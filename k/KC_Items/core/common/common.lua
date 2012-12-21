local locals = KC_ITEMS_LOCALS.modules.common

KC_Common = KC_ItemsModule:new({
	type		 = "common",
	name		 = locals.name,
	desc		 = locals.description,
})

KC_Items:Register(KC_Common)

function KC_Common:GetCode(link, long, short)
	local _, _, code = strfind(link or "", "(%d+:%d+:%d+:%d+)")
	code = code and gsub(code, "(%d+):(%d+):(%d+):(%d+)", "%1:%2:%3:0")
	if (code) then local nCode = gsub(code, "(%d+):(%d+):(%d+):(%d+)", "%1!%3"); self:AddCode(nCode) end
	return (code and (long and code or (short and gsub(code, "(%d+):(%d+):(%d+):(%d+)", "%1") or gsub(code, "(%d+):(%d+):(%d+):(%d+)", "%1!%3"))) or nil)
end

function KC_Common:GetCodes(id, list)
	if (list and type(list) ~= "string") then error("Bad String was a " .. type(string), 2)	end
	list = list and list or self:Explode(self.app.db:get(id), ",")
	if (list and type(list) ~= "string") then error(format("Bad Item Data for %s (%s)", self:GetItemInfo(id).name, id))	end
	local codes = {self:Explode(list, "!")}
	tremove(codes, 1)
	for i,v in codes do
		codes[i] = format("%s!%s", id, v)
	end

	return codes
end

function KC_Common:Split(string, sep)
	if (not string or type(string) ~= "string") then error("Bad String was a " .. type(string) .. "value: " .. (string or "nil"), 2)	end
	local x, y = (strfind(string , sep) or 0), (strlen(sep) or 1)
	return (tonumber(strsub(string, 1, x-1)) or strsub(string, 1, x-1)), (tonumber(strsub(string, x+y)) or strsub(string, x+y))
end

function KC_Common:Explode(string, sep)
	if (not string) then return	end
	if (type(string) ~= "string") then error("Bad String was a " .. type(string) .. "value: " .. (string or "nil"), 2)	end
	local a, b = self:Split(string, sep)
	if (not b or b == "") then return a; end
	if (not strfind(b, sep)) then return a, b; end
	return a, self:Explode(b, sep)
end

function KC_Common:CharCount(str, char)
	local count = 0 
	for i in string.gfind(str, char) do
		count = count + 1
	end
	return count
end

function KC_Common:GetHyperlink(code)
	if (not code) then error("Bad Code, Not A String!", 2) end
	if (strfind(code, "!")) then
		return format("item:%s:0:%s:0", self:Split(code, "!"))
	elseif (strfind(code, ":")) then
		return ("item:" .. code)
	else
		return format("item:%s:0:0:0", code)
	end
end

function KC_Common:GetTextLink(code)
	code = self:GetCode(code)
	local data = self:GetItemInfo(code)
	local _,_,_,hex = GetItemQualityColor(data["quality"])
	return format("%s|H%s|h[%s]|h|r", hex, self:GetHyperlink(code), data["name"])
end

function KC_Common:GetItemInfo(code)
	if (not code) then error("Bad Code, Not A String!", 2) end
	local name,	link, quality, minlevel, class,	subclass, maxstack, location, texture = GetItemInfo(type(code) == "number" and code or self:GetHyperlink(code))
	local sell, buy = self:GetItemPrices(code)
	local r, g, b, hex = GetItemQualityColor(quality or 0);
	return {name = name, hyperlink = link, quality = quality, minlevel = minlevel, class = class, subclass = subclass, maxstack = maxstack, location = getglobal(location), texture = texture, sell = sell, buy = buy, cname = name and hex..name or nil, squality = 9-(quality or 0), lcode = location}
end

function KC_Common:AddCode(link, sell, buy)
	if (not link or tonumber(link)) then return end
	sell = (sell and sell ~= 0) and sell or nil
	buy  = (buy and buy ~= 0) and buy or nil
	local code = strfind(link, ":") and self:GetCode(link) or  link
	local id, sub = self:Split(code, "!")
	local data = self.app.db:get(id)

	if (data) then
		local subs, sSell, sBuy = self:Explode(data, ",")
		if (not strfind(subs,"!" .. sub .."!")) then
			self.app.db:set(id, format("%s,%d,%d", subs .. sub .. "!", sell or sSell, buy or sBuy))
			self:UpdateStats(0, 1, sell and 1 or 0, buy and 1 or 0)
		elseif (sell or buy) then
			self.app.db:set(id, format("%s,%d,%d", subs, sell or sSell, buy or sBuy))			
			self:UpdateStats(0, 0, sell and ((sell == sSell) and 0 or 1), buy and ((buy == sBuy) and 0 or 1))
		end
	else
		self.app.db:set(id, format("!%d!,%d,%d", sub, sell or 0, buy or 0))
		self:UpdateStats(1, 1, sell and 1 or 0, buy and 1 or 0)
	end
end

function KC_Common:GetItemPrices(code)
	if (not code) then return end
	code = strfind(code, ":") and self:GetCode(code) or code
	local id, sub = type(code) == "number" and code or self:Split(code, "!")
	local data = self.app.db:get(id)

	if (data) then
		local subs, sell, buy = self:Explode(data, ",")
		if (sub and not strfind(subs,"!" .. sub .."!")) then self:AddCode(code) end
		return sell, buy
	else
		self:AddCode(code)
		return 0, 0
	end
end

KC_Common.SetItemPrices = KC_Common.AddCode

function KC_Common:GetRealmFactionID(neutrals)
	return format("%s|%s", ace.char.realm, strfind(neutrals or "", GetRealZoneText()) and "Neutral" or UnitFactionGroup("player"))
end

function KC_Common:CashTextLetters(cash)
	cash = floor(cash)
    local g,s,c = floor(cash/(100*100)),mod(floor(cash/100),100),mod(floor(cash),100)
    local str=""
    if(g>0) then
		str = format("%s%s%s", locals.money.gold.color, g, locals.money.gold.letter)
    end
    if(s>0) then
		if (str == "") then
			str = format("%s%s%s", locals.money.silver.color, s, locals.money.silver.letter)
		else
			str = format("%s %s%s%s", str, locals.money.silver.color, s, locals.money.silver.letter)
		end
    end
    if(c>0) then
		if (str == "") then
			str = format("%s%s%s", locals.money.copper.color, c, locals.money.copper.letter)
		else
			str = format("%s %s%s%s", str, locals.money.copper.color, c, locals.money.copper.letter)
		end
    end
    return str
end

function KC_Common:GetCodeFromInv(name, long)
	for bag = 0, 4 do
		for item = 1, GetContainerNumSlots(bag) do
			local id = self:GetCode(GetContainerItemLink(bag, item), long)
			if (id and self:GetItemInfo(id)["name"] == name) then
				return id;				
			end
		end
	end	
end

function KC_Common:StrMixed(string)
	string = strlower(string)
	return(strupper(strsub(string, 1,1)) .. strsub(string, 2))
end

function KC_Common:GetCharList(realm, faction)
	local result = {};
	local list = {"bank", "inventory", "equipment"}
	
	for i3,v3 in list do
		if (self.app[v3]) then
			local db = self.app[v3].db:get()
			for i, v in db do
				if (not faction or i == faction) then
					for i2, v2 in v do
						local cName, rID = self:Split(i2, locals.of)
						if (not realm or rID == realm) then
							result[i2] = {name = cName, realm = rID, faction = faction or i}
						end
					end
				end
			end
		end	
	end

   return result
end 

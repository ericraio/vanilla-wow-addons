local locals = KC_ITEMS_LOCALS.modules.chatlink

KC_ChatLink = KC_ItemsModule:new({
	type		 = "chatlink",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	optPath		 = {"chatlink", "options"}
})

KC_Items:Register(KC_ChatLink)

function KC_ChatLink:Enable()
	self:Hook("ChatEdit_OnTextChanged", "OnTextChanged")
end

function KC_ChatLink:OnTextChanged()
	local text = this:GetText();
	if (not(strfind(text, "^/script") or strfind(text, "^/dump"))) then
		this:SetText(self:ParseChatMessage(text))
	end
	self.Hooks["ChatEdit_OnTextChanged"].orig(this)
end

function KC_ChatLink:ParseChatMessage(text)
	if (self:GetOpt(self.optPath, "safe")) then
		return string.gsub(text, "($[|]?[h]?)%[(.-)%]([|]?[h]?)", self.LinkifyName)	
	else
		return string.gsub(text, "([|]?[h]?)%[(.-)%]([|]?[h]?)", self.LinkifyName)
	end
end 

function KC_ChatLink.LinkifyName(head, text, tail)
	if (head ~= "|h" and tail ~= "|h") then -- only linkify things text that isn't linked already
		local link = KC_ChatLink:GetLinkByName(text);
		if (link) then return link; end
	end
	return head.."["..text.."]"..tail;
end

function KC_ChatLink:GetLinkByName(text)
	local _, _, name, property = strfind(text, "(.-)(%((.-)%))?")

	name = (name and property) and string.gsub(name, " +$", "") or text
	
	local links = self:GetLinkTable(name)
	if (links and getn(links) > 0) then
		if (getn(links) > 1) then
			self:PrintList(links)
		end
		return self.common:GetTextLink(format("item:%s:0:0:0", links[1]))
	else 
		self:Msg("No Matching Links")
		return nil;
	end

end

function KC_ChatLink:GetLinkTable(name)
	matches={}
	name = strlower(name)
	for i=1,25000 do 
		local n = GetItemInfo(i) 
		if(n and string.find(strlower(n),name,nil,1)) then 
			table.insert(matches,i) 
		end
	end

	return matches
end

function KC_ChatLink:PrintList(list)
	local text = format("|cff00CC00LinkList(%s):|cff0099CC", getn(list))
	local sep = ""

	for i,k in pairs(list) do
		local name = GetItemInfo(k)
		text = format("%s%s %s ", text, sep, name)
		sep = ","
		if (i == 10) then
			text = text .. "..."
			break
		end
	end

	self:Msg(text)
end

---

function KC_ChatLink:mode()
	local status = self:TogOpt(self.optPath, "safe")
	self:Result(locals.msg.mode, status, locals.map)
end
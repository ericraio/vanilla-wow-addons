 OneStorage = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceDebug-2.0", "AceConsole-2.0")
 local L = AceLibrary("AceLocale-2.0"):new("OneView")
 
 function OneStorage:OnInitialize()
	self:RegisterEvent("OneView_Loaded")
 end
 
 function OneStorage:OneView_Loaded()
	if not self.db then
		self.db = OneView:AcquireDBNamespace("storage")
		OneView:RegisterDefaults("storage", 'account', { ['*'] = { ['*'] = { } } })
		local AceDB = AceLibrary("AceDB-2.0")
		self.faction = AceDB.FACTION
		self.charId = AceDB.CHAR_ID
	end

	self:RegisterEvent("BAG_UPDATE", 					function() self:SaveBag(arg1) end)
	self:RegisterEvent("BANKFRAME_OPENED", 				function() self.bankOpened = true  self:SaveBag(-1) for i=5,10 do self:SaveBag(i) end end)
	self:RegisterEvent("BANKFRAME_CLOSED", 				function() self.bankOpened = false end)
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED",	 	function() self:SaveBag(-1) end)
	self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED"	, 	function() self:SaveBag(-1) end)

	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "SaveEquipment")
	
	self:RegisterEvent("PLAYER_MONEY", "SaveMoney")
	self:SaveEquipment()
	self:SaveMoney()

	for bag = 0, 4 do
		self:SaveBag(bag)
	end
end
 
 function OneStorage:SaveMoney()
	  self.db.account[self.faction][self.charId]["money"] = GetMoney()
 end
 
 function OneStorage:SaveBag(bag)
   local size = GetContainerNumSlots(bag) or 0
   
   if (bag > 4 and bag <= 10) and not self.bankOpened then return end
   
   if bag > 0 then
	local link = GetInventoryItemLink("player", bag < 5 and bag + 19 or bag + 59)
	local _, _, code = strfind(link or "", "(item:%d+:%d+:%d+:%d+)")
	local info = code and (code .. "," .. size) or nil
	isAmmo, isSoul, isProf = self:GetBagTypes(bag)
	if info then
		info = format("%s,%s,%s,%s", info, tostring(isAmmo), tostring(isSoul), tostring(isProf))
	end
	self.db.account[self.faction][self.charId][bag .. 0] = info
   elseif(bag == 0) then
	  self.db.account[self.faction][self.charId][bag .. 0] = "nil,16,false,false,false"
   elseif(bag == -1) then
	  self.db.account[self.faction][self.charId][bag .. 0] = "nil,24,false,false,false"
   end
   
   for slot = 1, size do
	  local link = GetContainerItemLink(bag, slot)
	  local _, qty = GetContainerItemInfo(bag, slot)
	  local _, _, code = strfind(link or "", "(item:%d+:%d+:%d+:%d+)")
	  local info = code and (code .. "," .. qty) or nil
	  self.db.account[self.faction][self.charId][bag .. slot] = info
	end
end

function OneStorage:SaveEquipment()
   for slot = 0, 19 do
		local link = GetInventoryItemLink("player",slot)
		if (link) then 
			local _, _, code = strfind(link or "", "(item:%d+:%d+:%d+:%d+)")
			self.db.account[self.faction][self.charId]["e" .. slot] = code
		else
			self.db.account[self.faction][self.charId]["e" .. slot] = code
		end
	end
	self.db.account[self.faction][self.charId]["relic"] = UnitHasRelicSlot("player")
end

function OneStorage:Trim(msg)
	if not msg then return end
	local results = string.gsub(msg, "^%s+", "")
	return string.gsub(results, "%s+$", "")
end

function OneStorage:Split(string, sep)
	if (not string or type(string) ~= "string") then error("Bad String was a " .. type(string) .. "value: " .. (string or "nil"), 2)	end
	local x, y = (strfind(string , sep) or 0), (strlen(sep) or 1)
	return (tonumber(strsub(string, 1, x-1)) or strsub(string, 1, x-1)), (tonumber(strsub(string, x+y)) or strsub(string, x+y))
end

function OneStorage:Explode(string, sep)
	if (not string) then return	end
	if (type(string) ~= "string") then error("Bad String was a " .. type(string) .. "value: " .. (string or "nil"), 2)	end
	local a, b = self:Split(string, sep)
	if (not b or b == "") then return a; end
	if (not strfind(b, sep)) then return a, b; end
	return a, self:Explode(b, sep)
end

function OneStorage:SlotInfo(faction, charId, bag, slot)
	local info = self.db.account[faction or self.faction][charId or self.charId][bag .. slot]
	if info then
		return self:Split(info, ",")
	end
end

function OneStorage:BagInfo(faction, charId, bag)
	local info = self.db.account[faction or self.faction][charId or self.charId][bag .. 0]
	if info then
		local itemId, size, isAmmo, isSoul, isProf = self:Explode(info, ",")
		return itemId, size, (isAmmo == "true"), (isSoul == "true"), (isProf == "true")
	end
end

function OneStorage:HasRelic(faction, charId)
	return self.db.account[faction or self.faction][charId or self.charId]["relic"]
end

function OneStorage:EquipmentInfo(faction, charId, slot)
	return self.db.account[faction or self.faction][charId or self.charId]["e" .. slot]
end

function OneStorage:GetMoney(faction, charId)
  return self.db.account[faction or self.faction][charId or self.charId]["money"]
end

function OneStorage:GetBagTypes(bag)
	if( bag <= 0 ) then return end
	
	local _, _, id = strfind(GetInventoryItemLink("player", ContainerIDToInventoryID(bag)) or "", "item:(%d+)");
	if id then 
		local _, _, _, _, itemType, subType = GetItemInfo(id);
		return (itemType == L"Quiver" or false), (subType == L"Soul Bag" or false), (( itemType == L"Container" and not (subType == L"Bag" or subType == L"Soul Bag")  ) or false)
	end
end

function OneStorage:GetCharListByServerId()
		local list = {}
		for k, v in OneStorage.db.account do
			for k2, v2 in v do
				local _, _, name, server = string.find(k2, "(.+) of (.+)")
				serverId = format("%s - %s",  server, k)
				
				if not list[serverId] then list[serverId] = {} end
				table.insert(list[serverId], string.format("%s - %s", name, k2) )
				sort(list[serverId])
			end
		end
		return list
end
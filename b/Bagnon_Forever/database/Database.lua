--[[
	Bagnon Database
		Functions for storing and accessing player inventory data
		This is intended to be completely seperate from Bagnon_Forever
		
	BagnonDB has this format, which was adapted from KC_Items
		Realm
			Character
				BagID = size,count,[link]
					ItemSlot = link,[count]
				Money
--]]

--local globals
local currentPlayer = UnitName("player"); --the name of the current player that's logged on
local currentRealm = GetRealmName(); --what currentRealm we're on
local atBank; --is the current player at the bank or not

function BagnonDB_OnEvent()
	if(event == "BAG_UPDATE") then
		BagnonDB_SaveBagData(arg1);
	elseif(event == "PLAYERBANKSLOTS_CHANGED") then
		BagnonDB_SaveBagData(-1);
	elseif(event == "BANKFRAME_CLOSED") then
		atBank = nil;
		BagnonDB_SaveBankData();
	elseif(event == "BANKFRAME_OPENED") then
		atBank = 1;
		BagnonDB_SaveBankData();
	elseif(event == "PLAYER_MONEY") then
		BagnonDB_SavePlayerMoney();
	elseif(event == "PLAYER_LOGIN") then
		BagnonDB_LoadVariables();
		BagnonDB_SavePlayerMoney();
	end
end

function BagnonDB_LoadVariables()
	--[[
		BagnonDB settings are set to default under the following conditions
			No saved variables (duh)
			Versions that did not know about the wowVersion
			Right after any WoW Patch
	--]]
	if(not (BagnonDB and BagnonDB.wowVersion and BagnonDB.wowVersion == GetBuildInfo()) ) then
		BagnonDB = {
			version = BAGNON_FOREVER_VERSION,
			wowVersion = GetBuildInfo();
		};
	end
	
	if(not BagnonDB[currentRealm]) then
		BagnonDB[currentRealm] = {};
	end
	
	if(not BagnonDB[currentRealm][UnitName("player")]) then
		BagnonDB[currentRealm][UnitName("player")] = {};
	end
	
	if(BagnonDB.version ~= BAGNON_FOREVER_VERSION) then
		BagnonDB_UpdateVersion();
	end
end

function BagnonDB_UpdateVersion()
	BagnonDB.version = BAGNON_FOREVER_VERSION;
	
	DEFAULT_CHAT_FRAME:AddMessage(BAGNON_FOREVER_UPDATED, 1, 1, 0);
end

--[[  Storage Functions ]]--

--save all inventory data about the current player
function BagnonDB_SaveAllData()
	local i;
	--you know, this should probably be a constant
	for i = -2, 10, 1 do
		BagnonDB_SaveBagData(i);
	end
	BagnonDB_SavePlayerMoney();
end

--save all bank data about the current player
function BagnonDB_SaveBankData()
	BagnonDB_SaveBagData(-1);
	local bagID;
	for bagID = 5, 10, 1 do
		BagnonDB_SaveBagData(bagID);
	end
end

--saves all the data about the current player's bag
function BagnonDB_SaveBagData(bagID)
	--don't save bank data unless you're at the bank
	if( Bagnon_IsBankBag(bagID) and not atBank ) then
		return;
	end
	
	local size;
	if(bagID == KEYRING_CONTAINER) then
		size = GetKeyRingSize();
	else
		size = GetContainerNumSlots(bagID);
	end
	
	if(size > 0) then
		local link, count;
		
		if(bagID > 0) then
			link = BagnonDB_ToShortLink( GetInventoryItemLink("player", ContainerIDToInventoryID(bagID) ) );
		end
		
		count = GetInventoryItemCount("player", ContainerIDToInventoryID(bagID));
		
		--save bag size
		BagnonDB[currentRealm][currentPlayer][bagID] = {};
		BagnonDB[currentRealm][currentPlayer][bagID].s = size .. "," .. count .. ",";
		
		if(link) then
			BagnonDB[currentRealm][currentPlayer][bagID].s = BagnonDB[currentRealm][currentPlayer][bagID].s .. link;
		end

		--save all item info
		for index = 1, size, 1 do
			BagnonDB_SaveItemData(bagID, index);
		end
	else
		BagnonDB[currentRealm][currentPlayer][bagID] = nil;
	end
end

function BagnonDB_SaveItemData(bagID, itemSlot)
	local texture, count = GetContainerItemInfo(bagID, itemSlot);
	local data;
	
	if(texture) then
		data = BagnonDB_ToShortLink( GetContainerItemLink(bagID, itemSlot) ) .. ",";
		if(count > 1) then
			data = data .. count;
		end
	end
	
	BagnonDB[currentRealm][currentPlayer][bagID][itemSlot] = data;
end

function BagnonDB_SavePlayerMoney()
	BagnonDB[currentRealm][currentPlayer].g = GetMoney();
end

--[[ Access  Functions ]]--

--returns <player>'s current money
function BagnonDB_GetMoney(player)
	return BagnonDB[currentRealm][player].g;
end

--[[ 
	returns the size, link, and count of the current bag
		size is how many items the bag can hold
		link is the item link of the bag, if available
		count is how many items are in the bag, this is used by ammo and soul shard bags
--]]
function BagnonDB_GetBagData(player, bagID)
	local data = BagnonDB[currentRealm][player][bagID];
	if(data) then
		local _, _, size, count, link = string.find(data.s, "([%w_:]+),([%w_:]+),([%w_:]*)");
		
		if(link and link ~="") then
			return size, "item:" .. link, tonumber(count);
		elseif(size) then
			return size, nil, tonumber(count);
		end
	end
	return 0;
end

--returns the item link, (in the form of item:www:xxx:yyy:zzz),  texture (full path) , and count of the item in the given slot
function BagnonDB_GetItemDataFromSlot(player, bagID, slot)
	if( not( BagnonDB[currentRealm] and BagnonDB[currentRealm][player] and BagnonDB[currentRealm][player][bagID] )) then
		return nil;
	end
	
	local itemData = BagnonDB[currentRealm][player][bagID][slot];
	
	if(itemData) then
		local _, _, shortLink, count = string.find(itemData, "([%w_:]+),([%w_:]*)");
		
		shortLink = "item:" .. shortLink;
		
		if(count == "") then
			count = 1;
		else
			count = tonumber(count);
		end
		
		local _, _, _, _, _, _, _, _, texture = GetItemInfo(shortLink);
		
		return shortLink, texture, count;
	end
	
	return nil;
end

--returns the item link, (in the form of item:www:xxx:yyy:zzz),  texture (full path) , and count of the given item
function BagnonDB_GetItemData(item)
	local itemData = BagnonDB[currentRealm][item:GetParent():GetParent().player][item:GetParent():GetID()][item:GetID()];
	
	if(itemData) then
		local _, _, shortLink, count = string.find(itemData, "([%w_:]+),([%w_:]*)");
		
		if(shortLink ~= "") then
			shortLink = "item:" .. shortLink;
		else
			shortLink = nil;
		end
		
		if(count == "") then
			count = 1;
		else
			count = tonumber(count);
		end
		
		local _, _, _, _, _, _, _, _, texture = GetItemInfo(shortLink);
		
		return shortLink, texture, count;
	end
	
	return nil;
end

--return the full hyperlink of an item.  This is for linking in chat
function BagnonDB_GetFullItemLink(item)
	local link = ( BagnonDB_GetItemData(item) );
	
	if(link) then
		local name, ilink, quality = GetItemInfo( link );
		local r,g,b,hex = GetItemQualityColor( quality );
	
		return hex .. "|H".. link .. "|h[" .. name .. "]|h|r";
	end
end

--[[ Removal Functions ]]--

--removes all saved data about the given player
function BagnonDB_RemovePlayer(player, realm)
	if(BagnonDB[realm]) then
		BagnonDB[realm][player] = nil;
	end
end

--[[ Conversion Functions  ]]--

--takes a full item hyperlink and returns the www:xxx:yyy:zzz form
function BagnonDB_ToShortLink(fullLink)
	if(fullLink) then
		local _, _, w, x, y, z = string.find(fullLink, "(%d+):(%d+):(%d+):(%d+)") ;
		return w .. ":" .. x .. ":" .. y .. ":" .. z;
	end
	return nil;
end

--takes an item link and returns its ID
function BagnonDB_ToID(link)
	if(link) then
		local _, _, id = string.find(link, "item:(%d+)");
		return id;
	end
end

--[[ Create the Database Event Handler ]]--

CreateFrame("Frame", "Bagnon_DB");
Bagnon_DB:Hide();

Bagnon_DB:RegisterEvent("BAG_UPDATE");
Bagnon_DB:RegisterEvent("PLAYER_LOGIN");
Bagnon_DB:RegisterEvent("BANKFRAME_CLOSED");
Bagnon_DB:RegisterEvent("BANKFRAME_OPENED");
Bagnon_DB:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
Bagnon_DB:RegisterEvent("PLAYER_MONEY");

Bagnon_DB:SetScript("OnEvent", BagnonDB_OnEvent);
--[[
	BagnonForever.lua
		Records inventory data about the current player
		
	BagnonForeverData has the following format, which was adapted from KC_Items
	BagnonForeverData = {
		Realm
			Character
				BagID = size,count,[link]
					ItemSlot = link,[count]
				Money = money
	}
--]]

--local globals
local currentPlayer = UnitName("player"); --the name of the current player that's logged on
local currentRealm = GetRealmName(); --what currentRealm we're on
local atBank; --is the current player at the bank or not

--[[ Utility Functions ]]--

--takes a hyperlink (what you see in chat) and converts it to a shortened item link.
--a shortened item link is either the item:w:x:y:z form without the 'item:' part, or just the item's ID (the 'w' part)
function BagnonForever_HyperlinkToShortLink(hyperLink)
	if(hyperLink) then
		local _, _, w, x, y, z = string.find(hyperLink, "item:(%d+):(%d+):(%d+):(%d+)");
		if(tonumber(x) == 0 and tonumber(y) == 0 and tonumber(z) == 0) then
			return w;
		else
			return w .. ":" .. x .. ":" .. y .. ":" .. z;
		end
	end
end

--[[  Storage Functions ]]--

--saves data about a specific item the current player has
local function SaveItemData(bagID, itemSlot)
	local texture, count = GetContainerItemInfo(bagID, itemSlot);
	local data;
	
	if(texture) then
		data = BagnonForever_HyperlinkToShortLink( GetContainerItemLink(bagID, itemSlot) );
		if(count > 1) then
			data = data .. "," .. count;
		end
	end
	
	BagnonForeverData[currentRealm][currentPlayer][bagID][itemSlot] = data;
end

--saves all the data about the current player's bag
local function SaveBagData(bagID)
	--don't save bank data unless you're at the bank
	if Bagnon_IsBankBag(bagID) and not atBank then
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
		
		if bagID > 0 then
			link = BagnonForever_HyperlinkToShortLink( GetInventoryItemLink("player", ContainerIDToInventoryID(bagID) ) );
		end
		
		count = GetInventoryItemCount("player", ContainerIDToInventoryID(bagID));
		
		--save bag size
		BagnonForeverData[currentRealm][currentPlayer][bagID] = {};
		BagnonForeverData[currentRealm][currentPlayer][bagID].s = size .. "," .. count .. ",";
		
		if link then
			BagnonForeverData[currentRealm][currentPlayer][bagID].s = BagnonForeverData[currentRealm][currentPlayer][bagID].s .. link;
		end

		--save all item info
		for index = 1, size, 1 do
			SaveItemData(bagID, index);
		end
	else
		BagnonForeverData[currentRealm][currentPlayer][bagID] = nil;
	end
end

local function SavePlayerMoney()
	BagnonForeverData[currentRealm][currentPlayer].g = GetMoney();
end

--save all bank data about the current player
local function SaveBankData()
	SaveBagData(-1);
	local bagID;
	for bagID = 5, 10, 1 do
		SaveBagData(bagID);
	end
end

--save all inventory data about the current player
local function SaveAllData()
	local i;
	--you know, this should probably be a constant
	for i = -2, 10, 1 do
		SaveBagData(i);
	end
	SavePlayerMoney();
end

--[[ Removal Functions ]]--

--removes all saved data about the given player
function BagnonForever_RemovePlayer(player, realm)
	if(BagnonForeverData[realm]) then
		BagnonForeverData[realm][player] = nil;
	end
end

--[[ Startup Functions ]]--

local function UpdateVersion()
	BagnonForeverData.version = BAGNON_FOREVER_VERSION;
	
	BagnonMsg(BAGNON_FOREVER_UPDATED);
end

--[[
	BagnonForever's settings are set to default under the following conditions
		No saved variables (duh)
		Versions that did not know about the wowVersion (should only be on new installs)
		Right after any WoW Patch
		
	I think that the itemcache is rebuilt whenever there's an update to the game, so saved data becomes corrupt.
--]]
local function LoadVariables()	
	if(not (BagnonForeverData and BagnonForeverData.wowVersion and BagnonForeverData.wowVersion == GetBuildInfo()) ) then
		BagnonForeverData = {
			version = BAGNON_FOREVER_VERSION,
			wowVersion = GetBuildInfo();
		};
	end
	
	--this handles upgrading from 6.7.19 or earlier
	if(BagnonDB and not (BagnonDB.GetPlayers or BagnonDB.GetPlayerList)) then
		message("BagnonForever:  Updating from an old version.  Saved data will be available on your next login.");
		BagnonDB = nil;
	end
	
	if(not BagnonForeverData[currentRealm]) then
		BagnonForeverData[currentRealm] = {};
	end
	
	if(not BagnonForeverData[currentRealm][UnitName("player")]) then
		BagnonForeverData[currentRealm][UnitName("player")] = {};
		SaveAllData();
	end
	
	if(BagnonForeverData.version ~= BAGNON_FOREVER_VERSION) then
		UpdateVersion();
	end
end

--Event handler creation
CreateFrame("Frame", "BagnonForever");

BagnonForever:RegisterEvent("BAG_UPDATE");
BagnonForever:RegisterEvent("PLAYER_LOGIN");
BagnonForever:RegisterEvent("BANKFRAME_CLOSED");
BagnonForever:RegisterEvent("BANKFRAME_OPENED");
BagnonForever:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
BagnonForever:RegisterEvent("PLAYER_MONEY");

BagnonForever:SetScript("OnEvent", function()
	if(event == "BAG_UPDATE") then
		SaveBagData(arg1);
	elseif(event == "PLAYERBANKSLOTS_CHANGED") then
		SaveBagData(-1);
	elseif(event == "BANKFRAME_CLOSED") then
		atBank = nil;
		SaveBankData();
	elseif(event == "BANKFRAME_OPENED") then
		atBank = 1;
		SaveBankData();
	elseif(event == "PLAYER_MONEY") then
		SavePlayerMoney();
	elseif(event == "PLAYER_LOGIN") then
		LoadVariables();
		SavePlayerMoney();
	end
end);
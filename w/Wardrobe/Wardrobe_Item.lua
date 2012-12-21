--============================================================================================--
--============================================================================================--
--																							--
--							  ITEM, BAG, TOOLTIP FUNCTIONS								  --
--																							--
--============================================================================================--
--============================================================================================--

--GetContainerItemLink item name strfind syntax
local WARDROBE_ITEM_NAME_FROM_LINK = "|h%[(.-)%]|h";
local WARDROBE_ITEM_UNIQUE_IDS_FROM_LINK = "|Hitem:(.-):(.-):(.-):(.-)|h%[(.-)%]|h"
--/script local itemNum=GetMouseFocus():GetID(); Sea.io.printComma(string.gfind(GetInventoryItemLink("player", itemNum), WARDROBE_ITEM_UNIQUE_IDS_FROM_LINK)())

local CraftableItemIDs = {
-- These item id's will ignore suffix
	[1254]	= true;		--Lesser Firestone
	[13699]	= true;		--Firestone
	[13700]	= true;		--Greater Firestone
	[13701]	= true;		--Major Firestone
	
	[5522]	= true;		--Spellstone
	[13602]	= true;		--Greater Spellstone
	[13603]	= true;		--Major Spellstone
};

---------------------------------------------------------------------------------
-- Return the name of the item in the specified player's inventory slot number 
-- (1 = "headslot" etc - see Wardrobe.InventorySlots above for a full list of the slots)
---------------------------------------------------------------------------------
function Wardrobe.GetItemNameAtInventorySlotNumber(slotNum)

	local itemName, _ = "";
	-- get the id number for the item slot
	local id = GetInventorySlotInfo(Wardrobe.InventorySlots[slotNum]);
	local linktext = GetInventoryItemLink("player", id);
	if (linktext) then
		_,_,itemName = strfind(linktext, WARDROBE_ITEM_NAME_FROM_LINK);
	end
	return itemName;
end

function Wardrobe.GetItemInfoAtInventorySlotNumber(slotNum)

	local itemID, permEnchant, tempEnchant, suffix, itemName;
	-- get the id number for the item slot
	local linktext = GetInventoryItemLink("player", GetInventorySlotInfo(Wardrobe.InventorySlots[slotNum]));
	if (linktext) then
		itemID, permEnchant, tempEnchant, suffix, itemName = string.gfind(linktext, WARDROBE_ITEM_UNIQUE_IDS_FROM_LINK)();
	end
	return itemID, permEnchant, tempEnchant, suffix, itemName;
end


---------------------------------------------------------------------------------
-- Find the named item on the character's inventory (head slot, hand slot, etc -- not bags)
---------------------------------------------------------------------------------
function Wardrobe.FindInventoryItem(targetItemID, targetSuffix, targetPermEnchant, targetItemName)

	local itemSlot, itemID, permEnchant, tempEnchant, suffix, invItemName;
	for i = 1, table.getn(Wardrobe.InventorySlots) do
		itemID, permEnchant, tempEnchant, suffix, invItemName = Wardrobe.GetItemInfoAtInventorySlotNumber(i);
		
		if (itemID) then
			if (targetItemID) and (targetSuffix) and (targetPermEnchant) then
				-- If target item ID and suffix are passed try to match them.
				if (targetItemID == itemID) and (targetSuffix == suffix) then
					if (targetPermEnchant == permEnchant) then
						itemSlot = i;
						break;
					else
						-- Perm enchant doesn't match, ignore
					end
				end
			elseif (targetItemName == invItemName) then
				-- If only name is passed match loosely.
				itemSlot = i;
				break;
			end
		end
	end
	
	return itemSlot;
end


---------------------------------------------------------------------------------
-- Return the name of the item in the specified bag and slot
---------------------------------------------------------------------------------
function Wardrobe.GetItemNameInBagSlot(bagNum, slotNum)
	
	local itemName, _ = "";
	local linktext = GetContainerItemLink(bagNum, slotNum)
	if (linktext) then
		_,_,itemName = strfind(linktext, WARDROBE_ITEM_NAME_FROM_LINK);
	end
	
	return itemName;
end

function Wardrobe.GetItemInfoInBagSlot(bagNum, slotNum)

	local itemID, permEnchant, tempEnchant, suffix, itemName;
	local linktext = GetContainerItemLink(bagNum, slotNum);
	if (linktext) then
		itemID, permEnchant, tempEnchant, suffix, itemName = string.gfind(linktext, WARDROBE_ITEM_UNIQUE_IDS_FROM_LINK)();
	end
	return itemID, permEnchant, tempEnchant, suffix, itemName;
end

---------------------------------------------------------------------------------
-- Given the name of an item, find the bag and slot the item is in
---------------------------------------------------------------------------------
function Wardrobe.FindContainerItem(targetItemID, targetSuffix, targetPermEnchant, targetItemName)
	local foundBag, foundSlot, wrongEnchant;
	--Wardrobe.Debug("	Looking in inventory for ["..targetItemName.."]");	
	
	-- for each bag and slot
	if ( Wardrobe.InventorySearchForward == 1 ) then
		bagcounterA = 0
		bagcounterB = NUM_CONTAINER_FRAMES
	else
		bagcounterB = 0
		bagcounterA = NUM_CONTAINER_FRAMES
	end
	
	local backupItems = {};
	local itemID, permEnchant, tempEnchant, suffix, bagItemName;
	
	for bag = bagcounterA, bagcounterB, Wardrobe.InventorySearchForward do
		local frame = getglobal("ContainerFrame"..bag);
		local counterA = 1
		local counterB = 1
	
		if ( Wardrobe.InventorySearchForward == 1 ) then
			counterA = 1
			counterB = GetContainerNumSlots(bag)
		else
			counterB = 1
			counterA = GetContainerNumSlots(bag)
		end
		
		for slot = counterA, counterB, Wardrobe.InventorySearchForward do
			itemID, permEnchant, tempEnchant, suffix, bagItemName = Wardrobe.GetItemInfoInBagSlot(bag, slot);
			Wardrobe.Debug("		 Comparing with "..tostring(bagItemName).." Bag:"..bag.." Slot:"..slot);
			if (itemID) then
				if (targetItemID) and (targetItemID == itemID) and CraftableItemIDs[targetItemID] then
					Wardrobe.Debug("		   FOUND [by craftable ID] in bag = "..bag.." slot = "..slot);
					foundBag  = bag;
					foundSlot = slot;
					break;
				elseif (targetItemID) and (targetSuffix) and (targetPermEnchant) then
					-- If target item ID and suffix are passed try to match them.
					if (targetItemID == itemID) and (targetSuffix == suffix) then
						if (targetPermEnchant == permEnchant) then
							Wardrobe.Debug("		   FOUND [by full ID] in bag = "..bag.." slot = "..slot);
							foundBag  = bag;
							foundSlot = slot;
							break;
						else
							-- Perm enchant doesn't match, add to backup list for 2nd pass
							-- Currently Ignored for absolute match...
							--table.insert(backupItems, {bag=bag,slot=slot});
						end
					end
				elseif (targetItemName == bagItemName) then
					-- If only name is passed match loosely.
					Wardrobe.Debug("		   FOUND [by name] in bag = "..bag.." slot = "..slot);
					foundBag  = bag;
					foundSlot = slot;
					break;
				end
			end
		end
		if (foundBag and foundSlot) then
			break;
		end
	end
	
	if (not foundBag and not foundSlot) then
		for index, info in backupItems do
			-- Print out all found backups. Use the last one found.
			foundBag  = info.bag;
			foundSlot = info.slot;
			wrongEnchant = true;
			Wardrobe.Debug("		   FOUND [by partial ID] in bag = "..foundBag.." slot = "..foundSlot);
		end
	end

	if ( Wardrobe.InventorySearchForward == 1 ) then
		Wardrobe.InventorySearchForward = -1
	else
		Wardrobe.InventorySearchForward = 1
	end
	
	return foundBag, foundSlot, wrongEnchant;
end


---------------------------------------------------------------------------------
-- Build a list of items in our bags and on our person
---------------------------------------------------------------------------------
function Wardrobe.BuildItemList()

	tempList = {};
	
	-- for each bag and slot
	local itemID, permEnchant, tempEnchant, suffix, itemName
	for bag = 0, NUM_CONTAINER_FRAMES, 1 do
		local frame = getglobal("ContainerFrame"..bag);
		for slot = 1, GetContainerNumSlots(bag) do
		
			-- get the name of the item in this bag/slot
			--itemName = Wardrobe.GetItemNameInBagSlot(bag, slot);
			itemID, permEnchant, tempEnchant, suffix, itemName = Wardrobe.GetItemInfoInBagSlot(bag, slot);
			if (itemName) and (itemName ~= "") then
				table.insert(tempList, {Name = itemName, ItemID = itemID, PermEnchant = permEnchant, TempEnchant = tempEnchant, Suffix = suffix});
			end
		end
	end

	-- for each inventory item
	for i = 1, table.getn(Wardrobe.InventorySlots) do   
		--itemName = Wardrobe.GetItemNameAtInventorySlotNumber(i);
		itemID, permEnchant, tempEnchant, suffix, itemName = Wardrobe.GetItemInfoAtInventorySlotNumber(i);
		if (itemName) and (itemName ~= "") then
			table.insert(tempList, {Name = itemName, ItemID = itemID, PermEnchant = permEnchant, TempEnchant = tempEnchant, Suffix = suffix});		  
		end
	end

	
	return tempList;	
end



---------------------------------------------------------------------------------
-- Equip the specified item into the specified slot on our character (hands, chest, etc)
---------------------------------------------------------------------------------
function Wardrobe.Equip(itemName, equipSlot, itemID, suffix, permEnchant)

	-- if we're already holding something, bail
	if (CursorHasItem()) then
		return false;
	end
	
	-- find the bag and slot of this item
	local bag, slot, wrongEnchant = Wardrobe.FindContainerItem(itemID, suffix, permEnchant, itemName);
	if (bag and slot) then
		PickupContainerItem(bag, slot);
		if (equipSlot) and (equipSlot >= 11) and (equipSlot <= 17) and (equipSlot ~= 15) then
			--Fingers, Trinkets, Weapons
			--PickupInventoryItem(equipSlot);
			EquipCursorItem(equipSlot);
		else
			AutoEquipCursorItem();
		end
		return true;
	elseif (equipSlot) and (equipSlot >= 11) and (equipSlot <= 17) and (equipSlot ~= 15) then
		-- Fingers, Trinkets, Weapons
		-- Find the inventory slot of this item
		local invSlot = Wardrobe.FindInventoryItem(itemID, suffix, permEnchant, itemName);
		if (invSlot) then
			--convert to inventory id
			invSlot = GetInventorySlotInfo(Wardrobe.InventorySlots[invSlot]);
			
			if (invSlot ~= equipSlot) then
				PickupInventoryItem(invSlot);
				EquipCursorItem(equipSlot);
				return true;
			end
		end
	end
	return false;
end


---------------------------------------------------------------------------------
-- Check to see if the specified outfit name is already being used
---------------------------------------------------------------------------------
function Wardrobe.FoundOutfitName(outfitName)
	
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
		if (outfit.OutfitName == outfitName) then
			return true;
		end
	end
	
	return false;
end


---------------------------------------------------------------------------------
-- Return the index of the specified outfitName
---------------------------------------------------------------------------------
function Wardrobe.GetOutfitNum(outfitName)
	
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
		if (outfit.OutfitName == outfitName) then
			return i;
		end
	end
end



---------------------------------------------------------------------------------
-- See if this bag / slot is being used or is free
---------------------------------------------------------------------------------
function Wardrobe.UsedThisSlot(freeBagSpacesUsed, theBag, theSlot)
	for i = 1, table.getn(freeBagSpacesUsed) do
		if (freeBagSpacesUsed[i][1] == theBag and freeBagSpacesUsed[i][2] == theSlot) then
			return true;
		end
	end
	return false;
end


---------------------------------------------------------------------------------
-- Put an item into a free bag slot
---------------------------------------------------------------------------------
function BagItem(freeBagSpacesUsed, backwards)
	if (not freeBagSpacesUsed) then
		freeBagSpacesUsed = {};
	end
	local firstBag, lastBag, inc;
	if (backwards) then
		firstBag = 4
		lastBag = 1;
		inc = -1;
	else
		firstBag = 0
		lastBag = 4;
		inc = 1;
	end
	-- for each bag and slot
	for theBag = firstBag, lastBag, inc do
		local numSlot = GetContainerNumSlots(theBag);
		for theSlot = 1, numSlot do
		
			-- get info about the item here
			local texture, itemCount, locked = GetContainerItemInfo(theBag, theSlot);
			
			-- if we found nothing, add us to the list of free bag slots
			if (not texture and not Wardrobe.UsedThisSlot(freeBagSpacesUsed, theBag, theSlot)) then
				PickupContainerItem(theBag,theSlot);
				table.insert(freeBagSpacesUsed, {theBag, theSlot});
				return true, freeBagSpacesUsed;
			end
		end
	end
	
	AutoEquipCursorItem();
	
	return false, freeBagSpacesUsed;
end

---------------------------------------------------------------------------------
-- Move an item in your bags to the back most free bag slot
---------------------------------------------------------------------------------
function ReBagContainerItem(invItemName)
	local foundBag, foundSlot, wrongEnchant = Wardrobe.FindContainerItem(nil, nil, nil, invItemName);
	PickupContainerItem(foundBag, foundSlot);
	BagItem(nil,true);
end

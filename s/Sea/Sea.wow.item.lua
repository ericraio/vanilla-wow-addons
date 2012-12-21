--[[
--
--	Sea.wow.item
--
--	Item related wow functions
--
--	$LastChangedBy: Sinaloit $
--	$Rev: 2025 $
--	$Date: 2005-07-02 18:51:34 -0500 (Sat, 02 Jul 2005) $
--]]

Sea.wow.item = {

	--
	-- getInventoryItemName( bag, slot )
	--
	-- 	Gets the name of the item in the specified bag/slot
	--
	-- Args:
	-- 	(int bag, int slot)
	-- 	bag - 0 through 8, the bag number
	-- 	slot - index within the bag
	-- 	
	-- Returns:
	-- 	(string name)
	-- 	name - the item's name
	-- 	
	getInventoryItemName = function (bag, slot)
		local name = "";
		local strings = nil;
		strings = Sea.wow.item.getInventoryItemInfoStrings(bag, slot, "GameTooltip");
		-- Determine if the item is an ore, gem or herb
		if ( strings[1] ) then
			name = strings[1].left;
		end
		return name;
	end;
	
	--
	-- classifyInventoryItem(bag, slot, TooltipNameBase)
	--
	-- 	Returns a great deal of useful information about an item.
	--
	-- Return:
	-- 	Table[
	-- 		.classification
	-- 		.name
	-- 		.quality
	-- 		.count
	-- 		.minLevel
	-- 		.unique
	-- 		.soulbound
	-- 		.bindOnPickup
	-- 		.bindOnEquip
	-- 		.quest
	-- 		] itemInfo;
	--
	--

	classifyInventoryItem = function (bag, slot, TooltipNameBase)
		if ( TooltipNameBase == nil ) then 
			TooltipNameBase = "GameTooltip";
		end
	
		local strings = Sea.wow.item.getInventoryItemInfoStrings(bag, slot, TooltipNameBase);
	
		local texture, itemCount, locked, quality = GetContainerItemInfo(bag,slot);

		return Sea.wow.item.classifyItemStrings(strings, itemCount, quality);
	end;
	
	
	--
	-- classifyItemStrings(strings, itemCount, quality)
	--
	--  Args:
	--
	--   strings - array of strings that mimic the tooltip of the item to classify
	--   itemCount - optional number that indicates the number of items
	--   quality - optional number that indicates the quality of the item
	--
	-- 	Returns a great deal of useful information about an item. 
	--  The tooltip strings must be gathered from the item, using the 
	--   getInventoryItemInfoStrings syntax.
	--
	--
	-- Return:
	-- 	Table[
	-- 		.classification
	-- 		.name
	-- 		.quality
	-- 		.count
	-- 		.minLevel
	-- 		.unique
	-- 		.soulbound
	-- 		.bindOnPickup
	-- 		.bindOnEquip
	-- 		.quest
	-- 		] itemInfo;
	--
	--
	classifyItemStrings = function (strings, itemCount, quality)
		if ( not itemCount ) then
			itemCount = 1;
		end
		local classification = "Misc";
		local leftString, rightString, minLevel;
		local unique = false;
		local soulbound = false;
		local bindsOnPickup = false;
		local bindsOnEquip = false;
		local questItem = false;
		local isHerb = false;
		local isGem = false;
		local isOre = false;
		local isLeather = false;
		local isTailor = false;
		local isFishing = false;
		local isFood = false;
		local isDrink = false;
		local isShaman = false;
		local isPoison = false;
		local isWarlock = false;
		local isJunk = false;
		local engineering = false;
		local firstaid = false;
		local classitem = false;
		local class = "";
		local name = "";
		-- Look for the target line that identifies an item; it'll either be line 2, 3, or 4.

		-- Determine if the item is an ore, gem or herb
		if ( strings[1] ) then
			name = strings[1].left;
		end
	
		isHerb = Sea.list.isWordInList(Sea.data.item.herb, name);
		isGem  = Sea.list.isWordInList(Sea.data.item.gem, name);
		isOre  = Sea.list.isWordInList(Sea.data.item.ore, name);
		isLeather = Sea.list.isWordInList(Sea.data.item.leather, name);
		isFishing = Sea.list.isWordInList(Sea.data.item.fishing, name);
		isTailor = Sea.list.isWordInList(Sea.data.item.cloth, name);
		isPotion = Sea.list.isWordInList(Sea.data.item.potion, name);
		isMage = Sea.list.isWordInList(Sea.data.item.mage, name);
		isFood = Sea.list.isWordInList(Sea.data.item.food, name);
		isDrink = Sea.list.isWordInList(Sea.data.item.drink, name);
		isShaman = Sea.list.isWordInList(Sea.data.item.shaman, name);
		isPoison = Sea.list.isWordInList(Sea.data.item.poison, name);
		isWarlock = Sea.list.isWordInList(Sea.data.item.warlock, name);

		if ( ( quality ) and ( quality < 0 ) ) then 
			isJunk = true;
		end

		for i = 2, 5, 1 do
			if (not strings[i])
				then
				break;
			end
			if (strings[i].left == ITEM_UNIQUE or strings[i].left == ITEM_UNIQUE_MULTIPLE ) then unique = true; end
			if (strings[i].left == ITEM_SOULBOUND ) then soulbound = true; end
			if (strings[i].left == ITEM_BIND_ON_PICKUP ) then bindsOnPickup = true; end
			if (strings[i].left == ITEM_BIND_ON_EQUIP ) then bindsOnEquip = true; end
			if (strings[i].left == ITEM_BIND_QUEST ) then questItem = true; end
			
			if (string.find(strings[i].left,"First Aid", 0, true ) ) then firstaid = true; end
			if (string.find(strings[i].left,"Engineering", 0, true ) ) then engineering = true; end
			if (string.find(strings[i].left,"Classes:", 0, true ) ) then classitem = true; class = string.sub(strings[i].left, string.find(strings[i].left,":", 0, true )+2); end
			
			if (strings[i].left and
				strings[i].left ~= ITEM_UNIQUE and
				strings[i].left ~= ITEM_SOULBOUND and
				strings[i].left ~= ITEM_BIND_ON_EQUIP and
				strings[i].left ~= ITEM_BIND_ON_PICKUP and
				strings[i].left ~= ITEM_BIND_QUEST)
				then
				leftString = strings[i].left;
				rightString = strings[i].right;
				break;
			end
		end
		
		-- Find last line
		local lastLine;
		for i = 1, 10, 1 do
			if (strings[i] and strings[i].left)
				then
				lastLine = strings[i].left;
			else
				break;
			end
		end
		
		-- look at last line to see if it's a level requirement
		local minLevel = 0;
		if (lastLine)
			then
			local index, length, levelString = string.find(lastLine, "^Requires Level (%d+)$");
			if (index) then
				minLevel = Sea.string.toInt(levelString);
			end
		end
	
		-- classify item based on found strings
		if (leftString)
		then
			if (leftString == "Main Hand" or
				leftString == "Two-Hand" or
				leftString == "One-Hand")
			then
				classification = "Weapon";
			elseif (leftString == "Head" or
				leftString == "Hand" or
				leftString == "Waist" or
				leftString == "Shoulders" or
				leftString == "Legs" or
				leftString == "Back" or
				leftString == "Feet" or
				leftString == "Chest" or
				leftString == "Wrist")
				then
				classification = "Armor";
			elseif (leftString == "Off Hand")
				then
				classification = "Shield";
			elseif (leftString == "Wand" or
				leftString == "Ranged" or
				leftString == "Gun" )
				then
				classification = "Ranged";
			elseif (leftString == "Projectile") 
				then
				classification = "Ammo";
			elseif (leftString == "Shirt" or
				leftString == "Tabard" or
				leftString == "Finger" or
				leftString == "Neck" or
				leftString == "Trinket" or
				leftString == "Held In Hand")
				then
				classification = "Clothing";
			end
		end
		if ( classification == "Misc" ) then
			if ( isJunk ) then classification = "Junk"; end
			if ( isGem ) then classification = "Gem"; end
			if ( isOre ) then classification = "Ore"; end
			if ( isHerb ) then classification = "Herb"; end
			if ( engineering ) then classification = "Engineering"; end
			if ( firstaid ) then classification = "First Aid"; end
			if ( isLeather ) then classification = "Leather"; end
			if ( isTailor ) then classification = "Thread"; end
			if ( isPotion ) then classification = "Potion"; end
			if ( isFishing ) then classification = "Fishing"; end
			if ( isFood ) then classification = "Food"; end
			if ( isDrink ) then classification = "Drink"; end
			if ( isMage ) then classification = "Mage"; end
			if ( isShaman ) then classification = "Shaman"; end
			if ( isWarlock ) then classification = "Warlock"; end
			if ( isPoison ) then classification = "Poison"; end
			if ( classitem ) then classification = class; end
			if ( questItem ) then classification = "QuestItem"; end
		end 
		
		-- Create the item table
		-- Will soon have item information
		itemInfo = {};
		itemInfo.classification = classification;
		itemInfo.name = name;
		itemInfo.quality = quality;
		itemInfo.count = itemCount;
		itemInfo.minLevel = minLevel;
		itemInfo.unique = unique;
		itemInfo.soulbound = soulbound;
		itemInfo.bindOnPickup = bindsOnPickup;
		itemInfo.bindOnEquip = bindsOnEquip;
		itemInfo.quest = questItem;
	
		return itemInfo;
	end;
	
	--
	-- getInventoryItemInfoStrings ( bag, slot [, tooltip] )
	--
	--    Obtains all information about a bag/slot and returns it as an array 	
	--
	-- Args:
	-- 	(int bag, int slot, string tooltipbase )
	--
	-- Returns:
	-- 	(table[row][.left .right] strings)
	-- 	string - the string data of the tooltip
	-- 
	getInventoryItemInfoStrings = function (bag,slot, TooltipNameBase)
		if ( TooltipNameBase == nil ) then 
			TooltipNameBase = "GameTooltip";
		end

		Sea.wow.tooltip.clear(TooltipNameBase);
	
		local tooltip = getglobal(TooltipNameBase);
		
		-- Open tooltip & read contents
		Sea.wow.tooltip.protectTooltipMoney();
		if ( bag > -1 ) then
			tooltip:SetBagItem( bag, slot );
		else
			tooltip:SetInventoryItem( "player", slot);
		end
		Sea.wow.tooltip.unprotectTooltipMoney();
		local strings = Sea.wow.tooltip.scan(TooltipNameBase);

		-- Done our duty, send report
		return strings;
	end;

};

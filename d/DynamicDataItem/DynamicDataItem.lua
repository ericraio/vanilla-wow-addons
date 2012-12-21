--[[
	DynamicData

	By sarf

	This mod allows you to access dynamic data in WoW without being forced to rely on strange Blizzard functions

	Thanks goes to the Sea people, the UltimateUI team and finally the nice (but strange) people at 
	 #ultimateuitesters and Blizzard.
	
	UltimateUIUI URL:
	http://www.ultimateuiui.org/forums/viewtopic.php?t=NOT_YET_ANNOUNCED
	
   ]]

--[[
	Information returned by the DynamicData.item.get*Info() methods

An array is returned with the following values

	name					-- the name of the item
	strings					-- an array with strings that represent the tooltip of the item
	count					-- the number of items like this the user currently possesses
	texture
	cooldown = 				-- the cooldown of the item
		{ 
			start 			-- time when the cooldown started
			duration 		-- duration of the cooldown
			enable 			-- 1 or 0
		};
	
	-- each item may have these values:
	
	durability				-- current durability
	maxDurability			-- maximum durability
	itemType				-- type of item
	locked					-- ?

These values are 0 unless the item info derives from a ContainerInfo call (bag >= 0):

	quality					-- degree of commonness
	readable				-- ?

These values are 0 or "" unless the item info derives from a InventoryInfo call (bag == -1):

	broken					-- true if broken, false if not
	slotTexture 			-- background texture of the slot that the item resides in.


]]--


DYNAMICDATA_ITEM_SCAN_TYPE_TOOLTIP = 1;
DYNAMICDATA_ITEM_SCAN_TYPE_ITEMINFO = 2;
DYNAMICDATA_ITEM_SCAN_TYPE_COOLDOWN = 4;
DYNAMICDATA_ITEM_SCAN_TYPE_EVERYTHING = 7;
DYNAMICDATA_ITEM_SCAN_TYPE_QUICK = 6;


-- Item information - what the player is wearing and so on.
DynamicData.item = {

-- public functions	

	-- 
	-- addOnInventoryUpdateHandler (func)
	--
	--  Adds a function name that will be called on inventory updates.
	--  Function will have two parameters:
	--   bag, which may be nil.
	--   scanType, which may be DYNAMICDATA_ITEM_SCAN_TYPE_*
	--
	addOnInventoryUpdateHandler = function (func)
		return DynamicData.util.addOnWhateverHandler(DynamicData.item.OnInventoryUpdateHandlers, func);
	end;

	-- 
	-- removeOnInventoryUpdateHandler (func)
	--
	--  Removes the specified function, so that it will not be called on inventory updates.
	--
	removeOnInventoryUpdateHandler = function (func)
		return DynamicData.util.removeOnWhateverHandler(DynamicData.item.OnInventoryUpdateHandlers, func);
	end;

	-- LEGACY FUNCTION - covered in addOnInventoryUpdateHandler
	--
	-- addOnInventoryCooldownUpdateHandler (func)
	--
	--  Adds a function name that will be called on InventoryCooldown updates.
	--  Function will have one paremeter - bag, which may be nil.
	--
	addOnInventoryCooldownUpdateHandler = function (func)
		return DynamicData.util.addOnWhateverHandler(DynamicData.item.OnInventoryCooldownUpdateHandlers, func);
	end;

	-- LEGACY FUNCTION - covered in removeOnInventoryUpdateHandler
	-- 
	-- removeOnInventoryCooldownUpdateHandler (func)
	--
	--  Removes the specified function, so that it will not be called on InventoryCooldown updates.
	--
	removeOnInventoryCooldownUpdateHandler = function (func)
		return DynamicData.util.removeOnWhateverHandler(DynamicData.item.OnInventoryCooldownUpdateHandlers, func);
	end;

	-- 
	-- getEquippedSlotInfo (slot)
	--
	--  Retrieves information about the slot.
	--
	getEquippedSlotInfo = function (slot) 
		if ( ( DynamicData.item.player ) and ( DynamicData.item.player.itemsByBag )  and ( DynamicData.item.player.itemsByBag[-1] ) and ( DynamicData.item.player.itemsByBag[-1][slot] ) ) then
			return DynamicData.item.player.itemsByBag[-1][slot];
		else
			return DynamicData.item.defaultItem;
		end
	end;
	
	-- 
	-- getItemInfoByName (itemName)
	--
	--  Retrieves information about an item by name. 
	--  Adds a new variable called position with the position(s) of the item.
	--
	getItemInfoByName = function (itemName) 
		if ( ( DynamicData.item.player ) and ( DynamicData.item.player.itemsByBag ) ) then
			local element = nil;
			for bagNumber, bag in DynamicData.item.player.itemsByBag do
				for slotNumber, slot in bag do
					if ( slot.name == itemName ) then
						if ( not element ) then
							element = DynamicData.item.createBaseItem(slot);
						else
							if ( slot.count ) then
								element.count = element.count + slot.count;
							end
						end
						if ( not element.position ) then
							element.position = {};
						end
						local positionArray = {};
						positionArray.bag = bagNumber;
						positionArray.slot = slotNumber;
						table.insert(element.position, positionArray);
					end
				end
			end
			return element;
		else
			return DynamicData.item.defaultItem;
		end
	end;
	
	-- 
	-- getItemInfoByType (itemType)
	--
	--  Retrieves information about items with the specific type. Includes a new cute variable called totalCount.
	--
	getItemInfoByType = function (itemName) 
		local bagNumber, bag;
		local slotNumber, itemInfo;
		local items = {};
		for bagNumber, bag in DynamicData.item.player.itemsByBag do
			for slotNumber, itemInfo in bag do
				if ( itemInfo.itemType == itemType ) then
					table.insert(items, DynamicData.item.getItemInfoByName(itemInfo.name));
				end
			end
		end
		return items;
	end;
	
	-- 
	-- getEquippedSlotCooldown (slot)
	--
	--  Retrieves cooldown information about the slot.
	--
	getEquippedSlotCooldown = function (slot) 
		if ( ( DynamicData.item.player ) and ( DynamicData.item.player.itemsByBag )  and ( DynamicData.item.player.itemsByBag[-1] ) and ( DynamicData.item.player.itemsByBag[-1][slot] ) ) then
			local cooldown = DynamicData.item.player.itemsByBag[-1][slot].cooldown;
			return cooldown[1], cooldown[2], cooldown[3];
		else
			return 0, 0, 0;
		end
	end;
	
	-- 
	-- getInventoryInfo (bag, slot)
	--
	--  Retrieves information about the bag and slot.
	--
	getInventoryInfo = function (bag, slot)
		DynamicData.item.scanInventorySlotIfTime(bag, slot);
		local element = DynamicData.item.player.itemsByBag[bag][slot];
		if ( not element ) then
			element = DynamicData.item.defaultItem;
		end
		return element;
	end;

	-- 
	-- getInventoryName (bag, slot)
	--
	--  Retrieves the name of the item in the bag and slot.
	--
	getInventoryName = function (bag, slot) 
		if ( ( DynamicData.item.player ) and ( DynamicData.item.player.itemsByBag ) and ( DynamicData.item.player.itemsByBag[bag] ) and ( DynamicData.item.player.itemsByBag[bag][slot] ) ) then
			local itemInfo = DynamicData.item.getInventoryInfo(bag, slot);
			if ( ( not itemInfo ) or ( ( itemInfo.texture ) and ( strlen(itemInfo.texture) > 0 ) and ( ( not itemInfo.name ) or ( strlen(itemInfo.name) <= 0 ) ) ) ) then
				DynamicData.item.scanItem(bag, slot);
				itemInfo = DynamicData.item.player.itemsByBag[bag][slot];
			end
			return itemInfo.name;
		else
			return DynamicData.item.defaultItem.name;
		end
	end;

	-- 
	-- getInventoryCooldownInfo (bag, slot)
	--
	--  Retrieves cooldown information about the bag and slot.
	--
	getInventoryCooldown = function (bag, slot) 
		if ( ( DynamicData.item.player ) and ( DynamicData.item.player.itemsByBag ) and ( DynamicData.item.player.itemsByBag[bag] ) and ( DynamicData.item.player.itemsByBag[bag][slot] ) ) then
			local cooldown = DynamicData.item.player.itemsByBag[bag][slot].cooldown;
			return cooldown[1], cooldown[2], cooldown[3];
		else
			return 0, 0, 0;
		end
	end;

	-- 
	-- getEquippedSlotInfoBySlotName (slotName)
	--
	--  Retrieves information about the slot with the specified name.
	--
	getEquippedSlotInfoBySlotName = function (slotName) 
		for key, value in DynamicData.item.inventorySlotNames do
			if ( value.name == slotName ) then
				return DynamicData.item.getEquippedSlotInfo(value.id);
			end
		end
		return DynamicData.item.defaultItem;
	end;
	
	-- 
	-- updateItems ()
	--
	--  Updates the inventory of the player. 
	--
	updateItems = function (bag) 
		params = {
			func = DynamicData.item.doUpdateItems,
			params = { bag },
			allowInitialUpdate = 1,
			schedulingName = "DynamicData_item_UpdateItems",
		};
		--DynamicData.util.postpone(params);
		DynamicData.item.doUpdateItems(bag);
	end;
	
	-- 
	-- updateItemCooldowns ()
	--
	--  Updates the cooldowns of the players items.
	--
	updateItemCooldowns = function ()
		local safe = true; --DynamicData.util.safeToUseTooltips({"MerchantFrame", "TradeSkillFrame", "AuctionFrame"});
		if ( not safe ) then
			UltimateUI_ScheduleByName("DynamicData_item_updateItemCooldownsUnspecified", 0.1, DynamicData.item.updateItemCooldowns);
			return;
		end
		DynamicData.item.doQuickScan();
		--[[
		local bag;
		for bag = 0,4 do
			DynamicData.item.doUpdateBagItemsCooldown(bag);
		end
		DynamicData.item.doUpdateBagItemsCooldown(-1);
		bag = nil;
		DynamicData.item.notifyUpdateHandlers(nil, DYNAMICDATA_ITEM_SCAN_TYPE_COOLDOWN);
		DynamicData.item.notifyItemCooldownUpdateHandlers();
		]]--
	end;
	
	-- 
	-- updateItemLocks ()
	--
	--  Updates the locks of the players items.
	--
	updateItemLocks = function ()
		DynamicData.item.updateItems();
	end;
	
	-- 
	-- updateItemAlerts ()
	--
	--  Updates the alerts of the players items.
	--  You can never have too many lerts.
	--
	updateItemAlerts = function ()
		DynamicData.item.updateItems();
	end;

-- protected functions


	-- 
	-- doUpdateSeperateBagItems (bag)
	--
	--  Updates a bag seperately from the rest of the inventory of the player. 
	--  Saves some time.
	--
	doUpdateSeperateBagItems = function (bag) 
		if ( not bag ) then
			return;
		end
		if ( DynamicData.item.player.itemsByBag ) then
			table.remove(DynamicData.item.player.itemsByBag, bag);
		end
		DynamicData.item.doUpdateBagItems(bag);
	end;

	-- 
	-- doUpdateBagItems (bag)
	--
	--  Updates a bag of the inventory of the player. 
	--
	doUpdateBagItems = function (bag) 
		DynamicData.item.scanItemsInBag(bag);
	end;

	-- 
	-- doUpdateItems ()
	--
	--  Initiates updates of the inventory of the player. 
	--
	doUpdateItems = function (bag) 
		local safe = true; --DynamicData.util.safeToUseTooltips({"MerchantFrame", "TradeSkillFrame", "AuctionFrame"});
		if ( not safe ) then
			if ( bag ) then
				UltimateUI_ScheduleByName("DynamicData_item_doUpdateItems", 0.1, DynamicData.item.doUpdateItems, bag);
			else
				UltimateUI_ScheduleByName("DynamicData_item_doUpdateItemsUnspecified", 0.1, DynamicData.item.doUpdateItems);
			end
			return;
		end
		DynamicData.item.doQuickScan();
		if ( ( bag ) and ( DynamicData.item.player ) ) then
			--DynamicData.item.doQuickScan(bag);
			--local scanLists = DynamicData.item.generateScanLists(nil, bag);
			--DynamicData.item.addScans(scanLists);
			DynamicData.item.makeScanLists(bag);
			if ( not DynamicData.item.itemScanInProgress ) then
				--DynamicData.item.doScans(nil, nil, bag);
				DynamicData.item.doScans(nil, nil, bag);
				--UltimateUI_ScheduleByName("DynamicData_Item_doScans", 0.1, DynamicData.item.doScans);
			end
			--DynamicData.item.doUpdateSeperateBagItems(bag);
			--DynamicData.item.notifyUpdateHandlers(bag);
			--DynamicData.item.notifyItemCooldownUpdateHandlers();
		else
			--DynamicData.item.player = {};
			--local scanLists = DynamicData.item.generateScanLists();
			--DynamicData.item.addScans(scanLists);
			DynamicData.item.makeScanLists();
			--DynamicData.item.doQuickScan();
			if ( not DynamicData.item.itemScanInProgress ) then
				DynamicData.item.doScans(nil);
				--UltimateUI_ScheduleByName("DynamicData_Item_doScans", 0.1, DynamicData.item.doScans);
			end
		end
	end;

	--
	-- addScans(scanLists)
	--
	--  Adds scan lists to the global scanlist thingy.
	--
	addScans = function (scanLists)
		for k, v in scanLists do
			for bag, slot in v do
				if ( not DynamicData.item.scanList ) then
					DynamicData.item.scanList = {};
				end
				if ( not DynamicData.item.scanList[bag] ) then
					DynamicData.item.scanList[bag] = {};
				end
				if ( not DynamicData.item.scanList[bag][slot] ) then
					DynamicData.item.scanList[bag][slot] = 0;
				end
				DynamicData.item.scanList[bag][slot] = 1;
			end
			--table.insert(DynamicData.item.scanList, v);
		end
	end;
	
	

	--
	-- doScans (scanLists, currentIndex)
	--
	--  scans the currently indicated list and schedules next scan list.
	--  when completed, generates update notification.
	--
	doScans = function (scanLists, currentIndex, bag)
		scanLists = nil;
		--[[
		if ( not scanLists ) then
			scanLists = DynamicData.item.scanList;
		end
		]]--
		local scheduleName = "DynamicData_Item_doScans";
		if ( bag ) then
			--scheduleName = scheduleName.."_"..bag;
		end
		DynamicData.item.itemScanInProgress = true;
		if ( not currentIndex ) then
			-- if first time, then we schedule a new scan - this is to prevent the stuttering effect when receiving loads of updates in short succession.
			--[[
			if ( scanLists == DynamicData.item.scanList ) then
				scanLists = nil;
			end
			]]--
			UltimateUI_ScheduleByName(scheduleName, 0.1, DynamicData.item.doScans, scanLists, 1, bag);
			return;
		else
			-- prevents old scans from continuing.
			UltimateUI_ScheduleByName(scheduleName, 0.1, DynamicData.item.doScans);
		end
		local scanType = DYNAMICDATA_ITEM_SCAN_TYPE_TOOLTIP;
		if ( DynamicData.item.scanItems(scanType) ) then
			if ( scanLists == DynamicData.item.scanList ) then
				scanLists = nil;
			end
			UltimateUI_ScheduleByName(scheduleName, 0.1, DynamicData.item.doScans, scanLists, currentIndex, bag);
			return;
		else
			if ( scanLists == DynamicData.item.scanList ) then
				--DynamicData.item.scanList = {};
			end
			DynamicData.item.itemScanInProgress = false;
			DynamicData.item.notifyUpdateHandlers(bag, scanType);
			--DynamicData.item.notifyItemCooldownUpdateHandlers();
		end
	end;


	-- 
	-- doUpdateBagItemsCooldown (bag)
	--
	--  Updates the cooldown a bag of the inventory of the player. 
	--
	doUpdateBagItemsCooldown = function (bag) 
		if ( ( DynamicData.item.player ) and ( DynamicData.item.player.itemsByBag ) and ( DynamicData.item.player.itemsByBag[bag] ) ) then
			if ( bag > -1 ) then
				local element = nil;
				for slot = 1,GetContainerNumSlots(bag) do
					if ( DynamicData.item.player.itemsByBag[bag][slot] ) then
						local ic_start, ic_duration, ic_enable = GetContainerItemCooldown(bag, slot);
						local itemCooldown = DynamicData.item.getOldCooldown(bag, slot);
						itemCooldown[1] = ic_start;
						itemCooldown[2] = ic_duration;
						itemCooldown[3] = ic_enable;
						itemCooldown.start = ic_start;
						itemCooldown.duration = ic_duration;
						itemCooldown.enable = ic_enable;
						DynamicData.item.player.itemsByBag[bag][slot].cooldown = itemCooldown;
					end
				end
			else
				for k, v in DynamicData.item.inventorySlotNames do
					slot = v.id;
					if ( DynamicData.item.player.itemsByBag[bag][slot] ) then
						local ic_start, ic_duration, ic_enable = GetInventoryItemCooldown("player", slot);
						local itemCooldown = DynamicData.item.getOldCooldown(bag, slot);
						itemCooldown[1] = ic_start;
						itemCooldown[2] = ic_duration;
						itemCooldown[3] = ic_enable;
						itemCooldown.start = ic_start;
						itemCooldown.duration = ic_duration;
						itemCooldown.enable = ic_enable;
						DynamicData.item.player.itemsByBag[bag][slot].cooldown = itemCooldown;
					end
				end
			end
		end
	end;

-- private functions	

	-- 
	-- notifyUpdateHandlers (bag)
	--
	-- Args: 
	--  bag - if not nil, the bag that has been updated
	--  scanType - the type of scan that has completed
	-- 
	--  Notifies all update handlers that an update has occurred.
	--
	notifyUpdateHandlers = function (bag, scanType) 
		DynamicData.util.notifyWhateverHandlers(DynamicData.item.OnInventoryUpdateHandlers, bag, scanType);
	end;

	-- LEGACY FUNCTION
	-- 
	-- notifyItemCooldownUpdateHandlers ()
	--
	--  Notifies all item cooldown update handlers that an item cooldown has occurred.
	--
	notifyItemCooldownUpdateHandlers = function () 
		DynamicData.util.notifyWhateverHandlers(DynamicData.item.OnInventoryCooldownUpdateHandlers);
	end;

	--
	-- OnLoad ()
	--
	--  Sets up the DynamicData.item for operation.
	--  In this case, it retrieves the IDs for the inventory slots.
	--
	OnLoad = function ()
		for key, value in DynamicData.item.inventorySlotNames do
			DynamicData.item.inventorySlotNames[key].id = GetInventorySlotInfo(value.name);
		end
		DynamicData.item.doUpdateItems();
		UltimateUI_AfterInit(DynamicData.item.doUpdateItems);
		UltimateUI_AfterInit(UltimateUI_Schedule, 30, DynamicData.item.doUpdateItems);
		UltimateUI_AfterInit(UltimateUI_Schedule, 60, DynamicData.item.doUpdateItems);
		UltimateUI_AfterInit(UltimateUI_Schedule, 90, DynamicData.item.doUpdateItems);
	end;

-- variables

	-- Taken from ItemBuff - thanks, Telo!
	-- Used for mapping inventory (equipment) ids and slot names
	inventorySlotNames = {
		{ name = "HeadSlot" },
		{ name = "NeckSlot" },
		{ name = "ShoulderSlot" },
		{ name = "BackSlot" },
		{ name = "ChestSlot" },
		{ name = "ShirtSlot" },
		{ name = "TabardSlot" },
		{ name = "WristSlot" },
		{ name = "HandsSlot" },
		{ name = "WaistSlot" },
		{ name = "LegsSlot" },
		{ name = "FeetSlot" },
		{ name = "Finger0Slot" },
		{ name = "Finger1Slot" },
		{ name = "Trinket0Slot" },
		{ name = "Trinket1Slot" },
		{ name = "MainHandSlot" },
		{ name = "SecondaryHandSlot" },
		{ name = "RangedSlot" },
	};

	-- Contains lists of items that should be scanned.
	scanList = {};
	
	-- Contains lists of when item slots were scanned.
	scanListScanned = {};
	
	-- Whether a scan is in progress or not.
	itemScanInProgress = false;

	-- Contains item data about the player's items.
	player = {};

	-- Contains the function pointers to functions that want to be called whenever the inventory updates.
	-- Will be called AFTER the DynamicData has parsed the inventory.
	OnInventoryUpdateHandlers = {};	

	-- Contains the function pointers to functions that want to be called whenever the inventory cooldown updates.
	-- Will be called AFTER the DynamicData has parsed the inventory.
	OnInventoryCooldownUpdateHandlers = {};	

	defaultItem = {
		name = "",
		strings = {
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
			[5] = {},
			[6] = {},
			[7] = {},
			[8] = {},
			[9] = {},
			[10] = {},
			[11] = {},
			[12] = {},
			[13] = {},
			[14] = {},
			[15] = {}
		},
		count = 0,
		slotCount = 0,
		texture = "",
		cooldown = {
			[1] = 0,
			[2] = 0,
			[3] = 0,
			start = 0,
			duration = 0,
			enable = 0
		},
		itemType = "",
		locked = 0,
		durability = nil,
		maxDurability = nil,
		quality = 0,
		readable = 0,
		broken = 0,
		slotTexture = ""
	};

	--
	-- createBaseItem ()
	-- 
	--  creates a basic item with all attributes set to defaults.
	--
	createBaseItem = function (baseItem)
		local newItem = {};
		for k, v in DynamicData.item.defaultItem do
			newItem[k] = v;
		end
		if ( baseItem ) then
			for k, v in baseItem do
				newItem[k] = v;
			end
		end
		return newItem;
	end;


	--
	-- makeScanList (numberOfScansPerList, bag)
	--
	--  Makes a list of scans.
	--
	makeScanLists = function (bag)
		if ( not DynamicData.item.scanList ) then
			DynamicData.item.scanList = {};
		end
		if ( not bag ) then
			for bag = 0, 4, 1 do
				for slot = 1, GetContainerNumSlots(bag), 1 do
					if ( not DynamicData.item.scanList[bag] ) then
						DynamicData.item.scanList[bag] = {};
					end
					DynamicData.item.scanList[bag][slot] = 1;
				end
			end
			bag = -1;
			for slot = 1, 19, 1 do
				if ( not DynamicData.item.scanList[bag] ) then
					DynamicData.item.scanList[bag] = {};
				end
				DynamicData.item.scanList[bag][slot] = 1;
			end
		elseif ( bag <= -1 ) then
			bag = -1;
			if ( not DynamicData.item.scanList[bag] ) then
				DynamicData.item.scanList[bag] = {};
			end
			for slot = 1, 19, 1 do
				DynamicData.item.scanList[bag][slot] = 1;
			end
		else
			if ( not DynamicData.item.scanList[bag] ) then
				DynamicData.item.scanList[bag] = {};
			end
			for slot = 1, GetContainerNumSlots(bag), 1 do
				DynamicData.item.scanList[bag][slot] = 1;
			end
		end
	end;

	--
	-- generateScanLists (numberOfScansPerList, bag)
	--
	--  Generates a list of scans.
	--
	generateScanLists = function (numberOfScansPerList, bag)
		if ( not numberOfScansPerList ) then
			numberOfScansPerList = DYNAMICDATA_DEFAULT_NUMBER_OF_TOOLTIP_SCANS_PER_UPDATE;
		end
		local lists = {};
		local numberOfCurrentScans = 0;
		local currentList = {};
		local slot;
		if ( not bag ) then
			for bag = 0, 4, 1 do
				for slot = 1, GetContainerNumSlots(bag), 1 do
					if ( not currentList[bag] ) then
						currentList[bag] = {};
					end
					table.insert(currentList[bag], slot);
					numberOfCurrentScans = numberOfCurrentScans + 1;
					if ( numberOfCurrentScans >= numberOfScansPerList) then
						table.insert(lists, currentList);
						currentList = {};
						numberOfCurrentScans = 0;
					end
				end
			end
			bag = -1;
			for slot = 1, 19, 1 do
				if ( not currentList[bag] ) then
					currentList[bag] = {};
				end
				table.insert(currentList[bag], slot);
				numberOfCurrentScans = numberOfCurrentScans + 1;
				if ( numberOfCurrentScans >= numberOfScansPerList) then
					table.insert(lists, currentList);
					currentList = {};
					numberOfCurrentScans = 0;
				end
			end
		elseif ( bag <= -1 ) then
			bag = -1;
			for slot = 1, 19, 1 do
				if ( not currentList[bag] ) then
					currentList[bag] = {};
				end
				table.insert(currentList[bag], slot);
				numberOfCurrentScans = numberOfCurrentScans + 1;
				if ( numberOfCurrentScans >= numberOfScansPerList) then
					table.insert(lists, currentList);
					currentList = {};
					numberOfCurrentScans = 0;
				end
			end
		else
			for slot = 1, GetContainerNumSlots(bag), 1 do
				if ( not currentList[bag] ) then
					currentList[bag] = {};
				end
				table.insert(currentList[bag], slot);
				numberOfCurrentScans = numberOfCurrentScans + 1;
				if ( numberOfCurrentScans >= numberOfScansPerList) then
					table.insert(lists, currentList);
					currentList = {};
					numberOfCurrentScans = 0;
				end
			end
		end
		if ( numberOfCurrentScans > 0) then
			table.insert(lists, currentList);
		end
		return lists;
	end;
	
	--
	-- doQuickScan (bag)
	--
	--  does a quick scan of the bag (or of the whole inventory if bag is not specified).
	--
	doQuickScan = function(bag)
		if ( bag ) then
			DynamicData.item.scanItemsInBag(bag, DYNAMICDATA_ITEM_SCAN_TYPE_QUICK);
		else
			for i = 0, 4, 1 do
				DynamicData.item.scanItemsInBag(i, DYNAMICDATA_ITEM_SCAN_TYPE_QUICK);
			end
			DynamicData.item.scanItemsInBag(-1, DYNAMICDATA_ITEM_SCAN_TYPE_QUICK);
		end
		DynamicData.item.notifyUpdateHandlers(bag, DYNAMICDATA_ITEM_SCAN_TYPE_QUICK);
		DynamicData.item.notifyItemCooldownUpdateHandlers();
	end;
	
	--
	-- scanItemsInBag (bag, scanType)
	--
	--  scans all items in bag and puts the info into the database
	--  can be retailored to only scan the tooltip, everything but the tooltip and everything.
	--
	scanItemsInBag = function(bag, scanType)
		local bag, slot, v;
		if ( not bag ) then
			return;
		end
		if ( bag <= -1 ) then
			for slot = 1, 19, 1 do
				DynamicData.item.scanItem(-1, slot, scanType);
			end
		else
			for slot = 1, GetContainerNumSlots(bag), 1 do
				DynamicData.item.scanItem(bag, slot, scanType);
			end
		end
	end;
	
	--
	-- scanItems (list, scanType)
	--
	--  scans a list of item slots item and puts the info into the database
	--  can be retailored to only scan the tooltip, everything but the tooltip and everything.
	--  list format : list[bag] = { slot1, slot2, slot3 ... };
	--
	scanItems = function(scanType)
		local curTime = GetTime();
		local numberScanned = 0;
		local scanned = false;
		for bag, bagValue in DynamicData.item.scanList do
			for slot, value in bagValue do
				if ( value == 1 ) then
					DynamicData.item.scanItem(bag, slot, scanType);
					DynamicData.item.scanList[bag][slot] = 0;
					if ( not DynamicData.item.scanListScanned ) then
						DynamicData.item.scanListScanned = {};
					end
					if ( not DynamicData.item.scanListScanned[bag] ) then
						DynamicData.item.scanListScanned[bag] = {};
					end
					DynamicData.item.scanListScanned[bag][slot] = curTime;
					numberScanned = numberScanned + 1;
					scanned = true;
					if ( numberScanned >= DYNAMICDATA_DEFAULT_NUMBER_OF_TOOLTIP_SCANS_PER_UPDATE ) then
						return scanned;
					end
				end
			end
		end
		return scanned;
		--[[
		for bag, v in list do
			for key, slot in v do
				DynamicData.item.scanItem(bag, slot, scanType);
			end
		end
		]]--
	end;
	
	--
	-- scanItem (bag, slot)
	--
	--  scans an item and puts the info into the item database
	--
	scanItem = function(bag, slot, scanType)
		if ( not scanType ) then
			scanType = DYNAMICDATA_ITEM_SCAN_TYPE_EVERYTHING;
		end
		local strings = nil;
		local itemName = nil;
		local element = nil;
		if ( not DynamicData.item.scanListScanned ) then
			DynamicData.item.scanListScanned = {};
		end
		if ( not DynamicData.item.scanListScanned[bag] ) then
			DynamicData.item.scanListScanned[bag] = {};
		end
		if ( not DynamicData.item.scanListScanned[bag][slot] ) then
			DynamicData.item.scanListScanned[bag][slot] = GetTime();
		end
		if ( bag > -1 ) then
			if ( not DynamicData.item.player ) then
				DynamicData.item.player = {};
			end
			if ( not DynamicData.item.player.itemsByBag ) then
				DynamicData.item.player.itemsByBag = {};
			end
			if ( not DynamicData.item.player.itemsByBag[bag] ) then
				DynamicData.item.player.itemsByBag[bag] = {};
			end
			if ( GetContainerNumSlots(bag) < slot ) then
				return nil;
			end
			if ( not DynamicData.item.player.itemsByBag[bag][slot] ) then
				DynamicData.item.player.itemsByBag[bag][slot] = DynamicData.item.createBaseItem();
			end
			element = DynamicData.item.player.itemsByBag[bag][slot];
			if ( not element.previousElement ) then
				element.previousElement = {};
			end
			if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_COOLDOWN ) > 0 ) then
				local ic_start, ic_duration, ic_enable = GetContainerItemCooldown(bag, slot);
				local itemCooldown = DynamicData.item.getOldCooldown(bag, slot);
				itemCooldown[1] = ic_start;
				itemCooldown[2] = ic_duration;
				itemCooldown[3] = ic_enable;
				itemCooldown.start = ic_start;
				itemCooldown.duration = ic_duration;
				itemCooldown.enable = ic_enable;
				element.cooldown = itemCooldown;
			end
			if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_ITEMINFO ) > 0 ) then
				local textureName, itemCount, itemLocked, itemQuality, itemReadable = GetContainerItemInfo(bag, slot);
				local name = DynamicData.util.getItemNameFromLink(GetContainerItemLink(bag, slot));
				if ( name ) then
					element.name = name;
				end
				element.count = itemCount;
				element.texture = textureName;
				element.locked = itemLocked;
				element.quality = itemQuality;
				element.readable = itemReadable;
			end
			if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_TOOLTIP ) > 0 ) then
				if ( scanType == DYNAMICDATA_ITEM_SCAN_TYPE_TOOLTIP ) or ( not element.previousElement ) or ( element.previousElement.name ~= element.name ) or ( element.previousElement.cooldown.start ~= 0 ) or ( element.cooldown.start ~= 0 ) then
					strings = DynamicData.util.getItemTooltipInfo(bag, slot);
					if ( strings[1] ) and ( strings[1].left ) then
						itemName = strings[1].left;
					else
						itemName = "";
					end
					element.name = itemName;
					element.strings = strings;
					element.itemType = DynamicData.util.getItemStringType(strings);
	
					local itemCurrentDurability, itemMaxDurability = DynamicData.util.getCurrentAndMaxDurability(strings);
					element.durability = itemCurrentDurability;
					element.maxDurability = itemMaxDurability;
					if ( not element.previousElement ) then
						element.previousElement = {};
					end
					for k, v in element do
						if ( type(v) == "table" ) then
							if ( not element.previousElement[k] ) then
								element.previousElement[k] = {};
							end
							for key, value in v do
								if ( type(value) == "table" ) then
									if ( not element.previousElement[k][key] ) then
										element.previousElement[k][key] = {};
									end
									for keyKey, valueValue in value do
										element.previousElement[k][key][keyKey] = valueValue;
									end
								else
									element.previousElement[k][key] = value;
								end
							end
						else
							element.previousElement[k] = v;
						end
					end
				end
			end
			DynamicData.item.player.itemsByBag[bag][slot] = element;
		else
			bag = -1;
			if ( not DynamicData.item.player ) then
				DynamicData.item.player = {};
			end
			if ( not DynamicData.item.player.itemsByBag ) then
				DynamicData.item.player.itemsByBag = {};
			end
			if ( not DynamicData.item.player.itemsByBag[bag] ) then
				DynamicData.item.player.itemsByBag[bag] = {};
			end
			if ( not DynamicData.item.player.itemsByBag[bag][slot] ) then
				DynamicData.item.player.itemsByBag[bag][slot] = DynamicData.item.createBaseItem();
			end
			element = DynamicData.item.player.itemsByBag[bag][slot];

			if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_COOLDOWN ) > 0 ) then
				local ic_start, ic_duration, ic_enable = GetInventoryItemCooldown("player", slot);
				local itemCooldown = DynamicData.item.getOldCooldown(bag, slot);
				itemCooldown[1] = ic_start;
				itemCooldown[2] = ic_duration;
				itemCooldown[3] = ic_enable;
				itemCooldown.start = ic_start;
				itemCooldown.duration = ic_duration;
				itemCooldown.enable = ic_enable;
				element.cooldown = itemCooldown;
			end
			if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_ITEMINFO ) > 0 ) then
				local itemCount = GetInventoryItemCount("player", slot);
				local textureName = GetInventoryItemTexture("player", slot);
				element.count = itemCount;
				element.slotTexture = slotTextureName;
				element.texture = textureName;
				element.locked = IsInventoryItemLocked(slot);
				element.broken = GetInventoryItemBroken("player", slot);
				--element.quality = GetInventoryItemQuality("player", slot);
			end
			if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_TOOLTIP ) > 0 ) then
				strings = DynamicData.util.getItemTooltipInfo(-1, slot);
				element.strings = strings;
				if ( strings[1] ) and ( strings[1].left ) then
					itemName = strings[1].left;
				else
					itemName = "";
				end
				element.name = itemName;
				element.itemType = DynamicData.util.getItemStringType(strings);
				
				local itemCurrentDurability, itemMaxDurability = DynamicData.util.getCurrentAndMaxDurability(strings);
				element.durability = itemCurrentDurability;
				element.maxDurability = itemMaxDurability;
			end
			DynamicData.item.player.itemsByBag[bag][slot] = element;
		end
		return element;
	end;
	
	getOldCooldown = function(bag, slot)
		if ( DynamicData.item.player.itemsByBag ) 
			and ( DynamicData.item.player.itemsByBag[bag] ) 
			and ( DynamicData.item.player.itemsByBag[bag][slot] ) 
			and ( DynamicData.item.player.itemsByBag[bag][slot].cooldown ) then
			itemCooldown = DynamicData.item.player.itemsByBag[bag][slot].cooldown;
		else
			itemCooldown = { };
		end
		return itemCooldown;
	end;
	
	--
	-- getInventorySlotScanned(bag, slot) 
	--
	--  retrieves when the slot was last scanned or nil if never
	--
	getInventorySlotScanned = function (bag, slot) 
		if ( not DynamicData.item.scanListScanned ) then
			DynamicData.item.scanListScanned = {};
		end
		if ( not DynamicData.item.scanListScanned[bag] ) then
			DynamicData.item.scanListScanned[bag] = {};
		end
		return DynamicData.item.scanListScanned[bag][slot];
	end;
	
	--
	-- scanInventorySlotIfTime(bag, slot) 
	--
	--  scans the slot if necessary.
	--
	scanInventorySlotIfTime = function(bag, slot)
		local curTime = GetTime();
		local lastScanned = DynamicData.item.getInventorySlotScanned(bag, slot);
		if ( not lastScanned ) or ( ( lastScanned + 0.2 ) < GetTime() ) then
			DynamicData.item.scanItem(bag, slot, DYNAMICDATA_ITEM_SCAN_TYPE_QUICK);
		end
	end;

};


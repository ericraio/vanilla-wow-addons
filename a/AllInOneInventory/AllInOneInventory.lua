--[[
	All In One Inventory

	By sarf

	This mod allows you to view and interact with your inventory without caring about bags.

	Thanks goes to SirBender for the background conversion and other stuff! :)

	Thanks to amoeba for the ultra-nice Lock Button! Even if they lacked transparency. :)

	CosmosUI URL:
	http://www.cosmosui.org/forums/viewtopic.php?t=

   ]]


-- Constants
ALLINONEINVENTORY_MAX_ID = 109;
ALLINONEINVENTORY_WIDTH = 350;

ALLINONEINVENTORY_NUM_COLUMNS = 8;
ALLINONEINVENTORY_COLUMNS_MIN = 2;
ALLINONEINVENTORY_COLUMNS_MAX = 16;
ALLINONEINVENTORY_BASE_HEIGHT = 64;
ALLINONEINVENTORY_ROW_HEIGHT = 40;

ALLINONEINVENTORY_BASE_WIDTH = 26;
ALLINONEINVENTORY_COL_WIDTH = 40;

ALLINONEINVENTORY_ALPHA_MIN = 0;
ALLINONEINVENTORY_ALPHA_MAX = 1;

ALLINONEINVENTORY_SCALE_MIN = 0;
ALLINONEINVENTORY_SCALE_MAX = 2;

ALLINONEINVENTORY_SCHEDULENAME_UPDATE = "AllInOneInventory_UpdateBags";
ALLINONEINVENTORY_MAXIMUM_NUMBER_OF_BUTTONS = 109;
ALLINONEINVENTORY_MINIMUM_TIME_BETWEEN_UPDATES = 0.2;

-- Variables
AllInOneInventory_Enabled = 0;
AllInOneInventory_ReplaceBags = 0;
AllInOneInventory_IncludeShotBags = 1;
AllInOneInventory_ShowPrice = 1;
AllInOneInventory_Locked = 0;
AllInOneInventory_SwapBagOrder = 0;
AllInOneInventory_Alpha = 1;
AllInOneInventory_Scale = 1;

AllInOneInventory_ExcludeSlots = {};


AllInOneInventory_IncludeBagZero = 1;
AllInOneInventory_IncludeBagOne = 1;
AllInOneInventory_IncludeBagTwo = 1;
AllInOneInventory_IncludeBagThree = 1;
AllInOneInventory_IncludeBagFour = 1;

AllInOneInventory_ModifyTooltipsAtMerchant = 1;

AllInOneInventory_BagStringIndex = {
	[0] = "Zero",
	[1] = "One",
	[2] = "Two",
	[3] = "Three",
	[4] = "Four",
};

AllInOneInventory_BagsToInclude = {
	[0] = "AllInOneInventory_IncludeBagZero",
	[1] = "AllInOneInventory_IncludeBagOne",
	[2] = "AllInOneInventory_IncludeBagTwo",
	[3] = "AllInOneInventory_IncludeBagThree",
	[4] = "AllInOneInventory_IncludeBagFour",
};


AllInOneInventory_Columns = ALLINONEINVENTORY_NUM_COLUMNS;

AllInOneInventory_Patching_Tooltip = 0;

AllInOneInventory_Saved_SellValue_OnShow = nil;
AllInOneInventory_Saved_UseContainerItem = nil;
AllInOneInventory_Saved_ToggleBag = nil;
AllInOneInventory_Saved_OpenBag = nil;
AllInOneInventory_Saved_CloseBag = nil;
AllInOneInventory_Saved_ToggleBackpack = nil;
AllInOneInventory_Saved_CloseBackpack = nil;
AllInOneInventory_Saved_OpenBackpack = nil;
AllInOneInventory_Saved_BagSlotButton_OnClick = nil;
AllInOneInventory_Saved_BagSlotButton_OnDrag = nil;
AllInOneInventory_Saved_BackpackButton_OnClick = nil;
AllInOneInventory_Saved_CloseAllWindows = nil;
AllInOneInventory_Saved_OpenAllBags = nil;
AllInOneInventory_Saved_DepositBox_RefreshWindows = nil;

function AIOI_Schedule_Own(time, func, p1, p2, p3, p4, p5, p6, p7, p8, p9)
	func(p1, p2, p3, p4, p5, p6, p7, p8, p9);
end

function AIOI_ScheduleByName_Own(name, time, func, p1, p2, p3, p4, p5, p6, p7, p8, p9)
	func(p1, p2, p3, p4, p5, p6, p7, p8, p9);
end

-- executed on load, calls general set-up functions
function AllInOneInventoryScriptFrame_OnLoad()
	local func = AIOI_ScheduleByName_Own;
	if ( Chronos ) and ( Chronos.scheduleByName ) then
		func = Chronos.scheduleByName;
	elseif ( Cosmos_ScheduleByName ) then
		func = Cosmos_ScheduleByName;
	end
	setglobal("AIOI_ScheduleByName", func);
	func = AIOI_Schedule_Own;
	if ( Chronos ) and ( Chronos.schedule ) then
		func = Chronos.schedule;
	elseif ( Cosmos_Schedule ) then
		func = Cosmos_Schedule;
	end
	setglobal("AIOI_Schedule", func);

	AllInOneInventory_Register();
	AllInOneInventory_Setup_Hooks(1);
	--DynamicData.item.addOnInventoryUpdateHandler(AllInOneInventoryFrame_OnInventoryUpdate);
end

function AllInOneInventory_Register_SlashCommands()
	SlashCmdList["ALLINONEINVENTORYSLASHMAIN"] = AllInOneInventory_Main_ChatCommandHandler;
	SLASH_ALLINONEINVENTORYSLASHMAIN1 = "/allinoneinventory";
	SLASH_ALLINONEINVENTORYSLASHMAIN2 = "/aioi";
end

-- registers the mod with the system, integrating it with slash commands and "master" AddOns
function AllInOneInventory_Register()
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("ADDON_LOADED");
	AllInOneInventory_Register_SlashCommands()
end

function AllInOneInventory_Extract_NextParameter(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end

function AllInOneInventory_GetItemInfo(id)
	local bag, slot = AllInOneInventory_GetIdAsBagSlot(id);
	return GetContainerItemInfo(bag, slot);
end

function AllInOneInventory_GetNumberOfSlotsInBag(bag)
	local slots = 0;
	if ( AllInOneInventory_ShouldIncludeBag(bag) ) then
		slots = GetContainerNumSlots(bag);
		if ( AllInOneInventory_ExcludeSlots ) and ( AllInOneInventory_ExcludeSlots[bag] ) then
			local n = 0;
			for k, v in AllInOneInventory_ExcludeSlots[bag] do
				n = n + 1;
			end
			slots = slots - n;
		end
	end
	return slots;
end

AllInOneInventory_GetBags_Table = {};

function AllInOneInventory_GetBags()
	local bag = 0;
	local bags = AllInOneInventory_GetBags_Table;
	for bag = 0, 4 do
		bags[bag] = AllInOneInventory_GetNumberOfSlotsInBag(bag);
	end
	return bags;
end

function AllInOneInventory_GetBagsTotalSlots()
	local bags = AllInOneInventory_GetBags();
	local slots = 0;
	for k, v in bags do
		slots = slots + v;
	end
	return slots;
end

function AllInOneInventory_GetIdAsBagSlot(id)
	if ( not id ) then
		--return 0, 1;
		return nil, nil;
	end
	local bagSlots = AllInOneInventory_GetBags();
	local leftId = id;
	local curSlots = 0;
	local bag, slots;
	local ok = true;
	local bag = 0;
	if ( AllInOneInventory_SwapBagOrder == 1 ) then
		bag = 4;
	end
	while ( ok ) do
		curSlots = bagSlots[bag];
		if ( not curSlots ) then
			curSlots = 0;
		end
		if ( leftId - curSlots <= 0 ) then
			if ( AllInOneInventory_ExcludeSlots[bag] ) then
				for i = 1, leftId do
					if ( AllInOneInventory_ExcludeSlots[bag][i] ) then
						leftId = leftId + 1;
					end
				end
			end
			return bag, leftId;
		else
			leftId = leftId - curSlots;
		end
		if ( AllInOneInventory_SwapBagOrder == 1 ) then
			bag = bag - 1;
			if ( bag < 0 ) then
				ok = false;
			end
		else
			bag = bag + 1;
			if ( bag > 4 ) then
				ok = false;
			end
		end
	end
	return -1, -1;
end

function AllInOneInventory_CommandUsage()
	for k, v in ALLINONEINVENTORY_CHAT_COMMAND_USAGE do
		AllInOneInventory_Print(v);
	end
end

-- Handles chat - e.g. slashcommands - enabling/disabling the AllInOneInventory
function AllInOneInventory_Main_ChatCommandHandler(msg)

	local func = AllInOneInventory_Toggle_Enabled;

	local toggleFunc = true;

	if ( ( not msg) or ( strlen(msg) <= 0 ) ) then
		AllInOneInventory_CommandUsage();
		return;
	end

	local commandName, params = AllInOneInventory_Extract_NextParameter(msg);

	if ( ( commandName ) and ( strlen(commandName) > 0 ) ) then
		commandName = string.lower(commandName);
	else
		commandName = "";
	end

	if ( strfind( commandName, "state" ) ) then
		func = AllInOneInventory_Toggle_Enabled;
	elseif ( ( ( strfind( commandName, "togglebag" ) ) ) ) then
		local bagNumber;
		bagNumber, params = AllInOneInventory_Extract_NextParameter(params);
		func = nil;
		bagNumber = tonumber(bagNumber);
		if ( bagNumber ) then
			local str = AllInOneInventory_BagStringIndex[bagNumber];
			if ( str ) then
				func = getglobal(format("AllInOneInventory_Toggle_IncludeBag%s", str));
			end
		end
		if ( func ) then
			func(-1);
		else
			AllInOneInventory_Print(ALLINFOURINVENTORY_CHAT_NO_SUCH_BAGNUMBER);
		end
		return;
	elseif ( ( ( strfind( commandName, "toggleslot" ) ) ) ) then
		local bagNumber;
		local slotNumber;
		bagNumber, params = AllInOneInventory_Extract_NextParameter(params);
		slotNumber, params = AllInOneInventory_Extract_NextParameter(params);
		return AllInOneInventory_Toggle_ExcludedSlot(bagNumber, slotNumber);
	elseif ( ( strfind( commandName, "swap" ) ) or ( ( strfind( commandName, "order" ) ) ) ) then
		func = AllInOneInventory_Toggle_SwapBagOrder;
		toggleFunc = false;
	elseif ( ( ( strfind( commandName, "toggle" ) ) ) ) then
		func = ToggleAllInOneInventoryFrame;
		toggleFunc = false;
	elseif ( ( strfind( commandName, "show" ) ) ) then
		func = OpenAllInOneInventoryFrame;
		toggleFunc = false;
	elseif ( ( strfind( commandName, "hide" ) ) ) then
		func = CloseAllInOneInventoryFrame;
		toggleFunc = false;
	elseif ( ( strfind( commandName, "replacebag" ) ) or ( ( strfind( commandName, "hijackbag" ) ) ) ) then
		func = AllInOneInventory_Toggle_ReplaceBags;
	elseif ( strfind( commandName, "include" ) ) then
		func = AllInOneInventory_Toggle_IncludeShotBags;
	elseif ( strfind( commandName, "reset" ) ) then
		func = AllInOneInventoryFrame_ResetButton;
		func();
		AllInOneInventory_Print(TEXT(ALLINONEINVENTORY_CHAT_RESETPOSITION));
		return;
	elseif ( ( strfind( commandName, "setcols" ) ) or ( ( strfind( commandName, "cols" ) ) ) or ( ( strfind( commandName, "column" ) ) ) ) then
		func = AllInOneInventory_Change_Columns;
		toggleFunc = false;
		local cols = 0;
		cols, params = AllInOneInventory_Extract_NextParameter(params);
		cols = tonumber(cols);
		if ( not cols ) then
			AllInOneInventory_CommandUsage();
			return;
		else
			return func(1, cols);
		end
	elseif ( strfind( commandName, "alpha" ) ) then
		func = AllInOneInventory_Change_Alpha;
		toggleFunc = false;
		local cols = 0;
		cols, params = AllInOneInventory_Extract_NextParameter(params);
		cols = tonumber(cols);
		if ( not cols ) then
			AllInOneInventory_CommandUsage();
			return;
		else
			return func(1, cols);
		end
	elseif ( strfind( commandName, "scale" ) ) or ( strfind( commandName, "size" ) ) then
		func = AllInOneInventory_Change_Scale;
		toggleFunc = false;
		local cols = 0;
		cols, params = AllInOneInventory_Extract_NextParameter(params);
		cols = tonumber(cols);
		if ( not cols ) then
			AllInOneInventory_CommandUsage();
			return;
		else
			return func(1, cols);
		end
	else
		AllInOneInventory_CommandUsage();
		return;
	end

	if ( toggleFunc ) then
		-- Toggle appropriately
		if ( (string.find(params, 'on')) or ((string.find(params, '1')) and (not string.find(params, '-1')) ) ) then
			func(1);
		else
			if ( (string.find(params, 'off')) or (string.find(params, '0')) ) then
				func(0);
			else
				func(-1);
			end
		end
	else
		func();
	end
end

function UseAllInOneInventoryItem(id)
	local b,s = AllInOneInventory_GetIdAsBagSlot(id);
	if ( ( b > -1 ) and ( s > -1 ) ) then
		return AllInOneInventory_Saved_UseContainerItem(b, s);
	end
	return false;
end

-- Does things with the hooked function
function AllInOneInventory_UseContainerItem(bag, slot)
	if ( not slot ) then
		local b,s = AllInOneInventory_GetIdAsBagSlot(bag);
		if ( ( b > -1 ) and ( s > -1 ) ) then
			return AllInOneInventory_Saved_UseContainerItem(b, s);
		end
	end
	return AllInOneInventory_Saved_UseContainerItem(bag, slot);
end

AllInOneInventory_ContainerFrames = {
	[1] = "ContainerFrame1",
	[2] = "ContainerFrame2",
	[3] = "ContainerFrame3",
	[4] = "ContainerFrame4",
	[5] = "ContainerFrame5",
	[6] = "ContainerFrame6",
	[7] = "ContainerFrame7",
	[8] = "ContainerFrame8",
	[9] = "ContainerFrame9",
	[10] = "ContainerFrame10",
	[11] = "ContainerFrame11",
};

function AllInOneInventory_ToggleBackpack()
	if ( AllInOneInventory_ReplaceBags == 1 ) then
		if ( AllInOneInventoryFrame:IsVisible() ) then
			local frame = nil;
			local frameName = nil;
			for i=1, NUM_CONTAINER_FRAMES, 1 do
				frameName = AllInOneInventory_ContainerFrames[i];
				if ( not frameName ) then frameName = "ContainerFrame"..i; end
				frame = getglobal(frameName);
				if ( frame:IsVisible() ) then
					frame:Hide();
				end
			end
			CloseAllInOneInventoryFrame();
		else
			OpenAllInOneInventoryFrame();
		end
	else
		AllInOneInventory_Saved_ToggleBackpack()
	end
	AllInOneInventory_UpdateBagState();
end

function AllInOneInventory_BagSlotButton_OnClick()
	AllInOneInventory_Saved_BagSlotButton_OnClick()
	AllInOneInventory_UpdateBagState();
end

function AllInOneInventory_BagSlotButton_OnDrag()
	AllInOneInventory_Saved_BagSlotButton_OnDrag()
	AllInOneInventory_UpdateBagState();
end

function AllInOneInventory_BackpackButton_OnClick()
	AllInOneInventory_Saved_BackpackButton_OnClick()
	AllInOneInventory_UpdateBagState();
end

function AllInOneInventory_OpenBackpack()
	if ( AllInOneInventory_ReplaceBags == 1 ) then
		OpenAllInOneInventoryFrame();
		return;
	end
	AllInOneInventory_Saved_OpenBackpack();
	AllInOneInventory_UpdateBagState();
end

function AllInOneInventory_CloseBackpack()
	if ( AllInOneInventory_ReplaceBags == 1 ) then
		CloseAllInOneInventoryFrame();
		return;
	end
	AllInOneInventory_Saved_CloseBackpack();
	AllInOneInventory_UpdateBagState();
end

function AllInOneInventory_IsShotBag(bag)
	if ( bag < 0 ) or ( bag > 4 ) then
		return false;
	end
	local name = "MainMenuBarBackpackButton";
	if ( bag > 0 ) then
		name = "CharacterBag"..(bag-1).."Slot";
	end
	local objCount = getglobal(name.."Count");
	if ( objCount ) and ( objCount:IsVisible() ) then
		local tmp = objCount:GetText();
		if ( ( tmp ) and ( strlen(tmp) > 0) ) then
			return true;
		end
	end
	return false;
end

function AllInOneInventory_ShouldIncludeBag(bag)
	if ( ( bag >= 0 ) and ( bag <= 4 ) ) then
		if ( getglobal(AllInOneInventory_BagsToInclude[bag]) ~= 1 ) then
			return false;
		end
		if ( ( AllInOneInventory_IncludeShotBags == 1 ) or ( not AllInOneInventory_IsShotBag(bag) ) ) then
			return true;
		else
			return false;
		end
		return true;
	end
	return false;
end


function AllInOneInventory_ShouldOverrideBag(bag)
	if ( AllInOneInventory_ReplaceBags == 1 ) then
		if ( AllInOneInventory_ShouldIncludeBag(bag) ) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

function AllInOneInventory_ToggleBag(bag)
	if ( AllInOneInventory_ShouldOverrideBag(bag) ) then
		ToggleAllInOneInventoryFrame();
		return;
	else
		AllInOneInventory_Saved_ToggleBag(bag);
		AllInOneInventory_UpdateBagState();
	end
end

function AllInOneInventory_CloseBag(bag)
	if ( AllInOneInventory_ShouldOverrideBag(bag) ) then
		return;
	else
		AllInOneInventory_Saved_CloseBag(bag);
		AllInOneInventory_UpdateBagState();
	end
end

function AllInOneInventory_OpenBag(bag)
	if ( AllInOneInventory_ShouldOverrideBag(bag) ) then
		return;
	else
		AllInOneInventory_Saved_OpenBag(bag)
		AllInOneInventory_UpdateBagState();
	end
end

-- Hooks/unhooks functions. If toggle is 1, hooks functions, otherwise it unhooks functions.
--  Hooking functions mean that you replace them with your own functions and then call the
--  original function at your leisure.
function AllInOneInventory_Setup_Hooks(toggle)
	if ( toggle == 1 ) then
		if ( DepositBox_RefreshWindows ) and ( AllInOneInventory_Saved_DepositBox_RefreshWindows ~= DepositBox_RefreshWindows ) and ( AllInOneInventory_Saved_DepositBox_RefreshWindows == nil ) then
			AllInOneInventory_Saved_DepositBox_RefreshWindows = DepositBox_RefreshWindows;
			DepositBox_RefreshWindows = AllInOneInventory_DepositBox_RefreshWindows;
		end
		if ( SellValue_OnShow ) and ( SellValue_OnShow ~= AllInOneInventory_SellValue_OnShow ) and (AllInOneInventory_Saved_SellValue_OnShow == nil) then
			AllInOneInventory_Saved_SellValue_OnShow = SellValue_OnShow;
			SellValue_OnShow = AllInOneInventory_SellValue_OnShow;
		end
		if ( ( UseContainerItem ~= AllInOneInventory_UseContainerItem ) and (AllInOneInventory_Saved_UseContainerItem == nil) ) then
			AllInOneInventory_Saved_UseContainerItem = UseContainerItem;
			UseContainerItem = AllInOneInventory_UseContainerItem;
		end
		if ( ( ToggleBag ~= AllInOneInventory_ToggleBag ) and (AllInOneInventory_Saved_ToggleBag == nil) ) then
			AllInOneInventory_Saved_ToggleBag = ToggleBag;
			ToggleBag = AllInOneInventory_ToggleBag;
		end
		if ( ( CloseBag ~= AllInOneInventory_CloseBag ) and (AllInOneInventory_Saved_CloseBag == nil) ) then
			AllInOneInventory_Saved_CloseBag = CloseBag;
			CloseBag = AllInOneInventory_CloseBag;
		end
		if ( ( OpenBag ~= AllInOneInventory_OpenBag ) and (AllInOneInventory_Saved_OpenBag == nil) ) then
			AllInOneInventory_Saved_OpenBag = OpenBag;
			OpenBag = AllInOneInventory_OpenBag;
		end
		if ( ( ToggleBackpack ~= AllInOneInventory_ToggleBackpack ) and (AllInOneInventory_Saved_ToggleBackpack == nil) ) then
			AllInOneInventory_Saved_ToggleBackpack = ToggleBackpack;
			ToggleBackpack = AllInOneInventory_ToggleBackpack;
		end
		if ( ( CloseBackpack ~= AllInOneInventory_CloseBackpack ) and (AllInOneInventory_Saved_CloseBackpack == nil) ) then
			AllInOneInventory_Saved_CloseBackpack = CloseBackpack;
			CloseBackpack = AllInOneInventory_CloseBackpack;
		end
		if ( ( OpenBackpack ~= AllInOneInventory_OpenBackpack ) and (AllInOneInventory_Saved_OpenBackpack == nil) ) then
			AllInOneInventory_Saved_OpenBackpack = OpenBackpack;
			OpenBackpack = AllInOneInventory_OpenBackpack;
		end
		if ( ( BagSlotButton_OnClick ~= AllInOneInventory_BagSlotButton_OnClick ) and (AllInOneInventory_Saved_BagSlotButton_OnClick == nil) ) then
			AllInOneInventory_Saved_BagSlotButton_OnClick = BagSlotButton_OnClick;
			BagSlotButton_OnClick = AllInOneInventory_BagSlotButton_OnClick;
		end
		if ( ( BagSlotButton_OnDrag ~= AllInOneInventory_BagSlotButton_OnDrag ) and (AllInOneInventory_Saved_BagSlotButton_OnDrag == nil) ) then
			AllInOneInventory_Saved_BagSlotButton_OnDrag = BagSlotButton_OnDrag;
			BagSlotButton_OnDrag = AllInOneInventory_BagSlotButton_OnDrag;
		end
		if ( ( BackpackButton_OnClick ~= AllInOneInventory_BackpackButton_OnClick ) and (AllInOneInventory_Saved_BackpackButton_OnClick == nil) ) then
			AllInOneInventory_Saved_BackpackButton_OnClick = BackpackButton_OnClick;
			BackpackButton_OnClick = AllInOneInventory_BackpackButton_OnClick;
		end
		if ( ( CloseAllWindows ~= AllInOneInventory_CloseAllWindows ) and (AllInOneInventory_Saved_CloseAllWindows == nil) ) then
			AllInOneInventory_Saved_CloseAllWindows = CloseAllWindows;
			CloseAllWindows = AllInOneInventory_CloseAllWindows;
		end
		if ( ( OpenAllBags ~= AllInOneInventory_OpenAllBags ) and (AllInOneInventory_Saved_OpenAllBags == nil) ) then
			AllInOneInventory_Saved_OpenAllBags = OpenAllBags;
			OpenAllBags = AllInOneInventory_OpenAllBags;
		end
	else
		if ( DepositBox_RefreshWindows == AllInOneInventory_Saved_DepositBox_RefreshWindows ) then
			AllInOneInventory_Saved_DepositBox_RefreshWindows = DepositBox_RefreshWindows;
			DepositBox_RefreshWindows = AllInOneInventory_DepositBox_RefreshWindows;
		end
		if ( SellValue_OnShow == AllInOneInventory_SellValue_OnShow) then
			SellValue_OnShow = AllInOneInventory_Saved_SellValue_OnShow;
			AllInOneInventory_Saved_SellValue_OnShow = nil;
		end
		if ( UseContainerItem == AllInOneInventory_UseContainerItem) then
			UseContainerItem = AllInOneInventory_Saved_UseContainerItem;
			AllInOneInventory_Saved_UseContainerItem = nil;
		end
		if ( ToggleBag == AllInOneInventory_ToggleBag) then
			ToggleBag = AllInOneInventory_Saved_ToggleBag;
			AllInOneInventory_Saved_ToggleBag = nil;
		end
		if ( CloseBag == AllInOneInventory_CloseBag) then
			CloseBag = AllInOneInventory_Saved_CloseBag;
			AllInOneInventory_Saved_CloseBag = nil;
		end
		if ( OpenBag == AllInOneInventory_OpenBag) then
			OpenBag = AllInOneInventory_Saved_OpenBag;
			AllInOneInventory_Saved_OpenBag = nil;
		end
		if ( ToggleBackpack == AllInOneInventory_ToggleBackpack) then
			ToggleBackpack = AllInOneInventory_Saved_ToggleBackpack;
			AllInOneInventory_Saved_ToggleBackpack = nil;
		end
		if ( CloseBackpack == AllInOneInventory_CloseBackpack) then
			CloseBackpack = AllInOneInventory_Saved_CloseBackpack;
			AllInOneInventory_Saved_CloseBackpack = nil;
		end
		if ( OpenBackpack == AllInOneInventory_OpenBackpack) then
			OpenBackpack = AllInOneInventory_Saved_OpenBackpack;
			AllInOneInventory_Saved_OpenBackpack = nil;
		end
		if ( BagSlotButton_OnClick == AllInOneInventory_BagSlotButton_OnClick) then
			BagSlotButton_OnClick = AllInOneInventory_Saved_BagSlotButton_OnClick;
			AllInOneInventory_Saved_BagSlotButton_OnClick = nil;
		end
		if ( BagSlotButton_OnDrag == AllInOneInventory_BagSlotButton_OnDrag) then
			BagSlotButton_OnDrag = AllInOneInventory_Saved_BagSlotButton_OnDrag;
			AllInOneInventory_Saved_BagSlotButton_OnDrag = nil;
		end
		if ( BackpackButton_OnClick == AllInOneInventory_BackpackButton_OnClick) then
			BackpackButton_OnClick = AllInOneInventory_Saved_BackpackButton_OnClick;
			AllInOneInventory_Saved_BackpackButton_OnClick = nil;
		end
		if ( CloseAllWindows == AllInOneInventory_CloseAllWindows) then
			CloseAllWindows = AllInOneInventory_Saved_CloseAllWindows;
			AllInOneInventory_Saved_CloseAllWindows = nil;
		end
		if ( OpenAllBags == AllInOneInventory_OpenAllBags) then
			OpenAllBags = AllInOneInventory_Saved_OpenAllBags;
			AllInOneInventory_Saved_OpenAllBags = nil;
		end
	end
end

-- Handles events
function AllInOneInventoryScriptFrame_OnEvent(event)
	if ( event == "PLAYER_LOGIN" ) then
		local value = getglobal("AllInOneInventory_Enabled");
		if (value == nil ) then
			-- defaults to off
			value = 0;
		end
		AllInOneInventory_Toggle_Enabled(value);
		local value = getglobal("AllInOneInventory_ReplaceBags");
		if (value == nil ) then
			-- defaults to off
			value = 0;
		end
		AllInOneInventory_Toggle_ReplaceBags(value);
		local value = getglobal("AllInOneInventory_SwapBagOrder");
		if (value == nil ) then
			-- defaults to off
			value = 0;
		end
		AllInOneInventory_Toggle_SwapBagOrder(value);
		local value = getglobal("AllInOneInventory_Alpha");
		if (value == nil ) then
			-- defaults to off
			value = 0;
		end
		AllInOneInventory_Change_Alpha(1, value);
		local value = getglobal("AllInOneInventory_Scale");
		if (value == nil ) then
			-- defaults to off
			value = 0;
		end
		AllInOneInventory_Change_Scale(1, value);
		local value = getglobal("AllInOneInventory_IncludeShotBags");
		if (value == nil ) then
			-- defaults to off
			value = 1;
		end
		AllInOneInventory_Toggle_IncludeShotBags(value);
		local value = getglobal("AllInOneInventory_Columns");
		if (value == nil ) or ( value <= 0 ) then
			-- defaults to 8
			value = ALLINONEINVENTORY_NUM_COLUMNS;
		end
		AllInOneInventory_Change_Columns(1, value);
		local func = nil;
		for k, v in AllInOneInventory_BagStringIndex do
			func = getglobal(string.format("AllInOneInventory_Toggle_IncludeBag%s", v));
			value = getglobal(string.format("AllInOneInventory_IncludeBag%s", v));
			if ( not value ) then
				value = 1;
			end
			if ( func ) then
				func(value);
			end
		end
		local value = AllInOneInventory_Locked;
		if ( not value ) or ( value <= 0 ) then
			-- defaults to off
			value = 0;
		end
		AllInOneInventory_Toggle_Locked(value);
	elseif ( event == "ADDON_LOADED" ) then
		if ( IsAddOnLoaded("DepositBox") ) then
		end
		AllInOneInventory_Setup_Hooks(1);
	end
end

-- Toggles the enabled/disabled state of an option and returns the new state
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function AllInOneInventory_Generic_Toggle(toggle, variableName, enableMessage, disableMessage, CosmosVarName)
	local oldvalue = getglobal(variableName);
	local newvalue = toggle;
	if ( ( toggle ~= 1 ) and ( toggle ~= 0 ) ) then
		if (oldvalue == 1) then
			newvalue = 0;
		elseif ( oldvalue == 0 ) then
			newvalue = 1;
		else
			newvalue = 0;
		end
	end
	setglobal(variableName, newvalue);
	if ( newvalue ~= oldvalue ) then
		local text = "";
		if ( newvalue == 1 ) then
			if ( enableMessage ) then
				text = TEXT(getglobal(enableMessage));
			end
		else
			if ( disableMessage ) then
				text = TEXT(getglobal(disableMessage));
			end
		end
		if ( text ) and ( strlen(text) > 0 ) then
			AllInOneInventory_Print(text);
		end
	end
	return newvalue;
end

-- Toggles the enabled/disabled state of the AllInOneInventory
--  if toggle is 1, it's enabled
--  if toggle is 0, it's disabled
--   otherwise, it's toggled
function AllInOneInventory_Toggle_Enabled(toggle)
	AllInOneInventory_DoToggle_Enabled(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_Enabled(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_Enabled", "ALLINONEINVENTORY_CHAT_ENABLED", "ALLINONEINVENTORY_CHAT_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_Enabled");
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_Enabled_NoChat(toggle)
	AllInOneInventory_DoToggle_Enabled(toggle, false);
end

function AllInOneInventory_Toggle_Enabled(toggle)
	AllInOneInventory_DoToggle_Enabled(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_ReplaceBags(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_ReplaceBags", "ALLINONEINVENTORY_CHAT_REPLACEBAGS_ENABLED", "ALLINONEINVENTORY_CHAT_REPLACEBAGS_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_ReplaceBags");
	end
	if ( newvalue == 1 ) then
		AllInOneInventory_Saved_CloseBackpack();
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_ReplaceBags_NoChat(toggle)
	AllInOneInventory_DoToggle_ReplaceBags(toggle, false);
end

function AllInOneInventory_Toggle_ReplaceBags(toggle)
	AllInOneInventory_DoToggle_ReplaceBags(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_IncludeShotBags(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeShotBags", "ALLINONEINVENTORY_CHAT_INCLUDE_SHOTBAGS_ENABLED", "ALLINONEINVENTORY_CHAT_INCLUDE_SHOTBAGS_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeShotBags");
	end
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_Update(frame);
		AllInOneInventory_UpdateBagState();
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_IncludeShotBags_NoChat(toggle)
	AllInOneInventory_DoToggle_IncludeShotBags(toggle, false);
end

function AllInOneInventory_Toggle_IncludeShotBags(toggle)
	AllInOneInventory_DoToggle_IncludeShotBags(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_IncludeBagZero(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagZero", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGZERO_ENABLED", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGZERO_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagZero");
	end
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_Update(frame);
		AllInOneInventory_UpdateBagState();
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_IncludeBagZero_NoChat(toggle)
	AllInOneInventory_DoToggle_IncludeBagZero(toggle, false);
end

function AllInOneInventory_Toggle_IncludeBagZero(toggle)
	AllInOneInventory_DoToggle_IncludeBagZero(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_IncludeBagOne(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagOne", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGONE_ENABLED", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGONE_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagOne");
	end
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_Update(frame);
		AllInOneInventory_UpdateBagState();
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_IncludeBagOne_NoChat(toggle)
	AllInOneInventory_DoToggle_IncludeBagOne(toggle, false);
end

function AllInOneInventory_Toggle_IncludeBagOne(toggle)
	AllInOneInventory_DoToggle_IncludeBagOne(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_IncludeBagTwo(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagTwo", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGTWO_ENABLED", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGTWO_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagTwo");
	end
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_Update(frame);
		AllInOneInventory_UpdateBagState();
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_IncludeBagTwo_NoChat(toggle)
	AllInOneInventory_DoToggle_IncludeBagTwo(toggle, false);
end

function AllInOneInventory_Toggle_IncludeBagTwo(toggle)
	AllInOneInventory_DoToggle_IncludeBagTwo(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_IncludeBagThree(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagThree", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGTHREE_ENABLED", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGTHREE_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagThree");
	end
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_Update(frame);
		AllInOneInventory_UpdateBagState();
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_IncludeBagThree_NoChat(toggle)
	AllInOneInventory_DoToggle_IncludeBagThree(toggle, false);
end

function AllInOneInventory_Toggle_IncludeBagThree(toggle)
	AllInOneInventory_DoToggle_IncludeBagThree(toggle, true);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_IncludeBagFour(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagFour", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGFOUR_ENABLED", "ALLINONEINVENTORY_CHAT_INCLUDE_BAGFOUR_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_IncludeBagFour");
	end
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_Update(frame);
		AllInOneInventory_UpdateBagState();
	end
end

-- toggling - no text
function AllInOneInventory_Toggle_IncludeBagFour_NoChat(toggle)
	AllInOneInventory_DoToggle_IncludeBagFour(toggle, false);
end

function AllInOneInventory_Toggle_IncludeBagFour(toggle)
	AllInOneInventory_DoToggle_IncludeBagFour(toggle, true);
end


function AllInOneInventory_Generic_Number(value, variableName, message, formatValueMessage)
	local oldvalue = getglobal(variableName);
	local newvalue = value;
	if ( type(newvalue) ~= "number" ) then
		newvalue = tonumber(oldvalue);
		if ( not newvalue ) then
			return;
		end
	end
	setglobal(variableName, newvalue);
	if ( newvalue ~= oldvalue ) then
		local text = nil;
		if ( formatValueMessage ) then
			text = format(TEXT(getglobal(formatValueMessage)), newvalue);
		elseif ( message ) then
			text = TEXT(getglobal(formatValueMessage));
		end
		if ( text ) and ( strlen(text) > 0 ) then
			AllInOneInventory_Print(text);
		end
	end
	return newvalue;
end

function AllInOneInventory_Generic_Value(value, variableName, message, formatValueMessage)
	local oldvalue = getglobal(variableName);
	local newvalue = value;
	setglobal(variableName, newvalue);
	if ( newvalue ~= oldvalue ) then
		local text = nil;
		if ( formatValueMessage ) then
			text = format(TEXT(getglobal(formatValueMessage)), newvalue);
		elseif ( message ) then
			text = TEXT(getglobal(formatValueMessage));
		end
		if ( text ) and ( strlen(text) > 0 ) then
			AllInOneInventory_Print(text);
		end
	end
	return newvalue;
end

-- does the actual setting
function AllInOneInventory_DoChange_Columns(value, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Number(value, "AllInOneInventory_Columns", nil, "ALLINONEINVENTORY_CHAT_COLUMNS_FORMAT");
	else
		newvalue = AllInOneInventory_Generic_Number(value, "AllInOneInventory_Columns");
	end
	AllInOneInventoryFrame_SetColumns(newvalue);
end

-- toggling - no text
function AllInOneInventory_Change_Columns_NoChat(toggle, value)
	AllInOneInventory_DoChange_Columns(value, false);
end

function AllInOneInventory_Change_Columns(toggle, value)
	AllInOneInventory_DoChange_Columns(value, true);
end

function AllInOneInventory_DoToggle_SwapBagOrder(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_SwapBagOrder", "ALLINONEINVENTORY_CHAT_SWAP_BAG_ORDER_ENABLED", "ALLINONEINVENTORY_CHAT_SWAP_BAG_ORDER_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_SwapBagOrder");
	end
end

function AllInOneInventory_Toggle_SwapBagOrder_NoChat(toggle)
	AllInOneInventory_DoToggle_SwapBagOrder(toggle, false);
end

function AllInOneInventory_Toggle_SwapBagOrder(toggle)
	AllInOneInventory_DoToggle_SwapBagOrder(toggle, true);
end


function AllInOneInventoryFrame_SetAlpha(alpha)
	if ( not alpha ) then
		return;
	end
	if ( type(alpha) ~= "number" ) then
		alpha = tonumber(alpha);
		if ( not alpha ) then
			return;
		end
	end
	if ( alpha > ALLINONEINVENTORY_ALPHA_MAX ) then
		alpha = ALLINONEINVENTORY_ALPHA_MAX;
	end
	if ( alpha <= ALLINONEINVENTORY_ALPHA_MIN ) then
		local parentAlpha = 1;
		if ( UIParent ) and ( UIParent.GetAlpha ) then
			parentAlpha = UIParent:GetAlpha();
			if ( not parentAlpha ) then
				parentAlpha = 1;
			end
		end
		if ( parentAlpha ) then
			alpha = parentAlpha;
		end
	end
	if ( not alpha ) then
		return;
	end
	AllInOneInventoryFrame:SetAlpha(alpha);
end


function AllInOneInventory_DoChange_Alpha(value, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Number(value, "AllInOneInventory_Alpha", nil, "ALLINONEINVENTORY_CHAT_ALPHA_FORMAT");
	else
		newvalue = AllInOneInventory_Generic_Number(value, "AllInOneInventory_Alpha");
	end
	AllInOneInventoryFrame_SetAlpha(newvalue);
end

-- toggling - no text
function AllInOneInventory_Change_Alpha_NoChat(toggle, value)
	AllInOneInventory_DoChange_Alpha(value, false);
end

function AllInOneInventory_Change_Alpha(toggle, value)
	AllInOneInventory_DoChange_Alpha(value, true);
end

function AllInOneInventoryFrame_SetScale(scale)
	if ( not scale ) then
		return;
	end
	if ( type(scale) ~= "number" ) then
		scale = tonumber(scale);
		if ( not scale ) then
			return;
		end
	end
	if ( scale > ALLINONEINVENTORY_SCALE_MAX ) then
		scale = ALLINONEINVENTORY_SCALE_MAX;
	end
	if ( scale <= ALLINONEINVENTORY_SCALE_MIN ) then
		scale = 1;
		-- Since patch 1.9, scales are relative to parent.
		-- The code block below is not necessary
		--[[
		local parentScale = 1;
		if ( UIParent ) and ( UIParent.GetScale ) then
			parentScale = UIParent:GetScale();
			if ( not parentScale ) then
				parentScale = 1;
			end
		end
		if ( parentScale ) then
			scale = parentScale;
		end
		]]--
	end
	if ( not scale ) then
		return;
	end
	AllInOneInventoryFrame:SetScale(scale);
end


function AllInOneInventory_DoChange_Scale(value, showText)
	local newvalue = 1;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Number(value, "AllInOneInventory_Scale", nil, "ALLINONEINVENTORY_CHAT_SCALE_FORMAT");
	else
		newvalue = AllInOneInventory_Generic_Number(value, "AllInOneInventory_Scale");
	end
	AllInOneInventoryFrame_SetScale(newvalue);
end

-- toggling - no text
function AllInOneInventory_Change_Scale_NoChat(toggle, value)
	AllInOneInventory_DoChange_Scale(value, false);
end

function AllInOneInventory_Change_Scale(toggle, value)
	AllInOneInventory_DoChange_Scale(value, true);
end


-- Prints out text to a chat box.
function AllInOneInventory_Print(msg,r,g,b,frame,id,unknown4th)
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 0.0; end
	if ( Print ) then
		Print(msg, r, g, b, frame, id, unknown4th);
		return;
	end
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end

	if ( frame ) then
		frame:AddMessage(msg,r,g,b,id,unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id,unknown4th);
		end
	end
end

function AllInOneInventory_IsBagOpen(id)
	local formatStr = "ContainerFrame%d";
	local frame = nil;
	for i = 1, NUM_CONTAINER_FRAMES do
		frame = getglobal(format(formatStr, i));
		if ( ( frame ) and ( frame:IsVisible() ) and ( frame:GetID() == id ) ) then
			return true;
		end
	end
	return false;
end

function AllInOneInventory_GetBagState(bag, baseToggle)
	if ( AllInOneInventory_ShouldOverrideBag(bag) ) then
		local toggle = (AllInOneInventory_IsBagOpen(bag) or baseToggle);
		if ( ( toggle == true ) or ( toggle == 1 ) ) then
			return 1;
		else
			return 0;
		end
	else
		if ( AllInOneInventory_IsBagOpen(bag) ) then
			return 1;
		else
			return 0;
		end
	end
end

function AllInOneInventory_UpdateBagState()
	local shouldBeChecked = AllInOneInventoryFrame:IsVisible();
	MainMenuBarBackpackButton:SetChecked(AllInOneInventory_GetBagState(0, shouldBeChecked));
	local bagButton = nil;
	local formatStr = "CharacterBag%dSlot";
	for i = 0, 3 do
		bagButton = getglobal(format(formatStr, i));
		if ( bagButton ) then
			bagButton:SetChecked(AllInOneInventory_GetBagState(i+1, shouldBeChecked));
		end
	end
end

function ToggleAllInOneInventoryFrame()
	if ( AllInOneInventoryFrame:IsVisible() ) then
		CloseAllInOneInventoryFrame();
	else
		OpenAllInOneInventoryFrame();
	end
	AllInOneInventory_UpdateBagState();
end


function AllInOneInventory_CloseAllWindows(ignoreCenter)
	local wasVisible = AllInOneInventoryFrame:IsVisible();
	CloseAllInOneInventoryFrame();
	local realClosed = nil;
	if ( arg ) then
		realClosed = AllInOneInventory_Saved_CloseAllWindows(ignoreCenter);
	else
		realClosed = AllInOneInventory_Saved_CloseAllWindows();
	end
	if ( wasVisible ) then
		return 1;
	else
		return realClosed;
	end
end

function CloseAllInOneInventoryFrame()
	local value = false;
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) and ( frame:IsVisible() ) then
		frame:Hide();
		value = true;
	end
	AllInOneInventory_UpdateBagState();
	return value;
end

function OpenAllInOneInventoryFrame()
	local value = false;
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_Update(frame);
		if ( not frame:IsVisible() ) then
			frame:Show();
			value = true;
		end
	end
	AllInOneInventory_UpdateBagState();
	return value;
end

function AllInOneInventoryFrame_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	--DynamicData.item.addOnInventoryUpdateHandler(AllInOneInventoryFrame_OnInventoryUpdate);
	--DynamicData.item.addOnInventoryCooldownUpdateHandler(AllInOneInventoryFrame_OnInventoryCooldownUpdate);
end

AllInOneInventoryFrame_LastInventoryUpdate = {};
ALLINONEINVENTORYFRAME_UPDATE_DELAY = 1;

function AllInOneInventoryFrame_OnInventoryUpdate(bag, scanType)
	local curTime = GetTime();
	local qwe = AllInOneInventoryFrame_LastInventoryUpdate[scanType];
	if ( not qwe ) then
		qwe = 0;
	end
	local fixTime = ALLINONEINVENTORYFRAME_UPDATE_DELAY - (curTime - qwe);
	if ( fixTime <= 0 ) then
		fixTime = 0.01;
	end
	AIOI_ScheduleByName("AIOI_INV_UPDATE_"..scanType, fixTime, AllInOneInventoryFrame_DoInventoryUpdate, bag, scanType);
end

function AllInOneInventoryFrame_DoInventoryUpdate(bag, scanType)
	AllInOneInventoryFrame_LastInventoryUpdate[scanType] = GetTime();
	local frame = getglobal("AllInOneInventoryFrame");
	local func = nil;
	if ( scanType ) then
		if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_COOLDOWN ) > 0 ) then
			func = getglobal("AllInOneInventoryFrame_UpdateAllCooldowns");
		end
		if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_ITEMINFO ) > 0 ) then
			func = getglobal("AllInOneInventoryFrame_Update");
		end
	else
		func = getglobal("AllInOneInventoryFrame_Update");
	end
	if ( ( frame ) and ( frame:IsVisible() ) ) then
		if ( func ) then
			func(frame);
		end
	end
end

function AllInOneInventoryFrame_OnInventoryCooldownUpdate()
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventoryFrame_UpdateAllCooldowns(frame);
		if ( frame:IsVisible() ) then
			--AllInOneInventoryFrame_Update(frame);
		end
	end
end


function AllInOneInventoryFrame_OnEvent(event)
end

function AllInOneInventoryFrame_OnHide()
	PlaySound("igBackPackClose");
	AllInOneInventory_StopMoving(this);
end

function AllInOneInventoryFrame_OnShow()
	AllInOneInventoryFrame_Update(this);
	PlaySound("igBackPackOpen");
end

function AllInOneInventoryFrame_UpdateAllCooldowns(frame)
	local name = frame:GetName();
	local itemInfo;
	local itemButton;
	local bag, slot;
	for buttonID = 1, ALLINONEINVENTORY_MAXIMUM_NUMBER_OF_BUTTONS do
		itemButton = getglobal(name.."Item"..buttonID);
		if ( itemButton ) and ( itemButton:IsVisible() ) then
			bag, slot = AllInOneInventory_GetIdAsBagSlot(itemButton:GetID());
			itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
			if ( ( itemInfo ) and ( itemInfo.t ) and ( strlen(itemInfo.t) > 0 ) ) then
				AllInOneInventoryFrame_UpdateCooldown(itemButton);
			end
		end
	end
end

function AllInOneInventoryFrame_UpdateButton(frame, buttonID)
	local name = frame:GetName();
	local itemButton = getglobal(name.."Item"..buttonID);

	if ( not itemButton ) or ( not itemButton:IsVisible() ) then
		return;
	end

	local bag, slot = AllInOneInventory_GetIdAsBagSlot(itemButton:GetID());
	if ( bag == -1 ) and ( slot == -1 ) then
		return;
	end

	local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);

	if ( not itemInfo ) then
		itemInfo = AllInOneInventoryItems_NoItem;
	end

	SetItemButtonTexture(itemButton, itemInfo.t);
	SetItemButtonCount(itemButton, itemInfo.c);

	SetItemButtonDesaturated(itemButton, itemInfo.l, 0.5, 0.5, 0.5);

	if ( ( itemInfo.t ) and ( strlen(itemInfo.t) > 0 ) ) then
		AllInOneInventoryFrame_UpdateCooldown(itemButton);
	else
		local cooldownFrame = getglobal(itemButton:GetName().."Cooldown");
		if ( cooldownFrame ) then
			cooldownFrame:Hide();
		end
	end

	local readable = itemInfo.r;
	--local normalTexture = getglobal(name.."Item"..j.."NormalTexture");
	--if ( quality and quality ~= -1) then
	--	local color = getglobal("ITEM_QUALITY".. quality .."_COLOR");
	--	normalTexture:SetVertexColor(color.r, color.g, color.b);
	--else
	--	normalTexture:SetVertexColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
	--end
	local showSell = nil;
	if ( GameTooltip:IsOwned(itemButton) ) then
		if ( itemInfo.t ) and ( strlen(itemInfo.t) > 0 ) then
			AllInOneInventory_Patching_Tooltip = 1;
			local hasCooldown, repairCost = GameTooltip:SetBagItem(bag, slot);
			if ( hasCooldown ) then
				itemButton.updateTooltip = TOOLTIP_UPDATE_TIME;
			else
				itemButton.updateTooltip = nil;
			end
			if ( ( InRepairMode() ) and ( repairCost ) and (repairCost > 0) ) then
				GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1);
				SetTooltipMoney(GameTooltip, repairCost);
				--GameTooltip:Show();
			elseif ( MerchantFrame:IsVisible() and not locked) then
				showSell = 1;
			end
			AllInOneInventory_ModifyItemTooltip(bag, slot, "GameTooltip");
			AllInOneInventory_Patching_Tooltip = 0;
		else
			GameTooltip:Hide();
		end
		if ( showSell ) then
			ShowContainerSellCursor(bag, slot);
		elseif ( readable ) then
			ShowInspectCursor();
		else
			ResetCursor();
		end
	end
end

function AllInOneInventoryFrame_Update(frame)
	if ( not AllInOneInventoryFrame_UpdateLookIfNeeded() ) then
		for j=1, frame.size, 1 do
			AllInOneInventoryFrame_UpdateButton(frame, j);
		end
	end
end

function AllInOneInventoryFrame_UpdateCooldown(button)
	local bag, slot = AllInOneInventory_GetIdAsBagSlot(button:GetID());
	if ( bag == -1 ) and ( slot == -1 ) then
		return;
	end

	local cooldownFrame = getglobal(button:GetName().."Cooldown");
	local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
	local start, duration, enable = 0, 0, 1;
	if ( itemInfo ) then
		start, duration, enable = itemInfo.cs, itemInfo.cd, itemInfo.ce;
	end
	CooldownFrame_SetTimer(cooldownFrame, start, duration, enable);
	if ( ( duration > 0 ) and ( enable == 0 ) ) then
		SetItemButtonTextureVertexColor(button, 0.4, 0.4, 0.4);
	end
end

function AllInOneInventoryFrameItemButton_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterForDrag("LeftButton");

	this.SplitStack = function(button, split)
		SplitContainerItem(button:GetParent():GetID(), button:GetID(), split);
	end
end

function AllInOneInventory_HandleQuickMount(bag, slot)
	if ( QuickMount_PickupItem ) then
		local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
		if ( itemInfo ) and ( itemInfo.t ) and ( strlen(itemInfo.t) >= 0 ) then
			QuickMount_PickupItem(bag, slot, itemInfo.n, itemInfo.t);
		end
	end
end

function AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift)
	local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());
	if ( LootDestroyer_DoItem_OnClick ) then
		if ( LootDestroyer_DoItem_OnClick(bag, slot, button, ignoreShift) ) then
			return;
		end
	end
	if ( button == "LeftButton" ) then
		if ( IsShiftKeyDown() and not ignoreShift ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(GetContainerItemLink(bag, slot));
			else
				local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
				if ( itemInfo ) and ( not itemInfo.l ) then
					this.SplitStack = function(button, split)
						SplitContainerItem(bag, slot, split);
					end
					OpenStackSplitFrame(this.count, this, "BOTTOMRIGHT", "TOPRIGHT");
				end
			end
		elseif ( IsControlKeyDown() ) then
			DressUpItemLink(GetContainerItemLink(bag, slot));
		else
			AllInOneInventory_HandleQuickMount(bag, slot);
			PickupContainerItem(bag, slot);
		end
	else
-- Modifier2Sell fixed by daun
		if ( MerchantFrame:IsVisible() ) and ( Modifier2Sell_BagSlotButton_OnClick ) then
			if ( not Modifier2Sell_BagSlotButton_OnClick(button, ignoreShift, bag, slot) ) then
				return;
			end
		end
		if ( IsControlKeyDown() and not ignoreShift ) then
			return;
		elseif ( IsShiftKeyDown() and MerchantFrame:IsVisible() and not ignoreShift ) then
			this.SplitStack = function(button, split)
				SplitContainerItem(bag, slot, split);
				MerchantItemButton_OnClick("LeftButton");
			end
			OpenStackSplitFrame(this.count, this, "BOTTOMRIGHT", "TOPRIGHT");
		elseif ( MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 2 ) then
			-- Don't sell the item if the buyback tab is selected
			return;
		else
			UseContainerItem(bag, slot);
			StackSplitFrame:Hide();
		end
   end 
end

function AllInOneInventoryFrameItemButton_OnEnter()
	AllInOneInventory_Patching_Tooltip = 1;
	local tooltip = GameTooltip;
	local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());

	local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
	if ( ( not itemInfo ) or ( not itemInfo.t ) or ( strlen(itemInfo.t) <= 0 ) ) then
		tooltip:Hide();
		return;
	end
	tooltip:SetOwner(this, "ANCHOR_LEFT");
	local hasCooldown, repairCost = GameTooltip:SetBagItem(bag, slot);
	if ( hasCooldown ) then
		this.updateTooltip = 1;
	else
		this.updateTooltip = nil;
	end
	if ( InRepairMode() and (repairCost and repairCost > 0) ) then
		tooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1);
		SetTooltipMoney(tooltip, repairCost);
		tooltip:Show();
	elseif ( MerchantFrame:IsVisible() ) then
		ShowContainerSellCursor(bag, slot);
		AllInOneInventoryFrame_RegisterCurrentTooltipSellValue(tooltip, bag, slot);
	elseif ( this.readable ) then
		ShowInspectCursor();
	end

	AllInOneInventory_ModifyItemTooltip(bag, slot, tooltip:GetName());
	AllInOneInventory_Patching_Tooltip = 0;
end

function AllInOneInventoryFrame_RegisterCurrentTooltipSellValue(tooltip, bag, slot)
	local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
	if ( not itemInfo ) or ( not itemInfo.n ) or ( strlen(itemInfo.n) <= 0 ) then
		return;
	end
	if ( SellValue_SaveFor ) then
		local moneyFrame = getglobal(tooltip:GetName().."MoneyFrame");
		if ( moneyFrame ) and ( moneyFrame:IsVisible() ) and ( moneyFrame.staticMoney ) then
			SellValue_SaveFor(bag, slot, itemInfo.n, moneyFrame.staticMoney);
		end
	end
	if ( LootLink_ProcessLinks ) then
		local link = GetContainerItemLink(bag, slot);
		local name = LootLink_ProcessLinks(link);
		if ( LootLink_VendorEntry_Hook ) then
			local moneyFrame = getglobal(tooltip:GetName().."MoneyFrame");
			if ( moneyFrame ) and ( moneyFrame:IsVisible() ) and ( moneyFrame.staticMoney ) then
				if ( itemInfo.c ) and ( itemInfo.c > 0 ) then
					local money = moneyFrame.staticMoney / itemInfo.c;
					if ( ItemLinks[name] ) then
						if ( not ItemLinks[name].price ) and ( not ItemLinks[name].p ) then
							ItemLinks[name].p = money;
						end
						--LootLink_VendorEntry_Hook(bag, slot, itemInfo.n, moneyFrame.staticMoney);
					end
				end
			else
				local stringFormat = tooltip:GetName().."TextLeft%d";
				local string = nil;
				local text = nil;
				for i = 2, 10 do
					string = getglobal(stringFormat, i);
					if ( string ) and ( string:IsVisible() ) then
						text = string:GetText();
						if ( text ) and ( text == TEXT(ITEM_UNSELLABLE) ) then
							if ( ItemLinks[name] ) and ( ( ItemLinks[name].p ) or ( ItemLinks[name].price ) )  then
								ItemLinks[name].p = nil;
								ItemLinks[name].price = nil;
							end
						end
					end
				end

			end
		end
	end
end

function AllInOneInventoryFrameItemButton_OnLeave()
	this.updateTooltip = nil;
	if ( GameTooltip:IsOwned(this) ) then
		GameTooltip:Hide();
		ResetCursor();
	end
end

-- modifies the tooltip
function AllInOneInventory_ModifyItemTooltip(bag, slot, tooltipName)
	if ( not tooltipName ) then
		tooltipName = "GameTooltip";
	end
	--AllInOneInventory_ReagentHelper_ModifyItemTooltip(bag, slot, tooltipName);
	AllInOneInventory_LootLink_ModifyItemTooltip(bag, slot, tooltipName);
	AllInOneInventory_SellValue_ModifyItemTooltip(bag, slot, tooltipName);
	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		return;
	end
	tooltip:Show();
end

function AllInOneInventory_SellValue_ModifyItemTooltip(bag, slot, tooltipName)
	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		return;
	end
	if ( not SellValue_AddMoneyToTooltip ) then
		return;
	end
	local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);

	if ( not SellValues ) or ( MerchantFrame:IsVisible() ) then
		return;
	end

	local itemName = nil;
	local itemCount = nil;
	if ( itemInfo ) then
		itemCount = itemInfo.c;
		if ( itemInfo.n ) then
			if ( InvList_ShortenItemName ) then
				itemName = InvList_ShortenItemName(itemInfo.n);
			else
				itemName = itemInfo.n;
			end
		end
	end
	if ( not itemName ) or ( strlen(itemName) <= 0 ) then
		return;
	end
	if ( IsAddOnLoaded("SellValue") ) then
		-- Don't add a tooltip for hidden items for SellValue
		if ( not InvList_TooltipMode ) or
			( ( InvList_TooltipMode == 1 ) and ( InvList_HiddenItems ) and ( InvList_HiddenItems[itemName] ) ) then
			return;
		end
	end

	local price = SellValues[itemName];

	if ( price ) then
		local linesAdded = 0;
		if ( price == 0 ) then
			local msg = NOSELLPRICE;
			if ( not msg ) then
				msg = ITEM_UNSELLABLE;
			end
			tooltip:AddLine(msg, 1.0, 1.0, 0);
			linesAdded = 1;
		else
			tooltip:AddLine(SELLVALUE_COST, 1.0, 1.0, 0);
			SetTooltipMoney(tooltip, price);
			linesAdded = 2;
		end  -- if price > 0

		-- Adjust width to account for new lines
		if ( tooltip:GetWidth() < 120 ) then tooltip:SetWidth(120); end
	end  -- if price
end

function AllInOneInventory_LootLink_ModifyItemTooltip(bag, slot, tooltipName)
	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		tooltip = getglobal("GameTooltip");
		tooltipName = "GameTooltip";
	end
	if ( not tooltip ) then
		return false;
	end
	local shouldModify = true;
	if ( ( InRepairMode() ) or
		( AllInOneInventory_ModifyTooltipsAtMerchant == 0 ) and ( MerchantFrame:IsVisible() ) ) then
		shouldModify = false;
	end
	if (
		( LootLink_AddExtraTooltipInfo ) and
		( shouldModify ) and ( ItemLinks ) ) then
		local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
		local name = nil;
		if ( itemInfo ) and ( itemInfo.n ) then
			name = itemInfo.n;
		end
		local data = ItemLinks[name];
		if ( ( not LootLinkState ) or ( not LootLinkState.HideInfo ) ) and ( name ) and ( data ) then
			if ( itemInfo ) and ( itemInfo.t ) then
				if ( AllInOneInventory_ShowPrice == 1 ) then
					local money = ItemLinks[name].p;
					if ( not money ) and ( ItemLinks[name].price ) then
						money = ItemLinks[name].price;
					end
					local stack = ItemLinks[name].x;
					if ( not stack ) and ( ItemLinks[name].stack ) then
						stack = ItemLinks[name].stack;
					end
					if ( money ) then
						AIOI_LootLink_SetTooltipMoney(tooltip, itemInfo.c, money, stack);
					end
				end
				LootLink_AddExtraTooltipInfo(tooltip, name, itemInfo.c, data);
				--tooltip:Show();
				if( tooltip == GameTooltip ) then
					GameTooltip.llDone = 1;
				end
			end
		end
	elseif ( ( LootLink_Tooltip_Hook ) and ( shouldModify ) and ( ItemLinks ) ) then
		local name = nil;
		local itemInfo = AllInOneInventoryItems_GetInfo(bag, slot);
		if ( itemInfo ) then
			name = itemInfo.n;
		end
		if ( itemInfo ) and ( name ) and ( strlen(name) > 0 ) and ( ItemLinks[name] ) then
			local data = ItemLinks[name];
			local money = 0;
			if ( data.p ) then
				money = data.p;
			elseif ( data.price ) then
				money = data.price;
			end
			if ( not money ) then money = 0; end
			local tooltip = getglobal(tooltipName);
			if ( not tooltip ) then
				return;
			end
			LootLink_Tooltip_Hook(tooltip, name, money, itemInfo.c, data);
			--tooltip:Show();
		end
	end
end

function AllInOneInventory_ReagentHelper_ModifyItemTooltip(bag, slot, tooltipName)
	if ( ReagentHelper_ModifyTooltip ) then
		local shouldModifyTooltip = true;
		if ( Auctioneer_GetFilter ) then
			if ( Auctioneer_GetFilter("all") ) and ( Auctioneer_GetFilter("usage") ) then
				shouldModifyTooltip = false;
			end
		end
		if ( shouldModifyTooltip ) then
			ReagentHelper_ModifyTooltip(tooltipName);
		end
	else
		-- No Labels
	end
end

function AllInOneInventoryFrameItemButton_OnUpdate(elapsed)
	if ( not this.updateTooltip ) then
		return;
	end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		AllInOneInventoryFrameItemButton_OnEnter();
	else
		this.updateTooltip = nil;
	end
end

function AllInOneInventoryFrame_UpdateLookIfNeeded()
	local slots = AllInOneInventory_GetBagsTotalSlots();
	local frame = getglobal("AllInOneInventoryFrame");
	if ( ( frame ) and ( not frame.size ) or ( slots ~= frame.size ) ) then
		AllInOneInventoryFrame_UpdateLook(frame, slots);
		return true;
	end
	return false;
end

function AllInOneInventoryFrame_SetColumns(col)
	if ( type(col) ~= "number" ) then
		col = tonumber(col);
	end
	if ( not col ) then
		return;
	end
	if ( ( col >= ALLINONEINVENTORY_COLUMNS_MIN )
		and ( col <= ALLINONEINVENTORY_COLUMNS_MAX )
		) then
		AllInOneInventory_Columns = col;
		AllInOneInventoryFrame_UpdateLook(getglobal("AllInOneInventoryFrame"), AllInOneInventory_GetBagsTotalSlots());
	end
end

function AllInOneInventoryFrame_GetAppropriateHeight(rows)
	return ALLINONEINVENTORY_BASE_HEIGHT + ( ALLINONEINVENTORY_ROW_HEIGHT * rows );
end

function AllInOneInventoryFrame_GetAppropriateWidth(cols)
	return ALLINONEINVENTORY_BASE_WIDTH + ( ALLINONEINVENTORY_COL_WIDTH * cols );
end


AllInOneInventoryFrame_AnchorWidgetList = { "MainMenuBar"};

function AllInOneInventoryFrame_AddAnchorWidget(widgetName)
	table.insert(AllInOneInventoryFrame_AnchorWidgetList, widgetName);
end

function AllInOneInventoryFrame_GetAnchorWidget()
	local obj = nil;
	for k, v in AllInOneInventoryFrame_AnchorWidgetList do
		obj = getglobal(v);
		if ( obj ) and ( obj:IsVisible() ) then
			return v;
		end
	end
	return "UIParent";
end

function AllInOneInventoryFrame_ResetButton()
	AllInOneInventoryFrame_ResetPosition(AllInOneInventoryFrame);
end

function AllInOneInventoryFrame_ResetPosition(frame)
	frame:ClearAllPoints();
	frame:SetPoint("CENTER", "UIParent", "CENTER");
end

function AllInOneInventoryFrame_ResetPositionOld(frame)
	local anchorWidgetName = AllInOneInventoryFrame_GetAnchorWidget();
	local anchorWidget = getglobal(anchorWidgetName);
	local anchorWidgetYOffset = 5;

	if ( anchorWidgetName == "UIParent" ) then
		anchorWidgetYOffset = 54;
	end

	local xPos = -17;

	if ( SideBarLeft_ShouldShiftBagFramesLeftOnShow ) then
		if ( ( SideBarLeft_ShouldShiftBagFramesLeftOnShow() ) and ( SideBar:IsVisible() ) ) then
			local temp = UIParent:GetWidth() - anchorWidget:GetWidth();
			if ( SideBarLeft_GetSafeOffset ) then
				xPos = temp + SideBarLeft_GetSafeOffset();
			else
				xPos = temp;
			end
			if ( xPos > 0 ) then
				xPos = 1-xPos;
			end
		end
	end

	frame:ClearAllPoints();
	frame:SetPoint("BOTTOMRIGHT", anchorWidgetName, "TOPRIGHT", xPos, anchorWidgetYOffset);
end

function AllInOneInventoryFrame_DoNothing()
end

function AllInOneInventoryFrame_UpdateLook(frame, frameSize)
	if ( not frame ) then
		frame = getglobal("AllInOneInventoryFrame");
	end
	if ( ( not frameSize ) or ( frameSize == 0 ) ) then
		frameSize = AllInOneInventory_GetBagsTotalSlots()
	end
	if ( not frame ) or ( not frameSize ) or ( frameSize == 0 )then
		AIOI_ScheduleByName("AIOI_UPDATE_LOOK", 1, AllInOneInventoryFrame_UpdateLook, frame, frameSize);
	else
		AIOI_ScheduleByName("AIOI_UPDATE_LOOK", 1, AllInOneInventoryFrame_DoNothing);
	end
	frame.size = frameSize;

	local name = frame:GetName();
--	local bgTexture = getglobal(name.."BackgroundTexture");
	getglobal(name.."MoneyFrame"):Show();
	local columns = AllInOneInventory_Columns;
	if (columns > frame.size) then columns = frame.size; end -- doesn't make sense to have more columns than slots, just in case sarf decides to increase the upper limit
	if ( columns <= 0 ) then
		columns = 8;
	end
	local rows = ceil(frame.size / columns);
	if ( rows <= 0 ) then
		rows = 1;
	end
	-- Added a short name, in case the long name doesn't fit ;)
	if (columns <= 4) then
		getglobal(name.."Name"):SetText(ALLINONEINVENTORY_BAG_TITLE_SHORT);
	else
		getglobal(name.."Name"):SetText(ALLINONEINVENTORY_BAG_TITLE_LONG);
	end

	local oldHeight = frame:GetHeight();
	local height = AllInOneInventoryFrame_GetAppropriateHeight(rows);
	frame:SetHeight(height);

	local oldWidth = frame:GetWidth();
	local width = AllInOneInventoryFrame_GetAppropriateWidth(columns);
	frame:SetWidth(width);
	if ( frame:IsVisible() ) then
		frame:Show();
	end

--	bgTexture:Hide();

	local diffHeight = ceil(height - oldHeight);
	local diffWidth = ceil(width - oldWidth);

	if ( ( ( diffHeight > 1 ) or ( diffHeight < -1 ) ) or ( ( diffWidth > 1 ) or ( diffWidth < -1 ) ) ) then
		--AllInOneInventoryFrame_ResetPosition(frame);
	end

	-- texture code to make it look like a normal bag...
	local lastColumnIsComplete = false;
	if (rows == floor(frame.size / columns)) then lastColumnIsComplete = true; end

	-- set textures for moneyframe:
	getglobal(name.."TextureBottomMiddle"):SetWidth((columns - 2) * 42 + 70);

	-- show the first row (assumes that columns < frame.size)
	local texture = getglobal(name.."ItemTexture1");
	if ( texture ) then
		texture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\first_right");
		texture:SetPoint("TOPLEFT", name.."TextureBottomRight", "TOPLEFT", -35, 43);
		texture:Show();
	end
	for i=2, (columns-1), 1 do
		local texture = getglobal(name.."ItemTexture"..i);
		if ( texture ) then
			texture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\first_middle");
			texture:SetPoint("TOPLEFT", name.."ItemTexture"..(i - 1), "TOPLEFT", -42, 0);
			texture:Show();
		end
	end
	local texture = getglobal(name.."ItemTexture"..columns);
	if ( texture ) then
		texture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\first_left");
		texture:SetPoint("TOPLEFT", name.."ItemTexture"..(columns - 1), "TOPLEFT", -47, 0);
		texture:Show();
	end

	-- show the other rows
	for j=1, (rows - 1), 1 do
		local texture = getglobal(name.."ItemTexture"..(j * columns + 1));
		if ( texture ) then
			texture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\second_right");
			local textureOffsetX = 0; if (j == 1) then textureOffsetX = -3; end
			texture:SetPoint("TOPLEFT", name.."ItemTexture"..((j - 1) * columns + 1), "TOPLEFT", textureOffsetX, 41);
			texture:Show();
		end
		local slotsInRow = columns;
		if ((j + 1) * columns > frame.size) then slotsInRow = frame.size - (j * columns); end
		for i=2, (slotsInRow - 1), 1 do
			local texture = getglobal(name.."ItemTexture"..(j * columns + i));
			if ( texture ) then
				texture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\second_middle");
				texture:SetPoint("TOPLEFT", name.."ItemTexture"..(j * columns + i - 1), "TOPLEFT", -42, 0);
				texture:Show();
			end
		end
		if (slotsInRow == columns) then
			local texture = getglobal(name.."ItemTexture"..(j * columns + slotsInRow));
			if ( texture ) then
				texture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\second_left");
				texture:SetPoint("TOPLEFT", name.."ItemTexture"..(j * columns + slotsInRow - 1), "TOPLEFT", -44, 0);
				texture:Show();
			end
		elseif (slotsInRow > 1) then
			local texture = getglobal(name.."ItemTexture"..(j * columns + slotsInRow));
			if ( texture ) then
				texture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\second_middle");
				texture:SetPoint("TOPLEFT", name.."ItemTexture"..(j * columns + slotsInRow - 1), "TOPLEFT", -42, 0);
				texture:Show();
			end
		end
	end

	getglobal(name.."TextureTopMiddle"):SetWidth((columns - 2) * 42 + 22);
	if (lastColumnIsComplete) then
		local textureOffsetX = 0; if (frame.size == columns) then textureOffsetX = -3; end
		getglobal(name.."TextureTopRight"):SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\top_right_large");
		getglobal(name.."TextureTopRight"):SetPoint("BOTTOMLEFT", name.."ItemTexture"..((rows - 1) * columns + 1), "TOPLEFT", 19 + textureOffsetX, 0);
		getglobal(name.."TextureTopMiddle"):SetPoint("BOTTOMRIGHT", name.."TextureTopRight", "BOTTOMLEFT", 0, -34);
		getglobal(name.."CloseButton"):SetPoint("BOTTOMLEFT", name.."TextureTopRight", "BOTTOMLEFT", 4, 12);
	else
		getglobal(name.."TextureTopRight"):SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\top_right_small");
		getglobal(name.."TextureTopRight"):SetPoint("BOTTOMLEFT", name.."ItemTexture"..((rows - 1) * columns + 1), "TOPLEFT", 19, 0);
		getglobal(name.."TextureTopMiddle"):SetPoint("BOTTOMRIGHT", name.."TextureTopRight", "BOTTOMLEFT", 0, -51);
		getglobal(name.."CloseButton"):SetPoint("BOTTOMLEFT", name.."TextureTopRight", "BOTTOMLEFT", 4, -5);
	end

	for j=0, (frame.size - 1), 1 do
		local itemButton = getglobal(name.."Item"..(frame.size - j));
		itemButton:SetID(frame.size - j);
		itemButton:ClearAllPoints();
		-- Set first button
		if ( j == 0 ) then
			itemButton:SetPoint("TOPLEFT", name.."ItemTexture1", "TOPLEFT", 4, -1);
		else
			if ( mod(j, columns) == 0 ) then
				itemButton:SetPoint("TOPLEFT", name.."Item"..(frame.size - j + columns), "TOPLEFT", 0, 41);
			else
				itemButton:SetPoint("TOPLEFT", name.."Item"..(frame.size - j + 1), "TOPLEFT", -42, 0);
			end
		end
		itemButton:Show();

		AllInOneInventoryFrame_UpdateButton(frame, (frame.size - j));
	end
	local button = nil;
	local texture = nil;
	for i = frame.size+1, ALLINONEINVENTORY_MAX_ID do
		button = getglobal(name.."Item"..i);
		if ( button ) then
			button:Hide();
		end
		texture = getglobal(name.."ItemTexture"..i); -- hide the textures, that are not needed
		if ( texture ) then
			texture:Hide();
		end
	end
end

-- Thanks to 'lugo for this fix!
function AllInOneInventory_OpenAllBags(forceOpen)
	if ( AllInOneInventory_ReplaceBags == 1 ) then
		local bagsOpen = 0;
		local totalBags = 1;
		for i=1, NUM_CONTAINER_FRAMES, 1 do
			local containerFrame = getglobal(AllInOneInventory_ContainerFrames[i]);
			if ( not containerFrame ) then break; end
			local bagButton = getglobal("CharacterBag"..(i -1).."Slot");
			if (i <= NUM_BAG_FRAMES) then
				local id = bagButton:GetID() - CharacterBag0Slot:GetID() + 1;
				if ((not AllInOneInventory_ShouldOverrideBag(id)) and (GetContainerNumSlots(id) > 0)) then
					totalBags = totalBags + 1;
				end
			end
			if ( containerFrame:IsVisible() ) then
				containerFrame:Hide();
				if (containerFrame:GetID() <= NUM_BAG_FRAMES) then
					bagsOpen = bagsOpen + 1;
				end
			end
		end

	if (AllInOneInventoryFrame:IsVisible()) then
		CloseAllInOneInventoryFrame();
		bagsOpen = bagsOpen + 1;
	end

	if ( bagsOpen == totalBags and not forceOpen ) then
		return;
	end

	ToggleAllInOneInventoryFrame();
	if ( AllInOneInventoryFrame:IsVisible() ) then
		AllInOneInventory_OpenBag(1);
		AllInOneInventory_OpenBag(2);
		AllInOneInventory_OpenBag(3);
		AllInOneInventory_OpenBag(4);
	end
		return;
	end
	AllInOneInventory_Saved_OpenAllBags(forceOpen);
end

function AllInOneInventory_DepositBox_RefreshWindows()
	AllInOneInventory_Saved_DepositBox_RefreshWindows();
	MoneyFrame_Update("AllInOneInventoryFrameMoneyFrame", GetMoney() - GetCursorMoney());
end


function AIOI_LootLink_SetTooltipMoney(frame, count, money, stack)
	if ( not money ) then return; end
	if ( money <= 0) then return; end
	if ( count and count > 1 ) then
		money = money * count;
		frame:AddLine(format(LOOTLINK_SELL_PRICE_N, count), 1.0, 1.0, 1.0);
	elseif( stack ) then
		frame:AddLine(LOOTLINK_SELL_PRICE_EACH, 1.0, 1.0, 1.0);
	else
		frame:AddLine(LOOTLINK_SELL_PRICE, 1.0, 1.0, 1.0);
	end

	local numLines = frame:NumLines();
	local moneyFrame = getglobal(frame:GetName().."MoneyFrame");
	local newLine = frame:GetName().."TextLeft"..numLines;

	moneyFrame:SetPoint("LEFT", newLine, "RIGHT", 4, 0);
	moneyFrame:Show();
	MoneyFrame_Update(moneyFrame:GetName(), money);
	frame:SetMinimumWidth(moneyFrame:GetWidth() + getglobal(newLine):GetWidth() - 10);
end

function AllInOneInventory_SellValue_OnShow()
	if ( AllInOneInventory_Patching_Tooltip ~= 1 ) then
		AllInOneInventory_Saved_SellValue_OnShow();
	end
end

function AllInOneInventory_StartMoving(frame)
	if ( not frame.isMoving ) and ( frame.isLocked ~= 1 ) then
		frame:StartMoving();
		frame.isMoving = true;
	end
end

function AllInOneInventory_StopMoving(frame)
	if ( frame.isMoving ) then
		frame:StopMovingOrSizing();
		frame.isMoving = false;
	end
end

function AllInOneInventory_ToggleLock(frame)
	if ( frame.isLocked ~= 1 ) then
		frame.isLocked = 1;
	else
		frame.isLocked = nil;
	end
end

function AllInOneInventory_SetLock(frame)
	if ( not frame ) then
		frame = AllInOneInventoryFrame;
	end
	local lockButton = getglobal(frame:GetName().."LockButton");
	if ( AllInOneInventory_Locked ~= 1 ) then
		frame.isLocked = 0;
		if ( lockButton ) then
			lockButton:SetChecked(1);
		end
	else
		AllInOneInventory_StopMoving(frame);
		frame.isLocked = 1;
		if ( lockButton ) then
			lockButton:SetChecked(0);
		end
	end
end

function AllInOneInventory_GetLock(frame)
	if ( frame.isLocked == 1 ) then
		return 1;
	else
		return 0;
	end
end

function ToggleLockAllInOneInventoryFrame()
	AllInOneInventory_Toggle_Locked(-1);
end

function AllInOneInventory_Toggle_Locked(toggle)
	AllInOneInventory_DoToggle_Locked(toggle, true);
end

function AllInOneInventory_Toggle_Locked_NoChat(toggle)
	AllInOneInventory_DoToggle_Locked(toggle, false);
end

-- does the actual toggling
function AllInOneInventory_DoToggle_Locked(toggle, showText)
	local newvalue = 0;
	if ( showText ) then
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_Locked", "ALLINONEINVENTORY_CHAT_LOCKED_ENABLED", "ALLINONEINVENTORY_CHAT_LOCKED_DISABLED");
	else
		newvalue = AllInOneInventory_Generic_Toggle(toggle, "AllInOneInventory_Locked");
	end
	local frame = getglobal("AllInOneInventoryFrame");
	if ( frame ) then
		AllInOneInventory_SetLock(frame, newvalue);
	end
end

function AllInOneInventory_Toggle_ExcludedSlot(bag, slot)
	return AllInOneInventory_DoToggle_ExcludedSlot(bag, slot, 1)
end

function AllInOneInventory_Toggle_ExcludedSlot_NoChat(bag, slot)
	return AllInOneInventory_DoToggle_ExcludedSlot(bag, slot)
end

function AllInOneInventory_DoToggle_ExcludedSlot(bag, slot, showText)
	if ( bag ) and ( slot ) then
		if ( type(bag) == "string" ) then
			bag = tonumber(bag);
		end
		if ( type(slot) == "string" ) then
			slot = tonumber(slot);
		end
	end
	if ( not bag ) or ( not slot ) then
		if ( showText ) then
			AllInOneInventory_Print(ALLINONEINVENTORY_TOGGLE_SLOT_FAIL);
		end
		return false;
	end
	if ( not AllInOneInventory_ExcludedSlots ) then
		AllInOneInventory_ExcludedSlots = {};
	end
	if ( not AllInOneInventory_ExcludedSlots[bag] ) then
		AllInOneInventory_ExcludedSlots[bag] = {};
	end
	local newState = ALLINONEINVENTORY_TOGGLE_SLOT_OFF;
	if ( not AllInOneInventory_ExcludedSlots[bag][slot] ) then
		newState = ALLINONEINVENTORY_TOGGLE_SLOT_ON;
		AllInOneInventory_ExcludedSlots[bag][slot] = 1;
	else
		AllInOneInventory_ExcludedSlots[bag][slot] = nil;
	end
	if ( showText ) then
		AllInOneInventory_Print(string.format(ALLINONEINVENTORY_TOGGLE_SLOT, bag, slot, newState));
	end
	return true;
end

function AllInOneInventory_OnMouseDown(button, frame)
	--[[
	if ( button == "LeftButton" ) and ( IsShiftKeyDown() ) then
		ToggleLockAllInOneInventoryFrame();
	else
	end
	]]--
	AllInOneInventory_StartMoving(frame);
end

setglobal("AIOI_ScheduleByName", AIOI_ScheduleByName_Own);
setglobal("AIOI_Schedule", AIOI_Schedule_Own);



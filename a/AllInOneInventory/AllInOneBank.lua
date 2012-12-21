-- -----------------------------------------------------------------
-- File: AllInOneBank.lua
--
-- Purpose: Functions for AIOB WoW Window.
-- 
-- Author: Ramble 
-- 
-- Credits: 
--   Starven, for MyInventory
--   Kaitlin, for BankItems
--   Sarf, for the original concept of AllInOneInventory
-- -----------------------------------------------------------------
-----------------------
-- Saved Configuration
-----------------------
AIOBProfile = {}
AIOB_VERSION           =  "1.5.2";

local PlayerName = nil; -- Logged in player name
local bankPlayer     = nil; -- viewing player pointer
local bankPlayerName = nil; -- Viewing player name

------------------------
-- Saved Function Calls
------------------------
local BankFrame_Saved = nil;
local PurchaseSlot_Saved = nil;
-----------------------
-- Local Configuration
-----------------------
local AIOB_Loaded = nil;
local AtBank = false;

AIOB_MAX_ID              = 132; -- 6 * 18 slot bags, 24 Bankslots
AIOB_COLUMNS_MIN         =   6; -- 6 Bags, so it has to be at least 6 wide
AIOB_COLUMNS_MAX         =  18; -- Same as MI
AIOB_BASE_HEIGHT         = 153; -- Height of Borders + Title + Bottom
AIOB_ROW_HEIGHT          =  40; -- One Row
AIOB_BASE_WIDTH          =  12; -- Width of the borders
AIOB_COL_WIDTH           =  39; -- One Column
AIOB_FIRST_ITEM_OFFSET_X =   7; -- Leave room for the border
AIOB_FIRST_ITEM_OFFSET_Y = -28 - 39; -- Leave room for the title.
AIOB_ITEM_OFFSET_X       =  39; -- Each is 39 apart
AIOB_ITEM_OFFSET_Y       = -39; -- Each is 39 apart

AIOBDEBUG                = 0;
-- Not Saved between Sessions
AIOBAllRealms				= 0;
-- Saved Between Sessions
AIOBReplaceBank          = 1;
AIOBColumns              = 10;
AIOBFreeze					 = 0;
AIOBHighlightItems		 = 1;
AIOBHighlightBags			 = 1;
AIOBBagView              = 0;
AIOBGraphics             = 1;
AIOBBackground           = 1;
AIOBShowPlayers          = 1;

--InitializeProfile: Initializes a players profile {{{
--  If Player's profile is not found, it makes a new one from defaults
--  If Player's profile is found, it loads the values from AIOBProfile
function AIOB_InitializeProfile()
	if ( UnitName("player") ) then
		PlayerName = UnitName('player').."|"..AIOB_Trim(GetCVar("realmName"));
		AIOB_LoadSettings();

		AIOB_DEBUG("AIOB: Profile for "..PlayerName.." Initilized.");
		AIOBFrame_PopulateFrame();
		-- TODO: why is this here?
		-- AIOB_UpdateBagCost(AIOBProfile[PlayerName].Bags);
	end
end

function AIOB_LoadSettings()
	if ( AIOBProfile[PlayerName] == nil ) then
		AIOBProfile[PlayerName] = {};
		AIOB_Print("Creating new Profile for "..PlayerName);
	end
	AIOBReplaceBank    = AIOB_SavedOrDefault("ReplaceBank");
	AIOBColumns        = AIOB_SavedOrDefault("Columns");
	AIOBFreeze         = AIOB_SavedOrDefault("Freeze");
	AIOBHighlightItems = AIOB_SavedOrDefault("HighlightItems");
	AIOBHighlightBags  = AIOB_SavedOrDefault("HighlightBags");
	AIOBBagView        = AIOB_SavedOrDefault("BagView");
	AIOBGraphics       = AIOB_SavedOrDefault("Graphics");
	AIOBBackground     = AIOB_SavedOrDefault("Background");
	AIOBShowPlayers    = AIOB_SavedOrDefault("ShowPlayers");

	AIOB_SetGraphics();
	AIOB_SetReplaceBank();
	AIOB_SetFreeze();
end
function AIOB_SavedOrDefault(varname)
	if PlayerName == nil or varname == nil then
		AIOB_DEBUG("ERR: nil value");
		return nil;
	end
	if AIOBProfile[PlayerName][varname] == nil then -- Setting not set
		AIOBProfile[PlayerName][varname] = getglobal("AIOB"..varname); -- Load Default
	end
	return AIOBProfile[PlayerName][varname];  -- Return Setting.
end
-- END  Initialization }}}
function AIOB_GetPlayer(playerName)
	if ( not AIOBProfile[playerName] ) then
		AIOB_InitializeProfile();
	end
	bankPlayerName = playerName;
	UIDropDownMenu_SetSelectedValue(AIOBDropDown, bankPlayerName);
	return AIOBProfile[playerName];
end

function AIOB_GetBag(bagIndex)
	local curBag
	if bagIndex == BANK_CONTAINER then
		curBag = bankPlayer["Bank"];
	else
		curBag = bankPlayer["Bag"..bagIndex];
	end
	return curBag;
end

function AIOB_GetBagsTotalSlots()
	local slots = 24;
	if bankPlayer == nil then
		return slots;
	end 
	for bag = 5, 10 do
		local curBag = bankPlayer["Bag"..bag];
		if (curBag ~= nil) then
			if curBag["s"] ~=nil then
				slots = slots + curBag["s"];
			end
		end
	end
	return slots;
end

-- == Event Handling == 
-- OnLoad {{{
function AIOBFrame_OnLoad()
	AIOB_Register(); -- Slash Commands
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	this:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
	this:RegisterEvent("PLAYER_MONEY");
	tinsert(UISpecialFrames, "AIOBFrame"); -- Esc Closes AIOB
end

function AIOB_Register()
	SlashCmdList["AIOBSLASHMAIN"] = AIOB_ChatCommandHandler;
	SLASH_AIOBSLASHMAIN1 = "/AIOB";
	this:RegisterEvent("VARIABLES_LOADED");
end
-- End Load }}}
-- Confirm Dialog for buying bag slot {{{
function AIOB_RegisterConfirm() 
	PurchaseSlot_Saved = PurchaseSlot;
	PurchaseSlot = AIOB_PurchaseSlot;
	StaticPopupDialogs["PURCHASE_BANKBAG"] = {
		text = TEXT(AIOB_PURCHASE_CONFIRM_S),
		button1 = TEXT(ACCEPT),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			PurchaseSlot_Saved();
		end,
		showAlert = 1,
		timeout = 0,
	};
end

function AIOB_PurchaseSlot()
	if not StaticPopupDialogs["PURCHASE_BANKBAG"] then
		return;
	end
	local cost = GetBankSlotCost();
	if cost < 10000 then
		StaticPopupDialogs["PURCHASE_BANKBAG"]["text"] = format(AIOB_PURCHASE_CONFIRM_S,(cost/100)); 
	else
		StaticPopupDialogs["PURCHASE_BANKBAG"]["text"] = format(AIOB_PURCHASE_CONFIRM_G,(cost/10000)); 
	end
	StaticPopup_Show("PURCHASE_BANKBAG");
end
-- End buy bag slot config }}}
-- Register with MyAddons
function AIOB_MyAddonsRegister()
	if (myAddOnsFrame) then
		myAddOnsList.AIOB = {
			name = AIOB_MYADDON_NAME,
			description = AIOB_MYADDON_DESCRIPTION,
			version = AIOB_VERSION,
			category = MYADDONS_CATEGORY_INVENTORY,
			frame = "AIOBFrame",
			optionsframe = "AIOBConfigFrame"
		};
	end
end

function AIOBFrame_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		AIOB_Loaded = 1;
		AIOB_MyAddonsRegister();
		AIOB_InitializeProfile();
		if not BankBuyFrame then
			AIOB_RegisterConfirm();
		end
	end
	if (not AIOB_Loaded) then
		return;
	end
	
	if ( event == "PLAYER_ENTERING_WORLD" and bankPlayer == nil ) then
		PlayerName = UnitName("player").."|"..AIOB_Trim(GetCVar("realmName"));
		bankPlayer = AIOB_GetPlayer(PlayerName);
		AIOB_InitializeProfile();
		AIOB_SaveMoney();
	elseif ( event == "BAG_UPDATE" ) then
		if AtBank and arg1 >=5 and arg1 <=10 then
			AIOBFrame_SaveItems();
		end
	elseif (event == "PLAYERBANKSLOTS_CHANGED" or event=="PLAYERBANKBAGSLOTS_CHANGED") then
		AIOBFrame_SaveItems();
	elseif ( event == "ITEM_LOCK_CHANGED" or  event == "UPDATE_INVENTORY_ALERTS" ) then
		if ( AtBank ) then
			AIOBFrame_PopulateFrame();
		end
	end
	if (event == "BANKFRAME_OPENED") then
		AtBank = true;
		SetPortraitTexture(AIOBFramePortrait, "npc");
		AIOBFrameAtBankText:Show();
		OpenBackpack(); -- Open Backpack at Bank
		bankPlayer = AIOB_GetPlayer(PlayerName);
		AIOBFrame_SaveItems();
		AIOBFramePurchaseButton:Enable();
		if AIOBReplaceBank == 1 then
			OpenAIOBFrame();
		end
	elseif (event == "BANKFRAME_CLOSED") then
		AtBank = false;
		AIOBFramePortrait:SetTexture("Interface\\Addons\\AllInOneInventory\\Skin\\AIOBPortait");
		AIOBFrameAtBankText:Hide();
		AIOBFramePurchaseButton:Disable();
		CloseBackpack(); -- Close Backpack when leaving
	 	if AIOBReplaceBank == 1 then
			if AIOBFreeze == 0 then
				CloseAIOBFrame();
			end
		end
		if StackSplitFrame:IsVisible() then
			StackSplitFrame:Hide();
		end
	elseif (event == "PLAYER_MONEY" ) then
		AIOB_SaveMoney();
		return;
	end
end

function AIOB_HighlightBag(bagID, bagName, isItem)
	if AIOBHighlightBags == 0 and isItem then 
		return;
	end
	if AIOBHighlightItems == 0 and (not isItem) then
		return;
	end
	if isItem then
		if bagID > -1 then
			getglobal("AIOBFrameBag"..bagID):LockHighlight();
		end
	end
	if(bankPlayer[bagName])then
		local i, found;
		for i=1, AIOB_MAX_ID do
			local itemButton = getglobal("AIOBFrameItem"..i);
			if not itemButton:IsVisible() then
				break;
			end
			if itemButton.bagIndex == bagID then
				found = true;
				itemButton:LockHighlight();
			else
				if found then
					break;
				end
			end
		end
	end
end

function AIOB_GetCooldown(item)
	if item["d"] then
		local cooldownInfo = item["d"];
		local CoolDownRemaining;
		if cooldownInfo and cooldownInfo["d"] and cooldownInfo["s"] then
			CoolDownRemaining = cooldownInfo["d"] - (GetTime() - cooldownInfo["s"]);
		else
			CoolDownRemaining = 0;
		end
		if CoolDownRemaining <= 0 then
			item["d"] = nil;
		else
			return cooldownInfo;
		end
	end
	return nil;
end

function AIOB_GetCooldownString(cooldownInfo)
	local CoolDownRemaining = cooldownInfo["d"] - (GetTime() - cooldownInfo["s"]);
	-- 60 secs in a min
	-- 3600 secs in an hour
	-- 86400 secs in a day
	local days, hours, minutes, seconds;
	days = math.floor(CoolDownRemaining / 86400);
	CoolDownRemaining = CoolDownRemaining - 86400 * days;
	hours = math.floor(CoolDownRemaining / 3600);
	CoolDownRemaining = CoolDownRemaining - 3600 * hours;
	minutes = math.floor(CoolDownRemaining / 60);
	seconds = math.floor(CoolDownRemaining - 60 * minutes);
	if days > 0 then
		return format(ITEM_COOLDOWN_TIME_DAYS_P1, days+1);
	elseif hours > 0 then
		return format(ITEM_COOLDOWN_TIME_HOURS_P1, hours+1);
	elseif minutes > 0 then
		return format(ITEM_COOLDOWN_TIME_MIN, minutes+1);
	else
		return format(ITEM_COOLDOWN_TIME_SEC, seconds);
	end
end

function AIOB_MakeLink(item)
	if item and item["l"] then
		local name;
		_,_,_, name = strfind(item["l"],"|H(item:%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r");
		item["name"] = name;
		item["l"] = nil;
	end
	if item and item["name"] then
		local myHyperlink;
		if ItemsMatrix_GetHyperlink then
			myHyperlink = ItemsMatrix_GetHyperlink(item["name"]);
		elseif LootLink_GetHyperlink then
			myHyperlink = LootLink_GetHyperlink(item["name"]);
		else
			myHyperlink = AIOB_GetHyperlink(item);
		end
		if myHyperlink then
			GameTooltip:Hide();
			GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
			GameTooltip:SetHyperlink(myHyperlink);
			if item["sb"] then
				GameTooltipTextLeft2:SetText(ITEM_SOULBOUND);
			end
			if item["m"] then
				GameTooltip:AddLine(format(ITEM_CREATED_BY, item["m"]));
			end
			local cooldownInfo = item["d"];
			if cooldownInfo and cooldownInfo["e"] and cooldownInfo["e"] > 0 and cooldownInfo["d"] > 0 then
				CoolDownString = AIOB_GetCooldownString(cooldownInfo);
				GameTooltip:AddLine(CoolDownString, 1.0, 1.0, 1.0);
			end
			GameTooltip:Show();
		end
	end
end

function AIOBFrame_Button_OnEnter()
	--show tooltip
	local myLink, MadeBy, Soulbound, count;
	local bagName = strsub(this:GetName(), 10, 13);
	local curBag;
	local cooldownInfo;
	if AtBank then
		local hasCooldown, repairCost;
		GameTooltip:SetOwner(this,"ANCHOR_RIGHT");
		if (this.isBag) then
			AIOB_HighlightBag(this:GetID(), bagName);
			local inventoryID = BankButtonIDToInvSlotID(this:GetID(), 1);
			hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", inventoryID);
		else
			AIOB_HighlightBag(this.bagIndex, bagName, 1);
			if this.bagIndex < 0 then
				local newIndex =BankFrameItem1:GetInventorySlot(); 
				hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", newIndex);
			else
				hasCooldown, repairCost = GameTooltip:SetBagItem(this.bagIndex, this.itemIndex);
			end
		end

	else
		if LootLink_AutoInfoOff then
			LootLink_AutoInfoOff();
		end
		if (this.isBag) then
			AIOB_MakeLink(bankPlayer[bagName]);
			AIOB_HighlightBag(this:GetID(), bagName);
		else
			AIOB_HighlightBag(this.bagIndex, bagName, 1);
			curBag = AIOB_GetBag(this.bagIndex);
			if curBag and curBag[this.itemIndex] then
				AIOB_MakeLink(curBag[this.itemIndex]);
			end

		end
		if LootLink_AutoInfoOn then
			LootLink_AutoInfoOn();
		end
	end
end
function AIOBFrame_Button_OnLeave()
	if this.isBag then
		local bagName= strsub(this:GetName(), 10, 13);
		local i, found;
		for i=1, AIOB_MAX_ID do
			local itemButton = getglobal("AIOBFrameItem"..i);
			if itemButton.bagIndex == this:GetID() then
				found = true;
				itemButton:UnlockHighlight();
			else
				if found then
					break;
				end
			end
		end
	else
		if this.bagIndex > -1 then
			getglobal("AIOBFrameBag"..(this.bagIndex)):UnlockHighlight();
		end

	end
	GameTooltip:Hide();
end

function AIOBFrame_UpdateCooldown(button)
	if (not button.bagIndex) or (not button.itemIndex) then
		return;
	end
  local cooldown = getglobal(button:GetName().."Cooldown");
  local start, duration, enable = GetContainerItemCooldown(button.bagIndex, button.itemIndex);
  CooldownFrame_SetTimer(cooldown, start, duration, enable);
  if ( duration > 0 and enable == 0 ) then
    SetItemButtonTextureVertexColor(button, 0.4, 0.4, 0.4);
  end
end

function AIOBFrame_OnHide()
	if AtBank then
		CloseBankFrame();
	end
	PlaySound("igBackPackClose");
end

function AIOBFrame_OnShow()
	if AtBank then
		AIOBFramePurchaseButton:Enable();
	else
		AIOBFramePurchaseButton:Disable();
	end
	AIOB_UpdateTotalMoney();
	AIOBFrame_UpdateLookIfNeeded();
	PlaySound("igBackPackOpen");
end

function AIOBFrameItemButton_OnLoad()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterForDrag("LeftButton");

	this.SplitStack = function(button, split)
		SplitContainerItem(button:GetParent():GetID(), button:GetID(), split);
	end
end

function AIOBFrameItemButton_OnClick(button, ignoreShift)
	local myLink;
	local item = AIOB_GetBag(this.bagIndex)[this.itemIndex];
	if (button == "LeftButton" ) then
		if (IsShiftKeyDown() and (not ignoreShift)) then
			if ChatFrameEditBox:IsVisible() or ( MacroFrameText and MacroFrameText:IsVisible() ) then
				-- Insert Link
				if ItemsMatrix_GetLink then
					myLink = ItemsMatrix_GetLink(item["name"]);
				elseif LootLink_GetLink then
					myLink = LootLink_GetLink(item["name"]);
				else
					myLink = AIOB_GetLink(item);
				end
				if myLink then
				   if ChatFrameEditBox:IsVisible() then
					   ChatFrameEditBox:Insert(myLink);
					elseif ( MacroFrameText and MacroFrameText:IsVisible() ) then
		            MacroFrameText:Insert(myLink);
		         end
				end
			else
				if AtBank then
					--Shift key down, left mouse button
					local texture, itemCount, locked = GetContainerItemInfo(this.bagIndex, this.itemIndex);
					if ( not locked ) then
						this.SplitStack = function(button, split)
							SplitContainerItem(button.bagIndex, button.itemIndex, split);
						end
						OpenStackSplitFrame(this.count, this, "BOTTOMRIGHT", "TOPRIGHT");
					end
				end
			end
		else
			-- no shift, left mouse button
			if AtBank==true then
				PickupContainerItem(this.bagIndex, this.itemIndex);
			end
		end
	elseif (button == "RightButton") then
		if AtBank==true then
			UseContainerItem(this.bagIndex, this.itemIndex);
		end
	end
end
			  
function AIOBFrameItemButtonBag_OnShiftClick(button, ignoreShift) 
	local bankBag = getglobal("BankFrameBag"..(tonumber(strsub(this:GetName(), 13, 15))-4));
	local inventoryID = BankButtonIDToInvSlotID(bankBag:GetID(), 1);
	if ( ChatFrameEditBox:IsVisible() ) then
		local bagName= strsub(this:GetName(), 10, 13);
		local myLink;
		if ItemsMatrix_GetLink then
			myLink = ItemsMatrix_GetLink(bankPlayer[bagName]["name"]);
		elseif LootLink_GetLink then
			myLink = LootLink_GetLink(bankPlayer[bagName]["name"]);
		else
			myLink = AIOB_GetLink(bankPlayer[bagName]);
		end
		if myLink then
			if ChatFrameEditBox:IsVisible() then
			   ChatFrameEditBox:Insert(myLink);
			elseif ( MacroFrameText and MacroFrameText:IsVisible() ) then
            MacroFrameText:Insert(myLink);
         end
		end
	else
		 -- Shift key, no chat box
		if AtBank then
			PickupBagFromSlot(inventoryID);
			PlaySound("BAGMENUBUTTONPRESS");
		end
	end
end
function AIOBFrameItemButtonBag_OnClick(button, ignoreShift) 
	local bankBag = getglobal("BankFrameBag"..(tonumber(strsub(this:GetName(), 13, 15))-4));
	local inventoryID = BankButtonIDToInvSlotID(bankBag:GetID(), 1);
	AIOB_DEBUG(bankBag:GetName().." "..inventoryID);
		 -- No ShiftKey
	if AtBank then
		local hadItem = PutItemInBag(inventoryID);
		local id = this:GetID();
	end
end
-- == End Event Handling == 

function AIOBFrame_SetColumns(col)
	if ( type(col) ~= "number" ) then
		col = tonumber(col);
	end
	if ( ( col >= AIOB_COLUMNS_MIN ) and ( col <= AIOB_COLUMNS_MAX ) ) then
		AIOBColumns = col;
		bankPlayer.Columns = AIOBColumns;
		AIOBFrame_UpdateLook(getglobal("AIOBFrame"), AIOB_GetBagsTotalSlots());
	end
end

function AIOBFrame_GetAppropriateHeight(rows)
	local height = AIOB_BASE_HEIGHT + ( AIOB_ROW_HEIGHT * (AIOBBagView - 1 + rows ));
	if AIOBShowPlayers == 0 and AIOBGraphics == 0 then
		height = height - AIOB_ROW_HEIGHT;
	end
	return height;
end

function AIOBFrame_GetAppropriateWidth(cols)
	return AIOB_BASE_WIDTH + ( AIOB_COL_WIDTH * cols );
end

function AIOBTitle_Update()
	local i, j, totalSlots, takenSlots = 0, 0, 0, 0;
	totalSlots = AIOB_GetBagsTotalSlots();
	-- Need to calculate Free slots.
	if bankPlayer and bankPlayer["Bank"] then
		for i = 1, 24 do
			if bankPlayer["Bank"][i] then
				takenSlots = takenSlots + 1;
			end
		end
		for i = 5, 10 do
			if bankPlayer["Bag"..i] and bankPlayer["Bag"..i]["s"] then
				for j = 1, bankPlayer["Bag"..i]["s"] do
					if bankPlayer["Bag"..i][j] then
						takenSlots = takenSlots + 1;
					end
				end
			end
		end
	end

	if ( bankPlayerName ) then
		local playername = AIOB_Split(bankPlayerName, "|");
		if ( AIOBColumns >= 9 ) then
			AIOBFrameName:SetText(format(AIOB_FRAME_PLAYERANDREGION, playername[1], playername[2]));
		else
			AIOBFrameName:SetText(format(AIOB_FRAME_PLAYERONLY, playername[1]));
		end
		AIOBFrameName:SetTextColor(1.0, 1.0, 1.0);
	end
	AIOBFrameSlots:SetText(format(AIOB_FRAME_SLOTS, (totalSlots-takenSlots), (totalSlots)));
end

function AIOB_UpdateTotalMoney()
	local totalMoney = 0;
	for key, value in AIOBProfile do
		local thisRealmPlayers = AIOB_Split(key, "|")[2];
		if AIOBAllRealms == 1 or thisRealmPlayers == AIOB_Trim(GetCVar("realmName")) then
			if ( AIOBProfile[key].money ) then
				totalMoney = totalMoney + AIOBProfile[key].money;
			end
		end
	end
	if AIOBColumns < 8 then
		totalMoney = math.floor(totalMoney / 10000) * 10000;
	end
	MoneyFrame_Update("AIOB_MoneyFrameTotal", totalMoney);
end

function AIOB_UpdateBagCost(bags) 
	if not bags then
		bags=0;
	end
	if bags < 6 then
		AIOBFramePurchaseInfo:Show();
		local cost = AIOB_GetBankSlotCost(bags);
		MoneyFrame_Update("AIOBFrameDetailMoneyFrame", cost);
		if ( bankPlayer and bankPlayer["money"] and bankPlayer["money"] >= cost ) then
			SetMoneyFrameColor("AIOBFrameDetailMoneyFrame", 1.0, 1.0, 1.0);
		else
			SetMoneyFrameColor("AIOBFrameDetailMoneyFrame", 1.0, 0.1, 0.1)
		end
	else
		-- Hide frame
		AIOBFramePurchaseInfo:Hide();
	end
end

function AIOBFrame_UpdateLookIfNeeded()
	local slots = AIOB_GetBagsTotalSlots();
	if ( ( not AIOBFrame.size ) or ( slots ~= AIOBFrame.size ) ) then
		AIOBFrame_UpdateLook(getglobal("AIOBFrame"), slots);
	end
end

function AIOBFrame_UpdateLook(frame, frameSize)
	frame.size = frameSize;
	local name = frame:GetName();
	local columns = AIOBColumns;
	
	local rows = ceil(frame.size / columns);
	local height = AIOBFrame_GetAppropriateHeight(rows);
	frame:SetHeight(height);
	
	local width = AIOBFrame_GetAppropriateWidth(columns);
	frame:SetWidth(width);
	
	AIOBTitle_Update();	
	if AIOBShowPlayers ==1 then
		AIOBDropDown:Show();
		AIOB_AllRealms_Check:Show();
		--MYINVENTORY_BASE_HEIGHT = MYINVENTORY_BASE_HEIGHT - MYINVENTORY_ITEM_OFFSET_Y;
	else
		AIOBDropDown:Hide();
		AIOB_AllRealms_Check:Hide();
	end
	for j=5,10 do
		local bagButton=getglobal("AIOBFrameBag"..j);
		bagButton:ClearAllPoints();
		if j == 5 then
			bagButton:SetPoint("TOPLEFT", "AIOBBagButtonsBar", "TOPLEFT", 0, 0);
		else
			bagButton:SetPoint("TOPLEFT", "AIOBFrameBag"..(j-1), "TOPLEFT", AIOB_ITEM_OFFSET_X, 0);
		end
		bagButton:Show();
	end
	local First_Y;
		First_Y = AIOB_FIRST_ITEM_OFFSET_Y;
	if AIOBBagView == 1 then
		First_Y = AIOB_FIRST_ITEM_OFFSET_Y + AIOB_ITEM_OFFSET_Y;
		AIOBBagButtonsBar:Show();
	else
		First_Y = AIOB_FIRST_ITEM_OFFSET_Y;
		AIOBBagButtonsBar:Hide();
	end
	if (AIOBShowPlayers == 0 and AIOBGraphics == 0 ) then
		AIOB_DEBUG("move up");
		First_Y = First_Y - AIOB_ITEM_OFFSET_Y;
		AIOBBagButtonsBar:ClearAllPoints();
		AIOBBagButtonsBar:SetPoint("TOP", "AIOBFrame", "TOP", 0, -28);
	else
		AIOBBagButtonsBar:ClearAllPoints();
		AIOBBagButtonsBar:SetPoint("TOP", "AIOBFrame", "TOP", 0, -28-39);
		
	end
	for j=1, frame.size, 1 do
		local itemButton = getglobal(name.."Item"..j);
		-- Set first button
		itemButton:ClearAllPoints();
		if ( j == 1 ) then
			itemButton:SetPoint("TOPLEFT", name, "TOPLEFT", AIOB_FIRST_ITEM_OFFSET_X, First_Y);
		else
			if ( mod((j-1), columns) == 0 ) then
				itemButton:SetPoint("TOPLEFT", name.."Item"..(j - columns), "TOPLEFT", 0, AIOB_ITEM_OFFSET_Y);  
			else
				itemButton:SetPoint("TOPLEFT", name.."Item"..(j - 1), "TOPLEFT", AIOB_ITEM_OFFSET_X, 0);  
			end
		end
		
		itemButton.readable = readable;
		itemButton:Show();
	end
	local button = nil;
	for i = frame.size+1, AIOB_MAX_ID do
		button = getglobal("AIOBFrameItem"..i);
		if ( button ) then
			button:Hide();
		end
	end
	AIOBFrame_PopulateFrame();
end


function AIOB_GetTooltipData()
	local soulbound = nil;
	local madeBy = nil;
	local field;
	local left, right;

	for index = 1, 15, 1 do
		field = getglobal("AIOBHiddenTooltipTextLeft"..index);
		if( field and field:IsVisible() ) then
			left = field:GetText();
		else
			left = "";
		end
		field = getglobal("AIOBHiddenTooltipTextRight"..index);
		if( field and field:IsVisible() ) then
			right = field:GetText();
		else
			right = "";
		end
		if ( string.find(left, ITEM_SOULBOUND) ) then
			soulbound = 1;
		end
		local iStart, iEnd, val1 = string.find(left, "<Made by (.+)>");
		if (val1) then
			madeBy = val1;
		end
	end
	return soulbound, madeBy;
end

function AIOBFrame_SaveBagInfo(currPlayer, bagIndex, bagName)
	if bagName=="Bank" then
		return 24;
	end
	local bagNum_Slots = GetContainerNumSlots(bagIndex);
	local bagNum_ID    = BankButtonIDToInvSlotID(bagIndex, 1);
	local itemLink     = GetInventoryItemLink("player", bagNum_ID);
	local texture      = GetInventoryItemTexture("player", bagNum_ID);
	local hasCooldown, repairCost = AIOBHiddenTooltip:SetInventoryItem("player", bagNum_ID);
	local soulbound, madeBy = AIOB_GetTooltipData();
	if (itemLink) then
		currPlayer[bagName]= {};
		AIOB_SaveItemData(currPlayer[bagName], itemLink, strsub(texture,17), bagNum_Slots, _ , _ , soulbound, madeBy, _); 
		return bagNum_Slots;
	else
		currPlayer[bagName] = nil;
		return 0;
	end
end
function	AIOBSaveBagItem(currPlayer, bagNewIndex, itemIndex, bagName)
	local itemLink = GetContainerItemLink(bagNewIndex, itemIndex);
	local texture, itemCount, _, itemQuality = GetContainerItemInfo(bagNewIndex, itemIndex);
	local hasCooldown, repairCost;
	if bagNewIndex == BANK_CONTAINER then
		local newIndex = 39 + itemIndex; 
		hasCooldown, repairCost = AIOBHiddenTooltip:SetInventoryItem("player", newIndex);
	else
		hasCooldown, repairCost = AIOBHiddenTooltip:SetBagItem(bagNewIndex, itemIndex);
	end
	local start, duration, enable = GetContainerItemCooldown(bagNewIndex, itemIndex);
	local soulbound, madeBy = AIOB_GetTooltipData();
	local cooldown;
	if hasCooldown and enable > 0 then
		cooldown = {
			["s"] = start,
			["d"] = duration,
			["e"] = enable
		};
	end
	if (itemLink) then
		currPlayer[bagName][itemIndex] = {};
		AIOB_SaveItemData(currPlayer[bagName][itemIndex], itemLink, strsub(texture,17), _, itemCount, itemQuality, soulbound, madeBy, cooldown); 
	else
		currPlayer[bagName][itemIndex] = nil;
	end
end
function AIOB_SaveItemData(AIOBItem, itemLink, texture, Slots, Count, Quality, soulbound, madeBy, Cooldown)
	local myColor, myLink, name;
	local _,_, myColor, myLink, name = strfind(itemLink, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r");
	AIOBItem["name"] = name;
	AIOBItem["i"] = texture;
	AIOBItem["s"] = Slots;
	AIOBItem["c"] = Count;
   AIOBItem["q"] = Quality;
	if (ItemsMatrix_GetLink or LootLink_GetLink) then
		AIOBItem["color"] = nil;
		AIOBItem["item"] = nil;
	else
		AIOBItem["color"] = myColor;
		AIOBItem["item"] = myLink;
	end
	AIOBItem["sb"] = soulbound;
	AIOBItem["m"] = madeBy;
	AIOBItem["d"] = Cooldown;
end

function AIOB_SaveMoney()
	if ( PlayerName ) then
		if ( AIOBProfile[PlayerName] ) then
			AIOBProfile[PlayerName]["money"] = GetMoney();
		end
		if ( AIOB_MoneyFrame:IsVisible() ) then
			MoneyFrame_Update("AIOB_MoneyFrame", bankPlayer.money);
			AIOB_UpdateTotalMoney();
		end
	end
end

function AIOBFrame_SaveItems()
	local currPlayer=AIOBProfile[PlayerName];
	if currPlayer == nil then
		return;
	end
	if not AtBank then
		return;
	end
	AIOB_DEBUG("SaveItems");
	currPlayer.Bags, _ = GetNumBankSlots();
	local bagName, bagMaxIndex, bagNewIndex;
	for bagNum = 0, currPlayer.Bags do
		if bagNum == 0 then -- Is it the bank?
			bagName = "Bank";
			bagNewIndex = BANK_CONTAINER;
		else	-- It's in a bag slot
			bagName = "Bag"..(4+bagNum);
			bagNewIndex = (4+bagNum);
		end
		if (not currPlayer[bagName]) then
			AIOB_DEBUG("Clearing "..bagName);
			currPlayer[bagName] = {} ;
		end
		bagMaxIndex = AIOBFrame_SaveBagInfo(currPlayer, bagNewIndex, bagName);
		for itemIndex = 1, bagMaxIndex do
			AIOBSaveBagItem(currPlayer, bagNewIndex, itemIndex, bagName);
		end
	end
	for bagNum = 5+currPlayer.Bags, 10 do
		currPlayer["Bag"..bagNum] = nil;
	end
	AIOB_SaveMoney();
	AIOBFrame_PopulateFrame();
end


function AIOBFrame_PopulateFrame()
	local texture, itemButton, itemCount, itemQuality;
	local bagName, bagMaxIndex, bagNewIndex;
	local buttonIndex = 1;
	local BlankTexture;
	local maxBags;
	if not bankPlayer then 
		return;
	end
	if bankPlayer.Bags then
		maxBags = bankPlayer.Bags;
	else
		maxBags = 0;
	end
	AIOB_UpdateBagCost(maxBags);
	_, BlankTexture = GetInventorySlotInfo("Bag0Slot");
	for bagNum = 0, maxBags do
		if bagNum == 0 then -- Is it the bank?
			bagName = "Bank";
			bagNewIndex = BANK_CONTAINER;
			bagMaxIndex = 24;
		else
			bagName = "Bag"..(4+bagNum);
			bagNewIndex = (4+bagNum);
			local bagButton = getglobal("AIOBFrameBag"..(bagNewIndex));
			SetItemButtonNormalTextureVertexColor(bagButton, 1.0,1.0,1.0);
			SetItemButtonTextureVertexColor(bagButton, 1.0,1.0,1.0);
			if bankPlayer[bagName] and bankPlayer[bagName]["s"] then
				bagMaxIndex = bankPlayer[bagName]["s"];
				SetItemButtonTexture(bagButton, "Interface\\Icons\\"..bankPlayer[bagName]["i"]);
			else
				bagMaxIndex = 0;
				SetItemButtonTexture(bagButton, BlankTexture);
			end
		end
		for itemIndex = 1,bagMaxIndex do
			itemButton = getglobal("AIOBFrameItem"..buttonIndex);
			buttonIndex = buttonIndex + 1;
			if(bankPlayer and bankPlayer[bagName] and bankPlayer[bagName][itemIndex]) then
				texture = "Interface\\Icons\\"..bankPlayer[bagName][itemIndex]["i"];
				itemCount = bankPlayer[bagName][itemIndex]["c"];	
			else
				texture = nil;
				itemCount = 0;
			end
			if(itemButton) then
				local locked;
				if AtBank then
					texture, itemCount, locked, itemQuality, itemReadable = GetContainerItemInfo(bagNewIndex, itemIndex);
					AIOBFrame_UpdateCooldown(itemButton);
				else
					locked = nil;
				end
				if bankPlayer[bagName] and bankPlayer[bagName][itemIndex] and bankPlayer[bagName][itemIndex]["d"] then
					local cooldown = getglobal(itemButton:GetName().."Cooldown");
					local cooldownInfo = bankPlayer[bagName][itemIndex]["d"];
					if cooldownInfo and cooldownInfo["e"] then
						local start, duration, enable = cooldownInfo["s"], cooldownInfo["d"], cooldownInfo["e"];
						if duration > 0 then
							CooldownFrame_SetTimer(cooldown, start, duration, enable);
						else
							cooldown:Hide();
						end
					else
						cooldown:Hide();
					end
				end
				if bankPlayer[bagName] and bankPlayer[bagName][itemIndex] and bankPlayer[bagName][itemIndex]["q"] then
				   AIOB_UpdateBorder(itemButton, bankPlayer[bagName][itemIndex]["q"]);
				else
				   AIOB_UpdateBorder(itemButton, itemQuality);
				end
				SetItemButtonTexture(itemButton, texture);
				SetItemButtonCount(itemButton, itemCount);
				SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5);
				itemButton.bagIndex = bagNewIndex;
				itemButton.itemIndex= itemIndex;
			end
		end
	end
	for bagNum = 5+maxBags, 10 do
		local bagButton = getglobal("AIOBFrameBag"..(bagNum));
		SetItemButtonNormalTextureVertexColor(bagButton, 1.0,0.1,0.1);
		SetItemButtonTextureVertexColor(bagButton, 1.0,0.1,0.1);
		SetItemButtonTexture(bagButton, BlankTexture);
	end
	if ( bankPlayer and  bankPlayer["money"] ) then
		MoneyFrame_Update("AIOB_MoneyFrame", bankPlayer["money"]);
		AIOB_MoneyFrame:Show();
	else
		AIOB_MoneyFrame:Hide();
	end
	AIOB_UpdateTotalMoney();
	AIOBFrame_UpdateLookIfNeeded();
end




function AIOB_UpdateBorder(itemButton, itemQuality)
   local color = {
      ["r"]=0.5,
      ["g"]=0.5,
      ["b"]=0.5 };
   
   if ( itemQuality ) then
      if itemQuality == -1 then
         color = {
            ["r"]=1,
            ["g"]=1,
            ["b"]=1 } -- white
      elseif itemQuality == 1 then
         color = {
            ["r"]=0.5,
            ["g"]=0.5,
            ["b"]=0.5 } -- grey
      elseif itemQuality == 2 then
         color = {
            ["r"]=0.0,
            ["g"]=1.0,
            ["b"]=0.0 } -- green
      elseif itemQuality == 3 then
         color = {
            ["r"]=0.5,
            ["g"]=0.5,
            ["b"]=1.0 } --  blue
   
      elseif itemQuality == 4 then
         color = {
            ["r"]=0.7,
            ["g"]=0.1,
            ["b"]=1.0 } -- purple
      else
         color = {
            ["r"]=0.0,
            ["g"]=0.0,
            ["b"]=0.0 }  -- black
      end
   end
   SetItemButtonNormalTextureVertexColor(itemButton, color.r, color.g, color.b);
end




-- == Viewing other peoples banks ==
function AIOB_UserDropDown_GetValue()
	if ( bankPlayerName ) then
		return bankPlayerName;
	else
		return (UnitName("player").."|"..AIOB_Trim(GetCVar("realmName")));
	end
end
function AIOB_UserDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, AIOB_UserDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, AIOB_UserDropDown_GetValue());
	AIOBDropDown.tooltip = "You are viewing this player's bank contents.";
	UIDropDownMenu_SetWidth(140, AIOBDropDown);
	OptionsFrame_EnableDropDown(AIOBDropDown);
end

function AIOB_UserDropDown_OnClick()
	if ( not bankPlayer ) then
		return;
	end
	if AtBank then
		CloseBankFrame();
		OpenAIOBFrame();
	end
	-- UIDropDownMenu_SetSelectedValue(AIOBDropDown, this.value);
	if ( this.value ) then
		bankPlayer = AIOB_GetPlayer(this.value);
	end
	AIOBFrame_PopulateFrame();
end

function AIOB_UserDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(AIOBDropDown);
	local info;
	for key, value in AIOBProfile do
		local thisRealmPlayers = AIOB_Split(key, "|")[2];
		if ( table.getn(AIOBProfile[key]) > 0 or AIOBProfile[key].money ) then
			if (AIOBAllRealms == 1 or thisRealmPlayers == AIOB_Trim(GetCVar("realmName")) ) then
				info = {};
				info.text = AIOB_Split(key,"|")[1].." of "..AIOB_Split(key,"|")[2];
				info.value = key;
				info.func = AIOB_UserDropDown_OnClick;
				if ( selectedValue == info.value ) then
					info.checked = 1;
				else
					info.checked = nil;
				end
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function AIOB_ShowAllRealms_Check_OnClick()
		if ( AIOBAllRealms == 0 ) then
			AIOBAllRealms = 1;
		else
			AIOBAllRealms = 0;
		end
		AIOB_UpdateTotalMoney();
end

function AIOB_ShowAllRealms_Check_OnShow()
	if ( AIOBAllRealms == 1 ) then
		this.checked = 1;
	else
		this.checked = nil;
	end
	OptionsFrame_EnableCheckBox(this);
	this:SetChecked(this.checked);
	this.tooltipText = "Check to show all saved characters, regardless of realm.";
end


-- === Toggle Functions ===
-- All toggling of options
function ToggleAIOBFrame()
	if ( AIOBFrame:IsVisible() ) then
		CloseAIOBFrame();
	else
		OpenAIOBFrame();
	end
end
function CloseAIOBFrame()
	if AtBank then
		CloseBankFrame();
	end
	if ( AIOBFrame:IsVisible() ) then
		HideUIPanel(AIOBFrame);
	end
end
function OpenAIOBFrame()
	AIOBFrame_UpdateLookIfNeeded();
	ShowUIPanel(AIOBFrame, 1);
end

function AIOB_Toggle_Option(option, value, quiet)
	if value == nil then
		if getglobal("AIOB"..option) == 1 then
			value = 0;
		else
			value = 1;
		end
	end
	setglobal("AIOB"..option, value);
	AIOBProfile[PlayerName][option] = value;
	if not quiet then
		local chat_message;
		local globalName = "AIOB_CHAT_"..string.upper(option);
		if value == 0 then
			globalName = globalName.."OFF";
		else
			globalName = globalName.."ON";
		end
		chat_message = getglobal(globalName);
		if ( chat_message ) then
			AIOB_Print(chat_message);
		else
			AIOB_DEBUG("ERROR: No global "..globalName);
		end
	end
	if option == "ReplaceBank" then
		AIOB_SetReplaceBank();
	elseif option == "ShowPlayers" or option == "BagView" then
		AIOBFrame_UpdateLook(getglobal("AIOBFrame"),AIOB_GetBagsTotalSlots());
	elseif option == "Graphics" or option == "Background" then
		AIOB_SetGraphics();
		AIOBFrame_UpdateLook(getglobal("AIOBFrame"),AIOB_GetBagsTotalSlots());
	elseif option == "Freeze" then
		AIOB_SetFreeze();
	end
end
function AIOB_SetGraphics()
	if AIOBGraphics == 1 then
		AIOBFrame:SetBackdropColor(0,0,0,0);
		AIOBFrame:SetBackdropBorderColor(0,0,0,0);
		
		AIOBFramePortrait:Show();
		AIOBFrameTextureTopLeft:Show();
		AIOBFrameTextureTopCenter:Show();
		AIOBFrameTextureTopRight:Show();
		AIOBFrameTextureLeft:Show();
		AIOBFrameTextureCenter:Show();
		AIOBFrameTextureRight:Show();
		AIOBFrameTextureBottomLeft:Show();
		AIOBFrameTextureBottomCenter:Show();
		AIOBFrameTextureBottomRight:Show();
		AIOBFrameName:ClearAllPoints();
		AIOBFrameName:SetPoint("TOPLEFT", "AIOBFrame", "TOPLEFT", 70, -8);
		AIOBFrameCloseButton:ClearAllPoints();
		AIOBFrameCloseButton:SetPoint("TOPRIGHT", "AIOBFrame", "TOPRIGHT", 10, 0);
	else
		if AIOBBackground==1 then
			AIOBFrame:SetBackdropColor(0,0,0,0.7);
			AIOBFrame:SetBackdropBorderColor(1,1,1,0.7);
		else
			AIOBFrame:SetBackdropColor(0,0,0,0);
			AIOBFrame:SetBackdropBorderColor(1,1,1,0);
		end
			
		AIOBFramePortrait:Hide();
		AIOBFrameTextureTopLeft:Hide();
		AIOBFrameTextureTopCenter:Hide();
		AIOBFrameTextureTopRight:Hide();
		AIOBFrameTextureLeft:Hide();
		AIOBFrameTextureCenter:Hide();
		AIOBFrameTextureRight:Hide();
		AIOBFrameTextureBottomLeft:Hide();
		AIOBFrameTextureBottomCenter:Hide();
		AIOBFrameTextureBottomRight:Hide();
		AIOBFrameName:ClearAllPoints();
		AIOBFrameName:SetPoint("TOPLEFT", "AIOBFrame", "TOPLEFT", 5, -6);
		AIOBFrameCloseButton:ClearAllPoints();
		AIOBFrameCloseButton:SetPoint("TOPRIGHT", "AIOBFrame", "TOPRIGHT", 2, 2);
	end
end
function AIOB_SetFreeze()
	if AIOBFreeze == 1 then
		AIOBFreezeNormalTexture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\LockButton-Locked-Up");
	else
		AIOBFreezeNormalTexture:SetTexture("Interface\\AddOns\\AllInOneInventory\\Skin\\LockButton-Unlocked-Up");
	end
end

-- SetReplaceBank: Sets if AIOB replaces the official Bank frame
-- Unhooks the Official blizzard frome from the opened and closed events
function AIOB_SetReplaceBank()
	if BankFrame_Saved == nil then
		BankFrame_Saved = getglobal("BankFrame");
	end
	if ( AIOBReplaceBank == 0 ) then
		BankFrame_Saved:RegisterEvent("BANKFRAME_OPENED");
		BankFrame_Saved:RegisterEvent("BANKFRAME_CLOSED");
		setglobal("BankFrame", BankFrame_Saved);
		BankFrame_Saved = nil;
	else
		if BankFrame_Saved:IsVisible() then
			BankFrame_Saved:Hide();
		end
		BankFrame_Saved:UnregisterEvent("BANKFRAME_OPENED");
		BankFrame_Saved:UnregisterEvent("BANKFRAME_CLOSED");
		setglobal("BankFrame", AIOBFrameAtBankText);
	end
end
-- == End Toggle Functions ==

-- Get Link and Get Hyperlink - maintain independance.
function AIOB_GetLink(item)
	if item and item.color and item.item and item.name then
		local link = "|c"..item.color.."|H"..AIOB_GetHyperlink(item).."|h["..item.name.."]|h|r";
		return link;
	end
	return nil;
end

function AIOB_GetHyperlink(item)
	if item and item.item then
		local link = string.gsub(item.item, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:%4");
		return "item:"..link;
	end
	return nil;
end

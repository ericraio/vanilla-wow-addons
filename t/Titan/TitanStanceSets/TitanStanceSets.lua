-- Constants
TITAN_PANEL_UPDATE_BUTTON = 1;
TITAN_PANEL_UDPATE_TOOLTIP = 2;
TITAN_PANEL_UPDATE_ALL = 3;
TITAN_PANEL_LABEL_SEPARATOR = "  "

TITAN_PANEL_BUTTON_TYPE_TEXT = 1;
TITAN_PANEL_BUTTON_TYPE_ICON = 2;
TITAN_PANEL_BUTTON_TYPE_COMBO = 3;
TITAN_PANEL_BUTTON_TYPE_CUSTOM = 4;

TITAN_STANCESETS_ID = "StanceSets";
TITAN_STANCESETS_FREQUENCY = 1;

STANCESET_INDEX = 0;
STANCESET_MAX_STANCES = 5

BINDING_HEADER_STANCESETS = "Stance Sets"
BINDING_NAME_TOGGLESTANCESETSDLG = "Toggle Configuration Pane";
BINDING_NAME_STANCESETNEXT = "Equip Next Weapon Set";

StanceSetsOptions = {};

--UIPanelWindows["StanceSetsFrame"] = { area = "left", pushable = 5 }; 

function TitanOptionSlider_TooltipText(text, value) 
	return text .. GREEN_FONT_COLOR_CODE .. value .. FONT_COLOR_CODE_CLOSE;
end

function TitanPanelStanceSetsButton_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	-- register plugin
	this.registry = { 
		id = TITAN_STANCESETS_ID,
		menuText = STANCESETS_LOCALE["menu"],
		buttonTextFunction = "TitanPanelStanceSetsButton_GetButtonText",
		tooltipTitle = STANCESETS_LOCALE["tooltip"],
		tooltipTextFunction = "TitanPanelStanceSetsButton_GetTooltipText",
		frequency = TITAN_STANCESETS_FREQUENCY, 
		icon = "Interface\\Icons\\Ability_Warrior_ShieldWall",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = TITAN_NIL
		}
	};

end

function TitanPanelStanceSetsButton_OnEvent()
	if(event == "VARIABLES_LOADED") then
		if (StanceSetsOptions.StanceSetsLocked == nil) then
			StanceSetsOptions.StanceSetsLocked = false;
		end
		if (StanceSetsOptions.ShowStance == nil) then
			StanceSetsOptions.ShowStance = true;
		end
	end
end

function TitanPanelStanceSetsButton_GetButtonText(id)
	local retstr = "";

	-- supports turning off labels
	if (TitanGetVar(TITAN_STANCESETS_ID, "ShowLabelText")) then
		if (StanceSetsOptions.ShowStance) then
			retstr =  STANCESETS_LOCALE["button"];
		else
			retstr =  STANCESETS_LOCALE["cbutton"];
		end
	end
	
	if (StanceSetsOptions.ShowStance) then
		if (TitanGetVar(TITAN_STANCESETS_ID, "ShowColoredText")) then	
			retstr = retstr .. TitanUtils_GetGreenText(StanceSets_GetCurrentForm());
		else
			retstr = retstr .. TitanUtils_GetNormalText(StanceSets_GetCurrentForm());
		end
	end

	return retstr;
end

function TitanPanelStanceSetsButton_GetTooltipText()
	local retstr = TitanUtils_GetGreenText("Hint: Left click to open Stance Sets");
	return retstr;
end

function TitanPanelRightClickMenu_PrepareStanceSetsMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_STANCESETS_ID].menuText);
	info = {};
	info.text = ATLAS_OPTIONS_SHOWSTANCE;
	info.func = StanceSetOptions_ShowStanceToggle;
	info.value = ATLAS_OPTIONS_SHOWSTANCE;
	info.checked = StanceSetsOptions.ShowStance;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	info = {};

	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_STANCESETS_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_STANCESETS_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_STANCESETS_ID);
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_STANCESETS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitalPanelStanceSetsButton_OnClick(button)
	if ( button == "LeftButton" ) then
		StanceSets_Toggle();
	end
end

function StanceSetOptions_ShowStanceToggle()
	if(StanceSetsOptions.ShowStance) then
		StanceSetsOptions.ShowStance = false;
	else
		StanceSetsOptions.ShowStance = true;
	end
end

function StanceSets_StartMoving()
	if(not StanceSetsOptions.StanceSetsLocked) then
		StanceSetsFrame:StartMoving();
	end
end

function StanceSets_ToggleLock()
	if(StanceSetsOptions.StanceSetsLocked) then
		StanceSetsOptions.StanceSetsLocked = false;
		StanceSets_UpdateLock();
	else
		StanceSetsOptions.StanceSetsLocked = true;
		StanceSets_UpdateLock();
	end
end

function StanceSets_UpdateLock()
	if(StanceSetsOptions.StanceSetsLocked) then
		StanceSetsLockNorm:SetTexture("Interface\\AddOns\\Titan\\TitanStanceSets\\Images\\LockButton-Locked-Up");
		StanceSetsLockPush:SetTexture("Interface\\AddOns\\Titan\\TitanStanceSets\\Images\\LockButton-Locked-Down");
	else
		StanceSetsLockNorm:SetTexture("Interface\\AddOns\\Titan\\TitanStanceSets\\Images\\LockButton-Unlocked-Up");
		StanceSetsLockPush:SetTexture("Interface\\AddOns\\Titan\\TitanStanceSets\\Images\\LockButton-Unlocked-Down");
	end
end

function StanceSets_OnLoad()
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
	
	tinsert(UISpecialFrames, "StanceSetsFrame");
	UIPanelWindows["StanceSetsFrame"] = nil;
	StanceSetsFrame:RegisterForDrag("LeftButton");
	SlashCmdList["STANCESETS"] = StanceSets_SlashCmd;
	SLASH_STANCESETS1 = "/stancesets";
	
	StanceSets = { };
end

function StanceSets_OnShow()
	return StanceSets_UpdateAllStances();	
end

function StanceSets_OnEvent(event, arg1)
	if event == "UPDATE_BONUS_ACTIONBAR" then
		return StanceSets_FormChanged();
	elseif event == "SPELLS_CHANGED" then 
		return StanceSets_SpellsChanged();
	elseif event == "VARIABLES_LOADED" then
		StanceSets_UpdateLock();
	end
end

function StanceSets_SlashCmd(cmd)
	if cmd and cmd == "next" then
		return StanceSets_Next();
	end
	
	return StanceSets_Toggle();
end

function StanceSets_Toggle()
	if StanceSetsFrame:IsVisible() then
		HideUIPanel(StanceSetsFrame);
	else
		ShowUIPanel(StanceSetsFrame);
	end
end

function StanceSets_SpellsChanged()
	-- Spells have changed, this may mean that we've got a new shapeshift form
	if StanceSetsFrame:IsVisible() then
		return StanceSets_UpdateAllStances();
	end
end

function StanceSet_SetButtonTextureAndName(suffix,texture,itemName)
	local btn = getglobal("StanceSetsFrameSet"..suffix);
	if btn then
		SetItemButtonTexture(btn, texture);
		btn.itemName = itemName;
	end
end

function StanceSet_FindAndSetButtonTexture(suffix, itemName)
	if itemName and itemName ~= "" then
		local bag, slot = WeaponQuickSwap_FindItem(itemName);
		if bag and slot then
			local texture;
			if bag == -1 then
				texture = GetInventoryItemTexture("player", slot);
			else
				texture = GetContainerItemInfo(bag, slot);
			end
			StanceSet_SetButtonTextureAndName(suffix, texture, itemName);
		else
			-- if not found, just use a generic icon
			StanceSet_SetButtonTextureAndName(suffix, "Interface\\Icons\\INV_Misc_Gift_01", itemName);
		end
	else
		-- no item name, no icon
		StanceSet_SetButtonTextureAndName(suffix, nil, itemName);
	end
end

function StanceSets_UpdateAllStances()
	local allstances = StanceSets_GetAllForms();
	
	for i=1,STANCESET_MAX_STANCES do
		local stanceName = allstances[i];
		local frameStance = getglobal("StanceSetsFrameSet"..i);
		local frameLabel = getglobal("StanceSetsFrameSet"..i.."Title");
		
		if frameStance then
			local chkForceFirst = getglobal(frameStance:GetName().."ForceFirst");

			if stanceName then
				frameStance.StanceName = stanceName;
				
				frameStance:Show();
				if frameLabel then frameLabel:SetText(stanceName); end
				
				local playerName = UnitName("player");
				local setName = playerName.."_"..stanceName;
				local stanceSet = StanceSets[setName];
				
				if StanceSets[setName.."_ForceFirst"] then
					chkForceFirst:SetChecked(1);
				else
					chkForceFirst:SetChecked(nil);
				end
				
				if stanceSet then
				  StanceSet_FindAndSetButtonTexture(i.."MainHand1", stanceSet[1]);
				  StanceSet_FindAndSetButtonTexture(i.."OffHand1", stanceSet[2]);
				  StanceSet_FindAndSetButtonTexture(i.."MainHand2", stanceSet[3]);
				  StanceSet_FindAndSetButtonTexture(i.."OffHand2", stanceSet[4]);
				  StanceSet_FindAndSetButtonTexture(i.."MainHand3", stanceSet[5]);
				  StanceSet_FindAndSetButtonTexture(i.."OffHand3", stanceSet[6]);
				else
					StanceSet_SetButtonTextureAndName(i.."MainHand1", nil, nil);
					StanceSet_SetButtonTextureAndName(i.."OffHand1", nil, nil);
					StanceSet_SetButtonTextureAndName(i.."MainHand2", nil, nil);
					StanceSet_SetButtonTextureAndName(i.."OffHand2", nil, nil);
					StanceSet_SetButtonTextureAndName(i.."MainHand3", nil, nil);
					StanceSet_SetButtonTextureAndName(i.."OffHand3", nil, nil);
				end
			else				
				frameStance:Hide();
			end
		end  -- if frame found
	end  -- for i 1,MAX
end

function StanceSets_GetCurrentStanceSet()
	if not StanceSets then return end

	local currentForm = StanceSets_GetCurrentForm();
	local playerName = UnitName("player");
	
	if not playerName then return; end  -- player name might not be defined if not logged yet

	local setName = playerName.."_"..currentForm;
	return StanceSets[setName], setName;
end

function StanceSets_Next()
	local playerFormSet = StanceSets_GetCurrentStanceSet();
	if playerFormSet then
		for i = 1,6 do
			if not playerFormSet[i] and playerFormSet[i+1] then
				playerFormSet[i] = "";
			end
		end
						
		return WeaponSwap(unpack(playerFormSet));
	end
end

function StanceSets_FormChanged()
	local playerFormSet, setName = StanceSets_GetCurrentStanceSet();
	if playerFormSet then
		if StanceSets[setName.."_ForceFirst"] then
			-- must have at least one thing to do a swap
			if playerFormSet[1] or playerFormSet[2] then
				return WeaponSwap(playerFormSet[1], playerFormSet[2]);
			end
		elseif table.getn(playerFormSet) > 0 then
			-- If not forcing a set, only swap if we don't already a known set currently engaged
			local matchingsetidx = WeaponQuickSwap_FindCurrentSetIndex(16, 17, 1, playerFormSet);
			if not matchingsetidx then
				return WeaponSwap(unpack(playerFormSet));
			end
		end
	end
end

function StanceSets_GetCurrentForm()
	for i=1,GetNumShapeshiftForms(),1 do
		local _, name, isActive = GetShapeshiftFormInfo(i);
		if isActive then
			return name;
		end
	end
	
	return "Default";
end

function StanceSets_GetAllForms()
	local retVal = { };
	table.insert(retVal, "Default");
	for i=1,GetNumShapeshiftForms() do
		local _, name = GetShapeshiftFormInfo(i);
		table.insert(retVal, name);
	end
	
	return retVal;
end

function StanceSetSlot_OnEnter()
	if this.itemName and this.itemName ~= "" then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		
		local bag,slot = WeaponQuickSwap_FindItem(this.itemName);
		if bag and slot then
			if bag == -1 then
				GameTooltip:SetInventoryItem("player", slot);
			else
				GameTooltip:SetBagItem(bag,slot);
			end
		else
			GameTooltip:SetText(this.itemName, 1.0, 1.0, 1.0);
		end
		
		GameTooltip:Show();
	end
end

function StanceSetSlot_IDToSlotID(id)
	if id == 1 or id == 3 or id == 5 then
		return 16;
	else
		return 17;
	end
end

function StanceSetSlot_OnDragStart()
	local frmParent = this:GetParent();
	local playerName = UnitName("player");
	local setName = playerName.."_"..frmParent.StanceName;
	
	local stanceSet = StanceSets[setName];
	if stanceSet then
		stanceSet[this:GetID()] = nil;
		ResetCursor();
		StanceSets_UpdateAllStances();
	end
end

function StanceSetSlot_TakeItemOffCursor(srcBag, srcSlot)
	if srcBag == -1 then
		PickupInventoryItem(srcSlot);
	else
		PickupContainerItem(srcBag, srcSlot);
	end
end

function StanceSetSlot_OnReceiveDrag()
	StanceSetSlot_OnClick("LeftButton");
end

function StanceSetSlot_OnClick(arg1)
	local slotID = StanceSetSlot_IDToSlotID(this:GetID());
	
	arg1 = arg1 or "";
	if arg1 == "LeftButton" then
		if CursorHasItem() and StanceSets_PickedupItem then
			local itemName = WeaponQuickSwap_GetItemName(StanceSets_PickedupItem.bag,
				StanceSets_PickedupItem.slot);
				
			if CursorCanGoInSlot(slotID) then
				local frmParent = this:GetParent();
				local playerName = UnitName("player");
				local setName = playerName.."_"..frmParent.StanceName;
		
				local stanceSet = StanceSets[setName];
				if not stanceSet then stanceSet = {}; end
				stanceSet[this:GetID()] = itemName;
				StanceSets[setName] = stanceSet;
					
				StanceSets_UpdateAllStances();
			else
				Print(itemName.." can not go in that slot!");
			end
	
			ResetCursor();
			StanceSetSlot_TakeItemOffCursor(StanceSets_PickedupItem.bag,StanceSets_PickedupItem.slot);
		end  -- if has item and we know where it came from

		StanceSets_PickedupItem = nil;	
	end  -- if left button
end

local StanceSets_Save_PickupContainerItem = PickupContainerItem;
PickupContainerItem = function (bag,slot)
	StanceSets_PickedupItem = { };
	StanceSets_PickedupItem.bag = bag;
	StanceSets_PickedupItem.slot = slot;
	return StanceSets_Save_PickupContainerItem(bag,slot);
end

local StanceSets_Save_PickupInventoryItem = PickupInventoryItem;
PickupInventoryItem = function (slot)
	StanceSets_PickedupItem = { };
	StanceSets_PickedupItem.bag = -1;
	StanceSets_PickedupItem.slot = slot;
	return StanceSets_Save_PickupInventoryItem(slot);
end

function StanceSetsForceCheck_OnClick()
	local frmParent = this:GetParent();
	local playerName = UnitName("player");
	local setName = playerName.."_"..frmParent.StanceName.."_ForceFirst";
	
	if not StanceSets then StanceSets = { }; end
	
	if (this:GetChecked()) then
		StanceSets[setName] = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		StanceSets[setName] = nil;
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
end

function DebugReport(msg, color, bSecondChatWindow)
	local r = 0.50;
	local g = 0.50;
	local b = 1.00;

	if (color) then
		r = color.r;
		g = color.g;
		b = color.b;
	end

	local frame = DEFAULT_CHAT_FRAME;
	if (bSecondChatWindow) then
		frame = ChatFrame2;
	end

	if (frame) then
		frame:AddMessage(msg,r,g,b);
	end
end

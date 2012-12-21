--============================================================================================--
--============================================================================================--
--																							--
--							  INTERFACE FUNCTIONS											 --
--																							--
--============================================================================================--
--============================================================================================--

local function TEXT(key) return Localization.GetString("Wardrobe", key) end

WARDROBE_TEXTCOLORS = {
	{1.00, 0.00, 0.00},	-- red
	{1.00, 0.50, 0.50},	-- light red
	{1.00, 0.50, 0.00},	-- orange
	{1.00, 0.75, 0.50},	-- light orange
	{1.00, 0.75, 0.00},	-- gold
	{1.00, 0.87, 0.50},	-- light gold

	{1.00, 1.00, 0.00},	-- yellow
	{1.00, 1.00, 0.50},	-- light yellow
	{0.50, 1.00, 0.00},	-- yellow-green
	{0.75, 1.00, 0.50},	-- light yellow-green
	{0.00, 1.00, 0.00},	-- green
	{0.50, 1.00, 0.50},	-- light green

	{0.00, 1.00, 0.50},	-- blue-green
	{0.50, 1.00, 0.75},	-- light blue-green
	{0.00, 1.00, 1.00},	-- cyan
	{0.50, 1.00, 1.00},	-- light cyan
	{0.00, 0.00, 1.00},	-- blue
	{0.50, 0.50, 1.00},	-- light blue

	{0.50, 0.00, 1.00},	-- blue-purple
	{0.75, 0.50, 1.00},	-- light blue-purple
	{1.00, 0.00, 1.00},	-- purple
	{1.00, 0.50, 1.00},	-- light purple
	{1.00, 0.00, 0.50},	-- pink-red
	{1.00, 0.50, 0.75}	 -- light pink-red
};

WARDROBE_DRABCOLORS = {
	{0.50, 0.00, 0.00},	-- red
	{0.50, 0.25, 0.25},	-- light red
	{0.50, 0.25, 0.00},	-- orange
	{0.50, 0.38, 0.25},	-- light orange
	{0.50, 0.38, 0.00},	-- gold
	{0.50, 0.43, 0.25},	-- light gold
	
	{0.50, 0.50, 0.00},	-- yellow
	{0.50, 0.50, 0.25},	-- light yellow
	{0.25, 0.50, 0.00},	-- yellow-green
	{0.38, 0.50, 0.25},	-- light yellow-green
	{0.00, 0.50, 0.00},	-- green
	{0.25, 0.50, 0.25},	-- light green
	
	{0.00, 0.50, 0.25},	-- blue-green
	{0.25, 0.50, 0.38},	-- light blue-green
	{0.00, 0.50, 0.50},	-- cyan
	{0.25, 0.50, 0.50},	-- light cyan
	{0.00, 0.00, 0.50},	-- blue
	{0.25, 0.25, 0.50},	-- light blue
	
	{0.25, 0.00, 0.50},	-- blue-purple
	{0.38, 0.25, 0.50},	-- light blue-purple
	{0.50, 0.00, 0.50},	-- purple
	{0.50, 0.25, 0.50},	-- light purple
	{0.50, 0.00, 0.25},	-- pink-red
	{0.50, 0.25, 0.38},	-- light pink-red
};

WARDROBE_UNAVAILIBLECOLOR = {0.70, 0.76, 0.65};

--===============================================================================
--
-- UI Menu and Button
--
--===============================================================================

---------------------------------------------------------------------------------
-- Start dragging the wardrobe button
---------------------------------------------------------------------------------
function Wardrobe.OnDragStart()
	if (not Wardrobe.DragLock) then
		Wardrobe.IconFrame:StartMoving()
		Wardrobe.BeingDragged = true;
	end
end


---------------------------------------------------------------------------------
-- Stop dragging the wardrobe button
---------------------------------------------------------------------------------
function Wardrobe.OnDragStop()
	if (Wardrobe.BeingDragged) then
		Wardrobe.IconFrame:StopMovingOrSizing()
		Wardrobe.BeingDragged = false;
		local x,y = this:GetCenter();
		local px,py = this:GetParent():GetCenter();
		local ox = x-px;
		local oy = y-py;
		Wardrobe_Config.xOffset = ox;
		Wardrobe_Config.yOffset = oy;
	end
end

---------------------------------------------------------------------------------
-- Set the DropDownMenu Scale
---------------------------------------------------------------------------------
function Wardrobe.SetDropDownScale(scale)
	scale = tonumber(scale);
	if (not scale) then
		scale = 1;
	end
	if (scale > 1 or scale < .5) then
		Wardrobe.ShowHelp();
		return;
	end
	Wardrobe_Config.DropDownScale = scale;
	DropDownList1:SetScale(scale);
	DropDownList2:SetScale(scale);
	DropDownList3:SetScale(scale);
end

---------------------------------------------------------------------------------
-- Toggle whether the wardrobe button can be moved or not
---------------------------------------------------------------------------------
function Wardrobe.ToggleLockButton(toggle)
	Wardrobe.DragLock = toggle;
	if (Wardrobe.DragLock) then
		Wardrobe.Print(TEXT("TXT_BUTTONLOCKED"));
	else
		Wardrobe.Print(TEXT("TXT_BUTTONUNLOCKED"));
	end
end

---------------------------------------------------------------------------------
-- Toggle whether the wardrobe menu requires a click of the button to show
---------------------------------------------------------------------------------
function Wardrobe.ToggleClickButton(toggle)
	Wardrobe_Config.MustClickUIButton = toggle;
	if (Wardrobe_Config.MustClickUIButton) then
		Wardrobe.Print(TEXT("TXT_BUTTONONCLICK"));
	else
		Wardrobe.Print(TEXT("TXT_BUTTONONMOUSEOVER"));
	end
end


---------------------------------------------------------------------------------
-- Register the wardrobe button 
---------------------------------------------------------------------------------
function Wardrobe.ButtonOnLoad()
	this:RegisterForDrag("LeftButton");
	if (MobileMinimapButtons_AddButton) then
		MobileMinimapButtons_AddButton("Wardrobe_IconFrame", TEXT("TXT_WARDROBEBUTTON"));
	end
end


---------------------------------------------------------------------------------
-- Update function for showing/hiding the wardrobe button 
---------------------------------------------------------------------------------
function Wardrobe.ButtonUpdateVisibility()
	if (TitanGetVar) then
		if (TitanGetVar(WARDROBE_TITAN_ID, "ShowMinimapIcon")) then
    		Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 1;
        	Wardrobe.IconFrame:Show();
        else
        	Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 0;
			Wardrobe.IconFrame:Hide();
		end
    elseif (not Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible) or (Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible == 1) then
    	Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 1;
    	Wardrobe.IconFrame:Show();
    else
        Wardrobe.IconFrame:Hide();
    end
end


---------------------------------------------------------------------------------
-- When the user clicks on the UI button (currently disabled)
---------------------------------------------------------------------------------
function Wardrobe.HandleUIMenuTriggerClick()
	if (Wardrobe_Config.MustClickUIButton) then
		Wardrobe.ShowUIMenu();
	end			
end


---------------------------------------------------------------------------------
-- When the user mouses over the UI button
---------------------------------------------------------------------------------
function Wardrobe.HandleUIMenuTriggerEnter()
	if (not Wardrobe_Config.MustClickUIButton) then
		Wardrobe.ShowUIMenu();
	end
end


---------------------------------------------------------------------------------
-- When the user mouses off the UI button
---------------------------------------------------------------------------------
function Wardrobe.HandleUIMenuTriggerLeave()
	GameTooltip:Hide();
end


---------------------------------------------------------------------------------
-- Show the UI menu
---------------------------------------------------------------------------------
function Wardrobe.ShowUIMenu()
	ToggleDropDownMenu(1, nil, WardrobeDropDown, this:GetName(), 0, 0, "TOPRIGHT");
end

function Wardrobe.DropDown_OnLoad()
	-- Fake menu frame.... who says you need a frame, bah!
	WardrobeDropDown = {
		initialize = Wardrobe.LoadDropDownMenu;
		GetName = function() return "WardrobeDropDown" end;
		SetHeight = function() end;
	}
end

function Wardrobe.LoadDropDownMenu()
	
	local outfitList = Wardrobe.GetListOfOutfits();
	local dropdownList = {};
	
	--Title
	local info = {};
	info.text = UnitName("player").."'s "..TEXT("TEXT_MENU_TITLE");
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, 1);
	
	for i, text in outfitList do
		info = {};
		info.text = text;
		info.arg1 = i;
		info.notCheckable = true;
		info.justifyH = "CENTER";
		info.func = Wardrobe.WearOutfit;
		UIDropDownMenu_AddButton(info, 1);
	end
	
	info = {};
	info.text = TEXT("TEXT_MENU_OPEN");
	info.notCheckable = true;
	info.justifyH = "CENTER";
	info.func = Wardrobe.ShowMainMenu;
	UIDropDownMenu_AddButton(info, 1);
	
end


---------------------------------------------------------------------------------
-- Handle keybinding clicks
---------------------------------------------------------------------------------
function Wardrobe.Keybinding(outfitNum)
	if (outfitNum <= table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit)) then
		Wardrobe.WearOutfit(Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].OutfitName);
	end
end


--===============================================================================
--
-- Confirmation windows
--
--===============================================================================

---------------------------------------------------------------------------------
-- Confirm a popup menu
---------------------------------------------------------------------------------
function Wardrobe.PopupConfirm_OnClick()

	Wardrobe.NamePopup:Hide();
	Wardrobe.PopupConfirm:Hide();

	if (Wardrobe.PopupFunction == "[Add]") then
		Wardrobe.NewWardrobeName = Wardrobe.NamePopupEditBox:GetText();
		Wardrobe.ShowWardrobe_ConfigurationScreen();
	elseif (Wardrobe.PopupFunction == "[Delete]" or Wardrobe.PopupFunction == "DeleteFromSort") then
		Wardrobe.EraseOutfit(Wardrobe.NamePopupEditBox:GetText());
		if (Wardrobe.PopupFunction == "DeleteFromSort") then
			Wardrobe.PopulateMainMenu();
			Wardrobe.ToggleMainMenuFrameVisibility(true);
		end
		Wardrobe.PopupFunction = "";
	elseif (Wardrobe.PopupFunction == "[Edit]") then
		Wardrobe.NewWardrobeName = Wardrobe.NamePopupEditBox:GetText();
		Wardrobe.RenameOutfit(Wardrobe.Rename_OldName, Wardrobe.NewWardrobeName);
		Wardrobe.StoreVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME, Wardrobe.NewWardrobeName);
		Wardrobe.WearOutfit(Wardrobe.NewWardrobeName, true);
		Wardrobe.PopupFunction = "[Update]";
		Wardrobe.ShowWardrobe_ConfigurationScreen();
	elseif (Wardrobe.PopupFunction == "[Update]") then
		Wardrobe.NewWardrobeName = Wardrobe.NamePopupEditBox:GetText();
		Wardrobe.ShowWardrobe_ConfigurationScreen();
	elseif (Wardrobe.PopupFunction == "[Mounted]") then
		if (not Wardrobe.FoundOutfitName(Wardrobe.NamePopupEditBox:GetText()) or Wardrobe.NamePopupEditBox:GetText() == "") then
			Wardrobe.Print(TEXT("TXT_MOUNTEDNOTEXIST"));
			UIErrorsFrame:AddMessage(TEXT("TXT_NOTEXISTERROR"), 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			Wardrobe.PopupFunction = "";
		else
			Wardrobe.SetMountedOutfit(Wardrobe.NamePopupEditBox:GetText());
			Wardrobe.PopupFunction = "";
		end
	end
		
end


---------------------------------------------------------------------------------
-- Cancel a popup menu
---------------------------------------------------------------------------------
function Wardrobe.PopupCancel_OnClick()
	Wardrobe.NamePopup:Hide();
	Wardrobe.PopupConfirm:Hide();
	if (Wardrobe.PopupFunction == "DeleteFromSort") then
		Wardrobe.ToggleMainMenuFrameVisibility(true);
	end
end



--===============================================================================
--
-- Paperdoll configuration windows
--
--===============================================================================

---------------------------------------------------------------------------------
-- Show the screen that lets the user confirm his/her wardrobe selection (check off items, etc)
---------------------------------------------------------------------------------
function Wardrobe.ShowWardrobe_ConfigurationScreen()

	Wardrobe.CheckboxToggleState = Wardrobe_Config.DefaultCheckboxState;
	Wardrobe.CurrentOutfitButtonColor = WARDROBE_DEFAULT_BUTTON_COLOR;
	
	for i, slotName in Wardrobe.InventorySlots do
		getglobal("Character"..slotName.."WardrobeCheckBox"):SetCheckedTexture("Interface\\AddOns\\Wardrobe\\Images\\Check");
		--getglobal("Character"..Wardrobe.InventorySlots[i].."WardrobeCheckBox"):SetDisabledCheckedTexture("Interface\\AddOns\\Wardrobe\\Images\\X");
	end

	if (Wardrobe.PopupFunction == "[Add]") then
		if (Wardrobe_Config.DefaultCheckboxState == 1 or Wardrobe_Config.DefaultCheckboxState == 0) then
			for i, slotName in Wardrobe.InventorySlots do
				getglobal("Character"..slotName.."WardrobeCheckBox"):SetChecked(Wardrobe_Config.DefaultCheckboxState);
			end
		else
			Wardrobe.Print(TEXT("TXT_WARDROBENAME")..tostring(Wardrobe_Config.DefaultCheckboxState));
		end
		
	elseif (Wardrobe.PopupFunction == "[Update]") then
	
		-- for each outfit
		for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
			
			-- if it's the wardrobe we're updating
			if (outfit.OutfitName == Wardrobe.NewWardrobeName) then

				Wardrobe.CurrentOutfitButtonColor = outfit.ButtonColor;
				
				-- for each item in the outfit, set the checkbox
				for j=1, Wardrobe.InventorySlotsSize do
					local IsSlotUsed;
					if (not outfit.Item[j]) or (outfit.Item[j].IsSlotUsed ~= 1) then
						IsSlotUsed = 0;
					else
						IsSlotUsed = 1;
					end
					local checkBoxName = "Character"..Wardrobe.InventorySlots[j].."WardrobeCheckBox";
					getglobal(checkBoxName):SetChecked(IsSlotUsed);
				end
				break;
			end
		end
	end
	
	-- show the character paperdoll frame
	Wardrobe.ToggleCharacterPanel();
	
end


---------------------------------------------------------------------------------
-- Toggle the visibility of the character panel
---------------------------------------------------------------------------------
function Wardrobe.ToggleCharacterPanel(dontToggleChar)
	if (not Wardrobe.InToggleCharacterPanel) then
		Wardrobe.InToggleCharacterPanel = true;
		if (Wardrobe.ShowingCharacterPanel == false) then
			if (not dontToggleChar and (not PaperDollFrame:IsVisible())) then
				ToggleCharacter("PaperDollFrame");
			end
			Wardrobe.CheckboxesFrame:Show();
			Wardrobe.Orig_HideUIPanel = HideUIPanel;
			HideUIPanel = Wardrobe.HideUIPanel;
			Wardrobe.RefreshCharacterPanel();
			Wardrobe.ColorCycle_CharacterFrame(true);
			Wardrobe.ShowingCharacterPanel = true;
		else
			Wardrobe.CheckboxesFrame:Hide();
			CharacterNameText:SetText(UnitPVPName("player"));
			Wardrobe.ColorCycle_CharacterFrame(false);
			CharacterNameText:SetTextColor(1,1,1);
			Wardrobe.ShowingCharacterPanel = false;
			if (not dontToggleChar) then
				ToggleCharacter("PaperDollFrame");
			end
		end

		Wardrobe.InToggleCharacterPanel = false;
	end
end


---------------------------------------------------------------------------------
-- Refresh the character panel
---------------------------------------------------------------------------------
function Wardrobe.RefreshCharacterPanel()
	CharacterNameText:SetText(Wardrobe.NewWardrobeName);
	CharacterNameText:SetTextColor(WARDROBE_TEXTCOLORS[Wardrobe.CurrentOutfitButtonColor][1],WARDROBE_TEXTCOLORS[Wardrobe.CurrentOutfitButtonColor][2],WARDROBE_TEXTCOLORS[Wardrobe.CurrentOutfitButtonColor][3]);
end


---------------------------------------------------------------------------------
-- Turn on or off color cycling on the character panel
---------------------------------------------------------------------------------
function Wardrobe.ColorCycle_CharacterFrame(toggle)
	if (ColorCycle_AddTableEntry) then
		if (toggle) then
			for i = 1, table.getn(Wardrobe.InventorySlots) do
				ColorCycle_PulseWhite(
					{
						ID = "Character"..Wardrobe.InventorySlots[i].."WardrobeCheckBoxGlow";
						globalName = "Character"..Wardrobe.InventorySlots[i].."WardrobeCheckBoxGlow";
						cycleType  = "Texture";
						color	  = {0.0, 0.0, 0.0};
						speed	  = 0.05;
						pause	  = 0.25;
					}
				);	
			end			 
		else
			for i = 1, table.getn(Wardrobe.InventorySlots) do
				ColorCycle_PulseWhite(
					{
						ID	  = "Character"..Wardrobe.InventorySlots[i].."WardrobeCheckBoxGlow";
						remove  = true;
					}
				);	
			end
		end
	end
end

---------------------------------------------------------------------------------
-- Hook the HideUIPanel function so that we can trap when the user closes the character panel
---------------------------------------------------------------------------------
function Wardrobe.HideUIPanel(theFrame)

	Wardrobe.Orig_HideUIPanel(theFrame);
	
	if (theFrame == getglobal("CharacterFrame")) then
		Wardrobe.CheckboxesFrame:Hide();		
		Wardrobe.ToggleCharacterPanel(true);
		HideUIPanel = Wardrobe.Orig_HideUIPanel;
		if (not Wardrobe.PressedAcceptButton) then
			UIErrorsFrame:AddMessage(TEXT("TXT_CHANGECANCELED"), 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME); 
		end
		
		-- check to see if we should re-equip our previous outfit
		Wardrobe.CheckForEquipVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME);
	end
	
	Wardrobe.PressedAcceptButton = false;
end


---------------------------------------------------------------------------------
-- Handle when the user clicks the button to toggle all the checkboxes
---------------------------------------------------------------------------------
function Wardrobe.ToggleCheckboxes()
	if (Wardrobe.CheckboxToggleState == 1) then
		Wardrobe.CheckboxToggleState = 0;
	else
		Wardrobe.CheckboxToggleState = 1;
	end
	for i, slotName in Wardrobe.InventorySlots do
		getglobal("Character"..slotName.."WardrobeCheckBox"):SetChecked(Wardrobe.CheckboxToggleState);
	end	
end


---------------------------------------------------------------------------------
-- When the user accepts the wardrobe confirmation screen
---------------------------------------------------------------------------------
function Wardrobe.ConfirmWardrobeConfigurationScreen()

	-- remember which items were checked and unchecked for this outfit
	Wardrobe.ItemCheckState = { };
	for i, slotName in Wardrobe.InventorySlots do
		if (getglobal("Character"..slotName.."WardrobeCheckBox"):GetChecked()) then
			Wardrobe.ItemCheckState[i] = 1;
		end
	end
	
	if (CharacterMainHandSlotWardrobeCheckBox:GetChecked() == 1) and (CharacterSecondaryHandSlotWardrobeCheckBox:GetChecked() == 1) then
		--Check for 2h in Main slot and dissable offhand
	end
	
	if (Wardrobe.PopupFunction == "[Add]") then
		Wardrobe.AddNewOutfit(Wardrobe.NewWardrobeName, Wardrobe.CurrentOutfitButtonColor);
		Wardrobe.PopupFunction = "";
	elseif (Wardrobe.PopupFunction == "[Update]") then
		Wardrobe.UpdateOutfit(Wardrobe.NewWardrobeName, Wardrobe.CurrentOutfitButtonColor);
		Wardrobe.PopupFunction = "";
		
		-- check to see if we should re-equip our previous outfit
		Wardrobe.CheckForEquipVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME);
	end
	
	Wardrobe.PressedAcceptButton = true;
	Wardrobe.ToggleCharacterPanel();
end


---------------------------------------------------------------------------------
-- When the user rejects the wardrobe confirmation screen
---------------------------------------------------------------------------------
function Wardrobe.CancelWardrobe_ConfigurationScreen()
	-- check to see if we should re-equip our previous outfit
	Wardrobe.CheckForEquipVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME);
end


--===============================================================================
--
-- Main menu
--
--===============================================================================

---------------------------------------------------------------------------------
-- Show the main menu
---------------------------------------------------------------------------------
function Wardrobe.ShowMainMenu()

	Wardrobe.CheckForOurWardrobeID();
	
	-- clear any selected outfits
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
		outfit.Selected = false;
	end
	
	Wardrobe.ToggleMainMenuFrameVisibility(true);
	Wardrobe.PopulateMainMenu();
end


---------------------------------------------------------------------------------
-- Toggle the main menu visibility and color cycling
---------------------------------------------------------------------------------
function Wardrobe.ToggleMainMenuFrameVisibility(toggle)
	if (toggle) then
		Wardrobe.MainMenuFrame:Show();
	else
		Wardrobe.MainMenuFrame:Hide();
	end
	
	-- toggle color cycling
	Wardrobe.ColorCycle_MainMenuFrame(toggle);
end


---------------------------------------------------------------------------------
-- Start or stop color cycling on the modification frame
---------------------------------------------------------------------------------
function Wardrobe.ColorCycle_MainMenuFrame(toggle)
	if (ColorCycle_AddTableEntry) then
		if (toggle) then
			ColorCycle_AddTableEntry(
				{
					ID		  = "Wardrobe_MainMenuFrameTitle";
					cycleType   = "FontText";
					globalName  = "Wardrobe_MainMenuFrameTitle";
					cycleSpeed  = 0.01;
					okToWait	= {true, true, true};
				}
			);
		else
		
			-- turn off color cycling on the selected outfit
			for i = 1, WARDROBE_MAX_SCROLL_ENTRIES do
				local fs = Wardrobe["MainMenuFrameEntry"..i.."Outfit"];
				if (frameName ~= "Wardrobe_MainMenuFrameEntry"..i) then
					if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum]) then
						Wardrobe.SetSelectionColor(false, "Wardrobe_MainMenuFrameEntry"..i.."Outfit", fs)
					end
				end
			end
			ColorCycle_RemoveEntry("Wardrobe_MainMenuFrameTitle");
		end
	end
end


---------------------------------------------------------------------------------
-- Populate the main menu
---------------------------------------------------------------------------------
function Wardrobe.PopulateMainMenu(maintainSelected)
	Wardrobe.Debug("PopulateMainMenu");

	Wardrobe.CheckForOurWardrobeID();
		
	Wardrobe.SortOutfits();
	
	-- clear any selected item
	for rowCount = 1, WARDROBE_MAX_SCROLL_ENTRIES do
		Wardrobe.SetSelectionColor(false, "Wardrobe_MainMenuFrameEntry"..rowCount.."Outfit", Wardrobe["MainMenuFrameEntry"..rowCount.."Outfit"]);
	end
	
	local fs, totalExistingEntries, totalEntriesShown;
	local rowCount = 1;
	local entryCount = 1;
	local offset = FauxScrollFrame_GetOffset(Wardrobe.SortScrollFrame);
	Wardrobe.Debug("offset = "..offset);
	
	for i = 1, 21 do
		Wardrobe["MainMenuFrameEntry"..i.."Icon"]:Hide();
	end
	
	while rowCount <= WARDROBE_MAX_SCROLL_ENTRIES do

		Wardrobe.Debug("rowCount = "..rowCount);
		Wardrobe.Debug("entryCount = "..entryCount);
		fs = Wardrobe["MainMenuFrameEntry"..rowCount.."Outfit"];
		local outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset];
		if (not outfit) then
			fs:SetText("");
			fs.r = 0;
			fs.g = 0;
			fs.b = 0;
			Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:Hide();
			rowCount = rowCount + 1;
			
		-- if this isn't a virtual outfit
		elseif (not outfit.Virtual) then
			Wardrobe.Debug("Wasn't Virtual.  Setting text to: "..outfit.OutfitName);
			fs:SetText(outfit.OutfitName);
			local buttonColor = outfit.ButtonColor;
			fs.r = WARDROBE_TEXTCOLORS[buttonColor][1];
			fs.g = WARDROBE_TEXTCOLORS[buttonColor][2];
			fs.b = WARDROBE_TEXTCOLORS[buttonColor][3];
			if (not maintainSelected) then
				--Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset].Selected = false;
			end;
			
			-- if this outfit is selected, highlight it
			if (outfit.Selected) then
				Wardrobe.SetSelectionColor(true, "Wardrobe_MainMenuFrameEntry"..rowCount.."Outfit", fs);
			else
				fs:SetTextColor(fs.r, fs.g, fs.b);
			end
			
			-- check to see if we should show the mounted icon
			if (outfit.Special == "mounted") then
				-- set the texture
				Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:SetNormalTexture("Interface\\AddOns\\Wardrobe\\Images\\Paw");
				Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:Show();

			-- check to see if we should show the plaguelands icon
			elseif (outfit.Special == "plague") then
				-- set the texture
				Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:SetNormalTexture("Interface\\AddOns\\Wardrobe\\Images\\Sword");
				Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:Show();

			-- check to see if we should show the while-eating icon
			elseif (outfit.Special == "chowing") then
				-- set the texture
				Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:SetNormalTexture("Interface\\AddOns\\Wardrobe\\Images\\Food");
				Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:Show();

			else
				Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:Hide();
			end
			rowCount = rowCount + 1; 
		else
			Wardrobe.Debug("Was Virtual");
			Wardrobe["MainMenuFrameEntry"..rowCount.."Icon"]:Hide();
		end
		fs.OutfitNum = entryCount + offset;
		entryCount = entryCount + 1;
	end

	FauxScrollFrame_Update(Wardrobe.SortScrollFrame, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit), WARDROBE_MAX_SCROLL_ENTRIES, WARDROBE_MAX_SCROLL_ENTRIES);

	return entryCount, rowCount;	
end


---------------------------------------------------------------------------------
-- when mousing over an entry in the outfit menu, highlight it
---------------------------------------------------------------------------------
function Wardrobe.MainMenuFrameEntry_OnEnter()
	local frameName, number = string.gsub(this:GetName(), "^Wardrobe_", "");
	Wardrobe[frameName.."Outfit"]:SetTextColor(1.0, 1.0, 1.0);
end


---------------------------------------------------------------------------------
-- when the mouse leaves an entry in the outfit menu, return it to its normal color (unless it's selected)
---------------------------------------------------------------------------------
function Wardrobe.MainMenuFrameEntry_OnLeave()
	local frameName, number = string.gsub(this:GetName(), "^Wardrobe_", "");
	local fs = Wardrobe[frameName.."Outfit"];
	if (fs.OutfitNum) and (Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum]) and (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum].Selected) then
		fs:SetTextColor(fs.r, fs.g, fs.b);
	end	
end


---------------------------------------------------------------------------------
-- when clicking on an entry in the outfit menu
---------------------------------------------------------------------------------
function Wardrobe.MainMenuFrameEntry_OnClick()
	
	--local frameName = this:GetName();
	local frameName, number = string.gsub(this:GetName(), "^Wardrobe_", "");

	-- unselect all items
	Wardrobe.UnselectAllMainMenuItems();
	
	-- select this item
	local fs = Wardrobe[frameName.."Outfit"];
	if (fs) and (fs.OutfitNum) then
		local outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum];
		if (outfit) then
			if (not outfit.Selected) then
				outfit.Selected = true;
				Wardrobe.SetSelectionColor(true, "Wardrobe_"..frameName.."Outfit", fs);
			else
				outfit.Selected = false;
			end
		end	
	end	
end


---------------------------------------------------------------------------------
-- unselect all the outfits in the main menu
---------------------------------------------------------------------------------
function Wardrobe.UnselectAllMainMenuItems()

	-- unselect all the other buttons
	for i = 1, WARDROBE_MAX_SCROLL_ENTRIES do
		Wardrobe.SetSelectionColor(false, "Wardrobe_MainMenuFrameEntry"..i.."Outfit", Wardrobe["MainMenuFrameEntry"..i.."Outfit"]);
	end
	
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
		outfit.Selected = false;
	end
end


---------------------------------------------------------------------------------
-- set or unset the color of the selected outfit text in the main menu
---------------------------------------------------------------------------------
function Wardrobe.SetSelectionColor(toggle, theGlobal, fs)
	if (toggle) then
		if (ColorCycle_AddTableEntry) then
			ColorCycle_FlashWhite(
				{
					ID = theGlobal;
					cycleType = "FontText";
					globalName = theGlobal;
					color = {fs.r, fs.g, fs.b};
				}
			);
		else
			fs:SetTextColor(1, 1, 1);
		end
	else
		if (ColorCycle_AddTableEntry) then
			ColorCycle_FlashWhite(
				{
					ID = theGlobal;
					remove = true;
				}
			);
		end				
		fs:SetTextColor(fs.r, fs.g, fs.b);
	end
end


--===============================================================================
--
-- Main menu buttons
--
--===============================================================================

---------------------------------------------------------------------------------
-- when clicking on the new outfit button
---------------------------------------------------------------------------------
function Wardrobe.NewOutfitButtonClick()
	Wardrobe.NamePopupText:SetText(TEXT("TXT_NEWOUTFITNAME"));
	Wardrobe.PopupFunction = "[Add]";
	Wardrobe.UnselectAllMainMenuItems();	
	Wardrobe.ToggleMainMenuFrameVisibility(false);	
	Wardrobe.NamePopup:Show();
end


---------------------------------------------------------------------------------
-- when clicking on the close button
---------------------------------------------------------------------------------
function Wardrobe.MainMenuCloseButton()
	Wardrobe.ColorCycle_MainMenuFrame(false);
	this:GetParent():Hide();
end


---------------------------------------------------------------------------------
-- when clicking on the edit outfit button
---------------------------------------------------------------------------------
function Wardrobe.EditOutfitButtonClick()
	local selectedOutfit = Wardrobe.FindSelectedOutfit();	
	
	if (selectedOutfit) then
		Wardrobe.NewWardrobeName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName;
		Wardrobe.Rename_OldName = Wardrobe.NewWardrobeName;
		Wardrobe.NamePopupText:SetText("New Name");
		Wardrobe.NamePopupEditBox:SetText(Wardrobe.NewWardrobeName);
		Wardrobe.PopupFunction = "[Edit]";
		Wardrobe.ToggleMainMenuFrameVisibility(false);	
		Wardrobe.NamePopup:Show();
	end
end


---------------------------------------------------------------------------------
-- when clicking on the update outfit button
---------------------------------------------------------------------------------
function Wardrobe.UpdateOutfitButtonClick()
	local selectedOutfit = Wardrobe.FindSelectedOutfit();	
	
	if (selectedOutfit) then
		Wardrobe.NewWardrobeName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName;
		Wardrobe.PopupFunction = "[Update]";
		Wardrobe.ShowWardrobe_ConfigurationScreen();
	end
end



---------------------------------------------------------------------------------
-- When clicking the special buttons
---------------------------------------------------------------------------------
local WARDROBE_TXT_NOLONGERWORN = {
	mounted = function() return TEXT("TXT_NOLONGERWORNMOUNTERR") end;
	plague = function() return TEXT("TXT_NOLONGERWORNPLAGUEERR") end;
	chowing = function() return TEXT("TXT_NOLONGERWORNEATERR") end;
	swimming = function() return TEXT("TXT_NOLONGERWORNSWIMR") end;
};

local WARDROBE_TXT_WORNWHEN = {
	mounted = function() return TEXT("TXT_WORNWHENMOUNTERR") end;
	plague = function() return TEXT("TXT_WORNPLAGUEERR") end;
	chowing = function() return TEXT("TXT_WORNEATERR") end;
	swimming = function() return TEXT("TXT_WORNSWIMR") end;
};

function Wardrobe.SpecialButtonClick(specialType)
	local outfitNum = Wardrobe.FindSelectedOutfit();
	local alreadyUsingThisOutfitForSpecial = false;
	
	if (outfitNum) then
		local outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum];
		if (outfit.Special == specialType) then
			UIErrorsFrame:AddMessage(outfit.OutfitName.." "..WARDROBE_TXT_NOLONGERWORN[specialType](), 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			alreadyUsingThisOutfitForSpecial = true;
		end
		
		-- Clear other special outfits of this type
		for i, outfitI in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
			if (outfitI.Special == specialType) then
				outfitI.Special = nil;
			end
		end
		
		if (not alreadyUsingThisOutfitForSpecial) then
			outfit.Special = specialType;
			UIErrorsFrame:AddMessage(outfit.OutfitName.." "..WARDROBE_TXT_WORNWHEN[specialType](), 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
		end

		Wardrobe.PopulateMainMenu(true);
	end	
end

function Wardrobe.MountButtonClick()
	Wardrobe.SpecialButtonClick("mounted");
end

function Wardrobe.PlaguelandsButtonClick()
	Wardrobe.SpecialButtonClick("plague");
end

function Wardrobe.ChowingButtonClick()
	Wardrobe.SpecialButtonClick("chowing");
end


---------------------------------------------------------------------------------
-- When clicking the move up or move down buttons
---------------------------------------------------------------------------------
function Wardrobe.MoveOutfit_OnClick(direction)
	local outfitNum = Wardrobe.FindSelectedOutfit();
	
	if (outfitNum) then
		local swapNum = Wardrobe.OrderOutfit(outfitNum, direction);
		Wardrobe.SortOutfits();
		Wardrobe.PopulateMainMenu(true);
	end
end


---------------------------------------------------------------------------------
-- When clicking the delete outfit button
---------------------------------------------------------------------------------
function Wardrobe.DeleteOutfit_OnClick()
	selectedOutfit = nil;
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
		if (outfit.Selected) then
			selectedOutfit = i;
			break;
		end
	end
	
	if (selectedOutfit) then
		Wardrobe.PopupFunction = "DeleteFromSort";
		Wardrobe.NamePopupEditBox:SetText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName);
		Wardrobe.PopupConfirm:Show();
		Wardrobe.ToggleMainMenuFrameVisibility(false);
		Wardrobe.PopupConfirmText:SetText(TEXT("TXT_REALLYDELETEOUTFIT").."\n\n"..Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName);
	else
		UIErrorsFrame:AddMessage(TEXT("TXT_PLEASESELECTDELETE"), 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	end
end


--===============================================================================
--
-- Color picker
--
--===============================================================================

---------------------------------------------------------------------------------
-- when clicking on a color in the color picker
---------------------------------------------------------------------------------
function Wardrobe.ColorPickFrameColor_OnClick()
	local selectedOutfit = Wardrobe.FindSelectedOutfit();
	local buttonName = this:GetName();
	local x, y = string.find(buttonName, "%d+");
	Wardrobe.ColorPickFrame.buttonNum = tonumber(string.sub(buttonName, x, y));
	Wardrobe.ColorPickFrameExampleText:SetTextColor(WARDROBE_TEXTCOLORS[Wardrobe.ColorPickFrame.buttonNum][1], 
												   WARDROBE_TEXTCOLORS[Wardrobe.ColorPickFrame.buttonNum][2], 
												   WARDROBE_TEXTCOLORS[Wardrobe.ColorPickFrame.buttonNum][3]);	

	if (Wardrobe.EnteredColorPickerFromPaperdollFrame) then
		Wardrobe.CurrentOutfitButtonColor = Wardrobe.ColorPickFrame.buttonNum;
	end	
end


---------------------------------------------------------------------------------
-- Show the color selection menu
---------------------------------------------------------------------------------
function Wardrobe.ShowColorPickFrame()

	-- figure out where we were called from
	if (Wardrobe.MainMenuFrame:IsVisible()) then
		Wardrobe.EnteredColorPickerFromPaperdollFrame = false;
	else
		Wardrobe.EnteredColorPickerFromPaperdollFrame = true;
	end
	
	local selectedOutfit = Wardrobe.FindSelectedOutfit();

	if (selectedOutfit or Wardrobe.EnteredColorPickerFromPaperdollFrame) then

		Wardrobe.ColorPickFrame:SetAlpha(1.0);
		Wardrobe.ColorPickFrame:Show();
		Wardrobe.ColorPickFrameGrid:SetFrameLevel(Wardrobe.ColorPickFrameGrid:GetFrameLevel() + 1);
		for i = 1, 24 do
			Wardrobe["ColorPickFrameBox"..tostring(i).."Texture"]:SetVertexColor(WARDROBE_TEXTCOLORS[i][1],WARDROBE_TEXTCOLORS[i][2],WARDROBE_TEXTCOLORS[i][3],1.0);
			Wardrobe["ColorPickFrameBox"..tostring(i)]:SetFrameLevel(Wardrobe.ColorPickFrameGrid:GetFrameLevel() - 1);
		end

		if (Wardrobe.EnteredColorPickerFromPaperdollFrame) then
			Wardrobe.ColorPickFrameExampleText:SetText(Wardrobe.NewWardrobeName);
			Wardrobe.ColorPickFrameExampleText:SetTextColor(WARDROBE_TEXTCOLORS[Wardrobe.CurrentOutfitButtonColor][1], WARDROBE_TEXTCOLORS[Wardrobe.CurrentOutfitButtonColor][2], WARDROBE_TEXTCOLORS[Wardrobe.CurrentOutfitButtonColor][3]);	
		else
			Wardrobe.ColorPickFrameExampleText:SetText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName);
			local colorNum = Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].ButtonColor;
			Wardrobe.ColorPickFrameExampleText:SetTextColor(WARDROBE_TEXTCOLORS[colorNum][1], WARDROBE_TEXTCOLORS[colorNum][2], WARDROBE_TEXTCOLORS[colorNum][3]);	
		end
		
		if (not Wardrobe.EnteredColorPickerFromPaperdollFrame) then Wardrobe.ToggleMainMenuFrameVisibility(false); end

	end	
end


---------------------------------------------------------------------------------
-- Accept the color selection menu
---------------------------------------------------------------------------------
function Wardrobe.AcceptColorPickFrame()
	if (Wardrobe.EnteredColorPickerFromPaperdollFrame) then
		Wardrobe.RefreshCharacterPanel();
	end
	if (Wardrobe.ColorPickFrame.buttonNum) then
		Wardrobe.SetSelectedOutfitColor(Wardrobe.ColorPickFrame.buttonNum); 
		Wardrobe.PopulateMainMenu();		
	end
	Wardrobe.HideColorPickFrame();
end


---------------------------------------------------------------------------------
-- set the color of the selected outfit based on which button was clicked in the color selector
---------------------------------------------------------------------------------
function Wardrobe.SetSelectedOutfitColor(num)
	local selectedOutfit = Wardrobe.FindSelectedOutfit();

	if (selectedOutfit) then
		Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].ButtonColor = num;		
		Wardrobe.PopulateMainMenu();
	end
end

---------------------------------------------------------------------------------
-- Hide the color selection menu
---------------------------------------------------------------------------------
function Wardrobe.HideColorPickFrame()
	if (not Wardrobe.EnteredColorPickerFromPaperdollFrame) then
		Wardrobe.ToggleMainMenuFrameVisibility(true);
	end
	Wardrobe.ColorPickFrame.buttonNum = nil;
	Wardrobe.ColorPickFrame:Hide();
end


---------------------------------------------------------------------------------
-- Show the tooltip text
---------------------------------------------------------------------------------
function Wardrobe.ShowButtonTooltip(theText1, theText2, theText3, theText4, theText5)

	-- Set the anchor and text for the tooltip.
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(theText1, 0.39, 0.77, 0.16);
		
	-- add description lines to the tooltip
	if (theText2) then
		GameTooltip:AddLine(theText2, 0.82, 0.24, 0.79);
	end
	if (theText3) then
		GameTooltip:AddLine(theText3, 0.82, 0.24, 0.79);
	end
	if (theText4) then
		GameTooltip:AddLine(theText4, 0.82, 0.24, 0.79);
	end
	if (theText5) then
		GameTooltip:AddLine(theText5, 0.82, 0.24, 0.79);
	end
	
	-- Adjust width and height to account for new lines and show the tooltip
	-- (the Show() command automatically adjusts the width/height)
	GameTooltip:Show();
end

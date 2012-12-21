function DAB_PickupAction(action)
	DAB_Old_PickupAction(action);
	DAB_Update_ActionList();
end

function DAB_PlaceAction(action)
	DAB_Old_PlaceAction(action);
	DAB_Update_ActionList();
end

function DAB_ReputationWatchBar_Update(newLevel)
	DAB_Old_ReputationWatchBar_Update(newLevel);
	if (DAB_Settings[DAB_INDEX].MainMenuBar.showXP) then
		if ( not newLevel ) then
			newLevel = UnitLevel("player");
		end
		ReputationWatchBar:ClearAllPoints();
		if ( newLevel < MAX_PLAYER_LEVEL ) then
			ReputationWatchBar:SetPoint("TOP", MainMenuExpBar, "BOTTOM", 0, 0);
		else
			ReputationWatchBar:SetPoint("TOP", DAB_XPBar, "TOP", 0, 0);
		end
	end
end

function DAB_Initialize()
	if (DAB_INITIALIZED) then return; end

	if (DAB_DL_VERSION > DL_VERSION) then
		DL_Error("** You need to install the latest version of the Discord Library, v"..DAB_DL_VERSION..", for Discord Action Bars to work right.  It should be included in the same .zip file from which you extracted this mod. **");
		return;
	end

	DAB_Old_SaveBindings = SaveBindings;
	SaveBindings = DAB_SaveBindings;
	for i=1,12 do
		setglobal("BINDING_NAME_ACTIONBUTTON"..i, DAB_TEXT.KBWarning);
		setglobal("BINDING_NAME_SELFACTIONBUTTON"..i, DAB_TEXT.KBWarning);
	end
	UpdateTalentButton = function () end;
	TalentMicroButton:UnregisterEvent("UNIT_LEVEL");
	TalentMicroButton:UnregisterEvent("PLAYER_ENTERING_WORLD");
	ActionBarUpButton:SetScript("OnClick", function() DAB_Bar_PageUp(1); PlaySound("UChatScrollButton"); end);
	ActionBarDownButton:SetScript("OnClick", function() DAB_Bar_PageDown(1); PlaySound("UChatScrollButton"); end);

	DAB_Old_PickupAction = PickupAction;
	PickupAction = DAB_PickupAction;
	DAB_Old_PlaceAction = PlaceAction;
	PlaceAction = DAB_PlaceAction;

	DAB_Old_ReputationWatchBar_Update = ReputationWatchBar_Update;
	ReputationWatchBar_Update = DAB_ReputationWatchBar_Update;

	if (not DAB_Settings) then
		DAB_Settings = {};
	elseif (not DAB_Settings["INITIALIZED3.0"]) then
		DAB_Settings = {};
	end
	DAB_Settings["INITIALIZED3.0"] = 1;

	DAB_PROFILE_INDEX = UnitName("player").." :: "..GetCVar("realmName");
	if (DAB_Settings[DAB_PROFILE_INDEX]) then
		DAB_INDEX = DAB_Settings[DAB_PROFILE_INDEX];
	else
		DAB_INDEX = DAB_TEXT.Default;
		DAB_Settings[DAB_PROFILE_INDEX] = DAB_TEXT.Default;
	end

	if (not DAB_Settings[DAB_INDEX]) then
		local err = DAB_Load_DefaultSettings();
		if (err) then
			DL_Error("** Default settings not found for Discord Action Bars.  Unable to initialize. **");
			return;
		end
	end

	if (DAB_CUSTOM_SETTINGS) then
		DAB_Settings.Custom = {};
		DL_Copy_Table(DAB_CUSTOM_SETTINGS, DAB_Settings.Custom);
		DAB_CUSTOM_SETTINGS = nil;
	end

	ActionButtonDown = function() DL_Error("You are trying to use the default UI's action button keybindings.  They will not work with Discord Action Bars."); end

	if (CT_ActionButton1) then
		DL_Error("You are running CT_BarMod along with Discord Action Bars.  Discord Action Bars will not run until you disable CT_BarMod.");
		return;
	end

	if (CT_BottomBarFrame) then
		DL_Error("You are running CT_BottomBar along with Discord Action Bars.  Discord Action Bars will not run until you disable CT_BottomBar.");
		return;
	end

	DAB_INITIALIZED = true;
	DAB_Conditions();
	DAB_Initialize_Everything();
end

function DAB_Get_NumButtonsAndBars()
	local count = 1;
	while (getglobal("DAB_ActionButton_"..count)) do
		DAB_NUM_BUTTONS = count;
		count = count + 1;
	end
	count = 1;
	while (getglobal("DAB_ActionBar_"..count)) do
		DAB_NUM_BARS = count;
		count = count + 1;
	end
end

function DAB_Initialize_Everything()
	if (not DAB_INITIALIZED) then return; end
	DAB_Get_NumButtonsAndBars();
	DAB_Initialize_NewSettings();
	DAB_UPDATE_SPEED = 1 / DAB_Settings[DAB_INDEX].UpdateSpeed;
	for i=1,DAB_NUM_BARS do
		DAB_Bar_Location(i);
		DAB_Bar_Initialize(i);
		DAB_Bar_Label(i);
		DAB_Bar_Backdrop(i);
		DAB_Bar_ButtonTextures(i);
		DAB_Bar_ButtonText(i);
		DAB_Bar_ButtonSize(i);
		DAB_Bar_ButtonAlpha(i);
		DAB_Bar_Update(i);
		DAB_ControlBox_Initialize(i);
		DAB_Compile_Scripts("Bar", i);
		DAB_Compile_Scripts("ControlBox", i);
	end
	for i=11,14 do
		DAB_OtherBar_Initialize(i);
	end
	for i in DAB_Settings[DAB_INDEX].Floaters do
		DAB_Floater_Initialize(i);
		DAB_Compile_Scripts("Floaters", i);
	end
	DAB_VL_CHANGED = 1;
	DAB_EventMacro_Compile();
	DAB_Update_MainMenuBar();
	DAB_Set_Keybindings();
	DAB_Update_Keybindings();
	if (DAB_Options) then
		DAB_Init_MainMenuOptions();
		DAB_Init_MiscOptions();
		DAB_Set_OptionsScale(DAB_Settings[DAB_INDEX].optionsScale);
		DAB_Init_ButtonLayout();
	end
	DAB_Update_Locations();
	DAB_Update_ObjectList();
	DAB_Update_ActionList();
	DAB_Update_AnchorsList();
	DAB_Update_TextureList();
	DAB_Update_GroupList();
	DAB_Update_UnitList();
	DAB_Update_FontList();
	DAB_Update_FloaterList();
	DAB_Update_EventList();
	DAB_Update_ProfileList();
	DL_Update_Forms();
	for _,button in DAB_Settings[DAB_INDEX].FreeButtons do
		DAB_Settings[DAB_INDEX].Buttons[button] = {Conditions={}, Scripts={}, action=button};
		getglobal("DAB_ActionButton_"..button):Hide();
	end
end

function DAB_Initialize_NewSettings()
	if (not DAB_INITIALIZED) then return; end
	if (not DAB_Settings[DAB_INDEX]["INITIALIZED3.0H"]) then
		for i=1,DAB_NUM_BARS do
			DAB_Settings[DAB_INDEX].ControlBox[i].changePageBar = 1;
			DAB_Settings[DAB_INDEX].ControlBox[i].changePageType = 1;
			DAB_Settings[DAB_INDEX].ControlBox[i].changePagePage = 1;
		end
	end
	if (not DAB_Settings[DAB_INDEX]["INITIALIZED3.1"]) then
		for bar=1, DAB_NUM_BARS do
			DAB_Settings[DAB_INDEX].Bar[bar].pages = {};
			DAB_Settings[DAB_INDEX].Bar[bar].pageconditions = {};
			for page=1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
				DAB_Settings[DAB_INDEX].Bar[bar].pages[page] = {};
				DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page] = {};
				local count = 0;
				for b=1,DAB_NUM_BUTTONS do
					if (DAB_Settings[DAB_INDEX].Buttons[b].Bar == bar and DAB_Settings[DAB_INDEX].Buttons[b].Bar2 == page) then
						count = count + 1;
						DAB_Settings[DAB_INDEX].Bar[bar].pages[page][count] = b;
						DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][count] = {};
						DL_Copy_Table(DAB_Settings[DAB_INDEX].Buttons[b].Conditions, DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][count]);
					end
				end
			end
		end
		local count = {};
		for i=1,DAB_NUM_BUTTONS do
			DAB_Settings[DAB_INDEX].Buttons[i].action = i;
			local bar = DAB_Settings[DAB_INDEX].Buttons[i].Bar;
			local page = DAB_Settings[DAB_INDEX].Buttons[i].Bar2;
			DAB_Settings[DAB_INDEX].Buttons[i].Bar2 = nil;
			if (bar and bar ~= "F" and page > 1) then
				tinsert(DAB_Settings[DAB_INDEX].FreeButtons, i);
				DAB_Settings[DAB_INDEX].Buttons[i].Bar = nil;
				DAB_Settings[DAB_INDEX].Buttons[i].Conditions={};
				DAB_Settings[DAB_INDEX].Buttons[i].Scripts={};
			end
		end
	end
	-- Fixing some corrupted settings from the first 3.1 beta
	for bar = 1,10 do
		for page=1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
			if (not DAB_Settings[DAB_INDEX].Bar[bar].pages) then
				DAB_Settings[DAB_INDEX].Bar[bar].pages = {};
			end
			if (not DAB_Settings[DAB_INDEX].Bar[bar].pageconditions) then
				DAB_Settings[DAB_INDEX].Bar[bar].pageconditions = {};
			end
			if (not DAB_Settings[DAB_INDEX].Bar[bar].pages[page]) then
				DAB_Settings[DAB_INDEX].Bar[bar].pages[page] = {};
				for button = 1, DAB_Settings[DAB_INDEX].Bar[bar].numButtons do
					DAB_Settings[DAB_INDEX].Bar[bar].pages[page][button] = 1;
				end
			end
			if (not DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page]) then
				DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page] = {};
				for button = 1, DAB_Settings[DAB_INDEX].Bar[bar].numButtons do
					DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button] = {};
				end
			end
			for button = 1, DAB_Settings[DAB_INDEX].Bar[bar].numButtons do
				if (not DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button]) then
					DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button] = {};
				end
				if (not DAB_Settings[DAB_INDEX].Bar[bar].pages[page][button]) then
					DAB_Settings[DAB_INDEX].Bar[bar].pages[page][button] = 1;
				end
			end
		end
	end
	if (not DAB_Settings[DAB_INDEX]["INITIALIZED3.1g"]) then
		DAB_Settings[DAB_INDEX].SelfCast = 1;
		DAB_Settings[DAB_INDEX].DragLockOverride = 2;
		DAB_Settings[DAB_INDEX].ButtonLockOverride = 3;
		DAB_Settings[DAB_INDEX].CDFormat = 1;
	end
	if (not DAB_Settings[DAB_INDEX]["INITIALIZED3.1i"]) then
		DAB_Settings[DAB_INDEX].OtherBar[11].Cooldown = {color={r=1, g=1, b=0}, size=16, font="Fonts\\FRIZQT__.TTF"};
		DAB_Settings[DAB_INDEX].OtherBar[12].Cooldown = {color={r=1, g=1, b=0}, size=16, font="Fonts\\FRIZQT__.TTF"};
	end
	if (not DAB_Settings[DAB_INDEX]["INITIALIZED3.16"]) then
		DAB_Settings[DAB_INDEX].MainMenuBar.keyringscale = 1
	end
	DAB_Settings[DAB_INDEX]["INITIALIZED3.0H"] = 1;
	DAB_Settings[DAB_INDEX]["INITIALIZED3.1"] = 1;
	DAB_Settings[DAB_INDEX]["INITIALIZED3.1g"] = 1;
	DAB_Settings[DAB_INDEX]["INITIALIZED3.1i"] = 1;
	DAB_Settings[DAB_INDEX]["INITIALIZED3.16"] = 1;
end

function DAB_Compile_Scripts(object, index)
	for i = 1, 14 do
		local script = DAB_Settings[DAB_INDEX][object][index].Scripts[i];
		local name = DL_Get_MenuText(DAB_SCRIPTS, i);
		if (string.sub(name, -2) == " *") then
			name = string.sub(name, 1, -2);
		end
		if (i == 2) then
			name = "OnClickAfter"
		elseif (i == 12) then
			name = "OnClickBefore"
		elseif (i == 10) then
			name = "OnKeybindingDownAfter"
		elseif (i == 13) then
			name = "OnKeybindingDownBefore"
		elseif (i == 11) then
			name = "OnKeybindingUpAfter"
		elseif (i == 14) then
			name = "OnKeybindingUpBefore"
		end
		if (script and script ~= "") then
			RunScript("function DAB_"..object.."_"..index.."_"..name.."(param)\n"..script.."\nend");
		else
			RunScript("DAB_"..object.."_"..index.."_"..name.." = nil");
		end
	end
	if (getglobal("DAB_"..object.."_"..index.."_OnLoad")) then
		if (object == "Bar") then
			this = getglobal("DAB_ActionBar_"..index);
		else
			this = getglobal("DAB_ActionButton_"..index);
		end
		getglobal("DAB_"..object.."_"..index.."_OnLoad")();
	end
end

function DAB_Conditions()
	DL_Alphabetic_Insert(DL_CONDITIONS_MENU, { text="Bar's Current Page", value=200, params=200, desc="Detects what page the specified bar is currently on." }, "text", 2);
	DL_CheckCondition[200] = function(conditions)
		if (DL_Compare(DAB_Bar_GetRealPage(conditions.bar), conditions.number, conditions.compare)) then
			return true;
		end
	end
end

function DAB_Load_Options()
	if (DAB_Options) then return; end
	UIParentLoadAddOn("DiscordActionBarsOptions");
	DL_Set_OptionsTitle("DAB_Options", "DiscordActionBarsOptions\\title", DAB_VERSION);
	DL_Layout_Menu("DAB_DropMenu", DAB_DropMenu_OnClick);
	DL_Layout_ScrollButtons("DAB_Options_BarBrowser_Button", 15, DAB_BarBrowser_OnClick);
	DL_Layout_ScrollButtons("DAB_KeybindingOptions_KeybindingBrowser_Button", 10);
	DAB_Options_BarBrowser_Button2:SetChecked(1);
	DAB_Options_BarBrowser_Button2Text:SetTextColor(1, 0, 0);
	DL_Layout_ScrollButtons("DAB_ScrollMenu_Button", 10, DAB_ScrollMenu_OnClick);
	DL_Layout_ScrollButtons("DAB_BarOptions_BarControl_ConditionMenu_Button", 5);
	DL_Layout_ScrollButtons("DAB_FloaterOptions_Control_ConditionMenu_Button", 5);
	DL_Layout_ScrollButtons("DAB_SetActionIDs_ScrollMenu_Button", 19);
	DL_Layout_ScrollButtons("DAB_ChangeActions_ScrollMenu_Button", 13);
	DL_Layout_ScrollButtons("DAB_BarOptions_ButtonControl_ButtonsMenu_Button", 4, DAB_Select_BarButton);
	DAB_BarOptions_BarAppearance_PaddingLabel:SetText(DAB_TEXT.Padding);
	DAB_BarOptions_BarAppearance_InsetsLabel:SetText(DAB_TEXT.Insets);
	DAB_OtherBarOptions_PaddingLabel:SetText(DAB_TEXT.Padding);
	DAB_OtherBarOptions_InsetsLabel:SetText(DAB_TEXT.Insets);
	DAB_BarOptions_Label_InsetsLabel:SetText(DAB_TEXT.Insets);
	DAB_BarOptions_ButtonAppearance_PaddingLabel:SetText(DAB_TEXT.ButtonBorderPadding);
	DAB_BarOptions_ButtonAppearance_TextLabel:SetText(DAB_TEXT.ButtonText);
	DAB_BarOptions_ButtonAppearance_TextureLabel:SetText(DAB_TEXT.ButtonTextures);
	DAB_BarOptions_ButtonAppearance_ColorLabel:SetText(DAB_TEXT.ButtonConditionalColor);
	DAB_BarOptions_BarControl_ParamLabel:SetText(DAB_TEXT.Parameters);
	DAB_BarOptions_BarControl_ResponseLabel:SetText(DAB_TEXT.Parameters);
	DAB_NumButtons_ButtonLabel:SetText(DAB_TEXT.Buttons);
	DAB_NumButtons_PagesLabel:SetText(DAB_TEXT.Pages);
	DAB_NumButtons_Floaters_Label:SetText(DAB_TEXT.Floaters);
	DAB_NumButtons_Floaters_Label:SetTextColor(1, 1, 0);
	DAB_CBoxOptions_Config_AnchorLabel:SetText(DAB_TEXT.AnchorFrame);
	DAB_CBoxOptions_Config_AnchorPointLabel:SetText(DAB_TEXT.AnchorPoint);
	DAB_CBoxOptions_Config_AnchorToLabel:SetText(DAB_TEXT.AnchorTo);
	DAB_CBoxOptions_Config_HideLabel:SetText(DAB_TEXT.Hide);
	DAB_CBoxOptions_Config_BorderLabel:SetText(DAB_TEXT.Border);
	DAB_CBoxOptions_Config_WidthLabel:SetText(DAB_TEXT.Width);
	DAB_CBoxOptions_Config_TextureLabel:SetText(DAB_TEXT.Texture);
	DAB_FloaterOptions_AdvConfig_PaddingLabel:SetText(DAB_TEXT.ButtonBorderPadding);
	DAB_FloaterOptions_AdvConfig_TextLabel:SetText(DAB_TEXT.ButtonText);
	DAB_KeybindingOptions_KeybindingBrowser_OptionsLabel:SetText(DAB_TEXT.Options);
	DAB_KeybindingOptions_KeybindingBrowser_Key1Label:SetText(DAB_TEXT.Key1);
	DAB_KeybindingOptions_KeybindingBrowser_Key2Label:SetText(DAB_TEXT.Key2);
	DL_Init_MenuControl(DAB_SetActionIDs_FilterMenu1, 1);
	DAB_Init_BarOptions();
	DAB_Init_MainMenuOptions();
	DAB_Init_MiscOptions();
	DAB_Set_OptionsScale(DAB_Settings[DAB_INDEX].optionsScale);
	DAB_Init_ButtonLayout();
	DL_Update_Forms();
	DAB_Update_ScriptsList();
	DAB_BarBrowser_Update();
	DAB_Update_ActionIDsList();
end

function DAB_Load_DefaultSettings()
	DAB_Settings[DAB_INDEX] = {};
	if (DAB_DEFAULT_SETTINGS) then
		DL_Copy_Table(DAB_DEFAULT_SETTINGS, DAB_Settings[DAB_INDEX]);
	else
		return true;
	end
end

function DAB_Delete_Profile(index)
	if ((not index) or index == "") then
		if (DAB_Options) then
			index = DAB_MiscOptions_LoadProfile_Setting:GetText();
		end
		if ((not index) or index == "") then return; end
	end
	if (DAB_Options) then
		DAB_MiscOptions_LoadProfile_Setting:SetText("");
	end
	if (index == DAB_INDEX) then
		DL_Error("You cannot delete the profile you current have loaded.");
		return;
	end
	DAB_Settings[index] = nil;
	DAB_Update_ProfileList();
	DL_Feedback("Profile name "..index.." deleted.");
end

function DAB_Load_Profile(index)
	if (not DAB_INITIALIZED) then return; end
	if ((not index) or index == "") then
		if (DAB_Options) then
			index = DAB_MiscOptions_LoadProfile_Setting:GetText();
		end
		if ((not index) or index == "") then return; end
	end
	if (index == DAB_INDEX) then return; end
	if (DAB_Options) then
		DAB_MiscOptions_LoadProfile_Setting:SetText("");
	end
	DAB_INDEX = index;
	DAB_Settings[DAB_PROFILE_INDEX] = index;
	DAB_Initialize_Everything();
	DL_Feedback("Profile named "..index.." loaded.");
end

function DAB_SafeLoad_Profile(index)
	if (not DAB_INITIALIZED) then return; end
	if ((not index) or index == "") then
		if (DAB_Options) then
			index = DAB_MiscOptions_LoadProfile_Setting:GetText();
		end
		if ((not index) or index == "") then return; end
	end
	if (index == DAB_INDEX) then return; end
	DAB_Settings[DAB_PROFILE_INDEX] = index;
	ReloadUI();
end

function DAB_New_Profile(index)
	if ((not index) or index == "") then
		if (DAB_Options) then
			index = DAB_MiscOptions_NewProfile:GetText();
		end
		if ((not index) or index == "") then return; end
	end
	if (DAB_Options) then
		DAB_MiscOptions_NewProfile:SetText("");
		DAB_MiscOptions_NewProfile:ClearFocus();
	end
	if (DAB_Settings[index]) then
		DL_Error("You are trying to create a new profile with the same name as another profile.  You must delete the other profile first.");
		return;
	elseif (string.find(index, " :: ")) then
		DL_Error("You tried to create a profile using the reserved characters ::.  Use a different name.");
		return;
	elseif (index == "Custom") then
		DL_Error("You tried to create a profile using the reserved word Custom.  Use a different name.");
		return;
	end
	DAB_Settings[index] = {};
	DL_Copy_Table(DAB_Settings[DAB_INDEX], DAB_Settings[index]);
	DAB_INDEX = index;
	DAB_Settings[DAB_PROFILE_INDEX] = index;
	DL_Feedback("New profile, "..index..", created.");
	DAB_Update_ProfileList();
	if (DAB_Options) then
		DAB_MiscOptions_CurrentProfile:SetText(DAB_TEXT.CurrentProfile.." |cFFFFFFFF"..index);
	end
end

function DAB_Set_Keybindings()
	local binding, key1, key2;
	for i=1,120 do
		binding = "DAB_"..i;
		key1, key2 = GetBindingKey(binding);
		if (key1) then SetBinding(key1, ""); end
		if (key2) then SetBinding(key2, ""); end
		if (DAB_Settings[DAB_INDEX].Keybindings[i].key1) then
			SetBinding(DAB_Settings[DAB_INDEX].Keybindings[i].key1, "");
			SetBinding(DAB_Settings[DAB_INDEX].Keybindings[i].key1, binding);
		end
		if (DAB_Settings[DAB_INDEX].Keybindings[i].key2) then
			SetBinding(DAB_Settings[DAB_INDEX].Keybindings[i].key2, "");
			SetBinding(DAB_Settings[DAB_INDEX].Keybindings[i].key2, binding);
		end
	end
	SaveBindings(GetCurrentBindingSet());
end

function DAB_Toggle_State(setting, frame)
	if (setting) then
		if (not frame.oldShow) then
			frame.oldShow = frame.Show;
			frame.Show = function() end;
		end
		frame:Hide();
	else
		if (frame.oldShow) then
			frame.Show = frame.oldShow;
			frame.oldShow = nil;
		end
		frame:Show();
	end
end

function DAB_Update_ActionList()
	DAB_ACTIONS = {};
	for i=1, 120 do
		DAB_ACTIONS[i] = { text="["..i.."] "..DAB_Get_ActionName(i), value=i };
	end
end

function DAB_Update_AnchorsList()
	for i=1,10 do
		DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_TEXT.Bar.." "..i, "DAB_ActionBar_"..i);
	end
	DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_TEXT.PetBar, "DAB_OtherBar_Pet");
	DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_TEXT.ShapeshiftBar, "DAB_OtherBar_Form");
	DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_TEXT.BagBar, "DAB_OtherBar_Bag");
	DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_TEXT.MenuBar, "DAB_OtherBar_Menu");
	for i=1,10 do
		DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_TEXT.ControlBox.." "..i, "DAB_ControlBox_"..i);
	end
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Floaters[i]) then
			DL_AddToMenu(DL_ANCHOR_FRAMES, "[F "..i.."] "..DAB_Get_ActionName(DAB_Settings[DAB_INDEX].Buttons[i].action), "DAB_ActionButton_"..i);
		end
	end
	for i=1,10 do
		DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_Settings[DAB_INDEX].Bar[i].Anchor.frame);
		DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_Settings[DAB_INDEX].ControlBox[i].Anchor.frame);
	end
	for i=11,14 do
		DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_Settings[DAB_INDEX].OtherBar[i].Anchor.frame);
	end
	for i in DAB_Settings[DAB_INDEX].Floaters do
		DL_AddToMenu(DL_ANCHOR_FRAMES, DAB_Settings[DAB_INDEX].Floaters[i].Anchor.frame);
	end
end

function DAB_Update_EventList()
	for event, val in DAB_Settings[DAB_INDEX].CustomEvents do
		DL_AddToMenu(DAB_EVENTS, val.text, event, val.desc);
	end
	for index,val in DAB_EVENTS do
		if (DAB_Settings[DAB_INDEX].EventMacros[val.value] and DAB_Settings[DAB_INDEX].EventMacros[val.value] ~= "") then
			if (string.sub(DAB_EVENTS[index].text, -2) ~= " *") then
				DAB_EVENTS[index].text = DAB_EVENTS[index].text.." *";
			end
		elseif (string.sub(DAB_EVENTS[index].text, -2) == " *") then
			DAB_EVENTS[index].text = string.sub(DAB_EVENTS[index].text, 1, -2);
		end
	end
end

function DAB_Update_FloaterList()
	DAB_FLOATERS = {};
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Floaters[i]) then
			DL_AddToMenu(DAB_FLOATERS, "[F "..i.."] "..DAB_Get_ActionName(DAB_Settings[DAB_INDEX].Buttons[i].action), i);
		end
	end
end

function DAB_Update_FontList()
	for i=1,10 do
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Bar[i].Keybinding.font, nil, 1);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Bar[i].Cooldown.font, nil, 1);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Bar[i].Macro.font, nil, 1);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Bar[i].Count.font, nil, 1);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Bar[i].Label.font, nil, 1);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].ControlBox[i].font, nil, 1);
	end
	for i in DAB_Settings[DAB_INDEX].Floaters do
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Floaters[i].Keybinding.font);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Floaters[i].Cooldown.font);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Floaters[i].Macro.font);
		DL_AddToMenu(DL_FONTS_LIST, DAB_Settings[DAB_INDEX].Floaters[i].Count.font);
	end
end

function DAB_Update_GroupList()
	DAB_GROUPS = {};
	DAB_GROUPS[1] = {text=""};
	for i=1,10 do
		DAB_GROUPS[i + 1] = {text=i, value=i};
	end
	for i=1,10 do
		DL_AddToMenu(DAB_GROUPS, DAB_Settings[DAB_INDEX].Bar[i].cbgroup);
	end
	for i=11,14 do
		DL_AddToMenu(DAB_GROUPS, DAB_Settings[DAB_INDEX].OtherBar[i].cbgroup);
	end
	for i in DAB_Settings[DAB_INDEX].Floaters do
		DL_AddToMenu(DAB_GROUPS, DAB_Settings[DAB_INDEX].Floaters[i].cbgroup);
	end
end

function DAB_Update_Keybindings()
	if (not DAB_INITIALIZED) then return; end
	local kb, name, kbtext, button;
	for i=1,120 do
		getglobal("DAB_ActionButton_"..i.."_HotKey"):SetText("");
		getglobal("DAB_ActionButton_"..i).basekb = "";
	end
	for i=1,120 do
		kb = DAB_Settings[DAB_INDEX].Keybindings[i];
		kbtext = DL_Get_KeybindingText("DAB_"..i, nil, 1);
		if (kb.option == 1 or kb.option == 10) then
			name = "|cFF"..DAB_KB_COLOR[kb.option][kb.suboption].."   ";
		elseif (kb.option == 12) then
			local _, _, bar, page = string.find(kb.suboption, "(%d*)_(%d*)");
			bar = tonumber(bar);
			page = tonumber(page);
			name = "|cFF"..DAB_KB_COLOR[kb.option][bar].."   ";
		else
			name = "|cFF"..DAB_KB_COLOR[kb.option].."   ";
		end
		if (kb.option == 1) then
			name = name.."["..DAB_TEXT.Bar.." "..kb.suboption.."] "..DAB_Settings[DAB_INDEX].Bar[kb.suboption].Label.text.." :: "..DAB_TEXT.Button.." "..kb.suboption2;
			for page = 1, DAB_Settings[DAB_INDEX].Bar[kb.suboption].numBars do
				local button = DAB_Get_BarButtonID(kb.suboption, page, kb.suboption2);
				if (button and kbtext ~= "") then
					getglobal("DAB_ActionButton_"..button.."_HotKey"):SetText(kbtext);
					getglobal("DAB_ActionButton_"..button).basekb = kbtext;
				end
			end
		elseif (kb.option == 2) then
			name = name..DAB_TEXT.Group.." "..kb.suboption.." :: "..DAB_TEXT.Button.." "..kb.suboption2;
		elseif (kb.option == 3) then
			name = name.."[F "..kb.suboption.."] "..DAB_Get_ActionName(DAB_Settings[DAB_INDEX].Buttons[kb.suboption].action);
			if (kbtext ~= "") then
				getglobal("DAB_ActionButton_"..kb.suboption.."_HotKey"):SetText(kbtext);
			end
		elseif (kb.option == 4) then
			name = name..DAB_TEXT.ControlBox.." "..kb.suboption;
		elseif (kb.option == 5) then
			name = name..DAB_TEXT.SetKBGroup;
			name = string.gsub(name, "$g", kb.suboption);
			name = string.gsub(name, "$b", kb.suboption2);
		elseif (kb.option == 6) then
			name = name..DAB_TEXT.SetBarPage;
			name = string.gsub(name, "$b", kb.suboption);
			name = string.gsub(name, "$p", kb.suboption2);
		elseif (kb.option == 7) then
			name = name..DAB_TEXT.BarPageUp;
			name = string.gsub(name, "$b", kb.suboption);
		elseif (kb.option == 8) then
			name = name..DAB_TEXT.BarPageDown;
			name = string.gsub(name, "$b", kb.suboption);
		elseif (kb.option == 9) then
			if (DAB_VARIABLE_KEYBINDINGS[kb.suboption] ~= 1) then
				DAB_VARIABLE_KEYBINDINGS[kb.suboption] = 2;
			end
			name = name..DAB_TEXT.VariableKeybinding;
			name = string.gsub(name, "$n", kb.suboption);
		elseif (kb.option == 10) then
			name = name.."Self-cast ["..DAB_TEXT.Bar.." "..kb.suboption.."] "..DAB_Settings[DAB_INDEX].Bar[kb.suboption].Label.text.." :: "..DAB_TEXT.Button.." "..kb.suboption2;
		elseif (kb.option == 11) then
			name = name.."Self-cast [F "..kb.suboption.."] "..DAB_Get_ActionName(DAB_Settings[DAB_INDEX].Buttons[kb.suboption].action);
		elseif (kb.option == 12) then
			local _, _, bar, page = string.find(kb.suboption, "(%d*)_(%d*)");
			bar = tonumber(bar);
			page = tonumber(page);
			name = name.."["..DAB_TEXT.Bar.." "..bar..", "..DAB_TEXT.Page.." "..page.."] "..DAB_Settings[DAB_INDEX].Bar[bar].Label.text.." :: "..DAB_TEXT.Button.." "..kb.suboption2;
			local button = DAB_Get_BarButtonID(bar, page, kb.suboption2);
			if (button and kbtext ~= "") then
				getglobal("DAB_ActionButton_"..button.."_HotKey"):SetText(kbtext);
				getglobal("DAB_ActionButton_"..button).basekb = kbtext;
			end
		elseif (kb.option == 13) then
			name = name.."Use Action: "..DAB_Get_ActionName(kb.suboption);
		elseif (kb.option == 14) then
			name = name.."Self-cast Action: "..DAB_Get_ActionName(kb.suboption);
		else
			name = name..DAB_TEXT.Undefined;
		end
		setglobal("BINDING_NAME_DAB_"..i, name);
	end

	for group, bar in DAB_Settings[DAB_INDEX].KBGroups do
		DAB_Set_KeybindingGroup(group, bar);
	end
end

function DAB_Update_Locations()
	for frameName, settings in DAB_Settings[DAB_INDEX].FrameLocs do
		frame = getglobal(frameName);
		frame:ClearAllPoints();
		frame:SetPoint(settings.point, settings.frame, settings.to, settings.x, settings.y);
	end
end

function DAB_Update_MainMenuBar()
	local settings = DAB_Settings[DAB_INDEX].MainMenuBar;
	BonusActionBarFrame.Show = function() end;
	BonusActionBarFrame:SetScript("OnEvent", function() end);
	BonusActionBarFrame:Hide();
	for i=1,12 do
		local button = getglobal("ActionButton"..i);
		button.Show = function() end;
		button:SetScript("OnEvent", function() end);
		button:SetParent(UIParent);
		button:Hide();
		button = getglobal("BonusActionButton"..i);
		button.Show = function() end;
		button:SetScript("OnEvent", function() end);
		button:SetParent(UIParent);
		button:Hide();
		if (i <= 10) then
			button = getglobal("ShapeshiftButton"..i.."NormalTexture");
			button.Show = function() end;
			button:SetAlpha(0);
			button:Hide();
		end
	end
	DAB_Toggle_State(settings.hideEverything, MainMenuBar);
	DAB_Toggle_State(settings.hideEverything, MainMenuBarArtFrame);
	if (settings.showXP) then
		MainMenuExpBar:SetParent(DAB_XPBar);
		MainMenuExpBar:SetFrameStrata("LOW");
		MainMenuExpBar:SetFrameLevel(DAB_XPBar:GetFrameLevel() - 1);
		MainMenuExpBar:Show();
		MainMenuExpBar:ClearAllPoints();
		MainMenuExpBar:SetPoint("TOP", DAB_XPBar, "TOP", 0, 0);
		ExhaustionTick:SetParent(MainMenuExpBar);
		DAB_XPBar:Show();
		MainMenuBarPerformanceBarFrame:Hide();
		MainMenuExpBar:SetStatusBarColor(settings.xpcolor.r, settings.xpcolor.g, settings.xpcolor.b);
		for i=1,4 do
			if (settings.hideXPborder) then
				getglobal("DAB_XPBar_"..i):Hide();
			else
				getglobal("DAB_XPBar_"..i):Show();
			end
		end
		DAB_XPBar:SetScale(settings.xpscale);
		DAB_XPBar:SetAlpha(settings.xpalpha);
		ReputationWatchBar:SetParent(DAB_XPBar);
		ReputationWatchBar:SetFrameStrata("LOW");
	else
		ReputationWatchBar:SetParent(MainMenuBar);
		MainMenuExpBar:SetParent(MainMenuBar);
		MainMenuExpBar:ClearAllPoints();
		MainMenuExpBar:SetPoint("TOP", MainMenuBar, "TOP", 0, 0);
		DAB_XPBar:Hide();
	end
	if (settings.showLatency) then
		DAB_LatencyBar:Show();
		MainMenuBarPerformanceBarFrame:SetParent(DAB_LatencyBar);
		MainMenuBarPerformanceBarFrame:SetFrameStrata("BACKGROUND");
		MainMenuBarPerformanceBarFrame:Show();
		if (not MainMenuBarPerformanceBarFrame.OLD_SetPoint) then
			MainMenuBarPerformanceBarFrame:ClearAllPoints();
			MainMenuBarPerformanceBarFrame:SetPoint("CENTER", DAB_LatencyBar, "CENTER", 4, 0);
			MainMenuBarPerformanceBarFrame.OLD_SetPoint = MainMenuBarPerformanceBarFrame.SetPoint
			MainMenuBarPerformanceBarFrame.SetPoint = function() MainMenuBarPerformanceBarFrame:OLD_SetPoint("CENTER", DAB_LatencyBar, "CENTER", 4, 0); end
		end
		DAB_LatencyBar:SetScale(settings.latencyscale);
	else
		DAB_LatencyBar:Hide();
		MainMenuBarPerformanceBarFrame:SetParent(MainMenuExpBar);
		MainMenuBarPerformanceBarFrame:SetFrameStrata("LOW");
		if (MainMenuBarPerformanceBarFrame.OLD_SetPoint) then
			MainMenuBarPerformanceBarFrame.SetPoint = MainMenuBarPerformanceBarFrame.OLD_SetPoint
			MainMenuBarPerformanceBarFrame.OLD_SetPoint = nil
		end
		MainMenuBarPerformanceBarFrame:ClearAllPoints();
		MainMenuBarPerformanceBarFrame:SetPoint("BOTTOMRIGHT", MainMenuExpBar, "BOTTOMRIGHT", -227, -50);
	end
	if (settings.showKeyring) then
		DAB_KeyringBox:Show()
		KeyRingButton:SetParent(DAB_KeyringBox)
		KeyRingButton:SetFrameStrata("LOW")
		KeyRingButton:Show()
		if (not KeyRingButton.OLD_SetPoint) then
			KeyRingButton:ClearAllPoints()
			KeyRingButton:SetPoint("CENTER", DAB_KeyringBox, "CENTER", 0, 0)
			KeyRingButton.OLD_SetPoint = KeyRingButton.SetPoint
			KeyRingButton.SetPoint = function() KeyRingButton:OLD_SetPoint("CENTER", DAB_KeyringBox, "CENTER", 0, 0) end
		end
		DAB_KeyringBox:SetScale(settings.keyringscale)
	else
		DAB_KeyringBox:Hide()
		KeyRingButton:SetParent(MainMenuBarArtFrame)
		if (KeyRingButton.OLD_SetPoint) then
			KeyRingButton.SetPoint = KeyRingButton.OLD_SetPoint
			KeyRingButton.OLD_SetPoint = nil
		end
		KeyRingButton:ClearAllPoints()
		KeyRingButton:SetPoint("RIGHT", CharacterBag3Slot, "LEFT", -5, 0)
	end
	ReputationWatchBar_Update();
end

function DAB_Update_ObjectList()
	DAB_BAR_LIST = {};
	DAB_BAR_LIST[1] = { text=DAB_TEXT.Bars, header=true };
	for i=1,10 do
		DAB_BAR_LIST[i + 1] = { text="[Bar "..i.."] "..DAB_Settings[DAB_INDEX].Bar[i].Label.text, value=i };
		DAB_BAR_LIST[i + 17] = { text="[CB "..i.."] "..DAB_Settings[DAB_INDEX].ControlBox[i].text, value=i };
	end
	DAB_BAR_LIST[12] = { text=DAB_TEXT.OtherBars, header=true };
	DAB_BAR_LIST[13] = { text=DAB_TEXT.PetBar, value=11 };
	DAB_BAR_LIST[14] = { text=DAB_TEXT.ShapeshiftBar, value=12 };
	DAB_BAR_LIST[15] = { text=DAB_TEXT.BagBar, value=13 };
	DAB_BAR_LIST[16] = { text=DAB_TEXT.MenuBar, value=14 };
	DAB_BAR_LIST[17] = { text=DAB_TEXT.ControlBoxes, header=true };
	DAB_BAR_LIST[28] = { text=DAB_TEXT.Floaters, header=true };
	local index = 29;
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Floaters[i]) then
			DAB_BAR_LIST[index] = { text="[F "..i.."] "..DAB_Get_ActionName(DAB_Settings[DAB_INDEX].Buttons[i].action), value=i };
			index = index + 1;
		end
	end
end

function DAB_Update_ProfileList()
	DAB_PROFILES = {};
	for profile in DAB_Settings do
		if ((not string.find(profile, " :: ")) and profile ~= "INITIALIZED3.0") then
			if (profile == DAB_TEXT.Default) then
				DL_AddToMenu(DAB_PROFILES, profile, nil, "All new characters will start out using this profile.");
			elseif (profile == "Custom") then
				DL_AddToMenu(DAB_PROFILES, profile, nil, "You cannot make changes to this profile.  It is used only to load settings from your current DAB_Custom.lua file.  Start a new profile before making any changes.");
			else
				DL_AddToMenu(DAB_PROFILES, profile);
			end
		end
	end
end

function DAB_Update_TextureList()
	for i=1,10 do
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].Background.texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].Background.btexture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].buttonbg, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].checked, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].highlight, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].Label.texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].Label.btexture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Bar[i].ButtonBorder.texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].ControlBox[i].texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].ControlBox[i].b1texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].ControlBox[i].b2texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].ControlBox[i].b3texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].ControlBox[i].b4texture, nil, 1);
	end
	for i=11,14 do
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].OtherBar[i].Background.texture, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].OtherBar[i].Background.btexture, nil, 1);
	end
	for i in DAB_Settings[DAB_INDEX].Floaters do
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Floaters[i].buttonbg, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Floaters[i].checked, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Floaters[i].highlight, nil, 1);
		DL_AddToMenu(DL_TEXTURES_LIST, DAB_Settings[DAB_INDEX].Floaters[i].ButtonBorder.texture, nil, 1);
	end
end

function DAB_Update_UnitList()
	for i=1,10 do
		DL_AddToMenu(DL_UNITS_LIST, DAB_Settings[DAB_INDEX].Bar[i].target);
	end
	for i in DAB_Settings[DAB_INDEX].Floaters do
		DL_AddToMenu(DL_UNITS_LIST, DAB_Settings[DAB_INDEX].Floaters[i].target);
	end
end

function DAB_SaveBindings(flag)
	DAB_Old_SaveBindings(flag);
	DAB_Save_Keybindings();
	DAB_Update_Keybindings();
end
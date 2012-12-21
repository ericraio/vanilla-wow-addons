function DAB_Add_ButtonOrPage(id)
	if (not id) then
		id = this:GetParent():GetID();
	end
	local freeButtons = table.getn(DAB_Settings[DAB_INDEX].FreeButtons);
	if (id < 11) then
		local needed = 1;
		if (needed > freeButtons) then
			DAB_NumButtons_SetWarning(needed - freeButtons);
			return;
		end
		local button = DAB_Get_FreeButton();
		local action = DAB_Get_UnusedAction();
		DAB_Settings[DAB_INDEX].Buttons[button].Bar = id;
		DAB_Settings[DAB_INDEX].Buttons[button].Bar2 = i;
		DAB_Settings[DAB_INDEX].Buttons[button].action = action;
		DAB_Settings[DAB_INDEX].Bar[id].numButtons = DAB_Settings[DAB_INDEX].Bar[id].numButtons + 1;
		for p = 1, DAB_Settings[DAB_INDEX].Bar[id].numBars do
			DAB_Settings[DAB_INDEX].Bar[id].pages[p][DAB_Settings[DAB_INDEX].Bar[id].numButtons] = action;
			action = DAB_Get_UnusedAction();
			DAB_Settings[DAB_INDEX].Bar[id].pageconditions[p][DAB_Settings[DAB_INDEX].Bar[id].numButtons] = {};
		end
	else
		id = id - 10;
		local needed = DAB_Settings[DAB_INDEX].Bar[id].numButtons;
		DAB_Settings[DAB_INDEX].Bar[id].numBars = DAB_Settings[DAB_INDEX].Bar[id].numBars + 1;
		local page = DAB_Settings[DAB_INDEX].Bar[id].numBars;
		DAB_Settings[DAB_INDEX].Bar[id].pages[page] = {};
		DAB_Settings[DAB_INDEX].Bar[id].pageconditions[page] = {};
		for i=1,needed do
			local action = DAB_Get_UnusedAction();
			DAB_Settings[DAB_INDEX].Bar[id].pages[page][i] = action;
			DAB_Settings[DAB_INDEX].Bar[id].pageconditions[page][i] = {};
		end
	end
	DAB_Init_ButtonLayout();
	DAB_Bar_Initialize(id);
	DAB_Bar_ButtonTextures(id);
	DAB_Bar_ButtonText(id);
	DAB_Bar_ButtonSize(id);
	DAB_Bar_ButtonAlpha(id);
	if (DAB_Settings[DAB_INDEX].AutoConfigureKB) then
		DAB_AutoConfigure_Keybindings();
	end
	DAB_Update_Keybindings();
end

function DAB_Add_Condition()
	if (not DAB_CONDITION_BUFFER) then return; end
	local baseOptions;
	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		baseOptions = "DAB_BarOptions_ButtonControl_";
	elseif (DAB_OBJECT_TYPE == "Bar") then
		baseOptions = "DAB_BarOptions_BarControl_";
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		baseOptions = "DAB_FloaterOptions_Control_";
	end

	local option = getglobal(baseOptions.."Buff");
	if (option:IsShown()) then
		DAB_CONDITION_BUFFER.buff = option:GetText();
		if (not DAB_CONDITION_BUFFER.buff) then DAB_CONDITION_BUFFER.buff = ""; end
	end
	option = getglobal(baseOptions.."Text");
	if (option:IsShown()) then
		DAB_CONDITION_BUFFER.text = option:GetText();
		if (not DAB_CONDITION_BUFFER.text) then DAB_CONDITION_BUFFER.text = ""; end
	end
	option = getglobal(baseOptions.."Number");
	if (option:IsShown()) then
		DAB_CONDITION_BUFFER.number = option:GetNumber();
		if (not DAB_CONDITION_BUFFER.number) then DAB_CONDITION_BUFFER.number = 1; end
	end
	option = getglobal(baseOptions.."ResponseText");
	if (option:IsShown()) then
		DAB_CONDITION_BUFFER.rtext = option:GetText();
		if (not DAB_CONDITION_BUFFER.rtext) then DAB_CONDITION_BUFFER.rtext = ""; end
	end
	option = getglobal(baseOptions.."ResponseNumber");
	if (option:IsShown()) then
		DAB_CONDITION_BUFFER.rnumber = option:GetNumber();
		if (not DAB_CONDITION_BUFFER.rnumber) then DAB_CONDITION_BUFFER.rnumber = 1; end
	end
	option = getglobal(baseOptions.."ResponseX");
	if (option and option:IsShown()) then
		DAB_CONDITION_BUFFER.rx = option:GetNumber();
		if (not DAB_CONDITION_BUFFER.rx) then DAB_CONDITION_BUFFER.rx = 0; end
	end
	option = getglobal(baseOptions.."ResponseY");
	if (option and option:IsShown()) then
		DAB_CONDITION_BUFFER.ry = option:GetNumber();
		if (not DAB_CONDITION_BUFFER.ry) then DAB_CONDITION_BUFFER.ry = 0; end
	end

	local orbox = getglobal(baseOptions.."Overrides");
	DAB_CONDITION_BUFFER.overrides = orbox:GetText();
	orbox:SetText("");
	orbox:ClearFocus();
	if (DAB_CONDITION_BUFFER.overrides and DAB_CONDITION_BUFFER.overrides ~= "") then
		local overrides = {};
		local num = "";
		local index = 1;
		local char;
		for i=1, string.len(DAB_CONDITION_BUFFER.overrides) do
			char = string.sub(DAB_CONDITION_BUFFER.overrides, i, i);
			if (char == ",") then
				num = tonumber(num);
				if (num) then
					overrides[index] = num;
					index = index + 1;
				end
				num = "";
			else
				num = num..char;
			end
		end
		num = tonumber(num);
		if (num) then
			overrides[index] = num;
		end
		DAB_CONDITION_BUFFER.overrides = {};
		DL_Copy_Table(overrides, DAB_CONDITION_BUFFER.overrides);
	else
		DAB_CONDITION_BUFFER.overrides = {};
	end
	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
		local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
		local bar = DAB_OBJECT_SUBINDEX;
		local index = table.getn(DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button]) + 1;
		if (DAB_CONDITION_EDITTING) then
			index = DAB_CONDITION_EDITTING;
		end
		DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button][index] = {};
		DL_Copy_Table(DAB_CONDITION_BUFFER, DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button][index]);
		DAB_BarOptions_ButtonControl_Condition_Setting:SetText("");
		DAB_BarOptions_ButtonControl_Response_Setting:SetText("");
		DAB_Reset_Parameters("DAB_BarOptions_ButtonControl");
		local id = DAB_Get_BarButtonID(bar, page, button);
		getglobal("DAB_ActionButton_"..id).activeConditions = {};
	elseif (DAB_OBJECT_TYPE == "Bar") then
		local index = table.getn(DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions) + 1;
		if (DAB_CONDITION_EDITTING) then
			index = DAB_CONDITION_EDITTING;
		end
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions[index] = {};
		DL_Copy_Table(DAB_CONDITION_BUFFER, DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions[index]);
		DAB_BarOptions_BarControl_Condition_Setting:SetText("");
		DAB_BarOptions_BarControl_Response_Setting:SetText("");
		DAB_Reset_Parameters("DAB_BarOptions_BarControl");
		getglobal("DAB_ActionBar_"..DAB_OBJECT_SUBINDEX).activeConditions = {};
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		local index = table.getn(DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions) + 1;
		if (DAB_CONDITION_EDITTING) then
			index = DAB_CONDITION_EDITTING;
		end
		DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions[index] = {};
		DL_Copy_Table(DAB_CONDITION_BUFFER, DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions[index]);
		DAB_FloaterOptions_Control_Condition_Setting:SetText("");
		DAB_FloaterOptions_Control_Response_Setting:SetText("");
		DAB_Reset_Parameters("DAB_FloaterOptions_Control");
		getglobal("DAB_ActionButton_"..DAB_OBJECT_SUBINDEX).activeConditions = {};
	end
	DAB_ConditionMenu_Update();
	DAB_CONDITION_BUFFER = nil;
	DAB_CONDITION_EDITTING = nil;
end

function DAB_Add_Event()
	DAB_NewEvent:Hide();
	local event = DAB_NewEvent_Event:GetText();
	local name = DAB_NewEvent_Name:GetText();
	local desc = DAB_NewEvent_Desc:GetText();
	DAB_NewEvent_Event:SetText("");
	DAB_NewEvent_Name:SetText("");
	DAB_NewEvent_Desc:SetText("");
	if ((not event) or event == "") then return; end
	if ((not name) or name == "") then name = event; end
	if (not desc) then desc = ""; end
	DAB_Settings[DAB_INDEX].CustomEvents[event] = {text=name, desc=desc};
	DAB_Update_EventList();
end

function DAB_Add_Floater()
	if (table.getn(DAB_Settings[DAB_INDEX].FreeButtons) == 0) then
		DAB_NumButtons_SetWarning(1);
		return;
	end
	local id = DAB_Get_FreeButton();
	local action = DAB_Get_UnusedAction();
	DAB_Floater_SetDefaults(id, action);
	DAB_Settings[DAB_INDEX].Buttons[id].action = action;
	DAB_Floater_Initialize(id);
	DAB_Init_ButtonLayout();
	DAB_Update_ObjectList();
	DAB_Update_FloaterList();
	DAB_Update_AnchorsList();
	DAB_BarBrowser_Update();
	if (DAB_Settings[DAB_INDEX].AutoConfigureKB) then
		DAB_AutoConfigure_Keybindings();
	end
	DAB_Update_Keybindings();
end

function DAB_AddFloater_OnMouseWheel()
	if (arg1 > 0) then
		DAB_Add_Floater();
	end
end

function DAB_AnchorFrameEditBox_OnEnterPressed()
	DAB_MenuEditBox_OnEnterPressed();
	DAB_Update_AnchorsList();
end

function DAB_Apply_IDRange()
	DAB_SetActionIDs_Min:ClearFocus();
	DAB_SetActionIDs_Max:ClearFocus();
	local min = DAB_SetActionIDs_Min:GetNumber();
	local max = DAB_SetActionIDs_Max:GetNumber();
	if (not min) then return; end
	if (not max or max == 0) then max = 120; end
	if (min < 1 or min > 120 or max < 1 or max > 120) then
		DL_Debug("Action IDs can only be a number between 1 and 120.");
		return;
	end
	local step = 1;
	if (min > max) then
		step = -1;
	end
	local index = 0;
	for action=min,max,step do
		index = index + 1;
		if (DAB_ACTIONIDS_LIST[index]) then
			local bar = DAB_ACTIONIDS_LIST[index].bar;
			local button = DAB_ACTIONIDS_LIST[index].button;
			if (bar == "F") then
				DAB_Settings[DAB_INDEX].Buttons[button].action = action;
				DAB_ActionButton_Update(button);
			else
				local page = DAB_ACTIONIDS_LIST[index].page;
				DAB_Settings[DAB_INDEX].Bar[bar].pages[page][button] = action;
				DAB_Bar_SetPage(bar, DAB_Settings[DAB_INDEX].Bar[bar].page, 1);
			end
			DAB_ACTIONIDS_LIST[index].action = action;
		end
	end
	DAB_SetActionIDsMenu_Update();
	DAB_Update_FloaterList();
	DAB_Update_ObjectList();
	DAB_BarBrowser_Update();
end

function DAB_AutoConfigure_Keybindings()
	local count = 0;
	for bar = 1,5 do
		for button = 1,DAB_Settings[DAB_INDEX].Bar[bar].numButtons do
			count = count + 1;
			local key1 = DAB_Settings[DAB_INDEX].Keybindings[count].key1;
			local key2 = DAB_Settings[DAB_INDEX].Keybindings[count].key2;
			DAB_Settings[DAB_INDEX].Keybindings[count] = {option=1, suboption=bar, suboption2=button, down=1, key1=key1, key2=key2};
		end
	end
	for f=1,120 do
		if (DAB_Settings[DAB_INDEX].Floaters[f]) then
			count = count + 1;
			if (count > 120) then return; end
			local key1 = DAB_Settings[DAB_INDEX].Keybindings[count].key1;
			local key2 = DAB_Settings[DAB_INDEX].Keybindings[count].key2;
			DAB_Settings[DAB_INDEX].Keybindings[count] = {option=3, suboption=f, down=1, key1=key1, key2=key2};
		end
	end
	for b=1,10 do
		count = count + 1;
		if (count > 120) then return; end
		local key1 = DAB_Settings[DAB_INDEX].Keybindings[count].key1;
		local key2 = DAB_Settings[DAB_INDEX].Keybindings[count].key2;
		DAB_Settings[DAB_INDEX].Keybindings[count] = {option=4, suboption=b, down=1, key1=key1, key2=key2};
	end
	for bar=1,10 do
		if (DAB_Settings[DAB_INDEX].Bar[bar].numBars > 1) then
			count = count + 1;
			if (count > 120) then return; end
			local key1 = DAB_Settings[DAB_INDEX].Keybindings[count].key1;
			local key2 = DAB_Settings[DAB_INDEX].Keybindings[count].key2;
			DAB_Settings[DAB_INDEX].Keybindings[count] = {option=7, suboption=bar, down=1, key1=key1, key2=key2};
			count = count + 1;
			if (count > 120) then return; end
			local key1 = DAB_Settings[DAB_INDEX].Keybindings[count].key1;
			local key2 = DAB_Settings[DAB_INDEX].Keybindings[count].key2;
			DAB_Settings[DAB_INDEX].Keybindings[count] = {option=8, suboption=bar, down=1, key1=key1, key2=key2};
		end
	end
	for group=1,2 do
		for button=1,12 do
			count = count + 1;
			if (count > 120) then return; end
			local key1 = DAB_Settings[DAB_INDEX].Keybindings[count].key1;
			local key2 = DAB_Settings[DAB_INDEX].Keybindings[count].key2;
			DAB_Settings[DAB_INDEX].Keybindings[count] = {option=2, suboption=group, suboption2=button, down=1, key1=key1, key2=key2};
		end
	end

	count = count + 1;
	for i=count,120 do
		local key1 = DAB_Settings[DAB_INDEX].Keybindings[count].key1;
		local key2 = DAB_Settings[DAB_INDEX].Keybindings[count].key2;
		DAB_Settings[DAB_INDEX].Keybindings[i] = {option=0, down=1, key1=key1, key2=key2};
	end

	DAB_Save_Keybindings();
end

function DAB_BarBrowser_OnClick()
	this:SetChecked(1);
	DAB_Show_Window(this.index);
	DAB_BarBrowser_Update();
end

function DAB_BarBrowser_Update()
	local numOptions = table.getn(DAB_BAR_LIST);
	local offset = FauxScrollFrame_GetOffset(DAB_Options_BarBrowser);
	if (not offset) then offset = 0; end
	local index, button;
	
	for i=1, 15 do
		button = getglobal("DAB_Options_BarBrowser_Button"..i);
		buttontext = getglobal("DAB_Options_BarBrowser_Button"..i.."Text");
		index = offset + i;
		button.index = index;
		if ( DAB_BAR_LIST[index] ) then
			buttontext:SetText(DAB_BAR_LIST[index].text);
			buttontext:SetJustifyH("LEFT");
			button:Enable();
			button:Show();
			if (DAB_BAR_LIST[index].header) then
				button:Disable();
				buttontext:SetJustifyH("CENTER");
				button:SetChecked(0);
				buttontext:SetTextColor(1, .82, 0);
				buttontext:SetFont("Fonts\\MORPHEUS.ttf", 13);
			elseif (DAB_OBJECT_INDEX == button.index) then
				button:SetChecked(1);
				buttontext:SetTextColor(1, 0, 0);
				buttontext:SetFont("Fonts\\FRIZQT__.TTF", 12);
			else
				button:SetChecked(0);
				buttontext:SetTextColor(1, 1, 1);
				buttontext:SetFont("Fonts\\ARIALN.TTF", 12);
			end
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DAB_Options_BarBrowser, numOptions, 15, 20 );
end

function DAB_BarOptions_OnMouseWheel(direction)
	if (direction > 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX - 1;
	elseif (direction < 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX + 1;
	end
	if (DAB_OBJECT_INDEX > 11) then
		DAB_OBJECT_INDEX = 2;
	elseif (DAB_OBJECT_INDEX < 2) then
		DAB_OBJECT_INDEX = 11;
	end
	DAB_OBJECT_SUBINDEX = DAB_OBJECT_INDEX - 1;
	DAB_Init_BarOptions();
	DAB_BarBrowser_Update();
end

function DAB_BarButtonsMenu_Update()
	local numOptions = table.getn(DAB_BAR_BUTTONS);
	local offset = FauxScrollFrame_GetOffset(DAB_BarOptions_ButtonControl_ButtonsMenu);
	if (not offset) then offset = 0; end
	local index, button;
	
	for i=1, 4 do
		buttonName = "DAB_BarOptions_ButtonControl_ButtonsMenu_Button"..i;
		button = getglobal(buttonName);
		index = offset + i;
		button.action = nil;
		if ( DAB_BAR_BUTTONS[index] ) then
			button:Show();
			button:SetChecked(0);
			button.button = DAB_BAR_BUTTONS[index].button;
			button.page = DAB_BAR_BUTTONS[index].page;
			button.index = index;
			local action = DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].pages[button.page][button.button];
			getglobal(buttonName.."_Icon"):SetTexture(GetActionTexture(action));
			getglobal(buttonName.."_Button"):SetText(DAB_TEXT.Button..": "..DAB_BAR_BUTTONS[index].page.."/"..DAB_BAR_BUTTONS[index].button);
			getglobal(buttonName.."_ActionID"):SetText(DAB_TEXT.Action..": "..action);
			getglobal(buttonName.."_Action"):SetText(DAB_Get_ActionName(action));
			if (DAB_SELECTED_BARBUTTON == index) then
				button:SetChecked(1);
			end
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DAB_BarOptions_ButtonControl_ButtonsMenu, numOptions, 4, 20 );
	DAB_BarOptions_ButtonControl_ButtonsMenu:Show();
end

function DAB_CBoxOptions_OnMouseWheel(direction)
	if (direction > 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX - 1;
	elseif (direction < 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX + 1;
	end
	if (DAB_OBJECT_INDEX > 27) then
		DAB_OBJECT_INDEX = 18;
	elseif (DAB_OBJECT_INDEX < 18) then
		DAB_OBJECT_INDEX = 27;
	end
	DAB_OBJECT_SUBINDEX = DAB_BAR_LIST[DAB_OBJECT_INDEX].value;
	DAB_Init_ControlBoxOptions();
	DAB_BarBrowser_Update();
end

function DAB_Change_PageControlBar()
	DAB_CONTROL_PAGES = {};
	for i=1, DAB_Settings[DAB_INDEX].Bar[this.value].numBars do
		DAB_CONTROL_PAGES[i] = {text=i, value=i};
	end
	if (DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].changePagePage > DAB_Settings[DAB_INDEX].Bar[this.value].numBars) then
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].changePagePage = 1;
		DL_Init_MenuControl(DAB_CBoxOptions_Control_PageControlPage, DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].changePagePage);
	end
	DAB_Update_Setting(DAB_DropMenu.settingType, this.value, DAB_DropMenu.index, DAB_DropMenu.subindex, DAB_DropMenu.subindex2);
end

function DAB_Change_PageControlType()
	if (this.value == 3) then
		DAB_CBoxOptions_Control_PageControlPage:Show();
	else
		DAB_CBoxOptions_Control_PageControlPage:Hide();
	end
	DAB_Update_Setting(DAB_DropMenu.settingType, this.value, DAB_DropMenu.index, DAB_DropMenu.subindex, DAB_DropMenu.subindex2);
end

function DAB_ChangeActionsMenu_Update()
	local numOptions = 120;
	local offset = FauxScrollFrame_GetOffset(DAB_ChangeActions_ScrollMenu);
	if (not offset) then offset = 0; end
	local index, button, buttontext, icon, idtext;
	
	for i=1, 13 do
		button = getglobal("DAB_ChangeActions_ScrollMenu_Button"..i);
		buttontext = getglobal("DAB_ChangeActions_ScrollMenu_Button"..i.."_Text");
		actionbutton = getglobal("DAB_ChangeActions_ScrollMenu_Button"..i.."_Button");
		icon = getglobal("DAB_ChangeActions_ScrollMenu_Button"..i.."_Button_Icon");
		idtext = getglobal("DAB_ChangeActions_ScrollMenu_Button"..i.."_ID");
		index = offset + i;
		if ( index <= 120 ) then
			idtext:SetText(index..":");
			actionbutton.action = index;
			if (HasAction(index)) then
				icon:SetTexture(GetActionTexture(index));
			else
				icon:SetTexture("Interface\\AddOns\\DiscordLibrary\\EmptyButton");
			end
			buttontext:SetText(DAB_Get_ActionName(index));
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DAB_ChangeActions_ScrollMenu, numOptions, 13, 40 );
end

function DAB_CheckBox_OnClick()
	local value;
	if (this:GetChecked()) then
		value = 1;
	end
	DAB_Update_Setting(this.settingType, value, this.index, this.subindex, this.subindex2);
end

function DAB_ColorPicker_OnClick()
	local basecolor = DAB_Get_Setting(this.index, this.subindex);
	local color = {};
	color.r = basecolor.r;
	color.g = basecolor.g;
	color.b = basecolor.b;
	ColorPickerFrame.hasOpacity = nil;
	ColorPickerFrame.previousValues = color;
	ColorPickerFrame.cancelFunc = DAB_ColorPicker_ColorCancelled;
	ColorPickerFrame.opacityFunc = DAB_ColorPicker_ColorChanged;
	ColorPickerFrame.func = DAB_ColorPicker_ColorChanged;
	ColorPickerFrame.colorBox = this:GetName();
	ColorPickerFrame.index = this.index;
	ColorPickerFrame.subindex = this.subindex;
	ColorPickerFrame.settingType = this.settingType;
	ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
	ColorPickerFrame:ClearAllPoints();
	if (DAB_Options:GetRight() < UIParent:GetWidth() / 2) then
		ColorPickerFrame:SetPoint("LEFT", "DAB_Options", "RIGHT", 10, 0);
	else
		ColorPickerFrame:SetPoint("RIGHT", "DAB_Options", "LEFT", -10, 0);
	end
	ColorPickerFrame:Show();
end

function DAB_ColorPicker_ColorCancelled()
	local color = ColorPickerFrame.previousValues;
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	DAB_Update_Setting(ColorPickerFrame.settingType, color, ColorPickerFrame.index, ColorPickerFrame.subindex);
end

function DAB_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local color = { r=r, g=g, b=b };
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	DAB_Update_Setting(ColorPickerFrame.settingType, color, ColorPickerFrame.index, ColorPickerFrame.subindex);
end

function DAB_Condition_Delete()
	local list;
	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
		local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
		local bar = DAB_OBJECT_SUBINDEX;
		list = DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button];
		getglobal("DAB_ActionButton_"..DAB_SELECTED_BARBUTTON).activeConditions = {};
	elseif (DAB_OBJECT_TYPE == "Bar") then
		list = DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions;
		getglobal("DAB_ActionBar_"..DAB_OBJECT_SUBINDEX).activeConditions = {};
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		list = DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions;
		getglobal("DAB_ActionButton_"..DAB_OBJECT_SUBINDEX).activeConditions = {};
	end
	for i=1, table.getn(list) do
		if (i > this:GetParent().index and i > 1) then
			list[i - 1] = {};
			DL_Copy_Table(list[i], list[i - 1]);
		end
	end
	list[table.getn(list)] = nil;
	DAB_ConditionMenu_Update();
end

function DAB_Condition_Edit()
	local ci = this:GetParent().index;
	DAB_Select_Condition(ci, this:GetParent().cboxbase);
	DAB_Select_Response(DAB_CONDITION_BUFFER.response, this:GetParent().cboxbase);
end

function DAB_Condition_MoveDown()
	local list;
	local index = this:GetParent().index;
	local newindex = index + 1;

	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
		local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
		local bar = DAB_OBJECT_SUBINDEX;
		list = DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button];
	elseif (DAB_OBJECT_TYPE == "Bar") then
		list = DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions;
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		list = DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions;
	end
	if (newindex > table.getn(list)) then return; end

	local buffer = {};
	DL_Copy_Table(list[index], buffer);
	local buffer2 = {};
	DL_Copy_Table(list[newindex], buffer2);

	DL_Copy_Table(buffer2, list[index]);
	DL_Copy_Table(buffer, list[newindex]);
	DAB_ConditionMenu_Update();
end

function DAB_Condition_MoveUp()
	local list;
	local index = this:GetParent().index;
	local newindex = index - 1;
	if (newindex == 0) then return; end

	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
		local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
		local bar = DAB_OBJECT_SUBINDEX;
		list = DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button];
	elseif (DAB_OBJECT_TYPE == "Bar") then
		list = DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions;
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		list = DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions;
	end

	local buffer = {};
	DL_Copy_Table(list[index], buffer);
	local buffer2 = {};
	DL_Copy_Table(list[newindex], buffer2);

	DL_Copy_Table(buffer2, list[index]);
	DL_Copy_Table(buffer, list[newindex]);
	DAB_ConditionMenu_Update();
end

function DAB_ConditionMenu_Update()
	local list, frame, numButtons;
	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		local bar = DAB_OBJECT_SUBINDEX;
		if (DAB_Settings[DAB_INDEX].Bar[bar].numButtons == 0) then return; end
		local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
		local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
		list = DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button];
		frame = DAB_BarOptions_ButtonControl_ConditionMenu;
		numButtons = 2;
	elseif (DAB_OBJECT_TYPE == "Bar") then
		list = DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions;
		frame = DAB_BarOptions_BarControl_ConditionMenu;
		numButtons = 5;
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		list = DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions;
		frame = DAB_FloaterOptions_Control_ConditionMenu;
		numButtons = 5;
	end
	local numOptions = table.getn(list);
	local offset = FauxScrollFrame_GetOffset(frame);
	if (not offset) then offset = 0; end
	local index, button, text;
	
	for i=1, numButtons do
		button = getglobal(frame:GetName().."_Button"..i);
		index = offset + i;
		if ( list[index] ) then
			button:Disable();
			button:Show();
			button.index = index;
			button.cboxbase = frame:GetName();
			text = DL_Get_MenuText(DL_CONDITIONS_MENU, list[index].condition);
			if (not text) then text = ""; end
			local conditionsIndex;
			for cindex, value in DL_CONDITIONS_MENU do
				if (value.value == list[index].condition) then
					conditionsIndex = cindex;
					break;
				end
			end
			local params = DL_CONDITIONS_MENU[conditionsIndex].params;
			if (params == 1 or params == 2) then
				text = text..": |cFFFFFFFF"..DL_Get_MenuText(DAB_ACTIONS, list[index].action);
				if (list[index].ignoreGlobal) then
					text = text..",|cFFCCCCCC "..DAB_TEXT.IgnoreGlobal;
				end
			elseif (params == 3) then
				text = text.." on "..list[index].unit..": |cFFFFFFFF"..list[index].buff;
			elseif (params == 4) then
				text = text.." |cFFFFFFFF"..DL_Get_MenuText(DL_COMPARE_MENU, list[index].compare).." "..list[index].number;
			elseif (params == 5) then
				text = text..": |cFFFFFFFF"..list[index].unit..", "..list[index].text;
			elseif (params == 6) then
				text = text.." Applications "..DL_Get_MenuText(DL_COMPARE_MENU, list[index].compare).." "..list[index].number.." on "..list[index].unit..": |cFFFFFFFF"..list[index].text;
			elseif (params == 7) then
				local number = list[index].number;
				if (number < 1) then
					number = (number * 100).."%";
				end
				text = text.." "..list[index].unit.." "..DL_Get_MenuText(DL_COMPARE_MENU, list[index].compare).." "..number;
			elseif (params == 8) then
				local form = DL_Get_MenuText(DL_FORMS, list[index].form);
				if (form == "") then
					form = list[index].form;
				end
				text = text..": |cFFFFFFFF"..form;
			elseif (params == 9) then
				text = text..": |cFFFFFFFF"..DL_Get_MenuText(DL_TARGET_PARAMS, list[index].target);
			elseif (params == 10) then
				text = text..": |cFFFFFFFF"..list[index].number;
			elseif (params == 11) then
				text = text..": |cFFFFFFFF"..DL_Get_MenuText(DAB_ACTIONS, list[index].action).." "..DL_Get_MenuText(DL_COMPARE_MENU, list[index].compare).." "..list[index].number;
			elseif (params == 12) then
				text = text..": |cFFFFFFFF"..list[index].text;
			elseif (params == 13) then
				text = text..": |cFFFFFFFF"..list[index].unit;
			elseif (params == 14) then
				text = text..": |cFFFFFFFF"..list[index].unit.." and "..list[index].unit2;
			elseif (params == 200) then
				text = text..": |cFFFFFFFFBar "..list[index].bar.."'s Page "..DL_Get_MenuText(DL_COMPARE_MENU, list[index].compare).." "..list[index].number;
			end
			getglobal(frame:GetName().."_Button"..i.."ConditionText"):SetText(text);

			text = DAB_TEXT.Response.." |cFFFFFF00"..DL_Get_MenuText(getglobal(frame.responsemenu), list[index].response);
			if (list[index].response == 1) then
				text = text.." to "..list[index].page;
			elseif (list[index].response == 4 or list[index].response == 5 or list[index].response == 7) then
				text = text.." to "..(list[index].alpha * 100).."%";
			elseif (list[index].response == 6 or list[index].response == 8 or list[index].response == 20 or (list[index].response == 22 and list[index].color)) then
				local hex = DL_Get_HexColor(list[index].color.r, list[index].color.g, list[index].color.b);
				text = text.." to "..hex.."this color";
			elseif (list[index].response == 19 or (list[index].response > 10 and list[index].response < 19)) then
				text = text..": |cFFFFFFFF"..list[index].amount;
			elseif (list[index].response == 100 or list[index].response == 101 or list[index].response == 108 or list[index].response == 109 or list[index].response == 114 or list[index].response == 115) then
				text = text..": |cFFFFFFFF"..list[index].rtext;
			elseif (list[index].response == 23 or (list[index].response > 101 and list[index].response < 108)) then
				text = text..": |cFFFFFFFF"..list[index].rnumber;
			elseif (list[index].response == 29 or list[index].response == 111) then
				text = text..": |cFFFFFFFF"..DL_Get_MenuText(DAB_ACTIONS, list[index].raction);
			elseif (list[index].response == 110) then
				text = text..": |cFFFFFFFF"..DL_Get_MenuText(DAB_ACTIONS, list[index].raction).." on "..list[index].runit;
			elseif (list[index].response == 32) then
				text = text.." "..list[index].page2.." to "..list[index].page;
			elseif (list[index].response == 33) then
				text = text..": |cFFFFFFFF"..list[index].runit;
			elseif (list[index].response == 35) then
				text = text..": |cFFFFFFFF"..list[index].rx..", "..list[index].ry;
			elseif (list[index].response == 113) then
				text = text.." "..list[index].rtext.." for "..list[index].rnumber.." seconds";
			end
			getglobal(frame:GetName().."_Button"..i.."ResponseText"):SetText(text);

			text = DAB_TEXT.Overrides.." |cFFFFFFFF";
			for i,o in list[index].overrides do
				if (i == table.getn(list[index].overrides)) then
					text = text..o;
				else
					text = text..o..", ";
				end
			end
			getglobal(frame:GetName().."_Button"..i.."OverrideText"):SetText(text);
			getglobal(frame:GetName().."_Button"..i.."Index"):SetText(index);
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(frame, numOptions, numButtons, 40);
	frame:Show();
end

function DAB_Copy_ControlSettings()
	DAB_CONTROL_BUFFER = {};
	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
		local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
		local bar = DAB_OBJECT_SUBINDEX;
		DL_Copy_Table(DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button], DAB_CONTROL_BUFFER);
	elseif (DAB_OBJECT_TYPE == "Bar") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions, DAB_CONTROL_BUFFER);
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions, DAB_CONTROL_BUFFER);
	end
end

function DAB_Copy_Settings()
	DAB_BUFFER = {};
	if (DAB_OBJECT_TYPE == "Bar") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX], DAB_BUFFER);
		DAB_Options_Paste:SetText(DL_PASTETEXT.." (Bar "..DAB_OBJECT_SUBINDEX..")");
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX], DAB_BUFFER);
		DAB_Options_Paste:SetText(DL_PASTETEXT.." (Floater "..DAB_OBJECT_SUBINDEX..")");
	elseif (DAB_OBJECT_TYPE == "ControlBox") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX], DAB_BUFFER);
		DAB_Options_Paste:SetText(DL_PASTETEXT.." (Control Box "..DAB_OBJECT_SUBINDEX..")");
	elseif (DAB_OBJECT_TYPE == "OtherBar") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].OtherBar[DAB_OBJECT_SUBINDEX], DAB_BUFFER);
		DAB_Options_Paste:SetText(DL_PASTETEXT.." Other Bar");
	end
	DAB_BUFFER_TYPE = DAB_OBJECT_TYPE;
	DAB_Options_Paste:Enable();
end

function DAB_DropMenu_OnClick()
	getglobal(DAB_DropMenu.controlbox):SetText(getglobal(this:GetName().."_Text"):GetText());
	DAB_DropMenu:Hide();
	if (DAB_DropMenu.initFunc) then
		DAB_DropMenu.initFunc();
	else
		DAB_Update_Setting(DAB_DropMenu.settingType, this.value, DAB_DropMenu.index, DAB_DropMenu.subindex, DAB_DropMenu.subindex2);
	end
end

function DAB_EditBox_Update()
	local value = this:GetText();
	if (not value) then value = ""; end
	if (this.number) then
		value = this:GetNumber();
		if (not value) then
			value = 0;
			this:SetText("0");
		end
	end
	this:ClearFocus();
	this.prevvalue = value;
	DAB_Update_Setting(this.settingType, value, this.index, this.subindex);
end

function DAB_Filter_ActionIDs()
	if (DAB_DropMenu.index == "filter1") then
		DAB_ACTIONIDS_FILTER1 = this.value;
		DAB_ACTIONIDS_FILTER2 = 1;
		if (DAB_ACTIONIDS_FILTER1 > 2) then
			DAB_ACTIONID_FILTERS2 = { {text="All Pages", value=1} };
			local bar = this.value - 2;
			for page=1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
				DAB_ACTIONID_FILTERS2[page + 1] = {text="Page "..page, value=page + 1};
			end
			DAB_SetActionIDs_FilterMenu2_Setting:SetText("All Pages");
		else
			DAB_ACTIONID_FILTERS2 = {};
			DAB_SetActionIDs_FilterMenu2_Setting:SetText("");
		end
	else
		DAB_ACTIONIDS_FILTER2 = this.value;
	end
	DAB_Update_ActionIDsList();
end

function DAB_FloaterOptions_OnMouseWheel(direction)
	if (direction > 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX - 1;
	elseif (direction < 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX + 1;
	end
	if (DAB_OBJECT_INDEX > table.getn(DAB_BAR_LIST)) then
		DAB_OBJECT_INDEX = 29;
	elseif (DAB_OBJECT_INDEX < 29) then
		DAB_OBJECT_INDEX = table.getn(DAB_BAR_LIST);
	end
	DAB_OBJECT_SUBINDEX = DAB_BAR_LIST[DAB_OBJECT_INDEX].value;
	DAB_Init_FloaterOptions();
	DAB_BarBrowser_Update();
end

function DAB_FontEditBox_OnEnterPressed()
	DAB_MenuEditBox_OnEnterPressed();
	DAB_Update_FontList();
end

function DAB_Get_FreeButton()
	local low = 999;
	for i, b in DAB_Settings[DAB_INDEX].FreeButtons do
		if (b < low) then
			low = b;
		end
	end
	local oldFree = {};
	DL_Copy_Table(DAB_Settings[DAB_INDEX].FreeButtons, oldFree);
	DAB_Settings[DAB_INDEX].FreeButtons = {};
	local index = 0;
	for i, b in oldFree do
		if (b ~= low) then
			index = index + 1;
			DAB_Settings[DAB_INDEX].FreeButtons[index] = b;
		end
	end
	return low;
end

function DAB_Get_Setting(index, subindex, subindex2)
	if (index == "Misc") then
		return DAB_Settings[DAB_INDEX][subindex];
	elseif (index == "CONDITION") then
		return DAB_CONDITION_BUFFER[subindex];
	elseif (index == "MainMenuBar") then
		return DAB_Settings[DAB_INDEX].MainMenuBar[subindex];
	else
		if (subindex2) then
			return DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX][index][subindex][subindex2];
		elseif (subindex) then
			return DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX][index][subindex];
		else
			return DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX][index];
		end
	end
end

function DAB_Get_UnusedAction()
	local unusedAction;
	local usedactions = {};
	for bar = 1, DAB_NUM_BARS do
		for page = 1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
			if (DAB_Settings[DAB_INDEX].Bar[bar].pages[page]) then
				for _, pageAction in DAB_Settings[DAB_INDEX].Bar[bar].pages[page] do
					usedactions[pageAction] = 1;
				end
			end
		end
	end
	for button = 1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[button].Bar) then
			usedactions[DAB_Settings[DAB_INDEX].Buttons[button].action] = 1;
		end
	end
	for i = 1, 120 do
		if (not usedactions[i]) then
			unusedAction = i;
			break;
		end
	end
	if (not unusedAction) then
		if (DAB_LAST_USED) then
			DAB_LAST_USED = DAB_LAST_USED + 1;
			unusedAction = DAB_LAST_USED;
		else
			DAB_LAST_USED = 1;
			unusedAction = 1;
		end
	end
	return unusedAction;
end

function DAB_GroupEditBox_OnEnterPressed()
	DAB_MenuEditBox_OnEnterPressed();
	DAB_Update_GroupList();
end

function DAB_HideAllOptions()
	DAB_BarOptions:Hide();
	DAB_OtherBarOptions:Hide();
	DAB_ButtonLayout:Hide();
	DAB_FloaterOptions:Hide();
	DAB_OnEventMacros:Hide();
	DAB_MainBarOptions:Hide();
	DAB_CBoxOptions:Hide();
	DAB_ScriptOptions:Hide();
	DAB_KeybindingOptions:Hide();
	DAB_MiscOptions:Hide();
	DAB_ChangeActions:Hide();
end

function DAB_KeybindingBrowser_Update()
	local numOptions = 120;
	local offset = FauxScrollFrame_GetOffset(DAB_KeybindingOptions_KeybindingBrowser);
	local index, button;
	
	for i=1, 10 do
		button = "DAB_KeybindingOptions_KeybindingBrowser_Button"..i;
		index = offset + i;
		local option = DAB_Settings[DAB_INDEX].Keybindings[index].option;
		local suboption = DAB_Settings[DAB_INDEX].Keybindings[index].suboption;
		local suboption2 = DAB_Settings[DAB_INDEX].Keybindings[index].suboption2;
		getglobal(button).index = index;
		getglobal(button.."Index"):SetText(index);
		DL_Init_MenuControl(getglobal(button.."_Option"), option);
		setglobal("DAB_KEYBINDING_SUBOPTIONS_"..i, {});
		setglobal("DAB_KEYBINDING_SUBOPTIONS2_"..i, {});
		local suboptiontable = getglobal("DAB_KEYBINDING_SUBOPTIONS_"..i);
		local suboption2table = getglobal("DAB_KEYBINDING_SUBOPTIONS2_"..i);
		
		if (option == 0) then
			getglobal(button.."_Suboption_Label"):SetText("");
			getglobal(button.."_Suboption2_Label"):SetText("");
		elseif (option == 1 or option == 10) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Bar);
			getglobal(button.."_Suboption2_Label"):SetText(DAB_TEXT.Button);
			for i=1,10 do
				suboptiontable[i] = {text=i, value=i};
			end
			for i=1,DAB_Settings[DAB_INDEX].Bar[suboption].numButtons do
				local button = DAB_Settings[DAB_INDEX].Bar[suboption].pages[DAB_Settings[DAB_INDEX].Bar[suboption].page][i];
				suboption2table[i] = {text="["..i.."] "..DAB_Get_ActionName(button), value=i};
			end
		elseif (option == 2) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Group);
			getglobal(button.."_Suboption2_Label"):SetText(DAB_TEXT.Button);
			for i=1,120 do
				suboptiontable[i] = {text=i, value=i};
				suboption2table[i] = {text=i, value=i};
			end
		elseif (option == 3 or option == 11) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Floater);
			getglobal(button.."_Suboption2_Label"):SetText("");
			local count = 0;
			for i in DAB_Settings[DAB_INDEX].Floaters do
				count = count + 1;
				suboptiontable[count] = {text="["..i.."] "..DAB_Get_ActionName(DAB_Settings[DAB_INDEX].Buttons[i].action), value=i};
			end
		elseif (option == 4) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.CtrlBox);
			getglobal(button.."_Suboption2_Label"):SetText("");
			for i=1,10 do
				suboptiontable[i] = {text=i, value=i};
			end
		elseif (option == 5) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Group);
			getglobal(button.."_Suboption2_Label"):SetText(DAB_TEXT.Bar);
			for i=1,120 do
				suboptiontable[i] = {text=i, value=i};
			end
			for i=1,10 do
				suboption2table[i] = {text=i, value=i};
			end
		elseif (option == 6) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Bar);
			getglobal(button.."_Suboption2_Label"):SetText(DAB_TEXT.Page);
			for i=1,10 do
				suboptiontable[i] = {text=i, value=i};
			end
			for i=1,DAB_Settings[DAB_INDEX].Bar[suboption].numBars do
				suboption2table[i] = {text=i, value=i};
			end
		elseif (option == 7 or option == 8) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Bar);
			getglobal(button.."_Suboption2_Label"):SetText("");
			for i=1,10 do
				suboptiontable[i] = {text=i, value=i};
			end
		elseif (option == 9) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Number);
			getglobal(button.."_Suboption2_Label"):SetText("");
			for i=1,120 do
				suboptiontable[i] = {text=i, value=i};
			end
		elseif (option == 12) then
			local _, _, bar, page = string.find(suboption, "(%d*)_(%d*)");
			bar = tonumber(bar);
			page = tonumber(page);
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Bar);
			getglobal(button.."_Suboption2_Label"):SetText(DAB_TEXT.Button);
			local index = 0;
			for i=1,10 do
				for page=1, DAB_Settings[DAB_INDEX].Bar[i].numBars do
					index = index + 1;
					suboptiontable[index] = {text=DAB_TEXT.Bar.." "..i..", "..DAB_TEXT.Page.." "..page, value=i.."_"..page};
				end
			end
			for i=1,DAB_Settings[DAB_INDEX].Bar[bar].numButtons do
				local button = DAB_Settings[DAB_INDEX].Bar[bar].pages[page][i];
				suboption2table[i] = {text="["..i.."] "..DAB_Get_ActionName(button), value=i};
			end
		elseif (option == 13 or option == 14) then
			getglobal(button.."_Suboption_Label"):SetText(DAB_TEXT.Action);
			getglobal(button.."_Suboption2_Label"):SetText("");
			for i=1,120 do
				suboptiontable[i] = {text="["..i.."] "..DAB_Get_ActionName(i), value=i};
			end
		end
		DL_Init_MenuControl(getglobal(button.."_Suboption"), suboption);
		DL_Init_MenuControl(getglobal(button.."_Suboption2"), suboption2);
		local key1, key2 = DL_Get_KeybindingText("DAB_"..index, nil, 1);
		if (key1) then
			getglobal(button.."_Key1"):SetText(key1);
		else
			getglobal(button.."_Key1"):SetText("");
		end
		if (key2) then
			getglobal(button.."_Key2"):SetText(key2);
		else
			getglobal(button.."_Key2"):SetText("");
		end
		getglobal(button.."_Key1"):UnlockHighlight();
		getglobal(button.."_Key2"):UnlockHighlight();
		if (DAB_SELECTED_KEYBINDING.index == index) then
			if (DAB_SELECTED_KEYBINDING.keyID == 1) then
				getglobal(button.."_Key1"):LockHighlight();
			else
				getglobal(button.."_Key2"):LockHighlight();
			end
		end
		if (DAB_Settings[DAB_INDEX].Keybindings[index].down) then
			getglobal(button.."_Down"):SetChecked(1);
		else
			getglobal(button.."_Down"):SetChecked(0);
		end
		if (DAB_Settings[DAB_INDEX].Keybindings[index].up) then
			getglobal(button.."_Up"):SetChecked(1);
		else
			getglobal(button.."_Up"):SetChecked(0);
		end
	end
	
	FauxScrollFrame_Update(DAB_KeybindingOptions_KeybindingBrowser, numOptions, 10, 50);
end

function DAB_KeybindingButton_OnClick(button, key)
	local index = this:GetParent().index;
	if (DAB_SELECTED_KEYBINDING) then
		if ( button == "LeftButton" or button == "RightButton" ) then
			if (DAB_SELECTED_KEYBINDING.index == index) then
				DAB_SELECTED_KEYBINDING.index = nil;
			else
				DAB_SELECTED_KEYBINDING.index = index;
				DAB_SELECTED_KEYBINDING.button = this;
				DAB_SELECTED_KEYBINDING.keyID = key;
			end
			DAB_KeybindingBrowser_Update();
			return;
		end
		DAB_KeyBindingFrame_OnKeyDown(button);
	else
		if (DAB_SELECTED_KEYBINDING.button) then
			DAB_SELECTED_KEYBINDING.button:UnlockHighlight();
		end
		DAB_SELECTED_KEYBINDING.index = index;
		DAB_SELECTED_KEYBINDING.button = this;
		DAB_SELECTED_KEYBINDING.keyID = key;
	end
end

function DAB_KeyBindingFrame_OnKeyDown(button)
	if ( not IsMacClient() ) then
		if ( arg1 == "PRINTSCREEN" ) then
			Screenshot();
			return;
		end
	end
	if ( button == "LeftButton" ) then
		button = "BUTTON1";
	elseif ( button == "RightButton" ) then
		button = "BUTTON2";
	elseif ( button == "MiddleButton" ) then
		button = "BUTTON3";
	elseif ( button == "Button4" ) then
		button = "BUTTON4"
	elseif ( button == "Button5" ) then
		button = "BUTTON5"
	end
	if (DAB_SELECTED_KEYBINDING.index) then
		local keybinding = "DAB_"..DAB_SELECTED_KEYBINDING.index;
		local keyPressed;
		if ( button ) then
			if ( button == "BUTTON1" or button == "BUTTON2" ) then
				return;
			end
			keyPressed = button;
		else
			keyPressed = arg1;
		end
		if ( keyPressed == "UNKNOWN" ) then
			return;
		end
		if ( keyPressed == "SHIFT" or keyPressed == "CTRL" or keyPressed == "ALT") then
			return;
		end
		if ( IsShiftKeyDown() ) then
			keyPressed = "SHIFT-"..keyPressed;
		end
		if ( IsControlKeyDown() ) then
			keyPressed = "CTRL-"..keyPressed;
		end
		if ( IsAltKeyDown() ) then
			keyPressed = "ALT-"..keyPressed;
		end
		local key1, key2 = GetBindingKey(keybinding);
		if ( key1 ) then
			SetBinding(key1);
		end
		if ( key2 ) then
			SetBinding(key2);
		end
		if ( DAB_SELECTED_KEYBINDING.keyID == 1 ) then
			DAB_SetBinding(keyPressed, keybinding, key1);
			if ( key2 ) then
				SetBinding(key2, keybinding);
			end
		else
			if ( key1 ) then
				DAB_SetBinding(key1, keybinding);
			end
			DAB_SetBinding(keyPressed, keybinding, key2);
		end
		DAB_Save_Keybindings();
		DAB_Update_Keybindings();
		DAB_KeybindingBrowser_Update();
		DAB_SELECTED_KEYBINDING.index = nil;
		DAB_SELECTED_KEYBINDING.button:UnlockHighlight();
	end
end

function DAB_Load_PresetBackdrop()
	local bgtexture, bordertexture, tile, tileSize, edgeSize, left, right, top, bottom = DL_Get_Backdrop(this.value);
	if (DAB_BAR_OPTIONS == "DAB_BarOptions_LabelTab") then
		DAB_Update_Setting("Label", bgtexture, "Label", "texture", nil, 1);
		DAB_Update_Setting("Label", bordertexture, "Label", "btexture", nil, 1);
		DAB_Update_Setting("Label", tile, "Label", "tile", nil, 1);
		DAB_Update_Setting("Label", tileSize, "Label", "tileSize", nil, 1);
		DAB_Update_Setting("Label", edgeSize, "Label", "edgeSize", nil, 1);
		DAB_Update_Setting("Label", left, "Label", "left", nil, 1);
		DAB_Update_Setting("Label", right, "Label", "right", nil, 1);
		DAB_Update_Setting("Label", top, "Label", "top", nil, 1);
		DAB_Update_Setting("Label", bottom, "Label", "bottom");
	else
		DAB_Update_Setting("Backdrop", bgtexture, "Background", "texture", nil, 1);
		DAB_Update_Setting("Backdrop", bordertexture, "Background", "btexture", nil, 1);
		DAB_Update_Setting("Backdrop", tile, "Background", "tile", nil, 1);
		DAB_Update_Setting("Backdrop", tileSize, "Background", "tileSize", nil, 1);
		DAB_Update_Setting("Backdrop", edgeSize, "Background", "edgeSize", nil, 1);
		DAB_Update_Setting("Backdrop", left, "Background", "left", nil, 1);
		DAB_Update_Setting("Backdrop", right, "Background", "right", nil, 1);
		DAB_Update_Setting("Backdrop", top, "Background", "top", nil, 1);
		DAB_Update_Setting("Backdrop", bottom, "Background", "bottom");
	end
	if (DAB_OBJECT_TYPE == "Bar") then
		DAB_Init_BarOptions();
	else
		DAB_Init_OtherBarOptions();
	end
	DAB_Update_TextureList();
end

function DAB_MenuEditBox_OnEnterPressed()
	this:ClearFocus();
	DAB_Update_Setting(this:GetParent().settingType, this:GetText(), this:GetParent().index, this:GetParent().subindex);
end

function DAB_Nudge(button, dragframe)
	local dir = this:GetID();
	local amt = 1;
	if (button == "RightButton") then
		amt = 10;
	elseif (button == "MiddleButton") then
		amt = 3;
	end
	local x = DAB_Get_Setting("Anchor", "x");
	local y = DAB_Get_Setting("Anchor", "y");
	if (dir == 1) then
		getglobal(this.updateFrame):SetText(y + amt);
		DAB_Update_Setting("Location", y + amt, "Anchor", "y");
	elseif (dir == 2) then
		getglobal(this.updateFrame):SetText(y - amt);
		DAB_Update_Setting("Location", y - amt, "Anchor", "y");
	elseif (dir == 3) then
		getglobal(this.updateFrame):SetText(x - amt);
		DAB_Update_Setting("Location", x - amt, "Anchor", "x");
	elseif (dir == 4) then
		getglobal(this.updateFrame):SetText(x + amt);
		DAB_Update_Setting("Location", x + amt, "Anchor", "x");
	end
end

function DAB_Nudge_OnUpdate(elapsed, dragframe)
	if (not this.timer) then
		this.timer = 1 / 30;
	end
	if (this.movingframe) then
		this.timer = this.timer - elapsed;
		if (this.timer < 0) then
			this.timer = 1 / 30;
			DAB_Nudge("MiddleButton");
		end
	end
end

function DAB_NumButtons_OnMouseWheel()
	if (arg1 < 0) then
		DAB_Remove_ButtonOrPage(this:GetID());
	elseif (arg1 > 0) then
		DAB_Add_ButtonOrPage(this:GetID());
	end
end

function DAB_NumButtons_SetWarning(num)
	local warning = string.gsub(DAB_TEXT.Warning, "$n", num);
	DAB_NumButtons_Warning:SetText(warning);
	DAB_NumButtons_Warning:SetTextColor(1, 1, 0, 1);
	DAB_NumButtons.timer = 3;
end

function DAB_NumButtons_WarningTimeOut(elapsed)
	if (not this.timer) then return; end
	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = nil;
		DAB_NumButtons_Warning:SetText("");
	elseif (this.timer < .5) then
		DAB_NumButtons_Warning:SetTextColor(1, 1, 0, this.timer * 2);
	end
end

function DAB_Options_OnShow()
	 DAB_Update_FloaterList();
	 DAB_Update_ObjectList();
	 DAB_BarBrowser_Update();
end

function DAB_OtherBarOptions_OnMouseWheel(direction)
	if (direction > 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX - 1;
	elseif (direction < 0) then
		DAB_OBJECT_INDEX = DAB_OBJECT_INDEX + 1;
	end
	if (DAB_OBJECT_INDEX > 16) then
		DAB_OBJECT_INDEX = 13;
	elseif (DAB_OBJECT_INDEX < 13) then
		DAB_OBJECT_INDEX = 16;
	end
	DAB_OBJECT_SUBINDEX = DAB_BAR_LIST[DAB_OBJECT_INDEX].value;
	DAB_Init_OtherBarOptions();
	DAB_BarBrowser_Update();
end

function DAB_Paste_ControlSettings()
	if (not DAB_CONTROL_BUFFER) then return; end
	if (DAB_BarOptions_ButtonControl:IsVisible()) then
		local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
		local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
		local bar = DAB_OBJECT_SUBINDEX;
		DL_Copy_Table(DAB_CONTROL_BUFFER, DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button]);
	elseif (DAB_OBJECT_TYPE == "Bar") then
		DL_Copy_Table(DAB_CONTROL_BUFFER, DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions);
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		DL_Copy_Table(DAB_CONTROL_BUFFER, DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions);
	end
	DAB_ConditionMenu_Update();
end

function DAB_Paste_Settings()
	if (DAB_BUFFER_TYPE ~= DAB_OBJECT_TYPE) then return; end
	local initType;
	local oldSettings = {};
	if (DAB_OBJECT_TYPE == "Bar") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX], oldSettings);
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX] = {};
		DL_Copy_Table(DAB_BUFFER, DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX]);
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].numBars = oldSettings.numBars;
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].numButtons = oldSettings.numButtons;
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].page = oldSettings.page;
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].middleClick = oldSettings.middleClick;
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].rightClick = oldSettings.rightClick;
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].rows = oldSettings.rows;
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Label.text = oldSettings.Label.text;
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Anchor = {
				frame = oldSettings.Anchor.frame,
				to = oldSettings.Anchor.to,
				point = oldSettings.Anchor.point,
				x = oldSettings.Anchor.x,
				y = oldSettings.Anchor.y
			};
		DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Scripts = {};
		DL_Copy_Table(oldSettings.Scripts, DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Scripts);
		DAB_Init_BarOptions();
		DAB_Bar_Location(DAB_OBJECT_SUBINDEX);
		DAB_Bar_Initialize(DAB_OBJECT_SUBINDEX);
		DAB_Bar_Label(DAB_OBJECT_SUBINDEX);
		DAB_Bar_Backdrop(DAB_OBJECT_SUBINDEX);
		DAB_Bar_ButtonTextures(DAB_OBJECT_SUBINDEX);
		DAB_Bar_ButtonText(DAB_OBJECT_SUBINDEX);
		DAB_Bar_ButtonSize(DAB_OBJECT_SUBINDEX);
		DAB_Bar_ButtonAlpha(DAB_OBJECT_SUBINDEX);
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX], oldSettings);
		DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX] = {};
		DL_Copy_Table(DAB_BUFFER, DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX]);
		DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX].middleClick = oldSettings.middleClick;
		DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX].rightClick = oldSettings.rightClick;
		DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX].Anchor = {
				frame = oldSettings.Anchor.frame,
				to = oldSettings.Anchor.to,
				point = oldSettings.Anchor.point,
				x = oldSettings.Anchor.x,
				y = oldSettings.Anchor.y
			};
		DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX].Scripts = {};
		DL_Copy_Table(oldSettings.Scripts, DAB_Settings[DAB_INDEX].Floaters[DAB_OBJECT_SUBINDEX].Scripts);
		DAB_Floater_Initialize(DAB_OBJECT_SUBINDEX);
		DAB_Init_FloaterOptions();
	elseif (DAB_OBJECT_TYPE == "ControlBox") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX], oldSettings);
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX] = {};
		DL_Copy_Table(DAB_BUFFER, DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX]);
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].Anchor = {};
		DL_Copy_Table(oldSettings.Anchor, DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].Anchor);
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].group = oldSettings.group;
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].rcgroup = oldSettings.rcgroup;
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].mcgroup = oldSettings.mcgroup;
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].text = oldSettings.text;
		DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].Scripts = {};
		DL_Copy_Table(oldSettings.Scripts, DAB_Settings[DAB_INDEX].ControlBox[DAB_OBJECT_SUBINDEX].Scripts);
		DAB_ControlBox_Initialize(DAB_OBJECT_SUBINDEX);
		DAB_Init_ControlBoxOptions();
	elseif (DAB_OBJECT_TYPE == "OtherBar") then
		DL_Copy_Table(DAB_Settings[DAB_INDEX].OtherBar[DAB_OBJECT_SUBINDEX], oldSettings);
		DAB_Settings[DAB_INDEX].OtherBar[DAB_OBJECT_SUBINDEX] = {};
		DL_Copy_Table(DAB_BUFFER, DAB_Settings[DAB_INDEX].OtherBar[DAB_OBJECT_SUBINDEX]);
		DAB_Settings[DAB_INDEX].OtherBar[DAB_OBJECT_SUBINDEX].Anchor = {};
		DL_Copy_Table(oldSettings.Anchor, DAB_Settings[DAB_INDEX].OtherBar[DAB_OBJECT_SUBINDEX].Anchor);
		DAB_OtherBar_Initialize(DAB_OBJECT_SUBINDEX);
		DAB_Init_OtherBarOptions();
	end
end

function DAB_Remove_ButtonOrPage(id)
	if (not id) then
		id = this:GetParent():GetID();
	end
	if (id < 11) then
		if (DAB_Settings[DAB_INDEX].Bar[id].numButtons == 0) then return; end
		local button;
		for i=1, 120 do
			if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == id) then
				button = i;
			end
		end
		DAB_Settings[DAB_INDEX].Buttons[button] = {Conditions={}, Scripts={}, action=button};
		getglobal("DAB_FloaterBox_"..button):ClearAllPoints();
		getglobal("DAB_FloaterBox_"..button):SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		DAB_Settings[DAB_INDEX].FreeButtons[table.getn(DAB_Settings[DAB_INDEX].FreeButtons) + 1] = button;
		for page=1, DAB_Settings[DAB_INDEX].Bar[id].numBars do
			DAB_Settings[DAB_INDEX].Bar[id].pages[page][DAB_Settings[DAB_INDEX].Bar[id].numButtons] = nil;
			DAB_Settings[DAB_INDEX].Bar[id].pageconditions[page][DAB_Settings[DAB_INDEX].Bar[id].numButtons] = nil;
		end
		DAB_Settings[DAB_INDEX].Bar[id].numButtons = DAB_Settings[DAB_INDEX].Bar[id].numButtons - 1;
	else
		id = id - 10;
		if (DAB_Settings[DAB_INDEX].Bar[id].numBars == 1) then return; end
		local p = DAB_Settings[DAB_INDEX].Bar[id].numBars;
		DAB_Settings[DAB_INDEX].Bar[id].pages[p] = nil;
		DAB_Settings[DAB_INDEX].Bar[id].pageconditions[p] = nil;
		getglobal("DAB_ActionBar_"..id).pagemap[DAB_Settings[DAB_INDEX].Bar[id].numBars] = nil;
		DAB_Settings[DAB_INDEX].Bar[id].numBars = DAB_Settings[DAB_INDEX].Bar[id].numBars - 1;
		if (DAB_Settings[DAB_INDEX].Bar[id].page > DAB_Settings[DAB_INDEX].Bar[id].numBars) then
			DAB_Settings[DAB_INDEX].Bar[id].page = DAB_Settings[DAB_INDEX].Bar[id].numBars;
		end
		DAB_Bar_SetPage(id, 1, 1);
	end
	if (DAB_Settings[DAB_INDEX].Bar[id].rows > DAB_Settings[DAB_INDEX].Bar[id].numButtons) then
		DAB_Settings[DAB_INDEX].Bar[id].rows = DAB_Settings[DAB_INDEX].Bar[id].numButtons;
		if (DAB_Settings[DAB_INDEX].Bar[id].rows == 0) then
			DAB_Settings[DAB_INDEX].Bar[id].rows = 1;
		end
	end
	DAB_Init_ButtonLayout();
	DAB_Bar_Initialize(id);
	if (DAB_Settings[DAB_INDEX].AutoConfigureKB) then
		DAB_AutoConfigure_Keybindings();
	end
	DAB_Update_Keybindings();
end

function DAB_Remove_Floater(id)
	if (not id) then
		id = this.value;
	end
	DAB_Settings[DAB_INDEX].Floaters[id] = nil;
	DAB_Settings[DAB_INDEX].FreeButtons[table.getn(DAB_Settings[DAB_INDEX].FreeButtons) + 1] = id;
	DAB_Settings[DAB_INDEX].Buttons[id] = {Conditions={}, Scripts={}, action=id};
	getglobal("DAB_FloaterBox_"..id):ClearAllPoints();
	getglobal("DAB_FloaterBox_"..id):SetPoint("CENTER", UIParent, "CENTER", 0, 0);
	DAB_Init_ButtonLayout();
	DAB_Update_ObjectList();
	DAB_Update_FloaterList();
	DAB_Update_AnchorsList();
	DAB_BarBrowser_Update();
	if (DAB_Settings[DAB_INDEX].AutoConfigureKB) then
		DAB_AutoConfigure_Keybindings();
	end
	DAB_Update_Keybindings();
end

function DAB_Reset_Parameters(options, toggle)
	if (not toggle) then
		getglobal(options.."_ActionID"):Hide();
		getglobal(options.."_ActionID_Setting"):SetText("");
		getglobal(options.."_Bars"):Hide();
		getglobal(options.."_Bars_Setting"):SetText("");
		getglobal(options.."_IgnoreGlobal"):Hide();
		getglobal(options.."_IgnoreGlobal"):SetChecked(0);
		getglobal(options.."_Unit"):Hide();
		getglobal(options.."_Unit_Setting"):SetText("");
		getglobal(options.."_Unit2"):Hide();
		getglobal(options.."_Unit2_Setting"):SetText("");
		getglobal(options.."_Buff"):Hide();
		getglobal(options.."_Buff"):SetText("");
		getglobal(options.."_Comparison"):Hide();
		getglobal(options.."_Comparison_Setting"):SetText("");
		getglobal(options.."_Number"):Hide();
		getglobal(options.."_Number"):SetText("");
		getglobal(options.."_Text"):Hide();
		getglobal(options.."_Text"):SetText("");
		getglobal(options.."_Forms"):Hide();
		getglobal(options.."_Forms_Setting"):SetText("");
		getglobal(options.."_Targets"):Hide();
		getglobal(options.."_Targets_Setting"):SetText("");
	end
	if (DAB_OBJECT_TYPE == "Bar") then
		getglobal(options.."_Page"):Hide();
		getglobal(options.."_Page_Setting"):SetText("");
		if (getglobal(options.."_Page2")) then
			getglobal(options.."_Page2"):Hide();
			getglobal(options.."_Page2_Setting"):SetText("");
		end
	end
	getglobal(options.."_Alpha"):Hide();
	getglobal(options.."_Alpha_Display"):SetText("");
	getglobal(options.."_Color"):Hide();
	getglobal(options.."_Amount"):Hide();
	getglobal(options.."_Amount_Display"):SetText("");
	getglobal(options.."_ResponseNumber"):Hide();
	getglobal(options.."_ResponseNumber"):SetText("");
	getglobal(options.."_ResponseText"):Hide();
	getglobal(options.."_ResponseText"):SetText("");
	getglobal(options.."_ResponseUnit"):Hide();
	getglobal(options.."_ResponseUnit_Setting"):SetText("");
	if (getglobal(options.."_ResponseActionID")) then
		getglobal(options.."_ResponseActionID"):Hide();
		getglobal(options.."_ResponseActionID_Setting"):SetText("");
	end
	if (getglobal(options.."_ResponseX")) then
		getglobal(options.."_ResponseX"):Hide();
		getglobal(options.."_ResponseX"):SetText("");
		getglobal(options.."_ResponseY"):Hide();
		getglobal(options.."_ResponseY"):SetText("");
	end
end

function DAB_Scripts_Compile()
	DAB_Compile_Scripts(DAB_OBJECT_TYPE, DAB_OBJECT_SUBINDEX);
end

function DAB_Scripts_Update()
	if (DAB_CURRENT_SCRIPT) then
		DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX].Scripts[DAB_CURRENT_SCRIPT] = DAB_ScriptOptions_EditBox_Text:GetText();
		DAB_Update_ScriptsList();
	end
end

function DAB_ScrollMenu_OnClick()
	this:GetParent():Hide();
	local text = "";
	local list = getglobal(DAB_ScrollMenu.table);
	for _, value in list do
		if (value.value == this.value) then
			text = value.text;
		end
	end
	getglobal(DAB_ScrollMenu.controlbox):SetText(text);
	if (DAB_ScrollMenu.initFunc) then
		DAB_ScrollMenu.initFunc();
	else
		DAB_Update_Setting(DAB_ScrollMenu.settingType, this.value, DAB_ScrollMenu.index, DAB_ScrollMenu.subindex, DAB_ScrollMenu.subindex2);
	end
end

function DAB_ScrollMenu_Update()
	local list = getglobal(this:GetParent().table);
	if (not list) then return; end
	local numOptions = table.getn(list);
	local offset = FauxScrollFrame_GetOffset(DAB_ScrollMenu_ScrollFrame);
	if (not offset) then offset = 0; end
	local index, button;
	
	for i=1, 10 do
		button = getglobal("DAB_ScrollMenu_Button"..i);
		buttontext = getglobal("DAB_ScrollMenu_Button"..i.."Text");
		index = offset + i;
		if ( list[index] ) then
			buttontext:SetText(list[index].text);
			button:Show();
			button:SetChecked(0);
			button.value = list[index].value;
			button.desc = list[index].desc;
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DAB_ScrollMenu_ScrollFrame, numOptions, 10, 20 );
end

function DAB_Select_BarButton()
	DAB_SELECTED_BARBUTTON = this.index;
	DAB_BarButtonsMenu_Update();
	DAB_ConditionMenu_Update();
end

function DAB_Select_BarOptions(index)
	DAB_BarOptions_BarAppearance:Hide();
	DAB_BarOptions_ButtonAppearance:Hide();
	DAB_BarOptions_BarControl:Hide();
	DAB_BarOptions_Label:Hide();
	DAB_ScriptOptions:Hide();
	DAB_BarOptions_ButtonControl:Hide();
	if (index == 1) then
		DAB_BarOptions_BarAppearance:Show();
	elseif (index == 2) then
		DAB_BarOptions_BarControl:Show();
		DAB_ConditionMenu_Update();
	elseif (index == 3) then
		DAB_BarOptions_ButtonAppearance:Show();
	elseif (index == 4) then
		DAB_BarOptions_ButtonControl:Show();
		DAB_BarButtonsMenu_Update();
		DAB_ConditionMenu_Update();
	elseif (index == 5) then
		DAB_BarOptions_Label:Show();
	elseif (index == 6) then
		DAB_ScriptOptions:Show();
		DAB_Update_ScriptsList();
	end
end

function DAB_Select_ButtonLayoutOptions(index)
	DAB_NumButtons:Hide();
	DAB_SetActionIDs:Hide();
	if (index == 1) then
		DAB_NumButtons:Show();
	else
		DAB_SetActionIDs:Show();
		DAB_Update_ActionIDsList();
	end
end

function DAB_Select_CboxOptions(index)
	DAB_CBoxOptions_Config:Hide();
	DAB_CBoxOptions_Control:Hide();
	DAB_ScriptOptions:Hide();
	if (index == 1) then
		DAB_CBoxOptions_Config:Show();
	elseif (index == 2) then
		DAB_CBoxOptions_Control:Show();
	elseif (index == 3) then
		DAB_ScriptOptions:Show();
		DAB_Update_ScriptsList();
	end
end

function DAB_Select_Condition(condition, menucontrol)
	if (not condition) then
		DAB_CONDITION_EDITTING = nil;
		condition = this.value;
		DAB_CONDITION_BUFFER = { condition = condition };
	else
		DAB_CONDITION_EDITTING = condition;
		DAB_CONDITION_BUFFER = {};
		if (DAB_BarOptions_ButtonControl:IsVisible()) then
			local page = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].page;
			local button = DAB_BAR_BUTTONS[DAB_SELECTED_BARBUTTON].button;
			local bar = DAB_OBJECT_SUBINDEX;
			DL_Copy_Table(DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button][condition], DAB_CONDITION_BUFFER);
			DL_Init_MenuControl(DAB_BarOptions_ButtonControl_Condition, DAB_CONDITION_BUFFER.condition);
			DAB_CONDITION_BUFFER.overrides = "";
			for i,o in DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button][condition].overrides do
				if (i == table.getn(DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][button][condition].overrides)) then
					DAB_CONDITION_BUFFER.overrides = DAB_CONDITION_BUFFER.overrides..o;
				else
					DAB_CONDITION_BUFFER.overrides = DAB_CONDITION_BUFFER.overrides..o..", ";
				end
				DAB_BarOptions_ButtonControl_Overrides:SetText(DAB_CONDITION_BUFFER.overrides);
			end
		elseif (DAB_OBJECT_TYPE == "Bar") then
			DL_Copy_Table(DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions[condition], DAB_CONDITION_BUFFER);
			DL_Init_MenuControl(DAB_BarOptions_BarControl_Condition, DAB_CONDITION_BUFFER.condition);
			DAB_CONDITION_BUFFER.overrides = "";
			for i,o in DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions[condition].overrides do
				if (i == table.getn(DAB_Settings[DAB_INDEX].Bar[DAB_OBJECT_SUBINDEX].Conditions[condition].overrides)) then
					DAB_CONDITION_BUFFER.overrides = DAB_CONDITION_BUFFER.overrides..o;
				else
					DAB_CONDITION_BUFFER.overrides = DAB_CONDITION_BUFFER.overrides..o..", ";
				end
				DAB_BarOptions_BarControl_Overrides:SetText(DAB_CONDITION_BUFFER.overrides);
			end
		elseif (DAB_OBJECT_TYPE == "Floaters") then
			DL_Copy_Table(DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions[condition], DAB_CONDITION_BUFFER);
			DL_Init_MenuControl(DAB_FloaterOptions_Control_Condition, DAB_CONDITION_BUFFER.condition);
			DAB_CONDITION_BUFFER.overrides = "";
			for i,o in DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions[condition].overrides do
				if (i == table.getn(DAB_Settings[DAB_INDEX].Buttons[DAB_OBJECT_SUBINDEX].Conditions[condition].overrides)) then
					DAB_CONDITION_BUFFER.overrides = DAB_CONDITION_BUFFER.overrides..o;
				else
					DAB_CONDITION_BUFFER.overrides = DAB_CONDITION_BUFFER.overrides..o..", ";
				end
				DAB_FloaterOptions_Control_Overrides:SetText(DAB_CONDITION_BUFFER.overrides);
			end
		end
		condition = DAB_CONDITION_BUFFER.condition;
	end
	if (not menucontrol) then menucontrol = DAB_ScrollMenu.cboxbase; end
	local options = getglobal(menucontrol):GetParent():GetName();
	DAB_Reset_Parameters(options);
	local conditionsIndex;
	for index, value in DL_CONDITIONS_MENU do
		if (value.value == condition) then
			conditionsIndex = index;
			break;
		end
	end
	local params = DL_CONDITIONS_MENU[conditionsIndex].params;
	if (params == 1) then
		DAB_Show_Parameters({"_ActionID", "_IgnoreGlobal"}, {1, 2}, options);
	elseif (params == 2) then
		DAB_Show_Parameters({"_ActionID"}, {1}, options);
	elseif (params == 3) then
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.unit = "player";
		end
		DAB_Show_Parameters({"_Unit", "_Buff"}, {1, 3}, options);
	elseif (params == 4) then
		DL_Set_Anchor("_ConditionMenu", 0, -50, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_ConditionMenu", 0, -75, nil, nil, nil, getglobal(options.."_Number"));
		DAB_Show_Parameters({"_Comparison", "_Number"}, {1, 3}, options);
	elseif (params == 5) then
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.unit = "player";
		end
		DAB_Show_Parameters({"_Unit", "_Text"}, {1, 3}, options);
	elseif (params == 6) then
		DL_Set_Anchor("_ConditionMenu", 0, -100, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_Comparison", 5, 0, "LEFT", "RIGHT", nil, getglobal(options.."_Number"));
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.unit = "player";
		end
		DAB_Show_Parameters({"_Unit", "_Text", "_Comparison", "_Number"}, {1, 3, 1, 3}, options);
	elseif (params == 7) then
		DL_Set_Anchor("_ConditionMenu", 0, -75, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_ConditionMenu", 0, -100, nil, nil, nil, getglobal(options.."_Number"));
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.unit = "player";
		end
		DAB_Show_Parameters({"_Unit", "_Comparison", "_Number"}, {1, 1, 3}, options);
	elseif (params == 8) then
		DAB_Show_Parameters({"_Forms"}, {1}, options);
	elseif (params == 9) then
		DAB_Show_Parameters({"_Targets"}, {1}, options);
	elseif (params == 10) then
		DL_Set_Anchor("_ConditionMenu", 0, -50, nil, nil, nil, getglobal(options.."_Number"));
		DAB_Show_Parameters({"_Number"}, {3}, options);
	elseif (params == 11) then
		DL_Set_Anchor("_ConditionMenu", 0, -75, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_ConditionMenu", 0, -100, nil, nil, nil, getglobal(options.."_Number"));
		DAB_Show_Parameters({"_ActionID", "_Comparison", "_Number"}, {1, 1, 3}, options);
	elseif (params == 12) then
		DAB_Show_Parameters({"_Text"}, {3}, options);
	elseif (params == 13) then
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.unit = "player";
		end
		DAB_Show_Parameters({"_Unit"}, {1}, options);
	elseif (params == 14) then
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.unit = "player";
			DAB_CONDITION_BUFFER.unit2 = "player";
		end
		DAB_Show_Parameters({"_Unit", "_Unit2"}, {1, 1}, options);
	elseif (params == 200) then
		DL_Set_Anchor("_ConditionMenu", 0, -75, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_ConditionMenu", 0, -100, nil, nil, nil, getglobal(options.."_Number"));
		DAB_Show_Parameters({"_Bars", "_Comparison", "_Number"}, {1, 1, 3}, options);
	end
end

function DAB_Select_Event()
	DAB_MACRO_EVENT = this.value;
	local desc = "";
	for _,v in DAB_EVENTS do
		if (v.value == DAB_MACRO_EVENT) then
			desc = v.desc;
			break;
		end
	end
	DAB_OnEventMacros_Description:SetText(desc);
	if (DAB_Settings[DAB_INDEX].EventMacros[DAB_MACRO_EVENT]) then
		DAB_OnEventMacros_EditBox_Text:SetText(DAB_Settings[DAB_INDEX].EventMacros[DAB_MACRO_EVENT]);
	else
		DAB_OnEventMacros_EditBox_Text:SetText("");
	end
end

function DAB_Select_FloaterOptions(index)
	DAB_FloaterOptions_Config:Hide();
	DAB_FloaterOptions_AdvConfig:Hide();
	DAB_FloaterOptions_Control:Hide();
	DAB_ScriptOptions:Hide();
	if (index == 1) then
		DAB_FloaterOptions_Config:Show();
	elseif (index == 2) then
		DAB_FloaterOptions_AdvConfig:Show();
	elseif (index == 3) then
		DAB_FloaterOptions_Control:Show();
	elseif (index == 4) then
		DAB_ScriptOptions:Show();
		DAB_Update_ScriptsList();
	end
end

function DAB_Select_Response(response, menucontrol)
	if (not DAB_CONDITION_BUFFER) then return; end
	if (not menucontrol) then menucontrol = DAB_ScrollMenu.cboxbase; end
	local options = getglobal(menucontrol):GetParent():GetName();
	if (not response) then
		response = this.value;
		DAB_CONDITION_BUFFER.response = response;
	else
		response = DAB_CONDITION_BUFFER.response;
		DL_Init_MenuControl(getglobal(options.."_Response"), response);
	end
	DAB_Reset_Parameters(options, 1);
	if (response == 1) then
		DAB_Show_Parameters({"_Page"}, {1}, options);
	elseif (response == 4 or response == 5 or response == 7) then
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.alpha = 1;
			DL_Init_Slider(getglobal(options.."_Alpha"), 1);
		end
		DAB_Show_Parameters({"_Alpha"}, {4}, options);
	elseif (response == 6 or response == 8 or response == 20 or response == 22) then
		if (response ~= 22 or (not DAB_BarOptions_BarControl:IsShown())) then
			DAB_CONDITION_BUFFER.color = {r=1, g=1, b=1};
			DL_Init_ColorPicker(getglobal(options.."_Color"), DAB_CONDITION_BUFFER.color);
			DAB_Show_Parameters({"_Color"}, {5}, options);
		end
	elseif (response == 10) then
		DAB_Show_Parameters({"_ResponseNumber"}, {3}, options);
	elseif (response == 19 or (response > 10 and response < 19)) then
		if (not DAB_CONDITION_EDITTING) then
			DAB_CONDITION_BUFFER.amount = 50;
			DL_Init_Slider(getglobal(options.."_Amount"), 50);
		end
		DAB_Show_Parameters({"_Amount"}, {4}, options);
	elseif (response == 100 or response == 101 or response == 108 or response == 109 or response == 114 or response == 115) then
		DAB_Show_Parameters({"_ResponseText"}, {3}, options);
	elseif (response == 23 or (response > 101 and response < 108)) then
		DAB_Show_Parameters({"_ResponseNumber"}, {3}, options);
	elseif (response == 29 or response == 111) then
		DAB_Show_Parameters({"_ResponseActionID"}, {1}, options);
	elseif (response == 32) then
		DAB_Show_Parameters({"_Page", "_Page2"}, {1, 1}, options);
	elseif (response == 33) then
		DAB_Show_Parameters({"_ResponseUnit"}, {1}, options);
	elseif (response == 35) then
		DAB_Show_Parameters({"_ResponseX", "_ResponseY"}, {3,3}, options);
	elseif (response == 110) then
		DAB_Show_Parameters({"_ResponseActionID", "_ResponseUnit"}, {1,1}, options);
	elseif (response == 113) then
		DAB_Show_Parameters({"_ResponseNumber", "_ResponseText"}, {3,3}, options);
	end
end

function DAB_Select_Script(value)
	if (not value) then
		value = this.value;
	end
	DAB_CURRENT_SCRIPT = value;
	local desc = "";
	for _,v in DAB_SCRIPTS do
		if (v.value == DAB_CURRENT_SCRIPT) then
			desc = v.desc;
			break;
		end
	end
	DAB_ScriptOptions_Description:SetText(desc);
	local text = DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX].Scripts[DAB_CURRENT_SCRIPT];
	if (text) then
		DAB_ScriptOptions_EditBox_Text:SetText(text);
	else
		DAB_ScriptOptions_EditBox_Text:SetText("");
	end
end

function DAB_Set_OptionsScale(override)
	if (override) then
		DAB_Settings[DAB_INDEX].optionsScale = override;
	else
		DAB_Settings[DAB_INDEX].optionsScale = this.value;
	end
	DAB_Options:SetScale(DAB_Settings[DAB_INDEX].optionsScale / 100);
	DAB_Options:ClearAllPoints();
	DAB_Options:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
end

function DAB_SetActionIDsMenu_Update()
	local numOptions = table.getn(DAB_ACTIONIDS_LIST);
	local offset = FauxScrollFrame_GetOffset(DAB_SetActionIDs_ScrollMenu);
	if (not offset) then offset = 0; end
	local index, button, buttontext, menucontrol;
	
	for i=1, 19 do
		button = getglobal("DAB_SetActionIDs_ScrollMenu_Button"..i);
		buttontext = getglobal("DAB_SetActionIDs_ScrollMenu_Button"..i.."_Text");
		menucontrol = getglobal("DAB_SetActionIDs_ScrollMenu_Button"..i.."_ActionMenu");
		index = offset + i;
		if ( DAB_ACTIONIDS_LIST[index] ) then
			button:Show();
			menucontrol.subindex = DAB_ACTIONIDS_LIST[index].bar;
			if (DAB_ACTIONIDS_LIST[index].bar == "F") then
				buttontext:SetText("Floater "..DAB_ACTIONIDS_LIST[index].button);
				menucontrol.subindex2 = DAB_ACTIONIDS_LIST[index].button;
			else
				buttontext:SetText("Bar "..DAB_ACTIONIDS_LIST[index].bar..", Page "..DAB_ACTIONIDS_LIST[index].page..", Button "..DAB_ACTIONIDS_LIST[index].button);
				menucontrol.subindex2 = index;
			end
			DL_Init_MenuControl(menucontrol, DAB_ACTIONIDS_LIST[index].action);
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DAB_SetActionIDs_ScrollMenu, numOptions, 19, 25 );
	DAB_SetActionIDs_ScrollMenu:Show();
end

function DAB_SetBinding(key, selectedBinding, oldKey)
	if ( SetBinding(key, selectedBinding) ) then
		return;
	else
		if ( oldKey ) then
			SetBinding(oldKey, selectedBinding);
		end
		DL_Error("Can't bind mousewheel to actions with up and down states");
	end
end

function DAB_Show_Parameters(parameters, types, base)
	for i, param in parameters do
		local frame = getglobal(base..param);
		frame:Show();
		if (DAB_CONDITION_EDITTING) then
			if (types[i] == 1) then
				DL_Init_MenuControl(frame, DAB_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 2) then
				DL_Init_CheckBox(frame, DAB_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 3) then
				DL_Init_EditBox(frame, DAB_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 4) then
				if (not DAB_CONDITION_BUFFER[frame.subindex]) then
					local min, max = frame:GetMinMaxValues();
					if (frame.scale) then
						max = max / frame.scale;
					end
					DAB_CONDITION_BUFFER[frame.subindex] = max;
				end
				DL_Init_Slider(frame, DAB_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 5) then
				if (not DAB_CONDITION_BUFFER[frame.subindex]) then
					DAB_CONDITION_BUFFER[frame.subindex] = {r=1, g=1, b=1};
				end
				DL_Init_ColorPicker(frame, DAB_CONDITION_BUFFER[frame.subindex]);
			end
		elseif (param == "_Unit" or param == "_Unit2") then
			DL_Init_MenuControl(frame, "player");
		end
	end
end

function DAB_Show_Window(index)
	DAB_HideAllOptions();

	DAB_OBJECT_INDEX = index;
	if (index < 12) then
		DAB_OBJECT_TYPE = "Bar";
	elseif (index > 12 and index < 17) then
		DAB_OBJECT_TYPE = "OtherBar";
	elseif (index < 28) then
		DAB_OBJECT_TYPE = "ControlBox";
	else
		DAB_OBJECT_TYPE = "Floaters";
	end
	DAB_OBJECT_SUBINDEX = DAB_BAR_LIST[index].value;

	if (DAB_OBJECT_TYPE == "Bar") then
		DAB_BarOptions:Show();
		DAB_Init_BarOptions();
		if (DAB_BAR_OPTIONS == "DAB_BarOptions_ScriptsTab") then
			DAB_ScriptOptions:Show();
			DAB_Update_ScriptsList();
		end
	elseif (DAB_OBJECT_TYPE == "Floaters") then
		DAB_FloaterOptions:Show();
		DAB_Init_FloaterOptions();
		if (DAB_FLOATER_OPTIONS == "DAB_FloaterOptions_ScriptsTab") then
			DAB_ScriptOptions:Show();
			DAB_Update_ScriptsList();
		end
	elseif (DAB_OBJECT_TYPE == "ControlBox") then
		DAB_CBoxOptions:Show();
		DAB_Init_ControlBoxOptions();
		if (DAB_CBOX_OPTIONS == "DAB_CBoxOptions_ScriptsTab") then
			DAB_ScriptOptions:Show();
			DAB_Update_ScriptsList();
		end
	elseif (DAB_OBJECT_TYPE == "OtherBar") then
		DAB_OtherBarOptions:Show();
		DAB_Init_OtherBarOptions();
	end
end

function DAB_Slider_Update()
	if (not DAB_INITIALIZED) then return; end
	if (not this.minmaxset) then return; end
	local setting = DAB_Get_Setting(this.index, this.subindex);
	if (this.scale) then
		setting = setting * this.scale;
	end
	if (setting == this:GetValue()) then return; end
	local min, max = this:GetMinMaxValues();
	if (setting < min or setting > max) then
		return;
	end
	local value = this:GetValue();
	getglobal(this:GetName().."_Display"):SetText(value);
	if (this.scale) then
		value = value / this.scale;
	end
	DAB_Update_Setting(this.settingType, value, this.index, this.subindex, this.subindex2);
end

function DAB_Slider_UpdateFromEditBox()
	local value = this:GetNumber();
	if (not value) then value = 0; end
	local min, max = this:GetParent():GetMinMaxValues();
	if (this:GetParent().minlocked and value < min) then value = min; end
	if (this:GetParent().maxlocked and value > max) then value = max; end
	this:SetText(value);
	if (value >= min and value <= max) then
		this:GetParent():SetValue(value);
	end
	this:ClearFocus();
	if (this:GetParent().scale) then
		value = value / this:GetParent().scale;
	end
	DAB_Update_Setting(this:GetParent().settingType, value, this:GetParent().index, this:GetParent().subindex);
end

function DAB_TextureEditBox_OnEnterPressed()
	DAB_MenuEditBox_OnEnterPressed();
	DAB_Update_TextureList();
end

function DAB_UnitEditBox_OnEnterPressed()
	DAB_MenuEditBox_OnEnterPressed();
	DAB_Update_UnitList();
end

function DAB_Update_ActionIDsList()
	DAB_ACTIONIDS_LIST = {};
	local index = 0;
	if (DAB_ACTIONIDS_FILTER1 ~= 2) then
		for bar = 1, DAB_NUM_BARS do
			if (DAB_ACTIONIDS_FILTER1 == 1 or bar == DAB_ACTIONIDS_FILTER1 - 2) then
				for page = 1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
					if (DAB_ACTIONIDS_FILTER2 == 1 or page == DAB_ACTIONIDS_FILTER2 - 1) then
						for button = 1, DAB_Settings[DAB_INDEX].Bar[bar].numButtons do
							index = index + 1;
							DAB_ACTIONIDS_LIST[index] = {bar = bar, page = page, button = button, action = DAB_Settings[DAB_INDEX].Bar[bar].pages[page][button]};
						end
					end
				end
			end
		end
	end
	if (DAB_ACTIONIDS_FILTER1 < 3) then
		for i=1,DAB_NUM_BUTTONS do
			if (DAB_Settings[DAB_INDEX].Floaters[i]) then
				index = index + 1;
				DAB_ACTIONIDS_LIST[index] = {bar = "F", button = i, action = DAB_Settings[DAB_INDEX].Buttons[i].action};
			end
		end
	end
	DAB_SetActionIDsMenu_Update();
end

function DAB_Update_ScriptsList()
	for index, val in DAB_SCRIPTS do
		if (DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX].Scripts[val.value] and DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX].Scripts[val.value] ~= "") then
			if (string.sub(DAB_SCRIPTS[index].text, -2) ~= " *") then
				DAB_SCRIPTS[index].text = DAB_SCRIPTS[index].text.." *";
			end
		elseif (string.sub(DAB_SCRIPTS[index].text, -2) == " *") then
			DAB_SCRIPTS[index].text = string.sub(DAB_SCRIPTS[index].text, 1, -2);
		end
	end
end

function DAB_Update_Setting(settingType, value, index, subindex, subindex2, override)
	if (subindex == "font") then
		if (not string.find(value, "\\")) then
			value = DAB_Settings[DAB_INDEX].defaultFont..value;
		end
	end
	if ((index and string.find(index, "texture")) or (subindex and string.find(subindex, "texture"))) then
		if (not string.find(value, "\\")) then
			value = DAB_Settings[DAB_INDEX].defaultTexture..value;
		end
	end
	if (index == "Misc") then
		if (subindex == "UpdateSpeed") then
			DAB_Settings[DAB_INDEX].UpdateSpeed = value;
			DAB_UPDATE_SPEED = 1 / DAB_Settings[DAB_INDEX].UpdateSpeed;
		else
			DAB_Settings[DAB_INDEX][subindex] = value;
			if (subindex2) then
				subindex2();
			end
		end
		return;
	elseif (index == "SETACTIONID") then
		if (subindex == "F") then
			DAB_Settings[DAB_INDEX].Buttons[subindex2].action = value;
			DAB_ActionButton_Update(subindex2);
			DAB_Update_FloaterList();
			DAB_Update_ObjectList();
			DAB_BarBrowser_Update();
		else
			DAB_Settings[DAB_INDEX].Bar[subindex].pages[DAB_ACTIONIDS_LIST[subindex2].page][DAB_ACTIONIDS_LIST[subindex2].button] = value;
			DAB_Bar_SetPage(subindex, DAB_ACTIONIDS_LIST[subindex2].page, 1);
		end
		DAB_Update_ActionIDsList();
		DAB_SetActionIDsMenu_Update();
		return;
	elseif (index == "CONDITION") then
		DAB_CONDITION_BUFFER[subindex] = value;
	elseif (index == "MainMenuBar") then
		DAB_Settings[DAB_INDEX].MainMenuBar[subindex] = value;
		DAB_Update_MainMenuBar();
		return;
	elseif (index == "KEYBINDING") then
		local kbindex;
		if (subindex2 == "CheckBox") then
			kbindex = this:GetParent().index;
		elseif (subindex2 == "DropMenu") then
			local cbox = string.gsub(DAB_DropMenu.controlbox, "_Setting", "");
			kbindex = getglobal(cbox):GetParent().index;
		else
			local cbox = string.gsub(DAB_ScrollMenu.controlbox, "_Setting", "");
			kbindex = getglobal(cbox):GetParent().index;
		end
		DAB_Settings[DAB_INDEX].Keybindings[kbindex][subindex] = value;
		if (subindex2 == "DropMenu") then
			if (value == 12) then
				DAB_Settings[DAB_INDEX].Keybindings[kbindex].suboption = "1_1";
				DAB_Settings[DAB_INDEX].Keybindings[kbindex].suboption2 = 1;
			else
				DAB_Settings[DAB_INDEX].Keybindings[kbindex].suboption = 1;
				DAB_Settings[DAB_INDEX].Keybindings[kbindex].suboption2 = 1;
			end
		end
		DAB_KeybindingBrowser_Update();
		DAB_Update_Keybindings();
		return;
	else
		if (subindex2) then
			DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX][index][subindex][subindex2] = value;
		elseif (subindex) then
			DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX][index][subindex] = value;
		else
			DAB_Settings[DAB_INDEX][DAB_OBJECT_TYPE][DAB_OBJECT_SUBINDEX][index] = value;
		end
	end
	if ((not override) and settingType ~= 0) then
		local func;
		if (DAB_OBJECT_TYPE == "Bar") then
			func = "DAB_Bar_";
		elseif (DAB_OBJECT_TYPE == "Floaters") then
			func = "DAB_Floater_";
		elseif (DAB_OBJECT_TYPE == "ControlBox") then
			func = "DAB_ControlBox_";
			settingType = nil;
		elseif (DAB_OBJECT_TYPE == "OtherBar") then
			func = "DAB_OtherBar_";
			settingType = nil;
		end
		if (not settingType) then
			settingType = "Initialize";
		end
		getglobal(func..settingType)(DAB_OBJECT_SUBINDEX);
	end
	if (index == "Label" and subindex == "text") then
		DAB_Update_ObjectList();
		DAB_BarBrowser_Update();
	end
end
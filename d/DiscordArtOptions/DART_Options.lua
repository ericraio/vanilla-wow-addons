function DART_CheckButton_OnClick()
	DART_Update_Setting(this:GetChecked());
	DART_Run_Functions(this:GetChecked());
end

function DART_ColorPicker_OnClick()
	local basecolor = DART_Get_Setting(this.index);
	local color = {};
	color.r = basecolor.r;
	color.g = basecolor.g;
	color.b = basecolor.b;
	ColorPickerFrame.previousValues = color;
	ColorPickerFrame.cancelFunc = DART_ColorPicker_ColorCancelled;
	ColorPickerFrame.opacityFunc = DART_ColorPicker_ColorChanged;
	ColorPickerFrame.func = DART_ColorPicker_ColorChanged;
	ColorPickerFrame.colorBox = this:GetName();
	ColorPickerFrame.index = this.index;
	ColorPickerFrame.subindex = this.subindex;
	ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
	ColorPickerFrame:ClearAllPoints();
	if (DART_Options:GetRight() < UIParent:GetWidth() / 2) then
		ColorPickerFrame:SetPoint("LEFT", "DART_Options", "RIGHT", 10, 0);
	else
		ColorPickerFrame:SetPoint("RIGHT", "DART_Options", "LEFT", -10, 0);
	end
	ColorPickerFrame:Show();
end

function DART_ColorPicker_ColorCancelled()
	local color = ColorPickerFrame.previousValues;
	DART_Update_Setting(color, ColorPickerFrame.index, ColorPickerFrame.subindex);
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	if (ColorPickerFrame.index ~= "CONDITION") then
		DART_Run_Functions(1, 1, getglobal(ColorPickerFrame.colorBox).updatepreview);
	end
end

function DART_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local color = { r=r, g=g, b=b };
	DART_Update_Setting(color, ColorPickerFrame.index, ColorPickerFrame.subindex);
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	if (ColorPickerFrame.index ~= "CONDITION") then
		DART_Run_Functions(1, 1, getglobal(ColorPickerFrame.colorBox).updatepreview);
	end
end

function DART_ConditionMenu_Update()
	local list, frame, numButtons;
	list = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions;
	if (not list) then list = {}; end
	frame = DART_ControlOptions_ConditionMenu;
	numButtons = 7;

	local numOptions = #list;
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
			for cindex, value in pairs(DL_CONDITIONS_MENU) do
				if (value.value == list[index].condition) then
					conditionsIndex = cindex;
					break;
				end
			end
			local params = DL_CONDITIONS_MENU[conditionsIndex].params;
			if (params == 1 or params == 2) then
				text = text..": |cFFFFFFFF"..DL_Get_MenuText(DL_ACTIONS, list[index].action);
				if (list[index].ignoreGlobal) then
					text = text..",|cFFCCCCCC "..DART_TEXT.IgnoreGlobal;
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
				text = text..": |cFFFFFFFF"..DL_Get_MenuText(DL_ACTIONS, list[index].action).." "..DL_Get_MenuText(DL_COMPARE_MENU, list[index].compare).." "..list[index].number;
			elseif (params == 12) then
				text = text..": |cFFFFFFFF"..list[index].text;
			elseif (params == 13) then
				text = text..": |cFFFFFFFF"..list[index].unit;
			elseif (params == 14) then
				text = text..": |cFFFFFFFF"..list[index].unit.." and "..list[index].unit2;
			end
			getglobal(frame:GetName().."_Button"..i.."ConditionText"):SetText(text);

			text = DART_TEXT.Response.." |cFFFFFF00"..DL_Get_MenuText(DART_RESPONSES, list[index].response);
			if (list[index].response == 3 or list[index].response == 4) then
				text = text..": |cFFFFFFFF"..list[index].texture;
			elseif (list[index].response == 7 or list[index].response == 8 or list[index].response == 9 or list[index].response == 11 or list[index].response == 23 or list[index].response == 15 or list[index].response == 19 or list[index].response == 20 or list[index].response == 28) then
				text = text..": |cFFFFFFFF"..list[index].amount;
			elseif (list[index].response == 10) then
				text = text..": |cFFFFFFFF"..list[index].rx..", "..list[index].ry;
			elseif (list[index].response == 12 or list[index].response == 13 or list[index].response == 16 or list[index].response == 21 or list[index].response == 24) then
				text = text.." to "..(list[index].alpha * 100).."%";
			elseif (list[index].response == 14 or list[index].response == 17 or list[index].response == 18 or list[index].response == 22 or list[index].response == 25) then
				local hex = DL_Get_HexColor(list[index].color.r, list[index].color.g, list[index].color.b);
				text = text.." to "..hex.."this color";
			elseif (list[index].response == 26 or list[index].response == 27) then
				text = text..": |cFFFFFFFF"..list[index].rtext;
			end
			getglobal(frame:GetName().."_Button"..i.."ResponseText"):SetText(text);

			text = DART_TEXT.Overrides.." |cFFFFFFFF";
			for i,o in pairs(list[index].overrides) do
				if (i == #list[index].overrides) then
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

function DART_Add_Condition()
	if (not DART_CONDITION_BUFFER) then return; end
	local baseOptions = "DART_ControlOptions_";

	local option = getglobal(baseOptions.."Buff");
	if (option:IsShown()) then
		DART_CONDITION_BUFFER.buff = option:GetText();
		if (not DART_CONDITION_BUFFER.buff) then DART_CONDITION_BUFFER.buff = ""; end
	end
	option = getglobal(baseOptions.."Text");
	if (option:IsShown()) then
		DART_CONDITION_BUFFER.text = option:GetText();
		if (not DART_CONDITION_BUFFER.text) then DART_CONDITION_BUFFER.text = ""; end
	end
	option = getglobal(baseOptions.."Number");
	if (option:IsShown()) then
		DART_CONDITION_BUFFER.number = option:GetNumber();
		if (not DART_CONDITION_BUFFER.number) then DART_CONDITION_BUFFER.number = 1; end
	end
	option = getglobal(baseOptions.."ResponseText");
	if (option:IsShown()) then
		DART_CONDITION_BUFFER.rtext = option:GetText();
		if (not DART_CONDITION_BUFFER.rtext) then DART_CONDITION_BUFFER.rtext = ""; end
	end
	option = getglobal(baseOptions.."ResponseX");
	if (option and option:IsShown()) then
		DART_CONDITION_BUFFER.rx = option:GetNumber();
		if (not DART_CONDITION_BUFFER.rx) then DART_CONDITION_BUFFER.rx = 0; end
	end
	option = getglobal(baseOptions.."ResponseY");
	if (option and option:IsShown()) then
		DART_CONDITION_BUFFER.ry = option:GetNumber();
		if (not DART_CONDITION_BUFFER.ry) then DART_CONDITION_BUFFER.ry = 0; end
	end

	local orbox = getglobal(baseOptions.."Overrides");
	DART_CONDITION_BUFFER.overrides = orbox:GetText();
	orbox:SetText("");
	orbox:ClearFocus();
	if (DART_CONDITION_BUFFER.overrides and DART_CONDITION_BUFFER.overrides ~= "") then
		local overrides = {};
		local num = "";
		local index = 1;
		local char;
		for i=1, string.len(DART_CONDITION_BUFFER.overrides) do
			char = string.sub(DART_CONDITION_BUFFER.overrides, i, i);
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
		DART_CONDITION_BUFFER.overrides = {};
		DL_Copy_Table(overrides, DART_CONDITION_BUFFER.overrides);
	else
		DART_CONDITION_BUFFER.overrides = {};
	end
	if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions = {};
	end
	local index = #DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions + 1;
	if (DART_CONDITION_EDITTING) then
		index = DART_CONDITION_EDITTING;
	end
	DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions[index] = {};
	DL_Copy_Table(DART_CONDITION_BUFFER, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions[index]);
	DART_ControlOptions_Condition_Setting:SetText("");
	DART_ControlOptions_Response_Setting:SetText("");
	DART_Reset_Parameters("DART_ControlOptions");
	getglobal("DART_Texture_"..DART_TEXTURE_INDEX).activeConditions = {};
	DART_ConditionMenu_Update();
	DART_CONDITION_BUFFER = nil;
	DART_CONDITION_EDITTING = nil;
end

function DART_Select_Condition(condition, menucontrol)
	if (not condition) then
		DART_CONDITION_EDITTING = nil;
		condition = this.value;
		DART_CONDITION_BUFFER = { condition = condition };
	else
		DART_CONDITION_EDITTING = condition;
		DART_CONDITION_BUFFER = {};
		DL_Copy_Table(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions[condition], DART_CONDITION_BUFFER);
		DL_Init_MenuControl(DART_ControlOptions_Condition, DART_CONDITION_BUFFER.condition);
		DART_CONDITION_BUFFER.overrides = "";
		for i,o in pairs(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions[condition].overrides) do
			if (i == #DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions[condition].overrides) then
				DART_CONDITION_BUFFER.overrides = DART_CONDITION_BUFFER.overrides..o;
			else
				DART_CONDITION_BUFFER.overrides = DART_CONDITION_BUFFER.overrides..o..", ";
			end
			DART_ControlOptions_Overrides:SetText(DART_CONDITION_BUFFER.overrides);
		end
		condition = DART_CONDITION_BUFFER.condition;
	end
	if (not menucontrol) then menucontrol = DART_ScrollMenu.cboxbase; end
	local options = getglobal(menucontrol):GetParent():GetName();
	DART_Reset_Parameters(options);
	local conditionsIndex;
	for index, value in pairs(DL_CONDITIONS_MENU) do
		if (value.value == condition) then
			conditionsIndex = index;
			break;
		end
	end
	local params = DL_CONDITIONS_MENU[conditionsIndex].params;
	if (params == 1) then
		DART_Show_Parameters({"_ActionID", "_IgnoreGlobal"}, {1, 2}, options);
	elseif (params == 2) then
		DART_Show_Parameters({"_ActionID"}, {1}, options);
	elseif (params == 3) then
		if (not DART_CONDITION_EDITTING) then
			DART_CONDITION_BUFFER.unit = "player";
		end
		DART_Show_Parameters({"_Unit", "_Buff"}, {1, 3}, options);
	elseif (params == 4) then
		DL_Set_Anchor("_Condition", 0, -15, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_Condition", 0, -40, nil, nil, nil, getglobal(options.."_Number"));
		DART_Show_Parameters({"_Comparison", "_Number"}, {1, 3}, options);
	elseif (params == 5) then
		if (not DART_CONDITION_EDITTING) then
			DART_CONDITION_BUFFER.unit = "player";
		end
		DART_Show_Parameters({"_Unit", "_Text"}, {1, 3}, options);
	elseif (params == 6) then
		DL_Set_Anchor("_Condition", 0, -65, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_Comparison", 5, 0, "LEFT", "RIGHT", nil, getglobal(options.."_Number"));
		if (not DART_CONDITION_EDITTING) then
			DART_CONDITION_BUFFER.unit = "player";
		end
		DART_Show_Parameters({"_Unit", "_Text", "_Comparison", "_Number"}, {1, 3, 1, 3}, options);
	elseif (params == 7) then
		DL_Set_Anchor("_Condition", 0, -40, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_Condition", 0, -65, nil, nil, nil, getglobal(options.."_Number"));
		if (not DART_CONDITION_EDITTING) then
			DART_CONDITION_BUFFER.unit = "player";
		end
		DART_Show_Parameters({"_Unit", "_Comparison", "_Number"}, {1, 1, 3}, options);
	elseif (params == 8) then
		DART_Show_Parameters({"_Forms"}, {1}, options);
	elseif (params == 9) then
		DART_Show_Parameters({"_Targets"}, {1}, options);
	elseif (params == 10) then
		DL_Set_Anchor("_Condition", 0, -15, nil, nil, nil, getglobal(options.."_Number"));
		DART_Show_Parameters({"_Number"}, {3}, options);
	elseif (params == 11) then
		DL_Set_Anchor("_Condition", 0, -40, nil, nil, nil, getglobal(options.."_Comparison"));
		DL_Set_Anchor("_Condition", 0, -65, nil, nil, nil, getglobal(options.."_Number"));
		DART_Show_Parameters({"_ActionID", "_Comparison", "_Number"}, {1, 1, 3}, options);
	elseif (params == 12) then
		DART_Show_Parameters({"_Text"}, {3}, options);
	elseif (params == 13) then
		if (not DART_CONDITION_EDITTING) then
			DART_CONDITION_BUFFER.unit = "player";
		end
		DART_Show_Parameters({"_Unit"}, {1}, options);
	elseif (params == 14) then
		if (not DART_CONDITION_EDITTING) then
			DART_CONDITION_BUFFER.unit = "player";
			DART_CONDITION_BUFFER.unit2 = "player";
		end
		DART_Show_Parameters({"_Unit", "_Unit2"}, {1, 1}, options);
	end
end

function DART_Select_Response(response, menucontrol)
	if (not DART_CONDITION_BUFFER) then return; end
	if (not menucontrol) then menucontrol = DART_ScrollMenu.cboxbase; end
	local options = getglobal(menucontrol):GetParent():GetName();
	if (not response) then
		response = this.value;
		DART_CONDITION_BUFFER.response = response;
	else
		response = DART_CONDITION_BUFFER.response;
		DL_Init_MenuControl(getglobal(options.."_Response"), response);
	end
	DART_Reset_Parameters(options, 1);
	if (response == 3 or response == 4) then
		DART_Show_Parameters({"_ResponseTexture"}, {1}, options);
	elseif (response == 7 or response == 8 or response == 9 or response == 11 or response == 23 or response == 15 or response == 19 or response == 20 or response == 28) then
		DART_Show_Parameters({"_Amount"}, {4}, options);
	elseif (response == 10) then
		DART_Show_Parameters({"_ResponseX","_ResponseY"}, {3,3}, options);
	elseif (response == 12 or response == 13 or response == 16 or response == 21 or response == 24) then
		DART_Show_Parameters({"_Alpha"}, {4}, options);
	elseif (response == 14 or response == 17 or response == 18 or response == 22 or response == 25) then
		DART_Show_Parameters({"_Color"}, {5}, options);
	elseif (response == 26 or response == 27) then
		DART_Show_Parameters({"_ResponseText"}, {3}, options);
	end
end

function DART_Show_Parameters(parameters, types, base)
	for i, param in pairs(parameters) do
		local frame = getglobal(base..param);
		frame:Show();
		if (DART_CONDITION_EDITTING) then
			if (types[i] == 1) then
				DL_Init_MenuControl(frame, DART_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 2) then
				DL_Init_CheckBox(frame, DART_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 3) then
				DL_Init_EditBox(frame, DART_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 4) then
				if (not DART_CONDITION_BUFFER[frame.subindex]) then
					local min, max = frame:GetMinMaxValues();
					if (frame.scale) then
						max = max / frame.scale;
					end
					DART_CONDITION_BUFFER[frame.subindex] = max;
				end
				DL_Init_Slider(frame, DART_CONDITION_BUFFER[frame.subindex]);
			elseif (types[i] == 5) then
				if (not DART_CONDITION_BUFFER[frame.subindex]) then
					DART_CONDITION_BUFFER[frame.subindex] = {r=1, g=1, b=1};
				end
				DL_Init_ColorPicker(frame, DART_CONDITION_BUFFER[frame.subindex]);
			end
		elseif (param == "_Unit" or param == "_Unit2") then
			DL_Init_MenuControl(frame, "player");
		end
	end
end

function DART_Reset_Parameters(options, toggle)
	if (not toggle) then
		getglobal(options.."_ActionID"):Hide();
		getglobal(options.."_ActionID_Setting"):SetText("");
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
	getglobal(options.."_ResponseTexture"):Hide();
	getglobal(options.."_ResponseTexture_Setting"):SetText("");
	getglobal(options.."_Amount"):Hide();
	getglobal(options.."_Amount_Display"):SetText("");
	getglobal(options.."_Alpha"):Hide();
	getglobal(options.."_Alpha_Display"):SetText("");
	getglobal(options.."_ResponseX"):Hide();
	getglobal(options.."_ResponseX"):SetText("");
	getglobal(options.."_ResponseY"):Hide();
	getglobal(options.."_ResponseY"):SetText("");
	getglobal(options.."_Color"):Hide();
	getglobal(options.."_ResponseText"):Hide();
end

function DART_Condition_Delete()
	local list = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions;
	getglobal("DART_Texture_"..DART_TEXTURE_INDEX).activeConditions = {};

	for i=1, #list do
		if (i > this:GetParent().index and i > 1) then
			list[i - 1] = {};
			DL_Copy_Table(list[i], list[i - 1]);
		end
	end
	list[#list] = nil;
	DART_ConditionMenu_Update();
end

function DART_Condition_Edit()
	local ci = this:GetParent().index;
	DART_Select_Condition(ci, this:GetParent().cboxbase);
	DART_Select_Response(DART_CONDITION_BUFFER.response, this:GetParent().cboxbase);
end

function DART_Condition_MoveDown()
	local list;
	local index = this:GetParent().index;
	local newindex = index + 1;

	list = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions;

	if (newindex > #list) then return; end

	local buffer = {};
	DL_Copy_Table(list[index], buffer);
	local buffer2 = {};
	DL_Copy_Table(list[newindex], buffer2);

	DL_Copy_Table(buffer2, list[index]);
	DL_Copy_Table(buffer, list[newindex]);
	DART_ConditionMenu_Update();
end

function DART_Condition_MoveUp()
	local list;
	local index = this:GetParent().index;
	local newindex = index - 1;
	if (newindex == 0) then return; end

	list = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions;

	local buffer = {};
	DL_Copy_Table(list[index], buffer);
	local buffer2 = {};
	DL_Copy_Table(list[newindex], buffer2);

	DL_Copy_Table(buffer2, list[index]);
	DL_Copy_Table(buffer, list[newindex]);
	DART_ConditionMenu_Update();
end

function DART_EditBox_Update()
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
	if (this.index or this.miscindex) then
		DART_Update_Setting(value);
		DART_Run_Functions();
	end
	if (this.index == "name") then
		DART_BaseOptions_SelectTexture_Setting:SetText(DART_TEXTURE_LIST[DART_TEXTURE_INDEX].text);
	elseif (this.index == "texture") then
		DART_Update_Preview();
	end
end

function DART_Get_Setting()
	if (this.index == "CONDITION") then
		if (DART_CONDITION_BUFFER[this.subindex]) then
			return DART_CONDITION_BUFFER[this.subindex];
		elseif (this.subindex == "color") then
			return {r=1, g=1, b=1};
		else
			return 1;
		end
	elseif (this.miscindex) then
		return DART_Settings[DART_INDEX][this.miscindex];
	elseif (this.subindex) then
		return DART_Settings[DART_INDEX][DART_TEXTURE_INDEX][this.index][this.subindex];
	elseif (this.index) then
		return DART_Settings[DART_INDEX][DART_TEXTURE_INDEX][this.index];
	end
end

function DART_Initialize_MiscOptions()
	DL_Init_Slider(DART_MiscOptions_UpdateSpeed, DART_Settings[DART_INDEX].updatespeed);
	DL_Init_MenuControl(DART_MiscOptions_OptionsScale, DART_Settings[DART_INDEX].optionsscale);
	DL_Init_CheckBox(DART_MiscOptions_AutoLock, DART_Settings[DART_INDEX].AutoLock);
	local aloffset = DART_MiscOptions_AutoLock_Label:GetWidth() / 2;
	DART_MiscOptions_AutoLock:ClearAllPoints();
	DART_MiscOptions_AutoLock:SetPoint("TOP", "DART_MiscOptions", "TOP", -aloffset, -95);
	DART_MiscOptions_CurrentProfile:SetText(DART_TEXT.CurrentProfile..DART_INDEX);
	DART_MiscOptions_MaxTextures_Display:SetText(DART_Get_MaxTextureIndex());
end

function DART_Initialize_ProfileList()
	DART_PROFILE_LIST = {};
	local i = 0;
	for profile in pairs(DART_Settings) do
		if (profile ~= "CustomTextures" and (not string.find(profile, " : "))) then
			i = i + 1;
			DART_PROFILE_LIST[i] = { text=profile, value=profile };
		end
	end
end

function DART_Initialize_TextureList()
	DART_TEXTURE_LIST = {};
	local ti = 0;
	for ti = 1, DART_Get_MaxTextureIndex() do
		DART_TEXTURE_LIST[ti] = { text="["..ti.."] "..DART_Settings[DART_INDEX][ti].name, value=ti };
	end
end

function DART_Initialize_TextureOptions()
	local settings = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX];
	DART_Update_Preview();

	DL_Init_EditBox(DART_MainTextureOptions_Name, settings.name);

	DL_Init_CheckBox(DART_TextureOptions_Hide, settings.hide);
	DL_Init_CheckBox(DART_TextureOptions_Highlight, settings.highlight);
	DL_Init_CheckBox(DART_BackdropOptions_HideBackground, settings.hidebg);
	DL_Init_CheckBox(DART_TextOptions_HideText, settings.text.hide);
	DL_Init_CheckBox(DART_TextureOptions_DisableMouse, settings.disablemouse);
	DL_Init_CheckBox(DART_TextureOptions_DisableMousewheel, settings.disableMousewheel);
	DL_Init_Slider(DART_TextureOptions_Height, settings.height);
	DL_Init_Slider(DART_TextureOptions_Width, settings.width);
	DL_Init_Slider(DART_TextureOptions_Scale, settings.scale);
	DL_Init_Slider(DART_TextureOptions_Alpha, settings.alpha);
	DL_Init_Slider(DART_BackdropOptions_BackgroundAlpha, settings.bgalpha);
	DL_Init_Slider(DART_BackdropOptions_BorderAlpha, settings.borderalpha);
	DL_Init_Slider(DART_TextOptions_TextAlpha, settings.text.alpha);
	DL_Init_Slider(DART_TextureOptions_HighlightAlpha, settings.highlightalpha);
	DL_Init_Slider(DART_BackdropOptions_Padding, settings.padding);
	DL_Init_Slider(DART_TextOptions_TextHeight, settings.text.height);
	DL_Init_Slider(DART_TextOptions_TextWidth, settings.text.width);
	DL_Init_Slider(DART_TextOptions_FontSize, settings.text.fontsize);
	DL_Init_EditBox(DART_TextOptions_Text, settings.text.text);
	for i=1,4 do
		DL_Init_EditBox(getglobal("DART_TextureOptions_AttachFrame"..i), settings.attachframe[i]);
		DL_Init_EditBox(getglobal("DART_TextureOptions_XOffset"..i), settings.xoffset[i]);
		DL_Init_EditBox(getglobal("DART_TextureOptions_YOffset"..i), settings.yoffset[i]);
		DL_Init_MenuControl(getglobal("DART_TextureOptions_AttachPoint"..i), settings.attachpoint[i]);
		DL_Init_MenuControl(getglobal("DART_TextureOptions_AttachTo"..i), settings.attachto[i]);
	end
	DL_Init_EditBox(DART_TextureOptions_XOffsetT, settings.text.xoffset);
	DL_Init_EditBox(DART_MainTextureOptions_TextureFile, settings.texture);
	DL_Init_EditBox(DART_MainTextureOptions_X1, settings.coords[1]);
	DL_Init_EditBox(DART_MainTextureOptions_X2, settings.coords[2]);
	DL_Init_EditBox(DART_MainTextureOptions_Y1, settings.coords[3]);
	DL_Init_EditBox(DART_MainTextureOptions_Y2, settings.coords[4]);
	DL_Init_EditBox(DART_TextureOptions_FrameLevel, settings.framelevel);
	DL_Init_EditBox(DART_TextureOptions_YOffsetT, settings.text.yoffset);
	DL_Init_EditBox(DART_TextureOptions_HighlightTexture, settings.highlighttexture);
	DL_Init_EditBox(DART_TextOptions_Font, settings.font);
	DL_Init_EditBox(DART_TextureOptions_Parent, settings.parent);
	DL_Init_MenuControl(DART_TextureOptions_AttachPointT, settings.text.attachpoint);
	DL_Init_MenuControl(DART_TextureOptions_AttachToT, settings.text.attachto);
	DL_Init_MenuControl(DART_TextOptions_JustifyH, settings.text.justifyH);
	DL_Init_MenuControl(DART_TextOptions_JustifyV, settings.text.justifyV);
	DL_Init_MenuControl(DART_TextOptions_DrawLayer, settings.text.drawlayer);
	DL_Init_MenuControl(DART_TextureOptions_FrameStrata, settings.strata);
	DL_Init_MenuControl(DART_TextureOptions_DrawLayer, settings.drawlayer);
	DL_Init_MenuControl(DART_TextureOptions_BlendMode, settings.blendmode);
	DL_Init_ColorPicker(DART_TextureOptions_Color, settings.color);
	DL_Init_ColorPicker(DART_BackdropOptions_BGColor, settings.bgcolor);
	DL_Init_ColorPicker(DART_BackdropOptions_BorderColor, settings.bordercolor);
	DL_Init_ColorPicker(DART_TextureOptions_HighlightColor, settings.highlightcolor);
	DL_Init_ColorPicker(DART_TextOptions_TextColor, settings.text.color);

	DL_Init_EditBox(DART_BackdropOptions_BackgroundTexture, settings.bgtexture);
	DL_Init_EditBox(DART_BackdropOptions_BorderTexture, settings.bordertexture);
	DL_Init_CheckBox(DART_BackdropOptions_Tile, settings.Backdrop.tile);
	DL_Init_EditBox(DART_BackdropOptions_InsetLeft, settings.Backdrop.left);
	DL_Init_EditBox(DART_BackdropOptions_InsetRight, settings.Backdrop.right);
	DL_Init_EditBox(DART_BackdropOptions_InsetTop, settings.Backdrop.top);
	DL_Init_EditBox(DART_BackdropOptions_InsetBottom, settings.Backdrop.bottom);
	DL_Init_EditBox(DART_BackdropOptions_EdgeSize, settings.Backdrop.edgeSize);
	DL_Init_EditBox(DART_BackdropOptions_TileSize, settings.Backdrop.tileSize);

	for i=1,14 do
		if (settings.scripts[i] and settings.scripts[i] ~= "") then
			getglobal("DART_ScriptOptions_"..DART_SCRIPT_LABEL[i]):SetText(DART_SCRIPT_LABEL[i].." *");
		else
			getglobal("DART_ScriptOptions_"..DART_SCRIPT_LABEL[i]):SetText(DART_SCRIPT_LABEL[i]);
		end
	end
	if (DART_SCRIPT_INDEX and settings.scripts[DART_SCRIPT_INDEX]) then
		DART_ScriptOptions_ScrollFrame_Text:SetText(settings.scripts[DART_SCRIPT_INDEX]);
	elseif (DART_SCRIPT_INDEX) then
		DART_ScriptOptions_ScrollFrame_Text:SetText("");
	end

	if (DART_ControlOptions:IsShown()) then
		DART_ConditionMenu_Update();
	end
end

function DART_Copy_ControlSettings()
	DART_CONTROL_BUFFER = {};
	DL_Copy_Table(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions, DART_CONTROL_BUFFER);
end

function DART_Paste_ControlSettings()
	if (not DART_CONTROL_BUFFER) then return; end
	if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions = {};
	end
	DL_Copy_Table(DART_CONTROL_BUFFER, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Conditions);
	DART_ConditionMenu_Update();
end

function DART_Menu_OnClick()
	getglobal(DART_DropMenu.controlbox):SetText(getglobal(this:GetName().."_Text"):GetText());
	DART_DropMenu:Hide();
	if (DART_DropMenu.index) then
		DART_Update_Setting(this.value, DART_DropMenu.index, DART_DropMenu.subindex);
	elseif (DART_DropMenu.miscindex) then
		DART_Settings[DART_INDEX][DART_DropMenu.miscindex] = this.value;
	end
	if (DART_DropMenu.initFunc) then
		DART_DropMenu.initFunc();
	else
		DART_Initialize_Texture(DART_TEXTURE_INDEX);
	end
end

function DART_Nudge_OnClick(button)
	if (DART_NUDGE_INDEX < 5) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].attachframe[DART_NUDGE_INDEX]) then return; end
	end
	local amt = 1;
	if (button == "RightButton") then
		amt = 10;
	elseif (this.moving) then
		amt = 3;
	end
	local id = this:GetID();
	if (id == 1) then
		if (DART_NUDGE_INDEX == 5) then
			DART_TextMoveLeft(DART_TEXTURE_INDEX, amt);
		else
			DART_MoveLeft(DART_TEXTURE_INDEX, DART_NUDGE_INDEX, amt);
		end
	elseif (id == 2) then
		if (DART_NUDGE_INDEX == 5) then
			DART_TextMoveRight(DART_TEXTURE_INDEX, amt);
		else
			DART_MoveRight(DART_TEXTURE_INDEX, DART_NUDGE_INDEX, amt);
		end
	elseif (id == 3) then
		if (DART_NUDGE_INDEX == 5) then
			DART_TextMoveUp(DART_TEXTURE_INDEX, amt);
		else
			DART_MoveUp(DART_TEXTURE_INDEX, DART_NUDGE_INDEX, amt);
		end
	elseif (id == 4) then
		if (DART_NUDGE_INDEX == 5) then
			DART_TextMoveDown(DART_TEXTURE_INDEX, amt);
		else
			DART_MoveDown(DART_TEXTURE_INDEX, DART_NUDGE_INDEX, amt);
		end
	end

	if (DART_NUDGE_INDEX < 5) then 
		getglobal("DART_TextureOptions_XOffset"..DART_NUDGE_INDEX):SetText(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].xoffset[DART_NUDGE_INDEX]);
		getglobal("DART_TextureOptions_YOffset"..DART_NUDGE_INDEX):SetText(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].yoffset[DART_NUDGE_INDEX]);
	else
		DART_TextureOptions_XOffsetT:SetText(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].text.xoffset);
		DART_TextureOptions_YOffsetT:SetText(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].text.yoffset);
	end
end

function DART_Nudge_OnUpdate(elapsed)
	if (not this.moving) then return; end
	if (not this.timer) then
		this.timer = .05;
	end
	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = .05;
		DART_Nudge_OnClick();
	end
end

function DART_Options_AddTexture()
	local file = DART_TextureBrowser_File:GetText();
	if ((not file) or file == "") then
		DART_TextureBrowser_File:SetFocus();
		return;
	end
	if (not string.find(file, "\\")) then
		file = "Interface\\AddOns\\DiscordArt\\CustomTextures\\"..file;
	end
	local x1 = tonumber(DART_TextureBrowser_X1:GetText());
	if ((not x1) or x1 == "") then
		DART_TextureBrowser_X1:SetFocus();
		return;
	end
	local x2 = tonumber(DART_TextureBrowser_X2:GetText());
	if ((not x2) or x2 == "") then
		DART_TextureBrowser_X2:SetFocus();
		return;
	end
	local y1 = tonumber(DART_TextureBrowser_Y1:GetText());
	if ((not y1) or y1 == "") then
		DART_TextureBrowser_Y1:SetFocus();
		return;
	end
	local y2 = tonumber(DART_TextureBrowser_Y2:GetText());
	if ((not y2) or y2 == "") then
		DART_TextureBrowser_Y2:SetFocus();
		return;
	end
	local height = tonumber(DART_TextureBrowser_Height:GetText());
	if (not height) then
		DART_TextureBrowser_Height:SetFocus();
		return;
	end
	local width = tonumber(DART_TextureBrowser_Width:GetText());
	if (not width) then
		DART_TextureBrowser_Width:SetFocus();
		return;
	end
	local index = #DART_Settings.CustomTextures + 1;
	DART_Settings.CustomTextures[index] = {};
	DART_Settings.CustomTextures[index].file = file;
	DART_Settings.CustomTextures[index].x1 = x1;
	DART_Settings.CustomTextures[index].x2 = x2;
	DART_Settings.CustomTextures[index].y1 = y1;
	DART_Settings.CustomTextures[index].y2 = y2;
	DART_Settings.CustomTextures[index].height = height;
	DART_Settings.CustomTextures[index].width = width;
	local customindex = index;
	index = #DART_TEXTURES + 1;
	DART_TEXTURES[index] = {};
	DART_TEXTURES[index].file = file;
	DART_TEXTURES[index].x1 = x1;
	DART_TEXTURES[index].x2 = x2;
	DART_TEXTURES[index].y1 = y1;
	DART_TEXTURES[index].y2 = y2;
	DART_TEXTURES[index].height = height;
	DART_TEXTURES[index].width = width;
	DART_TEXTURES[index].customindex = customindex;
	DART_TextureBrowser_Update();
	DART_STICKY_TEXTURE = {file="", x1="", x2="", y1="", y2="", height="", width=""};
	DART_TextureBrowser_UpdatePreview();
end

function DART_Options_CopySettings()
	DART_CLIPBOARD = {};
	DL_Copy_Table(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX], DART_CLIPBOARD);
end

function DART_Options_DeleteProfile(index)
	if (not index) then
		index = DART_MiscOptions_SetProfile_Setting:GetText();
	end
	if (index == "" or (not index)) then return; end
	if (index == DART_TEXT.Default) then
		DL_Debug(DART_TEXT.CantDeleteDefault);
		return;
	elseif (index == DART_INDEX) then
		DL_Debug(DART_TEXT.CantDeleteCurrent);
		return;
	end
	DART_Settings[index] = nil;
	for profile in pairs(DART_Settings) do
		if (DART_Settings[profile] == index) then
			DART_Settings[profile] = DART_TEXT.Default;
		end
	end
	DART_Initialize_ProfileList();
	DART_MiscOptions_SetProfile_Setting:SetText("");
	DL_Debug(DART_TEXT.ProfileDeleted..index);
end

function DART_Options_CreateTexture()
	local ti = DART_Get_MaxTextureIndex() + 1;
	local texture = getglobal("DART_Texture_"..ti);
	DART_Set_DefaultSettings(DART_INDEX, ti);
	if (texture) then
		DART_Initialize_Texture(ti);
	else
		DART_Create_Texture(ti);
	end
	DART_MiscOptions_MaxTextures_Display:SetText(ti);
	DART_Initialize_TextureList();
end

function DART_Options_DeleteTexture()
	local ti = DART_Get_MaxTextureIndex();
	if (ti == 1) then
		DL_Error("You must have at least 1 texture.");
		return;
	end
	local texture = getglobal("DART_Texture_"..ti);
	texture:Hide();
	texture:UnregisterAllEvents();
	for i=1,DART_NUMBER_OF_SCRIPTS do
		RunScript("function DART_Texture"..ti.."_Script_"..DART_SCRIPT_LABEL[i].."()\nend");
	end
	DART_Settings[DART_INDEX][ti] = nil;
	DART_MiscOptions_MaxTextures_Display:SetText(ti - 1);
	DART_Initialize_TextureList();
	if (ti == DART_TEXTURE_INDEX) then
		DART_TEXTURE_INDEX = DART_TEXTURE_INDEX - 1;
		DART_Initialize_TextureOptions();
		DART_BaseOptions_SelectTexture_Setting:SetText(DART_TEXTURE_LIST[DART_TEXTURE_INDEX].text);
	end
end

function DART_Options_FrameLevelMinus()
	DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].framelevel = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].framelevel - 1;
	DART_Initialize_Texture(DART_TEXTURE_INDEX);
	DL_Init_EditBox(DART_TextureOptions_FrameLevel, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].framelevel);
end

function DART_Options_FrameLevelPlus()
	DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].framelevel = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].framelevel + 1;
	DART_Initialize_Texture(DART_TEXTURE_INDEX);
	DL_Init_EditBox(DART_TextureOptions_FrameLevel, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].framelevel);
end

function DART_Options_LoadPresetBackdrop()
	if (this.value == 1) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bordertexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Backdrop = { tile=true, tileSize=8, edgeSize=1, left=1, right=1, top=1, bottom=1};
	elseif (this.value == 2) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bordertexture = "Interface\\Tooltips\\UI-Tooltip-Border";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Backdrop = { tile=true, tileSize=16, edgeSize=16, left=5, right=5, top=5, bottom=5};
	elseif (this.value == 3) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bordertexture = "Interface\\DialogFrame\\UI-DialogBox-Border";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Backdrop = { tile=true, tileSize=32, edgeSize=32, left=11, right=12, top=12, bottom=11};
	elseif (this.value == 4) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bordertexture = "Interface\\Buttons\\UI-SliderBar-Border";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Backdrop = { tile=true, tileSize=8, edgeSize=8, left=3, right=3, top=6, bottom=6};
	elseif (this.value == 5) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bgtexture = "Interface\\Glues\\Common\\Glue-Tooltip-Background";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].bordertexture = "Interface\\Glues\\Common\\Glue-Tooltip-Border";
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].Backdrop = { tile=true, tileSize=16, edgeSize=16, left=10, right=5, top=4, bottom=9};
	end
	DART_Initialize_TextureOptions();
	DART_Initialize_Texture(DART_TEXTURE_INDEX);
end

function DART_Options_NewProfile(index)
	if (not index) then
		index = DART_MiscOptions_NewProfile:GetText();
	end
	if (index == "" or (not index)) then return; end
	if (index == DART_INDEX) then
		DL_Feedback("This is not a save option.  Discord Art saves your changes as you make them.");
		return;
	end
	DART_Settings[index] = {};
	DL_Copy_Table(DART_Settings[DART_INDEX], DART_Settings[index]);
	DART_INDEX = index;
	DART_Settings[DART_PROFILE_INDEX] = index;
	DART_Initialize_ProfileList();
	DART_MiscOptions_CurrentProfile:SetText(DART_TEXT.CurrentProfile..DART_INDEX);
	DL_Feedback(DART_TEXT.NewProfileCreated..DART_INDEX);
end

function DART_Options_OnHide()
	if (DART_Settings[DART_INDEX].autolock and DART_DRAGGING_UNLOCKED) then
		DART_Toggle_Dragging();
	end
end

function DART_Options_OnShow()
	
end

function DART_Options_PasteSettings()
	if (not DART_CLIPBOARD) then return; end
	DART_Settings[DART_INDEX][DART_TEXTURE_INDEX] = {};
	DL_Copy_Table(DART_CLIPBOARD, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX]);
	DART_Initialize_TextureList();
	DART_BaseOptions_SelectTexture_Setting:SetText(DART_TEXTURE_LIST[DART_TEXTURE_INDEX].text);
	DART_Initialize_TextureOptions();
	DART_Initialize_Texture(DART_TEXTURE_INDEX);
end

function DART_Options_SelectTexture()
	this:GetParent():Hide();
	local text = "";
	local list = getglobal(DART_ScrollMenu.table);
	for _, value in pairs(list) do
		if (value.value == this.value) then
			text = value.text;
		end
	end
	getglobal(DART_ScrollMenu.controlbox):SetText(text);
	if (DART_ScrollMenu.table == "DL_CONDITIONS_MENU") then
		DART_Select_Condition();
	elseif (DART_ScrollMenu.table == "DART_RESPONSES") then
		DART_Select_Response();
	elseif (DART_ScrollMenu.index == "CONDITION") then
		DART_Update_Setting(this.value, DART_ScrollMenu.index, DART_ScrollMenu.subindex);
	else
		DART_TEXTURE_INDEX = this.value;
		DART_Initialize_TextureOptions();
	end
end

function DART_Options_SelectTexture_OnMouseWheel(direction)
	local saved = DART_TEXTURE_INDEX;
	if (direction > 0) then
		DART_TEXTURE_INDEX = DART_TEXTURE_INDEX - 1;
	else
		DART_TEXTURE_INDEX = DART_TEXTURE_INDEX + 1;
	end
	if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX]) then
		DART_TEXTURE_INDEX = saved;
		return;
	end
	DART_BaseOptions_SelectTexture_Setting:SetText(DART_TEXTURE_LIST[DART_TEXTURE_INDEX].text);
	DART_Initialize_TextureOptions();
end

function DART_Options_SelectNudgeIndex()
	DART_NUDGE_INDEX = this.value;
end

function DART_Run_Functions(value, override, preview)
	if (override or (not this.initFunc)) then
		DART_Initialize_Texture(DART_TEXTURE_INDEX);
	else
		this.initFunc(DART_TEXTURE_INDEX, value);
	end
	if (this.updatepreview or preview) then
		DART_Update_Preview();
	end
end

function DART_ScrollMenu_Update()
	local list = getglobal(this:GetParent().table);
	if (not list) then return; end
	local numOptions = #list;
	local offset = FauxScrollFrame_GetOffset(DART_ScrollMenu_ScrollFrame);
	if (not offset) then offset = 0; end
	local index, button;
	
	for i=1, 10 do
		button = getglobal("DART_ScrollMenu_Button"..i);
		buttontext = getglobal("DART_ScrollMenu_Button"..i.."Text");
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
	
	FauxScrollFrame_Update(DART_ScrollMenu_ScrollFrame, numOptions, 10, 20 );
end

function DART_Show_Script(script)
	DART_ScriptOptions_Label:SetText(DART_SCRIPT_LABEL[script]);
	DART_SCRIPT_INDEX = script;
	DART_ScriptOptions_ScrollFrame_Text:SetText("");
	if (DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].scripts[DART_SCRIPT_INDEX]) then
		DART_ScriptOptions_ScrollFrame_Text:SetText(DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].scripts[DART_SCRIPT_INDEX]);
	end
	DART_ScriptOptions_ScrollFrame_Text:SetFocus();
end

function DART_Slider_Update()
	if (not DART_INITIALIZED) then return; end
	local setting = DART_Get_Setting();
	if (this.scale) then
		setting = setting * this.scale;
	end
	local min, max = this:GetMinMaxValues();
	if (setting < min or setting > max) then
		return;
	end
	local value = this:GetValue();
	getglobal(this:GetName().."_Display"):SetText(value);
	if (this.scale) then
		value = value / this.scale;
	end
	DART_Update_Setting(value);
	DART_Run_Functions(value);
end

function DART_Slider_UpdateFromEditBox()
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
	this.index = this:GetParent().index;
	this.subindex = this:GetParent().subindex;
	DART_Update_Setting(value, this.index, this.subindex);
	DART_Run_Functions(value);
end

function DART_TextureBrowser_AdjustCoord(button)
	local amt = .01;
	if (button == "MiddleButton") then
		amt = .0001;
	elseif (button == "RightButton") then
		amt = .001;
	end
	if (this:GetID() == 1) then
		DART_STICKY_TEXTURE.x1 = DART_STICKY_TEXTURE.x1 - amt;
	elseif (this:GetID() == 2) then
		DART_STICKY_TEXTURE.x1 = DART_STICKY_TEXTURE.x1 + amt;
	elseif (this:GetID() == 3) then
		DART_STICKY_TEXTURE.x2 = DART_STICKY_TEXTURE.x2 - amt;
	elseif (this:GetID() == 4) then
		DART_STICKY_TEXTURE.x2 = DART_STICKY_TEXTURE.x2 + amt;
	elseif (this:GetID() == 5) then
		DART_STICKY_TEXTURE.y1 = DART_STICKY_TEXTURE.y1 - amt;
	elseif (this:GetID() == 6) then
		DART_STICKY_TEXTURE.y1 = DART_STICKY_TEXTURE.y1 + amt;
	elseif (this:GetID() == 7) then
		DART_STICKY_TEXTURE.y2 = DART_STICKY_TEXTURE.y2 - amt;
	elseif (this:GetID() == 8) then
		DART_STICKY_TEXTURE.y2 = DART_STICKY_TEXTURE.y2 + amt;
	end
	DART_TextureBrowser_OnLeave();
	DART_TextureBrowser_UpdatePreview();
end

function DART_TextureBrowser_AdjustCoord2(button)
	local amt = .01;
	if (button == "MiddleButton") then
		amt = .0001;
	elseif (button == "RightButton") then
		amt = .001;
	end
	if (this:GetID() == 1) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1] - amt;
	elseif (this:GetID() == 2) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1] + amt;
	elseif (this:GetID() == 3) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2] - amt;
	elseif (this:GetID() == 4) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2] + amt;
	elseif (this:GetID() == 5) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3] - amt;
	elseif (this:GetID() == 6) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3] + amt;
	elseif (this:GetID() == 7) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4] - amt;
	elseif (this:GetID() == 8) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4] + amt;
	elseif (this:GetID() == 9) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5] - amt;
	elseif (this:GetID() == 10) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5] + amt;
	elseif (this:GetID() == 11) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6] - amt;
	elseif (this:GetID() == 12) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6] + amt;
	elseif (this:GetID() == 13) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7] - amt;
	elseif (this:GetID() == 14) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7] + amt;
	elseif (this:GetID() == 15) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8] - amt;
	elseif (this:GetID() == 16) then
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8] = 0;
		end
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8] = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8] + amt;
	end
	DART_Initialize_Texture(DART_TEXTURE_INDEX);
	DART_Update_Preview();
	DL_Init_EditBox(DART_MainTextureOptions_X1, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1]);
	DL_Init_EditBox(DART_MainTextureOptions_X2, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2]);
	DL_Init_EditBox(DART_MainTextureOptions_Y1, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3]);
	DL_Init_EditBox(DART_MainTextureOptions_Y2, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4]);
	DL_Init_EditBox(DART_MainTextureOptions_URx, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[5]);
	DL_Init_EditBox(DART_MainTextureOptions_URy, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[6]);
	DL_Init_EditBox(DART_MainTextureOptions_LRx, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[7]);
	DL_Init_EditBox(DART_MainTextureOptions_LRy, DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[8]);
end

function DART_TextureBrowser_OnClick(button)
	this:SetChecked(0);
	if (button == "RightButton" and (not IsShiftKeyDown())) then
		DART_STICKY_TEXTURE.file = DART_TEXTURES[this.textureindex].file;
		DART_STICKY_TEXTURE.x1 = DART_TEXTURES[this.textureindex].x1;
		DART_STICKY_TEXTURE.x2 = DART_TEXTURES[this.textureindex].x2;
		DART_STICKY_TEXTURE.y1 = DART_TEXTURES[this.textureindex].y1;
		DART_STICKY_TEXTURE.y2 = DART_TEXTURES[this.textureindex].y2;
		DART_STICKY_TEXTURE.height = DART_TEXTURES[this.textureindex].height;
		DART_STICKY_TEXTURE.width = DART_TEXTURES[this.textureindex].width;
		DART_TextureBrowser_UpdatePreview();
	elseif (button == "MiddleButton" or (button == "RightButton" and IsShiftKeyDown())) then
		if (not DART_TextureBrowser_CustomTab:GetChecked()) then return; end
		if (#DART_Settings.CustomTextures > 1) then
			local max = #DART_Settings.CustomTextures;
			DART_Settings.CustomTextures[this.textureindex] = {};
			for i=this.textureindex + 1, max do
				DL_Copy_Table(DART_Settings.CustomTextures[i], DART_Settings.CustomTextures[i - 1]);
				DART_Settings.CustomTextures[i] = {};
			end
			DART_Settings.CustomTextures[max] = nil;
		else
			DART_Settings.CustomTextures = {};
		end
		DART_TEXTURES = {};
		if (not DART_Settings.CustomTextures) then
			DART_Settings.CustomTextures = {};
		end
		DL_Copy_Table(DART_Settings.CustomTextures, DART_TEXTURES);
		DART_TextureBrowser_Update();
	else
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].texture = DART_TEXTURES[this.textureindex].file;
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1] = DART_TEXTURES[this.textureindex].x1;
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2] = DART_TEXTURES[this.textureindex].x2;
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3] = DART_TEXTURES[this.textureindex].y1;
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4] = DART_TEXTURES[this.textureindex].y2;
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].height = DART_TEXTURES[this.textureindex].height + DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].padding * 2;
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].width = DART_TEXTURES[this.textureindex].width + DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].padding * 2;

		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[1] = 0;
		end
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[2] = 1;
		end
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[3] = 0;
		end
		if (not DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4]) then
			DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].coords[4] = 1;
		end

		DART_TextureBrowser:Hide();
		DART_Initialize_Texture(DART_TEXTURE_INDEX);
		DART_Initialize_TextureOptions();
		DART_STICKY_TEXTURE = {file="", x1="0", x2="1", y1="0", y2="1", height="256", width="256"};
	end
end

function DART_TextureBrowser_OnEnter()
	DART_TextureBrowser_File:SetText(DART_TEXTURES[this.textureindex].file);
	DART_TextureBrowser_X1:SetText(DART_TEXTURES[this.textureindex].x1);
	DART_TextureBrowser_X2:SetText(DART_TEXTURES[this.textureindex].x2);
	DART_TextureBrowser_Y1:SetText(DART_TEXTURES[this.textureindex].y1);
	DART_TextureBrowser_Y2:SetText(DART_TEXTURES[this.textureindex].y2);
	DART_TextureBrowser_Height:SetText(DART_TEXTURES[this.textureindex].height);
	DART_TextureBrowser_Width:SetText(DART_TEXTURES[this.textureindex].width);
	GameTooltip:SetOwner(DART_TextureBrowser, "ANCHOR_TOPLEFT", 50);
	if (DART_TextureBrowser_CustomTab:GetChecked()) then
		GameTooltip:SetText(DART_TEXT.TextureTip..DART_TEXT.CustomTextureTip, 1, 1, 1, 1, 1);
	else
		GameTooltip:SetText(DART_TEXT.TextureTip, 1, 1, 1, 1, 1);
	end
end

function DART_TextureBrowser_OnLeave()
	DART_TextureBrowser_File:SetText(DART_STICKY_TEXTURE.file);
	DART_TextureBrowser_X1:SetText(DART_STICKY_TEXTURE.x1);
	DART_TextureBrowser_X2:SetText(DART_STICKY_TEXTURE.x2);
	DART_TextureBrowser_Y1:SetText(DART_STICKY_TEXTURE.y1);
	DART_TextureBrowser_Y2:SetText(DART_STICKY_TEXTURE.y2);
	DART_TextureBrowser_Height:SetText(DART_STICKY_TEXTURE.height);
	DART_TextureBrowser_Width:SetText(DART_STICKY_TEXTURE.width);
	GameTooltip:Hide();
end

function DART_TextureBrowser_Update()
	local numMacroIcons = #DART_TEXTURES;
	local macroPopupIcon, macroPopupButton;
	local macroPopupOffset = FauxScrollFrame_GetOffset(DART_TextureBrowser_ScrollFrame);
	if (not macroPopupOffset) then macroPopupOffset = 0; end
	local index;
	
	for i=1, 20 do
		macroPopupIcon = getglobal("DART_TextureBrowser_Button"..i.."Icon");
		macroPopupButton = getglobal("DART_TextureBrowser_Button"..i);
		index = (macroPopupOffset * 5) + i;
		if ( DART_TEXTURES[index] ) then
			macroPopupIcon:SetTexture(DART_TEXTURES[index].file);
			macroPopupIcon:SetTexCoord(DART_TEXTURES[index].x1, DART_TEXTURES[index].x2, DART_TEXTURES[index].y1, DART_TEXTURES[index].y2);
			macroPopupButton:Show();
			macroPopupButton.textureindex = index;
		else
			macroPopupIcon:SetTexture("");
			macroPopupButton:Hide();
			macroPopupButton.textureindex = nil;
		end
	end
	
	FauxScrollFrame_Update(DART_TextureBrowser_ScrollFrame, ceil(numMacroIcons / 5) , 4, 36 );
end

function DART_TextureBrowser_UpdatePreview()
	local texture = DART_STICKY_TEXTURE.file;
	if (not texture) then texture = ""; end
	if (not string.find(texture, "\\")) then
		texture = "Interface\\AddOns\\DiscordArt\\CustomTextures\\"..texture;
	end
	DART_TextureBrowser_PreviewTexture:SetTexture(texture);
	local height = tonumber(DART_STICKY_TEXTURE.height);
	if ((not height) or height <= 0 or height == "") then
		height = 30;
	end
	local width = tonumber(DART_STICKY_TEXTURE.width);
	if ((not width) or width <= 0 or width == "") then
		width = 30;
	end
	local x1 = tonumber(DART_STICKY_TEXTURE.x1);
	if ((not x1) or x1 == "") then
		x1 = 0;
	end
	local x2 = tonumber(DART_STICKY_TEXTURE.x2);
	if ((not x2) or x2 == "") then
		x2 = 1;
	end
	local y1 = tonumber(DART_STICKY_TEXTURE.y1);
	if ((not y1) or y1 == "") then
		y1 = 0;
	end
	local y2 = tonumber(DART_STICKY_TEXTURE.y2);
	if ((not y2) or y2 == "") then
		y2 = 1;
	end
	DART_TextureBrowser_PreviewTexture:SetTexCoord(x1, x2, y1, y2);
	DART_TextureBrowser_Preview:SetHeight(height + 10);
	DART_TextureBrowser_Preview:SetWidth(width + 10);
	DART_TextureBrowser:SetHeight(400 + height);
end

function DART_Update_FrameFinder()
	local obj = GetMouseFocus();
	local text = DART_TEXT.FrameFinder;
	if (obj and obj ~= WorldFrame and obj:GetName()) then
		text = text..obj:GetName();
		if (obj:GetParent()  and obj:GetParent() ~= WorldFrame and obj:GetParent():GetName() ) then
			text = text..DART_TEXT.Parent..obj:GetParent():GetName();
			if (obj:GetParent():GetParent() and obj:GetParent():GetParent() ~= WorldFrame and obj:GetParent():GetParent():GetName()) then
				text = text..DART_TEXT.ParentsParent..obj:GetParent():GetParent():GetName();
			end
		end
	end
	if ((not string.find(text, "DART_Options")) and (not string.find(text, "DART_MiscOptions")) and (not string.find(text, "DART_TextureOptions")) and (not string.find(text, "DART_TextOptions")) and (not string.find(text, "DART_TextureBrowser")) and (not string.find(text, "DART_DropMenu")) and (not string.find(text, "DART_ScriptOptions")) and (not string.find(text, "DART_BaseOptions")) and (not string.find(text, "DART_ControlOptions"))) then
		DART_Options_FrameFinder_Text:SetText(text);
	else
		DART_Options_FrameFinder_Text:SetText(DART_TEXT.FrameFinder);
	end
end

function DART_Update_Preview()
	local settings = DART_Settings[DART_INDEX][DART_TEXTURE_INDEX];
	DART_MainTextureOptions_Texture_Texture:SetTexture(settings.texture);
	if (settings.coords[5] and settings.coords[6] and settings.coords[7] and settings.coords[8]) then
		DART_MainTextureOptions_Texture_Texture:SetTexCoord(settings.coords[1], settings.coords[2], settings.coords[3], settings.coords[4], settings.coords[5], settings.coords[6], settings.coords[7], settings.coords[8]);
	else
		DART_MainTextureOptions_Texture_Texture:SetTexCoord(settings.coords[1], settings.coords[2], settings.coords[3], settings.coords[4]);
	end
	DART_MainTextureOptions_Texture:SetBackdrop({bgFile = settings.bgtexture, edgeFile = settings.bordertexture, tile = settings.Backdrop.tile, tileSize = settings.Backdrop.tileSize, edgeSize = settings.Backdrop.edgeSize, insets = { left = settings.Backdrop.left, right = settings.Backdrop.right, top = settings.Backdrop.top, bottom = settings.Backdrop.bottom }});
	DART_MainTextureOptions_Texture:SetBackdropColor(settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	DART_MainTextureOptions_Texture:SetBackdropBorderColor(settings.bordercolor.r, settings.bordercolor.g, settings.bordercolor.b, settings.borderalpha);
		DART_MainTextureOptions_Texture_Texture:SetVertexColor(settings.color.r, settings.color.g, settings.color.b);
	DART_MainTextureOptions_Texture_Texture:SetAlpha(settings.alpha);
	DART_MainTextureOptions_Texture_Texture:ClearAllPoints();
	DART_MainTextureOptions_Texture_Texture:SetPoint("TOPLEFT", "DART_MainTextureOptions_Texture", "TOPLEFT", settings.padding, -settings.padding);
	DART_MainTextureOptions_Texture_Texture:SetPoint("BOTTOMRIGHT", "DART_MainTextureOptions_Texture", "BOTTOMRIGHT", -settings.padding, settings.padding);
	if (settings.hidebg) then
		DART_MainTextureOptions_Texture:SetBackdropColor(0, 0, 0, 0);
		DART_MainTextureOptions_Texture:SetBackdropBorderColor(0, 0, 0, 0);
	end
end

function DART_Update_Script()
	local scrollBar = getglobal(this:GetParent():GetName().."ScrollBar")
	this:GetParent():UpdateScrollChildRect();
	local min;
	local max;
	min, max = scrollBar:GetMinMaxValues();
	if ( max > 0 and (this.max ~= max) ) then
		this.max = max;
		scrollBar:SetValue(max);
	end
	if (DART_SCRIPT_INDEX) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX].scripts[DART_SCRIPT_INDEX] = this:GetText();
		if (this:GetText() and this:GetText() ~= "") then
			getglobal("DART_ScriptOptions_"..DART_SCRIPT_LABEL[DART_SCRIPT_INDEX]):SetText(DART_SCRIPT_LABEL[DART_SCRIPT_INDEX].." *");
		else
			getglobal("DART_ScriptOptions_"..DART_SCRIPT_LABEL[DART_SCRIPT_INDEX]):SetText(DART_SCRIPT_LABEL[DART_SCRIPT_INDEX]);
		end
	end
end

function DART_Update_Setting(value, index, subindex)
	if (index == "CONDITION") then
		DART_CONDITION_BUFFER[subindex] = value;
	elseif (this.index == "CONDITION") then
		DART_CONDITION_BUFFER[this.subindex] = value;
	elseif (subindex) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX][index][subindex] = value;
	elseif (index) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX][index] = value;
	elseif (this.miscindex) then
		DART_Settings[DART_INDEX][this.miscindex] = value;
	elseif (this.subindex) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX][this.index][this.subindex] = value;
	elseif (this.index) then
		DART_Settings[DART_INDEX][DART_TEXTURE_INDEX][this.index] = value;
	end
end

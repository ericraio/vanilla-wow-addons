function DFM_Add_LoDFunc()
	DFM_LoDFrame_Func:ClearFocus();
	local func = DFM_LoDFrame_Func:GetText();
	if (not getglobal(func)) then return; end
	tinsert(DFM_Settings.LoadOnDemandFunctions, func);
	DFM_LoDMenu_Update();
	RunScript(string.gsub(DFM_LODHOOKFUNC, "$f", func));
	DL_Hook(func, "DFM");
end

function DFM_AddNewFrame()
	local frame = DFM_Options_AddFrame:GetText();
	local name = DFM_Options_AddName:GetText();
	if (name == "") then name = nil; end
	local header = DFM_Options_AddHeader:GetText();
	if (header == "") then header = nil; end
	local children = DFM_Options_AddChildren:GetChecked();
	local updateFlag;
	if (DFM_SELECTED_INDEX and frame == DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame) then
		updateFlag = 1;
	end
	DFM_Add_Frame(frame, name, header, children, nil, updateFlag);
	DFM_Options_AddFrame:SetText("");
	DFM_Options_AddName:SetText("");
	DFM_Options_AddHeader:SetText("");
	DFM_Options_AddFrame:ClearFocus();
	DFM_Options_AddName:ClearFocus();
	DFM_Options_AddHeader:ClearFocus();
	DFM_Options_AddChildren:SetChecked(0);
end

function DFM_CheckBox_OnClick()
	local value;
	if (this:GetChecked()) then
		value = 1;
	end
	DFM_Update_Setting(this:GetParent().index, value);
end

function DFM_ColorPicker_OnClick()
	local basecolor = DFM_Get_Setting(this:GetParent().index);
	if (not basecolor) then return; end
	local color = {};
	color.r = basecolor.r;
	color.g = basecolor.g;
	color.b = basecolor.b;
	ColorPickerFrame.hasOpacity = nil;
	ColorPickerFrame.previousValues = color;
	ColorPickerFrame.cancelFunc = DFM_ColorPicker_ColorCancelled;
	ColorPickerFrame.opacityFunc = DFM_ColorPicker_ColorChanged;
	ColorPickerFrame.func = DFM_ColorPicker_ColorChanged;
	ColorPickerFrame.colorBox = this:GetName();
	ColorPickerFrame.index = this:GetParent().index;
	ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
	ColorPickerFrame:ClearAllPoints();
	if (DFM_Options:GetRight() < UIParent:GetWidth() / 2) then
		ColorPickerFrame:SetPoint("LEFT", "DFM_Options", "RIGHT", 10, 0);
	else
		ColorPickerFrame:SetPoint("RIGHT", "DFM_Options", "LEFT", -10, 0);
	end
	ColorPickerFrame:Show();
end

function DFM_ColorPicker_ColorCancelled()
	local color = ColorPickerFrame.previousValues;
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	DFM_Update_Setting(ColorPickerFrame.index, color);
end

function DFM_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local color = { r=r, g=g, b=b };
	getglobal(ColorPickerFrame.colorBox):SetBackdropColor(color.r, color.g, color.b);
	DFM_Update_Setting(ColorPickerFrame.index, color);
end

function DFM_Copy_Settings()
	if (not DFM_SELECTED_INDEX) then return; end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	DFM_BUFFER = {};
	DL_Copy_Table(DFM_Settings[DFM_INDEX][header][frame], DFM_BUFFER);
end

function DFM_Create_NewFrame()
	local frameType = DFM_CreateFrameForm_FrameType_Setting:GetText();
	local frame = DFM_CreateFrameForm_AddFrame:GetText();
	local name = DFM_CreateFrameForm_AddName:GetText();
	local header = DFM_CreateFrameForm_AddHeader:GetText();
	if (header == "" or (not header)) then
		header = DFM_TEXT.UserAdded;
	end
	if (name == "" or (not name)) then
		name = frame;
	end
	DFM_Add_Frame(frame, name, header, nil, 1, nil, 1);
	DFM_Settings[DFM_INDEX][header][frame].customFrame = 1;
	DFM_Settings[DFM_INDEX][header][frame].frameType = frameType;
	DFM_Initialize_Frame(header, frame);
	DFM_CreateFrameForm_FrameType_Setting:SetText("Frame");
	DFM_CreateFrameForm_AddFrame:SetText("");
	DFM_CreateFrameForm_AddName:SetText("");
	DFM_CreateFrameForm_AddHeader:SetText("");
	DFM_Update_FrameList();
	DFM_FrameMenu_Update();
	DL_Feedback("Custom frame named "..name.." created beneath the "..header.." header.");
end

function DFM_Delete_LoDFunc()
	local index = this:GetParent().index;
	local func = DFM_Settings.LoadOnDemandFunctions[index];
	table.remove(DFM_Settings.LoadOnDemandFunctions, index);
	DFM_LoDMenu_Update();
	local oldFunc = getglobal("DFM_Old_"..func);
	func = getglobal(func);
	func = oldFunc;
	oldFunc = nil;
end

function DFM_Delete_Profile(index)
	if (not index) then
		if (DFM_Options) then
			index = DFM_Options_LoadProfile_Setting:GetText();
			if (not index or index == "") then return; end
		else
			return;
		end
	end
	if (index == "Default") then
		DL_Error("You cannot delete the Default profile.");
		return;
	elseif (index == DFM_INDEX) then
		DL_Error("You cannot delete the profile you're currently using.");
		return;
	end
	DFM_Settings[index] = nil;
	DFM_Update_Profiles();
	DFM_Options_LoadProfile_Setting:SetText("");
end

function DFM_DropMenu_OnClick()
	if (DFM_DropMenu.controlbox) then
		getglobal(DFM_DropMenu.controlbox):SetText(getglobal(this:GetName().."_Text"):GetText());
	end
	DFM_DropMenu:Hide();
	if (DFM_DropMenu.index == "point" or DFM_DropMenu.index == "to") then
		local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
		local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
		if (not DFM_Settings[DFM_INDEX][header][frame].Location) then return; end
		DFM_Settings[DFM_INDEX][header][frame].Location[DFM_DropMenu.index] = this.value;
		DFM_Initialize_FrameLocation(header, frame);
	elseif (DFM_DropMenu.index == "headeroption") then
		DFM_Settings[DFM_INDEX][DFM_FRAME_LIST[DFM_DropMenu.subindex].text] = nil;
		DFM_SELECTED_INDEX = nil;
		DFM_OPTIONS_LIST = {};
		DFM_Update_FrameList();
		DFM_FrameMenu_Update();
		DFM_OptionsMenu_Update();
		DFM_ReloadUIFrame:Show();
	elseif (DFM_DropMenu.index == "FRAMETYPE") then
		return;
	elseif (DFM_DropMenu.index ~= "profile") then
		DFM_Update_Setting(DFM_DropMenu.index, this.value);
	end
end

function DFM_EditBox_OnEnterPressed(scrollMenu)
	local value;
	if (this.number) then
		value = this:GetNumber();
		if (not value) then
			value = 0;
		end
	else
		value = this:GetText();
		if (not value) then
			value = "";
		end
	end
	this:ClearFocus();
	this.prevvalue = value;
	if (scrollMenu) then
		DFM_Update_Setting(this:GetParent():GetParent().index, value);
	else
		DFM_Update_Setting(this:GetParent().index, value);
	end
end

function DFM_FrameFinder_OnUpdate()
	local obj = GetMouseFocus();
	local name;
	if (obj and obj.GetName) then
		name = obj:GetName();
	end
	if (this.currentframe ~= name) then
		this.currentframe = name;
		DFM_FrameFinder_Update(obj);
	end
end

function DFM_FrameFinder_Update(frame, setlock)
	if (DFM_FINDER_LOCKED and (not setlock)) then return; end
	if (setlock) then
		DFM_FINDER_LOCKED = true;
		DFM_FrameFinder_LockText:SetText(DFM_TEXT.Locked);
	end
	if (frame) then
		local text = DFM_TEXT.MouseIsOver;
		if (frame.GetName and frame:GetName()) then
			text = text..frame:GetName();
		else
			text = text..DFM_TEXT.UnnamedFrame;
		end
		if (frame.GetParent and frame:GetParent() and frame:GetParent().GetName and frame:GetParent():GetName()) then
			text = text..DFM_TEXT.FrameParent..frame:GetParent():GetName();
			if (frame:GetParent().GetParent and frame:GetParent():GetParent() and frame:GetParent():GetParent().GetName and frame:GetParent():GetParent():GetName()) then
				text = text..DFM_TEXT.FrameParentParent..frame:GetParent():GetParent():GetName();
			end
		end
		if (frame.GetChildren) then
			local children = {frame:GetChildren()};
			if (children) then
				text = text..DFM_TEXT.Children;
				for _, child in children do
					if (child.GetName and child:GetName()) then
						text = text..child:GetName().."\n";
					end
				end
			end
		end
		if (frame.GetRegions) then
			local children = {frame:GetRegions()};
			if (children) then
				text = text..DFM_TEXT.Regions;
				for _, child in children do
					if (child.GetName and child:GetName()) then
						text = text..child:GetName().."\n";
					end
				end
			end
		end
		DFM_FrameFinder_ScrollFrame_Text:SetText(text);
	else
		DFM_FrameFinder_ScrollFrame_Text:SetText("");
	end
end

function DFM_FrameMenu_OnClick()
	DFM_DropMenu:Hide();
	DFM_ScrollMenu:Hide();
	for i=1,14 do
		button = getglobal("DFM_Options_FrameMenu_Button"..i);
		buttontext = getglobal("DFM_Options_FrameMenu_Button"..i.."Text");
		if (button:GetID() == this:GetID()) then
			button:SetChecked(1);
			buttontext:SetTextColor(1, 0, 0);
			buttontext:SetFont("Fonts\\FRIZQT__.TTF", 12);
		elseif (button.headerFlag) then
			button:SetChecked(0);
			buttontext:SetTextColor(1, .82, 0);
			buttontext:SetFont("Fonts\\MORPHEUS.ttf", 13);
		else
			button:SetChecked(0);
			if (DFM_FRAME_LIST[button.index] and DFM_FRAME_LIST[button.index].modified) then
				buttontext:SetTextColor(0, 1, 1);
			else
				buttontext:SetTextColor(1, 1, 1);
			end
			buttontext:SetFont("Fonts\\ARIALN.TTF", 12);
		end
	end
	if (arg1 == "RightButton") then
		DFM_FrameMenu_Update();
		local oldIndex = this.index;
		if (this.headerFlag) then
			this.table = "DFM_HEADER_OPTIONS";
			this.menu = "DFM_DropMenu";
			this.subindex = this.index;
			this.index = "headeroption";
		else
			this.table = "DFM_HEADERS_LIST";
			this.menu = "DFM_ScrollMenu";
			this.index = "scrolltoheader";
		end
		this:SetChecked(0);
		DL_Show_Menu();
		DFM_DropMenu.controlbox = nil;
		this.index = oldIndex;
	elseif (this.headerFlag) then
		this:SetChecked(0);
		getglobal(this:GetName().."Text"):SetTextColor(1, .82, 0);
		getglobal(this:GetName().."Text"):SetFont("Fonts\\MORPHEUS.ttf", 13);
		return;
	elseif (IsShiftKeyDown()) then
		DFM_FrameFinder:Show();
		DFM_FrameFinder_Update(getglobal(DFM_FRAME_LIST[this.index].frame), 1);
		DFM_FrameMenu_Update();
	else
		DFM_SELECTED_INDEX = this.index;
		DFM_Options_AddFrame:SetText(DFM_FRAME_LIST[this.index].frame);
		DFM_Options_AddName:SetText(DFM_FRAME_LIST[this.index].text);
		DFM_Options_AddHeader:SetText(DFM_FRAME_LIST[this.index].header);
		DFM_Options_AddChildren:SetChecked(0);
		DFM_Update_OptionsList();
	end
end

function DFM_FrameMenu_Update()
	local numOptions = table.getn(DFM_FRAME_LIST);
	local offset = FauxScrollFrame_GetOffset(DFM_Options_FrameMenu);
	if (not offset) then
		offset = 0;
	end
	local index, button;
	
	for i=1, 14 do
		button = getglobal("DFM_Options_FrameMenu_Button"..i);
		buttontext = getglobal("DFM_Options_FrameMenu_Button"..i.."Text");
		index = offset + i;
		button.index = index;
		button.desc = nil;
		button.headerFlag = nil;
		if ( DFM_FRAME_LIST[index] ) then
			buttontext:SetText(DFM_FRAME_LIST[index].text);
			buttontext:SetJustifyH("LEFT");
			button:Show();
			if (DFM_FRAME_LIST[index].headerFlag) then
				buttontext:SetJustifyH("CENTER");
				button:SetChecked(0);
				buttontext:SetTextColor(1, .82, 0);
				buttontext:SetFont("Fonts\\MORPHEUS.ttf", 13);
				button.headerFlag = true;
			elseif (DFM_SELECTED_INDEX == button.index) then
				button:SetChecked(1);
				buttontext:SetTextColor(1, 0, 0);
				buttontext:SetFont("Fonts\\FRIZQT__.TTF", 12);
				button.desc = DFM_FRAME_LIST[index].frame;
				if (string.len(button.desc) > 23) then
					button.desc = string.sub(button.desc, 1, 23).."\n"..string.sub(button.desc, 24);
				end
				button.desc = button.desc.."\n"..DFM_TEXT.Type..DFM_FRAME_LIST[index].frameType;
			else
				button:SetChecked(0);
				if (DFM_FRAME_LIST[index].modified) then
					buttontext:SetTextColor(0, 1, 1);
				else
					buttontext:SetTextColor(1, 1, 1);
				end
				buttontext:SetFont("Fonts\\ARIALN.TTF", 12);
				button.desc = DFM_FRAME_LIST[index].frame;
				if (string.len(button.desc) > 23) then
					button.desc = string.sub(button.desc, 1, 23).."\n"..string.sub(button.desc, 24);
				end
				button.desc = button.desc.."\n"..DFM_TEXT.Type..DFM_FRAME_LIST[index].frameType;
			end
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DFM_Options_FrameMenu, numOptions, 14, 20 );
	DFM_Options_FrameMenu:Show();
end

function DFM_Get_LocSettings(header, frame)
	if (DFM_Settings[DFM_INDEX][header][frame].Location) then
		return DFM_Settings[DFM_INDEX][header][frame].Location;
	else
		frame = getglobal(frame);
		if (frame.GetNumPoints and frame:GetNumPoints()) then
			local point, relativeObject, relativePoint, x, y = frame:GetPoint(1);
			if (not relativeObject) then
				relativeObject = UIParent;
			end
			return {frame=relativeObject:GetName(), point=point, to=relativePoint, x=DL_round(x, 1), y=DL_round(y, 1)};
		else
			local x, y;
			if (frame.GetCenter) then
				x, y = DL_Get_Offsets(getglobal(frame), UIParent, "CENTER", "CENTER");
			end
			if (not x) then x=0; end
			if (not y) then y=0; end
			x = DL_round(x, 1);
			y = DL_round(y, 1);
			return {frame="UIParent", point="CENTER", to="CENTER", x=x, y=y};
		end
	end
end

function DFM_Get_MethodSetting(method, index)
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (DFM_Settings[DFM_INDEX][header][frame]) then
		if (DFM_Settings[DFM_INDEX][header][frame][method]) then
			return DFM_Settings[DFM_INDEX][header][frame][method][index];
		end
	end
end

function DFM_Get_Setting(index)
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	local method = DFM_OPTIONS_LIST[index].method;
	local param = DFM_OPTIONS_LIST[index].param;
	if (DFM_Settings[DFM_INDEX][header][frame]) then
		if (index == 1) then
			return DFM_Settings[DFM_INDEX][header][frame].forceHide;
		elseif (DFM_Settings[DFM_INDEX][header][frame][method]) then
			return DFM_Settings[DFM_INDEX][header][frame][method][param];
		end
	end
end

function DFM_Init_Settings(method)
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (not DFM_Settings[DFM_INDEX][header][frame][method]) then
		DFM_Settings[DFM_INDEX][header][frame][method] = {};
	end
	for param,value in DFM_METHODS_LIST[method].options do
		if (not DFM_Settings[DFM_INDEX][header][frame][method][param]) then
			DFM_Settings[DFM_INDEX][header][frame][method][param] = value.default;
		end
	end
end

function DFM_LockCheckBox_OnClick()
	if (this:GetChecked()) then
		DFM_Update_MethodSetting(this.method, "lock", 1);
	else
		DFM_Update_MethodSetting(this.method, "lock");
		DFM_ReloadUIFrame:Show();
	end
end

function DFM_LockLocationCheckBox_OnClick()
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (this:GetChecked()) then
		if (not DFM_Settings[DFM_INDEX][header][frame].Location) then
			DFM_Settings[DFM_INDEX][header][frame].Location = DFM_Get_LocSettings(header, frame);
		end
		DFM_Settings[DFM_INDEX][header][frame].Location.lock = 1;
	else
		DFM_Settings[DFM_INDEX][header][frame].Location.lock = nil;
	end
	DFM_Initialize_FrameLocation(header, frame);
end

function DFM_LoDMenu_Update()
	local numOptions = table.getn(DFM_Settings.LoadOnDemandFunctions);
	local offset = FauxScrollFrame_GetOffset(DFM_LoDFrame_Menu);
	local index, button;
	
	for i=1, 7 do
		button = getglobal("DFM_LoDFrame_Menu_Button"..i);
		buttontext = getglobal("DFM_LoDFrame_Menu_Button"..i.."_Text");
		index = offset + i;
		button.index = index;
		if ( DFM_Settings.LoadOnDemandFunctions[index] ) then
			buttontext:SetText(DFM_Settings.LoadOnDemandFunctions[index]);
			button:Show();
		else
			button:Hide();
		end
	end
	
	FauxScrollFrame_Update(DFM_LoDFrame_Menu, numOptions, 7, 20 );
end

function DFM_MinusButton_OnClick()
	local value = this:GetParent():GetNumber();
	if (not value) then
		value = 0;
	end
	value = value - 1;
	this:GetParent():SetText(value);
	DFM_Update_Setting(this:GetParent():GetParent().index, value);
end

function DFM_Nudge(button, dragframe)
	if (not DFM_SELECTED_INDEX) then return; end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (not DFM_Settings[DFM_INDEX][header][frame].Location) then return; end
	if (not DFM_Settings[DFM_INDEX][header][frame].Location.use) then return; end
	local dir = this:GetID();
	local amt = 1;
	if (button == "RightButton") then
		amt = 10;
	elseif (button == "MiddleButton") then
		amt = 3;
	end
	local x = DFM_Settings[DFM_INDEX][header][frame].Location.x;
	local y = DFM_Settings[DFM_INDEX][header][frame].Location.y;
	if (dir == 0) then
		DFM_Options_XOffset:SetText(0);
		DFM_Options_YOffset:SetText(0);
		x = 0;
		y = 0;
	elseif (dir == 1) then
		getglobal(this.updateFrame):SetText(y + amt);
		y = y + amt;
	elseif (dir == 2) then
		getglobal(this.updateFrame):SetText(y - amt);
		y = y - amt;
	elseif (dir == 3) then
		getglobal(this.updateFrame):SetText(x - amt);
		x = x - amt;
	elseif (dir == 4) then
		getglobal(this.updateFrame):SetText(x + amt);
		x = x + amt;
	end
	DFM_Settings[DFM_INDEX][header][frame].Location.x = x;
	DFM_Settings[DFM_INDEX][header][frame].Location.y = y;
	DFM_Initialize_FrameLocation(header, frame);
	if (dragframe or DFM_DRAG_INDEX == DFM_SELECTED_INDEX) then
		DFM_Summon_DragFrame(1);
	end
end

function DFM_Nudge_OnUpdate(elapsed)
	if (not DFM_SELECTED_INDEX) then return; end
	if (not this.timer) then
		this.timer = 1 / 30;
	end
	if (this.movingframe) then
		this.timer = this.timer - elapsed;
		if (this.timer < 0) then
			this.timer = 1 / 30;
			DFM_Nudge("MiddleButton");
		end
	end
end

function DFM_OptionsMenu_OnClick()
	DFM_DropMenu:Hide();
	DFM_ScrollMenu:Hide();
end

function DFM_OptionsMenu_Update()
	DFM_DropMenu:Hide();
	DFM_ScrollMenu:Hide();
	local numOptions = table.getn(DFM_OPTIONS_LIST);
	local offset = FauxScrollFrame_GetOffset(DFM_Options_OptionsMenu);
	if (not offset) then
		offset = 0;
	end
	local index, button, buttonName, border, lockButton, useButton;
	
	for i=1, 7 do
		buttonName = "DFM_Options_OptionsMenu_Button"..i;
		button = getglobal(buttonName);
		border = getglobal(buttonName.."_Border");
		lockButton = getglobal(buttonName.."_Lock");
		useButton = getglobal(buttonName.."_Use");
		helpButton = getglobal(buttonName.."_Help");
		buttontext = getglobal("DFM_Options_OptionsMenu_Button"..i.."_Text");
		index = offset + i;
		button.index = index;
		button.help = nil;

		if ( DFM_OPTIONS_LIST[index] ) then
			button:Show();
			buttontext:SetText(DFM_TEXT[DFM_OPTIONS_LIST[index].name]);
			button.help = DFM_OPTIONS_LIST[index].help;

			for j=1,7 do
				getglobal(buttonName.."_"..j):Hide();
			end
			local option = getglobal(buttonName.."_"..DFM_OPTIONS_LIST[index].option);
			option:Show();
			local offset = buttontext:GetStringWidth() + 9;
			buttontext:ClearAllPoints();
			if (option.dynamicPosition) then
				buttontext:SetPoint("LEFT", button, "LEFT", 0, 0);
				option:ClearAllPoints();
				option:SetPoint("LEFT", button, "LEFT", offset + option.dynamicPosition, 0);
			else
				buttontext:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0);
			end

			local setting = DFM_Get_Setting(index);
			if (not setting) then
				local frame = getglobal(DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame);
				if (DFM_OPTIONS_LIST[index].name == "TextAlpha" and frame.GetTextColor) then
					_, _, _, setting = frame:GetTextColor();
				elseif (DFM_OPTIONS_LIST[index].name == "TextureAlpha") then
					if (frame.GetVertexColor) then
						_, _, _, setting = frame:GetVertexColor();
					else
						setting = 1;
					end
				elseif (DFM_OPTIONS_LIST[index].name == "ShadowAlpha") then
					_, _, _, setting = frame:GetShadowColor();
				elseif (DFM_OPTIONS_LIST[index].name == "ShadowOffsetX") then
					setting = frame:GetShadowOffset();
				elseif (DFM_OPTIONS_LIST[index].name == "ShadowOffsetY") then
					_, setting = frame:GetShadowOffset();
				elseif (DFM_OPTIONS_LIST[index].detection and string.find(DFM_OPTIONS_LIST[index].detection, "FontObject")) then
					if (frame[DFM_OPTIONS_LIST[index].detection] and frame[DFM_OPTIONS_LIST[index].detection](frame) and frame[DFM_OPTIONS_LIST[index].detection](frame).GetName and frame[DFM_OPTIONS_LIST[index].detection](frame):GetName()) then
						setting = frame[DFM_OPTIONS_LIST[index].detection](frame):GetName();
					else
						setting = "";
					end
				elseif (DFM_OPTIONS_LIST[index].detection == "GetScrollChild" and frame.GetScrollChild and frame:GetScrollChild() and frame:GetScrollChild().GetName and frame:GetScrollChild():GetName()) then
					setting = frame:GetScrollChild():GetName();
				elseif (DFM_OPTIONS_LIST[index].detection and string.find(DFM_OPTIONS_LIST[index].detection, "Color") and frame[DFM_OPTIONS_LIST[index].detection]) then
					setting = {};
					setting.r, setting.g, setting.b = frame[DFM_OPTIONS_LIST[index].detection](frame);
				elseif (DFM_OPTIONS_LIST[index].detection == "GetParent" and frame.GetParent and frame:GetParent() and  frame:GetParent().GetName and frame:GetParent():GetName()) then
					setting = frame:GetParent():GetName();
				elseif (DFM_OPTIONS_LIST[index].detection == "GetFont") then
					local font, fontHeight = frame:GetFont();
					if (font and DFM_OPTIONS_LIST[index].option == 3) then
						setting = font;
					elseif (fontHeight and DFM_OPTIONS_LIST[index].option == 4) then
						setting = fontHeight;
					else
						setting = DFM_OPTIONS_LIST[index].default;
					end
				elseif (DFM_OPTIONS_LIST[index].detection and frame[DFM_OPTIONS_LIST[index].detection]) then
					setting = frame[DFM_OPTIONS_LIST[index].detection](frame);
				else
					setting = DFM_OPTIONS_LIST[index].default;
				end
			end

			if (DFM_OPTIONS_LIST[index].scale) then
				setting = setting * DFM_OPTIONS_LIST[index].scale;
			end
			if (type(setting) == "number") then
				setting = DL_round(setting, 1);
			end

			if (DFM_OPTIONS_LIST[index].option == 1 or DFM_OPTIONS_LIST[index].option == 7) then
				DL_Init_EditBox(option, setting);
			elseif (DFM_OPTIONS_LIST[index].option == 2) then
				option.menu = "DFM_DropMenu";
				option.table = DFM_OPTIONS_LIST[index].table;
				option.index = index;
				DL_Init_MenuControl(option, setting);
			elseif (DFM_OPTIONS_LIST[index].option == 3) then
				option.menu = "DFM_ScrollMenu";
				option.table = DFM_OPTIONS_LIST[index].table;
				option.index = index;
				DL_Init_MenuControl(option, setting, 1);
			elseif (DFM_OPTIONS_LIST[index].option == 4) then
				option:SetMinMaxValues(DFM_OPTIONS_LIST[index].min, DFM_OPTIONS_LIST[index].max);
				getglobal(option:GetName().."Low"):SetText(DFM_OPTIONS_LIST[index].min);
				getglobal(option:GetName().."High"):SetText(DFM_OPTIONS_LIST[index].max);
				option:SetValue(setting);
				getglobal(option:GetName().."_Display"):SetText(setting);
			elseif (DFM_OPTIONS_LIST[index].option == 5) then
				DL_Init_CheckBox(option, setting);
			elseif (DFM_OPTIONS_LIST[index].option == 6) then
				DL_Init_ColorPicker(option, setting);
			end

			if (DFM_OPTIONS_LIST[index + 1] and DFM_OPTIONS_LIST[index + 1].method == DFM_OPTIONS_LIST[index].method) then
				border:Hide();
			else
				border:Show();
			end

			if (index == 1 or DFM_OPTIONS_LIST[index - 1].method == DFM_OPTIONS_LIST[index].method) then
				useButton:Hide();
				lockButton:Hide();
				if (index == 1) then
					helpButton:Show();
				else
					helpButton:Hide();
				end
			else
				useButton.method = DFM_OPTIONS_LIST[index].method;
				lockButton.method = DFM_OPTIONS_LIST[index].method;
				useButton:Show();
				lockButton:Show();
				helpButton:Show();
				DL_Init_CheckBox(useButton, DFM_Get_MethodSetting(useButton.method, "use"));
				DL_Init_CheckBox(lockButton, DFM_Get_MethodSetting(lockButton.method, "lock"));
			end
			if (not button.help) then
				helpButton:Hide();
			end
		else
			button:Hide();
		end
	end

	FauxScrollFrame_Update(DFM_Options_OptionsMenu, numOptions, 7, 40);
	DFM_Options_OptionsMenu:Show();
end

function DFM_Paste_Settings()
	if (not DFM_BUFFER) then return; end
	local buffer = {};
	DL_Copy_Table(DFM_BUFFER, buffer);
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frameName = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	local frame = getglobal(frameName);
	for method in buffer do
		if (tonumber(method)) then
			local m = DFM_METHODS_LIST[method].method;
			if (not frame[m]) then
				buffer[method] = nil;
			end
		end
	end
	local oldName = DFM_Settings[DFM_INDEX][header][frameName].name;
	DFM_Settings[DFM_INDEX][header][frameName] = {};
	DL_Copy_Table(buffer, DFM_Settings[DFM_INDEX][header][frameName]);
	DFM_Settings[DFM_INDEX][header][frameName].name = oldName;
	DFM_Initialize_Frame(header, frameName);
	DFM_OptionsMenu_Update();
	DFM_Update_LocationSettings();
	DFM_ReloadUIFrame:Show();
end

function DFM_PlusButton_OnClick()
	local value = this:GetParent():GetNumber();
	if (not value) then
		value = 0;
	end
	value = value + 1;
	this:GetParent():SetText(value);
	DFM_Update_Setting(this:GetParent():GetParent().index, value);
end

function DFM_Remove_Frame()
	if (not DFM_SELECTED_INDEX) then return; end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (DFM_Settings[DFM_INDEX][header][frame].customFrame) then
		local f = getglobal(frame);
		f:Hide();
		f.Show = function() end;
		if (f.UnregisterAllEvents) then
			f:UnregisterAllEvents();
		end
	end
	DFM_Settings[DFM_INDEX][header][frame] = nil;
	DFM_SELECTED_INDEX = nil;
	DFM_OPTIONS_LIST = {};
	DFM_Update_FrameList();
	DFM_FrameMenu_Update();
	DFM_OptionsMenu_Update();
	DFM_ReloadUIFrame:Show();
end

function DFM_Reset_Frame()
	if (not DFM_SELECTED_INDEX) then return; end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	local oldName = DFM_Settings[DFM_INDEX][header][frame].name;
	DFM_Settings[DFM_INDEX][header][frame] = {name=oldName};
	DFM_OptionsMenu_Update();
	DFM_Update_LocationSettings();
	DFM_ReloadUIFrame:Show();
end

function DFM_ScrollMenu_OnClick()
	this:GetParent():Hide();
	if (DFM_ScrollMenu.index == "scrolltoheader") then
		DFM_Options_FrameMenuScrollBar:SetValue(20 * (this.value - 1));
	else
		local text = "";
		local list = getglobal(DFM_ScrollMenu.table);
		for _, value in list do
			if (value.value == this.value) then
				text = value.text;
			end
		end
		getglobal(DFM_ScrollMenu.controlbox):SetText(text);
		DFM_Update_Setting(DFM_ScrollMenu.index, this.value);
	end
end

function DFM_ScrollMenu_Update()
	local list = getglobal(this:GetParent().table);
	if (not list) then return; end
	local numOptions = table.getn(list);
	local offset = FauxScrollFrame_GetOffset(DFM_ScrollMenu_ScrollFrame);
	if (not offset) then offset = 0; end
	local index, button;
	
	for i=1, 10 do
		button = getglobal("DFM_ScrollMenu_Button"..i);
		buttontext = getglobal("DFM_ScrollMenu_Button"..i.."Text");
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
	
	FauxScrollFrame_Update(DFM_ScrollMenu_ScrollFrame, numOptions, 10, 20 );
end

function DFM_Slider_OnValueChanged()
	if (not DFM_INITIALIZED) then return; end
	local optionIndex = this:GetParent().index;
	local setting = DFM_Get_Setting(optionIndex);
	if (not setting) then return; end
	if (DFM_OPTIONS_LIST[optionIndex].scale) then
		setting = setting * DFM_OPTIONS_LIST[optionIndex].scale;
	end
	if (setting == this:GetValue()) then return; end
	local min, max = this:GetMinMaxValues();
	if (setting < min or setting > max) then
		return;
	end
	local value = this:GetValue();
	value = DL_round(value, 2);
	getglobal(this:GetName().."_Display"):SetText(value);
	if (DFM_OPTIONS_LIST[optionIndex].scale) then
		value = value / DFM_OPTIONS_LIST[optionIndex].scale;
	end
	DFM_Update_Setting(optionIndex, value);
end

function DFM_SliderEditBox_OnEnterPressed()
	local value = this:GetNumber();
	local optionIndex = this:GetParent():GetParent().index;
	if (not value) then value = 0; end
	local min, max = this:GetParent():GetMinMaxValues();
	if (this:GetParent().minlocked and value < min) then value = min; end
	if (this:GetParent().maxlocked and value > max) then value = max; end
	this:SetText(value);
	if (value >= min and value <= max) then
		this:GetParent():SetValue(value);
	end
	this:ClearFocus();
	if (DFM_OPTIONS_LIST[optionIndex].scale) then
		value = value / DFM_OPTIONS_LIST[optionIndex].scale;
	end
	DFM_Update_Setting(optionIndex, value);
end

function DFM_Start_Dragging()
	local frame = getglobal(DFM_DragFrame.frameindex);
	if (not frame) then return; end
	frame:ClearAllPoints();
	if (frame.DFM_SetPoint) then
		frame:DFM_SetPoint("CENTER", this, "CENTER", 0, 0);
	else
		frame:SetPoint("CENTER", this, "CENTER", 0, 0);
	end
	this:StartMoving();
end

function DFM_Stop_Dragging()
	this:StopMovingOrSizing();
	if (not DFM_DRAG_INDEX) then return; end
	local header = DFM_FRAME_LIST[DFM_DRAG_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_DRAG_INDEX].frame;
	local settings = DFM_Settings[DFM_INDEX][header][frame].Location;
	local x, y = DL_Get_Offsets(DFM_DragFrame, getglobal(settings.frame), settings.point, settings.to);
	settings.x = x;
	settings.y = y;
	DFM_Initialize_FrameLocation(header, frame);
	if (DFM_DRAG_INDEX == DFM_SELECTED_INDEX) then
		DFM_Update_LocationSettings();
	end
end

function DFM_Summon_DragFrame(override)
	if (not DFM_SELECTED_INDEX) then return; end
	if (DFM_DragFrame:IsVisible() and (not override)) then
		DFM_Stop_Dragging();
		DFM_DragFrame:Hide();
		DFM_DRAG_INDEX = nil;
		return;
	end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	local settings = DFM_Settings[DFM_INDEX][header][frame].Location;
	if (not settings) then return; end
	if (not settings.use) then return; end
	DFM_DragFrame.frameindex = frame;
	DFM_DragFrame_FrameName:SetText(frame);
	frame = getglobal(frame);
	local height = frame:GetHeight();
	local width = frame:GetWidth();
	if (height < 50) then height = 50; end
	if (width < 50) then width = 50; end
	local scale;
	if (frame.GetEffectiveScale) then
		scale = frame:GetEffectiveScale();
	else
		scale = 1;
	end
	DFM_DragFrame:SetHeight(height);
	DFM_DragFrame:SetWidth(width);
	DFM_DragFrame:SetScale(scale);
	DFM_DragFrame:ClearAllPoints();
	DFM_DragFrame:SetPoint(settings.point, settings.frame, settings.to, settings.x, settings.y);
	DFM_DragFrame:Show();
	DFM_DRAG_INDEX = DFM_SELECTED_INDEX;
end

function DFM_Update_AnchorFrame()
	this:ClearFocus();
	local value = this:GetText();
	if ((not value) or value == "" or (not getglobal(value))) then
		this:SetText(this.prevvalue);
		return;
	end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (not DFM_Settings[DFM_INDEX][header][frame].Location) then
		this:SetText(this.prevvalue);
	else
		DFM_Settings[DFM_INDEX][header][frame].Location.frame = value;
		DFM_Initialize_FrameLocation(header, frame);
	end
end

function DFM_Update_FrameList()
	DFM_FRAME_LIST = {};
	DFM_HEADERS_LIST = {};
	local headers = {};
	local index = 1;
	for header in DFM_Settings[DFM_INDEX] do
		headers[index] = header;
		index = index + 1;
	end
	DL_Sort(headers);

	index = 0;
	hindex = 0;
	for _, header in headers do
		hindex = hindex + 1;
		index = index + 1;
		DFM_HEADERS_LIST[hindex] = {text=header, value=index};
		DFM_FRAME_LIST[index] = {text=header, headerFlag=true};

		local frames = {};
		local frameRealName = {};
		local i = 0;
		for frame in DFM_Settings[DFM_INDEX][header] do
			if (getglobal(frame)) then
				i = i + 1;
				frames[i] = DFM_Settings[DFM_INDEX][header][frame].name;
				frameRealName[frames[i]] = frame;
			end
		end
		DL_Sort(frames);
		for i=1, table.getn(frames) do
			index = index + 1;
			local frameType = "";
			local frame = getglobal(frameRealName[frames[i]]);
			if (frame.GetFrameType) then
				frameType = frame:GetFrameType();
			elseif (frame.SetFont) then
				frameType = "FontString";
			else
				frameType = "Texture";
			end
			DFM_FRAME_LIST[index] = {text=frames[i], header=header, frame=frameRealName[frames[i]], frameType=frameType};
			for m,v in DFM_Settings[DFM_INDEX][header][frameRealName[frames[i]]] do
				if (tonumber(m) and v.use) then
					DFM_FRAME_LIST[index].modified = 1;
				elseif (m == "Location" and v.use) then
					DFM_FRAME_LIST[index].modified = 1;
				elseif (m == "forceHide" and v) then
					DFM_FRAME_LIST[index].modified = 1;
				elseif (m == "customFrame") then
					DFM_FRAME_LIST[index].modified = 1;
				end
			end
		end
	end
end

function DFM_Update_LocationSettings()
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	local settings = DFM_Get_LocSettings(header, frame);
	DL_Init_EditBox(DFM_Options_XOffset, settings.x);
	DL_Init_EditBox(DFM_Options_YOffset, settings.y);
	DL_Init_EditBox(DFM_Options_AnchorFrame, settings.frame);
	DL_Init_MenuControl(DFM_Options_AnchorPoint, settings.point);
	DL_Init_MenuControl(DFM_Options_AnchorTo, settings.to);
	DL_Init_CheckBox(DFM_Options_UseLocation, settings.use);
	DL_Init_CheckBox(DFM_Options_LockLocation, settings.lock);
end

function DFM_Update_MethodSetting(method, index, value)
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (not DFM_Settings[DFM_INDEX][header][frame]) then
		DFM_Settings[DFM_INDEX][header][frame] = {};
	end
	if (not DFM_Settings[DFM_INDEX][header][frame][method]) then
		DFM_Settings[DFM_INDEX][header][frame][method] = {};
	end
	DFM_Settings[DFM_INDEX][header][frame][method][index] = value;
	DFM_Initialize_Frame(header, frame);
end

function DFM_Update_OptionsList()
	local headertext = string.upper(string.gsub(DFM_TEXT.Options, "$f", DFM_FRAME_LIST[DFM_SELECTED_INDEX].text));
	DFM_Options_OptionsMenu_OuterBorder_Header:SetText(headertext);
	DFM_OPTIONS_LIST = {};
	DFM_OPTIONS_LIST[1] = {name="ForceHide", option=5, help="Hides the frame in a way that will keep anything else from being able to show it."};
	local frame = getglobal(DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame);
	local index = 1;
	for methodIndex,value in DFM_METHODS_LIST do
		if (frame[value.method]) then
			for param,option in value.options do
				index = index + 1;
				DFM_OPTIONS_LIST[index] = {};
				DL_Copy_Table(option, DFM_OPTIONS_LIST[index]);
				DFM_OPTIONS_LIST[index].method = methodIndex;
				DFM_OPTIONS_LIST[index].param = param;
				DFM_OPTIONS_LIST[index].detection = value.detection;
				DFM_OPTIONS_LIST[index].help = value.help;
			end
		end
	end
	DFM_OptionsMenu_Update();
	DFM_Update_LocationSettings();
end

function DFM_Update_Profiles()
	DFM_PROFILES = {};
	for profile in DFM_Settings do
		if ((not string.find(profile, "INITIALIZED")) and (not string.find(profile, " :: ")) and profile ~= "LoadOnDemandFunctions"  and profile ~= "usetooltipanchor" and profile ~= "usecontaineranchors") then
			local i = table.getn(DFM_PROFILES) + 1;
			DFM_PROFILES[i] = { text=profile, value=profile };
			if (profile == "Default") then
				DFM_PROFILES[i].desc = "This profile will be used initially by any new character you create or characters on whom you haven't loaded Discord Frame Modifier yet.";
			elseif (profile == "Custom") then
				DFM_PROFILES[i].desc = "This profile holds settings from the DFM_Custom.lua file in the mod's folder.  CHANGES TO THIS PROFILE WILL NOT BE SAVED.  Load this profile and immediately create a new profile if you want to make changes.";
			end
		end
	end
end

function DFM_Update_Setting(index, value)
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	local method = DFM_OPTIONS_LIST[index].method;
	local param = DFM_OPTIONS_LIST[index].param;
	if (index == 1) then
		DFM_Settings[DFM_INDEX][header][frame].forceHide = value;
		if (not value) then
			DFM_ReloadUIFrame:Show();
		end
	else
		if (not DFM_Settings[DFM_INDEX][header][frame][method]) then
			DFM_Settings[DFM_INDEX][header][frame][method] = {};
		end
		DFM_Settings[DFM_INDEX][header][frame][method][param] = value;
	end
	DFM_Initialize_Frame(header, frame);
end

function DFM_Update_XOffset()
	this:ClearFocus();
	local value = this:GetNumber();
	if (not value or value == "") then
		value = 0;
		this:SetText(0);
	end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (not DFM_Settings[DFM_INDEX][header][frame].Location) then
		this:SetText(this.prevvalue);
		return;
	end
	DFM_Settings[DFM_INDEX][header][frame].Location.x = value;
	DFM_Initialize_FrameLocation(header, frame);
end

function DFM_Update_YOffset()
	this:ClearFocus();
	local value = this:GetNumber();
	if (not value or value == "") then
		value = 0;
		this:SetText(0);
	end
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (not DFM_Settings[DFM_INDEX][header][frame].Location) then
		this:SetText(this.prevvalue);
		return;
	end
	DFM_Settings[DFM_INDEX][header][frame].Location.y = value;
	DFM_Initialize_FrameLocation(header, frame);
end

function DFM_UseCheckBox_OnClick()
	if (this:GetChecked()) then
		DFM_Init_Settings(this.method);
		DFM_Update_MethodSetting(this.method, "use", 1);
		DFM_OptionsMenu_Update();
	else
		DFM_Update_MethodSetting(this.method, "use");
		DFM_ReloadUIFrame:Show();
	end
end

function DFM_UseLocationCheckBox_OnClick()
	local header = DFM_FRAME_LIST[DFM_SELECTED_INDEX].header;
	local frame = DFM_FRAME_LIST[DFM_SELECTED_INDEX].frame;
	if (this:GetChecked()) then
		if (not DFM_Settings[DFM_INDEX][header][frame].Location) then
			DFM_Settings[DFM_INDEX][header][frame].Location = DFM_Get_LocSettings(header, frame);
		end
		DFM_Settings[DFM_INDEX][header][frame].Location.use = 1;
		DFM_Initialize_FrameLocation(header, frame);
	else
		DFM_Settings[DFM_INDEX][header][frame].Location.use = nil;
		DFM_ReloadUIFrame:Show();
	end
end
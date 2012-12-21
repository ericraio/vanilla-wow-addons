--The Options Page variables and functions

--Event and Damage option values
local SCTOptionsFrameEventFrames = { };
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT1.name] = { index = 1, tooltipText = SCT_OPTION_EVENT1.tooltipText, SCTVar = "SHOWHIT"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT2.name] = { index = 2, tooltipText = SCT_OPTION_EVENT2.tooltipText, SCTVar = "SHOWMISS"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT3.name] = { index = 3, tooltipText = SCT_OPTION_EVENT3.tooltipText, SCTVar = "SHOWDODGE"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT4.name] = { index = 4, tooltipText = SCT_OPTION_EVENT4.tooltipText, SCTVar = "SHOWPARRY"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT5.name] = { index = 5, tooltipText = SCT_OPTION_EVENT5.tooltipText, SCTVar = "SHOWBLOCK"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT6.name] = { index = 6, tooltipText = SCT_OPTION_EVENT6.tooltipText, SCTVar = "SHOWSPELL"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT7.name] = { index = 7, tooltipText = SCT_OPTION_EVENT7.tooltipText, SCTVar = "SHOWHEAL"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT8.name] = { index = 8, tooltipText = SCT_OPTION_EVENT8.tooltipText, SCTVar = "SHOWRESIST"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT9.name] = { index = 9, tooltipText = SCT_OPTION_EVENT9.tooltipText, SCTVar = "SHOWDEBUFF"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT10.name] = { index = 10, tooltipText = SCT_OPTION_EVENT10.tooltipText, SCTVar = "SHOWABSORB"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT11.name] = { index = 11, tooltipText = SCT_OPTION_EVENT11.tooltipText, SCTVar = "SHOWLOWHP"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT12.name] = { index = 12, tooltipText = SCT_OPTION_EVENT12.tooltipText, SCTVar = "SHOWLOWMANA"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT13.name] = { index = 13, tooltipText = SCT_OPTION_EVENT13.tooltipText, SCTVar = "SHOWPOWER"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT14.name] = { index = 14, tooltipText = SCT_OPTION_EVENT14.tooltipText, SCTVar = "SHOWCOMBAT"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT15.name] = { index = 15, tooltipText = SCT_OPTION_EVENT15.tooltipText, SCTVar = "SHOWCOMBOPOINTS"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT16.name] = { index = 16, tooltipText = SCT_OPTION_EVENT16.tooltipText, SCTVar = "SHOWHONOR"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT17.name] = { index = 17, tooltipText = SCT_OPTION_EVENT17.tooltipText, SCTVar = "SHOWBUFF"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT18.name] = { index = 18, tooltipText = SCT_OPTION_EVENT18.tooltipText, SCTVar = "SHOWFADE"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT19.name] = { index = 19, tooltipText = SCT_OPTION_EVENT19.tooltipText, SCTVar = "SHOWEXECUTE"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT20.name] = { index = 20, tooltipText = SCT_OPTION_EVENT20.tooltipText, SCTVar = "SHOWREP"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT21.name] = { index = 21, tooltipText = SCT_OPTION_EVENT21.tooltipText, SCTVar = "SHOWSELFHEAL"};
SCTOptionsFrameEventFrames [SCT_OPTION_EVENT22.name] = { index = 22, tooltipText = SCT_OPTION_EVENT22.tooltipText, SCTVar = "SHOWSKILL"};

--Check Button option values
local SCTOptionsFrameCheckButtons = { };
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK1.name] = { index = 1, tooltipText = SCT_OPTION_CHECK1.tooltipText, SCTVar = "ENABLED"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK2.name] = { index = 2, tooltipText = SCT_OPTION_CHECK2.tooltipText, SCTVar = "SHOWSELF"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK3.name] = { index = 3, tooltipText = SCT_OPTION_CHECK3.tooltipText, SCTVar = "SHOWTARGETS"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK4.name] = { index = 4, tooltipText = SCT_OPTION_CHECK4.tooltipText, SCTVar = "DIRECTION"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK5.name] = { index = 5, tooltipText = SCT_OPTION_CHECK5.tooltipText, SCTVar = "STICKYCRIT"}
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK6.name] = { index = 6, tooltipText = SCT_OPTION_CHECK6.tooltipText, SCTVar = "SPELLTYPE"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK7.name] = { index = 7, tooltipText = SCT_OPTION_CHECK7.tooltipText, SCTVar = "DMGFONT"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK8.name] = { index = 8, tooltipText = SCT_OPTION_CHECK8.tooltipText, SCTVar = "SHOWALLPOWER"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK9.name] = { index = 9, tooltipText = SCT_OPTION_CHECK9.tooltipText, SCTVar = "FPSMODE"};
SCTOptionsFrameCheckButtons [SCT_OPTION_CHECK10.name] = { index = 10, tooltipText = SCT_OPTION_CHECK10.tooltipText, SCTVar = "SHOWOVERHEAL"};

--Slider options values
local SCTOptionsFrameSliders = { };
SCTOptionsFrameSliders [SCT_OPTION_SLIDER1.name] = { index = 1, SCTVar = "ANIMATIONSPEED", minValue = .005, maxValue = .025, valueStep = .005, minText=SCT_OPTION_SLIDER1.minText, maxText=SCT_OPTION_SLIDER1.maxText, tooltipText = SCT_OPTION_SLIDER1.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER2.name] = { index = 2, SCTVar = "TEXTSIZE", minValue = 12, maxValue = 36, valueStep = 3, minText=SCT_OPTION_SLIDER2.minText, maxText=SCT_OPTION_SLIDER2.maxText, tooltipText = SCT_OPTION_SLIDER2.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER3.name] = { index = 3, SCTVar = "LOWHP", minValue = .1, maxValue = .9, valueStep = .1, minText=SCT_OPTION_SLIDER3.minText, maxText=SCT_OPTION_SLIDER3.maxText, tooltipText = SCT_OPTION_SLIDER3.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER4.name] = { index = 4, SCTVar = "LOWMANA", minValue = .1, maxValue = .9, valueStep = .1, minText=SCT_OPTION_SLIDER4.minText, maxText=SCT_OPTION_SLIDER4.maxText, tooltipText = SCT_OPTION_SLIDER4.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER5.name] = { index = 5, SCTVar = "ALPHA", minValue = .1, maxValue = 1, valueStep = .1, minText=SCT_OPTION_SLIDER5.minText, maxText=SCT_OPTION_SLIDER5.maxText, tooltipText = SCT_OPTION_SLIDER5.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER6.name] = { index = 6, SCTVar = "MOVEMENT", minValue = 1, maxValue = 5, valueStep = 1, minText=SCT_OPTION_SLIDER6.minText, maxText=SCT_OPTION_SLIDER6.maxText, tooltipText = SCT_OPTION_SLIDER6.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER7.name] = { index = 7, SCTVar = "XOFFSET", minValue = -300, maxValue = 300, valueStep = 10, minText=SCT_OPTION_SLIDER7.minText, maxText=SCT_OPTION_SLIDER7.maxText, tooltipText = SCT_OPTION_SLIDER7.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER8.name] = { index = 8, SCTVar = "YOFFSET", minValue = -300, maxValue = 300, valueStep = 10, minText=SCT_OPTION_SLIDER8.minText, maxText=SCT_OPTION_SLIDER8.maxText, tooltipText = SCT_OPTION_SLIDER8.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER9.name] = { index = 9, SCTVar = "MSGXOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT_OPTION_SLIDER9.minText, maxText=SCT_OPTION_SLIDER9.maxText, tooltipText = SCT_OPTION_SLIDER9.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER10.name] = { index = 10, SCTVar = "MSGYOFFSET", minValue = -600, maxValue = 600, valueStep = 10, minText=SCT_OPTION_SLIDER10.minText, maxText=SCT_OPTION_SLIDER10.maxText, tooltipText = SCT_OPTION_SLIDER10.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER11.name] = { index = 11, SCTVar = "MSGFADE", minValue = 1, maxValue = 3, valueStep = .5, minText=SCT_OPTION_SLIDER11.minText, maxText=SCT_OPTION_SLIDER11.maxText, tooltipText = SCT_OPTION_SLIDER11.tooltipText};
SCTOptionsFrameSliders [SCT_OPTION_SLIDER12.name] = { index = 12, SCTVar = "MSGSIZE", minValue = 12, maxValue = 36, valueStep = 3, minText=SCT_OPTION_SLIDER12.minText, maxText=SCT_OPTION_SLIDER12.maxText, tooltipText = SCT_OPTION_SLIDER12.tooltipText};

--Selection Boxes
local SCTOptionsFrameSelections = {};
SCTOptionsFrameSelections [SCT_OPTION_SELECTION1.name] = { index = 1, SCTVar = "ANITYPE", tooltipText = SCT_OPTION_SELECTION1.tooltipText, table = SCT_OPTION_SELECTION1.table};
SCTOptionsFrameSelections [SCT_OPTION_SELECTION2.name] = { index = 2, SCTVar = "ANISIDETYPE", tooltipText = SCT_OPTION_SELECTION2.tooltipText, table = SCT_OPTION_SELECTION2.table};
SCTOptionsFrameSelections [SCT_OPTION_SELECTION3.name] = { index = 3, SCTVar = "FONT", tooltipText = SCT_OPTION_SELECTION3.tooltipText, table = SCT_OPTION_SELECTION3.table};
SCTOptionsFrameSelections [SCT_OPTION_SELECTION4.name] = { index = 4, SCTVar = "FONTSHADOW", tooltipText = SCT_OPTION_SELECTION4.tooltipText, table = SCT_OPTION_SELECTION4.table};
SCTOptionsFrameSelections [SCT_OPTION_SELECTION5.name] = { index = 5, SCTVar = "MSGFONT", tooltipText = SCT_OPTION_SELECTION5.tooltipText, table = SCT_OPTION_SELECTION5.table};
SCTOptionsFrameSelections [SCT_OPTION_SELECTION6.name] = { index = 6, SCTVar = "MSGFONTSHADOW", tooltipText = SCT_OPTION_SELECTION6.tooltipText, table = SCT_OPTION_SELECTION6.table};

--Other Options
local SCTOptionsFrameMisc = {};
SCTOptionsFrameMisc [SCT_OPTION_MISC1.name] = {index = 1, tooltipText = SCT_OPTION_MISC1.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC2.name] = {index = 2, tooltipText = SCT_OPTION_MISC2.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC3.name] = {index = 3, tooltipText = SCT_OPTION_MISC3.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC4.name] = {index = 4, tooltipText = SCT_OPTION_MISC4.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC5.name] = {index = 5, tooltipText = SCT_OPTION_MISC5.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC6.name] = {index = 6, tooltipText = SCT_OPTION_MISC6.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC7.name] = {index = 7, tooltipText = SCT_OPTION_MISC7.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC8.name] = {index = 8, tooltipText = SCT_OPTION_MISC8.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC9.name] = {index = 9, tooltipText = SCT_OPTION_MISC9.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC10.name] = {index = 10, tooltipText = SCT_OPTION_MISC10.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC11.name] = {index = 11, tooltipText = SCT_OPTION_MISC11.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC12.name] = {index = 12, tooltipText = SCT_OPTION_MISC12.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC13.name] = {index = 13, tooltipText = SCT_OPTION_MISC13.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC14.name] = {index = 14, tooltipText = SCT_OPTION_MISC14.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC15.name] = {index = 15, tooltipText = SCT_OPTION_MISC15.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC16.name] = {index = 16, tooltipText = SCT_OPTION_MISC16.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC17.name] = {index = 17, tooltipText = SCT_OPTION_MISC17.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC18.name] = {index = 18, tooltipText = SCT_OPTION_MISC18.tooltipText}
SCTOptionsFrameMisc [SCT_OPTION_MISC19.name] = {index = 19, tooltipText = SCT_OPTION_MISC19.tooltipText}

----------------------
--Called when option page loads
function SCTOptionsFrame_OnShow()
	-- Initial Values
	local button, button2, button3, string, checked;
	
	--Misc Options
	for key, value in SCTOptionsFrameMisc do
		string = getglobal("SCTOptionsFrame_Misc"..value.index);
		string:SetText(key);
		if (value.tooltipText) then
			string.tooltipText = value.tooltipText;
		end
	end
	
	-- Set Options values
	for key, value in SCTOptionsFrameEventFrames do
		button = getglobal("SCTOptionsFrame"..value.index.."_CheckButton");
		button2 = getglobal("SCTOptionsFrame"..value.index.."_CritCheckButton");
		button3 = getglobal("SCTOptionsFrame"..value.index.."_MsgCheckButton");
		string = getglobal("SCTOptionsFrame"..value.index.."_CheckButtonText");

		button:SetChecked(SCT_Get(value.SCTVar));
		button.tooltipText = value.tooltipText;
		button2:SetChecked(SCT_GetTable(SCT_CRITS_TABLE, value.SCTVar));
		button2.tooltipText = SCT_Option_Crit_Tip;
		button3:SetChecked(SCT_GetTable(SCT_MSGS_TABLE, value.SCTVar));
		button3.tooltipText = SCT_Option_Msg_Tip;
		string:SetText(key);
		
		--Color Swatch
		local frame,swatch,sRed,sGreen,sBlue,sColor,sfunc,cfunc,index,key;
		
		frame = getglobal("SCTOptionsFrame"..value.index);
		swatch = getglobal("SCTOptionsFrame"..value.index.."_ColorSwatchNormalTexture");
		
		sColor = SCT_GetTable(SCT_COLORS_TABLE, value.SCTVar);
		sRed = sColor.r;
		sGreen = sColor.g;
		sBlue = sColor.b;

		frame.r = sRed;
		frame.g = sGreen;
		frame.b = sBlue;

		index = value.index;
		key = value.SCTVar;
		sfunc = function(x) SCTOptionsFrame_SetColor(index, key) end;
		cfunc = function(x) SCTOptionsFrame_CancelColor(index, key, x) end;
		frame.swatchFunc = sfunc;
		frame.cancelFunc = cfunc;
		swatch:SetVertexColor(sRed,sGreen,sBlue);
	end
	
	-- Set CheckButton states
	for key, value in SCTOptionsFrameCheckButtons do
		button = getglobal("SCTOptionsFrame_CheckButton"..value.index);
		string = getglobal("SCTOptionsFrame_CheckButton"..value.index.."Text");

		button:SetChecked(SCT_Get(value.SCTVar));
		button.tooltipText = value.tooltipText;
		string:SetText(key);

	end
	
	local slider, string, low, high, getvalue	

	--Set Sliders
	for key, value in SCTOptionsFrameSliders do
		slider = getglobal("SCTOptionsFrame_Slider"..value.index);
		string = getglobal("SCTOptionsFrame_Slider"..value.index.."Text");
		low = getglobal("SCTOptionsFrame_Slider"..value.index.."Low");
		high = getglobal("SCTOptionsFrame_Slider"..value.index.."High");
		getvalue = SCT_Get(value.SCTVar);
		slider:SetMinMaxValues(value.minValue, value.maxValue);
		slider:SetValueStep(value.valueStep);
		slider.tooltipText = value.tooltipText;
		slider:SetValue(getvalue);
		string:SetText(key..": "..SCT_Format_Number(getvalue));
		low:SetText(value.minText);
		high:SetText(value.maxText);
	end
	
	local label, ddl, selected
	
	--Dropdowns
	for key, value in SCTOptionsFrameSelections do
		selected = SCT_Get(value.SCTVar);
		ddl = getglobal("SCTOptionsFrame_Selection"..value.index);
		UIDropDownMenu_SetSelectedID(ddl, selected);
		--not sure why I have to do this, but only way to make it show correctly
		UIDropDownMenu_SetText(value.table[selected], ddl);
		ddl.tooltipText = value.tooltipText;
		label = getglobal("SCTOptionsFrame_Selection"..value.index.."Label");
		label:SetText(key);
		
		--show hide text options
		if (value.index == 1) then
			SCT_UpdateAnimationOptions(selected);
		end
	end
	
	--Update Profiles	
	SCT_UpdateProfileList();	
end

----------------------
--Sets the colors of the config from a color swatch
function SCTOptionsFrame_SetColor(index,key)
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	local color={};
	swatch = getglobal("SCTOptionsFrame"..index.."_ColorSwatchNormalTexture");
	frame = getglobal("SCTOptionsFrame"..index);
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	color.r = r;
	color.g = g;
	color.b = b;
	--update back to config
	SCT_SetTable(SCT_COLORS_TABLE, key, color);
end

----------------------
-- Cancels the color selection
function SCTOptionsFrame_CancelColor(index, key, prev)
	local r = prev.r;
	local g = prev.g;
	local b = prev.b;
	local swatch, frame;
	local color={};
	swatch = getglobal("SCTOptionsFrame"..index.."_ColorSwatchNormalTexture");
	frame = getglobal("SCTOptionsFrame"..index);
	swatch:SetVertexColor(r, g, b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	color.r = r;
	color.g = g;
	color.b = b;
	-- Update back to config
	SCT_SetTable(SCT_COLORS_TABLE, key, color);
end

----------------------
--Sets the silder values in the config
function SCT_OptionsSliderOnValueChanged()
	local string;
	--loop thru slider array to find current one, then update its value	
	for key, value in SCTOptionsFrameSliders do
		if (this:GetName() == "SCTOptionsFrame_Slider"..value.index) then
			string = getglobal("SCTOptionsFrame_Slider"..value.index.."Text");
			string:SetText(key..": "..SCT_Format_Number(this:GetValue()));
			SCT_Set(value.SCTVar,this:GetValue());
			break;
		end
	end
	--update Example
	SCT_ShowExample();
end

----------------------
--Sets the checkbox values in the config
function SCT_OptionsCheckButtonOnClick()
	local button, chkvalue;
	--loop thru event checkbox array to find current one, then update its value
	for index, value in SCTOptionsFrameEventFrames do
		if (this:GetName() == "SCTOptionsFrame"..value.index.."_CheckButton") then
			button = getglobal("SCTOptionsFrame"..value.index.."_CheckButton");
			SCT_Set(value.SCTVar,button:GetChecked());
			break;
		--is it a crit checkbox
		elseif (this:GetName() == "SCTOptionsFrame"..value.index.."_CritCheckButton") then
			button = getglobal("SCTOptionsFrame"..value.index.."_CritCheckButton");
			SCT_SetTable(SCT_CRITS_TABLE, value.SCTVar,button:GetChecked());
			break;
		--is it a msg checkbox
		elseif (this:GetName() == "SCTOptionsFrame"..value.index.."_MsgCheckButton") then
			button = getglobal("SCTOptionsFrame"..value.index.."_MsgCheckButton");
			SCT_SetTable(SCT_MSGS_TABLE, value.SCTVar,button:GetChecked());
			break;
		end
	end
	--loop thru checkbox array to find current one, then update its value
	for index, value in SCTOptionsFrameCheckButtons do
		if (this:GetName() == "SCTOptionsFrame_CheckButton"..value.index) then
			button = getglobal("SCTOptionsFrame_CheckButton"..value.index);
			SCT_Set(value.SCTVar,button:GetChecked());
			break;
		end
	end
	--update Example
	SCT_ShowExample();
end

---------------------
--Save current settings, mainly to catch when they load a profile
function SCTSaveCurrentSettings()
	SCT_CONFIG[SCT_PlayerName] = SCT_clone(SCTPlayer);
	SCTPlayer = SCT_Config_GetPlayer();
end

----------------------
--Open the color selector using show/hide
function SCTSaveList_OnClick()
	local id = this:GetName();
	local profile = getglobal(id.."_Name"):GetText();
	local editbox = getglobal("SCTOptionsProfileEditBox");
	editbox:SetText(profile);
	SCTOptions_SaveLoadFrame:Hide();
end

-----------------------
--Load a profile
function SCTLoadProfile()
	local editbox = getglobal("SCTOptionsProfileEditBox");
	local profile = editbox:GetText();
	if (SCT_CONFIG[profile]) then
		SCTPlayer = SCT_clone(SCT_CONFIG[profile]);
		editbox:SetText("");
		SCT_hideMenu();
		SCT_showMenu();
		SCT_Chat_Message(SCT_PROFILE..profile);
	end
end

-----------------------
--Delete a profile
function SCTDeleteProfile()
	local editbox = getglobal("SCTOptionsProfileEditBox");
	local profile = editbox:GetText();
	if (SCT_CONFIG[profile]) then
		if (profile == SCT_PlayerName) then
			SCT_Reset();
		else
			SCT_CONFIG[profile] = nil;
		end
		editbox:SetText("");
		SCT_UpdateProfileList()
		SCT_hideMenu();
		SCT_showMenu();
		SCT_Chat_Message(SCT_PROFILE_DELETE..profile);
	end
end

-----------------------
--Update profile list
function SCT_UpdateProfileList()
	local loadprofile
	local i, j = 1;
	--update known profiles
	for key, value in SCT_CONFIG do
		if (i > 10) then
			return;
		end
		loadprofile = getglobal("SCTList"..i.."_Name");
		loadprofile:SetText(key);
		i = i + 1;
	end
	--blank out non-updated list items
	for j = i, 10 do
		loadprofile = getglobal("SCTList"..j.."_Name");
		loadprofile:SetText("");
	end
end

----------------------
--Open the color selector using show/hide
function SCT_OpenColorPicker(button)
	CloseMenus();
	if ( not button ) then
		button = this;
	end
	ColorPickerFrame.func = button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = button.cancelFunc;
	ColorPickerFrame:Show();
end

---------------------
--Init a Dropdown
function SCT_DropDown_Initialize()
	local info = {};
	for index, value in SCTOptionsFrameSelections do
		if (this:GetName() == "SCTOptionsFrame_Selection"..value.index.."Button") then
			for key, name in value.table do
				info = {};
				info.text = name;
				info.func = SCT_DropDown_OnClick;
				info.arg1 = value.index;
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

---------------------
-- Dropdown Onclick
function SCT_DropDown_OnClick(list)
	local ddl, ddl2, chkbox;
	for index, value in SCTOptionsFrameSelections do
		if (list == value.index) then
			ddl = getglobal("SCTOptionsFrame_Selection"..value.index);
			UIDropDownMenu_SetSelectedID(ddl, this:GetID());
			SCT_Set(value.SCTVar, this:GetID());
			--show hide text options
			if (value.index == 1) then
				SCT_UpdateAnimationOptions(this:GetID());
			end
		end
	end
	
	--update Example
	SCT_ShowExample();
end

----------------------
-- display ddl or chxbox based on type
function SCT_UpdateAnimationOptions(id)
	--get scroll down checkbox
		chkbox = getglobal("SCTOptionsFrame_CheckButton4");
		--get animside type dropdown
		ddl2 = getglobal("SCTOptionsFrame_Selection2");
		if (id == 1) then
			chkbox:Show();
			ddl2:Hide();
		else
			chkbox:Hide();
			ddl2:Show();
		end
end

---------------------
--Show SCT Example
function SCT_ShowExample()
	local example;
	SCT_UpdateGlobalPos();
	
	--show example frame
	SCT_EXAMPLETEXT:Show();
	--get object
	example = getglobal("SCTaniExampleData1");
	--set text size
	SCT_SetFont(example);
	--set the color
	example:SetTextColor(1, 1, 1);
	--set alpha
	example:SetAlpha(SCT_Get("ALPHA"));
	--Position
	example:SetPoint("CENTER", "UIParent", "CENTER", SCT_Get("XOFFSET"), SCT_Get("YOFFSET"));
	--Set the text to display
	example:SetText(SCT_EXAMPLE);
	
	--show msg frame
	SCT_EXAMPLEMSG:Show();
	--get object
	example = getglobal("SCTMsgExample1");
	--set text size
	SCT_SetMsgFont(example);
	--set the color
	example:SetTextColor(1, 1, 1);
	--set alpha
	example:SetAlpha(1);
	--Position
	example:SetPoint("CENTER", "UIParent", "CENTER", SCT_Get("MSGXOFFSET"), SCT_Get("MSGYOFFSET")-30);
	--Set the text to display
	example:SetText(SCT_MSG_EXAMPLE);
end

---------------
--format numbers
function SCT_Format_Number(number)
	if number > 0 and number < 1 then
		return format("%d",number * 100);
	else
		return number;
	end;
end
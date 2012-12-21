-------------------------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------------------------
ACW_DLG_COLOR = 0.4;
ACW_INVALID_TIME = 30;

------------------------------------------------------------------------------------------------
-- INTERNAL FUNCTIONS
-------------------------------------------------------------------------------------------------
function TITAN_ACWOptionsFrameTimeFormatDropDown_Initialize()

	local info;

	info = {};
	info.text = "12"..ACW_OPTIONS_HOURS;
	info.func = TITAN_ACWOptionsFrameTimeFormatDropDown_OnClick;
	info.value = 12;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "24"..ACW_OPTIONS_HOURS;
	info.func = TITAN_ACWOptionsFrameTimeFormatDropDown_OnClick;
	info.value = 24;
	UIDropDownMenu_AddButton(info);

end

function TITAN_ACWOptionsFrameModeDropDown_Initialize()

	local info;

	info = {};
	info.text = "Normal";
	info.func = TITAN_ACWOptionsFrameModeDropDown_OnClick;
	info.value = TITAN_ACW_NORMAL_MODE;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Compact";
	info.func = TITAN_ACWOptionsFrameModeDropDown_OnClick;
	info.value = TITAN_ACW_COMPACT_MODE;
	UIDropDownMenu_AddButton(info);

end

function TITAN_ACWOptionsFrameOffsetDropDown_Initialize()

	local info;

	for i=-12, 12, 1 do
		info = {};
		info.text = tostring(i);
		if (i>0) then
			info.text = "+"..info.text;
		end
		info.func = TITAN_ACWOptionsFrameOffsetDropDown_OnClick;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end

end

function TITAN_ACWOptionsFrameOffsetMinuteDropDown_Initialize()

	local info;

	for i=-45, 45, 15 do
		info = {};
		info.text = tostring(i);
		if (i>0) then
			info.text = "+"..info.text;
		end
		info.func = TITAN_ACWOptionsFrameOffsetMinuteDropDown_OnClick;
		info.value = i;
		UIDropDownMenu_AddButton(info);
	end

end

function TITAN_ACWOptions_Update(insertSavedTime)
	UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameTimeFormatDropDown, TITAN_ACWOptions.timeformat);
	UIDropDownMenu_SetText(TITAN_ACWOptions.timeformat..ACW_OPTIONS_HOURS, TITAN_ACWOptionsFrameTimeFormatDropDown);

	UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameModeDropDown, TITAN_ACWOptions.mode);
	if (TITAN_ACWOptions.mode == TITAN_ACW_COMPACT_MODE) then
		UIDropDownMenu_SetText("Compact", TITAN_ACWOptionsFrameModeDropDown);		
	else
		UIDropDownMenu_SetText("Normal", TITAN_ACWOptionsFrameModeDropDown);		
	end
	
	--UIDropDownMenu_SetText(TITAN_ACWOptions.PTIONS_HOURS, TITAN_ACWOptionsFrameTimeFormatDropDown);

	UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameOffsetDropDown, TITAN_ACWOptions.offset);
	if (TITAN_ACWOptions.offset>0) then
		UIDropDownMenu_SetText("+"..TITAN_ACWOptions.offset, TITAN_ACWOptionsFrameOffsetDropDown);
	else
		UIDropDownMenu_SetText(TITAN_ACWOptions.offset, TITAN_ACWOptionsFrameOffsetDropDown);
	end

	UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameOffsetMinuteDropDown, TITAN_ACWOptions.offsetminute);
	if (TITAN_ACWOptions.offsetminute>0) then
		UIDropDownMenu_SetText("+"..TITAN_ACWOptions.offsetminute, TITAN_ACWOptionsFrameOffsetMinuteDropDown);
	else
		UIDropDownMenu_SetText(TITAN_ACWOptions.offsetminute, TITAN_ACWOptionsFrameOffsetMinuteDropDown);
	end

	-- Alarm stuff
	TITAN_ACWOptionsAlarm1CheckButton:SetChecked(TITAN_ACWOptions.alarm1on);
	TITAN_ACWOptionsAlarm2CheckButton:SetChecked(TITAN_ACWOptions.alarm2on);
	TITAN_ACWOptionsAlarm3CheckButton:SetChecked(TITAN_ACWOptions.alarm3on);

	TITAN_ACWOptionsAlarm1EditBox:SetText(TITAN_ACWOptions.alarm1text);
	TITAN_ACWOptionsAlarm2EditBox:SetText(TITAN_ACWOptions.alarm2text);
	TITAN_ACWOptionsAlarm3EditBox:SetText(TITAN_ACWOptions.alarm3text);

	if (insertSavedTime == true) then
		TITAN_ACWOptionsAlarm1HourEditBox:SetNumber(TITAN_ACWOptions.alarm1hour);
		TITAN_ACWOptionsAlarm2HourEditBox:SetNumber(TITAN_ACWOptions.alarm2hour);
		TITAN_ACWOptionsAlarm3HourEditBox:SetNumber(TITAN_ACWOptions.alarm3hour);
	end
	
	if (insertSavedTime == true and TITAN_ACWOptions.timeformat == 24 ) then

	else
		TITAN_ACWAlarm1Frame_Adjust();
		TITAN_ACWAlarm2Frame_Adjust();
		TITAN_ACWAlarm3Frame_Adjust();
	end

	
	local minuteStr = ""..TITAN_ACWOptions.alarm1minute;
	if (TITAN_ACWOptions.alarm1minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	TITAN_ACWOptionsAlarm1MinuteEditBox:SetNumber(minuteStr);
	
	minuteStr = ""..TITAN_ACWOptions.alarm2minute;
	if (TITAN_ACWOptions.alarm2minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	TITAN_ACWOptionsAlarm2MinuteEditBox:SetNumber(minuteStr);

	minuteStr = ""..TITAN_ACWOptions.alarm3minute;
	if (TITAN_ACWOptions.alarm3minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	TITAN_ACWOptionsAlarm3MinuteEditBox:SetNumber(minuteStr);

	-- Set the misc options
	TITAN_ACWOptionsSnoozeMinuteEditBox:SetNumber((TITAN_ACWOptions.snoozetime/60));
end


function TITAN_ACWOptionsFrame_SetDefaults()
	-- Reset myClock options to defaults
	TITAN_ACW_Reset();
	
	-- Update the display
	TITAN_ACWOptions_Update(true);
end

-- Return the hour in 24 hour format if valid
function TITAN_ACWValidateTime(hour,minute,meridian)
	--message(meridian);
	if (TITAN_ACWOptions.timeformat == 12) then
		if ((hour <= 12 and hour > 0) and (minute < 60 and minute >= 0)) then
			if (hour == 12 and meridian == 1) then
				return hour;
			elseif (hour == 12 and meridian == nil) then
				return 0;
			elseif (meridian == 1) then
				hour = hour + 12;
				if (hour == 24) then
					hour = 0;
				end

				return hour;
			else
				return hour;
			end
		end
	else -- 24
		if ((hour <= 23 and hour >= 0) and (minute < 60 and minute >= 0)) then
			return hour;
		end
	end

	return ACW_INVALID_TIME;
end

-------------------------------------------------------------------------------------------------
-- EVENT HANDLERS
-------------------------------------------------------------------------------------------------

-- Main Frame
function TITAN_ACWOptionsFrame_OnLoad()
	UIPanelWindows["TITAN_ACW_Options"] = {area = "center", pushable = 0};

	UIDropDownMenu_Initialize(TITAN_ACWOptionsFrameTimeFormatDropDown, TITAN_ACWOptionsFrameTimeFormatDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, TITAN_ACWOptionsFrameTimeFormatDropDown);
	UIDropDownMenu_Initialize(TITAN_ACWOptionsFrameModeDropDown, TITAN_ACWOptionsFrameModeDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, TITAN_ACWOptionsFrameModeDropDown);
	UIDropDownMenu_Initialize(TITAN_ACWOptionsFrameOffsetDropDown, TITAN_ACWOptionsFrameOffsetDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, TITAN_ACWOptionsFrameOffsetDropDown);
	UIDropDownMenu_Initialize(TITAN_ACWOptionsFrameOffsetMinuteDropDown, TITAN_ACWOptionsFrameOffsetMinuteDropDown_Initialize);
	UIDropDownMenu_SetWidth(80, TITAN_ACWOptionsFrameOffsetMinuteDropDown);
end

function TITAN_ACWOptionsFrame_OnShow()
	-- Use smaller font for dropdown menus
	
	-- Update the display
	TITAN_ACWOptions_Update(true);
end

function TITAN_ACWOptionsFrame_OnHide()
	
	
end

function TITAN_ACWOptionsToggleCheckButton_OnClick()
	if (this == TITAN_ACWOptionsAlarm1AMCheckButton) then
		if (TITAN_ACWOptionsAlarm1AMCheckButton:GetChecked() == 1) then
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		end
	elseif (this == TITAN_ACWOptionsAlarm1PMCheckButton) then
		if (TITAN_ACWOptionsAlarm1PMCheckButton:GetChecked() == 1) then
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(1);
		end
	elseif (this == TITAN_ACWOptionsAlarm2AMCheckButton) then
		if (TITAN_ACWOptionsAlarm2AMCheckButton:GetChecked() == 1) then
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		end
	elseif (this == TITAN_ACWOptionsAlarm2PMCheckButton) then
		if (TITAN_ACWOptionsAlarm2PMCheckButton:GetChecked() == 1) then
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(1);
		end
	elseif (this == TITAN_ACWOptionsAlarm3AMCheckButton) then
		if (TITAN_ACWOptionsAlarm3AMCheckButton:GetChecked() == 1) then
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		end
	elseif (this == TITAN_ACWOptionsAlarm3PMCheckButton) then
		if (TITAN_ACWOptionsAlarm3PMCheckButton:GetChecked() == 1) then
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(0);
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(1);
		end
	end
end

function TITAN_ACWOptionsCheckButton_OnClick()
	-- Play sound
	if (this:GetChecked()) then
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	-- Update display
	--ACW_Update();
end

function TITAN_ACW_OnOK()
	--Get times and validate
	local hidePanel = true;
	local hour,minute,meridian;
	
	-- ** 1 ** --
	-- Time
	hour = TITAN_ACWOptionsAlarm1HourEditBox:GetNumber();
	minute = TITAN_ACWOptionsAlarm1MinuteEditBox:GetNumber();
	meridian = TITAN_ACWOptionsAlarm1PMCheckButton:GetChecked();

	hour = TITAN_ACWValidateTime(hour,minute,meridian);
	if (hour ~= ACW_INVALID_TIME) then
		TITAN_ACWOptions.alarm1hour = hour;
		TITAN_ACWOptions.alarm1minute = minute;
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMTIME);
		TITAN_ACWOptionsAlarm1HourEditBox:SetFocus();
	end

	-- Text
	if (TITAN_ACWOptionsAlarm1EditBox:GetNumLetters() > 0) then
		TITAN_ACWOptions.alarm1text = TITAN_ACWOptionsAlarm1EditBox:GetText();
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMMESSAGE);
		TITAN_ACWOptionsAlarm1EditBox:SetFocus();
	end

	-- On/Off
	TITAN_ACWOptions.alarm1on = TITAN_ACWOptionsAlarm1CheckButton:GetChecked();

	-- ** 2 ** --
	-- Time
	hour = TITAN_ACWOptionsAlarm2HourEditBox:GetNumber();
	minute = TITAN_ACWOptionsAlarm2MinuteEditBox:GetNumber();
	meridian = TITAN_ACWOptionsAlarm2PMCheckButton:GetChecked();

	hour = TITAN_ACWValidateTime(hour,minute,meridian);
	if (hour ~= ACW_INVALID_TIME) then
		TITAN_ACWOptions.alarm2hour = hour;
		TITAN_ACWOptions.alarm2minute = minute;
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMTIME);
		TITAN_ACWOptionsAlarm2HourEditBox:SetFocus();
	end

	-- Text
	if (TITAN_ACWOptionsAlarm2EditBox:GetNumLetters() > 0) then
		TITAN_ACWOptions.alarm2text = TITAN_ACWOptionsAlarm2EditBox:GetText();
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMMESSAGE);
		TITAN_ACWOptionsAlarm2EditBox:SetFocus();
	end

	-- On/Off
	TITAN_ACWOptions.alarm2on = TITAN_ACWOptionsAlarm2CheckButton:GetChecked();

	
	-- ** 3 ** --
	-- Time
	hour = TITAN_ACWOptionsAlarm3HourEditBox:GetNumber();
	minute = TITAN_ACWOptionsAlarm3MinuteEditBox:GetNumber();
	meridian = TITAN_ACWOptionsAlarm3PMCheckButton:GetChecked();

	hour = TITAN_ACWValidateTime(hour,minute,meridian);
	if (hour ~= ACW_INVALID_TIME) then
		TITAN_ACWOptions.alarm3hour = hour;
		TITAN_ACWOptions.alarm3minute = minute;
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMTIME);
		TITAN_ACWOptionsAlarm3HourEditBox:SetFocus();
	end

	-- Text
	if (TITAN_ACWOptionsAlarm3EditBox:GetNumLetters() > 0) then
		TITAN_ACWOptions.alarm3text = TITAN_ACWOptionsAlarm3EditBox:GetText();
	else
		hidePanel = false;
		message(ACW_ERROR_ALARMMESSAGE);
		TITAN_ACWOptionsAlarm3EditBox:SetFocus();
	end

	-- On/Off
	TITAN_ACWOptions.alarm3on = TITAN_ACWOptionsAlarm3CheckButton:GetChecked();

	-- grab the options
	

	if (TITAN_ACWOptionsSnoozeMinuteEditBox:GetNumLetters() > 0) then
		local snoozeTime = TITAN_ACWOptionsSnoozeMinuteEditBox:GetNumber();
		TITAN_ACWOptions.snoozetime = (snoozeTime * 60);
	else
		hidePanel = false;
		message(ACW_ERROR_SNOOZEMESSAGE);
		TITAN_ACWOptionsSnoozeMinuteEditBox:SetFocus();
	end

	if (hidePanel == true) then
		HideUIPanel(TITAN_ACW_Options);
	end
end

-- Children
function TITAN_ACWOptionsFrameTimeFormatDropDown_OnClick()
	if (TITAN_ACWOptions.timeformat ~= this.value) then
		UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameTimeFormatDropDown, this.value);
		TITAN_ACWOptions.timeformat = this.value;
		TITAN_ACWOptions_Update(false);
	end
end

function TITAN_ACWOptionsFrameModeDropDown_OnClick()
	if (TITAN_ACWOptions.mode ~= this.value) then
		UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameModeDropDown, this.value);
		
		if (this.value == TITAN_ACW_COMPACT_MODE) then
			TitanPanelACWButton_SetCompactMode();
		else
			TitanPanelACWButton_SetNormalMode();

			if (ACW_ALARM1_ALARMED == 1 or ACW_ALARM1_SNOOZING == 1 or ACW_ALARM2_ALARMED == 1 or ACW_ALARM2_SNOOZING == 1 or ACW_ALARM3_ALARMED == 1 or ACW_ALARM3_SNOOZING == 1) then
				TitanPanelAcknowledgeButton:Show();
				TitanPanelSnoozeButton:Show();
			else
				TitanPanelAcknowledgeButton:Hide();
				TitanPanelSnoozeButton:Hide();
			end
		end
	end
end


function TITAN_ACWOptionsFrameOffsetDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameOffsetDropDown, this.value);
	TITAN_ACWOptions.offset = this.value;
	TITAN_ACWOptions[ACW_SAVE_PREFIX.."offset"] = TITAN_ACWOptions.offset;

	if (TitanClockSettings ~= nil) then
		TitanClockSettings.OffsetHour = this.value;
	end
end

function TITAN_ACWOptionsFrameOffsetMinuteDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(TITAN_ACWOptionsFrameOffsetMinuteDropDown, this.value);
	TITAN_ACWOptions.offsetminute = this.value;
	TITAN_ACWOptions[ACW_SAVE_PREFIX.."offsetminute"] = TITAN_ACWOptions.offsetminute;
end


function TITAN_ACWAlarm1Frame_Adjust()
	TITAN_ACWOptionsAlarm1AMCheckButtonText:SetText("AM");
	TITAN_ACWOptionsAlarm1PMCheckButtonText:SetText("PM");

	if (TITAN_ACWOptions.timeformat == 12) then
		TITAN_ACWOptionsAlarm1PMCheckButton:Show();
		TITAN_ACWOptionsAlarm1AMCheckButton:Show();
		local hour = TITAN_ACWOptionsAlarm1HourEditBox:GetNumber();
		if (hour > 12) then
			TITAN_ACWOptionsAlarm1HourEditBox:SetNumber(hour-12);
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (hour == 0) then	
			TITAN_ACWOptionsAlarm1HourEditBox:SetNumber(12);
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		else -- hour < 12
			TITAN_ACWOptionsAlarm1HourEditBox:SetNumber(hour);
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		end
	else
		TITAN_ACWOptionsAlarm1AMCheckButton:Hide();
		TITAN_ACWOptionsAlarm1PMCheckButton:Hide();
		local hour = TITAN_ACWOptionsAlarm1HourEditBox:GetNumber();
		if (TITAN_ACWOptionsAlarm1PMCheckButton:GetChecked() and hour == 12) then
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (TITAN_ACWOptionsAlarm1PMCheckButton:GetChecked()) then
			hour = hour + 12;
			if (hour == 24) then
				hour = 0;
			end
			TITAN_ACWOptionsAlarm1HourEditBox:SetNumber(hour);
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			TITAN_ACWOptionsAlarm1HourEditBox:SetNumber(0);
			TITAN_ACWOptionsAlarm1PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm1AMCheckButton:SetChecked(1);
		end
	end

end

function TITAN_ACWAlarm2Frame_Adjust()
	TITAN_ACWOptionsAlarm2AMCheckButtonText:SetText("AM");
	TITAN_ACWOptionsAlarm2PMCheckButtonText:SetText("PM");

	if (TITAN_ACWOptions.timeformat == 12) then
		TITAN_ACWOptionsAlarm2PMCheckButton:Show();
		TITAN_ACWOptionsAlarm2AMCheckButton:Show();
		local hour = TITAN_ACWOptionsAlarm2HourEditBox:GetNumber();
		if (hour > 12) then
			TITAN_ACWOptionsAlarm2HourEditBox:SetNumber(hour-12);
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (hour == 0) then
			TITAN_ACWOptionsAlarm2HourEditBox:SetNumber(12);
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		else -- hour < 12
			TITAN_ACWOptionsAlarm2HourEditBox:SetNumber(hour);
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		end
	else
		TITAN_ACWOptionsAlarm2AMCheckButton:Hide();
		TITAN_ACWOptionsAlarm2PMCheckButton:Hide();

		local hour = TITAN_ACWOptionsAlarm2HourEditBox:GetNumber();
		if (TITAN_ACWOptionsAlarm2PMCheckButton:GetChecked() and hour == 12) then
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (TITAN_ACWOptionsAlarm2PMCheckButton:GetChecked()) then
			hour = hour + 12;
			if (hour == 24) then
				hour = 0;
			end
			TITAN_ACWOptionsAlarm2HourEditBox:SetNumber(hour);
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			TITAN_ACWOptionsAlarm2HourEditBox:SetNumber(0);
			TITAN_ACWOptionsAlarm2PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm2AMCheckButton:SetChecked(1);
		end
	end
end

function TITAN_ACWAlarm3Frame_Adjust()
	TITAN_ACWOptionsAlarm3AMCheckButtonText:SetText("AM");
	TITAN_ACWOptionsAlarm3PMCheckButtonText:SetText("PM");

	if (TITAN_ACWOptions.timeformat == 12) then
		TITAN_ACWOptionsAlarm3PMCheckButton:Show();
		TITAN_ACWOptionsAlarm3AMCheckButton:Show();
		local hour = TITAN_ACWOptionsAlarm3HourEditBox:GetNumber();
		if (hour > 12) then
			TITAN_ACWOptionsAlarm3HourEditBox:SetNumber(hour-12);
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (hour == 0) then
			TITAN_ACWOptionsAlarm3HourEditBox:SetNumber(12);
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		else -- hour < 12
			TITAN_ACWOptionsAlarm3HourEditBox:SetNumber(hour);
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		end
	else
		TITAN_ACWOptionsAlarm3AMCheckButton:Hide();
		TITAN_ACWOptionsAlarm3PMCheckButton:Hide();

		local hour = TITAN_ACWOptionsAlarm3HourEditBox:GetNumber();

		if (TITAN_ACWOptionsAlarm3PMCheckButton:GetChecked() and hour == 12) then
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (TITAN_ACWOptionsAlarm3PMCheckButton:GetChecked()) then
			hour = hour + 12;
			if (hour == 24) then
				hour = 0;
			end
			TITAN_ACWOptionsAlarm3HourEditBox:SetNumber(hour);
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(1);
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(0);
		elseif (hour == 12) then
			TITAN_ACWOptionsAlarm3HourEditBox:SetNumber(0);
			TITAN_ACWOptionsAlarm3PMCheckButton:SetChecked(0);
			TITAN_ACWOptionsAlarm3AMCheckButton:SetChecked(1);
		end
	end
end
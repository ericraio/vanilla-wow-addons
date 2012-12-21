--------------------------------------------------------------------------------------
-- Alarm Clock Wrangler for Telo's InfoBar
--------------------------------------------------------------------------------------

-- DEFAULT VARS
ACW_DEFAULT_ON = 1;
ACW_DEFAULT_LOCKED = 1;
ACW_DEFAULT_OFFSET = 0;
ACW_DEFAULT_ALARMON = 0;
ACW_DEFAULT_ALARMHOUR = 0;
ACW_DEFAULT_ALARMMINUTE = 0;
ACW_DEFAULT_SNOOZETIME = 300;
ACW_ALARM_DURATION = 3.0;
ACW_REALARMTIME = 6.0;
ACW_SNOOZETIME = 120;

-- ALARM VARS
ACW_ALARM1_SNOOZING = 0;
ACW_ALARM2_SNOOZING = 0;
ACW_ALARM3_SNOOZING = 0;

ACW_ALARM1_SNOOZE_HOUR = 0;
ACW_ALARM2_SNOOZE_HOUR = 0;
ACW_ALARM3_SNOOZE_HOUR = 0;

ACW_ALARM1_SNOOZE_MINUTE = 0;
ACW_ALARM2_SNOOZE_MINUTE = 0;
ACW_ALARM3_SNOOZE_MINUTE = 0;

ACW_ALARM1_SNOOZE_TIME = 0;
ACW_ALARM2_SNOOZE_TIME = 0;
ACW_ALARM3_SNOOZE_TIME = 0;

ACW_ALARM1_ALARMED = 0;
ACW_ALARM2_ALARMED = 0;
ACW_ALARM3_ALARMED = 0;

ACW_ALARM1_SNOOZE_ALARMED=0;
ACW_ALARM2_SNOOZE_ALARMED=0;
ACW_ALARM3_SNOOZE_ALARMED=0;

ACW_ELAPSE_CTR1 = 0;
ACW_ELAPSE_CTR2 = 0;
ACW_ELAPSE_CTR3 = 0;

ACW_ACKNOWLEDGE_ALARM1 = 0;
ACW_ACKNOWLEDGE_ALARM2 = 0;
ACW_ACKNOWLEDGE_ALARM3 = 0;

ACW_NIGHT = 0;
ACW_DAY = 1;
ACW_BLACK = 2;
ACW_DAY_NIGHT = ACW_DAY;

ACW_REALM_NAME = "";
ACW_SAVE_PREFIX = "";

TITAN_ACW_FREQUENCY=0.5;

TITAN_ACW_TIME_STR = "";
TITAN_ACW_OLD_CLOCK_FUNCTION = nil;
TITAN_ACW_HIDE_CLOCK = 1;

TITAN_ACW_COMPACT_MODE = 0;
TITAN_ACW_NORMAL_MODE = 1;
ACW_DEFAULT_MODE = TITAN_ACW_NORMAL_MODE;


local function dout(msg)
	if( DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg,1.0,0,0);
	end
end

function TitanPanelACWButton_SetCompactMode()
	TITAN_ACWOptions.mode = TITAN_ACW_COMPACT_MODE;
	TITAN_ACW_HIDE_CLOCK = 0;

	TitanPanelAcknowledgeButton:SetPoint("RIGHT","TitanPanelACWButton","LEFT",12,1);
	TitanPanelSnoozeButton:SetPoint("LEFT","TitanPanelACWButton","RIGHT",-12,1);

	TitanPanelACWButtonText:SetWidth(35);
	TITAN_ACW_CompactIcon:Show();
	TitanPanelAcknowledgeButton:Show();
	TitanPanelSnoozeButton:Show();
end

function TitanPanelACWButton_SetNormalMode()
	TITAN_ACWOptions.mode = TITAN_ACW_NORMAL_MODE;
	TITAN_ACW_HIDE_CLOCK = 1;

	TITAN_ACW_CompactIcon:Hide();
	TitanPanelACWButtonText:SetWidth(51);

	TitanPanelAcknowledgeButton:SetPoint("RIGHT","TitanPanelACWButton","LEFT",1,1);
	TitanPanelSnoozeButton:SetPoint("LEFT","TitanPanelACWButton","RIGHT",1,1);
end

function TitanPanelACWButton_OnLoad()
	this.registry={
		id="ACW",
		menuText=ACW_ACW,
		buttonTextFunction="TitanPanelACWButton_GetButtonText",
		tooltipTitle = ACW_ACW,
		tooltipTextFunction = "TitanPanelACWButton_GetTooltipText",
		frequency=TITAN_ACW_FREQUENCY,
	}

    -- Register events
	this:RegisterEvent("VARIABLES_LOADED");

	TITAN_ACWOptions = { };

	-- clock stuff
	TITAN_ACWOptions.on = ACW_DEFAULT_ON;
	TITAN_ACWOptions.locked = ACW_DEFAULT_LOCKED;
	TITAN_ACWOptions.timeformat = ACW_DEFAULT_TIMEFORMAT;
	TITAN_ACWOptions.offset = ACW_DEFAULT_OFFSET;
	TITAN_ACWOptions.offsetminute = ACW_DEFAULT_OFFSET;

	-- alarm stuff
	TITAN_ACWOptions.alarm1on = ACW_DEFAULT_ALARMON;
	TITAN_ACWOptions.alarm2on = ACW_DEFAULT_ALARMON;
	TITAN_ACWOptions.alarm3on = ACW_DEFAULT_ALARMON;

	TITAN_ACWOptions.alarm1text = ACW_DEFAULT_ALARMTEXT;
	TITAN_ACWOptions.alarm2text = ACW_DEFAULT_ALARMTEXT;
	TITAN_ACWOptions.alarm3text = ACW_DEFAULT_ALARMTEXT;

	TITAN_ACWOptions.alarm1hour = ACW_DEFAULT_ALARMHOUR;
	TITAN_ACWOptions.alarm2hour = ACW_DEFAULT_ALARMHOUR;
	TITAN_ACWOptions.alarm3hour = ACW_DEFAULT_ALARMHOUR;

	TITAN_ACWOptions.alarm1minute = ACW_DEFAULT_ALARMMINUTE;
	TITAN_ACWOptions.alarm2minute = ACW_DEFAULT_ALARMMINUTE;
	TITAN_ACWOptions.alarm3minute = ACW_DEFAULT_ALARMMINUTE;

	TITAN_ACWOptions.snoozetime = ACW_DEFAULT_SNOOZETIME;

	TITAN_ACWOptions.mode = ACW_DEFAULT_MODE;
end


function TitanPanelACWButton_OnEvent()
	TitanPanelButton_UpdateButton("ACW");
	TitanPanelButton_UpdateTooltip();

	if (event == "VARIABLES_LOADED") then
		-- per character settings
		ACW_REALM_NAME = GetCVar("realmName");
		ACW_SAVE_PREFIX = ACW_REALM_NAME;
				
		TITAN_ACWOptions.offset = TITAN_ACWOptions[ACW_SAVE_PREFIX.."offset"];
		--dout("TITAN_ACWOptions["..ACW_SAVE_PREFIX.."offset] = "..TITAN_ACWOptions[ACW_SAVE_PREFIX.."offset"]);
		if (TITAN_ACWOptions.offset == nil) then
			TITAN_ACWOptions.offset = ACW_DEFAULT_OFFSET;
		end

		TITAN_ACWOptions.offsetminute = TITAN_ACWOptions[ACW_SAVE_PREFIX.."offsetminute"];
		if (TITAN_ACWOptions.offsetminute == nil) then
			TITAN_ACWOptions.offsetminute = ACW_DEFAULT_OFFSET;
		end

		if (TitanClockSettings) then
			TitanClockSettings.OffsetHour = TITAN_ACWOptions.offset;
		end

		if (TITAN_ACWOptions.mode == TITAN_ACW_COMPACT_MODE) then
			TitanPanelACWButton_SetCompactMode();
		else
			TitanPanelACWButton_SetNormalMode();
		end
	end
end


function TitanPanelACWButton_Dummy()
	return;
end


function TITAN_ACW_Reset()
	TITAN_ACWOptions.on = ACW_DEFAULT_ON;
	TITAN_ACWOptions.locked = ACW_DEFAULT_LOCKED;
	TITAN_ACWOptions.timeformat = ACW_DEFAULT_TIMEFORMAT;
	TITAN_ACWOptions.offset = ACW_DEFAULT_OFFSET;
	TITAN_ACWOptions[ACW_SAVE_PREFIX.."offset"] = TITAN_ACWOptions.offset;
	TITAN_ACWOptions.offsetminute = ACW_DEFAULT_OFFSET;
	TITAN_ACWOptions[ACW_SAVE_PREFIX.."offsetminute"] = TITAN_ACWOptions.offsetminute;

	if (TitanClockSettings) then
		TitanClockSettings.OffsetHour = TITAN_ACWOptions.offset;
	end
	
	TITAN_ACWOptions.alarm1on = ACW_DEFAULT_ALARMON;
	TITAN_ACWOptions.alarm2on = ACW_DEFAULT_ALARMON;
	TITAN_ACWOptions.alarm3on = ACW_DEFAULT_ALARMON;
	
	TITAN_ACWOptions.alarm1text = ACW_DEFAULT_ALARMTEXT;
	TITAN_ACWOptions.alarm2text = ACW_DEFAULT_ALARMTEXT;
	TITAN_ACWOptions.alarm3text = ACW_DEFAULT_ALARMTEXT;

	TITAN_ACWOptions.alarm1hour = ACW_DEFAULT_ALARMHOUR;
	TITAN_ACWOptions.alarm2hour = ACW_DEFAULT_ALARMHOUR;
	TITAN_ACWOptions.alarm3hour = ACW_DEFAULT_ALARMHOUR;

	TITAN_ACWOptions.alarm1minute = ACW_DEFAULT_ALARMMINUTE;
	TITAN_ACWOptions.alarm2minute = ACW_DEFAULT_ALARMMINUTE;
	TITAN_ACWOptions.alarm3minute = ACW_DEFAULT_ALARMMINUTE;

	TITAN_ACWOptions.snoozetime = ACW_DEFAULT_SNOOZETIME;

	ACW_ALARM1_SNOOZING = 0;
	ACW_ALARM2_SNOOZING = 0;
	ACW_ALARM3_SNOOZING = 0;

	ACW_ALARM1_SNOOZE_HOUR = 0;
	ACW_ALARM2_SNOOZE_HOUR = 0;
	ACW_ALARM3_SNOOZE_HOUR = 0;

	ACW_ALARM1_SNOOZE_MINUTE = 0;
	ACW_ALARM2_SNOOZE_MINUTE = 0;
	ACW_ALARM3_SNOOZE_MINUTE = 0;

	ACW_ALARM1_SNOOZE_TIME = 0;
	ACW_ALARM2_SNOOZE_TIME = 0;
	ACW_ALARM3_SNOOZE_TIME = 0;

	ACW_ALARM1_ALARMED = 0;
	ACW_ALARM2_ALARMED = 0;
	ACW_ALARM3_ALARMED = 0;

	ACW_ALARM1_SNOOZE_ALARMED=0;
	ACW_ALARM2_SNOOZE_ALARMED=0;
	ACW_ALARM3_SNOOZE_ALARMED=0;

	ACW_ELAPSE_CTR1 = 0;
	ACW_ELAPSE_CTR2 = 0;
	ACW_ELAPSE_CTR3 = 0;

	ACW_ACKNOWLEDGE_ALARMS = 0;

	TitanPanelACWButton_SetNormalMode();
	
	TitanPanelSnoozeButton:Hide();
	TitanPanelAcknowledgeButton:Hide();
end


function TITAN_ACW_Alarm(msg)
	UIErrorsFrame:AddMessage(msg, 1.0, 0.0, 0.0, 1.0, ACW_ALARM_DURATION);
	
	TITAN_ACW_BlueButton:SetTexCoord(0.5,0.75,0,1);
	TITAN_ACW_RedButton:SetTexCoord(0,0.25,0,1);
	TitanPanelSnoozeButton:Show();
	TitanPanelAcknowledgeButton:Show();
	PlaySoundFile("Interface\\AddOns\\TitanAlarmClockWrangler\\bell.wav");
end


function TITAN_ACW_Snooze()
	if (ACW_ALARM1_ALARMED == 1) then
		ACW_ALARM1_SNOOZING = 1;
		ACW_ALARM1_SNOOZE_HOUR, ACW_ALARM1_SNOOZE_MINUTE = GetGameTime();
		ACW_ALARM1_SNOOZE_TIME = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM1.." "..ACW_SNOOZING, 1.0, 0.0, 0.0);
		ACW_ALARM1_ALARMED=0;
		ACW_ELAPSE_CTR1 = 0;
		ACW_ACKNOWLEDGE_ALARM1 = 1;
		TITAN_ACW_BlueButton:SetTexCoord(0.25,0.5,0,1);
	end

	if (ACW_ALARM2_ALARMED == 1) then
		ACW_ALARM2_SNOOZING = 1;
		ACW_ALARM2_SNOOZE_HOUR, ACW_ALARM2_SNOOZE_MINUTE = GetGameTime();
		ACW_ALARM2_SNOOZE_TIME = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM2.." "..ACW_SNOOZING, 1.0, 0.0, 0.0);
		ACW_ALARM2_ALARMED=0;
		ACW_ELAPSE_CTR2 = 0;
		ACW_ACKNOWLEDGE_ALARM2 = 1;
		TITAN_ACW_BlueButton:SetTexCoord(0.25,0.5,0,1);
	end

	if (ACW_ALARM3_ALARMED == 1) then
		ACW_ALARM3_SNOOZING = 1;
		ACW_ALARM3_SNOOZE_HOUR, ACW_ALARM3_SNOOZE_MINUTE = GetGameTime();
		ACW_ALARM3_SNOOZE_TIME = 0;
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM3.." "..ACW_SNOOZING, 1.0, 0.0, 0.0);
		ACW_ALARM3_ALARMED=0;
		ACW_ELAPSE_CTR3 = 0;
		ACW_ACKNOWLEDGE_ALARM3 = 1;
		TITAN_ACW_BlueButton:SetTexCoord(0.25,0.5,0,1);
	end
end


function TITAN_ACW_AcknowledgeAlarm()
	if (ACW_ALARM1_ALARMED == 1 or ACW_ALARM1_SNOOZING == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM1.." "..ACW_ACKNOWLEDGED, 1.0, 0.0, 0.0);
		ACW_ALARM1_ALARMED=0;
		ACW_ALARM1_SNOOZING = 0;
		ACW_ACKNOWLEDGE_ALARM1 = 1;
		if (TITAN_ACWOptions.mode == TITAN_ACW_NORMAL_MODE) then
			TitanPanelSnoozeButton:Hide();
			TitanPanelAcknowledgeButton:Hide();
		end

		TITAN_ACW_BlueButton:SetTexCoord(0.25,0.5,0,1);
		TITAN_ACW_RedButton:SetTexCoord(0.25,0.5,0,1);
	end

	if (ACW_ALARM2_ALARMED == 1 or ACW_ALARM2_SNOOZING == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM2.." "..ACW_ACKNOWLEDGED, 1.0, 0.0, 0.0);
		ACW_ALARM2_ALARMED=0;
		ACW_ALARM2_SNOOZING = 0;
		ACW_ACKNOWLEDGE_ALARM2 = 1;
		if (TITAN_ACWOptions.mode == TITAN_ACW_NORMAL_MODE) then
			TitanPanelSnoozeButton:Hide();
			TitanPanelAcknowledgeButton:Hide();
		end

		TITAN_ACW_BlueButton:SetTexCoord(0.25,0.5,0,1);
		TITAN_ACW_RedButton:SetTexCoord(0.25,0.5,0,1);
	end

	if (ACW_ALARM3_ALARMED == 1 or ACW_ALARM3_SNOOZING == 1) then
		DEFAULT_CHAT_FRAME:AddMessage(ACW_SNOOZE..ACW_ALARM3.." "..ACW_ACKNOWLEDGED, 1.0, 0.0, 0.0);
		ACW_ALARM3_ALARMED=0;
		ACW_ALARM3_SNOOZING = 0;
		ACW_ACKNOWLEDGE_ALARM3 = 1;
		if (TITAN_ACWOptions.mode == TITAN_ACW_NORMAL_MODE) then
			TitanPanelSnoozeButton:Hide();
			TitanPanelAcknowledgeButton:Hide();
		end

		TITAN_ACW_BlueButton:SetTexCoord(0.25,0.5,0,1);
		TITAN_ACW_RedButton:SetTexCoord(0.25,0.5,0,1);
	end
end

function TITAN_ACW_OnMouseDown(arg1)
	ShowUIPanel(TITAN_ACW_Options);
	PlaySound("igMainMenuOpen");
end


function TitanPanelACWButton_OnUpdate(elapsed)
	-- Get server time
	local hour, minute = GetGameTime();
	
	-- Apply the offset option
	hour = hour + TITAN_ACWOptions.offset;
	if (hour >= 24) then
		hour = hour - 24;
	elseif (hour < 0) then
		hour = hour + 24;
	end

	-- Apply the minute offset option
	minute = minute + TITAN_ACWOptions.offsetminute;
	if (minute < 0) then
		minute = minute + 60;
		hour = hour - 1;

		if (hour < 0) then
			hour = 23;
		end
	elseif (minute >= 60) then
		minute = minute - 60;
		hour = hour + 1;

		if (hour > 23) then
			hour = 0;
		end
	end

	-- Check for alarms
	if (TITAN_ACWOptions.alarm1on == 1) then
		if (ACW_ALARM1_ALARMED==1 or ACW_ALARM1_SNOOZING == 1) then
			ACW_ELAPSE_CTR1 = ACW_ELAPSE_CTR1 + elapsed;
		end
		
		if (ACW_ACKNOWLEDGE_ALARM1 == 0) then
			if ((TITAN_ACWOptions.alarm1hour == hour and TITAN_ACWOptions.alarm1minute == minute and ACW_ALARM1_ALARMED==0) 
				or (ACW_ALARM1_ALARMED==1 and ACW_ELAPSE_CTR1 >= ACW_REALARMTIME) 
				or (ACW_ALARM1_SNOOZING == 1 and ACW_ELAPSE_CTR1 >= TITAN_ACWOptions.snoozetime)) then
				ACW_ALARM1_ALARMED=1;
				TITAN_ACW_Alarm(TITAN_ACWOptions.alarm1text);
				ACW_ELAPSE_CTR1 = 0;
				ACW_ALARM1_SNOOZING = 0;
			end		
		end

		if (ACW_ACKNOWLEDGE_ALARM1 == 1 and TITAN_ACWOptions.alarm1minute ~= minute) then
			ACW_ACKNOWLEDGE_ALARM1 = 0;
		end
	end
	if (TITAN_ACWOptions.alarm2on == 1) then
		if (ACW_ALARM2_ALARMED==1 or ACW_ALARM2_SNOOZING == 1) then
			ACW_ELAPSE_CTR2 = ACW_ELAPSE_CTR2 + elapsed;
		end
		
		if (ACW_ACKNOWLEDGE_ALARM2 == 0) then
			if ((TITAN_ACWOptions.alarm2hour == hour and TITAN_ACWOptions.alarm2minute == minute and ACW_ALARM2_ALARMED==0) 
				or (ACW_ALARM2_ALARMED==1 and ACW_ELAPSE_CTR2 >= ACW_REALARMTIME) 
				or (ACW_ALARM2_SNOOZING == 1 and ACW_ELAPSE_CTR2 >= TITAN_ACWOptions.snoozetime)) then
				ACW_ALARM2_ALARMED=1;
				TITAN_ACW_Alarm(TITAN_ACWOptions.alarm2text);
				ACW_ELAPSE_CTR2 = 0;
				ACW_ALARM2_SNOOZING = 0;
			end		
		end

		if (ACW_ACKNOWLEDGE_ALARM2 == 1 and TITAN_ACWOptions.alarm2minute ~= minute) then
			ACW_ACKNOWLEDGE_ALARM2 = 0;
		end
	end
	if (TITAN_ACWOptions.alarm3on == 1) then
		if (ACW_ALARM3_ALARMED==1 or ACW_ALARM3_SNOOZING == 1) then
			ACW_ELAPSE_CTR3 = ACW_ELAPSE_CTR3 + elapsed;
		end
		
		if (ACW_ACKNOWLEDGE_ALARM3 == 0) then
			if ((TITAN_ACWOptions.alarm3hour == hour and TITAN_ACWOptions.alarm3minute == minute and ACW_ALARM3_ALARMED==0) 
				or (ACW_ALARM3_ALARMED==1 and ACW_ELAPSE_CTR3 >= ACW_REALARMTIME) 
				or (ACW_ALARM3_SNOOZING == 1 and ACW_ELAPSE_CTR3 >= TITAN_ACWOptions.snoozetime)) then
				ACW_ALARM3_ALARMED=1;
				TITAN_ACW_Alarm(TITAN_ACWOptions.alarm3text);
				ACW_ELAPSE_CTR3 = 0;
				ACW_ALARM3_SNOOZING = 0;
			end		
		end

		if (ACW_ACKNOWLEDGE_ALARM3 == 1 and TITAN_ACWOptions.alarm3minute ~= minute) then
			ACW_ACKNOWLEDGE_ALARM3 = 0;
		end
	end

	-- Check the time format option
	if (TITAN_ACWOptions.timeformat == 24) then
		TITAN_ACW_TIME_STR = format(TEXT(TIME_TWENTYFOURHOURS), hour, minute);
		--InfoBarAlarmClockWranglerCenteredText:SetText(format(TEXT(TIME_TWENTYFOURHOURS), hour, minute));
	else
		local pm = 0;
		if (hour >= 12) then
			pm = 1;
		end
		if (hour > 12) then
			hour = hour - 12;
		end
		if (hour == 0) then
			hour = 12;
		end
		
		if (pm == 0) then
			TITAN_ACW_TIME_STR = format(TEXT(TIME_TWELVEHOURAM), hour, minute);
			--InfoBarAlarmClockWranglerCenteredText:SetText(string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURAM), hour, minute),1,5)," ","")..ACW_AM);
		else
			TITAN_ACW_TIME_STR = format(TEXT(TIME_TWELVEHOURPM), hour, minute);
			--InfoBarAlarmClockWranglerCenteredText:SetText(string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURPM), hour, minute),1,5)," ","")..ACW_PM);
		end
	end
end

function TitanPanelACWButton_GetButtonText(id)
	if (TITAN_ACW_OLD_CLOCK_FUNCTION == nil) then
		TITAN_ACW_OLD_CLOCK_FUNCTION = TitanPanelClockButton_GetButtonText;
	end
	
	if (TITAN_ACW_HIDE_CLOCK == 1) then
		TitanPanelClockButton_GetButtonText = TitanPanelACWButton_Dummy;
	elseif (TITAN_ACW_OLD_CLOCK_FUNCTION ~= nil) then
		TitanPanelClockButton_GetButtonText = TITAN_ACW_OLD_CLOCK_FUNCTION;
	end

	if (TITAN_ACWOptions.mode == TITAN_ACW_COMPACT_MODE) then
	--	TitanPanelACWButton_SetCompactMode();
		return "";
	end
	
	--TitanPanelACWButton_SetNormalMode();
	return TITAN_ACW_TIME_STR;
end

function TitanPanelACWButton_GetTooltipText()
		local statusStr1 = ACW_STATUS;
	local statusStr2 = ACW_CURRENTLY_ALARMING;
	local statusStr3 = ACW_CURRENTLY_SNOOZING;
	local statusStr4 = ACW_ALARM_STATUS;
	local statusStr5 = ACW_ALARM1..": ";
	local statusStr5a = "";
	local statusStr6 = ACW_ALARM2..": ";
	local statusStr6a = "";
	local statusStr7 = ACW_ALARM3..": ";
	local statusStr7a = "";
	local statusStr8 = ACW_SERVER_TIME_STATUS;
	local statusStr9 = ACW_TIME;
	local statusStr10 = ACW_TOD;

	local firstItem = true;

	if (ACW_ALARM1_ALARMED == 1) then
		statusStr2 = statusStr2..TitanUtils_GetHighlightText(ACW_ALARM1);
		firstItem = false;
	end
	if (ACW_ALARM2_ALARMED == 1) then
		if (firstItem == false) then
			statusStr2 = statusStr2..TitanUtils_GetHighlightText(", ");
		end
		statusStr2 = statusStr2..TitanUtils_GetHighlightText(ACW_ALARM2);
		firstItem = false;
	end
	if (ACW_ALARM3_ALARMED == 1) then
		if (firstItem == false) then
			statusStr2 = statusStr2..TitanUtils_GetHighlightText(", ");
		end
		statusStr2 = statusStr2..TitanUtils_GetHighlightText(ACW_ALARM3);
		firstItem = false;
	end
	if (firstItem == true) then
		statusStr2 = statusStr2..TitanUtils_GetHighlightText(ACW_NONE);
	end

	
	firstItem = true;
	if (ACW_ALARM1_SNOOZING == 1) then
		statusStr3 = statusStr3..TitanUtils_GetHighlightText(ACW_ALARM1);
		firstItem = false;
	end
	if (ACW_ALARM2_SNOOZING == 1) then
		if (firstItem == false) then
			statusStr3 = statusStr3..TitanUtils_GetHighlightText(", ");
		end
		statusStr3 = statusStr3..TitanUtils_GetHighlightText(ACW_ALARM2);
		firstItem = false;
	end
	if (ACW_ALARM3_SNOOZING == 1) then
		if (firstItem == false) then
			statusStr3 = statusStr3..TitanUtils_GetHighlightText(", ");
		end
		statusStr3 = statusStr3..TitanUtils_GetHighlightText(ACW_ALARM3);
		firstItem = false;
	end
	if (firstItem == true) then
		statusStr3 = statusStr3..TitanUtils_GetHighlightText(ACW_NONE);
	end


	local meridian1 = "";
	local meridian2 = "";
	local meridian3 = "";
	if (TITAN_ACWOptions.timeformat == 24) then
		statusStr5a = statusStr5a..TitanUtils_GetHighlightText("("..TITAN_ACWOptions.alarm1hour..":");
		statusStr6a = statusStr6a..TitanUtils_GetHighlightText("("..TITAN_ACWOptions.alarm2hour..":");
		statusStr7a = statusStr7a..TitanUtils_GetHighlightText("("..TITAN_ACWOptions.alarm3hour..":");
	else 
		local hour = TITAN_ACWOptions.alarm1hour;
		
		if (hour > 12) then
			hour = hour -12;
			meridian1 = ACW_PM;
		elseif (hour >= 12) then
			meridian1 = ACW_PM;	
		elseif (hour == 0) then
			hour = 12;
			meridian1 = ACW_AM;
		else
			meridian1 = ACW_AM;
		end
		statusStr5a = statusStr5a..TitanUtils_GetHighlightText("("..hour..":");

		hour = TITAN_ACWOptions.alarm2hour;
		
		if (hour > 12) then
			hour = hour -12;
			meridian2 = ACW_PM;
		elseif (hour >= 12) then
			meridian2 = ACW_PM;
		elseif (hour == 0) then
			hour = 12;
			meridian2 = ACW_AM;
		else
			meridian2 = ACW_AM;
		end
		statusStr6a = statusStr6a..TitanUtils_GetHighlightText("("..hour..":");

		hour = TITAN_ACWOptions.alarm3hour;
		
		if (hour > 12) then
			hour = hour -12;
			meridian3 = ACW_PM;
		elseif (hour >= 12) then
			meridian3 = ACW_PM;
		elseif (hour == 0) then
			hour = 12;
			meridian3 = ACW_AM;
		else
			meridian3 = ACW_AM;
		end
		statusStr7a = statusStr7a..TitanUtils_GetHighlightText("("..hour..":");
	end

	local minuteStr = ""..TITAN_ACWOptions.alarm1minute;
	if (TITAN_ACWOptions.alarm1minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	
	local onStr;
	if (TITAN_ACWOptions.alarm1on == 1) then
		onStr = TitanUtils_GetGreenText(ACW_STR_ON);
	else
		onStr = TitanUtils_GetRedText(ACW_STR_OFF);
	end

	statusStr5 = statusStr5..onStr;
	statusStr5a = statusStr5a..TitanUtils_GetHighlightText(minuteStr..meridian1..")");


	minuteStr = ""..TITAN_ACWOptions.alarm2minute;
	if (TITAN_ACWOptions.alarm2minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	local onStr;
	if (TITAN_ACWOptions.alarm2on == 1) then
		onStr = TitanUtils_GetGreenText(ACW_STR_ON);
	else
		onStr = TitanUtils_GetRedText(ACW_STR_OFF);
	end

	statusStr6 = statusStr6..onStr;
	statusStr6a = statusStr6a..TitanUtils_GetHighlightText(minuteStr..meridian2..")");


	minuteStr = ""..TITAN_ACWOptions.alarm3minute;
	if (TITAN_ACWOptions.alarm3minute < 10) then -- pad
		minuteStr = "0"..minuteStr;
	end
	
	local onStr;
	if (TITAN_ACWOptions.alarm3on == 1) then
		onStr = TitanUtils_GetGreenText(ACW_STR_ON);
	else
		onStr = TitanUtils_GetRedText(ACW_STR_OFF);
	end

	statusStr7 = statusStr7..onStr;
	statusStr7a = statusStr7a..TitanUtils_GetHighlightText(minuteStr..meridian3..")");

	-- Check the time format option
	local hour, minute = GetGameTime();
	local time = (hour * 60) + minute;
	
	if(time < GAMETIME_DAWN or time >= GAMETIME_DUSK) then -- night
		statusStr10 = statusStr10..TitanUtils_GetHighlightText(ACW_STR_NIGHT);
	else
		statusStr10 = statusStr10..TitanUtils_GetHighlightText(ACW_STR_DAY);
	end
	
	
	if (TITAN_ACWOptions.timeformat == 24) then
		statusStr9 = statusStr9..TitanUtils_GetHighlightText("("..format(TEXT(TIME_TWENTYFOURHOURS), hour, minute)..")");
	else
		local pm = 0;
		if (hour >= 12) then
			pm = 1;
		end
		if (hour > 12) then
			hour = hour - 12;
		end
		if (hour == 0) then
			hour = 12;
		end
		if (pm == 0) then
			statusStr9 = statusStr9..TitanUtils_GetHighlightText("("..string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURAM), hour, minute),1,5)," ","").." AM"..")");
		else
			statusStr9 = statusStr9..TitanUtils_GetHighlightText("("..string.gsub(string.sub(format(TEXT(TIME_TWELVEHOURPM), hour, minute),1,5)," ","").." PM"..")");
		end
	end

	return	statusStr2.."\n"..
			statusStr3.."\n\n"..
			TitanUtils_GetHighlightText(statusStr4).."\n"..
			statusStr5.." "..statusStr5a.."\n"..
			statusStr6.." "..statusStr6a.."\n"..
			statusStr7.." "..statusStr7a.."\n\n"..
			TitanUtils_GetHighlightText(statusStr8).."\n"..
			statusStr9.."\n"..
			statusStr10;
end


function TITAN_ACW_ButtonTooltips()
	GameTooltip:SetOwner(this, "ANCHOR_NONE");
	
	local x,y = this:GetCenter();
	local xPos = 0;
	local yPos = 0;
	local anchor,relative,parent,text;
	if( y  < GetScreenHeight() / 2 ) then
		anchor = "BOTTOM";
		relative = "TOP";
	else
		anchor = "TOP";
		relative = "BOTTOM";
		yPos = yPos - 15;
	end	

	if( x < GetScreenWidth() / 2 ) then
		anchor = anchor.."LEFT";
		relative = relative.."LEFT";
	else
		anchor = anchor.."RIGHT";
		relative = relative.."RIGHT";
	end

	if (this == TitanPanelSnoozeButton) then
		parent = "TitanPanelSnoozeButton";
		text = ACW_SNOOZE_BUTTON;
	else
		parent = "TitanPanelAcknowledgeButton";
		text = ACW_ACKNOWLEDGE_ALARMS_BUTTON;
	end
	
	GameTooltip:SetPoint(anchor, parent, relative, xPos,yPos );	
	GameTooltip:SetText(text);
	
	--GameTooltip:Show();
end
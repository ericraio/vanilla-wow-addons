gCalendarEventEditor_ShowScheduleEditor = false;
gCalendarEventEditor_Active = false;

gCalendarEventEditor_Database = nil;
gCalendarEventEditor_Event = nil;
gCalendarEventEditor_IsNewEvent = false;
gCalendarEventEditor_NewClassLimits = nil;

gCalendarEventEditor_PreviousEventType = nil;

gCalendarEventEditor_CurrentPanel = 1;
gCalendarEventEditor_UsingLocalTime = false;
gCalendarEventEditor_EventDate = nil;
gCalendarEventEditor_EventTime = nil;
gCalendarEventEditor_EventDateIsLocal = false;

gGroupCalendar_cNumAttendanceItems = 12;
gGroupCalendar_cNumAutoConfirmAttendanceItems = 11;
gGroupCalendar_cNumPlainAttendanceItems = 16;
gGroupCalendar_cAttendanceItemHeight = 16;

gCalendarEventEditor_PanelFrames =
{
	"CalendarEventEditorEventFrame",
	"CalendarEventEditorAttendanceFrame",
};

StaticPopupDialogs["CONFIRM_CALENDAR_EVENT_DELETE"] = {
	text = TEXT(CalendarEventEditor_cConfirmDeleteMsg),
	button1 = TEXT(CalendarEventEditor_cDelete),
	button2 = TEXT(CANCEL),
	OnAccept = function() CalendarEventEditor_DeleteEvent(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["CONFIRM_CALENDAR_RSVP_DELETE"] = {
	text = TEXT(GroupCalendar_cConfrimDeleteRSVP),
	button1 = TEXT(CalendarEventEditor_cDelete),
	button2 = TEXT(CANCEL),
	OnAccept = function() CalendarEventEditor_DeleteRSVP(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["CONFIRM_CALENDAR_CLEAR_WHISPERS"] = {
	text = TEXT(GroupCalendar_cConfirmClearWhispers),
	button1 = TEXT(GroupCalendar_cClear),
	button2 = TEXT(CANCEL),
	OnAccept = function() CalendarWhisperLog_Clear(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

function CalendarEventEditor_EditEvent(pDatabase, pEvent, pIsNewEvent)
	gCalendarEventEditor_Database = pDatabase;
	gCalendarEventEditor_Event = pEvent;
	gCalendarEventEditor_IsNewEvent = pIsNewEvent;
	gCalendarEventEditor_UsingLocalTime = gGroupCalendar_Settings.ShowEventsInLocalTime;
	gCalendarEventEditor_NewClassLimits = nil;
	
	CalendarAttendanceList_SetEvent(CalendarEventEditorAttendance, pDatabase, pEvent);
	
	gCalendarEventEditor_EventDateIsLocal = gCalendarEventEditor_UsingLocalTime;
	
	if pIsNewEvent then
		-- New events have their date in whatever time zone is
		-- selected for display
		
		gCalendarEventEditor_EventDate = pEvent.mDate;
		gCalendarEventEditor_EventTime = pEvent.mTime;
	else
		-- Existing events have their date in server time so
		-- convert to a local date if necessary
		
		if gCalendarEventEditor_EventDateIsLocal then
			gCalendarEventEditor_EventDate, gCalendarEventEditor_EventTime = Calendar_GetLocalDateTimeFromServerDateTime(pEvent.mDate, pEvent.mTime);
		else
			gCalendarEventEditor_EventDate = pEvent.mDate;
			gCalendarEventEditor_EventTime = pEvent.mTime;
		end
	end
	
	CalendarEventEditorFrameSubTitle:SetText(Calendar_GetLongDateString(gCalendarEventEditor_EventDate));
	
	CalendarEventEditor_UpdateControlsFromEvent(pEvent);
	
	ShowUIPanel(CalendarEventEditorFrame);
	
	if pIsNewEvent then
		CalendarEventTitle:SetFocus();
		CalendarEventTitle:HighlightText();
	else
		CalendarEventTitle:HighlightText(0, 0);
	end
	
	gCalendarEventEditor_ShowScheduleEditor = false;
	gCalendarEventEditor_Active = true;
end

function CalendarEventEditor_MajorDatabaseChange()
	if not gCalendarEventEditor_Active then
		return;
	end
	
	if gCalendarEventEditor_UsingLocalTime ~= gGroupCalendar_Settings.ShowEventsInLocalTime then
		gCalendarEventEditor_UsingLocalTime = gGroupCalendar_Settings.ShowEventsInLocalTime;
		
		gCalendarEventEditor_EventTime = CalendarEventEditor_GetTimeControlValue(CalendarEventEditorTime);
		
		if gCalendarEventEditor_UsingLocalTime then
			gCalendarEventEditor_EventDate, gCalendarEventEditor_EventTime = Calendar_GetLocalDateTimeFromServerDateTime(gCalendarEventEditor_EventDate, gCalendarEventEditor_EventTime);
		else
			gCalendarEventEditor_EventDate, gCalendarEventEditor_EventTime = Calendar_GetServerDateTimeFromLocalDateTime(gCalendarEventEditor_EventDate, gCalendarEventEditor_EventTime);
		end
		
		CalendarEventEditor_SetTimeControlValue(CalendarEventEditorTime, gCalendarEventEditor_EventTime);
	end
end

function CalendarEventEditor_EventChanged(pEvent)
	if pEvent == gCalendarEventEditor_Event then
		CalendarAttendanceList_EventChanged(CalendarEventEditorAttendance, gCalendarEventEditor_Database, pEvent);
		
		-- Don't update the control values since that'll overwrite whatever
		-- is currently being set up
		-- CalendarEventEditor_UpdateControlsFromEvent(pEvent);
		
		CalendarGroupInvites_EventChanged(pEvent);
	end
end

function CalendarEventEditor_OnLoad()
	-- Tabs
	
	PanelTemplates_SetNumTabs(this, table.getn(gCalendarEventEditor_PanelFrames));
	CalendarEventEditorFrame.selectedTab = gCalendarEventEditor_CurrentPanel;
	PanelTemplates_UpdateTabs(this);
end

function CalendarEventEditor_OnShow()
	PlaySound("igCharacterInfoOpen");
	
	CalendarEventTypeEventType.ChangedValueFunc = CalendarEventEditor_EventTypeChanged;
	
	CalendarEventEditor_ShowPanel(1); -- Always switch to the event view when showing the window
end

function CalendarEventEditor_OnHide()
	PlaySound("igCharacterInfoClose");
	
	CalendarAddPlayer_Cancel(); -- Force the dialog to close if it's open
	
	if not gCalendarEventEditor_ShowScheduleEditor then
		CalendarEventEditor_SaveEvent();
		HideUIPanel(CalendarEditorFrame);
	end
	
	gCalendarEventEditor_Database = nil;
	gCalendarEventEditor_Event = nil;
	gCalendarEventEditor_Active = false;
end

function CalendarEventEditor_DoneEditing()
	if not gCalendarEventEditor_Active then
		return;
	end
	
	CalendarEventEditor_SaveEvent();
	CalendarEventEditor_CloseEditor(true);
end

function CalendarEventEditor_UpdateControlsFromEvent(pEvent, pExistingValuesOnly)
	if not pExistingValuesOnly
	or pEvent.mType then
		CalendarDropDown_SetSelectedValue(CalendarEventTypeEventType, pEvent.mType);
	end

	if pEvent.mTitle and pEvent.mTitle ~= "" then
		CalendarEventTitle:SetText(Calendar_UnescapeString(pEvent.mTitle));
	elseif not pExistingValuesOnly
	or pEvent.mType then
		local	vEventName = EventDatabase_GetEventNameByID(pEvent.mType);
		
		if vEventName ~= nil then
			CalendarEventTitle:SetText(vEventName);
		else
			CalendarEventTitle:SetText("");
		end
	end
	
	if not pExistingValuesOnly
	or gCalendarEventEditor_EventTime then
		CalendarEventEditor_SetTimeControlValue(CalendarEventEditorTime, gCalendarEventEditor_EventTime);
	end
	
	if not pExistingValuesOnly
	or pEvent.mDuration then
		CalendarDropDown_SetSelectedValue(CalendarEventEditorDurationDuration, pEvent.mDuration);
	end

	if pEvent.mDescription then
		CalendarEventDescription:SetText(Calendar_UnescapeString(pEvent.mDescription));
	elseif not pExistingValuesOnly then
		CalendarEventDescription:SetText("");
	end

	if pEvent.mMinLevel then
		CalendarEventMinLevel:SetText(pEvent.mMinLevel);
	elseif not pExistingValuesOnly then
		CalendarEventMinLevel:SetText("");
	end

	if pEvent.mMaxLevel then
		CalendarEventMaxLevel:SetText(pEvent.mMaxLevel);
	elseif not pExistingValuesOnly then
		CalendarEventMaxLevel:SetText("");
	end
	
	if not pExistingValuesOnly
	or pEvent.mType then
		gCalendarEventEditor_PreviousEventType = pEvent.mType;
		CalendarEventEditor_SetEventType(pEvent.mType);
	end
end

function CalendarEventEditor_SaveClassLimits(pLimits)
	gCalendarEventEditor_NewClassLimits = pLimits;
end

function CalendarEventEditor_UpdateEventFromControls(rEvent, rChangedFields)
	local	vChanged = false;
	local	vValue;
	
	-- Type
	
	vValue = UIDropDownMenu_GetSelectedValue(CalendarEventTypeEventType);
	
	if rEvent.mType ~= vValue then
		rEvent.mType = vValue;
		rChangedFields.mType = {op = "UPD", val = vValue};
		vChanged = true;
	end
	
	-- Title
	
	vValue = CalendarEventTitle:GetText();
	
	if vValue == EventDatabase_GetEventNameByID(rEvent.mType)
	or vValue == "" then
		vValue = nil;
	else
		vValue = Calendar_EscapeString(vValue);
	end
	
	if rEvent.mTitle ~= vValue then
		rEvent.mTitle = vValue;
		rChangedFields.mTitle = "UPD";
		vChanged = true;
	end
	
	-- Time
	
	local	vDate, vTime = nil, nil;
	
	if EventDatabase_EventTypeUsesTime(rEvent.mType) then
		vDate, vTime = gCalendarEventEditor_EventDate, CalendarEventEditor_GetTimeControlValue(CalendarEventEditorTime);
		
		if gCalendarEventEditor_UsingLocalTime then
			vDate, vTime = Calendar_GetServerDateTimeFromLocalDateTime(vDate, vTime);
		end
	else
		vDate = gCalendarEventEditor_EventDate;
	end
	
	if rEvent.mDate ~= vDate then
		rEvent.mDate = vDate;
		rChangedFields.mDate = "UPD";
		vChanged = true;
	end
	
	if rEvent.mTime ~= vTime then
		rEvent.mTime = vTime;
		rChangedFields.mTime = "UPD";
		vChanged = true;
	end
	
	-- Duration
	
	if EventDatabase_EventTypeUsesTime(rEvent.mType) then
		vValue = UIDropDownMenu_GetSelectedValue(CalendarEventEditorDurationDuration);
	else
		vValue = nil;
	end
	
	if vValue == 0 then
		vValue = nil;
	end
	
	if rEvent.mDuration ~= vValue then
		rEvent.mDuration = vValue;
		rChangedFields.mDuration = "UPD";
		vChanged = true;
	end
	
	-- Description
	
	vValue = CalendarEventDescription:GetText();
	
	if vValue == "" then
		vValue = nil;
	else
		vValue = Calendar_EscapeString(vValue);
	end
	
	if rEvent.mDescription ~= vValue then
		rEvent.mDescription = vValue;
		rChangedFields.mDescription = "UPD";
		vChanged = true;
	end
	
	-- MinLevel
	
	if EventDatabase_EventTypeUsesLevelLimits(rEvent.mType) then
		vValue = CalendarEventMinLevel:GetText();
	else
		vValue = nil;
	end
	
	if vValue and vValue ~= "" then
		vValue = tonumber(vValue);
		
		if vValue == 0 then
			vValue = nil;
		end
	else
		vValue = nil;
	end
	
	if rEvent.mMinLevel ~= vValue then
		rEvent.mMinLevel = vValue;
		rChangedFields.mMinLevel = "UPD";
		vChanged = true;
	end
	
	-- MaxLevel
	
	if EventDatabase_EventTypeUsesTime(rEvent.mType) then
		vValue = CalendarEventMaxLevel:GetText();
	else
		vValue = nil;
	end
	
	if vValue and vValue ~= "" then
		vValue = tonumber(vValue);
		
		if vValue == 0 then
			vValue = nil;
		end
	else
		vValue = nil;
	end
	
	if rEvent.mMaxLevel ~= vValue then
		rEvent.mMaxLevel = vValue;
		rChangedFields.mMaxLevel = "UPD";
		vChanged = true;
	end
	
	-- Automatic confirmations
	
	local	vManualConfirm;
	
	if EventDatabase_IsQuestingEventType(rEvent.mType) then
		vManualConfirm = CalendarAttendanceList_GetManualConfirmEnable(CalendarEventEditorAttendance);
	else
		-- Non-questing events are always auto-confirm (ie meetings)
		
		vManualConfirm = nil;
	end
	
	if vManualConfirm ~= rEvent.mManualConfirm then
		rEvent.mManualConfirm = vManualConfirm;
		rChangedFields.mManualConfirm = {op = "UPD", val = vManualConfirm};
	end
	
	if EventDatabase_IsQuestingEventType(rEvent.mType) then
		if gCalendarEventEditor_NewClassLimits
		and CalendarClassLimits_ClassLimitsChanged(rEvent.mLimits, gCalendarEventEditor_NewClassLimits) then
			rEvent.mLimits = gCalendarEventEditor_NewClassLimits;
			rChangedFields.mLimits = {op = "UPD", val = rEvent.mLimits};
		end
	else
		-- No limits on non-questing event types (ie, meetings)
		
		if rEvent.mLimits then
			rEvent.mLimits = nil;
			rChangedFields.mLimits = {op = "UPD", val = rEvent.mLimits};
		end
	end
	
	-- Done
	
	return vChanged;
end

function CalendarEventEditor_SetEventType(pEventType)
	-- CalendarEventTypeEventType:Show();
	-- CalendarEventTitle:Show();
	-- CalendarEventDescription:Show();
	
	local	vTitleText = CalendarEventTitle:GetText();
	local	vEventName = EventDatabase_GetEventNameByID(gCalendarEventEditor_PreviousEventType);
	local	vTitleWasEventName = vTitleText == vEventName;
	
	if EventDatabase_EventTypeUsesTime(pEventType) then
		CalendarEventEditorTime:Show();
		CalendarEventEditorDuration:Show();
	else
		CalendarEventEditorTime:Hide();
		CalendarEventEditorDuration:Hide();
	end
	
	if EventDatabase_EventTypeUsesLevelLimits(pEventType) then
		CalendarEventMinLevel:Show();
		CalendarEventMaxLevel:Show();
	else
		CalendarEventMinLevel:Hide();
		CalendarEventMaxLevel:Hide();
	end
	
	if EventDatabase_EventTypeUsesAttendance(pEventType) then
		CalendarEventEditorFrameTab2:Show();
		CalendarEventEditorSelfAttend:Show();
	else
		CalendarEventEditorFrameTab2:Hide();
		CalendarEventEditorSelfAttend:Hide();
	end
	
	if vTitleWasEventName then
		CalendarEventTitle:SetText(EventDatabase_GetEventNameByID(pEventType));
		CalendarEventTitle:SetFocus();
		CalendarEventTitle:HighlightText();
	end
	
	-- Update the sample icon
	
	CalendarEventEditorEventBackground:SetTexture(Calendar_GetEventTypeIconPath(pEventType));
	if pEventType == "Birth" then
		CalendarEventEditorEventBackground:SetVertexColor(1, 1, 1, 0.4);
	else
		CalendarEventEditorEventBackground:SetVertexColor(1, 1, 1, 0.19);
	end

	--
	
	gCalendarEventEditor_PreviousEventType = pEventType;
end

function CalendarEventEditor_DeleteEvent()
	if not gCalendarEventEditor_IsNewEvent then
		EventDatabase_DeleteEvent(gCalendarEventEditor_Database, gCalendarEventEditor_Event);
	end
	
	CalendarEventEditor_CloseEditor(true);
end

function CalendarEventEditor_DeleteRSVP()
	if not gGroupCalendar_RSVPToDelete then
		return;
	end
	
	gGroupCalendar_RSVPToDelete.mStatus = "-";
	
	EventDatabase_AddEventRSVP(
			gCalendarEventEditor_Database,
			gCalendarEventEditor_Event,
			gGroupCalendar_RSVPToDelete.mName,
			gGroupCalendar_RSVPToDelete);
	
	gGroupCalendar_RSVPToDelete = nil;
end

function CalendarEventEditor_CloseEditor(pShowScheduleEditor)
	gCalendarEventEditor_Active = false;
	
	gCalendarEventEditor_ShowScheduleEditor = pShowScheduleEditor;
	HideUIPanel(CalendarEventEditorFrame);
end

function CalendarEventEditor_CopyTemplateFields(pFromEvent, rToEvent)
	rToEvent.mTitle = pFromEvent.mTitle;
	rToEvent.mDescription = pFromEvent.mDescription;
	rToEvent.mTime = pFromEvent.mTime;
	rToEvent.mDuration = pFromEvent.mDuration;
	rToEvent.mMinLevel = pFromEvent.mMinLevel;
	rToEvent.mMaxLevel = pFromEvent.mMaxLevel;

	rToEvent.mManualConfirm = pFromEvent.mManualConfirm;
	rToEvent.mLimits = pFromEvent.mLimits;
end

function CalendarEventEditor_SaveEvent()
	-- Update the event
	
	local	vChangedFields = {};
	
	CalendarEventEditor_UpdateEventFromControls(gCalendarEventEditor_Event, vChangedFields);
	
	if Calendar_ArrayIsEmpty(vChangedFields) then
		return;
	end
	
	-- Save the event if it's new
	
	if gCalendarEventEditor_IsNewEvent then
		if (gCalendarEventEditor_Event.mTitle ~= nil and gCalendarEventEditor_Event.mTitle ~= "")
		or gCalendarEventEditor_Event.mType ~= nil then
			EventDatabase_AddEvent(gCalendarEventEditor_Database, gCalendarEventEditor_Event);
		end
	else
		EventDatabase_EventChanged(gCalendarEventEditor_Database, gCalendarEventEditor_Event, vChangedFields);
	end
	
	-- Save a template for the event
	
	if gCalendarEventEditor_Event.mType
	and gCalendarEventEditor_Event.mType ~= "Birth" then
		if not gGroupCalendar_PlayerSettings.EventTemplates then
			gGroupCalendar_PlayerSettings.EventTemplates = {};
		end
		
		local	vEventTemplate = {};
		
		CalendarEventEditor_CopyTemplateFields(gCalendarEventEditor_Event, vEventTemplate);
		vEventTemplate.mSelfAttend = CalendarEventEditor_GetSelfAttend();
		
		gGroupCalendar_PlayerSettings.EventTemplates[gCalendarEventEditor_Event.mType] = vEventTemplate;
	end
end

function CalendarEventEditor_SetTimeControlValue(pFrame, pTime)
	if pTime == nil then
		return;
	end
	
	local	vFrameName = pFrame:GetName();
	
	local	vHourFrame = getglobal(vFrameName.."Hour");
	local	vMinuteFrame = getglobal(vFrameName.."Minute");
	local	vAMPMFrame = getglobal(vFrameName.."AMPM");
	
	if TwentyFourHourTime then
		local	vHour, vMinute = Calendar_ConvertTimeToHM(pTime);
		
		CalendarDropDown_SetSelectedValue(vHourFrame, vHour);
		CalendarDropDown_SetSelectedValue(vMinuteFrame, vMinute);
		vAMPMFrame:Hide();
	else
		local	vHour, vMinute, vAMPM = Calendar_ConvertTimeToHMAMPM(pTime);
		
		CalendarDropDown_SetSelectedValue(vHourFrame, vHour);
		CalendarDropDown_SetSelectedValue(vMinuteFrame, vMinute);
		
		vAMPMFrame:Show();
		CalendarDropDown_SetSelectedValue(vAMPMFrame, vAMPM);
	end
end

function CalendarEventEditor_GetTimeControlValue(pFrame)
	local	vFrameName = pFrame:GetName();
	
	local	vHourFrame = getglobal(vFrameName.."Hour");
	local	vMinuteFrame = getglobal(vFrameName.."Minute");
	local	vAMPMFrame = getglobal(vFrameName.."AMPM");
	
	local	vHour = UIDropDownMenu_GetSelectedValue(vHourFrame);
	local	vMinute = UIDropDownMenu_GetSelectedValue(vMinuteFrame);
	
	if TwentyFourHourTime then
		return Calendar_ConvertHMToTime(vHour, vMinute);
	else
		local	vAMPM = UIDropDownMenu_GetSelectedValue(vAMPMFrame);
		
		return Calendar_ConvertHMAMPMToTime(vHour, vMinute, vAMPM);
	end
end

function CalendarEventEditor_EventTypeChanged(pMenuFrame, pValue)
	CalendarEventEditor_SetEventType(pValue);
	
	-- Set the templated field values if available
	
	if gCalendarEventEditor_IsNewEvent then
		-- Set the default limits for this dungeon (the template will
		-- override this if it's present)
		
		gCalendarEventEditor_Event.mLimits = EventDatabase_GetStandardLimitsByID(pValue);
		
		-- Copy of template values
		
		if gGroupCalendar_PlayerSettings.EventTemplates then
			local	vEventTemplate = gGroupCalendar_PlayerSettings.EventTemplates[pValue];
			
			if vEventTemplate then
				CalendarEventEditor_CopyTemplateFields(vEventTemplate, gCalendarEventEditor_Event);
				
				CalendarEventEditor_UpdateControlsFromEvent(gCalendarEventEditor_Event, true);
				
				if vEventTemplate.mSelfAttend then
					CalendarEventEditor_SetSelfAttend(vEventTemplate.mSelfAttend);
				end
			end
		end
	end
end

function CalendarEventEditor_ShowPanel(pPanelIndex)
	CalendarAddPlayer_Cancel(); -- Force the dialog to close if it's open
	
	if gCalendarEventEditor_CurrentPanel > 0
	and gCalendarEventEditor_CurrentPanel ~= pPanelIndex then
		CalendarEventEditor_HidePanel(gCalendarEventEditor_CurrentPanel);
	end
	
	-- NOTE: Don't check for redundant calls since this function
	-- will be called to reset the field values as well as to 
	-- actuall show the panel when it's hidden
	
	gCalendarEventEditor_CurrentPanel = pPanelIndex;
	
	-- Update the control values
	
	if pPanelIndex == 1 then
		-- Event panel
		
		CalendarEventEditorSelfAttend:SetChecked(CalendarEventEditor_GetSelfAttend());
		CalendarEventEditorSelfAttendText:SetText(string.format(GroupCalendar_cSelfWillAttend, gGroupCalendar_PlayerName));
		
	elseif pPanelIndex == 2 then
		-- Attendance panel
		
		if EventDatabase_IsQuestingEventType(gCalendarEventEditor_PreviousEventType) then
			CalendarAttendanceList_SetClassTotalsVisible(CalendarEventEditorAttendance, true, true);
		else
			CalendarAttendanceList_SetClassTotalsVisible(CalendarEventEditorAttendance, false, false);
		end
	else
		Calendar_DebugMessage("CalendarEventEditor_ShowPanel: Unknown index ("..pPanelIndex..")");
	end
	
	getglobal(gCalendarEventEditor_PanelFrames[pPanelIndex]):Show();
	
	PanelTemplates_SetTab(CalendarEventEditorFrame, pPanelIndex);
	
	CalendarEventEditor_Update();
end

function CalendarEventEditor_HidePanel(pFrameIndex)
	if gCalendarEventEditor_CurrentPanel ~= pFrameIndex then
		return;
	end
	
	getglobal(gCalendarEventEditor_PanelFrames[pFrameIndex]):Hide();
	gCalendarEventEditor_CurrentPanel = 0;
end

function CalendarEventEditor_Update()
	-- Event panel
	
	if gCalendarEventEditor_CurrentPanel == 1 then
	
	-- Attendance panel
	
	elseif gCalendarEventEditor_CurrentPanel == 2 then
		CalendarAttendanceList_Update(CalendarEventEditorAttendance);
	end
end

Calendar_cStatusCodeStrings =
{
	N = CalendarEventEditor_cNotAttending,
	Y = CalendarEventEditor_cConfirmed,
	D = CalendarEventEditor_cDeclined,
	S = CalendarEventEditor_cStandby,
	P = CalendarEventEditor_cPending,
	Q = CalendarEventEditor_cQueued,
};

function CalendarEventEditor_GetStatusString(pStatus)
	local	vStatus1 = string.sub(pStatus, 1, 1);
	local	vString = Calendar_cStatusCodeStrings[vStatus1];
	
	if vString then	
		return vString;
	else
		return format(CalendarEventEditor_cUnknownStatus, pStatus);
	end
end

function CalendarEventEditor_GetSelfAttend()
	return EventDatabase_FindEventRSVPString(gCalendarEventEditor_Event, gGroupCalendar_PlayerName) ~= nil;
end

function CalendarEventEditor_SetSelfAttend(pWillAttend)
	if pWillAttend then
		local vRSVP = EventDatabase_CreatePlayerRSVP(
								gCalendarEventEditor_Database,
								gCalendarEventEditor_Event,
								gGroupCalendar_PlayerName,
								EventDatabase_GetRaceCodeByRace(UnitRace("PLAYER")),
								EventDatabase_GetClassCodeByClass(UnitClass("PLAYER")),
								gGroupCalendar_PlayerLevel,
								"Y",
								nil,
								gGroupCalendar_PlayerGuild,
								gGroupCalendar_PlayerGuildRank,
								gGroupCalendar_PlayerCharacters);
		
		EventDatabase_AddEventRSVP(
				gCalendarEventEditor_Database,
				gCalendarEventEditor_Event,
				gGroupCalendar_PlayerName,
				vRSVP)
	else
		EventDatabase_RemoveEventRSVP(
				gCalendarEventEditor_Database,
				gCalendarEventEditor_Event,
				gGroupCalendar_PlayerName)
	end
end

function CalendarEventEditor_AskDeleteEvent()
	-- If it's new just kill it without asking
	
	if gCalendarEventEditor_IsNewEvent then
		CalendarEventEditor_DeleteEvent();
	else
		-- Update an event record so we can display a meaningful name
		
		local	vChangedFields = {};
		local	vEvent = {};
		
		CalendarEventEditor_UpdateEventFromControls(vEvent, vChangedFields);
		
		StaticPopup_Show("CONFIRM_CALENDAR_EVENT_DELETE", EventDatabase_GetEventDisplayName(vEvent));
	end
end

function CalendarAttendanceList_AnyItemsCollapsed(pAttendanceList)
	if not pAttendanceList.CollapsedCategories then
		return false;
	end
	
	for vCategory, vCollapsed in pAttendanceList.CollapsedCategories do
		return true;
	end
	
	return false;
end

local	gCalendar_WhisperLog = {mPlayers = {}, mEvent = nil};

function CalendarWhisperLog_AddWhisper(pPlayerName, pMessage)
	-- If no event is active then just ignore all whispers
	-- NOTE: Disabling this for now, it seems like it's better to have too
	-- many than too few whispers.  With this feature enabled, the organizer
	-- must remember to open the event before receiving whispers or else
	-- they'll be lost.  That can be a bit of a pain.
	
	--[[
	if not gCalendar_WhisperLog.mEvent then
		return;
	end
	]]
	
	-- Ignore whispers which appear to be data from other addons
	
	local	vFirstChar = string.sub(pMessage, 1, 1);
	
	if vFirstChar == "<"
	or vFirstChar == "["
	or vFirstChar == "{" then
		return;
	end
	
	-- Filter if necessary
	
	if gCalendar_WhisperLog.mWhisperFilterFunc
	and not gCalendar_WhisperLog.mWhisperFilterFunc(gCalendar_WhisperLog.mWhisperFilterParam, pPlayerName) then
		return;
	end
	
	--
	
	local	vPlayerLog = gCalendar_WhisperLog.mPlayers[pPlayerName];
	
	if not vPlayerLog then
		vPlayerLog = {};
		
		vPlayerLog.mName = pPlayerName;
		vPlayerLog.mDate, vPlayerLog.mTime = EventDatabase_GetServerDateTime60Stamp();
		vPlayerLog.mWhispers = {};
		
		gCalendar_WhisperLog.mPlayers[pPlayerName] = vPlayerLog;
	end
	
	local	vLength = table.getn(vPlayerLog.mWhispers);
	
	if vLength > 3 then
		table.remove(vPlayerLog.mWhispers, 1);
		vLength = vLength - 1;
	end
	
	vPlayerLog.mWhispers[vLength + 1] = pMessage;

	-- Notify
	
	if gCalendar_WhisperLog.mNotificationFunc then
		gCalendar_WhisperLog.mNotificationFunc(gCalendar_WhisperLog.mNotifcationParam);
	end
end

function CalendarWhisperLog_AskClear()
	StaticPopup_Show("CONFIRM_CALENDAR_CLEAR_WHISPERS");
end

function CalendarWhisperLog_Clear()
	gCalendar_WhisperLog.mPlayers = {};
	
	if gCalendar_WhisperLog.mNotificationFunc then
		gCalendar_WhisperLog.mNotificationFunc(gCalendar_WhisperLog.mNotifcationParam);
	end
end

function CalendarWhisperLog_GetPlayerWhispers(pEvent)
	if gCalendar_WhisperLog.mEvent ~= pEvent then
		gCalendar_WhisperLog.mEvent = pEvent;
		CalendarWhisperLog_Clear();
	end
	
	return gCalendar_WhisperLog.mPlayers;
end

function CalendarWhisperLog_SetNotificationFunc(pFunc, pParam)
	gCalendar_WhisperLog.mNotificationFunc = pFunc;
	gCalendar_WhisperLog.mNotifcationParam = pParam;
end

function CalendarWhisperLog_SetWhisperFilterFunc(pFunc, pParam)
	gCalendar_WhisperLog.mWhisperFilterFunc = pFunc;
	gCalendar_WhisperLog.mWhisperFilterParam = pParam;
end

function CalendarWhisperLog_RemovePlayer(pPlayerName)
	gCalendar_WhisperLog.mPlayers[pPlayerName] = nil;

	-- Notify
	
	if gCalendar_WhisperLog.mNotificationFunc then
		gCalendar_WhisperLog.mNotificationFunc(gCalendar_WhisperLog.mNotifcationParam);
	end
end

function CalendarWhisperLog_GetNextWhisper(pPlayerName)
	-- Make an indexed list of the whispers
	
	local	vWhispers = {};
	
	for vName, vWhisper in gCalendar_WhisperLog.mPlayers do
		table.insert(vWhispers, vWhisper);
	end
	
	-- Sort by time
	
	table.sort(vWhispers, EventDatabase_CompareRSVPsByDate);
	
	--
	
	local	vLowerName = strlower(pPlayerName);
	local	vUseNext = false;
	
	for vIndex, vWhisper in vWhispers do
		if vUseNext then
			return vWhisper;
		end
		
		if vLowerName == strlower(vWhisper.mName) then
			vUseNext = true;
		end
	end
	
	return nil;
end

function CalendarAttendanceList_GetManualConfirmEnable(pAttendanceList)
	local	vAutoConfirmEnable = getglobal(pAttendanceList:GetName().."MainViewAutoConfirmEnable");
	local	vManualConfirm = not vAutoConfirmEnable:GetChecked();
	
	if not vManualConfirm then
		vManualConfirm = nil;
	end
	
	return vManualConfirm;
end

gCalendarAttendanceList_VerticalScrollList = nil;

function CalendarAttendanceList_OnLoad()
	local	vListName = this:GetName();
	
	this.NumItems = gGroupCalendar_cNumAttendanceItems;
	this.CollapsedCategories = {};
	this.ListViewMode = "Date";
	
	-- Set the text color for the class totals
	
	for vClassID, vClassInfo in gGroupCalendar_ClassInfoByClassCode do
		local	vLabel = getglobal(vListName.."MainViewTotals"..vClassInfo.element.."sLabel");
		local	vCount = getglobal(vListName.."MainViewTotals"..vClassInfo.element.."s");
		local	vColor = RAID_CLASS_COLORS[vClassInfo.color];
		
		vLabel:SetTextColor(vColor.r, vColor.g, vColor.b);
		vCount:SetTextColor(vColor.r, vColor.g, vColor.b);
	end
	
	CalendarAttendanceList_SetClassTotalsVisible(this, true, true);
end

function CalendarAttendanceList_OnShow()
	CalendarAttendanceList_ShowPanel(this, "MainView");
	
	CalendarWhisperLog_SetNotificationFunc(CalendarAttendanceList_UpdateWhispers, this);
	CalendarWhisperLog_SetWhisperFilterFunc(CalendarAttendanceList_FilterWhispers, this);
end

function CalendarAttendanceList_OnHide()
	CalendarWhisperLog_SetNotificationFunc(nil, nil, nil);
	
	if GetNumPartyMembers() == 0
	and GetNumRaidMembers() == 0 then
		CalendarGroupInvites_EndEvent(this.Event);
	else
		CalendarGroupInvites_SetChangedFunc(nil, nil);
	end
end

function CalendarAttendanceList_SetEvent(pAttendanceList, pDatabase, pEvent)
	pAttendanceList.Database = pDatabase;
	pAttendanceList.Event = pEvent;
	pAttendanceList.Group = nil;
	
	pAttendanceList.ListViewMode = "Date";
	
	pAttendanceList.EventListInfo = {};
	pAttendanceList.CollapsedCategories = {};

	-- Update the auto confirm enable
	
	local	vAttendanceListName = pAttendanceList:GetName();
	local	vMainViewName = vAttendanceListName.."MainView";
	
	local	vAutoConfirmEnable = getglobal(vMainViewName.."AutoConfirmEnable");
	local	vAutoConfirmOptions = getglobal(vMainViewName.."AutoConfirmOptions");
	
	vAutoConfirmEnable:SetChecked(not pAttendanceList.Event.mManualConfirm);
	Calendar_SetButtonEnable(vAutoConfirmOptions, not pAttendanceList.Event.mManualConfirm);
	
	--
	
	CalendarAttendanceList_UpdateAttendanceCounts(pAttendanceList);
end

function CalendarAttendanceList_SetGroup(pAttendanceList, pGroup)
	pAttendanceList.Group = pGroup;
end

function CalendarAttendanceList_EventChanged(pAttendanceList, pDatabase, pEvent)
	pAttendanceList.Database = pDatabase;
	pAttendanceList.Event = pEvent;
	
	CalendarAttendanceList_UpdateAttendanceCounts(pAttendanceList);
	CalendarGroupInvites_EventChanged(pDatabase, pEvent);
	
	CalendarAttendanceList_Update(pAttendanceList);
end

function CalendarAttendanceList_UpdateAttendanceCounts(pAttendanceList)
	local	vUseClassCategories = EventDatabase_IsQuestingEventType(pAttendanceList.Event.mType);
	local	vHadWhispers = pAttendanceList.EventListInfo.AttendanceCounts
			           and pAttendanceList.EventListInfo.AttendanceCounts.Categories["WHISPERS"] ~= nil;
	
	pAttendanceList.EventListInfo.AttendanceCounts =
			CalendarEvent_GetAttendanceCounts(
					pAttendanceList.Database,
					pAttendanceList.Event,
					vUseClassCategories);
	
	-- Add in the recent whispers, but only if they're not in the attendance list
	-- and only if the event is editable
	
	if not vHadWhispers then
		pAttendanceList.CollapsedCategories["WHISPERS"] = true;
	end
	
	local	vAttendanceList = pAttendanceList.EventListInfo.AttendanceCounts;
	local	vGroupList = gGroupCalendar_Invites.Group;
	
	if pAttendanceList.mCanEdit then
		local	vPlayerWhispers = CalendarWhisperLog_GetPlayerWhispers(pAttendanceList.Event);
		
		for vPlayerName, vWhispers in vPlayerWhispers do
			CalendarAttendanceList_AddWhisper(
					vAttendanceList,
					vPlayerName,
					vWhispers);
		end
	end
	
	CalendarEvent_SortAttendanceCounts(pAttendanceList.EventListInfo.AttendanceCounts, pAttendanceList.ListViewMode);
end

function CalendarAttendanceList_FilterWhispers(pAttendanceList, pPlayerName)
	local	vAttendanceList = pAttendanceList.EventListInfo.AttendanceCounts;
	
	if vAttendanceList.Items
	and vAttendanceList.Items[pPlayerName] then
		return false;
	end
	
	if gGroupCalendar_Invites.Group
	and gGroupCalendar_Invites.Group.Items[pPlayerName] then
		return false;
	end
	
	return true;
end

function CalendarAttendanceList_UpdateWhispers(pAttendanceList)
	if not CalendarAttendanceList_RemoveCategory(pAttendanceList.EventListInfo.AttendanceCounts, "WHISPERS") then
		-- Collapse the category if this is the first one
		
		pAttendanceList.CollapsedCategories["WHISPERS"] = true;
	end
	
	local	vAttendanceList = pAttendanceList.EventListInfo.AttendanceCounts;
	local	vGroupList = gGroupCalendar_Invites.Group;
	
	local	vPlayerWhispers = CalendarWhisperLog_GetPlayerWhispers(pAttendanceList.Event);
	
	for vPlayerName, vWhispers in vPlayerWhispers do
		CalendarAttendanceList_AddWhisper(
				vAttendanceList,
				vPlayerName,
				vWhispers);
	end
	
	CalendarEvent_SortAttendanceCounts(pAttendanceList.EventListInfo.AttendanceCounts, pAttendanceList.ListViewMode);
	
	CalendarAttendanceList_Update(pAttendanceList);
end

function CalendarAttendanceList_SetCanEdit(pAttendanceList, pCanEdit)
	pAttendanceList.mCanEdit = pCanEdit;
end

function CalendarScrollbarTrench_SizeChanged(pScrollbarTrench)
	local	vScrollbarTrenchName = pScrollbarTrench:GetName();
	local	vScrollbarTrenchMiddle = getglobal(vScrollbarTrenchName.."Middle");
	
	local	vMiddleHeight= pScrollbarTrench:GetHeight() - 51;
	vScrollbarTrenchMiddle:SetHeight(vMiddleHeight);
end

function CalendarAttendanceList_SetClassTotalsVisible(pAttendanceList, pVisible, pShowAutoConfirm)
	pAttendanceList.ShowTotals = pVisible;
	pAttendanceList.ShowAutoConfirm = pShowAutoConfirm;
	
	CalendarAttendanceList_AdjustHeight(pAttendanceList);
end

function CalendarAttendanceList_AdjustHeight(pAttendanceList)
	local	vListName = pAttendanceList:GetName();
	local	vTotals = getglobal(vListName.."MainViewTotals");
	local	vAutoConfirm = getglobal(vListName.."MainViewAutoConfirm");
	local	vScrollFrame = getglobal(vListName.."ScrollFrame");
	local	vScrollTrench = getglobal(vListName.."ScrollbarTrench");
	local	vScrollFrameBaseHeight = 254;
	local	vScrollTrenchBaseHeight = 261;
	
	if pAttendanceList.CurrentPanel == "GroupView"
	or pAttendanceList.ShowTotals then
		local	vFooterHeight;
		
		vTotals:Show();
		
		if pAttendanceList.CurrentPanel ~= "GroupView"
		and pAttendanceList.ShowAutoConfirm then
			vAutoConfirm:Show();
			pAttendanceList.NumItems = gGroupCalendar_cNumAutoConfirmAttendanceItems;
			vFooterHeight = vAutoConfirm:GetHeight() + vTotals:GetHeight();
		else
			vAutoConfirm:Hide();
			pAttendanceList.NumItems = gGroupCalendar_cNumAttendanceItems;
			vFooterHeight = vTotals:GetHeight();
		end
		
		vScrollFrame:SetHeight(vScrollFrameBaseHeight - vFooterHeight);
		vScrollTrench:SetHeight(vScrollTrenchBaseHeight - vFooterHeight);
	else
		vTotals:Hide();
		vAutoConfirm:Hide();
		pAttendanceList.NumItems = gGroupCalendar_cNumPlainAttendanceItems;
		vScrollFrame:SetHeight(vScrollFrameBaseHeight);
		vScrollTrench:SetHeight(vScrollTrenchBaseHeight);
	end
end

function CalendarAttendanceList_Update(pAttendanceList)
	if not pAttendanceList:IsVisible() then
		return;
	end
	
	local	vAttendanceListName = pAttendanceList:GetName();
	local	vMainViewName = vAttendanceListName.."MainView";
	
	-- Update the view menu
	
	local	vListViewMenu = getglobal(vAttendanceListName.."ViewMenu");
	
	CalendarDropDown_SetSelectedValue(vListViewMenu, pAttendanceList.ListViewMode);
	
	if pAttendanceList.CurrentPanel == "MainView" then
		-- Update the scroll frame
		
		local		vTotalCount = 0;
		
		if pAttendanceList.EventListInfo.AttendanceCounts then
			for vCategory, vClassAttendanceInfo in pAttendanceList.EventListInfo.AttendanceCounts.Categories do
				vTotalCount = vTotalCount + 1;
				
				if not pAttendanceList.CollapsedCategories[vCategory] then
					vTotalCount = vTotalCount + vClassAttendanceInfo.mCount;
				end
			end
		end
		
		FauxScrollFrame_Update(
				getglobal(vAttendanceListName.."ScrollFrame"),
				vTotalCount,
				pAttendanceList.NumItems,
				gGroupCalendar_cAttendanceItemHeight,
				nil, nil, nil,
				nil,
				293, 316);
		
		CalendarAttendanceList_UpdateAttendanceList(pAttendanceList);
		
		-- Update the expand/collapse all button
		
		local	vExpandAllButton = getglobal(vAttendanceListName.."ExpandAllButton")
		
		if CalendarAttendanceList_AnyItemsCollapsed(pAttendanceList) then
			vExpandAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
		else
			vExpandAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
		end
		
		CalendarAttendanceList_UpdateClassTotals(pAttendanceList);
		
		-- Show or hide the add button
		
		local		vAddButton = getglobal(vMainViewName.."AddButton");
		
		if pAttendanceList.mCanEdit then
			vAddButton:Show();
		else
			vAddButton:Hide();
		end
		
	elseif pAttendanceList.CurrentPanel == "GroupView" then
		local	vGroupViewName = vAttendanceListName.."GroupView";
		local	vSelectionInfoText = getglobal(vGroupViewName.."SelectionInfo");
		local	vStatusText = getglobal(vGroupViewName.."Status");
		local	vStatusMessage = GroupCalendar_cInviteStatusMessages[gGroupCalendar_Invites.Status];
		local	vInviteButton = getglobal(vGroupViewName.."Invite");
		
		if vStatusMessage then
			vStatusText:SetText(vStatusMessage);
		elseif gGroupCalendar_Invites.Status then
			vStatusText:SetText("Unknown "..gGroupCalendar_Invites.Status);
		else
			vStatusText:SetText("Unknown (nil)");
		end
		
		local	vNumSelected = gGroupCalendar_Invites.NumSelected;
		
		if not vNumSelected
		or vNumSelected == 0 then
			vSelectionInfoText:SetText(GroupCalendar_cNoSelection);
		elseif vNumSelected == 1 then
			vSelectionInfoText:SetText(GroupCalendar_cSingleSelection);
		else
			vSelectionInfoText:SetText(format(GroupCalendar_cMultiSelection, vNumSelected));
		end
		
		-- Update the scroll frame
		
		local		vTotalCount = 0;
		
		if pAttendanceList.EventListInfo.AttendanceCounts then
			for vCategory, vClassAttendanceInfo in gGroupCalendar_Invites.Group.Categories do
				vTotalCount = vTotalCount + 1;
				
				if not pAttendanceList.CollapsedCategories[vCategory] then
					vTotalCount = vTotalCount + vClassAttendanceInfo.mCount;
				end
			end
		end
		
		FauxScrollFrame_Update(
				getglobal(vAttendanceListName.."ScrollFrame"),
				vTotalCount,
				pAttendanceList.NumItems,
				gGroupCalendar_cAttendanceItemHeight,
				nil, nil, nil,
				nil,
				293, 316);
		
		CalendarAttendanceList_UpdateAttendanceList(pAttendanceList);
		
		-- Enable the invite button if the player is the raid or party leader
		-- or is not in a raid or pary
		
		local		vEnableInvites = false;
		local		vInParty = GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0;
		
		if not vInParty
		or IsPartyLeader()
		or IsRaidLeader()
		or IsRaidOfficer() then
			vEnableInvites = true;
		end
		
		Calendar_SetButtonEnable(vInviteButton, vEnableInvites);
	else
		Calendar_ErrorMessage("CalendarAttendanceList_Update: Unknown panel "..pAttendanceList.CurrentPanel);
	end
end

function CalendarAttendanceList_ToggleExpandAll(pAttendanceList)
	-- Get the group
	
	local	vGroup;
	
	if pAttendanceList.CurrentPanel == "MainView" then
		vGroup = pAttendanceList.EventListInfo.AttendanceCounts;
	elseif pAttendanceList.CurrentPanel == "GroupView" then
		vGroup = gGroupCalendar_Invites.Group;
	else
		Calendar_ErrorMessage("CalendarAttendanceList_ToggleExpandAll: Unknown view "..pAttendanceList.CurrentPanel);
		return;
	end
	
	-- Just return if there are no attendance items to toggle
	
	if not pAttendanceList
	or not vGroup then
		return;
	end
	
	if CalendarAttendanceList_AnyItemsCollapsed(pAttendanceList) then
		-- Expand all
		
		pAttendanceList.CollapsedCategories = {};
	else
		-- Collapse all
		
		pAttendanceList.CollapsedCategories = {};
		
		for vCategory, vClassAttendanceInfo in vGroup.Categories do
			pAttendanceList.CollapsedCategories[vCategory] = true;
		end
	end
	
	CalendarAttendanceList_Update(pAttendanceList);
end

function CalendarAttendanceList_UpdateClassTotals(pAttendanceList)
	local	vListName = pAttendanceList:GetName();
	
	for vClassCode, vClassInfo in gGroupCalendar_ClassInfoByClassCode do
		local	vClassTotal;
		
		if pAttendanceList.EventListInfo.AttendanceCounts then
			vClassTotal = pAttendanceList.EventListInfo.AttendanceCounts.ClassTotals[vClassCode];
		else
			vClassTotal = nil;
		end
		
		local	vCountTextItem = getglobal(vListName.."MainViewTotals"..vClassInfo.element.."s");
		
		if not vClassTotal then
			vCountTextItem:SetText("0");
			vCountTextItem:SetTextColor(0.9, 0.2, 0.2);
		else
			local	vColor = RAID_CLASS_COLORS[vClassInfo.color];
			
			vCountTextItem:SetText(vClassTotal);
			vCountTextItem:SetTextColor(vColor.r, vColor.g, vColor.b);
		end
	end
end

gGroupCalendar_cAttendanceCategories =
{
	NO = GroupCalendar_cNotAttending,
	YES = GroupCalendar_cAttending,
	PENDING = GroupCalendar_cPendingApproval,
	STANDBY = GroupCalendar_cStandby,
	QUEUED = GroupCalendar_Queued,
	WHISPERS = GroupCalendar_cWhispers,
};

function CalendarAttendanceList_GetClassNameColor(pClassName)
	if not pClassName then
		return NORMAL_FONT_COLOR;
	end
	
	local	vClassColorName = getglobal("GroupCalendar_c"..pClassName.."ClassColorName");
	
	return RAID_CLASS_COLORS[vClassColorName];
end
	
function CalendarAttendanceList_SetItem(
					pAttendanceList,
					pIndex,
					pItemInfo,
					pLeftFormat,
					pRightFormat,
					pShowMenu,
					pMenuValue,
					pColor,
					pOffline,
					pIconPath,
					pChecked,
					pTooltipName,
					pTooltipText,
					pTooltipTextColor)
	local	vListName = pAttendanceList:GetName();
	local	vItemName = vListName.."Item"..pIndex;
	local	vItem = getglobal(vItemName);
	local	vItemHighlight = getglobal(vItemName.."Highlight");
	
	local	vItemCategory = getglobal(vItemName.."Category");
	local	vItemLeftText = getglobal(vItemName.."Name");
	local	vItemRightText = getglobal(vItemName.."Status");
	local	vItemMenu = getglobal(vItemName.."Menu");
	local	vItemActionButton = getglobal(vItemName.."Action");
	
	--
	
	vItemCategory:Hide();
	vItemLeftText:Show();
	vItemRightText:Show();
	vItemActionButton:Hide();
	
	if pShowMenu then
		CalendarDropDown_SetSelectedValue2(vItemMenu, pMenuValue);
		vItemMenu:Show();
		vItemRightText:SetWidth(112);
	else
		vItemMenu:Hide();
		vItemRightText:SetWidth(130);
	end
	
	vItemLeftText:SetText(string.gsub(pLeftFormat, "%$(%w+)", function (pField) return pItemInfo[pField]; end));
	vItemRightText:SetText(string.gsub(pRightFormat, "%$(%w+)", function (pField) return pItemInfo[pField]; end));
	
	if pColor then
		if pOffline then
			vItemLeftText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		else
			vItemLeftText:SetTextColor(pColor.r, pColor.g, pColor.b);
		end
		
		vItemRightText:SetTextColor(pColor.r, pColor.g, pColor.b);
	else
		if pOffline then
			vItemLeftText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		else
			vItemLeftText:SetTextColor(1, 1, 1);
		end
		vItemRightText:SetTextColor(1, 1, 1);
	end
	
	if pChecked ~= nil then
		vItem.Checkable = true;
		vItem:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
		vItem:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
		vItemHighlight:SetTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
		vItem:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
		vItem:SetChecked(pChecked);
	else
		vItem.Checkable = false;
		if pIconPath then
			vItem:SetNormalTexture(pIconPath);
		else
			vItem:SetNormalTexture("");
		end
		vItem:SetPushedTexture("");
		vItem:SetCheckedTexture("");
		vItemHighlight:SetTexture("");
		vItem:SetChecked(false);
	end
	
	vItem.IsCategoryItem = false;
	vItem:Show();
	
	vItem.TooltipName = pTooltipName;
	vItem.TooltipText = pTooltipText;
	vItem.TooltipTextColor = pTooltipTextColor;
	
	return vItem;
end

function CalendarAttendanceList_SetItemToRSVP(pAttendanceList, pIndex, pCategory, pRSVP, pNameFormat, pShowRank)
	local	vItemInfo =
	{
		name = pRSVP.mName,
		class = EventDatabase_GetClassByClassCode(pRSVP.mClassCode),
		race = EventDatabase_GetRaceByRaceCode(pRSVP.mRaceCode),
		level = tostring(pRSVP.mLevel),
		status = "",
	};
	
	-- Set the status
	
	local	vShowStatusString = false;
	
	if vShowStatusString then
		vItemInfo.status = CalendarEventEditor_GetStatusString(pRSVP.mStatus);
	elseif pShowRank then
		local	vRank = EventDatabase_MapGuildRank(pRSVP.mGuild, pRSVP.mGuildRank);
		
		if vRank then
			vItemInfo.status = GuildControlGetRankName(vRank + 1);
		else
			vItemInfo.status = GroupCalendar_cUnknown;
		end
		
	else
		local	vDate, vTime = EventDatabase_GetRSVPOriginalDateTime(pRSVP);
		
		if vDate and vTime then
			vTime = vTime / 60; -- Convert from seconds to minutes
			
			if gGroupCalendar_Settings.ShowEventsInLocalTime then
				vDate, vTime = Calendar_GetLocalDateTimeFromServerDateTime(vDate, vTime);
			end
			
			local	vShortDateString = Calendar_GetShortDateString(vDate);
			local	vShortTimeString = Calendar_GetShortTimeString(vTime);
			
			vItemInfo.status = vShortDateString.." "..vShortTimeString;
		end
	end
	
	local	vColor = CalendarAttendanceList_GetClassNameColor(vItemInfo.class);
	
	-- Get the icon path
	
	local	vIconPath;
	local	vTooltipName = nil;
	local	vTooltipText = nil;
	local	vTooltipTextColor = nil;
	
	if pRSVP.mComment and pRSVP.mComment ~= "" then
		vIconPath = "Interface\\Addons\\GroupCalendar\\Textures\\AttendanceNoteIcon";
		vTooltipName = pRSVP.mName;
		vTooltipText = Calendar_UnescapeString(pRSVP.mComment);
	elseif pRSVP.mType == "Whisper" then
		vIconPath = "Interface\\Addons\\GroupCalendar\\Textures\\AttendanceNoteIcon";
		
		vTooltipName = pRSVP.mName;
		vTooltipText = pRSVP.mWhispers;
		vTooltipTextColor = ChatTypeInfo["WHISPER"];
		vColor = vTooltipTextColor;
	else
		vIconPath = "";
	end
	
	-- Set the item
	
	local	vItem = CalendarAttendanceList_SetItem(
							pAttendanceList,
							pIndex,
							vItemInfo,
							pNameFormat,
							"$status",
							pAttendanceList.mCanEdit,
							pRSVP.mStatus,
							vColor,
							false,
							vIconPath,
							nil,
							vTooltipName,
							vTooltipText,
							vTooltipTextColor);
	
	vItem.Item = pRSVP;
end

function CalendarAttendanceList_SetItemToCategory(pAttendanceList, pIndex, pCategory, pActionFunc, pActionParam)
	local	vItemName = pAttendanceList:GetName().."Item"..pIndex;
	local	vItem = getglobal(vItemName);
	
	local	vItemHighlight = getglobal(vItemName.."Highlight");
	local	vItemCategory = getglobal(vItemName.."Category");
	local	vItemPlayerName = getglobal(vItemName.."Name");
	local	vItemPlayerStatus = getglobal(vItemName.."Status");
	local	vItemMenu = getglobal(vItemName.."Menu");
	local	vItemActionButton = getglobal(vItemName.."Action");

	local	vCategoryName;
	
	if type(pCategory) == "number" then
		vCategoryName = GuildControlGetRankName(pCategory + 1);
	else
		vCategoryName = gGroupCalendar_cAttendanceCategories[pCategory];
		
		if not vCategoryName then
			vCategoryName = EventDatabase_GetClassByClassCode(pCategory);
		end
	end
	
	vItemCategory:SetText(vCategoryName);
	vItemCategory:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	vItemCategory:Show();
	vItemPlayerName:Hide();
	vItemPlayerStatus:Hide();
	
	if pActionFunc then
		vItemActionButton.ActionFunc = pActionFunc;
		vItemActionButton.ActionParam = pActionParam;
		vItemActionButton:Show();
	else
		vItemActionButton:Hide();
	end
	
	vItemMenu:Hide();
	vItemPlayerStatus:SetWidth(130);
	
	if pAttendanceList.CollapsedCategories[pCategory] then
		vItem:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
		vItem:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down");
	else
		vItem:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
		vItem:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down"); 
	end
	
	vItemHighlight:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
	vItem:SetChecked(false);
	
	vItem.Item = nil;
	vItem.IsCategoryItem = true;
	vItem.Category = pCategory;
	
	vItem.TooltipName = nil;
	vItem.TooltipText = nil;
	vItem.TooltipTextColor = nil;
	
	vItem:Show();
end

function CalendarAttendanceList_HideUnusedAttendanceItems(pAttendanceList, pFirstItem)
	local	vListName = pAttendanceList:GetName();
	
	for vIndex = pFirstItem, gGroupCalendar_cNumPlainAttendanceItems - 1 do
		local	vItemName = vListName.."Item"..vIndex;
		getglobal(vItemName):Hide();
	end
end

function CalendarAttendanceList_UpdateAttendanceList(pAttendanceList)
	if pAttendanceList.CurrentPanel == "MainView" then
		CalendarAttendanceList_UpdateEventAttendance(pAttendanceList);
	elseif pAttendanceList.CurrentPanel == "GroupView" then
		CalendarAttendanceList_UpdateGroupAttendance(pAttendanceList);
	else
		Calendar_ErrorMessage("Unknown attendance panel "..pAttendanceList.CurrentPanel);
	end
end

function CalendarAttendanceList_UpdateGroupAttendance(pAttendanceList)
	local	vSortByFlags = GroupCalendar_cSortByFlags[pAttendanceList.ListViewMode];
	
	pAttendanceList.ViewType = "Class";
	pAttendanceList.ShowRank = vSortByFlags.Rank;
	
	CalendarAttendanceList_UpdateAttendanceItems(pAttendanceList, gGroupCalendar_Invites.Group, CalendarAttendanceList_SetGroupItem, GroupCalendar_cNumPlayersFormat);
end

function CalendarAttendanceList_UpdateEventAttendance(pAttendanceList)
	local	vSetItemFunction;
	
	if EventDatabase_IsQuestingEventType(pAttendanceList.Event.mType) then
		pAttendanceList.ViewType = "Class";
	else
		pAttendanceList.ViewType = "Plain";
	end
	
	local	vSortByFlags = GroupCalendar_cSortByFlags[pAttendanceList.ListViewMode];
	
	pAttendanceList.ShowRank = vSortByFlags.Class and vSortByFlags.Rank;
	
	CalendarAttendanceList_UpdateAttendanceItems(pAttendanceList, pAttendanceList.EventListInfo.AttendanceCounts, CalendarAttendanceList_SetAttendanceItem, GroupCalendar_cNumAttendeesFormat);
end

function CalendarAttendanceList_SetGroupItem(pAttendanceList, pItemIndex, pCategory, pItem)
	local	vItemInfo = {};
	local	vToolTipName, vTooltipText;
	local	vIconPath;
	
	vItemInfo.name = pItem.mName;
	vItemInfo.status = GroupCalendar_cGroupStatusMessages[pItem.mGroupStatus];
	vItemInfo.class = EventDatabase_GetClassByClassCode(pItem.mClassCode);
	vItemInfo.race = EventDatabase_GetRaceByRaceCode(pItem.mRaceCode);
	vItemInfo.level = tostring(pItem.mLevel);
	vItemInfo.offline = pItem.mOffline;
	
	-- Set the status
	
	local	vStatusColumnFormat = "";
	
	if pAttendanceList.ListViewMode == "Rank" then
		local	vRank = EventDatabase_MapGuildRank(pItem.mGuild, pItem.mGuildRank);
		
		if vRank then
			vItemInfo.rank = GuildControlGetRankName(vRank + 1);
		else
			vItemInfo.rank = GroupCalendar_cUnknown;
		end
		
		vStatusColumnFormat = "$rank";
	elseif pAttendanceList.ListViewMode == "Date"
	or pAttendanceList.ListViewMode == "Name" then
		local	vDate, vTime = EventDatabase_GetRSVPOriginalDateTime(pItem);
		
		if vDate and vTime then
			vTime = vTime / 60; -- Convert from seconds to minutes
			
			if gGroupCalendar_Settings.ShowEventsInLocalTime then
				vDate, vTime = Calendar_GetLocalDateTimeFromServerDateTime(vDate, vTime);
			end
			
			local	vShortDateString = Calendar_GetShortDateString(vDate);
			local	vShortTimeString = Calendar_GetShortTimeString(vTime);
			
			vItemInfo.date = vShortDateString.." "..vShortTimeString;
			
			vStatusColumnFormat = "$date";
		end
	end
	
	local	vNameColumnFormat;
	
	if pCategory == "STANDBY" then
		vNameColumnFormat = GroupCalendar_cMeetingAttendanceNameFormat;
	else
		vNameColumnFormat = GroupCalendar_cGroupAttendanceNameFormat;
	end
	
	local	vSelected;
	
	if pItem.mGroupStatus ~= "Joined" then
		vSelected = pItem.mSelected == true;
	end
	
	local	vItem = CalendarAttendanceList_SetItem(
							pAttendanceList,
							pItemIndex,
							vItemInfo,
							vNameColumnFormat,
							vStatusColumnFormat,
							false,
							false,
							CalendarAttendanceList_GetClassNameColor(vItemInfo.class),
							pItem.mOffline,
							vIconPath,
							vSelected,
							vTooltipName,
							vTooltipText);
	
	vItem.Item = pItem;
end

function CalendarAttendanceList_SetAttendanceItem(pAttendanceList, pItemIndex, pCategory, pItem)
	if pItem.mType == "Whisper" then
		CalendarAttendanceList_SetItemToRSVP(pAttendanceList, pItemIndex, pCategory, pItem, GroupCalendar_cMeetingAttendanceNameFormat, pAttendanceList.ShowRank);
	elseif pAttendanceList.ViewType == "Questing" then
		local	vNameFormat;

		if pCategory ~= "STANDBY" then
			vNameFormat = GroupCalendar_cQuestAttendanceNameFormat;
		else
			vNameFormat = GroupCalendar_cMeetingAttendanceNameFormat;
		end
		
		CalendarAttendanceList_SetItemToRSVP(pAttendanceList, pItemIndex, pCategory, pItem, vNameFormat, pAttendanceList.ShowRank);
	else
		CalendarAttendanceList_SetItemToRSVP(pAttendanceList, pItemIndex, pCategory, pItem, GroupCalendar_cMeetingAttendanceNameFormat, pAttendanceList.ShowRank);
	end
end

function CalendarAttendanceList_UpdateAttendanceItems(pAttendanceList, pAttendanceCounts, pSetItemFunction, pTotalAttendanceFormat)
	local	vTotalAttendeesItem = getglobal(pAttendanceList:GetName().."Total");
	
	local	vFirstItemIndex = FauxScrollFrame_GetOffset(getglobal(pAttendanceList:GetName().."ScrollFrame"));
	local	vItemIndex = 0;
	
	if not pAttendanceCounts then
		CalendarAttendanceList_HideUnusedAttendanceItems(pAttendanceList, vItemIndex);
		vTotalAttendeesItem:SetText(string.format(pTotalAttendanceFormat, 0));
		return;
	end
	
	vTotalAttendeesItem:SetText(string.format(pTotalAttendanceFormat, pAttendanceCounts.NumAttendees));
	
	for vIndex, vCategory in pAttendanceCounts.SortedCategories do
		local	vClassAttendanceInfo = pAttendanceCounts.Categories[vCategory];
		
		if vFirstItemIndex == 0 then
			local	vActionFunc = nil;
			
			if vCategory == "WHISPERS" then
				vActionFunc = CalendarWhisperLog_AskClear;
			end
			
			CalendarAttendanceList_SetItemToCategory(pAttendanceList, vItemIndex, vCategory, vActionFunc, nil);
			
			vItemIndex = vItemIndex + 1;
			
			if vItemIndex >= pAttendanceList.NumItems then
				CalendarAttendanceList_HideUnusedAttendanceItems(pAttendanceList, vItemIndex);
				return;
			end
		else
			vFirstItemIndex = vFirstItemIndex - 1;
		end
		
		if not pAttendanceList.CollapsedCategories[vCategory] then
			if vFirstItemIndex >= vClassAttendanceInfo.mCount then
				vFirstItemIndex = vFirstItemIndex - vClassAttendanceInfo.mCount;
			else
				for vIndex, vRSVP in vClassAttendanceInfo.mAttendees do
					if vFirstItemIndex == 0 then
						pSetItemFunction(pAttendanceList, vItemIndex, vCategory, vRSVP);
						
						vItemIndex = vItemIndex + 1;
						
						if vItemIndex >= pAttendanceList.NumItems then
							CalendarAttendanceList_HideUnusedAttendanceItems(pAttendanceList, vItemIndex);
							return;
						end
					else
						vFirstItemIndex = vFirstItemIndex - 1;
					end
				end
			end
		end
	end
	
	CalendarAttendanceList_HideUnusedAttendanceItems(pAttendanceList, vItemIndex);
end

function CalendarAttendanceList_GetIndexedItem(pAttendanceList, pIndex)
	local	vIndex = pIndex + FauxScrollFrame_GetOffset(getglobal(pAttendanceList:GetName().."ScrollFrame"));
	
	for vCategoryIndex, vCategory in pAttendanceList.EventListInfo.AttendanceCounts.SortedCategories do
		local	vClassAttendanceInfo = pAttendanceList.EventListInfo.AttendanceCounts.Categories[vCategory];
		
		if vIndex == 0 then
			Calendar_DebugMessage("CalendarAttendanceList_GetIndexedItem: Index specifies a header");
			return nil;
		end
		
		vIndex = vIndex - 1;
		
		if not pAttendanceList.CollapsedCategories[vCategory] then
			if vIndex < vClassAttendanceInfo.mCount then
				return vClassAttendanceInfo.mAttendees[vIndex + 1];
			end
			
			vIndex = vIndex - vClassAttendanceInfo.mCount;
		end
	end
	
	Calendar_DebugMessage("CalendarAttendanceList_GetIndexedItem: Index too high");
	return nil;
end

function CalendarAttendanceList_OnVerticalScroll()
	CalendarAttendanceList_Update(gCalendarAttendanceList_VerticalScrollList);
end

function CalendarAttendanceList_OnClick(pButton)
	local	vAttendanceList = pButton:GetParent();
	
	if pButton.IsCategoryItem then
		if not vAttendanceList.CollapsedCategories[pButton.Category] then
			vAttendanceList.CollapsedCategories[pButton.Category] = true;
		else
			vAttendanceList.CollapsedCategories[pButton.Category] = nil;
		end
		
		CalendarAttendanceList_Update(vAttendanceList);
		return;
	end
	
	if not pButton.Checkable then
		pButton:SetChecked(false);
		return;
	end
	
	if pButton.Item then
		if vAttendanceList.CurrentPanel == "GroupView" then
			CalendarGroupInvites_SetItemSelected(pButton.Item, not pButton.Item.mSelected);
		end
	end
end

function CalendarAttendanceList_ShowMessageTooltip(pOwner, pName, pMessages, pColor)
	if not pName then
		return;
	end
	
	GameTooltip:SetOwner(pOwner, "ANCHOR_LEFT");
	GameTooltip:AddLine(pName);
	
	local	vColor = {r = 1, g = 1, b = 1};
	
	if pColor then
		vColor = pColor;
	end;
	
	if type(pMessages) == "table" then
		for vIndex, vText in pMessages do
			GameTooltip:AddLine(vText, vColor.r, vColor.g, vColor.b, 1);
		end
	else
		GameTooltip:AddLine(pMessages, vColor.r, vColor.g, vColor.b, 1);
	end
	
	GameTooltip:Show();
end

function CalendarAttendanceList_OnEnter()
	local	vAttendanceList = this:GetParent();
	
	CalendarAttendanceList_ShowMessageTooltip(this, this.TooltipName, this.TooltipText, this.TooltipTextColor);
end

function CalendarAttendanceList_OnLeave()
	GameTooltip:Hide();
end

function CalendarAttendanceList_ListViewItemSelected(pMenu, pItem)
	local	vAttendanceList = pMenu.AttendanceList;
	
	CalendarAttendanceList_SetListView(vAttendanceList, pItem);
end

function CalendarAttendanceList_SetListView(pAttendanceList, pViewMode)
	pAttendanceList.ListViewMode = pViewMode;
	
	CalendarAttendanceList_EventChanged(pAttendanceList, pAttendanceList.Database, pAttendanceList.Event);
	CalendarGroupInvites_SetSortMode(pViewMode);
end

CalendarAttendanceList_cPanelNames =
{
	ExpandAll = "MainView",
	GroupTab = "GroupView",
};

function CalendarAttendanceList_GroupListChanged(pAttendanceList)
	CalendarAttendanceList_Update(pAttendanceList);
end

function CalendarAttendanceList_ShowPanel(pAttendanceList, pPanelName)
	local	vAttendanceListName = pAttendanceList:GetName();
	
	for vTabName, vPanelName in CalendarAttendanceList_cPanelNames do
		local	vPanel = getglobal(vAttendanceListName..vPanelName);
		local	vTab = getglobal(vAttendanceListName..vTabName);
		
		if vPanelName == pPanelName then
			vPanel:Show();
			PanelTemplates_SelectTab(vTab);
			
			-- Handle panel-specific show code
			
			if pPanelName == "GroupView" then
				local	vGroup = CalendarGroupInvites_BeginEvent(pAttendanceList.Database, pAttendanceList.Event);
				
				CalendarAttendanceList_SetGroup(pAttendanceList, vGroup);
				CalendarGroupInvites_SetChangedFunc(CalendarAttendanceList_GroupListChanged, pAttendanceList);
			end
		else
			if vPanelName == "GroupView" then
				CalendarGroupInvites_SetChangedFunc(nil, nil);
			end
			
			vPanel:Hide();
			PanelTemplates_DeselectTab(vTab);
		end
	end
	
	pAttendanceList.CurrentPanel = pPanelName;
	
	CalendarAttendanceList_AdjustHeight(pAttendanceList);
	CalendarAttendanceList_Update(pAttendanceList);
end

function CalendarAddPlayer_Open()
	CalendarAddPlayer_Reset();
	
	CalendarAddPlayerFrame:Show();
	CalendarAddPlayerFrameName:SetFocus();
end

function CalendarAddPlayer_Reset()
	CalendarAddPlayerFrame.IsWhisper = false;
	CalendarAddPlayerFrame.Guild = nil;
	
	CalendarAddPlayerFrameName:SetText("");
	CalendarAddPlayerFrameLevel:SetText("");
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameGuildRankMenu, nil);
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameStatusMenu, "Y");
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameClassMenu, "?");
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRaceMenu, "?");
	CalendarAddPlayerFrameComment:SetText("");
	
	if IsInGuild() then
		CalendarAddPlayerFrameGuildRankMenu:Show();
	else
		CalendarAddPlayerFrameGuildRankMenu:Hide();
	end
	
	CalendarAddPlayerFrameDeleteButton:Hide();
	
	CalendarAddPlayerFrameWhisper:Hide();
	CalendarAddPlayerFrame:SetHeight(CalendarAddPlayerFrame.NormalHeight);
end

function CalendarAddPlayer_OpenWhisper(pName, pDate, pTime, pWhispers)
	CalendarAddPlayer_Reset();
	
	CalendarAddPlayerFrame.IsWhisper = true;
	CalendarAddPlayerFrame.Name = pName;
	CalendarAddPlayerFrame.Date = pDate;
	CalendarAddPlayerFrame.Time = pTime;
	CalendarAddPlayerFrame.Whispers = pWhispers;
	
	CalendarAddPlayerFrameName:SetText(pName);
	CalendarAddPlayer_AutoCompletePlayerInfo();
	
	CalendarAddPlayerFrameDeleteButton:Show();
	
	CalendarAddPlayerFrameWhisper:Show();
	CalendarAddPlayerFrameWhisperRecent:SetText(pWhispers[table.getn(pWhispers)]);
	
	if gGroupCalendar_PlayerSettings.LastWhisperConfirmMessage then
		CalendarAddPlayerFrameWhisperReply:SetText(gGroupCalendar_PlayerSettings.LastWhisperConfirmMessage);
	end
	
	if gGroupCalendar_PlayerSettings.LastWhisperStatus then
		CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameStatusMenu, gGroupCalendar_PlayerSettings.LastWhisperStatus);
	end
	
	local	vColor = ChatTypeInfo["WHISPER"];
	
	CalendarAddPlayerFrameWhisperRecent:SetTextColor(vColor.r, vColor.g, vColor.b);
	CalendarAddPlayerFrameWhisperReply:SetTextColor(vColor.r, vColor.g, vColor.b);
	
	CalendarAddPlayerFrame:SetHeight(CalendarAddPlayerFrame.NormalHeight + CalendarAddPlayerFrameWhisper:GetHeight());
	
	CalendarAddPlayerFrame:Show();
	CalendarAddPlayerFrameName:SetFocus();
end

function CalendarAddPlayer_SaveNext()
	if CalendarAddPlayerFrame.IsWhisper then
		local	vNextWhisper = CalendarWhisperLog_GetNextWhisper(CalendarAddPlayerFrame.Name);
		
		CalendarAddPlayer_Save();
		
		if vNextWhisper then
			CalendarAddPlayer_OpenWhisper(vNextWhisper.mName, vNextWhisper.mDate, vNextWhisper.mTime, vNextWhisper.mWhispers);
		else
			CalendarAddPlayer_Cancel();
		end
	else
		CalendarAddPlayer_Save();
		CalendarAddPlayer_Open();
	end
end

function CalendarAddPlayer_Delete()
	if not CalendarAddPlayerFrame.IsWhisper then
		return;
	end
	
	local	vNextWhisper = CalendarWhisperLog_GetNextWhisper(CalendarAddPlayerFrame.Name);
	
	CalendarWhisperLog_RemovePlayer(CalendarAddPlayerFrame.Name);
	
	if vNextWhisper then
		CalendarAddPlayer_OpenWhisper(vNextWhisper.mName, vNextWhisper.mDate, vNextWhisper.mTime, vNextWhisper.mWhispers);
	else
		CalendarAddPlayer_Cancel();
	end
end

function CalendarAddPlayer_EditRSVP(pRSVP)
	CalendarAddPlayer_Reset();
	
	CalendarAddPlayerFrame.RSVP = pRSVP;
	CalendarAddPlayerFrameName:SetText(pRSVP.mName);
	CalendarAddPlayerFrameLevel:SetText(pRSVP.mLevel);
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameStatusMenu, pRSVP.mStatus);
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameClassMenu, pRSVP.mClassCode);
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRaceMenu, pRSVP.mRaceCode);
	
	local	vGuildRank = EventDatabase_MapGuildRank(pRSVP.mGuild, pRSVP.mGuildRank);
	
	CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameGuildRankMenu, vGuildRank);
	
	if pRSVP.mComment then
		CalendarAddPlayerFrameComment:SetText(pRSVP.mComment);
	end
	
	CalendarAddPlayerFrame:Show();
	CalendarAddPlayerFrameName:SetFocus();
end

function CalendarAddPlayer_Done()
	CalendarAddPlayer_Save();
	CalendarAddPlayerFrame:Hide();
end

function CalendarAddPlayer_Cancel()
	CalendarAddPlayerFrame:Hide();
end

function CalendarAddPlayer_Save()
	local	vName = CalendarAddPlayerFrameName:GetText();
	
	if vName == "" then
		return;
	end
	
	local	vStatusCode = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameStatusMenu);
	local	vClassCode = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameClassMenu);
	local	vRaceCode = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameRaceMenu);
	local	vLevel = tonumber(CalendarAddPlayerFrameLevel:GetText());
	local	vComment = CalendarAddPlayerFrameComment:GetText();
	local	vGuild = CalendarAddPlayerFrame.Guild;
	local	vGuildRank = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameGuildRankMenu);
	
	if not vGuild then
		vGuild = gGroupCalendar_PlayerGuild;
	end
	
	if not vGuildRank then
		vGuild = nil;
	end
	
	local vRSVP = EventDatabase_CreatePlayerRSVP(
							gCalendarEventEditor_Database,
							gCalendarEventEditor_Event,
							vName,
							vRaceCode,
							vClassCode,
							vLevel,
							vStatusCode,
							vComment,
							vGuild,
							vGuildRank,
							nil);
	
	if CalendarAddPlayerFrame.RSVP then
		-- if CalendarAddPlayerFrame.RSVP.mGuild then
		-- 	vRSVP.mGuild = CalendarAddPlayerFrame.RSVP.mGuild;
		-- 	vRSVP.mGuildRank = CalendarAddPlayerFrame.RSVP.mGuildRank;
		-- end
		
		vRSVP.mDate = CalendarAddPlayerFrame.RSVP.mDate;
		vRSVP.mTime = CalendarAddPlayerFrame.RSVP.mTime;
		vRSVP.mAlts = CalendarAddPlayerFrame.RSVP.mAlts;
		
		-- Save the guild rank mapping
		
		EventDatabase_SetGuildRankMapping(
				CalendarAddPlayerFrame.RSVP.mGuild,
				CalendarAddPlayerFrame.RSVP.mGuildRank,
				vGuildRank);
	end
	
	--
	
	EventDatabase_AddEventRSVP(
			gCalendarEventEditor_Database,
			gCalendarEventEditor_Event,
			vName,
			vRSVP)
	
	if CalendarAddPlayerFrame.IsWhisper then
		CalendarWhisperLog_RemovePlayer(CalendarAddPlayerFrame.Name);
	end
	
	-- Send the reply /w if there is one
	
	if CalendarAddPlayerFrameWhisper:IsVisible() then
		local	vReplyWhisper = CalendarAddPlayerFrameWhisperReply:GetText();
		
		if vReplyWhisper and vReplyWhisper ~= "" then
			gGroupCalendar_PlayerSettings.LastWhisperConfirmMessage = vReplyWhisper;
			SendChatMessage(vReplyWhisper, "WHISPER", nil, CalendarAddPlayerFrame.Name);
		end
		
		-- Remember what status was used
		
		gGroupCalendar_PlayerSettings.LastWhisperStatus = UIDropDownMenu_GetSelectedValue(CalendarAddPlayerFrameStatusMenu);
	end
end

function CalendarAddPlayer_AutoCompletePlayerInfo()
	local	vName = CalendarAddPlayerFrameName:GetText();
	local	vUpperName = strupper(vName);
	
	local	vGuildMemberIndex = CalendarNetwork_GetGuildMemberIndex(vName);
	
	if vGuildMemberIndex then
		local	vMemberName, vRank, vRankIndex, vLevel, vClass, vZone, vNote, vOfficerNote, vOnline = GetGuildRosterInfo(vGuildMemberIndex);
		
		CalendarAddPlayerFrameName:SetText(vMemberName);
		CalendarAddPlayerFrameLevel:SetText(vLevel);
		CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameClassMenu, EventDatabase_GetClassCodeByClass(vClass));
		-- CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRaceMenu, EventDatabase_GetRaceCodeByRace(vRace));
		CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameGuildRankMenu, vRankIndex);
		
		CalendarAddPlayerFrame.Guild = gGroupCalendar_PlayerGuild;
		
		return true;
	end
	
	local	vNumFriends = GetNumFriends();
	
	for vFriendIndex = 1, vNumFriends do
		local	vFriendName, vLevel, vClass, vArea, vConnected = GetFriendInfo(vFriendIndex);
		
		if strupper(vFriendName) == vUpperName
		and vConnected then
			CalendarAddPlayerFrameName:SetText(vFriendName);
			CalendarAddPlayerFrameLevel:SetText(vLevel);
			CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameClassMenu, EventDatabase_GetClassCodeByClass(vClass));
			-- CalendarDropDown_SetSelectedValue(CalendarAddPlayerFrameRaceMenu, EventDatabase_GetRaceCodeByRace(vRace));
		end
	end
	
	return false;
end

function CalendarAddPlayerWhisper_OnEnter()
	if not CalendarAddPlayerFrame.IsWhisper then
		return;
	end
	
	CalendarAttendanceList_ShowMessageTooltip(this, CalendarAddPlayerFrame.Name, CalendarAddPlayerFrame.Whispers, ChatTypeInfo["WHISPER"]);
end

function CalendarAddPlayerWhisper_OnLeave()
	GameTooltip:Hide();
end

function CalendarAddPlayerWhisper_Reply()
	local	vName;
	
	if CalendarAddPlayerFrame.Name then
		vName = CalendarAddPlayerFrame.Name;
	else
		vName = CalendarAddPlayerFrameName:GetText()
	end

	if not vName or vName == "" then
		return;
	end
	
	DEFAULT_CHAT_FRAME.editBox.chatType = "WHISPER";
	DEFAULT_CHAT_FRAME.editBox.tellTarget = vName;
	
	ChatEdit_UpdateHeader(DEFAULT_CHAT_FRAME.editBox);
	
	if not DEFAULT_CHAT_FRAME.editBox:IsVisible() then
		ChatFrame_OpenChat("", DEFAULT_CHAT_FRAME);
	end
end

function CalendarEventEditor_AttendanceMenuItemSelected(pOwner, pValue)
	local	vAttendanceItem = pOwner:GetParent();
	local	vLineIndex = vAttendanceItem:GetID();
	local	vAttendanceList = vAttendanceItem:GetParent();
	
	local	vItem = CalendarAttendanceList_GetIndexedItem(vAttendanceList, vLineIndex);
	
	if pValue == "DELETE" then
		if vItem.mType == "Whisper" then
			CalendarWhisperLog_RemovePlayer(vItem.mName);
		else
			gGroupCalendar_RSVPToDelete = vItem;
			StaticPopup_Show("CONFIRM_CALENDAR_RSVP_DELETE", vItem.mName);
		end
	elseif pValue == "ADD" then
		if vItem.mType == "Whisper" then
			CalendarAddPlayer_OpenWhisper(vItem.mName, vItem.mDate, vItem.mTime, vItem.mWhispers);
		end
	elseif pValue == "EDIT" then
		CalendarAddPlayer_EditRSVP(vItem);
	elseif pValue == "INVITE" then
		InviteByName(vItem.mName);
	else
		vItem.mStatus = pValue;
		
		EventDatabase_AddEventRSVP(
				gCalendarEventEditor_Database,
				gCalendarEventEditor_Event,
				vItem.mName,
				vItem);
	end
end

function CalendarClassLimitItem_SetClassName(pItem, pClassName)
	local	vItemName = pItem:GetName();
	local	vLabelItem = getglobal(vItemName.."Label");
	local	vSeparatorItem = getglobal(vItemName.."Separator");
	
	local	vLabel = getglobal("GroupCalendar_c"..pClassName.."sLabel");
	vLabelItem:SetText(vLabel);

	local	vColor = RAID_CLASS_COLORS[getglobal("GroupCalendar_c"..pClassName.."ClassColorName")];
	
	vLabelItem:SetTextColor(vColor.r, vColor.g, vColor.b);
	vSeparatorItem:SetTextColor(vColor.r, vColor.g, vColor.b);
end

function CalendarAttendanceTotals_OnShow(pTotalsFrame)
	local	vFrameName = this:GetName();
	local	vPaladinsFrame = getglobal(vFrameName.."Paladins");
	local	vPaladinsLabelFrame = getglobal(vFrameName.."PaladinsLabel");
	local	vShamansFrame = getglobal(vFrameName.."Shamans");
	local	vShamansLabelFrame = getglobal(vFrameName.."ShamansLabel");
	
	if gGroupCalendar_PlayerFactionGroup == "Alliance" then
		vPaladinsFrame:Show();
		vPaladinsLabelFrame:Show();
		vShamansFrame:Hide();
		vShamansLabelFrame:Hide();
	else
		vPaladinsFrame:Hide();
		vPaladinsLabelFrame:Hide();
		vShamansFrame:Show();
		vShamansLabelFrame:Show();
	end
end

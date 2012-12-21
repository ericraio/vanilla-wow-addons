CalendarEditor_cMaxItems = 15;

gCalendarEditor_SelectedDate = -1;
gCalendarEditor_CompiledSchedule = nil;

function CalendarEditor_ShowCompiledSchedule(pDate, pCompiledSchedule)
	-- Make sure the event editor and viewer is closed
	
	CalendarEventEditor_DoneEditing();
	CalendarEventViewer_DoneViewing();
	
	--
	
	gCalendarEditor_SelectedDate = pDate;
	gCalendarEditor_CompiledSchedule = pCompiledSchedule;
	
	-- Set the date being displayed
	
	CalendarEditorFrameSubTitle:SetText(Calendar_GetLongDateString(pDate));
	
	CalendarEditor_BuildCompiledScheduleList(pCompiledSchedule);
	
	Calendar_SetButtonEnable(CalendarEditorNewEventButton, gCalendarEditor_SelectedDate >= gGroupCalendar_MinimumEventDate);
	
	ShowUIPanel(CalendarEditorFrame);
end

function CalendarEditor_BuildCompiledScheduleList(pCompiledSchedule)
	local	vItemIndex = 1;
	local	vTotalNumItems = 0;
	
	if pCompiledSchedule ~= nil then
		-- Populate the schedule items
		
		vTotalNumItems = table.getn(pCompiledSchedule);
		
		for vEventIndex, vCompiledEvent in pCompiledSchedule do
			local	vEventItemName = "CalendarEditorEvent"..vItemIndex;
			
			local	vEventItemFrame = getglobal(vEventItemName);
			local	vEventItemTime = getglobal(vEventItemName.."Time");
			local	vEventItemTitle = getglobal(vEventItemName.."Title");
			local	vEventItemOwner = getglobal(vEventItemName.."Owner");
			local	vEventItemCircled = getglobal(vEventItemName.."Circled");
			
			if vCompiledEvent.mEvent.mType == "Birth" then
				vEventItemTime:SetText(GroupCalendar_cBirthdayEventName);
			else
				local	vTime;
				
				if gGroupCalendar_Settings.ShowEventsInLocalTime then
					vTime = Calendar_GetLocalTimeFromServerTime(vCompiledEvent.mEvent.mTime);
				else
					vTime = vCompiledEvent.mEvent.mTime;
				end
				
				vEventItemTime:SetText(Calendar_GetShortTimeString(vTime));
			end
			
			vEventItemTitle:SetText(EventDatabase_GetEventDisplayName(vCompiledEvent.mEvent));
			vEventItemOwner:SetText(vCompiledEvent.mOwner);
			
			if EventDatabase_PlayerIsAttendingEvent(vCompiledEvent.mOwner, vCompiledEvent.mEvent) then
				vEventItemCircled:Show();
			else
				vEventItemCircled:Hide();
			end
			
			vEventItemFrame:Show();
			
			vItemIndex = vItemIndex + 1;
			
			if vItemIndex > CalendarEditor_cMaxItems then
				break;
			end
		end
	end
	
	FauxScrollFrame_Update(
			CalendarEditorScrollFrame,
			vTotalNumItems,
			CalendarEditor_cMaxItems,
			22,
			nil, nil, nil,
			nil,
			220, 254);
	
	for vIndex = vItemIndex, CalendarEditor_cMaxItems do
		local	vEventItemFrame = getglobal("CalendarEditorEvent"..vIndex);
		
		vEventItemFrame:Hide();
	end
end

function CalendarEditor_ScheduleChanged(pDate, pSchedule)
	if pDate == gCalendarEditor_SelectedDate then
		local	vCompiledSchedule = EventDatabase_GetCompiledSchedule(pDate);
		
		gCalendarEditor_CompiledSchedule = vCompiledSchedule;
		
		CalendarEditor_BuildCompiledScheduleList(vCompiledSchedule);
	end
end

function CalendarEditor_MajorDatabaseChange()
	if not gCalendarEditor_SelectedDate == -1 then
		return;
	end
	
	local	vCompiledSchedule = EventDatabase_GetCompiledSchedule(gCalendarEditor_SelectedDate);

	gCalendarEditor_CompiledSchedule = vCompiledSchedule;

	CalendarEditor_BuildCompiledScheduleList(vCompiledSchedule);
end

function CalendarEditor_IsOpen()
	return gCalendarEditor_SelectedDate ~= -1
			and not gCalendarEventEditor_Active
			and not gCalendarEventViewer_Active;
end

function CalendarEditor_Close()
	HideUIPanel(CalendarEditorFrame);
end

function CalendarEditor_OnShow()
	PlaySound("igCharacterInfoOpen");
end

function CalendarEditor_OnHide()
	PlaySound("igCharacterInfoClose");
	gCalendarEditor_SelectedDate = -1;
	GroupCalendar_EditorClosed();
end

function CalendarEditor_NewEvent()
	local	vDatabase = EventDatabase_GetDatabase(gGroupCalendar_PlayerName, true);
	local	vEvent = EventDatabase_NewEvent(vDatabase, gCalendarEditor_SelectedDate);
	
	CalendarEventEditor_EditEvent(vDatabase, vEvent, true);
end

function CalendarEditor_EditIndexedEvent(pIndex)
	local		vCompiledEvent = gCalendarEditor_CompiledSchedule[pIndex];
	local		vDatabase = EventDatabase_GetDatabase(vCompiledEvent.mOwner);
	
	if vDatabase then
		if vDatabase.IsPlayerOwned
		and not EventDatabase_IsResetEventType(vCompiledEvent.mEvent.mType) then
			CalendarEventEditor_EditEvent(vDatabase, vCompiledEvent.mEvent, false);
		else
			CalendarEventViewer_ViewEvent(vDatabase, vCompiledEvent.mEvent);
		end
	end
end

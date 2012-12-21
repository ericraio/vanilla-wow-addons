gCalendarEventViewer_ShowScheduleEditor = false;
gCalendarEventViewer_Active = false;

gCalendarEventViewer_Database = nil;
gCalendarEventViewer_Event = nil;
gCalendarEventViewer_SelectedPlayerDatabase = nil;

gCalendarEventViewer_PanelFrames =
{
	"CalendarEventViewerEventFrame",
	"CalendarEventViewerAttendanceFrame",
};

gCalendarEventViewer_CurrentPanel = 1;

function CalendarEventViewer_ViewEvent(pDatabase, pEvent)
	gCalendarEventViewer_Database = pDatabase;
	gCalendarEventViewer_Event = pEvent;
	gCalendarEventViewer_SelectedPlayerDatabase = gGroupCalendar_UserDatabase;
	
	CalendarAttendanceList_SetEvent(CalendarEventViewerAttendance, pDatabase, pEvent);
	CalendarEventViewer_UpdateControlsFromEvent(gCalendarEventViewer_Event, false);
	
	ShowUIPanel(CalendarEventViewerFrame);
	
	CalendarEventTitle:SetFocus();
	CalendarEventTitle:HighlightText(0, 100);
	
	gCalendarEventViewer_ShowScheduleEditor = false;
	gCalendarEventViewer_Active = true;
end

function CalendarEventViewer_DoneViewing()
	if not gCalendarEventViewer_Active then
		return;
	end
	
	CalendarEventViewer_Close(true);
end

function CalendarEventViewer_ScheduleChanged(pDate)
	if gCalendarEventViewer_Active
	and gCalendarEventViewer_Event.mDate == pDate then
		CalendarAttendanceList_EventChanged(CalendarEventViewerAttendance, gCalendarEventViewer_Database, gCalendarEventViewer_Event);
		CalendarEventViewer_UpdateControlsFromEvent(gCalendarEventViewer_Event, true);
	end
end

function CalendarEventViewer_MajorDatabaseChange()
	if gCalendarEventViewer_Active then
		CalendarAttendanceList_EventChanged(CalendarEventViewerAttendance, gCalendarEventViewer_Database, gCalendarEventViewer_Event);
		CalendarEventViewer_UpdateControlsFromEvent(gCalendarEventViewer_Event, true);
	end
end

function CalendarEventViewer_Save()
	-- Save attendance feedback
	
	if EventDatabase_EventTypeUsesAttendance(gCalendarEventViewer_Event.mType)
	and EventDatabase_PlayerIsQualifiedForEvent(gCalendarEventViewer_Event, gCalendarEventViewer_SelectedPlayerDatabase.PlayerLevel) then
		local	vPendingRSVP = EventDatabase_FindRSVPRequestData(gCalendarEventViewer_SelectedPlayerDatabase, gCalendarEventViewer_Database.UserName, gCalendarEventViewer_Event.mID);
		local	vEventRSVP = EventDatabase_FindEventRSVP(gCalendarEventViewer_Database.UserName, gCalendarEventViewer_Event, gCalendarEventViewer_SelectedPlayerDatabase.UserName);
		local	vChanged = false;
		local	vHasResponse = false;
		local	vStatus;
		local	vComment;
		
		if not vPendingRSVP then
			if vEventRSVP then
				vStatus = vEventRSVP.mStatus;
				vComment = vEventRSVP.mComment;
			else
				vStatus = nil;
				vComment = "";
			end
		else
			vStatus = vPendingRSVP.mStatus;
			vComment = vPendingRSVP.mComment;
		end
		
		if not vComment then
			vComment = "";
		end
		
		-- Update the status
		
		if CalendarEventViewerYes:GetChecked() then
			vHasResponse = true;
			
			if vStatus ~= "Y" then
				vStatus = "Y";
				vChanged = true;
			end
		elseif CalendarEventViewerNo:GetChecked() then
			vHasResponse = true;
			
			if vStatus ~= "N" then
				vStatus = "N";
				vChanged = true;
			end
		--[[
		elseif vStatus ~= nil
		and vStatus ~= "-" then
			vStatus = "-";
			vChanged = true;
		]]
		end
		
		-- Update the comment
		
		if vHasResponse then
			local	vNewComment = Calendar_EscapeString(CalendarEventViewerComment:GetText());
			
			if vComment ~= vNewComment then
				vComment = vNewComment;
				vChanged = true;
			end
		end
		
		-- Add a new RSVP if it's changed
		
		if vChanged then
			local	vRSVP = EventDatabase_CreatePlayerRSVP(
									gCalendarEventViewer_Database,
									gCalendarEventViewer_Event,
									gCalendarEventViewer_SelectedPlayerDatabase.UserName,
									gCalendarEventViewer_SelectedPlayerDatabase.PlayerRaceCode,
									gCalendarEventViewer_SelectedPlayerDatabase.PlayerClassCode,
									gCalendarEventViewer_SelectedPlayerDatabase.PlayerLevel,
									vStatus,
									vComment,
									gGroupCalendar_PlayerGuild,
									gGroupCalendar_PlayerGuildRank,
									gGroupCalendar_PlayerCharacters);
			
			EventDatabase_AddRSVP(gCalendarEventViewer_SelectedPlayerDatabase, vRSVP);
			
			-- Update the UI
			
			CalendarAttendanceList_EventChanged(CalendarEventViewerAttendance, gCalendarEventViewer_Database, gCalendarEventViewer_Event);
			CalendarEventViewer_UpdateControlsFromEvent(gCalendarEventViewer_Event, false);
		end
	end
end

function CalendarEventViewer_Close(pShowScheduleEditor)
	gCalendarEventViewer_ShowScheduleEditor = pShowScheduleEditor;
	HideUIPanel(CalendarEventViewerFrame);
end

function CalendarEventViewer_OnLoad()
	-- Tabs
	
	PanelTemplates_SetNumTabs(this, table.getn(gCalendarEventViewer_PanelFrames));
	CalendarEventViewerFrame.selectedTab = gCalendarEventViewer_CurrentPanel;
	PanelTemplates_UpdateTabs(this);
	
	CalendarEventViewerCharacterMenu.ChangedValueFunc = CalendarEventViewer_SelectedCharacterChanged;
end

function CalendarEventViewer_OnShow()
	PlaySound("igCharacterInfoOpen");
	
	CalendarEventViewer_ShowPanel(1); -- Always switch to the event view when showing the window
end

function CalendarEventViewer_OnHide()
	PlaySound("igCharacterInfoClose");
	
	CalendarEventViewer_Save();
	
	if not gCalendarEventViewer_ShowScheduleEditor then
		HideUIPanel(CalendarEditorFrame);
	end
	
	gCalendarEventViewer_Database = nil;
	gCalendarEventViewer_Event = nil;
	
	gCalendarEventViewer_Active = false;
end

function CalendarEventViewer_SelectedCharacterChanged(pMenuFrame, pValue)
	gCalendarEventViewer_SelectedPlayerDatabase = EventDatabase_GetDatabase(pValue, false);
	CalendarEventViewer_UpdateControlsFromEvent(gCalendarEventViewer_Event, false);
end

function CalendarEventViewer_UpdateControlsFromEvent(pEvent, pSkipAttendanceFields)
	-- Update the title
	
	CalendarEventViewerEventFrameEventTitle:SetText(EventDatabase_GetEventDisplayName(pEvent));
	
	-- Update the date and time
	
	if pEvent.mTime ~= nil then
		local		vTime;
		local		vDate = pEvent.mDate;
		
		if gGroupCalendar_Settings.ShowEventsInLocalTime then
			vDate, vTime = Calendar_GetLocalDateTimeFromServerDateTime(pEvent.mDate, pEvent.mTime);
		else
			vTime = pEvent.mTime;
		end
		
		-- Set the date
		
		CalendarEventViewerEventFrameDate:SetText(Calendar_GetLongDateString(vDate));
		
		--
		
		local		vTimeString;
		
		if pEvent.mDuration ~= nil
		and pEvent.mDuration ~= 0 then
			local	vEndTime = math.mod(vTime + pEvent.mDuration, 1440);
			
			vTimeString = string.format(
								GroupCalendar_cTimeRangeFormat,
								Calendar_GetShortTimeString(vTime),
								Calendar_GetShortTimeString(vEndTime));
			
		else
			vTimeString = Calendar_GetShortTimeString(vTime);
		end

		CalendarEventViewerEventFrameTime:SetText(vTimeString);
		CalendarEventViewerEventFrameTime:Show();
	else
		CalendarEventViewerEventFrameDate:SetText(Calendar_GetLongDateString(pEvent.mDate));
		CalendarEventViewerEventFrameTime:Hide();
	end
	
	-- Update the level range
	
	if EventDatabase_EventTypeUsesLevelLimits(pEvent.mType) then
		if pEvent.mMinLevel ~= nil then
			if pEvent.mMaxLevel ~= nil then
				if pEvent.mMinLevel == pEvent.mMaxLevel then
					CalendarEventViewerEventFrameLevels:SetText(string.format(CalendarEventViewer_cSingleLevel, pEvent.mMinLevel));
				else
					CalendarEventViewerEventFrameLevels:SetText(string.format(CalendarEventViewer_cLevelRangeFormat, pEvent.mMinLevel, pEvent.mMaxLevel));
				end
			else
				if pEvent.mMinLevel == 60 then
					CalendarEventViewerEventFrameLevels:SetText(string.format(CalendarEventViewer_cSingleLevel, pEvent.mMinLevel));
				else
					CalendarEventViewerEventFrameLevels:SetText(string.format(CalendarEventViewer_cMinLevelFormat, pEvent.mMinLevel));
				end
			end
			
			CalendarEventViewerEventFrameLevels:Show();
		else
			if pEvent.mMaxLevel ~= nil then
				CalendarEventViewerEventFrameLevels:SetText(string.format(CalendarEventViewer_cMaxLevelFormat, pEvent.mMaxLevel));
			else
				CalendarEventViewerEventFrameLevels:SetText(CalendarEventViewer_cAllLevels);
			end
			
			CalendarEventViewerEventFrameLevels:Show();
		end
		
		if EventDatabase_PlayerIsQualifiedForEvent(gCalendarEventViewer_Event, gCalendarEventViewer_SelectedPlayerDatabase.PlayerLevel) then
			CalendarEventViewerEventFrameLevels:SetTextColor(1.0, 0.82, 0);
		else
			CalendarEventViewerEventFrameLevels:SetTextColor(1.0, 0.2, 0.2);
		end
	else
		CalendarEventViewerEventFrameLevels:Hide();
	end
	
	-- Update the description
	
	if pEvent.mDescription then
		CalendarEventViewerDescText:SetText(Calendar_UnescapeString(pEvent.mDescription));
		CalendarEventViewerDescText:Show();
	else
		CalendarEventViewerDescText:Hide();
	end
	
	-- Update the attendance
	
	if EventDatabase_EventTypeUsesAttendance(pEvent.mType) then
		local	vIsAttending = false;
		local	vIsNotAttending = false;
		local	vAttendanceComment = "";
		
		CalendarEventViewer_SetAttendanceVisible(true);
		
		if not pSkipAttendanceFields then
			CalendarDropDown_SetSelectedValue(CalendarEventViewerCharacterMenu, gCalendarEventViewer_SelectedPlayerDatabase.UserName);
			
			if EventDatabase_PlayerIsQualifiedForEvent(gCalendarEventViewer_Event, gCalendarEventViewer_SelectedPlayerDatabase.PlayerLevel) then
				CalendarEventViewer_SetAttendanceEnabled(true);
				
				local	vPendingRSVP = EventDatabase_FindRSVPRequestData(gCalendarEventViewer_SelectedPlayerDatabase, gCalendarEventViewer_Database.UserName, gCalendarEventViewer_Event.mID);
				local	vEventRSVP = EventDatabase_FindEventRSVP(gCalendarEventViewer_Database.UserName, gCalendarEventViewer_Event, gCalendarEventViewer_SelectedPlayerDatabase.UserName);
				local	vRSVP;
				
				if vPendingRSVP then
					vRSVP = vPendingRSVP;
				else
					vRSVP = vEventRSVP;
				end
				
				if vRSVP then
					vIsAttending = vRSVP.mStatus == "Y" or vRSVP.mStatus == "S";
					vIsNotAttending = vRSVP.mStatus == "N";
					
					if vRSVP.mComment then
						vAttendanceComment = Calendar_UnescapeString(vRSVP.mComment);
					end
				end
				
				CalendarEventViewer_SetResponseStatus(vPendingRSVP, vEventRSVP);
			else
				CalendarEventViewer_SetAttendanceEnabled(false);
			end
			
			CalendarEventViewerYes:SetChecked(vIsAttending);
			CalendarEventViewerNo:SetChecked(vIsNotAttending);
			CalendarEventViewerComment:SetText(vAttendanceComment);
			
			CalendarEventViewer_UpdateCommentEnable();
		end -- if not skipAttendance
	else
		CalendarEventViewer_SetAttendanceVisible(false);
	end
	
	if pEvent.mType ~= nil then
		CalendarEventViewerEventBackground:SetTexture(Calendar_GetEventTypeIconPath(pEvent.mType));
		if pEvent.mType == "Birth" then
			CalendarEventViewerEventBackground:SetVertexColor(1, 1, 1, 0.8);
		else
			CalendarEventViewerEventBackground:SetVertexColor(1, 1, 1, 0.19);
		end
	else
		CalendarEventViewerEventBackground:SetTexture("");
	end
end

function CalendarEventViewer_UpdateCommentEnable()
	local	vEnable = CalendarEventViewerYes:GetChecked() or CalendarEventViewerNo:GetChecked();
	
	Calendar_SetEditBoxEnable(CalendarEventViewerComment, vEnable);
end

function CalendarEventViewer_SetAttendanceEnabled(pEnable)
	Calendar_SetCheckButtonEnable(CalendarEventViewerYes, pEnable);
	Calendar_SetCheckButtonEnable(CalendarEventViewerNo, pEnable);
	Calendar_SetEditBoxEnable(CalendarEventViewerComment, pEnable);
	
	if pEnable then
		CalendarEventViewerEventFrameStatus:Show();
	else
		CalendarEventViewerEventFrameStatus:Hide();
	end
end

function CalendarEventViewer_SetAttendanceVisible(pVisible)
	if pVisible then
		CalendarEventViewerCharacter:Show();
		CalendarEventViewerYes:Show();
		CalendarEventViewerNo:Show();
		CalendarEventViewerComment:Show();
		CalendarEventViewerEventFrameStatus:Show();
		CalendarEventViewerFrameTab2:Show();
	else
		CalendarEventViewerCharacter:Hide();
		CalendarEventViewerYes:Hide();
		CalendarEventViewerNo:Hide();
		CalendarEventViewerComment:Hide();
		CalendarEventViewerEventFrameStatus:Hide();
		CalendarEventViewerFrameTab2:Hide();
	end
end

function CalendarEventViewer_CalculateResponseStatus(pPendingRSVP, pEventRSVP)
	if pPendingRSVP then
		return 2;
	elseif pEventRSVP then
		return 3;
	else
		return 1;
	end
end

function CalendarEventViewer_SetResponseStatus(pPendingRSVP, pEventRSVP)
	local	vStatus = CalendarEventViewer_CalculateResponseStatus(pPendingRSVP, pEventRSVP);
	CalendarEventViewerEventFrameStatus:SetText(CalendarEventViewer_cResponseMessage[vStatus]);
end

function CalendarEventViewer_ShowPanel(pPanelIndex)
	if gCalendarEventViewer_CurrentPanel > 0
	and gCalendarEventViewer_CurrentPanel ~= pPanelIndex then
		CalendarEventViewer_HidePanel(gCalendarEventViewer_CurrentPanel);
	end
	
	-- NOTE: Don't check for redundant calls since this function
	-- will be called to reset the field values as well as to 
	-- actuall show the panel when it's hidden
	
	gCalendarEventViewer_CurrentPanel = pPanelIndex;
	
	-- Update the control values
	
	if pPanelIndex == 1 then
		-- Event panel

		CalendarEventViewerParchment:Show();
		
	elseif pPanelIndex == 2 then
		-- Attendance panel
		
		CalendarEventViewerParchment:Hide();
		
		if EventDatabase_IsQuestingEventType(gCalendarEventViewer_Event.mType) then
			CalendarAttendanceList_SetClassTotalsVisible(CalendarEventViewerAttendance, true, false);
		else
			CalendarAttendanceList_SetClassTotalsVisible(CalendarEventViewerAttendance, false, false);
		end
	else
		Calendar_DebugMessage("CalendarEventViewer_ShowPanel: Unknown index ("..pPanelIndex..")");
	end
	
	getglobal(gCalendarEventViewer_PanelFrames[pPanelIndex]):Show();
	
	PanelTemplates_SetTab(CalendarEventViewerFrame, pPanelIndex);
end

function CalendarEventViewer_HidePanel(pFrameIndex)
	if gCalendarEventViewer_CurrentPanel ~= pFrameIndex then
		return;
	end
	
	CalendarEventViewer_Save();
	
	getglobal(gCalendarEventViewer_PanelFrames[pFrameIndex]):Hide();
	gCalendarEventViewer_CurrentPanel = 0;
end


SLASH_EXTENDEDQUESTLOG1 = "/eql";

function EQL_Options_OnLoad()
	SlashCmdList["EXTENDEDQUESTLOG"] = function(msg)
		EQL3_SlashCmd(msg);
	end
  this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("QUEST_LOG_UPDATE");
end

-- Let's see how of theese are needed
old_GetNumQuestLogEntries = GetNumQuestLogEntries;
-- local existingGetQuestLogTitle = GetQuestLogTitle;
old_SelectQuestLogEntry = SelectQuestLogEntry;
old_GetQuestLogSelection = GetQuestLogSelection;
old_ExpandQuestHeader = ExpandQuestHeader;
old_CollapseQuestHeader = CollapseQuestHeader;
old_IsUnitOnQuest = IsUnitOnQuest;
-- local existingIsQuestWatched = IsQuestWatched;
-- local existingAddQuestWatch = AddQuestWatch;
-- local existingRemoveQuestWatch = RemoveQuestWatch;
-- local existingGetQuestIndexForWatch = GetQuestIndexForWatch;
old_GetNumQuestLeaderBoards = GetNumQuestLeaderBoards;
old_GetQuestLogLeaderBoard = GetQuestLogLeaderBoard;

function EQL_Options_OnEvent(event)
	-- Only for organizer...
	if ( event == "QUEST_LOG_UPDATE" ) then
		if(not EQL3_Temp.GotQuestLogUpdate) then
			EQL3_Temp.GotQuestLogUpdate = 1;
			EQL3_RefreshOtherQuestDisplays();
			return;
		end
		EQL3_UpdateDB();
	end
	
	if (event == "VARIABLES_LOADED") then
		
		EQL_Options_SetStates();
					
	end
end



function EQL_Options_SetStates()
		if(QuestlogOptions[EQL3_Player].ShowQuestLevels == 1) then
			EQL3_OptionsFrame_Checkbox_ShowQuestLevels:SetChecked(1);
			EQL3_OptionsFrame_Checkbox_QuestLevelsOnlyInLog:Enable();
		else
			EQL3_OptionsFrame_Checkbox_ShowQuestLevels:SetChecked(0);
			EQL3_OptionsFrame_Checkbox_QuestLevelsOnlyInLog:Disable();
		end
		
		if(QuestlogOptions[EQL3_Player].RestoreUponSelect == 1) then
			EQL3_OptionsFrame_Checkbox_RestoreUponSelect:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_RestoreUponSelect:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].MinimizeUponClose == 1) then
			EQL3_OptionsFrame_Checkbox_MinimizeUponClose:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_MinimizeUponClose:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].CustomZoneColor == 1) then
			EQL3_OptionsFrame_Checkbox_CustomZoneColor:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_CustomZoneColor:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].CustomHeaderColor == 1) then
			EQL3_OptionsFrame_Checkbox_CustomHeaderColor:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_CustomHeaderColor:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].CustomObjetiveColor == 1) then
			EQL3_OptionsFrame_Checkbox_CustomObjectiveColor:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_CustomObjectiveColor:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].FadeHeaderColor == 1) then
			EQL3_OptionsFrame_Checkbox_FadeHeaderColor:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_FadeHeaderColor:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].FadeObjectiveColor == 1) then
			EQL3_OptionsFrame_Checkbox_FadeObjectiveColor:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_FadeObjectiveColor:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].CustomTrackerBGColor == 1) then
			EQL3_OptionsFrame_Checkbox_CustomTrackerBGColor:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_CustomTrackerBGColor:SetChecked(0);
		end
		
		if ( QuestlogOptions[EQL3_Player].ShowObjectiveMarkers == 1) then
			EQL3_OptionsFrame_Checkbox_ShowObjectiveMarkers:SetChecked(1);
			EQL3_OptionsFrame_Checkbox_UseTrackerListing:Enable();
			if(QuestlogOptions[EQL3_Player].UseTrackerListing == 1) then
				EQL3_OptionsFrame_Checkbox_Symbol1:Disable();
				EQL3_OptionsFrame_Checkbox_Symbol2:Disable();
				EQL3_OptionsFrame_Checkbox_Symbol3:Disable();
				EQL3_OptionsFrame_Checkbox_Symbol4:Disable();
				EQL3_OptionsFrame_Checkbox_List1:Enable();
				EQL3_OptionsFrame_Checkbox_List2:Enable();
				EQL3_OptionsFrame_Checkbox_List3:Enable();
				EQL3_OptionsFrame_Checkbox_List4:Enable();
			else
				EQL3_OptionsFrame_Checkbox_List1:Disable();
				EQL3_OptionsFrame_Checkbox_List2:Disable();
				EQL3_OptionsFrame_Checkbox_List3:Disable();
				EQL3_OptionsFrame_Checkbox_List4:Disable();
				EQL3_OptionsFrame_Checkbox_Symbol1:Enable();
				EQL3_OptionsFrame_Checkbox_Symbol2:Enable();
				EQL3_OptionsFrame_Checkbox_Symbol3:Enable();
				EQL3_OptionsFrame_Checkbox_Symbol4:Enable();
			end
		else
			EQL3_OptionsFrame_Checkbox_ShowObjectiveMarkers:SetChecked(0);
			EQL3_OptionsFrame_Checkbox_UseTrackerListing:Disable();
			EQL3_OptionsFrame_Checkbox_List1:Disable();
			EQL3_OptionsFrame_Checkbox_List2:Disable();
			EQL3_OptionsFrame_Checkbox_List3:Disable();
			EQL3_OptionsFrame_Checkbox_List4:Disable();
			EQL3_OptionsFrame_Checkbox_Symbol1:Disable();
			EQL3_OptionsFrame_Checkbox_Symbol2:Disable();
			EQL3_OptionsFrame_Checkbox_Symbol3:Disable();
			EQL3_OptionsFrame_Checkbox_Symbol4:Disable();
		end
		
		if(QuestlogOptions[EQL3_Player].UseTrackerListing == 1) then
			EQL3_OptionsFrame_Checkbox_UseTrackerListing:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_UseTrackerListing:SetChecked(0);
		end
		
		EQL3_OptionsFrame_Checkbox_List1:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_List2:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_List3:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_List4:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_Symbol1:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_Symbol2:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_Symbol3:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_Symbol4:SetChecked(0);
		
		getglobal("EQL3_OptionsFrame_Checkbox_List"..(QuestlogOptions[EQL3_Player].TrackerList+1)):SetChecked(1);
		getglobal("EQL3_OptionsFrame_Checkbox_Symbol"..(QuestlogOptions[EQL3_Player].TrackerSymbol+1)):SetChecked(1);
		
		
		EQL3_OptionsFrame_Checkbox_ShowZones:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_SortTracker:Enable();
		EQL3_OptionsFrame_Checkbox_SortTracker:SetChecked(0);
		
		if(QuestlogOptions[EQL3_Player].ShowZonesInTracker == 1) then
			EQL3_OptionsFrame_Checkbox_ShowZones:SetChecked(1);
			EQL3_OptionsFrame_Checkbox_SortTracker:Disable();
			EQL3_OptionsFrame_Checkbox_SortTracker:SetChecked(1);
		end
		
		if(QuestlogOptions[EQL3_Player].SortTrackerItems == 1) then
			EQL3_OptionsFrame_Checkbox_SortTracker:SetChecked(1);
		end
		
		if(QuestlogOptions[EQL3_Player].Color["TrackerBG"]) then
			EQL3_OptionsFrame_ColorSwatch_TrackerBGNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["TrackerBG"].r, 
																																					 QuestlogOptions[EQL3_Player].Color["TrackerBG"].g, 
																																					 QuestlogOptions[EQL3_Player].Color["TrackerBG"].b );
		end
		
		if(QuestlogOptions[EQL3_Player].Color["Zone"]) then
			EQL3_OptionsFrame_ColorSwatch_ZoneNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["Zone"].r, 
																																					 QuestlogOptions[EQL3_Player].Color["Zone"].g, 
																																					 QuestlogOptions[EQL3_Player].Color["Zone"].b );
		end
		
		if(QuestlogOptions[EQL3_Player].Color["HeaderEmpty"]) then
			EQL3_OptionsFrame_ColorSwatch_Header_EmptyNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["HeaderEmpty"].r, 
																																					 QuestlogOptions[EQL3_Player].Color["HeaderEmpty"].g, 
																																					 QuestlogOptions[EQL3_Player].Color["HeaderEmpty"].b );
		end
		
		if(QuestlogOptions[EQL3_Player].Color["HeaderComplete"]) then
			EQL3_OptionsFrame_ColorSwatch_Header_CompleteNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["HeaderComplete"].r, 
																																					 QuestlogOptions[EQL3_Player].Color["HeaderComplete"].g, 
																																					 QuestlogOptions[EQL3_Player].Color["HeaderComplete"].b );
		end
		
		if(QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"]) then
			EQL3_OptionsFrame_ColorSwatch_Objective_EmptyNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"].r, 
																																					 QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"].g, 
																																					 QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"].b );
		end
		
		if(QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"]) then
			EQL3_OptionsFrame_ColorSwatch_Objective_CompleteNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"].r, 
																																					 QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"].g, 
																																					 QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"].b );
		end
		
		if(QuestlogOptions[EQL3_Player].Color["Tooltip"]) then
			EQL3_OptionsFrame_ColorSwatch_TooltipInfoNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["Tooltip"].r, 
																																					 QuestlogOptions[EQL3_Player].Color["Tooltip"].g, 
																																					 QuestlogOptions[EQL3_Player].Color["Tooltip"].b );
		end
		
		
		
		if(QuestlogOptions[EQL3_Player].LockTracker == 1) then
			EQL3_OptionsFrame_Checkbox_LockTracker:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_LockTracker:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].AddNew == 1) then
			EQL3_OptionsFrame_Checkbox_AddNew:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_AddNew:SetChecked(0);
		end
		
		EQL3_OptionsFrame_Checkbox_RemoveFinished:SetChecked(0);
		EQL3_OptionsFrame_Checkbox_MinimizeFinished:Enable();
		EQL3_OptionsFrame_Checkbox_MinimizeFinished:SetChecked(0);
		
		if(QuestlogOptions[EQL3_Player].RemoveFinished == 1) then
			EQL3_OptionsFrame_Checkbox_RemoveFinished:SetChecked(1);
			EQL3_OptionsFrame_Checkbox_MinimizeFinished:Disable();
		end
		
		if(QuestlogOptions[EQL3_Player].MinimizeFinished == 1) then
			EQL3_OptionsFrame_Checkbox_MinimizeFinished:SetChecked(1);
		end
		
		if(QuestlogOptions[EQL3_Player].AddUntracked == 1) then
			EQL3_OptionsFrame_Checkbox_AddUntracked:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_AddUntracked:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].LockQuestLog == 1) then
			EQL3_OptionsFrame_Checkbox_LockQuestLog:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_LockQuestLog:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].TrackerShowMinimizer == 1) then
			EQL3_OptionsFrame_Checkbox_ShowMinimizer:SetChecked(1);
			EQL3_Tracker_MinimizeButton:Show();
		else
			EQL3_OptionsFrame_Checkbox_ShowMinimizer:SetChecked(0);
			EQL3_Tracker_MinimizeButton:Hide();
			QuestlogOptions[EQL3_Player].TrackerIsMinimized = 0;
		end
		
		-- new to 3.5.6
		
		if(QuestlogOptions[EQL3_Player].AutoCompleteQuests == 1) then
			EQL3_OptionsFrame_Checkbox_AutoCompleteQuests:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_AutoCompleteQuests:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].OnlyLevelsInLog == 1) then
			EQL3_OptionsFrame_Checkbox_QuestLevelsOnlyInLog:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_QuestLevelsOnlyInLog:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].RemoveCompletedObjectives == 1) then
			EQL3_OptionsFrame_Checkbox_HideCompletedObjectives:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_HideCompletedObjectives:SetChecked(0);
		end
		
		-- new to 3.5.9
		
		if(QuestlogOptions[EQL3_Player].ItemTooltip == 1) then
			EQL3_OptionsFrame_Checkbox_ShowItemTooltip:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_ShowItemTooltip:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].MobTooltip == 1) then
			EQL3_OptionsFrame_Checkbox_ShowMobTooltip:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_ShowMobTooltip:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].InfoOnQuestCompletion == 1) then
			EQL3_OptionsFrame_Checkbox_InfoOnQuestComplete:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_InfoOnQuestComplete:SetChecked(0);
		end
		
		if(QuestlogOptions[EQL3_Player].CustomTooltipColor == 1) then
			EQL3_OptionsFrame_Checkbox_CustomTooltipInfoColor:SetChecked(1);
		else
			EQL3_OptionsFrame_Checkbox_CustomTooltipInfoColor:SetChecked(0);
		end
end




function EQL3_Toggle_QuestLevels()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].ShowQuestLevels = 1;
		EQL3_OptionsFrame_Checkbox_QuestLevelsOnlyInLog:Enable();
	else
		QuestlogOptions[EQL3_Player].ShowQuestLevels = 0;
		EQL3_OptionsFrame_Checkbox_QuestLevelsOnlyInLog:Disable();
	end
	
	QuestLog_Update();
	QuestWatch_Update();
end

function EQL3_Toggle_RestoreUponSelect()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].RestoreUponSelect = 1;
	else
		QuestlogOptions[EQL3_Player].RestoreUponSelect = 0;
	end
end

function EQL3_Toggle_MinimizeUponClose()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].MinimizeUponClose = 1;
	else
		QuestlogOptions[EQL3_Player].MinimizeUponClose = 0;
	end
end

function EQL3_Toggle_CustomZoneColor()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].CustomZoneColor = 1;
	else
		QuestlogOptions[EQL3_Player].CustomZoneColor = 0;
	end
	QuestWatch_Update();
end

function EQL3_Toggle_CustomHeaderColor()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].CustomHeaderColor = 1;
	else
		QuestlogOptions[EQL3_Player].CustomHeaderColor = 0;
	end
	QuestWatch_Update();
end

function EQL3_Toggle_CustomObjectiveColor()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].CustomObjetiveColor = 1;
	else
		QuestlogOptions[EQL3_Player].CustomObjetiveColor = 0;
	end
	QuestWatch_Update();
end


function EQL3_Toggle_FadeHeaderColor()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].FadeHeaderColor = 1;
	else
		QuestlogOptions[EQL3_Player].FadeHeaderColor = 0;
	end
	QuestWatch_Update();
end

function EQL3_Toggle_FadeObjectiveColor()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].FadeObjectiveColor = 1;
	else
		QuestlogOptions[EQL3_Player].FadeObjectiveColor = 0;
	end
	QuestWatch_Update();
end

function EQL3_Toggle_CustomTrackerBGColor()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].CustomTrackerBGColor = 1;
	else
		QuestlogOptions[EQL3_Player].CustomTrackerBGColor = 0;
	end
	TrackerBackground_Update();
end

--new to 3.5.6

function EQL3_Toggle_ShowObjectiveMarkers()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].ShowObjectiveMarkers = 1;
		EQL3_OptionsFrame_Checkbox_UseTrackerListing:Enable();
		EQL3_Toggle_UseTrackerListing();
	else
		QuestlogOptions[EQL3_Player].ShowObjectiveMarkers = 0;
		EQL3_OptionsFrame_Checkbox_UseTrackerListing:Disable();
		EQL3_OptionsFrame_Checkbox_Symbol1:Disable();
		EQL3_OptionsFrame_Checkbox_Symbol2:Disable();
		EQL3_OptionsFrame_Checkbox_Symbol3:Disable();
		EQL3_OptionsFrame_Checkbox_Symbol4:Disable();
		EQL3_OptionsFrame_Checkbox_List1:Disable();
		EQL3_OptionsFrame_Checkbox_List2:Disable();
		EQL3_OptionsFrame_Checkbox_List3:Disable();
		EQL3_OptionsFrame_Checkbox_List4:Disable();
	end
	QuestWatch_Update();
end

-- end


function EQL3_Toggle_UseTrackerListing()
	if (EQL3_OptionsFrame_Checkbox_UseTrackerListing:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].UseTrackerListing = 1;
		EQL3_OptionsFrame_Checkbox_List1:Enable();
		EQL3_OptionsFrame_Checkbox_List2:Enable();
		EQL3_OptionsFrame_Checkbox_List3:Enable();
		EQL3_OptionsFrame_Checkbox_List4:Enable();
		
		EQL3_OptionsFrame_Checkbox_Symbol1:Disable();
		EQL3_OptionsFrame_Checkbox_Symbol2:Disable();
		EQL3_OptionsFrame_Checkbox_Symbol3:Disable();
		EQL3_OptionsFrame_Checkbox_Symbol4:Disable();
	else
		QuestlogOptions[EQL3_Player].UseTrackerListing = 0;
		EQL3_OptionsFrame_Checkbox_List1:Disable();
		EQL3_OptionsFrame_Checkbox_List2:Disable();
		EQL3_OptionsFrame_Checkbox_List3:Disable();
		EQL3_OptionsFrame_Checkbox_List4:Disable();
		
		EQL3_OptionsFrame_Checkbox_Symbol1:Enable();
		EQL3_OptionsFrame_Checkbox_Symbol2:Enable();
		EQL3_OptionsFrame_Checkbox_Symbol3:Enable();
		EQL3_OptionsFrame_Checkbox_Symbol4:Enable();
	end
	QuestWatch_Update();
end

function EQL3_Set_TrackerListing(id)
	QuestlogOptions[EQL3_Player].TrackerList = id;
	EQL3_OptionsFrame_Checkbox_List1:SetChecked(0);
	EQL3_OptionsFrame_Checkbox_List2:SetChecked(0);
	EQL3_OptionsFrame_Checkbox_List3:SetChecked(0);
	EQL3_OptionsFrame_Checkbox_List4:SetChecked(0);
	getglobal("EQL3_OptionsFrame_Checkbox_List"..(id+1)):SetChecked(1);
	QuestWatch_Update();
end

function EQL3_Set_TrackerSymbol(id)
	QuestlogOptions[EQL3_Player].TrackerSymbol = id;
	EQL3_OptionsFrame_Checkbox_Symbol1:SetChecked(0);
	EQL3_OptionsFrame_Checkbox_Symbol2:SetChecked(0);
	EQL3_OptionsFrame_Checkbox_Symbol3:SetChecked(0);
	EQL3_OptionsFrame_Checkbox_Symbol4:SetChecked(0);
	getglobal("EQL3_OptionsFrame_Checkbox_Symbol"..(id+1)):SetChecked(1);
	QuestWatch_Update();
end


function EQL3_Toggle_ShowZones()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].ShowZonesInTracker = 1;
		EQL3_OptionsFrame_Checkbox_SortTracker:Disable();
		EQL3_OptionsFrame_Checkbox_SortTracker:SetChecked(1);
	else
		QuestlogOptions[EQL3_Player].ShowZonesInTracker = 0;
		EQL3_OptionsFrame_Checkbox_SortTracker:Enable();
	end
	SortWatchedQuests();
	QuestWatch_Update();
end

function EQL3_Toggle_SortTracker()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].SortTrackerItems = 1;
	else
		QuestlogOptions[EQL3_Player].SortTrackerItems = 0;
	end
	SortWatchedQuests();
	QuestWatch_Update();
end





function EQL3_OpenColorPicker(color, useOpacity, swatch)
	local c={};
	
	c.r = QuestlogOptions[EQL3_Player].Color[color].r;
	c.g = QuestlogOptions[EQL3_Player].Color[color].g;
	c.b = QuestlogOptions[EQL3_Player].Color[color].b;
	if (useOpacity) then
		c.a = 1.0 - QuestlogOptions[EQL3_Player].Color[color].a;
	end
	if(not c.a) then
		c.a = 0.0;
	end
	EQL3_Temp.CurrentColor = color;
	EQL3_Temp.CurrentSwatch = swatch;
	ColorPickerFrame.opacity = c.a;
	ColorPickerFrame:SetColorRGB(c.r, c.g, c.b);
	ColorPickerFrame.previousValues = {r = c.r, g = c.g, b = c.b, a = c.a};
	ColorPickerFrame.hasOpacity = useOpacity;
	ColorPickerFrame.func = EQL3_SaveColorPicker;
	ColorPickerFrame.cancelFunc = EQL3_CancelColorPicker;
	ColorPickerFrame:Show();
	ColorPickerFrame:Raise();
	
end

function EQL3_SaveColorPicker()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].r = r;
	QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].g = g;
	QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].b = b;
	if (ColorPickerFrame.hasOpacity) then
		 QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].a = 1.0 - OpacitySliderFrame:GetValue();
	end
	
	getglobal(EQL3_Temp.CurrentSwatch.."NormalTexture"):SetVertexColor(r, g, b);
	
	if (not ColorPickerFrame:IsVisible()) then
		if (EQL3_Temp.CurrentColor == "TrackerBG") then
			TrackerBackground_Update();
		else
			QuestWatch_Update();
		end
		ColorPickerFrame.func = nil;
		ColorPickerFrame.cancelFunc = nil;
	end
	
end

function EQL3_CancelColorPicker(color)
	QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].r = ColorPickerFrame.previousValues.r;
	QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].g = ColorPickerFrame.previousValues.g;
	QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].b = ColorPickerFrame.previousValues.b;
	if (ColorPickerFrame.hasOpacity) then
		 QuestlogOptions[EQL3_Player].Color[EQL3_Temp.CurrentColor].a = 1.0 - ColorPickerFrame.previousValues.a;
	end
	
	getglobal(EQL3_Temp.CurrentSwatch.."NormalTexture"):SetVertexColor(ColorPickerFrame.previousValues.r, ColorPickerFrame.previousValues.g, ColorPickerFrame.previousValues.b);
	
	if (not ColorPickerFrame:IsVisible()) then
		if (EQL3_Temp.CurrentColor == "TrackerBG") then
			TrackerBackground_Update();
		else
			QuestWatch_Update();
		end
		ColorPickerFrame.func = nil;
		ColorPickerFrame.cancelFunc = nil;
	end	
end

function TrackerBackground_Update()
	if(QuestlogOptions[EQL3_Player].CustomTrackerBGColor == 1) then
	
		QuestWatchFrameBackdrop:SetBackdropBorderColor( QuestlogOptions[EQL3_Player].Color["TrackerBG"].r,
																										QuestlogOptions[EQL3_Player].Color["TrackerBG"].g,
																										QuestlogOptions[EQL3_Player].Color["TrackerBG"].b );
		QuestWatchFrameBackdrop:SetBackdropColor( QuestlogOptions[EQL3_Player].Color["TrackerBG"].r,
																										QuestlogOptions[EQL3_Player].Color["TrackerBG"].g,
																										QuestlogOptions[EQL3_Player].Color["TrackerBG"].b );																										
		QuestWatchFrameBackdrop:SetAlpha(QuestlogOptions[EQL3_Player].Color["TrackerBG"].a);
		
	else
	
		QuestWatchFrameBackdrop:SetBackdropBorderColor( TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
																										TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
																										TOOLTIP_DEFAULT_BACKGROUND_COLOR.b );
		QuestWatchFrameBackdrop:SetBackdropColor( TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
																										TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
																										TOOLTIP_DEFAULT_BACKGROUND_COLOR.b );																							
		QuestWatchFrameBackdrop:SetAlpha(0.0);
		
	end
end



function EQL3_Toggle_LockTracker()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].LockTracker = 1;
		EQL3_QuestWatchFrame:SetUserPlaced(0);
		EQL3_QuestWatchFrame:RegisterForDrag(0);
		EQL3_QuestWatchFrame:SetMovable(false);
		EQL3_QuestWatchFrame:EnableMouse(false);
	else
		QuestlogOptions[EQL3_Player].LockTracker = 0;
		EQL3_QuestWatchFrame:SetMovable(true);
		EQL3_QuestWatchFrame:EnableMouse(true);
		EQL3_QuestWatchFrame:SetUserPlaced(1);
		EQL3_QuestWatchFrame:RegisterForDrag("LeftButton");
	end
end

function EQL3_RestoreTracker()
	EQL3_QuestWatchFrame:ClearAllPoints();
	EQL3_QuestWatchFrame:SetPoint("TOPRIGHT","MinimapCluster","BOTTOMRIGHT",-100,10);
	QuestWatchFrame_LockCornerForGrowth();
end

function EQL3_RestoreColors()
	QuestlogOptions[EQL3_Player].Color["TrackerBG"] = {	r = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
																													g = TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
																													b = TOOLTIP_DEFAULT_BACKGROUND_COLOR.b,
																													a = 0.0};
																													
	QuestlogOptions[EQL3_Player].Color["Zone"] = {r = 1.0, g = 1.0, b = 1.0};
	QuestlogOptions[EQL3_Player].Color["HeaderEmpty"] = {r = 0.75, g = 0.61, b = 0.0};
	QuestlogOptions[EQL3_Player].Color["HeaderComplete"] = {r = NORMAL_FONT_COLOR.r, g = NORMAL_FONT_COLOR.g, b = NORMAL_FONT_COLOR.b};
	QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"] = {r = 0.8, g = 0.8, b = 0.8};
	QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"] = {r = HIGHLIGHT_FONT_COLOR.r, g = HIGHLIGHT_FONT_COLOR.g, b = HIGHLIGHT_FONT_COLOR.b};
	QuestlogOptions[EQL3_Player].Color["Tooltip"] = {r = 1.0, g = 0.8, b = 0.0};

	if(QuestlogOptions[EQL3_Player].Color["TrackerBG"]) then
		EQL3_OptionsFrame_ColorSwatch_TrackerBGNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["TrackerBG"].r, 
																																				 QuestlogOptions[EQL3_Player].Color["TrackerBG"].g, 
																																				 QuestlogOptions[EQL3_Player].Color["TrackerBG"].b );
	end
	
	if(QuestlogOptions[EQL3_Player].Color["Zone"]) then
		EQL3_OptionsFrame_ColorSwatch_ZoneNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["Zone"].r, 
																																				 QuestlogOptions[EQL3_Player].Color["Zone"].g, 
																																				 QuestlogOptions[EQL3_Player].Color["Zone"].b );
	end
	
	if(QuestlogOptions[EQL3_Player].Color["HeaderEmpty"]) then
		EQL3_OptionsFrame_ColorSwatch_Header_EmptyNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["HeaderEmpty"].r, 
																																				 QuestlogOptions[EQL3_Player].Color["HeaderEmpty"].g, 
																																				 QuestlogOptions[EQL3_Player].Color["HeaderEmpty"].b );
	end
	
	if(QuestlogOptions[EQL3_Player].Color["HeaderComplete"]) then
		EQL3_OptionsFrame_ColorSwatch_Header_CompleteNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["HeaderComplete"].r, 
																																				 QuestlogOptions[EQL3_Player].Color["HeaderComplete"].g, 
																																				 QuestlogOptions[EQL3_Player].Color["HeaderComplete"].b );
	end
	
	if(QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"]) then
		EQL3_OptionsFrame_ColorSwatch_Objective_EmptyNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"].r, 
																																				 QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"].g, 
																																				 QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"].b );
	end
	
	if(QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"]) then
		EQL3_OptionsFrame_ColorSwatch_Objective_CompleteNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"].r, 
																																				 QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"].g, 
																																				 QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"].b );
	end
	
	if(QuestlogOptions[EQL3_Player].Color["Tooltip"]) then
		EQL3_OptionsFrame_ColorSwatch_TooltipInfoNormalTexture:SetVertexColor( QuestlogOptions[EQL3_Player].Color["Tooltip"].r, 
																																				 QuestlogOptions[EQL3_Player].Color["Tooltip"].g, 
																																				 QuestlogOptions[EQL3_Player].Color["Tooltip"].b );
	end
	
	TrackerBackground_Update();
	QuestWatch_Update();
end



function EQL3_Toggle_AddNew()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].AddNew = 1
	else
		QuestlogOptions[EQL3_Player].AddNew = 0;
	end
end

function EQL3_Toggle_RemoveFinished()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].RemoveFinished = 1
		EQL3_OptionsFrame_Checkbox_MinimizeFinished:Disable();
	else
		QuestlogOptions[EQL3_Player].RemoveFinished = 0;
		EQL3_OptionsFrame_Checkbox_MinimizeFinished:Enable();
	end
	MagageTrackedQuests();
	QuestLog_Update();
	QuestWatch_Update();
end

function EQL3_Toggle_MinimizeFinished()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].MinimizeFinished = 1
	else
		QuestlogOptions[EQL3_Player].MinimizeFinished = 0;
	end
	QuestWatch_Update();
end

function EQL3_Toggle_AddUntracked()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].AddUntracked = 1
	else
		QuestlogOptions[EQL3_Player].AddUntracked = 0;
	end	
end




function EQL3_Toggle_LockQuestLog()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].LockQuestLog = 1;
		EQL3_QuestLogFrame:RegisterForDrag(0);
		EQL3_QuestLogFrame_Description:RegisterForDrag(0);
	else
		QuestlogOptions[EQL3_Player].LockQuestLog = 0;
		EQL3_QuestLogFrame:RegisterForDrag("LeftButton");
		EQL3_QuestLogFrame_Description:RegisterForDrag("LeftButton");
	end
end

function EQL3_RestoreQuestLog()
	EQL3_QuestLogFrame:ClearAllPoints();
	EQL3_QuestLogFrame:SetPoint("TOPLEFT", 0, -104);
	QuestLogFrame_LockCorner();
end




-- Organizer
function EQL3_SortComparison(value1, value2)
	if(value1.header == value2.header) then
		if(value1.level == value2.level) then
			return value1.title < value2.title;
		end
		return value1.level < value2.level;
	end
	return value1.header < value2.header;
end


function EQL3_UpdateDB()
	if(not EQL3_Temp.GotQuestLogUpdate) then
		return nil;
	end
	local numEntries, numQuests = old_GetNumQuestLogEntries();
	if(numEntries == EQL3_Temp.lastExistingNumEntries) then
		return 1;
	end
	if(EQL3_Temp.lastExistingNumEntries == -1 and numEntries < 1) then
		if(not EQL3_Temp.reportedNoQuests) then
			EQL3_Temp.reportedNoQuests = 1;
		end
		return nil;
	end
	if(EQL3_Temp.reportedNoQuests) then
		EQL3_Temp.reportedNoQuests = nil;
	end
	EQL3_Temp.lastExistingNumEntries = numEntries;
	local index;
	for index in QuestlogOptions[EQL3_Player].OrganizerSettings do
		QuestlogOptions[EQL3_Player].OrganizerSettings[index].cleanup = 1;
	end
	local i;
	local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete;
	local sortData = {};
	local j = 1;
	local lastHeader = "NoHeader";
	for i=1, numEntries, 1 do
		questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = old_GetQuestLogTitle(i);
		if(isHeader) then
			lastHeader = questLogTitleText;
		else
			sortData[j] = {};
			if(QuestlogOptions[EQL3_Player].OrganizerSettings[questLogTitleText]) then
				sortData[j].header = QuestlogOptions[EQL3_Player].OrganizerSettings[questLogTitleText].header;
				QuestlogOptions[EQL3_Player].OrganizerSettings[questLogTitleText].cleanup = nil;
			else
				sortData[j].header = lastHeader;
			end
			sortData[j].level = level;
			sortData[j].title = questLogTitleText;
			sortData[j].questID = i;
			j = j + 1;
		end
	end
	table.sort(sortData, EQL3_SortComparison);
	EQL3_Temp.savedNumQuests = j - 1;
	local selectedQuest = old_GetQuestLogSelection();
	EQL3_Temp.savedSelectedQuest = selectedQuest;
	EQL3_Temp.savedQuestIDMap = {};
	j = 1;
	lastHeader = nil;
	for i=1, EQL3_Temp.savedNumQuests, 1 do
		if(sortData[i].header ~= lastHeader) then
			lastHeader = sortData[i].header;
			EQL3_Temp.savedQuestIDMap[j] = {};
			EQL3_Temp.savedQuestIDMap[j].header = lastHeader;
			j = j + 1;
		end
		EQL3_Temp.savedQuestIDMap[j] = {};
		EQL3_Temp.savedQuestIDMap[j].questID = sortData[i].questID;
		if(EQL3_Temp.savedQuestIDMap[j].questID == EQL3_Temp.selectedQuest) then
			EQL3_Temp.savedSelectedQuest = j;
		end
		j = j + 1;
	end
	EQL3_Temp.savedNumEntries = j - 1;
	for index in QuestlogOptions[EQL3_Player].OrganizerSettings do
		if(QuestlogOptions[EQL3_Player].OrganizerSettings[index].cleanup) then
			QuestlogOptions[EQL3_Player].OrganizerSettings[index] = nil;
		end
	end
	return 1;
end

function EQL3_RefreshOtherQuestDisplays()
	EQL3_Temp.lastExistingNumEntries = -1;
	old_ExpandQuestHeader(0);
end



function FixGroupChangedQuest(title, headern)
	local temp, temp2, isHeader, foundQuest, header=nil;
	if(headern ~= nil) then header = headern end
	for i=1, GetNumQuestWatches(), 1 do
		temp = string.gsub(QuestlogOptions[EQL3_Player].QuestWatches[i], ".+,%d+,", "");
		if(title == temp) then
			if(header == nil) then
				-- Find the header...
				foundQuest = false;
				for j=GetNumQuestLogEntries(), 1, -1 do
					temp2, _, _, isHeader = GetQuestLogTitle(j);
					if(not foundQuest and temp2 == title) then
						foundQuest = true;
					end
					if (foundQuest and isHeader) then
						header = temp2;
						break;
					end
				end
			end
			if (header == nil) then
				SortWatchedQuests();
				return;
			end
			temp2 = string.gsub(QuestlogOptions[EQL3_Player].QuestWatches[i], ",%d+,.+", "");
			temp = header..string.gsub(QuestlogOptions[EQL3_Player].QuestWatches[i], temp2, "");
			QuestlogOptions[EQL3_Player].QuestWatches[i] = temp;
			SortWatchedQuests();
			return;
		end
	end
end

function EQL3_OrganizeFunctions(command)
		if(not EQL3_UpdateDB()) then
			return;
		end
		local questID = GetQuestLogSelection();
		if(not (questID and questID > 0)) then
			return;
		end
		if(command == "!!!resetall") then
			table.foreach (QuestlogOptions[EQL3_Player].OrganizerSettings, function (key, v)
        QuestlogOptions[EQL3_Player].OrganizerSettings[key] = nil;
				EQL3_RefreshOtherQuestDisplays();
				FixGroupChangedQuest(key, nil);
				return nil;
      end);
			QuestlogOptions[EQL3_Player].OrganizerSettings = {};
			EQL3_RefreshOtherQuestDisplays();
		else
			local title = GetQuestLogTitle(questID);
			if(not title) then
				return;
			end
			if(command == "!!!reset") then
				QuestlogOptions[EQL3_Player].OrganizerSettings[title] = nil;
				EQL3_RefreshOtherQuestDisplays();
				FixGroupChangedQuest(title, nil);
			else
				QuestlogOptions[EQL3_Player].OrganizerSettings[title] = {};
				QuestlogOptions[EQL3_Player].OrganizerSettings[title].header = command;
				EQL3_RefreshOtherQuestDisplays();
				FixGroupChangedQuest(title, command);
			end
		end
		EQL3_RefreshOtherQuestDisplays();
end


function EQL3_Toggle_Track()
	if ( EQL3_IsQuestWatched(GetQuestLogSelection()) ) then
		EQL3_RemoveQuestWatch(GetQuestLogSelection());
	else
		EQL3_AddQuestWatch(GetQuestLogSelection());
	end
	QuestLog_Update();
	QuestWatch_Update();
end


function EQL3_Organize_ShowNameWindow()
	EQL3_OrganizeFrame:Show();
	EQL3_OrganizeFrame:Raise();
	EQL3_OrganizeFrame_Text:SetFocus();
end


function EQL3_SlashCmd(msg)
	if (string.len(msg) > 0) then
		if(not EQL3_UpdateDB()) then
			return;
		end
		local questID = GetQuestLogSelection();
		if(not (questID and questID > 0)) then
			return;
		end
		if(msg == "resetall") then
			table.foreach (QuestlogOptions[EQL3_Player].OrganizerSettings, function (key, v)
        QuestlogOptions[EQL3_Player].OrganizerSettings[key] = nil;
				EQL3_RefreshOtherQuestDisplays();
				FixGroupChangedQuest(key, nil);
				return nil;
      end);
			QuestlogOptions[EQL3_Player].OrganizerSettings = {};
			EQL3_RefreshOtherQuestDisplays();
		else
			local title = GetQuestLogTitle(questID);
			if(not title) then
				return;
			end
			if(msg == "reset") then
				QuestlogOptions[EQL3_Player].OrganizerSettings[title] = nil;
				EQL3_RefreshOtherQuestDisplays();
				FixGroupChangedQuest(title, nil);
			else
				QuestlogOptions[EQL3_Player].OrganizerSettings[title] = {};
				QuestlogOptions[EQL3_Player].OrganizerSettings[title].header = msg;
				EQL3_RefreshOtherQuestDisplays();
				FixGroupChangedQuest(title, msg);
			end
		end
		EQL3_RefreshOtherQuestDisplays();
	else
		DEFAULT_CHAT_FRAME:AddMessage("Usage:");
		DEFAULT_CHAT_FRAME:AddMessage("/eql - shows this message");
		DEFAULT_CHAT_FRAME:AddMessage("/eql <header> - moves the currently selected quest to this header");
		DEFAULT_CHAT_FRAME:AddMessage("/eql reset - reset the currently selected quest to its default header");
		DEFAULT_CHAT_FRAME:AddMessage("/eql resetall - resets all quests to their default headers");
	end
end




function GetNumQuestLogEntries()
	if(not EQL3_UpdateDB()) then
		return old_GetNumQuestLogEntries();
	end
	return EQL3_Temp.savedNumEntries, EQL3_Temp.savedNumQuests;
end



function SelectQuestLogEntry(questID)
	if(not EQL3_UpdateDB()) then
		return old_SelectQuestLogEntry(questID);
	end
	if(EQL3_Temp.savedQuestIDMap and EQL3_Temp.savedQuestIDMap[questID] and EQL3_Temp.savedQuestIDMap[questID].questID) then
		EQL3_Temp.savedSelectedQuest = questID;
		return old_SelectQuestLogEntry(EQL3_Temp.savedQuestIDMap[questID].questID);
	end
end



function GetQuestLogSelection()
	if(not EQL3_UpdateDB()) then
		return old_GetQuestLogSelection();
	end
	return EQL3_Temp.savedSelectedQuest;
end




function ExpandQuestHeader(questID)
	-- DISABLED!
end

function CollapseQuestHeader(questID)
	-- DEFAULT_CHAT_FRAME:AddMessage("Collapsing quest headers will cause errors.");
	EQL3_QuestLogCollapseAllButton.collapsed = nil;
end



function IsUnitOnQuest(questID, unit)
	if(not EQL3_UpdateDB()) then
		return old_IsUnitOnQuest(questID, unit);
	end
	if(EQL3_Temp.savedQuestIDMap and EQL3_Temp.savedQuestIDMap[questID] and EQL3_Temp.savedQuestIDMap[questID].questID) then
		return old_IsUnitOnQuest(EQL3_Temp.savedQuestIDMap[questID].questID, unit);
	end
end



function IsQuestWatched(questID)
	if(not EQL3_UpdateDB()) then
		return EQL3_IsQuestWatched(questID);
	end
	if(EQL3_Temp.savedQuestIDMap and EQL3_Temp.savedQuestIDMap[questID] and EQL3_Temp.savedQuestIDMap[questID].questID) then
		return EQL3_IsQuestWatched(questID); -- EQL3_IsQuestWatched(EQL3_Temp.savedQuestIDMap[questID].questID);
	end
end

function AddQuestWatch(questID)
	if(not EQL3_UpdateDB()) then
		return EQL3_AddQuestWatch(questID);
	end
	if(EQL3_Temp.savedQuestIDMap and EQL3_Temp.savedQuestIDMap[questID] and EQL3_Temp.savedQuestIDMap[questID].questID) then
		return EQL3_AddQuestWatch(questID);-- EQL3_AddQuestWatch(EQL3_Temp.savedQuestIDMap[questID].questID);
	end
end

function RemoveQuestWatch(questID)
	if(not EQL3_UpdateDB()) then
		return EQL3_RemoveQuestWatch(questID);
	end
	if(EQL3_Temp.savedQuestIDMap and EQL3_Temp.savedQuestIDMap[questID] and EQL3_Temp.savedQuestIDMap[questID].questID) then
		return EQL3_RemoveQuestWatch(questID); -- EQL3_RemoveQuestWatch(EQL3_Temp.savedQuestIDMap[questID].questID);
	end
end


function GetQuestIndexForWatch(watchID)
	if(not EQL3_UpdateDB()) then
		return EQL3_GetQuestIndexForWatch(watchID);
	end
	
	if(EQL3_Temp.savedQuestIDMap) then
	
		local mappedQuestID = EQL3_GetQuestIndexForWatch(watchID);
		local questID;
		for questID in EQL3_Temp.savedQuestIDMap do
			if(EQL3_Temp.savedQuestIDMap[questID].questID and (EQL3_Temp.savedQuestIDMap[questID].questID == mappedQuestID)) then
				return EQL3_GetQuestIndexForWatch(watchID); -- return questID;
			end
		end
	end
end



function GetNumQuestLeaderBoards(questID)
	if(not questID or not EQL3_UpdateDB()) then
		return old_GetNumQuestLeaderBoards(questID);
	end
	if(EQL3_Temp.savedQuestIDMap and EQL3_Temp.savedQuestIDMap[questID] and EQL3_Temp.savedQuestIDMap[questID].questID) then
		return old_GetNumQuestLeaderBoards(EQL3_Temp.savedQuestIDMap[questID].questID);
	end
end

function GetQuestLogLeaderBoard(objectiveID, questID)
	if(not questID or not EQL3_UpdateDB()) then
		return old_GetQuestLogLeaderBoard(objectiveID, questID);
	end
	if(EQL3_Temp.savedQuestIDMap and EQL3_Temp.savedQuestIDMap[questID] and EQL3_Temp.savedQuestIDMap[questID].questID) then
		return old_GetQuestLogLeaderBoard(objectiveID, EQL3_Temp.savedQuestIDMap[questID].questID);
	end
end





function SetTrackerFontSize()
	local temp, t1, t2;
	
	t1, _, t2 = EQL3_QuestWatchLine1:GetFont();
	
	for i=1, MAX_QUESTWATCH_LINES, 1 do
		temp = getglobal("EQL3_QuestWatchLine"..i);
		--temp:SetTextHeight(QuestlogOptions[EQL3_Player].TrackerFontHeight);
		temp:SetFont(t1, QuestlogOptions[EQL3_Player].TrackerFontHeight, t2);
		temp:SetHeight(QuestlogOptions[EQL3_Player].TrackerFontHeight+1);
	end
	
	QuestWatch_Update();
end

function EQL3_Toggle_ShowMinimizer()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].TrackerShowMinimizer = 1;
		EQL3_Tracker_MinimizeButton:Show();
	else
		QuestlogOptions[EQL3_Player].TrackerShowMinimizer = 0;
		QuestlogOptions[EQL3_Player].TrackerIsMinimized = 0;
		EQL3_Tracker_MinimizeButton:Hide();
	end
	
	QuestWatch_Update();
end

function EQL3_Toggle_Tracker()
	if ( QuestlogOptions[EQL3_Player].TrackerIsMinimized == 1 ) then
		QuestlogOptions[EQL3_Player].TrackerIsMinimized = 0;
	else
		QuestlogOptions[EQL3_Player].TrackerIsMinimized = 1;
	end
	
	QuestWatch_Update();
end




function EQL3_ShowLoadDropDown(button)
	if ( button == "LeftButton" ) then
		ToggleDropDownMenu(1, nil, EQL3_RealmDropDown, this:GetName(), 0, 0);
		return;
	end
end


function EQL3_RealmDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, EQL3_RealmDropDown_Initialize, "MENU");
	UIDropDownMenu_SetButtonWidth(50);
	UIDropDownMenu_SetWidth(50);
end



function EQL3_RealmDropDown_Initialize()
	
	if ( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then
	
		local info = {};
		local realms = {};
		
		-- Loop through Realms and add to menu
		for i in QuestlogOptions do
			for w in string.gfind(i, "%-([^%-]+)") do
					if ( not realms[w] ) then
					
						-- Make sure every realm is only shown once
						realms[w] = 1;
						-- Realms List
						info = {};
						info.text = w;
						info.hasArrow = 1;
						info.func = nil;
						info.notCheckable = 1;
						UIDropDownMenu_AddButton(info);

					break;
				end
			end
		end

	elseif ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then

		info = {};
		info.text = UIDROPDOWNMENU_MENU_VALUE;
		info.notClickable = 1;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		for i in QuestlogOptions do
			for x, w in string.gfind(i, "([^%-]+)%-([^%-]+)") do
				if(w == UIDROPDOWNMENU_MENU_VALUE) then
					info = {};
					info.text = x;
					info.value = i;
					info.func = EQL3_LoadCharacterSettings;
					info.notCheckable = 1;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
		
	end
end

function EQL3_LoadCharacterSettings()
	-- toggle the menu.. in this case hide it
	ToggleDropDownMenu(1, nil, EQL3_RealmDropDown, EQL3_OptionsFrameLoadButton:GetName(), 0, 0);
	
	--load the settings...
		QuestlogOptions[EQL3_Player].ShowQuestLevels = QuestlogOptions[this.value].ShowQuestLevels;
		
		QuestlogOptions[EQL3_Player].RestoreUponSelect = QuestlogOptions[this.value].RestoreUponSelect;
		
		QuestlogOptions[EQL3_Player].MinimizeUponClose = QuestlogOptions[this.value].MinimizeUponClose;
		
		QuestlogOptions[EQL3_Player].LockQuestLog = QuestlogOptions[this.value].LockQuestLog;


		if(QuestlogOptions[EQL3_Player].LockQuestLog == 1) then
			EQL3_QuestLogFrame:RegisterForDrag(0);
			EQL3_QuestLogFrame_Description:RegisterForDrag(0);
		else
			EQL3_QuestLogFrame:RegisterForDrag("LeftButton");
			EQL3_QuestLogFrame_Description:RegisterForDrag("LeftButton");
		end
		
		
		QuestlogOptions[EQL3_Player].LogLockPoints = QuestlogOptions[this.value].LogLockPoints;
			
			
		if (QuestlogOptions[EQL3_Player].LogLockPoints and
							QuestlogOptions[EQL3_Player].LogLockPoints.pointone and
							QuestlogOptions[EQL3_Player].LogLockPoints.pointtwo) then
			EQL3_QuestLogFrame:ClearAllPoints();
			EQL3_QuestLogFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",QuestlogOptions[EQL3_Player].LogLockPoints.pointone,QuestlogOptions[EQL3_Player].LogLockPoints.pointtwo);
		end
		
		
		QuestlogOptions[EQL3_Player].MinimizeUponClose = QuestlogOptions[this.value].MinimizeUponClose;
		
		QuestlogOptions[EQL3_Player].LogOpacity = QuestlogOptions[this.value].LogOpacity;
		EQL3_QuestLogFrame:SetAlpha(QuestlogOptions[EQL3_Player].LogOpacity);
		EQL3_OptionsFrame_Slider_LogOpacity:SetValue(QuestlogOptions[EQL3_Player].LogOpacity);
		
		QuestlogOptions[EQL3_Player].ShowZonesInTracker = QuestlogOptions[this.value].ShowZonesInTracker;
		
		QuestlogOptions[EQL3_Player].SortTrackerItems = QuestlogOptions[this.value].SortTrackerItems;
		
		QuestlogOptions[EQL3_Player].CustomZoneColor = QuestlogOptions[this.value].CustomZoneColor;
		
		QuestlogOptions[EQL3_Player].CustomHeaderColor = QuestlogOptions[this.value].CustomHeaderColor;
		
		QuestlogOptions[EQL3_Player].CustomObjetiveColor = QuestlogOptions[this.value].CustomObjetiveColor;
		
		QuestlogOptions[EQL3_Player].FadeHeaderColor = QuestlogOptions[this.value].FadeHeaderColor;
		
		QuestlogOptions[EQL3_Player].FadeObjectiveColor = QuestlogOptions[this.value].FadeObjectiveColor;
		
		QuestlogOptions[EQL3_Player].CustomTrackerBGColor = QuestlogOptions[this.value].CustomTrackerBGColor;
		
		QuestlogOptions[EQL3_Player].UseTrackerListing = QuestlogOptions[this.value].UseTrackerListing;
		
		QuestlogOptions[EQL3_Player].TrackerList = QuestlogOptions[this.value].TrackerList;
		
		QuestlogOptions[EQL3_Player].TrackerSymbol = QuestlogOptions[this.value].TrackerSymbol;
		
		QuestlogOptions[EQL3_Player].Color["TrackerBG"] = {r=QuestlogOptions[this.value].Color["TrackerBG"].r, 
																											 g=QuestlogOptions[this.value].Color["TrackerBG"].g,
																											 b=QuestlogOptions[this.value].Color["TrackerBG"].b,
																											 a=QuestlogOptions[this.value].Color["TrackerBG"].a};
																											 
																											 
		QuestlogOptions[EQL3_Player].Color["Zone"] = {r=QuestlogOptions[this.value].Color["Zone"].r, 
																								  g=QuestlogOptions[this.value].Color["Zone"].g,
																								  b=QuestlogOptions[this.value].Color["Zone"].b};
																											 
		QuestlogOptions[EQL3_Player].Color["HeaderEmpty"] = {r=QuestlogOptions[this.value].Color["HeaderEmpty"].r, 
																										 		 g=QuestlogOptions[this.value].Color["HeaderEmpty"].g,
																											 	 b=QuestlogOptions[this.value].Color["HeaderEmpty"].b};
																											 
		QuestlogOptions[EQL3_Player].Color["HeaderComplete"] = {r=QuestlogOptions[this.value].Color["HeaderComplete"].r, 
																														g=QuestlogOptions[this.value].Color["HeaderComplete"].g,
																														b=QuestlogOptions[this.value].Color["HeaderComplete"].b};
																											 
		QuestlogOptions[EQL3_Player].Color["ObjectiveEmpty"] = {r=QuestlogOptions[this.value].Color["ObjectiveEmpty"].r, 
																														g=QuestlogOptions[this.value].Color["ObjectiveEmpty"].g,
																														b=QuestlogOptions[this.value].Color["ObjectiveEmpty"].b};
																											 
		QuestlogOptions[EQL3_Player].Color["ObjectiveComplete"] = {r=QuestlogOptions[this.value].Color["ObjectiveComplete"].r, 
																															 g=QuestlogOptions[this.value].Color["ObjectiveComplete"].g,
																															 b=QuestlogOptions[this.value].Color["ObjectiveComplete"].b};
																											 
		QuestlogOptions[EQL3_Player].Color["Tooltip"] = {r=QuestlogOptions[this.value].Color["Tooltip"].r, 
																										 g=QuestlogOptions[this.value].Color["Tooltip"].g,
																										 b=QuestlogOptions[this.value].Color["Tooltip"].b};


		QuestlogOptions[EQL3_Player].LockTracker = QuestlogOptions[this.value].LockTracker;
		
		QuestlogOptions[EQL3_Player].LockPoints = QuestlogOptions[this.value].LockPoints;
		
		QuestlogOptions[EQL3_Player].AddNew = QuestlogOptions[this.value].AddNew;
		
		QuestlogOptions[EQL3_Player].RemoveFinished = QuestlogOptions[this.value].RemoveFinished;
		
		QuestlogOptions[EQL3_Player].MinimizeFinished = QuestlogOptions[this.value].MinimizeFinished;
		
		QuestlogOptions[EQL3_Player].AddUntracked = QuestlogOptions[this.value].AddUntracked;
		
		QuestlogOptions[EQL3_Player].TrackerFontHeight = QuestlogOptions[this.value].TrackerFontHeight;
		
		EQL3_OptionsFrame_Slider_TrackerFontSize:SetValue(QuestlogOptions[EQL3_Player].TrackerFontHeight);
		
		QuestlogOptions[EQL3_Player].TrackerShowMinimizer = QuestlogOptions[this.value].TrackerShowMinimizer;
		
		QuestlogOptions[EQL3_Player].TrackerIsMinimized = QuestlogOptions[this.value].TrackerIsMinimized;
		
		-- new to 3.5.6
		
		QuestlogOptions[EQL3_Player].AutoCompleteQuests = QuestlogOptions[this.value].AutoCompleteQuests;
			
		QuestlogOptions[EQL3_Player].RemoveCompletedObjectives = QuestlogOptions[this.value].RemoveCompletedObjectives;
		
		QuestlogOptions[EQL3_Player].ShowObjectiveMarkers = QuestlogOptions[this.value].ShowObjectiveMarkers;
		
		QuestlogOptions[EQL3_Player].OnlyLevelsInLog = QuestlogOptions[this.value].OnlyLevelsInLog;
		
		-- new to 3.5.9
		
		QuestlogOptions[EQL3_Player].ItemTooltip = QuestlogOptions[this.value].ItemTooltip;
			
		QuestlogOptions[EQL3_Player].MobTooltip = QuestlogOptions[this.value].MobTooltip;
		
		QuestlogOptions[EQL3_Player].InfoOnQuestCompletion = QuestlogOptions[this.value].InfoOnQuestCompletion;
		
		QuestlogOptions[EQL3_Player].CustomTooltipColor = QuestlogOptions[this.value].CustomTooltipColor;
		
	
	EQL_Options_SetStates();
	
	QuestLog_Update();
	QuestWatch_Update();
end

-- new to 3.5.6
function EQL3_Toggle_AutoCompleteQuests()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].AutoCompleteQuests = 1;
	else
		QuestlogOptions[EQL3_Player].AutoCompleteQuests = 0;
	end
end

function EQL3_Toggle_OnlyLevelsInLog()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].OnlyLevelsInLog = 1;
	else
		QuestlogOptions[EQL3_Player].OnlyLevelsInLog = 0;
	end
end

function EQL3_Toggle_HideCompletedObjectives()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].RemoveCompletedObjectives = 1;
	else
		QuestlogOptions[EQL3_Player].RemoveCompletedObjectives = 0;
	end
	QuestWatch_Update();
end


-- new to3.5.9

function EQL3_Toggle_ShowItemTooltip()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].ItemTooltip = 1;
	else
		QuestlogOptions[EQL3_Player].ItemTooltip = 0;
	end
end


function EQL3_Toggle_ShowMobTooltip()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].MobTooltip = 1;
	else
		QuestlogOptions[EQL3_Player].MobTooltip = 0;
	end
end

function EQL3_Toggle_InfoOnQuestComplete()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].InfoOnQuestCompletion = 1;
		LookForCompletedQuests(false)
	else
		QuestlogOptions[EQL3_Player].InfoOnQuestCompletion = 0;
	end
end

function EQL3_Toggle_CustomTooltipInfoColor()
	if (this:GetChecked() == 1) then
		QuestlogOptions[EQL3_Player].CustomTooltipColor = 1;
	else
		QuestlogOptions[EQL3_Player].CustomTooltipColor = 0;
	end
end




-- end




--;
--
--
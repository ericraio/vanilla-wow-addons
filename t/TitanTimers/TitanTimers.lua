TITAN_TIMERS_ID = "Timers";
TITAN_TIMERS_FREQUENCY = 1;

function TitanPanelTimersButton_OnLoad()
	this.registry = { 
		id = TITAN_TIMERS_ID,
		menuText = "Advanced Timers", 
		buttonTextFunction = "TitanPanelTimersButton_GetButtonText", 
		tooltipTitle = "Advanced Timers",
		tooltipTextFunction = "TitanPanelTimersButton_GetTooltipText", 
		frequency = TITAN_TIMERS_FREQUENCY,
		updateType = TITAN_PANEL_UPDATE_ALL,
    savedVariables = {
      ShowLabelText = 0,
      HideName = 1
    } 
	};
end

function TitanPanelTimersButton_OnUpdate()
  if (TitanPanelButton_UpdateButton ~= nil) then
    TitanPanelButton_UpdateButton(TITAN_TIMERS_ID);
  end
  if GameTooltip:IsVisible() and GameTooltip:IsOwned(TitanUtils_GetButton(TITAN_TIMERS_ID)) then
  	TitanPanelButton_SetTooltip(TITAN_TIMERS_ID);
  end
end

function TitanPanelTimersButton_OnClick()
	if not TimersMainFrame:IsVisible() then
		Timers_ShowMainPanel();
	end
end

function TitanPanelTimersButton_GetButtonText(id)
	local time = TimersString_Replace_tNext();
	if time == 0 then
		if table.getn(timerdata) == 0 then
			return TIMERS_LOC_NO_TIMERS;
		else
			local time = timerdata[1].time;
			for i=2, table.getn(timerdata) do
				if timerdata[i].time > time then
					time = timerdata[i].time;
				end
			end
			return TitanUtils_GetRedText(Timers_TimeToText(time-Timers_GetLocalTime()));
		end
	else
		if not (TitanGetVar(TITAN_TIMERS_ID, "HideName")) then
			time = TimersString_Replace_nNext()..": "..time;
		end
		return time;
	end	
end

function TitanPanelTimersButton_GetTooltipText()
	local ToolTip = "\n";
	if table.getn(timerdata) == 0 then
		ToolTip = ToolTip..TIMERS_LOC_NO_TIMERS;
	else
		local clonedTable = Timers_cloneTable(timerdata);
		table.sort(clonedTable,TitanPanelTimers_CompareTime);
		for i=1 , table.getn(clonedTable) do
			ToolTip = ToolTip..clonedTable[i].name.."\t";
			if clonedTable[i].time-Timers_GetLocalTime() < 0 then
				ToolTip = ToolTip..TitanUtils_GetRedText(Timers_TimeToText(clonedTable[i].time-Timers_GetLocalTime()).."\n");
			else
				ToolTip = ToolTip..TitanUtils_GetHighlightText(Timers_TimeToText(clonedTable[i].time-Timers_GetLocalTime()).."\n");			
			end
		end
	end
	return ToolTip;
end

function TitanPanelTimers_CompareTime(item1, item2)
	return tonumber(item1.time) < tonumber(item2.time);
end

function TitanPanelRightClickMenu_PrepareTimersMenu()
  TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_TIMERS_ID].menuText);	
  TitanPanelRightClickMenu_AddCommand(TIMERS_LOC_DELETEXPIRED, TITAN_TIMERS_ID, "TimersEdit_DeleteExpired");	
  TitanPanelRightClickMenu_AddCommand(TIMERS_LOC_DELETALL, TITAN_TIMERS_ID, "TimersEdit_DeleteAllTimer");	
	TitanPanelRightClickMenu_AddSpacer();
  TitanPanelRightClickMenu_AddToggleVar(TIMERS_TITAN_HIDE_NAME, TITAN_TIMERS_ID, "HideName");
	TitanPanelRightClickMenu_AddSpacer();
  TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_TIMERS_ID, TITAN_PANEL_MENU_FUNC_HIDE);	
end
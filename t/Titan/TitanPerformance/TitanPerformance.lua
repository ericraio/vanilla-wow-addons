TITAN_PERFORMANCE_ID = "Performance";
TITAN_PERFORMANCE_FREQUENCY = 1;

TITAN_FPS_THRESHOLD_TABLE = {
	Values = { 20, 30 },
	Colors = { RED_FONT_COLOR, NORMAL_FONT_COLOR, GREEN_FONT_COLOR },
}
TITAN_LATENCY_THRESHOLD_TABLE = {
	Values = { PERFORMANCEBAR_LOW_LATENCY, PERFORMANCEBAR_MEDIUM_LATENCY },
	Colors = { GREEN_FONT_COLOR, NORMAL_FONT_COLOR, RED_FONT_COLOR },
}
TITAN_MEMORY_RATE_THRESHOLD_TABLE = {
	Values = { 1, 2 },
	Colors = { GREEN_FONT_COLOR, NORMAL_FONT_COLOR, RED_FONT_COLOR },
}
TITAN_MEMORY_TIMETOGC_THRESHOLD_TABLE = {
	Values = { 60, 300 },
	Colors = { RED_FONT_COLOR, NORMAL_FONT_COLOR, GREEN_FONT_COLOR },
}
TITAN_MEMORY_MENU_TOGGLE_TABLE = {
	"ShowFPS", "ShowLatency", "ShowMemory",
}

function TitanPanelPerformanceButton_OnLoad()
	this.registry = {
		id = TITAN_PERFORMANCE_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_PERFORMANCE_MENU_TEXT, 
		buttonTextFunction = "TitanPanelPerformanceButton_GetButtonText";
		tooltipCustomFunction = TitanPanelPerformanceButton_SetTooltip;
		icon = TITAN_ARTWORK_PATH.."TitanPerformance",	
		iconWidth = 16,
		frequency = TITAN_PERFORMANCE_FREQUENCY, 
		savedVariables = {
			ShowFPS = 1,
			ShowLatency = 1,
			ShowMemory = 1,
			ShowIcon = 1,
			ShowLabelText = TITAN_NIL,
			ShowColoredText = 1,
		}
	};

	this.fpsSampleCount = 0;
end

function TitanPanelPerformanceButton_GetButtonText(id)	
	local button = TitanPanelPerformanceButton;
	local color, fpsRichText, latencyRichText, memoryRichText;
	local showFPS = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowFPS");
	local showLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowLatency");
	local showMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowMemory");

	-- Update real time data
	TitanPanelPerformanceButton_UpdateData()
	
	-- FPS text
	if ( showFPS ) then
		local fpsText = format(TITAN_FPS_FORMAT, button.fps);
		if ( TitanGetVar(TITAN_PERFORMANCE_ID, "ShowColoredText") ) then	
			color = TitanUtils_GetThresholdColor(TITAN_FPS_THRESHOLD_TABLE, button.fps);
			fpsRichText = TitanUtils_GetColoredText(fpsText, color);
		else
			fpsRichText = TitanUtils_GetHighlightText(fpsText);
		end
	end

	-- Latency text
	if ( showLatency ) then
		local latencyText = format(TITAN_LATENCY_FORMAT, button.latency);	
		if ( TitanGetVar(TITAN_PERFORMANCE_ID, "ShowColoredText") ) then	
			color = TitanUtils_GetThresholdColor(TITAN_LATENCY_THRESHOLD_TABLE, button.latency);
			latencyRichText = TitanUtils_GetColoredText(latencyText, color);
		else
			latencyRichText = TitanUtils_GetHighlightText(latencyText);
		end
	end

	-- Memory text
	if ( showMemory ) then
		local memoryText = format(TITAN_MEMORY_FORMAT, button.memory/1024);
		memoryRichText = TitanUtils_GetHighlightText(memoryText);
	end
	
	if ( showFPS ) then
		if ( showLatency ) then
			if ( showMemory ) then
				return TITAN_FPS_BUTTON_LABEL, fpsRichText, TITAN_LATENCY_BUTTON_LABEL, latencyRichText, TITAN_MEMORY_BUTTON_LABEL, memoryRichText;
			else
				return TITAN_FPS_BUTTON_LABEL, fpsRichText, TITAN_LATENCY_BUTTON_LABEL, latencyRichText;
			end
		else
			if ( showMemory ) then
				return TITAN_FPS_BUTTON_LABEL, fpsRichText, TITAN_MEMORY_BUTTON_LABEL, memoryRichText;
			else
				return TITAN_FPS_BUTTON_LABEL, fpsRichText;
			end
		end
	else
		if ( showLatency ) then
			if ( showMemory ) then
				return TITAN_LATENCY_BUTTON_LABEL, latencyRichText, TITAN_MEMORY_BUTTON_LABEL, memoryRichText;
			else
				return TITAN_LATENCY_BUTTON_LABEL, latencyRichText;
			end
		else
			if ( showMemory ) then
				return TITAN_MEMORY_BUTTON_LABEL, memoryRichText;
			else
				return;
			end
		end
	end
end

function TitanPanelPerformanceButton_SetTooltip()
	local showFPS = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowFPS");
	local showLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowLatency");
	local showMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowMemory");

	-- Tooltip title
	GameTooltip:SetText(TITAN_PERFORMANCE_TOOLTIP, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

	-- FPS tooltip
	if ( showFPS ) then
		local fpsText = format(TITAN_FPS_FORMAT, this.fps);
		local avgFPSText = format(TITAN_FPS_FORMAT, this.avgFPS);
		local minFPSText = format(TITAN_FPS_FORMAT, this.minFPS);
		local maxFPSText = format(TITAN_FPS_FORMAT, this.maxFPS);	
		
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(TitanUtils_GetHighlightText(TITAN_FPS_TOOLTIP));
		GameTooltip:AddDoubleLine(TITAN_FPS_TOOLTIP_CURRENT_FPS, TitanUtils_GetHighlightText(fpsText));
		GameTooltip:AddDoubleLine(TITAN_FPS_TOOLTIP_AVG_FPS, TitanUtils_GetHighlightText(avgFPSText));
		GameTooltip:AddDoubleLine(TITAN_FPS_TOOLTIP_MIN_FPS, TitanUtils_GetHighlightText(minFPSText));
		GameTooltip:AddDoubleLine(TITAN_FPS_TOOLTIP_MAX_FPS, TitanUtils_GetHighlightText(maxFPSText));
	end

	-- Latency tooltip
	if ( showLatency ) then
		local latencyText = format(TITAN_LATENCY_FORMAT, this.latency);
		local bandwidthInText = format(TITAN_LATENCY_BANDWIDTH_FORMAT, this.bandwidthIn);
		local bandwidthOutText = format(TITAN_LATENCY_BANDWIDTH_FORMAT, this.bandwidthOut);
		
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(TitanUtils_GetHighlightText(TITAN_LATENCY_TOOLTIP));
		GameTooltip:AddDoubleLine(TITAN_LATENCY_TOOLTIP_LATENCY, TitanUtils_GetHighlightText(latencyText));
		GameTooltip:AddDoubleLine(TITAN_LATENCY_TOOLTIP_BANDWIDTH_IN, TitanUtils_GetHighlightText(bandwidthInText));
		GameTooltip:AddDoubleLine(TITAN_LATENCY_TOOLTIP_BANDWIDTH_OUT, TitanUtils_GetHighlightText(bandwidthOutText));
	end

	-- Memory tooltip
	if ( showMemory ) then
		local memoryText = format(TITAN_MEMORY_FORMAT, this.memory/1024);
		local initialMemoryText = format(TITAN_MEMORY_FORMAT, this.initialMemory/1024);
		local gcThresholdText = format(TITAN_MEMORY_FORMAT, this.gcThreshold/1024);
		local sessionTime = TitanUtils_GetSessionTime() - this.startSessionTime;		
		local rateRichText, timeToGCRichText, rate, timeToGC, color;	
		if ( sessionTime == 0 ) then
			rateRichText = TitanUtils_GetHighlightText("N/A");
		else
			rate = (this.memory - this.initialMemory) / sessionTime;
			color = TitanUtils_GetThresholdColor(TITAN_MEMORY_RATE_THRESHOLD_TABLE, rate);
			rateRichText = TitanUtils_GetColoredText(format(TITAN_MEMORY_RATE_FORMAT, rate), color);
		end	
		if ( this.memory == this.initialMemory ) then
			timeToGCRichText = TitanUtils_GetHighlightText("N/A");
		else
			timeToGC = (this.gcThreshold - this.memory) / (this.memory - this.initialMemory) * sessionTime;
			color = TitanUtils_GetThresholdColor(TITAN_MEMORY_TIMETOGC_THRESHOLD_TABLE, timeToGC);
			timeToGCRichText = TitanUtils_GetColoredText(TitanUtils_GetAbbrTimeText(timeToGC), color);
		end	
	
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(TitanUtils_GetHighlightText(TITAN_MEMORY_TOOLTIP));
		GameTooltip:AddDoubleLine(TITAN_MEMORY_TOOLTIP_CURRENT_MEMORY, TitanUtils_GetHighlightText(memoryText));
		GameTooltip:AddDoubleLine(TITAN_MEMORY_TOOLTIP_INITIAL_MEMORY, TitanUtils_GetHighlightText(initialMemoryText));
		GameTooltip:AddDoubleLine(TITAN_MEMORY_TOOLTIP_INCREASING_RATE, rateRichText);
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(TitanUtils_GetHighlightText(TITAN_MEMORY_TOOLTIP_GC_INFO));
		GameTooltip:AddDoubleLine(TITAN_MEMORY_TOOLTIP_GC_THRESHOLD, TitanUtils_GetHighlightText(gcThresholdText));
		GameTooltip:AddDoubleLine(TITAN_MEMORY_TOOLTIP_TIME_TO_GC, timeToGCRichText);
	end
end

function TitanPanelRightClickMenu_PreparePerformanceMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_PERFORMANCE_ID].menuText);
	TitanPanelRightClickMenu_AddToggleVar(TITAN_PERFORMANCE_MENU_SHOW_FPS, TITAN_PERFORMANCE_ID, "ShowFPS");
	TitanPanelRightClickMenu_AddToggleVar(TITAN_PERFORMANCE_MENU_SHOW_LATENCY, TITAN_PERFORMANCE_ID, "ShowLatency");
	TitanPanelRightClickMenu_AddToggleVar(TITAN_PERFORMANCE_MENU_SHOW_MEMORY, TITAN_PERFORMANCE_ID, "ShowMemory");

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_PERFORMANCE_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_PERFORMANCE_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_PERFORMANCE_ID);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_PERFORMANCE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelPerformanceButton_UpdateData()
	local button = TitanPanelPerformanceButton;
	local showFPS = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowFPS");
	local showLatency = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowLatency");
	local showMemory = TitanGetVar(TITAN_PERFORMANCE_ID, "ShowMemory");

	-- FPS Data
	if ( showFPS ) then
		button.fps = GetFramerate();	
		button.fpsSampleCount = button.fpsSampleCount + 1;
		if (button.fpsSampleCount == 1) then
			button.minFPS = button.fps;
			button.maxFPS = button.fps;
			button.avgFPS = button.fps;
		else
			if (button.fps < button.minFPS) then
				button.minFPS = button.fps;
			elseif (button.fps > button.maxFPS) then
				button.maxFPS = button.fps;
			end
			button.avgFPS = (button.avgFPS * (button.fpsSampleCount - 1) + button.fps) / button.fpsSampleCount;
		end
	end

	-- Latency Data
	if ( showLatency ) then
		button.bandwidthIn, button.bandwidthOut, button.latency = GetNetStats();
	end

	-- Memory data
	if ( showMemory ) then
		local previousMemory = button.memory;	
		button.memory, button.gcThreshold = gcinfo();		
		if ( not button.startSessionTime ) then
			-- Initial data
			button.startSessionTime = TitanUtils_GetSessionTime();	
			button.initialMemory = button.memory;
		elseif (previousMemory and button.memory and previousMemory > button.memory) then
			-- Reset data after garbage collection
			button.startSessionTime = TitanUtils_GetSessionTime();
			button.initialMemory = button.memory;
		end
	end
end

function TitanPanelPerformanceButton_ResetMemory()
	local button = TitanPanelPerformanceButton;
	button.memory, button.gcThreshold = gcinfo();	
	button.initialMemory = button.memory;
	button.startSessionTime = TitanUtils_GetSessionTime();
end

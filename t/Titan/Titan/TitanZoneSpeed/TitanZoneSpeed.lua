TITAN_ZONE_SPEED_ID = "ZoneSpeed";
TITAN_ZONE_SPEED_FREQUENCY = 1;

local ZoneSpeed_LastZone = nil;

function TitanPanelZoneSpeedButton_OnLoad()
	this.registry = {
		id = TITAN_ZONE_SPEED_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_ZONE_SPEED_MENU_TEXT,
		buttonTextFunction = "TitanPanelZoneSpeedButton_GetButtonText", 
		tooltipTitle = TITAN_ZONE_SPEED_MENU_TEXT,
		tooltipTextFunction = "TitanPanelZoneSpeedButton_GetTooltipText", 
		frequency = TITAN_ZONE_SPEED_FREQUENCY,
		icon = TITAN_ARTWORK_PATH.."TitanThrown",	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
			ShowLastZone = 1,
			LastZone = 0
		}
	};	

	this:RegisterEvent("VARIABLES_LOADED");
end

function TitanPanelZoneSpeedButton_GetButtonText(id)
	local retstr = "";

	if (TitanGetVar(TITAN_ZONE_SPEED_ID, "ShowLabelText")) then	
		retstr = TITAN_ZONE_SPEED_MENU_TEXT;
		if TitanGetVar(TITAN_ZONE_SPEED_ID, "ShowLastZone") then
			retstr = retstr .. ": ";
		end
	end

	if TitanGetVar(TITAN_ZONE_SPEED_ID,"LastZone") == nil then
		TitanSetVar(TITAN_ZONE_SPEED_ID,"LastZone", "<none>")
	end
	if (TitanGetVar(TITAN_ZONE_SPEED_ID, "ShowColoredText")) then	
		retstr = retstr .. TitanUtils_GetGreenText(TitanGetVar(TITAN_ZONE_SPEED_ID,"LastZone"));
	else
		retstr = retstr .. TitanUtils_GetNormalText(TitanGetVar(TITAN_ZONE_SPEED_ID,"LastZone"));
	end

	return retstr
end

function TitanPanelZoneSpeedButton_GetTooltipText()
	local retstr = "";
	retstr = retstr .. TitanUtils_GetGreenText(TITAN_ZONE_SPEED_LASTZONE .. ": " .. TitanGetVar(TITAN_ZONE_SPEED_ID,"LastZone"));
	return retstr;
end

function TitanPanelRightClickMenu_PrepareZoneSpeedMenu()
	TitanPanelRightClickMenu_AddTitle(TITAN_ZONE_SPEED_MENU_TEXT);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_ZONE_SPEED_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ZONE_SPEED_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_ZONE_SPEED_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_ZONE_SPEED_ID);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ZONE_SPEED_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelZoneSpeedButton_OnEvent()
	if(event == "VARIABLES_LOADED") then
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
		this:RegisterEvent("PLAYER_LEAVING_WORLD");
	end
	if(event == "PLAYER_ENTERING_WORLD") then
		if(not ZoneSpeed_LastZone) then
			return; 
		end

		local ZoneTime = string.format("%.2f", GetTime() - ZoneSpeed_LastZone) .. "s"
		TitanSetVar(TITAN_ZONE_SPEED_ID, "LastZone", ZoneTime);
		TitanPanelZoneSpeed_RestoreAllEvents();
	end
	if(event == "PLAYER_LEAVING_WORLD") then
		ZoneSpeed_LastZone = GetTime();
		TitanPanelZoneSpeed_TurnOffUnwantedEvents();
	end
end

function TitanPanelZoneSpeed_TurnOffUnwantedEvents()
	local f = EnumerateFrames();
	local OnEvent;
	while f do
		OnEvent = f:GetScript("OnEvent");
		if(OnEvent) then
			f.ZoneSpeed_OnEvent = OnEvent;
			f:SetScript("OnEvent", function()
					if(event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGOUT" or event == "PLAYER_TARGET_CHANGED" or string.sub(event,0,4) == "CHAT") then
						this.ZoneSpeed_OnEvent();
					end
				end
			);
		end
		f = EnumerateFrames(f);
	end	
end

function TitanPanelZoneSpeed_RestoreAllEvents()
	local f = EnumerateFrames();
	while f do
		if(f.ZoneSpeed_OnEvent) then
			f:SetScript("OnEvent",f.ZoneSpeed_OnEvent);
			f.ZoneSpeed_OnEvent = nil;
		end
		f = EnumerateFrames(f);
	end
end


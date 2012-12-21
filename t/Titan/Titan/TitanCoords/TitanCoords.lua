TITAN_COORDS_ID = "Coords";
TITAN_COORDS_FREQUENCY = 0.5;

function TitanPanelCoordsButton_OnLoad()
	this.registry = { 
		id = TITAN_COORDS_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_COORDS_MENU_TEXT, 
		buttonTextFunction = "TitanPanelCoordsButton_GetButtonText",
		tooltipTitle = TITAN_COORDS_TOOLTIP, 
		tooltipTextFunction = "TitanPanelCoordsButton_GetTooltipText", 
		frequency = TITAN_COORDS_FREQUENCY, 
		updateType = TITAN_PANEL_UPDATE_BUTTON;
		icon = TITAN_ARTWORK_PATH.."TitanCoords",	
		iconWidth = 16,
		savedVariables = {
			ShowZoneText = 1,
			ShowCoordsOnMap = 1,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
		}
	};

	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_INDOORS");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("MINIMAP_ZONE_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end 

function TitanPanelCoordsButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);

	button.px, button.py = GetPlayerMapPosition("player");
	local locationText = format(TITAN_COORDS_FORMAT, 100 * button.px, 100 * button.py);
	if (TitanGetVar(TITAN_COORDS_ID, "ShowZoneText")) then	
		if (TitanUtils_ToString(button.subZoneText) == '') then
			locationText = TitanUtils_ToString(button.zoneText)..' '..locationText;
		else
			locationText = TitanUtils_ToString(button.subZoneText)..' '..locationText;
		end
	end

	local locationRichText;
	if (TitanGetVar(TITAN_COORDS_ID, "ShowColoredText")) then	
		if (this.isArena) then
			locationRichText = TitanUtils_GetRedText(locationText);		
		elseif (this.pvpType == "friendly") then
			locationRichText = TitanUtils_GetGreenText(locationText);
		elseif (this.pvpType == "hostile") then
			locationRichText = TitanUtils_GetRedText(locationText);
		elseif (this.pvpType == "contested") then
			locationRichText = TitanUtils_GetNormalText(locationText);
		else
			locationRichText = TitanUtils_GetNormalText(locationText);
		end
	else
		locationRichText = TitanUtils_GetHighlightText(locationText);
	end

	return TITAN_COORDS_BUTTON_LABEL, locationRichText;
end

function TitanPanelCoordsButton_GetTooltipText()
	local pvpInfoRichText;

	if (this.pvpType == "friendly") then
		pvpInfoRichText = TitanUtils_GetGreenText(format(FACTION_CONTROLLED_TERRITORY, this.factionName));
	elseif (this.pvpType == "hostile") then
		pvpInfoRichText = TitanUtils_GetRedText(format(FACTION_CONTROLLED_TERRITORY, this.factionName));
	elseif (this.pvpType == "contested") then
		pvpInfoRichText = TitanUtils_GetNormalText(CONTESTED_TERRITORY);
	else
		pvpInfoRichText = "";
	end
	
	--[[
	local pvpArenaText;
	if (isArena) then
		pvpArenaText = FREE_FOR_ALL_TERRITORY;
		this.subZoneText = TitanUtils_GetRedText(this.subZoneText);
	else
		pvpArenaText = "";
	end
	]]--

	return ""..
		TITAN_COORDS_TOOLTIP_ZONE.."\t"..TitanUtils_GetHighlightText(this.zoneText).."\n"..
		TitanUtils_Ternary((this.subZoneText == ""), "", TITAN_COORDS_TOOLTIP_SUBZONE.."\t"..TitanUtils_GetHighlightText(this.subZoneText).."\n")..		
		TitanUtils_Ternary((pvpInfoRichText == ""), "", TITAN_COORDS_TOOLTIP_PVPINFO.."\t"..pvpInfoRichText.."\n")..
		"\n"..
		TitanUtils_GetHighlightText(TITAN_COORDS_TOOLTIP_HOMELOCATION).."\n"..
		TITAN_COORDS_TOOLTIP_INN.."\t"..TitanUtils_GetHighlightText(GetBindLocation()).."\n"..
		TitanUtils_GetGreenText(TITAN_COORDS_TOOLTIP_HINTS_1).."\n"..
		TitanUtils_GetGreenText(TITAN_COORDS_TOOLTIP_HINTS_2);
end

function TitanPanelCoordsButton_OnEvent()
	if (event == "ZONE_CHANGED_NEW_AREA") then
		SetMapToCurrentZone();
	end
	TitanPanelCoordsButton_UpdateZoneInfo();
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelCoordsButton_OnClick(button)
	if (button == "LeftButton" and IsShiftKeyDown()) then
		if (ChatFrameEditBox:IsVisible()) then
			message = TitanUtils_ToString(this.zoneText).." "..
				format(TITAN_COORDS_FORMAT, 100 * this.px, 100 * this.py);
			ChatFrameEditBox:Insert(message);
		end
	end
end

function TitanPanelCoordsButton_UpdateZoneInfo()
	this.zoneText = GetZoneText();
	this.subZoneText = GetSubZoneText();
	this.minimapZoneText = GetMinimapZoneText();
	this.pvpType, this.factionName, this.isArena = GetZonePVPInfo();
end

function TitanPanelRightClickMenu_PrepareCoordsMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_COORDS_ID].menuText);
	
	local info = {};
	info.text = TITAN_COORDS_MENU_SHOW_ZONE_ON_PANEL_TEXT;
	info.func = TitanPanelCoordsButton_ToggleDisplay;
	info.checked = TitanGetVar(TITAN_COORDS_ID, "ShowZoneText");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_COORDS_MENU_SHOW_COORDS_ON_MAP_TEXT;
	info.func = TitanPanelCoordsButton_ToggleCoordsOnMap;
	info.checked = TitanGetVar(TITAN_COORDS_ID, "ShowCoordsOnMap");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_COORDS_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_COORDS_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_COORDS_ID);


	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_COORDS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelCoordsButton_ToggleDisplay()
	TitanToggleVar(TITAN_COORDS_ID, "ShowZoneText");
	TitanPanelButton_UpdateButton(TITAN_COORDS_ID);	
end

function TitanPanelCoordsButton_ToggleCoordsOnMap()
	TitanToggleVar(TITAN_COORDS_ID, "ShowCoordsOnMap");
	if (TitanGetVar(TITAN_COORDS_ID, "ShowCoordsOnMap")) then
		TitanMapCursorCoords:Show();
		TitanMapPlayerCoords:Show();
	else
		TitanMapCursorCoords:Hide();
		TitanMapPlayerCoords:Hide();
	end
end

function TitanPanelCoordsButton_ToggleColor()
	TitanToggleVar(TITAN_COORDS_ID, "ShowColoredText");
	TitanPanelButton_UpdateButton(TITAN_COORDS_ID);
end

local OFFSET_X = 0.0022;
local OFFSET_Y = -0.0262;

function TitanMapFrame_OnUpdate()
	if (TitanGetVar(TITAN_COORDS_ID, "ShowCoordsOnMap")) then
		local x, y = GetCursorPosition();
		x = x / WorldMapFrame:GetScale();
		y = y / WorldMapFrame:GetScale();
	
		this.px, this.py = GetPlayerMapPosition("player");
		local centerX, centerY = WorldMapFrame:GetCenter();
		local width = WorldMapButton:GetWidth();
		local height = WorldMapButton:GetHeight();
		local adjustedX = (x - (centerX - (width/2))) / width;
		local adjustedY = (centerY + (height/2) - y ) / height;
		local cx = (adjustedX + OFFSET_X);
		local cy = (adjustedY + OFFSET_Y);
	
		local cursorCoordsText = format(TITAN_COORDS_MAP_COORDS_TEXT, 100 * cx, 100 * cy);
		local playerCoordsText = format(TITAN_COORDS_MAP_COORDS_TEXT, 100 * this.px, 100 * this.py);			
		TitanMapCursorCoords:SetText(format(TITAN_COORDS_MAP_CURSOR_COORDS_TEXT, TitanUtils_GetHighlightText(cursorCoordsText)));
		TitanMapPlayerCoords:SetText(format(TITAN_COORDS_MAP_PLAYER_COORDS_TEXT, TitanUtils_GetHighlightText(playerCoordsText)));
	end
end

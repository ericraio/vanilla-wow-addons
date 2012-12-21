-- Font Colors
TRZ_WHITE = HIGHLIGHT_FONT_COLOR_CODE;
TRZ_RED = RED_FONT_COLOR_CODE;
TRZ_ORANGE = "|cffff8020";
TRZ_YELLOW = "|cffffff20";
TRZ_GREEN = GREEN_FONT_COLOR_CODE;
TRZ_GRAY = GRAY_FONT_COLOR_CODE;
TRZ_NORMAL = NORMAL_FONT_COLOR_CODE;
TRZ_FONT_OFF = FONT_COLOR_CODE_CLOSE;

TRZ_INSTANCE_TEXT = "%s%s%s (%d+ " .. TRZ_TOOLTIP_TO .. " %d+)" .. TRZ_FONT_OFF;  -- Instance (35+ to 45+)
TRZ_INSTANCE_TEXT2 = "%s%s%s (%d+)" .. TRZ_FONT_OFF;  -- Instance (35+)
TRZ_WORLDMAP_TEXT = "(%d-%d)" .. "\n\n" .. TRZ_FONT_OFF;

TRZ_MAX_ROWS = 29;

TRZ_ID =  "TRZ";

trz_tooltip_text = "";
trz_button_text = "";
trz_current_continent = 0;
trz_current_zone = 0;

function TRZ_Init()
	local zonearray = {};
	local i;
	
	if (myAddOnsFrame_Register) then
		myAddOnsFrame_Register( {name="TitanRecZone",version=TRZ_VERSION,category=MYADDONS_CATEGORY_PLUGINS} );
	end
	
	TRZ_ToggleWorldMapText();

	-- Populate zonenames (Hopefully should work for all locales)
	zonearray[1]={GetMapZones(1)};
	zonearray[2]={GetMapZones(2)};
	for i = 0, table.getn(TRZ_ZONES), 1 do
		TRZ_ZONES[i].zone = zonearray[TRZ_ZONES[i].continent][TRZ_ZONES[i].nr];
	end
end

function TRZ_OnLoad()
	this.registry = { 
		id = TRZ_ID,
		menuText = TRZ_MENU_TEXT, 
		buttonTextFunction = "TRZ_GetButtonText", 
		tooltipTitle = TRZ_TOOLTIP_TITEL,
		tooltipTextFunction = "TRZ_GetTooltipText", 
		category="Information",
		version=TRZ_VERSION,
		savedVariables = {
			ShowCurInstance = 1,
			ShowInstance = 1,
			ShowBattleground = 1,
			ShowRaid = TITAN_NIL,
			ShowFaction = TITAN_NIL,
			ShowContinent = TITAN_NIL,
			ShowLoc = 1,
			ShowMap = 1,
			ShowLower = TITAN_NIL,
			ShowHigher = TITAN_NIL,
			ShowColoredText = 1,
			ShowLabelText = 1,  -- Default to 1
		}
	};
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TRZ_OnEvent()
	if (event == "VARIABLES_LOADED") then
		TRZ_Init();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");
		this:RegisterEvent("PLAYER_LEAVING_WORLD");
		this:RegisterEvent("MINIMAP_ZONE_CHANGED");
		this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		this:RegisterEvent("PLAYER_LEVEL_UP");
		--TRZ_UpdateButtonText();
		TitanPanelButton_UpdateButton(TRZ_ID);
	elseif (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("PLAYER_LEAVING_WORLD");
		this:UnregisterEvent("MINIMAP_ZONE_CHANGED");
		this:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
		this:UnregisterEvent("PLAYER_LEVEL_UP");
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
	else
		--TRZ_UpdateButtonText();
		TitanPanelButton_UpdateButton(TRZ_ID);
	end
end

function TRZ_GetButtonText(id)
	TRZ_UpdateButtonText();
	TRZ_ToggleWorldMapText();
	return TRZ_BUTTON_LABEL, trz_button_text;
end

function TRZ_GetTooltipText()
	TRZ_UpdateTooltipText();
	return trz_tooltip_text;	
end

function TitanPanelRightClickMenu_PrepareTRZMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TRZ_ID].menuText);	
	
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_CUR_INSTANCE, TRZ_ID, "ShowCurInstance");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_FACTION, TRZ_ID, "ShowFaction");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_CONTINENT, TRZ_ID, "ShowContinent");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_INSTANCE, TRZ_ID, "ShowInstance");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_BG, TRZ_ID, "ShowBattleground");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_RAID, TRZ_ID, "ShowRaid");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_LOC, TRZ_ID, "ShowLoc");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_LOWER, TRZ_ID, "ShowLower");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_HIGHER, TRZ_ID, "ShowHigher");
	TitanPanelRightClickMenu_AddToggleVar(TRZ_TOGGLE_MAP_TEXT, TRZ_ID, "ShowMap");
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleColoredText(TRZ_ID)
	TitanPanelRightClickMenu_AddToggleLabelText(TRZ_ID);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TRZ_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

-- end titan panel setup

function TRZ_GetColor(low,high)
	-- PlayerLevel <= low for zone - 4  == RED
	-- PlayerLevel <  low for zone      == ORANGE
	-- PlayerLevel <= high              == YELLOW
	-- PlayerLevel <  high + 5          == GREEN
	-- Otherwise                        == GRAY
  local playerLevel = UnitLevel("player");
	if (playerLevel <= (low-4)) then
		return TRZ_RED;
	elseif (playerLevel < low) then
		return TRZ_ORANGE;
	elseif (playerLevel <= high) then
		return TRZ_YELLOW;
	elseif (playerLevel < (high+5)) then
		return TRZ_GREEN;
	else
		return TRZ_GRAY;
	end
end

function TRZ_GetInstanceText(index,colors)
	local instanceColor = TRZ_WHITE;
	local instanceType = "";
	if ( TRZ_INSTANCES[index] == nil ) then
		return "";
	end
	if (colors) then
		instanceColor = TRZ_GetColor(TRZ_INSTANCES[index].low,TRZ_INSTANCES[index].high);
	end
	if (TRZ_INSTANCES[index].type ~= TRZ_INSTANCE) then
		return instanceColor .. TRZ_INSTANCES[index].zone .. TRZ_INSTANCE_TYPE[TRZ_INSTANCES[index].type];
	end
	if (TRZ_INSTANCES[index].low == TRZ_INSTANCES[index].high) then
		return format(TRZ_INSTANCE_TEXT2, instanceColor, TRZ_INSTANCES[index].zone,
								TRZ_INSTANCE_TYPE[TRZ_INSTANCES[index].type],
								TRZ_INSTANCES[index].low );
	end
	return format(TRZ_INSTANCE_TEXT, instanceColor, TRZ_INSTANCES[index].zone,
								TRZ_INSTANCE_TYPE[TRZ_INSTANCES[index].type],
								TRZ_INSTANCES[index].low, TRZ_INSTANCES[index].high );
end

function TRZ_GetZoneText(index,colors)
	local zoneColor = TRZ_WHITE;
	if ( TRZ_ZONES[index] == nil ) then
		return "";
	end
	-- No level range for city zones
	if ( TRZ_ZONES[index].faction == TRZ_CITY ) then
		return TRZ_WHITE .. TRZ_ZONES[index].zone .. TRZ_FONT_OFF;
	end
	if (colors) then
		zoneColor = TRZ_GetColor(TRZ_ZONES[index].low,TRZ_ZONES[index].high);
	end
	-- Add zone name and level range.
	return	zoneColor .. TRZ_ZONES[index].zone .. 
					" (" .. TRZ_ZONES[index].low .. "-" .. TRZ_ZONES[index].high .. ")" .. TRZ_FONT_OFF;
end

function TRZ_GetFactionText(index,colors)
	local factionColor = TRZ_WHITE;
	if ( TRZ_ZONES[index] == nil ) then
		return "";
	end
	if (colors) then
		if ( TRZ_ZONES[index].faction == TRZ_CONTESTED ) then
			factionColor = TRZ_YELLOW;
		else
			factionColor = TRZ_GREEN;
		end
	end
	return factionColor .. " [" .. TRZ_FACTION[TRZ_ZONES[index].faction] .. "]" .. TRZ_FONT_OFF;
end

function TRZ_GetContinentText(index,colors)
	local continentColor = TRZ_WHITE;
	if ( TRZ_ZONES[index] == nil ) then
		return "";
	end
	if (colors) then
		if ( TRZ_ZONES[index].continent == trz_current_continent ) then
			continentColor = TRZ_GREEN;
		else
			continentColor = TRZ_YELLOW;
		end
	end
	return continentColor .. " (" .. TRZ_CONTINENT[TRZ_ZONES[index].continent] .. ")";
end

function TRZ_GetLevelText(low,high,colors)
	local levelColor = TRZ_WHITE;
	if ( colors ) then
		levelColor = TRZ_GetColor(low,high);
	end
	return levelColor .. format("%d-%d", low, high) .. TRZ_FONT_OFF;
end

function TRZ_UpdateButtonText()	
  local i;
  local zoneColor;
  local playerLevel = UnitLevel("player");
  local zoneName = GetRealZoneText();
	local colorTooltip = TitanGetVar(TRZ_ID, "ShowColoredText");

  trz_button_text = "";
	for i = 0, table.getn(TRZ_ZONES), 1 do
		if (string.find(zoneName, TRZ_ZONES[i].zone)) then
			trz_current_continent = TRZ_ZONES[i].continent;
			trz_current_zone = i;
			if (TRZ_ZONES[i].faction == TRZ_CITY) then
				trz_button_text = TRZ_WHITE .. TRZ_FACTION[TRZ_ZONES[i].faction] .. TRZ_FONT_OFF;
			else
				trz_button_text = TRZ_GetLevelText(TRZ_ZONES[i].low, TRZ_ZONES[i].high, colorTooltip);
			end
			return
		end
	end
	-- Check if we are in an instance
	for i = 0, table.getn(TRZ_INSTANCES), 1 do
		if (string.find(zoneName, TRZ_INSTANCES[i].zone)) then
			trz_current_zone = i+100;
			trz_button_text = TRZ_GetLevelText(TRZ_INSTANCES[i].low, TRZ_INSTANCES[i].high, colorTooltip);
			return;
		end
	end
	return 
end

function  TRZ_UpdateTooltipText()	
  local player_level = UnitLevel("player");
  local c,i;
  local tempText;
  local firstShown;
  local showLower = 0;
  local showHigher = 0;
	local colorTooltip = TitanGetVar(TRZ_ID, "ShowColoredText");
	local showInstance = TitanGetVar(TRZ_ID, "ShowInstance");
	local showCurInstance = TitanGetVar(TRZ_ID, "ShowCurInstance");
	local showBattleground = TitanGetVar(TRZ_ID, "ShowBattleground");
	local showRaid = TitanGetVar(TRZ_ID, "ShowRaid");
	local showFaction = TitanGetVar(TRZ_ID, "ShowFaction");
	local showContinent = TitanGetVar(TRZ_ID, "ShowContinent");
	local showLoc = TitanGetVar(TRZ_ID, "ShowLoc");
	local rows = 4;
	
	trz_tooltip_text = "";
	if ( TitanGetVar(TRZ_ID, "ShowLower" ) ) then
		showLower = 5;
	end
	if ( TitanGetVar(TRZ_ID, "ShowHigher" ) ) then
		showHigher = 5;
	end	
	if (trz_current_zone >= 100 ) then
		tempText = TRZ_TOOLTIP_CZONE .. TRZ_GetInstanceText(trz_current_zone-100,colorTooltip);
	else
		tempText = TRZ_TOOLTIP_CZONE .. TRZ_GetZoneText(trz_current_zone,colorTooltip) .. "\t";
	  -- Show faction
		if ( showFaction ) then
			tempText = tempText .. TRZ_GetFactionText(trz_current_zone,colorTooltip);
		end
		-- show continent
		if ( showContinent ) then
			tempText = tempText .. TRZ_GetContinentText(trz_current_zone,colorTooltip);
		end
	
		-- Show instances for current zone.
	  if ( showCurInstance ) then
			if ( TRZ_ZONES[trz_current_zone].instances[0] ~= nil ) then
			  for c = 0, table.getn(TRZ_ZONES[trz_current_zone].instances), 1 do
			  	local f = TRZ_INSTANCES[TRZ_ZONES[trz_current_zone].instances[c]].faction;
			  	if ( (f == TRZ_CONTESTED) or (TRZ_FACTION[f] == UnitFactionGroup("player")) ) then
						tempText = tempText .. "\n" .. TRZ_TOOLTIP_CINSTANCES ..
												TRZ_GetInstanceText(TRZ_ZONES[trz_current_zone].instances[c], colorTooltip);
						rows = rows + 1;
					end
				end
			end
		end			
	end
	
	-- Show recommended zones.
	tempText = tempText .. "\n\n" .. TRZ_WHITE .. TRZ_TOOLTIP_RECOMMEND .. TRZ_FONT_OFF;
	for i = 0, table.getn(TRZ_ZONES), 1 do
		if ( (TRZ_ZONES[i].low - showHigher) <= player_level and 
		     (TRZ_ZONES[i].high + showLower) >= player_level ) then	
			if ( (TRZ_ZONES[i].faction == TRZ_CONTESTED) or (UnitFactionGroup("player") == TRZ_FACTION[TRZ_ZONES[i].faction]) ) then

				if ( rows >= TRZ_MAX_ROWS ) then
					tempText = tempText .. "\n" .. TRZ_TOOLTIP_MORE;
					trz_tooltip_text = tempText;
					return
				end

				-- Add zone name and level range.
        tempText = tempText .. "\n" .. TRZ_GetZoneText(i,colorTooltip) .. "\t";
				rows = rows + 1;
				
        -- Show faction
				if ( showFaction ) then
	        tempText = tempText .. TRZ_GetFactionText(i,colorTooltip);
				end

        -- show continent
        if ( showContinent ) then
          tempText = tempText .. TRZ_GetContinentText(i,colorTooltip);
        end
			end
		end
	end
	
	-- Show recommended instances/battlegrounds/raids
	if( showInstance or showRaid or showBattleground ) then
		firstShown = nil;
		for i = 0, table.getn(TRZ_INSTANCES), 1 do
			if ( (TRZ_INSTANCES[i].low - showHigher) <= player_level and
					 (TRZ_INSTANCES[i].high + showLower) >= player_level ) then
		  	local f = TRZ_INSTANCES[i].faction;
		  	if ( (f == TRZ_CONTESTED) or (TRZ_FACTION[f] == UnitFactionGroup("player")) ) then
			  	local t = TRZ_INSTANCES[i].type
					if ( (t == TRZ_INSTANCE and showInstance) or 
							((t == TRZ_RAID20 or t == TRZ_RAID40) and showRaid) or
							 (t == TRZ_BATTLEGROUND and showBattleground)) then
						if ( rows >= TRZ_MAX_ROWS ) then
							tempText = tempText .. "\n" .. TRZ_TOOLTIP_MORE;
							trz_tooltip_text = tempText;
							return
						end
						if ( not firstShown )	then
							tempText = tempText .. "\n\n" .. TRZ_WHITE .. TRZ_TOOLTIP_RECOMMEND_INSTANCES .. TRZ_FONT_OFF;
							firstShown = 1;
							rows = rows + 1;
						end
						if ( rows >= TRZ_MAX_ROWS ) then
							tempText = tempText .. "\n" .. TRZ_TOOLTIP_MORE;
							trz_tooltip_text = tempText;
							return
						end
						tempText = tempText .. "\n" .. TRZ_GetInstanceText(i,colorTooltip);
						rows = rows + 1;
						if ( showLoc ) then
							if ( TRZ_INSTANCES[i].iloc ) then
								tempText = tempText .. "\t" .. TRZ_WHITE .. "<" .. TRZ_INSTANCES[TRZ_INSTANCES[i].iloc].zone .. ">" .. TRZ_FONT_OFF
							else
								tempText = tempText .. "\t" .. TRZ_WHITE .. "<" .. TRZ_ZONES[TRZ_INSTANCES[i].loc].zone .. ">" .. TRZ_FONT_OFF
							end
						end
					end
				end
			end
		end
	end
					  
	trz_tooltip_text = tempText;
	return
end


-- Worldmap function --

function TRZ_ToggleWorldMapText()
	if (TitanGetVar(TRZ_ID, "ShowMap")) then
		TRZ_WorldMap_Frame:Show();
	else
		TRZ_WorldMap_Frame:Hide();
	end
end

function TRZ_WorldMapButton_OnUpdate()
   local player_level = UnitLevel("player");
   local zoneColor;
	 if (WorldMapFrame.areaName ~= nil) then 	
		 for i = 0, table.getn(TRZ_ZONES), 1 do
			if (string.find(WorldMapFrame.areaName, TRZ_ZONES[i].zone)) then
				zoneColor = TRZ_GetColor(TRZ_ZONES[i].low, TRZ_ZONES[i].high);
				zoneText = zoneColor .. format(TRZ_WORLDMAP_TEXT, TRZ_ZONES[i].low, TRZ_ZONES[i].high);
				if ( TRZ_ZONES[i].instances[0] ~= nil ) then
				  zoneText = zoneText .. TRZ_NORMAL .. TRZ_TOOLTIP_CINSTANCES .. "\n" .. TRZ_FONT_OFF;
					for c = 0, table.getn(TRZ_ZONES[i].instances), 1 do
						zoneText = zoneText .. TRZ_GetInstanceText(TRZ_ZONES[i].instances[c], true) .. "\n";
					end
				end
				TRZ_WorldMap_Text:SetText(zoneText);
			end
		end
	else
		TRZ_WorldMap_Text:SetText("");
	end

	if (WorldMapFrame.poiHighlight == 1) then
		for i = 0, table.getn(TRZ_ZONES), 1 do
			if (string.find(WorldMapFrameAreaLabel:GetText(), TRZ_ZONES[i].zone)) then
				zoneText = TRZ_WHITE .. TRZ_FACTION[TRZ_ZONES[i].faction] .. "\n\n" .. TRZ_FONT_OFF;
				if (TRZ_ZONES[i].instances ~= nil) then
					zoneText = zoneText .. TRZ_NORMAL .. TRZ_TOOLTIP_RINSTANCES .. "\n" .. TRZ_FONT_OFF;
					for c = 0, table.getn(TRZ_ZONES[i].instances), 1 do
						zoneText = zoneText .. TRZ_GetInstanceText(TRZ_ZONES[i].instances[c], true) .. "\n";
					end
				end
				TRZ_WorldMap_Text:SetText(zoneText);
			end
		end
	end
end


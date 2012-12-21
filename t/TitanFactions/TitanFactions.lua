--------------------------------------------------------------------------
-- TitanFactions.lua 
--------------------------------------------------------------------------
--[[

Titan Panel [Factions]
	When hovered over it displays the reputation standing for each faction
	and the percentage completed.  Can monitor an individual faction in the
	Titan Panel.

Author: Corgi - corgiwow@gmail.com

v0.13 (April 10, 2006 14:21 PST)
- updated toc# for 1.10 patch
- added ability to show both percent and raw values

v0.12 (January 6, 2006 10:00 PST)
- updated toc# for 1.9 patch

v0.11 (October 19, 2005 11:15 PST)
- localization update

v0.10 (October 14, 2005 13:45 PST)
- added ability to monitor a faction
- color-coded faction text (thanks Fyredrake)

v0.09 (October 11, 2005 16:20 PST)
- updated for changes to GetFactionInfo()
- updated toc# for 1.80 patch

v0.08 (September 15, 2005 21:23 PST)
- added toggle between raw and percentage
- updated toc# for 1.70 patch

v0.07 (June 13, 2005 15:00 PST)
- updated for Titan Panel 1.24

v0.06 (June 7, 2005 20:30 PST)
- toc updated for 1.50 patch

v0.05 (June 6, 2005 23:45 PST)
- added transparent icon

v0.04 (May 31, 2005 02:22 PST)
- updated for Titan Panel version 1.22
- added Icon
- removed the displaying number of factions

v0.03 (May 26, 2005 15:20 PST)
- added a tab between faction name and standing

v0.02 (May 25, 2005 11:05 PST)
- removed faction headers from total number of factions

v0.01 (May 25, 2005 02:00 PST)
- Initial Release

TODO: Complete translation for German, French and Korean.
      
NOTE: Requires Titan Panel version 1.22+

]]--

TITAN_FACTIONS_ID = "Factions";

TITAN_FACTIONS_ICON = "Interface\\AddOns\\TitanFactions\\Artwork\\TitanFactions";

-- Maximum units for each standing
Units = { };
Units[1] = 36000; -- Hated
Units[2] = 3000; -- Hostile
Units[3] = 3000; -- Unfriendly
Units[4] = 3000; -- Neutral
Units[5] = 6000; -- Friendly
Units[6] = 12000; -- Honored
Units[7] = 21000; -- Revered
Units[8] = 1000; -- Exalted

--
-- OnFunctions
--
function TitanPanelFactionsButton_OnLoad()
	this.registry = { 
		id = TITAN_FACTIONS_ID,
		menuText = TITAN_FACTIONS_MENU_TEXT, 
		buttonTextFunction = "TitanPanelFactionsButton_GetButtonText", 
		tooltipTitle = TITAN_FACTIONS_TOOLTIP,
		tooltipTextFunction = "TitanPanelFactionsButton_GetTooltipText", 
		icon = TITAN_FACTIONS_ICON,
	    iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowRaw = TITAN_NIL,
			ShowBoth = TITAN_NIL,
			ShowMonitor = TITAN_NIL,
			MonitorFaction = TITAN_NIL,
		}
	};
	
	this:RegisterEvent("UPDATE_FACTION");
end


function TitanPanelFactionsButton_OnEvent(event)
	if ( event == "UPDATE_FACTION" ) then
		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 ) then
			TitanPanelFactions_UpdateMonitor();
			TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID);	
		end
		TitanPanelButton_UpdateTooltip();
	end
end

--
-- Titan functions
--
function TitanPanelFactionsButton_GetButtonText(id)
	local buttonRichText = "";
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 and (TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction") ~= nil) ) then
		buttonRichText = format(TITAN_FACTIONS_BUTTON_TEXT, TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction"));
	end
	
	return TITAN_FACTIONS_BUTTON_LABEL, buttonRichText;
end


function TitanPanelFactionsButton_GetTooltipText()
	
	local tooltipRichText = "";

	local NumFactions = GetNumFactions();

	local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith;
	local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed;

	local factionIndex;

	for factionIndex=1, NumFactions do

		faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed = GetFactionInfo(factionIndex);
	
		if ( not faction_isHeader ) then
			
			tooltipRichText = tooltipRichText..TitanUtils_GetGreenText(faction_name)..":".."\t"..TitanPanelFactions_FindRep(faction_standingID).."(";
			
			if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
				tooltipRichText = tooltipRichText..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")\n";
			elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
				local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100);
				tooltipRichText = tooltipRichText..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..") ("..bval.."%)\n";
			else
				local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100);
				tooltipRichText = tooltipRichText..bval.."%)\n";
			end
		else
			tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(faction_name).."\n";
		end
	end

	-- remove the last \n
	tooltipRichText = string.sub(tooltipRichText, 1, string.len(tooltipRichText)-1);

	return tooltipRichText;
end

--
-- create 2nd level right-click menu
--
function TitanPanelRightClickMenu_PrepareFactionsMenu()

	local info = {};
	
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then		
		if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then
			info = {};
			info.text = TITAN_FACTIONS_ABOUT_POPUP_TEXT;
			info.value = "AboutTextPopUP";
			info.notClickable = 1;
			info.isTitle = 0;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		
		if ( UIDROPDOWNMENU_MENU_VALUE == "Monitor" ) then
				
			info = {};
			info.text = TITAN_FACTIONS_MONITOR_TOGGLE_TEXT;
			info.func = TitanPanelFactions_MonitorToggle;
			info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor");
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			
			info = {};
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			
			local NumFactions = GetNumFactions();

			local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith;
			local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed;
		
			local factionIndex;
		
			for factionIndex=1, NumFactions do
		
				info = {};
				info.text = "";
				
				faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed = GetFactionInfo(factionIndex);
			
				if ( not faction_isHeader ) then
					
					info.text = info.text..TitanUtils_GetGreenText(faction_name)..":".."\t"..TitanPanelFactions_FindRep(faction_standingID).."(";
					
					if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
						info.text = info.text..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")\n";
					elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
						local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100);
						info.text = info.text..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..") ("..bval.."%)\n";
					else
						local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100);
						info.text = info.text..bval.."%)\n";
					end
					
					info.value = info.text;
					
					info.func = TitanPanelFactions_SetMonitorFaction;
								
					info.checked = nil;
					if ( info.text == TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction") ) then
						info.checked = 1;
					end
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				
				end
				
			end
		end
				
		return;
	end
	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_FACTIONS_ID].menuText);
	
	--TitanPanelRightClickMenu_AddToggleIcon(TITAN_FACTIONS_ID);
	
	-- monitor
	info = {};
	info.text = TITAN_FACTIONS_MONITOR;
	info.value = "Monitor";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = {};
	info.text = TITAN_FACTIONS_SHOW_RAW;
	info.func = TitanPanelFactions_ShowRawToggle;
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw");
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = {};
	info.text = TITAN_FACTIONS_SHOW_BOTH;
	info.func = TitanPanelFactions_ShowBothToggle;
	info.checked = TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth");
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = {};
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_FACTIONS_ID);		
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_FACTIONS_ID, TITAN_PANEL_MENU_FUNC_HIDE);

	-- info about plugin
	info = {};
	info.text = TITAN_FACTIONS_ABOUT_TEXT;
	info.value = "DisplayAbout";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

end

--
-- Factions functions
--
-- Round function
function round(x)
	return floor(x+0.5);
end

function TitanPanelFactions_UpdateMonitor()

	local tmp_faction = "";
	
	local NumFactions = GetNumFactions();

	local faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith;
	local faction_canToggleAtWar, faction_isHeader, faction_isCollapsed;

	local factionIndex;
	
	for factionIndex=1, NumFactions do

		faction_name, faction_description, faction_standingID, faction_barMin, faction_barMax, faction_barValue, faction_atWarWith, faction_canToggleAtWar, faction_isHeader, faction_isCollapsed = GetFactionInfo(factionIndex);
	
		if ( (TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction") ~= nil) and string.find(TitanGetVar(TITAN_FACTIONS_ID, "MonitorFaction"), faction_name) ) then
			
			tmp_faction = TitanUtils_GetGreenText(faction_name)..":".."\t"..TitanPanelFactions_FindRep(faction_standingID).."(";
			
			if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
				tmp_faction = tmp_faction..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..")\n";
			elseif (TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
				local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100);
				tmp_faction = tmp_faction..faction_barValue - faction_barMin.."/"..faction_barMax - faction_barMin..") ("..bval.."%)\n";
			else
				local bval = math.floor( ((faction_barValue - faction_barMin) / (faction_barMax - faction_barMin)) * 100);
				tmp_faction = tmp_faction..bval.."%)\n";
			end
			TitanSetVar(TITAN_FACTIONS_ID, "MonitorFaction", tmp_faction);
		end
	end	
end

function TitanPanelFactions_MonitorToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowMonitor", nil);
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowMonitor", 1);
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID);
end

function TitanPanelFactions_SetMonitorFaction()
	TitanSetVar(TITAN_FACTIONS_ID, "MonitorFaction", this.value);
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID);
end

function TitanPanelFactions_ShowRawToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowRaw", nil);
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowRaw", 1);
		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
			TitanSetVar(TITAN_FACTIONS_ID, "ShowBoth", nil);
		end
	end
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 ) then
			TitanPanelFactions_UpdateMonitor();
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID);
end

function TitanPanelFactions_ShowBothToggle()
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowBoth") ) then
		TitanSetVar(TITAN_FACTIONS_ID, "ShowBoth", nil);
	else
		TitanSetVar(TITAN_FACTIONS_ID, "ShowBoth", 1);
		if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowRaw") ) then
			TitanSetVar(TITAN_FACTIONS_ID, "ShowRaw", nil);
		end
	end
	if ( TitanGetVar(TITAN_FACTIONS_ID, "ShowMonitor") == 1 ) then
			TitanPanelFactions_UpdateMonitor();
	end
	TitanPanelButton_UpdateButton(TITAN_FACTIONS_ID);
end

function TitanPanelFactions_FindRep(standingID)
	if ( standingID == 0 ) then
		return UNKNOWN; -- unknown
	elseif ( standingID == 1 ) then
		return FactionTextHated; -- hated
	elseif ( standingID == 2) then
		return FactionTextHostile; -- hostile
	elseif ( standingID == 3) then
		return FactionTextUnfriendly; -- unfriendly
	elseif ( standingID == 4) then
		return FactionTextNeutral; -- neutral
	elseif ( standingID == 5) then
		return FactionTextFriendly; -- friendly
	elseif ( standingID == 6) then
		return FactionTextHonored; -- honored
	elseif ( standingID == 7) then
		return FactionTextRevered; -- revered
	elseif ( standingID == 8) then
		return FactionTextExalted; -- exalted
	end
end

--
-- debug
--
function TitanPanelFactions_ChatPrint(msg)
        DEFAULT_CHAT_FRAME:AddMessage(msg);
end

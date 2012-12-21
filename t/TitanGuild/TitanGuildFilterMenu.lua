----------------------------------------------------------------------
-- TitanGuildFilterMenu.lua
-- code for filtering the button contents
----------------------------------------------------------------------

----------------------------------------------------------------------
--  TitanPanelGuildButton_IsPassFilter()
--  checks player selected filters against guild data
----------------------------------------------------------------------
function TitanPanelGuildButton_IsPassFilter(member_zone, member_level, member_class)
	-- init to true by default
	local showMember = true;
	local zoneFilterPass = true;
	local levelFilterPass = true;
	local classFilterPass = true;
	
	local playerZone = "";
	local levelMax = TitanPanelGuildButton_GetMaxLevel();
	local levelMin = TitanPanelGuildButton_GetMinLevel();
	-- init zone
	playerZone = GetZoneText();
	-- check level
	if (TitanGetVar(TITAN_GUILD_ID, "FilterMyZone")) then
		if (member_zone == playerZone) then
			zoneFilterPass = true;
		else
			zoneFilterPass = false;
		end
	end
	-- check zone
	if (TitanGetVar(TITAN_GUILD_ID, "FilterMyLevel")) then
		if (member_level >= levelMin and member_level <= levelMax) then
			levelFilterPass = true;
		else
			levelFilterPass = false;
		end
	end
	-- check class
	if (TitanGetVar(TITAN_GUILD_ID, "FilterClasses")) then
		if (member_class == TitanGetVar(TITAN_GUILD_ID, "FilterClasses")) then
			classFilterPass = true;
		else
			classFilterPass = false;
		end		
	end
	-- check all filters and returned combined logical value
	if (zoneFilterPass and levelFilterPass and classFilterPass) then
		showMember = true;
	else
		showMember = false;
	end
	
	return showMember;
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_BuildClassFilterMenu()
----------------------------------------------------------------------
function TitanPanelGuildButton_BuildClassFilterMenu()
	local classListValues = {};
	local classListLabels = {};
	local playerFaction = "";
	playerFaction = UnitFactionGroup("player");
	if (playerFaction == "Horde") then
		classListValues = hordeClassValues;
		classListLabels = hordeClassLabels;
	else
		classListValues = allianceClassValues;
		classListLabels = allianceClassLabels;
	end
	local classIndex;
	TitanPanelRightClickMenu_AddTitle(UIDROPDOWNMENU_MENU_VALUE, UIDROPDOWNMENU_MENU_LEVEL);
	for classIndex = 1, table.getn(classListValues) do
		info = {};
		info.text = classListLabels[classIndex];
		info.value = classListValues[classIndex];
		info.func = TitanPanelGuildButton_AddClassFilter;
		if (classListValues[classIndex] == TitanGetVar(TITAN_GUILD_ID, "FilterClasses")) then
			info.checked = 1;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	TitanPanelRightClickMenu_AddCommand(TITAN_GUILD_MENU_HIDE, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_CLOSEMENU, UIDROPDOWNMENU_MENU_LEVEL);
end
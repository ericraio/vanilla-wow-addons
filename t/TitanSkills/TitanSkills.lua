--------------------------------------------------------------------------
-- TitanSkills.lua 
--------------------------------------------------------------------------
--[[

Titan Panel [Skills]
	Plug-in for Titan Panel that displays Professions, Secondary Skills 
	and Weapons Skills when hovered over. 

Author: Corgi - corgiwow@gmail.com

v0.09 (April 5, 2006 22:00 PST)
- fixed level change
- toc# updated for 1.10 patch

v0.08 (January 5, 2006 20:05 PST)
- added ability to toggle player's Level 
- Shift-click opens Skills frame
- toc# updated for 1.9 patch

v0.07 (October 26, 2005 10:18 PST)
- toc# updated for 1.8 patch
- added Skills (Right) options (thanks Forger)
- tooltip will now popup below/above Titan bar (thanks Forger)
- added skill bonuses (e.g. Skill 10(+5)/300) (thanks Forger)

v0.06 (September 24, 2005 19:11 PST)
- toc# updated for 1.7 patch
- added French localization

v0.05 (June 13, 2005 14:30 PST)
- updated for Titan Panel 1.24

v0.04 (June 7, 2005 14:25 PST)
- toc updated for 1.5 patch
- minor french localization

v0.03 (June 6, 2005 12:35 PST)
- complete German translation by Crowley
- added transparent icon

v0.02 (June 3, 2005 20:00 PST)
- list non-passive Class Skills (ie, Rogue's Lockpicking and Poison skills)

v0.01 (May 31, 2005 2:00 PST)
- Initial Release

]]--

TITAN_SKILLS_ID = "Skills";
TITAN_SKILLS_RIGHT_ID = "SkillsRight";

TITAN_SKILLS_ICON = "Interface\\Addons\\TitanSkills\\Artwork\\TitanSkills";

--
-- OnFuctions
--
function TitanPanelSkillsButton_OnLoad()
	this.registry = { 
		id = TITAN_SKILLS_ID,
		menuText = TITAN_SKILLS_MENU_TEXT, 
		buttonTextFunction = "TitanPanelSkillsButton_GetButtonText", 
		tooltipTitle = TITAN_SKILLS_TOOLTIP,
		tooltipTextFunction = "TitanPanelSkillsButton_GetTooltipText",
		icon = TITAN_SKILLS_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowLevel = TITAN_NIL,
		}
	};
	this:RegisterEvent("SKILL_LINES_CHANGED");
	this:RegisterEvent("PLAYER_LEVEL_UP");
end

function TitanPanelSkillsRightButton_OnLoad()
	this.registry = { 
		id = TITAN_SKILLS_RIGHT_ID,
		menuText = TITAN_SKILLS_RIGHT_MENU_TEXT, 
		buttonTextFunction = "TitanPanelSkillsButton_GetButtonText", 
		tooltipTitle = TITAN_SKILLS_TOOLTIP,
		tooltipTextFunction = "TitanPanelSkillsButton_GetTooltipText",
		icon = TITAN_SKILLS_ICON,
		iconWidth = 16,
	};
end

function TitanPanelSkillsButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_SKILLS_ID);	
	TitanPanelButton_UpdateTooltip();
end

-- CROWGOBLIN ADDITION
function TitanPanelSkillsButton_OnClick()
        if (IsShiftKeyDown()) then
                ToggleCharacter("SkillFrame");
        end
end

--
-- Titan functions
--
function TitanPanelSkillsButton_GetButtonText(id)	
	local buttonRichText = "";
	
	if ( TitanGetVar(TITAN_SKILLS_ID,"ShowLevel") ~= nil ) then
		buttonRichText = " "..TitanUtils_GetHighlightText(UnitLevel("player"));
	end
	
	if ( id == TITAN_SKILLS_RIGHT_ID ) then
		return "", "";
	else
		return TITAN_SKILLS_BUTTON_LABEL, buttonRichText;
	end
end

function TitanPanelSkillsButton_GetTooltipText()
	
	local tooltipRichText = "";
	
	local SkillList = TitanPanelSkills_BuildSkillList();
	
	local numSkills = table.getn(SkillList);

	local i = 0;
	local currentHeader = "";
	local prevHeader = "";
	
	for i=1, numSkills do

		currentHeader = SkillList[i].stype;

		if ( SkillList[i].stype == TRADE_SKILLS or SkillList[i].stype == TITAN_SKILLS_SECONDARY_TEXT or SkillList[i].stype == TITAN_SKILLS_WEAPON_TEXT or SkillList[i].stype == TITAN_SKILLS_CLASS_TEXT ) then
			if ( currentHeader ~= prevHeader and SkillList[i].maxrank > 1 ) then
				tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(SkillList[i].stype).."\n";
				prevHeader = currentHeader;
			end
			if ( SkillList[i].maxrank > 1 ) then
					tooltipRichText = tooltipRichText..TitanUtils_GetGreenText(SkillList[i].name)..":".."\t"..SkillList[i].rank;
					if ( SkillList[i].rankbonus > 0 ) then
						tooltipRichText = tooltipRichText.."(+"..SkillList[i].rankbonus..")";
					end
					tooltipRichText = tooltipRichText.."/"..SkillList[i].maxrank.."\n";
			end
		end
	end

	-- remove the last \n
	tooltipRichText = string.sub(tooltipRichText, 1, string.len(tooltipRichText)-1);

	return tooltipRichText;
end

--
-- create menus
--
function TitanPanelRightClickMenu_PrepareSkillsMenu()
	TitanPanelRightClickMenu_PrepareMenu(TITAN_SKILLS_ID);
end

function TitanPanelRightClickMenu_PrepareSkillsRightMenu()
	TitanPanelRightClickMenu_PrepareMenu(TITAN_SKILLS_RIGHT_ID);
end

function TitanPanelRightClickMenu_PrepareMenu(id)

	local info = {};
	
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
	
		if ( UIDROPDOWNMENU_MENU_VALUE == "DisplayAbout" ) then
			info = {};
			info.text = TITAN_SKILLS_ABOUT_POPUP_TEXT;
			info.value = "AboutTextPopUP";
			info.notClickable = 1;
			info.isTitle = 0;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end
	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);
	if ( id == TITAN_SKILLS_ID ) then
		info = {};
		info.text = TITAN_SKILLS_SHOW_LEVEL_TEXT;
		info.value = "ShowLevelToggle";
		info.func = TitanPanelSkills_ShowLevelToggle;
		info.checked = TitanGetVar(TITAN_SKILLS_ID, "ShowLevel");
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		TitanPanelRightClickMenu_AddToggleLabelText(id);
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
	end

	-- info about plugin
	info = {};
	info.text = TITAN_SKILLS_ABOUT_TEXT;
	info.value = "DisplayAbout";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
end

--
-- Skills functions
--
function TitanPanelSkills_BuildSkillList()

	local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable;
	local stepCost, rankCost, minLevel, skillCostType;

	local skillType = "";
	local skillIndex = 0;
	local SkillList = { };

	local numSkills = GetNumSkillLines();

	for skillIndex=1, numSkills do
		
		skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(skillIndex);
	
		if ( isHeader ) then
			skillType = skillName;
		else
			local entry = { name = skillName, stype = skillType, rank = skillRank, maxrank = skillMaxRank, rankbonus = skillModifier };
			table.insert(SkillList, entry);
		end
	end
	
	--TitanPanelSkills_DisplayTheList(SkillList);
	return SkillList;
end

function TitanPanelSkills_ShowLevelToggle()
	if ( TitanGetVar(TITAN_SKILLS_ID, "ShowLevel") ) then
		TitanSetVar(TITAN_SKILLS_ID, "ShowLevel", nil);
	else
		TitanSetVar(TITAN_SKILLS_ID, "ShowLevel", 1);
	end
	
	TitanPanelButton_UpdateButton(TITAN_SKILLS_ID);
end

--
-- debug
-- 
function TitanPanelSkills_DisplayTheList(thelist)
	local i = 0;
	for i=1, table.getn(thelist) do
		TitanPanelSkills_ChatPrint(i..":"..thelist[i].name..":"..thelist[i].stype.."\n");
	end
end

function TitanPanelSkills_ChatPrint(msg)
        DEFAULT_CHAT_FRAME:AddMessage(msg);
end
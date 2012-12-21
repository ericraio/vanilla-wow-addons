TITAN_LOOTTYPE_ID = "LootType";

TitanLootMethod = {};
TitanLootMethod["freeforall"] = {text = TITAN_LOOTTYPE_FREE_FOR_ALL};
TitanLootMethod["roundrobin"] = {text = TITAN_LOOTTYPE_ROUND_ROBIN};
TitanLootMethod["master"] = {text = TITAN_LOOTTYPE_MASTER_LOOTER};
TitanLootMethod["group"] = {text = TITAN_LOOTTYPE_GROUP_LOOT};
TitanLootMethod["needbeforegreed"] = {text = TITAN_LOOTTYPE_NEED_BEFORE_GREED};

function TitanPanelLootTypeButton_OnLoad()
	this.registry = {
		id = TITAN_LOOTTYPE_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_LOOTTYPE_MENU_TEXT,
		buttonTextFunction = "TitanPanelLootTypeButton_GetButtonText", 
		tooltipTitle = TITAN_LOOTTYPE_TOOLTIP, 
		tooltipTextFunction = "TitanPanelLootTypeButton_GetTooltipText",
		icon = TITAN_ARTWORK_PATH.."TitanLootType",		
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};	

    this:RegisterEvent("PARTY_MEMBERS_CHANGED");
    this:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
end

function TitanPanelLootTypeButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_LOOTTYPE_ID);	
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelLootTypeButton_GetButtonText(id)
	local lootTypeText, lootThreshold, color;
	if (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
		lootTypeText = TitanLootMethod[GetLootMethod()].text;
		lootThreshold = GetLootThreshold();
		color = ITEM_QUALITY_COLORS[lootThreshold];
	else
		lootTypeText = TITAN_NA;
		color = HIGHLIGHT_FONT_COLOR;
	end
	
	return TITAN_LOOTTYPE_BUTTON_LABEL, TitanUtils_GetColoredText(lootTypeText, color);
end

function TitanPanelLootTypeButton_GetTooltipText()
	if (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
		local lootTypeText = TitanLootMethod[GetLootMethod()].text;
		local lootThreshold = GetLootThreshold();
		local itemQualityDesc = getglobal("ITEM_QUALITY"..lootThreshold.."_DESC");
		local color = ITEM_QUALITY_COLORS[lootThreshold];
		return ""..
			LOOT_METHOD..": \t"..TitanUtils_GetHighlightText(lootTypeText).."\n"..
			LOOT_THRESHOLD..": \t"..TitanUtils_GetColoredText(itemQualityDesc, color);		
	else
		return TitanUtils_GetNormalText(ERR_NOT_IN_GROUP);
	end
end

function TitanPanelRightClickMenu_PrepareLootTypeMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_LOOTTYPE_ID].menuText);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_LOOTTYPE_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_LOOTTYPE_ID);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_LOOTTYPE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end


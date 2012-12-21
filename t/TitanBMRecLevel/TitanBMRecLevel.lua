TITAN_BRL_ID =  "BRL";
TITAN_BRL_VERSION = "2.0";

function TitanPanelBRLButton_Init()
	if (myAddOnsFrame_Register) then
		myAddOnsFrame_Register( {name="TitanBMRecLevel",version=TITAN_BRL_VERSION,category=MYADDONS_CATEGORY_PLUGINS} );
	end
end
	
function TitanPanelBRLButton_OnLoad()
	this.registry = { 
		id = TITAN_BRL_ID,
		menuText = TITAN_BRL_MENU_TEXT, 
		buttonTextFunction = "TitanPanelBRLButton_GetButtonText", 
		tooltipTitle = TITAN_BRL_TOOLTIP_TITEL,
		tooltipTextFunction = "TitanPanelBRLButton_GetTooltipText", 
		category="Information",
		version=TITAN_BRL_VERSION,
		savedVariables = {
			ShowLabelText = 1,  -- Default to 1
		}
	};
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanelBRLButton_OnEvent()
	if (event == "VARIABLES_LOADED") then
		TitanPanelBRLButton_Init();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");
		this:RegisterEvent("PLAYER_LEAVING_WORLD");
		this:RegisterEvent("MINIMAP_ZONE_CHANGED");
		this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		this:RegisterEvent("PLAYER_LEVEL_UP");
		TitanPanelButton_UpdateButton(TITAN_BRL_ID);
	elseif (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("PLAYER_LEAVING_WORLD");
		this:UnregisterEvent("MINIMAP_ZONE_CHANGED");
		this:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
		this:UnregisterEvent("PLAYER_LEVEL_UP");
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
	else
		TitanPanelButton_UpdateButton(TITAN_BRL_ID);
	end
end

function TitanPanelBRLButton_GetButtonText(id)
	return TITAN_BRL_BUTTON_LABEL, BM_REC_LEVEL_BUTTON_TEXT;
end

function TitanPanelBRLButton_GetTooltipText()
	return BM_REC_LEVEL_TOOLTIP_SHORT;	
end

function TitanPanelRightClickMenu_PrepareBRLMenu()
	local info;
	local realmplayer = GetCVar("realmName") .. "|" .. UnitName("player");

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_BRL_ID].menuText);	

	info = {};
	info.text = TITAN_BRL_TOGGLE_FACTION;
	info.func = TitanPanelBRLButton_ToggleFaction;
	info.checked = BRL_CONFIG[realmplayer].show_tooltip_faction;
	UIDropDownMenu_AddButton(info); 
	
	info = {};
	info.text = TITAN_BRL_TOGGLE_INSTANCE;
	info.func = TitanPanelBRLButton_ToggleInstance;
	info.checked = BRL_CONFIG[realmplayer].show_tooltip_instance;
	UIDropDownMenu_AddButton(info); 	
	
	info = {};
	info.text = TITAN_BRL_TOGGLE_CONTINENT;
	info.func = TitanPanelBRLButton_ToggleContinent;
	info.checked = BRL_CONFIG[realmplayer].show_tooltip_continent;
	UIDropDownMenu_AddButton(info); 

	info = {};
	info.text = TITAN_BRL_TOGGLE_MAP_TEXT;
	info.func = TitanPanelBRLButton_ToggleMapText;
	info.checked = BRL_CONFIG[realmplayer].map_text_enable;
	UIDropDownMenu_AddButton(info); 

	TitanPanelRightClickMenu_AddSpacer();
	info = {};
	info.text = TITAN_BRL_OPEN_CONFIG_UI;
	info.func = BRL_UI_Panel_SlashHandler;
	info.checked = false;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_BRL_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_BRL_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelBRLButton_ToggleInstance()
	local realmplayer = GetCVar("realmName") .. "|" .. UnitName("player");
	BRL_Show_Tooltip_Instance(not BRL_CONFIG[realmplayer].show_tooltip_instance);
end

function TitanPanelBRLButton_ToggleFaction()
	local realmplayer = GetCVar("realmName") .. "|" .. UnitName("player");
	BRL_Show_Tooltip_Faction(not BRL_CONFIG[realmplayer].show_tooltip_faction);
end

function TitanPanelBRLButton_ToggleContinent()
	local realmplayer = GetCVar("realmName") .. "|" .. UnitName("player");
	BRL_Show_Tooltip_Continent(not BRL_CONFIG[realmplayer].show_tooltip_continent);
end

function TitanPanelBRLButton_ToggleMapText()
	local realmplayer = GetCVar("realmName") .. "|" .. UnitName("player");
	BRL_Map_Text_Enable(not BRL_CONFIG[realmplayer].map_text_enable);
end

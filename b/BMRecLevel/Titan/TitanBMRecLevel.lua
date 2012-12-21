TITAN_BRL_ID =  "BRL";
PLUGIN_POSITION = 0;
BRL_PLAYER_INFO = "";
--TITAN_BRL_ICON_PATH = "Interface\\Icons\\Ability_Hunter_Pathfinding";
--TITAN_BRL_ICON_PATH = "Interface\\Icons\\INV_Misc_TheGoldenCheep";
--TITAN_BRL_ICON_PATH = "Interface\\Icons\\Spell_Arcane_TeleportDarnassus";
--TITAN_BRL_ICON_PATH = "Interface\\Buttons\\UI-MicroButton-World-Up";
TITAN_BRL_ICON_PATH = "Interface\\Addons\\BMRecLevel\\BRL_Icon";

function TitanPanelBRLButton_OnLoad()
	this.registry = { 
		id = TITAN_BRL_ID,
		menuText = BMRECLEVEL_TITLE, 
		buttonTextFunction = "TitanPanelBRLButton_GetButtonText", 
		tooltipTitle = BRL_TOOPTIP_TITLE,
		--tooltipTextFunction = "TitanPanelBRLButton_GetTooltipText",
		icon = TITAN_BRL_ICON_PATH,
		iconWidth = 12,
		savedVariables = {
			ShowLabelText = 1,  -- Default to 1
			ShowIcon = 1;
		}
	};
	
	this:RegisterEvent("VARIABLES_LOADED");
	--this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("MINIMAP_ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("PLAYER_LEVEL_UP");
end

function TitanPanelBRLButton_OnEvent()
	if (event == "VARIABLES_LOADED") then
		TitanPanelButtonBRL_SetIcon();
	end
	--[[
	if (event == "PLAYER_ENTERING_WORLD") then
		BRL_PLAYER_INFO = UnitName("player") .. "@" ..  GetCVar("realmName");
	end]]
	TitanPanelButton_UpdateButton(TITAN_BRL_ID);
end

function TitanPanelBRLButton_GetButtonText(id)
	if (TitanGetVar(TITAN_BRL_ID, "ShowLabelText")) then
		local zonetext, levelrangetext  = BMRecLevel_Update_Text();
		return TitanUtils_GetNormalText(zonetext), levelrangetext;
	else
		local __, levelrangetext  = BMRecLevel_Update_Text();
		return levelrangetext;
	end
end

function TitanPanelBRLButton_GetTooltipText()
	return BM_REC_LEVEL_TOOLTIP_TEXT;	
end

function TitanPanelRightClickMenu_PrepareBRLMenu()
	local info;
	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_BRL_ID].menuText);	
	
	info = {};
	info.text = BRL_SHOW_ZONE;
	info.func = TitanPanelBRLButton_ToggleZone;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone;
	UIDropDownMenu_AddButton(info); 

	info = {};
	info.text = BRL_SHOW_TOOLTIP_FACTION;
	info.func = TitanPanelBRLButton_ToggleFaction;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction;
	UIDropDownMenu_AddButton(info); 
	
	info = {};
	info.text = BRL_SHOW_TOOLTIP_INSTANCE;
	info.func = TitanPanelBRLButton_ToggleInstance;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = BRL_SHOW_TOOLTIP_CONTINENT;
	info.func = TitanPanelBRLButton_ToggleContinent;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent;
	UIDropDownMenu_AddButton(info);
		
	TitanPanelRightClickMenu_AddSpacer();

	info = {};
	info.text = BRL_MOVABLE_FRAME_ENABLE;
	info.func = TitanPanelBRLButton_ToggleMoveableFrame;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = BRL_MAP_TEXT_ENABLE;
	info.func = TitanPanelBRLButton_ToggleMapText;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	info = {};
	info.text = BRL_SHOW_REC_INSTANCE;
	info.func = TitanPanelBRLButton_ToggleRecInstances;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = BRL_SHOW_REC_BATTLEGROUNDS;
	info.func = TitanPanelBRLButton_ToggleRecBattlegrounds;
	info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_BRL_ID);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_BRL_ID);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_BRL_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelBRLButton_ToggleZone()
	BRL_Show_Zone(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone);
	TitanPanelButton_UpdateButton(TITAN_BRL_ID);
end

function TitanPanelBRLButton_ToggleMoveableFrame()
	BRL_Show_Moveable_Frame(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame);
	TitanPanelButton_UpdateButton(TITAN_BRL_ID);
end

function TitanPanelBRLButton_ToggleInstance()
	BRL_Show_Tooltip_Instance(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance);
	TitanPanelButton_UpdateButton(TITAN_BRL_ID);
end

function TitanPanelBRLButton_ToggleFaction()
	BRL_Show_Tooltip_Faction(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction);
end

function TitanPanelBRLButton_ToggleRecInstances()
	BRL_Toogle_RecInstances(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances);
end

function TitanPanelBRLButton_ToggleRecBattlegrounds()
	BRL_Toogle_RecBattlegrounds(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds);
end

function TitanPanelBRLButton_ToggleMapText()
	BRL_Map_Text_Enable(not BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable);
end

function TitanPanelBRLButton_ToggleContinent()
	BRL_Show_Tooltip_Continent(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent);
end

function TitanPanelButtonBRL_SetIcon()
	local icon1 = TitanPanelBRLButtonIcon;
	if (TitanGetVar(TITAN_BRL_ID, "ShowIcon")) then
		icon1:SetTexture(TITAN_BRL_ICON_PATH);
		icon1:SetWidth(TitanPlugins[TITAN_BRL_ID].iconWidth);
		--icon1:SetHeight(BAG_STATUS_ICON_SIZE);
	else
		icon1:SetTexture("");
		icon1:SetWidth(1);
	end
end


--This function is in every plugin always the same except for the 2 varables
function TitanBRLButton_OnEnter()
	--[[
	local brl_tooltip_anchor = "";
	local brl_tooltip_relpoint = "";
	local plugin_position = 0;
	for key, value  in TitanSettings["Players"][BRL_PLAYER_INFO]["Panel"]["Buttons"] do			
		plugin_position = plugin_position + 1;
		if (value == TITAN_BRL_ID) then
			break;
		end
	end
	if (TitanSettings["Players"][BRL_PLAYER_INFO]["Panel"]["Location"][plugin_position] == "Bar") then
		brl_tooltip_anchor = "TOP";
		brl_tooltip_relpoint = "BOTTOM";
	else
		brl_tooltip_anchor = "BOTTOM";
		brl_tooltip_relpoint = "TOP";
	end
	]]
	GameTooltip:SetOwner(this, "ANCHOR_NONE");
	GameTooltip:SetPoint(BRL_PositonToolTip_Anchor() .. BRL_PositonToolTip_RightLeft(), this, BRL_PositonToolTip_Relpoint() .. BRL_PositonToolTip_RightLeft(), 0, 0);
	-- set the tool tip text 
	--only these two lines will change everything else is the same for all plugins
	GameTooltip:SetText(TitanUtils_GetGreenText(BRL_TOOPTIP_TITLE)); -- Usually found in localization file  TITAN_COMBATINFO_TOOLTIP="Combat Info"
	GameTooltip:AddLine(BM_REC_LEVEL_TOOLTIP_TEXT);
	--BM_Tooltip_AddTooltipText(BM_REC_LEVEL_TOOLTIP_TEXT); --The variable created by the GetTooltipText() function
	GameTooltip:Show();	
end

--This function is in every plugin always the same
function TitanBRLButton_OnLeave()
	-- put the tool tip in the default position
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:Hide();
end

function BRL_PositonToolTip_RightLeft()
	local tooltipleftright
	local ui_parent_scale = UIParent:GetScale();
	local ui_parent_width = UIParent:GetWidth()/ui_parent_scale;
	if (this:GetRight() >= (ui_parent_width/2)) then
		tooltipleftright = "RIGHT";
	else
		tooltipleftright = "LEFT";
	end
	return tooltipleftright;
end

function BRL_PositonToolTip_Anchor()
	local tooltipanchor;
	local ui_parent_scale = UIParent:GetScale();
	local ui_parent_height = UIParent:GetHeight()/ui_parent_scale;
	if (this:GetTop() >= (ui_parent_height/2)) then
		tooltipanchor = "TOP";
	else
		tooltipanchor = "BOTTOM";
	end
	return tooltipanchor;
end

function BRL_PositonToolTip_Relpoint()
	local tooltiprelpoint;
	local ui_parent_scale = UIParent:GetScale();
	local ui_parent_height = UIParent:GetHeight()/ui_parent_scale;
	if (this:GetTop() >= (ui_parent_height/2)) then
		tooltiprelpoint = "BOTTOM";
	else
		tooltiprelpoint = "TOP";
	end
	return tooltiprelpoint;
end
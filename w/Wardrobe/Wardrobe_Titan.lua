-- TitanWardrobe 1.0

local function TEXT(key) return Localization.GetString("Wardrobe", key) end

WARDROBE_TITAN_ID 						= "Wardrobe";

function Wardrobe.TitanPanelButton_OnLoad()
	
	if ( IsAddOnLoaded("Titan") ) then
		-- register the plugin
		this.registry = {
			id = WARDROBE_TITAN_ID,
			menuText = WARDROBE_TITAN_ID,
			buttonTextFunction = "Wardrobe_TitanPanelButton_GetButtonText",
			--tooltipTitle = TEXT("TITAN_BUTTON_TEXT"),
			--tooltipTextFunction = "Wardrobe_TitanPanelButton_GetTooltipText",
			icon = "Interface\\AddOns\\Wardrobe\\Images\\WardrobeTitan",
			iconWidth = 16,
			savedVariables = {
				ShowMinimapIcon = 1,
				ShowIcon = 1,
				ShowLabelText = TITAN_NIL,
			}
		};
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
		if (Chronos) then
			this:RegisterEvent("UNIT_INVENTORY_CHANGED");
		else
			this.registry.frequency = 1;
		end
		
		TitanPanelButton_OnLoad();
	end
end

function Wardrobe.TitanPanelButton_OnEvent(event)
	if (event == "UNIT_INVENTORY_CHANGED") then
		Chronos.scheduleByName("WardrobeTitanUpdate", .2, function() TitanPanelButton_UpdateButton(WARDROBE_TITAN_ID) end);
	elseif (event == "PLAYER_ENTERING_WORLD") then
		Wardrobe.enteredWorld = true;
		Wardrobe.CheckForOurWardrobeID();
		Wardrobe.TitanUpdateMinimapStatus();
	end
end

function Wardrobe.TitanPanelButton_GetButtonText(id)

	local labelText = nil;

	-- display the label if the user has selected
	if (TitanGetVar(WARDROBE_TITAN_ID, "ShowLabelText")) then
		labelText = TEXT("TITAN_BUTTON_TEXT");
	end
	
	-- get any active outfits
	local outfitText = Wardrobe.GetActiveOutfitsTextList();
	
	-- show / hide the minimap icon
	if (Wardrobe.enteredWorld) then
		Wardrobe.TitanUpdateMinimapStatus();
	end
	
	return labelText, outfitText;
end
Wardrobe_TitanPanelButton_GetButtonText = Wardrobe.TitanPanelButton_GetButtonText;

function Wardrobe.TitanUpdateMinimapStatus(elseShow)
	if (TitanGetVar) then
		if (TitanGetVar(WARDROBE_TITAN_ID, "ShowMinimapIcon")) then
			Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 1;
			Wardrobe.IconFrame:Show();
		else
			Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 0;
			Wardrobe.IconFrame:Hide();
		end
	else
		if (elseShow) then
			Wardrobe.IconFrame:Show();
		else
			Wardrobe.IconFrame:Hide();
		end
	end
end

function Wardrobe.TitanPanelButton_GetTooltipText()
	return TEXT("TITAN_TOOLTIP_TEXT");
end
Wardrobe_TitanPanelButton_GetTooltipText = Wardrobe.TitanPanelButton_GetTooltipText;

function TitanPanelRightClickMenu_PrepareWardrobeMenu()

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[WARDROBE_TITAN_ID].menuText);
	
	-- show the "hide minimap icon"
	TitanPanelRightClickMenu_AddToggleVar(TEXT("TITAN_MENU_SHOW_MINIMAP_ICON"), WARDROBE_TITAN_ID, "ShowMinimapIcon");
	
	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleIcon(WARDROBE_TITAN_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(WARDROBE_TITAN_ID);

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, WARDROBE_TITAN_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function Wardrobe.TitanPanelButton_OnClick(button)
	-- show the wardrobe menu on left clicks, options on right clicks
	if ( button == "LeftButton" ) then
		local position = TitanUtils_GetRealPosition(WARDROBE_TITAN_ID);
		--local horizOffset = -( DropDownList1:GetWidth()-TitanPanelWardrobeButton:GetWidth() )/2;
		if (position == TITAN_PANEL_PLACE_TOP) then
			ToggleDropDownMenu(1, nil, WardrobeDropDown, "TitanPanelWardrobeButton", -15, 0, "TOPLEFT");
		else
			ToggleDropDownMenu(1, nil, WardrobeDropDown, "TitanPanelWardrobeButton", -15, 0, "BOTTOMLEFT");
		end
	else
		TitanPanelButton_OnClick(button, 1);
	end
end

function Wardrobe.TitanPanelButton_OnEnter()
	if (Wardrobe_Config.MustClickUIButton) then
		TitanPanelButton_OnEnter();
	else
		if (not DropDownList1:IsVisible()) then
			Wardrobe.TitanPanelButton_OnClick("LeftButton");
		end
	end
end


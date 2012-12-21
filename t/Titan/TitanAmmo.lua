TITAN_AMMO_ID = "Ammo";
TITAN_AMMO_THRESHOLD_TABLE = {
	Values = { 150, 400 },
	Colors = { RED_FONT_COLOR, NORMAL_FONT_COLOR, GREEN_FONT_COLOR },
}

function TitanPanelAmmoButton_OnLoad()
	this.registry = {
		id = TITAN_AMMO_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_AMMO_MENU_TEXT,
		buttonTextFunction = "TitanPanelAmmoButton_GetButtonText", 
		tooltipTitle = TITAN_AMMO_TOOLTIP, 
		icon = TITAN_ARTWORK_PATH.."TitanThrown",	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
		}
	};	

	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
end

function TitanPanelAmmoButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_AMMO_ID);		
end

function TitanPanelAmmoButton_GetButtonText(id)
	local ammoSlotID = GetInventorySlotInfo("ammoSlot");
	local rangedSlotID = GetInventorySlotInfo("rangedSlot");

	local isThrown, isAmmo;
	if (GetInventoryItemQuality("player", rangedSlotID) and
			string.find(GetInventoryItemLink("player", rangedSlotID), TITAN_AMMO_THROWN_KEYWORD)) then
		isThrown = 1;
	end
	if (not isThrown and GetInventoryItemQuality("player", ammoSlotID)) then
		isAmmo = 1;
	end
	
	local count, labelText, ammoText, ammoRichText, color;
	if (isThrown) then
		count = GetInventoryItemCount("player", rangedSlotID);
		labelText = TITAN_AMMO_BUTTON_LABEL_THROWN;
		ammoText = format(TITAN_AMMO_FORMAT, count);
	elseif (isAmmo) then
		count = GetInventoryItemCount("player", ammoSlotID);
		labelText = TITAN_AMMO_BUTTON_LABEL_AMMO;
		ammoText = format(TITAN_AMMO_FORMAT, count);
	else
		count = 0;
		labelText = TITAN_AMMO_BUTTON_LABEL_AMMO_THROWN;
		ammoText = format(TITAN_AMMO_FORMAT, count);
	end
	
	if ( TitanGetVar(TITAN_AMMO_ID, "ShowColoredText") ) then	
		color = TitanUtils_GetThresholdColor(TITAN_AMMO_THRESHOLD_TABLE, count);
		ammoRichText = TitanUtils_GetColoredText(ammoText, color);
	else
		ammoRichText = TitanUtils_GetHighlightText(ammoText);
	end

	return labelText, ammoRichText;
end

function TitanPanelRightClickMenu_PrepareAmmoMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AMMO_ID].menuText);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_AMMO_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_AMMO_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_AMMO_ID);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_AMMO_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end


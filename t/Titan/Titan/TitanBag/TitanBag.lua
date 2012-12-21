TITAN_BAG_ID = "Bag";
TITAN_BAG_THRESHOLD_TABLE = {
	Values = { 0.5, 0.75 },
	Colors = { GREEN_FONT_COLOR, NORMAL_FONT_COLOR, RED_FONT_COLOR },
}

function TitanPanelBagButton_OnLoad()
	this.registry = {
		id = TITAN_BAG_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_BAG_MENU_TEXT,
		buttonTextFunction = "TitanPanelBagButton_GetButtonText", 
		tooltipTitle = TITAN_BAG_TOOLTIP, 
		tooltipTextFunction = "TitanPanelBagButton_GetTooltipText", 
		icon = TITAN_ARTWORK_PATH.."TitanBag",	
		iconWidth = 16,
		savedVariables = {
			ShowUsedSlots = 1,
			CountAmmoPouchSlots = TITAN_NIL,
			CountShardBagSlots = TITAN_NIL,
			CountProfBagSlots = TITAN_NIL,
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
		}
	};	

 	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanelBagButton_OnEvent()
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("BAG_UPDATE");
		this:UnregisterEvent("ITEM_LOCK_CHANGED");
		this:UnregisterEvent("UNIT_MODEL_CHANGED");
	end

	if (event == "PLAYER_ENTERING_WORLD") then
		this:RegisterEvent("BAG_UPDATE");
		this:RegisterEvent("ITEM_LOCK_CHANGED");
		this:RegisterEvent("UNIT_MODEL_CHANGED");
	end

	TitanPanelButton_UpdateButton(TITAN_BAG_ID);		
end

function TitanPanelBagButton_OnClick(button)
	if (button == "LeftButton") then
		OpenAllBags();
	end
end

function TitanPanelBagButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local totalSlots, usedSlosts, availableSlots;
	local useme;
	
	totalSlots = 0;
	usedSlots = 0;
	for bag = 0, 4 do
		if TitanGetVar(TITAN_BAG_ID, "CountAmmoPouchSlots") and TitanBag_IsAmmoPouch(GetBagName(bag)) then
			useme = 1;
		elseif TitanGetVar(TITAN_BAG_ID, "CountShardBagSlots") and TitanBag_IsShardBag(GetBagName(bag)) then
			useme = 1;
		elseif TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots") and TitanBag_IsProfBag(GetBagName(bag)) then
			useme = 1;
		elseif not TitanBag_IsAmmoPouch(GetBagName(bag)) and not TitanBag_IsShardBag(GetBagName(bag)) and not TitanBag_IsProfBag(GetBagName(bag)) then
			useme = 1;
		else
			useme = 0;
		end

		if useme == 1 then
			local size = GetContainerNumSlots(bag);
			if (size and size > 0) then
				totalSlots = totalSlots + size;
				for slot = 1, size do
					if (GetContainerItemInfo(bag, slot)) then
						usedSlots = usedSlots + 1;
					end
				end
			end
		end
	end
	availableSlots = totalSlots - usedSlots;

	local bagText, bagRichText, color;
	if (TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots")) then
		bagText = format(TITAN_BAG_FORMAT, usedSlots, totalSlots);
	else
		bagText = format(TITAN_BAG_FORMAT, availableSlots, totalSlots);
	end
	
	if ( TitanGetVar(TITAN_BAG_ID, "ShowColoredText") ) then	
		color = TitanUtils_GetThresholdColor(TITAN_BAG_THRESHOLD_TABLE, usedSlots / totalSlots);
		bagRichText = TitanUtils_GetColoredText(bagText, color);
	else
		bagRichText = TitanUtils_GetHighlightText(bagText);
	end

	return TITAN_BAG_BUTTON_LABEL, bagRichText;
end

function TitanPanelBagButton_GetTooltipText()
	return TitanUtils_GetGreenText(TITAN_BAG_TOOLTIP_HINTS);
end

function TitanPanelRightClickMenu_PrepareBagMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_BAG_ID].menuText);
	
	local info = {};
	info.text = TITAN_BAG_MENU_SHOW_USED_SLOTS;
	info.func = TitanPanelBagButton_ShowUsedSlots;
	info.checked = TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_BAG_MENU_SHOW_AVAILABLE_SLOTS;
	info.func = TitanPanelBagButton_ShowAvailableSlots;
	info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "ShowUsedSlots"));
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();	
	
	info = {};
	info.text = TITAN_BAG_MENU_IGNORE_AMMO_POUCH_SLOTS;
	info.func = TitanPanelBagButton_ToggleIgnoreAmmoPouchSlots;
	info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountAmmoPouchSlots"));
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_BAG_MENU_IGNORE_SHARD_BAGS_SLOTS;
	info.func = TitanPanelBagButton_ToggleIgnoreShardBagSlots;
	info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountShardBagSlots"));
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_BAG_MENU_IGNORE_PROF_BAGS_SLOTS;
	info.func = TitanPanelBagButton_ToggleIgnoreProfBagSlots;
	info.checked = TitanUtils_Toggle(TitanGetVar(TITAN_BAG_ID, "CountProfBagSlots"));
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_BAG_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_BAG_ID);
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_BAG_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelBagButton_ShowUsedSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", 1);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

function TitanPanelBagButton_ShowAvailableSlots()
	TitanSetVar(TITAN_BAG_ID, "ShowUsedSlots", nil);
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

function TitanPanelBagButton_ToggleIgnoreAmmoPouchSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountAmmoPouchSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

function TitanPanelBagButton_ToggleIgnoreShardBagSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountShardBagSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

function TitanPanelBagButton_ToggleIgnoreProfdBagSlots()
	TitanToggleVar(TITAN_BAG_ID, "CountProfBagSlots");
	TitanPanelButton_UpdateButton(TITAN_BAG_ID);
end

function TitanBag_IsAmmoPouch(name)	
	if (name) then
		for index, value in TITAN_BAG_AMMO_POUCH_NAMES do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end

function TitanBag_IsShardBag(name)	
	if (name) then
		for index, value in TITAN_BAG_SHARD_BAG_NAMES do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end

function TitanBag_IsProfBag(name)	
	if (name) then
		for index, value in TITAN_BAG_PROF_BAG_NAMES do
			if (string.find(name, value)) then
				return true;
			end
		end
	end
	return false;
end
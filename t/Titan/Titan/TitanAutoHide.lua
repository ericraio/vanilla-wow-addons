TITAN_AUTOHIDE_ID = "AutoHide";

function TitanPanelAutoHideButton_OnLoad()
	this.registry = {
		id = TITAN_AUTOHIDE_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_AUTOHIDE_MENU_TEXT, 
		tooltipTitle = TITAN_AUTOHIDE_TOOLTIP, 
	};
end

function TitanPanelAutoHideButton_OnShow()
	TitanPanelAutoHideButton_SetIcon();
end

function TitanPanelAutoHideButton_OnClick(button)
	if (button == "LeftButton") then
		TitanPanelBarButton_ToggleAutoHide();
	end
end

function TitanPanelAutoHideButton_SetIcon()
	local icon = TitanPanelAutoHideButtonIcon;
	if (TitanPanelGetVar("AutoHide")) then
		icon:SetTexture(TITAN_ARTWORK_PATH.."TitanPanelPushpinOut");
	else
		icon:SetTexture(TITAN_ARTWORK_PATH.."TitanPanelPushpinIn");
	end	
end

function TitanPanelRightClickMenu_PrepareAutoHideMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AUTOHIDE_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_AUTOHIDE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

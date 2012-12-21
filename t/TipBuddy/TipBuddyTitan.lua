-- Titan Panel support

function TitanPanelTipBuddyIcon_OnLoad()	
	this:RegisterEvent("PLAYER_LOGIN");

	this.registry = {
		id = TIPBUDDYTITAN,
		menuText = TIPBUDDYTITLE,
		version = TIPBUDDY_VERSION,
		category = "Interface",
		icon = "Interface\\Cursor\\Cast",
		iconWidth = 16,
		tooltipTitle = TIPBUDDYTITLE,
		tooltipTextFunction = "TitanPanelTipBuddyIcon_GetTooltipText",
		savedVariables = {
			ShowIcon = 1,
		}
	};
end

function TitanPanelTipBuddyIcon_OnClick(button)
	TipBuddy_ToggleOptionsFrame();
end

function TitanPanelTipBuddyIcon_OnEvent()
	if( event == "PLAYER_LOGIN" ) then	
		if (not TitanPanelButton_UpdateButton) then
			return;
		end
		TB_AddMessage("---------------------------------------------------loading titan");
		TitanPanelButton_OnLoad();
		TitanPanelButton_UpdateButton(TIPBUDDYTITAN);
	end
end

function TitanPanelTipBuddyIcon_GetTooltipText()
	--local text = TB_MENU_BUTTON_TOOLTIP.."\n";
	return TB_MENU_BUTTON_TOOLTIP;
end


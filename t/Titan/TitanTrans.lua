TITAN_TRANS_ID = "Trans";
TITAN_TRANS_FRAME_SHOW_TIME = 0.5;

function TitanPanelTransButton_OnLoad()
	this.registry = {
		id = TITAN_TRANS_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_TRANS_MENU_TEXT, 
		tooltipTitle = TITAN_TRANS_TOOLTIP, 
		tooltipTextFunction = "TitanPanelTransButton_GetTooltipText", 
		icon = TITAN_ARTWORK_PATH.."TitanPanelTrans",
	};
end

function TitanPanelTransButton_GetTooltipText()
	local transText = TitanPanelTrans_GetAlphaText(TitanPanelGetVar("Transparency"));
	return ""..
		TITAN_TRANS_TOOLTIP_VALUE.."\t"..TitanUtils_GetHighlightText(transText).."\n"..
		TitanUtils_GetGreenText(TITAN_TRANS_TOOLTIP_HINT1).."\n"..
		TitanUtils_GetGreenText(TITAN_TRANS_TOOLTIP_HINT2);
end

function TitanPanelTransControlSlider_OnEnter()
	this.tooltipText = TitanOptionSlider_TooltipText(TITAN_TRANS_CONTROL_TOOLTIP, TitanPanelTrans_GetAlphaText(TitanPanelGetVar("Transparency")));
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(this:GetParent());
end

function TitanPanelTransControlSlider_OnLeave()
	this.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(this:GetParent(), TITAN_TRANS_FRAME_SHOW_TIME);
end

function TitanPanelTransControlSlider_OnShow()	
	getglobal(this:GetName().."Text"):SetText(TitanPanelTrans_GetAlphaText(TitanPanelGetVar("Transparency")));
	getglobal(this:GetName().."High"):SetText(TITAN_TRANS_CONTROL_LOW);
	getglobal(this:GetName().."Low"):SetText(TITAN_TRANS_CONTROL_HIGH);
	this:SetMinMaxValues(0, 1);
	this:SetValueStep(0.01);
	this:SetValue(1 - TitanPanelGetVar("Transparency"));

	position = TitanUtils_GetRealPosition(TITAN_TRANS_ID);
	
	TitanPanelTransControlFrame:SetPoint("BOTTOMRIGHT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_TRANS_ID) .."Button", "TOPRIGHT", 0, 0);
	if (position == TITAN_PANEL_PLACE_TOP) then 
		TitanPanelTransControlFrame:ClearAllPoints();
		TitanPanelTransControlFrame:SetPoint("TOPLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_TRANS_ID) .."Button", "BOTTOMLEFT", UIParent:GetRight() - TitanPanelTransControlFrame:GetWidth(), -4);
	else
		TitanPanelTransControlFrame:ClearAllPoints();
		TitanPanelTransControlFrame:SetPoint("BOTTOMLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_TRANS_ID) .."Button", "TOPLEFT", UIParent:GetRight() - TitanPanelTransControlFrame:GetWidth(), 0);
	end		

end

function TitanPanelTransControlSlider_OnValueChanged()
	getglobal(this:GetName().."Text"):SetText(TitanPanelTrans_GetAlphaText(1 - this:GetValue()));
	TitanPanelBarButton:SetAlpha(1 - this:GetValue());
	TitanPanelAuxBarButton:SetAlpha(1 - this:GetValue());
	TitanPanelSetVar("Transparency", 1 - this:GetValue());
	
	-- Update GameTooltip
	if (this.tooltipText) then
		this.tooltipText = TitanOptionSlider_TooltipText(TITAN_TRANS_CONTROL_TOOLTIP, TitanPanelTrans_GetAlphaText(1 - this:GetValue()));
		GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelTrans_GetAlphaText(alpha)
	return tostring(floor(100 * alpha + 0.5)) .. "%";
end

function TitanPanelTransControlFrame_OnLoad()
	getglobal(this:GetName().."Title"):SetText(TITAN_TRANS_CONTROL_TITLE);
	this:SetBackdropBorderColor(1, 1, 1);
	this:SetBackdropColor(0, 0, 0, 1);
end

-- If dropdown is visible then see if its timer has expired, if so hide the frame
function TitanPanelTransControlFrame_OnUpdate(elapsed)
	TitanUtils_CheckFrameCounting(this, elapsed);
end

function TitanPanelRightClickMenu_PrepareTransMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_TRANS_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_TRANS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

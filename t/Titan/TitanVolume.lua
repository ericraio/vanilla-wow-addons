TITAN_VOLUME_ID = "Volume";
TITAN_VOLUME_FRAME_SHOW_TIME = 0.5;

function TitanPanelVolumeButton_OnLoad()
	this.registry = { 
		id = TITAN_VOLUME_ID,
		builtIn = 1,
		version = TITAN_VERSION,
		menuText = TITAN_VOLUME_MENU_TEXT, 
		tooltipTitle = TITAN_VOLUME_TOOLTIP, 
		tooltipTextFunction = "TitanPanelVolumeButton_GetTooltipText",
		iconWidth = 32,
		iconButtonWidth = 18,
	};
end

function TitanPanelVolumeButton_OnShow()
	TitanPanelVolume_SetVolumeIcon();
end

function TitanPanelVolumeButton_OnEnter()
	-- Confirm master volume value
	TitanPanelVolumeControlSlider:SetValue(1 - GetCVar("MasterVolume"));
	TitanPanelVolume_SetVolumeIcon();
end

function TitanPanelVolumeControlSlider_OnEnter()
	this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME_CONTROL_TOOLTIP, TitanPanelVolume_GetVolumeText(GetCVar("MasterVolume")));
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(this:GetParent());
end

function TitanPanelVolumeControlSlider_OnLeave()
	this.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(this:GetParent(), TITAN_VOLUME_FRAME_SHOW_TIME);
end

function TitanPanelVolumeControlSlider_OnShow()
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume_GetVolumeText(GetCVar("MasterVolume")));
	getglobal(this:GetName().."High"):SetText(TITAN_VOLUME_CONTROL_LOW);
	getglobal(this:GetName().."Low"):SetText(TITAN_VOLUME_CONTROL_HIGH);
	this:SetMinMaxValues(0, 1);
	this:SetValueStep(0.01);
	this:SetValue(1 - GetCVar("MasterVolume"));

	position = TitanUtils_GetRealPosition(TITAN_VOLUME_ID);
	
	TitanPanelVolumeControlFrame:SetPoint("BOTTOMRIGHT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_VOLUME_ID) .."Button", "TOPRIGHT", 0, 0);
	if (position == TITAN_PANEL_PLACE_TOP) then 
		TitanPanelVolumeControlFrame:ClearAllPoints();
		TitanPanelVolumeControlFrame:SetPoint("TOPLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_VOLUME_ID) .."Button", "BOTTOMLEFT", UIParent:GetRight() - TitanPanelVolumeControlFrame:GetWidth(), -4);
	else
		TitanPanelVolumeControlFrame:ClearAllPoints();
		TitanPanelVolumeControlFrame:SetPoint("BOTTOMLEFT", "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_VOLUME_ID) .."Button", "TOPLEFT", UIParent:GetRight() - TitanPanelVolumeControlFrame:GetWidth(), 0);
	end		

end

function TitanPanelVolumeControlSlider_OnValueChanged()
	SetCVar("MasterVolume", 1 - this:GetValue());
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume_GetVolumeText(GetCVar("MasterVolume")));
	TitanPanelVolume_SetVolumeIcon();

	-- Update GameTooltip
	if (this.tooltipText) then
		this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME_CONTROL_TOOLTIP, TitanPanelVolume_GetVolumeText(GetCVar("MasterVolume")));
		GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	end
end

function TitanPanelVolume_GetVolumeText(volume)
	return tostring(floor(100 * volume + 0.5)) .. "%";
end

function TitanPanelVolumeControlFrame_OnLoad()
	getglobal(this:GetName().."Title"):SetText(TITAN_VOLUME_CONTROL_TITLE);
	this:SetBackdropBorderColor(1, 1, 1);
	this:SetBackdropColor(0, 0, 0, 1);
end

function TitanPanelVolumeControlFrame_OnUpdate(elapsed)
	TitanUtils_CheckFrameCounting(this, elapsed);
end

function TitanPanelVolume_SetVolumeIcon()
	local icon = getglobal("TitanPanelVolumeButtonIcon");
	local masterVolume = tonumber(GetCVar("MasterVolume"));
	if (masterVolume <= 0) then
		icon:SetTexture(TITAN_ARTWORK_PATH.."TitanVolumeMute");
	elseif (masterVolume < 0.33) then
		icon:SetTexture(TITAN_ARTWORK_PATH.."TitanVolumeLow");
	elseif (masterVolume < 0.66) then
		icon:SetTexture(TITAN_ARTWORK_PATH.."TitanVolumeMedium");
	else
		icon:SetTexture(TITAN_ARTWORK_PATH.."TitanVolumeHigh");
	end	
end

function TitanPanelVolumeButton_GetTooltipText()
	local volumeText = TitanPanelVolume_GetVolumeText(GetCVar("MasterVolume"));
	return ""..
		TITAN_VOLUME_TOOLTIP_VALUE.."\t"..TitanUtils_GetHighlightText(volumeText).."\n"..
		TitanUtils_GetGreenText(TITAN_VOLUME_TOOLTIP_HINT1).."\n"..
		TitanUtils_GetGreenText(TITAN_VOLUME_TOOLTIP_HINT2);
end

function TitanPanelRightClickMenu_PrepareVolumeMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_VOLUME_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_VOLUME_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

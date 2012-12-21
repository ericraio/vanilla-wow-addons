function AtlasOptions_Toggle()
	if(AtlasOptionsFrame:IsVisible()) then
		AtlasOptionsFrame:Hide();
	else
		AtlasOptionsFrame:Show();
	end
end

function AtlasOptions_AutoSelectToggle()
	if(AtlasOptions.AtlasAutoSelect) then
		AtlasOptions.AtlasAutoSelect = false;
	else
		AtlasOptions.AtlasAutoSelect = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_ReplaceWorldMapToggle()
	if(AtlasOptions.AtlasReplaceWorldMap) then
		AtlasOptions.AtlasReplaceWorldMap = false;
	else
		AtlasOptions.AtlasReplaceWorldMap = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_RightClickToggle()
	if(AtlasOptions.AtlasRightClick) then
		AtlasOptions.AtlasRightClick = false;
	else
		AtlasOptions.AtlasRightClick = true;
	end
	AtlasOptions_Init();
end

function AtlasOptions_MapNameToggle()
	if(AtlasOptions.AtlasMapName) then
		AtlasOptions.AtlasMapName = false;
	else
		AtlasOptions.AtlasMapName = true;
	end
end

function AtlasOptions_AcronymsToggle()
	if(AtlasOptions.AtlasAcronyms) then
		AtlasOptions.AtlasAcronyms = false;
	else
		AtlasOptions.AtlasAcronyms = true;
	end
	AtlasOptions_Init();
	Atlas_Refresh();
end

function AtlasOptions_OnLoad()
	UIPanelWindows['AtlasOptionsFrame'] = {area = 'center', pushable = 0};
end

function AtlasOptions_Init()
	AtlasOptionsFrameToggleButton:SetChecked(AtlasOptions.AtlasButtonShown);
	AtlasOptionsFrameAutoSelect:SetChecked(AtlasOptions.AtlasAutoSelect);
	AtlasOptionsFrameReplaceWorldMap:SetChecked(AtlasOptions.AtlasReplaceWorldMap);
	AtlasOptionsFrameRightClick:SetChecked(AtlasOptions.AtlasRightClick);
	AtlasOptionsFrameAcronyms:SetChecked(AtlasOptions.AtlasAcronyms);
	SliderButtonPos:SetValue(AtlasOptions.AtlasButtonPosition);
	SliderAlpha:SetValue(AtlasOptions.AtlasAlpha);
end

function AtlasOptions_ResetPosition()
	AtlasFrame:SetPoint("TOPLEFT", 0, -104);
end



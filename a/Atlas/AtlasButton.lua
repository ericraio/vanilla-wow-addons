function AtlasButton_OnClick()
	Atlas_Toggle();
end

function AtlasButton_Init()
	if(AtlasOptions.AtlasButtonShown) then
		AtlasButtonFrame:Show();
	else
		AtlasButtonFrame:Hide();
	end
end

function AtlasButton_Toggle()
	if(AtlasButtonFrame:IsVisible()) then
		AtlasButtonFrame:Hide();
		AtlasOptions.AtlasButtonShown = false;
	else
		AtlasButtonFrame:Show();
		AtlasOptions.AtlasButtonShown = true;
	end
	AtlasOptions_Init();
end

function AtlasButton_UpdatePosition()
	AtlasButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(AtlasOptions.AtlasButtonPosition)),
		(78 * sin(AtlasOptions.AtlasButtonPosition)) - 55
	);
	AtlasOptions_Init();
end

-- Thanks to Yatlas for this code
function AtlasButton_BeingDragged()
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    AtlasButton_SetPosition(math.deg(math.atan2(ypos,xpos)));
end

function AtlasButton_SetPosition(v)
    if(v < 0) then
        v = v + 360;
    end

    AtlasOptions.AtlasButtonPosition = v;
    AtlasButton_UpdatePosition();
end

function AtlasButton_OnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText(ATLAS_BUTTON_TOOLTIP);
    GameTooltip:AddLine(ATLAS_BUTTON_TOOLTIP2);
    GameTooltip:AddLine(ATLAS_BUTTON_TOOLTIP3);
    GameTooltip:Show();
end
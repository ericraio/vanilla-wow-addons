

function YatlasButton_OnEvent(event) 
    if(event == "VARIABLES_LOADED") then
        YatlasOptionsButtonSlider:SetValue(YatlasOptions.ButtonLocation);
        YatlasButton_Update();
    end
end

function YatlasButton_Update()
    if(YatlasOptions.ShowButton) then
        YatlasButtonFrame:SetPoint(
            "TOPLEFT", "Minimap", "TOPLEFT",
            54 - (78 * cos(YatlasOptions.ButtonLocation)),
            (78 * sin(YatlasOptions.ButtonLocation)) - 55);
        YatlasButtonFrame:Show();
    else
        YatlasButtonFrame:Hide();
    end
end

function YatlasButton_BeingDragged()
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    YatlasButton_SetPosition(math.deg(math.atan2(ypos,xpos)));
end

function YatlasButton_OnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText(YATLAS_BUTTON_TOOLTIP1);
    GameTooltip:AddLine(YATLAS_BUTTON_TOOLTIP2);
    GameTooltip:AddLine(YATLAS_BUTTON_TOOLTIP3);
    GameTooltip:Show();
end

function YatlasButton_SetPosition(v)
    if(v < 0) then
        v = v + 360;
    end
    if(v == YatlasOptions.ButtonLocation) then
        return;
    end

    YatlasOptionsButtonSlider:SetValue(YatlasOptions.ButtonLocation);

    YatlasOptions.ButtonLocation = v;
    YatlasButton_Update()
end

function YatlasButton_GetPosition()
    return YatlasOptions.ButtonLocation;
end


function YatlasButton_OnClick()
    YatlasFrame:Toggle();
end

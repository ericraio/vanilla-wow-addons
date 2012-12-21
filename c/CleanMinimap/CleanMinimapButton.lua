--[[
    CleanMinimap Minimap button handler.
    
    $Id: CleanMinimapButton.lua 61 2005-08-27 18:02:21Z joev $
--]]


function CleanMinimapButton_OnClick(button)
    if (button == "RightButton") then
        -- Do Dropdown menu
    else
      CleanMinimapOptions_Toggle();
    end
end

function CleanMinimapButton_Toggle()
    CleanMinimapConfig[CleanMinimap_player].showButton = not CleanMinimapConfig[CleanMinimap_player].showButton;
    if (CleanMinimapConfig[CleanMinimap_player].showButton) then
            CleanMinimapButtonFrame:Show();
    else
            CleanMinimapButtonFrame:Hide();
    end
end

function CleanMinimapButton_UpdatePosition()
    CleanMinimapButtonFrame:SetPoint(
        "TOPLEFT",
        "Minimap",
        "TOPLEFT",
        52 - (80 * cos(CleanMinimapConfig[CleanMinimap_player].buttonPos)),
        (80 * sin(CleanMinimapConfig[CleanMinimap_player].buttonPos)) - 52
    );
end

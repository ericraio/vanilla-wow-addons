--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerTitan.lua
--
-- Logic for interacting with Titan
--===========================================================================--

LT_TITAN_ID             = "LootTracker";
LT_TITAN_MENU_TEXT      = "LootTracker";
LT_TITAN_TOOLTIP_TITLE  = "Loot Tracker Summary";


------------------------------------------------------------------------------
-- LT_Titan_ButtonOnLoad
-- Initialize our Titan button
------------------------------------------------------------------------------

function LT_Titan_ButtonOnLoad()

    this.registry = {
        id                  = LT_TITAN_ID,
        menuText            = LT_TITAN_MENU_TEXT,
        buttonTextFunction  = "LT_Titan_GetButtonText",
        tooltipTitle        = LT_TITAN_TOOLTIP_TITLE,
        tooltipTextFunction = "LT_Titan_GetTooltipText",
    };

    -- Listen for change events on the data source
    LT_AddListener(LT_Titan_DataChanged);

end


------------------------------------------------------------------------------
-- LT_Titan_ButtonOnClick
-- Respond to our Titan button's click event
------------------------------------------------------------------------------

function LT_Titan_ButtonOnClick(button)

    if (button == "LeftButton") then

        if (LT_SettingsUI:IsShown()) then
            HideUIPanel(LT_SettingsUI);
        else
            ShowUIPanel(LT_SettingsUI);
        end

    elseif (button == "RightButton") then

        LT_NextTooltipMode();

    end

end


------------------------------------------------------------------------------
-- LT_Titan_GetButtonText
-- Get the text to display on our Titan button
------------------------------------------------------------------------------

function LT_Titan_GetButtonText(id)

    return LT_GetToolbarSummary();

end


------------------------------------------------------------------------------
-- LT_Titan_GetTooltipText
-- Get the text to display when the user hovers over our Titan button
------------------------------------------------------------------------------

function LT_Titan_GetTooltipText()

    return LT_GetTooltipSummary();

end


------------------------------------------------------------------------------
-- LT_Titan_DataChanged
-- The data source has changed in some way.  Refresh our dependant controls.
------------------------------------------------------------------------------

function LT_Titan_DataChanged()

    if (getglobal("TitanPanelButton_UpdateButton") ~= nil) then

        TitanPanelButton_UpdateButton(LT_TITAN_ID);
        TitanPanelButton_UpdateTooltip();

    end

end


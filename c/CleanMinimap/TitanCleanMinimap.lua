--[[
  CleanMinimap TitanPanel support.
  
  $Id: TitanCleanMinimap.lua 69 2005-08-28 16:05:53Z joev $
--]]
TITAN_CLEANMINIMAP_ID = "CleanMinimap";
TITAN_CLEANMINIMAP_ARTWORK_PATH = "Interface\\AddOns\\CleanMinimap\\Artwork\\";
TITAN_CLEANMINIMAP_MENU_TEXT = CMMSTRINGS.appName;

TITAN_CLEANMINIMAP_TOOLTIP_ALPHA_VALUE = CMMSTRINGS.opacity.." "..CMMSTRINGS.is..": ";
TITAN_CLEANMINIMAP_TOOLTIP_SIZE_VALUE = CMMSTRINGS.size.." "..CMMSTRINGS.is..": ";
TITAN_CLEANMINIMAP_TOOLTIP_STATUS = "Minimap "..CMMSTRINGS.is..": ";
TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS = CMMSTRINGS.appName.." "..CMMSTRINGS.is..": ";
TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_TITLE = CMMSTRINGS.titlebar.." "..CMMSTRINGS.is..": ";
TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_CLOCK = CMMSTRINGS.clock.." "..CMMSTRINGS.is..": ";
TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_ZOOM = CMMSTRINGS.zoomButtons.." "..CMMSTRINGS.are..": ";
TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_NSEW = CMMSTRINGS.nsewIndicators.." "..CMMSTRINGS.are..": ";

TITAN_CLEANMINIMAP_MENU_ENABLE_MM = CMMSTRINGS.options.enableMinimap;
TITAN_CLEANMINIMAP_MENU_ENABLE_CMM = CMMSTRINGS.options.enableCleanMinimap;
TITAN_CLEANMINIMAP_MENU_SHOW_CLOCK = CMMSTRINGS.options.showClockButton;
TITAN_CLEANMINIMAP_MENU_SHOW_TITLE = CMMSTRINGS.options.showTitleButton;
TITAN_CLEANMINIMAP_MENU_SHOW_ZOOM = CMMSTRINGS.options.showZoomButton;
TITAN_CLEANMINIMAP_MENU_SHOW_NSEW = CMMSTRINGS.options.showNSEWButton;
TITAN_CLEANMINIMAP_MENU_OPTIONS = CMMSTRINGS.options.title.."...";
TITAN_CLEANMINIMAP_MENU_MOVE = CMMSTRINGS.move;

TITAN_CLEANMINIMAP_TOOLTIP_HINT1 = CMMSTRINGS.titan.hint1;
TITAN_CLEANMINIMAP_TOOLTIP_HINT2 = CMMSTRINGS.titan.hint2;
TITAN_CLEANMINIMAP_TOOLTIP_HINT3 = CMMSTRINGS.titan.hint3;
TITAN_CLEANMINIMAP_TOOLTIP_HINT4 = CMMSTRINGS.titan.hint4;
TITAN_CLEANMINIMAP_TOOLTIP_HINT5 = CMMSTRINGS.titan.hint5;
TITAN_CLEANMINIMAP_TOOLTIP_HINT6 = CMMSTRINGS.titan.hint6;

local TCMM_DEBUG = 0;

local function Print_Debug(s)
   if (TCMM_DEBUG == 1) then
      DEFAULT_CHAT_FRAME:AddMessage(s, 1, 1, 0)
   end
end

function TitanPanelCleanMinimapButton_OnLoad()
  if (TitanPanelBarButton) then
    this.registry = {
      id = TITAN_CLEANMINIMAP_ID,
      menuText = TITAN_CLEANMINIMAP_MENU_TEXT, 
      tooltipTitle = TITAN_CLEANMINIMAP_MENU_TEXT,
      tooltipTextFunction = "TitanPanelCleanMinimapButton_GetTooltipText",
    };
    TitanPanelButton_OnLoad();
  end
  Print_Debug("Loaded");
end

function TitanPanelCleanMinimapButton_OnShow()

    TitanPanelCleanMinimapButton_SetIcon();
    Print_Debug("Show");
end

function TitanPanelCleanMinimapButton_OnClick(button)
  if (button == "LeftButton") then
        TitanPanelCleanMinimap_ToggleMinimap();
  end
  TitanPanelButton_OnClick(button);
end

function TitanPanelCleanMinimapButton_SetIcon()
  local icon = TitanPanelCleanMinimapButtonIcon;
  if (icon ~= nil) then
    if (MinimapCluster:IsVisible()) then
          icon:SetTexture(TITAN_CLEANMINIMAP_ARTWORK_PATH.."CleanMinimapShow");
    else
          icon:SetTexture(TITAN_CLEANMINIMAP_ARTWORK_PATH.."CleanMinimapHide");
    end 
  end
end

function TitanPanelCleanMinimap_ToggleCleanMinimap()
    if (CleanMinimap_IsOn()) then
        CleanMinimap_Slash("off");
    else
        CleanMinimap_Slash("on");
    end
end

function TitanPanelCleanMinimap_ToggleClock()
    CleanMinimap_ToggleClock();
end

function TitanPanelCleanMinimap_ToggleZoom()
    CleanMinimap_ToggleZoom();
end

function TitanPanelCleanMinimap_ToggleTitle()
    CleanMinimap_ToggleTitle();
end

function TitanPanelCleanMinimap_ToggleNsew()
    CleanMinimap_ToggleNsew();
end

function TitanPanelCleanMinimap_MoveMinimap()
    CleanMinimap_StartMoving();
end

function TitanPanelCleanMinimap_GetAlpha(alpha)
    return floor(100 * alpha + 0.5);
end

function TitanPanelCleanMinimap_GetAlphaText(alpha)
    return tostring(TitanPanelCleanMinimap_GetAlpha(alpha)) .. "%";
end

function TitanPanelCleanMinimap_ToggleOptions()
  CleanMinimapOptions_Toggle();
end

function TitanPanelRightClickMenu_PrepareCleanMinimapMenu()
    TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_CLEANMINIMAP_ID].menuText);
    local info = {};

    info = {};
    info.text = TITAN_CLEANMINIMAP_MENU_ENABLE_MM;
    info.func = TitanPanelCleanMinimap_ToggleMinimap;
    info.checked = MinimapCluster:IsVisible();
    UIDropDownMenu_AddButton(info);

    if (Minimap:IsVisible()) then    
        info = {};
        info.text = TITAN_CLEANMINIMAP_MENU_ENABLE_CMM;
        info.func = TitanPanelCleanMinimap_ToggleCleanMinimap;
        info.checked = CleanMinimap_IsOn();
        UIDropDownMenu_AddButton(info);

        TitanPanelRightClickMenu_AddSpacer();

        if (CleanMinimap_IsOn()) then 

            info = {};
            info.text = TITAN_CLEANMINIMAP_MENU_SHOW_CLOCK;
            info.func = TitanPanelCleanMinimap_ToggleClock;
            info.checked = CleanMinimap_GetClock();
            UIDropDownMenu_AddButton(info);

            info = {};
            info.text = TITAN_CLEANMINIMAP_MENU_SHOW_ZOOM;
            info.func = TitanPanelCleanMinimap_ToggleZoom;
            info.checked = CleanMinimap_GetZoom();
            UIDropDownMenu_AddButton(info);

            info = {};
            info.text = TITAN_CLEANMINIMAP_MENU_SHOW_TITLE;
            info.func = TitanPanelCleanMinimap_ToggleTitle;
            info.checked = CleanMinimap_GetTitle();
            UIDropDownMenu_AddButton(info);

            info = {};
            info.text = TITAN_CLEANMINIMAP_MENU_SHOW_NSEW;
            info.func = TitanPanelCleanMinimap_ToggleNsew;
            info.checked = CleanMinimap_GetNsew();
            UIDropDownMenu_AddButton(info);

            TitanPanelRightClickMenu_AddSpacer();

            info = {};
            info.text = TITAN_CLEANMINIMAP_MENU_OPTIONS;
            info.func = TitanPanelCleanMinimap_ToggleOptions;
            UIDropDownMenu_AddButton(info);
            
            TitanPanelRightClickMenu_AddSpacer();

            info = {};
            info.text = TITAN_CLEANMINIMAP_MENU_MOVE;
            info.func = TitanPanelCleanMinimap_MoveMinimap;
            UIDropDownMenu_AddButton(info);
        end
    end
    TitanPanelRightClickMenu_AddSpacer();
    
        
  TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_CLEANMINIMAP_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelCleanMinimap_ToggleMinimap()
    if (MinimapCluster:IsVisible()) then
        MinimapCluster:Hide();
    else
        MinimapCluster:Show();
    end
    TitanPanelCleanMinimapButton_SetIcon();
end

function TitanPanelCleanMinimapButton_GetTooltipText()
    local alphaText = TitanPanelCleanMinimap_GetAlphaText(CleanMinimap_GetAlpha());
    local HINT5 = string.gsub(TITAN_CLEANMINIMAP_TOOLTIP_HINT5,"MOD",CleanMinimapConfig[CleanMinimap_player].modifierKey);
    local legend = "";
    if (Minimap:IsVisible()) then
        legend = TITAN_CLEANMINIMAP_TOOLTIP_STATUS.."\t"..TitanUtils_GetGreenText(CMMSTRINGS.on).."\n";
    else
        legend = TITAN_CLEANMINIMAP_TOOLTIP_STATUS.."\t"..TitanUtils_GetRedText(CMMSTRINGS.off).."\n";
    end
    
    if (CleanMinimap_IsOn() and Minimap:IsVisible()) then
        legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS.."\t"..TitanUtils_GetGreenText(CMMSTRINGS.on).."\n\n";
        legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_ALPHA_VALUE.."\t"..TitanUtils_GetHighlightText(alphaText).."\n\n";
        if (CleanMinimap_GetTitle()) then
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_TITLE.."\t"..TitanUtils_GetGreenText(CMMSTRINGS.on).."\n";
        else
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_TITLE.."\t"..TitanUtils_GetRedText(CMMSTRINGS.off).."\n";
        end
        if (CleanMinimap_GetClock()) then
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_CLOCK.."\t"..TitanUtils_GetGreenText(CMMSTRINGS.on).."\n";
        else
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_CLOCK.."\t"..TitanUtils_GetRedText(CMMSTRINGS.off).."\n";
        end
        if (CleanMinimap_GetZoom()) then
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_ZOOM.."\t"..TitanUtils_GetGreenText(CMMSTRINGS.on).."\n";
        else
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_ZOOM.."\t"..TitanUtils_GetRedText(CMMSTRINGS.off).."\n";
        end
        if (CleanMinimap_GetNsew()) then
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_NSEW.."\t"..TitanUtils_GetGreenText(CMMSTRINGS.on).."\n";
        else
            legend = legend..TITAN_CLEANMINIMAP_TOOLTIP_CMMSTATUS_NSEW.."\t"..TitanUtils_GetRedText(CMMSTRINGS.off).."\n";
        end
    end
    
    return ""..
        legend.."\n"..
        TitanUtils_GetGreenText(TITAN_CLEANMINIMAP_TOOLTIP_HINT1).."\n"..
        TitanUtils_GetGreenText(TITAN_CLEANMINIMAP_TOOLTIP_HINT2).."\n\n"..
        TitanUtils_GetHighlightText(TITAN_CLEANMINIMAP_TOOLTIP_HINT3).."\n"..
        TitanUtils_GetHighlightText(TITAN_CLEANMINIMAP_TOOLTIP_HINT4).."\n"..
        TitanUtils_GetHighlightText(HINT5).."\n"..
        TitanUtils_GetHighlightText(TITAN_CLEANMINIMAP_TOOLTIP_HINT6).."\n\n";
end

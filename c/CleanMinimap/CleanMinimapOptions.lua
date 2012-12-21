--[[
  CleanMinimap options frame.
  
  $Id: CleanMinimapOptions.lua 61 2005-08-27 18:02:21Z joev $
--]]
CMMOPTIONS_TITLE = CMMSTRINGS.options.title;
CMMOPTIONS_DONE = CMMSTRINGS.options.done;

CleanMinimapOptions_notVisible = false;

function CleanMinimapOptions_Toggle()
  if(CleanMinimapOptionsFrame:IsVisible()) then
    CleanMinimapOptionsFrame:Hide();
  else
    CleanMinimapOptionsFrame:Show();
  end
end

function CleanMinimapOptions_OnLoad()
  UIPanelWindows['CleanMinimapOptionsFrame'] = {area = 'center', pushable = 0};
end

function CleanMinimapOptions_Refresh()
  CMMToggleCleanMinimap:SetChecked(CleanMinimapConfig[CleanMinimap_player].on);
  CMMToggleMinimapButton:SetChecked(CleanMinimapConfig[CleanMinimap_player].showButton);
  CMMSliderButtonPos:SetValue(CleanMinimapConfig[CleanMinimap_player].buttonPos);
  CMMToggleClockButton:SetChecked(CleanMinimapConfig[CleanMinimap_player].clock);
  CMMToggleZoomButton:SetChecked(CleanMinimapConfig[CleanMinimap_player].zoom);
  CMMToggleTitleButton:SetChecked(CleanMinimapConfig[CleanMinimap_player].title);
  CMMToggleNSEWButton:SetChecked(CleanMinimapConfig[CleanMinimap_player].nsew);
  CMMSliderOpacity:SetValue(CleanMinimapConfig[CleanMinimap_player].alpha * 100);
  CMMSliderLargeSize:SetValue(CleanMinimapConfig[CleanMinimap_player].largeScale * 100);
  CMMSliderSmallSize:SetValue(CleanMinimapConfig[CleanMinimap_player].smallScale * 100);
  CMMSliderZoomIn:SetValue(CleanMinimapConfig[CleanMinimap_player].iconsPosition["MinimapZoomIn"]);
  CMMSliderZoomOut:SetValue(CleanMinimapConfig[CleanMinimap_player].iconsPosition["MinimapZoomOut"]);
  CMMSliderMail:SetValue(CleanMinimapConfig[CleanMinimap_player].iconsPosition["MiniMapMailFrame"]);
  CMMSliderTracking:SetValue(CleanMinimapConfig[CleanMinimap_player].iconsPosition["MiniMapTrackingFrame"]);
  CMMSliderBattleGrounds:SetValue(CleanMinimapConfig[CleanMinimap_player].iconsPosition["MiniMapBattlefieldFrame"]);
  CMMSliderMeetingStone:SetValue(CleanMinimapConfig[CleanMinimap_player].iconsPosition["MiniMapMeetingStoneFrame"]);
  if (CleanMinimapConfig[CleanMinimap_player].modifierKey == "CTRL") then
    CMMUseShiftButton:SetChecked(0);
    CMMUseCtrlButton:SetChecked(1);
    CMMUseAltButton:SetChecked(0);
  elseif (CleanMinimapConfig[CleanMinimap_player].modifierKey == "ALT")  then
    CMMUseShiftButton:SetChecked(0);
    CMMUseCtrlButton:SetChecked(0);
    CMMUseAltButton:SetChecked(1);
  else
    CMMUseShiftButton:SetChecked(1);
    CMMUseCtrlButton:SetChecked(0);
    CMMUseAltButton:SetChecked(0);
  end
  CMMUseOneConfigButton:SetChecked(CleanMinimapConfig.perCharSettings);
  CleanMinimapOptions_EnableButtons();
end

function CleanMinimapOptions_OnShow()
  CleanMinimapOptions_Refresh();
end

function CleanMinimapOptions_OnHide()
  if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
    ShowUIPanel(myAddOnsFrame);
  end
end

function CleanMinimapOptions_ToggleCMM()
    CleanMinimap_Toggle();
    CleanMinimapOptions_EnableButtons();
end

function CleanMinimapOptions_EnableButtons()
    if (CleanMinimapConfig[CleanMinimap_player].on) then
      getglobal("CleanMinimapMapOptionsGroupTitleText"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
      getglobal("CleanMinimapSliderGroupTitleText"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
      getglobal("CleanMinimapMapModifierGroupTitleText"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
      getglobal("CleanMinimapIconsGroupTitleText"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);

      CMMToggleClockButton:Enable();
      CMMToggleClockButtonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);      
      CMMToggleZoomButton:Enable();
      CMMToggleZoomButtonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);      
      CMMToggleTitleButton:Enable();
      CMMToggleTitleButtonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);      
      CMMToggleNSEWButton:Enable();
      CMMToggleNSEWButtonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);      

      CMMSliderOpacityThumb:Show();
      CMMSliderOpacityText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderOpacityTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderLargeSizeThumb:Show();
      CMMSliderLargeSizeText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderLargeSizeTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderSmallSizeThumb:Show();
      CMMSliderSmallSizeText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderSmallSizeTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);

      CMMUseShiftButton:Enable();
      CMMUseShiftButtonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMUseCtrlButton:Enable();
      CMMUseCtrlButtonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMUseAltButton:Enable();
      CMMUseAltButtonText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);

      CMMSliderZoomIn:Show();
      CMMSliderZoomInText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderZoomInTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderZoomOut:Show();
      CMMSliderZoomOutText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderZoomOutTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderMail:Show();
      CMMSliderMailText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderMailTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderTracking:Show();
      CMMSliderTrackingText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderTrackingTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderBattleGrounds:Show();
      CMMSliderBattleGroundsText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderBattleGroundsTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderMeetingStone:Show();
      CMMSliderMeetingStoneText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      CMMSliderMeetingStoneTextUpdate:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
    else
      getglobal("CleanMinimapMapOptionsGroupTitleText"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      getglobal("CleanMinimapSliderGroupTitleText"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      getglobal("CleanMinimapMapModifierGroupTitleText"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      getglobal("CleanMinimapIconsGroupTitleText"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);

      CMMToggleClockButton:Disable();
      CMMToggleClockButtonText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMToggleZoomButton:Disable();
      CMMToggleZoomButtonText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMToggleTitleButton:Disable();
      CMMToggleTitleButtonText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMToggleNSEWButton:Disable();
      CMMToggleNSEWButtonText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);

      CMMSliderOpacityThumb:Hide();
      CMMSliderOpacityText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderOpacityTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderLargeSizeThumb:Hide();
      CMMSliderLargeSizeText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderLargeSizeTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderSmallSizeThumb:Hide();
      CMMSliderSmallSizeText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderSmallSizeTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);

      CMMUseShiftButton:Disable();
      CMMUseShiftButtonText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMUseCtrlButton:Disable();
      CMMUseCtrlButtonText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMUseAltButton:Disable();
      CMMUseAltButtonText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);

      CMMSliderZoomIn:Hide();
      CMMSliderZoomInText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderZoomInTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderZoomOut:Hide();
      CMMSliderZoomOutText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderZoomOutTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderMail:Hide();
      CMMSliderMailText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderMailTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderTracking:Hide();
      CMMSliderTrackingText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderTrackingTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderBattleGrounds:Hide();
      CMMSliderBattleGroundsText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderBattleGroundsTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderMeetingStone:Hide();
      CMMSliderMeetingStoneText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
      CMMSliderMeetingStoneTextUpdate:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);

    end

end

function CleanMinimapOptions_ShowIcon(frameName)
  if (not getglobal(frameName):IsShown()) then
    CleanMinimapOptions_notVisible = true;
    getglobal(frameName):Show();
  end
end

function CleanMinimapOptions_HideIcon(frameName)
  if (CleanMinimapOptions_notVisible) then
    getglobal(frameName):Hide();
    CleanMinimapOptions_notVisible = false;
  end 
end

--[[
]]--
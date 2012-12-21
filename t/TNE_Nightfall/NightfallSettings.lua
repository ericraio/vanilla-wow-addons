
function TNE_NightfallSettings_OnLoad()

  -- setup GUI labels
  for i, value in TNE_NightfallSettings_Labels do
    getglobal("NightfallSettingsFrameLabel".. i):SetText(value)
  end
  getglobal("NightfallSettingsFrameVersion"):SetText(TNE_Nightfall_Version)

  -- setup components
  -- checkbuttons
  for i, value in TNE_NightfallSettings_CheckButtonTooltipStrings do
    getglobal("NightfallSettingsFrameCheckButton".. i).tooltipText = value
  end

  for i, value in TNE_NightfallSettings_CheckButtonStrings do
    getglobal("NightfallSettingsFrameCheckButton".. i.. "Text"):SetText(value)
  end

  -- regular buttons
  for i, value in TNE_NightfallSettings_ButtonStrings do
    getglobal("NightfallSettingsFrameButton".. i.. "Text"):SetText(value)
  end

  -- make config window close on escape
  tinsert(UISpecialFrames, "NightfallSettingsFrame")

  -- add window to built-in UI window managment
  UIPanelWindows["NightfallSettingsFrame"] = { area = "left", pushable = 2, whileDead = 1 }

end


function TNE_NightfallSettings_OnShow()

  -- initalize GUI
  local checkButtons = { [1] = TNE_Nightfall_Enabled, [2] = TNE_Nightfall_UseLargeEffect,
                         [3] = TNE_Nightfall_SoundEffects, [4] = TNE_Nightfall_ShardEnabled, }
  TNE_NightfallSettings_SetValues(checkButtons)

end


function TNE_NightfallSettings_SetValues(checkButtonValues)

  -- set components to parameters
  for i, value in checkButtonValues do
    getglobal("NightfallSettingsFrameCheckButton".. i):SetChecked(value)
  end

end


function TNE_NightfallSettings_ApplySettings()

  -- set addon enabled
  TNE_Nightfall_Enabled = getglobal("NightfallSettingsFrameCheckButton1"):GetChecked() or false
  TNE_Nightfall_UseLargeEffect = getglobal("NightfallSettingsFrameCheckButton2"):GetChecked() or false
  TNE_Nightfall_SoundEffects = getglobal("NightfallSettingsFrameCheckButton3"):GetChecked() or false
  TNE_Nightfall_ShardEnabled = getglobal("NightfallSettingsFrameCheckButton4"):GetChecked() or false

  -- propagate settings
  TNE_Nightfall_ApplySettings()

end


function TNE_NightfallSettings_ResetSettings()

  -- restore default values
  local checkButtons = { TNE_Nightfall_Default_Enabled, TNE_Nightfall_Default_UseLargeEffect,
                         TNE_Nightfall_SoundEffects, TNE_Nightfall_Default_ShardEnabled, }
  TNE_NightfallSettings_SetValues(checkButtons)

end

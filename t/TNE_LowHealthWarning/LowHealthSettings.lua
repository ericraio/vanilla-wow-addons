
function TNE_LowHealthSettings_OnLoad()

  local frame = "LowHealthSettingsFrame"

  -- setup GUI labels
  for i, value in TNE_LowHealthSettings_Labels do
    getglobal(frame.. "Label".. i):SetText(value)
  end
  getglobal(frame.. "Version"):SetText(TNE_LowHealth_Version)

  -- fields and checkbuttons
  for field, buttons in TNE_LowHealthSettings_CheckButtons do
    getglobal(frame.. field.. "Options".. "Title"):SetText(field)
    for i, data in buttons do
      local text, tooltip = unpack(data)
      local button = frame.. field.. "Options".. "CheckButton".. i
      getglobal(button.. "Text"):SetText(text)
      getglobal(button).tooltipText = tooltip
    end
  end

  -- sliders
  for field, sliders in TNE_LowHealthSettings_Sliders do
    for i, data in sliders do
      getglobal(frame.. field.. "Options".. "ThresholdSlider".. i.. "Text"):SetText(data[1])
    end
  end

  -- regular buttons
  for i, value in TNE_LowHealthSettings_Buttons do
    getglobal(frame.. "Button".. i.. "Text"):SetText(value)
    getglobal(frame.. "Button".. i.. "HighlightText"):SetText(value)
  end

  -- make config window close on escape
  tinsert(UISpecialFrames, "LowHealthSettingsFrame")

  -- add window to built-in UI window managment
  UIPanelWindows["LowHealthSettingsFrame"] = { area = "left", pushable = 2, whileDead = 1 }

end


function TNE_LowHealthSettings_SetValues(checkButtonValues, sliderValues)

  local frame = "LowHealthSettingsFrame"

  -- set components
  for field, buttons in TNE_LowHealthSettings_CheckButtons do
    for i in buttons do
      getglobal(frame.. field.. "Options".. "CheckButton".. i):SetChecked(checkButtonValues[field][i])
    end
  end

  -- sliders
  for field, sliders in TNE_LowHealthSettings_Sliders do
    for i, _ in sliders do
      getglobal(frame.. field.. "Options".. "ThresholdSlider".. i):SetValue(sliderValues[field][i])
    end
  end

end


function TNE_LowHealthSettings_OptionsSlider_OnValueChanged()

  -- set tooltip to reflect the changing value
  local frame = "LowHealthSettingsFrame"
  local _, _, parent, id = string.find(this:GetName(), frame.. "(.+)OptionsThresholdSlider(.+)")
  this.tooltipText = format(TNE_LowHealthSettings_Sliders[parent][tonumber(id)][2], this:GetValue())
  GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1)

end


function TNE_LowHealthSettings_ApplySettings()

  local health, mana, sound = "UNIT_HEALTH", "UNIT_MANA", "SOUND"
  local frame = "LowHealthSettingsFrame"
  local ocb = "OptionsCheckButton"
  local ots = "OptionsThresholdSlider"

  -- set flags
  TNE_LowHealth_Enabled = getglobal(frame.. "General".. ocb.. "1"):GetChecked() or false
  TNE_LowHealth_SoundEnabled = getglobal(frame.. "Sound".. ocb.. "1"):GetChecked() or false
  TNE_LowHealth_SoundCombatOnly = getglobal(frame.. "Sound".. ocb.. "2"):GetChecked() or false
  TNE_LowHealth_HealthEnabled = getglobal(frame.. "Health".. ocb.. "1"):GetChecked() or false
  TNE_LowHealth_HealthCombatOnly = getglobal(frame.. "Health".. ocb.. "2"):GetChecked() or false
  TNE_LowHealth_HealthSync = getglobal(frame.. "Health".. ocb.. "3"):GetChecked() or false
  TNE_LowHealth_HealthEmote = getglobal(frame.. "Health".. ocb.. "4"):GetChecked() or false
  TNE_LowHealth_ManaEnabled = getglobal(frame.. "Mana".. ocb.. "1"):GetChecked() or false
  TNE_LowHealth_ManaCombatOnly = getglobal(frame.. "Mana".. ocb.. "2"):GetChecked() or false
  TNE_LowHealth_ManaSync = getglobal(frame.. "Mana".. ocb.. "3"):GetChecked() or false

  -- set thresholds
  TNE_LowHealth_Thresholds[sound][1] = getglobal(frame.. "Sound".. ots.. 1):GetValue()
  TNE_LowHealth_Thresholds[health][1] = getglobal(frame.. "Health".. ots.. 1):GetValue()
  TNE_LowHealth_Thresholds[health][2] = getglobal(frame.. "Health".. ots.. 2):GetValue()
  TNE_LowHealth_Thresholds[mana][1] = getglobal(frame.. "Mana".. ots.. 1):GetValue()
  TNE_LowHealth_Thresholds[mana][2] = getglobal(frame.. "Mana".. ots.. 2):GetValue()

  -- propagate settings
  TNE_LowHealth_ApplySettings()

end


function TNE_LowHealthSettings_PrepareValues(default)

  if (not default) then
    default = ""
  end

  local checkButtons = {
    ["General"] = {
      [1] = getglobal("TNE_LowHealth".. default.. "_Enabled"),
    },
    ["Sound"] = {
      [1] = getglobal("TNE_LowHealth".. default.. "_SoundEnabled"),
      [2] = getglobal("TNE_LowHealth".. default.. "_SoundCombatOnly"),
    },
    ["Health"] = {
      [1] = getglobal("TNE_LowHealth".. default.. "_HealthEnabled"),
      [2] = getglobal("TNE_LowHealth".. default.. "_HealthCombatOnly"),
      [3] = getglobal("TNE_LowHealth".. default.. "_HealthSync"),
      [4] = getglobal("TNE_LowHealth".. default.. "_HealthEmote"),
    },
    ["Mana"] = {
      [1] = getglobal("TNE_LowHealth".. default.. "_ManaEnabled"),
      [2] = getglobal("TNE_LowHealth".. default.. "_ManaCombatOnly"),
      [3] = getglobal("TNE_LowHealth".. default.. "_ManaSync"),
    },
  }

  local health, mana, sound = "UNIT_HEALTH", "UNIT_MANA", "SOUND"
  local thresholds = getglobal("TNE_LowHealth".. default.. "_Thresholds")
  local sliders = {
    ["Sound"] = thresholds["SOUND"],
    ["Health"] = thresholds["UNIT_HEALTH"],
    ["Mana"] = thresholds["UNIT_MANA"],
  }

  TNE_LowHealthSettings_SetValues(checkButtons, sliders)

end


function TNE_LowHealthSettings_OnShow()

  TNE_LowHealthSettings_PrepareValues()

end


function TNE_LowHealthSettings_ResetSettings()

  TNE_LowHealthSettings_PrepareValues("_Default")

end

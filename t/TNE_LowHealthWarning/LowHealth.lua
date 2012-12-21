
-- TODO: flashDuration = -1 to keep running forever? check blizz's code

function TNE_LowHealth_OnLoad()

  local health, mana, sound = "UNIT_HEALTH", "UNIT_MANA", "SOUND"

  TNE_LowHealth_Version = "2.0"

  -- these are the default values
  TNE_LowHealth_Default_Enabled = true
  TNE_LowHealth_Default_SoundEnabled = true
  TNE_LowHealth_Default_HealthEnabled = true
  TNE_LowHealth_Default_ManaEnabled = true
  TNE_LowHealth_Default_SoundCombatOnly = false
  TNE_LowHealth_Default_HealthCombatOnly = false
  TNE_LowHealth_Default_ManaCombatOnly = false
  TNE_LowHealth_Default_HealthSync = false
  TNE_LowHealth_Default_ManaSync = false
  TNE_LowHealth_Default_HealthEmote = false
  TNE_LowHealth_Default_Thresholds = {
    [health] = { [1] = 40, [2] = 20 }, -- regular and critical, in percent
    [mana] = { [1] = 40, [2] = 20 },
    [sound] = { [1] = 50 },
  }

  -- set variables to their default values. these will be overriden when variables are loaded
  TNE_LowHealth_Enabled = TNE_LowHealth_Default_Enabled
  TNE_LowHealth_SoundEnabled = TNE_LowHealth_Default_SoundEnabled
  TNE_LowHealth_HealthEnabled = TNE_LowHealth_Default_HealthEnabled
  TNE_LowHealth_ManaEnabled = TNE_LowHealth_Default_ManaEnabled
  TNE_LowHealth_SoundCombatOnly = TNE_LowHealth_Default_SoundCombatOnly
  TNE_LowHealth_HealthCombatOnly = TNE_LowHealth_Default_HealthCombatOnly
  TNE_LowHealth_ManaCombatOnly = TNE_LowHealth_Default_ManaCombatOnly
  TNE_LowHealth_HealthSync = TNE_LowHealth_Default_HealthSync
  TNE_LowHealth_ManaSync = TNE_LowHealth_Default_ManaSync
  TNE_LowHealth_HealthEmote = TNE_LowHealth_Default_HealthEmote
  TNE_LowHealth_Thresholds = TNE_LowHealth_Default_Thresholds

  -- these values keep track of animation
  this.states = { [health] = 0, [mana] = 0 }

  -- change the blue frame to act as the red one
  OutOfControlFrame:ClearAllPoints()
  OutOfControlFrame:SetParent("WorldFrame")
  OutOfControlFrame:SetAllPoints("WorldFrame")

  -- set both frames transparent to avoid onload flashing
  LowHealthFrame:SetAlpha(0)
  OutOfControlFrame:SetAlpha(0)

  -- command line
  SlashCmdList["LOWHEALTHWARNINGCMD"] = TNE_LowHealth_CMD
  SLASH_LOWHEALTHWARNINGCMD1 = "/lowhealthwarning"
  SLASH_LOWHEALTHWARNINGCMD2 = "/lowhealth"
  SLASH_LOWHEALTHWARNINGCMD3 = "/lhw"

end


function TNE_LowHealth_ApplySettings(leavingWorld)

  -- for compatibility with older versions of saved variables
  if (not TNE_LowHealth_Thresholds["SOUND"]) then
    TNE_LowHealth_Thresholds["SOUND"] = { [1] = 30 }
  end

  local frame = getglobal("LowHealthWarningFrame")

  -- register or unregister events (always unregister when we leave the world)
  if (TNE_LowHealth_Enabled and not leavingWorld) then
    frame:RegisterEvent("UNIT_DISPLAYPOWER")
    if (TNE_LowHealth_HealthEnabled or TNE_LowHealth_SoundEnabled) then
      frame:RegisterEvent("UNIT_HEALTH")
    end
    TNE_LowHealth_ManaCheck()
  else
    frame:UnregisterEvent("UNIT_HEALTH")
    frame:UnregisterEvent("UNIT_HEALTH")
    frame:UnregisterEvent("UNIT_DISPLAYPOWER")
    TNE_LowHealth_FlashFrameStop(LowHealthFrame, "UNIT_HEALTH")
    TNE_LowHealth_FlashFrameStop(OutOfControlFrame, "UNIT_MANA")
  end

end


function TNE_LowHealth_FlashFrame(value, regular, critical, frame, state)

  local REGULAR_FLASH, CRITICAL_FLASH = 1, 2

  -- disable
  if (value > regular or TNE_LowHealth_CombatCheck(state) or UnitIsDeadOrGhost("player")) then
    TNE_LowHealth_FlashFrameStop(frame, state)
  -- regular flash
  elseif (value > critical) then
    if (not (LowHealthWarningFrame.states[state] == REGULAR_FLASH)) then
      if (UIFrameIsFlashing(frame)) then
        frame.flashDuration = frame.flashDuration + 10
        frame.fadeInTime = 0.4
        frame.fadeOutTime = 0.6
        frame.flashInHoldTime = 1
      else
        UIFrameFlash(frame, 0.4, 0.6, 60, nil, 1, 0)
      end
      LowHealthWarningFrame.states[state] = REGULAR_FLASH
    end
  -- critical flash
  else
    if (not (LowHealthWarningFrame.states[state] == CRITICAL_FLASH)) then
      if (TNE_LowHealth_HealthEmote and state == "UNIT_HEALTH") then DoEmote("healme") end
      if (UIFrameIsFlashing(frame)) then
        frame.flashDuration = frame.flashDuration + 10
        frame.fadeInTime = 0.2
        frame.fadeOutTime = 0.8
        frame.flashInHoldTime = 0
      else
        UIFrameFlash(frame, 0.2, 0.8, 60, nil, 0, 0)
      end
      LowHealthWarningFrame.states[state] = CRITICAL_FLASH
    end
  end

end

function TNE_LowHealth_SmoothFlashFrame(value, threshold, frame, state)

  -- disable
  if (value > threshold or TNE_LowHealth_CombatCheck(state) or UnitIsDeadOrGhost("player")) then
    TNE_LowHealth_FlashFrameStop(frame, state)
  -- smooth flash
  else
    local rate = TNE_LowHealth_GetHeartRate(state)
    local flashIn, flashOut = rate * 0.1, rate * 0.4
    if (UIFrameIsFlashing(frame)) then
      frame.flashDuration = frame.flashDuration + rate + 1
      if (rate < 1) then
        frame.fadeInTime = rate * 0.15
        frame.fadeOutTime = rate * 0.85
        frame.flashInHoldTime = 0
      else
        frame.fadeInTime = 0.2
        frame.fadeOutTime = 0.8
        frame.flashInHoldTime = rate - 1
      end
    else
      UIFrameFlash(frame, 0.2, 0.8, 10, nil, rate -1, 0)
    end
  end

end


function TNE_LowHealth_FlashFrameStop(frame, state)

  UIFrameFlashRemoveFrame(frame)
  UIFrameFadeRemoveFrame(frame)
  UIFrameFadeOut(frame, 0.5, frame:GetAlpha(), 0)
  LowHealthWarningFrame.states[state] = 0

end


function TNE_LowHealth_OnEvent()

  if (event == "UNIT_DISPLAYPOWER") then 
    TNE_LowHealth_ManaCheck()
    return
  end

  -- unpacks regular threshold, critical threshold, nil, nil, nil
  local t1, t2, value, frame, smooth = unpack(TNE_LowHealth_Thresholds[event])

  -- pick frame based on event
  if (event == "UNIT_HEALTH") then
    value = UnitHealth("player") / UnitHealthMax("player")
    TNE_LowHealth_SoundCheck(this, value * 100, unpack(TNE_LowHealth_Thresholds["SOUND"]))
    if (not TNE_LowHealth_HealthEnabled) then
      return -- this 'hack' is because both sound and health flash need this event
    end
    frame = LowHealthFrame
    smooth = TNE_LowHealth_HealthSync
  elseif (event == "UNIT_MANA") then
    value = UnitMana("player") / UnitManaMax("player")
    frame = OutOfControlFrame
    smooth = TNE_LowHealth_ManaSync
  end

  if (smooth) then -- flash differently depending on settings
    TNE_LowHealth_SmoothFlashFrame(value * 100, t1, frame, event)
  else
    TNE_LowHealth_FlashFrame(value * 100, t1, t2, frame, event)
  end

end


function TNE_LowHealth_CombatCheck(state)

  local combat = UnitAffectingCombat("player")
  if (not state or state == "UNIT_HEALTH") then
    return TNE_LowHealth_HealthCombatOnly and not combat
  elseif (state == "UNIT_MANA") then
    return TNE_LowHealth_ManaCombatOnly and not combat
  else
    return TNE_LowHealth_SoundCombatOnly and not combat
  end

end


function TNE_LowHealth_SoundCheck(frame, value, threshold)

  -- disable
  if (value > threshold or not TNE_LowHealth_SoundEnabled or TNE_LowHealth_CombatCheck("SOUND") or UnitIsDeadOrGhost("player")) then
    if (frame.heartRate) then
      frame:SetScript("OnUpdate", nil)
      frame.heartRate = nil
    end
  -- regular
  elseif (not frame.heartRate) then
    frame:SetScript("OnUpdate", TNE_LowHealth_OnUpdate)
    frame.timer = 1
    frame.heartRate = 0
  end
end


function TNE_LowHealth_ManaCheck()

  local mana, frame = "UNIT_MANA", getglobal("LowHealthWarningFrame")
  if (TNE_LowHealth_ManaEnabled and UnitPowerType("player") == 0) then
    -- player is using mana
    frame:RegisterEvent(mana)
  else
    frame:UnregisterEvent(mana)
    TNE_LowHealth_FlashFrameStop(OutOfControlFrame, mana)
  end
end


function TNE_LowHealth_OnUpdate()

  if (this.timer > this.heartRate) then
    PlaySoundFile("Interface\\AddOns\\TNE_LowHealthWarning\\Sounds\\Heartbeat.wav")
    this.heartRate = TNE_LowHealth_GetHeartRate()
    this.timer = 0
  else
    this.timer = this.timer + arg1
  end

end


function TNE_LowHealth_GetHeartRate(state)
  if (state and state == "UNIT_MANA") then
    return 0.5 + 2.0 * UnitMana("player") / UnitManaMax("player")
  else
    return 0.5 + 2.0 * UnitHealth("player") / UnitHealthMax("player")
  end
end


function TNE_LowHealth_CMD(arg1)

  if (not arg1) then
    return
  end

  if (string.find(arg1, "^settings$") or arg1 == "") then
    ShowUIPanel(LowHealthSettingsFrame)
    return
  end

end

  
  -- TODO: some inconsistency with clearcasting, or maybe I'm just stupid. go play more mage.
  -- TODO: make it possible to localize help
  -- TODO: SCT support. message when rule begins/end or something, shouldn't be hard to add
  
  FiveSec = {
    version = "2.1.2",
    supportedbuild = "11000",
    lastupdate = "May 28, 2006",
    name = "FiveSec",
    cmd = "/fs",
    cmd2 = "/fivesec",
    frame = "FiveSecBarFrame",
    author = "Silent",
    email = "silentaddons@gmail.com",
    url = "http://www.curse-gaming.com/mod.php?addid=3319",
    events = {
      "SPELLCAST_STOP",
      "SPELLCAST_CHANNEL_START",
      "SPELLCAST_CHANNEL_STOP",
      "SPELLCAST_FAILED",
      "SPELLCAST_INTERRUPTED",
      "CHAT_MSG_SPELL_SELF_DAMAGE", -- need this one for Raptor Strike
      "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", -- need this one to detect Spirit Tap/Innervate/Blue Dragon aura
      "CHAT_MSG_SPELL_AURA_GONE_SELF", -- ... and for when the buffs fade
      "UNIT_MANA",
    },
    help = {
      ["reset"] = "$v/fs reset$ev: Moves the bar in position above the casting bar.",
      ["toggle"] = "$v/fs$ev <$von$ev | $voff$ev>: Toggle the addon on or off.",
      ["mode"] = "$v/fs mode$ev <$vstandard$ev | $vreverse$ev>: Increasing or decreasing bar.",
      ["move"] = "$v/fs move$ev <$von$ev | $voff$ev>: Turn on to easily move the bar.",
      ["hidden"] = "$v/fs hidden$ev <$von$ev | $voff$ev>: Turn on to keep functionality without showing the bar (for Perl users).",
      ["fraction"] = "$v/fs fraction$ev <$von$ev | $voff$ev>: Turn on to show split seconds in the timer.",
      ["alpha"] = "$v/fs alpha$ev <$v0.1$ev - $v1.0$ev>: Set opacity.",
      ["scale"] = "$v/fs scale$ev <$v0.5$ev - $v2.0$ev>: Set scale.",
      ["about"] = "$v/fs about$ev: Displays infomation about this addon.",
    },
  }
  
  -- addon loading and initialization
  --------------------------------------------------------------------------------
  
  function FiveSec:Initalize()

    TNE_FiveSec_Enabled = true
    TNE_FiveSec_Movable = false
    TNE_FiveSec_Reverse = false
    TNE_FiveSec_Hidden = false
    TNE_FiveSec_Scale = 0.8
    TNE_FiveSec_Alpha = 1.0
    TNE_FiveSec_SplitSeconds = false
    TNE_FiveSec_FIVE_SECONDS = 5 -- duh. but maybe it changes some day
    TNE_FiveSec_25FPS = 0.025
    TNE_FiveSec_10FPS = 0.1
    TOTAL_MANA_REGENERATED = 0 -- this variable can be used to track mana regen from another addon
    REGENERATING_MANA = true -- globally available boolean, true if mana regeneration is active

    FiveSec:UpdatePosition()

    -- setup values
    local frame = getglobal(FiveSec.frame)
    frame.active = nil
    frame.duration = TNE_FiveSec_FIVE_SECONDS 
    frame.timer = 0
    frame.delay = 0
    frame.mode = "standard"
    frame.fadeOutTime = 1.5
    frame.update = 0
    frame.updateRate = TNE_FiveSec_25FPS
    FiveSec.mana = 0
    FiveSec.activeBuffs = {}
  
    -- function hooks
    TNE_FiveSec_Old_CastSpell = CastSpell
    CastSpell = TNE_FiveSec_CastSpell
    TNE_FiveSec_Old_CastSpellByName = CastSpellByName
    CastSpellByName = TNE_FiveSec_CastSpellByName
    TNE_FiveSec_Old_UseAction = UseAction
    UseAction = TNE_FiveSec_UseAction
    TNE_FiveSec_Old_SpellStopCasting = SpellStopCasting
    SpellStopCasting = TNE_FiveSec_SpellStopCasting
    TNE_FiveSec_Old_SpellStopTargeting = SpellStopTargeting
    SpellStopTargeting = TNE_FiveSec_SpellStopTargeting
  
    -- chat commands
    SlashCmdList["FIVESECCMD"] = TNE_FiveSec_Command
    SLASH_FIVESECCMD1 = FiveSec.cmd
    SLASH_FIVESECCMD2 = FiveSec.cmd2

    -- piggyback ride on blizzards UI management. sweet. -- temporarily disabled
    --UIPARENT_MANAGED_FRAME_POSITIONS["FiveSecBarFrame"] = {baseY = 120, bottomEither = 40, pet = 40, reputation = 9}
  
    TNEUtils.Help(FiveSec, "onload")
  
  end
  
  
  function FiveSec:OnLoadToggle()

    local frame, spark = getglobal(FiveSec.frame), getglobal(FiveSec.frame.. "Spark")  
    frame:SetScale(TNE_FiveSec_Scale)
    frame:SetAlpha(0)
    FS_Enabled, FS_ReverseMode = nil, nil -- remove old variables
    if (TNE_FiveSec_Reverse) then
      frame.mode = "reverse"
    end
    if (TNE_FiveSec_Enabled) then
      TNEUtils.CombatEcho(FiveSec.name.. ": Addon enabled.")
      TNEUtils.RegisterEvents(FiveSec.frame, FiveSec.events)
      frame:Show()
    else
      TNEUtils.CombatEcho(FiveSec.name.. ": Addon disabled.")
      frame:Hide()
    end

    frame:SetValue(0)
    frame:SetMinMaxValues(0, 1)
    spark:Hide()
  
  end

  function FiveSec:ManaCheck()
    if (TNE_FiveSec_Enabled and UnitPowerType("player") == 0) then
      -- player is using mana
      TNEUtils.RegisterEvents(FiveSec.frame, FiveSec.events)
    else
      TNEUtils.UnregisterEvents(FiveSec.frame, FiveSec.events)
    end
  end


  -- hooked functions
  --------------------------------------------------------------------------------
  
  function TNE_FiveSec_SpellStopCasting()
    if (TNE_FiveSec_Enabled) then
      FiveSec:ClearTooltip()
      FiveSec.nextMelee = nil
      FiveSec.nextSpell = nil
    end
    TNE_FiveSec_Old_SpellStopCasting()
  end
  
  function TNE_FiveSec_SpellStopTargeting()
    if (TNE_FiveSec_Enabled) then
      FiveSec:ClearTooltip()
      FiveSec.nextSpell = nil
    end
    TNE_FiveSec_Old_SpellStopTargeting()
  end
  
  function TNE_FiveSec_UseAction(actionID, number, onSelf)

    if (TNE_FiveSec_Enabled and not (IsAutoRepeatAction(actionID) or IsConsumableAction(actionID) or GetActionText(actionID))) then
      FiveSec:SetTooltipAction(actionID)
      FiveSec:ProcessTooltip()
    end

    TNE_FiveSec_Old_UseAction(actionID, number, onSelf)

  end
  
  function TNE_FiveSec_CastSpell(spellId, spellbookTabNum)
  
    --TNEUtils.CombatEcho("CastSpell: ".. spellID) --debug
    if (TNE_FiveSec_Enabled) then
      FiveSec:SetTooltipSpell(spellId, spellbookTabNum)
      FiveSec:ProcessTooltip()
    end

    TNE_FiveSec_Old_CastSpell(spellId, spellbookTabNum)
  
  end
  
  function TNE_FiveSec_CastSpellByName(spellName, onSelf)  -- should catch macro'ed spells
  
    --TNEUtils.CombatEcho2("CastSpellByName: ".. spellName) --debug
  
    -- this loop should break out early most of the times
    if (TNE_FiveSec_Enabled) then

      for i=1, 255 do
        local spell = GetSpellName(i, BOOKTYPE_SPELL) 
        if (spell) then
          if (spell == spellName) then
            --TNEUtils.CombatEcho("CastSpellByName found spell ID: ".. 1) --debug
            FiveSec:SetTooltipSpell(i, BOOKTYPE_SPELL)
            FiveSec:ProcessTooltip()
            break;
          end
        else
          break
        end
      end

    end

    TNE_FiveSec_Old_CastSpellByName(spellName, onSelf)
  
  end
  
  
  -- tooltip management
  --------------------------------------------------------------------------------
  
  function FiveSec:ProcessTooltip()
    if (FiveSec:TooltipSpellHasManaCost()) then
      if (FiveSec:TooltipSpellIsNextMelee()) then
        FiveSec.nextMelee = FiveSec:TooltipSpellName()
      else
        FiveSec.nextSpell = true
      end
    else
      FiveSec.nextSpell = nil
    end
  end
  
  function FiveSec:SetTooltipSpell(spellId, spellbookTabNum)

    FiveSecTooltip:SetOwner(getglobal(FiveSec.frame), "ANCHOR_NONE") -- 1.10 ftw

    local oldUberTooltips = GetCVar("UberTooltips") -- backup and override ubertooltip settings
    SetCVar("UberTooltips", 1)

    if (GetSpellName(spellId, spellbookTabNum)) then
      FiveSecTooltip:SetSpell(spellId, spellbookTabNum)
    end

    SetCVar("UberTooltips", oldUberTooltips) -- restore ubertooltip setting

  end
  
  function FiveSec:SetTooltipAction(index)

    FiveSecTooltip:SetOwner(getglobal(FiveSec.frame), "ANCHOR_NONE") -- 1.10 ftw

    local oldUberTooltips = GetCVar("UberTooltips") -- backup and override ubertooltip settings
    SetCVar("UberTooltips", 1)

    if (GetActionTexture(index)) then -- skip empty action slots
      FiveSecTooltip:SetAction(index)
    end

    SetCVar("UberTooltips", oldUberTooltips) -- restore ubertooltip setting

  end
  
  function FiveSec:ClearTooltip()
    FiveSecTooltip:ClearLines()
  end
  
  function FiveSec:TooltipSpellName()
    return FiveSecTooltipTextLeft1:GetText()
  end
  
  function FiveSec:TooltipSpellHasManaCost()
    local text = FiveSecTooltipTextLeft2:GetText()
    if (text) then
      return string.find(text, MANA)
    else
      return nil
    end
  end
  
  function FiveSec:TooltipSpellIsNextMelee()
    local text = FiveSecTooltipTextLeft3:GetText()
    if (text) then
      return string.find(text, SPELL_ON_NEXT_SWING)
    end
    return nil
  end


  -- statusbar managment
  --------------------------------------------------------------------------------

  function FiveSec:Start()
  
    --TNEUtils.CombatEcho("FiveSec:Start() called") --debug

    --if (table.getn(FiveSec.activeBuffs) > 0) then
      --return
    --end

    local frame, text, spark = getglobal(FiveSec.frame), getglobal(FiveSec.frame.. "Text"), getglobal(FiveSec.frame.. "Spark")
    local delay, now = 0, GetTime()
    if (FiveSec.lastGain) then
      --delay = math.mod(FiveSec.lastGain, 2)
      delay = 1 - math.mod(now - FiveSec.lastGain, 2) -- not 100% accurate
      --delay = 2 - math.mod(now - FiveSec.lastGain, 2)
      --delay = math.mod(now - FiveSec.lastGain, 2)
      --delay = 1
      --pxd("Delay by: ".. (delay))
      --if (delay < -0.2) then
      --  pxd("Expect tick at (7): ".. now + 7 + delay)
      --else
      --  pxd("Expect tick at (5): ".. now + 5 + delay)
      --end
      --pxd("Was expected at: ".. now + delay)
      --pxd("Last tick was: ".. now - delay)
    end

    -- set values
    frame.active = 1
    frame.startTime = GetTime()
    frame.lastUpdate = frame.startTime
    frame.delay = TNEUtils.Select(delay < 0, 2 + delay, delay)
    --frame.delay = delay
    --pxd(frame.delay)
    frame.duration = TNE_FiveSec_FIVE_SECONDS + frame.delay
    frame.timer = TNEUtils.Select(frame.mode == "reverse", frame.duration, 0)

    -- color and decoration
    local color = TNE_FiveSec_BarColors["disabled"]
    if (table.getn(FiveSec.activeBuffs) > 0) then
      color = TNE_FiveSec_BarColors["enabled"]
    end
    frame:SetStatusBarColor(color.r, color.g, color.b)
    frame:SetMinMaxValues(0, frame.duration)
    frame:SetValue(frame.timer)
    spark:Show()
    text:SetText(format(TNE_FiveSec_REGENERATION_IN, frame.duration))

    -- display
    UIFrameFadeRemoveFrame(frame)
    frame:SetAlpha(TNEUtils.Select(TNE_FiveSec_Hidden, 0, TNE_FiveSec_Alpha))

    -- set global flags (used in ManaWatch, Perl)
    REGENERATING_MANA = false -- global flag: mana regenartion active
    if (TOTAL_MANA_REGENERATED > 0) then -- global flag: regenerated mana
      TOTAL_MANA_REGENERATED = 0
    end

  end

  function FiveSec:Stop()

    --TNEUtils.CombatEcho("FiveSec:Stop() called") --debug

    local frame, text, spark = getglobal(FiveSec.frame), getglobal(FiveSec.frame.. "Text"), getglobal(FiveSec.frame.. "Spark")
  
    frame.active = nil
  
    --local color = TNE_FiveSec_BarColors["enabled"]
    --frame:SetStatusBarColor(color.r, color.g, color.b)
    frame:SetValue(TNEUtils.Select(frame.mode == "reverse", 0, frame.duration))
    spark:Hide()
    text:SetText(format(TNE_FiveSec_REGENERATION_IN_INT, 0))

    if (TOTAL_MANA_REGENERATED < 0) then
      TOTAL_MANA_REGENERATED = 0
    end
    REGENERATING_MANA = true

    if (not TNE_FiveSec_Movable) then
      UIFrameFadeOut(frame, frame.fadeOutTime * TNE_FiveSec_Alpha, frame:GetAlpha(), 0)
    end

  end

  function FiveSec:WaitWhileChanneling(delayedAt)
    local frame, label, text, delay, spark = getglobal(FiveSec.frame), getglobal(FiveSec.frame.. "Label"), getglobal(FiveSec.frame.. "Text"), getglobal(FiveSec.frame.. "Delay"), getglobal(FiveSec.frame.. "Spark")
    frame.delayed = delayedAt
    frame:SetValue(delayedAt)
    label:Hide()
    text:Hide()
    delay:Show()
    delay:SetAlpha(0)
    spark:Hide()
    UIFrameFlash(delay, 0.4, 0.75, -1, nil, 0, 0.5)
  end

  function FiveSecBarFrame_OnUpdate(elapsed)

    local frame = getglobal(FiveSec.frame)

    -- limiter
    frame.update = this.update + elapsed
    if (frame.update < frame.updateRate) then
      return
    end
    this.update = 0

    local now = GetTime()

    if (frame.possibleInterruptAt) then
      if (now > frame.possibleInterruptAt + 0.5) then
        if (frame.wasActiveOnInterrupt) then
          FiveSec:Start(now - frame.possibleInterruptAt)
        end
        frame.possibleInterruptAt = nil
        frame.wasActiveOnInterrupt = nil
      end
    end

    if (frame.active) then
      -- update timer
      frame.timer = frame.timer + TNEUtils.Select(frame.mode == "reverse", frame.lastUpdate - now, now - frame.lastUpdate)
      frame.lastUpdate = now
  
      if (FiveSec.channeling) then
        if (frame.delayed) then
          return -- do nothing until player stops channeling
        elseif ((frame.mode == "reverse" and frame.timer < frame.delay) or (frame.mode == "standard" and frame.timer > TNE_FiveSec_FIVE_SECONDS)) then
          FiveSec:WaitWhileChanneling(frame.timer)
          return 
        end
      elseif (frame.delayed) then
        -- restore frame
        frame.timer = frame.delayed
        frame.delayed = nil
        local delayLabel = getglobal(FiveSec.frame.. "Delay")
        UIFrameFlashRemoveFrame(delayLabel)
        UIFrameFadeRemoveFrame(delayLabel)
        delayLabel:Hide()
        getglobal(FiveSec.frame.. "Label"):Show()
        getglobal(FiveSec.frame.. "Text"):Show()
        --frame:SetAlpha(TNEUtils.Select(TNE_FiveSec_Hidden, 0, TNE_FiveSec_Alpha))
      end

      if (frame.timer < 0 or frame.timer > frame.duration) then
        -- time's up, snap to limits and stop
        frame.timer = TNEUtils.Select(frame.timer < 0, 0, frame.duration)
        FiveSec:Stop()
      else
        if ((frame.mode == "reverse" and frame.timer < frame.delay) or (frame.mode == "standard" and frame.timer > TNE_FiveSec_FIVE_SECONDS)) then
          REGENERATING_MANA = true
        end
        -- keep going, set time remaining
        local frame, text, spark = getglobal(FiveSec.frame), getglobal(FiveSec.frame.. "Text"), getglobal(FiveSec.frame.. "Spark")
        frame:SetValue(frame.timer)
        --local secondsToRegen = math.ceil(TNEUtils.Select(frame.mode == "reverse", frame.timer, frame.duration - frame.timer))
        local secondsToRegen = TNEUtils.Select(frame.mode == "reverse", frame.timer, frame.duration - frame.timer)
        if (TNE_FiveSec_SplitSeconds) then
          text:SetText(format(TNE_FiveSec_REGENERATION_IN, secondsToRegen))
        else
          text:SetText(format(TNE_FiveSec_REGENERATION_IN_INT, math.ceil(secondsToRegen)))
        end
        -- update the spark. I love the spark
        local sparkPosition = (frame.timer / frame.duration) * frame:GetWidth()
        --spark:SetPoint("CENTER", FiveSec.frame, "LEFT", TNEUtils.Select(sparkPosition < 0, 0, sparkPosition), 0)
        spark:SetPoint("CENTER", FiveSec.frame, "LEFT", sparkPosition, 0)
        spark:Show()
      end
    end
  
  end


  
  -- addon logic
  --------------------------------------------------------------------------------
  
  function FiveSec:CheckInterrupt()

    ----pxd("Interrupt call")
    local frame = getglobal(FiveSec.frame)
    frame.possibleInterruptAt = GetTime()
    if (frame.active) then
      ----pxd("  Already active")
      frame.wasActiveOnInterrupt = true
    else
      ----pxd("  Not active. Starting.")
      frame.wasActiveOnInterrupt = false
      FiveSec:Start()
    end

  end

  function FiveSec:Interrupt()
    --this.timer = TNEUtils.Select(this.mode == "reverse", 0, this.fiveSeconds)
    FiveSec:Stop()
    this.possibleInterruptAt = nil
    this.wasActiveOnInterrupt = nil
  end

  function FiveSecBarFrame_OnEvent()
  
    --if (arg1) then
    --  TNEUtils.CombatEcho(event..": ".. arg1) --debug
    --else
    --  TNEUtils.CombatEcho(event..": no arg1") --debug
    --end

    if (event == "UNIT_MANA") then

      if not (arg1 == "player") then
        return
      end

      local mana = UnitMana("player")
      if (mana > FiveSec.mana and FiveSec.mana > 0) then
        FiveSec.lastGain = GetTime()
        --pxd("Tick at: ".. FiveSec.lastGain)
      --else
      --  local now = GetTime() -- unreliable
      --  if (FiveSec.lastGain) then
      --    FiveSec.lastLoss = now
          --pxd("Loss at: ".. FiveSec.lastLoss)
          --pxd("Difference: ".. 2-math.mod(FiveSec.lastLoss - FiveSec.lastGain, 2))
      --  end
      end
      FiveSec.mana = mana

    elseif (event == "SPELLCAST_STOP") then
  
      if (FiveSec.channeling) then
        -- we just finished casting a channeled spell (does not trigger rule)
        -- do nothing
      elseif (FiveSec.nextSpell) then
        -- an expected spell will trigger the rule
        FiveSec:CheckInterrupt()
      end
      -- reset
      FiveSec.nextSpell = nil
      FiveSec:ClearTooltip()
  
    elseif (event == "SPELLCAST_CHANNEL_START") then
  
      -- channeling spell are interesting if they cost mana
      if (FiveSec:TooltipSpellHasManaCost()) then
        -- flag it so we don't think it's an instant when it stops
        FiveSec.channeling = true
        FiveSec:Start()
      end
      FiveSec:ClearTooltip()

    elseif (event == "SPELLCAST_CHANNEL_STOP") then

        FiveSec.channeling = false

    elseif (event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED") then
  
      -- spell was interrupted. abort
      -- SPELLCAST_FAILED is when out of range, out of mana, spell on cooldown, or right-click-to-clear
      FiveSec.channeling = nil
      FiveSec.nextSpell = nil
      if (this.possibleInterruptAt) then
        --pxd("  EVENT: expected interrupt")
        if (not this.wasActiveOnInterrupt) then
          FiveSec:Interrupt()
          ----pxd("    Was not active: Stopping")
        --else
          ----pxd("    Was active: No action")
        end
        this.possibleInterruptAt = nil
        this.wasActiveOnInterrupt = nil
      else
        --pxd("  EVENT: unexpected interrupt")
      end
      FiveSec:ClearTooltip()
  
    elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE" and FiveSec.nextMelee) then

      -- Raptor Strike and other hunter abilites are on-next-melee with mana cost. a special bunch, those hunters
      if (string.find (arg1, FiveSec.nextMelee)) then
        FiveSec:Start()
        FiveSec.nextMelee = nil
        FiveSec:ClearTooltip()
      end

    elseif (event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then

      -- restore the bar when Blue Dragon aura, Innervate, etc fades
      for i, buff in FiveSec.activeBuffs do
        if (string.find(arg1, buff)) then
          local color = TNE_FiveSec_BarColors["disabled"]
          FiveSecBarFrame:SetStatusBarColor(color.r, color.g, color.b)
          table.remove(FiveSec.activeBuffs, i)
          break
        end
      end

    elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then

      -- interrupt the bar when gaining Blue Dragon aura, Innervate, etc
      for _, buff in TNE_FiveSec_RegenerationBuffs do
        if (string.find(arg1, buff)) then
          local color = TNE_FiveSec_BarColors["enabled"]
          FiveSecBarFrame:SetStatusBarColor(color.r, color.g, color.b)
          --FiveSec:Interrupt()
          table.insert(FiveSec.activeBuffs, buff)
          break
        end
      end

    elseif (event == "UNIT_DISPLAYPOWER") then
      FiveSec:ManaCheck()

    elseif (event == "VARIABLES_LOADED") then
      FiveSec:OnLoadToggle()
    end
  
  end
  
  
  -- addon managment
  --------------------------------------------------------------------------------
  
  function FiveSec:UpdatePosition()
    FiveSecBarFrame:ClearAllPoints()
    if (CastingBarReplacementFrame) then
      FiveSecBarFrame:SetPoint("BOTTOM", "CastingBarReplacementFrame", "TOP", 0, 10)
    else
      FiveSecBarFrame:SetPoint("BOTTOM", "CastingBarFrame", "TOP", 0, 10)
    end
    UIParent_ManageFramePositions()
  end
  
  function TNE_FiveSec_Command(arg1)
  
    if (not arg1) then return end

    local frame = getglobal(FiveSec.frame)
  
    -- reset
    if (string.find(arg1, "^"..TNE_FiveSec_CMD_RESET.."$")) then
      FiveSec:UpdatePosition()
      TNEUtils.PrefixedEcho(FiveSec.name, TNE_FiveSec_HELP_RESET)

    -- about
    elseif (string.find(arg1, "^"..TNE_FiveSec_CMD_ABOUT.."$")) then
      TNEUtils.About(FiveSec)

    -- mode
    elseif (string.find(arg1, "^"..TNE_FiveSec_CMD_MODE)) then
      -- save old mode
      local oldMode = frame.mode
      if (string.find(arg1, "^"..TNE_FiveSec_CMD_MODE.." "..TNE_FiveSec_CMD_MODE_STANDARD)) then
        -- enter standard mode
        TNE_FiveSec_Reverse = TNEUtils.SetVar(FiveSec, TNE_FiveSec_Reverse, false, TNE_FiveSec_HELP_REVERSE_MODE, nil)
        frame.mode = "standard"
      elseif (string.find(arg1, "^"..TNE_FiveSec_CMD_MODE.." "..TNE_FiveSec_CMD_MODE_REVERSE)) then
        -- enter reverse mode
        TNE_FiveSec_Reverse = TNEUtils.SetVar(FiveSec, TNE_FiveSec_Reverse, true, TNE_FiveSec_HELP_REVERSE_MODE, nil)
        frame.mode = "reverse"
      else
        -- show help
        TNEUtils.Help(FiveSec, "mode")
      end
      -- convert timer to new mode
      if (not (frame.mode == oldMode) and (frame.timer > 0)) then
        frame.timer = frame.duration - frame.timer
      end

    -- moving
    elseif (string.find(arg1, "^"..TNE_FiveSec_CMD_MOVE)) then
      if (string.find(arg1, "^"..TNE_FiveSec_CMD_MOVE.." "..TNE_FiveSec_CMD_OFF.."$") or string.find(arg1, "^"..TNE_FiveSec_CMD_MOVE.." "..TNE_FiveSec_CMD_ON.."$")) then
        TNE_FiveSec_Movable = TNEUtils.SetVar(FiveSec, TNE_FiveSec_Movable, string.find(arg1, " "..TNE_FiveSec_CMD_ON.."$"), TNE_FiveSec_HELP_MOVING, nil)
        frame:EnableMouse(TNE_FiveSec_Movable)
        if (TNE_FiveSec_Movable) then
          frame:SetAlpha(TNE_FiveSec_Alpha)
        elseif (frame.timer == 0 or frame.timer == frame.duration) then
          UIFrameFadeOut(frame, frame.fadeOutTime, frame:GetAlpha(), 0)
        end
      else
        TNEUtils.Help(FiveSec, "move")
      end

    -- hidden on/off
    elseif (string.find(arg1, "^"..TNE_FiveSec_CMD_HIDDEN)) then
      if (string.find(arg1, "^"..TNE_FiveSec_CMD_HIDDEN.." "..TNE_FiveSec_CMD_OFF.."$") or string.find(arg1, "^"..TNE_FiveSec_CMD_HIDDEN.." "..TNE_FiveSec_CMD_ON.."$")) then
        TNE_FiveSec_Hidden = TNEUtils.SetVar(FiveSec, TNE_FiveSec_Hidden, string.find(arg1, " "..TNE_FiveSec_CMD_ON.."$"), TNE_FiveSec_HELP_HIDDEN, nil)
        frame:SetAlpha(TNEUtils.Select(TNE_FiveSec_Hidden, 0, TNE_FiveSec_Alpha))
        frame.updateRate = TNEUtils.Select(TNE_FiveSec_Hidden, TNE_FiveSec_10FPS, TNE_FiveSec_25FPS)
      else
        TNEUtils.Help(FiveSec, "hidden")
      end

    -- fraction on/off
    elseif (string.find(arg1, "^"..TNE_FiveSec_CMD_FRACTION)) then
      if (string.find(arg1, "^"..TNE_FiveSec_CMD_FRACTION.." "..TNE_FiveSec_CMD_OFF.."$") or string.find(arg1, "^"..TNE_FiveSec_CMD_FRACTION.." "..TNE_FiveSec_CMD_ON.."$")) then
        TNE_FiveSec_SplitSeconds = TNEUtils.SetVar(FiveSec, TNE_FiveSec_SplitSeconds, string.find(arg1, " "..TNE_FiveSec_CMD_ON.."$"), TNE_FiveSec_HELP_FRACTION, nil)
      else
        TNEUtils.Help(FiveSec, "fraction")
      end

    -- alpha
    elseif (string.find(arg1, "alpha")) then
      local _, _, alpha = string.find(arg1, "alpha (.+)")
      alpha = tonumber(alpha)
      if (alpha >= 0.1 and alpha <= 1.0) then
        if not (frame.timer == 0 or frame.timer == frame.duration) or TNE_FiveSec_Movable then
          local fadeFunction = TNEUtils.Select(TNE_FiveSec_Alpha > alpha, UIFrameFadeOut, UIFrameFadeIn)
          fadeFunction(frame, 0.5, frame:GetAlpha(), alpha)
        end
        TNE_FiveSec_Alpha = alpha
        TNEUtils.PrefixedEcho(FiveSec.name, "Bar alpha value set to $v".. TNE_FiveSec_Alpha.. "$ev.")
      else
        TNEUtils.PrefixedEcho(FiveSec.name, "Invalid alpha value (must be between $v0.1$ev and $v1.0$ev)")
      end

    -- scale
    elseif (string.find(arg1, "scale")) then
      local _, _, scale = string.find(arg1, "scale (.+)")
      scale = tonumber(scale)
      if (scale >= 0.5 and scale <= 2.0) then
        TNE_FiveSec_Scale = scale
        frame:SetScale(TNE_FiveSec_Scale)
        TNEUtils.PrefixedEcho(FiveSec.name, "Bar scaled to $v".. TNE_FiveSec_Scale.. "$ev.")
      else
        TNEUtils.PrefixedEcho(FiveSec.name, "Invalid scale value (must be between $v0.5$ev and $v2.0$ev)")
      end

    -- addon on/off
    elseif (string.find(arg1, "^"..TNE_FiveSec_CMD_OFF.."$") or string.find(arg1, "^"..TNE_FiveSec_CMD_ON.."$")) then
      TNE_FiveSec_Enabled = TNEUtils.ToggleAddon(FiveSec, FiveSec.frame, TNE_FiveSec_Enabled, string.find(arg1, "^"..TNE_FiveSec_CMD_ON.."$"), nil)
      if (TNE_FiveSec_Enabled) then
        frame:Show()
      else
        frame:Hide()
        REGENERATING_MANA, TOTAL_MANA_REGENERATED = nil, 0
      end
      FiveSec:ManaCheck()

    -- link above a frame
    elseif (string.find(arg1, "link above")) then
      local _, _, target = string.find(arg1, "link (.+)")
      frame:ClearAllPoints()
      frame:SetPoint("BOTTOM", getglobal(target), "TOP", 0, 10)

    -- link below a frame
    elseif (string.find(arg1, "link below")) then
      local _, _, target = string.find(arg1, "link (.+)")
      frame:ClearAllPoints()
      frame:SetPoint("TOP", getglobal(target), "BOTTOM", 0, -10)

    -- custom anchor to frame
    elseif (string.find(arg1, "anchor")) then
      local _, _, anchor, target, targetAnchor, ox, oy = string.find(arg1, "anchor (.+) (.+) (.+) (.+) (.+)")
      frame:ClearAllPoints()
      frame:SetPoint(anchor, getglobal(target), targetAnchor, tonumber(ox), tonumber(oy))

    -- help
    elseif (string.find(arg1, TNE_FiveSec_CMD_HELP)) then
      TNEUtils.Help(FiveSec, "list")
       
    -- status
    elseif (arg1 == "") then
      TNEUtils.PrefixedEcho(FiveSec.name, format(TNE_FiveSec_CMD_ADDON_STATUS, "$v"..TNEUtils.Select(TNE_FiveSec_Enabled, TNE_FiveSec_CMD_ENABLED, TNE_FiveSec_CMD_DISABLED).."$ev", "$v"..FiveSec.cmd.. " "..TNE_FiveSec_CMD_HELP.."$ev"))
    else
      TNEUtils.PrefixedEcho(FiveSec.name, format(TNE_FiveSec_CMD_UNKNOWN, "$v"..FiveSec.cmd.. " "..TNE_FiveSec_CMD_HELP.."$ev"))
    end
  
  end


-- TODO: magic numbers everywhere

function TNE_Nightfall_OnLoad()

  TNE_Nightfall_Version = "1.1.4"

  -- set default values. these will be overriden when variables are loaded
  TNE_Nightfall_Default_Enabled = true
  TNE_Nightfall_Default_ShardEnabled = true
  TNE_Nightfall_Default_UseLargeEffect = false
  TNE_Nightfall_Default_SoundEffects = false

  TNE_Nightfall_Enabled = TNE_Nightfall_Default_Enabled
  TNE_Nightfall_ShardEnabled = TNE_Nightfall_Default_ShardEnabled
  TNE_Nightfall_UseLargeEffect = TNE_Nightfall_Default_UseLargeEffect
  TNE_Nightfall_SoundEffects = TNE_Nightfall_Default_SoundEffects

  -- hide both frames to avoid quick flashes
  NightfallFrameEffect1:SetAlpha(0)
  NightfallFrameEffect1Texture:SetVertexColor(1, 0, 0.8) -- COLOR: shadow trance frame
  NightfallFrameEffect2:SetAlpha(0)
  NightfallFrameEffect2Texture:SetVertexColor(1, 0.5, 1) -- COLOR: shard frame

  -- command line
  SlashCmdList["NIGHTFALLCMD"] = TNE_Nightfall_CMD
  SLASH_NIGHTFALLCMD1 = "/nightfall"

end

function TNE_Nightfall_ApplySettings()

  local frame = getglobal("NightfallFrame")

  -- register or unregister when turning modes on or off
  if (TNE_Nightfall_ShardEnabled) then
    frame:RegisterEvent("CHAT_MSG_LOOT")
  else
    frame:UnregisterEvent("CHAT_MSG_LOOT")
  end

  if (TNE_Nightfall_Enabled) then
    frame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
    frame:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")
    if (TNE_Nightfall_UseLargeEffect) then
      NightfallFrameEffect1Texture:SetVertexColor(1, 0, 0.8) -- COLOR: shadow trance frame
      --NightfallFrameEffect1Texture:SetTexture("Interface\\Addons\\TNE_Nightfall\\texture\\flash3.tga")
    else
      NightfallFrameEffect1Texture:SetVertexColor(0.5, 0, 0.4) -- COLOR: shadow trance frame
      --NightfallFrameEffect1Texture:SetTexture("Interface\\Addons\\TNE_Nightfall\\texture\\flash1.tga")
    end
  else
    frame:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
    frame:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")
  end

end


function TNE_Nightfall_OnEvent()

  if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
    if (string.find(arg1, TNE_Nightfall_String_ShadowTrance)) then
      local frame = NightfallFrameEffect1
      UIFrameFlash(frame, 0.2, 0.8, 10, nil, 0.2, 0)
      if (TNE_Nightfall_SoundEffects) then
        PlaySoundFile("Interface\\AddOns\\TNE_Nightfall\\sounds\\ShadowTrance.mp3")
      end
    end
  elseif (event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then
    if (string.find(arg1, TNE_Nightfall_String_ShadowTrance)) then
      local frame = NightfallFrameEffect1
      UIFrameFlashRemoveFrame(frame)
      UIFrameFadeRemoveFrame(frame)
      UIFrameFadeOut(frame, 0.8, frame:GetAlpha(), 0)
    end
  elseif (event == "CHAT_MSG_LOOT") then 
    if (string.find (arg1, TNE_Nightfall_String_YouCreate) and string.find(arg1, TNE_Nightfall_String_SoulShard)) then
      local frame = NightfallFrameEffect2
      UIFrameFlash(frame, 0.01, 0.5, 1, nil, 1, 0)
    end
  end

end

function TNE_Nightfall_CMD(arg1)

  if (not arg1) then
    return
  end

  if (string.find(arg1, "^settings$") or arg1 == "") then
    ShowUIPanel(NightfallSettingsFrame)
    return
  end

end

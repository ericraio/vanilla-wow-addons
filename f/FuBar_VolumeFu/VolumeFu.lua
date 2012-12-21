local L = AceLibrary("AceLocale-2.0"):new("VolumeFu")
local Crayon = AceLibrary("Crayon-2.0")
local Tablet = AceLibrary("Tablet-2.0")

VolumeFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

VolumeFu.version = "2.0."..string.sub("$Revision: 9772 $", 12, -3)
VolumeFu.date = string.sub("$Date: 2006-09-01 19:38:36 -0400 (Fri, 01 Sep 2006) $", 8, 17)
VolumeFu.hasIcon = "Interface\\AddOns\\FuBar_VolumeFu\\icons\\off.tga"
VolumeFu.hasNoText = true
VolumeFu.defaultPosition = "RIGHT"

VolumeFu:RegisterDB("VolumeFuDB")
VolumeFu:RegisterDefaults("profile", {
  quickfix = false,
  mute = false,
  master = tonumber(GetCVar("MasterVolume")),
})

function VolumeFu:OnEnable()
  self:SetIcon(self:GetVolumeIcon())
end

function VolumeFu:OnClick()
  if not self:IsMute() and not self:IsQuickFix() then
    if arg1 == "LeftButton" and IsShiftKeyDown() then
      self:ResetVolume()
    end
  end
end

function VolumeFu:OnDoubleClick()
  self:ToggleMute()
  self:SetIcon(self:GetVolumeIcon())
end

function VolumeFu:OnTooltipUpdate()
  local r, g, b = 1, 1, 0
  local category

  if self:IsMute() then
    category = Tablet:AddCategory(
      "text", Crayon:Red(L["Muted"]),
      "columns", 1,
      "justify", "CENTER",
      "showWithoutChildren", true
    )
  end

  category = Tablet:AddCategory(
    "text", L["Levels"],
    "columns", 2,
    "child_textR", r,
    "child_textG", g,
    "child_textB", b
  )

  self:AddTooltipLevel(category, L["Master"], self:GetMasterVolume())
  self:AddTooltipLevel(category, L["Sound"], self:GetSoundVolume())
  self:AddTooltipLevel(category, L["Music"], self:GetMusicVolume())
  self:AddTooltipLevel(category, L["Ambience"], self:GetAmbienceVolume())

  category = Tablet:AddCategory(
    "text", L["Settings"],
    "columns", 2,
    "child_textR", r,
    "child_textG", g,
    "child_textB", b
  )

  self:AddTooltipSetting(category, L["Ambience"], self:IsSetAmbience())
  self:AddTooltipSetting(category, L["Error Speech"], self:IsSetErrorSpeech())
  self:AddTooltipSetting(category, L["Music"], self:IsSetMusic())
  self:AddTooltipSetting(category, L["Sound at Character"], self:IsSetSoundAtCharacter())
  self:AddTooltipSetting(category, L["Emote Sounds"], self:IsSetEmoteSounds())
  self:AddTooltipSetting(category, L["Loop Music"], self:IsSetLoopMusic())

  if not self:IsMute() and self:IsQuickFix() then
    self:ResetVolume()
  end

  if self:IsMute() then
    Tablet:SetHint(L["MuteOn-hint"])
  else
    if self:IsQuickFix() then
      Tablet:SetHint(L["QuickFix-hint"].."\n"..L["MuteOff-hint"])
    else
      Tablet:SetHint(L["RegularFix-hint"].."\n"..L["MuteOff-hint"])
    end
  end
end

local options = {
  handler = VolumeFu,
  type = "group",
  args = {
    mute = {
      type = "toggle",
      order = 1.0,
      name = L["Mute"],
      desc = L["Mute sound"],
      get = "IsMute",
      set = "ToggleMute",
    },
    quickfix = {
      type = "toggle",
      order = 1.1,
      name = L["Quick Fix"],
      desc = L["Always reset game volume on mouseover"],
      get = "IsQuickFix",
      set = "ToggleQuickFix",
    },
    levels = {
      type = "group",
      order = 1.2,
      name = L["Levels"],
      desc = L["Set volume levels"],
      disabled = function() return VolumeFu:IsMute() end,
      args = {
        master = {
          type = "range",
	  order = 1.0,
          name = L["Master"],
          desc = L["Set the master volume"],
          max = 1, 
          min = 0,
          step = 0.01,
          isPercent = true,
          get = "GetMasterVolume",
          set = "SetMasterVolume",
        },
        sound = {
          type = "range",
	  order = 1.1,
          name = L["Sound"],
          desc = L["Set the sound volume"],
          max = 1,
          min = 0,
          step = 0.01,
          isPercent = true,
          get = "GetSoundVolume",
          set = "SetSoundVolume",
        },
        music = {
          type = "range",
	  order = 1.2,
          name = L["Music"],
          desc = L["Set the music volume"],
          max = 1,
          min = 0,
          step = 0.01,
          isPercent = true,
          get = "GetMusicVolume",
          set = "SetMusicVolume",
        },
        ambience = {
          type = "range",
	  order = 1.3,
          name = L["Ambience"],
          desc = L["Set the ambience volume"],
          max = 1,
          min = 0,
          step = 0.01,
          isPercent = true,
          get = "GetAmbienceVolume",
          set = "SetAmbienceVolume",
        },
      },
    },
    settings = {
      type = "group",
      order = 1.2,
      name = L["Settings"],
      desc = L["Change volume settings"],
      disabled = function() return VolumeFu:IsMute() end,
      args = {
        soundeffects = {
          type = "toggle",
	  order = 1.0,
          name = L["Sound Effects"],
          desc = L["Toggle master sound effects"],
          get = "IsSetMasterSoundEffects",
          set = "ToggleMasterSoundEffects",
        },
        ambience = {
          type = "toggle",
	  order = 1.1,
          name = L["Ambience"],
          desc = L["Toggle ambient noise"],
          get = "IsSetAmbience",
          set = "ToggleAmbience",
        },
        errorspeech = {
          type = "toggle",
	  order = 1.2,
          name = L["Error Speech"],
          desc = L["Toggle error speech"],
          get = "IsSetErrorSpeech",
          set = "ToggleErrorSpeech",
        },
        music = {
          type = "toggle",
	  order = 1.3,
          name = L["Music"],
          desc = L["Toggle music"],
          get = "IsSetMusic",
          set = "ToggleMusic",
	},
        soundatcharacter = {
          type = "toggle",
	  order = 1.4,
          name = L["Sound at Character"],
          desc = L["Toggle sound at character"],
          get = "IsSetSoundAtCharacter",
          set = "ToggleSoundAtCharacter",
	},
	emotesounds = {
          type = "toggle",
	  order = 1.5,
          name = L["Emote Sounds"],
          desc = L["Toggle emote sounds"],
          get = "IsSetEmoteSounds",
          set = "ToggleEmoteSounds",
	},
	loopmusic = {
          type = "toggle",
	  order = 1.6,
          name = L["Loop Music"],
          desc = L["Toggle loop music"],
          get = "IsSetLoopMusic",
          set = "ToggleLoopMusic",
	},
      },
    },
  },
}

VolumeFu:RegisterChatCommand({"/volumefu", "/volfu", "/vfu"}, options)
VolumeFu.OnMenuRequest = options


function VolumeFu:AddTooltipLevel(category, label, level)
  local r, g, b = Crayon:GetThresholdColor(level)
  category:AddLine(
    "text", label, 
    "text2", format("%d%%", floor(100 * level + 0.5)),
    "text2R", r,
    "text2G", g,
    "text2B", b
  )
end

local MAP_ONOFF = { [false] = "|cffff0000Off|r", [true] = "|cff00ff00On|r" }
function VolumeFu:AddTooltipSetting(category, label, value)
  category:AddLine(
    "text", label,
    "text2", MAP_ONOFF[value]
  )
end

function VolumeFu:ResetVolume()
  local volume = self:GetMasterVolume()
  SetCVar("MasterVolume", 0)
  SetCVar("MasterVolume", volume)
end

function VolumeFu:GetVolumeIcon()
  local path = "Interface\\AddOns\\FuBar_VolumeFu\\icons\\"
  local volume = self:GetMasterVolume()
  if volume > 0.66 then
    path = path.."high"
  elseif volume > 0.33 then
    path = path.."medium"
  elseif volume > 0 then
    path = path.."low"
  else
    path = path.."off"
  end  
  if self:IsMute() then
    path = path.."-mute"
  end
  return path..".tga"
end

function VolumeFu:IsQuickFix()
  return self.db.profile.quickfix
end

function VolumeFu:ToggleQuickFix()
  self.db.profile.quickfix = not self.db.profile.quickfix
  self:Update()
  return self.db.profile.quickfix
end 

function VolumeFu:IsMute()
  return self.db.profile.mute
end

function VolumeFu:ToggleMute()
  self.db.profile.mute = not self.db.profile.mute
  if self.db.profile.mute then
    SetCVar("MasterVolume", 0)
  else
    SetCVar("MasterVolume", self.db.profile.master)
  end
  self:SetIcon(self:GetVolumeIcon())
  self:Update()
  return self.db.profile.mute
end

function VolumeFu:GetMasterVolume()
  return self.db.profile.master
end

function VolumeFu:SetMasterVolume(value)
  self.db.profile.master = value
  SetCVar("MasterVolume", value)
  self:SetIcon(self:GetVolumeIcon())
end

function VolumeFu:GetSoundVolume()
  return tonumber(GetCVar("SoundVolume"))
end

function VolumeFu:SetSoundVolume(value)
  SetCVar("SoundVolume", value)
  self:SetIcon(self:GetVolumeIcon())
end

function VolumeFu:GetMusicVolume()
  return tonumber(GetCVar("MusicVolume"))
end

function VolumeFu:SetMusicVolume(value)
  SetCVar("MusicVolume", value)
  self:SetIcon(self:GetVolumeIcon())
end

function VolumeFu:GetAmbienceVolume()
  return tonumber(GetCVar("AmbienceVolume"))
end

function VolumeFu:SetAmbienceVolume(value)
  SetCVar("AmbienceVolume", value)
  self:SetIcon(self:GetVolumeIcon())
end

function VolumeFu:IsSetMasterSoundEffects()
  return GetCVar("MasterSoundEffects") == "1"
end

function VolumeFu:ToggleMasterSoundEffects()
  SetCVar("MasterSoundEffects", GetCVar("MasterSoundEffects") == "1" and 0 or 1)
end

function VolumeFu:IsSetMusic()
  return GetCVar("EnableMusic") == "1"
end

function VolumeFu:ToggleMusic()
  SetCVar("EnableMusic", GetCVar("EnableMusic") == "1" and 0 or 1)
end

function VolumeFu:IsSetSoundAtCharacter()
  return GetCVar("SoundListenerAtCharacter") == "1"
end

function VolumeFu:ToggleSoundAtCharacter()
  SetCVar("SoundListenerAtCharacter", GetCVar("SoundListenerAtCharacter") == "1" and 0 or 1)
end

function VolumeFu:IsSetEmoteSounds()
  return GetCVar("EmoteSounds") == "1"
end

function VolumeFu:ToggleEmoteSounds()
  SetCVar("EmoteSounds", GetCVar("EmoteSounds") == "1" and 0 or 1)
end

function VolumeFu:IsSetLoopMusic()
  return GetCVar("SoundZoneMusicNoDelay") == "1"
end

function VolumeFu:ToggleLoopMusic()
  SetCVar("SoundZoneMusicNoDelay", GetCVar("SoundZoneMusicNoDelay") == "1" and 0 or 1)
end

function VolumeFu:IsSetAmbience()
  return GetCVar("EnableAmbience") == "1"
end

function VolumeFu:ToggleAmbience()
  SetCVar("EnableAmbience", GetCVar("EnableAmbience") == "1" and 0 or 1)
end

function VolumeFu:IsSetErrorSpeech()
  return GetCVar("EnableErrorSpeech") == "1"
end

function VolumeFu:ToggleErrorSpeech()
  SetCVar("EnableErrorSpeech", GetCVar("EnableErrorSpeech") == "1" and 0 or 1)
end
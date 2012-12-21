
TNE_UTILS_VERSION = 9

local RGBColors = {
  ["value"] = { r=255, g=229, b=102, },
  ["normal"] = { r=1, g=0.82, b=0, }, -- NORMAL_FONT_COLOR
  ["white"] = { r=255, g=255, b=255, },
  ["black"] = { r=0, g=0, b=0, },
  ["red"] = { r=255, g=0, b=0, },
  ["green"] = { r=0, g=255, b=0, },
  ["blue"] = { r=0, g=0, b=255, },
  ["gold"] = { r=255, g=229, b=102, },
  ["silver"] = { r=212, g=212, b=212, },
  ["copper"] = { r=255, g=136, b=68, },
}

local HexColors = {
  ["stop"] = "|r",
  ["value"] = "|cFFFFE566", -- I use this to highlight stuff
  ["normal"] = "|cFFFFD100", -- NORMAL_FONT_COLOR
  ["white"] = "|cFFFFFFFF",
  ["black"] = "|cFF000000",
  ["red"] = "|cFFFF2211",
  ["green"] = "|cFF22FF11",
  ["blue"] = "|cFF1122FF",
  ["gold"] = "|cFFFFE566",
  ["silver"] = "|cFFD4D4D4",
  ["copper"] = "|cFFFF8844",
}

-- select b or c, depending on a

function TNE_Local_Select(a, b, c)
  if a then return b else return c end
end


-- Show a message in any message frame

function TNE_Local_MessageToFrame(msg, frame, r, g, b, duration)

  if (type(frame) == "string") then
    frame = getglobal(frame)
  end
  if (msg and frame) then
    if (r and g and b) then
      if (duration) then
        frame:AddMessage(msg, r, g, b, 1.0, duration)
      else
        frame:AddMessage(msg, r, g, b, 1.0, UIERRORS_HOLD_TIME)
      end
    else
      frame:AddMessage(msg)
    end
  end

end

-- Show a message in the ui error frame

function TNE_Local_Alert(msg, r, g, b)
  TNE_Local_MessageToFrame(msg, UIErrorsFrame, r, g, b, UIERRORS_HOLD_TIME)
end



-- Show a message in the combat log

function TNE_Local_CombatEcho(msg, stripColor)

  if (msg and ChatFrame2) then
    if (stripColor) then
      msg = TNE_Local_StripColorTags(msg)
    else
      msg = TNE_Local_ApplyColorTags(msg)
    end
    TNE_Local_MessageToFrame(msg, ChatFrame2)
  end

end


-- Show a prefixed message in the default chat frame 
-- ie 'AddonName: Help message'

function TNE_Local_PrefixedEcho(prefix, msg, r, g, b)

  if (prefix and msg) then
    TNE_Local_Echo(format("%s: %s", prefix, msg), r, g, b)
  end

end


-- Show a message in the default chat frame 

function TNE_Local_Echo(msg)
  TNE_Local_MessageToFrame(TNE_Local_ApplyColorTags(msg), DEFAULT_CHAT_FRAME)
end

-- Shows an about message for specified addon

function TNE_Local_About(addon)
  local msg = addon.name.. " version $v".. addon.version..
    "$ev by $v".. addon.author.. "$ev.\nEmail: $v".. addon.email..
    "$ev\nCompatible with World of Warcraft build $v".. addon.supportedbuild..
    "$ev.\nLatest update: $v".. addon.lastupdate.. "$ev."
  TNE_Local_Echo(msg)
end


-- Toggles an addon on or off by registering/unregistering its events
-- MyAddonEnabled = TNEUtils.ToggleAddon(MyAddon, "MyAddonFrame", MyAddonEnabled, true, true) to enable and show the frame

function TNE_Local_Toggle_Addon(addon, frameName, addonEnabled, toggleOn, showFrame)

  if (toggleOn) then
    if (not addonEnabled) then
      addonEnabled = true
      TNE_Local_RegisterEvents(frameName, addon.events)
      TNE_Local_PrefixedEcho(addon.name, "Addon $venabled$ev. Use $v".. addon.cmd.. " off$ev to disable.");
      if (showFrame) then
        getglobal(frameName):Show()
      end
    else
      TNE_Local_PrefixedEcho(addon.name, "Addon is already $venabled$ev. Use $v".. addon.cmd.. " off$ev to disable.");
    end
  else
    if (addonEnabled) then
      addonEnabled = false
      TNE_Local_UnregisterEvents(frameName, addon.events)
      TNE_Local_PrefixedEcho(addon.name, "Addon $vdisabled$ev. Use $v".. addon.cmd.. " on$ev to enable.");
      getglobal(frameName):Hide()
    else
      TNE_Local_PrefixedEcho(addon.name, "Addon is already $vdisabled$ev. Use $v".. addon.cmd.. " on$ev to enable.");
    end
  end

  return addonEnabled

end

-- Sets a variable on or off

function TNE_Local_Set_Var(addon, variable, toggleOn, description, cmd, flag)

  if (variable) then
    if (toggleOn) then
      local s = description.. " is already $venabled$ev."
      if (cmd) then
        if (flag) then cmd = cmd.. " off" end
        s = s.. " Use $v".. addon.cmd .." ".. cmd.. "$ev to disable."
      end
      TNE_Local_PrefixedEcho(addon.name,  s);
    else
      TNE_Local_PrefixedEcho(addon.name, description.. " $vdisabled$ev.");
      variable = false
    end
  else
    if (toggleOn) then
      TNE_Local_PrefixedEcho(addon.name, description.. " $venabled$ev.");
      variable = true
    else
      local s = description.. " is already $vdisabled$ev."
      if (cmd) then
        if (flag) then cmd = cmd.. " on" end
        s = s.. " Use $v".. addon.cmd .." ".. cmd.. "$ev to enable."
      end
      TNE_Local_PrefixedEcho(addon.name, s);
    end
  end

  return variable

end

-- Registers events with a frame
function TNE_Local_RegisterEvents(frame, events)

  if (type(frame) == "string") then
    frame = getglobal(frame)
  end
  table.foreach(events, function(key, value) frame:RegisterEvent(value) end)

end


-- Unregisters events from a frame
function TNE_Local_UnregisterEvents(frame, events)

  if (type(frame) == "string") then
    frame = getglobal(frame)
  end
  table.foreach(events, function(key, value) frame:UnregisterEvent(value) end)

end


-- Show help string based on topic

function TNE_Local_Help(addon, topic)

  if (addon and addon.help) then
    if (topic == "onload") then
      local msg = "%s: $v%s$ev loaded. Use $v%s$ev for quick help."
      TNE_Local_Echo(format(msg, addon.name, addon.version, addon.cmd))
      return true
    elseif (topic == "list") then
      local msg = "%s: %s"
      TNE_Local_Echo(format(msg, addon.name, "List of commands:"))
      table.foreach(addon.help, function(key, value) TNE_Local_Echo(value) end)
      return true
    elseif (addon.help[topic]) then
      TNE_Local_PrefixedEcho(addon.name, addon.help[topic])
      return true
    else
      TNE_Local_PrefixedEcho(addon.name, "Help not available for $v".. topic.. "$ev.")
      return false
    end
  end

end


-- Strips color tags from a string

function TNE_Local_StripColorTags(s)
  return string.gsub(string.gsub(s, "$ev", ""), "$v", "")
end


-- Adds color tags from a string

function TNE_Local_ApplyColorTags(s, color)
  local c = HexColors[color] or HexColors["value"]
  return string.gsub(string.gsub(s, "$ev", HexColors["stop"]), "$v", c)
end


-- Count table entries for string-indexed tables
-- (inspired by code from Gazmik Fizzwidget)

function TNE_Local_TableLength(t)
  local n = nil
  if (t and type(t) == "table") then
    n = 0
    for _ in t do
      n = n + 1
    end
  end
  return n
end


-- only use the most recent util library
-- thanks to Gazmik Fizzwidget (I ended up using a pattern very similar to his utilites)

if (not TNEUtils) then
  TNEUtils = {}
end

local Utils = TNEUtils

if ((not Utils.version) or Utils.version < TNE_UTILS_VERSION) then

  Utils.AlertTo = TNE_Local_MessageToFrame
  Utils.Echo = TNE_Local_Echo
  Utils.PrefixedEcho = TNE_Local_PrefixedEcho
  Utils.Alert = TNE_Local_Alert
  Utils.CombatEcho = TNE_Local_CombatEcho

  Utils.Select = TNE_Local_Select
  Utils.SetVar = TNE_Local_Set_Var
  Utils.ToggleAddon = TNE_Local_Toggle_Addon
  Utils.About = TNE_Local_About
  Utils.UnregisterEvents = TNE_Local_UnregisterEvents
  Utils.RegisterEvents = TNE_Local_RegisterEvents

  Utils.Help = TNE_Local_Help
  Utils.StripColorTags = TNE_Local_StripColorTags
  Utils.ApplyColorTags = TNE_Local_ApplyColorTags

  Utils.TableLength = TNE_Local_TableLength

  Utils.RGB = RGBColors
  Utils.Hex = HexColors

  Utils.version = TNE_UTILS_VERSION

end
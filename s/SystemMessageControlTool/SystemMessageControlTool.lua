--[[
    - System Message Control Tool

    - Redirect certain system messages to different chat windows or completely mute them.

    - Version: 1.28
]]

smctVars = {
  name = "System Message Control Tool",
  version = "1.28",
  count = 0,
  realmName = GetCVar("realmName"),
  playerName = UnitName("player"),
  curID = nil,
  curGroup = nil,
  events = nil,
  chatWindows = nil,
  profileOpenID = nil,
  chatSystemUpdated = {},
  chatGroupsAdded = false,
  chatMenuItemsAdded = false;
  ChatFrame_OnEvent = nil,
  FCF_Tab_OnClick = nil,
  FCF_SetChatTypeColor = nil,
  FCF_CancelFontColorSettings = nil,
  FCFMessageTypeDropDown_OnClick = nil,
  channels = {},
  channelsIgnore = {
    ["CT_RA_Channel"] = "variable",
    ["DamageMeters_syncChannel"] = "variable",
  },
  coreSystemGroups = {
    [1] = "OFFICER",
    [2] = "GUILD_MOTD",
  },
  predefinedColors = {
    [1] = {event="SYSTEM", description="System"},
    [2] = {event="LOOT", description="Loot"},
    [3] = {event="MONEY", description="Money loot"},
    [4] = {event="BG_SYSTEM_ALLIANCE", description="BG: Alliance"},
    [5] = {event="BG_SYSTEM_HORDE", description="BG: Horde"},
    [6] = {event="BG_SYSTEM_NEUTRAL", description="BG: Neutral"},
    [7] = {event="CHANNEL_LIST", description="Channel list"},
    [8] = {event="PARTY", description="Party"},
    [9] = {event="RAID", description="Raid"},
    [10] = {event="GUILD", description="Guild"},
    [11] = {event="OFFICER", description="Officer"},
    [12] = {event="SKILL", description="Skill-up"},
  },
  text = {
    closeWindow = "Close window",
    muted = "Muted",
    passthrough = "Pass-through",
    multipleWindows = "Multiple windows",
    floating = "Floating",
    windowSelectHeader = "Select message action",
    colorGroupError = "ERROR: Couldn't find color group.",
    optionOpenError = "ERROR: Frame already active.",
  },
  helpText = {
    [1] = "|cff9bb6efHelp/information for SMCT|r";
    [2] = "";
    [3] = "|cfff7a21ePass-through:|r";
    [4] = "The pass-through setting means that SMCT will ignore messages from that group and send them back into the original chat system, so it can do whatever it is setup to do.";
    [5] = "If you just want to change the color of a message group then you can't leave it at pass-through. You will have to set the window it should be displayed in also.";
    [6] = "";
    [7] = "|cfff7a21eSelecting multiple windows:|r";
    [8] = "You can send messages to multiple chat windows by holding down the shift key while selecting the windows in the menu. When you're done click the \"Close window\" button.";
    [9] = "The \"Floating\" type can also be selected when using multiple windows.";
    [10] = "";
    [11] = "|cfff7a21eProfiles:|r";
    [12] = "Click the \"Profiles\" button to copy settings from other existing profiles to this character.";
  },
  language = string.upper(string.sub(GetLocale(), 1, 2)),
  indexes = {
    ["floating"] = 100,
    ["close"] = -10,
    ["passthrough"] = 0,
    ["muted"] = -1,
  },
  changedChannels = {
  },
};



function smctConvStr(s)
  local s = string.gsub(s, "%-", "%%-");
  s = string.gsub(s, "%+", "%%+");
  s = string.gsub(s, "%?", "%%?");
  s = string.gsub(s, "%.", "%%.");
  s = string.gsub(s, "%*", "%%*");
  s = string.gsub(s, "%%d", "%%d+");
  s = string.gsub(s, "%%s", "[%%S]+[%%s*%%S+]*");
  s = string.gsub(s, "%%%d$s", "[%%S]+[%%s*%%S+]*");
  s = string.gsub(s, "%%%d$d", "[%%S]+");
  return s;
end


function smctConvStr2(s)
  local s = string.gsub(s, "%(", "%%(");
  s = string.gsub(s, "%)", "%%)");
  s = string.gsub(s, "%[", "%%[");
  s = string.gsub(s, "%]", "%%]");
  return smctConvStr(s);
end


function SystemMessageControlTool_OnLoad()
  this:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.9);
  this:SetBackdropColor(0.1, 0.1, 0.1, 1);
  this:RegisterEvent("VARIABLES_LOADED");
end


function SystemMessageControlTool_OnEvent(event)
  if (event == "VARIABLES_LOADED") then
    if (VipersAddonsLoaded) then
      local tablePos = table.getn(VipersAddonsLoaded)+1;
      VipersAddonsLoaded[tablePos] = {};
      VipersAddonsLoaded[tablePos]["NAME"] = smctVars.name;
      VipersAddonsLoaded[tablePos]["VERSION"] = smctVars.version;
      VipersAddonsLoaded[tablePos]["OPTIONSFRAME"] = "SystemMessageControlToolFrame";
    end

    if (not smctSettings) then
      smctSettings = {};
    end
    if (not smctSettings[smctVars.realmName]) then
      smctSettings[smctVars.realmName] = {};
    end
    if (not smctSettings[smctVars.realmName][smctVars.playerName]) then
      smctSettings[smctVars.realmName][smctVars.playerName] = {};
    end

    -- Remove any old settings in case they're there.
    if (smctSettings.windowID) then
      smctSettings.windowID = nil;
    end
    if (smctSettings.windowName) then
      smctSettings.windowName = nil;
    end

    SLASH_SMCT1 = "/smct";
    SlashCmdList["SMCT"] = function(msg)
      SystemMessageControlTool_SlashCommand(msg);
    end

    smctVars.ChatFrame_OnEvent = ChatFrame_OnEvent;
    smctVars.FCF_Tab_OnClick = FCF_Tab_OnClick;
    smctVars.FCF_SetChatTypeColor = FCF_SetChatTypeColor;
    smctVars.FCF_CancelFontColorSettings = FCF_CancelFontColorSettings;
    smctVars.FCFMessageTypeDropDown_OnClick = FCFMessageTypeDropDown_OnClick;
    ChatFrame_OnEvent = SystemMessageControlTool_OnEvent;
    FCF_Tab_OnClick = smctFCF_Tab_OnClick;
    FCF_SetChatTypeColor = smctFCF_SetChatTypeColor;
    FCF_CancelFontColorSettings = smctFCF_CancelFontColorSettings;
    FCFMessageTypeDropDown_OnClick = smctFCFMessageTypeDropDown_OnClick;

    -- Store current active channels.
    local activeChannels = {GetChatWindowChannels(DEFAULT_CHAT_FRAME:GetID())};
    local zoneID, str;
    for i, v in activeChannels do
      if (mod(i, 2) == 1) then
        str = "";
        zoneID = activeChannels[(i+1)];
        if (zoneID > 0) then
          str = smctConvStr(activeChannels[(i+1)]..". "..v.." - %s");
        else
          str = v;
        end
        table.insert(smctVars.channels, str)
      end
    end

    table.insert(UISpecialFrames, "SystemMessageControlToolFrame");

    if ((not VipersAddonsSettings) or ((VipersAddonsSettings) and (not VipersAddonsSettings["SURPRESSLOADMSG"])) and (DEFAULT_CHAT_FRAME)) then
      DEFAULT_CHAT_FRAME:AddMessage("|cffffffff- |cff00f100Viper's "..smctVars.name.." is loaded (version "..smctVars.version..").");
    end
    return;
  elseif (smctVars.events[event]) then
    local strFound = false;
    local group, func;
    if (smctVars.events[event].doSearch) then
      for i, v in smctVars.events[event].groups do
        if (smctSkipGroup(v.group)) then
          next(smctVars.events[event].groups);
        end
        for n, k in v.strings do
          if (string.find(arg1, k)) then
            local str = arg1;
            func = smctVars.events[event].func;
            if (func) then
              str = func(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
            end
            if ((str) and (smctSetOutput(v.group, str))) then
              return;
            end
            if (str == false) then
              return;
            end
            strFound = true;
            break;
          end
        end
        if (strFound) then
          break;
        end
      end
    else
      func = smctVars.events[event].func;
      if ((func) and (func(smctVars.events[event].groups[1].group, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9))) then
        return;
      end
    end
  elseif (event == "UPDATE_CHAT_WINDOWS") then
    smctVars.ChatFrame_OnEvent(event);
    if (not smctVars.chatSystemUpdated[this:GetID()]) then
      local i = 1;
      local frame = getglobal("ChatFrame"..i);
      local GuildFrame = false;
      while (frame.messageTypeList[n]) do
        if (frame.messageTypeList[n] == "GUILD") then
          DEFAULT_CHAT_FRAME:AddMessage("- GUILD: "..i);
          ChatFrame_RemoveMessageGroup(frame, "GUILD");
          GuildFrame = true;
        end
        n = n + 1;
      end
      
      if (not smctVars.chatMenuItemsAdded) then
        CHAT_MSG_GUILD = "Guild: Normal";
        CHAT_MSG_OFFICER = "Guild: Officer";
        GUILD_MOTD = "Guild: MOTD";
        ChatTypeInfo["GUILD_MOTD"] = {sticky=0};
        ChatTypeGroup["GUILD"] = {
          "CHAT_MSG_GUILD",
        };
        ChatTypeGroup["OFFICER"] = {
          "CHAT_MSG_OFFICER",
        };
        ChatTypeGroup["GUILD_MOTD"] = {
          "GUILD_MOTD",
        };
        table.insert(ChannelMenuChatTypeGroups, 4, "OFFICER");
        table.insert(ChannelMenuChatTypeGroups, 5, "GUILD_MOTD");
        FCF_LoadChatSubTypes(ChannelMenuChatTypeGroups);
        smctVars.chatMenuItemsAdded = true;
      end

      if (GuildFrame) then
        ChatFrame_AddMessageGroup(this, "GUILD");
      end
      smctVars.chatSystemUpdated[this:GetID()] = true;
    end
    for i, v in smctVars.coreSystemGroups do
      if (not ((smctSettings[smctVars.realmName][smctVars.playerName][v]) and (smctSettings[smctVars.realmName][smctVars.playerName][v].windowID))) then
        smctSettings[smctVars.realmName][smctVars.playerName][v] = {};
        smctSettings[smctVars.realmName][smctVars.playerName][v].windowID = {};
        table.insert(smctSettings[smctVars.realmName][smctVars.playerName][v].windowID, 1);
      end
      for n, k in smctSettings[smctVars.realmName][smctVars.playerName][v].windowID do
        if (k == this:GetID()) then
          local c = 1;
          local skipAdd = false;
          while (this.messageTypeList[c]) do
            if (this.messageTypeList[c] == v) then
              skipAdd = true;
              break;
            end
            c = c + 1;
          end
          if (not skipAdd) then
            ChatFrame_AddMessageGroup(this, v);
          end
        end
      end
      smctVars.chatGroupsAdded = true;
    end
    return;
  elseif (event == "GUILD_MOTD") then
    local doMOTD = false;
    local settings = smctSettings[smctVars.realmName][smctVars.playerName][event];
    if ((settings) and (settings.windowID)) then
      for i, v in settings.windowID do
        if (v == this:GetID()) then
          doMOTD = true;
          break;
        end
      end
    end
    if (doMOTD) then
      if ((settings) and (settings.r)) then
        ChatTypeInfo[event].r = settings.r;
        ChatTypeInfo[event].g = settings.g;
        ChatTypeInfo[event].b = settings.b;
      else
        ChatTypeInfo[event].r = ChatTypeInfo["GUILD"].r;
        ChatTypeInfo[event].g = ChatTypeInfo["GUILD"].g;
        ChatTypeInfo[event].b = ChatTypeInfo["GUILD"].b;
      end
      local info = ChatTypeInfo["GUILD_MOTD"];
      local string = format(TEXT(GUILD_MOTD_TEMPLATE), arg1);
      this:AddMessage(string, info.r, info.g, info.b, info.id);
    end
    return;
  end

  smctVars.ChatFrame_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
end


function smctSkipGroup(group)
  local doSkip = false;
  if ((not smctSettings[smctVars.realmName][smctVars.playerName][group]) or ((smctSettings[smctVars.realmName][smctVars.playerName][group].windowID ~= nil) and (smctSettings[smctVars.realmName][smctVars.playerName][group].windowID == smctVars.indexes.passthrough))) then
    doSkip = true;
  end
  if ((not doSkip) and (strupper(type(smctSettings[smctVars.realmName][smctVars.playerName][group].windowID)) == "TABLE")) then
    for i, v in smctSettings[smctVars.realmName][smctVars.playerName][group].windowID do
      if (v == -smctVars.indexes.muted) then
        doSkip = true;
        break;
      end
    end
  end
  return doSkip;
end


function smctVerifyFrame(ID)
  local frame = getglobal("ChatFrame"..ID);
  local frameActive = false;
  if (frame) then
    frameActive = true;
    if (not frame:IsShown()) then
      frameActive = false;
      for index, value in DOCKED_CHAT_FRAMES do
        if (value:GetName() == "ChatFrame"..ID) then
          frameActive = true;
          break;
        end
      end
    end
  end
  return frameActive, frame;
end


function smctSetOutput(group, s)
  local frameActive, frame, color;
  local settings = smctSettings[smctVars.realmName][smctVars.playerName][group];
  if ((settings) and (settings.windowID)) then
    if (strupper(type(settings.windowID)) == "TABLE") then
      color = smctGetColor(group);
      local didDeliver = false;
      for i, v in settings.windowID do
        if (v == smctVars.indexes.muted) then
          return true;
        elseif (v == smctVars.indexes.floating) then
          UIErrorsFrame:AddMessage(s, color.r, color.g, color.b, 1.0, UIERRORS_HOLD_TIME);
          didDeliver = true;
        else
          frameActive, frame = smctVerifyFrame(v);
          if (frameActive) then
            frame:AddMessage(s, color.r, color.g, color.b);
            didDeliver = true;
          end
        end
      end
      if (didDeliver) then
        return true;
      else
        return false;
      end
    elseif (settings.windowID == smctVars.indexes.muted) then
      return true;
    elseif (settings.windowID == smctVars.indexes.floating) then
      color = smctGetColor(group);
      UIErrorsFrame:AddMessage(s, color.r, color.g, color.b, 1.0, UIERRORS_HOLD_TIME);
      return true;
    elseif (settings.windowID > smctVars.indexes.passthrough) then
      -- Old code for compatability.
      frameActive, frame = smctVerifyFrame(settings.windowID);
      if (frameActive) then
        color = smctGetColor(group);
        frame:AddMessage(s, color.r, color.g, color.b);
        return true;
      end
    end
  end
  return false;
end


function SystemMessageControlTool_SlashCommand(s)
  if (SystemMessageControlToolFrame:IsVisible()) then
    SystemMessageControlToolFrame:Hide();
  else
    if (not SystemMessageControlToolPredefinedColorsFrame:IsVisible()) then
      SystemMessageControlToolFrame:Show();
    else
      smctSendChatMessage(smctVars.text.optionOpenError);
    end
  end
end


function smctSendChatMessage(s)
  if (DEFAULT_CHAT_FRAME) then
    DEFAULT_CHAT_FRAME:AddMessage("[SMCT] "..s, 0.75, 0.8, 1);
  end
end


function SystemMessageControlTool_OnHide()
  if (SystemMessageControlToolChatWindowsFrame:IsShown()) then
    SystemMessageControlToolChatWindowsFrame:Hide();
  end
  if (SystemMessageControlToolProfileFrame:IsShown()) then
    SystemMessageControlToolProfileFrame:Hide();
  end
end


function SystemMessageControlTool_OnShow()
  local groups = {};
  local sortedEvents = {};
  local fName = this:GetName();
  local c = 1;
  local tmp, color, winName;
  local str = "";

  getglobal(fName.."HeaderText"):SetText(smctVars.name);
  getglobal(fName.."Version"):SetText("Version "..smctVars.version);
  for i, v in smctVars.helpText do
    str = str..v.."\n";
  end
  getglobal(fName.."Help"):SetText(str);
  getglobal(fName.."Help"):SetTextColor(0.8, 0.8, 0.8);

  table.insert(sortedEvents, smctVars.events["CHAT_MSG_LOOT"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_SYSTEM"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_BG_SYSTEM_ALLIANCE"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_BG_SYSTEM_HORDE"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_BG_SYSTEM_NEUTRAL"]);
  table.insert(sortedEvents, smctVars.events["PLAYER_LEVEL_UP"]);
  table.insert(sortedEvents, smctVars.events["CHARACTER_POINTS_CHANGED"]);
  table.insert(sortedEvents, smctVars.events["TIME_PLAYED_MSG"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_CHANNEL_NOTICE"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_CHANNEL_LIST"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_GUILD"]);
  table.insert(sortedEvents, smctVars.events["CHAT_MSG_OFFICER"]);
  for i, v in sortedEvents do
    for n, k in v.groups do
      if (not groups[k.group]) then
        groups[k.group] = true;
        color = smctGetColor(k.group);
        getglobal(fName.."Group"..c.."ColorSwatchNormalTexture"):SetVertexColor(color.r, color.g, color.b);
        getglobal(fName.."Group"..c.."SetWindow"):SetText(smctGetWindowInfo(k.group));
        getglobal(fName.."Group"..c.."SetWindowText"):SetWidth(120);
        tmp = getglobal(fName.."Group"..c);
        tmp.group = k.group;
        tmp.text = k.name;
        tmp.tooltip = k.description;
        tmp:Show();
        c = c + 1;
      end
    end
  end

  local i = 1;
  smctVars.chatWindows = {
    [1] = {index=smctVars.indexes.close, name=smctVars.text.closeWindow},
    [2] = {index=smctVars.indexes.muted, name=smctVars.text.muted},
    [3] = {index=smctVars.indexes.passthrough, name=smctVars.text.passthrough},
    [4] = {index=smctVars.indexes.floating, name=smctVars.text.floating},
  };
  while (getglobal("ChatFrame"..i)) do
    winName = getglobal("ChatFrame"..i.."TabText"):GetText();
    if (winName ~= "Chat "..i) then
      if (smctVerifyFrame(i)) then
        table.insert(smctVars.chatWindows, {index=i, name=winName});
      end
    end
    i = i + 1;
  end

  this:SetHeight((16*c)+30);
end


function smctGetColor(group)
  local gotColor = false;
  local color = {};
  local saved = smctSettings[smctVars.realmName][smctVars.playerName][group];
  if ((saved) and (saved.r)) then
    color.r = saved.r;
    color.g = saved.g;
    color.b = saved.b;
    gotColor = true;
  elseif (strsub(group, 1, 8) == "CHAT_MSG") then
    local subEvent = string.gsub(strsub(group, 10), "_SMCT%d", "");
    if ((ChatTypeInfo[subEvent]) and (ChatTypeInfo[subEvent].r)) then
      color.r = ChatTypeInfo[subEvent].r;
      color.g = ChatTypeInfo[subEvent].g;
      color.b = ChatTypeInfo[subEvent].b;
      gotColor = true;
    end
  end
  if (not gotColor) then
    color.r = ChatTypeInfo["SYSTEM"].r;
    color.g = ChatTypeInfo["SYSTEM"].g;
    color.b = ChatTypeInfo["SYSTEM"].b;
  end
  return color;
end


function smctGetWindowInfo(group)
  local strGroup = group;
  local group = smctSettings[smctVars.realmName][smctVars.playerName][strGroup];
  local windowName;
  local windowCount = 0;
  local gotWindow = false;
  if (group) then
    if (group.windowID ~= nil) then
      if (strupper(type(group.windowID)) == "TABLE") then
        windowCount = table.getn(group.windowID);
        if (windowCount > 1) then
          windowName = smctVars.text.multipleWindows;
          gotWindow = true;
        elseif (windowCount == 1) then
          local tmpID, tmpName = smctGetActiveWindow(strGroup);
          if (tmpID > 0 and tmpID ~= smctVars.indexes.floating) then
            windowName = "["..tmpID.."] "..tmpName;
          else
            windowName = tmpName;
          end
          gotWindow = true;
        end
      elseif (group.windowID == -1) then
        windowName = smctVars.text.muted;
        gotWindow = true;
      elseif (group.windowID > 0) then
        windowName = "["..group.windowID.."] "..group.windowName;
        -- Convert old stored variables to work with new multiple windows code.
        local tmpWindowID = group.windowID;
        local tmpWindowName = group.windowName;
        group.windowID = {};
        group.windowName = {};
        table.insert(group.windowID, tmpWindowID);
        table.insert(group.windowName, tmpWindowName);
        gotWindow = true;
      end
    end
  end
  if (not gotWindow) then
    windowName = smctVars.text.passthrough;
  end
  return windowName, windowCount;
end


function smctOpenColorPicker(group, ID)
  local btn;
  for i, v in smctVars.predefinedColors do
    btn = getglobal("SystemMessageControlToolPredefinedColorsFrameButton"..i);
    btn:SetWidth(100);
    btn:SetText(v.description);
    btn:SetScript("OnClick", function() smctSetPredefinedColor(this:GetID()) end);
  end
  local color = smctGetColor(group);
  smctVars.curID = ID;
  smctVars.curGroup = group;
  ColorPickerFrame.func = smctSaveColorPicker;
  ColorPickerFrame.cancelFunc = smctCancelColorPicker;
  ColorPickerFrame.hasOpacity = false;
  ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
  ColorPickerFrame.previousValues = {r = color.r, g = color.g, b = color.b};
  SystemMessageControlToolFrame:Hide();
  ColorPickerFrame:Show();
  SystemMessageControlToolPredefinedColorsFrame:Show();
end


function smctSaveColorPicker()
  local r, g, b = ColorPickerFrame:GetColorRGB();
  if (not smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup]) then
    smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup] = {};
  end
  smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup].r = r;
  smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup].g = g;
  smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup].b = b;
  ChangeChatColor("TIME_PLAYED", r, g, b)
  if (not ColorPickerFrame:IsVisible()) then
    SystemMessageControlToolPredefinedColorsFrame:Hide();
    SystemMessageControlToolFrame:Show();
  end
end


function smctCancelColorPicker(previousValues)
  if ((previousValues.r) and (smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup])) then
    smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup].r = previousValues.r;
    smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup].g = previousValues.g;
    smctSettings[smctVars.realmName][smctVars.playerName][smctVars.curGroup].b = previousValues.b;
  end
  if (not ColorPickerFrame:IsVisible()) then
    SystemMessageControlToolPredefinedColorsFrame:Hide();
    SystemMessageControlToolFrame:Show();
  end
end


function smctSetGroupWindow(e)
  local group = e:GetParent().group;
  local ID = e:GetParent():GetID();
  local f = SystemMessageControlToolChatWindowsFrame;
  local c = 0;
  local str, btn, check, subF;
  local fText = getglobal(f:GetName().."HeaderText");
  local maxWidth = 120;
  getglobal(f:GetName().."HeaderText"):SetText(smctVars.text.windowSelectHeader);
  f:SetFrameLevel(e:GetFrameLevel()+1);
  local btnFrameLevel = f:GetFrameLevel()+1;

  for i=1, 11 do
    subF = getglobal(f:GetName().."Button"..i);
    btn = getglobal(subF:GetName().."Button");
    check = getglobal(subF:GetName().."Check");
    if (smctVars.chatWindows[i]) then
      str = smctVars.chatWindows[i].name;
      if (smctVars.chatWindows[i].index > 0) then
        if (smctVars.chatWindows[i].index == smctVars.indexes.floating) then
          str = smctVars.text.floating;
        else
          str = "["..smctVars.chatWindows[i].index.."] "..str;
        end
      end
      if (i == 1) then
        btn:SetTextColor(0.6, 0.6, 0.6);
      end
      if (smctIsWindowSelected(group, smctVars.chatWindows[i].index)) then
        check:Show();
      else
        check:Hide();
      end
      btn.ID = ID;
      btn.name = smctVars.chatWindows[i].name;
      btn.group = group;
      btn:SetID(smctVars.chatWindows[i].index);
      btn:SetText(str);
      btn:SetScript("OnClick", function() smctSetChatWindow(this) end);
      btn:SetFrameLevel((btnFrameLevel+1));
      subF:SetFrameLevel(btnFrameLevel);
      subF:Show();
      c = c + 1;
    else
      subF:Hide();
    end
  end

  f:ClearAllPoints();
  f:SetPoint("TOPLEFT", "SystemMessageControlToolFrameGroup"..ID.."SetWindow", "TOPRIGHT", 0, 0);
  f:SetHeight((14*c)+32);
  f:Show();
end


function smctSetChatWindow(f)
  local action = f:GetID();
  local tmpWindowID, tmpWindowName;
  local multiselect = false;
  local foundAction = false;

  if (IsShiftKeyDown()) then
    multiselect = true;
  end
  if ((action == smctVars.indexes.close) or (not multiselect)) then
    SystemMessageControlToolChatWindowsFrame:Hide();
    if (action == smctVars.indexes.close) then
      return;
    end
  end
  -- Create new group for storing settings.
  if (not smctSettings[smctVars.realmName][smctVars.playerName][f.group]) then
    smctSettings[smctVars.realmName][smctVars.playerName][f.group] = {};
  end
  -- Code for handling compatability with old versions.
  if (strupper(type(smctSettings[smctVars.realmName][smctVars.playerName][f.group].windowID)) ~= "TABLE") then
    if (smctSettings[smctVars.realmName][smctVars.playerName][f.group].windowID) then
      tmpWindowID = smctSettings[smctVars.realmName][smctVars.playerName][f.group].windowID;
      tmpWindowName = smctSettings[smctVars.realmName][smctVars.playerName][f.group].windowName;
      smctAddWindow(tmpWindowID, tmpWindowName, f.group);
    else
      smctAddWindow(0, smctVars.text.passthrough, f.group);
    end
  end

  if (not multiselect) then
    smctUncheckWindows(f);
    smctRemoveWindow(0, f.group);
    smctAddWindow(action, f.name, f.group);
  else
    if (action > smctVars.indexes.passthrough) then
      local didHide = false;
      for i, v in smctSettings[smctVars.realmName][smctVars.playerName][f.group].windowID do
        if (v <= smctVars.indexes.passthrough) then
          if (not didHide) then
            smctUncheckWindows(f);
            didHide = true;
          end
          smctRemoveWindow(i, f.group);
        end
        if (v == action) then
          if (table.getn(smctSettings[smctVars.realmName][smctVars.playerName][f.group].windowID) > 1) then
            smctRemoveWindow(i, f.group);
            foundAction = true;
          else
            return;
          end
        end
      end
      if (not foundAction) then
        smctAddWindow(action, f.name, f.group);
        getglobal(f:GetParent():GetName().."Check"):Show();
      else
        getglobal(f:GetParent():GetName().."Check"):Hide();
      end
    else
      smctUncheckWindows(f);
      smctRemoveWindow(0, f.group);
      smctAddWindow(action, f.name, f.group);
      getglobal(f:GetParent():GetName().."Check"):Show();
    end
  end
  local str = f.name;
  if (table.getn(smctSettings[smctVars.realmName][smctVars.playerName][f.group].windowID) > 1) then
    str = smctVars.text.multipleWindows;
  elseif (action > smctVars.indexes.passthrough) then
    if (not foundAction) then
      if (action == smctVars.indexes.floating) then
        str = smctVars.text.floating;
      else
        str = "["..action.."] "..str;
      end
    else
      local tmpID, tmpName = smctGetActiveWindow(f.group);
      if (tmpID == smctVars.indexes.floating) then
        str = smctVars.text.floating;
      else
        str = "["..tmpID.."] "..tmpName;
      end
    end
  end
  getglobal("SystemMessageControlToolFrameGroup"..f.ID.."SetWindow"):SetText(str);
end


function smctAddWindow(action, name, group)
  if (strupper(type(smctSettings[smctVars.realmName][smctVars.playerName][group].windowID)) ~= "TABLE") then
    smctSettings[smctVars.realmName][smctVars.playerName][group].windowID = {};
    smctSettings[smctVars.realmName][smctVars.playerName][group].windowName = {};
  end
  table.insert(smctSettings[smctVars.realmName][smctVars.playerName][group].windowID, action);
  table.insert(smctSettings[smctVars.realmName][smctVars.playerName][group].windowName, name);
end


function smctRemoveWindow(index, group)
  if (not smctSettings[smctVars.realmName][smctVars.playerName][group].windowID) then
    return;
  end
  if (index == 0) then
    smctSettings[smctVars.realmName][smctVars.playerName][group].windowID = {};
    smctSettings[smctVars.realmName][smctVars.playerName][group].windowName = {};
  else
    table.remove(smctSettings[smctVars.realmName][smctVars.playerName][group].windowID, index);
    table.remove(smctSettings[smctVars.realmName][smctVars.playerName][group].windowName, index);
  end
end


function smctUncheckWindows(f)
  local frameName = f:GetParent():GetParent():GetName();
  for i=1, 11 do
    getglobal(frameName.."Button"..i.."Check"):Hide();
  end
end


function smctGetActiveWindow(group)
  local ID, name = "", "";
  for i, v in smctSettings[smctVars.realmName][smctVars.playerName][group].windowID do
    ID = v;
  end
  for i, v in smctSettings[smctVars.realmName][smctVars.playerName][group].windowName do
    name = v;
  end
  return ID, name;
end


function smctIsWindowSelected(group, index)
  local settings = smctSettings[smctVars.realmName][smctVars.playerName][group];
  if ((settings) and (settings.windowID)) then
    if (strupper(type(settings.windowID)) == "TABLE") then
      for i, v in settings.windowID do
        if (v == index) then
          return true;
        end
      end
    elseif (settings.windowID == index) then
      return true;
    end
  else
    if (index == smctVars.indexes.passthrough) then
      return true;
    end
  end
  return false;
end


function smctTimePlayed(group, arg1, arg2)
  local d, h, m, s, didDeliver;
  d, h, m, s = ChatFrame_TimeBreakDown(arg1);
  local str1 = format(TEXT(TIME_PLAYED_TOTAL), format(TEXT(TIME_DAYHOURMINUTESECOND), d, h, m, s));
  d, h, m, s = ChatFrame_TimeBreakDown(arg2);
  local str2 = format(TEXT(TIME_PLAYED_LEVEL), format(TEXT(TIME_DAYHOURMINUTESECOND), d, h, m, s));
  smctSetOutput(group, str1);
  return smctSetOutput(group, str2);
end


function smctPlayerLevelUp(group, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
  local str, didDeliver;
  didDeliver = smctSetOutput(group, format(TEXT(LEVEL_UP), arg1));

  if (arg3 > 0) then
    str = format(TEXT(LEVEL_UP_HEALTH_MANA), arg2, arg3);
  else
    str = format(TEXT(LEVEL_UP_HEALTH), arg2);
  end
  didDeliver = smctSetOutput(group, str);

  if (arg4 > 0) then
    didDeliver = smctSetOutput(group, format(GetText("LEVEL_UP_CHAR_POINTS", nil, arg4), arg4));
  end

  if (arg5 > 0) then
    didDeliver = smctSetOutput(group, format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT0_NAME), arg5));
  end
  if (arg6 > 0) then
    didDeliver = smctSetOutput(group, format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT1_NAME), arg6));
  end
  if (arg7 > 0) then
    didDeliver = smctSetOutput(group, format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT2_NAME), arg7));
  end
  if (arg8 > 0) then
    didDeliver = smctSetOutput(group, format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT3_NAME), arg8));
  end
  if (arg9 > 0) then
    didDeliver = smctSetOutput(group, format(TEXT(LEVEL_UP_STAT), TEXT(SPELL_STAT4_NAME), arg9));
  end
  return didDeliver;
end


function smctCharacterPointsChanged(group, arg1, arg2)
  local didDeliver = false;
  if (arg2 > 0) then
    local cp1, cp2 = UnitCharacterPoints("player");
    if (cp2) then
      didDeliver = smctSetOutput(group, format(GetText("LEVEL_UP_SKILL_POINTS", nil, cp2), cp2));
    end
  end
  return didDeliver;
end


function smctIsChannelIgnored(channelName)
  local isIgnored = false;
  for i, v in smctVars.channelsIgnore do
    if (v == "variable") then
      if (getglobal(i) == channelName) then
        isIgnored = true;
        break;
      end
    elseif (v == "string") then
      if (i == channelName) then
        isIgnored = true;
        break;
      end
    end
  end
  return isIgnored;
end


function smctChannelNotice(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
  if ((not arg1) or (not arg4)) then
    return false;
  end
  local displayMessage = false;
  if (arg1 == "YOU_JOINED") then
    if (not smctIsChannelIgnored(arg9)) then
      local channelActive = false;
      for i, v in smctVars.channels do
        if (string.find(arg4, v)) then
          channelActive = true;
        end
      end
      if (not channelActive) then
        table.insert(smctVars.channels, (table.getn(smctVars.channels)+1), smctConvStr(arg4));
        displayMessage = true;
      end
    end
  elseif (arg1 == "YOU_LEFT") then
    if (not smctIsChannelIgnored(arg9)) then
      for i, v in smctVars.channels do
        if (string.find(arg4, v)) then
          table.remove(smctVars.channels, i);
          displayMessage = true;
          break;
        end
      end
    end
  elseif (arg1 == "SUSPENDED") then
    if (not smctIsChannelIgnored(arg9)) then
      for i, v in smctVars.channels do
        if (string.find(arg4, v)) then
          table.remove(smctVars.channels, i);
          displayMessage = true;
          break;
        end
      end
    end
  elseif (arg1 == "YOU_CHANGED") then
    if (not smctIsChannelIgnored(arg9)) then
      if (not smctVars.changedChannels[arg4] or time()-smctVars.changedChannels[arg4] > 1) then
        smctVars.changedChannels[arg4] = time();
        displayMessage = true;
      end
    end
  end

  if (displayMessage) then
    local str = string.gsub(getglobal("CHAT_"..arg1.."_NOTICE"), "%%s", arg4);
    return (str);
  else
    return false;
  end
end


function smctBGMessageRerouter(group, arg1)
  return smctSetOutput(group, arg1);
end


function smctSetPredefinedColor(i)
  local color = ChatTypeInfo[smctVars.predefinedColors[i].event];
  if ((color) and (color.r)) then
    ColorPickerFrame:SetColorRGB(color.r, color.g, color.b);
  else
    smctSendChatMessage(smctVars.text.colorGroupError);
  end
end


function smctToggleProfileWindow()
  if (SystemMessageControlToolProfileFrame:IsShown()) then
    SystemMessageControlToolProfileFrame:Hide();
  else
    SystemMessageControlToolProfileFrame:SetHeight(SystemMessageControlToolFrame:GetHeight());
    SystemMessageControlToolProfileFrame:Show();
  end
end


function smctOpenProfiles(f)
  local ID = f:GetID();
  local server = f.server;
  local c = 1;
  local hasChildren;
  local btn, name;
  if (smctVars.profileOpenID) then
    for i=1, 10 do
      getglobal("SystemMessageControlToolProfileFrameButton"..smctVars.profileOpenID.."Name"..i):Hide();
    end
    getglobal("SystemMessageControlToolProfileFrameButton"..smctVars.profileOpenID):SetHeight(14);
    getglobal("SystemMessageControlToolProfileFrameButton"..smctVars.profileOpenID.."Server"):UnlockHighlight();
    if (smctVars.profileOpenID == ID) then
      smctVars.profileOpenID = nil;
      return;
    end
  end
  f:LockHighlight();
  for i, v in smctSettings[server] do
    name = tostring(i);
    hasChildren = false;
    for n, k in smctSettings[server][name] do
      hasChildren = true;
      break;
    end
    if (hasChildren) then
      btn = getglobal(f:GetParent():GetName().."Name"..c);
      btn.server = server;
      btn.name = name;
      btn:SetText(name);
      btn:SetScript("OnClick", function() smctLoadProfile(this) end);
      btn:Show();
      c = c + 1;
    end
    if (c > 10) then
      break;
    end
  end
  for i=c, 10 do
    getglobal(f:GetParent():GetName().."Name"..i):Hide();
  end
  f:GetParent():SetHeight(((c-1)*14)+16);
  smctVars.profileOpenID = ID;
end


function smctLoadProfile(f)
  local name, server = f.name, f.server;
--  SystemMessageControlToolFrame:Hide();
--  smctSendChatMessage("Server: "..server.." - Name: "..name);

  smctSettings[smctVars.realmName][smctVars.playerName] = {};

  for i, v in smctSettings[server][name] do
    smctSettings[smctVars.realmName][smctVars.playerName][i] = {};
    smctSettings[smctVars.realmName][smctVars.playerName][i] = v;
  end
  smctSendChatMessage("Loaded settings from profile (Server: "..server.." - Name: "..name..").");
  SystemMessageControlTool_OnShow();
--  SystemMessageControlToolFrame:Show();
end


function SystemMessageControlTool_Profiles_OnShow()
  local btn, server;
  local c = 1;
  local hasChildren;
  for i, v in smctSettings do
    server = tostring(i);
    hasChildren = false;
    for n, k in smctSettings[server] do
      hasChildren = true;
      break;
    end
    if (hasChildren) then
      btn = getglobal("SystemMessageControlToolProfileFrameButton"..c.."Server");
      btn:SetID(c);
      btn.server = server;
      btn:SetText(server);
      btn:SetScript("OnClick", function() smctOpenProfiles(this) end);
      getglobal("SystemMessageControlToolProfileFrameButton"..c):Show();
    end
    c = c + 1;
    if (c > 15) then
      break;
    end
  end
end


function smctFCF_Tab_OnClick(button)
  smctVars.FCF_Tab_OnClick(button);
  if (button == "RightButton") then
    local frame = getglobal("ChatFrame"..this:GetID());
    local settings = {};
    for i, v in smctVars.coreSystemGroups do
      local colorSettings = smctSettings[smctVars.realmName][smctVars.playerName][v];
      if ((colorSettings) and (colorSettings.r)) then
        ChatTypeInfo[v].r = colorSettings.r;
        ChatTypeInfo[v].g = colorSettings.g;
        ChatTypeInfo[v].b = colorSettings.b;
      else
        local s = string.gsub(v, "_MOTD", "");
        ChatTypeInfo[v].r = ChatTypeInfo[s].r;
        ChatTypeInfo[v].g = ChatTypeInfo[s].g;
        ChatTypeInfo[v].b = ChatTypeInfo[s].b;
      end
      settings[v] = smctSettings[smctVars.realmName][smctVars.playerName][v];
      if (not ((settings[v]) and (settings[v].windowID))) then
        settings[v] = {};
        settings[v].windowID = {};
        table.insert(settings[v].windowID, 1);
      end
      for n, k in settings[v].windowID do
        if (k == this:GetID()) then
          local skipAdd = false;
          local c = 1;
          while (frame.messageTypeList[c]) do
            if (frame.messageTypeList[c] == v) then
              skipAdd = true;
              break;
            end
            c = c + 1;
          end
          if (not skipAdd) then
            ChatFrame_AddMessageGroup(frame, v);
          end
        end
      end
    end
  end
end


function smctFCF_SetChatTypeColor()
  smctVars.FCF_SetChatTypeColor();
  for i, v in smctVars.coreSystemGroups do
    if (UIDROPDOWNMENU_MENU_VALUE == v) then
      if (not smctSettings[smctVars.realmName][smctVars.playerName][v]) then
        smctSettings[smctVars.realmName][smctVars.playerName][v] = {};
      end
      local r, g, b = ColorPickerFrame:GetColorRGB();
      ChatTypeInfo[v].r = r;
      ChatTypeInfo[v].g = g;
      ChatTypeInfo[v].b = b;
      smctSettings[smctVars.realmName][smctVars.playerName][v].r = r;
      smctSettings[smctVars.realmName][smctVars.playerName][v].g = g;
      smctSettings[smctVars.realmName][smctVars.playerName][v].b = b;
    end
  end
end


function smctFCF_CancelFontColorSettings(previousValues)
  smctVars.FCF_CancelFontColorSettings(previousValues);
  if (not previousValues.r) then
    return;
  end
  for i, v in smctVars.coreSystemGroups do
    if (UIDROPDOWNMENU_MENU_VALUE == v) then
      if (not smctSettings[smctVars.realmName][smctVars.playerName][v]) then
        smctSettings[smctVars.realmName][smctVars.playerName][v] = {};
      end
      local r, g, b = ColorPickerFrame:GetColorRGB();
      ChatTypeInfo[v].r = previousValues.r;
      ChatTypeInfo[v].g = previousValues.g;
      ChatTypeInfo[v].b = previousValues.b;
      smctSettings[smctVars.realmName][smctVars.playerName][v].r = previousValues.r;
      smctSettings[smctVars.realmName][smctVars.playerName][v].g = previousValues.g;
      smctSettings[smctVars.realmName][smctVars.playerName][v].b = previousValues.b;
    end
  end
end


function smctFCFMessageTypeDropDown_OnClick()
  smctVars.FCFMessageTypeDropDown_OnClick();
  for i, v in smctVars.coreSystemGroups do
    if (this.value == v) then
      if (not smctSettings[smctVars.realmName][smctVars.playerName][v]) then
        smctSettings[smctVars.realmName][smctVars.playerName][v] = {};
      end
      if (not smctSettings[smctVars.realmName][smctVars.playerName][v].windowID) then
        smctSettings[smctVars.realmName][smctVars.playerName][v].windowID = {};
      end
      if (UIDropDownMenuButton_GetChecked()) then
        for n, k in smctSettings[smctVars.realmName][smctVars.playerName][v].windowID do
          if (FCF_GetCurrentChatFrame():GetID() == k) then
            table.remove(smctSettings[smctVars.realmName][smctVars.playerName][v].windowID, n);
            ChatFrame_RemoveMessageGroup(FCF_GetCurrentChatFrame(), v);
            break;
          end
        end
      else
        table.insert(smctSettings[smctVars.realmName][smctVars.playerName][v].windowID, FCF_GetCurrentChatFrame():GetID());
        ChatFrame_AddMessageGroup(FCF_GetCurrentChatFrame(), v);
      end
    end
  end
end


function smctResetToDefaults()
end

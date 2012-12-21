--[[
  Guild Event Manager by Kiki (European Cho'gall) (Alliance)
    CMD module
]]

--------------- Saved variables ---------------

--------------- Shared variables ---------------

--------------- Local variables ---------------

--------------- Hooked functions ---------------

--------------- Internal functions ---------------


--------------- Exported functions ---------------

function GEM_CMD_Help()
  GEM_ChatPrint("/gem toggle : Shows or hides the GUI (you can also assign a key in your shortcuts)");
  GEM_ChatPrint("/gem join : Rejoin GEM channels, if auto-join failed");
  GEM_ChatPrint("/gem channels : Lists current GEM channels");
  GEM_ChatPrint("/gem addchan <Name> [<Password>] : Adds a new GEM channel with password (optional)");
  GEM_ChatPrint("/gem delchan <Name> : Removes a current GEM channel");
  GEM_ChatPrint("/gem setdefchan <Name> : Changes the default channel for 'New events'");
  GEM_ChatPrint("/gem setalias <ChannelName> <Alias> <SlashCmd> : Sets alias/slashcmd for this channel");
  GEM_ChatPrint("/gem delalias <ChannelName> : Removes alias and slashcmd for this channel");
  GEM_ChatPrint("--- ADVANCED COMMANDS ---");
  GEM_ChatPrint("/gem offset <hours> : Forces an offset from the server (in hours, can be negative)");
  GEM_ChatPrint("--- Debug commands ---");
  GEM_ChatPrint("/gem debug <1/2/0> : Sets or not debug mode (2=debug+log)");
end

function GEM_CMD_Command(cmd,param)
  if(cmd == "toggle")
  then
    GEM_Toggle();
    return true;
  elseif(cmd == "debug")
  then
    if(param == "1")
    then
      GEM_DBG_SetDebugMode(1,true);
      GEM_ChatPrint("Debug mode ON");
    elseif(param == "2")
    then
      GEM_DBG_SetDebugMode(2,true);
      GEM_ChatPrint("Debug mode ON WITH LOG");
    else
      GEM_DBG_SetDebugMode(0,true);
      GEM_ChatPrint("Debug mode OFF");
    end
    return true;
  elseif(cmd == "join")
  then
    GEM_InitChannels(false);
    return true;
  elseif(cmd == "channels")
  then
    GEM_ChatPrint("GEM channels list : <Name> : <Password> : <Alias> : <SlashCmd>");
    for channame, tab in GEM_COM_Channels
    do
      local def = "";
      if(channame == GEM_DefaultSendChannel)
      then
        def = "(Default channel for 'New events')";
      end
      local pwd = tab.password;
      if(pwd == nil or pwd == "")
      then
        pwd = "(no password)";
      end
      local alias = tab.alias;
      if(alias == nil or alias == "")
      then
        alias = "(no alias)";
      end
      local slash = tab.slash;
      if(slash == nil or slash == "")
      then
        slash = "(no slash)";
      end
      GEM_ChatPrint(" - "..channame.." "..def.." : "..pwd.." : "..alias.." : "..slash);
    end
    GEM_ChatPrint("End of listing");
    return true;
  elseif(cmd == "addchan")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    local _,_,chan,pwd = string.find(param,"([^%s]+)%s*(.*)");
    if(not chan)
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    GEMOptions_AddChannel(chan,pwd,"","");
    GEM_ChatPrint("Channel "..chan.." added !");
    return true;
  elseif(cmd == "delchan")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    if(not GEM_COM_Channels[param])
    then
      GEM_ChatPrint("Unknown GEM channel "..param);
      return true;
    end
    GEMOptions_RemoveChannel(param);
    GEM_ChatPrint("Channel "..param.." removed !");
    return true;
  elseif(cmd == "setdefchan")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel name");
      return true;
    end
    if(not GEM_COM_Channels[param])
    then
      GEM_ChatPrint("Unknown GEM channel "..param);
      return true;
    end
    GEM_DefaultSendChannel = param;
    GEM_ChatPrint("Channel "..param.." set as default one for New events !");
    return true;
  elseif(cmd == "setalias")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel");
      return true;
    end
    local _,_,chan,alias,slash = string.find(param,"([^%s]+)%s+([^%s]+)%s+([^%s]+)");
    if(chan == nil or alias == nil or slash == nil or chan == "" or alias == "" or slash == "")
    then
      GEM_ChatPrint("Need to specify a channel, an alias and a slashcmd");
      return true;
    end
    if(not GEM_COM_Channels[chan])
    then
      GEM_ChatPrint("Unknown GEM channel "..chan);
      return true;
    end
    for i,chantab in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
    do
      if(chantab.name == chan)
      then
        chantab.alias = alias;
        chantab.slash = slash;
        break;
      end
    end
    GEM_COM_Channels[chan].alias = alias;
    GEM_COM_Channels[chan].slash = slash;
    GEM_COM_AliasChannel(chan,GEM_COM_Channels[chan].alias,GEM_COM_Channels[chan].slash);
    GEM_ChatPrint("Alias and SlashCmd for channel "..chan.." set to : "..alias.." : "..slash);
    return true;
  elseif(cmd == "delalias")
  then
    if(not param or param == "")
    then
      GEM_ChatPrint("Need to specify a channel");
      return true;
    end
    if(not GEM_COM_Channels[param])
    then
      GEM_ChatPrint("Unknown GEM channel "..param);
      return true;
    end
    for i,chantab in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
    do
      if(chantab.name == param)
      then
        chantab.alias = "";
        chantab.slash = "";
        break;
      end
    end
    GEM_COM_UnAliasChannel(param,GEM_COM_Channels[param].alias,GEM_COM_Channels[param].slash);
    GEM_COM_Channels[param].alias = "";
    GEM_COM_Channels[param].slash = "";
    GEM_ChatPrint("Removed Alias and SlashCmd for channel "..param);
    return true;
  elseif(cmd == "offset")
  then
    local hours = tonumber(param);
    if(hours == nil)
    then
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset = nil;
      GEM_ChatPrint("Removing Forced hours offset !");
    else
      if(hours > 24 or hours < -24)
      then
        GEM_ChatPrint("Hour offset value must be <24 and >-24");
      end
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset = hours;
      GEM_ChatPrint("Forced hour offset to "..hours.." hours !");
    end
    GEM_ServerOffset = 666;
    GEM_ComputeServerOffset();
    GEMNew_Reset();
    return true;
  end
  return false;
end

--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Communication module (parse/send)

    Chaque message envoyé est de la forme :
    <GEM_CMD>-<Stamp>-<EventID>[GEM_TOKEN<Param>]*
     - GEM_CMD : Entier     -- Type de paquet
     - Stamp   : Entier     -- Stamp de l'emetteur au moment de l'envoi du message, relatif au leader de l'event EventID
     - EventID : String     -- EventID de l'event (identifiant unique)
     - Param   : <Variable> -- Parametres associés au type de paquet

Events :
------
 - Update/Create Event : <Leader> <Date> <Place> <Comment> <Max> <Levels> <Class Limits> <Titulars> <Substitutes> <Replacements>
 - Close Event : Nothing


Commands :
--------
Each command has at least the following fields :
 - event leader
 - event date
 - ACK type (0 or 1)
 - player affected
 - player from

 [P] Permanent command (stored)
 [V] Volative command (not stored)
Leader commands :
 - [P] TITULAR : <player name> -- Informs player he is in titular list
 - [P] SUBSTITUTE : <player name> -- Informs player he is in substitute list
 - [P] REPLACEMENT : <player name> -- Informs player he is in replacement list
 - [P] KICK : <player name> [Reason] -- Informs player he has been kicked from event
 - [P] BAN : <player name> [Reason] -- Informs player he has been banned from event
 - [P] UNBAN : <player name> -- Informs player he has been unbanned from event
 - [V] LEADER : <player name> <Events data> -- Informs player he is now the new leader
 - [V] INFOS : <player level> <player guild> <player zone> -- Give informations about me

Non-leader commands :
 - [P] SUBSCRIBE : <sub> [Comment] -- Subscribe to an event -- <sub>(1/0) informs the leader if you want to be put directly in substitute queue (so he will invite you only if he don't find someone to replace you)
 - [P] UNSUBSCRIBE : [Comment]  -- Unsubscribe from an event
]]


--------------- Shared variables ---------------
GEM_GLOBAL_CMD = "GlobalEventId1"; -- special ev_id tag for global commands
GEM_CMD_EVENT_UPDATE = "01"; -- Event updated (or created)
GEM_CMD_EVENT_CLOSE = "02"; -- Event closed
GEM_CMD_CMD_SUBSCRIBE = "03"; -- Subscribe : <Class> <Guild> <Level> <Sub> <Comment>
GEM_CMD_CMD_UNSUBSCRIBE = "04"; -- Unsubscribe : <Comment>
GEM_CMD_CMD_TITULAR = "05"; -- Titular
GEM_CMD_CMD_SUBSTITUTE = "06"; -- Substitute
GEM_CMD_CMD_REPLACEMENT = "07"; -- Replacement
GEM_CMD_CMD_KICK = "08"; -- Kick
GEM_CMD_CMD_BAN = "09"; -- Ban
GEM_CMD_CMD_UNBAN = "10"; -- UnBan
GEM_CMD_EVENT_LEADER = "11"; -- New event leader
GEM_CMD_PLAYER_INFOS = "12"; -- New infos about myself
GEM_CMD_CMD_ASSISTANT = "13"; -- Add assistant

-- GUI notify values
GEM_NOTIFY_NEW_EVENT = 1;
GEM_NOTIFY_CLOSE_EVENT = 2;
GEM_NOTIFY_EVENT_UPDATE = 3;
GEM_NOTIFY_SUBSCRIBER = 4;
GEM_NOTIFY_UNSUBSCRIBER = 5;
GEM_NOTIFY_MY_SUBSCRIPTION = 6;
GEM_NOTIFY_PLAYER_INFOS = 7;

-- Other variables
GEM_COM_Channels = nil;
GEM_COM_LastJoinerTime = 0;

--------------- Local variables ---------------

--local _GEM_TOKEN = '\35'; -- Debug value
--local _GEM_TOKEN_SUB_TOKEN = '\38'; -- Debug value
--local _GEM_TOKEN_EMPTY = '\36'; -- Debug value
--local _GEM_TOKEN_MORE = '\33'; -- Debug value
local _GEM_TOKEN = '\30';
local _GEM_TOKEN_SUB_TOKEN = '\29';
local _GEM_TOKEN_EMPTY = '\28';
local _GEM_TOKEN_MORE = '\27';
local _GEM_PARSE_PATTERN = "([^".._GEM_TOKEN.."]+)";
local _GEM_PARSE_PATTERN_SUB_PATTERN = "([^".._GEM_TOKEN_SUB_TOKEN.."]+)";
local _GEM_NotifyCallBackFunction = nil;
local _GEM_IntToClass = { ["1"] = "WARRIOR"; ["2"] = "PALADIN"; ["3"] = "SHAMAN"; ["4"] = "ROGUE"; ["5"] = "MAGE"; ["6"] = "WARLOCK"; ["7"] = "HUNTER"; ["8"] = "DRUID"; ["9"] = "PRIEST" };
local _GEM_ClassToInt = { ["WARRIOR"] = "1"; ["PALADIN"] = "2"; ["SHAMAN"] = "3"; ["ROGUE"] = "4"; ["MAGE"] = "5"; ["WARLOCK"] = "6"; ["HUNTER"] = "7"; ["DRUID"] = "8"; ["PRIEST"] = "9" };
local _GEMComm_ScheduledUpdates = {};
local _GEMComm_Dispatch = {};
local _GEM_MoreCounter = 1;
local _GEMComm_MultiplePackets = {};
local _GEM_COM_QueuedMessages = {};
local _GEM_COM_RoutineScheduled = false;
local _GEM_COM_LastPlayerInfosSend = 0;

-- Consts
local _GEM_MAX_STRING_LENGTH = 240;
local _GEM_PIPE_ENTITIE = "\127p";
local _GEM_COM_MaxSendPerSchedule = 1;
local _GEM_COM_ScheduledTaskInterval = 1.500;
local _GEM_COM_PlayersInfosInterval = 5*60; -- 5 min

--------------- Internal functions ---------------

local function _GEM_COM_NameFromAlias(alias)
  for name,chantab in GEM_COM_Channels
  do
    if(chantab.aliasSet and chantab.aliasSet == alias)
    then
      return chantab.id;
    end
  end
  return nil;
end

_GEM_COM_oldSendChatMessage = SendChatMessage;
local function _GEM_COM_newSendChatMessage(msg,sys,lang,name)
  local id = _GEM_COM_NameFromAlias(sys);
  if(id)
  then
    return _GEM_COM_oldSendChatMessage(string.gsub(msg,"|",_GEM_PIPE_ENTITIE),"CHANNEL",lang,id);
  end
  return _GEM_COM_oldSendChatMessage(msg,sys,lang,name);
end
SendChatMessage = _GEM_COM_newSendChatMessage;

local function _GEM_COM_ScheduledPlayerInfos()
  if(_GEM_COM_LastPlayerInfosSend + _GEM_COM_PlayersInfosInterval < time())
  then
    GEM_ChatDebug(GEM_DEBUG_GLOBAL,"_GEM_COM_ScheduledPlayerInfos : Too long since last player infos send.");
    GEM_COM_PlayerInfos();
  end

  -- Reschedule routine
  GEMSystem_Schedule(10,_GEM_COM_ScheduledPlayerInfos);
end

local function _GEM_COM_ScheduledSendRoutine()
  local msg_sent = 0;

  while(table.getn(_GEM_COM_QueuedMessages) > 0 and not GEM_YouAreDrunk)
  do
    local channel = _GEM_COM_QueuedMessages[1].channel;
    local cmd = _GEM_COM_QueuedMessages[1].cmd;
    local ev_id = _GEM_COM_QueuedMessages[1].ev_id;
    local stamp = _GEM_COM_QueuedMessages[1].stamp;
    local msgstring = _GEM_COM_QueuedMessages[1].msgstring;

    while(GEM_COM_Channels[channel] == nil)
    do
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_COM_ScheduledSendRoutine : GEM_COM_Channels["..tostring(channel).."] is nil (left channel ?). Discarding message !");
      table.remove(_GEM_COM_QueuedMessages,1);
      if(table.getn(_GEM_COM_QueuedMessages) == 0)
      then
        break;
      end
      -- Re-read params
      local channel = _GEM_COM_QueuedMessages[1].channel;
      local cmd = _GEM_COM_QueuedMessages[1].cmd;
      local ev_id = _GEM_COM_QueuedMessages[1].ev_id;
      local stamp = _GEM_COM_QueuedMessages[1].stamp;
      local msgstring = _GEM_COM_QueuedMessages[1].msgstring;
    end

    if(GEM_COM_Channels[channel].id == 0) -- Channel not init !
    then
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_COM_ScheduledSendRoutine : ChannelID = "..tostring(GEM_COM_Channels[channel].id).." for "..tostring(channel));
      GEM_InitChannels(false);
      if(GEM_COM_Channels[channel].id == 0) -- Still not joined ?
      then
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_COM_ScheduledSendRoutine : Channel '"..tostring(channel).."' still not init, rescheduling send later");
        break;
      end
    end
    -- DEBUG
    if(GEM_Events.debug == 1)
    then
      if(GetChannelName(channel) ~= GEM_COM_Channels[channel].id)
      then
        if(GetChannelName(channel) ~= 0)
        then
          GEM_ChatWarning("_GEM_COM_ScheduledSendRoutine : CurrentChanID differs from saved one : "..GetChannelName(channel).." - "..GEM_COM_Channels[channel].id);
        else
          GEM_ChatWarning("_GEM_COM_ScheduledSendRoutine : If you've left GEM's channel by hand, ignore this message, otherwise please contact Kiki");
        end
        table.remove(_GEM_COM_QueuedMessages,1);
        break;
      end
    end
    -- END DEBUG

    if(cmd == GEM_CMD_EVENT_UPDATE) -- Special case, we must set the real stamp when sending (we specified the offset)
    then
      stamp = time() - stamp;
    end
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_ScheduledSendRoutine : Sending command "..cmd.." for EventID "..ev_id.." on Channel "..channel);
    local prefix = "<GEM"..GEM_MAJOR.."."..GEM_MINOR..">"..cmd.."-"..stamp.."-"..ev_id;
    local msg = prefix..msgstring;
  
    while(string.len(msg) > _GEM_MAX_STRING_LENGTH)
    do
      local submsg = string.sub(msg,1,_GEM_MAX_STRING_LENGTH);
      if(string.sub(submsg,string.len(submsg)) == _GEM_TOKEN)
      then
        submsg = submsg.._GEM_TOKEN_EMPTY;
      end
      submsg = submsg.._GEM_TOKEN.._GEM_TOKEN_MORE.._GEM_MoreCounter;
      local addmsg = string.sub(msg,_GEM_MAX_STRING_LENGTH+1);
      if(string.sub(addmsg,1,1) == _GEM_TOKEN)
      then
        addmsg = _GEM_TOKEN_EMPTY..addmsg;
      end
      msg = prefix.._GEM_TOKEN_MORE.._GEM_MoreCounter.."-"..addmsg;
      _GEM_COM_newSendChatMessage(submsg,"CHANNEL",nil,GEM_COM_Channels[channel].id);
      msg_sent = msg_sent + 1;
      GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_ScheduledSendRoutine : Splitted command, MoreCounter is ".._GEM_MoreCounter.." : "..submsg);
    end
    _GEM_MoreCounter = _GEM_MoreCounter + 1;
    _GEM_COM_newSendChatMessage(msg,"CHANNEL",nil,GEM_COM_Channels[channel].id);
    msg_sent = msg_sent + 1;
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_ScheduledSendRoutine : Sending last msg part : "..msg);
    
    table.remove(_GEM_COM_QueuedMessages,1);
    if(msg_sent >= _GEM_COM_MaxSendPerSchedule)
    then
      break;
    end
  end

  -- Reschedule routine
  GEMSystem_Schedule(_GEM_COM_ScheduledTaskInterval,_GEM_COM_ScheduledSendRoutine);
end

local function _GEM_COM_QueueMessage(channel,cmd,ev_id,stamp,msgstring)
  -- Queue the message
  table.insert(_GEM_COM_QueuedMessages, { channel=channel, cmd=cmd, ev_id=ev_id, stamp=stamp, msgstring=msgstring });
end

local function _GEM_COM_UnpackClasses(clas)
  local classes = {};
  if(clas and clas ~= "")
  then
    for c in string.gfind(clas,_GEM_PARSE_PATTERN_SUB_PATTERN)
    do
      if(c ~= "")
      then
        local _,_,id,mini,maxi,tit,sub,repl = string.find(c,"(%d+):([-]?%d+):([-]?%d+):(%d+):(%d+):(%d+)");
        if(id ~= nil)
        then
          local name = _GEM_IntToClass[id];
          classes[name] = {};
          classes[name].min = tonumber(mini,10);
          classes[name].max = tonumber(maxi,10);
          classes[name].tit_count = tonumber(tit,10);
          classes[name].sub_count = tonumber(sub,10);
          classes[name].repl_count = tonumber(repl,10);
        end
      end
    end
  end
  return classes;
end

local function _GEM_COM_UnpackSubscribers(subs,subtype)
  local subscribers = {};
  local pos = 1;

  if(subs and subs ~= "")
  then
    for c in string.gfind(subs,_GEM_PARSE_PATTERN_SUB_PATTERN)
    do
      if(c ~= "")
      then
        local _,_,pl_name,id,level_str = string.find(c,"([^:]+):(%d+):(%d+)");
        if(id ~= nil)
        then
          local class = _GEM_IntToClass[id];
          local level = tonumber(level_str,10);
          tinsert(subscribers, {place = subtype..pos; name = pl_name; guild=GEM_NA_FORMAT; class=class; level=level});
          pos = pos + 1;
        end
      end
    end
  end
  return subscribers;
end

local function _GEM_COM_UnpackPlayers(pls)
  local players = {};
  
  if(pls and pls ~= "")
  then
    for c in string.gfind(pls,_GEM_PARSE_PATTERN_SUB_PATTERN)
    do
      if(c ~= "")
      then
        local _,_,pl_name,id,level_str,stamp_str,forcesub_str,guild,comment = string.find(c,"([^:]+):(%d+):(%d+):(%d+):(%d+):([^:]*):(.*)");
        if(id ~= nil)
        then
          local class = _GEM_IntToClass[id];
          local level = tonumber(level_str,10);
          local stamp = tonumber(stamp_str,10);
          local forcesub = tonumber(forcesub_str,10);
          players[pl_name] = {class=class; level=level; update_time=stamp; forcesub=forcesub; guild=guild; comment=comment};
        end
      end
    end
  end
  
  return players;
end

local function _GEM_COM_UnpackBanned(bans)
  local banned = {};
  
  if(bans and bans ~= "")
  then
    for c in string.gfind(bans,_GEM_PARSE_PATTERN_SUB_PATTERN)
    do
      if(c ~= "")
      then
        local _,_,pl_name,reason = string.find(c,"([^:]+):(.*)");
        if(id ~= nil)
        then
          banned[pl_name] = reason;
        end
      end
    end
  end
  
  return banned;
end

local function _GEM_COM_GetPreviousPacket(from,ev_id,w)
  local _,_,MoreCounter,param = string.find(w,_GEM_TOKEN_MORE.."(%d+)-(.*)");
  if(MoreCounter == nil)
  then
    GEM_ChatWarning("_GEM_COM_GetPreviousPacket : Failed to find MoreCounter in '"..w.."' from "..from);
    return nil;
  end
  local params = _GEMComm_MultiplePackets[from..ev_id..MoreCounter];
  if(params == nil)
  then
    --GEM_ChatWarning("_GEM_COM_GetPreviousPacket : Params is nil in '"..w.."' from "..from);
    return nil;
  end
  if(param == _GEM_TOKEN_EMPTY)
  then
    param = "";
  end
  params[table.getn(params)] = params[table.getn(params)]..param;
  return params,MoreCounter;
end

local function _GEM_COM_SaveMultiplePacket(from,ev_id,w,params)
  local _,_,MoreCounter = string.find(w,_GEM_TOKEN_MORE.."(%d+)");
  if(MoreCounter == nil)
  then
    GEM_ChatWarning("_GEM_COM_SaveMultiplePacket : Failed to find MoreCounter in '"..w.."' from "..from);
    return;
  end
  _GEMComm_MultiplePackets[from..ev_id..MoreCounter] = params;
end

local function _GEM_COM_ClearMultiplePacket(from,ev_id,MoreCounter)
  _GEMComm_MultiplePackets[from..ev_id..MoreCounter] = nil;
end

function GEM_COM_PurgeQueueMessageForChannel(channel)
  local i = 1;
  while(i <= table.getn(_GEM_COM_QueuedMessages))
  do
    local queue_chan = _GEM_COM_QueuedMessages[i].channel;
    if(queue_chan == channel)
    then
      table.remove(_GEM_COM_QueuedMessages,i);
    else
      i = i + 1;
    end
  end
end


--[[
 function GEM_COM_ParseChannelMessage
   Channel parsing function.
]]
function GEM_COM_ParseChannelMessage(channel,from,message)
  if(from == GEM_PlayerName) then return; end; -- Not interested by messages from me
  GEM_CheckPlayerJoined(channel,from);
  local _,i,version,cmd_stamp_id = string.find(message,"^<GEM([^>]+)>(%d+-%d+-[^%s%d-]+%d+)");
  if(cmd_stamp_id == nil) then return; end;
  local _,_,cmd,stamp_str,ev_id = string.find(cmd_stamp_id,"(%d+)-(%d+)-([^%s%d-]+%d+)");
  if(cmd == nil or stamp_str == nil or ev_id == nil) then return; end;
  local stamp = tonumber(stamp_str,10);
  if(stamp == nil) then return; end;

  -- Check version
  local _,_,major,minor = string.find(version,"([^.]+)%.(.+)");
  if(major == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_GLOBAL,from.." is using an old major version of GEM.");
    return;
  end
  if(major ~= GEM_MAJOR)
  then
    if(major > GEM_MAJOR)
    then
      if(GEM_OldVersion == false)
      then
        GEM_ChatPrint(GEM_TEXT_UPGRADE_NEEDED);
        GEM_ChatPrint("GEM home page : http://christophe.calmejane.free.fr/wow/gem");
        GEM_OldVersion = true;
      end
    else
      GEM_ChatDebug(GEM_DEBUG_GLOBAL,from.." is using an old major version of GEM.");
    end
    return;
  end
  if(minor ~= GEM_MINOR)
  then
    if(minor > GEM_MINOR)
    then
      if(GEM_NewMinorVersion == false)
      then
        GEM_ChatPrint(GEM_TEXT_UPGRADE_SUGGESTED);
        GEM_ChatPrint("GEM home page : http://christophe.calmejane.free.fr/wow/gem");
        GEM_NewMinorVersion = true;
      end
    else
      GEM_ChatDebug(GEM_DEBUG_GLOBAL,from.." is using an old minor version of GEM.");
    end
  end

  local msg = strsub(message,i+1);

  if(ev_id ~= GEM_GLOBAL_CMD and GEM_EVT_CheckExpiredEvent(ev_id)) -- Message for an expired event, just return
  then
    return;
  end

  if(GEM_Events.realms[GEM_Realm].ignore[ev_id])
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"Event "..ev_id.." is in ignore list, discarding message");
    return;
  end

  if(_GEMComm_Dispatch[cmd] == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"Unknown command : "..cmd.." from "..from);
    return;
  end

  local params = {};
  local MoreCounter = nil;
  for w in string.gfind(msg,_GEM_PARSE_PATTERN)
  do
    if(string.find(w,_GEM_TOKEN_MORE) ~= nil) -- Multiple packet
    then
      if(table.getn(params) == 0) -- First param -> Continued packet
      then
        params,MoreCounter = _GEM_COM_GetPreviousPacket(from,ev_id,w);
        if(params == nil) -- Cannot find previous packet, just discard this one
        then
          return;
        end
      else -- Continued multiple packets
        _GEM_COM_SaveMultiplePacket(from,ev_id,w,params);
        MoreCounter = nil;
        return;
      end
    else -- Not multiple packet
      if(w == nil or w == _GEM_TOKEN_EMPTY)
      then
        table.insert(params,"");
      else
        table.insert(params,w);
      end
    end
  end
  if(MoreCounter ~= nil)
  then
    _GEM_COM_ClearMultiplePacket(from,ev_id,MoreCounter);
  end
  if(ev_id ~= GEM_GLOBAL_CMD and cmd ~= GEM_CMD_EVENT_UPDATE and cmd ~= GEM_CMD_EVENT_CLOSE and cmd ~= GEM_CMD_EVENT_LEADER) -- Not an Event msg (-> a cmd message)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"GEM_COM_ParseChannelMessage : Received command "..cmd.." from "..from.." for EventID "..ev_id);
    if(GEM_CMD_ReceivedCommand(channel,cmd,from,stamp,ev_id,params) == false) -- This command does not need more processing, don't dispatch, and return now
    then
      return;
    end
  end
  GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"GEM_COM_ParseChannelMessage : Dispatching command "..cmd.." from "..from.." for EventID "..ev_id.." : "..message);
  _GEMComm_Dispatch[cmd](channel,from,stamp,ev_id,params);
end

local function _GEM_COM_BuildClassesString(classes)
  local clas = "";
  if(classes ~= nil)
  then
    for name,tab in classes
    do
      clas = clas.._GEM_TOKEN_SUB_TOKEN.._GEM_ClassToInt[name]..":"..tab.min..":"..tab.max..":"..tab.tit_count..":"..tab.sub_count..":"..tab.repl_count;
    end
  end
  return clas;
end

local function _GEM_COM_BuildSubscribersStrings(event)
  local tits = "";
  local subs = "";
  local repls = "";

  for pos,tab in event.titulars do
    tits = tits.._GEM_TOKEN_SUB_TOKEN..tab.name..":".._GEM_ClassToInt[tab.class]..":"..tab.level;
  end

  for pos,tab in event.substitutes do
    subs = subs.._GEM_TOKEN_SUB_TOKEN..tab.name..":".._GEM_ClassToInt[tab.class]..":"..tab.level;
  end

  for pos,tab in event.replacements do
    repls = repls.._GEM_TOKEN_SUB_TOKEN..tab.name..":".._GEM_ClassToInt[tab.class]..":"..tab.level;
  end

  return tits,subs,repls;
end

local function _GEM_COM_BuildPlayersString(event)
  local pls = "";

  for name,tab in event.players do
    pls = pls.._GEM_TOKEN_SUB_TOKEN..name..":".._GEM_ClassToInt[tab.class]..":"..tab.level..":"..tab.update_time..":"..tab.forcesub..":"..tab.guild..":"..tab.comment;
  end

  return pls;
end

local function _GEM_COM_BuildBannedString(event)
  local bans = "";

  for name,reason in event.banned do
    bans = bans.._GEM_TOKEN_SUB_TOKEN..name..":"..reason;
  end

  return bans;
end

--[[
 function _GEM_COM_SendMessage
  Low level sending function
   channel : String     -- Channel to send message to
   cmd     : String     -- Command to send
   ev_id   : String     -- EventId command is refering to
   stamp   : Integer    -- TimeStamp of the send (relative to leader of ev_id)
   params  : String/Int -- Params associated with command
]]
local function _GEM_COM_SendMessage(channel,cmd,ev_id,stamp,...)
  if(channel == nil)
  then
    channel = GEM_DefaultSendChannel;
    -- DEBUG
    GEM_ChatWarning("_GEM_COM_SendMessage : Channel not nil !!");
  end
  local msg = "";
  for i=1, arg.n
  do
    local val = arg[i];
    if(val == nil)
    then
      val = _GEM_TOKEN_EMPTY;
    elseif((type(val) == "string") and (val == ""))
    then
      val = _GEM_TOKEN_EMPTY;
    end;
    msg = msg.._GEM_TOKEN..val;
  end

  _GEM_COM_QueueMessage(channel,cmd,ev_id,stamp,msg);
end

--[[
 function _GEM_COM_PrepareAndSendCommand
  Low level command storing and sending function
   ev_id   : String     -- EventId command is refering to
   cmd     : String     -- Command to store/send
   pl_dest : String     -- Name of player the command is destinated to
   pl_src  : String     -- Name of player the command is originating from
   ...     : String/Int -- Params associated with command
]]
local function _GEM_COM_PrepareAndSendCommand(ev_id,cmd,pl_dest,pl_src,...)
  local stamp = time() - GEM_GetOffsetTime(ev_id);
  local cmd_id = pl_dest.."-"..pl_src.."-"..stamp.."-"..cmd;
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  local params = {};

  if(event == nil)
  then
    return;
  end

  tinsert(params,event.leader);
  tinsert(params,event.ev_date);
  tinsert(params,"0"); -- Not ACKed
  tinsert(params,pl_dest);
  tinsert(params,pl_src);

  for i=1, arg.n do -- Build params array to store command
    if(arg[i] == nil)
    then
      tinsert(params,"");
    else
      tinsert(params,arg[i]);
    end
  end

  -- Create the CMD struct for this ev_id, if it does not exist
  if(GEM_Events.realms[GEM_Realm].commands[ev_id] == nil)
  then
    GEM_CMD_CreateCommands(event.channel,ev_id,event.leader,event.ev_date);
  end
  -- Save the command
  GEM_CMD_CreateCommandId(ev_id,cmd_id,cmd,stamp,params);

  _GEM_COM_SendMessage(event.channel,cmd,ev_id,stamp,event.leader,event.ev_date,0,pl_dest,pl_src,unpack(arg));
end


--------------- Process functions ---------------
--[[
  Process EventUpdate :
   Params[1] = update_time (INT)
   Params[2] = leader (STRING)
   Params[3] = ev_date (INT)
   Params[4] = ev_place (STRING)
   Params[5] = ev_comment (STRING)
   Params[6] = max_count (INT)
   Params[7] = min_lvl (INT)
   Params[8] = max_lvl (INT)
   Params[9] = classes (STRING)
   Params[10] = Titulars (STRING)
   Params[11] = Substitutes (STRING)
   Params[12] = Replacements (STRING)
   Params[13] = Sorttype (STRING)
   Params[14] = Closed comment (STRING)
]]
local function _GEM_COM_Process_EventUpdate(channel,from,stamp,ev_id,params)
  local update_time = tonumber(params[1],10);
  local ev_date = tonumber(params[3],10);
  local max_count = tonumber(params[6],10);
  local min_lvl = tonumber(params[7],10);
  local max_lvl = tonumber(params[8],10);

  if(update_time == nil or ev_date == nil or max_count == nil or min_lvl == nil or max_lvl == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_EventUpdate : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_EventUpdate : From="..from.." at "..date("%c",stamp).." for "..ev_id);
  if(GEM_EVT_UpdateEvent(channel,ev_id,update_time,params[2],ev_date,params[4],params[5],max_count,min_lvl,max_lvl,_GEM_COM_UnpackClasses(params[9]),_GEM_COM_UnpackSubscribers(params[10],"P"),_GEM_COM_UnpackSubscribers(params[11],"S"),_GEM_COM_UnpackSubscribers(params[12],"R"),params[13],params[14]))
  then
    if((GEM_Events.realms[GEM_Realm].events[ev_id].offset_time == 0) or (params[2] == from)) -- Update offset, if I don't have one, or if msg is from the leader
    then
      GEM_SetOffsetStamp(ev_id,stamp);
    end
  end
end

--[[
  Process EventClose :
   Params[1] = Comment (STRING)
]]
local function _GEM_COM_Process_EventClose(channel,from,stamp,ev_id,params)
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_EventClose : Close event not used right anymore !!");
  --GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_EventClose : From="..from.." at "..date("%c",stamp).." for "..ev_id);
  --GEM_EVT_ClearEvent(ev_id,params[1],false);
  --GEM_QUE_RemoveEventFromQueue(ev_id);
end

--[[
  Process EventLeader :
   Params[1] = update_time (INT)
   Params[2] = new leader (STRING)
   Params[3] = ev_date (INT)
   Params[4] = ev_place (STRING)
   Params[5] = ev_comment (STRING)
   Params[6] = max_count (INT)
   Params[7] = min_lvl (INT)
   Params[8] = max_lvl (INT)
   Params[9] = classes (STRING)
   Params[10] = Titulars (STRING)
   Params[11] = Substitutes (STRING)
   Params[12] = Replacements (STRING)
   Params[13] = Sorttype (STRING)
   Params[13] = Players (STRING)
   Params[13] = Banned (STRING)
]]
local function _GEM_COM_Process_EventLeader(channel,from,stamp,ev_id,params)
  if(GEM_IsMyReroll(params[2])) -- If I'm the new leader, process
  then
    local update_time = tonumber(params[1],10);
    local ev_date = tonumber(params[3],10);
    local max_count = tonumber(params[6],10);
    local min_lvl = tonumber(params[7],10);
    local max_lvl = tonumber(params[8],10);

    GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_EventLeader : From="..from.." at "..date("%c",stamp).." for "..ev_id..". I'm the new leader !");
    -- Remove event, so I can re-create it
    GEM_Events.realms[GEM_Realm].events[ev_id] = nil;
    GEM_EVT_AddEvent(channel,ev_id,time(),params[2],ev_date,params[4],params[5],max_count,min_lvl,max_lvl,_GEM_COM_UnpackClasses(params[9]),_GEM_COM_UnpackSubscribers(params[10],"P"),_GEM_COM_UnpackSubscribers(params[11],"S"),_GEM_COM_UnpackSubscribers(params[12],"R"),params[13]);
    GEM_Events.realms[GEM_Realm].events[ev_id].players = _GEM_COM_UnpackPlayers(params[14]);
    GEM_Events.realms[GEM_Realm].events[ev_id].banned = _GEM_COM_UnpackBanned(params[15]);

    -- Update my list
    GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,ev_id);
    
    -- Broadcast event, and we are done
    --GEM_COM_BroadcastEvent(GEM_Events.realms[GEM_Realm].events[ev_id]);
    GEM_COM_NotifyEventUpdate(ev_id);
  end
end

--[[
  Process CmdSubscribe :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
   Params[6] = Class (STRING) -- Class of the subscribing player
   Params[7] = Guild (STRING) -- Guild of the subscribing player
   Params[8] = Level (INT)    -- Level of the subscribing player
   Params[9] = ForceSub (INT) -- <1/0> Force or not, subscribing player to replacement queue
   Params[10] = Comment (STRING) -- Subscribe comment string
]]
local function _GEM_COM_Process_CmdSubscribe(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_level = tonumber(params[8],10);
  local forcesub = tonumber(params[9],10);
  local leader = params[1];
  local pl_name = params[5];
  local pl_class = params[6];
  local pl_guild = params[7];
  local pl_comment = params[10];
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil)
  then
    return;
  end

  if(ev_date == nil or pl_level == nil or forcesub == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdSubscribe : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdSubscribe : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4].." : "..params[6].." - "..pl_level.." - "..params[10]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdSubscribe : Processing a command not for me");
  end

  -- Check player's level
  if(pl_level < event.min_lvl or pl_level > event.max_lvl)
  then
    GEM_COM_KickPlayer(ev_id,pl_name,GEM_TEXT_ERR_LEVEL_FAILED);
    return;
  end

  if((event.players[pl_name] == nil) or (stamp > event.players[pl_name].update_time)) -- First time I see this, or the command is more recent than the last received
  then
    if(GEM_EVT_IsBanned(ev_id,pl_name)) -- Check player for BAN
    then
      GEM_COM_BanPlayer(ev_id,pl_name); -- Resend a BAN command
      return; -- Then return (just ignore this CMD)
    end
    GEM_SUB_CreateSubscriber(ev_id,stamp,pl_name,pl_class,pl_guild,pl_level,pl_comment,forcesub,0); -- Creates the subscribe
    GEM_NotifyGUI(GEM_NOTIFY_SUBSCRIBER,ev_id,pl_name);
  end
end

--[[
  Process CmdUnsubscribe :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
   Params[6] = Comment (STRING) -- Unsubscribe comment string
]]
local function _GEM_COM_Process_CmdUnsubscribe(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local leader = params[1];
  local pl_name = params[5];
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil)
  then
    return;
  end

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdUnsubscribe : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdUnsubscribe : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4].." : "..params[6]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdUnsubscribe : Processing a command not for me");
  end

  if((event.players[pl_name] ~= nil) and (stamp > event.players[pl_name].update_time)) -- Player exists, and the command is more recent than the last received
  then
    GEM_SUB_RemoveSubscriber(ev_id,pl_name,params[6]); -- Removes the subscriber
    GEM_NotifyGUI(GEM_NOTIFY_UNSUBSCRIBER,ev_id,pl_name);
  end
end

--[[
  Process CmdTitular :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
]]
local function _GEM_COM_Process_CmdTitular(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_name = params[4];

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdTitular : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdTitular : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdTitular : Processing a command not for me");
  end

  GEM_SUB_SetTitular(ev_id,stamp,pl_name);
end

--[[
  Process CmdSubstitute :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
]]
local function _GEM_COM_Process_CmdSubstitute(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_name = params[4];

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdSubstitute : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdSubstitute : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdSubstitute : Processing a command not for me");
  end

  GEM_SUB_SetSubstitute(ev_id,stamp,pl_name);
end

--[[
  Process CmdReplacement :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
]]
local function _GEM_COM_Process_CmdReplacement(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_name = params[4];

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdReplacement : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdReplacement : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdReplacement : Processing a command not for me");
  end

  GEM_SUB_SetReplacement(ev_id,stamp,pl_name);
end

--[[
  Process CmdKick :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
   Params[6] = Reason (STRING) -- Reason of the kick
]]
local function _GEM_COM_Process_CmdKick(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_name = params[4];
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdKick : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdKick : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4].." : "..params[6]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdKick : Processing a command not for me");
  end

  GEM_Events.realms[GEM_Realm].subscribed[ev_id] = nil;
  GEM_Events.realms[GEM_Realm].kicked[ev_id] = params[6];

  if(event == nil)
  then
    return;
  end

  GEM_ChatPrint(GEM_TEXT_CHAT_KICKED..event.ev_place.." ("..event.leader..") : "..params[6]);
  GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
end

--[[
  Process CmdBan :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
   Params[6] = Reason (STRING) -- Reason of the ban
]]
local function _GEM_COM_Process_CmdBan(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_name = params[4];
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdBan : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdBan : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4].." : "..params[6]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdBan : Processing a command not for me");
  end

  GEM_Events.realms[GEM_Realm].subscribed[ev_id] = nil;
  GEM_Events.realms[GEM_Realm].banned[ev_id] = params[6];

  if(event == nil)
  then
    return;
  end

  GEM_ChatPrint(GEM_TEXT_CHAT_BANNED..event.ev_place.." ("..event.leader..") : "..params[6]);
  GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
end

--[[
  Process CmdUnBan :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
]]
local function _GEM_COM_Process_CmdUnBan(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_name = params[4];
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdUnBan : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdUnBan : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdUnBan : Processing a command not for me");
  end

  GEM_Events.realms[GEM_Realm].banned[ev_id] = nil;

  if(event == nil)
  then
    return;
  end

  GEM_ChatPrint(GEM_TEXT_CHAT_UNBANNED..event.ev_place.." ("..event.leader..")");
  GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
end

--[[
  Process PlayerInfos :
   Params[1] = name (STRING)
   Params[2] = guild (STRING)
   Params[3] = location (STRING)
   Params[4] = level (INT)
   Params[5] = class (STRING)
   Params[6] = officer (INT)
   Params[7] = rank name (STRING)
   Params[8] = rank idx (INT)
   Params[9] = GEM-Version (STRING)
   Params[10] = Comment (STRING)
]]
local function _GEM_COM_Process_Global_PlayerInfos(channel,from,stamp,ev_id,params)
  local pl_level = tonumber(params[4],10);
  local g_rank_idx = tonumber(params[8],10);

  if(params[6] == nil or params[6] == "")
  then
    params[6] = "0";
  end
  local officer = tonumber(params[6],10);

  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_Global_PlayerInfos : From="..from.." at "..date("%c",stamp).." Fill infos : "..params[2].." : "..params[3].." : "..pl_level.." : "..params[5]);
  GEM_PLAY_FillPlayerInfos(channel,params[1],params[2],params[3],pl_level,params[5],officer,params[7],g_rank_idx,params[9],params[10]);
  GEM_NotifyGUI(GEM_NOTIFY_PLAYER_INFOS);
end

--[[
  Process CmdAssistant :
   -- Common Cmd params
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
   -- Specific Cmd params
]]
local function _GEM_COM_Process_CmdAssistant(channel,from,stamp,ev_id,params)
  local ev_date = tonumber(params[2],10);
  local pl_name = params[4];
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_PROTOCOL,"_GEM_COM_Process_CmdAssistant : WARNING : Malformed event from "..from.." for EventID "..ev_id);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_COM_Process_CmdAssistant : From="..from.." at "..date("%c",stamp).." for "..ev_id.." : From "..params[5].." to "..params[4]);

  if(not GEM_IsMyReroll(params[4])) -- Not for me ??
  then
    GEM_ChatWarning("_GEM_COM_Process_CmdAssistant : Processing a command not for me");
  end

  GEM_Events.realms[GEM_Realm].assistant[ev_id] = true;

  if(event == nil)
  then
    return;
  end

  GEM_ChatPrint(GEM_TEXT_CHAT_ASSISTANT..event.ev_place.." ("..event.leader..")");
  GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
end



--------------- Exported functions ---------------

GEM_oldChatFrame_OnEvent = ChatFrame_OnEvent;
function GEM_newChatFrame_OnEvent(event)
  local channel = nil;
  if(arg9)
  then
    channel = strlower(arg9);
  end

  -- There is a channel
  if ( strsub(event, 1, 8) == "CHAT_MSG" and channel and GEM_Realm and GEM_IsChannelInList(channel)) then
    local type = strsub(event, 10);
    if(string.find(type,"^CHANNEL"))
    then
      if(type == "CHANNEL")
      then
        if(string.find(arg1,"^<GEM")) -- A GEM message ? Don't display
        then
          return;
        end
        -- the message is shown in this ChatFrame ?
        local info;
        local found = 0;
        local channelLength = strlen(arg4);
        for index, value in this.channelList do
          if ( channelLength > strlen(value) ) then
            -- arg9 is the channel name without the number in front...
            if ( ((arg7 > 0) and (this.zoneChannelList[index] == arg7)) or (strlower(value) == channel) ) then
              found = 1;
              info = ChatTypeInfo["CHANNEL"..arg8];
              break;
            end
          end
        end
        if ( (found == 0) or not info ) then
          return;
        end

        -- unpack PIPE_ENTITIE
        arg1 = string.gsub(arg1,_GEM_PIPE_ENTITIE,"|");
        
        -- Check for alias
        if(GEM_COM_Channels[channel].aliasSet and GEM_COM_Channels[channel].aliasSet ~= "") -- Alias set ? Show alias name
        then
          event = "CHAT_MSG_"..GEM_COM_Channels[channel].aliasSet;
          arg4 = "";
          --arg9 = GEM_COM_Channels[channel].aliasSet;
        end
      elseif(type ~= "CHANNEL_LIST")
      then
        return;
      end
    end
  end
  GEM_oldChatFrame_OnEvent(event);
end
ChatFrame_OnEvent = GEM_newChatFrame_OnEvent;

function GEM_COM_InitRoutines()
  -- Schedule routine
  if(_GEM_COM_RoutineScheduled == false)
  then
    GEMSystem_Schedule(0.050,_GEM_COM_ScheduledSendRoutine);
    GEMSystem_Schedule(10,_GEM_COM_ScheduledPlayerInfos);
    _GEM_COM_RoutineScheduled = true;
  end

end

function GEM_COM_JoinChannel(channel,password)
  if(GetChannelName(channel) == 0)
  then
    GEM_ConnectedPlayers[channel] = {}; -- Reset players
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_JoinChannel : Joining channel "..channel.." with password ("..tostring(password)..")");
    local zoneChannel, channelName = JoinChannelByName(channel,password,DEFAULT_CHAT_FRAME:GetID());
    if(channelName)
    then
      channel = channelName;
    end
    if(not zoneChannel)
    then
      return;
    end
    
    local i = 1;
    while(DEFAULT_CHAT_FRAME.channelList[i])
    do
      i = i + 1;
    end
    DEFAULT_CHAT_FRAME.channelList[i] = channel;
    DEFAULT_CHAT_FRAME.zoneChannelList[i] = zoneChannel;
  else
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_COM_JoinChannel : Already in channel "..channel);
  end
end

function GEM_COM_LeaveChannel(channel)
  if(channel and GEM_COM_Channels[channel] and GEM_COM_Channels[channel].id ~= 0)
  then
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_COM_LeaveChannel : Leaving channel "..channel);
    LeaveChannelByName(channel);
    GEM_COM_Channels[channel].id = 0;
    GEM_COM_Channels[channel].aliasSet = nil;
  end
end

function GEM_Comm_test()
  --GEM_ChatPrint("ok");
end

function GEM_COM_AliasChannel(channel,alias,slash)
  if(alias == nil or alias == "")
  then
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_COM_AliasChannel : Not installing Channel Alias and Slash command, no alias defined");
    return;
  end

  if(GEM_IsChannelJoined(channel))
  then
    local id = GEM_COM_Channels[channel].id;
    local upper = string.upper(slash);
    GEM_COM_Channels[channel].aliasSet = upper;
    ChatTypeInfo[upper] = ChatTypeInfo["CHANNEL"..id];
    ChatTypeInfo[upper].sticky = 1;

    setglobal("CHAT_MSG_"..upper,alias);
    setglobal("CHAT_"..upper.."_GET", "["..alias.."] %s:\32");
    setglobal("CHAT_"..upper.."_SEND", alias..":\32");
    
    SlashCmdList[upper] = GEM_Comm_test;
    setglobal("SLASH_"..upper.."1", "/"..slash);
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_COM_AliasChannel : Channel Alias and Slash command initialized !");
  else
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_COM_AliasChannel : Not installing Channel Alias and Slash command, channel not joined yet");
  end
end

function GEM_COM_UnAliasChannel(channel,alias,slash)
  if(alias and alias ~= "")
  then
    local upper = string.upper(slash);
    if(DEFAULT_CHAT_FRAME.editBox.stickyType == upper)
    then
      DEFAULT_CHAT_FRAME.editBox.chatType = "SAY";
      DEFAULT_CHAT_FRAME.editBox.stickyType = "SAY";
    end
    
    setglobal("CHAT_MSG_"..upper, nil);
    setglobal("CHAT_"..upper.."_GET", nil);
    setglobal("CHAT_"..upper.."_SEND", nil);
    
    SlashCmdList[upper] = nil;
    setglobal("SLASH_"..upper.."1", nil);
    GEM_COM_Channels[channel].aliasSet = nil;
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_COM_UnAliasChannel : Channel Alias and Slash command Uninitialized !");
  end
end


--[[
 function GEM_COM_BroadcastEvent :
  Broadcast an event
   event : Array -- The event struct to broadcast
]]
function GEM_COM_BroadcastEvent(event)
  if(event == nil) then return; end;

  local clas = _GEM_COM_BuildClassesString(event.classes);
  local tits,subs,repls = _GEM_COM_BuildSubscribersStrings(event);

  _GEM_COM_SendMessage(event.channel,GEM_CMD_EVENT_UPDATE,event.id,event.offset_time,event.update_time,event.leader,event.ev_date,event.ev_place,event.ev_comment,event.max_count,event.min_lvl,event.max_lvl,clas,tits,subs,repls,event.sorttype,event.closed_comment);
end

--[[
 function GEM_COM_SendAckCommand :
  Send an ACK for a cmd
   ev_id  : String -- Event ID
   cmd_id : String -- Cmd ID to ACK
]]
function GEM_COM_SendAckCommand(ev_id,cmd_id)
  local cmds = GEM_CMD_GetCommands(ev_id);

  cmds.cmds[cmd_id].LastSend = time();
  _GEM_COM_SendMessage(cmds.channel,cmds.cmds[cmd_id].cmd,ev_id,cmds.cmds[cmd_id].stamp,cmds.leader,cmds.ev_date,1,cmds.cmds[cmd_id].params[4],cmds.cmds[cmd_id].params[5]);
end

--[[
 function GEM_COM_SendForwardCommand :
  Forward the command to the new leader
]]
function GEM_COM_SendForwardCommand(channel,cmd,ev_id,stamp,params)
  _GEM_COM_SendMessage(channel,cmd,ev_id,stamp,unpack(params));
end

--[[
 function GEM_COM_BroadcastCommand
  Broadcast an ACK for a cmd
   ev_id  : String -- Event ID
   cmd_id : String -- Cmd ID to send
]]
function GEM_COM_BroadcastCommand(ev_id,cmd_id)
  local cmds = GEM_Events.realms[GEM_Realm].commands[ev_id];
  local cmdtab = cmds.cmds[cmd_id];

  if(cmdtab == nil)
  then
    GEM_ChatWarning("GEM_COM_BroadcastCommand : Failed to find cmd_id '"..cmd_id.."'");
    return;
  end
  if(not GEM_CMD_IsCommandAcked(ev_id,cmd_id))
  then
    _GEM_COM_SendMessage(cmds.channel,cmdtab.cmd,ev_id,cmdtab.stamp,unpack(cmdtab.params));
  end
end



function GEM_NotifyGUI(cmd,...)
  if(_GEM_NotifyCallBackFunction == nil) then return; end;

  _GEM_NotifyCallBackFunction(cmd,unpack(arg));
end


--------------- GUI Exported functions ---------------

--[[ - GUI ENTRY POINT
 function GEM_SetNotifyCallback :
  Sets the Callback function for GUI notifications.
   CBFunc : Function -- The CB function : void (*func)(NotifyCommand,...)
]]
function GEM_SetNotifyCallback(CBfunc)
  _GEM_NotifyCallBackFunction = CBfunc;
end

--[[ - GUI ENTRY POINT
 function GEM_COM_CreateNewEvent :
  Creates a new event and broadcast it.
   channel    : String  -- Channel where is event is to be created
   ev_date    : Integer -- Date/Hour of the event (number of sec since 1970)
   ev_place   : String  -- Place of the event
   ev_comment : String  -- Comment for the event
   max_count  : Integer -- Max players for the event
   min_lvl    : Integer -- Minimum level
   max_lvl    : Integer -- Maximim level
   classes    : Array{class={min,max,tit_count,sub_count,repl_count},...} -- Min/Max/Titulars/Substitutes/Replacements players of each listed class for the event
   sorttype   : String  -- Sorting type to use
  --
   Returns the event ID (String) used to Broadcast the event
]]
function GEM_COM_CreateNewEvent(channel,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,sorttype)
  local ev_id;
  local creat_time = time();
  local selected = GEM_GetSelectedReroll();
  local infos = GEM_Events.realms[GEM_Realm].my_names[selected];

  GEM_Events.next_event_id = GEM_Events.next_event_id + 1;
  ev_id = selected..GEM_Events.next_event_id;
  GEM_EVT_AddEvent(channel,ev_id,creat_time,selected,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,{},{},{},sorttype);
  GEM_SUB_CreateSubscriber(ev_id,creat_time,selected,infos.class,infos.guild,infos.level,"",0,0);
  GEM_NotifyGUI(GEM_NOTIFY_NEW_EVENT,ev_id);
  return ev_id;
end

--[[ - GUI ENTRY POINT
 function GEM_COM_ChangeLeader :
  Changes the leader of an event, and send him all needed data. New leader must have subscribed, and be online.
   ev_id      : String -- Event ID to change leader of
   new_leader : String -- Name of the new leader
]]
function GEM_COM_ChangeLeader(ev_id,new_leader)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event ~= nil)
  then
    if(event.players[new_leader] == nil)
    then
      GEM_ChatPrint("Cannot change leader of EventID "..ev_id..", because "..new_leader.." never subscribed to the event");
      return;
    end
    if(not GEM_IsPlayerConnected(event.channel,new_leader))
    then
      GEM_ChatPrint("Cannot change leader of EventID "..ev_id..", because "..new_leader.." is not connected");
      return;
    end

    -- Tag myself as having subscribed to the event
    local myself = event.players[event.leader];
    if(myself ~= nil)
    then
      GEM_EVT_SubscribeMyself(ev_id,event.leader,myself.guild,myself.level,myself.class,myself.comment,myself.forcesub,"1"); -- Titular
    end
    
    local clas = _GEM_COM_BuildClassesString(event.classes);
    local tits,subs,repls = _GEM_COM_BuildSubscribersStrings(event);
    local pls = _GEM_COM_BuildPlayersString(event);
    local bans = _GEM_COM_BuildBannedString(event);

    _GEM_COM_SendMessage(event.channel,GEM_CMD_EVENT_LEADER,event.id,time(),event.update_time,new_leader,event.ev_date,event.ev_place,event.ev_comment,event.max_count,event.min_lvl,event.max_lvl,clas,tits,subs,repls,event.sorttype,pls,bans);
    -- Remove the event, and set new forwarder
    GEM_Events.realms[GEM_Realm].forward[ev_id] = new_leader;
    event.leader = new_leader; -- Change leader, and wait for update
    GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,ev_id);
  end
end

local function _GEM_COM_NotifyEventUpdate_Schedule(ev_id) -- Scheduled CB function
  if(_GEMComm_ScheduledUpdates[ev_id] == nil or GEM_Events.realms[GEM_Realm].events[ev_id] == nil)
  then
    return;
  end
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  event.update_time = time();
  GEM_COM_BroadcastEvent(event);
  _GEMComm_ScheduledUpdates[ev_id] = nil;
end

--[[ - GUI ENTRY POINT
 function GEM_NotifyEventUpdate :
  Notify all players of an update in the event (called only by leader of ev_id).
   ev_id : String -- Event ID to notify an update from
]]
function GEM_COM_NotifyEventUpdate(ev_id)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event ~= nil)
  then
    if(not GEM_IsMyReroll(event.leader))
    then
      GEM_ChatPrint("GEM_COM_NotifyEventUpdate : This Event ID does not belong to me ("..ev_id..")");
      return;
    end
    if(_GEMComm_ScheduledUpdates[ev_id] == nil) -- Not yet scheduled for update
    then
      _GEMComm_ScheduledUpdates[ev_id] = 1;
      GEMSystem_Schedule(10,_GEM_COM_NotifyEventUpdate_Schedule,ev_id); -- Schedule in 10s
    end
    GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,ev_id);
  end
end

--[[ - GUI ENTRY POINT
 function GEM_COM_CloseEvent :
  Closes an event and broadcast it (called only by leader of ev_id).
   ev_id : String   -- Event ID to close
   comment : String -- comment for closed event
]]
function GEM_COM_CloseEvent(ev_id,comment)
  --local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  --if(event and (event.LastCloseSent == nil or event.LastCloseSent < GEM_COM_LastJoinerTime))
  --then
    --_GEM_COM_SendMessage(event.channel,GEM_CMD_EVENT_CLOSE,ev_id,time(),comment);
    --event.LastCloseSent = time();
  --end
  --GEM_EVT_ClearEvent(ev_id,comment,false);
  GEM_ChatWarning("Call to GEM_COM_CloseEvent");
end

--[[ - GUI ENTRY POINT
 function GEM_COM_Subscribe :
  Subscribes to an event and broadcast it (Sent by player, once).
   ev_id    : String -- Event ID to subscribe to
   forcesub : Int    -- <1/0> If you want to be put directly in replacement queue ("take me if you can't find anyone")
   comment  : String -- Comment to send with subscription
  --
   Returns nil if ok, error string otherwise.
]]
function GEM_COM_Subscribe(ev_id,forcesub,comment)
  local selected = GEM_GetSelectedReroll();
  local infos = GEM_Events.realms[GEM_Realm].my_names[selected];
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil) -- Event does not exist anymore
  then
    return "Event "..ev_id.." does not exist anymore";
  end
  if(GEM_IsMyReroll(event.leader)) -- I'm the leader
  then
    return "Cannot re-subscribe my own event";
  end
  if(GEM_Events.realms[GEM_Realm].banned[ev_id] ~= nil)
  then
    GEM_ChatPrint("I am banned from EventID "..ev_id.." : "..GEM_Events.realms[GEM_Realm].banned[ev_id]);
    return "I'm banned from Event "..ev_id.." : "..GEM_Events.realms[GEM_Realm].banned[ev_id];
  end
  
  if(GEM_Events.realms[GEM_Realm].subscribed[ev_id] ~= nil)
  then
    GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEM_COM_Subscribe : Already tagged for subscription !!");
    return "Internal error : Already tagged for subscription";
  end

  _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_SUBSCRIBE,event.leader,selected,infos.class,infos.guild,infos.level,forcesub,comment);

  GEM_EVT_SubscribeMyself(ev_id,selected,infos.class,infos.level,infos.class,comment,forcesub,"0"); -- Tag myself as having sent a subscription
  GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
  
  return nil;
end

--[[ - GUI ENTRY POINT
 function GEM_COM_Unsubscribe :
  Unsubscribes from an event and broadcast it (Sent by player, once).
   ev_id : String -- Event ID to unsubscribe from
   comment  : String -- Comment to send with unsubscription
]]
function GEM_COM_Unsubscribe(ev_id,comment)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil) -- Event does not exist anymore
  then
    return;
  end
  if(GEM_IsMyReroll(event.leader)) -- Cannot remove ourself
  then
    GEM_ChatPrint("GEM_COM_Unsubscribe : Cannot unsubscribe from your own event !");
    return;
  end

  if(GEM_Events.realms[GEM_Realm].subscribed[ev_id] == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEM_COM_Unsubscribe : I'm not tagged as having sent subscription !!");
    return;
  end

  _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_UNSUBSCRIBE,event.leader,GEM_Events.realms[GEM_Realm].subscribed[ev_id].name,comment);

  GEM_Events.realms[GEM_Realm].subscribed[ev_id] = nil;
  GEM_Events.realms[GEM_Realm].assistant[ev_id] = nil; -- Reset assistant status
  GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
end

--[[ - GUI ENTRY POINT
 function GEM_COM_TitularPlayer :
  Informs a player he is titular, from an event I'm the leader.
   ev_id   : String -- Event ID
   pl_name : String -- Player to inform
]]
function GEM_COM_TitularPlayer(ev_id,pl_name)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event ~= nil)
  then
    if(not GEM_IsMyReroll(event.leader))
    then
      GEM_ChatPrint("GEM_COM_TitularPlayer : This Event ID does not belong to me ("..ev_id..")");
      return;
    end
    if(GEM_IsMyReroll(pl_name)) -- pl_name is me !
    then
      return;
    end
    _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_TITULAR,pl_name,event.leader);
  end
end

--[[ - GUI ENTRY POINT
 function GEM_COM_SubstitutePlayer :
  Informs a player he is Substitute, from an event I'm the leader.
   ev_id   : String -- Event ID
   pl_name : String -- Player to inform
]]
function GEM_COM_SubstitutePlayer(ev_id,pl_name)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event ~= nil)
  then
    if(not GEM_IsMyReroll(event.leader))
    then
      GEM_ChatPrint("GEM_COM_SubstitutePlayer : This Event ID does not belong to me ("..ev_id..")");
      return;
    end
    if(GEM_IsMyReroll(pl_name)) -- pl_name is me !
    then
      return;
    end
    local stamp = time();
    _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_SUBSTITUTE,pl_name,event.leader);
  end
end

--[[ - GUI ENTRY POINT
 function GEM_COM_ReplacementPlayer :
  Informs a player he is Replacement, from an event I'm the leader.
   ev_id   : String -- Event ID
   pl_name : String -- Player to inform
]]
function GEM_COM_ReplacementPlayer(ev_id,pl_name)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event ~= nil)
  then
    if(not GEM_IsMyReroll(event.leader))
    then
      GEM_ChatPrint("GEM_COM_ReplacementPlayer : This Event ID does not belong to me ("..ev_id..")");
      return;
    end
    if(GEM_IsMyReroll(pl_name)) -- pl_name is me !
    then
      return;
    end
    local stamp = time();
    _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_REPLACEMENT,pl_name,event.leader);
  end
end

--[[ - GUI ENTRY POINT
 function GEM_COM_KickPlayer :
  Kicks a player from an event I'm the leader.
   ev_id   : String -- Event ID
   pl_name : String -- Player to kick from event
   reason  : String -- Why you kick him
]]
function GEM_COM_KickPlayer(ev_id,pl_name,reason)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil) -- Event does not exist anymore
  then
    return;
  end
  if(GEM_IsMyReroll(pl_name)) -- Cannot remove ourself
  then
    GEM_ChatPrint("Cannot kick myself !");
    return;
  end

  _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_KICK,pl_name,event.leader,reason);

  GEM_SUB_RemoveSubscriber(ev_id,pl_name,reason); -- Removes the subscriber
  GEM_NotifyGUI(GEM_NOTIFY_UNSUBSCRIBER,ev_id,pl_name);
end

--[[ - GUI ENTRY POINT
 function GEM_COM_BanPlayer :
  Bans a player from an event I'm the leader.
   ev_id   : String -- Event ID
   pl_name : String -- Player to ban from event
   reason  : String -- Why you ban him
]]
function GEM_COM_BanPlayer(ev_id,pl_name,reason)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil) -- Event does not exist anymore
  then
    return;
  end
  if(GEM_IsMyReroll(pl_name)) -- Cannot remove ourself
  then
    GEM_ChatPrint("Cannot ban myself !");
    return;
  end

  _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_BAN,pl_name,event.leader,reason);

  GEM_SUB_RemoveSubscriber(ev_id,pl_name,reason); -- Removes the subscriber
  GEM_EVT_SetBanned(ev_id,pl_name,reason); -- And now ban him
  GEM_NotifyGUI(GEM_NOTIFY_UNSUBSCRIBER,ev_id,pl_name);
end

--[[ - GUI ENTRY POINT
 function GEM_COM_UnBanPlayer :
  UnBans a player from an event I'm the leader.
   ev_id   : String -- Event ID
   pl_name : String -- Player to unban from event
]]
function GEM_COM_UnBanPlayer(ev_id,pl_name)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil) -- Event does not exist anymore
  then
    return;
  end

  _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_UNBAN,pl_name,event.leader);

  GEM_EVT_SetUnBanned(ev_id,pl_name); -- And now unban him
end

--[[ - GUI ENTRY POINT
 function GEM_COM_PlayerInfos :
  Sends my player informations to all channels.
]]
function GEM_COM_PlayerInfos()
  for channel,chantab in GEM_COM_Channels
  do
    if(chantab.id ~= 0)
    then
      _GEM_COM_LastPlayerInfosSend = time();
      _GEM_COM_SendMessage(channel,GEM_CMD_PLAYER_INFOS,GEM_GLOBAL_CMD,time(),GEM_PLAY_GetMyPlayerInfos(channel));
    end
  end
end

--[[ - GUI ENTRY POINT
 function GEM_COM_PlayerInfosSingle :
  Sends my player informations to a single channel.
]]
function GEM_COM_PlayerInfosSingle(channel)
  _GEM_COM_LastPlayerInfosSend = time();
  _GEM_COM_SendMessage(channel,GEM_CMD_PLAYER_INFOS,GEM_GLOBAL_CMD,time(),GEM_PLAY_GetMyPlayerInfos(channel));
end

--[[ - GUI ENTRY POINT
 function GEM_COM_AddAssistant :
  Promotes a player assistant of an event I'm the leader.
   ev_id   : String -- Event ID
   pl_name : String -- Player to promote assistant
]]
function GEM_COM_AddAssistant(ev_id,pl_name)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event == nil) -- Event does not exist anymore
  then
    return;
  end

  event.assistants[pl_name] = 1;
  _GEM_COM_PrepareAndSendCommand(ev_id,GEM_CMD_CMD_ASSISTANT,pl_name,event.leader);
end


--------------- Plugin API  ---------------

--[[ - PLUGIN API ENTRY POINT
 function GEM_COM_API_AddDispatchFunction :
  Adds a command dispatch callback function
   opcode : String   -- Unique Opcode you want to use (must represent an Int)
   func   : Function -- Function to be called when you receive this Opcode

  Prototype for command related to an event = function CallbackFunc(channel,from,stamp,ev_id,params) :
   - channel = Channel event is linked to
   - from = Sender of the message
   - stamp = Stamp the command was issued by the author of the cmd (not necessary same person than 'from')
   - ev_id = EventId the command is related to
   - Common Cmd 'params' =
     Params[1] = leader (STRING) -- Leader of the event
     Params[2] = ev_date (INT) -- Date of the event
     Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
     Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
     Params[5] = pl_src (STRING) -- Name of player the command is originating from
     Followed by specific Cmd 'params' you pass to the Send function

  Prototype for global command = function CallbackFunc(channel,from,stamp,ev_id,params) :
   - Same as previously, but ev_id = GEM_GLOBAL_CMD, and no 'common params', only 'specific params'
   
  Global commands are volatile (not stored nor forwarded by other players), while event related commands are stored and broadcasted when a new player arrives.
   
  Returns true on success, false if opcode is already in use
]]
function GEM_COM_API_AddDispatchFunction(opcode,func)
  if(_GEMComm_Dispatch[tostring(opcode)] ~= nil)
  then
    return false;
  end
  _GEMComm_Dispatch[tostring(opcode)] = func;
  return true;
end

--[[ - PLUGIN API ENTRY POINT
 function GEM_COM_API_SendVolatileCommand :
  Sends a volatile command (not stored nor forwarded by other players)
   channel : String -- Channel to send message to
   opcode  : String -- Unique Opcode you want to use (must represent an Int)
   params  : Table  -- Array of your params (must be Int index based, use table.insert())
  Returns true on success.
]]
function GEM_COM_API_SendVolatileCommand(channel,opcode,params)
  _GEM_COM_SendMessage(channel,tostring(opcode),GEM_GLOBAL_CMD,time(),unpack(params));
  return true;
end

--[[ - PLUGIN API ENTRY POINT
 function GEM_COM_API_SendCommand :
  Sends an event related command (stored and broadcasted when a new player arrives)
   channel : String -- Channel to send message to
   opcode  : String -- Unique Opcode you want to use (must represent an Int)
   ev_id   : String -- EventId command is related to
   pl_dest : String -- Recipient player the message is addressed to
   pl_src  : String -- Originator player (often the event.leader)
   params  : Table  -- Array of your params (must be Int index based, use table.insert())
  Returns true on success, false if event is unknown.
]]
function GEM_COM_API_SendCommand(channel,opcode,ev_id,pl_dest,pl_src,params)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] == nil)
  then
    return false;
  end
  _GEM_COM_PrepareAndSendCommand(ev_id,tostring(opcode),pl_dest,pl_src,unpack(params));
  return true;
end


--------------- Init dispatch table ---------------
_GEMComm_Dispatch[GEM_CMD_EVENT_UPDATE] = _GEM_COM_Process_EventUpdate;
_GEMComm_Dispatch[GEM_CMD_EVENT_CLOSE] = _GEM_COM_Process_EventClose;
_GEMComm_Dispatch[GEM_CMD_EVENT_LEADER] = _GEM_COM_Process_EventLeader;
_GEMComm_Dispatch[GEM_CMD_CMD_SUBSCRIBE] = _GEM_COM_Process_CmdSubscribe;
_GEMComm_Dispatch[GEM_CMD_CMD_UNSUBSCRIBE] = _GEM_COM_Process_CmdUnsubscribe;
_GEMComm_Dispatch[GEM_CMD_CMD_TITULAR] = _GEM_COM_Process_CmdTitular;
_GEMComm_Dispatch[GEM_CMD_CMD_SUBSTITUTE] = _GEM_COM_Process_CmdSubstitute;
_GEMComm_Dispatch[GEM_CMD_CMD_REPLACEMENT] = _GEM_COM_Process_CmdReplacement;
_GEMComm_Dispatch[GEM_CMD_CMD_KICK] = _GEM_COM_Process_CmdKick;
_GEMComm_Dispatch[GEM_CMD_CMD_BAN] = _GEM_COM_Process_CmdBan;
_GEMComm_Dispatch[GEM_CMD_CMD_UNBAN] = _GEM_COM_Process_CmdUnBan;
_GEMComm_Dispatch[GEM_CMD_PLAYER_INFOS] = _GEM_COM_Process_Global_PlayerInfos;
_GEMComm_Dispatch[GEM_CMD_CMD_ASSISTANT] = _GEM_COM_Process_CmdAssistant;



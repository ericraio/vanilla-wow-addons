--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Commands module (handle)
]]


--------------- Shared variables ---------------


--------------- Local variables ---------------
local _GEM_CMD_CloseEventSends = {};
local _GEM_CMD_AutoAckCorrespondance = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSCRIBE] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSCRIBE][GEM_CMD_CMD_SUBSCRIBE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSCRIBE][GEM_CMD_CMD_UNSUBSCRIBE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_UNSUBSCRIBE] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_UNSUBSCRIBE][GEM_CMD_CMD_SUBSCRIBE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_UNSUBSCRIBE][GEM_CMD_CMD_UNSUBSCRIBE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_TITULAR] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_TITULAR][GEM_CMD_CMD_TITULAR] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_TITULAR][GEM_CMD_CMD_SUBSTITUTE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_TITULAR][GEM_CMD_CMD_REPLACEMENT] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_TITULAR][GEM_CMD_CMD_KICK] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_TITULAR][GEM_CMD_CMD_BAN] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSTITUTE] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSTITUTE][GEM_CMD_CMD_TITULAR] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSTITUTE][GEM_CMD_CMD_SUBSTITUTE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSTITUTE][GEM_CMD_CMD_REPLACEMENT] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSTITUTE][GEM_CMD_CMD_KICK] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_SUBSTITUTE][GEM_CMD_CMD_BAN] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_REPLACEMENT] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_REPLACEMENT][GEM_CMD_CMD_TITULAR] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_REPLACEMENT][GEM_CMD_CMD_SUBSTITUTE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_REPLACEMENT][GEM_CMD_CMD_REPLACEMENT] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_REPLACEMENT][GEM_CMD_CMD_KICK] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_REPLACEMENT][GEM_CMD_CMD_BAN] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_KICK] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_KICK][GEM_CMD_CMD_TITULAR] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_KICK][GEM_CMD_CMD_SUBSTITUTE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_KICK][GEM_CMD_CMD_REPLACEMENT] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_KICK][GEM_CMD_CMD_KICK] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_KICK][GEM_CMD_CMD_BAN] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_BAN] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_BAN][GEM_CMD_CMD_TITULAR] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_BAN][GEM_CMD_CMD_SUBSTITUTE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_BAN][GEM_CMD_CMD_REPLACEMENT] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_BAN][GEM_CMD_CMD_KICK] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_BAN][GEM_CMD_CMD_BAN] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_UNBAN] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_UNBAN][GEM_CMD_CMD_KICK] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_UNBAN][GEM_CMD_CMD_UNBAN] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_ASSISTANT] = {};
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_ASSISTANT][GEM_CMD_CMD_UNSUBSCRIBE] = 1;
_GEM_CMD_AutoAckCorrespondance[GEM_CMD_CMD_ASSISTANT][GEM_CMD_CMD_ASSISTANT] = 1;


--------------- Internal functions ---------------

--[[
 function _GEM_CMD_CheckExpiredCommand
  Checks if the Event has expired yet (well 10h after)
   ev_id    : String  -- EventID
   ev_date  : Integer -- Event's date
  --
   Returns True if the event has expired. False otherwise
]]
local function _GEM_CMD_CheckExpiredCommand(ev_id,ev_date)
  if(ev_id == nil or ev_date == nil)
  then
    GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_CMD_CheckExpiredCommand : ev_id or ev_date is nil. Set as expired !");
    return true;
  end
  local tim = time();
  if((ev_date + GEM_ExpirationTime) < (tim-GEM_GetOffsetTime(ev_id)))
  then
    GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_CMD_CheckExpiredCommand : Command expired for Event "..ev_id.." ! ("..date("%c",ev_date).."--"..date("%c",tim)..")");
    GEM_EVT_ClearEvent(ev_id,"Expired command",true);
    return true;
  end
  return false;
end

local function _GEM_CMD_AckCommand(ev_id,cmd_id)
  GEM_Events.realms[GEM_Realm].commands[ev_id].cmds[cmd_id].acked = 1;
end

--[[
  _GEM_CMD_CheckCommandForward :
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
  Returns true if command must be processed, false if it has been forwarded to the new leader
]]
local function _GEM_CMD_CheckCommandForward(channel,cmd,from,stamp,ev_id,params)
  local forwarder = GEM_Events.realms[GEM_Realm].forward[ev_id];
  -- Check if we have a forwarder set
  if(forwarder ~= nil)
  then
    if(cmd == GEM_CMD_CMD_SUBSCRIBE or cmd == GEM_CMD_CMD_UNSUBSCRIBE) -- For leader commands, we must forward
    then
      -- Build new params
      local new_params = {};
      for i=1,table.getn(params) do table.insert(new_params,params[i]); end;
      new_params[1] = forwarder;
      new_params[4] = forwarder;

      if(new_params[3] == "1") -- A ACK
      then
        GEM_ChatWarning("_GEM_CMD_CheckCommandForward : Params[3] is acked. Must creat new_params entierely");
        new_params[3] = "0";
      end

      -- Store new command
      local cmd_id = forwarder.."-"..params[5].."-"..stamp.."-"..cmd;
      GEM_CMD_CreateCommandId(ev_id,cmd_id,cmd,stamp,new_params);

      -- Send the forwarded message
      GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_CMD_CheckCommandForward : Forwarding "..from.."'s cmd "..cmd.." from "..params[1].." to "..forwarder);
      GEM_COM_SendForwardCommand(channel,cmd,ev_id,stamp,new_params);
      return false;
    end
  end
  return true;
end

function _GEM_CMD_PurgeMultipleCommands_Sorting(a,b)
  if(a.stamp < b.stamp)
  then
    return true;
  else
    return false;
  end
end

local function _GEM_CMD_PurgeMultipleCommands(ev_id,cmd_id,from)
  local thiscmd = GEM_Events.realms[GEM_Realm].commands[ev_id].cmds[cmd_id].cmd;
  local thisautoack = _GEM_CMD_AutoAckCorrespondance[thiscmd];
  
  -- First, sort cmds by stamp
  local cmds = {};
  for cmdid,cmdtab in GEM_Events.realms[GEM_Realm].commands[ev_id].cmds
  do
    if(from == cmdtab.params[5]) -- This cmd is from 'from' too, add it to the list
    then
      table.insert(cmds,{ id=cmdid, cmd=cmdtab.cmd, stamp=cmdtab.stamp, acked=cmdtab.acked });
    end
  end
  table.sort(cmds,_GEM_CMD_PurgeMultipleCommands_Sorting);
  
  -- Now check for auto acked cmds
  for i,cmd in cmds
  do
    if(cmd.id == cmd_id) -- Found our cmd, stop parsing
    then
      break;
    end
    if(thisautoack[cmd.cmd]) -- This older command must be auto-acked
    then
      GEM_ChatDebug(GEM_DEBUG_COMMANDS,"_GEM_CMD_PurgeMultipleCommands : Auto acking CmdId "..cmd.id.." because of "..cmd_id);
      _GEM_CMD_AckCommand(ev_id,cmd.id);
    end
  end
end

local function _GEM_CMD_IsTooSoonCmd(ev_id,cmd_id)
  if(ev_id == nil or cmd_id == nil)
  then
    GEM_ChatWarning("_GEM_CMD_IsTooSoonCmd : ev_id or cmd_id is nil : "..tostring(ev_id).." : "..tostring(cmd_id));
    return true;
  end
  if(GEM_Events.realms[GEM_Realm].commands[ev_id].cmds[cmd_id].LastSend and GEM_Events.realms[GEM_Realm].commands[ev_id].cmds[cmd_id].LastSend > GEM_COM_LastJoinerTime) -- Sending too soon ?
  then
    return true;
  end
  return false;
end

--------------- Exported functions ---------------

function GEM_CMD_IsCommandAcked(ev_id,cmd_id)
  return GEM_Events.realms[GEM_Realm].commands[ev_id].cmds[cmd_id].acked == 1;
end

function GEM_CMD_CreateCommands(channel,ev_id,leader,ev_date)
  local s_cmd = {}
  
  s_cmd.cmds = {};
  s_cmd.channel = channel;
  s_cmd.leader = leader;
  s_cmd.ev_date = ev_date;
  GEM_Events.realms[GEM_Realm].commands[ev_id] = s_cmd;
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"GEM_CMD_CreateCommands : Creating cmds for eventID "..ev_id);
end

function GEM_CMD_CreateCommandId(ev_id,cmd_id,cmd,stamp,params)
  local s_cmd = {};

  s_cmd.cmd = cmd;
  s_cmd.stamp = stamp;
  s_cmd.acked = 0;
  s_cmd.params = params;
  GEM_Events.realms[GEM_Realm].commands[ev_id].cmds[cmd_id] = s_cmd;
  GEM_ChatDebug(GEM_DEBUG_COMMANDS,"GEM_CMD_CreateCommandId : Creating a new cmdID "..cmd_id.." for eventID "..ev_id);
  _GEM_CMD_PurgeMultipleCommands(ev_id,cmd_id,params[5]);
end

function GEM_CMD_GetCommands(ev_id)
  return GEM_Events.realms[GEM_Realm].commands[ev_id];
end

--[[
  GEM_CMD_ReceivedCommand :
   Params[1] = leader (STRING) -- Leader of the event
   Params[2] = ev_date (INT) -- Date of the event
   Params[3] = ack (STRING) -- 1 or 0, if the packet is an ack to the command or not
   Params[4] = pl_dest (STRING) -- Name of player the command is destinated to
   Params[5] = pl_src (STRING) -- Name of player the command is originating from
]]
function GEM_CMD_ReceivedCommand(channel,cmd,from,stamp,ev_id,params)
  local cmd_id = params[4].."-"..params[5].."-"..stamp.."-"..cmd;
  local ev_date = tonumber(params[2]);
  local must_process = false;

  -- First check if command is not expired
  if(_GEM_CMD_CheckExpiredCommand(ev_id,ev_date))
  then
    return must_process;
  end

  -- Check for unknown event if I'm leader
  if(GEM_IsMyReroll(params[1]) and GEM_Events.realms[GEM_Realm].events[ev_id] == nil) -- Unknown event
  then
    GEM_ChatDebug(GEM_DEBUG_COMMANDS,"GEM_CMD_ReceivedCommand : I'm leader of EventID "..ev_id..", but I don't know it.");
  end
  
  -- Create the CMD struct for this ev_id, if it does not exist
  if(GEM_Events.realms[GEM_Realm].commands[ev_id] == nil)
  then
    GEM_CMD_CreateCommands(channel,ev_id,params[1],ev_date);
  end

  -- Then check if commandID exists
  if(GEM_Events.realms[GEM_Realm].commands[ev_id].cmds[cmd_id] == nil)
  then
    GEM_CMD_CreateCommandId(ev_id,cmd_id,cmd,stamp,params);
  end

  GEM_QUE_RemoveCommandFromQueue(ev_id,cmd_id); -- Remove from queue. It will be resent if needed
  if(params[3] == "1") -- A ACK
  then
    GEM_ChatDebug(GEM_DEBUG_COMMANDS,"GEM_CMD_ReceivedCommand : Received an ACK from "..from.." for cmdID : "..cmd_id);
    _GEM_CMD_AckCommand(ev_id,cmd_id);
  else -- A command (not a ACK)
    -- Check if I already have a ACK for this
    if(GEM_CMD_IsCommandAcked(ev_id,cmd_id)) -- I have a ACK
    then
      if(not _GEM_CMD_IsTooSoonCmd(ev_id,cmd_id))
      then
        GEM_ChatDebug(GEM_DEBUG_COMMANDS,"GEM_CMD_ReceivedCommand : I already have a ACK for cmdID "..cmd_id..". Broadcasting my ACK");
        GEM_COM_SendAckCommand(ev_id,cmd_id); -- Broadcast the ACK
      end
    elseif(GEM_IsMyReroll(params[4])) -- This command is for me, ACK it
    then
      GEM_ChatDebug(GEM_DEBUG_COMMANDS,"GEM_CMD_ReceivedCommand : Got cmdID "..cmd_id.." for me. Broadcasting ACK");
      _GEM_CMD_AckCommand(ev_id,cmd_id);
      GEM_COM_SendAckCommand(ev_id,cmd_id); -- Broadcast the ACK
      must_process = _GEM_CMD_CheckCommandForward(channel,cmd,from,stamp,ev_id,params);
    end
  end
  
  return must_process;
end


--[[
 function GEM_CMD_CheckExpiredCommands
  Checks all commands, for expired ones
]]
function GEM_CMD_CheckExpiredCommands()
  for ev_id,cmdtab in GEM_Events.realms[GEM_Realm].commands
  do
    _GEM_CMD_CheckExpiredCommand(ev_id,cmdtab.ev_date);
  end
end


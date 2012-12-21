--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Queues module (broadcast/build)
]]

--------------- Local variables ---------------
local _GEM_QUE_immediateQueue = {};
local _GEM_QUE_delayedQueue = {};
local _GEM_QUE_cmdQueue = {};
local _GEM_MaxBcastRow = 2;
local _GEM_MinimalTimeBeforeSend = 2;
local _GEM_RejoinTooSoon = 60; -- 60 sec delay

--------------- Internal functions ---------------

local function _GEM_QUE_CheckForBroadcast(queue)
  local curr_count = 0;
  if(queue == 1) -- Immediate EVENT queue
  then
    GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Start immediate EVENT queue");
    for ev_id,event in _GEM_QUE_immediateQueue
    do
      curr_count = curr_count + 1;
      if(curr_count > _GEM_MaxBcastRow or GEM_YouAreDrunk) -- Check for reschedule later
      then
        GEMSystem_Schedule(1,_GEM_QUE_CheckForBroadcast,1);
        GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Queue continue in 1sec");
        return;
      end
      GEM_COM_BroadcastEvent(event);
      _GEM_QUE_immediateQueue[ev_id] = nil;
    end
    GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Complete");
  elseif(queue == 2) -- Delayed EVENT queue
  then
    GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Start delayed EVENT queue");
    for ev_id,event in _GEM_QUE_delayedQueue
    do
      curr_count = curr_count + 1;
      if(curr_count > _GEM_MaxBcastRow or GEM_YouAreDrunk) -- Check for reschedule later
      then
        GEMSystem_Schedule(2,_GEM_QUE_CheckForBroadcast,2);
        GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Queue continue in 2sec");
        return;
      end
      GEM_COM_BroadcastEvent(event);
      _GEM_QUE_delayedQueue[ev_id] = nil;
    end
    GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Complete");
  elseif(queue == 3) -- Delayed CMD queue
  then
    GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Start delayed CMD queue");
    for ev_id,cmdstab in _GEM_QUE_cmdQueue
    do
      while(table.getn(cmdstab) > 0)
      do
        curr_count = curr_count + 1;
        if(curr_count > _GEM_MaxBcastRow or GEM_YouAreDrunk) -- Check for reschedule later
        then
          GEMSystem_Schedule(2,_GEM_QUE_CheckForBroadcast,3);
          GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Queue continue in 2sec");
          return;
        end
        local cmd_id = _GEM_QUE_cmdQueue[ev_id][table.getn(_GEM_QUE_cmdQueue[ev_id])]; -- Get cmd_id value from queue
        table.remove(_GEM_QUE_cmdQueue[ev_id]); -- Immediately remove cmd_id from queue
        if(not GEM_CMD_IsCommandAcked(ev_id,cmd_id)) -- Still not acked, send it
        then
          GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Broadcasting cmdID "..cmd_id.." from eventID "..ev_id);
          GEM_COM_BroadcastCommand(ev_id,cmd_id);
        end
      end
      _GEM_QUE_cmdQueue[ev_id] = nil;
    end
    GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_CheckForBroadcast : Complete");
  end
end

local function _GEM_QUE_BuildCommandsQueue(channel,forcesend)
  -- Acks queues
  for ev_id,cmdstab in GEM_Events.realms[GEM_Realm].commands
  do
    GEM_CheckCommandHasChannel(cmdstab);
    if(cmdstab.channel == channel)
    then
      for cmd_id,tab in cmdstab.cmds
      do
        if(not GEM_CMD_IsCommandAcked(ev_id,cmd_id))
        then
          if(forcesend or GEM_IsMyReroll(tab.params[5])) -- Forced send, or if it is a command from me
          then
            if(_GEM_QUE_cmdQueue[ev_id] == nil)
            then
              _GEM_QUE_cmdQueue[ev_id] = {};
            end
            tinsert(_GEM_QUE_cmdQueue[ev_id],cmd_id);
            GEM_ChatDebug(GEM_DEBUG_QUEUES,"_GEM_QUE_BuildCommandsQueue : "..channel.." : Added cmdID "..cmd_id.." to ACK queue for eventID "..ev_id);
          end
        end
      end
    end
  end
end


--------------- Exported functions ---------------

function GEM_QUE_RemoveEventFromQueue(ev_id)
  _GEM_QUE_immediateQueue[ev_id] = nil;
  _GEM_QUE_delayedQueue[ev_id] = nil;
end

function GEM_QUE_RemoveCommandFromQueue(ev_id,cmd_id)
  local cmdstab = _GEM_QUE_cmdQueue[ev_id];
  
  if(cmdstab == nil)
  then
    return;
  end
  for pos,cmd in cmdstab
  do
    if(cmd == cmd_id)
    then
      GEM_ChatDebug(GEM_DEBUG_QUEUES,"GEM_QUE_RemoveCommandFromQueue : Removed cmdID "..cmd_id.." from cmdQueue");
      table.remove(cmdstab,pos);
      return;
    end
  end
end

--[[
 function GEM_QUE_RemoveCommands
  Remove all commands for this event.
   ev_id : String -- EventID for commands to remove from ACK list
]]
function GEM_QUE_RemoveCommands(ev_id)
  -- Cancel delayed queue
  _GEM_QUE_cmdQueue[ev_id] = {};
end

--[[
  Builds broadcast queues.
   player : String -- Player who joined the channel
]]
function GEM_QUE_BuildBroadcastQueues(channel,player)
  -- Check for player's last leave
  local last_leave = GEM_PLAY_GetLastLeave(channel,player);
  local tim = time();

  if((last_leave + _GEM_RejoinTooSoon) > tim)
  then
    GEM_ChatDebug(GEM_DEBUG_QUEUES,"GEM_QUE_BuildBroadcastQueues : "..channel.." : Player "..tostring(player).." rejoining too soon the channel. Don't broadcast");
    return;
  end
  
  -- Check for expired events
  GEM_EVT_CheckExpiredEvents();

  -- Events queues
  for ev_id,event in GEM_Events.realms[GEM_Realm].events
  do
    GEM_CheckEventHasChannel(event);
    if(event.channel == channel)
    then
      if(GEM_IsMyReroll(event.leader)) -- My event -> Immediate queue
      then
        _GEM_QUE_immediateQueue[ev_id] = event;
        GEM_ChatDebug(GEM_DEBUG_QUEUES,"GEM_QUE_BuildBroadcastQueues : "..channel.." : Added EventID "..ev_id.." to immediate queue");
      elseif(event.leader ~= player) -- Player is not the leader -> Delayed queue
      then
        _GEM_QUE_delayedQueue[ev_id] = event;
        GEM_ChatDebug(GEM_DEBUG_QUEUES,"GEM_QUE_BuildBroadcastQueues : "..channel.." : Added EventID "..ev_id.." to delayed queue");
      end
    end
  end

  -- Check for expired commands
  GEM_CMD_CheckExpiredCommands();
  
  -- Build commands
  _GEM_QUE_BuildCommandsQueue(channel,true);

  -- Send Immediate queue
  GEMSystem_Schedule(_GEM_MinimalTimeBeforeSend,_GEM_QUE_CheckForBroadcast,1); -- 1 = Immediate EVENT queue
  GEM_ChatDebug(GEM_DEBUG_QUEUES,"Scheduled 'delayed_queue' in "..GEM_Events.my_bcast_offset.."sec");
  GEMSystem_Schedule(_GEM_MinimalTimeBeforeSend+GEM_Events.my_bcast_offset,_GEM_QUE_CheckForBroadcast,2); -- 2 = Delayed EVENT queue
  GEMSystem_Schedule(_GEM_MinimalTimeBeforeSend+GEM_Events.my_bcast_offset+1,_GEM_QUE_CheckForBroadcast,3); -- 3 = ACK EVENT queue
end

--[[
function GEM_QUE_BroadcastMyEvents(channel)
  for ev_id,event in GEM_Events.realms[GEM_Realm].events
  do
    GEM_CheckEventHasChannel(event);
    if(event.channel == channel)
    then
      if(GEM_IsMyReroll(event.leader)) -- My event -> Immediate queue
      then
        GEM_ChatDebug(GEM_DEBUG_QUEUES,"GEM_QUE_BroadcastMyEvents : "..channel.." : Adding my EventID "..ev_id.." to immediate broadcast queue");
        _GEM_QUE_immediateQueue[ev_id] = event;
      end
    end
  end

  _GEM_QUE_BuildCommandsQueue(channel,false);

  GEMSystem_Schedule(_GEM_MinimalTimeBeforeSend,_GEM_QUE_CheckForBroadcast,1); -- 1 = Immediate EVENT queue
  GEMSystem_Schedule(_GEM_MinimalTimeBeforeSend+GEM_Events.my_bcast_offset+1,_GEM_QUE_CheckForBroadcast,3); -- 3 = ACK EVENT queue
end
]]

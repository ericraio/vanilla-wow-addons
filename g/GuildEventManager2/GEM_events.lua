--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Events module (handle)
]]


--------------- Shared variables ---------------
GEM_ExpirationTime = 60*60*1; -- 1 hour
GEM_ExpirationTimeSelf = 60*60*10; -- 10 hours

--------------- Local variables ---------------

--------------- Internal functions ---------------

local function _GEM_EVT_CheckMySubscription(ev_id)
  if(GEM_Events.realms[GEM_Realm].subscribed[ev_id] == nil) -- I never subscribed
  then
    -- Check titulars list
    for i,tab in GEM_Events.realms[GEM_Realm].events[ev_id].titulars do
      if(GEM_IsMyReroll(tab.name))
      then
        local infos = GEM_Events.realms[GEM_Realm].my_names[tab.name];
        if(infos ~= nil)
        then
          GEM_EVT_SubscribeMyself(ev_id,tab.name,infos.guild,infos.level,infos.class,"",0,"1");
        end
        return;
      end
    end
    
    -- Check substitutes list
    for i,tab in GEM_Events.realms[GEM_Realm].events[ev_id].substitutes do
      if(GEM_IsMyReroll(tab.name))
      then
        local infos = GEM_Events.realms[GEM_Realm].my_names[tab.name];
        if(infos ~= nil)
        then
          GEM_EVT_SubscribeMyself(ev_id,tab.name,infos.guild,infos.level,infos.class,"",0,"2");
        end
        return;
      end
    end
    
    -- Check replacements list
    for i,tab in GEM_Events.realms[GEM_Realm].events[ev_id].replacements do
      if(GEM_IsMyReroll(tab.name))
      then
        local infos = GEM_Events.realms[GEM_Realm].my_names[tab.name];
        if(infos ~= nil)
        then
          GEM_EVT_SubscribeMyself(ev_id,tab.name,infos.guild,infos.level,infos.class,"",1,"3");
        end
        return;
      end
    end
  end
end


--------------- Exported functions ---------------

function GEM_EVT_SubscribeMyself(ev_id,name,guild,level,class,comment,forcesub,state)
  GEM_Events.realms[GEM_Realm].kicked[ev_id] = nil; -- Unkick me if I was
  GEM_Events.realms[GEM_Realm].subscribed[ev_id] = {};
  GEM_Events.realms[GEM_Realm].subscribed[ev_id].state = state;
  GEM_Events.realms[GEM_Realm].subscribed[ev_id].comment = comment;
  GEM_Events.realms[GEM_Realm].subscribed[ev_id].forcesub = forcesub;
  GEM_Events.realms[GEM_Realm].subscribed[ev_id].name = name;
  GEM_Events.realms[GEM_Realm].subscribed[ev_id].class = class;
  GEM_Events.realms[GEM_Realm].subscribed[ev_id].guild = guild;
  GEM_Events.realms[GEM_Realm].subscribed[ev_id].level = level;
end

function GEM_GetOffsetTime(ev_id)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] == nil)
  then
    return 0;
  end
  return GEM_Events.realms[GEM_Realm].events[ev_id].offset_time;
end

function GEM_SetOffsetStamp(ev_id,leader_stamp)
  GEM_Events.realms[GEM_Realm].events[ev_id].offset_time = time() - leader_stamp;
  GEM_ChatDebug(GEM_DEBUG_EVENTS,"I have an offset of "..GEM_Events.realms[GEM_Realm].events[ev_id].offset_time.." sec from Leader");
end

function GEM_EVT_AddEvent(channel,ev_id,creat_time,leader,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,titulars,substitutes,replacements,sorttype,closed_comment)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] ~= nil) then GEM_ChatDebug(GEM_DEBUG_EVENTS,"Already have an Event with that ID ("..ev_id..")"); return GEM_Events.realms[GEM_Realm].events[ev_id]; end;
  local event = {};
  event.channel = channel;
  event.id = ev_id;
  event.update_time = creat_time;
  event.offset_time = 0;
  event.leader = leader;
  event.ev_date = ev_date;
  event.ev_place = ev_place;
  event.ev_comment = ev_comment;
  event.max_count = max_count;
  event.min_lvl = min_lvl;
  event.max_lvl = max_lvl;
  event.classes = classes;
  event.titular_count = table.getn(titulars);
  event.titulars = titulars;
  event.substitutes = substitutes;
  event.replacements = replacements;
  event.sorttype = sorttype;
  if(closed_comment and closed_comment ~= "")
  then
    event.closed_comment = closed_comment;
  end
  event.players = {}; -- Leader side only
  event.banned = {}; -- Leader side only
  event.assistants = {}; -- Leader side only
  GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_AddEvent : EventId "..ev_id.." Leader="..leader.." Date="..date("%c",ev_date).." ("..ev_date..") Place="..ev_place);
  GEM_Events.realms[GEM_Realm].events[ev_id] = event;
  return event;
end

-- Returns true if event updated, false otherwise
function GEM_EVT_UpdateEvent(channel,ev_id,update_time,leader,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,titulars,substitutes,replacements,sorttype,closed_comment)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  local tim = time();

  if(GEM_IsMyReroll(leader)) -- If I'm the leader of this event
  then
    if(event and update_time == event.update_time) -- Someone just sent the event, cancel the send
    then
      GEM_QUE_RemoveEventFromQueue(ev_id);
    end
    if(event == nil)
    then
      if(GEM_Events.realms[GEM_Realm].my_closed_events[ev_id] == nil) -- Never heard of this event
      then
        if((ev_date + GEM_ExpirationTime) > tim)
	then
          GEM_ChatPrint("WARNING : I'm supposed to be the leader of '"..ev_id.."' but I don't know it. Auto-closing event. This happen if you crashed the game, after creating the event. You can try to 'Recover' the event.");
          event = GEM_EVT_AddEvent(channel,ev_id,update_time,leader,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,titulars,substitutes,replacements,sorttype,"Leader lost the event (crashed)");
          event.crashed = 1;
          GEM_COM_NotifyEventUpdate(ev_id);
          GEM_NotifyGUI(GEM_NOTIFY_NEW_EVENT,ev_id);
	else
          GEM_ChatDebug(GEM_DEBUG_WARNING,"GEM_EVT_UpdateEvent : I'm supposed to be the leader of '"..ev_id.."', it's expired, ignoring.");
	end
      else -- I deleted this event
        GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_UpdateEvent : Event "..ev_id.." was deleted ! Resending deleted event notification.");
        event = GEM_EVT_AddEvent(channel,ev_id,update_time,leader,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,titulars,substitutes,replacements,sorttype,"Event was deleted");
        event.ev_date = time() - GEM_ExpirationTimeSelf * 2;
        event.update_time = time();
        GEM_COM_BroadcastEvent(event); -- Force brodcast (or it will be deleted before update)
        GEM_Events.realms[GEM_Realm].events[ev_id] = nil;
      end
    end
    return false; -- Return, not interested in an update of my own event
  end

  if((ev_date + GEM_ExpirationTime) < (tim-GEM_GetOffsetTime(ev_id)))
  then
    GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_UpdateEvent : Event "..ev_id.." expired ! ev_date="..date("%c",ev_date).." ("..ev_date..")");
    GEM_EVT_ClearEvent(ev_id,"Expired",true);
    return false;
  end

  if(event == nil) -- Never seen this event, create it
  then
    GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_UpdateEvent : EventID not found ("..ev_id..") : Creating");
    event = GEM_EVT_AddEvent(channel,ev_id,update_time,leader,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,titulars,substitutes,replacements,sorttype,closed_comment);
    _GEM_EVT_CheckMySubscription(ev_id);
    event.update_time = update_time;
    GEM_NotifyGUI(GEM_NOTIFY_NEW_EVENT,ev_id);
    return true;
  end
  
  if(update_time > event.update_time) -- New update, destroy and re-create it
  then
    GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_UpdateEvent : Found an update for EventID "..ev_id);
    GEM_Events.realms[GEM_Realm].events[ev_id] = nil;
    event = GEM_EVT_AddEvent(channel,ev_id,update_time,leader,ev_date,ev_place,ev_comment,max_count,min_lvl,max_lvl,classes,titulars,substitutes,replacements,sorttype,closed_comment);
    _GEM_EVT_CheckMySubscription(ev_id);
    event.update_time = update_time;
    GEM_QUE_RemoveEventFromQueue(ev_id);
    GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,ev_id);
  elseif(update_time == event.update_time) -- Someone just sent the event, cancel the send
  then
    GEM_QUE_RemoveEventFromQueue(ev_id);
  else -- Old event
    GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_UpdateEvent : Found an old update for EventID "..ev_id);
  end
  return true;
end


--[[
 function GEM_EVT_CloseEvent
  Close an event (called by leader only).
   ev_id   : String -- EventID to be closed
   reason  : String -- Reason of the close
]]
function GEM_EVT_CloseEvent(ev_id,reason)
  if(reason == nil or reason == "")
  then
    reason = GEM_TEXT_NO_REASON;
  end
  GEM_EVT_ClearEvent(ev_id,reason,false);
  GEM_Events.realms[GEM_Realm].my_closed_events[ev_id] = 1;
  GEM_Events.realms[GEM_Realm].events[ev_id].crashed = nil; -- Un-crash it
  GEM_COM_NotifyEventUpdate(ev_id); -- Notify an update
end

--[[
 function GEM_EVT_UnCloseEvent
  Unclose a closed event (called by leader only).
   ev_id   : String  -- EventID to be unclosed
]]
function GEM_EVT_UnCloseEvent(ev_id)
  GEM_Events.realms[GEM_Realm].events[ev_id].closed_comment = nil;
  GEM_Events.realms[GEM_Realm].my_closed_events[ev_id] = nil;
  GEM_COM_NotifyEventUpdate(ev_id); -- Notify an update
end


--[[
 function GEM_EVT_ClearEvent
  Remove all infos about this event.
   ev_id   : String  -- EventID to be removed
   comment : String  -- Comment for close event
   purge   : Boolean -- If event must be completly purged
]]
function GEM_EVT_ClearEvent(ev_id,comment,purge)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  -- Remove from NewEvents
  if(GEM_IsNewEvent(ev_id))
  then
    GEM_RemoveNewEvent(ev_id);
  end
  -- Set close comment
  GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_ClearEvent : Clearing Event "..ev_id.." : "..comment);
  if(event)
  then
    event.closed_comment = comment;
  end
  if(purge)
  then
    -- Remove the event
    GEM_ChatDebug(GEM_DEBUG_EVENTS,"GEM_EVT_ClearEvent : Purging Event "..ev_id.." : "..comment);
    GEM_Events.realms[GEM_Realm].events[ev_id] = nil;
    -- Clear all related infos  
    GEM_Events.realms[GEM_Realm].commands[ev_id] = nil; -- Remove commands
    GEM_Events.realms[GEM_Realm].subscribed[ev_id] = nil; -- Remove my subscriptions
    GEM_Events.realms[GEM_Realm].kicked[ev_id] = nil; -- Remove kicks
    GEM_Events.realms[GEM_Realm].banned[ev_id] = nil; -- Remove bans
    GEM_Events.realms[GEM_Realm].forward[ev_id] = nil; -- Remove bans
    GEM_Events.realms[GEM_Realm].assistant[ev_id] = nil; -- Remove assistant
    -- DON'T REMOVE FROM IGNORE LIST !!!
  end
  -- Clear queues
  GEM_QUE_RemoveCommands(ev_id);
  -- Notify GUI
  GEM_NotifyGUI(GEM_NOTIFY_CLOSE_EVENT,ev_id);
end

function GEM_EVT_SetBanned(ev_id,pl_name,reason)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] ~= nil)
  then
    GEM_Events.realms[GEM_Realm].events[ev_id].banned[pl_name] = reason;
  end
end

function GEM_EVT_SetUnBanned(ev_id,pl_name)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] ~= nil)
  then
    GEM_Events.realms[GEM_Realm].events[ev_id].banned[pl_name] = nil;
  end
end

function GEM_EVT_IsBanned(ev_id,pl_name)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] == nil)
  then
    return false;
  end
  return GEM_Events.realms[GEM_Realm].events[ev_id].banned[pl_name] ~= nil;
end

--[[
 function GEM_EVT_CheckExpiredEvent
  Checks if the Event has expired yet (well 10h after)
   ev_id    : String  -- EventID
  --
   Returns True if the event has expired. False otherwise
]]
function GEM_EVT_CheckExpiredEvent(ev_id)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];

  if(event)
  then
    local tim = time();
    if(event.ev_date == nil)
    then
      return true;
    end
    local expire_time = GEM_ExpirationTime;
    if(GEM_IsMyReroll(event.leader))
    then
      expire_time = GEM_ExpirationTimeSelf;
    end
    if((event.ev_date + expire_time) < (tim-GEM_GetOffsetTime(ev_id)))
    then
      GEM_EVT_ClearEvent(ev_id,"Expired",true);
    end
  end
  return false;
end

--[[
 function GEM_EVT_CheckExpiredEvents
  Checks all events, for expired ones
]]
function GEM_EVT_CheckExpiredEvents()
  for ev_id,event in GEM_Events.realms[GEM_Realm].events
  do
    GEM_EVT_CheckExpiredEvent(ev_id);
  end
end


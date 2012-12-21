--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Subscribers module (Sorting/Adding/Managing)
]]


--------------- Local variables ---------------

GEM_SUB_Plugins = {};


--------------- Internal functions ---------------

local function _GEM_SUB_IsTitular(ev_id,pl_name)
  for i,tab in GEM_Events.realms[GEM_Realm].events[ev_id].titulars do
    if(tab.name == pl_name)
    then
      return true;
    end
  end
  return false;
end

local function _GEM_SUB_IsSubstitute(ev_id,pl_name)
  for i,tab in GEM_Events.realms[GEM_Realm].events[ev_id].substitutes do
    if(tab.name == pl_name)
    then
      return true;
    end
  end
  return false;
end

local function _GEM_SUB_IsReplacement(ev_id,pl_name)
  for i,tab in GEM_Events.realms[GEM_Realm].events[ev_id].replacements do
    if(tab.name == pl_name)
    then
      return true;
    end
  end
  return false;
end


--------------- Exported functions ---------------

function GEM_SUB_AddToReplacementList(ev_id,pl_name,pl_guild,pl_class,pl_level)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  if(event == nil)
  then
    return;
  end
  table.insert(event.replacements,{name=pl_name,guild=pl_guild,class=pl_class,level=pl_level});
  event.classes[pl_class].repl_count = event.classes[pl_class].repl_count + 1;
  GEM_COM_ReplacementPlayer(ev_id,pl_name);
  GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_AddToReplacementList : Added "..pl_name.." to Replacement list");
end

function GEM_SUB_RemoveFromReplacementList(ev_id,pl_name,pl_class)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  if(event == nil)
  then
    return;
  end
  for i,tab in event.replacements do
    if(tab.name == pl_name)
    then
      table.remove(event.replacements,i);
      event.classes[pl_class].repl_count = event.classes[pl_class].repl_count - 1;
      GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_RemoveFromReplacementList : Removed "..pl_name.." from replacement list");
      return;
    end
  end
end

function GEM_SUB_CreateSubscriber(ev_id,pl_stamp,pl_name,pl_class,pl_guild,pl_level,pl_comment,forcesub,forcetit)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  if(event == nil)
  then
    return;
  end
  if(event.players[pl_name] ~= nil)
  then
    event.players[pl_name].update_time = pl_stamp;
    event.players[pl_name].level = pl_level;
    event.players[pl_name].comment = pl_comment;
    GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_CreateSubscriber : Player "..pl_name.." already in my list. Updating stamp, level and comment");
    if(GEM_SUB_SortPlayers(ev_id))
    then
      GEM_COM_NotifyEventUpdate(ev_id); -- Schedule an event update
    end
    return;
  end
  event.players[pl_name] = {};
  event.players[pl_name].class = pl_class;
  event.players[pl_name].level = pl_level;
  event.players[pl_name].update_time = pl_stamp; -- Leader side only
  event.players[pl_name].guild = pl_guild; -- Leader side only
  event.players[pl_name].comment = pl_comment; -- Leader side only
  event.players[pl_name].forcesub = forcesub; -- Leader side only
  event.players[pl_name].forcetit = forcetit; -- Leader side only
  if(event.players[pl_name].forcetit == nil)
  then
    event.players[pl_name].forcetit = 0;
  end

  if(forcesub == 1)
  then
    GEM_SUB_AddToReplacementList(ev_id,pl_name,pl_guild,pl_class,pl_level);
  else
    GEM_SUB_SortPlayers(ev_id); -- Sort players
  end
  GEM_COM_NotifyEventUpdate(ev_id); -- Schedule an event update
end

function GEM_SUB_RemoveSubscriber(ev_id,pl_name,comment)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  if(event == nil)
  then
    return;
  end
  if(event.players[pl_name] == nil) -- Unknown player
  then
    GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_RemoveSubscriber : Unknown player "..pl_name);
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_RemoveSubscriber : Removing player "..pl_name);
  
  local pl_class = event.players[pl_name].class;
  
  event.players[pl_name] = nil; -- Remove player

  if(_GEM_SUB_IsReplacement(ev_id,pl_name)) -- Player was a replacement ?
  then
    GEM_SUB_RemoveFromReplacementList(ev_id,pl_name,pl_class);
  else
    GEM_SUB_SortPlayers(ev_id); -- Sort players
  end

  event.assistants[pl_name] = nil; -- Remove assistant status
  GEM_COM_NotifyEventUpdate(ev_id); -- Schedule an event update
end

function GEM_SUB_SetTitular(ev_id,pl_stamp,pl_name)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] ~= nil)
  then
    if(GEM_Events.realms[GEM_Realm].subscribed[ev_id] ~= nil)
    then
      GEM_Events.realms[GEM_Realm].subscribed[ev_id].state = "1";
      GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_SetTitular : I'm now a TITULAR from EventID "..ev_id);
      GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
    end
  end
end

function GEM_SUB_SetSubstitute(ev_id,pl_stamp,pl_name)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] ~= nil)
  then
    if(GEM_Events.realms[GEM_Realm].subscribed[ev_id] ~= nil)
    then
      GEM_Events.realms[GEM_Realm].subscribed[ev_id].state = "2";
      GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_SetSubstitute : I'm now a SUBSTITUTE from EventID "..ev_id);
      GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
    end
  end
end

function GEM_SUB_SetReplacement(ev_id,pl_stamp,pl_name)
  if(GEM_Events.realms[GEM_Realm].events[ev_id] ~= nil)
  then
    if(GEM_Events.realms[GEM_Realm].subscribed[ev_id] ~= nil)
    then
      GEM_Events.realms[GEM_Realm].subscribed[ev_id].state = "3";
      GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_SetReplacement : I'm now a REPLACEMENT from EventID "..ev_id);
      GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,ev_id);
    end
  end
end

function GEM_SUB_CheckPlayersLevel(ev_id)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  if(event == nil)
  then
    GEM_ChatWarning("GEM_SUB_CheckPlayersLevel : Trying to sort a nil event ("..ev_id..")");
    return;
  end
  for name,tab in event.players do
    if(tab.level < event.min_lvl or tab.level > event.max_lvl) -- Not in level range anymore
    then
      GEM_COM_KickPlayer(ev_id,name,GEM_TEXT_ERR_LEVEL_FAILED);
    end
  end
end

function GEM_SUB_RegisterPlugin(plugin)
  if(type(plugin) ~= "table")
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin : Passed plugin is not a table");
    return;
  end
  if(plugin.Name == nil)
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin : Passed plugin has no 'Name' parameter");
    return;
  end
  if(type(plugin.Name) ~= "string")
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin : Passed plugin's 'Name' value is not a string");
    return;
  end
  local name = plugin.Name;
  if(plugin.SortType == nil)
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin has no 'SortType' parameter");
    return;
  end
  if(type(plugin.SortType) ~= "string")
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'SortType' value is not a string");
    return;
  end
  if(plugin.Sort == nil)
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin has no 'Sort' function");
    return;
  end
  if(type(plugin.Sort) ~= "function")
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'Sort' value is not a function");
    return;
  end
  if(plugin.Configure and type(plugin.Configure) ~= "function")
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'Configure' value is not a function");
    return;
  end
  if(plugin.Help and type(plugin.Help) ~= "string")
  then
    GEM_ChatPrint("GEM_SUB_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'Help' value is not a string");
    return;
  end
  GEM_SUB_Plugins[name] = plugin;
  GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEM_SUB_RegisterPlugin : Successfully loaded plugin '"..name.."'");
end

function GEM_SUB_GetPlugin(sorttype)
  for name,plugin in GEM_SUB_Plugins do
    if(plugin.SortType == sorttype)
    then
      return plugin;
    end
  end
  return nil;
end

function GEM_SUB_GetSortType(sortname)
  if(sortname == nil)
  then
    return nil;
  end

  local plugin = GEM_SUB_Plugins[sortname];
  if(plugin ~= nil)
  then
    return plugin.SortType;
  end
  return nil;
end


--[[
  Main sorting function.
   Returns True if order changed, false otherwise
]]
function GEM_SUB_SortPlayers(ev_id)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  if(event == nil)
  then
    GEM_ChatWarning("GEM_SUB_SortPlayers : Trying to sort a nil event ("..ev_id..")");
    return false;
  end
  local plugin = GEM_SUB_GetPlugin(event.sorttype);
  
  if(plugin == nil)
  then
    GEM_ChatWarning("GEM_SUB_SortPlayers : Cannot find selected sorting plugin ("..event.sorttype..") !");
    return false;
  end
  local players = {};
  for name,tab in event.players do
    if(tab.forcesub == 0) -- Only add non-forcesub players
    then
      players[name] = tab;
    end
  end

  -- Build classes limits
  local classes = {};
  for name,tab in event.classes do
    local max = tab.max;
    local min = tab.min;
    if(max == nil or max == -1)
    then
      max = 666;
    end
    if(min == nil or min == -1)
    then
      min = 0;
    end
    classes[name] = { min=min,max=max,count=0 };
  end

  local res_tit,res_sub = plugin.Sort(players,classes,event.max_count);
  
  -- Check if order has changed
  local update = false;
  if(event.titular_count ~= table.getn(res_tit) or table.getn(event.substitutes) ~= table.getn(res_sub))
  then
    update = true;
  end
  
  for name,tab in event.classes do
    event.classes[name].tit_count = 0;
    event.classes[name].sub_count = 0;
  end

  -- Rebuild the lists
  local new_tit = {};
  for i,name in res_tit do
    if(event.titulars[i] == nil or event.titulars[i].name ~= name) -- Not the same order, tag for update
    then
      update = true;
      if(not _GEM_SUB_IsTitular(ev_id,name)) -- Was not a titular previously
      then
        GEM_COM_TitularPlayer(ev_id,name);
        GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_SortPlayers : Added "..name.." to Titular list");
      end
    end
    local player = event.players[name];
    if(player == nil)
    then
      GEM_ChatWarning("GEM_SUB_SortPlayers : Failed to find titular player '"..name.."' in my players list !");
    else
      table.insert(new_tit,{name=name,stamp=player.update_time,guild=player.guild,class=player.class,level=player.level});
      event.classes[player.class].tit_count = event.classes[player.class].tit_count + 1;
    end
  end
  event.titulars = new_tit;
  event.titular_count = table.getn(new_tit);

  local new_sub = {};
  for i,name in res_sub do
    if(event.substitutes[i] == nil or event.substitutes[i].name ~= name) -- Not the same order, tag for update
    then
      update = true;
      if(not _GEM_SUB_IsSubstitute(ev_id,name)) -- Was not a substitute previously
      then
        GEM_COM_SubstitutePlayer(ev_id,name);
        GEM_ChatDebug(GEM_DEBUG_SUBSCRIBERS,"GEM_SUB_SortPlayers : Added "..name.." to Substitute list");
      end
    end
    local player = event.players[name];
    if(player == nil)
    then
      GEM_ChatWarning("GEM_SUB_SortPlayers : Failed to find substitute player '"..name.."' in my players list !");
    else
      table.insert(new_sub,{name=name,stamp=player.update_time,guild=player.guild,class=player.class,level=player.level});
      event.classes[player.class].sub_count = event.classes[player.class].sub_count + 1;
    end
  end
  event.substitutes = new_sub;
  
  return update;
end

function GEM_SUB_RecoverSubscribers(ev_id)
  local event = GEM_Events.realms[GEM_Realm].events[ev_id];
  if(event == nil)
  then
    GEM_ChatWarning("GEM_SUB_RecoverSubscribers : Trying to recover a nil event ("..ev_id..")");
    return false;
  end
  local plugin = GEM_SUB_GetPlugin(event.sorttype);
  
  if(plugin == nil)
  then
    GEM_ChatWarning("GEM_SUB_RecoverSubscribers : Cannot find selected sorting plugin ("..event.sorttype..") !");
    return false;
  end
  
  if(plugin.Recover == nil)
  then
    GEM_ChatWarning("GEM_SUB_RecoverSubscribers : Cannot find 'Recover' function for selected sorting plugin ("..event.sorttype..") !");
    return false;
  end
  
  -- Rebuild 'players' tab
  for i,tab in event.titulars
  do
    if(event.players[tab.name] == nil)
    then
      event.players[tab.name] = {};
      event.players[tab.name].update_time = i+1;
      event.players[tab.name].class = tab.class;
      event.players[tab.name].guild = GEM_NA_FORMAT;
      event.players[tab.name].level = tab.level;
      event.players[tab.name].comment = "";
      event.players[tab.name].forcesub = 0;
    end
  end
  for i,tab in event.substitutes
  do
    if(event.players[tab.name] == nil)
    then
      event.players[tab.name] = {};
      event.players[tab.name].update_time = event.titular_count + i + 1;
      event.players[tab.name].class = tab.class;
      event.players[tab.name].guild = GEM_NA_FORMAT;
      event.players[tab.name].level = tab.level;
      event.players[tab.name].comment = "";
      event.players[tab.name].forcesub = 0;
    end
  end
  for i,tab in event.replacements
  do
    if(event.players[tab.name] == nil)
    then
      event.players[tab.name] = {};
      event.players[tab.name].update_time = 1;
      event.players[tab.name].class = tab.class;
      event.players[tab.name].guild = GEM_NA_FORMAT;
      event.players[tab.name].level = tab.level;
      event.players[tab.name].comment = "";
      event.players[tab.name].forcesub = 1;
    end
  end

  -- Build classes limits
  local classes = {};
  for name,tab in event.classes do
    local max = tab.max;
    local min = tab.min;
    if(max == nil or max == -1)
    then
      max = 666;
    end
    if(min == nil or min == -1)
    then
      min = 0;
    end
    classes[name] = { min=min,max=max,count=0 };
  end

  plugin.Recover(event.players,classes,event.max_count);
  GEM_SUB_SortPlayers(ev_id);

  return true;
end

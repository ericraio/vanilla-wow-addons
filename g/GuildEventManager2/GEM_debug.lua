--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Debug module
]]

GEM_DEBUG_GLOBAL = 1; -- Blanc
GEM_DEBUG_PROTOCOL = 2; -- Jaune foncé
GEM_DEBUG_CHANNEL = 3; -- Bleu clair
GEM_DEBUG_EVENTS = 4; -- Vert foncé
GEM_DEBUG_COMMANDS = 5; -- Orange clair
GEM_DEBUG_SUBSCRIBERS = 6; -- Violet foncé
GEM_DEBUG_GUI = 7; -- Cyan clair
GEM_DEBUG_QUEUES = 8; -- Cyan foncé
GEM_DEBUG_WARNING = 9; -- Rouge

local _GEM_DBG_ColorCodes = {{1,1,1},{0.5,0.5,0},{0,0,1.0},{0,0.4,0},{1,0.5,0},{1,0,1},{0,0.6,0.9},{0,0.4,0.5},{1,0.1,0.1}};

function GEM_DBG_SetDebugMode(mode,wipedata)
  if(mode == 1 or mode == 2)
  then
    GEM_Events.debug = mode;
    GEMMainFrameTab5:Show();
    if(mode == 2 and wipedata)
    then
      GEM_Events.debug_log = {};
    end
  else
    if(GEMDebugFrame:IsVisible())
    then
      GEMMain_SelectTab(1);
    end
    GEMMainFrameTab5:Hide();
    GEM_Events.debug = 0;
  end
end

function GEM_ChatDebug(dbg_type,str)
  if(GEM_Events.debug and GEM_Events.debug >= 1)
  then
    local tab = date("*t",tim);
    local hour_str = tab.hour;
    local min_str = tab.min;
    local sec_str = tab.sec;
    
    if(string.len(hour_str) == 1)
    then
      hour_str = "0"..hour_str;
    end
    if(string.len(min_str) == 1)
    then
      min_str = "0"..min_str;
    end
    if(string.len(sec_str) == 1)
    then
      sec_str = "0"..sec_str;
    end
    local time_str = "["..hour_str..":"..min_str..":"..sec_str.."] ";
    GEMDebug_Log:AddMessage(time_str..str,_GEM_DBG_ColorCodes[dbg_type][1],_GEM_DBG_ColorCodes[dbg_type][2],_GEM_DBG_ColorCodes[dbg_type][3]);
    if(GEM_Events.debug == 2)
    then
      table.insert(GEM_Events.debug_log,time_str..str);
    end
  end
end

function GEM_ChatWarning(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage("GuildEventManager WARNING (please inform Kiki) : "..str, 1.0, 0, 0);
  end
  GEM_ChatDebug(GEM_DEBUG_WARNING,str);
end

function GEM_ChatPrint(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage("GuildEventManager : "..str, 0.9, 0.8, 0.10);
  end
end

function GEM_ChatMsg(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage(str, 0.9, 0.7, 0.10);
  end
end


--[[
 Simulate JOIN channel :
   -> /script arg9="kikichan2";arg2="Lenor";event="CHAT_MSG_CHANNEL_JOIN";GEM_OnEvent();
 Simulate LEAVE channel :
   -> /script arg9="kikichan2";arg2="Lenor";event="CHAT_MSG_CHANNEL_LEAVE";GEM_OnEvent();


]]


--[[
  Healers Assist by Kiki of European Cho'gall (Alliance)
    Debug module
]]

HA_DEBUG_GLOBAL = 1; -- Blanc
HA_DEBUG_PROTOCOL = 2; -- Jaune foncé
HA_DEBUG_CHANNEL = 3; -- Bleu clair
HA_DEBUG_SPELLS = 4; -- Vert foncé
HA_DEBUG_MEMBERS = 5; -- Orange clair
HA_DEBUG_RAIDERS = 6; -- Violet foncé
HA_DEBUG_GUI = 7; -- Cyan clair
HA_DEBUG_ACTIONS = 8; -- Cyan foncé
HA_DEBUG_WARNING = 9; -- Rouge

local _HA_DBG_ColorCodes = {{1,1,1},{0.5,0.5,0},{0,0,1.0},{0,0.4,0},{1,0.5,0},{1,0,1},{0,0.6,0.9},{0,0.4,0.5},{1,0.1,0.1}};

function HA_DBG_SetDebugMode(mode)
  if(mode == 1)
  then
    HA_Config.Debug = true;
    HADebugFrame:Show();
  else
    HADebugFrame:Hide();
    HA_Config.Debug = nil;
  end
end

function HA_ChatDebug(dbg_type,str)
  if(HA_Config and HA_Config.Debug)
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
    local time_str = "["..hour_str..":"..min_str..":"..sec_str.."-"..HA_CurrentTime.."] ";
    HADebug_Log:AddMessage(time_str..str,_HA_DBG_ColorCodes[dbg_type][1],_HA_DBG_ColorCodes[dbg_type][2],_HA_DBG_ColorCodes[dbg_type][3]);
  end
end

function HA_ChatWarning(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage("HealersAssist WARNING (please inform Kiki) : "..str, 1.0, 0, 0);
  end
  HA_ChatDebug(HA_DEBUG_WARNING,str);
end

function HA_ChatPrint(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage("HealersAssist : "..str, 1.0, 0.7, 0.15);
  end
end

function HA_ChatMsg(str)
  if(DEFAULT_CHAT_FRAME)
  then
    DEFAULT_CHAT_FRAME:AddMessage(str, 0.9, 0.7, 0.10);
  end
end

--[[
 TEMP DEBUG PART
]]
function _HA_DBG_Test1()
  HA_ChatPrint("Revert : ");
  for id,tab in HA_RaidersByID
  do
    HA_ChatPrint(" "..id.." : "..tab.name);
  end
  HA_ChatPrint("Done");
end


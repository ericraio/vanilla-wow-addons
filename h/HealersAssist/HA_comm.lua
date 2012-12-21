--[[
  Healers Assist by Kiki of European Cho'gall (Alliance)
    Communication module (parse/send)

]]


--------------- Shared variables ---------------
HA_CMD_SPELL_START = "01";
HA_CMD_SPELL_COMPLETE = "02";
HA_CMD_SPELL_FAILED = "03";
HA_CMD_SPELL_DELAYED = "04";
HA_CMD_SPELL_COOLDOWN = "05";
HA_CMD_COOLDOWN_UPDATE = "06";
HA_CMD_SPELL_OVERTIME = "07";
HA_CMD_SPELL_INSTANT = "08";
HA_CMD_SPELL_REQUEST = "09";
HA_CMD_SPELL_REQUEST_DENIED = "10";
HA_CMD_REGEN_MODE = "11";
HA_CMD_GOT_POWER_INFUSION = "12";
HA_CMD_SPELL_STOP = "13";
HA_CMD_ANNOUNCE = "14";
HA_CMD_PLUGIN_CMD = "15";
HA_CMD_VERSION = "16";
HA_CMD_SPELL_HOT_TICK = "17";

HA_ADDON_PREFIX = "HealAss";

--------------- Local variables ---------------

local HA_COM_VERSION = "7";

local _HA_TOKEN = '\30';
local _HA_TOKEN_EMPTY = '\28';
local _HA_PARSE_PATTERN = "([^".._HA_TOKEN.."]+)";
local _HAComm_Dispatch = {};


--------------- Internal functions ---------------

local function _HA_COM_SendMessage(cmd,...)
  local msg = "<HA"..HA_COM_VERSION..">"..cmd;

  for i=1, arg.n
  do
    local val = arg[i];
    if(val == nil)
    then
      val = _HA_TOKEN_EMPTY;
    elseif(type(val) == "string")
    then
      if(val == "")
      then
        val = _HA_TOKEN_EMPTY;
      end
    elseif(type(val) == "boolean")
    then
      if(val) then val = 1; else val = 0; end;
    end;
    msg = msg.._HA_TOKEN..val;
  end
  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_SendMessage : Sending "..msg);
  SendAddonMessage(HA_ADDON_PREFIX,msg,"RAID");
  --SendAddonMessage(HA_ADDON_PREFIX,msg.._HA_TOKEN,"RAID");
end

--[[
 function HA_COM_ParseMessage
   Channel parsing function.
]]
function HA_COM_ParseMessage(from,message)
  if(from == HA_PlayerName) then return; end; -- Not interested by messages from me
  --HA_CheckPlayerJoined(from);
  local _,i,version,cmd = string.find(message,"^<HA([^>]+)>(%d+)");
  if(version == nil or cmd == nil) then return; end;

  -- Check version
  if(version ~= HA_COM_VERSION)
  then
    if(version > HA_COM_VERSION)
    then
      if(HA_OldVersion == false)
      then
        HA_ChatPrint(HA_TEXT_UPGRADE_NEEDED);
        HA_OldVersion = true;
      end
    else
      --HA_ChatDebug(HA_DEBUG_GLOBAL,from.." is using an old major version of HA.");
    end
    return;
  end

  local msg = strsub(message,i+1);

  if(_HAComm_Dispatch[cmd] == nil)
  then
    HA_ChatDebug(HA_DEBUG_PROTOCOL,"Unknown command : "..cmd.." from "..from.." : "..type(cmd));
    return;
  end

  local params = {};
  for w in string.gfind(msg,_HA_PARSE_PATTERN)
  do
      if(w == nil or w == _HA_TOKEN_EMPTY)
      then
        table.insert(params,"");
      else
        table.insert(params,w);
      end
  end
  HA_ChatDebug(HA_DEBUG_PROTOCOL,"HA_COM_ParseMessage : Dispatching command "..cmd.." from "..from.." : "..message);
  _HAComm_Dispatch[cmd](from,params);
end


--------------- Process functions ---------------

--[[
  Process SpellStart :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING) -- Can be empty string
   Params[3] = CastTime (INT)
   Params[4] = Estimated (INT)
   Params[5] = WillCrit (BOOL)
   Params[6] = Rank (INT) -- Can be empty
]]
local function _HA_COM_Process_CmdSpellStart(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];
  local castTime = tonumber(params[3],10);
  local estimated = tonumber(params[4],10);
  local willcrit = tonumber(params[5],10);
  local spellRank = tonumber(params[6],10);
  
  if(willcrit)
  then
    if(willcrit == 1) then willcrit = true; else willcrit = false; end;
  end
  if(spellRank == nil)
  then
    spellRank = 0;
  end
  
  if(spellCode == nil or targetName == nil or castTime == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellStart : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(targetName).." - "..tostring(castTime)..")");
    return;
  end
  if(estimated == nil)
  then
    estimated = 0;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellStart : From="..from.." Spell="..spellCode.." Target="..targetName.." CastTime="..castTime.." Estimated="..tostring(estimated));
  HA_GUI_Process_SpellStart(from,spellCode,targetName,castTime,estimated,willcrit,spellRank);
end

--[[
  Process SpellStop :
]]
local function _HA_COM_Process_CmdSpellStop(from,params)
  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellStop : From="..from);
  HA_GUI_Process_SpellStop(from);
end

--[[
  Process SpellComplete :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING)
   Params[3] = Value (INT)
   Params[4] = Crit (BOOL)
]]
local function _HA_COM_Process_CmdSpellComplete(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];
  local value = tonumber(params[3],10);
  local crit = tonumber(params[4],10);

  if(crit)
  then
    if(crit == 1) then crit = true; else crit = false; end;
  end

  if(spellCode == nil or targetName == nil or value == nil or crit == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellComplete : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(targetName).." - "..tostring(value).." - "..tostring(crit)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellComplete : From="..from.." Spell="..spellCode.." Target="..targetName.." Value="..value.." Crit="..tostring(crit));
  HA_GUI_Process_SpellHit(from,spellCode,targetName,value,crit);
end

--[[
  Process SpellFailed :
   Params[1] = SpellCode (INT)
   Params[2] = IReason (INT)
   Params[3] = Reason (STRING)
]]
local function _HA_COM_Process_CmdSpellFailed(from,params)
  local spellCode = tonumber(params[1],10);
  local ireason = tonumber(params[2],10);
  local reason = params[3];
  
  if(spellCode == nil or ireason == nil or reason == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellFailed : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(ireason).." - "..tostring(reason)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellFailed : From="..from.." Spell="..spellCode.." IReason="..ireason.." Reason="..reason);
  HA_GUI_Process_SpellFailed(from,spellCode,ireason,reason);
end

--[[
  Process SpellDelayed :
   Params[1] = Value (INT) -- Delayed value in msec
]]
local function _HA_COM_Process_CmdSpellDelayed(from,params)
  local value = tonumber(params[1],10);
  
  if(value == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellDelayed : From="..from.." : VALUES ARE NIL ("..tostring(value)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellDelayed : From="..from.." Delay="..value);
  HA_GUI_Process_SpellDelayed(from,value);
end

--[[
  Process SpellCooldown :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING) -- Can be empty string
]]
local function _HA_COM_Process_CmdSpellCooldown(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];

  if(spellCode == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellCooldown : From="..from.." : VALUES ARE NIL ("..tostring(spellCode)..")");
    return;
  end
  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellCooldown : From="..from.." To="..targetName);
  HA_GUI_Process_SpellCooldown(from,spellCode,targetName);
end

--[[
  Process SpellCooldown :
   Params[1] = SpellCode (INT)
   Params[2] = Cooldown (INT) -- Cooldown in sec
]]
local function _HA_COM_Process_CmdCooldownUpdate(from,params)
  local spellCode = tonumber(params[1],10);
  local cooldown = tonumber(params[2],10);
  
  if(spellCode == nil or cooldown == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdCooldownUpdate : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(cooldown)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdCooldownUpdate : From="..from.." SpellCode="..spellCode.." Cooldown="..cooldown);
  HA_GUI_Process_CooldownUpdate(from,spellCode,cooldown);
end

--[[
  Process SpellOvertime :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING) -- Can be empty string
   Params[3] = Duration (INT)
   Params[4] = Estimated (INT)
   Params[5] = Rank (INT) -- Can be empty
]]
local function _HA_COM_Process_CmdSpellOvertime(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];
  local duration = tonumber(params[3],10);
  local estimated = tonumber(params[4],10);
  local spellRank = tonumber(params[5],10);
  
  if(spellRank == nil)
  then
    spellRank = 0;
  end
  
  if(spellCode == nil or duration == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellOvertime : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(duration)..")");
    return;
  end
  if(estimated == nil)
  then
    estimated = 0;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellOvertime : From="..from.." Spell="..spellCode.." Target="..targetName.." Duration="..duration.." Estimated="..tostring(estimated));
  HA_GUI_Process_SpellOvertime(from,spellCode,targetName,duration,estimated,spellRank);
end

--[[
  Process SpellInstant :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING) -- Can be empty string
   Params[3] = Rank (INT) -- Can be empty
]]
local function _HA_COM_Process_CmdSpellInstant(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];
  local spellRank = tonumber(params[3],10);
  
  if(spellRank == nil)
  then
    spellRank = 0;
  end
  
  if(spellCode == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellInstant : From="..from.." : VALUES ARE NIL ("..tostring(spellcode)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellInstant : From="..from.." Spell="..spellCode.." Target="..targetName);
  HA_GUI_Process_SpellInstant(from,spellCode,targetName,spellRank);
end

--[[
  Process SpellRequest :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING)
]]
local function _HA_COM_Process_CmdSpellRequest(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];
  
  if(spellCode == nil or targetName == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellRequest : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(targetName)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellRequest : From="..from.." Spell="..spellCode.." To="..targetName);
  if(targetName == HA_PlayerName) -- A request for me ?
  then
    HA_GUI_Process_SpellRequest(from,spellCode);
  end
end

--[[
  Process SpellRequestDenied :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING)
   Params[3] = ReasonCode (INT)
]]
local function _HA_COM_Process_CmdSpellRequestDenied(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];
  local reasonCode = tonumber(params[3],10);
  
  if(spellCode == nil or targetName == nil or reasonCode == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellRequestDenied : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(targetName).." - "..tostring(reasonCode)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellRequestDenied : From="..from.." Spell="..spellCode.." To="..targetName);
  if(targetName == HA_PlayerName) -- A request for me ?
  then
    HA_GUI_Process_SpellRequestDenied(from,spellCode,reasonCode);
  end
end

--[[
  Process RegenMode :
   Params[1] = IsInRegen (BOOL)
]]
local function _HA_COM_Process_CmdRegenMode(from,params)
  local isinregen = tonumber(params[1],10);
  
  if(isinregen)
  then
    if(isinregen == 1) then isinregen = true; else isinregen = false; end;
  else
    HA_ChatWarning("_HA_COM_Process_CmdRegenMode : From="..from.." : VALUES ARE NIL ("..tostring(isinregen)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdRegenMode : From="..from.." IsInRegen="..tostring(isinregen));
  HA_GUI_Process_RegenMode(from,isinregen);
end

--[[
  Process GotPowerInfusion :
]]
local function _HA_COM_Process_CmdGotPowerInfusion(from)
  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdGotPowerInfusion : From="..from);
  HA_GUI_Process_GotPowerInfusion(from);
end

--[[
  Process Announce :
   Params[1] = Message (STRING)
]]
local function _HA_COM_Process_CmdAnnounce(from,params)
  local msg = params[1];

  if(msg == nil)
  then  
    HA_ChatWarning("_HA_COM_Process_CmdAnnounce : From="..from.." : VALUES ARE NIL ("..tostring(msg)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdAnnounce : From="..from.." Message="..msg);
  HA_GUI_Process_Announce(from,msg);
end

--[[
  Process PluginCmd :
   Params[1] = PluginName (STRING)
   Params[...] = Plugin params
]]
local function _HA_COM_Process_CmdPluginCmd(from,params)
  local name = params[1];

  if(name == nil)
  then  
    HA_ChatWarning("_HA_COM_Process_CmdPluginCmd : From="..from.." : VALUES ARE NIL ("..tostring(name)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdPluginCmd : From="..from.." PluginName="..name);
  -- Call plugins
  for _,pl in HA_ActivePlugins
  do
    if(pl.Name == name and pl.OnPluginMessage)
    then
      pl.OnPluginMessage(from,params);
    end
  end
end

--[[
  Process Version :
   Params[1] = Version (STRING)
]]
local function _HA_COM_Process_CmdVersion(from,params)
  local version = params[1];

  if(version == nil)
  then  
    HA_ChatWarning("_HA_COM_Process_CmdVersion : From="..from.." : VALUES ARE NIL ("..tostring(version)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdVersion : From="..from.." Version="..version);
  HA_GUI_Process_Version(from,version);
end

--[[
  Process SpellHotTick :
   Params[1] = SpellCode (INT)
   Params[2] = TargetName (STRING)
   Params[3] = Value (INT)
]]
local function _HA_COM_Process_CmdSpellHotTick(from,params)
  local spellCode = tonumber(params[1],10);
  local targetName = params[2];
  local value = tonumber(params[3],10);
  
  if(spellCode == nil or targetName == nil or value == nil)
  then
    HA_ChatWarning("_HA_COM_Process_CmdSpellHotTick : From="..from.." : VALUES ARE NIL ("..tostring(spellCode).." - "..tostring(targetName).." - "..tostring(value)..")");
    return;
  end

  HA_ChatDebug(HA_DEBUG_PROTOCOL,"_HA_COM_Process_CmdSpellHotTick : From="..from.." Spell="..spellCode.." Target="..targetName.." Value="..value);
  HA_GUI_Process_SpellHotTick(from,spellCode,targetName,value);
end


--------------- GUI Exported functions ---------------

--[[ - GUI ENTRY POINT
 function HA_COM_SpellStart :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Target of the heal
   - CastTime   : Int    -- Casttime of the spell
   - Estimated  : Int    -- Estimated spell value
   - WillCrit   : Bool   -- If you are sure the spell will crit (Estimated is crit value)
   - SpellRank  : Int    -- Rank of the spell (can be nil)
]]
function HA_COM_SpellStart(SpellCode,TargetName,CastTime,Estimated,WillCrit,SpellRank)
  if(SpellCode)
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_START,SpellCode,TargetName,CastTime,Estimated,WillCrit,SpellRank);
  end
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellStop :
]]
function HA_COM_SpellStop()
  _HA_COM_SendMessage(HA_CMD_SPELL_STOP);
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellComplete :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Target of the heal
   - Value      : Int    -- Healed value
   - Crit       : Bool   -- Heal has crit
]]
function HA_COM_SpellComplete(SpellCode,TargetName,Value,Crit)
  if(SpellCode)
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_COMPLETE,SpellCode,TargetName,Value,Crit);
  end
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellFailed :
   - SpellCode : Int    -- International code of the spell
   - IReason   : Int -- Reason code of failure
   - Reason    : String -- Reason text of failure (nil if IReason ~= 0)
]]
function HA_COM_SpellFailed(SpellCode,IReason,Reason)
  if(SpellCode)
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_FAILED,SpellCode,IReason,Reason);
  end
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellDelayed :
   - Value : Int -- Delayed value in msec
]]
function HA_COM_SpellDelayed(Value)
  _HA_COM_SendMessage(HA_CMD_SPELL_DELAYED,Value);
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellCooldown :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Target of the spell
]]
function HA_COM_SpellCooldown(SpellCode,TargetName)
  _HA_COM_SendMessage(HA_CMD_SPELL_COOLDOWN,SpellCode,TargetName);
end

--[[ - GUI ENTRY POINT
 function HA_COM_CooldownUpdate :
   - SpellCode : Int    -- International code of the spell
   - Cooldown  : Int -- number of sec before it's up (0 = up)
]]
function HA_COM_CooldownUpdate(SpellCode,Cooldown)
  _HA_COM_SendMessage(HA_CMD_COOLDOWN_UPDATE,SpellCode,Cooldown);
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellOvertime :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Target of the heal
   - Duration   : Int    -- Duration of the spell
   - Estimated  : Int    -- Estimated spell value
   - SpellRank  : Int    -- Rank of the spell (can be nil)
]]
function HA_COM_SpellOvertime(SpellCode,TargetName,Duration,Estimated,SpellRank)
  if(SpellCode)
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_OVERTIME,SpellCode,TargetName,Duration,Estimated,SpellRank);
  end
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellInstant :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Target of the heal
   - SpellRank  : Int    -- Rank of the spell (can be nil)
]]
function HA_COM_SpellInstant(SpellCode,TargetName,SpellRank)
  if(SpellCode)
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_INSTANT,SpellCode,TargetName,SpellRank);
  end
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellRequest :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Request spell to
]]
function HA_COM_SpellRequest(SpellCode,TargetName)
  if(SpellCode and TargetName and TargetName ~= "")
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_REQUEST,SpellCode,TargetName);
  end
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellRequestDenied :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Request spell from
   - ReasonCode : Int    -- Reason
]]
function HA_COM_SpellRequestDenied(SpellCode,TargetName,ReasonCode)
  if(SpellCode and TargetName and TargetName ~= "")
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_REQUEST_DENIED,SpellCode,TargetName,ReasonCode);
  end
end

--[[ - GUI ENTRY POINT
 function HA_COM_RegenMode :
   - IsInRegen  : Bool -- If I go in regen mode
]]
function HA_COM_RegenMode(IsInRegen)
  _HA_COM_SendMessage(HA_CMD_REGEN_MODE,IsInRegen);
end

--[[ - GUI ENTRY POINT
 function HA_COM_GotPowerInfusion :
]]
function HA_COM_GotPowerInfusion()
  _HA_COM_SendMessage(HA_CMD_GOT_POWER_INFUSION);
end

--[[ - GUI ENTRY POINT
 function HA_COM_Announce :
   - Message : String -- Message to show
]]
function HA_COM_Announce(Message)
  _HA_COM_SendMessage(HA_CMD_ANNOUNCE,Message);
end

--[[ - GUI ENTRY POINT
 function HA_COM_PluginCommand :
   - PluginName : String -- Message to show
   - ...        : Any    -- Plugins command params
]]
function HA_COM_PluginCommand(PluginName,...)
  _HA_COM_SendMessage(HA_CMD_PLUGIN_CMD,PluginName,unpack(arg));
end

--[[ - GUI ENTRY POINT
 function HA_COM_SendVersion :
]]
function HA_COM_SendVersion()
  _HA_COM_SendMessage(HA_CMD_VERSION,HA_VERSION);
end

--[[ - GUI ENTRY POINT
 function HA_COM_SpellHotTick :
   - SpellCode  : Int    -- International code of the spell
   - TargetName : String -- Target of the heal
   - Value      : Int    -- Healed value
]]
function HA_COM_SpellHotTick(SpellCode,TargetName,Value)
  if(SpellCode)
  then
    _HA_COM_SendMessage(HA_CMD_SPELL_HOT_TICK,SpellCode,TargetName,Value);
  end
end


--------------- Init dispatch table ---------------
_HAComm_Dispatch[HA_CMD_SPELL_START] = _HA_COM_Process_CmdSpellStart;
_HAComm_Dispatch[HA_CMD_SPELL_STOP] = _HA_COM_Process_CmdSpellStop;
_HAComm_Dispatch[HA_CMD_SPELL_COMPLETE] = _HA_COM_Process_CmdSpellComplete;
_HAComm_Dispatch[HA_CMD_SPELL_FAILED] = _HA_COM_Process_CmdSpellFailed;
_HAComm_Dispatch[HA_CMD_SPELL_DELAYED] = _HA_COM_Process_CmdSpellDelayed;
_HAComm_Dispatch[HA_CMD_SPELL_COOLDOWN] = _HA_COM_Process_CmdSpellCooldown;
_HAComm_Dispatch[HA_CMD_COOLDOWN_UPDATE] = _HA_COM_Process_CmdCooldownUpdate;
_HAComm_Dispatch[HA_CMD_SPELL_OVERTIME] = _HA_COM_Process_CmdSpellOvertime;
_HAComm_Dispatch[HA_CMD_SPELL_INSTANT] = _HA_COM_Process_CmdSpellInstant;
_HAComm_Dispatch[HA_CMD_SPELL_REQUEST] = _HA_COM_Process_CmdSpellRequest;
_HAComm_Dispatch[HA_CMD_SPELL_REQUEST_DENIED] = _HA_COM_Process_CmdSpellRequestDenied;
_HAComm_Dispatch[HA_CMD_REGEN_MODE] = _HA_COM_Process_CmdRegenMode;
_HAComm_Dispatch[HA_CMD_GOT_POWER_INFUSION] = _HA_COM_Process_CmdGotPowerInfusion;
_HAComm_Dispatch[HA_CMD_ANNOUNCE] = _HA_COM_Process_CmdAnnounce;
_HAComm_Dispatch[HA_CMD_PLUGIN_CMD] = _HA_COM_Process_CmdPluginCmd;
_HAComm_Dispatch[HA_CMD_VERSION] = _HA_COM_Process_CmdVersion;
_HAComm_Dispatch[HA_CMD_SPELL_HOT_TICK] = _HA_COM_Process_CmdSpellHotTick;

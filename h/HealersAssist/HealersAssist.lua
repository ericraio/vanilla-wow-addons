--[[
  Healers Assist by Kiki - European Cho'gall

  TODO :
  
    GESTION/CONFIG :
     - Handle Talent/Armor bonus in _HA_GetDuration function
     - Handle pets (with config option to show them in emergency)
     - For the buf request, add an option to refuse requests when in combat (for some bufs, maybe configurable per buf with 3 options, deny:not-in-combat:always)

    GUI :
     - Possibility to configure color used in the HA_GUI_Process_Announce function
     - Possibility to only show hots I can cast in emergency list
     - Emergency list : Show in another color, people out of my healing range (CheckInteractDistance() is 30yards max, maybe show in yellow)
     - Show an estimated time of remaining regen time for a healer in Resting mode (dans le champ de casting) (new field EndRegenTime to compute in HA_Healers struct)
     - Show remaining effect time of a cooldown spell casted on a healer

    SORTING :
     [Quote from Freddy] Some feature ideas I heard about the emergency list:
      - Mark players which are in your party (different color of HP bar?) + priority option
      - Option to limit filter the estimated heal value that is added to the HP by casting time (e.g. only add heal which should have finished in <1.5sek)
      - Make an option which allowes it to set a fixed value of HP difference to show up the player in the list (not percentage)
      - Add something which put's the tanks at a higher priorty (class specific settings for casting tiem filter?) 

  TODO WARRIOR PLUGIN :
   - Show for "YOU", current casts on yourself, with casting times (sorted by casting time)
     -> Prints a warning to yourself (use healing potion !! for example) if no spell is coming, and you have the agro, or gonna die soon ^^

  BUGS :
   - Unit IDs changing during a SpellRequest (raid changes while the SpellRequest popup is shown -> possible wrong unitid) (NOT SURE IF THIS IS POSSIBLE)
    -> In _HA_SetRaiderVariables function (and GA callback)
      -> Callback a function in GUI to update all internal variables using IDs (like SpellRequest)
   - RaiderDeath not always correct (maybe check with hp==0 ?)
   - Hunter that Feign death will be counted as "dead/rezzed"
   - Druid shifting back to humain with full mana, will show empty mana (need to grab mp/mpmax after a shift)
   - Without GroupAnalyse, if I'm in Group Mode (not raid) all members are set as GroupLeader
   - Heal on an external player or NPC (out of raid), will trigger overheal status after spell complete -> Well... nevermind right now

 ChangeLog :
   - 2006/09/12 : 1.1
     - Fixed incorrect healing debuff detection of Nefarius encounter
   - 2006/08/31 :
     - Fixed Item Bonuses not correct with latest BonusScanner addon installed (Scan not done, if no other addon ask BS for a scan)
   - 2006/08/30 :
     - Fixed minor xml error (minimap button not highlighting correctly (thanks Kagar)
     - Fixed initialization issue, if not using GroupAnalyse addon
     
  [Full ChangeLog in readme.txt file]
]]



--------------- Shared Constantes ---------------
HA_MODE_NONE = 0;
HA_MODE_SOLO = 1
HA_MODE_GROUP = 2
HA_MODE_RAID = 3;

--------------- Shared variables ---------------
HA_VERSION = "1.1";
HA_PlayerName = nil;
HA_CurrentTarget = nil;
HA_LibramItem = nil;
HA_Healers = {};
HA_Raiders = {};
HA_RaidersByID = {};
HA_CurrentGroupMode = HA_MODE_NONE;
HA_MyselfHealer = nil;
HA_MyselfRaider = nil;
HA_CurrentZone = nil;
HA_SpellCooldowns = {};
HA_AFK_Mode = false;
HA_ClassesID = {
  ["DRUID"] = 1;
  ["HUNTER"] = 2;
  ["MAGE"] = 3;
  ["PRIEST"] = 4;
  ["ROGUE"] = 5;
  ["WARLOCK"] = 6;
  ["WARRIOR"] = 7;
  ["PALADIN"] = 8;
  ["SHAMAN"] = 8;
};

--------------- Local Constantes ---------------
local HA_COOLDOWN_SPELLS_UPDATE_DELAY = 60; -- Every 60sec
local HA_VERSION_SEND_DELAY = 60; -- Every 60sec
local HA_MAX_HEAL_UPDATES = 10; -- Keep max 10 incoming heal per raider
local _HA_LastTimeEmergency = 0;

--------------- Local variables ---------------
local HA_NeedInit = true;
local HA_CastingSpell = nil;
local HA_HookActionName = nil;
local HA_HookActionRank = 0;
local HA_StopCommandSent = true;
local HA_StopCommandLastTime = 0;
local HA_CastingInstantSpell = nil;
local HA_CastingInstantRank = 0;
local HA_SpellTargetName = nil;
local HA_PotentialSpellTargetName = nil;
local HA_LastRegrowthRank = 0;
local HA_MaxRanks = {};
local _HA_UseBonusScannerAddon = false;
local _HA_BonusScanScheduled = false;
local _HA_LastSendVersion = 0;


--------------- Internal functions ---------------

function HA_SetNewLock(printmsg)
  if(HA_Config.Lock)
  then
    HealersAssistMainFrame:EnableMouse("false");
    if(printmsg)
    then
      HA_ChatPrint(HA_CHAT_LOCK_ON);
    end
  else
    HealersAssistMainFrame:EnableMouse("true");
    if(printmsg)
    then
      HA_ChatPrint(HA_CHAT_LOCK_OFF);
    end
  end
end

local function _HA_GetMaxSpellRanks()
  local maxRanks = {};
  local index = 1;
  while(1) do
    local spellName, spellRank = GetSpellName(index, BOOKTYPE_SPELL)
    if(not spellName) then
       break;
    elseif(HA_Spells[spellName]) then
       local _,_,ranknum = string.find(spellRank,HA_RANK.." (%d+)");
     ranknum = tonumber(ranknum,10);
     if(not maxRanks[spellName]) then
          maxRanks[spellName] = ranknum;
       elseif(ranknum > maxRanks[spellName]) then
          maxRanks[spellName] = ranknum;
       end
    end
  index = index + 1
  end
  return maxRanks;
end

local function _HA_SetRaiderAsHealer(raider)
  if(not raider.ishealer)
  then
    raider.ishealer = true;
    -- Call plugins
    for n,pl in HA_ActivePlugins
    do
      if(pl.OnEvent)
      then
        pl.OnEvent(HA_EVENT_HEALER_JOINED,{raider.name});
      end
    end
  end
end

local function _HA_UpdateOtherVariables(raider)
  raider.percent = floor(raider.hp / raider.hpmax * 100);
  raider.mppercent = floor(raider.mp / raider.mpmax * 100);

  local healer = HA_Healers[raider.name];
  if(healer and (raider.class == "PRIEST" or raider.class == "DRUID" or raider.class == "PALADIN" or raider.class == "SHAMAN")) -- This is a healer
  then
    _HA_SetRaiderAsHealer(raider);
    healer.id = raider.id;
    healer.Raider = raider;
  end
end

local function _HA_SetMinimalRaiderVariables(raider,raidid,rank,subgrp)
  raider.id = raidid;
  HA_RaidersByID[raidid] = raider;
  raider.rank = rank;
  raider.subgrp = subgrp;
end

local function _HA_SetFullRaiderVariables(raider,raidid,rank,subgrp)
  _HA_SetMinimalRaiderVariables(raider,raidid,rank,subgrp);
  _,raider.class = UnitClass(raider.id);
  raider.classid = HA_ClassesID[raider.class];
  raider.isdead = UnitIsDeadOrGhost(raider.id);
  raider.oldisdead = raider.isdead;
  raider.hp_real = UnitHealth(raider.id);
  raider.hpmax = UnitHealthMax(raider.id);
  raider.ischarmed = UnitIsCharmed(raider.id);
  raider.mp = UnitMana(raider.id);
  raider.mpmax = UnitManaMax(raider.id);
  raider.isconnected = UnitIsConnected(raider.id);

  raider.hp = raider.hp_real;
  raider.hp_estim = raider.hp_real;
  raider.ignore_next_wound = 0;
  raider.life_updates = {};
  raider.heal_updates = {};
  
  _HA_UpdateOtherVariables(raider);
end

local function _HA_CreateRaider(name)
  local infos = {};
  infos.name = name;
  infos.count = 0;
  infos.estimates = {};
  infos.estimate_ratio = 1;
  infos.overtime = {};
  return infos;
end

local function _HA_AddHealer(pl_name)
  if(HA_Healers[pl_name] == nil)
  then
    local infos = {};
    local raider = HA_Raiders[pl_name];
    infos.Cooldown = {};
    infos.Name = pl_name;
    infos.State = HA_STATE_NOTHING;
    infos.OverHealPercent = 0;
    infos.EstimateRatio = 1;
    infos.Estimate = 0;
    infos.StartTime = 0;
    infos.Raider = raider;

    if(raider)
    then
      local class = raider.class;
      infos.id = raider.id;
      if(class == "PRIEST" or class == "DRUID" or class == "PALADIN" or class == "SHAMAN")
      then
        HA_ChatDebug(HA_DEBUG_MEMBERS,"HA_CheckPlayerJoined : "..pl_name.." is in my Raiders list and is a Healer");
        _HA_SetRaiderAsHealer(raider);
      else
        HA_ChatDebug(HA_DEBUG_MEMBERS,"HA_CheckPlayerJoined : "..pl_name.." is in my Raiders list but is not a Healer");
      end
    else
      HA_ChatDebug(HA_DEBUG_MEMBERS,"HA_CheckPlayerJoined : "..pl_name.." is not in my Raiders list");
    end

    HA_Healers[pl_name] = infos;
    if(pl_name == HA_PlayerName)
    then
      HA_MyselfHealer = infos;
      HA_ChatDebug(HA_DEBUG_GLOBAL,"Setting MYSELF as HEALER : "..tostring(infos));
      HA_GUI_Process_Version(HA_PlayerName,HA_VERSION);
    end
  end
end

local function _HA_AddRaider(name,tab)
  HA_Raiders[name] = tab;
  HA_RaidersByID[tab.id] = tab;
  HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_AddRaider : Adding raider "..name.." with id="..tab.id);
  if(name == HA_PlayerName) -- Myself
  then
    HA_MyselfRaider = tab;
    HA_ChatDebug(HA_DEBUG_GLOBAL,"Setting MYSELF as RAIDER : "..tostring(tab));
  end
  -- Call plugins
  for _,pl in HA_ActivePlugins
  do
    if(pl.OnEvent)
    then
      pl.OnEvent(HA_EVENT_RAIDER_JOINED,{name});
    end
  end
  if(tab.class == "PRIEST" or tab.class == "DRUID" or tab.class == "PALADIN" or tab.class == "SHAMAN")
  then
    _HA_AddHealer(name);
  end
end

local function _HA_RemoveHealer(pl_name)
  if(HA_Healers[pl_name])
  then
    -- Call plugins
    for n,pl in HA_ActivePlugins
    do
      if(pl.OnEvent)
      then
        pl.OnEvent(HA_EVENT_HEALER_LEFT,{pl_name});
      end
    end
    HA_Healers[pl_name] = nil;
  end
end

local function _HA_RemoveRaider(name)
  local raider = HA_Raiders[name];
  if(raider)
  then
    HA_RaidersByID[raider.id] = nil;
  end
  HA_Raiders[name] = nil;
  HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_RemoveRaider : Removed raider "..name);
  -- Call plugins
  for _,pl in HA_ActivePlugins
  do
    if(pl.OnEvent)
    then
      pl.OnEvent(HA_EVENT_RAIDER_LEFT,{name});
    end
  end
  _HA_RemoveHealer(name); -- Check for healer removal
end

local function _HA_AnalyseGroupRaidMembers()
  local newmode = HA_MODE_NONE;
  local new_raiders = {};
  HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_AnalyseGroupRaidMembers : Start Analyse");

  if(GetNumRaidMembers() ~= 0) -- In a raid
  then
    if(HA_CurrentGroupMode ~= HA_MODE_RAID) -- But was not
    then
      HealersAssistMainFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED");
    end
    HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_AnalyseGroupRaidMembers : I'm in a RAID");
    newmode = HA_MODE_RAID;
    local count = GetNumRaidMembers();
    for i = 1, count do
      local name,rank,subgrp = GetRaidRosterInfo(i);
      if(name)
      then
        new_raiders[name] = _HA_CreateRaider(name);
        _HA_SetMinimalRaiderVariables(new_raiders[name],"raid"..i,rank,subgrp);
      end
    end
  else
    if(HA_CurrentGroupMode == HA_MODE_RAID) -- Was in a RAID
    then
      HealersAssistMainFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
    end
    new_raiders[HA_PlayerName] = _HA_CreateRaider(HA_PlayerName);
    _HA_SetMinimalRaiderVariables(new_raiders[HA_PlayerName],"player",2,1);
    if(GetNumPartyMembers() ~= 0) -- In a group
    then
      HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_AnalyseGroupRaidMembers : I'm in a GROUP");
      newmode = HA_MODE_GROUP;
      for i = 1,4 do
        local name = UnitName("party"..i);
        if(name and (name ~= UNKNOWNOBJECT) and (name ~= UKNOWNBEING))
        then
          new_raiders[name] = _HA_CreateRaider(name);
          _HA_SetMinimalRaiderVariables(new_raiders[name],"party"..i,2,1);
        end
      end
    else
      HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_AnalyseGroupRaidMembers : I'm not grouped");
      newmode = HA_MODE_SOLO;
    end
  end

  -- Update list of Raiders
  for n,tab in HA_Raiders -- Remove old raiders
  do
    if(new_raiders[n] == nil) -- No longer in the raid
    then
      _HA_RemoveRaider(n);
    end
  end

  HA_RaidersByID = {};
  for n,tab in new_raiders -- Add new raiders
  do
    local raider = HA_Raiders[n];
    if(raider == nil) -- New member
    then
      _HA_SetFullRaiderVariables(tab,tab.id,tab.rank,tab.subgrp);
      _HA_AddRaider(n,tab);
    else -- Was already here -> Update variables
      _HA_SetMinimalRaiderVariables(raider,tab.id,tab.rank,tab.subgrp);
      _HA_UpdateOtherVariables(raider);
    end
  end

  if(HA_Config.Auto and newmode ~= HA_CurrentGroupMode)
  then
    if(newmode == HA_MODE_SOLO)
    then
      HealersAssistMainFrame:Hide();
    else
      HealersAssistMainFrame:Show();
    end
  end
  HA_CurrentGroupMode = newmode;
  
  HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_AnalyseGroupRaidMembers : Analyse Completed");
end

local function _HA_GroupAnalyseCallback(event,param)
  local infos;
  if(event == GA_EVENT_INFOS_CHANGED)
  then
    HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_GroupAnalyseCallback : Start members data update");
    HA_RaidersByID = {};
    debugprofilestart();
    for name,member in GA_Members
    do
      infos = HA_Raiders[name];
      if(infos)
      then
        infos.id = member.unitid;
        HA_RaidersByID[member.unitid] = infos;
        infos.rank = member.rank;
        infos.subgrp = member.subgrp;
        infos.ischarmed = member.ischarmed;
        infos.isconnected = member.isconnected;
        _HA_UpdateOtherVariables(infos);
      end
    end
    HA_PROFILE_AnalyseRaidersRoutine = debugprofilestop();
    HA_ChatDebug(HA_DEBUG_RAIDERS,"_HA_GroupAnalyseCallback : Update Completed");
  elseif(event == GA_EVENT_MEMBER_JOINED)
  then
    infos = _HA_CreateRaider(param);
    local member = GA_Members[param];
    _HA_SetFullRaiderVariables(infos,member.unitid,member.rank,member.subgrp);
    _HA_AddRaider(param,infos);
  elseif(event == GA_EVENT_MEMBER_LEFT)
  then
    _HA_RemoveRaider(param);
  elseif(event == GA_EVENT_GROUP_MODE_CHANGED)
  then
    HA_ChatDebug(HA_DEBUG_GLOBAL,"_HA_GroupAnalyseCallback : Group mode changed to "..param);
    if(HA_Config.Auto)
    then
      if(param == GA_MODE_SOLO)
      then
        HealersAssistMainFrame:Hide();
      else
        HealersAssistMainFrame:Show();
      end
    end
    HA_CurrentGroupMode = param;
  end
end

local function _HA_CooldownUpdateScheduleRoutine()
  local serv_time = GetTime();
  local tim = time();
  -- Update my cooldown status
  if(HA_MyselfHealer)
  then
    for spell,infos in HA_SpellCooldowns
    do
      -- Update my cooldown
      local startTime,cd_value = GetSpellCooldown(infos.id,"spell");
      local Cooldown = 0;
      if(startTime ~= 0 and cd_value > 30) -- (Prevent global cooldown and silence spells to interfere)
      then
        Cooldown = floor((startTime+cd_value) - serv_time);
      end
  
      -- Check for update send
      if(not HA_AFK_Mode and ((Cooldown == 0 and infos.last ~= 0) or -- Was in cooldown, but not anymore
         (Cooldown ~= 0 and infos.last == 0) or -- Was up, but in cooldown now
         (tim > (infos.lastSend+HA_COOLDOWN_SPELLS_UPDATE_DELAY)))) -- Delay expired
      then
        HA_GUI_Process_CooldownUpdate(HA_PlayerName,infos.ispell,Cooldown);
        HA_COM_CooldownUpdate(infos.ispell,Cooldown);
        infos.lastSend = tim;
        infos.last = Cooldown;
      end
    end
    -- Check for HA version send
    if(not HA_AFK_Mode and (tim > (_HA_LastSendVersion+HA_VERSION_SEND_DELAY))) -- Delay expired
    then
      HA_ChatDebug(HA_DEBUG_GLOBAL,"Too long since last Version send");
      HA_COM_SendVersion();
      _HA_LastSendVersion = tim;
    end
  end

  -- Update other cooldown status
  for name,tab in HA_Healers
  do
    for spell,infos in tab.Cooldown
    do
      if(infos.Remain ~= 0) -- Player having a Cooldown spell
      then
        infos.Remain = infos.Remain - (serv_time - infos.Start);
        if(infos.Remain <= 0)
        then
          infos.Remain = 0;
        end
        infos.Start = serv_time;
      end
    end
  end
  
  -- Re schedule
  HASystem_Schedule(1,_HA_CooldownUpdateScheduleRoutine);
end

local function _HA_SetDefaultConfig(param,value)
  if(HA_Config[param] == nil)
  then
    HA_Config[param] = value;
  end
end

local function _HA_ScheduledInit()
  HA_InitializeCooldownSpells();
  HASystem_Schedule(1,_HA_CooldownUpdateScheduleRoutine); -- Special cooldown routine
  HASystem_Schedule(1,HA_OvertimeScheduleRoutine); -- Special overtime routine
  HASystem_Schedule(1,HA_StatusScheduleRoutine); -- Special status routine
end

local function HA_StartupInitVars()
  local playerName = UnitName("player");
  if((playerName) and (playerName ~= UNKNOWNOBJECT) and (playerName ~= UKNOWNBEING))
  then
    -- Initialize Toon specific stuff
    HA_PlayerName = playerName;
    HA_NeedInit = false;
    _HA_SetDefaultConfig("MinEmergencyPercent",90);
    _HA_SetDefaultConfig("KeepValue",3);
    _HA_SetDefaultConfig("ShowInstants",false);
    _HA_SetDefaultConfig("ShowHoT",false);
    _HA_SetDefaultConfig("ButtonPosition",190);
    _HA_SetDefaultConfig("EmergencyGroups",{ true,true,true,true,true,true,true,true });
    _HA_SetDefaultConfig("EmergencyClasses",{ true,true,true,true,true,true,true,true });
    _HA_SetDefaultConfig("HealersClasses",{ true,true,true,true,true,true,true,true });
    _HA_SetDefaultConfig("AllowSpellRequest",{});
    _HA_SetDefaultConfig("HealersLines",10);
    _HA_SetDefaultConfig("EmergLines",5);
    _HA_SetDefaultConfig("Scale",100);
    _HA_SetDefaultConfig("Alpha",100);
    _HA_SetDefaultConfig("BackdropAlpha",100);
    _HA_SetDefaultConfig("GUIRefresh",0.1);
    _HA_SetDefaultConfig("Plugins",{});
    _HA_SetDefaultConfig("PluginOrder",{});
    _HA_SetDefaultConfig("PluginAuto",{});
    _HA_SetDefaultConfig("UseEstimatedHealth",true);
    HA_CheckLoadPlugins();
    HA_SetNewLock(false);
    HASystem_Schedule(5,_HA_ScheduledInit);
    HA_MoveMinimapButton();
    -- Setup Default function
    if(CastParty_OnClickByUnit and type(CastParty_OnClickByUnit) == "function") -- CastParty
    then
      HA_CustomOnClickFunction = CastParty_OnClickByUnit;
    end
    if(WatchDog_OnClick and type(WatchDog_OnClick) == "function") -- WatchDog
    then
      HA_CustomOnClickFunction = WatchDog_OnClick;
    end
    if(JC_CatchKeyBinding and type(JC_CatchKeyBinding) == "function") -- JustClick
    then
      HA_CustomOnClickFunction = JC_CatchKeyBinding;
    end
  end
end

function HA_PlayerHasBuf(texture)
  for i=1,16
  do
    local t = UnitBuff("player",i);
    if(t == nil) then break; end;
    if(t == texture)
    then
      return true;
    end
  end
  return false;
end

local function HA_BuildRankString(ranknum)
  local rankstr = "";

  if(ranknum and ranknum > 1)
  then
    for i=1,ranknum do
      rankstr = rankstr.."I";
    end
  end

  return rankstr;
end

local function HA_Commands(command)
  local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
  if(not cmd) then cmd = command; end
  if(not cmd) then cmd = ""; end
  if(not param) then param = ""; end

  if((cmd == "") or (cmd == "help"))
  then
    local lock = "off";
    if(HA_Config.Lock) then lock = "on"; end
    local auto = "off";
    if(HA_Config.Auto) then auto = "on"; end
    HA_ChatPrint("Usage:");
    HA_ChatPrint("  |cffffffff/ha show|r - "..HA_CHAT_HELP_SHOW);
    HA_ChatPrint("  |cffffffff/ha lock (on|off)|r |cff2040ff["..lock.."]|r - "..HA_CHAT_HELP_LOCK);
    HA_ChatPrint("  |cffffffff/ha auto (on|off)|r |cff2040ff["..auto.."]|r - "..HA_CHAT_HELP_AUTO);
    HA_ChatPrint("  |cffffffff/ha versions |r - "..HA_CHAT_HELP_VERSIONS);
    HA_ChatPrint("  |cffffffff/ha msg <Msg to send>|r - "..HA_CHAT_HELP_MSG);
    HA_ChatPrint("  ---- DEBUG ----");
    HA_ChatPrint("  |cffffffff/ha debug (on|off)|r - "..HA_CHAT_HELP_DEBUG);
  elseif(cmd == "show")
  then
    HealersAssistMainFrame:Show();
  elseif(cmd == "lock")
  then
    if(param == "off")
    then
      HA_Config.Lock = nil;
    elseif(param == "on")
    then
      HA_Config.Lock = true;
    else
      HA_ChatPrint(HA_CHAT_CMD_PARAM_ERROR.."lock");
      return;
    end
    HA_SetNewLock(true);
  elseif(cmd == "auto")
  then
    if(param == "off")
    then
      HA_Config.Auto = nil;
    elseif(param == "on")
    then
      HA_Config.Auto = true;
    else
      HA_ChatPrint(HA_CHAT_CMD_PARAM_ERROR.."auto");
      return;
    end
  elseif(cmd == "debug")
  then
    if(param == "off")
    then
      HA_DBG_SetDebugMode(0);
    elseif(param == "on")
    then
      HA_DBG_SetDebugMode(1)
    else
      HA_ChatPrint(HA_CHAT_CMD_PARAM_ERROR.."debug");
      return;
    end
  elseif(cmd == "versions")
  then
    HA_ShowVersions();
  elseif(cmd == "msg" and param and param ~= "")
  then
    HA_GUI_Process_Announce(HA_PlayerName,param);
    HA_COM_Announce(param);
  else
    HA_ChatPrint(HA_CHAT_CMD_UNKNOWN);
  end
end

function CheckSpellTarget(FunctionHook)
  if(SpellIsTargeting())
  then
    HA_PotentialSpellTargetName = UnitName("mouseover");
    HA_ChatDebug(HA_DEBUG_ACTIONS,FunctionHook.." : PotentialTarget="..tostring(HA_PotentialSpellTargetName));
  elseif(UnitIsFriend("player","target"))
  then
    HA_SpellTargetName = UnitName("target");
    HA_ChatDebug(HA_DEBUG_ACTIONS,FunctionHook.." : Target="..tostring(HA_SpellTargetName));
  end
end

--------------- Hooked functions ---------------

function HealersAssist_SpellTargetUnit(unit)
  if(SpellIsTargeting() or not HA_SpellTargetName)
  then
    HA_SpellTargetName = UnitName(unit);
    HA_ChatDebug(HA_DEBUG_ACTIONS,"SpellTargetUnit : Target="..tostring(HA_SpellTargetName));
  end
  return HA_Old_SpellTargetUnit(unit);
end

HA_Old_SpellTargetUnit = SpellTargetUnit;
SpellTargetUnit = HealersAssist_SpellTargetUnit;

--

function HealersAssist_CastShapeshiftForm(index)
  local ret_val = HA_Old_CastShapeshiftForm(index);

  HA_ChatDebug(HA_DEBUG_ACTIONS,"CastShapeshiftForm : Index="..tostring(index));

  HA_CastingInstantSpell = nil;
  HA_CastingInstantRank = 0;
  return ret_val;
end

HA_Old_CastShapeshiftForm = CastShapeshiftForm;
CastShapeshiftForm = HealersAssist_CastShapeshiftForm;

--

function HealersAssist_UseAction(id, val, onSelf)
  HealersAssistTooltip:SetOwner(UIParent, "ANCHOR_NONE");
  HealersAssistTooltip:ClearLines();
  HealersAssistTooltip:SetAction(id);
  local spellName = tostring(HealersAssistTooltipTextLeft1:GetText());
  local rank = HealersAssistTooltipTextRight1:GetText();
  local rankstr = "";
  HealersAssistTooltip:Hide();

  local ret_val = HA_Old_UseAction(id,val,onSelf);

  if(rank and rank ~= "")
  then
    local _,_,ranknum = string.find(rank,HA_RANK.." (%d+)");
    rank = tonumber(ranknum,10);
  elseif(HA_MaxRanks[spellName])
  then
    rank = HA_MaxRanks[spellName];
  else
    rank = 1;
  end

  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnEvent)
    then
      pl.OnEvent(HA_EVENT_USE_ACTION,{id,val,onSelf,spellName,rank});
    end
  end

  if(HA_Spells[spellName])
  then
    CheckSpellTarget("UseAction");
    HA_ChatDebug(HA_DEBUG_ACTIONS,"UseAction : SpellName="..tostring(spellName).." Rank="..tostring(rank));
    HA_HookActionName = spellName;
    HA_HookActionRank = rank;
  end

  if(HA_InstantSpells[spellName])
  then
    CheckSpellTarget("UseAction");
    HA_CastingInstantSpell = spellName;
    HA_CastingInstantRank = rank;
  end
  
  -- If onSelf
  if(onSelf and onSelf == 1)
  then
    HA_SpellTargetName = HA_PlayerName;
    HA_ChatDebug(HA_DEBUG_ACTIONS,"UseAction on Self : Target="..tostring(HA_SpellTargetName));
  end
  return ret_val;
end

HA_Old_UseAction = UseAction;
UseAction = HealersAssist_UseAction;

--

function HealersAssist_CastSpell(id,spellBook)
  local ret_val = HealersAssist_Old_CastSpell(id,spellBook);

  local spellName,rank = GetSpellName(id,spellBook);

  if(rank and rank ~= "")
  then
    local _,_,ranknum = string.find(rank,HA_RANK.." (%d+)");
    rank = tonumber(ranknum,10);
  elseif(HA_MaxRanks[spellName])
  then
    rank = HA_MaxRanks[spellName];
  else
    rank = 1;
  end

  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnEvent)
    then
      pl.OnEvent(HA_EVENT_CAST_SPELL,{id,spellBook,spellName,rank});
    end
  end

  if(HA_Spells[spellName])
  then
    CheckSpellTarget("CastSpell");
    HA_ChatDebug(HA_DEBUG_ACTIONS,"CastSpell : SpellName="..tostring(spellName).." Rank="..tostring(rank));
    HA_HookActionName = spellName;
    HA_HookActionRank = rank;
  end

  if(HA_InstantSpells[spellName])
  then
    CheckSpellTarget("CastSpell");
    HA_CastingInstantSpell = spellName;
    HA_CastingInstantRank = rank;
  end
  return ret_val;
end

HealersAssist_Old_CastSpell = CastSpell;
CastSpell = HealersAssist_CastSpell;

function HealersAssist_CastSpellByName(spell, onSelf)
  local ret_val = HealersAssist_Old_CastSpellByName(spell, onSelf);

  if(spell)
  then
    local _,_,spellName,rank = string.find(spell,"(.+)%("..HA_RANK.." (%d+)%)");
    if(spellName == nil) -- Spell without rank
    then
      spellName = spell;
    end
    
    if(rank)
    then
      rank = tonumber(rank,10);
    elseif(HA_MaxRanks[spellName])
    then
      rank = HA_MaxRanks[spellName];
    else
      rank = 1;
    end

    -- Call plugins
    for n,pl in HA_ActivePlugins
    do
      if(pl.OnEvent)
      then
        pl.OnEvent(HA_EVENT_CAST_SPELL_BY_NAME,{spell,onSelf,spellName,rank});
      end
    end
  
    if(HA_Spells[spellName])
    then
      CheckSpellTarget("CastSpellByName");
      HA_ChatDebug(HA_DEBUG_ACTIONS,"CastSpellByName : SpellName="..tostring(spellName).." Rank="..tostring(rank));
      HA_HookActionName = spellName;
      HA_HookActionRank = rank;
    end

    if(HA_InstantSpells[spellName])
    then
      CheckSpellTarget("CastSpellByName");
      HA_CastingInstantSpell = spellName;
      HA_CastingInstantRank = rank;
    end
  end
  -- If onSelf
  if(onSelf and onSelf == 1)
  then
    HA_SpellTargetName = HA_PlayerName;
    HA_ChatDebug(HA_DEBUG_ACTIONS,"CastSpellByName on Self : Target="..tostring(HA_SpellTargetName));
  end
  return ret_val;
end

HealersAssist_Old_CastSpellByName = CastSpellByName;
CastSpellByName = HealersAssist_CastSpellByName;

--

local function _HA_GetISpell(SpellName)
  if(HA_Spells[SpellName])
  then
    return HA_Spells[SpellName].iname;
  elseif(HA_InstantSpells[SpellName])
  then
    return HA_InstantSpells[SpellName].iname;
  end
  return nil;
end

function HA_UnitHasBlessingOfLight(TargetName)
  local id = nil;
  if(TargetName)
  then
    if(HA_Raiders[TargetName] and HA_Raiders[TargetName].id)
    then
      id = HA_Raiders[TargetName].id;
    elseif(UnitName("target") == TargetName)
    then
      id = "target";
    end
  end
  if(id)
  then
    for i=1,16
    do
      local t = UnitBuff(id,i,1);
      if(t == nil) then break; end;
      if(t == HA_BLESSING_OF_LIGHT_TEXTURE or t == HA_GREATER_BLESSING_OF_LIGHT_TEXTURE)
      then
        return true;
      end
    end
  end
  return false;
end

local function _HA_GetEstimated(ISpell,IHookName,HookRank,TargetName,CastTime)
  local estimated = 0;
  local spiritadd = 0;
  local willcrit = false;

  if(IHookName and HookRank and ISpell == IHookName and HA_SpellRanks[ISpell] and HA_SpellRanks[ISpell][HookRank])
  then
    local infos = HA_SpellRanks[ISpell][HookRank];
    
    estimated = infos.base;

    -- Add Talent values
    local tinfos = HA_SpellTalents[ISpell];
    if(tinfos)
    then
      if(tinfos.ratios) -- Ratio
      then
      --[[ -- Old code (if talent bonus are applied one after another, and not all at once)
        for _,tid in tinfos.ratios
        do
          if(HA_Talents[tid] and HA_Talents[tid].rank) -- Talent found, and player's rank set
          then
            if(HA_Talents[tid].rankratio) -- Direct ratios
            then
              estimated = estimated * HA_Talents[tid].rankratio[HA_Talents[tid].rank];
            elseif(HA_Talents[tid].spiritratio) -- Spirit based ratios
            then
              spiritadd = HA_Talents[tid].spiritratio[HA_Talents[tid].rank] * UnitStat("player",5);
            end
          end
        end
        ]]
        local total_percent = 1.0;
        for _,tid in tinfos.ratios
        do
          if(HA_Talents[tid] and HA_Talents[tid].rank) -- Talent found, and player's rank set
          then
            if(HA_Talents[tid].rankratio) -- Direct ratios
            then
              total_percent = total_percent + HA_Talents[tid].rankratio[HA_Talents[tid].rank];
            elseif(HA_Talents[tid].spiritratio) -- Spirit based ratios
            then
              spiritadd = HA_Talents[tid].spiritratio[HA_Talents[tid].rank] * UnitStat("player",5);
            end
          end
        end
        estimated = estimated * total_percent;
      end
    end

    -- Add +heal values
    local itembonus;
    if(_HA_UseBonusScannerAddon)
    then
      itembonus = tonumber(BonusScanner.bonuses["HEAL"]);
    else
      itembonus = tonumber(HA_BonusScanner_bonuses["HEAL"]);
    end
    if(itembonus)
    then
      if(HA_LibramItem) -- Check for librams
      then
        if(ISpell == HA_SPELL_FLASH_OF_LIGHT and HA_LibramItem == 23201) -- Libram of Divinity
        then
          itembonus = itembonus + 53;
        elseif(ISpell == HA_SPELL_FLASH_OF_LIGHT and HA_LibramItem == 23006) -- Libram of Light
        then
          itembonus = itembonus + 83;
        elseif(ISpell == HA_SPELL_LESSER_HEALING_WAVE and HA_LibramItem == 23200) -- Totem of Sustaining
        then
          itembonus = itembonus + 53;
        elseif(ISpell == HA_SPELL_LESSER_HEALING_WAVE and HA_LibramItem == 22396) -- Totem of Life
        then
          itembonus = itembonus + 80;
        elseif(ISpell == HA_SPELL_REJUVENATION and HA_LibramItem == 22398) -- Idol of Rejuvenation
        then
          itembonus = itembonus + 62.5; -- Real value is 50, but this value will be 80% applied below, but the game does not apply the 80% rule on the idol
        end
      end
      estimated = estimated + itembonus * infos.castratio * infos.levelratio;
    end

    -- Add + Blessing of light value
    if(HA_SpellTalents[ISpell] and HA_SpellTalents[ISpell].blessing) -- Check for Blessing of light
    then
      if(HA_UnitHasBlessingOfLight(TargetName))
      then
        estimated = estimated + HA_SpellTalents[ISpell].blessing;
      end
    end
  
    -- Check for WillCrit
    local index = 0;
    local texture;
    while(GetPlayerBuffTexture(index))
    do
      texture = GetPlayerBuffTexture(index);
      applications = GetPlayerBuffApplications(index);
      if(texture == HA_DIVINE_FAVOR_TEXTURE)
      then
        willcrit = true;
      elseif(texture == HA_UNSTABLE_POWER_TEXTURE)
      then
        estimated = estimated + (70 * applications * infos.castratio * infos.levelratio);
      elseif(texture == HA_HEALING_OF_THE_AGES_TEXTURE)
      then
        estimated = estimated + (350 * infos.castratio * infos.levelratio);
      end
      index = index + 1;
    end

    if(willcrit)
    then
      estimated = estimated * 1.5;
    end 
  end
  
  return floor(estimated+spiritadd),willcrit;
end

local function _HA_GetDuration(ISpell)
  local duration = 0;

  if(HA_SpellOvertime[ISpell])
  then
    local infos = HA_SpellOvertime[ISpell];
    
    duration = infos.duration;

    -- Add Talent values for duration
    -- Add armor values for duration

  end
  
  return duration;
end

local function _HA_DoStop(resetSpell,msg)
  HA_ChatDebug(HA_DEBUG_ACTIONS,"HA_DoStop : Event="..msg.." CmdSend="..tostring(HA_StopCommandSent).." LastTime="..HA_StopCommandLastTime.." CurTime="..HA_CurrentTime);
  if(not HA_StopCommandSent and (HA_StopCommandLastTime+0.10 < HA_CurrentTime))
  then
    HA_GUI_Process_SpellStop(HA_PlayerName);
    HA_COM_SpellStop();
    HA_StopCommandSent = true;
    HA_StopCommandLastTime = HA_CurrentTime;
    if(resetSpell)
    then
      HA_CastingSpell = nil;
    end
  end
end

local function _HA_RegExpr_CallBack(event, Source, Target, SpellName, Value, Crit)
  -- Check for HoT Ticks
  if(event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" or
    event == "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" or
    event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS")
  then
    local ispell = HA_HotSpells[SpellName];
    if(ispell)
    then
      HA_ChatDebug(HA_DEBUG_SPELLS,"Callback HOT : Source="..tostring(Source).." Target="..tostring(Target).." Spell="..tostring(SpellName).." ("..ispell..") Value="..tostring(Value));
      HA_GUI_Process_SpellHotTick(Source,ispell,Target,Value);
      HA_COM_SpellHotTick(ispell,Target,Value);
    end
  
  else -- Ok, check for direct heal spells
    local spell = HA_Spells[SpellName];
    local instaspell = false;
    if(spell == nil) -- Not casted, check instant
    then
      spell = HA_InstantSpells[SpellName];
      instaspell = true;
    end
    if(spell)
    then
      if(event == "CHAT_MSG_SPELL_SELF_BUFF") -- Heal from self
      then
        local ispell = _HA_GetISpell(SpellName);
        if(not instaspell)
        then
          _HA_DoStop(true,"HIT");
        end
        HA_GUI_Process_SpellHit(Source,ispell,Target,Value,Crit);
        HA_COM_SpellComplete(ispell,Target,Value,Crit);
        -- Special HA_SPELL_REGROWTH case
        if(ispell == HA_SPELL_REGROWTH)
        then
          ispell = HA_SPELL_REGROWTH_HOT;
          local estimated = _HA_GetEstimated(ispell,ispell,HA_LastRegrowthRank,Target,0);
          local duration = _HA_GetDuration(ispell);
          if(duration ~= 0)
          then
            HA_GUI_Process_SpellOvertime(HA_PlayerName,ispell,Target,duration,estimated,HA_LastRegrowthRank);
            HA_COM_SpellOvertime(ispell,Target,duration,estimated,HA_LastRegrowthRank);
          end
        end
      else -- Heal from other
        if(not spell.group)
        then
          local ispell = _HA_GetISpell(SpellName);
          HA_GUI_Process_SpellHit(Source,ispell,Target,Value,Crit);
        end
      end
    end
  end
end

local function _HA_CheckRegenModeFromCast()
  local healer = HA_MyselfHealer;
  if(healer and healer.State == HA_STATE_RESTING)
  then
    HA_SetRegenMode(false);
  end
end

local function _HA_ScanScheduleRoutine()
  HA_ChatDebug(HA_DEBUG_GLOBAL,"_HA_ScanScheduleRoutine : Scanning bonuses");
  -- Check for Items bonuses
  if(not _HA_UseBonusScannerAddon)
  then
    HA_ChatDebug(HA_DEBUG_GLOBAL,"_HA_ScanScheduleRoutine : Not using BonusScanner addon - Scanning equipment !");
    HA_BonusScanner_ScanAll();
  end
  -- Check for Relic
  local libramlink = GetInventoryItemLink("player",18);
  if(libramlink)
  then
    for iItemId, iEnchantId, iPropertieId, sItemName in string.gfind(libramlink, "|c%x+|Hitem:(%d+):(%d+):(%d+):%d+|h%[(.-)%]|h|r")
    do
      HA_LibramItem = tonumber(iItemId);
    end
  else
    HA_LibramItem = nil;
  end
  -- Ok done
  _HA_BonusScanScheduled = false;
end

local function _HA_GetReasonCode(Reason)
  for i,n in HA_FailReasons
  do
    if(Reason == n)
    then
      return i,"";
    end
  end
  return 0,Reason;
end

local function _HA_CheckForBonusScan()
  if(not _HA_BonusScanScheduled)
  then
    _HA_BonusScanScheduled = true;
    HASystem_Schedule(2,_HA_ScanScheduleRoutine); -- Schedule scan in 2 sec
  end
end

local function _HA_RegisterEvents()
  HealersAssistMainFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
end

local function _HA_UnregisterEvents()
  HealersAssistMainFrame:UnregisterEvent("UNIT_INVENTORY_CHANGED");
end

local function _HA_CheckLifeUpdates(raider,new_hp)
  if(HA_Config.UseEstimatedHealth)
  then
    local estim = raider.hp_real;
    local updates = raider.life_updates;
  
    --[[if(updates[1] == nil and new_hp == estim)
    then
      HA_ChatDebug(HA_DEBUG_GLOBAL,"UNIT_HEALTH Diff OK : NewHP="..new_hp.." - Got no updates");
    end]]
  
    while(updates[1])
    do
      estim = estim + updates[1].value;
      table.remove(updates,1);
      if(estim == new_hp)
      then
        --HA_ChatDebug(HA_DEBUG_GLOBAL,"UNIT_HEALTH Diff Matching ("..table.getn(updates).." remaning updates) : NewHP="..new_hp);
        break;
      end
    end
    if(estim > raider.hpmax) then estim = raider.hpmax; end
    if(new_hp ~= estim)
    then
      --HA_ChatDebug(HA_DEBUG_GLOBAL,"UNIT_HEALTH Diff Error : NewHP="..new_hp.." Ignoring next Wound Event");
      raider.ignore_next_wound = HA_CurrentTime;
    end
  end
  raider.hp_estim = new_hp;
end

-- Currently don't handle "STOP because of failure" for casted request-spell
local function _HA_CheckSpellRequestSuccess(spell,instant)
  if(HA_SpellRequest and HA_SpellRequest.spell == spell)
  then
    HA_ChatDebug(HA_DEBUG_ACTIONS,"_HA_CheckSpellRequestSuccess : SpellRequest successfully casted (or stopped for casted ones) : "..tostring(spell).." : "..tostring(instant));
    HA_SpellRequest = nil;
    StaticPopup_Hide("HA_REQUEST_FOR_SPELL");
  end
end

local function _HA_CheckSpellRequestFailed(spell,reason)
  if(HA_SpellRequest and HA_SpellRequest.spell == spell)
  then
    HA_ChatDebug(HA_DEBUG_ACTIONS,"_HA_CheckSpellRequestFailed : SpellRequest failed for "..tostring(spell).." : "..tostring(reason));
    HA_SpellRequest.failure = reason;
  end
end

local function _HA_ProcessEvent_SpellCastStart()
  _HA_CheckRegenModeFromCast();
  if(HA_Spells[arg1])
  then
    _HA_DoStop(false,"START");
    HA_CastingSpell = arg1;
    HA_StopCommandSent = false; -- Set *waiting for stop* state
    HA_StopCommandLastTime = HA_CurrentTime; -- And reset time
    if(HA_SpellTargetName == nil)
    then
      HA_SpellTargetName = HA_PotentialSpellTargetName;
      HA_ChatDebug(HA_DEBUG_ACTIONS,"SPELLCAST_START : Target="..tostring(HA_SpellTargetName));
    end
    local casttime = tonumber(arg2,10)
    local target = HA_SpellTargetName;
    local ispell = _HA_GetISpell(HA_CastingSpell);
    local ihook = _HA_GetISpell(HA_HookActionName);
    local estimated,willcrit = _HA_GetEstimated(ispell,ihook,HA_HookActionRank,target,casttime);
    HA_GUI_Process_SpellStart(HA_PlayerName,ispell,target,casttime,estimated,willcrit,HA_HookActionRank);
    HA_COM_SpellStart(ispell,target,casttime,estimated,willcrit,HA_HookActionRank);
    -- Special HA_SPELL_REGROWTH case
    if(ispell == HA_SPELL_REGROWTH)
    then
      HA_LastRegrowthRank = HA_HookActionRank;
    end
  end
  HA_SpellTargetName = nil;
end

local function _HA_ProcessEvent_SpellCastStop()
  _HA_CheckRegenModeFromCast();
  if(HA_CastingInstantSpell) -- An instant spell ?
  then
    if(HA_SpellTargetName == nil)
    then
      HA_SpellTargetName = HA_PotentialSpellTargetName;
      HA_ChatDebug(HA_DEBUG_ACTIONS,"SPELLCAST_STOP (INSTANT SPELL) : Target="..tostring(HA_SpellTargetName));
    end
    local target = HA_SpellTargetName;
    local ispell = _HA_GetISpell(HA_CastingInstantSpell);
    if(HA_InstantSpells[HA_CastingInstantSpell].cooldown) -- A cooldown instant spell
    then
      HA_GUI_Process_SpellCooldown(HA_PlayerName,ispell,target);
      HA_COM_SpellCooldown(ispell,target);
    elseif(HA_InstantSpells[HA_CastingInstantSpell].nonheal) -- A non-heal spell
    then
      HA_GUI_Process_SpellInstant(HA_PlayerName,ispell,target,HA_CastingInstantRank);
      HA_COM_SpellInstant(ispell,target,HA_CastingInstantRank);
    else
      local estimated = _HA_GetEstimated(ispell,ispell,HA_CastingInstantRank,target,0);
      local duration = _HA_GetDuration(ispell);
      if(duration ~= 0)
      then
        HA_GUI_Process_SpellOvertime(HA_PlayerName,ispell,target,duration,estimated,HA_CastingInstantRank);
        HA_COM_SpellOvertime(ispell,target,duration,estimated,HA_CastingInstantRank);
      end
    end
    _HA_CheckSpellRequestSuccess(HA_CastingInstantSpell,true);
    HA_CastingInstantSpell = nil;
  elseif(HA_CastingSpell)
  then
    HA_ChatDebug(HA_DEBUG_ACTIONS,"SPELLCAST_STOP : Spell="..tostring(HA_CastingSpell));
    _HA_CheckSpellRequestSuccess(HA_CastingSpell,false);
    _HA_DoStop(false,"STOP");
  end
  HA_SpellTargetName = nil;
end


--------------- Shared functions ---------------

function HA_GetSpellIDFromName(spellName,spellRank)
  local i = 1;
  local name,rank = GetSpellName(i,BOOKTYPE_SPELL);
  local searched;
  
  if(spellRank) -- With rank
  then
    if(type(spellRank) == "number") -- Number
    then
      searched = spellName.."("..HA_RANK.." "..tostring(spellRank)..")";
    else -- String
      searched = spellName.."("..spellRank..")";
    end
  else -- No rank
    searched = spellName;
  end

  while(name)
  do
    local current;
    if(rank ~= "") -- With rank
    then
      current = name.."("..rank..")";
    else -- No rank
      current = name;
    end
    if(searched == current) -- Found
    then
      return i;
    end
    i = i + 1;
    name,rank = GetSpellName(i,BOOKTYPE_SPELL);
  end
  return 0;
end

local function HA_CheckForEmergencyListUpdate()
  -- Update Emergency every 30 msec
  if(HA_CurrentTime > (_HA_LastTimeEmergency+0.030))
  then
    HA_UpdateListEmergency();
    _HA_LastTimeEmergency = HA_CurrentTime;
  end
end

--------------- XML functions ---------------

function HA_OnEvent()
  if(event == "VARIABLES_LOADED")
  then
    if(HA_NeedInit)
    then
      HA_StartupInitVars();
    end
    return;
  elseif(event == "PLAYER_LOGIN")
  then
    HA_MaxRanks = _HA_GetMaxSpellRanks();
  elseif(event == "PLAYER_ENTERING_WORLD")
  then
    _HA_AnalyseGroupRaidMembers(); -- Force group analyse now
    HA_CurrentZone = GetRealZoneText(); -- Get it here too, because when you /reloadui the ZONE_CHANGED is not called - Thanks blizzard
    _HA_RegisterEvents();
    _HA_CheckForBonusScan();
    HA_CurrentTarget = nil
    if(HA_Config.Auto and HA_CurrentGroupMode ~= HA_MODE_SOLO)
    then
      HealersAssistMainFrame:Show();
    end
  elseif(event == "PLAYER_LEAVING_WORLD")
  then
    _HA_UnregisterEvents();
  elseif(event == "ZONE_CHANGED_NEW_AREA")
  then
    HA_CurrentZone = GetRealZoneText();
  end

  if(event == "UNIT_COMBAT")
  then
    if(HA_Config.UseEstimatedHealth)
    then
      local raider = HA_RaidersByID[arg1];
      if(raider and arg1 ~= "target")
      then
        if(arg2 == "WOUND")
        then
          if(HA_CurrentTime > (raider.ignore_next_wound+0.5))
          then
            --HA_ChatDebug(HA_DEBUG_GLOBAL,"UNIT_COMBAT '"..tostring(arg1).."' ("..tostring(raider.name)..") : DEGATS : "..tostring(arg4).." : UnitHealth="..UnitHealth(arg1).." hp="..raider.hp_real);
            raider.hp_estim = raider.hp_estim - arg4;
            if(raider.hp_estim < 0) then raider.hp_estim = 0; end
            tinsert(raider.life_updates,{ value=-arg4; stamp=HA_CurrentTime });
          --[[else
            HA_ChatDebug(HA_DEBUG_GLOBAL,"UNIT_COMBAT '"..tostring(arg1).."' ("..tostring(raider.name)..") : DEGATS : "..tostring(arg4).." : UnitHealth="..UnitHealth(arg1).." hp="..raider.hp_real.." - IGNORED");]]
          end
          raider.ignore_next_wound = 0;
        elseif(arg2 == "HEAL")
        then
          --HA_ChatDebug(HA_DEBUG_GLOBAL,"UNIT_COMBAT '"..tostring(arg1).."' ("..tostring(raider.name)..") : SOINS : "..tostring(arg4));
          tinsert(raider.heal_updates,{ value=arg4, oldhp=raider.hp_estim }); -- Store health before applying heal
          raider.hp_estim = raider.hp_estim + arg4;
          if(raider.hp_estim > raider.hpmax) then raider.hp_estim = raider.hpmax; end
          tinsert(raider.life_updates,{ value=arg4; stamp=HA_CurrentTime });
          if(getn(raider.heal_updates) > HA_MAX_HEAL_UPDATES) -- Remove a heal update, if too many in the array
          then
            table.remove(raider.heal_updates,1);
          end
        else
          --HA_ChatDebug(HA_DEBUG_GLOBAL,"UNIT_COMBAT '"..tostring(arg1).."' ("..tostring(raider.name)..") : "..tostring(arg2).." : "..tostring(arg4).." : "..tostring(arg3));
        end
        raider.hp = raider.hp_estim; -- Update HP value
      end
    end
    return;

  -- Health/Mana events
  elseif(event == "UNIT_HEALTH")
  then
    local raider = HA_RaidersByID[arg1];
    if(raider)
    then
      local new_hp = UnitHealth(arg1);
      if(arg1 ~= "target")
      then
        _HA_CheckLifeUpdates(raider,new_hp); -- Parse "updates" array, and update hp_estim to 'new_hp' value
      end
      raider.hp_real = new_hp;
      raider.hp = new_hp;
      raider.percent = floor(raider.hp / raider.hpmax * 100);
      HA_CheckForEmergencyListUpdate();
    end
    return;
  elseif(event == "UNIT_MAXHEALTH")
  then
    local raider = HA_RaidersByID[arg1];
    if(raider)
    then
      raider.hpmax = UnitHealthMax(arg1);
      raider.percent = floor(raider.hp / raider.hpmax * 100);
      HA_CheckForEmergencyListUpdate();
    end
    return;
  elseif(event == "UNIT_MANA")
  then
    local raider = HA_RaidersByID[arg1];
    if(raider and raider.ishealer)
    then
      raider.mp = UnitMana(arg1);
      raider.mppercent = floor(raider.mp / raider.mpmax * 100);
    end
    return;
  elseif(event == "UNIT_MAXMANA")
  then
    local raider = HA_RaidersByID[arg1];
    if(raider and raider.ishealer)
    then
      raider.mpmax = UnitManaMax(arg1);
      raider.mppercent = floor(raider.mp / raider.mpmax * 100);
    end
    return;
  elseif(event == "PLAYER_AURAS_CHANGED")
  then
    if(HA_MyselfHealer and not HA_RaiderInfused(HA_PlayerName) and HA_PlayerHasBuf(HA_POWER_INFUSION_TEXTURE))
    then
      HA_GUI_Process_GotPowerInfusion(HA_PlayerName);
      HA_COM_GotPowerInfusion();
    end
    return;
  end

  -- Group events
  if(event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE")
  then
    HA_ChatDebug(HA_DEBUG_RAIDERS,event.." : Party members changed. Analysing Raiders...");
    debugprofilestart();
    _HA_AnalyseGroupRaidMembers();
    HA_PROFILE_AnalyseRaidersRoutine = debugprofilestop();
    return;
  end
  
  -- Inventory events
  if(HA_NeedInit == false and event == "UNIT_INVENTORY_CHANGED")
  then
    _HA_CheckForBonusScan();
    return;
  end
  
  -- Mouse over event - Get target
  if(event == "UPDATE_MOUSEOVER_UNIT")
  then
    if(SpellIsTargeting() and UnitIsFriend("player", "mouseover"))
    then
      HA_PotentialSpellTargetName = UnitName("mouseover");
      HA_ChatDebug(HA_DEBUG_ACTIONS,"MouseOverUpdate : PotentialTarget="..tostring(HA_PotentialSpellTargetName));
    end 
    return;
  end

  -- Target changed  
  if(event == "PLAYER_TARGET_CHANGED" )
  then
    if(UnitExists("target") and UnitIsFriend("player","target")) -- Add target if don't exist
    then
      local name = UnitName("target");
      local raider = HA_Raiders[name];
      if(raider == nil) -- Don't exist, add it as subgrp 0
      then
        raider = _HA_CreateRaider(name);
        HA_Raiders[name] = raider;
        _HA_SetFullRaiderVariables(raider,"target",0,0);
        HA_UpdateListEmergency();
        -- Call plugins
        for n,pl in HA_ActivePlugins
        do
          if(pl.OnEvent)
          then
            pl.OnEvent(HA_EVENT_RAIDER_JOINED,{name});
          end
        end
      end
      HA_RaidersByID["target"] = raider;
      HA_CurrentTarget = name;
    else -- No valid target
      HA_RaidersByID["target"] = nil;
      HA_CurrentTarget = nil
    end
    HA_PotentialSpellTargetName = HA_CurrentTarget;
    return;
  end
  
  -- System events
  if(event == "CHAT_MSG_SYSTEM")
  then
    if(arg1 == MARKED_AFK or string.find(arg1,string.format(MARKED_AFK_MESSAGE,".*")))
    then
      HA_AFK_Mode = true;
    end
    if(arg1 == CLEARED_AFK)
    then
      HA_AFK_Mode = false;
    end
  elseif(event == "CHAT_MSG_ADDON" and (arg3 == "RAID" or arg3 == "PARTY") and arg1 == HA_ADDON_PREFIX)
  then
    HA_COM_ParseMessage(arg4,arg2);
  
  -- Spell Events
  elseif(event == "SPELLCAST_START")
  then
    _HA_ProcessEvent_SpellCastStart();
  elseif(event == "SPELLCAST_STOP")
  then
    _HA_ProcessEvent_SpellCastStop();
  elseif(event == "SPELLCAST_DELAYED")
  then
    if(HA_CastingSpell)
    then
      HA_GUI_Process_SpellDelayed(HA_PlayerName,arg1);
      HA_COM_SpellDelayed(arg1);
    end
  elseif(event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
  then
    local _,_,spell,reason = string.find(arg1,HA_PARSE_SPELL_FAILED_REASON);
    if(reason == nil) then reason = "???"; end;
    HA_ChatDebug(HA_DEBUG_ACTIONS,"SPELLCAST_FAILED : ParsedSpell="..tostring(spell).." Casting="..tostring(HA_CastingSpell).." Instant="..tostring(HA_CastingInstantSpell).." Reason="..reason);
    if(reason ~= SPELL_FAILED_SPELL_IN_PROGRESS and HA_CastingSpell and HA_CastingSpell == spell)
    then
      local ispell = _HA_GetISpell(HA_CastingSpell);
      local ireason,sreason = _HA_GetReasonCode(reason);
      _HA_DoStop(true,"FAILED");
      if(HA_StopCommandSent)
      then
        HA_GUI_Process_SpellFailed(HA_PlayerName,ispell,ireason,sreason);
        HA_COM_SpellFailed(ispell,ireason,sreason);
      end
    end
    _HA_CheckSpellRequestFailed(spell,reason);
    HA_CastingInstantSpell = nil;
  else
    HA_findEventMatch(event,_HA_RegExpr_CallBack); -- Check remaing events
  end
end

--------------- Exported functions ---------------

--[[
  Function HA_QuerySpell
   - SpellName  : String - Spell to request.
   - PlayerName : String - Player to request spell to.
  Sends a request for spell to this player.
  Returns true is spell was found, ready, and queried. False otherwise.
]]
function HA_QuerySpell(SpellName,PlayerName)
  local healer = HA_Healers[PlayerName];
  if(healer)
  then
    local spell = healer.Cooldown[SpellName];
    if(spell and spell.Remain == 0)
    then
      HA_COM_SpellRequest(spell.ispell,PlayerName);
      return true;
    else
      if(spell == nil)
      then
        HA_ChatPrint("HA_QuerySpell Failed : "..SpellName.." is not in "..PlayerName.."'s list of spells");
      else
        HA_ChatPrint("HA_QuerySpell Failed : "..SpellName.." is not ready ("..spell.Remain.." sec remaining)");
      end
    end
  else
    HA_ChatPrint("HA_QuerySpell Failed : "..PlayerName.." is not in my group/raid");
  end
  return false;
end

--[[
  Function HA_ShowVersions
  Prints HA's version for all Healers in your group/raid (if available).
]]
function HA_ShowVersions()
  for name,raider in HA_Raiders
  do
    if(raider.Version)
    then
      HA_ChatPrint(name.." : "..raider.Version);
    end
  end
end


--------------- Init functions ---------------

local function _HA_CheckSpellCooldown(spell,ispell,rank)
  local id = HA_GetSpellIDFromName(spell,rank);
  if(id == 0 and type(rank) == "number")
  then
    while(id == 0)
    do
      rank = rank - 1;
      if(rank == 0) -- Really don't have this spell
      then
        break;
      end
      id = HA_GetSpellIDFromName(spell,rank);
    end
  end
  if(id ~= 0)
  then
    HA_SpellCooldowns[spell] = { ispell=ispell; id=id; last=0; lastSend=0 };
    HA_ChatDebug(HA_DEBUG_SPELLS,"_HA_CheckSpellCooldown : Found spell "..spell.." rank "..tostring(rank).." as ID "..id);
    return true;
  end
  return false;
end

local function _HA_CheckTalents(talentids)
  local numTabs = GetNumTalentTabs();
  for t=1, numTabs
  do
    local numTalents = GetNumTalents(t);
    for i=1, numTalents
    do
      local name,icon,x,y,rank,max = GetTalentInfo(t,i);
      for _,tid in talentids
      do
        if(HA_Talents[tid] and HA_Talents[tid].texture == icon)
        then
          HA_Talents[tid].rank = rank;
          HA_ChatDebug(HA_DEBUG_SPELLS,"_HA_CheckTalents : Found talent "..name.." at rank "..rank.."/"..max);
        end
      end
    end
  end
end

function HA_InitializeCooldownSpells()
  -- Reset infos
  HA_SpellCooldowns = {};
  for id,tab in HA_Talents
  do
    tab.rank = nil;
  end

  -- Fill infos
  local _,clas = UnitClass("player");
  if(clas == "DRUID")
  then
    _HA_CheckSpellCooldown(HA_INNERVATE,HA_SPELL_INNERVATE);
    _HA_CheckSpellCooldown(HA_REBIRTH,HA_SPELL_REBIRTH,5);
    _HA_CheckTalents({HA_TALENT_GIF_OF_NATURE,HA_TALENT_IMPROVED_REJUVINATION});
  elseif(clas == "PALADIN")
  then
    _HA_CheckSpellCooldown(HA_DIVINE_INTERVENTION,HA_SPELL_DIVINE_INTERVENTION);
    _HA_CheckSpellCooldown(HA_BLESSING_OF_PROTECTION,HA_SPELL_BLESSING_OF_PROTECTION,3);
    _HA_CheckTalents({HA_TALENT_HEALING_LIGHT});
  elseif(clas == "SHAMAN")
  then
    _HA_CheckSpellCooldown(HA_REINCARNATION,HA_SPELL_REINCARNATION,HA_PASSIVE);
    _HA_CheckSpellCooldown(HA_MANA_TIDE,HA_SPELL_MANA_TIDE,2);
    _HA_CheckTalents({HA_TALENT_PURIFICATION});
  elseif(clas == "PRIEST")
  then
    _HA_CheckSpellCooldown(HA_LIGHTWELL,HA_SPELL_LIGHTWELL,3);
    _HA_CheckSpellCooldown(HA_POWER_INFUSION,HA_SPELL_POWER_INFUSION);
    _HA_CheckTalents({HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_IMPROVED_RENEW,HA_TALENT_SPIRITUAL_GUIDANCE});
  end
end

function HA_OnLoad()
  -- Print init message
  HA_ChatPrint("Version "..HA_VERSION.." "..HA_CHAT_MISC_LOADED);

  -- Register events
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("PLAYER_LOGIN");
  this:RegisterEvent("PLAYER_ENTERING_WORLD");
  this:RegisterEvent("PLAYER_LEAVING_WORLD");
  this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

  this:RegisterEvent("UNIT_COMBAT");
  this:RegisterEvent("UNIT_HEALTH");
  this:RegisterEvent("UNIT_MAXHEALTH");
  this:RegisterEvent("UNIT_MANA");
  this:RegisterEvent("UNIT_MAXMANA");
  this:RegisterEvent("PLAYER_AURAS_CHANGED");
  this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
  this:RegisterEvent("PLAYER_TARGET_CHANGED");

  this:RegisterEvent("CHAT_MSG_SYSTEM");
  this:RegisterEvent("CHAT_MSG_ADDON");

  this:RegisterEvent("SPELLCAST_START");
  this:RegisterEvent("SPELLCAST_STOP");
  this:RegisterEvent("SPELLCAST_DELAYED");
  this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
  this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
  this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
  this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
  this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
  this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"); -- Self hots
  this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS"); -- Group hots
  this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"); -- Raid hots

  HealersAssistTitle:SetText("HealersAssist v"..HA_VERSION);
  -- Initialize Slash commands
  SLASH_HA1 = "/ha";
  SlashCmdList["HA"] = function(msg)
    HA_Commands(msg);
  end
  
  tinsert(UISpecialFrames, "HAConfFrame");

  -- Initialiaze RegExprs
  HA_CreateRegexFromGlobals();

  -- Build ISpell structure
  HA_BuildLocalNames();

  -- Check for GroupAnalyse AddOn
  if(GA_RegisterForEvents ~= nil)
  then
    GA_RegisterForEvents(_HA_GroupAnalyseCallback);
  else
    this:RegisterEvent("PARTY_MEMBERS_CHANGED");
    this:RegisterEvent("RAID_ROSTER_UPDATE");
  end
  -- Check for BonusScanner AddOn
  if(BonusScanner and BONUSSCANNER_VERSION and BONUSSCANNER_VERSION >= "v1.0")
  then
    _HA_UseBonusScannerAddon = true;
  end
end


--/script HA_RequestSpell("Blessing of Protection")
--/script SendAddonMessage("HealAss","<HA7>09"..'\30'.."16"..'\30'.."Kiki","RAID")

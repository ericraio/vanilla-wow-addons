--[[
  Healers Assist by Kiki of European Cho'gall (Alliance)
    Process channel events

]]


--------------- Constantes ---------------

HA_STATE_CASTING = 1;
HA_STATE_HEALED = 2;
HA_STATE_STOP = 3;
HA_STATE_FAILED = 4;
HA_STATE_RESTING = 5;
HA_STATE_NOTHING = 6;
HA_STATE_DEAD = 7;

HA_GUI_MAX_HEALERS = 16;
HA_GUI_MAX_EMERG = 6;

local MAX_COOLDOWN_SPELLS = 2;
local MAX_OVERTIME_SPELLS=4;
local HA_SPELL_REQUEST_CODE_DENIED_DENIED = 1;
local HA_SPELL_REQUEST_CODE_DENIED_BLOCKED = 2;
local HA_SPELL_REQUEST_CODE_DENIED_BUSY = 3;
local HA_START_SLOT = 1;
local HA_END_SLOT   = 120;


--------------- Shared variables ---------------

HA_CustomOnClickFunction = nil;
HA_SpellRequest = nil;
HA_EmergList = {};

-- Profiling
HA_PROFILE_StatusRoutine = 0;
HA_PROFILE_OvertimeRoutine = 0;
HA_PROFILE_RaidersInfosRoutine = 0;
HA_PROFILE_GUIRoutine = 0;
HA_PROFILE_AnalyseRaidersRoutine = 0;


--------------- Local variables ---------------

local _HA_LastTimeGUI = 0;
local _HA_LastTimeHPMP = 0;
local _HA_CurrentTarget = nil;
local _HA_SortByName = false;
local _HA_CurrentWindowAlpha = 1.0;
local _HA_CurrentUIRefresh = 0.1;
local _HA_NewVersionNotice = false;

--------------- Internal functions ---------------

local function _HA_ResetRaiderState(raider)
  raider.count = 0;
  raider.estimates = {};
  raider.estimate_ratio = 1;
  raider.overtime = {};
end

local function _HA_ResetHealerEstimate(healer)
  local raider = HA_Raiders[healer.TargetName];
  if(raider)
  then
    if(raider.estimates[healer.Name] and raider.count > 0)
    then
      raider.count = raider.count - 1;
    end
    raider.estimates[healer.Name] = nil;
  end
end

local function _HA_ResetHealerState(healer,reset_warn)
  if(healer.State == HA_STATE_CASTING) -- If was casting, reset estimates
  then
    _HA_ResetHealerEstimate(healer);
    if(reset_warn and HA_Config.Debug) -- Should issue a warning
    then
      --HA_ChatWarning("_HA_ResetHealerState : Was in CASTING state on "..tostring(healer.TargetName).." with spell "..tostring(healer.SpellName)..", but should not !");
    end
  end
  if(healer.NextResetState)
  then
    healer.State = healer.NextResetState;
  else
    healer.State = HA_STATE_NOTHING;
  end
  healer.NextResetState = nil;
  healer.SpellCode = nil;
  healer.NonHeal = nil;
  healer.SpellName = nil;
  healer.SpellRank = nil;
  healer.ShortSpellName = nil;
  healer.TargetName = nil;
  healer.Estimate = 0;
  healer.CastTime = nil;
  healer.StartTime = 0;
  healer.EndTime = nil;
  healer.OverHealed = nil;
  healer.OverHealPercent = 0;
  healer.EstimateRatio = 1;
  healer.GroupHeal = nil;
end

local function _HA_CheckForResetStates()
  for name,tab in HA_Healers do
    if((tab.State == HA_STATE_HEALED) or (tab.State == HA_STATE_FAILED) or (tab.State == HA_STATE_STOP))
    then
      if(HA_CurrentTime > tab.EndTime)
      then
        _HA_ResetHealerState(tab,false);
      end
    end
  end
end

-- (Duration and Estimated) ~= 0 -> Healing spell (Show Heal/Duration in 'Casting column')
local function _HA_Process_SpellHitInstant(healer,raider,SpellCode,SpellName,Duration,Estimated,SpellRank)
  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnSpellHitInstant)
    then
      pl.OnSpellHitInstant(healer,raider,SpellCode,SpellName,Duration,Estimated,SpellRank);
    end
  end
  if((Duration ~= 0 and HA_Config.ShowHoT and SpellCode ~= HA_SPELL_REGROWTH_HOT)
    or (Duration == 0 and HA_Config.ShowInstants))
  then
    healer.State = HA_STATE_HEALED;
    healer.SpellCode = SpellCode;
    healer.NonHeal = HA_InstantSpells[SpellName].nonheal;
    healer.SpellName = SpellName;
    healer.SpellRank = SpellRank;
    healer.TargetName = raider.name;
    healer.ShortSpellName = HA_InstantSpells[SpellName].short;
    healer.EndTime = HA_CurrentTime + HA_Config.KeepValue;
    healer.Value = Estimated;
    healer.Duration = Duration;
    healer.Crit = false;
    healer.HoT = true;
    healer.GroupHeal = HA_InstantSpells[SpellName].group;
  end
end

local function _HA_EatHoT(healer,raider)
  local rejuvName = HA_GetLocalName(HA_SPELL_REJUVENATION);
  local regrowName = HA_GetLocalName(HA_SPELL_REGROWTH_HOT);

  local spell = raider.overtime[rejuvName];
  if(spell) -- Rejuv has priority over regrowth
  then
    HA_ChatDebug(HA_DEBUG_SPELLS,"_HA_EatHoT : Eat HoT "..rejuvName.." from "..healer.Name.." to "..raider.name);
    -- Call plugins
    for n,pl in HA_ActivePlugins
    do
      if(pl.OnEatHot)
      then
        pl.OnEatHot(HA_SPELL_REJUVENATION,raider,spell.From,spell.Start,spell.Duration);
      end
    end
    raider.overtime[rejuvName] = nil;
    return;
  end
  
  spell = raider.overtime[regrowName];
  if(spell)
  then
    HA_ChatDebug(HA_DEBUG_SPELLS,"_HA_EatHoT : Eat HoT "..regrowName.." from "..healer.Name.." to "..raider.name);
    -- Call plugins
    for n,pl in HA_ActivePlugins
    do
      if(pl.OnEatHot)
      then
        pl.OnEatHot(HA_SPELL_REGROWTH_HOT,raider,spell.From,spell.Start,spell.Duration);
      end
    end
    raider.overtime[regrowName] = nil;
    return;
  end
end

local function _HA_GetRaiderHealthBeforeHeal(raider,Value,healer)
  for i,tab in raider.heal_updates
  do
    if(tab.value == Value) -- Found it
    then
      local val = tab.oldhp;
      HA_ChatDebug(HA_DEBUG_SPELLS,"_HA_GetRaiderHealthBeforeHeal : Heal value ("..tostring(Value)..") found from "..tostring(healer.Name).." to "..raider.name.." : HP before="..tostring(val).." : Array size="..tostring(getn(raider.heal_updates)));
      table.remove(raider.heal_updates,i);
      return val;
    end
  end
  if(HA_Config.Debug and HA_Config.UseEstimatedHealth and getn(raider.heal_updates) == HA_MAX_HEAL_UPDATES) -- Estim health algo used, but value not found
  then
    HA_ChatWarning("_HA_GetRaiderHealthBeforeHeal : Heal value ("..tostring(Value)..") not found from "..tostring(healer.Name).." to "..raider.name.." : Array size="..tostring(getn(raider.heal_updates)));
  end
  return raider.hp;
end

local function _HA_Process_SpellHit(healer,SpellCode,SpellName,raider,Value,Crit,InstantSpell)
  -- Traitement
  if(raider)
  then
    if(Crit)
    then
      HA_ChatDebug(HA_DEBUG_SPELLS,"SpellHit CRIT from "..healer.Name.." to "..raider.name.." with "..SpellName.." for "..tostring(Value).." hp.");
    else
      HA_ChatDebug(HA_DEBUG_SPELLS,"SpellHit from "..healer.Name.." to "..raider.name.." with "..SpellName.." for "..tostring(Value).." hp.");
    end

    -- Check overhealed status
    local new_hp = _HA_GetRaiderHealthBeforeHeal(raider,Value,healer) + Value;
    local overhealed = 0;
    if(new_hp > raider.hpmax)
    then
      overhealed = new_hp - raider.hpmax;
      healer.OverHealed = overhealed / Value;
    end
    
    if(SpellCode == HA_SPELL_SWIFTMEND)
    then
      _HA_EatHoT(healer,raider);
    end

    -- Call plugins
    for n,pl in HA_ActivePlugins
    do
      if(pl.OnSpellHit)
      then
        pl.OnSpellHit(healer,raider,SpellCode,SpellName,Value,Crit,overhealed,InstantSpell);
      end
    end
  end
  
  if(healer.State == HA_STATE_STOP and healer.SpellCode == SpellCode) -- Added SpellCode check, to prevent an instant heal (like SwiftMend) to come before a casted spell
  then
    -- Reset data
    healer.State = HA_STATE_HEALED;
    healer.EndTime = HA_CurrentTime + HA_Config.KeepValue;
    healer.Value = Value;
    healer.Crit = Crit;
    healer.HoT = false;
  end
end

local function _HA_GetCurrentInfos()
  for name,infos in HA_Raiders
  do
    local healer = HA_Healers[name];
    local death_state_changed = false;
    infos.isconnected = UnitIsConnected(infos.id);
    if(infos.isconnected and (infos.subgrp ~= 0 or (HA_CurrentTarget and name == HA_CurrentTarget))) -- If a special "Target" raider, must be current target
    then
      -- Update infos
      infos.isdead = UnitIsDeadOrGhost(infos.id);
      infos.ischarmed = UnitIsCharmed(infos.id);
      -- Check Raider death state
      if(infos.isdead and not infos.oldisdead) -- was alive, is now dead
      then
        death_state_changed = true;
        _HA_ResetRaiderState(infos);
        -- Call plugins
        for n,pl in HA_ActivePlugins
        do
          if(pl.OnEvent)
          then
            pl.OnEvent(HA_EVENT_RAIDER_DIED,{name});
          end
        end
      elseif(infos.oldisdead and not infos.isdead) -- Was dead, got rez
      then
        death_state_changed = true;
        -- Call plugins
        for n,pl in HA_ActivePlugins
        do
          if(pl.OnEvent)
          then
            pl.OnEvent(HA_EVENT_RAIDER_RESURRECTED,{name});
          end
        end
      end
      infos.oldisdead = infos.isdead;
      -- Check Raider is a Healer
      if(infos.ishealer)
      then
        if(death_state_changed)
        then
          if(infos.isdead) -- Was alive, is now dead
          then
            _HA_ResetHealerState(healer,false);
            -- Call plugins
            for n,pl in HA_ActivePlugins
            do
              if(pl.OnEvent)
              then
                pl.OnEvent(HA_EVENT_HEALER_DIED,{name});
              end
            end
            HA_Healers[name].State = HA_STATE_DEAD;
          else -- Was dead, got resurrection
            _HA_ResetHealerState(healer,false);
            -- Call plugins
            for n,pl in HA_ActivePlugins
            do
              if(pl.OnEvent)
              then
                pl.OnEvent(HA_EVENT_HEALER_RESURRECTED,{name});
              end
            end
          end
        end
      end
    end
    -- Check for a possible Estimates reset of Raider
    if(not infos.isconnected) -- Offline, reset estimates
    then
      _HA_ResetRaiderState(infos);
      if(infos.ishealer and healer)
      then
        _HA_ResetHealerState(healer,false);
      end
    end
  end
  _HA_LastTimeHPMP = HA_CurrentTime;
end

local function _HA_WillOverHeal(healer)
  local raider = HA_Raiders[healer.TargetName];
  local my_end_time = healer.StartTime + healer.CastTime;

  if(raider and (raider.subgrp ~= 0 or healer.TargetName == HA_PlayerName))
  then
    local hp = raider.hp;
    -- Check all other healers, casting on the same target than me, if their spell will hit before me, forcing me to overheal
    for name,tab in HA_Healers
    do
      if(name ~= HA_PlayerName and tab.State == HA_STATE_CASTING and tab.TargetName == healer.TargetName and (tab.StartTime+tab.CastTime) < my_end_time)
      then
        hp = hp + tab.Estimate * tab.EstimateRatio * raider.estimate_ratio;
        if(hp >= raider.hpmax)
        then
          healer.OverHealPercent = 100; -- My spell will overheal at 100%
          return;
        end
      end
    end
    -- Nobody will force me to overheal at 100%, check how much my spell will overheal
    local my_estim = healer.Estimate * healer.EstimateRatio * raider.estimate_ratio;
    local my_spell = hp + my_estim;
    if(my_spell > raider.hpmax)
    then
      healer.OverHealPercent = (my_spell-raider.hpmax) / my_estim * 100;
      return;
    end
  end
  healer.OverHealPercent = 0;
end

local function HA_ScanDebufName(unitid,i)
  HealersAssistTooltip:SetOwner(UIParent, "ANCHOR_NONE");
  HealersAssistTooltip:ClearLines();
  HealersAssistTooltip:SetUnitDebuff(unitid,i);
  local debuffName = tostring(HealersAssistTooltipTextLeft1:GetText());
  HealersAssistTooltip:Hide();
  --HA_ChatPrint("HA_ScanDebufName : Unit="..unitid.." i="..i.." Name="..debuffName);
  return debuffName;
end

function HA_ShowDebuf()
  for i=1,16
  do
    local texture,count = UnitDebuff("target",i);
    if(texture == nil) then break; end;
    HA_ChatPrint("DebufName : i="..i.." Name="..HA_ScanDebufName("target",i));
    if(count == nil or count == 0) then count = 1; end;
    local debuf = HA_HealDebuffs[texture];
    if(debuf)
    then
      if(debuf.malus) -- No zone check
      then
        HA_ChatPrint("Found GLOBAL debuff ("..i..") with malus="..debuf.malus.." count="..count.." : "..texture);
        ret = ret * (1 - count * debuf.malus);
      elseif(debuf.zones)
      then
        local malus = debuf.zones[HA_CurrentZone];
        if(malus)
        then
          if(type(malus) == "table")
          then
          else
            HA_ChatPrint("Found Zone ("..HA_CurrentZone..")debuff ("..i..") with malus="..malus.." count="..count.." : "..texture);
            ret = ret * (1 - count * malus);
          end
        else
          HA_ChatPrint("Debuf texture found ("..texture.."), but malus for this zone : "..HA_CurrentZone);
        end
      end
    end
  end
end

function HA_UnitHasHealDebuf(unitid)
  local malus;
  local names;
  local ret = 1;
  local texture;
  local count;
  local debuf;

  for i=1,16
  do
    texture,count = UnitDebuff(unitid,i);
    if(texture == nil) then break; end;
    if(count == nil or count == 0) then count = 1; end;
    debuf = HA_HealDebuffs[texture];
    if(debuf)
    then
      if(debuf.malus) -- No zone check
      then
        ret = ret * (1 - count * debuf.malus);
      elseif(debuf.zones)
      then
        malus = debuf.zones[HA_CurrentZone];
        if(malus)
        then
          if(type(malus) == "table")
          then
            names =  malus.names;
            if(names)
            then
              malus = names[HA_ScanDebufName(unitid,i)];
              if(malus)
              then
                ret = ret * (1 - count * malus);
              end
            end
          else
            ret = ret * (1 - count * malus);
          end
        end
      end
    end
  end
  return ret;
end

function HA_StatusScheduleRoutine()
  debugprofilestart();
  -- First, check my overheal status
  local healer = HA_MyselfHealer;
  if(healer and healer.State == HA_STATE_CASTING)
  then
    _HA_WillOverHeal(healer);
  end
  
  -- Second, check estimates debufs (for mortal strike or other)
  for name,tab in HA_Raiders
  do
    tab.estimate_ratio = 1; -- Reset value
    if(tab.count ~= 0) -- Someone casting, time to check ratio
    then
      tab.estimate_ratio = HA_UnitHasHealDebuf(tab.id);
    end
  end
  
  -- Third, check estimates bufs
  for name,tab in HA_Healers
  do
    tab.EstimateRatio = 1; -- Reset value
    if(HA_RaiderInfused(name)) -- Got infused with power ?
    then
      tab.EstimateRatio = tab.EstimateRatio * 1.2;
    end
  end
  
  HA_PROFILE_StatusRoutine = debugprofilestop();
  -- Finally reschedule
  HASystem_Schedule(0.10,HA_StatusScheduleRoutine);
end

function HA_OvertimeScheduleRoutine()
  debugprofilestart();
  local serv_time = GetTime();

  -- Check overtime timers
  for name,tab in HA_Raiders
  do
    for spell,infos in tab.overtime
    do
      if(serv_time > (infos.Start + infos.Duration)) -- Expired
      then
        tab.overtime[spell] = nil;
      end
    end
  end
  
  -- Check IsRegen state
  local raider = HA_MyselfRaider;
  local healer = HA_MyselfHealer;
  if(healer and raider and healer.State == HA_STATE_RESTING)
  then
    if(raider.isdead or raider.mp == raider.mpmax) -- I'm dead, or my mana is full
    then
      HA_SetRegenMode(false);
    end
  end

  HA_PROFILE_OvertimeRoutine = debugprofilestop();
  -- Re schedule
  HASystem_Schedule(1,HA_OvertimeScheduleRoutine);
end

local function _HA_ConvertToMinSec(val)
  local minutes = floor(val / 60);
  local secondes = val - (minutes*60);
  return minutes.." min "..secondes.." sec";
end

-- Range code from decursive
local function _HA_FindActionSlot(texture,SpellName)
  local i = 0;
  for i = HA_START_SLOT, HA_END_SLOT
  do
    if(HasAction(i))
    then
      icon = GetActionTexture(i);
      if(icon == texture)
      then
        return i; -- Don't check the spell name
      end
    end
  end
  return 0;
end

local function _HA_UnitInRange(id,ISpell)
  if(not UnitIsVisible(id))
  then
    return false;
  end
  local SpellName = HA_GetLocalName(ISpell);
  local cdspell = HA_Cooldown[ISpell];
  if(SpellName and cdspell and not cdspell.norange)
  then
    if(cdspell.longrange)
    then
      local Range_Slot = _HA_FindActionSlot(cdspell.texture,SpellName);
      if(Range_Slot ~= 0)
      then
        local ret_val = false;
        TargetUnit(id);
        if(UnitIsUnit("target",id))
        then
          ret_val = (IsActionInRange(Range_Slot) == 1);
        end
        return ret_val;
      end
    else
      if(CheckInteractDistance(id,4))
      then
        return true;
      else
        return false;
      end
    end
  end
  return true;
end

function HA_GUI_GetHealersLines()
  local healerslines = HA_Config.HealersLines;
  if(HA_Config.HealersCollapsed) then healerslines = 1; end;
  
  return healerslines;
end

function HA_GUI_GetHealersHeight()
  return 16+2 + HA_GUI_GetHealersLines() * 16;
end

function HA_GUI_GetEmergencyHeight()
  local emerg_height = 0;
  if(HA_Config.EmergLines ~= 0)
  then
    emerg_height = 16+2 + HA_Config.EmergLines * 16;
  end
  return emerg_height;
end

function HA_GUI_GetMainHeight()
  return 25+10+10 + HA_GUI_GetHealersHeight() + HA_GUI_GetEmergencyHeight();
end

local _ha_first_show = true;
function HA_SetWidgetSizeAndPosition()
  local healerslines = HA_GUI_GetHealersLines();
  local healers_height = HA_GUI_GetHealersHeight();
  local emerg_height = HA_GUI_GetEmergencyHeight();
  local main_height = HA_GUI_GetMainHeight();
  local scale = HA_Config.Scale / 100;
  local back_alpha = HA_Config.BackdropAlpha / 100;
  _HA_CurrentWindowAlpha = HA_Config.Alpha / 100;
  _HA_CurrentUIRefresh = HA_Config.GUIRefresh / 1000;

  if scale < 0.3 then
    scale = 0.3;
  elseif scale > 1.5 then
    scale = 1.5;
  end

  -- Hide non-used Healers
  for i=healerslines+1,HA_GUI_MAX_HEALERS
  do
    getglobal("HAItem_"..i):Hide();
  end

  -- Hide non-used emerg
  for i=HA_Config.EmergLines+1,HA_GUI_MAX_EMERG
  do
    getglobal("HAItemEmergency_"..i):Hide();
  end
  
  if(HA_Config.EmergLines ~= 0)
  then
    -- Set emergency position
    HAEmergencyFrame:Show();
    HAEmergencyFrame:SetHeight(emerg_height);
    HAEmergencyFrame:SetPoint("TOPLEFT","HAItem_"..healerslines,"BOTTOMLEFT",0,-10);
  else
    HAEmergencyFrame:Hide();
  end

  -- Set main window anchor and height
  if(HA_Config.GrowUpwards)
  then
    local i = HealersAssistMainFrame:GetBottom();
    local j = HealersAssistMainFrame:GetLeft();
    if(i and j)
    then
      if(not _ha_first_show)
      then
        HealersAssistMainFrame:ClearAllPoints();
        HealersAssistMainFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",j,i+main_height);
      end
    end
  end
  HealersAssistMainFrame:SetHeight(main_height);
  HealersAssistMainFrame:SetScale(scale);
  HealersAssistMainFrame:SetAlpha(_HA_CurrentWindowAlpha);
  HealersAssistMainFrame:SetBackdropColor(1,1,1,back_alpha);
  HealersAssistMainFrame:SetBackdropBorderColor(1,1,1,back_alpha);
  if(healerslines >= 4)
  then
    HAItemScrollFrame:SetHeight(healerslines * 16);
  else
    HAItemScrollFrame:SetHeight(4 * 16);
  end

  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnEvent)
    then
      pl.OnEvent(HA_EVENT_WINDOW_SIZED,{healerslines,HA_Config.EmergLines,healers_height,emerg_height,main_height,scale,_HA_CurrentWindowAlpha,back_alpha});
    end
  end
  _ha_first_show = false;
end

--------------- Shared functions ---------------

function HA_IsPlayerCasting()
  local healer = HA_MyselfHealer;
  if(healer and healer.State == HA_STATE_CASTING)
  then
    return true;
  end;
  return false;
end

function HA_RaiderInfused(Name)
  local raider = HA_Raiders[Name];
  if(raider)
  then
    for ispell,tab in raider.overtime
    do
      if(ispell == HA_POWER_INFUSION)
      then
        return true;
      end
    end
  end
  return false;
end


--------------- XML functions ---------------

function HA_Collapse_Healers_Click(state)
  if(state)
  then
    HA_Config.HealersCollapsed = true;
  else
    HA_Config.HealersCollapsed = false;
  end
  HA_SetWidgetSizeAndPosition();
end

function HA_SelectEmergency(pos)
  local infos = HA_EmergList[pos];

  if(infos and infos.raider)
  then
    TargetUnit(infos.raider.id);
  else
    ClearTarget();
  end
end

function HAHeader_SortByName(byname)
  _HA_SortByName = byname;
end

function HA_OnShow()
  HealersAssistMainFrameCollapseHealers:SetChecked(HA_Config.HealersCollapsed);
  HA_SetWidgetSizeAndPosition();
  _HA_CheckForResetStates();
  HA_UpdateList();
  HA_UpdateListEmergency();
  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnEvent)
    then
      pl.OnEvent(HA_EVENT_WINDOW_SHOW);
    end
  end
end

function HA_OnHide()
  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnEvent)
    then
      pl.OnEvent(HA_EVENT_WINDOW_HIDE);
    end
  end
end

function HA_CheckGetCurrentInfos()
  -- Update Raider infos every 0.25 sec
  if(HA_CurrentTime > (_HA_LastTimeHPMP+0.25))
  then
    debugprofilestart();
    _HA_GetCurrentInfos();
    HA_PROFILE_RaidersInfosRoutine = debugprofilestop();
  end
end

function HA_OnUpdate(arg1)
  -- Update GUI every 0.10 sec
  if(HA_CurrentTime > (_HA_LastTimeGUI+_HA_CurrentUIRefresh))
  then
    debugprofilestart();
    _HA_CheckForResetStates();
    HA_UpdateList();
    HA_UpdateListEmergency();
    _HA_LastTimeGUI = HA_CurrentTime;
    HA_PROFILE_GUIRoutine = debugprofilestop();
  end
end

function HASetColumnWidth( width, frame )
  if ( not frame ) then
    frame = this;
  end
  frame:SetWidth(width);
  getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
end

local function _HA_SortHealersByAlphabetic(a,b)
  return a.Name < b.Name; -- Return alphabetic order
end

local function _HA_SortByCastingTime(a,b)
  return (a.StartTime+a.CastTime) < (b.StartTime+b.CastTime);
end

local _HA_NextSortingFunction = {};
_HA_NextSortingFunction[HA_STATE_HEALED] = _HA_SortHealersByAlphabetic;
_HA_NextSortingFunction[HA_STATE_STOP] = _HA_SortHealersByAlphabetic;
_HA_NextSortingFunction[HA_STATE_CASTING] = _HA_SortByCastingTime;
_HA_NextSortingFunction[HA_STATE_FAILED] = _HA_SortHealersByAlphabetic;
_HA_NextSortingFunction[HA_STATE_RESTING] = _HA_SortHealersByAlphabetic;
_HA_NextSortingFunction[HA_STATE_NOTHING] = _HA_SortHealersByAlphabetic;
_HA_NextSortingFunction[HA_STATE_DEAD] = _HA_SortHealersByAlphabetic;

local function _HA_SortHealersByState(a,b)
  if(a.State == b.State)
  then
    return _HA_NextSortingFunction[a.State](a,b);
  end
  return a.State < b.State;
end

local function _HA_SortHealersList(a,b)
  if(a.Name == HA_PlayerName) -- Put myself on top of the list
  then
    return true;
  end
  if(b.Name == HA_PlayerName) -- Put myself on top of the list
  then
    return false;
  end
  if(_HA_SortByName)
  then
    return _HA_SortHealersByAlphabetic(a,b);
  end
  if(_HA_CurrentTarget) -- I have a target
  then
    if(tostring(a.TargetName) == _HA_CurrentTarget) -- 'a' has the same target
    then
      if(tostring(b.TargetName) == _HA_CurrentTarget) -- 'b' has too, check from state (can not be dead)
      then
        return _HA_SortHealersByState(a,b);
      else -- 'b' doesn't, 'a' before 'b'
        return true;
      end
    else -- 'a' doesn't have the same target, check if 'b' has
      if(tostring(b.TargetName) == _HA_CurrentTarget) -- 'b' has, 'b' before 'a'
      then
        return false;
      else -- Else, check from State
        return _HA_SortHealersByState(a,b);
      end
    end
  end
  return _HA_SortHealersByState(a,b); -- I don't have a target, return from State
end

function HA_DefaultFilter_Healer(healer)
  if(healer.Raider and healer.Raider.ishealer and (healer.Name == HA_PlayerName or HA_Config.HealersClasses[healer.Raider.classid]))
  then
    return true;
  end
  return false;
end

local function HA_GetList()
  local UIList = {};
  local get_done = false;
  local sort_done = false;

  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnGetHealersList)
    then
      UIList = pl.OnGetHealersList();
      get_done = true;
      break;
    end
  end
  if(not get_done)
  then
    for name,tab in HA_Healers
    do
      if(HA_DefaultFilter_Healer(tab))
      then
        tinsert(UIList, tab);
      end
    end
    _HA_CurrentTarget = nil;
    if(HA_MyselfHealer)
    then
      _HA_CurrentTarget = HA_MyselfHealer.TargetName;
    end
  end

  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.SortHealers)
    then
      table.sort(UIList,pl.SortHealers);
      sort_done = true;
      break;
    end
  end
  if(not sort_done)
  then
    table.sort(UIList,_HA_SortHealersList);
  end
  return UIList;
end

local function _HA_SortEmergencyList(a,b)
  if(a.raider.count == 0) -- Nobody on 'a'
  then
    if(b.raider.count == 0) -- Nobody on 'b' -> Sort by %
    then
      return a.raider.percent < b.raider.percent;
    -- Everything else, sort by remain
    end
  end
  return ((a.raider.hpmax-a.raider.hp)-a.total) > ((b.raider.hpmax-b.raider.hp)-b.total); -- Compares a.remain - b.remain (remain = deficit-totalHeal)
end

function HA_DefaultFilter_Raider(raider)
  if(raider.percent < HA_Config.MinEmergencyPercent and -- percent < Config
   raider.isconnected and not raider.isdead and not raider.ischarmed and UnitIsVisible(raider.id) and -- Connected, not dead, is not charmed, is visible
   -- Check for filter
   (raider == HA_MyselfRaider or -- Always show myself
   ((raider.subgrp ~= 0 or (HA_CurrentTarget and raider.name == HA_CurrentTarget)) and -- If a special "Target" raider, must be current target
    (HA_CurrentGroupMode ~= HA_MODE_RAID or raider.subgrp == 0 or HA_Config.EmergencyGroups[raider.subgrp]) and -- Not Group filtered
    HA_Config.EmergencyClasses[raider.classid])) and -- Not class filtered
    (not HA_Config.FilterRange or CheckInteractDistance(raider.id,4))) -- Not range filtered
  then
    return true;
  end
  return false;
end

function HA_ComputeIncomingHeals(raider)
  local total = 0;
  local healer;

  for name,value in raider.estimates
  do
    heal_ratio = 1;
    healer = HA_Healers[name];
    if(healer)
    then
      heal_ratio = healer.EstimateRatio;
    end
    total = total + value*heal_ratio;
  end
  return floor(total * raider.estimate_ratio); -- Apply ratio
end

local function HA_GetListEmergency()
  local ret_vals = {};
  local temp = {};
  local heal_ratio;
  local healer;
  local get_done = false;
  local sort_done = false;

  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.OnGetEmergencyList)
    then
      temp = pl.OnGetEmergencyList();
      get_done = true;
      break;
    end
  end
  if(not get_done)
  then
    local total;
    for name,tab in HA_Raiders
    do
      if(HA_DefaultFilter_Raider(tab))
      then
        total = HA_ComputeIncomingHeals(tab);
        tinsert(temp, { raider = tab; total = total });
      end
    end
  end

  -- Call plugins
  for n,pl in HA_ActivePlugins
  do
    if(pl.SortEmergency)
    then
      table.sort(temp,pl.SortEmergency);
      sort_done = true;
      break;
    end
  end
  if(not sort_done)
  then
    table.sort(temp,_HA_SortEmergencyList);
  end
  
  if(HA_Config.EmergLines ~= 0)
  then
    local pos = 1;
    for i=1,HA_Config.EmergLines
    do
      if(temp[i])
      then
        ret_vals[pos] = { raider = temp[i].raider; deficit = temp[i].raider.hpmax-temp[i].raider.hp; total = temp[i].total };
        getglobal("HAItemEmergency_"..pos.."ClickFrame").unitid = temp[i].raider.id;
        pos = pos + 1;
      end
    end
  
    if(pos <= HA_Config.EmergLines)
    then
      for i=pos,HA_Config.EmergLines
      do
        ret_vals[i] = {};
      end
    end
  end
  HA_EmergList = ret_vals;
  return ret_vals;
end

local function _HA_SetTargetHealth(prefix,TargetName)
  if(TargetName ~= nil)
  then
    local percent = nil;
    if(HA_Raiders[TargetName]) -- Target is in the raid
    then
      local infos = HA_Raiders[TargetName];
      percent = infos.percent;
    elseif(UnitName("target") == TargetName) -- My target is the person I'm tyrying to heal
    then
      percent = floor(UnitHealth("target") / UnitHealthMax("target") * 100);
    end
    if(percent ~= nil)
    then
      if(percent > 100) then percent = 100; end;
      getglobal(prefix.."HPBar"):Show();
      getglobal(prefix.."HPBar"):SetValue(percent);
      return;
    end
  end
  getglobal(prefix.."HPBar"):Hide();
end

local function _HA_SetHealerMana(prefix,PlayerName,State)
  local infos = HA_Raiders[PlayerName];
  if(infos)
  then
    local percent = infos.mppercent;
    if(percent ~= nil)
    then
      -- Draw MP bar
      if(percent > 100) then percent = 100; end;
      local powertype = UnitPowerType(infos.id);
      if(powertype ~= 0) -- Check powertype for druids
      then
        percent = 0;
        if(powertype == 1) -- Bear
        then
          getglobal(prefix.."MPBarBG"):SetVertexColor(1, 0, 0, 0.2);
        else -- Cat
          getglobal(prefix.."MPBarBG"):SetVertexColor(1, 1, 0, 0.2);
        end
      else
        getglobal(prefix.."MPBarBG"):SetVertexColor(0, 0, 1, 0.2);
      end
      getglobal(prefix.."MPBar"):Show();
      getglobal(prefix.."MPBar"):SetValue(percent);
      -- Check for MP bar flashing
      if(State == HA_STATE_RESTING)
      then
        local cur_alpha = getglobal(prefix.."MPBar"):GetAlpha();
        cur_alpha = cur_alpha + _HA_CurrentWindowAlpha/10;
        if(cur_alpha >= _HA_CurrentWindowAlpha)
        then
          cur_alpha = _HA_CurrentWindowAlpha/3;
        end
        getglobal(prefix.."MPBar"):SetAlpha(cur_alpha);
      else
        getglobal(prefix.."MPBar"):SetAlpha(_HA_CurrentWindowAlpha);
      end
      return;
    end
  end
  getglobal(prefix.."MPBar"):Hide();
end

function HA_UpdateList()
	if(not HealersAssistMainFrame:IsVisible()) then
		return;
	end
	local list = HA_GetList();
	local size = table.getn(list);
	local target_raider;
	local estim_ratio;
        local isdead;
        local healer;
	
	local offset = FauxScrollFrame_GetOffset(HAItemScrollFrame);
        local healerslines = HA_Config.HealersLines;
        if(HA_Config.HealersCollapsed) then healerslines = 1; end;
	numButtons = healerslines;
	i = 1;
	while (i <= numButtons) do
		local j = i + offset
		local prefix = "HAItem_"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
			healer = list[j];
			getglobal("HAItem_"..i.."ClickFrame").unitid = healer.Raider.id;
                        button.infos = healer;
                        isdead = false;
                        if(healer.State == HA_STATE_DEAD)
                        then
                          getglobal(prefix.."MPBarText"):SetTextColor(1, 0.1, 0.1);
                          isdead = true;
                        else
                          local colors = RAID_CLASS_COLORS[healer.Raider.class];
                          if(colors)
                          then
                            getglobal(prefix.."MPBarText"):SetTextColor(colors.r, colors.g, colors.b);
                          end
                        end
			getglobal(prefix.."MPBarText"):SetText(healer.Name);
			_HA_SetHealerMana(prefix,healer.Name,healer.State);
                        if(healer.State == HA_STATE_CASTING or healer.State == HA_STATE_STOP)
                        then
                          getglobal(prefix.."State"):SetTextColor(0,0.9,0);
			  getglobal(prefix.."State"):SetText(healer.ShortSpellName);
                          if(healer.OverHealPercent ~= 0) -- Overhealing
                          then
                            local col = 1.0 - (healer.OverHealPercent / 100);
                            getglobal(prefix.."HPBarText"):SetVertexColor(1.0, col, col, 0.8);
                          else
                            getglobal(prefix.."HPBarText"):SetVertexColor(1.0, 1.0, 1.0, 0.8);
                          end
			  getglobal(prefix.."HPBarText"):SetText(healer.TargetName);
                          local percent = (HA_CurrentTime - healer.StartTime) / healer.CastTime * 100;
                          if(percent > 100)
                          then
                            percent = 100;
                          end;
			  getglobal(prefix.."CTBar"):Show();
			  getglobal(prefix.."CTBar"):SetValue(percent);
                          getglobal(prefix.."CTBarText"):SetTextColor(0,0.8,0);
                          if(healer.Estimate ~= 0)
                          then
                            target_raider = HA_Raiders[healer.TargetName];
                            estim_ratio = 1;
                            if(target_raider)
                            then
                              estim_ratio = target_raider.estimate_ratio;
                            end
                            getglobal(prefix.."CTBarText"):SetText("("..tostring(floor(healer.Estimate*healer.EstimateRatio*estim_ratio))..")");
                          else
                            getglobal(prefix.."CTBarText"):SetText("");
                          end
                          _HA_SetTargetHealth(prefix,healer.TargetName);
                        elseif(healer.State == HA_STATE_FAILED)
                        then
                          getglobal(prefix.."State"):SetTextColor(0.8,0,0);
			  getglobal(prefix.."State"):SetText(healer.Reason);
                          getglobal(prefix.."HPBarText"):SetVertexColor(1.0, 1.0, 1.0, 0.8);
			  getglobal(prefix.."HPBarText"):SetText(healer.TargetName);
			  getglobal(prefix.."CTBar"):Hide();
                          _HA_SetTargetHealth(prefix,healer.TargetName);
                        elseif(healer.State == HA_STATE_HEALED)
                        then
                          getglobal(prefix.."State"):SetTextColor(0.1,0.4,0.1);
			  getglobal(prefix.."State"):SetText(healer.ShortSpellName);
                          if(healer.OverHealed) -- Overhealing
                          then
                            local col = 1.0 - healer.OverHealed;
                            getglobal(prefix.."HPBarText"):SetVertexColor(1.0, col, col, 0.8);
                          else
                            getglobal(prefix.."HPBarText"):SetVertexColor(1.0, 1.0, 1.0, 0.8);
                          end
			  getglobal(prefix.."HPBarText"):SetText(healer.TargetName);
			  getglobal(prefix.."CTBar"):Show();
                          getglobal(prefix.."CTBar"):SetValue(0);
                          if(healer.HoT) -- A HoT spell (or instant)
                          then
                            if(healer.Duration == 0) -- Instant
                            then
                              getglobal(prefix.."CTBarText"):SetText("");
                            else -- HoT
                              getglobal(prefix.."CTBarText"):SetText(tostring(healer.Value).."/"..tostring(healer.Duration).."s");
                              getglobal(prefix.."CTBarText"):SetTextColor(0,0.9,0);
                            end
                          else -- Casted spell
                            if(healer.Value == 0) -- Non-heal spell (rez ?)
                            then
                              getglobal(prefix.."CTBarText"):SetText("");
                            elseif(healer.Crit)
                            then
                              getglobal(prefix.."CTBarText"):SetText("C:+"..tostring(healer.Value));
                              getglobal(prefix.."CTBarText"):SetTextColor(0,1,0);
                            else
                              getglobal(prefix.."CTBarText"):SetText("+"..tostring(healer.Value));
                              getglobal(prefix.."CTBarText"):SetTextColor(0,0.9,0);
                            end
                          end
                          _HA_SetTargetHealth(prefix,healer.TargetName);
                        else -- All other cases (NOTHING/DEAD/RESTING)
                          if(healer.State == HA_STATE_RESTING)
                          then
                            getglobal(prefix.."State"):SetTextColor(0.2,0.2,1.0);
			    getglobal(prefix.."State"):SetText(HA_GUI_RESTING_STATE);
                            if(HA_CurrentGroupMode == HA_MODE_RAID)
                            then
                              getglobal(prefix.."HPBarText"):SetVertexColor(1.0, 1.0, 1.0, 1.0);
                              getglobal(prefix.."HPBarText"):SetText("Grp "..healer.Raider.subgrp);
                              getglobal(prefix.."HPBar"):SetValue(0);
                              getglobal(prefix.."HPBar"):Show();
                            else
                              getglobal(prefix.."HPBar"):Hide();
                            end
                          else
			    getglobal(prefix.."State"):SetText("");
                            getglobal(prefix.."HPBar"):Hide();
                          end
			  getglobal(prefix.."CTBar"):Hide();
                        end
                        -- Cooldown receiver status
                        local under_Cooldown = {};
                        local cur_specific = 1;
                        for spell,tab in healer.Raider.overtime
                        do
                          if(cur_specific > MAX_COOLDOWN_SPELLS)
                          then
                            break;
                          end
                          if(HA_Cooldown[tab.ispell]) -- I'm under a Cooldown spell
                          then
                            getglobal(prefix.."ClassSpecific"..cur_specific):Show();
                            getglobal(prefix.."ClassSpecific"..cur_specific.."Texture"):SetVertexColor(HA_Cooldown[tab.ispell].flash_r,HA_Cooldown[tab.ispell].flash_g,HA_Cooldown[tab.ispell].flash_b);
                            getglobal(prefix.."ClassSpecific"..cur_specific.."Texture"):SetTexture(HA_Cooldown[tab.ispell].texture);
                            local cur_alpha = getglobal(prefix.."ClassSpecific"..cur_specific):GetAlpha();
                            cur_alpha = cur_alpha + _HA_CurrentWindowAlpha/10;
                            if(cur_alpha >= _HA_CurrentWindowAlpha)
                            then
                              cur_alpha = _HA_CurrentWindowAlpha/3;
                            end
                            getglobal(prefix.."ClassSpecific"..cur_specific):SetAlpha(cur_alpha);
                            getglobal(prefix.."ClassSpecific"..cur_specific).cooldown = nil;
                            getglobal(prefix.."ClassSpecific"..cur_specific).spell = spell;
                            getglobal(prefix.."ClassSpecific"..cur_specific).ispell = tab.ispell;
                            getglobal(prefix.."ClassSpecific"..cur_specific).from = tab.From;
                            getglobal(prefix.."ClassSpecific"..cur_specific).me = nil;
                            cur_specific = cur_specific + 1;
                            under_Cooldown[spell] = true;
                          end
                        end
                        -- Cooldown owner status
                        for spell,cdinfos in healer.Cooldown
                        do
                          if(HA_Cooldown[cdinfos.ispell])
                          then
                            if(cur_specific > MAX_COOLDOWN_SPELLS)
                            then
                              break;
                            end
                            if(under_Cooldown[spell] == nil) -- I'm not under a Cooldown spell myself, show my Cooldown status
                            then
                              if(cdinfos.Remain > 0 or isdead) -- Still in cooldown, or dead
                              then
                                getglobal(prefix.."ClassSpecific"..cur_specific):SetAlpha(_HA_CurrentWindowAlpha/5);
                              else
                                getglobal(prefix.."ClassSpecific"..cur_specific):SetAlpha(_HA_CurrentWindowAlpha);
                              end
                              getglobal(prefix.."ClassSpecific"..cur_specific.."Texture"):SetVertexColor(1,1,1);
                              getglobal(prefix.."ClassSpecific"..cur_specific.."Texture"):SetTexture(HA_Cooldown[cdinfos.ispell].texture);
                              getglobal(prefix.."ClassSpecific"..cur_specific):Show();
                              getglobal(prefix.."ClassSpecific"..cur_specific).cooldown = cdinfos.Remain;
                              getglobal(prefix.."ClassSpecific"..cur_specific).spell = spell;
                              getglobal(prefix.."ClassSpecific"..cur_specific).ispell = cdinfos.ispell;
                              getglobal(prefix.."ClassSpecific"..cur_specific).me = healer.Name;
                              getglobal(prefix.."ClassSpecific"..cur_specific).isdead = isdead;
                              cur_specific = cur_specific + 1;
                            end
                          end
                        end
                        for k=cur_specific,MAX_COOLDOWN_SPELLS
                        do
                          getglobal(prefix.."ClassSpecific"..k):Hide();
                        end
			button:Show();
		else
                        button.infos = nil;
			button:Hide();
		end
		
		i = i + 1;
	end
	
	FauxScrollFrame_Update(HAItemScrollFrame, size, healerslines, 1);

        -- Call plugins
        for n,pl in HA_ActivePlugins
        do
          if(pl.OnEvent)
          then
            pl.OnEvent(HA_EVENT_GUI_UPDATED_HEALERS);
          end
        end
end

function HA_UpdateListEmergency()
	local list = HA_GetListEmergency();
	if(not HealersAssistMainFrame:IsVisible()) then
		return;
	end
	local size = table.getn(list);
        local healer = HA_MyselfHealer;
        local raider;

	for i,infos in list
	do
		local prefix = "HAItemEmergency_"..i;
		local button = getglobal(prefix);
		raider = infos.raider;
                if(raider)
                then
                  local colors = RAID_CLASS_COLORS[raider.class];
                  if(colors)
                  then
                    getglobal(prefix.."Name"):SetTextColor(colors.r, colors.g, colors.b);
                  end
                  getglobal(prefix.."Name"):SetText(raider.name);
                  if(raider.subgrp == 0) -- Current Target
                  then
                    getglobal(prefix.."HPBarText"):SetText(raider.percent.."%");
                  else
                    getglobal(prefix.."HPBarText"):SetText("-"..tostring(infos.deficit));
                  end
                  if(healer and healer.State == HA_STATE_CASTING and healer.TargetName == raider.name)
                  then
                    getglobal(prefix.."HPBarText"):SetVertexColor(0.4, 0.4, 1.0, 0.9);
                  else
                    getglobal(prefix.."HPBarText"):SetVertexColor(1.0, 1.0, 1.0, 0.9);
                  end
                  getglobal(prefix.."HPBar"):SetValue(tostring(raider.percent));
                  getglobal(prefix.."Count"):SetText(tostring(raider.count));
                  if(infos.total == 0)
                  then
                    getglobal(prefix.."Total"):SetText("-");
                  else
                    getglobal(prefix.."Total"):SetText(tostring(infos.total));
                  end
                  -- Update overtime
                  local pos = 1;
                  for spell,tab in raider.overtime
                  do
                    if(HA_Cooldown[tab.ispell] == nil) -- Don't show cooldown spells
                    then
                      if(HA_InstantSpells[spell] and HA_SpellOvertime[tab.ispell]) -- A changer, on accede direct sans le iname coté serveur
                      then
                        getglobal(prefix.."Overtime"..pos.."Texture"):SetTexture(HA_SpellOvertime[tab.ispell].texture);
                        getglobal(prefix.."Overtime"..pos):Show();
                        -- Break if too many spells
                        pos = pos + 1;
                        if(pos > MAX_OVERTIME_SPELLS)
                        then
                          break;
                        end
                      end
                    end
                  end
                  for k=pos,MAX_OVERTIME_SPELLS
                  do
                    getglobal(prefix.."Overtime"..k):Hide();
                  end
                  button.infos = raider;
                  button.unitid = raider.id;
                  button:Show();
                else
                  button.infos = nil;
                  button.unitid = nil;
                  button:Hide();
                end
	end

        -- Call plugins
        for n,pl in HA_ActivePlugins
        do
          if(pl.OnEvent)
          then
            pl.OnEvent(HA_EVENT_GUI_UPDATED_EMERGENCY);
          end
        end
end

function HA_RequestSpell(SpellName)
  local request_name = nil;
  local spell_code = HA_GetSpellCode(SpellName);
  local spell_class = HA_GetSpellClass(spell_code);

  if(HA_Cooldown[spell_code] == nil or not HA_Cooldown[spell_code].can_request)
  then
    HA_ChatPrint(string.format(HA_GUI_REQUEST_SEARCH_INVALID_SPELL,SpellName));
    return;
  end
  
  for name,healer in HA_Healers do
    if(not healer.isdead and healer.Raider and spell_class == healer.Raider.class)
    then
      for spell,cdinfos in healer.Cooldown
      do
        if(cdinfos.ispell == spell_code and cdinfos.Remain == 0) -- Found somebody
        then
          request_name = name; -- Store the name to fallback in case nobody in range
          if(CheckInteractDistance(healer.id,4) and UnitPowerType(healer.id) == 0) -- In range and not a druid in feral form, stop checking
          then
            break;
          end
        end
      end
    end
  end
  if(request_name) -- Found someone
  then
    HA_COM_SpellRequest(spell_code,request_name);
    HA_ChatPrint(string.format(HA_GUI_REQUEST_SEARCH_OK,SpellName,request_name));
  else
    HA_ChatPrint(string.format(HA_GUI_REQUEST_SEARCH_FAILED,SpellName));
  end
end

function HA_GUI_ClassSpecificTooltip(spell,from,cooldown)
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
  GameTooltip:ClearLines();
  if(cooldown == nil) -- Receiver
  then
    GameTooltip:AddLine(string.format(HA_GUI_TOOLTIP_GOT_SPELL,spell,from));
  else
    if(cooldown == 0)
    then
      GameTooltip:AddLine(string.format(HA_GUI_TOOLTIP_READY,spell));
    else
      GameTooltip:AddLine(string.format(HA_GUI_TOOLTIP_COOLDOWN,spell));
      GameTooltip:AddLine(_HA_ConvertToMinSec(floor(cooldown)));
    end
  end
  GameTooltip:Show();
end

function HA_GUI_ClassSpecificClick(SpellCode,PlayerName,cooldown)
  if(cooldown == nil or cooldown ~= 0 or PlayerName == nil or HA_Cooldown[SpellCode] == nil or not HA_Cooldown[SpellCode].can_request) -- Under this spell, or spell not ready, or spell cannot be requested
  then
    return;
  end
  local SpellName = HA_GetLocalName(SpellCode);
  local spellinfos = HA_Spells[SpellName];
  if(spellinfos == nil) then spellinfos = HA_InstantSpells[SpellName]; end
  if(spellinfos)
  then
    if(UnitIsDeadOrGhost("player") and not spellinfos.rez) -- I'm dead
    then
      HA_ChatPrint(HA_GUI_REQUEST_YOU_ARE_DEAD);
      return;
    elseif(not UnitIsDeadOrGhost("player") and spellinfos.rez) -- Not dead
    then
      HA_ChatPrint(HA_GUI_REQUEST_NOT_DEAD_YET);
      return;
    end
  end
  if(PlayerName == HA_PlayerName)
  then
    HA_GUI_Process_SpellRequest(PlayerName,SpellCode);
  else
    HA_COM_SpellRequest(SpellCode,PlayerName);
  end
end

StaticPopupDialogs["HA_REQUEST_FOR_SPELL"] = {
  text = TEXT(""),
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  OnShow = function()
    local TargetName = HA_SpellRequest.target;
    local SpellName = HA_SpellRequest.spell;
    HA_ChatDebug(HA_DEBUG_ACTIONS,"StaticPopup : SpellRequest show for "..tostring(HA_SpellRequest.spell));
    if(SpellName)
    then
      if(HA_SpellRequest.failure)
      then
        getglobal(this:GetName().."Text"):SetText(format(HA_GUI_POPUP_REQUEST_FOR_SPELL_WITH_FAILURE,TargetName,SpellName,HA_SpellRequest.failure));
      else
        getglobal(this:GetName().."Text"):SetText(format(HA_GUI_POPUP_REQUEST_FOR_SPELL,TargetName,SpellName));
      end
    else
      getglobal(this:GetName().."Text"):SetText("HealersAssist Spell Request Error !\nPlease inform kiki.");
    end
    if(_HA_UnitInRange(HA_SpellRequest.id,HA_SpellRequest.ispell))
    then
      getglobal(this:GetName().."Button1"):Enable();
      HA_SpellRequest.WasEnabled = true;
    else
      getglobal(this:GetName().."Button1"):Disable();
      HA_SpellRequest.WasEnabled = false;
    end
    HA_SpellRequest.LastTime = HA_CurrentTime;
    this.FirstUpdate = true;
  end,
  OnUpdate = function()
    if(this.FirstUpdate)
    then
      local bb = getglobal(this:GetName().."Button1");  
      this:SetHeight(this:GetTop() - bb:GetBottom() + 20);
      this.FirstUpdate = nil;
    end
    if(HA_SpellRequest and HA_SpellRequest.LastTime and (HA_CurrentTime > (HA_SpellRequest.LastTime+0.2)))
    then
      HA_SpellRequest.LastTime = HA_CurrentTime;
      if(this and getglobal(this:GetName().."Button1"))
      then
        local new_state = _HA_UnitInRange(HA_SpellRequest.id,HA_SpellRequest.ispell);
        if(new_state ~= HA_SpellRequest.WasEnabled)
        then
          if(new_state)
          then
            getglobal(this:GetName().."Button1"):Enable();
          else
            getglobal(this:GetName().."Button1"):Disable();
          end
          HA_SpellRequest.WasEnabled = new_state;
        end
      end
    end
  end,
  OnAccept = function()
    if(HA_SpellRequest)
    then
      local TargetName = HA_SpellRequest.target;
      local unitid = HA_SpellRequest.id;
      local SpellName = HA_GetLocalName(HA_SpellRequest.ispell);
      if(SpellName)
      then
        HA_ChatDebug(HA_DEBUG_ACTIONS,"StaticPopup : SpellRequest accepted for "..tostring(HA_SpellRequest.spell));
        if(not HA_Cooldown[HA_SpellRequest.ispell].norange)
        then
          TargetUnit(unitid);
        end
        SpellStopCasting();
        HA_SpellTargetName = TargetName;
        CastSpellByName(SpellName);
      end
    end
  end,
  OnCancel = function()
    if(HA_SpellRequest)
    then
      local TargetName = HA_SpellRequest.target;
      local SpellCode = HA_SpellRequest.ispell;
      HA_ChatDebug(HA_DEBUG_ACTIONS,"StaticPopup : SpellRequest denied for "..tostring(HA_SpellRequest.spell).." : "..tostring(HA_SpellRequest.failure));
      HA_COM_SpellRequestDenied(SpellCode,TargetName,HA_SPELL_REQUEST_CODE_DENIED_DENIED);
    end
    HA_SpellRequest = nil;
  end,
  OnHide = function()
    if(HA_SpellRequest ~= nil)
    then
      StaticPopup_Show("HA_REQUEST_FOR_SPELL");
    end
  end,
  whileDead = 0,
  hideOnEscape = 1,
  timeout = 0
};

function HA_SetRegenMode(state)
  local healer = HA_MyselfHealer;
  if(healer)
  then
    if(state)
    then
      healer.NextResetState = HA_STATE_RESTING;
      HA_COM_RegenMode(true);
      HealersAssistMainFrameSetResting:SetChecked(1);
      if(healer.State == HA_STATE_NOTHING) -- Was doing nothing, change the state now
      then
        _HA_ResetHealerState(healer,false);
      end
    else
      healer.NextResetState = nil;
      if(healer.State == HA_STATE_RESTING) -- Was already in regen state, reset the state
      then
        _HA_ResetHealerState(healer,false);
      end
      HA_COM_RegenMode(false);
      HealersAssistMainFrameSetResting:SetChecked(0);
    end
  end
end


--------------- Process functions ---------------

--[[
  HA_GUI_Process_SpellStart function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - TargetName : String -- Target of the heal
   - CastTime   : Int    -- Casttime of the spell
   - Estimated  : Int    -- Estimated spell value (can be 0)
   - WillCrit   : Bool   -- If you are sure the spell will crit (Estimated is crit value)
   - SpellRank  : Int    -- Rank of the spell (can be 0)
]]
function HA_GUI_Process_SpellStart(From,SpellCode,TargetName,CastTime,Estimated,WillCrit,SpellRank)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];
  if(healer and SpellName)
  then
    local spell = HA_Spells[SpellName];
    if(spell)
    then
      if(SpellRank == nil) then SpellRank = 0; end
      _HA_ResetHealerState(healer,true);
      healer.SpellCode = SpellCode;
      healer.NonHeal = spell.nonheal;
      healer.SpellName = SpellName;
      healer.SpellRank = SpellRank;
      healer.ShortSpellName = spell.short;
      healer.TargetName = TargetName;
      healer.Estimate = Estimated;
      healer.WillCrit = WillCrit;
      healer.GroupHeal = spell.group;
      if(CastTime == nil)
      then
        HA_ChatWarning("SPELLCAST_START : CastTime is nil : "..tostring(arg2));
        healer.CastTime = 1;
      else
        healer.CastTime = CastTime / 1000;
      end
      healer.StartTime = HA_CurrentTime;
      local raider = HA_Raiders[TargetName];
      if(raider and Estimated ~= 0 and raider.estimates[From] == nil and not spell.group)
      then
        raider.count = raider.count + 1;
        raider.estimates[From] = healer.Estimate;
      end
      healer.State = HA_STATE_CASTING;
      if(raider)
      then
        -- Call plugins
        for n,pl in HA_ActivePlugins
        do
          if(pl.OnSpellStart)
          then
            pl.OnSpellStart(healer,raider,SpellCode,SpellName,CastTime,Estimated,WillCrit,SpellRank);
          end
        end
      end
      HA_ChatDebug(HA_DEBUG_SPELLS,"SpellStart from "..From.." to "..tostring(TargetName).." with "..SpellName.." ("..tostring(SpellRank)..") for "..tostring(CastTime));
    end
  end
end

--[[
  HA_GUI_Process_SpellStop function :
   - From       : String -- Source player
]]
function HA_GUI_Process_SpellStop(From)
  local healer = HA_Healers[From];
  if(healer)
  then
    -- Remove estimate value
    _HA_ResetHealerEstimate(healer);
    -- Set STOP state
    healer.EndTime = HA_CurrentTime + HA_Config.KeepValue;
    healer.State = HA_STATE_STOP;
    if(healer.CastTime == nil)
    then
      healer.CastTime = 1;
    end
    HA_ChatDebug(HA_DEBUG_SPELLS,"SpellStop from "..From);
  end
end

--[[
  HA_GUI_Process_SpellHit function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - TargetName : String -- Target of the heal
   - Value      : Int    -- Healed value
   - Crit       : Bool   -- Heal has crit
]]
function HA_GUI_Process_SpellHit(From,SpellCode,TargetName,Value,Crit)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];
  local spell = HA_Spells[SpellName];
  local raider = HA_Raiders[TargetName];

  if(healer)
  then
    if(spell) -- Casted spell
    then
      _HA_Process_SpellHit(healer,SpellCode,SpellName,raider,Value,Crit,false);
    elseif(HA_InstantSpells[SpellName])
    then
      _HA_Process_SpellHit(healer,SpellCode,SpellName,raider,Value,Crit,true);
    end
  end
end

--[[
  HA_GUI_Process_SpellFailed function :
   - From      : String -- Source player
   - SpellCode : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - IReason   : Int -- Reason code of failure
   - Reason    : String -- Reason text of failure (nil if IReason ~= 0)
]]
function HA_GUI_Process_SpellFailed(From,SpellCode,IReason,Reason)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];
  local spell = HA_Spells[SpellName];
  if(healer and spell)
  then
    if(IReason ~= 0)
    then
      if(IReason == HA_SPELL_FAILED_OUT_OF_SIGHT)
      then
        Reason = HA_FAILED_TEXT_OUT_OF_SIGHT;
      elseif(IReason == HA_SPELL_FAILED_OUT_OF_RANGE)
      then
        Reason = HA_FAILED_TEXT_TOO_FAR;
      elseif(IReason == HA_SPELL_FAILED_TARGET_DIED)
      then
        Reason = HA_FAILED_TEXT_DEAD;
      else
        Reason = HA_GetLocalReason(IReason);
      end
    end
    local raider = HA_Raiders[healer.TargetName];
    if(raider)
    then
      -- Call plugins
      for n,pl in HA_ActivePlugins
      do
        if(pl.OnSpellFailed)
        then
          pl.OnSpellFailed(healer,raider,SpellCode,IReason,Reason);
        end
      end
    end
    -- Set failed mode, if not currently casting
    if(healer.State  == HA_STATE_STOP)
    then
      healer.State  = HA_STATE_FAILED;
      healer.EndTime = HA_CurrentTime + HA_Config.KeepValue;
      healer.Reason = Reason;
    end
    HA_ChatDebug(HA_DEBUG_SPELLS,"SpellFailed from "..healer.Name.." with "..tostring(SpellName).." : "..Reason);
  end
end

--[[
  HA_GUI_Process_SpellDelayed function :
   - From  : String -- Source player
   - Value : Int -- Delayed value in msec
]]
function HA_GUI_Process_SpellDelayed(From,Value)
  local healer = HA_Healers[From];
  if(healer)
  then
    if(healer.State == HA_STATE_CASTING)
    then
      healer.StartTime = healer.StartTime + Value/1000;
      -- Call plugins
      for n,pl in HA_ActivePlugins
      do
        if(pl.OnSpellDelayed)
        then
          pl.OnSpellDelayed(healer,Value);
        end
      end
      HA_ChatDebug(HA_DEBUG_SPELLS,"SpellDelayed from "..From.." for "..Value);
    end
  end
end

--[[
  HA_GUI_Process_SpellCooldown function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - TargetName : String -- Target
]]
function HA_GUI_Process_SpellCooldown(From,SpellCode,TargetName)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];

  if(healer and SpellName)
  then
    local raider = HA_Raiders[TargetName];
    if(raider)
    then
      if(SpellCode == HA_SPELL_INNERVATE) -- Druid's Innervate
      then
        raider.overtime[HA_INNERVATE] = { From = healer.Name; Start = GetTime(); Duration = 20; ispell = SpellCode };
        if(raider.name == HA_PlayerName and healer.Name ~= HA_PlayerName)
        then
          HA_ChatPrint(HA_CHAT_MSG_INNERVATED);
          PlaySoundFile("Sound\\interface\\levelup2.wav");
        end
      elseif(SpellCode == HA_SPELL_BLESSING_OF_PROTECTION) -- Paladin's BoP
      then
        raider.overtime[HA_BLESSING_OF_PROTECTION] = { From = healer.Name; Start = GetTime(); Duration = 10; ispell = SpellCode };
      elseif(SpellCode == HA_SPELL_DIVINE_INTERVENTION) -- Paladin's Divine Intervention
      then
        raider.overtime[HA_DIVINE_INTERVENTION] = { From = healer.Name; Start = GetTime(); Duration = 180; ispell = SpellCode };
      elseif(SpellCode == HA_SPELL_POWER_INFUSION) -- Priest's Power Infusion
      then
        if(HA_RaiderInfused(TargetName))
        then
          raider.overtime[HA_POWER_INFUSION].From = healer.Name;
        else
          raider.overtime[HA_POWER_INFUSION] = { From = healer.Name; Start = GetTime(); Duration = 15; ispell = SpellCode };
          if(raider.name == HA_PlayerName and healer.Name ~= HA_PlayerName)
          then
            HA_ChatPrint(HA_CHAT_MSG_INFUSED);
            PlaySoundFile("Sound\\Doodad\\HornGoober.wav");
          end
        end
      end
      -- Call plugins
      for n,pl in HA_ActivePlugins
      do
        if(pl.OnSpellCooldown)
        then
          pl.OnSpellCooldown(healer,raider,SpellCode,SpellName);
        end
      end
      HA_ChatDebug(HA_DEBUG_SPELLS,"SpellCooldown "..SpellName.." from "..healer.Name.." to "..tostring(raider.name));
    end
  end
end

--[[
  HA_GUI_Process_CooldownUpdate function :
   - From      : String -- Source player
   - SpellCode : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - Cooldown  : Int    -- Cooldown in sec (0 = up)
]]
function HA_GUI_Process_CooldownUpdate(From,SpellCode,Cooldown)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];
  if(healer and SpellName and HA_Cooldown[SpellCode])
  then
    healer.Cooldown[SpellName] = { Start = GetTime(); Remain = Cooldown; ispell = SpellCode };
    -- Call plugins
    for n,pl in HA_ActivePlugins
    do
      if(pl.OnCooldownUpdate)
      then
        pl.OnCooldownUpdate(healer,SpellCode,SpellName,Cooldown);
      end
    end
    HA_ChatDebug(HA_DEBUG_SPELLS,SpellName.." cooldown of "..From.." is "..Cooldown);
  end
end

--[[
  HA_GUI_Process_SpellOvertime function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - TargetName : String -- Target of the heal
   - Duration   : Int    -- Duration over time
   - Estimated  : Int    -- Estimated spell value (can be 0)
   - SpellRank  : Int    -- Rank of the spell (can be 0)
]]
function HA_GUI_Process_SpellOvertime(From,SpellCode,TargetName,Duration,Estimated,SpellRank)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];
  if(healer and SpellName)
  then
    if(HA_InstantSpells[SpellName])
    then
      if(SpellRank == nil) then SpellRank = 0; end
      local raider = HA_Raiders[TargetName];
      if(raider and HA_SpellOvertime[HA_InstantSpells[SpellName].iname])
      then
        raider.overtime[SpellName] = { From = From; Start = GetTime(); Duration = Duration; ispell = SpellCode; Estimated = Estimated };
        _HA_Process_SpellHitInstant(healer,raider,SpellCode,SpellName,Duration,Estimated,SpellRank);
      end
      HA_ChatDebug(HA_DEBUG_SPELLS,"SpellOvertime from "..From.." to "..tostring(TargetName).." with "..SpellName.." ("..tostring(SpellRank)..") for "..Duration.." secondes (Estimated "..Estimated..")");
    end
  end
end

--[[
  HA_GUI_Process_SpellInstant function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - TargetName : String -- Target of the spell
   - SpellRank  : Int    -- Rank of the spell (can be 0)
]]
function HA_GUI_Process_SpellInstant(From,SpellCode,TargetName,SpellRank)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];
  if(healer and SpellName)
  then
    if(HA_InstantSpells[SpellName])
    then
      if(SpellRank == nil) then SpellRank = 0; end
      local raider = HA_Raiders[TargetName];
      if(raider)
      then
        _HA_Process_SpellHitInstant(healer,raider,SpellCode,SpellName,0,0,SpellRank);
        if(HA_SpellOvertime[HA_InstantSpells[SpellName].iname]) -- Is it a spell over time ?
        then
          raider.overtime[SpellName] = { From = From; Start = GetTime(); Duration = HA_SpellOvertime[HA_InstantSpells[SpellName].iname].duration; ispell = SpellCode };
        end
      end
      HA_ChatDebug(HA_DEBUG_SPELLS,"SpellInstant from "..From.." to "..tostring(TargetName).." with "..SpellName.." ("..tostring(SpellRank)..")");
    end
  end
end

--[[
  HA_GUI_Process_SpellRequest function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
]]
function HA_GUI_Process_SpellRequest(From,SpellCode)
  local SpellName = HA_GetLocalName(SpellCode);
  if(SpellName and HA_Raiders[From])
  then
    HA_ChatDebug(HA_DEBUG_SPELLS,"HA_GUI_Process_SpellRequest from "..From.." for "..SpellName);
    if(HA_Config.AllowSpellRequest[SpellName] and HA_SpellRequest == nil) -- I allow this spell to be auto-casted, and I'm not currently under a request
    then
      HA_SpellRequest = { spell=SpellName; ispell=SpellCode; target=From; id=HA_Raiders[From].id };
      StaticPopup_Show("HA_REQUEST_FOR_SPELL");
    else
      if(HA_Config.AllowSpellRequest[SpellName] == nil)
      then
        HA_ChatDebug(HA_DEBUG_SPELLS,"HA_GUI_Process_SpellRequest : Automatically denying request !");
        HA_COM_SpellRequestDenied(SpellCode,From,HA_SPELL_REQUEST_CODE_DENIED_BLOCKED);
      else
        HA_ChatDebug(HA_DEBUG_SPELLS,"HA_GUI_Process_SpellRequest : Denying request, already got one !");
        HA_COM_SpellRequestDenied(SpellCode,From,HA_SPELL_REQUEST_CODE_DENIED_BUSY);
      end
    end
  end
end

--[[
  HA_GUI_Process_SpellRequestDenied function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - ReasonCode : Int    -- Reason
]]
function HA_GUI_Process_SpellRequestDenied(From,SpellCode,ReasonCode)
  local SpellName = HA_GetLocalName(SpellCode);
  if(SpellName)
  then
    HA_ChatDebug(HA_DEBUG_SPELLS,"HA_GUI_Process_SpellRequestDenied from "..From.." for "..SpellName);
    HA_ChatPrint(string.format(HA_SpellRequestDenied[ReasonCode],SpellName,From));
  end
end

--[[
  HA_GUI_Process_RegenMode function :
   - From       : String -- Source player
   - IsInRegen  : Bool -- If I go in regen mode
]]
function HA_GUI_Process_RegenMode(From,IsInRegen)
  local healer = HA_Healers[From];
  if(healer and HA_Raiders[From])
  then
    if(IsInRegen)
    then
      healer.NextResetState = HA_STATE_RESTING;
      if(HA_Config.NotifyRegen)
      then
        HA_ChatPrint(string.format(HA_CHAT_MSG_IN_REGEN,From));
      end
      if(healer.State == HA_STATE_NOTHING) -- Was doing nothing, change the state now
      then
        _HA_ResetHealerState(healer,false);
      end
    else
      healer.NextResetState = nil;
      if(healer.State == HA_STATE_RESTING) -- Was already in regen state, reset the state
      then
        _HA_ResetHealerState(healer,false);
      end
      if(HA_Config.NotifyRegen)
      then
        HA_ChatPrint(string.format(HA_CHAT_MSG_OUT_OF_REGEN,From));
      end
    end
    HA_ChatDebug(HA_DEBUG_SPELLS,"HA_GUI_Process_RegenMode from "..From.." : "..tostring(IsInRegen));
  end
end

--[[
  HA_GUI_Process_GotPowerInfusion function :
   - From       : String -- Source player
]]
function HA_GUI_Process_GotPowerInfusion(From)
  local raider = HA_Raiders[From];

  if(raider)
  then
    if(not HA_RaiderInfused(From))
    then
      raider.overtime[HA_POWER_INFUSION] = { From = "???"; Start = GetTime(); Duration = 15; ispell = HA_SPELL_POWER_INFUSION };
      if(From == HA_PlayerName)
      then
        HA_ChatPrint(HA_CHAT_MSG_INFUSED);
        PlaySoundFile("Sound\\Doodad\\HornGoober.wav");
      end
      HA_ChatDebug(HA_DEBUG_SPELLS,"HA_GUI_Process_GotPowerInfusion : Processing since I didn't get the SpellCooldown message yet");
    end
  end
end

--[[
  HA_GUI_Process_Announce function :
   - From    : String -- Source player
   - Message : String -- Message to show
]]
function HA_GUI_Process_Announce(From,Message)
  local raider = HA_Raiders[From];

  if(raider)
  then
    RaidWarningFrame:AddMessage("[HA] "..Message, 0.2, 0.8, 0.2, 1.0);
    DEFAULT_CHAT_FRAME:AddMessage("[HA Warning] "..From..": "..Message, 0.2, 0.8, 0.2, 1.0);
    PlaySound("RaidWarning");
  end
end


--[[
  HA_GUI_Process_Version function :
   - From    : String -- Source player
   - Version : String -- Player's HA Version
]]
function HA_GUI_Process_Version(From,Version)
  local raider = HA_Raiders[From];
  if(raider)
  then
    raider.Version = Version;
  end
  if(_HA_NewVersionNotice == false and Version > HA_VERSION)
  then
    _HA_NewVersionNotice = true;
    HA_ChatPrint(HA_TEXT_MINOR_VERSION);
  end
end

--[[
  HA_GUI_Process_SpellHotTick function :
   - From       : String -- Source player
   - SpellCode  : Int    -- International Spell Code (use HA_GetLocalName to get local name)
   - TargetName : String -- Target of the heal
   - Value      : Int    -- Healed value
]]
function HA_GUI_Process_SpellHotTick(From,SpellCode,TargetName,Value)
  local SpellName = HA_GetLocalName(SpellCode);
  local healer = HA_Healers[From];
  local spell = HA_InstantSpells[SpellName];

  if(healer and spell)
  then
    HA_ChatDebug(HA_DEBUG_SPELLS,"SpellHotTick from "..From.." to "..TargetName.." with "..SpellName.." for "..tostring(Value).." hp.");
    local raider = HA_Raiders[TargetName];
    if(raider)
    then
      -- Check overhealed status
      local new_hp = _HA_GetRaiderHealthBeforeHeal(raider,Value,healer) + Value;
      local overhealed = 0;
      if(new_hp > raider.hpmax)
      then
        overhealed = new_hp - raider.hpmax;
      end

      -- Call plugins
      for n,pl in HA_ActivePlugins
      do
        if(pl.OnSpellHotTick)
        then
          pl.OnSpellHotTick(healer,raider,SpellCode,SpellName,Value,overhealed);
        end
      end
    end
  end
end


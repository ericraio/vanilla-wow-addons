--
-- LazyRogue
--
-- Scriptable Rogue attacks.
-- 
-- Copyright (c) 2005-2006 Ithilyn (Steve Kehlet)
--
-- Developers: Ithilyn, FreeSpeech
--

SLASH_LAZYROGUE1 = "/lazyrogue"
SLASH_LAZYROGUE2 = "/lr"

BINDING_HEADER_LAZYROGUE = "LazyRogue"
BINDING_NAME_LR_EXECUTE = "Execute Default Form"

lazyr = {}
lazyr.version = "3.1"
lazyr.addOnIsActive = false
lazyr.isInCombat = false
lazyr.attackSlot = nil
lazyr.eviscDamage = {
   { (7+11)/2, (13+17)/2, (19+23)/2, (25+29)/2, (31+35)/2 },
   { (16+24)/2, (29+37)/2, (42+50)/2, (55+63)/2, (68+76)/2 },
   { (29+43)/2, (52+66)/2, (75+89)/2, (98+112)/2, (121+135)/2 },
   { (47+67)/2, (84+104)/2, (121+141)/2, (158+178)/2, (195+215)/2 },
   { (69+99)/2, (123+153)/2, (177+207)/2, (231+261)/2, (285+315)/2 },
   { (104+148)/2, (186+230)/2, (268+312)/2, (350+394)/2, (432+476)/2 },
   { (158+226)/2, (282+350)/2, (406+474)/2, (530+598)/2, (654+722)/2 },
   { (216+312)/2, (384+480)/2, (552+648)/2, (720+816)/2, (888+984)/2 },
   { (242+350)/2, (430+538)/2, (618+726)/2, (806+914)/2, (994+1102)/2 },
}
lazyr.eviscComboPoints = 0
lazyr.mock = false
lazyr.behindAttackLastFailedAt = 0
lazyr.inFrontAttackLastFailedAt = 0
lazyr.lastAttacker = ""
lazyr.numberOfAttackers = 0 
lazyr.ganked= nil
lazyr.InDuel = false
lazyr.talentCache = {}
lazyr.parsedFormCache = {}
lazyr.realmName = "Unknown"
lazyr.playerName = "Unknown"
lazyr.latestEnergy = 0
lazyr.lastTickTime = 0
lazyr.targetHealthHistory = nil
lazyr.perPlayerConf = nil
lazyr.defaultForms = {}
lazyr.defaultForms.lr = { 
   "--",
   "-- This is the classic LazyRogue form.  Nice and easy.",
   "-- Sinister Strike until you have 5 combo points, then Eviscerate.",
   "-- Uncomment Riposte (remove the leading '--') if you have it.",
   "--",
   "evisc-if5cp", 
   "--riposte", 
   "ss"
}
lazyr.defaultForms.lazy1 = {
   "--",
   "-- Open with Cheap Shot.",
   "-- SS until you have 5 combo points, or enough to kill the target.",
   "-- Throw in a Kidney Shot if your health is dropping, or a Rupture",
   "-- if the guy's elite.",
   "--",
   "cs",
   "evisc-ifKillShot", 
   "ks-5cp-ifPlayer<60%hp", 
   "rupture-5cp-ifTarget>65%hp-ifNotRuptureActive-ifTargetElite", 
   "evisc-if5cp", 
   "--riposte", 
   "ss"
}
lazyr.defaultForms.lazy2 = {
   "--",
   "-- This form works well both solo and in groups.",
   "-- Note: Comment out the cbevisc entries if you don't have",
   "-- Cold Blood.",
   "--",
   "stopAll-ifVanishActive",
   "--stopAll-ifNotTargetNPC -- uncomment to avoid accidental PvP",
   "dismount-ifMounted",
   "stealth",
   "stopAll-ifTargetCCd-ifNotShiftDown",
   "vanish-ifPlayer<30%hp-ifInCombat-ifTargetOfTarget",
   "cs",
   "evisc-ifKillShot",
   "evisc-ifInGroup-ifLastChance",
   "cbEvisc-if3cp-ifCbKillShot-ifNotShiftDown",
   "kick-ifTargetIsCasting-ifNotShiftDown",
   "ks-if<3cp-ifTargetIsCasting-ifNotShiftDown",
   "gouge-ifTargetIsCasting-ifNotShiftDown",
   "ks-if5cp-ifPlayer<75%hp-ifTargetOfTarget-ifTarget>35%hp",
   "rupture-if5cp-ifTarget>75%hp-ifNotRuptureActive-ifTargetElite",
   "cbEvisc-if5cp-ifNotShiftDown",
   "evisc-if5cp",
   "snd-if=1cp-ifNotSndActive",
   "feint-ifTargetOfTarget-ifInGroup-ifNotShiftDown",
   "-- uncomment the following if you keep pulling aggro :-)",
   "--feint-ifInGroup-every15s-ifNotShiftDown",
   "--riposte", 
   "ss"
}
lazyr.defaultForms.lazy3 = {
   "--",
   "-- Here's a form I used as a Subtlety/Hemo build.",
   "-- Apply Hemo when not active, SS the rest of the time.",
   "--",
   "dismount-ifMounted",
   "--stealth",
   "stopAll-ifTargetCCd-ifNotShiftDown",
   "stopAll-ifVanishActive",
   "vanish-ifPlayer<30%hp-ifInGroup-ifInCombat-ifTargetAlive",
   "cs",
   "evisc-ifKillShot",
   "evisc-ifInGroup-ifLastChance",
   "cbEvisc-if3cp-ifCbKillShot-ifNotShiftDown",
   "kick-ifTargetIsCasting",
   "ks-if<3cp-ifTargetIsCasting",
   "gouge-ifTargetIsCasting",
   "ks-if5cp-ifPlayer<60%hp-ifTargetOfTarget-ifTarget>35%hp",
   "rupture-if5cp-ifTarget>60%hp-ifNotRuptureActive",
   "cbEvisc-if5cp-ifNotShiftDown",
   "evisc-if5cp",
   "snd-if=1cp-ifNotSndActive",
   "feint-ifTargetOfTarget-ifInGroup-ifNotShiftDown",
   "--feint-ifInGroup-every20s-ifNotShiftDown",
   "ghostly-ifNotGhostlyActive-ifTargetOfTarget",
   "hemo-ifNotHemoActive",
   "ss"
}

lrConf = {}
lrConf.confVersion = 6
lrConf.forms = {}
lrConf.forms.lr =     lazyr.defaultForms.lr
lrConf.forms.lazy1 =  lazyr.defaultForms.lazy1
lrConf.forms.lazy2 =  lazyr.defaultForms.lazy2
lrConf.forms.lazy3 =  lazyr.defaultForms.lazy3
lrConf.interruptExceptionCriteria = { 
   "-ifTargetIsCasting=^Shoot$", 
   "# The following almost always works great, but",
   "# Reportedly some mobs in Winterspring may have", 
   "# 0 mana but can still cast.", 
   "-ifTarget=0mana-ifTargetNPC", 
   "# example of possibile options",
   "#-ifTargetClass=Warrior",
   "# the following is an example for a weird boss that",
   "# behaves differently under 50% hp (no kicks)",
   "#-ifTargetNamed=Some%sMajor%sBoss-ifTarget<50%hp",
 }
lrConf.perPlayer = {}


function lazyr.OnLoad()
   local junk, englishClass = UnitClass("player")
   if (englishClass ~= "ROGUE") then
      return
   end
   lazyr.addOnIsActive = true
   this:RegisterEvent("PLAYER_ENTERING_WORLD")
   this:RegisterEvent("VARIABLES_LOADED")
   SlashCmdList["LAZYROGUE"] = lazyr.SlashCommand
   lazyr.chat("LazyRogue v"..lazyr.version.." loaded.")
end

function lazyr.OnEvent()
   if (event == "PLAYER_ENTERING_WORLD") then

      this:RegisterEvent("PLAYER_ENTER_COMBAT")
      this:RegisterEvent("PLAYER_LEAVE_COMBAT")
      this:RegisterEvent("PLAYER_TARGET_CHANGED")
      this:RegisterEvent("PLAYER_REGEN_DISABLED")
      this:RegisterEvent("PLAYER_REGEN_ENABLED")
      this:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
      this:RegisterEvent("SPELLS_CHANGED")
      this:RegisterEvent("UI_ERROR_MESSAGE")
	
      -- Deathstimator
      lazyr.targetHealthHistory = lazyr.deathstimator.HealthHistory:New()
      this:RegisterEvent("UNIT_HEALTH")

      -- isLastChance
      this:RegisterEvent("UNIT_ENERGY")

      -- Eviscerate tracking
      this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
      if (not lazyr.UseActionOrig) then
         lazyr.UseActionOrig = UseAction
         UseAction = lazyr.et.UseActionHook
      end

      -- Casting interrupts
      -- PvE
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
      this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
      -- PvP
      this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
      this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")

      -- Attacker tracking
      this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
      this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS")
      this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")

      --WG flag tracking
      this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
      this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")

      --duel detection
      this:RegisterEvent("CHAT_MSG_SYSTEM")

   elseif (event == "VARIABLES_LOADED") then
      lazyr.realmName = GetRealmName()
      lazyr.playerName = UnitName("player")

      -- our chance to upgrade any old saved variables
      if (lrConf.confVersion < 2) then
         lrConf.confVersion = 2
         lrConf.mmIsVisible = true
      end

      if (lrConf.confVersion < 3) then
         lrConf.confVersion = 3
         lrConf.minionHidesOutOfCombat = false
         lrConf.forms.lr =       lazyr.defaultForms.lr
         lrConf.forms.lazy1 =  lazyr.defaultForms.lazy1
         lrConf.forms.lazy2 =  lazyr.defaultForms.lazy2
         if (lrConf.defaultForm == "solo1") then
            lrConf.defaultForm = "lr"
         elseif (lrConf.defaultForm == "solo2") then
            lrConf.defaultForm = "lr"
         elseif (lrConf.defaultForm == "solo3") then
            lrConf.defaultForm = "lr"
         elseif (lrConf.defaultForm == "party1") then
            lrConf.defaultForm = "lr"
         elseif (lrConf.defaultForm == "party2") then
            lrConf.defaultForm = "lr"
         end
      end

      if (lrConf.confVersion < 4) then
         lrConf.confVersion = 4
         lrConf.perPlayer = {}
         lrConf.deathMinionIsVisible = false
         lrConf.deathMinionHidesOutOfCombat = false
      end

      -- beginning with data version 4 we store per player
      if (not lrConf.perPlayer[lazyr.realmName]) then
         lrConf.perPlayer[lazyr.realmName] = {}
      end
      if (not lrConf.perPlayer[lazyr.realmName][lazyr.playerName]) then
         -- first time this player has used LazyRogue, set him up
         lrConf.perPlayer[lazyr.realmName][lazyr.playerName] = {}
      end
      -- quick reference for convenience
      lazyr.perPlayerConf = lrConf.perPlayer[lazyr.realmName][lazyr.playerName]

      if (lrConf.confVersion < 5) then
         lrConf.confVersion = 5
         lrConf.interruptExceptionCriteria = { 
   "-ifTargetIsCasting=^Shoot$", 
   "# The following almost always works great, but",
   "# Reportedly some mobs in Winterspring may have", 
   "# 0 mana but can still cast.", 
   "-ifTarget=0mana-ifTargetNPC", 
   "# example of possibile options",
   "#-ifTargetClass=Warrior",
   "# the following is an example for a weird boss that",
   "# behaves differently under 50% hp (no kicks)",
   "#-ifTargetNamed=Some%sMajor%sBoss-ifTarget<50%hp",
         }

         -- migrate all these options to per-player
         lazyr.perPlayerConf.debug = lrConf.debug
         lazyr.perPlayerConf.minionIsVisible = lrConf.minionIsVisible
         lazyr.perPlayerConf.minionHidesOutOfCombat = lrConf.minionHidesOutOfCombat
         lazyr.perPlayerConf.deathMinionIsVisible = lrConf.deathMinionIsVisible
         lazyr.perPlayerConf.deathMinionHidesOutOfCombat = lrConf.deathMinionHidesOutOfCombat
         lazyr.perPlayerConf.minimapButtonPos = lrConf.minimapButtonPos
         lazyr.perPlayerConf.mmIsVisible = lrConf.mmIsVisible
         lazyr.perPlayerConf.defaultForm = lrConf.defaultForm
         lrConf.debug = nil
         lrConf.minionIsVisible = nil
         lrConf.minionHidesOutOfCombat = nil
         lrConf.deathMinionIsVisible = nil
         lrConf.deathMinionHidesOutOfCombat = nil
         lrConf.minimapButtonPos = nil
         lrConf.mmIsVisible = nil
         lrConf.defaultForm = nil
      end

      local perPlayerDefaults = {
         ["autoTarget"] = true,
         ["deathMinionHidesOutOfCombat"] = false,
         ["deathMinionIsVisible"] = false,
         ["debug"] = false,
         ["defaultForm"] = "lr",
         ["eviscTracker"] = { {0,0}, {0,0}, {0,0}, {0,0}, {0,0} },
         ["eviscerateSample"] = 25,
         ["healthHistorySize"] = 5,
         ["initiateAutoAttack"] = true,
         ["minimapButtonPos"] = 0,
         ["minionHidesOutOfCombat"] = false,
         ["minionIsVisible"] = true,
         ["mmIsVisible"] = true,
         ["showTargetCasts"] = false,
         ["showReasonForTargetCCd"] = true,
         ["trackEviscCrits"] = false,
         ["useEviscTracking"] = true,
         ["useImmunities"] = true,
         ["Immunities"] = {} ,
      }
      for var, val in perPlayerDefaults do
         if (lazyr.perPlayerConf[var] == nil) then
            lazyr.perPlayerConf[var] = val
         end
      end

      if (lrConf.confVersion < 6) then
         lrConf.confVersion = 6
         if (not lrConf.forms.lr) then
            lrConf.forms.lr = lazyr.defaultForms.lr
         end
         lrConf.forms.lazy1 = lazyr.defaultForms.lazy1
         lrConf.forms.lazy2 = lazyr.defaultForms.lazy2
         lrConf.forms.lazy3 = lazyr.defaultForms.lazy3
      end

      -- upgrades done
      
      lazyr.minion.SetText(lazyr.perPlayerConf.defaultForm)
      if (lazyr.perPlayerConf.minionIsVisible) then
         LazyRogueMinionFrame:Show()
      end
      lazyr.deathstimator.minion.SetText("Deathstimator")
      if (lazyr.perPlayerConf.deathMinionIsVisible) then
         LazyRogueDeathstimatorFrame:Show()
      end

   elseif (event == "CHAT_MSG_SYSTEM") then
      if lazyr.re(arg1,lrLocale.DUEL_COUNTDOWN) then
         if lazyr.match1 == "3" then
            lazyr.InDuel = true
            lazyr.d("Entering Duel")
         end
      elseif lazyr.re(arg1,lrLocale.DUEL_WINNER_KNOCKOUT) or lazyr.re(arg1,lrLocale.DUEL_WINNER_RETREAT) then
         if lazyr.match1 == UnitName("player") or lazyr.match2 == UnitName("player") then
            lazyr.InDuel = false
            lazyr.d("Leaving Duel")
         end
      end
  
   elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE" then
      if (lrLocale.BGWGTEXT0) then
         if string.find(GetZoneText(), lrLocale.BGWGTEXT0) then
            if lazyr.re(arg1,string.format(lrLocale.BGWGTEXT1,UnitFactionGroup("player"))) then
               lazyr.flagHolder = lazyr.match1
               lazyr.d(tostring("|cffe5e519WG Flag Holder: "..lazyr.flagHolder))
            elseif string.find(arg1,string.format(lrLocale.BGWGTEXT2,UnitFactionGroup("player"))) or string.find(arg1,string.format(lrLocale.BGWGTEXT3,UnitFactionGroup("player"))) or string.find(arg1,string.format(lrLocale.BGWGTEXT4,UnitFactionGroup("player"))) then
               lazyr.d(tostring("|cffe5e519WG Flag Holder: Empty"))
               lazyr.flagHolder = ""
            end		
         end
      end
      
   elseif (event == "CHAT_MSG_COMBAT_SELF_HITS") then
      if lazyr.ganked==nil then
         lazyr.ganked = false
      end

   elseif (event == "PLAYER_ENTER_COMBAT") then
      lazyr.ResetEveryTimers()
   elseif (event == "PLAYER_LEAVE_COMBAT") then
      --do nothing
   elseif (event == "PLAYER_TARGET_CHANGED") then
      lazyr.interrupt.targetCasting = nil
      lazyr.ResetEveryTimers()
      lazyr.targetHealthHistory:Reset()
   elseif (event == "PLAYER_REGEN_DISABLED") then
      lazyr.isInCombat = true
      lazyr.minion.OnUpdate()  -- force refresh, in case it's hidden
      lazyr.deathstimator.minion.OnUpdate()  -- force refresh, in case it's hidden
	  
   elseif (event == "PLAYER_REGEN_ENABLED") then
      lazyr.isInCombat = false
      lazyr.minion.SetText(lazyr.perPlayerConf.defaultForm)
      lazyr.deathstimator.minion.SetText("Deathstimator")

      if lazyr.numberOfAttackers ~= 0 then
         if lazyr.ganked==true  then
            if lrLocale.GANKED~=nil then
               lazyr.p(tostring("|cffe5e519"..string.format(lrLocale.GANKED,lazyr.lastAttacker,lazyr.numberOfAttackers)))
            end
         else
            lazyr.d(tostring("|cffe5e519PVP Opponents:"..lazyr.lastAttacker.." Count:"..lazyr.numberOfAttackers))
         end
      end
      lazyr.lastAttacker = ""
      lazyr.numberOfAttackers = 0
      lazyr.ganked=nil
      
   elseif (event == "ACTIONBAR_SLOT_CHANGED") then
      lazyr.DeCacheActionSlotIds()
      lazyr.attackSlot = nil
      lazyr.globalCooldownSlot = nil
	  
   elseif (event == "SPELLS_CHANGED") then
      lazyr.DeCacheActionRanks()
   elseif (event == "UI_ERROR_MESSAGE") then
      if (arg1 == SPELL_FAILED_NOT_BEHIND) then
         lazyr.d("I see your behind-only attack just failed, will wait to use it again.")
         lazyr.behindAttackLastFailedAt = GetTime()
      elseif (arg1 == SPELL_FAILED_NOT_INFRONT) then
         lazyr.d("I see your infront-only attack just failed, will wait to use it again.")
         lazyr.inFrontAttackLastFailedAt = GetTime()
      end

   elseif (event == "UNIT_ENERGY") then
      if (arg1 == "player") then
         local currentEnergy = UnitMana("player")
         if (currentEnergy > lazyr.latestEnergy) then
            -- a tick
            lazyr.lastTickTime = GetTime()
            --lazyr.d("ENERGY TICK: "..lazyr.lastTickTime)
         end
         lazyr.latestEnergy = currentEnergy
      end
         
   elseif (event == "UNIT_HEALTH") then
      lazyr.deathstimator.OnUnitHealth(arg1)

   elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
      if string.find(arg1, lrLocale.EVISCERATE_HIT ) then
         lazyr.et.TrackEviscerates(arg1)
      end
      if (lrLocale.IMMUNE) then
         if string.find(arg1, lrLocale.IMMUNE ) then
            lazyr.WatchForImmunes(arg1)
         end
      end
      
   elseif (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" or 
           event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or
           event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" or 
           event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or 
           event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then

      -- have to lump these two together since
      -- CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE is used by both attacker
      -- tracking and PvP kick support.

      if (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" or 
          event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then

         if (lrLocale.GANKED_CHATS) then
            for idx, regex in lrLocale.GANKED_CHATS do
               if (lazyr.re(arg1, regex)) then
                  if lazyr.ganked==nil then
                     lazyr.ganked = true
                  end
                  player = lazyr.match1

                  if not(string.find(lazyr.lastAttacker," "..player..",")) then
                     lazyr.numberOfAttackers = lazyr.numberOfAttackers + 1
                     lazyr.lastAttacker = lazyr.lastAttacker.." "..player..","
                  end
               end
            end
         end
      end

      if (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or
          event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" or 
          event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or 
          event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
         lazyr.interrupt.OnChatMsgSpell(arg1)
      end

   else
      lazyr.d("Unhandled event: "..event..": ")
   end
end     

function lazyr.Help()
   lazyr.chat("LazyRogue v"..lazyr.version..".")
   lazyr.chat("/lazyrogue do <attack1> [<attack2> ...]")
   lazyr.chat("/lazyrogue list")
   lazyr.chat("/lazyrogue edit <formName>")
   lazyr.chat("/lazyrogue set <formName> <attack1> [<attack2> ...]")
   lazyr.chat("/lazyrogue copy <formName> <formName2>")
   lazyr.chat("/lazyrogue clear <formName>")
   lazyr.chat("/lazyrogue default [<formName>]")
   lazyr.chat("/lazyrogue [<formName>]")
   lazyr.chat("/lazyrogue summon")
   lazyr.chat("/lazyrogue dismiss")
   lazyr.chat("/lazyrogue hideMinionOutOfCombat")
   lazyr.chat("/lazyrogue summonDeath")
   lazyr.chat("/lazyrogue dismissDeath")
   lazyr.chat("/lazyrogue hideDeathMinionOutOfCombat")
   lazyr.chat("/lazyrogue mmshow")
   lazyr.chat("/lazyrogue mmhide")
   lazyr.chat("/lazyrogue useEviscerateTracking")
   lazyr.chat("/lazyrogue resetEviscerateStats")
   lazyr.chat("/lazyrogue interruptExceptionCriteria")
   lazyr.chat("/lazyrogue noLongerInterruptLastInterrupted")
   lazyr.chat("/lazyrogue showTargetCasts")
   lazyr.chat("/lazyrogue autoTarget")
   lazyr.chat("/lazyrogue initiateAutoAttack")
   lazyr.chat("/lazyrogue about")
   lazyr.chat("/lazyrogue help")
   lazyr.chat("/lazyrogue assist <playername>")
   lazyr.chat("/lazyrogue useImmunitiesList")
   lazyr.chat("/lazyrogue clearImmunitiesList")
   lazyr.chat("/lazyrogue showImmunitiesList")
   
end

function lazyr.ListForms()
   -- sigh, table.sort() sorts the values, no way to sort by keys...
   local formNames = {}
   for form, actions in lrConf.forms do
      table.insert(formNames, form)
   end

   table.sort(formNames)

   for idx, formName in formNames do
      local name = formName
      local actions = lrConf.forms[formName]

      if (lazyr.perPlayerConf.defaultForm and formName == lazyr.perPlayerConf.defaultForm) then
         name = "*"..name
      end
      lazyr.chat(name..": "..table.concat(actions, ' '))
   end
end

function lazyr.SlashCommand(line)
   if (not line) then
      line = ""
   end
   local args = lazyr.SplitArgs(line)
   local cmd = args[1]
   table.remove(args, 1)

   if (cmd == "help") then
      lazyr.Help()

   elseif (cmd == "about") then
      LazyRogueAboutFrame:Show()

   elseif (cmd == "debug") then
      if (lazyr.perPlayerConf.debug) then
         lazyr.perPlayerConf.debug = false
         lazyr.p("Debugging off.")
      else
         lazyr.perPlayerConf.debug = true
         lazyr.p("Debugging on.")
      end

   elseif (cmd == "list") then
      lazyr.ListForms()

   elseif (cmd == "edit") then
      local form = args[1]
      LazyRogueFormEditFrame:Hide()
      lazyr.lreb.currentForm = form
      LazyRogueFormScrollFrame:SetWidth(LazyRogueFormEditFrame:GetWidth()-50);
  LazyRogueFormEditFrameForm:SetWidth(LazyRogueFormScrollFrame:GetWidth()-50);
 LazyRogueFormScrollFrame:SetHeight(LazyRogueFormEditFrame:GetHeight()-110);
  LazyRogueFormEditFrameForm:SetHeight(LazyRogueFormScrollFrame:GetHeight()-110);
 LazyRogueFormEditFrame:Show()

   elseif (cmd == "set") then
      local form = args[1]
      table.remove(args, 1)
      local verb
      if (lrConf.forms[form]) then
         verb = "updated"
      else
         verb = "created"
      end
      lrConf.forms[form] = args
      lazyr.ClearParsedForm(form)
      lazyr.p("Form "..form.." "..verb..".")
      lazyr.ParseForm(args)

   elseif (cmd == "copy") then
      local form1 = args[1]
      local form2 = args[2]
      --lrConf.forms[form2] = form1
      if (not lrConf.forms[form1]) then
         lazyr.p("Form "..form1.." doesn't exist.")
         return false
      end
      -- I'm not sure exactly how lua works.. but I think I can't just
      -- point form2 to form1's actions, because it's by reference, and
      -- then any changes to form1 would affect form2.  So copy...
      local newActions = {}
      for idx, action in lrConf.forms[form1] do
         table.insert(newActions, action)
      end
      lrConf.forms[form2] = newActions
      lazyr.p("Form "..form1.." copied to form "..form2..".")

   elseif (cmd == "clear") then
      local form = args[1]
      -- destroy this form entry
      -- this is how you do it in Lua, just set its value to nil
      lrConf.forms[form] = nil
      lazyr.ClearParsedForm(form)
      lazyr.p("Form "..form.." removed.")
      if (lazyr.perPlayerConf.defaultForm == form) then
         if (lrConf.forms.lr) then
            lazyr.perPlayerConf.defaultForm = "lr"
            lazyr.p("Default form is now lazyr.")
         else
            lazyr.perPlayerConf.defaultForm = nil
            lazyr.p("WARNING: you no longer have a default form.  Choose one from the LR minimap bubble.")
         end
      end

   elseif (cmd == "do") then
      local actions = lazyr.ParseForm(args)
      if (actions) then
         lazyr.TryActions(actions)
      end

   elseif (cmd == "autoTarget") then
      if (lazyr.perPlayerConf.autoTarget) then
         lazyr.perPlayerConf.autoTarget = false
         lazyr.p("LazyRogue will no longer auto-target.")
         -- turning off autotargeting also means turning off initiating auto-attack
         if (lazyr.perPlayerConf.initiateAutoAttack) then
            lazyr.SlashCommand("initiateAutoAttack")
         end
      else
         lazyr.perPlayerConf.autoTarget = true
         lazyr.p("LazyRogue will now auto-target.")
      end

   elseif (cmd == "initiateAutoAttack") then
      if (lazyr.perPlayerConf.initiateAutoAttack) then
         lazyr.perPlayerConf.initiateAutoAttack = false
         lazyr.p("LazyRogue will no longer initiate auto-attack.")
      else
         lazyr.perPlayerConf.initiateAutoAttack = true
         lazyr.p("LazyRogue will now initiate auto-attack.")
      end

   elseif (cmd == "showImmunitiesList") then
      lazyr.p("Current Immunities List...")
      for action in lazyr.perPlayerConf.Immunities do
         for mob in lazyr.perPlayerConf.Immunities[action] do
            lazyr.p("Action ["..action.."] Immune To ["..mob.."]")
         end
      end

   elseif (cmd == "useImmunitiesList") then
      if (lazyr.perPlayerConf.useImmunities) then
         lazyr.perPlayerConf.useImmunities = false
         lazyr.p("LazyRogue will no longer check for immunities.")
      else
         lazyr.perPlayerConf.useImmunities = true
         lazyr.p("LazyRogue will now check for immunities.")
      end

   elseif (cmd == "clearImmunitiesList") then
      lazyr.perPlayerConf.Immunities = {}
      lazyr.p("Immunities list cleared.")
      
   elseif (cmd == "summon") then
      lazyr.perPlayerConf.minionIsVisible = true
      LazyRogueMinionFrame:Show()
      lazyr.p("Now showing the minion.")

   elseif (cmd == "dismiss") then
      lazyr.perPlayerConf.minionIsVisible = false
      LazyRogueMinionFrame:Hide()
      lazyr.p("Hiding the minion.")

   elseif (cmd == "hideMinionOutOfCombat") then
      if (lazyr.perPlayerConf.minionHidesOutOfCombat) then
         lazyr.perPlayerConf.minionHidesOutOfCombat = false
         LazyRogueMinionFrame:Show()
         lazyr.p("Minion will no longer hide out of combat.")
      else
         lazyr.perPlayerConf.minionHidesOutOfCombat = true
         lazyr.p("Minion will now hide out of combat.")
      end

   elseif (cmd == "summonDeath") then
      lazyr.perPlayerConf.deathMinionIsVisible = true
      LazyRogueDeathstimatorFrame:Show()
      lazyr.p("Now showing the deathstimator minion.")

   elseif (cmd == "dismissDeath") then
      lazyr.perPlayerConf.deathMinionIsVisible = false
      LazyRogueDeathstimatorFrame:Hide()
      lazyr.p("Hiding the deathstimator minion.")

   elseif (cmd == "hideDeathMinionOutOfCombat") then
      if (lazyr.perPlayerConf.deathMinionHidesOutOfCombat) then
         lazyr.perPlayerConf.deathMinionHidesOutOfCombat = false
         LazyRogueDeathstimatorFrame:Show()
         lazyr.p("Death minion will no longer hide out of combat.")
      else
         lazyr.perPlayerConf.deathMinionHidesOutOfCombat = true
         lazyr.p("Death minion will now hide out of combat.")
      end

   elseif (cmd == "showReasonForTargetCCd") then
      if (lazyr.perPlayerConf.showReasonForTargetCCd) then
         lazyr.perPlayerConf.showReasonForTargetCCd = false
         lazyr.p("No longer showing why LR thinks a target is CCd")
      else
         lazyr.perPlayerConf.showReasonForTargetCCd = true
         lazyr.p("Now showing why LR thinks a target is CCd")
      end

   elseif (cmd == "mmshow") then
      lazyr.perPlayerConf.mmIsVisible = true
      LazyRogueMinimapFrame:Show()
      LazyRogueMinimapButton:Show()

   elseif (cmd == "mmhide") then
      lazyr.perPlayerConf.mmIsVisible = false
      LazyRogueMinimapFrame:Hide()
      LazyRogueMinimapButton:Hide()

   elseif (cmd == "resetEviscerateStats") then
      lazyr.et.ResetEviscTracking()

   elseif (cmd == "useEviscerateTracking") then
      if (lazyr.perPlayerConf.useEviscTracking) then
         lazyr.perPlayerConf.useEviscTracking = false
         lazyr.p("No longer using Eviscerate tracking.")
      else
         lazyr.perPlayerConf.useEviscTracking = true
         lazyr.p("Now using Eviscerate tracking.")
      end

   elseif (cmd == "trackEviscCrits") then
      if (lazyr.perPlayerConf.trackEviscCrits) then
         lazyr.perPlayerConf.trackEviscCrits = false
         lazyr.p("No longer tracking Eviscerate crits.")
      else
         lazyr.perPlayerConf.trackEviscCrits = true
         lazyr.p("Now tracking Eviscerate crits.")
      end

   elseif (cmd == "interruptExceptionCriteria") then
      LazyRogueInterruptExceptionCriteriaEditFrame:Show()

   elseif (cmd == "noLongerInterruptLastInterrupted") then
      if (not lazyr.interrupt.lastSpellInterrupted) then
         lazyr.p("You haven't interrupted anything recently.")
      else
         local lastInterrupted = string.gsub(lazyr.interrupt.lastSpellInterrupted, 
                                             "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
         lastInterrupted = string.gsub(lastInterrupted, "%s", "%%s")
         local criteria = "-ifTargetIsCasting=^"..lastInterrupted.."$"
         table.insert(lrConf.interruptExceptionCriteria, criteria)
         lazyr.p("Added new exception ("..criteria..") to global interrupt criteria.")
      end

   elseif (cmd == "showTargetCasts") then
      if (lazyr.perPlayerConf.showTargetCasts) then
         lazyr.perPlayerConf.showTargetCasts = false
         lazyr.p("No longer showing when the target casts.")
      else
         lazyr.perPlayerConf.showTargetCasts = true
         lazyr.p("Now showing when the target casts.")
      end

   elseif (cmd == "assist") then
      if UnitIsPlayer("target") and UnitIsFriend("target","player") and UnitName("target")~=UnitName("player") then
         if UnitName("target")  then
            lazyr.assistName = UnitName("target")
            if lazyr.masks.PlayerInRaid() then
               SendChatMessage("Assist set to "..UnitName("target"), "Raid");
            elseif lazyr.masks.PlayerInGroup() then
               SendChatMessage("Assist set to "..UnitName("target"), "Party");
            else
               SendChatMessage("Assist set to "..UnitName("target"), "Say");
            end
         else
            lazyr.assistName = args[2]
            lazyr.p("Assist set to "..UnitName("target"))
         end
      else
         lazyr.p("Target Assist Not Set!")
      end

   elseif (cmd == "default") then
      local form = args[1]
      if (form) then
         local actions = lazyr.FindForm(form)
         if (not actions) then
            lazyr.p("Form "..form.." not found.")
            return false
         end
         lazyr.perPlayerConf.defaultForm = form
         lazyr.p("Default form is now "..form)
      else
         lazyr.p("Default form is "..lazyr.nonil(lazyr.perPlayerConf.defaultForm))
      end
      lazyr.minion.SetText(lazyr.perPlayerConf.defaultForm)

   elseif (not cmd or cmd == "") then
      if (not lazyr.perPlayerConf.defaultForm) then
         lazyr.p("No default form assigned, use /lazyrogue default <form> to set one.")
         return false
      end
      local actions = lazyr.FindParsedForm(lazyr.perPlayerConf.defaultForm)
      if (not actions) then
         lazyr.p("Your default form is "..lazyr.perPlayerConf.defaultForm..", but it doesn't exist!  Please choose a form from the LR bubble.")
         return false
      end
      lazyr.TryActions(actions)

   else
      local actions = lazyr.FindParsedForm(cmd)
      if (not actions) then
         lazyr.p("Form "..cmd.." not found.  Try /lazyrogue help for help.")
         return false
      end
      if (actions) then
         lazyr.TryActions(actions)
      end

   end
end

-- previous API for compatibility
function LazyRogue()
   lazyr.SlashCommand()
end


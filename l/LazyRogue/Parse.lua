-- Masks

-- These look a little ugly but the idea is decent...
lazyr.masks = {}

-- klugy, but hey
lazyr.masks.alreadyInsideInterruptExceptionCriteria = false

function lazyr.masks.negWrapper(f, negate)
   return function()
             local r = f()
             return ((r and not negate) or (not r and negate))
          end
end

-- returns a super mask.  Returns true if any of the given masks are true (an "OR").
-- however if negate is true, then returns true only if ALL of then given masks are false ("AND")
function lazyr.masks.maskGroup(masks, negate)
   return function()
             if (not negate) then
                for idx, mask in masks do
                   if (mask()) then
                      return true
                   end
                end
                return false
             else
                for idx, mask in masks do
                   if (mask()) then
                      return false
                   end
                end
                return true
             end
          end
end


function lazyr.masks.ComboPoints(cp, gtLtEq)
   cp = tonumber(cp)
   return function() 
             if (not gtLtEq or gtLtEq == "") then
                return (GetComboPoints() >= cp)
             end
             if (gtLtEq == ">") then
                return (GetComboPoints() > cp)
             elseif (gtLtEq == "=") then
                return (GetComboPoints() == cp)
             else
                return (GetComboPoints() < cp)
             end
          end
end

function lazyr.masks.IsBeingGanked()
   return function() 
             return lazyr.ganked
          end
end

function lazyr.masks.DebuffSpace()
   return function()
             if UnitExists("target") then
                for i=1,16 do
                   s=UnitDebuff("target", i)
                   if (not s) then
                      return true
                   end
                end 
             end
             return false	
          end
end

function lazyr.masks.IsImmune(action)
   return function()
             if (lazyr.perPlayerConf.Immunities[action] and lazyr.perPlayerConf.Immunities[action][UnitName("target")]) then
                if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                   lazyr.p("-ifTargetImmune:  "..UnitName("target").." has immunity to "..action)
                end
                return true
             end
             return false
          end
end


function lazyr.masks.IsFlagRunner()
   return function() 
             if (not lrLocale.BGWGTEXT0) then
                lazyr.p("Sorry, ifFlagRunner not supported for your locale.")
                return false
             end
             if (UnitName("target")==lazyr.flagHolder) and UnitExists("target") then
                return true
             else
                return false
             end
          end
end

function lazyr.masks.IsFlaggedPVP(unit)
   return function() 
             if unit ~= "Target" then
                if UnitIsPVP("player") then
                   return true
                else
                   return false
                end
             else
                if (UnitIsPVP("target") and UnitIsEnemy("target","player") and UnitExists("target")) then
                   return true
                else
                   return false
                end
             end
          end
end

function lazyr.masks.IsDueling()
   return function() 
             return lazyr.InDuel
          end
end


function lazyr.masks.IsBeingAttackedBy(num, gtLtEq)
   num = tonumber(num)
   return function() 
             if (not gtLtEq or gtLtEq == "") then
                return (lazyr.numberOfAttackers >= num)
             end
             if (gtLtEq == ">") then
                return (lazyr.numberOfAttackers > num)
             elseif (gtLtEq == "=") then
                return (lazyr.numberOfAttackers == num)
             else
                return (lazyr.numberOfAttackers < num)
             end
          end
end

function lazyr.masks.IsTargetOfTarget()
   return function() 
             return UnitIsUnit("player", "targettarget")
          end
end

function lazyr.masks.IsTargetOfTargetClass(class)
   return function()
             return (class == UnitClass("targettarget"))
          end
end


-- :-(
function lazyr.masks.IsStealthed()
   local icon, name, active, castable = GetShapeshiftFormInfo(1)
   return (active == 1)
end

function lazyr.masks.IsStealthedMask()
   return function()
             return lazyr.masks.IsStealthed()
          end
end

function lazyr.masks.BehindAttackHasNotFailedRecently()
   return function() 
             return ((GetTime() - lazyr.behindAttackLastFailedAt) >= .3)
          end
end

function lazyr.masks.BehindAttackFailedRecently()
   return function() 
             return ((GetTime() - lazyr.behindAttackLastFailedAt) < .3)
          end
end

function lazyr.masks.InFrontAttackHasNotFailedRecently()
   return function() 
             return ((GetTime() - lazyr.inFrontAttackLastFailedAt) >= .3)
          end
end

function lazyr.masks.InFrontAttackFailedRecently()
   return function() 
             return ((GetTime() - lazyr.inFrontAttackLastFailedAt) < .3)
          end
end

function lazyr.masks.InCooldown(action)
   return function()
             local actionInfo = lazyr.ParseArg(action)
             if (not actionInfo) then
                return false
             end
             local action = actionInfo[1]
             local start, duration, enable = GetActionCooldown(action:GetSlot());
             if ( (duration - (GetTime() - start)) > 1) then
                return true
             else
                return false
             end
          end
end

-- :-(
function lazyr.masks.FindTalentPoints(icon)
   -- Okay, there is no event that gets fired when talents have changed, so
   -- normally we'd need to scan the talent tree every single time.
   -- Instead, for fun, we cache talent point lookups for 1 minute.  Not sure
   -- how much this really helps performance, but hey.

   local cacheInfo = lazyr.talentCache[icon]
   if (cacheInfo) then
      local time = cacheInfo[1]
      local rank = cacheInfo[2]
      if (time and time > (GetTime() - 60)) then
         return rank
      end
   end

   rank = 0
   for i = 1, GetNumTalentTabs() do
      for j = 1, GetNumTalents(i) do
         local name, thisIcon, _, _, rank, max = GetTalentInfo(i, j)
         if (thisIcon and string.find(thisIcon, icon)) then
            lazyr.talentCache[icon] = {GetTime(), rank}
            return rank
         end
      end
   end
   
   lazyr.talentCache[icon] = {GetTime(), 0}
   return 0
end

-- :-(
function lazyr.masks.CalculateBaseEviscDamage(cp)
   -- find eviscerate rank
   -- lookup damage cp using damage table
   local rank = lazyr.actions.eviscerate:GetRank()
   if (rank == 0) then
      return false
   end
   local eviscDamage = lazyr.eviscDamage[rank][cp]
   if (not eviscDamage) then
      lazyr.p("strange, damage lookup failed")
      return false
   end
   --origEviscDamage = eviscDamage
   
   -- adjust for Improved Eviscerate, if invested
   local ieAdjust = { 1.05, 1.1, 1.15 }
   local tpts = lazyr.masks.FindTalentPoints("Ability_Rogue_Eviscerate")
   if (tpts > 0) then
      eviscDamage = eviscDamage * ieAdjust[tpts]
   end
   
   -- adjust for Aggression, if invested
   local aggrAdjust = { 1.02, 1.04, 1.06 }
   local tpts = lazyr.masks.FindTalentPoints("Ability_Racial_Avatar")
   if (tpts > 0) then
      eviscDamage = eviscDamage * aggrAdjust[tpts]
   end

   return eviscDamage
end

-- :-(
function lazyr.masks.CalculateObservedEviscDamage(cp)
   if (lazyr.perPlayerConf.useEviscTracking) then
      local observedDamage, observedCt = lazyr.et.GetEviscTrackingInfo(cp)
      if (observedCt > 0) then
         --lazyr.d("Calculate Evisc Dmg: Using the OBSERVED Evisc ("..cp.."cp) damage of: "..observedDamage)
         return observedDamage
      end
   end

   local dmg = lazyr.masks.CalculateBaseEviscDamage(cp)
   --lazyr.d("Calculate Evisc Dmg: Using the OPTIMAL Evisc ("..cp.."cp) damage of: "..dmg)
   return dmg
end

function lazyr.masks.IsEviscKillShot(assumeCBActive, goalPct)
   return function()
             local cp = GetComboPoints()
             if (cp == 0) then
                return false
             end

             local hp = lazyr.masks.GetUnitHealth("target")
             -- adjust hp for goalPct
             if (goalPct ~= 100) then
                hp = hp * (goalPct / 100)
             end

             local eviscDamage = lazyr.masks.CalculateObservedEviscDamage(cp)

             -- adjust for Cold Blood, if we're asked to, or if active
             if (assumeCBActive or lazyr.masks.HasBuffOrDebuff("player", "buff", 
                                                               lazyr.actions.coldBlood.texture, 
                                                               lrLocale.BUFF_TTS.coldBlood)) then
                -- Cold Blood guarantees a crit (if it hits)
                eviscDamage = eviscDamage * 2
             end
             
             --lazyr.d("Adjusted evisc dmg: "..origEviscDamage.." vs "..eviscDamage)
             --lazyr.d("Avg evisc dmg with "..cp.." combo points is "..eviscDamage..", vs: "..hp)
             if (hp <= eviscDamage) then
                if (cp < 5) then
                   lazyr.d("Early eviscerate! Kill shot!")
                end
                return true
             else
                return false
             end
          end
end

-- :-(
-- supported unitIds: player, (enemy) target
function lazyr.masks.GetUnitHealth(unitId, wantPct)
   if (unitId == "player") then
      if (wantPct) then
         return (UnitHealth(unitId) / UnitHealthMax(unitId)) * 100
      else
         return UnitHealth(unitId)
      end
   elseif (unitId == "target") then
      if (wantPct) then
         return UnitHealth(unitId)
      else
         if (not MobHealth_GetTargetCurHP) then
            lazyr.p("MobInfo2 (or equivalent) not installed, can't determine target's HP.")
            -- return something huge
            return 1000000
         end
         local hp = MobHealth_GetTargetCurHP()
         if (not hp or hp == 0) then
            -- no mob info, return something huge
            hp = 1000000
         end
         return hp
      end
   end
end

-- :-(
-- returns mana, energy, or rage
function lazyr.masks.GetUnitMana(unitId, wantPct)
   -- mana is different than health, we get actual values for everything, even enemies
   if (wantPct) then
      return (UnitMana(unitId) / UnitManaMax(unitId)) * 100
   else
      return UnitMana(unitId)
   end
end

function lazyr.masks.UnitPowerMask(unitId, gtLtEq, val, powerType, wantPct)
   return function()
             local compareVal = 0

             if (powerType == "hp") then
                compareVal = lazyr.masks.GetUnitHealth(unitId, wantPct)
             elseif (powerType == "mana" or powerType == "energy") then
                compareVal = lazyr.masks.GetUnitMana(unitId, wantPct)
             end

             if (gtLtEq == ">") then
                return (compareVal > val)
             elseif (gtLtEq == "=") then
                return (compareVal == val)
             else
                return (compareVal < val)
             end
          end
end



-- :-(
--
-- Checking buffs/debuffs is fun!
-- We accept one or more of:
-- - the buff/debuff texture
-- - the Tooltip title
-- - a line found inside the body of the tooltip.
--
function lazyr.masks.HasBuffOrDebuff(unitId, buffOrDebuff, texture, ttTitle, ttBody)
   local candidates = {}
   local buffId = 1
   while true do
      local thisTexture
      if (buffOrDebuff == "buff") then
         thisTexture = UnitBuff(unitId, buffId)
      else
         thisTexture = UnitDebuff(unitId, buffId)
      end
      if (not thisTexture) then
         break
      end

      if (not texture) then
         -- no texture criteria given, so just add to list of candidates
         candidates[buffId] = true

      elseif (string.find(thisTexture, texture)) then
         lazyr.d("HasBuffOrDebuff: found texture "..texture.." at buffId: "..buffId)
         candidates[buffId] = true

      else
         candidates[buffId] = false
      end
      buffId = buffId + 1
   end

   if (ttTitle) then
      for buffId, isCandidate in ipairs(candidates) do
         if (isCandidate) then
            LazyRogue_Tooltip:ClearLines()
            if (buffOrDebuff == "buff") then
               LazyRogue_Tooltip:SetUnitBuff(unitId, buffId)
            else
               LazyRogue_Tooltip:SetUnitDebuff(unitId, buffId)
            end
            local thisTTTitle = LazyRogue_TooltipTextLeft1:GetText()
            if (thisTTTitle and string.find(thisTTTitle, "^"..ttTitle)) then
               lazyr.d("HasBuffOrDebuff: found ttTitle "..ttTitle.." at buffId: "..buffId)
            else
               lazyr.d("HasBuffOrDebuff: did NOT find ttTitle "..ttTitle.." at buffId: "..buffId)
               candidates[buffId] = false
            end
         end
      end
   end
            
   if (ttBody) then
      for buffId, isCandidate in ipairs(candidates) do
         if (isCandidate) then
            LazyRogue_Tooltip:ClearLines()
            if (buffOrDebuff == "buff") then
               LazyRogue_Tooltip:SetUnitBuff(unitId, buffId)
            else
               LazyRogue_Tooltip:SetUnitDebuff(unitId, buffId)
            end
            local ttNumlines = LazyRogue_Tooltip:NumLines()
            for i = 2, ttNumlines do
               local thisTTBody = getglobal("LazyRogue_TooltipTextLeft"..i):GetText()
               if (thisTTBody and string.find(thisTTBody, "^"..ttBody)) then
                  lazyr.d("HasBuffOrDebuff: found ttBody "..ttBody.." at buffId: "..buffId)
               else
                  lazyr.d("HasBuffOrDebuff: did NOT find ttBody "..ttBody.." at buffId: "..buffId)
                  candidates[buffId] = false
               end
            end
         end
      end
   end

   for buffId, isCandidate in ipairs(candidates) do
      if (isCandidate) then
         return buffId
      end
   end

   return nil
end


function lazyr.masks.BuffOrDebuffMask(attack)
   return function()
             local unitId = "target"
             local buffOrDebuff = "debuff"
             local texture
             local ttTitle
             if (attack == "Adrenaline") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.adrenalineRush.texture
                ttTitle = lrLocale.BUFF_TTS.adrenalineRush
             elseif (attack == "Berserking") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.berserking.texture
                ttTitle = lrLocale.BUFF_TTS.berserking
             elseif (attack == "BladeFlurry") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.bladeFlurry.texture
                ttTitle = lrLocale.BUFF_TTS.bladeFlurry
             elseif (attack == "Blind") then
                texture = lazyr.actions.blind.texture
                ttTitle = lrLocale.BUFF_TTS.blind
             elseif (attack == "ColdBlood") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.coldBlood.texture
                ttTitle = lrLocale.BUFF_TTS.coldBlood
             elseif (attack == "Cs") then
                texture = lazyr.actions.cheapShot.texture
                ttTitle = lrLocale.BUFF_TTS.cheapShot
             elseif (attack == "Evasion") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.evasion.texture
                ttTitle = lrLocale.BUFF_TTS.evasion
             elseif (attack == "Expose") then
                texture = lazyr.actions.exposeArmor.texture
                ttTitle = lrLocale.BUFF_TTS.exposeArmor
             elseif (attack == "Garrote") then
                texture = lazyr.actions.garrote.texture
                ttTitle = lrLocale.BUFF_TTS.garrote
             elseif (attack == "Ghostly") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.ghostlyStrike.texture
                ttTitle = lrLocale.BUFF_TTS.ghostlyStrike
             elseif (attack == "Gouge") then
                texture = lazyr.actions.gouge.texture
                ttTitle = lrLocale.BUFF_TTS.gouge
             elseif (attack == "Hemo") then
                texture = lazyr.actions.hemorrhage.texture
                ttTitle = lrLocale.BUFF_TTS.hemorrhage
             elseif (attack == "Ks") then
                texture = lazyr.actions.kidneyShot.texture
                ttTitle = lrLocale.BUFF_TTS.kidneyShot
             elseif (attack == "RecentlyBandaged") then
                unitId = "player"
                texture = "INV_Misc_Bandage_08"
                ttTitle = lrLocale.BUFF_TTS.recentlyBandaged
             elseif (attack == "FirstAid") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = "Spell_Holy_Heal"
                ttTitle = lrLocale.BUFF_TTS.firstAid
             elseif (attack == "Remorseless") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = "Ability_FiegnDead"
                ttTitle = lrLocale.BUFF_TTS.remorseless
             elseif (attack == "Rupture") then
                texture = lazyr.actions.rupture.texture
                ttTitle = lrLocale.BUFF_TTS.rupture
             elseif (attack == "Sap") then
                texture = lazyr.actions.sap.texture
                ttTitle = lrLocale.BUFF_TTS.sap
             elseif (attack == "Snd") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.sliceNDice.texture
                ttTitle = lrLocale.BUFF_TTS.sliceNDice
             elseif (attack == "Stealth") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.stealth.texture
                ttTitle = lrLocale.BUFF_TTS.stealth
             elseif (attack == "Vanish") then
                unitId = "player"
                buffOrDebuff = "buff"
                texture = lazyr.actions.vanish.texture
                ttTitle = lrLocale.BUFF_TTS.vanish
             else
                lazyr.p("internal error, unknown attack: "..attack)
                return false
             end

             return lazyr.masks.HasBuffOrDebuff(unitId, buffOrDebuff, texture, ttTitle)
          end
end

function lazyr.masks.TargetClass(class)
   return function()
             return (class == UnitClass("target"))
          end
end

function lazyr.masks.TargetLevel(gtLtEq, val)
   return function()
             if (not UnitExists("target")) then
                return false
             end
             local tLevel = UnitLevel("target")
             if (tLevel == -1) then
                -- "??"
                -- means target is > 10 levels above the player.
                -- hmm, special case.  we can still be smart here.
                -- if the criteria was greater than something, where something 
                -- is at most your level + 10, then we can return true.  
                -- otherwise we can't be sure.
                local pLevel = UnitLevel("player")
                if (gtLtEq == ">" and (val <= pLevel + 10)) then
                   return true
                end
                return false
             end

             if (gtLtEq == ">") then
                return (tLevel > val)
             elseif (gtLtEq == "=") then
                return (tLevel == val)
             else
                return (tLevel < val)
             end
          end
end

function lazyr.masks.TargetMyLevel(gtLtEq, val)
   return function()
             if (not UnitExists("target")) then
                return false
             end
             local tLevel = tonumber(UnitLevel("target"))
             local pLevel = tonumber(UnitLevel("player"))
             local tmp=pLevel+val
             --not sure how to code this with the information availble
			 --if (tLevel == -1) then
                -- "??"
                -- means target is > 10 levels above the player.
                -- hmm, special case.  we can still be smart here.
                -- if the criteria was greater than something, where something 
                -- is at most your level + 10, then we can return true.  
                -- otherwise we can't be sure.
            --    if (gtLtEq == ">" and (tmp <= pLevel + 10)) then
            --       return true
            --    end
            --    return false
            -- end
             if (gtLtEq == ">") then
             lazyr.d("Search for target over lvl "..tmp)
			    return (tmp < tLevel)
             elseif (gtLtEq == "=") then
             lazyr.d("Search for target equal to lvl "..tmp)
			    return (tmp == tLevel)
             else
             lazyr.d("Search for target under lvl "..tmp)
			    return (tmp > tLevel)
             end
          end
end

function lazyr.masks.TargetType(type)
   return function()
             return (type == UnitCreatureType("target"))
          end
end

function lazyr.masks.TargetNamed(nameRegex)
   return function()
             local tName = UnitName("target")
             if (tName and string.find(tName, nameRegex)) then
                return true
             end
             return false
          end
end

function lazyr.masks.TargetNPC()
   return function()
             return not UnitIsPlayer("target")
          end
end

function lazyr.masks.TargetHostile()
   return function()
             -- http://www.wowwiki.com/API_UnitReaction
             local reaction = UnitReaction("player", "target")
             if (not reaction) then
                -- dunno...
                return false
             end
             return (reaction <= 3)
          end
end

function lazyr.masks.TargetInCombat()
   return function()
             return UnitAffectingCombat("target")
          end
end

function lazyr.masks.TargetAlive()
   return function()
             if UnitName("target") then
                return (not UnitIsDead("target"))
             else
                return false
             end
          end
end

function lazyr.masks.TargetCCd()
   return function()
             for texture, ttInfo in lrLocale.CC_TTS do
                local ttTitle = ttInfo[1]
                local ttBody = ttInfo[2]
                if (lazyr.masks.HasBuffOrDebuff("target", "debuff", texture, ttTitle, ttBody)) then
                   if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                      if (not ttTitle) then
                         ttTitle = texture
                      end
                      lazyr.p("ifTargetCCd: target afflicted by "..ttTitle)
                   end
                   return true
                end
             end
             return false
          end
end

function lazyr.masks.IsMarked()
   return function()
             if (not lrLocale.HuntersMark_TTS) then
                lazyr.p("Sorry, ifHuntersMark not supported for your locale.")
                return false
             end
             for texture, ttTitle in lrLocale.HuntersMark_TTS do
                if (lazyr.masks.HasBuffOrDebuff("player", "debuff", texture, ttTitle)) then
                   lazyr.d("player afflicted by Hunter's Mark")
                   return true
                end
             end
             return false
          end
end

function lazyr.masks.IsPolymorphed()
   return function()
             if (not lrLocale.Polymorph_TTS) then
                lazyr.p("Sorry, ifPolymorphed not supported for your locale.")
                return false
             end
             for texture, ttTitle in lrLocale.Polymorph_TTS do
                if (lazyr.masks.HasBuffOrDebuff("player", "debuff", texture, ttTitle)) then
                   lazyr.d("player afflicted by Polymorph")
                   return true
                end
             end
             return false
          end
end


function lazyr.masks.IsBleeding()
   return function()
             if (not lrLocale.Bleed_TTS) then
                lazyr.p("Sorry, ifBleeding not supported for your locale.")
                return false
             end
             for texture, ttTitle in lrLocale.Bleed_TTS do
                if (lazyr.masks.HasBuffOrDebuff("player", "debuff", texture, ttTitle)) then
                   if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                      if (not ttTitle) then
                         ttTitle = texture
                      end
                      lazyr.p("ifBleeding: player afflicted by "..ttTitle)
                   end
                   return true
                end
             end
             return false
          end
end

function lazyr.masks.IsDotted()
   return function()
             if (not lrLocale.DOT_TTS) then
                lazyr.p("Sorry, ifDotted not supported for your locale.")
                return false
             end
             for idx, ttBody in lrLocale.DOT_TTS do
                if (lazyr.masks.HasBuffOrDebuff("player", "debuff", nil, nil, ttBody)) then
                    if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                      lazyr.p("ifDotted: player afflicted by "..ttBody)
                   end
                  return true
                end
             end
             return false
          end
end

function lazyr.masks.IsFeared()
   return function()
             if (not lrLocale.FEAR_TTS) then
                lazyr.p("Sorry, ifFeared not supported for your locale.")
                return false
             end
             for idx, ttBody in lrLocale.FEAR_TTS do
                if (lazyr.masks.HasBuffOrDebuff("player", "debuff", nil, nil, ttBody)) then
                   if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                      lazyr.p("ifFeared: player afflicted by "..ttBody)
                   end
                   return true
                end
             end
             return false
          end
end

function lazyr.masks.IsImmobile()
   return function()
             if (not lrLocale.IMMOBILE_TTS) then
                lazyr.p("Sorry, ifImmobile not supported for your locale.")
                return false
             end
             for idx, ttBody in lrLocale.IMMOBILE_TTS do
                if (lazyr.masks.HasBuffOrDebuff("player", "debuff", nil, nil, ttBody)) then
                   if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                      lazyr.p("ifImmobile: player afflicted by "..ttBody)
                   end
                   return true
                end
             end
             return false
          end
end

function lazyr.masks.UnitStunned(unitId)
   return function()
             if (not lrLocale.STUNNED_TTS) then
                lazyr.p("Sorry, if[Target]Stunned not supported for your locale.")
                return false
             end
             for idx, ttBody in lrLocale.STUNNED_TTS do
                if (lazyr.masks.HasBuffOrDebuff(unitId, "debuff", nil, nil, ttBody)) then
                   if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                      lazyr.p("ifStunned: played afflicted by "..ttBody)
                   end
                   return true
                end
             end
             return false
          end
end

function lazyr.masks.UnitSlowed(unitId)
   return function()
             if (not lrLocale.SLOWED_TTS) then
                lazyr.p("Sorry, if[Target]Slowed not supported for your locale.")
                return false
             end
             for idx, ttBody in lrLocale.SLOWED_TTS do
                if (lazyr.masks.HasBuffOrDebuff(unitId, "debuff", nil, nil, ttBody)) then
                   if (lazyr.perPlayerConf.showReasonForTargetCCd) then
                      lazyr.p("ifSlowed: player afflicted by "..ttBody)
                   end
                   return true
                end
             end
             return false
          end
end

function lazyr.masks.IsInstance(unitId)
   return function()
             if (not lrLocale.INSTANCES) then
                lazyr.p("Sorry, ifInstance not supported for your locale.")
                return false
             end
			 zone = GetZoneText()
             for idx, instance in lrLocale.INSTANCES do
                if string.find(zone, instance) then
				return true
                end
             end
             return false
          end
end
function lazyr.masks.IsBattleground(unitId)
   return function()
			 for i = 1, MAX_BATTLEFIELD_QUEUES do
         status, mapName, instanceID = GetBattlefieldStatus(i)
         if (status == "active") then
            lazyr.d("You're in batteground: "..mapName)
             return true
         end

             return false
          end
		  end
end

function lazyr.masks.TargetIsCasting(nameRegex)
   return function()
             if (lazyr.interrupt.targetCasting and ((GetTime() - lazyr.interrupt.castingDetectedAt) <= 5)) then
                if (not nameRegex or nameRegex == "") then
                   return true
                end
                if (string.find(lazyr.interrupt.targetCasting, nameRegex)) then
                   return true
                end
             end
             return false
          end
end

-- if any of the exception criteria return true, we return FALSE
function lazyr.masks.InterruptExceptionCriteria()
   return function()
             lazyr.masks.alreadyInsideInterruptExceptionCriteria = true
             local actionInfos = lazyr.ParseForm(lrConf.interruptExceptionCriteria)
             lazyr.masks.alreadyInsideInterruptExceptionCriteria = false

             for idx, actionInfo in actionInfos do
                local action = actionInfo[1] -- should be nil
                local masks = actionInfo[2]
                local areAllTrue = true
                   if (masks) then
                   for idx, mask in masks do
                      if (not mask()) then
                         areAllTrue = false
                         break
                      end
                   end
                   if (areAllTrue) then
                      -- all criteria on this line returned true, so this mask returns false
                      return false
                   end
                end
             end
             
             return true
          end
end

function lazyr.masks.TargetElite()
   return function()
             return string.find(UnitClassification("target"), "elite")
          end
end

function lazyr.masks.TargetInMeleRange()
   return function()
             return CheckInteractDistance("target", 1)
          end
end

function lazyr.masks.TargetInBlindRange()
   return function()
             return CheckInteractDistance("target", 2)
          end
end

function lazyr.masks.PlayerInCombat()
   return function()
             return lazyr.isInCombat
          end
end

function lazyr.masks.PlayerInGroup()
   return function()
             return (GetNumPartyMembers() > 0)
          end
end

function lazyr.masks.PlayerInRaid()
   return function()
             return (GetNumRaidMembers() > 0)
          end
end

function lazyr.masks.PlayerInGroupOrRaid()
   return function()
             return ((GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0))
          end
end

 
-- if you don't eviscerate now, will you have time for 2 ticks before the target dies?
-- we determine the rate of damage, and estimate when the target will be dead
-- then we look at the last tick, and add 4 seconds, and see if that's before he'll die.
function lazyr.masks.IsLastChance()
   return function()
             -- MobInfo-2 required
             if (not MobHealth_GetTargetCurHP) then
                return false
             end
             if (GetComboPoints() == 0 or not UnitName("target") or UnitHealth("target") == 0) then
                return false
             end

             local n = lazyr.targetHealthHistory:GetN()
             -- we want at least a couple data points
             if (n < 3) then
                return false
             end

             local startTime = GetTime()

             -- m is the slope, or hp per second
             local m = lazyr.targetHealthHistory:ComputeSlope()
             if (not m) then
                return false
             end
             if (m >= 0) then
                lazyr.d("IsLastChance: m is positive?  target healing?")
                return false
             end
             local currentHp = lazyr.masks.GetUnitHealth("target")
             local secondsTilDeath = math.abs(currentHp / m)

             -- now, we know when he'll die.  
             -- look at the last tick, and add 4 seconds (and a 1/4s buffer), and see 
             -- if that's before he'll die.
             -- Also consider the player's current energy:
             -- Maybe we won't need 2 ticks... to be really smart, we'd need to know what attack 
             -- the player will use if he doesn't evisc right now... well, the maximum attack is 
             -- backstab (60), but more likely a SS (40-45).
             -- Okay, for simplicity let's just assume the player will SS (40).
             local ticksNeeded = 2
             local currentEnergy = lazyr.masks.GetUnitMana("player")
             if (currentEnergy >= 60) then
                ticksNeeded = 1
             elseif (currentEnergy >= 80) then
                ticksNeeded = 0
             end
             local whenTicks = lazyr.lastTickTime + (ticksNeeded * 2)

             local isLastChance
             if ((whenTicks + .25) > (GetTime() + secondsTilDeath)) then
                isLastChance = true
             else
                isLastChance = false
             end

             local msg = "IsLastChance: n: "..n..
                ", m: "..math.abs(string.format("%.1f", m)).."hp/s, "..
                " hp: "..currentHp.. ", DEAD IN "..
                string.format("%.1f", secondsTilDeath).."s ("..
                string.format("%.1f", (GetTime() - startTime)).."s)"
             if (isLastChance) then
                msg = msg.." EVISCERATE NOW"
             end
             msg = msg.."."
             lazyr.d(msg)

             return isLastChance
          end
end

function lazyr.masks.IsEquipped(item)
   return function()
             local itemId
             local itemName
             if (string.find(item, '^%d')) then
                itemId = tonumber(item)
             else
                itemName = item
             end
             for slot = 0, 19 do
                local link = GetInventoryItemLink("player", slot)
                if (link) then
                   local id, name = lazyr.IdAndNameFromLink(link)
                   if (id) then
                      if ((itemId and id == itemId)) then
                         return true
                      elseif (itemName) then
                         if string.lower(name) == string.lower(itemName) then
                            return true
                         end
                      end
                   end
                end
             end
             return false
          end
end

function lazyr.masks.IsKeyDown(key)
   return function()
             if (key == "Ctrl") then
                return IsControlKeyDown()
             elseif (key == "Alt") then
                return IsAltKeyDown()
             elseif (key == "Shift") then
                return IsShiftKeyDown()
             end
             return false
          end
end

function lazyr.masks.Every(action, seconds)
   return function()
             if (GetTime() > (action.everyTimer + seconds))or action.everyTimer==nil then
                return true
             end
             return false
          end
end

function lazyr.masks.Timer(action, seconds)
   return function()
             if lazyr.actions[action] then
			 if (GetTime() > (lazyr.actions[action].everyTimer + seconds)) then
                return true
             end
             elseif lazyr.forms[action] then
			 if (GetTime() > (lazyr.setForm[action].everyTimer + seconds)) then
                return true
             end
             elseif lazyr.items[action] then
			 if (GetTime() > (lazyr.item[action].everyTimer + seconds)) then
                return true
             end
             elseif lazyr.pseudoActions[action] then
			 if (GetTime() > (lazyr.pseudoActions[action].everyTimer + seconds)) then
                return true
             end
             elseif lazyr.comboActions[action] then
			 if (GetTime() > (lazyr.comboActions[action].everyTimer + seconds)) then
                return true
             end
             end
			 return false
          end
end

-- :-(
-- This code is good for a Rogue.  It skips over some annoying exceptions that only
-- Hunters and Druids face.  Do not rip off this code unless you're writing a Rogue-only addon.
function lazyr.masks.PlayerMountedIndex()
   local buffId = 0
   local mountBuffIndex = nil
   while true do
      local buffIndex = GetPlayerBuff(buffId, "HELPFUL|PASSIVE")
      if (buffIndex < 0) then
         break
      end

      local texture = GetPlayerBuffTexture(buffIndex)

      local skip = false

      if (string.find(texture, "Ability_Mount_") or 
          string.find(texture, "Spell_Nature_Swiftness") or 
          string.find(texture, "INV_Misc_Foot_Kodo")) then

         -- Whoa, one exception though: Is it really a mount? (Spotted Frostsaber?) 
         -- or just a Hunter in the party with Aspect of the Pack?
         if (string.find(texture, "Ability_Mount_WhiteTiger")) then
            lazyr.d("PlayerMountedIndex: Whoa, Ability_Mount_WhiteTiger is suspect, having to parse TT")
            LazyRogue_Tooltip:ClearLines()
            LazyRogue_Tooltip:SetPlayerBuff(buffIndex)
            local ttText = LazyRogue_TooltipTextLeft2:GetText()
            if (not string.find(ttText, "^"..lrLocale.MOUNTED_BUFF_TT)) then
               lazyr.d("PlayerMountedIndex: IGNORING: it's not really a mount: "..ttText)
               skip = true -- uggh, Lua really needs a continue function
            end
         end

         if (not skip) then
            lazyr.d("PlayerMountedIndex: OK, you're mounted: "..texture)
            mountBuffIndex = buffIndex
            break
         end
      end

      buffId = buffId + 1
   end

   return mountBuffIndex
end


function lazyr.masks.PlayerMounted()
   return function()
             return lazyr.masks.PlayerMountedIndex()
          end
end


function lazyr.masks.InZone(nameRegex)
   return function()
             if (string.find(GetRealZoneText(), nameRegex)) then
                return true
             end
             return false
          end
end

function lazyr.masks.IsPoisoned(weapon)
   return function()
             bMh, tMh, cMh, bOh, tOh, cOh = GetWeaponEnchantInfo();
             if (weapon == "MainHand" and bMh) then
                return true
             elseif (weapon == "OffHand" and bOh) then
                return true
             else
                return false
             end
             return false
          end
end

function lazyr.masks.IsGlobalCooldown()
return function()
if not lazyr.globalCooldownSlot then
 for slot = 1, 120 do 
         if (not GetActionText(slot)) then -- ignore any Player macros :-)
            local text = GetActionTexture(slot)
            if (text and (string.find(text, "INV_Misc_Rune_01"))) then 
               lazyr.globalCooldownSlot = slot
               break
            end
         end
      end
 if not lazyr.globalCooldownSlot then
 lazyr.p("Sorry -if[Not]GlobalCooldown function is not available to this char.")
 return false
 end
	  local start, duration, enable = GetActionCooldown(lazyr.globalCooldownSlot)
             if (enable > 0) then
                return true
             else
                return false
             end
	
	  
	  
	  else
	  local start, duration, enable = GetActionCooldown(lazyr.globalCooldownSlot)
             if ( start > 0 and duration > 0 and enable > 0) then
                return true
             else
                return false
             end
	  end
	  end
	  end

function lazyr.masks.History(gtLtEq, val, action)
   return function()
             local historySize = table.getn(lazyr.actionHistory)
             if (gtLtEq == ">") then
                local i = val + 1
                while true do
                   if (not lazyr.actionHistory[i]) then
                      return false
                   end
                   if (lazyr.actionHistory[i] == action) then
                      return true
                   end
                   i = i + 1
                end
             elseif (gtLtEq == "<") then
                local i = val - 1
                while (i > 0) do
                   if (lazyr.actionHistory[i] and lazyr.actionHistory[i] == action) then
                      return true
                   end
                   i = i - 1
                end
                return false
             else
                if (lazyr.actionHistory[val] and lazyr.actionHistory[val] == action) then
                   return true
                end
                return false
             end
          end
end




function lazyr.ParseArg(arg)
   -- remove comments: # .... or // ....
   -- trim leading/trailing whitespace
   -- ignore blank lines
   arg = string.gsub(arg, "#.*", "")
   arg = string.gsub(arg, "//.*", "")
   arg = string.gsub(arg, "%-%-.*", "")
   arg = string.gsub(arg, "^%s+", "")
   arg = string.gsub(arg, "%s+$", "")
   if (arg == "") then
      return 0
   end

   local bits = {}
   for bit in string.gfind(arg, "[^\-]+") do
      table.insert(bits, bit)
   end

   local action
   local masks = {}
   for idx, bit in bits do
      if (string.sub(bit, 1, 6) == "action") then
         if (not lazyr.re(bit, "^action=(.+)$")) then
            lazyr.p("Can't parse: "..bit)
            return nil
         end
         local thisAction = lazyr.match1
         if (not lazyr.otherActions[thisAction]) then
            lazyr.otherActions[thisAction] = lazyr.Action:New(thisAction, thisAction)
         end
         action = lazyr.otherActions[thisAction]
      elseif (bit == "adrenaline") then
         action = lazyr.actions.adrenalineRush
      elseif (bit == "ambush") then
         action = lazyr.actions.ambush
      elseif (bit == "cbAmbush") then
         action = lazyr.comboActions.cbAmbush
      elseif (bit == "berserking") then
         action = lazyr.actions.berserking
      elseif (bit == "bladeFlurry" or bit == "bladeflurry") then
         action = lazyr.actions.bladeFlurry
      elseif (bit == "blind") then
         action = lazyr.actions.blind
      elseif (bit == "bs") then
         action = lazyr.actions.backstab
         table.insert(masks, lazyr.masks.BehindAttackHasNotFailedRecently())
      elseif (bit == "cbEvisc" or bit == "cbevisc") then
         action = lazyr.comboActions.cbEvisc
      elseif (bit == "coldBlood" or bit == "coldblood") then
         action = lazyr.actions.coldBlood
      elseif (bit == "cs") then
         action = lazyr.actions.cheapShot
      elseif (bit == "dismount") then
         action = lazyr.pseudoActions.dismount
      elseif (bit == "evasion") then
         action = lazyr.actions.evasion
      elseif (bit == "evisc") then
         action = lazyr.actions.eviscerate
      elseif (bit == "expose") then
         action = lazyr.actions.exposeArmor
      elseif (bit == "feint") then
         action = lazyr.actions.feint
         table.insert(masks, lazyr.masks.PlayerInGroupOrRaid())
      elseif (bit == "garrote") then
         action = lazyr.actions.garrote
         table.insert(masks, lazyr.masks.BehindAttackHasNotFailedRecently())
      elseif (bit == "ghostly") then
         action = lazyr.actions.ghostlyStrike
      elseif (bit == "gouge") then
         action = lazyr.actions.gouge
         table.insert(masks, lazyr.masks.InFrontAttackHasNotFailedRecently())
      elseif (bit == "hemo") then
         action = lazyr.actions.hemorrhage
      elseif (bit == "kick") then
         action = lazyr.actions.kick
         table.insert(masks, lazyr.masks.TargetInMeleRange())
      elseif (bit == "ks") then
         action = lazyr.actions.kidneyShot
      elseif (bit == "ping") then
         action = lazyr.pseudoActions.ping
      elseif (bit == "premeditation") then
         action = lazyr.actions.premeditation
      elseif (bit == "preparation") then
         action = lazyr.actions.preparation
      elseif (bit == "pickPocket") then
         action = lazyr.actions.pickPocket
      elseif (bit == "riposte") then
         action = lazyr.actions.riposte
      elseif (bit == "rupture") then
         action = lazyr.actions.rupture
      elseif (bit == "sap") then
         action = lazyr.actions.sap
      elseif (bit == "snd") then
         action = lazyr.actions.sliceNDice
      elseif (bit == "sprint") then
         action = lazyr.actions.sprint
      elseif (bit == "ss") then
         action = lazyr.actions.sinisterStrike
      elseif (bit == "stealth") then
         action = lazyr.actions.stealth
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.BuffOrDebuffMask("Stealth"), true))
      elseif (bit == "stop") then
         action = lazyr.pseudoActions.stop
      elseif (bit == "stopAll" or bit == "stopall") then
         action = lazyr.pseudoActions.stopAll
      elseif (bit == "tea") then
         action = lazyr.items.thistleTea
      elseif (bit == "perception") then
         action = lazyr.actions.humanRacial
      elseif (bit == "stoneForm") then
         action = lazyr.actions.dwarfRacial
      elseif (bit == "escapeArtist") then
         action = lazyr.actions.gnomeRacial
      elseif (bit == "bloodFury") then
         action = lazyr.actions.orcRacial
      elseif (bit == "warStomp") then
         action = lazyr.actions.taurenRacial
      elseif (bit == "forsaken") then
         action = lazyr.actions.undeadRacial
     elseif (bit == "throw") then
         action = lazyr.actions.throw
     elseif (bit == "bow") then
         action = lazyr.actions.bow
     elseif (bit == "gun") then
         action = lazyr.actions.gun
     elseif (bit == "crossbow") then
         action = lazyr.actions.crossbow
     elseif (bit == "cannibalize") then
        action = lazyr.actions.cannibalize
	elseif (bit == "targetAssist") then
         action = lazyr.pseudoActions.targetAssist
      elseif (bit == "targetNearest") then
         action = lazyr.pseudoActions.targetNearest
      elseif (bit == "autoAttack") then
         action = lazyr.pseudoActions.autoAttack
      elseif (string.sub(bit, 1, 11) == "applyPoison") then 
         lazyr.d("applyPoison")
         if (not lazyr.re(bit, "^applyPoison(%a+)=(.+)$")) then
            lazyr.p("Can't parse: "..bit)
            return nil
         end
         if (lazyr.match1 ~="MainHand" and lazyr.match1 ~="OffHand") then
            lazyr.p("Only MainHand and OffHand available, but not"..lazyr.match1)
            return nil
         end
         local weaponName=lazyr.match1
         local poisonName=lazyr.match2
         local key = weaponName..":"..poisonName
         if (not lazyr.poisonsUse[key]) then
            lazyr.poisonsUse[key] = lazyr.applyPoison:New(poisonName, weaponName)
         end
         action = lazyr.poisonsUse[key]
         
      elseif (string.sub(bit, 1, 5) == "sayIn") then
         if (not lazyr.re(bit, "^sayIn(%a+)=(.+)$")) then
            lazyr.p("Can't parse: "..bit)
            return nil
         end
         if lazyr.match1 ~="Guild" and lazyr.match1 ~="Party" and lazyr.match1 ~="Raid" and lazyr.match1 ~="Say" and lazyr.match1 ~="Emote" and lazyr.match1 ~="RAID_WARNING" then
            lazyr.p("Unknown channel name: "..lazyr.match1)
            return nil
         end
         -- XXX: this will not work!  these globals are set at parse time, but they
         -- might be changed before run time!
         lazyr.sayInChannel = lazyr.match1
         lazyr.sayInMessage = lazyr.match2
         
         action = lazyr.pseudoActions.sayIn
         
      elseif (string.sub(bit, 1, 8) == "setForm=") then
         if (not lazyr.re(bit, "^setForm=(.+)$")) then
            lazyr.p("Can't parse: "..bit)
            return nil
         end
         local form = lazyr.match1
         if (not lazyr.forms[form]) then
            lazyr.forms[form] = lazyr.SetForm:New("form"..form, form)
         end
         action = lazyr.forms[form]

      elseif (string.sub(bit, 1, 14) == "equipMainHand=") then
         if (not lazyr.re(bit, "^equipMainHand=(.+)$")) then
            lazyr.p("Can't parse: "..bit)
            return nil
         end
         local item = lazyr.match1
         local itemId
         local itemName
         if (string.find(item, '^%d')) then
            itemId = tonumber(item)
            itemName = "Item "..itemId
         else
            itemName = item
         end
         if (not lazyr.mainHandItems[item]) then
            lazyr.mainHandItems[item] = lazyr.EquipItem:New(item, itemName, itemId, 16)
         end
         action = lazyr.mainHandItems[item]

      elseif (string.sub(bit, 1, 13) == "equipOffHand=") then
         if (not lazyr.re(bit, "^equipOffHand=(.+)$")) then
            lazyr.p("Can't parse: "..bit)
            return nil
         end
         local item = lazyr.match1
         local itemId
         local itemName
         if (string.find(item, '^%d')) then
            itemId = tonumber(item)
            itemName = "Item "..itemId
         else
            itemName = item
         end
         if (not lazyr.offHandItems[item]) then
            lazyr.offHandItems[item] = lazyr.EquipItem:New(item, itemName, itemId, 17)
         end
         action = lazyr.offHandItems[item]

      elseif (string.sub(bit, 1, 3) == "use") then
         if (not lazyr.re(bit, "^use(E?q?u?i?p?p?e?d?)=?(.+)$")) then
            lazyr.p("Can't parse: "..bit)
            return nil
         end
         local equippedOnly = (lazyr.match1 == "Equipped")
         local item = lazyr.match2
         local itemId
         local itemName
         if (string.find(item, '^%d')) then
            itemId = tonumber(item)
            itemName = "Item "..itemId
         else
            itemName = item
         end
         local myItemSet
         if (equippedOnly) then
            myItemSet = lazyr.equippedItems
         else
            myItemSet = lazyr.items
         end
         if (not myItemSet[item]) then
            myItemSet[item] = lazyr.Item:New(item, itemName, itemId, equippedOnly)
         end
         action = myItemSet[item]
         
      elseif (bit == "vanish") then
         action = lazyr.actions.vanish

      elseif (lazyr.re(bit, "^if(N?o?t?)Equipped=(.+)$")) then
         local negate = lazyr.match1 == "Not"
         local item = lazyr.match2
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsEquipped(item), negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)TargetOfTargetClass=(.+)$")) then
         local negate = (lazyr.match1 == "Not")
         
         local subMasks = {}
         for class in string.gfind(lazyr.match2, "[^,]+") do
            table.insert(subMasks, lazyr.masks.IsTargetOfTargetClass(class))
         end

         table.insert(masks, lazyr.masks.maskGroup(subMasks, negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)Dueling$")) then
         local negate = lazyr.match1 == "Not"
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsDueling(), negate))
         
      elseif (lazyr.re(bit, "^if(T?a?r?g?e?t?)FlaggedPVP$")) then
         local unit = lazyr.match1
         table.insert(masks, lazyr.masks.IsFlaggedPVP(unit))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)TargetOfTarget$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsTargetOfTarget(), negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)Stealthed$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsStealthedMask(), negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)InCombat$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.PlayerInCombat(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)BehindAttackJustFailed$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.BehindAttackFailedRecently(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)InFrontAttackJustFailed$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.InFrontAttackFailedRecently(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)InGroup$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.PlayerInGroup(), negate))

       elseif (lazyr.re(bit, "^if(N?o?t?)InRaid$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.PlayerInRaid(), negate))
		 
      elseif (lazyr.re(bit, "^if(N?o?t?)LastChance$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsLastChance(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Mounted$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.PlayerMounted(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Instance$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsInstance(), negate))

     elseif (lazyr.re(bit, "^if(N?o?t?)Battleground$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsBattleground(), negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)Ganked$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsBeingGanked(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)FlagRunner$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsFlagRunner(), negate))

      elseif (lazyr.re(bit, "^if(C?b?)KillShot=?(%d?%d?%d?)%%?$")) then
         local assumeCBActive = false
         local goalPct = 100
         if (bit == "ifKillShot" and action ~= lazyr.actions.eviscerate) then
            lazyr.p("-ifKillShot only works with evisc")
            return nil
         elseif (bit == "^ifCbKillShot$" and action ~= lazyr.comboActions.cbEvisc and 
                 action ~= lazyr.actions.eviscerate) then
            lazyr.p("-ifCbKillShot only works with cbevisc or evisc")
            return nil
         end
         if (lazyr.match2 ~= "") then
            goalPct = tonumber(lazyr.match2)
         end
         table.insert(masks, lazyr.masks.IsEviscKillShot(assumeCBActive, goalPct))

      elseif (lazyr.re(bit, "^if([<=>]?)(%d+)cp$") or lazyr.re(bit, "^([<=>]?)(%d+)cp$")) then
         local gtLtEq = lazyr.match1
         local val = tonumber(lazyr.match2)
         table.insert(masks, lazyr.masks.ComboPoints(val, gtLtEq))
       
      elseif (lazyr.re(bit, "^if([<=>]?)(%d+)attackers$")) then
         local gtLtEq = lazyr.match1
         local val = tonumber(lazyr.match2)
         table.insert(masks, lazyr.masks.IsBeingAttackedBy(val, gtLtEq))
         
      elseif (lazyr.re(bit, "^if(%a+)([<=>])(%d+)(%%?)(%a+)$") or
              lazyr.re(bit, "^(%a+)([<=>])(%d+)(%%?)(%a+)$")) then
         local unitId = string.lower(lazyr.match1)
         local gtLtEq = lazyr.match2
         local val = tonumber(lazyr.match3)
         local wantPct = (lazyr.match4 == "%")
         local powerType = lazyr.match5

         if (unitId ~= "player" and unitId ~= "target") then
            lazyr.p("UnitId must be Player or Target, "..unitId.." not supported.")
            return nil
         end
         if (powerType ~= "hp" and powerType ~= "mana" and powerType ~= "energy") then
            lazyr.p("Only hp and mana/energy are supported, not: "..powerType)
            return nil
         end

         table.insert(masks, lazyr.masks.UnitPowerMask(unitId, gtLtEq, val, powerType, wantPct))

      elseif (lazyr.re(bit, "^if(N?o?t?)(%a-)(N?o?t?)Active$")) then
         -- Okay, this is a little messy, but it will fix up those 
         -- N?o?t?s from capturing pieces of %a- they shouldn't.
         if (lazyr.match1 ~= "" and lazyr.match1 ~= "Not") then
            lazyr.match2 = lazyr.match1..lazyr.match2
         end
         if (lazyr.match3 ~= "" and lazyr.match3 ~= "Not") then
            lazyr.match2 = lazyr.match2..lazyr.match3
         end
         local attack = lazyr.match2
         local negate = (lazyr.match1 == "Not" or lazyr.match3 == "Not")

         if (attack ~= "Adrenaline" and attack ~= "Berserking"
             and attack ~= "BladeFlurry" and attack ~= "Blind" and attack ~= "ColdBlood" 
             and attack ~= "Cs" and attack ~= "Evasion" 
             and attack ~= "Expose" and attack ~= "Garrote" and attack ~= "Ghostly" 
             and attack ~= "Gouge" and attack ~= "FirstAid" 
             and attack ~= "Hemo" and attack ~= "Ks" 
             and attack ~= "RecentlyBandaged" and attack ~= "Remorseless" 
             and attack ~= "Rupture" and attack ~= "Sap" and attack ~= "Snd" 
             and attack ~= "Vanish") then
            lazyr.p("Only Adrenaline, Berserking, BladeFlurry, Blind, ColdBlood, Cs, Evasion, Expose, FirstAid (Bandage), Garrote, Ghostly, Gouge, Hemo, Ks, RecentlyBandaged, Remorseless, Rupture, Sap, Snd, and Vanish are supported, not: "..attack)
            return nil
         end

         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.BuffOrDebuffMask(attack), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)GlobalCooldown$")) then
         local negate = (lazyr.match1 == "Not" )
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsGlobalCooldown(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetClass=?(.+)$")) then
         local negate = (lazyr.match1 == "Not")
         local subMasks = {}
         for class in string.gfind(lazyr.match2, "[^,]+") do
            table.insert(subMasks, lazyr.masks.TargetClass(class))
         end
         table.insert(masks, lazyr.masks.maskGroup(subMasks, negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetLevel([<=>])(%d+)$")) then
         local negate = (lazyr.match1 == "Not" )
         local gtLtEq = lazyr.match2
   	 local val = tonumber(lazyr.match3)
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetLevel(gtLtEq, val), negate))
         

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetMyLevel([<=>])(%a*)(%d+)$")) then
         local val = nil
         local negate = (lazyr.match1 == "Not" )
         local gtLtEq = lazyr.match2
         if lazyr.match3 == "plus" or lazyr.match3 == "" then
            val = tonumber(lazyr.match4)
         elseif lazyr.match3 == "minus" then
            val = tonumber(lazyr.match4*-1)
         else
            lazyr.d("unable to determine plus/minus sign")
            return nil
         end
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetMyLevel(gtLtEq, val), negate))
 
      elseif (lazyr.re(bit, "^if(N?o?t?)TargetType=?(.+)$")) then
         local negate = (lazyr.match1 == "Not")
         local subMasks = {}
         for type in string.gfind(lazyr.match2, "[^,]+") do
            table.insert(subMasks, lazyr.masks.TargetType(type))
         end
         table.insert(masks, lazyr.masks.maskGroup(subMasks, negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetNamed=(.+)$")) then
         local negate = (lazyr.match1 == "Not")
         local nameRegex = lazyr.match2
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetNamed(nameRegex), negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)TargetNPC$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetNPC(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetHostile$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetHostile(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetInCombat$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetInCombat(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetSlowed$")) then
         local negate = (lazyr.match1 == "Not" )
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.UnitSlowed("target"), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Slowed$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.UnitSlowed("player"), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetStunned$")) then
         local negate = (lazyr.match1 == "Not" )
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.UnitStunned("target"), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Stunned$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.UnitStunned("player"), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Feared$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsFeared(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Immobile$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsImmobile(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetAlive$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetAlive(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetCCd$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetCCd(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetIsCasting=?(.*)$")) then
         local negate = (lazyr.match1 == "Not")
         if (lazyr.match2 ~= "") then
            local subMasks = {}
            for nameRegex in string.gfind(lazyr.match2, "[^,]+") do
               table.insert(subMasks, lazyr.masks.TargetIsCasting(nameRegex))
            end
            table.insert(masks, lazyr.masks.maskGroup(subMasks, negate))
         else
            table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetIsCasting(), negate))
         end
         -- XXX this is kinda strange, should rethink this.
         if (not negate and not lazyr.masks.alreadyInsideInterruptExceptionCriteria) then
            table.insert(masks, lazyr.masks.InterruptExceptionCriteria())
         end
         
      elseif (lazyr.re(bit, "^if(N?o?t?)TargetElite$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetElite(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)(%a+)Down$")) then
         local negate = (lazyr.match1 == "Not")
         local key = lazyr.match2
         if (key ~= "Ctrl" and key ~= "Alt" and key ~= "Shift") then
            lazyr.p("Only Ctrl, Alt, and Shift are supported, not: "..key)
         end
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsKeyDown(key), negate))

      elseif (lazyr.re(bit, "^every(%d+)s$")) then
         if (action == nil) then
            lazyr.p("you must put the action before the -everyXXs")
            return nil
         end
         local val = tonumber(lazyr.match1)
         table.insert(masks, lazyr.masks.Every(action, val))

      elseif (lazyr.re(bit, "^if(N?o?t?)Timer=(.+)>(.+)s$")) then
         if (lazyr.match2 == nil) or (lazyr.match3 == nil) then
            lazyr.p("syntax eg. -ifTimer=gouge>5s")
            return nil
         end
         local negate = (lazyr.match1 == "Not")
         local val = tonumber(lazyr.match3)
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.Timer(string.lower(lazyr.match2), val), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Zone=(.+)$")) then
         local negate = (lazyr.match1 == "Not")
         local nameRegex = lazyr.match2
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.InZone(nameRegex), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)History([<=>])(%d+)=(.+)$")) then
         local negate = (lazyr.match1 == "Not")
         local gtLtEq = lazyr.match2
         local val = tonumber(lazyr.match3)
         local action = lazyr.match4
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.History(gtLtEq, val, action), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetInMeleeRange$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetInMeleRange(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)TargetInBlindRange$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.TargetInBlindRange(), negate))

       elseif (lazyr.re(bit, "^if(N?o?t?)InCooldown=(.+)$")) then
         local negate = (lazyr.match1 == "Not")
         local action = lazyr.match2
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.InCooldown(action), negate))

       elseif (lazyr.re(bit, "^if(N?o?t?)Dotted$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsDotted(), negate))

       elseif (lazyr.re(bit, "^if(N?o?t?)Bleeding$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsBleeding(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)HuntersMark$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsMarked(), negate))

      elseif (lazyr.re(bit, "^if(N?o?t?)Polymorphed$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsPolymorphed(), negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)CanDebuff$")) then
         local negate = (lazyr.match1 == "Not")
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.DebuffSpace(), negate))
         
      elseif (lazyr.re(bit, "^if(N?o?t?)TargetImmune=?(.*)$")) then
         local negate = (lazyr.match1 == "Not")
         if (lazyr.match2 ~= "") then
            local subMasks = {}
            for thisAction in string.gfind(lazyr.match2, "[^,]+") do
               table.insert(subMasks, lazyr.masks.IsImmune(thisAction))
            end
            table.insert(masks, lazyr.masks.maskGroup(subMasks, negate))
         else
            table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsImmune(lazyr.match2), negate))
         end
         
      elseif (lazyr.re(bit, "^if(N?o?t?)Poisoned=(%a+)$")) then
         if (lazyr.match2 ~="MainHand" and lazyr.match2 ~="OffHand") then
            lazyr.p("Only MainHand and OffHand available, but not"..lazyr.match1)
            return nil
         end
         local negate = (lazyr.match1 == "Not")
         local targetW = lazyr.match2
         table.insert(masks, lazyr.masks.negWrapper(lazyr.masks.IsPoisoned(targetW), negate))
         
      else
         lazyr.d("ParseArg: parse failure: "..arg)
         return nil
      end
   end

   return {action, masks}
end

function lazyr.ParseForm(args)
   local startTime = GetTime()
   local actions = {}
   for idx, arg in args do
      local actionInfo = lazyr.ParseArg(arg)
      if (not actionInfo) then
         lazyr.p("Can't parse: "..arg)
         return nil
      elseif (actionInfo == 0) then
         -- was empty (comments?) just ignore this
      else
         table.insert(actions, actionInfo)
      end
   end
   --lazyr.d("ParseForm: time: "..string.format("%f", (GetTime() - startTime)).."s")
   return actions
end

function lazyr.FindForm(formName)
   if (not formName) then
      return nil
   end
   for thisFormName, actions in lrConf.forms do
      if (thisFormName == formName) then
         return actions
      end
   end
   return nil
end

-- speed optimization, skip parsing and regexes every time
function lazyr.FindParsedForm(formName)
   if (not formName) then
      return nil
   end
   local startTime = GetTime()
   if (lazyr.parsedFormCache[formName] == nil) then
      local actions = lazyr.FindForm(formName)
      if (actions) then
         lazyr.parsedFormCache[formName] = lazyr.ParseForm(actions)
      end
   end
   --lazyr.d("FindParsedForm: time: "..string.format("%f", (GetTime() - startTime)).."s")
   return lazyr.parsedFormCache[formName]
end

function lazyr.ClearParsedForm(formName)
   lazyr.parsedFormCache[formName] = nil
end

function lazyr.Try(action, masks)
   if (masks) then
      for idx, mask in masks do
         if (not mask()) then
            return false
         end
      end
   end
   return action:Use()
end

function lazyr.TryActions(actions)
   local actionThatSucceeded = nil

   if (not UnitName("target") and lazyr.perPlayerConf.autoTarget) then
      TargetNearestEnemy()
   end
   
   if (actions) then
      for idx, actionInfo in actions do
         local action = actionInfo[1]
         local masks = actionInfo[2]
         if (lazyr.Try(action, masks)) then
            actionThatSucceeded = action
            break
         end
      end
   end

   if (not lazyr.mock 
       and lazyr.perPlayerConf.initiateAutoAttack
       and not actionThatSucceeded 
       and not lazyr.masks.IsStealthed()) then

      if (not lazyr.IsAutoAttacking()) then
         lazyr.d("Initiating auto-attack...")
         lazyr.StartAutoAttack()
      end
   end

   if (actionThatSucceeded) then
      return actionThatSucceeded.name
   else
      return nil
   end
end



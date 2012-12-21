-- Eviscerate tracking

lazyr.et = {}


function lazyr.et.ResetEviscTracking()
   lazyr.perPlayerConf.eviscTracker = { {0,0}, {0,0}, {0,0}, {0,0}, {0,0} }
end

function lazyr.et.GetEviscTrackingInfo(cp)
   local observedDamage = lazyr.perPlayerConf.eviscTracker[cp][1]
   local observedCt = lazyr.perPlayerConf.eviscTracker[cp][2]
   return observedDamage, observedCt
end

function lazyr.et.SetEviscTrackingInfo(cp, observedDamage, observedCt)
   lazyr.perPlayerConf.eviscTracker[cp][1] = observedDamage
   lazyr.perPlayerConf.eviscTracker[cp][2] = observedCt
end

function lazyr.et.TrackEviscerates(arg1)
   local thisDamage = nil
   if (lazyr.re(arg1, lrLocale.EVISCERATE_HIT)) then
      thisDamage = lazyr.match2
   elseif (lazyr.perPlayerConf.trackEviscCrits and lazyr.re(arg1, lrLocale.EVISCERATE_CRIT)) then
      thisDamage = lazyr.match2
   end
   if (not thisDamage) then
      return
   end

   if (not lazyr.eviscComboPoints or lazyr.eviscComboPoints == 0) then
      lazyr.d("lazyr.eviscComboPoints is nil or 0, can't record")
      return
   end

   local observedDamage, observedCt = lazyr.et.GetEviscTrackingInfo(lazyr.eviscComboPoints)

   observedDamage = observedDamage * observedCt
   local newCt = observedCt + 1
   observedDamage = observedDamage + thisDamage
   observedDamage = observedDamage / newCt
   observedCt = math.min(lazyr.perPlayerConf.eviscerateSample, newCt)

   lazyr.et.SetEviscTrackingInfo(lazyr.eviscComboPoints, observedDamage, observedCt)
      
   local expectedDamage = lazyr.masks.CalculateBaseEviscDamage(lazyr.eviscComboPoints)
   local thisRatio = thisDamage / expectedDamage
   local avgRatio = observedDamage / expectedDamage
   lazyr.d("Eviscerate ("..lazyr.eviscComboPoints.."cp): "..thisDamage.." damage (optimal "..
        expectedDamage..") "..string.format("%.2f", thisRatio).."/"..
        string.format("%.2f", avgRatio).." (cur/avg vs. optimal)")
   
   lazyr.eviscComboPoints = nil
end

-- Hook UseAction() so we can record how many combo points the 
-- player had when he eviscerated.
function lazyr.et.UseActionHook(action, checkCursor, onSelf)
   if (action == lazyr.actions.eviscerate:GetSlot()) then
      lazyr.eviscComboPoints = GetComboPoints()
      --lazyr.d("UseActionHook, I see you're eviscerating with "..lazyr.eviscComboPoints.." cps")
   end
   return lazyr.UseActionOrig(action, checkCursor, onSelf)
end

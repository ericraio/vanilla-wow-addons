-- Minion support

lazyr.minion = {}

lazyr.minion.lastUpdate = 0
lazyr.minion.updateInterval = 0.1


function lazyr.minion.OnUpdate()
   if (not lazyr.addOnIsActive) then
      return
   end
   if (not lazyr.perPlayerConf.minionIsVisible) then
      return
   end

   local now = GetTime()
   if (now >= (lazyr.minion.lastUpdate + lazyr.minion.updateInterval)) then
      lazyr.minion.lastUpdate = now

      if (lazyr.perPlayerConf.minionHidesOutOfCombat) then
         if (not lazyr.isInCombat and LazyRogueMinionFrame:IsShown()) then
            lazyr.d("You're not in combat, and the thing's showing, so I'm hiding it")
            LazyRogueMinionFrame:Hide()
         end
         if (lazyr.isInCombat and not LazyRogueMinionFrame:IsShown()) then
            lazyr.d("You're IN combat, and the thing's hidden, so I'm showing it")
            LazyRogueMinionFrame:Show()
         end
      end

      if (lazyr.isInCombat) then
         local actions = lazyr.FindParsedForm(lazyr.perPlayerConf.defaultForm)
         if (actions) then
            lazyr.mock = true
            local whichAction = lazyr.TryActions(actions)
            lazyr.mock = false
            if (not whichAction) then
               whichAction = "...zzz..."
            end 
            lazyr.minion.SetText(whichAction)
         end
      end
   end
end

function lazyr.minion.OnEnter(button)
   GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
   GameTooltip:AddLine("LazyRogue v"..lazyr.version.." Minion.\n")
   GameTooltip:AddLine("Shift + Left Click to move me around.\n")
   GameTooltip:Show()
end

function lazyr.minion.OnLeave(button)
   GameTooltip:Hide()
end

function lazyr.minion.SetText(text)
   if (not text) then
      text = ""
   end
   LazyRogueMinionText:SetText(text)
end



-- Deathstimator support

lazyr.deathstimator = {}

function lazyr.deathstimator.OnUnitHealth(arg1)
   if (arg1 == "target") then
      -- MobInfo-2 required
      if (not MobHealth_GetTargetCurHP) then
         return
      end
      local hp = lazyr.masks.GetUnitHealth("target")
      lazyr.targetHealthHistory:AddInfo(hp)
   end
end


-- Target Health History Object
-- Used for computing the best fit line (slope) for the Target's health.
--
-- Compute the best slope using the method of least squares.
-- http://www.acad.sunytccc.edu/instruct/sbrown/stat/leastsq.htm
--
-- Wow, I NEVER thought I'd ever use ANYTHING like this in real life.
-- Haha, and then, it's only for a computer game.
-- Ms. Chen, my high school Calculus teacher, would be so proud.  Nah, 
-- probably still too pissed at me.
--

lazyr.deathstimator.HealthHistory = {}

function lazyr.deathstimator.HealthHistory:New()
   local obj = {}
   setmetatable(obj, { __index = self })
   lazyr.deathstimator.HealthHistory.Reset(obj)
   return obj
end
function lazyr.deathstimator.HealthHistory:Reset()
   self.info = {}
   self.ctr = 0
   self.lastCtrComputed = 0
   self.m = 0
end
function lazyr.deathstimator.HealthHistory:AddInfo(hp)
   self.ctr = self.ctr + 1
   table.insert(self.info, { GetTime(), hp })
   -- Remove any leading entries older than the desired time window
   local oldest = math.floor(GetTime()) - lazyr.perPlayerConf.healthHistorySize
   local ct = 0
   while true do
      local healthInfo = self.info[1]
      if (not healthInfo) then
         break
      end
      local time = healthInfo[1]
      if (time >= oldest) then
         break
      end
      table.remove(self.info, 1)
      ct = ct + 1
   end
   --lazyr.d("AddInfo: trimmed "..ct.." expired entries.")
end
function lazyr.deathstimator.HealthHistory:GetN()
   return table.getn(self.info)
end
function lazyr.deathstimator.HealthHistory:ComputeSlope()
   local n = self:GetN()
   if (n == 0) then
      return nil
   end
   if (self.ctr == self.lastCtrComputed) then
      return self.m
   end
   self.lastCtrComputed = self.ctr

   local xSum = 0
   local ySum = 0
   local xSquaredSum = 0
   local xySum = 0
   for idx, healthInfo in ipairs(self.info) do
      local time = healthInfo[1]
      local hp = healthInfo[2]
      -- time is the x access, hp is the y access
      xSum = xSum + time
      ySum = ySum + hp
      xSquaredSum = xSquaredSum + (time * time)
      xySum = xySum + (time * hp)
   end

   if (self.xSquaredSum == 0 or self.xSum == 0) then
      return nil
   end

   self.m = ( (n * xySum) - (xSum * ySum) ) / ( (n * xSquaredSum) - (xSum * xSum) )

   return self.m
end




-- Deathstimator minion

lazyr.deathstimator.minion = {}
lazyr.deathstimator.minion.lastUpdate = 0
lazyr.deathstimator.minion.updateInterval = 0.25


function lazyr.deathstimator.minion.OnUpdate()
   if (not lazyr.addOnIsActive) then
      return
   end
   if (not lazyr.perPlayerConf.deathMinionIsVisible) then
      return
   end

   local now = GetTime()
   if (now >= (lazyr.deathstimator.minion.lastUpdate + lazyr.deathstimator.minion.updateInterval)) then
      lazyr.deathstimator.minion.lastUpdate = now

      if (lazyr.perPlayerConf.deathMinionHidesOutOfCombat) then
         if (not lazyr.isInCombat and LazyRogueDeathstimatorFrame:IsShown()) then
            lazyr.d("You're not in combat, and the death thing's showing, so I'm hiding it")
            LazyRogueDeathstimatorFrame:Hide()
         end
         if (lazyr.isInCombat and not LazyRogueDeathstimatorFrame:IsShown()) then
            lazyr.d("You're IN combat, and the death thing's hidden, so I'm showing it")
            LazyRogueDeathstimatorFrame:Show()
         end
      end

      if (not UnitName("target")) then
         return
      end

      if (lazyr.isInCombat) then
         local text

         local n = lazyr.targetHealthHistory:GetN()
         -- we want at least a couple data points
         if (n < 3) then
            text = "...gathering..."
         else
            -- m is the slope, or hp per second
            local m = lazyr.targetHealthHistory:ComputeSlope()
            if (m) then
               local currentHp = lazyr.masks.GetUnitHealth("target")
               local secondsTilDeath = math.abs(currentHp / m)
               text = "Death in "..string.format("%.1f", secondsTilDeath).."s"..
                  " ("..math.abs(string.format("%.1f", m)).."hp/s)"
            end
         end
         lazyr.deathstimator.minion.SetText(text)
      end
   end
end

function lazyr.deathstimator.minion.OnEnter(button)
   GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
   GameTooltip:AddLine("LazyRogue v"..lazyr.version.." Deathstimator.\n")
   GameTooltip:AddLine("Shift + Left Click to move me around.\n")
   GameTooltip:Show()
end

function lazyr.deathstimator.minion.OnLeave(button)
   GameTooltip:Hide()
end

function lazyr.deathstimator.minion.SetText(text)
   if (not text) then
      text = ""
   end
   LazyRogueDeathstimatorText:SetText(text)
end




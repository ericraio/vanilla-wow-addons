local elapsed = 0

-- dIsInSeconds is passed by custom clients if they want to save on maths
-- dontRegister is passed by custom clients if they need to call Stop/Failed/Delayed manually
function oCB:SpellStart(s, d, dIsInSeconds, dontRegister)
	self:Debug(string.format("SpellStart - %s | %s (%s)%s", s, d, dIsInSeconds and "s" or "ms", dontRegister and " | Not Registering" or ""))
    
    if not dontRegister then
        self:RegisterEvent("SPELLCAST_STOP", "SpellStop")
        self:RegisterEvent("SPELLCAST_INTERRUPTED","SpellFailed")
        self:RegisterEvent("SPELLCAST_FAILED", "SpellFailed")
        self:RegisterEvent("SPELLCAST_DELAYED", "SpellDelayed")
    end
	
	local c = self.db.profile.Colors.Casting
		
	self.startTime = GetTime()
    
    if not dIsInSeconds then
        d = d/1000
    end
	self.maxValue = self.startTime + d
	
	self.frames.CastingBar.Bar:SetStatusBarColor(c.r, c.g, c.b)
	self.frames.CastingBar.Bar:SetMinMaxValues(self.startTime, self.maxValue )
	self.frames.CastingBar.Bar:SetValue(0)
	self.frames.CastingBar.Spell:SetText(s)
	self.frames.CastingBar:SetAlpha(1)
	self.frames.CastingBar.Time:SetText("")
	self.frames.CastingBar.Delay:SetText("")
		
	self.holdTime 	= 0
	self.delay 		= 0
	self.casting 		= 1
	self.fadeOut 	= nil
	
	self.frames.CastingBar:Show()
	self.frames.CastingBar.Spark:Show()
end

-- Arg is for custom clients
function oCB:SpellStop(dontUnregister)
	self:Debug("SpellStop - Stopping cast")		
	local c = self.db.profile.Colors.Complete
	
	self.frames.CastingBar.Bar:SetValue(self.maxValue)
	
	if not self.channeling then
		self.frames.CastingBar.Bar:SetStatusBarColor(c.r, c.g, c.b)
		self.frames.CastingBar.Spark:Hide()
	end
	
	self.delay 		= 0
	self.casting 		= nil
	self.fadeOut 	= 1
	
    if not dontUnregister then
        self:UnregisterEvent("SPELLCAST_STOP")
        self:UnregisterEvent("SPELLCAST_FAILED")
        self:UnregisterEvent("SPELLCAST_INTERRUPTED")
        self:UnregisterEvent("SPELLCAST_DELAYED")
    end
end

function oCB:SpellFailed(dontUnregister)
	local c = self.db.profile.Colors.Failed

	self.frames.CastingBar.Bar:SetValue(self.maxValue)
	self.frames.CastingBar.Bar:SetStatusBarColor(c.r, c.g, c.b)
	self.frames.CastingBar.Spark:Hide()
	
	if (event == "SPELLCAST_FAILED") then
		self.frames.CastingBar.Spell:SetText(FAILED)
	else
		self.frames.CastingBar.Spell:SetText(INTERRUPTED)
	end
	
	self.casting 		= nil
	self.channeling 	= nil
	self.fadeOut	= 1
	self.holdTime = GetTime() + 1
    
    if not dontUnregister then
        self:UnregisterEvent("SPELLCAST_STOP")
        self:UnregisterEvent("SPELLCAST_FAILED")
        self:UnregisterEvent("SPELLCAST_INTERRUPTED")
        self:UnregisterEvent("SPELLCAST_DELAYED")
    end
end

function oCB:SpellDelayed(d)
	self:Debug(string.format("SpellDelayed - Spell delayed with %s", d/1000))
	d = d / 1000
	
	if(self.frames.CastingBar:IsShown()) then
		if self.delay == nil then self.delay = 0 end
		
		self.startTime = self.startTime + d
		self.maxValue = self.maxValue + d
		self.delay = self.delay + d
		
		self.frames.CastingBar.Bar:SetMinMaxValues(self.startTime, self.maxValue)
	end
end

function oCB:SpellChannelStart(d)
	self:Debug("SpellChannelStart - Starting channel")
	d = d / 1000
	local c = self.db.profile.Colors.Channel
	
	self.startTime = GetTime()
	self.endTime = self.startTime + d
	self.maxValue = self.endTime
	
	self.frames.CastingBar.Bar:SetStatusBarColor(c.r, c.g, c.b)
	self.frames.CastingBar.Bar:SetMinMaxValues(self.startTime, self.endTime)
	self.frames.CastingBar.Bar:SetValue(self.endTime)
	self.frames.CastingBar.Spell:SetText(arg2)
	self.frames.CastingBar.Time:SetText("")
	self.frames.CastingBar.Delay:SetText("")
	self.frames.CastingBar:SetAlpha(1)
	
	self.holdTime 	= 0
	self.casting		= nil
	self.channeling 	= 1
	self.fadeOut 	= nil
	
	self.frames.CastingBar:Show()
	self.frames.CastingBar.Spark:Show()
end

function oCB:SpellChannelStop()
	self:Debug("SpellChannelStop - Stopping channel")
	if not self.channeling then return end
	local c = self.db.profile.Colors.Complete
	
	self.frames.CastingBar.Bar:SetValue(self.endTime)
	self.frames.CastingBar.Bar:SetStatusBarColor(c.r, c.g, c.b)
	self.frames.CastingBar.Spark:Hide()
	
	self.delay = 0
	self.casting = nil
	self.channeling = nil
	self.fadeOut = 1
end

function oCB:SpellChannelUpdate(d)
	self:Debug("SpellChannelUpdate - Updating channel")
	d = d / 1000
	
	if(self.frames.CastingBar:IsShown()) then
		local origDuration = self.endTime - self.startTime
		
		if self.delay == nil then self.delay = 0 end
		
		self.delay = self.delay + d
		self.endTime = GetTime() + d
		self.maxValue = self.endTime
		self.startTime = self.endTime - origDuration
		
		self.frames.CastingBar.Bar:SetMinMaxValues(self.startTime, self.endTime)
	end
end

function oCB:OnCasting()
	elapsed= elapsed + arg1
	if(oCB.casting) then
		local delay, n, sp = false, GetTime(), 0
		
		if ( n > oCB.maxValue ) then n = oCB.maxValue end
		
		oCB.frames.CastingBar.Time:SetText(string.format( "%.1f", math.max(oCB.maxValue - n, 0.0)))
		
		if (oCB.delay ~= 0) then delay = 1 end
		if (delay) then
			oCB.frames.CastingBar.Delay:SetText("+"..string.format("%.1f", oCB.delay or "" ))
		else 
			oCB.frames.CastingBar.Delay:SetText("")
		end
		
		oCB.frames.CastingBar.Bar:SetValue(n)
		
		local w = oCB.frames.CastingBar.Bar:GetWidth()
		sp = ((n - oCB.startTime) / (oCB.maxValue - oCB.startTime)) * w
		if( sp < 0 ) then sp = 0 end
		
		oCB.frames.CastingBar.Spark:SetPoint("CENTER", oCB.frames.CastingBar.Bar, "LEFT", sp, 0)
	elseif (oCB.channeling) then
		local delay, n, sp = false, GetTime(), 0
		
		if (n > oCB.endTime) then n = oCB.endTime end
		if (n == oCB.endTime) then
			oCB.channeling = nil
			oCB.fadeOut = 1
			return
		end

		local b = oCB.startTime + (oCB.endTime - n)
		
		oCB.frames.CastingBar.Time:SetText(string.format( "%.1f", math.max(oCB.maxValue - n, 0.0)))
		
		if (oCB.delay and oCB.delay ~= 0) then delay = 1 end
		if (delay) then
			oCB.frames.CastingBar.Delay:SetText("-"..string.format("%.1f", oCB.delay ))
		else 
			oCB.frames.CastingBar.Delay:SetText("")
		end
		
		oCB.frames.CastingBar.Bar:SetValue(b)
		
		local w = oCB.frames.CastingBar.Bar:GetWidth()
		sp = ((b - oCB.startTime) / (oCB.endTime - oCB.startTime)) * w
		
		oCB.frames.CastingBar.Spark:SetPoint("CENTER", oCB.frames.CastingBar.Bar, "LEFT", sp, 0)
	elseif(GetTime() < oCB.holdTime) then
		return
	elseif(oCB.fadeOut) then
		local a = this:GetAlpha() - .05
		
		if (a > 0) then
			oCB.frames.CastingBar:SetAlpha(a)
		else
			oCB.fadeOut = nil
			oCB.frames.CastingBar:Hide()
			oCB.frames.CastingBar.Time:SetText("")
			oCB.frames.CastingBar.Delay:SetText("")
			oCB.frames.CastingBar:SetAlpha(1)
		end
	end
end
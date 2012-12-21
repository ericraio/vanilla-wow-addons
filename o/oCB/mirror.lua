local elapsed = 0

function oCB:MIRROR_TIMER_START(type, value, maxValue, scale, pause, text)
	self:Debug("MIRROR_TIMER_START - %s | %s | %s | %s | %s | %s", type, value, maxValue, scale, pause, text)
	
	oCB.frames[type].value = (value / 1000)
	oCB.frames[type].scale = scale
	
	if ( pause > 0 ) then CB.frames[type].pause = 1
	else oCB.frames[type].pause = nil end
	
	oCB.frames[type].Spell:SetText(text)

	local c = self.db.profile.Mirror[type]
	oCB.frames[type].Bar:SetMinMaxValues(0, (maxValue / 1000))
	oCB.frames[type].Bar:SetValue(oCB.frames[type].value)
	oCB.frames[type].Bar:SetStatusBarColor(c.r, c.g, c.b)

	if(not oCB.frames[type]:IsShown()) then
		oCB.frames[type]:Show()
		oCB.frames[type].Spark:Show()
		oCB.frames[type].Time:Show()
	end
end

function oCB:MIRROR_TIMER_PAUSE(pause)
	if ( pause > 0 ) then
		this.pause = 1
	else
		this.pause = nil
	end
end

function oCB:MIRROR_TIMER_STOP(type)
	self:Debug("MIRROR_TIMER_STOP - %s", type)
	
	oCB.frames[type]:Hide()
end

function oCB:OnMirror()
	if ( this.pause ) then
		return
	end
	this.value = (this.value + this.scale * arg1)
	this.Bar:SetValue(this.value)
	
	local w, _, max = this.Bar:GetWidth(), this.Bar:GetMinMaxValues()
	sp = ( this.value / max ) * w
	
	if( sp < 0 ) then sp = 0 end
	if(sp > w) then
		this.Time:Hide()
		this.Spark:Hide()
	else
		this.Time:SetText(string.format( "%.1f", math.max(this.value)))
		this.Spark:SetPoint("CENTER", this.Bar, "LEFT", sp, 0)
	end
end
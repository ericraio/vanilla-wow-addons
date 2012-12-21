local module = ArcHUD:NewModule("MirrorTimer")
module.unit = "player"
module.defaults = {
	Enabled = true,
	Outline = true,
	ShowSpell = true,
	Side = 1,
	Level = -1,
}
module.options = {
	{name = "ShowSpell", text = "SHOWSPELL", tooltip = "SHOWSPELL"},
	attach = true,
}
module.localized = true
module.disableEvents = {
	{frame = "MirrorTimer1", hide = TRUE, events = {"MIRROR_TIMER_PAUSE", "MIRROR_TIMER_STOP", "PLAYER_ENTERING_WORLD"}},
	{frame = "MirrorTimer2", hide = TRUE, events = {"MIRROR_TIMER_PAUSE", "MIRROR_TIMER_STOP", "PLAYER_ENTERING_WORLD"}},
	{frame = "MirrorTimer3", hide = TRUE, events = {"MIRROR_TIMER_PAUSE", "MIRROR_TIMER_STOP", "PLAYER_ENTERING_WORLD"}},
	{frame = "UIParent", hide = FALSE, events = {"MIRROR_TIMER_START"}},
}

function module:Initialize()
	-- Setup the frame we need
	self.f = self:CreateRing(true, ArcHUDFrame)
	self.f:SetAlpha(0)

	self.Text = {}
	self.Text[1] = self:CreateFontString(self.f, "BACKGROUND", {140, 16}, 14, "CENTER", {1.0, 1.0, 1.0}, {"BOTTOM", "ArcHUDFrameCombo", "TOP", 0, 96})
	self.Text[2] = self:CreateFontString(self.f, "BACKGROUND", {140, 16}, 14, "CENTER", {1.0, 1.0, 1.0}, {"TOPLEFT", self.Text[1], "BOTTOMLEFT", 0, 0})
	self.Text[3] = self:CreateFontString(self.f, "BACKGROUND", {140, 16}, 14, "CENTER", {1.0, 1.0, 1.0}, {"TOPLEFT", self.Text[2], "BOTTOMLEFT", 0, 0})

	-- Override Update timer
	self:RegisterMetro(self.name .. "Update", self.UpdateTimers, 0.05, self)
end

function module:Update()
	if(self.db.profile.ShowSpell) then
		for i=1,3 do
			self.Text[i]:Show()
		end
	else
		for i=1,3 do
			self.Text[i]:Hide()
		end
	end

	if(self.db.profile.Outline) then
		self.f.BG:Show()
	else
		self.f.BG:Hide()
	end

	-- Clear all points for the ring
	self.f:ClearAllPoints()
	if(self.db.profile.Side == 1) then
		-- Attach to left side
		self.f:SetPoint("TOPLEFT", self.parent:GetModule("Anchors").Left, "TOPLEFT", self.db.profile.Level * -15, 0)
		self.f.BG:SetReversed(false)
		self.f:SetReversed(false)
	else
		-- Attach to right side
		self.f:SetPoint("TOPRIGHT", self.parent:GetModule("Anchors").Right, "TOPRIGHT", self.db.profile.Level * 15, 0)
		self.f.BG:SetReversed(true)
		self.f:SetReversed(true)
	end
	self.f.BG:SetAngle(180)
end

function module:Enable()
	self.f.fadeIn = 0.25
	self.f.fadeOut = 2

	self.f.dirty = true

	-- Register the events we will use
	self:RegisterEvent("MIRROR_TIMER_START")
	self:RegisterEvent("MIRROR_TIMER_PAUSE")
	self:RegisterEvent("MIRROR_TIMER_STOP")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- Activate the timers
	self:StartMetro(self.name .. "Update")
	self:StartMetro(self.name .. "Alpha")
	self:StartMetro(self.name .. "Fade")

	if(not self.timers) then
		self.timers = {count = 0}
		self.timer = 0
	end

	self.f:Show()
end

function module:UpdateTimers(elapsed)
	for i=1,MIRRORTIMER_NUMTIMERS do
		if(self.timers[i] and not self.timers[i].paused) then
			self.timers[i].value = self.timers[i].value + self.timers[i].scale * elapsed*1000
			if(self.timers[i].value > self.timers[i].maxvalue) then
				self.timers[i].value = self.timers[i].maxvalue
			end
			--self:Msg("Updating timer %d: %d time elapsed, value now: %d", i, elapsed*1000, self.timers[i].value)
			if(self.timer == i) then
				self.f:SetMax(self.timers[i].maxvalue)
				self.f:SetValue(self.timers[i].value)
			end
			local texttime = ""
			local time_remaining = self.timers[i].value
			if((time_remaining/1000) > 60) then
				local minutes = math.floor(time_remaining/60000)
				local seconds = math.floor(((time_remaining/60000) - minutes) * 60)
				if(seconds < 10) then
					texttime = minutes..":0"..seconds
				else
					texttime = minutes..":"..seconds
				end
			else
				local intlength = string.len(string.format("%u",time_remaining/1000))
				texttime = strsub(string.format("%f",time_remaining/1000),1,intlength+2)
			end
			self.Text[i]:SetText(self.timers[i].label..": "..texttime)
		else
			self.Text[i]:SetText("")
		end
	end
end

function module:MIRROR_TIMER_START()
	-- Find a free timer table
	local updTimer, newTimer
	for i=1,MIRRORTIMER_NUMTIMERS do
		if(self.timers[i] and self.timers[i].timer == arg1) then
			updTimer = i
			break
		end
	end
	if(not updTimer) then
		for i=1,MIRRORTIMER_NUMTIMERS do
			if(not self.timers[i]) then
				newTimer = i
				break
			end
		end
	end

	if(newTimer) then
		-- Add timer to table
		self.timers[newTimer] = {
			timer = arg1,
			value = arg2,
			maxvalue = arg3,
			scale = arg4,
			paused = (arg5 > 0 and arg5 or nil),
			label = arg6,
		}
		-- Switch ring color to the new timer
		self.f:UpdateColor(MirrorTimerColors[arg1])
		self.timer = newTimer
		self.timers.count = self.timers.count + 1
		--self:Msg("Adding new timer %d: %s, %d, %d, %d, %d, %s", newTimer, arg1, arg2, arg3, arg4, arg5, arg6)
	elseif(updTimer) then
		-- Update existing timer
		self.timers[updTimer] = {
			timer = arg1,
			value = arg2,
			maxvalue = arg3,
			scale = arg4,
			paused = (arg5 > 0 and arg5 or nil),
			label = arg6,
		}
		--self:Msg("Updating timer %d: %s, %d, %d, %d, %d, %s", updTimer, arg1, arg2, arg3, arg4, arg5, arg6)
	end
	if(ArcHUD.db.profile.FadeIC > ArcHUD.db.profile.FadeOOC) then
		self.f:SetRingAlpha(ArcHUD.db.profile.FadeIC)
	else
		self.f:SetRingAlpha(ArcHUD.db.profile.FadeOOC)
	end
end

function module:MIRROR_TIMER_PAUSE()
	for i=1,MIRRORTIMER_NUMTIMERS do
		if(self.timers[i]) then
			self.timers[i].paused = (arg1 > 0 and 1 or nil)
		end
	end
end

function module:MIRROR_TIMER_STOP()
	for i=1,MIRRORTIMER_NUMTIMERS do
		if(self.timers[i] and self.timers[i].timer == arg1) then
			if(self.timers[i+1]) then
				self.timers[i] = self.timers[i+1]
				self.timers[i+1] = nil
			else
				self.timers[i] = nil
			end
			self.timers.count = self.timers.count - 1
			--self:Msg("Stopping timer %d: %s", i, arg1)
		end
	end
	if(self.timers.count == 0) then
		--self:Msg("No timers left, hiding")
		self.f:SetRingAlpha(0)
	else
		if(not self.timers[self.timer]) then
			for i=MIRRORTIMER_NUMTIMERS,1,-1 do
				if(self.timers[i]) then
					self.timer = i
					self.f:UpdateColor(MirrorTimerColors[self.timers[i].timer])
					break
				end
			end
		end
	end
end

function module:PLAYER_ENTERING_WORLD()
	for i=1,MIRRORTIMER_NUMTIMERS do
		self.timers[i] = nil
	end
	self.timers.count = 0
	self.f:SetRingAlpha(0)
end

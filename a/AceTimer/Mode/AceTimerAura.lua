--<< ====================================================================== >>--
-- Module Setup                                                               --
--<< ====================================================================== >>--
AceTimerAura = AceTimer:AddModule()

function AceTimerAura:Enable()
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",       "SPELL_PERIODIC")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",        "SPELL_PERIODIC")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",   "SPELL_PERIODIC")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",  "SPELL_PERIODIC")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",            "SPELL_PERIODIC")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",           "SPELL_PERIODIC")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",  "SPELL_PERIODIC")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "SPELL_PERIODIC")
end

function AceTimerAura:Disable()
	self:UnregisterAllEvents(self)
end

--<< ====================================================================== >>--
-- Main                                                                       --
--<< ====================================================================== >>--
function AceTimerAura:SPELL_PERIODIC()
	local aura, unit, isgain
	if     self:FindGlobal(arg1, AURAADDEDOTHERHARMFUL) then  -- "%s is afflicted by %s."
		aura = self.gs_captured[2]; unit = self.gs_captured[1]; isgain = FALSE
	elseif self:FindGlobal(arg1, AURAADDEDOTHERHELPFUL) then  -- "%s gains %s."
		aura = self.gs_captured[2]; unit = self.gs_captured[1]; isgain = TRUE
	elseif self:FindGlobal(arg1, AURAADDEDSELFHARMFUL)  then  -- "You are afflicted by %s."
		aura = self.gs_captured[1]; isgain = FALSE
	elseif self:FindGlobal(arg1, AURAADDEDSELFHELPFUL)  then -- "You gain %s."
		aura = self.gs_captured[1]; isgain = TRUE
	else
		return
	end

	local timer = self.timers[ACETIMER.EVENT][aura]
	if timer and timer.k.g == isgain and (timer.x.a or (timer.v and timer.v > GetTime())) then
		if timer.k.t then
			if not unit then unit = UnitName("player") end
			if timer.k.s then
				if timer.t and timer.t ~= unit then return end
			else
				if not UnitExists("target") or unit ~= UnitName("target") then return end
			end
		else
			if not timer.k.s or not unit then unit = "none" else return end
		end
		timer.v = nil; timer.t = nil;
		self:StartTimer(timer, aura, unit) 
	end
end

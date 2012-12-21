--<< ====================================================================== >>--
-- Module Setup                                                               --
--<< ====================================================================== >>--
AceTimerFade = AceTimer:AddModule({ 
	option = ACETIMER.OPT_FADE, 
	method = "CareOptFade", 
	desc = ACETIMER.OPT_FADE_DESC, 
})

function AceTimerFade:Enable()
	if self.GetOpt("NoFade") then return self:Disable() end
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF",  "SPELL_AURA_GONE_SELF")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "SPELL_AURA_GONE_OTHER")
end

function AceTimerFade:Disable()
	self:UnregisterAllEvents(self)
end

--<< ====================================================================== >>--
-- Fade processing                                                            --
--<< ====================================================================== >>--
function AceTimerFade:SPELL_AURA_GONE_SELF()
	if  self:FindGlobal(arg1, AURAREMOVEDSELF) then -- "%s fades from you."
		return self:KillBar(self.gs_captured[1])
	end
end

function AceTimerFade:SPELL_AURA_GONE_OTHER()
	if self:FindGlobal(arg1, AURAREMOVEDOTHER) then -- "%s fades from %s."
		return self:KillBar(self.gs_captured[1], self.gs_captured[2])
	end
end

--<< ====================================================================== >>--
-- Command Handlers                                                           --
--<< ====================================================================== >>--
function AceTimerFade:CareOptFade()
	if self.TogOpt("NoFade") then self:Disable() else self:Enable() end
	return self:Report()
end

function AceTimerFade:Report()
	return self.cmd:result(
		ACETIMER.OPT_FADE_TEXT, 
		ACETIMER.MAP_ONOFF[self.GetOpt("NoFade") or 0]
	)
end

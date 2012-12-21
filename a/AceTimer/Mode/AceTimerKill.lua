--<< ====================================================================== >>--
-- Setup                                                                      --
--<< ====================================================================== >>--
AceTimerKill = AceTimer:AddModule({ 
	option = ACETIMER.OPT_KILL, 
	method = "CareOptKill", 
	desc = ACETIMER.OPT_KILL_DESC,
})

function AceTimerKill:Enable()
	if self.GetOpt("NoKill") then return self:Disable() end
	self:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH", "COMBAT_DEATH")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH",  "COMBAT_DEATH")
	self:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN",        "COMBAT_DEATH")
end

function AceTimerKill:Disable()
	self:UnregisterAllEvents(self)
end

--<< ====================================================================== >>--
-- Main                                                                       --
--<< ====================================================================== >>--
function AceTimerKill:COMBAT_DEATH()
	if self:FindGlobal(arg1, UNITDESTROYEDOTHER) 
	then
		return self:KillBar(string.gsub(self.gs_captured[1], " [IVX]+$", ""), "none")
	elseif self:FindGlobal(arg1, UNITDIESOTHER) 
	or     self:FindGlobal(arg1, COMBATLOG_XPGAIN_FIRSTPERSON)
	then 
		return self:KillBars(self.gs_captured[1])
	end
end

--<< ====================================================================== >>--
-- Command Handlers                                                           --
--<< ====================================================================== >>--
function AceTimerKill:CareOptKill()
	if self.TogOpt("NoKill") then self:Disable() else self:Enable() end
	return self:Report()
end

function AceTimerKill:Report()
	return self.cmd:result(ACETIMER.OPT_KILL_TEXT, ACETIMER.MAP_ONOFF[self.GetOpt("NoKill") or 0])
end

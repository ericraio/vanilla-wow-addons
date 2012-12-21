--<< ====================================================================== >>--
-- Module Setup                                                               --
--<< ====================================================================== >>--
AceTimerSkill = AceTimer:AddModule({ 
	option = ACETIMER.OPT_SKILL, 
	method = "CareOptSkill", 
	desc = ACETIMER.OPT_SKILL_DESC, 
})

function AceTimerSkill:Enable()
	if self.GetOpt("NoSkill") then return self:Disable() end
	if self.timers[ACETIMER.SKILL] then 
		self:Hook("ActionButton_UpdateUsable")
	end
end

function AceTimerSkill:Disable()
	self:UnregisterAllEvents(self)
	self:UnhookAllScripts()
end

--<< ====================================================================== >>--
-- Main                                                                       --
--<< ====================================================================== >>--
function AceTimerSkill:ActionButton_UpdateUsable()
	local slot = ActionButton_GetPagedID(this)
	AceTimerTooltip:SetAction(slot)
	local name = AceTimerTooltipTextLeft1:GetText()
	local timer = self.timers[ACETIMER.SKILL][name]
	if timer then 
		if IsUsableAction(slot) then
			if not timer.v or timer.v < GetTime() then
				timer.v = GetTime() + 5
				self:StartTimer(timer, name)
			end
		else
			if timer.v then 
				timer.v = nil
				self:KillBar(name, "none")
			end
		end
	end
	return self:CallHook("ActionButton_UpdateUsable")
end

--<< ====================================================================== >>--
-- Command Handlers                                                           --
--<< ====================================================================== >>--
function AceTimerSkill:CareOptSkill()
	if self.TogOpt("NoSkill") then self:Disable() else self:Enable() end
	return self:Report()
end

function AceTimerSkill:Report()
	return self.cmd:result(
		ACETIMER.OPT_SKILL_TEXT, 
		ACETIMER.MAP_ONOFF[self.GetOpt("NoSkill") or 0]
	)
end

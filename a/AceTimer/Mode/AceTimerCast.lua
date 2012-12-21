--<< ====================================================================== >>--
-- Module Setup                                                               --
--<< ====================================================================== >>--
AceTimerCast = AceTimer:AddModule()

function AceTimerCast:Enable()
	self.captive    = {}
	self.active     = {}
	self.rank_cache = {}
	self.iscasting  = FALSE
	self:Hook("UseAction")
	self:Hook("CastSpell")
	self:Hook("CastSpellByName")
	self:Hook("SpellTargetUnit")
	self:Hook("TargetUnit")
	self:Hook("SpellStopTargeting")
	self:Hook("SpellStopCasting")
	self:HookScript(WorldFrame, "OnMouseDown")
	self:RegisterEvent("SPELLCAST_FAILED")
	self:RegisterEvent("SPELLCAST_INTERRUPTED")
	self:RegisterEvent("SPELLCAST_START")
	self:RegisterEvent("SPELLCAST_STOP")
	self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	self:RegisterEvent("PLAYER_DEAD")
end

function AceTimerCast:Disable()
	if self.captive    then self.captive    = nil end
	if self.active     then self.active     = nil end
	if self.iscasting  then self.iscasting  = nil end
	if self.rank_cache then self.rank_cache = nil end
	self:UnregisterAllEvents(self)
	self:UnhookAllScripts()
end

--<< ====================================================================== >>--
-- Helpers                                                                    --
--<< ====================================================================== >>--
function AceTimerCast:LEARNED_SPELL_IN_TAB()
	for k in self.rank_cache do
		self.rank_cache[k] = nil 
	end
end

function AceTimerCast:PLAYER_DEAD()
	self.active.t = nil; self.active.n = nil; self.active.u = nil; self.active.r = nil
	self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil
	self.iscasting = FALSE
	self:KillBars()
end

--<< ====================================================================== >>--
-- Catch Spellcast                                                            --
--<< ====================================================================== >>--
function AceTimerCast:UseAction(slot, clicked, onself)
	if not self.iscasting then
		if self.captive.n then 
			self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil 
		end
		if not GetActionText(slot) and HasAction(slot) then 
			AceTimerTooltipTextRight1:SetText("")
			AceTimerTooltip:SetAction(slot)
			local name = AceTimerTooltipTextLeft1:GetText()
			local timer = self.timers[ACETIMER.SPELL][name]
			if timer then 
				local rank = AceTimerTooltipTextRight1:GetText()
				if not rank then rank = 0 end
				self:CatchSpellcast(timer, name, rank, onself)
			end
		end
	end
	return self:CallHook("UseAction", slot, clicked, onself)
end

function AceTimerCast:CastSpell(index, booktype)
	if not self.iscasting then
		if self.captive.n then 
			self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil 
		end
		local name, rank = GetSpellName(index, booktype)
		local timer = self.timers[ACETIMER.SPELL][name]
		if timer then 
			if not rank or rank == "" then rank = 0 end
			self:CatchSpellcast(timer, name, rank)
		end
	end
	return self:CallHook("CastSpell", index, booktype)
end

function AceTimerCast:CastSpellByName(text, onself)
	if not self.iscasting then
		if self.captive.n then 
			self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil 
		end
		local _,_, name, rank = string.find(text, "^(.+)%("..ACETIMER.PAT_RANK.."%)%s*$")
		if not name then _,_, name = string.find(text, "^(.+)%(%)%s*$") end
		if not name then name = text end
		local timer = self.timers[ACETIMER.SPELL][name]
		if timer then 
			self:CatchSpellcast(timer, name, rank and tonumber(rank), oneself)
		end
	end
	return self:CallHook("CastSpellByName", text, onself)
end

function AceTimerCast:CatchSpellcast(timer, name, rank, onself)
	if not rank then 
		if self.rank_cache[name] then rank = self.rank_cache[name]
		else
			local i, sn, sr = 1
			while true do sn, sr = GetSpellName(i, BOOKTYPE_SPELL)
				if not sn then break 
				elseif sn == name then rank = sr
				elseif rank then break 
				end
				i = i + 1
			end
			if not rank or rank == "" then rank = 0 end
			self.rank_cache[name] = rank
		end
	end
	if type(rank) == "string" then
		local _,_, found = string.find(rank, ACETIMER.PAT_RANK)
		rank = found and tonumber(found) or 0
	end
	
	local unit
	if timer.k.t then
		if timer.k.s then 
			if onself and onself == 1 then unit = UnitName("player")
			elseif UnitExists("target") then
				if timer.k.g then 
					if UnitIsFriend("player", "target") then unit = UnitName("target") end
				else
					if UnitCanAttack("player", "target") then unit = UnitName("target") end
				end
			end
		else
			if UnitExists("target") then unit = UnitName("target") else return end
		end
	else
		unit = "none"
	end
	self.captive.t = timer; self.captive.n = name; self.captive.u = unit; self.captive.r = rank
end

--<< ====================================================================== >>--
-- Catch Spellcast Target                                                     --
--<< ====================================================================== >>--
function AceTimerCast:SpellTargetUnit(unit)
	if self.captive.n and not self.captive.u then 
		self.captive.u = UnitName(unit) 
	end
   	return self:CallHook("SpellTargetUnit", unit)
end

function AceTimerCast:TargetUnit(unit)
	if self.captive.n and not self.captive.u then 
		self.captive.u = UnitName(unit) 
	end
	return self:CallHook("TargetUnit", unit)
end

function AceTimerCast:OnMouseDown()
	if self.captive.n and not self.captive.u and arg1 == "LeftButton" and UnitExists("mouseover") then 
		self.captive.u = UnitName("mouseover") 
	end
	return self:CallScript(WorldFrame, "OnMouseDown", arg1)
end

--<< ====================================================================== >>--
-- Complete Spellcast                                                         --
--<< ====================================================================== >>--
function AceTimerCast:SPELLCAST_START()
	self.iscasting = TRUE
end

function AceTimerCast:SPELLCAST_STOP()
	self.iscasting = FALSE
	if self.captive.n then
		if self.captive.u == "none" then 
			self:StartTimer(self.captive.t, self.captive.n, self.captive.u, self.captive.r)
		else
			self.active.t = self.captive.t; self.active.n = self.captive.n; self.active.u = self.captive.u; self.active.r = self.captive.r
			Timex:AddSchedule("AceTimerCast", 0.5, nil, nil, self.CompleteCast, self)
		end
		self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil 
	end
end

function AceTimerCast:CompleteCast()
	if self.active.n then
		self:StartTimer(self.active.t, self.active.n, self.active.u, self.active.r)
		self.active.t = nil; self.active.n = nil; self.active.u = nil; self.active.r = nil
	end
end

--<< ====================================================================== >>--
-- Drop Spellcast                                                             --
--<< ====================================================================== >>--
function AceTimerCast:SpellStopCasting()
	if self.captive.n then
		self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil 
	end
	return self:CallHook("SpellStopCasting")
end

function AceTimerCast:SpellStopTargeting()
	if self.captive.n and SpellIsTargeting() then 
		self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil 
	end
	return self:CallHook("SpellStopTargeting")
end

function AceTimerCast:SPELLCAST_FAILED()
	if self.captive.n then
		self.captive.t = nil; self.captive.n = nil; self.captive.u = nil; self.captive.r = nil 
	end
	self.iscasting = FALSE
end

function AceTimerCast:SPELLCAST_INTERRUPTED()
	if self.active.n then 
		self.active.t = nil; self.active.n = nil; self.active.u = nil; self.active.r = nil
	end
end

function AceTimerCast:CHAT_MSG_SPELL_SELF_DAMAGE()
	if not self.active.n then return end
	if self:FindGlobal(arg1, SPELLDODGEDSELFOTHER)    -- "Your %s was dodged by %s."
	or self:FindGlobal(arg1, SPELLPARRIEDSELFOTHER)   -- "Your %s is parried by %s."
	or self:FindGlobal(arg1, SPELLEVADEDSELFOTHER)    -- "Your %s was evaded by %s."
	or self:FindGlobal(arg1, SPELLMISSSELFOTHER)      -- "Your %s missed %s."
	or self:FindGlobal(arg1, SPELLBLOCKEDSELFOTHER)   -- "Your %s was blocked by %s."
	or self:FindGlobal(arg1, SPELLRESISTSELFOTHER)    -- "Your %s was resisted by %s."
	or self:FindGlobal(arg1, SPELLIMMUNESELFOTHER)    -- "Your %s failed. %s is immune."
	or self:FindGlobal(arg1, SPELLLOGABSORBSELFOTHER) -- "Your %s is absorbed by %s."
	or self:FindGlobal(arg1, SPELLREFLECTSELFOTHER)   -- "Your %s is reflected back by %s."
	or self:FindGlobal(arg1, SPELLDEFLECTEDSELFOTHER) -- "Your %s was deflected by %s."
	then
		if self.gs_captured[1] == self.active.n and self.gs_captured[2] == self.active.u then 
			self.active.t = nil; self.active.n = nil; self.active.u = nil; self.active.r = nil
		end
	end
end

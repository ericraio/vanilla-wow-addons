--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerHunter = AceTimer:AddModule()

function AceTimerHunter:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "HUNTER" then 
		self:DelModule(self)
		AceTimerHunter = nil
		ACETIMER.HUNTER = nil
	end
end

function AceTimerHunter:Enable()
	self:Setup() 
	self:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE", "SPELL_PET_DAMAGE");
end

function AceTimerHunter:Disable()
	self:UnregisterAllEvents(self)
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerHunter:Setup()
	local A = ACETIMER
	local C = A.HUNTER
	
	self:AddGroup(1, TRUE,  "FUCHSIA")
	self:AddGroup(2, FALSE, "MAROON")
	
	self:AddTimer(A.SPELL, C.BESTIAL_WRATH,           15, 0,1,1)
	self:AddTimer(A.SPELL, C.CONCUSSIVE_SHOT,          4, 1,0,0, { ea={[C.IMPROVED_CONCUSSIVE_SHOT]=4} })
	self:AddTimer(A.SPELL, C.COUNTERATTACK,            5, 1,0,0)
	self:AddTimer(A.SPELL, C.DETERRENCE,              10, 0,1,1)
	self:AddTimer(A.SPELL, C.EXPLOSIVE_TRAP,          60, 0,0,0, { gr=1, rc=TRUE, ea={[C.EXPLOSIVE_TRAP_EFFECT]=60}  })
	self:AddTimer(A.SPELL, C.FREEZING_TRAP,           60, 0,0,0, { gr=1, rc=TRUE, ea={[C.FREEZING_TRAP_EFFECT]=60}   })
	self:AddTimer(A.SPELL, C.FROST_TRAP,              60, 0,0,0, { gr=1, rc=TRUE, ea={[C.FROST_TRAP_EFFECT]=60}      })
	self:AddTimer(A.SPELL, C.FLARE,                   30, 0,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.HUNTER_S_MARK,          120, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.IMMOLATION_TRAP,         60, 0,0,0, { gr=1, ea={[C.IMMOLATION_TRAP_EFFECT]=60} })
	self:AddTimer(A.SPELL, C.RAPID_FIRE,              10, 0,1,1)
	self:AddTimer(A.SPELL, C.SCARE_BEAST,             10, 1,0,0, { rc=TRUE, d={rs=5} })
	self:AddTimer(A.SPELL, C.SCATTER_SHOT,             4, 1,0,0)
	self:AddTimer(A.SPELL, C.SCORPID_STING,           20, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.SERPENT_STING,           15, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.VIPER_STING,              8, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.WING_CLIP,               10, 1,0,0, { rc=TRUE, ea={[C.IMPROVED_WING_CLIP]=10} })
	self:AddTimer(A.SPELL, C.WYVERN_STING,            12, 1,0,0, { gr=2, rc=TRUE })

	self:AddTimer(A.EVENT, C.EXPLOSIVE_TRAP_EFFECT,   20, 1,0,1, { gr=1, xn=C.EXPLOSIVE_TRAP })
	self:AddTimer(A.EVENT, C.FREEZING_TRAP_EFFECT,    10, 1,0,1, { gr=1, d={rs=5, tn=C.CLEVER_TRAPS, tb=0.15, tp=1}, xn=C.FREEZING_TRAP })
	self:AddTimer(A.EVENT, C.FROST_TRAP_EFFECT,       30, 0,0,0, { gr=1, d={tn=C.CLEVER_TRAPS, tb=0.15, tp=1}, xn=C.FROST_TRAP })
	self:AddTimer(A.EVENT, C.IMMOLATION_TRAP_EFFECT,  20, 1,0,1, { gr=1, xn=C.IMMOLATION_TRAP })
	self:AddTimer(A.EVENT, C.IMPROVED_CONCUSSIVE_SHOT, 3, 1,0,0, { cr="LIME", xn=C.CONCUSSIVE_SHOT })
	self:AddTimer(A.EVENT, C.IMPROVED_WING_CLIP,       5, 1,0,0, { cr="LIME", xn=C.WING_CLIP } )
	self:AddTimer(A.EVENT, C.QUICK_SHOTS,             12, 0,1,1, { a=1, cr="LIME", tx="Interface\\Icons\\Ability_Warrior_InnerRage" })

	self:AddTimer(A.SKILL, C.COUNTERATTACK,            5, 0,1,0, { cr="YELLOW", rc=TRUE })
	self:AddTimer(A.SKILL, C.MONGOOSE_BITE,            5, 0,1,0, { cr="YELLOW", rc=TRUE })
end

--<< ====================================================================== >>--
-- Trap Specific                                                              --
--<< ====================================================================== >>--
function AceTimerHunter:SPELL_PET_DAMAGE()
	if self:FindGlobal(arg1, SPELLRESISTOTHEROTHER) -- "%s's %s was resisted by %s.";
	then
		local event = self.timers[ACETIMER.EVENT][self.gs_captured[2]]
		if event and event.x.gr and event.x.gr == 1 and event.v and event.v > GetTime() then 
			if self.gs_captured[2] == ACETIMER.HUNTER.FROST_TRAP_EFFECT then
				self:StartTimer(ACETIMER.EVENT, self.gs_captured[2], "none") 
			else
				self:CleanGroup(event.x.gr, self.gs_captured[3])
			end
			event.v = nil
		end
	end
end

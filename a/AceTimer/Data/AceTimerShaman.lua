--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerShaman = AceTimer:AddModule()

function AceTimerShaman:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "SHAMAN" then 
		self:DelModule(self)
		AceTimerShaman = nil
		ACETIMER.SHAMAN = nil
	end
end

function AceTimerShaman:Enable()
	self:Setup()
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", "CountTotemHits");
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",    "CountTotemHits");
end

function AceTimerShaman:Disable()
	self:UnregisterAllEvents(self)
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerShaman:Setup()
	local A = ACETIMER
	local C = A.SHAMAN
	self:AddGroup(1, "GREEN",  FALSE)
	self:AddGroup(2, "MAROON", FALSE)
	self:AddGroup(3, "AQUA",   FALSE)
	self:AddGroup(4, "NAVY",   FALSE)
	
	self:AddTimer(A.SPELL, C.EARTHBIND_TOTEM,         45, 0,1,0, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.STONECLAW_TOTEM,         15, 0,1,0, { gr=1, rc=TRUE, h={rt={50,150,220,280,390,480} }})
	self:AddTimer(A.SPELL, C.STONESKIN_TOTEM,         120, 0,1,0, { gr=1, rc=TRUE, d={rt={45}} })
	self:AddTimer(A.SPELL, C.STRENGTH_OF_EARTH_TOTEM, 120, 0,1,0, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.TREMOR_TOTEM,            90, 0,1,0, { gr=1, rc=TRUE })
	
	self:AddTimer(A.SPELL, C.FIRE_NOVA_TOTEM,          5, 0,1,0, { gr=2, rc=TRUE, d={tn=C.IMPROVED_FIRE_TOTEMS, tb=-1}})
	self:AddTimer(A.SPELL, C.FLAMETONGUE_TOTEM,       120, 0,1,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.FROST_RESISTANCE_TOTEM,  120, 0,1,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.MAGMA_TOTEM,             20, 0,1,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.SEARING_TOTEM,           30, 0,1,0, { gr=2, rc=TRUE, d={rs=5} })
	
	self:AddTimer(A.SPELL, C.GRACE_OF_AIR_TOTEM,      120, 0,1,0, { gr=3, rc=TRUE })
	self:AddTimer(A.SPELL, C.GROUNDING_TOTEM,         45, 0,1,0, { gr=3, rc=TRUE })
	self:AddTimer(A.SPELL, C.NATURE_RESISTANCE_TOTEM, 120, 0,1,0, { gr=3, rc=TRUE })
	self:AddTimer(A.SPELL, C.SENTRY_TOTEM,           300, 0,1,0, { gr=3, rc=TRUE })
	self:AddTimer(A.SPELL, C.TRANQUIL_AIR_TOTEM,      90, 0,1,0, { gr=3, rc=TRUE })
	self:AddTimer(A.SPELL, C.WINDFURY_TOTEM,          120, 0,1,0, { gr=3, rc=TRUE })
	self:AddTimer(A.SPELL, C.WINDWALL_TOTEM,          120, 0,1,0, { gr=3, rc=TRUE })
	
	self:AddTimer(A.SPELL, C.DISEASE_CLEANSING_TOTEM, 120, 0,1,0, { gr=4, rc=TRUE })
--	self:AddTimer(A.SPELL, C.ENAMORED_WATER_SPIRIT,   24, 0,1,0, { gr=4, rc=TRUE, d={tn=C.EVENTIDE, tb=2} })
	self:AddTimer(A.SPELL, C.ENAMORED_WATER_SPIRIT,   24, 0,1,0, { gr=4, rc=TRUE })
	self:AddTimer(A.SPELL, C.FIRE_RESISTANCE_TOTEM,   120, 0,1,0, { gr=4, rc=TRUE })
--	self:AddTimer(A.SPELL, C.HEALING_STREAM_TOTEM,    60, 0,1,0, { gr=4, rc=TRUE, d={tn=C.EVENTIDE, tb=2} })
	self:AddTimer(A.SPELL, C.HEALING_STREAM_TOTEM,    60, 0,1,0, { gr=4, rc=TRUE })
--	self:AddTimer(A.SPELL, C.MANA_SPRING_TOTEM,       60, 0,1,0, { gr=4, rc=TRUE, d={tn=C.EVENTIDE, tb=2} })
	self:AddTimer(A.SPELL, C.MANA_SPRING_TOTEM,       60, 0,1,0, { gr=4, rc=TRUE })
	self:AddTimer(A.SPELL, C.MANA_TIDE_TOTEM,         12, 0,1,0, { gr=4, rc=TRUE })
	self:AddTimer(A.SPELL, C.POISON_CLEANSING_TOTEM,  120, 0,1,0, { gr=4, rc=TRUE })

	self:AddTimer(A.SPELL, C.EARTH_SHOCK,  2, 1,0,0)
	self:AddTimer(A.SPELL, C.FLAME_SHOCK, 12, 1,0,0, { rc=true})
	self:AddTimer(A.SPELL, C.FROST_SHOCK,  8, 1,0,0, { rc=true})
	self:AddTimer(A.SPELL, C.STORMSTRIKE, 12, 0,1,1)
	
	self:AddTimer(A.EVENT, C.ANCESTRAL_FORTITUDE,  15, 1,1,0, { cr="LIME", a=1, xn=C.ANCESTRAL_HEALING })
	self:AddTimer(A.EVENT, C.CLEARCASTING,         15, 0,1,1, { cr="LIME", a=1, tx="Interface\\Icons\\Spell_Shadow_ManaBurn" })
end

--<< ====================================================================== >>--
-- Totem Specifics                                                            --
--<< ====================================================================== >>--
function AceTimerShaman:CountTotemHits()
	if self:FindGlobal(arg1, COMBATHITOTHEROTHER)           -- "%s hits %s for %d."
	or self:FindGlobal(arg1, COMBATHITSCHOOLOTHEROTHER)     -- "%s hits %s for %d %s damage."
	or self:FindGlobal(arg1, COMBATHITCRITOTHEROTHER)       -- "%s crits %s for %d."
	or self:FindGlobal(arg1, COMBATHITCRITSCHOOLOTHEROTHER) -- "%s crits %s for %d %s damage."
	then 
		totem = string.gsub(self.gs_captured[2], " [IVX]+$", "")
		for i = 1, 20 do local bar = self.bars[i]
			if bar.name == totem then 
				if not bar.hits then 
					bar.hits = bar.timer.x.h and self:GetDuration(50, bar.timer.x.h, bar.rank) or 5
				end
				bar.hits = bar.hits - self.gs_captured[3]
				if bar.hits <= 0 then 
					TimexBar:StopBar(bar.id)
					return self:StopBar(bar.id)
				end
			end
		end
	end
end

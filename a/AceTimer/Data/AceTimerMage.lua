--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerMage = AceTimer:AddModule()

function AceTimerMage:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "MAGE" then 
		self:DelModule(self)
		AceTimerMage  = nil
		ACETIMER.MAGE = nil
	end
end

function AceTimerMage:Enable()
	return self:Setup()
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerMage:Setup()
	local A = ACETIMER
	local C = A.MAGE
	
	self:AddGroup(1, TRUE, "FUCHSIA")
	
	self:AddTimer(A.SPELL, C.ARCANE_POWER,  15, 0,1,1)
	self:AddTimer(A.SPELL, C.BLAST_WAVE,     6, 0,0,0)
	self:AddTimer(A.SPELL, C.CONE_OF_COLD,   8, 0,0,0, { rc=TRUE, d={tn=C.PERMAFROST, tb=1, ts=0.5} })
	self:AddTimer(A.SPELL, C.COUNTERSPELL,  10, 1,0,0, { ea={[C.COUNTERSPELL_SILENCED]=1} })
	self:AddTimer(A.SPELL, C.DETECT_MAGIC, 120, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.FIRE_WARD,     30, 0,1,1)
	self:AddTimer(A.SPELL, C.FIREBALL,       8, 1,0,0, { d={rt={4,6,6}} })
	self:AddTimer(A.SPELL, C.FLAMESTRIKE,    8, 0,0,0)
	self:AddTimer(A.SPELL, C.FROST_NOVA,     8, 0,0,0)
	self:AddTimer(A.SPELL, C.FROST_WARD,    30, 0,1,0)
	self:AddTimer(A.SPELL, C.FROSTBOLT,      9, 1,0,0, { d={rt={5,6,6,7,7,8,8}} })
	self:AddTimer(A.SPELL, C.ICE_BARRIER,   60, 0,1,1)
	self:AddTimer(A.SPELL, C.ICE_BLOCK,     10, 0,1,1)
	self:AddTimer(A.SPELL, C.MANA_SHIELD,   60, 0,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.POLYMORPH,     20, 1,0,0, { gr=1, rc=TRUE, d={rs=10} })
	self:AddTimer(A.SPELL, C.PYROBLAST,     12, 1,0,0)
	self:AddTimer(A.SPELL, C.SCORCH,         0, 1,0,0, { ea={[C.FIRE_VULNERABILITY]=1} })

	self:AddTimer(A.EVENT, C.CLEARCASTING,         15, 0,1,1, { cr="LIME", a=1, tx="Interface\\Icons\\Spell_Shadow_ManaBurn" })
	self:AddTimer(A.EVENT, C.COUNTERSPELL_SILENCED, 4, 1,0,0, { cr="LIME", xn=C.COUNTERSPELL })
	self:AddTimer(A.EVENT, C.FIRE_VULNERABILITY,   15, 1,0,0, { cr="LIME", xn=C.SCORCH })
	self:AddTimer(A.EVENT, C.FROSTBITE,             5, 1,0,1, { cr="LIME", a=1 }) 
	self:AddTimer(A.EVENT, C.IGNITE,                4, 1,0,1, { cr="LIME", a=1 })
	self:AddTimer(A.EVENT, C.IMPACT,                2, 1,0,0, { cr="LIME", a=1 })
end

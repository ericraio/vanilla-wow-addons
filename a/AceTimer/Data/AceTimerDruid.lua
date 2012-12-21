--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerDruid = AceTimer:AddModule()

function AceTimerDruid:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "DRUID" then 
		self:DelModule(self)
		AceTimerDruid = nil
		ACETIMER.DRUID = nil
	end
end

function AceTimerDruid:Enable()
	return self:Setup() 
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerDruid:Setup()
	local A = ACETIMER
	local C = A.DRUID
	self:AddGroup(1, TRUE,  "FUCHSIA")
	self:AddGroup(2, FALSE, "MAROON")
	self:AddGroup(3, TRUE,  "FUCHSIA")
	
	self:AddTimer(A.SPELL, C.ABOLISH_POISON,         8, 1,1,1)
	self:AddTimer(A.SPELL, C.BASH,                   2, 1,0,0, { d={rs=1, tn=C.BRUTAL_IMPACT, tb=0.5} })
	self:AddTimer(A.SPELL, C.BARKSKIN,              15, 0,1,1)
	self:AddTimer(A.SPELL, C.DASH,                  15, 0,1,1)
	self:AddTimer(A.SPELL, C.DEMORALIZING_ROAR,     30, 0,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.ENRAGE,                10, 0,1,1)
	self:AddTimer(A.SPELL, C.ENTANGLING_ROOTS,      10, 1,0,0, { gr=1, rc=TRUE, d={rs=3} })
	self:AddTimer(A.SPELL, C.FAERIE_FIRE,           40, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.FAERIE_FIRE_FERAL,     40, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.FERAL_CHARGE,           4, 1,0,0)
	self:AddTimer(A.SPELL, C.FRENZIED_REGENERATION, 10, 0,1,1)
	self:AddTimer(A.SPELL, C.HIBERNATE,             20, 1,0,0, { gr=3, rc=TRUE, d={rs=10}  })
	self:AddTimer(A.SPELL, C.INNERVATE,             20, 1,1,1)
	self:AddTimer(A.SPELL, C.INSECT_SWARM,          12, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.NATURE_S_GRASP,        45, 0,1,1, { cr="BLUE", ea={[C.ENTANGLING_ROOTS]=45} })
	self:AddTimer(A.SPELL, C.MOONFIRE,              12, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.POUNCE,                 2, 1,0,0, { ea={[C.POUNCE_BLEED]=1} })
	self:AddTimer(A.SPELL, C.RAKE,                   9, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.REGROWTH,              21, 1,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.REJUVENATION,          12, 1,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.RIP,                   12, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.SOOTHE_ANIMAL,         15, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.STARFIRE,               0, 1,0,0, { ea={[C.STARFIRE_STUN]=1} })
	self:AddTimer(A.SPELL, C.TIGER_S_FURY,           6, 0,1,1, { rc=TRUE })
	
	self:AddTimer(A.EVENT, C.ENTANGLING_ROOTS,      10, 1,0,1, { gr=1, d={rs=3} })
	self:AddTimer(A.EVENT, C.NATURE_S_GRACE,        15, 0,1,1, { cr="LIME", a=1 })

	self:AddTimer(A.EVENT, C.CLEARCASTING,          15, 0,1,1, { cr="LIME", a=1, tx="Interface\\Icons\\Spell_Shadow_ManaBurn" })
	self:AddTimer(A.EVENT, C.POUNCE_BLEED,          18, 1,0,0, { xn=C.POUNCE })
	self:AddTimer(A.EVENT, C.STARFIRE_STUN,          3, 1,0,0, { xn=C.STARFIRE })
end

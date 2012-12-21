--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerRogue = AceTimer:AddModule()

function AceTimerRogue:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "ROGUE" then 
		self:DelModule(self)
		AceTimerRogue = nil
		ACETIMER.ROGUE = nil
	end
end

function AceTimerRogue:Enable()
	return self:Setup()
end
--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerRogue:Setup()
	local A = ACETIMER
	local C = A.ROGUE
	
	self:AddTimer(A.SPELL, C.ADRENALINE_RUSH, 15, 0,1,1)
	self:AddTimer(A.SPELL, C.BLIND,           10, 1,0,0)
	self:AddTimer(A.SPELL, C.BLADE_FLURRY,    15, 0,1,1)
	self:AddTimer(A.SPELL, C.CHEAP_SHOT,       4, 1,0,0)
	self:AddTimer(A.SPELL, C.DISTRACT,        10, 0,0,0)
	self:AddTimer(A.SPELL, C.EVASION,         15, 0,1,1, { d={tn=C.IMPROVED_EVASION, tb=2} })
	self:AddTimer(A.SPELL, C.EXPOSE_ARMOR,    30, 1,0,0)
	self:AddTimer(A.SPELL, C.GARROTE,         18, 1,0,0, { d={tn=C.IMPROVED_GARROTE, tb=3} })
	self:AddTimer(A.SPELL, C.GOUGE,            4, 1,0,0, { d={tn=C.IMPROVED_GOUGE,   tb=0.5} })
	self:AddTimer(A.SPELL, C.HEMORRHAGE,      15, 1,0,0)
	self:AddTimer(A.SPELL, C.KICK,             5, 1,0,0, { ea={[C.KICK_SILENCED]=1} })
	self:AddTimer(A.SPELL, C.KIDNEY_SHOT,      1, 1,0,0, { d={rs=1, cp=1} })
	self:AddTimer(A.SPELL, C.RIPOSTE,          6, 1,0,0)
	self:AddTimer(A.SPELL, C.RUPTURE,          6, 1,0,0, { d={cp=4} })
	self:AddTimer(A.SPELL, C.SAP,             25, 1,0,0, { d={rs=10} })
	self:AddTimer(A.SPELL, C.SLICE_AND_DICE,   9, 0,1,1, { d={cp=3, tn=C.IMPROVED_SLICE_AND_DICE, tb=15, tp=1} })
	self:AddTimer(A.SPELL, C.SPRINT,          15, 0,1,1)
	self:AddTimer(A.SPELL, C.VANISH,          10, 0,1,1)

	self:AddTimer(A.EVENT, C.KICK_SILENCED,    2, 1,0,0, { cr="LIME" })
	self:AddTimer(A.EVENT, C.MACE_STUN_EFFECT, 3, 1,0,0, { cr="LIME", a=1, xn=C.MACE_SPECIALIZATION })
	self:AddTimer(A.EVENT, C.REMORSELESS,     20, 0,1,1, { cr="LIME", a=1, xn=C.REMORSELESS_ATTACKS })
	
	self:AddTimer(A.SKILL, C.RIPOSTE,          5, 0,1,1, { cr="YELLOW" })
end

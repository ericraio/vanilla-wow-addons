--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerWarrior = AceTimer:AddModule()

function AceTimerWarrior:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "WARRIOR" then
		self:DelModule(self)
		AceTimerWarrior = nil
		ACETIMER.WARRIOR = nil
	end
end

function AceTimerWarrior:Enable()
	self:Setup()
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerWarrior:Setup()
	local A = ACETIMER
	local C = A.WARRIOR
	
	self:AddTimer(A.SPELL, C.BATTLE_SHOUT,       120, 0,1,0, { rc=TRUE, d={tn=C.BOOMING_VOICE, tp=TRUE, tb=10} })
	self:AddTimer(A.SPELL, C.BERSERKER_RAGE,      10, 0,1,1)
	self:AddTimer(A.SPELL, C.BLOODRAGE,           10, 0,1,1)
	self:AddTimer(A.SPELL, C.BLOODTHIRST,          0, 1,0,0, { ea={[C.BLOODTHIRST]=1} }) 
	self:AddTimer(A.SPELL, C.CHALLENGING_SHOUT,    6, 0,0,0)
	self:AddTimer(A.SPELL, C.CHARGE,               0, 1,0,0, { ea={[C.CHARGE_STUN]=1} })
	self:AddTimer(A.SPELL, C.CONCUSSION_BLOW,      5, 1,0,0)
	self:AddTimer(A.SPELL, C.DEATH_WISH,          30, 0,0,1)
	self:AddTimer(A.SPELL, C.DEMORALIZING_SHOUT,  30, 0,0,0, { rc=TRUE, d={tn=C.BOOMING_VOICE, tp=TRUE, tb=10} })
	self:AddTimer(A.SPELL, C.DISARM,              10, 1,0,0, { rc=TRUE, d={tn=C.IMPROVED_DISARM, tb=1} })
	self:AddTimer(A.SPELL, C.HAMSTRING,           15, 1,0,0, { rc=TRUE, ea={[C.IMPROVED_HAMSTRING]=5} })
	self:AddTimer(A.SPELL, C.INTERCEPT,            0, 1,0,0, { ea={[C.INTERCEPT_STUN]=1} })
	self:AddTimer(A.SPELL, C.INTIMIDATING_SHOUT,   8, 0,0,0)
	self:AddTimer(A.SPELL, C.LAST_STAND,          20, 0,1,1)
	self:AddTimer(A.SPELL, C.MOCKING_BLOW,         6, 1,0,0)
	self:AddTimer(A.SPELL, C.MORTAL_STRIKE,       10, 1,0,0)
	self:AddTimer(A.SPELL, C.PIERCING_HOWL,        6, 0,0,0)
	self:AddTimer(A.SPELL, C.PUMMEL,               4, 1,0,0)
	self:AddTimer(A.SPELL, C.RECKLESSNESS,        15, 0,1,1)
	self:AddTimer(A.SPELL, C.REND,                21, 1,0,0, { d={rt={9,12,15,18}} })
	self:AddTimer(A.SPELL, C.RETALIATION,         15, 0,1,1)
	self:AddTimer(A.SPELL, C.REVENGE,              0, 1,0,0, { ea={[C.REVENGE_STUN]=2} })
	self:AddTimer(A.SPELL, C.SHIELD_BASH,          6, 1,0,0, { ea={[C.SHIELD_BASH_SILENCED]=1} })
	self:AddTimer(A.SPELL, C.SHIELD_BLOCK,         5, 0,1,1, { d={tn=C.IMPROVED_SHIELD_BLOCK, tt={0.5, 1, 2}} })
	self:AddTimer(A.SPELL, C.SHIELD_WALL,         10, 0,1,1, { d={tn=C.IMPROVED_SHIELD_WALL, tb=3, ts=2} })
	self:AddTimer(A.SPELL, C.SUNDER_ARMOR,        30, 1,0,0, { rc=TRUE } )
	self:AddTimer(A.SPELL, C.SWEEPING_STRIKES,    20, 0,1,1)
	self:AddTimer(A.SPELL, C.TAUNT,                3, 1,0,0)
	self:AddTimer(A.SPELL, C.THUNDER_CLAP,        10, 0,0,0, { rc=TRUE, d={rs=4} })

	self:AddTimer(A.EVENT, C.BLOOD_CRAZE,          6, 0,1,1, { a=1, cr="LIME" })
	self:AddTimer(A.EVENT, C.BLOODTHIRST,          8, 0,1,1)
	self:AddTimer(A.EVENT, C.CHARGE_STUN,          1, 1,0,0, { xn=C.CHARGE })
	self:AddTimer(A.EVENT, C.DEEP_WOUNDS,         12, 1,0,0, { a=1, cr="LIME" })
	self:AddTimer(A.EVENT, C.ENRAGE,              12, 0,1,1, { a=1, cr="LIME" })
	self:AddTimer(A.EVENT, C.IMPROVED_HAMSTRING,   5, 1,0,0, { cr="LIME" })
	self:AddTimer(A.EVENT, C.INTERCEPT_STUN,       3, 1,0,0, { xn=C.INTERCEPT })
	self:AddTimer(A.EVENT, C.MACE_STUN_EFFECT,     3, 1,0,0, { cr="LIME", a=1, xn=C.MACE_SPECIALIZATION })
	self:AddTimer(A.EVENT, C.REVENGE_STUN,         3, 1,0,0, { cr="LIME", xn=C.REVENGE })
	self:AddTimer(A.EVENT, C.SHIELD_BASH_SILENCED, 3, 1,0,0, { cr="LIME", xn=C.SHIELD_BASH })
	
	self:AddTimer(A.SKILL, C.EXECUTE,              5, 0,1,1, { cr="YELLOW", rc=TRUE }) -- Only usable on enemies that have 20% or less health.
	self:AddTimer(A.SKILL, C.OVERPOWER,            5, 0,1,1, { cr="YELLOW", rc=TRUE }) -- Only useable after the target dodges.
	self:AddTimer(A.SKILL, C.REVENGE,              5, 0,1,1, { cr="YELLOW", rc=TRUE }) -- Revenge must follow a block, dodge or parry.
end

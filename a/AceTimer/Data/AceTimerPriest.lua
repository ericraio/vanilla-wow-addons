--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerPriest = AceTimer:AddModule()

function AceTimerPriest:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "PRIEST" then
		self:DelModule(self)
		AceTimerPriest = nil
		ACETIMER.PRIEST = nil
	end
end

function AceTimerPriest:Enable()
	return self:Setup()
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--

function AceTimerPriest:Setup()
	local A = ACETIMER
	local C = A.PRIEST
	
	self:AddTimer(A.SPELL, C.ABOLISH_DISEASE,    20, 1,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.DEVOURING_PLAGUE,   24, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.ELUNE_S_GRACE,      15, 0,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.FADE,               10, 0,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.FEEDBACK,           15, 0,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.HEX_OF_WEAKNESS,   120, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.HOLY_FIRE,          10, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.MIND_SOOTHE,        15, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.POWER_INFUSION,     15, 1,1,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.POWER_WORD_SHIELD,  30, 1,1,1, { ea={[C.WEAKENED_SOUL]=1} })
	self:AddTimer(A.SPELL, C.PSYCHIC_SCREAM,      8, 0,0,0)
	self:AddTimer(A.SPELL, C.RENEW,              15, 1,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.SHACKLE_UNDEAD,     30, 1,0,0, { rc=TRUE, d={rs=10} })
	self:AddTimer(A.SPELL, C.SHADOW_WORD_PAIN,   18, 1,0,0, { rc=TRUE, d={tn=C.IMPROVED_SHADOW_WORD_PAIN, tb=3} })
	self:AddTimer(A.SPELL, C.SILENCE,             5, 1,0,0)
	self:AddTimer(A.SPELL, C.STARSHARDS,          6, 1,0,0)
	self:AddTimer(A.SPELL, C.TOUCH_OF_WEAKNESS, 120, 0,1,1, { rc=TRUE })
	self:AddTimer(A.SPELL, C.VAMPIRIC_EMBRACE,   60, 1,0,0, { rc=TRUE })
	
	self:AddTimer(A.EVENT, C.BLACKOUT,              3, 1,0,0, { a=1 })
	self:AddTimer(A.EVENT, C.BLESSED_RECOVERY,      6, 0,1,1, { a=1 })
	self:AddTimer(A.EVENT, C.INSPIRATION,          15, 1,1,0, { a=1, tx="Interface\\Icons\\INV_Shield_06" })
	self:AddTimer(A.EVENT, C.SHADOW_VULNERABILITY, 15, 1,0,0, { a=1, xn=C.SHADOW_WEAVING })
	self:AddTimer(A.EVENT, C.SPIRIT_TAP,           15, 0,1,1, { a=1 })
	self:AddTimer(A.EVENT, C.WEAKENED_SOUL,        15, 1,0,1, { tx="Interface\\Icons\\Spell_Holy_AshesToAshes" })
end

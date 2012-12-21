--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerWarlock = AceTimer:AddModule()

function AceTimerWarlock:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "WARLOCK" then 
		self:DelModule(self)
		AceTimerWarlock = nil
		ACETIMER.WARLOCK = nil
	end
end

function AceTimerWarlock:Enable()
	self:Setup()
	self:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE", "SPELL_PET_DAMAGE");
end

function AceTimerWarlock:Disable()
	self:UnregisterAllEvents(self)
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerWarlock:Setup()
	local A = ACETIMER
	local C = A.WARLOCK
	self:AddGroup(1, TRUE,  "FUCHSIA")
	self:AddGroup(2, FALSE, "MAROON")
	self:AddGroup(3, TRUE,  "RED")
	
	self:AddTimer(A.SPELL, C.AMPLIFY_CURSE,          30, 0,1,1)
	self:AddTimer(A.SPELL, C.BANISH,                 20, 1,0,0, { gr=1, rc=TRUE, d={rs=10} })
	self:AddTimer(A.SPELL, C.CORRUPTION,             18, 1,0,0, { rc=TRUE, d={rt={12,15}} })
	self:AddTimer(A.SPELL, C.CURSE_OF_AGONY,         24, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.CURSE_OF_DOOM,          60, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.CURSE_OF_EXHAUSTION,    12, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.CURSE_OF_RECKLESSNESS, 120, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.CURSE_OF_SHADOW,       300, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.CURSE_OF_TONGUES,       30, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.CURSE_OF_WEAKNESS,     120, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.CURSE_OF_THE_ELEMENTS, 300, 1,0,0, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.DEATH_COIL,              3, 1,0,0)
	self:AddTimer(A.SPELL, C.FEAR,                   10, 1,0,0, { gr=3, rc=TRUE, d={rs=5} })
	self:AddTimer(A.SPELL, C.FEL_DOMINATION,         15, 0,1,1)
	self:AddTimer(A.SPELL, C.HOWL_OF_TERROR,         10, 0,0,0, { d={rs=5} })
	self:AddTimer(A.SPELL, C.IMMOLATE,               15, 1,0,0, { rc=TRUE })
	self:AddTimer(A.SPELL, C.SHADOW_BOLT,             0, 1,0,0, { ea={[C.SHADOW_VULNERABILITY]=2} })
	self:AddTimer(A.SPELL, C.SHADOW_WARD,            30, 0,1,1)
	self:AddTimer(A.SPELL, C.SHADOWBURN,              5, 1,0,0)
	self:AddTimer(A.SPELL, C.SIPHON_LIFE,            30, 1,0,0, { rc=TRUE })
	
	self:AddTimer(A.EVENT, C.AFTERMATH,               5, 0,1,1, { cr="LIME", a=1 })
	self:AddTimer(A.EVENT, C.ENSLAVE_DEMON,         300, 1,0,0, { cr="BLUE", a=1 })
	self:AddTimer(A.EVENT, C.PYROCLASM,               3, 0,1,1, { cr="LIME", a=1 })
	self:AddTimer(A.EVENT, C.SACRIFICE,              30, 0,1,1, { cr="LIME", a=1 })
	self:AddTimer(A.EVENT, C.SEDUCTION,              15, 1,0,1, { cr="RED" })
	self:AddTimer(A.EVENT, C.SHADOW_VULNERABILITY,   12, 1,0,0, { cr="LIME", xn=C.SHADOW_BOLT })
	self:AddTimer(A.EVENT, C.SHADOW_TRANCE,          10, 0,1,1, { cr="LIME", a=1, xn=C.NIGHTFALL })
	self:AddTimer(A.EVENT, C.SOUL_SIPHON,            10, 0,1,1, { cr="LIME", a=1, xn=C.DRAIN_SOUL })
end

--<< ====================================================================== >>--
-- Pet Spell Spicific                                                         --
--<< ====================================================================== >>--
function AceTimerWarlock:SPELL_PET_DAMAGE()
	if self:FindGlobal(arg1, SPELLCASTGOOTHERTARGETTED) -- "%s casts %s on %s.";
	or self:FindGlobal(arg1, SPELLCASTGOOTHER)          -- "%s casts %s.";
	then
		local timer = self.timers[ACETIMER.EVENT][self.gs_captured[2]]	
		if timer then 
			timer.t = self.gs_captured[3] or UnitName("pettarget")
			timer.v = GetTime() + 3
		end
	end
end

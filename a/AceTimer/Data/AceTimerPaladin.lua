--<< ====================================================================== >>--
-- Setup Module                                                               --
--<< ====================================================================== >>--
AceTimerPaladin = AceTimer:AddModule()

function AceTimerPaladin:Initialize()
	local _, eclass = UnitClass("player")
	if eclass ~= "PALADIN" then 
		self:DelModule(self)
		AceTimerPaladin  = nil
		ACETIMER.PALADIN = nil
	end
end

function AceTimerPaladin:Enable()
	return self:Setup()
end

--<< ====================================================================== >>--
-- Setup Timers                                                               --
--<< ====================================================================== >>--
function AceTimerPaladin:Setup()
	local A = ACETIMER
	local C = A.PALADIN
	self:AddGroup(1, FALSE, "AQUA")
	self:AddGroup(2, TRUE,  "NAVY")
	self:AddGroup(3, TRUE,  "FUCHSIA")
	self:AddTimer(A.SPELL, C.BLESSING_OF_FREEDOM,    10, 1,1,1, { gr=1, d={tn=C.GUARDIAN_S_FAVOR, tb=3} })
	self:AddTimer(A.SPELL, C.BLESSING_OF_KINGS,     300, 1,1,1, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.BLESSING_OF_LIGHT,     300, 1,1,1, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.BLESSING_OF_MIGHT,     300, 1,1,1, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.BLESSING_OF_PROTECTION,  6, 1,1,1, { gr=1, d={rs=2}, ea={[C.FORBEARANCE]=1} })
	self:AddTimer(A.SPELL, C.BLESSING_OF_SACRIFICE,  30, 1,1,1, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.BLESSING_OF_SALVATION, 300, 1,1,1, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.BLESSING_OF_SANCTUARY, 300, 1,1,1, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.BLESSING_OF_WISDOM,    300, 1,1,1, { gr=1, rc=TRUE })
	self:AddTimer(A.SPELL, C.CONSECRATION,            8, 0,0,0)
	self:AddTimer(A.SPELL, C.DIVINE_PROTECTION,       6, 0,1,1, { cr="BLUE", d={rs=2}, ea={[C.FORBEARANCE]=1} })
	self:AddTimer(A.SPELL, C.DIVINE_SHIELD,          10, 0,1,1, { cr="BLUE", d={rs=2}, ea={[C.FORBEARANCE]=1} })
	self:AddTimer(A.SPELL, C.HAMMER_OF_JUSTICE,       6, 1,0,0)
	self:AddTimer(A.SPELL, C.HOLY_SHIELD,            10, 1,0,0)
	self:AddTimer(A.SPELL, C.JUDGEMENT,               0, 1,0,0, { gr=2, ea={[C.JUDGEMENT_OF_JUSTICE]=1, [C.JUDGEMENT_OF_LIGHT]=1, [C.JUDGEMENT_OF_WISDOM]=1, [C.JUDGEMENT_OF_THE_CRUSADER]=1} })
	self:AddTimer(A.SPELL, C.LAY_ON_HANDS,            0, 1,1,1, { ea={[C.LAY_ON_HANDS]=2} })
	self:AddTimer(A.SPELL, C.REPENTANCE,              6, 1,0,0)
	self:AddTimer(A.SPELL, C.SEAL_OF_COMMAND,        30, 0,1,1, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.SEAL_OF_JUSTICE,        30, 0,1,1, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.SEAL_OF_LIGHT,          30, 0,1,1, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.SEAL_OF_RIGHTEOUSNESS,  30, 0,1,1, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.SEAL_OF_THE_CRUSADER,   30, 0,1,1, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.SEAL_OF_WISDOM,         30, 0,1,1, { gr=2, rc=TRUE })
	self:AddTimer(A.SPELL, C.TURN_UNDEAD,            10, 1,0,0, { gr=3, d={rs=5} })

	self:AddTimer(A.EVENT, C.FORBEARANCE,               60, 1,0,1, { tx="Interface\\Icons\\Spell_Holy_RemoveCurse" })
	self:AddTimer(A.EVENT, C.JUDGEMENT_OF_JUSTICE,      10, 1,0,0, { cr="RED", xn=C.SEAL_OF_JUSTICE })
	self:AddTimer(A.EVENT, C.JUDGEMENT_OF_LIGHT,        10, 1,0,0, { cr="RED", xn=C.SEAL_OF_LIGHT,  d={tn=C.LASTING_JUDGEMENT, tb=10} })
	self:AddTimer(A.EVENT, C.JUDGEMENT_OF_WISDOM,       10, 1,0,0, { cr="RED", xn=C.SEAL_OF_WISDOM, d={tn=C.LASTING_JUDGEMENT, tb=10} })
	self:AddTimer(A.EVENT, C.JUDGEMENT_OF_THE_CRUSADER, 10, 1,0,0, { cr="RED", xn=C.SEAL_OF_THE_CRUSADER })
	self:AddTimer(A.EVENT, C.LAY_ON_HANDS,             120, 1,1,1, { cr="BLUE" })
	self:AddTimer(A.EVENT, C.REDOUBT,                   10, 0,1,1, { cr="LIME", a=1 })
	self:AddTimer(A.EVENT, C.VENGEANCE,                  8, 0,1,1, { cr="LIME", a=1 })
	self:AddTimer(A.EVENT, C.VINDICATION,                8, 1,0,0, { cr="RED",  a=1 })
	
	self:AddTimer(A.SKILL, C.HAMMER_OF_WRATH,            5, 0,1,1, { cr="YELLOW" })
end
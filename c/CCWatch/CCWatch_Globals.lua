ETYPE_CC = 1;
ETYPE_DEBUFF = 2;
ETYPE_BUFF = 4;

function QuickLocalize(str)
-- just remove $1 & $2 args because we *know that the order is not changed*.
-- not fail proof if ever it occurs (should be a more clever function, and return found arguments order)
	str = string.gsub(str, ".%$", "");
	str = string.gsub(str, "%%s", "\(.+\)");
	return str;
end

function CCWatch_Globals()

CCWatch_Save = {}

CCWATCH = {}
CCWATCH.PROFILE = ""
CCWATCH.COMBO = 0
CCWATCH.STATUS = 0

CCWATCH.INVERT = false
CCWATCH.GROWTH = 0
CCWATCH.SCALE = 1
CCWATCH.WIDTH = 160
CCWATCH.ALPHA = 1

CCWATCH.VARIABLES_LOADED = false
CCWATCH.VARIABLE_TIMER = 0

-- time threshold before an event is trashed, may need to be raised in high lag situations
CCWATCH.THRESHOLD = 0.25

-- most recent unit aura seen
CCWATCH.UNIT_AURA = {}
CCWATCH.UNIT_AURA.TARGET = ""
CCWATCH.UNIT_AURA.TIME = 0

-- most recent effect seen
CCWATCH.EFFECT = {}
CCWATCH.EFFECT.TYPE = ""
CCWATCH.EFFECT.TARGET = ""
CCWATCH.EFFECT.TIME = 0
CCWATCH.EFFECT.STATUS = 0  -- 0 = no effect, 1 = applied, 2 = broken, 3 = faded

-- effect groups for each bar
CCWATCH.GROUPSCC = {}
CCWATCH.GROUPSCC[1] = {}
CCWATCH.GROUPSCC[1].EFFECT = {}

CCWATCH.GROUPSCC[2] = {}
CCWATCH.GROUPSCC[2].EFFECT = {}

CCWATCH.GROUPSCC[3] = {}
CCWATCH.GROUPSCC[3].EFFECT = {}

CCWATCH.GROUPSCC[4] = {}
CCWATCH.GROUPSCC[4].EFFECT = {}

CCWATCH.GROUPSCC[5] = {}
CCWATCH.GROUPSCC[5].EFFECT = {}

CCWATCH.GROUPSDEBUFF = {}
CCWATCH.GROUPSDEBUFF[1] = {}
CCWATCH.GROUPSDEBUFF[1].EFFECT = {}

CCWATCH.GROUPSDEBUFF[2] = {}
CCWATCH.GROUPSDEBUFF[2].EFFECT = {}

CCWATCH.GROUPSDEBUFF[3] = {}
CCWATCH.GROUPSDEBUFF[3].EFFECT = {}

CCWATCH.GROUPSDEBUFF[4] = {}
CCWATCH.GROUPSDEBUFF[4].EFFECT = {}

CCWATCH.GROUPSDEBUFF[5] = {}
CCWATCH.GROUPSDEBUFF[5].EFFECT = {}

CCWATCH.GROUPSBUFF = {}
CCWATCH.GROUPSBUFF[1] = {}
CCWATCH.GROUPSBUFF[1].EFFECT = {}

CCWATCH.GROUPSBUFF[2] = {}
CCWATCH.GROUPSBUFF[2].EFFECT = {}

CCWATCH.GROUPSBUFF[3] = {}
CCWATCH.GROUPSBUFF[3].EFFECT = {}

CCWATCH.GROUPSBUFF[4] = {}
CCWATCH.GROUPSBUFF[4].EFFECT = {}

CCWATCH.GROUPSBUFF[5] = {}
CCWATCH.GROUPSBUFF[5].EFFECT = {}

-- CC Durations according to rank
-- WARNING : in case of difference between skill and effect, separate strings have to be used.
-- (see Hunter 'Freeze Trap' for instance)

CCWATCH_SPELLS = {}
-- Warrior
CCWATCH_SPELLS[CCWATCH_REND] = {
	RANKS = 7,
	DURATION = {9, 12, 15, 18, 21, 21, 21}
}

-- Mage
CCWATCH_SPELLS[CCWATCH_POLYMORPH] = {
	RANKS = 4,
	DURATION = {20, 30, 40, 50}
}

CCWATCH_SPELLS[CCWATCH_FIREBALL] = {
	RANKS = 11,
	DURATION = {4, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8}
}

CCWATCH_SPELLS[CCWATCH_FROSTBOLT] = {
	RANKS = 10,
	DURATION = {5, 6, 6, 7, 7, 8, 8, 9, 9, 9}
}

-- Priest
CCWATCH_SPELLS[CCWATCH_SHACKLE] = {
	RANKS = 3,
	DURATION = {30, 40, 50}
}

-- Druid
CCWATCH_SPELLS[CCWATCH_ROOTS] = {
	RANKS = 6,
	DURATION = {12, 15, 18, 21, 24, 27}
}

CCWATCH_SPELLS[CCWATCH_BASH] = {
	RANKS = 3,
	DURATION = {2, 3, 4}
}

CCWATCH_SPELLS[CCWATCH_HIBERNATE] = {
	RANKS = 3,
	DURATION = {20, 30, 40}
}

-- Hunter
CCWATCH_SPELLS[CCWATCH_FREEZINGTRAP_SPELL] = {
	RANKS = 3,
	DURATION = {10, 15, 20},
	EFFECTNAME = CCWATCH_FREEZINGTRAP
}

CCWATCH_SPELLS[CCWATCH_SCAREBEAST] = {
	RANKS = 3,
	DURATION = {10, 15, 20}
}

-- Paladin
CCWATCH_SPELLS[CCWATCH_HOJ] = {
	RANKS = 4,
	DURATION = {3, 4, 5, 6}
}

CCWATCH_SPELLS[CCWATCH_TURNUNDEAD] = {
	RANKS = 3,
	DURATION = {10, 15, 20}
}

CCWATCH_SPELLS[CCWATCH_DIVINESHIELD] = {
	RANKS = 2,
	DURATION = {10, 12}
}

-- Warlock
CCWATCH_SPELLS[CCWATCH_FEAR] = {
	RANKS = 3,
	DURATION = {10, 15, 20}
}

CCWATCH_SPELLS[CCWATCH_HOWLOFTERROR] = {
	RANKS = 2,
	DURATION = {10, 15}
}

CCWATCH_SPELLS[CCWATCH_BANISH] = {
	RANKS = 2,
	DURATION = {20, 30}
}

-- Rogue
CCWATCH_SPELLS[CCWATCH_SAP] = {
	RANKS = 3,
	DURATION = {25, 35, 45}
}

CCWATCH.LASTTARGETS = {}

CCWATCH_TEXT_ON = QuickLocalize(AURAADDEDOTHERHARMFUL);
CCWATCH_TEXT_BREAK = QuickLocalize(AURADISPELOTHER);
CCWATCH_TEXT_OFF = QuickLocalize(AURAREMOVEDOTHER);

CCWATCH_TEXT_BUFF_ON = QuickLocalize(AURAADDEDOTHERHELPFUL);
CCWATCH_TEXT_DIE = QuickLocalize(UNITDIESOTHER);
CCWATCH_TEXT_DIEXP = strsub(CCWATCH_TEXT_DIE, 1, -2)..".+";
end

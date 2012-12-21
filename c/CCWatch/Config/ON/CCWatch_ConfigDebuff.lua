function CCWatch_ConfigDebuff()

-- required attributes: GROUP, LENGTH, DIMINISHES
--  ETYPE = Effect Type : ETYPE_CC Pure CC(Stun/Root), ETYPE_DEBUFF Debuff(Snare/DoT,...), ETYPE_BUFF Buff
--  GROUP = Bar this CC is placed on
--  LENGTH = Duration of CC
--  DIMINISHES = 0 never diminishes, 1 = always diminishes, 2 = diminishes on players only
-- optional attributes PVPCC, COMBO
--  PVPCC = if PVPCC exists this value will be used as the base max for a Player target
--  COMBO = if COMBO exists then Combo Points will be added to CC duration
--
-- TARGET, PLAYER, TIMER_START, TIMER_END, DIMINISH are required for all and should be initialized empty
-- MONITOR is required for all and should be initialized to true
-- WARN is required for all and should be initialized to 0

-- Rogue - Debuffs
CCWATCH.CCS[CCWATCH_RUPTURE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 2,
	DIMINISHES = 0,
	COMBO = true,
	A = 4, -- f(x) = A * x + LENGTH
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_GAROTTE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 2,
	LENGTH = 18,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_RIPOSTE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 6,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_IMPROVEDKICK] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 2,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Priest - Debuffs
CCWATCH.CCS[CCWATCH_SHADOWWORDPAIN] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 18,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_DEVOURINGPLAGUE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 4,
	LENGTH = 24,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}


-- Mage - Debuffs
CCWATCH.CCS[CCWATCH_FROSTBOLT] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 5,
	LENGTH = 5,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CONEOFCOLD] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 5,
	LENGTH = 8,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_COUNTERSPELL] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 4,
	LENGTH = 4,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_FIREBALL] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 4,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_PYROBLAST] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 12,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_IGNITE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 4,
	LENGTH = 4,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_FLAMESTRIKE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 8,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_BLASTWAVE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 5,
	LENGTH = 6,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_FROSTARMOR] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 5,
	LENGTH = 8,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Druid - Debuffs
CCWATCH.CCS[CCWATCH_MOONFIRE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 8,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Hunter - Debuffs
CCWATCH.CCS[CCWATCH_SERPENTSTING] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Paladin - Debuffs

-- Warlock - Debuffs
CCWATCH.CCS[CCWATCH_IMMOLATE] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 3,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CORRUPTION] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 2,
	LENGTH = 18,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFAGONY] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 24,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFEXHAUSTION] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 12,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFELEMENTS] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 300,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFSHADOW] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 300,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFTONGUES] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 30,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFWEAKNESS] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 120,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFRECKLESSNESS] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 120,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CURSEOFDOOM] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 60,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Warrior - Debuffs

-- Shaman - Debuffs

CCWATCH.CCS[CCWATCH_FROSTSHOCK] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 8,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_FLAMESHOCK] = {
	ETYPE = ETYPE_DEBUFF,
	GROUP = 1,
	LENGTH = 12,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}


-- Specific - Debuffs

end
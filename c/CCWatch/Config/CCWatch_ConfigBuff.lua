function CCWatch_ConfigBuff()

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

-- Rogue - Target Buffs
CCWATCH.CCS[CCWATCH_ADRENALINERUSH] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 3,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_ROGUESPRINT] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_EVASION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_BLADEFLURRY] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 4,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
-- Priest - Buffs
CCWATCH.CCS[CCWATCH_POWERWORDSHIELD] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 30,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_RENEW] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 4,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

CCWATCH.CCS[CCWATCH_POWERINFUSION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}


-- Mage - Buffs
CCWATCH.CCS[CCWATCH_ARCANEPOWER] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_EVOCATION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 8,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
-- Druid - Buffs
CCWATCH.CCS[CCWATCH_NATURESGRASP] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
	LENGTH = 45,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_REJUVENATION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 12,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_REGROWTH] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 3,
	LENGTH = 21,
	DIMINISHES = 0,
	MONITOR = false,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_DASH] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_INNERVATE] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 20,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_BARKSKIN] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 4,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_FREGEN] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

-- Hunter - Buffs
CCWATCH.CCS[CCWATCH_DETERRENCE] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_RAPIDFIRE] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
-- Paladin - Buffs
CCWATCH.CCS[CCWATCH_DIVINESHIELD] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 12,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_BOPROTECTION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_BOFREEDOM] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

-- Warlock - Buffs
CCWATCH.CCS[CCWATCH_SACRIFICE] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 30,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_SPELLSTONE] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 45,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
-- Warrior - Buffs
CCWATCH.CCS[CCWATCH_BERSERKERRAGE] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_BLOODRAGE] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 2,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = false,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_LASTSTAND] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 3,
	LENGTH = 20,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_RETALIATION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_SHIELDWALL] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_RECKLESSNESS] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
	LENGTH = 15,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
CCWATCH.CCS[CCWATCH_DEATHWISH] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 4,
	LENGTH = 30,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}
-- Specific - Buffs

-- Forsaken
CCWATCH.CCS[CCWATCH_WOTF] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 3,
	LENGTH = 5,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

-- Human
CCWATCH.CCS[CCWATCH_PERCEPTION] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 3,
	LENGTH = 20,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

end
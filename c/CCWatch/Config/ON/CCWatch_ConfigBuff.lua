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

-- Priest - Buffs
CCWATCH.CCS[CCWATCH_POWERWORDSHIELD] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
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


-- Mage - Buffs

-- Druid - Buffs

-- Hunter - Buffs

-- Paladin - Buffs
CCWATCH.CCS[CCWATCH_DIVINESHIELD] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 5,
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

-- Warlock - Buffs

-- Warrior - Buffs

-- Specific - Buffs

-- Forsaken
CCWATCH.CCS[CCWATCH_WOTF] = {
	ETYPE = ETYPE_BUFF,
	GROUP = 1,
	LENGTH = 5,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Human
CCWATCH.CCS[CCWATCH_PERCEPTION] = {
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
	DIMINISH = 1
}

end
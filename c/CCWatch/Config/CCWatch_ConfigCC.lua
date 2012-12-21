function CCWatch_ConfigCC()

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

-- Rogue - Stun/Root CCs
CCWATCH.CCS[CCWATCH_GOUGE] = {
	GROUP = 1,
	ETYPE = ETYPE_CC,
	LENGTH = 4,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_BLIND] = {
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 10,
	DIMINISHES = 1,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_SAP] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 45,
	PVPCC = 15,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_KS] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 1,
	DIMINISHES = 1,
	COMBO = true,
	A = 1, -- f(x) = A * x + LENGTH => 1 point = 2 sec, 5 point = 6 sec
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CS] = {
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 4,
	DIMINISHES = 1,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Priest - Stun/Root CCs
CCWATCH.CCS[CCWATCH_SHACKLE] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 30,	-- 40 50
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

CCWATCH.CCS[CCWATCH_PSYCHICSCREAM] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 8,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

CCWATCH.CCS[CCWATCH_BLACKOUT] = {
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 2,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0
}

-- Mage - Stun/Root CCs
CCWATCH.CCS[CCWATCH_POLYMORPH] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 20, -- 30 40 50
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_FROSTNOVA] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
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

CCWATCH.CCS[CCWATCH_FROSTBITE] = {
	ETYPE = ETYPE_CC,
	GROUP = 2,
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

CCWATCH.CCS[CCWATCH_ICEBLOCK] = {
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 10,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}


-- Druid - Stun/Root CCs
CCWATCH.CCS[CCWATCH_ROOTS] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 12, -- 15 18 21 24 27
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_HIBERNATE] = {
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 20, -- 30 40
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_FERALCHARGE] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 4,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_IMPSTARFIRE] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 3,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_POUNCE] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
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

CCWATCH.CCS[CCWATCH_BASH] = {
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 2, -- 2, 3, 4
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Hunter - Stun/Root CCs
CCWATCH.CCS[CCWATCH_FREEZINGTRAP] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_IMPCS] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_SCAREBEAST] = {
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_SCATTERSHOT] = {
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 4, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_INTIMIDATION] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 3, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_COUNTERATTACK] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
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

CCWATCH.CCS[CCWATCH_IMPROVEDWINGCLIP] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
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

CCWATCH.CCS[CCWATCH_WYVERNSTING] = {
	ETYPE = ETYPE_CC,
	GROUP = 5,
	LENGTH = 12,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_ENTRAPMENT] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
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

-- Paladin - Stun/Root CCs
CCWATCH.CCS[CCWATCH_HOJ] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 3, -- 4 5 6
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_REPENTANCE] = {
	ETYPE = ETYPE_CC,
	GROUP = 2,
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

CCWATCH.CCS[CCWATCH_TURNUNDEAD] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Warlock - Stun/Root CCs
CCWATCH.CCS[CCWATCH_SEDUCE] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 15,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_FEAR] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 10, -- 15 20 
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_HOWLOFTERROR] = {
	ETYPE = ETYPE_CC,
	GROUP = 2,
	LENGTH = 10, -- 15
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_DEATHCOIL] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 3,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_BANISH] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 20, -- 30
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Warrior - Stun/Root CCs
CCWATCH.CCS[CCWATCH_INTERCEPT] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_MACESPE] = {
	ETYPE = ETYPE_CC,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_IMPHAMSTRING] = {
	ETYPE = ETYPE_CC,
	GROUP = 3,
	LENGTH = 3,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_INTIMIDATINGSHOUT] = {
	ETYPE = ETYPE_CC,
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

CCWATCH.CCS[CCWATCH_IMPREVENGE] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 3,
	DIMINISHES = 0,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

CCWATCH.CCS[CCWATCH_CONCUSSIONBLOW] = {
	ETYPE = ETYPE_CC,
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

-- Specific - Stun/Root CCs

-- Tauren
CCWATCH.CCS[CCWATCH_WARSTOMP] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
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

-- Green Whelp Armour
CCWATCH.CCS[CCWATCH_SLEEP] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 30,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Net O Matic
CCWATCH.CCS[CCWATCH_NETOMATIC] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 10,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

-- Reckless Helmet
CCWATCH.CCS[CCWATCH_ROCKETHELM] = {
	ETYPE = ETYPE_CC,
	GROUP = 4,
	LENGTH = 30,
	DIMINISHES = 2,
	MONITOR = true,
	WARN = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1
}

end
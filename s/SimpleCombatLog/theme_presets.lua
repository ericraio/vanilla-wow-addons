local themes = {}
SimpleCombatLog.themes = themes

themes.default = {
	theme = 'default',
	suppress = true,
	colorspell = true,
	filters = {
		hit = { [1] = true, [2] = true, [8] = true, [9] = true },
		heal = { [1] = true, [2] = true, [8] = true, [9] = true },
		miss = { [1] = true, [2] = true, [8] = true, [9] = true },
		cast = { [1] = true, [2] = true, [8] = true, [9] = true },
		gain = { [1] = true, [2] = true, [8] = true, [9] = true },
		drain = { [1] = true, [2] = true, [8] = true, [9] = true },
		leech = { [1] = true, [2] = true, [8] = true, [9] = true },
		dispel = { [1] = true, [2] = true, [8] = true, [9] = true },
		buff = { [1] = true, [2] = true, [8] = true, [9] = true },
		debuff = { [1] = true, [2] = true, [8] = true, [9] = true },
		fade = { [1] = true, [2] = true, [8] = true, [9] = true },
		interrupt = { [1] = true, [2] = true, [8] = true, [9] = true },
		death = { [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true },
		environment = { [1] = true, [2] = true, [8] = true, [9] = true },
		extraattack = { [1] = true, [2] = true, [8] = true, [9] = true },
		enchant = { [1] = true, [2] = true, [8] = true, [9] = true },
	},
	events = SimpleCombatLog.events	
}

themes.myDmgDone = {
	["theme"] = "myDmgDone",
	["formats"] = {
		["hitCrit"] = "%4$s",
		["hit"] = "%4$s",
		["hitDOT"] = "%4$s~",
	},
	["events"] = {
		["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = true,
		["CHAT_MSG_COMBAT_SELF_HITS"] = true,
		["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = true,
		["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_SELF_DAMAGE"] = true,
	},
	["suppress"] = true,
	["resize"] = true,
	["filters"] = {
		["hit"] = {
			[1] = true,
		},
	},
}

themes.myDmgTaken = {
	["theme"] = "myDmgTaken",
	["formats"] = {
		["hitCrit"] = "%4$s",
		["hit"] = "%4$s",
		["hitDOT"] = "%4$s~",
	},
	["events"] = {
		["CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"] = true,
		["CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"] = true,
		["CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"] = true,
		["CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"] = true,
		["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS"] = true,
		["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = true,
	},
	["resize"] = true,
	["suppress"] = true,
	["filters"] = {
		["hit"] = {
			[8] = true,
		},
	},
}

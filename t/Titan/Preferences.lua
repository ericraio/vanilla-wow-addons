TITAN_ITEMBONUSES_SETNAME_PATTERN = "^(.*) %(%d/%d%)$";

TITAN_ITEMBONUSES_PREFIX_PATTERN = "^%+(%d+)%%?(.*)$";
TITAN_ITEMBONUSES_SUFFIX_PATTERN = "^(.*)%+(%d+)%%?$";


TitanItemBonuses_colors = {
	X = 'FFD200',  -- attributes
	Y = '20FF20',  -- skills
	M = 'FFFFFF',  -- melee
	R = '00C0C0',  -- ranged
	C = 'FFFF00',  -- spells
	A = 'FF60FF',  -- arcane
	I = 'FF3600',  -- fire
	F = '00C0FF',  -- frost
	H = 'FFA400',  -- holy
	N = '00FF60',  -- nature
	S = 'AA12AC',  -- shadow
	L = '20FF20',  -- life
	P = '6060FF',  -- mana
};


TITAN_ITEMBONUSES_EFFECTS = {
	{ effect = "STR",				name = TITAN_ITEMBONUSES_STR,	 			format = "+%d",		short = "XSTR",	cat = "ATT" },
	{ effect = "AGI",				name = TITAN_ITEMBONUSES_AGI, 				format = "+%d",		short = "XAGI",	cat = "ATT" },
	{ effect = "STA",				name = TITAN_ITEMBONUSES_STA, 				format = "+%d",		short = "XSTA",	cat = "ATT" },
	{ effect = "INT",				name = TITAN_ITEMBONUSES_INT, 				format = "+%d",		short = "XINT",	cat = "ATT" },
	{ effect = "SPI",				name = TITAN_ITEMBONUSES_SPI,	 			format = "+%d",		short = "XSPI",	cat = "ATT" },
	{ effect = "ARMOR",				name = TITAN_ITEMBONUSES_ARMOR,	 			format = "+%d",		short = "XARM",	cat = "ATT" },

	{ effect = "ARCANERES",			name = TITAN_ITEMBONUSES_ARCANERES,			format = "+%d",		short = "AR",	cat = "RES" },
	{ effect = "FIRERES",			name = TITAN_ITEMBONUSES_FIRERES, 			format = "+%d",		short = "IR",	cat = "RES" },
	{ effect = "NATURERES", 		name = TITAN_ITEMBONUSES_NATURERES, 		format = "+%d",		short = "NR",	cat = "RES" },
	{ effect = "FROSTRES",			name = TITAN_ITEMBONUSES_FROSTRES, 			format = "+%d",		short = "FR",	cat = "RES" },
	{ effect = "SHADOWRES",			name = TITAN_ITEMBONUSES_SHADOWRES,			format = "+%d",		short = "SR",	cat = "RES" },

	{ effect = "DEFENSE",			name = TITAN_ITEMBONUSES_DEFENSE, 			format = "+%d",		short = "YDEF",	cat = "SKILL" },
	{ effect = "MINING",			name = TITAN_ITEMBONUSES_MINING,			format = "+%d",		short = "YMIN",	cat = "SKILL" },
	{ effect = "HERBALISM",			name = TITAN_ITEMBONUSES_HERBALISM, 		format = "+%d",		short = "YHER",	cat = "SKILL" },
	{ effect = "SKINNING", 			name = TITAN_ITEMBONUSES_SKINNING, 			format = "+%d",		short = "YSKI",	cat = "SKILL" },
	{ effect = "FISHING",			name = TITAN_ITEMBONUSES_FISHING,			format = "+%d",		short = "YFIS",	cat = "SKILL" },

	{ effect = "ATTACKPOWER", 		name = TITAN_ITEMBONUSES_ATTACKPOWER, 		format = "+%d",		short = "MA",	cat = "BON" },
	{ effect = "CRIT",				name = TITAN_ITEMBONUSES_CRIT, 				format = "+%d%%",	short = "MC",	cat = "BON" },
	{ effect = "BLOCK",				name = TITAN_ITEMBONUSES_BLOCK, 			format = "+%d%%",	short = "MB",	cat = "BON" },
	{ effect = "DODGE",				name = TITAN_ITEMBONUSES_DODGE, 			format = "+%d%%",	short = "MD",	cat = "BON" },
	{ effect = "PARRY", 			name = TITAN_ITEMBONUSES_PARRY, 			format = "+%d%%",	short = "MP",	cat = "BON" },
	{ effect = "TOHIT", 			name = TITAN_ITEMBONUSES_TOHIT, 			format = "+%d%%",	short = "MH",	cat = "BON" },
	{ effect = "RANGEDATTACKPOWER", name = TITAN_ITEMBONUSES_RANGEDATTACKPOWER, format = "+%d",		short = "RA",	cat = "BON" },
	{ effect = "RANGEDCRIT",		name = TITAN_ITEMBONUSES_RANGEDCRIT,		format = "+%d%%",	short = "RC",	cat = "BON" },

	{ effect = "DMG",				name = TITAN_ITEMBONUSES_DMG, 				format = "+%d",		short = "CD",	cat = "SBON" },
	{ effect = "HEAL",				name = TITAN_ITEMBONUSES_HEAL, 				format = "+%d",		short = "CH",	cat = "SBON"},
	{ effect = "HOLYCRIT", 			name = TITAN_ITEMBONUSES_HOLYCRIT,			format = "+%d%%",	short = "CHC",	cat = "SBON" },
	{ effect = "SPELLCRIT", 		name = TITAN_ITEMBONUSES_SPELLCRIT,			format = "+%d%%",	short = "CSC",	cat = "SBON" },
	{ effect = "SPELLTOHIT", 		name = TITAN_ITEMBONUSES_SPELLTOHIT,		format = "+%d%%",	short = "CSH",	cat = "SBON" },
	{ effect = "ARCANEDMG", 		name = TITAN_ITEMBONUSES_ARCANEDMG, 		format = "+%d",		short = "AD",	cat = "SBON" },
	{ effect = "FIREDMG", 			name = TITAN_ITEMBONUSES_FIREDMG, 			format = "+%d",		short = "ID",	cat = "SBON" },
	{ effect = "FROSTDMG",			name = TITAN_ITEMBONUSES_FROSTDMG, 			format = "+%d",		short = "FD",	cat = "SBON" },
	{ effect = "HOLYDMG",			name = TITAN_ITEMBONUSES_HOLYDMG, 			format = "+%d",		short = "HD",	cat = "SBON" },
	{ effect = "NATUREDMG",			name = TITAN_ITEMBONUSES_NATUREDMG, 		format = "+%d",		short = "ND",	cat = "SBON" },
	{ effect = "SHADOWDMG",			name = TITAN_ITEMBONUSES_SHADOWDMG, 		format = "+%d",		short = "SD",	cat = "SBON" },

	{ effect = "HEALTH",			name = TITAN_ITEMBONUSES_HEALTH,			format = "+%d",		short = "LP",	cat = "OBON" },
	{ effect = "HEALTHREG",			name = TITAN_ITEMBONUSES_HEALTHREG,			format = "%d HP/5s",short = "LR",	cat = "OBON" },
	{ effect = "MANA",				name = TITAN_ITEMBONUSES_MANA, 				format = "+%d",		short = "PP",	cat = "OBON" },
	{ effect = "MANAREG",			name = TITAN_ITEMBONUSES_MANAREG, 			format = "%d MP/5s",short = "PR",	cat = "OBON" },
};

TITAN_ITEMBONUSES_CATEGORIES = {'ATT', 'BON', 'SBON', 'RES', 'SKILL', 'OBON'};
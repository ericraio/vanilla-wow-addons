------------------------------------------------------------------------------------------------------
-- Necrosis LdC
--
-- Créateur initial (US) : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Implémentation de base (FR) : Tilienna Thorondor
-- Reprise du projet : Lomig & Nyx des Larmes de Cenarius, Kael'Thas
--
-- Skins et voix Françaises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements spéciaux pour Sadyre (JoL)
-- Version 06.05.2006-1
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

NECROSIS_UNIT_WARLOCK = "Warlock";

NECROSIS_ANTI_FEAR_SPELL = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"Fear Ward",			-- Dwarf priest racial trait
		"Will of the Forsaken",		-- Forsaken racial trait
		"Fearless",			-- Trinket
		"Berzerker Rage",		-- Warrior Fury talent
		"Recklessness",			-- Warrior Fury talent
		"Death Wish",			-- Warrior Fury talent
		"Bestial Wrath",		-- Hunter Beast Mastery talent (pet only)
		"Ice Block",			-- Mage Ice talent
		"Divine Protection",		-- Paladin Holy buff
		"Divine Shield",		-- Paladin Holy buff
		"Tremor Totem",			-- Shaman totem
		"Abolish Magic"			-- Majordomo (NPC) spell
		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.		
	},

	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"Curse of Recklessness"		-- Warlock curse
	}
};

-- Creature type absolutly immune to fear effects
NECROSIS_ANTI_FEAR_UNIT = {
	"Undead"
};

-- Word to search for spell immunity. First (.+) replace the spell's name, 2nd (.+) replace the creature's name
NECROSIS_ANTI_FEAR_SRCH = "Your (.+) failed. (.+) is immune."

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Summon Felsteed",		Length = 0,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Summon Dreadsteed",		Length = 0,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Summon Imp",			Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Summon Voidwalker",		Length = 0,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Summon Succubus",		Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Summon Felhunter",		Length = 0,	Type = 0},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Bolt",			Length = 0,	Type = 0},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Inferno",			Length = 3600,	Type = 3},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Banish",			Length = 30,	Type = 2},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Enslave Demon",			Length = 30000,	Type = 2},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Soulstone Resurrection",	Length = 1800,	Type = 1},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Immolate",			Length = 15,	Type = 5},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fear",				Length = 15,	Type = 5},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Corruption",			Length = 17,	Type = 5},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Fel Domination",		Length = 900,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of Doom",			Length = 60,	Type = 3},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Sacrifice",			Length = 30,	Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Soul Fire",			Length = 60,	Type = 3},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Death Coil",			Length = 120,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadowburn",			Length = 15,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Conflagrate",			Length = 10,	Type = 3},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of Agony",		Length = 24,	Type = 4},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of Weakness",		Length = 120,	Type = 4},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of Recklessness",		Length = 120,	Type = 4},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of Tongues",		Length = 30,	Type = 4},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of the Elements",		Length = 300,	Type = 4},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of Shadow",		Length = 300,	Type = 4},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Siphon Life",			Length = 30,	Type = 5},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Howl of Terror",		Length = 40,	Type = 3},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ritual of Doom",		Length = 3600,	Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Demon Armor",			Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Unending Breath",		Length = 0,	Type = 0},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Invisibility",			Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Eye of Kilrogg",		Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Enslave Demon",			Length = 0,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Demon Skin",			Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ritual of Summoning",		Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Soul Link",			Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Sense Demons",			Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Curse of Exhaustion",		Length = 12,	Type = 4},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Life Tap",			Length = 0,	Type = 0},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Amplify Curse",			Length = 180,	Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Shadow Ward",			Length = 30,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Demonic Sacrifice",		Length = 0,	Type = 0},

};
-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de malédiction
-- Type 5 = Timer de combat

NECROSIS_ITEM = {
	["Soulshard"] = "Soul Shard",
	["Soulstone"] = "Soulstone",
	["Healthstone"] = "Healthstone",
	["Spellstone"] = "Spellstone",
	["Firestone"] = "Firestone",
	["Offhand"] = "Held In Off-hand",
	["Twohand"] = "Two-Hand",
	["InfernalStone"] = "Infernal Stone",
	["DemoniacStone"] = "Demonic Figurine",
	["Hearthstone"] = "Hearthstone",
	["SoulPouch"] = {"Soul Pouch", "Felcloth Bag", "Core Felcloth Bag"}	
};


NECROSIS_STONE_RANK = {
	[1] = " (Minor)",	-- Rank Minor
	[2] = " (Lesser)",	-- Rank Lesser
	[3] = "",		-- Rank Intermediate, no name
	[4] = " (Greater)",	-- Rank Greater
	[5] = " (Major)"	-- Rank Major
};

NECROSIS_NIGHTFALL = {
	["BoltName"] = "Bolt",
	["ShadowTrance"] = "Shadow Trance"
};

NECROSIS_CREATE = {
	[1] = "Create Soulstone",
	[2] = "Create Healthstone",
	[3] = "Create Spellstone",
	[4] = "Create Firestone"
};

NECROSIS_PET_LOCAL_NAME = {
	[1] = "Imp",
	[2] = "Voidwalker",
	[3] = "Succubus",
	[4] = "Felhunter",
	[5] = "Inferno",
	[6] = "Doomguard"
};

NECROSIS_TRANSLATION = {
	["Cooldown"] = "Cooldown",
	["Hearth"] = "Hearthstone",
	["Rank"] = "Rank",
	["Invisible"] = "Detect Invisibility",
	["LesserInvisible"] = "Detect Lesser Invisibility",
	["GreaterInvisible"] = "Detect Greater Invisibility",
	["SoulLinkGain"] = "You gain Soul Link.",
	["SacrificeGain"] = "You gain Sacrifice.",
	["SummoningRitual"] = "Ritual of Summoning"
};

end

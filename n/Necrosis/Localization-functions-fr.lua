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
-- Version 06.05.2006-2
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- VERSION FRANCAISE DES FONCTIONS --
------------------------------------------------

if ( GetLocale() == "frFR" ) then

NECROSIS_UNIT_WARLOCK = "D\195\169moniste";

NECROSIS_ANTI_FEAR_SPELL = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"Gardien de peur",				-- Dwarf priest racial trait
		"Volont\195\169 des r\195\169prouv\195\169",	-- Forsaken racial trait
		"Sans peur",					-- Trinket
		"Furie Berzerker",				-- Warrior Fury talent
		"T\195\169m\195\169rit\195\169",		-- Warrior Fury talent
		"Souhait mortel",				-- Warrior Fury talent
		"Courroux bestial",				-- Hunter Beast Mastery talent (pet only)
		"Carapace de glace",				-- Mage Ice talent
		"Protection divine",				-- Paladin Holy buff
		"Bouclier divin",				-- Paladin Holy buff
		"Totem de s\195\169isme",			-- Shaman totem
		"Abolir la magie"				-- Majordomo (NPC) spell
		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.		
	},

	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"Mal\195\169diction de t\195\169m\195\169rit\195\169"		-- Warlock curse
	}
};

-- Creature type absolutly immune to fear effects
NECROSIS_ANTI_FEAR_UNIT = {
	"Mort-vivant"
};

-- Word to search for spell immunity. First (.+) replace the spell's name, 2nd (.+) replace the creature's name
NECROSIS_ANTI_FEAR_SRCH = "Votre (.+) rate. (.+) y est insensible."

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Invocation d'un palefroi corrompu",			Length = 0,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Invocation d'un Destrier de l'Effroi",			Length = 0,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Invocation d'un diablotin",				Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Invocation d'un marcheur du Vide",			Length = 0,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Invocation d'une succube",				Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Invocation d'un chasseur corrompu",			Length = 0,	Type = 0},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Trait de l'ombre",					Length = 0,	Type = 0},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Inferno",						Length = 3600,	Type = 3},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Bannir",						Length = 30,	Type = 2},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Asservir d\195\169mon",					Length = 30000,	Type = 2},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "R\195\169surrection de Pierre d'\195\162me",		Length = 1800,	Type = 1},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Immolation",						Length = 15,	Type = 5},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Peur",							Length = 15,	Type = 5},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Corruption",						Length = 17,	Type = 5},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Domination corrompue",					Length = 900,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction funeste",				Length = 60,	Type = 3},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Sacrifice",						Length = 30,	Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feu de l'\195\162me",					Length = 60,	Type = 3},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Voile mortel",						Length = 120,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Br\195\187lure de l'ombre",				Length = 15,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Conflagration",						Length = 10,	Type = 3},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction d'agonie",				Length = 24,	Type = 4},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de faiblesse",			Length = 120,	Type = 4},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de t\195\169m\195\169rit\195\169",	Length = 120,	Type = 4},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction des langages",			Length = 30,	Type = 4},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction des \195\169l\195\169ments",		Length = 300,	Type = 4},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de l'ombre",				Length = 300,	Type = 4},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Siphon de vie",						Length = 30,	Type = 5},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Hurlement de terreur",					Length = 40,	Type = 3},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Rituel de mal\195\169diction",				Length = 3600,	Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Armure d\195\169moniaque",				Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Respiration interminable",				Length = 0,	Type = 0},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Invisibilit\195\169",					Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Oeil de Kilrogg",					Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Asservir d\195\169mon",					Length = 0,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Peau de d\195\169mon",					Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Rituel d'invocation",					Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Lien spirituel",					Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "D\195\169tection des d\195\169mons",			Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de fatigue",				Length = 12,	Type = 4},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Connexion",						Length = 0,	Type = 0},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction amplifi\195\169e",			Length = 180,	Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gardien de l'ombre",					Length = 30,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Sacrifice d\195\169moniaque",				Length = 0,	Type = 0},
};
-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de malédiction
-- Type 5 = Timer de combat

NECROSIS_ITEM = {
	["Soulshard"] = "Fragment d'\195\162me",
	["Soulstone"] = "Pierre d'\195\162me",
	["Healthstone"] = "Pierre de soins",
	["Spellstone"] = "Pierre de sort",
	["Firestone"] = "Pierre de feu",
	["Offhand"] = "Tenu en main gauche",
	["Twohand"] = "Deux mains",
	["InfernalStone"] = "Pierre infernale",
	["DemoniacStone"] = "Figurine d\195\169moniaque",
	["Hearthstone"] = "Pierre de foyer",
	["SoulPouch"] = {"Bourse d'\195\162me", "Sac en gangr\195\169toffe", "Sac en gangr\195\169toffe du Magma"}
};


NECROSIS_STONE_RANK = {
	[1] = " (mineure)",			-- Rank Minor
	[2] = " (inf\195\169rieure)",		-- Rank Lesser
	[3] = "",				-- Rank Intermediate, no name
	[4] = " (sup\195\169rieure)",		-- Rank Greater
	[5] = " (majeure)"			-- Rank Major
};

NECROSIS_NIGHTFALL = {
	["BoltName"] = "Trait",
	["ShadowTrance"] = "Transe de l'ombre",
};

NECROSIS_CREATE = {
	[1] = "Cr\195\169ation de Pierre d'\195\162me",
	[2] = "Cr\195\169ation de Pierre de soins",
	[3] = "Cr\195\169ation de Pierre de sort",
	[4] = "Cr\195\169ation de Pierre de feu"
};

NECROSIS_PET_LOCAL_NAME = {
	[1] = "Diablotin",
	[2] = "Marcheur du Vide",
	[3] = "Succube",
	[4] = "Chasseur corrompu",
	[5] = "Infernal",
	[6] = "Garde funeste"
};

NECROSIS_TRANSLATION = {
	["Cooldown"] = "Temps",
	["Hearth"] = "Pierre de foyer",
	["Rank"] = "Rang",
	["Invisible"] = "D\195\169tection de l'invisibilit\195\169",
	["LesserInvisible"] = "D\195\169tection de l'invisibilit\195\169 inf\195\169rieure",
	["GreaterInvisible"] = "D\195\169tection de l'invisibilit\195\169 sup\195\169rieure",
	["SoulLinkGain"] = "Vous gagnez Lien spirituel.",
	["SacrificeGain"] = "Vous gagnez Sacrifice.",
	["SummoningRitual"] = "Rituel d'invocation"
};

end

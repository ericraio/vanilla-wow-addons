-- french localization by the_nuru

if (LOCALE_frFR) then 
-- bonus names


BONUSSCANNER_NAMES = {	
	STR 		= "Force",
	AGI 		= "Agilité",
	STA 		= "Endurance",
	INT 		= "Intelligence",
	SPI 		= "Esprit",
	ARMOR 		= "Bonus d'Armure",

	ARCANERES 	= "Arcane",
	FIRERES 	= "Feu",
	NATURERES 	= "Nature",
	FROSTRES 	= "Givre",
	SHADOWRES 	= "Ombre",

	FISHING 	= "Pêche",
	MINING 		= "Minage",
	HERBALISM 	= "Herborisme",
	SKINNING 	= "Dépeçage",
	DEFENSE 	= "Défense",

	BLOCK 		= "Blocage",
	DODGE 		= "Esquive",
	PARRY 		= "Parade",
	ATTACKPOWER = "Puissance d'attaque",
 	ATTACKPOWERUNDEAD = "Puissance d'attaque contre les morts-vivants",
	CRIT 		= "Coups Critiques",
	RANGEDATTACKPOWER = "Puissance d'attaque à distance",
	RANGEDCRIT 	= "Tirs Crit.",
	TOHIT 		= "Chances de toucher",

	DMG 		= "Dégâts",
 	DMGUNDEAD	= "Dégâts des sorts contre les morts-vivants",
	ARCANEDMG 	= "Dégâts d'Arcanes",
	FIREDMG 	= "Dégâts de Feu",
	FROSTDMG 	= "Dégâts de Froid",
	HOLYDMG 	= "Dégâts Sacrés",
	NATUREDMG 	= "Dégâts de Nature",
	SHADOWDMG 	= "Dégâts des Ombres",
	SPELLCRIT 	= "Critiques",
	HEAL 		= "Soins",
	HOLYCRIT 	= "Soins Crit.",
	SPELLTOHIT	= "Chance de toucher avec les sorts",
	SPELLPEN 	= "Diminue les résistances",

	HEALTHREG 	= "Régeneration Vie",
	MANAREG 	= "Régeneration Mana",
	HEALTH 		= "Points de Vie",
	MANA 		= "Points de Mana",
};
-- equip and set bonus patterns:
BONUSSCANNER_PREFIX_EQUIP = "Equipé : ";
BONUSSCANNER_PREFIX_SET = "Complet : ";

BONUSSCANNER_PATTERNS_PASSIVE = {
	{ pattern = "+(%d+) à la puissance d'attaque%.", effect = "ATTACKPOWER" },
	{ pattern = "+(%d+) à la puissance d'attaque lorsque vous combattez les morts.vivants%.", effect = "ATTACKPOWERUNDEAD" },
	{ pattern = "+(%d+) à la puissance des attaques à distance%.", effect = "RANGEDATTACKPOWER" },
	{ pattern = "Augmente vos chances de bloquer une attaque de (%d+)%%%.", effect = "BLOCK" },
	{ pattern = "Augmente vos chances d'esquiver une attaque de (%d+)%%%.", effect = "DODGE" },
	{ pattern = "Augmente vos chances de parer une attaque par (%d+)%%%.", effect = "PARRY" },
	{ pattern = "Augmente vos chances d'infliger un coup critique avec vos sorts de (%d+)%%%.", effect = "SPELLCRIT" },
	{ pattern = "Augmente vos chances d'infliger un coup critique de (%d+)%%%.", effect = "CRIT" },
	{ pattern = "Augmente vos chances d'infliger un coup critique avec une arme à feu par (%d+)%%%.", effect = "RANGEDCRIT" },
	{ pattern = "Augmente vos chances de lancer un soin critique par (%d+)%%%.", effect = "HEALCRIT" },
	{ pattern = "Augmente les points de dégâts infligés par les effets et les sorts des Arcanes de (%d+)% au maximum.", effect = "ARCANEDMG" },
	{ pattern = "Augmente les points de dégâts infligés par vos sorts et effets de Feu de (%d+)% au maximum.", effect = "FIREDMG" },
	{ pattern = "Augmente les points de dégâts infligés par les sorts et les effets de givre de (%d+)% au maximum.", effect = "FROSTDMG" },
	{ pattern = "Augmente les dommages realises par les sorts Sacrés de (%d+)%.", effect = "HOLYDMG" },
	{ pattern = "Augmente les points de dégâts infligés par les sorts et les effets de Nature (%d+)% au maximum.", effect = "NATUREDMG" },
	{ pattern = "Augmente les points de dégâts infligés par les sorts et les effets d'ombre de (%d+)% au maximum.", effect = "SHADOWDMG" },
	{ pattern = "(%d+)% aux dégâts des sorts d'ombres.", effect = "SHADOWDMG" },
	{ pattern = "Augmente les effets des sorts de soins de (%d+)% au maximum.", effect = "HEAL" },
	{ pattern = "Augmente les soins prodigués par les sorts et effets de (%d+)% au maximum.", effect = "HEAL"},
	{ pattern = "Augmente les soins et dégâts produits par les sorts et effets magiques de (%d+) au maximum.", effect = {"HEAL", "DMG" }},
	{ pattern = "Augmente les dégâts et les soins produits par les sorts et effets magiques de (%d+) au maximum.", effect = {"HEAL", "DMG" }},
 	{ pattern = "Augmente les dégâts infligés aux morts.vivants par les sorts et effets magiques d'un maximum de (%d+)%.", effect = "DMGUNDEAD" }, -- the . in morts.vivants is to replace the special '-' characater they use... (3 hours to find it)
	{ pattern = "Rend (%d+) points de vie toutes les 5 sec.", effect = "HEALTHREG" },
	{ pattern = "Rend (%d+) points de mana toutes les 5 secondes.", effect = "MANAREG" },
	{ pattern = "Augmente vos chances de toucher de (%d+)%%%.", effect = "TOHIT" },
	{ pattern = "Augmente vos chances de toucher avec des sorts de (%d+)%%%.", effect = "SPELLTOHIT" },
	{ pattern = "Diminue les résistances magiques des cibles de vos sorts de (%d+).", effect = "SPELLPEN" },
	{ pattern = "Pêche augmentée de (%d+)%.", effect = "FISHING" },
	{ pattern = "Défense augmentée de (%d+)%.", effect = "DEFENSE"},
};


BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {
	["Toutes les caractéristiques"] = {"STR", "AGI", "STA", "INT", "SPI"},
	["Force"] = "STR",
	["Agilité"] = "AGI",
	["Endurance"] = "STA",
	["Intelligence"] = "INT",
	["Esprit"] = "SPI",
	["à toutes les résistances"] = { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
	["Pêche"] = "FISHING",
	["Minage"] = "MINING",
	["Herborisme"] = "HERBALISM",
	["Dépeçage"] = "SKINNING",
	["Défense"] = "DEFENSE",
	["puissance d'Attaque"] = "ATTACKPOWER",
 	["Puissance d'attaque contre les morts.vivants"] 		= "ATTACKPOWERUNDEAD",
	["Esquive"] = "DODGE",
	["Blocage"] = "BLOCK",
	["Blocage"] = "BLOCK",
	["Pouvoir d'Attaque à distance"] = "RANGEDATTACKPOWER",
	["Soins chaque 5 sec."] = "HEALTHREG",
	["Sorts de Soins"] = "HEAL",
	["Sorts de soin"] = "HEAL",
	["Sorts de soins"] = "HEAL", 	
	["Mana chaque 5 sec."] = "MANAREG",
	["Sorts de Dommages"] = "DMG",
	["dégâts des sorts"] = "DMG",
	["dégâts et les effets des sorts"] = "DMG",
	["Dégâts et soins "] = {"HEAL", "DMG"},
	["Coup Critique"] = "CRIT",
	["Dommage"] = "DMG",
	["Soins"] = "HEALTH",
	["Mana"] = "MANA",
	["Armure :"] = "ARMOR",
	["Armure renforcée"] = "ARMOR",
};
	
BONUSSCANNER_PATTERNS_GENERIC_STAGE1 = {
	{ pattern = "Arcane", effect = "ARCANE" },
	{ pattern = "Feu", effect = "FIRE" },
	{ pattern = "Givre", effect = "FROST" },
	{ pattern = "Sacré", effect = "HOLY" },
	{ pattern = "Ombre", effect = "SHADOW" },
	{ pattern = "Nature", effect = "NATURE" },
	{ pattern = "arcanes", effect = "ARCANE" },
	{ pattern = "feu", effect = "FIRE" },
	{ pattern = "givre", effect = "FROST" },
	{ pattern = "ombre", effect = "SHADOW" },
	{ pattern = "nature", effect = "NATURE" }
};

BONUSSCANNER_PATTERNS_GENERIC_STAGE2 = {
	{ pattern = "résistance", effect = "RES" },
	{ pattern = "dégâts", effect = "DMG" },
	{ pattern = "effets", effect = "DMG" }
};


BONUSSCANNER_PATTERNS_OTHER = {
};

end 

if (LOCALE_deDE) then

-- Namen der Boni
BONUSSCANNER_NAMES = {	
	STR 		= "Stärke",
	AGI 		= "Beweglichkeit",
	STA 		= "Ausdauer",
	INT 		= "Intelligenz",
	SPI 		= "Willenskraft",
	ARMOR 		= "Verstärkte Rüstung",

	ARCANERES 	= "Arkanwiderstand",	
	FIRERES 	= "Feuerwiderstand",
	NATURERES 	= "Naturwiderstand",
	FROSTRES 	= "Frostwiderstand",
	SHADOWRES 	= "Schattenwiderstand",

	FISHING 	= "Angeln",
	MINING 		= "Bergbau",
	HERBALISM 	= "Kräuterkunde",
	SKINNING 	= "Kürschnerei",
	DEFENSE 	= "Verteidigung",

	BLOCK 		= "Blocken",
	DODGE 		= "Ausweichen",
	PARRY 		= "Parieren",
	ATTACKPOWER = "Angriffskraft",
	ATTACKPOWERUNDEAD = "Angriffskraft gegen Untote",
	CRIT 		= "krit. Treffer",
	RANGEDATTACKPOWER = "Distanzangriffskraft",
	RANGEDCRIT 	= "krit. Schuss",
	TOHIT 		= "Trefferchance",
	DMG			= "Zauberschaden",
	DMGUNDEAD	= "Zauberschaden gegen Untote",
	ARCANEDMG 	= "Arkanschaden",
	FIREDMG 	= "Feuerschaden",
	FROSTDMG 	= "Frostschaden",
	HOLYDMG 	= "Heiligschaden",
	NATUREDMG 	= "Naturschaden",
	SHADOWDMG 	= "Schattenschaden",
	HOLYCRIT 	= "krit. Heiligzauber",	
	SPELLCRIT 	= "krit. Zauber",
	SPELLTOHIT 	= "Zaubertrefferchance",
	SPELLPEN 	= "Magiedurchdringung",
	HEAL 		= "Heilung",
	HEALTHREG 	= "Lebensregeneration",
	MANAREG 	= "Manaregeneration",	
	HEALTH 		= "Lebenspunkte",
	MANA 		= "Manapunkte",	
}

-- Pr�fixe f�r passive und Set-Boni
BONUSSCANNER_PREFIX_EQUIP = "Anlegen: ";
BONUSSCANNER_PREFIX_SET = "Set: ";

-- Suchmuster f�r passive Boni. Wird auf Zeilen angewandt, die mit obigen Pr�fixen beginnen.
BONUSSCANNER_PATTERNS_PASSIVE = {
	{ pattern = "%+(%d+) bei allen Widerstandsarten%.", effect = { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"} },
	{ pattern = "Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um (%d+)%%%.", effect = "BLOCK" },
	{ pattern = "Erhöht Eure Chance, einem Angriff auszuweichen, um (%d+)%%%.", effect = "DODGE" },
	{ pattern = "Erhöht Eure Chance, einen Angriff zu parieren, um (%d+)%%%.", effect = "PARRY" },
	{ pattern = "Erhöht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um (%d+)%%%.", effect = "SPELLCRIT" },
	{ pattern = "Erhöht Eure Chance, einen kritischen Treffer durch Heiligzauber zu erzielen, um (%d+)%%%.", effect = "HOLYCRIT" },
	{ pattern = "Erhöht Eure Chance, einen kritischen Treffer zu erzielen, um (%d+)%%%.", effect = "CRIT" },
	{ pattern = "Erhöht Eure Chance, mit Geschosswaffen einen kritischen Schlag zu erzielen, um (%d+)%.", effect = "RANGEDCRIT" },
	{ pattern = "Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu (%d+)%.", effect = "ARCANEDMG" },
	{ pattern = "Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu (%d+)%.", effect = "FIREDMG" },
	{ pattern = "Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu (%d+)%.", effect = "FROSTDMG" },
	{ pattern = "Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu (%d+)%.", effect = "HOLYDMG" },
	{ pattern = "Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu (%d+)%.", effect = "NATUREDMG" },
	{ pattern = "Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu (%d+)%.", effect = "SHADOWDMG" },
	{ pattern = "Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu (%d+)%.", effect = {"HEAL","DMG"} },
	{ pattern = "Erhöht den durch magische Zauber und magische Effekte zugefügten Schaden gegen Untote um bis zu (%d+)", effect = "DMGUNDEAD" },
	{ pattern = "+(%d+) Angriffskraft gegen Untote.", effect = "ATTACKPOWERUNDEAD" },
	{ pattern = "Erhöht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
	{ pattern = "Erhöht die durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
	{ pattern = "Stellt alle 5 Sek%. (%d+) Punkt%(e%) Gesundheit wieder her%.", effect = "HEALTHREG" },
	{ pattern = "Stellt alle 5 Sek%. (%d+) Punkt%(e%) Mana wieder her%.", effect = "MANAREG" },
	{ pattern = "Verbessert Eure Trefferchance um (%d+)%%%.", effect = "TOHIT" },
	{ pattern = "Erhöht Eure Chance mit Zaubern zu treffen um (%d+)%%%.", effect = "SPELLTOHIT" },
	{ pattern = "Reduziert die Magiewiderstände der Ziele Eurer Zauber um (%d+)%.", effect = "SPELLPEN" }
};
	
	
-- Suchmuster f�r allgemeine Gegenstandsboni in der Form "+xx bonus" oder "bonus +xx" (%-Zeichen nach dem Wert ist optional)

-- Zuerst wird versucht den "bonus"-String in der folgenden Tabelle nachzuschlagen
BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {
	["Alle Werte"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["Stärke"]				= "STR",
	["Beweglichkeit"]		= "AGI",
	["Ausdauer"]			= "STA",
	["Intelligenz"]			= "INT",
	["Willenskraft"] 		= "SPI",

	["Alle Widerstandsarten"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},

	["Angeln"]				= "FISHING",
	["Angelköder"]			= "FISHING",
	["Bergbau"]				= "MINING",
	["Kräuterkunde"]		= "HERBALISM",
	["Kürschnerei"]		= "SKINNING",
	["Verteidigung"]		= "DEFENSE",
	["Verteidigungsfertigkeit"] = "DEFENSE",

	["Angriffskraft"] 		= "ATTACKPOWER",
	["Angriffskraft gegen Untote"] = "ATTACKPOWERUNDEAD",
	["Ausweichen"] 			= "DODGE",
	["Blocken"]				= "BLOCK",
	["Trefferchance"]		= "TOHIT",
	["Distanzangriffskraft"] = "RANGEDATTACKPOWER",
	["Gesundheit alle 5 Sek"] = "HEALTHREG",
	["Heilzauber"] 			= "HEAL",
	["Mana alle 5 Sek"] 	= "MANAREG",
	["Manaregeneration"]	= "MANAREG",
	["Zauberschaden erhöhen"]= "DMG",
	["Kritischer Treffer"] 	= "CRIT",
	["Zauberschaden"] 		= "DMG",
	["Blocken"]				= "BLOCK",
	["Gesundheit"]			= "HEALTH",
	["HP"]					= "HEALTH",
	["Heilzauber"]			= "HEAL",
	["Heilung und Zauberschaden"] = {"HEAL","DMG"},
	["Zauberschaden und Heilung"] = {"HEAL","DMG"},
	["Zaubertrefferchance"]	= "SPELLTOHIT",

	["Mana"]				= "MANA",
	["Rüstung"]			= "ARMOR",
	["Verstärkte Rüstung"]= "ARMOR"
};

-- ... dann wird versucht ob eines der Stage 1 und eines der Stage 2 Muster passt und daraus ein Effect-String zusammengesetzt
BONUSSCANNER_PATTERNS_GENERIC_STAGE1 = {
	{ pattern = "Arkan", 	effect = "ARCANE" },	
	{ pattern = "Feuer", 	effect = "FIRE" },	
	{ pattern = "Frost", 	effect = "FROST" },	
	{ pattern = "Heilig", 	effect = "HOLY" },	
	{ pattern = "Schatten", effect = "SHADOW" },	
	{ pattern = "Natur", 	effect = "NATURE" }}; 	

BONUSSCANNER_PATTERNS_GENERIC_STAGE2 = {
	{ pattern = "widerst", 	effect = "RES" },	
	{ pattern = "schaden", 	effect = "DMG" },
	{ pattern = "effekte", 	effect = "DMG" }}; 	

-- Zuletzt, falls immer noch kein Treffer vorliegt wird noch auf einige spezielle Verzauberungen �berpr�ft.
BONUSSCANNER_PATTERNS_OTHER = {
	{ pattern = "Manaregeneration (%d+) per 5 Sek%.", effect = "MANAREG" },
	
	{ pattern = "Schwaches Zauberöl", effect = {"DMG", "HEAL"}, value = 8 },
	{ pattern = "Geringes Zauberöl", effect = {"DMG", "HEAL"}, value = 16 },
	{ pattern = "Zauberöl", effect = {"DMG", "HEAL"}, value = 24 },
	{ pattern = "Hervorragendes Zauberöl", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

	{ pattern = "Schwaches Manaöl", effect = "MANAREG", value = 4 },
	{ pattern = "Geringes Manaöl", effect = "MANAREG", value = 8 },
	{ pattern = "Hervorragendes Manaöl", effect = { "MANAREG", "HEAL"}, value = {12, 25} },

	{ pattern = "Eterniumschnur", effect = "FISHING", value = 5 }
};

end
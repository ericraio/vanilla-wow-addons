if ( GetLocale() == "enUS" ) then
----------------------- ENGLISH ------------------------------

	--Feedback information
	CS_STAT = "caster stat";
	CS_DMG_TOGGLE = "damage";
	CS_HEALING_TOGGLE = "healing";
	CS_FEEDBACK_STATCHANGE = "CS - Primary stat set to";

	--Stat names
	CS_STAT_NAMES = {
		HEAL = "Healing",
		DMG = "Spell Dmg",
		ARCANEDMG = "Arcane Damage",
		FIREDMG = "Fire Damage",
		FROSTDMG = "Frost Damage",
		HOLYDMG = "Holy Damage",
		NATUREDMG = "Nature Damage",
		SHADOWDMG = "Shadow Damage",
		SPELLCRIT = "Spell Critical",
		HOLYCRIT = "Holy Critical",
		SPELLTOHIT = "Chance to Hit with Spells",
		HEALTHREG = "Health Regen",
		MANAREG = "Mana Regen",
		NEGRES = "Target Resist Decrease"
	};

	--Additions to the Bonusscanner scans
	CS_BONUSSCANNER_ADD_NEGRES = { pattern = "Decreases the magical resistances of your spell targets by (%d+)%.", effect = "NEGRES" };



elseif ( GetLocale() == "deDE" ) then
----------------------- GERMAN ------------------------------
	--Thx to all who worked on this
	--German by Ani, corrected by Natu, corrected and 1.9 modified by Kilworth, corrected by DeviL, corrected by herzausgold, reformatted by RMS

	--Ausgabe
	CS_STAT = "caster stat";
	CS_DMG_TOGGLE = "schaden";
	CS_HEALING_TOGGLE = "heilung";
	CS_FEEDBACK_STATCHANGE = "CS - Neue einstellung: ";

	--Stat names
	CS_STAT_NAMES = {
		HEAL = "Heilung",
		DMG = "Zauberschaden ",
		ARCANEDMG = "Arkanzauberschaden",
		FIREDMG = "Feuerzauberschaden",
		FROSTDMG = "Frostzauberschaden",
		HOLYDMG = "Heiligzauberschaden",
		NATUREDMG = "Naturzauberschaden",
		SHADOWDMG = "Schattenzauberschaden",
		SPELLCRIT = "Zauber Krit.",
		HOLYCRIT = "Heilig Krit.",
		SPELLTOHIT = "Chance mit Zaubern zu treffen",
		HEALTHREG = "Gesundheitsregenaration",
		MANAREG = "Mana Regeneration",	
		NEGRES = "Target Resist Decrease" --English
	};

	--Additions to the Bonusscanner scans -- DISABLED - REQUIRES TRANSLATION
	--CS_BONUSSCANNER_ADD_NEGRES = { pattern = "Decreases the magical resistances of your spell targets by (%d+)%.", effect = "NEGRES" };



elseif ( GetLocale() == "frFR" ) then
----------------------- FRENCH ------------------------------
	--Thx nuru. I hope this is still good.
	--the_nuru
	--Feedback information
	CS_STAT = "Caster stat";
	CS_DMG_TOGGLE = "Degats";
	CS_HEALING_TOGGLE = "Soins";
	CS_FEEDBACK_STATCHANGE = "CS - Primary stat set to";


	--Stat names
	CS_STAT_NAMES = {
		HEAL = "Soin",
		DMG = "D\195\169g\195\162ts des sorts",	
		ARCANEDMG = "D\195\169g\195\162ts d'Arcanes",
		FIREDMG = "D\195\169g\195\162ts de Feu",
		FROSTDMG = "D\195\169g\195\162ts de Froid",
		HOLYDMG = "D\195\169g\195\162ts Sacr\195\169s",
		NATUREDMG = "D\195\169g\195\162ts de Nature",
		SHADOWDMG = "D\195\169g\195\162ts des Ombres",
		SPELLCRIT = "Critiques ",
		HOLYCRIT = "Critiques Sacr\195\169s",
		SPELLTOHIT = "Chances de toucher avec les sorts",
		HEALTHGEN = "R\195\169generation Vie",
		MANAGEN = "R\195\169generation Mana",
		NEGRES = "Target Resist Decrease" --English
	};

	--Additions to the Bonusscanner scans -- DISABLED - REQUIRES TRANSLATION
	--CS_BONUSSCANNER_ADD_NEGRES = { pattern = "Decreases the magical resistances of your spell targets by (%d+)%.", effect = "NEGRES" };
end
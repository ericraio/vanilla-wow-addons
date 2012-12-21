local L = AceLibrary("AceLocale-2.0"):new("RegenFu")

L:RegisterTranslations("frFR", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "Affiche vos vitesses de regen HP/Mana",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";

	MENU_SHOW_HP = "Montrer HP";
	MENU_SHOW_MP = "Montrer MP";
	MENU_SHOW_PERCENT = "Montrer %";
	MENU_SHOW_CURRENT = "Montrer %";

	MENU_HIDE_LABEL = "Cacher le texte";

        TOOLTIP1_LEFT 		= "Vie:";
	TOOLTIP2_LEFT 		= "Mana:";
	TOOLTIP3_LEFT 		= "Meilleur regen HP:";
	TOOLTIP4_LEFT 		= "Moins bon regen HP:";
	TOOLTIP5_LEFT 		= "Meilleur regen Mana:";
	TOOLTIP6_LEFT 		= "Moins bon regen Mana:";
	TOOLTIP7_LEFT 		= "Mana R\195\169cup\195\169r\195\169e durant le dernier combat:";
	TOOLTIP8_LEFT 		= "HP R\195\169cup\195\169r\195\169s durant le dernier combat:";	
} end )


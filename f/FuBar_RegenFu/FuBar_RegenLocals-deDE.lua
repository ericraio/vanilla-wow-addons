local L = AceLibrary("AceLocale-2.0"):new("RegenFu")

L:RegisterTranslations("deDE", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "Zeige HP/MP Regenerationsrate",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";

	MENU_SHOW_HP = "Zeige HP";
	MENU_SHOW_MP = "Zeige MP";
	MENU_SHOW_PERCENT = "Zeige als Prozent";
	MENU_SHOW_CURRENT = "Show current value";

	MENU_HIDE_LABEL = "Text verstecken";

	TOOLTIP1_LEFT 		= "Gesundheit:";
	TOOLTIP2_LEFT 		= "Mana:";
	TOOLTIP3_LEFT 		= "Beste HP Regeneration:";
	TOOLTIP4_LEFT 		= "Am schlechtesten HP Regeneration:";
	TOOLTIP5_LEFT 		= "Beste MP Regeneration:";
	TOOLTIP6_LEFT 		= "Am schlechtesten MP Regeneration:";
	TOOLTIP7_LEFT 		= "MP Regeneration im letzten Kampf:";
	TOOLTIP8_LEFT 		= "HP Regeneration im letzten Kampf:";
	
} end )


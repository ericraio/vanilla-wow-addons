local L = AceLibrary("AceLocale-2.0"):new("RegenFu")

L:RegisterTranslations("enUS", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "Show your HP/MP regen rate.",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";

	MENU_SHOW_HP = "Show HP";
	MENU_SHOW_MP = "Show MP";
	MENU_SHOW_PERCENT = "Show as percentage";
	MENU_SHOW_CURRENT = "Show current value";

	MENU_HIDE_LABEL = "Hide label";
	
	TOOLTIP1_LEFT 		= "Health:";
	TOOLTIP2_LEFT 		= "Mana:";
	TOOLTIP3_LEFT 		= "Best HP Regen:";
	TOOLTIP4_LEFT 		= "Worst HP Regen:";
	TOOLTIP5_LEFT 		= "Best MP Regen:";
	TOOLTIP6_LEFT 		= "Worst MP Regen:";
	TOOLTIP7_LEFT 		= "MP Regen in Last Fight:";
	TOOLTIP8_LEFT 		= "HP Regen in Last Fight:";
	
} end )


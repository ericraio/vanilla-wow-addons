local L = AceLibrary("AceLocale-2.2"):new("RegenFu")

L:RegisterTranslations("enUS", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "Show your HP/MP regen rate.",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";
	FSR_LABEL = "FSR: ",

	MENU_SHOW_HP = "Show HP";
	MENU_SHOW_MP = "Show MP";
    
    ["Show FSRT"] = true,
    
	MENU_SHOW_PERCENT = "Show as percentage";
	MENU_SHOW_CURRENT = "Show current value";
	
	["Show In Combat Regen Total"] = true,


	MENU_HIDE_LABEL = "Hide label";
	
	TOOLTIP1_LEFT 		= "Health:";
	TOOLTIP2_LEFT 		= "Mana:";
	TOOLTIP3_LEFT 		= "Best HP Regen:";
	TOOLTIP4_LEFT 		= "Worst HP Regen:";
	TOOLTIP5_LEFT 		= "Best MP Regen:";
	TOOLTIP6_LEFT 		= "Worst MP Regen:";
	TOOLTIP7_LEFT 		= "MP Regen in Last Fight:";
	TOOLTIP8_LEFT 		= "HP Regen in Last Fight:";
	TOOLTIP9_LEFT			= "Average MP Regen in Last Fight:";
    
   	["AceConsole-commands"] = { "/regenfu" },

    ["Percent Regen While Casting"] = true,
    ["Mana Regen Forumula (Spirit/<value>)"] = true,
    ["Mana Per Int"] = true,


   	["Reset FSR Data"] = true,
    ["Time Spent In Regen"] = true,
    ["(This Fight)"]    = true, 
    ["(Last Fight)"]    = true, 

    ["Total Regen Time Observed"]        = true,
    ["% Of That Time In FSR"] = true, 
    ["Spirit Needed To Equal 1mp5"]         = true,
    ["Int Needed To Equal 1mp5"]        = true, 
    
    ["FSR Countdown Bar"] = true,
    ["FSR"] = true,

 } end )


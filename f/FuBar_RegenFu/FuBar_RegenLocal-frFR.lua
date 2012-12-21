local L = AceLibrary("AceLocale-2.2"):new("RegenFu")

L:RegisterTranslations("frFR", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "Affiche les taux de régenèration de vie et mana",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";
	FSR_LABEL = "R5S: ",

	MENU_SHOW_HP = "Afficher la vie";
	MENU_SHOW_MP = "Afficher la mana";
	
	["Show FSRT"] = "Afficher le temps sous la règle des 5 secondes (R5S)",
	
	MENU_SHOW_PERCENT = "Afficher en pourcentage";
	MENU_SHOW_CURRENT = "Afficher la valeur courante";

	["Show In Combat Regen Total"] = "Montrez la régenèration totale en combat",


	MENU_HIDE_LABEL = "Cacher le menu";

	TOOLTIP1_LEFT 		= "Vie:";
	TOOLTIP2_LEFT 		= "Mana:";
	TOOLTIP3_LEFT 		= "Meilleure régenèration de vie:";
	TOOLTIP4_LEFT 		= "Pire régenèration de vie:";
	TOOLTIP5_LEFT 		= "Meilleure régenèration de mana:";
	TOOLTIP6_LEFT 		= "Pire régenèration de mana:";
	TOOLTIP7_LEFT 		= "Régenèration de mana pendant le dernier combat:";
	TOOLTIP8_LEFT 		= "Régenèration de vie pendant le dernier combat:";
	
   	["AceConsole-commands"] = { "/regenfu" },

    ["Percent Regen While Casting"] = "Pourcentage de régenèration pendant l'incantation",
    ["Mana Regen Forumula (Spirit/<value>)"] = "Mana régenèré par point d'Esprit",
    ["Mana Per Int"] = "Mana régenèré par point d'Intelligence",


	["Reset FSR Data"] = "Remise à zéro des données R5S",
    ["Time Spent In Regen"] = "Temps pass\195\169 en r\195\169g\195\169n\195\169ration",
    ["(This Fight)"] = "(Ce combat)", 
    ["(Last Fight)"] = "(Combat pr\195\169c\195\169dent)", 

    ["Total Regen Time Observed"] = "Durée de régeneration observée",
    ["% Of That Time In FSR"] = "% de ce temps sous la R5S", 
    ["Spirit Needed To Equal 1mp5"] = "Esprit requis pour égaler 1 mana/5s",
    ["Int Needed To Equal 1mp5"] = "Intelligence requise pour égaler 1 mana/5s", 
} end )

local L = AceLibrary("AceLocale-2.0"):new("FuBar_ClockFu")

L:RegisterTranslations("frFR", function() return {
	["24-hour format"] = "Format 24H",
	["Toggle between 12-hour and 24-hour format"] = "Basculer entre les affichages 12H/24H",
	["Show seconds"] = "Afficher les secondes",
	["Local time"] = "Heure locale",
	["Toggle between local time and server time"] = "Choisir entre Heure locale et Heure serveur",
	["Both times"] = "Loc+Serv",
	["Toggle between showing two times or just one"] = "Permet d'aficher les 2 types d'heures",
	["Show day/night bubble"] = "Afficher sur la minimap",
	["Show the day/night bubble on the upper-right corner of the minimap"] = "Permet de cacher l'icone de la minimap montrant l'heure",
	["Set the color of the text"] = "Choisir la couleur",
	
	["AceConsole-commands"] = { "/clockfu" },
	
	["Server time"] = "Heure serveur",
--	["UTC"] = true
} end)
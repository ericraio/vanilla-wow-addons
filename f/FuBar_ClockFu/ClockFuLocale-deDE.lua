local L = AceLibrary("AceLocale-2.0"):new("FuBar_ClockFu")

L:RegisterTranslations("deDE", function() return {
	["24-hour format"] = "24-Stunden-Format",
	["Toggle between 12-hour and 24-hour format"] = "Zwischen 12- und 24-Stunden-Format umschalten.",
	["Show seconds"] = "Sekunden anzeigen",
	["Local time"] = "Lokale Zeit",
	["Toggle between local time and server time"] = "Zwischen lokaler und Serverzeit umschalten.",
	["Both times"] = "Sowohl Server-, als auch lokale Zeit anzeigen",
	["Toggle between showing two times or just one"] = "Umschalter für einfache oder doppelte Zeitanzeige.",
	["Show day/night bubble"] = "Tag/Nacht-Anzeige ein/ausschalten",
	["Show the day/night bubble on the upper-right corner of the minimap"] = "Zeige die Tag/Nacht-Anzeige oben rechts an der Minikarte.",
	["Set the color of the text"] = "Sie die Farbe des Textes ein",
	
	["AceConsole-commands"] = { "/clockfu" },
	
	["Server time"] = "Serverzeit",
	["UTC"] = "UTC"
} end)
------------------------------
----- Translation for deDE
-- by Gamefaq
local L = AceLibrary("AceLocale-2.0"):new("ArcHUD_Core")

L:RegisterTranslations("deDE", function() return {
	-- Core stuff
		CMD_OPTS_FRAME		= "Options Fenster \195\182ffnen",
		CMD_OPTS_DEBUG		= "Setze debug level",
		CMD_RESET			= "Einstellungen f\195\188r diesen Charakter auf Grundeinstellung zurr\195\188ck setzen",
		CMD_RESET_HELP		= "Diese Option wird dir erlauben deine Einstellungen auf die Grundeinstellung zurrÅcksetzen. Um dies zu tun tippe 'CONFIRM' hinter der Option ein, so das da\195\159 Addon wei\195\159 das du diese Information hier gelesen hast.",
		CMD_RESET_CONFIRM	= "Diese Option wird alle Einstellunegn auf die Grundeinstellung zurr\195\188ck setzen wie sie wahren als du das Addon installiert hattest.",
		TEXT_RESET			= "Bitte Tippe CONFIRM hinter diesem Befehl ein um zu best\195\164tigen das du wirklich die Einstellungen zurr\195\188ck setzen willst.",
		TEXT_RESET_CONFIRM	= "Alle Einstellungen wurden zurr\195\188ck auf die Grundeinstellung gesetzt.",

		FONT				= "FRIZQT__.TTF",

		["Version: "]		= "Version: ",
		["Author: "]		= "Author: ",

	--	Options
		TEXT = {
			TITLE		= "ArcHUD Optionen",

			DISPLAY		= "Anzeige  Optionen",
			TARGETFRAME	= "Ziel Fenster",
			PLAYERMODEL	= "3D Modell f\195\188r Spieler",
			MOBMODEL	= "3D Modell f\195\188r Gegner",
			SHOWGUILD	= "Zeige Spielergilde",
			SHOWCLASS	= "Zeige Ziel Klasse",
			NAMEPLATES	= "Spieler/Tier Namenschilder",
			ATTACHTOP	= "Ziel Fenster oben anbringen",
			HOVERMSG	= "Namenschild Maus\195\188ber-Nachricht",
			HOVERDELAY	= "Namenschild Maus\195\188ber-Verz\195\182gerrung",
			TOT			= "Aktiviere Ziel des Ziel's",
			TOTOT		= "Aktiviere Ziel des Ziel's Ziel",
			BLIZZPLAYER = "Blizzard Spieler Fenster unsichtbar",
			BLIZZTARGET = "Blizzard Ziel Fenster unsichtbar",

			FADE		= "Ausblenden Optionen",
			FADE_FULL	= "Wenn voll",
			FADE_OOC	= "Au\195\159erhalb des Kapfes",
			FADE_IC		= "Im Kampf",

			MISC		= "Sonstige Optionen",
			WIDTH		= "HUD Breite",
			YLOC		= "Vertikale Ausrichtung",
			SCALE		= "Skalierung",

			RINGVIS		= "Ausblenden verhalten",
			RINGVIS_1	= "AusblendenVOLL: Ausblenden wenn voll",
			RINGVIS_2	= "AusblendenOOC: Ausblenden wenn au\195\159erhalb des Kampfes",
			RINGVIS_3	= "AusblendenBEIDES: Ausblenden wenn voll oder au\195\159erhalb des Kampfes",

			RINGS		= "Ring Optionen",
			RING		= "Ring",
		},
		TOOLTIP = {
			TARGETFRAME = "Schaltet das Anzeigen des Ziel Fensters ein",
			PLAYERMODEL = "Schaltet das Anzeigen des 3D Modells der Spieler ein",
			MOBMODEL	= "Schaltet das Anzeigen des 3D Modells der Monster ein",
			SHOWGUILD	= "Zeige Gildennamen neben dem Spielernamen an",
			SHOWCLASS	= "Zeige Klasse des Zieles oder Typ der Monster",
			TOT			= "Aktiviert das Anzeigen des Ziel des Ziel's",
			TOTOT		= "Aktiviert das Anzeigen des Ziel des Ziel's Ziel",
			NAMEPLATES	= "Schaltet das Anzeigen des Spieler und Tier Namensschildes ein",
			ATTACHTOP	= "Ziel Fenster \195\188ber den Ringen anstelle unter den Ringen anbringen",
			HOVERMSG	= "Schaltet das Anzeigen der Namensschilder beim schweben der Maus \195\188ber dem Namen ein",
			HOVERDELAY	= "Dauer an Sekunden die notwendig sind mit der Maus \195\188ber dem Namen zu schweben bis das Namensschild akiviert wird",
			BLIZZPLAYER = "Schaltet das Anzeigen des Blizzard Spieler Fensters ein",
			BLIZZTARGET = "Schaltet das Anzeigen des Blizzard Ziel Fensters ein",

			FADE_FULL	= "Transparenz zu der \195\188bergeblendet wird wenn man au\195\159erhalb des Kampfes ist und die Ringe bei 100% sind",
			FADE_OOC	= "Transparenz zu der \195\188bergeblendet wird wenn man au\195\159erhalb des Kampfes ist oder Ringe nicht bei 100% sind",
			FADE_IC		= "Transparanz zu der \195\188bergeblendet wird wenn man im Kampf ist (wird nur benutzt wenn das verhalten auf 'Au\195\159erhalb des Kampfes' oder 'Wenn voll' eingestellt ist)",

			WIDTH		= "Stellt ein wieweit die Ringe voneinander auseinander stehn",
			YLOC		= "Positioniert ArcHUD entlang der Y-Achse. Positive Werte schieben hoch, negative Werte schieben runter",
			SCALE		= "Stellt die Skalierung ein",

			RINGVIS		= "Stellt ein wann die Ringe ausgeblendet werden",
			RINGVIS_1	= "Ausblenden wenn Ringe voll sind, unabh\195\164ngig des Kampf Status",
			RINGVIS_2	= "Immer ausblenden wenn au\195\159erhalb des Kampfes, unabh\195\164ngig des Ring Status",
			RINGVIS_3	= "Ausblenden wenn au\195\159erhalb des Kampfes oder Ringe voll sind",
		},
} end)

local LM = AceLibrary("AceLocale-2.0"):new("ArcHUD_Module")

LM:RegisterTranslations("deDE", function() return {
		FONT			= "FRIZQT__.TTF",

		["Version: "]	= "Version: ",
		["Author: "]	= "Author: ",

		TEXT = {
			ENABLED		= "Aktiviert",
			OUTLINE		= "Ring Umrandung",
			SHOWTEXT	= "Zeige Text",
			SHOWPERC	= "Zeige Prozente",
			COLORFADE	= "Farbiges ausblenden",
			FLASH		= "Aufblitzen bei max Combo Punkten",
			SHOWSPELL	= "Zeige Zauber wird gezaubert",
			SHOWTIME	= "Zeige Zauber Zeit",
			HIDEBLIZZ	= "Verstecke Blizzards Fenster",
			ENABLEMENU	= "Aktiviere Rechtsklick Men\195\188",
			SHOWBUFFS 	= "Zeige Buffs/Debuffs",
			DEFICIT		= "Defizit",
			ATTACH		= "Anheften",
			SIDE		= "Seite",
			LEVEL		= "Stufe",
		},
		TOOLTIP = {
			ENABLED		= "Schaltet den Ring ein oder aus",
			OUTLINE		= "Schaltet die Umrandung um den Ring ein oder aus",
			SHOWTEXT	= "Schaltet die Text Anzeige um (Leben, Mana, etc.)",
			SHOWPERC	= "Schaltet die Prozent Anzeige  ein oder aus",
			SHOWSPELL	= "Schaltet das Anzeigen des Zaubers der verwendet wird ein oder aus",
			SHOWTIME	= "Schaltet die Zauberzeit Anzeige ein oder aus",
			COLORFADE	= "Schaltet das farbige ausblenden ein oder aus (gr\195\188n zu rot f\195\188r Leben und so weiter)",
			FLASH		= "Schaltet das aufblitzen  ein oder aus wenn man 5 Combo Punkte erreicht",
			HIDEBLIZZ	= "Schaltet das Anzeigen der Blizzard Fenster ein oder aus",
			ENABLEMENU	= "Schaltet das Rechtsklick Men\195\188 ein oder aus",
			SHOWBUFFS	= "Schaltet das Anzeigen von Buff/Debufffs ein oder aus",
			DEFICIT		= "Schaltet das Anzeigen von Lebensdefizit ein oder aus (Max Leben - gegenw\195\164rtiges Leben)",
			SIDE		= "Stellt die Seite ein wo angeheftet werden soll",
			LEVEL		= "Stellt ein welche Stufe verwendet werden soll zum relativen Fixpunkt (<-1: richtung mitte, 0: beim fixpunkt, >1: weg von der mitte)",
		},
		SIDE = {
			LEFT		= "Linker Fixpunkt",
			RIGHT		= "Rechter Fixpunkt",
		},
} end)

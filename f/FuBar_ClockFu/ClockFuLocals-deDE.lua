function ClockFu_Locals_deDE()

ClockFuLocals = {
	NAME = "FuBar - ClockFu",
	DESCRIPTION = "A einfache Uhr.",
	COMMANDS = {"/clfu", "/clockfu"},
	CMD_OPTIONS = {},
	ARGUMENT_TWENTYFOUR = "twentyFour",
	ARGUMENT_SHOWSECONDS = "showSeconds",
	ARGUMENT_BUBBLE = "bubble",
	ARGUMENT_LOCALTIME = "localTime",
	ARGUMENT_BOTHTIMES = "bothTimes",
	
	MENU_24_HOUR_FORMAT = "24-Stunden-Format",
	MENU_SHOW_SECONDS = "Sekunden anzeigen",
	MENU_SHOW_DAY_NIGHT_BUBBLE = "Tag/Nacht-Anzeige ein/ausschalten",
	MENU_LOCAL_TIME = "Lokale Zeit",
	MENU_SHOW_BOTH_TIMES = "Sowohl Server-, als auch lokale Zeit anzeigen",
	
	TEXT_LOCAL_TIME = "Lokale Zeit",
	TEXT_SERVER_TIME = "Serverzeit",
}

ClockFuLocals.CMD_OPTIONS = {
	{
		option = ClockFuLocals.ARGUMENT_TWENTYFOUR,
		desc = "Zwischen 12- und 24-Stunden-Format umschalten.",
		method = "ToggleTwentyFour"
	},
	{
		option = ClockFuLocals.ARGUMENT_SHOWSECONDS,
		desc = "Zeige Sekunden.",
		method = "ToggleSeconds"
	},
	{
		option = ClockFuLocals.ARGUMENT_BUBBLE,
		desc = "Zeige die Tag/Nacht-Anzeige oben rechts an der Minikarte.",
		method = "ToggleDayNightBubble"
	},
	{
		option = ClockFuLocals.ARGUMENT_LOCALTIME,
		desc = "Zwischen lokaler und Serverzeit umschalten.",
		method = "ToggleLocalTime"
	},
	{
		option = ClockFuLocals.ARGUMENT_BOTHTIMES,
		desc = "Umschalter für einfache oder doppelte Zeitanzeige.",
		method = "ToggleBothTimes"
	}
}

end
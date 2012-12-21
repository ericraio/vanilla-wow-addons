if not ace:LoadTranslation("ClockFu") then

ClockFuLocals = {
	NAME = "FuBar - ClockFu",
	DESCRIPTION = "A simplistic clock.",
	COMMANDS = {"/clfu", "/clockfu"},
	CMD_OPTIONS = {},
	ARGUMENT_TWENTYFOUR = "twentyFour",
	ARGUMENT_SHOWSECONDS = "showSeconds",
	ARGUMENT_BUBBLE = "bubble",
	ARGUMENT_LOCALTIME = "localTime",
	ARGUMENT_BOTHTIMES = "bothTimes",
	
	MENU_24_HOUR_FORMAT = "24-hour format",
	MENU_SHOW_SECONDS = "Show seconds",
	MENU_SHOW_DAY_NIGHT_BUBBLE = "Show day/night bubble",
	MENU_LOCAL_TIME = "Local time",
	MENU_SHOW_BOTH_TIMES = "Show both local and server",
	
	TEXT_LOCAL_TIME = "Local time",
	TEXT_SERVER_TIME = "Server time",
}

ClockFuLocals.CMD_OPTIONS = {
	{
		option = ClockFuLocals.ARGUMENT_TWENTYFOUR,
		desc = "Toggle between 12-hour and 24-hour.",
		method = "ToggleTwentyFour"
	},
	{
		option = ClockFuLocals.ARGUMENT_SHOWSECONDS,
		desc = "Show Seconds.",
		method = "ToggleSeconds"
	},
	{
		option = ClockFuLocals.ARGUMENT_BUBBLE,
		desc = "Show the day/night bubble on the upper-right corner of the minimap.",
		method = "ToggleDayNightBubble"
	},
	{
		option = ClockFuLocals.ARGUMENT_LOCALTIME,
		desc = "Toggle between local time and server time.",
		method = "ToggleLocalTime"
	},
	{
		option = ClockFuLocals.ARGUMENT_BOTHTIMES,
		desc = "Toggle between showing two times or just one.",
		method = "ToggleBothTimes"
	}
}

end
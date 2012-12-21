local L = AceLibrary("AceLocale-2.0"):new("FuBar_ClockFu")

L:RegisterTranslations("enUS", function() return {
	["24-hour format"] = true,
	["Toggle between 12-hour and 24-hour format"] = true,
	["Show seconds"] = true,
	["Local time"] = true,
	["Toggle between local time and server time"] = true,
	["Both times"] = true,
	["Toggle between showing two times or just one"] = true,
	["Show day/night bubble"] = true,
	["Show the day/night bubble on the upper-right corner of the minimap"] = true,
	["Set the color of the text"] = true,
	
	["AceConsole-commands"] = { "/clockfu" },
	
	["Server time"] = true,
	["UTC"] = true
} end)
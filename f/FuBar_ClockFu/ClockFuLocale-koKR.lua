local L = AceLibrary("AceLocale-2.0"):new("FuBar_ClockFu")

L:RegisterTranslations("koKR", function() return {
	["24-hour format"] = "24시간 형식",
	["Toggle between 12-hour and 24-hour format"] = "12시간과 24시간 형식 변경",
	["Show seconds"] = "초 표시",
	["Local time"] = "로컬 시간",
	["Toggle between local time and server time"] = "로컬 시간과 서버 시간 변경",
	["Both times"] = "모든 시간",
	["Toggle between showing two times or just one"] = "두 시간을 표시 하거나 하나만 표시",
	["Show day/night bubble"] = "낮/밤 표시",
	["Show the day/night bubble on the upper-right corner of the minimap"] = "미니맵의 상단우측에 낮/밤 원 표시",
	["Set the color of the text"] = "글씨 색상 변경",
	
	["AceConsole-commands"] = { "/clockfu" },
	
	["Server time"] = "서버 시간",
	["UTC"] = "UTC"
} end)

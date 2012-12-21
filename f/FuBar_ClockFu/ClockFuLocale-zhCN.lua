local L = AceLibrary("AceLocale-2.0"):new("FuBar_ClockFu")

L:RegisterTranslations("zhCN", function() return {
	["24-hour format"] = "24小时制",
	["Toggle between 12-hour and 24-hour format"] = "切换12小时制或24小时制显示方式",
	["Show seconds"] = "显示秒",
	["Local time"] = "显示本地时间",
	["Toggle between local time and server time"] = "切换显示服务器时间或本地时间",
	["Both times"] = "同时显示2个时间",
	["Toggle between showing two times or just one"] = "切换同时显示2个时间或只显示1个时间",
	["Show day/night bubble"] = "显示白天黑夜图标",
	["Show the day/night bubble on the upper-right corner of the minimap"] = "显示白天黑夜图标在小地图上",
	["Set the color of the text"] = "设置文字显示颜色",
	
	["AceConsole-commands"] = { "/clockfu" },
	
	["Server time"] = "服务器时间",
	["UTC"] = "格林威治时间"
} end)
local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("simpleMinimap_Autozoom", "enUS", function() return({
	enabled = "enabled",
		enabled_desc = "enable / disable auto zoom-out function",

	autozoom = "autozoom",
		autozoom_desc = "auto zoom-out minimap after specified time",
	time = "time",
		time_desc = "delay, in seconds, before auto zoom-out"
}) end)

local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("simpleMinimap_Pings", "enUS", function() return({
	enabled = "enabled",
		enabled_desc = "enable / disable pinger name popup",

	alpha = "alpha",
		alpha_desc = "set ping name frame alpha",
	pings = "pings",
		pings_desc = "pinger name popup frame",
	position = "position",
		position_desc = "position of coordinates frame on the minimap",
	scale = "scale",
		scale_desc = "set ping name frame scale",

	position1 = "bottom inside",
		position1_desc = "bottom of the minimap, inside the frame",
	position2 ="bottom outside",
		position2_desc = "bottom of the minimap, outside the frame",
	position3 = "top inside",
		position3_desc = "top of the minimap, inside the frame",
	position4 ="top outside",
		position4_desc = "top of the minimap, outside the frame",

	ping_by = "ping by"
}) end)

local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("simpleMinimap_GUI", "enUS", function() return({
	enabled = "enabled",
		enabled_desc = "enable / disable GUI options",
	gui = "GUI",
		gui_desc = "dropdown menu options",
	mouse = "mouse button",
		mouse_desc = "mouse button that activiates the dropdown menu"
}) end)

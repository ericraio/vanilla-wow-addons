function FuBar_Locals_deDE()
 
FuBarLocals = {
	NAME = "FuBar",
	DESCRIPTION = "Eine Leiste, in der sich Module einbinden k\195\182nnen.",
	COMMANDS = {"/fubar", "/fb", "/fbar"},
	CMD_OPTIONS = {},
	
	MAP_ONOFF = {[0]="|cffff0000Aus|r",[1]="|cff00ff00An|r"},
	
	MENU_REMOVE_PANEL = "Leiste entfernen",
	MENU_SHOW_NEW_PANEL = "Neue Leiste erstellen",
	MENU_ADJUST_FRAMES = "Frames automatisch anpassen",
	MENU_ATTACH = "Verankern",
	MENU_ATTACH_TO_TOP = "An oberen Bildschirmrand heften",
	MENU_ATTACH_TO_BOTTOM = "An unteren Bildschirmrand heften",
	MENU_DETACH_PANEL = "Leiste l\195\182sen", 
	MENU_ABOUT = "\195\156ber",
	MENU_LOCK_PANEL = "Leiste verriegeln",
	MENU_PROFILE = "Profil",
	MENU_DEFAULT_PROFILE = "Defaultprofil",
	MENU_AUTO_HIDE = "Auto-Ausblenden",
	MENU_AUTO_HIDE_TOP = "Auto-Ausblenden oben", 
	MENU_AUTO_HIDE_BOTTOM = "Auto-Ausblenden unten", 
	MENU_TRANSPARENCY = "Transparenz",
	MENU_TOOLTIP_COLOR = "Tooltipfarbe", 
	MENU_SPACING = "Abst\195\164nde",
	MENU_FONT_SIZE = "Schriftgr\195\182\195\159e", 
	MENU_THICKNESS = "Dicke", 
	WARN_REMOVE_PANEL = "Bist Du sicher, dass Du diese Leiste entfernen willst?",
	MENU_LEFT_ALIGNED = "Linksb\195\188ndig",
	MENU_CENTER_ALIGNED = "Mittig",
	MENU_RIGHT_ALIGNED = "Rechtsb\195\188ndig",
	MENU_TOOLTIP = "Tooltip",
	MENU_PANEL = "Leiste",
	MENU_TEXTURE = "Texture", -- CHECK
	MENU_OVERFLOW_PLUGINS = "Overflow plugins", -- CHECK
	
	ARGUMENT_ADJUST = "adjust",
	ARGUMENT_AUTOHIDE = "autohide",
	
	MENU_CATEGORIES = {
		bars = "Interfaceleisten",
		char = "Chat/Kommunikation",
		class = "Klassenerweiterungen",
		combat = "Kampf/Zaubern",
		compilations = "Zusammenstellungen",
		interface = "Interfaceerweiterungen",
		inventory = "Inventar/Itemerweiterungen",
		map = "Kartenerweiterungen",
		others = "Andere",
		professions = "Berufe",
		quests = "Questerweiterungen",
		raid = "Schlachtzughilfen",
	},
	MENU_OPTIONS = "Optionen",
}
 
FuBarLocals.CMD_OPTIONS = {
	{
		option = FuBarLocals.ARGUMENT_ADJUST,
		desc = "Automatische Anpassung der Blizzard-Frames umschalten.",
		method = "ToggleAdjust"
	},
	{
		option = FuBarLocals.ARGUMENT_AUTOHIDE,
		desc = "Automatisches Ausblenden der Leisten umschalten.",
		method = "ToggleAutoHiding"
	},
}
 
end
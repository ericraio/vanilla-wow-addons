if not ace:LoadTranslation("FuBar") then

FuBarLocals = {
	NAME = "FuBar",
	DESCRIPTION = "A panel that modules can plug into.",
	COMMANDS = {"/fubar", "/fb", "/fbar"},
	CMD_OPTIONS = {},
	
	MAP_ONOFF = {[0]="|cffff0000Off|r",[1]="|cff00ff00On|r"},
	
	MENU_LOCK_PANEL = "Lock panel",
	MENU_REMOVE_PANEL = "Remove panel",
	MENU_SHOW_NEW_PANEL = "Create new panel",
	MENU_ADJUST_FRAMES = "Auto-adjust frames",
	MENU_ATTACH = "Attach",
	MENU_ATTACH_TO_TOP = "Attach to top of screen",
	MENU_ATTACH_TO_BOTTOM = "Attach to bottom of screen",
	MENU_DETACH_PANEL = "Detach panel",
	MENU_ABOUT = "About",
	MENU_PROFILE = "Profile",
	MENU_DEFAULT_PROFILE = "Default profile",
	MENU_AUTO_HIDE = "Auto-hide",
	MENU_AUTO_HIDE_TOP = "Auto-hide top",
	MENU_AUTO_HIDE_BOTTOM = "Auto-hide bottom",
	MENU_TRANSPARENCY = "Transparency",
	MENU_TOOLTIP_COLOR = "Tooltip color",
	MENU_SPACING = "Spacing",
	MENU_FONT_SIZE = "Font size",
	MENU_THICKNESS = "Thickness",
	WARN_REMOVE_PANEL = "Are you sure you want to remove this panel?",
	MENU_LEFT_ALIGNED = "Left-aligned",
	MENU_CENTER_ALIGNED = "Center-aligned",
	MENU_RIGHT_ALIGNED = "Right-aligned",
	MENU_TOOLTIP = "Tooltip",
	MENU_PANEL = "Panel",
	MENU_TEXTURE = "Texture",
	MENU_OVERFLOW_PLUGINS = "Overflow plugins",
	
	ARGUMENT_ADJUST = "adjust",
	ARGUMENT_AUTOHIDE = "autohide",
	
	MENU_CATEGORIES = {
		bars = "Interface Bars",
		char = "Chat/Communications",
		class = "Class Enhancement",
		combat = "Combat/Casting",
		compilations = "Compilations",
		interface = "Interface Enhancements",
		inventory = "Inventory/Item Enhancements",
		map = "Map Enhancements",
		others = "Other",
		professions = "Professions",
		quests = "Quest Enhancements",
		raid = "Raid Assistance",
	},
	MENU_OPTIONS = "Options",
}

FuBarLocals.CMD_OPTIONS = {
	{
		option = FuBarLocals.ARGUMENT_ADJUST,
		desc = "Toggle auto-adjustment of blizzard's frames.",
		method = "ToggleAdjust"
	},
	{
		option = FuBarLocals.ARGUMENT_AUTOHIDE,
		desc = "Toggle auto-hiding of the panels.",
		method = "ToggleAutoHiding"
	},
}

end
function FuBar_Locals_frFR()

FuBarLocals = {
	NAME = "FuBar",
	DESCRIPTION = "Un panneau dans lequel des modules peuvent se brancher.",
	COMMANDS = {"/fubar", "/fb", "/fbar"},
	CMD_OPTIONS = {},
	
	MAP_ONOFF = {[0]="|cffff0000Off|r",[1]="|cff00ff00On|r"},
	
	MENU_REMOVE_PANEL = "Enlever le panneau",
	MENU_SHOW_NEW_PANEL = "Creer un nouveau panneu",
	MENU_ADJUST_FRAMES = "Auto-ajuster les cadres",
	MENU_ATTACH = "Attach", -- CHECK
	MENU_ATTACH_TO_TOP = "Encrer en haut de l'ecran",
	MENU_ATTACH_TO_BOTTOM = "Encrer en bas de l'ecran",
	MENU_DETACH_PANEL = "Detacher le panneau",
	MENU_ABOUT = "A propos",
	MENU_LOCK_PANEL = "Verouiller le panneau",
	MENU_PROFILE = "Profile",
	MENU_DEFAULT_PROFILE = "Profile de default",
	MENU_AUTO_HIDE = "Dissumulage automatique",
	MENU_AUTO_HIDE_TOP = "Auto-hide top",
	MENU_AUTO_HIDE_BOTTOM = "Auto-hide bottom",
	MENU_SPACING = "Spacing", -- CHEcK
	MENU_FONT_SIZE = "Font size", -- CHEcK
	MENU_THICKNESS = "Thickness", -- CHEcK
	WARN_REMOVE_PANEL = "Are you sure you want to remove this panel?", -- CHECK
	MENU_LEFT_ALIGNED = "Left-aligned", -- CHECK
	MENU_CENTER_ALIGNED = "Center-aligned", -- CHECK
	MENU_RIGHT_ALIGNED = "Right-aligned", -- CHECK
	MENU_TOOLTIP = "Tooltip", -- CHECK
	MENU_PANEL = "Panel", -- CHECK
	MENU_TEXTURE = "Texture", -- CHECK
	MENU_OVERFLOW_PLUGINS = "Overflow plugins", -- CHECK
	
	ARGUMENT_ADJUST = "adjust",
	ARGUMENT_AUTOHIDE = "autohide",
	
	MENU_CATEGORIES = {
		bars = "Bars d'interfaces",
		char = "Chat/Communications",
		class = "Amelioration Specefique a une Classe",
		combat = "Combat/Casting",
		compilations = "Compilations",
		interface = "Ameliorations d'Interface",
		inventory = "Ameliorations d'items/d'inventaire",
		map = "Amelioration de carte",
		others = "Autres",
		professions = "Professions",
		quests = "Ameliorations de Quetes",
		raid = "Aide raid",
	},
	MENU_OPTIONS = "Options",
}

FuBarLocals.CMD_OPTIONS = {
	{
		option = FuBarLocals.ARGUMENT_ADJUST,
		desc = "Bascule l'auto-ajustement des cadres blizzard.",
		method = "ToggleAdjust"
	},
	{
		option = FuBarLocals.ARGUMENT_AUTOHIDE,
		desc = "Bascule la dissimulation automatique du text.",
		method = "ToggleAutoHiding"
	},
}

end

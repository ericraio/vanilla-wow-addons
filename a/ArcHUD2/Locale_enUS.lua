------------------------------
----- Translation for enEN
local L = AceLibrary("AceLocale-2.0"):new("ArcHUD_Core")

L:RegisterTranslations("enUS", function() return {
	-- Core stuff
		CMD_OPTS_FRAME		= "Open options window",
		CMD_OPTS_DEBUG		= "Set debugging level",
		CMD_RESET			= "Reset settings for this character to the defaults",
		CMD_RESET_HELP		= "This option will allow you to do two things, firstly you can reset your settings to their defaults.  To do this type 'CONFIRM' after the option so that the AddOn will know you've read this information",
		CMD_RESET_CONFIRM	= "This option will reset all of your options to the default values they had when the AddOn was installed",
		TEXT_RESET			= "Please type CONFIRM after this command to confirm you really do wish to reset your settings",
		TEXT_RESET_CONFIRM	= "All settings have been reset to their defaults",

		FONT				= "FRIZQT__.TTF",

		["Version: "]		= true,
		["Author: "]		= true,

	--	Options
		TEXT = {
			TITLE		= "ArcHUD Options",

			DISPLAY		= "Display options",
			TARGETFRAME	= "Target frame",
			PLAYERMODEL	= "3D model for players",
			MOBMODEL	= "3D model for mobs",
			SHOWGUILD	= "Show player guild",
			SHOWCLASS	= "Show target class",
			NAMEPLATES	= "Player/Pet nameplates",
			ATTACHTOP	= "Attach target frame to top",
			HOVERMSG	= "Nameplate hover message",
			HOVERDELAY	= "Nameplate hover delay",
			TOT			= "Enable target's target",
			TOTOT		= "Enable target's target's target",
			BLIZZPLAYER = "Blizzard player frame visible",
			BLIZZTARGET = "Blizzard target frame visible",

			FADE		= "Fade options",
			FADE_FULL	= "When full",
			FADE_OOC	= "Out of combat",
			FADE_IC		= "In combat",

			MISC		= "Miscellanous options",
			WIDTH		= "HUD width",
			YLOC		= "Vertical alignment",
			SCALE		= "Scale",

			RINGVIS		= "Fade behaviour",
			RINGVIS_1	= "FadeFull: Fade when full",
			RINGVIS_2	= "FadeOOC: Fade when out of combat",
			RINGVIS_3	= "FadeBoth: Fade when full or out of combat",

			RINGS		= "Ring options",
			RING		= "Ring",
		},
		TOOLTIP = {
			TARGETFRAME = "Toggle display of entire target frame",
			PLAYERMODEL = "Toggle display of 3D target model of players",
			MOBMODEL	= "Toggle display of 3D target model of mobs",
			SHOWGUILD	= "Show player guild information next to their name",
			SHOWCLASS	= "Show target class or creature type",
			TOT			= "Enable displaying of target's target",
			TOTOT		= "Enable displaying of target's target's target",
			NAMEPLATES	= "Toggle display of player and pet nameplates",
			ATTACHTOP	= "Attach target frame to the top of the rings instead of the bottom",
			HOVERMSG	= "Toggle displaying of nameplate mouse input enabled in chat",
			HOVERDELAY	= "Amount of seconds needed to hover above the nameplate to activate it",
			BLIZZPLAYER = "Toggles visibility of the Blizzard player frame",
			BLIZZTARGET = "Toggles visibility of the Blizzard target frame",

			FADE_FULL	= "Alpha to fade to when out of combat and ring at 100%",
			FADE_OOC	= "Alpha to fade to when out of combat or ring not at 100%",
			FADE_IC		= "Alpha to fade to when in combat (only used if behaviour is set to FadeBoth or FadeOOC)",

			WIDTH		= "Sets how much the rings should be separated from the center",
			YLOC		= "Positions ArcHud along the Y-axis. Positive values brings it up, negative values brings it down",
			SCALE		= "Set the Scale Factor",

			RINGVIS		= "Sets when the rings fade out",
			RINGVIS_1	= "Fade out when rings are full, regardless of combat status",
			RINGVIS_2	= "Always fade out when out of combat, regardless of ring status",
			RINGVIS_3	= "Fade out when out of combat or rings are full",
		},
} end)

local LM = AceLibrary("AceLocale-2.0"):new("ArcHUD_Module")

LM:RegisterTranslations("enUS", function() return {
		FONT			= "FRIZQT__.TTF",

		["Version: "]	= true,
		["Author: "]	= true,

		TEXT = {
			ENABLED		= "Enabled",
			OUTLINE		= "Ring outline",
			SHOWTEXT	= "Show text",
			SHOWPERC	= "Show percentage",
			COLORFADE	= "Color fading",
			FLASH		= "Flash at max combo points",
			SHOWSPELL	= "Show spell being cast",
			SHOWTIME	= "Show spell timer",
			HIDEBLIZZ	= "Hide default Blizzard frame",
			ENABLEMENU	= "Enable right-click menu",
			SHOWBUFFS 	= "Show buffs/debuffs",
			DEFICIT		= "Deficit",
			ATTACH		= "Attachment",
			SIDE		= "Side",
			LEVEL		= "Level",
		},
		TOOLTIP = {
			ENABLED		= "Toggle the ring on and off",
			OUTLINE		= "Toggle the outline around the ring",
			SHOWTEXT	= "Toggle text display (health, mana, etc.)",
			SHOWPERC	= "Toggle showing percentage",
			SHOWSPELL	= "Toggle displaying of current spell being casted",
			SHOWTIME	= "Toggle showing spell timer",
			COLORFADE	= "Toggle color fading (green to red for health and so on)",
			FLASH		= "Toggle flashing when at 5 combo points",
			HIDEBLIZZ	= "Toggle showing of default Blizzard frame",
			ENABLEMENU	= "Toggle right-click menu on and off",
			SHOWBUFFS	= "Toggle display of buffs and debuffs",
			DEFICIT		= "Toggle health deficit (Max health - current health)",
			SIDE		= "Set which side to attach to",
			LEVEL		= "Set at which level it should be attached relative to the anchor (<-1: towards center, 0: at anchor, >1: away from center)",
		},
		SIDE = {
			LEFT		= "Left anchor",
			RIGHT		= "Right anchor",
		},
} end)

if ace:LoadTranslation("FuBar_ExperiencedLocals") then return end

FuBar_ExperiencedLocals = {
	NAME													= "FuBar - Experienced",
	DESCRIPTION 										= "Display experience information.",
	CHATCMD											= {"/fuxpe", "/fubar_exper"},
	CHATOPT												= {},
	
	ARGUMENT_BYLEVEL 							= "byLevel",
	ARGUMENT_SHOWXP 							= "showExp",
	ARGUMENT_LEVELXP 							= "levelExp",
	ARGUMENT_TOLEVELXP 						= "toLevelExp",
	ARGUMENT_LEVELXPPERCENT				= "levelExpPercent",
	ARGUMENT_RESTEDXP 						= "restedExp",
	ARGUMENT_RESTEDXPPERCENT			= "restedExpPercent",
	ARGUMENT_MERGEHONOR 					= "mergeHonor",
	ARGUMENT_SHOWHONOR 					= "showHonorl",

	MENU_SHOW_CURRENT_XP 				= "Show current exp",
	MENU_SHOW_TOLEVEL_XP 					= "Show exp needed to level",
	MENU_SHOW_LEVEL_XP 						= "Show next level exp",
	MENU_SHOW_LEVEL_XP_PERCENT		= "Show percent exp of current level",
	MENU_SHOW_RESTED_XP 					= "Show rested exp",
	MENU_SHOW_RESTED_XP_PERCENT		= "Show rested exp as a percentage",
	
	TEXT_LEVEL											= "Current Level:",
	TEXT_TOTAL_LEVEL_XP						= "Total XP this Level:",
	TEXT_XP_GAINED									= "Gained:",
	TEXT_XP_REMAINING							= "Remaining:",
	TEXT_RESTED_XP									= "Total Rested XP:",
	
}

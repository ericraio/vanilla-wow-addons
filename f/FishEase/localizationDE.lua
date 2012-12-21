-- Version : German (thanks to Maischter)
-- Last Update : 06/11/2005



if ( GetLocale() == "deDE" ) then

FE_BOBBER_NAME        = "Blinker";

-- binding strings
BINDING_HEADER_FE_BINDS   = FE_ADDON_NAME;
BINDING_NAME_FE_SWITCH    = "Switch Gear";

-- commands
FE_CMD_EASYCAST  = "easycast";
FE_CMD_FASTCAST  = "fastcast";
FE_CMD_SHIFTCAST = "shiftcast";
FE_CMD_SWITCH    = "switch";
FE_CMD_RESET     = "reset";

-- syntax
FE_SYNTAX_ERROR     = FE_ADDON_NAME.." Syntax Error: ";
FE_SYNTAX_EASYCAST  = " |cff00ff00"..FE_CMD_EASYCAST.."|r [on|off] (Right clicking will cast while a fishing pole is equipped.)";
FE_SYNTAX_FASTCAST  = " |cff00ff00"..FE_CMD_FASTCAST.."|r [on|off] (Automatically re-cast when you click the blinker.)";
FE_SYNTAX_SHIFTCAST = " |cff00ff00"..FE_CMD_SHIFTCAST.."|r [on|off] (Requires holding the Shift key to use EasyCast.)";
FE_SYNTAX_SWITCH    = " |cff00ff00"..FE_CMD_SWITCH.."|r (Switch between your fishing gear and regular gear.)";
FE_SYNTAX_RESET     = " |cff00ff00"..FE_CMD_RESET.."|r (Clears your saved gear sets.)";

-- Command Help
FE_COMMAND_HELP = {
	FE_ADDON_NAME.." Help:",
	"/fishease or /fe <command> [args] to perform the following commands:",
	FE_SYNTAX_EASYCAST,
	FE_SYNTAX_FASTCAST,
	FE_SYNTAX_SHIFTCAST,
	FE_SYNTAX_SWITCH,
	FE_SYNTAX_RESET,
}

-- Output Strings
FE_OUT_SET_POLE           = "Angel auf %s eingestellt.";
FE_OUT_SET_MAIN           = "Waffenhand auf %s eingestellt.";
FE_OUT_SET_SECONDARY      = "Schildhand auf %s eingestellt.";
FE_OUT_SET_FISHING_GLOVES = "Angelhandschuhe auf %s eingestellt.";
FE_OUT_SET_FISHING_HAT    = "Angel Hat auf %s eingestellt.";
FE_OUT_SET_FISHING_BOOT   = "Angel boots auf %s eingestellt.";
FE_OUT_SET_GLOVES         = "Normale Handschuhe auf %s eingestellt.";
FE_OUT_SET_HAT            = "Normale Hat auf %s eingestellt.";
FE_OUT_SET_BOOT           = "Normale Boots auf %s eingestellt.";
FE_OUT_NEED_SET_POLE      = "Bitte die Angel, die benutzt werden soll, in die Hand nehmen und nochmal versuchen.";
FE_OUT_NEED_SET_NORMAL    = "Bitte die Waffe, die benutzt werden soll, in die Hand nehmen und nochmal versuchen.";
FE_OUT_ENABLED            = "%s aktiviert";
FE_OUT_DISABLED           = "%s deaktiviet";
FE_OUT_EASYCAST           = "Einfaches Werfen";
FE_OUT_FASTCAST           = "Schnelles Werfen";
FE_OUT_SHIFTCAST          = "Shift Werfen";
FE_OUT_RESET              = "Your saved fishing gear sets have been reset.";

end
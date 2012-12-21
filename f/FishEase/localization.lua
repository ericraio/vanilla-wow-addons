-- Version : English Default (by Aalny)
-- Last Update : 08/03/2005

-- version strings
FE_ADDON_NAME  = "FishEase";
FE_ADDON_VER   = "1.2.7";

FE_BOBBER_NAME        = "Fishing Bobber";

-- binding strings
BINDING_HEADER_FE_BINDS   = FE_ADDON_NAME;
BINDING_NAME_FE_SWITCH    = "Switch Gear";
BINDING_NAME_FE_CAST      = "Cast Pole";

-- commands
FE_CMD_EASYCAST  = "easycast";
FE_CMD_FASTCAST  = "fastcast";
FE_CMD_SHIFTCAST = "shiftcast";
FE_CMD_SWITCH    = "switch";
FE_CMD_RESET     = "reset";

-- syntax
FE_SYNTAX_ERROR     = FE_ADDON_NAME.." Syntax Error: ";
FE_SYNTAX_EASYCAST  = " |cff00ff00"..FE_CMD_EASYCAST.."|r [on|off] (Right clicking will cast while a fishing pole is equipped.)";
FE_SYNTAX_FASTCAST  = " |cff00ff00"..FE_CMD_FASTCAST.."|r [on|off] (Automatically re-cast when you click the fishing bobber.)";
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
FE_OUT_SET_POLE           = "Fishing pole set to %s.";
FE_OUT_SET_MAIN           = "Main hand set to %s.";
FE_OUT_SET_SECONDARY      = "Secondary hand set to %s.";
FE_OUT_SET_FISHING_GLOVES = "Fishing gloves set to %s.";
FE_OUT_SET_FISHING_HAT    = "Fishing hat set to %s.";
FE_OUT_SET_FISHING_BOOT   = "Fishing boots set to %s.";
FE_OUT_SET_GLOVES         = "Normal gloves set to %s.";
FE_OUT_SET_HAT            = "Normal hat set to %s.";
FE_OUT_SET_BOOT           = "Normal boots set to %s.";
FE_OUT_NEED_SET_POLE      = "Please equip the fishing gear you want to use and run this command again.";
FE_OUT_NEED_SET_NORMAL    = "Please equip your primary gear and run this command again.";
FE_OUT_ENABLED            = "%s is Enabled.";
FE_OUT_DISABLED           = "%s is Disabled.";
FE_OUT_EASYCAST           = "Easy Cast";
FE_OUT_FASTCAST           = "Fast Cast";
FE_OUT_SHIFTCAST          = "Shift Cast";
FE_OUT_RESET              = "Your saved gear sets have been reset.";


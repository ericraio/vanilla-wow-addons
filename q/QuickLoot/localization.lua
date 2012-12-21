-- Version : English
-- Last Update : 02/17/2005

-- UltimateUI Configuration
ULTIMATEUI_CONFIG_QLOOT_HEADER		= "Quick Loot";
ULTIMATEUI_CONFIG_QLOOT_HEADER_INFO		= "This section configures options for Quick Loot";
ULTIMATEUI_CONFIG_QLOOT			= "Check here to enable quick looting.";
ULTIMATEUI_CONFIG_QLOOT_INFO		= "This will automatically move the first non-empty item slot in the loot window under your cursor as you loot.";
ULTIMATEUI_CONFIG_QLOOT_HIDE		= "Auto close empty loot windows.";	
ULTIMATEUI_CONFIG_QLOOT_HIDE_INFO		= "If this is enabled and you loot a corpse with no items, the loot window will be closed immediately.";
ULTIMATEUI_CONFIG_QLOOT_ONSCREEN		= "Show loot completely on screen.";
ULTIMATEUI_CONFIG_QLOOT_ONSCREEN_INFO	= "If this is enabled loot window will remain open as coin/items are looted.";

ULTIMATEUI_CONFIG_QLOOT_MOVE_ONCE		= "Only move the window to the mouse.";
ULTIMATEUI_CONFIG_QLOOT_MOVE_ONCE_INFO	= "If this is enabled, QuickLoot will not move the window more than once.";

-- Chat Configuration
QLOOT_LOADED				= "Telo's QuickLoot loaded";
ERR_LOOT_NONE				= "There was no loot to get.";

QUICKLOOT_CHAT_COMMAND_INFO		= "Sets up Quick Loot from the command line. Try it without parameters to get usage help.";
QUICKLOOT_CHAT_COMMAND_USAGE		= "Usage: /quickloot <enable/autohide/onscreen/moveonce>\nAll commands toggle the current state.\nCommands:\n enable - enables/disables Quick Loot\n autohide - whether Quick Loot should autohide empty loot windows or not\n onscree - should Quick Loot keep the loot window on screen or not";
QUICKLOOT_CHAT_COMMAND_ENABLE		= ULTIMATEUI_CONFIG_QLOOT_HEADER;
QUICKLOOT_CHAT_COMMAND_HIDE		= ULTIMATEUI_CONFIG_QLOOT_HEADER.." hiding";
QUICKLOOT_CHAT_COMMAND_ONSCREEN		= ULTIMATEUI_CONFIG_QLOOT_HEADER.." keep on screen";
QUICKLOOT_CHAT_COMMAND_MOVE_ONCE	= ULTIMATEUI_CONFIG_QLOOT_HEADER.." move once";

QUICKLOOT_CHAT_STATE_ENABLED		= " enabled";
QUICKLOOT_CHAT_STATE_DISABLED		= " disabled";
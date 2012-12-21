--[[
	Bagnon Localization file
	
	TODO:
		Add some frame strings and other things
		I could probably Babelfish the translation, but most likely it would insult someone's 
			mother or something.
--]]

BAGNON_VERSION = "6.6.26";

--[[
	English - Default Language
		This version MUST always be loaded, as it has default values for all strings.
--]]

--[[ Keybindings ]]--

BINDING_HEADER_BAGNON = "Bagnon";
BINDING_NAME_BAGNON_TOGGLE = "Toggle Bagnon";
BINDING_NAME_BANKNON_TOGGLE = "Toggle Banknon";

--[[ Slash Commands ]]--

BAGNON_COMMAND_HELP = "help";
BAGNON_COMMAND_SHOWBAGS = "bags";
BAGNON_COMMAND_SHOWBANK = "bank";
BAGNON_COMMAND_REVERSE = "reverse";
BAGNON_COMMAND_OVERRIDE_BANK = "overridebank";
BAGNON_COMMAND_TOGGLE_TOOLTIPS = "tooltips";
BAGNON_COMMAND_DEBUG_ON = "debug";
BAGNON_COMMAND_DEBUG_OFF = "nodebug";

--[[ Messages from the slash commands ]]--

--/bgn help
BAGNON_HELP_TITLE = "Bagnon commands:";
BAGNON_HELP_SHOWBAGS = "/bgn " .. BAGNON_COMMAND_SHOWBAGS .. " - Show/Hide Bagnon.";
BAGNON_HELP_SHOWBANK = "/bgn " .. BAGNON_COMMAND_SHOWBANK .. " - Show/Hide Banknon.";
BAGNON_HELP_HELP = "/bgn " .. BAGNON_COMMAND_HELP .. " - Display slash commands.";

--/bgn debug
BAGNON_DEBUG_ENABLED = "Debugging mode enabled.";

--/bgn nodebug
BAGNON_DEBUG_DISABLED = "Debugging mode disabled.";

--[[ System Messages ]]--

BAGNON_INITIALIZED = "Bagnon initialized.  Type /bagnon or /bgn for commands";
BAGNON_UPDATED = "Bagnon Settings updated to v" .. BAGNON_VERSION .. ".  Type /bagnon or /bgn for commands";

--[[ UI Text ]]--

--Titles

--These should probably read Inventory of <player> and Bank of <player> in other versions I guess
BAGNON_INVENTORY_TITLE = "%s's Inventory";
BAGNON_BANK_TITLE = "%s's Bank";

--Bag Button
BAGNON_SHOWBAGS = "Show Bags";
BAGNON_HIDEBAGS = "Hide Bags";

--General Options Menu
BAGNON_MAINOPTIONS_TITLE = "Bagnon Options";
BAGNON_MAINOPTIONS_SHOW = "Show";

--Right Click Menu
BAGNON_OPTIONS_TITLE = "%s Settings";
BAGNON_OPTIONS_LOCK = "Lock Position";
BAGNON_OPTIONS_BACKGROUND = "Background";
BAGNON_OPTIONS_REVERSE = "Reverse Bag Ordering";
BAGNON_OPTIONS_COLUMNS = "Columns";
BAGNON_OPTIONS_SPACING = "Spacing";
BAGNON_OPTIONS_SCALE = "Scale";
BAGNON_OPTIONS_OPACITY = "Opacity";
BAGNON_OPTIONS_STRATA = "Layer";
BAGNON_OPTIONS_STAY_ON_SCREEN = "Stay on Screen";

--[[ Tooltips ]]--

--Title tooltip
BAGNON_TITLE_TOOLTIP = "<Right-Click> to open up the settings menu.";

--Bag Tooltips
BAGNON_BAGS_HIDE = "<Shift-Click> to hide.";
BAGNON_BAGS_SHOW = "<Shift-Click> to show.";

--[[ Other ]]--

--fifth return for GetItemInfo(id)
BAGNON_ITEMTYPE_CONTAINER = "Container";
BAGNON_ITEMTYPE_QUIVER = "Quiver";

--sixth return for GetItemInfo(id)
BAGNON_SUBTYPE_SOULBAG = "Soul Bag";
BAGNON_SUBTYPE_BAG = "Bag";
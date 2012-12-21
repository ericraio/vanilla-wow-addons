--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerStrings.lua
--
-- Localizable strings
--===========================================================================--


--===========================================================================--
-- Core strings
-- These strings are used to match WoW output.  They *must* be localized for
-- LootTracker to work at all
--===========================================================================--

LT_YOU                      = "You";
LT_LOOT_RECEIVED            = "(.+) receives loot: (.+).";
LT_LOOT_RECEIVED_YOU        = "You receive loot: (.+).";
LT_LOOT_ITEM                = "You receive item: (.+).";
LT_LOOT_CREATED             = "You create: (.+)";
LT_LOOT_WON                 = "(.+) won: (.+)";
LT_FRIENDLY_DEATH           = "(.+) die";
LT_HOSTILE_DEATH            = "(.+) die";
LT_RECEIVED_ITEM            = "Received item: (.+)";
LT_RECEIVED_MONEY           = "Received ([%a%s%d]+).";
LT_MONEY_LOOT               = "You loot (.+)";
LT_SHARED_MONEY_LOOT        = "Your share of the loot is (.+)";
LT_REPUTATION_FACTION       = "Your reputation with ([%a%s]+) has";
LT_REPUTATION_GAINED        = "(%d+) reputation gained";
LT_REPUTATION_LOST          = "(%d+) reputation lost";
LT_EXPERIENCE_GAINED        = "You gain (%d+) experience";
LT_EXPERIENCE_GAINED_KILL   = "you gain (%d+) experience";
LT_EXPERIENCE_GAINED_EXPLORE = "(%d+) experience gained";
LT_EXPERIENCE_GAINED_QUEST   = "Experience gained: (%d+)";
LT_HONOR_GAINED_KILL        = "Estimated Honor Points: (%d+)";
LT_HONOR_GAINED_AWARD       = "You have been awarded (%d+) honor points.";
LT_SKILL_GAINED             = "Your skill in (.+) has increased to (%d+)";

LT_COIN_NAME = {
    [0] = "Gold",
    [1] = "Silver",
    [2] = "Copper"
};


--===========================================================================--
-- UI strings
--===========================================================================--

LT_LABEL_FORMAT_TIMESTART   = "%b %d";
LT_LABEL_FORMAT_TIMEELAPSED = "%H:%M:%S";
LT_LABEL_TIMESUMMARY        = "%s, %s";

LT_GOLD                 = "%dg";
LT_SILVER               = "%ds";
LT_COPPER               = "%dc";

SLASH_LT_1              = "/loottracker";
SLASH_LT_2              = "/lt";

LT_STARTUP              = "LootTracker v%s loaded (/lt for settings)";

LT_HELPMESSAGE_1        = "LootTracker v%s";
LT_HELPMESSAGE_2        = "/lt settings";
LT_HELPMESSAGE_3        = "/lt session [SessionName]";
LT_HELPMESSAGE_4        = "/lt sessions";
LT_HELPMESSAGE_5        = "/lt justmyloot [true/false]";
LT_HELPMESSAGE_6        = "/lt color [red green blue]";
LT_HELPMESSAGE_7        = "/lt update [name]";
LT_HELPMESSAGE_8        = "/lt summary [items/kills/players/name]";
LT_HELPMESSAGE_9        = "/lt reset [SessionName]";
LT_HELPMESSAGE_10       = "/lt export [SessionName]";
LT_HELPMESSAGE_11       = "/lt threshold [-1,0,1,2,3,4,5]";
LT_HELPMESSAGE_12       = "/lt transfer [source] [target] [item]";
LT_HELPMESSAGE_13       = "/lt debug [level]";

BINDING_HEADER_LOOTTRACKER  = "LootTracker";
BINDING_NAME_TOGGLESETTINGS = "Open/Close Settings";

LT_EVERYONE             = "Everyone";
LT_MONEY                = "Money";
LT_SOURCE_QUEST         = "Quest";
LT_SOURCE_CRAFT         = "Craft";
LT_SOURCE_VENDOR        = "Vendor";
LT_SOURCE_KILL          = "Kill";
LT_SOURCE_EXPLORATION   = "Exploration";
LT_EXPERIENCE           = "Experience";
LT_HONOR                = "Honor";
LT_SKILL                = "Skill";
LT_SKILL_TYPE           = "Skill - %s";
LT_REPUTATION           = "Reputation";
LT_REPUTATION_TYPE      = "Reputation - %s";
LT_REPUTATION_TYPELOST  = "Reputation Loss - %s";

LT_SLASHCOMMAND_DEBUG               = "debug";
LT_SLASHCOMMAND_DEBUG_ERROR         = "Must specify a numeric debug level";
LT_SLASHCOMMAND_DEBUG_QUERY         = "DebugLevel is \"%s\"";

LT_SLASHCOMMAND_JUSTMYLOOT          = "justmyloot";
LT_SLASHCOMMAND_JUSTMYLOOT_QUERY    = "JustMyLoot is \"%s\"";

LT_SLASHCOMMAND_SESSION             = "session";
LT_SLASHCOMMAND_SESSION_QUERY       = "CurrentSession is \"%s\"";
LT_SLASHCOMMAND_SESSION_CHANGED     = "CurrentSession changed to \"%s\"";

LT_SLASHCOMMAND_SESSIONS            = "sessions";
LT_SLASHCOMMAND_SESSIONS_QUERY      = "Listing sessions:";

LT_SLASHCOMMAND_EXPORT              = "export";
LT_SLASHCOMMAND_EXPORT_ERROR        = "Must specify an export target";
LT_SLASHCOMMAND_EXPORT_CHANGED      = "Exported \"%s\" session data to \"%s\"";

LT_SLASHCOMMAND_SUMMARY             = "summary";

LT_SLASHCOMMAND_CHATCOLOR           = "color";
LT_SLASHCOMMAND_CHATCOLOR_ERROR     = "Unrecognized color";
LT_SLASHCOMMAND_CHATCOLOR_QUERY     = "ChatColor is %f, %f, %f";

LT_SLASHCOMMAND_THRESHOLD           = "threshold";
LT_SLASHCOMMAND_THRESHOLD_ERROR     = "Must specify a threshold value";
LT_SLASHCOMMAND_THRESHOLD_QUERY     = "QualityThreshold is %d";

LT_SLASHCOMMAND_RESET               = "reset";
LT_SLASHCOMMAND_RESET_ERROR         = "Unknown session \"%s\"";
LT_SLASHCOMMAND_RESET_CHANGED       = "Resetting session \"%s\"";

LT_SLASHCOMMAND_UPDATE              = "update";
LT_SLASHCOMMAND_UPDATE_ERROR        = "Must specify an item/player/kill name";
LT_SLASHCOMMAND_UPDATE_ERROR2       = "Unknown: %s";

LT_SLASHCOMMAND_TRANSFER            = "transfer";
LT_SLASHCOMMAND_TRANSFER_ERROR      = "Must specify a source player, target player, and item name";
LT_SLASHCOMMAND_TRANSFER_ERROR2     = "Item not found: %s";
LT_SLASHCOMMAND_TRANSFER_ERROR3     = "Item not found on player: %s";
LT_SLASHCOMMAND_TRANSFER_MSG        = "Transfering \"%s\" from \"%s\" to \"%s\"";

LT_SLASHCOMMAND_SETTINGS            = "settings";

LT_SLASHCOMMAND_HELP                = "help";

LT_SLASHCOMMAND_ERROR               = "Unknown argument: %s";

LT_DEFAULT_SESSIONNAME  = "Default";
LT_VERSION_WARNING      = "LootTracker WARNING: Your data version does not match the version of the AddOn.  There may be incompatibilities.  To prevent errors you should do a Reset or delete your SavedVariables file.";

LT_BUTTON_SET           = "Set";
LT_BUTTON_CREATE        = "Create";
LT_BUTTON_RESET         = "Reset";
LT_BUTTON_DELETE        = "Delete";
LT_BUTTON_EXPORT        = "Export";
LT_BUTTON_CHATCOLOR     = "Choose Color";
LT_BUTTON_EXIT          = "Exit";

LT_LABEL_CURRENTSESSION = "Current Session";
LT_LABEL_CHANGESESSION  = "Change Session";
LT_LABEL_SESSIONS       = "Available sessions:";
LT_LABEL_SETTINGS       = "Settings";
LT_LABEL_JUSTMYLOOT     = "Ignore party loot";
LT_LABEL_THRESHOLD      = "Quality threshold: %s";
LT_LABEL_QUERY          = "Query";
LT_LABEL_QUERYITEMS     = "Items";
LT_LABEL_QUERYKILLS     = "Kills";
LT_LABEL_QUERYPLAYERS   = "Players";
LT_LABEL_TOOLTIP        = "Tooltip";
LT_LABEL_TOOLTIP_MODE   = "Tooltip mode: %s";
LT_LABEL_SHOWITEMS      = "Show items";
LT_LABEL_SHOWKILLS      = "Show kills";
LT_LABEL_SHOWPLAYERS    = "Show players";

LT_QUERY_ITEMS          = "items";
LT_QUERY_KILLS          = "kills";
LT_QUERY_PLAYERS        = "players";
LT_QUERY_TARGETS        = "targets";
LT_QUERY_LOOT           = "loot";
LT_QUERY_ERROR          = "Unknown: %s";

LT_TOOLBAR_ITEMS        = "Items: %s";
LT_TOOLBAR_KILLS        = "Kills: %s";
LT_TOOLBAR_PLAYERS      = "Players: %s";
LT_TOOLBAR_DIVIDER      = "%s | %s";

LT_TOOLTIP_VALUE        = "Total Value: %s";
LT_TOOLTIP_VALUE2       = "Total Value: %s (Player's Share: %s)";
LT_TOOLTIP_BREAKDOWN    = "Breakdown: %s";

LT_QUALITY_NAME = {
    ["-2"] = "Status",
    ["-1"] = "Money",
    ["0"]  = "Junk", 
    ["1"]  = "Common", 
    ["2"]  = "Uncommon", 
    ["3"]  = "Rare", 
    ["4"]  = "Epic", 
    ["5"]  = "Legendary"
};

LT_TOOLTIP_DESCRIPTION = {
    [1] = "Items",
    [2] = "Kills",
    [3] = "Players",
}



if (not ace:LoadTranslation("FriendsFu")) then
FriendsFULocals = {
	NAME = "FuBar - FriendsFU",
	DESCRIPTION = "Keeps track of your friends.",
	COMMANDS = {"/fbfr", "/fbfriends", "/fubar_friends"},
	CMD_OPTIONS = {},
	ARGUMENT_HIDELOCATION = "hideLocation",
	ARGUMENT_HIDELEVEL = "hideLevel",
	ARGUMENT_HIDECLASS = "hideClass",
	ARGUMENT_HIDELABEL = "hideLabel",
	ARGUMENT_SETLEADTEXT = "leadtext",
    ARGUMENT_SETLEVELRANGE = "levelrange",
    ARGUMENT_SETREFRESH = "refreshrate",
	MENU_DISPLAY = "Show",
	MENU_ORDER = "Order",
	MENU_SHOW_LOCATION = "Show location",
	MENU_SHOW_LEVEL = "Show level",
	MENU_SHOW_CLASS = "Show class",
	MENU_SHOW_LABEL = "Show label",
	MENU_SHOW_TOTAL = "Show total",
	MENU_COLORNAMES = "Color playernames according to class",
	MENU_ORDER_LOCATION = "By location",
	MENU_ORDER_LEVEL = "By level",
	MENU_ORDER_CLASS = "By class",
	MENU_ORDER_NAME = "By name",	
	MENU_INVITE = "Invite",
	MENU_WHISPER = "Whisper",
	MENU_PAGING = "Use Paging",
	MENU_PAGING_PREV = "|cff00ff33Previous page ...|r",
	MENU_PAGING_NEXT = "|cff00ff33Next page ...|r",
	MENU_PAGING_PAGE = "|cffffcc00Page %i/%i|r",
	MENU_PAGING_WARNING = "|cffff0000Too many persons, use paging.|r",
	MAX_ITEMS_SHOW = 25,
	WowMaxLevel = 60,
	REFRESHINTERVAL = 120,
	MENU_FILTER_LEVELRANGE = 5,
	MENU_FILTER = "Filter",
	MENU_FILTER_CLASS = "Class",
	MENU_FILTER_LEVEL = "Level",
	MENU_FILTER_ZONE = "Zone",
	MENU_FILTERS_ZONE= {
		"People in my zone",
		"People not in an instance",
		"People not in battlegrounds"
	},
	SYSMSG_ONLINE = "has come online",
	SYSMSG_OFFLINE = "has gone offline",
	SYSMSG_ADDED = "added to friends.",
	SYSMSG_REMOVED = "removed from friends list.",
	TOOLTIP_TITLE = "Friendlist",
	TOOLTIP_WARNING = "|cffff0000Too many persons, use filtering.|r",
	hordeClassValues = {"All", "Warrior", "Mage", "Rogue", "Druid", "Hunter", "Shaman", "Priest", "Warlock"},
	allianceClassValues = {"All", "Warrior", "Mage", "Rogue", "Druid", "Hunter", "Priest", "Warlock", "Paladin"},
	colorclasses = { 
		["Hunter"]  = "|cffaad372", 
		["Warlock"] = "|cff9382c9", 
		["Priest"]  = "|cffffffff", 
		["Paladin"] = "|cfff48cba", 
		["Shaman"]  = "|cfff48cba", 
		["Mage"]    = "|cff68ccef", 
		["Rogue"]   = "|cfffff468", 
		["Druid"]   = "|cffff7c0a", 
		["Warrior"] = "|cffc69b6d"
	},
	dungeonlist = {
		["Ahn'Qiraj"] = TRUE,
		["Blackfathom Deeps"] = TRUE,
		["Blackrock Depths"] = TRUE,
		["Blackrock Spire"] = TRUE,
		["Blackwing Lair"] = TRUE,
		["Caverns of Time"] = TRUE,
		["Dire Maul"] = TRUE,
		["Gnomeregan"] = TRUE,
		["Maraudon"] = TRUE,
		["Onyxia's Lair"] = TRUE,
		["Ragefire Chasm"] = TRUE,
		["Razorfen Downs"] = TRUE,
		["Razorfen Kraul"] = TRUE,
		["Scarlet Monastery"] = TRUE,
		["Scholomance"] = TRUE,
		["Shadowfang Keep"] = TRUE,
		["Stormwind Stockade"] = TRUE,
		["Stratholme"] = TRUE,
		["The Deadmines"] = TRUE,
		["The Molten Core"] = TRUE,
		["The Temple of Atal'Hakkar"] = TRUE,
		["The Wailing Caverns"] = TRUE,
		["Thunder Bluff"] = TRUE,
		["Uldaman"] = TRUE,
		["Zul'Farrak"] = TRUE,
		["Zul'Gurub"] = TRUE
	},
	battlegroundlist = {
		["Alterac Valley"] = TRUE,
		["Arathi Basin"] = TRUE,
		["Warsong Gulch"] = TRUE
	}
}

FriendsFULocals.CMD_OPTIONS = {
	{
		option = FriendsFULocals.ARGUMENT_SETLEADTEXT,
		desc = "Sets the leading text displayed in the bar.",
		method = "SetLeadText",
		input = TRUE,
		args = {
			{
				option = "<text>",
				desc = "This sets the leading text before the numbers in the bosspanel. Setting it to nil will clear the text."
			}
		}		
	},
	{
		option	= FriendsFULocals.ARGUMENT_SETLEVELRANGE,
		desc	= "Sets the levelrange for the level filter in the menu.",
		method	= "SetLevelRange",
		input	= TRUE,
		args	= {
			{
				option	= "<#>",
				desc	= "A number between 0 and 10. Setting it to 0 will result in a filter for your level."
			}
		}		
	},
	{
		option	= FriendsFULocals.ARGUMENT_SETREFRESH,
		desc	= "Sets the time in seconds between forced refreshes of the guild list.",
		method	= "SetRefreshRate",
		input	= TRUE,
		args	= {
			{
				option	= "<#>",
				desc	= "A number between 1 and 300. Setting it outside these numbers will result in setting it to the default value: " .. FriendsFULocals.REFRESHINTERVAL
			}
		}		
	}
}
end

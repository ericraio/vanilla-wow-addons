function GuildFu_Locals_deDE()
GuildFULocals = {
	NAME = "FuBar - GuildFu",
	DESCRIPTION = "\195\156berwacht die Gildenmitglieder-Liste.",
	COMMANDS = {"/fbg", "/fbguild", "/fubar_guild"},
    ARGUMENT_HIDELOCATION = "hideLocation", 
    ARGUMENT_HIDELEVEL = "hideLevel", 
    ARGUMENT_HIDECLASS = "hideClass", 
    ARGUMENT_HIDELABEL = "hideLabel", 
	ARGUMENT_SETLEADTEXT = "leadtext",
	ARGUMENT_SETLEVELRANGE = "levelrange",
	ARGUMENT_SETREFRESH = "refreshrate",
	MENU_DISPLAY = "Anzeigen", 
    MENU_ORDER = "Reihenfolge", 
    MENU_SHOW_LOCATION = "Zeige Ort", 
    MENU_SHOW_LEVEL = "Zeige Stufe", 
    MENU_SHOW_CLASS = "Zeige Klasse",
	MENU_SHOW_RACE = "Zeige Race",
	MENU_SHOW_RANK = "Zeige Rank",
	MENU_SHOW_PUBLICNOTES = "Zeige public notes",
	MENU_SHOW_OFFICERNOTES = "Zeige officer notes",	
    MENU_SHOW_LABEL = "Zeige Label",
	MENU_SHOW_TOTAL = "Zeige Total",
	MENU_COLORNAMES = "Color playernames according to class",
    MENU_ORDER_LOCATION = "nach Ort", 
    MENU_ORDER_LEVEL = "nach Stufe", 
    MENU_ORDER_CLASS = "nach Klasse", 
    MENU_ORDER_NAME = "nach Name",       
    MENU_INVITE = "Einladen", 
    MENU_WHISPER = "Fl\195\188stern", 
    MENU_PAGING = "Benutze Umbl\195\164ttern.", 
    MENU_PAGING_PREV = "|cff00ff33Vorherige Seite ...|r", 
    MENU_PAGING_NEXT = "|cff00ff33N\195\164chste Seite ...|r", 
    MENU_PAGING_PAGE = "|cffffcc00Seite %i/%i|r", 
    MENU_PAGING_WARNING = "|cffff0000Zuviele Personen, benutze Umbl\195\164ttern..|r", 
    MAX_ITEMS_SHOW = 25, 
    WowMaxLevel = 60, 
    REFRESHINTERVAL = 120, 
	MENU_FILTER_LEVELRANGE = 5, 
    MENU_FILTER = "Filter", 
    MENU_FILTER_CLASS = "Klasse", 
    MENU_FILTER_LEVEL = "Stufe", 
    MENU_FILTER_ZONE = "Zone",
	MENU_FILTERS_ZONE= {
		"Personen in meiner Zone",
		"Personen nicht in einen Instance",
		"Personen nicht nicht in Battlegrounds"
	},
    SYSMSG_ONLINE = "has come online",
	SYSMSG_OFFLINE = "has gone offline",
	SYSMSG_ADDED = "added to friends.",
	SYSMSG_REMOVED = "removed from friends list.",
    TOOLTIP_TITLE = "Gildenliste", 
	TOOLTIP_NOTINGUILD = "Nicht in einem guild",
    TOOLTIP_WARNING = "|cffff0000Zuviele Personen, verwende filtern.|r", 
    hordeClassValues = {"Alle", "Krieger", "Magier", "Schurke", "Druide", "J\195\164ger", "Schamane", "Priester", "Hexenmeister"}, 
    allianceClassValues = {"Alle", "Krieger", "Magier", "Schurke", "Druide", "J\195\164ger", "Priester", "Hexenmeister", "Paladin"}, 
    colorclasses = { 
		["J\195\164ger"] = "|cffaad372", 
		["Hexenmeister"] = "|cff9382c9", 
		["Priester"] = "|cffffffff", 
		["Paladin"] = "|cfff48cba", 
		["Schamane"] = "|cfff48cba", 
		["Magier"] = "|cff68ccef", 
		["Schurke"] = "|cfffff468", 
		["Druide"] = "|cffff7c0a", 
		["Krieger"] = "|cffc69b6d" 
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

GuildFULocals.CMD_OPTIONS = {
	{
		option = GuildFULocals.ARGUMENT_SETLEADTEXT,
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
		option	= GuildFULocals.ARGUMENT_SETLEVELRANGE,
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
		option	= GuildFULocals.ARGUMENT_SETREFRESH,
		desc	= "Sets the time in seconds between forced refreshes of the guild list.",
		method	= "SetRefreshRate",
		input	= TRUE,
		args	= {
			{
				option	= "<#>",
				desc	= "A number between 1 and 300. Setting it outside these numbers will result in setting it to the default value: " .. GuildFULocals.REFRESHINTERVAL
			}
		}		
	}
}

end
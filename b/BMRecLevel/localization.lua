-- *** NEW LOCALIZATION VARIABLES ***--
BRL_LOADED_INFO							= GREEN_FONT_COLOR_CODE .. "\nType '/brlconfig' in the chat frame, to open the User settings window." .. FONT_COLOR_CODE_CLOSE

BRL_RESET_ALL_TEXT						= "Do you really want to reset all settings?";
BRL_UNKNOW_ENTITY							= "Unknown Entity";
BRL_NONE											= "None";
BRL_ALLIANCE									= 0;
BRL_HORDE											= 1;
BRL_CONTESTED									= 2;
BRL_CITY											= 3;
BRL_EASTERN 									= 0;
BRL_KALIMDOR									= 1;
BRL_FACTION = {
	[BRL_ALLIANCE] = FACTION_ALLIANCE,
	[BRL_HORDE] = FACTION_HORDE,
	[BRL_CONTESTED] = "Contested",
	[BRL_CITY] = "City"
}
BRL_CONTINENT = {
	[BRL_EASTERN] = "Eastern Kingdoms",
	[BRL_KALIMDOR] = "Kalimdor"
}
	
BRL_TOOLTIP_CURRENT						= "Current:";
BRL_TOOLTIP_CLEVEL						= "Current Level: ";
BRL_TOOLTIP_CZONE							= "Current Zone: ";
BRL_TOOLTIP_CRANGE						= "Zone Range: ";
BRL_TOOLTIP_CINSTANCES				= "Instances: ";
BRL_TOOLTIP_RECOMMEND					= "Recommended Zones:";
BRL_TOOLTIP_RECOMMEND_INSTANCES = "Recommended Instances:";
BRL_TOOLTIP_RZONE							= "Zone: ";
BRL_TOOLTIP_RRANGE						= "Zone Range: ";
BRL_TOOLTIP_RFACTION					= "Faction: ";
BRL_TOOLTIP_RINSTANCES				= "Instances: ";
BRL_TOOLTIP_RCONTINENT				= "Continent: ";
BRL_TOOPTIP_TITLE							= "Zone Info";
BRL_ERROR_MESSAGE_1						= "Number must be between 0 and 1.";
BRL_TOOLTIP_TO								= "to";

BRL_ZONE_INFO_ENABLE						= "Zone Info Bar Show/Hide";
BRL_TOOLTIP_ENABLE							= "Tooltip Show/Hide";
BRL_MAP_TEXT_ENABLE							= "Map Text Show/Hide";
BRL_TOOLTIP_OFFSET_LEFT					= "Offset Left/Right";	
BRL_TOOLTIP_OFFSET_BOTTOM				= "Offset Bottom/Top";
BRL_SHOW_TOOLTIP_FACTION				= "Show Faction in Tooltip";
BRL_SHOW_TOOLTIP_INSTANCE				= "Show Instances in Tooltip";
BRL_SHOW_TOOLTIP_CONTINENT			= "Show Continent in Tooltip";
BRL_BORDER_ALPHASLIDER					= "Alpha Shade on Border";

-- ***RECOMMENDED LEVEL  INFORMATION*** ---
BRL_TITLE			= "Bhaldie Recommended Level/wmrojer version";
BRL_VERSION		= "2.0";
BRL_DESCRIPTION	= "Displays the zone level ranage of the zone you are in and also gives you a suggest zone to be in.";
BRL_LOADED		= "|cffffff00" .. BRL_TITLE .. " v" .. BRL_VERSION .. " loaded";

BM_RECOMMEND = { 
	[0]  = { zone ="City of Ironforge", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = {} },
	[1]  = { zone ="Stormwind City", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = { [0] = 17 } },
	[2]  = { zone ="The Undercity", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = {} },
	[3]  = { zone ="Dun Morogh",  low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 7 } },
	[4]  = { zone ="Elwynn Forest", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 17 } },
	[5]  = { zone ="Tirisfal Glades", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_EASTERN, instances = { [0] = 14 } },
	[6]  = { zone ="Loch Modan", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = {} },
	[7]  = { zone ="Westfall", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 20 } },
	[8]  = { zone ="Silverpine Forest", low = 10, high = 20, faction = BRL_HORDE, continent = BRL_EASTERN, instances = { [0] = 15 } },
	[9]  = { zone ="Redridge Mountains", low = 15, high = 25, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[10] = { zone ="Wetlands", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[11] = { zone ="Duskwood", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[12] = { zone ="Hillsbrad Foothills", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[13] = { zone ="Alterac Mountains", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 1 } },
	[14] = { zone ="Arathi Highlands", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[15] = { zone ="Badlands", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 21 } },
	[16] = { zone ="Stranglethorn Vale", low = 30, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[17] = { zone ="Swamp of Sorrows", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 16 } },
	[18] = { zone ="Blasted Lands", low = 47, high = 55, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[19] = { zone ="Searing Gorge", low = 43, high = 50, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[20] = { zone ="The Hinterlands", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[21] = { zone ="Blackrock Mountain", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 9, [1] = 3, [2] = 4, [3] = 5 } },
	[22] = { zone ="Burning Steppes", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 9, [1] = 3, [2] = 4, [3] = 5 } },
	[23] = { zone ="Deadwind Pass", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[24] = { zone ="Eastern Plaguelands", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 18 } },
	[25] = { zone ="Western Plaguelands", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 19 } },
	[26] = { zone ="City of Darnassus", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = {} },
	[27] = { zone ="City of Orgrimmar", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = { [0] = 11 } },
	[28] = { zone ="City of Thunder Bluff", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = {} },
	[29] = { zone ="Durotar", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = { [0] = 11 } },
	[30] = { zone ="Mulgore", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = {} },
	[31] = { zone ="Teldrassil", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_KALIMDOR, instances = {} },
	[32] = { zone ="Darkshore", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_KALIMDOR, instances = {} },
	[33] = { zone ="The Barrens", low = 10, high = 25, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = { [0] = 0, [1] = 22, [2] = 13, [3] = 12 } },
	[34] = { zone ="Ashenvale", low = 15, high = 30, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 0, [1] = 2 } },
	[35] = { zone ="Stonetalon Mountains", low = 15, high = 27, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[36] = { zone ="Thousand Needles", low = 25, high = 35, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[37] = { zone ="Desolace", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 8 } },
	[38] = { zone ="Dustwallow Marsh", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 10 } },
	[39] = { zone ="Feralas", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 6 } },
	[40] = { zone ="Silithus", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[41] = { zone ="Tanaris", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 23 } },
	[42] = { zone ="Un'Goro Crater", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[43] = { zone ="Azshara", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[44] = { zone ="Felwood", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[45] = { zone ="Moonglade", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[46] = { zone ="Wintersprings", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[47] = { zone ="Maraudon",	low = 40,	high = 50, 	faction = BRL_CONTESTED, continent = BRL_KALIMDOR,	instances = {} },
}

BM_INSTANCES = {
	[0]  = { zone = "Battleground Warsong Gulch", low = 21, high = 60 },
	[1]  = { zone = "Battleground Alterac Valley", low = 51, high = 60 },
	[2]  = { zone = "Blackfathom Deeps", low = 23, high = 30 },
	[3]  = { zone = "Blackwing Lair", low = 60, high = 60 },
	[4]  = { zone = "Blackrock Spire", low = 56, high = 60 },
	[5]  = { zone = "Blackrock Depths", low = 50, high = 56 },
	[6]  = { zone = "Dire Maul", low = 56, high = 60 },
	[7]  = { zone = "Gnomeregan", low = 26, high = 35 },
	[8]  = { zone = "Maraudon", low = 40, high = 50 },
	[9]  = { zone = "Molten Core", low = 60, high = 60 },
	[10] = { zone = "Onyxia's Lair", low = 60, high = 60 },
	[11] = { zone = "Ragefire Chasm", low = 13, high = 20 },
	[12] = { zone = "Razorfen Downs", low = 35, high = 42 },
	[13] = { zone = "Razorfen Kraul", low = 28, high = 35 },
	[14] = { zone = "Scarlet Monastary", low = 33, high = 44 },
	[15] = { zone = "Shadowfang Keep", low = 20, high = 28 },
	[16] = { zone = "Sunken Temple of Atal'Hakkar", low = 44, high = 52 },
	[17] = { zone = "Stockades", low = 20, high = 26 },
	[18] = { zone = "Stratholme", low = 56, high = 60 },
	[19] = { zone = "Scholomance", low = 58, high = 60 },
	[20] = { zone = "The Deadmines", low = 16, high = 24 },
	[21] = { zone = "Uldaman", low = 38, high = 46 },
	[22] = { zone = "Wailing Caverns", low = 15, high = 25 },
	[23] = { zone = "Zul'Farrak", low = 43, high = 50 },
}



if GetLocale() == "deDE" then
   -- German translation provided by Gizpiella

-- "Unknown Entitiy" as used in game
BRL_UNKNOW_ENTITY							= "Unbekannte Entit\195\164t";
BRL_NONE											= "Keine";
BRL_FACTION = {
	[BRL_ALLIANCE] = "Allianz",
	[BRL_HORDE] = "Horde",
	[BRL_CONTESTED] = "Umk\195\164mpft",
	[BRL_CITY] = "Stadt"
}
BRL_CONTINENT = {
	[BRL_EASTERN] = "\195\150stliche K\195\182nigreiche",
	[BRL_KALIMDOR] = "Kalimdor"
}

-- MouseOver Tooltip
BRL_TOOLTIP_CURRENT							= "Aktuell:";
BRL_TOOLTIP_CLEVEL							= "Aktuelles Level: ";
BRL_TOOLTIP_CZONE								= "Aktuelle Zone: ";
BRL_TOOLTIP_CRANGE							= "Zonenlevel: ";
BRL_TOOLTIP_CINSTANCES					= "Instanzen: ";
BRL_TOOLTIP_RECOMMEND						= "Empfohlene Zonen:";
BRL_TOOLTIP_RECOMMEND_INSTANCES = "Empfohlene Instanzen:";

-- MouseOver Tooltip continued
BRL_TOOLTIP_RZONE								= "Zone: ";
BRL_TOOLTIP_RRANGE							= "Zonenlevel: ";
BRL_TOOLTIP_RFACTION						= "Fraktion: ";
BRL_TOOLTIP_RINSTANCES					= "Instanzen: ";
BRL_TOOLTIP_RCONTINENT					= "Continent: ";
BRL_TOOPTIP_TITLE								= "Zoneninfo";
BRL_TOOLTIP_TO									= "to";

BRL_ERROR_MESSAGE_1							= "Zahl muss zwischen 0 und 1 liegen.";

BRL_ZONE_INFO_ENABLE						= "Zoneninfo Leiste anzeigen";
BRL_TOOLTIP_ENABLE							= "Tooltip anzeigen";
BRL_MAP_TEXT_ENABLE							= "Zoneninfo auf Weltkarte anzeigen";
BRL_TOOLTIP_OFFSET_LEFT					= "Offset Links/Rechts";	
BRL_TOOLTIP_OFFSET_BOTTOM				= "Offset Unten/Oben";
BRL_SHOW_TOOLTIP_FACTION				= "Show Faction in Tooltip";
BRL_SHOW_TOOLTIP_INSTANCE				= "Show Instances in Tooltip";
BRL_SHOW_TOOLTIP_CONTINENT			= "Show Continent in Tooltip";
BRL_BORDER_ALPHASLIDER					= "Transparenz der Zoneninfo Leiste";


BRL_DESCRIPTION	= "Zeigt den Levelbereich der aktuellen Zone an und gibt eine Zonenempfehlung f\195\188r dein Level.";
BRL_LOADED		= "|cffffff00" .. BRL_VERSION .. " v" .. BRL_TITLE .. " geladen";

BM_RECOMMEND = {
	[0] = { zone ="Ironforge", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = {} },
	[1] = { zone ="Stormwind", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = { [0] = 17 } },
	[2] = { zone ="Undercity", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = {} },
	[3] = { zone ="Dun Morogh", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 7 } },
	[4] = { zone ="Der Wald von Elwynn", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 17 } },
	[5] = { zone ="Tirisfal", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_EASTERN, instances = { [0] = 14 } },
	[6] = { zone ="Loch Modan", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = {}, }, 
	[7] = { zone ="Westfall", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 20 } },
	[8] = { zone ="Der Silberwald", low = 10, high = 20, faction = BRL_HORDE, continent = BRL_EASTERN, instances = { [0] = 15 } },
	[9] = { zone ="Das Redridgegebirge", low = 15, high = 25, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[10] = { zone ="Das Sumpfland", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[11] = { zone ="Duskwood", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[12] = { zone ="Die Vorgebirge von Hillsbrad", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[13] = { zone ="Das Alteracgebirge", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 1 } },
	[14] = { zone ="Das Arathi Hochland", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[15] = { zone ="Das \195\150dland", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 21 } },
	[16] = { zone ="Stranglethorn", low = 30, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[17] = { zone ="Die S\195\188mpfe des Elends", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 16 } },
	[18] = { zone ="Die verw\195\188steten Lande", low = 47, high = 55, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[19] = { zone ="Die Sengende Schlucht", low = 43, high = 50, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[20] = { zone ="Das Hinterland", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[21] = { zone ="Blackrock Mountain", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 9, [1] = 3, [2] = 4, [3] = 5 } },
	[22] = { zone ="Die brennende Steppe", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 9, [1] = 3, [2] = 4, [3] = 5 } },
	[23] = { zone ="Der Gebirgspass der Totenwinde", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[24] = { zone ="Die \195\182stlichen Pestl\195\164nder", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 18 } },
	[25] = { zone ="Die westlichen Pestl\195\164nder", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 19 } },
	[26] = { zone ="Darnassus", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = {} },
	[27] = { zone ="Orgrimmar", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = { [0] = 11 } },
	[28] = { zone ="Thunder Bluff", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = {} },
	[29] = { zone ="Durotar", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = { [0] = 11 } },
	[30] = { zone ="Mulgore", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = {} },
	[31] = { zone ="Teldrassil", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_KALIMDOR, instances = {} },
	[32] = { zone ="Darkshore", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_KALIMDOR, instances = {} },
	[33] = { zone ="Das Brachland", low = 10, high = 25, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = { [0] = 0, [1] = 22, [2] = 13, [3] = 12 } },
	[34] = { zone ="Ashenvale", low = 15, high = 30, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 0, [0] = 2 } },
	[35] = { zone ="Das Steinkrallengebirge", low = 15, high = 27, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[36] = { zone ="Thousand Needles", low = 25, high = 35, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[37] = { zone ="Desolace", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 8 } },
	[38] = { zone ="Die Marschen von Dustwallow", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 10 } },
	[39] = { zone ="Feralas", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 6 }},
	[40] = { zone ="Silithus", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[41] = { zone ="Tanaris", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 23 } },
	[42] = { zone ="Der Un'Goro Krater", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[43] = { zone ="Azshara", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[44] = { zone ="Felwood", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[45] = { zone ="Moonglade", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[46] = { zone ="Wintersprings", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[47] = { zone ="Maraudon", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
}

BM_INSTANCES = {
	[0] = { zone = "Warsong Gulch", low = 21, high = 60 },
	[1] = { zone = "Alterac Valley", low = 51, high = 60 },
	[2] = { zone = "Die Blackfathom-Tiefen", low = 23, high = 30 },
	[3] = { zone = "Blackwing Lair", low = 60, high = 60 },
	[4] = { zone = "Blackrock Spire", low = 56, high = 60 },
	[5] = { zone = "Die Blackrocktiefen", low = 50, high = 56 },
	[6] = { zone = "Dire Maul", low = 56, high = 60 },
	[7] = { zone = "Gnomeregan", low = 26, high = 35 },
	[8] = { zone = "Maraudon", low = 40, high = 50 },
	[9] = { zone = "Der geschmolzene Kern", low = 60, high = 60 },
	[10] = { zone = "Onyxia's Lair", low = 60, high = 60 },
	[11] = { zone = "Der Ragefireabgrund", low = 13, high = 20 },
	[12] = { zone = "Die H\195\188gel von Razorfen", low = 35, high = 42 },
	[13] = { zone = "Der Kraal von Razorfen", low = 28, high = 35 },
	[14] = { zone = "Das scharlachrote Kloster", low = 33, high = 44 },
	[15] = { zone = "Shadowfang Keep", low = 20, high = 28 },
	[16] = { zone = "Atal'Hakkar", low = 44, high = 52 },
	[17] = { zone = "Die Palisaden", low = 20, high = 26 },
	[18] = { zone = "Stratholme", low = 56, high = 60 },
	[19] = { zone = "Die Scholomance", low = 58, high = 60 },
	[20] = { zone = "Die Todesminen", low = 16, high = 24 },
	[21] = { zone = "Uldaman", low = 38, high = 46 },
	[22] = { zone = "H\195\182hlen des Wehklagens", low = 15, high = 25 },
	[23] = { zone = "Zul'Farrak", low = 43, high = 50 },
}

end

if GetLocale() == "frFR" then
	
	BRL_UNKNOW_ENTITY = "Entit/195/169e inconnue";
	BRL_NONE = "Rien";
	BRL_FACTION = {
		[BRL_ALLIANCE] = "Alliance",
		[BRL_HORDE] = "Horde",
		[BRL_CONTESTED] = "Contest/195/169",
		[BRL_CITY] = "Cit/195/169"
	}
	BRL_CONTINENT = {
		[BRL_EASTERN] = "Royaumes de l'est ",
		[BRL_KALIMDOR] = "Kalimdor"
	}
	
	BRL_TOOLTIP_CURRENT = "Actuel:";
	BRL_TOOLTIP_CLEVEL = "Niveau actuel: ";
	BRL_TOOLTIP_CZONE = "Zone actuelle: ";
	BRL_TOOLTIP_CRANGE = "Niveaux de la zone: ";
	BRL_TOOLTIP_CINSTANCES = "Instances: ";
	BRL_TOOLTIP_RECOMMEND = "Zones recommand/195/169es:";
	BRL_TOOLTIP_RECOMMEND_INSTANCES = "Instances recommand/195/169es:";
	BRL_TOOLTIP_RZONE = "Zone: ";
	BRL_TOOLTIP_RRANGE = "Niveaux de la zone: ";
	BRL_TOOLTIP_RFACTION = "Faction: ";
	BRL_TOOLTIP_RINSTANCES = "Instances: ";
	BRL_TOOLTIP_RCONTINENT = "Continent: ";
	BRL_TOOPTIP_TITLE = "Zone Info";
  BRL_TOOLTIP_TO		= "to";
	BRL_ERROR_MESSAGE_1 = "Nombre doit etre entre 0 et 1.";
	
	BRL_DESCRIPTION = "Montre le niveau de la zone et vous conseille des alternatives.";
	BRL_LOADED = "|cffffff00" .. BRL_TITLE .. " v" .. BRL_VERSION .. " Charg/195/169e";
	
BM_RECOMMEND = {
	[0] = { zone = "Ironforge", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = {} },
	[1] = { zone = "Cit/195/169 de Stormwind", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = { [0] = 17 } },
	[2] = { zone = "Undercity", low = 0, high = 0, faction = BRL_CITY, continent = BRL_EASTERN, instances = {} },
	[3] = { zone = "Dun Morogh", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 7 } },
	[4] = { zone = "For/195/170t d'Elwynn", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 17 } },
	[5] = { zone = "Clairi/195/168res de Tirisfal", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_EASTERN, instances = { [0] = 14 } },
	[6] = { zone = "Loch Modan", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = {} },
	[7] = { zone = "Marche de l'Ouest (Westfall)", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_EASTERN, instances = { [0] = 20 } },
	[8] = { zone = "For/195/170t des Pins argent/195/169s (Silverpine Forest)", low = 10, high = 20, faction = BRL_HORDE, continent = BRL_EASTERN, instances = { [0] = 15 } },
	[9] = { zone = "Les Carmines (Redridge Mts)", low = 15, high = 25, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[10] = { zone = "Les Paluns (Wetlands)", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[11] = { zone = "Bois de la p/195/169nombre (Duskwood)", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[12] = { zone = "Contreforts d'Hillsbrad", low = 20, high = 30, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[13] = { zone = "Montagnes d'Alterac", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 1 } },
	[14] = { zone = "Hautes-terres d'Arathi", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[15] = { zone = "Terres ingrates (Badlands)", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 21 } },
	[16] = { zone = "Vall/195/169e de Strangleronce (Stranglethorn Vale)", low = 30, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[17] = { zone = "Marais des Chagrins (Swamp of Sorrows)", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 16 } },
	[18] = { zone = "Terres foudroy/195/169es (Blasted Lands)", low = 47, high = 55, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[19] = { zone = "Gorge des Vents br/195/187lants (Searing Gorge)", low = 43, high = 50, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[20] = { zone = "Les Hinterlands", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[21] = { zone = "Mont Blackrock", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 9, [1] = 3, [2] = 4, [3] = 5 } },
	[22] = { zone = "Steppes ardentes", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 9, [1] = 3, [2] = 4, [3] = 5 } },
	[23] = { zone = "D/195/169fil/195/169 de Deuillevent (Deadwind Pass)", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = {} },
	[24] = { zone = "Maleterres de l'est (Eastern Plaguelands)", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 18 } },
	[25] = { zone = "Maleterres de l'ouest (Western Plaguelands)", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_EASTERN, instances = { [0] = 19 } },
	[26] = { zone = "Darnassus", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = {} },
	[27] = { zone = "Orgrimmar", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = { [0] = 11 } },
	[28] = { zone = "Thunder Bluff", low = 0, high = 0, faction = BRL_CITY, continent = BRL_KALIMDOR, instances = {} },
	[29] = { zone = "Durotar", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = { [0] = 11 } },
	[30] = { zone = "Mulgore", low = 1, high = 12, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = {} },
	[31] = { zone = "Teldrassil", low = 1, high = 12, faction = BRL_ALLIANCE, continent = BRL_KALIMDOR, instances = {} },
	[32] = { zone = "Sombrivage (Darkshore)", low = 10, high = 20, faction = BRL_ALLIANCE, continent = BRL_KALIMDOR, instances = {} },
	[33] = { zone = "Les Tarides (the Barrens)", low = 10, high = 25, faction = BRL_HORDE, continent = BRL_KALIMDOR, instances = { [0] = 0, [1] = 22, [2] = 13, [3] = 12 } },
	[34] = { zone = "Ashenvale", low = 15, high = 30, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 0, [1] = 2 } },
	[35] = { zone = "Les Serres-Rocheuses (Stonetalon Mts)", low = 15, high = 27, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[36] = { zone = "Mille pointes (Thousand Needles)", low = 25, high = 35, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[37] = { zone = "D/195/169solace", low = 30, high = 40, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 8 } },
	[38] = { zone = "Mar/195/169cage d'/195/130prefange (Dustwallow Marsh)", low = 35, high = 45, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 10 } },
	[39] = { zone = "Feralas", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 6 } },
	[40] = { zone = "Silithus", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[41] = { zone = "Tanaris", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = { [0] = 23 } },
	[42] = { zone = "Crat/195/168re d'Un'Goro", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[43] = { zone = "Azshara", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[44] = { zone = "Gangrebois (Felwood)", low = 48, high = 55, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[45] = { zone = "Reflet-de-Lune (Moonglade)", low = 50, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[46] = { zone = "Berceau-de-l'Hiver (Winterspring)", low = 55, high = 60, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
	[47] = { zone = "Maraudon", low = 40, high = 50, faction = BRL_CONTESTED, continent = BRL_KALIMDOR, instances = {} },
}

BM_INSTANCES = {
	[0]  = { zone = "Battleground Warsong Gulch", low = 21, high = 60 },
	[1]  = { zone = "Battleground Alterac Valley", low = 51, high = 60 },
	[2]  = { zone = "Profondeurs de Brassenoire", low = 23, high = 30 },
	[3]  = { zone = "Blackwing Lair", low = 60, high = 60 },
	[4]  = { zone = "Pic de Blackrock", low = 56, high = 60 },
	[5]  = { zone = "Profondeurs de Blackrock", low = 50, high = 56 },
	[6]  = { zone = "Haches Tripes", low = 56, high = 60 },
	[7]  = { zone = "Gnomeregan", low = 26, high = 35 },
	[8]  = { zone = "Maraudon", low = 40, high = 50 },
	[9]  = { zone = "Molten Core", low = 60, high = 60 },
	[10] = { zone = "Onyxia's Lair", low = 60, high = 60 },
	[11] = { zone = "Gouffre de Ragefeu", low = 13, high = 20 },
	[12] = { zone = "Souilles de Tranchebauge", low = 35, high = 42 },
	[13] = { zone = "Kraal de Tranchebauge", low = 28, high = 35 },
	[14] = { zone = "Monast/195/168re /195/169carlate", low = 33, high = 44 },
	[15] = { zone = "Shadowfang Keep", low = 20, high = 28 },
	[16] = { zone = "Le Temple d'Atal'Hakkar", low = 44, high = 52 },
	[17] = { zone = "Stockades", low = 20, high = 26 },
	[18] = { zone = "Stratholme", low = 56, high = 60 },
	[19] = { zone = "Scholomance", low = 58, high = 60 },
	[20] = { zone = "Mortemines", low = 16, high = 24 },
	[21] = { zone = "Uldaman", low = 38, high = 46 },
	[22] = { zone = "Cavernes des lamentations", low = 15, high = 25 },
	[23] = { zone = "Zul'Farrak", low = 43, high = 50 },
}

end
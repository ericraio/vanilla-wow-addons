-- Version : English
-- 28/09/2005 : Add Zul'gurrub, Blackwing Lair, Arathi instance

GUILDADS_TITLE				= "GuildAds";

-- Minimap button
GUILDADS_BUTTON_TIP			= "Click here to show or hide GuildAds.";

-- Config
GUILDADS_CHAT_OPTIONS		= "Chat settings";
GUILDADS_CHAT_USETHIS		= "Use this channel :";
GUILDADS_CHAT_CHANNEL		= "Name";
GUILDADS_CHAT_PASSWORD		= "Password";
GUILDADS_CHAT_COMMAND		= "Slash Command";
GUILDADS_CHAT_ALIAS 		= "Channel Alias";
GUILDADS_CHAT_SHOW_NEWEVENT	= "Show news about 'Event'"
GUILDADS_CHAT_SHOW_NEWASK	= "Show news about 'Ask'";
GUILDADS_CHAT_SHOW_NEWHAVE	= "Show news about 'Have'";
GUILDADS_ADS_OPTIONS		= "Ads settings";
GUILDADS_PUBLISH			= "Publish my ads";
GUILDADS_VIEWMYADS			= "Show my ads";
GUILDADS_ICON_OPTIONS		= "Minimap icon settings";
GUILDADS_ICON				= "Minimap icon";
GUILDADS_ADJUST_ANGLE		= "Adjust angle";
GUILDADS_ADJUST_RADIUS		= "Adjust radius";

-- Main frame
GUILDADS_MYADS				= "My Ads";
GUILDADS_BUTTON_ADDREQUEST	= "Ask";
GUILDADS_BUTTON_ADDAVAILABLE	= "Have";
GUILDADS_BUTTON_ADDEVENT	= "Participate";
GUILDADS_BUTTON_REMOVE		= REMOVE;
GUILDADS_QUANTITY			= "Quantity";
GUILDADS_SINCE				= "Since %s";
GUILDADS_ACCOUNT_NA			= "Information not available";
GUILDADS_GROUPBYACCOUNT		= "Group by account";

-- Column headers
GUILDADS_HEADER_REQUEST		= "Ask";
GUILDADS_HEADER_AVAILABLE	= "Have";
GUILDADS_HEADER_INVENTORY	= INSPECT;
GUILDADS_HEADER_SKILL 		= SKILLS;
GUILDADS_HEADER_ANNONCE		= GUILD;
GUILDADS_HEADER_EVENT		= "Events";

-- Race
GUILDADS_RACES			= {
					[1] = "Human",
					[2] = "Dwarf",
					[3] = "Night Elf",
					[4] = "Gnome",
					[5] = "Orc",
					[6] = "Undead",
					[7] = "Tauren",
					[8] = "Troll"
				};

-- Class				
GUILDADS_CLASSES		= {
					[1] = "Warrior",
					[2] = "Shaman",
					[3] = "Paladin",
					[4] = "Druid",
					[5] = "Rogue",
					[6] = "Hunter",
					[7] = "Warlock",
					[8] = "Mage",
					[9] = "Priest"
				};

-- Faction
GUILDADS_ALLIANCE = 1;
GUILDADS_HORDE = 2;
GUILDADS_RACES_TO_FACTION = {
					[1] = GUILDADS_ALLIANCE,
					[2] = GUILDADS_ALLIANCE,
					[3] = GUILDADS_ALLIANCE,
					[4] = GUILDADS_ALLIANCE,
					[5] = GUILDADS_HORDE,
					[6] = GUILDADS_HORDE,
					[7] = GUILDADS_HORDE,
					[8] = GUILDADS_HORDE
					};
					
GUILDADS_CLASS_TO_FACTION = {
					[2] = GUILDADS_HORDE,
					[3] = GUILDADS_ALLIANCE,
					};

-- Item
GUILDADS_ITEMS = {
					everything		= "Everything",
					everythingelse	= "Everything else",
					monster			= "Monster drop",
					classReagent	= "Class reagents",
					tradeReagent	= "Tradeskills reagents",
					vendor			= "Vendor",
					trade			= "Tradeskills production",
					gather			= "Gather",
				};
				
GUILDADS_ITEMS_SIMPLE = {
					everything	= "Everything"
				};
				
-- Skill
GUILDADS_SKILLS	= {
					[1]  = "Herbalism",
					[2]  = "Mining",
					[3]  = "Skinning",
					[4]  = "Alchemy",
					[5]  = "Blacksmithing",
					[6]  = "Engineering",
					[7]  = "Leatherworking",
					[8]  = "Tailoring",
					[9]  = "Enchanting",
					[10] = "Fishing",
					[11] = "First Aid",
					[12] = "Cooking",
					[13] = "Lockpicking",
				-- [14] = "Poisons",
					
					[20] = "Fist Weapons",
					[21] = "Daggers",
					[22] = "Swords",
					[23] = "Two-Handed Swords",
					[24] = "Maces",
					[25] = "Two-Handed Maces",
					[26] = "Axes",
					[27] = "Two-Handed Axes",
					[28] = "Polearms",
					[29] = "Staves",
					[30] = "Thrown",
					[31] = "Guns",
					[32] = "Bows",
					[33] = "Crossbows",
					[34] = "Wands"
				};

-- Equipment
GUILDADS_EQUIPMENT = "Equipment";

-- Tooltip requests
GUILDADS_ASKTOOLTIP	= "%i request(s)";

-- Instances
GUILDADS_EVENTS_TITLE = "Instances";
GUILDADS_EVENTS		= {
					"Ragefire Chasm",
					"Deadmines",
					"Wailing Caverns",
					"Shadowfang Keep",
					"Blackfeathom Deeps",
					"Gnomeregan",
					"Razorfen Kraul",
					"The Scarlet Monastery",
					"Razorfen Downs",
					"Uldaman",
					"Maraudon",
					"Zul'Farrak",
					"The Sunken Temple",
					"Blackrock Depths",
					"Blackrock Spire",
					"Stratholme",
					"Dire Maul",
					"Scholomance",
					"Upper Blackrock Spire",
					"Onyxia Lair",
					"Molten Core",
					"Zul'Gurub",
					"Blackwing Lair",
					"BG Alterac",
					"BG Arathi",
					"BG Warsong"
				};
				
-- GuildAds
GUILDADS_TS_LINK			= GUILDADS_TITLE;
GUILDADS_TS_ASKITEMS		= "Ask for items of %i %s";
GUILDADS_TS_ASKITEMS_TT		= "Modify the number of objects to be created to set the quantities.";

-- Binding
BINDING_HEADER_GUILDADS		= GUILDADS_TITLE;
BINDING_NAME_SHOW			= "Show GuildAds";
BINDING_NAME_SHOW_CONFIG	= "Show GuildAds configuration"

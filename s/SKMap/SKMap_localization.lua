
-- note about localization :
-- WoW uses UTF-8 encoded file for all special characters, and NOT
-- extended ASCII. Thus it's not possible to just type in "é" for instance.
-- instead of converting my file to UTF-8 I'll be using escape sequences, this will prevent
-- all conversion problems.

-- Ü (U trema) = \195\156
-- ü (u trema) = \195\188
-- é (e accent aigu) = \195\169
-- è (e accent grave) = \195\168
-- ê (e accent circ) = \195\170
-- â (a accent circ) = \195\162
-- à (a accent grave) = \195\160
-- ç (c cedille) = \195\167
-- û (u accent circ) = \195\187
-- ô (o accent circ) = \195\180
-- \195\182 (o trema) = \195\182
-- ' (apostrophe) = \226\128\153


SKM_CurrentLocale = string.upper(string.sub(GetLocale(), 1, 2)); -- FR, EN or DE
--SKM_CurrentLocale = "FR";
--SKM_CurrentLocale = "DE";

-- Fix provided because GetZoneText() does not always match the zone text that is returned
-- by GetMapZones. To my knowledge, the only occurence of this problem is Ironforge. If there
-- are more, add more values to the structure.
-- dunno if localization is needed, hope not...
SKM_ZoneFix = {
	{ Val_ZoneText = "City of Ironforge";
		Val_MapZones = "Ironforge";
	}
};

SKM_Locale = {
	["EN"] = {
		-- no local shifts
		-- no current shift (obviously, since we want to convert to EN order)
	};
	["FR"] = {
		-- local shifts
		LocalShift = {
			[1] = {
				Source = "FR 1_4_2";
				Dest = "FR 1_5_0";
				DateShift = "08/06/2005 00:00:00";
			};

			[2] = {
				Source = "FR 1_5_1";
				Dest = "FR 1_6_0";
				DateShift = "13/07/2005 00:00:00";
			};
		};
		-- current shift
		CurrentShift = {
			Source = "FR 1_6_0";
			Dest = "EN 1_6_0";
		};
	};
	["DE"] = {
		-- no local shifts
		-- current shifts
		CurrentShift = {
			Source = "DE 1_6_0";
			Dest = "EN 1_6_0";
		};
	};
};

SKM_ShiftTables = {
	["FR 1_4_2"] = {
		["FR 1_5_0"] = {
			-- french 1.4.2 -> french 1.5.0 (and 1.5.1) zone shift
			-- thanks to Gatherer
			{  1, 2, 3, 4, 6, 5, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21 },
			{ 23,22, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,17,18,19,15,16,20,21,24,25 }
		};
	};
	["FR 1_5_1"] = {
		["FR 1_6_0"] = {
			-- french 1.5.1 -> french 1.6.0 zone shift
			-- thanks to Gatherer
			{  1, 2, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21, 3 },
			{  1, 2, 6, 4, 5, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20, 3,21,22,23,24,25 }
		};
	};
	["FR 1_6_0"] = {
		["EN 1_6_0"] = {
			-- french 1.6 -> english 1.6 zone shift
			{  1, 2,21,20, 4, 6, 5, 9, 8,14,17, 7,18,11,12,10,13, 3,15,16,19 },
			{  8,17,21,11, 7, 6,10,16,15, 2,12,14,20,25,13, 9,23,19,24, 1, 5, 4, 3,22,18 };
		};
	};

	["DE 1_6_0"] = {
		["EN 1_6_0"] = {
			-- deutsch 1.6 -> english 1.6 zone shift
			-- CHECK !!
			{  1, 2, 3, 4,17,14,20, 5, 7, 6, 8, 9,10,11,12,13,15,16,18,19,21 },
			{  1, 2,20,14,25, 3, 6,16,10,15,19,11, 5, 4,23, 9, 7, 8,12,13,17,18,21,22,24};
		};
	};

	["EN 1_6_0"] = {
		["FR 1_6_0"] = {
			-- english 1.6 -> french 1.6 zone shift (for reverse shift)
			{  1, 2,18, 5, 7, 6,12, 9, 8,16,14,15,17,10,19,20,11,13,21, 4, 3 },
			{ 20,10,23,22,21, 6, 5, 1,16, 7, 4,11,15,12, 9, 8, 2,25,18,13, 3,24,17,19,14 };
		};
		["DE 1_6_0"] = {
			-- english 1.6 -> deutsch 1.6 zone shift (for reverse shift)
			-- thanks to Gatherer
			-- CHECK !!
			{  1, 2, 3, 4, 8, 10, 9, 11, 12, 13, 14, 15, 16, 6, 17, 18, 5, 19, 20, 7, 21 },
			{  1, 2, 6, 14, 13, 7, 17, 18, 16, 9, 12, 19, 20, 4, 10, 8, 21, 22, 11, 3, 23, 24, 15, 25, 5 };
		};
	};

};


if (SKM_Locale[SKM_CurrentLocale]) and (SKM_Locale[SKM_CurrentLocale].CurrentShift) then
	SKM_ZoneShift = SKM_ShiftTables[SKM_Locale[SKM_CurrentLocale].CurrentShift.Source][SKM_Locale[SKM_CurrentLocale].CurrentShift.Dest];
end


-- --------------------------------------------------------------------------------------
-- ENGLISH LOCALIZATION
-- --------------------------------------------------------------------------------------

-- Parsing patterns
SKM_PATTERN = {

	-- (Player) versus (Non Player)
	Player_HitDamage = "You hit %s for %d";
	Player_HitCritDamage = "You crit %s for %d";
	Player_SpellDamage = "Your %s hits %s for %d";
	Player_SpellCritDamage = "Your %s crits %s for %d";
	Player_DotDamage = "%s suffers %d %s damage from your %s";

	-- (Non Player A) versus (Non Player B)
	Other_HitDamage = "%s hits %s for %d";
	Other_HitCritDamage = "%s crits %s for %d";
	Other_SpellDamage = "%s's %s hits %s for %d";
	Other_SpellCritDamage = "%s's %s crits %s for %d";
	Other_DotDamage = "%s suffers %d %s damage from %s's %s";

--	Other_TotemDamage = "%s's Attack hits %s for %d";

	-- (Non Player) versus (Player)
	Self_HitDamage = "%s hits you for %d";
	Self_HitCritDamage = "%s crits you for %d";
	Self_SpellDamage = "%s's %s hits you for %d";
	Self_SpellCritDamage = "%s's %s crits you for %d";
	Self_DotDamage = "You suffers %d %s damage from %s's %s";


	Other_Death = "%s dies";


	-- Xp gain messages
	XpGain_Rested_Solo = "%s dies, you gain %d experience. (%d exp %d bonus)";
	XpGain_Rested_Group = "%s dies, you gain %d experience. (%d exp %d bonus, +%d group bonus)";
	XpGain_Rested_Raid = "%s dies, you gain %d experience. (%d exp %d bonus, -%d raid penalty)";

	XpGain_Solo = "%s dies, you gain %d experience.";
	XpGain_Group = "%s dies, you gain %d experience. (+%d group bonus)";
	XpGain_Raid = "%s dies, you gain %d experience. (-%d raid penalty)";


	-- Honor kill
	--Honor_Kill = "%s dies, honorable kill.(Rank: %s)"; -- old version
	--Honor_Kill = "%s dies, honorable kill Rank: %s (Estimated Honor Points: %d)";	-- new version
	Honor_Kill = COMBATLOG_HONORGAIN;

	-- Duel messages
	Duel_Won = "%s has defeated %s in a duel";
	Duel_Fled = "%s has fled from %s in a duel";


	-- pattern for totem units names : type followed by a blank and "Totem".
	-- the blank character insures this is not a player.
	Totem = "%s Totem";
};

-- Races
SKM_RACE = {
	Dwarf = "Dwarf";
	Gnome = "Gnome";
	Human = "Human";
	NightElf = "Night Elf";

	Orc = "Orc";
	Tauren = "Tauren";
	Troll = "Troll";
	Undead = "Undead";
};

-- Classes
SKM_CLASS = {
	Druid = "Druid";
	Hunter = "Hunter";
	Mage = "Mage";
	Paladin = "Paladin";
	Priest = "Priest";
	Rogue = "Rogue";
	Shaman = "Shaman";
	Warrior = "Warrior";
	Warlock = "Warlock";
};

SKM_BATTLEGROUNDS = {
	"Warsong Gulch",
	"Alterac Valley",
	"Arathi Basin"
};

-- this is the localized zone names but matching the current english zone order
SKM_ZoneText = {
	{	"Ashenvale",
		"Azshara",
		"Darkshore",
		"Darnassus",
		"Desolace",
		"Durotar",
		"Dustwallow Marsh",
		"Felwood",
		"Feralas",
		"Moonglade",
		"Mulgore",
		"Orgrimmar",
		"Silithus",
		"Stonetalon Mountains",
		"Tanaris",
		"Teldrassil",
		"The Barrens",
		"Thousand Needles",
		"Thunder Bluff",
		"Un'Goro Crater",
		"Winterspring",
	},
	{	"Alterac Mountains",
		"Arathi Highlands",
		"Badlands",
		"Blasted Lands",
		"Burning Steppes",
		"Deadwind Pass",
		"Dun Morogh",
		"Duskwood",
		"Eastern Plaguelands",
		"Elwynn Forest",
		"Hillsbrad Foothills",
		"Ironforge",
		"Loch Modan",
		"Redridge Mountains",
		"Searing Gorge",
		"Silverpine Forest",
		"Stormwind City",
		"Stranglethorn Vale",
		"Swamp of Sorrows",
		"The Hinterlands",
		"Tirisfal Glades",
		"Undercity",
		"Western Plaguelands",
		"Westfall",
		"Wetlands",
	}
};


-- UI Strings
SKM_UI_STRINGS = {

	-- PvP Target Info Frame
	Map_Window_Title = "SKMap Records";
	Small_Target_Info_Kill = "Kill : ";
	Small_Target_Info_Death = "Death : ";
	Small_Target_Info_Met = "Met : ";
	War_Floating_Message = "At WAR with ";
	Small_Target_War = "WAR";
	Since = " since ";
	Small_Target_Honor = "Honor : ";
	Small_Target_NoHonor = "None";


	-- Minimap button
	MinimapButton_Tooltip = "SKMap interface toggle";


	-- Options Tab
	Options_Label_General = "General configuration";
	Options_Label_Map = "Map configuration";
	Options_Label_War = "WAR configuration";
	Options_Label_Record = "Record configuration";
	Options_Label_Minimap = "Minimap configuration";
	Options_Label_Cleanup = "Clean-up configuration";

	Options_Check_ShowTargetInfo = "Enable PvP target info frame";
	Options_Tooltip_ShowTargetInfo = "Display PvP information about your current target";

	Options_Button_SmallTargetInfo = "Reduced-size target info frame";
	Options_Tooltip_SmallTargetInfo = "Use compact version of PvP information frame";

	Options_Button_WarSoundWarning = "WAR mouse-over sound warning";
	Options_Tooltip_WarSoundWarning = "Play a sound when mouse-over on an enemy at WAR";

	Options_Button_WarFloatingMessage = "WAR mouse-over floating message warning";
	Options_Tooltip_WarFloatingMessage = "Display a floating message when mouse-over on an enemy at WAR";

	Options_Button_WarAutoTarget = "WAR mouse-over auto target";
	Options_Tooltip_WarAutoTarget = "Automatically targets enemies at WAR seen on mouse-over (if no current target)";

	Options_Button_RecordPlayerKill = "Record enemy players kills";
	Options_Tooltip_RecordPlayerKill = "Keep track of enemy players you kill";

	Options_Button_RecordCreatureKill = "Record creature kills";
	Options_Tooltip_RecordCreatureKill = "Keep track of the most recent creatures you kill";

	Options_Button_RecordPlayerDeath = "Record player PvP deaths";
	Options_Tooltip_RecordPlayerDeath = "Keep track of your deaths caused by enemy players";

	Options_Button_DisplayKillRecord = "Display player kill record";
	Options_Tooltip_DisplayKillRecord = "Display a message when recording a player kill";

	Options_Button_DisplayCreatureKillRecord = "Display creature kill record";
	Options_Tooltip_DisplayCreatureKillRecord = "Display a message when recording a creature kill";

	Options_Button_DisplayDeathRecord = "Display player death record";
	Options_Tooltip_DisplayDeathRecord = "Display a message when recording a death";

	Options_Button_MapDisplayRecords = "Display recorded events on world map";
	Options_Tooltip_MapDisplayRecords = "Graphically display recorded events on the world map";

	Options_Slider_CreatureKillRecordsByZone = "Max. creature kill";
	Options_Tooltip_CreatureKillRecordsByZone = "Maximum number of creature kills recorded by zone";

	Options_Button_IgnoreLowerEnemies = "Ignore low level enemies";
	Options_Tooltip_IgnoreLowerEnemies = "Disable storage of information related to low level enemies";

	Options_Slider_IgnoreLevelThreshold = "Ignore level threshold";
	Options_Tooltip_IgnoreLevelThreshold = "Ignore inactive enemies less than % of your level";

	Options_Button_ShowTargetGuildInfo = "Display enemy player guild";
	Options_Tooltip_ShowTargetGuildInfo = "Display the guild to which belong currently targetted enemy player (if any)";

	Options_Button_ShowTargetClassInfo = "Display enemy player class";
	Options_Tooltip_ShowTargetClassInfo = "Display currently targetted enemy player class (if any)";

	Options_Button_ShowWorldMapControl = "Show world map control frame";
	Options_Tooltip_ShowWorldMapControl = "Display a mini frame on the world map to display or hide records";

	Options_Button_ShowMinimapButton = "Show minimap button";
	Options_Tooltip_ShowMinimapButton = "Show or hide the interface minimap button";

	Options_Slider_MinimapButtonPosition = "Minimap button position";
	Options_Tooltip_MinimapButtonPosition = "Relative position of the interface minimap button";

	Options_Slider_MinimapButtonOffset = "Minimap button offset";

	Options_Tooltip_MinimapButtonOffset = "Offset of the interface minimap button";

	Options_Button_IgnoreNoPvPFlag = "Ignore non PvP flagged enemies";
	Options_Tooltip_IgnoreNoPvPFlag = "Disable storage of information related to enemies without a PvP flag";

	Options_Button_StoreEnemyPlayers = "Store enemy players";
	Options_Tooltip_StoreEnemyPlayers = "Store information about enemy players when you meet them. WARNING : disabling this option will prevent assigning deaths and kills to enemy players";

	Options_Button_StoreDuels = "Store duels";
	Options_Tooltip_StoreDuels = "Keep track of your duels";

	Options_Button_LockedTargetInfo = "Lock PvP target info frame";
	Options_Tooltip_LockedTargetInfo = "Prevents from moving the PvP information frame";


	Options_Button_TooltipTargetInfo = "Add PvP info to Game Tooltip";
	Options_Tooltip_TooltipTargetInfo = "Add enemy player PvP information to Game Tooltip";

	Options_Button_WarEnableFilter = "WAR filter delay";
	Options_Tooltip_WarEnableFilter = "Filter out WAR message and sound warnings if minimum delay is not yet elapsed";

	Options_Slider_WarFilterDelay = "WAR filter delay";
	Options_Tooltip_WarFilterDelay = "Minimum delay (in seconds) between two WAR warnings";

	Options_Button_WarChatMessage = "WAR mouse-over chat message warning";
	Options_Tooltip_WarChatMessage = "Display a message in the default chat frame when mouse-over on an enemy at WAR";

	Options_Button_WarShowNote = "Show associated player note";
	Options_Tooltip_WarShowNote = "Add to the chat message your note associated to this enemy (if any)";

	Options_Button_DataCleanUp = "Enable automatic data clean-up";
	Options_Tooltip_DataCleanUp = "Perform automatic data clean-up at regular intervals";

	Options_Slider_DataCleanUpInterval = "Automatic data clean-up interval";
	Options_Tooltip_DataCleanUpInterval = "Data clean-up interval (in days)";

	Options_Button_CleanInactiveEnemies = "Delete long time inactive enemies";
	Options_Tooltip_CleanInactiveEnemies = "Delete long time not seen enemies that are inactive, i.e. enemies not at WAR and for which you do not have any PvP record";

	Options_Slider_CleanInactiveEnemiesDelay = "Long time not seen enemies deletion delay";
	Options_Tooltip_CleanInactiveEnemiesDelay = "Long time not seen enemies deletion delay (in days)";

	Options_Button_SharedWarMode = "Shared WAR mode";
	Options_Tooltip_SharedWarMode = "Issue WAR warnings if any of your characters is at WAR with a given enemy (even if the character you're currently playing is not)";

	Options_Button_TooltipPlayerNote = "Add player note to Game Tooltip";
	Options_Tooltip_TooltipPlayerNote = "Add player note associated to an enemy to Game Tooltip";

	Options_Button_EnemyListAutoUpdate = "Enemy list automatic update";
	Options_Tooltip_EnemyListAutoUpdate = "Automatically update (if needed) the enemy list each time the corresponding interface panel is opened";

	Options_Slider_EnemyListAutoUpdateDelay = "Enemy list automatic update minimum delay";
	Options_Tooltip_EnemyListAutoUpdateDelay = "Minimum delay between two automatic updates of the enemy list (in seconds)";

	Options_Button_CleanEmptyGuilds = "Delete empty guilds";
	Options_Tooltip_CleanEmptyGuilds = "Delete guilds to which no known enemy player belong anymore";

	Options_Button_RecordPlayerDeathNonPvP = "Record player non-PvP deaths";
	Options_Tooltip_RecordPlayerDeathNonPvP = "Keep track of your deaths not caused by enemy players";

	Options_Button_ReportPlayerDeath = "Report player death";
	Options_Tooltip_ReportPlayerDeath = "When you die, display a report of enemies responsible for your death";


	-- List Frame Detail labels
	-- 0.08.2 Begin of modification: Add localization for list frame
	List_Frame_Player = "Player :  ";
	List_Frame_Guild = "Guild :  ";
	List_Frame_Level = "Level ";
	List_Frame_Last_Seen = "Last seen :  ";
	List_Frame_Last_Updated = "Last updated :  ";
	List_Frame_Met = "Met :  ";
	List_Frame_Death = "Death :  ";
	List_Frame_Kill = "Kill :  ";
	List_Frame_Full = "Full :  ";
	List_Frame_Standard = "Standard :  ";
	List_Frame_Assist = "Assist :  ";
	List_Frame_Note = "Note :  ";
	List_Frame_Guild_Member = "Known members :  ";
	List_Frame_LoneWolf = "Lone Wolf Kill :  ";
	List_Frame_HonorKill = "Honor Kill :  ";
	List_Frame_RemainHonor = "Remaining today :  ";
	List_Frame_BGKill = "BG Kill :  ";
	List_Frame_BGDeath = "BG Death :  ";
	-- 0.08.2 End of modification: Add localization for list frame

	List_Frame_Last_Duel = "Last duel :  ";
	List_Frame_Duel = "Duels :  ";
	List_Frame_Win = "Win :  ";
	List_Frame_Loss = "Loss :  ";
	List_Frame_Score = "Score :  ";

	List_Button_FilterNoWar = "Show 'at war' only";
	List_Tooltip_FilterNoWar = "Filter out enemies or guilds not at war";

	List_ConfirmDeletePlayer = "%sThis will delete %s%s%s and *all* map records associated (kills and deaths). Are you really sure ?";

	Duel_ConfirmDeletePlayer = "%sThis will delete %s%s%s and *all* associated duel information. Are you really sure ?";

	List_EditNote_Title = "Edit Note";
	List_EditPlayerNote_Prompt = "%sEnter note for player  %s%s%s  :";
	List_EditGuildNote_Prompt = "%sEnter note for guild  <%s%s%s>  :";


	-- Book frame
	Book_Page = "Page";

	Book_GeneralStat_Header = "General PvP Statistics";
	Book_ClassStat_Header = "Class PvP Statistics";
	Book_RaceStat_Header = "Race PvP Statistics";
	Book_EnemyStat_Header = "Enemy PvP Statistics";
	Book_GuildStat_Header = "Guild PvP Statistics";
	Book_ZoneStat_Header = "Zone PvP Statistics";
	Book_DateStat_Header = "Date PvP Statistics";
	Book_BGDateStat_Header = "Date Battleground Statistics";
	Book_BGZoneStat_Header = "Zone Battleground Statistics";
	Book_BGDateZoneStat_Header = "Date/Zone Battleground Statistics";

	Book_TotalKill = "Total PvP Kills";
	Book_TotalDeath = "Total PvP Deaths";
	Book_TotalRatio = "Ratio Kill/Total";
	Book_AverageKillLevel = "Avg level of victims";
	Book_AverageDeathLevel = "Avg level of executioners";

	Book_EnemyPlayers = "Known enemy players";
	Book_EnemyGuilds = "Known enemy guilds";
	Book_MapRecords = "Total map records";

	Book_Label_Class = "Class";
	Book_Label_Race = "Race";
	Book_Label_Enemy = "Enemy";
	Book_Label_Guild = "Guild";
	Book_Label_Zone = "Zone";
	Book_Label_Date = "Date";
	Book_Label_Kill = "Kill";
	Book_Label_Death = "Death";
	Book_Label_Ratio = "Ratio";
	Book_Label_DateZone = "Date/Zone";

	Book_NoData = "No data available";

	Book_Format_AssistKill = "You killed %s (Assist kill)";
	Book_Format_Kill = "You killed %s (Standard kill)";
	Book_Format_FullKill = "You killed %s (Full kill)";
	Book_Format_LoneWolfKill = "You killed %s (Lone Wolf kill)";
	Book_Format_Death = "%s killed you";

	Report_Button_UseAssist = "Count assist kills";
	Report_Tooltip_UseAssist = "Take 'assist' kills into account for statistics and reports";


	-- World map control frame
	WorldMap_Button_ShowRecords = "Show records";


	-- Messages optionaly displayed in chat window when recording events
	RecordMessage_PlayerPvPDeath = "Player death (killed by %s) recorded";
	RecordMessage_PlayerPvEDeath = "Player death (killed by %s) recorded";
	RecordMessage_PlayerDeath = "Player death recorded";

	RecordMessage_AssistKill = "%s <- Assist Kill recorded";
	RecordMessage_Kill = "%s <- Kill recorded";
	RecordMessage_FullKill = "%s <- Full Kill recorded";

	RecordMessage_CreatureKill = "%s <- Kill recorded";

	ReportMessage_PlayerDeath = "Player death - responsibilities report (top %d)";

};

-- Note : the following UI strings can't be in a table because they are directly substituted from
-- values in xml file.

-- tab labels
SKMAP_TAB_LIST = "PvP";
SKMAP_TAB_DUEL = "Duels";
SKMAP_TAB_REPORT = "Hall of Fame";
SKMAP_TAB_OPTIONS	= "Options";

-- lists column headers
SKMAP_COLUMN_NAME 	= "Name";	-- player + guild
SKMAP_COLUMN_GUILD 	= "Guild";	-- player
SKMAP_COLUMN_RACE 	= "Race";	-- player
SKMAP_COLUMN_CLASS 	= "Class";	-- player
SKMAP_COLUMN_LEVEL 	= "Lvl";	-- player
SKMAP_COLUMN_KILL 	= "Kill";	-- player + guild
SKMAP_COLUMN_DEATH 	= "Death";	-- player + guild
SKMAP_COLUMN_MET 	= "Met";	-- player + guild
SKMAP_COLUMN_LASTSEEN 	= "Last seen";	-- player + guild
SKMAP_COLUMN_ATWAR 	= "War ?";	-- player + guild
SKMAP_COLUMN_MEMBERS	= "Members";	-- guild
-- 0.08.1 Begin of modification: add localization ofr ATWar status
SKMAP_COLUMN_ATWAR_ALL = "All";
SKMAP_COLUMN_ATWAR_PLAYER = "Player";
SKMAP_COLUMN_ATWAR_GUILD = "Guild";
-- 0.08.1 End of modification: add localization ofr ATWar status

SKMAP_COLUMN_WIN = "Win";
SKMAP_COLUMN_LOSS = "Loss";
SKMAP_COLUMN_DUELS = "Duels";
SKMAP_COLUMN_LASTDUEL = "Last duel";
SKMAP_COLUMN_SCORE = "Score";


-- "list toggle" button
SKMAP_GUILDS		= "Guilds";
SKMAP_PLAYERS		= "Players";


-- "show guild" button
SKMAP_SHOWGUILD		= "Show guild";

-- "back" button
SKMAP_BACK		= "Back";

-- "edit note" button
SKMAP_EDITNOTE		= "Edit Note";

-- "report" button
SKMAP_REPORT		= "Report";

-- "delete" button
SKMAP_DELETE		= "Delete";

-- "clear" button
SKMAP_CLEAR		= "Clear";

SKMAP_RESETSORT = "Reset sort";

SKMAP_UPDATELIST = "Update";


SKM_BTN_EXPAND_ALL = "Expand all";
SKM_BTN_COLLAPSE_ALL = "Collapse all";


-- previous and next labels for book browsing buttons
SKMAP_PREV		= "Prev";
SKMAP_NEXT		= "Next";

SKMAP_BTN_STATS_GENERAL	= "General";
SKMAP_BTN_STATS_CLASS	= "Class";
SKMAP_BTN_STATS_RACE	= "Race";
SKMAP_BTN_STATS_ENEMIES	= "Enemies";
SKMAP_BTN_STATS_GUILDS	= "Guilds";
SKMAP_BTN_STATS_ZONE	= "Map";
SKMAP_BTN_STATS_DATE	= "Date";
SKMAP_BTN_CREDITS	= "Credits";

SKMAP_BTN_STATS_BG_ZONE = "BG Map";
SKMAP_BTN_STATS_BG_DATE = "BG Date";
SKMAP_BTN_STATS_BG_DATE_ZONE = "BG Date/Map";


SKMAP_CREDITS = {
	"Shim's Kill Map, a.k.a SKMap",
	"",
	"Original idea by Shimroar (that's me !)",
	"",
	"Special thanks to :",
	"",
	"- PIng for french localization and help in development",
	"- All the people, from 'La cage aux trolls' and beyond, that helped",
	"  testing and provided me with precious suggestions",
	"- Goomi of the Unspeakable Vault of Doom, who gracefully allowed",
	"  me to use one of his drawings as the mod mascott",
	"  (visit <http://www.macguff.fr/goomi/unspeakable/home.html>,",
	"  it's worth it !)",
	"- All the World of Warcraft community and talented mod writters",
	"- And, of course, Blizzard, for making such an enjoyable game !",
	"",
	"Shimroar.",
	""

};

SKMAP_WORLDMAP_TITLE = "SKMap";
SKMAP_WORLDMAP_HIDE = "Hide me";

-- Messages patterns.
-- Allowed pattern variables are :
-- %name : unit name (player name, monster name, NPC name)
-- %class : unit class (Rogue, Warlock, ...), or creature class (Elite, Rare, ...)
-- %race : unit race (Undead, Troll, ...)
-- %level : unit level
-- %player : player name

SKM_MESSAGES = {
  -- Report enemy player kill
  Message_PlayerKill = "%date - %name (lvl %level %race %class)";

  -- Report player self death - no known killer
  Message_PlayerDeath = "%date - RIP %player";

  -- Report player self death - PvE
  Message_PlayerDeath_PvE = "%date - %player killed by %name";

  -- Report player self death - PvP
  Message_PlayerDeath_PvP_NoData = "%date - %player killed by %name";
  Message_PlayerDeath_PvP = "%date - %player killed by %name (lvl %level %race %class)";

  -- Report creature kill
  Message_CreatureKill_Basic = "%date - %name";
  Message_CreatureKill_Detail = "%date - %name (lvl %level)";
  Message_CreatureKill_RareDetail = "%date - %name (lvl %level %class)";

  Message_LevelUp = "%date - %name has reached level %level !";

  SubMessage_HonorKill = "|cff4cffff[Honor]";

};

SKM_UNKNOWN_ENTITY = "Unknown Entity";
-- --------------------------------------------------------------------------------------




if (SKM_CurrentLocale == "FR") then
--if ( GetLocale() == "frFR" ) then
-- for test:
--if (true) then

-- --------------------------------------------------------------------------------------
-- FRENCH LOCALIZATION
-- --------------------------------------------------------------------------------------

SKM_PATTERN = {
	-- (Player) versus (Non Player)
	Player_HitDamage = "Vous touchez %s et infligez %d points de d\195\169g\195\162ts";
	Player_HitCritDamage = "Vous touchez %s avec un coup critique et infligez %d points de d\195\169g\195\162ts";
	Player_SpellDamage = "Votre %s touche %s et inflige %d points de d\195\169g\195\162ts";
	Player_SpellCritDamage = "Votre %s touche %s avec un coup critique et inflige %d points de d\195\169g\195\162ts";

	Player_DotDamage = "Votre %s inflige %d points de d\195\169g\195\162t de %s \195\160 %s."; -- must keep trailing dot here to identify target !

	-- (Non Player A) versus (Non Player B)
	Other_HitDamage = "%s touche %s et inflige %d points de d\195\169g\195\162ts";
	Other_HitCritDamage = "%s touche %s avec un coup critique et inflige %d points de d\195\169g\195\162ts";
	Other_SpellDamage = "%s de %s touche %s pour %d points de d\195\169g\195\162ts";
	Other_SpellCritDamage = "%s utilise %s et touche %s avec un coup critique, infligeant %d points de d\195\169g\195\162ts";
	Other_DotDamage = "%s de %s inflige \195\160 %s %d points de d\195\169g\195\162ts de %s";

	-- (Non Player) versus (Player)

	Self_HitDamage = "%s vous touche et inflige %d points de d\195\169g\195\162ts";
	Self_HitCritDamage = "%s vous touche avec un coup critique et inflige %d points de d\195\169g\195\162ts";
	Self_SpellDamage = "%s de %s vous inflige %d points de d\195\169g\195\162ts";
	Self_SpellCritDamage = "%s utilise %s et vous touche avec un coup critique, infligeant %d points de d\195\169g\195\162ts";
	Self_DotDamage = "%s de %s vous inflige %d points de d\195\169g\195\162ts de %s"; -- 0.09.1 Add localization

	-- (Other : totems) versus (Player)
	Self_OtherDamage = "Attaque de %s vous inflige %d points de d\195\169g\195\162ts";


	Other_Death = "%s meurt";


	-- Xp gain messages
	XpGain_Rested_Solo = "%s succombe, vous gagnez %d points d'exp\195\169rience. (+%d exp bonus %s)";	-- 0.09.2 Fix again...
	XpGain_Rested_Group = "%s succombe, vous gagnez %d points d'exp\195\169rience. (+%d exp %d bonus, +%d group bonus)";
	XpGain_Rested_Raid = "%s succombe, vous gagnez %d points d'exp\195\169rience. (+%d exp %d bonus, -%d raid penalty)"; -- CHECK THIS

	XpGain_Solo = "%s meurt, vous gagnez %d points d'exp\195\169rience.";
	XpGain_Group = "%s meurt, vous gagnez %d points d'exp\195\169rience. (+%d groupe bonus)";
	XpGain_Raid = "%s meurt, vous gagnez %d points d'exp\195\169rience. (-%d raid penalty)"; -- CHECK THIS


	-- Honor kill
	--Honor_Kill = "%s meurt, victoire honorable (Grade : %s)"; -- old version
	--Honor_Kill = "%s meurt, victoire honorable. Grade : %s (Points d'honneur estim\195\169s : %d)"; -- new version
	Honor_Kill = COMBATLOG_HONORGAIN;


	-- Duel messages
	Duel_Won = "%s a triomph\195\169 de %s lors d'un duel";
	Duel_Fled = "%s s'enfuit de son duel contre %s";


	-- pattern for totem units names : "Totem" followed by a blank and the totem type.
	-- the blank character insures this is not a player.
	Totem = "Totem %s";
};

-- 0.11.2 Begin of modification Add (again ?) localization
-- Races
SKM_RACE = {
	Dwarf = "Nain";
	Gnome = "Gnome";
	Human = "Humain";
	NightElf = "Elfe de la nuit";

	Orc = "Orc";
	Tauren = "Tauren";
	Troll = "Troll";
	Undead = "Mort-vivant";
};
-- 0.11.2 End of modification

-- Classes
SKM_CLASS = {
	Druid = "Druide";
	Hunter = "Chasseur";
	Mage = "Mage";
	Paladin = "Paladin";
	Priest = "Pr\195\170tre";
	Rogue = "Voleur";
	Shaman = "Chaman";
	Warrior	= "Guerrier";
	Warlock	= "D\195\169moniste";
};

SKM_BATTLEGROUNDS = {
	"Goulet des Warsong",
	"Vall\195\169e d\226\128\153Alterac",
	"Bassin d'Arathi"
};

-- this is the localized zone names but matching the current english zone order
SKM_ZoneText = {
	{	"Ashenvale",	--"Ashenvale",
		"Azshara",	--"Azshara",
		"Sombrivage (Darkshore)",	--"Darkshore",
		"Darnassus",	--"Darnassus",
		"D\195\169solace",	--"Desolace",
		"Durotar",	--"Durotar",
		"Mar\195\169cage d'\195\130prefange (Dustwallow Marsh)",	--"Dustwallow Marsh",
		"Gangrebois (Felwood)",	--"Felwood",
		"Feralas",	--"Feralas",
		"Reflet-de-Lune (Moonglade)",	--"Moonglade",
		"Mulgore",	--"Mulgore",
		"Orgrimmar",	--"Orgrimmar",
		"Silithus",	--"Silithus",
		"Les Serres-Rocheuses (Stonetalon Mts)",	--"Stonetalon Mountains",
		"Tanaris",	--"Tanaris",
		"Teldrassil",	--"Teldrassil",
		"Les Tarides (the Barrens)",	--"The Barrens",
		"Mille pointes (Thousand Needles)",	--"Thousand Needles",
		"Thunder Bluff",	--"Thunder Bluff",
		"Crat\195\168re d'Un'Goro",	--"Un'Goro Crater",
		"Berceau-de-l'Hiver (Winterspring)",	--"Winterspring",
	},
	{	"Montagnes d'Alterac",	--"Alterac Mountains",
		"Hautes-terres d'Arathi",	--"Arathi Highlands",
		"Terres ingrates (Badlands)",	--"Badlands",
		"Terres foudroy\195\169es (Blasted Lands)",	--"Blasted Lands",
		"Steppes ardentes",	--"Burning Steppes",
		"D\195\169fil\195\169 de Deuillevent (Deadwind Pass)",	--"Deadwind Pass",
		"Dun Morogh",	--"Dun Morogh",
		"Bois de la p\195\169nombre (Duskwood)",	--"Duskwood",
		"Maleterres de l'est (Eastern Plaguelands)",	--"Eastern Plaguelands",
		"For\195\170t d'Elwynn",	--"Elwynn Forest",
		"Contreforts d'Hillsbrad",	--"Hillsbrad Foothills",
		"Ironforge",	--"Ironforge",
		"Loch Modan",	--"Loch Modan",
		"Les Carmines (Redridge Mts)",	--"Redridge Mountains",
		"Gorge des Vents br\195\187lants (Searing Gorge)",	--"Searing Gorge",
		"For\195\170t des Pins argent\195\169s (Silverpine Forest)",	--"Silverpine Forest",
		"Cit\195\169 de Stormwind",	--"Stormwind City",
		"Vall\195\169e de Strangleronce (Stranglethorn Vale)",	--"Stranglethorn Vale",
		"Marais des Chagrins (Swamp of Sorrows)",	--"Swamp of Sorrows",
		"Les Hinterlands",	--"The Hinterlands",
		"Clairi\195\168res de Tirisfal",	--"Tirisfal Glades",
		"Undercity",	--"Undercity",
		"Maleterres de l'ouest (Western Plaguelands)",	--"Western Plaguelands",
		"Marche de l'Ouest (Westfall)",	--"Westfall",
		"Les Paluns (Wetlands)",	--"Wetlands",
	}
};


--SKM_ZoneShift = SKM_ShiftTables[SKM_CurrentShift.Source][SKM_CurrentShift.Dest];



-- UI Strings
SKM_UI_STRINGS = {

	-- PvP Target Info Frame
	Map_Window_Title = "Donn\195\169es SKMap";
	Small_Target_Info_Kill = "Vic. : ";
	Small_Target_Info_Death = "D\195\169f. : ";
	Small_Target_Info_Met = "Vu : ";
	War_Floating_Message = "En GUERRE avec ";
	Small_Target_War = "Guerre";
	Since = " depuis ";
	Small_Target_Honor = "Honor : ";
	Small_Target_NoHonor = "Aucun";

	--0.08.1 French translation

	-- Minimap button
	MinimapButton_Tooltip = "Ouvrir/Fermer l'interface SKMap";


	-- Options Tab
	Options_Label_General = "Configuration g\195\169n\195\169rale";
	Options_Label_Map = "Configuration world map";
	Options_Label_War = "Configuration mode WAR";
	Options_Label_Record = "Configuration enregistrements";
	Options_Label_Minimap = "Configuration minimap";
	Options_Label_Cleanup = "Configuration nettoyage";

	-- Options Tab
	Options_Check_ShowTargetInfo = "Activer la fen\195\170tre d'info JcJ";
	Options_Tooltip_ShowTargetInfo = "Affiche les informations JcJ de votre cible courante";

	Options_Button_SmallTargetInfo = "Fen\195\170tre d'info JcJ r\195\169duite";
	Options_Tooltip_SmallTargetInfo = "Active la version compacte de la fen\195\170tre d'information JcJ";

	Options_Button_WarSoundWarning = "Avertiss. sonore cibles En Guerre";
	Options_Tooltip_WarSoundWarning = "Jouer un son lorsque le curseur de la souris passe sur un ennemi avec lequel vous \195\170tes en guerre";


	Options_Button_WarFloatingMessage = "Afficher un message flottant cibles En Guerre";
	Options_Tooltip_WarFloatingMessage = "Affiche un message au centre de l'\195\169cran lorsque le curseur de la souris passe sur un ennemi avec lequel vous \195\170tes en guerre";

	Options_Button_WarAutoTarget = "Ciblage auto des joueurs En Guerre";
	Options_Tooltip_WarAutoTarget = "Cible automatiquement un joueur lorsque vous \195\170tes En Guerre avec lui et que le curseur de la souris passe sur lui";

	Options_Button_RecordPlayerKill = "Enregistrer les victoires en JcJ";
	Options_Tooltip_RecordPlayerKill = "Enregistre vos victoires en JcJ";

	Options_Button_RecordCreatureKill = "Enregistrer les victoires en JcE";
	Options_Tooltip_RecordCreatureKill = "Enregistre vos victoires en JcE";

	Options_Button_RecordPlayerDeath = "Enregistrer vos morts en JcJ";
	Options_Tooltip_RecordPlayerDeath = "Enregistre vos passages \195\160 tr\195\169pas en JcJ";

	Options_Button_DisplayKillRecord = "Afficher enreg. victoire JcJ";
	Options_Tooltip_DisplayKillRecord = "Affiche dans la fen\195\170tre du canal g\195\169n\195\169ral un court message signalant l'enregistrement d'une victoire JcJ";

	Options_Button_DisplayCreatureKillRecord = "Afficher enreg. victoire JcE";
	Options_Tooltip_DisplayCreatureKillRecord = "Affiche dans la fen\195\170tre du canal g\195\169n\195\169ral un court message signalant l'enregistrement d'une victoire JcE";


	Options_Button_DisplayDeathRecord = "Afficher enreg. de votre mort";
	Options_Tooltip_DisplayDeathRecord = "Affiche dans la fen\195\170tre du canal g\195\169n\195\169ral un court message signalant l'enregistrement de votre mort";

	Options_Button_MapDisplayRecords = "Afficher les \195\169v\195\169nements sur la carte";
	Options_Tooltip_MapDisplayRecords = "Affiche graphiquement sur la carte les diff\195\169rents \195\169v\195\169nements enregistr\195\169s";

	Options_Slider_CreatureKillRecordsByZone = "Nombre maximum de victoires JcE enregistr\195\169es par zone";
	Options_Tooltip_CreatureKillRecordsByZone = "Nombre maximum de victoires JcE enregistr\195\169es par zone";

	Options_Button_IgnoreLowerEnemies = "Ignorer adversaires de bas niveau";
	Options_Tooltip_IgnoreLowerEnemies = "D\195\169sactive l'enregistrement d'information sur les ennemis de bas niveau";

	Options_Slider_IgnoreLevelThreshold = "Seuil de niveau en %";
	Options_Tooltip_IgnoreLevelThreshold = "D\195\169finit le niveau des adversaires ignor\195\169s en % par rapport \195\160 votre niveau";

	Options_Button_ShowTargetGuildInfo = "Afficher la guilde ennemie";
	Options_Tooltip_ShowTargetGuildInfo = "Affiche la guilde \195\160 laquelle appartient le joueur ennemi cibl\195\169";

	Options_Button_ShowTargetClassInfo = "Afficher la classe d'un ennemi";
	Options_Tooltip_ShowTargetClassInfo = "Affiche la classe du joueur ennemi cibl\195\169";

	Options_Button_ShowWorldMapControl = "Afficher fen\195\170tre de contr\195\180le monde";
	Options_Tooltip_ShowWorldMapControl = "Affiche une mini fen\195\170tre sur la carte du monde permettant d'afficher ou de cacher les enregistrements";

	Options_Button_ShowMinimapButton = "Afficher le bouton minimap";
	Options_Tooltip_ShowMinimapButton = "Afficher ou inhiber le bouton minimap de l'interface";

	Options_Slider_MinimapButtonPosition = "Position du bouton minimap";
	Options_Tooltip_MinimapButtonPosition = "Position relative du bouton minimap de l'interface";

	Options_Slider_MinimapButtonOffset = "Offset du bouton minimap";
	Options_Tooltip_MinimapButtonOffset = "D\195\169calage du bouton minimap de l'interface";

	Options_Button_IgnoreNoPvPFlag = "Ignorer les adversaires non PvP";
	Options_Tooltip_IgnoreNoPvPFlag = "D\195\169sactive l'enregistrement d'information sur les ennemis sans flag PvP";

	Options_Button_StoreEnemyPlayers = "Enregistrer joueurs ennemis";
	Options_Tooltip_StoreEnemyPlayers = "Stocke les informations des joueurs ennemis lorsque vous les rencontrez. ATTENTION : d\195\169sactiver cette option emp\195\170chera de d\195\169terminer les victoires et d\195\169faites JcJ";

	Options_Button_StoreDuels = "Enregister les duels";
	Options_Tooltip_StoreDuels = "Enregistre vos duels";

	Options_Button_LockedTargetInfo = "Verrouiller fen\195\170tre d'info JcJ";
	Options_Tooltip_LockedTargetInfo = "Emp\195\170che de d\195\169placer la fen\195\170tre d'information JcJ";

	Options_Button_TooltipTargetInfo = "Ajouter info JcJ \195\160 l'infobulle";
	Options_Tooltip_TooltipTargetInfo = "Ajouter les informations d'un joueur ennemi \195\160 l'infobulle";

	Options_Button_WarEnableFilter = "D\195\169lai de filtre En guerre";
	Options_Tooltip_WarEnableFilter = "Filtrer les avertissements En guerre si le d\195\169lai minimum n'est pas \195\169coul\195\169";

	Options_Slider_WarFilterDelay = "D\195\169lai de filtre En guerre";
	Options_Tooltip_WarFilterDelay = "D\195\169lai minimum (en secondes) entre deux avertissements En guerre";

	Options_Button_WarChatMessage = "Afficher un message de chat cibles En Guerre";
	Options_Tooltip_WarChatMessage = "Affiche un message dans la fen\195\170tre de chat lorsque le curseur de la souris passe sur un ennemi avec lequel vous \195\170tes en guerre";

	Options_Button_WarShowNote = "Voir note associ\195\169e";
	Options_Tooltip_WarShowNote = "Ajoute \195\160 la fen\195\170tre de chat la note associ\195\169e \195\160 cet ennemi (si elle existe)";

	Options_Button_DataCleanUp = "Activer nettoyage automatique des donn\195\169es";
	Options_Tooltip_DataCleanUp = "Nettoyer automatiquement les donn\195\169es superflues \195\160 intervalles r\195\169guliers";

	Options_Slider_DataCleanUpInterval = "Intervalle de nettoyage automatique des donn\195\169es";
	Options_Tooltip_DataCleanUpInterval = "Intervalle de nettoyage automatique des donn\195\169es (en jours)";

	Options_Button_CleanInactiveEnemies = "Effacer anciens ennemis inactifs";

	Options_Tooltip_CleanInactiveEnemies = "Effacer les anciens ennemis inactifs, i.e. ennemis non En guerre et pour lesquels vous n'avez aucun enregistrement JcJ";

	Options_Slider_CleanInactiveEnemiesDelay = "D\195\169lai de suppression des anciens ennemis inactifs";
	Options_Tooltip_CleanInactiveEnemiesDelay = "D\195\169lai de suppression des anciens ennemis inactifs (en jours)";

	Options_Button_SharedWarMode = "Mode En guerre partag\195\169";
	Options_Tooltip_SharedWarMode = "G\195\169n\195\168re les avertissements En guerre si au moins un de vos personnages est en guerre avec un ennemi donn\195\169 (m\195\170me si le personnage courant ne l'est pas)";

	Options_Button_TooltipPlayerNote = "Ajouter note personnelle \195\160 l'infobulle";
	Options_Tooltip_TooltipPlayerNote = "Ajouter la note associ\195\169e \195\160 un joueur ennemi \195\160 l'infobulle";

	Options_Button_EnemyListAutoUpdate = "Mise \195\160 jour automatique liste ennemis";
	Options_Tooltip_EnemyListAutoUpdate = "Mise \195\160 jour automatique de la liste des ennemis \195\160 chaque fois que l'onglet correspondant est ouvert";

	Options_Slider_EnemyListAutoUpdateDelay = "D\195\169lai de mise \195\160 jour auto liste ennemis";
	Options_Tooltip_EnemyListAutoUpdateDelay = "D\195\169lai minimum entre deux mises \195\160 jour auto de la liste des ennemis (en secondes)";

	Options_Button_CleanEmptyGuilds = "Effacer guildes fant\195\180me";
	Options_Tooltip_CleanEmptyGuilds = "Effacer les guildes n'ayant plus aucun joueur connu";

	Options_Button_RecordPlayerDeathNonPvP = "Enregistrer vos morts hors JcJ";
	Options_Tooltip_RecordPlayerDeathNonPvP = "Enregistre vos passages \195\160 tr\195\169pas non provoqu\195\169s par un joueur ennemi";

	Options_Button_ReportPlayerDeath = "Afficher un rapport de vos morts";
	Options_Tooltip_ReportPlayerDeath = "Permet d'afficher, lorsque vous mourez, un rapport sur les ennemis responsables de votre mort";


	-- List Frame Detail labels
	-- 0.08.2 Begin of modification: Add localization for list frame
	List_Frame_Player = "Joueur :  ";
	List_Frame_Guild = "Guilde :  ";
	List_Frame_Level = "Niveau ";
	List_Frame_Last_Seen = "Derni\195\168re renc. :  ";
	List_Frame_Last_Updated = "Derni\195\168re MaJ :  ";
	List_Frame_Met = "Vu :  ";
	List_Frame_Death = "D\195\169f. :  ";
	List_Frame_Kill = "Vic. :  ";
	List_Frame_Full = "Compl\195\168te :  ";
	List_Frame_Standard = "Standard :  ";
	List_Frame_Assist = "Assist. :  ";
	List_Frame_Note = "Note :  ";
	List_Frame_Guild_Member = "Membres rencontr\195\169s :  ";
	List_Frame_LoneWolf = "Vic. Solo :  ";
	-- 0.08.2 End of modification: Add localization for list frame
	List_Frame_HonorKill = "Vic. Honor. :  ";
	List_Frame_RemainHonor = "Reste aujourd'hui :  ";
	List_Frame_BGKill = "Vic. BG :  ";
	List_Frame_BGDeath = "D\195\169f. BG :  ";

	List_Frame_Last_Duel = "Dernier duel :  ";
	List_Frame_Duel = "Duels :  ";
	List_Frame_Win = "Victoires :  ";
	List_Frame_Loss = "D\195\169faites :  ";
	List_Frame_Score = "Score :  ";

	-- 0.11.1 Begin of modifications: Add localization
	List_Button_FilterNoWar = "Afficher ennemis 'En guerre' uniquement";
	List_Tooltip_FilterNoWar = "Permet de filtrer la liste des ennemis ou guildes et d'afficher uniquement ceux dont le status est 'En guerre'";

	List_ConfirmDeletePlayer = "%sVous allez effacer %s%s%s et *tous* les enregistrements associ\195\169s (victoire et d\195\169faite). Confirmez-vous ?";

	Duel_ConfirmDeletePlayer = "%sVous allez effacer %s%s%s et *toutes* les donn\195\169es de duel associ\195\169es. Confirmez-vous ?";


	List_EditNote_Title = "Editer Note";
	List_EditPlayerNote_Prompt = "%sTapez la note pour le joueur  %s%s%s  :";
	List_EditGuildNote_Prompt = "%sTapez la note pour la guilde <%s%s%s>  :";
	-- 0.11.1 End of modifications

	-- Book frame
	Book_Page = "Page";



	-- 0.11.1 Begin of modifications: Add localization
	Book_GeneralStat_Header = "Statistiques JcJ g\195\169n\195\169rales";
	Book_ClassStat_Header = "Statistiques JcJ par classe";
	Book_RaceStat_Header = "Statistiques JcJ par race";
	Book_EnemyStat_Header = "Statistiques JcJ par joueur";
	Book_GuildStat_Header = "Statistiques JcJ par guilde";
	Book_ZoneStat_Header = "Statistiques JcJ par zone";
	Book_DateStat_Header = "Statistiques JcJ par date";
	Book_BGDateStat_Header = "Statistiques Battleground par date";
	Book_BGZoneStat_Header = "Statistiques Battleground par zone";
	Book_BGDateZoneStat_Header = "Statistiques Battleground par date/zone";

	Book_TotalKill = "Total de victoires en JcJ";
	Book_TotalDeath = "Total de d\195\169faites en JcJ";
	Book_TotalRatio = "Ratio Victoire/Total";
	Book_AverageKillLevel = "Niveau moyen des victimes";
	Book_AverageDeathLevel = "Niveau moyen des bourreaux";

	Book_EnemyPlayers = "Joueurs ennemis connus";
	Book_EnemyGuilds = "Guildes ennemies connues";
	Book_MapRecords = "Total enreg. carte";

	Book_Label_Class = "Classe";
	Book_Label_Race = "Race";
	Book_Label_Enemy = "Ennemi";
	Book_Label_Guild = "Guilde";
	Book_Label_Zone = "Zone";
	Book_Label_Date = "Date";
	Book_Label_Kill = "Victoire";
	Book_Label_Death = "D\195\169faite";
	Book_Label_Ratio = "Ratio";
	Book_Label_DateZone = "Date/Zone";

	Book_NoData = "Pas de donn\195\169e disponible";

	Book_Format_AssistKill = "Vous avez tu\195\169 %s (Victoire assist)";
	Book_Format_Kill = "Vous avez tu\195\169 %s (Victoire standard)";
	Book_Format_FullKill = "Vous avez tu\195\169 %s (Victoire totale)";
	Book_Format_Death = "%s vous a tu\195\169(e).";
	-- 0.11.1 End of modifications
	Book_Format_LoneWolfKill = "Vous avez tu\195\169 %s (Victoire solo)";

	Report_Button_UseAssist = "Compter vic. assist.";
	Report_Tooltip_UseAssist = "Comptabiliser les victoires 'assist' pour les statistiques";



	-- World map control frame
	WorldMap_Button_ShowRecords = "Voir enreg.";


	-- Messages optionaly displayed in chat window when recording events
	RecordMessage_PlayerPvPDeath = "Mort (tu\195\169 par %s) enregistr\195\169e";
	RecordMessage_PlayerPvEDeath = "Mort (tu\195\169 par %s) enregistr\195\169e";
	RecordMessage_PlayerDeath = "Mort enregistr\195\169e";

	RecordMessage_AssistKill = "%s <- Victoire Assist. enregistr\195\169e";
	RecordMessage_Kill = "%s <- Victoire enregistr\195\169e";
	RecordMessage_FullKill = "%s <- Victoire totale enregistr\195\169e";

	RecordMessage_CreatureKill = "%s <- Victoire enregistr\195\169e";

	ReportMessage_PlayerDeath = "Mort - liste des coupables (top %d)";

};

-- note : the following UI strings can't be in a table because they are directly substituted from
-- values in xml file.

-- tab labels
SKMAP_TAB_LIST 		= "JcJ";
SKMAP_TAB_DUEL = "Duels";
SKMAP_TAB_REPORT	= "Hall of Fame"; -- 0.09.1 Localization
SKMAP_TAB_OPTIONS 	= "Options";

-- lists column headers
SKMAP_COLUMN_NAME 	= "Nom";	-- player + guild
SKMAP_COLUMN_GUILD 	= "Guilde";	-- player
SKMAP_COLUMN_RACE 	= "Race";	-- player
SKMAP_COLUMN_CLASS 	= "Classe";	-- player
SKMAP_COLUMN_LEVEL 	= "Niv.";	-- player
SKMAP_COLUMN_KILL 	= "Vic.";	-- player + guild
SKMAP_COLUMN_DEATH 	= "D\195\169f.";	-- player + guild
SKMAP_COLUMN_MET 	= "Vu";	-- player + guild
SKMAP_COLUMN_LASTSEEN 	= "Derni\195\168re rencontre";	-- player + guild
SKMAP_COLUMN_ATWAR 	= "Guerre ?";	-- player + guild

SKMAP_COLUMN_MEMBERS	= "Membres";	-- guild
-- 0.08.1 Begin of modification: add localization ofr ATWar status
SKMAP_COLUMN_ATWAR_ALL = "Totale";
SKMAP_COLUMN_ATWAR_PLAYER = "Joueur";
SKMAP_COLUMN_ATWAR_GUILD = "Guilde";
-- 0.08.1 End of modification: add localization of AT War status

SKMAP_COLUMN_WIN = "Vic.";
SKMAP_COLUMN_LOSS = "D\195\169f.";
SKMAP_COLUMN_DUELS = "Duels";
SKMAP_COLUMN_LASTDUEL = "Dernier duel";
SKMAP_COLUMN_SCORE = "Score";


-- "list toggle" button
SKMAP_GUILDS		= "Guildes";
SKMAP_PLAYERS		= "Joueurs";

-- "show guild" button
SKMAP_SHOWGUILD		= "Voir Guilde";

-- "back" button
SKMAP_BACK		= "Retour";

-- "edit note" button
SKMAP_EDITNOTE		= "Editer Note";

-- 0.08.1 End of modification

-- 0.11.1 Begin of modifications: Add localisation

-- "report" button
SKMAP_REPORT		= "Rapport";

-- "delete" button
SKMAP_DELETE		= "Effacer";

-- "clear" button
SKMAP_CLEAR		= "Effacer";
-- 0.11.1 End of modifications

SKMAP_RESETSORT = "Tri d\195\169faut";

SKMAP_UPDATELIST = "Actualiser";


SKM_BTN_EXPAND_ALL = "D\195\169tailler tout";
SKM_BTN_COLLAPSE_ALL = "R\195\169duire tout";


-- 0.09.1 Begin of modification

-- previous and next labels for book browsing buttons
SKMAP_PREV		= "Pr\195\169c.";
SKMAP_NEXT		= "Suiv.";

SKMAP_BTN_STATS_GENERAL	= "G\195\169n\195\169ral";
SKMAP_BTN_STATS_CLASS	= "Classe";
SKMAP_BTN_STATS_RACE	= "Race";
SKMAP_BTN_STATS_ENEMIES	= "Ennemis";
SKMAP_BTN_STATS_GUILDS	= "Guildes";
SKMAP_BTN_STATS_ZONE	= "Carte";
SKMAP_BTN_STATS_DATE	= "Date";

SKMAP_BTN_CREDITS	= "Cr\195\169dits";

SKMAP_BTN_STATS_BG_ZONE = "BG Carte";
SKMAP_BTN_STATS_BG_DATE = "BG Date";
SKMAP_BTN_STATS_BG_DATE_ZONE = "BG Date/Carte";


-- don't translate this !
--SKMAP_CREDITS = {
--};

-- 0.09.1 End of modification

SKMAP_WORLDMAP_TITLE = "SKMap";
SKMAP_WORLDMAP_HIDE = "Cacher";

  -- Messages patterns.
  -- Allowed pattern variables are :
  -- %name : unit name (player name, monster name, NPC name)
  -- %class : unit class (Rogue, Warlock, ...)
  -- %race : unit race (Undead, Troll, ...)
  -- %level : unit level
  -- %player : player name

SKM_MESSAGES = {
  -- Report enemy player kill
  Message_PlayerKill = "%date - %name (Niveau %level %race %class)";

  -- Report player self death - no known killer
  Message_PlayerDeath = "%date - RIP %player";

  -- Report player self death - PvE
  Message_PlayerDeath_PvE = "%date - %player tu\195\169(e) par %name";

  -- Report player self death - PvP
  Message_PlayerDeath_PvP_NoData = "%date - %player tu\195\169(e) par %name";
  Message_PlayerDeath_PvP = "%date - %player tu\195\169(e) par %name (Niveau %level %race %class)";

  -- Report creature kill
  Message_CreatureKill_Basic = "%date - %name";
  Message_CreatureKill_Detail = "%date - %name (lvl %level)";
  Message_CreatureKill_RareDetail = "%date - %name (lvl %level %class)";

  Message_LevelUp = "%date - %name a atteint le niveau %level !";

  SubMessage_HonorKill = "|cff4cffff[Honor]";

};

SKM_UNKNOWN_ENTITY = "Entit\195\169 inconnue";
-- --------------------------------------------------------------------------------------




elseif (SKM_CurrentLocale == "DE") then
--elseif ( GetLocale() == "deDE" ) then
-- for test:
--elseif (true) then

-- --------------------------------------------------------------------------------------
-- DEUTSCH LOCALIZATION (by Tenvan, Maischter and Bisaz. Thanks a lot !)
-- --------------------------------------------------------------------------------------

SKM_PATTERN = {

--	-- (Player) versus (Non Player)
--	Player_HitDamage = "Ihr trefft %s. Schaden: %d.";
--	Player_HitCritDamage = "Ihr trefft %s kritisch f\195\188r %d Schaden.";
--	--Player_SpellDamage = "%s von Euch trifft %s f\195\188r %d Schaden.";
--	Player_SpellDamage = "%s von Euch trifft %s fuer %d Schaden."; -- To confirm
--	Player_SpellCritDamage = "Eu. %s trifft %s kritisch. Schaden: %d.";
--	Player_DotDamage = "%s erleidet %d %sschaden (durch %s).";
--
--	-- (Non Player A) versus (Non Player B)
--	Other_HitDamage = "%s trifft %s. f\195\188r %d Schaden.";
--	Other_HitCritDamage = "%s trifft %s kritisch f\195\188r %d Schaden.";
--	Other_SpellDamage = "%ss %s trifft %s f\195\188r %d Schaden.";
--	Other_SpellCritDamage = "%ss %s trifft %s kritisch fuer %d Schaden.";
--	Other_DotDamage = "%s erleidet %d %sschaden von %s (durch %s).";
--
--	-- (Non Player) versus (Player)
--	Self_HitDamage = "%s trifft Euch f\195\188r %d Schaden.";
--	Self_HitCritDamage = "%s trifft Euch kritisch. Schaden: %d.";
--	Self_SpellDamage = "%s trifft Euch (mit %s). Schaden: %d.";
--	Self_SpellCritDamage = "%s trifft Euch kritisch (mit %s). Schaden: %d.";
--	Self_DotDamage = "Ihr erleidet %d %sschaden von %s (durch %s).";


	--
	-- fixed patterns provided by Maischter, 2005.10.03
	--

	-- (Player) versus (Non Player)
	Player_HitDamage = "Ihr trefft %s. Schaden: %d.";
	Player_HitCritDamage = "Ihr trefft %s kritisch f\195\188r %d Schaden.";
	Player_SpellDamage = "Euer %s trifft %s kritisch. Schaden: %d %s.";
	Player_SpellCritDamage = "Euer %s trifft %s kritisch. Schaden: %d %s.";
	Player_DotDamage = "%s erleidet %d %sschaden (durch %s).";

	-- (Non Player A) versus (Non Player B)
	Other_HitDamage = "%s trifft %s f\195\188r %d Schaden.";
	Other_HitCritDamage = "%s trifft %s kritisch f\195\188r %d Schaden.";
	Other_SpellDamage = "%ss %s trifft %s f\195\188r %d %s Schaden.";
	Other_SpellCritDamage = "%ss %s trifft %s kritisch f\195\188r %d %s Schaden.";
	Other_DotDamage = "%s erleidet %d %sschaden von %s (durch %s).";

	-- (Non Player) versus (Player)
	Self_HitDamage = "%s trifft Euch f\195\188r %d Schaden.";
	Self_HitCritDamage = "%s trifft Euch kritisch. Schaden: %d.";
	Self_SpellDamage = "%ss %s trifft Euch f\195\188r %d %s Schaden.";
	Self_SpellCritDamage = "%ss %s trifft Euch kritisch f\195\188r %d %s Schaden.";
	Self_DotDamage = "Ihr erleidet %d %sschaden von %s (durch %s).";



	Other_Death = UNITDIESOTHER;



	-- Xp gain messages
	XpGain_Rested_Solo = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus)";
	XpGain_Rested_Group = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus, +%d Gruppen-Bonus)";
	XpGain_Rested_Raid = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Abzug, -%d \195\156berfall-Abzug)";

	XpGain_Solo = "%s stirbt, Ihr bekommt %d Erfahrung.";
	XpGain_Group = "%s stirbt, Ihr bekommt %d Erfahrung. (+%d Gruppen-Bonus)";
	XpGain_Raid = "%s stirbt, Ihr bekommt %d Erfahrung. (-%d \195\156berfall-Abzug)";


	-- Honor kill
	--Honor_Kill = "%s stirbt, ehrenvoller kill.(Rang: %s)"; -- old version
	Honor_Kill = COMBATLOG_HONORGAIN;


	-- Duel messages
	Duel_Won = "%s hat %s in einem Duell besiegt.";
	Duel_Fled = "%s ist vor %s aus einem Duell gefl\195\188chtet.";


	-- pattern for totem units names : type followed by a blank and "Totem".
	-- the blank character insures this is not a player.
	Totem = "%s Totem";

};

-- Races
SKM_RACE = {
	Dwarf = "Zwerg";
	Gnome = "Gnom";
	Human = "Mensch";
	NightElf = "Nachtelf";

	Orc = "Orc";
	Tauren = "Tauren";
	Troll = "Troll";
	Undead = "Untoter";
};

-- Classes
SKM_CLASS = {
	Druid = "Druide";
	Hunter = "J\195\164ger";
	Mage = "Magier";
	Paladin = "Paladin";
	Priest = "Priester";
	Rogue = "Schurke";
	Shaman = "Schamane";
	Warrior = "Krieger";
	Warlock = "Hexenmeister";
};

SKM_BATTLEGROUNDS = {
	"Warsongschlucht",
	"Alteractal",
	"Arathibecken"
};

-- this is the localized zone names but matching the current english zone order
SKM_ZoneText = {
	{	"Ashenvale",	--"Ashenvale",
		"Azshara",	--"Azshara",
		"Darkshore",	--"Darkshore",
		"Darnassus",	--"Darnassus",
		"Desolace",	--"Desolace",
		"Durotar",	--"Durotar",
		"Die Marschen von Dustwallow",	--"Dustwallow Marsh",
		"Felwood",	--"Felwood",
		"Feralas",	--"Feralas",
		"Moonglade",	--"Moonglade",
		"Mulgore",	--"Mulgore",
		"Orgrimmar",	--"Orgrimmar",
		"Silithus",	--"Silithus",
		"Das Steinkrallengebirge",	--"Stonetalon Mountains",
		"Tanaris",	--"Tanaris",
		"Teldrassil",	--"Teldrassil",
		"Das Brachland",	--"The Barrens",
		"Thousand Needles",	--"Thousand Needles",
		"Thunder Bluff",	--"Thunder Bluff",
		"Der Un'Goro Krater",	--"Un'Goro Crater",
		"Wintersprings",	--"Winterspring",
	},
	{	"Das Alteracgebirge",	--"Alterac Mountains",
		"Das Arathi Hochland",	--"Arathi Highlands",
		"Das \195\150dland",	--"Badlands",
		"Die verw\195\188steten Lande",	--"Blasted Lands",
		"Die brennende Steppe",	--"Burning Steppes",
		"Der Gebirgspass der Totenwinde",	--"Deadwind Pass",
		"Dun Morogh",	--"Dun Morogh",
		"Duskwood",	--"Duskwood",
		"Die \195\182stlichen Pestl\195\164nder",	--"Eastern Plaguelands",
		"Der Wald von Elwynn",	--"Elwynn Forest",
		"Die Vorgebirge von Hillsbrad",	--"Hillsbrad Foothills",
		"Ironforge",	--"Ironforge",
		"Loch Modan",	--"Loch Modan",
		"Das Redridgegebirge",	--"Redridge Mountains",
		"Die Sengende Schlucht",	--"Searing Gorge",
		"Der Silberwald",	--"Silverpine Forest",
		"Stormwind",	--"Stormwind City",
		"Stranglethorn",	--"Stranglethorn Vale",
		"Die S\195\188mpfe des Elends",	--"Swamp of Sorrows",
		"Das Hinterland",	--"The Hinterlands",
		"Tirisfal",	--"Tirisfal Glades",
		"Undercity",	--"Undercity",
		"Die westlichen Pestl\195\164nder",	--"Western Plaguelands",
		"Westfall",	--"Westfall",
		"Das Sumpfland",	--"Wetlands",
	}
};

--SKM_ZoneShift = SKM_ShiftTables[SKM_CurrentShift.Source][SKM_CurrentShift.Dest];



-- UI Strings
SKM_UI_STRINGS = {

	-- PvP Target Info Frame
	Map_Window_Title = "SKMap Records";
	Small_Target_Info_Kill = "Kills : ";
	Small_Target_Info_Death = "Tode : ";
	Small_Target_Info_Met = "Beg. : ";
	War_Floating_Message = "Im Krieg mit ";
	Small_Target_War = "Krieg";
	Since = " seit ";
	Small_Target_Honor = "Ehre : ";
	Small_Target_NoHonor = "Nichts";

	-- Minimap button
	MinimapButton_Tooltip = "SKMap Interface-Schalter";


	-- Options Tab
	Options_Label_General = "Generelle Einstellungen";
	Options_Label_Map = "Karten Einstellungen";
	Options_Label_War = "Kriegs-Einstellungen";
	Options_Label_Record = "Aufnahme-Einstellungen";
	Options_Label_Minimap = "Minimap Einstellungen";
	Options_Label_Cleanup = "Clean-up Konfiguration";

	Options_Check_ShowTargetInfo = "PvP-Ziel Infofenster aktivieren";
	Options_Tooltip_ShowTargetInfo = "Zeigt PvP Informationen \195\188ber euer Ziel";

	Options_Button_SmallTargetInfo = "Komprimiertes Ziel-Infofenster";
	Options_Tooltip_SmallTargetInfo = "Kompakt Version des Ziel-Infofensters";

	Options_Button_WarSoundWarning = "Krieg Mouse-over Soundwarnung";
	Options_Tooltip_WarSoundWarning = "Spielt einen Sound ab, wenn man im Krieg die Maus \195\188ber einen Feind bewegt";

	Options_Button_WarFloatingMessage = "Krieg Mouse-over Warnungsnachricht";
	Options_Tooltip_WarFloatingMessage = "Zeigt eine Warnungsnachricht, wenn man im Krieg die Maus \195\188ber einen Feind bewegt";

	Options_Button_WarAutoTarget = "Krieg Mouse-over automatische Zielwahl";
	Options_Tooltip_WarAutoTarget = "Automatische Zielwahl, auf ein mit euch im Krieg befindlichen Feind, welches ihr beim Mouse-over gesehen habt(solange ihr kein anderes Ziel habt)";

	Options_Button_RecordPlayerKill = "Aufzeichnung der get\195\182teten feindlichen Mitspieler";
	Options_Tooltip_RecordPlayerKill = "Zeichnet auf wieviele feindliche Mitspieler ihr get\195\182tet habt";

	Options_Button_RecordCreatureKill = "Aufzeichnung der Kreaturt\195\182tungen";
	Options_Tooltip_RecordCreatureKill = "Zeichnet auf wieviel Kreaturen (die wichtigsten) ihr get\195\182tet habt";

	Options_Button_RecordPlayerDeath = "PvP Tode speichern";
	Options_Tooltip_RecordPlayerDeath = "Speichert die Tode, die durch feindliche Spieler verursacht wurden";

	Options_Button_DisplayKillRecord = "Anzeigen der get\195\182teten Mitspieler Aufzeichnungen";
	Options_Tooltip_DisplayKillRecord = "Anzeige einer Nachricht wenn eine Mitspielert\195\182tung aufgezeichnet wurde";

	Options_Button_DisplayCreatureKillRecord = "Anzeigen der get\195\182teten Kreatur Aufzeichnungen";
	Options_Tooltip_DisplayCreatureKillRecord = "Anzeige einer Nachricht wenn eine Kreaturt\195\182tung aufgezeichnet wurde";

	Options_Button_DisplayDeathRecord = "Anz. der Spielertode Aufzeichnung";
	Options_Tooltip_DisplayDeathRecord = "Anzeige einer Aufzeichnungsnachricht wenn eine sie gestorben sind";

	Options_Button_MapDisplayRecords = "Daten auf der Weltkarte anzeigen";
	Options_Tooltip_MapDisplayRecords = "Grafische Anzeige der Aufzeichnungsdaten auf der Weltkarte";

	Options_Slider_CreatureKillRecordsByZone = "Max. Kreaturt\195\182tungen";
	Options_Tooltip_CreatureKillRecordsByZone = "Maximale Anzahl der Kreaturt\195\182tungen nach Zonen";

	Options_Button_IgnoreLowerEnemies = "Ignoriere inaktive Low-Level Feinde";
	Options_Tooltip_IgnoreLowerEnemies = "Deaktiviert die Aufzeichnung von inaktive Low-Level Feinden";

	Options_Slider_IgnoreLevelThreshold = "Ignoranz Schwelle";
	Options_Tooltip_IgnoreLevelThreshold = "Ignoriere inaktive Feinde die niedrieger als % eures Levels sind";

	Options_Button_ShowTargetGuildInfo = "Zeige feindliche Spielergilde";
	Options_Tooltip_ShowTargetGuildInfo = "Anzeige der Gilde des derzeitigen Ziels, sofern eines angew\195\164hlt ist";

	Options_Button_ShowTargetClassInfo = "Zeige feindliche Spielerklasse";
	Options_Tooltip_ShowTargetClassInfo = "Anzeige der Klasse des derzeitigen Ziels, sofern eines angew\195\164hlt ist ";

	Options_Button_ShowWorldMapControl = "Zeige ein weltkarten Kontrollfenster";
	Options_Tooltip_ShowWorldMapControl = "Zeigt ein Kleines Fenster auf der Weltkarte an, zur Anzeige von Aufzeichnungen";

	Options_Button_ShowMinimapButton = "Zeige Minimap-Button";
	Options_Tooltip_ShowMinimapButton = "Zeige oder verstecke den Minimap-Button";

	Options_Slider_MinimapButtonPosition = "Minimap-Button Position";
	Options_Tooltip_MinimapButtonPosition = "Relative Position des Minimap-Buttons";

	Options_Slider_MinimapButtonOffset = "Minimap-Button seitl. versetzen";
	Options_Tooltip_MinimapButtonOffset = "Versetzt den Minimap Button seitlich";

	Options_Button_StoreEnemyPlayers = "Speichert feindl. Spieler";
	Options_Tooltip_StoreEnemyPlayers = "Speichert alle Daten von feindlichen Spieler die ihr trefft. WARNUNG: Bitte angemarkert lassen, oder es werden gar keine Daten mehr gespeichert !!";

	Options_Button_IgnoreNoPvPFlag = "Ignoriere Feinde ohne PvP-Flagge";
	Options_Tooltip_IgnoreNoPvPFlag = "Deaktiviert die Aufzeichnung von Feinden ohne PvP-Flagge";

	Options_Button_StoreDuels = "Duelle speichern";
	Options_Tooltip_StoreDuels = "Speichert deine Duelle";

	Options_Button_LockedTargetInfo = "PvP Zielinfo Fenster speichern";
	Options_Tooltip_LockedTargetInfo = "Das PvP Zielinformations-Fenster unbeweglich machen";

	Options_Button_TooltipTargetInfo = "PvP Infos werden im Tooltip angezeigt";
	Options_Tooltip_TooltipTargetInfo = "Zeigt bei feindlichen Spielern PvP Infos im Tooltip an";

	Options_Button_WarEnableFilter = "Krieg Filter Verz\195\182gerung";
	Options_Tooltip_WarEnableFilter = "Filtert Sound und Kriegsmittleilungen heraus, wenn eine Verz\195\182gerung eingestellt wurde";

	Options_Slider_WarFilterDelay = "Krieg Filter Verz\195\182gerung";
	Options_Tooltip_WarFilterDelay = "Minimum der Verz\195\182gerung (in Sekunden) zwischen 2 Kriegswarnungen";

	Options_Button_WarChatMessage = "Krieg Mouse-Over Chat Meldung";
	Options_Tooltip_WarChatMessage = "Gibt eine Warnmeldung im Chat aus sobald ein feindlicher Spieler ausgew\195\164hlt wird.";

	Options_Button_WarShowNote = "Zeigt Notizen feindlicher Spieler im Chat an";
	Options_Tooltip_WarShowNote = "Zeigt Notizen im Chat \195\156ber den feindlichen Spieler an (Wenn eine hinterlegt wurde)";

	Options_Button_DataCleanUp = "Aktiviere automatisches Data Clean-up";
	Options_Tooltip_DataCleanUp = "Automatischer Data Clean-up beim eingestellten n\195\164chsten Intervall";

	Options_Slider_DataCleanUpInterval = "Automatischer Data Clean-up Intervall";
	Options_Tooltip_DataCleanUpInterval = "Data Clean-up Intervall (in Tagen)";

	Options_Button_CleanInactiveEnemies = "L\195\182sche inaktive Feindeintragungen";
	Options_Tooltip_CleanInactiveEnemies = "L\195\182sche Feindeintragungen, die lange Zeit nicht ge\195\164ndert wurden und f\195\188r die Du keine PvP Eintragungen hast";

	Options_Slider_CleanInactiveEnemiesDelay = "L\195\182scheinstellung f\195\188r Feinde die Du lange Zeit nicht mehr gesehen hast";
	Options_Slider_CleanInactiveEnemiesDelay = "L\195\182scheinstellung f\195\188r Feinde die Du lange Zeit nicht mehr gesehen hast (in Tagen)";

	Options_Button_SharedWarMode = "Gemeinsam genutzte Kriegs Einstellungen";
	Options_Tooltip_SharedWarMode = "Gibt eine Warnmeldung aus, wenn einer Deiner Charaktere mit dem angew\195\164hlten Gegner im Krieg ist)";

	Options_Button_TooltipPlayerNote = "Zeigt Deine eingetragene Notiz im Tooltip an";
	Options_Tooltip_TooltipPlayerNote = "Zeigt Deine eingetragene Notiz im Tooltip des Gegners an";

	Options_Button_EnemyListAutoUpdate = "Automatisches Update der Feindes-Liste";
	Options_Tooltip_EnemyListAutoUpdate = "Aktualisiert automatisch (falls ben\195\182tigt) die Feindliste, wenn das entsprechende Interface-Element ge\195\182ffnet ist";

	Options_Slider_EnemyListAutoUpdateDelay = "Minimumverz\195\182gerung der Updates";
	Options_Tooltip_EnemyListAutoUpdateDelay = "Minimumsverz\195\182gerung zwischen zwei automatischen Updates der Feindes-Liste";

	Options_Button_CleanEmptyGuilds = "L\195\182schen leerer Gilden";
	Options_Tooltip_CleanEmptyGuilds = "L\195\182scht Gilden aus der Liste, der kein registrierter Feind mehr angeh\195\182rt";

	Options_Button_RecordPlayerDeathNonPvP = "Nicht-PvP Tode speichern";
	Options_Tooltip_RecordPlayerDeathNonPvP = "Speichert die Tode, die nicht durch feindliche Spieler verursacht wurden";
	
	Options_Button_ReportPlayerDeath = "Spieler-Tode Report";	
	Options_Tooltip_ReportPlayerDeath = "Gibt einen Report über die Spieler, die verantwortlich für Ihren Tod sind, wenn Sie sterben";


	-- List Frame Detail labels
	List_Frame_Player = "Spieler : ";
	List_Frame_Guild = "Gilde : ";
	List_Frame_Level = "Level ";
	List_Frame_Last_Seen = "Zuletzt gesehen : ";
	List_Frame_Last_Updated = "Zuletzt geupdatet : ";
	List_Frame_Met = "Beg. : ";
	List_Frame_Death = "Death : ";
	List_Frame_Kill = "Kill : ";
	List_Frame_Full = "Voll : ";
	List_Frame_Standard = "Standart : ";
	List_Frame_Assist = "Assistiert : ";
	List_Frame_Note = "Notiz : ";
	List_Frame_Guild_Member = "Bekannte Mitglieder : ";
	List_Frame_LoneWolf = "Einzelg\195\164nger Kills : ";
	List_Frame_HonorKill = "Ehrenkill :  ";
	List_Frame_RemainHonor = "Heutige Kills :  ";
	List_Frame_BGKill = "BG Kill :  ";
	List_Frame_BGDeath = "BG Death :  ";

	List_Frame_Last_Duel = "Letztes Duell :  ";
	List_Frame_Duel = "Duelle :  ";
	List_Frame_Win = "Sieg :  ";
	List_Frame_Loss = "Nied :  ";
	List_Frame_Score = "Punkte :  ";

	List_Button_FilterNoWar = "Zeige nur 'im Krieg' ";
	List_Tooltip_FilterNoWar = "Filtert alle Spieler und Gilden aus, die sich nicht im Krieg befinden";

	List_ConfirmDeletePlayer = "%sDies wird %s%s%s l\195\182schen und alle Mapaufzeichnungen inkl. (Siege und Niederlagen). Sind Sie sich wirklich sicher ?";

	Duel_ConfirmDeletePlayer = "%sDies wird %s%s%s l\195\182schen und alle damit verbundenen Duell-Informationen. Sind Sie sich wirklich sicher ?";


	List_EditNote_Title = "Edit Notiz";
	List_EditPlayerNote_Prompt = "%s Eingabe - Spielernotiz %s%s%s :";
	List_EditGuildNote_Prompt = "%s Eingabe - Gildennotiz <%s%s%s> :";


	-- Book frame
	Book_Page = "Seite";

	Book_GeneralStat_Header = "Generelle PvP Statistik";
	Book_ClassStat_Header = "Klassen PvP Statistik";
	Book_RaceStat_Header = "Rassen PvP Statistik";
	Book_EnemyStat_Header = "PvP Statistik nach Feinden";
	Book_GuildStat_Header = "Gilden PvP Statistik";
	Book_ZoneStat_Header = "PvP Statistik nach Zonen";

	Book_DateStat_Header = "PvP Statistik nach Datum";
	Book_BGDateStat_Header = "Battleground Statistik nach Datum";
	Book_BGZoneStat_Header = "Battleground Statistik nach Zonen";
	Book_BGDateZoneStat_Header = "Datum/Zonen Battleground Statistik";

	Book_TotalKill = "Totale PvP Kills";
	Book_TotalDeath = "Totale PvP Tode";
	Book_TotalRatio = "Kill/Total Durchschnitt";
	Book_AverageKillLevel = "Durchs. Level deiner Opfer";
	Book_AverageDeathLevel = "Durchs. Level deiner Henker";

	Book_EnemyPlayers = "Bekannte feindliche Spieler";
	Book_EnemyGuilds = "Bekannte feindliche Gilden";
	--Book_MapRecords = "Alle Aufzeichnungen der Weltkarte";
	Book_MapRecords = "Alle Aufzeichnungen der karte";


	Book_Label_Class = "Klassen";
	Book_Label_Race = "Rassen";
	Book_Label_Enemy = "Feinde";
	Book_Label_Guild = "Gilden";
	Book_Label_Zone = "Zonen";
	Book_Label_Date = "Datum";
	Book_Label_Kill = "Kills";
	Book_Label_Death = "Tode";
	Book_Label_Ratio = "Prozent";
	Book_Label_DateZone = "Datum/Zonen";

	Book_NoData = "Keine Daten vorhanden";

	Book_Format_AssistKill = "Sie t\195\182teten %s (Assistierter kill)";
	Book_Format_Kill = "Sie t\195\182teten %s (Standart Kill)";
	Book_Format_FullKill = "Sie t\195\182teten %s (Voller Kill)";
	Book_Format_LoneWolfKill = "Sie t\195\182teten %s (Einzelg\195\164nger kill)";
	Book_Format_Death = "%s t\195\182teten dich";

	Report_Button_UseAssist = "Z\195\164hle Assist Kills";
	Report_Tooltip_UseAssist = "Nimmt 'assist' Kills in die Spielerdaten mit auf. (Statistische Zwecke etc)";




	-- World map control frame
	--WorldMap_Button_ShowRecords = "Zeige Aufzeichnungen";
	WorldMap_Button_ShowRecords = "Zeige Icons"; -- shorter


	-- Messages optionaly displayed in chat window when recording events
	RecordMessage_PlayerPvPDeath = "Spieler gestorben (get\195\182tet von %s) aufgezeichnet";
	RecordMessage_PlayerPvEDeath = "Spieler gestorben (get\195\182tet von %s) aufgezeichnet";
	RecordMessage_PlayerDeath = "Spieler gestorben aufgezeichnet";

	RecordMessage_AssistKill = "%s <- Assistierter Kill aufgezeichnet";
	RecordMessage_Kill = "%s <- Kill aufgezeichnet";
	RecordMessage_FullKill = "%s <- Voller Kill aufgezeichnet";

	RecordMessage_CreatureKill = "%s <- Kill aufgezeichnet";
	
	ReportMessage_PlayerDeath = "Spieler-Tode - Verantwortlichkeitsreport (top %d)";

};

-- Note : the following UI strings can't be in a table because they are directly substituted from
-- values in xml file.

-- tab labels
SKMAP_TAB_LIST 		= "PvP";
SKMAP_TAB_DUEL          = "Duelle";
SKMAP_TAB_REPORT	= "Ruhmeshalle";
SKMAP_TAB_OPTIONS 	= "Optionen";

-- lists column headers
SKMAP_COLUMN_NAME 	= "Name";	-- player + guild
SKMAP_COLUMN_GUILD 	= "Gilde";	-- player
SKMAP_COLUMN_RACE 	= "Rasse";	-- player
SKMAP_COLUMN_CLASS 	= "Klasse";	-- player
SKMAP_COLUMN_LEVEL 	= "Lvl";	-- player
SKMAP_COLUMN_KILL 	= "Kills";	-- player + guild
SKMAP_COLUMN_DEATH 	= "Tode";	-- player + guild
SKMAP_COLUMN_MET 	= "Beg.";	-- player + guild
SKMAP_COLUMN_LASTSEEN 	= "Zuletzt gesehen";	-- player + guild
SKMAP_COLUMN_ATWAR 	= "Im Krieg ?";	-- player + guild
SKMAP_COLUMN_MEMBERS	= "Mitglieder";	-- guild
-- 0.08.1 Begin of modification: add localization ofr ATWar status
SKMAP_COLUMN_ATWAR_ALL = "Alle";
SKMAP_COLUMN_ATWAR_PLAYER = "Spieler";
SKMAP_COLUMN_ATWAR_GUILD = "Gilde";
-- 0.08.1 End of modification: add localization ofr ATWar status

SKMAP_COLUMN_WIN = "Sieg";
SKMAP_COLUMN_LOSS = "Nied";
SKMAP_COLUMN_DUELS = "Duelle";
SKMAP_COLUMN_LASTDUEL = "Letztes Duell";
SKMAP_COLUMN_SCORE = "Punkte";

-- "list toggle" button
SKMAP_GUILDS		= "Gilden";
SKMAP_PLAYERS		= "Spieler";

-- "show guild" button
SKMAP_SHOWGUILD = "Zeige Gilde";

-- "back" button
SKMAP_BACK = "Zur\195\188ck";

-- "edit note" button
SKMAP_EDITNOTE = "Edit Notiz";

-- "report" button
SKMAP_REPORT = "Report";

-- "delete" button
SKMAP_DELETE = "L\195\182schen";

-- "clear" button
SKMAP_CLEAR = "Leeren";

--SKMAP_RESETSORT = "Zur\195\188cksetzen der Sortierung"; -- too long
SKMAP_RESETSORT = "Reset sort"; -- need translation

--SKMAP_UPDATELIST = "Aktualisieren"; -- too long
SKMAP_UPDATELIST = "Update";

SKM_BTN_EXPAND_ALL = "Alle \195\150ffnen";
SKM_BTN_COLLAPSE_ALL = "Alle Schlie\195\159en";


-- previous and next labels for book browsing buttons
SKMAP_PREV = "Zur\195\188ck";
SKMAP_NEXT = "Vor";

SKMAP_BTN_STATS_GENERAL	= "Generell";
SKMAP_BTN_STATS_CLASS	= "Klassen";
SKMAP_BTN_STATS_RACE	= "Rassen";
SKMAP_BTN_STATS_ENEMIES	= "Feinde";
SKMAP_BTN_STATS_GUILDS	= "Gilden";
SKMAP_BTN_STATS_ZONE	= "Karte";
SKMAP_BTN_STATS_DATE	= "Datum";
SKMAP_BTN_CREDITS	= "Credits";

SKMAP_BTN_STATS_BG_ZONE = "BG Karte";
SKMAP_BTN_STATS_BG_DATE = "BG Datum";
SKMAP_BTN_STATS_BG_DATE_ZONE = "BG Datum/Karte";

--don't translate this
--SKMAP_CREDITS = {
--};

SKMAP_WORLDMAP_TITLE = "SKMap";
SKMAP_WORLDMAP_HIDE = "Verstecken";

-- Messages patterns.
-- Allowed pattern variables are :
-- %name : unit name (player name, monster name, NPC name)
-- %class : unit class (Rogue, Warlock, ...), or creature class (Elite, Rare, ...)
-- %race : unit race (Undead, Troll, ...)
-- %level : unit level
-- %player : player name

SKM_MESSAGES = {
	-- Report enemy player kill
	Message_PlayerKill = "%date - %name (lvl %level %race %class)";

	-- Report player self death - no known killer
	Message_PlayerDeath = "%date - RIP %player";

	-- Report player self death - PvE
	Message_PlayerDeath_PvE = "%date - %player get\195\182tet von %name";

	-- Report player self death - PvP
	Message_PlayerDeath_PvP_NoData = "%date - %player get\195\182tet von %name";
	Message_PlayerDeath_PvP = "%date - %player get\195\182tet von %name (lvl %level %race %class)";

	-- Report creature kill
	Message_CreatureKill_Basic = "%date - %name";
	Message_CreatureKill_Detail = "%date - %name (lvl %level)";
	Message_CreatureKill_RareDetail = "%date - %name (lvl %level %class)";

	Message_LevelUp = "%date - %name hat folgendes Level erreicht %level !";

	SubMessage_HonorKill = "|cff4cffff[Ehre]";

};

SKM_UNKNOWN_ENTITY = UNKNOWNOBJECT;
-- --------------------------------------------------------------------------------------



end



-- 09/04/2005 11:16:11 PIng:  Message_* localized


-- Player configuration for SKMap
SKM_Config = {

	-- RGB values for the debug modes
	RGB_Debug = {
		[0] = { r = 1.0, g = 1.0, b = 0.5 };
		      { r = 1.0, g = 1.0, b = 1.0 },
		      { r = 0.8, g = 0.8, b = 0.8 },
		      { r = 0.6, g = 0.6, b = 0.6 },
		      { r = 0.6, g = 0.5, b = 0.4 }
	};

	-- Debug information level. -1 = no debug, 0-4 = quiet to very verbose
	DebugLevel = -1;

	-- Record debug to SavedVariables.lua
	RecordDebug = false;

	-- Issue an information message each x lines recorded
	RecordIntervalInfo = 100;

	-- Maximum function length displayed in debug messages
	DebugMaxFuncLen = 20;

	-- RGB values for the mod messages
	RGB_Msg = { r = 0.3, g = 1.0, b = 1.0 };

	-- RGB values
	RGB_PlayerDeath = { r = 0.9, g = 0.2, b = 0.2 };
	RGB_PlayerPvEDeath = { r = 0.9, g = 0.5, b = 0.0 };
	RGB_PlayerPvPDeath = { r = 0.9, g = 0.2, b = 0.2 };

	RGB_PlayerAssistKill = { r = 0.2, g = 0.9, b = 0.2 };
	RGB_PlayerKill = { r = 0.25, g = 0.4, b = 0.9 };
	RGB_PlayerFullKill = { r = 0.7, g = 0.3, b = 0.8 };
	RGB_LoneWolfKill = { r = 0.93, g = 0.5, b = 0.93 };

	RGB_CreatureKill = { r = 0.6, g = 0.6, b = 0.6 };

	RGB_LevelUp = { r = 1, g = 0.8, b = 0.0 };

	RGB_ReportDeath = { r = 0.9, g = 0.2, b = 0.1 };


  -- 0.2  = x33
  -- 0.9  = xe6
  -- 0.25 = x40
  -- 0.4  = x66
  -- 0.7  = xb3
  -- 0.3  = x4c
  -- 0.8  = xcc
  -- default blizz gold color : "|cffffd700"

	-- Color codes in string format
	Col_Label = "|cffffffff";
	Col_LabelTitle = "|cffffd700";

	Col_PlayerAssistKill = "|cff33e633";
	Col_PlayerKill = "|cff4066e6";
	Col_PlayerFullKill = "|cffb34ccc";
	Col_LoneWolfKill = "|cffee82ee";
	Col_PlayerTotalKill = "|cff228b22";
	Col_PlayerDeath = "|cffe63333";
	Col_PlayerMet = "|cffdcdcdc";
	Col_PlayerWar = "|cffff2020";
	Col_BGKill = "|cff20b2aa";
	Col_BGDeath = "|cfff08080";

	--Col_HonorKill = "|cffafeeee";
	--Col_HonorKill = "|cff9acd32";
	Col_HonorKill = "|cff4cffff";
	--Col_Honorless = "|cffcdc9c9";
	Col_Honorless = "|cff999999";

	Col_DuelWin = "|cff33e633";
	Col_DuelLoss = "|cffe63333";

	Col_Rank = "|cffb0c4de";
	Col_SharedWar = "|cffffd700";
	Col_PlayerNote = "|cffcdc9c9";

	IconPath = "Interface\\AddOns\\SKMap\\Icons";

--	Icons = {
--		WorldMap = {
--		  [_icon_PlayerKill] = "PlayerKill";
--		  [_icon_PlayerDeath] = "PlayerDeath";
--		};
--	};

	IconsByType = {
		-- single types
		[_SKM._playerAssistKill] = "PlayerKill";
		[_SKM._playerKill] = "PlayerKill";
		[_SKM._playerFullKill] = "PlayerKill";
		[_SKM._playerDeath] = "PlayerDeath";
		[_SKM._playerDeathPvE] = "PlayerDeathPvE";
		[_SKM._playerDeathPvP] = "PlayerDeathPvP";
		[_SKM._creatureKill_Target] = "CreatureKill";
		[_SKM._creatureKill_Xp] = "CreatureKill";
		[_SKM._levelUp] = "LevelUp";

		-- multiples types
		[_SKM._playerKillAndDeath] = "PlayerCombat";
		[_SKM._multiType] = "Multi";

		-- default
		[_SKM._default] = "Default";
	};

	Buttons = {
		--ExpandButton = "SKMapExpandButton";
		ExpandButton = "SKMapTargetInfoMaxButton";
		--CollapseButton = "SKMapCollapseButton";
		CollapseButton = "SKMapTargetInfoMinButton";
	};



	-- Minimum distance between two notes for separate POI
	--MapNotes_MinDiff = 7;
	MapNotes_MinDiff = 15;

	-- Max number of lines displayed in tooltip
	MapNotes_MaxLines = 20;

	-- Messages patterns.
	-- Allowed pattern variables are :
	-- %name : unit name (player name, monster name, NPC name)
	-- %class : unit class (Rogue, Warlock, ...)
	-- %race : unit race (Undead, Troll, ...)
	-- %level : unit level
	-- %player : player name

	-- Report enemy player kill
	Message_PlayerKill = SKM_MESSAGES.Message_PlayerKill;

	-- Report player self death - no known killer
	Message_PlayerDeath = SKM_MESSAGES.Message_PlayerDeath;

	-- Report player self death - PvE
	Message_PlayerDeath_PvE = SKM_MESSAGES.Message_PlayerDeath_PvE;


	-- Report player self death - PvP
	Message_PlayerDeath_PvP_NoData = SKM_MESSAGES.Message_PlayerDeath_PvP_NoData;
	Message_PlayerDeath_PvP = SKM_MESSAGES.Message_PlayerDeath_PvP;

	-- Report creature kill
	Message_CreatureKill_Basic = SKM_MESSAGES.Message_CreatureKill_Basic;
	Message_CreatureKill_Detail = SKM_MESSAGES.Message_CreatureKill_Detail;
	Message_CreatureKill_RareDetail = SKM_MESSAGES.Message_CreatureKill_RareDetail;

	--Message_LevelUp = "%date - DING! %level";
	Message_LevelUp = SKM_MESSAGES.Message_LevelUp;

	SubMessage_HonorKill = SKM_MESSAGES.SubMessage_HonorKill;

	-- Labels displayed for creature classification
	CreatureClassLabel = {
		["worldboss"] = "World Boss";
		["rareelite"] = "Rare Elite";
		["elite"] = "Elite";
		["rare"] = "Rare";
	};



	-- Remove an enemy from the "EnemyCombat" list (ie, damage done to enemies)
	-- if no update is received within this timer range.
	ForgetEnemyTimer = 120;

	-- Remove an enemy from the "PlayerCombat" list (ie, damage done by enemies to player)
	-- if no update is received within this timer range.
	ForgetAggressorTimer = 120;

	-- Hate reduction coefficient. For each second, current hate is reduced by this
	-- coefficient percentage. 0 means there is no hate reduction at all.
	HateReductionCoeff = 4;

	-- Time interval between last seen an enemy and now to consider it's a new meeting
	-- (in sec)
	TimeRangeForNewMeeting = 1800; -- 30 min

	-- Maximum size of RecentEnemyKill list
	MaxRecentEnemyKill = 5;

	-- Maximum validity delay of an element in RecentEnemyKill list
	RecentEnemyKillDelay = 5;

	-- Maximum size of RecentWarWarning list
	MaxRecentWarWarning = 5;

	-- Maximum validity delay of an element in RecentWarWarning list
	RecentWarWarningDelay = 5;

	-- For formatted line added to Tooltip
	MaxFormatLineLength = 60;
	FormatLineThreshold = 15;


	-- filter out enemies or guilds not "at war" in list frame
	FilterNotAtWar = false;

	-- war sound file
	WarSoundFile = "Interface\\AddOns\\SKMap\\Sound\\WarSound.wav";



	-- The following configured values are initial values only. They are loaded the first
	-- time you use the mod, and then managed in the Graphical UI.

	-- Display target info frame or keep it hidden
	ShowTargetInfo = true;

	-- Use small target info (true) or normal one (false)
	SmallTargetInfo = false;

	-- Automatically target an enemy at war on whom you get a mouse-over warning
	-- if current target is empty
	WarAutoTarget = false;

	-- Play a sound when an enemy at war is detected on mouse-over
	WarSoundWarning = true;

	-- Display a floating message when an enemy at war is detected on mouse-over
	WarFloatingMessage = true;

	-- Record enemy players kills
	RecordPlayerKill = true;

	-- Record player deaths (PvP)
	RecordPlayerDeath = true;

	-- Record player deaths (non-PvP)
	RecordPlayerDeathNonPvP = true;

	-- Record creature kills
	RecordCreatureKill = true;

	-- Display a message when recording a player kill
	DisplayKillRecord = false;

	-- Display a message when recording a creature kill
	DisplayCreatureKillRecord = false;

	-- Display a message when recording player deaths
	DisplayDeathRecord = false;

	-- Display icons on main world map
	UseMainMap = true;

	-- Display recorded events on world map
	MapDisplayRecords = true;

	-- Only keep the N most recently recorded creature kills by zone
	-- (else we could quickly create a huge mess !) - allowed range = 0-100
	CreatureKillRecordsByZone = 20;

	-- Disable storage of information related to inactive low level enemies
	IgnoreLowerEnemies = false;

	-- Ignore enemies less than x% of player level  (if option "IgnoreLowerEnemies" is
	-- checked).
	IgnoreLevelThreshold = 75;

	-- Display enemy target guild information
	ShowTargetGuildInfo = true;

	-- Display enemy target class information
	ShowTargetClassInfo = false;

	-- Show world map control mini frame
	ShowWorldMapControl = true;

	-- Show minimap button
	ShowMinimapButton = true;

	-- position of minimap button that toggles SKMap interface
	-- (this is a percentage value of the real position, 100 is at the top left, just below the
	-- "detect" icon, and 0 is at the bottom right, just left of the "-" icon)
	MinimapButtonPosition = 100;

	-- offset of minimap button that toggles SKMap interface
	MinimapButtonOffset = 82;


	-- Ignore (don't record) enemies that do not have a PvP flag
	IgnoreNoPvPFlag = false;

	-- Store enemy players. WARNING : if this is disabled, then kills and deaths will probably
	-- not be identified !
	StoreEnemyPlayers = true;

	-- Store duels
	StoreDuels = true;

	-- Take "assist kills" into account for statistics and reports
	AssistKillStat = false;

	-- "locked" Target Info frame
	LockedTargetInfo = false;

	-- Add enemy target information to tooltip
	TooltipTargetInfo = false;


	-- Add enemy player note to tooltip
	TooltipPlayerNote = false;

	-- War delay filter enabled
	WarEnableFilter = false;

	-- War delay filter value
	WarFilterDelay = 1;

	-- Display a chat message when an enemy at war is detected on mouse-over
	WarChatMessage = false;

	-- Add player note to WAR chat message
	WarShowNote = false;

	-- Automatic data clean-up options
	DataCleanUp = true;

	DataCleanUpInterval = 7;
	CleanInactiveEnemies = false;
	CleanInactiveEnemiesDelay = 60;
	CleanEmptyGuilds = true;

	-- Shared WAR mode
	SharedWarMode = false;


	-- Display a report upon player death
	ReportPlayerDeath = true;
	ReportDeathMaxLines = 5;


	-- Enemy list automatic update
	EnemyListAutoUpdate = true;
	EnemyListAutoUpdateDelay = 0;

	-- Default sort criterias
	EnemyList_SortType = "Name";
	EnemyList_SortTypes = { "Name" };
	EnemyList_ReverseSort = false;

	GuildList_SortType = "Name";
	GuildList_SortTypes = { "Name" };
	GuildList_ReverseSort = false;

	DuelList_SortType = "Name";
	DuelList_SortTypes = { "Name" };
	DuelList_ReverseSort = false;


}


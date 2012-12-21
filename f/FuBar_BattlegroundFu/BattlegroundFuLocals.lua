if not ace:LoadTranslation("BattlegroundFu") then

BattlegroundFuLocals = {
	NAME = "FuBar - BattlegroundFu",
	DESCRIPTION = "Battleground management for FuBar, based on TitanBG",
	COMMANDS = {"/bf","/batfu","/battlegroundfu"},
	CMD_OPTIONS = {},
	--
	TEXT_BASE = "Base",
	TEXT_STATUS = "Status",
	TEXT_CONFIRM = "Confirm",
	TEXT_BGQUEUES = "Battlefields Queued",
	TEXT_QUEUES = "Queue(s)",
	TEXT_NO_QUEUES = "No Queues",
	TEXT_QUEUE_PROGRESS = "Progress",
	TEXT_INVERT_QUEUE_PROGRESS = "Remaining",
	TEXT_PLAYER_STATS = "Player Stats",
	TEXT_FLAG_CARRIERS = "Flag Carriers",
	TEXT_FLAG = "Flag",
	TEXT_CARRIER = "Carrier",
	
	TEXT_TEAM = "Team",
	TEXT_PLAYERS = "Players",
	TEXT_SCORE = "Score",
	TEXT_BASES = "Bases",
	TEXT_RESOURCES = "Resources",
	TEXT_TTV = "TTV",
	TEXT_NONE = "None",
	TEXT_NA = "N/A",

	TEXT_STANDING = "Standing",
	TEXT_KILLING_BLOWS = "Killing Blows",
	TEXT_KILLS = "Kills",
	TEXT_DEATHS = "Deaths",
	TEXT_BONUS_HONOR = "Bonus Honor",

	TEXT_HINT_NORMAL = "Click to cycle through Scoreboard/Battlefield List frames.",
	TEXT_HINT_CLICKSHOWSSCOREBOARD = "Click to toggle scoreboard display.",
	--
	MENU_HIDE_MINIMAP_BUTTON = "Hide Minimap Button",
	MENU_INVERT_QUEUE_PROGRESS_TIMERS = "Invert Queue Progress Timers",
	MENU_CLICK_SHOWS_SCOREBOARD = "Show only scoreboard on click",
	MENU_TOOLTIP_DISPLAY = "Tooltip Display",
	MENU_TEAM_SIZES = "Team Sizes",
	MENU_TEAM_SCORES = "Team Scores",
	MENU_NUM_BASES_HELD = "Bases Held",
	MENU_RESOURCE_TTV = "Resource Time-To-Victory",
	MENU_BATTLEFIELD_STATS = "Player Stats",
	MENU_OBJECTIVE_STATUS = "Objective Status",
	MENU_SHOW_UNCONTESTED = "Show Uncontested Objectives",
	MENU_CTF_FLAG_CARRIERS = "CTF Flag Carriers",
	MENU_BATTLEFIELD_QUEUES = "Queues",
	--
	ARGUMENT_HIDEMINIMAPBUTTON = "minimap",
	ARGUMENT_INVERTQUEUEPROGRESS = "invert",
	ARGUMENT_CLICKSHOWSSCOREBOARD = "clickscores",
	ARGUMENT_SHOWTEAMSIZES = "teamsizes",
	ARGUMENT_SHOWTEAMSCORES = "teamscores",
	ARGUMENT_SHOWNUMBASES = "bases",
	ARGUMENT_SHOWRESOURCETTV = "ttv",
	ARGUMENT_SHOWBATTLEFIELDSTATS = "stats",
	ARGUMENT_SHOWOBJECTIVESTATUS = "objectives",
	ARGUMENT_SHOWUNCONTESTED = "uncontested",
	ARGUMENT_SHOWCTFFLAGCARRIERS = "flags",
	ARGUMENT_SHOWBATTLEFIELDQUEUES = "queues",
	--
	TEXT_BGOBJECTIVE_DESTROYED = "Destroyed",
	TEXT_BGOBJECTIVE_INCONFLICT = "In Conflict",
}
BattlegroundFuLocals.CMD_OPTIONS = {
	{
		option = BattlegroundFuLocals.ARGUMENT_HIDEMINIMAPBUTTON,
		desc = "Toggle the Battlegrounds minimap button.",
		method = "ToggleHidingMinimapButton",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_INVERTQUEUEPROGRESS,
		desc = "Toggle whether queue timers count down from the estimated queue duration or up from zero.",
		method = "ToggleInvertQueueProgress",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_CLICKSHOWSSCOREBOARD,
		desc = "Toggle in-battle behavior for clicking on the BattlegroundFu bar (scoreboard only/scoreboard and battlefield instance frames).",
		method = "ToggleClickShowsScoreboard",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWTEAMSIZES,
		desc = "Toggle tooltip display of team sizes in-battle.",
		method = "ToggleShowingTeamSizes",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWTEAMSCORES,
		desc = "Toggle tooltip display of team scores in-battle.",
		method = "ToggleShowingTeamScores",
	},
 	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWNUMBASES,
		desc = "Toggle display of number of bases held in resource-gather battlegrounds.",
		method = "ToggleShowingNumBases",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWRESOURCETTV,
		desc = "Toggle display of estimated time-to-victory in resource-gather battlegrounds.",
		method = "ToggleShowingResourceTTV",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWBATTLEFIELDSTATS,
		desc = "Toggle tooltip display of player's scores and stats.",
		method = "ToggleShowingBattlefieldPlayerStatistics",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWOBJECTIVESTATUS,
		desc = "Toggle tooltip display of battlefield objective status (capture timers, base ownership, etc.).",
		method = "ToggleShowingBattlefieldObjectiveStatus",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWUNCONTESTED,
		desc = "Filter display between all objectives and only those which are currently contested.",
		method = "ToggleShowingUncontestedObjectives",
	},
 	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWCTFFLAGCARRIERS,
		desc = "Toggle clickable tooltip display of the flag carriers in CTF battlegrounds.",
		method = "ToggleShowingCTFFlagCarriers",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWBATTLEFIELDQUEUES,
		desc = "Toggle tooltip display of battlefield queues.",
		method = "ToggleShowingBattlefieldQueues",
	},
}
end

function BattlegroundFu_Locals_deDE()
	BattlegroundFuLocals = {
	NAME = "FuBar - BattlegroundFu",
	DESCRIPTION = "Schlachtfeld Management f\195\188r FuBar, basierend auf TitanBG",
	COMMANDS = {"/bf","/batfu","/battlegroundfu"},
	CMD_OPTIONS = {},
	--
	TEXT_BASE = "Basis",
	TEXT_STATUS = "Status",
	TEXT_CONFIRM = "Best\195\164tigen",
	TEXT_BGQUEUES = "Schlachtfeld",
	TEXT_QUEUES = "Schlange(n)",
	TEXT_NO_QUEUES = "Keine Schlangen",
	TEXT_QUEUE_PROGRESS = "Wartezeit",
	TEXT_INVERT_QUEUE_PROGRESS = "Wartezeit (\195\188brig)",
	TEXT_PLAYER_STATS = "Spieler-Werte",
	TEXT_FLAG_CARRIERS = "Flaggentr\195\164ger",
	TEXT_FLAG = "Flagge",
	TEXT_CARRIER = "Tr\195\164ger",

	TEXT_TEAM = "Team",
	TEXT_PLAYERS = "Spieler",
	TEXT_SCORE = "Punkte",
	TEXT_BASES = "Basen",
	TEXT_RESOURCES = "Ressourcen",
	-- TEXT_TTV = "TTV",
	TEXT_NONE = "Keine",
	TEXT_NA = "N/A",

	TEXT_STANDING = "Platz",
	TEXT_KILLING_BLOWS = "Todestreffer",
	TEXT_KILLS = "T\195\182tungen",
	TEXT_DEATHS = "Tode",
	TEXT_BONUS_HONOR = "Bonus-Ehre",

	TEXT_HINT_NORMAL = "Klicken um zwischen Punktetabelle und Schlachtfeldliste zu wechseln.",
	TEXT_HINT_CLICKSHOWSSCOREBOARD = "Klicken um die Punktetabelle anzuzeigen.",
	--
	MENU_HIDE_MINIMAP_BUTTON = "Minikarten-Knopf ausblenden",
	MENU_INVERT_QUEUE_PROGRESS_TIMERS = "Rest-Wartezeit anzeigen",
	MENU_CLICK_SHOWS_SCOREBOARD = "Bei Klick nur Punktetabelle anzeigen",
	MENU_TOOLTIP_DISPLAY = "Tooltip-Anzeige",
	MENU_TEAM_SIZES = "Team-Gr\195\182\195\159en",
	MENU_TEAM_SCORES = "Team-Punkte",
	MENU_NUM_BASES_HELD = "Basen Gehalten",
	MENU_RESOURCE_TTV = "Ressourcen Zeit-bis-Sieg",
	MENU_BATTLEFIELD_STATS = "Player-Werte",
	MENU_OBJECTIVE_STATUS = "Ziel-Status",
	MENU_SHOW_UNCONTESTED = "Show Uncontested Objectives",  --TRANSLATE
	MENU_CTF_FLAG_CARRIERS = "CTF Flaggentr\195\164ger",
	MENU_BATTLEFIELD_QUEUES = "Schlangen",
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
	TEXT_BGOBJECTIVE_DESTROYED = "Zerst\195\182rt",
	TEXT_BGOBJECTIVE_INCONFLICT = "Umk\195\164mpft",
	}
	BattlegroundFuLocals.CMD_OPTIONS = {
	{
		option = BattlegroundFuLocals.ARGUMENT_HIDEMINIMAPBUTTON,
		desc = "Minikarten-Knopf ein/ausblenden.",
		method = "ToggleHidingMinimapButton",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_INVERTQUEUEPROGRESS,
		desc = "Einstellen ob Timer ab- oder aufw\195\164rts z\195\164hlt.",
		method = "ToggleInvertQUEUEProgress",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_CLICKSHOWSSCOREBOARD ,
		desc = "Einstellen ob auf dem Schlachtfeld bei Klick nur die Punktetabelle oder auch die Instanzen angezeigt werden.",
		method = "ToggleClickShowsScoreboard",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWTEAMSIZES,
		desc = "Tooltip-Anzeige der Team-Gr\195\182\195\159en umschalten.",
		method = "ToggleShowingTeamSizes",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWTEAMSCORES,
		desc = "Tooltip-Anzeige der Team-Punkte umschalten.",
		method = "ToggleShowingTeamScores",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWNUMBASES,
		desc = "Tooltip-Anzeige der gehaltenen Basen umschalten.",
		method = "ToggleShowingNumBases",
	},
		--[[ {
		option = BattlegroundFuLocals.ARGUMENT_SHOWRESOURCETTV,
		desc = "Tooltip-Anzeige der Zeit-bis-Sieg Angabe umschalten.",
		method = "ToggleShowingResourceTTV",
		},]]--
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWBATTLEFIELDSTATS ,
		desc = "Tooltip-Anzeige der Spieler-Punkte und -Werte umschalten.",
		method = "ToggleShowingBattlefieldPlayerStatistics",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWOBJECTIVESTATUS,
		desc = "Tooltip-Anzeige des Ziel-Status (Timer, Basen) umschalten.",
		method = "ToggleShowingBattlefieldObjectiveStatus",
	},
	{--TRANSLATE
		option = BattlegroundFuLocals.ARGUMENT_SHOWUNCONTESTED,
		desc = "Filter display between all objectives and only those which are currently contested.",
		method = "ToggleShowingUncontestedObjectives",
	},
 	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWCTFFLAGCARRIERS,
		desc = "Tooltip-Anzeige der Flaggentr\195\164ger klickbar machen.",
		method = "ToggleShowingCTFFlagCarriers",
	},
	{
		option = BattlegroundFuLocals.ARGUMENT_SHOWBATTLEFIELDQUEUES,
		desc = "Tooltip-Anzeige der Schlangen umschalten.",
		method = "ToggleShowingBattlefieldQueues",
	},
}
end

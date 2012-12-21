if not ace:LoadTranslation("HonorFu") then

HonorFuLocals = {
	NAME = "FuBar - HonorFu",
	DESCRIPTION = "Keeps track of honor and PvP statistics.",
	COMMANDS = {"/honfu", "/honorfu"},
	CMD_OPTIONS = {},

	ARGUMENT_MERGEHONOR = "mergeHonor",
	ARGUMENT_SHOWHONOR = "showHonor",
	ARGUMENT_SHOWBGSCORE = "showBGScore",
	ARGUMENT_SHOWKILLSDEATHS = "showKillsDeaths",
	ARGUMENT_AUTORELEASE = "autoRelease",
	ARGUMENT_TARGETFLAG = "targetFlag",
	ARGUMENT_BGMAP = "bgMap",
	ARGUMENT_RESETBG = "resetBG",
	ARGUMENT_PRINTREPGAIN = "printRepGain",
	ARGUMENT_PRINTHONORGAIN = "printHonorGain",
	ARGUMENT_SHOWCOOLDOWN = "cooldown",
	ARGUMENT_ENEMYTOOLTIP = "enemyTooltip",
	
	MENU_SHOW_HONOR = "Show Honor",
	MENU_SHOW_BATTLEGROUNDS_SCORE = "Show Battlegrounds score",
	MENU_SHOW_KILLS_AND_DEATHS = "Show kills and deaths",
	MENU_RESET_BG_SCORES = "Reset battlegrounds scores",
	MENU_MERGE_WITH_HONOR = "Merge with Honor",
	MENU_SHOW_HONOR_STATISTICS = "Show honor statistics",
	MENU_SHOW_XP_STATISTICS = "Show XP statistics",
	MENU_AUTO_RELEASE_WHEN_DEAD = "Auto-release when dead",
	MENU_TARGET_FLAG = "Target opposing flagholder",
	MENU_OPEN_BATTLEGROUNDS_MINIMAP = "Auto-open minimap for battlegrounds",
	MENU_PRINT_REPUTATION_GAINS = "Print out PvP reputation gains",
	MENU_PRINT_HONOR_GAINS = "Print out honor gains",
	MENU_SHOW_COOLDOWN = "Show cooldown",
	MENU_ADD_INFO_TO_ENEMY_TOOLTIP = "Add info to enemy tooltip",
	
	TEXT_PVP_COOLDOWN = "PvP Cooldown",
	TEXT_BATTLEGROUNDS = "Battlegrounds",
	TEXT_FLAGGED = "Flagged",
	TEXT_PROGRESS = "Progress",
	TEXT_KILLS_TO_DEATHS = "Kills-Deaths",
	TEXT_BATTLEGROUNDS_SCORE = "Battlegrounds score",
	TEXT_TODAY_HK_HONOR = "Today's HK honor",
	TEXT_TODAY_BONUS_HONOR = "Today's bonus honor",
	TEXT_TODAY_TOTAL_HONOR = "Today's total honor",
	TEXT_YESTERDAY_HONOR = "Yesterday's honor",
	TEXT_THIS_WEEK_HONOR = "This week's honor",
	TEXT_LAST_WEEK_HONOR = "Last week's honor",
	TEXT_BATTLEGROUNDS_SCORE_RESET = "Battlegrounds score reset",
	TEXT_RATING_LIMIT = "Rating limit",
	TEXT_RANK_LIMIT = "Rank limit",
	TEXT_ON = "On",
	TEXT_OFF = "Off",
	
	PATTERN_BONUS_HONOR = "Gained %d bonus honor",
	PATTERN_GAIN_HK = "Kill: %s %s. %d honor gained. Killed %d times today.",
	PATTERN_REPUTATION_GAIN = "Gained %d reputation with %s",
	PATTERN_HINT_WARSONG = "Click to target flag carrier (%s).",
	PATTERN_BATTLEGROUNDS_SCORE = "%s score",
	PATTERN_BATTLEGROUNDS_WEEKEND = "%s weekend",
}

HonorFuLocals.CMD_OPTIONS = {
	{
		option = HonorFuLocals.ARGUMENT_AUTORELEASE,
		desc = "Toggle whether to automatically release when dead in battlegrounds.",
		method = "ToggleAutoReleasing",
	},
	{
		option = HonorFuLocals.ARGUMENT_BGMAP,
		desc = "Toggle whether to automatically open the battlegrounds minimap.",
		method = "ToggleShowingBGMap",
	},
	{
		option = HonorFuLocals.ARGUMENT_TARGETFLAG,
		desc = "Target the current opposing flagholder. (also /tflag or /tarflag)",
		method = "TargetFlag",
	},
	{
		option = HonorFuLocals.ARGUMENT_RESETBG,
		desc = "Reset the battlegrounds scores to 0-0",
		method = "ResetBGScores",
	},
	{
		option = HonorFuLocals.ARGUMENT_PRINTREPGAIN,
		desc = "Print out PvP reputation gains",
		method = "TogglePrintingReputationGains",
	},
	{
		option = HonorFuLocals.ARGUMENT_PRINTHONORGAIN,
		desc = "Print out honor gains",
		method = "TogglePrintingHonorGains",
	},
	{
		option = HonorFuLocals.ARGUMENT_SHOWBGSCORE,
		desc = "Show Battlegrounds score in the text",
		method = "ToggleShowBGScore"
	},
	{
		option = HonorFuLocals.ARGUMENT_SHOWKILLSDEATHS,
		desc = "Show kills and deaths in the text",
		method = "ToggleShowKillsDeaths"
	},
}

end
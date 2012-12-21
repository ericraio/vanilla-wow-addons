function HonorFu_Locals_deDE()
 
HonorFuLocals = {
	NAME = "FuBar - HonorFu",
	DESCRIPTION = "F\195\188hrt Buch \195\188ber PvP und Ehre.",
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
	
	MENU_SHOW_HONOR = "Zeige Ehre",
	MENU_SHOW_BATTLEGROUNDS_SCORE = "Schlachtfeldpunkte anzeigen",
	MENU_SHOW_KILLS_AND_DEATHS = "Kills und Tode anzeigen",
	MENU_RESET_BG_SCORES = "Schlachtfeldpunkte zur\195\188cksetzen",
	MENU_MERGE_WITH_HONOR = "Mit HonorFu verbinden",
	MENU_SHOW_HONOR_STATISTICS = "Zeige Ehrenstatistik",
	MENU_SHOW_XP_STATISTICS = "Zeige Erfahrungsstatistik",
	MENU_AUTO_RELEASE_WHEN_DEAD = "Geist beim Tod automatisch freilassen",
	MENU_TARGET_FLAG = "Gegnerischen Flaggentr\195\164ger ins Ziel nehmen",
	MENU_OPEN_BATTLEGROUNDS_MINIMAP = "Minischlachtfeldkarte automatisch \195\182ffnen",
	MENU_PRINT_REPUTATION_GAINS = "PvP-Ruf im Chatfenster ausgeben",
	MENU_PRINT_HONOR_GAINS = "Ehre im Chatfenster ausgeben",
	MENU_SHOW_COOLDOWN = "Abklingzeit anzeigen",
	MENU_ADD_INFO_TO_ENEMY_TOOLTIP = "Info zum Gegner-Tooltip hinzuf\195\188gen",
	
	TEXT_PVP_COOLDOWN = "PvP-Abklingzeit",
	TEXT_BATTLEGROUNDS = "Schlachtfelder",
	TEXT_FLAGGED = "Flaggentr\195\164ger",
	TEXT_PROGRESS = "Fortschritt",
	TEXT_KILLS_TO_DEATHS = "Kills-Tode",
	TEXT_BATTLEGROUNDS_SCORE = "Schlachtfeldpunkte",
	TEXT_TODAY_HK_HONOR = "Killehre heute",
	TEXT_TODAY_BONUS_HONOR = "Bonusehre heute",
	TEXT_TODAY_TOTAL_HONOR = "Gesamtehre heute",
	TEXT_YESTERDAY_HONOR = "Ehre gestern",
	TEXT_THIS_WEEK_HONOR = "Ehre diese Woche",
	TEXT_LAST_WEEK_HONOR = "Ehre letzte Woche",
	TEXT_BATTLEGROUNDS_SCORE_RESET = "Schlachtfeldpunkte zu\195\188cksetzen",
	TEXT_RATING_LIMIT = "Bewertungsgrenze", 
	TEXT_RANK_LIMIT = "Ranggrenze", 
	TEXT_ON = "An",
	TEXT_OFF = "Aus",
	
	PATTERN_BONUS_HONOR = "Bonusehre: %d",
	PATTERN_GAIN_HK = "Kill: %s %s. %d Ehre erhalten. Heute %d Mal get\195\182tet.",
	PATTERN_REPUTATION_GAIN = "%d Ruf bei %s erhalten",
	PATTERN_HINT_WARSONG = "Klicken um Flaggentr\195\164ger ins Ziel zu nehmen (%s).",
	PATTERN_BATTLEGROUNDS_SCORE = "%s Punkte",
	PATTERN_BATTLEGROUNDS_WEEKEND = "%s Wochenende",
}
 
HonorFuLocals.CMD_OPTIONS = {
	{
		option = HonorFuLocals.ARGUMENT_AUTORELEASE,
		desc = "Automatische Freigabe, wenn man im Schlachtfeld gestorben ist.",
		method = "ToggleAutoReleasing",
	},
	{
		option = HonorFuLocals.ARGUMENT_BGMAP,
		desc = "Minischlachtfeldkarte automatisch \195\182ffnen.",
		method = "ToggleShowingBGMap",
	},
	{
		option = HonorFuLocals.ARGUMENT_TARGETFLAG,
		desc = "Gegnerischen Flaggentr\195\164ger ins Ziel nehmen. (auch /tflag oderr /tarflag)",
		method = "TargetFlag",
	},
	{
		option = HonorFuLocals.ARGUMENT_RESETBG,
		desc = "Schlachtfeldpunkte zu\195\188cksetzen auf 0-0.",
		method = "ResetBGScores",
	},
	{
		option = HonorFuLocals.ARGUMENT_PRINTREPGAIN,
		desc = "Erhalten von PvP-Ruf im Chatfenster ausgeben.",
		method = "TogglePrintingReputationGains",
	},
	{
		option = HonorFuLocals.ARGUMENT_PRINTHONORGAIN,
		desc = "Erhalten von Ehre im Chatfenster ausgeben.",
		method = "TogglePrintingHonorGains",
	},
	{
		option = HonorFuLocals.ARGUMENT_SHOWBGSCORE,
		desc = "Anzeigen der Schlachtfeldpunkte im Textfeld.",
		method = "ToggleShowBGScore"
	},
	{
		option = HonorFuLocals.ARGUMENT_SHOWKILLSDEATHS,
		desc = "Anzeigen der Kills und Tode im Textfeld.",
		method = "ToggleShowKillsDeaths"
	},
}
 
end
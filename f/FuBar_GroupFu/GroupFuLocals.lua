if not ace:LoadTranslation("GroupFu") then

GroupFuLocals = {
	NAME = "FuBar - GroupFu",
	DESCRIPTION = "Combination of Titan LootType and Roll.",
	
	DEFAULT_ICON = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",

	TEXT_SOLO = "Solo",
	TEXT_GROUP = "Group",
	TEXT_FFA = "Free for All",
	TEXT_MASTER = "Master Looter",
	TEXT_NBG = "Need Before Greed",
	TEXT_RR = "Round Robin",
	TEXT_NOROLLS = "No Rolls",
	
	TEXT_ENDING10 = "Roll ending in 10",
	TEXT_ENDING5 = "Roll ending in 5",
	TEXT_ENDING4 = "Roll ending in 4",
	TEXT_ENDING3 = "Roll ending in 3",
	TEXT_ENDING2 = "Roll ending in 2",
	TEXT_ENDING1 = "Roll ending in 1",
	TEXT_ENDED = "Rolling over announcing winner.",
	
	
	SEARCH_MASTERLOOTER = "(.+) is now the loot master.",
	SEARCH_ROLLS = "(.+) rolls (%d+) %((%d+)%-(%d+)%)",
	
	FORMAT_ANNOUNCE_WIN = "Winner: %s [%d] out of %d rolls.",
	FORMAT_TEXT_ROLLCOUNT = "%s (%d/%d)",
	FORMAT_TOOLTIP_ROLLCOUNT = "%d of expected %d rolls recorded",

	MENU_SHOWMLNAME = "Show Master Looter Name",
	MENU_PERFORMROLL = "Perform roll when clicked",
	MENU_SHOWROLLCOUNT = "Show count of rolls recorded ie <# rolls>/<# player in raid/party>",
	MENU_ANNOUNCEROLLCOUNTDOWN = "Announce count down and display winner when roll clearing timer reached",

	MENU_OUTPUT = "Output Location",
	MENU_OUTPUT_AUTO = "Output results based on being in Raid, Group, or Solo",
	MENU_OUTPUT_LOCAL = "Output results to Local Screen",
	MENU_OUTPUT_SAY = "Output results to the Say channel",
	MENU_OUTPUT_PARTY = "Output results to the Party channel",
	MENU_OUTPUT_RAID = "Output results to the Raid channel",
	MENU_OUTPUT_GUILD = "Output results to the Guild channel",

	MENU_CLEAR = "Automatic Roll Clearing",
	MENU_CLEAR_NEVER = "Never",
	MENU_CLEAR_15SEC = "15 seconds",
	MENU_CLEAR_30SEC = "30 seconds",
	MENU_CLEAR_45SEC = "45 seconds",
	MENU_CLEAR_60SEC = "60 seconds",

	MENU_DETAIL = "Output Detail",
	MENU_DETAIL_SHORT = "Display winner only",
	MENU_DETAIL_LONG = "Display all rolls",
	MENU_DETAIL_FULL = "Display all rolls, along with non-standard roll info",
	
	MENU_MODE = "Text Mode",
	MENU_MODE_GROUPFU = "GroupFu: Loot type, unless a roll is active then the winner of the roll",
	MENU_MODE_ROLLSFU = "RollFu: No Rolls, unless a roll is active then the winner of the roll",
	MENU_MODE_LOOTTYFU = "LootTyFu: Loot type always",

	MENU_STANDARDROLLSONLY = "Accept standard (1-100) rolls only",
	MENU_IGNOREDUPES = "Ignore duplicate rolls",
	MENU_AUTODELETE = "Auto-delete rolls after output",
	MENU_SHOWCLASSLEVEL = "Show Class and Level in tooltip",
	
	MENU_GROUP = "Group Functions",
	MENU_GROUP_LEAVE = "Leave Group",
	MENU_GROUP_RAID = "Convert Group to Raid",
	MENU_GROUP_LOOT = "Change Looting Method",
	MENU_GROUP_THRESHOLD = "Change Loot Threshold",
	MENU_GROUP_RESETINSTANCE = "Reset Instance",
	
	TOOLTIP_CAT_LOOTING = "Looting",
	TOOLTIP_CAT_ROLLS = "Rolls",
	TOOLTIP_METHOD = "Looting Method",
	TOOLTIP_HINT_ROLLS = "Click to roll, Ctrl-Click to output winner, Shift-Click to clear the list",
	TOOLTIP_HINT_NOROLLS = "Ctrl-Click to output winner, Shift-Click to clear the list",

	ENDENLOCALE = true
}

end

if not ace:LoadTranslation("DurabilityFu") then

DurabilityFuLocals = {
	NAME = "FuBar - DurabilityFu",
	DESCRIPTION = "Keeps track of durability and pops up a dialog to repair when you go to a vendor who can.",
	COMMANDS = {"/durfu", "/durabilityfu"},
	CMD_OPTIONS = {},
	
	TEXT_TOTAL = "Total",
	TEXT_PERCENT = "Percent",
	TEXT_REPAIR_COST = "Repair cost",
	TEXT_INVENTORY = "Inventory",
	TEXT_EQUIPMENT = "Equipment",
	TEXT_REPAIR = "Repair",
	
	ARGUMENT_POPUP = "popup",
	ARGUMENT_SHOWMAN = "showMan",
	ARGUMENT_AVERAGE = "average",
	ARGUMENT_HEALTHY = "healthy",
	ARGUMENT_AUTOREPAIREQUIP = "autoRepairEquip",
	ARGUMENT_AUTOREPAIRINV = "autoRepairInv",
	
	MENU_SHOW_POPUP = "Show repair popup at vendor",
	MENU_SHOW_ARMORED_MAN = "Show the armored man",
	MENU_SHOW_AVERAGE_VALUE = "Show average value",
	MENU_SHOW_HEALTHY_ITEMS = "Show healthy items",
	MENU_AUTO_REPAIR = "Auto repair",
}

DurabilityFuLocals.CMD_OPTIONS = {
	{
		option = DurabilityFuLocals.ARGUMENT_POPUP,
		desc = "Toggle whether to show the popup at the merchant window.",
		method = "ToggleShowingPopup"
	},
	{
		option = DurabilityFuLocals.ARGUMENT_SHOWMAN,
		desc = "Toggle whether to show Blizzard's armored man.",
		method = "ToggleShowingMan"
	},
	{
		option = DurabilityFuLocals.ARGUMENT_AVERAGE,
		desc = "Toggle whether to show your average or minimum durability.",
		method = "ToggleShowingAverage"
	},
	{
		option = DurabilityFuLocals.ARGUMENT_HEALTHY,
		desc = "Toggle whether to show items that are healthy (100% repaired).",
		method = "ToggleShowingHealthyItems"
	},
}

end
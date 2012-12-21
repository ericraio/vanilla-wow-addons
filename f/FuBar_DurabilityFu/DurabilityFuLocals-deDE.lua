function DurabilityFu_Locals_deDE()

DurabilityFuLocals = {
	NAME = "FuBar - DurabilityFu",
	DESCRIPTION = "Beobachtet die Haltbarkeit der Ausr\195\188stung und zeigt bei geeigneten H\195\164ndlern ein Reparaturfenster..",
	COMMANDS = {"/durfu", "/durabilityfu"},
	CMD_OPTIONS = {},
	
	TEXT_TOTAL = "Gesamt",
	TEXT_PERCENT = "Prozent",
	TEXT_REPAIR_COST = "Reparaturkosten",
	TEXT_INVENTORY = "Inventar",
	TEXT_EQUIPMENT = "Ausr\195\188stung",
	TEXT_REPAIR = "Reparatur",
	
	ARGUMENT_POPUP = "popup",
	ARGUMENT_SHOWMAN = "showMan",
	ARGUMENT_AVERAGE = "average",
	ARGUMENT_HEALTHY = "healthy",
	
	MENU_SHOW_POPUP = "Reparaturfenster beim H\195\164ndler anzeigen",
	MENU_SHOW_ARMORED_MAN = "Ausr\195\188stungsfigur anzeigen",
	MENU_SHOW_AVERAGE_VALUE = "Mittelwert anzeigen",
	MENU_SHOW_HEALTHY_ITEMS = "Unbesch\195\164digte Gegenst\195\164nde anzeigen",
	MENU_AUTO_REPAIR = "Automatisch reparieren",
}

DurabilityFuLocals.CMD_OPTIONS = {
	{
		option = DurabilityFuLocals.ARGUMENT_POPUP,
		desc = "Anzeige des Reparaturfensters beim Händler ein/ausschalten.",
		method = "ToggleShowingPopup"
	},
	{
		option = DurabilityFuLocals.ARGUMENT_SHOWMAN,
		desc = "Anzeige der Ausr\195\188stungsfigur ein/ausschalten.",
		method = "ToggleShowingMan"
	},
	{
		option = DurabilityFuLocals.ARGUMENT_AVERAGE,
		desc = "Anzeige zwischen mittlerer oder minimaler Haltbarkeit umschalten.",
		method = "ToggleShowingAverage"
	},
	{
		option = DurabilityFuLocals.ARGUMENT_HEALTHY,
		desc = "Anzeige unbesch\195\164digter Gegenst\195\164nde ein/ausschalten.",
		method = "ToggleShowingHealthyItems"
	},
}

end
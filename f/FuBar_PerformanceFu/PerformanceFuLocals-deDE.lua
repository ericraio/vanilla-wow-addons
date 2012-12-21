function PerformanceFu_Locals_deDE()

PerformanceFuLocals = {
	NAME = "FuBar - PerformanceFu",
	DESCRIPTION = "Protokolliert technische Leistungsdaten.",
	COMMANDS = {"/perffu", "/performancefu"},
	CMD_OPTIONS = {},
	
	ARGUMENT_FRAMERATE = "framerate",
	ARGUMENT_LATENCY = "latency",
	ARGUMENT_MEMORY = "memory",
	ARGUMENT_SHOWRATE = "showRate",
	ARGUMENT_WARNGC = "warnGC",
	ARGUMENT_FORCEGC = "forceGC",
	
	MENU_SHOW_FRAMERATE = "Bildwiederholrate anzeigen",
	MENU_SHOW_LATENCY = "Latenz anzeigen",
	MENU_SHOW_MEMORY = "Speicherverbrauch anzeigen",
	MENU_SHOW_INCREASING_MEMORY_USAGE = "Ver\195\164nderung des Speicherverbrauchs anzeigen",
	MENU_FORCE_GC = "Erzwinge Abfallsammler",
	MENU_WARN_ON_GC = "Warnung bei Abfallsammler",
	
	TEXT_FRAMERATE = "Wiederholrate",
	TEXT_NETWORK_STATUS = "Netzwerkstatus",
	TEXT_LATENCY = "Latenz",
	TEXT_BANDWIDTH_IN = "Eingehende Bandbreite",
	TEXT_BANDWIDTH_OUT = "Ausgehende Bandbreite",
	TEXT_MEMORY_USAGE = "Speicherverbrauch",
	TEXT_CURRENT_MEMORY = "Aktueller Speicher",
	TEXT_INITIAL_MEMORY = "Speicher zu Beginn",
	TEXT_CURRENT_INCREASING_RATE = "Aktuelle Steigerungsrate",
	TEXT_AVERAGE_INCREASING_RATE = "Mittlere Steigerungsrate",
	TEXT_GARBAGE_COLLECTION = "Abfallsammler",
	TEXT_THRESHOLD = "Grenzwert",
	TEXT_TIME_TO_NEXT = "Zeit bis zum n\195\164chsten",
	
	PATTERN_GARBAGE_COLLECTION_IN_TIME = "Abfallsammler in %s",
	TEXT_GARBAGE_COLLECTION_OCCURED = "Abfallsammler aktiviert",
}

PerformanceFuLocals.CMD_OPTIONS = {
	{
		option = PerformanceFuLocals.ARGUMENT_FRAMERATE,
		desc = "Anzeige der Wiederholrate ein/ausschalten.",
		method = "ToggleShowingFramerate"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_LATENCY,
		desc = "Anzeige der Latenz ein/ausschalten.",
		method = "ToggleShowingLatency"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_MEMORY,
		desc = "Anzeige des aktuellen Speicherverbrauchs ein/ausschalten.",
		method = "ToggleShowingMemory"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_SHOWRATE,
		desc = "Anzeige der aktuellen Steigerung des Speicherverbrauchs ein/ausschalten.",
		method = "ToggleShowingRate"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_WARNGC,
		desc = "Warnung vor Abfallsammler ein/ausschalten.",
		method = "ToggleWarningOnGC"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_FORCEGC,
		desc = "Erzwinge die Durchf\195\188hrung der Abfallsammlung.",
		method = "ForceGC"
	},
}

end
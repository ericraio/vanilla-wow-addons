if not ace:LoadTranslation("PerformanceFu") then

PerformanceFuLocals = {
	NAME = "FuBar - PerformanceFu",
	DESCRIPTION = "Keeps track of performance.",
	COMMANDS = {"/perffu", "/performancefu"},
	CMD_OPTIONS = {},
	
	ARGUMENT_FRAMERATE = "framerate",
	ARGUMENT_LATENCY = "latency",
	ARGUMENT_MEMORY = "memory",
	ARGUMENT_SHOWRATE = "showRate",
	ARGUMENT_WARNGC = "warnGC",
	ARGUMENT_FORCEGC = "forceGC",
	
	MENU_SHOW_FRAMERATE = "Show framerate",
	MENU_SHOW_LATENCY = "Show latency",
	MENU_SHOW_MEMORY = "Show memory",
	MENU_SHOW_INCREASING_MEMORY_USAGE = "Show increasing memory usage",
	MENU_FORCE_GC = "Force garbage collection",
	MENU_WARN_ON_GC = "Warn on garbage collection",
	
	TEXT_FRAMERATE = "Framerate",
	TEXT_NETWORK_STATUS = "Network status",
	TEXT_LATENCY = "Latency",
	TEXT_BANDWIDTH_IN = "Bandwidth in",
	TEXT_BANDWIDTH_OUT = "Bandwidth out",
	TEXT_MEMORY_USAGE = "Memory usage",
	TEXT_CURRENT_MEMORY = "Current memory",
	TEXT_INITIAL_MEMORY = "Initial memory",
	TEXT_CURRENT_INCREASING_RATE = "Current increasing rate",
	TEXT_AVERAGE_INCREASING_RATE = "Average increasing rate",
	TEXT_GARBAGE_COLLECTION = "Garbage collection",
	TEXT_THRESHOLD = "Threshold",
	TEXT_TIME_TO_NEXT = "Time to next",
	
	PATTERN_GARBAGE_COLLECTION_IN_TIME = "Garbage collection in %s",
	TEXT_GARBAGE_COLLECTION_OCCURED = "Garbage collection occurred",
}

PerformanceFuLocals.CMD_OPTIONS = {
	{
		option = PerformanceFuLocals.ARGUMENT_FRAMERATE,
		desc = "Toggle whether to framerate.",
		method = "ToggleShowingFramerate"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_LATENCY,
		desc = "Toggle whether to latency (lag).",
		method = "ToggleShowingLatency"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_MEMORY,
		desc = "Toggle whether to show current memory usage.",
		method = "ToggleShowingMemory"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_SHOWRATE,
		desc = "Toggle whether to show increasing rate of memory.",
		method = "ToggleShowingRate"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_WARNGC,
		desc = "Toggle whether to warn on an upcoming garbage collection.",
		method = "ToggleWarningOnGC"
	},
	{
		option = PerformanceFuLocals.ARGUMENT_FORCEGC,
		desc = "Force a garbage collection to happen.",
		method = "ForceGC"
	},
}

end
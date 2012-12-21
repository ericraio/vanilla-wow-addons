
-- Make sure this file is loaded after the main localisation file
local mod = thismod

mod.string.data["enUS"] = 
{
	print = 
	{
		core = 
		{
			startupmessage = "KLHPerformanceMonitor Release |cff33ff33%s|r Revision |cff33ff33%s|r loaded.",
			
			-- These shouldn't be overridden
			header = "|cffff00ffKPM: |r",
			frame = "KLHPM_Frame",
			modname = "KLHPerformanceMonitor",
		},
		console = 
		{
			-- These don't need to be overridden
			short = "/kpm",
			medium = "/klhpm",
			long = "/klhperformancemonitor",
		},
	},
}

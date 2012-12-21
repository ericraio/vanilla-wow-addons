if not ace:LoadTranslation("DamageMetersFu") then

DamageMetersFuLocals = {
	-- Basics
	NAME = "FuBar - DamageMetersFu",
	DESCRIPTION = "Damage meters control and information.",
	COMMANDS = {"/dmfu", "/damagemetersfu"},
	CMD_OPTIONS = {},
	
	-- Slash command arguments
	ARGUMENT_CLEAR = "clear",
	ARGUMENT_PAUSE = "pause",
	ARGUMENT_RESET_POSITION = "resetpos",
	
	-- Orphans
	TEXT = "Damage Meters",
	SHORT_TEXT = "DM",
	HINT = "Click to toggle the DamageMeters window.",
	
	-- Menu Values
	MENU_DISPLAY_NONE = "Display None",
	MENU_SHORT_DISPLAY = "Brief Label Text",
	MENU_COLOR_DISPLAY = "Show Colored Values",
	MENU_USE_DM_COLORS = "Use DM Colors", 
	MENU_VALUE = "Values", 
	MENU_RANK = "Ranks", 
	MENU_LEADER = "Leaders",
	MENU_RESET_POSITION = "Reset Position",
	MENU_PAUSE = "Pause Parsing",
	MENU_CLEAR = "Clear",
	
	DAMAGEMETERS_MISSING = "DamageMeters N/A",
	DAMAGEMETERS_MISSING_DESC = "Please install DamageMeters before attempting to use this addon.",
	DAMAGEMETERS_QUANT = {} 
}

-- Versioning and backwards compatibility with 4.2.1
if ( DamageMeters_VERSION == 4500 ) then 
	DamageMetersFuLocals.DAMAGEMETERS_QUANT = {
			[1] = { name = "Damage Done", abbr = "D", color = 'FF0000' }, 
			[2] = { name = "Healing Done", abbr = "H", color = '00FF00' },
			[3] = { name = "Damage Taken", abbr = "DT", color = 'FF7F00' }, 
			[4] = { name = "Healing Taken", abbr = "HT", color = '00B24C' },
			[5] = { name = "Curing Done", abbr = "Cu", color = '99B2CC' },
			[6] = { name = "Overheal Done", abbr = "Oh", color = 'FFFF00' },
			[7] = { name = "Raw Healing Done", abbr = "RawHD", color = 'FF00FD' },
			[8] = { name = "Damage Per/sec", abbr = "DPS", color = '8428E0' }, 
			[9] = { name = "Healing Per/sec", abbr = "HPS", color = '33E57F' }, 
			[10] = { name = "Damage Taken Per/sec", abbr = "DTPS", color = 'FFB233' }, 
			[11] = { name = "Healing Taken Per/sec", abbr = "HTPS", color = '00CCCC' }, 
			[12] = { name = "Cures Per/sec", abbr = "CuPS", color = '667FF9' }, 
			[13] = { name = "Overheal Per/sec", abbr = "OHPS", color = '666600' },
			[14] = { name = "Raw Healing Per/sec", abbr = "RawHPS", color = 'CC00CA' },
			[15] = { name = "Idle Time", abbr = "IT", color = '0000FF' },
			[16] = { name = "Net Damage", abbr = "NetD", color = '7F0000' }, 
			[17] = { name = "Net Healing", abbr = "NetH", color = '007F00' }, 
			[18] = { name = "Damage+Healing", abbr = "D+H", color = '7F7F7F' },
			[19] = { name = "Health", abbr = "H", color = '804DB2' },
			[20] = { name = "Overheal Percent", abbr = "Oh%", color = '8080B2' }
	}
else 
	DamageMetersFuLocals.DAMAGEMETERS_QUANT = {
		[1] = { name = "Damage Done", abbr = "D", color = 'FF0000' }, 
		[2] = { name = "Healing Done", abbr = "H", color = '00FF00' },
		[3] = { name = "Damage Taken", abbr = "DT", color = 'FF7F00' }, 
		[4] = { name = "Healing Taken", abbr = "HT", color = '00B24C' },
		[5] = { name = "Curing Done", abbr = "Cu", color = '99B2CC' },
		[6] = { name = "Damage Per/sec", abbr = "DPS", color = '8428E0' }, 
		[7] = { name = "Healing Per/sec", abbr = "HPS", color = '33E57F' }, 
		[8] = { name = "Damage Taken Per/sec", abbr = "DTPS", color = 'FFB233' }, 
		[9] = { name = "Healing Taken Per/sec", abbr = "HTPS", color = '00CCCC' }, 
		[10] = { name = "Cures Per/sec", abbr = "CuPS", color = '667FF9' }, 
		[11] = { name = "Idle Time", abbr = "IT", color = '0000FF' },
		[12] = { name = "Net Damage", abbr = "NetD", color = '7F0000' }, 
		[13] = { name = "Net Healing", abbr = "NetH", color = '007F00' }, 
		[14] = { name = "Damage+Healing", abbr = "D+H", color = '7F7F7F' }
	}
end


DamageMetersFuLocals.CMD_OPTIONS = {
	{
		option = DamageMetersFuLocals.ARGUMENT_CLEAR,
		desc = "Clear your local DamageMeters data.",
		method = "DMClear"
	},
	{
		option = DamageMetersFuLocals.ARGUMENT_PAUSE,
		desc = "Toggle whether to pause/unpause DamageMeters parsing.",
		method = "DMTogglePause"
	},
	{
		option = DamageMetersFuLocals.ARGUMENT_RESET_POSITION,
		desc = "Reset the DamageMeters window position",
		method = "DMResetPos"
	},
}
end
PERFECTRAID = {}
PERFECTRAID.CURSE 		= "Curse"
PERFECTRAID.MAGIC 		= "Magic"
PERFECTRAID.POISON 		= "Poison"
PERFECTRAID.DISEASE 	= "Disease"
PERFECTRAID.FEIGNDEATH 	= "Feign Death"
PERFECTRAID.GHOST 		= "Ghost"
PERFECTRAID.SOULSTONE	= "Soulstone Resurrection"

PERFECTRAID.COLORS = {}
PERFECTRAID.COLORS["Curse"] 		= "|cFFCC0000Cu |r"
PERFECTRAID.COLORS["Magic"] 		= "|cFF660099Ma |r"
PERFECTRAID.COLORS["Poison"] 		= "|cFF006600Po |r"
PERFECTRAID.COLORS["Disease"] 		= "|cFF666600Di |r"
PERFECTRAID.COLORS["LowMana"] 		= "|cFFFFFF00Mana |r"
PERFECTRAID.COLORS["FeignDeath"]	= "|cFF00E6C6FD |r"
PERFECTRAID.COLORS["Soulstone"]		= "|cFFCA21FFSS |r"
PERFECTRAID.COLORS["Innervate"]		= "|cFF00FF33Inn |r"
PERFECTRAID.COLORS["PowerInfusion"]	= "|cFF00FF33PwI |r"

PERFECTRAID.CLASSES = {}
PERFECTRAID.CLASSES["PALADIN"] 	= "|cFFF48CBA"
PERFECTRAID.CLASSES["WARRIOR"] 	= "|cFFC69B6D"
PERFECTRAID.CLASSES["WARLOCK"] 	= "|cFF9382C9"
PERFECTRAID.CLASSES["PRIEST"] 	= "|cFFFFFFFF"
PERFECTRAID.CLASSES["DRUID"] 	= "|cFFFF7C0A"
PERFECTRAID.CLASSES["MAGE"]		= "|cFF68CCEF"
PERFECTRAID.CLASSES["ROGUE"]	= "|cFFFFF468"
PERFECTRAID.CLASSES["SHAMAN"]	= "|cFFF48CBA"
PERFECTRAID.CLASSES["HUNTER"]	= "|cFFAAD372"

PERFECTRAID.CHAT_COMMANDS 	= { "/perfectraid", "/praid"}
PERFECTRAID.CHAT_OPTIONS 	= {
	{
		option	= "align",
		desc	= "Changes the alignment of the raid frames",
		input	= TRUE,
		method	= "Align",
		args 	= {
			{	
				option 	= "left",
				desc	= "Aligns the frames for a left-sided display.",
			},
			{	
				option	= "right",
				desc	= "Aligns the frames for a right-sided display.",
			},
		},
	},
	{
		option	= "hide",
		desc	= "Hides the frames.",
		method	= "Hide",
	},
	{
		option	= "show",
		desc	= "Shows the frames.",
		method	= "Show",
	},
	{
		option	= "reset",
		desc	= "Resets all options to default (including location).",
		method	= "Reset",
	},
	{
		option	= "truncate",
		desc	= "Toggles between truncating names, and expanding to fit them.",
		method	= "Truncate",
	},
	{
		option	= "backdrop",
		desc	= "Sets the backdrop frame's alpha.",
		method	= "SetBackdrop",
		input 	= TRUE,
		args	= {
			{
				option	= "bar",
				desc	= "Sets the backdrop of the status bars. Usage: /praid bar backdrop r g b a",
				input 	= TRUE,
			},
			{
				option	= "frame",
				desc	= "Sets the backdrop of the PerfectRaid frame. Usage: /praid bar backdrop r g b a",
				input	= TRUE,
			},
		},
	},	
	{
		option	= "manathreshold",
		desc	= "Changes the \"Low Mana\" threshold (in percent 0-100).",
		input	= TRUE,
		method	= "SetLowMana",
	},
	{
		option	= "scale",
		desc	= "Changes the Scaling of the frames (0.1 - 2.0)",
		input	= TRUE,
		method	= "SetScale",
	},
	{
		option	= "voffset",
		desc	= "Changes the seperator between sorted groups/classes (Negative numbers move frames down)",
		input	= TRUE,
		method	= "SetVoffset",
	},
	{
		option	= "sort",
		desc	= "Changes the sort order of the frames.",
		input	= TRUE,
		method	= "Sort",
		args	= {
			{
				option	= "class",
				desc	= "Sorts by class name.",
			},
			{
				option	= "group",
				desc	= "Sorts by group number, then by player name.",
			},
			{
				option	= "raid",
				desc	= "Sorts by raid id (not very useful).",
			},
			{
				option	= "name",
				desc	= "Sorts by player name.",
			},
			{
				option	= "groupclass",
				desc	= "Sorts by group number, then by class name.",
			},
		},
	},
	{
		option	= "select",
		desc	= "Allows you to highlight a portion of the raid",
		input	= TRUE,
		method	= "Select",
		args	= {
			{
				option	= "group",
				desc	= "Selects all members of a raid group. Must specify group number.",
				input 	= TRUE,
			},
			{
				option	= "class",
				desc	= "Selects all members of a specific class.  Must specify class",
				input 	= TRUE
			},
			{
				option	= "all",
				desc	= "Selects all members of the raid.",
			},
			{
				option	= "none",
				desc	= "Removes all selections.",
			},
			{
				option	= "number",
				desc	= "Shows each raid member's group number.",
			},
		},
	},
	{
		option	= "need",
		desc	= "Sorts the raid by who has the most NEED for something",
		input	= TRUE,
		method	= "SortNeed",
		args	= {
			{
				option	= "off",
				desc	= "Turns need mode off, and sorts by default sort order.",
			},
			{
				option	= "heal",
				desc	= "Sorts by missing hit points, descending.",
				input 	= TRUE
			},
			{
				option	= "curse",
				desc	= "Sorts by those members who are cursed.",
			},
			{
				option	= "magic",
				desc	= "Sorts by those members who have a magic debuff.",
			},
			{
				option	= "disease",
				desc	= "Sorts by those members who have a disease.",
			},
			{
				option	= "poison",
				desc	= "Sorts by those members who have a poison debuff.",
			},
			{
				option	= "anycure",
				desc	= "Sorts by those members who have a debuff you can cure.",
			},
		},
	},
	{
		option	= "filter",
		desc	= "Filter debuffs to only those you can cure",
		method	= "ToggleFilter",
	},
	{
		option	= "rangecheck",
		desc	= "When casting spells, makes units you can't target slightly transparent.",
		method	= "ToggleRangeCheck",
	},
}
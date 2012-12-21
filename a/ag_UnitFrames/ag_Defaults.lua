aUF_DEFAULT_OPTIONS = {
	Version = "dd-mm-yy",

	RaidHideParty = true,
	
	Locked = false,
	
	RaidColorName = false,	
	
	HighlightSelected = true,	
	
	ShowPvPIcon = false,
	ShowGroupIcons = true,

	TargetShowHostile = true,	
	SmoothHealthBars = true,

	RaidGrouping = "subgroup",
	PartyGrouping = "withplayer",
	PetGrouping = "withplayer",
	
	BorderStyle = "Hidden",
	BarStyle = "Default",

	HealthColor = {
		r = 0.41,
		g = 0.95,
		b = 0.2,
	},
	
	ManaColor = {
		[0] = { b = 0.84, g = 0.52, r = 0.28}, -- Mana
		[1] = { r = 226/255, g = 45/255, b = 75/255}, -- Rage
		[2] = { r = 255/255, g = 210/255, b = 0}, -- Focus
		[3] = { r = 255, g = 220/255, b = 25/255}, -- Energy
		[4] = { r = 0.00, g = 1.00, b = 1.00} -- Happiness
	},
	
	PartyFrameColors = {
		r = 0,
		g = 0,
		b = 0,
		a = 0.5},
	TargetFrameColors = {
		r = 0,
		g = 0,
		b = 0,
		a = 0.5},
	FrameBorderColors = {
		r = TOOLTIP_DEFAULT_COLOR.r,
		g = TOOLTIP_DEFAULT_COLOR.g,
		b = TOOLTIP_DEFAULT_COLOR.b,
		c = 0.7},
	
	BlizFramesVisibility = {
		["HidePlayerFrame"] = true,
		["HidePartyFrame"] = true,
		["HideTargetFrame"] = true
	},
	
	["player"] = {	
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",		
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
		
		["FrameStyle"] = "ABF",
		["AuraStyle"] = "TwoLines",
		["AuraPos"] = "Right",
		["AuraFilter"] = 1,
		["AuraDebuffC"] = true,
		["ShowCombat"] = false,
		["ShowXP"] = true,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,		
		["Scale"] = 1,
		["RaidColorName"] = false,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 141,
	},

	["party"] = {	
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",			
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
		
		["FrameStyle"] = "ABF",
		["AlwaysShow"] = false,
		["AuraStyle"] = "TwoLines",
		["AuraPos"] = "Right",
		["AuraFilter"] = 1,
		["AuraDebuffC"] = true,
		["ShowCombat"] = false,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,	
		["Scale"] = 1,
		["RaidColorName"] = false,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 141,		
	},
	
	["partypet"] = {	
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",		
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
		
		["FrameStyle"] = "ABF",
		["AuraStyle"] = "OneLine",	
		["AuraPos"] = "Right",
		["HideMana"] = true,		
		["AuraFilter"] = 1,
		["AuraDebuffC"] = true,
		["ShowCombat"] = false,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,			
		["Scale"] = 1,
		["RaidColorName"] = false,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 141,		
	},

	["pet"] = {	
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",		
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
		
		["FrameStyle"] = "ABF",
		["AuraStyle"] = "OneLine",	
		["AuraPos"] = "Right",
		["AuraFilter"] = 1,
		["AuraDebuffC"] = true,
		["ShowCombat"] = false,
		["ShowXP"] = true,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,			
		["Scale"] = 1,		
		["RaidColorName"] = false,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 141,		
	},

	["raid"] = {
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",	
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
		
		["FrameStyle"] = "ABF",
		["AuraStyle"] = "OneLine",
		["AuraPos"] = "Right",
		["AuraFilter"] = 1,
		["AuraDebuffC"] = true,
		["HideMana"] = true,
		["HideFrame"] = true,
		["ShowCombat"] = false,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,			
		["Scale"] = 0.85,
		["RaidColorName"] = true,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 110,		
	},

	["raidpet"] = {	
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",		
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
		
		["FrameStyle"] = "ABF",
		["AuraStyle"] = "OneLine",
		["AuraPos"] = "Right",
		["AuraFilter"] = 1,
		["AuraDebuffC"] = true,
		["HideMana"] = true,
		["HideFrame"] = true,
		["ShowCombat"] = false,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,			
		["Scale"] = 0.85,
		["RaidColorName"] = false,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 110,		
	},
	
	["target"] = {	
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",		
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
		
		["FrameStyle"] = "ABF",
		["AuraStyle"] = "TwoLines",	
		["AuraPos"] = "Below",
		["AuraFilter"] = 0,
		["AuraDebuffC"] = false,
		["ShowCombat"] = false,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,		
		["Scale"] = 1,
		["RaidColorName"] = false,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 141,		
	},

	["targettarget"] = {	
		["HealthFormat"] = "[curhp]/[maxhp]",
		["ManaFormat"] = "[curmana]/[maxmana]",
		["HealthStyle"] = "Absolute",
		["ManaStyle"] = "Absolute",	
		["NameStyle"] = "Default",
		["ClassStyle"] = "Default",	
		["NameFormat"] = "",
		["ClassFormat"] = "",
				
		["FrameStyle"] = "ABF",
		["AuraStyle"] = "TwoLines",
		["AuraPos"] = "Below",
		["AuraFilter"] = 0,
		["AuraDebuffC"] = true,
		["HideMana"] = true,
		["ShowCombat"] = false,
		["LongStatusbars"] = false,
		["ClassColorBars"] = false,			
		["Scale"] = 0.85,
		["RaidColorName"] = true,
		["ShowRaidTargetIcon"] = true,
		["ShowInCombatIcon"] = true,
		["Width"] = 141,
	},

	Positions = {
		["player"] = {
			["x"] = 10,
			["y"] = -5,
		},
		["pet"] = {
			["x"] = 10,
			["y"] = -100,
		},		
		["target"] = {
			["x"] = 250,
			["y"] = -5,
		},
		["targettarget"] = {
			["x"] = 385,
			["y"] = -5,
		},		
		["party1"] = {
			["x"] = 10,
			["y"] = -65,
		},
		["party2"] = {
			["x"] = 10,
			["y"] = -115,
		},
		["party3"] = {
			["x"] = 10,
			["y"] = -165,
		},
		["party4"] = {
			["x"] = 10,
			["y"] = -215,
		},
		["partyPlayer_aUFgroup"] = {
			["x"] = 10,
			["y"] = -5,
		},
	},
--.--.--.--.--.--.--.--.--	
  -- Old stuff below! --	
--.--.--.--.--.--.--.--.-- 	
	
	--[[Scaling = {
		["UseMGScale"] = 0,
		["MGScale"] = 1,
		["UseRaidScale"] = 1,
		["RaidScale"] = 0.75,				
	},
	
	DebuffOrder = {
		[1] = "Magic",
		[2] = "Poison",
		[3] = "Disease",
		[4] = "Curse",
		[5] = "None"
	},
	
	DebuffColors = {
		["Magic"] = {r = 0.5, g = 0.5, b = 0.75, c = "!"},
		["Poison"] = {r = 0.75, g = 0, b = 0, c = "$"},
		["Disease"] = {r = 1, g = 1, b = 0, c = "^"},
		["Curse"] = {r = 1, g = 0.5, b = 0, c = "@"},
		["None"] = {r = 1.0, g = 0.82, b = 0, c = ""}
	},
	

	Anchors = {
		["MGraid_achor1"] = nil,
		["MGraid_achor2"] = "MGraid_achor1",
		["MGraid_achor3"] = "MGraid_achor2",
		["MGraid_achor4"] = "MGraid_achor3",
		["MGraid_achor5"] = "MGraid_achor4",
		["MGraid_achor6"] = "MGraid_achor5",		
		["MGraid_achor7"] = "MGraid_achor6",
		["MGraid_achor8"] = "MGraid_achor7"
	},

	RaidByClass = 0,
	ShowAnchors = 1,
	HideAnchorBackgrounds = 1,
	ShowMapButton = 1,	
	LockMGFrames = 1,
	CastPartyEnabled = 1,
	CastPartyTargetEnabled = 1,
	AlphaBorder = 0,
	IconPosition = 188,	
	CastPartyOverrideMouse = 2,
	CastPartyOverrideAlt = 0,
	CastPartyOverrideCtrl = 0,
	CastPartyOverrideShift = 0,	
	ShowClassText = 1,
	ShowEndcaps = 0,
	UsePartyRaidColors = 1,
	RaidHideParty = 1,
	RaidColorName = 0,	
	FrameGrowth = 1,		
	PartyPetGrouping = 4,
	PartyGrouping = 0,	
	RestIndicator = 2,
	FlashRestIndicator = 1,
	CombatIndicator = 2,
	FlashCombatIndicator = 1,
	AggroIndicator = 2,
	FlashAggroIndicator = 1,	
	GroupSpace = 1,]]
}

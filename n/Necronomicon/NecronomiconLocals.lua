BINDING_HEADER_NECRONOMICON = "Necronomicon"
-- This statement will load any translation that is present or default to English.
if( not ace:LoadTranslation("Necronomicon") ) then

	NECRONOMICON_MSG_COLOR		= "|cffcceebb";
	NECRONOMICON_DISPLAY_OPTION	= "[|cfff5f530%s|cff0099CC]";

	NECRONOMICON_CONST = {

		Title   		= "Necronomicon",
		Version 		= "0.7",
		Desc    		= "Necronomicon, Ace'd Necrosis",
		Timerheader		= "Spell Timers",
		UpdateInterval		= 0.2,
	
		ChatCmd		= {"/necro", "/necronomicon", "/Necronomicon"},
		
		ChatOpt 		= {
			{	
				option	= "reset",
				desc	= "Reset the window positions.",
				method	= "chatReset",
			},
			{
				option  = "feldom",
				desc	= "Set the Fel Domination modifier: ctrl alt shift none",
				method  = "chatFelDom",
			},
			{
				option  = "closeonclick",
				desc    = "Toggle closing the pet menu on clicking a button",
				method  = "chatCloseClick",
			},
			{
				option  = "soulstonesound",
				desc    = "Toggle playing of soulstone expired sound",
				method  = "chatSoulstoneSound",
			},
			{
				option  = "shadowtrancesound",
				desc    = "Toggle playing of nightfall proc sound",
				method  = "chatShadowTranceSound",
			},
			{
				option	= "texture",
				desc	= "Choose a different shardcount texture: default blue orange rose turquoise violet x",
				method	= "chatTexture",
			},
			{
				option 	= "lock",
				desc	= "Toggle locking of the frames",
				method  = "chatLock",
			},
			{
				option  = "timers",
				desc    = "Toggle to turn on/off the timers",
				method  = "chatTimers",
			},

		},
		
		Chat            	= {
			FelDomModifier  = "Fel Domination Modifier is now: ",
			FelDomValid	= "Valid Modifiers are: ctrl alt shift none",
			CloseOnClick    = "Close On Click is now: ",
			ShadowTranceSound = "Playing of Shadowtrance sound is now: ",
			SoulstoneSound = "Playing of Soulstone expired sound is now: ",
			Texture = "Texture is now: ",
			TextureValid = "Valid textures are: default blue orange rose turquoise violet x",
			Lock = "Frame lock is now: ",
			Timers = "Timers are now: ",
		},
		
		Message			= {
			TooFarAway 	= "They are too far away.",
			Busy		= "They are busy.",
			PreSummon	= "Going to summon %s, please click the portal.",
			PreSoulstone	= "Placing my soulstone on %s.",
			Soulstone	= "%s has been soulstoned.",
			SoulstoneAborted = "Soustone Aborted! It's not placed.",
			FailedSummon	= "Summoning %s failed!",
		},
		

		Pattern = {
			Shard = "Soul Shard",
			Corrupted = "Corrupted",
			Healthstone = "Healthstone",
			Soulstone = "Soulstone",
			Spellstone = "Spellstone",
			Firestone = "Firestone",
			ShadowTrance = "^You gain Shadow Trance.$",
			RitualOfSummoning = "Ritual of Summoning",
			SoulstoneResurrection = "Soulstone Resurrection",
			Warlock = "Warlock",
			Rank = "Rank (.+)",
			Resisted = "^Your [%a%s%p]+ was resisted by [%a%s%p]+%.",
			Immune = "^Your [%a%s%p]+ failed%. [%a%s%p]+ is immune%.$",
		},

		State = {
			Reset = 0,
			Cast = 1,
			Start = 2,
			Stop = 3,
			NewMonsterNewSpell = 4,
			NewSpell = 5,
			Update = 6,
			Failed = 7
			
		},

		Spell = {
			["Summon Imp"] = "IMP",
			["Summon Voidwalker"] = "VOIDWALKER",
			["Summon Succubus"] = "SUCCUBUS",
			["Summon Felhunter"] = "FELHUNTER",
			["Inferno"] = "INFERNO",
			["Ritual of Doom"] = "DOOMGUARD",
			["Eye of Kilrogg"] = "KILROGG",
			["Fel Domination"] = "FELDOMINATION",
			["Demonic Sacrifice"] = "DEMONICSACRIFICE",
			["Soul Link"] = "SOULLINK",
			["Soulstone Resurrection"] = "SOULSTONERESURRECTION",
			["Ritual of Summoning"] = "RITUALOFSUMMONING",
		},

		RankedSpell = {
			["Summon Felsteed"] = { "MOUNT", 1 },
			["Summon Dreadsteed"] = { "MOUNT", 2 },
			["Demon Skin Rank 1"] = { "ARMOR", 1 },
			["Demon Skin Rank 2"] = { "ARMOR", 2 },
			["Demon Armor Rank 1"] = { "ARMOR", 3 },
			["Demon Armor Rank 2"] = { "ARMOR", 4 },
			["Demon Armor Rank 3"] = { "ARMOR", 5 },
			["Demon Armor Rank 4"] = { "ARMOR", 6 },
			["Demon Armor Rank 5"] = { "ARMOR", 7 },
			["Health Funnel Rank 1"] = { "HEALTHFUNNEL", 1 },
			["Health Funnel Rank 2"] = { "HEALTHFUNNEL", 2 },
			["Health Funnel Rank 3"] = { "HEALTHFUNNEL", 3 },
			["Health Funnel Rank 4"] = { "HEALTHFUNNEL", 4 },
			["Health Funnel Rank 5"] = { "HEALTHFUNNEL", 5 },
			["Health Funnel Rank 6"] = { "HEALTHFUNNEL", 6 },
			["Health Funnel Rank 7"] = { "HEALTHFUNNEL", 7 },
			["Create Healthstone (Minor)"] = { "HEALTHSTONE", 1 },
			["Create Healthstone (Lesser)"] = { "HEALTHSTONE", 2 },
			["Create Healthstone"] = { "HEALTHSTONE", 3 },
			["Create Healthstone (Greater)"] = { "HEALTHSTONE", 4 },
			["Create Healthstone (Major)"] = { "HEALTHSTONE", 5 },
			["Create Soulstone (Minor)"] = { "SOULSTONE", 1 },
			["Create Soulstone (Lesser)"] = { "SOULSTONE", 2 },
			["Create Soulstone"] = { "SOULSTONE", 3 },
			["Create Soulstone (Greater)"] = { "SOULSTONE", 4 },
			["Create Soulstone (Major)"] = { "SOULSTONE", 5 },
			["Create Spellstone"] = { "SPELLSTONE", 1 },
			["Create Spellstone (Greater)"] = { "SPELLSTONE", 2 },
			["Create Spellstone (Major)"] = { "SPELLSTONE", 3 },
			["Create Firestone (Lesser)"] = { "FIRESTONE", 1 },
			["Create Firestone"] = { "FIRESTONE", 2 },
			["Create Firestone (Greater)"] = { "FIRESTONE", 3 },
			["Create Firestone (Major)"] = { "FIRESTONE", 4 },
			["Enslave Demon Rank 1"] = {"ENSLAVE", 1},
			["Enslave Demon Rank 2"] = {"ENSLAVE", 2},
			["Enslave Demon Rank 3"] = {"ENSLAVE", 3},
		},
		TimedSpell = {
			["Corruption"] = { 12, 15, 18, 18, 18, 18, 18 },
			["Immolate"] = { 15, 15, 15, 15, 15, 15, 15, 15 },
			["Siphon Life"] = { 30, 30, 30, 30 },
			["Curse of Agony"] = { 24, 24, 24, 24, 24, 24 },
			["Banish"] = { 20, 30 },
			["Death Coil"] = {3, 3, 3},
			["Curse of Weakness"] = { 120, 120, 120, 120, 120, 120 },
			["Curse of Recklessness"] = { 120, 120, 120, 120 },
			["Curse of the Elements"] = { 300, 300, 300 },
			["Curse of Shadow"] = { 300, 300 },
			["Fear"] = { 10, 15, 20 },
			["Enslave Demon"] = { 300, 300, 300 },
			["Curse of Doom"] = { 60 },
			["Curse of Tongues"] = { 30, 30 },
		},
	}

	ace:RegisterGlobals({
		version	= 1.01,
	
		ACEG_TEXT_NOW_SET_TO = "now set to",
		ACEG_TEXT_DEFAULT	 = "default",
	
		ACEG_DISPLAY_OPTION  = "[|cfff5f530%s|r]",
	
		ACEG_MAP_ONOFF		 = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
		ACEG_MAP_ENABLED	 = {[0]="|cffff5050Disabled|r",[1]="|cff00ff00Enabled|r"},
	})
end
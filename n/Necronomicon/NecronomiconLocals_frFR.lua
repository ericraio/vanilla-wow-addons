function Necronomicon_Locals_frFR()

	NECRONOMICON_MSG_COLOR		= "|cffcceebb";
	NECRONOMICON_DISPLAY_OPTION	= "[|cfff5f530%s|cff0099CC]";

	NECRONOMICON_CONST = {

		Title   		= "Necronomicon",
		Version 		= "0.5",
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
			Shard = "Fragment d\'\195\162me",
			Corrupted = "Corrompu",
			Healthstone = "Pierre de soins",
			Soulstone = "Pierre d\'\195\162me",
			Spellstone = "Pierre de sort",
			Firestone = "Pierre de feu",
			ShadowTrance = "^Vous gagnez Transe de l'ombre%.$",
			RitualOfSummoning = "Rituel d\'invocation",
			SoulstoneResurrection = "R\195\169surrection de Pierre d\'\195\162me",
			Warlock = "D\195\169moniste",
			Rank = "Rang (.+)",
			Resisted = "^Vous utilisez [%a%s%p]+, mais [%a%s%p]+ r\195\169siste%.$",
			Immune = "^Votre [%a%s%p]+ rate%. [%a%s%p]+ y est insensible%.$",
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
			["Invocation d\'un diablotin"] = "IMP",
			["Invocation d\'un marcheur du Vide"] = "VOIDWALKER",
			["Invocation d\'une succube"] = "SUCCUBUS",
			["Invocation d\'un chasseur corrompu"] = "FELHUNTER",
			["Infernal"] = "INFERNO",
			["Rituel de mal\195\169diction"] = "DOOMGUARD",
			["Oeil de Kilrog"] = "KILROGG",
			["Domination corrompue"] = "FELDOMINATION",
			["Sacrifice d\195\169moniaque"] = "DEMONICSACRIFICE",
			["Lien Spirituel"] = "SOULLINK",
			["R\195\169surrection de Pierre d\'\195\162me"] = "SOULSTONERESURRECTION",
			["Rituel d\'invocation"] = "RITUALOFSUMMONING",

		},
		RankedSpell = {
			["Invocation d'un palefroi corrompu"] = { "MOUNT", 1 },
			["Invocation de Destrier de l'Effroi"] = { "MOUNT", 2 },
			["Peau de d\195\169mon Rang 1"] = { "ARMOR", 1 },
			["Peau de d\195\169mon Rang 2"] = { "ARMOR", 2 },
			["Armure d\195\169moniaque Rang 1"] = { "ARMOR", 3 },
			["Armure d\195\169moniaque Rang 2"] = { "ARMOR", 4 },
			["Armure d\195\169moniaque Rang 3"] = { "ARMOR", 5 },
			["Armure d\195\169moniaque Rang 4"] = { "ARMOR", 6 },
			["Armure d\195\169moniaque Rang 5"] = { "ARMOR", 7 },
			["Captation de vie Rang 1"] = { "HEALTHFUNNEL", 1 },
			["Captation de vie Rang 2"] = { "HEALTHFUNNEL", 2 },
			["Captation de vie Rang 3"] = { "HEALTHFUNNEL", 3 },
			["Captation de vie Rang 4"] = { "HEALTHFUNNEL", 4 },
			["Captation de vie Rang 5"] = { "HEALTHFUNNEL", 5 },
			["Captation de vie Rang 6"] = { "HEALTHFUNNEL", 6 },
			["Captation de vie Rang 7"] = { "HEALTHFUNNEL", 7 },
			["Cr\195\169ation de Pierre de soins (mineure)"] = { "HEALTHSTONE", 1 },
			["Cr\195\169ation de Pierre de soins (inf\195\169rieure)"] = { "HEALTHSTONE", 2 },
			["Cr\195\169ation de Pierre de soins"] = { "HEALTHSTONE", 3 },
			["Cr\195\169ation de Pierre de soins (sup\195\169rieure)"] = { "HEALTHSTONE", 4 },
			["Cr\195\169ation de Pierre de soins (majeure)"] = { "HEALTHSTONE", 5 },
			["Cr\195\169ation de Pierre d'\195\162me (mineure)"] = { "SOULSTONE", 1 },
			["Cr\195\169ation de Pierre d'\195\162me (inf\195\169rieure)"] = { "SOULSTONE", 2 },
			["Cr\195\169ation de Pierre d'\195\162me"] = { "SOULSTONE", 3 },
			["Cr\195\169ation de Pierre d'\195\162me (sup\195\169rieure)"] = { "SOULSTONE", 4 },
			["Cr\195\169ation de Pierre d'\195\162me (majeure)"] = { "SOULSTONE", 5 },
			["Cr\195\169ation de Pierre de sort"] = { "SPELLSTONE", 1 },
			["Cr\195\169ation de Pierre de sort (sup\195\169rieure)"] = { "SPELLSTONE", 2 },
			["Cr\195\169ation de Pierre de sort (majeure)"] = { "SPELLSTONE", 3 },
			["Cr\195\169ation de Pierre de feu (Inf\195\169rieure)"] = { "FIRESTONE", 1 },
			["Cr\195\169ation de Pierre de feu"] = { "FIRESTONE", 2 },
			["Cr\195\169ation de Pierre de feu (sup\195\169rieure)"] = { "FIRESTONE", 3 },
			["Cr\195\169ation de Pierre de feu (majeure)"] = { "FIRESTONE", 4 },
			["Asservir d\195\169mon Rang 1"] = {"ENSLAVE", 1},
			["Asservir d\195\169mon Rang 2"] = {"ENSLAVE", 2},
			["Asservir d\195\169mon Rang 3"] = {"ENSLAVE", 3},
		},
		TimedSpell = {
			["Corruption"] = { 12, 15, 18, 18, 18, 18, 18 },
			["Immolation"] = { 15, 15, 15, 15, 15, 15, 15, 15 },
			["Siphon de vie"] = { 30, 30, 30, 30 },
			["Mal\195\169diction d\'agonie"] = { 24, 24, 24, 24, 24, 24 },
			["Bannir"] = { 20, 30 },
			["Voile mortel"] = {3, 3, 3},
			["Mal\195\169diction de faiblesse"] = { 120, 120, 120, 120, 120, 120 },
			["Mal\195\169diction de t\195\169m\195\169rit\195\169"] = { 120, 120, 120, 120 },
			["Mal\195\169diction des \195\169l\195\169ments"] = { 300, 300, 300 },
			["Mal\195\169diction de l\'ombre"] = { 300, 300 },
			["Peur"] = { 10, 15, 20 },
			["Asservir d\195\169mon"] = { 300, 300, 300 },
			["Mal\195\169diction funeste"] = { 60 },
			["Mal\195\169diction des languages"] = { 30, 30 },
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
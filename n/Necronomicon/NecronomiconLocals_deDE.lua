function Necronomicon_Locals_deDE()

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
			Shard = "Seelensplitter",
			Corrupted = "Corrupted",
			Healthstone = "Gesundheitsstein",
			Soulstone = "Seelenstein",
			Spellstone = "Zauberstein",
			Firestone = "Feuerstein",
			ShadowTrance = "^Ihr bekommt 'Schattentrance'%.$",
			RitualOfSummoning = "Ritual der Beschw\195\182rung",
			SoulstoneResurrection = "Seelenstein\204\182Auferstehung",
			Warlock = "Hexenmeister",
			Rank = "Rang (.+)",
			Resisted = "^Ihr habt es mit [%a%s%p]+ versucht, aber [%a%s%p]+ hat widerstanden%.",
			Immune = "^[%a%s%p]+ war ein Fehlschlag%. [%a%s%p]+ ist immun%.$",
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
			["Wichtel beschw\195\182ren"] = "IMP",
			["Leerwandler beschw\195\182ren"] = "VOIDWALKER",
			["Sukkubus beschw\195\182ren"] = "SUCCUBUS",
			["Teufelsj\195\164ger beschw\195\182ren"] = "FELHUNTER",
			["Inferno"] = "INFERNO",
			["Verdammniswache"] = "DOOMGUARD",
			["Auge von Kilrogg"] = "KILROGG",
			["Teufelsbeherrschung"] = "FELDOMINATION",
			["D\195\164monenopferung"] = "DEMONICSACRIFICE",
			["Seelenverbindung"] = "SOULLINK",
			["Seelenstein\204\182Auferstehung"] = "SOULSTONERESURRECTION",
			["Ritual der Beschw\195\182rung"] = "RITUALOFSUMMONING",
		},
		RankedSpell = {
			["Teufelsross beschw\195\182ren"] = { "MOUNT", 1 },
			["Schreckensross herbeirufen"] = { "MOUNT", 2 },
			["D\195\164monenhaut Rang 1"] = { "ARMOR", 1 },
			["D\195\164monenhaut Rang 2"] = { "ARMOR", 2 },
			["D\195\164monenr\195\188stung Rang 1"] = { "ARMOR", 3 },
			["D\195\164monenr\195\188stung Rank 2"] = { "ARMOR", 4 },
			["D\195\164monenr\195\188stung Rang 3"] = { "ARMOR", 5 },
			["D\195\164monenr\195\188stung Rang 4"] = { "ARMOR", 6 },
			["D\195\164monenr\195\188stung Rang 5"] = { "ARMOR", 7 },
			["Gesundheitstrichter Rang 1"] = { "HEALTHFUNNEL", 1 },
			["Gesundheitstrichter Rang 2"] = { "HEALTHFUNNEL", 2 },
			["Gesundheitstrichter Rang 3"] = { "HEALTHFUNNEL", 3 },
			["Gesundheitstrichter Rang 4"] = { "HEALTHFUNNEL", 4 },
			["Gesundheitstrichter Rang 5"] = { "HEALTHFUNNEL", 5 },
			["Gesundheitstrichter Rang 6"] = { "HEALTHFUNNEL", 6 },
			["Gesundheitstrichter Rang 7"] = { "HEALTHFUNNEL", 7 },
			["Gesundheitsstein herstellen (schwach)"] = { "HEALTHSTONE", 1 },
			["Gesundheitsstein herstellen (gering)"] = { "HEALTHSTONE", 2 },
			["Gesundheitsstein herstellen"] = { "HEALTHSTONE", 3 },
			["Gesundheitsstein herstellen (gro\195\159)"] = { "HEALTHSTONE", 4 },
			["Gesundheitsstein herstellen (erheblich)"] = { "HEALTHSTONE", 5 },
			["Seelenstein herstellen (swach)"] = { "SOULSTONE", 1 },
			["Seelenstein herstellen (gering)"] = { "SOULSTONE", 2 },
			["Seelenstein herstellen"] = { "SOULSTONE", 3 },
			["Seelenstein herstellen (gr\195\159)"] = { "SOULSTONE", 4 },
			["Seelenstein herstellen (erheblich)"] = { "SOULSTONE", 5 },
			["Zauberstein herstellen"] = { "SPELLSTONE", 1 },
			["Zauberstein herstellen (gro\195\159)"] = { "SPELLSTONE", 2 },
			["Zauberstein herstellen (erheblich)"] = { "SPELLSTONE", 3 },
			["Feuerstein herstellen (gering)"] = { "FIRESTONE", 1 },
			["Feuerstein herstellen"] = { "FIRESTONE", 2 },
			["Feuerstein herstellen (gro\195\159)"] = { "FIRESTONE", 3 },
			["Feuerstein herstellen (erheblich)"] = { "FIRESTONE", 4 },
			["D\195\164monensklave Rang 1"] = {"ENSLAVE", 1},
			["D\195\164monensklave Rang 2"] = {"ENSLAVE", 2},
			["D\195\164monensklave Rang 3"] = {"ENSLAVE", 3},
		},
		TimedSpell = {
			["Verderbnis"] = { 12, 15, 18, 18, 18, 18, 18 },
			["Feuerbrand"] = { 15, 15, 15, 15, 15, 15, 15, 15 },
			["Lebensentzug"] = { 30, 30, 30, 30 },
			["Fluch der Pein"] = { 24, 24, 24, 24, 24, 24 },
			["Verbannen"] = { 20, 30 },
			["Todesmantel"] = {3, 3, 3},
			["Fluch der Schw\195\164che"] = { 120, 120, 120, 120, 120, 120 },
			["Fluch der Tollk\195\188hnheit"] = { 120, 120, 120, 120 },
			["Fluch der Elemente"] = { 300, 300, 300 },
			["Schattenfluch"] = { 300, 300 },
			["Furcht"] = { 10, 15, 20 },
			["Enslave Demon"] = { 300, 300, 300 },
			["Curse of Doom"] = { 60 },
			["Fluch der Sprachen"] = { 30, 30 },
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
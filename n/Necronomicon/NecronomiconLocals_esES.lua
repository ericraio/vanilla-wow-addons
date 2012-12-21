function Necronomicon_Locals_esES()

	NECRONOMICON_MSG_COLOR		= "|cffcceebb";
	NECRONOMICON_DISPLAY_OPTION	= "[|cfff5f530%s|cff0099CC]";

	NECRONOMICON_CONST = {

		Title   		= "Necronomicon",
		Version 		= "0.5",
		Desc    		= "Necronomicon, Ace'd Necrosis - Spanish by PorkoJones",
		Timerheader		= "Temp. Hechizos",
		UpdateInterval		= 0.2,
	
		ChatCmd		= {"/necro", "/necronomicon", "/Necronomicon"},
		
		ChatOpt 		= {
			{	
				option	= "reset",
				desc	= "Resetea la posici\195\179n de las ventanas.",
				method	= "chatReset",
			},
			{
				option  = "feldom",
				desc	= "Establece el modificador para Dominio de lo Maldito: ctrl alt shift none",
				method  = "chatFelDom",
			},
			{
				option  = "closeonclick",
				desc    = "Alterna la posibilidad de cerrar el men\195\186 de mascota haciendo clic",
				method  = "chatCloseClick",
			},
			{
				option  = "soulstonesound",
				desc    = "Alterna la posibilidad de reproducir un sonido cuando se agote la Piedra de Alma",
				method  = "chatSoulstoneSound",
			},
			{
				option  = "shadowtrancesound",
				desc    = "Alterna la posibilidad de reproducir un sonido cuando se active el efecto Ocaso",
				method  = "chatShadowTranceSound",
			},
			{
				option	= "texture",
				desc	= "Elegir una textura diferente para la cuenta de fragmentos de alma: default blue orange rose turquoise violet x",
				method	= "chatTexture",
			},
			{
				option 	= "lock",
				desc	= "Alterna el bloqueo de ventana",
				method  = "chatLock",
			},

		},
		
		Chat            	= {
			FelDomModifier  = "Modificador para Dominio de lo Maldito establecido a: ",
			FelDomValid	= "Los modificadores v\195\161lidos son: ctrl alt shift none",
			CloseOnClick    = "Cerrar la hacer clic establecido a: ",
			ShadowTranceSound = "Reproducir sonido cuando se active el efecto Ocaso establecido a: ",
			SoulstoneSound = "Reproducir sonido cuando se agote la Piedra de Alma establecido a: ",
			Texture = "Textura establecida a: ",
			TextureValid = "Las Texturas v\195\161lidas son: default blue orange rose turquoise violet x",
			Lock = "Bloqueo de ventana establecido a: ",

		},
		
		Message			= {
			TooFarAway 	= "Estan muy lejos.",
			Busy		= "Estan ocupados.",
			PreSummon	= "Voy a invocar a %s, por favor haced clic en el portal.",
			PreSoulstone	= "Depositando mi Piedra de Alma en %s.",
			Soulstone	= "%s ha recibido una Piedra de Alma.",
			SoulstoneAborted = "Piedra de Alma interrumpida! No se ha depositado.",
		},
		

		Pattern = {
			Shard = "Fragmento de alma",
			Corrupted = "Corrupto",
			Healthstone = "Piedra de salud",
			Soulstone = "Piedra de alma",
			Spellstone = "Piedra de hechizos",
			Firestone = "Pirorroca",
			ShadowTrance = "^Ganas Trance de las Sombras.$",
			RitualOfSummoning = "Ritual de invocaci\195\179n",
			SoulstoneResurrection = "Resurrecci\195\179n con piedra de alma",
			Warlock = "Brujo",
			Rank = "Rango (.+)",
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
			["Invocar a diablillo"] = "IMP",
			["Invocar a abisario"] = "VOIDWALKER",
			["Invocar a s\195\186cubo"] = "SUCCUBUS",
			["Invocar a man\195\161fago"] = "FELHUNTER",
			["Inferno"] = "INFERNO",
			["Ritual de condena"] = "DOOMGUARD",
			["Ojo de Kilrogg"] = "KILROGG",
			["Dominio de lo Maldito"] = "FELDOMINATION",
			["Sacrificio demon\195\173aco"] = "DEMONICSACRIFICE",
			["Enlace de alma"] = "SOULLINK",
			["Resurrecci\195\179n con piedra de alma"] = "SOULSTONERESURRECTION",
			["Ritual de invocaci\195\179n"] = "RITUALOFSUMMONING",
		},
		RankedSpell = {
			["Invocar a corcel nefasto"] = { "MOUNT", 1 },
			["Invocar a corcel de la muerte"] = { "MOUNT", 2 },
			["Piel de demonio Rango 1"] = { "ARMOR", 1 },
			["Piel de demonio Rango 2"] = { "ARMOR", 2 },
			["Armadura demon\195\173aca Rango 1"] = { "ARMOR", 3 },
			["Armadura demon\195\173aca Rango 2"] = { "ARMOR", 4 },
			["Armadura demon\195\173aca Rango 3"] = { "ARMOR", 5 },
			["Armadura demon\195\173aca Rango 4"] = { "ARMOR", 6 },
			["Armadura demon\195\173aca Rango 5"] = { "ARMOR", 7 },
			["Cauce de salud Rango 1"] = { "HEALTHFUNNEL", 1 },
			["Cauce de salud Rango 2"] = { "HEALTHFUNNEL", 2 },
			["Cauce de salud Rango 3"] = { "HEALTHFUNNEL", 3 },
			["Cauce de salud Rango 4"] = { "HEALTHFUNNEL", 4 },
			["Cauce de salud Rango 5"] = { "HEALTHFUNNEL", 5 },
			["Cauce de salud Rango 6"] = { "HEALTHFUNNEL", 6 },
			["Cauce de salud Rango 7"] = { "HEALTHFUNNEL", 7 },
			["Crear piedra de salud (menor)"] = { "HEALTHSTONE", 1 },
			["Crear piedra de salud (inferior)"] = { "HEALTHSTONE", 2 },
			["Crear piedra de salud"] = { "HEALTHSTONE", 3 },
			["Crear piedra de salud (superior)"] = { "HEALTHSTONE", 4 },
			["Crear piedra de salud (sublime)"] = { "HEALTHSTONE", 5 },
			["Crear piedra de alma (menor)"] = { "SOULSTONE", 1 },
			["Crear piedra de alma (inferior)"] = { "SOULSTONE", 2 },
			["Crear piedra de alma"] = { "SOULSTONE", 3 },
			["Crear piedra de alma (superior)"] = { "SOULSTONE", 4 },
			["Crear piedra de alma (sublime)"] = { "SOULSTONE", 5 },
			["Crear piedra de hechizos"] = { "SPELLSTONE", 1 },
			["Crear piedra de hechizos (superior)"] = { "SPELLSTONE", 2 },
			["Crear piedra de hechizos (sublime)"] = { "SPELLSTONE", 3 },
			["Crear pirorroca (inferior)"] = { "FIRESTONE", 1 },
			["Crear pirorroca"] = { "FIRESTONE", 2 },
			["Crear pirorroca (superior)"] = { "FIRESTONE", 3 },
			["Crear pirorroca (sublime)"] = { "FIRESTONE", 4 },
			["Esclavizar demonio Rango 1"] = {"ENSLAVE", 1},
			["Esclavizar demonio Rango 2"] = {"ENSLAVE", 2},
			["Esclavizar demonio Rango 3"] = {"ENSLAVE", 3},
		},
		TimedSpell = {
			["Corrupci\195\179n"] = { 12, 15, 18, 18, 18, 18, 18 },
			["Inmolar"] = { 15, 15, 15, 15, 15, 15, 15, 15 },
			["Engullir vida"] = { 30, 30, 30, 30 },
			["Maldici\195\179n de Agon\195\173a"] = { 24, 24, 24, 24, 24, 24 },
			["Desterrar"] = { 20, 30 },
			["Espiral mortal"] = {3, 3, 3},
			["Maldici\195\179n de debilidad"] = { 120, 120, 120, 120, 120, 120 },
			["Maldici\195\179n de Temeridad"] = { 120, 120, 120, 120 },
			["Maldici\195\179n de los Elementos"] = { 300, 300, 300 },
			["Maldici\195\179n de las Sombras"] = { 300, 300 },
			["Miedo"] = { 10, 15, 20 },
			["Esclavizar demonio"] = { 300, 300, 300 },
			["Maldici\195\179n del Apocalipsis"] = { 60 },
			["Maldici\195\179n de la lengua"] = { 30, 30 },
		},
	}
	
	ace:RegisterGlobals({
		version	= 1.01,
	
		ACEG_TEXT_NOW_SET_TO = "establecido a",
		ACEG_TEXT_DEFAULT	 = "por defecto",
	
		ACEG_DISPLAY_OPTION  = "[|cfff5f530%s|r]",
	
		ACEG_MAP_ONOFF		 = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
		ACEG_MAP_ENABLED	 = {[0]="|cffff5050Deshabilitado|r",[1]="|cff00ff00Habilitado|r"},
	})
end
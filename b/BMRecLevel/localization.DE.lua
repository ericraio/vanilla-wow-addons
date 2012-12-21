function BM_Translation_DE()
	-- ***GLOBAL VARIABLES ***--
	BRL_LOADED_INFO						= BM_GREEN .. "\nZeigt den Levelbereich der aktuellen Zone an und gibt eine Zonenempfehlung f\195\188r dein Level." .. BM_FONT_OFF;
	BRL_ACTIVE_INFO						= BM_GREEN .. "Recommended Level UI Men\195\188 ist AKTIVIERT\nMit /brlconfig rufst du das UI Men\195\188 auf." .. BM_FONT_OFF; -- New
	BRL_DISABLED_INFO						= BM_GREEN .. "Recommended Level UI Men\195\188 ist DEAKTIVIERT\nMit /brlconfig wird das UI Men\195\188 nicht aufgerufen." .. BM_FONT_OFF; -- New
	BRL_RESET_ALL_TEXT						= "Willst du alle Einstellungen zur\195\188cksetzen?";
	BRL_CITY								= "Stadt";
	BRL_CONTESTED							= "Umk\195\164mpft";
	BRL_ALLIANCE							= "Allianz";
	BRL_HORDE								= "Horde";
	BRL_NONE								= "Keine";
	BRL_TOOLTIP_CURRENT					= "Aktuell:";
	BRL_TOOLTIP_CLEVEL						= "Aktuelles Level: ";
	BRL_TOOLTIP_CZONE						= "Aktuelle Zone: ";
	BRL_TOOLTIP_CRANGE						= "Zonenlevel: ";
	BRL_TOOLTIP_CINSTANCES				= "Instanzen: ";
	BRL_TOOLTIP_RECOMMEND				= "Empfohlene Zonen:";
	BRL_TOOLTIP_RZONE						= "Zone: ";
	BRL_TOOLTIP_RRANGE						= "Zonenlevel: ";
	BRL_TOOLTIP_RFACTION					= "Fraktion: ";
	BRL_TOOLTIP_RINSTANCES				= "Instanzen: ";
	BRL_TOOLTIP_RCONTINENT				= "Kontinent: ";
	BRL_TOOPTIP_TITLE						= "Zoneninfo";
	BRL_ERROR_MESSAGE_1					= "Zahl muss zwischen 0 und 1 liegen.";
	BRL_TOOLTIP_BG							= "Schlachtfeld";
	BRL_RECOMMEND_TO						= "bis ";
	BRL_RECOMMEND_AND_UP					= " und h\195\182her ";
	BRL_RECOMMEND_INSTANCES				= "Empfohlene Instanzen:";
	BRL_RECOMMEND_BATTLEGROUNDS			= "Empfohlene Schlachtfelder:";


	-- *** MENU OPTIONS *** --
	BRL_ZONE_INFO_ENABLE					= "Zoneninfo-Leiste anzeigen";
	BRL_TOOLTIP_ENABLE						= "Tooltip anzeigen";
	BRL_MAP_TEXT_ENABLE					= "Zoneninfo auf der Weltkarte anzeigen";
	BRL_TOOLTIP_OFFSET_LEFT				= "Offset Links/Rechts";
	BRL_TOOLTIP_OFFSET_BOTTOM			= "Offset Unten/Oben";
	BRL_SHOW_TOOLTIP_FACTION				= "Fraktion im Tooltip anzeigen";
	BRL_SHOW_TOOLTIP_INSTANCE			= "Instanzen im Tooltip anzeigen";
	BRL_BORDER_ALPHASLIDER					= "Transparenz der Zoneninfo-Leiste";
	BRL_SHOW_ZONE							= "Zone am Bildschirm anzeigen";
	BRL_SHOW_REC_INSTANCE				= "Zeige empfohlene Instanzen";
	BRL_SHOW_REC_BATTLEGROUNDS			= "Zeige empfohlene Schlachtfelder";
	BRL_SHOW_TOOLTIP_CONTINENT			= "Kontinent im Tooltip anzeigen";
	BRL_MOVABLE_FRAME_ENABLE				= "Zeige bewegbares Fenster"; --New


	-- ***RECOMMENDED LEVEL INFORMATION*** --
	BMRECLEVEL_TITLE						= "Bhaldie Recommended Level";
	BMRECLEVEL_VERSION						= "2.11";
	BMRECLEVEL_DESCRIPTION				= "Zeigt den Levelbereich der aktuellen Zone an und gibt eine Zonenempfehlung f\195\188r dein Level.";
	BMRECLEVEL_LOADED						= "|cffffff00" .. BMRECLEVEL_TITLE .. " v" .. BMRECLEVEL_VERSION .. " geladen";
	
	-- *** TABLE VARIABLES *** --
	BRL_EASTERNKINGDOM					= "\195\150stliche K\195\182nigreiche";
	BRL_KALIMDOR							= "Kalimdor";


	-- ***LIST OF ZONES*** --
	ZONE_TABLE = {
				["ironforge"]			="Ironforge",
				["stormwind"]			="Stormwind",
				["undercity"]			="Undercity",
				["dun_morogh"]		="Dun Morogh",
				["elwynn_forest"]		="Der Wald von Elwynn",
				["tirisfal_glades"]		="Tirisfal",
				["loch_modan"]		="Loch Modan",
				["westfall"]			="Westfall",
				["silverpine"]			="Der Silberwald",
				["redridge"]			="Das Redridgegebirge",
				["wetlands"]			="Das Sumpfland",
				["duskwood"]			="Duskwood",
				["hillsbrad"]			="Die Vorgebirge von Hillsbrad",
				["alterac"]			="Das Alteracgebirge",
				["arathi"]			="Das Arathihochland",
				["badlands"]			="Das \195\150dland",
				["stranglethorn"]		="Stranglethorn",
				["swamp_sorrows"]	="Die S\195\188mpfe des Elends",
				["blasted_lands"]		="Die verw\195\188steten Lande",
				["searing_gorge"]		="Die sengende Schlucht",
				["hinterlands"]		="Das Hinterland",
				["blackrock"]			="Der Blackrock",
				["burning_steppes"]	="Die brennende Steppe",
				["deadwind"]			="Der Gebirgspass der Totenwinde",
				["eastern_plague"]	="Die \195\182stlichen Pestl\195\164nder",
				["western_plague"]	="Die westlichen Pestl\195\164nder",
				["darnassus"]			="Darnassus",
				["orgrimmar"]			="Orgrimmar",
				["thunder_bluff"]		="Thunder Bluff",
				["durotar"]			="Durotar",
				["mulgore"]			="Mulgore",
				["teldrassil"]			="Teldrassil",
				["darkshore"]			="Dunkelk\195\188ste",
				["barrens"]			="Das Brachland",
				["ashenvale"]			="Ashenvale",
				["stonetalon"]		="Das Steinkrallengebirge",
				["thousand_needles"]	="Thousand Needles",
				["desolace"]			="Desolace",
				["dustwallow"]		="Die Marschen von Dustwallow",
				["feralas"]			="Feralas",
				["silithus"]			="Silithus",
				["tanaris"]			="Tanaris",
				["ungoro"]			="Der Un'\Goro Krater",
				["azshara"]			="Azshara",
				["felwood"]			="Teufelswald",
				["moonglade"]		="Moonglade",
				["wintersprings"]		="Winterspring",
	}


	-- ***LIST OF INSTANCES*** --
	INSTANCE_TABLE = {
				["ironforge_instances"]		= {{["instance"] = BRL_NONE}},
				["stormwind_instances"]		= {{["itype"] = "instance", ["instance"] = "Die Palisaden", ["low_level"] = 24, ["high_level"] = 32, ["faction"] = BRL_ALLIANCE}},
				["undercity_instances"]		= {{["instance"] = BRL_NONE}},
				["dun_morogh_instances"]		= {{["itype"] = "instance", ["instance"] = "Gnomeregan", ["low_level"] = 29, ["high_level"] = 38, ["faction"] = BRL_ALLIANCE}},
				["elwynn_forest_instances"]	= {{["instance"] = BRL_NONE}},
				["tirisfal_glades_instances"]	= {{["itype"] = "instance", ["instance"] = "Das scharlachrote Kloster", ["low_level"] = 34, ["high_level"] = 45, ["faction"] = BRL_NONE}},
				["loch_modan_instances"]		= {{["instance"] = BRL_NONE}},
				["westfall_instances"]			= {{["itype"] = "instance", ["instance"] = "Die Todesminen", ["low_level"] = 17, ["high_level"] = 26, ["faction"] = BRL_ALLIANCE}},
				["silverpine_instances"]		= {{["itype"] = "instance", ["instance"] = "Burg Shadowfang", ["low_level"] = 22, ["high_level"] = 30, ["faction"] = BRL_HORDE}},
				["redridge_instances"]			= {{["instance"] = BRL_NONE}},
				["wetlands_instances"]		= {{["instance"] = BRL_NONE}},
				["duskwood_instances"]		= {{["instance"] = BRL_NONE}},
				["hillsbrad_instances"]			= {{["instance"] = BRL_NONE}},
				["alterac_instances"]			= {{["itype"] = "battlegrounds", ["instance"] = "Das Alteractal", ["low_level"] = 51, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["arathi_instances"]			= {{["itype"] = "battlegrounds", ["instance"] = "Das Arathibecken", ["low_level"] = 20, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["badlands_instances"]		= {{["itype"] = "instance", ["instance"] = "Uldaman", ["low_level"] = 41, ["high_level"] = 51, ["faction"] = BRL_NONE}},
				["stranglethorn_instances"]	= {{["itype"] = "instance", ["instance"] = "Zul'\Grub", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["swamp_sorrows_instances"]	= {{["itype"] = "instance", ["instance"] = "Der versunkene Tempel", ["low_level"] = 50, ["high_level"] = 55, ["faction"] = BRL_NONE}},
				["blasted_lands_instances"]	= {{["instance"] = BRL_NONE}},
				["searing_gorge_instances"]	= {
												{["itype"] = "instance", ["instance"] = "Der Geschmolzene Kern", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Der Pechschwingenhort", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Die Blackrockspitze", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Die Blackrocktiefen", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["hinterlands_instances"]		= {{["instance"] = BRL_NONE}},
				["blackrock_instances"]		= {
												{["itype"] = "instance", ["instance"] = "Der Geschmolzene Kern", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Der Pechschwingenhort", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Die Blackrockspitze", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Die Blackrocktiefen", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["burning_steppes_instances"]	 = {
												{["itype"] = "instance", ["instance"] = "Der Geschmolzene Kern", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Der Pechschwingenhort", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Die Blackrockspitze", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Die Blackrocktiefen", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["deadwind_instances"]		= {{["instance"] = BRL_NONE}},
				["eastern_plague_instances"]	= {{["itype"] = "instance", ["instance"] = "Stratholme", ["low_level"] = 58, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["western_plague_instances"]	= {{["itype"] = "instance", ["instance"] = "Scholomance", ["low_level"] = 56, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["darnassus_instances"]		= {{["instance"] = BRL_NONE}},
				["orgrimmar_instances"]		= {{["itype"] = "instance", ["instance"] = "Der Ragefireabgrund", ["low_level"] = 13, ["high_level"] = 18, ["faction"] = BRL_HORDE}},
				["thunder_bluff_instances"]	= {{["instance"] = BRL_NONE}},
				["durotar_instances"]			= {{["instance"] = BRL_NONE}},
				["mulgore_instances"]			= {{["instance"] = BRL_NONE}},
				["teldrassil_instances"]		= {{["instance"] = BRL_NONE}},
				["darkshore_instances"]		= {{["instance"] = BRL_NONE}},
				["barrens_instances"]			= {
												{["itype"] = "instance", ["instance"] = "H\195\182hlen des Wehklagens", ["low_level"] = 17, ["high_level"] = 24, ["faction"] = BRL_HORDE},
												{["itype"] = "instance", ["instance"] = "Der Kral von Razorfen", ["low_level"] = 29, ["high_level"] = 38, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Die H\195\188gel von Razorfen", ["low_level"] = 37, ["high_level"] = 46, ["faction"] = BRL_NONE},
												{["itype"] = "battlegrounds", ["instance"] = "Die Warsongschlucht", ["low_level"] = 10, ["high_level"] = 60, ["faction"] = BRL_HORDE},
											},
				["ashenvale_instances"]		= {
												{["itype"] = "instance", ["instance"] = "Die Blackfathom-Tiefen", ["low_level"] = 24, ["high_level"] = 32, ["faction"] = BRL_NONE},
												{["itype"] = "battlegrounds", ["instance"] = "Die Warsongschlucht", ["low_level"] = 10, ["high_level"] = 60, ["faction"] = BRL_ALLIANCE},
											},
				["stonetalon_instances"]		= {{["instance"] = BRL_NONE}},
				["thousand_needles_instances"] = {{["instance"] = BRL_NONE}},
				["desolace_instances"]		= {{["itype"] = "instance", ["instance"] = "Maraudon", ["low_level"] = 46, ["high_level"] = 55, ["faction"] = BRL_NONE}},
				["dustwallow_instances"]		= {{["itype"] = "instance", ["instance"] = "Onyxia'\s Hort", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["feralas_instances"]			= {{["itype"] = "instance", ["instance"] = "D\195\188sterbruch", ["low_level"] = 56, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["silithus_instances"]			= {{["itype"] = "instance", ["instance"] = "Die Tore von Ahn'\Qiraj", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["tanaris_instances"]			= {{["itype"] = "instance", ["instance"] = "Zul'\Farrak", ["low_level"] = 44, ["high_level"] = 54, ["faction"] = BRL_NONE}},
				["ungoro_instances"]			= {{["instance"] = BRL_NONE}},
				["azshara_instances"]			= {{["instance"] = BRL_NONE}},
				["felwood_instances"]			= {{["instance"] = BRL_NONE}},
				["moonglade_instances"]		= {{["instance"] = BRL_NONE}},
				["wintersprings_instances"]	= {{["instance"] = BRL_NONE}},
	}
end
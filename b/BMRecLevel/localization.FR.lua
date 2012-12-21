function BM_Translation_FR()
	-- ***GLOBAL VARIABLES ***--
	BRL_LOADED_INFO						= BM_GREEN .. "\nTapez '/brlconfig' dans la fenêtre de chat, pour ouvrir la fenêtre de configuration." .. BM_FONT_OFF;
	BRL_ACTIVE_INFO						= BM_GREEN .. "Recommended Level UI Menu is ACTIVE\nYou can type /brlconfig in the chat window to bring up the UI Menu." .. BM_FONT_OFF; -- New
	BRL_DISABLED_INFO						= BM_GREEN .. "Recommended Level UI Menu is DISABLED\nTyping /brlconfig in the chat window will not bring up the UI Menu." .. BM_FONT_OFF; -- New
	BRL_RESET_ALL_TEXT						= "Voulez vous vraiment r\195\169initialiser la configuration?"; 
	BRL_CITY								= "Ville";
	BRL_CONTESTED							= "Contest\195\169";
	BRL_ALLIANCE							= "Alliance";
	BRL_HORDE								= "Horde";
	BRL_NONE								= "Aucune";
	BRL_TOOLTIP_CURRENT					= "Actuel:";
	BRL_TOOLTIP_CLEVEL						= "Niveau Actuel: ";
	BRL_TOOLTIP_CZONE						= "Zone Actuelle: ";
	BRL_TOOLTIP_CRANGE						= "Niveau de zone: ";
	BRL_TOOLTIP_CINSTANCES				= "Instances: "; 
	BRL_TOOLTIP_RECOMMEND				= "Zones recommand\195\169es:";
	BRL_TOOLTIP_RZONE						= "Zone: ";
	BRL_TOOLTIP_RRANGE						= "Niveau de zone: ";
	BRL_TOOLTIP_RFACTION					= "Faction: "; 
	BRL_TOOLTIP_RINSTANCES				= "Instances: ";
	BRL_TOOLTIP_RCONTINENT				= "Continent: "; --New
	BRL_TOOPTIP_TITLE						= "Zone Info"; 
	BRL_ERROR_MESSAGE_1					= "Le nombre doit \195\170tre compris entre 0 et 1.";
	BRL_TOOLTIP_BG							= "Battlegrounds"; --New
	BRL_RECOMMEND_TO						= "\195\160 "; --New
	BRL_RECOMMEND_AND_UP					= " and up "; --New
	BRL_RECOMMEND_INSTANCES				= "Recommended Instances:"; --New
	BRL_RECOMMEND_BATTLEGROUNDS			= "Recommended Battlegrounds:"; --New


	-- *** MENU OPTIONS *** --
	BRL_ZONE_INFO_ENABLE					= "Montrer/Cacher la barre de Zone Info";
	BRL_TOOLTIP_ENABLE						= "Montrer/Cacher le tooltip"; 
	BRL_MAP_TEXT_ENABLE					= "Montrer/Cacher le texte de carte";
	BRL_TOOLTIP_OFFSET_LEFT				= "Offset Gauche/Droite"; 	 
	BRL_TOOLTIP_OFFSET_BOTTOM			= "Offset Bas/haut"; 
	BRL_SHOW_TOOLTIP_FACTION				= "Montrer la faction dans le tooltip";
	BRL_SHOW_TOOLTIP_INSTANCE			= "Montrer les instances dans le tooltip"; 
	BRL_BORDER_ALPHASLIDER					= "Alpha du bord";
	BRL_SHOW_ZONE							= "Montrer la zone dans la fenêtre";
	BRL_SHOW_REC_INSTANCE				= "Show Recommended Instances"; --New
	BRL_SHOW_REC_BATTLEGROUNDS			= "Show Recommended Battlegrounds"; --New
	BRL_SHOW_TOOLTIP_CONTINENT			= "Show Continent in Tooltip"; --New
	BRL_MOVABLE_FRAME_ENABLE				= "Show Moveable Frame"; --New


	-- ***RECOMMENDED LEVEL  INFORMATION*** --
	BMRECLEVEL_TITLE						= "Bhaldie Recommended Level";
	BMRECLEVEL_VERSION						= "2.11";
	BMRECLEVEL_DESCRIPTION				= "Donne le niveau de la zone ou vous \195\170tes et vous en sugg\195\168re par rapport a votre niveau.";
	BMRECLEVEL_LOADED						= "|cffffff00" .. BMRECLEVEL_TITLE .. " v" .. BMRECLEVEL_VERSION .. " charg\195\169.";

	-- *** TABLE VARIABLES *** --
	BRL_EASTERNKINGDOM					= "Royaumes de l'est";
	BRL_KALIMDOR							= "Kalimdor";


	-- ***LIST OF ZONES*** --
	ZONE_TABLE = {
				["ironforge"]			="Ironforge",
				["stormwind"]			="Cit\195\169 de Stormwind",
				["undercity"]			="Undercity",
				["dun_morogh"]		="Dun Morogh",
				["elwynn_forest"]		="For\195\170t d'Elwynn",
				["tirisfal_glades"]		="Clairi\195\168res de Tirisfal",
				["loch_modan"]		="Loch Modan",
				["westfall"]			="Marche de l'Ouest",
				["silverpine"]			="For\195\170t des Pins argent\195\169s",
				["redridge"]			="Les Carmines",
				["wetlands"]			="Les Paluns",
				["duskwood"]			="Bois de la p\195\169nombre",
				["hillsbrad"]			="Contreforts d'Hillsbrad",
				["alterac"]			="Montagnes d'Alterac",
				["arathi"]			="Hautes-terres d'Arathi",
				["badlands"]			="Terres ingrates",
				["stranglethorn"]		="Vall\195\169e de Strangleronce",
				["swamp_sorrows"]	="Marais des Chagrins",
				["blasted_lands"]		="Terres foudroy\195\169es",
				["searing_gorge"]		="Gorge des Vents br\195\187lants",
				["hinterlands"]		="Les Hinterlands",
				["blackrock"]			="Mont Blackrock",
				["burning_steppes"]	="Steppes ardentes",
				["deadwind"]			="D\195\169fil\195\169 de Deuillevent",
				["eastern_plague"]	="Maleterres de l'est",
				["western_plague"]	="Maleterres de l'ouest",
				["darnassus"]			="Darnassus",
				["orgrimmar"]			="Orgrimmar",
				["thunder_bluff"]		="Thunder Bluff",
				["durotar"]			="Durotar",
				["mulgore"]			="Mulgore",
				["teldrassil"]			="Teldrassil",
				["darkshore"]			="Sombrivage",
				["barrens"]			="Les Tarides",
				["ashenvale"]			="Ashenvale",
				["stonetalon"]		="Les Serres-Rocheuses",
				["thousand_needles"]	="Mille pointes",
				["desolace"]			="D\195\169solace",
				["dustwallow"]		="Mar\195\169cage d'\195\130prefange",
				["feralas"]			="Feralas",
				["silithus"]			="Silithus",
				["tanaris"]			="Tanaris",
				["ungoro"]			="Crat\195\168re d'Un'Goro",
				["azshara"]			="Azshara",
				["felwood"]			="Gangrebois",
				["moonglade"]		="Reflet-de-Lune",
				["wintersprings"]		="Berceau-de-l'Hiver",
	}


	-- ***LIST OF INSTANCES*** --
	INSTANCE_TABLE = {
				["ironforge_instances"]		= {{["instance"] = BRL_NONE}},
				["stormwind_instances"]		= {{["itype"] = "instance", ["instance"] = "La prison", ["low_level"] = 24, ["high_level"] = 32, ["faction"] = BRL_ALLIANCE}},
				["undercity_instances"]		= {{["instance"] = BRL_NONE}},
				["dun_morogh_instances"]		= {{["itype"] = "instance", ["instance"] = "Gnomeregan", ["low_level"] = 29, ["high_level"] = 38, ["faction"] = BRL_ALLIANCE}}, 
				["elwynn_forest_instances"]	= {{["instance"] = BRL_NONE}},
				["tirisfal_glades_instances"]	= {{["itype"] = "instance", ["instance"] = "Monast\195\168re Ecarlate", ["low_level"] = 34, ["high_level"] = 45, ["faction"] = BRL_NONE}},
				["loch_modan_instances"]		= {{["instance"] = BRL_NONE}},
				["westfall_instances"]			= {{["itype"] = "instance", ["instance"] = "Les mortemines", ["low_level"] = 17, ["high_level"] = 26, ["faction"] = BRL_ALLIANCE}},
				["silverpine_instances"]		= {{["itype"] = "instance", ["instance"] = "Le donjon d'Ombrecroc", ["low_level"] = 22, ["high_level"] = 30, ["faction"] = BRL_HORDE}},
				["redridge_instances"]			= {{["instance"] = BRL_NONE}},
				["wetlands_instances"]		= {{["instance"] = BRL_NONE}},
				["duskwood_instances"]		= {{["instance"] = BRL_NONE}},
				["hillsbrad_instances"]			= {{["instance"] = BRL_NONE}},
				["alterac_instances"]			= {{["itype"] = "battlegrounds", ["instance"] = "Vall\195\169e d'Alterac", ["low_level"] = 51, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["arathi_instances"]			= {{["itype"] = "battlegrounds", ["instance"] = "Bassin d'Arathi", ["low_level"] = 20, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["badlands_instances"]		= {{["itype"] = "instance", ["instance"] = "Uldaman", ["low_level"] = 41, ["high_level"] = 51, ["faction"] = BRL_NONE}},
				["stranglethorn_instances"]	= {{["itype"] = "instance", ["instance"] = "Zul'Grub", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["swamp_sorrows_instances"]	= {{["itype"] = "instance", ["instance"] = "Le temple d\'Atal\'Hakkar", ["low_level"] = 50, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["blasted_lands_instances"]	= {{["instance"] = BRL_NONE}},
				["searing_gorge_instances"]	= {
												{["itype"] = "instance", ["instance"] = "Coeur du magma", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Rep\195\168re de l'Aile noire", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Le pic de Blackrock", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Les profondeurs de Blackrock", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["hinterlands_instances"]		= {{["instance"] = BRL_NONE}},
				["blackrock_instances"]		= {
												{["itype"] = "instance", ["instance"] = "Coeur du magma", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Rep\195\168re de l'Aile noire", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Le pic de Blackrock", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Les profondeurs de Blackrock", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["burning_steppes_instances"]	= {
												{["itype"] = "instance", ["instance"] = "Coeur du magma", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Rep\195\168re de l'Aile noire", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Le pic de Blackrock", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Les profondeurs de Blackrock", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["deadwind_instances"]		= {{["instance"] = BRL_NONE}},
				["eastern_plague_instances"]	= {{["itype"] = "instance", ["instance"] = "Stratholme", ["low_level"] = 58, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["western_plague_instances"]	= {{["itype"] = "instance", ["instance"] = "Scholomance", ["low_level"] = 56, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["darnassus_instances"]		= {{["instance"] = BRL_NONE}},
				["orgrimmar_instances"]		= {{["itype"] = "instance", ["instance"] = "Gouffre de Ragefeu", ["low_level"] = 13, ["high_level"] = 18, ["faction"] = BRL_HORDE}},
				["thunder_bluff_instances"]	= {{["instance"] = BRL_NONE}},
				["durotar_instances"]			= {{["instance"] = BRL_NONE}},
				["mulgore_instances"]			= {{["instance"] = BRL_NONE}},
				["teldrassil_instances"]		= {{["instance"] = BRL_NONE}},
				["darkshore_instances"]		= {{["instance"] = BRL_NONE}},
				["barrens_instances"]			= {
												{["itype"] = "instance", ["instance"] = "Caverne des lamentations", ["low_level"] = 17, ["high_level"] = 24, ["faction"] = BRL_HORDE},
												{["itype"] = "instance", ["instance"] = "Kraal de Tranchebauge", ["low_level"] = 29, ["high_level"] = 38, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Souilles de Tranchebauge", ["low_level"] = 37, ["high_level"] = 46, ["faction"] = BRL_NONE},
												{["itype"] = "battlegrounds", ["instance"] = "Goulet des Warsong", ["low_level"] = 10, ["high_level"] = 60, ["faction"] = BRL_HORDE},
											},
				["ashenvale_instances"]		= {
												{["itype"] = "instance", ["instance"] = "Profondeurs de Brassenoire", ["low_level"] = 24, ["high_level"] = 32, ["faction"] = BRL_NONE},
												{["itype"] = "battlegrounds", ["instance"] = "Goulet des Warsong", ["low_level"] = 10, ["high_level"] = 60, ["faction"] = BRL_ALLIANCE},
											},
				["stonetalon_instances"]		= {{["instance"] = BRL_NONE}},
				["thousand_needles_instances"] = {{["instance"] = BRL_NONE}},
				["desolace_instances"]		= {{["itype"] = "instance", ["instance"] = "Maraudon", ["low_level"] = 46, ["high_level"] = 55, ["faction"] = BRL_NONE}},
				["dustwallow_instances"]		= {{["itype"] = "instance", ["instance"] = "l'Antre d'Onyxia", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["feralas_instances"]			= {{["itype"] = "instance", ["instance"] = "Hache-Tripes", ["low_level"] = 56, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["silithus_instances"]			= {{["itype"] = "instance", ["instance"] = "Les portes d'Ahn'Qiraj", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["tanaris_instances"]			= {{["itype"] = "instance", ["instance"] = "Zul'Farrak", ["low_level"] = 44, ["high_level"] = 54, ["faction"] = BRL_NONE}},
				["ungoro_instances"]			= {{["instance"] = BRL_NONE}},
				["azshara_instances"]			= {{["instance"] = BRL_NONE}},
				["felwood_instances"]			= {{["instance"] = BRL_NONE}},
				["moonglade_instances"]		= {{["instance"] = BRL_NONE}},
				["wintersprings_instances"]	= {{["instance"] = BRL_NONE}},
	}
end
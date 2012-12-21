if( GetLocale() == "frFR" ) then

	--[[
	-- CTA Localization
	-- 
	-- French By : Sasmira ( Cosmos Team )
	-- 
	-- $Id$
	-- $Rev$ R7
	-- $LastChangedBy$ IDispatch
	-- $Date$ 2005/10/11
	--
	--]]
	
	-- e accent aigu : \195\169
	-- e accent circonflexe: \195\170
	-- e accent grave: \195\168
	-- a accent grave: \195\160
	
	-- Chat --
	
	CTA_ORCISH = "ORC";
	CTA_COMMON = "COMMUN";
	CTA_ILLEGAL_CHANNEL_WORDS = "D\195\169fense Locale Commerce G\195\169n\195\169ral";
	
	-- Classes --
	
	CTA_PRIEST = "Pr\195\170tre";
	CTA_MAGE = "Mage";
	CTA_WARLOCK = "D\195\169moniste";
	CTA_DRUID = "Druide";
	CTA_HUNTER = "Chasseur";
	CTA_ROGUE = "Voleur";
	CTA_WARRIOR = "Guerrier";
	CTA_PALADIN = "Paladin";
	CTA_SHAMAN = "Chaman";
	CTA_ANY_CLASS = "Toutes classes";
	
	-- User interface --
	
	CTA_CALL_TO_ARMS = "Call To Arms";
	
	CTA_GROUP = "groupe";
	CTA_PARTY = "groupe";
	CTA_CURRENT_SIZE = "Taille actuelle";
	CTA_CONVERT_TO_RAID = "Convertir en Raid";
	CTA_PLAYER_IS_RAID_MEMBER_NOT_LEADER = "Vous \195\170tes un membre d\'un groupe, mais pas son chef. Vous devez \195\170tre Chef de groupe ou sans groupe pour commencer \195\160 en h\195\169berger un.";
	CTA_LIST_RAIDS = "Trouver des groupes";
	CTA_MY_RAID = "H\195\169berger un groupe";
	CTA_SEARCH_OPTIONS = "Options de recherche";
	CTA_SHOW_ALL_CLASSES = "Afficher toutes les classes";
	CTA_SHOW_PVE_RAIDS = "Afficher groupes JcE";
	CTA_SHOW_PVP_RAIDS = "Afficher groupes JcJ";
	CTA_SEARCH_RAID_DESCRIPTIONS = "Rech. dans les descriptions:";
	CTA_SHOW_FULL_RAIDS = "Afficher groupes complets";
	CTA_SHOW_EMPTY_RAIDS = "Afficher groupes vides";
	CTA_SHOW_PASSWORD_PROTECTED_RAIDS = "Afficher les groupes avec mot de passe";
	CTA_SHOW_RAIDS_ABOVE_MY_LEVEL = "Afficher les groupes sup\195\169rieurs \195\160 mon niveau";
	CTA_RESULTS = "R\195\169sultat:";
	CTA_UPDATE_LIST = "M.\195\160.J. liste";
	CTA_JOIN_RAID = "Rejoindre groupe";
	CTA_RAID_DESCRIPTION = "Description du groupe:";
	CTA_RAID_DESCRIPTION_HELP = "Inclure les informations telles que le lieu, le but et autres commentaires";
	CTA_RAID_TYPE = "Type de groupe:";
	CTA_PLAYER_VS_PLAYER = "Joueur Vs Joueur";
	CTA_PLAYER_VS_ENVIRONMENT = "Joueur Vs Environnement";
	CTA_MAXIMUM_PLAYERS = "Joueurs max:";
	CTA_MAXIMUM_PLAYERS_HELP = "5 - 40";
	CTA_MAXIMUM_PLAYERS_HELP2 = "Pour plus de 5 membres, vous devez convertir un Groupe en Raid";
	CTA_MINIMUM_LEVEL = "Niveau minimum:";
	CTA_MINIMUM_LEVEL_HELP = "1 - 60";
	CTA_PASSWORD = "Mot de passe:";
	CTA_PASSWORD_HELP = "Pas d\'espace dans le mot de passe, laisser vide pour aucun";
	CTA_CLASS_DISTRIBUTION = "Distribution des classes:";
	CTA_START_A_RAID = "Commencer un groupe";
	CTA_SEND_REQUEST = "Envoyer la requ\195\170te";
	CTA_CANCEL = "Annuler";
	CTA_GO_ONLINE = "Passer online";
	CTA_GO_OFFLINE = "Passer offline";
	CTA_RAID_OFFLINE_MESSAGE = "CE GROUPE EST OFFLINE. Aucun des joueurs utilisant Call To Arms ne peut voir votre groupe.";
	CTA_RAID_ONLINE_MESSAGE = "CE GROUPE EST ONLINE. Tous les joueurs utilisant Call To Arms peuvent voir votre groupe.";
	CTA_IS_OFFLINE = "Call to Arms est offline";
	CTA_IS_ONLINE = "Call to Arms est online";
	CTA_SEARCH_FOR_RAIDS = "Recherche de groupes";
	CTA_HOST_A_RAID = "H\195\169berger un groupe";
	CTA_HEADER_RAID_DESCRIPTION = "Description du groupe";
	CTA_HEADER_TYPE = "Type";
	CTA_HEADER_SIZE = "Taille";
	CTA_HEADER_MIN_LEVEL = "Niv. min";
	CTA_RESULTS_FOUND = "Trouv\195\169s:";
	CTA_RAID = "raid";
	CTA_RAIDS = "raids";
	CTA_MIN_LEVEL_TO_JOIN_RAID = "Niveau minimum pour rejoindre le groupe";
	CTA_RAID_REQUIRES_PASSWORD = "Un mot de passe est requis pour joindre ce groupe."
	CTA_RAID_CREATED = "Groupe cr\195\169e";
	CTA_NO_DESCRIPTION = "Aucune description";
	CTA_PVP = "JcJ";
	CTA_PVE = "JcE";
	CTA_YES = "Oui";
	CTA_NO = "Non";
	CTA_RAID_LEADER = "Chef de groupe";
	CTA_DESCRIPTION = "Description";
	CTA_PAGE = "PAGE";
	CTA_GROUPS = "groupes";
	
	-- Slash commands --
	
	CTA_COMMANDS = "Commands";
	--CTA_HELP = "help";
	--CTA_TOGGLE = "toggle";
	--CTA_DEFAULT_CHANNEL = "default channel";
	--CTA_SET_CHANNEL = "set channel";
	--CTA_CHANNEL_NAME = "channelName";
	--CTA_CLEAR_BLACKLIST = "clear blacklist";
	--CTA_DISSOLVE_RAID = "dissolve group";
	--CTA_CONVERT_RAID = "convert raid";
	
	CTA_TOGGLE_HELP = "Affiche/Cache la fen\195\170tre CTA";
	CTA_DEFAULT_CHANNEL_HELP = "Fixe le canal CTA au canal par d\195\169faut";
	CTA_SET_CHANNEL_HELP = "Fixe le canal CTA \195\160 "..CTA_CHANNEL_NAME.." (non recommand\195\169)";
	CTA_CLEAR_BLACKLIST_HELP = "Nettoie la liste de joueurs que CTA ignore en raison du spam"
	CTA_DISSOLVE_RAID_HELP = "(Chef de groupe seulement) Dissout totalement le groupe en enlevant tous les joueurs"
	CTA_CONVERT_RAID_HELP = "(Chef de groupe seulement) Convertit un Raid en Groupe";
	
	-- Generated messages --
	
	CTA_CALL_TO_ARMS_LOADED = "Call To Arms lanc\195\169. Utiliser /cta pour plus de commandes."
	
	CTA_QUERY_CHANNEL_IS = "Le canal de requ\195\170te est";
	CTA_BLACKLIST_CLEARED = "Liste noire nettoy\195\169e";
	CTA_ILLEGAL_CHANNEL_NAME = "Nom de canal ill\195\169gal";
	CTA_WAS_BLACKLISTED = "a \195\169t\195\169 mis en liste noire pour spam";
	CTA_GROUP_MEMBERS = "Membres du groupe: ";
	CTA_INVITATION_SENT_TO = "Invitation envoy\195\169e \195\160";
	
	CTA_DISSOLVING_RAID = "Suppression du groupe...";
	CTA_MUST_BE_LEADER_TO_DISSOLVE_RAID = "Vous devez \195\170tre le Chef de groupe pour dissoudre le groupe." ;
	CTA_RAID_DISSOLVED = "Groupe dissout";
	
	CTA_CONVERTING_TO_PARTY = "Conversion du groupe...";
	CTA_CANNOT_CONVERT_TO_PARTY = "Ne peut pas convertir en Groupe \195\160 moins que le Raid n\'ait 5 membres ou moins";
	CTA_CONVERTING_TO_PARTY_DONE = "Groupe converti";
	CTA_MUST_BE_LEADER_TO_CONVERT_RAID = "Vous devez \195\170tre le Chef de Groupe pour convertir un groupe." ;
	
	-- Automated chat messages --
	
	CTA_WRONG_LEVEL_OR_CLASS = "D\195\169sol\195\169, mais votre niveau et/ou classe ne r\195\169pondent pas aux exigences requises pour rejoindre ce groupe.";
	CTA_DISSOLVING_THE_RAID_CHAT_MESSAGE = "Le groupe est maintenant dissout, merci de votre participation.";
	CTA_CONVERTING_TO_PARTY_MESSAGE = "Conversion en Groupe, acceptez l\'invitation pour rejoindre le groupe.";
	CTA_INVITATION_SENT_MESSAGE = "Bonjour, une invitation pour rejoindre mon groupe vous a \195\169t\195\169 envoy\195\169e.";
	CTA_INCORRECT_PASSWORD_MESSAGE = "Vous avez envoy\195\169 un mot de passe incorrect pour ce groupe.";
	CTA_NO_SPACE_MESSAGE = "Ce groupe a d\195\169j\195\160 le nombre maximum de joueurs.";
	CTA_PASSWORD_REQURED_TO_JOIN_MESSAGE = "Un mot de passe est requis pour rejoindre ce groupe.";
	
	-- Tooltips --
	
	CTA_MAXIMUM_PLAYERS_ALLOWED = "Maximum de joueurs autoris\195\169s";
	CTA_PLAYERS_IN_RAID = "Joueurs actuellement en groupe";
	CTA_NUMBER_OF_PLAYERS_NEEDED = "Nombre de joueurs demand\195\169s";
	CTA_ANY_CLASS_TOOLTIP = "Le nombre maximum de joueurs de toutes classes autoris\195\169s \195\160 rejoindre le groupe.";
	CTA_MINIMUM_PLAYERS_WANTED = "Minimum de joueurs recherch\195\169s";
	CTA_LFM_ANY_CLASS = "Besoin de plus de joueurs de toutes classes.";
	CTA_LFM_CLASSLIST = "Besoin de plus de joueurs de ces classes: ";
	CTA_CLASS_TOOLTIP = "Le nombre minimum de joueurs de cette classe autoris\195\169s \195\160 rejoindre le groupe. Si ce minimum est d\195\169pass\195\169 les joueurs suppl\195\169mentaires sont comptabilis\195\169s comme joueurs de \'Toutes classes\'.";
	
	CTA_GenTooltips = {
	
	CTA_SearchFrameShowClassCheckButton = {
	tooltip1 = "Afficher toutes les classes",
	tooltip2 = "Si coch\195\169, les r\195\169sultats incluront les groupes qui recherchent plus de joueurs des classes diff\195\169rentes de la votre."
	},
	
	CTA_SearchFrameShowPVPCheckButton = {
	tooltip1 = "Afficher les groupes JcJ",
	tooltip2 = "Si coch\195\169, les r\195\169sultats incluront les groupes de Joueurs contre Joueurs."
	},
	
	CTA_SearchFrameShowPVECheckButton = {
	tooltip1 = "Afficher les groupes JcE",
	tooltip2 = "Si coch\195\169, les r\195\169sultats incluront les groupes de Joueurs contre Environnement et de qu\195\170tes."
	},
	
	CTA_SearchFrameShowFullCheckButton = {
	tooltip1 = "Afficher les groupes complets",
	tooltip2 = "Si coch\195\169, les r\195\169sultats incluront les groupes complets et qui n\'ont pas besoin de joueurs suppl\195\169mentaires."
	},
	
	CTA_SearchFrameShowEmptyCheckButton = {
	tooltip1 = "Afficher les groupes vides",
	tooltip2 = "Si coch\195\169, les r\195\169sultats incluront les groupes \'vides\' qui n\'ont qu\'un seul joueur."
	},
	
	CTA_SearchFrameShowPasswordCheckButton = {
	tooltip1 = "Afficher les groupes avec mot de passe",
	tooltip2 = "Si coch\195\169, les r\195\169sultats incluront les groupes avec mot de passe."
	},
	
	CTA_SearchFrameShowLevelCheckButton = {
	tooltip1 = "Afficher les groupes sup\195\169rieurs \195\160 mon niveau",
	tooltip2 = "Si coch\195\169, les r\195\169sultats incluront les groupes demandant des joueurs de niveau plus \195\169lev\195\169 que le v\195\180tre."
	},
	
	CTA_SearchFrameDescriptionEditBox = {
	tooltip1 = "Recherche dans les descriptions",
	tooltip2 = "Beaucoup de chefs de groupes font une description sommaire de leur groupe. Si des mots-cl\195\169s sont \195\169crits dans cette zone de texte, seulement les groupes avec ces mots-cl\195\169s dans leur description seront inclus dans les r\195\169sultats."
	},
	
	};
	
	
	-- New for R3 features
	
	CTA_CURRENT = "Actuel";
	CTA_PENDING = "En cours";
	CTA_SIZE = "Taille";
	
	CTA_LOG = "Log";
	CTA_HELP_TAB = "Aide";
	
	CTA_SETTINGS = "Options";
	CTA_MINIMAP_ICON_SETTINGS = "Options de l\'ic\195\180ne de la Minimap";
	CTA_COMM_SETTINGS = "Options de communication";
	CTA_LOG_AND_MONITOR = "Log syst\195\168me et surveillance du chat (Beta)"
	
	CTA_START_PARTY = "Cr\195\169er un Groupe";
	CTA_START_RAID = "Cr\195\169er un Raid";
	CTA_PLAYER_CAN_START_A_GROUP = "Commencer l\'h\195\169bergement d\'un nouveau groupe";
	CTA_CONVERT_TO_PARTY = "Convertir en Groupe";
	CTA_STOP_HOSTING = "Arr\195\170ter l\'h\195\169bergement";
	CTA_SEARCH_MATCH = "Score de la recherche";
	CTA_NO_MORE_PLAYERS_NEEDED = "Plus besoin de joueurs";
	
	CTA_PLAYER_LIST = "Joueurs en liste noire";
	CTA_EDIT_PLAYER = "Editer les informations du joueur";
	CTA_DELETE = "Supprimer";
	CTA_SAVE = "Sauver";
	CTA_ADD_PLAYER = "Ajouter joueur";
	
	CTA_PLAYER_NOTE = "Note";
	CTA_PLAYER_STATUS = "Statut";
	CTA_DEFAULT_PLAYER_NOTE = "Nouveau joueur ajout\195\169. Cliquez ici pour \195\169diter cette note."
	CTA_DEFAULT_STATUS = ""
	CTA_DEFAULT_IMPORTED_IGNORED_PLAYER_NOTE = "Import\195\169 depuis les joueurs \'ignor\195\169s\'. Cliquez ici pour \195\169diter cette note.";
	CTA_DEFAULT_RATING = "";
	CTA_BLACKLISTED_NOTE = "Temporairement en liste noire de CTA. Editez la note pour rendre permanent.";
	CTA_PROMO = "\'Call To Arms\' (CTA) est un nouvel add-on permettant \195\160 des joueurs d\'h\195\169berger, de trouver et de rejoindre des groupes rapidement et plus facilement. Allez sur le site de http://www.curse-gaming.com, http://ui.worldofwar.net, http://www.wowguru.com ou http://www.wowinterface.com pour plus de d\195\169tails.";
	CTA_OK = "OK";
	CTA_ADD_PLAYER = "Ajouter joueur";
	CTA_ENTER_PLAYER_NAME = "Entrez le nom du joueur \195\160 mettre en liste noire:";
	
	CTA_ICON = "Ic\195\180ne de la Minimap";
	CTA_ICON_TEXT = "Texte ic\195\180ne";
	CTA_ADJUST_ANGLE = "Ajuster l\'angle";
	CTA_ADJUST_RADIUS = "Ajuster le rayon";
	
	-- New for R5

	CTA_MAXIMUM_PLAYERS_ALLOWED 				= "Nombre d\'emplacements autoris\195\169";
	CTA_PLAYERS_IN_RAID 						= "Joueurs actuellement dans le groupe";
	CTA_NUMBER_OF_PLAYERS_NEEDED 				= "Nombre de joueurs requis";
	CTA_ANY_CLASS_TOOLTIP 						= "Nombre d\'emplacements non r\195\169serv\195\169s. Permet \195\160 des joueurs de toutes classes de remplir ces emplacements.";
	CTA_MINIMUM_PLAYERS_WANTED 					= "Emplacements r\195\169serv\195\169s";
	CTA_LFM_ANY_CLASS 							= "besoin de plus de joueurs de toutes classes.";
	CTA_LFM_CLASSLIST 							= "besoin de plus de joueurs de ces classes: ";
	CTA_CLASS_TOOLTIP							= "Nombre d\'emplacements r\195\169serv\195\169s aux joueurs de cet ensemble de classes. Si ce nombre est d\195\169pass\195\169 les joueurs suppl\195\169mentaires sont comptabilis\195\169s comme des joueurs de \'Toutes classes\'.";
	--CTA_ANNOUNCE_GROUP							= "announce";
	CTA_ANNOUNCE_GROUP_HELP						= "Envoie un message public (LFM). Usage: \'cta announce <num\195\169ro de canal>\'";
	CTA_WAIT_TO_ANNOUNCE						= "Veuillez attendre un moment avant d\'annoncer votre groupe."
	CTA_TOGGLE_CHAT_MONITORING					= "Surveiller les messages du chat";
	CTA_LOG_AND_MONITOR							= "Entr\195\169es du log";
	CTA_LAST_UPDATE								= "Derni\195\168re M.\195\160.J";
	CTA_FILTER_RESULTS							= "Filtres optionnels";
	
	CTA_LFM										= "LFM";
	CTA_LFG										= "LFG";
	
	-- R6
	
	CTA_EDIT_ACID_CLASSES						= "Editer les classes pour cette r\195\168gle:";
	CTA_NAME									= "Nom";
		
	-- P7B1
	CTA_NON_CTA_GROUP_MESSAGE					= "Groupe Non-CTA";
	CTA_NON_CTA_PLAYER_MESSAGE					= "Joueur Non-CTA";
	CTA_NEW_LFX									= "Nouveau LFx trouv\195\169";
	CTA_PRE_R7_USER								= "Version R6 ou plus ancienne";
	CTA_VERSION									= "Version";
	CTA_CURRENT_GROUP_CLASSES					= "Classes dans le groupe";
	CTA_TOGGLE_MINIMAP							= "minimap";
	CTA_LFG_FRAME								= "Rech. groupe";
	CTA_ANNOUNCE_LFG							= "Diffuser ce message LFG sur le canal CTAChannel.";
	CTA_ANNOUNCE_INFO_TEXT						= "Ce message LFG sera diffus\195\169 sur le canal CTAChannel uniquement si vous n\'h\195\169bergez pas de groupe avec CTA.\n\nUtilisez \'/cta announce <channel>\' pour envoyer votre message LFG/M sur un canal local toutes les 100 secondes et \'/cta announce off\' pour arr\195\170ter.";
	CTA_AUTO_ANNOUNCE_OFF						= "announce off";
	
	--P7B3
	CTA_FIND_PLAYERS_AND_GROUPS					= "Rech. joueurs et groupes";
	CTA_LFG_FRAME								= "Me marquer comme LFG";
	CTA_CANNOT_LFG								= "Vous ne pouvez pas vous marquer comme LFG si vous \195\170tes d\195\169j\195\160 dans un groupe."
	CTA_MANAGE_GROUP							= "G\195\169rer mon groupe";
	CTA_SEARCH									= "Chercher";
	CTA_CLOSE									= "Fermer";
	CTA_LFG										= "LFG"; -- LFG = 'Looking For Group'
	
	CTA_LFG_TRIGGER								= "Mots-cl\195\169s pour les messages \'Looking for group\'";
	CTA_LFM_TRIGGER								= "Mots-cl\195\169s pour les messages \'Looking For More\'";
	CTA_FILTER_GROUP_RESULTS					= "Filtres des groupes";
	CTA_FILTER_PLAYER_RESULTS					= "Filtres des joueurs";
	
	CTA_SEARCH_RESULTS							= "R\195\169sultats de recherche";
	CTA_SEARCH_OPTIONS							= "Options de recherche";
	
	CTA_SHOW_PLAYERS_AND_GROUPS					= "Afficher les joueurs et les groupes";
	CTA_SHOW_PLAYERS_ONLY						= "Afficher uniquement les joueurs";
	CTA_SHOW_GROUPS_ONLY						= "Afficher uniquement les groupes";
	CTA_CTA_PLAYER								= "Joueur CTA";
	CTA_CTA_GROUP								= "Groupe CTA";
	CTA_FORWARD_LFX								= "Surveiller les canaux locaux et envoyer tous les messages LFG/M vers le canal CTAChannel.";
	
	CTA_MORE_FEATURES							= "Plus";
	
	CTA_ANNOUNCE_SUMMARY_PROMPT					= " > Pour plus d\'info, tapez \'/w "..(UnitName( "player" )).." details\'";
	CTA_ANNOUNCE_DETAILS_PROMPT					= " > Pour rejoindre, tapez \'/w "..(UnitName( "player" )).." inviteme\'";
	CTA_ANNOUNCE_JOIN_PROMPT					= " > For plus d\'info, tapez \'/w "..(UnitName( "player" )).." cta?\'";
	CTA_PROMO									= "Bienvenue dans le groupe! Ce groupe et g\195\169r\195\169 par l\'addon CallToArms.";
	CTA_ABOUT_CTA_MESSAGE						= "L\'addon \'CallToArms\' de recherche de groupe rend tr\195\168s simple la formation de groupes dans WoW et est disponible sur www.curse-gaming.com, ui.worldofwar.net, www.wowguru.com et www.wowinterface.com."
	
	-- R7 BETA 4

	BINDING_HEADER_CALL_TO_ARMS				 	= "Call To Arms";
	BINDING_NAME_CTA_SHOW_FRAME					= "Montrer la fen\195\170tre principale";
	
	CTA_CHANNEL_MONITORING						= "Surveillance de canal et transmission";
	CTA_CHANNEL_MONITORING_NOTE					= "Les mots-cl\195\169s doivent avoir au moins 3 caract\195\168res et sont utilis\195\169s pour identifier les messages LFM et LFG dans les canaux locaux. Choisissez ces mots-cl\195\169s avec soin car les messages ainsi s\195\169lectionn\195\169s seront transmis \195\160 tous les autres utilisateurs de CTA. Modifiez ces mots-cl\195\169s uniquement s\'ils ne correspondent pas aux codes utilis\195\169s sur votre serveur.";
	
	CTA_SHOW_NON_CTA_RESULTS					= "Montrer les r\195\169sultats locaux (non CTA)";
	CTA_SHOW_LFX_OPTIONS						= "Option des LFx locaux";
	CTA_ADJUST_TRANSPARENCY						= "Ajuster la transparence de la fen\195\170tre";
	
	CTA_CTA_GROUP_FILTERS						= "Filtres de groupes CTA";
	CTA_OTHER_FILTERS							= "Autres filtres";
	CTA_PLAYER_FILTERS							= "Filtres des joueurs";
	CTA_UPDATE_LFX								= "Appliquer";	
	CTA_ERROR_REPORT							= "- Rapport d\'erreur -\nCopiez le texte ci-dessous dans le rapport d\'erreur que vous enverrez.";
end
-- ## Many thanks to the following people for this translation ..
-- ##     * Triel on Curse Gaming
-- ##     * Tchoutchou on WorldOfWar
-- ##     * Gwerrae on Curse Gaming
-- ##     * BiDOrD on Curse Gaming

if (GetLocale() == "frFR") then

	-- ###############
	-- ## MENU TEXT ##
	-- ###############

	TITANBG_MENU_SHOW_OPTIONS = "Show Options";

	TITANBG_MENU_HEADER           = "Titan Battleground";
	TITANBG_MENU_HEADER_INTERFACE = "Interface";
	TITANBG_MENU_HEADER_WORLD     = "Monde";

	TITANBG_MENU_GENERAL_OPTIONS = "Options g\195\169n\195\169rales";
	TITANBG_MENU_DISP_OPTIONS    = "Options d'affichage";

	-- General Options
		-- Battleground
		TITANBG_MENU_AUTOJOIN     = "Rejoindre automatiquement le champ de bataille";
		TITANBG_MENU_AUTOLEAVE    = "Quitter automatiquement le champ de bataille lorsqu'il est termin\195\169";
		TITANBG_MENU_AUTORELEASE  = "Lib\195\169rer automatiquement l'esprit apr\195\168s la mort dans un champ de bataille";
		TITANBG_MENU_RELEASECHECK = "Do not automatically release if a Soulstone or Shaman Ressurect is available?";

		-- Interface
		TITANBG_MENU_OVERWRITESIMILAR = "Bloquer les options similaires d'autres add-ons";

		TITANBG_MENU_HIDEMINIMAPBUTTON = "Cacher l'ic\195\180ne Champ de bataille de la minicarte";
		TITANBG_MENU_AUTOSHOWBATTLEMAP = "Afficher automatiquement la carte tactique du champ de bataille";

		TITANBG_MENU_HIDEJOINPOPUP  = "Cacher le dialogue d'annonce qu'un champ de bataille est pr\195\170t \195\160 \195\170tre rejoint";
		TITANBG_MENU_REPEATSOUND    = "R\195\169p\195\169ter p\195\169riodiquement le son d'annonce";
		TITANBG_MENU_PLAYWHICHSOUND = "Son \195\160 utiliser";

	-- Display Options
	TITANBG_MENU_B_SPACERS = "Afficher des caract\195\168res autour du texte";

	-- World
		TITANBG_MENU_B_TIME     = "Afficher le temps attendu et le temps d'attente estim\195\169";
		TITANBG_MENU_B_TIMELEFT = "Afficher le temps maximum restant pour rejoindre le champ de bataille";

		TITANBG_MENU_TT_QUEUETIMERS = "Afficher le temps d'attente";
		TITANBG_MENU_TT_REMBGSOPEN  = "Afficher le nombre de champs de bataille disponibles";

		-- Battleground
		TITANBG_MENU_BUTTON_OPTIONS = "Options du texte de la barre Titan";
		TITANBG_PANEL_HIDEACTIVE    = "Cacher les infos actives lorsqu'un autre champ de bataille peut \195\170tre rejoint";
		TITANBG_PANEL_P             = "Afficher le nombre de joueurs";
		TITANBG_PANEL_S             = "Afficher votre niveau de r\195\169putation";
		TITANBG_PANEL_K             = "Afficher votre nombre de victoires honorables";
		TITANBG_PANEL_KB            = "Afficher votre nombre de coups fatals";
		TITANBG_PANEL_D             = "Afficher votre nombre de morts";
		TITANBG_PANEL_H             = "Afficher votre nombre de points d'honneur bonus";

		TITANBG_MENU_TT_OPTIONS        = "Options de l'infobulle";
		TITANBG_MENU_TT_TWOTOOLTIPS    = "Champ de bataille actif et files d'attente dans des infobulles s\195\169par\195\169es";
		TITANBG_MENU_TT_AB_WINESTIMATE = "Afficher le vainqueur estim\195\169 dans le Bassin d'Arathi";
		TITANBG_MENU_TT_WSG_FLAG       = "Afficher le suivit des drapeaux dans le Goulet des Warsongs";
		TITANBG_MENU_SHOWSTATS         = "Afficher les statistiques du joueur";
		TITANBG_MENU_SHOWLOCATIONSTATS = "Afficher les statistiques du joueur concernant les objectifs strat\95\169giques";
		TITANBG_MENU_SHOWFRIENDS       = "Afficher les statistiques des amis";
		TITANBG_MENU_SHOWCAPTURE       = "Afficher les comptes \195\160 rebours des captures";

		TITANBG_MENU_PANEL_OPTIONS    = "Options du panneau d'informations";
		TITANBG_MENU_PANEL_LOCK       = "Verrouiller le panneau";
		TITANBG_MENU_PANEL_CAP_SHOW   = "Afficher les comptes \195\160 rebours des captures";
		TITANBG_MENU_PANEL_CAP_INVERT = "Inverser l'orientation des comptes \195\160 rebours";

		TITANBG_MENU_PANEL_WSG_SHOW       = "Afficher le suivit des drapeaux dans le Goulet des Warsongs";
		TITANBG_MENU_PANEL_WSG_CLICK      = "Autoriser le ciblage du porteur du drapeau en cliquant sur son nom";
		TITANBG_MENU_PANEL_WSG_COLORCLASS = "Colorer le nom du porteur du drapeau en fonction de sa classe";
		TITANBG_MENU_PANEL_WSG_TEXTCLASS  = "Afficher sa classe \195\160 cot\195\169 du nom du porteur du drapeau";
		TITANBG_MENU_PANEL_WSG_INVERT     = "Inverser l'orientation du suivit des drapeaux";
		TITANBG_MENU_PANEL_WSG_ATTACH     = "Ancrer le suivit des drapeaux au panneau des scores";

		TITANBG_MENU_POPUP_OPTIONS = "Options du dialogue";
		TITANBG_MENU_POPUP_EXPIRE  = "Afficher le temps maximum restant pour rejoindre le champ de bataille";

	-- Queue Options
	TITANBG_MENU_QUEUE_OPTIONS = "Option des files d'attente";

	-- ###################
	-- ## BUTTON LABELS ##
	-- ###################

	TITANBG_BUTTON_PAUSED = "P";

	-- Queue
	TITANBG_FIRST_AVAILABLE = "1er dispo";
	TITANBG_LABEL_READY     = "Pr\195\170t";

	-- Battleground
	TITANBG_S_STANDING     = "#: ";
	TITANBG_S_KILLINGBLOWS = "CM: ";
	TITANBG_S_KILLS        = "VH: ";
	TITANBG_S_DEATHS       = "M: ";
	TITANBG_S_HONOR        = "H: ";

	-- XML
	TITANBG_DRAGGABLE_OS_CAP         = "Panneau d'informations de Titan Battleground\nVous pouvez d\195\169placer ce rectangle.";
	TITANBG_DRAGGABLE_OS_CAPINSTRUCT = "Pour cacher ce rectangle, cochez l'option '" .. TITANBG_MENU_PANEL_LOCK .. "' dans la cat\195\169gorie '" .. TITANBG_MENU_DISP_OPTIONS .. " / " .. CHAT_MSG_BATTLEGROUND .. "' des options de Titan Battleground.";

	-- ####################
	-- ## TOOLTIP LABELS ##
	-- ####################

	TITANBG_TOOLTIP         = "Informations des champs de bataille";
	TITANBG_TOOLTIP_PAUSED  = "En pause";
	TITANBG_TOOLTIP_UNPAUSE = "R\195\169activ\195\169";

	-- Not in the Queue.
	TITANBG_NOT_IN_QUEUE_LONG = "Aucune file d'attente pour {bg}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.

	-- Waiting
	TITANBG_TIME_IN_QUEUE       = "Temps pass\195\169 dans la file: ";
	TITANBG_ESTIMATED_REMAINING = "Temps restant estim\195\169: ";
	TITANBG_ESTIMATED_WAIT      = "Temps d'attente estim\195\169: ";
	TITANBG_LESS_THAN_ONE_MIN   = "Moins d'une minute.";
	TITANBG_QUEUED_NOPREF       = "Vous \195\170tes actuellement en file d'attente pour le prochain {bg} disponible."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.
	TITANBG_QUEUED_PREF         = "Vous \195\170tes actuellement en file d'attente pour {bg}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name.
	TITANBG_ACTIVE_INSTANCES    = "Nombre de champs de bataille en cours:";

	-- Ready
	TITANBG_CONFIRMJOIN   = "Vous avez la possibilit\195\169 d'entrer dans {bg}{time}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name. The {time} part of the string will be replaced by the time left before the queue expires.
	TITANBG_AUTOJOIN      = "Vous rejoindrez automatiquement {bg} dans {time}."; -- !! NOTE: The {bg} part of the string will be replaced by a specific battleground name. The {time} part of the string will be replaced by the join time.
	TITANBG_AUTOJOIN_HINT = "Astuce: Clic gauche pour arr\195\170ter/reprendre le compte \195\160 rebours de l'auto-join.";

	-- Battleground
	TITANBG_AUTOLEAVE = "Vous quitterez automatiquement le champs de bataille dans {time}."; -- !! NOTE: The {time} part of the string will be replaced by the join time.

	TITANBG_NO_INFORMATION       = "En recherche des informations";
	TITANBG_INSTANCE_RUN_TIME_NA = "Indisponible.";
	TITANBG_PLAYERS              = "Nombre de joueurs:";

	TITANBG_AB_WINNER         = "Vainqueur estim\195\169:";
	TITANBG_AB_FINAL_SCORE    = "Score final estim\195\169:";
	TITANBG_AB_TIME_LEFT      = "Temps restant estim\195\169:";
	TITANBG_AB_TO_WIN         = "Nombre de points strat\195\169giques n\195\169cessaires \195\160 votre faction pour gagner:";
	TITANBG_AB_TO_WIN_ENEMY   = "Nombre de points strat\195\169giques n\195\169cessaires \195\160 la faction adverse pour gagner:";
	TITANBG_AB_IMPOSSIBLE     = "Impossible.";
	TITANBG_AB_WINNER_UNKNOWN = "Inconnu.";

	TITANBG_PLAYER_STATS        = "Statistiques du joueur";
	TITANBG_PLAYER_STANDING     = "Position:";
	TITANBG_PLAYER_KILLINGBLOWS = "Coups fatals:";
	TITANBG_PLAYER_KILLS        = "Victoires honorables:";
	TITANBG_PLAYER_DEATHS       = "Morts:";

	TITANBG_LOCATION_STATS     = "Statistiques du joueur concernant les objectifs strat\95\169giques";
	TITANBG_PLAYER_GYASSAULTED = "Cimeti\195\168res attaqu\195\169s:";
	TITANBG_PLAYER_GYDEFENDED  = "Cimeti\195\168res d\195\169fendus:";
	TITANBG_PLAYER_TASSAULTED  = "Tours attaqu\195\169es:";
	TITANBG_PLAYER_TDEFENDED   = "Tours d\195\169fendues:";
	TITANBG_PLAYER_MCAPTURED   = "Mines captur\195\169es:";
	TITANBG_PLAYER_LKILLED     = "Chefs tu\195\169s:";
	TITANBG_PLAYER_SECOBJ      = "Objectifs secondaires:";
	TITANBG_PLAYER_FCAPTURED   = "Drapeaux captur\195\169s:";
	TITANBG_PLAYER_FRETURNED   = "Drapeaux rammen\195\169s:";
	TITANBG_PLAYER_BSASSULTED  = "Bases attaqu\195\169es:";
	TITANBG_PLAYER_BSDEFENDED  = "Bases d\195\169fendues:";
	TITANBG_PLAYER_BONUSHONOR  = "Points d'honneur bonus:";

	TITANBG_FRIENDS = "Amis";

	TITANBG_CAPTURE_TIMERS  = "Comptes \195\160 rebours de capture";
	TITANBG_CAPTURE_UNKNOWN = "Inconnu.";
	TITANBG_CAPTURE_IMINENT = "Capture imminente.";

	TITANBG_WIN_ESTIMATE = "Vainqueur estim\195\169:";
	TITANBG_FLAG_TRACKER = "Etat du drapeau:";
	TITANBG_FLAG         = "Drapeau:";

	TITANBG_SCOREFRAME_HINT = "Astuce: Clic gauche pour afficher la fen\195\170tre des scores.";
	TITANBG_MINIMAP_HINT    = "Astuce: MAJ + clic gauche pour afficher la carte tactique.";
	TITANBG_TOOLTIP_HINT    = "Astuce: CTRL + clic gauche pour changer les informations de l'infobulle.";

	-- ######################
	-- ## TITANBG MESSAGES ##
	-- ######################

	TITANBG_MESSAGE_NOTICE = TITAN_TITANBG_NAME .. " " .. TITANBG_VERSION  .. ". Developed by " .. TITANBG_AUTHOR .. ".";

	TITANBG_MESSAGE_CHANGEOVERWRITTEN = "Pour modifier cette option, utilisez Titan Battleground ou d\195\169cochez l'option '" .. TITANBG_MENU_OVERWRITESIMILAR .. "' dans la cat\195\169gorie '" .. TITANBG_MENU_GENERAL_OPTIONS .. "' des options de Titan Battleground.";
	TITANBG_MESSAGE_ACTIONOVERWRITTEN = "Cette option est bloqu\195\169e par Titan Battleground et ne sera pas utilis\1695\169e.\n\n|cffffffff" .. TITANBG_MESSAGE_CHANGEOVERWRITTEN;

	-- ##################
	-- ## NOMENCLATURE ##
	-- ##################

	-- Short names for the battlegrounds.
	TITANBG_BG_AV_SHORT  = "VA";
	TITANBG_BG_WSG_SHORT = "GDW";
	TITANBG_BG_AB_SHORT  = "BA";

	-- Sound file names.
	TITANBG_SOUND_DEFAULT   = "Par d\195\169faut";
	TITANBG_SOUND_CRASH     = "Collision";
	TITANBG_SOUND_LIGHTNING = "Foudre";
	TITANBG_SOUND_BELL      = "Cloche";
	TITANBG_SOUND_HORN      = "Corne de brume";
	TITANBG_SOUND_CYMBAL    = "Cymbales";
	TITANBG_SOUND_WHISTLE   = "Sifflement";
	TITANBG_SOUND_CHIME     = "Carillon";
	TITANBG_SOUND_TRUMPET   = "Trompette";

	-- ################
	-- ## REFERENCES ##
	-- ################

	-- This section has special requirements, as the translations reference Blizzard terminology.
	-- Please pay marked attention to the comments.

	-- Translate the section within the [""] only.
	-- Class names must be exactly as returned by UnitClass().
	TITANBG_CLASS = {
		["Druide"]           = "DRUID",
		["Chasseur"]         = "HUNTER",
		["Mage"]             = "MAGE",
		["Paladin"]          = "PALADIN",
		["Pr\195\170tre"]    = "PRIEST",
		["Voleur"]           = "ROGUE",
		["Chaman"]           = "SHAMAN",
		["D\195\169moniste"] = "WARLOCK",
		["Guerrier"]         = "WARRIOR",
	};

	-- Arathi Basin text, displayed at the top of the screen, listing the amount of resources captured by each faction. For example 'Resources: 0/2000'.
	-- Must be displayed exactly how it appears on the screen.
	TITANBG_AB_RESOURCES_DP = "Ressources:";

	-- These must be exactly as printed by the system while in Warsong Gulch.
	-- These are used for pattern matching and should not include the player's name or any text following or preceding it as applicable.
	TITANBG_WSG_PICKEDUP = "Le drapeau [%a ']+ a \195\169t\195\169 ramass\195\169 par"; -- Name following.
	TITANBG_WSG_DROPPED  = "Le drapeau [%a ']+ a \195\169t\195\169 lach\195\169 par"; -- Name following.
	TITANBG_WSG_CAPTURED = "a pris [lL]e drapeau [%a ']+!"; -- Name preceeding.

	-- !! WARNING !!
	-- These must apear exactly as sent by the system.
	-- This can be tested by making certain the lines between !! DEBUG START and !! DEBUG END
	-- are not commented (do not have a preceeding --) and typing '/console reloadui' into the chat window.

	-- 'BG = ' will display the name of the battleground. If the slot isn't taken up by a battleground,
	-- then it will display the zone you are currently in.

	-- Please make certain the text appears EXACTLY as printed. Do not insert capitals where they are not necessary,
	-- nor not include capitals when they are listed.

	-- Battleground Names
	TITANBG_BG_AV  = "Vall\195\169e d'Alterac";
	TITANBG_BG_WSG = "Goulet des Warsong";
	TITANBG_BG_AB  = "Bassin d'Arathi";

	-- !! END WARNING !!
end
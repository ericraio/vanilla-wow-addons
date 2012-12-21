-- File containing localized strings - FR
-- Translation by : frFR - Kiki


if ( GetLocale() == "frFR" ) then
  -- French localized variables
  -- �(à) �(á) �(â) �(ã) �(ä) �(æ) �(ç) �(è) �(é) �(ê) �(ë) �(î) �(ï) �(ò) �(ó) �(ô) �(õ) �(ö) �(ù) �(ú) �(û) �(ü) '(’)
  -- => Displayed strings
  GEM_CHAT_MISC_LOADED = "Chargé ! (/gem pour l’aide)";
  GEM_CHAT_CMD_PARAM_ERROR = "Erreur de paramètre pour la commande ";
  GEM_CHAT_CMD_UNKNOWN = "Commande inconnue pour /gem (essayez /gem help)";
  -- => Other strings
  
  GEM_TITLE		= "Guild Event Manager";
  GEM_TEXT_OBSOLETE = " (Version incompatible - Upgradez !)"
  GEM_TEXT_NEW_MINOR = " (Nouvelle version disponible)"
  GEM_TEXT_UPGRADE_NEEDED = "Une nouvelle version majeure de GEM est disponible. Il faut mettre à jour, sinon vous risquez de ne pas voir tous les événements !";
  GEM_TEXT_UPGRADE_SUGGESTED = "Une nouvelle version mineure de GEM est disponible. Il faut mettre à jour, afin de corriger les bugs !";
  
  GEM_HEADER_DATE		= "Date";
  GEM_HEADER_DATE_SERVER = "Heure serveur : ";
  GEM_HEADER_WHERE	= "Lieu";
  GEM_HEADER_LEADER	= "Organisateur";
  GEM_HEADER_COUNT	= "Titulaires";
  GEM_HEADER_MAX		= "Max";
  GEM_HEADER_RANGE_LEVEL	= "Niveau";
  
  GEMLIMIT_HEADER_CLASS = "Classe";
  GEMLIMIT_HEADER_MIN = "Min";
  GEMLIMIT_HEADER_MAX = "Max";
  GEMLIMIT_HEADER_TITULAR = "Titulaires";
  GEMLIMIT_HEADER_SUBSTITUTE = "Suppléants";
  GEMLIMIT_HEADER_REPLACEMENT = "Remplaçants";
  
  GEMADMIN_HEADER_PLACE = "Pos";
  GEMADMIN_HEADER_NAME = "Nom";
  GEMADMIN_HEADER_GUILD = "Guilde";
  GEMADMIN_HEADER_CLASS = "Classe";
  GEMADMIN_HEADER_LEVEL = "Niveau";
  
  GEM_TAB_LIST		= "Evénements";
  GEM_TAB_NEW		= "Créer";
  GEM_TAB_OPTIONS		= "Options"
  GEM_TAB_PLAYERS		= "Membres";
  
  GEM_TAB_LIST_CLASSES = "Limitations";
  GEM_TAB_LIST_DETAILS = "Details";
  GEM_TAB_LIST_ADMIN = "Inscrits";
  
  GEM_TEXT_PLAYER_JOINED = "%s arrive.";
  GEM_TEXT_PLAYER_LEFT = "%s s'en va.";
  
  GEM_TEXT_UNCLOSE	= "Réouvrir";
  GEM_TEXT_RECOVER	= "Récupérer";
  GEM_TEXT_DELETE	= "Effacer";
  GEM_TEXT_DELETE_CONFIRM = "Vraiment effacer cet événement ?"
  GEM_TEXT_UNSUBSCRIBE	= "Renoncer";
  GEM_TEXT_SUBSCRIBE	= "S'inscrire";
  GEM_TEXT_CREATE		= "Créer";
  GEM_TEXT_MODIFY		= "Modifier";
  GEM_TEXT_FORCETIT = "Forcer liste principale";
  GEM_TEXT_FORCESUB = "Forcer liste d'attente";
  GEM_TEXT_SETLEADER = "Nommer nouveau chef";
  GEM_TEXT_NO_REASON = "Pas de raison";
  GEM_TEXT_EVT_CHANNEL = "Canal %s";
  
  GEM_TEXT_DATE_CHOOSE	= "Choisir...";
  GEM_TEXT_WHERE		= "Lieu";
  GEM_TEXT_COMMENT = "Commentaire";
  GEM_TEXT_COUNT		= "Taille du raid/groupe";
  GEM_TEXT_LEVEL	    = "Niveau";
  GEM_TEXT_ERR_NO_WHERE = "Vous devez préciser un lieu";
  GEM_TEXT_GUILD_RANK = "Rang de guilde";
  GEM_TEXT_GEM_VERSION = "Version de GEM";
  
  GEM_HEADER_PLAYERS_NAME = "Nom";
  GEM_HEADER_PLAYERS_GUILD = "Guilde";
  GEM_HEADER_PLAYERS_LOCATION = "Lieu";
  GEM_HEADER_PLAYERS_LEVEL = "Niv.";
  GEM_HEADER_PLAYERS_CLASS = "Classe";
  GEM_TEXT_PLAYERS_SEEOFFLINE = "Voir déconnectés";
  GEM_TEXT_PLAYERS_COUNT = "%d membres (%d total)";

  GEM_TEXT_CHANNEL	= "Canal";
  GEM_TEXT_PASSWORD	= "MdP";
  GEM_TEXT_ALIAS = "Alias";
  GEM_TEXT_SLASH = "Slash";
  GEM_TEXT_DATE_FORMAT	= "Format d'affichage des dates";
  GEM_TEXT_DATE_USE_SERVER = "Utiliser l'heure du serveur";
  GEM_TEXT_SHOW_LOGS = "Notifie";
  GEM_TEXT_BIP_CHANNEL = "Jouer un son sur ce nom";
  GEM_TEXT_FILTER_EVENTS = "Filtrer les événements hors de mon level";
  GEM_TEXT_VALIDATE	= "Valider";
  GEM_TEXT_ERR_NEED_CHANNEL = "Vous devez donner un nom de canal";
  GEM_TEXT_ERR_NEED_ALIAS = "Vous devez donner un alias ET une commande slash";
  GEM_TEXT_ERR_DATE_OFFSET = "Vous devez donner une valeur numérique (ou 0) pour le décalage de l'heure";
  GEM_TEXT_ICON = "Ic\195\180ne de la Minimap";
  GEM_TEXT_ICON_ADJUST_ANGLE = "Ajuster l\'Angle";
  GEM_TEXT_ICON_ADJUST_RADIUS = "Ajuster le Rayon";
  GEM_TEXT_OPTIONS_ICONCHOICE = "Choix de l'icône de la minimap";
  GEM_TEXT_BUTTON_CHAN_ADD = "Ajouter";
  GEM_TEXT_BUTTON_CHAN_DEL = "Retirer";
  GEM_TEXT_BUTTON_CHAN_UPDT = "Modifier";

  GEM_TEXT_CLASS_LIMITATION = "Limitations des classes (min/max)"
  GEM_TEXT_CLASS_WARRIOR = "Guerrier";
  GEM_TEXT_CLASS_PALADIN = "Paladin";
  GEM_TEXT_CLASS_SHAMAN = "Chaman";
  GEM_TEXT_CLASS_ROGUE = "Voleur";
  GEM_TEXT_CLASS_MAGE = "Mage";
  GEM_TEXT_CLASS_WARLOCK = "Démoniste";
  GEM_TEXT_CLASS_HUNTER = "Chasseur";
  GEM_TEXT_CLASS_DRUID = "Druide";
  GEM_TEXT_CLASS_PRIEST = "Prêtre";
  
  GEM_TEXT_DETAILS_DESCRIPTION = "Description :";
  GEM_TEXT_DETAILS_SORTTYPE = "Mode d'ordonnancement :";
  GEM_TEXT_DETAILS_UNKNOWN = "Inconnu";
  GEM_TEXT_ADMIN_CLOSE = "Cloturer";
  GEM_TEXT_ADMIN_CLOSE_CONFIRM = "Cloturer cet événement ?";
  GEM_TEXT_ADMIN_SETLEADER_CONFIRM = "Nommer nouveau chef ?";
  GEM_TEXT_ADMIN_EDIT = "Modifier";
  GEM_TEXT_ADMIN_ASSISTANT = "Nommer assistant";
  GEM_TEXT_ADMIN_KICK = "Ejecter";
  GEM_TEXT_ADMIN_BAN = "Bannir";
  GEM_TEXT_ADMIN_BANNED = "Bannis";
  GEM_TEXT_ADMIN_ADDEXT = "Ajout externe";
  GEM_TEXT_ADMIN_GROUP = "Inviter tous";
  GEM_TEXT_ADMIN_IGNORE = "Ignorer";
  GEM_TEXT_ADMIN_IGNORE_CONFIRM = "Ignorer cet événement ?";
  GEM_TEXT_ADMIN_ERR_LEAVE_GROUP = "Vous ne pouvez pas faire de groupe pour une autre sortie. Quittez votre groupe d'abord.";
  GEM_TEXT_ADMIN_ERR_ALREADY_GROUP = "Attention : Vous déjà dans un groupe ou un raid !";
  GEM_TEXT_ADMIN_COMMENT = "Commentaire d'inscription";
  
  GEM_DATE_FORMAT		= "%a %d/%m/%Y %H:%M";
  GEM_HOUR_FORMAT = "%H:%M";
  GEM_DATE_CONVERT = {Mon="Lun", Tue="Mar", Wed="Mer", Thu="Jeu", Fri="Ven", Sat="Sam", Sun="Dim"};
  GEM_NA_FORMAT = "N/D";
  
  BINDING_HEADER_GEM = GEM_TITLE;
  BINDING_NAME_GEM_SHOW_EVENTS = "Afficher/Cacher la liste des événements";
  BINDING_NAME_GEM_SHOW_NEW = "Afficher/Cacher la création d'événement";
  BINDING_NAME_GEM_SHOW_MEMBERS = "Afficher/Cacher la liste des membres";
  BINDING_NAME_GEM_SHOW_CONFIG = "Afficher/Cacher la config";
  
  GEM_INSTANCES = {
          "Gouffre de Ragefeu",
          "Les Mortemines",
          "Cavernes des Lamentations",
          "Donjon d'Ombrecroc",
          "La Prison",
          "Profondeurs de Brassenoire",
          "Gnomeregan",
          "Kraal de Tranchebauge",
          "Monastere Ecarlate",
          "Souilles de Tranchebauge",
          "Uldaman",
          "Maraudon",
          "Zul'Farrak",
          "Le Temple Englouti",
          "Profondeurs de Blackrock",
          "Pic de Blackrock",
          "Stratholme",
          "Hache-tripes",
          "Scholomance",
          "Pic de Blackrock (Haut)",
          "Zul'Gurub",
          "Ruines d'Ahn'Qiraj",
          "Repaire d'Onyxia",
          "Coeur du Magma",
          "Le repaire de l'Aile Noire",
          "Temple d'Ahn'Qiraj",
          "BG Alterac",
          "BG Arathi",
          "BG Warsong"
  };
  
  GEM_TEXT_CALENDAR_SUNDAY = "D";
  GEM_TEXT_CALENDAR_MONDAY = "L";
  GEM_TEXT_CALENDAR_TUESDAY = "M";
  GEM_TEXT_CALENDAR_WEDNESDAY = "M";
  GEM_TEXT_CALENDAR_THURSDAY = "J";
  GEM_TEXT_CALENDAR_FRIDAY = "V";
  GEM_TEXT_CALENDAR_SATURDAY = "S";
  GEM_TEXT_CALENDAR_HEADER = "Choisissez l'heure de la date de la sortie";
  GEM_TEXT_CALENDAR_HELP = "Choisissez l'heure de votre sortie, et cliquez sur le jour pour valider. Le jour en vert est aujourd'hui.";
  GEMCalendar_Month = {"Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"};

  GEM_TEXT_BANNED_HEADER = "Liste des bannis pour cet événement";
  GEM_TEXT_BANNED_NAME = "Nom";
  GEM_TEXT_BANNED_REASON = "Raison de l'exclusion";
  GEM_TEXT_BANNED_UNBAN = "Débannir";

  GEM_TEXT_EXTERNAL_HEADER = "Ajout d'un joueur n'ayant pas GEM";
  GEM_TEXT_EXTERNAL_NAME = "Nom";
  GEM_TEXT_EXTERNAL_GUILD = "Guilde";
  GEM_TEXT_EXTERNAL_CLASS = "Classe";
  GEM_TEXT_EXTERNAL_LEVEL = "Niveau";
  GEM_TEXT_EXTERNAL_COMMENT = "Commentaire";
  GEM_TEXT_EXTERNAL_FORCESUB = "En liste d'attente";
  GEM_TEXT_EXTERNAL_ADD = "Ajouter";
  GEM_TEXT_EXTERNAL_TARGET = "Ajouter la cible";
  GEM_TEXT_EXTERNAL_ERR_LEVEL = "Joueur externe invalide : Niveau non compris dans la plage autorisée";
  GEM_TEXT_EXTERNAL_ERR_GIVE_NAME = "Vous devez specifier le nom du joueur";
  GEM_TEXT_EXTERNAL_ERR_GIVE_LEVEL = "Vous devez specifier le niveau du joueur";
  GEM_TEXT_EXTERNAL_ERR_INVALID = "Cible incorrecte";
  
  GEM_TEXT_TEMPLATE_HEADER = "Profils";
  GEM_TEXT_TEMPLATE_SAVE = "Sauver";
  GEM_TEXT_TEMPLATE_LOAD = "Charger";
  GEM_TEXT_TEMPLATE_DELETE = "Effacer";
  GEM_TEXT_ERR_NO_TEMPLATE = "Echec de la sauvegarde de profil : Vous devez donner un nom de profil";
  GEM_TEXT_TEMPLATE_SAVED = "Profil sauvegardé !";
  
  GEM_TEXT_REROLL_ERR_SELECT = "Vous ne pouvez pas sélectionner ce personnage, car le canal GEM défini pour celui-ci n'est pas le même que le canal courant.";
  GEM_TEXT_SORTING_HEADER = "Mode d'ordonnancement";
  GEM_TEXT_SORTING_CONFIGURE = "Configurer";

  GEM_TEXT_TOOLTIP_KICKED = "Ejecté de l'événement : ";
  GEM_TEXT_TOOLTIP_BANNED = "Banni de l'événement : ";
  GEM_TEXT_TOOLTIP_CLOSED = "Evénement clos : ";
  GEM_TEXT_ERR_LEVEL_FAILED = "Votre niveau n'est pas dans la plage autorisée pour cet événement.";
  GEM_TEXT_CHAT_KICKED = "Je viens d'être éjecté de l'événement à ";
  GEM_TEXT_CHAT_BANNED = "Je viens d'être banni de l'événement à ";
  GEM_TEXT_CHAT_UNBANNED = "Je viens d'être débanni de l'événement à ";
  GEM_TEXT_CHAT_ASSISTANT = "Je viens d'être nommer assistant de l'événement à ";
  
  GEM_TEXT_NEW_EVENTS_AVAILABLE = "Nouveaux événements : ";
  GEM_TEXT_USAGE = "Utilisation:";
  
  GEM_HELP_EVENTS_TAB_EVENTS = "|c00FFFFFFCode de couleur pour la liste des événements :|r\n"..
    "  - |c00606060Tous les champs gris|r = Evénement clos\n"..
    "  - |c00FFFFFFLieu :|r\n".."    - |c0000FF00Vert|r = Nouvel événement\n".."    - |c00FFFFFFBlanc|r = Ancien événement\n"..
    "  - |c00FFFFFFOrganisateur :|r\n".."    - |c0000FF00Vert|r = Connecté\n".."    - |c00FFFFFFBlanc|r = Non connecté\n"..
    "  - |c00FFFFFFTitulaires :|r\n".."    - |c00FFFFFFBlanc|r = Non inscrit\n".."    - |c00D000E0Violet|r = Niveau requis incorrect\n".."    - |c00606060Gris foncé|r = Inscription envoyée, mais pas encore validée\n".."    - |c00E0E000Jaune|r = Inscrit en liste d'attente\n".."    - |c004040FFBleu|r = Inscrit en liste secondaire\n".."    - |c0000FF00Vert|r = Inscrit en liste principale\n".."    - |c00800000Rouge foncé|r = Ejecté de l'événement\n".."    - |c00FF0000Rouge clair|r = Banni de l'événement\n\n"..
    "|c00FFFFFFInformations complémentaires :|r\n"..
    " Lorsque vous vous inscrivez à un événement et que le responsable\n"..
    " n'est pas connecté, vous devez attendre que celui-ci arrive afin\n"..
    " qu'il valide votre demande.\n"..
    " Vous pouvez cependant voir dans la liste des inscrits les joueurs\n"..
    " dont la demande n'est pas encore validée par le signe 'NA'.";
  GEM_HELP_PLAYERS_TAB_MEMBERS = "|c00FFFFFFCode de couleur pour la liste des membres :|r\n"..
    "  - |c00606060Tous les champs gris|r = Non connecté\n"..
    "  - |c00FFFFFFGuilde :|r\n".."    - |c00FFFFFFBlanc|r = Membre normal\n".."    - |c004040FFBleu|r = Officier de guilde\n".."    - |c0000FF00Vert|r = Responsable de guilde\n\n"..
    "|c00FFFFFFInformations complémentaires :|r\n"..
    " Afin d'optimiser le transit des messages sur le canal de GEM,\n"..
    " il se peut que cette liste mette un certain temps pour se remplir\n"..
    " lors de votre première connexion au canal.\n"..
    " En outre lorsque vous vous connectez (toujours dans le même souci),\n"..
    " le lieu des autres membres reste à 'N/D' jusqu'à ce que chaque joueur\n"..
    " change de zone de jeu.";
  GEM_HELP_NEW_TAB_TEMPLATES = "|c00FFFFFFLes profils :|r\n"..
    " Ils vous permettent de sauver sous le nom de votre choix\n"..
    " (en vue d'un chargement ultérieur), la configuration complête\n"..
    " des champs de création d'événement (lieu, commentaire, taille,\n"..
    " niveaux, limitations de classes).";
  GEM_HELP_NEW_TAB_SORTING = "|c00FFFFFFLe mode d'ordonnancement :|r\n"..
    " Sélectionne (et configure) l'algorithme qui sera utilisé\n"..
    " pour ordonner les inscriptions des joueurs dans les files\n"..
    " principales et secondaires.";

  GEM_HELP_NEW_TAB_CONFIG = "|c00FFFFFFAide de configuration :|r\n\n"..
    "|c00FFFFFF"..GEM_TEXT_CHANNEL.." :|r\n"..
    " C'est le nom du canal pour vont �tre envoyés les messages de GEM.\n"..
    " Demandez à votre guilde/alliance ces parametres si vous ne les connaissez pas.\n"..
    "|c00FFFFFF"..GEM_TEXT_PASSWORD.." :|r\n"..
    " C'est le mot de passe pour pouvoir acceder au canal.\n"..
    "|c00FFFFFF"..GEM_TEXT_ALIAS.." :|r\n"..
    " C'est le nom sous lequel seront affichés les messages de texte.\n"..
    " Il s'agit purement d'affichage, vous pouvez mettre ce que vous voulez.\n"..
    "|c00FFFFFF"..GEM_TEXT_SLASH.." :|r\n"..
    " C'est la commande à taper pour parler directement dans le canal de GEM.\n"..
    " Notez que vous devez préciser un alias ET une commande slash pour que\n"..
    " cela fonctionne. De plus vous ne pouvez envoyer des liens d'objet qu'à\n"..
    " partir d'une commande slash, cela ne marche pas avec un /# (numéro de canal).\n"..
    "|c00FFFFFF"..GEM_TEXT_SHOW_LOGS.." :|r\n"..
    " Affiche ou non les notifications lorsqu'un joueur arrive ou part du canal.\n"..
    "|c00FFFFFF"..GEM_TEXT_COMMENT.." :|r\n"..
    " Commentaire à afficher pour votre perso dans la liste des membres.\n"..
    "|c00FFFFFF"..GEM_TEXT_BIP_CHANNEL.." :|r\n"..
    " Jouer un son quand le nom spécifié est dit dans le canal de GEM.\n"..
    "|c00FFFFFF"..GEM_TEXT_DATE_FORMAT.." :|r\n"..
    " Le format sous lequel vous voulez voir les dates s'afficher.\n"..
    " (option avancée, voir http://www.opengroup.org/onlinepubs/007908799/xsh/strftime.html)\n"..
    "|c00FFFFFF"..GEM_TEXT_DATE_USE_SERVER.." :|r\n"..
    " Si cette option est activée, le calendrier de GEM utilisera l'heure du serveur.\n"..
    " De plus, tous les événements de la liste afficheront l'heure du serveur.\n"..
    "|c00FFFFFF"..GEM_TEXT_FILTER_EVENTS.." :|r\n"..
    " Affiche ou non les événements hors de la plage de niveau du personnage sélectionné.\n";

  GEM_DRUNK_MESSAGES = {
    "Vous êtes un peu pompette. Ouh !",
    "Vous avez trop bu. Oups !",
    "Vous sentez que vous avez vraiment trop bu.",
  };
  GEM_DRUNK_MESSAGES_COUNT = 3;
  GEM_DRUNK_NORMAL = "Vous vous sentez de nouveau sobre.";
  
  GEM_TEXT_NEW_CLOSE_CONFIRM = "Effacer ce Profil ?";
  GEM_TEXT_NEW_AUTOMEMBERS_BUTTON = "Ajout-auto...";
  GEM_TEXT_NEW_AUTOMEMBERS_TITLE = "Ajouter automatiquement \195\160 un nouvel \195\169v\195\169nement";
  GEM_TEXT_NEW_AUTOMEMBERS_ADD_TITULAR = "Ajouter un joueur";
  GEM_TEXT_NEW_AUTOMEMBERS_ADD_REPLACEMENT = "Ajouter en attente";
  GEM_TEXT_NEW_AUTOMEMBERS_FILL_TITULAR = "Joueur \195\160 ajouter en liste Principale/Secondaire";
  GEM_TEXT_NEW_AUTOMEMBERS_FILL_REPLACEMENT = "Joueur \195\160 ajouter en liste d'attente";
  
  -- Event Calendar
  GEM_EVENT_CALENDAR_VIEW = "Vue calendrier";
  GEM_EVENT_CALENDAR_INSTANCE_RESET = "Afficher reset instances";
  GEM_EVENT_CALENDAR_INSTANCE_NONE_NAME = "Aucune";
  GEM_EVENT_CALENDAR_INSTANCE_ONYXIA_NAME = "Onyxia";
  GEM_EVENT_CALENDAR_INSTANCE_MC_NAME = "Coeur du magma";
  GEM_EVENT_CALENDAR_INSTANCE_BWL_NAME = "Repaire de l'aile noire";
  GEM_EVENT_CALENDAR_INSTANCE_ZG_NAME = "Zul'Gurub";
  GEM_EVENT_CALENDAR_INSTANCE_AQ20_NAME = "Ruines d'Ahn'Qiraj";
  GEM_EVENT_CALENDAR_INSTANCE_AQ40_NAME = "Temple d'Ahn'Qiraj";
  
  GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR = "fr";

  GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_1 = 1136242800; -- Onyxia
  GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_2 = 1136329200; -- MC/BWL/AQ40
  GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_3 = 1136329200; -- ZG/AQ20
  
end

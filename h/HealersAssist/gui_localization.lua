--[[
  Healers Assist GUI Localization file
]]


if ( GetLocale() == "frFR" ) then
  -- French localized variables
  -- �(à) �(á) �(â) �(ã) �(ä) �(æ) �(ç) �(è) �(é) �(ê) �(ë) �(î) �(ï) �(ò) �(ó) �(ô) �(õ) �(ö) �(ù) �(ú) �(û) �(ü) '(’)

  -- => BINDINGS STRINGS
  BINDING_HEADER_HA = "Healers Assist";
  BINDING_NAME_HA_SHOW = "Afficher/Cacher la fenêtre principale de Healers Assist";
  BINDING_NAME_HA_SHOW_CONFIG = "Afficher/Cacher la fenêtre de configuration de Healers Assist";
  BINDING_NAME_HA_EMERG1 = "S�lectionne la cible d\'urgence 1";
  BINDING_NAME_HA_EMERG2 = "S�lectionne la cible d\'urgence 2";
  BINDING_NAME_HA_EMERG3 = "S�lectionne la cible d\'urgence 3";
  BINDING_NAME_HA_EMERG4 = "S�lectionne la cible d\'urgence 4";
  BINDING_NAME_HA_EMERG5 = "S�lectionne la cible d\'urgence 5";
  
  -- => MAIN WINDOW STRINGS
  HA_GUI_HEALERS_HEALER = "Soigneur";
  HA_GUI_HEALERS_SPELL = "Sort";
  HA_GUI_HEALERS_TARGET = "Cible";
  HA_GUI_HEALERS_CASTING = "Progres.";
  HA_GUI_EMERG_NAME = "Nom";
  HA_GUI_EMERG_DEFICIT = "Déficit";
  HA_GUI_EMERG_COUNT = "Nombre";
  HA_GUI_EMERG_ESTIM = "Estim.";
  HA_GUI_COLLAPSE = "Replier";
  HA_GUI_RESTING = "Repos";
  HA_GUI_RESTING_STATE = "En r\195\169gen";

  -- => TOOLTIP STRINGS
  HA_GUI_TOOLTIP_MINIMAP = "Healers Assist\nClic gauche pour ouvrir la fenêtre\nClic droit pour le sous menu";
  HA_GUI_TOOLTIP_GOT_SPELL = "%2$s a lancé %1$s"; -- $1=spell $2=from
  HA_GUI_TOOLTIP_READY = "%s est prêt !"; -- $1=spell
  HA_GUI_TOOLTIP_COOLDOWN = "%s est encore en recharge :"; -- $1=spell
  
  -- => SUB-MENU STRINGS
  HA_GUI_SUBMENU_OPEN_OPTIONS = "Ouvre le menu des options";
  HA_GUI_SUBMENU_LOCK = "Verrouiller la fenêtre";
  HA_GUI_SUBMENU_UNLOCK = "Déverrouiller la fenêtre";

  -- => CONFIG STRINGS
  HA_GUI_MAIN_MENU_GENERAL = "Options generales";
  HA_GUI_MAIN_MENU_HEALERS = "Options de la liste des soigneurs";
  HA_GUI_MAIN_MENU_EMERGENCY = "Options de la liste d'urgence";
  HA_GUI_MAIN_MENU_PLUGINS = "Options des plugins";

  HA_GUI_TITLE = "HA Config";
  HA_GUI_CHANOPT_TITLE = "Options du canal";
  HA_GUI_CHANOPT_CHAN_NAME = "Nom du canal";
  HA_GUI_CHANOPT_SYNC_CTRAID = "Utiliser le canal de CTRaid";
  HA_GUI_CHANOPT_VALIDATE = "Valider";
  HA_GUI_SCALE_TITLE = "Echelle fenêtre principale : ";
  HA_GUI_ALPHA_TITLE = "Opacité fenêtre principale : ";
  HA_GUI_BACKDROP_ALPHA_TITLE = "Opacité du fond : ";
  HA_GUI_GUI_REFRESH_TITLE = "Délai de rafraichissement UI : ";
  HA_GUI_EMERGOPT_TITLE = "Options des cibles d'urgence";
  HA_GUI_EMERGOPT_LINES_TITLE = "Nombre de lignes d'urgence visibles : ";
  HA_GUI_EMERGOPT_MIN_HEALTH_TITLE = "% minimum de vie pour afficher une cible d'urgence : ";
  HA_GUI_EMERGOPT_GRPS_TITLE = "Afficher les groupes suivants (Raid seulement)";
  HA_GUI_EMERGOPT_GRPS_G1 = "Grp1";
  HA_GUI_EMERGOPT_GRPS_G2 = "Grp2";
  HA_GUI_EMERGOPT_GRPS_G3 = "Grp3";
  HA_GUI_EMERGOPT_GRPS_G4 = "Grp4";
  HA_GUI_EMERGOPT_GRPS_G5 = "Grp5";
  HA_GUI_EMERGOPT_GRPS_G6 = "Grp6";
  HA_GUI_EMERGOPT_GRPS_G7 = "Grp7";
  HA_GUI_EMERGOPT_GRPS_G8 = "Grp8";
  HA_GUI_EMERGOPT_CLASSES_TITLE = "Afficher les classes suivantes";
  HA_GUI_EMERGOPT_CLASSES_DRUID = "Druide";
  HA_GUI_EMERGOPT_CLASSES_HUNTER = "Chasseur";
  HA_GUI_EMERGOPT_CLASSES_MAGE = "Mage";
  HA_GUI_EMERGOPT_CLASSES_PRIEST = "Prêtre";
  HA_GUI_EMERGOPT_CLASSES_ROGUE = "Voleur";
  HA_GUI_EMERGOPT_CLASSES_WARLOCK = "Démoniste";
  HA_GUI_EMERGOPT_CLASSES_WARRIOR = "Guerrier";
  HA_GUI_EMERGOPT_CLASSES_PALA_SHAM = "Pala/Cham";
  HA_GUI_EMERGOPT_FILTER_RANGE = "N'affiche que les joueurs à moins de 30m";
  HA_GUI_HEALOPT_ALLOWSPELLS_TITLE = "Autoriser la demande pour ces sorts";
  HA_GUI_HEALOPT_TITLE = "Options de la liste des soigneurs";
  HA_GUI_HEALOPT_LINES_TITLE = "Nombre de lignes de soigneurs visibles : ";
  HA_GUI_HEALOPT_KEEP_SPELL_TITLE = "Rémanence des sorts lancés : "
  HA_GUI_HEALOPT_KEEP_SPELL_SHORT = "Court";
  HA_GUI_HEALOPT_KEEP_SPELL_LONG = "Long";
  HA_GUI_HEALOPT_SHOW_INSTANTS = "Montre les sorts instantanés (dispel ou autre)";
  HA_GUI_HEALOPT_SHOW_HOTS = "Montre les soins sur le temps";
  HA_GUI_HEALOPT_GROW_UPWARDS = "La fen\195\170tre s'\195\169tend vers le haut";
  HA_GUI_HEALOPT_NOTIFY_REGEN = "Afficher un message quand un soigneur entre ou sort de r\195\169cup mana";
  HA_GUI_HEALOPT_CLASSES_DRUID = "Druide";
  HA_GUI_HEALOPT_CLASSES_PRIEST = "Prêtre";
  HA_GUI_HEALOPT_CLASSES_PALA_SHAM = "Pala/Cham";
  HA_GUI_PLUGINS_AUTO = "Auto";
  HA_GUI_PLUGINS_LOAD = "Activer";
  HA_GUI_PLUGINS_NAME = "Nom du plugin";
  HA_GUI_PLUGINS_CONFIGURE = "Configurer";
  HA_GUI_MINIMAP_TITLE = "Position de l'icone autour de la mini-carte";
  HA_GUI_AUTO_OPEN = "Ouvre automatiquement en groupe ou en raid";
  HA_GUI_REALTIME_LIFE_UPDATES = "Mise \195\160 jour temps r\195\169el de la vie (Exp\195\169rimental)";
  HA_GUI_CLOSE = "Fermer";
  HA_GUI_BACK = "Retour";
  HA_FAILED_TEXT_OUT_OF_SIGHT = "Hors vue";
  HA_FAILED_TEXT_TOO_FAR = "Trop loin";
  HA_FAILED_TEXT_DEAD = "Mort !!";

  HA_HELP_CHAN_OPT = "|c00FFFFFF"..HA_GUI_CHANOPT_CHAN_NAME.." :|r\n"..
    "  Indiquez ici le nom du canal à utiliser.\n"..
    "  Tous les soigneurs doivent être sur le même canal pour voir\n"..
    "   les informations des sorts utilisés par les autres.\n\n"..
    "|c00FFFFFF"..HA_GUI_CHANOPT_SYNC_CTRAID.." :|r\n"..
    "  Si vous cochez cette case et que CTRaid est installé,\n"..
    "   alors HA va se synchroniser automatiquement sur le canal\n"..
    "   de CTRaid à chaque broadcast.\n"..
    "  Quand vous cochez la case, HA recherche le canal actuel\n"..
    "   configuré pour CTRaid et l'indique dans la boîte de saisie.\n\n"..
    "|c00FFFFFF"..HA_GUI_CHANOPT_VALIDATE.." :|r\n"..
    "  Vous devez cliquer sur ce bouton pour valider les changements\n"..
    "   dans les options du canal.";

  HA_HELP_HEAL_OPT = "|c00FFFFFF"..HA_GUI_HEALOPT_KEEP_SPELL_TITLE.." :|r\n"..
    "  Indiquez ici combien de temps vous voulez que les sorts\n"..
    "   restent affichés dans la liste des soigneurs, après la fin\n"..
    "   de leur lancement (réussi ou non).\n\n"..
    "|c00FFFFFF"..HA_GUI_HEALOPT_SHOW_INSTANTS.." :|r\n"..
    "  Si vous cochez cette case, les sorts instantannés qui\n"..
    "   ne soignent pas (dispell par exemple), seront affichés.\n\n"..
    "|c00FFFFFF"..HA_GUI_HEALOPT_SHOW_HOTS.." :|r\n"..
    "  Si vous cochez cette case, les sorts instantannés qui\n"..
    "   soignent sur le temps (rénovation par exemple), seront affichés.\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_CLASSES_TITLE.." :|r\n"..
    "  Choisissez les classes que vous voulez voir apparaitre\n"..
    "   dans la liste des soigneurs.";

  HA_HELP_EMERG_OPT = "|c00FFFFFF"..HA_GUI_EMERGOPT_MIN_HEALTH_TITLE.." :|r\n"..
    "  Indiquez ici le pourcentage minimum de vie que doit avoir\n"..
    "   un membre du groupe ou du raid, pour qu'il apparaisse dans\n"..
    "   la liste des soins d'urgence.\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_GRPS_TITLE.." :|r\n"..
    "  Choisissez les groupes que vous voulez voir apparaitre\n"..
    "   dans la liste des soins d'urgence.\n"..
    "  Cette option n'est valable qu'en mode de RAID.\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_CLASSES_TITLE.." :|r\n"..
    "  Choisissez les classes que vous voulez voir apparaitre\n"..
    "   dans la liste des soins d'urgence.";

  -- => POPUP STRINGS
  HA_GUI_POPUP_REQUEST_FOR_SPELL = "%s demande le sort %s\nLe lancer automatiquement ?"; -- $1=from $2=spell
  HA_GUI_POPUP_REQUEST_FOR_SPELL_WITH_FAILURE = "%s demande le sort %s\nLe lancer automatiquement ?\n|cffff0000(%s)"; -- $1=from $2=spell $3=Failure

  -- => SPELL REQUEST DENIED STRINGS
  HA_SpellRequestDenied = -- $1=spell $2=from
  {
    [1] = "Demande du sort %s refus\195\169e par %s",
    [2] = "Sort %s automatiquement bloqu\195\169 par %s",
    [3] = "Demande du sort %s refus\195\169e par %s : Il traite d\195\169j\195\160 une demande",
  };

  -- => SPELL REQUEST STRINGS
  HA_GUI_REQUEST_NOT_DEAD_YET = "Tu devrais peut \195\170tre attendre d'\195\170tre mort avant de demander une r\195\169surrection ?";
  HA_GUI_REQUEST_YOU_ARE_DEAD = "D\195\169sol\195\169 mais *hum comment dire*, tu es mort !";
  HA_GUI_REQUEST_SEARCH_OK = "'%s' trouv\195\169 chez %s. Demande envoy\195\169e !";
  HA_GUI_REQUEST_SEARCH_FAILED = "Aucun '%s' disponible !";
  HA_GUI_REQUEST_SEARCH_INVALID_SPELL = "Le sort '%s' ne fait pas partie de la liste des sorts qu'on peut demander";

  
elseif ( GetLocale() == "deDE" ) then

-- German

-- => BINDINGS STRINGS
BINDING_HEADER_HA = "Healers Assist";
BINDING_NAME_HA_SHOW = "Healers Assist Fenster anzeigen/verstecken";
BINDING_NAME_HA_SHOW_CONFIG = "Healers Assist Konfigurationsfenster anzeigen/verstecken";
BINDING_NAME_HA_EMERG1 = "Emergency 1 ausw\195\164hlen";
BINDING_NAME_HA_EMERG2 = "Emergency 2 ausw\195\164hlen";
BINDING_NAME_HA_EMERG3 = "Emergency 3 ausw\195\164hlen";
BINDING_NAME_HA_EMERG4 = "Emergency 4 ausw\195\164hlen";
BINDING_NAME_HA_EMERG5 = "Emergency 5 ausw\195\164hlen";
 
-- => MAIN WINDOW STRINGS
HA_GUI_HEALERS_HEALER = "Heiler";
HA_GUI_HEALERS_SPELL = "Zauber";
HA_GUI_HEALERS_TARGET = "Ziel";
HA_GUI_HEALERS_CASTING = "Wirkt";
HA_GUI_EMERG_NAME = "Name";
HA_GUI_EMERG_DEFICIT = "Verlust";
HA_GUI_EMERG_COUNT = "Anzahl";
HA_GUI_EMERG_ESTIM = "Voraussi.";
HA_GUI_COLLAPSE = "Verkleinern";
HA_GUI_RESTING = "Reg."; -- Warning must not exceed 4 characters (5 MAX !!)
HA_GUI_RESTING_STATE = "regeneriert";

-- => TOOLTIP STRINGS
HA_GUI_TOOLTIP_MINIMAP = "Healers Assist\nLincksklick: Hauptfenster\nRechtsklick: Untermen\195\188";
HA_GUI_TOOLTIP_GOT_SPELL = "bekommt %s von %s"; -- $1=spell $2=from
HA_GUI_TOOLTIP_READY = "%s ist bereit!"; -- $1=spell
HA_GUI_TOOLTIP_COOLDOWN = "%s Cooldown:"; -- $1=spell

-- => SUB-MENU STRINGS
HA_GUI_SUBMENU_OPEN_OPTIONS = "Zeige Optionen";
HA_GUI_SUBMENU_LOCK = "Fenster sperren";
HA_GUI_SUBMENU_UNLOCK = "Fenster entsperren";

-- => CONFIG STRINGS
  HA_GUI_MAIN_MENU_GENERAL = "Allgemeine Optionen";
  HA_GUI_MAIN_MENU_HEALERS = "Heileransicht Optionen";
  HA_GUI_MAIN_MENU_EMERGENCY = "Emergency Liste Optionen";
  HA_GUI_MAIN_MENU_PLUGINS = "Plugins Optionen";

HA_GUI_TITLE = "HA Konfiguration";
HA_GUI_CHANOPT_TITLE = "Channel - Optionen";
HA_GUI_CHANOPT_CHAN_NAME = "Channel Name";
HA_GUI_CHANOPT_SYNC_CTRAID = "Sync mit CTRaid Channel";
HA_GUI_CHANOPT_VALIDATE = "Zuweisen";
HA_GUI_SCALE_TITLE = "Hauptfenster Skalierung: ";
HA_GUI_ALPHA_TITLE = "Hauptfenster Deckkraft: ";
HA_GUI_BACKDROP_ALPHA_TITLE = "Hintergrund Deckkraft: "; 
HA_GUI_GUI_REFRESH_TITLE = "UI Update Rate: ";
HA_GUI_EMERGOPT_TITLE = "Emergency Liste - Optionen";
HA_GUI_EMERGOPT_LINES_TITLE = "Anzahl der sichtbaren Emergency Zeilen: ";
HA_GUI_EMERGOPT_MIN_HEALTH_TITLE = "Minimale Gesundheit des Ziels in Prozent: ";
HA_GUI_EMERGOPT_GRPS_TITLE = "Anzuzeigende Gruppen";
HA_GUI_EMERGOPT_GRPS_G1 = "Grp1";
HA_GUI_EMERGOPT_GRPS_G2 = "Grp2";
HA_GUI_EMERGOPT_GRPS_G3 = "Grp3";
HA_GUI_EMERGOPT_GRPS_G4 = "Grp4";
HA_GUI_EMERGOPT_GRPS_G5 = "Grp5";
HA_GUI_EMERGOPT_GRPS_G6 = "Grp6";
HA_GUI_EMERGOPT_GRPS_G7 = "Grp7";
HA_GUI_EMERGOPT_GRPS_G8 = "Grp8";
HA_GUI_EMERGOPT_CLASSES_TITLE = "Anzuzeigende Klassen";
HA_GUI_EMERGOPT_CLASSES_DRUID = "Druide";
HA_GUI_EMERGOPT_CLASSES_HUNTER = "J\195\164ger";
HA_GUI_EMERGOPT_CLASSES_MAGE = "Magier";
HA_GUI_EMERGOPT_CLASSES_PRIEST = "Priester";
HA_GUI_EMERGOPT_CLASSES_ROGUE = "Schurke";
HA_GUI_EMERGOPT_CLASSES_WARLOCK = "Hexen.";
HA_GUI_EMERGOPT_CLASSES_WARRIOR = "Krieger";
HA_GUI_EMERGOPT_CLASSES_PALA_SHAM = "Pala/Sham";
HA_GUI_EMERGOPT_FILTER_RANGE = "Nur Spieler  im Radius von 30m anzeigen";
HA_GUI_HEALOPT_ALLOWSPELLS_TITLE = "Zauber Anfragen f\195\188r diese zauber zulassen";
HA_GUI_HEALOPT_TITLE = "Heileransicht - Optionen";
HA_GUI_HEALOPT_LINES_TITLE = "Anzahl der sichtbaren Heiler Zeilen: ";
HA_GUI_HEALOPT_KEEP_SPELL_TITLE = "Zeige gewirkte Zauber f\195\188r: ";
HA_GUI_HEALOPT_KEEP_SPELL_SHORT = "Kurz";
HA_GUI_HEALOPT_KEEP_SPELL_LONG = "Lang";
HA_GUI_HEALOPT_SHOW_INSTANTS = "Zeige sofortgew. Zauber";
HA_GUI_HEALOPT_SHOW_HOTS = "Zeige HoTs";
HA_GUI_HEALOPT_GROW_UPWARDS = "Fenster nach oben erweitern";
HA_GUI_HEALOPT_NOTIFY_REGEN = "Benachrichtigen wenn ein Heiler anf\195\164ngt/aufh\195\182rt zu regenerieren";
HA_GUI_HEALOPT_CLASSES_DRUID = "Druide";
HA_GUI_HEALOPT_CLASSES_PRIEST = "Priester";
HA_GUI_HEALOPT_CLASSES_PALA_SHAM = "Pala/Sham";
HA_GUI_PLUGINS_AUTO = "Auto";
HA_GUI_PLUGINS_LOAD = "Aktivieren";
HA_GUI_PLUGINS_NAME = "Plugin Name";
HA_GUI_PLUGINS_CONFIGURE = "Konfigurieren";
HA_GUI_MINIMAP_TITLE = "Position des Minimap Icons";
HA_GUI_AUTO_OPEN = "Automatisch \195\182ffnen wenn in Gruppe/Raid";
HA_GUI_REALTIME_LIFE_UPDATES  = "Realtime life updates (experimental)";
HA_GUI_CLOSE = "Schlie\195\159en";
HA_GUI_BACK = "Zur\195\188ck";
HA_FAILED_TEXT_OUT_OF_SIGHT = "Nicht in Sicht";
HA_FAILED_TEXT_TOO_FAR = "Zu weit";
HA_FAILED_TEXT_DEAD = "Tot!";

   HA_HELP_CHAN_OPT = "|c00FFFFFF"..HA_GUI_CHANOPT_CHAN_NAME..":|r\n"..
    "  Hier wird der Channel angegeben.\n"..
    "  Alle Heiler m\195\188ssen in dem selben channel sein\n"..
    "  um die Casts der anderen Heiler zu sehen\n\n"..
    "|c00FFFFFF"..HA_GUI_CHANOPT_SYNC_CTRAID..":|r\n"..
    "  Wenn diese Box angeklickt wird und CTRaidAssist installiert ist,\n"..
    "  wird automatisch der CTRaidAssist Channel benutzt\n"..
    "  Beim aktivieren dieser Checkbox wird der aktuelle Chanel ermittelt\n\n"..
    "|c00FFFFFF"..HA_GUI_CHANOPT_VALIDATE..":|r\n"..
    "  Diere Button muss bet\195\164tigt werden um die \195\132nderungen zu \195\188bernehmen";

   HA_HELP_HEAL_OPT = "|c00FFFFFF"..HA_GUI_HEALOPT_KEEP_SPELL_TITLE.."|r\n"..
    "  Hier wird angegeben wilange erfolgreiche Zauber angezeigt werden sollen\n\n"..
    "|c00FFFFFF"..HA_GUI_HEALOPT_SHOW_INSTANTS.." :|r\n"..
    "  Durch aktivieren dieser Controlbox werden sofortgewirkte Zauber\n"..
    "  die nicht heilen angezeigt (dispell, etc.)\n\n"..
    "|c00FFFFFF"..HA_GUI_HEALOPT_SHOW_HOTS.." :|r\n"..
    "  Duch aktivieren dieser Controlbox werden sofortgewirkte HoT Zauber\n"..
    "  angezeigt (z.B. Erneuerung).\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_CLASSES_TITLE.." :|r\n"..
    "  Hier kannst du w\195\164hlen welche Klassen angezeigt werden sollen";
 
  HA_HELP_EMERG_OPT = "|c00FFFFFF"..HA_GUI_EMERGOPT_MIN_HEALTH_TITLE.." :|r\n"..
    "  Hier kannst du einstellen ab wann Spieler in der\n"..
    "  Emergency Liste angezeigt werden sollen.\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_GRPS_TITLE.." :|r\n"..
    "  Hier kannst du die Gruppen einstellen die in der Emergency Liste\n"..
    "  angezeigt werden sollen (nur im Raid)\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_CLASSES_TITLE.." :|r\n"..
    "  Hier kannst du die Klassen einstellen die in der Emergency Liste\n"..
    "  angezeigt werden sollen (nur im Raid)";

  -- => POPUP STRINGS
  HA_GUI_POPUP_REQUEST_FOR_SPELL = "%s bittet um %s\nAutomatisch zaubern?"; -- $1=from $2=spell
  HA_GUI_POPUP_REQUEST_FOR_SPELL_WITH_FAILURE = "%s bittet um %s\nAutomatisch zaubern?\n|cffff0000(%s)"; -- $1=from $2=spell $3=Failure

  -- => SPELL REQUEST DENIED STRINGS
  HA_SpellRequestDenied = -- $1=spell $2=from
  {
    [1] = "Bitte um %s wurde von %s abgelehnt",
    [2] = "Zauber wurde %s automatisch von %s geblockt",
    [3] = "Bitte um %s wurde von %s abgelehnt, eine andere Bitte ist noch im gange",
  };

  -- => SPELL REQUEST STRINGS
  HA_GUI_REQUEST_NOT_DEAD_YET = "Ehhh, bitte zuerst sterben! ;)";
  HA_GUI_REQUEST_YOU_ARE_DEAD = "Sorry, aber *\195\164hm* du bist tot...";
  HA_GUI_REQUEST_SEARCH_OK = "Verf�gbares '%s' gefunden: %s wurde gebeten es zu zaubern!"; 
  HA_GUI_REQUEST_SEARCH_FAILED = "Es ist kein '%s' verf�gbar!!";
  HA_GUI_REQUEST_SEARCH_INVALID_SPELL = "'%s' gibt es nicht!";

else
  -- Default English values

  -- => BINDINGS STRINGS
  BINDING_HEADER_HA = "Healers Assist";
  BINDING_NAME_HA_SHOW = "Show/Hide Healers Assist main window";
  BINDING_NAME_HA_SHOW_CONFIG = "Show/Hide Healers Assist configuration window";
  BINDING_NAME_HA_EMERG1 = "Select emergency 1";
  BINDING_NAME_HA_EMERG2 = "Select emergency 2";
  BINDING_NAME_HA_EMERG3 = "Select emergency 3";
  BINDING_NAME_HA_EMERG4 = "Select emergency 4";
  BINDING_NAME_HA_EMERG5 = "Select emergency 5";
  
  -- => MAIN WINDOW STRINGS
  HA_GUI_HEALERS_HEALER = "Healer";
  HA_GUI_HEALERS_SPELL = "Spell";
  HA_GUI_HEALERS_TARGET = "Target";
  HA_GUI_HEALERS_CASTING = "Casting";
  HA_GUI_EMERG_NAME = "Name";
  HA_GUI_EMERG_DEFICIT = "Deficit";
  HA_GUI_EMERG_COUNT = "Count";
  HA_GUI_EMERG_ESTIM = "Estim.";
  HA_GUI_COLLAPSE = "Collapse";
  HA_GUI_RESTING = "Rest";
  HA_GUI_RESTING_STATE = "Resting";

  -- => TOOLTIP STRINGS
  HA_GUI_TOOLTIP_MINIMAP = "Healers Assist\nLeft Click to open main window\nRight Click to open sub menu";
  HA_GUI_TOOLTIP_GOT_SPELL = "Got %s from %s"; -- $1=spell $2=from
  HA_GUI_TOOLTIP_READY = "%s is ready !"; -- $1=spell
  HA_GUI_TOOLTIP_COOLDOWN = "%s cooldown :"; -- $1=spell
  
  -- => SUB-MENU STRINGS
  HA_GUI_SUBMENU_OPEN_OPTIONS = "Open options panel";
  HA_GUI_SUBMENU_LOCK = "Lock the window";
  HA_GUI_SUBMENU_UNLOCK = "Unlock the window";

  -- => CONFIG STRINGS
  HA_GUI_MAIN_MENU_GENERAL = "General options";
  HA_GUI_MAIN_MENU_HEALERS = "Healers list options";
  HA_GUI_MAIN_MENU_EMERGENCY = "Emergency list options";
  HA_GUI_MAIN_MENU_PLUGINS = "Plugins options";

  HA_GUI_TITLE = "HA Config";
  HA_GUI_CHANOPT_TITLE = "Channel Options";
  HA_GUI_CHANOPT_CHAN_NAME = "Channel Name";
  HA_GUI_CHANOPT_SYNC_CTRAID = "Sync with CTRaid's channel";
  HA_GUI_CHANOPT_VALIDATE = "Validate";
  HA_GUI_SCALE_TITLE = "Main Window Scale : ";
  HA_GUI_ALPHA_TITLE = "Main Window Opacity : ";
  HA_GUI_BACKDROP_ALPHA_TITLE = "Backdrop Opacity : ";
  HA_GUI_GUI_REFRESH_TITLE = "UI refresh rate : ";
  HA_GUI_EMERGOPT_TITLE = "Emergency Targets Options";
  HA_GUI_EMERGOPT_LINES_TITLE = "Count of visible emergency lines : ";
  HA_GUI_EMERGOPT_MIN_HEALTH_TITLE = "Minimum Target Health Percent for Emergency : ";
  HA_GUI_EMERGOPT_GRPS_TITLE = "Groups to show in Emergency (Raid only)";
  HA_GUI_EMERGOPT_GRPS_G1 = "Grp1";
  HA_GUI_EMERGOPT_GRPS_G2 = "Grp2";
  HA_GUI_EMERGOPT_GRPS_G3 = "Grp3";
  HA_GUI_EMERGOPT_GRPS_G4 = "Grp4";
  HA_GUI_EMERGOPT_GRPS_G5 = "Grp5";
  HA_GUI_EMERGOPT_GRPS_G6 = "Grp6";
  HA_GUI_EMERGOPT_GRPS_G7 = "Grp7";
  HA_GUI_EMERGOPT_GRPS_G8 = "Grp8";
  HA_GUI_EMERGOPT_CLASSES_TITLE = "Classes to show in Emergency";
  HA_GUI_EMERGOPT_CLASSES_DRUID = "Druid";
  HA_GUI_EMERGOPT_CLASSES_HUNTER = "Hunter";
  HA_GUI_EMERGOPT_CLASSES_MAGE = "Mage";
  HA_GUI_EMERGOPT_CLASSES_PRIEST = "Priest";
  HA_GUI_EMERGOPT_CLASSES_ROGUE = "Rogue";
  HA_GUI_EMERGOPT_CLASSES_WARLOCK = "Warlock";
  HA_GUI_EMERGOPT_CLASSES_WARRIOR = "Warrior";
  HA_GUI_EMERGOPT_CLASSES_PALA_SHAM = "Pala/Sham";
  HA_GUI_EMERGOPT_FILTER_RANGE = "Only show players within 30y range";
  HA_GUI_HEALOPT_ALLOWSPELLS_TITLE = "Authorize request for those spells";
  HA_GUI_HEALOPT_TITLE = "Healers View Options";
  HA_GUI_HEALOPT_LINES_TITLE = "Count of visible healers lines : ";
  HA_GUI_HEALOPT_KEEP_SPELL_TITLE = "Show casted spells for : "
  HA_GUI_HEALOPT_KEEP_SPELL_SHORT = "Short";
  HA_GUI_HEALOPT_KEEP_SPELL_LONG = "Long";
  HA_GUI_HEALOPT_SHOW_INSTANTS = "Show Instant Spells (purge or dispel)";
  HA_GUI_HEALOPT_SHOW_HOTS = "Show HoTs";
  HA_GUI_HEALOPT_GROW_UPWARDS = "The window grows upwards";
  HA_GUI_HEALOPT_NOTIFY_REGEN = "Display a message when a healer enters or leaves regen mana state";
  HA_GUI_HEALOPT_CLASSES_DRUID = "Druid";
  HA_GUI_HEALOPT_CLASSES_PRIEST = "Priest";
  HA_GUI_HEALOPT_CLASSES_PALA_SHAM = "Pala/Sham";
  HA_GUI_PLUGINS_AUTO = "Auto";
  HA_GUI_PLUGINS_LOAD = "Activate";
  HA_GUI_PLUGINS_NAME = "Plugin name";
  HA_GUI_PLUGINS_CONFIGURE = "Configure";
  HA_GUI_MINIMAP_TITLE = "Minimap Icon Position";
  HA_GUI_AUTO_OPEN = "Auto open when in a group/raid";
  HA_GUI_REALTIME_LIFE_UPDATES  = "Realtime life updates (experimental)";
  HA_GUI_CLOSE = "Close";
  HA_GUI_BACK = "Back";
  HA_FAILED_TEXT_OUT_OF_SIGHT = "Out of Sight";
  HA_FAILED_TEXT_TOO_FAR = "Too far";
  HA_FAILED_TEXT_DEAD = "Dead !!";

  HA_HELP_CHAN_OPT = "|c00FFFFFF"..HA_GUI_CHANOPT_CHAN_NAME.." :|r\n"..
    "  Specify here the channel name to use.\n"..
    "  All healers must be in the same channel to see\n"..
    "   other's spell informations.\n\n"..
    "|c00FFFFFF"..HA_GUI_CHANOPT_SYNC_CTRAID.." :|r\n"..
    "  If you check this box and CTRaid is installed,\n"..
    "   HA will automatically sync with CTRaid's channel\n"..
    "   at each broadcast.\n"..
    "  When you check this box, HA searches for current\n"..
    "   CTRaid's channel, and shows it in the EditBox.\n\n"..
    "|c00FFFFFF"..HA_GUI_CHANOPT_VALIDATE.." :|r\n"..
    "  You must clic this button, to validate any change\n"..
    "   in channel options.";

  HA_HELP_HEAL_OPT = "|c00FFFFFF"..HA_GUI_HEALOPT_KEEP_SPELL_TITLE.." :|r\n"..
    "  Specify here how long you want casted spells (successful or not)\n"..
    "   to show in healer's view.\n\n"..
    "|c00FFFFFF"..HA_GUI_HEALOPT_SHOW_INSTANTS.." :|r\n"..
    "  If you check this box, instant spells that do not heal\n"..
    "   (like any dispel), will be shown.\n\n"..
    "|c00FFFFFF"..HA_GUI_HEALOPT_SHOW_HOTS.." :|r\n"..
    "  If you check this box, instant spells that heal\n"..
    "   over time (like renew), will be shown.\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_CLASSES_TITLE.." :|r\n"..
    "  Choose which healing classes you want to see in the\n"..
    "   healers list view.";

  HA_HELP_EMERG_OPT = "|c00FFFFFF"..HA_GUI_EMERGOPT_MIN_HEALTH_TITLE.." :|r\n"..
    "  Specify here the minimum health percent value that must have someone\n"..
    "   in your group or raid, to be shown in the emergency list.\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_GRPS_TITLE.." :|r\n"..
    "  Choose which groups you want to see in the emergency list.\n"..
    "  This is only valid in a RAID.\n\n"..
    "|c00FFFFFF"..HA_GUI_EMERGOPT_CLASSES_TITLE.." :|r\n"..
    "  Choose which classes your want to see in the\n"..
    "   emergency list.";

  -- => POPUP STRINGS
  HA_GUI_POPUP_REQUEST_FOR_SPELL = "%s asks for %s\nCast it automatically ?"; -- $1=from $2=spell
  HA_GUI_POPUP_REQUEST_FOR_SPELL_WITH_FAILURE = "%s asks for %s\nCast it automatically ?\n|cffff0000(%s)"; -- $1=from $2=spell $3=Failure

  -- => SPELL REQUEST DENIED STRINGS
  HA_SpellRequestDenied = -- $1=spell $2=from
  {
    [1] = "Request for spell %s denied by %s",
    [2] = "Spell %s automatically blocked by %s",
    [3] = "Request for spell %s denied by %s : He is processing another request",
  };
  
  -- => SPELL REQUEST STRINGS
  HA_GUI_REQUEST_NOT_DEAD_YET = "Well, wait for death before asking for resurrection ^^";
  HA_GUI_REQUEST_YOU_ARE_DEAD = "Sorry but *hum* you are dead...";
  HA_GUI_REQUEST_SEARCH_OK = "Found a usable '%s': Asking %s to cast it!";
  HA_GUI_REQUEST_SEARCH_FAILED = "Failed to find someone with a useable '%s'!!";
  HA_GUI_REQUEST_SEARCH_INVALID_SPELL = "Spell '%s' is not in the list of spells you can request!";

end

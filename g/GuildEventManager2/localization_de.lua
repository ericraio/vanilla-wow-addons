-- File containing localized strings - DE
-- Translation by : deDE - Fauxpass

if ( GetLocale() == "deDE" ) then
  -- German localized variables (default)
  -- => Displayed strings
  -- Umlautersetzungstabelle:
  -- ä->\195\164; ö->\195\182; ü->\195\188; ß->\195\159
  -- 
  GEM_CHAT_MISC_LOADED = "Geladen ! (/gem f\195\188r Hilfe)";
  GEM_CHAT_CMD_PARAM_ERROR = "Unbekannter Parameter f\195\188r diesen Befehl!";
  GEM_CHAT_CMD_UNKNOWN = "Unbekannter Befehl f\195\188r /gem (Versuchen Sie /gem help)";
  -- => Other strings
  
  GEM_TITLE = "Guild Event Manager";
  GEM_TEXT_OBSOLETE = " (Inkompatible Version - Upgrade notwendig !)";
  GEM_TEXT_NEW_MINOR = " (Neue Version vorhanden)";
  GEM_TEXT_UPGRADE_NEEDED = "Es gibt ein wichtiges Update von GEM. Bitte upgraden, um die Funktionalit\195\164t zu gew\195\164hrleisten!";
  GEM_TEXT_UPGRADE_SUGGESTED = "Es gibt ein kleines Update von GEM. Bitte upgraden, um Bugs zu beheben.";
  
  GEM_HEADER_DATE = "Datum";
  GEM_HEADER_DATE_SERVER = "Serverzeit : ";
  GEM_HEADER_WHERE = "Wo";
  GEM_HEADER_LEADER = "Leiter";
  GEM_HEADER_COUNT = "Anzahl";
  GEM_HEADER_MAX = "Max";
  GEM_HEADER_RANGE_LEVEL = "Level";
  
  GEMLIMIT_HEADER_CLASS = "Klasse";
  GEMLIMIT_HEADER_MIN = "Min";
  GEMLIMIT_HEADER_MAX = "Max";
  GEMLIMIT_HEADER_TITULAR = "Anzahl";
  GEMLIMIT_HEADER_SUBSTITUTE = "Warteliste";
  GEMLIMIT_HEADER_REPLACEMENT = "Ersatz";
  
  GEMADMIN_HEADER_PLACE = "Pos";
  GEMADMIN_HEADER_NAME = "Name";
  GEMADMIN_HEADER_GUILD = "Gilde";
  GEMADMIN_HEADER_CLASS = "Klasse";
  GEMADMIN_HEADER_LEVEL = "Level";
  
  GEM_TAB_LIST = "Termine";
  GEM_TAB_NEW = "Neues Event";
  GEM_TAB_OPTIONS = "Optionen"
  GEM_TAB_PLAYERS = "Mitglieder";
  
  GEM_TAB_LIST_CLASSES = "Limits";
  GEM_TAB_LIST_DETAILS = "Details";
  GEM_TAB_LIST_ADMIN = "Anmeldungen";
  
  GEM_TEXT_PLAYER_JOINED = "%s betritt Channel.";
  GEM_TEXT_PLAYER_LEFT = "%s verl\195\164\195\159t Channel.";
  
  GEM_TEXT_UNCLOSE	= "Wieder \195\182ffnen";
  GEM_TEXT_RECOVER = "Wiederherst.";
  GEM_TEXT_DELETE = "L\195\182schen";
  GEM_TEXT_DELETE_CONFIRM = "Event l\195\182schen: Sind Sie sicher?"
  GEM_TEXT_UNSUBSCRIBE = "Abmelden";
  GEM_TEXT_SUBSCRIBE = "Anmelden";
  GEM_TEXT_CREATE = "Erstellen";
  GEM_TEXT_MODIFY = "\195\164ndern";
  GEM_TEXT_FORCETIT = "Platz als fester Teilnehmer zuweisen"; 
  GEM_TEXT_FORCESUB = "Platz in Ersatzliste zuweisen";
  GEM_TEXT_SETLEADER = "Zum Anf\195\188hrer ernennen";
  GEM_TEXT_NO_REASON = "Kein Grund angegeben";
  GEM_TEXT_EVT_CHANNEL = "Channel %s";
  
  GEM_TEXT_DATE_CHOOSE = "W\195\164hle...";
  GEM_TEXT_WHERE = "Wo";
  GEM_TEXT_COMMENT = "Kommentar";
  GEM_TEXT_COUNT = "Gr\195\182\195\159e der Gruppe/Raid";
  GEM_TEXT_LEVEL = "Level";
  GEM_TEXT_ERR_NO_WHERE = "Sie m\195\188ssen eintragen 'Wo' das Event stattfinden soll!";
  GEM_TEXT_EVENT_CLOSED = "Event geschlossen : ";
  GEM_TEXT_GUILD_RANK = "Gildenrang";
  GEM_TEXT_GEM_VERSION = "GEM version";
  
  GEM_HEADER_PLAYERS_NAME = "Name";
  GEM_HEADER_PLAYERS_GUILD = "Gilde";
  GEM_HEADER_PLAYERS_LOCATION = "Ort";
  GEM_HEADER_PLAYERS_LEVEL = "Lvl.";
  GEM_HEADER_PLAYERS_CLASS = "Klasse";
  GEM_TEXT_PLAYERS_SEEOFFLINE = "Zeige offline";
  GEM_TEXT_PLAYERS_COUNT = "%d Mitglieder (%d insgesamt)";

  GEM_TEXT_CHANNEL = "Chatkanal";
  GEM_TEXT_PASSWORD = "Passwort";
  GEM_TEXT_ALIAS = "Alias";
  GEM_TEXT_SLASH = "Slashkommando";
  GEM_TEXT_DATE_FORMAT	= "Datumsformat";
  GEM_TEXT_DATE_USE_SERVER = "Benutze Serverzeit";
  GEM_TEXT_SHOW_LOGS = "Verbindungsbenachrichtigung";
  GEM_TEXT_BIP_CHANNEL = "F\195\188r diesen Namen einen Ton abspielen";
  GEM_TEXT_FILTER_EVENTS = "Nur Events f\195\188r mein Level anzeigen";
  GEM_TEXT_VALIDATE = "Akzeptieren";
  GEM_TEXT_ERR_NEED_CHANNEL = "Chatkanal angeben!";
  GEM_TEXT_ERR_NEED_ALIAS = "Aliasname und Slashkommando m\195\188ssen angeben sein";
  GEM_TEXT_ERR_DATE_OFFSET = "Der Stundenoffset muss eine Zahl sein";  
  GEM_TEXT_ICON = "Minikartensymbol";
  GEM_TEXT_ICON_ADJUST_ANGLE = "Winkel anpassen";
  GEM_TEXT_ICON_ADJUST_RADIUS = "Radius anpassen";
  GEM_TEXT_OPTIONS_ICONCHOICE = "Wahl des Minikartensymbols";
  GEM_TEXT_BUTTON_CHAN_ADD = "Add";
  GEM_TEXT_BUTTON_CHAN_DEL = "Remove";
  GEM_TEXT_BUTTON_CHAN_UPDT = "Update";
  
  GEM_TEXT_CLASS_LIMITATION = "Klassen-Limits (min/max)"
  GEM_TEXT_CLASS_WARRIOR = "Krieger";
  GEM_TEXT_CLASS_PALADIN = "Paladin";
  GEM_TEXT_CLASS_SHAMAN = "Schamane";
  GEM_TEXT_CLASS_ROGUE = "Schurke";
  GEM_TEXT_CLASS_MAGE = "Magier";
  GEM_TEXT_CLASS_WARLOCK = "Hexenmeister";
  GEM_TEXT_CLASS_HUNTER = "J\195\164ger";
  GEM_TEXT_CLASS_DRUID = "Druide";
  GEM_TEXT_CLASS_PRIEST = "Priester";
  
  GEM_TEXT_DETAILS_DESCRIPTION = "Beschreibung :";
  GEM_TEXT_DETAILS_SORTTYPE = "Sortierung :";
  GEM_TEXT_DETAILS_UNKNOWN = "Unbekannt";
  GEM_TEXT_ADMIN_CLOSE = "Absagen";
  GEM_TEXT_ADMIN_CLOSE_CONFIRM = "Dieses Event absagen?"; 
  GEM_TEXT_ADMIN_SETLEADER_CONFIRM = "Anf\195\188hrer wechseln?";
  GEM_TEXT_ADMIN_EDIT = "Editieren";
  GEM_TEXT_ADMIN_ASSISTANT = "Bef\195\182rdern";
  GEM_TEXT_ADMIN_KICK = "Hinauswerfen";
  GEM_TEXT_ADMIN_BAN = "Sperren";
  GEM_TEXT_ADMIN_BANNED = "Gesperrt";
  GEM_TEXT_ADMIN_ADDEXT = "Externen dazu";
  GEM_TEXT_ADMIN_GROUP = "Alle einladen";
  GEM_TEXT_ADMIN_IGNORE = "Ignorieren";
  GEM_TEXT_ADMIN_IGNORE_CONFIRM = "Dieses Event ignorieren?";
  GEM_TEXT_ADMIN_ERR_LEAVE_GROUP = "Keine neue Gruppenbildung m\195\182glich. Erst aktuelle Gruppe verlassen!";
  GEM_TEXT_ADMIN_ERR_ALREADY_GROUP = "Warnung: Sie sind schon in einer (Schlacht-)Gruppe!";
  GEM_TEXT_ADMIN_COMMENT = "Anmeldekommentar";
  
  GEM_DATE_FORMAT = "%d. %m. %Y %H:%M %a";
  GEM_HOUR_FORMAT = "%H:%M";
  GEM_DATE_CONVERT = {Mon="Mo", Tue="Di", Wed="Mi", Thu="Do", Fri="Fr", Sat="Sa", Sun="So"};
  GEM_NA_FORMAT = "N/A";
  
  BINDING_HEADER_GEM = GEM_TITLE;
  BINDING_NAME_GEM_SHOW_EVENTS = "Zeige/Verberge Eventliste";
  BINDING_NAME_GEM_SHOW_NEW = "Zeige/Verberge Eventerstellung";
  BINDING_NAME_GEM_SHOW_MEMBERS = "Zeige/Verberge Mitgliederliste";
  BINDING_NAME_GEM_SHOW_CONFIG = "Zeige/Verberge Konfiguration";  

GEM_INSTANCES = {
  "Ragefireabgrund",
  "Die Todesminen",
  "Die H\195\182hlen des Wehklagens",
  "Burg Shadowfang",
  "Das Verlies",
  "Die Blackfathomtiefen",
  "Gnomeregan",
  "Der Kral von Razorfen",
  "Das scharlachrote Kloster",
  "Die H\195\188gel von Razorfen",
  "Uldaman",
  "Maraudon",
  "Zul'Farrak",
  "Der versunkene Tempel",
  "Die Blackrocktiefen",
  "Stratholme",
  "D\195\188sterbruch",
  "Scholomance",
  "untere Blackrockspitze [LBRS]",
  "obere Blackrockspitze [UBRS]",
  "Zul'Gurub [ZG]",
  "Ruinen von Ahn'Qiraj [AQ20]",
  "Onyxias Hort",
  "Der geschmolzene Kern [MC]",
  "Pechschwingenhort [BWL]",
  "Tempel von Ahn'Qiraj [AQ40]",
  "BG Alteractal",
  "BG Arathibecken",
  "BG Warsongschlucht"
  }; 
  
  GEM_TEXT_CALENDAR_SUNDAY = "S";
  GEM_TEXT_CALENDAR_MONDAY = "M";
  GEM_TEXT_CALENDAR_TUESDAY = "D";
  GEM_TEXT_CALENDAR_WEDNESDAY = "M";
  GEM_TEXT_CALENDAR_THURSDAY = "D";
  GEM_TEXT_CALENDAR_FRIDAY = "F";
  GEM_TEXT_CALENDAR_SATURDAY = "S";
  GEM_TEXT_CALENDAR_HEADER = "Uhrzeit w\195\164hlen";
  GEM_TEXT_CALENDAR_HELP = "Zeitpunkt des Events w\195\164hlen, danach zur Best\195\164tigung auf den Tag klicken. Gr\195\188n markiertes Datum ist heute.";
  GEMCalendar_Month = {"Januar","Februar","M\195\164rz","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember"};
  
  GEM_TEXT_BANNED_HEADER = "Liste der gesperrten Spieler f\195\188r dieses Event";
  GEM_TEXT_BANNED_NAME = "Name";
  GEM_TEXT_BANNED_REASON = "Grund f\195\188r die Sperre";
  GEM_TEXT_BANNED_UNBAN = "Sperre aufheben";

  GEM_TEXT_EXTERNAL_HEADER = "Spieler ohne GEM hinzuf\195\188gen";
  GEM_TEXT_EXTERNAL_NAME = "Name";
  GEM_TEXT_EXTERNAL_GUILD = "Gilde";
  GEM_TEXT_EXTERNAL_CLASS = "Klasse";
  GEM_TEXT_EXTERNAL_LEVEL = "Level";
  GEM_TEXT_EXTERNAL_COMMENT = "Kommentar";
  GEM_TEXT_EXTERNAL_FORCESUB = "In Warteschlange";
  GEM_TEXT_EXTERNAL_ADD = "Hinzuf\195\188gen";
  GEM_TEXT_EXTERNAL_TARGET = "Ziel hinzuf\195\188gen";
  GEM_TEXT_EXTERNAL_ERR_LEVEL = "Ung\195\188ltiger Externer Spieler: Level entspricht nicht den Anforderungen";
  GEM_TEXT_EXTERNAL_ERR_GIVE_NAME = "Spielername angeben";
  GEM_TEXT_EXTERNAL_ERR_GIVE_LEVEL = "Spielerlevel angeben";
  GEM_TEXT_EXTERNAL_ERR_INVALID = "Ung\195\188ltiges Ziel";
  
  GEM_TEXT_TEMPLATE_HEADER = "Vorlagen";
  GEM_TEXT_TEMPLATE_SAVE = "Speichern";
  GEM_TEXT_TEMPLATE_LOAD = "Laden";
  GEM_TEXT_TEMPLATE_DELETE = "L\195\182schen";
  GEM_TEXT_ERR_NO_TEMPLATE = "Speichern der Vorlage fehlgeschlagen : Namen der Vorlage angeben";
  GEM_TEXT_TEMPLATE_SAVED = "Vorlage gespeichert!";
  
  GEM_TEXT_REROLL_ERR_SELECT = "Charakterauswahl unm\195\182glich, da der eingestellte GEM-Kanal sich vom aktuellen unterscheidet.";
  GEM_TEXT_SORTING_HEADER = "Sortierung";
  GEM_TEXT_SORTING_CONFIGURE = "Konfigurieren";

  GEM_TEXT_TOOLTIP_KICKED = "F\195\188r Event entfernt: ";
  GEM_TEXT_TOOLTIP_BANNED = "F\195\188r Event gesperrt: ";
  GEM_TEXT_TOOLTIP_CLOSED = "Event geschlossen : ";
  GEM_TEXT_ERR_LEVEL_FAILED = "Level nicht im erlaubten Levelbereich.";
  GEM_TEXT_CHAT_KICKED = "Ich wurde entfernt f\195\188r das Event in ";
  GEM_TEXT_CHAT_BANNED = "Ich wurde gesperrt f\195\188r das Event in ";
  GEM_TEXT_CHAT_UNBANNED = "Ich wurde entsperrt f\195\188r das Event in ";
  GEM_TEXT_CHAT_ASSISTANT = "Ich wurde zum Assistent bef\195\182rdert des Events in ";
  
  GEM_TEXT_NEW_EVENTS_AVAILABLE = "Neue Events : ";  
  GEM_TEXT_USAGE = "Anwendung:";

  GEM_HELP_EVENTS_TAB_EVENTS = "|c00FFFFFFFarbcodes der Eventliste:|r\n"..
    " - |c00606060Alle Felder grau|r = Event geschlossen\n"..
    " - |c00FFFFFFOrt :|r\n"..
    " - |c0000FF00Gr\195\188n|r = Neues Event\n"..
    " - |c00FFFFFFWei\195\159|r = Altes Event\n"..
    " - |c00FFFFFFLeiter :|r\n"..
    " - |c0000FF00Gr\195\188n|r = Online\n"..
    " - |c00FFFFFFWei\195\159|r = Offline\n"..
    " - |c00FFFFFFAnzahl :|r\n"..
    " - |c00FFFFFFWei\195\159|r = Nicht angemeldet\n"..
    " - |c00D000E0Lila|r = Nicht innerhalb der angegebenen Level\n"..
    " - |c00606060Dunkles grau|r = Anmeldung gesendet, aber noch nicht best\195\164tigt\n"..
    " - |c00E0E000Gelb|r = Angemeldet in Warteschlange\n"..
    " - |c004040FFBlau|r = Angemeldet in Ersatzliste\n"..
    " - |c0000FF00Gr\195\188n|r = Angemeldet in Teilnehmerliste\n"..
    " - |c00800000dunkles Rot|r = Aus Event geworfen\n"..
    " - |c00FF0000helles Rot|r = Aus Event gebannt\n\n"..
    "|c00FFFFFFZusatzinformation :|r\n"..
    " Wenn man sich f\195\188r ein Event anmeldet aber der Leiter offline ist,\n"..
    " muss man warten bis die Teilnahme von ihm best\195\164tigt ist\n"..
    " und man wird in eine Warteschlange gestellt.\n"..
    " W\195\164hrenddessen sieht man in der Anmeldeliste\n"..
    " nicht best\195\164tigte Anmeldungen mit dem Zeichen 'NA'.";

  GEM_HELP_PLAYERS_TAB_MEMBERS = "|c00FFFFFFFarbcodes der Mitgliederliste :|r\n"..
    " - |c00606060Alle Felder grau|r = Offline\n"..
    " - |c00FFFFFFGilde :|r\n".." - |c00FFFFFFWei\195\159|r = Normales Mitglied\n"..
    " - |c004040FFBlau|r = Gildenoffizier\n"..
    " - |c0000FF00Gr\195\188n|r = Gildenleiter\n\n"..
    "|c00FFFFFFZusatzinformation :|r\n"..
    " Um die Nachrichtenmenge von GEM minimal zu halten\n"..
    " kann es sein, da\195\159 sich die Liste langsam f\195\188llt, wenn\n"..
    " man das erste Mal in den gew\195\164hlten Kanal wechselt.\n"..
    " Aus demselben Grund wird nach dem Einloggen),\n"..
    " der Ort der Mitglieder mit 'N/A' angegeben\n"..
    " bis der jeweilige Spieler seine Zone \195\164ndert.";

  GEM_HELP_NEW_TAB_TEMPLATES = "|c00FFFFFFVorlagen :|r\n"..
    " Mit Vorlagen kann man folgende Angaben unter eigenem Namen speichern:\n"..
    " Alle Eventerstellungsfelder\n"..
    " (Ort, Kommentar, Gr\195\182\195\159e, Levels, Klassenbeschr\195\164nkung).";

  GEM_HELP_NEW_TAB_SORTING = "|c00FFFFFFSortierreihenfolge:|r\n"..
    " W\195\164hlt und konfiguriert den Algorithmus der verwendet wird\n"..
    " um Spieleranmeldungen zu sortieren.\n";

  GEM_HELP_NEW_TAB_CONFIG = "|c00FFFFFFHilfe zur Konfiguration:|r\n\n"..
    "|c00FFFFFF"..GEM_TEXT_CHANNEL.." :|r\n"..
    " Dies ist der Name des Kanals in dem GEM-Nachrichten ausgetauscht werden.\n"..
    " Fragen Sie Ihre Gilde/B\195\188ndnis, wenn Sie den Namen nicht kennen.\n"..
    "|c00FFFFFF"..GEM_TEXT_PASSWORD.." :|r\n"..
    " Passwort um den Kanal betreten zu k\195\182nnen (optional).\n"..
    "|c00FFFFFF"..GEM_TEXT_ALIAS.." :|r\n"..
    " Alias f\195\188r den eingestellten Kanal\n"..
    " Dies ist ein reiner Anzeigewert. Einstellung frei w\195\164hlbar\n"..
    "|c00FFFFFF"..GEM_TEXT_SLASH.." :|r\n"..
    " Befehl (Slashkommando) um im GEM-Kanal sprechen zu k\195\182nnen\n"..
    " Es muss ein Alias vergeben sein um sprechen zu k\195\182nnen.\n"..
    " Itemlinks funktionieren auch nur \195\188ber diesen Befehl,\n"..
    " nicht mit /# (Kanalnummer).\n"..
    "|c00FFFFFF"..GEM_TEXT_SHOW_LOGS.." :|r\n"..
    " Zeigt/Versteckt die Betritt/Verl\195\164sst-Meldungen.\n"..
    "|c00FFFFFF"..GEM_TEXT_COMMENT.." :|r\n"..
    " Kommentar wird in der Mitgliederliste im Tooltip \195\188ber Ihrem Namen angezeigt.\n"..
    "|c00FFFFFF"..GEM_TEXT_BIP_CHANNEL.." :|r\n"..
    " Spielt einen Sound ab, wenn ein bestimmter Name im GEM-Channel genannt wird.\n"..
    "|c00FFFFFF"..GEM_TEXT_DATE_FORMAT.." :|r\n"..
    " Format f\195\188r angezeigte Daten (erweiterte Option).\n"..
    "|c00FFFFFF"..GEM_TEXT_DATE_USE_SERVER.." :|r\n"..
    " Ausw\195\164hlen, um neue Events in Serverzeit anstatt lokaler Zeit zu erstellen.\n"..
    " Events in der Liste werden ebenfalls mit Serverzeit angezeigt.\n"..
    "|c00FFFFFF"..GEM_TEXT_FILTER_EVENTS.." :|r\n"..
    " Zeigt/Versteckt Events au\195\159erhalb Ihres Levelbereichs.\n";

  GEM_DRUNK_MESSAGES = {
    "Ihr f\195\188hlt Euch beschwipst. Hui!",
    "Ihr f\195\188hlt Euch betrunken. Ohhhaaa!",
    "Ihr f\195\188hlt Euch sternhagelvoll.",
  };
  GEM_DRUNK_MESSAGES_COUNT = 3;
  GEM_DRUNK_NORMAL = "Ihr f\195\188hlt Euch wieder n\195\188chtern.";

  GEM_TEXT_NEW_CLOSE_CONFIRM = "Diese Vorlage l\195\182schen?";
  GEM_TEXT_NEW_AUTOMEMBERS_BUTTON = "Automitglieder...";
  GEM_TEXT_NEW_AUTOMEMBERS_TITLE = "Autom. Hinzuf\195\188gen von Mitgliedern zum neuen Event";
  GEM_TEXT_NEW_AUTOMEMBERS_ADD_TITULAR = "Mitglied hinzuf\195\188gen";
  GEM_TEXT_NEW_AUTOMEMBERS_ADD_REPLACEMENT = "Ersatz hinzuf\195\188gen";
  GEM_TEXT_NEW_AUTOMEMBERS_FILL_TITULAR = "Mitglied zur Stammliste hinzuf\195\188gen"; 
  GEM_TEXT_NEW_AUTOMEMBERS_FILL_REPLACEMENT = "Mitglied zum Hinzuf\195\188gen in Ersatzliste"; 
  
  -- Event Calendar
  GEM_EVENT_CALENDAR_VIEW = "Kalenderansicht";
  GEM_EVENT_CALENDAR_INSTANCE_RESET = "Zeige Instanzresets";
  GEM_EVENT_CALENDAR_INSTANCE_NONE_NAME = "Keine";
  GEM_EVENT_CALENDAR_INSTANCE_ONYXIA_NAME = "Onyxias Hort";
  GEM_EVENT_CALENDAR_INSTANCE_MC_NAME = "Der Geschmolzene Kern [MC]";
  GEM_EVENT_CALENDAR_INSTANCE_BWL_NAME = "Pechschwingenhort [BWL]";
  GEM_EVENT_CALENDAR_INSTANCE_ZG_NAME = "Zul'Gurub [ZG]"; 
  GEM_EVENT_CALENDAR_INSTANCE_AQ20_NAME = "Ruinen von Ahn'Qiraj [AQ20]";
  GEM_EVENT_CALENDAR_INSTANCE_AQ40_NAME = "Tempel von Ahn'Qiraj [AQ40]"; 
  
  GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR = "en";

  GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_1 = 1136242800; -- Onyxia
  GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_2 = 1136329200; -- MC/BWL/AQ40
  GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_3 = 1136329200; -- ZG/AQ20

end

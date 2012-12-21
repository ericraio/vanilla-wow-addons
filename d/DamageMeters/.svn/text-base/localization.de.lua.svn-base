--[[
--
--	DamageMeters Localization Data (GERMAN)
--        by wisc aka Radwar / Sentinel aka Jaffnar
--        some translations by 8tImER
--        first released by java
--	Version 5.0.0 SR3
--
	Special Keys in German:
	-- Ä =  \195\132
	-- Ö =  \195\150
	-- Ü =  \195\156
	-- ä =  \195\164
	-- ö =  \195\182
	-- ü =  \195\188
	-- ß =  \195\159

--]]

if ( GetLocale() == "deDE" ) then

-- CombatMessageAmbigousfix by No-Nonsense, improved by Sentinel
local COMBAT_MESSAGES = {
	-- Combat Messages.
	"SPELLLOGCRITOTHEROTHER",
	"SPELLLOGOTHEROTHER",
	"SPELLLOGCRITSCHOOLOTHERSELF",
	"SPELLLOGCRITSCHOOLOTHEROTHER",
	"SPELLLOGSCHOOLOTHERSELF",
	"SPELLLOGSCHOOLOTHEROTHER",
	"SPELLSPLITDAMAGEOTHEROTHER",
	"SPELLSPLITDAMAGEOTHERSELF",
	"SPELLRESISTOTHEROTHER",

	-- Heal Messages.
	"PERIODICAURAHEALOTHEROTHER",
	"HEALEDCRITOTHEROTHER",
	"HEALEDCRITOTHERSELF",
	"HEALEDOTHEROTHER"
};

-- Apply modifications.
for _, cmsg in COMBAT_MESSAGES do
	local fixcode = cmsg .. '= string.gsub(string.gsub(' .. cmsg .. ', "(%%%d%$s)s ", "%1\'s "), "%%ss ", "%%s\'s ")';
	RunScript(fixcode);
end

-- Free Memory.
local COMBAT_MESSAGES = nil;

-- General --
DamageMeters_PRINTCOLOR = "|cFF8F8FFF"

-- Bindings --
BINDING_HEADER_DAMAGEMETERSHEADER 		= "DamageMeters";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOW	= "Fenster anzeigen/verstecken";
BINDING_NAME_DAMAGEMETERS_CYCLEQUANT	= "Daten vorw. durchschalten";
BINDING_NAME_DAMAGEMETERS_CYCLEQUANTBACK= "Daten r\195\188ckw. durchschalten";
BINDING_NAME_DAMAGEMETERS_CLEAR			= "Daten l\195\182schen";
BINDING_NAME_DAMAGEMETERS_TOGGLEPAUSED	= "Pause an/aus";
BINDING_NAME_DAMAGEMETERS_SHOWREPORTFRAME = "Berichtsfenster anzeigen";
BINDING_NAME_DAMAGEMETERS_SWAPMEMORY	= "Speicherstand austauschen";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOWMAX	= "Max. Balken anzeigen an/aus";
BINDING_NAME_DAMAGEMETERS_SYNCREADY		= "Sync-Bereitschaft senden";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOWFIGHTASPS = "Daten \"pro Sekunde\" anzeigen an/aus";
BINDING_NAME_DAMAGEMETERS_TOGGLENORMALANDFIGHT = "Daten \"pro Kampf\" anzeigen an/aus";
BINDING_NAME_DAMAGEMETERS_TOGGLEMINIMODE = "Mini-Modus an/aus";
BINDING_NAME_DAMAGEMETERS_SYNCPAUSE = "Sync-Pause";
BINDING_NAME_DAMAGEMETERS_SYNCUNPAUSE = "Sync-Fortsetzen";
BINDING_NAME_DAMAGEMETERS_SYNCCLEAR = "Sync-L\195\182schen";

--[[ work in progress
-- command, function, help string
DM_HELPDEF = {
	-- Main commands.
	{ "help", DamageMeters_Help, DM_CMD_HELP },
	{ "cmd", DamageMeters_ListCommands, DM_CMD_CMD },
	{ "version", DamageMeters_ShowVersion, DM_CMD_VERSION },
	{ "show", DamageMeters_ToggleShow, DM_CMD_SHOW },
	{ "hide", DamageMeters_Hide, DM_CMD_HIDE },
	{ "clear", DamageMeters_Clear, DM_CMD_CLEAR },
	{ "report", DamageMeters_Report, DM_CMD_REPORT },
	{ "sort", DamageMeters_SetSort, DM_CMD_SORT },
	{ "count", DamageMeters_SetCount, DM_CMD_SETCOUNT },
	{ "autocount", DamageMeters_SetAutoCount, DM_CMD_AUTOCOUNT },
	{ "lock", DamageMeters_ToggleLock, DM_CMD_LOCK },
	{ "pause", DamageMeters_TogglePause, DM_CMD_PAUSE },
	{ "ready", DamageMeters_SetReady, DM_CMD_READY },
	{ "resetpos", DamageMeters_ResetPos, DM_CMD_RESETPOS },
	{ "pop", DamageMeters_Populate, DM_CMD_POP },
	{ "listbanned", DamageMeters_ListBanned, DM_CMD_LISTBANNED },
	{ "clearbanned", DamageMeters_ClearBanned, DM_CMD_CLEARBANNED },

	-- Memory
	{ "save", DamageMeters_Save, DM_CMD_SAVE },
	{ "restore", DamageMeters_Restore, DM_CMD_RESTORE },
	{ "swap", DamageMeters_Swap, DM_CMD_SWAP },
	{ "memclear", DamageMeters_MemClear, DM_CMD_MEMCLEAR },

	-- These all have menu options.
	{ "color", DamageMeters_SetColorScheme, DM_CMD_COLOR },
	{ "quant", DamageMeters_SetQuantity, DM_CMD_QUANT },
	{ "text", DamageMeters_SetTextOptions, DM_CMD_TEXT },
	{ "visinparty", DamageMeters_SetVisibleInParty, DM_CMD_VISINPARTY },
	{ "lockpos", DamageMeters_ToggleLockPos, DM_CMD_LOCKPAUSE },
	{ "grouponly", DamageMeters_ToggleGroupMembersOnly, DM_CMD_GROUPONLY },
	{ "addpettoplayer", DamageMeters_ToggleAddPetToPlayer, DM_CMD_ADDPETTOPLAYER },
	{ "resetoncombat", DamageMeters_ToggleResetWhenCombatStarts, DM_CMD_RESETONCOMBAT },
	{ "total", DamageMeters_ToggleTotal, DM_CMD_TOTAL },
	{ "showmax", DamageMeters_ToggleMaxBars, DM_CMD_SHOWMAX },

	-- Sync commands.
	{ "sync", DamageMeters_Sync, DM_CMD_SYNC },
	{ "syncchan", DamageMeters_SyncChan, DM_CMD_SYNCCHAN },
	{ "syncleave", DamageMeters_SyncLeaveChanCmd, DM_CMD_SYNCLEAVE },
	{ "syncsend", DamageMeters_SyncReport, DM_CMD_SYNCSEND },
	{ "syncrequest", DamageMeters_SyncRequest, DM_CMD_SYNCREQUEST },
	{ "syncclear", DamageMeters_SyncClear, DM_CMD_SYNCCLEAR },
	{ "syncmsg", DamageMeters_SendSyncMsg, DM_CMD_SYNCMSG },
	{ "syncbroadcastchan", DamageMeters_SyncBroadcastChan, DM_CMD_SYNCBROADCASTCHAN },
	{ "syncping", DamageMeters_SyncPingRequest, DM_CMD_SYNCPING },
	{ "syncpause", DamageMeters_SyncPause, DM_CMD_SYNCPAUSE },
	{ "syncunpause", DamageMeters_SyncUnpause, DM_CMD_SYNCUNPAUSE },
	{ "syncready", DamageMeters_SyncReady, DM_CMD_SYNCREADY },
	{ "synckick", DamageMeters_SyncKick, DM_CMD_SYNCKICK },
	{ "synclabel", DamageMeters_SyncLabel, DM_CMD_SYNCLABEL },
	{ "syncstart", DamageMeters_SyncStart, DM_CMD_SYNCSTART },
	{ "synchalt", DamageMeters_SyncHalt, DM_CMD_SYNCHALT },
	{ "synce", DamageMeters_SyncEmote, DM_CMD_SYNCEMOTE },

	-- Debug commands.
	{ "reset", DamageMeters_Reset, DM_CMD_RESET },
	{ "test", DamageMeters_Test, DM_CMD_TEST },
	{ "add", DamageMeters_Add, DM_CMD_ADD },
	{ "dumptable", DamageMeters_DumpTable, DM_CMD_DUMPTABLE },
	{ "debug", DM_ToggleDMPrintD, DM_CMD_DEBUG },
	{ "dumpmsg", DM_DumpMsg, DM_CMD_DUMPMSG },
	{ "print", DM_ConsolePrint, DM_CMD_PRINT },
};
]]--

-- Help --
DamageMeters_helpTable = {
		"Die folgenden Befehle stehen zur Verf\195\188gung:",
		"/dmhelp - Hilfe zur Benutzung von DamageMeters.",
		"/dmcmd - Listet alle verf\195\188gbaren /dm (DamageMeters)-Befehle auf.",
		"/dmshow - Zeigt oder versteckt das DamageMeters-Fenster. Bitte beachten: Die Kampfdaten werden im Hintergrund weiterhin gesammelt, sollte das Fenster versteckt sein.",
		"/dmhide - Versteckt das Fenster.",
		"/dmclear [#] - Entfernt (unten beginnend) Eintr\195\164ge aus der Liste, bis # St\195\188ck \195\188brig sind. Wenn keine Zahl angegeben wird, wird die gesamte Liste geleert.",
		"/dmreport [help] [total] [c/s/p/r/w/h/g/f[#]] [Fl\195\188sterZiel/ChannelName] - Gibt einen Bericht zu den momentan vorliegenden Daten aus: '/dmreport help' f\195\188r Detailhilfe benutzen.",
		"/dmsort [#] - Legt die Sortierreihenfolge fest. Keine Nummer angeben, um eine Liste aller verf\195\188gbaren Reihenfolgen zu erhalten.",
		"/dmcount [#] - Legt die Anzahl gleichzeitig sichtbarer Balken fest. Wenn keine Zahl angegeben wird, werden so viele wie m\195\182glich angezeigt.",
		"/dmsave - Speichert die aktuellen Daten intern.",
		"/dmrestore - Stellt fr\195\188her (via /dmsave) gespeicherte Daten wieder her und \195\188berschreibt jegliche aktuelle Daten.",
		--"/dmmerge - F\195\188hrt fr\195\188her (via /dmsave) gespeicherte Daten mit den aktuellen Daten zusammen.",
		"/dmswap - Tauscht fr\195\188her (via /dmsave) gespeicherte Daten mit den aktuellen Daten.",
		"/dmmemclear - L\195\182scht (via /dmsave) gespeicherte Daten.",
		"/dmresetpos - Setzt die Position des Fensters auf die Ausgangsposition zur\195\188ck (hilfreich, wenn man es vom Bildschirm geschoben haben sollte).",
		"/dmtext 0/<[r][n][p][l][v]> - Legt fest, welcher Text auf den Balken angezeigt werden soll. r - Platzierung. n - Spielername. p - Prozentanteil am Gesamtschaden. l - Prozent von Platz 1. v - Wert (Rohe Zahl).",
		"/dmcolor # - Legt das Farbschema f\195\188r die Balken fest.  Keine Zahl angeben f\195\188r eine Liste m\195\182glicher Optionen.",
		"/dmquant # - Legt fest, an Hand welchen Wertes die Balken gezeichnet werden. Keine Zahl angeben f\195\188r eine Liste m\195\182glicher Optionen.",
		"/dmvisinparty [y/n] - Legt fest, ob das Fenster nur angezeigt werden soll, wenn du in einer Gruppe/Schlachtzug bist. Kein Argument angeben um hin- und herzuschalten.",
		"/dmautocount # - Wenn die Zahl gr\195\182sser als Null ist, zeigt das Fenster so viele Balken an, wie ihm Daten zur verf\195\188gung stehen bis zu einem Maximum von #. Wenn # Null ist, wird diese Funktion abgeschaltet.",
		"/dmlistbanned - F\195\188hrt alle gebannten Objekte auf.",
		"/dmclearbanned - L\195\182scht die Liste aller gebannten Objekte auf.",

		"/dmsync [d#] [e] - L\195\182st die Synchronisierung deiner Daten mit der anderer DamageMeters-Nutzer, die denselben Sync-Channel benutzen, aus.  (Ruft /dmsyncsend und /dmsyncrequest auf.) Wenn d angegeben wurde, wird die Synchronisierung um d Sekunden verz\195\182gert. Wenn e angegeben wurde, werden Ereignisdaten gesendet/angefordert.",
		"/dmsyncchan - Legt den Namen des Channels fest, der zum Synchronisieren genutzt werden soll.",
		"/dmsyncleave - Verl\195\164sst den aktuellen Synchronisierungs-Channel.",
		"/dmsyncsend - Sendet Synchronisierungs-Informationen an den Synchronisierungs-Channel.",
		"/dmsyncrequest - Sendet eine Anfrage an andere Leute im Synchronisierungs-Channel, eine automatische Synchronisierung (/dmsync) durchzuf\195\188hren.",
		"/dmsyncclear - Sendet eine Anfrage an andere Leute im Synchronisierungs-Channel, jedermanns jeweilige Daten zur\195\188ckzusetzen.",
		"/dmsyncmsg <Nachricht> - Sendet eine Nachricht an andere Leute im Synchronisierungs-Channel. /dmm tut dasselbe.",
		"/dmsyncbroadcastchan - Teilt deiner Gruppe/Schlachtzug deinen aktuellen Synchronisierungs-Channel mit. /dmsyncb tut dasselbe.",
		"/dmsyncping - 'Pingt' andere Leute im Synchronisierungs-Channel, wodurch diese mit ihrer jeweiligen DamageMeters-Versionsnummer antworten.",
		"/dmsyncpause - Pausiert die DamageMeters anderer Leute im Synchronisierungs-Channel.",
		"/dmsyncunpause - Entpausiert die DamageMeters anderer Leute im Synchronisierungs-Channel.",
		"/dmsyncready - Sendet einen Befehl, der alle im Synchronisierungs-Channel befindlichen Nutzer in den Bereitschafts-Status gehen l\195\164sst.",
		"/dmsynckick player - Entfernt einen Spieler aus dem Synchronisierungs-Channel.",
		"/dmsynclabel Titel - Gibt der momentanen Datensammlung einen Namen (Standardindex: 1).",
		"/dmsyncstart Titel - Kombinierte Funktion aus: /dmsynclabel, /dmsyncpause, und /dmsyncclear. F\195\188r Faule. ;-)",
		"/dmsynchalt - Bricht jeglichen momentanen Synchronisierungsvorgang ab.",

		"/dmpop - F\195\188llt die Liste mit den momentanen Gruppen/Schlachtzug-Mitgliedern (\195\188berschreibt keine vorhandenen Eintr\195\164ge).",
		"/dmlock - Schaltet die Listensperre an/aus. Neue Eintr\195\164ge werden einer gesperrten Liste nicht mehr hinzugef\195\188gt, bereits vorhandene jedoch aktualisiert.",
		"/dmpause - Schaltet die Datensammlungs-Funktion an/aus.",
		"/dmlockpos - Schaltet die Bewegbarkeitssperre des Fensters an/aus.",
		"/dmgrouponly - Schaltet an/aus, ob ausschlie\195\159lich Gruppen/Schlachtzug-Mitglieder ber\195\188cksichtigt werden sollen. (Dein Begleiter wird unabh\195\164ngig von dieser Einstellung ber\195\188cksichtigt.)",
		"/dmaddpettoplayer - Schaltet an/aus, ob die Daten eines Begleiter als Daten des Spielers selbst behandelt werden sollen.",
		"/dmresetoncombat - Schaltet an/aus, ob die Daten zur\195\188ckgesetzt werden, wenn ein Kampf beginnt.",
		"/dmversion - Zeigt Versionsinformationen an.",
		"/dmtotal - Schaltet die Anzeige des Gesamtwertes an/aus.",
		"/dmshowmax - Schaltet die Anzeige der Gesamtzahl angezeigter Balken an/aus.",
};

-- Filters --
DamageMeters_Filter_STRING1 = "Gruppenmitglieder";
DamageMeters_Filter_STRING2 = "Alle befreundeten Spieler";

-- Despelling --
DM_YOU_LOCALIZED = "Ihr";

-- Relationships --
DamageMeters_Relation_STRING = {
		"Ich",
		"Mein Begleiter",
		"Gruppe",
		"Freundliche Spieler"};

-- Color Schemes --
DamageMeters_colorScheme_STRING = {
		"Beziehung",
		"Klassenfarben"};

-- Quantities --
DM_QUANTSTRING_DAMAGEDONE = "Schaden";
DM_QUANTSTRING_HEALINGDONE = "Heilung";
DM_QUANTSTRING_DAMAGETAKEN = "Erlittener Schaden";
DM_QUANTSTRING_HEALINGTAKEN = "Erhaltene Heilung";
DM_QUANTSTRING_DAMAGEDONE_FIGHT = "Schaden (Kampf)";
DM_QUANTSTRING_HEALINGDONE_FIGHT = "Heilung (Kampf)";
DM_QUANTSTRING_DAMAGETAKEN_FIGHT = "Erlt. Schad. (Kampf)";
DM_QUANTSTRING_HEALINGTAKEN_FIGHT = "Erhlt. Heil. (Kampf)";
DM_QUANTSTRING_DAMAGEDONE_PS = "DPS";
DM_QUANTSTRING_HEALINGDONE_PS = "HPS";
DM_QUANTSTRING_DAMAGETAKEN_PS = "DTPS";
DM_QUANTSTRING_HEALINGTAKEN_PS = "HTPS";
DM_QUANTSTRING_IDLETIME = "Unt\195\164tige Zeit";
DM_QUANTSTRING_NETDAMAGE = "Nettoschaden";
DM_QUANTSTRING_NETHEALING = "Nettoheilung";
DM_QUANTSTRING_DAMAGEPLUSHEALING = "Schaden + Heilung";
DM_QUANTSTRING_CURING = "S\195\164uberungen";
DM_QUANTSTRING_CURING_FIGHT = "S\195\164ub. (Kampf)";
DM_QUANTSTRING_CURING_PS = "S\195\164ub./Sekunde";
DM_QUANTSTRING_OVERHEAL = "\195\156berheilung";
DM_QUANTSTRING_OVERHEAL_FIGHT = "\195\156berheil. (Kampf)";
DM_QUANTSTRING_OVERHEAL_PS = "OHPS";
DM_QUANTSTRING_HEALTH = "Gesundheit";
DM_QUANTSTRING_OVERHEAL_PERCENTAGE = "\195\156berheilung in %";
DM_QUANTSTRING_ABSHEAL = "Abs. Heilung";
DM_QUANTSTRING_ABSHEAL_FIGHT = "Abs. Heilung (Kampf)";
DM_QUANTSTRING_ABSHEAL_PS = "Abs. HPS";

DMI_NAMES = {
	DM_QUANTSTRING_DAMAGEDONE,
	DM_QUANTSTRING_HEALINGDONE,
	DM_QUANTSTRING_DAMAGETAKEN,
	DM_QUANTSTRING_HEALINGTAKEN,
	DM_QUANTSTRING_CURING,
	DM_QUANTSTRING_OVERHEAL,
	DM_QUANTSTRING_ABSHEAL,
};

DM_QUANTABBREV_DAMAGEDONE = "D";
DM_QUANTABBREV_HEALINGDONE = "H";
DM_QUANTABBREV_DAMAGETAKEN = "DT";
DM_QUANTABBREV_HEALINGTAKEN = "HT";
DM_QUANTABBREV_CURING = "Cu";
DM_QUANTABBREV_OVERHEAL = "Oh";
DM_QUANTABBREV_ABSHEAL = "RohHD";

DM_QUANTABBREV_DAMAGEDONE_PS = "DPS";
DM_QUANTABBREV_HEALINGDONE_PS = "HPS";
DM_QUANTABBREV_DAMAGETAKEN_PS = "DTPS";
DM_QUANTABBREV_HEALINGTAKEN_PS = "HTPS";
DM_QUANTABBREV_CURING_PS = "CuPS";
DM_QUANTABBREV_OVERHEAL_PS = "OHPS";
DM_QUANTABBREV_ABSHEAL_PS = "AbsHDPS";

DM_QUANTABBREV_IDLETIME = "LL";
DM_QUANTABBREV_NETDAMAGE = "NetD";
DM_QUANTABBREV_NETHEALING = "NetH";
DM_QUANTABBREV_DAMAGEPLUSHEALING = "D+H";
DM_QUANTABBREV_HEALTH = "HP";
DM_QUANTABBREV_OVERHEAL_PERCENTAGE = "Oh%";


-- Sort --
DamageMeters_Sort_STRING = {
	"Absteigend",
	"Aufsteigend",
	"Alphabetisch"};

DamageMeters_ClassConversion = {
			["J\195\132GER"] = "HUNTER",
			["HEXENMEISTER"] = "WARLOCK",
			["PRIESTER"] = "PRIEST",
			["PALADIN"] = "PALADIN",
			["MAGIER"] = "MAGE",
			["SCHURKE"] = "ROGUE",
			["DRUIDE"] = "DRUID",
			["SCHAMANE"] = "SHAMAN",
			["KRIEGER"] = "WARRIOR"
		};

function DamageMeters_GetClassColor(className)
  return RAID_CLASS_COLORS[DamageMeters_ClassConversion[string.upper(className)]];
end


-- This associates the string names of damage types (schools) with the DM_DMGTYPE constants.
DM_DMGNAMETOID = {
	["Arkan"]              = DM_DMGTYPE_ARCANE,
	["Feuer"]              = DM_DMGTYPE_FIRE,
	["Natur"]              = DM_DMGTYPE_NATURE,
	["Frost"]              = DM_DMGTYPE_FROST,
	["Schatten"]           = DM_DMGTYPE_SHADOW,
	["Heilig"]             = DM_DMGTYPE_HOLY,
	["K\195\182rperlich"]  = DM_DMGTYPE_PHYSICAL,
};

DM_DMGTYPENAMES = {
	"Arkan",
	"Feuer",
	"Natur",
	"Frost",
	"Schatten",
	"Heilig",
	"K\195\182rperlich",
	"Normal",
};

-- Errors --
DM_ERROR_INVALIDARG = "DamageMeters: Ung\195\188ltige(s) Argument(e).";
DM_ERROR_MISSINGARG = "DamageMeters: Argument(e) fehlt/en.";
DM_ERROR_NOSAVEDTABLE = "DamageMeters: Kein gespeicherter Datensatz vorhanden.";
DM_ERROR_BADREPORTTARGET = "DamageMeters: Ung\195\188ltiges Berichtziel: ";
DM_ERROR_MISSINGWHISPERTARGET = "DamageMeters: Fl\195\188stern ausgew\195\164lt, aber kein Spielername angegeben.";
DM_ERROR_MISSINGCHANNEL = "DamageMeters: Channel angegeben aber keine Zahl angegeben.";
DM_ERROR_NOSYNCCHANNEL = "DamageMeters: Synchronisations-Kanal muss angegeben werden, bevor Sync-Funktionen genutzt werden k\195\182nnen.";
DM_ERROR_JOINSYNCCHANNEL = "DamageMeters: Du musst den Synchronisations-Kanal ('%s') betreten, bevor du Sync-Funktionen benutzen kannst.";
DM_ERROR_SYNCTOOSOON = "DamageMeters: Synchronisations-Anfrage zu kurz nach der letzten - ignoriert.";
DM_ERROR_POPNOPARTY = "DamageMeters: Kann die Tabelle nicht bef\195\188llen: Du bist nicht in einer Gruppe/Schlachtzug.";
DM_ERROR_NOROOMFORPLAYER = "DamageMeters: Kann Begleiter-Daten nicht mit Spielerdaten verschmelzen, da der Spieler der Liste nicht hinzugef\195\188gt werden konnte. (Liste voll?)";
DM_ERROR_BROADCASTNOGROUP = "DamageMeters: Du musst in einer Gruppe/Schlachtzug sein, um den Synchronisations-Kanal bekanntzugeben!";
DM_ERROR_NOPARTY = "DamageMeters: Du bist nicht in eine Gruppe.";
DM_ERROR_NORAID = "DamageMeters: Du bist nicht Teil eines Schlachtzugs.";

-- Messages --
DM_MSG_SETQUANT = "DamageMeters: Setze Anzahl sichtbarer Anzeigen auf: ";
DM_MSG_CURRENTQUANT = "DamageMeters: Aktueller Wert: ";
DM_MSG_CURRENTSORT = "DamageMeters: Aktuelle Sortierung: ";
DM_MSG_SORT = "DamageMeters: Setze Sortierung auf: ";
DM_MSG_CLEAR = "DamageMeters: Entferne Eintr\195\164ge %d bis %d.";
--DM_MSG_REMAINING = "DamageMeters: %d Objekte \195\188brig.";
DM_MSG_REPORTHEADER = "DamageMeters: <%s> Bericht \195\188ber %d/%d Quellen:";
DM_MSG_PLAYERREPORTHEADER = "DamageMeters: Spielerbericht \195\188ber %s:";
DM_MSG_SETCOUNTTOMAX = "DamageMeters: Keine Anzahl angegeben, stelle das Maximum ein.";
DM_MSG_SETCOUNT = "DamageMeters: Neue Balkenanzahl: ";
DM_MSG_RESETFRAMEPOS = "DamageMeters: Setze Fensterposition zur\195\188ck.";
DM_MSG_SAVE = "DamageMeters: Speichere aktuelle Daten.";
DM_MSG_RESTORE = "DamageMeters: Stelle gespeicherte Daten wieder her.";
DM_MSG_MERGE = "DamageMeters: Verschmelze gespeicherte Daten mit den aktuellen Daten.";
DM_MSG_SWAP = "DamageMeters: Tausche aktuelle Daten (%d) gegen gespeicherte Daten (%d).";
DM_MSG_SETCOLORSCHEME = "DamageMeters: Setze Farbschema auf: ";
DM_MSG_TRUE = "Ja";
DM_MSG_FALSE = "Nein";
DM_MSG_SETVISINPARTY = "DamageMeters: Nur-in-Gruppe-sichtbar ist eingestellt auf: ";
DM_MSG_SETAUTOCOUNT = "DamageMeters: Setze die Obergrenze automatisch angezeiger Balken auf: ";
DM_MSG_LISTBANNED = "DamageMeters: Liste gebannter Eintr\195\164ge: ";
DM_MSG_CLEARBANNED = "DamageMeters: L\195\182sche alle gebannten Eintr\195\164ge.";
DM_MSG_HOWTOSHOW = "DamageMeters: Verstecke das Fenster. Benutze /dmshow um es wieder sichtbar zu machen.";
DM_MSG_SYNCCHAN = "DamageMeters: Synchronisations-Kanal eingestellt auf: ";
DM_MSG_SYNCREQUESTACK = "DamageMeters: Synchronisierung angefordert von Spieler: ";
DM_MSG_SYNCREQUESTACKEVENTS = "DamageMeters: Synchronisierung (mit Ereignissen) angefordert von Spieler: ";
DM_MSG_SYNC = "DamageMeters: Sende Synchronisierungs-Daten.";
DM_MSG_SYNCEVENTS = "DamageMeters: Sende Synchronisierungs-Daten (mit Ereignissen).";
DM_MSG_LOCKED = "DamageMeters: Liste fixiert.";
DM_MSG_NOTLOCKED = "DamageMeters: Liste freigegeben.";
DM_MSG_PAUSED = "DamageMeters: Datensammlung pausiert.";
DM_MSG_UNPAUSED = "DamageMeters: Datensammlung fortgesetzt.";
DM_MSG_POSLOCKED = "DamageMeters: Position fixiert.";
DM_MSG_POSNOTLOCKED = "DamageMeters: Position freigegeben.";
DM_MSG_CLEARRECEIVED = "DamageMeters: L\195\182schanfrage erhalten von Spieler: ";
DM_MSG_ADDINGPETTOPLAYER = "DamageMeters: Begleiterdaten werden nun behandelt, als k\195\164men sie von dir selbst.";
DM_MSG_NOTADDINGPETTOPLAYER = "DamageMeters: Begleiterdaten werden nun separat von deinen eigenen behandelt.";
DM_MSG_PETMERGE = "DamageMeters: Verschmelze Begleiterdaten (von %s) mit deinen eigenen.";
DM_MSG_RESETWHENCOMBATSTARTSCHANGE = "DamageMeters: Zur\195\188cksetzen wenn ein Kampf beginnt: ";
DM_MSG_SHOWFIGHTASPS = "DamageMeters: Zeige Kampfdaten als \"pro Sekunde\": ";
DM_MSG_COMBATDURATION = "Kampfdauer: %.2f Sekunden.";
DM_MSG_RECEIVEDSYNCDATA = "DamageMeters: Empfange Synchronisierungs-Daten von %s.";
DM_MSG_TOTAL = "GESAMT";
DM_MSG_VERSION = "DamageMeters Version %s geladen.";
DM_MSG_REPORTHELP = "Der Befehl /dmreport besteht aus drei Teilen:\n\n1) Der Zielbuchstabe. Dies kann einer der folgenden Buchstaben sein:\n  c - Console (Nur du selbst kannst es sehen)\n  s - Sagen\n  p - Gruppenchat\n  r - Schlachtzugchat\n  g - Gildenchat\n  o - Gildenoffiziers-Chat\n  h - Chatchannel. /dmreport h MeinChannel\n  w - Einem Spieler fl\195\188stern. /dmreport w Leeroy\n  f - Fenster: Zeigt den Bericht in diesem Fenster.\n\nWenn der Buchstabe kleingeschrieben ist, wird der Bericht in umgekehrter Reihenfolge sein (niedrigster -> h\195\182chster)%.\n\n2) Optional die Anzahl Leute auf die der Bericht begrenzt sein soll. Diese Zahl kommt direkt hinter den Zielbuchstaben.\nZum Beispiel: /dmreport p5.\n\n3) Standardm\195\164\195\159ig umfasst ein Bericht nur den momentan angezeigten Wert. Wenn jedoch das Wort 'total' vor dem Zielbuchstaben angegeben wird, umfasst der Bericht die Gesamtzahlen f\195\188r alle Werte. Auf diese Art erstellte Berichte sind so formatiert, dass sie in einer Textdatei gut aussehen und eignen sich daher am besten zur Verwendung mit der Ausgabe in einem Fenster zum herauskopieren.\nZum  Beispiel: /dmreport total f\n\nEin weiteres Beispiel: Fl\195\188stere dem Spieler 'Leeroy' die Top drei in der Liste:\n/dmreport w3 Leeroy";
DM_MSG_COLLECTORS = "Datensammler: (%s)";
DM_MSG_ACCUMULATING = "DamageMeters: Sammle Daten im Speicher.";
DM_MSG_REPORTTOTALDPS = "Gesamt = %.1f (%.1f sichtbar)";
DM_MSG_REPORTTOTAL = "Gesamt = %d (%d sichtbar)";
DM_MSG_SYNCMSG = "[DMM] |Hplayer:%s|h[%s]|h: %s";
DM_MSG_MEMCLEAR = "DamageMeters: Gespeicherte Daten gel\195\182scht.";
DM_MSG_MAXBARS = "DamageMeters: Zeige so viele Balken wie m\195\182glich an: %s.";
DM_MSG_MINBARS = "DamageMeters: Fenster minimiert: %s.";
DM_MSG_LEADERREPORTHEADER = "DamageMeters: Anf\195\188her-Bericht \195\188ber %d/%d Quellen:\n #";
-- This causes disconnects...maybe its too long?  ..maybe WoW doesn't like the \n character?
--DM_MSG_FULLREPORTHEADER = "DamageMeters: Full Report on %d/%d Sources:\nPlayer        Damage     Healing     Damaged      Healed        Hits   Crits\n_______________________________________________________________________________";
DM_MSG_FULLREPORTHEADER1 = "DamageMeters: Voller Bericht \195\188ber %d/%d Quellen:";
DM_MSG_FULLREPORTHEADER2 = "Spieler       Schaden    Heilung     Erlt.Schaden  Erhlt.Heilung  Treffer   Crits";
DM_MSG_FULLREPORTHEADER3 = "_______________________________________________________________________________";
DM_MSG_CLEARACKNOWLEDGED = "DamageMeters: L\195\182schung best\195\164tigt von Spieler: %s.";
DM_MSG_EVENTREPORTHEADER = "DamageMeters: Ereignis-Bericht \195\188ber %d/%d Quellen:\n";
DM_MSG_PLAYERONLYEVENTDATAOFF = "DamageMeters: Zeichne Ereignisdaten aller Spieler auf.";
DM_MSG_PLAYERONLYEVENTDATAON = "DamageMeters: Zeichne nur deine eigenen Ereignisdaten auf.";
DM_MSG_SYNCCHANBROADCAST = "<DamageMeters>: Setting this group's sync channel to: ";
DM_MSG_SYNCINGROUPON = "DamageMeters: Du tauscht Synchronisations-Daten nur mit Gruppenmitgliedern aus.";
DM_MSG_SYNCINGROUPOFF = "DamageMeters: Du tauscht Synchronisations-Daten mit jedermann aus.";
DM_MSG_AUTOSYNCJOINON = "DamageMeters: Du betrittst nun automatisch im Gruppen-/Schlachtzugchat bekanntgegebene Synchronisations-Kan\195\164le.";
DM_MSG_AUTOSYNCJOINOFF = "DamageMeters: Du betrittst nun nicht mehr automatisch im Gruppen-/Schlachtzugchat bekanntgegebene Synchronisations-Kan\195\164le";
DM_MSG_SYNCHELP = "DamageMeters' Synchronisiation ist ein Vorgang bei dem mehrere DamageMeters-Benutzer ihre gesammelten Daten austauschen. Der Hauptverwendungszweck liegt in Instanzen, in denen Spieler oft weit genug voneinander entfernt sind, um nicht mehr alle Kampfnachrichten aller anderen Mitspieler mitgeteilt zu bekommen.\n\nKurzanleitung zur Synchronisation\n\n1) Jemand (der Sync-Leiter) w\195\164hlt einen Kanalnamen aus und betritt ihn, z.B. mit /dmsyncchan UnserBeispielChannel\n2) Der Sync-Leiter benutzt dann /dmsyncbroadcastchan (bzw. /dmsyncb). Jeder, der eine halbwegs aktuelle Version von DamageMeters benutzt, wird dann automatisch diesem Channel beitreten.\n3) Der Sync-Leiter w\195\164hlt einen Namen f\195\188r die Sitzung -- zum Beispiel 'Onyxia' -- und benutzt dann /dmsyncstart mit diesem Namen. (/dmsyncstart Onyxia) Dies l\195\182scht die Daten aller Teilnehmer, pausiert alle DamageMeters der Teilnehmer und markiert die Daten mit diesem Namen.\n3) Sobald alle im angegebenen Channel sind, aber noch bevor die Action losgeht, sollte der Sync-Leiter /dmsyncready oder /dmsyncunpause benutzen, damit wieder Daten gesammelt werden.\n4) Spielt!  Sammelt Daten!\n5) Zu guter Letzt benutzt der Sync-Leiter /dmsync um die Daten aller Teilnehmer abzugleichen. Da dieser Vorgang ein wenig anstrengend f\195\188r WoW ist, ist es empfehlenswert dies nicht mitten im Kampf zu machen, sondern eher, wenn gerade mal nicht so viel los ist. Wenn Ereignisdaten gew\195\188nscht sind, muss (/dmsync e) verwendet werden - allerdings dauert dies dann bedeutend l\195\164nger.\n\nHinweis: Der Sync-Leiter kann nichts besonderes, die Befehle k\195\182nnen von jedem Teilnehmer ausgef\195\188hrt werden. Es erleichert jedoch die gesamte Verwaltung, wenn eine bestimmte Person f\195\188r all dies zust\195\164ndig ist.";
DM_MSG_PINGING = "DamageMeters: Pinge andere Spieler...";
DM_MSG_SYNCONLYPLAYEREVENTSON = "DamageMeters: Nur deine eigenen Ereignisdaten werden \195\188bermittelt.";
DM_MSG_SYNCONLYPLAYEREVENTSOFF = "DamageMeters: Ereignisdaten aller Spieler werden \195\188bermittelt.";
DM_MSG_SYNCPAUSE = "DamageMeters: Pause-Befehl von Spieler %s erhalten.";
DM_MSG_SYNCUNPAUSE = "DamageMeters: Fortsetzen-Befehl von Spieler %s erhalten.";
DM_MSG_SYNCREADY = "DamageMeters: Bereitschafts-Befehl von Spieler %s erhalten.";
DM_MSG_SYNCPAUSEREQ = "DamageMeters: Sende Pause-Befehl...";
DM_MSG_SYNCUNPAUSEREQ = "DamageMeters: Sende Fortsetzen-Befehl...";
DM_MSG_SYNCREADYREQ = "DamageMeters: Sende Bereitschafts-Befehl...";
DM_MSG_PRESSCONTROLEVENT = "Halte Steuerung gedr\195\188ckt, um Ereignisdaten zu sehen";
DM_MSG_PRESSCONTROLQUANTITY = "Halte Steuerung gedr\195\188ckt, um Wertedaten zu sehen";
DM_MSG_PRESSALTSINGLEQUANTITY = "Halte Alt gedr\195\188ckt, um nur den aktuellen Wert zu sehen";
DM_MSG_PAUSEDTITLE = "Pausiert";
DM_MSG_READYTITLE = "Bereit";
DM_MSG_EVENTDATALEVEL = {
	"DamageMeters: Sammle keine Ereignisdaten.",
	"DamageMeters: Sammle nur die Ereignisdaten des Spielers selbst.",
	"DamageMeters: Sammle Ereignisdaten aller Spieler."
};
DM_MSG_SYNCEVENTDATALEVEL = {
	"DamageMeters: \195\156bermittle keine Ereignisdaten.",
	"DamageMeters: \195\156bermittle nur die Ereignisdaten des Spielers selbst.",
	"DamageMeters: \195\156bermittle Ereignisdaten aller Spieler."
};
DM_MSG_HELP = "- /dmcmd eingeben, um eine Liste der verf\195\188gbaren Befehle zu erhalten.\n- Solltest du das DamageMeters-Fenster nicht sehen k\195\182nnen, versuch' /dmresetpos.";
DM_MSG_LEAVECHAN = "DamageMeters: Verlasse Synchronisations-Kanal '%s'.";
DM_MSG_READYUNPAUSING = "DamageMeters: Schadensereignis empfangen, \195\188bermittle Sync-Fortsetzen-Befehl...";
DM_MSG_KICKED = "DamageMeters: Du wurdest von %s aus dem Synchronisations-Kanal entfernt.";
DM_MSG_SETLABEL = "DamageMeters: Name der Datensammlung auf <%s> eingestellt. (Index = %d)";
DM_MSG_SESSIONMISMATCH = "DamageMeters: Synchronisierungs-Daten aus einer anderen Datensammlung erhalten. L\195\182sche aktuelle Daten automatisch.";
DM_MSG_SHOWINGFIGHTEVENTSONLY = "Zeige nur Ereignisse aus dem aktuellen Kampf.";
DM_MSG_SYNCCLEARREQ = "DamageMeters: \195\156bermittle L\195\182schanfrage...";
DM_MSG_CURRENTBARWIDTH = "DamageMeters: Momentane Balkenbreite = %d.\nBenutze (/dmsetbarwidth default) zum zur\195\188cksetzen.";
DM_MSG_NEWBARWIDTH = "DamageMeters: Neue Balkenbreite: %d.";
DM_MSG_PLAYERJOINEDSYNCCHAN = "DamageMeters: Spieler %s hat den Synchronisations-Kanal betreten. [Version %s]";
DM_MSG_SYNCSESSIONMISMATCH = "Datensammlung des Spielers %s (%s:%d) passte nicht: Daten des Spielers gel\195\182scht.";
DM_MSG_SYNCHALTRECEIVED = "DamageMeters: Synchronisierungs-Stopp-Befehl erhalten von Spieler %s.";
DM_MSG_SYNCHALTSENT = "DamageMeters: \195\156bermittle Stopp-Befehl...";
-- RPS
DM_MSG_RPS_CHALLENGE = "Du forderst %s zu Stein-Schere-Papier heraus! Dein Zug ist: %s.";
DM_MSG_RPS_CHALLENGED = "%s hat dich zu Stein-Schere-Papier herausgefordert! Benutze /dmrpsr [Spielername] [r/s/p] um zu reagieren.";
DM_MSG_RPS_MISSING_PLAYER = "FEHLER: Fehlendes Argument. Der Spielername kann NUR ausgelassen werden, wenn nur ein einziger Spieler dich momentan herausfordert.";
DM_MSG_RPS_NOTCHALLENGED = "FEHLER: %s hat dich nicht herausgefordert.";
DM_MSG_RPS_YOUPLAY = "Dein Zug ist: %s.";
DM_MSG_RPS_PLAYS = "%ss Zug ist: %s.";
DM_MSG_RPS_DEFEATED = "%s hat dich besiegt.";
DM_MSG_RPS_VICTORIOUS = "Du hast %s besiegt!"
DM_MSG_RPS_TIE = "Das Spiel gegen %s endet mit einem Patt.";

--[[ Note: This is only to help construct the DM_MSG_REPORTHELP string.
The /dmreport command consists of three parts:

1) The destination character.  This can be one of the following letters:
  c - Console (only you can see it)%.
  s - Say
  p - Party chat
  r - Raid chat
  g - Guild chat
  h - Chat cHannel. /dmreport h mychannel
  w - Whisper to player.  /dmreport w dandelion
  f - Frame: Shows the report in this window.

If the letter is lower case the report will be in reverse order (lowest to highest)%.

2) Optionally, the number of people to limit it to.  This number goes right after the destination character.
Example: /dmreport p5

3) By default, reports are on the currently visible quantity only.  If the word 'total' is specified before the destination character, though, the report will be on the totals for every quantity. 'Total' reports are formatted so that they look good when cut-and-paste into a text file, and so work best with the Frame destination.
Example: /dmreport total f

Example: Whisper to player "dandelion" the top three people in the list:
/dmreport w3 dandelion
]]--

--[[ Note: This is only to help construct the DM_MSG_SYNCHELP string.
DamageMeters Sync'ing (short for synchronization) is a process whereby multiple DM users can transmit their data to each other.  Its primary use is for instances where the players are often far from each other and thus miss some of each other's combat messages.\n\nSync Quick-Start Guide:\n\n1) Someone (I'll call her the Sync Leader) chooses a channel name and joins it, ie. /dmsyncchan ourchannel.\n2) The Sync Leader then calls /dmsyncbroadcastchan (or just /dmsyncb).  Anyone who is running a sufficiently recent version of DM will automatically be joined into that channel.\n3) The Sync Leader choses a name for the session--for example, Onyxia-- then calls /dmsyncstart with that name. (/dmsyncstart Onyxia_.  This will clear everyone's data and pause them, as well as mark them with this label.\n3) Once everyone is in the channel, but before the activity begins, the Sync  Leader should call /dmsyncready or /dmsyncunpause so that data collection can happen.\n4) Play!  Collect data!\n5) Finally, the Sync Leader calls /dmsync whenever she wants the raid to share data.  Since it can cause a little slowdown it is best to do this between fights (though not necessarily between every fight).  If event data is desired, call (/dmsync e), though it takes a lot longer to sync.\n\nNote: There is nothing special about the Sync Leader: any player can perform any of these commands.  It just seems simpler to have one person in charge of it.
]]--

-- Menu Options --
DM_MENU_CLEAR = "L\195\182schen";
DM_MENU_RESETPOS = "Position zur\195\188cksetzen";
DM_MENU_HIDE = "Fenster verstecken";
DM_MENU_SHOW = "Fenster anzeigen";
DM_MENU_VISINPARTY = "Nur in Gruppen sichtbar";
DM_MENU_REPORT = "Bericht";
DM_MENU_BARCOUNT = "Balkenanzahl";
DM_MENU_AUTOCOUNTLIMIT = "Autom. Balken";
DM_MENU_SORT = "Sortierreihenfolge";
DM_MENU_VISIBLEQUANTITY = "Sichtbarer Wert";
--DM_MENU_COLORSCHEME = "Farbschema";
DM_MENU_MEMORY = "Datenspeicher";
DM_MENU_SAVE = "Speichern";
DM_MENU_RESTORE = "Wiederherstellen";
DM_MENU_MERGE = "Verschmelzen";
DM_MENU_SWAP = "Austauschen";
DM_MENU_DELETE = "L\195\182schen";
DM_MENU_BAN = "Verbannen";
DM_MENU_CLEARABOVE = "Oberhalb l\195\182schen";
DM_MENU_CLEARBELOW = "Unterhalb l\195\182schen";
--DM_MENU_LOCK = "Liste fixieren";
--DM_MENU_UNLOCK = "Liste freigeben";
DM_MENU_PAUSE = "Pausieren";
--DM_MENU_UNPAUSE = "Datensammlung fortsetzen";
DM_MENU_LOCKPOS = "Position fixieren";
DM_MENU_UNLOCKPOS = "Position freigeben";
DM_MENU_GROUPMEMBERSONLY = "Nur Gruppenmitglieder \195\188berwachen";
DM_MENU_ADDPETTOPLAYER = "Begleiterdaten als eigene Daten z\195\164hlen";
DM_MENU_TEXT = "Textoptionen";
DM_MENU_TEXT_RANK = "Platz";
DM_MENU_TEXT_NAME = "Name";
DM_MENU_TEXT_TOTALPERCENTAGE = "% von Gesamt";
DM_MENU_TEXT_LEADERPERCENTAGE = "% des Anf\195\188hrers";
DM_MENU_TEXT_VALUE = "Wert";
DM_MENU_TEXT_DELTA = "Differenz";
DM_MENU_SETCOLORFORALL = "Setze Farbe f\195\188r alle";
DM_MENU_DEFAULTCOLORS = "Stelle Standardfarben wieder her";
DM_MENU_RESETONCOMBATSTARTS = "Daten bei Kampfbeginn zur\195\188cksetzen";
DM_MENU_SHOWFIGHTASPS = "Kampfdaten als \"pro Sekunde\" anzeigen";
DM_MENU_REFRESHBUTTON = "Aktualisieren";
DM_MENU_TOTAL = "Gesamt";
DM_MENU_CHOOSEREPORT = "Bericht w\195\164hlen";
-- Note reordered this list in version 2.2.0
DM_MENU_REPORTNAMES = {"Fenster", "Konsole", "Sagen", "Gruppe", "Schlachtzug", "Gilde", "Offiziere"};
DM_MENU_TEXTCYCLE = "Durchschalten";
DM_MENU_QUANTCYCLE = "Automatisch Durchschalten";
DM_MENU_HELP = "Hilfe";
DM_MENU_ACCUMULATEINMEMORY = "Daten aufsummieren";
DM_MENU_POSITION = "Position";
DM_MENU_RESIZELEFT = "Gr\195\182\195\159e nach links anpassen";
DM_MENU_RESIZEUP = "Gr\195\182\195\159e nach oben anpassen";
DM_MENU_SHOWMAX = "Alle";
DM_MENU_SHOWTOTAL = "Gesamtwert anzeigen";
DM_MENU_LEADERS = "Anf\195\188hrer";
DM_MENU_PLAYERREPORT = "Spielerbericht";
DM_MENU_EVENTREPORT = "Ereignisbericht";
DM_MENU_EVENTDATA = "Ereignisdaten";
DM_MENU_EVENTDATA_NONE = "Keine Ereignisse beachten";
DM_MENU_EVENTDATA_PLAYER = "Ereignisse des Spielers beachten";
DM_MENU_EVENTDATA_ALL = "Ereignisse aller Spieler beachten";
--DM_MENU_SYNCEVENTDATA_NONE = "\195\156bermittle keine Ereignisse";
--DM_MENU_SYNCEVENTDATA_PLAYER = "\195\156bermittle Ereignisse des Spielers selbst";
--DM_MENU_SYNCEVENTDATA_ALL = "\195\156bermittle Ereignisse aller Spieler";
DM_MENU_SHOWEVENTDATATOOLTIP = "Tooltip-Standard";
DM_MENU_EVENTS1 = "Ereignisse 1-20";
DM_MENU_EVENTS2 = "Ereignisse 21-40";
DM_MENU_EVENTS3 = "Ereignisse 41-50";
DM_MENU_SYNC = "Synchronisation";
DM_MENU_ONLYSYNCWITHGROUP = "Nur mit Gruppenmitgliedern synchronisieren";
DM_MENU_PERMITSYNCAUTOJOIN = "Bekanntgegebenen Channels beitreten";
DM_MENU_CLEARONAUTOJOIN = "Daten beim Beitreten l\195\182schen";
DM_MENU_SYNCBROADCASTCHAN = "Kanal bekanntgeben";
DM_MENU_SYNCLEAVECHAN = "Kanal verlassen";
DM_MENU_SYNCONLYPLAYEREVENTS = "Nur Ereignisse des Spielers synchronisieren";
DM_MENU_ENABLEDMM = "DMM-Nachrichten anzeigen";
DM_MENU_NOSYNCCHAN = "KEIN SYNC-KANAL ANGEGEBEN";
DM_MENU_SYNCCHAN = "Momentaner Sync-Kanal: ";
DM_MENU_SESSION = "Momentane Datensammlung: ";
DM_MENU_SAVEDSESSION = "Datensammlung: ";
DM_MENU_JOINSYNCCHAN = "Kanal beitreten: Benutze /dmsyncchan";
DM_MENU_PARSEEVENTMESSAGES = "Eingehende Ereignisse verarbeiten";
DM_MENU_SENDINGBAR = "Sende...";
DM_MENU_PROCESSINGBAR = "Verarbeite...";
DM_MENU_QUANTITYFILTER = "Werte-Filter";
DM_MENU_MINIMIZE = "Minimieren";
DM_MENU_LEFTJUSTIFYTEXT = "Links-Ausrichtung";
DM_MENU_RESTOREDEFAULTOPTIONS = "Standard-Einstellungen wiederherstellen";
DM_MENU_PLAYERALWAYSVISIBLE = "Spieler selbst immer sichtbar";
DM_MENU_APPLYFILTERTOMANUALCYCLING = "Auf manuelles Durchschalten anwenden";
DM_MENU_APPLYFILTERTOAUTOCYCLING = "Auf automatisches Durchschalten anwenden";
DM_MENU_GENERAL = "Allgemeine Optionen";
DM_MENU_GROUPDPSMODE = "Gruppen-DPS-Modus";
DM_MENU_CLEARBANNED = "Alle entbannen";
DM_MENU_CONSTANTVISUALUPDATE = "Permanentes Grafikupdate";
DM_MENU_CLEARWHENJOINPARTY = "L\195\182schen beim Gruppenbeitritt";

-- Misc
DM_CLASS = "Klasse"; -- The word for player class, like Druid or Warrior.
DM_TOOLTIP = "\nZeit seit letzter Aktion = %.1fs\nBeziehung = %s";
DM_YOU = "Du"
DM_CRITSTR = "Crit";
DM_UNKNOWNENTITY = "Unbekannte Entit\195\164t";
DM_SYNCSPELLNAME = "[Sync]";

DM_DMG_MELEE = "[Nahkampf]";
DM_DMG_FALLING = "[Fallschaden]";
DM_DMG_LAVA = "[Lava]";
DM_DMG_DAMAGESHIELD = "[Schadensschild]";
DM_DMG_DEATH = "[Tod]";
DM_DMG_COMBAT = "[Nicht im Kampf]";

DamageMeters_RPSmoveStrings =
{
	r = "Stein",
	p = "Papier",
	s = "Schere"
};

-------------------------------------------------------------------------------

--[[ This system based on the one in Gello's Recap, which itself was based on the one in Telo's MobHealth.
- source and dest = 0 means the player

TODO: These are all special cases in English because they contain apostrophes.
Julie's Dagger
Rammstein's Lightning Bolts
Night Dragon's Breath

]]--

--[[
This table defines types of messages that DM parses and how to parse them.

The index of the table is a human-readable name, which by convention is
normally the name of the string variable (as defined in GlobalStrings.lua) that
is being parsed.  Every type of message that is parsed for the "Damage Done",
"Healing Done", "Damage Taken", and "Healing Taken" quantities must be defined in this
table.

The key to the system is the "pattern" member.  This is usually (there are some
special cases) a string defined in GlobalStrings.lua.  An example is COMBATHITSELFOTHER =
"You hit %s for %d.".  When DM loads up it goes through this list and converts all the
patterns into "regular expression" search strings.  So, for example, the above becomes
"You hit (.+) for (%d+)%."

When a match is found there will be an array of "elements" for
each unknown in the pattern.  In the above pattern, elements[1] will be the string name
of who was hit, and elements[2] will be how much damage was done.  Each msgInfo has fields
in which you specify which elements mean what.  So, in the msgInfo for this example we set
"dest=1" and "amount=2".

The fields of each entry are defined as follows:
- source: The index of the element that specifies the source of the amount.  The source is the
person doing damage or doing the healing in the case of "Damage done" and "healing done" messages,
but it is the the person being hit in the case of "damage received" messages.  When source=0, it
means the player (us) is the source.
- dest: The name of the entity being effected.  Again, dest=0 means the player.
- amount: The index of the element that contains the quantity of damage/healing done.
- spell: This is the index of the element which references the spell that is doing the damage/healing.
Alternately, if it is a string that spell will be used explicitly.  Spell=0 or nil defaults to regular
melee damage.
- damageType: Also known as "school", this is the index of the element which specifies the type of
damage done, ie. "physical", "fire", "frost", etc.
- crit: This is one of three defined values: DM_HIT, DM_CRT, DM_DOT.  Set this to specify whether
the message represents a spell that hit normally, critically hit, or was a non-crittable spell.
(Damage Over Time spells, DOTs, cannot crit, hence the name.)
- pattern: This is the pattern, usually a string from GlobalStrings.lua.
- custom: If this is set to true, the pattern will not be transformed when DM is loaded.  Use
this for custom patterns.
]]--

DamageMeters_msgInfo = {
	-- CHAT_MSG_COMBAT_SELF_HITS
		_COMBATHITSELFOTHER =
			{ source=0, dest=1, amount=2, spell=0, damageType=0, crit=DM_HIT, pattern=COMBATHITSELFOTHER }, -- You hit (.+) for (%d+)
		_COMBATHITCRITSELFOTHER =
			{ source=0, dest=1, amount=2, spell=0, damageType=0, crit=DM_CRT, pattern=COMBATHITCRITSELFOTHER }, -- You crit (.+) for (%d+)
		_VSENVIRONMENTALDAMAGE_FALLING_SELF =
			{ source=0, dest=0, amount=1, spell=DM_DMG_FALLING, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_FALLING_SELF }, -- You fall and lose (%d+) health
		_VSENVIRONMENTALDAMAGE_LAVA_SELF =
			{ source=0, dest=0, amount=1, spell=DM_DMG_LAVA, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_LAVA_SELF }, -- You lose %d health for swimming in lava.


	-- CHAT_MSG_SPELL_SELF_DAMAGE
		_SPELLLOGSCHOOLSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=4, crit=DM_HIT, pattern=SPELLLOGSCHOOLSELFOTHER }, -- Your (.+) hits (.+) for (%d+) (.+)%.
		_SPELLLOGCRITSCHOOLSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=4, crit=DM_CRT, pattern=SPELLLOGCRITSCHOOLSELFOTHER }, -- "Your %s crits %s for %d %s damage.";
		_SPELLLOGSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=0, crit=DM_HIT, pattern=SPELLLOGSELFOTHER }, -- Your (.+) hits (.+) for (%d+)
		_SPELLLOGCRITSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=0, crit=DM_CRT, pattern=SPELLLOGCRITSELFOTHER }, -- Your (.+) crits (.+) for (%d+)

	-- "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		-- No such message.
		--_PERIODICAURADAMAGEABSORBEDSELFOTHER =
		--	{ source=0, dest=1, amount=2, spell=4, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGEABSORBEDSELFOTHER }, -- = "%s suffers %d %s damage from your %s (%d absorbed)."
		_PERIODICAURADAMAGESELFOTHER =
			{ source=0, dest=1, amount=2, spell=4, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGESELFOTHER }, -- (.+) suffers (%d+) (.+) damage from your (.+).
		-- No such message.
		--_PERIODICAURADAMAGEABSORBEDOTHEROTHER =
		--	{ source=4, dest=1, amount=2, spell=5, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGEABSORBEDOTHEROTHER }, -- %s suffers %d %s damage from %s's %s (%d absorbed).
		_PERIODICAURADAMAGEOTHEROTHER =
			{ source=4, dest=1, amount=2, spell=5, damageType=0, crit=DM_DOT, pattern=PERIODICAURADAMAGEOTHEROTHER }, -- (.+) suffers (%d+) (.+) damage from (.+)'s (.+)

	-- "CHAT_MSG_COMBAT_PARTY_HITS" or "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS" or	"CHAT_MSG_COMBAT_PET_HITS")
		_COMBATHITOTHEROTHER =
			{ source=1, dest=2, amount=3, spell=7, damageType=0, crit=DM_HIT, pattern=COMBATHITOTHEROTHER }, -- (.+) hits (.+) for (%d+)
		_COMBATHITCRITOTHEROTHER =
			{ source=1, dest=2, amount=3, spell=7, damageType=0, crit=DM_CRT, pattern=COMBATHITCRITOTHEROTHER }, -- (.+) crits (.+) for (%d+)
		_VSENVIRONMENTALDAMAGE_FALLING_OTHER =
			{ source=1, dest=1, amount=2, spell=DM_DMG_FALLING, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_FALLING_OTHER }, -- %s falls and loses %d health.
		_VSENVIRONMENTALDAMAGE_LAVA_OTHER =
			{ source=1, dest=1, amount=2, spell=DM_DMG_LAVA, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_LAVA_OTHER }, -- %s loses %d health for swimming in lava.

	-- "CHAT_MSG_SPELL_PARTY_DAMAGE"  "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" "CHAT_MSG_SPELL_PET_DAMAGE"
		_SPELLLOGOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=0, crit=DM_HIT, pattern=SPELLLOGOTHEROTHER }, -- (.+)'s (.+) hits (.+) for (%d+) -- 
		_SPELLLOGCRITOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=0, crit=DM_CRT, pattern=SPELLLOGCRITOTHEROTHER }, -- (.+)'s (.+) crits (.+) for (%d+)
		_SPELLSPLITDAMAGEOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=0, crit=DM_DOT, pattern=SPELLSPLITDAMAGEOTHEROTHER }, -- (.+)'s (.+) causes (.+) (%d+) damage

	-- CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF
		_DAMAGESHIELDSELFOTHER =
			{ source=0, dest=3, amount=1, spell=DM_DMG_DAMAGESHIELD, damageType=0, crit=DM_DOT, pattern=DAMAGESHIELDSELFOTHER }, -- You reflect (%d+) (.+) damage to (.+)

	-- CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS
		_DAMAGESHIELDOTHEROTHER =
			{ source=1, dest=4, amount=2, spell=DM_DMG_DAMAGESHIELD, damageType=0, crit=DM_DOT, pattern=DAMAGESHIELDOTHEROTHER }, -- (.+) reflects (%d+) (.+) damage to (.+)
		-- ? soul link or something?
		_SPELLSPLITDAMAGESELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=0, crit=DM_DOT, pattern=SPELLSPLITDAMAGESELFOTHER }, -- Your (.+) causes (.+) (%d+) damage

-- DAMAGE TAKEN
	--"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" -- this gets complicated with pets.
	--"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS"
	--"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS"
		_COMBATHITOTHERSELF =
			{ source=1, dest=0, amount=2, crit=DM_HIT, pattern=COMBATHITOTHERSELF }, -- "%s hits you for %d.";
		_COMBATHITCRITOTHERSELF =
			{ source=1, dest=0, amount=2, crit=DM_CRT, pattern=COMBATHITCRITOTHERSELF }, -- "%s crits you for %d.";
		_COMBATHITOTHEROTHER =
			{ source=1, dest=2, amount=3, crit=DM_HIT, pattern=COMBATHITOTHEROTHER }, -- "%s hits %s for %d.";
		_COMBATHITCRITOTHEROTHER =
			{ source=1, dest=2, amount=3, crit=DM_CRT, pattern=COMBATHITCRITOTHEROTHER }, -- "%s crits %s for %d.";
		_COMBATHITCRITSCHOOLOTHEROTHER =
			{ source=1, dest=2, amount=3, damageType=4, crit=DM_CRT, pattern=COMBATHITCRITSCHOOLOTHEROTHER }, -- "%s crits %s for %d %s damage.";
		_COMBATHITSCHOOLOTHEROTHER =
			{ source=1, dest=2, amount=3, damageType=4, crit=DM_HIT, pattern=COMBATHITSCHOOLOTHEROTHER }, -- "%s hits %s for %d %s damage.";
		_COMBATHITCRITSCHOOLOTHERSELF =
			{ source=1, dest=0, amount=2, damageType=3, crit=DM_CRT, pattern=COMBATHITCRITSCHOOLOTHERSELF }, -- "%s crits you for %d %s damage.";
		_COMBATHITSCHOOLOTHERSELF =
			{ source=1, dest=0, amount=2, damageType=3, crit=DM_HIT, pattern=COMBATHITSCHOOLOTHERSELF }, -- "%s hits you for %d %s damage.";


	--"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or
	--"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or
	--"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		_SPELLLOGOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, damageType=0, crit=DM_HIT, pattern=SPELLLOGOTHERSELF }, -- "%s's %s hits you for %d.";
		_SPELLLOGSCHOOLOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, damageType=4, crit=DM_HIT, pattern=SPELLLOGSCHOOLOTHERSELF }, --  "%s's %s hits you for %d %s damage.";
		_SPELLLOGCRITSCHOOLOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, damageType=4, crit=DM_CRT, pattern=SPELLLOGCRITSCHOOLOTHERSELF }, --  "%s's %s crits you for %d %s damage.";
		_SPELLLOGCRITOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, crit=DM_CRT, pattern=SPELLLOGCRITOTHERSELF }, -- "%s's %s crits you for %d.";
		-- bunch of junk in here in the old code
		_SPELLRESISTOTHERSELF =
			{ source=1, dest=0, amount=0, spell=2, crit=DM_HIT, pattern=SPELLRESISTOTHERSELF }, -- "%s's %s was resisted.";

		_SPELLLOGSCHOOLOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=5, crit=DM_HIT, pattern=SPELLLOGSCHOOLOTHEROTHER }, --  "%s's %s hits %s for %d %s damage.";
		_SPELLLOGCRITSCHOOLOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=5, crit=DM_CRT, pattern=SPELLLOGCRITSCHOOLOTHEROTHER }, --  "%s's %s crits %s for %d %s damage.";
		_SPELLRESISTOTHEROTHER =
			{ source=1, dest=3, amount=0, spell=2, crit=DM_HIT, pattern=SPELLRESISTOTHEROTHER }, -- "%s's %s was resisted by %s.";

	--"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
		_PERIODICAURADAMAGEOTHERSELF =
			{ source=3, dest=0, amount=1, spell=4, damageType=2, crit=DM_DOT, pattern=PERIODICAURADAMAGEOTHERSELF }, -- "You suffer %d %s damage from %s's %s."
		_PERIODICAURADAMAGESELFSELF =
			{ source=0, dest=0, amount=1, spell=3, damageType=2, crit=DM_DOT, pattern=PERIODICAURADAMAGESELFSELF }, -- "You suffer %d %s damage from your %s."
		-- pet
		_PERIODICAURADAMAGEOTHEROTHER =
			{ source=4, dest=1, amount=2, spell=5, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGEOTHEROTHER }, -- "%s suffers %d %s damage from %s's %s."

--HEALING
	-- "CHAT_MSG_SPELL_SELF_BUFF" "CHAT_MSG_SPELL_PARTY_BUFF" "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"
		_HEALEDSELFSELF =
			{ source=0, dest=0, amount=2, spell=1, crit=DM_HIT, pattern=HEALEDSELFSELF }, -- "Your %s heals you for %d.";
		_HEALEDCRITSELFSELF =
			{ source=0, dest=0, amount=2, spell=1, crit=DM_CRT, pattern=HEALEDCRITSELFSELF }, -- "Your %s critically heals you for %d.";
		_HEALEDSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, crit=DM_HIT, pattern=HEALEDSELFOTHER }, -- "Your %s heals %s for %d."
		-- missing some here, ie. HEALEDSELFSELF "Your %s heals you for %d."
		_HEALEDCRITSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, crit=DM_CRT, pattern=HEALEDCRITSELFOTHER }, -- "Your %s critically heals %s for %d.";
		__NIGHTDRAGONSBREATHOTHER =
			{ source=1, dest=2, amount=3, spell="Nachtdrachenodem", crit=DM_HIT, pattern="(.+)'s Nachtdrachenodem heilt (.+) um (%d+) Punkte.", custom=true }, -- "%s's Night Dragon's Breath heals %s for %d.";
		__NIGHTDRAGONSBREATHOTHERCRIT =
			{ source=1, dest=2, amount=3, spell="Nachtdrachenodem", crit=DM_CRT, pattern="(.+)'s Nachtdrachenodem heilt (.+) kritisch um (%d+) Punkte.", custom=true }, -- "%s's Night Dragon's Breath heals %s for %d.";
		_HEALEDOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, crit=DM_HIT, pattern=HEALEDOTHERSELF }, -- "%s's %s heals %s you %d.";
		_HEALEDCRITOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, crit=DM_CRT, pattern=HEALEDCRITOTHERSELF }, -- "%s's %s critically heals %s you %d.";
		_HEALEDOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, crit=DM_HIT, pattern=HEALEDOTHEROTHER }, -- "%s's %s heals %s for %d.";
		_HEALEDCRITOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, crit=DM_CRT, pattern=HEALEDCRITOTHEROTHER }, -- "%s's %s critically heals %s for %d.";

	--"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS" -- why?
		__JULIESBLESSINGOTHER =
			{ source=3, dest=1, amount=2, spell="Julies Segen", crit=DM_HIT, pattern="(.+) bekommt (%d+) Punkte durch (.+)'s Julies Segen%.", custom=true },

		_PERIODICAURAHEALOTHERSELF =
			{ source=2, dest=0, amount=1, spell=3, crit=DM_DOT, pattern=PERIODICAURAHEALOTHERSELF }, -- "You gain %d health from %s's %s."
		_PERIODICAURAHEALSELFSELF =
			{ source=0, dest=0, amount=1, spell=2, crit=DM_DOT, pattern=PERIODICAURAHEALSELFSELF }, -- "You gain %d health from %s."
		_PERIODICAURAHEALSELFOTHER =
			{ source=0, dest=1, amount=2, spell=3, crit=DM_DOT, pattern=PERIODICAURAHEALSELFOTHER }, -- "%s gains %d health from your %s."
		_PERIODICAURAHEALOTHEROTHER =
			{ source=3, dest=1, amount=2, spell=4, crit=DM_DOT, pattern=PERIODICAURAHEALOTHEROTHER }, -- "%s gains %d health from %s's %s."

--CURING
};

--[[ DamageMeters_eventCaseTable

This table defines which msgInfos are checked for which events.  Although its a bit of a pain
maintaining this big list there are several big reasons why we do so.  First and foremost, we
gain some information about the players involved in a message from the event type.  For example,
we can deduce that if the event was CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS and the message was of the
type "[Someone] hit [someone] for [amount] damage." that the entity being hit was not us but rather
a pet or totem of ours.  The second reason for this table is to greatly reduce the amount of patterns
each event is compared against.  The final reason is that sometimes the order of parsing is critical.

Here is an example:

HEALEDOTHEROTHER = "%s's %s heals %s for %d."
HEALEDCRITOTHEROTHER - "%s's %s critically heals %s for %d."

If we feed the following message into the above patterns, the
HEALEDOTHEROTHER will generate the following elements:

"Dandelion's Healing Touch critically heals Sterne for 1234."
->
"Dandelion", "Healing Touch critically", "Sterne", 1234

Hence, we must in this case test for HEALEDCRITOTHEROTHER before HEALEDOTHEROTHER.

]]--

DamageMeters_eventCaseTable = {
	[DM_MSGTYPE_DAMAGE] = {
		CHAT_MSG_COMBAT_SELF_HITS = {
            [1] = { n = "_COMBATHITCRITSELFOTHER" }, -- ok
            [2] = { n = "_COMBATHITSELFOTHER" }, -- ok
			[3] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_SELF", msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
			[4] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_SELF", msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
		},
		CHAT_MSG_SPELL_SELF_DAMAGE = {
			-- These two are for school-less "spells" like Heroic Strike.
			[1] = { n = "_SPELLLOGCRITSELFOTHER" }, -- ok
			[2] = { n = "_SPELLLOGSELFOTHER" }, -- ok
			-- These are for regular spells (ie. with Frost damage, etc).
			[3] = { n = "_SPELLLOGCRITSCHOOLSELFOTHER" }, -- ok
			[4] = { n = "_SPELLLOGSCHOOLSELFOTHER" }, -- ok
		},

		CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGESELFOTHER" }, -- ok (rend)
			[2] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},
		CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGESELFOTHER" },
			[2] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},

		CHAT_MSG_COMBAT_PARTY_HITS = {
			[1] = { n = "_COMBATHITCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[2] = { n = "_COMBATHITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER", sourceRelation=DamageMeters_Relation_PARTY },
			[4] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER", sourceRelation=DamageMeters_Relation_PARTY },
		},
		CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS = {
			[1] = { n = "_COMBATHITCRITOTHEROTHER" }, -- ok
			[2] = { n = "_COMBATHITOTHEROTHER" }, -- ok
			[3] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER", sourceRelation=DamageMeters_Relation_FRIENDLY }, -- ok
			[4] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER", sourceRelation=DamageMeters_Relation_FRIENDLY },
		},
		CHAT_MSG_COMBAT_PET_HITS = {
			[1] = { n = "_COMBATHITCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, --ok
			[2] = { n = "_COMBATHITOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
			[3] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER", destRelation=DamageMeters_Relation_PET, msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
			[4] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER", destRelation=DamageMeters_Relation_PET, msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
		},

		CHAT_MSG_SPELL_PARTY_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[2] = { n = "_SPELLLOGCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n = "_SPELLSPLITDAMAGEOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY },
			[4] = { n = "_SPELLLOGSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[5] = { n = "_SPELLLOGOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
		},
		CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER" }, -- ok
			[2] = { n = "_SPELLLOGCRITOTHEROTHER" }, -- ok
			[3] = { n = "_SPELLSPLITDAMAGEOTHEROTHER" },
			[4] = { n = "_SPELLLOGSCHOOLOTHEROTHER" }, -- ok
			[5] = { n = "_SPELLLOGOTHEROTHER" }, -- ok
		},
		CHAT_MSG_SPELL_PET_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
			[2] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PET },
			-- Totems do school damage.
			[3] = { n = "_SPELLLOGSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
			[4] = { n = "_SPELLSPLITDAMAGEOTHEROTHER", sourceRelation=DamageMeters_Relation_PET },
			[5] = { n = "_SPELLLOGOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
		},

		CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF = {
			[1] = { n = "_DAMAGESHIELDSELFOTHER" }, -- ok
		},
		CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS = {
			[1] = { n = "_DAMAGESHIELDOTHEROTHER" }, -- ok
			[2] = { n = "_SPELLSPLITDAMAGESELFOTHER" },
		},
	},

	[DM_MSGTYPE_DAMAGERECEIVED] = {
		CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS = {
			[1] = { n = "_COMBATHITCRITOTHERSELF" }, -- ok
			[2] = { n = "_COMBATHITCRITSCHOOLOTHERSELF" }, -- ok
			[3] = { n = "_COMBATHITSCHOOLOTHERSELF" }, -- ok
			[4] = { n = "_COMBATHITOTHERSELF" }, -- ok

			[5] = { n = "_COMBATHITCRITOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[6] = { n = "_COMBATHITOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
			[7] = { n = "_COMBATHITCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
			[8] = { n = "_COMBATHITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
		},
		CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS = {
			[1] = { n = "_COMBATHITCRITOTHEROTHER", destRelation=DamageMeters_Relation_PARTY },
			[2] = { n = "_COMBATHITOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n = "_COMBATHITCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY },
			[4] = { n = "_COMBATHITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
		},
		CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS = {
			[1] = { n = "_COMBATHITCRITOTHEROTHER" }, -- ok
			[2] = { n = "_COMBATHITOTHEROTHER" }, -- ok
			[3] = { n = "_COMBATHITCRITSCHOOLOTHEROTHER" },
			[4] = { n = "_COMBATHITSCHOOLOTHEROTHER" },
		},

		-- absorb messages.
		--CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES = {},
		--CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES = {},
		--CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES = {},

		CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHERSELF" }, --! test
			[2] = { n = "_SPELLLOGSCHOOLOTHERSELF" }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHERSELF" }, -- ok
			[4] = { n = "_SPELLLOGOTHERSELF" }, -- ok
			[5] = { n = "_SPELLRESISTOTHERSELF" }, -- ok

			[6] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[7] = { n = "_SPELLLOGSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
			[8] = { n = "_SPELLLOGCRITOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[9] = { n = "_SPELLLOGOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[10] = { n = "_SPELLRESISTOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
		},
		CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[2] = { n = "_SPELLLOGSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, --! hmm
			[4] = { n = "_SPELLLOGOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[5] = { n = "_SPELLRESISTOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
		},
		CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER" }, -- ok
			[2] = { n = "_SPELLLOGSCHOOLOTHEROTHER" }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHEROTHER" }, -- ok
			[4] = { n = "_SPELLLOGOTHEROTHER" }, -- ok
			[5] = { n = "_SPELLRESISTOTHEROTHER" }, -- ok
		},

		-- Unsure against what players this occurs for.  Happens vs. self and pets for sure.
		CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHERSELF" }, --ok
			[2] = { n = "_SPELLLOGSCHOOLOTHERSELF" }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHERSELF" }, -- ok
			[4] = { n = "_SPELLLOGOTHERSELF" }, -- ok
			[5] = { n = "_SPELLRESISTOTHERSELF" }, -- ok

			[6] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER" }, -- ok
			[7] = { n = "_SPELLLOGSCHOOLOTHEROTHER" }, -- ok
			[8] = { n = "_SPELLLOGCRITOTHEROTHER" }, -- ok
			[9] = { n = "_SPELLLOGOTHEROTHER" }, -- ok
			[10] = { n = "_SPELLRESISTOTHEROTHER" }, -- ok
		},

		CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGESELFSELF" }, --! hmm, would need to get a mob to reflect a dot onto me.
			[2] = { n = "_PERIODICAURADAMAGEOTHERSELF" }, -- ok
			[3] = { n = "_PERIODICAURADAMAGEOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
		},

		CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},
		CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},

		CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS = {
			[1] = { n = "_COMBATHITCRITOTHERSELF" }, -- ok
			[2] = { n = "_COMBATHITOTHERSELF" }, -- ok
			[3] = { n = "_COMBATHITCRITOTHEROTHER" }, -- ok
			[4] = { n = "_COMBATHITOTHEROTHER" }, -- ok (sometimes pets but we couldn't know)
			[5] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER" }, -- ok (this monitors the damage our enemys take in pvp.  we don't really care about this)
			[6] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER" },
		},
	},

-- Healing :
	[DM_MSGTYPE_HEALING] = {
		CHAT_MSG_SPELL_SELF_BUFF = {
			[1] = { n="_HEALEDCRITSELFSELF" }, -- ok
			[2] = { n="_HEALEDSELFSELF" },	-- ok
			[3] = { n="_HEALEDCRITSELFOTHER" }, --ok
			[4] = { n="_HEALEDSELFOTHER" }, -- ok

			--[5] = { n="_HEALEDOTHEROTHER" }, -- this might theoretically happen if there was a direct heal (non-hot) for a pet class, but i don't think there are any
			--[6] = { n="_HEALEDCRITOTHEROTHER" },
		},
		CHAT_MSG_SPELL_PARTY_BUFF = {
			[1] = { n="__NIGHTDRAGONSBREATHOTHERCRIT", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY },
			[2] = { n="__NIGHTDRAGONSBREATHOTHER", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY },
			[3] = { n="_HEALEDCRITOTHERSELF", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_SELF }, --! test, and shouldn't there be relations?
			[4] = { n="_HEALEDOTHERSELF", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_SELF }, --!
			[5] = { n="_HEALEDCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[6] = { n="_HEALEDOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
		},
		CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF = {
			[1] = { n="__NIGHTDRAGONSBREATHOTHERCRIT" }, -- ok
			[2] = { n="__NIGHTDRAGONSBREATHOTHER" },
			[3] = { n="_HEALEDCRITOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --! test, and shouldn't there be relations?
			[4] = { n="_HEALEDOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --!
			[5] = { n="_HEALEDCRITOTHEROTHER" }, -- ok
			[6] = { n="_HEALEDOTHEROTHER" }, -- ok
		},
		CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF = {
			[1] = { n="__NIGHTDRAGONSBREATHOTHERCRIT" },
			[2] = { n="__NIGHTDRAGONSBREATHOTHER" },
			[3] = { n="_HEALEDCRITOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --! test, and shouldn't there be relations?
			[4] = { n="_HEALEDOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --!
			[5] = { n="_HEALEDCRITOTHEROTHER" }, -- ok
			[6] = { n="_HEALEDOTHEROTHER" }, -- ok
		},

		-- guessing
		CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS = {
			[1] = { n="_PERIODICAURAHEALOTHERSELF" }, -- ok
			[2] = { n="_PERIODICAURAHEALSELFSELF" }, -- ok
			[3] = { n="_PERIODICAURAHEALSELFOTHER" }, -- ok (ie. Mend Pet)
		},
		-- guessing
		CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS = {
			[1] = { n="__JULIESBLESSINGOTHER", sourceRelation=DamageMeters_Relation_PARTY },
			[2] = { n="_PERIODICAURAHEALSELFOTHER", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n="_PERIODICAURAHEALOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY }, -- ok
		};
		-- guessing
		CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS = {
			[1] = { n="__JULIESBLESSINGOTHER" },
			[2] = { n="_PERIODICAURAHEALSELFOTHER" }, -- ok
			[3] = { n="_PERIODICAURAHEALOTHEROTHER" }, -- ok
		};
		-- guessing
		CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS = {
			[1] = { n="_PERIODICAURAHEALOTHERSELF" }, --!
			[2] = { n="_PERIODICAURAHEALSELFSELF" }, --!
			[3] = { n="_PERIODICAURAHEALSELFOTHER" }, --!
			[4] = { n="_PERIODICAURAHEALOTHEROTHER" }, --! ok, but irrelevant, i think
		};
	},
};

-------------------------------------------------------------------------------

--[[
I lifted this system from some other mod (can't remember which, maybe DPSPlus).
Basically, the DM_Spellometer_Patterns works a lot like my own system, but
the patterns are quite a bit more complicated in this case.  In English, the two
patterns represent all 4 of the following:

DISPELLEDOTHEROTHER = "%s wirkt %s auf %s.";
DISPELLEDOTHERSELF = "%s wirkt %s auf Euch.";
DISPELLEDSELFOTHER = "Ihr wirkt %s auf %s.";
DISPELLEDSELFSELF = "Ihr wirkt %s.";

]]--
DM_Spellometer_Patterns = {
   { pattern="^([^ ]+) wirkt (.*) auf (.*)%.$", caster=1, spell=2, target=3 },
   { pattern="^([^ ]+) wirkt (.*)%.$", caster = 1, spell=2, target=nil }
};

-- This list contains all of the "cure" spells we want to track.
DM_CURESPELLS = {
	"Magiebannung",
	"Fluch aufheben",
	"Geringen Fluch aufheben",
	"Vergiftung heilen",
	"Vergiftung aufheben",
	"Krankheit heilen",
	"Krankheit aufheben",
	"Reinigung des Glaubens",
	"L\195\164utern",
	"Totem der Giftreinigung",
	"Totem der Krankheitsreinigung",
	"Geist der Ahnen",
	"Wiedergeburt",
	"Erl\195\182sung",
	"Auferstehung",
	"Defibrillation",
};

end
-- if german version
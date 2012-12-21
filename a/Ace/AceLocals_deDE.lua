-- This translation was provided by Neriak.

function Ace_Locals_deDE()

-- All text inside quotes is translatable, except for 'method' lines.

SLASH_RELOAD1	= "/rl"
SLASH_RELOAD2	= "/reload"

ACE_NAME				= "Ace"
ACE_DESCRIPTION			= "AddOn Entwicklungs- und Management-Toolkit."
ACE_VERSION_MISMATCH	= "|cffff6060[Ace Versionsfehler]|r"

-- Various text strings
ACE_TEXT_COMMANDS			= "Befehle"
ACE_TEXT_ALL				= "alle"
ACE_TEXT_OF					= "von"
ACE_TEXT_AUTHOR				= "Autor"
ACE_TEXT_EMAIL				= "Email"
ACE_TEXT_RELEASED			= "ver\195\182ffentlicht"
ACE_TEXT_WEBSITE			= "Webseite"
ACE_TEXT_MEM_USAGE			= "Speichernutzung (MB)"
ACE_TEXT_TOTAL_ADDONS		= "Anzahl Addons"
ACE_TEXT_TOTAL_LOADED		= "Momentan geladene Addons"
ACE_TEXT_ACE_ADDONS_LOADED	= "Ace Addons geladen"
ACE_TEXT_ACE_REGISTERED		= "Ace Addons registriert"
ACE_TEXT_OTHERS_LOADED		= "Andere geladene Addons"
ACE_TEXT_NOT_LOADED			= "Nicht geladene Addons"
ACE_TEXT_LOADMSG			= "Lademeldungs-Typ"
ACE_TEXT_NOW_SET_TO			= "ge\195\164ndert auf"
ACE_TEXT_DEFAULT			= "default"

ACE_MAP_STANDBY				= {[0]="Aktiv.", [1]="Stand-By."}
ACE_MAP_LOADMSG				= {[0]="Zusammenfassung", addon="Addon", none="Keine"}

ACE_DISPLAY_OPTION			= "[|cfff5f530%s|r]"

-- Load message locals
ACE_LOAD_MSG_SUMMARY		= "|cffffff78Ace Addon Initialisierung beendet|r\n"..
							  "|cffffff78"..ACE_TEXT_ACE_REGISTERED..":|r %s\n"..
							  "|cffffff78Geladenes Profil:|r %s\n"..
							  "|cffffff78Bitte|r |cffd8c7ff/ace|r |cffffff78f\195\188r mehr Informationen eingeben|r"

-- Addon locals
ACE_ADDON_LOADED			= "|cffffff78%s v%s|r |cffffffffvon|r |cffd8c7ff%s|r |cffffffffist nun geladen.|r"
ACE_ADDON_CHAT_COMMAND		= "|cffffff78(%s)"
ACE_ADDON_STANDBY			= "|cffff5050(Ruhezustand)|r"

-- Addon Categories
ACE_CATEGORY_BARS			= "Interface-Leisten"
ACE_CATEGORY_CHAT			= "Chat/Kommunikation"
ACE_CATEGORY_CLASS			= "Klassen-Erweiterungen"
ACE_CATEGORY_COMBAT			= "Kampf/Zauber"
ACE_CATEGORY_COMPILATIONS	= "Zusammenstellung"
ACE_CATEGORY_INTERFACE		= "Interface-Erweiterungen"
ACE_CATEGORY_INVENTORY		= "Inventar/Gegenstands-Erweiterungen"
ACE_CATEGORY_MAP			= "Karten-Erweiterungen"
ACE_CATEGORY_OTHERS			= "Sonstige"
ACE_CATEGORY_PROFESSIONS	= "Berufe"
ACE_CATEGORY_QUESTS			= "Quest-Erweiterungen"
ACE_CATEGORY_RAID			= "Raid-Hilfe"

-- Profile locals
ACE_PROFILE_DEFAULT			= "default"
ACE_PROFILE_LOADED_CHAR		= "F\195\188r %s wurde ein individuelles Profil geladen."
ACE_PROFILE_LOADED_CLASS	= "F\195\188r %s wurde das %s Klassen-Profil geladen."
ACE_PROFILE_LOADED_DEFAULT	= "F\195\188r wurde das Default-Profil geladen."

-- Information locals
ACE_INFO_HEADER			  	= "|cffffff78Ace Information|r"
ACE_INFO_NUM_ADDONS			= "Addons geladen"
ACE_INFO_PROFILE_LOADED		= "Profile geladen"

-- Chat handler locals
ACE_COMMANDS				= {"/ace"}

ACE_CMD_OPT_HELP			= "?"
ACE_CMD_OPT_HELP_DESC		= "Zeigt Extra-Informationen \195\188ber dieses Addon an."
ACE_CMD_OPT_STANDBY			= "standby"
ACE_CMD_OPT_STANDBY_DESC	= "Schaltet zwischen Ruhe- und Aktiv-Modus des Addons um."
ACE_CMD_OPT_REPORT			= "report"
ACE_CMD_OPT_REPORT_DESC		= "Zeigt den Status s\195\164mtlicher Einstellungen an."
ACE_CMD_OPT_INVALID			= "'%s' ist eine ung\195\188ltige Option."
ACE_CMD_OPT_LIST_ADDONS		= "Addon List"
ACE_CMD_OPT_LOAD_IS_LOADED	= "%s ist bereits geladen."
ACE_CMD_OPT_LOAD_ERROR		= "%s konnte nicht geladen werden: %s."
ACE_CMD_OPT_LOAD_LOADED		= "%s wurde geladen."
ACE_CMD_OPT_AUTO_OFF_MSG	= "%s wird beim Spielstart nicht mehr nach Bedarf geladen."
ACE_CMD_ERROR				= "|cffff6060[Fehler]|r"

ACE_CMD_ADDON_NOTFOUND		= "Es wurde kein Addon mit dem Namen '%s' gefunden."
ACE_CMD_ADDON_ENABLED		= "%s wurde aktiviert. Bitte Spiel neu starten um das Addon zu laden."
ACE_CMD_ADDON_ENABLED_ALL	= "Alle Addons wurden aktiviert. Bitte Spiel neu starten um vorher "..
							  "ungeladene Addons zu laden."
ACE_CMD_ADDON_DISABLED		= "%s wurde deaktiviert, aber bleibt bis zum Neustart des Spiels geladen."
ACE_CMD_ADDON_DISABLED_ALL	= "Alle Addons ausser Ace selbst wurden deaktiviert, bleiben aber "..
							  "bis zum Neustart des Spiels geladen."

ACE_CMD_PROFILE_ADDON_ADDED	= "%s wurde hinzugef\195\188gt. Aktives Profil: %s."
ACE_CMD_PROFILE_ALL_ADDED	= "Es wurden alle Addons hinzugef\195\188gt. Aktives Profil: %s."
ACE_CMD_PROFILE_ALL			= "alle"
ACE_CMD_PROFILE_NO_PROFILE	= "F\195\188r %s sind keine profilbezogenen Optionen verf\195\188gbar."

ACE_CMD_USAGE_ADDON_DESC	= "|cffffff78[%s v%s]|r : %s"
ACE_CMD_USAGE_HEADER		= "|cffffff78Gebrauch:|r |cffd8c7ff%s|r %s"
ACE_CMD_USAGE_OPT_DESC		= " - |cffffff78%s:|r %s"
ACE_CMD_USAGE_OPT_SEP		= " | "
ACE_CMD_USAGE_OPT_OPEN		= "["
ACE_CMD_USAGE_OPT_CLOSE		= "]"
ACE_CMD_USAGE_OPTION		= "|cffd8c7ff%s %s|r %s"
ACE_CMD_USAGE_NOINFO		= "Keine weiteren Informationen."

ACE_CMD_RESULT				= "|cffffff78%s:|r %s"

ACE_CMD_REPORT_STATUS		= "Status"
ACE_CMD_REPORT_LINE			= " - %s [|cfff5f530%s|r]"
ACE_CMD_REPORT_LINE_PRE		= " - "
ACE_CMD_REPORT_LINE_INDENT	= "   "

ACE_CMD_REPORT_NO_VAL	  	= "|cffc7c7c7kein Wert|r"

ACE_CMD_OPTIONS			  	= {
	{
		option   = "enable",
		desc	 = "Aktiviert ein Addon.",
		method   = "EnableAddon"
	},
	{
		option   = "disable",
		desc	 = "Deaktiviert ein Addon.",
		method   = "DisableAddon"
	},
	{
		option   = "info",
		desc	 = "Zeigt Addon- und aktive Profil-Informationen an.",
		method   = "DisplayInfo"
	},
	{
		option   = "list",
		desc	 = "Zeigt alle aktuell geladenen Addons an. Optional kann f\195\188r Suche nachfolgend "..
				   "der Name eines Addons angegeben werden.",
		method   = "ListAddons",
		args	 = {
			{
				option	= "ace",
				desc	= "Zeige nur aktuell geladenen Ace Addons an.",
				method	= "ListAddonsAce"
		 	},
			{
				option	= "other",
				desc	= "Zeigt alle anderen Addons an.",
				method	= "ListAddonsOther"
			},
			{
				option	= "loadable",
				desc	= "Zeigt alle Addons an, die zum Laden verf\195\188gbar sind.",
				method	= "ListAddonsLoadable"
		 	}
	  	}
	},
	{
		option	= "load",
		desc	= "L\195\164dt ein Addon, das zur Zeit nicht geladen ist, aber f\195\188r das Laden nach Bedarf vorgesehen ist.",
		input	= 1,
		method	= "LoadAddon",
		args	= {
			{
				option	= "auto",
				desc	= "L\195\164dt ein Addon und vermerkt es automatisch f\195\188r das 'Laden nach Bedarf'.",
				method	= "LoadAddonAuto"
			},
			{
				option	= "off",
				desc	= "Schaltet das automatische 'Laden nach Bedarf' beim Spielstart aus.",
				method	= "LoadAddonOff"
			}
		}
   },
   {
		option   = "loadmsg",
		desc	 = "\195\132ndert die Darstellung der Lade-Meldungen beim Spielstart oder Neuladen.",
		args	 = {
			{
				option	= "addon",
				desc	= "Zeigt eine Lade-Meldung f\195\188r jedes Addon an.",
				method	= "ChangeLoadMsgAddon"
			},
			{
				option	= "none",
				desc	= "Zeigt keine Lade-Meldungen an.",
				method	= "ChangeLoadMsgNone"
			},
			{
				option	= "sum",
				desc	= "Zeigt eine kurze Zusammenfassung an.",
				method	= "ChangeLoadMsgSum"
			}
		},
	},
	{
		option	= "profile",
		desc	= "L\195\164dt eines der drei Profile: char, class, oder default. Falls das "..
				  "entsprechende Profil nicht existiert wird ein neues erstellt. Dein Charakter- "..
				  "und Klassen-Profil wird die Default-Einstellungen des Addons benutzen, bis Du "..
				  "es zuweist. Sobald ein Addon einem Profil zugewiesen wurde, werden alle "..
				  "Einstellungen die Du f\195\188r dieses Addon \195\164nderst, diesem "..
				  "speziellen Profil zugewiesen.",
		args	 = {
			{
				option	= "char",
				desc	= "L\195\164dt speziell f\195\188r diesen Charakter ein eigenes Profil. "..
						  "Gib 'all' oder einen bestimmten Addon-Namen ein um sie/es diesem "..
						  "Profil zuzuweisen.",
				method	= "UseProfileChar",
			},
			{
				option	= "class",
				desc	= "L\195\164dt speziell f\195\188r diese Charakter-Klasse ein eigens "..
						  "Profil. Gib 'all' oder einen bestimmten Addon-Namen ein um sie/es "..
						  "diesem Profil zuzuweisen.",
				method	= "UseProfileClass"
			},
			{
				option	= ACE_PROFILE_DEFAULT,
				desc	= "L\195\164dt das Default-Profil f\195\188r diesen Charakter. Dieses "..
						  "Profil wird automatisch von allen Addons genutzt.",
				method	= "UseProfileDefault"
			},
		},
	}
}

end

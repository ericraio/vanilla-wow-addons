-- Version : German (by pc, StarDust)
-- Last Update : 02/17/2005

if ( GetLocale() == "deDE" ) then

	-- UltimateUI Configuration
	ULTIMATEUI_CONFIG_QLOOT_HEADER		= "Schnelles Pl\195\188ndern";
	ULTIMATEUI_CONFIG_QLOOT_HEADER_INFO		= "Diese Einstellungen erm\195\188glichen die Anpassung von QuickLoot";
	ULTIMATEUI_CONFIG_QLOOT			= "Schnelles Pl\195\188ndern aktivieren";
	ULTIMATEUI_CONFIG_QLOOT_INFO		= "Wenn aktiviert, wandert der Mauszeiger sofort auf den ersten Gegenstand im Pl\195\188ndern-Fenster.";
	ULTIMATEUI_CONFIG_QLOOT_HIDE		= "Leere Pl\195\188ndern-Fenster automatisch schlie\195\159en";
	ULTIMATEUI_CONFIG_QLOOT_HIDE_INFO		= "Wenn aktiviert, wird beim Versuch einen leeren Kadaver zu pl\195\188ndern das Pl\195\188ndern-Fenster automatisch geschlossen.";
	ULTIMATEUI_CONFIG_QLOOT_ONSCREEN		= "Gesamten Loot anzeigen";
	ULTIMATEUI_CONFIG_QLOOT_ONSCREEN_INFO	= "Wenn aktiviert, wird das Pl\195\188ndern-Fenster dennoch ge\195\182ffnet wenn Geld zum Looten verf\195\188gbar ist.";

	ULTIMATEUI_CONFIG_QLOOT_MOVE_ONCE		= "Pl\195\188ndern-Fenster zum Mauszeiger bewegen";
	ULTIMATEUI_CONFIG_QLOOT_MOVE_ONCE_INFO	= "Wenn aktiviert, wird das Pl\195\188ndern-Fenster nur einmal zum Mauszeiger bewegt.";

	-- Chat Configuration
	QLOOT_LOADED				= "Schnelles Pl\195\188ndern geladen";
	ERR_LOOT_NONE				= "Es gab nichts zu pl\195\188ndern.";

	QUICKLOOT_CHAT_COMMAND_INFO		= "Konfiguriert Schnelles Pl\195\188ndern \195\188ber die Kommandozeile. Eingabe ohne Parameter zeigt eine Hilfe an.";
	QUICKLOOT_CHAT_COMMAND_USAGE		= "Benutzung: /quickloot <enable/autohide/onscreen/moveonce>\nJeder Parameter wechselt den jeweiligen Zustand.\nParameter:\n enable - aktivieren/deaktivieren von Schnelles Pl\195\188ndern\n autohide - gibt an ob Schnelles Pl\195\188ndern leere Pl\195\188ndern-Fenster automatisch schlie\195\159en soll\n onscree - gibt an ob das Pl\195\188ndern-Fenster am Bildschirm halten soll";
	QUICKLOOT_CHAT_COMMAND_ENABLE		= ULTIMATEUI_CONFIG_QLOOT_HEADER;
	QUICKLOOT_CHAT_COMMAND_HIDE		= ULTIMATEUI_CONFIG_QLOOT_HEADER.." verstecken";
	QUICKLOOT_CHAT_COMMAND_ONSCREEN		= ULTIMATEUI_CONFIG_QLOOT_HEADER.." am Bildschirm halten";
	QUICKLOOT_CHAT_COMMAND_MOVE_ONCE	= ULTIMATEUI_CONFIG_QLOOT_HEADER.." einmal bewegen";

	QUICKLOOT_CHAT_STATE_ENABLED		= " aktiviert";
	QUICKLOOT_CHAT_STATE_DISABLED		= " deaktiviert";

end
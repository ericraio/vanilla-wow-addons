-- Version : German (by DrVanGogh, StarDust)
-- Last Update : 12/05/2005

if ( GetLocale() == "deDE" ) then
	
	TELLTRACK_MENU_WIDTH 			= 120;
	
	--Binding Configuration
	BINDING_HEADER_TELLTRACKHEADER		= "Laberbox";
	BINDING_NAME_TELLTRACK			= "Laberbox ein-/ausschalten";
	BINDING_NAME_TELLTRACK1			= "Nachricht an 1. Slot senden";
	BINDING_NAME_TELLTRACK2			= "Nachricht an 2. Slot senden";
	BINDING_NAME_TELLTRACK3			= "Nachricht an 3. Slot senden";
	BINDING_NAME_TELLTRACK4			= "Nachricht an 4. Slot senden";
	BINDING_NAME_TELLTRACK_RETELL		= "Nachricht an letzten Empf. senden";

	-- Cosmos Configuration
	TELLTRACK_CONFIG_HEADER			= "Laberbox";
	TELLTRACK_CONFIG_HEADER_INFO		= "Enth\195\164lt Einstellungen f\195\188r die Laberbox, ein AddOn das es einfacher macht mit mehreren Leuten gleichzeitig zu kommunizieren. Das Fragezeichen in der Ecke f\195\188r mehr Informationen anklicken.";
    
	TELLTRACK_BORDER_CONFIG_HEADER		= "Laberbox Rahmen";

	TELLTRACK_ENABLED			= "Laberbox aktivieren";
	TELLTRACK_ENABLED_INFO			= "Aktiviert die Laberbox und zeigt das dazugeh\195\182rige Fenster an.";
    
	TELLTRACK_INVERTED			= "Kontakliste umkehren";
	TELLTRACK_INVERTED_INFO			= "Kehrt die Kontaktliste der Laberbox um und zeigt die Namen in umgekehrter Reihenfolge.";

	TELLTRACK_DONTSAVELIST			= "Kontaktliste nicht speichern";
	TELLTRACK_DONTSAVELIST_INFO		= "L\195\182scht die Kontakliste beim Beenden der Spielsession.";

	TELLTRACK_AUTOWHISPERFRAME		= "Fl\195\188stern-Chatfenster automatisch erstellen";
	TELLTRACK_AUTOWHISPERFRAME_INFO		= "Wenn kein eigenes Fl\195\188stern-Chatfenster existiert wird jenes automatisch angelegt um alle Fl\195\188stern-Nachrichten darin anzuzeigen.";

	TELLTRACK_HIDEOTHERWHISPERS		= "Fl\195\188stern-Nachrichten nur im Fl\195\188stern-Chatfenster anzeigen";
	TELLTRACK_HIDEOTHERWHISPERS_INFO	= "Wenn aktiviert, werden alle Fl\195\188stern-Nachrichten in allen anderen Chatfenstern ausgeblendet und nur im Fl\195\188stern-Chatfenster angezeigt.";

	TELLTRACK_TIMESTAMPS			= "Fl\195\188stern-Nachrichten mit Zeitstempel versehen";
	TELLTRACK_TIMESTAMPS_INFO		= "Wenn aktiviert, wird vor jeder Nachricht im Fl\195\188stern-Chatfestern die jeweilige Uhrzeit angezeigt.";

	TELLTRACK_WHISPERFIRST			= "BeiKlick: Zuerst anfl\195\188stern";
	TELLTRACK_WHISPERFIRST_INFO		= "Wenn aktiviert, wird beim ersten Anklicken des Namens eine Fl\195\188ster-Nachricht gestartet, beim zweiten Klick wird das Chat-Log angezeigt.";

	-- Chat Configuration
	TELLTRACK_CHAT_ENABLED			= "Laberbox aktiviert.\nDas Laberbox Hilfe-Icon oben rechts anklicken um mehr Informationen zu erhalten.";
	TELLTRACK_CHAT_DISABLED			= "Laberbox deaktiviert.";

	TELLTRACK_CHAT_INVERTED			= "Kontaktliste umgekehrt.";
	TELLTRACK_CHAT_NORMALIZED		= "Kontaktliste der Laberbox wieder normal sortiert.";

	TELLTRACK_CHAT_DONTSAVELIST		= "Kontaktliste der Laberbock wird zwischen den Spielsessions speichern.";
	TELLTRACK_CHAT_SAVELIST			= "Kontaktliste der Laberbock wird zwischen den Spielsessions nicht speichern.";

	TELLTRACK_CHAT_AUTOWHISPERFRAME		= "Das Fl\195\188stern-Chatfenster wird bei Bedarf automatisch erstellt.";
	TELLTRACK_CHAT_MANUALWHISPERFRAME	= "Das Fl\195\188stern-Chatfenster muss bei Bedarf manuell erstellt werden.";

	TELLTRACK_CHAT_HIDEOTHERWHISPERS	= "Fl\195\188stern-Nachrichten werden nur im Fl\195\188stern-Chatfenster anzeigen (sofern jenes vorhanden ist) und in allen anderen Chatfenstern ausgeblendet."
	TELLTRACK_CHAT_SHOWOTHERWHISPERS	= "Fl\195\188stern-Nachrichten werden in allen Chatfenstern angezeigt.";

	TELLTRACK_CHAT_TIMESTAMPS		= "Fl\195\188stern-Nachrichten werden im Fl\195\188stern-Chatfenster mit einem Zeitstempel versehen.";
	TELLTRACK_CHAT_NOTIMESTAMPS		= "Fl\195\188stern-Nachrichten werden mit keinem Zeitstempel versehen.";
    
	TELLTRACK_CHAT_WHISPERFIRST		= "Laberbox BeiKlick gesetzt auf: zuerst Fl\195\188stern-Nachricht.";
	TELLTRACK_CHAT_LOGFIRST			= "Laberbox BeiKlick gesetzt auf: zuerst Caht-Log.";
	
	TELLTRACK_CHAT_COMMAND_INFO			= "Einstellungen der Laberbox anzeigen.";
	TELLTRACK_CHAT_COMMAND_ENABLE_INFO		= "Laberbox aktivieren/deaktivieren.";
	TELLTRACK_CHAT_COMMAND_CLEARALL_INFO		= "Alle Eintr\195\164ge der Laberbox l\195\182schen.";
	TELLTRACK_CHAT_COMMAND_INVERT_INFO		= "Kontakliste der Laberbox umkehren/normal sortieren.";
	TELLTRACK_CHAT_COMMAND_DONTSAVELIST_INFO	= "Kontakliste der Laberbox nach Ende der Spielsession l\195\182schen.";
	TELLTRACK_CHAT_COMMAND_AUTOWHISPERFRAME_INFO	= "Fl\195\188stern-Chatfenster automatisch erstellen.";
	TELLTRACK_CHAT_COMMAND_HIDEOTHERWHISPERS_INFO	= "Fl\195\188stern-Nachrichten in allen Chatfenstern abgesehn vom Fl\195\188stern-Chatfenster verbergen.";
	TELLTRACK_CHAT_COMMAND_TIMESTAMPS_INFO		= "Fl\195\188stern-Nachrichten mit Zeitstempel versehen.";
	TELLTRACK_CHAT_COMMAND_WHISPERFIRST_INFO	= "Der erste Klick auf den Namen startet eine Fl\195\188stern-Nachricht, der zweite zeigt das Chat-Log an.";

	TELLTRACK_CHAT_QUESTION_MARK_INFO	= "Laberbox (von AnduinLothar, sarf und Lash)\n\nLinke Maustaste auf Slot: Nachricht schicken\nRechte Maustaste auf Slot: Slot l\195\182schen\nMausrad: Scrollt einen Slot nach dem anderen durch (max. 20)\nLinke Maustaste auf Pfeile: Scrollt Slots seitenweise durch (max. 20)\nRechte Maustaste auf Pfeile: Springe zum ersten/letzten Slot..\n'\\telltrack' um das Fenster mit Optionen anzuzeigen.";
	TELLTRACK_CHAT_USE_INFO			= "Benutzung: '/telltrack <Befehl> [on/off/1/0]'";

	-- Interface Configuration
	TELLTRACK_QUESTION_MARK_TOOLTIP		= "Hier klicken um weitere \nInformationen anzuzeigen."
	TELLTRACK_RESIZE_TOOLTIP		= "Hierklicken und ziehen um Gr\195\182\195\159e zu \195\164ndern."
	TELLTRACK_WHISPER			= "Fl\195\188stern";
	TELLTRACK_SHOW_CONVERSATION		= "Unterhaltung anzeigen";
	TELLTRACK_WHO				= "Wer";
	TELLTRACK_GRPINV			= "Gruppeneinladung";
	TELLTRACK_ADDFRIEND			= "Freund hinzuf\195\188gen";
	TELLTRACK_DELETE			= "L\195\182schen"
	TELLTRACK_DELETE_ALL			= "Alle L\195\182schen"
	TELLTRACK_INVERT			= "Liste Umkehren"
	TELLTRACK_SHOW_ALL_WHISPERS		= "Alle Fl\195\188stern-Nachrichten anzeigen"
	TELLTRACK_CREATE_CHATFRAME		= "Fl\195\188stern-Chatfenster erstellen"
	TELLTRACK_CANCEL			= "Abbrechen";

	TELLTRACK_WHISPER_FRAME_TITLE		= "Laberbox";

	TELLTRACK_NO_CURRENT_CONVERSATION	= "-- Momentan keine Unterhaltung mit %s --";

	-- Cosmos AddOn Mod Configuration
	TELLTRACK_CONFIG_TRANSNUI		= "Laberbox";
	TELLTRACK_CONFIG_TRANSNUI_INFO		= "Ver\195\164ndert die Sichtbarkeit des Laberbox Fensters.";
    
	TELLTRACK_CONFIG_POPNUI			= "Laberbox";
	TELLTRACK_CONFIG_POPNUI_INFO		= "Wenn aktiviert, wird das Laberbox Fenster nur angezeigt wenn man den Muszeiger \195\188ber jenes bewegt.";

end
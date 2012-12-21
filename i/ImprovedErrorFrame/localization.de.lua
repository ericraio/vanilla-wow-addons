-- Version : English (by DrVanGogh, StarDust)
-- Last Update : 07/11/2005

if ( GetLocale() == "deDE" ) then

	-- Interface Configuration
	IEF_FILE		= "Datei:";
	IEF_STRING		= "Zeichenkette:";
	IEF_LINE		= "Zeile:";
	IEF_COUNT		= "Nummer:";
	IEF_ERROR		= "Fehler:";

	IEF_CANCEL		= "Abbrechen";
	IEF_CLOSE		= "Schlie\195\159en";
	IEF_REPORT		= "Melden";

	IEF_INFINITE		= "Unendlich";

	-- Slash command strings
	IEF_NOTIFY_ON		= "ErweitertesFehlerFenster: Fehler werden zur sp\195\164teren Anzeige gespeichert.";
	IEF_NOTIFY_OFF		= "ErweitertesFehlerFenster: Fehler werden angezeigt sobald jene auftreten.";
	IEF_BLINK_ON		= "ErweitertesFehlerFenster: Fehlerbutton blinkt bei neuem Fehler.";
	IEF_BLINK_OFF		= "ErweitertesFehlerFenster: Fehlerbutton blinkt nicht bei neuem Fehler.";
	IEF_COUNT_ON		= "ErweitertesFehlerFenster: Anzahl der Fehler wird angezeigt.";
	IEF_COUNT_OFF		= "ErweitertesFehlerFenster: Anzahl der Fehler wird nicht angezeigt.";
	IEF_ALWAYS_ON		= "ErweitertesFehlerFenster: Fehlerbutton wird immer angezeigt.";
	IEF_ALWAYS_OFF		= "ErweitertesFehlerFenster: Button wird bei Benachrichtigung angezeigt.";
	IEF_SOUND_ON		= "ErweitertesFehlerFenster: Sound wird bei Benachrichtigung abgespielt.";
	IEF_SOUND_OFF		= "ErweitertesFehlerFenster: Es wird kein Sound bei Benachrichtigung abgespielt.";
	IEF_EMPTY_ON		= "ErweitertesFehlerFenster: Buttongrafik verschwindet wenn blinkend.";
	IEF_EMPTY_OFF		= "ErweitertesFehlerFenster: Buttongrafik bleibt wenn blinkend.";
	IEF_DEBUG_ON		= "ErweitertesFehlerFenster: FrameXML genaue Protokollierung ein.";
	IEF_DEBUG_OFF		= "ErweitertesFehlerFenster: FrameXML genaue Protokollierung aus.";
	IEF_FORMAT_STR		= "Benutzung: /ief <MELDEN|BLINKEN|ANZAHL|IMMER|SOUND> <EIN|AUS>";
	IEF_FORMAT_STR_NOCHRON	= "Benutzung: /ief <MELDEN|ANZAHL|IMMER|SOUND> <EIN|AUS>";
	IEF_CURRENT_SETTINGS	= "Momentane Einstellungen:";
	IEF_BLINK_OPT		= "blinken";
	IEF_NOTIFY_OPT		= "melden";
	IEF_COUNT_OPT		= "anzahl";
	IEF_ALWAYS_OPT		= "immer";
	IEF_SOUND_OPT		= "sound";
	IEF_EMPTY_OPT		= "leer";
	IEF_DEBUG_OPT		= "debug";
	IEF_ON			= "ein";
	IEF_OFF			= "aus";
	IEF_HELP_TEXT		= "/ief - Einstellungen des Erweiterten Fehlerfensters";

	-- Tooltip Text
	IEF_TOOLTIP		= "Klicken um Fehler anzuzeigen.";

	-- Header Text
	IEF_TITLE_TEXT		= "Gespeicherte Fehler";
	IEF_ERROR_TEXT		= "Echtzeit Fehler";

	-- Khaos/Cosmos descriptions
	IEF_OPTION_TEXT		= "Erweitertes Fehlerfenster";
	IEF_OPTION_HELP		= "Erlaubt es die Art der Fehlerberichterstattung zu ver\195\164ndern.";
	IEF_HEADER_TEXT		= "Erweitertes Fehlerfenster";
	IEF_HEADER_HELP		= "Unterschiedliche Einstellungen um die Fehlerberichterstattung an deine Bed\195\188rfnisse anzupassen.";
	IEF_NOTIFY_TEXT		= "Fehler in Liste speichern";
	IEF_NOTIFY_HELP		= "Wenn aktiviert, werden auftretende Fehler in einer Liste gespeichert um sp\195\164ter angezeigt zu werden.";
	IEF_BLINK_TEXT		= "Button blinkend";
	IEF_BLINK_HELP		= "Wenn aktiviert, blinkt der Button sobald neue Fehler gespeichert wurden.";
	IEF_COUNT_TEXT		= "Anzahl der Fehler im Button anzeigen";
	IEF_COUNT_HELP		= "Wenn aktiviert, wird die Anzahl der gespeicherten Fehler im Button als Zahl angezeigt.";
	IEF_ALWAYS_TEXT		= "Fehlerbutton immer anzeigen";
	IEF_ALWAYS_HELP		= "Wenn aktiviert, wird der Fehlerbutton immer angezeigt auch wenn keine Fehler aufgetreten sind.";
	IEF_SOUND_TEXT		= "Sound bei Fehler abspielen";
	IEF_SOUND_HELP		= "Wenn aktiviert, wird ein Sound abgespielt sobald ein neuer Fehler auftritt.";
	IEF_EMPTY_TEXT		= "Buttongrafik bei Fehler ausblenden";
	IEF_EMPTY_HELP		= "Wenn aktiviert, wird die Buttongrafik ausgeblendet wenn jener blinkt.";
	IEF_DEBUG_TEXT		= "Genaue FrameXML Fehlerprotokollierung";
	IEF_DEBUG_HELP		= "Wenn aktiviert, wird FrameXML.log in der erweiterten Protokollierung ausgelagert. (Erfordert neuladen des UI)";

end
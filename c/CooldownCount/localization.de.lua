-- Version : German (by StarDust)
-- Last Update : 06/06/2005

if ( GetLocale() == "deDE" ) then
    
	BINDING_HEADER_COOLDOWNCOUNTHEADER			= "Abklingzeit Z\195\164hler";
	BINDING_NAME_COOLDOWNCOUNT				= "Abklingzeit anzeigen/verbergen";

	COOLDOWNCOUNT_CONFIG_HEADER				= "Abklingzeit Z\195\164hler";
	COOLDOWNCOUNT_CONFIG_HEADER_INFO			= "Erlaubt es den Abklingzeit Z\195\164hler zu konfigurueren, ein AddOn welches die noch verbleibende Abklingzeit auf den Buttons in den Aktionsleisten anzeigt.";

	COOLDOWNCOUNT_ENABLED					= "Abklingzeit Z\195\164hler aktivieren";
	COOLDOWNCOUNT_ENABLED_INFO				= "Aktiviert den Abklingzeit Z\195\164hler, welcher die noch verbleibende Abklingzeit auf den Aktionen anzeigt.";

	COOLDOWNCOUNT_NOSPACES					= "Abstand zwischen Zeit und Zeiteinheit entfernen";
	COOLDOWNCOUNT_NOSPACES_INFO				= "Wenn aktiviert, wird der Abstand zwischen der Zeit selbst und der Zeiteinheit entfernen, wodurch dann zum Beispiel \"19 m\" als \"19m\" angezeigt wird.";

	COOLDOWNCOUNT_SIDECOUNT					= "Seitenleisten Versatz verwenden";
	COOLDOWNCOUNT_SIDECOUNT_INFO				= "Wenn aktiviert, wird der Abklingzeit Z\195\164hler auf den Seitenleisten weiter in die Mitte des Bildschirms versetzt.";

	COOLDOWNCOUNT_FLASHSPEED				= "Blinkgeschwindigkeit";
	COOLDOWNCOUNT_FLASHSPEED_INFO				= "Legt die Zeit zwischen jedem Blinken fest, wenn die Abklingzeit schon fast ausgelaufen ist.";

	COOLDOWNCOUNT_FLASHSPEED_SLIDER_DESCRIPTION		= "Dauer";
	COOLDOWNCOUNT_FLASHSPEED_SLIDER_APPEND			= " Sek.";

	COOLDOWNCOUNT_HIDEUNTILTIMELEFT				= "Z\195\164hler bis ... verbergen";
	COOLDOWNCOUNT_HIDEUNTILTIMELEFT_INFO			= "Legt fest, ab wann die Abklingzeit Z\195\164hler angezeigt werden sollen (0 = immer sichtbar).";

	COOLDOWNCOUNT_HIDEUNTILTIMELEFT_SLIDER_DESCRIPTION	= "Dauer";
	COOLDOWNCOUNT_HIDEUNTILTIMELEFT_SLIDER_APPEND		= " Sek.";

	COOLDOWNCOUNT_HOURS_FORMAT				= "%s S";
	COOLDOWNCOUNT_MINUTES_FORMAT				= "%s M";

	COOLDOWNCOUNT_HOUR_MINUTES_FORMAT			= "%s:%s";
	COOLDOWNCOUNT_MINUTES_SECONDS_FORMAT			= "%s:%s";
	COOLDOWNCOUNT_SECONDS_FORMAT				= "%s";

	COOLDOWNCOUNT_SECONDS_LONG_FORMAT			= "%s S";

	COOLDOWNCOUNT_USERSCALE					= "Skalierung";
	COOLDOWNCOUNT_USERSCALE_INFO				= "Legt die Skalierung der Ziffern des Abklingzeit Z\195\164hlers fest. Achtung, es k\195\182nnen seltsame Ergebnisse auftreten. Standard ist 100 Prozent.";
	COOLDOWNCOUNT_USERSCALE_SLIDER_DESCRIPTION		= "Skalierung";
	COOLDOWNCOUNT_USERSCALE_SLIDER_APPEND			= " Proz.";

	COOLDOWNCOUNT_USELONGTIMERS				= "Lange Bezeichnung der Zeit benutzen.";
	COOLDOWNCOUNT_USELONGTIMERS_INFO			= "Wennaktiviert, wird die lange Bezeichnung der Abklingzeit erzwungen.";

	COOLDOWNCOUNT_NORMALCOLOR_SET				= "Farbe des Textes";
	COOLDOWNCOUNT_NORMALCOLOR_SET_INFO			= "Legt die Textfarbe des normalen Z\195\164hlers fest.";

	COOLDOWNCOUNT_FLASHCOLOR_SET				= "Farbe des blinkenden Textes";
	COOLDOWNCOUNT_FLASHCOLOR_SET_INFO			= "Legt die Textfarbe des blinkenden Z\195\164hlers fest.";
	COOLDOWNCOUNT_SETTEXT					= "Ausw\195\164hlen";

	COOLDOWNCOUNT_ALPHA					= "Sichtbarkeit";
	COOLDOWNCOUNT_ALPHA_INFO				= "Legt die Sichtbarkeit des Z\195\164hlers fest.";

	COOLDOWNCOUNT_ALPHA_SLIDER_DESCRIPTION			= "Alpha";
	COOLDOWNCOUNT_ALPHA_SLIDER_APPEND			= " Proz.";

	-- Slash Commands
	COOLDOWNCOUNT_SLASH_ENABLE				= "aktiviert";
	COOLDOWNCOUNT_SLASH_DISABLE				= "deaktiviert";
	COOLDOWNCOUNT_SLASH_SET					= "setzen";
	COOLDOWNCOUNT_SLASH_FLASHSPEED				= "blinken";
	COOLDOWNCOUNT_SLASH_SCALE				= "skalierung";
	COOLDOWNCOUNT_SLASH_ALPHA				= "alpha";
	COOLDOWNCOUNT_SLASH_NOSPACES				= "zwischenraum";
	COOLDOWNCOUNT_SLASH_NORMALCOLOR				= "standardfarbe";
	COOLDOWNCOUNT_SLASH_FLASHCOLOR				= "blinkfarbe";
	COOLDOWNCOUNT_SLASH_USELONGTIMERS			= "langezeitverwenden";
	COOLDOWNCOUNT_SLASH_HIDEUNTILTIMELEFT			= "verbergenbis";

	COOLDOWNCOUNT_PARAM_ON					= "ein";
	COOLDOWNCOUNT_PARAM_OFF					= "aus";
	COOLDOWNCOUNT_PARAM_TOGGLE				= "wechseln";

	COOLDOWNCOUNT_SLASH_USAGE 				= {
		" Benutzung: /cooldowncount (oder /cc) <Befehl> [Parameter]",
		"",
		" Befehle:",
		COOLDOWNCOUNT_SLASH_ENABLE.." - aktiviert den Abklingzeit Z\195\164hler",
		COOLDOWNCOUNT_SLASH_DISABLE.." - deaktiviert den Abklingzeit Z\195\164hler",
		COOLDOWNCOUNT_SLASH_SET.." - aktiviert/deaktiviert den Abklingzeit Z\195\164hler",
		COOLDOWNCOUNT_SLASH_FLASHSPEED.." - legt die Blinkgeschwindigkeit fest",
		COOLDOWNCOUNT_SLASH_SCALE.." - legt die Skalierung fest",
		COOLDOWNCOUNT_SLASH_ALPHA.." - legt den Alphawert fest",
		COOLDOWNCOUNT_SLASH_NOSPACES.." - legt den Abstand fest (ob zwischen Nummer und Einheit ein Abstand angezeigt werden soll)",
		COOLDOWNCOUNT_SLASH_NORMALCOLOR.." - legt die Standardfarbe des Z\195\164hlers fest",
		COOLDOWNCOUNT_SLASH_FLASHCOLOR.." - legt die Blinkfarbe des Z\195\164hlers fest",
		COOLDOWNCOUNT_SLASH_HIDEUNTILTIMELEFT.." - verbergen bis angegebene Abklingzeit erreicht, 0 deaktiviert",
		--COOLDOWNCOUNT_SLASH_USELONGTIMERS.." - legt die lange Beschriftung des Z\195\164hlers fest"
	};

	COOLDOWNCOUNT_CHAT_ALPHA_NOT_SPECIFIED			= "Abklingzeit Z\195\164hler: Alpha muss als Zahl angegeben werden.";

	COOLDOWNCOUNT_CHAT_USERSCALE				= "Abklingzeit Z\195\164hler: Skalierung der Ziffern festgelegt auf %s.";
	COOLDOWNCOUNT_CHAT_USERSCALE_NOT_SPECIFIED		= "Abklingzeit Z\195\164hler: Skalierung muss als Zahl angegeben werden.";

	COOLDOWNCOUNT_CHAT_USELONGTIMERS_ENABLED		= "Abklingzeit Z\195\164hler: Lange Bezeichnung der Zeit aktiviert.";
	COOLDOWNCOUNT_CHAT_USELONGTIMERS_DISABLED		= "Abklingzeit Z\195\164hler: Lange Bezeichnung der Zeit deaktiviert.";

	COOLDOWNCOUNT_CHAT_ENABLED				= "Abklingzeit Z\195\164hler: aktiviert.";
	COOLDOWNCOUNT_CHAT_DISABLED				= "Abklingzeit Z\195\164hler: deaktiviert.";
	COOLDOWNCOUNT_CHAT_NOSPACES_ENABLED			= "Abklingzeit Z\195\164hler: kein Abstand aktiviert.";
	COOLDOWNCOUNT_CHAT_NOSPACES_DISABLED			= "Abklingzeit Z\195\164hler: kein Abstand deaktiviert.";
	COOLDOWNCOUNT_CHAT_FLASHSPEED				= "Abklingzeit Z\195\164hler: Blinkgeschwindigkeit gesetzt auf %s.";

	COOLDOWNCOUNT_CHAT_COMMAND_MAIN_INFO			= "Legt Einstellungen f\195\188r den Abklingzeit Z\195\164hler fest.";
	COOLDOWNCOUNT_CHAT_COMMAND_ENABLE_INFO			= "Abklingzeit Z\195\164hler aktivieren/deaktivieren.";
	COOLDOWNCOUNT_CHAT_COMMAND_SIDECOUNT_ENABLE_INFO	= "Seitenleisten Versatz des Abklingzeit Z\195\164hlers aktivieren/deaktivieren.";
	COOLDOWNCOUNT_CHAT_COMMAND_FLASHSPEED_INFO		= "Legt die Zeit (in Sekunden) zwischen jedem Blinken fest, wenn die Abklingzeit schon fast ausgelaufen ist.";
	COOLDOWNCOUNT_CHAT_COMMAND_SCALE_INFO			= "Legt die Skalierung der Ziffern des Abklingzeit Z\195\164hlers fest.";

	COOLDOWNCOUNT_CHAT_ALPHA_FORMAT				= "Abklingzeit Z\195\164hler: Alpha gesetzt auf %2f";
	COOLDOWNCOUNT_CHAT_NORMAL_COLOR_SET			= "Abklingzeit Z\195\164hler: Normale Textfarbe des Z\195\164hlers festgelegt.";
	COOLDOWNCOUNT_CHAT_FLASH_COLOR_SET			= "Abklingzeit Z\195\164hler: Blinkende Textfarbe des Z\195\164hlers festgelegt.";

	COOLDOWNCOUNT_CHAT_HIDEUNTILTIMELEFT			= "Abklingzeit Z\195\164hler: Verbergen bis verbleibende Zeit festgelegt auf %d.";
	COOLDOWNCOUNT_CHAT_HIDEUNTILTIMELEFT_NOT_SPECIFIED	= "Abklingzeit Z\195\164hler: Verbergen bis verbleibende Zeit muss als Zahl angegeben werden.";

	-- Classes
	COOLDOWNCOUNT_CLASS_ROGUE				= "Schurke";

end
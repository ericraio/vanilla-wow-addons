-- Version : German (by DrVanGogh, StarDust)
-- Last Update : 02/17/2005

if ( GetLocale() == "deDE" ) then

	-- Cosmos Configuration
	COMBATSTATS_CONFIG_HEADER		= "Kampfstatistik";
	COMBATSTATS_CONFIG_HEADER_INFO		= "Zeigt eine Kampfstatistik im oberen Bereich des Bildschirms an.";
	COMBATSTATS_CONFIG_ONOFF		= "Kampfstatistik ein-/ausschalten";
	COMBATSTATS_CONFIG_ONOFF_INFO		= "Wenn aktiviert, wird die Kampfstatistik im oberen Bereich des Bildschirms angezeigt.";
	COMBATSTATS_CHAT_COMMAND_INFO		= "Speichert Kampfstatistiken und generiert Daten.";
	COMBATSTATS_CONFIG_HIDEONNOTARGET	= "Ausblenden wenn kein Ziel ausgew\195\164hlt ist";
	COMBATSTATS_CONFIG_HIDEONNOTARGET_INFO	= "Wenn aktiviert, wird das Fenster mit der Kampfstatistik nur angezeigt falls ein Ziel angew\195\164hlt ist.";
	COMBATSTATS_CONFIG_USEMOUSEOVER		= "Anzeigen bei Mouseover";
	COMBATSTATS_CONFIG_USEMOUSEOVER_INFO	= "Wenn aktiviert, wird das Fenster mit der Kampfstatistik angezeigt, wenn der Mauszeiger \195\188ber den Titel bewegt wird. Anderenfalls wird die Kampfstatistik bei einem Klick auf den Titel angezeigt.";
	COMBATSTATS_CONFIG_ENDOFFIGHT		= "Kampfstatistiken nach einem Kampf anzeigen";
	COMBATSTATS_CONFIG_ENDOFFIGHT_INFO	= "Wenn aktiviert, weden nach Ende eines Kampfes DPS/Schaden Statistiken angezeigt.";

	COMBATSTATS_CONFIG_DPS_LENGTH		= "DPS Zeitbasis f\195\188r Durchschnitt";
	COMBATSTATS_CONFIG_DPS_LENGTH_INFO	= "Dies gibt an, wieviele vorherigen Sekunden zur Berechnung des Durchschnitts-DPS herangezogen werden. (-1 f\195\188r die gesamte Sitzung)";
	COMBATSTATS_CONFIG_DPS_LENGTH_TEXT	= "Dauer";
	COMBATSTATS_CONFIG_DPS_LENGTH_APPEND	= " Sek.";

	-- Chat Configuration
	COMBSTATS_CHAT_COMMAND_RESET		= "Gesammelte Daten der Kampfstatistik zur\195\188cksetzen";
	CS_CHAT_COMMAND_INFO			= "/cs oder /combatstats eingeben, um eine Hilfe angezeigt zu bekommen.";

	-- Interface Configuration
	DPS_DISPLAY				= "DPS Gesamt :: %.2f";
	DPS_DISPLAY_INITIAL			= "DPS Gesamt :: ---";
	CS_FRAME_GEN_ATTACK_NAME		= "Angriffsart:";
	CS_FRAME_TICKS_TEXT			= "DOT Ticks.";
	CS_FRAME_HITS_TEXT			= "Treffer v.";
	CS_FRAME_SWINGS_TEXT			= "Schl\195\164ge:";
	CS_FRAME_MISSES_TEXT			= "Verfehlt";
	CS_FRAME_DODGES_TEXT			= "Ausgew.";
	CS_FRAME_PARRIES_TEXT			= "Parriert";
	CS_FRAME_BLOCKS_TEXT			= "Geblockt";
	CS_FRAME_RESISTS_TEXT			= "Widerst.";
	CS_FRAME_IMMUNE_TEXT			= "Immun";
	CS_FRAME_EVADES_TEXT			= "Entkom.";
	CS_FRAME_DEFLECTS_TEXT			= "Abgelenkt";
	CS_FRAME_PERCENT_OVERALL_TEXT		= "Anteil am Gesamtschaden:";
	CS_FRAME_TIME_LASTCRIT_TEXT		= "Zeit seit letz. Krit.:";
	CS_FRAME_TOTAL_TEXT			= "Gesamt:";
	CS_FRAME_DAMAGE_TEXT			= "Schaden:";
	CS_FRAME_MINMAX_TEXT			= "Min/Max:";
	CS_FRAME_AVGDMG_TEXT			= "Mittl. Schaden:";
	CS_FRAME_PERCENTDMG_TEXT		= "% v. Schaden:";
	    
	CS_DROPDOWN_SELECT_TEXT			= "Angriff w\195\164hlen";
   
	CS_TT_OVERALLPCT_TEXT			= "Kritische Treffer insgesamt in Prozenz.";
	CS_TT_OVERALLDMGPCT_TEXT		= "Gesamtschaden f\195\188r alle Angriffe dieser Art in Prozent.";
	CS_TT_NONCRIT_HITSPCT_TEXT		= "Nichtkritische Treffer dieses Angriffs in Prozent.";
	CS_TT_CRIT_HITSPCT_TEXT			= "Kritischen Treffer dieses Angriffs in Prozent.";
	CS_TT_NONCRIT_DMGPCT_TEXT		= "Schaden durch nichtkritische Treffer dieses Angriffs in Prozent.";
	CS_TT_CRIT_DMGPCT_TEXT			= "Schaden durch kritische Treffer dieses Angriffs in Prozent.";

	CS_TEXT_RESET				= "Zur\195\188cksetzen";
	CS_TEXT_NA				= "k.A.";
	CS_TEXT_GENERAL				= "Angriffsdaten";
	CS_TEXT_NONCRIT				= "Normal";
	CS_TEXT_CRIT				= "Kritisch";

	CS_TEXT_ATTACK_DEFAULT			= "Standard";
	CS_TEXT_ATTACK_TOTAL			= "Gesamt";
	    
	CLOCK_TIME_DAY				= "%d Tag";
	CLOCK_TIME_DAYS				= "%d Tage";
	CLOCK_TIME_HOUR				= "%d Stunde";
	CLOCK_TIME_HOURS			= "%d Stunden";
	CLOCK_TIME_MINUTE			= "%d Minute";
	CLOCK_TIME_MINUTES			= "%d Minuten";
	CLOCK_TIME_SECOND			= "%d Sekunde";
	CLOCK_TIME_SECONDS			= "%d Sekunden";
	

end
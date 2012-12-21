
-- Thanks to Eike and Leftaf for the following translations, and guidance with the required program changes :)

  -- Ä - \195\132
  -- Ö - \195\150
  -- Ü - \195\156
  -- ä - \195\164
  -- ö - \195\182
  -- ü - \195\188
  -- ß - \195\159

if ( GetLocale() == "deDE" ) then

	PSPOT_DELAY_SUFFIX = " Sekunde(n) Abstand zwischen Kartenaktualisierungen";
	PSPOT_OFF = "deaktiviert";

	PSPOT_HELP_TEXT  = " ";
	PSPOT_HELP_TEXT0  = "|cffffff00PartySpotter Befehlshilfe :|r";
	PSPOT_HELP_TEXT1  = "|cff00ff00Benutze |r|cffffffff/pspot|r|cff00ff00 ohne Parameter. Zeigt die aktuelle Anzahl Sekunden Abstand zwischen Kartenaktualisierungen, und diese Hilfe.|r";
	PSPOT_HELP_TEXT2  = "|cff00ff00Benutze |r|cffffffff/pspot 0|r|cff00ff00 um PartySpotter zu deaktiveren|r";
	PSPOT_HELP_TEXT3  = "|cff00ff00Benutze |r|cffffffff/pspot 1|r|cff00ff00 um PartySpotter zu aktivieren und 1 Sekunde Abstand zwischen Kartenaktualisierungen zu haben.|r";
	PSPOT_HELP_TEXT4  = "|cff00ff00Benutze |r|cffffffff/pspot < 1 - 9 >|r|cff00ff00 um PartySpotter zu aktivieren und die Kartenanzeige alle 1 and 9 zu aktualisieren.|r";
	PSPOT_HELP_TEXT5 = "|cff00ff00Benutze |r|cffffffff/pspot showgroups icons / numbers / off|r|cff00ff00 schaltet zwischen Hervorheben der \195\156berfallgruppen mit verschiedenen Farben oder Nummern bzw. keiner Hervorhebung um. |r";
	PSPOT_HELP_TEXT6 = "|cff00ff00Benutze |r|cffffffff/pspot showfriends|r|cff00ff00 schaltet die Hervorhebung von Freunden an/aus|r";
	PSPOT_HELP_TEXT7 = "|cff00ff00Benutze |r|cffffffff/pspot showignores|r|cff00ff00 schaltet die Hervorhebung von Ignorierten an/aus|r";
	PSPOT_HELP_TEXT8 = "|cff00ff00Benutze |r|cffffffff/pspot showguild|r|cff00ff00 schaltet die Hervorhebung von Gildenmitgliedern an/aus|r";
	PSPOT_HELP_TEXT9  = "|cff00ff00Use |r|cffffffff/pspot -l|r|cff00ff00 schaltet die Hervorhebung vom Raidleiter an/aus|r";
	PSPOT_HELP_TEXT10 = "|cff00ff00Use |r|cffffffff/pspot -t <Spieler Name>|r|cff00ff00 hervorheben eines bestimmten Spieler|r";
	PSPOT_HELP_TEXT11 = "|cff00ff00Use |r|cffffffff/pspot -t|r|cff00ff00 |r|cff00ff00 ausschalten der Hervorhebung eines bestimmten Spieler|r";
	PSPOT_HELP_TEXT12 = "|cff00ff00Use |r|cffffffff/pspot reset|r|cff00ff00 Werte Zur\195\188cksetzen|r";

	PSPOT_COLOUR_GROUPS = "Farbcodierte \195\156berfallgruppen";
	PSPOT_NUMBER_GROUPS = "Nummerierte \195\156berfallgruppen";
	PSPOT_DFLT_GROUPS = "Alle \195\156berfallgruppen Mit Gleicher Farbe";
	PSPOT_SHOW_FRIENDS = "Freunde Hervorheben";
	PSPOT_SHOW_IGNORES = "Ignorierte Hervorheben";
	PSPOT_SHOW_GUILD = "Gildenmitglieder Hervorheben";
	PSPOT_NO_HLIGHTS = "Keine Hervorhebung";
	PSPOT_LEADER = "Raidleiter Hervorheben";
 	PSPOT_INDI = "Ausgew\195\164hlten Spieler Hervorheben";

	PSPOT_KEY_TITLE = "PartySpotter\nTasten";

	BINDING_HEADER_PSPOT = "PartySpotter";
	BINDING_NAME_PSPOT_CYCLE_MODE = "PartySpotter Modus umschalten";
	BINDING_NAME_PSPOT_CYCLE_HLIGHT = "PartySpotter Hervorhebung umschalten";

end

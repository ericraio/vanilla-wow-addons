-- German localisation

if (GetLocale() == "deDE") then
    BINDING_HEADER_FLIGHTMAP = "Flugkarte";
    BINDING_NAME_FLIGHTMAP   = "Zeige Flugkarte";

    FLIGHTMAP_NAME          = "Flugkarte";
    FLIGHTMAP_DESCRIPTION   = "Fluglinieninfos auf der Weltkarte";
    FLIGHTMAP_ALLIANCE      = "Allianz";
    FLIGHTMAP_HORDE         = "Horde";
    FLIGHTMAP_CONTESTED     = "Umk\195\164mpft";

    -- Zone names
    FLIGHTMAP_MOONGLADE     = "Moonglade";
    FLIGHTMAP_ELWYNN        = "Wald von Elwynn";
    FLIGHTMAP_DUNMOROGH     = "Dun Morogh";
    FLIGHTMAP_TIRISFAL      = "Tirisfal";
    FLIGHTMAP_LOCHMODAN     = "Loch Modan";
    FLIGHTMAP_SILVERPINE    = "Silberwald";
    FLIGHTMAP_WESTFALL      = "Westfall";
    FLIGHTMAP_REDRIDGE      = "Rotkammgebirge";
    FLIGHTMAP_DUSKWOOD      = "D\195\164mmerwald";
    FLIGHTMAP_HILLSBRAD     = "Vorgebirge von Hillsbrad";
    FLIGHTMAP_WETLANDS      = "Sumpfland";
    FLIGHTMAP_ALTERAC       = "Alteracgebirge";
    FLIGHTMAP_ARATHI        = "Arathihochland";
    FLIGHTMAP_STRANGLETHORN = "Schlingendorntal";
    FLIGHTMAP_BADLANDS      = "\195\150dland";
    FLIGHTMAP_SORROWS       = "S\195\188mpfe des Elends";
    FLIGHTMAP_HINTERLANDS   = "Hinterland";
    FLIGHTMAP_SEARINGGORGE  = "Sengende Schlucht";
    FLIGHTMAP_BLASTEDLANDS  = "Verw\195\188stete Lande";
    FLIGHTMAP_BURNINGSTEPPE = "Brennende Steppe";
    FLIGHTMAP_WESTERNPLAGUE = "Westliche Pestl\195\164nder";
    FLIGHTMAP_EASTERNPLAGUE = "\195\150stliche Pestl\195\164nder";
    FLIGHTMAP_DUROTAR       = "Durotar";
    FLIGHTMAP_MULGORE       = "Mulgore";
    FLIGHTMAP_DARKSHORE     = "Dunkelk\195\188ste";
    FLIGHTMAP_BARRENS       = "Brachland";
    FLIGHTMAP_STONETALON    = "Steinkrallengebirge";
    FLIGHTMAP_ASHENVALE     = "Ashenvale";
    FLIGHTMAP_1KNEEDLES     = "Tausend Nadeln";
    FLIGHTMAP_DESOLACE      = "Desolace";
    FLIGHTMAP_DUSTWALLOW    = "Marschen von Dustwallow";
    FLIGHTMAP_FERALAS       = "Feralas";
    FLIGHTMAP_TANARIS       = "Tanaris";
    FLIGHTMAP_AZSHARA       = "Azshara";
    FLIGHTMAP_FELWOOD       = "Teufelswald";
    FLIGHTMAP_UNGOROCRATER  = "Un'Goro-Krater";
    FLIGHTMAP_SILITHUS      = "Silithus";
    FLIGHTMAP_WINTERSPRING  = "Winterspring";
    FLIGHTMAP_TELDRASSIL    = "Teldrassil";
    FLIGHTMAP_DEADWINDPASS  = "Gebirgspass der Totenwinde";
    FLIGHTMAP_ORGRIMMAR     = "Orgrimmar";
    FLIGHTMAP_THUNDERBLUFF  = "Thunder Bluff";
    FLIGHTMAP_UNDERCITY     = "Undercity";
    FLIGHTMAP_IRONFORGE     = "Ironforge";
    FLIGHTMAP_STORMWIND     = "Stormwind"
    FLIGHTMAP_DARNASSUS     = "Darnassus";

    -- General strings:
    FLIGHTMAP_TIMING        = "(Zeitberechnung)";
    FLIGHTMAP_LEVELS        = "|cff00ff00Zonen-Level: %d - %d|r";
    FLIGHTMAP_NOFLIGHTS     = "Keine bekannt!";
    FLIGHTMAP_NOT_KNOWN     = "(Nicht bekannt)";
    FLIGHTMAP_NO_COST       = "Kostenlos"
    FLIGHTMAP_MONEY_GOLD    = "g";
    FLIGHTMAP_MONEY_SILVER  = "s";
    FLIGHTMAP_MONEY_COPPER  = "k";
    FLIGHTMAP_FLIGHTTIME    = "Flugzeit: ";
    FLIGHTMAP_QUICKEST      = "Schnellste Verbindung";
    FLIGHTMAP_TOTAL_TIME    = "Gesamtdauer";
    FLIGHTMAP_VIA           = "\195\188ber ";
    FLIGHTMAP_CONFIRM       = "Bist du sicher dass du nach %s fliegen willst?%s";
    FLIGHTMAP_CONFIRM_TIME  = " Dieser Flug dauert ";

    -- Command strings
    FLIGHTMAP_RESET         = "Zur\195\188cksetzen";
    FLIGHTMAP_SHOWMAP       = "\195\182ffnen";
    FLIGHTMAP_LOCKTIMES     = "Sperren";
    FLIGHTMAP_GETHELP       = "Hilfe";

    -- Help text
    FLIGHTMAP_TIMER_HELP    =
        "Halte die SHIFT-Taste gedr\195\188ckt und verschiebe die Zeitleiste zum neuanordnen.";
    FLIGHTMAP_SUBCOMMANDS   = {
        [FLIGHTMAP_RESET]       = "Setze die Position der Zeitleiste zur\195\188ck",
        [FLIGHTMAP_SHOWMAP]     = "\195\182ffne de Flugkarte",
        [FLIGHTMAP_GETHELP]     = "Zeige diesen Text",
    };

    -- Locked/unlocked status
    FLIGHTMAP_TIMESLOCKED   = {
        [true] = "Flugzeiten werden nicht l\195\164nger aufgezeichnet.",
        [false] = "Flugzeiten werden nun aufgezeichnet.",
    };

    -- Option strings:
    FLIGHTMAP_OPTIONS_CLOSE = "Schlie\195\159en";
    FLIGHTMAP_OPTIONS_TITLE = "FlightMap Optionen";
    FLIGHTMAP_OPTIONS = {};
    FLIGHTMAP_OPTIONS[1] = {   -- Option 1: flight path lines
        label = "Flugrouten-Linien",
        option = "showPaths",
        tooltip = "Flougrouten auf der Karte mit Linien anzeigen.",
    };
    FLIGHTMAP_OPTIONS[2] = {   -- Option 2: extra POI buttons
        label = "Flugmeister-Symbole",
        option = "showPOIs",
        tooltip = "Flugmeister auf der Karte mit Symbolen anzeigen.",
    };
    FLIGHTMAP_OPTIONS[3] = {   -- Option 3: Unknown masters
        label = "Zeige alles Infos",
        option = "showAllInfo",
        tooltip = "Alle Infos auf der Weltkarte anzeigen (auch f\195\188r unbesuchte Flugpunkte).",
    };
    FLIGHTMAP_OPTIONS[4] = {   -- Option 4: Auto-Dismount
        label = "Auto-absteigen",
        option = "autoDismount",
        tooltip = "Auotmatisch vom Mount steigen wenn beim Flugmeister",
    };
    FLIGHTMAP_OPTIONS[5] = {   -- Option 5: flight timers
        label = "Restdauer-Anzeige",
        option = "useTimer",
        tooltip = "Zeitanzeige im Flugmodus ein-/ausschalten.",
    };

    FLIGHTMAP_OPTIONS[6] = {   -- Option 6: Show flight destinations
        label = "Zeige Zielorte",
        option = "showDestinations",
        tooltip = "Zeige Flugziele im Tooltip",
        children = {7, 8, 9},
    };
    FLIGHTMAP_OPTIONS[7] = {   -- Option 7: Show multi-hop destinations
        label = "Multi-hop einbeziehen",
        option = "showMultiHop",
        tooltip = "Zeige multi-hop Ziele in den Tootips",
    };
    FLIGHTMAP_OPTIONS[8] = {   -- Option 8: Show flight times
        label = "Zeige Flugdauer",
        option = "showTimes",
        tooltip = "Flugzeiten im Tooltip anzeigen.",
    };
    FLIGHTMAP_OPTIONS[9] = {   -- Option 9: Show flight costs
        label = "Zeige Flugkosten",
        option = "showCosts",
        tooltip = "Flugkosten im Tooltip anzeigen.",
    };
    FLIGHTMAP_OPTIONS[10] = {   -- Option 10: Taxi window extras
        label = "Vollst\195\164ndige Flugkarte",
        option = "fullTaxiMap",
        tooltip = "Zeige alle Flugpunkte im Flugmeister-Fenster.",
    };
    FLIGHTMAP_OPTIONS[11] = {   -- Option 11: Confirm flight destinations
        label = "Fl\195\188ge best\195\164tigen",
        option = "confirmFlights",
        tooltip = "Nachfragen bevor die Fl\195\188ge starten",
    };

    -- These constants determine how "Town, Zone" strings look.
    -- SEP_STRING is what separates Town from Zone.  SEP_POSTAMBLE
    -- is anything that is after Zone.
    FLIGHTMAP_SEP_STRING    = ", ";
    FLIGHTMAP_SEP_POSTAMBLE = "";
end

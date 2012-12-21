-- Translatable strings, French version

-- XXX This is not yet translated!  If you wish to translate it,
--     please send a copy to me via <bje@apnic.net> so I can include
--     it in the next release!

if (GetLocale() == "frFR") then
    BINDING_HEADER_FLIGHTMAP = "FlightMap";
    BINDING_NAME_FLIGHTMAP   = "Show flight map";

    FLIGHTMAP_NAME          = "FlightMap";
    FLIGHTMAP_DESCRIPTION   = "Informations sur les vols";
    FLIGHTMAP_ALLIANCE      = "Alliance";
    FLIGHTMAP_HORDE         = "Horde";
    FLIGHTMAP_CONTESTED     = "Contest\195\130";

    -- Zone names
    FLIGHTMAP_MOONGLADE     = "Reflet-de-Lune (Moonglade)";
    FLIGHTMAP_ELWYNN        = "For\195\170t d'Elwynn";
    FLIGHTMAP_DUNMOROGH     = "Dun Morogh";
    FLIGHTMAP_TIRISFAL      = "Clairi\195\168res de Tirisfal";
    FLIGHTMAP_LOCHMODAN     = "Loch Modan";
    FLIGHTMAP_SILVERPINE    = "For\195\170t des Pins argent\195\169s (Silverpine Forest)";
    FLIGHTMAP_WESTFALL      = "Marche de l'Ouest (Westfall)";
    FLIGHTMAP_REDRIDGE      = "Les Carmines (Redridge Mts)";
    FLIGHTMAP_DUSKWOOD      = "Bois de la p\195\169nombre (Duskwood)";
    FLIGHTMAP_HILLSBRAD     = "Contreforts d'Hillsbrad";
    FLIGHTMAP_WETLANDS      = "Les Paluns (Wetlands)";
    FLIGHTMAP_ALTERAC       = "Montagnes d'Alterac";
    FLIGHTMAP_ARATHI        = "Hautes-Terres d'Arathi";
    FLIGHTMAP_STRANGLETHORN = "Vall\195\169e de Strangleronce (Stranglethorn Vale)";
    FLIGHTMAP_BADLANDS      = "Terres ingrates (Badlands)";
    FLIGHTMAP_SORROWS       = "Marais des Chagrins (Swamp of Sorrows)";
    FLIGHTMAP_HINTERLANDS   = "Les Hinterlands";
    FLIGHTMAP_SEARINGGORGE  = "Gorges des Vents Br\195\187lants (Searing Gorge)";
    FLIGHTMAP_BLASTEDLANDS  = "Terres foudroy\195\169es (Blasted Lands)";
    FLIGHTMAP_BURNINGSTEPPE = "Steppes ardentes";
    FLIGHTMAP_WESTERNPLAGUE = "Maleterres de l'ouest (Western Plaguelands)";
    FLIGHTMAP_EASTERNPLAGUE = "Maleterres de l'est (Eastern Plaguelands)";
    FLIGHTMAP_DUROTAR       = "Durotar";
    FLIGHTMAP_MULGORE       = "Mulgore";
    FLIGHTMAP_DARKSHORE     = "Sombrivage (Darkshore)";
    FLIGHTMAP_BARRENS       = "Les Tarides (the Barrens)";
    FLIGHTMAP_STONETALON    = "Les Serres-Rocheuses (Stonetalon Mts)";
    FLIGHTMAP_ASHENVALE     = "Ashenvale";
    FLIGHTMAP_1KNEEDLES     = "Mille pointes (Thousand Needles)";
    FLIGHTMAP_DESOLACE      = "D\195\169solace";
    FLIGHTMAP_DUSTWALLOW    = "Mar\195\169cage d'\195\130prefange (Dustwallow Marsh)";
    FLIGHTMAP_FERALAS       = "Feralas";
    FLIGHTMAP_TANARIS       = "Tanaris";
    FLIGHTMAP_AZSHARA       = "Azshara";
    FLIGHTMAP_FELWOOD       = "Gangrebois (Felwood)";
    FLIGHTMAP_UNGOROCRATER  = "Crat\195\168re d'Un'Goro";
    FLIGHTMAP_SILITHUS      = "Silithus";
    FLIGHTMAP_WINTERSPRING  = "Berceau-de-l'Hiver (Winterspring)";
    FLIGHTMAP_TELDRASSIL    = "Teldrassil";
    FLIGHTMAP_DEADWINDPASS  = "D\195\169fil\195\169 de Deuillevent (Deadwind Pass)";
    FLIGHTMAP_ORGRIMMAR     = "Orgrimmar";      -- TODO translate
    FLIGHTMAP_THUNDERBLUFF  = "Thunder Bluff";  -- TODO translate
    FLIGHTMAP_UNDERCITY     = "Undercity";
    FLIGHTMAP_IRONFORGE     = "Ironforge";      -- TODO translate
    FLIGHTMAP_STORMWIND     = "Cit\195\169 de Stormwind";
    FLIGHTMAP_DARNASSUS     = "Darnassus";      -- TODO translate

    -- General strings
    FLIGHTMAP_TIMING        = "(Calcul)";
    FLIGHTMAP_LEVELS        = "|cff00ff00Niveau de Zone: %d - %d|r";
    FLIGHTMAP_NOFLIGHTS     = "Aucun connu!";
    FLIGHTMAP_NOT_KNOWN     = "(Inconnu)";
    FLIGHTMAP_NO_COST       = "Gratuit";
    FLIGHTMAP_MONEY_GOLD    = "o";
    FLIGHTMAP_MONEY_SILVER  = "a";
    FLIGHTMAP_MONEY_COPPER  = "c";
    FLIGHTMAP_FLIGHTTIME    = "Temps de vol: ";
    FLIGHTMAP_QUICKEST      = "Trajet le plus rapide";
    FLIGHTMAP_TOTAL_TIME    = "Temps total";
    FLIGHTMAP_VIA           = "Via ";           -- TODO translate
    FLIGHTMAP_CONFIRM       = "Voulez-vous vraiment rejoindre %s?%s";
    FLIGHTMAP_CONFIRM_TIME  = " Ce vol prendra ";

    -- Command strings
    FLIGHTMAP_RESET         = "reset";  -- TODO translate
    FLIGHTMAP_SHOWMAP       = "open";   -- TODO translate
    FLIGHTMAP_LOCKTIMES     = "lock";   -- TODO translate
    FLIGHTMAP_GETHELP       = "help";   -- TODO translate

    -- Help text        TODO translate
    FLIGHTMAP_TIMER_HELP    =
        "Hold down SHIFT and drag the timer bar to reposition.";
    FLIGHTMAP_SUBCOMMANDS   = {
        [FLIGHTMAP_RESET]       = "Reset timer bar position",
        [FLIGHTMAP_SHOWMAP]     = "Open flight map window",
        [FLIGHTMAP_GETHELP]     = "Show this text",
    };

    -- Locked/unlocked status           TODO translate
    FLIGHTMAP_TIMESLOCKED   = {
        [true] = "Flight times will no longer be recorded.",
        [false] = "Flight times will now be recorded.",
    };

    -- Option strings
    FLIGHTMAP_OPTIONS_CLOSE = "Close";             -- TODO translate
    FLIGHTMAP_OPTIONS_TITLE = "FlightMap Options"; -- TODO translate
    FLIGHTMAP_OPTIONS = {}
    FLIGHTMAP_OPTIONS[1] = {   -- Option 1: flight path lines
        label = "Lignes de trajets",
        option = "showPaths",
        tooltip = "Dessine les trajets a\195\169riens sur la carte du monde.",
    };
    FLIGHTMAP_OPTIONS[2] = {   -- Option 2: extra POI buttons
        label = "POIs pour M\195\162itres",
        option = "showPOIs",
        tooltip = "Affiche des bouttons POI suppl\195\169mentaites pour les m\195\162itre des cavaliers celestes.",
    };
    FLIGHTMAP_OPTIONS[3] = {   -- Option 3: Unknown masters  (TODO translate)
        label = "Show all info",
        option = "showAllInfo",
        tooltip = "Show all data, even for unvisited flight nodes.",
    };
    FLIGHTMAP_OPTIONS[4] = {   -- Option 4: Auto-Dismount
        label = "Auto dismount",
        option = "autoDismount",
        tooltip = "Automatically dismount when speaking to a flight master",
    };
    FLIGHTMAP_OPTIONS[5] = {   -- Option 5: flight timers
        label = "Compteur durant le vol",
        option = "useTimer",
        tooltip = "Active/Supprime le la barre de dur\195\169e du trajet.",
    };

    FLIGHTMAP_OPTIONS[6] = {   -- Option 6: Show flight destinations
        label = "Show destinations",
        option = "showDestinations",
        tooltip = "Show flight destinations on tooltips",
        children = {7, 8, 9},
    };
    FLIGHTMAP_OPTIONS[7] = {   -- Option 7: Show multi-hop destinations
        label = "Including multi-hop",
        option = "showMultiHop",
        tooltip = "Show multi-hop destinations on tooltips",
    };
    FLIGHTMAP_OPTIONS[8] = {   -- Option 8: Show flight times  (TODO translate)
        label = "With flight times",
        option = "showTimes",
        tooltip = "Show flight times on tooltips.",
    };
    FLIGHTMAP_OPTIONS[9] = {   -- Option 9: Show flight costs  (TODO translate)
        label = "With flight costs",
        option = "showCosts",
        tooltip = "Show flight costs on tooltips.",
    };
    FLIGHTMAP_OPTIONS[10] = {   -- Option 10: Taxi window extras 
        label = "Full flight map",
        option = "fullTaxiMap",
        tooltip = "Show unreachable nodes on the taxi window map",
    };
    FLIGHTMAP_OPTIONS[11] = {   -- Option 11: Confirm flight destinations
        label = "Confirm flights",
        option = "confirmFlights",
        tooltip = "Prompt for confirmation before taking a flight",
    };

    -- These constants determine how "Town, Zone" strings look.
    -- SEP_STRING is what separates Town from Zone.  SEP_POSTAMBLE
    -- is anything that is after Zone.
    FLIGHTMAP_SEP_STRING    = ", ";
    FLIGHTMAP_SEP_POSTAMBLE = "";
end

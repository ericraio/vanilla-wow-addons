-- Default data sets for FlightMap
--
-- Some default flight times thanks to Krwaz, author of FlightPath.
-- 
-- This file is loaded after the localizations

-- Default options
FLIGHTMAP_DEFAULT_OPTS = {
     ["showPaths"]   = true,
     ["showPOIs"]    = true,
     ["showAllInfo"] = false,
     ["useTimer"]    = true,
     ["showCosts"]   = false,
     ["showTimes"]   = false,
     ["fullTaxiMap"] = true,
};

-- Sub-zones
FLIGHTMAP_SUBZONES = {
    [FLIGHTMAP_ORGRIMMAR]    = FLIGHTMAP_DUROTAR,
    [FLIGHTMAP_THUNDERBLUFF] = FLIGHTMAP_MULGORE,
    [FLIGHTMAP_UNDERCITY]    = FLIGHTMAP_TIRISFAL,
    [FLIGHTMAP_IRONFORGE]    = FLIGHTMAP_DUNMOROGH,
    [FLIGHTMAP_STORMWIND]    = FLIGHTMAP_ELWYNN,
};

-- Default flight data
-- Note that the node names are not internationalised.  This is not a
-- problem, because they will be updated as soon as that node appears
-- on a taxi map, and they are not used for anything but labels.
FLIGHTMAP_HORDE_FLIGHTS = {
    ["2:671:703"] = {
        ["Name"]      = "Revantusk Village, The Hinterlands",
        ["Zone"]      = FLIGHTMAP_HINTERLANDS,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.671537, ["y"] = 0.703984 },
            ["Continent"] = { ["x"] = 0.58861, ["y"] = 0.345161 },
            ["Zone"]      = { ["x"] = 0.816628, ["y"] = 0.818109 },
        },
        ["Flights"]   = {
            ["2:494:733"] = 170.182,   	-- Tarren Mill, Hillsbrad
            ["2:442:805"] = 285.968,   	-- Undercity, Tirisfal
        },
        ["Costs"]     = {
            ["2:494:733"] = 330,  	-- Tarren Mill, Hillsbrad
            ["2:442:805"] = 730,  	-- Undercity, Tirisfal
        },
    },
    ["2:605:253"] = {
        ["Name"]      = "Stonard, Swamp of Sorrows",
        ["Zone"]      = FLIGHTMAP_SORROWS,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.605416, ["y"] = 0.253385 },
            ["Continent"] = { ["x"] = 0.547707, ["y"] = 0.763791 },
            ["Zone"]      = { ["x"] = 0.460527, ["y"] = 0.546792 },
        },
        ["Flights"]   = {
            ["2:448:163"] = 190,   	-- Grom'gol, Stranglethorn
            ["2:431:70"] = 261.643,   	-- Booty Bay, Stranglethorn
            ["2:554:428"] = 287.134,   	-- Kargath, Badlands
            ["2:555:388"] = 199.168,   	-- Flame Crest, Burning Steppes
        },
        ["Costs"]     = {
            ["2:448:163"] = 630,  	-- Grom'gol, Stranglethorn
            ["2:431:70"] = 630,  	-- Booty Bay, Stranglethorn
            ["2:554:428"] = 630,  	-- Kargath, Badlands
            ["2:555:388"] = 830,  	-- Flame Crest, Burning Steppes
        },
    },
    ["1:640:767"] = {
        ["Name"]      = "Everlook, Winterspring",
        ["Zone"]      = FLIGHTMAP_WINTERSPRING,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.640145, ["y"] = 0.767587 },
            ["Continent"] = { ["x"] = 0.589027, ["y"] = 0.244034 },
            ["Zone"]      = { ["x"] = 0.60462, ["y"] = 0.363457 },
        },
        ["Flights"]   = {
            ["1:537:794"] = 145,   	-- Moonglade
            ["1:464:695"] = 196.671,   	-- Bloodvenom Post, Felwood
            ["1:537:794"] = 145,   	-- Moonglade
            ["1:628:556"] = 297.52,   	-- Orgrimmar, Durotar
        },
        ["Costs"]     = {
            ["1:537:794"] = 830,  	-- Moonglade
            ["1:464:695"] = 930,  	-- Bloodvenom Post, Felwood
            ["1:537:794"] = 830,  	-- Moonglade
            ["1:628:556"] = 1020,  	-- Orgrimmar, Durotar
        },
    },
    ["2:442:805"] = {
        ["Name"]      = "Undercity, Tirisfal",
        ["Zone"]      = FLIGHTMAP_UNDERCITY,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.442677, ["y"] = 0.805093 },
            ["Continent"] = { ["x"] = 0.447031, ["y"] = 0.251379 },
            ["Zone"]      = { ["x"] = 0.634422, ["y"] = 0.484864 },
        },
        ["Flights"]   = {
            ["2:384:755"] = 107.893,   	-- Sepulcher, Silverpine
            ["2:494:733"] = 142.431,   	-- Tarren Mill, Hillsbrad
            ["2:615:691"] = 302.177,   	-- Hammerfall, Arathi
            ["2:554:428"] = 490.724,   	-- Kargath, Badlands
            ["2:697:839"] = 263.949,   	-- Light's Hope Chapel, Eastern Plaguelands
            ["2:671:703"] = 286.121,   	-- Revantusk Village, The Hinterlands
        },
        ["Costs"]     = {
            ["2:384:755"] = 110,  	-- Sepulcher, Silverpine
            ["2:494:733"] = 330,  	-- Tarren Mill, Hillsbrad
            ["2:615:691"] = 530,  	-- Hammerfall, Arathi
            ["2:554:428"] = 630,  	-- Kargath, Badlands
            ["2:697:839"] = 1020,  	-- Light's Hope Chapel, Eastern Plaguelands
            ["2:671:703"] = 730,  	-- Revantusk Village, The Hinterlands
        },
    },
    ["2:431:70"] = {
        ["Name"]      = "Booty Bay, Stranglethorn",
        ["Zone"]      = FLIGHTMAP_STRANGLETHORN,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.431591, ["y"] = 0.0704551 },
            ["Continent"] = { ["x"] = 0.4402, ["y"] = 0.933794 },
            ["Zone"]      = { ["x"] = 0.268888, ["y"] = 0.770448 },
        },
        ["Flights"]   = {
            ["2:448:163"] = 103.445,   	-- Grom'gol, Stranglethorn
            ["2:554:428"] = 395.039,   	-- Kargath, Badlands
            ["2:605:253"] = 252.256,   	-- Stonard, Swamp of Sorrows
        },
        ["Costs"]     = {
            ["2:448:163"] = 630,  	-- Grom'gol, Stranglethorn
            ["2:554:428"] = 630,  	-- Kargath, Badlands
            ["2:605:253"] = 630,  	-- Stonard, Swamp of Sorrows
        },
    },
    ["1:449:438"] = {
        ["Name"]      = "Thunder Bluff, Mulgore",
        ["Zone"]      = FLIGHTMAP_THUNDERBLUFF,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.449478, ["y"] = 0.438488 },
            ["Continent"] = { ["x"] = 0.463042, ["y"] = 0.570557 },
            ["Zone"]      = { ["x"] = 0.469395, ["y"] = 0.499671 },
        },
        ["Flights"]   = {
            ["1:567:358"] = 0,   	-- Brackenwall Village, Dustwallow Marsh
            ["1:628:556"] = 208.804,   	-- Orgrimmar, Durotar
            ["1:557:469"] = 158.739,   	-- Crossroads, The Barrens
            ["1:407:527"] = 197,   	-- Sun Rock Retreat, Stonetalon Mountains
            ["1:549:265"] = 205,   	-- Freewind Post, Thousand Needles
            ["1:631:638"] = 0,   	-- Valormok, Azshara
            ["1:316:415"] = 161.027,   	-- Shadowprey Village, Desolace
            ["1:442:306"] = 254.928,   	-- Camp Mojache, Feralas
            ["1:606:198"] = 293.05,   	-- Gadgetzan, Tanaris
            ["1:528:389"] = 112.021,   	-- Camp Taurajo, The Barrens
        },
        ["Costs"]     = {
            ["1:567:358"] = 630,  	-- Brackenwall Village, Dustwallow Marsh
            ["1:628:556"] = 50,  	-- Orgrimmar, Durotar
            ["1:557:469"] = 110,  	-- Crossroads, The Barrens
            ["1:407:527"] = 210,  	-- Sun Rock Retreat, Stonetalon Mountains
            ["1:549:265"] = 430,  	-- Freewind Post, Thousand Needles
            ["1:631:638"] = 830,  	-- Valormok, Azshara
            ["1:316:415"] = 530,  	-- Shadowprey Village, Desolace
            ["1:442:306"] = 730,  	-- Camp Mojache, Feralas
            ["1:606:198"] = 730,  	-- Gadgetzan, Tanaris
            ["1:528:389"] = 110,  	-- Camp Taurajo, The Barrens
        },
    },
    ["1:606:198"] = {
        ["Name"]      = "Gadgetzan, Tanaris",
        ["Zone"]      = FLIGHTMAP_TANARIS,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.606013, ["y"] = 0.198074 },
            ["Continent"] = { ["x"] = 0.566477, ["y"] = 0.809009 },
            ["Zone"]      = { ["x"] = 0.516066, ["y"] = 0.255169 },
        },
        ["Flights"]   = {
            ["1:628:556"] = 352.006,   	-- Orgrimmar, Durotar
            ["1:549:265"] = 89.112,     -- Freewind Post, Thousand Needles
            ["1:449:438"] = 0,          -- Thunder Bluff, Mulgore
            ["1:567:358"] = 223.047,    -- Brackenwall Village, Dustwallow Marsh
            ["1:442:306"] = 195.068,   	-- Camp Mojache, Feralas
            ["1:557:469"] = 306.64,   	-- Crossroads, The Barrens
            ["1:416:207"] = 242.258,   	-- Cenarion Hold, Silithus
        },
        ["Costs"]     = {
            ["1:628:556"] = 730,  	-- Orgrimmar, Durotar
            ["1:549:265"] = 430,  	-- Freewind Post, Thousand Needles
            ["1:449:438"] = 730,  	-- Thunder Bluff, Mulgore
            ["1:567:358"] = 630,  	-- Brackenwall Village, Dustwallow Marsh
            ["1:442:306"] = 630,  	-- Camp Mojache, Feralas
            ["1:557:469"] = 730,  	-- Crossroads, The Barrens
            ["1:416:207"] = 1020,  	-- Cenarion Hold, Silithus
        },
    },
    ["1:631:638"] = {
        ["Name"]      = "Valormok, Azshara",
        ["Zone"]      = FLIGHTMAP_AZSHARA,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.631076, ["y"] = 0.638107 },
            ["Continent"] = { ["x"] = 0.583076, ["y"] = 0.372502 },
            ["Zone"]      = { ["x"] = 0.219568, ["y"] = 0.496983 },
        },
        ["Flights"]   = {
            ["1:628:556"] = 122,   	-- Orgrimmar, Durotar
            ["1:449:438"] = 0,   	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 251,   	-- Crossroads, The Barrens
            ["1:464:695"] = 0,   	-- Bloodvenom Post, Felwood
        },
        ["Costs"]     = {
            ["1:628:556"] = 830,  	-- Orgrimmar, Durotar
            ["1:449:438"] = 830,  	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 830,  	-- Crossroads, The Barrens
            ["1:464:695"] = 930,  	-- Bloodvenom Post, Felwood
        },
    },
    ["2:555:388"] = {
        ["Name"]      = "Flame Crest, Burning Steppes",
        ["Zone"]      = FLIGHTMAP_BURNINGSTEPPE,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.555331, ["y"] = 0.388859 },
            ["Continent"] = { ["x"] = 0.516704, ["y"] = 0.637847 },
            ["Zone"]      = { ["x"] = 0.655905, ["y"] = 0.240902 },
        },
        ["Flights"]   = {
            ["2:605:253"] = 199.512,   	-- Stonard, Swamp of Sorrows
            ["2:554:428"] = 89.367,   	-- Kargath, Badlands
            ["2:505:432"] = 0,   	-- Thorium Point, Searing Gorge
        },
        ["Costs"]     = {
            ["2:605:253"] = 830,  	-- Stonard, Swamp of Sorrows
            ["2:554:428"] = 830,  	-- Kargath, Badlands
            ["2:505:432"] = 830,  	-- Thorium Point, Searing Gorge
        },
    },
    ["2:697:839"] = {
        ["Name"]      = "Light's Hope Chapel, Eastern Plaguelands",
        ["Zone"]      = FLIGHTMAP_EASTERNPLAGUE,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.697522, ["y"] = 0.839905 },
            ["Continent"] = { ["x"] = 0.604868, ["y"] = 0.219077 },
            ["Zone"]      = { ["x"] = 0.802381, ["y"] = 0.571197 },
        },
        ["Flights"]   = {
            ["2:442:805"] = 259.563,   	-- Undercity, Tirisfal
        },
        ["Costs"]     = {
            ["2:442:805"] = 1020,  	-- Undercity, Tirisfal
        },
    },
    ["1:528:389"] = {
        ["Name"]      = "Camp Taurajo, The Barrens",
        ["Zone"]      = FLIGHTMAP_BARRENS,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.528047, ["y"] = 0.389866 },
            ["Continent"] = { ["x"] = 0.514925, ["y"] = 0.618813 },
            ["Zone"]      = { ["x"] = 0.444619, ["y"] = 0.591164 },
        },
        ["Flights"]   = {
            ["1:557:469"] = 84.272,   	-- Crossroads, The Barrens
            ["1:449:438"] = 115.798,   	-- Thunder Bluff, Mulgore
            ["1:549:265"] = 0,   	-- Freewind Post, Thousand Needles
        },
        ["Costs"]     = {
            ["1:557:469"] = 110,  	-- Crossroads, The Barrens
            ["1:449:438"] = 110,  	-- Thunder Bluff, Mulgore
            ["1:549:265"] = 430,  	-- Freewind Post, Thousand Needles
        },
    },
    ["1:316:415"] = {
        ["Name"]      = "Shadowprey Village, Desolace",
        ["Zone"]      = FLIGHTMAP_DESOLACE,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.316603, ["y"] = 0.415052 },
            ["Continent"] = { ["x"] = 0.375114, ["y"] = 0.593778 },
            ["Zone"]      = { ["x"] = 0.215948, ["y"] = 0.740331 },
        },
        ["Flights"]   = {
            ["1:449:438"] = 173.48,   	-- Thunder Bluff, Mulgore
            ["1:407:527"] = 201.209,   	-- Sun Rock Retreat, Stonetalon Mountains
            ["1:442:306"] = 205.478,   	-- Camp Mojache, Feralas
        },
        ["Costs"]     = {
            ["1:449:438"] = 530,  	-- Thunder Bluff, Mulgore
            ["1:407:527"] = 210,  	-- Sun Rock Retreat, Stonetalon Mountains
            ["1:442:306"] = 730,  	-- Camp Mojache, Feralas
        },
    },
    ["2:505:432"] = {
        ["Name"]      = "Thorium Point, Searing Gorge",
        ["Zone"]      = FLIGHTMAP_SEARINGGORGE,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.505439, ["y"] = 0.432402 },
            ["Continent"] = { ["x"] = 0.485798, ["y"] = 0.597623 },
            ["Zone"]      = { ["x"] = 0.348295, ["y"] = 0.307621 },
        },
        ["Flights"]   = {
            ["2:554:428"] = 58.547,   	-- Kargath, Badlands
            ["2:555:388"] = 78.535,   	-- Flame Crest, Burning Steppes
        },
        ["Costs"]     = {
            ["2:554:428"] = 630,  	-- Kargath, Badlands
            ["2:555:388"] = 830,  	-- Flame Crest, Burning Steppes
        },
    },
    ["2:554:428"] = {
        ["Name"]      = "Kargath, Badlands",
        ["Zone"]      = FLIGHTMAP_BADLANDS,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.554987, ["y"] = 0.428775 },
            ["Continent"] = { ["x"] = 0.51648, ["y"] = 0.600879 },
            ["Zone"]      = { ["x"] = 0.0405562, ["y"] = 0.448889 },
        },
        ["Flights"]   = {
            ["2:555:388"] = 88.824,   	-- Flame Crest, Burning Steppes
            ["2:615:691"] = 258.426,   	-- Hammerfall, Arathi
            ["2:431:70"] = 435.394,   	-- Booty Bay, Stranglethorn
            ["2:442:805"] = 499.5,   	-- Undercity, Tirisfal
            ["2:605:253"] = 0,   	-- Stonard, Swamp of Sorrows
            ["2:448:163"] = 315.546,   	-- Grom'gol, Stranglethorn
            ["2:505:432"] = 0,   	-- Thorium Point, Searing Gorge
        },
        ["Costs"]     = {
            ["2:555:388"] = 830,  	-- Flame Crest, Burning Steppes
            ["2:615:691"] = 630,  	-- Hammerfall, Arathi
            ["2:431:70"] = 630,  	-- Booty Bay, Stranglethorn
            ["2:442:805"] = 630,  	-- Undercity, Tirisfal
            ["2:605:253"] = 710,  	-- Stonard, Swamp of Sorrows
            ["2:448:163"] = 530,  	-- Grom'gol, Stranglethorn
            ["2:505:432"] = 830,  	-- Thorium Point, Searing Gorge
        },
    },
    ["1:554:582"] = {
        ["Name"]      = "Splintertree Post, Ashenvale",
        ["Zone"]      = FLIGHTMAP_ASHENVALE,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.554419, ["y"] = 0.582267 },
            ["Continent"] = { ["x"] = 0.532215, ["y"] = 0.427593 },
            ["Zone"]      = { ["x"] = 0.731588, ["y"] = 0.614828 },
        },
        ["Flights"]   = {
            ["1:409:626"] = 168.356,   	-- Zoram'gar Outpost, Ashenvale
            ["1:628:556"] = 89.738,   	-- Orgrimmar, Durotar
            ["1:557:469"] = 165.429,   	-- Crossroads, The Barrens
        },
        ["Costs"]     = {
            ["1:409:626"] = 330,  	-- Zoram'gar Outpost, Ashenvale
            ["1:628:556"] = 530,  	-- Orgrimmar, Durotar
            ["1:557:469"] = 530,  	-- Crossroads, The Barrens
        },
    },
    ["1:628:556"] = {
        ["Name"]      = "Orgrimmar, Durotar",
        ["Zone"]      = FLIGHTMAP_ORGRIMMAR,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.628008, ["y"] = 0.556598 },
            ["Continent"] = { ["x"] = 0.58107, ["y"] = 0.453437 },
            ["Zone"]      = { ["x"] = 0.453496, ["y"] = 0.639553 },
        },
        ["Flights"]   = {
            ["1:567:358"] = 230.779,   	-- Brackenwall Village, Dustwallow Marsh
            ["1:464:695"] = 249.503,   	-- Bloodvenom Post, Felwood
            ["1:640:767"] = 322.161,   	-- Everlook, Winterspring
            ["1:449:438"] = 226.608,   	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 111.996,   	-- Crossroads, The Barrens
            ["1:606:198"] = 418.397,   	-- Gadgetzan, Tanaris
            ["1:631:638"] = 100.518,   	-- Valormok, Azshara
            ["1:554:582"] = 92.452,   	-- Splintertree Post, Ashenvale
        },
        ["Costs"]     = {
            ["1:567:358"] = 630,  	-- Brackenwall Village, Dustwallow Marsh
            ["1:464:695"] = 830,  	-- Bloodvenom Post, Felwood
            ["1:640:767"] = 1020,  	-- Everlook, Winterspring
            ["1:449:438"] = 50,  	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 110,  	-- Crossroads, The Barrens
            ["1:606:198"] = 730,  	-- Gadgetzan, Tanaris
            ["1:631:638"] = 830,  	-- Valormok, Azshara
            ["1:554:582"] = 530,  	-- Splintertree Post, Ashenvale
        },
    },
    ["1:549:265"] = {
        ["Name"]      = "Freewind Post, Thousand Needles",
        ["Zone"]      = FLIGHTMAP_1KNEEDLES,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.549889, ["y"] = 0.265501 },
            ["Continent"] = { ["x"] = 0.529478, ["y"] = 0.742223 },
            ["Zone"]      = { ["x"] = 0.451083, ["y"] = 0.491774 },
        },
        ["Flights"]   = {
            ["1:449:438"] = 220.431,    -- Thunder Bluff, Mulgore
            ["1:557:469"] = 188.208,   	-- Crossroads, The Barrens
            ["1:606:198"] = 0,          -- Gadgetzan, Tanaris
            ["1:528:389"] = 0,          -- Camp Taurajo, The Barrens
        },
        ["Costs"]     = {
            ["1:449:438"] = 430,  	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 430,  	-- Crossroads, The Barrens
            ["1:606:198"] = 730,  	-- Gadgetzan, Tanaris
            ["1:528:389"] = 430,  	-- Camp Taurajo, The Barrens
        },
    },
    ["1:464:695"] = {
        ["Name"]      = "Bloodvenom Post, Felwood",
        ["Zone"]      = FLIGHTMAP_FELWOOD,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.464553, ["y"] = 0.695908 },
            ["Continent"] = { ["x"] = 0.472967, ["y"] = 0.315084 },
            ["Zone"]      = { ["x"] = 0.344375, ["y"] = 0.538294 },
        },
        ["Flights"]   = {
            ["1:640:767"] = 193.748,   	-- Everlook, Winterspring
            ["1:557:469"] = 269.608,   	-- Crossroads, The Barrens
            ["1:628:556"] = 248.205,   	-- Orgrimmar, Durotar
            ["1:537:794"] = 160.639,   	-- Moonglade
            ["1:631:638"] = 0,   	-- Valormok, Azshara
        },
        ["Costs"]     = {
            ["1:640:767"] = 1020,  	-- Everlook, Winterspring
            ["1:557:469"] = 930,  	-- Crossroads, The Barrens
            ["1:628:556"] = 930,  	-- Orgrimmar, Durotar
            ["1:537:794"] = 830,  	-- Moonglade
            ["1:631:638"] = 830,  	-- Valormok, Azshara
        },
    },
    ["1:442:306"] = {
        ["Name"]      = "Camp Mojache, Feralas",
        ["Zone"]      = FLIGHTMAP_FERALAS,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.44251, ["y"] = 0.306086 },
            ["Continent"] = { ["x"] = 0.458381, ["y"] = 0.701901 },
            ["Zone"]      = { ["x"] = 0.754445, ["y"] = 0.443163 },
        },
        ["Flights"]   = {
            ["1:557:469"] = 269.09,   	-- Crossroads, The Barrens
            ["1:316:415"] = 0,   	-- Shadowprey Village, Desolace
            ["1:449:438"] = 261.121,   	-- Thunder Bluff, Mulgore
            ["1:606:198"] = 193,   	-- Gadgetzan, Tanaris
        },
        ["Costs"]     = {
            ["1:557:469"] = 730,  	-- Crossroads, The Barrens
            ["1:316:415"] = 730,  	-- Shadowprey Village, Desolace
            ["1:449:438"] = 730,  	-- Thunder Bluff, Mulgore
            ["1:606:198"] = 630,  	-- Gadgetzan, Tanaris
        },
    },
    ["1:407:527"] = {
        ["Name"]      = "Sun Rock Retreat, Stonetalon Mountains",
        ["Zone"]      = FLIGHTMAP_STONETALON,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.407957, ["y"] = 0.527386 },
            ["Continent"] = { ["x"] = 0.435442, ["y"] = 0.482352 },
            ["Zone"]      = { ["x"] = 0.451209, ["y"] = 0.598971 },
        },
        ["Flights"]   = {
            ["1:316:415"] = 198.632,   	-- Shadowprey Village, Desolace
            ["1:449:438"] = 317,   	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 152.151,   	-- Crossroads, The Barrens
        },
        ["Costs"]     = {
            ["1:316:415"] = 530,  	-- Shadowprey Village, Desolace
            ["1:449:438"] = 210,  	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 210,  	-- Crossroads, The Barrens
        },
    },
    ["1:537:794"] = {
        ["Name"]      = "Moonglade",
        ["Zone"]      = FLIGHTMAP_MOONGLADE,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.537937, ["y"] = 0.794593 },
            ["Continent"] = { ["x"] = 0.521423, ["y"] = 0.217275 },
            ["Zone"]      = { ["x"] = 0.3215, ["y"] = 0.6633 },
        },
        ["Flights"]   = {
            ["1:640:767"] = 146.938,   	-- Everlook, Winterspring
            ["1:464:695"] = 161,   	-- Bloodvenom Post, Felwood
            ["1:640:767"] = 146.938,   	-- Everlook, Winterspring
        },
        ["Costs"]     = {
            ["1:640:767"] = 1020,  	-- Everlook, Winterspring
            ["1:464:695"] = 930,  	-- Bloodvenom Post, Felwood
            ["1:640:767"] = 1020,  	-- Everlook, Winterspring
        },
    },
    ["2:384:755"] = {
        ["Name"]      = "Sepulcher, Silverpine",
        ["Zone"]      = FLIGHTMAP_SILVERPINE,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.384475, ["y"] = 0.755098 },
            ["Continent"] = { ["x"] = 0.410883, ["y"] = 0.29787 },
            ["Zone"]      = { ["x"] = 0.455483, ["y"] = 0.42502 },
        },
        ["Flights"]   = {
            ["2:442:805"] = 116.442,   	-- Undercity, Tirisfal
        },
        ["Costs"]     = {
            ["2:442:805"] = 110,  	-- Undercity, Tirisfal
        },
    },
    ["2:494:733"] = {
        ["Name"]      = "Tarren Mill, Hillsbrad",
        ["Zone"]      = FLIGHTMAP_HILLSBRAD,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.494422, ["y"] = 0.733126 },
            ["Continent"] = { ["x"] = 0.478968, ["y"] = 0.318099 },
            ["Zone"]      = { ["x"] = 0.601966, ["y"] = 0.186614 },
        },
        ["Flights"]   = {
            ["2:442:805"] = 136.582,   	-- Undercity, Tirisfal
            ["2:615:691"] = 116.419,   	-- Hammerfall, Arathi
            ["2:671:703"] = 0,   	-- Revantusk Village, The Hinterlands
        },
        ["Costs"]     = {
            ["2:442:805"] = 330,  	-- Undercity, Tirisfal
            ["2:615:691"] = 530,  	-- Hammerfall, Arathi
            ["2:671:703"] = 730,  	-- Revantusk Village, The Hinterlands
        },
    },
    ["1:557:469"] = {
        ["Name"]      = "Crossroads, The Barrens",
        ["Zone"]      = FLIGHTMAP_BARRENS,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.557357, ["y"] = 0.469523 },
            ["Continent"] = { ["x"] = 0.534377, ["y"] = 0.539696 },
            ["Zone"]      = { ["x"] = 0.51526, ["y"] = 0.303878 },
        },
        ["Flights"]   = {
            ["1:409:626"] = 231.538,   	-- Zoram'gar Outpost, Ashenvale
            ["1:567:358"] = 164,   	-- Brackenwall Village, Dustwallow Marsh
            ["1:631:638"] = 171,   	-- Valormok, Azshara
            ["1:464:695"] = 243.547,   	-- Bloodvenom Post, Felwood
            ["1:442:306"] = 254.817,   	-- Camp Mojache, Feralas
            ["1:449:438"] = 174.225,   	-- Thunder Bluff, Mulgore
            ["1:628:556"] = 134.882,   	-- Orgrimmar, Durotar
            ["1:407:527"] = 144,   	-- Sun Rock Retreat, Stonetalon Mountains
            ["1:549:265"] = 189.179,   	-- Freewind Post, Thousand Needles
            ["1:554:582"] = 161.332,   	-- Splintertree Post, Ashenvale
            ["1:606:198"] = 310.98,   	-- Gadgetzan, Tanaris
            ["1:528:389"] = 91.842,   	-- Camp Taurajo, The Barrens
        },
        ["Costs"]     = {
            ["1:409:626"] = 330,  	-- Zoram'gar Outpost, Ashenvale
            ["1:567:358"] = 630,  	-- Brackenwall Village, Dustwallow Marsh
            ["1:631:638"] = 830,  	-- Valormok, Azshara
            ["1:464:695"] = 930,  	-- Bloodvenom Post, Felwood
            ["1:442:306"] = 730,  	-- Camp Mojache, Feralas
            ["1:449:438"] = 110,  	-- Thunder Bluff, Mulgore
            ["1:628:556"] = 110,  	-- Orgrimmar, Durotar
            ["1:407:527"] = 210,  	-- Sun Rock Retreat, Stonetalon Mountains
            ["1:549:265"] = 430,  	-- Freewind Post, Thousand Needles
            ["1:554:582"] = 530,  	-- Splintertree Post, Ashenvale
            ["1:606:198"] = 730,  	-- Gadgetzan, Tanaris
            ["1:528:389"] = 110,  	-- Camp Taurajo, The Barrens
        },
    },
    ["1:567:358"] = {
        ["Name"]      = "Brackenwall Village, Dustwallow Marsh",
        ["Zone"]      = FLIGHTMAP_DUSTWALLOW,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.567468, ["y"] = 0.358365 },
            ["Continent"] = { ["x"] = 0.540997, ["y"] = 0.650054 },
            ["Zone"]      = { ["x"] = 0.355619, ["y"] = 0.31848 },
        },
        ["Flights"]   = {
            ["1:628:556"] = 229.681,   	-- Orgrimmar, Durotar
            ["1:449:438"] = 231.025,    -- Thunder Bluff, Mulgore
            ["1:557:469"] = 164.653,   	-- Crossroads, The Barrens
            ["1:606:198"] = 0,          -- Gadgetzan, Tanaris
        },
        ["Costs"]     = {
            ["1:628:556"] = 630,  	-- Orgrimmar, Durotar
            ["1:449:438"] = 630,  	-- Thunder Bluff, Mulgore
            ["1:557:469"] = 630,  	-- Crossroads, The Barrens
            ["1:606:198"] = 730,  	-- Gadgetzan, Tanaris
        },
    },
    ["1:416:207"] = {
        ["Name"]      = "Cenarion Hold, Silithus",
        ["Zone"]      = FLIGHTMAP_SILITHUS,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.416321, ["y"] = 0.207831 },
            ["Continent"] = { ["x"] = 0.440948, ["y"] = 0.799361 },
            ["Zone"]      = { ["x"] = 0.487380, ["y"] = 0.367060 },
        },
        ["Flights"]   = {
            ["1:606:198"] = 247.125,   	-- Gadgetzan, Tanaris
        },
        ["Costs"]     = {
            ["1:606:198"] = 730,        -- Gadgetzan, Tanaris
        },
    },
    ["2:448:163"] = {
        ["Name"]      = "Grom'gol, Stranglethorn",
        ["Zone"]      = FLIGHTMAP_STRANGLETHORN,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.448259, ["y"] = 0.163592 },
            ["Continent"] = { ["x"] = 0.450412, ["y"] = 0.847288 },
            ["Zone"]      = { ["x"] = 0.325219, ["y"] = 0.293269 },
        },
        ["Flights"]   = {
            ["2:605:253"] = 189.025,   	-- Stonard, Swamp of Sorrows
            ["2:554:428"] = 315.12,   	-- Kargath, Badlands
            ["2:431:70"] = 82.982,   	-- Booty Bay, Stranglethorn
        },
        ["Costs"]     = {
            ["2:605:253"] = 630,  	-- Stonard, Swamp of Sorrows
            ["2:554:428"] = 630,  	-- Kargath, Badlands
            ["2:431:70"] = 630,  	-- Booty Bay, Stranglethorn
        },
    },
    ["2:615:691"] = {
        ["Name"]      = "Hammerfall, Arathi",
        ["Zone"]      = FLIGHTMAP_ARATHI,
        ["Continent"] = 2,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.615401, ["y"] = 0.691091 },
            ["Continent"] = { ["x"] = 0.55389, ["y"] = 0.357226 },
            ["Zone"]      = { ["x"] = 0.730618, ["y"] = 0.326232 },
        },
        ["Flights"]   = {
            ["2:554:428"] = 260.779,   	-- Kargath, Badlands
            ["2:494:733"] = 118.411,   	-- Tarren Mill, Hillsbrad
            ["2:442:805"] = 257.233,   	-- Undercity, Tirisfal
        },
        ["Costs"]     = {
            ["2:554:428"] = 630,  	-- Kargath, Badlands
            ["2:494:733"] = 330,  	-- Tarren Mill, Hillsbrad
            ["2:442:805"] = 530,  	-- Undercity, Tirisfal
        },
    },
    ["1:549:807"] = {
        ["Name"]      = "Nighthaven, Moonglade",
        ["Zone"]      = FLIGHTMAP_MOONGLADE,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.54947, ["y"] = 0.80763 },
            ["Continent"] = { ["x"] = 0.529119, ["y"] = 0.204321 },
            ["Zone"]      = { ["x"] = 0.443451, ["y"] = 0.457528 },
        },
        ["Flights"]   = {
            ["1:449:438"] = 0,   	-- Thunder Bluff, Mulgore
        },
        ["Costs"]     = {
            ["1:449:438"] = 0,  	-- Thunder Bluff, Mulgore
        },
    },
    ["1:409:626"] = {
        ["Name"]      = "Zoram'gar Outpost, Ashenvale",
        ["Zone"]      = FLIGHTMAP_ASHENVALE,
        ["Continent"] = 1,
        ["Location"]  = {
            ["Taxi"]      = { ["x"] = 0.409738, ["y"] = 0.626323 },
            ["Continent"] = { ["x"] = 0.436687, ["y"] = 0.38425 },
            ["Zone"]      = { ["x"] = 0.121975, ["y"] = 0.338188 },
        },
        ["Flights"]   = {
            ["1:557:469"] = 230.267,   	-- Crossroads, The Barrens
            ["1:554:582"] = 169.587,   	-- Splintertree Post, Ashenvale
        },
        ["Costs"]     = {
            ["1:557:469"] = 110,  	-- Crossroads, The Barrens
            ["1:554:582"] = 530,  	-- Splintertree Post, Ashenvale
        },
    },
};

-- Provided by Thorarin
FLIGHTMAP_ALLIANCE_FLIGHTS = {
        ["1:418:209"] = {
                ["Name"] = "Cenarion Hold, Silithus",
                ["Zone"] = FLIGHTMAP_SILITHUS,
                ["Continent"] = 1,
                ["Location"] = {
                        ["Taxi"]      = { ["x"] = 0.418980, ["y"] = 0.209867 },
                        ["Continent"] = { ["x"] = 0.442699, ["y"] = 0.797194 },
                        ["Zone"]      = { ["x"] = 0.505879, ["y"] = 0.344175 },
                },
                ["Flights"] = {
                        ["1:604:190"] = 191.037,        -- Gadgetzan, anaris
                },
                ["Costs"] = {
                        ["1:604:190"] = 730,            -- Gadgetzan, anaris
                },
        },
	["1:313:307"] = {
		["Flights"] = {
			["1:427:748"] = 471.486,
			["1:396:493"] = 227.866,
			["1:482:303"] = 170.654,
		},
		["Name"] = "Feathermoon, Feralas",
		["Zone"] = FLIGHTMAP_FERALAS,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.373022, ["y"] = 0.699925 },
			["Taxi"]      = { ["x"] = 0.313531, ["y"] = 0.307979 },
			["Zone"]      = { ["x"] = 0.302476, ["y"] = 0.432695 },
		},
		["Costs"] = {
			["1:427:748"] = 730,
			["1:396:493"] = 730,
			["1:482:303"] = 430,
		},
	},
	["1:416:842"] = {
		["Flights"] = {
			["1:427:748"] = 90.106,
		},
		["Name"] = "Rut'theran Village, Teldrassil",
		["Zone"] = FLIGHTMAP_TELDRASSIL,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.440912, ["y"] = 0.169434 },
			["Taxi"]      = { ["x"] = 0.416144, ["y"] = 0.842793 },
			["Zone"]      = { ["x"] = 0.583983, ["y"] = 0.939404 },
		},
		["Costs"] = {
			["1:427:748"] = 0,
		},
	},
	["1:482:303"] = {
		["Flights"] = {
			["1:636:330"] = 162.201,
			["1:313:307"] = 168.917,
			["1:604:190"] = 171.48,
		},
		["Name"] = "Thalanaar, Feralas",
		["Zone"] = FLIGHTMAP_FERALAS,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.484853, ["y"] = 0.704832 },
			["Taxi"]      = { ["x"] = 0.482576, ["y"] = 0.303127 },
			["Zone"]      = { ["x"] = 0.894612, ["y"] = 0.458679 },
		},
		["Costs"] = {
			["1:636:330"] = 730,
			["1:313:307"] = 630,
			["1:604:190"] = 730,
		},
	},
	["2:570:676"] = {
		["Flights"] = {
			["2:589:484"] = 172.578,
			["2:478:700"] = 81.865,
			["2:507:511"] = 278.969,
			["2:490:559"] = 127.312,
			["2:546:746"] = 73.103,
		},
		["Name"] = "Refuge Pointe, Arathi",
		["Zone"] = FLIGHTMAP_ARATHI,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.525999, ["y"] = 0.371044 },
			["Taxi"]      = { ["x"] = 0.570359, ["y"] = 0.676216 },
			["Zone"]      = { ["x"] = 0.457901, ["y"] = 0.461332 },
		},
		["Costs"] = {
			["2:589:484"] = 110,
			["2:478:700"] = 330,
			["2:507:511"] = 530,
			["2:490:559"] = 330,
			["2:546:746"] = 730,
		},
	},
	["1:610:599"] = {
		["Flights"] = {
			["1:427:748"] = 306.578,
			["1:530:742"] = 286.023,
		},
		["Name"] = "Talrendis Point, Azshara",
		["Zone"] = FLIGHTMAP_AZSHARA,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.56926, ["y"] = 0.410965 },
			["Taxi"]      = { ["x"] = 0.610477, ["y"] = 0.599073 },
			["Zone"]      = { ["x"] = 0.119307, ["y"] = 0.776057 },
		},
		["Costs"] = {
			["1:427:748"] = 730,
			["1:530:742"] = 730,
		},
	},
	["1:552:794"] = {
		["Flights"] = {
			["1:427:748"] = 146.66,
			["1:645:767"] = 133.588,
		},
		["Name"] = "Moonglade",
		["Zone"] = FLIGHTMAP_MOONGLADE,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.531431, ["y"] = 0.217861 },
			["Taxi"]      = { ["x"] = 0.552823, ["y"] = 0.793992 },
			["Zone"]      = { ["x"] = 0.480302, ["y"] = 0.673299 },
		},
		["Costs"] = {
			["1:427:748"] = 830,
			["1:645:767"] = 1020,
		},
	},
	["1:390:597"] = {
		["Flights"] = {
			["1:427:748"] = 181.969,
		},
		["Name"] = "Stonetalon Peak, Stonetalon Mountains",
		["Zone"] = FLIGHTMAP_STONETALON,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.423968, ["y"] = 0.412391 },
			["Taxi"]      = { ["x"] = 0.390646, ["y"] = 0.597828 },
			["Zone"]      = { ["x"] = 0.364744, ["y"] = 0.0718715 },
		},
		["Costs"] = {
			["1:427:748"] = 330,
		},
	},
	["2:478:700"] = {
		["Flights"] = {
			["2:546:746"] = 72.843,
			["2:520:775"] = 88.07,
			["2:507:511"] = 207,
			["2:490:559"] = 107.183,
			["2:570:676"] = 76.14,
		},
		["Name"] = "Southshore, Hillsbrad",
		["Zone"] = FLIGHTMAP_HILLSBRAD,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.469121, ["y"] = 0.348598 },
			["Taxi"]      = { ["x"] = 0.47862, ["y"] = 0.700487 },
			["Zone"]      = { ["x"] = 0.493652, ["y"] = 0.522103 },
		},
		["Costs"] = {
			["2:546:746"] = 730,
			["2:520:775"] = 830,
			["2:507:511"] = 330,
			["2:490:559"] = 330,
			["2:570:676"] = 530,
		},
	},
	["2:557:300"] = {
		["Flights"] = {
			["2:512:250"] = 61.859,
			["2:407:245"] = 135.389,
			["2:432:327"] = 115,
		},
		["Name"] = "Lakeshire, Redridge",
		["Zone"] = FLIGHTMAP_REDRIDGE,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.518128, ["y"] = 0.720186 },
			["Taxi"]      = { ["x"] = 0.557343, ["y"] = 0.300541 },
			["Zone"]      = { ["x"] = 0.307354, ["y"] = 0.593072 },
		},
		["Costs"] = {
			["2:512:250"] = 330,
			["2:407:245"] = 110,
			["2:432:327"] = 210,
		},
	},
	["1:636:330"] = {
		["Flights"] = {
			["1:396:493"] = 334.861,
			["1:482:303"] = 162.129,
			["1:427:748"] = 718.213,
			["1:604:190"] = 158.968,
		},
		["Name"] = "Theramore, Dustwallow Marsh",
		["Zone"] = FLIGHTMAP_DUSTWALLOW,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.586515, ["y"] = 0.677733 },
			["Taxi"]      = { ["x"] = 0.636261, ["y"] = 0.330511 },
			["Zone"]      = { ["x"] = 0.674672, ["y"] = 0.512493 },
		},
		["Costs"] = {
			["1:427:748"] = 630,
			["1:482:303"] = 430,
			["1:396:493"] = 530,
			["1:604:190"] = 730,
		},
	},
	["2:699:837"] = {
		["Flights"] = {
			["2:546:746"] = 175.257,
		},
		["Name"] = "Light's Hope Chapel, Eastern Plaguelands",
		["Zone"] = FLIGHTMAP_EASTERNPLAGUE,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.60636, ["y"] = 0.221464 },
			["Taxi"]      = { ["x"] = 0.699995, ["y"] = 0.837321 },
			["Zone"]      = { ["x"] = 0.815946, ["y"] = 0.592893 },
		},
		["Costs"] = {
			["2:546:746"] = 730,
		},
	},
	["2:507:511"] = {
		["Flights"] = {
			["2:589:484"] = 103.018,
			["2:432:327"] = 215.711,
			["2:508:432"] = 88.681,
			["2:490:559"] = 130.653,
			["2:570:676"] = 258.269,
			["2:546:746"] = 307.166,
			["2:478:700"] = 266,
		},
		["Name"] = "Ironforge, Dun Morogh",
		["Zone"] = FLIGHTMAP_IRONFORGE,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.487331, ["y"] = 0.523615 },
			["Taxi"]      = { ["x"] = 0.50798, ["y"] = 0.511915 },
			["Zone"]      = { ["x"] = 0.557052, ["y"] = 0.476917 },
		},
		["Costs"] = {
			["2:589:484"] = 110,
			["2:478:700"] = 330,
			["2:508:432"] = 830,
			["2:490:559"] = 330,
			["2:570:676"] = 530,
			["2:432:327"] = 50,
			["2:546:746"] = 730,
		},
	},
	["1:604:190"] = {
		["Flights"] = {
			["1:636:330"] = 158.465,
			["1:482:303"] = 174.262,
                        ["1:418:209"] = 199.821,
		},
		["Name"] = "Gadgetzan, Tanaris",
		["Zone"] = FLIGHTMAP_TANARIS,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.565253, ["y"] = 0.816195 },
			["Taxi"]      = { ["x"] = 0.604133, ["y"] = 0.19088 },
			["Zone"]      = { ["x"] = 0.509542, ["y"] = 0.293254 },
		},
		["Costs"] = {
			["1:636:330"] = 630,
			["1:482:303"] = 430,
                        ["1:418:209"] = 1070,
		},
	},
	["2:580:349"] = {
		["Flights"] = {
			["2:612:223"] = 250.819,
			["2:508:432"] = 104.499,
		},
		["Name"] = "Morgan's Vigil, Burning Steppes",
		["Zone"] = FLIGHTMAP_BURNINGSTEPPE,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.532341, ["y"] = 0.674627 },
			["Taxi"]      = { ["x"] = 0.580601, ["y"] = 0.349378 },
			["Zone"]      = { ["x"] = 0.843818, ["y"] = 0.683045 },
		},
		["Costs"] = {
			["2:612:223"] = 830,
			["2:508:432"] = 830,
		},
	},
	["2:589:484"] = {
		["Flights"] = {
			["2:490:559"] = 152,
			["2:570:676"] = 165.29,
			["2:507:511"] = 117.773,
		},
		["Name"] = "Thelsamar, Loch Modan",
		["Zone"] = FLIGHTMAP_LOCHMODAN,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.537786, ["y"] = 0.549228 },
			["Taxi"]      = { ["x"] = 0.589393, ["y"] = 0.484383 },
			["Zone"]      = { ["x"] = 0.33943, ["y"] = 0.507947 },
		},
		["Costs"] = {
			["2:490:559"] = 330,
			["2:570:676"] = 530,
			["2:507:511"] = 110,
		},
	},
	["2:432:327"] = {
		["Flights"] = {
			["2:407:245"] = 77.299,
			["2:507:511"] = 262.656,
			["2:433:69"] = 245,
			["2:612:223"] = 175.057,
			["2:512:250"] = 117.236,
			["2:557:300"] = 112.726,
		},
		["Name"] = "Stormwind, Elwynn",
		["Zone"] = FLIGHTMAP_STORMWIND,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.440659, ["y"] = 0.694733 },
			["Taxi"]      = { ["x"] = 0.432504, ["y"] = 0.327542 },
			["Zone"]      = { ["x"] = 0.663639, ["y"] = 0.622032 },
		},
		["Costs"] = {
			["2:407:245"] = 110,
			["2:557:300"] = 210,
			["2:433:69"] = 630,
			["2:612:223"] = 830,
			["2:512:250"] = 330,
			["2:507:511"] = 50,
		},
	},
	["1:462:603"] = {
		["Flights"] = {
			["1:427:748"] = 151.597,
		},
		["Name"] = "Astranaar, Ashenvale",
		["Zone"] = FLIGHTMAP_ASHENVALE,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.471421, ["y"] = 0.406474 },
			["Taxi"]      = { ["x"] = 0.462582, ["y"] = 0.603835 },
			["Zone"]      = { ["x"] = 0.343628, ["y"] = 0.480031 },
		},
		["Costs"] = {
			["1:427:748"] = 330,
		},
	},
	["2:490:559"] = {
		["Flights"] = {
			["2:589:484"] = 164.479,
			["2:478:700"] = 130.487,
			["2:507:511"] = 90.02,
			["2:570:676"] = 114.526,
		},
		["Name"] = "Menethil Harbor, Wetlands",
		["Zone"] = FLIGHTMAP_WETLANDS,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.476799, ["y"] = 0.479782 },
			["Taxi"]      = { ["x"] = 0.490907, ["y"] = 0.559148 },
			["Zone"]      = { ["x"] = 0.0952036, ["y"] = 0.596587 },
		},
		["Costs"] = {
			["2:589:484"] = 110,
			["2:478:700"] = 330,
			["2:507:511"] = 330,
			["2:570:676"] = 530,
		},
	},
	["1:396:493"] = {
		["Flights"] = {
			["1:636:330"] = 310.32,
			["1:427:748"] = 284.542,
			["1:313:307"] = 230.16,
		},
		["Name"] = "Nijel's Point, Desolace",
		["Zone"] = FLIGHTMAP_DESOLACE,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.427741, ["y"] = 0.516062 },
			["Taxi"]      = { ["x"] = 0.396228, ["y"] = 0.493395 },
			["Zone"]      = { ["x"] = 0.646713, ["y"] = 0.104354 },
		},
		["Costs"] = {
			["1:636:330"] = 530,
			["1:427:748"] = 530,
			["1:313:307"] = 730,
		},
	},
	["2:512:250"] = {
		["Flights"] = {
			["2:407:245"] = 97.66,
			["2:432:327"] = 90.131,
			["2:557:300"] = 60.827,
			["2:433:69"] = 173.46,
			["2:612:223"] = 98.483,
		},
		["Name"] = "Darkshire, Duskwood",
		["Zone"] = FLIGHTMAP_DUSKWOOD,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.490338, ["y"] = 0.766227 },
			["Taxi"]      = { ["x"] = 0.512853, ["y"] = 0.250701 },
			["Zone"]      = { ["x"] = 0.775258, ["y"] = 0.443037 },
		},
		["Costs"] = {
			["2:407:245"] = 110,
			["2:432:327"] = 330,
			["2:557:300"] = 210,
			["2:433:69"] = 630,
			["2:612:223"] = 830,
		},
	},
	["1:645:767"] = {
		["Flights"] = {
			["1:552:794"] = 133.276,
			["1:530:742"] = 124.126,
		},
		["Name"] = "Everlook, Winterspring",
		["Zone"] = FLIGHTMAP_WINTERSPRING,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.59264, ["y"] = 0.244593 },
			["Taxi"]      = { ["x"] = 0.64554, ["y"] = 0.767019 },
			["Zone"]      = { ["x"] = 0.623348, ["y"] = 0.366358 },
		},
		["Costs"] = {
			["1:552:794"] = 830,
			["1:530:742"] = 730,
		},
	},
	["2:407:245"] = {
		["Flights"] = {
			["2:432:327"] = 82.72,
			["2:557:300"] = 131.25,
			["2:433:69"] = 187.855,
			["2:512:250"] = 98.096,
		},
		["Name"] = "Sentinel Hill, Westfall",
		["Zone"] = FLIGHTMAP_WESTFALL,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.425095, ["y"] = 0.771117 },
			["Taxi"]      = { ["x"] = 0.40741, ["y"] = 0.245498 },
			["Zone"]      = { ["x"] = 0.56571, ["y"] = 0.526667 },
		},
		["Costs"] = {
			["2:432:327"] = 110,
			["2:557:300"] = 210,
			["2:433:69"] = 630,
			["2:512:250"] = 330,
		},
	},
	["2:546:746"] = {
		["Flights"] = {
			["2:478:700"] = 68.312,
			["2:507:511"] = 257.422,
			["2:699:837"] = 174.485,
			["2:570:676"] = 74.786,
		},
		["Name"] = "Aerie Peak, The Hinterlands",
		["Zone"] = FLIGHTMAP_HINTERLANDS,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.511443, ["y"] = 0.306089 },
			["Taxi"]      = { ["x"] = 0.546853, ["y"] = 0.746146 },
			["Zone"]      = { ["x"] = 0.111106, ["y"] = 0.46088 },
		},
		["Costs"] = {
			["2:478:700"] = 330,
			["2:507:511"] = 730,
			["2:570:676"] = 530,
			["2:699:837"] = 1020,
		},
	},
	["2:520:775"] = {
		["Flights"] = {
			["2:478:700"] = 87.715,
		},
		["Name"] = "Chillwind Camp, Western Plaguelands",
		["Zone"] = FLIGHTMAP_WESTERNPLAGUE,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.495184, ["y"] = 0.27856 },
			["Taxi"]      = { ["x"] = 0.520581, ["y"] = 0.775855 },
			["Zone"]      = { ["x"] = 0.429553, ["y"] = 0.850087 },
		},
		["Costs"] = {
			["2:478:700"] = 330,
		},
	},
	["1:427:748"] = {
		["Flights"] = {
			["1:313:307"] = 476.326,
			["1:416:842"] = 85.418,
			["1:610:599"] = 304.109,
			["1:396:493"] = 286.348,
			["1:462:603"] = 180.638,
			["1:390:597"] = 186.054,
			["1:636:330"] = 692.73,
			["1:530:742"] = 188.888,
			["1:552:794"] = 149.985,
		},
		["Name"] = "Auberdine, Darkshore",
		["Zone"] = FLIGHTMAP_DARKSHORE,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.448539, ["y"] = 0.263223 },
			["Taxi"]      = { ["x"] = 0.427786, ["y"] = 0.748208 },
			["Zone"]      = { ["x"] = 0.363542, ["y"] = 0.455986 },
		},
		["Costs"] = {
			["1:313:307"] = 730,
			["1:416:842"] = 0,
			["1:610:599"] = 730,
			["1:396:493"] = 530,
			["1:462:603"] = 330,
			["1:390:597"] = 330,
			["1:636:330"] = 630,
			["1:552:794"] = 830,
			["1:530:742"] = 730,
		},
	},
	["2:433:69"] = {
		["Flights"] = {
			["2:512:250"] = 176.653,
			["2:407:245"] = 183.07,
			["2:432:327"] = 222.092,
		},
		["Name"] = "Booty Bay, Stranglethorn",
		["Zone"] = FLIGHTMAP_STRANGLETHORN,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.441329, ["y"] = 0.935091 },
			["Taxi"]      = { ["x"] = 0.433677, ["y"] = 0.0691357 },
			["Zone"]      = { ["x"] = 0.275115, ["y"] = 0.777602 },
		},
		["Costs"] = {
			["2:512:250"] = 330,
			["2:407:245"] = 530,
			["2:432:327"] = 630,
		},
	},
	["1:530:742"] = {
		["Flights"] = {
			["1:427:748"] = 188.315,
			["1:610:599"] = 285.859,
			["1:645:767"] = 124.187,
		},
		["Name"] = "Talonbranch Glade, Felwood",
		["Zone"] = FLIGHTMAP_FELWOOD,
		["Continent"] = 1,
		["Location"] = {
			["Continent"] = { ["x"] = 0.516755, ["y"] = 0.268729 },
			["Taxi"]      = { ["x"] = 0.530809, ["y"] = 0.742692 },
			["Zone"]      = { ["x"] = 0.624619, ["y"] = 0.241621 },
		},
		["Costs"] = {
			["1:427:748"] = 730,
			["1:610:599"] = 730,
			["1:645:767"] = 1020,
		},
	},
	["2:508:432"] = {
		["Flights"] = {
			["2:580:349"] = 103.571,
			["2:507:511"] = 91.911,
		},
		["Name"] = "Thorium Point, Searing Gorge",
		["Zone"] = FLIGHTMAP_SEARINGGORGE,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.487759, ["y"] = 0.597613 },
			["Taxi"]      = { ["x"] = 0.508569, ["y"] = 0.43251 },
			["Zone"]      = { ["x"] = 0.379221, ["y"] = 0.307452 },
		},
		["Costs"] = {
			["2:580:349"] = 830,
			["2:507:511"] = 830,
		},
	},
	["2:612:223"] = {
		["Flights"] = {
			["2:512:250"] = 93.468,
			["2:432:327"] = 182.299,
			["2:580:349"] = 237.981,
		},
		["Name"] = "Nethergarde Keep, Blasted Lands",
		["Zone"] = FLIGHTMAP_BLASTEDLANDS,
		["Continent"] = 2,
		["Location"] = {
			["Continent"] = { ["x"] = 0.552203, ["y"] = 0.791679 },
			["Taxi"]      = { ["x"] = 0.612595, ["y"] = 0.223322 },
			["Zone"]      = { ["x"] = 0.655472, ["y"] = 0.243918 },
		},
		["Costs"] = {
			["2:512:250"] = 330,
			["2:432:327"] = 830,
			["2:580:349"] = 830,
		},
	},
};

FlightMap = {
    ["Opts"]             = FLIGHTMAP_DEFAULT_OPTS,
    ["Knowledge"]        = {},
};

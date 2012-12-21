
YA_MAPS = {
    ["Eastern Kingdoms"] = {"Azeroth"},
    ["Kalimdor"] = {"Kalimdor"},
    --
};

Yatlas_WorldMapIds = {
    ["Azeroth"] = 2,
    ["Kalimdor"] = 1
};


-- These MUST MATCH the values returned by GetMapZones()
-- (These are the id versions)
Yatlas_ZoneIds = {
    ["Azeroth"] =   {
    	1, 3, 4, 8, 10, 11, 12, 28, 33, 36, 38, 40, 41, 44, 45, 46,
        47, 51, 85, 130, 139, 267, 1497, 1519, 1537
    },
    ["Kalimdor"] =  {
    	14, 15, 16, 17, 141, 148, 215, 331, 357, 361, 400, 405,
	406, 440, 490, 493, 618, 1377, 1637, 1638, 1657
    },	
}

Yatlas_PaperZoneNames = {};     -- we don't fill this in by hand 
Yatlas_Landmarks = {};          -- this is filled in automatically too

-- Adjustment for dropdown menu
Yatlas_mapareas_adjust = {
    [148] = {-1,0},         -- Darkshore
    [361] = {-0.95,0},      -- Felwood
    [357] = {1.2, .1},      -- Feralas
    [618] = {0.7, -0.5},    -- Winterspring
    
    [36] = {-0.3, 0},       -- Alterac
    [12] = {0, 0.4},        -- Elwynn Forest
    [267] = {0.3, -0.3},    -- Hillsbrad
    [33] = {-1.4, -1},      -- STV
    [8] = {0.4, 0},         -- Swamp of Sorrows
    [40] = {-0.1, 0},       -- Westfall
    [11] = {-0.7, -0.9}     -- Wetlands
};

-- Instances (entrances)
Yatlas_instances = {
    ["Kalimdor"] = {
        {"Ahn'Qiraj",           1526, -8132},
        {"Blackfathom Deeps",   888, 4138},
        {"Dire Maul",           1341, -4367},
        {"Maraudon",            2932, -1415},
        {"Onyxia's Lair",       -3730, -4712},
        {"Ragefire Chasm",      -4416.2, 1818.4},
        {"Razorfen Downs",      -2336, -4721},
        {"Razorfen Kraul",      -1606, -4455},
        {"Wailing Caverns",     -2027, -796},
        {"Zul'Farrak",          -2904, -6665},
    },
    ["Azeroth"] = {
        {"Blackrock Depths",    -919, -7179},
        {"Blackrock Spire",     -1223, -7529},
        {"Gnomeregan",          933, -5161},
   --     {"Blackwing Lair", -1217, -7658},
   --     {"Molten Core", -1038, -7508},
        {"Scarlet Monestary",   -867, 2916},
        {"Scholomance",         -2567, 1275},
        {"Shadowfang Keep",     1585, -229},
        {"Stratholme",          -3375, 3381},
        {"Stratholme (Service Entrance)", -4033, 3187},
        {"The Deadmines",       1512, -11081},
        {"The Temple of Atal'Hakkar", -3826, -10414},
        {"Zul'Gurub",           -1250, -11915},

    }
};

Yatlas_towns2 = {
    ["Kalimdor"] = {
        -- Ashenvale --
        {"Maestra's Post",          154, 3240},
        {"The Talondeep Path",          -718, 1913},
        {"Raynewood Retreat",       -1881, 2707},
        {"Satyrnaar",               -2981.2, 2694},
        {"Warsong Lumber Camp",     -3545.8, 2438},
        {"Zoram'Gar Outpost",       1012.5, 3353},
        -- Azshara --
        {"Valormok",                -4400, 3600},
        {"Talrendis Point",         -3975, 2693},
        {"Ruins of Eldarath",       -5150, 3542},
        -- Darkshore --
        {"Ruins of Mathystra",      -845, 7368},
        {"Bashal'Aran",             -22.9, 6695},
        {"Ameth'Aran",              200, 5702},
        {"Grove of the Ancients",   102, 4993},
        -- Desolace --
        {"Sargeron",                762, -230},
        {"Thunder Axe Fortress",    1762, -346},
        {"Kodo Graveyard",          1929, -1303},
        {"Ghostwalker Post",        1752,  -1238},
        {"Mannoroc Coven",          1902, -1905}, 
        {"Valley of Spears",        2793, -1273},
        {"Gelkis Village",          2558, -2184},
        {"Magram Village",          1045, -1807},
        {"Kolkar Village",          954, -948},
        -- Durotar --
        {"Razor Hill",              -4741.6, 309},
        {"The Den",                 -4218, -609},
        {"Sen'jin Village",         -4912, -823},
        -- Duskwallow --
        {"Brackenwall Village",     -2877, -3122},
        {"Stonemaul Ruins",         -3295, -4329},
        -- Felwood --
        {"Felpaw Village",          -1935, 6785},
        {"Jaedenar",                -551, 4329},
        {"Emerald Sanctuary",       -1310, 4008},
        {"Talonbranch Glade",       -1935, 6173},
        -- Feralas --
        {"Ruins of Isildien",       1376, -5686},
        {"Gordunni Outpost",        155, -3730},
        {"Grimtotem Compound",      824, -4507},
        -- Moonglade --
        {"Nighthaven",              -2497, 7890},
        {"Stormrage Barrow Dens",   -2947, 7565},
        {"Shrine of Remulos",       -2214, 7846},
        -- Mulgore --
        {"Red Rocks",               -1137.5, -935},
        {"Bloodhoof Village",       -381.2, -2318},
        {"Brambleblade Ravine",     -1181, -3000},
        {"Camp Narache",            -254, -2904},
        -- Silithus --
        {"Staghelm Point",          100, -6548},
        {"Valor's Rest",            -304, -6430},
        {"Southwind Village",       364, -7196},
        {"Bronzebeard Encampment",  1122, -8036},
        -- Stonetalon Mountains --   
        {"Malaka'jin",              -327, -196},
        {"The Talon Den",           1814, 2409},
        {"The Talondeep Path",      -579, 1544},
        -- Tanaris --
        {"Steamwheedle Port",       -4864, -6937},
        {"Uldum",                   -2785, -9656},
        {"Dunemaul Compound",       -3050, -8435},
        {"Sandsorrow Warch",        -2952, -7162},
        -- Teldrassil --
        {"Aldrassil",               818, 10480},
        {"The Oracle Glade",        1918, 10684},
        {"Dolanaar",                968, 9846},
        {"Starbreeze Village",      420, 9871},
        {"Rut'Theran Village",      991, 8709},
        -- The Barrens --
        {"The Sludge Fen",          -3079, 1044},
        {"Northwatch Hold",         -3641, -2098},
        -- Thousand Needles --
        {"The Great Lift",          -1849, -4662},
        {"Mirage Raceway",          -3914, -6220},
        {"Roguefeather Den",        -1614, -5487},
        {"The Weathered Nook",      -2797, -5208},
        {"Ironstone Camp",          -3422, -5825},
        {"Whitereach Post",         -1366, -4918},
        {"Darkcloud Pinnacle",      -1931, -5087},
        -- Un'goro Crater --
        {"Marshal's Refuge",        -1087, -6165},        
        {"Fungal Rock",             -1856, -6382},
        -- Winterspring --
        {"Owl Wing Thicket",        -4958, 5652},
        {"The Hidden Grove",        -4842, 7733},
        {"Starfall Village",        -3931, 7147},
        {"Winterfall Village",      -5129, 6764},
    },
    ["Azeroth"] = {
        -- Alterac --
        {"Strahnbrad",              -956, 679},
        {"Ruins of Alterac",        -310, 539},
        {"Dalaran",                 364, 266},
        {"Lordamere Internment Camp", 226, -95},
        -- Arathi Highlands --
        {"The Tower of Arathor",    -1500, -1777},
        {"Stromgarde",              -1800, -1631},
        {"Witherbark Village",      -3398, -1741},
        {"Faldir's Cove",           -2112, -2079},
        {"Refuge Pointe",           -2416, -1373},
        -- Badlands --
        {"Angor Fortress",          -3137, -6375},
        {"Dustbelch Grotto",        -2289, -7275},
        -- Blasted Lands --
        {"Nethergarde Keep",        -3431, -10991},
        {"The Dark Portal",         -3193, -11829},
        {"Dreadmaul Hold",          -2664, -108524},
        -- Burning Steppes --   
        {"Flame Crest",             -2193, -7480},
        {"Blackrock Stronghold",    -1439, -7701},
        -- Deadwind Pass --
        -- Dun Morogh --
        {"Anvilmar",                387, -6102},
        {"Kharanos",                -500, -5583},
        {"Brewnall Village",        302, -5360},
        -- Duskwood --
        {"Ravenhill",               327, -10735},
        -- Eastern Plaguelands --
        {"Terrorweb Tunnel",        -2772, 3034},
        {"Terrorweb Tunnel",        -2470, 2751},
        {"Light's Hope Chapel",     -5339, 2298},
        {"Tyr's Hand",              -5558, 1596},
        {"Darrowshire",             -3695, 1438},
        {"Corin's Crossing",        -4505, 2032},    
        -- Elwynn Forest --
        {"Northshire Abbey",        -172, -8878}, 
        {"Eastvale Logging Camp",   -1352, -9460},
        {"Goldshire",               68, -9458},
        {"Westbrook Garrison",      677, -9624},
        -- Hillsbrad Foothills
        {"Azurlode Mine",           196, -827},
        {"Durnholde Keep",          -1457, -456},
        {"Dun Garok",               -1218, -1292},
        {"Purgation Isle",          590, -1333},
        -- Loch Modan --
        {"The Farstrider Lodge",    -4270, -5655},
        -- Red Ridge Mountains --
        {"Tower of Ilgalar",        -3297, -9280},
        {"Stonewatch Keep",         -3052, -9380}, 
        -- Searing Gorge --
        {"Thorium Point",           -1153, -6504},
        -- Silverpine Forest --
        {"Ambermill",               791, -122},
        {"Pyrewood Village",        1556, -385},
        -- Strangethorn Vale --
        {"Mosh'Ogg Ogre Mound",     -1006, -12368},
        {"Venture Co. Base Camp",   -523, -11972},
        {"Gurubashi Arena",         278, -13204},
        -- Swamp of Sorrows --
        {"Fallow Sanctuary",        -3641, -9954},
        {"Misty Valley",            -2526, -10164},
        {"Stagalbog Cave",          -3745, -10795},
        -- The Hinterlands --
        {"Skulk Rock",              -3795, 393},
        {"Quel'Danil Lodge",        -2764, 239},
        {"The Altar of Zul",        -3454, -293},
        {"Jintha'Alor",             -3955, -468},
        -- Tirisfal Glades --
        {"Agamand Mills",           871, 2839},
        {"Deathknell",              1580, 1929},
        {"Brill",                   286, 2304},
        -- Western Plaguelands --
        {"Hearthglen",              1516, 2877},
        {"Ruins of Andorhal",       -1518,1383},
        {"Caer Darrow",             -2558, 1156},
        {"The Bulwark",             -762, 1745},
        {"Chillwind Camp",          -1441, 925},
        -- Westfall --
        {"Jangolode Mine",          1453, -9968},
        {"Gold Coast Quarry",       1915, -10416},
        {"Moonbrook",               1501, -11010},
        -- Wetlands --
        {"Dun Modr",                -2327, -2610},
        {"Dun Algaz",               -2369, -4198},
        {"Grim Batol",              -3429, -4006},        
    }

}

-- XXX USEME
Yatlas_Mobs = {
    -- two original outdoor raid bosses
    {"Lord Kazzak",         "Kalimdor", -2439, -12211},
    {"Azuregos",            "Azeroth", -5884, 2764},
    -- four dragons
    {"Dragons of Nightmare", "Azeroth", -4081, 624},
    {"Dragons of Nightmare", "Kalimdor", -3741, 3174},
    {"Dragons of Nightmare", "Azeroth", -421, -10441},
    {"Dragons of Nightmare", "Kalimdor", 1874, -2796},
};

-- 'blacklist' some of our 'graveyards'
function YA_BL_gy(cont, c) 
    for h,v in ipairs(Yatlas_graveyards[cont]) do
        if(v[1] == c[1] and v[2] == c[2]) then
            tremove(Yatlas_graveyards[cont], h);
            return;
        end
    end
end
YA_BL_gy("Azeroth", {-831.880981, -3518.520020});   -- AB
YA_BL_gy("Azeroth", {-1215.589966, -2531.750000});  -- AB
YA_BL_gy("Azeroth", {536.494995, -1085.719971});    -- AV
YA_BL_gy("Azeroth", {101.143997, -184.934006});     -- AV
YA_BL_gy("Azeroth", {-5687.000000, -515.000000});   -- Dun Morogh Extra
YA_BL_gy("Azeroth", {-9115.000000, 423.000000});    -- Stormwind Bogus
YA_BL_gy("Azeroth", {-9151.980469, 410.944000});    -- Stormwind Bogus
YA_BL_gy("Azeroth", {1822.609985, 214.673996});     -- Undercity Bogus
YA_BL_gy("Azeroth", {-5049.450195, -809.697021});   -- Ironforge extra
YA_BL_gy("Azeroth", {-13290.000000, 108.000000});   -- Gurubashi Arena Bogus
YA_BL_gy("Kalimdor", {1357.099976, -4412.009766});  -- Orgrimmar Bogus
YA_BL_gy("Kalimdor", {1459.170044, -1858.670044});  -- WSG
YA_BL_gy("Kalimdor", {1035.270020, -2104.280029});  -- WSG


--
-- Base prices for Auctioneer
-- Gathered by Norganna
--

function Auctioneer_BuildBaseData()
Auctioneer_BasePrices = {
	[25]={b=35,s=7,d=1542,c=AUCT_CLAS_WEAPON},  -- Worn Shortsword
	[35]={b=47,s=9,d=472,c=AUCT_CLAS_WEAPON},  -- Bent Staff
	[36]={b=38,s=7,d=5194,c=AUCT_CLAS_WEAPON},  -- Worn Mace
	[37]={b=38,s=7,d=14029,c=AUCT_CLAS_WEAPON},  -- Worn Axe
	[38]={b=1,s=1,d=9891,c=AUCT_CLAS_ARMOR},  -- Recruit's Shirt
	[39]={b=5,s=1,d=9892,c=AUCT_CLAS_ARMOR},  -- Recruit's Pants
	[40]={b=4,s=1,d=10141,c=AUCT_CLAS_ARMOR},  -- Recruit's Boots
	[43]={b=4,s=1,d=10272,c=AUCT_CLAS_ARMOR},  -- Squire's Boots
	[44]={b=4,s=1,d=9937,c=AUCT_CLAS_ARMOR},  -- Squire's Pants
	[45]={b=1,s=1,d=3265,c=AUCT_CLAS_ARMOR},  -- Squire's Shirt
	[47]={b=4,s=1,d=9915,c=AUCT_CLAS_ARMOR},  -- Footpad's Shoes
	[48]={b=4,s=1,d=9913,c=AUCT_CLAS_ARMOR},  -- Footpad's Pants
	[49]={b=1,s=1,d=9906,c=AUCT_CLAS_ARMOR},  -- Footpad's Shirt
	[51]={b=5,s=1,d=9946,c=AUCT_CLAS_ARMOR},  -- Neophyte's Boots
	[52]={b=5,s=1,d=9945,c=AUCT_CLAS_ARMOR},  -- Neophyte's Pants
	[53]={b=1,s=1,d=9944,c=AUCT_CLAS_ARMOR},  -- Neophyte's Shirt
	[55]={b=5,s=1,d=9929,c=AUCT_CLAS_ARMOR},  -- Apprentice's Boots
	[56]={b=5,s=1,d=12647,c=AUCT_CLAS_ARMOR},  -- Apprentice's Robe
	[57]={b=5,s=1,d=12645,c=AUCT_CLAS_ARMOR},  -- Acolyte's Robe
	[59]={b=5,s=1,d=3261,c=AUCT_CLAS_ARMOR},  -- Acolyte's Shoes
	[60]={b=60,s=12,d=16891,c=AUCT_CLAS_ARMOR},  -- Layered Tunic
	[61]={b=60,s=12,d=16953,c=AUCT_CLAS_ARMOR},  -- Dwarven Leather Pants
	[79]={b=52,s=10,d=16847,c=AUCT_CLAS_ARMOR},  -- Dwarven Cloth Britches
	[80]={b=35,s=7,d=16854,c=AUCT_CLAS_ARMOR},  -- Soft Fur-lined Shoes
	[85]={b=62,s=12,d=16883,c=AUCT_CLAS_ARMOR},  -- Dirty Leather Vest
	[117]={b=25,s=1,d=2473,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Tough Jerky
	[118]={b=20,s=5,d=15710,x=5,u=AUCT_TYPE_ALCHEM},  -- Minor Healing Potion
	[120]={b=4,s=1,d=10006,c=AUCT_CLAS_ARMOR},  -- Thug Pants
	[121]={b=4,s=1,d=10008,c=AUCT_CLAS_ARMOR},  -- Thug Boots
	[127]={b=1,s=1,d=9996,c=AUCT_CLAS_ARMOR},  -- Trapper's Shirt
	[128]={b=5,s=1,d=396,c=AUCT_CLAS_ARMOR},  -- Deprecated Tauren Trapper's Pants
	[129]={b=5,s=1,d=9977,c=AUCT_CLAS_ARMOR},  -- Rugged Trapper's Boots
	[139]={b=4,s=1,d=9988,c=AUCT_CLAS_ARMOR},  -- Brawler's Pants
	[140]={b=4,s=1,d=9992,c=AUCT_CLAS_ARMOR},  -- Brawler's Boots
	[147]={b=5,s=1,d=9975,c=AUCT_CLAS_ARMOR},  -- Rugged Trapper's Pants
	[148]={b=1,s=1,d=9976,c=AUCT_CLAS_ARMOR},  -- Rugged Trapper's Shirt
	[153]={b=5,s=1,d=10050,c=AUCT_CLAS_ARMOR},  -- Primitive Kilt
	[154]={b=1,s=1,d=10058,c=AUCT_CLAS_ARMOR},  -- Primitive Mantle
	[159]={b=25,s=1,d=18084,q=20,x=20,c=AUCT_CLAS_DRINK,u=AUCT_TYPE_COOK..", "..AUCT_TYPE_ENGINEER},  -- Refreshing Spring Water
	[182]={b=0,s=0,d=7038},  -- Garrick's Head
	[193]={b=48,s=9,d=16579,c=AUCT_CLAS_ARMOR},  -- Tattered Cloth Vest
	[194]={b=49,s=9,d=16580,c=AUCT_CLAS_ARMOR},  -- Tattered Cloth Pants
	[195]={b=36,s=7,d=16582,c=AUCT_CLAS_ARMOR},  -- Tattered Cloth Boots
	[200]={b=2270,s=454,d=16777,c=AUCT_CLAS_ARMOR},  -- Thick Cloth Vest
	[201]={b=2278,s=455,d=16778,c=AUCT_CLAS_ARMOR},  -- Thick Cloth Pants
	[202]={b=1714,s=342,d=16780,c=AUCT_CLAS_ARMOR},  -- Thick Cloth Shoes
	[203]={b=1147,s=229,d=16779,c=AUCT_CLAS_ARMOR},  -- Thick Cloth Gloves
	[209]={b=60,s=12,d=17140,c=AUCT_CLAS_ARMOR},  -- Dirty Leather Pants
	[210]={b=45,s=9,d=14444,c=AUCT_CLAS_ARMOR},  -- Dirty Leather Boots
	[236]={b=2795,s=559,d=14278,c=AUCT_CLAS_ARMOR},  -- Cured Leather Armor
	[237]={b=2805,s=561,d=14476,c=AUCT_CLAS_ARMOR},  -- Cured Leather Pants
	[238]={b=2112,s=422,d=14474,c=AUCT_CLAS_ARMOR},  -- Cured Leather Boots
	[239]={b=1413,s=282,d=14475,c=AUCT_CLAS_ARMOR},  -- Cured Leather Gloves
	[285]={b=3555,s=711,d=16101,c=AUCT_CLAS_ARMOR},  -- Scalemail Vest
	[286]={b=3229,s=645,d=10400,c=AUCT_CLAS_ARMOR},  -- Scalemail Pants
	[287]={b=2441,s=488,d=12745,c=AUCT_CLAS_ARMOR},  -- Scalemail Boots
	[414]={b=125,s=6,d=21904,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Dalaran Sharp
	[422]={b=500,s=25,d=6352,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Dwarven Mild
	[537]={b=350,s=87,d=6629,x=5},  -- Dull Frenzy Scale
	[555]={b=35,s=8,d=11206,x=10},  -- Rough Vulture Feathers
	[556]={b=425,s=106,d=6625,x=5},  -- Buzzard Beak
	[647]={b=350121,s=70024,d=20190,c=AUCT_CLAS_WEAPON},  -- Destiny
	[710]={b=361,s=72,d=16936,c=AUCT_CLAS_ARMOR},  -- Bracers of the People's Militia
	[711]={b=25,s=5,d=16581,c=AUCT_CLAS_ARMOR},  -- Tattered Cloth Gloves
	[714]={b=32,s=6,d=14445,c=AUCT_CLAS_ARMOR},  -- Dirty Leather Gloves
	[718]={b=1614,s=322,d=6986,c=AUCT_CLAS_ARMOR},  -- Scalemail Gloves
	[719]={b=23,s=4,d=16970,c=AUCT_CLAS_ARMOR},  -- Rabbit Handler Gloves
	[720]={b=5350,s=1070,d=2368,c=AUCT_CLAS_ARMOR},  -- Brawler Gloves
	[723]={b=60,s=15,d=7369,x=10,u=AUCT_TYPE_COOK},  -- Goretusk Liver
	[724]={b=100,s=25,d=6385,x=20,c=AUCT_CLAS_FOOD},  -- Goretusk Liver Pie
	[725]={b=0,s=0,d=6671,q=20,x=20},  -- Gnoll Paw
	[727]={b=1224,s=244,d=26577,c=AUCT_CLAS_WEAPON},  -- Notched Shortsword
	[728]={b=200,s=50,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Westfall Stew
	[729]={b=70,s=17,d=7407,x=10,u=AUCT_TYPE_COOK},  -- Stringy Vulture Meat
	[730]={b=65,s=16,d=7394,x=10,u=AUCT_TYPE_COOK},  -- Murloc Eye
	[731]={b=110,s=27,d=8802,x=10,u=AUCT_TYPE_COOK},  -- Goretusk Snout
	[732]={b=25,s=6,d=7395,x=10},  -- Okra
	[733]={b=400,s=100,d=6428,x=20,c=AUCT_CLAS_FOOD},  -- Westfall Stew
	[735]={b=0,s=0,d=7093},  -- Rolf and Malakai's Medallions
	[737]={b=0,s=0,d=926,c=AUCT_CLAS_POTION},  -- Holy Spring Water
	[738]={b=0,s=0,d=1297,q=20,x=20},  -- Sack of Barley
	[739]={b=0,s=0,d=11994,q=20,x=20},  -- Sack of Corn
	[740]={b=0,s=0,d=11998,q=20,x=20},  -- Sack of Rye
	[742]={b=0,s=0,d=928},  -- A Sycamore Branch
	[743]={b=0,s=0,d=929},  -- Bundle of Charred Oak
	[744]={b=40000,s=10000,d=18059,c=AUCT_CLAS_ARMOR},  -- Thunderbrew's Boot Flask
	[745]={b=0,s=0,d=1102,c=AUCT_CLAS_WRITTEN},  -- Marshal McBride's Documents
	[748]={b=0,s=0,d=1102,c=AUCT_CLAS_WRITTEN},  -- Stormwind Armor Marker
	[750]={b=0,s=0,d=1116,q=20,x=20},  -- Tough Wolf Meat
	[752]={b=0,s=0,d=1272,q=20,x=20},  -- Red Burlap Bandana
	[753]={b=19211,s=3842,d=20094,c=AUCT_CLAS_WEAPON},  -- Dragonmaw Shortsword
	[754]={b=117784,s=23556,d=20218,c=AUCT_CLAS_WEAPON},  -- Shortsword of Vengeance
	[755]={b=4,s=1,d=6677,q=5,x=5},  -- Melted Candle
	[756]={b=24818,s=4963,d=6264,c=AUCT_CLAS_WEAPON},  -- Tunnel Pick
	[763]={b=293,s=58,d=17007,c=AUCT_CLAS_ARMOR},  -- Ice-covered Bracers
	[765]={b=40,s=10,d=18088,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Silverleaf
	[766]={b=286,s=57,d=19621,c=AUCT_CLAS_WEAPON},  -- Flanged Mace
	[767]={b=504,s=100,d=20443,c=AUCT_CLAS_WEAPON},  -- Long Bo Staff
	[768]={b=567,s=113,d=5012,c=AUCT_CLAS_WEAPON},  -- Lumberjack Axe
	[769]={b=15,s=3,d=6348,x=10,u=AUCT_TYPE_COOK},  -- Chunk of Boar Meat
	[770]={b=1265,s=316,d=6630,x=10},  -- Pointy Crocolisk Tooth
	[771]={b=155,s=38,d=1225,x=5},  -- Chipped Boar Tusk
	[772]={b=0,s=0,d=7066,q=20,x=20},  -- Large Candle
	[773]={b=0,s=0,d=7137,q=20,x=20},  -- Gold Dust
	[774]={b=60,s=15,d=7353,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Malachite
	[776]={b=28826,s=5765,d=6452,c=AUCT_CLAS_WEAPON},  -- Vendetta
	[777]={b=86,s=21,d=959,x=10},  -- Prowler Teeth
	[778]={b=278,s=55,d=6259,c=AUCT_CLAS_WEAPON},  -- Kobold Excavation Pick
	[779]={b=75,s=18,d=7714,x=5},  -- Shiny Seashell
	[780]={b=0,s=0,d=6628,q=20,x=20,u=AUCT_TYPE_COOK},  -- Torn Murloc Fin
	[781]={b=552,s=110,d=19644,c=AUCT_CLAS_WEAPON},  -- Stone Gnoll Hammer
	[782]={b=0,s=0,d=1329,q=20,x=20},  -- Painted Gnoll Armband
	[783]={b=200,s=50,d=6687,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Light Hide
	[785]={b=80,s=20,d=7341,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Mageroyal
	[787]={b=25,s=1,d=24697,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Slitherskin Mackerel
	[789]={b=9847,s=1969,d=19699,c=AUCT_CLAS_WEAPON},  -- Stout Battlehammer
	[790]={b=10101,s=2020,d=19401,c=AUCT_CLAS_WEAPON},  -- Forester's Axe
	[791]={b=35347,s=7069,d=20334,c=AUCT_CLAS_WEAPON},  -- Gnarled Ash Staff
	[792]={b=207,s=41,d=16855,c=AUCT_CLAS_ARMOR},  -- Knitted Sandals
	[793]={b=139,s=27,d=14449,c=AUCT_CLAS_ARMOR},  -- Knitted Gloves
	[794]={b=279,s=55,d=14450,c=AUCT_CLAS_ARMOR},  -- Knitted Pants
	[795]={b=280,s=56,d=14154,c=AUCT_CLAS_ARMOR},  -- Knitted Tunic
	[796]={b=264,s=52,d=22973,c=AUCT_CLAS_ARMOR},  -- Rough Leather Boots
	[797]={b=176,s=35,d=17068,c=AUCT_CLAS_ARMOR},  -- Rough Leather Gloves
	[798]={b=354,s=70,d=22972,c=AUCT_CLAS_ARMOR},  -- Rough Leather Pants
	[799]={b=355,s=71,d=2106,c=AUCT_CLAS_ARMOR},  -- Rough Leather Vest
	[804]={b=10000,s=2500,d=2588,c=AUCT_CLAS_CONTAINER},  -- Large Blue Sack
	[805]={b=1000,s=250,d=2586,c=AUCT_CLAS_CONTAINER},  -- Small Red Pouch
	[809]={b=195625,s=39125,d=20033,c=AUCT_CLAS_WEAPON},  -- Bloodrazor
	[810]={b=226335,s=45267,d=19726,c=AUCT_CLAS_WEAPON},  -- Hammer of the Northern Wind
	[811]={b=270619,s=54123,d=19137,c=AUCT_CLAS_WEAPON},  -- Axe of the Deep Woods
	[812]={b=285093,s=57018,d=20257,c=AUCT_CLAS_WEAPON},  -- Glowing Brightwood Staff
	[814]={b=100,s=25,d=18084,x=20,u=AUCT_TYPE_ENGINEER},  -- Flask of Oil
	[816]={b=1527,s=305,d=6472,c=AUCT_CLAS_WEAPON},  -- Small Hand Blade
	[818]={b=400,s=100,d=7413,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Tigerseye
	[820]={b=4738,s=947,d=6470,c=AUCT_CLAS_WEAPON},  -- Slicer Blade
	[821]={b=1248,s=249,d=17102,c=AUCT_CLAS_ARMOR},  -- Riverpaw Leather Vest
	[826]={b=3661,s=732,d=19271,c=AUCT_CLAS_WEAPON},  -- Brutish Riverpaw Axe
	[827]={b=4858,s=971,d=3498,c=AUCT_CLAS_WEAPON},  -- Wicked Blackjack
	[828]={b=1000,s=250,d=2584,c=AUCT_CLAS_CONTAINER},  -- Small Blue Pouch
	[829]={b=0,s=0,d=1272,q=20,x=20},  -- Red Leather Bandana
	[832]={b=1015,s=203,d=6847,c=AUCT_CLAS_ARMOR},  -- Silver Defias Belt
	[833]={b=112000,s=28000,d=22978,c=AUCT_CLAS_ARMOR},  -- Lifestone
	[835]={b=95,s=23,d=1007},  -- Large Rope Net
	[837]={b=1124,s=224,d=14466,c=AUCT_CLAS_ARMOR},  -- Heavy Weave Armor
	[838]={b=1128,s=225,d=14468,c=AUCT_CLAS_ARMOR},  -- Heavy Weave Pants
	[839]={b=566,s=113,d=14467,c=AUCT_CLAS_ARMOR},  -- Heavy Weave Gloves
	[840]={b=853,s=170,d=16821,c=AUCT_CLAS_ARMOR},  -- Heavy Weave Shoes
	[841]={b=0,s=0,d=1270},  -- Furlbrow's Pocket Watch
	[843]={b=1077,s=215,d=14470,c=AUCT_CLAS_ARMOR},  -- Tanned Leather Boots
	[844]={b=720,s=144,d=2101,c=AUCT_CLAS_ARMOR},  -- Tanned Leather Gloves
	[845]={b=1447,s=289,d=9640,c=AUCT_CLAS_ARMOR},  -- Tanned Leather Pants
	[846]={b=1452,s=290,d=14472,c=AUCT_CLAS_ARMOR},  -- Tanned Leather Jerkin
	[847]={b=1749,s=349,d=1019,c=AUCT_CLAS_ARMOR},  -- Chainmail Armor
	[848]={b=1755,s=351,d=697,c=AUCT_CLAS_ARMOR},  -- Chainmail Pants
	[849]={b=1326,s=265,d=6869,c=AUCT_CLAS_ARMOR},  -- Chainmail Boots
	[850]={b=883,s=176,d=6871,c=AUCT_CLAS_ARMOR},  -- Chainmail Gloves
	[851]={b=2023,s=404,d=22077,c=AUCT_CLAS_WEAPON},  -- Cutlass
	[852]={b=1739,s=347,d=8287,c=AUCT_CLAS_WEAPON},  -- Mace
	[853]={b=2409,s=481,d=22102,c=AUCT_CLAS_WEAPON},  -- Hatchet
	[854]={b=3022,s=604,d=22147,c=AUCT_CLAS_WEAPON},  -- Quarter Staff
	[856]={b=3500,s=875,d=1025,c=AUCT_CLAS_CONTAINER},  -- Blue Leather Bag
	[857]={b=10000,s=2500,d=4056,c=AUCT_CLAS_CONTAINER},  -- Large Red Sack
	[858]={b=100,s=25,d=15711,x=5,c=AUCT_CLAS_POTION},  -- Lesser Healing Potion
	[859]={b=350,s=87,d=9880,c=AUCT_CLAS_ARMOR},  -- Fine Cloth Shirt
	[860]={b=447,s=89,d=3443,c=AUCT_CLAS_ARMOR},  -- Cavalier's Boots
	[862]={b=152890,s=38222,d=18397,c=AUCT_CLAS_ARMOR},  -- Runed Ring
	[863]={b=44820,s=8964,d=19213,c=AUCT_CLAS_WEAPON},  -- Gloom Reaper
	[864]={b=48580,s=9716,d=26579,c=AUCT_CLAS_WEAPON},  -- Knightly Longsword
	[865]={b=25480,s=5096,d=5212,c=AUCT_CLAS_WEAPON},  -- Leaden Mace
	[866]={b=83204,s=16640,d=20357,c=AUCT_CLAS_WEAPON},  -- Monk's Staff
	[867]={b=26720,s=5344,d=17180,c=AUCT_CLAS_ARMOR},  -- Gloves of Holy Might
	[868]={b=107664,s=21532,d=19713,c=AUCT_CLAS_WEAPON},  -- Ardent Custodian
	[869]={b=92648,s=18529,d=5163,c=AUCT_CLAS_WEAPON},  -- Dazzling Longsword
	[870]={b=107640,s=21528,d=19303,c=AUCT_CLAS_WEAPON},  -- Fiery War Axe
	[871]={b=148139,s=29627,d=19235,c=AUCT_CLAS_WEAPON},  -- Flurry Axe
	[872]={b=10058,s=2011,d=19242,c=AUCT_CLAS_WEAPON},  -- Rockslicer
	[873]={b=108853,s=21770,d=20298,c=AUCT_CLAS_WEAPON},  -- Staff of Jordan
	[878]={b=225,s=56,d=9200,x=10},  -- Fist-sized Spinneret
	[880]={b=13460,s=2692,d=20382,c=AUCT_CLAS_WEAPON},  -- Staff of Horrors
	[884]={b=0,s=0,d=6368,q=20,x=20},  -- Ghoul Rib
	[885]={b=11504,s=2300,d=14036,c=AUCT_CLAS_WEAPON},  -- Black Metal Axe
	[886]={b=14747,s=2949,d=20093,c=AUCT_CLAS_WEAPON},  -- Black Metal Shortsword
	[887]={b=330,s=82,d=6680,x=5},  -- Pound of Flesh
	[888]={b=4903,s=980,d=17182,c=AUCT_CLAS_ARMOR},  -- Naga Battle Gloves
	[889]={b=0,s=0,d=3022,c=AUCT_CLAS_WRITTEN},  -- A Dusty Unsent Letter
	[890]={b=17588,s=3517,d=20386,c=AUCT_CLAS_WEAPON},  -- Twisted Chanter's Staff
	[892]={b=1849,s=369,d=16950,c=AUCT_CLAS_ARMOR},  -- Gnoll Casting Gloves
	[893]={b=550,s=137,d=959,x=10},  -- Dire Wolf Fang
	[895]={b=0,s=0,d=7103,q=20,x=20},  -- Worgen Skull
	[896]={b=0,s=0,d=959,q=20,x=20},  -- Worgen Fang
	[897]={b=5112,s=1022,d=17011,c=AUCT_CLAS_ARMOR},  -- Madwolf Bracers
	[899]={b=6241,s=1248,d=6459,c=AUCT_CLAS_WEAPON},  -- Venom Web Fang
	[910]={b=0,s=0,d=3024,c=AUCT_CLAS_WRITTEN},  -- An Undelivered Letter
	[911]={b=16622,s=3324,d=28628,c=AUCT_CLAS_WEAPON},  -- Ironwood Treebranch
	[914]={b=13347,s=2669,d=2829,c=AUCT_CLAS_ARMOR},  -- Large Ogre Chain Armor
	[915]={b=0,s=0,d=1272,q=20,x=20},  -- Red Silk Bandana
	[916]={b=0,s=0,d=7589,c=AUCT_CLAS_WRITTEN},  -- A Torn Journal Page
	[918]={b=5000,s=1250,d=1283,c=AUCT_CLAS_CONTAINER},  -- Deviate Hide Pack
	[920]={b=14106,s=2821,d=19703,c=AUCT_CLAS_WEAPON},  -- Wicked Spiked Mace
	[921]={b=0,s=0,d=7588,c=AUCT_CLAS_WRITTEN},  -- A Faded Journal Page
	[922]={b=12038,s=2407,d=22097,c=AUCT_CLAS_WEAPON},  -- Dacian Falx
	[923]={b=8743,s=1748,d=22080,c=AUCT_CLAS_WEAPON},  -- Longsword
	[924]={b=10972,s=2194,d=22131,c=AUCT_CLAS_WEAPON},  -- Maul
	[925]={b=7797,s=1559,d=4351,c=AUCT_CLAS_WEAPON},  -- Flail
	[926]={b=9784,s=1956,d=22108,c=AUCT_CLAS_WEAPON},  -- Battle Axe
	[927]={b=6953,s=1390,d=22106,c=AUCT_CLAS_WEAPON},  -- Double Axe
	[928]={b=9860,s=1972,d=22151,c=AUCT_CLAS_WEAPON},  -- Long Staff
	[929]={b=300,s=75,d=15712,x=5,c=AUCT_CLAS_POTION,u=AUCT_TYPE_TAILOR},  -- Healing Potion
	[932]={b=2550,s=637,d=6430,c=AUCT_CLAS_CONTAINER},  -- Fel Steed Saddlebags
	[933]={b=10000,s=2500,d=1282,c=AUCT_CLAS_CONTAINER},  -- Large Rucksack
	[934]={b=53411,s=10682,d=19405,c=AUCT_CLAS_WEAPON},  -- Stalvan's Reaper
	[935]={b=8712,s=1742,d=8274,c=AUCT_CLAS_WEAPON},  -- Night Watch Shortsword
	[936]={b=58104,s=11620,d=5215,c=AUCT_CLAS_WEAPON},  -- Midnight Mace
	[937]={b=72885,s=14577,d=20329,c=AUCT_CLAS_WEAPON},  -- Black Duskwood Staff
	[938]={b=0,s=0,d=7601,c=AUCT_CLAS_WRITTEN},  -- Muddy Journal Pages
	[939]={b=0,s=0,d=7588,c=AUCT_CLAS_WRITTEN},  -- A Bloodstained Journal Page
	[940]={b=62829,s=12565,d=16676,c=AUCT_CLAS_ARMOR},  -- Robes of Insight
	[942]={b=18000,s=4500,d=9835,c=AUCT_CLAS_ARMOR},  -- Freezing Band
	[943]={b=214318,s=42863,d=20256,c=AUCT_CLAS_WEAPON},  -- Warden Staff
	[944]={b=415003,s=83000,d=20253,c=AUCT_CLAS_WEAPON},  -- Elemental Mage Staff
	[954]={b=200,s=50,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Strength
	[955]={b=150,s=37,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Intellect
	[957]={b=0,s=0,d=7286,c=AUCT_CLAS_WRITTEN},  -- William's Shipment
	[961]={b=10,s=2,d=6387,x=10},  -- Healing Herb
	[962]={b=0,s=0,d=6385},  -- Pork Belly Pie
	[981]={b=0,s=0,d=1399},  -- Bernice's Necklace
	[983]={b=108,s=21,d=4878,c=AUCT_CLAS_ARMOR},  -- Red Linen Sash
	[997]={b=17,s=3,d=859,c=AUCT_CLAS_WEAPON},  -- Fire Sword of Crippling
	[1006]={b=0,s=0,d=224},  -- Brass Collar
	[1008]={b=720,s=144,d=1550,c=AUCT_CLAS_WEAPON},  -- Well-used Sword
	[1009]={b=2451,s=490,d=8583,c=AUCT_CLAS_WEAPON},  -- Compact Hammer
	[1010]={b=498,s=99,d=20440,c=AUCT_CLAS_WEAPON},  -- Gnarled Short Staff
	[1011]={b=400,s=80,d=19273,c=AUCT_CLAS_WEAPON},  -- Sharp Axe
	[1013]={b=0,s=0,d=1236,q=20,x=20},  -- Iron Rivet
	[1015]={b=96,s=24,d=6348,x=10,u=AUCT_TYPE_COOK},  -- Lean Wolf Flank
	[1017]={b=400,s=100,d=1116,x=20},  -- Seasoned Wolf Kabob
	[1019]={b=0,s=0,d=1272,q=20,x=20},  -- Red Linen Bandana
	[1024]={b=6,s=1,d=15304,c=AUCT_CLAS_ARMOR},  -- Plate Helmet D2 (test)
	[1027]={b=6,s=1,d=15294,c=AUCT_CLAS_ARMOR},  -- Mail Helmet A (Test)
	[1074]={b=1965,s=491,d=6619,x=5},  -- Hard Spider Leg Tip
	[1075]={b=0,s=0,d=7236,q=20,x=20},  -- Shadowhide Pendant
	[1076]={b=2600,s=650,d=6012,c=AUCT_CLAS_ARMOR},  -- Defias Renegade Ring
	[1077]={b=100,s=25,d=9836,c=AUCT_CLAS_ARMOR},  -- Defias Mage Ring
	[1080]={b=315,s=78,d=25475,x=10,u=AUCT_TYPE_COOK},  -- Tough Condor Meat
	[1081]={b=200,s=50,d=7345,x=10,u=AUCT_TYPE_COOK},  -- Crisp Spider Meat
	[1082]={b=600,s=150,d=6406,x=20},  -- Redridge Goulash
	[1083]={b=0,s=0,d=7133},  -- Glyph of Azora
	[1113]={b=0,s=0,d=6413,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Conjured Bread
	[1114]={b=0,s=0,d=6343,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Conjured Rye
	[1116]={b=5000,s=1250,d=6011,c=AUCT_CLAS_ARMOR},  -- Ring of Pure Silver
	[1121]={b=5375,s=1075,d=703,c=AUCT_CLAS_ARMOR},  -- Feet of the Lynx
	[1127]={b=100,s=25,d=1816,x=10},  -- Flash Bundle
	[1129]={b=0,s=0,d=7129,q=20,x=20},  -- Ghoul Fang
	[1130]={b=0,s=0,d=1288,q=20,x=20},  -- Vial of Spider Venom
	[1131]={b=4545,s=1136,d=9557,c=AUCT_CLAS_WEAPON},  -- Totem of Infliction
	[1132]={b=800000,s=0,d=16208},  -- Horn of the Timber Wolf
	[1154]={b=513,s=102,d=6833,c=AUCT_CLAS_ARMOR},  -- Belt of the People's Militia
	[1155]={b=29770,s=5954,d=20327,c=AUCT_CLAS_WEAPON},  -- Rod of the Sleepwalker
	[1156]={b=3250,s=812,d=9839,c=AUCT_CLAS_ARMOR},  -- Lavishly Jeweled Ring
	[1158]={b=731,s=146,d=19643,c=AUCT_CLAS_WEAPON},  -- Solid Metal Club
	[1159]={b=160,s=32,d=4994,c=AUCT_CLAS_WEAPON},  -- Militia Quarterstaff
	[1161]={b=128,s=25,d=1544,c=AUCT_CLAS_WEAPON},  -- Militia Shortsword
	[1168]={b=211484,s=42296,d=30993,c=AUCT_CLAS_WEAPON},  -- Skullflame Shield
	[1169]={b=94076,s=18815,d=18816,c=AUCT_CLAS_WEAPON},  -- Blackskull Shield
	[1171]={b=277,s=55,d=12707,c=AUCT_CLAS_ARMOR},  -- Well-stitched Robe
	[1172]={b=3875,s=968,d=12313,c=AUCT_CLAS_WEAPON},  -- Grayson's Torch
	[1173]={b=262,s=52,d=6777,c=AUCT_CLAS_ARMOR},  -- Weather-worn Boots
	[1175]={b=115,s=28,d=6659},  -- A Gold Tooth
	[1177]={b=12,s=3,d=6400,x=10},  -- Oil of Olaf
	[1178]={b=30,s=7,d=6336,x=20},  -- Explosive Rocket
	[1179]={b=125,s=6,d=18090,q=20,x=20,u=AUCT_TYPE_COOK},  -- Ice Cold Milk
	[1180]={b=150,s=37,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Stamina
	[1181]={b=100,s=25,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Spirit
	[1182]={b=222,s=44,d=6852,c=AUCT_CLAS_ARMOR},  -- Brass-studded Bracers
	[1183]={b=149,s=29,d=16927,c=AUCT_CLAS_ARMOR},  -- Elastic Wristguards
	[1187]={b=4325,s=1081,d=6415},  -- Spiked Collar
	[1189]={b=2500,s=625,d=963,c=AUCT_CLAS_ARMOR},  -- Overseer's Ring
	[1190]={b=3150,s=630,d=15120,c=AUCT_CLAS_ARMOR},  -- Overseer's Cloak
	[1191]={b=330,s=82,d=1816},  -- Bag of Marbles
	[1194]={b=104,s=20,d=22093,c=AUCT_CLAS_WEAPON},  -- Bastard Sword
	[1195]={b=236,s=47,d=7495,c=AUCT_CLAS_WEAPON},  -- Kobold Mining Shovel
	[1196]={b=2214,s=442,d=22114,c=AUCT_CLAS_WEAPON},  -- Tabar
	[1197]={b=2666,s=533,d=5226,c=AUCT_CLAS_WEAPON},  -- Giant Mace
	[1198]={b=2676,s=535,d=22095,c=AUCT_CLAS_WEAPON},  -- Claymore
	[1200]={b=82,s=16,d=18663,c=AUCT_CLAS_WEAPON},  -- Large Wooden Shield
	[1201]={b=473,s=94,d=2161,c=AUCT_CLAS_WEAPON},  -- Dull Heater Shield
	[1202]={b=1839,s=367,d=2329,c=AUCT_CLAS_WEAPON},  -- Wall Shield
	[1203]={b=117526,s=23505,d=2594,c=AUCT_CLAS_WEAPON},  -- Aegis of Stormwind
	[1204]={b=62886,s=12577,d=1644,c=AUCT_CLAS_WEAPON},  -- The Green Tower
	[1205]={b=500,s=25,d=18078,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Melon Juice
	[1206]={b=1600,s=400,d=7393,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH},  -- Moss Agate
	[1207]={b=49460,s=9892,d=5223,c=AUCT_CLAS_WEAPON},  -- Murphstar
	[1208]={b=0,s=0,d=2616,c=AUCT_CLAS_WRITTEN},  -- Maybell's Love Letter
	[1210]={b=1000,s=250,d=7401,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH},  -- Shadowgem
	[1211]={b=1738,s=347,d=14260,c=AUCT_CLAS_ARMOR},  -- Gnoll War Harness
	[1212]={b=85,s=21,d=2637,x=5},  -- Gnoll Spittle
	[1213]={b=437,s=87,d=3613,c=AUCT_CLAS_ARMOR},  -- Gnoll Kindred Bracers
	[1214]={b=4651,s=930,d=19625,c=AUCT_CLAS_WEAPON},  -- Gnoll Punisher
	[1215]={b=2347,s=469,d=16942,c=AUCT_CLAS_ARMOR},  -- Support Girdle
	[1217]={b=0,s=0,d=7280},  -- Unknown Reward
	[1218]={b=10321,s=2064,d=5527,c=AUCT_CLAS_WEAPON},  -- Heavy Gnoll War Club
	[1219]={b=4119,s=823,d=20122,c=AUCT_CLAS_WEAPON},  -- Redridge Machete
	[1220]={b=9039,s=1807,d=19232,c=AUCT_CLAS_WEAPON},  -- Lupine Axe
	[1221]={b=0,s=0,d=568,q=20,x=20},  -- Underbelly Whelp Scale
	[1251]={b=40,s=10,d=11907,x=20},  -- Linen Bandage
	[1252]={b=0,s=0,d=2616,c=AUCT_CLAS_WRITTEN},  -- Gramma Stonefield's Note
	[1254]={b=0,s=0,d=24380,c=AUCT_CLAS_WEAPON},  -- Lesser Firestone
	[1256]={b=0,s=0,d=7078,q=20,x=20},  -- Crystal Kelp Frond
	[1257]={b=0,s=0,d=1656},  -- Invisibility Liquor
	[1260]={b=0,s=0,d=1310},  -- Tharil'zun's Head
	[1261]={b=0,s=0,d=6009,q=20,x=20},  -- Midnight Orb
	[1262]={b=445,s=111,d=7923},  -- Keg of Thunderbrew Lager
	[1263]={b=395323,s=79064,d=22215,c=AUCT_CLAS_WEAPON},  -- Brain Hacker
	[1264]={b=18357,s=3671,d=5530,c=AUCT_CLAS_WEAPON},  -- Headbasher
	[1265]={b=58874,s=11774,d=20156,c=AUCT_CLAS_WEAPON},  -- Scorpion Sting
	[1270]={b=1067,s=213,d=23113,c=AUCT_CLAS_ARMOR},  -- Finely Woven Cloak
	[1273]={b=8282,s=1656,d=12723,c=AUCT_CLAS_ARMOR},  -- Forest Chain
	[1274]={b=35,s=8,d=6661,x=20},  -- Hops
	[1275]={b=8342,s=1668,d=1019,c=AUCT_CLAS_ARMOR},  -- Deputy Chain Coat
	[1276]={b=11101,s=2220,d=2210,c=AUCT_CLAS_WEAPON},  -- Fire Hardened Buckler
	[1280]={b=18481,s=3696,d=15298,c=AUCT_CLAS_ARMOR},  -- Cloaked Hood
	[1282]={b=14125,s=2825,d=15324,c=AUCT_CLAS_ARMOR},  -- Sparkmetal Coif
	[1283]={b=0,s=0,d=811,c=AUCT_CLAS_WRITTEN},  -- Verner's Note
	[1284]={b=0,s=0,d=7914,c=AUCT_CLAS_WRITTEN},  -- Crate of Horseshoes
	[1287]={b=3518,s=703,d=6447,c=AUCT_CLAS_WEAPON},  -- Giant Tarantula Fang
	[1288]={b=740,s=185,d=4826,x=5,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_FSTAID},  -- Large Venom Sac
	[1292]={b=16504,s=3300,d=8466,c=AUCT_CLAS_WEAPON},  -- Butcher's Cleaver
	[1293]={b=0,s=0,d=3034,c=AUCT_CLAS_WRITTEN},  -- The State of Lakeshire
	[1294]={b=0,s=0,d=3035,c=AUCT_CLAS_WRITTEN},  -- The General's Response
	[1296]={b=8408,s=1681,d=5195,c=AUCT_CLAS_WEAPON},  -- Blackrock Mace
	[1297]={b=10193,s=2038,d=19035,c=AUCT_CLAS_ARMOR},  -- Robes of the Shadowcaster
	[1299]={b=1953,s=390,d=16717,c=AUCT_CLAS_ARMOR},  -- Lesser Belt of the Spire
	[1300]={b=9270,s=1854,d=20391,c=AUCT_CLAS_WEAPON},  -- Lesser Staff of the Spire
	[1302]={b=1312,s=262,d=17174,c=AUCT_CLAS_ARMOR},  -- Black Whelp Gloves
	[1303]={b=2091,s=418,d=6871,c=AUCT_CLAS_ARMOR},  -- Bridgeworker's Gloves
	[1304]={b=1398,s=279,d=16818,c=AUCT_CLAS_ARMOR},  -- Riding Gloves
	[1306]={b=1761,s=352,d=11387,c=AUCT_CLAS_ARMOR},  -- Wolfmane Wristguards
	[1307]={b=0,s=0,d=811,c=AUCT_CLAS_QUEST},  -- Gold Pickup Schedule
	[1309]={b=0,s=0,d=12334},  -- Oslow's Toolbox
	[1310]={b=3576,s=715,d=16971,c=AUCT_CLAS_ARMOR},  -- Smith's Trousers
	[1314]={b=1814,s=362,d=17179,c=AUCT_CLAS_ARMOR},  -- Ghoul Fingers
	[1315]={b=52000,s=13000,d=6524,c=AUCT_CLAS_ARMOR},  -- Lei of Lilies
	[1317]={b=17501,s=3500,d=20377,c=AUCT_CLAS_WEAPON},  -- Hardened Root Staff
	[1318]={b=15332,s=3066,d=19290,c=AUCT_CLAS_WEAPON},  -- Night Reaver
	[1319]={b=1850,s=462,d=14437,c=AUCT_CLAS_ARMOR},  -- Ring of Iron Will
	[1322]={b=275,s=68,d=6373,x=10,c=AUCT_CLAS_POTION},  -- Fishliver Oil
	[1325]={b=0,s=0,d=6524},  -- Daffodil Bouquet
	[1326]={b=40,s=10,d=2661,x=20},  -- Sauteed Sunfish
	[1327]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Wiley's Note
	[1349]={b=0,s=0,d=7918},  -- Abercrombie's Crate
	[1351]={b=3843,s=768,d=16897,c=AUCT_CLAS_ARMOR},  -- Fingerbone Bracers
	[1353]={b=0,s=0,d=3031,c=AUCT_CLAS_WRITTEN},  -- Shaw's Report
	[1355]={b=1259,s=251,d=23014,c=AUCT_CLAS_ARMOR},  -- Buckskin Cape
	[1357]={b=0,s=0,d=1322,c=AUCT_CLAS_QUEST},  -- Captain Sander's Treasure Map
	[1358]={b=0,s=0,d=7593,c=AUCT_CLAS_WRITTEN},  -- A Clue to Sander's Treasure
	[1359]={b=95,s=19,d=6751,c=AUCT_CLAS_ARMOR},  -- Lion-stamped Gloves
	[1360]={b=210,s=42,d=7000,c=AUCT_CLAS_ARMOR},  -- Stormwind Chain Gloves
	[1361]={b=0,s=0,d=7594,c=AUCT_CLAS_WRITTEN},  -- Another Clue to Sander's Treasure
	[1362]={b=0,s=0,d=7595,c=AUCT_CLAS_WRITTEN},  -- Final Clue to Sander's Treasure
	[1364]={b=41,s=8,d=14339,c=AUCT_CLAS_ARMOR},  -- Ragged Leather Vest
	[1366]={b=11,s=2,d=14338,c=AUCT_CLAS_ARMOR},  -- Ragged Leather Pants
	[1367]={b=14,s=2,d=14354,c=AUCT_CLAS_ARMOR},  -- Ragged Leather Boots
	[1368]={b=14,s=2,d=17184,c=AUCT_CLAS_ARMOR},  -- Ragged Leather Gloves
	[1369]={b=21,s=4,d=14335,c=AUCT_CLAS_ARMOR},  -- Ragged Leather Belt
	[1370]={b=14,s=2,d=14336,c=AUCT_CLAS_ARMOR},  -- Ragged Leather Bracers
	[1372]={b=11,s=2,d=23054,c=AUCT_CLAS_ARMOR},  -- Ragged Cloak
	[1374]={b=16,s=3,d=16659,c=AUCT_CLAS_ARMOR},  -- Frayed Shoes
	[1376]={b=23,s=4,d=23090,c=AUCT_CLAS_ARMOR},  -- Frayed Cloak
	[1377]={b=6,s=1,d=16657,c=AUCT_CLAS_ARMOR},  -- Frayed Gloves
	[1378]={b=9,s=1,d=16656,c=AUCT_CLAS_ARMOR},  -- Frayed Pants
	[1380]={b=21,s=4,d=12426,c=AUCT_CLAS_ARMOR},  -- Frayed Robe
	[1381]={b=0,s=0,d=3023,c=AUCT_CLAS_WRITTEN},  -- A Mysterious Message
	[1382]={b=122,s=24,d=19636,c=AUCT_CLAS_WEAPON},  -- Rock Mace
	[1383]={b=126,s=25,d=8495,c=AUCT_CLAS_WEAPON},  -- Stone Tomahawk
	[1384]={b=56,s=11,d=1546,c=AUCT_CLAS_WEAPON},  -- Dull Blade
	[1386]={b=160,s=32,d=19247,c=AUCT_CLAS_WEAPON},  -- Thistlewood Axe
	[1387]={b=7892,s=1578,d=20087,c=AUCT_CLAS_WEAPON},  -- Ghoulfang
	[1388]={b=71,s=14,d=20450,c=AUCT_CLAS_WEAPON},  -- Crooked Staff
	[1389]={b=291,s=58,d=8575,c=AUCT_CLAS_WEAPON},  -- Kobold Mining Mallet
	[1391]={b=6961,s=1392,d=20410,c=AUCT_CLAS_WEAPON},  -- Riverpaw Mystic Staff
	[1394]={b=3700,s=740,d=5204,c=AUCT_CLAS_WEAPON},  -- Driftwood Club
	[1395]={b=5,s=1,d=9924,c=AUCT_CLAS_ARMOR},  -- Apprentice's Pants
	[1396]={b=4,s=1,d=3260,c=AUCT_CLAS_ARMOR},  -- Acolyte's Pants
	[1399]={b=50,s=12,d=6395,x=20},  -- Magic Candle
	[1401]={b=56,s=14,d=18088,x=20},  -- Green Tea Leaf
	[1404]={b=41225,s=10306,d=6499,c=AUCT_CLAS_ARMOR},  -- Tidal Charm
	[1405]={b=5923,s=1184,d=5540,c=AUCT_CLAS_WEAPON},  -- Foamspittle Staff
	[1406]={b=10398,s=2079,d=5638,c=AUCT_CLAS_WEAPON},  -- Pearl-encrusted Spear
	[1407]={b=0,s=0,d=3032,c=AUCT_CLAS_WRITTEN},  -- Solomon's Plea to Westfall
	[1408]={b=0,s=0,d=3033,c=AUCT_CLAS_WRITTEN},  -- Stoutmantle's Response to Solomon
	[1409]={b=0,s=0,d=3032,c=AUCT_CLAS_WRITTEN},  -- Solomon's Plea to Darkshire
	[1410]={b=0,s=0,d=3032,c=AUCT_CLAS_WRITTEN},  -- Ebonlocke's Response to Solomon
	[1411]={b=343,s=68,d=20442,c=AUCT_CLAS_WEAPON},  -- Withered Staff
	[1412]={b=246,s=49,d=20074,c=AUCT_CLAS_WEAPON},  -- Crude Bastard Sword
	[1413]={b=276,s=55,d=1547,c=AUCT_CLAS_WEAPON},  -- Feeble Sword
	[1414]={b=486,s=97,d=19525,c=AUCT_CLAS_WEAPON},  -- Cracked Sledge
	[1415]={b=363,s=72,d=19613,c=AUCT_CLAS_WEAPON},  -- Carpenter's Mallet
	[1416]={b=364,s=72,d=8495,c=AUCT_CLAS_WEAPON},  -- Rusty Hatchet
	[1417]={b=326,s=65,d=8501,c=AUCT_CLAS_WEAPON},  -- Beaten Battle Axe
	[1418]={b=46,s=9,d=14344,c=AUCT_CLAS_ARMOR},  -- Worn Leather Belt
	[1419]={b=98,s=19,d=14353,c=AUCT_CLAS_ARMOR},  -- Worn Leather Boots
	[1420]={b=92,s=18,d=4471,c=AUCT_CLAS_ARMOR},  -- Worn Leather Bracers
	[1421]={b=144,s=28,d=23083,c=AUCT_CLAS_ARMOR},  -- Worn Hide Cloak
	[1422]={b=31,s=6,d=14345,c=AUCT_CLAS_ARMOR},  -- Worn Leather Gloves
	[1423]={b=94,s=18,d=14346,c=AUCT_CLAS_ARMOR},  -- Worn Leather Pants
	[1425]={b=188,s=37,d=14190,c=AUCT_CLAS_ARMOR},  -- Worn Leather Vest
	[1427]={b=147,s=29,d=16798,c=AUCT_CLAS_ARMOR},  -- Patchwork Shoes
	[1429]={b=38,s=7,d=23130,c=AUCT_CLAS_ARMOR},  -- Patchwork Cloak
	[1430]={b=38,s=7,d=16797,c=AUCT_CLAS_ARMOR},  -- Patchwork Gloves
	[1431]={b=101,s=20,d=16796,c=AUCT_CLAS_ARMOR},  -- Patchwork Pants
	[1433]={b=72,s=14,d=16795,c=AUCT_CLAS_ARMOR},  -- Patchwork Armor
	[1434]={b=175,s=43,d=6383,x=20},  -- Glowing Wax Stick
	[1436]={b=2290,s=458,d=17144,c=AUCT_CLAS_ARMOR},  -- Frontier Britches
	[1438]={b=352,s=70,d=25943,c=AUCT_CLAS_WEAPON},  -- Warrior's Shield
	[1440]={b=6151,s=1230,d=8570,c=AUCT_CLAS_WEAPON},  -- Gnoll Skull Basher
	[1443]={b=84500,s=21125,d=6522,c=AUCT_CLAS_ARMOR},  -- Jeweled Amulet of Cainwyn
	[1445]={b=2919,s=583,d=10167,c=AUCT_CLAS_ARMOR},  -- Blackrock Pauldrons
	[1446]={b=2842,s=568,d=6841,c=AUCT_CLAS_ARMOR},  -- Blackrock Boots
	[1447]={b=91100,s=22775,d=14438,c=AUCT_CLAS_ARMOR},  -- Ring of Saviors
	[1448]={b=2027,s=405,d=6842,c=AUCT_CLAS_ARMOR},  -- Blackrock Gauntlets
	[1449]={b=7500,s=1875,d=9823,c=AUCT_CLAS_ARMOR},  -- Minor Channeling Ring
	[1451]={b=0,s=0,d=1249},  -- Bottle of Zombie Juice
	[1453]={b=0,s=0,d=9825},  -- Spectral Comb
	[1454]={b=19689,s=3937,d=8457,c=AUCT_CLAS_WEAPON},  -- Axe of the Enforcer
	[1455]={b=14657,s=2931,d=22214,c=AUCT_CLAS_WEAPON},  -- Blackrock Champion's Axe
	[1457]={b=9251,s=1850,d=19683,c=AUCT_CLAS_WEAPON},  -- Shadowhide Mace
	[1458]={b=13117,s=2623,d=8601,c=AUCT_CLAS_WEAPON},  -- Shadowhide Maul
	[1459]={b=11902,s=2380,d=19136,c=AUCT_CLAS_WEAPON},  -- Shadowhide Scalper
	[1460]={b=8842,s=1768,d=20109,c=AUCT_CLAS_WEAPON},  -- Shadowhide Two-handed Sword
	[1461]={b=16936,s=3387,d=19375,c=AUCT_CLAS_WEAPON},  -- Slayer's Battle Axe
	[1462]={b=5225,s=1306,d=9846,c=AUCT_CLAS_ARMOR},  -- Ring of the Shadow
	[1464]={b=285,s=71,d=6627,x=5},  -- Buzzard Talon
	[1465]={b=49124,s=9824,d=20594,c=AUCT_CLAS_WEAPON},  -- Tigerbane
	[1467]={b=0,s=0,d=1361,q=20,x=20},  -- Spotted Sunfish
	[1468]={b=115,s=28,d=6697,x=10,u=AUCT_TYPE_COOK},  -- Murloc Fin
	[1469]={b=5900,s=1180,d=20154,c=AUCT_CLAS_WEAPON},  -- Scimitar of Atun
	[1470]={b=3500,s=875,d=1025,c=AUCT_CLAS_CONTAINER},  -- Murloc Skin Bag
	[1473]={b=7489,s=1497,d=20402,c=AUCT_CLAS_WEAPON},  -- Riverside Staff
	[1475]={b=330,s=82,d=6693,x=5,u=AUCT_TYPE_FSTAID},  -- Small Venom Sac
	[1476]={b=25,s=6,d=6619,x=5},  -- Snapped Spider Limb
	[1477]={b=350,s=87,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Agility II
	[1478]={b=250,s=62,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Protection II
	[1479]={b=238,s=47,d=16710,c=AUCT_CLAS_ARMOR},  -- Salma's Oven Mitts
	[1480]={b=4773,s=954,d=9381,c=AUCT_CLAS_WEAPON},  -- Fist of the People's Militia
	[1481]={b=16688,s=3337,d=25595,c=AUCT_CLAS_WEAPON},  -- Grimclaw
	[1482]={b=14822,s=2964,d=20089,c=AUCT_CLAS_WEAPON},  -- Shadowfang
	[1483]={b=10129,s=2025,d=9117,c=AUCT_CLAS_WEAPON},  -- Face Smasher
	[1484]={b=14612,s=2922,d=9122,c=AUCT_CLAS_WEAPON},  -- Witching Stave
	[1485]={b=7053,s=1410,d=7464,c=AUCT_CLAS_WEAPON},  -- Pitchfork
	[1486]={b=6012,s=1202,d=9889,c=AUCT_CLAS_ARMOR},  -- Tree Bark Jacket
	[1487]={b=0,s=0,d=6344,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Conjured Pumpernickel
	[1488]={b=16899,s=3379,d=12960,c=AUCT_CLAS_ARMOR},  -- Avenger's Armor
	[1489]={b=7767,s=1553,d=8676,c=AUCT_CLAS_ARMOR},  -- Gloomshroud Armor
	[1490]={b=35640,s=8910,d=6502,c=AUCT_CLAS_ARMOR},  -- Guardian Talisman
	[1491]={b=8830,s=2207,d=9836,c=AUCT_CLAS_ARMOR},  -- Ring of Precision
	[1493]={b=19610,s=3922,d=5165,c=AUCT_CLAS_WEAPON},  -- Heavy Marauder Scimitar
	[1495]={b=294,s=58,d=16553,c=AUCT_CLAS_ARMOR},  -- Calico Shoes
	[1497]={b=356,s=71,d=23094,c=AUCT_CLAS_ARMOR},  -- Calico Cloak
	[1498]={b=285,s=57,d=14348,c=AUCT_CLAS_ARMOR},  -- Calico Gloves
	[1499]={b=255,s=51,d=16552,c=AUCT_CLAS_ARMOR},  -- Calico Pants
	[1501]={b=402,s=80,d=16551,c=AUCT_CLAS_ARMOR},  -- Calico Tunic
	[1502]={b=302,s=60,d=16947,c=AUCT_CLAS_ARMOR},  -- Warped Leather Belt
	[1503]={b=546,s=109,d=14846,c=AUCT_CLAS_ARMOR},  -- Warped Leather Boots
	[1504]={b=162,s=32,d=17024,c=AUCT_CLAS_ARMOR},  -- Warped Leather Bracers
	[1505]={b=244,s=48,d=23076,c=AUCT_CLAS_ARMOR},  -- Warped Cloak
	[1506]={b=255,s=51,d=17077,c=AUCT_CLAS_ARMOR},  -- Warped Leather Gloves
	[1507]={b=616,s=123,d=17156,c=AUCT_CLAS_ARMOR},  -- Warped Leather Pants
	[1509]={b=299,s=59,d=18466,c=AUCT_CLAS_ARMOR},  -- Warped Leather Vest
	[1510]={b=752,s=150,d=19775,c=AUCT_CLAS_WEAPON},  -- Heavy Hammer
	[1511]={b=969,s=193,d=20173,c=AUCT_CLAS_WEAPON},  -- Commoner's Sword
	[1512]={b=973,s=194,d=19226,c=AUCT_CLAS_WEAPON},  -- Crude Battle Axe
	[1513]={b=1465,s=293,d=20092,c=AUCT_CLAS_WEAPON},  -- Old Greatsword
	[1514]={b=1470,s=294,d=19533,c=AUCT_CLAS_WEAPON},  -- Rusty Warhammer
	[1515]={b=984,s=196,d=20421,c=AUCT_CLAS_WEAPON},  -- Rough Wooden Staff
	[1516]={b=1185,s=237,d=8498,c=AUCT_CLAS_WEAPON},  -- Worn Hatchet
	[1518]={b=0,s=0,d=9825},  -- Ghost Hair Comb
	[1519]={b=0,s=0,d=1438,q=20,x=20},  -- Bloodscalp Ear
	[1520]={b=285,s=71,d=1656,x=5},  -- Troll Sweat
	[1521]={b=96027,s=19205,d=19306,c=AUCT_CLAS_WEAPON},  -- Lumbering Ogre Axe
	[1522]={b=51121,s=10224,d=22239,c=AUCT_CLAS_WEAPON},  -- Headhunting Spear
	[1523]={b=51305,s=10261,d=5534,c=AUCT_CLAS_WEAPON},  -- Huge Stone Club
	[1524]={b=0,s=0,d=959,q=20,x=20},  -- Skullsplitter Tusk
	[1528]={b=0,s=0,d=1443,q=20,x=20},  -- Handful of Oats
	[1529]={b=2800,s=700,d=1262,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Jade
	[1532]={b=0,s=0,d=7104,q=20,x=20},  -- Shrunken Head
	[1537]={b=250,s=62,d=1183,c=AUCT_CLAS_CONTAINER},  -- Old Blanchy's Feed Pouch
	[1539]={b=7861,s=1572,d=20395,c=AUCT_CLAS_WEAPON},  -- Gnarled Hermit's Staff
	[1547]={b=13978,s=2795,d=21551,c=AUCT_CLAS_WEAPON},  -- Shield of the Faith
	[1557]={b=4594,s=918,d=18456,c=AUCT_CLAS_WEAPON},  -- Buckler of the Seas
	[1560]={b=2568,s=513,d=16856,c=AUCT_CLAS_ARMOR},  -- Bluegill Sandals
	[1561]={b=1343,s=268,d=12671,c=AUCT_CLAS_ARMOR},  -- Harvester's Robe
	[1566]={b=5663,s=1132,d=20078,c=AUCT_CLAS_WEAPON},  -- Edge of the People's Militia
	[1596]={b=0,s=0,d=18096},  -- Ghost Hair Thread
	[1598]={b=0,s=0,d=1464,q=20,x=20},  -- Rot Blossom
	[1602]={b=58427,s=11685,d=8489,c=AUCT_CLAS_WEAPON},  -- Sickle Axe
	[1604]={b=97319,s=19463,d=20188,c=AUCT_CLAS_WEAPON},  -- Chromatic Sword
	[1607]={b=217103,s=43420,d=20272,c=AUCT_CLAS_WEAPON},  -- Soulkeeper
	[1608]={b=94703,s=18940,d=19743,c=AUCT_CLAS_WEAPON},  -- Skullcrusher Mace
	[1613]={b=95699,s=19139,d=28470,c=AUCT_CLAS_WEAPON},  -- Spiritchaser Staff
	[1624]={b=30862,s=6172,d=15340,c=AUCT_CLAS_ARMOR},  -- Skullsplitter Helm
	[1625]={b=73773,s=14754,d=26586,c=AUCT_CLAS_WEAPON},  -- Exquisite Flamberge
	[1630]={b=265,s=66,d=6552,x=5},  -- Broken Electro-lantern
	[1637]={b=0,s=0,d=1102,c=AUCT_CLAS_WRITTEN},  -- Letter to Ello
	[1639]={b=142301,s=28460,d=5128,c=AUCT_CLAS_WEAPON},  -- Grinning Axe
	[1640]={b=78188,s=15637,d=8526,c=AUCT_CLAS_WEAPON},  -- Monstrous War Axe
	[1645]={b=2000,s=100,d=18060,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Moonberry Juice
	[1652]={b=20000,s=5000,d=12642,c=AUCT_CLAS_CONTAINER},  -- Sturdy Lunchbox
	[1656]={b=0,s=0,d=1102,c=AUCT_CLAS_WRITTEN},  -- Translated Letter
	[1659]={b=10682,s=2136,d=1795,c=AUCT_CLAS_ARMOR},  -- Engineering Gloves
	[1664]={b=73475,s=14695,d=18289,c=AUCT_CLAS_WEAPON},  -- Spellforce Rod
	[1677]={b=50466,s=10093,d=8678,c=AUCT_CLAS_ARMOR},  -- Drake-scale Vest
	[1678]={b=22907,s=4581,d=11269,c=AUCT_CLAS_ARMOR},  -- Black Ogre Kickers
	[1679]={b=48177,s=9635,d=5137,c=AUCT_CLAS_WEAPON},  -- Korg Bat
	[1680]={b=91170,s=18234,d=19304,c=AUCT_CLAS_WEAPON},  -- Headchopper
	[1685]={b=25000,s=6250,d=1285,c=AUCT_CLAS_CONTAINER},  -- Troll-hide Bag
	[1686]={b=2935,s=733,d=18096,x=10},  -- Bristly Whisker
	[1687]={b=975,s=243,d=1496,x=5},  -- Retractable Claw
	[1688]={b=3225,s=806,d=18092,x=5},  -- Long Soft Tail
	[1696]={b=2425,s=606,d=1498,x=5},  -- Curved Raptor Talon
	[1697]={b=1780,s=445,d=6630,x=10},  -- Keen Raptor Tooth
	[1701]={b=1505,s=376,d=1498,x=5},  -- Curved Basilisk Claw
	[1702]={b=1280,s=320,d=6349,x=5},  -- Intact Basilisk Spine
	[1703]={b=325,s=81,d=6349,x=10},  -- Crystal Basilisk Spine
	[1705]={b=2400,s=600,d=7380,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Lesser Moonstone
	[1706]={b=344,s=86,d=6614,x=10},  -- Azuredeep Shards
	[1707]={b=1000,s=62,d=21905,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Stormwind Brie
	[1708]={b=1000,s=50,d=18114,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Sweet Nectar
	[1710]={b=500,s=125,d=15713,x=5,c=AUCT_CLAS_POTION},  -- Greater Healing Potion
	[1711]={b=300,s=75,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Stamina II
	[1712]={b=250,s=62,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Spirit II
	[1713]={b=21400,s=5350,d=23949,c=AUCT_CLAS_ARMOR},  -- Ankh of Life
	[1714]={b=10140,s=2535,d=9858,c=AUCT_CLAS_ARMOR},  -- Necklace of Calisea
	[1715]={b=51509,s=10301,d=8683,c=AUCT_CLAS_ARMOR},  -- Polished Jazeraint Armor
	[1716]={b=25335,s=5067,d=16667,c=AUCT_CLAS_ARMOR},  -- Robe of the Magi
	[1717]={b=15540,s=3108,d=12960,c=AUCT_CLAS_ARMOR},  -- Double Link Tunic
	[1718]={b=40202,s=8040,d=17137,c=AUCT_CLAS_ARMOR},  -- Basilisk Hide Pants
	[1720]={b=131048,s=26209,d=21460,c=AUCT_CLAS_WEAPON},  -- Tanglewood Staff
	[1721]={b=179079,s=35815,d=8581,c=AUCT_CLAS_WEAPON},  -- Viking Warhammer
	[1722]={b=97038,s=19407,d=15467,c=AUCT_CLAS_WEAPON},  -- Thornstone Sledgehammer
	[1725]={b=20000,s=5000,d=2592,c=AUCT_CLAS_CONTAINER},  -- Large Knapsack
	[1726]={b=60915,s=12183,d=20749,c=AUCT_CLAS_WEAPON},  -- Poison-tipped Bone Spear
	[1727]={b=22814,s=4562,d=12827,c=AUCT_CLAS_WEAPON},  -- Sword of Decay
	[1729]={b=2000,s=500,d=2588,c=AUCT_CLAS_CONTAINER},  -- Gunnysack of the Night Watch
	[1730]={b=243,s=48,d=6902,c=AUCT_CLAS_ARMOR},  -- Worn Mail Belt
	[1731]={b=461,s=92,d=6903,c=AUCT_CLAS_ARMOR},  -- Worn Mail Boots
	[1732]={b=368,s=73,d=6904,c=AUCT_CLAS_ARMOR},  -- Worn Mail Bracers
	[1733]={b=443,s=88,d=15272,c=AUCT_CLAS_ARMOR},  -- Worn Cloak
	[1734]={b=197,s=39,d=6905,c=AUCT_CLAS_ARMOR},  -- Worn Mail Gloves
	[1735]={b=449,s=89,d=687,c=AUCT_CLAS_ARMOR},  -- Worn Mail Pants
	[1737]={b=698,s=139,d=977,c=AUCT_CLAS_ARMOR},  -- Worn Mail Vest
	[1738]={b=735,s=147,d=6902,c=AUCT_CLAS_ARMOR},  -- Laced Mail Belt
	[1739]={b=1279,s=255,d=6903,c=AUCT_CLAS_ARMOR},  -- Laced Mail Boots
	[1740]={b=487,s=97,d=6904,c=AUCT_CLAS_ARMOR},  -- Laced Mail Bracers
	[1741]={b=562,s=112,d=15065,c=AUCT_CLAS_ARMOR},  -- Laced Cloak
	[1742]={b=648,s=129,d=6905,c=AUCT_CLAS_ARMOR},  -- Laced Mail Gloves
	[1743]={b=1497,s=299,d=687,c=AUCT_CLAS_ARMOR},  -- Laced Mail Pants
	[1744]={b=1302,s=260,d=6914,c=AUCT_CLAS_ARMOR},  -- Laced Mail Shoulderpads
	[1745]={b=992,s=198,d=977,c=AUCT_CLAS_ARMOR},  -- Laced Mail Vest
	[1746]={b=1662,s=332,d=6902,c=AUCT_CLAS_ARMOR},  -- Linked Chain Belt
	[1747]={b=1514,s=302,d=6903,c=AUCT_CLAS_ARMOR},  -- Linked Chain Boots
	[1748]={b=1160,s=232,d=6904,c=AUCT_CLAS_ARMOR},  -- Linked Chain Bracers
	[1749]={b=1982,s=396,d=15074,c=AUCT_CLAS_ARMOR},  -- Linked Chain Cloak
	[1750]={b=1491,s=298,d=6905,c=AUCT_CLAS_ARMOR},  -- Linked Chain Gloves
	[1751]={b=3384,s=676,d=687,c=AUCT_CLAS_ARMOR},  -- Linked Chain Pants
	[1752]={b=1433,s=286,d=6914,c=AUCT_CLAS_ARMOR},  -- Linked Chain Shoulderpads
	[1753]={b=2196,s=439,d=977,c=AUCT_CLAS_ARMOR},  -- Linked Chain Vest
	[1754]={b=1796,s=359,d=6902,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Belt
	[1755]={b=2989,s=597,d=6903,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Boots
	[1756]={b=2190,s=438,d=6904,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Bracers
	[1757]={b=3643,s=728,d=15181,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Cloak
	[1758]={b=2670,s=534,d=6905,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Gloves
	[1759]={b=3661,s=732,d=687,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Pants
	[1760]={b=3045,s=609,d=6914,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Shoulderpads
	[1761]={b=4463,s=892,d=977,c=AUCT_CLAS_ARMOR},  -- Reinforced Chain Vest
	[1764]={b=568,s=113,d=7578,c=AUCT_CLAS_ARMOR},  -- Canvas Shoes
	[1766]={b=658,s=131,d=23095,c=AUCT_CLAS_ARMOR},  -- Canvas Cloak
	[1767]={b=505,s=101,d=14065,c=AUCT_CLAS_ARMOR},  -- Canvas Gloves
	[1768]={b=1085,s=217,d=14064,c=AUCT_CLAS_ARMOR},  -- Canvas Pants
	[1769]={b=816,s=163,d=16786,c=AUCT_CLAS_ARMOR},  -- Canvas Shoulderpads
	[1770]={b=719,s=143,d=14378,c=AUCT_CLAS_ARMOR},  -- Canvas Vest
	[1772]={b=1235,s=247,d=3757,c=AUCT_CLAS_ARMOR},  -- Brocade Shoes
	[1774]={b=1406,s=281,d=23093,c=AUCT_CLAS_ARMOR},  -- Brocade Cloak
	[1775]={b=1064,s=212,d=14370,c=AUCT_CLAS_ARMOR},  -- Brocade Gloves
	[1776]={b=1287,s=257,d=12930,c=AUCT_CLAS_ARMOR},  -- Brocade Pants
	[1777]={b=1114,s=222,d=14371,c=AUCT_CLAS_ARMOR},  -- Brocade Shoulderpads
	[1778]={b=1685,s=337,d=14377,c=AUCT_CLAS_ARMOR},  -- Brocade Vest
	[1780]={b=2445,s=489,d=16820,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Sandals
	[1782]={b=2709,s=541,d=23102,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Cloak
	[1783]={b=1238,s=247,d=14373,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Gloves
	[1784]={b=2734,s=546,d=14374,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Pants
	[1785]={b=2322,s=464,d=14121,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Shoulderpads
	[1786]={b=3419,s=683,d=14376,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Vest
	[1787]={b=510,s=102,d=14360,c=AUCT_CLAS_ARMOR},  -- Patched Leather Belt
	[1788]={b=884,s=176,d=16990,c=AUCT_CLAS_ARMOR},  -- Patched Leather Boots
	[1789]={b=680,s=136,d=3653,c=AUCT_CLAS_ARMOR},  -- Patched Leather Bracers
	[1790]={b=469,s=93,d=23050,c=AUCT_CLAS_ARMOR},  -- Patched Cloak
	[1791]={b=450,s=90,d=972,c=AUCT_CLAS_ARMOR},  -- Patched Leather Gloves
	[1792]={b=1041,s=208,d=6731,c=AUCT_CLAS_ARMOR},  -- Patched Leather Pants
	[1793]={b=1037,s=207,d=14361,c=AUCT_CLAS_ARMOR},  -- Patched Leather Shoulderpads
	[1794]={b=1387,s=277,d=14272,c=AUCT_CLAS_ARMOR},  -- Patched Leather Jerkin
	[1795]={b=1176,s=235,d=16935,c=AUCT_CLAS_ARMOR},  -- Rawhide Belt
	[1796]={b=2001,s=400,d=16992,c=AUCT_CLAS_ARMOR},  -- Rawhide Boots
	[1797]={b=807,s=161,d=17015,c=AUCT_CLAS_ARMOR},  -- Rawhide Bracers
	[1798]={b=1397,s=279,d=23058,c=AUCT_CLAS_ARMOR},  -- Rawhide Cloak
	[1799]={b=1056,s=211,d=17066,c=AUCT_CLAS_ARMOR},  -- Rawhide Gloves
	[1800]={b=2397,s=479,d=16967,c=AUCT_CLAS_ARMOR},  -- Rawhide Pants
	[1801]={b=2093,s=418,d=15002,c=AUCT_CLAS_ARMOR},  -- Rawhide Shoulderpads
	[1802]={b=1688,s=337,d=16895,c=AUCT_CLAS_ARMOR},  -- Rawhide Tunic
	[1803]={b=2325,s=465,d=16945,c=AUCT_CLAS_ARMOR},  -- Tough Leather Belt
	[1804]={b=2391,s=478,d=16998,c=AUCT_CLAS_ARMOR},  -- Tough Leather Boots
	[1805]={b=1759,s=351,d=17022,c=AUCT_CLAS_ARMOR},  -- Tough Leather Bracers
	[1806]={b=2330,s=466,d=23072,c=AUCT_CLAS_ARMOR},  -- Tough Cloak
	[1807]={b=1939,s=387,d=17072,c=AUCT_CLAS_ARMOR},  -- Tough Leather Gloves
	[1808]={b=4284,s=856,d=16977,c=AUCT_CLAS_ARMOR},  -- Tough Leather Pants
	[1809]={b=2203,s=440,d=14205,c=AUCT_CLAS_ARMOR},  -- Tough Leather Shoulderpads
	[1810]={b=3243,s=648,d=14418,c=AUCT_CLAS_ARMOR},  -- Tough Leather Armor
	[1811]={b=2255,s=451,d=20037,c=AUCT_CLAS_WEAPON},  -- Blunt Claymore
	[1812]={b=2264,s=452,d=19245,c=AUCT_CLAS_WEAPON},  -- Short-handled Battle Axe
	[1813]={b=2614,s=522,d=20413,c=AUCT_CLAS_WEAPON},  -- Chipped Quarterstaff
	[1814]={b=3018,s=603,d=19534,c=AUCT_CLAS_WEAPON},  -- Battered Mallet
	[1815]={b=1832,s=366,d=5217,c=AUCT_CLAS_WEAPON},  -- Ornamental Mace
	[1816]={b=2432,s=486,d=8495,c=AUCT_CLAS_WEAPON},  -- Unbalanced Axe
	[1817]={b=2507,s=501,d=20164,c=AUCT_CLAS_WEAPON},  -- Stock Shortsword
	[1818]={b=6109,s=1221,d=20183,c=AUCT_CLAS_WEAPON},  -- Standard Claymore
	[1819]={b=3840,s=768,d=14039,c=AUCT_CLAS_WEAPON},  -- Gouging Pick
	[1820]={b=4818,s=963,d=19535,c=AUCT_CLAS_WEAPON},  -- Wooden Maul
	[1821]={b=4940,s=988,d=5151,c=AUCT_CLAS_WEAPON},  -- Warped Blade
	[1822]={b=5484,s=1096,d=20385,c=AUCT_CLAS_WEAPON},  -- Cedar Walking Stick
	[1823]={b=3896,s=779,d=6794,c=AUCT_CLAS_WEAPON},  -- Bludgeoning Cudgel
	[1824]={b=5523,s=1104,d=19292,c=AUCT_CLAS_WEAPON},  -- Shiny War Axe
	[1825]={b=7742,s=1548,d=19784,c=AUCT_CLAS_WEAPON},  -- Bulky Bludgeon
	[1826]={b=8828,s=1765,d=8587,c=AUCT_CLAS_WEAPON},  -- Rock Maul
	[1827]={b=6412,s=1282,d=8482,c=AUCT_CLAS_WEAPON},  -- Meat Cleaver
	[1828]={b=8046,s=1609,d=19369,c=AUCT_CLAS_WEAPON},  -- Stone War Axe
	[1829]={b=7818,s=1563,d=15591,c=AUCT_CLAS_WEAPON},  -- Short Cutlass
	[1830]={b=8919,s=1783,d=4129,c=AUCT_CLAS_WEAPON},  -- Long Bastard Sword
	[1831]={b=8953,s=1790,d=20361,c=AUCT_CLAS_WEAPON},  -- Oaken War Staff
	[1832]={b=1811,s=362,d=16845,c=AUCT_CLAS_ARMOR},  -- Lucky Trousers
	[1835]={b=31,s=6,d=14443,c=AUCT_CLAS_ARMOR},  -- Dirty Leather Belt
	[1836]={b=31,s=6,d=14249,c=AUCT_CLAS_ARMOR},  -- Dirty Leather Bracers
	[1839]={b=184,s=36,d=17126,c=AUCT_CLAS_ARMOR},  -- Rough Leather Belt
	[1840]={b=185,s=37,d=17170,c=AUCT_CLAS_ARMOR},  -- Rough Leather Bracers
	[1843]={b=725,s=145,d=14469,c=AUCT_CLAS_ARMOR},  -- Tanned Leather Belt
	[1844]={b=728,s=145,d=14471,c=AUCT_CLAS_ARMOR},  -- Tanned Leather Bracers
	[1845]={b=877,s=175,d=6864,c=AUCT_CLAS_ARMOR},  -- Chainmail Belt
	[1846]={b=880,s=176,d=13617,c=AUCT_CLAS_ARMOR},  -- Chainmail Bracers
	[1849]={b=1388,s=277,d=16914,c=AUCT_CLAS_ARMOR},  -- Cured Leather Belt
	[1850]={b=1393,s=278,d=14282,c=AUCT_CLAS_ARMOR},  -- Cured Leather Bracers
	[1852]={b=1684,s=336,d=6985,c=AUCT_CLAS_ARMOR},  -- Scalemail Bracers
	[1853]={b=1690,s=338,d=10410,c=AUCT_CLAS_ARMOR},  -- Scalemail Belt
	[1875]={b=0,s=0,d=8604},  -- Thistlenettle's Badge
	[1893]={b=8876,s=1775,d=19234,c=AUCT_CLAS_WEAPON},  -- Miner's Revenge
	[1894]={b=0,s=0,d=3029,q=20,x=20},  -- Miners' Union Card
	[1913]={b=742,s=148,d=5009,c=AUCT_CLAS_WEAPON},  -- Studded Blackjack
	[1917]={b=1256,s=251,d=20435,c=AUCT_CLAS_WEAPON},  -- Jeweled Dagger
	[1922]={b=0,s=0,d=1283},  -- Supplies for Sven
	[1923]={b=0,s=0,d=1625},  -- Ambassador's Satchel
	[1925]={b=3938,s=787,d=20114,c=AUCT_CLAS_WEAPON},  -- Defias Rapier
	[1926]={b=3438,s=687,d=5225,c=AUCT_CLAS_WEAPON},  -- Weighted Sap
	[1927]={b=3451,s=690,d=19276,c=AUCT_CLAS_WEAPON},  -- Deadmines Cleaver
	[1928]={b=4979,s=995,d=20415,c=AUCT_CLAS_WEAPON},  -- Defias Mage Staff
	[1929]={b=2171,s=434,d=16848,c=AUCT_CLAS_ARMOR},  -- Silk-threaded Trousers
	[1930]={b=2044,s=408,d=23067,c=AUCT_CLAS_ARMOR},  -- Stonemason Cloak
	[1931]={b=0,s=0,d=1645},  -- Huge Gnoll Claw
	[1933]={b=4528,s=905,d=20418,c=AUCT_CLAS_WEAPON},  -- Staff of Conjuring
	[1934]={b=3656,s=731,d=6774,c=AUCT_CLAS_ARMOR},  -- Stonemason Trousers
	[1935]={b=14874,s=2974,d=20471,c=AUCT_CLAS_WEAPON},  -- Assassin's Blade
	[1936]={b=5569,s=1113,d=20399,c=AUCT_CLAS_WEAPON},  -- Goblin Screwdriver
	[1937]={b=8500,s=1700,d=5040,c=AUCT_CLAS_WEAPON},  -- Buzz Saw
	[1938]={b=9810,s=1962,d=8565,c=AUCT_CLAS_WEAPON},  -- Block Mallet
	[1939]={b=675,s=168,d=18084},  -- Skin of Sweet Rum
	[1941]={b=815,s=203,d=8383},  -- Cask of Merlot
	[1942]={b=1265,s=316,d=18080},  -- Bottle of Moonshine
	[1943]={b=3566,s=713,d=697,c=AUCT_CLAS_ARMOR},  -- Goblin Mail Leggings
	[1944]={b=1296,s=259,d=17062,c=AUCT_CLAS_ARMOR},  -- Metalworking Gloves
	[1945]={b=1337,s=267,d=17189,c=AUCT_CLAS_ARMOR},  -- Woodworking Gloves
	[1946]={b=0,s=0,d=20919},  -- Mary's Looking Glass
	[1951]={b=6290,s=1258,d=8279,c=AUCT_CLAS_WEAPON},  -- Blackwater Cutlass
	[1955]={b=7868,s=1573,d=6907,c=AUCT_CLAS_ARMOR},  -- Dragonmaw Chain Boots
	[1956]={b=0,s=0,d=7236},  -- Faded Shadowhide Pendant
	[1958]={b=4876,s=975,d=1515,c=AUCT_CLAS_WEAPON},  -- Petrified Shinbone
	[1959]={b=6117,s=1223,d=14038,c=AUCT_CLAS_WEAPON},  -- Cold Iron Pick
	[1962]={b=0,s=0,d=6565,c=AUCT_CLAS_QUEST},  -- Glowing Shadowhide Pendant
	[1965]={b=180,s=36,d=3846,c=AUCT_CLAS_ARMOR},  -- White Wolf Gloves
	[1968]={b=0,s=0,d=1695},  -- Ogre's Monocle
	[1970]={b=480,s=120,d=1805,x=10},  -- Restoring Balm
	[1971]={b=0,s=0,d=7128,c=AUCT_CLAS_WRITTEN},  -- Furlbrow's Deed
	[1972]={b=0,s=0,d=924,c=AUCT_CLAS_QUEST},  -- Westfall Deed
	[1973]={b=18475,s=4618,d=6506,c=AUCT_CLAS_ARMOR},  -- Orb of Deception
	[1974]={b=2320,s=464,d=16901,c=AUCT_CLAS_ARMOR},  -- Mindthrust Bracers
	[1975]={b=28721,s=5744,d=20179,c=AUCT_CLAS_WEAPON},  -- Pysan's Old Greatsword
	[1976]={b=31703,s=6340,d=8590,c=AUCT_CLAS_WEAPON},  -- Slaghammer
	[1978]={b=4904,s=980,d=12813,c=AUCT_CLAS_ARMOR},  -- Wolfclaw Gloves
	[1979]={b=116369,s=23273,d=18793,c=AUCT_CLAS_WEAPON},  -- Wall of the Dead
	[1980]={b=24800,s=6200,d=9840,c=AUCT_CLAS_ARMOR},  -- Underworld Band
	[1981]={b=70566,s=14113,d=8668,c=AUCT_CLAS_ARMOR},  -- Icemail Jerkin
	[1982]={b=147568,s=29513,d=20191,c=AUCT_CLAS_WEAPON},  -- Nightblade
	[1986]={b=74309,s=14861,d=20638,c=AUCT_CLAS_WEAPON},  -- Gutrender
	[1987]={b=0,s=0,d=7155},  -- Krazek's Fixed Pot
	[1988]={b=14260,s=2852,d=25892,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Gauntlets
	[1990]={b=50385,s=10077,d=5533,c=AUCT_CLAS_WEAPON},  -- Ballast Maul
	[1991]={b=41788,s=8357,d=18269,c=AUCT_CLAS_WEAPON},  -- Goblin Power Shovel
	[1992]={b=27340,s=5468,d=21612,c=AUCT_CLAS_WEAPON},  -- Swampchill Fetish
	[1993]={b=8400,s=2100,d=14436,c=AUCT_CLAS_ARMOR},  -- Ogremind Ring
	[1994]={b=83480,s=16696,d=19129,c=AUCT_CLAS_WEAPON},  -- Ebonclaw Reaver
	[1996]={b=6880,s=1720,d=9840,c=AUCT_CLAS_ARMOR},  -- Voodoo Band
	[1997]={b=12694,s=2538,d=16670,c=AUCT_CLAS_ARMOR},  -- Pressed Felt Robe
	[1998]={b=36199,s=7239,d=20356,c=AUCT_CLAS_WEAPON},  -- Bloodscalp Channeling Staff
	[2000]={b=44136,s=8827,d=20251,c=AUCT_CLAS_WEAPON},  -- Archeus
	[2004]={b=0,s=0,d=7138,c=AUCT_CLAS_WRITTEN},  -- Grelin Whitebeard's Journal
	[2005]={b=0,s=0,d=7270,c=AUCT_CLAS_WRITTEN},  -- The First Troll Legend
	[2006]={b=0,s=0,d=7270,c=AUCT_CLAS_WRITTEN},  -- The Second Troll Legend
	[2007]={b=0,s=0,d=7270,c=AUCT_CLAS_WRITTEN},  -- The Third Troll Legend
	[2008]={b=0,s=0,d=7270,c=AUCT_CLAS_WRITTEN},  -- The Fourth Troll Legend
	[2011]={b=19200,s=3840,d=20120,c=AUCT_CLAS_WEAPON},  -- Twisted Sabre
	[2013]={b=18222,s=3644,d=20373,c=AUCT_CLAS_WEAPON},  -- Cryptbone Staff
	[2014]={b=24346,s=4869,d=5176,c=AUCT_CLAS_WEAPON},  -- Black Metal Greatsword
	[2015]={b=22219,s=4443,d=19255,c=AUCT_CLAS_WEAPON},  -- Black Metal War Axe
	[2017]={b=4477,s=895,d=6738,c=AUCT_CLAS_ARMOR},  -- Glowing Leather Bracers
	[2018]={b=16345,s=3269,d=20088,c=AUCT_CLAS_WEAPON},  -- Skeletal Longsword
	[2020]={b=5249,s=1049,d=20492,c=AUCT_CLAS_WEAPON},  -- Hollowfang Blade
	[2021]={b=5129,s=1025,d=18650,c=AUCT_CLAS_WEAPON},  -- Green Carapace Shield
	[2024]={b=6078,s=1215,d=22096,c=AUCT_CLAS_WEAPON},  -- Espadon
	[2025]={b=5304,s=1060,d=22115,c=AUCT_CLAS_WEAPON},  -- Bearded Axe
	[2026]={b=6286,s=1257,d=8593,c=AUCT_CLAS_WEAPON},  -- Rock Hammer
	[2027]={b=3815,s=763,d=22079,c=AUCT_CLAS_WEAPON},  -- Scimitar
	[2028]={b=5065,s=1013,d=22119,c=AUCT_CLAS_WEAPON},  -- Hammer
	[2029]={b=4419,s=883,d=19281,c=AUCT_CLAS_WEAPON},  -- Cleaver
	[2030]={b=5544,s=1108,d=22146,c=AUCT_CLAS_WEAPON},  -- Gnarled Staff
	[2032]={b=8328,s=1665,d=16887,c=AUCT_CLAS_ARMOR},  -- Gallan Cuffs
	[2033]={b=4836,s=967,d=10711,c=AUCT_CLAS_ARMOR},  -- Ambassador's Boots
	[2034]={b=5179,s=1035,d=12699,c=AUCT_CLAS_ARMOR},  -- Scholarly Robes
	[2035]={b=11503,s=2300,d=5161,c=AUCT_CLAS_WEAPON},  -- Sword of the Night Sky
	[2036]={b=1291,s=258,d=17054,c=AUCT_CLAS_ARMOR},  -- Dusty Mining Gloves
	[2037]={b=2345,s=469,d=11447,c=AUCT_CLAS_ARMOR},  -- Tunneler's Boots
	[2039]={b=3000,s=750,d=6012,c=AUCT_CLAS_ARMOR},  -- Plains Ring
	[2041]={b=7060,s=1412,d=8703,c=AUCT_CLAS_ARMOR},  -- Tunic of Westfall
	[2042]={b=18195,s=3639,d=20379,c=AUCT_CLAS_WEAPON},  -- Staff of Westfall
	[2043]={b=6000,s=1500,d=6011,c=AUCT_CLAS_ARMOR},  -- Ring of Forlorn Spirits
	[2044]={b=36787,s=7357,d=19220,c=AUCT_CLAS_WEAPON},  -- Crescent of Forlorn Spirits
	[2046]={b=12307,s=2461,d=22226,c=AUCT_CLAS_WEAPON},  -- Bluegill Kukri
	[2047]={b=129,s=25,d=8473,c=AUCT_CLAS_WEAPON},  -- Anvilmar Hand Axe
	[2048]={b=129,s=25,d=19770,c=AUCT_CLAS_WEAPON},  -- Anvilmar Hammer
	[2054]={b=80,s=16,d=19299,c=AUCT_CLAS_WEAPON},  -- Trogg Hand Axe
	[2055]={b=80,s=16,d=8579,c=AUCT_CLAS_WEAPON},  -- Small Wooden Hammer
	[2057]={b=81,s=16,d=20175,c=AUCT_CLAS_WEAPON},  -- Pitted Defias Shortsword
	[2058]={b=20986,s=4197,d=19611,c=AUCT_CLAS_WEAPON},  -- Kazon's Maul
	[2059]={b=4318,s=863,d=22991,c=AUCT_CLAS_ARMOR},  -- Sentry Cloak
	[2064]={b=958,s=191,d=19650,c=AUCT_CLAS_WEAPON},  -- Trogg Club
	[2065]={b=569,s=113,d=20212,c=AUCT_CLAS_WEAPON},  -- Rockjaw Blade
	[2066]={b=407,s=81,d=19203,c=AUCT_CLAS_WEAPON},  -- Skull Hatchet
	[2067]={b=931,s=186,d=20431,c=AUCT_CLAS_WEAPON},  -- Frostbit Staff
	[2069]={b=609,s=121,d=16868,c=AUCT_CLAS_ARMOR},  -- Black Bear Hide Vest
	[2070]={b=25,s=1,d=6353,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Darnassian Bleu
	[2072]={b=22070,s=4414,d=20363,c=AUCT_CLAS_WEAPON},  -- Dwarven Magestaff
	[2073]={b=3713,s=742,d=19134,c=AUCT_CLAS_WEAPON},  -- Dwarven Hatchet
	[2074]={b=5271,s=1054,d=20168,c=AUCT_CLAS_WEAPON},  -- Solid Shortblade
	[2075]={b=1932,s=386,d=5218,c=AUCT_CLAS_WEAPON},  -- Priest's Mace
	[2077]={b=25295,s=5059,d=28578,c=AUCT_CLAS_WEAPON},  -- Magician Staff
	[2078]={b=5350,s=1070,d=20157,c=AUCT_CLAS_WEAPON},  -- Northern Shortsword
	[2079]={b=4669,s=933,d=19637,c=AUCT_CLAS_WEAPON},  -- Sergeant's Warhammer
	[2080]={b=32954,s=6590,d=19400,c=AUCT_CLAS_WEAPON},  -- Hillborne Axe
	[2082]={b=1000,s=250,d=2588,c=AUCT_CLAS_CONTAINER},  -- Wizbang's Gunnysack
	[2084]={b=28547,s=5709,d=20152,c=AUCT_CLAS_WEAPON},  -- Darksteel Bastard Sword
	[2085]={b=60,s=15,d=1116,x=5},  -- Chunk of Flesh
	[2087]={b=1262,s=252,d=17095,c=AUCT_CLAS_ARMOR},  -- Hard Crawler Carapace
	[2088]={b=3648,s=729,d=6455,c=AUCT_CLAS_WEAPON},  -- Long Crawler Limb
	[2089]={b=5567,s=1113,d=20407,c=AUCT_CLAS_WEAPON},  -- Scrimshaw Dagger
	[2091]={b=855,s=213,d=6396,x=10},  -- Magic Dust
	[2092]={b=35,s=7,d=6442,c=AUCT_CLAS_WEAPON},  -- Worn Dagger
	[2098]={b=15104,s=3020,d=28718,c=AUCT_CLAS_WEAPON},  -- Double-barreled Shotgun
	[2099]={b=225203,s=45040,d=28636,c=AUCT_CLAS_WEAPON},  -- Dwarven Hand Cannon
	[2100]={b=122699,s=24539,d=8258,c=AUCT_CLAS_WEAPON},  -- Precisely Calibrated Boomstick
	[2101]={b=4,s=1,d=21328,c=AUCT_CLAS_CONTAINER},  -- Light Quiver
	[2102]={b=4,s=1,d=1816,c=AUCT_CLAS_CONTAINER},  -- Small Ammo Pouch
	[2105]={b=5,s=1,d=10005,c=AUCT_CLAS_ARMOR},  -- Thug Shirt
	[2108]={b=40,s=8,d=8662,c=AUCT_CLAS_ARMOR},  -- Frostmane Leather Vest
	[2109]={b=72,s=14,d=977,c=AUCT_CLAS_ARMOR},  -- Frostmane Chain Vest
	[2110]={b=31,s=6,d=12674,c=AUCT_CLAS_ARMOR},  -- Light Magesmith Robe
	[2112]={b=271,s=54,d=14279,c=AUCT_CLAS_ARMOR},  -- Lumberjack Jerkin
	[2113]={b=0,s=0,d=924,c=AUCT_CLAS_WRITTEN},  -- Calor's Note
	[2114]={b=155,s=31,d=16654,c=AUCT_CLAS_ARMOR},  -- Snowy Robe
	[2117]={b=36,s=7,d=16576,c=AUCT_CLAS_ARMOR},  -- Thin Cloth Shoes
	[2119]={b=24,s=4,d=16969,c=AUCT_CLAS_ARMOR},  -- Thin Cloth Gloves
	[2120]={b=50,s=10,d=8969,c=AUCT_CLAS_ARMOR},  -- Thin Cloth Pants
	[2121]={b=50,s=10,d=16575,c=AUCT_CLAS_ARMOR},  -- Thin Cloth Armor
	[2122]={b=32,s=6,d=14425,c=AUCT_CLAS_ARMOR},  -- Cracked Leather Belt
	[2123]={b=48,s=9,d=14426,c=AUCT_CLAS_ARMOR},  -- Cracked Leather Boots
	[2124]={b=32,s=6,d=14427,c=AUCT_CLAS_ARMOR},  -- Cracked Leather Bracers
	[2125]={b=32,s=6,d=17176,c=AUCT_CLAS_ARMOR},  -- Cracked Leather Gloves
	[2126]={b=59,s=11,d=14429,c=AUCT_CLAS_ARMOR},  -- Cracked Leather Pants
	[2127]={b=60,s=12,d=14430,c=AUCT_CLAS_ARMOR},  -- Cracked Leather Vest
	[2129]={b=77,s=15,d=18662,c=AUCT_CLAS_WEAPON},  -- Large Round Shield
	[2130]={b=54,s=10,d=22118,c=AUCT_CLAS_WEAPON},  -- Club
	[2131]={b=54,s=10,d=22075,c=AUCT_CLAS_WEAPON},  -- Shortsword
	[2132]={b=102,s=20,d=22149,c=AUCT_CLAS_WEAPON},  -- Short Staff
	[2133]={b=79,s=15,d=18480,c=AUCT_CLAS_WEAPON},  -- Small Shield
	[2134]={b=82,s=16,d=22101,c=AUCT_CLAS_WEAPON},  -- Hand Axe
	[2136]={b=0,s=0,d=18085,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Conjured Purified Water
	[2137]={b=124,s=24,d=6437,c=AUCT_CLAS_WEAPON},  -- Whittling Knife
	[2138]={b=192,s=38,d=6460,c=AUCT_CLAS_WEAPON},  -- Sharpened Letter Opener
	[2139]={b=57,s=11,d=22135,c=AUCT_CLAS_WEAPON},  -- Dirk
	[2140]={b=1616,s=323,d=6440,c=AUCT_CLAS_WEAPON},  -- Carving Knife
	[2141]={b=5223,s=1044,d=8655,c=AUCT_CLAS_ARMOR},  -- Cuirboulli Vest
	[2142]={b=2620,s=524,d=17117,c=AUCT_CLAS_ARMOR},  -- Cuirboulli Belt
	[2143]={b=3944,s=788,d=2355,c=AUCT_CLAS_ARMOR},  -- Cuirboulli Boots
	[2144]={b=2639,s=527,d=3602,c=AUCT_CLAS_ARMOR},  -- Cuirboulli Bracers
	[2145]={b=2648,s=529,d=14480,c=AUCT_CLAS_ARMOR},  -- Cuirboulli Gloves
	[2146]={b=4809,s=961,d=14481,c=AUCT_CLAS_ARMOR},  -- Cuirboulli Pants
	[2148]={b=2907,s=581,d=6926,c=AUCT_CLAS_ARMOR},  -- Polished Scale Belt
	[2149]={b=4397,s=879,d=6972,c=AUCT_CLAS_ARMOR},  -- Polished Scale Boots
	[2150]={b=2930,s=586,d=6973,c=AUCT_CLAS_ARMOR},  -- Polished Scale Bracers
	[2151]={b=2941,s=588,d=6975,c=AUCT_CLAS_ARMOR},  -- Polished Scale Gloves
	[2152]={b=5906,s=1181,d=2989,c=AUCT_CLAS_ARMOR},  -- Polished Scale Leggings
	[2153]={b=5927,s=1185,d=8683,c=AUCT_CLAS_ARMOR},  -- Polished Scale Vest
	[2154]={b=0,s=0,d=1143,c=AUCT_CLAS_WRITTEN},  -- The Story of Morgan Ladimore
	[2156]={b=3077,s=615,d=16858,c=AUCT_CLAS_ARMOR},  -- Padded Boots
	[2158]={b=2066,s=413,d=14478,c=AUCT_CLAS_ARMOR},  -- Padded Gloves
	[2159]={b=4148,s=829,d=14479,c=AUCT_CLAS_ARMOR},  -- Padded Pants
	[2160]={b=4163,s=832,d=14477,c=AUCT_CLAS_ARMOR},  -- Padded Armor
	[2161]={b=0,s=0,d=1143,c=AUCT_CLAS_WRITTEN},  -- Book from Sven's Farm
	[2162]={b=0,s=0,d=963},  -- Sarah's Ring
	[2163]={b=233550,s=46710,d=20291,c=AUCT_CLAS_WEAPON},  -- Shadowblade
	[2164]={b=135159,s=27031,d=20312,c=AUCT_CLAS_WEAPON},  -- Gut Ripper
	[2165]={b=227,s=45,d=23054,c=AUCT_CLAS_ARMOR},  -- Old Blanchy's Blanket
	[2166]={b=4054,s=810,d=685,c=AUCT_CLAS_ARMOR},  -- Foreman's Leggings
	[2167]={b=1695,s=339,d=17178,c=AUCT_CLAS_ARMOR},  -- Foreman's Gloves
	[2168]={b=2349,s=469,d=16713,c=AUCT_CLAS_ARMOR},  -- Foreman's Boots
	[2169]={b=4717,s=943,d=20347,c=AUCT_CLAS_WEAPON},  -- Buzzer Blade
	[2172]={b=36,s=7,d=9895,c=AUCT_CLAS_ARMOR},  -- Rustic Belt
	[2173]={b=31,s=6,d=28227,c=AUCT_CLAS_ARMOR},  -- Old Leather Belt
	[2175]={b=13416,s=2683,d=8534,c=AUCT_CLAS_WEAPON},  -- Shadowhide Battle Axe
	[2186]={b=30,s=6,d=4545,c=AUCT_CLAS_ARMOR},  -- Outfitter Belt
	[2187]={b=0,s=0,d=3019},  -- A Stack of Letters
	[2188]={b=0,s=0,d=3020,c=AUCT_CLAS_WRITTEN},  -- A Letter to Grelin Whitebeard
	[2194]={b=16383,s=3276,d=8567,c=AUCT_CLAS_WEAPON},  -- Diamond Hammer
	[2195]={b=127,s=25,d=6432,c=AUCT_CLAS_WEAPON},  -- Anvilmar Knife
	[2203]={b=7463,s=1492,d=8506,c=AUCT_CLAS_WEAPON},  -- Brashclaw's Chopper
	[2204]={b=5665,s=1133,d=20038,c=AUCT_CLAS_WEAPON},  -- Brashclaw's Skewer
	[2205]={b=19806,s=3961,d=20153,c=AUCT_CLAS_WEAPON},  -- Duskbringer
	[2207]={b=2390,s=478,d=22137,c=AUCT_CLAS_WEAPON},  -- Jambiya
	[2208]={b=3650,s=730,d=22142,c=AUCT_CLAS_WEAPON},  -- Poniard
	[2209]={b=7115,s=1423,d=22139,c=AUCT_CLAS_WEAPON},  -- Kris
	[2210]={b=15,s=3,d=2552,c=AUCT_CLAS_WEAPON},  -- Battered Buckler
	[2211]={b=35,s=7,d=18656,c=AUCT_CLAS_WEAPON},  -- Bent Large Shield
	[2212]={b=80,s=16,d=2553,c=AUCT_CLAS_WEAPON},  -- Cracked Buckler
	[2213]={b=121,s=24,d=18673,c=AUCT_CLAS_WEAPON},  -- Worn Large Shield
	[2214]={b=910,s=182,d=17884,c=AUCT_CLAS_WEAPON},  -- Wooden Buckler
	[2215]={b=405,s=81,d=18670,c=AUCT_CLAS_WEAPON},  -- Wooden Shield
	[2216]={b=1054,s=210,d=18486,c=AUCT_CLAS_WEAPON},  -- Simple Buckler
	[2217]={b=1216,s=243,d=18665,c=AUCT_CLAS_WEAPON},  -- Rectangular Shield
	[2218]={b=2505,s=501,d=20451,c=AUCT_CLAS_WEAPON},  -- Craftsman's Dagger
	[2219]={b=2288,s=457,d=18485,c=AUCT_CLAS_WEAPON},  -- Small Round Shield
	[2220]={b=2596,s=519,d=18729,c=AUCT_CLAS_WEAPON},  -- Box Shield
	[2221]={b=4550,s=910,d=18484,c=AUCT_CLAS_WEAPON},  -- Targe Shield
	[2222]={b=5025,s=1005,d=2559,c=AUCT_CLAS_WEAPON},  -- Tower Shield
	[2223]={b=0,s=0,d=1102,c=AUCT_CLAS_WRITTEN},  -- The Collector's Schedule
	[2224]={b=122,s=24,d=6432,c=AUCT_CLAS_WEAPON},  -- Militia Dagger
	[2225]={b=916,s=183,d=20470,c=AUCT_CLAS_WEAPON},  -- Sharp Kitchen Knife
	[2226]={b=20589,s=4117,d=20372,c=AUCT_CLAS_WEAPON},  -- Ogremage Staff
	[2227]={b=20667,s=4133,d=22219,c=AUCT_CLAS_WEAPON},  -- Heavy Ogre War Axe
	[2230]={b=3570,s=714,d=6930,c=AUCT_CLAS_ARMOR},  -- Gloves of Brawn
	[2231]={b=21933,s=4386,d=16671,c=AUCT_CLAS_ARMOR},  -- Inferno Robe
	[2232]={b=4064,s=812,d=4272,c=AUCT_CLAS_ARMOR},  -- Dark Runner Boots
	[2233]={b=8452,s=1690,d=18489,c=AUCT_CLAS_ARMOR},  -- Shadow Weaver Leggings
	[2234]={b=9033,s=1806,d=8677,c=AUCT_CLAS_ARMOR},  -- Nightwalker Armor
	[2235]={b=6406,s=1281,d=20598,c=AUCT_CLAS_WEAPON},  -- Brackclaw
	[2236]={b=16931,s=3386,d=20345,c=AUCT_CLAS_WEAPON},  -- Blackfang
	[2237]={b=377,s=75,d=2628,c=AUCT_CLAS_ARMOR},  -- Patched Pants
	[2238]={b=303,s=60,d=16842,c=AUCT_CLAS_ARMOR},  -- Urchin's Pants
	[2239]={b=0,s=0,d=2854},  -- The Collector's Ring
	[2240]={b=758,s=151,d=23061,c=AUCT_CLAS_ARMOR},  -- Rugged Cape
	[2241]={b=3078,s=615,d=15248,c=AUCT_CLAS_ARMOR},  -- Desperado Cape
	[2243]={b=352770,s=70554,d=19729,c=AUCT_CLAS_WEAPON},  -- Hand of Edward the Odd
	[2244]={b=259289,s=51857,d=8090,c=AUCT_CLAS_WEAPON},  -- Krol Blade
	[2245]={b=138183,s=27636,d=15506,c=AUCT_CLAS_ARMOR},  -- Helm of Narv
	[2246]={b=120000,s=30000,d=9841,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Signet
	[2249]={b=457,s=91,d=2632,c=AUCT_CLAS_WEAPON},  -- Militia Buckler
	[2250]={b=0,s=0,d=7113},  -- Dusky Crab Cakes
	[2251]={b=48,s=12,d=7368,x=10,u=AUCT_TYPE_COOK},  -- Gooey Spider Leg
	[2252]={b=0,s=0,d=7167},  -- Miscellaneous Goblin Supplies
	[2254]={b=2534,s=506,d=19612,c=AUCT_CLAS_WEAPON},  -- Icepane Warhammer
	[2256]={b=14982,s=2996,d=5221,c=AUCT_CLAS_WEAPON},  -- Skeletal Club
	[2257]={b=944,s=188,d=20429,c=AUCT_CLAS_WEAPON},  -- Frostmane Staff
	[2258]={b=416,s=83,d=4260,c=AUCT_CLAS_WEAPON},  -- Frostmane Shortsword
	[2259]={b=378,s=75,d=19623,c=AUCT_CLAS_WEAPON},  -- Frostmane Club
	[2260]={b=532,s=106,d=8470,c=AUCT_CLAS_WEAPON},  -- Frostmane Hand Axe
	[2262]={b=34985,s=8746,d=9840,c=AUCT_CLAS_ARMOR},  -- Mark of Kern
	[2263]={b=13098,s=2619,d=5170,c=AUCT_CLAS_WEAPON},  -- Phytoblade
	[2264]={b=9788,s=1957,d=12830,c=AUCT_CLAS_ARMOR},  -- Mantle of Thieves
	[2265]={b=2387,s=477,d=19297,c=AUCT_CLAS_WEAPON},  -- Stonesplinter Axe
	[2266]={b=2396,s=479,d=20427,c=AUCT_CLAS_WEAPON},  -- Stonesplinter Dagger
	[2267]={b=3558,s=711,d=5208,c=AUCT_CLAS_WEAPON},  -- Stonesplinter Mace
	[2268]={b=732,s=146,d=20213,c=AUCT_CLAS_WEAPON},  -- Stonesplinter Blade
	[2271]={b=16278,s=3255,d=20346,c=AUCT_CLAS_WEAPON},  -- Staff of the Blessed Seer
	[2274]={b=1447,s=289,d=6883,c=AUCT_CLAS_ARMOR},  -- Sapper's Gloves
	[2276]={b=20466,s=4093,d=16996,c=AUCT_CLAS_ARMOR},  -- Swampwalker Boots
	[2277]={b=18104,s=3620,d=3173,c=AUCT_CLAS_ARMOR},  -- Necromancer Leggings
	[2278]={b=11633,s=2326,d=17190,c=AUCT_CLAS_ARMOR},  -- Forest Tracker Epaulets
	[2280]={b=20117,s=4023,d=20370,c=AUCT_CLAS_WEAPON},  -- Kam's Walking Stick
	[2281]={b=1504,s=300,d=19297,c=AUCT_CLAS_WEAPON},  -- Rodentia Flint Axe
	[2282]={b=696,s=139,d=20211,c=AUCT_CLAS_WEAPON},  -- Rodentia Shortsword
	[2283]={b=700,s=140,d=16831,c=AUCT_CLAS_ARMOR},  -- Rat Cloth Belt
	[2284]={b=1055,s=211,d=23132,c=AUCT_CLAS_ARMOR},  -- Rat Cloth Cloak
	[2287]={b=125,s=6,d=2474,q=20,x=20},  -- Haunch of Meat
	[2288]={b=0,s=0,d=18084,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Conjured Fresh Water
	[2289]={b=350,s=87,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Strength II
	[2290]={b=300,s=75,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Intellect II
	[2291]={b=222900,s=44580,d=19305,c=AUCT_CLAS_WEAPON},  -- Kang the Decapitator
	[2292]={b=6673,s=1334,d=19037,c=AUCT_CLAS_ARMOR},  -- Necrology Robes
	[2295]={b=280,s=70,d=1225,x=5},  -- Large Boar Tusk
	[2296]={b=200,s=50,d=10377,x=10,u=AUCT_TYPE_COOK},  -- Great Goretusk Snout
	[2299]={b=43784,s=8756,d=19389,c=AUCT_CLAS_WEAPON},  -- Burning War Axe
	[2300]={b=962,s=192,d=9502,c=AUCT_CLAS_ARMOR},  -- Embossed Leather Vest
	[2302]={b=147,s=29,d=4713,c=AUCT_CLAS_ARMOR},  -- Handstitched Leather Boots
	[2303]={b=358,s=71,d=9500,c=AUCT_CLAS_ARMOR},  -- Handstitched Leather Pants
	[2304]={b=60,s=15,d=7450,x=10},  -- Light Armor Kit
	[2307]={b=1216,s=243,d=17163,c=AUCT_CLAS_ARMOR},  -- Fine Leather Boots
	[2308]={b=1338,s=267,d=23028,c=AUCT_CLAS_ARMOR},  -- Fine Leather Cloak
	[2309]={b=1343,s=268,d=13864,c=AUCT_CLAS_ARMOR},  -- Embossed Leather Boots
	[2310]={b=561,s=112,d=23025,c=AUCT_CLAS_ARMOR},  -- Embossed Leather Cloak
	[2311]={b=751,s=150,d=17233,c=AUCT_CLAS_ARMOR},  -- White Leather Jerkin
	[2312]={b=905,s=181,d=5406,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_LEATHER},  -- Fine Leather Gloves
	[2313]={b=800,s=200,d=7451,x=10},  -- Medium Armor Kit
	[2314]={b=3717,s=743,d=9531,c=AUCT_CLAS_ARMOR},  -- Toughened Leather Armor
	[2315]={b=1538,s=307,d=9530,c=AUCT_CLAS_ARMOR},  -- Dark Leather Boots
	[2316]={b=2043,s=408,d=23021,c=AUCT_CLAS_ARMOR},  -- Dark Leather Cloak
	[2317]={b=3446,s=689,d=17214,c=AUCT_CLAS_ARMOR},  -- Dark Leather Tunic
	[2318]={b=60,s=15,d=7382,x=10,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Light Leather
	[2319]={b=200,s=50,d=7388,x=10,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Medium Leather
	[2320]={b=10,s=2,d=4752,x=20,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Coarse Thread
	[2321]={b=100,s=25,d=7363,x=20,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Fine Thread
	[2324]={b=25,s=6,d=18114,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Bleach
	[2325]={b=1000,s=250,d=15732,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Black Dye
	[2326]={b=145,s=29,d=16905,c=AUCT_CLAS_ARMOR},  -- Ivy-weave Bracers
	[2327]={b=182,s=36,d=17172,c=AUCT_CLAS_ARMOR},  -- Sturdy Leather Bracers
	[2361]={b=45,s=9,d=8690,c=AUCT_CLAS_WEAPON},  -- Battleworn Hammer
	[2362]={b=7,s=1,d=18730,c=AUCT_CLAS_WEAPON},  -- Worn Wooden Shield
	[2364]={b=296,s=59,d=14459,c=AUCT_CLAS_ARMOR},  -- Woven Vest
	[2366]={b=298,s=59,d=14458,c=AUCT_CLAS_ARMOR},  -- Woven Pants
	[2367]={b=223,s=44,d=14162,c=AUCT_CLAS_ARMOR},  -- Woven Boots
	[2369]={b=150,s=30,d=14457,c=AUCT_CLAS_ARMOR},  -- Woven Gloves
	[2370]={b=377,s=75,d=16871,c=AUCT_CLAS_ARMOR},  -- Battered Leather Harness
	[2371]={b=189,s=37,d=17114,c=AUCT_CLAS_ARMOR},  -- Battered Leather Belt
	[2372]={b=343,s=68,d=18478,c=AUCT_CLAS_ARMOR},  -- Battered Leather Pants
	[2373]={b=259,s=51,d=17158,c=AUCT_CLAS_ARMOR},  -- Battered Leather Boots
	[2374]={b=173,s=34,d=17002,c=AUCT_CLAS_ARMOR},  -- Battered Leather Bracers
	[2375]={b=173,s=34,d=17051,c=AUCT_CLAS_ARMOR},  -- Battered Leather Gloves
	[2376]={b=447,s=89,d=18672,c=AUCT_CLAS_WEAPON},  -- Worn Heater Shield
	[2378]={b=0,s=0,d=7251,q=20,x=20},  -- Skeleton Finger
	[2379]={b=75,s=15,d=2215,c=AUCT_CLAS_ARMOR},  -- Tarnished Chain Vest
	[2380]={b=37,s=7,d=6902,c=AUCT_CLAS_ARMOR},  -- Tarnished Chain Belt
	[2381]={b=75,s=15,d=2217,c=AUCT_CLAS_ARMOR},  -- Tarnished Chain Leggings
	[2382]={b=0,s=0,d=7269},  -- The Embalmer's Heart
	[2383]={b=57,s=11,d=6903,c=AUCT_CLAS_ARMOR},  -- Tarnished Chain Boots
	[2384]={b=37,s=7,d=6904,c=AUCT_CLAS_ARMOR},  -- Tarnished Chain Bracers
	[2385]={b=37,s=7,d=6905,c=AUCT_CLAS_ARMOR},  -- Tarnished Chain Gloves
	[2386]={b=77,s=15,d=2222,c=AUCT_CLAS_ARMOR},  -- Rusted Chain Vest
	[2387]={b=38,s=7,d=6902,c=AUCT_CLAS_ARMOR},  -- Rusted Chain Belt
	[2388]={b=77,s=15,d=2228,c=AUCT_CLAS_ARMOR},  -- Rusted Chain Leggings
	[2389]={b=59,s=11,d=6952,c=AUCT_CLAS_ARMOR},  -- Rusted Chain Boots
	[2390]={b=38,s=7,d=6953,c=AUCT_CLAS_ARMOR},  -- Rusted Chain Bracers
	[2391]={b=38,s=7,d=6954,c=AUCT_CLAS_ARMOR},  -- Rusted Chain Gloves
	[2392]={b=413,s=82,d=2265,c=AUCT_CLAS_ARMOR},  -- Light Mail Armor
	[2393]={b=206,s=41,d=6902,c=AUCT_CLAS_ARMOR},  -- Light Mail Belt
	[2394]={b=416,s=83,d=2217,c=AUCT_CLAS_ARMOR},  -- Light Mail Leggings
	[2395]={b=322,s=64,d=6903,c=AUCT_CLAS_ARMOR},  -- Light Mail Boots
	[2396]={b=215,s=43,d=6904,c=AUCT_CLAS_ARMOR},  -- Light Mail Bracers
	[2397]={b=215,s=43,d=6955,c=AUCT_CLAS_ARMOR},  -- Light Mail Gloves
	[2398]={b=434,s=86,d=2269,c=AUCT_CLAS_ARMOR},  -- Light Chain Armor
	[2399]={b=217,s=43,d=6902,c=AUCT_CLAS_ARMOR},  -- Light Chain Belt
	[2400]={b=437,s=87,d=2270,c=AUCT_CLAS_ARMOR},  -- Light Chain Leggings
	[2401]={b=330,s=66,d=6952,c=AUCT_CLAS_ARMOR},  -- Light Chain Boots
	[2402]={b=219,s=43,d=6953,c=AUCT_CLAS_ARMOR},  -- Light Chain Bracers
	[2403]={b=220,s=44,d=6954,c=AUCT_CLAS_ARMOR},  -- Light Chain Gloves
	[2406]={b=100,s=25,d=15274},  -- Pattern: Fine Leather Boots
	[2407]={b=650,s=162,d=1102},  -- Pattern: White Leather Jerkin
	[2408]={b=500,s=125,d=15274,u=AUCT_TYPE_LEATHER},  -- Pattern: Fine Leather Gloves
	[2409]={b=1400,s=350,d=15274},  -- Pattern: Dark Leather Tunic
	[2411]={b=800000,s=0,d=13108},  -- Black Stallion Bridle
	[2414]={b=800000,s=0,d=13108},  -- Pinto Bridle
	[2417]={b=15673,s=3134,d=8634,c=AUCT_CLAS_ARMOR},  -- Augmented Chain Vest
	[2418]={b=15731,s=3146,d=2969,c=AUCT_CLAS_ARMOR},  -- Augmented Chain Leggings
	[2419]={b=7894,s=1578,d=6819,c=AUCT_CLAS_ARMOR},  -- Augmented Chain Belt
	[2420]={b=11937,s=2387,d=6820,c=AUCT_CLAS_ARMOR},  -- Augmented Chain Boots
	[2421]={b=7952,s=1590,d=6821,c=AUCT_CLAS_ARMOR},  -- Augmented Chain Bracers
	[2422]={b=7981,s=1596,d=6822,c=AUCT_CLAS_ARMOR},  -- Augmented Chain Gloves
	[2423]={b=42770,s=8554,d=8642,c=AUCT_CLAS_ARMOR},  -- Brigandine Vest
	[2424]={b=21461,s=4292,d=6853,c=AUCT_CLAS_ARMOR},  -- Brigandine Belt
	[2425]={b=43077,s=8615,d=2976,c=AUCT_CLAS_ARMOR},  -- Brigandine Leggings
	[2426]={b=32568,s=6513,d=6854,c=AUCT_CLAS_ARMOR},  -- Brigandine Boots
	[2427]={b=20146,s=4029,d=6855,c=AUCT_CLAS_ARMOR},  -- Brigandine Bracers
	[2428]={b=20222,s=4044,d=6856,c=AUCT_CLAS_ARMOR},  -- Brigandine Gloves
	[2429]={b=10138,s=2027,d=14484,c=AUCT_CLAS_ARMOR},  -- Russet Vest
	[2431]={b=10215,s=2043,d=14483,c=AUCT_CLAS_ARMOR},  -- Russet Pants
	[2432]={b=7690,s=1538,d=1861,c=AUCT_CLAS_ARMOR},  -- Russet Boots
	[2434]={b=5165,s=1033,d=14482,c=AUCT_CLAS_ARMOR},  -- Russet Gloves
	[2435]={b=27683,s=5536,d=16769,c=AUCT_CLAS_ARMOR},  -- Embroidered Armor
	[2437]={b=27890,s=5578,d=16770,c=AUCT_CLAS_ARMOR},  -- Embroidered Pants
	[2438]={b=20996,s=4199,d=16772,c=AUCT_CLAS_ARMOR},  -- Embroidered Boots
	[2440]={b=14099,s=2819,d=16771,c=AUCT_CLAS_ARMOR},  -- Embroidered Gloves
	[2445]={b=3433,s=686,d=18749,c=AUCT_CLAS_WEAPON},  -- Large Metal Shield
	[2446]={b=6182,s=1236,d=18733,c=AUCT_CLAS_WEAPON},  -- Kite Shield
	[2447]={b=40,s=10,d=7396,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Peacebloom
	[2448]={b=16158,s=3231,d=18732,c=AUCT_CLAS_WEAPON},  -- Heavy Pavise
	[2449]={b=80,s=20,d=1464,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Earthroot
	[2450]={b=100,s=25,d=7406,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Briarthorn
	[2451]={b=43629,s=8725,d=18772,c=AUCT_CLAS_WEAPON},  -- Crested Heater Shield
	[2452]={b=60,s=15,d=7241,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_COOK},  -- Swiftthistle
	[2453]={b=100,s=25,d=7337,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Bruiseweed
	[2454]={b=80,s=20,d=15733,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Lion's Strength
	[2455]={b=40,s=10,d=15715,x=5,u=AUCT_TYPE_TAILOR},  -- Minor Mana Potion
	[2456]={b=60,s=15,d=2345,x=5,c=AUCT_CLAS_POTION},  -- Minor Rejuvenation Potion
	[2457]={b=60,s=15,d=15738,x=5,c=AUCT_CLAS_POTION,u=AUCT_TYPE_LEATHER},  -- Elixir of Minor Agility
	[2458]={b=60,s=15,d=15792,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Minor Fortitude
	[2459]={b=100,s=25,d=15742,x=5,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH},  -- Swiftness Potion
	[2463]={b=13695,s=2739,d=16900,c=AUCT_CLAS_ARMOR},  -- Studded Doublet
	[2464]={b=6871,s=1374,d=11558,c=AUCT_CLAS_ARMOR},  -- Studded Belt
	[2465]={b=12477,s=2495,d=17031,c=AUCT_CLAS_ARMOR},  -- Studded Pants
	[2466]={b=0,s=0,d=6368,q=20,x=20},  -- Skullsplitter Fetish
	[2467]={b=9430,s=1886,d=17165,c=AUCT_CLAS_ARMOR},  -- Studded Boots
	[2468]={b=6310,s=1262,d=17020,c=AUCT_CLAS_ARMOR},  -- Studded Bracers
	[2469]={b=6334,s=1266,d=17027,c=AUCT_CLAS_ARMOR},  -- Studded Gloves
	[2470]={b=33952,s=6790,d=14496,c=AUCT_CLAS_ARMOR},  -- Reinforced Leather Vest
	[2471]={b=17040,s=3408,d=14492,c=AUCT_CLAS_ARMOR},  -- Reinforced Leather Belt
	[2472]={b=34211,s=6842,d=14495,c=AUCT_CLAS_ARMOR},  -- Reinforced Leather Pants
	[2473]={b=25753,s=5150,d=14295,c=AUCT_CLAS_ARMOR},  -- Reinforced Leather Boots
	[2474]={b=17233,s=3446,d=14493,c=AUCT_CLAS_ARMOR},  -- Reinforced Leather Bracers
	[2475]={b=17298,s=3459,d=2686,c=AUCT_CLAS_ARMOR},  -- Reinforced Leather Gloves
	[2476]={b=0,s=0,d=2376,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Chilled Basilisk Haunch
	[2477]={b=0,s=0,d=23527,q=20,x=20},  -- Ravager's Skull
	[2479]={b=107,s=21,d=8512,c=AUCT_CLAS_WEAPON},  -- Broad Axe
	[2480]={b=72,s=14,d=19601,c=AUCT_CLAS_WEAPON},  -- Large Club
	[2488]={b=536,s=107,d=22078,c=AUCT_CLAS_WEAPON},  -- Gladius
	[2489]={b=342,s=68,d=22094,c=AUCT_CLAS_WEAPON},  -- Two-handed Sword
	[2490]={b=540,s=108,d=8488,c=AUCT_CLAS_WEAPON},  -- Tomahawk
	[2491]={b=484,s=96,d=22112,c=AUCT_CLAS_WEAPON},  -- Large Axe
	[2492]={b=284,s=56,d=12992,c=AUCT_CLAS_WEAPON},  -- Cudgel
	[2493]={b=701,s=140,d=22121,c=AUCT_CLAS_WEAPON},  -- Wooden Mallet
	[2494]={b=401,s=80,d=22136,c=AUCT_CLAS_WEAPON},  -- Stiletto
	[2495]={b=504,s=100,d=7310,c=AUCT_CLAS_WEAPON},  -- Walking Stick
	[2504]={b=29,s=5,d=8106,c=AUCT_CLAS_WEAPON},  -- Worn Shortbow
	[2505]={b=59,s=11,d=20723,c=AUCT_CLAS_WEAPON},  -- Polished Shortbow
	[2506]={b=285,s=57,d=20722,c=AUCT_CLAS_WEAPON},  -- Hornwood Recurve Bow
	[2507]={b=1751,s=350,d=20714,c=AUCT_CLAS_WEAPON},  -- Laminated Recurve Bow
	[2508]={b=27,s=5,d=6606,c=AUCT_CLAS_WEAPON},  -- Old Blunderbuss
	[2509]={b=414,s=82,d=6607,c=AUCT_CLAS_WEAPON},  -- Ornate Blunderbuss
	[2510]={b=41,s=8,d=6594,c=AUCT_CLAS_WEAPON},  -- Solid Blunderbuss
	[2511]={b=1324,s=264,d=20728,c=AUCT_CLAS_WEAPON},  -- Hunter's Boomstick
	[2512]={b=10,s=0,d=5996,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Rough Arrow
	[2515]={b=50,s=0,d=5996,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Sharp Arrow
	[2516]={b=10,s=0,d=5998,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Light Shot
	[2519]={b=50,s=0,d=5998,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Heavy Shot
	[2520]={b=24628,s=4925,d=22085,c=AUCT_CLAS_WEAPON},  -- Broadsword
	[2521]={b=30896,s=6179,d=22084,c=AUCT_CLAS_WEAPON},  -- Flamberge
	[2522]={b=22548,s=4509,d=8485,c=AUCT_CLAS_WEAPON},  -- Crescent Axe
	[2523]={b=28285,s=5657,d=22216,c=AUCT_CLAS_WEAPON},  -- Bullova
	[2524]={b=19192,s=3838,d=8803,c=AUCT_CLAS_WEAPON},  -- Truncheon
	[2525]={b=26489,s=5297,d=22133,c=AUCT_CLAS_WEAPON},  -- War Hammer
	[2526]={b=19336,s=3867,d=22141,c=AUCT_CLAS_WEAPON},  -- Main Gauche
	[2527]={b=29356,s=5871,d=22150,c=AUCT_CLAS_WEAPON},  -- Battle Staff
	[2528]={b=51836,s=10367,d=22081,c=AUCT_CLAS_WEAPON},  -- Falchion
	[2529]={b=65031,s=13006,d=22098,c=AUCT_CLAS_WEAPON},  -- Zweihander
	[2530]={b=52219,s=10443,d=22105,c=AUCT_CLAS_WEAPON},  -- Francisca
	[2531]={b=56169,s=11233,d=22111,c=AUCT_CLAS_WEAPON},  -- Great Axe
	[2532]={b=52608,s=10521,d=22120,c=AUCT_CLAS_WEAPON},  -- Morning Star
	[2533]={b=61107,s=12221,d=22134,c=AUCT_CLAS_WEAPON},  -- War Maul
	[2534]={b=45431,s=9086,d=22140,c=AUCT_CLAS_WEAPON},  -- Rondel
	[2535]={b=61556,s=12311,d=20389,c=AUCT_CLAS_WEAPON},  -- War Staff
	[2536]={b=0,s=0,d=6630,q=20,x=20},  -- Trogg Stone Tooth
	[2545]={b=8984,s=1796,d=3043,c=AUCT_CLAS_ARMOR},  -- Malleable Chain Leggings
	[2546]={b=276,s=55,d=6981,c=AUCT_CLAS_ARMOR},  -- Royal Frostmane Girdle
	[2547]={b=36,s=7,d=6905,c=AUCT_CLAS_ARMOR},  -- Boar Handler Gloves
	[2548]={b=0,s=0,d=7922},  -- Barrel of Barleybrew Scalder
	[2549]={b=25082,s=5016,d=20330,c=AUCT_CLAS_WEAPON},  -- Staff of the Shade
	[2553]={b=100,s=25,d=1301,u=AUCT_TYPE_LEATHER},  -- Recipe: Elixir of Minor Agility
	[2555]={b=160,s=40,d=15274,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH},  -- Recipe: Swiftness Potion
	[2560]={b=0,s=0,d=1143,c=AUCT_CLAS_WRITTEN},  -- Jitters' Completed Journal
	[2561]={b=0,s=0,d=1310},  -- Chok'sul's Head
	[2562]={b=2300,s=575,d=6488,c=AUCT_CLAS_WEAPON},  -- Bouquet of Scarlet Begonias
	[2563]={b=0,s=0,d=6396},  -- Strange Smelling Powder
	[2564]={b=34085,s=6817,d=4485,c=AUCT_CLAS_ARMOR},  -- Elven Spirit Claws
	[2565]={b=12453,s=3113,d=6555,c=AUCT_CLAS_WEAPON},  -- Rod of Molten Fire
	[2566]={b=6613,s=1322,d=16666,c=AUCT_CLAS_ARMOR},  -- Sacrificial Robes
	[2567]={b=12546,s=2509,d=20590,c=AUCT_CLAS_WEAPON},  -- Evocator's Blade
	[2568]={b=156,s=31,d=17125,c=AUCT_CLAS_ARMOR},  -- Brown Linen Vest
	[2569]={b=437,s=87,d=17120,c=AUCT_CLAS_ARMOR},  -- Linen Boots
	[2570]={b=55,s=11,d=23122,c=AUCT_CLAS_ARMOR},  -- Linen Cloak
	[2571]={b=84,s=16,d=2486,c=AUCT_CLAS_ARMOR},  -- Viny Wrappings
	[2572]={b=496,s=99,d=12687,c=AUCT_CLAS_ARMOR},  -- Red Linen Robe
	[2575]={b=100,s=25,d=10840,c=AUCT_CLAS_ARMOR},  -- Red Linen Shirt
	[2576]={b=300,s=75,d=10834,c=AUCT_CLAS_ARMOR},  -- White Linen Shirt
	[2577]={b=300,s=75,d=10845,c=AUCT_CLAS_ARMOR},  -- Blue Linen Shirt
	[2578]={b=1120,s=224,d=10891,c=AUCT_CLAS_ARMOR},  -- Barbaric Linen Vest
	[2579]={b=150,s=37,d=12864,c=AUCT_CLAS_ARMOR},  -- Green Linen Shirt
	[2580]={b=338,s=67,d=23133,c=AUCT_CLAS_ARMOR},  -- Reinforced Linen Cape
	[2581]={b=80,s=20,d=11908,x=20},  -- Heavy Linen Bandage
	[2582]={b=1082,s=216,d=12394,c=AUCT_CLAS_ARMOR},  -- Green Woolen Vest
	[2583]={b=1796,s=359,d=13524,c=AUCT_CLAS_ARMOR},  -- Woolen Boots
	[2584]={b=711,s=142,d=23144,c=AUCT_CLAS_ARMOR},  -- Woolen Cape
	[2585]={b=3193,s=638,d=12669,c=AUCT_CLAS_ARMOR},  -- Gray Woolen Robe
	[2586]={b=6,s=1,d=22033,c=AUCT_CLAS_ARMOR},  -- Gamemaster's Robe
	[2587]={b=800,s=200,d=10892,c=AUCT_CLAS_ARMOR},  -- Gray Woolen Shirt
	[2589]={b=55,s=13,d=7383,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_FSTAID..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Linen Cloth
	[2590]={b=20,s=5,d=18597,x=5},  -- Forest Spider Webbing
	[2591]={b=20,s=5,d=1329,x=5,c=AUCT_CLAS_CLOTH},  -- Dirty Trogg Cloth
	[2592]={b=135,s=33,d=7418,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_FSTAID..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Wool Cloth
	[2593]={b=150,s=37,d=6373,x=20},  -- Flask of Port
	[2594]={b=1500,s=375,d=18115,x=20},  -- Flagon of Mead
	[2595]={b=2000,s=500,d=7921,x=20},  -- Jug of Bourbon
	[2596]={b=120,s=30,d=18085,x=20,u=AUCT_TYPE_COOK},  -- Skin of Dwarven Stout
	[2598]={b=120,s=30,d=15274},  -- Pattern: Red Linen Robe
	[2601]={b=400,s=100,d=15274},  -- Pattern: Gray Woolen Robe
	[2604]={b=50,s=12,d=7349,x=10,u=AUCT_TYPE_TAILOR},  -- Red Dye
	[2605]={b=100,s=25,d=6373,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Green Dye
	[2606]={b=0,s=0,d=2515},  -- Lurker Venom
	[2607]={b=0,s=0,d=2516},  -- Mo'grosh Crystal
	[2608]={b=255,s=63,d=6703,x=5},  -- Threshadon Ambergris
	[2609]={b=0,s=0,d=2637},  -- Disarming Colloid
	[2610]={b=0,s=0,d=6396},  -- Disarming Mixture
	[2611]={b=0,s=0,d=18107,q=20,x=20},  -- Crude Flint
	[2612]={b=163,s=32,d=12704,c=AUCT_CLAS_ARMOR},  -- Plain Robe
	[2613]={b=607,s=121,d=12661,c=AUCT_CLAS_ARMOR},  -- Double-stitched Robes
	[2614]={b=1161,s=232,d=16614,c=AUCT_CLAS_ARMOR},  -- Robe of Apprenticeship
	[2615]={b=5091,s=1018,d=12655,c=AUCT_CLAS_ARMOR},  -- Chromatic Robe
	[2616]={b=2659,s=531,d=12701,c=AUCT_CLAS_ARMOR},  -- Shimmering Silk Robes
	[2617]={b=10991,s=2198,d=12654,c=AUCT_CLAS_ARMOR},  -- Burning Robes
	[2618]={b=26639,s=5327,d=12702,c=AUCT_CLAS_ARMOR},  -- Silver Dress Robes
	[2619]={b=0,s=0,d=3029,c=AUCT_CLAS_WRITTEN},  -- Grelin's Report
	[2620]={b=15067,s=3013,d=15284,c=AUCT_CLAS_ARMOR},  -- Augural Shroud
	[2621]={b=11787,s=2357,d=15295,c=AUCT_CLAS_ARMOR},  -- Cowl of Necromancy
	[2622]={b=13015,s=2603,d=13244,c=AUCT_CLAS_ARMOR},  -- Nimar's Tribal Headdress
	[2623]={b=17772,s=3554,d=15336,c=AUCT_CLAS_ARMOR},  -- Holy Diadem
	[2624]={b=19264,s=3852,d=15547,c=AUCT_CLAS_ARMOR},  -- Thinking Cap
	[2625]={b=0,s=0,d=12931},  -- Menethil Statuette
	[2628]={b=0,s=0,d=3048,c=AUCT_CLAS_WRITTEN},  -- Senir's Report
	[2629]={b=0,s=0,d=6710},  -- Intrepid Strongbox Key
	[2632]={b=3029,s=605,d=20473,c=AUCT_CLAS_WEAPON},  -- Curved Dagger
	[2633]={b=100,s=25,d=2533,x=10},  -- Jungle Remedy
	[2634]={b=0,s=0,d=7283},  -- Venom Fern Extract
	[2635]={b=82,s=16,d=6902,c=AUCT_CLAS_ARMOR},  -- Loose Chain Belt
	[2636]={b=0,s=0,d=2551,q=20,x=20},  -- Carved Stone Idol
	[2637]={b=0,s=0,d=924,c=AUCT_CLAS_WRITTEN},  -- Ironband's Progress Report
	[2639]={b=0,s=0,d=2571,c=AUCT_CLAS_WRITTEN},  -- Merrin's Letter
	[2640]={b=0,s=0,d=7166,q=20,x=20},  -- Miners' Gear
	[2642]={b=166,s=33,d=6903,c=AUCT_CLAS_ARMOR},  -- Loose Chain Boots
	[2643]={b=144,s=28,d=6904,c=AUCT_CLAS_ARMOR},  -- Loose Chain Bracers
	[2644]={b=56,s=11,d=15082,c=AUCT_CLAS_ARMOR},  -- Loose Chain Cloak
	[2645]={b=56,s=11,d=6905,c=AUCT_CLAS_ARMOR},  -- Loose Chain Gloves
	[2646]={b=159,s=31,d=2217,c=AUCT_CLAS_ARMOR},  -- Loose Chain Pants
	[2648]={b=293,s=58,d=2215,c=AUCT_CLAS_ARMOR},  -- Loose Chain Vest
	[2649]={b=7,s=1,d=6902,c=AUCT_CLAS_ARMOR},  -- Flimsy Chain Belt
	[2650]={b=16,s=3,d=6903,c=AUCT_CLAS_ARMOR},  -- Flimsy Chain Boots
	[2651]={b=16,s=3,d=6904,c=AUCT_CLAS_ARMOR},  -- Flimsy Chain Bracers
	[2652]={b=36,s=7,d=15164,c=AUCT_CLAS_ARMOR},  -- Flimsy Chain Cloak
	[2653]={b=15,s=3,d=6905,c=AUCT_CLAS_ARMOR},  -- Flimsy Chain Gloves
	[2654]={b=14,s=2,d=2217,c=AUCT_CLAS_ARMOR},  -- Flimsy Chain Pants
	[2656]={b=48,s=9,d=2215,c=AUCT_CLAS_ARMOR},  -- Flimsy Chain Vest
	[2657]={b=3500,s=875,d=981,c=AUCT_CLAS_CONTAINER},  -- Red Leather Bag
	[2658]={b=0,s=0,d=18103},  -- Ados Fragment
	[2659]={b=0,s=0,d=18105},  -- Modr Fragment
	[2660]={b=0,s=0,d=18104},  -- Golm Fragment
	[2661]={b=0,s=0,d=18106},  -- Neru Fragment
	[2662]={b=35000,s=8750,d=21712,c=AUCT_CLAS_CONTAINER},  -- Ribbly's Quiver
	[2663]={b=35000,s=8750,d=1816,c=AUCT_CLAS_CONTAINER},  -- Ribbly's Bandolier
	[2665]={b=20,s=5,d=6396,x=20,u=AUCT_TYPE_COOK},  -- Stormwind Seasoning Herbs
	[2666]={b=0,s=0,d=7923},  -- Barrel of Thunder Ale
	[2667]={b=0,s=0,d=2599},  -- MacGrann's Dried Meats
	[2671]={b=0,s=0,d=6655,q=20,x=20},  -- Wendigo Mane
	[2672]={b=16,s=4,d=6680,x=10,u=AUCT_TYPE_COOK},  -- Stringy Wolf Meat
	[2673]={b=40,s=10,d=25467,x=10,u=AUCT_TYPE_COOK},  -- Coyote Meat
	[2674]={b=48,s=12,d=22193,x=10,u=AUCT_TYPE_COOK},  -- Crawler Meat
	[2675]={b=44,s=11,d=8743,x=10,u=AUCT_TYPE_COOK},  -- Crawler Claw
	[2676]={b=0,s=0,d=7241,q=20,x=20},  -- Shimmerweed
	[2677]={b=60,s=15,d=2473,x=10,u=AUCT_TYPE_COOK},  -- Boar Ribs
	[2678]={b=10,s=0,d=1443,q=20,x=20,u=AUCT_TYPE_COOK},  -- Mild Spices
	[2679]={b=20,s=5,d=2474,x=20,c=AUCT_CLAS_FOOD},  -- Charred Wolf Meat
	[2680]={b=40,s=10,d=25468,x=20,c=AUCT_CLAS_FOOD},  -- Spiced Wolf Meat
	[2681]={b=24,s=6,d=2474,x=20,c=AUCT_CLAS_FOOD},  -- Roasted Boar Meat
	[2682]={b=100,s=25,d=2627,x=20,c=AUCT_CLAS_FOOD},  -- Cooked Crab Claw
	[2683]={b=100,s=25,d=6345,x=20,c=AUCT_CLAS_FOOD},  -- Crab Cake
	[2684]={b=80,s=20,d=25468,x=20,c=AUCT_CLAS_FOOD},  -- Coyote Steak
	[2685]={b=300,s=75,d=2473,x=20,c=AUCT_CLAS_FOOD},  -- Succulent Pork Ribs
	[2686]={b=50,s=12,d=18117,x=10},  -- Thunder Ale
	[2687]={b=100,s=25,d=21327,x=20,c=AUCT_CLAS_FOOD},  -- Dry Pork Ribs
	[2690]={b=38,s=7,d=28201,c=AUCT_CLAS_ARMOR},  -- Latched Belt
	[2691]={b=54,s=10,d=6903,c=AUCT_CLAS_ARMOR},  -- Outfitter Boots
	[2692]={b=40,s=10,d=1443,x=20,u=AUCT_TYPE_COOK},  -- Hot Spices
	[2694]={b=2697,s=539,d=28250,c=AUCT_CLAS_ARMOR},  -- Settler's Leggings
	[2696]={b=0,s=0,d=7922},  -- Cask of Evershine
	[2697]={b=400,s=100,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Goretusk Liver Pie
	[2698]={b=400,s=100,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Cooked Crab Claw
	[2699]={b=800,s=200,d=1102},  -- Recipe: Redridge Goulash
	[2700]={b=400,s=100,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Succulent Pork Ribs
	[2701]={b=1600,s=400,d=1102},  -- Recipe: Seasoned Wolf Kabob
	[2702]={b=0,s=0,d=7158,q=20,x=20},  -- Lightforge Ingot
	[2712]={b=0,s=0,d=7916},  -- Crate of Lightforge Ingots
	[2713]={b=0,s=0,d=28952},  -- Ol' Sooty's Head
	[2719]={b=0,s=0,d=6710},  -- Small Brass Key
	[2720]={b=0,s=0,d=1102,c=AUCT_CLAS_WRITTEN},  -- Muddy Note
	[2721]={b=9914,s=1982,d=16826,c=AUCT_CLAS_ARMOR},  -- Holy Shroud
	[2722]={b=0,s=0,d=1102},  -- Wine Ticket
	[2723]={b=50,s=12,d=18079,x=20},  -- Bottle of Pinot Noir
	[2724]={b=0,s=0,d=1323,c=AUCT_CLAS_WRITTEN},  -- Cloth Request
	[2725]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 1
	[2728]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 4
	[2730]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 6
	[2732]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 8
	[2734]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 10
	[2735]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 11
	[2738]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 14
	[2740]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 16
	[2742]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 18
	[2744]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 20
	[2745]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 21
	[2748]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 24
	[2749]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 25
	[2750]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 26
	[2751]={b=1500,s=375,d=7629,x=10,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Page 27
	[2754]={b=69,s=13,d=20117,c=AUCT_CLAS_WEAPON},  -- Tarnished Bastard Sword
	[2756]={b=0,s=0,d=7596,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Chapter I
	[2757]={b=0,s=0,d=7596,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Chapter II
	[2758]={b=0,s=0,d=7596,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Chapter III
	[2759]={b=0,s=0,d=7596,c=AUCT_CLAS_WRITTEN},  -- Green Hills of Stranglethorn - Chapter IV
	[2760]={b=0,s=0,d=6430},  -- Thurman's Sewing Kit
	[2763]={b=1203,s=240,d=6437,c=AUCT_CLAS_WEAPON},  -- Fisherman Knife
	[2764]={b=2202,s=440,d=6444,c=AUCT_CLAS_WEAPON},  -- Small Dagger
	[2765]={b=4057,s=811,d=20383,c=AUCT_CLAS_WEAPON},  -- Hunting Knife
	[2766]={b=7823,s=1564,d=6445,c=AUCT_CLAS_WEAPON},  -- Deft Stiletto
	[2770]={b=20,s=5,d=4681,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_MINING},  -- Copper Ore
	[2771]={b=100,s=25,d=4690,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_MINING},  -- Tin Ore
	[2772]={b=600,s=150,d=4689,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_MINING},  -- Iron Ore
	[2773]={b=195,s=39,d=2786,c=AUCT_CLAS_WEAPON},  -- Cracked Shortbow
	[2774]={b=140,s=28,d=20654,c=AUCT_CLAS_WEAPON},  -- Rust-covered Blunderbuss
	[2775]={b=300,s=75,d=18107,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_MINING},  -- Silver Ore
	[2776]={b=2000,s=500,d=4681,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_MINING},  -- Gold Ore
	[2777]={b=734,s=146,d=2787,c=AUCT_CLAS_WEAPON},  -- Feeble Shortbow
	[2778]={b=737,s=147,d=20654,c=AUCT_CLAS_WEAPON},  -- Cheap Blunderbuss
	[2779]={b=0,s=0,d=2788},  -- Tear of Tilloa
	[2780]={b=1872,s=374,d=20712,c=AUCT_CLAS_WEAPON},  -- Light Hunting Bow
	[2781]={b=1676,s=335,d=20979,c=AUCT_CLAS_WEAPON},  -- Dirty Blunderbuss
	[2782]={b=3759,s=751,d=20671,c=AUCT_CLAS_WEAPON},  -- Mishandled Recurve Bow
	[2783]={b=2954,s=590,d=20717,c=AUCT_CLAS_WEAPON},  -- Shoddy Blunderbuss
	[2784]={b=0,s=0,d=2793},  -- Musquash Root
	[2785]={b=5311,s=1062,d=20668,c=AUCT_CLAS_WEAPON},  -- Stiff Recurve Bow
	[2786]={b=5865,s=1173,d=20718,c=AUCT_CLAS_WEAPON},  -- Oiled Blunderbuss
	[2787]={b=53,s=10,d=20534,c=AUCT_CLAS_WEAPON},  -- Trogg Dagger
	[2788]={b=0,s=0,d=18115},  -- Black Claw Stout
	[2794]={b=0,s=0,d=1143,c=AUCT_CLAS_QUEST},  -- An Old History Book
	[2795]={b=0,s=0,d=1143},  -- Book: Stresses of Iron
	[2797]={b=0,s=0,d=3422},  -- Heart of Mokk
	[2798]={b=0,s=0,d=4689,q=20,x=20},  -- Rethban Ore
	[2799]={b=270,s=67,d=7129,x=20},  -- Gorilla Fang
	[2800]={b=7625,s=1525,d=21114,c=AUCT_CLAS_ARMOR},  -- Black Velvet Robes
	[2801]={b=523648,s=104729,d=5193,c=AUCT_CLAS_WEAPON},  -- Blade of Hanna
	[2802]={b=6500,s=1625,d=6484,c=AUCT_CLAS_ARMOR},  -- Blazing Emblem
	[2805]={b=11762,s=2352,d=23084,c=AUCT_CLAS_ARMOR},  -- Yeti Fur Cloak
	[2806]={b=0,s=0,d=1244},  -- Package for Stormpike
	[2807]={b=12264,s=2452,d=9118,c=AUCT_CLAS_WEAPON},  -- Guillotine Axe
	[2815]={b=98890,s=19778,d=8467,c=AUCT_CLAS_WEAPON},  -- Curve-bladed Ripper
	[2816]={b=36620,s=7324,d=19669,c=AUCT_CLAS_WEAPON},  -- Death Speaker Scepter
	[2817]={b=1006,s=201,d=17103,c=AUCT_CLAS_ARMOR},  -- Soft Leather Tunic
	[2818]={b=1817,s=363,d=1963,c=AUCT_CLAS_ARMOR},  -- Stretched Leather Trousers
	[2819]={b=19152,s=3830,d=6443,c=AUCT_CLAS_WEAPON},  -- Cross Dagger
	[2820]={b=18650,s=4662,d=6540,c=AUCT_CLAS_ARMOR},  -- Nifty Stopwatch
	[2821]={b=5589,s=1117,d=19633,c=AUCT_CLAS_WEAPON},  -- Mo'grosh Masher
	[2822]={b=7012,s=1402,d=20091,c=AUCT_CLAS_WEAPON},  -- Mo'grosh Toothpick
	[2823]={b=8092,s=1618,d=19236,c=AUCT_CLAS_WEAPON},  -- Mo'grosh Can Opener
	[2824]={b=160159,s=32031,d=20554,c=AUCT_CLAS_WEAPON},  -- Hurricane
	[2825]={b=73609,s=14721,d=20552,c=AUCT_CLAS_WEAPON},  -- Bow of Searing Arrows
	[2828]={b=0,s=0,d=7105},  -- Nissa's Remains
	[2829]={b=0,s=0,d=2853},  -- Gregor's Remains
	[2830]={b=0,s=0,d=2853},  -- Thurman's Remains
	[2831]={b=0,s=0,d=2853},  -- Devlin's Remains
	[2832]={b=0,s=0,d=811,c=AUCT_CLAS_WRITTEN},  -- Verna's Westfall Stew Recipe
	[2833]={b=0,s=0,d=7139},  -- The Lich's Spellbook
	[2834]={b=0,s=0,d=3152,q=20,x=20},  -- Embalming Ichor
	[2835]={b=8,s=2,d=4714,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Rough Stone
	[2836]={b=60,s=15,d=4715,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Coarse Stone
	[2837]={b=0,s=0,d=924,c=AUCT_CLAS_WRITTEN},  -- Thurman's Letter
	[2838]={b=240,s=60,d=4716,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Heavy Stone
	[2839]={b=0,s=0,d=924,c=AUCT_CLAS_QUEST},  -- A Letter to Yvette
	[2840]={b=40,s=10,d=7391,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_MINING..", "..AUCT_TYPE_SMITH},  -- Copper Bar
	[2841]={b=200,s=50,d=7390,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Bronze Bar
	[2842]={b=400,s=100,d=7355,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Silver Bar
	[2843]={b=0,s=0,d=18074,q=20,x=20},  -- Dirty Knucklebones
	[2844]={b=530,s=106,d=2861,c=AUCT_CLAS_WEAPON},  -- Copper Mace
	[2845]={b=546,s=109,d=14035,c=AUCT_CLAS_WEAPON},  -- Copper Axe
	[2846]={b=0,s=0,d=3225,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Tirisfal Pumpkin
	[2847]={b=551,s=110,d=4805,c=AUCT_CLAS_WEAPON},  -- Copper Shortsword
	[2848]={b=5595,s=1119,d=5198,c=AUCT_CLAS_WEAPON},  -- Bronze Mace
	[2849]={b=6345,s=1269,d=19929,c=AUCT_CLAS_WEAPON},  -- Bronze Axe
	[2850]={b=7197,s=1439,d=3855,c=AUCT_CLAS_WEAPON},  -- Bronze Shortsword
	[2851]={b=282,s=56,d=23529,c=AUCT_CLAS_ARMOR},  -- Copper Chain Belt
	[2852]={b=335,s=67,d=13095,c=AUCT_CLAS_ARMOR},  -- Copper Chain Pants
	[2853]={b=85,s=17,d=6966,c=AUCT_CLAS_ARMOR},  -- Copper Bracers
	[2854]={b=1127,s=225,d=25851,c=AUCT_CLAS_ARMOR},  -- Runed Copper Bracers
	[2855]={b=0,s=0,d=7207,q=20,x=20},  -- Putrid Claw
	[2856]={b=0,s=0,d=2868,q=20,x=20},  -- Iron Pike
	[2857]={b=991,s=198,d=25852,c=AUCT_CLAS_ARMOR},  -- Runed Copper Belt
	[2858]={b=0,s=0,d=2873,q=20,x=20},  -- Darkhound Blood
	[2859]={b=0,s=0,d=2874,q=20,x=20},  -- Vile Fin Scale
	[2862]={b=12,s=3,d=24673,x=20},  -- Rough Sharpening Stone
	[2863]={b=40,s=10,d=24674,x=20},  -- Coarse Sharpening Stone
	[2864]={b=3150,s=630,d=25848,c=AUCT_CLAS_ARMOR},  -- Runed Copper Breastplate
	[2865]={b=4810,s=962,d=4333,c=AUCT_CLAS_ARMOR},  -- Rough Bronze Leggings
	[2866]={b=3764,s=752,d=23530,c=AUCT_CLAS_ARMOR},  -- Rough Bronze Cuirass
	[2868]={b=4035,s=807,d=23533,c=AUCT_CLAS_ARMOR},  -- Patterned Bronze Bracers
	[2869]={b=9155,s=1831,d=9403,c=AUCT_CLAS_ARMOR},  -- Silvered Bronze Breastplate
	[2870]={b=14677,s=2935,d=23540,c=AUCT_CLAS_ARMOR},  -- Shining Silver Breastplate
	[2871]={b=160,s=40,d=24675,x=20},  -- Heavy Sharpening Stone
	[2872]={b=0,s=0,d=2885,q=20,x=20},  -- Vicious Night Web Spider Venom
	[2874]={b=0,s=0,d=3020,c=AUCT_CLAS_QUEST},  -- An Unsent Letter
	[2875]={b=0,s=0,d=11990,q=20,x=20},  -- Scarlet Insignia Ring
	[2876]={b=0,s=0,d=6660,q=20,x=20},  -- Duskbat Pelt
	[2877]={b=42623,s=8524,d=20151,c=AUCT_CLAS_WEAPON},  -- Combatant Claymore
	[2878]={b=25718,s=5143,d=8456,c=AUCT_CLAS_WEAPON},  -- Bearded Boneaxe
	[2879]={b=15605,s=3121,d=13109,c=AUCT_CLAS_WEAPON},  -- Antipodean Rod
	[2880]={b=100,s=25,d=7417,x=10,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Weak Flux
	[2881]={b=600,s=150,d=15274},  -- Plans: Runed Copper Breastplate
	[2882]={b=1200,s=300,d=15274},  -- Plans: Silvered Bronze Shoulders
	[2883]={b=1500,s=375,d=15274},  -- Plans: Deadly Bronze Poniard
	[2885]={b=0,s=0,d=3048,c=AUCT_CLAS_WRITTEN},  -- Scarlet Crusade Documents
	[2886]={b=20,s=5,d=2904,x=10,u=AUCT_TYPE_COOK},  -- Crag Boar Rib
	[2888]={b=40,s=10,d=21327,x=20,u=AUCT_TYPE_COOK},  -- Beer Basted Boar Ribs
	[2889]={b=240,s=60,d=811,u=AUCT_TYPE_COOK},  -- Recipe: Beer Basted Boar Ribs
	[2892]={b=120,s=30,d=13707,x=10,c=AUCT_CLAS_POISON},  -- Deadly Poison
	[2893]={b=220,s=55,d=13707,x=10,c=AUCT_CLAS_POISON},  -- Deadly Poison II
	[2894]={b=50,s=12,d=18117,x=10,u=AUCT_TYPE_COOK},  -- Rhapsody Malt
	[2898]={b=162,s=32,d=2967,c=AUCT_CLAS_ARMOR},  -- Mountaineer Chestpiece
	[2899]={b=846,s=169,d=16949,c=AUCT_CLAS_ARMOR},  -- Wendigo Collar
	[2900]={b=446,s=89,d=18528,c=AUCT_CLAS_WEAPON},  -- Stone Buckler
	[2901]={b=81,s=16,d=6568,c=AUCT_CLAS_WEAPON},  -- Mining Pick
	[2902]={b=6527,s=1305,d=23099,c=AUCT_CLAS_ARMOR},  -- Cloak of the Faith
	[2903]={b=2578,s=515,d=8107,c=AUCT_CLAS_WEAPON},  -- Daryl's Hunting Bow
	[2904]={b=2977,s=595,d=20732,c=AUCT_CLAS_WEAPON},  -- Daryl's Hunting Rifle
	[2905]={b=266,s=53,d=23032,c=AUCT_CLAS_ARMOR},  -- Goat Fur Cloak
	[2906]={b=9051,s=1810,d=2922,c=AUCT_CLAS_ARMOR},  -- Darkshire Mail Leggings
	[2907]={b=8778,s=1755,d=19227,c=AUCT_CLAS_WEAPON},  -- Dwarven Tree Chopper
	[2908]={b=7048,s=1409,d=20605,c=AUCT_CLAS_WEAPON},  -- Thornblade
	[2909]={b=0,s=0,d=2925,q=20,x=20},  -- Red Wool Bandana
	[2910]={b=6286,s=1257,d=6931,c=AUCT_CLAS_ARMOR},  -- Gold Militia Boots
	[2911]={b=2623,s=524,d=9898,c=AUCT_CLAS_ARMOR},  -- Keller's Girdle
	[2912]={b=33656,s=6731,d=20320,c=AUCT_CLAS_WEAPON},  -- Claw of the Shadowmancer
	[2913]={b=5766,s=1153,d=16828,c=AUCT_CLAS_ARMOR},  -- Silk Mantle of Gamn
	[2915]={b=276447,s=55289,d=19664,c=AUCT_CLAS_WEAPON},  -- Taran Icebreaker
	[2916]={b=22028,s=4405,d=2934,c=AUCT_CLAS_WEAPON},  -- Gold Lion Shield
	[2917]={b=2660,s=665,d=9850,c=AUCT_CLAS_ARMOR},  -- Tranquil Ring
	[2924]={b=65,s=16,d=6350,x=10,u=AUCT_TYPE_COOK},  -- Crocolisk Meat
	[2925]={b=0,s=0,d=3124,q=20,x=20},  -- Crocolisk Skin
	[2926]={b=0,s=0,d=7038},  -- Head of Bazil Thredd
	[2928]={b=20,s=5,d=6371,x=20,u=AUCT_TYPE_POISON},  -- Dust of Decay
	[2930]={b=50,s=12,d=6400,x=10,u=AUCT_TYPE_POISON},  -- Essence of Pain
	[2933]={b=15000,s=3750,d=9845,c=AUCT_CLAS_ARMOR},  -- Seal of Wrynn
	[2934]={b=30,s=7,d=7400,x=10,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Ruined Leather Scraps
	[2939]={b=0,s=0,d=3004},  -- Crocolisk Tear
	[2940]={b=175,s=43,d=1769,x=5},  -- Bloody Bear Paw
	[2941]={b=17761,s=3552,d=20359,c=AUCT_CLAS_WEAPON},  -- Prison Shank
	[2942]={b=18316,s=3663,d=3007,c=AUCT_CLAS_WEAPON},  -- Iron Knuckles
	[2943]={b=2150,s=537,d=21600,c=AUCT_CLAS_WEAPON},  -- Eye of Paleth
	[2944]={b=0,s=0,d=21598,c=AUCT_CLAS_WEAPON},  -- Cursed Eye of Paleth
	[2946]={b=30,s=0,d=16752,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Balanced Throwing Dagger
	[2947]={b=15,s=0,d=16754,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Small Throwing Knife
	[2949]={b=5196,s=1039,d=16989,c=AUCT_CLAS_ARMOR},  -- Mariner Boots
	[2950]={b=17384,s=3476,d=20378,c=AUCT_CLAS_WEAPON},  -- Icicle Rod
	[2951]={b=2625,s=656,d=9851,c=AUCT_CLAS_ARMOR},  -- Ring of the Underwood
	[2953]={b=11606,s=2321,d=23077,c=AUCT_CLAS_ARMOR},  -- Watch Master's Cloak
	[2954]={b=12425,s=2485,d=14615,c=AUCT_CLAS_ARMOR},  -- Night Watch Pantaloons
	[2955]={b=17247,s=3449,d=16545,c=AUCT_CLAS_ARMOR},  -- First Mate Hat
	[2956]={b=0,s=0,d=3031,c=AUCT_CLAS_WRITTEN},  -- Report on the Defias Brotherhood
	[2957]={b=596,s=119,d=14499,c=AUCT_CLAS_ARMOR},  -- Journeyman's Vest
	[2958]={b=473,s=94,d=14498,c=AUCT_CLAS_ARMOR},  -- Journeyman's Pants
	[2959]={b=164,s=32,d=14525,c=AUCT_CLAS_ARMOR},  -- Journeyman's Boots
	[2960]={b=109,s=21,d=14497,c=AUCT_CLAS_ARMOR},  -- Journeyman's Gloves
	[2961]={b=779,s=155,d=17093,c=AUCT_CLAS_ARMOR},  -- Burnt Leather Vest
	[2962]={b=600,s=120,d=17160,c=AUCT_CLAS_ARMOR},  -- Burnt Leather Breeches
	[2963]={b=208,s=41,d=16980,c=AUCT_CLAS_ARMOR},  -- Burnt Leather Boots
	[2964]={b=181,s=36,d=17175,c=AUCT_CLAS_ARMOR},  -- Burnt Leather Gloves
	[2965]={b=948,s=189,d=22677,c=AUCT_CLAS_ARMOR},  -- Warrior's Tunic
	[2966]={b=731,s=146,d=7193,c=AUCT_CLAS_ARMOR},  -- Warrior's Pants
	[2967]={b=331,s=66,d=22673,c=AUCT_CLAS_ARMOR},  -- Warrior's Boots
	[2968]={b=169,s=33,d=22676,c=AUCT_CLAS_ARMOR},  -- Warrior's Gloves
	[2969]={b=1909,s=381,d=14524,c=AUCT_CLAS_ARMOR},  -- Spellbinder Vest
	[2970]={b=1666,s=333,d=14529,c=AUCT_CLAS_ARMOR},  -- Spellbinder Pants
	[2971]={b=544,s=108,d=14531,c=AUCT_CLAS_ARMOR},  -- Spellbinder Boots
	[2972]={b=364,s=72,d=14528,c=AUCT_CLAS_ARMOR},  -- Spellbinder Gloves
	[2973]={b=2420,s=484,d=14539,c=AUCT_CLAS_ARMOR},  -- Hunting Tunic
	[2974]={b=1962,s=392,d=14537,c=AUCT_CLAS_ARMOR},  -- Hunting Pants
	[2975]={b=642,s=128,d=14534,c=AUCT_CLAS_ARMOR},  -- Hunting Boots
	[2976]={b=859,s=171,d=14536,c=AUCT_CLAS_ARMOR},  -- Hunting Gloves
	[2977]={b=2382,s=476,d=22689,c=AUCT_CLAS_ARMOR},  -- Veteran Armor
	[2978]={b=2079,s=415,d=22693,c=AUCT_CLAS_ARMOR},  -- Veteran Leggings
	[2979]={b=785,s=157,d=22690,c=AUCT_CLAS_ARMOR},  -- Veteran Boots
	[2980]={b=1047,s=209,d=12450,c=AUCT_CLAS_ARMOR},  -- Veteran Gloves
	[2981]={b=3242,s=648,d=14549,c=AUCT_CLAS_ARMOR},  -- Seer's Robe
	[2982]={b=2829,s=565,d=14554,c=AUCT_CLAS_ARMOR},  -- Seer's Pants
	[2983]={b=1400,s=280,d=14552,c=AUCT_CLAS_ARMOR},  -- Seer's Boots
	[2984]={b=1077,s=215,d=16789,c=AUCT_CLAS_ARMOR},  -- Seer's Gloves
	[2985]={b=4113,s=822,d=9739,c=AUCT_CLAS_ARMOR},  -- Inscribed Leather Breastplate
	[2986]={b=3590,s=718,d=11369,c=AUCT_CLAS_ARMOR},  -- Inscribed Leather Pants
	[2987]={b=2043,s=408,d=11373,c=AUCT_CLAS_ARMOR},  -- Inscribed Leather Boots
	[2988]={b=1571,s=314,d=14411,c=AUCT_CLAS_ARMOR},  -- Inscribed Leather Gloves
	[2989]={b=5009,s=1001,d=25769,c=AUCT_CLAS_ARMOR},  -- Burnished Tunic
	[2990]={b=4666,s=933,d=25768,c=AUCT_CLAS_ARMOR},  -- Burnished Leggings
	[2991]={b=3528,s=705,d=25765,c=AUCT_CLAS_ARMOR},  -- Burnished Boots
	[2992]={b=2044,s=408,d=16731,c=AUCT_CLAS_ARMOR},  -- Burnished Gloves
	[2996]={b=160,s=40,d=7331,x=10,u=AUCT_TYPE_TAILOR},  -- Bolt of Linen Cloth
	[2997]={b=400,s=100,d=10044,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Bolt of Woolen Cloth
	[2998]={b=0,s=0,d=6562},  -- A Simple Compass
	[2999]={b=0,s=0,d=7259},  -- Steelgrill's Tools
	[3000]={b=596,s=119,d=16888,c=AUCT_CLAS_ARMOR},  -- Brood Mother Carapace
	[3008]={b=218,s=43,d=23080,c=AUCT_CLAS_ARMOR},  -- Wendigo Fur Cloak
	[3010]={b=405,s=101,d=6371,x=5},  -- Fine Sand
	[3011]={b=14234,s=2846,d=13259,c=AUCT_CLAS_ARMOR},  -- Feathered Headdress
	[3012]={b=200,s=50,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Agility
	[3013]={b=100,s=25,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Protection
	[3014]={b=0,s=0,d=7040,q=20,x=20},  -- Battleworn Axe
	[3016]={b=0,s=0,d=7139},  -- Gunther's Spellbook
	[3017]={b=0,s=0,d=811,c=AUCT_CLAS_WRITTEN},  -- Sevren's Orders
	[3018]={b=3906,s=781,d=23027,c=AUCT_CLAS_ARMOR},  -- Hide of Lupos
	[3019]={b=2115,s=423,d=12682,c=AUCT_CLAS_ARMOR},  -- Noble's Robe
	[3020]={b=13279,s=2655,d=21294,c=AUCT_CLAS_ARMOR},  -- Enduring Cap
	[3021]={b=12105,s=2421,d=20673,c=AUCT_CLAS_WEAPON},  -- Ranger Bow
	[3022]={b=5427,s=1085,d=16534,c=AUCT_CLAS_ARMOR},  -- Bluegill Breeches
	[3023]={b=3771,s=754,d=20727,c=AUCT_CLAS_WEAPON},  -- Large Bore Blunderbuss
	[3024]={b=7098,s=1419,d=20726,c=AUCT_CLAS_WEAPON},  -- BKP 2700 "Enforcer"
	[3025]={b=18478,s=3695,d=20725,c=AUCT_CLAS_WEAPON},  -- BKP 42 "Ultra"
	[3026]={b=3812,s=762,d=20675,c=AUCT_CLAS_WEAPON},  -- Reinforced Bow
	[3027]={b=6349,s=1269,d=20670,c=AUCT_CLAS_WEAPON},  -- Heavy Recurve Bow
	[3030]={b=300,s=0,d=26497,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Razor Arrow
	[3033]={b=300,s=0,d=5998,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Solid Shot
	[3035]={b=0,s=0,d=3225,c=AUCT_CLAS_FOOD},  -- Laced Pumpkin
	[3036]={b=2578,s=515,d=5392,c=AUCT_CLAS_WEAPON},  -- Heavy Shortbow
	[3037]={b=24071,s=4814,d=20653,c=AUCT_CLAS_WEAPON},  -- Whipwood Recurve Bow
	[3039]={b=8052,s=1610,d=20672,c=AUCT_CLAS_WEAPON},  -- Short Ash Bow
	[3040]={b=4701,s=940,d=20740,c=AUCT_CLAS_WEAPON},  -- Hunter's Muzzle Loader
	[3041]={b=18846,s=3769,d=20729,c=AUCT_CLAS_WEAPON},  -- "Mage-Eye" Blunderbuss
	[3042]={b=22887,s=4577,d=20734,c=AUCT_CLAS_WEAPON},  -- BKP "Sparrow" Smallbore
	[3045]={b=7869,s=1573,d=25778,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Boots
	[3047]={b=5260,s=1052,d=25782,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Gloves
	[3048]={b=9598,s=1919,d=11525,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Legguards
	[3049]={b=10595,s=2119,d=25780,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Breastplate
	[3053]={b=10703,s=2140,d=3293,c=AUCT_CLAS_ARMOR},  -- Humbert's Chestpiece
	[3055]={b=7631,s=1526,d=8665,c=AUCT_CLAS_ARMOR},  -- Forest Leather Chestpiece
	[3056]={b=7660,s=1532,d=16954,c=AUCT_CLAS_ARMOR},  -- Forest Leather Pants
	[3057]={b=4515,s=903,d=16984,c=AUCT_CLAS_ARMOR},  -- Forest Leather Boots
	[3058]={b=3414,s=682,d=17055,c=AUCT_CLAS_ARMOR},  -- Forest Leather Gloves
	[3065]={b=3290,s=658,d=27547,c=AUCT_CLAS_ARMOR},  -- Bright Boots
	[3066]={b=2487,s=497,d=27550,c=AUCT_CLAS_ARMOR},  -- Bright Gloves
	[3067]={b=6375,s=1275,d=3217,c=AUCT_CLAS_ARMOR},  -- Bright Pants
	[3069]={b=7063,s=1412,d=27554,c=AUCT_CLAS_ARMOR},  -- Bright Robe
	[3070]={b=55,s=11,d=15149,c=AUCT_CLAS_ARMOR},  -- Ensign Cloak
	[3071]={b=1155,s=231,d=19209,c=AUCT_CLAS_WEAPON},  -- Striking Hatchet
	[3072]={b=6036,s=1207,d=16694,c=AUCT_CLAS_ARMOR},  -- Smoldering Robe
	[3073]={b=6059,s=1211,d=16846,c=AUCT_CLAS_ARMOR},  -- Smoldering Pants
	[3074]={b=2380,s=476,d=12420,c=AUCT_CLAS_ARMOR},  -- Smoldering Gloves
	[3075]={b=75368,s=15073,d=15322,c=AUCT_CLAS_ARMOR},  -- Eye of Flame
	[3076]={b=3184,s=636,d=4873,c=AUCT_CLAS_ARMOR},  -- Smoldering Boots
	[3078]={b=11572,s=2314,d=20669,c=AUCT_CLAS_WEAPON},  -- Naga Heartpiercer
	[3079]={b=1486,s=297,d=20738,c=AUCT_CLAS_WEAPON},  -- Skorn's Rifle
	[3080]={b=0,s=0,d=7066},  -- Candle of Beckoning
	[3081]={b=0,s=0,d=7185},  -- Nether Gem
	[3082]={b=0,s=0,d=2853},  -- Dargol's Skull
	[3083]={b=0,s=0,d=7215,q=20,x=20},  -- Restabilization Cog
	[3084]={b=0,s=0,d=7072,q=20,x=20},  -- Gyromechanic Gear
	[3085]={b=0,s=0,d=7922},  -- Barrel of Shimmer Stout
	[3086]={b=0,s=0,d=7922},  -- Cask of Shimmer Stout
	[3087]={b=45,s=11,d=18115,x=10},  -- Mug of Shimmer Stout
	[3103]={b=2334,s=466,d=8588,c=AUCT_CLAS_WEAPON},  -- Coldridge Hammer
	[3107]={b=75,s=0,d=20779,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Keen Throwing Knife
	[3108]={b=200,s=0,d=20773,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Heavy Throwing Dagger
	[3110]={b=0,s=0,d=7723,q=20,x=20},  -- Tunnel Rat Ear
	[3111]={b=15,s=0,d=20777,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Crude Throwing Axe
	[3117]={b=0,s=0,d=7138,c=AUCT_CLAS_WRITTEN},  -- Hildelve's Journal
	[3131]={b=30,s=0,d=16760,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Weighted Throwing Axe
	[3135]={b=75,s=0,d=20782,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Sharp Throwing Axe
	[3137]={b=200,s=0,d=20783,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Deadly Throwing Axe
	[3151]={b=437,s=87,d=3293,c=AUCT_CLAS_ARMOR},  -- Siege Brigade Vest
	[3152]={b=140,s=28,d=17177,c=AUCT_CLAS_ARMOR},  -- Driving Gloves
	[3153]={b=169,s=33,d=23128,c=AUCT_CLAS_ARMOR},  -- Oil-stained Cloak
	[3154]={b=5470,s=1094,d=18340,c=AUCT_CLAS_WEAPON},  -- Thelsamar Axe
	[3155]={b=0,s=0,d=3331},  -- Remedy of Arugal
	[3156]={b=0,s=0,d=7132,q=20,x=20},  -- Glutton Shackle
	[3157]={b=0,s=0,d=7083,q=20,x=20},  -- Darksoul Shackle
	[3158]={b=303,s=60,d=10412,c=AUCT_CLAS_ARMOR},  -- Burnt Hide Bracers
	[3160]={b=2351,s=470,d=3304,c=AUCT_CLAS_WEAPON},  -- Ironplate Buckler
	[3161]={b=1474,s=294,d=16696,c=AUCT_CLAS_ARMOR},  -- Robe of the Keeper
	[3162]={b=0,s=0,d=3233,q=20,x=20},  -- Notched Rib
	[3163]={b=0,s=0,d=2853,q=20,x=20},  -- Blackened Skull
	[3164]={b=135,s=33,d=7357,x=10,u=AUCT_TYPE_ALCHEM},  -- Discolored Worg Heart
	[3165]={b=0,s=0,d=983,c=AUCT_CLAS_POTION},  -- Quinn's Potion
	[3166]={b=2039,s=407,d=12965,c=AUCT_CLAS_ARMOR},  -- Ironheart Chain
	[3167]={b=275,s=68,d=6699,x=10},  -- Thick Spider Hair
	[3169]={b=75,s=18,d=6002,x=10},  -- Chipped Bear Tooth
	[3170]={b=190,s=47,d=6666,x=10},  -- Large Bear Tooth
	[3171]={b=25,s=6,d=3429,x=5},  -- Broken Boar Tusk
	[3172]={b=75,s=18,d=7330,x=10,u=AUCT_TYPE_COOK},  -- Boar Intestines
	[3173]={b=60,s=15,d=25466,x=10,u=AUCT_TYPE_COOK},  -- Bear Meat
	[3174]={b=65,s=16,d=6690,x=10,u=AUCT_TYPE_COOK},  -- Spider Ichor
	[3175]={b=400,s=100,d=11164,x=10},  -- Ruined Dragonhide
	[3176]={b=300,s=75,d=3307,x=10},  -- Small Claw
	[3177]={b=200,s=50,d=6651,x=10},  -- Tiny Fang
	[3179]={b=500,s=125,d=28257,x=10},  -- Cracked Dragon Molting
	[3180]={b=675,s=168,d=6658,x=5},  -- Flecked Raptor Scale
	[3181]={b=95,s=23,d=6678,x=5},  -- Partially Digested Meat
	[3182]={b=1550,s=387,d=18597,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Spider's Silk
	[3183]={b=0,s=0,d=6669},  -- Mangy Claw
	[3184]={b=6973,s=1394,d=20396,c=AUCT_CLAS_WEAPON},  -- Hook Dagger
	[3185]={b=40440,s=8088,d=20362,c=AUCT_CLAS_WEAPON},  -- Acrobatic Staff
	[3186]={b=22180,s=4436,d=26576,c=AUCT_CLAS_WEAPON},  -- Viking Sword
	[3187]={b=74353,s=14870,d=20573,c=AUCT_CLAS_WEAPON},  -- Sacrificial Kris
	[3188]={b=4398,s=879,d=20072,c=AUCT_CLAS_WEAPON},  -- Coral Claymore
	[3189]={b=497,s=99,d=8525,c=AUCT_CLAS_WEAPON},  -- Wood Chopper
	[3190]={b=499,s=99,d=6799,c=AUCT_CLAS_WEAPON},  -- Beatstick
	[3191]={b=19289,s=3857,d=11165,c=AUCT_CLAS_WEAPON},  -- Arced War Axe
	[3192]={b=2479,s=495,d=26590,c=AUCT_CLAS_WEAPON},  -- Short Bastard Sword
	[3193]={b=10361,s=2072,d=19545,c=AUCT_CLAS_WEAPON},  -- Oak Mallet
	[3194]={b=12479,s=2495,d=19622,c=AUCT_CLAS_WEAPON},  -- Black Malice
	[3195]={b=6862,s=1372,d=8499,c=AUCT_CLAS_WEAPON},  -- Barbaric Battle Axe
	[3196]={b=6886,s=1377,d=26585,c=AUCT_CLAS_WEAPON},  -- Edged Bastard Sword
	[3197]={b=46478,s=9295,d=20184,c=AUCT_CLAS_WEAPON},  -- Stonecutter Claymore
	[3198]={b=13709,s=2741,d=8585,c=AUCT_CLAS_WEAPON},  -- Battering Hammer
	[3199]={b=11310,s=2262,d=19372,c=AUCT_CLAS_WEAPON},  -- Battle Slayer
	[3200]={b=95,s=19,d=17004,c=AUCT_CLAS_ARMOR},  -- Burnt Leather Bracers
	[3201]={b=22483,s=4496,d=19283,c=AUCT_CLAS_WEAPON},  -- Barbarian War Axe
	[3202]={b=2921,s=584,d=10216,c=AUCT_CLAS_ARMOR},  -- Forest Leather Bracers
	[3203]={b=27184,s=5436,d=5228,c=AUCT_CLAS_WEAPON},  -- Dense Triangle Mace
	[3204]={b=3758,s=751,d=3606,c=AUCT_CLAS_ARMOR},  -- Deepwood Bracers
	[3205]={b=1149,s=229,d=14410,c=AUCT_CLAS_ARMOR},  -- Inscribed Leather Bracers
	[3206]={b=22910,s=4582,d=20186,c=AUCT_CLAS_WEAPON},  -- Cavalier Two-hander
	[3207]={b=438,s=87,d=14535,c=AUCT_CLAS_ARMOR},  -- Hunting Bracers
	[3208]={b=126893,s=25378,d=5232,c=AUCT_CLAS_WEAPON},  -- Conk Hammer
	[3209]={b=33917,s=6783,d=20250,c=AUCT_CLAS_WEAPON},  -- Ancient War Sword
	[3210]={b=28134,s=5626,d=19275,c=AUCT_CLAS_WEAPON},  -- Brutal War Axe
	[3211]={b=1865,s=373,d=25766,c=AUCT_CLAS_ARMOR},  -- Burnished Bracers
	[3212]={b=4645,s=929,d=25779,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Bracers
	[3213]={b=447,s=89,d=6953,c=AUCT_CLAS_ARMOR},  -- Veteran Bracers
	[3214]={b=169,s=33,d=22674,c=AUCT_CLAS_ARMOR},  -- Warrior's Bracers
	[3216]={b=275,s=55,d=18121,c=AUCT_CLAS_ARMOR},  -- Warm Winter Robe
	[3217]={b=674,s=134,d=16787,c=AUCT_CLAS_ARMOR},  -- Foreman Belt
	[3218]={b=0,s=0,d=7208,q=20,x=20},  -- Pyrewood Shackle
	[3220]={b=160,s=40,d=25469,x=20,c=AUCT_CLAS_FOOD},  -- Blood Sausage
	[3223]={b=1534,s=306,d=19624,c=AUCT_CLAS_WEAPON},  -- Frostmane Scepter
	[3224]={b=142,s=28,d=16926,c=AUCT_CLAS_ARMOR},  -- Silver-lined Bracers
	[3225]={b=548,s=109,d=6437,c=AUCT_CLAS_WEAPON},  -- Bloodstained Knife
	[3227]={b=13169,s=2633,d=20381,c=AUCT_CLAS_WEAPON},  -- Nightbane Staff
	[3228]={b=5492,s=1098,d=10402,c=AUCT_CLAS_ARMOR},  -- Jimmied Handcuffs
	[3229]={b=2122,s=424,d=9917,c=AUCT_CLAS_ARMOR},  -- Tarantula Silk Sash
	[3230]={b=3842,s=768,d=17166,c=AUCT_CLAS_ARMOR},  -- Black Wolf Bracers
	[3231]={b=6332,s=1266,d=10166,c=AUCT_CLAS_ARMOR},  -- Cutthroat Pauldrons
	[3233]={b=850,s=212,d=3410,c=AUCT_CLAS_CONTAINER},  -- Gnoll Hide Sack
	[3234]={b=0,s=0,d=963},  -- Deliah's Ring
	[3235]={b=1650,s=412,d=9840,c=AUCT_CLAS_ARMOR},  -- Ring of Scorn
	[3236]={b=0,s=0,d=3152,q=20,x=20},  -- Rot Hide Ichor
	[3237]={b=0,s=0,d=3152},  -- Sample Ichor
	[3238]={b=0,s=0,d=3411},  -- Johaan's Findings
	[3239]={b=12,s=3,d=24683,x=20},  -- Rough Weightstone
	[3240]={b=40,s=10,d=24684,x=20},  -- Coarse Weightstone
	[3241]={b=160,s=40,d=24685,x=20},  -- Heavy Weightstone
	[3248]={b=0,s=0,d=1102,c=AUCT_CLAS_WRITTEN},  -- Translated Letter from The Embalmer
	[3250]={b=0,s=0,d=1301},  -- Bethor's Scroll
	[3251]={b=0,s=0,d=8452,c=AUCT_CLAS_POTION},  -- Bethor's Potion
	[3252]={b=0,s=0,d=3029,c=AUCT_CLAS_WRITTEN},  -- Deathstalker Report
	[3253]={b=0,s=0,d=3422,q=20,x=20},  -- Grizzled Bear Heart
	[3254]={b=0,s=0,d=2885,q=20,x=20},  -- Skittering Blood
	[3255]={b=0,s=0,d=3426,c=AUCT_CLAS_WRITTEN},  -- Berard's Journal
	[3256]={b=0,s=0,d=3427,q=20,x=20},  -- Lake Skulker Moss
	[3257]={b=0,s=0,d=3427,q=20,x=20},  -- Lake Creeper Moss
	[3258]={b=0,s=0,d=5283},  -- Hardened Tumor
	[3260]={b=31,s=6,d=16612,c=AUCT_CLAS_ARMOR},  -- Scarlet Initiate Robes
	[3261]={b=35,s=7,d=23143,c=AUCT_CLAS_ARMOR},  -- Webbed Cloak
	[3262]={b=54,s=10,d=21052,c=AUCT_CLAS_WEAPON},  -- Putrid Wooden Hammer
	[3263]={b=22,s=4,d=3432,c=AUCT_CLAS_ARMOR},  -- Webbed Pants
	[3264]={b=0,s=0,d=11489,q=20,x=20},  -- Duskbat Wing
	[3265]={b=0,s=0,d=6669,q=20,x=20},  -- Scavenger Paw
	[3266]={b=0,s=0,d=3433,q=20,x=20},  -- Scarlet Armband
	[3267]={b=128,s=25,d=20176,c=AUCT_CLAS_WEAPON},  -- Forsaken Shortsword
	[3268]={b=128,s=25,d=6432,c=AUCT_CLAS_WEAPON},  -- Forsaken Dagger
	[3269]={b=129,s=25,d=19772,c=AUCT_CLAS_WEAPON},  -- Forsaken Maul
	[3270]={b=51,s=10,d=16585,c=AUCT_CLAS_ARMOR},  -- Flax Vest
	[3272]={b=65,s=13,d=3442,c=AUCT_CLAS_ARMOR},  -- Zombie Skin Leggings
	[3273]={b=77,s=15,d=2967,c=AUCT_CLAS_ARMOR},  -- Rugged Mail Vest
	[3274]={b=38,s=7,d=16587,c=AUCT_CLAS_ARMOR},  -- Flax Boots
	[3275]={b=26,s=5,d=16586,c=AUCT_CLAS_ARMOR},  -- Flax Gloves
	[3276]={b=76,s=15,d=18490,c=AUCT_CLAS_WEAPON},  -- Deathguard Buckler
	[3277]={b=150,s=30,d=20444,c=AUCT_CLAS_WEAPON},  -- Executor Staff
	[3279]={b=525,s=105,d=26927,c=AUCT_CLAS_ARMOR},  -- Battle Chain Boots
	[3280]={b=165,s=33,d=26928,c=AUCT_CLAS_ARMOR},  -- Battle Chain Bracers
	[3281]={b=280,s=56,d=27175,c=AUCT_CLAS_ARMOR},  -- Battle Chain Gloves
	[3282]={b=1177,s=235,d=26932,c=AUCT_CLAS_ARMOR},  -- Battle Chain Pants
	[3283]={b=1476,s=295,d=26933,c=AUCT_CLAS_ARMOR},  -- Battle Chain Tunic
	[3284]={b=444,s=88,d=27993,c=AUCT_CLAS_ARMOR},  -- Tribal Boots
	[3285]={b=182,s=36,d=27994,c=AUCT_CLAS_ARMOR},  -- Tribal Bracers
	[3286]={b=297,s=59,d=27995,c=AUCT_CLAS_ARMOR},  -- Tribal Gloves
	[3287]={b=998,s=199,d=28591,c=AUCT_CLAS_ARMOR},  -- Tribal Pants
	[3288]={b=1253,s=250,d=27996,c=AUCT_CLAS_ARMOR},  -- Tribal Vest
	[3289]={b=288,s=57,d=14514,c=AUCT_CLAS_ARMOR},  -- Ancestral Boots
	[3290]={b=241,s=48,d=14509,c=AUCT_CLAS_ARMOR},  -- Ancestral Gloves
	[3291]={b=1013,s=202,d=14511,c=AUCT_CLAS_ARMOR},  -- Ancestral Woollies
	[3292]={b=1016,s=203,d=14513,c=AUCT_CLAS_ARMOR},  -- Ancestral Tunic
	[3293]={b=58,s=11,d=19281,c=AUCT_CLAS_WEAPON},  -- Deadman Cleaver
	[3294]={b=58,s=11,d=5203,c=AUCT_CLAS_WEAPON},  -- Deadman Club
	[3295]={b=54,s=10,d=3434,c=AUCT_CLAS_WEAPON},  -- Deadman Blade
	[3296]={b=54,s=10,d=6442,c=AUCT_CLAS_WEAPON},  -- Deadman Dagger
	[3297]={b=0,s=0,d=3427,q=20,x=20},  -- Fel Moss
	[3299]={b=195,s=48,d=6002,x=10},  -- Fractured Canine
	[3300]={b=38,s=9,d=6682,x=5},  -- Rabbit's Foot
	[3301]={b=410,s=102,d=6002,x=10},  -- Sharp Canine
	[3302]={b=1595,s=319,d=26944,c=AUCT_CLAS_ARMOR},  -- Brackwater Boots
	[3303]={b=353,s=70,d=26945,c=AUCT_CLAS_ARMOR},  -- Brackwater Bracers
	[3304]={b=533,s=106,d=28997,c=AUCT_CLAS_ARMOR},  -- Brackwater Gauntlets
	[3305]={b=2463,s=492,d=26948,c=AUCT_CLAS_ARMOR},  -- Brackwater Leggings
	[3306]={b=3269,s=653,d=26949,c=AUCT_CLAS_ARMOR},  -- Brackwater Vest
	[3307]={b=1078,s=215,d=11060,c=AUCT_CLAS_ARMOR},  -- Barbaric Cloth Boots
	[3308]={b=721,s=144,d=16592,c=AUCT_CLAS_ARMOR},  -- Barbaric Cloth Gloves
	[3309]={b=1666,s=333,d=16591,c=AUCT_CLAS_ARMOR},  -- Barbaric Loincloth
	[3310]={b=2211,s=442,d=16590,c=AUCT_CLAS_ARMOR},  -- Barbaric Cloth Vest
	[3311]={b=761,s=152,d=14544,c=AUCT_CLAS_ARMOR},  -- Ceremonial Leather Ankleguards
	[3312]={b=353,s=70,d=14545,c=AUCT_CLAS_ARMOR},  -- Ceremonial Leather Bracers
	[3313]={b=2595,s=519,d=28047,c=AUCT_CLAS_ARMOR},  -- Ceremonial Leather Harness
	[3314]={b=856,s=171,d=14546,c=AUCT_CLAS_ARMOR},  -- Ceremonial Leather Gloves
	[3315]={b=2274,s=454,d=14547,c=AUCT_CLAS_ARMOR},  -- Ceremonial Leather Loincloth
	[3317]={b=0,s=0,d=3486,c=AUCT_CLAS_QUEST},  -- A Talking Head
	[3318]={b=0,s=0,d=3487},  -- Alaric's Remains
	[3319]={b=550,s=110,d=5007,c=AUCT_CLAS_WEAPON},  -- Short Sabre
	[3321]={b=207,s=41,d=4016,c=AUCT_CLAS_ARMOR},  -- Gray Fur Booties
	[3322]={b=55,s=11,d=23015,c=AUCT_CLAS_ARMOR},  -- Wispy Cloak
	[3323]={b=79,s=15,d=16906,c=AUCT_CLAS_ARMOR},  -- Ghostly Bracers
	[3324]={b=5599,s=1119,d=21457,c=AUCT_CLAS_ARMOR},  -- Ghostly Mantle
	[3325]={b=703,s=140,d=19252,c=AUCT_CLAS_WEAPON},  -- Vile Fin Battle Axe
	[3327]={b=708,s=141,d=20434,c=AUCT_CLAS_WEAPON},  -- Vile Fin Oracle Staff
	[3328]={b=233,s=46,d=16655,c=AUCT_CLAS_ARMOR},  -- Spider Web Robe
	[3329]={b=896,s=179,d=5204,c=AUCT_CLAS_WEAPON},  -- Spiked Wooden Plank
	[3330]={b=1405,s=281,d=12971,c=AUCT_CLAS_ARMOR},  -- Dargol's Hauberk
	[3331]={b=509,s=101,d=15196,c=AUCT_CLAS_ARMOR},  -- Melrache's Cape
	[3332]={b=242,s=48,d=6987,c=AUCT_CLAS_ARMOR},  -- Perrine's Boots
	[3334]={b=343,s=68,d=7495,c=AUCT_CLAS_WEAPON},  -- Farmer's Shovel
	[3335]={b=230,s=46,d=3509,c=AUCT_CLAS_WEAPON},  -- Farmer's Broom
	[3336]={b=19933,s=3986,d=20341,c=AUCT_CLAS_WEAPON},  -- Flesh Piercer
	[3337]={b=0,s=0,d=7111,q=20,x=20},  -- Dragonmaw War Banner
	[3339]={b=0,s=0,d=6371},  -- Dwarven Tinder
	[3340]={b=125,s=31,d=7148,x=10},  -- Incendicite Ore
	[3341]={b=8108,s=1621,d=6920,c=AUCT_CLAS_ARMOR},  -- Gauntlets of Ogre Strength
	[3342]={b=550,s=137,d=7843,c=AUCT_CLAS_ARMOR},  -- Captain Sander's Shirt
	[3343]={b=1800,s=450,d=1183,c=AUCT_CLAS_CONTAINER},  -- Captain Sander's Booty Bag
	[3344]={b=729,s=145,d=4511,c=AUCT_CLAS_ARMOR},  -- Captain Sander's Sash
	[3345]={b=13601,s=2720,d=15912,c=AUCT_CLAS_ARMOR},  -- Silk Wizard Hat
	[3347]={b=0,s=0,d=568},  -- Bundle of Crocolisk Skins
	[3348]={b=0,s=0,d=6646,q=20,x=20},  -- Giant Crocolisk Skin
	[3349]={b=0,s=0,d=3565},  -- Sida's Bag
	[3352]={b=5000,s=1250,d=3568,c=AUCT_CLAS_CONTAINER},  -- Ooze-covered Bag
	[3353]={b=0,s=0,d=6502},  -- Rune-inscribed Pendant
	[3354]={b=0,s=0,d=6502,q=20,x=20},  -- Dalaran Pendant
	[3355]={b=200,s=50,d=6524,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Wild Steelbloom
	[3356]={b=120,s=30,d=7346,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER},  -- Kingsblood
	[3357]={b=300,s=75,d=7381,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Liferoot
	[3358]={b=700,s=175,d=6661,x=20,u=AUCT_TYPE_ALCHEM},  -- Khadgar's Whisker
	[3360]={b=2500,s=625,d=3573,c=AUCT_CLAS_WEAPON},  -- Stitches' Femur
	[3363]={b=7,s=1,d=16663,c=AUCT_CLAS_ARMOR},  -- Frayed Belt
	[3365]={b=16,s=3,d=16664,c=AUCT_CLAS_ARMOR},  -- Frayed Bracers
	[3369]={b=100,s=25,d=6396,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Grave Moss
	[3370]={b=50,s=10,d=7881,c=AUCT_CLAS_ARMOR},  -- Patchwork Belt
	[3371]={b=20,s=1,d=18077,q=20,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_POISON},  -- Empty Vial
	[3372]={b=200,s=10,d=18077,q=20,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_POISON},  -- Leaded Vial
	[3373]={b=71,s=14,d=16804,c=AUCT_CLAS_ARMOR},  -- Patchwork Bracers
	[3374]={b=227,s=45,d=16554,c=AUCT_CLAS_ARMOR},  -- Calico Belt
	[3375]={b=152,s=30,d=16555,c=AUCT_CLAS_ARMOR},  -- Calico Bracers
	[3376]={b=431,s=86,d=16819,c=AUCT_CLAS_ARMOR},  -- Canvas Belt
	[3377]={b=497,s=99,d=14111,c=AUCT_CLAS_ARMOR},  -- Canvas Bracers
	[3378]={b=660,s=132,d=16807,c=AUCT_CLAS_ARMOR},  -- Brocade Belt
	[3379]={b=762,s=152,d=16806,c=AUCT_CLAS_ARMOR},  -- Brocade Bracers
	[3380]={b=1826,s=365,d=16784,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Belt
	[3381]={b=1515,s=303,d=16913,c=AUCT_CLAS_ARMOR},  -- Cross-stitched Bracers
	[3382]={b=40,s=10,d=15734,x=5,c=AUCT_CLAS_POTION},  -- Weak Troll's Blood Potion
	[3383]={b=400,s=100,d=15745,x=5,u=AUCT_TYPE_LEATHER},  -- Elixir of Wisdom
	[3384]={b=80,s=20,d=292,x=5,c=AUCT_CLAS_POTION},  -- Minor Magic Resistance Potion
	[3385]={b=120,s=30,d=15716,x=5,c=AUCT_CLAS_POTION,u=AUCT_TYPE_TAILOR},  -- Lesser Mana Potion
	[3386]={b=140,s=35,d=15750,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Poison Resistance
	[3387]={b=120,s=30,d=24213,x=5,c=AUCT_CLAS_POTION},  -- Limited Invulnerability Potion
	[3388]={b=160,s=40,d=15770,x=5,c=AUCT_CLAS_POTION},  -- Strong Troll's Blood Potion
	[3389]={b=160,s=40,d=15773,x=5,c=AUCT_CLAS_POTION,u=AUCT_TYPE_LEATHER},  -- Elixir of Defense
	[3390]={b=140,s=35,d=15787,x=5,u=AUCT_TYPE_LEATHER},  -- Elixir of Lesser Agility
	[3391]={b=80,s=20,d=15789,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Ogre's Strength
	[3392]={b=8317,s=1663,d=21310,c=AUCT_CLAS_ARMOR},  -- Ringed Helm
	[3393]={b=1000,s=250,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Minor Magic Resistance Potion
	[3394]={b=1000,s=250,d=1301},  -- Recipe: Elixir of Poison Resistance
	[3395]={b=1000,s=250,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Limited Invulnerability Potion
	[3396]={b=1000,s=250,d=1301,u=AUCT_TYPE_LEATHER},  -- Recipe: Elixir of Lesser Agility
	[3397]={b=0,s=0,d=6629,q=20,x=20},  -- Young Crocolisk Skin
	[3399]={b=325,s=81,d=6627,x=5},  -- Vulture Talon
	[3400]={b=13806,s=2761,d=20110,c=AUCT_CLAS_WEAPON},  -- Lucine Longsword
	[3401]={b=325,s=81,d=6628,x=5},  -- Rough Crocolisk Scale
	[3402]={b=2410,s=602,d=6691,x=5},  -- Soft Patch of Fur
	[3403]={b=1285,s=321,d=1225,x=5},  -- Ivory Boar Tusk
	[3404]={b=725,s=181,d=7338,x=10,u=AUCT_TYPE_COOK},  -- Buzzard Wing
	[3405]={b=0,s=0,d=7210},  -- Raven Claw Talisman
	[3406]={b=0,s=0,d=19567},  -- Black Feather Quill
	[3407]={b=0,s=0,d=1659},  -- Sapphire of Sky
	[3408]={b=0,s=0,d=7217},  -- Rune of Nesting
	[3409]={b=0,s=0,d=7186,q=20,x=20},  -- Nightsaber Fang
	[3411]={b=0,s=0,d=19528,q=20,x=20},  -- Strigid Owl Feather
	[3412]={b=0,s=0,d=18597,q=20,x=20,c=AUCT_CLAS_CLOTH},  -- Webwood Spider Silk
	[3413]={b=16147,s=3229,d=20589,c=AUCT_CLAS_WEAPON},  -- Doomspike
	[3414]={b=20144,s=4028,d=6796,c=AUCT_CLAS_WEAPON},  -- Crested Scepter
	[3415]={b=17993,s=3598,d=20339,c=AUCT_CLAS_WEAPON},  -- Staff of the Friar
	[3416]={b=11069,s=2213,d=12971,c=AUCT_CLAS_ARMOR},  -- Martyr's Chain
	[3417]={b=23146,s=4629,d=20174,c=AUCT_CLAS_WEAPON},  -- Onyx Claymore
	[3418]={b=0,s=0,d=7287,q=20,x=20},  -- Fel Cone
	[3419]={b=500,s=125,d=6549,c=AUCT_CLAS_WEAPON},  -- Red Rose
	[3420]={b=5000,s=1250,d=6483,c=AUCT_CLAS_WEAPON},  -- Black Rose
	[3421]={b=200,s=50,d=6560,c=AUCT_CLAS_WEAPON},  -- Simple Wildflowers
	[3422]={b=2000,s=500,d=6479,c=AUCT_CLAS_WEAPON},  -- Beautiful Wildflowers
	[3423]={b=20000,s=5000,d=6489,c=AUCT_CLAS_WEAPON},  -- Bouquet of White Roses
	[3424]={b=500000,s=125000,d=6487,c=AUCT_CLAS_WEAPON},  -- Bouquet of Black Roses
	[3425]={b=0,s=0,d=7292},  -- Woven Wand
	[3426]={b=4000,s=1000,d=16610,c=AUCT_CLAS_ARMOR},  -- Bold Yellow Shirt
	[3427]={b=6000,s=1500,d=7905,c=AUCT_CLAS_ARMOR},  -- Stylish Black Shirt
	[3428]={b=400,s=100,d=10892,c=AUCT_CLAS_ARMOR},  -- Common Gray Shirt
	[3429]={b=2931,s=586,d=4532,c=AUCT_CLAS_ARMOR},  -- Guardsman Belt
	[3430]={b=55134,s=11026,d=6612,c=AUCT_CLAS_WEAPON},  -- Sniper Rifle
	[3431]={b=6677,s=1335,d=17092,c=AUCT_CLAS_ARMOR},  -- Bone-studded Leather
	[3434]={b=15,s=3,d=6371,x=10},  -- Slumber Sand
	[3435]={b=98,s=19,d=3708,c=AUCT_CLAS_ARMOR},  -- Zombie Skin Bracers
	[3437]={b=119,s=23,d=6875,c=AUCT_CLAS_ARMOR},  -- Clasped Belt
	[3439]={b=150,s=30,d=3709,c=AUCT_CLAS_ARMOR},  -- Zombie Skin Boots
	[3440]={b=3202,s=640,d=6806,c=AUCT_CLAS_WEAPON},  -- Bonecracker
	[3442]={b=223,s=44,d=4500,c=AUCT_CLAS_ARMOR},  -- Apprentice Sash
	[3443]={b=691,s=138,d=8495,c=AUCT_CLAS_WEAPON},  -- Ceremonial Tomahawk
	[3444]={b=451,s=90,d=8698,c=AUCT_CLAS_ARMOR},  -- Tiller's Vest
	[3445]={b=1133,s=226,d=20599,c=AUCT_CLAS_WEAPON},  -- Ceremonial Knife
	[3446]={b=2963,s=592,d=20419,c=AUCT_CLAS_WEAPON},  -- Darkwood Staff
	[3447]={b=174,s=34,d=6880,c=AUCT_CLAS_ARMOR},  -- Cryptwalker Boots
	[3448]={b=25,s=6,d=1464,x=20},  -- Senggin Root
	[3449]={b=1035,s=207,d=23127,c=AUCT_CLAS_ARMOR},  -- Mystic Shawl
	[3450]={b=2217,s=443,d=18659,c=AUCT_CLAS_WEAPON},  -- Faerleia's Shield
	[3451]={b=2430,s=607,d=6541,c=AUCT_CLAS_WEAPON},  -- Nightglow Concoction
	[3452]={b=11610,s=2322,d=5120,c=AUCT_CLAS_WEAPON},  -- Ceranium Rod
	[3453]={b=232,s=46,d=16907,c=AUCT_CLAS_ARMOR},  -- Quilted Bracers
	[3454]={b=527,s=105,d=3755,c=AUCT_CLAS_ARMOR},  -- Reconnaissance Boots
	[3455]={b=941,s=188,d=20015,c=AUCT_CLAS_WEAPON},  -- Deathstalker Shortsword
	[3456]={b=25500,s=6375,d=15798},  -- Dog Whistle
	[3457]={b=2220,s=444,d=16850,c=AUCT_CLAS_ARMOR},  -- Stamped Trousers
	[3458]={b=1670,s=334,d=6982,c=AUCT_CLAS_ARMOR},  -- Rugged Mail Gloves
	[3460]={b=0,s=0,d=18115},  -- Johaan's Special Drink
	[3461]={b=5029,s=1005,d=12672,c=AUCT_CLAS_ARMOR},  -- High Robe of the Adjudicator
	[3462]={b=11418,s=2283,d=28607,c=AUCT_CLAS_WEAPON},  -- Talonstrike
	[3463]={b=37,s=9,d=20772,x=200,c=AUCT_CLAS_WEAPON},  -- Silver Star
	[3464]={b=35,s=8,d=26497,x=200,c=AUCT_CLAS_WEAPON},  -- Feathered Arrow
	[3465]={b=36,s=9,d=5998,x=200,c=AUCT_CLAS_WEAPON},  -- Exploding Shot
	[3466]={b=2000,s=500,d=7408,x=10,u=AUCT_TYPE_SMITH},  -- Strong Flux
	[3467]={b=0,s=0,d=6714},  -- Dull Iron Key
	[3468]={b=0,s=0,d=3411},  -- Renferrel's Findings
	[3469]={b=245,s=49,d=23528,c=AUCT_CLAS_ARMOR},  -- Copper Chain Boots
	[3470]={b=20,s=5,d=24678,x=20,u=AUCT_TYPE_SMITH},  -- Rough Grinding Stone
	[3471]={b=712,s=142,d=13090,c=AUCT_CLAS_ARMOR},  -- Copper Chain Vest
	[3472]={b=357,s=71,d=25850,c=AUCT_CLAS_ARMOR},  -- Runed Copper Gauntlets
	[3473]={b=1498,s=299,d=25849,c=AUCT_CLAS_ARMOR},  -- Runed Copper Pants
	[3474]={b=1083,s=216,d=9390,c=AUCT_CLAS_ARMOR},  -- Gemmed Copper Gauntlets
	[3476]={b=0,s=0,d=20898,q=20,x=20},  -- Gray Bear Tongue
	[3477]={b=0,s=0,d=2885},  -- Creeper Ichor
	[3478]={b=40,s=10,d=24679,x=20,u=AUCT_TYPE_SMITH},  -- Coarse Grinding Stone
	[3480]={b=2660,s=532,d=23531,c=AUCT_CLAS_ARMOR},  -- Rough Bronze Shoulders
	[3481]={b=6422,s=1284,d=9407,c=AUCT_CLAS_ARMOR},  -- Silvered Bronze Shoulders
	[3482]={b=6588,s=1317,d=9404,c=AUCT_CLAS_ARMOR},  -- Silvered Bronze Boots
	[3483]={b=4828,s=965,d=9406,c=AUCT_CLAS_ARMOR},  -- Silvered Bronze Gauntlets
	[3484]={b=8837,s=1767,d=9412,c=AUCT_CLAS_ARMOR},  -- Green Iron Boots
	[3485]={b=6477,s=1295,d=9414,c=AUCT_CLAS_ARMOR},  -- Green Iron Gauntlets
	[3486]={b=400,s=100,d=24680,x=20,u=AUCT_TYPE_SMITH},  -- Heavy Grinding Stone
	[3487]={b=7490,s=1498,d=20196,c=AUCT_CLAS_WEAPON},  -- Heavy Copper Broadsword
	[3488]={b=3066,s=613,d=8516,c=AUCT_CLAS_WEAPON},  -- Copper Battle Axe
	[3489]={b=4688,s=937,d=8496,c=AUCT_CLAS_WEAPON},  -- Thick War Axe
	[3490]={b=13658,s=2731,d=6445,c=AUCT_CLAS_WEAPON},  -- Deadly Bronze Poniard
	[3491]={b=13709,s=2741,d=5211,c=AUCT_CLAS_WEAPON},  -- Heavy Bronze Mace
	[3492]={b=22764,s=4552,d=3780,c=AUCT_CLAS_WEAPON},  -- Mighty Iron Hammer
	[3493]={b=17133,s=3426,d=20664,c=AUCT_CLAS_WEAPON},  -- Raptor's End
	[3495]={b=0,s=0,d=3788,c=AUCT_CLAS_POTION},  -- Elixir of Suffering
	[3496]={b=0,s=0,d=16452,q=20,x=20},  -- Mountain Lion Blood
	[3497]={b=0,s=0,d=3788,c=AUCT_CLAS_POTION},  -- Elixir of Pain
	[3498]={b=0,s=0,d=9657},  -- Taretha's Necklace
	[3499]={b=0,s=0,d=6710},  -- Burnished Gold Key
	[3502]={b=0,s=0,d=17459,q=20,x=20},  -- Mudsnout Blossoms
	[3505]={b=0,s=0,d=6012,q=20,x=20},  -- Alterac Signet Ring
	[3506]={b=0,s=0,d=7171},  -- Mudsnout Composite
	[3508]={b=0,s=0,d=7175},  -- Mudsnout Mixture
	[3509]={b=0,s=0,d=7043,q=20,x=20},  -- Daggerspine Scale
	[3510]={b=0,s=0,d=7110,q=20,x=20},  -- Torn Fin Eye
	[3511]={b=1338,s=267,d=23020,c=AUCT_CLAS_ARMOR},  -- Cloak of the People's Militia
	[3514]={b=0,s=0,d=2853},  -- Mor'Ladim's Skull
	[3515]={b=0,s=0,d=7030},  -- Ataeric's Staff
	[3516]={b=0,s=0,d=7038},  -- Lescovar's Head
	[3517]={b=0,s=0,d=7921},  -- Keg of Shindigger Stout
	[3518]={b=0,s=0,d=1096,c=AUCT_CLAS_WRITTEN},  -- Decrypted Letter
	[3520]={b=0,s=0,d=7921},  -- Tainted Keg
	[3521]={b=0,s=0,d=1323},  -- Cleverly Encrypted Letter
	[3530]={b=115,s=28,d=11909,x=20},  -- Wool Bandage
	[3531]={b=230,s=57,d=11910,x=20},  -- Heavy Wool Bandage
	[3550]={b=0,s=0,d=1310},  -- Targ's Head
	[3551]={b=0,s=0,d=1310},  -- Muckrake's Head
	[3552]={b=0,s=0,d=1310},  -- Glommus's Head
	[3553]={b=0,s=0,d=1310},  -- Mug'thol's Head
	[3554]={b=0,s=0,d=7077},  -- Crown of Will
	[3555]={b=5161,s=1032,d=16615,c=AUCT_CLAS_ARMOR},  -- Robe of Solomon
	[3556]={b=6429,s=1285,d=16544,c=AUCT_CLAS_ARMOR},  -- Dread Mage Hat
	[3558]={b=5220,s=1044,d=16528,c=AUCT_CLAS_ARMOR},  -- Fen Keeper Robe
	[3559]={b=2368,s=473,d=11626,c=AUCT_CLAS_ARMOR},  -- Night Watch Gauntlets
	[3560]={b=10514,s=2102,d=20715,c=AUCT_CLAS_ARMOR},  -- Mantle of Honor
	[3561]={b=4475,s=895,d=23135,c=AUCT_CLAS_ARMOR},  -- Resilient Poncho
	[3562]={b=4117,s=823,d=16910,c=AUCT_CLAS_ARMOR},  -- Belt of Vindication
	[3563]={b=2787,s=557,d=3179,c=AUCT_CLAS_ARMOR},  -- Seafarer's Pantaloons
	[3564]={b=0,s=0,d=7924},  -- Shipment of Iron
	[3565]={b=1403,s=280,d=14127,c=AUCT_CLAS_ARMOR},  -- Beerstained Gloves
	[3566]={b=10116,s=2023,d=17101,c=AUCT_CLAS_ARMOR},  -- Raptorbane Armor
	[3567]={b=4613,s=922,d=6601,c=AUCT_CLAS_FISHING},  -- Dwarven Fishing Pole
	[3569]={b=6310,s=1262,d=18122,c=AUCT_CLAS_ARMOR},  -- Vicar's Robe
	[3570]={b=4197,s=839,d=5197,c=AUCT_CLAS_WEAPON},  -- Bonegrinding Pestle
	[3571]={b=10593,s=2118,d=19546,c=AUCT_CLAS_WEAPON},  -- Trogg Beater
	[3572]={b=4861,s=972,d=5151,c=AUCT_CLAS_WEAPON},  -- Daryl's Shortsword
	[3573]={b=850,s=212,d=21321,c=AUCT_CLAS_CONTAINER},  -- Hunting Quiver
	[3574]={b=850,s=212,d=1816,c=AUCT_CLAS_CONTAINER},  -- Hunting Ammo Sack
	[3575]={b=800,s=200,d=7376,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_MINING..", "..AUCT_TYPE_SMITH},  -- Iron Bar
	[3576]={b=140,s=35,d=18086,x=20,u=AUCT_TYPE_MINING},  -- Tin Bar
	[3577]={b=2400,s=600,d=7352,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Gold Bar
	[3578]={b=1699,s=339,d=9380,c=AUCT_CLAS_ARMOR},  -- Harvester's Pants
	[3581]={b=5230,s=1046,d=20414,c=AUCT_CLAS_WEAPON},  -- Serrated Knife
	[3582]={b=2372,s=474,d=23085,c=AUCT_CLAS_ARMOR},  -- Acidproof Cloak
	[3583]={b=288,s=57,d=16948,c=AUCT_CLAS_ARMOR},  -- Weathered Belt
	[3585]={b=4767,s=953,d=16876,c=AUCT_CLAS_ARMOR},  -- Camouflaged Tunic
	[3586]={b=5171,s=1034,d=19231,c=AUCT_CLAS_WEAPON},  -- Logsplitter
	[3587]={b=14314,s=2862,d=16773,c=AUCT_CLAS_ARMOR},  -- Embroidered Belt
	[3588]={b=14365,s=2873,d=16774,c=AUCT_CLAS_ARMOR},  -- Embroidered Bracers
	[3589]={b=576,s=115,d=16788,c=AUCT_CLAS_ARMOR},  -- Heavy Weave Belt
	[3590]={b=578,s=115,d=16816,c=AUCT_CLAS_ARMOR},  -- Heavy Weave Bracers
	[3591]={b=2097,s=419,d=16834,c=AUCT_CLAS_ARMOR},  -- Padded Belt
	[3592]={b=2104,s=420,d=3645,c=AUCT_CLAS_ARMOR},  -- Padded Bracers
	[3593]={b=5477,s=1095,d=16835,c=AUCT_CLAS_ARMOR},  -- Russet Belt
	[3594]={b=5497,s=1099,d=3740,c=AUCT_CLAS_ARMOR},  -- Russet Bracers
	[3595]={b=23,s=4,d=16583,c=AUCT_CLAS_ARMOR},  -- Tattered Cloth Belt
	[3596]={b=23,s=4,d=16584,c=AUCT_CLAS_ARMOR},  -- Tattered Cloth Bracers
	[3597]={b=1081,s=216,d=16782,c=AUCT_CLAS_ARMOR},  -- Thick Cloth Belt
	[3598]={b=1085,s=217,d=3895,c=AUCT_CLAS_ARMOR},  -- Thick Cloth Bracers
	[3599]={b=24,s=4,d=16832,c=AUCT_CLAS_ARMOR},  -- Thin Cloth Belt
	[3600]={b=24,s=4,d=16929,c=AUCT_CLAS_ARMOR},  -- Thin Cloth Bracers
	[3601]={b=0,s=0,d=7263,c=AUCT_CLAS_WRITTEN},  -- Syndicate Missive
	[3602]={b=145,s=29,d=16577,c=AUCT_CLAS_ARMOR},  -- Knitted Belt
	[3603]={b=145,s=29,d=16930,c=AUCT_CLAS_ARMOR},  -- Knitted Bracers
	[3604]={b=2000,s=500,d=2584,c=AUCT_CLAS_CONTAINER},  -- Bandolier of the Night Watch
	[3605]={b=2000,s=500,d=21332,c=AUCT_CLAS_CONTAINER},  -- Quiver of the Night Watch
	[3606]={b=147,s=29,d=14456,c=AUCT_CLAS_ARMOR},  -- Woven Belt
	[3607]={b=148,s=29,d=14161,c=AUCT_CLAS_ARMOR},  -- Woven Bracers
	[3608]={b=2000,s=500,d=15274},  -- Plans: Mighty Iron Hammer
	[3609]={b=100,s=25,d=15274},  -- Plans: Copper Chain Vest
	[3610]={b=200,s=50,d=15274},  -- Plans: Gemmed Copper Gauntlets
	[3611]={b=2000,s=500,d=15274},  -- Plans: Green Iron Boots
	[3612]={b=2000,s=500,d=15274},  -- Plans: Green Iron Gauntlets
	[3613]={b=0,s=0,d=7282},  -- Valdred's Hands
	[3614]={b=0,s=0,d=6669},  -- Yowler's Paw
	[3615]={b=0,s=0,d=7038},  -- Kurzen's Head
	[3616]={b=0,s=0,d=6521},  -- Mind's Eye
	[3617]={b=0,s=0,d=7197},  -- Pendant of Shadow
	[3618]={b=0,s=0,d=7135},  -- Gobbler's Head
	[3619]={b=0,s=0,d=9515},  -- Snellig's Snuffbox
	[3621]={b=0,s=0,d=7150},  -- Ivar's Head
	[3622]={b=0,s=0,d=6371},  -- Essence of Nightlash
	[3623]={b=0,s=0,d=7038},  -- Thule's Head
	[3625]={b=0,s=0,d=7141},  -- Nek'rosh's Head
	[3626]={b=0,s=0,d=7038},  -- Head of Baron Vardus
	[3627]={b=0,s=0,d=3671},  -- Fang of Vagash
	[3628]={b=0,s=0,d=3913},  -- Hand of Dextren Ward
	[3629]={b=0,s=0,d=6538},  -- Mistmantle Family Ring
	[3630]={b=0,s=0,d=3914},  -- Head of Targorr
	[3631]={b=0,s=0,d=7042},  -- Bellygrub's Tusk
	[3632]={b=0,s=0,d=3916},  -- Fangore's Paw
	[3633]={b=0,s=0,d=3914},  -- Head of Gath'Ilzogg
	[3634]={b=0,s=0,d=3917},  -- Head of Grimson
	[3635]={b=0,s=0,d=3916},  -- Maggot Eye's Paw
	[3636]={b=0,s=0,d=7043},  -- Scale of Old Murk-Eye
	[3637]={b=0,s=0,d=3918},  -- Head of VanCleef
	[3638]={b=0,s=0,d=7089},  -- Sarltooth's Talon
	[3639]={b=0,s=0,d=7612},  -- Ear of Balgaras
	[3640]={b=0,s=0,d=3920},  -- Head of Deepfury
	[3641]={b=78,s=15,d=14423,c=AUCT_CLAS_ARMOR},  -- Journeyman's Bracers
	[3642]={b=111,s=22,d=14510,c=AUCT_CLAS_ARMOR},  -- Ancestral Bracers
	[3643]={b=355,s=71,d=14342,c=AUCT_CLAS_ARMOR},  -- Spellbinder Bracers
	[3644]={b=237,s=47,d=16595,c=AUCT_CLAS_ARMOR},  -- Barbaric Cloth Bracers
	[3645]={b=947,s=189,d=16915,c=AUCT_CLAS_ARMOR},  -- Seer's Cuffs
	[3647]={b=2169,s=433,d=14566,c=AUCT_CLAS_ARMOR},  -- Bright Bracers
	[3649]={b=575,s=115,d=18512,c=AUCT_CLAS_WEAPON},  -- Tribal Buckler
	[3650]={b=342,s=68,d=18655,c=AUCT_CLAS_WEAPON},  -- Battle Shield
	[3651]={b=2176,s=435,d=2052,c=AUCT_CLAS_WEAPON},  -- Veteran Shield
	[3652]={b=1820,s=364,d=18488,c=AUCT_CLAS_WEAPON},  -- Hunting Buckler
	[3653]={b=2192,s=438,d=1673,c=AUCT_CLAS_WEAPON},  -- Ceremonial Buckler
	[3654]={b=1834,s=366,d=18657,c=AUCT_CLAS_WEAPON},  -- Brackwater Shield
	[3655]={b=5111,s=1022,d=18696,c=AUCT_CLAS_WEAPON},  -- Burnished Shield
	[3656]={b=10584,s=2116,d=18702,c=AUCT_CLAS_WEAPON},  -- Lambent Scale Shield
	[3657]={b=0,s=0,d=2757,c=AUCT_CLAS_WRITTEN},  -- Hillsbrad Town Registry
	[3658]={b=0,s=0,d=1317,q=10,x=10},  -- Recovered Tome
	[3659]={b=0,s=0,d=1103},  -- Worn Leather Book
	[3660]={b=0,s=0,d=8731},  -- Tomes of Alterac
	[3661]={b=45,s=9,d=18530,c=AUCT_CLAS_WEAPON},  -- Handcrafted Staff
	[3662]={b=100,s=25,d=22194,x=20},  -- Crocolisk Steak
	[3663]={b=500,s=125,d=6347,x=20,c=AUCT_CLAS_FOOD},  -- Murloc Fin Soup
	[3664]={b=400,s=100,d=6347,x=20,c=AUCT_CLAS_FOOD},  -- Crocolisk Gumbo
	[3665]={b=600,s=150,d=18053,x=20,c=AUCT_CLAS_FOOD},  -- Curiously Tasty Omelet
	[3666]={b=400,s=100,d=6342,x=20,c=AUCT_CLAS_FOOD},  -- Gooey Spider Cake
	[3667]={b=100,s=25,d=6350,x=10,u=AUCT_TYPE_COOK},  -- Tender Crocolisk Meat
	[3668]={b=0,s=0,d=1323,c=AUCT_CLAS_QUEST},  -- Assassin's Contract
	[3669]={b=780,s=195,d=2637,x=5},  -- Gelatinous Goo
	[3670]={b=280,s=70,d=6668,x=5},  -- Large Slimy Bone
	[3671]={b=805,s=201,d=7102,x=5},  -- Lifeless Skull
	[3672]={b=0,s=0,d=7141},  -- Head of Nagaz
	[3673]={b=180,s=45,d=6616,x=100},  -- Broken Arrow
	[3674]={b=380,s=95,d=6638,x=5},  -- Decomposed Boot
	[3676]={b=425,s=106,d=6690,x=5},  -- Slimy Ichor
	[3678]={b=400,s=100,d=1102},  -- Recipe: Crocolisk Steak
	[3679]={b=400,s=100,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Blood Sausage
	[3680]={b=1600,s=400,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Murloc Fin Soup
	[3681]={b=1600,s=400,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Crocolisk Gumbo
	[3682]={b=1600,s=400,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Curiously Tasty Omelet
	[3683]={b=1600,s=400,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Gooey Spider Cake
	[3684]={b=0,s=0,d=7198},  -- Perenolde Tiara
	[3685]={b=285,s=71,d=18050,x=10,u=AUCT_TYPE_COOK},  -- Raptor Egg
	[3688]={b=0,s=0,d=7051},  -- Bloodstone Oval
	[3689]={b=0,s=0,d=7050},  -- Bloodstone Marble
	[3690]={b=0,s=0,d=7052},  -- Bloodstone Shard
	[3691]={b=0,s=0,d=7053},  -- Bloodstone Wedge
	[3692]={b=0,s=0,d=7100,q=20,x=20},  -- Hillsbrad Human Skull
	[3693]={b=0,s=0,d=7147},  -- Humbert's Sword
	[3701]={b=0,s=0,d=6639},  -- Darthalia's Sealed Commendation
	[3702]={b=1995,s=498,d=4045,x=10},  -- Bear Gall Bladder
	[3703]={b=145,s=36,d=18102,x=10},  -- Southshore Stout
	[3704]={b=0,s=0,d=6713},  -- Rusted Iron Key
	[3706]={b=0,s=0,d=7015,c=AUCT_CLAS_QUEST},  -- Ensorcelled Parchment
	[3708]={b=0,s=0,d=10275},  -- Helcular's Rod
	[3710]={b=0,s=0,d=10275},  -- Rod of Helcular
	[3711]={b=0,s=0,d=4049,c=AUCT_CLAS_WRITTEN},  -- Belamoore's Research Journal
	[3712]={b=350,s=87,d=25472,x=10,u=AUCT_TYPE_COOK},  -- Turtle Meat
	[3713]={b=160,s=40,d=1443,x=20,u=AUCT_TYPE_COOK},  -- Soothing Spices
	[3714]={b=0,s=0,d=7291,q=20,x=20},  -- Worn Stone Token
	[3715]={b=0,s=0,d=7059,q=20,x=20},  -- Bracers of Earth Binding
	[3716]={b=0,s=0,d=9585,q=20,x=20},  -- Murloc Head
	[3717]={b=0,s=0,d=7219},  -- Sack of Murloc Heads
	[3718]={b=0,s=0,d=1323,c=AUCT_CLAS_WRITTEN},  -- Foreboding Plans
	[3719]={b=5139,s=1027,d=23040,c=AUCT_CLAS_ARMOR},  -- Hillman's Cloak
	[3720]={b=0,s=0,d=7294,q=20,x=20},  -- Yeti Fur
	[3721]={b=0,s=0,d=3031},  -- Farren's Report
	[3722]={b=855,s=213,d=6655,x=5},  -- Familiar Hide
	[3723]={b=275,s=68,d=6630,x=5},  -- Familiar Fang
	[3724]={b=325,s=81,d=6651,x=5},  -- Familiar Claw
	[3725]={b=666,s=166,d=6656,x=5},  -- Familiar Horn
	[3726]={b=500,s=125,d=22194,x=20,c=AUCT_CLAS_FOOD},  -- Big Bear Steak
	[3727]={b=500,s=125,d=6327,x=20,c=AUCT_CLAS_FOOD},  -- Hot Lion Chops
	[3728]={b=1200,s=300,d=6419,x=20,c=AUCT_CLAS_FOOD},  -- Tasty Lion Steak
	[3729]={b=1200,s=300,d=6414,x=20},  -- Soothing Turtle Bisque
	[3730]={b=180,s=45,d=6350,x=10,u=AUCT_TYPE_COOK},  -- Big Bear Meat
	[3731]={b=220,s=55,d=25466,x=10,u=AUCT_TYPE_COOK},  -- Lion Meat
	[3732]={b=4006,s=801,d=15339,c=AUCT_CLAS_ARMOR},  -- Hooded Cowl
	[3733]={b=6347,s=1269,d=4085,c=AUCT_CLAS_ARMOR},  -- Orcish War Chain
	[3734]={b=1600,s=400,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Big Bear Steak
	[3735]={b=1800,s=450,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Hot Lion Chops
	[3736]={b=2000,s=500,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Tasty Lion Steak
	[3737]={b=2200,s=550,d=1102},  -- Recipe: Soothing Turtle Bisque
	[3739]={b=5000,s=1250,d=16132,c=AUCT_CLAS_ARMOR},  -- Skull Ring
	[3740]={b=12262,s=2452,d=22226,c=AUCT_CLAS_WEAPON},  -- Decapitating Sword
	[3741]={b=4614,s=922,d=17164,c=AUCT_CLAS_ARMOR},  -- Stomping Boots
	[3742]={b=14311,s=2862,d=20667,c=AUCT_CLAS_WEAPON},  -- Bow of Plunder
	[3743]={b=12256,s=2451,d=6275,c=AUCT_CLAS_WEAPON},  -- Sentry Buckler
	[3744]={b=0,s=0,d=1399},  -- Bloodstone Pendant
	[3745]={b=0,s=0,d=7218,q=20,x=20},  -- Rune of Opening
	[3747]={b=5462,s=1092,d=11167,c=AUCT_CLAS_ARMOR},  -- Meditative Sash
	[3748]={b=6524,s=1304,d=10169,c=AUCT_CLAS_ARMOR},  -- Feline Mantle
	[3749]={b=6603,s=1320,d=23118,c=AUCT_CLAS_ARMOR},  -- High Apothecary Cloak
	[3750]={b=11048,s=2209,d=8732,c=AUCT_CLAS_ARMOR},  -- Ribbed Breastplate
	[3751]={b=13307,s=2661,d=3083,c=AUCT_CLAS_ARMOR},  -- Mercenary Leggings
	[3752]={b=3729,s=745,d=8666,c=AUCT_CLAS_ARMOR},  -- Grunt Vest
	[3753]={b=8178,s=1635,d=17129,c=AUCT_CLAS_ARMOR},  -- Shepherd's Girdle
	[3754]={b=7461,s=1492,d=17186,c=AUCT_CLAS_ARMOR},  -- Shepherd's Gloves
	[3755]={b=27236,s=5447,d=19228,c=AUCT_CLAS_WEAPON},  -- Fish Gutter
	[3758]={b=9086,s=1817,d=6902,c=AUCT_CLAS_ARMOR},  -- Crusader Belt
	[3759]={b=6080,s=1216,d=16944,c=AUCT_CLAS_ARMOR},  -- Insulated Sage Gloves
	[3760]={b=6000,s=1500,d=963,c=AUCT_CLAS_ARMOR},  -- Band of the Undercity
	[3761]={b=16533,s=3306,d=18769,c=AUCT_CLAS_WEAPON},  -- Deadskull Shield
	[3763]={b=33805,s=6761,d=6272,c=AUCT_CLAS_WEAPON},  -- Lunar Buckler
	[3764]={b=15905,s=3181,d=3750,c=AUCT_CLAS_ARMOR},  -- Mantis Boots
	[3765]={b=24057,s=4811,d=6971,c=AUCT_CLAS_ARMOR},  -- Brigand's Pauldrons
	[3766]={b=120,s=30,d=19569,x=10},  -- Gryphon Feather Quill
	[3767]={b=95,s=23,d=4110,x=5},  -- Fine Parchment
	[3769]={b=55,s=13,d=6620,x=5},  -- Broken Wand
	[3770]={b=500,s=25,d=6350,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Mutton Chop
	[3771]={b=1000,s=50,d=4113,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Wild Hog Shank
	[3772]={b=0,s=0,d=18079,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Conjured Spring Water
	[3775]={b=52,s=13,d=13708,x=10,c=AUCT_TYPE_POISON},  -- Crippling Poison
	[3776]={b=700,s=175,d=2947,x=10,c=AUCT_CLAS_POISON},  -- Crippling Poison II
	[3777]={b=40,s=10,d=6371,x=20,u=AUCT_TYPE_POISON},  -- Lethargy Root
	[3778]={b=7705,s=1541,d=20660,c=AUCT_CLAS_WEAPON},  -- Taut Compound Bow
	[3779]={b=14175,s=2835,d=19287,c=AUCT_CLAS_WEAPON},  -- Hefty War Axe
	[3780]={b=9388,s=1877,d=20717,c=AUCT_CLAS_WEAPON},  -- Long-barreled Musket
	[3781]={b=15628,s=3125,d=20150,c=AUCT_CLAS_WEAPON},  -- Broad Claymore
	[3782]={b=17257,s=3451,d=19532,c=AUCT_CLAS_WEAPON},  -- Large War Club
	[3783]={b=15244,s=3048,d=20216,c=AUCT_CLAS_WEAPON},  -- Light Scimitar
	[3784]={b=21042,s=4208,d=20350,c=AUCT_CLAS_WEAPON},  -- Metal Stave
	[3785]={b=18250,s=3650,d=8480,c=AUCT_CLAS_WEAPON},  -- Keen Axe
	[3786]={b=19785,s=3957,d=6468,c=AUCT_CLAS_WEAPON},  -- Shiny Dirk
	[3787]={b=21448,s=4289,d=19694,c=AUCT_CLAS_WEAPON},  -- Stone Club
	[3792]={b=2606,s=521,d=12424,c=AUCT_CLAS_ARMOR},  -- Interlaced Belt
	[3793]={b=3243,s=648,d=6190,c=AUCT_CLAS_ARMOR},  -- Interlaced Boots
	[3794]={b=3874,s=774,d=16571,c=AUCT_CLAS_ARMOR},  -- Interlaced Bracers
	[3795]={b=4909,s=981,d=23120,c=AUCT_CLAS_ARMOR},  -- Interlaced Cloak
	[3796]={b=2467,s=493,d=16569,c=AUCT_CLAS_ARMOR},  -- Interlaced Gloves
	[3797]={b=8460,s=1692,d=14711,c=AUCT_CLAS_ARMOR},  -- Interlaced Pants
	[3798]={b=4510,s=902,d=14091,c=AUCT_CLAS_ARMOR},  -- Interlaced Shoulderpads
	[3799]={b=7304,s=1460,d=16568,c=AUCT_CLAS_ARMOR},  -- Interlaced Vest
	[3800]={b=5343,s=1068,d=19042,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Belt
	[3801]={b=5156,s=1031,d=19043,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Boots
	[3802]={b=3136,s=627,d=14803,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Bracers
	[3803]={b=5432,s=1086,d=23036,c=AUCT_CLAS_ARMOR},  -- Hardened Cloak
	[3804]={b=3825,s=765,d=19044,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Gloves
	[3805]={b=5245,s=1049,d=19041,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Pants
	[3806]={b=6359,s=1271,d=11270,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Shoulderpads
	[3807]={b=5813,s=1162,d=19040,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Tunic
	[3808]={b=3851,s=770,d=6902,c=AUCT_CLAS_ARMOR},  -- Double Mail Belt
	[3809]={b=4813,s=962,d=6903,c=AUCT_CLAS_ARMOR},  -- Double Mail Boots
	[3810]={b=5728,s=1145,d=6904,c=AUCT_CLAS_ARMOR},  -- Double Mail Bracers
	[3811]={b=5323,s=1064,d=15121,c=AUCT_CLAS_ARMOR},  -- Double-stitched Cloak
	[3812]={b=4856,s=971,d=6905,c=AUCT_CLAS_ARMOR},  -- Double Mail Gloves
	[3813]={b=8862,s=1772,d=687,c=AUCT_CLAS_ARMOR},  -- Double Mail Pants
	[3814]={b=9457,s=1891,d=6914,c=AUCT_CLAS_ARMOR},  -- Double Mail Shoulderpads
	[3815]={b=7377,s=1475,d=977,c=AUCT_CLAS_ARMOR},  -- Double Mail Vest
	[3816]={b=10511,s=2102,d=4130,c=AUCT_CLAS_WEAPON},  -- Reflective Heater
	[3817]={b=7925,s=1585,d=18481,c=AUCT_CLAS_WEAPON},  -- Reinforced Buckler
	[3818]={b=500,s=125,d=18169,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Fadeleaf
	[3819]={b=400,s=100,d=7364,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Wintersbite
	[3820]={b=400,s=100,d=18089,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Stranglekelp
	[3821]={b=600,s=150,d=19497,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_COOK},  -- Goldthorn
	[3822]={b=32405,s=6481,d=20180,c=AUCT_CLAS_WEAPON},  -- Runic Darkblade
	[3823]={b=400,s=100,d=2354,x=5,c=AUCT_CLAS_POTION},  -- Lesser Invisibility Potion
	[3824]={b=600,s=150,d=17469,x=5,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Shadow Oil
	[3825]={b=440,s=110,d=15790,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Fortitude
	[3826]={b=420,s=105,d=15793,x=5,c=AUCT_CLAS_POTION},  -- Mighty Troll's Blood Potion
	[3827]={b=480,s=120,d=15717,x=5,c=AUCT_CLAS_POTION,u=AUCT_TYPE_TAILOR},  -- Mana Potion
	[3828]={b=600,s=150,d=4137,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Detect Lesser Invisibility
	[3829]={b=600,s=150,d=15794,x=5,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Frost Oil
	[3830]={b=2000,s=500,d=1301},  -- Recipe: Elixir of Fortitude
	[3831]={b=2200,s=550,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Mighty Troll's Blood Potion
	[3832]={b=2200,s=550,d=15274},  -- Recipe: Elixir of Detect Lesser Invisibility
	[3833]={b=121,s=24,d=23089,c=AUCT_CLAS_ARMOR},  -- Adept's Cloak
	[3834]={b=162,s=32,d=16839,c=AUCT_CLAS_ARMOR},  -- Sturdy Cloth Trousers
	[3835]={b=5532,s=1106,d=9417,c=AUCT_CLAS_ARMOR},  -- Green Iron Bracers
	[3836]={b=15268,s=3053,d=25658,c=AUCT_CLAS_ARMOR},  -- Green Iron Helm
	[3837]={b=22027,s=4405,d=15333,c=AUCT_CLAS_ARMOR},  -- Golden Scale Coif
	[3838]={b=0,s=0,d=7089,q=20,x=20},  -- Shadowmaw Claw
	[3839]={b=0,s=0,d=7186},  -- Pristine Tigress Fang
	[3840]={b=12855,s=2571,d=9422,c=AUCT_CLAS_ARMOR},  -- Green Iron Shoulders
	[3841]={b=15534,s=3106,d=9424,c=AUCT_CLAS_ARMOR},  -- Golden Scale Shoulders
	[3842]={b=14531,s=2906,d=9415,c=AUCT_CLAS_ARMOR},  -- Green Iron Leggings
	[3843]={b=19413,s=3882,d=9242,c=AUCT_CLAS_ARMOR},  -- Golden Scale Leggings
	[3844]={b=28293,s=5658,d=13088,c=AUCT_CLAS_ARMOR},  -- Green Iron Hauberk
	[3845]={b=32794,s=6558,d=9425,c=AUCT_CLAS_ARMOR},  -- Golden Scale Cuirass
	[3846]={b=19685,s=3937,d=23537,c=AUCT_CLAS_ARMOR},  -- Polished Steel Boots
	[3847]={b=24887,s=4977,d=9426,c=AUCT_CLAS_ARMOR},  -- Golden Scale Boots
	[3848]={b=7130,s=1426,d=6434,c=AUCT_CLAS_WEAPON},  -- Big Bronze Knife
	[3849]={b=27340,s=5468,d=5153,c=AUCT_CLAS_WEAPON},  -- Hardened Iron Shortsword
	[3850]={b=36523,s=7304,d=20215,c=AUCT_CLAS_WEAPON},  -- Jade Serpentblade
	[3851]={b=31294,s=6258,d=19647,c=AUCT_CLAS_WEAPON},  -- Solid Iron Maul
	[3852]={b=41804,s=8360,d=15468,c=AUCT_CLAS_WEAPON},  -- Golden Iron Destroyer
	[3853]={b=50768,s=10153,d=7324,c=AUCT_CLAS_WEAPON},  -- Moonsteel Broadsword
	[3854]={b=70603,s=14120,d=20252,c=AUCT_CLAS_WEAPON},  -- Frost Tiger Blade
	[3855]={b=56243,s=11248,d=8528,c=AUCT_CLAS_WEAPON},  -- Massive Iron Axe
	[3856]={b=71106,s=14221,d=8533,c=AUCT_CLAS_WEAPON},  -- Shadow Crescent Axe
	[3857]={b=500,s=125,d=7340,x=10,u=AUCT_TYPE_MINING},  -- Coal
	[3858]={b=1000,s=250,d=20661,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_MINING},  -- Mithril Ore
	[3859]={b=240,s=60,d=7392,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Steel Bar
	[3860]={b=1600,s=400,d=20659,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Mithril Bar
	[3862]={b=0,s=0,d=20951},  -- Aged Gorilla Sinew
	[3863]={b=0,s=0,d=11205,q=20,x=20},  -- Jungle Stalker Feather
	[3864]={b=3200,s=800,d=7339,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Citrine
	[3866]={b=4000,s=1000,d=15274},  -- Plans: Jade Serpentblade
	[3867]={b=3800,s=950,d=15274},  -- Plans: Golden Iron Destroyer
	[3868]={b=5000,s=1250,d=15274},  -- Plans: Frost Tiger Blade
	[3869]={b=5000,s=1250,d=15274},  -- Plans: Shadow Crescent Axe
	[3870]={b=3000,s=750,d=15274},  -- Plans: Green Iron Shoulders
	[3871]={b=3400,s=850,d=1102},  -- Plans: Golden Scale Shoulders
	[3872]={b=3200,s=800,d=15274},  -- Plans: Golden Scale Leggings
	[3873]={b=4400,s=1100,d=15274},  -- Plans: Golden Scale Cuirass
	[3874]={b=4400,s=1100,d=15274},  -- Plans: Polished Steel Boots
	[3875]={b=5000,s=1250,d=1102},  -- Plans: Golden Scale Boots
	[3876]={b=0,s=0,d=1151},  -- Fang of Bhag'thera
	[3877]={b=0,s=0,d=7266},  -- Talon of Tethis
	[3879]={b=0,s=0,d=7230},  -- Paw of Sin'Dall
	[3880]={b=0,s=0,d=5689},  -- Head of Bangalash
	[3882]={b=55,s=13,d=19531,x=10},  -- Buzzard Feather
	[3889]={b=7922,s=1584,d=15908,c=AUCT_CLAS_ARMOR},  -- Russet Hat
	[3890]={b=10201,s=2040,d=17204,c=AUCT_CLAS_ARMOR},  -- Studded Hat
	[3891]={b=12284,s=2456,d=15318,c=AUCT_CLAS_ARMOR},  -- Augmented Chain Helm
	[3892]={b=21940,s=4388,d=16775,c=AUCT_CLAS_ARMOR},  -- Embroidered Hat
	[3893]={b=27523,s=5504,d=21308,c=AUCT_CLAS_ARMOR},  -- Reinforced Leather Cap
	[3894]={b=29986,s=5997,d=15320,c=AUCT_CLAS_ARMOR},  -- Brigandine Helm
	[3897]={b=0,s=0,d=7110},  -- Dizzy's Eye
	[3898]={b=0,s=0,d=1102},  -- Library Scrip
	[3899]={b=100,s=25,d=6672,c=AUCT_CLAS_WRITTEN},  -- Legends of the Gurubashi, Volume 3
	[3900]={b=0,s=0,d=18078,q=20,x=20},  -- Pupellyverbos Port
	[3901]={b=0,s=0,d=7048,q=20,x=20},  -- Bloodscalp Tusk
	[3902]={b=6588,s=1317,d=20412,c=AUCT_CLAS_WEAPON},  -- Staff of Nobles
	[3904]={b=0,s=0,d=1310},  -- Gan'zulah's Head
	[3905]={b=0,s=0,d=1310},  -- Nezzliok's Head
	[3906]={b=0,s=0,d=7036,q=20,x=20},  -- Balia'mah Trophy
	[3907]={b=0,s=0,d=7100,q=20,x=20},  -- Ziata'jai Trophy
	[3908]={b=0,s=0,d=7100,q=20,x=20},  -- Zul'Mamwe Trophy
	[3909]={b=0,s=0,d=7063},  -- Broken Armor of Ana'thek
	[3910]={b=0,s=0,d=7171,q=20,x=20},  -- Snuff
	[3911]={b=0,s=0,d=7205,q=20,x=20},  -- Pulsing Blue Shard
	[3912]={b=0,s=0,d=7257},  -- Soul Gem
	[3913]={b=0,s=0,d=6554},  -- Filled Soul Gem
	[3914]={b=25000,s=6250,d=1283,c=AUCT_CLAS_CONTAINER},  -- Journeyman's Backpack
	[3915]={b=0,s=0,d=7054,q=20,x=20},  -- Bloody Bone Necklace
	[3916]={b=0,s=0,d=18075,q=20,x=20},  -- Split Bone Necklace
	[3917]={b=0,s=0,d=6546,q=20,x=20},  -- Singing Blue Crystal
	[3918]={b=0,s=0,d=6614,q=20,x=20},  -- Singing Crystal Shard
	[3919]={b=0,s=0,d=7168,q=20,x=20},  -- Mistvale Giblets
	[3920]={b=0,s=0,d=7047},  -- Bloodsail Charts
	[3921]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Bloodsail Orders
	[3922]={b=0,s=0,d=4280},  -- Shaky's Payment
	[3923]={b=0,s=0,d=7284,q=20,x=20},  -- Water Elemental Bracers
	[3924]={b=0,s=0,d=7161},  -- Maury's Clubbed Foot
	[3925]={b=0,s=0,d=7151},  -- Jon-Jon's Golden Spyglass
	[3926]={b=0,s=0,d=4284},  -- Chucky's Huge Ring
	[3927]={b=2000,s=150,d=6425,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Fine Aged Cheddar
	[3928]={b=1000,s=250,d=15714,x=5,c=AUCT_CLAS_POTION},  -- Superior Healing Potion
	[3930]={b=0,s=0,d=4287},  -- Maury's Key
	[3931]={b=740,s=185,d=959,x=5},  -- Poisoned Spider Fang
	[3932]={b=0,s=0,d=12333},  -- Smotts' Chest
	[3935]={b=0,s=0,d=4800,c=AUCT_CLAS_WEAPON},  -- Smotts' Cutlass
	[3936]={b=4926,s=985,d=16722,c=AUCT_CLAS_ARMOR},  -- Crochet Belt
	[3937]={b=10092,s=2018,d=16721,c=AUCT_CLAS_ARMOR},  -- Crochet Boots
	[3938]={b=5949,s=1189,d=16724,c=AUCT_CLAS_ARMOR},  -- Crochet Bracers
	[3939]={b=11283,s=2256,d=23101,c=AUCT_CLAS_ARMOR},  -- Crochet Cloak
	[3940]={b=8154,s=1630,d=16720,c=AUCT_CLAS_ARMOR},  -- Crochet Gloves
	[3941]={b=12993,s=2598,d=16719,c=AUCT_CLAS_ARMOR},  -- Crochet Pants
	[3942]={b=13183,s=2636,d=14396,c=AUCT_CLAS_ARMOR},  -- Crochet Shoulderpads
	[3943]={b=11221,s=2244,d=16718,c=AUCT_CLAS_ARMOR},  -- Crochet Vest
	[3944]={b=11389,s=2277,d=16704,c=AUCT_CLAS_ARMOR},  -- Twill Belt
	[3945]={b=19263,s=3852,d=16703,c=AUCT_CLAS_ARMOR},  -- Twill Boots
	[3946]={b=12159,s=2431,d=9894,c=AUCT_CLAS_ARMOR},  -- Twill Bracers
	[3947]={b=16292,s=3258,d=16707,c=AUCT_CLAS_ARMOR},  -- Twill Cloak
	[3948]={b=15463,s=3092,d=16702,c=AUCT_CLAS_ARMOR},  -- Twill Gloves
	[3949]={b=32586,s=6517,d=16701,c=AUCT_CLAS_ARMOR},  -- Twill Pants
	[3950]={b=20789,s=4157,d=16706,c=AUCT_CLAS_ARMOR},  -- Twill Shoulderpads
	[3951]={b=29487,s=5897,d=16700,c=AUCT_CLAS_ARMOR},  -- Twill Vest
	[3960]={b=0,s=0,d=6430},  -- Bag of Water Elemental Bracers
	[3961]={b=7518,s=1503,d=16943,c=AUCT_CLAS_ARMOR},  -- Thick Leather Belt
	[3962]={b=15399,s=3079,d=18419,c=AUCT_CLAS_ARMOR},  -- Thick Leather Boots
	[3963]={b=7012,s=1402,d=17021,c=AUCT_CLAS_ARMOR},  -- Thick Leather Bracers
	[3964]={b=10638,s=2127,d=23070,c=AUCT_CLAS_ARMOR},  -- Thick Cloak
	[3965]={b=11105,s=2221,d=17188,c=AUCT_CLAS_ARMOR},  -- Thick Leather Gloves
	[3966]={b=13128,s=2625,d=17155,c=AUCT_CLAS_ARMOR},  -- Thick Leather Pants
	[3967]={b=14519,s=2903,d=17196,c=AUCT_CLAS_ARMOR},  -- Thick Leather Shoulderpads
	[3968]={b=16656,s=3331,d=17105,c=AUCT_CLAS_ARMOR},  -- Thick Leather Tunic
	[3969]={b=16283,s=3256,d=14408,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Belt
	[3970]={b=21481,s=4296,d=16994,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Boots
	[3971]={b=19057,s=3811,d=17171,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Bracers
	[3972]={b=19456,s=3891,d=23065,c=AUCT_CLAS_ARMOR},  -- Smooth Cloak
	[3973]={b=18286,s=3657,d=17069,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Gloves
	[3974]={b=27434,s=5486,d=16972,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Pants
	[3975]={b=19482,s=3896,d=4486,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Shoulderpads
	[3976]={b=34894,s=6978,d=11138,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Armor
	[3985]={b=0,s=0,d=16829,c=AUCT_CLAS_QUEST},  -- Monogrammed Sash
	[3986]={b=26664,s=5332,d=18814,c=AUCT_CLAS_WEAPON},  -- Protective Pavise
	[3987]={b=34185,s=6837,d=18774,c=AUCT_CLAS_WEAPON},  -- Deflecting Tower
	[3989]={b=15772,s=3154,d=18472,c=AUCT_CLAS_WEAPON},  -- Blocking Targe
	[3990]={b=41186,s=8237,d=17885,c=AUCT_CLAS_WEAPON},  -- Crested Buckler
	[3992]={b=15410,s=3082,d=6946,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Belt
	[3993]={b=24704,s=4940,d=6947,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Boots
	[3994]={b=22023,s=4404,d=6948,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Bracers
	[3995]={b=31422,s=6284,d=15068,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Cloak
	[3996]={b=23299,s=4659,d=6949,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Gloves
	[3997]={b=39648,s=7929,d=4339,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Pants
	[3998]={b=28280,s=5656,d=10170,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Shoulderpads
	[3999]={b=35547,s=7109,d=8672,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Armor
	[4000]={b=8986,s=1797,d=6964,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Belt
	[4001]={b=15852,s=3170,d=6965,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Boots
	[4002]={b=12315,s=2463,d=6966,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Bracers
	[4003]={b=20451,s=4090,d=15106,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Cloak
	[4004]={b=11788,s=2357,d=6967,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Gloves
	[4005]={b=17389,s=3477,d=4333,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Pants
	[4006]={b=12172,s=2434,d=28392,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Shoulderpads
	[4007]={b=18480,s=3696,d=11565,c=AUCT_CLAS_ARMOR},  -- Overlinked Chain Armor
	[4016]={b=0,s=0,d=1288,q=20,x=20},  -- Zanzil's Mixture
	[4017]={b=34550,s=6910,d=20225,c=AUCT_CLAS_WEAPON},  -- Sharp Shortsword
	[4018]={b=31863,s=6372,d=20195,c=AUCT_CLAS_WEAPON},  -- Whetted Claymore
	[4019]={b=41683,s=8336,d=8478,c=AUCT_CLAS_WEAPON},  -- Heavy Flint Axe
	[4020]={b=55948,s=11189,d=19374,c=AUCT_CLAS_WEAPON},  -- Splintering Battle Axe
	[4021]={b=35991,s=7198,d=19716,c=AUCT_CLAS_WEAPON},  -- Blunting Mace
	[4022]={b=60297,s=12059,d=19526,c=AUCT_CLAS_WEAPON},  -- Crushing Maul
	[4023]={b=31079,s=6215,d=4119,c=AUCT_CLAS_WEAPON},  -- Fine Pointed Dagger
	[4024]={b=49109,s=9821,d=20309,c=AUCT_CLAS_WEAPON},  -- Heavy War Staff
	[4025]={b=25351,s=5070,d=20550,c=AUCT_CLAS_WEAPON},  -- Balanced Long Bow
	[4026]={b=21812,s=4362,d=20721,c=AUCT_CLAS_WEAPON},  -- Sentinel Musket
	[4027]={b=0,s=0,d=7069},  -- Catelyn's Blade
	[4028]={b=0,s=0,d=7065},  -- Bundle of Akiris Reeds
	[4029]={b=0,s=0,d=3427,q=20,x=20},  -- Akiris Reed
	[4034]={b=0,s=0,d=7261},  -- Stone of the Tides
	[4035]={b=9944,s=1988,d=16643,c=AUCT_CLAS_ARMOR},  -- Silver-thread Robe
	[4036]={b=3408,s=681,d=4607,c=AUCT_CLAS_ARMOR},  -- Silver-thread Cuffs
	[4037]={b=9106,s=1821,d=14989,c=AUCT_CLAS_ARMOR},  -- Silver-thread Pants
	[4038]={b=17810,s=3562,d=27557,c=AUCT_CLAS_ARMOR},  -- Nightsky Robe
	[4039]={b=11078,s=2215,d=15298,c=AUCT_CLAS_ARMOR},  -- Nightsky Cowl
	[4040]={b=6738,s=1347,d=14623,c=AUCT_CLAS_ARMOR},  -- Nightsky Gloves
	[4041]={b=15749,s=3149,d=15287,c=AUCT_CLAS_ARMOR},  -- Aurora Cowl
	[4042]={b=10536,s=2107,d=14661,c=AUCT_CLAS_ARMOR},  -- Aurora Gloves
	[4043]={b=9790,s=1958,d=14652,c=AUCT_CLAS_ARMOR},  -- Aurora Bracers
	[4044]={b=22921,s=4584,d=14659,c=AUCT_CLAS_ARMOR},  -- Aurora Pants
	[4045]={b=13415,s=2683,d=14680,c=AUCT_CLAS_ARMOR},  -- Mistscape Bracers
	[4046]={b=33919,s=6783,d=14685,c=AUCT_CLAS_ARMOR},  -- Mistscape Pants
	[4047]={b=19799,s=3959,d=14679,c=AUCT_CLAS_ARMOR},  -- Mistscape Boots
	[4048]={b=8837,s=1767,d=17199,c=AUCT_CLAS_ARMOR},  -- Emblazoned Hat
	[4049]={b=4443,s=888,d=14601,c=AUCT_CLAS_ARMOR},  -- Emblazoned Bracers
	[4050]={b=11874,s=2374,d=17141,c=AUCT_CLAS_ARMOR},  -- Emblazoned Leggings
	[4051]={b=8349,s=1669,d=17161,c=AUCT_CLAS_ARMOR},  -- Emblazoned Boots
	[4052]={b=13498,s=2699,d=21304,c=AUCT_CLAS_ARMOR},  -- Insignia Cap
	[4053]={b=0,s=0,d=6629,q=20,x=20},  -- Large River Crocolisk Skin
	[4054]={b=18129,s=3625,d=17149,c=AUCT_CLAS_ARMOR},  -- Insignia Leggings
	[4055]={b=12406,s=2481,d=3036,c=AUCT_CLAS_ARMOR},  -- Insignia Boots
	[4056]={b=0,s=0,d=811,c=AUCT_CLAS_QUEST},  -- Cortello's Riddle
	[4057]={b=20163,s=4032,d=16890,c=AUCT_CLAS_ARMOR},  -- Insignia Chestguard
	[4058]={b=30283,s=6056,d=14674,c=AUCT_CLAS_ARMOR},  -- Glyphed Breastplate
	[4059]={b=11169,s=2233,d=14673,c=AUCT_CLAS_ARMOR},  -- Glyphed Bracers
	[4060]={b=28244,s=5648,d=14675,c=AUCT_CLAS_ARMOR},  -- Glyphed Leggings
	[4061]={b=16531,s=3306,d=17008,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Bracers
	[4062]={b=41795,s=8359,d=17147,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Pants
	[4063]={b=17980,s=3596,d=17181,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Gloves
	[4064]={b=14938,s=2987,d=18487,c=AUCT_CLAS_WEAPON},  -- Emblazoned Buckler
	[4065]={b=26558,s=5311,d=18699,c=AUCT_CLAS_WEAPON},  -- Combat Shield
	[4066]={b=24227,s=4845,d=4403,c=AUCT_CLAS_WEAPON},  -- Insignia Buckler
	[4067]={b=31909,s=6381,d=6272,c=AUCT_CLAS_WEAPON},  -- Glyphed Buckler
	[4068]={b=34592,s=6918,d=26325,c=AUCT_CLAS_WEAPON},  -- Chief Brigadier Shield
	[4069]={b=59503,s=11900,d=26085,c=AUCT_CLAS_WEAPON},  -- Blackforge Buckler
	[4070]={b=37638,s=7527,d=18771,c=AUCT_CLAS_WEAPON},  -- Jouster's Crest
	[4071]={b=14695,s=2939,d=25801,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Breastplate
	[4072]={b=6704,s=1340,d=25802,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Gauntlets
	[4073]={b=11151,s=2230,d=25804,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Greaves
	[4074]={b=23928,s=4785,d=25809,c=AUCT_CLAS_ARMOR},  -- Mail Combat Armor
	[4075]={b=9924,s=1984,d=25811,c=AUCT_CLAS_ARMOR},  -- Mail Combat Gauntlets
	[4076]={b=16508,s=3301,d=25810,c=AUCT_CLAS_ARMOR},  -- Mail Combat Boots
	[4077]={b=16494,s=3298,d=25825,c=AUCT_CLAS_ARMOR},  -- Mail Combat Headguard
	[4078]={b=23364,s=4672,d=25904,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Coif
	[4079]={b=33766,s=6753,d=25896,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Leggings
	[4080]={b=37346,s=7469,d=15290,c=AUCT_CLAS_ARMOR},  -- Blackforge Cowl
	[4082]={b=58495,s=11699,d=26074,c=AUCT_CLAS_ARMOR},  -- Blackforge Breastplate
	[4083]={b=21644,s=4328,d=26075,c=AUCT_CLAS_ARMOR},  -- Blackforge Gauntlets
	[4084]={b=50681,s=10136,d=3409,c=AUCT_CLAS_ARMOR},  -- Blackforge Leggings
	[4085]={b=0,s=0,d=7155},  -- Krazek's Crock Pot
	[4086]={b=31934,s=6386,d=20736,c=AUCT_CLAS_WEAPON},  -- Flash Rifle
	[4087]={b=43611,s=8722,d=4426,c=AUCT_CLAS_WEAPON},  -- Trueshot Bow
	[4088]={b=92615,s=18523,d=28520,c=AUCT_CLAS_WEAPON},  -- Dreadblade
	[4089]={b=75302,s=15060,d=6592,c=AUCT_CLAS_WEAPON},  -- Ricochet Blunderbuss
	[4090]={b=103683,s=20736,d=18496,c=AUCT_CLAS_WEAPON},  -- Mug O' Hurt
	[4091]={b=112398,s=22479,d=20380,c=AUCT_CLAS_WEAPON},  -- Widowmaker
	[4092]={b=5185,s=1296,d=4433,x=5},  -- Prismatic Basilisk Scale
	[4093]={b=2855,s=713,d=6665,x=5},  -- Large Basilisk Tail
	[4094]={b=0,s=0,d=7264},  -- Tablet Shard
	[4096]={b=2435,s=608,d=18096,x=10,u=AUCT_TYPE_LEATHER},  -- Coarse Gorilla Hair
	[4097]={b=1220,s=305,d=6630,x=10},  -- Chipped Gorilla Tooth
	[4098]={b=0,s=0,d=4435,c=AUCT_CLAS_QUEST},  -- Carefully Folded Note
	[4099]={b=4525,s=1131,d=29087,x=5},  -- Tuft of Gorilla Hair
	[4100]={b=95,s=23,d=3093,x=10,c=AUCT_CLAS_WRITTEN},  -- Crumpled Note
	[4101]={b=105,s=26,d=3093,x=10,c=AUCT_CLAS_WRITTEN},  -- Ripped Note
	[4102]={b=135,s=33,d=3093,x=10,c=AUCT_CLAS_WRITTEN},  -- Torn Note
	[4103]={b=0,s=0,d=6708},  -- Shackle Key
	[4104]={b=0,s=0,d=6646,q=20,x=20},  -- Snapjaw Crocolisk Skin
	[4105]={b=0,s=0,d=6658,q=20,x=20},  -- Elder Crocolisk Skin
	[4106]={b=0,s=0,d=7279,q=20,x=20},  -- Tumbled Crystal
	[4107]={b=10682,s=2136,d=4438,c=AUCT_CLAS_ARMOR},  -- Tiger Hunter Gloves
	[4108]={b=27017,s=5403,d=4439,c=AUCT_CLAS_ARMOR},  -- Panther Hunter Leggings
	[4109]={b=21966,s=4393,d=16983,c=AUCT_CLAS_ARMOR},  -- Excelsior Boots
	[4110]={b=59995,s=11999,d=20555,c=AUCT_CLAS_WEAPON},  -- Master Hunter's Bow
	[4111]={b=60214,s=12042,d=8095,c=AUCT_CLAS_WEAPON},  -- Master Hunter's Rifle
	[4112]={b=16730,s=4182,d=9852,c=AUCT_CLAS_ARMOR},  -- Choker of the High Shaman
	[4113]={b=24265,s=4853,d=23123,c=AUCT_CLAS_ARMOR},  -- Medicine Blanket
	[4114]={b=29130,s=5826,d=15246,c=AUCT_CLAS_ARMOR},  -- Darktide Cape
	[4115]={b=28915,s=5783,d=17888,c=AUCT_CLAS_WEAPON},  -- Grom'gol Buckler
	[4116]={b=61686,s=12337,d=20223,c=AUCT_CLAS_WEAPON},  -- Olmann Sewar
	[4117]={b=15596,s=3119,d=16830,c=AUCT_CLAS_ARMOR},  -- Scorching Sash
	[4118]={b=36567,s=7313,d=6976,c=AUCT_CLAS_ARMOR},  -- Poobah's Nose Ring
	[4119]={b=36357,s=7271,d=17100,c=AUCT_CLAS_ARMOR},  -- Raptor Hunter Tunic
	[4120]={b=20963,s=4192,d=16695,c=AUCT_CLAS_ARMOR},  -- Robe of Crystal Waters
	[4121]={b=6902,s=1380,d=14323,c=AUCT_CLAS_ARMOR},  -- Gemmed Gloves
	[4122]={b=41922,s=8384,d=3498,c=AUCT_CLAS_WEAPON},  -- Bookmaker's Scepter
	[4123]={b=19022,s=3804,d=6919,c=AUCT_CLAS_ARMOR},  -- Frost Metal Pauldrons
	[4124]={b=19956,s=3991,d=21293,c=AUCT_CLAS_ARMOR},  -- Cap of Harmony
	[4125]={b=12570,s=3142,d=21605,c=AUCT_CLAS_WEAPON},  -- Tranquil Orb
	[4126]={b=31980,s=6396,d=19217,c=AUCT_CLAS_WEAPON},  -- Guerrilla Cleaver
	[4127]={b=40368,s=8073,d=20662,c=AUCT_CLAS_WEAPON},  -- Shrapnel Blaster
	[4128]={b=72939,s=14587,d=18269,c=AUCT_CLAS_WEAPON},  -- Silver Spade
	[4129]={b=47221,s=9444,d=4458,c=AUCT_CLAS_WEAPON},  -- Collection Plate
	[4130]={b=8685,s=2171,d=6562,c=AUCT_CLAS_ARMOR},  -- Smotts' Compass
	[4131]={b=19079,s=3815,d=17115,c=AUCT_CLAS_ARMOR},  -- Belt of Corruption
	[4132]={b=13408,s=2681,d=6884,c=AUCT_CLAS_ARMOR},  -- Darkspear Armsplints
	[4133]={b=8970,s=1794,d=4462,c=AUCT_CLAS_ARMOR},  -- Darkspear Cuffs
	[4134]={b=112477,s=22495,d=20294,c=AUCT_CLAS_WEAPON},  -- Nimboya's Mystical Staff
	[4135]={b=4520,s=1130,d=6486,c=AUCT_CLAS_ARMOR},  -- Bloodbone Band
	[4136]={b=30109,s=6021,d=6885,c=AUCT_CLAS_ARMOR},  -- Darkspear Boots
	[4137]={b=20053,s=4010,d=4835,c=AUCT_CLAS_ARMOR},  -- Darkspear Shoes
	[4138]={b=50704,s=10140,d=8638,c=AUCT_CLAS_ARMOR},  -- Blackwater Tunic
	[4139]={b=13745,s=2749,d=16822,c=AUCT_CLAS_ARMOR},  -- Junglewalker Sandals
	[4140]={b=9375,s=1875,d=4869,c=AUCT_CLAS_ARMOR},  -- Palm Frond Mantle
	[4197]={b=13828,s=2765,d=12980,c=AUCT_CLAS_ARMOR},  -- Berylline Pads
	[4213]={b=10000,s=2500,d=1246},  -- Grimoire of Doom
	[4231]={b=440,s=110,d=5086,x=10,c=AUCT_CLAS_HIDE,u=AUCT_TYPE_LEATHER},  -- Cured Light Hide
	[4232]={b=500,s=125,d=21463,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Medium Hide
	[4233]={b=800,s=200,d=7112,x=10,c=AUCT_CLAS_HIDE,u=AUCT_TYPE_LEATHER},  -- Cured Medium Hide
	[4234]={b=600,s=150,d=7410,x=10,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Heavy Leather
	[4235]={b=800,s=200,d=11164,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Heavy Hide
	[4236]={b=900,s=225,d=3164,x=10,c=AUCT_CLAS_HIDE,u=AUCT_TYPE_LEATHER},  -- Cured Heavy Hide
	[4237]={b=174,s=34,d=9501,c=AUCT_CLAS_ARMOR},  -- Handstitched Leather Belt
	[4238]={b=800,s=200,d=3410,c=AUCT_CLAS_CONTAINER},  -- Linen Bag
	[4239]={b=357,s=71,d=9503,c=AUCT_CLAS_ARMOR},  -- Embossed Leather Gloves
	[4240]={b=1200,s=300,d=4584,c=AUCT_CLAS_CONTAINER},  -- Woolen Bag
	[4241]={b=1800,s=450,d=8442,c=AUCT_CLAS_CONTAINER},  -- Green Woolen Bag
	[4242]={b=1739,s=347,d=9505,c=AUCT_CLAS_ARMOR},  -- Embossed Leather Pants
	[4243]={b=2308,s=461,d=9511,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_LEATHER},  -- Fine Leather Tunic
	[4244]={b=3618,s=723,d=18458,c=AUCT_CLAS_ARMOR},  -- Hillman's Leather Vest
	[4245]={b=8000,s=2000,d=3337,c=AUCT_CLAS_CONTAINER},  -- Small Silk Pack
	[4246]={b=625,s=125,d=9513,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_LEATHER},  -- Fine Leather Belt
	[4247]={b=5248,s=1049,d=2362,c=AUCT_CLAS_ARMOR},  -- Hillman's Leather Gloves
	[4248]={b=3958,s=791,d=9526,c=AUCT_CLAS_ARMOR},  -- Dark Leather Gloves
	[4249]={b=3515,s=703,d=12464,c=AUCT_CLAS_ARMOR},  -- Dark Leather Belt
	[4250]={b=3527,s=705,d=17237,c=AUCT_CLAS_ARMOR},  -- Hillman's Belt
	[4251]={b=5999,s=1199,d=11274,c=AUCT_CLAS_ARMOR},  -- Hillman's Shoulders
	[4252]={b=7286,s=1457,d=12403,c=AUCT_CLAS_ARMOR},  -- Dark Leather Shoulders
	[4253]={b=4810,s=962,d=27881,c=AUCT_CLAS_ARMOR},  -- Toughened Leather Gloves
	[4254]={b=5356,s=1071,d=9543,c=AUCT_CLAS_ARMOR},  -- Barbaric Gloves
	[4255]={b=11830,s=2366,d=9532,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_SMITH},  -- Green Leather Armor
	[4256]={b=17387,s=3477,d=9545,c=AUCT_CLAS_ARMOR},  -- Guardian Armor
	[4257]={b=6556,s=1311,d=17224,c=AUCT_CLAS_ARMOR},  -- Green Leather Belt
	[4258]={b=7963,s=1592,d=9538,c=AUCT_CLAS_ARMOR},  -- Guardian Belt
	[4259]={b=9672,s=1934,d=9546,c=AUCT_CLAS_ARMOR},  -- Green Leather Bracers
	[4260]={b=12796,s=2559,d=9550,c=AUCT_CLAS_ARMOR},  -- Guardian Leather Bracers
	[4261]={b=159,s=31,d=16794,c=AUCT_CLAS_ARMOR},  -- Solliden's Trousers
	[4262]={b=13260,s=2652,d=17218,c=AUCT_CLAS_ARMOR},  -- Gem-studded Leather Belt
	[4263]={b=470,s=94,d=18668,c=AUCT_CLAS_WEAPON},  -- Standard Issue Shield
	[4264]={b=14022,s=2804,d=17111,c=AUCT_CLAS_ARMOR},  -- Barbaric Belt
	[4265]={b=2600,s=650,d=7452,x=10},  -- Heavy Armor Kit
	[4278]={b=100,s=25,d=7148,x=20},  -- Lesser Bloodstone Ore
	[4289]={b=50,s=12,d=6396,x=20,u=AUCT_TYPE_LEATHER},  -- Salt
	[4290]={b=3576,s=715,d=4400,c=AUCT_CLAS_WEAPON},  -- Dust Bowl
	[4291]={b=500,s=125,d=12105,x=20,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Silken Thread
	[4292]={b=800,s=200,d=1102},  -- Pattern: Green Woolen Bag
	[4293]={b=650,s=162,d=1102},  -- Pattern: Hillman's Leather Vest
	[4294]={b=1600,s=400,d=1102},  -- Pattern: Hillman's Belt
	[4296]={b=2100,s=525,d=15274},  -- Pattern: Dark Leather Shoulders
	[4297]={b=2000,s=500,d=15274},  -- Pattern: Barbaric Gloves
	[4298]={b=650,s=162,d=1102},  -- Pattern: Guardian Belt
	[4299]={b=2000,s=500,d=1102},  -- Pattern: Guardian Armor
	[4300]={b=2800,s=700,d=1102},  -- Pattern: Guardian Leather Bracers
	[4301]={b=3500,s=875,d=1102},  -- Pattern: Barbaric Belt
	[4302]={b=732,s=146,d=3006,c=AUCT_CLAS_WEAPON},  -- Small Green Dagger
	[4303]={b=1991,s=398,d=19615,c=AUCT_CLAS_WEAPON},  -- Cranial Thumper
	[4304]={b=1200,s=300,d=8711,x=10,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Thick Leather
	[4305]={b=2400,s=600,d=7333,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Bolt of Silk Cloth
	[4306]={b=600,s=150,d=7717,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_FSTAID..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Silk Cloth
	[4307]={b=149,s=29,d=6295,c=AUCT_CLAS_ARMOR},  -- Heavy Linen Gloves
	[4308]={b=225,s=45,d=8089,c=AUCT_CLAS_ARMOR},  -- Green Linen Bracers
	[4309]={b=1133,s=226,d=12395,c=AUCT_CLAS_ARMOR},  -- Handstitched Linen Britches
	[4310]={b=902,s=180,d=12865,c=AUCT_CLAS_ARMOR},  -- Heavy Woolen Gloves
	[4311]={b=2378,s=475,d=23117,c=AUCT_CLAS_ARMOR},  -- Heavy Woolen Cloak
	[4312]={b=1186,s=237,d=14403,c=AUCT_CLAS_ARMOR},  -- Soft-soled Linen Boots
	[4313]={b=2083,s=416,d=4615,c=AUCT_CLAS_ARMOR},  -- Red Woolen Boots
	[4314]={b=1659,s=331,d=9997,c=AUCT_CLAS_ARMOR},  -- Double-stitched Woolen Shoulders
	[4315]={b=2126,s=425,d=17135,c=AUCT_CLAS_ARMOR},  -- Reinforced Woolen Shoulders
	[4316]={b=3715,s=743,d=6297,c=AUCT_CLAS_ARMOR},  -- Heavy Woolen Pants
	[4317]={b=5382,s=1076,d=12399,c=AUCT_CLAS_ARMOR},  -- Phoenix Pants
	[4318]={b=3052,s=610,d=6291,c=AUCT_CLAS_ARMOR},  -- Gloves of Meditation
	[4319]={b=4076,s=815,d=17130,c=AUCT_CLAS_ARMOR},  -- Azure Silk Gloves
	[4320]={b=4897,s=979,d=4301,c=AUCT_CLAS_ARMOR},  -- Spidersilk Boots
	[4321]={b=5600,s=1120,d=17138,c=AUCT_CLAS_ARMOR},  -- Spider Silk Slippers
	[4322]={b=9053,s=1810,d=15314,c=AUCT_CLAS_ARMOR},  -- Enchanter's Cowl
	[4323]={b=9995,s=1999,d=15319,c=AUCT_CLAS_ARMOR},  -- Shadow Hood
	[4324]={b=9373,s=1874,d=17128,c=AUCT_CLAS_ARMOR},  -- Azure Silk Vest
	[4325]={b=11362,s=2272,d=4631,c=AUCT_CLAS_ARMOR},  -- Boots of the Enchanter
	[4326]={b=12482,s=2496,d=15076,c=AUCT_CLAS_ARMOR},  -- Long Silken Cloak
	[4327]={b=18941,s=3788,d=15273,c=AUCT_CLAS_ARMOR},  -- Icy Cloak
	[4328]={b=7623,s=1524,d=17136,c=AUCT_CLAS_ARMOR},  -- Spider Belt
	[4329]={b=10603,s=2120,d=6315,c=AUCT_CLAS_ARMOR},  -- Star Belt
	[4330]={b=1000,s=250,d=7906,c=AUCT_CLAS_ARMOR},  -- Stylish Red Shirt
	[4331]={b=2630,s=526,d=13195,c=AUCT_CLAS_ARMOR},  -- Phoenix Gloves
	[4332]={b=2000,s=500,d=7902,c=AUCT_CLAS_ARMOR},  -- Bright Yellow Shirt
	[4333]={b=4800,s=1200,d=15858,c=AUCT_CLAS_ARMOR},  -- Dark Silk Shirt
	[4334]={b=2200,s=550,d=7903,c=AUCT_CLAS_ARMOR},  -- Formal White Shirt
	[4335]={b=6000,s=1500,d=7904,c=AUCT_CLAS_ARMOR},  -- Rich Purple Silk Shirt
	[4336]={b=6000,s=1500,d=13055,c=AUCT_CLAS_ARMOR},  -- Black Swashbuckler's Shirt
	[4337]={b=3000,s=750,d=18597,x=10,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Thick Spider's Silk
	[4338]={b=1000,s=250,d=7384,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_FSTAID..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Mageweave Cloth
	[4339]={b=5000,s=1250,d=7332,x=10,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_TAILOR},  -- Bolt of Mageweave
	[4340]={b=350,s=87,d=18079,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Gray Dye
	[4341]={b=500,s=125,d=6373,x=10,u=AUCT_TYPE_TAILOR},  -- Yellow Dye
	[4342]={b=2500,s=625,d=6389,x=10,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_TAILOR},  -- Purple Dye
	[4343]={b=301,s=60,d=12388,c=AUCT_CLAS_ARMOR},  -- Brown Linen Pants
	[4344]={b=58,s=11,d=12802,c=AUCT_CLAS_ARMOR},  -- Brown Linen Shirt
	[4345]={b=400,s=100,d=15274},  -- Pattern: Red Woolen Boots
	[4346]={b=400,s=100,d=15274},  -- Pattern: Heavy Woolen Cloak
	[4347]={b=600,s=150,d=15274},  -- Pattern: Reinforced Woolen Shoulders
	[4348]={b=700,s=175,d=15274},  -- Pattern: Phoenix Gloves
	[4349]={b=700,s=175,d=15274},  -- Pattern: Phoenix Pants
	[4350]={b=800,s=200,d=15274},  -- Pattern: Spider Silk Slippers
	[4351]={b=900,s=225,d=15274},  -- Pattern: Shadow Hood
	[4352]={b=1100,s=275,d=15274},  -- Pattern: Boots of the Enchanter
	[4353]={b=1200,s=300,d=15274},  -- Pattern: Spider Belt
	[4354]={b=1400,s=350,d=6270},  -- Pattern: Rich Purple Silk Shirt
	[4355]={b=1500,s=375,d=1102},  -- Pattern: Icy Cloak
	[4356]={b=1500,s=375,d=15274},  -- Pattern: Star Belt
	[4357]={b=16,s=4,d=7137,x=20,u=AUCT_TYPE_ENGINEER},  -- Rough Blasting Powder
	[4358]={b=120,s=30,d=18062,x=20},  -- Rough Dynamite
	[4359]={b=50,s=12,d=10700,x=10,u=AUCT_TYPE_ENGINEER},  -- Handful of Copper Bolts
	[4360]={b=240,s=60,d=25483,x=10},  -- Rough Copper Bomb
	[4361]={b=480,s=120,d=18174,x=10,u=AUCT_TYPE_ENGINEER},  -- Copper Tube
	[4362]={b=938,s=187,d=6600,c=AUCT_CLAS_WEAPON},  -- Rough Boomstick
	[4363]={b=200,s=50,d=7839,x=10,u=AUCT_TYPE_ENGINEER},  -- Copper Modulator
	[4364]={b=48,s=12,d=6396,x=20,u=AUCT_TYPE_ENGINEER},  -- Coarse Blasting Powder
	[4365]={b=300,s=75,d=18062,x=20},  -- Coarse Dynamite
	[4366]={b=300,s=75,d=26633,x=10},  -- Target Dummy
	[4367]={b=600,s=150,d=6393,x=10},  -- Small Seaforium Charge
	[4368]={b=2043,s=408,d=13236,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_ENGINEER},  -- Flying Tiger Goggles
	[4369]={b=5899,s=1179,d=20743,c=AUCT_CLAS_WEAPON},  -- Deadly Blunderbuss
	[4370]={b=700,s=175,d=7624,x=10},  -- Large Copper Bomb
	[4371]={b=800,s=200,d=19482,x=10,u=AUCT_TYPE_ENGINEER},  -- Bronze Tube
	[4372]={b=9000,s=1800,d=6594,c=AUCT_CLAS_WEAPON},  -- Lovingly Crafted Boomstick
	[4373]={b=3613,s=722,d=26619,c=AUCT_CLAS_ARMOR},  -- Shadow Goggles
	[4374]={b=800,s=200,d=25483,x=10},  -- Small Bronze Bomb
	[4375]={b=460,s=115,d=7840,x=10,u=AUCT_TYPE_ENGINEER},  -- Whirring Bronze Gizmo
	[4376]={b=800,s=200,d=7841},  -- Flame Deflector
	[4377]={b=600,s=150,d=31325,x=20,u=AUCT_TYPE_ENGINEER},  -- Heavy Blasting Powder
	[4378]={b=1400,s=350,d=18062,x=20},  -- Heavy Dynamite
	[4379]={b=11788,s=2357,d=15835,c=AUCT_CLAS_WEAPON},  -- Silver-plated Shotgun
	[4380]={b=2000,s=500,d=7626,x=10},  -- Big Bronze Bomb
	[4381]={b=2400,s=600,d=22293,c=AUCT_CLAS_ARMOR},  -- Minor Recombobulator
	[4382]={b=2400,s=600,d=20624,x=10,u=AUCT_TYPE_ENGINEER},  -- Bronze Framework
	[4383]={b=15915,s=3183,d=8257,c=AUCT_CLAS_WEAPON},  -- Moonsight Rifle
	[4384]={b=4000,s=1000,d=7361,x=5},  -- Explosive Sheep
	[4385]={b=7052,s=1410,d=22422,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_ENGINEER},  -- Green Tinted Goggles
	[4386]={b=700,s=175,d=7841},  -- Ice Deflector
	[4387]={b=1600,s=400,d=7377,x=10,u=AUCT_TYPE_ENGINEER},  -- Iron Strut
	[4388]={b=4000,s=1000,d=7358},  -- Discombobulator Ray
	[4389]={b=3000,s=750,d=7371,x=10,u=AUCT_TYPE_ENGINEER},  -- Gyrochronatom
	[4390]={b=2000,s=500,d=25482,x=10},  -- Iron Grenade
	[4391]={b=16000,s=4000,d=21652,x=5},  -- Compact Harvest Reaper Kit
	[4392]={b=10000,s=2500,d=26632,x=10},  -- Advanced Target Dummy
	[4393]={b=13162,s=2632,d=13215,c=AUCT_CLAS_ARMOR},  -- Craftsman's Monocle
	[4394]={b=3000,s=750,d=7624,x=10},  -- Big Iron Bomb
	[4395]={b=6400,s=1600,d=7367,x=10},  -- Goblin Land Mine
	[4396]={b=24000,s=6000,d=21632,c=AUCT_CLAS_ARMOR},  -- Mechanical Dragonling
	[4397]={b=20000,s=5000,d=7841,c=AUCT_CLAS_ARMOR},  -- Gnomish Cloaking Device
	[4398]={b=3600,s=900,d=6393,x=10},  -- Large Seaforium Charge
	[4399]={b=200,s=50,d=7375,x=10,u=AUCT_TYPE_ENGINEER},  -- Wooden Stock
	[4400]={b=2000,s=500,d=7375,x=10,u=AUCT_TYPE_ENGINEER},  -- Heavy Stock
	[4401]={b=400,s=100,d=16536},  -- Mechanical Squirrel Box
	[4402]={b=1000,s=250,d=1438,x=5,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_COOK..", "..AUCT_TYPE_ENGINEER},  -- Small Flame Sac
	[4403]={b=8000,s=2000,d=7397},  -- Portable Bronze Mortar
	[4404]={b=100,s=25,d=7404,x=20,u=AUCT_TYPE_ENGINEER},  -- Silver Contact
	[4405]={b=500,s=125,d=7326,x=5},  -- Crude Scope
	[4406]={b=2400,s=600,d=7326,x=5},  -- Standard Scope
	[4407]={b=4800,s=1200,d=7326,x=5,u=AUCT_TYPE_ENGINEER},  -- Accurate Scope
	[4408]={b=650,s=162,d=15274},  -- Schematic: Mechanical Squirrel
	[4409]={b=800,s=200,d=15274},  -- Schematic: Small Seaforium Charge
	[4410]={b=1000,s=250,d=15274},  -- Schematic: Shadow Goggles
	[4411]={b=1100,s=275,d=1102},  -- Schematic: Flame Deflector
	[4412]={b=1500,s=375,d=15274},  -- Schematic: Moonsight Rifle
	[4413]={b=1800,s=450,d=15274},  -- Schematic: Discombobulator Ray
	[4414]={b=1850,s=462,d=15274},  -- Schematic: Portable Bronze Mortar
	[4415]={b=2200,s=550,d=1102},  -- Schematic: Craftsman's Monocle
	[4416]={b=2400,s=600,d=15274},  -- Schematic: Goblin Land Mine
	[4417]={b=2700,s=675,d=15274},  -- Schematic: Large Seaforium Charge
	[4419]={b=450,s=112,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Intellect III
	[4421]={b=400,s=100,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Protection III
	[4422]={b=450,s=112,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Stamina III
	[4424]={b=400,s=100,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Spirit III
	[4425]={b=500,s=125,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Agility III
	[4426]={b=500,s=125,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Strength III
	[4428]={b=1325,s=331,d=6699,x=5},  -- Spider Palp
	[4429]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Deepfury's Orders
	[4430]={b=17230,s=4307,d=9853,c=AUCT_CLAS_ARMOR},  -- Ethereal Talisman
	[4432]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Sully Balloo's Letter
	[4433]={b=0,s=0,d=4435,c=AUCT_CLAS_QUEST},  -- Waterlogged Envelope
	[4434]={b=2861,s=572,d=4365,c=AUCT_CLAS_ARMOR},  -- Scarecrow Trousers
	[4435]={b=0,s=0,d=6614,q=20,x=20},  -- Mote of Myzrael
	[4436]={b=1657,s=331,d=9912,c=AUCT_CLAS_ARMOR},  -- Jewel-encrusted Sash
	[4437]={b=9278,s=1855,d=20390,c=AUCT_CLAS_WEAPON},  -- Channeler's Staff
	[4438]={b=8464,s=1692,d=6977,c=AUCT_CLAS_ARMOR},  -- Pugilist Bracers
	[4439]={b=8944,s=1788,d=6795,c=AUCT_CLAS_WEAPON},  -- Bruiser Club
	[4440]={b=0,s=0,d=7246},  -- Sigil of Strom
	[4441]={b=0,s=0,d=18078},  -- MacKreel's Moonshine
	[4443]={b=17360,s=3472,d=11327,c=AUCT_CLAS_ARMOR},  -- Grim Pauldrons
	[4444]={b=7450,s=1490,d=18694,c=AUCT_CLAS_WEAPON},  -- Black Husk Shield
	[4445]={b=10341,s=2068,d=19398,c=AUCT_CLAS_WEAPON},  -- Flesh Carver
	[4446]={b=17972,s=3594,d=20369,c=AUCT_CLAS_WEAPON},  -- Blackvenom Blade
	[4447]={b=4509,s=901,d=23019,c=AUCT_CLAS_ARMOR},  -- Cloak of Night
	[4448]={b=9959,s=1991,d=4723,c=AUCT_CLAS_ARMOR},  -- Husk of Naraxis
	[4449]={b=16662,s=3332,d=20439,c=AUCT_CLAS_WEAPON},  -- Naraxis' Fang
	[4450]={b=0,s=0,d=7184,q=20,x=20},  -- Sigil Fragment
	[4453]={b=0,s=0,d=7248},  -- Sigil of Thoradin
	[4454]={b=19001,s=3800,d=20592,c=AUCT_CLAS_WEAPON},  -- Talon of Vultros
	[4455]={b=15483,s=3096,d=14261,c=AUCT_CLAS_ARMOR},  -- Raptor Hide Harness
	[4456]={b=7768,s=1553,d=17231,c=AUCT_CLAS_ARMOR},  -- Raptor Hide Belt
	[4457]={b=1200,s=300,d=6327,x=20,u=AUCT_TYPE_COOK},  -- Barbecued Buzzard Wing
	[4458]={b=0,s=0,d=7245},  -- Sigil of Arathor
	[4459]={b=600,s=150,d=18072,x=10},  -- Brittle Dragon Bone
	[4460]={b=700,s=175,d=568,x=10},  -- Ripped Wing Webbing
	[4461]={b=835,s=208,d=7399,x=10,u=AUCT_TYPE_LEATHER},  -- Raptor Hide
	[4462]={b=7126,s=1425,d=23098,c=AUCT_CLAS_ARMOR},  -- Cloak of Rot
	[4463]={b=4769,s=953,d=9916,c=AUCT_CLAS_ARMOR},  -- Beaded Raptor Collar
	[4464]={b=11901,s=2380,d=7002,c=AUCT_CLAS_ARMOR},  -- Trouncing Boots
	[4465]={b=7928,s=1585,d=6844,c=AUCT_CLAS_ARMOR},  -- Bonefist Gauntlets
	[4466]={b=0,s=0,d=7249},  -- Sigil of Trollbane
	[4467]={b=0,s=0,d=7244},  -- Sigil of Ignaeus
	[4468]={b=0,s=0,d=7239},  -- Sheathed Trol'kalar
	[4469]={b=0,s=0,d=7216},  -- Rod of Order
	[4470]={b=38,s=9,d=21102,x=20,u=AUCT_TYPE_ENCHANT},  -- Simple Wood
	[4471]={b=135,s=33,d=4720},  -- Flint and Tinder
	[4472]={b=0,s=0,d=2616},  -- Scroll of Myzrael
	[4473]={b=0,s=0,d=7118},  -- Eldritch Shackles
	[4474]={b=21037,s=4207,d=12883,c=AUCT_CLAS_WEAPON},  -- Ravenwood Bow
	[4476]={b=13672,s=2734,d=12650,c=AUCT_CLAS_ARMOR},  -- Beastwalker Robe
	[4477]={b=21953,s=4390,d=17887,c=AUCT_CLAS_WEAPON},  -- Nefarious Buckler
	[4478]={b=50883,s=10176,d=4744,c=AUCT_CLAS_ARMOR},  -- Iridescent Scale Leggings
	[4479]={b=715,s=178,d=6337,x=10},  -- Burning Charm
	[4480]={b=740,s=185,d=6424,x=10},  -- Thundering Charm
	[4481]={b=705,s=176,d=6346,x=10},  -- Cresting Charm
	[4482]={b=0,s=0,d=7234},  -- Sealed Folder
	[4483]={b=0,s=0,d=6709},  -- Burning Key
	[4484]={b=0,s=0,d=6712},  -- Cresting Key
	[4485]={b=0,s=0,d=6711},  -- Thundering Key
	[4487]={b=0,s=0,d=7047},  -- Maiden's Folly Charts
	[4488]={b=0,s=0,d=7047},  -- Spirit of Silverpine Charts
	[4489]={b=0,s=0,d=7152},  -- Maiden's Folly Log
	[4490]={b=0,s=0,d=3426},  -- Spirit of Silverpine Log
	[4491]={b=0,s=0,d=12289,c=AUCT_CLAS_ARMOR},  -- Goggles of Gem Hunting
	[4492]={b=0,s=0,d=7119,q=20,x=20},  -- Elven Gem
	[4493]={b=0,s=0,d=7120},  -- Elven Gems
	[4494]={b=0,s=0,d=7233},  -- Seahorn's Sealed Letter
	[4495]={b=0,s=0,d=9658,q=20,x=20},  -- Bloodstone Amulet
	[4496]={b=500,s=125,d=8271,c=AUCT_CLAS_CONTAINER},  -- Small Brown Pouch
	[4497]={b=20000,s=5000,d=1183,c=AUCT_CLAS_CONTAINER},  -- Heavy Brown Bag
	[4498]={b=2500,s=625,d=2585,c=AUCT_CLAS_CONTAINER},  -- Brown Leather Satchel
	[4499]={b=100000,s=25000,d=1183,c=AUCT_CLAS_CONTAINER},  -- Huge Brown Sack
	[4500]={b=35000,s=8750,d=6430,c=AUCT_CLAS_CONTAINER},  -- Traveler's Backpack
	[4502]={b=0,s=0,d=7221},  -- Sample Elven Gem
	[4503]={b=0,s=0,d=3429,q=20,x=20},  -- Witherbark Tusk
	[4504]={b=11112,s=2222,d=15183,c=AUCT_CLAS_ARMOR},  -- Dwarven Guard Cloak
	[4505]={b=9870,s=1974,d=16791,c=AUCT_CLAS_ARMOR},  -- Swampland Trousers
	[4506]={b=0,s=0,d=6510,q=20,x=20},  -- Stromgarde Badge
	[4507]={b=41411,s=8282,d=18653,c=AUCT_CLAS_WEAPON},  -- Pit Fighter's Shield
	[4508]={b=38965,s=7793,d=8639,c=AUCT_CLAS_ARMOR},  -- Blood-tinged Armor
	[4509]={b=13970,s=2794,d=17185,c=AUCT_CLAS_ARMOR},  -- Seawolf Gloves
	[4510]={b=0,s=0,d=7041},  -- Befouled Bloodstone Orb
	[4511]={b=56284,s=11256,d=19783,c=AUCT_CLAS_WEAPON},  -- Black Water Hammer
	[4512]={b=0,s=0,d=1504,q=20,x=20},  -- Highland Raptor Eye
	[4513]={b=0,s=0,d=6693,q=20,x=20},  -- Raptor Heart
	[4514]={b=0,s=0,d=4771,c=AUCT_CLAS_WRITTEN},  -- Sara Balloo's Plea
	[4515]={b=0,s=0,d=1310},  -- Marez's Head
	[4516]={b=0,s=0,d=7038},  -- Otto's Head
	[4517]={b=0,s=0,d=7038},  -- Falconcrest's Head
	[4518]={b=0,s=0,d=2616},  -- Torn Scroll Fragment
	[4519]={b=0,s=0,d=2616},  -- Crumpled Scroll Fragment
	[4520]={b=0,s=0,d=2616},  -- Singed Scroll Fragment
	[4521]={b=0,s=0,d=7024,q=20,x=20},  -- Alterac Granite
	[4522]={b=0,s=0,d=7289,q=20,x=20},  -- Witherbark Medicine Pouch
	[4525]={b=0,s=0,d=7278},  -- Trelane's Wand of Invocation
	[4526]={b=0,s=0,d=7202},  -- Raptor Talon Amulet
	[4527]={b=0,s=0,d=1659},  -- Azure Agate
	[4528]={b=0,s=0,d=7261},  -- Tor'gan's Orb
	[4529]={b=0,s=0,d=4775},  -- Enchanted Agate
	[4530]={b=0,s=0,d=7277},  -- Trelane's Phylactery
	[4531]={b=0,s=0,d=6564},  -- Trelane's Orb
	[4532]={b=0,s=0,d=4777},  -- Trelane's Ember Agate
	[4533]={b=0,s=0,d=4435},  -- Sealed Letter to Archmage Malin
	[4534]={b=5868,s=1173,d=6996,c=AUCT_CLAS_ARMOR},  -- Steel-clasped Bracers
	[4535]={b=3530,s=882,d=9838,c=AUCT_CLAS_ARMOR},  -- Ironforge Memorial Ring
	[4536]={b=25,s=1,d=6410,q=20,x=20,u=AUCT_TYPE_COOK},  -- Shiny Red Apple
	[4537]={b=125,s=6,d=6420,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Tel'Abim Banana
	[4538]={b=500,s=25,d=4781,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Snapvine Watermelon
	[4539]={b=1000,s=50,d=7856,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Goldenbark Apple
	[4540]={b=25,s=1,d=6399,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Tough Hunk of Bread
	[4541]={b=125,s=6,d=6343,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Freshly Baked Bread
	[4542]={b=500,s=25,d=6344,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Moist Cornbread
	[4543]={b=20494,s=4098,d=21313,c=AUCT_CLAS_ARMOR},  -- White Drakeskin Cap
	[4544]={b=1000,s=50,d=6399,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Mulgore Spice Bread
	[4545]={b=11010,s=2202,d=16892,c=AUCT_CLAS_ARMOR},  -- Radiant Silver Bracers
	[4546]={b=2135,s=533,d=6338},  -- Call of the Raptor
	[4547]={b=41596,s=8319,d=21016,c=AUCT_CLAS_WEAPON},  -- Gnomish Zapper
	[4548]={b=75143,s=15028,d=3151,c=AUCT_CLAS_WEAPON},  -- Servomechanic Sledgehammer
	[4549]={b=8370,s=2092,d=9834,c=AUCT_CLAS_ARMOR},  -- Seafire Band
	[4550]={b=8370,s=2092,d=9832,c=AUCT_CLAS_ARMOR},  -- Coldwater Ring
	[4551]={b=0,s=0,d=3918},  -- Or'Kalar's Head
	[4552]={b=2120,s=530,d=4719,x=10},  -- Smooth Stone Chip
	[4553]={b=1645,s=411,d=4722,x=5},  -- Jagged Piece of Stone
	[4554]={b=2835,s=708,d=4721,x=5},  -- Shiny Polished Stone
	[4555]={b=620,s=155,d=20915,x=5},  -- Thick Scaly Tail
	[4556]={b=3615,s=903,d=20914,x=5},  -- Speckled Shell Fragment
	[4557]={b=900,s=225,d=28258,x=10},  -- Fiery Gland
	[4558]={b=6260,s=1565,d=8381},  -- Empty Barrel
	[4560]={b=185,s=37,d=4788,c=AUCT_CLAS_WEAPON},  -- Fine Scimitar
	[4561]={b=1546,s=309,d=19299,c=AUCT_CLAS_WEAPON},  -- Scalping Tomahawk
	[4562]={b=1491,s=298,d=8531,c=AUCT_CLAS_WEAPON},  -- Severing Axe
	[4563]={b=552,s=110,d=4609,c=AUCT_CLAS_WEAPON},  -- Billy Club
	[4564]={b=3053,s=610,d=6813,c=AUCT_CLAS_WEAPON},  -- Spiked Club
	[4565]={b=193,s=38,d=6433,c=AUCT_CLAS_WEAPON},  -- Simple Dagger
	[4566]={b=3157,s=631,d=20420,c=AUCT_CLAS_WEAPON},  -- Sturdy Quarterstaff
	[4567]={b=5247,s=1049,d=20111,c=AUCT_CLAS_WEAPON},  -- Merc Sword
	[4568]={b=8474,s=1694,d=22478,c=AUCT_CLAS_WEAPON},  -- Grunt Axe
	[4569]={b=3063,s=612,d=19778,c=AUCT_CLAS_WEAPON},  -- Staunch Hammer
	[4570]={b=4611,s=922,d=8586,c=AUCT_CLAS_WEAPON},  -- Birchwood Maul
	[4571]={b=4896,s=979,d=20430,c=AUCT_CLAS_WEAPON},  -- War Knife
	[4575]={b=7435,s=1487,d=20401,c=AUCT_CLAS_WEAPON},  -- Medicine Staff
	[4576]={b=5922,s=1184,d=20674,c=AUCT_CLAS_WEAPON},  -- Light Bow
	[4577]={b=1784,s=356,d=6592,c=AUCT_CLAS_WEAPON},  -- Compact Shotgun
	[4580]={b=3150,s=787,d=959,x=10},  -- Sabertooth Fang
	[4581]={b=3450,s=862,d=6679,x=5},  -- Patch of Fine Fur
	[4582]={b=2980,s=745,d=18095,x=5},  -- Soft Bushy Tail
	[4583]={b=3250,s=812,d=6698,x=5},  -- Thick Furry Mane
	[4584]={b=3750,s=937,d=6669,x=5},  -- Large Trophy Paw
	[4585]={b=2335,s=583,d=6619,x=5},  -- Dripping Spider Mandible
	[4586]={b=2855,s=713,d=6628,x=5},  -- Smooth Raptor Skin
	[4587]={b=3230,s=807,d=11208,x=10},  -- Tribal Raptor Feathers
	[4588]={b=3600,s=900,d=4807,x=5},  -- Pristine Raptor Skull
	[4589]={b=2120,s=530,d=11207,x=10,u=AUCT_TYPE_TAILOR},  -- Long Elegant Feather
	[4590]={b=2620,s=655,d=6636,x=5},  -- Curved Yellow Bill
	[4591]={b=1655,s=413,d=6492,x=5},  -- Eagle Eye
	[4592]={b=20,s=1,d=24702,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Longjaw Mud Snapper
	[4593]={b=500,s=4,d=24710,q=20,x=20},  -- Bristle Whisker Catfish
	[4594]={b=1000,s=6,d=4823,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Rockscale Cod
	[4595]={b=300,s=75,d=18078,x=10},  -- Junglevine Wine
	[4596]={b=100,s=25,d=15736,x=5,c=AUCT_CLAS_POTION},  -- Discolored Healing Potion
	[4597]={b=1000,s=250,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Discolored Healing Potion
	[4598]={b=850,s=212,d=18063,x=10,c=AUCT_CLAS_FISHING},  -- Goblin Fishing Pole
	[4599]={b=2000,s=100,d=6350,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Cured Ham Steak
	[4600]={b=340,s=85,d=18119,x=20,c=AUCT_CLAS_DRINK},  -- Cherry Grog
	[4601]={b=2000,s=100,d=6413,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Soft Banana Bread
	[4602]={b=2000,s=100,d=6402,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Moon Harvest Pumpkin
	[4603]={b=80,s=4,d=4811,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Spotted Yellowtail
	[4604]={b=25,s=1,d=15852,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Forest Mushroom Cap
	[4605]={b=125,s=6,d=15853,q=20,x=20},  -- Red-speckled Mushroom
	[4606]={b=500,s=25,d=15854,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Spongy Morel
	[4607]={b=1000,s=50,d=6355,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Delicious Cave Mold
	[4608]={b=2000,s=100,d=15855,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Raw Black Truffle
	[4609]={b=1000,s=250,d=1301,u=AUCT_TYPE_COOK},  -- Recipe: Barbecued Buzzard Wing
	[4610]={b=0,s=0,d=6393,q=20,x=20},  -- Carved Stone Urn
	[4611]={b=200,s=50,d=13103,x=20,c=AUCT_CLAS_GEM},  -- Blue Pearl
	[4612]={b=0,s=0,d=4826,q=20,x=20},  -- Black Drake's Heart
	[4613]={b=0,s=0,d=20913,c=AUCT_CLAS_QUEST},  -- Corroded Black Box
	[4614]={b=0,s=0,d=9859,c=AUCT_CLAS_QUEST},  -- Pendant of Myzrael
	[4615]={b=0,s=0,d=4829},  -- Blacklash's Bindings
	[4616]={b=17,s=3,d=6589,c=AUCT_CLAS_WEAPON},  -- Ryedol's Lucky Pick
	[4621]={b=0,s=0,d=7025},  -- Ambassador Infernus' Bracer
	[4622]={b=0,s=0,d=4435},  -- Sealed Note to Advisor Belgrum
	[4623]={b=1500,s=375,d=24215,x=5,c=AUCT_CLAS_POTION},  -- Lesser Stoneshield Potion
	[4624]={b=2200,s=550,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Lesser Stoneshield Potion
	[4625]={b=1000,s=250,d=19495,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Firebloom
	[4626]={b=0,s=0,d=4717,q=20,x=20},  -- Small Stone Shard
	[4627]={b=0,s=0,d=7157,q=5,x=5},  -- Large Stone Slab
	[4628]={b=0,s=0,d=7060,q=20,x=20},  -- Bracers of Rock Binding
	[4629]={b=0,s=0,d=7925,q=20,x=20},  -- Supply Crate
	[4630]={b=0,s=0,d=7064,q=20,x=20},  -- Scrap Metal
	[4631]={b=0,s=0,d=7264},  -- Tablet of Ryun'eh
	[4632]={b=200,s=50,d=9632},  -- Ornate Bronze Lockbox
	[4633]={b=280,s=70,d=9632},  -- Heavy Bronze Lockbox
	[4634]={b=350,s=87,d=9632},  -- Iron Lockbox
	[4635]={b=0,s=0,d=4841},  -- Hammertoe's Amulet
	[4636]={b=440,s=110,d=9632},  -- Strong Iron Lockbox
	[4637]={b=600,s=150,d=9632},  -- Steel Lockbox
	[4638]={b=800,s=200,d=9632},  -- Reinforced Steel Lockbox
	[4639]={b=650,s=162,d=7078},  -- Enchanted Sea Kelp
	[4640]={b=0,s=0,d=4681},  -- Sign of the Earth
	[4641]={b=0,s=0,d=3146},  -- Hand of Dagun
	[4643]={b=13741,s=2748,d=15079,c=AUCT_CLAS_ARMOR},  -- Grimsteel Cape
	[4644]={b=0,s=0,d=7269},  -- The Legacy Heart
	[4645]={b=0,s=0,d=4829},  -- Chains of Hematus
	[4646]={b=0,s=0,d=2516},  -- Star of Xil'yeh
	[4647]={b=0,s=0,d=7293},  -- Yagyin's Digest
	[4648]={b=0,s=0,d=7247},  -- Sigil of the Hammer
	[4649]={b=0,s=0,d=811,c=AUCT_CLAS_WRITTEN},  -- Bonegrip's Note
	[4650]={b=0,s=0,d=811,c=AUCT_CLAS_WRITTEN},  -- Bel'dugur's Note
	[4652]={b=50631,s=10126,d=18789,c=AUCT_CLAS_WEAPON},  -- Salbac Shield
	[4653]={b=35890,s=7178,d=6944,c=AUCT_CLAS_ARMOR},  -- Ironheel Boots
	[4654]={b=0,s=0,d=7177},  -- Mysterious Fossil
	[4655]={b=285,s=71,d=22193,x=10,u=AUCT_TYPE_COOK},  -- Giant Clam Meat
	[4656]={b=25,s=1,d=6402,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Small Pumpkin
	[4658]={b=118,s=23,d=25945,c=AUCT_CLAS_ARMOR},  -- Warrior's Cloak
	[4659]={b=119,s=23,d=11131,c=AUCT_CLAS_ARMOR},  -- Warrior's Girdle
	[4660]={b=1622,s=324,d=6322,c=AUCT_CLAS_ARMOR},  -- Walking Boots
	[4661]={b=4645,s=929,d=27551,c=AUCT_CLAS_ARMOR},  -- Bright Mantle
	[4662]={b=123,s=24,d=15061,c=AUCT_CLAS_ARMOR},  -- Journeyman's Cloak
	[4663]={b=115,s=23,d=9907,c=AUCT_CLAS_ARMOR},  -- Journeyman's Belt
	[4665]={b=113,s=22,d=23015,c=AUCT_CLAS_ARMOR},  -- Burnt Cloak
	[4666]={b=132,s=26,d=16911,c=AUCT_CLAS_ARMOR},  -- Burnt Leather Belt
	[4668]={b=160,s=32,d=26979,c=AUCT_CLAS_ARMOR},  -- Battle Chain Cloak
	[4669]={b=209,s=41,d=26930,c=AUCT_CLAS_ARMOR},  -- Battle Chain Girdle
	[4671]={b=162,s=32,d=25657,c=AUCT_CLAS_ARMOR},  -- Ancestral Cloak
	[4672]={b=141,s=28,d=14515,c=AUCT_CLAS_ARMOR},  -- Ancestral Belt
	[4674]={b=164,s=32,d=27997,c=AUCT_CLAS_ARMOR},  -- Tribal Cloak
	[4675]={b=178,s=35,d=16911,c=AUCT_CLAS_ARMOR},  -- Tribal Belt
	[4676]={b=1390,s=278,d=6991,c=AUCT_CLAS_ARMOR},  -- Skeletal Gauntlets
	[4677]={b=351,s=70,d=25950,c=AUCT_CLAS_ARMOR},  -- Veteran Cloak
	[4678]={b=543,s=108,d=22692,c=AUCT_CLAS_ARMOR},  -- Veteran Girdle
	[4680]={b=456,s=91,d=26981,c=AUCT_CLAS_ARMOR},  -- Brackwater Cloak
	[4681]={b=549,s=109,d=26947,c=AUCT_CLAS_ARMOR},  -- Brackwater Girdle
	[4683]={b=461,s=92,d=23113,c=AUCT_CLAS_ARMOR},  -- Spellbinder Cloak
	[4684]={b=307,s=61,d=14530,c=AUCT_CLAS_ARMOR},  -- Spellbinder Belt
	[4686]={b=336,s=67,d=23137,c=AUCT_CLAS_ARMOR},  -- Barbaric Cloth Cloak
	[4687]={b=338,s=67,d=16594,c=AUCT_CLAS_ARMOR},  -- Barbaric Cloth Belt
	[4689]={b=532,s=106,d=23041,c=AUCT_CLAS_ARMOR},  -- Hunting Cloak
	[4690]={b=356,s=71,d=14533,c=AUCT_CLAS_ARMOR},  -- Hunting Belt
	[4692]={b=344,s=68,d=28049,c=AUCT_CLAS_ARMOR},  -- Ceremonial Cloak
	[4693]={b=433,s=86,d=29632,c=AUCT_CLAS_ARMOR},  -- Ceremonial Leather Belt
	[4694]={b=2576,s=515,d=25770,c=AUCT_CLAS_ARMOR},  -- Burnished Pauldrons
	[4695]={b=1635,s=327,d=26048,c=AUCT_CLAS_ARMOR},  -- Burnished Cloak
	[4696]={b=22150,s=5537,d=18495,c=AUCT_CLAS_WEAPON},  -- Lapidis Tankard of Tidesippe
	[4697]={b=2179,s=435,d=25767,c=AUCT_CLAS_ARMOR},  -- Burnished Girdle
	[4698]={b=1508,s=301,d=14550,c=AUCT_CLAS_ARMOR},  -- Seer's Mantle
	[4699]={b=1105,s=221,d=14555,c=AUCT_CLAS_ARMOR},  -- Seer's Belt
	[4700]={b=1899,s=379,d=14232,c=AUCT_CLAS_ARMOR},  -- Inscribed Leather Spaulders
	[4701]={b=1263,s=252,d=23044,c=AUCT_CLAS_ARMOR},  -- Inscribed Cloak
	[4702]={b=0,s=0,d=7096,q=20,x=20},  -- Prospector's Pick
	[4703]={b=0,s=0,d=7064,q=20,x=20},  -- Broken Tools
	[4705]={b=7248,s=1449,d=25783,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Pauldrons
	[4706]={b=3438,s=687,d=25979,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Cloak
	[4707]={b=4407,s=881,d=25781,c=AUCT_CLAS_ARMOR},  -- Lambent Scale Girdle
	[4708]={b=2309,s=461,d=27545,c=AUCT_CLAS_ARMOR},  -- Bright Belt
	[4709]={b=4913,s=982,d=8098,c=AUCT_CLAS_ARMOR},  -- Forest Leather Mantle
	[4710]={b=2808,s=561,d=23029,c=AUCT_CLAS_ARMOR},  -- Forest Cloak
	[4711]={b=5561,s=1112,d=26047,c=AUCT_CLAS_ARMOR},  -- Glimmering Cloak
	[4712]={b=6140,s=1228,d=25803,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Girdle
	[4713]={b=4630,s=926,d=23140,c=AUCT_CLAS_ARMOR},  -- Silver-thread Cloak
	[4714]={b=3408,s=681,d=4557,c=AUCT_CLAS_ARMOR},  -- Silver-thread Sash
	[4715]={b=5130,s=1026,d=23024,c=AUCT_CLAS_ARMOR},  -- Emblazoned Cloak
	[4716]={b=8294,s=1658,d=26016,c=AUCT_CLAS_ARMOR},  -- Combat Cloak
	[4717]={b=10071,s=2014,d=25813,c=AUCT_CLAS_ARMOR},  -- Mail Combat Belt
	[4718]={b=11118,s=2223,d=16652,c=AUCT_CLAS_ARMOR},  -- Nightsky Mantle
	[4719]={b=8383,s=1676,d=18131,c=AUCT_CLAS_ARMOR},  -- Nightsky Cloak
	[4720]={b=6170,s=1234,d=14624,c=AUCT_CLAS_ARMOR},  -- Nightsky Sash
	[4721]={b=14047,s=2809,d=17193,c=AUCT_CLAS_ARMOR},  -- Insignia Mantle
	[4722]={b=10591,s=2118,d=23045,c=AUCT_CLAS_ARMOR},  -- Insignia Cloak
	[4723]={b=8518,s=1703,d=14332,c=AUCT_CLAS_ARMOR},  -- Humbert's Pants
	[4724]={b=8815,s=1763,d=21302,c=AUCT_CLAS_ARMOR},  -- Humbert's Helm
	[4725]={b=23680,s=4736,d=25897,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Pauldrons
	[4726]={b=11703,s=2340,d=25900,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Cloak
	[4727]={b=13955,s=2791,d=25895,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Girdle
	[4729]={b=15184,s=3036,d=14649,c=AUCT_CLAS_ARMOR},  -- Aurora Mantle
	[4731]={b=19122,s=3824,d=14677,c=AUCT_CLAS_ARMOR},  -- Glyphed Epaulets
	[4732]={b=13162,s=2632,d=23031,c=AUCT_CLAS_ARMOR},  -- Glyphed Cloak
	[4733]={b=39789,s=7957,d=26078,c=AUCT_CLAS_ARMOR},  -- Blackforge Pauldrons
	[4734]={b=21041,s=4208,d=11638,c=AUCT_CLAS_ARMOR},  -- Mistscape Mantle
	[4735]={b=18105,s=3621,d=23125,c=AUCT_CLAS_ARMOR},  -- Mistscape Cloak
	[4736]={b=13081,s=2616,d=14686,c=AUCT_CLAS_ARMOR},  -- Mistscape Sash
	[4737]={b=28715,s=5743,d=17192,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Spaulders
	[4738]={b=16471,s=3294,d=16921,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Belt
	[4739]={b=0,s=0,d=2599,q=20,x=20},  -- Plainstrider Meat
	[4740]={b=0,s=0,d=19572,q=20,x=20},  -- Plainstrider Feather
	[4741]={b=27194,s=5438,d=4912,c=AUCT_CLAS_ARMOR},  -- Stromgarde Cavalry Leggings
	[4742]={b=0,s=0,d=7169,q=20,x=20},  -- Mountain Cougar Pelt
	[4743]={b=21720,s=5430,d=6546,c=AUCT_CLAS_ARMOR},  -- Pulsating Crystalline Shard
	[4744]={b=9933,s=1986,d=16925,c=AUCT_CLAS_ARMOR},  -- Arcane Runed Bracers
	[4745]={b=16153,s=3230,d=7005,c=AUCT_CLAS_ARMOR},  -- War Rider Bracers
	[4746]={b=21620,s=4324,d=12718,c=AUCT_CLAS_ARMOR},  -- Doomsayer's Robe
	[4751]={b=0,s=0,d=7266,q=20,x=20},  -- Windfury Talon
	[4752]={b=0,s=0,d=19528,q=20,x=20},  -- Azure Feather
	[4753]={b=0,s=0,d=19529,q=20,x=20},  -- Bronze Feather
	[4755]={b=0,s=0,d=18102},  -- Water Pitcher
	[4757]={b=19,s=4,d=18053,x=5},  -- Cracked Egg Shells
	[4758]={b=0,s=0,d=6669,q=20,x=20},  -- Prairie Wolf Paw
	[4759]={b=0,s=0,d=7202,q=20,x=20},  -- Plainstrider Talon
	[4765]={b=2877,s=575,d=7313,c=AUCT_CLAS_WEAPON},  -- Enamelled Broadsword
	[4766]={b=2407,s=481,d=7314,c=AUCT_CLAS_WEAPON},  -- Feral Blade
	[4767]={b=695,s=139,d=3528,c=AUCT_CLAS_ARMOR},  -- Coppercloth Gloves
	[4768]={b=698,s=139,d=16946,c=AUCT_CLAS_ARMOR},  -- Adept's Gloves
	[4769]={b=0,s=0,d=11207,q=20,x=20},  -- Trophy Swoop Quill
	[4770]={b=0,s=0,d=7061,q=20,x=20},  -- Bristleback Belt
	[4771]={b=1324,s=264,d=23012,c=AUCT_CLAS_ARMOR},  -- Harvest Cloak
	[4772]={b=353,s=70,d=23075,c=AUCT_CLAS_ARMOR},  -- Warm Cloak
	[4775]={b=115,s=28,d=6633,x=5},  -- Cracked Bill
	[4776]={b=165,s=41,d=19567,x=10},  -- Ruffled Feather
	[4777]={b=7040,s=1408,d=19538,c=AUCT_CLAS_WEAPON},  -- Ironwood Maul
	[4778]={b=7350,s=1470,d=6808,c=AUCT_CLAS_WEAPON},  -- Heavy Spiked Mace
	[4779]={b=55,s=13,d=6652,x=10},  -- Dull Kodo Tooth
	[4780]={b=225,s=56,d=6664,x=5},  -- Kodo Horn Fragment
	[4781]={b=2735,s=547,d=8702,c=AUCT_CLAS_ARMOR},  -- Whispering Vest
	[4782]={b=2076,s=415,d=16812,c=AUCT_CLAS_ARMOR},  -- Solstice Robe
	[4783]={b=0,s=0,d=7276},  -- Totem of Hawkwind
	[4784]={b=1440,s=360,d=4719,x=5},  -- Lifeless Stone
	[4785]={b=2345,s=469,d=6277,c=AUCT_CLAS_ARMOR},  -- Brimstone Belt
	[4786]={b=1393,s=278,d=16833,c=AUCT_CLAS_ARMOR},  -- Wise Man's Belt
	[4787]={b=2310,s=577,d=22927,x=5},  -- Burning Pitch
	[4788]={b=2633,s=526,d=4024,c=AUCT_CLAS_ARMOR},  -- Agile Boots
	[4789]={b=1998,s=399,d=6777,c=AUCT_CLAS_ARMOR},  -- Stable Boots
	[4790]={b=4158,s=831,d=15165,c=AUCT_CLAS_ARMOR},  -- Inferno Cloak
	[4791]={b=535,s=133,d=6374,x=20},  -- Enchanted Water
	[4792]={b=3279,s=655,d=23131,c=AUCT_CLAS_ARMOR},  -- Spirit Cloak
	[4793]={b=3720,s=744,d=15247,c=AUCT_CLAS_ARMOR},  -- Sylvan Cloak
	[4794]={b=3515,s=703,d=6787,c=AUCT_CLAS_ARMOR},  -- Wolf Bracers
	[4795]={b=3528,s=705,d=6756,c=AUCT_CLAS_ARMOR},  -- Bear Bracers
	[4796]={b=3540,s=708,d=6758,c=AUCT_CLAS_ARMOR},  -- Owl Bracers
	[4797]={b=4262,s=852,d=15161,c=AUCT_CLAS_ARMOR},  -- Fiery Cloak
	[4798]={b=5832,s=1166,d=15206,c=AUCT_CLAS_ARMOR},  -- Heavy Runed Cloak
	[4799]={b=3042,s=608,d=23087,c=AUCT_CLAS_ARMOR},  -- Antiquated Cloak
	[4800]={b=6109,s=1221,d=697,c=AUCT_CLAS_ARMOR},  -- Mighty Chain Pants
	[4801]={b=0,s=0,d=1496,q=20,x=20},  -- Stalker Claws
	[4802]={b=0,s=0,d=6671,q=20,x=20},  -- Cougar Claws
	[4803]={b=0,s=0,d=6630,q=20,x=20},  -- Prairie Alpha Tooth
	[4804]={b=0,s=0,d=7142},  -- Prairie Wolf Heart
	[4805]={b=0,s=0,d=7126},  -- Flatland Cougar Femur
	[4806]={b=0,s=0,d=6646},  -- Plainstrider Scale
	[4807]={b=0,s=0,d=6427},  -- Swoop Gizzard
	[4808]={b=0,s=0,d=8039,q=20,x=20},  -- Well Stone
	[4809]={b=0,s=0,d=7287,q=20,x=20},  -- Ambercorn
	[4810]={b=16759,s=3351,d=19911,c=AUCT_CLAS_ARMOR},  -- Boulder Pads
	[4813]={b=135,s=33,d=15593,x=10},  -- Small Leather Collar
	[4814]={b=25,s=6,d=7048,x=5},  -- Discolored Fang
	[4816]={b=7518,s=1503,d=4978,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Leggings
	[4817]={b=12311,s=2462,d=7319,c=AUCT_CLAS_WEAPON},  -- Blessed Claymore
	[4818]={b=14273,s=2854,d=20155,c=AUCT_CLAS_WEAPON},  -- Executioner's Sword
	[4819]={b=0,s=0,d=4110},  -- Fizsprocket's Clipboard
	[4820]={b=8320,s=1664,d=18511,c=AUCT_CLAS_WEAPON},  -- Guardian Buckler
	[4821]={b=6541,s=1308,d=3445,c=AUCT_CLAS_WEAPON},  -- Bear Buckler
	[4822]={b=6746,s=1349,d=4983,c=AUCT_CLAS_WEAPON},  -- Owl's Disk
	[4823]={b=0,s=0,d=4984},  -- Water of the Seers
	[4824]={b=16856,s=3371,d=8459,c=AUCT_CLAS_WEAPON},  -- Blurred Axe
	[4825]={b=20472,s=4094,d=8461,c=AUCT_CLAS_WEAPON},  -- Callous Axe
	[4826]={b=15436,s=3087,d=19224,c=AUCT_CLAS_WEAPON},  -- Marauder Axe
	[4827]={b=3748,s=749,d=16865,c=AUCT_CLAS_ARMOR},  -- Wizard's Belt
	[4828]={b=3420,s=684,d=16792,c=AUCT_CLAS_ARMOR},  -- Nightwind Belt
	[4829]={b=4153,s=830,d=9912,c=AUCT_CLAS_ARMOR},  -- Dreamer's Belt
	[4830]={b=9474,s=1894,d=17153,c=AUCT_CLAS_ARMOR},  -- Saber Leggings
	[4831]={b=7858,s=1571,d=17154,c=AUCT_CLAS_ARMOR},  -- Stalking Pants
	[4832]={b=10497,s=2099,d=22428,c=AUCT_CLAS_ARMOR},  -- Mystic Sarong
	[4833]={b=8658,s=1731,d=6929,c=AUCT_CLAS_ARMOR},  -- Glorious Shoulders
	[4834]={b=0,s=0,d=7234,c=AUCT_CLAS_WRITTEN},  -- Venture Co. Documents
	[4835]={b=10550,s=2110,d=6912,c=AUCT_CLAS_ARMOR},  -- Elite Shoulders
	[4836]={b=8002,s=2000,d=21601,c=AUCT_CLAS_WEAPON},  -- Fireproof Orb
	[4837]={b=8002,s=2000,d=21611,c=AUCT_CLAS_WEAPON},  -- Strength of Will
	[4838]={b=8002,s=2000,d=21606,c=AUCT_CLAS_WEAPON},  -- Orb of Power
	[4840]={b=713,s=142,d=13908,c=AUCT_CLAS_WEAPON},  -- Long Bayonet
	[4841]={b=0,s=0,d=7145},  -- Horn of Arra'chea
	[4843]={b=0,s=0,d=7026},  -- Amethyst Runestone
	[4844]={b=0,s=0,d=7189},  -- Opal Runestone
	[4845]={b=0,s=0,d=7106},  -- Diamond Runestone
	[4846]={b=0,s=0,d=7072},  -- Cog #5
	[4847]={b=0,s=0,d=7159},  -- Lotwil's Shackles of Elemental Binding
	[4848]={b=0,s=0,d=8802,q=20,x=20},  -- Battleboar Snout
	[4849]={b=0,s=0,d=2599,q=20,x=20},  -- Battleboar Flank
	[4850]={b=0,s=0,d=7047},  -- Bristleback Attack Plans
	[4851]={b=0,s=0,d=7047,c=AUCT_CLAS_QUEST},  -- Dirt-stained Map
	[4852]={b=1200,s=300,d=6378,x=5},  -- Flash Bomb
	[4854]={b=0,s=0,d=23103,c=AUCT_CLAS_QUEST},  -- Demon Scarred Cloak
	[4859]={b=0,s=0,d=6484},  -- Burning Blade Medallion
	[4860]={b=2965,s=741,d=4433,x=5},  -- Glistening Frenzy Scale
	[4861]={b=596,s=119,d=5243,c=AUCT_CLAS_ARMOR},  -- Sleek Feathered Tunic
	[4862]={b=0,s=0,d=7229,q=20,x=20},  -- Scorpid Worker Tail
	[4863]={b=0,s=0,d=7602,q=20,x=20},  -- Gnomish Tools
	[4864]={b=0,s=0,d=7102,q=10,x=10},  -- Minshina's Skull
	[4865]={b=20,s=5,d=7086,x=5},  -- Ruined Pelt
	[4866]={b=0,s=0,d=9090},  -- Zalazane's Head
	[4867]={b=35,s=8,d=6619,x=5},  -- Broken Scorpid Leg
	[4869]={b=0,s=0,d=3146},  -- Fizzle's Claw
	[4870]={b=0,s=0,d=7067,q=20,x=20},  -- Canvas Scraps
	[4871]={b=0,s=0,d=12643,q=20,x=20},  -- Searing Collar
	[4872]={b=380,s=95,d=1504,x=5},  -- Dry Scorpid Eye
	[4873]={b=60,s=15,d=4714,x=5},  -- Dry Hardened Barnacle
	[4874]={b=185,s=46,d=6631,x=5},  -- Clean Fishbones
	[4875]={b=55,s=13,d=6668,x=5},  -- Slimy Bone
	[4876]={b=315,s=78,d=6615,x=5},  -- Bloody Leather Boot
	[4877]={b=40,s=10,d=6701,x=5},  -- Stone Arrowhead
	[4878]={b=225,s=56,d=6617},  -- Broken Bloodstained Bow
	[4879]={b=30,s=7,d=6700,x=5},  -- Squashed Rabbit Carcass
	[4880]={b=345,s=86,d=2868,x=5},  -- Broken Spear
	[4881]={b=0,s=0,d=3093,c=AUCT_CLAS_QUEST},  -- Aged Envelope
	[4882]={b=0,s=0,d=8903},  -- Benedict's Key
	[4883]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Admiral Proudmoore's Orders
	[4886]={b=0,s=0,d=6694,q=20,x=20},  -- Venomtail Poison Sac
	[4887]={b=0,s=0,d=7110,q=20,x=20},  -- Intact Makrura Eye
	[4888]={b=0,s=0,d=3788,q=20,x=20},  -- Crawler Mucus
	[4890]={b=0,s=0,d=18047,q=20,x=20},  -- Taillasher Egg
	[4891]={b=0,s=0,d=4841},  -- Kron's Amulet
	[4892]={b=0,s=0,d=7112,q=20,x=20},  -- Durotar Tiger Fur
	[4893]={b=0,s=0,d=3672,q=20,x=20},  -- Savannah Lion Tusk
	[4894]={b=0,s=0,d=3759,q=20,x=20},  -- Plainstrider Kidney
	[4895]={b=0,s=0,d=7089},  -- Thunder Lizard Horn
	[4896]={b=0,s=0,d=5287,q=20,x=20},  -- Kodo Liver
	[4897]={b=0,s=0,d=6694,q=20,x=20},  -- Thunderhawk Saliva Gland
	[4898]={b=0,s=0,d=5283,q=20,x=20},  -- Lightning Gland
	[4903]={b=0,s=0,d=7122,c=AUCT_CLAS_QUEST},  -- Eye of Burning Shadow
	[4904]={b=0,s=0,d=2533,q=20,x=20},  -- Venomtail Antidote
	[4905]={b=0,s=0,d=3146},  -- Sarkoth's Mangled Claw
	[4906]={b=109,s=21,d=8308,c=AUCT_CLAS_ARMOR},  -- Rainwalker Boots
	[4907]={b=65,s=13,d=8701,c=AUCT_CLAS_ARMOR},  -- Woodland Tunic
	[4908]={b=32,s=6,d=17169,c=AUCT_CLAS_ARMOR},  -- Nomadic Bracers
	[4909]={b=1844,s=368,d=7560,c=AUCT_CLAS_ARMOR},  -- Kodo Hunter's Leggings
	[4910]={b=38,s=7,d=6969,c=AUCT_CLAS_ARMOR},  -- Painted Chain Gloves
	[4911]={b=76,s=15,d=18522,c=AUCT_CLAS_WEAPON},  -- Thick Bark Buckler
	[4913]={b=35,s=7,d=9920,c=AUCT_CLAS_ARMOR},  -- Painted Chain Belt
	[4914]={b=29,s=5,d=17075,c=AUCT_CLAS_ARMOR},  -- Battleworn Leather Gloves
	[4915]={b=35,s=7,d=16802,c=AUCT_CLAS_ARMOR},  -- Soft Wool Boots
	[4916]={b=48,s=9,d=16800,c=AUCT_CLAS_ARMOR},  -- Soft Wool Vest
	[4917]={b=72,s=14,d=5337,c=AUCT_CLAS_ARMOR},  -- Battleworn Chain Leggings
	[4918]={b=0,s=0,d=1183,q=20,x=20},  -- Sack of Supplies
	[4919]={b=25,s=5,d=16799,c=AUCT_CLAS_ARMOR},  -- Soft Wool Belt
	[4920]={b=37,s=7,d=23007,c=AUCT_CLAS_ARMOR},  -- Battleworn Cape
	[4921]={b=63,s=12,d=9671,c=AUCT_CLAS_ARMOR},  -- Dust-covered Leggings
	[4922]={b=76,s=15,d=2967,c=AUCT_CLAS_ARMOR},  -- Jagged Chain Vest
	[4923]={b=128,s=25,d=8498,c=AUCT_CLAS_WEAPON},  -- Primitive Hatchet
	[4924]={b=129,s=25,d=19634,c=AUCT_CLAS_WEAPON},  -- Primitive Club
	[4925]={b=129,s=25,d=6457,c=AUCT_CLAS_WEAPON},  -- Primitive Hand Blade
	[4926]={b=0,s=0,d=18116,c=AUCT_CLAS_QUEST},  -- Chen's Empty Keg
	[4928]={b=102,s=20,d=17017,c=AUCT_CLAS_ARMOR},  -- Sandrunner Wristguards
	[4929]={b=291,s=58,d=17097,c=AUCT_CLAS_ARMOR},  -- Light Scorpid Armor
	[4931]={b=671,s=134,d=7603,c=AUCT_CLAS_WEAPON},  -- Hickory Shortbow
	[4932]={b=899,s=179,d=20013,c=AUCT_CLAS_WEAPON},  -- Harpy Wing Clipper
	[4933]={b=241,s=48,d=15211,c=AUCT_CLAS_ARMOR},  -- Seasoned Fighter's Cloak
	[4935]={b=117,s=23,d=7007,c=AUCT_CLAS_ARMOR},  -- Wide Metal Girdle
	[4936]={b=118,s=23,d=16880,c=AUCT_CLAS_ARMOR},  -- Dirt-trodden Boots
	[4937]={b=356,s=71,d=18510,c=AUCT_CLAS_WEAPON},  -- Charging Buckler
	[4938]={b=1182,s=236,d=20423,c=AUCT_CLAS_WEAPON},  -- Blemished Wooden Staff
	[4939]={b=1977,s=395,d=20112,c=AUCT_CLAS_WEAPON},  -- Steady Bastard Sword
	[4940]={b=182,s=36,d=17074,c=AUCT_CLAS_ARMOR},  -- Veiled Grips
	[4941]={b=45,s=11,d=1805,x=20},  -- Really Sticky Glue
	[4942]={b=449,s=89,d=16997,c=AUCT_CLAS_ARMOR},  -- Tiger Hide Boots
	[4944]={b=361,s=72,d=23116,c=AUCT_CLAS_ARMOR},  -- Handsewn Cloak
	[4945]={b=150,s=37,d=7099},  -- Faintly Glowing Skull
	[4946]={b=337,s=67,d=6876,c=AUCT_CLAS_ARMOR},  -- Lightweight Boots
	[4947]={b=1627,s=325,d=20603,c=AUCT_CLAS_WEAPON},  -- Jagged Dagger
	[4948]={b=1633,s=326,d=5009,c=AUCT_CLAS_WEAPON},  -- Stinging Mace
	[4949]={b=8532,s=1706,d=19214,c=AUCT_CLAS_WEAPON},  -- Orcish Cleaver
	[4951]={b=69,s=13,d=16938,c=AUCT_CLAS_ARMOR},  -- Squealer's Belt
	[4952]={b=255,s=63,d=18099,x=10},  -- Stormstout
	[4953]={b=355,s=88,d=18117,x=10},  -- Trogg Ale
	[4954]={b=30,s=6,d=16932,c=AUCT_CLAS_ARMOR},  -- Nomadic Belt
	[4957]={b=1000,s=250,d=1168,c=AUCT_CLAS_CONTAINER},  -- Old Moneybag
	[4958]={b=180,s=36,d=15244,c=AUCT_CLAS_ARMOR},  -- Sun-beaten Cloak
	[4960]={b=50,s=12,d=5998,x=200,c=AUCT_CLAS_WEAPON},  -- Flash Pellet
	[4961]={b=918,s=183,d=20426,c=AUCT_CLAS_WEAPON},  -- Dreamwatcher Staff
	[4962]={b=100,s=20,d=5418,c=AUCT_CLAS_ARMOR},  -- Double-layered Gloves
	[4963]={b=152,s=30,d=23071,c=AUCT_CLAS_ARMOR},  -- Thunderhorn Cloak
	[4964]={b=2516,s=503,d=19544,c=AUCT_CLAS_WEAPON},  -- Goblin Smasher
	[4967]={b=580,s=116,d=5422,c=AUCT_CLAS_WEAPON},  -- Tribal Warrior's Shield
	[4968]={b=454,s=90,d=9925,c=AUCT_CLAS_ARMOR},  -- Bound Harness
	[4969]={b=210,s=42,d=6915,c=AUCT_CLAS_ARMOR},  -- Fortified Bindings
	[4970]={b=271,s=54,d=16968,c=AUCT_CLAS_ARMOR},  -- Rough-hewn Kodo Leggings
	[4971]={b=1919,s=383,d=8572,c=AUCT_CLAS_WEAPON},  -- Skorn's Hammer
	[4972]={b=320,s=64,d=6876,c=AUCT_CLAS_ARMOR},  -- Cliff Runner Boots
	[4973]={b=178,s=35,d=17014,c=AUCT_CLAS_ARMOR},  -- Plains Hunter Wristguards
	[4974]={b=1940,s=388,d=3006,c=AUCT_CLAS_WEAPON},  -- Compact Fighting Knife
	[4975]={b=32389,s=6477,d=18491,c=AUCT_CLAS_WEAPON},  -- Vigilant Buckler
	[4976]={b=27431,s=5486,d=28287,c=AUCT_CLAS_ARMOR},  -- Mistspray Kilt
	[4977]={b=59465,s=11893,d=20009,c=AUCT_CLAS_WEAPON},  -- Sword of Hammerfall
	[4978]={b=39882,s=7976,d=19741,c=AUCT_CLAS_WEAPON},  -- Ryedol's Hammer
	[4979]={b=12939,s=2587,d=5434,c=AUCT_CLAS_ARMOR},  -- Enchanted Stonecloth Bracers
	[4980]={b=11048,s=2209,d=5435,c=AUCT_CLAS_ARMOR},  -- Prospector Gloves
	[4982]={b=4807,s=961,d=10411,c=AUCT_CLAS_ARMOR},  -- Ripped Prospector Belt
	[4983]={b=84185,s=16837,d=19596,c=AUCT_CLAS_WEAPON},  -- Rock Pulverizer
	[4984]={b=22520,s=5630,d=21609,c=AUCT_CLAS_WEAPON},  -- Skull of Impending Doom
	[4986]={b=0,s=0,d=6521},  -- Flawed Power Stone
	[4987]={b=77920,s=15584,d=20083,c=AUCT_CLAS_WEAPON},  -- Dwarf Captain's Sword
	[4992]={b=0,s=0,d=5567,c=AUCT_CLAS_WRITTEN},  -- Recruitment Letter
	[4995]={b=0,s=0,d=5567,c=AUCT_CLAS_WRITTEN},  -- Signed Recruitment Letter
	[4998]={b=3350,s=837,d=9834,c=AUCT_CLAS_ARMOR},  -- Blood Ring
	[4999]={b=4210,s=1052,d=14433,c=AUCT_CLAS_ARMOR},  -- Azora's Will
	[5001]={b=4155,s=1038,d=9834,c=AUCT_CLAS_ARMOR},  -- Heart Ring
	[5002]={b=6140,s=1535,d=6539,c=AUCT_CLAS_ARMOR},  -- Glowing Green Talisman
	[5003]={b=6855,s=1713,d=9854,c=AUCT_CLAS_ARMOR},  -- Crystal Starfire Medallion
	[5006]={b=0,s=0,d=7152,c=AUCT_CLAS_WRITTEN},  -- Khazgorm's Journal
	[5007]={b=6530,s=1632,d=6478,c=AUCT_CLAS_ARMOR},  -- Band of Thorns
	[5009]={b=6785,s=1696,d=9840,c=AUCT_CLAS_ARMOR},  -- Mindbender Loop
	[5011]={b=7650,s=1912,d=9851,c=AUCT_CLAS_ARMOR},  -- Welken Ring
	[5012]={b=0,s=0,d=7127,q=20,x=20},  -- Fungal Spores
	[5016]={b=14775,s=2955,d=16849,c=AUCT_CLAS_ARMOR},  -- Artisan's Trousers
	[5017]={b=0,s=0,d=1150,q=20,x=20},  -- Nitroglycerin
	[5018]={b=0,s=0,d=7290,q=20,x=20},  -- Wood Pulp
	[5019]={b=0,s=0,d=7256,q=20,x=20},  -- Sodium Nitrate
	[5020]={b=15,s=3,d=4287},  -- Kolkar Booty Key
	[5021]={b=0,s=0,d=18062},  -- Explosive Stick of Gann
	[5022]={b=0,s=0,d=12904},  -- Barak's Head
	[5023]={b=0,s=0,d=12904},  -- Verog's Head
	[5025]={b=0,s=0,d=12904},  -- Hezrul's Head
	[5026]={b=0,s=0,d=9518},  -- Fire Tar
	[5027]={b=0,s=0,d=1282},  -- Rendered Spores
	[5028]={b=22150,s=5537,d=24742,c=AUCT_CLAS_WEAPON},  -- Lord Sakrasis' Scepter
	[5029]={b=21130,s=5282,d=9860,c=AUCT_CLAS_ARMOR},  -- Talisman of the Naga Lord
	[5030]={b=0,s=0,d=7070,q=20,x=20},  -- Centaur Bracers
	[5038]={b=0,s=0,d=7267},  -- Tear of the Moons
	[5040]={b=0,s=0,d=20321,c=AUCT_CLAS_WEAPON},  -- Shadow Hunter Knife
	[5042]={b=50,s=12,d=6405,x=10},  -- Red Ribboned Wrapping Paper
	[5043]={b=0,s=0,d=6404},  -- Red Ribboned Gift
	[5044]={b=0,s=0,d=6329},  -- Blue Ribboned Gift
	[5048]={b=50,s=12,d=6330,x=10},  -- Blue Ribboned Wrapping Paper
	[5050]={b=0,s=0,d=8902},  -- Ignition Key
	[5051]={b=1,s=1,d=7107,q=20,x=20,u=AUCT_TYPE_COOK},  -- Dig Rat
	[5052]={b=0,s=0,d=6705,u=AUCT_TYPE_COOK},  -- Unconscious Dig Rat
	[5054]={b=0,s=0,d=9167},  -- Samophlange
	[5055]={b=0,s=0,d=7048,q=20,x=20},  -- Intact Raptor Horn
	[5056]={b=0,s=0,d=1464,q=20,x=20},  -- Root Sample
	[5057]={b=25,s=1,d=6390,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Ripe Watermelon
	[5058]={b=0,s=0,d=18050,q=20,x=20},  -- Silithid Egg
	[5059]={b=0,s=0,d=7108},  -- Digging Claw
	[5060]={b=1500,s=0,d=7411},  -- Thieves' Tools
	[5061]={b=0,s=0,d=7260,q=20,x=20},  -- Stolen Silver
	[5062]={b=0,s=0,d=9826,q=20,x=20},  -- Raptor Head
	[5063]={b=0,s=0,d=7154},  -- Kreenig Snarlsnout's Tusk
	[5064]={b=0,s=0,d=7288,q=20,x=20},  -- Witchwing Talon
	[5065]={b=0,s=0,d=6013,q=20,x=20},  -- Harpy Lieutenant Ring
	[5066]={b=85,s=21,d=6377,x=10},  -- Fissure Plant
	[5067]={b=0,s=0,d=7235},  -- Serena's Head
	[5068]={b=0,s=0,d=6371},  -- Dried Seeds
	[5069]={b=1465,s=293,d=6097,c=AUCT_CLAS_WEAPON},  -- Fire Wand
	[5071]={b=2215,s=443,d=18356,c=AUCT_CLAS_WEAPON},  -- Shadow Wand
	[5072]={b=0,s=0,d=7101},  -- Lok's Skull
	[5073]={b=0,s=0,d=7101},  -- Nak's Skull
	[5074]={b=0,s=0,d=7101},  -- Kuz's Skull
	[5075]={b=100,s=25,d=7045,x=10},  -- Blood Shard
	[5076]={b=0,s=0,d=7242,q=20,x=20},  -- Shipment of Boots
	[5077]={b=0,s=0,d=7268,q=20,x=20},  -- Telescopic Lens
	[5078]={b=0,s=0,d=7271,q=20,x=20},  -- Theramore Medal
	[5079]={b=18570,s=4642,d=6492,c=AUCT_CLAS_ARMOR},  -- Cold Basilisk Eye
	[5080]={b=0,s=0,d=1134,q=10,x=10},  -- Gazlowe's Ledger
	[5081]={b=1000,s=250,d=4584,c=AUCT_CLAS_CONTAINER},  -- Kodo Hide Bag
	[5082]={b=100,s=25,d=7412,x=10,u=AUCT_TYPE_LEATHER},  -- Thin Kodo Leather
	[5083]={b=200,s=50,d=1102},  -- Pattern: Kodo Hide Bag
	[5084]={b=0,s=0,d=7038},  -- Baron Longshore's Head
	[5085]={b=0,s=0,d=7209,q=20,x=20},  -- Bristleback Quilboar Tusk
	[5086]={b=0,s=0,d=7295,q=20,x=20},  -- Zhevra Hooves
	[5087]={b=0,s=0,d=6633,q=20,x=20},  -- Plainstrider Beak
	[5088]={b=0,s=0,d=7073,c=AUCT_CLAS_WRITTEN},  -- Control Console Operating Manual
	[5089]={b=0,s=0,d=9660},  -- Console Key
	[5092]={b=1203,s=240,d=6101,c=AUCT_CLAS_WEAPON},  -- Charred Razormane Wand
	[5093]={b=1238,s=247,d=20392,c=AUCT_CLAS_WEAPON},  -- Razormane Backstabber
	[5094]={b=1168,s=233,d=5808,c=AUCT_CLAS_WEAPON},  -- Razormane War Shield
	[5095]={b=125,s=3,d=24704,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Rainbow Fin Albacore
	[5096]={b=0,s=0,d=7204,q=20,x=20},  -- Prowler Claws
	[5097]={b=0,s=0,d=6851},  -- Cats Eye Emerald
	[5098]={b=0,s=0,d=17460,q=20,x=20},  -- Altered Snapjaw Shell
	[5099]={b=0,s=0,d=7144,c=AUCT_CLAS_QUEST},  -- Hoof of Lakota'mani
	[5100]={b=0,s=0,d=7086},  -- Echeyakee's Hide
	[5101]={b=0,s=0,d=6666},  -- Ishamuhale's Fang
	[5102]={b=0,s=0,d=8007,c=AUCT_CLAS_QUEST},  -- Owatanka's Tailspike
	[5103]={b=0,s=0,d=11207,c=AUCT_CLAS_QUEST},  -- Washte Pawne's Feather
	[5104]={b=0,s=0,d=7142},  -- Heart of Isha Awak
	[5107]={b=698,s=139,d=16557,c=AUCT_CLAS_ARMOR},  -- Deckhand's Shirt
	[5109]={b=1116,s=223,d=16589,c=AUCT_CLAS_ARMOR},  -- Stonesplinter Rags
	[5110]={b=1289,s=257,d=12656,c=AUCT_CLAS_ARMOR},  -- Dalaran Wizard's Robe
	[5111]={b=1601,s=320,d=18133,c=AUCT_CLAS_ARMOR},  -- Rathorian's Cape
	[5112]={b=3651,s=730,d=20491,c=AUCT_CLAS_WEAPON},  -- Ritual Blade
	[5113]={b=1000,s=250,d=6565,x=5},  -- Mark of the Syndicate
	[5114]={b=385,s=96,d=6627,x=5},  -- Severed Talon
	[5115]={b=405,s=101,d=18072,x=5},  -- Broken Wishbone
	[5116]={b=1215,s=303,d=19571,x=10,u=AUCT_TYPE_LEATHER},  -- Long Tail Feather
	[5117]={b=3300,s=825,d=19570,x=10},  -- Vibrant Plume
	[5118]={b=285,s=71,d=6657,x=10},  -- Large Flat Tooth
	[5119]={b=475,s=118,d=18095,x=10},  -- Fine Loose Hair
	[5120]={b=775,s=193,d=18096,x=5},  -- Long Tail Hair
	[5121]={b=650,s=162,d=6646,x=5},  -- Dirty Kodo Scale
	[5122]={b=1150,s=287,d=6702,x=10},  -- Thick Kodo Hair
	[5123]={b=470,s=117,d=6701,x=5},  -- Steel Arrowhead
	[5124]={b=470,s=117,d=6002,x=10},  -- Small Raptor Tooth
	[5125]={b=620,s=155,d=6628,x=5},  -- Charged Scale
	[5128]={b=810,s=202,d=568,x=5},  -- Shed Lizard Skin
	[5133]={b=1200,s=300,d=1438,x=5},  -- Seeping Gizzard
	[5134]={b=370,s=92,d=7231,x=5},  -- Small Furry Paw
	[5135]={b=570,s=142,d=6651,x=5},  -- Thin Black Claw
	[5136]={b=710,s=177,d=6704,x=5},  -- Torn Furry Ear
	[5137]={b=870,s=217,d=1504,x=5},  -- Bright Eyeball
	[5138]={b=0,s=0,d=15525,c=AUCT_CLAS_QUEST},  -- Harvester's Head
	[5140]={b=25,s=6,d=6379,x=10},  -- Flash Powder
	[5143]={b=0,s=0,d=7262,q=20,x=20},  -- Thunder Lizard Blood
	[5164]={b=0,s=0,d=8284},  -- Thunderhawk Wings
	[5165]={b=0,s=0,d=19799,q=20,x=20},  -- Sunscale Feather
	[5166]={b=0,s=0,d=4045,q=20,x=20},  -- Webwood Venom Sac
	[5167]={b=0,s=0,d=18047,q=20,x=20},  -- Webwood Egg
	[5168]={b=0,s=0,d=7273,q=20,x=20},  -- Timberling Seed
	[5169]={b=0,s=0,d=7274,q=20,x=20},  -- Timberling Sprout
	[5170]={b=0,s=0,d=5283,q=20,x=20},  -- Mossy Tumor
	[5173]={b=100,s=25,d=7328,x=10,u=AUCT_TYPE_POISON},  -- Deathweed
	[5175]={b=0,s=0,d=7299,c=AUCT_CLAS_SHAMAN},  -- Earth Totem
	[5176]={b=0,s=0,d=7299,c=AUCT_CLAS_SHAMAN},  -- Fire Totem
	[5177]={b=0,s=0,d=7299,c=AUCT_CLAS_SHAMAN},  -- Water Totem
	[5178]={b=0,s=0,d=7299,c=AUCT_CLAS_SHAMAN},  -- Air Totem
	[5179]={b=0,s=0,d=5283,c=AUCT_CLAS_QUEST},  -- Moss-twined Heart
	[5180]={b=11110,s=2777,d=6494,c=AUCT_CLAS_ARMOR},  -- Necklace of Harmony
	[5181]={b=8890,s=1778,d=23142,c=AUCT_CLAS_ARMOR},  -- Vibrant Silk Cape
	[5182]={b=8849,s=1769,d=8000,c=AUCT_CLAS_WEAPON},  -- Shiver Blade
	[5183]={b=6300,s=1575,d=21607,c=AUCT_CLAS_WEAPON},  -- Pulsating Hydra Heart
	[5184]={b=0,s=0,d=7124},  -- Filled Crystal Phial
	[5185]={b=0,s=0,d=8545},  -- Crystal Phial
	[5186]={b=0,s=0,d=7125},  -- Partially Filled Vessel
	[5187]={b=5407,s=1081,d=8600,c=AUCT_CLAS_WEAPON},  -- Rhahk'Zor's Hammer
	[5188]={b=0,s=0,d=7125},  -- Filled Vessel
	[5189]={b=0,s=0,d=7130},  -- Glowing Fruit
	[5190]={b=0,s=0,d=7240},  -- Shimmering Frond
	[5191]={b=14822,s=2964,d=7311,c=AUCT_CLAS_WEAPON},  -- Cruel Barb
	[5192]={b=9015,s=1803,d=5144,c=AUCT_CLAS_WEAPON},  -- Thief's Blade
	[5193]={b=4700,s=940,d=22998,c=AUCT_CLAS_ARMOR},  -- Cape of the Brotherhood
	[5194]={b=15399,s=3079,d=19296,c=AUCT_CLAS_WEAPON},  -- Taskmaster Axe
	[5195]={b=1823,s=364,d=16966,c=AUCT_CLAS_ARMOR},  -- Gold-flecked Gloves
	[5196]={b=9154,s=1830,d=13913,c=AUCT_CLAS_WEAPON},  -- Smite's Reaver
	[5197]={b=7989,s=1597,d=20953,c=AUCT_CLAS_WEAPON},  -- Cookie's Tenderizer
	[5198]={b=8301,s=1660,d=21011,c=AUCT_CLAS_WEAPON},  -- Cookie's Stirring Rod
	[5199]={b=4024,s=804,d=1978,c=AUCT_CLAS_ARMOR},  -- Smelting Pants
	[5200]={b=11615,s=2323,d=5949,c=AUCT_CLAS_WEAPON},  -- Impaling Harpoon
	[5201]={b=15809,s=3161,d=20340,c=AUCT_CLAS_WEAPON},  -- Emberstone Staff
	[5202]={b=5737,s=1147,d=12803,c=AUCT_CLAS_ARMOR},  -- Corsair's Overshirt
	[5203]={b=0,s=0,d=6669,q=20,x=20},  -- Flatland Prowler Claw
	[5204]={b=0,s=0,d=7046,q=20,x=20},  -- Bloodfeather Belt
	[5205]={b=125,s=31,d=6416,x=10},  -- Sprouted Frond
	[5206]={b=150,s=37,d=6331,x=10},  -- Bogling Root
	[5207]={b=5405,s=1081,d=20903,c=AUCT_CLAS_WEAPON},  -- Opaque Wand
	[5208]={b=3340,s=668,d=20829,c=AUCT_CLAS_WEAPON},  -- Smoldering Wand
	[5209]={b=3854,s=770,d=6099,c=AUCT_CLAS_WEAPON},  -- Gloom Wand
	[5210]={b=5807,s=1161,d=20787,c=AUCT_CLAS_WEAPON},  -- Burning Wand
	[5211]={b=5830,s=1166,d=20852,c=AUCT_CLAS_WEAPON},  -- Dusk Wand
	[5212]={b=3361,s=672,d=6081,c=AUCT_CLAS_WEAPON},  -- Blazing Wand
	[5213]={b=26093,s=5218,d=20907,c=AUCT_CLAS_WEAPON},  -- Scorching Wand
	[5214]={b=19677,s=3935,d=21020,c=AUCT_CLAS_WEAPON},  -- Wand of Eventide
	[5215]={b=43280,s=8656,d=20815,c=AUCT_CLAS_WEAPON},  -- Ember Wand
	[5216]={b=59108,s=11821,d=20790,c=AUCT_CLAS_WEAPON},  -- Umbral Wand
	[5217]={b=0,s=0,d=3422},  -- Tainted Heart
	[5218]={b=0,s=0,d=3422},  -- Cleansed Timberling Heart
	[5219]={b=0,s=0,d=7149},  -- Inscribed Bark
	[5220]={b=0,s=0,d=7134,q=20,x=20},  -- Gnarlpine Fang
	[5221]={b=0,s=0,d=7164},  -- Melenas' Head
	[5232]={b=0,s=0,d=6009,c=AUCT_CLAS_WARLOCK},  -- Minor Soulstone
	[5233]={b=0,s=0,d=6017},  -- Stone of Relu
	[5234]={b=0,s=0,d=6016},  -- Flagongut's Fossil
	[5236]={b=14394,s=2878,d=20916,c=AUCT_CLAS_WEAPON},  -- Combustible Wand
	[5237]={b=72,s=18,d=13709,x=10,c=AUCT_CLAS_POISON},  -- Mind-numbing Poison
	[5238]={b=35727,s=7145,d=20787,c=AUCT_CLAS_WEAPON},  -- Pitchwood Wand
	[5239]={b=38731,s=7746,d=20776,c=AUCT_CLAS_WEAPON},  -- Blackbone Wand
	[5240]={b=6220,s=1244,d=6101,c=AUCT_CLAS_WEAPON},  -- Torchlight Wand
	[5241]={b=4104,s=820,d=6097,c=AUCT_CLAS_WEAPON},  -- Dwarven Flamestick
	[5242]={b=3114,s=622,d=6093,c=AUCT_CLAS_WEAPON},  -- Cinder Wand
	[5243]={b=6562,s=1312,d=12601,c=AUCT_CLAS_WEAPON},  -- Firebelcher
	[5244]={b=17325,s=3465,d=21024,c=AUCT_CLAS_WEAPON},  -- Consecrated Wand
	[5245]={b=25457,s=5091,d=21019,c=AUCT_CLAS_WEAPON},  -- Summoner's Wand
	[5246]={b=17449,s=3489,d=6093,c=AUCT_CLAS_WEAPON},  -- Excavation Rod
	[5247]={b=39806,s=7961,d=20828,c=AUCT_CLAS_WEAPON},  -- Rod of Sorrow
	[5248]={b=34245,s=6849,d=21023,c=AUCT_CLAS_WEAPON},  -- Flash Wand
	[5249]={b=43292,s=8658,d=20793,c=AUCT_CLAS_WEAPON},  -- Burning Sliver
	[5250]={b=13232,s=2646,d=6140,c=AUCT_CLAS_WEAPON},  -- Charred Wand
	[5251]={b=0,s=0,d=8752},  -- Phial of Scrying
	[5252]={b=5877,s=1175,d=20825,c=AUCT_CLAS_WEAPON},  -- Wand of Decay
	[5253]={b=39760,s=7952,d=20801,c=AUCT_CLAS_WEAPON},  -- Goblin Igniter
	[5254]={b=1544,s=308,d=10179,c=AUCT_CLAS_ARMOR},  -- Rugged Spaulders
	[5256]={b=36136,s=7227,d=19673,c=AUCT_CLAS_WEAPON},  -- Kovork's Rattle
	[5257]={b=15799,s=3159,d=23000,c=AUCT_CLAS_ARMOR},  -- Dark Hooded Cape
	[5263]={b=4,s=1,d=6238,q=10,x=10},  -- Pocket Lint
	[5266]={b=44630,s=11157,d=9837,c=AUCT_CLAS_ARMOR},  -- Eye of Adaegus
	[5267]={b=299255,s=59851,d=3363,c=AUCT_CLAS_WEAPON},  -- Scarlet Kris
	[5268]={b=875,s=218,d=16363,x=5},  -- Cracked Silithid Shell
	[5269]={b=380,s=95,d=2885,x=5},  -- Silithid Ichor
	[5270]={b=0,s=0,d=15857,q=20,x=20},  -- Death Cap
	[5271]={b=0,s=0,d=19488,q=20,x=20},  -- Scaber Stalk
	[5272]={b=0,s=0,d=6927},  -- Insane Scribbles
	[5273]={b=0,s=0,d=13988,q=20,x=20},  -- Mathystra Relic
	[5274]={b=5018,s=1003,d=17135,c=AUCT_CLAS_ARMOR},  -- Rose Mantle
	[5275]={b=879,s=175,d=7545,c=AUCT_CLAS_ARMOR},  -- Binding Girdle
	[5279]={b=7184,s=1436,d=20411,c=AUCT_CLAS_WEAPON},  -- Harpy Skinner
	[5299]={b=1795,s=359,d=17223,c=AUCT_CLAS_ARMOR},  -- Gloves of the Moon
	[5302]={b=4647,s=929,d=18451,c=AUCT_CLAS_WEAPON},  -- Cobalt Buckler
	[5306]={b=8554,s=1710,d=7524,c=AUCT_CLAS_WEAPON},  -- Wind Rider Staff
	[5309]={b=5190,s=1038,d=7531,c=AUCT_CLAS_WEAPON},  -- Privateer Musket
	[5310]={b=2778,s=555,d=7533,c=AUCT_CLAS_ARMOR},  -- Sea Dog Britches
	[5311]={b=3007,s=601,d=17159,c=AUCT_CLAS_ARMOR},  -- Buckled Boots
	[5312]={b=2099,s=419,d=7540,c=AUCT_CLAS_ARMOR},  -- Riveted Gauntlets
	[5313]={b=2600,s=650,d=7544,c=AUCT_CLAS_ARMOR},  -- Totemic Clan Ring
	[5314]={b=2643,s=528,d=23012,c=AUCT_CLAS_ARMOR},  -- Boar Hunter's Cape
	[5315]={b=1069,s=213,d=28200,c=AUCT_CLAS_ARMOR},  -- Timberland Armguards
	[5316]={b=6778,s=1355,d=16870,c=AUCT_CLAS_ARMOR},  -- Barkshell Tunic
	[5317]={b=6803,s=1360,d=8658,c=AUCT_CLAS_ARMOR},  -- Dry Moss Tunic
	[5318]={b=8946,s=1789,d=22225,c=AUCT_CLAS_WEAPON},  -- Zhovur Axe
	[5319]={b=1615,s=323,d=7553,c=AUCT_CLAS_ARMOR},  -- Bashing Pauldrons
	[5320]={b=1862,s=372,d=7554,c=AUCT_CLAS_ARMOR},  -- Padded Lamellar Boots
	[5321]={b=7423,s=1484,d=20014,c=AUCT_CLAS_WEAPON},  -- Elegant Shortsword
	[5322]={b=20081,s=4016,d=19611,c=AUCT_CLAS_WEAPON},  -- Demolition Hammer
	[5323]={b=6530,s=1632,d=7557,c=AUCT_CLAS_WEAPON},  -- Everglow Lantern
	[5324]={b=3881,s=776,d=8568,c=AUCT_CLAS_WEAPON},  -- Engineer's Hammer
	[5325]={b=2493,s=498,d=7559,c=AUCT_CLAS_WEAPON},  -- Welding Shield
	[5326]={b=3879,s=775,d=6097,c=AUCT_CLAS_WEAPON},  -- Flaring Baton
	[5327]={b=2595,s=519,d=16958,c=AUCT_CLAS_ARMOR},  -- Greasy Tinker's Pants
	[5328]={b=1028,s=205,d=7563,c=AUCT_CLAS_ARMOR},  -- Cinched Belt
	[5329]={b=60,s=15,d=8289,x=20},  -- Cat Figurine
	[5332]={b=60,s=15,d=8289},  -- Glowing Cat Figurine
	[5334]={b=0,s=0,d=18079},  -- 99-Year-Old Port
	[5335]={b=0,s=0,d=1183},  -- A Sack of Coins
	[5336]={b=0,s=0,d=9849,q=20,x=20},  -- Grell Earring
	[5337]={b=836,s=167,d=19899,c=AUCT_CLAS_ARMOR},  -- Wayfaring Gloves
	[5338]={b=0,s=0,d=7572},  -- Ancient Moonstone Seal
	[5339]={b=0,s=0,d=7573,q=20,x=20},  -- Serpentbloom
	[5340]={b=4596,s=919,d=20417,c=AUCT_CLAS_WEAPON},  -- Cauldron Stirrer
	[5341]={b=1844,s=368,d=8717,c=AUCT_CLAS_ARMOR},  -- Spore-covered Tunic
	[5342]={b=355,s=88,d=18099,x=10},  -- Raptor Punch
	[5343]={b=2310,s=462,d=23088,c=AUCT_CLAS_ARMOR},  -- Barkeeper's Cloak
	[5344]={b=2812,s=562,d=8485,c=AUCT_CLAS_WEAPON},  -- Pointed Axe
	[5345]={b=3529,s=705,d=8602,c=AUCT_CLAS_WEAPON},  -- Stonewood Hammer
	[5346]={b=2125,s=425,d=20719,c=AUCT_CLAS_WEAPON},  -- Orcish Battle Bow
	[5347]={b=15713,s=3142,d=21022,c=AUCT_CLAS_WEAPON},  -- Pestilent Wand
	[5348]={b=0,s=0,d=3331,q=20,x=20},  -- Worn Parchment
	[5349]={b=0,s=0,d=6342,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Conjured Muffin
	[5350]={b=0,s=0,d=18081,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Conjured Water
	[5351]={b=1615,s=403,d=6011,c=AUCT_CLAS_ARMOR},  -- Bounty Hunter's Ring
	[5352]={b=0,s=0,d=7637,c=AUCT_CLAS_QUEST},  -- Book: The Powers Below
	[5354]={b=0,s=0,d=8919,c=AUCT_CLAS_WRITTEN},  -- Letter to Delgren
	[5355]={b=4738,s=947,d=7662,c=AUCT_CLAS_ARMOR},  -- Beastmaster's Girdle
	[5356]={b=12971,s=2594,d=20834,c=AUCT_CLAS_WEAPON},  -- Branding Rod
	[5357]={b=11107,s=2221,d=1685,c=AUCT_CLAS_WEAPON},  -- Ward of the Vale
	[5359]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Lorgalis Manuscript
	[5360]={b=0,s=0,d=7697,q=20,x=20},  -- Highborne Relic
	[5361]={b=65,s=16,d=6651,x=10},  -- Fishbone Toothpick
	[5362]={b=75,s=18,d=1504,x=5},  -- Chew Toy
	[5363]={b=80,s=20,d=7717,x=5},  -- Folded Handkerchief
	[5364]={b=110,s=27,d=4718,x=5},  -- Dry Salt Lick
	[5366]={b=0,s=0,d=6554},  -- Glowing Soul Gem
	[5367]={b=90,s=22,d=4717,x=5},  -- Primitive Rock Tool
	[5368]={b=195,s=48,d=7718,x=5},  -- Empty Wallet
	[5369]={b=130,s=32,d=7251,x=5},  -- Gnawed Bone
	[5370]={b=150,s=37,d=7716,x=5},  -- Bent Spoon
	[5371]={b=195,s=48,d=7713,x=5},  -- Piece of Coral
	[5373]={b=290,s=72,d=15026,x=5,u=AUCT_TYPE_LEATHER},  -- Lucky Charm
	[5374]={b=350,s=87,d=7719,x=5},  -- Small Pocket Watch
	[5375]={b=380,s=95,d=8119,x=5},  -- Scratching Stick
	[5376]={b=265,s=66,d=7268,x=5},  -- Broken Mirror
	[5377]={b=230,s=57,d=7714,x=5},  -- Scallop Shell
	[5379]={b=0,s=0,d=20781,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Boot Knife
	[5382]={b=0,s=0,d=7735},  -- Anaya's Pendant
	[5383]={b=0,s=0,d=7164},  -- Athrikus Narassin's Head
	[5385]={b=0,s=0,d=8007,q=20,x=20},  -- Crawler Leg
	[5386]={b=0,s=0,d=7740,q=20,x=20},  -- Fine Moonstalker Pelt
	[5387]={b=0,s=0,d=23108,c=AUCT_CLAS_ARMOR},  -- Enchanted Moonstalker Cloak
	[5388]={b=0,s=0,d=7741},  -- Ran Bloodtooth's Skull
	[5389]={b=0,s=0,d=7742},  -- Corrupted Furbolg Totem
	[5390]={b=0,s=0,d=7744},  -- Fandral's Message
	[5391]={b=0,s=0,d=7791},  -- Rare Earth
	[5392]={b=127,s=25,d=6432,c=AUCT_CLAS_WEAPON},  -- Thistlewood Dagger
	[5393]={b=160,s=32,d=5108,c=AUCT_CLAS_WEAPON},  -- Thistlewood Staff
	[5394]={b=31,s=6,d=7823,c=AUCT_CLAS_ARMOR},  -- Archery Training Gloves
	[5395]={b=82,s=16,d=18671,c=AUCT_CLAS_WEAPON},  -- Woodland Shield
	[5396]={b=0,s=0,d=13824},  -- Key to Searing Gorge
	[5397]={b=0,s=0,d=7828},  -- Defias Gunpowder
	[5398]={b=65,s=13,d=16951,c=AUCT_CLAS_ARMOR},  -- Canopy Leggings
	[5399]={b=59,s=11,d=7835,c=AUCT_CLAS_ARMOR},  -- Tracking Boots
	[5404]={b=2345,s=469,d=6729,c=AUCT_CLAS_ARMOR},  -- Serpent's Shoulders
	[5405]={b=36,s=7,d=23105,c=AUCT_CLAS_ARMOR},  -- Draped Cloak
	[5411]={b=0,s=0,d=7866},  -- Winterhoof Cleansing Totem
	[5412]={b=0,s=0,d=6492,q=20,x=20},  -- Thresher Eye
	[5413]={b=0,s=0,d=7886,q=20,x=20},  -- Moonstalker Fang
	[5414]={b=0,s=0,d=6683,q=20,x=20},  -- Grizzled Scalp
	[5415]={b=0,s=0,d=7866},  -- Thunderhorn Cleansing Totem
	[5416]={b=0,s=0,d=7866},  -- Wildmane Cleansing Totem
	[5419]={b=68,s=13,d=17002,c=AUCT_CLAS_ARMOR},  -- Feral Bracers
	[5420]={b=1138,s=227,d=8635,c=AUCT_CLAS_ARMOR},  -- Banshee Armor
	[5421]={b=2600,s=650,d=7899},  -- Fiery Enchantment
	[5422]={b=3460,s=692,d=16974,c=AUCT_CLAS_ARMOR},  -- Brambleweed Leggings
	[5423]={b=10421,s=2084,d=19221,c=AUCT_CLAS_WEAPON},  -- Boahn's Fang
	[5424]={b=0,s=0,d=7928},  -- Ancient Statuette
	[5425]={b=2099,s=419,d=7932,c=AUCT_CLAS_ARMOR},  -- Runescale Girdle
	[5426]={b=8431,s=1686,d=19396,c=AUCT_CLAS_WEAPON},  -- Serpent's Kiss
	[5427]={b=590,s=147,d=8118,x=5},  -- Crude Pocket Watch
	[5428]={b=1290,s=322,d=8117,x=5,c=AUCT_CLAS_WRITTEN},  -- An Exotic Cookbook
	[5429]={b=550,s=137,d=8121,x=5},  -- A Pretty Rock
	[5430]={b=1110,s=277,d=8120,x=5,c=AUCT_CLAS_FISHING},  -- Intricate Bauble
	[5431]={b=620,s=155,d=18058,x=5},  -- Empty Hip Flask
	[5432]={b=1320,s=330,d=8114,x=5},  -- Hickory Pipe
	[5433]={b=555,s=138,d=6358,x=5},  -- Rag Doll
	[5435]={b=1090,s=272,d=8115,x=5},  -- Shiny Dinglehopper
	[5437]={b=0,s=0,d=1442,q=20,x=20},  -- Bathran's Hair
	[5439]={b=100,s=25,d=21318,c=AUCT_CLAS_CONTAINER},  -- Small Quiver
	[5440]={b=0,s=0,d=3788},  -- Bottle of Disease
	[5441]={b=1000,s=250,d=1816,c=AUCT_CLAS_CONTAINER},  -- Small Shot Pouch
	[5442]={b=0,s=0,d=7951},  -- Head of Arugal
	[5443]={b=5335,s=1067,d=18523,c=AUCT_CLAS_WEAPON},  -- Gold-plated Buckler
	[5444]={b=2740,s=548,d=15089,c=AUCT_CLAS_ARMOR},  -- Miner's Cape
	[5445]={b=0,s=0,d=9865},  -- Ring of Zoram
	[5446]={b=55,s=13,d=7954,x=20},  -- Broken Elemental Bracer
	[5447]={b=80,s=20,d=7954,x=20},  -- Damaged Elemental Bracer
	[5448]={b=70,s=17,d=7954,x=20},  -- Fractured Elemental Bracer
	[5451]={b=90,s=22,d=7954,x=20},  -- Crushed Elemental Bracer
	[5455]={b=0,s=0,d=7957,c=AUCT_CLAS_WRITTEN},  -- Divined Scroll
	[5456]={b=0,s=0,d=7956},  -- Divining Scroll
	[5457]={b=95,s=23,d=1496,x=10},  -- Severed Voodoo Claw
	[5458]={b=138,s=27,d=9908,c=AUCT_CLAS_ARMOR},  -- Dirtwood Belt
	[5459]={b=2361,s=472,d=7965,c=AUCT_CLAS_WEAPON},  -- Defender Axe
	[5460]={b=0,s=0,d=7976},  -- Orendil's Cure
	[5461]={b=0,s=0,d=9659},  -- Branch of Cenarius
	[5462]={b=0,s=0,d=7982},  -- Dartol's Rod of Transformation
	[5463]={b=0,s=0,d=7984},  -- Glowing Gem
	[5464]={b=0,s=0,d=8033},  -- Iron Shaft
	[5465]={b=12,s=3,d=7345,x=10,u=AUCT_TYPE_COOK},  -- Small Spider Leg
	[5466]={b=32,s=8,d=7987,x=10,u=AUCT_TYPE_COOK},  -- Scorpid Stinger
	[5467]={b=30,s=7,d=6680,x=10,u=AUCT_TYPE_COOK},  -- Kodo Meat
	[5468]={b=48,s=12,d=7988,x=10,u=AUCT_TYPE_COOK},  -- Soft Frenzy Flesh
	[5469]={b=36,s=9,d=1116,x=10,u=AUCT_TYPE_COOK},  -- Strider Meat
	[5470]={b=115,s=28,d=7989,x=10,u=AUCT_TYPE_COOK},  -- Thunder Lizard Tail
	[5471]={b=120,s=30,d=7990,x=10,u=AUCT_TYPE_COOK},  -- Stag Meat
	[5472]={b=40,s=10,d=25473,x=20},  -- Kaldorei Spider Kabob
	[5473]={b=40,s=10,d=7994,x=20,c=AUCT_CLAS_FOOD},  -- Scorpid Surprise
	[5474]={b=36,s=9,d=25481,x=20,c=AUCT_CLAS_FOOD},  -- Roasted Kodo Meat
	[5475]={b=0,s=0,d=8951},  -- Wooden Key
	[5476]={b=12,s=3,d=7996,x=20,c=AUCT_CLAS_FOOD},  -- Fillet of Frenzy
	[5477]={b=74,s=18,d=6406,x=20,c=AUCT_CLAS_FOOD},  -- Strider Stew
	[5478]={b=280,s=70,d=557,x=20,c=AUCT_CLAS_FOOD},  -- Dig Rat Stew
	[5479]={b=500,s=125,d=8088,x=20},  -- Crispy Lizard Tail
	[5480]={b=380,s=95,d=25475,x=20,c=AUCT_CLAS_FOOD},  -- Lean Venison
	[5481]={b=0,s=0,d=7999,q=20,x=20},  -- Satyr Horns
	[5482]={b=40,s=10,d=811},  -- Recipe: Kaldorei Spider Kabob
	[5483]={b=140,s=35,d=811,c=AUCT_CLAS_FOOD},  -- Recipe: Scorpid Surprise
	[5484]={b=240,s=60,d=811,c=AUCT_CLAS_FOOD},  -- Recipe: Roasted Kodo Meat
	[5485]={b=400,s=100,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Fillet of Frenzy
	[5486]={b=440,s=110,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Strider Stew
	[5487]={b=800,s=200,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Dig Rat Stew
	[5488]={b=400,s=100,d=1102},  -- Recipe: Crispy Lizard Tail
	[5489]={b=1200,s=300,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Lean Venison
	[5490]={b=0,s=0,d=8009,q=20,x=20},  -- Wrathtail Head
	[5493]={b=0,s=0,d=13120},  -- Elune's Tear
	[5494]={b=0,s=0,d=8014,q=20,x=20},  -- Handful of Stardust
	[5498]={b=800,s=200,d=12309,x=20,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Small Lustrous Pearl
	[5500]={b=3000,s=750,d=12310,x=20,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Iridescent Pearl
	[5503]={b=65,s=16,d=22193,x=10,u=AUCT_TYPE_COOK},  -- Clam Meat
	[5504]={b=90,s=22,d=22193,x=10,u=AUCT_TYPE_COOK},  -- Tangy Clam Meat
	[5505]={b=0,s=0,d=7152,c=AUCT_CLAS_WRITTEN},  -- Teronis' Journal
	[5506]={b=285,s=71,d=1504,x=5},  -- Beady Eye Stalk
	[5507]={b=2400,s=600,d=7365},  -- Ornate Spyglass
	[5508]={b=0,s=0,d=8025},  -- Fallen Moonstone
	[5509]={b=0,s=0,d=8026,c=AUCT_CLAS_WARLOCK},  -- Healthstone
	[5510]={b=0,s=0,d=8026,c=AUCT_CLAS_WARLOCK},  -- Greater Healthstone
	[5511]={b=0,s=0,d=8026,c=AUCT_CLAS_WARLOCK},  -- Lesser Healthstone
	[5512]={b=0,s=0,d=8026,c=AUCT_CLAS_WARLOCK},  -- Minor Healthstone
	[5513]={b=0,s=0,d=7393,c=AUCT_CLAS_MAGE},  -- Mana Jade
	[5514]={b=0,s=0,d=6851,c=AUCT_CLAS_MAGE},  -- Mana Agate
	[5516]={b=1589,s=317,d=8028,c=AUCT_CLAS_WEAPON},  -- Threshadon Fang
	[5519]={b=0,s=0,d=8032},  -- Iron Pommel
	[5520]={b=0,s=0,d=8040,c=AUCT_CLAS_WRITTEN},  -- Velinde's Journal
	[5521]={b=0,s=0,d=8042},  -- Velinde's Key
	[5522]={b=0,s=0,d=21610,c=AUCT_CLAS_WEAPON},  -- Spellstone
	[5523]={b=60,s=15,d=7177},  -- Small Barnacled Clam
	[5524]={b=85,s=21,d=16212},  -- Thick-shelled Clam
	[5525]={b=80,s=20,d=8048,x=20,c=AUCT_CLAS_FOOD},  -- Boiled Clams
	[5526]={b=300,s=75,d=8049,x=20,c=AUCT_CLAS_FOOD},  -- Clam Chowder
	[5527]={b=380,s=95,d=7177,x=20},  -- Goblin Deviled Clams
	[5528]={b=800,s=200,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Clam Chowder
	[5529]={b=500,s=125,d=6371,x=20},  -- Tomb Dust
	[5530]={b=500,s=125,d=8052,x=20},  -- Blinding Powder
	[5533]={b=0,s=0,d=9129},  -- Ilkrud Magthrull's Tome
	[5534]={b=0,s=0,d=7416},  -- Parker's Lunch
	[5535]={b=0,s=0,d=8093,c=AUCT_CLAS_WRITTEN},  -- Compendium of the Fallen
	[5536]={b=0,s=0,d=8094,c=AUCT_CLAS_WRITTEN},  -- Mythology of the Titans
	[5537]={b=0,s=0,d=3486},  -- Sarilus Foulborne's Head
	[5538]={b=0,s=0,d=8096},  -- Vorrel's Wedding Ring
	[5539]={b=0,s=0,d=8097},  -- Letter of Commendation
	[5540]={b=10539,s=2107,d=6439,c=AUCT_CLAS_WEAPON},  -- Pearl-handled Dagger
	[5541]={b=18469,s=3693,d=19801,c=AUCT_CLAS_WEAPON},  -- Iridescent Hammer
	[5542]={b=1852,s=370,d=23131,c=AUCT_CLAS_ARMOR},  -- Pearl-clasped Cloak
	[5543]={b=1800,s=450,d=15274},  -- Plans: Iridescent Hammer
	[5544]={b=0,s=0,d=7741},  -- Dal Bloodclaw's Skull
	[5547]={b=0,s=0,d=8122},  -- Reconstructed Rod
	[5565]={b=5000,s=1250,d=6504,x=5},  -- Infernal Stone
	[5566]={b=420,s=105,d=8232,x=5},  -- Broken Antler
	[5567]={b=785,s=196,d=8233,x=5},  -- Silver Hook
	[5568]={b=16,s=4,d=5998,x=200,c=AUCT_CLAS_WEAPON},  -- Smooth Pebble
	[5569]={b=815,s=203,d=7415,x=5},  -- Seaweed
	[5570]={b=0,s=0,d=18050,q=20,x=20},  -- Deepmoss Egg
	[5571]={b=1000,s=250,d=1281,c=AUCT_CLAS_CONTAINER},  -- Small Black Pouch
	[5572]={b=1000,s=250,d=1277,c=AUCT_CLAS_CONTAINER},  -- Small Green Pouch
	[5573]={b=3500,s=875,d=3565,c=AUCT_CLAS_CONTAINER},  -- Green Leather Bag
	[5574]={b=3500,s=875,d=8269,c=AUCT_CLAS_CONTAINER},  -- White Leather Bag
	[5575]={b=10000,s=2500,d=3568,c=AUCT_CLAS_CONTAINER},  -- Large Green Sack
	[5576]={b=10000,s=2500,d=1183,c=AUCT_CLAS_CONTAINER},  -- Large Brown Sack
	[5578]={b=1200,s=300,d=15274},  -- Plans: Silvered Bronze Breastplate
	[5579]={b=160,s=32,d=19544,c=AUCT_CLAS_WEAPON},  -- Militia Warhammer
	[5580]={b=128,s=25,d=19777,c=AUCT_CLAS_WEAPON},  -- Militia Hammer
	[5581]={b=161,s=32,d=20446,c=AUCT_CLAS_WEAPON},  -- Smooth Walking Staff
	[5582]={b=0,s=0,d=8283,q=20,x=20},  -- Stonetalon Sap
	[5583]={b=0,s=0,d=8284,q=20,x=20},  -- Fey Dragon Scale
	[5584]={b=0,s=0,d=18096,q=20,x=20},  -- Twilight Whisker
	[5585]={b=0,s=0,d=6492,q=20,x=20},  -- Courser Eye
	[5586]={b=130,s=26,d=1547,c=AUCT_CLAS_WEAPON},  -- Thistlewood Blade
	[5587]={b=2562,s=512,d=19648,c=AUCT_CLAS_WEAPON},  -- Thornroot Club
	[5588]={b=0,s=0,d=7976},  -- Lydon's Toxin
	[5589]={b=206,s=41,d=8292,c=AUCT_CLAS_ARMOR},  -- Moss-covered Gauntlets
	[5590]={b=179,s=35,d=16918,c=AUCT_CLAS_ARMOR},  -- Cord Bracers
	[5591]={b=338,s=67,d=23055,c=AUCT_CLAS_ARMOR},  -- Rain-spotted Cape
	[5592]={b=271,s=54,d=8295,c=AUCT_CLAS_ARMOR},  -- Shackled Girdle
	[5593]={b=582,s=116,d=8296,c=AUCT_CLAS_WEAPON},  -- Crag Buckler
	[5594]={b=0,s=0,d=7649,c=AUCT_CLAS_WRITTEN},  -- Letter to Jin'Zil
	[5595]={b=1177,s=235,d=8298,c=AUCT_CLAS_WEAPON},  -- Thicket Hammer
	[5596]={b=708,s=141,d=20720,c=AUCT_CLAS_WEAPON},  -- Ashwood Bow
	[5601]={b=90,s=22,d=18053,x=10},  -- Hatched Egg Sac
	[5602]={b=255,s=63,d=18597,x=10},  -- Sticky Spider Webbing
	[5604]={b=1901,s=380,d=28159,c=AUCT_CLAS_WEAPON},  -- Elven Wand
	[5605]={b=750,s=150,d=3550,c=AUCT_CLAS_WEAPON},  -- Pruning Knife
	[5606]={b=115,s=23,d=16817,c=AUCT_CLAS_ARMOR},  -- Gardening Gloves
	[5608]={b=17315,s=3463,d=15278,c=AUCT_CLAS_ARMOR},  -- Living Cowl
	[5609]={b=2235,s=447,d=6755,c=AUCT_CLAS_ARMOR},  -- Steadfast Cinch
	[5610]={b=1040,s=208,d=23115,c=AUCT_CLAS_ARMOR},  -- Gustweald Cloak
	[5611]={b=1810,s=452,d=8436,c=AUCT_CLAS_WEAPON},  -- Tear of Grief
	[5612]={b=363,s=72,d=17010,c=AUCT_CLAS_ARMOR},  -- Ivy Cuffs
	[5613]={b=13177,s=2635,d=20384,c=AUCT_CLAS_WEAPON},  -- Staff of the Purifier
	[5614]={b=30735,s=6147,d=20182,c=AUCT_CLAS_WEAPON},  -- Seraph's Strike
	[5615]={b=8883,s=1776,d=20121,c=AUCT_CLAS_WEAPON},  -- Woodsman Sword
	[5616]={b=113690,s=22738,d=20376,c=AUCT_CLAS_WEAPON},  -- Gutwrencher
	[5617]={b=1235,s=247,d=6718,c=AUCT_CLAS_ARMOR},  -- Vagabond Leggings
	[5618]={b=430,s=86,d=15032,c=AUCT_CLAS_ARMOR},  -- Scout's Cloak
	[5619]={b=0,s=0,d=8518},  -- Jade Phial
	[5620]={b=0,s=0,d=7206,q=20,x=20},  -- Vial of Innocent Blood
	[5621]={b=0,s=0,d=8543},  -- Tourmaline Phial
	[5622]={b=2225,s=556,d=14432,c=AUCT_CLAS_ARMOR},  -- Clergy Ring
	[5623]={b=0,s=0,d=8547},  -- Amethyst Phial
	[5624]={b=14634,s=2926,d=15905,c=AUCT_CLAS_ARMOR},  -- Circlet of the Order
	[5626]={b=8587,s=1717,d=19246,c=AUCT_CLAS_WEAPON},  -- Skullchipper
	[5627]={b=6896,s=1379,d=20354,c=AUCT_CLAS_WEAPON},  -- Relic Blade
	[5628]={b=0,s=0,d=6639,c=AUCT_CLAS_WRITTEN},  -- Zamah's Note
	[5629]={b=1736,s=347,d=8450,c=AUCT_CLAS_ARMOR},  -- Hammerfist Gloves
	[5630]={b=1743,s=348,d=8449,c=AUCT_CLAS_ARMOR},  -- Windfelt Gloves
	[5631]={b=120,s=30,d=15741,x=5,c=AUCT_CLAS_POTION},  -- Rage Potion
	[5633]={b=600,s=150,d=15791,x=5,u=AUCT_TYPE_LEATHER},  -- Great Rage Potion
	[5634]={b=300,s=75,d=8453,x=5,c=AUCT_CLAS_POTION},  -- Free Action Potion
	[5635]={b=180,s=45,d=1496,x=5,u=AUCT_TYPE_SMITH},  -- Sharp Claw
	[5636]={b=300,s=75,d=19568,x=10},  -- Delicate Feather
	[5637]={b=300,s=75,d=2460,x=5,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_SMITH},  -- Large Fang
	[5638]={b=0,s=0,d=8471},  -- Toxic Fogger
	[5639]={b=0,s=0,d=8523},  -- Filled Jade Phial
	[5640]={b=100,s=25,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Rage Potion
	[5642]={b=1800,s=450,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Free Action Potion
	[5643]={b=2000,s=500,d=1301,u=AUCT_TYPE_LEATHER},  -- Recipe: Great Rage Potion
	[5645]={b=0,s=0,d=8544},  -- Filled Tourmaline Phial
	[5646]={b=0,s=0,d=21672},  -- Vial of Blessed Water
	[5655]={b=800000,s=0,d=13108},  -- Chestnut Mare Bridle
	[5656]={b=800000,s=0,d=13108},  -- Brown Horse Bridle
	[5659]={b=0,s=0,d=8560,q=20,x=20},  -- Smoldering Embers
	[5664]={b=0,s=0,d=8562,q=20,x=20},  -- Corroded Shrapnel
	[5665]={b=800000,s=0,d=16207},  -- Horn of the Dire Wolf
	[5668]={b=800000,s=0,d=16208},  -- Horn of the Brown Wolf
	[5669]={b=0,s=0,d=2480},  -- Dust Devil Debris
	[5675]={b=0,s=0,d=8564,q=20,x=20},  -- Crystalized Scales
	[5681]={b=0,s=0,d=8283},  -- Corrosive Sap
	[5686]={b=0,s=0,d=7164},  -- Ordanus' Head
	[5687]={b=0,s=0,d=6554},  -- Gatekeeper's Key
	[5689]={b=0,s=0,d=8737},  -- Sleepers' Key
	[5690]={b=0,s=0,d=7737},  -- Claw Key
	[5691]={b=0,s=0,d=8735},  -- Barrow Key
	[5692]={b=0,s=0,d=8622},  -- Remote Detonator (Red)
	[5693]={b=0,s=0,d=8622},  -- Remote Detonator (Blue)
	[5694]={b=0,s=0,d=8625},  -- NG-5 Explosives (Red)
	[5695]={b=0,s=0,d=8625},  -- NG-5 Explosives (Blue)
	[5717]={b=0,s=0,d=8623},  -- Venture Co. Letters
	[5718]={b=0,s=0,d=8624},  -- Venture Co. Engineering Plans
	[5731]={b=0,s=0,d=8626,c=AUCT_CLAS_POTION},  -- Scroll of Messaging
	[5732]={b=0,s=0,d=8627},  -- NG-5
	[5733]={b=0,s=0,d=7340},  -- Unidentified Ore
	[5734]={b=0,s=0,d=8628},  -- Super Reaper 6000 Blueprints
	[5735]={b=0,s=0,d=3411},  -- Sealed Envelope
	[5736]={b=0,s=0,d=8629},  -- Gerenzo's Mechanical Arm
	[5737]={b=0,s=0,d=8630,c=AUCT_CLAS_WRITTEN},  -- Covert Ops Plans: Alpha & Beta
	[5738]={b=0,s=0,d=8631},  -- Covert Ops Pack
	[5739]={b=13694,s=2738,d=12368,c=AUCT_CLAS_ARMOR},  -- Barbaric Harness
	[5740]={b=100,s=25,d=8733,x=5},  -- Red Fireworks Rocket
	[5741]={b=445,s=111,d=4719,x=20},  -- Rock Chip
	[5744]={b=1933,s=386,d=8279,c=AUCT_CLAS_WEAPON},  -- Pale Skinner
	[5749]={b=13321,s=2664,d=19291,c=AUCT_CLAS_WEAPON},  -- Scythe Axe
	[5750]={b=3208,s=641,d=8749,c=AUCT_CLAS_ARMOR},  -- Warchief's Girdle
	[5751]={b=5140,s=1028,d=23078,c=AUCT_CLAS_ARMOR},  -- Webwing Cloak
	[5752]={b=15548,s=3109,d=20596,c=AUCT_CLAS_WEAPON},  -- Wyvern Tailspike
	[5753]={b=9423,s=1884,d=8753,c=AUCT_CLAS_ARMOR},  -- Ruffled Chaplet
	[5754]={b=10155,s=2538,d=7093,c=AUCT_CLAS_ARMOR},  -- Wolfpack Medallion
	[5755]={b=20638,s=4127,d=8719,c=AUCT_CLAS_ARMOR},  -- Onyx Shredder Plate
	[5756]={b=50134,s=10026,d=20591,c=AUCT_CLAS_WEAPON},  -- Sliverblade
	[5757]={b=6816,s=1363,d=8803,c=AUCT_CLAS_WEAPON},  -- Hardwood Cudgel
	[5758]={b=1000,s=250,d=9632},  -- Mithril Lockbox
	[5759]={b=1500,s=375,d=9632},  -- Thorium Lockbox
	[5760]={b=2000,s=500,d=9632},  -- Eternium Lockbox
	[5761]={b=153,s=30,d=19544,c=AUCT_CLAS_WEAPON},  -- Anvilmar Sledge
	[5762]={b=1000,s=250,d=12998,c=AUCT_CLAS_CONTAINER},  -- Red Linen Bag
	[5763]={b=2800,s=700,d=8859,c=AUCT_CLAS_CONTAINER},  -- Red Woolen Bag
	[5764]={b=12000,s=3000,d=8860,c=AUCT_CLAS_CONTAINER},  -- Green Silk Pack
	[5765]={b=16000,s=4000,d=8861,c=AUCT_CLAS_CONTAINER},  -- Black Silk Pack
	[5766]={b=6691,s=1338,d=12397,c=AUCT_CLAS_ARMOR},  -- Lesser Wizard's Robe
	[5767]={b=221,s=44,d=16611,c=AUCT_CLAS_ARMOR},  -- Violet Robes
	[5770]={b=9037,s=1807,d=12695,c=AUCT_CLAS_ARMOR},  -- Robes of Arcana
	[5771]={b=200,s=50,d=1102},  -- Pattern: Red Linen Bag
	[5772]={b=500,s=125,d=1102},  -- Pattern: Red Woolen Bag
	[5773]={b=1000,s=250,d=15274},  -- Pattern: Robes of Arcana
	[5774]={b=1100,s=275,d=15274},  -- Pattern: Green Silk Pack
	[5775]={b=1400,s=350,d=15274},  -- Pattern: Black Silk Pack
	[5776]={b=150,s=30,d=20449,c=AUCT_CLAS_WEAPON},  -- Elder's Cane
	[5777]={b=151,s=30,d=8899,c=AUCT_CLAS_WEAPON},  -- Brave's Axe
	[5778]={b=151,s=30,d=5404,c=AUCT_CLAS_WEAPON},  -- Primitive Walking Stick
	[5779]={b=152,s=30,d=20084,c=AUCT_CLAS_WEAPON},  -- Forsaken Bastard Sword
	[5780]={b=781,s=156,d=8905,c=AUCT_CLAS_ARMOR},  -- Murloc Scale Belt
	[5781]={b=3008,s=601,d=8908,c=AUCT_CLAS_ARMOR},  -- Murloc Scale Breastplate
	[5782]={b=16055,s=3211,d=22393,c=AUCT_CLAS_ARMOR},  -- Thick Murloc Armor
	[5783]={b=11581,s=2316,d=8912,c=AUCT_CLAS_ARMOR},  -- Murloc Scale Bracers
	[5784]={b=300,s=75,d=8913,x=10,u=AUCT_TYPE_LEATHER},  -- Slimy Murloc Scale
	[5785]={b=2000,s=500,d=8914,x=10,u=AUCT_TYPE_LEATHER},  -- Thick Murloc Scale
	[5786]={b=550,s=137,d=1102},  -- Pattern: Murloc Scale Belt
	[5787]={b=600,s=150,d=1102},  -- Pattern: Murloc Scale Breastplate
	[5788]={b=650,s=162,d=1102},  -- Pattern: Thick Murloc Armor
	[5789]={b=2800,s=700,d=1102},  -- Pattern: Murloc Scale Bracers
	[5790]={b=0,s=0,d=8040,c=AUCT_CLAS_WRITTEN},  -- Lonebrow's Journal
	[5791]={b=0,s=0,d=8040,c=AUCT_CLAS_QUEST},  -- Henrig Lonebrow's Journal
	[5792]={b=0,s=0,d=8918},  -- Razorflank's Medallion
	[5793]={b=0,s=0,d=8917},  -- Razorflank's Heart
	[5794]={b=0,s=0,d=8922,q=20,x=20},  -- Salty Scorpid Venom
	[5795]={b=0,s=0,d=8923,q=20,x=20},  -- Hardened Tortoise Shell
	[5796]={b=0,s=0,d=10043,q=20,x=20},  -- Encrusted Tail Fin
	[5797]={b=0,s=0,d=9110,q=20,x=20},  -- Indurium Flake
	[5798]={b=0,s=0,d=8926,q=20,x=20},  -- Rocket Car Parts
	[5799]={b=0,s=0,d=8927,c=AUCT_CLAS_WRITTEN},  -- Kravel's Parts Order
	[5800]={b=0,s=0,d=8928},  -- Kravel's Parts
	[5801]={b=0,s=0,d=13715,q=20,x=20},  -- Kraul Guano
	[5802]={b=0,s=0,d=8931},  -- Delicate Car Parts
	[5803]={b=0,s=0,d=8932,q=20,x=20,u=AUCT_TYPE_ENCHANT},  -- Speck of Dream Dust
	[5804]={b=0,s=0,d=4435,c=AUCT_CLAS_WRITTEN},  -- Goblin Rumors
	[5805]={b=0,s=0,d=4045,q=20,x=20},  -- Heart of Zeal
	[5806]={b=0,s=0,d=8935},  -- Fool's Stout
	[5807]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Fool's Stout Report
	[5808]={b=0,s=0,d=8940,q=20,x=20},  -- Pridewing Venom Sac
	[5809]={b=0,s=0,d=8940,q=20,x=20},  -- Highperch Venom Sac
	[5810]={b=0,s=0,d=8942},  -- Fresh Carcass
	[5811]={b=0,s=0,d=8952},  -- Frostmaw's Mane
	[5812]={b=5645,s=1129,d=12694,c=AUCT_CLAS_ARMOR},  -- Robes of Antiquity
	[5813]={b=35439,s=7087,d=9055,c=AUCT_CLAS_WEAPON},  -- Emil's Brand
	[5814]={b=11756,s=2351,d=16899,c=AUCT_CLAS_ARMOR},  -- Snapbrook Armor
	[5815]={b=29355,s=5871,d=9057,c=AUCT_CLAS_WEAPON},  -- Glacial Stone
	[5816]={b=1620,s=405,d=9058},  -- Light of Elune
	[5817]={b=16134,s=3226,d=9060,c=AUCT_CLAS_WEAPON},  -- Lunaris Bow
	[5818]={b=16196,s=3239,d=21026,c=AUCT_CLAS_WEAPON},  -- Moonbeam Wand
	[5819]={b=16009,s=3201,d=15810,c=AUCT_CLAS_ARMOR},  -- Sunblaze Coif
	[5820]={b=8114,s=1622,d=9077,c=AUCT_CLAS_ARMOR},  -- Faerie Mantle
	[5824]={b=0,s=0,d=9106},  -- Tablet of Will
	[5825]={b=0,s=0,d=9305},  -- Treshala's Pendant
	[5826]={b=0,s=0,d=7629,c=AUCT_CLAS_WRITTEN},  -- Kravel's Scheme
	[5827]={b=0,s=0,d=4435,c=AUCT_CLAS_WRITTEN},  -- Fizzle Brassbolts' Letter
	[5829]={b=3216,s=804,d=6633,x=5},  -- Razor-sharp Beak
	[5830]={b=0,s=0,d=15706},  -- Kenata's Head
	[5831]={b=0,s=0,d=7038},  -- Fardel's Head
	[5832]={b=0,s=0,d=7038},  -- Marcel's Head
	[5833]={b=0,s=0,d=9116,q=20,x=20},  -- Indurium Ore
	[5834]={b=0,s=0,d=9124},  -- Mok'Morokk's Snuff
	[5835]={b=0,s=0,d=18078},  -- Mok'Morokk's Grog
	[5836]={b=0,s=0,d=12644},  -- Mok'Morokk's Strongbox
	[5837]={b=0,s=0,d=9134},  -- Steelsnap's Rib
	[5838]={b=0,s=0,d=9144,c=AUCT_CLAS_WRITTEN},  -- Kodo Skin Scroll
	[5839]={b=4,s=1,d=9135,c=AUCT_CLAS_WRITTEN},  -- Journal Page
	[5840]={b=0,s=0,d=20952,q=20,x=20},  -- Searing Tongue
	[5841]={b=0,s=0,d=3422,q=20,x=20},  -- Searing Heart
	[5842]={b=0,s=0,d=18107},  -- Unrefined Ore Sample
	[5843]={b=0,s=0,d=3596},  -- Grenka's Claw
	[5844]={b=0,s=0,d=9147},  -- Fragments of Rok'Alim
	[5846]={b=0,s=0,d=9148},  -- Korran's Sealed Note
	[5847]={b=0,s=0,d=9150,q=20,x=20},  -- Mirefin Head
	[5848]={b=0,s=0,d=7126,q=20,x=20},  -- Hollow Vulture Bone
	[5849]={b=0,s=0,d=9151},  -- Crate of Crash Helmets
	[5850]={b=0,s=0,d=9152},  -- Belgrom's Sealed Note
	[5851]={b=0,s=0,d=9154},  -- Cozzle's Key
	[5852]={b=0,s=0,d=9155},  -- Fuel Regulator Blueprints
	[5853]={b=0,s=0,d=9158,q=20,x=20},  -- Intact Silithid Carapace
	[5854]={b=0,s=0,d=9157,q=20,x=20},  -- Silithid Talon
	[5855]={b=0,s=0,d=4045,q=20,x=20},  -- Silithid Heart
	[5860]={b=0,s=0,d=9164,c=AUCT_CLAS_WRITTEN},  -- Legacy of the Aspects
	[5861]={b=0,s=0,d=9165,c=AUCT_CLAS_WRITTEN},  -- Beginnings of the Undead Threat
	[5862]={b=0,s=0,d=9166},  -- Seaforium Booster
	[5863]={b=0,s=0,d=16161},  -- Guild Charter
	[5864]={b=800000,s=0,d=17343},  -- Gray Ram
	[5865]={b=0,s=0,d=9166},  -- Modified Seaforium Booster
	[5866]={b=0,s=0,d=9116},  -- Sample of Indurium Ore
	[5867]={b=0,s=0,d=9208},  -- Etched Phial
	[5868]={b=0,s=0,d=9207},  -- Filled Etched Phial
	[5869]={b=0,s=0,d=9209},  -- Cloven Hoof
	[5871]={b=1275,s=318,d=7296,x=5},  -- Large Hoof
	[5872]={b=800000,s=0,d=17343},  -- Brown Ram
	[5873]={b=800000,s=0,d=17343},  -- White Ram
	[5876]={b=0,s=0,d=6624,q=20,x=20},  -- Blueleaf Tuber
	[5877]={b=0,s=0,d=9284,c=AUCT_CLAS_QUEST},  -- Cracked Silithid Carapace
	[5879]={b=0,s=0,d=9285,q=20,x=20},  -- Twilight Pendant
	[5880]={b=0,s=0,d=9288},  -- Crate With Holes
	[5881]={b=0,s=0,d=9289},  -- Head of Kelris
	[5882]={b=0,s=0,d=9467,c=AUCT_CLAS_WRITTEN},  -- Captain's Documents
	[5883]={b=0,s=0,d=9291,q=20,x=20},  -- Forked Mudrock Tongue
	[5884]={b=0,s=0,d=9292,q=20,x=20},  -- Unpopped Darkmist Eye
	[5897]={b=0,s=0,d=9319,c=AUCT_CLAS_WRITTEN},  -- Snufflenose Owner's Manual
	[5917]={b=0,s=0,d=811,c=AUCT_CLAS_WRITTEN},  -- Spy's Report
	[5918]={b=0,s=0,d=3914},  -- Defiant Orc Head
	[5919]={b=0,s=0,d=9354},  -- Blackened Iron Shield
	[5936]={b=99,s=19,d=9365,c=AUCT_CLAS_ARMOR},  -- Animal Skin Belt
	[5938]={b=0,s=0,d=7345,q=20,x=20},  -- Pristine Crawler Leg
	[5939]={b=100,s=20,d=9374,c=AUCT_CLAS_ARMOR},  -- Sewing Gloves
	[5940]={b=769,s=153,d=2916,c=AUCT_CLAS_WEAPON},  -- Bone Buckler
	[5941]={b=578,s=115,d=4339,c=AUCT_CLAS_ARMOR},  -- Brass Scale Pants
	[5942]={b=0,s=0,d=9377},  -- Jeweled Pendant
	[5943]={b=4202,s=840,d=9378,c=AUCT_CLAS_ARMOR},  -- Rift Bracers
	[5944]={b=1655,s=331,d=7554,c=AUCT_CLAS_ARMOR},  -- Greaves of the People's Militia
	[5945]={b=0,s=0,d=9396},  -- Deadmire's Tooth
	[5946]={b=0,s=0,d=9148},  -- Sealed Note to Elling
	[5947]={b=0,s=0,d=9397,c=AUCT_CLAS_WRITTEN},  -- Defias Docket
	[5948]={b=0,s=0,d=9148,c=AUCT_CLAS_WRITTEN},  -- Letter to Jorgen
	[5950]={b=0,s=0,d=9429},  -- Reethe's Badge
	[5951]={b=165,s=41,d=9430,x=10},  -- Moist Towelette
	[5952]={b=0,s=0,d=13531,q=20,x=20},  -- Corrupted Brain Stem
	[5956]={b=84,s=16,d=8568,c=AUCT_CLAS_WEAPON},  -- Blacksmith's Hammer
	[5957]={b=200,s=40,d=9499,c=AUCT_CLAS_ARMOR},  -- Handstitched Leather Vest
	[5958]={b=4145,s=829,d=9514,c=AUCT_CLAS_ARMOR},  -- Fine Leather Pants
	[5959]={b=0,s=0,d=2885,q=20,x=20},  -- Acidic Venom Sac
	[5960]={b=0,s=0,d=9152},  -- Sealed Note to Watcher Backus
	[5961]={b=5446,s=1089,d=12402,c=AUCT_CLAS_ARMOR},  -- Dark Leather Pants
	[5962]={b=13972,s=2794,d=9535,c=AUCT_CLAS_ARMOR},  -- Guardian Pants
	[5963]={b=15756,s=3151,d=17212,c=AUCT_CLAS_ARMOR},  -- Barbaric Leggings
	[5964]={b=13049,s=2609,d=9544,c=AUCT_CLAS_ARMOR},  -- Barbaric Shoulders
	[5965]={b=12680,s=2536,d=23033,c=AUCT_CLAS_ARMOR},  -- Guardian Cloak
	[5966]={b=6873,s=1374,d=9549,c=AUCT_CLAS_ARMOR},  -- Guardian Gloves
	[5967]={b=1045,s=209,d=9552,c=AUCT_CLAS_ARMOR},  -- Girdle of Nobility
	[5969]={b=3908,s=781,d=23059,c=AUCT_CLAS_ARMOR},  -- Regent's Cloak
	[5970]={b=2092,s=418,d=19128,c=AUCT_CLAS_ARMOR},  -- Serpent Gloves
	[5971]={b=5681,s=1136,d=23026,c=AUCT_CLAS_ARMOR},  -- Feathered Cape
	[5972]={b=1500,s=375,d=15274},  -- Pattern: Fine Leather Pants
	[5973]={b=650,s=162,d=1102},  -- Pattern: Barbaric Leggings
	[5974]={b=1400,s=350,d=15274},  -- Pattern: Guardian Cloak
	[5975]={b=2664,s=532,d=9584,c=AUCT_CLAS_ARMOR},  -- Ruffian Belt
	[5976]={b=10000,s=2500,d=20621,c=AUCT_CLAS_ARMOR},  -- Guild Tabard
	[5996]={b=380,s=95,d=4836,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Water Breathing
	[5997]={b=20,s=5,d=15732,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Minor Defense
	[5998]={b=0,s=0,d=4435,c=AUCT_CLAS_WRITTEN},  -- Stormpike's Request
	[6016]={b=0,s=0,d=4045},  -- Wolf Heart Sample
	[6037]={b=5000,s=1250,d=20656,x=20,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Truesilver Bar
	[6038]={b=1250,s=312,d=9633,x=20,c=AUCT_CLAS_FOOD},  -- Giant Clam Scorcho
	[6039]={b=5000,s=1250,d=1301,c=AUCT_CLAS_FOOD},  -- Recipe: Giant Clam Scorcho
	[6040]={b=8247,s=1649,d=9634,c=AUCT_CLAS_ARMOR},  -- Golden Scale Bracers
	[6041]={b=6000,s=1500,d=9635,x=5},  -- Steel Weapon Chain
	[6042]={b=1000,s=250,d=9637,x=5},  -- Iron Shield Spike
	[6043]={b=2000,s=500,d=7261,x=5},  -- Iron Counterweight
	[6044]={b=1800,s=450,d=15274},  -- Plans: Iron Shield Spike
	[6045]={b=2600,s=650,d=15274},  -- Plans: Iron Counterweight
	[6046]={b=3800,s=950,d=15274},  -- Plans: Steel Weapon Chain
	[6047]={b=4400,s=1100,d=1102},  -- Plans: Golden Scale Coif
	[6048]={b=400,s=100,d=15774,x=5,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_TAILOR},  -- Shadow Protection Potion
	[6049]={b=680,s=170,d=9639,x=5,c=AUCT_CLAS_POTION},  -- Fire Protection Potion
	[6050]={b=1200,s=300,d=9058,x=5,c=AUCT_CLAS_POTION},  -- Frost Protection Potion
	[6051]={b=250,s=62,d=15747,x=5,c=AUCT_CLAS_POTION},  -- Holy Protection Potion
	[6052]={b=1200,s=300,d=4135,x=5,c=AUCT_CLAS_POTION},  -- Nature Protection Potion
	[6053]={b=800,s=200,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Holy Protection Potion
	[6054]={b=900,s=225,d=1301,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_TAILOR},  -- Recipe: Shadow Protection Potion
	[6055]={b=1500,s=375,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Fire Protection Potion
	[6056]={b=2000,s=500,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Frost Protection Potion
	[6057]={b=2000,s=500,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Nature Protection Potion
	[6058]={b=32,s=6,d=8419,c=AUCT_CLAS_ARMOR},  -- Blackened Leather Belt
	[6059]={b=65,s=13,d=9930,c=AUCT_CLAS_ARMOR},  -- Nomadic Vest
	[6060]={b=24,s=4,d=16588,c=AUCT_CLAS_ARMOR},  -- Flax Bracers
	[6061]={b=116,s=23,d=9644,c=AUCT_CLAS_ARMOR},  -- Graystone Bracers
	[6062]={b=142,s=28,d=16805,c=AUCT_CLAS_ARMOR},  -- Heavy Cord Bracers
	[6063]={b=117,s=23,d=6954,c=AUCT_CLAS_ARMOR},  -- Cold Steel Gauntlets
	[6064]={b=0,s=0,d=16265},  -- Miniature Platinum Discs
	[6065]={b=0,s=0,d=9663},  -- Khadgar's Essays on Dimensional Convergence
	[6066]={b=0,s=0,d=9666},  -- Khan Dez'hepah's Head
	[6067]={b=0,s=0,d=9668,q=20,x=20},  -- Centaur Ear
	[6068]={b=1500,s=375,d=1301,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Recipe: Shadow Oil
	[6069]={b=0,s=0,d=7407,q=20,x=20},  -- Crudely Dried Meat
	[6070]={b=31,s=6,d=17173,c=AUCT_CLAS_ARMOR},  -- Wolfskin Bracers
	[6071]={b=0,s=0,d=6563,q=20,x=20},  -- Draenethyst Crystal
	[6072]={b=0,s=0,d=9666},  -- Khan Jehn's Head
	[6073]={b=0,s=0,d=9666},  -- Khan Shaka's Head
	[6074]={b=0,s=0,d=9711},  -- War Horn Mouthpiece
	[6076]={b=47,s=9,d=16843,c=AUCT_CLAS_ARMOR},  -- Tapered Pants
	[6077]={b=0,s=0,d=9728},  -- Maraudine Key Fragment
	[6078]={b=78,s=15,d=18664,c=AUCT_CLAS_WEAPON},  -- Pikeman Shield
	[6079]={b=0,s=0,d=9730,q=20,x=20},  -- Crude Charm
	[6080]={b=0,s=0,d=8917,q=20,x=20},  -- Shadow Panther Heart
	[6081]={b=0,s=0,d=9733},  -- Mire Lord Fungus
	[6082]={b=0,s=0,d=9734},  -- Deepstrider Tumor
	[6083]={b=0,s=0,d=9737,q=20,x=20},  -- Broken Tears
	[6084]={b=1454,s=290,d=9738,c=AUCT_CLAS_ARMOR},  -- Stormwind Guard Leggings
	[6085]={b=1217,s=243,d=11368,c=AUCT_CLAS_ARMOR},  -- Footman Tunic
	[6087]={b=8639,s=1727,d=9742,c=AUCT_CLAS_ARMOR},  -- Chausses of Westfall
	[6091]={b=0,s=0,d=9822},  -- Crate of Power Stones
	[6092]={b=2104,s=420,d=16981,c=AUCT_CLAS_ARMOR},  -- Black Whelp Boots
	[6093]={b=22091,s=4418,d=19646,c=AUCT_CLAS_WEAPON},  -- Orc Crusher
	[6094]={b=6393,s=1278,d=19390,c=AUCT_CLAS_WEAPON},  -- Piercing Axe
	[6095]={b=3440,s=688,d=11548,c=AUCT_CLAS_ARMOR},  -- Wandering Boots
	[6096]={b=1,s=1,d=2163,c=AUCT_CLAS_ARMOR},  -- Apprentice's Shirt
	[6097]={b=1,s=1,d=2470,c=AUCT_CLAS_ARMOR},  -- Acolyte's Shirt
	[6098]={b=4,s=1,d=12679,c=AUCT_CLAS_ARMOR},  -- Neophyte's Robe
	[6117]={b=1,s=1,d=9972,c=AUCT_CLAS_ARMOR},  -- Squire's Shirt
	[6118]={b=4,s=1,d=9974,c=AUCT_CLAS_ARMOR},  -- Squire's Pants
	[6119]={b=4,s=1,d=12681,c=AUCT_CLAS_ARMOR},  -- Neophyte's Robe
	[6120]={b=1,s=1,d=9983,c=AUCT_CLAS_ARMOR},  -- Recruit's Shirt
	[6121]={b=4,s=1,d=9984,c=AUCT_CLAS_ARMOR},  -- Recruit's Pants
	[6122]={b=4,s=1,d=9985,c=AUCT_CLAS_ARMOR},  -- Recruit's Boots
	[6123]={b=4,s=1,d=12683,c=AUCT_CLAS_ARMOR},  -- Novice's Robe
	[6124]={b=5,s=1,d=9987,c=AUCT_CLAS_ARMOR},  -- Novice's Pants
	[6125]={b=1,s=1,d=9995,c=AUCT_CLAS_ARMOR},  -- Brawler's Harness
	[6126]={b=5,s=1,d=10002,c=AUCT_CLAS_ARMOR},  -- Trapper's Pants
	[6127]={b=5,s=1,d=10003,c=AUCT_CLAS_ARMOR},  -- Trapper's Boots
	[6129]={b=5,s=1,d=12646,c=AUCT_CLAS_ARMOR},  -- Acolyte's Robe
	[6134]={b=1,s=1,d=10108,c=AUCT_CLAS_ARMOR},  -- Primitive Mantle
	[6135]={b=5,s=1,d=10109,c=AUCT_CLAS_ARMOR},  -- Primitive Kilt
	[6136]={b=4,s=1,d=10112,c=AUCT_CLAS_ARMOR},  -- Thug Shirt
	[6137]={b=4,s=1,d=10114,c=AUCT_CLAS_ARMOR},  -- Thug Pants
	[6138]={b=4,s=1,d=10115,c=AUCT_CLAS_ARMOR},  -- Thug Boots
	[6139]={b=4,s=1,d=12684,c=AUCT_CLAS_ARMOR},  -- Novice's Robe
	[6140]={b=4,s=1,d=12649,c=AUCT_CLAS_ARMOR},  -- Apprentice's Robe
	[6144]={b=5,s=1,d=12680,c=AUCT_CLAS_ARMOR},  -- Neophyte's Robe
	[6145]={b=0,s=0,d=7570},  -- Clarice's Pendant
	[6146]={b=0,s=0,d=10190,q=20,x=20},  -- Sundried Driftwood
	[6147]={b=185,s=37,d=9508,c=AUCT_CLAS_ARMOR},  -- Ratty Old Belt
	[6148]={b=223,s=44,d=16853,c=AUCT_CLAS_ARMOR},  -- Web-covered Boots
	[6149]={b=480,s=120,d=15718,x=5,u=AUCT_TYPE_TAILOR},  -- Greater Mana Potion
	[6150]={b=90,s=22,d=10301,x=20},  -- A Frayed Knot
	[6166]={b=0,s=0,d=10345,q=20,x=20},  -- Coyote Jawbone
	[6167]={b=0,s=0,d=6423,c=AUCT_CLAS_WRITTEN},  -- Neeka's Report
	[6168]={b=0,s=0,d=9157,q=20,x=20},  -- Sawtooth Snapper Claw
	[6169]={b=0,s=0,d=6678,q=20,x=20},  -- Unprepared Sawtooth Flank
	[6170]={b=0,s=0,d=10353},  -- Wizards' Reagents
	[6171]={b=32,s=6,d=9374,c=AUCT_CLAS_ARMOR},  -- Wolf Handler Gloves
	[6172]={b=0,s=0,d=12927,c=AUCT_CLAS_QUEST},  -- Lost Supplies
	[6173]={b=36,s=7,d=16809,c=AUCT_CLAS_ARMOR},  -- Snow Boots
	[6175]={b=0,s=0,d=10365,q=20,x=20},  -- Atal'ai Artifact
	[6176]={b=79,s=15,d=3725,c=AUCT_CLAS_WEAPON},  -- Dwarven Kite Shield
	[6177]={b=348,s=69,d=6934,c=AUCT_CLAS_ARMOR},  -- Ironwrought Bracers
	[6178]={b=0,s=0,d=8928},  -- Shipment to Nethergarde
	[6179]={b=2782,s=556,d=15166,c=AUCT_CLAS_ARMOR},  -- Privateer's Cape
	[6180]={b=2119,s=423,d=11563,c=AUCT_CLAS_ARMOR},  -- Slarkskin
	[6181]={b=0,s=0,d=4262,q=20,x=20},  -- Fetish of Hakkar
	[6184]={b=0,s=0,d=10399,q=20,x=20},  -- Monstrous Crawler Leg
	[6185]={b=47,s=9,d=23008,c=AUCT_CLAS_ARMOR},  -- Bear Shawl
	[6186]={b=6864,s=1372,d=20119,c=AUCT_CLAS_WEAPON},  -- Trogg Slicer
	[6187]={b=3066,s=613,d=18658,c=AUCT_CLAS_WEAPON},  -- Dwarven Defender
	[6188]={b=1525,s=305,d=10434,c=AUCT_CLAS_ARMOR},  -- Mud Stompers
	[6189]={b=3122,s=624,d=10448,c=AUCT_CLAS_ARMOR},  -- Durable Chain Shoulders
	[6190]={b=0,s=0,d=10449},  -- Draenethyst Shard
	[6191]={b=3079,s=615,d=10454,c=AUCT_CLAS_ARMOR},  -- Kimbra Boots
	[6193]={b=0,s=0,d=10481},  -- Bundle of Atal'ai Artifacts
	[6194]={b=26543,s=5308,d=19404,c=AUCT_CLAS_WEAPON},  -- Barreling Reaper
	[6195]={b=2080,s=416,d=12944,c=AUCT_CLAS_ARMOR},  -- Wax-polished Armor
	[6196]={b=0,s=0,d=6794,c=AUCT_CLAS_QUEST},  -- Noboru's Cudgel
	[6197]={b=4646,s=929,d=2644,c=AUCT_CLAS_ARMOR},  -- Loch Croc Hide Vest
	[6198]={b=5566,s=1113,d=10529,c=AUCT_CLAS_ARMOR},  -- Jurassic Wristguards
	[6199]={b=2600,s=650,d=10530,c=AUCT_CLAS_ARMOR},  -- Black Widow Band
	[6200]={b=6117,s=1223,d=10532,c=AUCT_CLAS_ARMOR},  -- Garneg's War Belt
	[6201]={b=272,s=54,d=9510,c=AUCT_CLAS_ARMOR},  -- Lithe Boots
	[6202]={b=179,s=35,d=10535,c=AUCT_CLAS_ARMOR},  -- Fingerless Gloves
	[6203]={b=608,s=121,d=18669,c=AUCT_CLAS_WEAPON},  -- Thuggish Shield
	[6204]={b=10327,s=2065,d=13266,c=AUCT_CLAS_ARMOR},  -- Tribal Worg Helm
	[6205]={b=4613,s=922,d=7495,c=AUCT_CLAS_WEAPON},  -- Burrowing Shovel
	[6206]={b=2777,s=555,d=14040,c=AUCT_CLAS_WEAPON},  -- Rock Chipper
	[6211]={b=1800,s=450,d=1301},  -- Recipe: Elixir of Ogre's Strength
	[6212]={b=0,s=0,d=10546},  -- Head of Jammal'an
	[6214]={b=2978,s=595,d=10642,c=AUCT_CLAS_WEAPON},  -- Heavy Copper Maul
	[6215]={b=3009,s=601,d=10654,c=AUCT_CLAS_WEAPON},  -- Balanced Fighting Stick
	[6217]={b=124,s=24,d=21205,u=AUCT_TYPE_ENCHANT},  -- Copper Rod
	[6218]={b=124,s=24,d=21207,u=AUCT_TYPE_ENCHANT},  -- Runed Copper Rod
	[6219]={b=721,s=144,d=7494,c=AUCT_CLAS_WEAPON},  -- Arclight Spanner
	[6220]={b=24468,s=4893,d=20536,c=AUCT_CLAS_WEAPON},  -- Meteor Shard
	[6223]={b=23986,s=4797,d=10721,c=AUCT_CLAS_WEAPON},  -- Crest of Darkshire
	[6226]={b=4452,s=890,d=12652,c=AUCT_CLAS_ARMOR},  -- Bloody Apron
	[6238]={b=491,s=98,d=12389,c=AUCT_CLAS_ARMOR},  -- Brown Linen Robe
	[6239]={b=802,s=160,d=12400,c=AUCT_CLAS_ARMOR},  -- Red Linen Vest
	[6240]={b=805,s=161,d=12387,c=AUCT_CLAS_ARMOR},  -- Blue Linen Vest
	[6241]={b=496,s=99,d=17123,c=AUCT_CLAS_ARMOR},  -- White Linen Robe
	[6242]={b=1217,s=243,d=12386,c=AUCT_CLAS_ARMOR},  -- Blue Linen Robe
	[6245]={b=0,s=0,d=7289},  -- Karnitol's Satchel
	[6246]={b=0,s=0,d=10920,q=20,x=20},  -- Hatefury Claw
	[6247]={b=0,s=0,d=10921,q=20,x=20},  -- Hatefury Horn
	[6248]={b=0,s=0,d=6400,q=20,x=20},  -- Scorpashi Venom
	[6249]={b=0,s=0,d=10922,q=20,x=20},  -- Aged Kodo Hide
	[6250]={b=0,s=0,d=10923,q=20,x=20},  -- Felhound Brain
	[6251]={b=0,s=0,d=3124,q=20,x=20},  -- Nether Wing
	[6252]={b=0,s=0,d=6400,q=20,x=20},  -- Doomwarder Blood
	[6253]={b=0,s=0,d=10924},  -- Leftwitch's Package
	[6256]={b=23,s=4,d=20730,c=AUCT_CLAS_FISHING},  -- Fishing Pole
	[6257]={b=0,s=0,d=11012,q=20,x=20},  -- Roc Gizzard
	[6258]={b=0,s=0,d=6427,q=20,x=20},  -- Ironfur Liver
	[6259]={b=0,s=0,d=4045,q=20,x=20},  -- Groddoc Liver
	[6260]={b=50,s=12,d=1656,x=10,u=AUCT_TYPE_TAILOR},  -- Blue Dye
	[6261]={b=1000,s=250,d=15736,x=10,u=AUCT_TYPE_TAILOR},  -- Orange Dye
	[6263]={b=2947,s=589,d=11182,c=AUCT_CLAS_ARMOR},  -- Blue Overalls
	[6264]={b=4420,s=884,d=12716,c=AUCT_CLAS_ARMOR},  -- Greater Adept's Robe
	[6265]={b=0,s=0,d=6689,c=AUCT_CLAS_WARLOCK},  -- Soul Shard
	[6266]={b=1028,s=205,d=16560,c=AUCT_CLAS_ARMOR},  -- Disciple's Vest
	[6267]={b=747,s=149,d=16561,c=AUCT_CLAS_ARMOR},  -- Disciple's Pants
	[6268]={b=1171,s=234,d=17098,c=AUCT_CLAS_ARMOR},  -- Pioneer Tunic
	[6269]={b=966,s=193,d=17152,c=AUCT_CLAS_ARMOR},  -- Pioneer Trousers
	[6270]={b=200,s=50,d=1102},  -- Pattern: Blue Linen Vest
	[6271]={b=200,s=50,d=15274},  -- Pattern: Red Linen Vest
	[6272]={b=300,s=75,d=1102},  -- Pattern: Blue Linen Robe
	[6274]={b=400,s=100,d=1102},  -- Pattern: Blue Overalls
	[6275]={b=800,s=200,d=1102},  -- Pattern: Greater Adept's Robe
	[6281]={b=0,s=0,d=4262,q=20,x=20},  -- Rattlecage Skull
	[6282]={b=11219,s=2243,d=11166,c=AUCT_CLAS_ARMOR},  -- Sacred Burial Trousers
	[6283]={b=0,s=0,d=2757,c=AUCT_CLAS_WRITTEN},  -- The Book of Ur
	[6284]={b=0,s=0,d=11180},  -- Runes of Summoning
	[6285]={b=0,s=0,d=11181},  -- Egalin's Grimoire
	[6286]={b=0,s=0,d=6694},  -- Pure Hearts
	[6287]={b=0,s=0,d=11183},  -- Atal'ai Tablet Fragment
	[6288]={b=0,s=0,d=11185,q=20,x=20},  -- Atal'ai Tablet
	[6289]={b=20,s=1,d=24702,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Longjaw Mud Snapper
	[6290]={b=25,s=1,d=18536,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Brilliant Smallfish
	[6291]={b=20,s=1,d=18535,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Brilliant Smallfish
	[6292]={b=34,s=8,d=24701,c=AUCT_CLAS_FOOD},  -- 10 Pound Mud Snapper
	[6293]={b=135,s=33,d=11199,x=10},  -- Dried Bat Blood
	[6294]={b=40,s=10,d=24701,c=AUCT_CLAS_FOOD},  -- 12 Pound Mud Snapper
	[6295]={b=48,s=12,d=24701,c=AUCT_CLAS_FOOD},  -- 15 Pound Mud Snapper
	[6296]={b=115,s=28,d=6691,x=10},  -- Patch of Bat Hair
	[6297]={b=30,s=7,d=7741,x=10},  -- Old Skull
	[6298]={b=520,s=130,d=6666,x=20},  -- Bloody Bat Fang
	[6299]={b=25,s=1,d=24696,q=20,x=20},  -- Sickly Looking Fish
	[6300]={b=1775,s=443,d=6628,x=10},  -- Husk Fragment
	[6301]={b=80,s=20,d=6375},  -- Old Teamster's Skull
	[6302]={b=2515,s=628,d=4433,x=5},  -- Delicate Insect Wing
	[6303]={b=20,s=1,d=24697,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Slitherskin Mackerel
	[6304]={b=100,s=25,d=7629,c=AUCT_CLAS_WRITTEN},  -- Damp Diary Page (Day 4)
	[6305]={b=100,s=25,d=7629,c=AUCT_CLAS_WRITTEN},  -- Damp Diary Page (Day 87)
	[6306]={b=100,s=25,d=7629,c=AUCT_CLAS_WRITTEN},  -- Damp Diary Page (Day 512)
	[6307]={b=4,s=1,d=18113},  -- Message in a Bottle
	[6308]={b=40,s=2,d=24710,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Bristle Whisker Catfish
	[6309]={b=400,s=100,d=24712,c=AUCT_CLAS_WEAPON},  -- 17 Pound Catfish
	[6310]={b=600,s=150,d=24712,c=AUCT_CLAS_WEAPON},  -- 19 Pound Catfish
	[6311]={b=750,s=187,d=24712,c=AUCT_CLAS_WEAPON},  -- 22 Pound Catfish
	[6312]={b=0,s=0,d=3422},  -- Dalin's Heart
	[6313]={b=0,s=0,d=3422},  -- Comar's Heart
	[6314]={b=6343,s=1268,d=23082,c=AUCT_CLAS_ARMOR},  -- Wolfmaster Cape
	[6315]={b=12733,s=2546,d=11247,c=AUCT_CLAS_WEAPON},  -- Steelarrow Crossbow
	[6316]={b=60,s=3,d=11268,q=20,x=20},  -- Loch Frenzy Delight
	[6317]={b=40,s=2,d=4813,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Loch Frenzy
	[6318]={b=24014,s=4802,d=20335,c=AUCT_CLAS_WEAPON},  -- Odo's Ley Staff
	[6319]={b=4016,s=803,d=11253,c=AUCT_CLAS_ARMOR},  -- Girdle of the Blindwatcher
	[6320]={b=13556,s=2711,d=18700,c=AUCT_CLAS_WEAPON},  -- Commander's Crest
	[6321]={b=6600,s=1650,d=14433,c=AUCT_CLAS_ARMOR},  -- Silverlaine's Family Seal
	[6323]={b=13058,s=2611,d=21051,c=AUCT_CLAS_WEAPON},  -- Baron's Scepter
	[6324]={b=9463,s=1892,d=12696,c=AUCT_CLAS_ARMOR},  -- Robes of Arugal
	[6325]={b=40,s=10,d=811,c=AUCT_CLAS_FOOD},  -- Recipe: Brilliant Smallfish
	[6326]={b=40,s=10,d=811,c=AUCT_CLAS_FOOD},  -- Recipe: Slitherskin Mackerel
	[6327]={b=64118,s=12823,d=11271,c=AUCT_CLAS_WEAPON},  -- The Pacifier
	[6328]={b=400,s=100,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Longjaw Mud Snapper
	[6329]={b=400,s=100,d=1102},  -- Recipe: Loch Frenzy Delight
	[6330]={b=1200,s=300,d=1102},  -- Recipe: Bristle Whisker Catfish
	[6331]={b=47333,s=9466,d=20333,c=AUCT_CLAS_WEAPON},  -- Howling Blade
	[6332]={b=4615,s=1153,d=9837,c=AUCT_CLAS_ARMOR},  -- Black Pearl Ring
	[6333]={b=9645,s=1929,d=20604,c=AUCT_CLAS_WEAPON},  -- Spikelash Dagger
	[6335]={b=7905,s=1581,d=11330,c=AUCT_CLAS_ARMOR},  -- Grizzled Boots
	[6336]={b=1526,s=305,d=3057,c=AUCT_CLAS_ARMOR},  -- Infantry Tunic
	[6337]={b=1225,s=245,d=3058,c=AUCT_CLAS_ARMOR},  -- Infantry Leggings
	[6338]={b=500,s=125,d=21208},  -- Silver Rod
	[6339]={b=124,s=24,d=21208},  -- Runed Silver Rod
	[6340]={b=4375,s=875,d=23027,c=AUCT_CLAS_ARMOR},  -- Fenrus' Hide
	[6341]={b=2665,s=666,d=11410,c=AUCT_CLAS_WEAPON},  -- Eerie Stable Lantern
	[6342]={b=300,s=75,d=11431},  -- Formula: Enchant Chest - Minor Mana
	[6344]={b=400,s=100,d=11431},  -- Formula: Enchant Bracer - Minor Spirit
	[6346]={b=400,s=100,d=11431},  -- Formula: Enchant Chest - Lesser Mana
	[6347]={b=400,s=100,d=11431},  -- Formula: Enchant Bracer - Minor Strength
	[6348]={b=500,s=125,d=11431},  -- Formula: Enchant Weapon - Minor Beastslayer
	[6349]={b=500,s=125,d=11431},  -- Formula: Enchant 2H Weapon - Lesser Intellect
	[6350]={b=1478,s=295,d=6885,c=AUCT_CLAS_ARMOR},  -- Rough Bronze Boots
	[6351]={b=4,s=1,d=9151},  -- Dented Crate
	[6352]={b=4,s=1,d=9822},  -- Waterlogged Crate
	[6353]={b=4,s=1,d=12331},  -- Small Chest
	[6354]={b=4,s=1,d=12332},  -- Small Locked Chest
	[6355]={b=4,s=1,d=12331},  -- Sturdy Locked Chest
	[6356]={b=4,s=1,d=12331},  -- Battered Chest
	[6357]={b=4,s=1,d=8928},  -- Sealed Crate
	[6358]={b=16,s=4,d=9150,x=20,u=AUCT_TYPE_ALCHEM},  -- Oily Blackmouth
	[6359]={b=20,s=5,d=11451,x=20,u=AUCT_TYPE_ALCHEM},  -- Firefin Snapper
	[6360]={b=12905,s=2581,d=11453,c=AUCT_CLAS_WEAPON},  -- Steelscale Crushfish
	[6361]={b=40,s=2,d=24709,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Rainbow Fin Albacore
	[6362]={b=80,s=4,d=4823,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Rockscale Cod
	[6363]={b=1000,s=250,d=24712,c=AUCT_CLAS_WEAPON},  -- 26 Pound Catfish
	[6364]={b=1500,s=375,d=24712,c=AUCT_CLAS_WEAPON},  -- 32 Pound Catfish
	[6365]={b=901,s=180,d=20618,c=AUCT_CLAS_FISHING},  -- Strong Fishing Pole
	[6367]={b=16892,s=3378,d=20619,c=AUCT_CLAS_FISHING},  -- Big Iron Fishing Pole
	[6368]={b=400,s=100,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Rainbow Fin Albacore
	[6369]={b=2200,s=550,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Rockscale Cod
	[6370]={b=40,s=10,d=18114,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT},  -- Blackmouth Oil
	[6371]={b=48,s=12,d=15771,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_TAILOR},  -- Fire Oil
	[6372]={b=140,s=35,d=15748,x=5,c=AUCT_CLAS_POTION},  -- Swim Speed Potion
	[6373]={b=140,s=35,d=15788,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Firepower
	[6375]={b=1000,s=250,d=11431},  -- Formula: Enchant Bracer - Lesser Spirit
	[6377]={b=1000,s=250,d=11431},  -- Formula: Enchant Boots - Minor Agility
	[6378]={b=1463,s=292,d=23139,c=AUCT_CLAS_ARMOR},  -- Seer's Cape
	[6379]={b=1223,s=244,d=16922,c=AUCT_CLAS_ARMOR},  -- Inscribed Leather Belt
	[6380]={b=3271,s=654,d=1673,c=AUCT_CLAS_WEAPON},  -- Inscribed Buckler
	[6381]={b=3127,s=625,d=27549,c=AUCT_CLAS_ARMOR},  -- Bright Cloak
	[6382]={b=2616,s=523,d=16916,c=AUCT_CLAS_ARMOR},  -- Forest Leather Belt
	[6383]={b=7596,s=1519,d=18483,c=AUCT_CLAS_WEAPON},  -- Forest Buckler
	[6384]={b=1000,s=250,d=11518,c=AUCT_CLAS_ARMOR},  -- Stylish Blue Shirt
	[6385]={b=1000,s=250,d=11519,c=AUCT_CLAS_ARMOR},  -- Stylish Green Shirt
	[6386]={b=13462,s=2692,d=25805,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Legguards
	[6387]={b=6141,s=1228,d=25800,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Bracers
	[6388]={b=10216,s=2043,d=25806,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Pauldrons
	[6389]={b=11229,s=2245,d=15517,c=AUCT_CLAS_ARMOR},  -- Glimmering Mail Coif
	[6390]={b=600,s=150,d=15274},  -- Pattern: Stylish Blue Shirt
	[6391]={b=600,s=150,d=15274},  -- Pattern: Stylish Green Shirt
	[6392]={b=5003,s=1000,d=11533,c=AUCT_CLAS_ARMOR},  -- Belt of Arugal
	[6393]={b=3803,s=760,d=16642,c=AUCT_CLAS_ARMOR},  -- Silver-thread Gloves
	[6394]={b=5205,s=1041,d=11571,c=AUCT_CLAS_ARMOR},  -- Silver-thread Boots
	[6395]={b=6321,s=1264,d=13677,c=AUCT_CLAS_ARMOR},  -- Silver-thread Amice
	[6396]={b=14073,s=2814,d=14602,c=AUCT_CLAS_ARMOR},  -- Emblazoned Chestpiece
	[6397]={b=4929,s=985,d=14603,c=AUCT_CLAS_ARMOR},  -- Emblazoned Gloves
	[6398]={b=4948,s=989,d=17118,c=AUCT_CLAS_ARMOR},  -- Emblazoned Belt
	[6399]={b=8196,s=1639,d=14599,c=AUCT_CLAS_ARMOR},  -- Emblazoned Shoulders
	[6400]={b=15445,s=3089,d=11559,c=AUCT_CLAS_WEAPON},  -- Glimmering Shield
	[6401]={b=1100,s=275,d=1102},  -- Pattern: Dark Silk Shirt
	[6402]={b=23496,s=4699,d=25812,c=AUCT_CLAS_ARMOR},  -- Mail Combat Leggings
	[6403]={b=8859,s=1771,d=25808,c=AUCT_CLAS_ARMOR},  -- Mail Combat Armguards
	[6404]={b=16211,s=3242,d=25815,c=AUCT_CLAS_ARMOR},  -- Mail Combat Spaulders
	[6405]={b=15839,s=3167,d=14625,c=AUCT_CLAS_ARMOR},  -- Nightsky Trousers
	[6406]={b=9854,s=1970,d=14617,c=AUCT_CLAS_ARMOR},  -- Nightsky Boots
	[6407]={b=5994,s=1198,d=14618,c=AUCT_CLAS_ARMOR},  -- Nightsky Wristbands
	[6408]={b=8271,s=1654,d=17061,c=AUCT_CLAS_ARMOR},  -- Insignia Gloves
	[6409]={b=8302,s=1660,d=17121,c=AUCT_CLAS_ARMOR},  -- Insignia Belt
	[6410]={b=7574,s=1514,d=17009,c=AUCT_CLAS_ARMOR},  -- Insignia Bracers
	[6411]={b=36343,s=7268,d=25882,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Armor
	[6412]={b=23558,s=4711,d=25883,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Boots
	[6413]={b=12487,s=2497,d=25886,c=AUCT_CLAS_ARMOR},  -- Chief Brigadier Bracers
	[6414]={b=8220,s=2055,d=9846,c=AUCT_CLAS_ARMOR},  -- Seal of Sylvanas
	[6415]={b=22825,s=4565,d=12653,c=AUCT_CLAS_ARMOR},  -- Aurora Robe
	[6416]={b=13642,s=2728,d=14651,c=AUCT_CLAS_ARMOR},  -- Aurora Boots
	[6417]={b=12680,s=2536,d=23091,c=AUCT_CLAS_ARMOR},  -- Aurora Cloak
	[6418]={b=8486,s=1697,d=14656,c=AUCT_CLAS_ARMOR},  -- Aurora Sash
	[6419]={b=11497,s=2299,d=14676,c=AUCT_CLAS_ARMOR},  -- Glyphed Mitts
	[6420]={b=18698,s=3739,d=14672,c=AUCT_CLAS_ARMOR},  -- Glyphed Boots
	[6421]={b=11585,s=2317,d=14671,c=AUCT_CLAS_ARMOR},  -- Glyphed Belt
	[6422]={b=18840,s=3768,d=21297,c=AUCT_CLAS_ARMOR},  -- Glyphed Helm
	[6423]={b=36168,s=7233,d=26077,c=AUCT_CLAS_ARMOR},  -- Blackforge Greaves
	[6424]={b=19127,s=3825,d=26082,c=AUCT_CLAS_ARMOR},  -- Blackforge Cape
	[6425]={b=22393,s=4478,d=26076,c=AUCT_CLAS_ARMOR},  -- Blackforge Girdle
	[6426]={b=20811,s=4162,d=26073,c=AUCT_CLAS_ARMOR},  -- Blackforge Bracers
	[6427]={b=35081,s=7016,d=12676,c=AUCT_CLAS_ARMOR},  -- Mistscape Robe
	[6428]={b=13975,s=2795,d=14684,c=AUCT_CLAS_ARMOR},  -- Mistscape Gloves
	[6429]={b=22724,s=4544,d=15910,c=AUCT_CLAS_ARMOR},  -- Mistscape Wizard Hat
	[6430]={b=45493,s=9098,d=18471,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Breastplate
	[6431]={b=27181,s=5436,d=16986,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Boots
	[6432]={b=18708,s=3741,d=23039,c=AUCT_CLAS_ARMOR},  -- Imperial Cloak
	[6433]={b=24767,s=4953,d=21291,c=AUCT_CLAS_ARMOR},  -- Imperial Leather Helm
	[6435]={b=0,s=0,d=11766,q=20,x=20},  -- Infused Burning Gem
	[6436]={b=0,s=0,d=6521},  -- Burning Gem
	[6438]={b=1450,s=362,d=11791,x=5},  -- Dull Elemental Bracer
	[6439]={b=950,s=237,d=11791,x=5},  -- Broken Binding Bracer
	[6440]={b=63250,s=15812,d=12643,c=AUCT_CLAS_ARMOR},  -- Brainlash
	[6441]={b=0,s=0,d=11825},  -- Shadowstalker Scalp
	[6442]={b=0,s=0,d=15027},  -- Oracle Crystal
	[6443]={b=0,s=0,d=11164,q=20,x=20},  -- Deviate Hide
	[6444]={b=915,s=228,d=11889,x=5},  -- Forked Tongue
	[6445]={b=352,s=88,d=6629,x=5},  -- Brittle Molting
	[6446]={b=2130,s=532,d=2593,c=AUCT_CLAS_CONTAINER},  -- Snakeskin Bag
	[6447]={b=2810,s=562,d=22805,c=AUCT_CLAS_WEAPON},  -- Worn Turtle Shell Shield
	[6448]={b=9714,s=1942,d=20349,c=AUCT_CLAS_WEAPON},  -- Tail Spike
	[6449]={b=3509,s=701,d=23001,c=AUCT_CLAS_ARMOR},  -- Glowing Lizardscale Cloak
	[6450]={b=800,s=200,d=8603,x=20},  -- Silk Bandage
	[6451]={b=1600,s=400,d=11926,x=20},  -- Heavy Silk Bandage
	[6452]={b=115,s=28,d=2885,x=20},  -- Anti-Venom
	[6453]={b=250,s=62,d=2885,x=20},  -- Strong Anti-Venom
	[6454]={b=900,s=225,d=8117},  -- Manual: Strong Anti-Venom
	[6455]={b=16,s=4,d=18706,x=5},  -- Old Wagonwheel
	[6456]={b=12,s=3,d=2885,x=10},  -- Acidic Slime
	[6457]={b=16,s=4,d=3257,x=5},  -- Rusted Engineering Parts
	[6458]={b=4,s=1,d=11932,q=20,x=20},  -- Oil Covered Fish
	[6459]={b=4674,s=934,d=11935,c=AUCT_CLAS_ARMOR},  -- Savage Trodders
	[6460]={b=4222,s=844,d=11945,c=AUCT_CLAS_ARMOR},  -- Cobrahn's Grasp
	[6461]={b=5954,s=1190,d=11946,c=AUCT_CLAS_ARMOR},  -- Slime-encrusted Pads
	[6462]={b=0,s=0,d=11449},  -- Secure Crate
	[6463]={b=6110,s=1527,d=9846,c=AUCT_CLAS_ARMOR},  -- Deep Fathom Ring
	[6464]={b=0,s=0,d=12926,q=20,x=20},  -- Wailing Essence
	[6465]={b=3843,s=768,d=12693,c=AUCT_CLAS_ARMOR},  -- Robe of the Moccasin
	[6466]={b=2067,s=413,d=23010,c=AUCT_CLAS_ARMOR},  -- Deviate Scale Cloak
	[6467]={b=2103,s=420,d=11952,c=AUCT_CLAS_ARMOR},  -- Deviate Scale Gloves
	[6468]={b=3292,s=658,d=11960,c=AUCT_CLAS_ARMOR},  -- Deviate Scale Belt
	[6469]={b=11201,s=2240,d=20652,c=AUCT_CLAS_WEAPON},  -- Venomstrike
	[6470]={b=80,s=20,d=8913,x=20,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Deviate Scale
	[6471]={b=2000,s=500,d=3668,x=20,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Perfect Deviate Scale
	[6472]={b=15094,s=3018,d=24741,c=AUCT_CLAS_WEAPON},  -- Stinging Viper
	[6473]={b=5053,s=1010,d=17091,c=AUCT_CLAS_ARMOR},  -- Armor of the Fang
	[6474]={b=550,s=137,d=1102},  -- Pattern: Deviate Scale Cloak
	[6475]={b=1500,s=375,d=1102},  -- Pattern: Deviate Scale Gloves
	[6476]={b=2000,s=500,d=15274},  -- Pattern: Deviate Scale Belt
	[6477]={b=1372,s=274,d=11997,c=AUCT_CLAS_ARMOR},  -- Grassland Sash
	[6479]={b=0,s=0,d=12018},  -- Malem Pendant
	[6480]={b=3566,s=713,d=9541,c=AUCT_CLAS_ARMOR},  -- Slick Deviate Leggings
	[6481]={b=3209,s=641,d=12068,c=AUCT_CLAS_ARMOR},  -- Dagmire Gauntlets
	[6482]={b=3640,s=728,d=12070,c=AUCT_CLAS_ARMOR},  -- Firewalker Boots
	[6486]={b=0,s=0,d=10043,q=20,x=20},  -- Singed Scale
	[6487]={b=0,s=0,d=20931,q=20,x=20},  -- Vile Familiar Head
	[6488]={b=0,s=0,d=12221,c=AUCT_CLAS_WRITTEN},  -- Simple Tablet
	[6502]={b=5701,s=1140,d=12282,c=AUCT_CLAS_ARMOR},  -- Violet Scale Armor
	[6503]={b=3814,s=762,d=12670,c=AUCT_CLAS_ARMOR},  -- Harlequin Robes
	[6504]={b=14667,s=2933,d=20116,c=AUCT_CLAS_WEAPON},  -- Wingblade
	[6505]={b=18401,s=3680,d=12286,c=AUCT_CLAS_WEAPON},  -- Crescent Staff
	[6506]={b=436,s=87,d=22680,c=AUCT_CLAS_ARMOR},  -- Infantry Boots
	[6507]={b=223,s=44,d=22679,c=AUCT_CLAS_ARMOR},  -- Infantry Bracers
	[6508]={b=172,s=34,d=25948,c=AUCT_CLAS_ARMOR},  -- Infantry Cloak
	[6509]={b=224,s=44,d=22678,c=AUCT_CLAS_ARMOR},  -- Infantry Belt
	[6510]={b=272,s=54,d=22682,c=AUCT_CLAS_ARMOR},  -- Infantry Gauntlets
	[6511]={b=608,s=121,d=16698,c=AUCT_CLAS_ARMOR},  -- Journeyman's Robe
	[6512]={b=955,s=191,d=16813,c=AUCT_CLAS_ARMOR},  -- Disciple's Robe
	[6513]={b=141,s=28,d=16565,c=AUCT_CLAS_ARMOR},  -- Disciple's Sash
	[6514]={b=212,s=42,d=23104,c=AUCT_CLAS_ARMOR},  -- Disciple's Cloak
	[6515]={b=185,s=37,d=16562,c=AUCT_CLAS_ARMOR},  -- Disciple's Gloves
	[6517]={b=179,s=35,d=17124,c=AUCT_CLAS_ARMOR},  -- Pioneer Belt
	[6518]={b=351,s=70,d=16991,c=AUCT_CLAS_ARMOR},  -- Pioneer Boots
	[6519]={b=180,s=36,d=8437,c=AUCT_CLAS_ARMOR},  -- Pioneer Bracers
	[6520]={b=209,s=41,d=23052,c=AUCT_CLAS_ARMOR},  -- Pioneer Cloak
	[6521]={b=236,s=47,d=6717,c=AUCT_CLAS_ARMOR},  -- Pioneer Gloves
	[6522]={b=16,s=4,d=11451,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_COOK},  -- Deviate Fish
	[6523]={b=1422,s=284,d=14259,c=AUCT_CLAS_ARMOR},  -- Buckled Harness
	[6524]={b=2870,s=574,d=12370,c=AUCT_CLAS_ARMOR},  -- Studded Leather Harness
	[6525]={b=5167,s=1033,d=12371,c=AUCT_CLAS_ARMOR},  -- Grunt's Harness
	[6526]={b=12487,s=2497,d=12372,c=AUCT_CLAS_ARMOR},  -- Battle Harness
	[6527]={b=937,s=187,d=12422,c=AUCT_CLAS_ARMOR},  -- Ancestral Robe
	[6528]={b=1792,s=358,d=16567,c=AUCT_CLAS_ARMOR},  -- Spellbinder Robe
	[6529]={b=50,s=12,d=12410,x=20,c=AUCT_CLAS_FISHING},  -- Shiny Bauble
	[6530]={b=100,s=25,d=18097,x=20,c=AUCT_CLAS_FISHING,u=AUCT_TYPE_ENGINEER},  -- Nightcrawlers
	[6531]={b=2085,s=417,d=19110,c=AUCT_CLAS_ARMOR},  -- Barbaric Cloth Robe
	[6532]={b=250,s=62,d=12423,x=20,c=AUCT_CLAS_FISHING},  -- Bright Baubles
	[6533]={b=250,s=62,d=12425,x=20,c=AUCT_CLAS_FISHING},  -- Aquadynamic Fish Attractor
	[6534]={b=0,s=0,d=12434},  -- Forged Steel Bars
	[6535]={b=0,s=0,d=12435},  -- Tablet of Verga
	[6536]={b=2443,s=488,d=14739,c=AUCT_CLAS_ARMOR},  -- Willow Vest
	[6537]={b=1051,s=210,d=12439,c=AUCT_CLAS_ARMOR},  -- Willow Boots
	[6538]={b=2461,s=492,d=16522,c=AUCT_CLAS_ARMOR},  -- Willow Robe
	[6539]={b=811,s=162,d=14735,c=AUCT_CLAS_ARMOR},  -- Willow Belt
	[6540]={b=2156,s=431,d=14738,c=AUCT_CLAS_ARMOR},  -- Willow Pants
	[6541]={b=817,s=163,d=14737,c=AUCT_CLAS_ARMOR},  -- Willow Gloves
	[6542]={b=1099,s=219,d=15267,c=AUCT_CLAS_ARMOR},  -- Willow Cape
	[6543]={b=735,s=147,d=14736,c=AUCT_CLAS_ARMOR},  -- Willow Bracers
	[6545]={b=3379,s=675,d=25755,c=AUCT_CLAS_ARMOR},  -- Soldier's Armor
	[6546]={b=2668,s=533,d=25759,c=AUCT_CLAS_ARMOR},  -- Soldier's Leggings
	[6547]={b=1339,s=267,d=25756,c=AUCT_CLAS_ARMOR},  -- Soldier's Gauntlets
	[6548]={b=1169,s=233,d=25757,c=AUCT_CLAS_ARMOR},  -- Soldier's Girdle
	[6549]={b=509,s=101,d=25953,c=AUCT_CLAS_ARMOR},  -- Soldier's Cloak
	[6550]={b=1024,s=204,d=25758,c=AUCT_CLAS_ARMOR},  -- Soldier's Wristguards
	[6551]={b=2048,s=409,d=6931,c=AUCT_CLAS_ARMOR},  -- Soldier's Boots
	[6552]={b=3009,s=601,d=14731,c=AUCT_CLAS_ARMOR},  -- Bard's Tunic
	[6553]={b=2626,s=525,d=14730,c=AUCT_CLAS_ARMOR},  -- Bard's Trousers
	[6554]={b=1145,s=229,d=14729,c=AUCT_CLAS_ARMOR},  -- Bard's Gloves
	[6555]={b=652,s=130,d=23006,c=AUCT_CLAS_ARMOR},  -- Bard's Cloak
	[6556]={b=873,s=174,d=14728,c=AUCT_CLAS_ARMOR},  -- Bard's Bracers
	[6557]={b=1511,s=302,d=19184,c=AUCT_CLAS_ARMOR},  -- Bard's Boots
	[6558]={b=902,s=180,d=17113,c=AUCT_CLAS_ARMOR},  -- Bard's Belt
	[6559]={b=2668,s=533,d=2210,c=AUCT_CLAS_WEAPON},  -- Bard's Buckler
	[6560]={b=3079,s=615,d=25955,c=AUCT_CLAS_WEAPON},  -- Soldier's Shield
	[6561]={b=3378,s=675,d=14551,c=AUCT_CLAS_ARMOR},  -- Seer's Padded Armor
	[6562]={b=2542,s=508,d=16881,c=AUCT_CLAS_ARMOR},  -- Shimmering Boots
	[6563]={b=1478,s=295,d=14750,c=AUCT_CLAS_ARMOR},  -- Shimmering Bracers
	[6564]={b=2560,s=512,d=23109,c=AUCT_CLAS_ARMOR},  -- Shimmering Cloak
	[6565]={b=1969,s=393,d=16793,c=AUCT_CLAS_ARMOR},  -- Shimmering Gloves
	[6566]={b=2055,s=411,d=16470,c=AUCT_CLAS_ARMOR},  -- Shimmering Amice
	[6567]={b=5182,s=1036,d=14748,c=AUCT_CLAS_ARMOR},  -- Shimmering Armor
	[6568]={b=4603,s=920,d=14746,c=AUCT_CLAS_ARMOR},  -- Shimmering Trousers
	[6569]={b=5222,s=1044,d=18120,c=AUCT_CLAS_ARMOR},  -- Shimmering Robe
	[6570]={b=1815,s=363,d=14752,c=AUCT_CLAS_ARMOR},  -- Shimmering Sash
	[6571]={b=5834,s=1166,d=18493,c=AUCT_CLAS_WEAPON},  -- Scouting Buckler
	[6572]={b=6618,s=1323,d=18701,c=AUCT_CLAS_WEAPON},  -- Defender Shield
	[6573]={b=4691,s=938,d=25760,c=AUCT_CLAS_ARMOR},  -- Defender Boots
	[6574]={b=2840,s=568,d=12456,c=AUCT_CLAS_ARMOR},  -- Defender Bracers
	[6575]={b=2155,s=431,d=25967,c=AUCT_CLAS_ARMOR},  -- Defender Cloak
	[6576]={b=2861,s=572,d=25762,c=AUCT_CLAS_ARMOR},  -- Defender Girdle
	[6577]={b=3245,s=649,d=25761,c=AUCT_CLAS_ARMOR},  -- Defender Gauntlets
	[6578]={b=6514,s=1302,d=12453,c=AUCT_CLAS_ARMOR},  -- Defender Leggings
	[6579]={b=3339,s=667,d=25764,c=AUCT_CLAS_ARMOR},  -- Defender Spaulders
	[6580]={b=6562,s=1312,d=25763,c=AUCT_CLAS_ARMOR},  -- Defender Tunic
	[6581]={b=2111,s=422,d=17127,c=AUCT_CLAS_ARMOR},  -- Scouting Belt
	[6582]={b=3655,s=731,d=14759,c=AUCT_CLAS_ARMOR},  -- Scouting Boots
	[6583]={b=2126,s=425,d=3657,c=AUCT_CLAS_ARMOR},  -- Scouting Bracers
	[6584]={b=7082,s=1416,d=14758,c=AUCT_CLAS_ARMOR},  -- Scouting Tunic
	[6585]={b=2792,s=558,d=23053,c=AUCT_CLAS_ARMOR},  -- Scouting Cloak
	[6586]={b=2526,s=505,d=14755,c=AUCT_CLAS_ARMOR},  -- Scouting Gloves
	[6587]={b=5732,s=1146,d=14757,c=AUCT_CLAS_ARMOR},  -- Scouting Trousers
	[6588]={b=2291,s=458,d=17195,c=AUCT_CLAS_ARMOR},  -- Scouting Spaulders
	[6590]={b=9153,s=1830,d=25793,c=AUCT_CLAS_ARMOR},  -- Battleforge Boots
	[6591]={b=5039,s=1007,d=25797,c=AUCT_CLAS_ARMOR},  -- Battleforge Wristguards
	[6592]={b=12239,s=2447,d=25798,c=AUCT_CLAS_ARMOR},  -- Battleforge Armor
	[6593]={b=4614,s=922,d=25993,c=AUCT_CLAS_ARMOR},  -- Battleforge Cloak
	[6594]={b=5604,s=1120,d=25795,c=AUCT_CLAS_ARMOR},  -- Battleforge Girdle
	[6595]={b=5624,s=1124,d=25794,c=AUCT_CLAS_ARMOR},  -- Battleforge Gauntlets
	[6596]={b=11290,s=2258,d=25796,c=AUCT_CLAS_ARMOR},  -- Battleforge Legguards
	[6597]={b=8536,s=1707,d=25799,c=AUCT_CLAS_ARMOR},  -- Battleforge Shoulderguards
	[6598]={b=12131,s=2426,d=18449,c=AUCT_CLAS_WEAPON},  -- Dervish Buckler
	[6599]={b=13393,s=2678,d=26014,c=AUCT_CLAS_WEAPON},  -- Battleforge Shield
	[6600]={b=4338,s=867,d=14774,c=AUCT_CLAS_ARMOR},  -- Dervish Belt
	[6601]={b=7185,s=1437,d=14769,c=AUCT_CLAS_ARMOR},  -- Dervish Boots
	[6602]={b=4369,s=873,d=17167,c=AUCT_CLAS_ARMOR},  -- Dervish Bracers
	[6603]={b=11674,s=2334,d=14773,c=AUCT_CLAS_ARMOR},  -- Dervish Tunic
	[6604]={b=6000,s=1200,d=23022,c=AUCT_CLAS_ARMOR},  -- Dervish Cape
	[6605]={b=4857,s=971,d=14775,c=AUCT_CLAS_ARMOR},  -- Dervish Gloves
	[6607]={b=11012,s=2202,d=14776,c=AUCT_CLAS_ARMOR},  -- Dervish Leggings
	[6608]={b=6644,s=1328,d=27542,c=AUCT_CLAS_ARMOR},  -- Bright Armor
	[6609]={b=10740,s=2148,d=16862,c=AUCT_CLAS_CLOTH},  -- Sage's Cloth
	[6610]={b=10780,s=2156,d=16878,c=AUCT_CLAS_ARMOR},  -- Sage's Robe
	[6611]={b=4063,s=812,d=16866,c=AUCT_CLAS_ARMOR},  -- Sage's Sash
	[6612]={b=5562,s=1112,d=19921,c=AUCT_CLAS_ARMOR},  -- Sage's Boots
	[6613]={b=3722,s=744,d=16869,c=AUCT_CLAS_ARMOR},  -- Sage's Bracers
	[6614]={b=5603,s=1120,d=23138,c=AUCT_CLAS_ARMOR},  -- Sage's Cloak
	[6615]={b=4123,s=824,d=16864,c=AUCT_CLAS_ARMOR},  -- Sage's Gloves
	[6616]={b=11019,s=2203,d=16863,c=AUCT_CLAS_ARMOR},  -- Sage's Pants
	[6617]={b=6855,s=1371,d=4904,c=AUCT_CLAS_ARMOR},  -- Sage's Mantle
	[6622]={b=277000,s=55400,d=21554,c=AUCT_CLAS_WEAPON},  -- Sword of Zeal
	[6624]={b=0,s=0,d=12565},  -- Ken'zigla's Draught
	[6625]={b=0,s=0,d=12567},  -- Dirt-caked Pendant
	[6626]={b=0,s=0,d=12567},  -- Dogran's Pendant
	[6627]={b=13104,s=2620,d=12595,c=AUCT_CLAS_ARMOR},  -- Mutant Scale Breastplate
	[6628]={b=1851,s=370,d=16952,c=AUCT_CLAS_ARMOR},  -- Raven's Claws
	[6629]={b=3150,s=630,d=23141,c=AUCT_CLAS_ARMOR},  -- Sporid Cape
	[6630]={b=10337,s=2067,d=6274,c=AUCT_CLAS_WEAPON},  -- Seedcloud Buckler
	[6631]={b=20266,s=4053,d=20336,c=AUCT_CLAS_WEAPON},  -- Living Root
	[6632]={b=3211,s=642,d=15156,c=AUCT_CLAS_ARMOR},  -- Feyscale Cloak
	[6633]={b=10659,s=2131,d=12610,c=AUCT_CLAS_WEAPON},  -- Butcher's Slicer
	[6634]={b=0,s=0,d=6381,q=20,x=20},  -- Ritual Salve
	[6635]={b=0,s=0,d=6400,c=AUCT_CLAS_SHAMAN},  -- Earth Sapta
	[6636]={b=0,s=0,d=12621,c=AUCT_CLAS_SHAMAN},  -- Fire Sapta
	[6637]={b=0,s=0,d=6340,c=AUCT_CLAS_SHAMAN},  -- Water Sapta
	[6640]={b=0,s=0,d=12625,q=20,x=20},  -- Felstalker Hoof
	[6641]={b=18376,s=3675,d=20167,c=AUCT_CLAS_WEAPON},  -- Haunting Blade
	[6642]={b=9402,s=1880,d=12632,c=AUCT_CLAS_ARMOR},  -- Phantom Armor
	[6643]={b=25,s=6,d=18535,c=AUCT_CLAS_FOOD},  -- Bloated Smallfish
	[6645]={b=100,s=25,d=24694,c=AUCT_CLAS_FOOD},  -- Bloated Mud Snapper
	[6652]={b=0,s=0,d=12735},  -- Reagent Pouch
	[6653]={b=0,s=0,d=12992,c=AUCT_CLAS_WEAPON},  -- Torch of the Dormant Flame
	[6654]={b=0,s=0,d=12738,c=AUCT_CLAS_WEAPON},  -- Torch of the Eternal Flame
	[6655]={b=0,s=0,d=12736},  -- Glowing Ember
	[6656]={b=0,s=0,d=12746},  -- Rough Quartz
	[6657]={b=20,s=5,d=12780,x=20},  -- Savory Deviate Delight
	[6658]={b=0,s=0,d=12643},  -- Example Collar
	[6659]={b=2705,s=541,d=12777,c=AUCT_CLAS_ARMOR},  -- Scarab Trousers
	[6660]={b=180788,s=36157,d=13001,c=AUCT_CLAS_WEAPON},  -- Julie's Dagger
	[6661]={b=460,s=115,d=1102},  -- Recipe: Savory Deviate Delight
	[6662]={b=380,s=95,d=11462,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Giant Growth
	[6663]={b=600,s=150,d=15274},  -- Recipe: Elixir of Giant Growth
	[6664]={b=4460,s=892,d=12782,c=AUCT_CLAS_ARMOR},  -- Voodoo Mantle
	[6665]={b=4477,s=895,d=12783,c=AUCT_CLAS_ARMOR},  -- Hexed Bracers
	[6666]={b=4152,s=830,d=12784,c=AUCT_CLAS_ARMOR},  -- Dredge Boots
	[6667]={b=4962,s=992,d=23110,c=AUCT_CLAS_ARMOR},  -- Engineer's Cloak
	[6668]={b=6226,s=1245,d=12788,c=AUCT_CLAS_ARMOR},  -- Draftsman Boots
	[6669]={b=5515,s=1378,d=9833,c=AUCT_CLAS_ARMOR},  -- Sacred Band
	[6670]={b=8363,s=1672,d=12794,c=AUCT_CLAS_ARMOR},  -- Panther Armor
	[6671]={b=10341,s=2068,d=12795,c=AUCT_CLAS_ARMOR},  -- Juggernaut Leggings
	[6672]={b=2000,s=500,d=15274},  -- Schematic: Flash Bomb
	[6675]={b=5244,s=1048,d=12804,c=AUCT_CLAS_ARMOR},  -- Tempered Bracers
	[6676]={b=11229,s=2245,d=12805,c=AUCT_CLAS_WEAPON},  -- Constable Buckler
	[6677]={b=12005,s=2401,d=21018,c=AUCT_CLAS_WEAPON},  -- Spellcrafter Wand
	[6678]={b=2710,s=677,d=14434,c=AUCT_CLAS_ARMOR},  -- Band of Elven Grace
	[6679]={b=24264,s=4852,d=22241,c=AUCT_CLAS_WEAPON},  -- Armor Piercer
	[6681]={b=15622,s=3124,d=20593,c=AUCT_CLAS_WEAPON},  -- Thornspike
	[6682]={b=9504,s=1900,d=12858,c=AUCT_CLAS_ARMOR},  -- Death Speaker Robes
	[6684]={b=0,s=0,d=12866},  -- Snufflenose Command Stick
	[6685]={b=6554,s=1310,d=11473,c=AUCT_CLAS_ARMOR},  -- Death Speaker Mantle
	[6686]={b=13135,s=2627,d=15492,c=AUCT_CLAS_ARMOR},  -- Tusken Helm
	[6687]={b=49652,s=9930,d=22217,c=AUCT_CLAS_WEAPON},  -- Corpsemaker
	[6688]={b=10295,s=2059,d=17277,c=AUCT_CLAS_ARMOR},  -- Whisperwind Headdress
	[6689]={b=41336,s=8267,d=20325,c=AUCT_CLAS_WEAPON},  -- Wind Spirit Staff
	[6690]={b=16731,s=3346,d=17142,c=AUCT_CLAS_ARMOR},  -- Ferine Leggings
	[6691]={b=44332,s=8866,d=12880,c=AUCT_CLAS_WEAPON},  -- Swinetusk Shank
	[6692]={b=48942,s=9788,d=25597,c=AUCT_CLAS_WEAPON},  -- Pronged Reaver
	[6693]={b=7265,s=1816,d=6486,c=AUCT_CLAS_ARMOR},  -- Agamaggan's Clutch
	[6694]={b=31546,s=6309,d=18454,c=AUCT_CLAS_WEAPON},  -- Heart of Agamaggan
	[6695]={b=12010,s=3002,d=9852,c=AUCT_CLAS_ARMOR},  -- Stygian Bone Amulet
	[6696]={b=25431,s=5086,d=20650,c=AUCT_CLAS_WEAPON},  -- Nightstalker Bow
	[6697]={b=10208,s=2041,d=5116,c=AUCT_CLAS_ARMOR},  -- Batwing Mantle
	[6709]={b=2726,s=545,d=12924,c=AUCT_CLAS_ARMOR},  -- Moonglow Vest
	[6710]={b=550,s=137,d=1102},  -- Pattern: Moonglow Vest
	[6712]={b=50,s=12,d=12925},  -- Practice Lock
	[6713]={b=51,s=10,d=12928,c=AUCT_CLAS_ARMOR},  -- Ripped Pants
	[6714]={b=300,s=75,d=18062,x=20},  -- Ez-Thro Dynamite
	[6715]={b=85,s=21,d=7064},  -- Ruined Jumper Cables
	[6716]={b=800,s=200,d=15274},  -- Schematic: EZ-Thro Dynamite
	[6717]={b=0,s=0,d=8931,q=20,x=20},  -- Gaffer Jack
	[6718]={b=0,s=0,d=7411,q=20,x=20},  -- Electropeller
	[6719]={b=5485,s=1097,d=17134,c=AUCT_CLAS_ARMOR},  -- Windborne Belt
	[6720]={b=16094,s=3218,d=28984,c=AUCT_CLAS_ARMOR},  -- Spirit Hunter Headdress
	[6721]={b=7094,s=1418,d=12934,c=AUCT_CLAS_ARMOR},  -- Chestplate of Kor
	[6722]={b=6657,s=1331,d=12935,c=AUCT_CLAS_ARMOR},  -- Beastial Manacles
	[6723]={b=32620,s=8155,d=4841,c=AUCT_CLAS_ARMOR},  -- Medal of Courage
	[6725]={b=30528,s=6105,d=18469,c=AUCT_CLAS_WEAPON},  -- Marbled Buckler
	[6726]={b=11941,s=2388,d=16716,c=AUCT_CLAS_ARMOR},  -- Razzeric's Customized Seatbelt
	[6727]={b=14982,s=2996,d=17067,c=AUCT_CLAS_ARMOR},  -- Razzeric's Racing Grips
	[6729]={b=35938,s=7187,d=20821,c=AUCT_CLAS_WEAPON},  -- Fizzle's Zippy Lighter
	[6731]={b=4358,s=871,d=12945,c=AUCT_CLAS_ARMOR},  -- Ironforge Breastplate
	[6732]={b=12108,s=2421,d=12943,c=AUCT_CLAS_ARMOR},  -- Gnomish Mechanic's Gloves
	[6735]={b=600,s=150,d=15274},  -- Plans: Ironforge Breastplate
	[6737]={b=14027,s=2805,d=16852,c=AUCT_CLAS_ARMOR},  -- Dryleaf Pants
	[6738]={b=35203,s=7040,d=19126,c=AUCT_CLAS_WEAPON},  -- Bleeding Crescent
	[6739]={b=14958,s=2991,d=20666,c=AUCT_CLAS_WEAPON},  -- Cliffrunner's Aim
	[6740]={b=5004,s=1000,d=12977,c=AUCT_CLAS_ARMOR},  -- Azure Sash
	[6741]={b=15072,s=3014,d=20177,c=AUCT_CLAS_WEAPON},  -- Orcish War Sword
	[6742]={b=14150,s=2830,d=12981,c=AUCT_CLAS_ARMOR},  -- Stonefist Girdle
	[6743]={b=5850,s=1462,d=12984,c=AUCT_CLAS_ARMOR},  -- Sustaining Ring
	[6744]={b=5950,s=1190,d=16956,c=AUCT_CLAS_ARMOR},  -- Gloves of Kapelan
	[6745]={b=11197,s=2239,d=23069,c=AUCT_CLAS_ARMOR},  -- Swiftrunner Cape
	[6746]={b=35379,s=7075,d=18507,c=AUCT_CLAS_WEAPON},  -- Basalt Buckler
	[6747]={b=25076,s=5015,d=12986,c=AUCT_CLAS_ARMOR},  -- Enforcer Pauldrons
	[6748]={b=3590,s=897,d=9836,c=AUCT_CLAS_ARMOR},  -- Monkey Ring
	[6749]={b=3590,s=897,d=9823,c=AUCT_CLAS_ARMOR},  -- Tiger Band
	[6750]={b=3590,s=897,d=12987,c=AUCT_CLAS_ARMOR},  -- Snake Hoop
	[6751]={b=7057,s=1411,d=23126,c=AUCT_CLAS_ARMOR},  -- Mourning Shawl
	[6752]={b=8009,s=1601,d=16988,c=AUCT_CLAS_ARMOR},  -- Lancer Boots
	[6753]={b=0,s=0,d=12989,q=20,x=20},  -- Feather Charm
	[6755]={b=0,s=0,d=12991},  -- A Small Container of Gems
	[6756]={b=5500,s=1375,d=12991,c=AUCT_CLAS_CONTAINER},  -- Jewelry Box
	[6757]={b=18520,s=4630,d=9837,c=AUCT_CLAS_ARMOR},  -- Jaina's Signet Ring
	[6766]={b=0,s=0,d=13002,c=AUCT_CLAS_QUEST},  -- Flayed Demon Skin
	[6767]={b=0,s=0,d=12863},  -- Tyranis' Pendant
	[6773]={b=36831,s=7366,d=13011,c=AUCT_CLAS_ARMOR},  -- Gelkis Marauder Chain
	[6774]={b=11540,s=2885,d=13012,c=AUCT_CLAS_WEAPON},  -- Uthek's Finger
	[6775]={b=0,s=0,d=13005,c=AUCT_CLAS_QUEST},  -- Tome of Divinity
	[6776]={b=0,s=0,d=13005,c=AUCT_CLAS_QUEST},  -- Tome of Valor
	[6780]={b=7800,s=1560,d=13023,c=AUCT_CLAS_ARMOR},  -- Lilac Sash
	[6781]={b=0,s=0,d=18100},  -- Bartleby's Mug
	[6782]={b=0,s=0,d=13024},  -- Marshal Haggard's Badge
	[6783]={b=0,s=0,d=13025},  -- Dead-tooth's Key
	[6784]={b=10159,s=2031,d=13026,c=AUCT_CLAS_ARMOR},  -- Braced Handguards
	[6785]={b=0,s=0,d=7637},  -- Powers of the Void
	[6786]={b=298,s=59,d=13043,c=AUCT_CLAS_ARMOR},  -- Simple Dress
	[6787]={b=2331,s=466,d=13046,c=AUCT_CLAS_ARMOR},  -- White Woolen Dress
	[6788]={b=16658,s=3331,d=17122,c=AUCT_CLAS_ARMOR},  -- Magram Hunter's Belt
	[6789]={b=20060,s=4012,d=23096,c=AUCT_CLAS_ARMOR},  -- Ceremonial Centaur Blanket
	[6790]={b=6160,s=1540,d=6012,c=AUCT_CLAS_ARMOR},  -- Ring of Calm
	[6791]={b=17321,s=3464,d=17227,c=AUCT_CLAS_ARMOR},  -- Hellion Boots
	[6792]={b=23693,s=4738,d=13052,c=AUCT_CLAS_ARMOR},  -- Sanguine Pauldrons
	[6793]={b=15786,s=3157,d=13053,c=AUCT_CLAS_ARMOR},  -- Auric Bracers
	[6794]={b=13206,s=2641,d=17187,c=AUCT_CLAS_ARMOR},  -- Stormfire Gauntlets
	[6795]={b=2000,s=500,d=13056,c=AUCT_CLAS_ARMOR},  -- White Swashbuckler's Shirt
	[6796]={b=3000,s=750,d=13057,c=AUCT_CLAS_ARMOR},  -- Red Swashbuckler's Shirt
	[6797]={b=31812,s=6362,d=21014,c=AUCT_CLAS_WEAPON},  -- Eyepoker
	[6798]={b=31934,s=6386,d=13060,c=AUCT_CLAS_WEAPON},  -- Blasting Hackbut
	[6799]={b=0,s=0,d=13061},  -- Vejrek's Head
	[6800]={b=0,s=0,d=13063,q=20,x=20},  -- Umbral Ore
	[6801]={b=22282,s=4456,d=13077,c=AUCT_CLAS_ARMOR},  -- Baroque Apron
	[6802]={b=91277,s=18255,d=20010,c=AUCT_CLAS_WEAPON},  -- Sword of Omen
	[6803]={b=19540,s=4885,d=15430,c=AUCT_CLAS_WEAPON},  -- Prophetic Cane
	[6804]={b=56312,s=11262,d=19707,c=AUCT_CLAS_WEAPON},  -- Windstorm Hammer
	[6805]={b=0,s=0,d=13082},  -- Horn of Vorlus
	[6806]={b=42539,s=8507,d=13084,c=AUCT_CLAS_WEAPON},  -- Dancing Flame
	[6807]={b=1250,s=62,d=557,q=20,x=20},  -- Frog Leg Stew
	[6808]={b=0,s=0,d=13063,q=20,x=20},  -- Elunite Ore
	[6809]={b=0,s=0,d=7425},  -- Elura's Medallion
	[6810]={b=0,s=0,d=13085},  -- Surena's Choker
	[6811]={b=100,s=25,d=13086,x=20},  -- Aquadynamic Fish Lens
	[6812]={b=0,s=0,d=13100},  -- Case of Elunite
	[6826]={b=2195,s=548,d=6658,x=10},  -- Brilliant Scale
	[6827]={b=600,s=150,d=13110},  -- Box of Supplies
	[6828]={b=31340,s=6268,d=18476,c=AUCT_CLAS_WEAPON},  -- Visionary Buckler
	[6829]={b=93572,s=18714,d=20075,c=AUCT_CLAS_WEAPON},  -- Sword of Serenity
	[6830]={b=117381,s=23476,d=18607,c=AUCT_CLAS_WEAPON},  -- Bonebiter
	[6831]={b=87613,s=17522,d=20292,c=AUCT_CLAS_WEAPON},  -- Black Menace
	[6832]={b=18849,s=3769,d=23097,c=AUCT_CLAS_ARMOR},  -- Cloak of Blight
	[6833]={b=2000,s=500,d=13115,c=AUCT_CLAS_ARMOR},  -- White Tuxedo Shirt
	[6835]={b=2521,s=504,d=13117,c=AUCT_CLAS_ARMOR},  -- Black Tuxedo Pants
	[6838]={b=0,s=0,d=9396,q=20,x=20},  -- Scorched Spider Fang
	[6839]={b=0,s=0,d=13121,q=20,x=20},  -- Charred Horn
	[6840]={b=0,s=0,d=13122,q=20,x=20},  -- Galvanized Horn
	[6841]={b=0,s=0,d=4984},  -- Vial of Phlogiston
	[6842]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Furen's Instructions
	[6843]={b=0,s=0,d=7922},  -- Cask of Scalder
	[6844]={b=0,s=0,d=18060,q=20,x=20},  -- Burning Blood
	[6845]={b=0,s=0,d=13124,q=20,x=20},  -- Burning Rock
	[6846]={b=0,s=0,d=13125,c=AUCT_CLAS_WRITTEN},  -- Defias Script
	[6847]={b=0,s=0,d=13125,c=AUCT_CLAS_WRITTEN},  -- Dark Iron Script
	[6848]={b=0,s=0,d=13918,q=20,x=20},  -- Searing Coral
	[6849]={b=0,s=0,d=18054,q=20,x=20},  -- Sunscorched Shell
	[6851]={b=0,s=0,d=19800},  -- Essence of the Exile
	[6866]={b=0,s=0,d=13144},  -- Symbol of Life
	[6887]={b=2000,s=5,d=4811,q=20,x=20},  -- Spotted Yellowtail
	[6888]={b=40,s=10,d=18052,x=20},  -- Herb Baked Egg
	[6889]={b=16,s=4,d=18046,x=10,u=AUCT_TYPE_COOK},  -- Small Egg
	[6890]={b=125,s=6,d=4113,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Smoked Bear Meat
	[6892]={b=250,s=62,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Smoked Bear Meat
	[6893]={b=0,s=0,d=13290},  -- Workshop Key
	[6894]={b=0,s=0,d=13291},  -- Whirlwind Heart
	[6895]={b=0,s=0,d=13292},  -- Jordan's Smithing Hammer
	[6898]={b=16530,s=4132,d=21597,c=AUCT_CLAS_WEAPON},  -- Orb of Soran'ruk
	[6900]={b=23427,s=4685,d=13337,c=AUCT_CLAS_ARMOR},  -- Enchanted Gold Bloodrobe
	[6901]={b=7615,s=1523,d=23002,c=AUCT_CLAS_ARMOR},  -- Glowing Thresher Cape
	[6902]={b=4385,s=877,d=17001,c=AUCT_CLAS_ARMOR},  -- Bands of Serra'kis
	[6903]={b=7747,s=1549,d=13357,c=AUCT_CLAS_ARMOR},  -- Gaze Dreamer Pants
	[6904]={b=23326,s=4665,d=20575,c=AUCT_CLAS_WEAPON},  -- Bite of Serra'kis
	[6905]={b=20054,s=4010,d=22222,c=AUCT_CLAS_WEAPON},  -- Reef Axe
	[6906]={b=6377,s=1275,d=13361,c=AUCT_CLAS_ARMOR},  -- Algae Fists
	[6907]={b=9364,s=1872,d=16903,c=AUCT_CLAS_ARMOR},  -- Tortoise Armor
	[6908]={b=2611,s=522,d=16723,c=AUCT_CLAS_ARMOR},  -- Ghamoo-ra's Bind
	[6909]={b=35777,s=7155,d=20185,c=AUCT_CLAS_WEAPON},  -- Strike of the Hydra
	[6910]={b=11492,s=2298,d=13365,c=AUCT_CLAS_ARMOR},  -- Leech Pants
	[6911]={b=7210,s=1442,d=16931,c=AUCT_CLAS_ARMOR},  -- Moss Cinch
	[6912]={b=0,s=0,d=13370},  -- Heartswood
	[6913]={b=0,s=0,d=13458},  -- Heartswood Core
	[6914]={b=0,s=0,d=1695,q=20,x=20},  -- Soran'ruk Fragment
	[6915]={b=0,s=0,d=6564},  -- Large Soran'ruk Fragment
	[6916]={b=0,s=0,d=13005,c=AUCT_CLAS_QUEST},  -- Tome of Divinity
	[6926]={b=0,s=0,d=13430},  -- Furen's Notes
	[6927]={b=0,s=0,d=13433},  -- Big Will's Ear
	[6928]={b=0,s=0,d=13085},  -- Bloodstone Choker
	[6929]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Bath'rah's Parchment
	[6930]={b=0,s=0,d=13435,q=20,x=20},  -- Rod of Channeling
	[6931]={b=0,s=0,d=2757},  -- Moldy Tome
	[6947]={b=22,s=5,d=13710,x=10,c=AUCT_CLAS_POISON},  -- Instant Poison
	[6948]={b=0,s=0,d=6418},  -- Hearthstone
	[6949]={b=80,s=20,d=13710,x=10,c=AUCT_CLAS_POISON},  -- Instant Poison II
	[6950]={b=120,s=30,d=13710,x=10,c=AUCT_CLAS_POISON},  -- Instant Poison III
	[6951]={b=300,s=75,d=13709,x=10,c=AUCT_CLAS_POISON},  -- Mind-numbing Poison II
	[6952]={b=0,s=0,d=7169,q=20,x=20},  -- Thick Bear Fur
	[6953]={b=37297,s=7459,d=13466,c=AUCT_CLAS_WEAPON},  -- Verigan's Fist
	[6966]={b=3468,s=693,d=19135,c=AUCT_CLAS_WEAPON},  -- Elunite Axe
	[6967]={b=3481,s=696,d=20162,c=AUCT_CLAS_WEAPON},  -- Elunite Sword
	[6968]={b=3494,s=698,d=19771,c=AUCT_CLAS_WEAPON},  -- Elunite Hammer
	[6969]={b=3506,s=701,d=20400,c=AUCT_CLAS_WEAPON},  -- Elunite Dagger
	[6970]={b=4531,s=906,d=21475,c=AUCT_CLAS_WEAPON},  -- Furen's Favor
	[6971]={b=11105,s=2221,d=15327,c=AUCT_CLAS_ARMOR},  -- Fire Hardened Coif
	[6972]={b=16213,s=3242,d=22480,c=AUCT_CLAS_ARMOR},  -- Fire Hardened Hauberk
	[6973]={b=12326,s=2465,d=22481,c=AUCT_CLAS_ARMOR},  -- Fire Hardened Leggings
	[6974]={b=7485,s=1497,d=22482,c=AUCT_CLAS_ARMOR},  -- Fire Hardened Gauntlets
	[6975]={b=83831,s=16766,d=22734,c=AUCT_CLAS_WEAPON},  -- Whirlwind Axe
	[6976]={b=86321,s=17264,d=25079,c=AUCT_CLAS_WEAPON},  -- Whirlwind Warhammer
	[6977]={b=86627,s=17325,d=22731,c=AUCT_CLAS_WEAPON},  -- Whirlwind Sword
	[6978]={b=3363,s=672,d=19133,c=AUCT_CLAS_WEAPON},  -- Umbral Axe
	[6979]={b=3376,s=675,d=19274,c=AUCT_CLAS_WEAPON},  -- Haggard's Axe
	[6980]={b=3389,s=677,d=20601,c=AUCT_CLAS_WEAPON},  -- Haggard's Dagger
	[6981]={b=3402,s=680,d=20606,c=AUCT_CLAS_WEAPON},  -- Umbral Dagger
	[6982]={b=3415,s=683,d=19652,c=AUCT_CLAS_WEAPON},  -- Umbral Mace
	[6983]={b=3428,s=685,d=19773,c=AUCT_CLAS_WEAPON},  -- Haggard's Hammer
	[6984]={b=3441,s=688,d=20159,c=AUCT_CLAS_WEAPON},  -- Umbral Sword
	[6985]={b=3454,s=690,d=20163,c=AUCT_CLAS_WEAPON},  -- Haggard's Sword
	[6986]={b=200,s=50,d=19495,x=10},  -- Crimson Lotus
	[6987]={b=55,s=13,d=6628,x=10},  -- Fish Scale
	[6989]={b=0,s=0,d=1150,q=20,x=20},  -- Vial of Hatefury Blood
	[6990]={b=0,s=0,d=13490},  -- Lesser Infernal Stone
	[6991]={b=0,s=0,d=9116,q=20,x=20,u=AUCT_TYPE_MINING},  -- Smoldering Coal
	[6992]={b=0,s=0,d=13493},  -- Jordan's Ore Shipment
	[6993]={b=0,s=0,d=13494},  -- Jordan's Refined Ore Shipment
	[6994]={b=0,s=0,d=13495},  -- Whitestone Oak Lumber
	[6995]={b=0,s=0,d=13703},  -- Corrupted Kor Gem
	[6996]={b=0,s=0,d=13497,c=AUCT_CLAS_WRITTEN},  -- Jordan's Weapon Notes
	[6997]={b=0,s=0,d=7798},  -- Tattered Manuscript
	[6998]={b=3872,s=774,d=13500,c=AUCT_CLAS_ARMOR},  -- Nimbus Boots
	[6999]={b=0,s=0,d=2757},  -- Tome of the Cabal
	[7000]={b=3252,s=650,d=16919,c=AUCT_CLAS_ARMOR},  -- Heartwood Girdle
	[7001]={b=17676,s=3535,d=20824,c=AUCT_CLAS_WEAPON},  -- Gravestone Scepter
	[7002]={b=15141,s=3028,d=4743,c=AUCT_CLAS_WEAPON},  -- Arctic Buckler
	[7003]={b=4906,s=981,d=13508,c=AUCT_CLAS_ARMOR},  -- Beetle Clasps
	[7004]={b=4924,s=984,d=15042,c=AUCT_CLAS_ARMOR},  -- Prelacy Cape
	[7005]={b=82,s=16,d=6440,c=AUCT_CLAS_WEAPON},  -- Skinning Knife
	[7006]={b=0,s=0,d=2757},  -- Reconstructed Tome
	[7026]={b=111,s=22,d=17119,c=AUCT_CLAS_ARMOR},  -- Linen Belt
	[7046]={b=7473,s=1494,d=13649,c=AUCT_CLAS_ARMOR},  -- Azure Silk Pants
	[7047]={b=4124,s=824,d=17146,c=AUCT_CLAS_ARMOR},  -- Hands of Darkness
	[7048]={b=3725,s=745,d=15283,c=AUCT_CLAS_ARMOR},  -- Azure Silk Hood
	[7049]={b=4570,s=914,d=17143,c=AUCT_CLAS_ARMOR},  -- Truefaith Gloves
	[7050]={b=4995,s=999,d=15863,c=AUCT_CLAS_ARMOR},  -- Silk Headband
	[7051]={b=13481,s=2696,d=8721,c=AUCT_CLAS_ARMOR},  -- Earthen Vest
	[7052]={b=7440,s=1488,d=13664,c=AUCT_CLAS_ARMOR},  -- Azure Silk Belt
	[7053]={b=11201,s=2240,d=23092,c=AUCT_CLAS_ARMOR},  -- Azure Silk Cloak
	[7054]={b=23504,s=4700,d=17133,c=AUCT_CLAS_ARMOR},  -- Robe of Power
	[7055]={b=7519,s=1503,d=17112,c=AUCT_CLAS_ARMOR},  -- Crimson Silk Belt
	[7056]={b=11574,s=2314,d=15243,c=AUCT_CLAS_ARMOR},  -- Crimson Silk Cloak
	[7057]={b=11618,s=2323,d=28729,c=AUCT_CLAS_ARMOR},  -- Green Silken Shoulders
	[7058]={b=10262,s=2052,d=13671,c=AUCT_CLAS_ARMOR},  -- Crimson Silk Vest
	[7059]={b=13905,s=2781,d=13672,c=AUCT_CLAS_ARMOR},  -- Crimson Silk Shoulders
	[7060]={b=13958,s=2791,d=17132,c=AUCT_CLAS_ARMOR},  -- Azure Shoulders
	[7061]={b=10087,s=2017,d=13678,c=AUCT_CLAS_ARMOR},  -- Earthen Silk Belt
	[7062]={b=12150,s=2430,d=13679,c=AUCT_CLAS_ARMOR},  -- Crimson Silk Pantaloons
	[7063]={b=23707,s=4741,d=12675,c=AUCT_CLAS_ARMOR},  -- Crimson Silk Robe
	[7064]={b=12849,s=2569,d=13681,c=AUCT_CLAS_ARMOR},  -- Crimson Silk Gloves
	[7065]={b=11990,s=2398,d=13684,c=AUCT_CLAS_ARMOR},  -- Green Silk Armor
	[7067]={b=1600,s=400,d=13686,x=10,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Elemental Earth
	[7068]={b=1600,s=400,d=20874,x=10,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Elemental Fire
	[7069]={b=1600,s=400,d=23755,x=10,u=AUCT_TYPE_TAILOR},  -- Elemental Air
	[7070]={b=1600,s=400,d=4136,x=10,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Elemental Water
	[7071]={b=400,s=100,d=13692,x=5,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Iron Buckle
	[7072]={b=600,s=150,d=3668,x=10,u=AUCT_TYPE_TAILOR},  -- Naga Scale
	[7073]={b=25,s=6,d=6002,x=5},  -- Broken Fang
	[7074]={b=16,s=4,d=7048,x=5},  -- Chipped Claw
	[7075]={b=1600,s=400,d=8560,x=10,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER},  -- Core of Earth
	[7076]={b=1600,s=400,d=23754,x=10},  -- Essence of Earth
	[7077]={b=1600,s=400,d=21583,x=10,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Heart of Fire
	[7078]={b=1600,s=400,d=23287,x=10,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Essence of Fire
	[7079]={b=1600,s=400,d=8025,x=10,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Globe of Water
	[7080]={b=1600,s=400,d=13689,x=10,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Essence of Water
	[7081]={b=1600,s=400,d=13687,x=10,u=AUCT_TYPE_ENCHANT},  -- Breath of Wind
	[7082]={b=1600,s=400,d=23284,x=10,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER},  -- Essence of Air
	[7083]={b=0,s=0,d=7279},  -- Purified Kor Gem
	[7084]={b=1400,s=350,d=15274},  -- Pattern: Crimson Silk Shoulders
	[7085]={b=1400,s=350,d=15274},  -- Pattern: Azure Shoulders
	[7086]={b=1500,s=375,d=15274},  -- Pattern: Earthen Silk Belt
	[7087]={b=1200,s=300,d=1102},  -- Pattern: Crimson Silk Cloak
	[7088]={b=5000,s=1250,d=1102},  -- Pattern: Crimson Silk Robe
	[7089]={b=1500,s=375,d=1102},  -- Pattern: Azure Silk Cloak
	[7090]={b=1000,s=250,d=15274},  -- Pattern: Green Silk Armor
	[7091]={b=1000,s=250,d=15274},  -- Pattern: Truefaith Gloves
	[7092]={b=1000,s=250,d=15274},  -- Pattern: Hands of Darkness
	[7094]={b=871,s=174,d=13711,c=AUCT_CLAS_WEAPON},  -- Driftwood Branch
	[7095]={b=161,s=32,d=16810,c=AUCT_CLAS_ARMOR},  -- Bog Boots
	[7096]={b=20,s=5,d=19573,x=5},  -- Plucked Feather
	[7097]={b=25,s=1,d=2474,q=20,x=20},  -- Leg Meat
	[7098]={b=25,s=6,d=3429,x=5},  -- Splintered Tusk
	[7099]={b=25,s=6,d=13713,x=5},  -- Severed Pincer
	[7100]={b=30,s=7,d=13715,x=5},  -- Sticky Ichor
	[7101]={b=20,s=5,d=13714,x=5},  -- Bug Eye
	[7106]={b=6173,s=1234,d=16959,c=AUCT_CLAS_ARMOR},  -- Zodiac Gloves
	[7107]={b=9293,s=1858,d=13758,c=AUCT_CLAS_ARMOR},  -- Belt of the Stars
	[7108]={b=1046,s=209,d=18661,c=AUCT_CLAS_WEAPON},  -- Infantry Shield
	[7109]={b=372,s=74,d=18508,c=AUCT_CLAS_WEAPON},  -- Pioneer Buckler
	[7110]={b=10349,s=2069,d=8720,c=AUCT_CLAS_ARMOR},  -- Silver-thread Armor
	[7111]={b=16648,s=3329,d=14986,c=AUCT_CLAS_ARMOR},  -- Nightsky Armor
	[7112]={b=22735,s=4547,d=14657,c=AUCT_CLAS_ARMOR},  -- Aurora Armor
	[7113]={b=33535,s=6707,d=14678,c=AUCT_CLAS_ARMOR},  -- Mistscape Armor
	[7114]={b=1000,s=250,d=1102},  -- Pattern: Azure Silk Gloves
	[7115]={b=3415,s=683,d=19204,c=AUCT_CLAS_WEAPON},  -- Heirloom Axe
	[7116]={b=3428,s=685,d=20602,c=AUCT_CLAS_WEAPON},  -- Heirloom Dagger
	[7117]={b=3441,s=688,d=19776,c=AUCT_CLAS_WEAPON},  -- Heirloom Hammer
	[7118]={b=3454,s=690,d=20161,c=AUCT_CLAS_WEAPON},  -- Heirloom Sword
	[7119]={b=0,s=0,d=15507},  -- Twitching Antenna
	[7120]={b=4479,s=895,d=22730,c=AUCT_CLAS_WEAPON},  -- Ruga's Bulwark
	[7126]={b=0,s=0,d=13783,q=20,x=20},  -- Smokey Iron Ingot
	[7127]={b=0,s=0,d=7171,q=20,x=20},  -- Powdered Azurite
	[7128]={b=0,s=0,d=13785,q=20,x=20},  -- Uncloven Satyr Hoof
	[7129]={b=7734,s=1546,d=13484,c=AUCT_CLAS_ARMOR},  -- Brutal Gauntlets
	[7130]={b=11642,s=2328,d=15288,c=AUCT_CLAS_ARMOR},  -- Brutal Helm
	[7131]={b=0,s=0,d=13799,q=20,x=20},  -- Dragonmaw Shinbone
	[7132]={b=11692,s=2338,d=3541,c=AUCT_CLAS_ARMOR},  -- Brutal Legguards
	[7133]={b=15493,s=3098,d=13011,c=AUCT_CLAS_ARMOR},  -- Brutal Hauberk
	[7134]={b=0,s=0,d=13799,q=20,x=20},  -- Sturdy Dragonmaw Shinbone
	[7135]={b=0,s=0,d=13806,q=20,x=20},  -- Broken Dragonmaw Shinbone
	[7146]={b=0,s=0,d=8735},  -- The Scarlet Key
	[7148]={b=85,s=21,d=31201,c=AUCT_CLAS_ARMOR},  -- Goblin Jumper Cables
	[7166]={b=973,s=194,d=13848,c=AUCT_CLAS_WEAPON},  -- Copper Dagger
	[7189]={b=23562,s=4712,d=20622,c=AUCT_CLAS_ARMOR},  -- Goblin Rocket Boots
	[7190]={b=0,s=0,d=20623},  -- Scorched Rocket Boots
	[7191]={b=0,s=0,d=16367,u=AUCT_TYPE_ENGINEER},  -- Fused Wiring
	[7206]={b=0,s=0,d=18059},  -- Mirror Lake Water Sample
	[7207]={b=0,s=0,d=18057},  -- Jennea's Flask
	[7208]={b=0,s=0,d=13885},  -- Tazan's Key
	[7209]={b=0,s=0,d=13884},  -- Tazan's Satchel
	[7226]={b=0,s=0,d=13903},  -- Mage-tastic Gizmonitor
	[7227]={b=0,s=0,d=13905},  -- Balnir Snapdragons
	[7228]={b=500,s=25,d=13906,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Tigule and Foror's Strawberry Ice Cream
	[7229]={b=1427,s=285,d=11563,c=AUCT_CLAS_ARMOR},  -- Explorer's Vest
	[7230]={b=15515,s=3103,d=19610,c=AUCT_CLAS_WEAPON},  -- Smite's Mighty Hammer
	[7231]={b=0,s=0,d=7695},  -- Astor's Letter of Introduction
	[7247]={b=0,s=0,d=11449},  -- Chest of Containment Coffers
	[7249]={b=0,s=0,d=7162,q=20,x=20},  -- Charged Rift Gem
	[7266]={b=0,s=0,d=11181,c=AUCT_CLAS_WRITTEN},  -- Ur's Treatise on Shadow Magic
	[7267]={b=0,s=0,d=18597,q=20,x=20,c=AUCT_CLAS_CLOTH},  -- Pristine Spider Silk
	[7268]={b=0,s=0,d=18059},  -- Xavian Water Sample
	[7269]={b=0,s=0,d=18057},  -- Deino's Flask
	[7270]={b=0,s=0,d=13992,q=20,x=20},  -- Laughing Sister's Hair
	[7271]={b=0,s=0,d=13998,q=20,x=20},  -- Flawless Ivory Tusk
	[7272]={b=0,s=0,d=7143},  -- Bolt Charged Bramble
	[7273]={b=0,s=0,d=14000,q=20,x=20},  -- Witherbark Totem Stick
	[7274]={b=0,s=0,d=11181},  -- Rituals of Power
	[7276]={b=170,s=34,d=23035,c=AUCT_CLAS_ARMOR},  -- Handstitched Leather Cloak
	[7277]={b=142,s=28,d=14001,c=AUCT_CLAS_ARMOR},  -- Handstitched Leather Bracers
	[7278]={b=100,s=25,d=21330,c=AUCT_CLAS_CONTAINER},  -- Light Leather Quiver
	[7279]={b=100,s=25,d=1816,c=AUCT_CLAS_CONTAINER},  -- Small Leather Ammo Pouch
	[7280]={b=814,s=162,d=17232,c=AUCT_CLAS_ARMOR},  -- Rugged Leather Pants
	[7281]={b=421,s=84,d=14002,c=AUCT_CLAS_ARMOR},  -- Light Leather Bracers
	[7282]={b=2998,s=599,d=3248,c=AUCT_CLAS_ARMOR},  -- Light Leather Pants
	[7283]={b=2595,s=519,d=23010,c=AUCT_CLAS_ARMOR},  -- Black Whelp Cloak
	[7284]={b=2933,s=586,d=3992,c=AUCT_CLAS_ARMOR},  -- Red Whelp Gloves
	[7285]={b=2944,s=588,d=14004,c=AUCT_CLAS_ARMOR},  -- Nimble Leather Gloves
	[7286]={b=100,s=25,d=6646,x=10,c=AUCT_CLAS_LEATHER},  -- Black Whelp Scale
	[7287]={b=400,s=100,d=6629,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Red Whelp Scale
	[7288]={b=500,s=125,d=1102},  -- Pattern: Rugged Leather Pants
	[7289]={b=650,s=162,d=1102},  -- Pattern: Black Whelp Cloak
	[7290]={b=1600,s=400,d=1102},  -- Pattern: Red Whelp Gloves
	[7291]={b=0,s=0,d=1695},  -- Infernal Orb
	[7292]={b=0,s=0,d=14006,q=20,x=20},  -- Filled Containment Coffer
	[7293]={b=0,s=0,d=14007,q=20,x=20},  -- Dalaran Mana Gem
	[7294]={b=0,s=0,d=14008},  -- Andron's Ledger
	[7295]={b=0,s=0,d=6645},  -- Tazan's Logbook
	[7296]={b=225,s=56,d=14019,x=5},  -- Extinguished Torch
	[7297]={b=0,s=0,d=21604,c=AUCT_CLAS_WEAPON},  -- Morbent's Bane
	[7298]={b=2344,s=468,d=20425,c=AUCT_CLAS_WEAPON},  -- Blade of Cunning
	[7306]={b=0,s=0,d=14023},  -- Fenwick's Head
	[7307]={b=250,s=62,d=18098,x=20},  -- Flesh Eating Worm
	[7308]={b=0,s=0,d=12328},  -- Cantation of Manifestation
	[7309]={b=0,s=0,d=15374},  -- Dalaran Status Report
	[7326]={b=3480,s=696,d=19132,c=AUCT_CLAS_WEAPON},  -- Thun'grim's Axe
	[7327]={b=3493,s=698,d=20398,c=AUCT_CLAS_WEAPON},  -- Thun'grim's Dagger
	[7328]={b=3506,s=701,d=19649,c=AUCT_CLAS_WEAPON},  -- Thun'grim's Mace
	[7329]={b=3519,s=703,d=20160,c=AUCT_CLAS_WEAPON},  -- Thun'grim's Sword
	[7330]={b=19615,s=3923,d=2632,c=AUCT_CLAS_WEAPON},  -- Infiltrator Buckler
	[7331]={b=21654,s=4330,d=26046,c=AUCT_CLAS_WEAPON},  -- Phalanx Shield
	[7332]={b=33462,s=6692,d=15003,c=AUCT_CLAS_ARMOR},  -- Regal Armor
	[7333]={b=0,s=0,d=7276},  -- Overseer's Whistle
	[7334]={b=7721,s=1544,d=16523,c=AUCT_CLAS_ARMOR},  -- Efflorescent Robe
	[7335]={b=9685,s=1937,d=12482,c=AUCT_CLAS_ARMOR},  -- Grizzly Tunic
	[7336]={b=7548,s=1509,d=14069,c=AUCT_CLAS_ARMOR},  -- Wildwood Chain
	[7337]={b=1000000,s=250000,d=24646,c=AUCT_CLAS_ARMOR},  -- The Rock
	[7338]={b=10000,s=2500,d=9833,c=AUCT_CLAS_ARMOR},  -- Mood Ring
	[7339]={b=250000,s=62500,d=9835,c=AUCT_CLAS_ARMOR},  -- Miniscule Diamond Ring
	[7340]={b=500000,s=125000,d=9832,c=AUCT_CLAS_ARMOR},  -- Flawless Diamond Solitaire
	[7341]={b=50000,s=12500,d=9837,c=AUCT_CLAS_ARMOR},  -- Cubic Zirconia Ring
	[7342]={b=100000,s=25000,d=14432,c=AUCT_CLAS_ARMOR},  -- Silver Piffeny Band
	[7343]={b=0,s=0,d=7602},  -- Bingles's Wrench
	[7344]={b=20000,s=5000,d=21604,c=AUCT_CLAS_WEAPON},  -- Torch of Holy Flame
	[7345]={b=0,s=0,d=14305},  -- Bingles's Screwdriver
	[7346]={b=0,s=0,d=14306},  -- Bingles's Hammer
	[7348]={b=3454,s=690,d=6735,c=AUCT_CLAS_ARMOR},  -- Fletcher's Gloves
	[7349]={b=4308,s=861,d=17230,c=AUCT_CLAS_ARMOR},  -- Herbalist's Gloves
	[7350]={b=148,s=29,d=16566,c=AUCT_CLAS_ARMOR},  -- Disciple's Bracers
	[7351]={b=290,s=58,d=16563,c=AUCT_CLAS_ARMOR},  -- Disciple's Boots
	[7352]={b=6533,s=1306,d=14316,c=AUCT_CLAS_ARMOR},  -- Earthen Leather Shoulders
	[7353]={b=14991,s=2998,d=16599,c=AUCT_CLAS_ARMOR},  -- Elder's Padded Armor
	[7354]={b=9324,s=1864,d=16605,c=AUCT_CLAS_ARMOR},  -- Elder's Boots
	[7355]={b=5155,s=1031,d=16604,c=AUCT_CLAS_ARMOR},  -- Elder's Bracers
	[7356]={b=7056,s=1411,d=23100,c=AUCT_CLAS_ARMOR},  -- Elder's Cloak
	[7357]={b=9378,s=1875,d=15906,c=AUCT_CLAS_ARMOR},  -- Elder's Hat
	[7358]={b=4428,s=885,d=2057,c=AUCT_CLAS_ARMOR},  -- Pilferer's Gloves
	[7359]={b=4890,s=978,d=17225,c=AUCT_CLAS_ARMOR},  -- Heavy Earthen Gloves
	[7360]={b=1600,s=400,d=15274},  -- Pattern: Dark Leather Gloves
	[7361]={b=1800,s=450,d=1102},  -- Pattern: Herbalist's Gloves
	[7362]={b=2000,s=500,d=1102},  -- Pattern: Earthen Leather Shoulders
	[7363]={b=2100,s=525,d=1102},  -- Pattern: Pilferer's Gloves
	[7364]={b=2200,s=550,d=1102},  -- Pattern: Heavy Earthen Gloves
	[7365]={b=0,s=0,d=14326},  -- Gnoam Sprecklesprocket
	[7366]={b=5490,s=1098,d=16601,c=AUCT_CLAS_ARMOR},  -- Elder's Gloves
	[7367]={b=9093,s=1818,d=16606,c=AUCT_CLAS_ARMOR},  -- Elder's Mantle
	[7368]={b=13385,s=2677,d=16600,c=AUCT_CLAS_ARMOR},  -- Elder's Pants
	[7369]={b=14777,s=2955,d=16607,c=AUCT_CLAS_ARMOR},  -- Elder's Robe
	[7370]={b=5064,s=1012,d=16603,c=AUCT_CLAS_ARMOR},  -- Elder's Sash
	[7371]={b=2000,s=500,d=21322,c=AUCT_CLAS_CONTAINER},  -- Heavy Quiver
	[7372]={b=2000,s=500,d=2585,c=AUCT_CLAS_CONTAINER},  -- Heavy Leather Ammo Pouch
	[7373]={b=15485,s=3097,d=14777,c=AUCT_CLAS_ARMOR},  -- Dusky Leather Leggings
	[7374]={b=18804,s=3760,d=14781,c=AUCT_CLAS_ARMOR},  -- Dusky Leather Armor
	[7375]={b=18869,s=3773,d=25674,c=AUCT_CLAS_ARMOR},  -- Green Whelp Armor
	[7376]={b=0,s=0,d=18062},  -- Bingles's Blastencapper
	[7377]={b=11347,s=2269,d=23030,c=AUCT_CLAS_ARMOR},  -- Frost Leather Cloak
	[7378]={b=10731,s=2146,d=14803,c=AUCT_CLAS_ARMOR},  -- Dusky Bracers
	[7386]={b=11937,s=2387,d=14831,c=AUCT_CLAS_ARMOR},  -- Green Whelp Bracers
	[7387]={b=12939,s=2587,d=14832,c=AUCT_CLAS_ARMOR},  -- Dusky Belt
	[7389]={b=0,s=0,d=3426},  -- Venture Co. Ledger
	[7390]={b=21188,s=4237,d=17215,c=AUCT_CLAS_ARMOR},  -- Dusky Boots
	[7391]={b=21265,s=4253,d=28734,c=AUCT_CLAS_ARMOR},  -- Swift Boots
	[7392]={b=800,s=200,d=6646,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_ENCHANT},  -- Green Whelp Scale
	[7406]={b=6861,s=1372,d=6755,c=AUCT_CLAS_ARMOR},  -- Infiltrator Cord
	[7407]={b=18333,s=3666,d=21900,c=AUCT_CLAS_ARMOR},  -- Infiltrator Armor
	[7408]={b=11405,s=2281,d=11270,c=AUCT_CLAS_ARMOR},  -- Infiltrator Shoulders
	[7409]={b=11445,s=2289,d=19043,c=AUCT_CLAS_ARMOR},  -- Infiltrator Boots
	[7410]={b=5873,s=1174,d=14803,c=AUCT_CLAS_ARMOR},  -- Infiltrator Bracers
	[7411]={b=8846,s=1769,d=23043,c=AUCT_CLAS_ARMOR},  -- Infiltrator Cloak
	[7412]={b=6512,s=1302,d=21902,c=AUCT_CLAS_ARMOR},  -- Infiltrator Gloves
	[7413]={b=10785,s=2157,d=21298,c=AUCT_CLAS_ARMOR},  -- Infiltrator Cap
	[7414]={b=15879,s=3175,d=21901,c=AUCT_CLAS_ARMOR},  -- Infiltrator Pants
	[7415]={b=7423,s=1484,d=14950,c=AUCT_CLAS_ARMOR},  -- Dervish Spaulders
	[7416]={b=7213,s=1442,d=26032,c=AUCT_CLAS_ARMOR},  -- Phalanx Bracers
	[7417]={b=14519,s=2903,d=26030,c=AUCT_CLAS_ARMOR},  -- Phalanx Boots
	[7418]={b=21280,s=4256,d=26034,c=AUCT_CLAS_ARMOR},  -- Phalanx Breastplate
	[7419]={b=6631,s=1326,d=26043,c=AUCT_CLAS_ARMOR},  -- Phalanx Cloak
	[7420]={b=13290,s=2658,d=30091,c=AUCT_CLAS_ARMOR},  -- Phalanx Headguard
	[7421]={b=8891,s=1778,d=26036,c=AUCT_CLAS_ARMOR},  -- Phalanx Gauntlets
	[7422]={b=8113,s=1622,d=26037,c=AUCT_CLAS_ARMOR},  -- Phalanx Girdle
	[7423]={b=19709,s=3941,d=26039,c=AUCT_CLAS_ARMOR},  -- Phalanx Leggings
	[7424]={b=13545,s=2709,d=26040,c=AUCT_CLAS_ARMOR},  -- Phalanx Spaulders
	[7428]={b=1000,s=250,d=26371,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Shadowcat Hide
	[7429]={b=23100,s=4620,d=14646,c=AUCT_CLAS_ARMOR},  -- Twilight Armor
	[7430]={b=20974,s=4194,d=14990,c=AUCT_CLAS_ARMOR},  -- Twilight Robe
	[7431]={b=19495,s=3899,d=14644,c=AUCT_CLAS_ARMOR},  -- Twilight Pants
	[7432]={b=13589,s=2717,d=16825,c=AUCT_CLAS_ARMOR},  -- Twilight Cowl
	[7433]={b=8421,s=1684,d=16651,c=AUCT_CLAS_ARMOR},  -- Twilight Gloves
	[7434]={b=12680,s=2536,d=14645,c=AUCT_CLAS_ARMOR},  -- Twilight Boots
	[7435]={b=13747,s=2749,d=14589,c=AUCT_CLAS_ARMOR},  -- Twilight Mantle
	[7436]={b=10558,s=2111,d=15175,c=AUCT_CLAS_ARMOR},  -- Twilight Cape
	[7437]={b=7772,s=1554,d=14647,c=AUCT_CLAS_ARMOR},  -- Twilight Cuffs
	[7438]={b=7802,s=1560,d=14648,c=AUCT_CLAS_ARMOR},  -- Twilight Belt
	[7439]={b=27127,s=5425,d=14995,c=AUCT_CLAS_ARMOR},  -- Sentinel Breastplate
	[7440]={b=25212,s=5042,d=15001,c=AUCT_CLAS_ARMOR},  -- Sentinel Trousers
	[7441]={b=17573,s=3514,d=21311,c=AUCT_CLAS_ARMOR},  -- Sentinel Cap
	[7442]={b=0,s=0,d=14993},  -- Gyromast's Key
	[7443]={b=11217,s=2243,d=15000,c=AUCT_CLAS_ARMOR},  -- Sentinel Gloves
	[7444]={b=16887,s=3377,d=14996,c=AUCT_CLAS_ARMOR},  -- Sentinel Boots
	[7445]={b=18303,s=3660,d=5414,c=AUCT_CLAS_ARMOR},  -- Sentinel Shoulders
	[7446]={b=15462,s=3092,d=23062,c=AUCT_CLAS_ARMOR},  -- Sentinel Cloak
	[7447]={b=10343,s=2068,d=14997,c=AUCT_CLAS_ARMOR},  -- Sentinel Bracers
	[7448]={b=10380,s=2076,d=14999,c=AUCT_CLAS_ARMOR},  -- Sentinel Girdle
	[7449]={b=2500,s=625,d=15274},  -- Pattern: Dusky Leather Leggings
	[7450]={b=2000,s=500,d=1102},  -- Pattern: Green Whelp Armor
	[7451]={b=2800,s=700,d=1102},  -- Pattern: Green Whelp Bracers
	[7452]={b=3500,s=875,d=1102},  -- Pattern: Dusky Boots
	[7453]={b=3500,s=875,d=1102},  -- Pattern: Swift Boots
	[7454]={b=29575,s=5915,d=25862,c=AUCT_CLAS_ARMOR},  -- Knight's Breastplate
	[7455]={b=29688,s=5937,d=25868,c=AUCT_CLAS_ARMOR},  -- Knight's Legguards
	[7456]={b=20695,s=4139,d=30092,c=AUCT_CLAS_ARMOR},  -- Knight's Headguard
	[7457]={b=12823,s=2564,d=25865,c=AUCT_CLAS_ARMOR},  -- Knight's Gauntlets
	[7458]={b=19916,s=3983,d=25860,c=AUCT_CLAS_ARMOR},  -- Knight's Boots
	[7459]={b=21588,s=4317,d=25872,c=AUCT_CLAS_ARMOR},  -- Knight's Pauldrons
	[7460]={b=10004,s=2000,d=26064,c=AUCT_CLAS_ARMOR},  -- Knight's Cloak
	[7461]={b=12149,s=2429,d=25861,c=AUCT_CLAS_ARMOR},  -- Knight's Bracers
	[7462]={b=13412,s=2682,d=25866,c=AUCT_CLAS_ARMOR},  -- Knight's Girdle
	[7463]={b=31013,s=6202,d=4403,c=AUCT_CLAS_WEAPON},  -- Sentinel Buckler
	[7464]={b=0,s=0,d=11180},  -- Glyphs of Summoning
	[7465]={b=33735,s=6747,d=26065,c=AUCT_CLAS_WEAPON},  -- Knight's Crest
	[7468]={b=33815,s=6763,d=15005,c=AUCT_CLAS_ARMOR},  -- Regal Robe
	[7469]={b=31421,s=6284,d=15015,c=AUCT_CLAS_ARMOR},  -- Regal Leggings
	[7470]={b=18341,s=3668,d=15911,c=AUCT_CLAS_ARMOR},  -- Regal Wizard Hat
	[7471]={b=12275,s=2455,d=15008,c=AUCT_CLAS_ARMOR},  -- Regal Gloves
	[7472]={b=17115,s=3423,d=13051,c=AUCT_CLAS_ARMOR},  -- Regal Boots
	[7473]={b=18554,s=3710,d=15014,c=AUCT_CLAS_ARMOR},  -- Regal Mantle
	[7474]={b=16407,s=3281,d=15178,c=AUCT_CLAS_ARMOR},  -- Regal Cloak
	[7475]={b=11856,s=2371,d=15410,c=AUCT_CLAS_ARMOR},  -- Regal Cuffs
	[7476]={b=11019,s=2203,d=15012,c=AUCT_CLAS_ARMOR},  -- Regal Sash
	[7477]={b=40624,s=8124,d=17099,c=AUCT_CLAS_ARMOR},  -- Ranger Tunic
	[7478]={b=34958,s=6991,d=15020,c=AUCT_CLAS_ARMOR},  -- Ranger Leggings
	[7479]={b=24365,s=4873,d=15307,c=AUCT_CLAS_ARMOR},  -- Ranger Helm
	[7480]={b=15095,s=3019,d=15018,c=AUCT_CLAS_ARMOR},  -- Ranger Gloves
	[7481]={b=24541,s=4908,d=15017,c=AUCT_CLAS_ARMOR},  -- Ranger Boots
	[7482]={b=24630,s=4926,d=17194,c=AUCT_CLAS_ARMOR},  -- Ranger Shoulders
	[7483]={b=21192,s=4238,d=23057,c=AUCT_CLAS_ARMOR},  -- Ranger Cloak
	[7484]={b=15314,s=3062,d=15023,c=AUCT_CLAS_ARMOR},  -- Ranger Wristguards
	[7485]={b=15367,s=3073,d=15016,c=AUCT_CLAS_ARMOR},  -- Ranger Cord
	[7486]={b=46628,s=9325,d=22559,c=AUCT_CLAS_ARMOR},  -- Captain's Breastplate
	[7487]={b=43328,s=8665,d=25820,c=AUCT_CLAS_ARMOR},  -- Captain's Leggings
	[7488]={b=30193,s=6038,d=25824,c=AUCT_CLAS_ARMOR},  -- Captain's Circlet
	[7489]={b=18703,s=3740,d=25819,c=AUCT_CLAS_ARMOR},  -- Captain's Gauntlets
	[7490]={b=28403,s=5680,d=25817,c=AUCT_CLAS_ARMOR},  -- Captain's Boots
	[7491]={b=30792,s=6158,d=25822,c=AUCT_CLAS_ARMOR},  -- Captain's Shoulderguards
	[7492]={b=15077,s=3015,d=26018,c=AUCT_CLAS_ARMOR},  -- Captain's Cloak
	[7493]={b=16344,s=3268,d=25818,c=AUCT_CLAS_ARMOR},  -- Captain's Bracers
	[7494]={b=17717,s=3543,d=25821,c=AUCT_CLAS_ARMOR},  -- Captain's Waistguard
	[7495]={b=47792,s=9558,d=18451,c=AUCT_CLAS_WEAPON},  -- Captain's Buckler
	[7496]={b=44412,s=8882,d=18697,c=AUCT_CLAS_WEAPON},  -- Field Plate Shield
	[7498]={b=0,s=0,d=13025},  -- Top of Gelkak's Key
	[7499]={b=0,s=0,d=15123},  -- Middle of Gelkak's Key
	[7500]={b=0,s=0,d=8031},  -- Bottom of Gelkak's Key
	[7506]={b=2000,s=500,d=15150,c=AUCT_CLAS_ARMOR},  -- Gnomish Universal Remote
	[7507]={b=1600,s=400,d=22923,c=AUCT_CLAS_WEAPON},  -- Arcane Orb
	[7508]={b=1600,s=400,d=22923,c=AUCT_CLAS_WEAPON},  -- Ley Orb
	[7509]={b=1376,s=275,d=22958,c=AUCT_CLAS_ARMOR},  -- Manaweave Robe
	[7510]={b=1381,s=276,d=15201,c=AUCT_CLAS_ARMOR},  -- Spellfire Robes
	[7511]={b=6016,s=1203,d=15223,c=AUCT_CLAS_ARMOR},  -- Astral Knot Robe
	[7512]={b=6039,s=1207,d=15232,c=AUCT_CLAS_ARMOR},  -- Nether-lace Robe
	[7513]={b=40856,s=8171,d=25078,c=AUCT_CLAS_WEAPON},  -- Ragefire Wand
	[7514]={b=41009,s=8201,d=25076,c=AUCT_CLAS_WEAPON},  -- Icefury Wand
	[7515]={b=21530,s=5382,d=25072,c=AUCT_CLAS_WEAPON},  -- Celestial Orb
	[7516]={b=0,s=0,d=15274,c=AUCT_CLAS_WRITTEN},  -- Tabetha's Instructions
	[7517]={b=46863,s=9372,d=15398,c=AUCT_CLAS_ARMOR},  -- Gossamer Tunic
	[7518]={b=47031,s=9406,d=15400,c=AUCT_CLAS_ARMOR},  -- Gossamer Robe
	[7519]={b=38175,s=7635,d=15401,c=AUCT_CLAS_ARMOR},  -- Gossamer Pants
	[7520]={b=28737,s=5747,d=15909,c=AUCT_CLAS_ARMOR},  -- Gossamer Headpiece
	[7521]={b=17803,s=3560,d=15405,c=AUCT_CLAS_ARMOR},  -- Gossamer Gloves
	[7522]={b=24814,s=4962,d=15409,c=AUCT_CLAS_ARMOR},  -- Gossamer Boots
	[7523]={b=24965,s=4993,d=15402,c=AUCT_CLAS_ARMOR},  -- Gossamer Shoulderpads
	[7524]={b=21486,s=4297,d=15406,c=AUCT_CLAS_ARMOR},  -- Gossamer Cape
	[7525]={b=15530,s=3106,d=15407,c=AUCT_CLAS_ARMOR},  -- Gossamer Bracers
	[7526]={b=16835,s=3367,d=16838,c=AUCT_CLAS_ARMOR},  -- Gossamer Belt
	[7527]={b=56423,s=11284,d=17094,c=AUCT_CLAS_ARMOR},  -- Cabalist Chestpiece
	[7528]={b=49471,s=9894,d=15416,c=AUCT_CLAS_ARMOR},  -- Cabalist Leggings
	[7529]={b=34486,s=6897,d=21292,c=AUCT_CLAS_ARMOR},  -- Cabalist Helm
	[7530]={b=21366,s=4273,d=15415,c=AUCT_CLAS_ARMOR},  -- Cabalist Gloves
	[7531]={b=32171,s=6434,d=15412,c=AUCT_CLAS_ARMOR},  -- Cabalist Boots
	[7532]={b=34876,s=6975,d=15417,c=AUCT_CLAS_ARMOR},  -- Cabalist Spaulders
	[7533]={b=27789,s=5557,d=23016,c=AUCT_CLAS_ARMOR},  -- Cabalist Cloak
	[7534]={b=20080,s=4016,d=15413,c=AUCT_CLAS_ARMOR},  -- Cabalist Bracers
	[7535]={b=21769,s=4353,d=15411,c=AUCT_CLAS_ARMOR},  -- Cabalist Belt
	[7536]={b=65244,s=13048,d=26099,c=AUCT_CLAS_WEAPON},  -- Champion's Wall Shield
	[7537]={b=70062,s=14012,d=18775,c=AUCT_CLAS_WEAPON},  -- Gothic Shield
	[7538]={b=61612,s=12322,d=26087,c=AUCT_CLAS_ARMOR},  -- Champion's Armor
	[7539]={b=63461,s=12692,d=3193,c=AUCT_CLAS_ARMOR},  -- Champion's Leggings
	[7540]={b=44228,s=8845,d=26098,c=AUCT_CLAS_ARMOR},  -- Champion's Helmet
	[7541]={b=27396,s=5479,d=26089,c=AUCT_CLAS_ARMOR},  -- Champion's Gauntlets
	[7542]={b=41422,s=8284,d=26090,c=AUCT_CLAS_ARMOR},  -- Champion's Greaves
	[7543]={b=40619,s=8123,d=26091,c=AUCT_CLAS_ARMOR},  -- Champion's Pauldrons
	[7544]={b=21484,s=4296,d=26097,c=AUCT_CLAS_ARMOR},  -- Champion's Cape
	[7545]={b=23290,s=4658,d=26088,c=AUCT_CLAS_ARMOR},  -- Champion's Bracers
	[7546]={b=25251,s=5050,d=6926,c=AUCT_CLAS_ARMOR},  -- Champion's Girdle
	[7552]={b=10170,s=2542,d=9832,c=AUCT_CLAS_ARMOR},  -- Falcon's Hook
	[7553]={b=10170,s=2542,d=15422,c=AUCT_CLAS_ARMOR},  -- Band of the Unicorn
	[7554]={b=4158,s=1039,d=15424,c=AUCT_CLAS_WEAPON},  -- Willow Branch
	[7555]={b=28493,s=7123,d=6098,c=AUCT_CLAS_WEAPON},  -- Regal Star
	[7556]={b=21548,s=5387,d=21598,c=AUCT_CLAS_WEAPON},  -- Twilight Orb
	[7557]={b=30385,s=7596,d=15427,c=AUCT_CLAS_WEAPON},  -- Gossamer Rod
	[7558]={b=6438,s=1609,d=15428,c=AUCT_CLAS_WEAPON},  -- Shimmering Stave
	[7559]={b=2665,s=666,d=11919,c=AUCT_CLAS_WEAPON},  -- Runic Cane
	[7560]={b=1200,s=300,d=1102},  -- Schematic: Gnomish Universal Remote
	[7561]={b=2000,s=500,d=1102},  -- Schematic: Goblin Jumper Cables
	[7566]={b=0,s=0,d=16204},  -- Agamand Family Sword
	[7567]={b=0,s=0,d=15471},  -- Agamand Family Axe
	[7568]={b=0,s=0,d=7098},  -- Agamand Family Dagger
	[7569]={b=0,s=0,d=16203},  -- Agamand Family Mace
	[7586]={b=0,s=0,d=7245},  -- Tharnariun's Hope
	[7587]={b=0,s=0,d=15510,c=AUCT_CLAS_WRITTEN},  -- Thun'grim's Instructions
	[7606]={b=2788,s=557,d=15721,c=AUCT_CLAS_ARMOR},  -- Polar Gauntlets
	[7607]={b=6998,s=1399,d=20920,c=AUCT_CLAS_WEAPON},  -- Sable Wand
	[7608]={b=4425,s=1106,d=18494,c=AUCT_CLAS_WEAPON},  -- Seer's Fine Stein
	[7609]={b=16843,s=4210,d=15564,c=AUCT_CLAS_WEAPON},  -- Elder's Amber Stave
	[7610]={b=23245,s=5811,d=21596,c=AUCT_CLAS_WEAPON},  -- Aurora Sphere
	[7611]={b=29458,s=7364,d=15561,c=AUCT_CLAS_WEAPON},  -- Mistscape Stave
	[7613]={b=2000,s=500,d=1102,u=AUCT_TYPE_SMITH},  -- Pattern: Green Leather Armor
	[7626]={b=0,s=0,d=15583},  -- Bundle of Furs
	[7627]={b=0,s=0,d=15590},  -- Dolanaar Delivery
	[7628]={b=0,s=0,d=13125},  -- Nondescript Letter
	[7629]={b=0,s=0,d=362},  -- Ukor's Burden
	[7646]={b=0,s=0,d=11448},  -- Crate of Inn Supplies
	[7666]={b=0,s=0,d=15685,c=AUCT_CLAS_QUEST},  -- Shattered Necklace
	[7667]={b=0,s=0,d=8752},  -- Talvash's Phial of Scrying
	[7668]={b=0,s=0,d=4049,c=AUCT_CLAS_WRITTEN},  -- Bloodstained Journal
	[7669]={b=0,s=0,d=7045},  -- Shattered Necklace Ruby
	[7670]={b=0,s=0,d=1659},  -- Shattered Necklace Sapphire
	[7671]={b=0,s=0,d=18707},  -- Shattered Necklace Topaz
	[7672]={b=0,s=0,d=6014},  -- Shattered Necklace Power Source
	[7673]={b=35961,s=8990,d=9854,c=AUCT_CLAS_ARMOR},  -- Talvash's Enhancing Necklace
	[7674]={b=0,s=0,d=15692},  -- Delivery to Mathias
	[7675]={b=0,s=0,d=9717},  -- Defias Shipping Schedule
	[7676]={b=120,s=30,d=18091,x=10},  -- Thistle Tea
	[7678]={b=200,s=50,d=1102},  -- Recipe: Thistle Tea
	[7679]={b=0,s=0,d=7886,q=20,x=20},  -- Shrike Bat Fang
	[7680]={b=0,s=0,d=3563,q=20,x=20},  -- Jadespine Basilisk Scale
	[7682]={b=38392,s=7678,d=6555,c=AUCT_CLAS_WEAPON},  -- Torturing Poker
	[7683]={b=19792,s=3958,d=15720,c=AUCT_CLAS_WEAPON},  -- Bloody Brass Knuckles
	[7684]={b=10924,s=2184,d=15800,c=AUCT_CLAS_ARMOR},  -- Bloodmage Mantle
	[7685]={b=27340,s=5468,d=15725,c=AUCT_CLAS_WEAPON},  -- Orb of the Forgotten Seer
	[7686]={b=17235,s=4308,d=9834,c=AUCT_CLAS_ARMOR},  -- Ironspine's Eye
	[7687]={b=44180,s=8836,d=15726,c=AUCT_CLAS_WEAPON},  -- Ironspine's Fist
	[7688]={b=26602,s=5320,d=15731,c=AUCT_CLAS_ARMOR},  -- Ironspine's Ribcage
	[7689]={b=55621,s=11124,d=20172,c=AUCT_CLAS_WEAPON},  -- Morbid Dawn
	[7690]={b=11164,s=2232,d=15753,c=AUCT_CLAS_ARMOR},  -- Ebon Vise
	[7691]={b=13445,s=2689,d=16823,c=AUCT_CLAS_ARMOR},  -- Embalmed Shroud
	[7708]={b=33249,s=6649,d=20825,c=AUCT_CLAS_WEAPON},  -- Necrotic Wand
	[7709]={b=17797,s=3559,d=15824,c=AUCT_CLAS_ARMOR},  -- Blighted Leggings
	[7710]={b=61398,s=12279,d=20360,c=AUCT_CLAS_WEAPON},  -- Loksey's Training Stick
	[7711]={b=5855,s=1171,d=12673,c=AUCT_CLAS_ARMOR},  -- Robe of Doan
	[7712]={b=4407,s=881,d=4488,c=AUCT_CLAS_ARMOR},  -- Mantle of Doan
	[7713]={b=23886,s=4777,d=15806,c=AUCT_CLAS_WEAPON},  -- Illusionary Rod
	[7714]={b=19174,s=3834,d=20318,c=AUCT_CLAS_WEAPON},  -- Hypnotic Blade
	[7715]={b=0,s=0,d=9725},  -- Onin's Report
	[7717]={b=94616,s=18923,d=22221,c=AUCT_CLAS_WEAPON},  -- Ravager
	[7718]={b=34338,s=6867,d=15809,c=AUCT_CLAS_ARMOR},  -- Herod's Shoulder
	[7719]={b=34315,s=6863,d=15811,c=AUCT_CLAS_ARMOR},  -- Raging Berserker's Helm
	[7720]={b=26783,s=5356,d=16224,c=AUCT_CLAS_ARMOR},  -- Whitemane's Chapeau
	[7721]={b=89611,s=17922,d=19735,c=AUCT_CLAS_WEAPON},  -- Hand of Righteousness
	[7722]={b=37180,s=9295,d=6522,c=AUCT_CLAS_ARMOR},  -- Triune Amulet
	[7723]={b=112836,s=22567,d=21252,c=AUCT_CLAS_WEAPON},  -- Mograine's Might
	[7724]={b=27180,s=5436,d=16223,c=AUCT_CLAS_ARMOR},  -- Gauntlets of Divinity
	[7726]={b=58406,s=11681,d=18751,c=AUCT_CLAS_WEAPON},  -- Aegis of the Scarlet Commander
	[7727]={b=12444,s=2488,d=17197,c=AUCT_CLAS_ARMOR},  -- Watchman Pauldrons
	[7728]={b=16118,s=3223,d=19109,c=AUCT_CLAS_ARMOR},  -- Beguiler Robes
	[7729]={b=27573,s=5514,d=15821,c=AUCT_CLAS_WEAPON},  -- Chesterfall Musket
	[7730]={b=50732,s=10146,d=15466,c=AUCT_CLAS_WEAPON},  -- Cobalt Crusher
	[7731]={b=13930,s=3482,d=15420,c=AUCT_CLAS_ARMOR},  -- Ghostshard Talisman
	[7733]={b=0,s=0,d=15828},  -- Staff of Prehistoria
	[7734]={b=61980,s=15495,d=3410,c=AUCT_CLAS_ARMOR},  -- Six Demon Bag
	[7735]={b=0,s=0,d=13489},  -- Jannok's Rose
	[7736]={b=59854,s=11970,d=5224,c=AUCT_CLAS_WEAPON},  -- Fight Club
	[7737]={b=0,s=0,d=1246},  -- Sethir's Journal
	[7738]={b=1058,s=211,d=16815,c=AUCT_CLAS_ARMOR},  -- Evergreen Gloves
	[7739]={b=2401,s=480,d=15866,c=AUCT_CLAS_ARMOR},  -- Timberland Cape
	[7740]={b=0,s=0,d=7366},  -- Gni'kiv Medallion
	[7741]={b=0,s=0,d=15867},  -- The Shaft of Tsol
	[7742]={b=2400,s=600,d=1102},  -- Schematic: Gnomish Cloaking Device
	[7746]={b=33720,s=8430,d=7899,c=AUCT_CLAS_ARMOR},  -- Explorers' League Commendation
	[7747]={b=38774,s=7754,d=18792,c=AUCT_CLAS_WEAPON},  -- Vile Protector
	[7748]={b=54312,s=10862,d=4405,c=AUCT_CLAS_WEAPON},  -- Forcestone Buckler
	[7749]={b=19540,s=4885,d=21595,c=AUCT_CLAS_WEAPON},  -- Omega Orb
	[7750]={b=8562,s=1712,d=13673,c=AUCT_CLAS_ARMOR},  -- Mantle of Woe
	[7751]={b=8072,s=1614,d=15886,c=AUCT_CLAS_ARMOR},  -- Vorrel's Boots
	[7752]={b=34514,s=6902,d=19670,c=AUCT_CLAS_WEAPON},  -- Dreamslayer
	[7753]={b=39371,s=7874,d=19371,c=AUCT_CLAS_WEAPON},  -- Bloodspiller
	[7754]={b=9798,s=1959,d=15889,c=AUCT_CLAS_ARMOR},  -- Harbinger Boots
	[7755]={b=20702,s=4140,d=15890,c=AUCT_CLAS_ARMOR},  -- Flintrock Shoulders
	[7756]={b=8030,s=1606,d=15894,c=AUCT_CLAS_ARMOR},  -- Dog Training Gloves
	[7757]={b=64374,s=12874,d=20316,c=AUCT_CLAS_WEAPON},  -- Windweaver Staff
	[7758]={b=75370,s=15074,d=22238,c=AUCT_CLAS_WEAPON},  -- Ruthless Shiv
	[7759]={b=33619,s=6723,d=15897,c=AUCT_CLAS_ARMOR},  -- Archon Chestpiece
	[7760]={b=30371,s=6074,d=21404,c=AUCT_CLAS_ARMOR},  -- Warchief Kilt
	[7761]={b=56453,s=11290,d=19210,c=AUCT_CLAS_WEAPON},  -- Steelclaw Reaver
	[7766]={b=0,s=0,d=29438},  -- Empty Brown Waterskin
	[7767]={b=0,s=0,d=29434},  -- Empty Blue Waterskin
	[7768]={b=0,s=0,d=29436},  -- Empty Red Waterskin
	[7769]={b=0,s=0,d=29439},  -- Filled Brown Waterskin
	[7770]={b=0,s=0,d=29435},  -- Filled Blue Waterskin
	[7771]={b=0,s=0,d=29437},  -- Filled Red Waterskin
	[7786]={b=28028,s=5605,d=15938,c=AUCT_CLAS_WEAPON},  -- Headsplitter
	[7787]={b=19802,s=3960,d=18455,c=AUCT_CLAS_WEAPON},  -- Resplendent Guardian
	[7806]={b=40,s=10,d=15963,x=20},  -- Lollipop
	[7807]={b=40,s=10,d=15964,x=20},  -- Candy Bar
	[7808]={b=40,s=10,d=15965,x=20},  -- Chocolate Square
	[7809]={b=5124,s=1024,d=15966,c=AUCT_CLAS_ARMOR},  -- Easter Dress
	[7810]={b=0,s=0,d=15794},  -- Vial of Purest Water
	[7811]={b=0,s=0,d=4836},  -- Remaining Drops of Purest Water
	[7812]={b=0,s=0,d=4829},  -- Corrupt Manifestation's Bracers
	[7813]={b=0,s=0,d=1659},  -- Shard of Water
	[7846]={b=0,s=0,d=7886,q=20,x=20},  -- Crag Coyote Fang
	[7847]={b=0,s=0,d=1438,q=20,x=20},  -- Buzzard Gizzard
	[7848]={b=0,s=0,d=18500,q=20,x=20},  -- Rock Elemental Shard
	[7866]={b=0,s=0,d=16023},  -- Empty Thaumaturgy Vessel
	[7867]={b=0,s=0,d=16024,q=20,x=20},  -- Vessel of Dragon's Blood
	[7870]={b=0,s=0,d=18721},  -- Thaumaturgy Vessel Lockbox
	[7871]={b=0,s=0,d=6357},  -- Token of Thievery
	[7886]={b=0,s=0,d=4049},  -- Untranslated Journal
	[7887]={b=0,s=0,d=16052},  -- Necklace and Gem Salvage
	[7888]={b=35961,s=8990,d=9854,c=AUCT_CLAS_ARMOR},  -- Jarkal's Enhancing Necklace
	[7906]={b=0,s=0,d=16283},  -- Horns of Nez'ra
	[7907]={b=0,s=0,d=16065,c=AUCT_CLAS_WRITTEN},  -- Certificate of Thievery
	[7908]={b=0,s=0,d=1134,c=AUCT_CLAS_WRITTEN},  -- Klaven Mortwake's Journal
	[7909]={b=4000,s=1000,d=13496,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_ENGINEER},  -- Aquamarine
	[7910]={b=20000,s=5000,d=4777,x=20,c=AUCT_CLAS_GEM,u=AUCT_TYPE_ENGINEER},  -- Star Ruby
	[7911]={b=2000,s=500,d=20657,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_MINING},  -- Truesilver Ore
	[7912]={b=400,s=100,d=4719,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH},  -- Solid Stone
	[7913]={b=12502,s=2500,d=16081,c=AUCT_CLAS_ARMOR},  -- Barbaric Iron Shoulders
	[7914]={b=16654,s=3330,d=16080,c=AUCT_CLAS_ARMOR},  -- Barbaric Iron Breastplate
	[7915]={b=16686,s=3337,d=16084,c=AUCT_CLAS_ARMOR},  -- Barbaric Iron Helm
	[7916]={b=18502,s=3700,d=16086,c=AUCT_CLAS_ARMOR},  -- Barbaric Iron Boots
	[7917]={b=13557,s=2711,d=16087,c=AUCT_CLAS_ARMOR},  -- Barbaric Iron Gloves
	[7918]={b=18508,s=3701,d=16089,c=AUCT_CLAS_ARMOR},  -- Heavy Mithril Shoulder
	[7919]={b=12382,s=2476,d=16091,c=AUCT_CLAS_ARMOR},  -- Heavy Mithril Gauntlet
	[7920]={b=40265,s=8053,d=3409,c=AUCT_CLAS_ARMOR},  -- Mithril Scale Pants
	[7921]={b=26936,s=5387,d=16092,c=AUCT_CLAS_ARMOR},  -- Heavy Mithril Pants
	[7922]={b=11885,s=2377,d=16093,c=AUCT_CLAS_ARMOR},  -- Steel Plate Helm
	[7923]={b=0,s=0,d=16100},  -- Defias Tower Key
	[7924]={b=20516,s=4103,d=6985,c=AUCT_CLAS_ARMOR},  -- Mithril Scale Bracers
	[7926]={b=29761,s=5952,d=16103,c=AUCT_CLAS_ARMOR},  -- Ornate Mithril Pants
	[7927]={b=14935,s=2987,d=16105,c=AUCT_CLAS_ARMOR},  -- Ornate Mithril Gloves
	[7928]={b=24286,s=4857,d=16106,c=AUCT_CLAS_ARMOR},  -- Ornate Mithril Shoulder
	[7929]={b=38698,s=7739,d=23538,c=AUCT_CLAS_ARMOR},  -- Orcish War Leggings
	[7930]={b=35228,s=7045,d=16109,c=AUCT_CLAS_ARMOR},  -- Heavy Mithril Breastplate
	[7931]={b=39778,s=7955,d=16110,c=AUCT_CLAS_ARMOR},  -- Mithril Coif
	[7932]={b=43309,s=8661,d=16111,c=AUCT_CLAS_ARMOR},  -- Mithril Scale Shoulders
	[7933]={b=28847,s=5769,d=16113,c=AUCT_CLAS_ARMOR},  -- Heavy Mithril Boots
	[7934]={b=28952,s=5790,d=16115,c=AUCT_CLAS_ARMOR},  -- Heavy Mithril Helm
	[7935]={b=41842,s=8368,d=16117,c=AUCT_CLAS_ARMOR},  -- Ornate Mithril Breastplate
	[7936]={b=33696,s=6739,d=16118,c=AUCT_CLAS_ARMOR},  -- Ornate Mithril Boots
	[7937]={b=33818,s=6763,d=16119,c=AUCT_CLAS_ARMOR},  -- Ornate Mithril Helm
	[7938]={b=20142,s=4028,d=16124,c=AUCT_CLAS_ARMOR},  -- Truesilver Gauntlets
	[7939]={b=54496,s=10899,d=24393,c=AUCT_CLAS_ARMOR},  -- Truesilver Breastplate
	[7941]={b=62601,s=12520,d=16126,c=AUCT_CLAS_WEAPON},  -- Heavy Mithril Axe
	[7942]={b=73296,s=14659,d=5639,c=AUCT_CLAS_WEAPON},  -- Blue Glittering Axe
	[7943]={b=79459,s=15891,d=16128,c=AUCT_CLAS_WEAPON},  -- Wicked Mithril Blade
	[7944]={b=100463,s=20092,d=20221,c=AUCT_CLAS_WEAPON},  -- Dazzling Mithril Rapier
	[7945]={b=86455,s=17291,d=5223,c=AUCT_CLAS_WEAPON},  -- Big Black Mace
	[7946]={b=108304,s=21660,d=15887,c=AUCT_CLAS_WEAPON},  -- Runed Mithril Hammer
	[7947]={b=124460,s=24892,d=16130,c=AUCT_CLAS_WEAPON},  -- Ebon Shiv
	[7954]={b=115799,s=23159,d=19748,c=AUCT_CLAS_WEAPON},  -- The Shatterer
	[7955]={b=1208,s=241,d=20071,c=AUCT_CLAS_WEAPON},  -- Copper Claymore
	[7956]={b=9722,s=1944,d=16146,c=AUCT_CLAS_WEAPON},  -- Bronze Warhammer
	[7957]={b=11028,s=2205,d=16147,c=AUCT_CLAS_WEAPON},  -- Bronze Greatsword
	[7958]={b=12178,s=2435,d=19272,c=AUCT_CLAS_WEAPON},  -- Bronze Battle Axe
	[7959]={b=169289,s=33857,d=22234,c=AUCT_CLAS_WEAPON},  -- Blight
	[7960]={b=192743,s=38548,d=23264,c=AUCT_CLAS_WEAPON},  -- Truesilver Champion
	[7961]={b=127541,s=25508,d=25053,c=AUCT_CLAS_WEAPON},  -- Phantom Blade
	[7963]={b=32440,s=6488,d=16184,c=AUCT_CLAS_ARMOR},  -- Steel Breastplate
	[7964]={b=160,s=40,d=24676,x=20},  -- Solid Sharpening Stone
	[7965]={b=160,s=40,d=24686,x=20},  -- Solid Weightstone
	[7966]={b=800,s=200,d=24681,x=20},  -- Solid Grinding Stone
	[7967]={b=1000,s=250,d=16189,x=5},  -- Mithril Shield Spike
	[7968]={b=0,s=0,d=16190},  -- Southsea Treasure
	[7969]={b=1000,s=250,d=16205},  -- Mithril Spurs
	[7970]={b=0,s=0,d=16206},  -- E.C.A.C.
	[7971]={b=4000,s=1000,d=16209,x=20,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER},  -- Black Pearl
	[7972]={b=1600,s=400,d=16210,x=10,u=AUCT_TYPE_ENCHANT},  -- Ichor of Undeath
	[7973]={b=185,s=46,d=16211},  -- Big-mouth Clam
	[7974]={b=200,s=50,d=22193,x=10,u=AUCT_TYPE_COOK},  -- Zesty Clam Meat
	[7975]={b=6000,s=1500,d=15274},  -- Plans: Heavy Mithril Pants
	[7976]={b=8000,s=2000,d=1102},  -- Plans: Mithril Shield Spike
	[7978]={b=3000,s=750,d=15274},  -- Plans: Barbaric Iron Shoulders
	[7979]={b=3000,s=750,d=15274},  -- Plans: Barbaric Iron Breastplate
	[7980]={b=3400,s=850,d=15274},  -- Plans: Barbaric Iron Helm
	[7981]={b=4400,s=1100,d=15274},  -- Plans: Barbaric Iron Boots
	[7982]={b=4400,s=1100,d=15274},  -- Plans: Barbaric Iron Gloves
	[7983]={b=8000,s=2000,d=15274},  -- Plans: Ornate Mithril Pants
	[7984]={b=8000,s=2000,d=15274},  -- Plans: Ornate Mithril Gloves
	[7985]={b=8000,s=2000,d=15274},  -- Plans: Ornate Mithril Shoulder
	[7989]={b=10000,s=2500,d=15274},  -- Plans: Mithril Spurs
	[7990]={b=10000,s=2500,d=15274},  -- Plans: Heavy Mithril Helm
	[7991]={b=10000,s=2500,d=1102},  -- Plans: Mithril Scale Shoulders
	[7992]={b=8000,s=2000,d=15274},  -- Plans: Blue Glittering Axe
	[7993]={b=10000,s=2500,d=15274},  -- Plans: Dazzling Mithril Rapier
	[7995]={b=6000,s=1500,d=15274},  -- Plans: Mithril Scale Bracers
	[7997]={b=406,s=81,d=15308,c=AUCT_CLAS_ARMOR},  -- Red Defias Mask
	[8006]={b=62360,s=12472,d=20326,c=AUCT_CLAS_WEAPON},  -- The Ziggler
	[8007]={b=0,s=0,d=6496,c=AUCT_CLAS_MAGE},  -- Mana Citrine
	[8008]={b=0,s=0,d=7045,c=AUCT_CLAS_MAGE},  -- Mana Ruby
	[8009]={b=0,s=0,d=17923,q=20,x=20},  -- Dentrium Power Stone
	[8026]={b=0,s=0,d=18722},  -- Garrett Family Treasure
	[8027]={b=0,s=0,d=18718},  -- Krom Stoutarm's Treasure
	[8028]={b=10000,s=2500,d=1102},  -- Plans: Runed Mithril Hammer
	[8029]={b=8000,s=2000,d=15274},  -- Plans: Wicked Mithril Blade
	[8030]={b=10000,s=2500,d=1301},  -- Plans: Ebon Shiv
	[8046]={b=0,s=0,d=6672,c=AUCT_CLAS_WRITTEN},  -- Kearnen's Journal
	[8047]={b=0,s=0,d=18719,q=20,x=20},  -- Magenta Fungus Cap
	[8048]={b=0,s=0,d=16300},  -- Emerald Dreamcatcher
	[8049]={b=0,s=0,d=6539},  -- Gnarlpine Necklace
	[8050]={b=0,s=0,d=6851},  -- Tallonkai's Jewel
	[8051]={b=0,s=0,d=16299},  -- Flare Gun
	[8052]={b=0,s=0,d=17922,q=20,x=20},  -- An'Alleum Power Stone
	[8053]={b=0,s=0,d=12410},  -- Obsidian Power Source
	[8066]={b=0,s=0,d=16303},  -- Fizzule's Whistle
	[8067]={b=10,s=0,d=5998,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Crafted Light Shot
	[8068]={b=50,s=0,d=5998,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Crafted Heavy Shot
	[8069]={b=300,s=0,d=5998,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Crafted Solid Shot
	[8070]={b=0,s=0,d=3029},  -- Reward Voucher
	[8071]={b=7673,s=1534,d=6093,c=AUCT_CLAS_WEAPON},  -- Sizzle Stick
	[8072]={b=0,s=0,d=9154},  -- Silixiz's Tower Key
	[8073]={b=0,s=0,d=16321},  -- Cache of Zanzil's Altered Mixture
	[8074]={b=0,s=0,d=16322},  -- Gallywix's Head
	[8075]={b=0,s=0,d=6399,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Conjured Sourdough
	[8076]={b=0,s=0,d=21203,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Conjured Sweet Roll
	[8077]={b=0,s=0,d=18078,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Conjured Mineral Water
	[8078]={b=0,s=0,d=18080,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Conjured Sparkling Water
	[8079]={b=0,s=0,d=21794,q=20,x=20},  -- Conjured Crystal Water
	[8080]={b=29936,s=5987,d=28398,c=AUCT_CLAS_ARMOR},  -- Light Plate Chestpiece
	[8081]={b=14172,s=2834,d=28399,c=AUCT_CLAS_ARMOR},  -- Light Plate Belt
	[8082]={b=15945,s=3189,d=28404,c=AUCT_CLAS_ARMOR},  -- Light Plate Boots
	[8083]={b=11308,s=2261,d=9388,c=AUCT_CLAS_ARMOR},  -- Light Plate Bracers
	[8084]={b=13517,s=2703,d=28401,c=AUCT_CLAS_ARMOR},  -- Light Plate Gloves
	[8085]={b=26269,s=5253,d=28402,c=AUCT_CLAS_ARMOR},  -- Light Plate Pants
	[8086]={b=18652,s=3730,d=28403,c=AUCT_CLAS_ARMOR},  -- Light Plate Shoulderpads
	[8087]={b=0,s=0,d=9731},  -- Sample of Zanzil's Altered Mixture
	[8088]={b=13335,s=2667,d=28395,c=AUCT_CLAS_ARMOR},  -- Platemail Belt
	[8089]={b=20081,s=4016,d=28396,c=AUCT_CLAS_ARMOR},  -- Platemail Boots
	[8090]={b=13439,s=2687,d=25829,c=AUCT_CLAS_ARMOR},  -- Platemail Bracers
	[8091]={b=13489,s=2697,d=28397,c=AUCT_CLAS_ARMOR},  -- Platemail Gloves
	[8092]={b=20312,s=4062,d=15340,c=AUCT_CLAS_ARMOR},  -- Platemail Helm
	[8093]={b=27186,s=5437,d=25833,c=AUCT_CLAS_ARMOR},  -- Platemail Leggings
	[8094]={b=27290,s=5458,d=28394,c=AUCT_CLAS_ARMOR},  -- Platemail Armor
	[8095]={b=0,s=0,d=16325,c=AUCT_CLAS_POTION},  -- Hinott's Oil
	[8106]={b=52194,s=10438,d=16631,c=AUCT_CLAS_ARMOR},  -- Hibernal Armor
	[8107]={b=29692,s=5938,d=16634,c=AUCT_CLAS_ARMOR},  -- Hibernal Boots
	[8108]={b=17972,s=3594,d=16636,c=AUCT_CLAS_ARMOR},  -- Hibernal Bracers
	[8109]={b=25059,s=5011,d=23107,c=AUCT_CLAS_ARMOR},  -- Hibernal Cloak
	[8110]={b=18110,s=3622,d=16633,c=AUCT_CLAS_ARMOR},  -- Hibernal Gloves
	[8111]={b=29452,s=5890,d=16637,c=AUCT_CLAS_ARMOR},  -- Hibernal Mantle
	[8112]={b=42181,s=8436,d=16632,c=AUCT_CLAS_ARMOR},  -- Hibernal Pants
	[8113]={b=48473,s=9694,d=19901,c=AUCT_CLAS_ARMOR},  -- Hibernal Robe
	[8114]={b=18388,s=3677,d=21459,c=AUCT_CLAS_ARMOR},  -- Hibernal Sash
	[8115]={b=29902,s=5980,d=16638,c=AUCT_CLAS_ARMOR},  -- Hibernal Cowl
	[8116]={b=23160,s=4632,d=16920,c=AUCT_CLAS_ARMOR},  -- Heraldic Belt
	[8117]={b=35808,s=7161,d=14701,c=AUCT_CLAS_ARMOR},  -- Heraldic Boots
	[8118]={b=22184,s=4436,d=14700,c=AUCT_CLAS_ARMOR},  -- Heraldic Bracers
	[8119]={b=63629,s=12725,d=28737,c=AUCT_CLAS_ARMOR},  -- Heraldic Breastplate
	[8120]={b=31036,s=6207,d=23038,c=AUCT_CLAS_ARMOR},  -- Heraldic Cloak
	[8121]={b=24219,s=4843,d=14698,c=AUCT_CLAS_ARMOR},  -- Heraldic Gloves
	[8122]={b=39377,s=7875,d=21300,c=AUCT_CLAS_ARMOR},  -- Heraldic Headpiece
	[8123]={b=56379,s=11275,d=14697,c=AUCT_CLAS_ARMOR},  -- Heraldic Leggings
	[8124]={b=39660,s=7932,d=14696,c=AUCT_CLAS_ARMOR},  -- Heraldic Spaulders
	[8125]={b=31837,s=6367,d=26103,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Bracers
	[8126]={b=78284,s=15656,d=26105,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Breastplate
	[8127]={b=29689,s=5937,d=26118,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Cape
	[8128]={b=31148,s=6229,d=26107,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Gauntlets
	[8129]={b=31269,s=6253,d=26108,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Girdle
	[8130]={b=47294,s=9458,d=26109,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Greaves
	[8131]={b=50576,s=10115,d=26115,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Helm
	[8132]={b=72426,s=14485,d=26110,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Leggings
	[8133]={b=52585,s=10517,d=26114,c=AUCT_CLAS_ARMOR},  -- Myrmidon's Pauldrons
	[8134]={b=79966,s=15993,d=26120,c=AUCT_CLAS_WEAPON},  -- Myrmidon's Defender
	[8135]={b=56171,s=11234,d=27339,c=AUCT_CLAS_WEAPON},  -- Chromite Shield
	[8136]={b=0,s=0,d=1438},  -- Gargantuan Tumor
	[8137]={b=14035,s=2807,d=27329,c=AUCT_CLAS_ARMOR},  -- Chromite Bracers
	[8138]={b=38330,s=7666,d=27330,c=AUCT_CLAS_ARMOR},  -- Chromite Chestplate
	[8139]={b=15269,s=3053,d=27331,c=AUCT_CLAS_ARMOR},  -- Chromite Gauntlets
	[8140]={b=14188,s=2837,d=27332,c=AUCT_CLAS_ARMOR},  -- Chromite Girdle
	[8141]={b=23068,s=4613,d=27334,c=AUCT_CLAS_ARMOR},  -- Chromite Greaves
	[8142]={b=23152,s=4630,d=27338,c=AUCT_CLAS_ARMOR},  -- Chromite Barbute
	[8143]={b=36135,s=7227,d=27335,c=AUCT_CLAS_ARMOR},  -- Chromite Legplates
	[8144]={b=25181,s=5036,d=27336,c=AUCT_CLAS_ARMOR},  -- Chromite Pauldrons
	[8146]={b=2000,s=500,d=3146,x=5,u=AUCT_TYPE_LEATHER},  -- Wicked Claw
	[8149]={b=0,s=0,d=16456},  -- Voodoo Charm
	[8150]={b=1000,s=250,d=6396,x=20,u=AUCT_TYPE_LEATHER},  -- Deeprock Salt
	[8151]={b=1000,s=250,d=1249,x=20,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_LEATHER},  -- Flask of Mojo
	[8152]={b=2000,s=500,d=2533,x=20,u=AUCT_TYPE_LEATHER},  -- Flask of Big Mojo
	[8153]={b=20,s=5,d=7346,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Wildvine
	[8154]={b=1000,s=250,d=2874,x=20,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Scorpid Scale
	[8155]={b=0,s=0,d=16464},  -- Sathrah's Sacrifice
	[8156]={b=11099,s=2219,d=27345,c=AUCT_CLAS_ARMOR},  -- Jouster's Wristguards
	[8157]={b=25989,s=5197,d=27340,c=AUCT_CLAS_ARMOR},  -- Jouster's Chestplate
	[8158]={b=11181,s=2236,d=27341,c=AUCT_CLAS_ARMOR},  -- Jouster's Gauntlets
	[8159]={b=11221,s=2244,d=27342,c=AUCT_CLAS_ARMOR},  -- Jouster's Girdle
	[8160]={b=16893,s=3378,d=27343,c=AUCT_CLAS_ARMOR},  -- Jouster's Greaves
	[8161]={b=16954,s=3390,d=27347,c=AUCT_CLAS_ARMOR},  -- Jouster's Visor
	[8162]={b=24500,s=4900,d=27344,c=AUCT_CLAS_ARMOR},  -- Jouster's Legplates
	[8163]={b=18441,s=3688,d=27346,c=AUCT_CLAS_ARMOR},  -- Jouster's Pauldrons
	[8164]={b=10,s=2,d=1069,x=10},  -- Test Stationery
	[8165]={b=2000,s=500,d=22838,x=20,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Worn Dragonscale
	[8167]={b=400,s=100,d=21363,x=20,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Turtle Scale
	[8168]={b=400,s=100,d=19531,x=20,u=AUCT_TYPE_LEATHER},  -- Jet Black Feather
	[8169]={b=2000,s=500,d=8952,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Thick Hide
	[8170]={b=2000,s=500,d=16474,x=10,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Rugged Leather
	[8171]={b=2000,s=500,d=8794,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Rugged Hide
	[8172]={b=2000,s=500,d=7354,x=10,c=AUCT_CLAS_HIDE,u=AUCT_TYPE_LEATHER},  -- Cured Thick Hide
	[8173]={b=4000,s=1000,d=26389,x=10},  -- Thick Armor Kit
	[8174]={b=20657,s=4131,d=17213,c=AUCT_CLAS_ARMOR},  -- Comfortable Leather Hat
	[8175]={b=29857,s=5971,d=16482,c=AUCT_CLAS_ARMOR},  -- Nightscape Tunic
	[8176]={b=22475,s=4495,d=16483,c=AUCT_CLAS_ARMOR},  -- Nightscape Headband
	[8177]={b=358,s=71,d=18354,c=AUCT_CLAS_WEAPON},  -- Practice Sword
	[8178]={b=1531,s=306,d=26591,c=AUCT_CLAS_WEAPON},  -- Training Sword
	[8179]={b=144,s=28,d=18343,c=AUCT_CLAS_WEAPON},  -- Cadet's Bow
	[8180]={b=1203,s=240,d=18350,c=AUCT_CLAS_WEAPON},  -- Hunting Bow
	[8181]={b=397,s=79,d=20728,c=AUCT_CLAS_WEAPON},  -- Hunting Rifle
	[8182]={b=203,s=40,d=20741,c=AUCT_CLAS_WEAPON},  -- Pellet Rifle
	[8183]={b=12132,s=2426,d=18355,c=AUCT_CLAS_WEAPON},  -- Precision Bow
	[8184]={b=14736,s=2947,d=18346,c=AUCT_CLAS_WEAPON},  -- Firestarter
	[8185]={b=54764,s=10952,d=16487,c=AUCT_CLAS_ARMOR},  -- Turtle Scale Leggings
	[8186]={b=11155,s=2231,d=20851,c=AUCT_CLAS_WEAPON},  -- Dire Wand
	[8187]={b=17387,s=3477,d=16488,c=AUCT_CLAS_ARMOR},  -- Turtle Scale Gloves
	[8188]={b=32071,s=6414,d=20735,c=AUCT_CLAS_WEAPON},  -- Explosive Shotgun
	[8189]={b=37838,s=7567,d=11598,c=AUCT_CLAS_ARMOR},  -- Turtle Scale Breastplate
	[8190]={b=186433,s=37286,d=20081,c=AUCT_CLAS_WEAPON},  -- Hanzo Sword
	[8191]={b=38900,s=7780,d=16492,c=AUCT_CLAS_ARMOR},  -- Turtle Scale Helm
	[8192]={b=23914,s=4782,d=16497,c=AUCT_CLAS_ARMOR},  -- Nightscape Shoulders
	[8193]={b=43542,s=8708,d=17151,c=AUCT_CLAS_ARMOR},  -- Nightscape Pants
	[8194]={b=69388,s=13877,d=19721,c=AUCT_CLAS_WEAPON},  -- Goblin Nutcracker
	[8196]={b=69895,s=13979,d=26572,c=AUCT_CLAS_WEAPON},  -- Ebon Scimitar
	[8197]={b=35790,s=7158,d=16505,c=AUCT_CLAS_ARMOR},  -- Nightscape Boots
	[8198]={b=20068,s=4013,d=16506,c=AUCT_CLAS_ARMOR},  -- Turtle Scale Bracers
	[8199]={b=123306,s=24661,d=18342,c=AUCT_CLAS_WEAPON},  -- Battlefield Destroyer
	[8200]={b=36378,s=7275,d=16508,c=AUCT_CLAS_ARMOR},  -- Big Voodoo Robe
	[8201]={b=26754,s=5350,d=25711,c=AUCT_CLAS_ARMOR},  -- Big Voodoo Mask
	[8202]={b=45112,s=9022,d=16510,c=AUCT_CLAS_ARMOR},  -- Big Voodoo Pants
	[8203]={b=43140,s=8628,d=16513,c=AUCT_CLAS_ARMOR},  -- Tough Scorpid Breastplate
	[8204]={b=23382,s=4676,d=16515,c=AUCT_CLAS_ARMOR},  -- Tough Scorpid Gloves
	[8205]={b=21734,s=4346,d=16516,c=AUCT_CLAS_ARMOR},  -- Tough Scorpid Bracers
	[8206]={b=63521,s=12704,d=16517,c=AUCT_CLAS_ARMOR},  -- Tough Scorpid Leggings
	[8207]={b=44892,s=8978,d=16519,c=AUCT_CLAS_ARMOR},  -- Tough Scorpid Shoulders
	[8208]={b=51360,s=10272,d=16520,c=AUCT_CLAS_ARMOR},  -- Tough Scorpid Helm
	[8209]={b=41879,s=8375,d=16521,c=AUCT_CLAS_ARMOR},  -- Tough Scorpid Boots
	[8210]={b=27685,s=5537,d=25691,c=AUCT_CLAS_ARMOR},  -- Wild Leather Shoulders
	[8211]={b=40012,s=8002,d=25689,c=AUCT_CLAS_ARMOR},  -- Wild Leather Vest
	[8212]={b=57925,s=11585,d=18935,c=AUCT_CLAS_ARMOR},  -- Wild Leather Leggings
	[8213]={b=40753,s=8150,d=4389,c=AUCT_CLAS_ARMOR},  -- Wild Leather Boots
	[8214]={b=31151,s=6230,d=25693,c=AUCT_CLAS_ARMOR},  -- Wild Leather Helmet
	[8215]={b=45086,s=9017,d=23081,c=AUCT_CLAS_ARMOR},  -- Wild Leather Cloak
	[8216]={b=31617,s=6323,d=24297,c=AUCT_CLAS_ARMOR},  -- Big Voodoo Cloak
	[8217]={b=4000,s=1000,d=21331,c=AUCT_CLAS_CONTAINER},  -- Quickdraw Quiver
	[8218]={b=4000,s=1000,d=1281,c=AUCT_CLAS_CONTAINER},  -- Thick Leather Ammo Pouch
	[8223]={b=50333,s=10066,d=20073,c=AUCT_CLAS_WEAPON},  -- Blade of the Basilisk
	[8224]={b=38278,s=7655,d=22232,c=AUCT_CLAS_WEAPON},  -- Silithid Ripper
	[8225]={b=46111,s=9222,d=20076,c=AUCT_CLAS_WEAPON},  -- Tainted Pierce
	[8226]={b=28737,s=5747,d=16539,c=AUCT_CLAS_WEAPON},  -- The Butcher
	[8244]={b=0,s=10000,d=18704,q=20,x=20},  -- Flawless Draenethyst Sphere
	[8245]={b=64614,s=12922,d=17211,c=AUCT_CLAS_ARMOR},  -- Imperial Red Tunic
	[8246]={b=39586,s=7917,d=16766,c=AUCT_CLAS_ARMOR},  -- Imperial Red Boots
	[8247]={b=24988,s=4997,d=17229,c=AUCT_CLAS_ARMOR},  -- Imperial Red Bracers
	[8248]={b=35161,s=7032,d=17238,c=AUCT_CLAS_ARMOR},  -- Imperial Red Cloak
	[8249]={b=26682,s=5336,d=17216,c=AUCT_CLAS_ARMOR},  -- Imperial Red Gloves
	[8250]={b=40170,s=8034,d=17234,c=AUCT_CLAS_ARMOR},  -- Imperial Red Mantle
	[8251]={b=60401,s=12080,d=16764,c=AUCT_CLAS_ARMOR},  -- Imperial Red Pants
	[8252]={b=68114,s=13622,d=17236,c=AUCT_CLAS_ARMOR},  -- Imperial Red Robe
	[8253]={b=25539,s=5107,d=17228,c=AUCT_CLAS_ARMOR},  -- Imperial Red Sash
	[8254]={b=43199,s=8639,d=18728,c=AUCT_CLAS_ARMOR},  -- Imperial Red Circlet
	[8255]={b=30052,s=6010,d=15411,c=AUCT_CLAS_ARMOR},  -- Serpentskin Girdle
	[8256]={b=51306,s=10261,d=17258,c=AUCT_CLAS_ARMOR},  -- Serpentskin Boots
	[8257]={b=30265,s=6053,d=17259,c=AUCT_CLAS_ARMOR},  -- Serpentskin Bracers
	[8258]={b=86983,s=17396,d=18470,c=AUCT_CLAS_ARMOR},  -- Serpentskin Armor
	[8259]={b=45721,s=9144,d=23063,c=AUCT_CLAS_ARMOR},  -- Serpentskin Cloak
	[8260]={b=34691,s=6938,d=17263,c=AUCT_CLAS_ARMOR},  -- Serpentskin Gloves
	[8261]={b=53086,s=10617,d=17321,c=AUCT_CLAS_ARMOR},  -- Serpentskin Helm
	[8262]={b=73029,s=14605,d=17265,c=AUCT_CLAS_ARMOR},  -- Serpentskin Leggings
	[8263]={b=51866,s=10373,d=17267,c=AUCT_CLAS_ARMOR},  -- Serpentskin Spaulders
	[8264]={b=39287,s=7857,d=28451,c=AUCT_CLAS_ARMOR},  -- Ebonhold Wristguards
	[8265]={b=99571,s=19914,d=26204,c=AUCT_CLAS_ARMOR},  -- Ebonhold Armor
	[8266]={b=37341,s=7468,d=26228,c=AUCT_CLAS_ARMOR},  -- Ebonhold Cloak
	[8267]={b=44639,s=8927,d=28726,c=AUCT_CLAS_ARMOR},  -- Ebonhold Gauntlets
	[8268]={b=44800,s=8960,d=26210,c=AUCT_CLAS_ARMOR},  -- Ebonhold Girdle
	[8269]={b=71813,s=14362,d=28667,c=AUCT_CLAS_ARMOR},  -- Ebonhold Boots
	[8270]={b=71758,s=14351,d=26220,c=AUCT_CLAS_ARMOR},  -- Ebonhold Helmet
	[8271]={b=101790,s=20358,d=21694,c=AUCT_CLAS_ARMOR},  -- Ebonhold Leggings
	[8272]={b=68489,s=13697,d=26217,c=AUCT_CLAS_ARMOR},  -- Ebonhold Shoulderpads
	[8273]={b=17871,s=3574,d=27373,c=AUCT_CLAS_ARMOR},  -- Valorous Wristguards
	[8274]={b=51259,s=10251,d=27372,c=AUCT_CLAS_ARMOR},  -- Valorous Chestguard
	[8275]={b=110140,s=22028,d=26232,c=AUCT_CLAS_WEAPON},  -- Ebonhold Buckler
	[8276]={b=19509,s=3901,d=27374,c=AUCT_CLAS_ARMOR},  -- Valorous Gauntlets
	[8277]={b=18128,s=3625,d=27375,c=AUCT_CLAS_ARMOR},  -- Valorous Girdle
	[8278]={b=27387,s=5477,d=27376,c=AUCT_CLAS_ARMOR},  -- Valorous Greaves
	[8279]={b=29688,s=5937,d=27379,c=AUCT_CLAS_ARMOR},  -- Valorous Helm
	[8280]={b=42518,s=8503,d=27377,c=AUCT_CLAS_ARMOR},  -- Valorous Legguards
	[8281]={b=29914,s=5982,d=27378,c=AUCT_CLAS_ARMOR},  -- Valorous Pauldrons
	[8282]={b=78478,s=15695,d=18790,c=AUCT_CLAS_WEAPON},  -- Valorous Shield
	[8283]={b=85690,s=17138,d=17251,c=AUCT_CLAS_ARMOR},  -- Arcane Armor
	[8284]={b=52570,s=10514,d=17256,c=AUCT_CLAS_ARMOR},  -- Arcane Boots
	[8285]={b=33186,s=6637,d=17262,c=AUCT_CLAS_ARMOR},  -- Arcane Bands
	[8286]={b=47137,s=9427,d=13984,c=AUCT_CLAS_ARMOR},  -- Arcane Cloak
	[8287]={b=35437,s=7087,d=17255,c=AUCT_CLAS_ARMOR},  -- Arcane Gloves
	[8288]={b=59381,s=11876,d=17271,c=AUCT_CLAS_ARMOR},  -- Arcane Pads
	[8289]={b=83441,s=16688,d=17252,c=AUCT_CLAS_ARMOR},  -- Arcane Leggings
	[8290]={b=87927,s=17585,d=17276,c=AUCT_CLAS_ARMOR},  -- Arcane Robe
	[8291]={b=33922,s=6784,d=17261,c=AUCT_CLAS_ARMOR},  -- Arcane Sash
	[8292]={b=57382,s=11476,d=17274,c=AUCT_CLAS_ARMOR},  -- Arcane Cover
	[8293]={b=42713,s=8542,d=17318,c=AUCT_CLAS_ARMOR},  -- Traveler's Belt
	[8294]={b=63259,s=12651,d=17317,c=AUCT_CLAS_ARMOR},  -- Traveler's Boots
	[8295]={b=39940,s=7988,d=17316,c=AUCT_CLAS_ARMOR},  -- Traveler's Bracers
	[8296]={b=104305,s=20861,d=17312,c=AUCT_CLAS_ARMOR},  -- Traveler's Jerkin
	[8297]={b=45565,s=9113,d=23066,c=AUCT_CLAS_ARMOR},  -- Traveler's Cloak
	[8298]={b=42825,s=8565,d=17314,c=AUCT_CLAS_ARMOR},  -- Traveler's Gloves
	[8299]={b=71769,s=14353,d=17269,c=AUCT_CLAS_ARMOR},  -- Traveler's Helm
	[8300]={b=100862,s=20172,d=17313,c=AUCT_CLAS_ARMOR},  -- Traveler's Leggings
	[8301]={b=72317,s=14463,d=17319,c=AUCT_CLAS_ARMOR},  -- Traveler's Spaulders
	[8302]={b=55301,s=11060,d=26313,c=AUCT_CLAS_ARMOR},  -- Hero's Bracers
	[8303]={b=134948,s=26989,d=26314,c=AUCT_CLAS_ARMOR},  -- Hero's Breastplate
	[8304]={b=52565,s=10513,d=26323,c=AUCT_CLAS_ARMOR},  -- Hero's Cape
	[8305]={b=58718,s=11743,d=26316,c=AUCT_CLAS_ARMOR},  -- Hero's Gauntlets
	[8306]={b=58937,s=11787,d=26312,c=AUCT_CLAS_ARMOR},  -- Hero's Belt
	[8307]={b=93586,s=18717,d=26310,c=AUCT_CLAS_ARMOR},  -- Hero's Boots
	[8308]={b=93517,s=18703,d=26315,c=AUCT_CLAS_ARMOR},  -- Hero's Band
	[8309]={b=131394,s=26278,d=26317,c=AUCT_CLAS_ARMOR},  -- Hero's Leggings
	[8310]={b=97099,s=19419,d=26321,c=AUCT_CLAS_ARMOR},  -- Hero's Pauldrons
	[8311]={b=29224,s=5844,d=27394,c=AUCT_CLAS_ARMOR},  -- Alabaster Plate Vambraces
	[8312]={b=74053,s=14810,d=27389,c=AUCT_CLAS_ARMOR},  -- Alabaster Breastplate
	[8313]={b=153187,s=30637,d=26324,c=AUCT_CLAS_WEAPON},  -- Hero's Buckler
	[8314]={b=26721,s=5344,d=27390,c=AUCT_CLAS_ARMOR},  -- Alabaster Plate Gauntlets
	[8315]={b=25306,s=5061,d=27391,c=AUCT_CLAS_ARMOR},  -- Alabaster Plate Girdle
	[8316]={b=40393,s=8078,d=27392,c=AUCT_CLAS_ARMOR},  -- Alabaster Plate Greaves
	[8317]={b=42977,s=8595,d=27395,c=AUCT_CLAS_ARMOR},  -- Alabaster Plate Helmet
	[8318]={b=64634,s=12926,d=27393,c=AUCT_CLAS_ARMOR},  -- Alabaster Plate Leggings
	[8319]={b=45906,s=9181,d=27396,c=AUCT_CLAS_ARMOR},  -- Alabaster Plate Pauldrons
	[8320]={b=110461,s=22092,d=27571,c=AUCT_CLAS_WEAPON},  -- Alabaster Shield
	[8343]={b=2000,s=500,d=12105,x=20,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Heavy Silken Thread
	[8344]={b=0,s=0,d=16464},  -- Silvery Spinnerets
	[8345]={b=37109,s=7421,d=28987,c=AUCT_CLAS_ARMOR},  -- Wolfshead Helm
	[8346]={b=26815,s=5363,d=16678,c=AUCT_CLAS_ARMOR},  -- Gauntlets of the Sea
	[8347]={b=29899,s=5979,d=16731,c=AUCT_CLAS_ARMOR},  -- Dragonscale Gauntlets
	[8348]={b=54099,s=10819,d=17226,c=AUCT_CLAS_ARMOR},  -- Helm of Fire
	[8349]={b=72391,s=14478,d=8660,c=AUCT_CLAS_ARMOR},  -- Feathered Breastplate
	[8350]={b=4520,s=1130,d=224,c=AUCT_CLAS_ARMOR},  -- The 1 Ring
	[8363]={b=0,s=0,d=16456},  -- Shaman Voodoo Charm
	[8364]={b=1250,s=6,d=1208,q=20,x=20},  -- Mithril Head Trout
	[8365]={b=80,s=4,d=1208,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Mithril Head Trout
	[8367]={b=92276,s=18455,d=16729,c=AUCT_CLAS_ARMOR},  -- Dragonscale Breastplate
	[8368]={b=4000,s=1000,d=21470,x=5,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Thick Wolfhide
	[8383]={b=0,s=0,d=7798},  -- Plain Letter
	[8384]={b=3500,s=875,d=1102},  -- Pattern: Comfortable Leather Hat
	[8385]={b=3500,s=875,d=1102},  -- Pattern: Turtle Scale Gloves
	[8386]={b=4000,s=1000,d=15274},  -- Pattern: Big Voodoo Robe
	[8387]={b=4000,s=1000,d=15274},  -- Pattern: Big Voodoo Mask
	[8389]={b=5000,s=1250,d=15274},  -- Pattern: Big Voodoo Pants
	[8390]={b=5000,s=1250,d=15274},  -- Pattern: Big Voodoo Cloak
	[8391]={b=0,s=0,d=1116,q=20,x=20},  -- Snickerfang Jowl
	[8392]={b=0,s=0,d=1438,q=20,x=20},  -- Blasted Boar Lung
	[8393]={b=0,s=0,d=16776,q=20,x=20},  -- Scorpok Pincer
	[8394]={b=0,s=0,d=10923,q=20,x=20},  -- Basilisk Brain
	[8395]={b=4000,s=1000,d=1102},  -- Pattern: Tough Scorpid Breastplate
	[8396]={b=0,s=0,d=3759,q=20,x=20},  -- Vulture Gizzard
	[8397]={b=4000,s=1000,d=1102},  -- Pattern: Tough Scorpid Bracers
	[8398]={b=4500,s=1125,d=1102},  -- Pattern: Tough Scorpid Gloves
	[8399]={b=5000,s=1250,d=1102},  -- Pattern: Tough Scorpid Boots
	[8400]={b=5000,s=1250,d=1102},  -- Pattern: Tough Scorpid Shoulders
	[8401]={b=5500,s=1375,d=1102},  -- Pattern: Tough Scorpid Leggings
	[8402]={b=5500,s=1375,d=1102},  -- Pattern: Tough Scorpid Helm
	[8403]={b=4000,s=1000,d=1102},  -- Pattern: Wild Leather Shoulders
	[8404]={b=4000,s=1000,d=1102},  -- Pattern: Wild Leather Vest
	[8405]={b=4000,s=1000,d=1102},  -- Pattern: Wild Leather Helmet
	[8406]={b=5000,s=1250,d=1102},  -- Pattern: Wild Leather Boots
	[8407]={b=5000,s=1250,d=1102},  -- Pattern: Wild Leather Leggings
	[8408]={b=5000,s=1250,d=1102},  -- Pattern: Wild Leather Cloak
	[8409]={b=4000,s=1000,d=1102},  -- Pattern: Nightscape Shoulders
	[8410]={b=0,s=0,d=16801},  -- R.O.I.D.S.
	[8411]={b=0,s=0,d=18114},  -- Lung Juice Cocktail
	[8412]={b=0,s=0,d=16803},  -- Ground Scorpok Assay
	[8423]={b=0,s=0,d=16836},  -- Cerebral Cortex Compound
	[8424]={b=0,s=0,d=16837},  -- Gizzard Gum
	[8425]={b=0,s=0,d=6703,q=20,x=20},  -- Parrot Droppings
	[8426]={b=0,s=0,d=19570,q=20,x=20},  -- Large Ruffled Feather
	[8427]={b=0,s=0,d=16860,q=20,x=20},  -- Mutilated Rat Carcass
	[8428]={b=0,s=0,d=16861},  -- Laden Dew Gland
	[8429]={b=125,s=31,d=6703,x=10},  -- Punctured Dew Gland
	[8430]={b=185,s=46,d=18071,x=10},  -- Empty Dew Gland
	[8431]={b=0,s=0,d=7403},  -- Spool of Light Chartreuse Silk Thread
	[8432]={b=0,s=0,d=16325},  -- Eau de Mixilpixil
	[8443]={b=0,s=0,d=18725,q=20,x=20},  -- Gahz'ridian Ornament
	[8444]={b=0,s=0,d=7737},  -- Executioner's Key
	[8463]={b=0,s=0,d=16161,c=AUCT_CLAS_WRITTEN},  -- Warchief's Orders
	[8483]={b=685,s=171,d=18085,x=20},  -- Wastewander Water Pouch
	[8484]={b=275,s=68,d=18574},  -- Gadgetzan Water Co. Care Package
	[8485]={b=4000,s=1000,d=20629},  -- Cat Carrier (Bombay)
	[8486]={b=4000,s=1000,d=20629},  -- Cat Carrier (Cornish Rex)
	[8487]={b=4000,s=1000,d=20629},  -- Cat Carrier (Orange Tabby)
	[8488]={b=4000,s=1000,d=20629},  -- Cat Carrier (Silver Tabby)
	[8489]={b=6000,s=1500,d=20629},  -- Cat Carrier (White Kitten)
	[8490]={b=6000,s=1500,d=20629},  -- Cat Carrier (Siamese)
	[8491]={b=6000,s=1500,d=20629},  -- Cat Carrier (Maine Coon)
	[8492]={b=4000,s=1000,d=17292},  -- Parrot Cage (Green Wing Macaw)
	[8494]={b=4000,s=1000,d=17292},  -- Parrot Cage (Hyacinth Macaw)
	[8495]={b=4000,s=1000,d=17292},  -- Parrot Cage (Senegal)
	[8496]={b=4000,s=1000,d=17292},  -- Parrot Cage (Cockatiel)
	[8497]={b=2000,s=500,d=17284},  -- Rabbit Crate (Snowshoe)
	[8498]={b=10000,s=2500,d=20655},  -- Tiny Emerald Whelpling
	[8499]={b=10000,s=2500,d=20655},  -- Tiny Crimson Whelpling
	[8500]={b=5000,s=1250,d=19091},  -- Great Horned Owl
	[8501]={b=5000,s=1250,d=19091},  -- Hawk Owl
	[8523]={b=1000,s=0,d=2592},  -- Field Testing Kit
	[8524]={b=0,s=0,d=14993,c=AUCT_CLAS_QUEST},  -- Model 4711-FTZ Power Source
	[8525]={b=0,s=0,d=7798},  -- Zinge's Purchase Order
	[8526]={b=0,s=0,d=17391},  -- Violet Tragan
	[8527]={b=0,s=0,d=2592},  -- Sealed Field Testing Kit
	[8528]={b=0,s=0,d=17397},  -- Violet Powder
	[8529]={b=3500,s=175,d=17403,q=20,x=20,c=AUCT_CLAS_POTION},  -- Noggenfogger Elixir
	[8544]={b=1600,s=400,d=17457,x=20},  -- Mageweave Bandage
	[8545]={b=2400,s=600,d=17458,x=20},  -- Heavy Mageweave Bandage
	[8548]={b=0,s=0,d=17461},  -- Divino-matic Rod
	[8563]={b=800000,s=0,d=17785},  -- Red Mechanostrider
	[8564]={b=800,s=200,d=18047},  -- Hippogryph Egg
	[8584]={b=0,s=0,d=18717},  -- Untapped Dowsing Widget
	[8585]={b=0,s=0,d=15718},  -- Tapped Dowsing Widget
	[8586]={b=10000000,s=0,d=17494},  -- Whistle of the Mottled Red Raptor
	[8587]={b=0,s=0,d=18723,q=20,x=20},  -- Centipaar Insect Parts
	[8588]={b=800000,s=0,d=17494},  -- Whistle of the Emerald Raptor
	[8591]={b=800000,s=0,d=17494},  -- Whistle of the Turquoise Raptor
	[8592]={b=800000,s=0,d=17494},  -- Whistle of the Violet Raptor
	[8593]={b=0,s=0,d=14326},  -- Scrimshank's Surveying Gear
	[8594]={b=0,s=0,d=7695},  -- Insect Analysis Report
	[8595]={b=800000,s=0,d=17785},  -- Blue Mechanostrider
	[8603]={b=0,s=0,d=15734},  -- Thistleshrub Dew
	[8623]={b=0,s=0,d=18632,c=AUCT_CLAS_QUEST},  -- OOX-17/TN Distress Beacon
	[8626]={b=1000,s=250,d=17602,c=AUCT_CLAS_WEAPON},  -- Blue Sparkler
	[8629]={b=800000,s=0,d=17606},  -- Reins of the Striped Nightsaber
	[8631]={b=800000,s=0,d=17608},  -- Reins of the Striped Frostsaber
	[8632]={b=800000,s=0,d=17608},  -- Reins of the Spotted Frostsaber
	[8643]={b=10000,s=2500,d=18050},  -- Extraordinary Egg
	[8644]={b=6000,s=1500,d=18050},  -- Fine Egg
	[8645]={b=3000,s=750,d=18049},  -- Ordinary Egg
	[8646]={b=1000,s=250,d=18049},  -- Bad Egg
	[8647]={b=0,s=0,d=12331},  -- Egg Crate
	[8663]={b=0,s=0,d=17655,c=AUCT_CLAS_ARMOR},  -- Mithril Insignia
	[8683]={b=4,s=1,d=6410,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Clara's Fresh Apple
	[8684]={b=0,s=0,d=18079,q=20,x=20},  -- Hinterlands Honey Ripple
	[8685]={b=0,s=0,d=8381},  -- Dran's Ripple Delivery
	[8686]={b=0,s=0,d=17685},  -- Mithril Pendant
	[8687]={b=0,s=0,d=7744},  -- Sealed Description of Thredd's Visitor
	[8703]={b=25968,s=6492,d=17776,c=AUCT_CLAS_ARMOR},  -- Signet of Expertise
	[8704]={b=0,s=0,d=18632,c=AUCT_CLAS_QUEST},  -- OOX-09/HL Distress Beacon
	[8705]={b=0,s=0,d=18632,c=AUCT_CLAS_QUEST},  -- OOX-22/FE Distress Beacon
	[8707]={b=0,s=0,d=8923},  -- Gahz'rilla's Electrified Scale
	[8708]={b=0,s=0,d=17788,c=AUCT_CLAS_WEAPON},  -- Hammer of Expertise
	[8723]={b=0,s=0,d=3918},  -- Caliph Scorpidsting's Head
	[8724]={b=0,s=0,d=17809},  -- Rin'ji's Secret
	[8746]={b=3411,s=682,d=18416,c=AUCT_CLAS_ARMOR},  -- Interlaced Cowl
	[8747]={b=5181,s=1036,d=21298,c=AUCT_CLAS_ARMOR},  -- Hardened Leather Helm
	[8748]={b=3874,s=774,d=28389,c=AUCT_CLAS_ARMOR},  -- Double Mail Coif
	[8749]={b=8019,s=1603,d=18414,c=AUCT_CLAS_ARMOR},  -- Crochet Hat
	[8750]={b=9317,s=1863,d=21312,c=AUCT_CLAS_ARMOR},  -- Thick Leather Hat
	[8751]={b=13091,s=2618,d=28393,c=AUCT_CLAS_ARMOR},  -- Overlinked Coif
	[8752]={b=26086,s=5217,d=28391,c=AUCT_CLAS_ARMOR},  -- Laminated Scale Circlet
	[8753]={b=25990,s=5198,d=18418,c=AUCT_CLAS_ARMOR},  -- Smooth Leather Helmet
	[8754]={b=19687,s=3937,d=18422,c=AUCT_CLAS_ARMOR},  -- Twill Cover
	[8755]={b=18642,s=3728,d=28847,c=AUCT_CLAS_ARMOR},  -- Light Plate Helmet
	[8766]={b=4000,s=200,d=926,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Morning Glory Dew
	[8831]={b=1200,s=300,d=19493,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Purple Lotus
	[8836]={b=380,s=95,d=19498,x=20,u=AUCT_TYPE_ALCHEM},  -- Arthas' Tears
	[8838]={b=240,s=60,d=19492,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT},  -- Sungrass
	[8839]={b=1500,s=375,d=19496,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Blindweed
	[8845]={b=1500,s=375,d=17871,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Ghost Mushroom
	[8846]={b=1000,s=250,d=19494,x=20,c=AUCT_CLAS_HERB,u=AUCT_TYPE_ALCHEM},  -- Gromsblood
	[8923]={b=200,s=50,d=1288,x=10,u=AUCT_TYPE_POISON},  -- Essence of Agony
	[8924]={b=100,s=25,d=6379,x=20,u=AUCT_TYPE_POISON},  -- Dust of Deterioration
	[8925]={b=2500,s=125,d=18077,q=20,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_POISON},  -- Crystal Vial
	[8926]={b=300,s=75,d=13710,x=10,c=AUCT_CLAS_POISON},  -- Instant Poison IV
	[8927]={b=400,s=100,d=13710,x=10,c=AUCT_CLAS_POISON},  -- Instant Poison V
	[8928]={b=500,s=125,d=13710,x=10,c=AUCT_CLAS_POISON},  -- Instant Poison VI
	[8932]={b=4000,s=200,d=21906,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Alterac Swiss
	[8948]={b=4000,s=200,d=17880,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Dried King Bolete
	[8949]={b=800,s=200,d=17882,x=5,u=AUCT_TYPE_LEATHER},  -- Elixir of Agility
	[8950]={b=4000,s=200,d=6342,q=20,x=20},  -- Homemade Cherry Pie
	[8951]={b=800,s=200,d=17883,x=5,u=AUCT_TYPE_LEATHER},  -- Elixir of Greater Defense
	[8952]={b=4000,s=200,d=4112,q=20,x=20},  -- Roasted Quail
	[8953]={b=4000,s=200,d=17881,q=20,x=20},  -- Deep Fried Plantains
	[8956]={b=800,s=200,d=2351,x=5},  -- Oil of Immolation
	[8957]={b=4000,s=200,d=24718,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Spinefin Halibut
	[8959]={b=3200,s=160,d=24718,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Raw Spinefin Halibut
	[8973]={b=0,s=0,d=7373,q=20,x=20,c=AUCT_CLAS_LEATHER},  -- Thick Yeti Hide
	[8984]={b=400,s=100,d=13707,x=10,c=AUCT_CLAS_POISON},  -- Deadly Poison III
	[8985]={b=600,s=150,d=13707,x=10,c=AUCT_CLAS_POISON},  -- Deadly Poison IV
	[9030]={b=800,s=200,d=926,x=5,c=AUCT_CLAS_POTION},  -- Restorative Elixir
	[9036]={b=80,s=20,d=1215,x=5,c=AUCT_CLAS_POTION},  -- Magic Resistance Potion
	[9060]={b=4000,s=1000,d=7397,x=20,u=AUCT_TYPE_ENGINEER},  -- Inlaid Mithril Cylinder
	[9061]={b=1000,s=250,d=7921,x=20,u=AUCT_TYPE_ENGINEER},  -- Goblin Rocket Fuel
	[9088]={b=1000,s=250,d=17889,x=5},  -- Gift of Arthas
	[9144]={b=1000,s=250,d=17893,x=5,c=AUCT_CLAS_POTION},  -- Wildvine Potion
	[9149]={b=1000,s=250,d=8025},  -- Philosophers' Stone
	[9153]={b=0,s=0,d=7629},  -- Rig Blueprints
	[9154]={b=1200,s=300,d=15714,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Detect Undead
	[9155]={b=1600,s=400,d=17896,x=5,c=AUCT_CLAS_POTION},  -- Arcane Elixir
	[9172]={b=2000,s=500,d=17898,x=5,c=AUCT_CLAS_POTION},  -- Invisibility Potion
	[9173]={b=0,s=0,d=17899},  -- Goblin Transponder
	[9179]={b=4000,s=1000,d=3664,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Greater Intellect
	[9186]={b=700,s=175,d=13709,x=10,c=AUCT_CLAS_POISON},  -- Mind-numbing Poison III
	[9187]={b=2400,s=600,d=17902,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Greater Agility
	[9189]={b=0,s=0,d=17911},  -- Shay's Bell
	[9197]={b=2400,s=600,d=4134,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Dream Vision
	[9206]={b=2800,s=700,d=17904,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Giants
	[9210]={b=3000,s=750,d=9731,x=10},  -- Ghost Dye
	[9214]={b=10000,s=2500,d=1246},  -- Grimoire of Inferno
	[9224]={b=2800,s=700,d=16325,x=5,u=AUCT_TYPE_ENCHANT},  -- Elixir of Demonslaying
	[9233]={b=2000,s=500,d=15714,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Detect Demon
	[9234]={b=0,s=0,d=1399},  -- Tiara of the Deep
	[9235]={b=0,s=0,d=3018},  -- Pratt's Letter
	[9236]={b=0,s=0,d=3029},  -- Jangdor's Letter
	[9237]={b=0,s=0,d=18093,q=20,x=20},  -- Woodpaw Gnoll Mane
	[9238]={b=0,s=0,d=8923,q=20,x=20},  -- Uncracked Scarab Shell
	[9240]={b=0,s=0,d=17916},  -- Mallet of Zul'Farrak
	[9241]={b=0,s=0,d=17916},  -- Sacred Mallet
	[9242]={b=9685,s=2421,d=18204,c=AUCT_CLAS_WRITTEN},  -- Ancient Tablet
	[9243]={b=0,s=0,d=17918,c=AUCT_CLAS_ARMOR},  -- Shriveled Heart
	[9244]={b=0,s=0,d=7922},  -- Stoley's Shipment
	[9245]={b=0,s=0,d=18080},  -- Stoley's Bottle
	[9246]={b=0,s=0,d=7038},  -- Firebeard's Head
	[9247]={b=0,s=0,d=3668,q=20,x=20,u=AUCT_TYPE_TAILOR},  -- Hatecrest Naga Scale
	[9248]={b=0,s=0,d=18720},  -- Mysterious Relic
	[9249]={b=6215,s=1553,d=6709},  -- Captain's Key
	[9250]={b=0,s=0,d=811,c=AUCT_CLAS_QUEST},  -- Ship Schedule
	[9251]={b=250,s=62,d=7695},  -- Upper Map Fragment
	[9252]={b=250,s=62,d=7798},  -- Lower Map Fragment
	[9253]={b=250,s=62,d=8927},  -- Middle Map Fragment
	[9254]={b=0,s=0,d=1322,c=AUCT_CLAS_QUEST},  -- Cuergo's Treasure Map
	[9255]={b=0,s=0,d=6688},  -- Lahassa Essence
	[9256]={b=0,s=0,d=18021},  -- Imbel Essence
	[9257]={b=0,s=0,d=18022},  -- Samha Essence
	[9258]={b=0,s=0,d=1659},  -- Byltan Essence
	[9259]={b=258,s=64,d=9860,x=20},  -- Troll Tribal Necklace
	[9260]={b=1600,s=400,d=18059,x=10,u=AUCT_TYPE_ALCHEM},  -- Volatile Rum
	[9261]={b=1000,s=250,d=4690,x=10},  -- Lead Ore
	[9262]={b=4000,s=1000,d=17957,x=10},  -- Black Vitriol
	[9263]={b=0,s=0,d=8556},  -- Troyas' Stave
	[9264]={b=140,s=35,d=24216,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Shadow Power
	[9265]={b=60,s=15,d=13100},  -- Cuergo's Hidden Treasure
	[9266]={b=0,s=0,d=3331},  -- Woodpaw Battle Plans
	[9275]={b=0,s=0,d=13025},  -- Cuergo's Key
	[9276]={b=400,s=100,d=12332},  -- Pirate's Footlocker
	[9277]={b=0,s=0,d=17922},  -- Techbot's Memory Core
	[9278]={b=0,s=0,d=18215,q=20,x=20},  -- Essential Artificial
	[9279]={b=180,s=45,d=7355,c=AUCT_CLAS_WRITTEN},  -- White Punch Card
	[9280]={b=0,s=0,d=7355,c=AUCT_CLAS_WRITTEN},  -- Yellow Punch Card
	[9281]={b=0,s=0,d=7355,c=AUCT_CLAS_WRITTEN},  -- Red Punch Card
	[9282]={b=0,s=0,d=7355,c=AUCT_CLAS_WRITTEN},  -- Blue Punch Card
	[9283]={b=0,s=0,d=18057},  -- Empty Leaden Collection Phial
	[9284]={b=0,s=0,d=18057},  -- Full Leaden Collection Phial
	[9285]={b=11943,s=2388,d=27362,c=AUCT_CLAS_ARMOR},  -- Field Plate Vambraces
	[9286]={b=30203,s=6040,d=27356,c=AUCT_CLAS_ARMOR},  -- Field Plate Armor
	[9287]={b=12031,s=2406,d=27358,c=AUCT_CLAS_ARMOR},  -- Field Plate Gauntlets
	[9288]={b=12074,s=2414,d=27359,c=AUCT_CLAS_ARMOR},  -- Field Plate Girdle
	[9289]={b=18178,s=3635,d=27357,c=AUCT_CLAS_ARMOR},  -- Field Plate Boots
	[9290]={b=19703,s=3940,d=25839,c=AUCT_CLAS_ARMOR},  -- Field Plate Helmet
	[9291]={b=26432,s=5286,d=27360,c=AUCT_CLAS_ARMOR},  -- Field Plate Leggings
	[9292]={b=18424,s=3684,d=27361,c=AUCT_CLAS_ARMOR},  -- Field Plate Pauldrons
	[9293]={b=5000,s=1250,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Magic Resistance Potion
	[9294]={b=8000,s=2000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Wildvine Potion
	[9295]={b=8000,s=2000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Invisibility Potion
	[9296]={b=8000,s=2000,d=6270},  -- Recipe: Gift of Arthas
	[9297]={b=10000,s=2500,d=15274},  -- Recipe: Elixir of Dream Vision
	[9298]={b=9000,s=2250,d=15274},  -- Recipe: Elixir of Giants
	[9299]={b=0,s=0,d=18010},  -- Thermaplugg's Safe Combination
	[9300]={b=10000,s=2500,d=1301,u=AUCT_TYPE_ENCHANT},  -- Recipe: Elixir of Demonslaying
	[9301]={b=10000,s=2500,d=15274},  -- Recipe: Elixir of Shadow Power
	[9302]={b=9000,s=2250,d=6270},  -- Recipe: Ghost Dye
	[9303]={b=8000,s=2000,d=1301},  -- Recipe: Philosophers' Stone
	[9304]={b=8000,s=2000,d=1301},  -- Recipe: Transmute Iron to Gold
	[9305]={b=8000,s=2000,d=1301},  -- Recipe: Transmute Mithril to Truesilver
	[9306]={b=0,s=0,d=18026},  -- Stave of Equinex
	[9307]={b=0,s=0,d=6506},  -- A Sparkling Stone
	[9308]={b=152,s=38,d=18716,x=20},  -- Grime-Encrusted Object
	[9309]={b=0,s=0,d=8931,q=20,x=20},  -- Robo-mechanical Guts
	[9311]={b=0,s=0,d=7798},  -- Default Stationery
	[9312]={b=50,s=12,d=18066,x=5},  -- Blue Firework
	[9313]={b=50,s=12,d=18067,x=5},  -- Green Firework
	[9316]={b=0,s=0,d=7355,c=AUCT_CLAS_WRITTEN},  -- Prismatic Punch Card
	[9318]={b=50,s=12,d=8733,x=5},  -- Red Firework
	[9319]={b=0,s=0,d=25592},  -- Nimboya's Laden Pike
	[9320]={b=0,s=0,d=7150,q=20,x=20},  -- Witherbark Skull
	[9321]={b=0,s=0,d=1288},  -- Venom Bottle
	[9322]={b=0,s=0,d=8940,q=20,x=20},  -- Undamaged Venom Sac
	[9323]={b=0,s=0,d=2616},  -- Gadrin's Parchment
	[9324]={b=0,s=0,d=15770},  -- Shadra's Venom
	[9326]={b=0,s=0,d=13490,c=AUCT_CLAS_QUEST},  -- Grime-Encrusted Ring
	[9327]={b=2500,s=625,d=7356},  -- Security DELTA Data Access Card
	[9328]={b=0,s=0,d=18155},  -- Super Snapper FX
	[9329]={b=0,s=0,d=3029,c=AUCT_CLAS_WRITTEN},  -- A Short Note
	[9330]={b=0,s=0,d=18158,c=AUCT_CLAS_WRITTEN},  -- Snapshot of Gammerita
	[9331]={b=0,s=0,d=18164},  -- Feralas: A History
	[9332]={b=155,s=38,d=18170,x=20},  -- Crusted Bandages
	[9333]={b=295,s=73,d=18172,x=20,c=AUCT_CLAS_ARMOR},  -- Tarnished Silver Necklace
	[9334]={b=190,s=47,d=18173,x=10},  -- Cracked Pottery
	[9335]={b=210,s=52,d=7161,x=5},  -- Broken Obsidian Club
	[9336]={b=5155,s=1288,d=18174,x=5},  -- Gold-capped Troll Tusk
	[9355]={b=1505,s=376,d=9835,x=20},  -- Hoop Earring
	[9356]={b=870,s=217,d=18192,x=5},  -- A Wooden Leg
	[9357]={b=910,s=227,d=3233,x=10},  -- A Parrot Skeleton
	[9358]={b=915,s=228,d=18193,x=20},  -- A Head Rag
	[9359]={b=97888,s=19577,d=19756,c=AUCT_CLAS_WEAPON},  -- Wirt's Third Leg
	[9360]={b=1600,s=400,d=18059},  -- Cuergo's Gold
	[9361]={b=1600,s=400,d=18059},  -- Cuergo's Gold with Worm
	[9362]={b=0,s=0,d=224,c=AUCT_CLAS_ARMOR},  -- Brilliant Gold Ring
	[9363]={b=50,s=12,d=18499},  -- Sparklematic-Wrapped Box
	[9364]={b=0,s=0,d=18057},  -- Heavy Leaden Collection Phial
	[9365]={b=0,s=0,d=18649},  -- High Potency Radioactive Fallout
	[9366]={b=18446,s=3689,d=18256,c=AUCT_CLAS_ARMOR},  -- Golden Scale Gauntlets
	[9367]={b=5000,s=1250,d=15274},  -- Plans: Golden Scale Gauntlets
	[9368]={b=0,s=0,d=9837},  -- Jer'kai's Signet Ring
	[9369]={b=0,s=0,d=3668,q=20,x=20},  -- Iridescent Sprite Darter Wing
	[9370]={b=0,s=0,d=1093,c=AUCT_CLAS_QUEST},  -- Gordunni Scroll
	[9371]={b=0,s=0,d=16209},  -- Gordunni Orb
	[9372]={b=309681,s=61936,d=20616,c=AUCT_CLAS_WEAPON},  -- Sul'thraze the Lasher
	[9375]={b=21101,s=4220,d=21295,c=AUCT_CLAS_ARMOR},  -- Expert Goldminer's Helmet
	[9378]={b=56901,s=11380,d=18257,c=AUCT_CLAS_WEAPON},  -- Shovelphlange's Mining Axe
	[9379]={b=131917,s=26383,d=20032,c=AUCT_CLAS_WEAPON},  -- Sang'thraze the Deflector
	[9381]={b=43143,s=8628,d=21025,c=AUCT_CLAS_WEAPON},  -- Earthen Rod
	[9382]={b=18039,s=3607,d=28734,c=AUCT_CLAS_ARMOR},  -- Tromping Miner's Boots
	[9383]={b=84476,s=16895,d=18328,c=AUCT_CLAS_WEAPON},  -- Obsidian Cleaver
	[9384]={b=48947,s=9789,d=18264,c=AUCT_CLAS_WEAPON},  -- Stonevault Shiv
	[9385]={b=61404,s=12280,d=20249,c=AUCT_CLAS_WEAPON},  -- Archaic Defender
	[9386]={b=49296,s=9859,d=18268,c=AUCT_CLAS_WEAPON},  -- Excavator's Brand
	[9387]={b=17194,s=3438,d=18430,c=AUCT_CLAS_ARMOR},  -- Revelosh's Boots
	[9388]={b=15981,s=3196,d=18427,c=AUCT_CLAS_ARMOR},  -- Revelosh's Armguards
	[9389]={b=21657,s=4331,d=18433,c=AUCT_CLAS_ARMOR},  -- Revelosh's Spaulders
	[9390]={b=10734,s=2146,d=19056,c=AUCT_CLAS_ARMOR},  -- Revelosh's Gloves
	[9391]={b=64158,s=12831,d=18269,c=AUCT_CLAS_WEAPON},  -- The Shoveler
	[9392]={b=64901,s=12980,d=18270,c=AUCT_CLAS_WEAPON},  -- Annealed Blade
	[9393]={b=31530,s=7882,d=11410,c=AUCT_CLAS_WEAPON},  -- Beacon of Hope
	[9394]={b=22878,s=4575,d=21301,c=AUCT_CLAS_ARMOR},  -- Horned Viking Helmet
	[9395]={b=7828,s=1565,d=18271,c=AUCT_CLAS_ARMOR},  -- Gloves of Old
	[9396]={b=36596,s=7319,d=18274,c=AUCT_CLAS_ARMOR},  -- Legguards of the Vault
	[9397]={b=18364,s=3672,d=22996,c=AUCT_CLAS_ARMOR},  -- Energy Cloak
	[9398]={b=12441,s=2488,d=18361,c=AUCT_CLAS_ARMOR},  -- Worn Running Boots
	[9399]={b=40,s=10,d=26498,x=200,c=AUCT_CLAS_WEAPON},  -- Precision Arrow
	[9400]={b=27073,s=5414,d=20553,c=AUCT_CLAS_WEAPON},  -- Baelog's Shortbow
	[9401]={b=84507,s=16901,d=7485,c=AUCT_CLAS_WEAPON},  -- Nordic Longshank
	[9402]={b=126543,s=25308,d=21403,c=AUCT_CLAS_ARMOR},  -- Earthborn Kilt
	[9403]={b=22184,s=4436,d=18824,c=AUCT_CLAS_WEAPON},  -- Battered Viking Shield
	[9404]={b=46991,s=9398,d=18826,c=AUCT_CLAS_WEAPON},  -- Olaf's All Purpose Shield
	[9405]={b=10277,s=2055,d=18283,c=AUCT_CLAS_ARMOR},  -- Girdle of Golem Strength
	[9406]={b=20807,s=4161,d=18284,c=AUCT_CLAS_ARMOR},  -- Spirewind Fetter
	[9407]={b=25470,s=5094,d=12345,c=AUCT_CLAS_ARMOR},  -- Stoneweaver Leggings
	[9408]={b=93198,s=18639,d=20274,c=AUCT_CLAS_WEAPON},  -- Ironshod Bludgeon
	[9409]={b=22450,s=4490,d=18352,c=AUCT_CLAS_ARMOR},  -- Ironaya's Bracers
	[9410]={b=18925,s=3785,d=29000,c=AUCT_CLAS_ARMOR},  -- Cragfists
	[9411]={b=35780,s=7156,d=6480,c=AUCT_CLAS_ARMOR},  -- Rockshard Pauldrons
	[9412]={b=83405,s=16681,d=18298,c=AUCT_CLAS_WEAPON},  -- Galgann's Fireblaster
	[9413]={b=161244,s=32248,d=19620,c=AUCT_CLAS_WEAPON},  -- The Rockpounder
	[9414]={b=43227,s=8645,d=18434,c=AUCT_CLAS_ARMOR},  -- Oilskin Leggings
	[9415]={b=44986,s=8997,d=18347,c=AUCT_CLAS_ARMOR},  -- Grimlok's Tribal Vestments
	[9416]={b=141092,s=28218,d=22233,c=AUCT_CLAS_WEAPON},  -- Grimlok's Charge
	[9418]={b=164258,s=32851,d=20193,c=AUCT_CLAS_WEAPON},  -- Stoneslayer
	[9419]={b=90384,s=18076,d=18312,c=AUCT_CLAS_WEAPON},  -- Galgann's Firehammer
	[9420]={b=20416,s=4083,d=18322,c=AUCT_CLAS_ARMOR},  -- Adventurer's Pith Helmet
	[9421]={b=0,s=0,d=8026,c=AUCT_CLAS_WARLOCK},  -- Major Healthstone
	[9422]={b=65262,s=13052,d=20663,c=AUCT_CLAS_WEAPON},  -- Shadowforge Bushmaster
	[9423]={b=127319,s=25463,d=18324,c=AUCT_CLAS_WEAPON},  -- The Jackhammer
	[9424]={b=67970,s=13594,d=18325,c=AUCT_CLAS_WEAPON},  -- Ginn-su Sword
	[9425]={b=107446,s=21489,d=22220,c=AUCT_CLAS_WEAPON},  -- Pendulum of Doom
	[9426]={b=51375,s=10275,d=20556,c=AUCT_CLAS_WEAPON},  -- Monolithic Bow
	[9427]={b=74265,s=14853,d=22051,c=AUCT_CLAS_WEAPON},  -- Stonevault Bonebreaker
	[9428]={b=10481,s=2096,d=18331,c=AUCT_CLAS_ARMOR},  -- Unearthed Bands
	[9429]={b=26184,s=5236,d=18376,c=AUCT_CLAS_ARMOR},  -- Miner's Hat of the Deep
	[9430]={b=42768,s=8553,d=18333,c=AUCT_CLAS_ARMOR},  -- Spaulders of a Lost Age
	[9431]={b=24426,s=4885,d=18334,c=AUCT_CLAS_ARMOR},  -- Papal Fez
	[9432]={b=15135,s=3027,d=18378,c=AUCT_CLAS_ARMOR},  -- Skullplate Bracers
	[9433]={b=20669,s=4133,d=18337,c=AUCT_CLAS_ARMOR},  -- Forgotten Wraps
	[9434]={b=28240,s=5648,d=18338,c=AUCT_CLAS_ARMOR},  -- Elemental Raiment
	[9435]={b=14583,s=2916,d=18339,c=AUCT_CLAS_ARMOR},  -- Reticulated Bone Gauntlets
	[9436]={b=0,s=0,d=18359},  -- Faranell's Parcel
	[9437]={b=0,s=0,d=3563,q=20,x=20},  -- Untested Basilisk Sample
	[9438]={b=0,s=0,d=18712,q=20,x=20},  -- Acceptable Scorpid Sample
	[9439]={b=0,s=0,d=11164,q=20,x=20},  -- Untested Hyena Sample
	[9440]={b=0,s=0,d=3563,q=20,x=20},  -- Acceptable Basilisk Sample
	[9441]={b=0,s=0,d=11164,q=20,x=20},  -- Acceptable Hyena Sample
	[9442]={b=0,s=0,d=18712,q=20,x=20},  -- Untested Scorpid Sample
	[9444]={b=5602,s=1120,d=8296,c=AUCT_CLAS_WEAPON},  -- Techbot CPU Shell
	[9445]={b=11302,s=2260,d=18364,c=AUCT_CLAS_ARMOR},  -- Grubbis Paws
	[9446]={b=37820,s=7564,d=16538,c=AUCT_CLAS_WEAPON},  -- Electrocutioner Leg
	[9447]={b=12950,s=3237,d=18365,c=AUCT_CLAS_ARMOR},  -- Electrocutioner Lagnut
	[9448]={b=5774,s=1154,d=18366,c=AUCT_CLAS_ARMOR},  -- Spidertank Oilrag
	[9449]={b=47822,s=9564,d=19645,c=AUCT_CLAS_WEAPON},  -- Manual Crowd Pummeler
	[9450]={b=10908,s=2181,d=18367,c=AUCT_CLAS_ARMOR},  -- Gnomebot Operating Boots
	[9451]={b=500,s=25,d=926,q=20,x=20,c=AUCT_CLAS_DRINK},  -- Bubbling Water
	[9452]={b=41051,s=8210,d=20323,c=AUCT_CLAS_WEAPON},  -- Hydrocane
	[9453]={b=32961,s=6592,d=20595,c=AUCT_CLAS_WEAPON},  -- Toxic Revenger
	[9454]={b=9923,s=1984,d=14749,c=AUCT_CLAS_ARMOR},  -- Acidic Walkers
	[9455]={b=9129,s=1825,d=18371,c=AUCT_CLAS_ARMOR},  -- Emissary Cuffs
	[9456]={b=33262,s=6652,d=18372,c=AUCT_CLAS_WEAPON},  -- Glass Shooter
	[9457]={b=44510,s=8902,d=18373,c=AUCT_CLAS_WEAPON},  -- Royal Diplomatic Scepter
	[9458]={b=34589,s=6917,d=18374,c=AUCT_CLAS_WEAPON},  -- Thermaplugg's Central Core
	[9459]={b=67801,s=13560,d=19298,c=AUCT_CLAS_WEAPON},  -- Thermaplugg's Left Arm
	[9460]={b=0,s=0,d=13998,q=20,x=20},  -- Grimtotem Horn
	[9461]={b=18345,s=4586,d=3258,c=AUCT_CLAS_ARMOR},  -- Charged Gear
	[9462]={b=0,s=0,d=9151},  -- Crate of Grimtotem Horns
	[9463]={b=0,s=0,d=18021,q=20,x=20},  -- Gordunni Cobalt
	[9465]={b=92804,s=18560,d=18377,c=AUCT_CLAS_WEAPON},  -- Digmaster 5000
	[9466]={b=0,s=0,d=18379},  -- Orwin's Shovel
	[9467]={b=93409,s=18681,d=20311,c=AUCT_CLAS_WEAPON},  -- Gahz'rilla Fang
	[9468]={b=0,s=0,d=11205},  -- Sharpbeak's Feather
	[9469]={b=73171,s=14634,d=18382,c=AUCT_CLAS_ARMOR},  -- Gahz'rilla Scale Armor
	[9470]={b=39292,s=7858,d=18689,c=AUCT_CLAS_ARMOR},  -- Bad Mojo Mask
	[9471]={b=0,s=0,d=7425},  -- Nekrum's Medallion
	[9472]={b=0,s=0,d=13025},  -- Hexx's Key
	[9473]={b=66207,s=13241,d=18386,c=AUCT_CLAS_ARMOR},  -- Jinxed Hoodoo Skin
	[9474]={b=66450,s=13290,d=18387,c=AUCT_CLAS_ARMOR},  -- Jinxed Hoodoo Kilt
	[9475]={b=166732,s=33346,d=22209,c=AUCT_CLAS_WEAPON},  -- Diabolic Skiver
	[9476]={b=42968,s=8593,d=18389,c=AUCT_CLAS_ARMOR},  -- Big Bad Pauldrons
	[9477]={b=179682,s=35936,d=21514,c=AUCT_CLAS_WEAPON},  -- The Chief's Enforcer
	[9478]={b=144265,s=28853,d=25598,c=AUCT_CLAS_WEAPON},  -- Ripsaw
	[9479]={b=54294,s=10858,d=18392,c=AUCT_CLAS_ARMOR},  -- Embrace of the Lycan
	[9480]={b=158625,s=31725,d=22235,c=AUCT_CLAS_WEAPON},  -- Eyegouger
	[9481]={b=170335,s=34067,d=19309,c=AUCT_CLAS_WEAPON},  -- The Minotaur
	[9482]={b=147925,s=29585,d=20269,c=AUCT_CLAS_WEAPON},  -- Witch Doctor's Cane
	[9483]={b=95695,s=19139,d=20786,c=AUCT_CLAS_WEAPON},  -- Flaming Incinerator
	[9484]={b=54811,s=10962,d=22426,c=AUCT_CLAS_ARMOR},  -- Spellshock Leggings
	[9485]={b=26440,s=5288,d=18403,c=AUCT_CLAS_WEAPON},  -- Vibroblade
	[9486]={b=27417,s=5483,d=19295,c=AUCT_CLAS_WEAPON},  -- Supercharger Battle Axe
	[9487]={b=18163,s=3632,d=18405,c=AUCT_CLAS_WEAPON},  -- Hi-tech Supergun
	[9488]={b=22096,s=4419,d=18406,c=AUCT_CLAS_WEAPON},  -- Oscillating Power Hammer
	[9489]={b=18450,s=3690,d=18408,c=AUCT_CLAS_WEAPON},  -- Gyromatic Icemaker
	[9490]={b=30609,s=6121,d=18409,c=AUCT_CLAS_WEAPON},  -- Gizmotron Megachopper
	[9491]={b=6542,s=1308,d=14765,c=AUCT_CLAS_ARMOR},  -- Hotshot Pilot's Gloves
	[9492]={b=15862,s=3172,d=18415,c=AUCT_CLAS_ARMOR},  -- Electromagnetic Gigaflux Reactivator
	[9507]={b=0,s=0,d=18426},  -- A Carefully-packed Crate
	[9508]={b=11762,s=2352,d=18428,c=AUCT_CLAS_ARMOR},  -- Mechbuilder's Overalls
	[9509]={b=13416,s=2683,d=18429,c=AUCT_CLAS_ARMOR},  -- Petrolspill Leggings
	[9510]={b=14729,s=2945,d=18431,c=AUCT_CLAS_ARMOR},  -- Caverndeep Trudgers
	[9511]={b=105300,s=21060,d=20029,c=AUCT_CLAS_WEAPON},  -- Bloodletter Scalpel
	[9512]={b=31705,s=6341,d=22988,c=AUCT_CLAS_ARMOR},  -- Blackmetal Cape
	[9513]={b=1526,s=305,d=18438,c=AUCT_CLAS_WEAPON},  -- Ley Staff
	[9514]={b=1532,s=306,d=20424,c=AUCT_CLAS_WEAPON},  -- Arcane Staff
	[9515]={b=6243,s=1248,d=18439,c=AUCT_CLAS_ARMOR},  -- Nether-lace Tunic
	[9516]={b=6429,s=1285,d=18440,c=AUCT_CLAS_ARMOR},  -- Astral Knot Blouse
	[9517]={b=65572,s=13114,d=20348,c=AUCT_CLAS_WEAPON},  -- Celestial Stave
	[9518]={b=9499,s=1899,d=18443,c=AUCT_CLAS_ARMOR},  -- Mud's Crushers
	[9519]={b=11444,s=2288,d=18444,c=AUCT_CLAS_ARMOR},  -- Durtfeet Stompers
	[9520]={b=57309,s=11461,d=20574,c=AUCT_CLAS_WEAPON},  -- Silent Hunter
	[9521]={b=71912,s=14382,d=19307,c=AUCT_CLAS_WEAPON},  -- Skullsplitter
	[9522]={b=24694,s=4938,d=18447,c=AUCT_CLAS_WEAPON},  -- Energized Stone Circle
	[9523]={b=0,s=0,d=17898,q=20,x=20},  -- Troll Temper
	[9527]={b=108069,s=21613,d=20300,c=AUCT_CLAS_WEAPON},  -- Spellshifter Rod
	[9528]={b=0,s=0,d=18473},  -- Edana's Dark Heart
	[9530]={b=0,s=0,d=13122},  -- Horn of Hatetalon
	[9531]={b=26322,s=5264,d=18497,c=AUCT_CLAS_ARMOR},  -- Gemshale Pauldrons
	[9533]={b=28370,s=7092,d=224,c=AUCT_CLAS_ARMOR},  -- Masons Fraternity Ring
	[9534]={b=44236,s=8847,d=18498,c=AUCT_CLAS_ARMOR},  -- Engineer's Guild Headpiece
	[9535]={b=7034,s=1406,d=28169,c=AUCT_CLAS_ARMOR},  -- Fire-welded Bracers
	[9536]={b=7059,s=1411,d=18901,c=AUCT_CLAS_ARMOR},  -- Fairywing Mantle
	[9538]={b=25852,s=6463,d=224,c=AUCT_CLAS_ARMOR},  -- Talvash's Gold Ring
	[9539]={b=200,s=50,d=12925},  -- Box of Rations
	[9540]={b=600,s=150,d=14006},  -- Box of Spells
	[9541]={b=800,s=200,d=16028},  -- Box of Goodies
	[9542]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Simple Letter
	[9543]={b=0,s=0,d=22443,c=AUCT_CLAS_WRITTEN},  -- Simple Rune
	[9544]={b=0,s=0,d=7629,c=AUCT_CLAS_WRITTEN},  -- Simple Memorandum
	[9545]={b=0,s=0,d=6015,c=AUCT_CLAS_WRITTEN},  -- Simple Sigil
	[9546]={b=0,s=0,d=1301,c=AUCT_CLAS_WRITTEN},  -- Simple Scroll
	[9547]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Simple Note
	[9548]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Hallowed Letter
	[9550]={b=0,s=0,d=22443,c=AUCT_CLAS_WRITTEN},  -- Encrypted Rune
	[9551]={b=0,s=0,d=6015,c=AUCT_CLAS_WRITTEN},  -- Encrypted Sigil
	[9552]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Rune-Inscribed Note
	[9553]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Etched Parchment
	[9554]={b=0,s=0,d=18500,c=AUCT_CLAS_WRITTEN},  -- Encrypted Tablet
	[9555]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Encrypted Letter
	[9556]={b=0,s=0,d=22443,c=AUCT_CLAS_WRITTEN},  -- Hallowed Rune
	[9557]={b=0,s=0,d=6015,c=AUCT_CLAS_WRITTEN},  -- Hallowed Sigil
	[9558]={b=0,s=0,d=7629,c=AUCT_CLAS_WRITTEN},  -- Encrypted Memorandum
	[9559]={b=0,s=0,d=1301,c=AUCT_CLAS_WRITTEN},  -- Encrypted Scroll
	[9560]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Encrypted Parchment
	[9561]={b=0,s=0,d=18500,c=AUCT_CLAS_WRITTEN},  -- Hallowed Tablet
	[9562]={b=0,s=0,d=18500,c=AUCT_CLAS_WRITTEN},  -- Rune-Inscribed Tablet
	[9563]={b=0,s=0,d=22443,c=AUCT_CLAS_WRITTEN},  -- Consecrated Rune
	[9564]={b=0,s=0,d=18500,c=AUCT_CLAS_WRITTEN},  -- Etched Tablet
	[9565]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Etched Note
	[9566]={b=0,s=0,d=22443,c=AUCT_CLAS_WRITTEN},  -- Etched Rune
	[9567]={b=0,s=0,d=6015,c=AUCT_CLAS_WRITTEN},  -- Etched Sigil
	[9568]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Rune-Inscribed Parchment
	[9569]={b=0,s=0,d=1301,c=AUCT_CLAS_WRITTEN},  -- Hallowed Scroll
	[9570]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Consecrated Letter
	[9571]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Glyphic Letter
	[9573]={b=0,s=0,d=7629,c=AUCT_CLAS_WRITTEN},  -- Glyphic Memorandum
	[9574]={b=0,s=0,d=1301,c=AUCT_CLAS_WRITTEN},  -- Glyphic Scroll
	[9575]={b=0,s=0,d=18500,c=AUCT_CLAS_WRITTEN},  -- Glyphic Tablet
	[9576]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Tainted Letter
	[9577]={b=0,s=0,d=7629,c=AUCT_CLAS_WRITTEN},  -- Tainted Memorandum
	[9578]={b=0,s=0,d=1301,c=AUCT_CLAS_WRITTEN},  -- Tainted Scroll
	[9579]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Tainted Parchment
	[9580]={b=0,s=0,d=6015,c=AUCT_CLAS_WRITTEN},  -- Verdant Sigil
	[9581]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Verdant Note
	[9587]={b=25000,s=6250,d=21202,c=AUCT_CLAS_CONTAINER},  -- Thawpelt Sack
	[9588]={b=25852,s=6463,d=224,c=AUCT_CLAS_ARMOR},  -- Nogg's Gold Ring
	[9589]={b=0,s=0,d=18514,q=20,x=20},  -- Encrusted Minerals
	[9590]={b=0,s=0,d=929},  -- Splintered Log
	[9591]={b=0,s=0,d=18517,q=20,x=20},  -- Resilient Sinew
	[9592]={b=0,s=0,d=18519,x=40},  -- Metallic Fragments
	[9593]={b=0,s=0,d=18524,q=20,x=20},  -- Treant Muisek
	[9594]={b=0,s=0,d=18094,q=20,x=20},  -- Wildkin Muisek
	[9595]={b=0,s=0,d=18525,q=20,x=20},  -- Hippogryph Muisek
	[9596]={b=0,s=0,d=18526,q=20,x=20},  -- Faerie Dragon Muisek
	[9597]={b=0,s=0,d=18527,q=20,x=20},  -- Mountain Giant Muisek
	[9598]={b=473,s=94,d=19011,c=AUCT_CLAS_ARMOR},  -- Sleeping Robes
	[9599]={b=713,s=142,d=26948,c=AUCT_CLAS_ARMOR},  -- Barkmail Leggings
	[9600]={b=465,s=93,d=18911,c=AUCT_CLAS_ARMOR},  -- Lace Pants
	[9601]={b=438,s=87,d=28142,c=AUCT_CLAS_ARMOR},  -- Cushioned Boots
	[9602]={b=1504,s=300,d=20069,c=AUCT_CLAS_WEAPON},  -- Brushwood Blade
	[9603]={b=1510,s=302,d=20432,c=AUCT_CLAS_WEAPON},  -- Gritroot Staff
	[9604]={b=28160,s=5632,d=18531,c=AUCT_CLAS_WEAPON},  -- Mechanic's Pipehammer
	[9605]={b=6783,s=1356,d=23134,c=AUCT_CLAS_ARMOR},  -- Repairman's Cape
	[9606]={b=0,s=0,d=18532},  -- Treant Muisek Vessel
	[9607]={b=8810,s=1762,d=18533,c=AUCT_CLAS_WEAPON},  -- Bastion of Stormwind
	[9608]={b=25144,s=5028,d=7494,c=AUCT_CLAS_WEAPON},  -- Shoni's Disarming Tool
	[9609]={b=5046,s=1009,d=18991,c=AUCT_CLAS_ARMOR},  -- Shilly Mitts
	[9618]={b=0,s=0,d=18532},  -- Wildkin Muisek Vessel
	[9619]={b=0,s=0,d=18532},  -- Hippogryph Muisek Vessel
	[9620]={b=0,s=0,d=18532},  -- Faerie Dragon Muisek Vessel
	[9621]={b=0,s=0,d=18532},  -- Mountain Giant Muisek Vessel
	[9622]={b=22660,s=5665,d=14432,c=AUCT_CLAS_ARMOR},  -- Reedknot Ring
	[9623]={b=20992,s=4198,d=18883,c=AUCT_CLAS_ARMOR},  -- Civinad Robes
	[9624]={b=26338,s=5267,d=28195,c=AUCT_CLAS_ARMOR},  -- Triprunner Dungarees
	[9625]={b=31721,s=6344,d=28317,c=AUCT_CLAS_ARMOR},  -- Dual Reinforced Leggings
	[9626]={b=81219,s=16243,d=19302,c=AUCT_CLAS_WEAPON},  -- Dwarven Charge
	[9627]={b=10170,s=2542,d=11410,c=AUCT_CLAS_WEAPON},  -- Explorer's League Lodestar
	[9628]={b=0,s=0,d=2593},  -- Neeru's Herb Pouch
	[9629]={b=0,s=0,d=18568},  -- A Shrunken Head
	[9630]={b=28903,s=5780,d=4440,c=AUCT_CLAS_ARMOR},  -- Pratt's Handcrafted Boots
	[9631]={b=19341,s=3868,d=28339,c=AUCT_CLAS_ARMOR},  -- Pratt's Handcrafted Gloves
	[9632]={b=19416,s=3883,d=28283,c=AUCT_CLAS_ARMOR},  -- Jangdor's Handcrafted Gloves
	[9633]={b=29237,s=5847,d=28281,c=AUCT_CLAS_ARMOR},  -- Jangdor's Handcrafted Boots
	[9634]={b=16905,s=3381,d=18998,c=AUCT_CLAS_ARMOR},  -- Skilled Handling Gloves
	[9635]={b=23567,s=4713,d=18915,c=AUCT_CLAS_ARMOR},  -- Master Apothecary Cape
	[9636]={b=15772,s=3154,d=4446,c=AUCT_CLAS_ARMOR},  -- Swashbuckler Sash
	[9637]={b=23747,s=4749,d=28252,c=AUCT_CLAS_ARMOR},  -- Shinkicker Boots
	[9638]={b=34376,s=6875,d=28118,c=AUCT_CLAS_ARMOR},  -- Chelonian Cuffs
	[9639]={b=120556,s=24111,d=18572,c=AUCT_CLAS_WEAPON},  -- The Hand of Antu'sul
	[9640]={b=24201,s=4840,d=18573,c=AUCT_CLAS_ARMOR},  -- Vice Grips
	[9641]={b=52165,s=13041,d=9854,c=AUCT_CLAS_ARMOR},  -- Lifeblood Amulet
	[9642]={b=8370,s=2092,d=9832,c=AUCT_CLAS_ARMOR},  -- Band of the Great Tortoise
	[9643]={b=79942,s=15988,d=18822,c=AUCT_CLAS_WEAPON},  -- Optomatic Deflector
	[9644]={b=39540,s=9885,d=18575,c=AUCT_CLAS_WEAPON},  -- Thermotastic Egg Timer
	[9645]={b=33841,s=6768,d=18906,c=AUCT_CLAS_ARMOR},  -- Gnomish Inventor Boots
	[9646]={b=33959,s=6791,d=28172,c=AUCT_CLAS_ARMOR},  -- Gnomish Water Sinking Device
	[9647]={b=39813,s=7962,d=18577,c=AUCT_CLAS_ARMOR},  -- Failed Flying Experiment
	[9648]={b=31963,s=6392,d=28097,c=AUCT_CLAS_ARMOR},  -- Chainlink Towel
	[9649]={b=66146,s=13229,d=28294,c=AUCT_CLAS_ARMOR},  -- Royal Highmark Vestments
	[9650]={b=90081,s=18016,d=28279,c=AUCT_CLAS_ARMOR},  -- Honorguard Chestpiece
	[9651]={b=134140,s=26828,d=18578,c=AUCT_CLAS_WEAPON},  -- Gryphon Rider's Stormhammer
	[9652]={b=67330,s=13466,d=17150,c=AUCT_CLAS_ARMOR},  -- Gryphon Rider's Leggings
	[9653]={b=33727,s=6745,d=18579,c=AUCT_CLAS_ARMOR},  -- Speedy Racer Goggles
	[9654]={b=84644,s=16928,d=28307,c=AUCT_CLAS_WEAPON},  -- Cairnstone Sliver
	[9655]={b=28370,s=7092,d=9833,c=AUCT_CLAS_ARMOR},  -- Seedtime Hoop
	[9656]={b=21256,s=4251,d=18580,c=AUCT_CLAS_ARMOR},  -- Granite Grips
	[9657]={b=26669,s=5333,d=28426,c=AUCT_CLAS_ARMOR},  -- Vinehedge Cinch
	[9658]={b=20432,s=4086,d=19913,c=AUCT_CLAS_ARMOR},  -- Boots of the Maharishi
	[9660]={b=21139,s=4227,d=28299,c=AUCT_CLAS_ARMOR},  -- Stargazer Cloak
	[9661]={b=45257,s=9051,d=20900,c=AUCT_CLAS_WEAPON},  -- Earthclasp Barrier
	[9662]={b=21291,s=4258,d=28295,c=AUCT_CLAS_ARMOR},  -- Rushridge Boots
	[9663]={b=49848,s=9969,d=28315,c=AUCT_CLAS_ARMOR},  -- Dawnrider's Chestpiece
	[9664]={b=25013,s=5002,d=18584,c=AUCT_CLAS_ARMOR},  -- Sentinel's Guard
	[9665]={b=24134,s=4826,d=18586,c=AUCT_CLAS_ARMOR},  -- Wingcrest Gloves
	[9666]={b=36332,s=7266,d=28300,c=AUCT_CLAS_ARMOR},  -- Stronghorn Girdle
	[9678]={b=87429,s=17485,d=5233,c=AUCT_CLAS_WEAPON},  -- Tok'kar's Murloc Basher
	[9679]={b=87750,s=17550,d=22223,c=AUCT_CLAS_WEAPON},  -- Tok'kar's Murloc Chopper
	[9680]={b=70451,s=14090,d=20475,c=AUCT_CLAS_WEAPON},  -- Tok'kar's Murloc Shanker
	[9681]={b=1000,s=50,d=7980,q=20,x=20},  -- Grilled King Crawler Legs
	[9682]={b=19159,s=3831,d=28284,c=AUCT_CLAS_ARMOR},  -- Leather Chef's Belt
	[9683]={b=149764,s=29952,d=20289,c=AUCT_CLAS_WEAPON},  -- Strength of the Treant
	[9684]={b=128648,s=25729,d=19130,c=AUCT_CLAS_WEAPON},  -- Force of the Hippogryph
	[9686]={b=129573,s=25914,d=19746,c=AUCT_CLAS_WEAPON},  -- Spirit of the Faerie Dragon
	[9687]={b=7771,s=1554,d=28328,c=AUCT_CLAS_ARMOR},  -- Grappler's Belt
	[9698]={b=7524,s=1504,d=17186,c=AUCT_CLAS_ARMOR},  -- Gloves of Insight
	[9699]={b=9062,s=1812,d=28326,c=AUCT_CLAS_ARMOR},  -- Garrison Cloak
	[9703]={b=21362,s=4272,d=28297,c=AUCT_CLAS_ARMOR},  -- Scorched Cape
	[9704]={b=17865,s=3573,d=28296,c=AUCT_CLAS_ARMOR},  -- Rustler Gloves
	[9705]={b=17930,s=3586,d=17231,c=AUCT_CLAS_ARMOR},  -- Tharg's Shoelace
	[9706]={b=46062,s=9212,d=20975,c=AUCT_CLAS_WEAPON},  -- Tharg's Disk
	[9718]={b=57106,s=11421,d=13488,c=AUCT_CLAS_WEAPON},  -- Reforged Blade of Heroes
	[9719]={b=25000,s=6250,d=13488},  -- Broken Blade of Heroes
	[9738]={b=0,s=0,d=1262,q=20,x=20},  -- Gem of Cobrahn
	[9739]={b=0,s=0,d=1262,q=20,x=20},  -- Gem of Anacondra
	[9740]={b=0,s=0,d=1262,q=20,x=20},  -- Gem of Pythas
	[9741]={b=0,s=0,d=1262,q=20,x=20},  -- Gem of Serpentis
	[9742]={b=246,s=49,d=14710,c=AUCT_CLAS_ARMOR},  -- Simple Cord
	[9743]={b=335,s=67,d=27532,c=AUCT_CLAS_ARMOR},  -- Simple Shoes
	[9744]={b=224,s=44,d=14705,c=AUCT_CLAS_ARMOR},  -- Simple Bands
	[9745]={b=270,s=54,d=27533,c=AUCT_CLAS_ARMOR},  -- Simple Cape
	[9746]={b=282,s=56,d=14706,c=AUCT_CLAS_ARMOR},  -- Simple Gloves
	[9747]={b=1139,s=227,d=14711,c=AUCT_CLAS_ARMOR},  -- Simple Britches
	[9748]={b=1371,s=274,d=18883,c=AUCT_CLAS_ARMOR},  -- Simple Robe
	[9749]={b=1376,s=275,d=27529,c=AUCT_CLAS_ARMOR},  -- Simple Blouse
	[9750]={b=287,s=57,d=19034,c=AUCT_CLAS_ARMOR},  -- Gypsy Sash
	[9751]={b=433,s=86,d=19033,c=AUCT_CLAS_ARMOR},  -- Gypsy Sandals
	[9752]={b=289,s=57,d=17169,c=AUCT_CLAS_ARMOR},  -- Gypsy Bands
	[9753]={b=1242,s=248,d=18469,c=AUCT_CLAS_WEAPON},  -- Gypsy Buckler
	[9754]={b=350,s=70,d=23034,c=AUCT_CLAS_ARMOR},  -- Gypsy Cloak
	[9755]={b=366,s=73,d=19032,c=AUCT_CLAS_ARMOR},  -- Gypsy Gloves
	[9756]={b=1471,s=294,d=19030,c=AUCT_CLAS_ARMOR},  -- Gypsy Trousers
	[9757]={b=1819,s=363,d=19029,c=AUCT_CLAS_ARMOR},  -- Gypsy Tunic
	[9758]={b=364,s=72,d=22683,c=AUCT_CLAS_ARMOR},  -- Cadet Belt
	[9759]={b=690,s=138,d=22684,c=AUCT_CLAS_ARMOR},  -- Cadet Boots
	[9760]={b=367,s=73,d=22685,c=AUCT_CLAS_ARMOR},  -- Cadet Bracers
	[9761]={b=294,s=58,d=25960,c=AUCT_CLAS_ARMOR},  -- Cadet Cloak
	[9762]={b=463,s=92,d=22686,c=AUCT_CLAS_ARMOR},  -- Cadet Gauntlets
	[9763]={b=1681,s=336,d=22687,c=AUCT_CLAS_ARMOR},  -- Cadet Leggings
	[9764]={b=1501,s=300,d=18823,c=AUCT_CLAS_WEAPON},  -- Cadet Shield
	[9765]={b=2034,s=406,d=22688,c=AUCT_CLAS_ARMOR},  -- Cadet Vest
	[9766]={b=1809,s=361,d=25947,c=AUCT_CLAS_ARMOR},  -- Greenweave Sash
	[9767]={b=3080,s=616,d=25946,c=AUCT_CLAS_ARMOR},  -- Greenweave Sandals
	[9768]={b=1586,s=317,d=25939,c=AUCT_CLAS_ARMOR},  -- Greenweave Bracers
	[9769]={b=6548,s=1637,d=28023,c=AUCT_CLAS_WEAPON},  -- Greenweave Branch
	[9770]={b=2084,s=416,d=23106,c=AUCT_CLAS_ARMOR},  -- Greenweave Cloak
	[9771]={b=2662,s=532,d=25941,c=AUCT_CLAS_ARMOR},  -- Greenweave Gloves
	[9772]={b=6644,s=1328,d=25942,c=AUCT_CLAS_ARMOR},  -- Greenweave Leggings
	[9773]={b=6847,s=1369,d=25944,c=AUCT_CLAS_ARMOR},  -- Greenweave Robe
	[9774]={b=6872,s=1374,d=25949,c=AUCT_CLAS_ARMOR},  -- Greenweave Vest
	[9775]={b=1579,s=315,d=28177,c=AUCT_CLAS_ARMOR},  -- Bandit Cinch
	[9776]={b=2735,s=547,d=16981,c=AUCT_CLAS_ARMOR},  -- Bandit Boots
	[9777]={b=1591,s=318,d=28427,c=AUCT_CLAS_ARMOR},  -- Bandit Bracers
	[9778]={b=4702,s=940,d=20826,c=AUCT_CLAS_WEAPON},  -- Bandit Buckler
	[9779]={b=1671,s=334,d=28433,c=AUCT_CLAS_ARMOR},  -- Bandit Cloak
	[9780]={b=1849,s=369,d=28428,c=AUCT_CLAS_ARMOR},  -- Bandit Gloves
	[9781]={b=4910,s=982,d=28431,c=AUCT_CLAS_ARMOR},  -- Bandit Pants
	[9782]={b=5568,s=1113,d=28430,c=AUCT_CLAS_ARMOR},  -- Bandit Jerkin
	[9783]={b=4059,s=811,d=13011,c=AUCT_CLAS_ARMOR},  -- Raider's Chestpiece
	[9784]={b=2669,s=533,d=6987,c=AUCT_CLAS_ARMOR},  -- Raider's Boots
	[9785]={b=1344,s=268,d=25776,c=AUCT_CLAS_ARMOR},  -- Raider's Bracers
	[9786]={b=1173,s=234,d=25978,c=AUCT_CLAS_ARMOR},  -- Raider's Cloak
	[9787]={b=1791,s=358,d=13484,c=AUCT_CLAS_ARMOR},  -- Raider's Gauntlets
	[9788]={b=1563,s=312,d=25775,c=AUCT_CLAS_ARMOR},  -- Raider's Belt
	[9789]={b=3709,s=741,d=3541,c=AUCT_CLAS_ARMOR},  -- Raider's Legguards
	[9790]={b=3972,s=794,d=18657,c=AUCT_CLAS_WEAPON},  -- Raider's Shield
	[9791]={b=8224,s=1644,d=27751,c=AUCT_CLAS_ARMOR},  -- Ivycloth Tunic
	[9792]={b=4115,s=823,d=16881,c=AUCT_CLAS_ARMOR},  -- Ivycloth Boots
	[9793]={b=2753,s=550,d=14736,c=AUCT_CLAS_ARMOR},  -- Ivycloth Bracelets
	[9794]={b=4145,s=829,d=27752,c=AUCT_CLAS_ARMOR},  -- Ivycloth Cloak
	[9795]={b=3134,s=626,d=27753,c=AUCT_CLAS_ARMOR},  -- Ivycloth Gloves
	[9796]={b=5190,s=1038,d=27754,c=AUCT_CLAS_ARMOR},  -- Ivycloth Mantle
	[9797]={b=7640,s=1528,d=27755,c=AUCT_CLAS_ARMOR},  -- Ivycloth Pants
	[9798]={b=8434,s=1686,d=18120,c=AUCT_CLAS_ARMOR},  -- Ivycloth Robe
	[9799]={b=3179,s=635,d=28477,c=AUCT_CLAS_ARMOR},  -- Ivycloth Sash
	[9800]={b=8110,s=2027,d=27756,c=AUCT_CLAS_WEAPON},  -- Ivy Orb
	[9801]={b=3542,s=708,d=6760,c=AUCT_CLAS_ARMOR},  -- Superior Belt
	[9802]={b=6024,s=1204,d=27761,c=AUCT_CLAS_ARMOR},  -- Superior Boots
	[9803]={b=3647,s=729,d=27760,c=AUCT_CLAS_ARMOR},  -- Superior Bracers
	[9804]={b=9372,s=1874,d=1685,c=AUCT_CLAS_WEAPON},  -- Superior Buckler
	[9805]={b=3549,s=709,d=23108,c=AUCT_CLAS_ARMOR},  -- Superior Cloak
	[9806]={b=4169,s=833,d=2358,c=AUCT_CLAS_ARMOR},  -- Superior Gloves
	[9807]={b=6278,s=1255,d=27759,c=AUCT_CLAS_ARMOR},  -- Superior Shoulders
	[9808]={b=9242,s=1848,d=691,c=AUCT_CLAS_ARMOR},  -- Superior Leggings
	[9809]={b=9276,s=1855,d=27758,c=AUCT_CLAS_ARMOR},  -- Superior Tunic
	[9810]={b=6155,s=1231,d=6869,c=AUCT_CLAS_ARMOR},  -- Fortified Boots
	[9811]={b=3628,s=725,d=25772,c=AUCT_CLAS_ARMOR},  -- Fortified Bracers
	[9812]={b=2851,s=570,d=25975,c=AUCT_CLAS_ARMOR},  -- Fortified Cloak
	[9813]={b=4129,s=825,d=25773,c=AUCT_CLAS_ARMOR},  -- Fortified Gauntlets
	[9814]={b=3668,s=733,d=25771,c=AUCT_CLAS_ARMOR},  -- Fortified Belt
	[9815]={b=8320,s=1664,d=697,c=AUCT_CLAS_ARMOR},  -- Fortified Leggings
	[9816]={b=8906,s=1781,d=26121,c=AUCT_CLAS_WEAPON},  -- Fortified Shield
	[9817]={b=7134,s=1426,d=25774,c=AUCT_CLAS_ARMOR},  -- Fortified Spaulders
	[9818]={b=8410,s=1682,d=1019,c=AUCT_CLAS_ARMOR},  -- Fortified Chain
	[9819]={b=13630,s=2726,d=27860,c=AUCT_CLAS_ARMOR},  -- Durable Tunic
	[9820]={b=7707,s=1541,d=27861,c=AUCT_CLAS_ARMOR},  -- Durable Boots
	[9821]={b=4357,s=871,d=27857,c=AUCT_CLAS_ARMOR},  -- Durable Bracers
	[9822]={b=5963,s=1192,d=27858,c=AUCT_CLAS_ARMOR},  -- Durable Cape
	[9823]={b=4828,s=965,d=10508,c=AUCT_CLAS_ARMOR},  -- Durable Gloves
	[9824]={b=7998,s=1599,d=27855,c=AUCT_CLAS_ARMOR},  -- Durable Shoulders
	[9825]={b=11775,s=2355,d=27853,c=AUCT_CLAS_ARMOR},  -- Durable Pants
	[9826]={b=13001,s=2600,d=27856,c=AUCT_CLAS_ARMOR},  -- Durable Robe
	[9827]={b=5570,s=1114,d=14936,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Belt
	[9828]={b=9225,s=1845,d=11581,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Boots
	[9829]={b=5100,s=1020,d=28482,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Bracers
	[9830]={b=17445,s=3489,d=6274,c=AUCT_CLAS_WEAPON},  -- Scaled Shield
	[9831]={b=6166,s=1233,d=27768,c=AUCT_CLAS_ARMOR},  -- Scaled Cloak
	[9832]={b=6240,s=1248,d=27766,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Gloves
	[9833]={b=15157,s=3031,d=6772,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Leggings
	[9834]={b=10371,s=2074,d=27764,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Shoulders
	[9835]={b=15266,s=3053,d=11580,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Tunic
	[9836]={b=18387,s=3677,d=27769,c=AUCT_CLAS_ARMOR},  -- Banded Armor
	[9837]={b=6436,s=1287,d=27783,c=AUCT_CLAS_ARMOR},  -- Banded Bracers
	[9838]={b=5872,s=1174,d=27779,c=AUCT_CLAS_ARMOR},  -- Banded Cloak
	[9839]={b=7134,s=1426,d=27778,c=AUCT_CLAS_ARMOR},  -- Banded Gauntlets
	[9840]={b=7161,s=1432,d=27777,c=AUCT_CLAS_ARMOR},  -- Banded Girdle
	[9841]={b=15815,s=3163,d=27770,c=AUCT_CLAS_ARMOR},  -- Banded Leggings
	[9842]={b=11958,s=2391,d=27776,c=AUCT_CLAS_ARMOR},  -- Banded Pauldrons
	[9843]={b=18696,s=3739,d=26060,c=AUCT_CLAS_WEAPON},  -- Banded Shield
	[9844]={b=18546,s=3709,d=28424,c=AUCT_CLAS_ARMOR},  -- Conjurer's Vest
	[9845]={b=10683,s=2136,d=28423,c=AUCT_CLAS_ARMOR},  -- Conjurer's Shoes
	[9846]={b=7148,s=1429,d=28418,c=AUCT_CLAS_ARMOR},  -- Conjurer's Bracers
	[9847]={b=8895,s=1779,d=15236,c=AUCT_CLAS_ARMOR},  -- Conjurer's Cloak
	[9848]={b=7922,s=1584,d=28422,c=AUCT_CLAS_ARMOR},  -- Conjurer's Gloves
	[9849]={b=11927,s=2385,d=16638,c=AUCT_CLAS_ARMOR},  -- Conjurer's Hood
	[9850]={b=11971,s=2394,d=12980,c=AUCT_CLAS_ARMOR},  -- Conjurer's Mantle
	[9851]={b=17623,s=3524,d=28419,c=AUCT_CLAS_ARMOR},  -- Conjurer's Breeches
	[9852]={b=19102,s=3820,d=28425,c=AUCT_CLAS_ARMOR},  -- Conjurer's Robe
	[9853]={b=6842,s=1368,d=28421,c=AUCT_CLAS_ARMOR},  -- Conjurer's Cinch
	[9854]={b=24677,s=4935,d=14068,c=AUCT_CLAS_ARMOR},  -- Archer's Jerkin
	[9855]={b=9475,s=1895,d=11956,c=AUCT_CLAS_ARMOR},  -- Archer's Belt
	[9856]={b=14195,s=2839,d=28734,c=AUCT_CLAS_ARMOR},  -- Archer's Boots
	[9857]={b=7851,s=1570,d=18930,c=AUCT_CLAS_ARMOR},  -- Archer's Bracers
	[9858]={b=24414,s=4882,d=18488,c=AUCT_CLAS_WEAPON},  -- Archer's Buckler
	[9859]={b=14359,s=2871,d=26550,c=AUCT_CLAS_ARMOR},  -- Archer's Cap
	[9860]={b=11912,s=2382,d=23004,c=AUCT_CLAS_ARMOR},  -- Archer's Cloak
	[9861]={b=8768,s=1753,d=18929,c=AUCT_CLAS_ARMOR},  -- Archer's Gloves
	[9862]={b=21302,s=4260,d=14635,c=AUCT_CLAS_ARMOR},  -- Archer's Trousers
	[9863]={b=16037,s=3207,d=8098,c=AUCT_CLAS_ARMOR},  -- Archer's Shoulderpads
	[9864]={b=17637,s=3527,d=25980,c=AUCT_CLAS_ARMOR},  -- Renegade Boots
	[9865]={b=9711,s=1942,d=25786,c=AUCT_CLAS_ARMOR},  -- Renegade Bracers
	[9866]={b=28025,s=5605,d=25787,c=AUCT_CLAS_ARMOR},  -- Renegade Chestguard
	[9867]={b=8894,s=1778,d=26251,c=AUCT_CLAS_ARMOR},  -- Renegade Cloak
	[9868]={b=10802,s=2160,d=25788,c=AUCT_CLAS_ARMOR},  -- Renegade Gauntlets
	[9869]={b=11129,s=2225,d=25784,c=AUCT_CLAS_ARMOR},  -- Renegade Belt
	[9870]={b=18430,s=3686,d=25991,c=AUCT_CLAS_ARMOR},  -- Renegade Circlet
	[9871]={b=27128,s=5425,d=26249,c=AUCT_CLAS_ARMOR},  -- Renegade Leggings
	[9872]={b=20508,s=4101,d=25790,c=AUCT_CLAS_ARMOR},  -- Renegade Pauldrons
	[9873]={b=29141,s=5828,d=25988,c=AUCT_CLAS_WEAPON},  -- Renegade Shield
	[9874]={b=29005,s=5801,d=28064,c=AUCT_CLAS_ARMOR},  -- Sorcerer Drape
	[9875]={b=10697,s=2139,d=26470,c=AUCT_CLAS_ARMOR},  -- Sorcerer Sash
	[9876]={b=15733,s=3146,d=28088,c=AUCT_CLAS_ARMOR},  -- Sorcerer Slippers
	[9877]={b=13541,s=2708,d=28065,c=AUCT_CLAS_ARMOR},  -- Sorcerer Cloak
	[9878]={b=17124,s=3424,d=28067,c=AUCT_CLAS_ARMOR},  -- Sorcerer Hat
	[9879]={b=9824,s=1964,d=28057,c=AUCT_CLAS_ARMOR},  -- Sorcerer Bracelets
	[9880]={b=10650,s=2130,d=28062,c=AUCT_CLAS_ARMOR},  -- Sorcerer Gloves
	[9881]={b=17320,s=3464,d=28068,c=AUCT_CLAS_ARMOR},  -- Sorcerer Mantle
	[9882]={b=24836,s=6209,d=21603,c=AUCT_CLAS_WEAPON},  -- Sorcerer Sphere
	[9883]={b=25130,s=5026,d=28061,c=AUCT_CLAS_ARMOR},  -- Sorcerer Pants
	[9884]={b=27244,s=5448,d=28074,c=AUCT_CLAS_ARMOR},  -- Sorcerer Robe
	[9885]={b=20899,s=4179,d=18904,c=AUCT_CLAS_ARMOR},  -- Huntsman's Boots
	[9886]={b=12948,s=2589,d=3606,c=AUCT_CLAS_ARMOR},  -- Huntsman's Bands
	[9887]={b=35357,s=7071,d=18903,c=AUCT_CLAS_ARMOR},  -- Huntsman's Armor
	[9889]={b=21203,s=4240,d=18921,c=AUCT_CLAS_ARMOR},  -- Huntsman's Cap
	[9890]={b=14595,s=2919,d=23023,c=AUCT_CLAS_ARMOR},  -- Huntsman's Cape
	[9891]={b=13181,s=2636,d=17129,c=AUCT_CLAS_ARMOR},  -- Huntsman's Belt
	[9892]={b=14287,s=2857,d=18912,c=AUCT_CLAS_ARMOR},  -- Huntsman's Gloves
	[9893]={b=33448,s=6689,d=27807,c=AUCT_CLAS_ARMOR},  -- Huntsman's Leggings
	[9894]={b=23308,s=4661,d=3169,c=AUCT_CLAS_ARMOR},  -- Huntsman's Shoulders
	[9895]={b=26105,s=5221,d=27787,c=AUCT_CLAS_ARMOR},  -- Jazeraint Boots
	[9896]={b=14567,s=2913,d=27788,c=AUCT_CLAS_ARMOR},  -- Jazeraint Bracers
	[9897]={b=36842,s=7368,d=27784,c=AUCT_CLAS_ARMOR},  -- Jazeraint Chestguard
	[9898]={b=13591,s=2718,d=27794,c=AUCT_CLAS_ARMOR},  -- Jazeraint Cloak
	[9899]={b=39600,s=7920,d=25911,c=AUCT_CLAS_WEAPON},  -- Jazeraint Shield
	[9900]={b=15975,s=3195,d=27791,c=AUCT_CLAS_ARMOR},  -- Jazeraint Gauntlets
	[9901]={b=16474,s=3294,d=27792,c=AUCT_CLAS_ARMOR},  -- Jazeraint Belt
	[9902]={b=26786,s=5357,d=27789,c=AUCT_CLAS_ARMOR},  -- Jazeraint Helm
	[9903]={b=38714,s=7742,d=26163,c=AUCT_CLAS_ARMOR},  -- Jazeraint Leggings
	[9904]={b=27104,s=5420,d=27790,c=AUCT_CLAS_ARMOR},  -- Jazeraint Pauldrons
	[9905]={b=41258,s=8251,d=28411,c=AUCT_CLAS_ARMOR},  -- Royal Blouse
	[9906]={b=15216,s=3043,d=28415,c=AUCT_CLAS_ARMOR},  -- Royal Sash
	[9907]={b=22909,s=4581,d=11548,c=AUCT_CLAS_ARMOR},  -- Royal Boots
	[9908]={b=21289,s=4257,d=28412,c=AUCT_CLAS_ARMOR},  -- Royal Cape
	[9909]={b=14242,s=2848,d=28410,c=AUCT_CLAS_ARMOR},  -- Royal Bands
	[9910]={b=15437,s=3087,d=28413,c=AUCT_CLAS_ARMOR},  -- Royal Gloves
	[9911]={b=36142,s=7228,d=28416,c=AUCT_CLAS_ARMOR},  -- Royal Trousers
	[9912]={b=25188,s=5037,d=28409,c=AUCT_CLAS_ARMOR},  -- Royal Amice
	[9913]={b=42454,s=8490,d=28417,c=AUCT_CLAS_ARMOR},  -- Royal Gown
	[9914]={b=30230,s=7557,d=18714,c=AUCT_CLAS_WEAPON},  -- Royal Scepter
	[9915]={b=25456,s=5091,d=28414,c=AUCT_CLAS_ARMOR},  -- Royal Headband
	[9916]={b=17834,s=3566,d=17115,c=AUCT_CLAS_ARMOR},  -- Tracker's Belt
	[9917]={b=27598,s=5519,d=18937,c=AUCT_CLAS_ARMOR},  -- Tracker's Boots
	[9918]={b=51061,s=10212,d=25940,c=AUCT_CLAS_WEAPON},  -- Brigade Defender
	[9919]={b=25746,s=5149,d=23073,c=AUCT_CLAS_ARMOR},  -- Tracker's Cloak
	[9920]={b=18606,s=3721,d=18936,c=AUCT_CLAS_ARMOR},  -- Tracker's Gloves
	[9921]={b=30252,s=6050,d=19010,c=AUCT_CLAS_ARMOR},  -- Tracker's Headband
	[9922]={b=43726,s=8745,d=18935,c=AUCT_CLAS_ARMOR},  -- Tracker's Leggings
	[9923]={b=30477,s=6095,d=18939,c=AUCT_CLAS_ARMOR},  -- Tracker's Shoulderpads
	[9924]={b=51380,s=10276,d=18934,c=AUCT_CLAS_ARMOR},  -- Tracker's Tunic
	[9925]={b=18949,s=3789,d=18938,c=AUCT_CLAS_ARMOR},  -- Tracker's Wristguards
	[9926]={b=31840,s=6368,d=25930,c=AUCT_CLAS_ARMOR},  -- Brigade Boots
	[9927]={b=19638,s=3927,d=25931,c=AUCT_CLAS_ARMOR},  -- Brigade Bracers
	[9928]={b=49654,s=9930,d=25932,c=AUCT_CLAS_ARMOR},  -- Brigade Breastplate
	[9929]={b=18314,s=3662,d=25938,c=AUCT_CLAS_ARMOR},  -- Brigade Cloak
	[9930]={b=21439,s=4287,d=25933,c=AUCT_CLAS_ARMOR},  -- Brigade Gauntlets
	[9931]={b=21516,s=4303,d=25928,c=AUCT_CLAS_ARMOR},  -- Brigade Girdle
	[9932]={b=34977,s=6995,d=25937,c=AUCT_CLAS_ARMOR},  -- Brigade Circlet
	[9933]={b=46970,s=9394,d=25934,c=AUCT_CLAS_ARMOR},  -- Brigade Leggings
	[9934]={b=32888,s=6577,d=25935,c=AUCT_CLAS_ARMOR},  -- Brigade Pauldrons
	[9935]={b=50486,s=10097,d=18819,c=AUCT_CLAS_WEAPON},  -- Embossed Plate Shield
	[9936]={b=32016,s=6403,d=28010,c=AUCT_CLAS_ARMOR},  -- Abjurer's Boots
	[9937]={b=20023,s=4004,d=16936,c=AUCT_CLAS_ARMOR},  -- Abjurer's Bands
	[9938]={b=30147,s=6029,d=15040,c=AUCT_CLAS_ARMOR},  -- Abjurer's Cloak
	[9939]={b=21586,s=4317,d=17130,c=AUCT_CLAS_ARMOR},  -- Abjurer's Gloves
	[9940]={b=34772,s=6954,d=27799,c=AUCT_CLAS_ARMOR},  -- Abjurer's Hood
	[9941]={b=32619,s=6523,d=27796,c=AUCT_CLAS_ARMOR},  -- Abjurer's Mantle
	[9942]={b=46708,s=9341,d=14613,c=AUCT_CLAS_ARMOR},  -- Abjurer's Pants
	[9943]={b=56358,s=11271,d=27800,c=AUCT_CLAS_ARMOR},  -- Abjurer's Robe
	[9944]={b=34283,s=8570,d=27801,c=AUCT_CLAS_WEAPON},  -- Abjurer's Crystal
	[9945]={b=20623,s=4124,d=13664,c=AUCT_CLAS_ARMOR},  -- Abjurer's Sash
	[9946]={b=56982,s=11396,d=28972,c=AUCT_CLAS_ARMOR},  -- Abjurer's Tunic
	[9947]={b=25965,s=5193,d=14702,c=AUCT_CLAS_ARMOR},  -- Chieftain's Belt
	[9948]={b=41826,s=8365,d=18944,c=AUCT_CLAS_ARMOR},  -- Chieftain's Boots
	[9949]={b=24276,s=4855,d=18945,c=AUCT_CLAS_ARMOR},  -- Chieftain's Bracers
	[9950]={b=67091,s=13418,d=18943,c=AUCT_CLAS_ARMOR},  -- Chieftain's Breastplate
	[9951]={b=33976,s=6795,d=23018,c=AUCT_CLAS_ARMOR},  -- Chieftain's Cloak
	[9952]={b=26276,s=5255,d=18946,c=AUCT_CLAS_ARMOR},  -- Chieftain's Gloves
	[9953]={b=42335,s=8467,d=11275,c=AUCT_CLAS_ARMOR},  -- Chieftain's Headdress
	[9954]={b=60629,s=12125,d=18947,c=AUCT_CLAS_ARMOR},  -- Chieftain's Leggings
	[9955]={b=42654,s=8530,d=18951,c=AUCT_CLAS_ARMOR},  -- Chieftain's Shoulders
	[9956]={b=25650,s=5130,d=26181,c=AUCT_CLAS_ARMOR},  -- Warmonger's Bracers
	[9957]={b=68766,s=13753,d=26183,c=AUCT_CLAS_ARMOR},  -- Warmonger's Chestpiece
	[9958]={b=73620,s=14724,d=26234,c=AUCT_CLAS_WEAPON},  -- Warmonger's Buckler
	[9959]={b=24017,s=4803,d=26202,c=AUCT_CLAS_ARMOR},  -- Warmonger's Cloak
	[9960]={b=28119,s=5623,d=26185,c=AUCT_CLAS_ARMOR},  -- Warmonger's Gauntlets
	[9961]={b=28224,s=5644,d=26180,c=AUCT_CLAS_ARMOR},  -- Warmonger's Belt
	[9962]={b=46092,s=9218,d=26188,c=AUCT_CLAS_ARMOR},  -- Warmonger's Greaves
	[9963]={b=46058,s=9211,d=26200,c=AUCT_CLAS_ARMOR},  -- Warmonger's Circlet
	[9964]={b=65952,s=13190,d=26191,c=AUCT_CLAS_ARMOR},  -- Warmonger's Leggings
	[9965]={b=49866,s=9973,d=26194,c=AUCT_CLAS_ARMOR},  -- Warmonger's Pauldrons
	[9966]={b=33715,s=6743,d=27348,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Armor
	[9967]={b=14503,s=2900,d=27351,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Gauntlets
	[9968]={b=13476,s=2695,d=27352,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Girdle
	[9969]={b=19824,s=3964,d=27511,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Helmet
	[9970]={b=28654,s=5730,d=27354,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Leggings
	[9971]={b=19976,s=3995,d=27355,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Pauldrons
	[9972]={b=12378,s=2475,d=27350,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Bracers
	[9973]={b=18637,s=3727,d=27349,c=AUCT_CLAS_ARMOR},  -- Embossed Plate Boots
	[9974]={b=82246,s=16449,d=18815,c=AUCT_CLAS_WEAPON},  -- Overlord's Shield
	[9978]={b=0,s=0,d=21296,c=AUCT_CLAS_ARMOR},  -- Gahz'ridian Detector
	[9998]={b=24076,s=4815,d=24352,c=AUCT_CLAS_ARMOR},  -- Black Mageweave Vest
	[9999]={b=24164,s=4832,d=24354,c=AUCT_CLAS_ARMOR},  -- Black Mageweave Leggings
	[10000]={b=0,s=0,d=6338,c=AUCT_CLAS_QUEST},  -- Margol's Horn
	[10001]={b=26285,s=5257,d=19141,c=AUCT_CLAS_ARMOR},  -- Black Mageweave Robe
	[10002]={b=26380,s=5276,d=19061,c=AUCT_CLAS_ARMOR},  -- Shadoweave Pants
	[10003]={b=14296,s=2859,d=18835,c=AUCT_CLAS_ARMOR},  -- Black Mageweave Gloves
	[10004]={b=28694,s=5738,d=24951,c=AUCT_CLAS_ARMOR},  -- Shadoweave Robe
	[10005]={b=0,s=0,d=6338},  -- Margol's Gigantic Horn
	[10007]={b=28999,s=5799,d=19114,c=AUCT_CLAS_ARMOR},  -- Red Mageweave Vest
	[10008]={b=21826,s=4365,d=18861,c=AUCT_CLAS_ARMOR},  -- White Bandit Mask
	[10009]={b=26424,s=5284,d=16764,c=AUCT_CLAS_ARMOR},  -- Red Mageweave Pants
	[10018]={b=16376,s=3275,d=19111,c=AUCT_CLAS_ARMOR},  -- Red Mageweave Gloves
	[10019]={b=19721,s=3944,d=18999,c=AUCT_CLAS_ARMOR},  -- Dreamweave Gloves
	[10021]={b=39730,s=7946,d=18949,c=AUCT_CLAS_ARMOR},  -- Dreamweave Vest
	[10022]={b=0,s=0,d=16065,c=AUCT_CLAS_WRITTEN},  -- Proof of Deed
	[10023]={b=16672,s=3334,d=19055,c=AUCT_CLAS_ARMOR},  -- Shadoweave Gloves
	[10024]={b=27107,s=5421,d=18860,c=AUCT_CLAS_ARMOR},  -- Black Mageweave Headband
	[10025]={b=33952,s=6790,d=19060,c=AUCT_CLAS_ARMOR},  -- Shadoweave Mask
	[10026]={b=27298,s=5459,d=21154,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_ENGINEER},  -- Black Mageweave Boots
	[10027]={b=27396,s=5479,d=18865,c=AUCT_CLAS_ARMOR},  -- Black Mageweave Shoulders
	[10028]={b=29692,s=5938,d=18866,c=AUCT_CLAS_ARMOR},  -- Shadoweave Shoulders
	[10029]={b=26959,s=5391,d=19113,c=AUCT_CLAS_ARMOR},  -- Red Mageweave Shoulders
	[10030]={b=30037,s=6007,d=18872,c=AUCT_CLAS_ARMOR},  -- Admiral's Hat
	[10031]={b=30150,s=6030,d=19051,c=AUCT_CLAS_ARMOR},  -- Shadoweave Boots
	[10033]={b=30377,s=6075,d=18879,c=AUCT_CLAS_ARMOR},  -- Red Mageweave Headband
	[10034]={b=8000,s=2000,d=13115,c=AUCT_CLAS_ARMOR},  -- Tuxedo Shirt
	[10035]={b=8676,s=1735,d=13117,c=AUCT_CLAS_ARMOR},  -- Tuxedo Pants
	[10036]={b=8708,s=1741,d=13116,c=AUCT_CLAS_ARMOR},  -- Tuxedo Jacket
	[10040]={b=8836,s=1767,d=13119,c=AUCT_CLAS_ARMOR},  -- White Wedding Dress
	[10041]={b=35806,s=7161,d=19000,c=AUCT_CLAS_ARMOR},  -- Dreamweave Circlet
	[10042]={b=33222,s=6644,d=14606,c=AUCT_CLAS_ARMOR},  -- Cindercloth Robe
	[10043]={b=10167,s=2033,d=20209,c=AUCT_CLAS_ARMOR},  -- Pious Legwraps
	[10044]={b=33827,s=6765,d=18933,c=AUCT_CLAS_ARMOR},  -- Cindercloth Boots
	[10045]={b=117,s=23,d=14450,c=AUCT_CLAS_ARMOR},  -- Simple Linen Pants
	[10046]={b=161,s=32,d=16853,c=AUCT_CLAS_ARMOR},  -- Simple Linen Boots
	[10047]={b=822,s=164,d=19009,c=AUCT_CLAS_ARMOR},  -- Simple Kilt
	[10048]={b=4678,s=935,d=18914,c=AUCT_CLAS_ARMOR},  -- Colorful Kilt
	[10050]={b=10000,s=2500,d=1282,c=AUCT_CLAS_CONTAINER},  -- Mageweave Bag
	[10051]={b=10000,s=2500,d=4056,c=AUCT_CLAS_CONTAINER},  -- Red Mageweave Bag
	[10052]={b=6000,s=1500,d=18916,c=AUCT_CLAS_ARMOR},  -- Orange Martial Shirt
	[10053]={b=22497,s=4499,d=19142,c=AUCT_CLAS_ARMOR},  -- Simple Black Dress
	[10054]={b=12000,s=3000,d=18924,c=AUCT_CLAS_ARMOR},  -- Lavender Mageweave Shirt
	[10055]={b=12000,s=3000,d=18923,c=AUCT_CLAS_ARMOR},  -- Pink Mageweave Shirt
	[10056]={b=6000,s=1500,d=18925,c=AUCT_CLAS_ARMOR},  -- Orange Mageweave Shirt
	[10057]={b=63558,s=12711,d=28158,c=AUCT_CLAS_ARMOR},  -- Duskwoven Tunic
	[10058]={b=35417,s=7083,d=28151,c=AUCT_CLAS_ARMOR},  -- Duskwoven Sandals
	[10059]={b=23697,s=4739,d=28124,c=AUCT_CLAS_ARMOR},  -- Duskwoven Bracers
	[10060]={b=33339,s=6667,d=28125,c=AUCT_CLAS_ARMOR},  -- Duskwoven Cape
	[10061]={b=38309,s=7661,d=28131,c=AUCT_CLAS_ARMOR},  -- Duskwoven Turban
	[10062]={b=23791,s=4758,d=29002,c=AUCT_CLAS_ARMOR},  -- Duskwoven Gloves
	[10063]={b=35826,s=7165,d=28123,c=AUCT_CLAS_ARMOR},  -- Duskwoven Amice
	[10064]={b=53874,s=10774,d=28140,c=AUCT_CLAS_ARMOR},  -- Duskwoven Pants
	[10065]={b=60767,s=12153,d=28165,c=AUCT_CLAS_ARMOR},  -- Duskwoven Robe
	[10066]={b=21101,s=4220,d=28155,c=AUCT_CLAS_ARMOR},  -- Duskwoven Sash
	[10067]={b=26478,s=5295,d=19019,c=AUCT_CLAS_ARMOR},  -- Righteous Waistguard
	[10068]={b=45640,s=9128,d=19013,c=AUCT_CLAS_ARMOR},  -- Righteous Boots
	[10069]={b=26677,s=5335,d=19014,c=AUCT_CLAS_ARMOR},  -- Righteous Bracers
	[10070]={b=77411,s=15482,d=19012,c=AUCT_CLAS_ARMOR},  -- Righteous Armor
	[10071]={b=40315,s=8063,d=23060,c=AUCT_CLAS_ARMOR},  -- Righteous Cloak
	[10072]={b=30886,s=6177,d=19017,c=AUCT_CLAS_ARMOR},  -- Righteous Gloves
	[10073]={b=49293,s=9858,d=21309,c=AUCT_CLAS_ARMOR},  -- Righteous Helmet
	[10074]={b=69928,s=13985,d=19018,c=AUCT_CLAS_ARMOR},  -- Righteous Leggings
	[10075]={b=46845,s=9369,d=19020,c=AUCT_CLAS_ARMOR},  -- Righteous Spaulders
	[10076]={b=32855,s=6571,d=19725,c=AUCT_CLAS_ARMOR},  -- Lord's Armguards
	[10077]={b=84841,s=16968,d=26327,c=AUCT_CLAS_ARMOR},  -- Lord's Breastplate
	[10078]={b=93213,s=18642,d=20972,c=AUCT_CLAS_WEAPON},  -- Lord's Crest
	[10079]={b=31852,s=6370,d=26331,c=AUCT_CLAS_ARMOR},  -- Lord's Cape
	[10080]={b=36598,s=7319,d=26328,c=AUCT_CLAS_ARMOR},  -- Lord's Gauntlets
	[10081]={b=36728,s=7345,d=19718,c=AUCT_CLAS_ARMOR},  -- Lord's Girdle
	[10082]={b=53763,s=10752,d=26326,c=AUCT_CLAS_ARMOR},  -- Lord's Boots
	[10083]={b=53728,s=10745,d=26330,c=AUCT_CLAS_ARMOR},  -- Lord's Crown
	[10084]={b=76231,s=15246,d=19720,c=AUCT_CLAS_ARMOR},  -- Lord's Legguards
	[10085]={b=57648,s=11529,d=26329,c=AUCT_CLAS_ARMOR},  -- Lord's Pauldrons
	[10086]={b=42194,s=8438,d=27363,c=AUCT_CLAS_ARMOR},  -- Gothic Plate Armor
	[10087]={b=16968,s=3393,d=27364,c=AUCT_CLAS_ARMOR},  -- Gothic Plate Gauntlets
	[10088]={b=15772,s=3154,d=27365,c=AUCT_CLAS_ARMOR},  -- Gothic Plate Girdle
	[10089]={b=23747,s=4749,d=27370,c=AUCT_CLAS_ARMOR},  -- Gothic Sabatons
	[10090]={b=25742,s=5148,d=27366,c=AUCT_CLAS_ARMOR},  -- Gothic Plate Helmet
	[10091]={b=37208,s=7441,d=27367,c=AUCT_CLAS_ARMOR},  -- Gothic Plate Leggings
	[10092]={b=28011,s=5602,d=27371,c=AUCT_CLAS_ARMOR},  -- Gothic Plate Spaulders
	[10093]={b=94517,s=18903,d=27432,c=AUCT_CLAS_WEAPON},  -- Revenant Deflector
	[10094]={b=16557,s=3311,d=27368,c=AUCT_CLAS_ARMOR},  -- Gothic Plate Vambraces
	[10095]={b=51476,s=10295,d=27600,c=AUCT_CLAS_ARMOR},  -- Councillor's Boots
	[10096]={b=30653,s=6130,d=27601,c=AUCT_CLAS_ARMOR},  -- Councillor's Cuffs
	[10097]={b=54959,s=10991,d=27606,c=AUCT_CLAS_ARMOR},  -- Councillor's Circlet
	[10098]={b=43684,s=8736,d=27607,c=AUCT_CLAS_ARMOR},  -- Councillor's Cloak
	[10099]={b=32839,s=6567,d=27602,c=AUCT_CLAS_ARMOR},  -- Councillor's Gloves
	[10100]={b=55544,s=11108,d=27605,c=AUCT_CLAS_ARMOR},  -- Councillor's Shoulders
	[10101]={b=78781,s=15756,d=27598,c=AUCT_CLAS_ARMOR},  -- Councillor's Pants
	[10102]={b=75101,s=15020,d=27609,c=AUCT_CLAS_ARMOR},  -- Councillor's Robes
	[10103]={b=28437,s=5687,d=27614,c=AUCT_CLAS_ARMOR},  -- Councillor's Sash
	[10104]={b=75686,s=15137,d=27599,c=AUCT_CLAS_ARMOR},  -- Councillor's Tunic
	[10105]={b=99711,s=19942,d=27716,c=AUCT_CLAS_ARMOR},  -- Wanderer's Armor
	[10106]={b=60601,s=12120,d=27718,c=AUCT_CLAS_ARMOR},  -- Wanderer's Boots
	[10107]={b=36094,s=7218,d=27719,c=AUCT_CLAS_ARMOR},  -- Wanderer's Bracers
	[10108]={b=41016,s=8203,d=27721,c=AUCT_CLAS_ARMOR},  -- Wanderer's Cloak
	[10109]={b=36366,s=7273,d=27717,c=AUCT_CLAS_ARMOR},  -- Wanderer's Belt
	[10110]={b=39739,s=7947,d=27726,c=AUCT_CLAS_ARMOR},  -- Wanderer's Gloves
	[10111]={b=67223,s=13444,d=28590,c=AUCT_CLAS_ARMOR},  -- Wanderer's Hat
	[10112]={b=95356,s=19071,d=27731,c=AUCT_CLAS_ARMOR},  -- Wanderer's Leggings
	[10113]={b=67708,s=13541,d=27733,c=AUCT_CLAS_ARMOR},  -- Wanderer's Shoulders
	[10118]={b=116909,s=23381,d=26291,c=AUCT_CLAS_ARMOR},  -- Ornate Breastplate
	[10119]={b=83383,s=16676,d=26297,c=AUCT_CLAS_ARMOR},  -- Ornate Greaves
	[10120]={b=43987,s=8797,d=26304,c=AUCT_CLAS_ARMOR},  -- Ornate Cloak
	[10121]={b=52576,s=10515,d=26293,c=AUCT_CLAS_ARMOR},  -- Ornate Gauntlets
	[10122]={b=45035,s=9007,d=26295,c=AUCT_CLAS_ARMOR},  -- Ornate Girdle
	[10123]={b=76198,s=15239,d=26303,c=AUCT_CLAS_ARMOR},  -- Ornate Circlet
	[10124]={b=101982,s=20396,d=19708,c=AUCT_CLAS_ARMOR},  -- Ornate Legguards
	[10125]={b=72757,s=14551,d=26301,c=AUCT_CLAS_ARMOR},  -- Ornate Pauldrons
	[10126]={b=44327,s=8865,d=26289,c=AUCT_CLAS_ARMOR},  -- Ornate Bracers
	[10127]={b=21752,s=4350,d=27426,c=AUCT_CLAS_ARMOR},  -- Revenant Bracers
	[10128]={b=59538,s=11907,d=27427,c=AUCT_CLAS_ARMOR},  -- Revenant Chestplate
	[10129]={b=23445,s=4689,d=27428,c=AUCT_CLAS_ARMOR},  -- Revenant Gauntlets
	[10130]={b=23531,s=4706,d=27429,c=AUCT_CLAS_ARMOR},  -- Revenant Girdle
	[10131]={b=35428,s=7085,d=27425,c=AUCT_CLAS_ARMOR},  -- Revenant Boots
	[10132]={b=38043,s=7608,d=19759,c=AUCT_CLAS_ARMOR},  -- Revenant Helmet
	[10133]={b=53964,s=10792,d=27430,c=AUCT_CLAS_ARMOR},  -- Revenant Leggings
	[10134]={b=38320,s=7664,d=27431,c=AUCT_CLAS_ARMOR},  -- Revenant Shoulders
	[10135]={b=103318,s=20663,d=27628,c=AUCT_CLAS_ARMOR},  -- High Councillor's Tunic
	[10136]={b=42653,s=8530,d=27630,c=AUCT_CLAS_ARMOR},  -- High Councillor's Bracers
	[10137]={b=67420,s=13484,d=27633,c=AUCT_CLAS_ARMOR},  -- High Councillor's Boots
	[10138]={b=61371,s=12274,d=27631,c=AUCT_CLAS_ARMOR},  -- High Councillor's Cloak
	[10139]={b=71291,s=14258,d=28852,c=AUCT_CLAS_ARMOR},  -- High Councillor's Circlet
	[10140]={b=45425,s=9085,d=27639,c=AUCT_CLAS_ARMOR},  -- High Councillor's Gloves
	[10141]={b=100518,s=20103,d=27629,c=AUCT_CLAS_ARMOR},  -- High Councillor's Pants
	[10142]={b=67007,s=13401,d=27640,c=AUCT_CLAS_ARMOR},  -- High Councillor's Mantle
	[10143]={b=98864,s=19772,d=27645,c=AUCT_CLAS_ARMOR},  -- High Councillor's Robe
	[10144]={b=40820,s=8164,d=27647,c=AUCT_CLAS_ARMOR},  -- High Councillor's Sash
	[10145]={b=48779,s=9755,d=18974,c=AUCT_CLAS_ARMOR},  -- Mighty Girdle
	[10146]={b=80970,s=16194,d=27741,c=AUCT_CLAS_ARMOR},  -- Mighty Boots
	[10147]={b=51596,s=10319,d=27740,c=AUCT_CLAS_ARMOR},  -- Mighty Armsplints
	[10148]={b=56367,s=11273,d=27743,c=AUCT_CLAS_ARMOR},  -- Mighty Cloak
	[10149]={b=54579,s=10915,d=27745,c=AUCT_CLAS_ARMOR},  -- Mighty Gauntlets
	[10150]={b=86270,s=17254,d=27746,c=AUCT_CLAS_ARMOR},  -- Mighty Helmet
	[10151]={b=127283,s=25456,d=27739,c=AUCT_CLAS_ARMOR},  -- Mighty Tunic
	[10152]={b=121666,s=24333,d=18962,c=AUCT_CLAS_ARMOR},  -- Mighty Leggings
	[10153]={b=87221,s=17444,d=27748,c=AUCT_CLAS_ARMOR},  -- Mighty Spaulders
	[10154]={b=66689,s=13337,d=26127,c=AUCT_CLAS_ARMOR},  -- Mercurial Girdle
	[10155]={b=100842,s=20168,d=26129,c=AUCT_CLAS_ARMOR},  -- Mercurial Greaves
	[10156]={b=63973,s=12794,d=26122,c=AUCT_CLAS_ARMOR},  -- Mercurial Bracers
	[10157]={b=156081,s=31216,d=26123,c=AUCT_CLAS_ARMOR},  -- Mercurial Breastplate
	[10158]={b=155200,s=31040,d=26152,c=AUCT_CLAS_WEAPON},  -- Mercurial Guard
	[10159]={b=57220,s=11444,d=26141,c=AUCT_CLAS_ARMOR},  -- Mercurial Cloak
	[10160]={b=99741,s=19948,d=26139,c=AUCT_CLAS_ARMOR},  -- Mercurial Circlet
	[10161]={b=63568,s=12713,d=26125,c=AUCT_CLAS_ARMOR},  -- Mercurial Gauntlets
	[10162]={b=140688,s=28137,d=26130,c=AUCT_CLAS_ARMOR},  -- Mercurial Legguards
	[10163]={b=101320,s=20264,d=23490,c=AUCT_CLAS_ARMOR},  -- Mercurial Pauldrons
	[10164]={b=74044,s=14808,d=27407,c=AUCT_CLAS_ARMOR},  -- Templar Chestplate
	[10165]={b=31200,s=6240,d=29014,c=AUCT_CLAS_ARMOR},  -- Templar Gauntlets
	[10166]={b=29542,s=5908,d=27411,c=AUCT_CLAS_ARMOR},  -- Templar Girdle
	[10167]={b=47147,s=9429,d=27405,c=AUCT_CLAS_ARMOR},  -- Templar Boots
	[10168]={b=50161,s=10032,d=27408,c=AUCT_CLAS_ARMOR},  -- Templar Crown
	[10169]={b=71151,s=14230,d=27413,c=AUCT_CLAS_ARMOR},  -- Templar Legplates
	[10170]={b=50528,s=10105,d=27414,c=AUCT_CLAS_ARMOR},  -- Templar Pauldrons
	[10171]={b=30090,s=6018,d=27406,c=AUCT_CLAS_ARMOR},  -- Templar Bracers
	[10172]={b=48018,s=9603,d=28109,c=AUCT_CLAS_ARMOR},  -- Mystical Mantle
	[10173]={b=28592,s=5718,d=28082,c=AUCT_CLAS_ARMOR},  -- Mystical Bracers
	[10174]={b=40607,s=8121,d=23136,c=AUCT_CLAS_ARMOR},  -- Mystical Cape
	[10175]={b=45054,s=9010,d=28853,c=AUCT_CLAS_ARMOR},  -- Mystical Headwrap
	[10176]={b=28446,s=5689,d=28083,c=AUCT_CLAS_ARMOR},  -- Mystical Gloves
	[10177]={b=64165,s=12833,d=28084,c=AUCT_CLAS_ARMOR},  -- Mystical Leggings
	[10178]={b=72375,s=14475,d=28112,c=AUCT_CLAS_ARMOR},  -- Mystical Robe
	[10179]={b=43161,s=8632,d=28080,c=AUCT_CLAS_ARMOR},  -- Mystical Boots
	[10180]={b=25707,s=5141,d=28079,c=AUCT_CLAS_ARMOR},  -- Mystical Belt
	[10181]={b=73202,s=14640,d=28078,c=AUCT_CLAS_ARMOR},  -- Mystical Armor
	[10182]={b=91850,s=18370,d=19002,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Breastplate
	[10183]={b=54772,s=10954,d=6762,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Boots
	[10184]={b=32617,s=6523,d=4382,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Bracers
	[10185]={b=37064,s=7412,d=23042,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Cape
	[10186]={b=34834,s=6966,d=19005,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Gloves
	[10187]={b=58928,s=11785,d=27809,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Eyepatch
	[10188]={b=83587,s=16717,d=17137,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Leggings
	[10189]={b=59360,s=11872,d=19008,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Shoulderpads
	[10190]={b=33349,s=6669,d=19001,c=AUCT_CLAS_ARMOR},  -- Swashbuckler's Belt
	[10191]={b=38887,s=7777,d=26155,c=AUCT_CLAS_ARMOR},  -- Crusader's Armguards
	[10192]={b=66060,s=13212,d=26160,c=AUCT_CLAS_ARMOR},  -- Crusader's Boots
	[10193]={b=98879,s=19775,d=26156,c=AUCT_CLAS_ARMOR},  -- Crusader's Armor
	[10194]={b=36728,s=7345,d=26173,c=AUCT_CLAS_ARMOR},  -- Crusader's Cloak
	[10195]={b=96107,s=19221,d=26176,c=AUCT_CLAS_WEAPON},  -- Crusader's Shield
	[10196]={b=37967,s=7593,d=26162,c=AUCT_CLAS_ARMOR},  -- Crusader's Gauntlets
	[10197]={b=38115,s=7623,d=26158,c=AUCT_CLAS_ARMOR},  -- Crusader's Belt
	[10198]={b=60837,s=12167,d=26172,c=AUCT_CLAS_ARMOR},  -- Crusader's Helm
	[10199]={b=86305,s=17261,d=26163,c=AUCT_CLAS_ARMOR},  -- Crusader's Leggings
	[10200]={b=61571,s=12314,d=26164,c=AUCT_CLAS_ARMOR},  -- Crusader's Pauldrons
	[10201]={b=29801,s=5960,d=27400,c=AUCT_CLAS_ARMOR},  -- Overlord's Greaves
	[10202]={b=19943,s=3988,d=27402,c=AUCT_CLAS_ARMOR},  -- Overlord's Vambraces
	[10203]={b=51986,s=10397,d=27397,c=AUCT_CLAS_ARMOR},  -- Overlord's Chestplate
	[10204]={b=99441,s=19888,d=27388,c=AUCT_CLAS_WEAPON},  -- Heavy Lamellar Shield
	[10205]={b=21580,s=4316,d=27398,c=AUCT_CLAS_ARMOR},  -- Overlord's Gauntlets
	[10206]={b=20243,s=4048,d=27399,c=AUCT_CLAS_ARMOR},  -- Overlord's Girdle
	[10207]={b=33477,s=6695,d=27404,c=AUCT_CLAS_ARMOR},  -- Overlord's Crown
	[10208]={b=47933,s=9586,d=27401,c=AUCT_CLAS_ARMOR},  -- Overlord's Legplates
	[10209]={b=36080,s=7216,d=27403,c=AUCT_CLAS_ARMOR},  -- Overlord's Spaulders
	[10210]={b=64228,s=12845,d=27867,c=AUCT_CLAS_ARMOR},  -- Elegant Mantle
	[10211]={b=61383,s=12276,d=24291,c=AUCT_CLAS_ARMOR},  -- Elegant Boots
	[10212]={b=55348,s=11069,d=15214,c=AUCT_CLAS_ARMOR},  -- Elegant Cloak
	[10213]={b=39251,s=7850,d=27870,c=AUCT_CLAS_ARMOR},  -- Elegant Bracers
	[10214]={b=41356,s=8271,d=27868,c=AUCT_CLAS_ARMOR},  -- Elegant Gloves
	[10215]={b=86939,s=17387,d=28992,c=AUCT_CLAS_ARMOR},  -- Elegant Robes
	[10216]={b=35901,s=7180,d=27842,c=AUCT_CLAS_ARMOR},  -- Elegant Belt
	[10217]={b=83444,s=16688,d=25198,c=AUCT_CLAS_ARMOR},  -- Elegant Leggings
	[10218]={b=87945,s=17589,d=27866,c=AUCT_CLAS_ARMOR},  -- Elegant Tunic
	[10219]={b=60056,s=12011,d=28851,c=AUCT_CLAS_ARMOR},  -- Elegant Circlet
	[10220]={b=116316,s=23263,d=18977,c=AUCT_CLAS_ARMOR},  -- Nightshade Tunic
	[10221]={b=45742,s=9148,d=18980,c=AUCT_CLAS_ARMOR},  -- Nightshade Girdle
	[10222]={b=72310,s=14462,d=18979,c=AUCT_CLAS_ARMOR},  -- Nightshade Boots
	[10223]={b=47330,s=9466,d=18978,c=AUCT_CLAS_ARMOR},  -- Nightshade Armguards
	[10224]={b=53778,s=10755,d=23048,c=AUCT_CLAS_ARMOR},  -- Nightshade Cloak
	[10225]={b=50062,s=10012,d=18981,c=AUCT_CLAS_ARMOR},  -- Nightshade Gloves
	[10226]={b=83084,s=16616,d=18985,c=AUCT_CLAS_ARMOR},  -- Nightshade Helmet
	[10227]={b=116741,s=23348,d=18982,c=AUCT_CLAS_ARMOR},  -- Nightshade Leggings
	[10228]={b=79702,s=15940,d=18983,c=AUCT_CLAS_ARMOR},  -- Nightshade Spaulders
	[10229]={b=51657,s=10331,d=26265,c=AUCT_CLAS_ARMOR},  -- Engraved Bracers
	[10230]={b=128433,s=25686,d=26267,c=AUCT_CLAS_ARMOR},  -- Engraved Breastplate
	[10231]={b=49079,s=9815,d=26278,c=AUCT_CLAS_ARMOR},  -- Engraved Cape
	[10232]={b=58663,s=11732,d=26269,c=AUCT_CLAS_ARMOR},  -- Engraved Gauntlets
	[10233]={b=55534,s=11106,d=26270,c=AUCT_CLAS_ARMOR},  -- Engraved Girdle
	[10234]={b=89007,s=17801,d=26264,c=AUCT_CLAS_ARMOR},  -- Engraved Boots
	[10235]={b=84481,s=16896,d=26274,c=AUCT_CLAS_ARMOR},  -- Engraved Helm
	[10236]={b=113079,s=22615,d=26272,c=AUCT_CLAS_ARMOR},  -- Engraved Leggings
	[10237]={b=81436,s=16287,d=26273,c=AUCT_CLAS_ARMOR},  -- Engraved Pauldrons
	[10238]={b=38250,s=7650,d=27380,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Boots
	[10239]={b=24811,s=4962,d=27385,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Vambraces
	[10240]={b=62882,s=12576,d=27384,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Chestpiece
	[10241]={b=42125,s=8425,d=27387,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Helm
	[10242]={b=26592,s=5318,d=27381,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Gauntlets
	[10243]={b=25179,s=5035,d=27382,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Girdle
	[10244]={b=60199,s=12039,d=27383,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Leggings
	[10245]={b=42744,s=8548,d=27386,c=AUCT_CLAS_ARMOR},  -- Heavy Lamellar Pauldrons
	[10246]={b=107712,s=21542,d=27821,c=AUCT_CLAS_ARMOR},  -- Master's Vest
	[10247]={b=73539,s=14707,d=4272,c=AUCT_CLAS_ARMOR},  -- Master's Boots
	[10248]={b=46856,s=9371,d=16892,c=AUCT_CLAS_ARMOR},  -- Master's Bracers
	[10249]={b=67179,s=13435,d=26126,c=AUCT_CLAS_ARMOR},  -- Master's Cloak
	[10250]={b=74331,s=14866,d=27824,c=AUCT_CLAS_ARMOR},  -- Master's Hat
	[10251]={b=49731,s=9946,d=16642,c=AUCT_CLAS_ARMOR},  -- Master's Gloves
	[10252]={b=104799,s=20959,d=27822,c=AUCT_CLAS_ARMOR},  -- Master's Leggings
	[10253]={b=75123,s=15024,d=27823,c=AUCT_CLAS_ARMOR},  -- Master's Mantle
	[10254]={b=110823,s=22164,d=28479,c=AUCT_CLAS_ARMOR},  -- Master's Robe
	[10255]={b=44671,s=8934,d=27830,c=AUCT_CLAS_ARMOR},  -- Master's Belt
	[10256]={b=53376,s=10675,d=27847,c=AUCT_CLAS_ARMOR},  -- Adventurer's Bracers
	[10257]={b=84385,s=16877,d=27844,c=AUCT_CLAS_ARMOR},  -- Adventurer's Boots
	[10258]={b=61461,s=12292,d=27850,c=AUCT_CLAS_ARMOR},  -- Adventurer's Cape
	[10259]={b=56679,s=11335,d=27846,c=AUCT_CLAS_ARMOR},  -- Adventurer's Belt
	[10260]={b=59729,s=11945,d=27845,c=AUCT_CLAS_ARMOR},  -- Adventurer's Gloves
	[10261]={b=89927,s=17985,d=29051,c=AUCT_CLAS_ARMOR},  -- Adventurer's Bandana
	[10262]={b=126364,s=25272,d=27843,c=AUCT_CLAS_ARMOR},  -- Adventurer's Legguards
	[10263]={b=90583,s=18116,d=27849,c=AUCT_CLAS_ARMOR},  -- Adventurer's Shoulders
	[10264]={b=133648,s=26729,d=8664,c=AUCT_CLAS_ARMOR},  -- Adventurer's Tunic
	[10265]={b=69523,s=13904,d=26239,c=AUCT_CLAS_ARMOR},  -- Masterwork Bracers
	[10266]={b=161552,s=32310,d=26241,c=AUCT_CLAS_ARMOR},  -- Masterwork Breastplate
	[10267]={b=66689,s=13337,d=26259,c=AUCT_CLAS_ARMOR},  -- Masterwork Cape
	[10268]={b=73791,s=14758,d=26244,c=AUCT_CLAS_ARMOR},  -- Masterwork Gauntlets
	[10269]={b=70531,s=14106,d=26245,c=AUCT_CLAS_ARMOR},  -- Masterwork Girdle
	[10270]={b=111982,s=22396,d=26237,c=AUCT_CLAS_ARMOR},  -- Masterwork Boots
	[10271]={b=162960,s=32592,d=27806,c=AUCT_CLAS_WEAPON},  -- Masterwork Shield
	[10272]={b=104328,s=20865,d=27804,c=AUCT_CLAS_ARMOR},  -- Masterwork Circlet
	[10273]={b=146619,s=29323,d=26248,c=AUCT_CLAS_ARMOR},  -- Masterwork Legplates
	[10274]={b=105594,s=21118,d=27805,c=AUCT_CLAS_ARMOR},  -- Masterwork Pauldrons
	[10275]={b=81021,s=16204,d=27416,c=AUCT_CLAS_ARMOR},  -- Emerald Breastplate
	[10276]={b=49238,s=9847,d=27419,c=AUCT_CLAS_ARMOR},  -- Emerald Sabatons
	[10277]={b=34926,s=6985,d=29003,c=AUCT_CLAS_ARMOR},  -- Emerald Gauntlets
	[10278]={b=31197,s=6239,d=27418,c=AUCT_CLAS_ARMOR},  -- Emerald Girdle
	[10279]={b=55944,s=11188,d=27423,c=AUCT_CLAS_ARMOR},  -- Emerald Helm
	[10280]={b=78615,s=15723,d=13206,c=AUCT_CLAS_ARMOR},  -- Emerald Legplates
	[10281]={b=56362,s=11272,d=27422,c=AUCT_CLAS_ARMOR},  -- Emerald Pauldrons
	[10282]={b=33561,s=6712,d=27420,c=AUCT_CLAS_ARMOR},  -- Emerald Vambraces
	[10283]={b=0,s=0,d=7357},  -- Wolf Heart Samples
	[10285]={b=4000,s=1000,d=18597,x=10,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_TAILOR},  -- Shadow Silk
	[10286]={b=1600,s=400,d=18953,x=10,u=AUCT_TYPE_TAILOR},  -- Heart of the Wild
	[10287]={b=4822,s=964,d=16470,c=AUCT_CLAS_ARMOR},  -- Greenweave Mantle
	[10288]={b=7052,s=1410,d=18976,c=AUCT_CLAS_ARMOR},  -- Sage's Circlet
	[10289]={b=7787,s=1557,d=27862,c=AUCT_CLAS_ARMOR},  -- Durable Hat
	[10290]={b=2500,s=625,d=983,x=10,u=AUCT_TYPE_TAILOR},  -- Pink Dye
	[10298]={b=4975,s=1243,d=9832,c=AUCT_CLAS_ARMOR},  -- Gnomeregan Band
	[10299]={b=15112,s=3778,d=9853,c=AUCT_CLAS_ARMOR},  -- Gnomeregan Amulet
	[10300]={b=5000,s=1250,d=15274},  -- Pattern: Red Mageweave Vest
	[10301]={b=5000,s=1250,d=15274},  -- Pattern: White Bandit Mask
	[10302]={b=5000,s=1250,d=15274},  -- Pattern: Red Mageweave Pants
	[10305]={b=550,s=100,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Protection IV
	[10306]={b=550,s=100,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Spirit IV
	[10307]={b=600,s=112,d=1093,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Stamina IV
	[10308]={b=600,s=112,d=2616,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Intellect IV
	[10309]={b=650,s=125,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Agility IV
	[10310]={b=650,s=125,d=3331,x=5,c=AUCT_CLAS_POTION},  -- Scroll of Strength IV
	[10311]={b=3000,s=750,d=1102},  -- Pattern: Orange Martial Shirt
	[10312]={b=6000,s=1500,d=15274},  -- Pattern: Red Mageweave Gloves
	[10314]={b=4000,s=1000,d=1102},  -- Pattern: Lavender Mageweave Shirt
	[10315]={b=7000,s=1750,d=15274},  -- Pattern: Red Mageweave Shoulders
	[10316]={b=800,s=200,d=15274},  -- Pattern: Colorful Kilt
	[10317]={b=4000,s=1000,d=1102},  -- Pattern: Pink Mageweave Shirt
	[10318]={b=7000,s=1750,d=1102},  -- Pattern: Admiral's Hat
	[10320]={b=7000,s=1750,d=15274},  -- Pattern: Red Mageweave Headband
	[10321]={b=4500,s=1125,d=1102},  -- Pattern: Tuxedo Shirt
	[10323]={b=4500,s=1125,d=1102},  -- Pattern: Tuxedo Pants
	[10325]={b=10000,s=2500,d=1102},  -- Pattern: White Wedding Dress
	[10326]={b=5000,s=1250,d=1102},  -- Pattern: Tuxedo Jacket
	[10327]={b=0,s=0,d=13121},  -- Horn of Echeyakee
	[10328]={b=34964,s=6992,d=19049,c=AUCT_CLAS_ARMOR},  -- Scarlet Chestpiece
	[10329]={b=12538,s=2507,d=27951,c=AUCT_CLAS_ARMOR},  -- Scarlet Belt
	[10330]={b=47938,s=9587,d=3519,c=AUCT_CLAS_ARMOR},  -- Scarlet Leggings
	[10331]={b=13644,s=2728,d=15816,c=AUCT_CLAS_ARMOR},  -- Scarlet Gauntlets
	[10332]={b=18950,s=3790,d=28383,c=AUCT_CLAS_ARMOR},  -- Scarlet Boots
	[10333]={b=11574,s=2314,d=28382,c=AUCT_CLAS_ARMOR},  -- Scarlet Wristguards
	[10338]={b=0,s=0,d=8942},  -- Fresh Zhevra Carcass
	[10358]={b=12107,s=2421,d=28156,c=AUCT_CLAS_ARMOR},  -- Duracin Bracers
	[10359]={b=12151,s=2430,d=19917,c=AUCT_CLAS_ARMOR},  -- Everlast Boots
	[10360]={b=5000,s=1250,d=19089},  -- Black Kingsnake
	[10361]={b=5000,s=1250,d=19089},  -- Brown Snake
	[10362]={b=123802,s=24760,d=20910,c=AUCT_CLAS_WEAPON},  -- Ornate Shield
	[10363]={b=136982,s=27396,d=26283,c=AUCT_CLAS_WEAPON},  -- Engraved Wall
	[10364]={b=124692,s=24938,d=27415,c=AUCT_CLAS_WEAPON},  -- Templar Shield
	[10365]={b=131381,s=26276,d=27803,c=AUCT_CLAS_WEAPON},  -- Emerald Shield
	[10366]={b=160263,s=32052,d=20831,c=AUCT_CLAS_WEAPON},  -- Demon Guard
	[10367]={b=164856,s=32971,d=20971,c=AUCT_CLAS_WEAPON},  -- Hyperion Shield
	[10368]={b=89343,s=17868,d=26351,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Armor
	[10369]={b=36886,s=7377,d=26352,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Gauntlets
	[10370]={b=34929,s=6985,d=26353,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Girdle
	[10371]={b=55747,s=11149,d=26354,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Greaves
	[10372]={b=58754,s=11750,d=26365,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Helmet
	[10373]={b=86682,s=17336,d=26355,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Leggings
	[10374]={b=59186,s=11837,d=26364,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Pauldrons
	[10375]={b=35582,s=7116,d=26363,c=AUCT_CLAS_ARMOR},  -- Imbued Plate Vambraces
	[10376]={b=62599,s=12519,d=26333,c=AUCT_CLAS_ARMOR},  -- Commander's Boots
	[10377]={b=39891,s=7978,d=26362,c=AUCT_CLAS_ARMOR},  -- Commander's Vambraces
	[10378]={b=97332,s=19466,d=26332,c=AUCT_CLAS_ARMOR},  -- Commander's Armor
	[10379]={b=66454,s=13290,d=27749,c=AUCT_CLAS_ARMOR},  -- Commander's Helm
	[10380]={b=42342,s=8468,d=26334,c=AUCT_CLAS_ARMOR},  -- Commander's Gauntlets
	[10381]={b=40471,s=8094,d=26335,c=AUCT_CLAS_ARMOR},  -- Commander's Girdle
	[10382]={b=94041,s=18808,d=26336,c=AUCT_CLAS_ARMOR},  -- Commander's Leggings
	[10383]={b=62609,s=12521,d=26337,c=AUCT_CLAS_ARMOR},  -- Commander's Pauldrons
	[10384]={b=101850,s=20370,d=19844,c=AUCT_CLAS_ARMOR},  -- Hyperion Armor
	[10385]={b=66239,s=13247,d=26341,c=AUCT_CLAS_ARMOR},  -- Hyperion Greaves
	[10386]={b=44329,s=8865,d=26339,c=AUCT_CLAS_ARMOR},  -- Hyperion Gauntlets
	[10387]={b=42379,s=8475,d=26340,c=AUCT_CLAS_ARMOR},  -- Hyperion Girdle
	[10388]={b=70344,s=14068,d=26257,c=AUCT_CLAS_ARMOR},  -- Hyperion Helm
	[10389]={b=98854,s=19770,d=19843,c=AUCT_CLAS_ARMOR},  -- Hyperion Legplates
	[10390]={b=70876,s=14175,d=26342,c=AUCT_CLAS_ARMOR},  -- Hyperion Pauldrons
	[10391]={b=40966,s=8193,d=26360,c=AUCT_CLAS_ARMOR},  -- Hyperion Vambraces
	[10392]={b=5000,s=1250,d=19089},  -- Crimson Snake
	[10393]={b=5000,s=1250,d=19092},  -- Cockroach
	[10394]={b=5000,s=1250,d=15798},  -- Prairie Dog Whistle
	[10398]={b=4000,s=1000,d=19115},  -- Mechanical Chicken
	[10399]={b=7335,s=1467,d=9123,c=AUCT_CLAS_ARMOR},  -- Blackened Defias Armor
	[10400]={b=2817,s=563,d=27947,c=AUCT_CLAS_ARMOR},  -- Blackened Defias Leggings
	[10401]={b=1278,s=255,d=27946,c=AUCT_CLAS_ARMOR},  -- Blackened Defias Gloves
	[10402]={b=1926,s=385,d=21903,c=AUCT_CLAS_ARMOR},  -- Blackened Defias Boots
	[10403]={b=2255,s=451,d=14389,c=AUCT_CLAS_ARMOR},  -- Blackened Defias Belt
	[10404]={b=4323,s=864,d=27854,c=AUCT_CLAS_ARMOR},  -- Durable Belt
	[10405]={b=2045,s=409,d=17195,c=AUCT_CLAS_ARMOR},  -- Bandit Shoulders
	[10406]={b=9884,s=1976,d=28173,c=AUCT_CLAS_ARMOR},  -- Scaled Leather Headband
	[10407]={b=2159,s=431,d=25777,c=AUCT_CLAS_ARMOR},  -- Raider's Shoulderpads
	[10408]={b=11951,s=2390,d=27774,c=AUCT_CLAS_ARMOR},  -- Banded Helm
	[10409]={b=12049,s=2409,d=27771,c=AUCT_CLAS_ARMOR},  -- Banded Boots
	[10410]={b=6280,s=1256,d=28385,c=AUCT_CLAS_ARMOR},  -- Leggings of the Fang
	[10411]={b=3939,s=787,d=27949,c=AUCT_CLAS_ARMOR},  -- Footpads of the Fang
	[10412]={b=2028,s=405,d=28384,c=AUCT_CLAS_ARMOR},  -- Belt of the Fang
	[10413]={b=1539,s=307,d=19125,c=AUCT_CLAS_ARMOR},  -- Gloves of the Fang
	[10414]={b=0,s=0,d=17460},  -- Sample Snapjaw Shell
	[10418]={b=65859,s=16464,d=19149,c=AUCT_CLAS_ARMOR},  -- Glimmering Mithril Insignia
	[10420]={b=0,s=0,d=2853},  -- Skull of the Coldbringer
	[10421]={b=161,s=32,d=977,c=AUCT_CLAS_ARMOR},  -- Rough Copper Vest
	[10423]={b=14211,s=2842,d=19201,c=AUCT_CLAS_ARMOR},  -- Silvered Bronze Leggings
	[10424]={b=3000,s=750,d=15274},  -- Plans: Silvered Bronze Leggings
	[10438]={b=0,s=0,d=12331},  -- Felix's Box
	[10439]={b=0,s=0,d=19222},  -- Durnan's Scalding Mornbrew
	[10440]={b=0,s=0,d=19222},  -- Nori's Mug
	[10441]={b=0,s=0,d=19223,c=AUCT_CLAS_QUEST},  -- Glowing Shard
	[10442]={b=0,s=0,d=7148},  -- Mysterious Artifact
	[10443]={b=0,s=0,d=3093},  -- Singed Letter
	[10444]={b=0,s=0,d=19225},  -- Standard Issue Flare Gun
	[10445]={b=0,s=0,d=12925},  -- Drawing Kit
	[10446]={b=0,s=0,d=19239},  -- Heart of Obsidion
	[10447]={b=0,s=0,d=3920},  -- Head of Lathoric the Black
	[10450]={b=1585,s=396,d=19530,x=20},  -- Undamaged Hippogryph Feather
	[10454]={b=0,s=0,d=6513,c=AUCT_CLAS_QUEST},  -- Essence of Eranikus
	[10455]={b=25859,s=6464,d=6513,c=AUCT_CLAS_ARMOR},  -- Chained Essence of Eranikus
	[10456]={b=0,s=0,d=2588},  -- A Bulging Coin Purse
	[10457]={b=570,s=142,d=19284,x=5},  -- Empty Sea Snail Shell
	[10458]={b=0,s=0,d=7697},  -- Prayer to Elune
	[10459]={b=0,s=0,d=10377},  -- Chief Sharptusk Thornmantle's Head
	[10460]={b=2518,s=629,d=19312},  -- Hakkar'i Blood
	[10461]={b=15410,s=3082,d=19314,c=AUCT_CLAS_ARMOR},  -- Shadowy Bracers
	[10462]={b=18044,s=3608,d=19313,c=AUCT_CLAS_ARMOR},  -- Shadowy Belt
	[10463]={b=7000,s=1750,d=15274},  -- Pattern: Shadoweave Mask
	[10464]={b=0,s=0,d=19315},  -- Staff of Command
	[10465]={b=0,s=0,d=18050},  -- Egg of Hakkar
	[10466]={b=0,s=0,d=19316},  -- Atal'ai Stone Circle
	[10467]={b=0,s=0,d=1283},  -- Trader's Satchel
	[10479]={b=48,s=24,d=1283},  -- Kovic's Trading Satchel
	[10498]={b=81,s=16,d=19394},  -- Gyromatic Micro-Adjustor
	[10499]={b=10526,s=2105,d=19397,c=AUCT_CLAS_ARMOR},  -- Bright-Eye Goggles
	[10500]={b=17394,s=3478,d=19399,c=AUCT_CLAS_ARMOR,u=AUCT_TYPE_ENGINEER},  -- Fire Goggles
	[10501]={b=21993,s=4398,d=19402,c=AUCT_CLAS_ARMOR},  -- Catseye Ultra Goggles
	[10502]={b=20441,s=4088,d=19409,c=AUCT_CLAS_ARMOR},  -- Spellpower Goggles Xtreme
	[10503]={b=25847,s=5169,d=22423,c=AUCT_CLAS_ARMOR},  -- Rose Colored Goggles
	[10504]={b=38852,s=7770,d=19563,c=AUCT_CLAS_ARMOR},  -- Green Lens
	[10505]={b=1000,s=250,d=6412,x=20,u=AUCT_TYPE_ENGINEER},  -- Solid Blasting Powder
	[10506]={b=26136,s=5227,d=23161,c=AUCT_CLAS_ARMOR},  -- Deepdive Helmet
	[10507]={b=1400,s=350,d=18062,x=20},  -- Solid Dynamite
	[10508]={b=44794,s=8958,d=18298,c=AUCT_CLAS_WEAPON},  -- Mithril Blunderbuss
	[10509]={b=0,s=0,d=7050,q=4,x=4},  -- Heart of Flame
	[10510]={b=56845,s=11369,d=20744,c=AUCT_CLAS_WEAPON},  -- Mithril Heavy-bore Rifle
	[10511]={b=0,s=0,d=19421,q=4,x=4,c=AUCT_CLAS_POTION},  -- Golem Oil
	[10512]={b=1000,s=2,d=19422,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Hi-Impact Mithril Slugs
	[10513]={b=2000,s=5,d=19422,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Mithril Gyro-Shot
	[10514]={b=3000,s=750,d=7889,x=10},  -- Mithril Frag Bomb
	[10515]={b=0,s=0,d=19461,c=AUCT_CLAS_WEAPON},  -- Torch of Retribution
	[10518]={b=23482,s=4696,d=23129,c=AUCT_CLAS_ARMOR},  -- Parachute Cloak
	[10538]={b=0,s=0,d=18203},  -- Tablet of Beth'Amara
	[10539]={b=0,s=0,d=19830},  -- Tablet of Jin'yael
	[10540]={b=0,s=0,d=19831},  -- Tablet of Markri
	[10541]={b=0,s=0,d=19832},  -- Tablet of Sael'hai
	[10542]={b=26279,s=5255,d=20813,c=AUCT_CLAS_ARMOR},  -- Goblin Mining Helmet
	[10543]={b=17585,s=3517,d=20814,c=AUCT_CLAS_ARMOR},  -- Goblin Construction Helmet
	[10544]={b=127,s=25,d=19782,c=AUCT_CLAS_WEAPON},  -- Thistlewood Maul
	[10545]={b=19646,s=3929,d=22420,c=AUCT_CLAS_ARMOR},  -- Gnomish Goggles
	[10546]={b=6000,s=1500,d=7326,x=5},  -- Deadly Scope
	[10547]={b=408,s=81,d=6472,c=AUCT_CLAS_WEAPON},  -- Camping Knife
	[10548]={b=10000,s=2500,d=7326,x=5},  -- Sniper Scope
	[10549]={b=811,s=162,d=19951,c=AUCT_CLAS_ARMOR},  -- Rancher's Trousers
	[10550]={b=243,s=48,d=19994,c=AUCT_CLAS_ARMOR},  -- Wooly Mittens
	[10551]={b=0,s=0,d=19459,q=10,x=10},  -- Thorium Plated Dagger
	[10552]={b=0,s=0,d=19462},  -- Symbol of Ragnaros
	[10553]={b=657,s=131,d=19919,c=AUCT_CLAS_ARMOR},  -- Foreman Vest
	[10554]={b=597,s=119,d=19918,c=AUCT_CLAS_ARMOR},  -- Foreman Pants
	[10556]={b=0,s=0,d=19316},  -- Stone Circle
	[10558]={b=1000,s=250,d=19477,x=20,u=AUCT_TYPE_ENGINEER},  -- Gold Power Core
	[10559]={b=3000,s=750,d=19487,x=10,u=AUCT_TYPE_ENGINEER},  -- Mithril Tube
	[10560]={b=4000,s=1000,d=19479,x=10,u=AUCT_TYPE_ENGINEER},  -- Unstable Trigger
	[10561]={b=4000,s=1000,d=20620,x=10,u=AUCT_TYPE_ENGINEER},  -- Mithril Casing
	[10562]={b=3000,s=750,d=25484,x=10},  -- Hi-Explosive Bomb
	[10563]={b=0,s=0,d=7629},  -- Rubbing: Rune of Beth'Amara
	[10564]={b=0,s=0,d=7629},  -- Rubbing: Rune of Jin'yael
	[10565]={b=0,s=0,d=7629},  -- Rubbing: Rune of Markri
	[10566]={b=0,s=0,d=7629},  -- Rubbing: Rune of Sael'hai
	[10567]={b=43628,s=8725,d=20649,c=AUCT_CLAS_WEAPON},  -- Quillshooter
	[10569]={b=0,s=0,d=14006},  -- Hoard of the Black Dragonflight
	[10570]={b=79375,s=15875,d=28796,c=AUCT_CLAS_WEAPON},  -- Manslayer
	[10571]={b=54635,s=10927,d=19501,c=AUCT_CLAS_WEAPON},  -- Ebony Boneclub
	[10572]={b=47960,s=9592,d=28747,c=AUCT_CLAS_WEAPON},  -- Freezing Shard
	[10573]={b=68773,s=13754,d=20149,c=AUCT_CLAS_WEAPON},  -- Boneslasher
	[10574]={b=18878,s=3775,d=19903,c=AUCT_CLAS_ARMOR},  -- Corpseshroud
	[10575]={b=0,s=0,d=19502,q=10,x=10},  -- Black Dragonflight Molt
	[10576]={b=24000,s=6000,d=21632,c=AUCT_CLAS_ARMOR},  -- Mithril Mechanical Dragonling
	[10577]={b=8000,s=2000,d=7397,c=AUCT_CLAS_ARMOR},  -- Goblin Mortar
	[10578]={b=16885,s=3377,d=19993,c=AUCT_CLAS_ARMOR},  -- Thoughtcast Boots
	[10581]={b=26553,s=5310,d=19506,c=AUCT_CLAS_ARMOR},  -- Death's Head Vestment
	[10582]={b=18031,s=3606,d=28654,c=AUCT_CLAS_ARMOR},  -- Briar Tredders
	[10583]={b=30956,s=6191,d=28808,c=AUCT_CLAS_ARMOR},  -- Quillward Harness
	[10584]={b=14528,s=2905,d=28685,c=AUCT_CLAS_ARMOR},  -- Stormgale Fists
	[10586]={b=3000,s=750,d=7888,x=10},  -- The Big One
	[10587]={b=6000,s=1500,d=20627,c=AUCT_CLAS_ARMOR},  -- Goblin Bomb Dispenser
	[10588]={b=29171,s=5834,d=23166,c=AUCT_CLAS_ARMOR},  -- Goblin Rocket Helmet
	[10589]={b=0,s=0,d=20220,c=AUCT_CLAS_QUEST},  -- Oathstone of Ysera's Dragonflight
	[10590]={b=0,s=0,d=7074,c=AUCT_CLAS_QUEST},  -- Pocked Black Box
	[10592]={b=600,s=150,d=19520,x=5,u=AUCT_TYPE_ENGINEER},  -- Catseye Elixir
	[10593]={b=0,s=0,d=6673,q=20,x=20},  -- Imperfect Draenethyst Fragment
	[10597]={b=0,s=0,d=15706},  -- Head of Magus Rimtori
	[10598]={b=0,s=0,d=7135},  -- Hetaera's Bloodied Head
	[10599]={b=0,s=0,d=11932},  -- Hetaera's Beaten Head
	[10600]={b=0,s=0,d=9150},  -- Hetaera's Bruised Head
	[10601]={b=2000,s=500,d=15274},  -- Schematic: Bright-Eye Goggles
	[10602]={b=3000,s=750,d=1102},  -- Schematic: Deadly Scope
	[10603]={b=3300,s=825,d=15274},  -- Schematic: Catseye Ultra Goggles
	[10604]={b=3300,s=825,d=15274},  -- Schematic: Mithril Heavy-bore Rifle
	[10605]={b=3500,s=875,d=1102},  -- Schematic: Spellpower Goggles Xtreme
	[10606]={b=3500,s=875,d=15274},  -- Schematic: Parachute Cloak
	[10607]={b=3600,s=900,d=1102},  -- Schematic: Deepdive Helmet
	[10608]={b=3800,s=950,d=1102},  -- Schematic: Sniper Scope
	[10609]={b=4000,s=1000,d=1102},  -- Schematic: Mithril Mechanical Dragonling
	[10610]={b=0,s=0,d=19547},  -- Hetaera's Blood
	[10620]={b=1000,s=250,d=20658,x=10,c=AUCT_CLAS_ORE,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_MINING},  -- Thorium Ore
	[10621]={b=0,s=0,d=1301,c=AUCT_CLAS_QUEST},  -- Runed Scroll
	[10622]={b=0,s=0,d=19562},  -- Kadrak's Flag
	[10623]={b=123740,s=24748,d=18391,c=AUCT_CLAS_WEAPON},  -- Winter's Bite
	[10624]={b=86246,s=17249,d=25604,c=AUCT_CLAS_WEAPON},  -- Stinging Bow
	[10625]={b=136831,s=27366,d=20315,c=AUCT_CLAS_WEAPON},  -- Stealthblade
	[10626]={b=183661,s=36732,d=19617,c=AUCT_CLAS_WEAPON},  -- Ragehammer
	[10627]={b=134870,s=26974,d=20259,c=AUCT_CLAS_WEAPON},  -- Bludgeon of the Grinning Dog
	[10628]={b=146225,s=29245,d=20189,c=AUCT_CLAS_WEAPON},  -- Deathblow
	[10629]={b=40330,s=8066,d=19950,c=AUCT_CLAS_ARMOR},  -- Mistwalker Boots
	[10630]={b=43320,s=8664,d=22928,c=AUCT_CLAS_ARMOR},  -- Soulcatcher Halo
	[10631]={b=30433,s=6086,d=28800,c=AUCT_CLAS_ARMOR},  -- Murkwater Gauntlets
	[10632]={b=38124,s=7624,d=28711,c=AUCT_CLAS_ARMOR},  -- Slimescale Bracers
	[10633]={b=58420,s=11684,d=19900,c=AUCT_CLAS_ARMOR},  -- Silvershell Leggings
	[10634]={b=43250,s=10812,d=9832,c=AUCT_CLAS_ARMOR},  -- Mindseye Circle
	[10635]={b=73,s=14,d=28230,c=AUCT_CLAS_ARMOR},  -- Painted Chain Leggings
	[10636]={b=30,s=6,d=12415,c=AUCT_CLAS_ARMOR},  -- Nomadic Gloves
	[10637]={b=698,s=139,d=14152,c=AUCT_CLAS_ARMOR},  -- Brewer's Gloves
	[10638]={b=1052,s=210,d=28209,c=AUCT_CLAS_ARMOR},  -- Long Draping Cape
	[10639]={b=0,s=0,d=19566,q=20,x=20},  -- Hyacinth Mushroom
	[10640]={b=0,s=0,d=2885,q=20,x=20},  -- Webwood Ichor
	[10641]={b=0,s=0,d=18168,q=20,x=20},  -- Moonpetal Lily
	[10642]={b=0,s=0,d=17893},  -- Iverron's Antidote
	[10643]={b=0,s=0,d=3029},  -- Sealed Letter to Ag'tor
	[10644]={b=2000,s=500,d=1301,u=AUCT_TYPE_ENGINEER},  -- Recipe: Goblin Rocket Fuel
	[10645]={b=3000,s=750,d=20626,c=AUCT_CLAS_ARMOR},  -- Gnomish Death Ray
	[10646]={b=2000,s=500,d=20535,x=10},  -- Goblin Sapper Charge
	[10647]={b=2000,s=500,d=17883,x=10,u=AUCT_TYPE_ENGINEER},  -- Engineer's Ink
	[10648]={b=500,s=125,d=7744,x=10,u=AUCT_TYPE_ENGINEER},  -- Blank Parchment
	[10649]={b=0,s=0,d=19223},  -- Nightmare Shard
	[10652]={b=151543,s=30308,d=22213,c=AUCT_CLAS_WEAPON},  -- Will of the Mountain Giant
	[10653]={b=8197,s=1639,d=9174,c=AUCT_CLAS_ARMOR},  -- Trailblazer Boots
	[10654]={b=4827,s=965,d=19949,c=AUCT_CLAS_ARMOR},  -- Jutebraid Gloves
	[10655]={b=49,s=9,d=20210,c=AUCT_CLAS_ARMOR},  -- Sedgeweed Britches
	[10656]={b=73,s=14,d=28069,c=AUCT_CLAS_ARMOR},  -- Barkmail Vest
	[10657]={b=4669,s=933,d=19991,c=AUCT_CLAS_ARMOR},  -- Talbar Mantle
	[10658]={b=6248,s=1249,d=28238,c=AUCT_CLAS_ARMOR},  -- Quagmire Galoshes
	[10659]={b=18650,s=4662,d=2516,c=AUCT_CLAS_ARMOR},  -- Shard of Afrasa
	[10660]={b=0,s=0,d=22484},  -- First Mosh'aru Tablet
	[10661]={b=0,s=0,d=20220},  -- Second Mosh'aru Tablet
	[10662]={b=0,s=0,d=19527},  -- Filled Egg of Hakkar
	[10663]={b=0,s=0,d=19576},  -- Essence of Hakkar
	[10664]={b=0,s=0,d=7798},  -- A Note to Magus Rimtori
	[10678]={b=0,s=0,d=3024},  -- Magatha's Note
	[10679]={b=0,s=0,d=3024},  -- Andron's Note
	[10680]={b=0,s=0,d=3024},  -- Jes'rimon's Note
	[10681]={b=0,s=0,d=3024},  -- Xylem's Note
	[10682]={b=0,s=0,d=20219},  -- Belnistrasz's Oathstone
	[10684]={b=2000,s=500,d=19606},  -- Colossal Parachute
	[10686]={b=105815,s=21163,d=20820,c=AUCT_CLAS_WEAPON},  -- Aegis of Battle
	[10687]={b=0,s=0,d=18077},  -- Empty Vial Labeled #1
	[10688]={b=0,s=0,d=18077},  -- Empty Vial Labeled #2
	[10689]={b=0,s=0,d=18077},  -- Empty Vial Labeled #3
	[10690]={b=0,s=0,d=18077},  -- Empty Vial Labeled #4
	[10691]={b=0,s=0,d=15736},  -- Filled Vial Labeled #1
	[10692]={b=0,s=0,d=15737},  -- Filled Vial Labeled #2
	[10693]={b=0,s=0,d=15733},  -- Filled Vial Labeled #3
	[10694]={b=0,s=0,d=15734},  -- Filled Vial Labeled #4
	[10695]={b=0,s=0,d=12925},  -- Box of Empty Vials
	[10696]={b=209454,s=41890,d=22229,c=AUCT_CLAS_WEAPON},  -- Enchanted Azsharite Felbane Sword
	[10697]={b=210221,s=42044,d=20570,c=AUCT_CLAS_WEAPON},  -- Enchanted Azsharite Felbane Dagger
	[10698]={b=263735,s=52747,d=20275,c=AUCT_CLAS_WEAPON},  -- Enchanted Azsharite Felbane Staff
	[10699]={b=0,s=0,d=12866},  -- Yeh'kinya's Bramble
	[10700]={b=24918,s=4983,d=18832,c=AUCT_CLAS_ARMOR},  -- Encarmine Boots
	[10701]={b=37680,s=7536,d=28263,c=AUCT_CLAS_ARMOR},  -- Boots of Zua'tec
	[10702]={b=26897,s=5379,d=28273,c=AUCT_CLAS_ARMOR},  -- Enormous Ogre Boots
	[10703]={b=83963,s=16792,d=20297,c=AUCT_CLAS_WEAPON},  -- Fiendish Skiv
	[10704]={b=68246,s=13649,d=28267,c=AUCT_CLAS_WEAPON},  -- Chillnail Splinter
	[10705]={b=18333,s=3666,d=19915,c=AUCT_CLAS_ARMOR},  -- Firwillow Wristbands
	[10706]={b=27606,s=5521,d=28336,c=AUCT_CLAS_ARMOR},  -- Nightscale Girdle
	[10707]={b=38862,s=7772,d=19742,c=AUCT_CLAS_ARMOR},  -- Steelsmith Greaves
	[10708]={b=35930,s=8982,d=19786,c=AUCT_CLAS_WEAPON},  -- Skullspell Orb
	[10709]={b=43814,s=10953,d=28291,c=AUCT_CLAS_WEAPON},  -- Pyrestone Orb
	[10710]={b=24520,s=6130,d=9834,c=AUCT_CLAS_ARMOR},  -- Dragonclaw Ring
	[10711]={b=33510,s=8377,d=9854,c=AUCT_CLAS_ARMOR},  -- Dragon's Blood Necklace
	[10712]={b=0,s=0,d=2533,c=AUCT_CLAS_POTION},  -- Cuely's Elixir
	[10713]={b=2000,s=500,d=6270,u=AUCT_TYPE_ENGINEER},  -- Plans: Inlaid Mithril Cylinder
	[10714]={b=0,s=0,d=13496,q=20,x=20},  -- Crystallized Azsharite
	[10715]={b=0,s=0,d=18155},  -- Kim'Jael's Scope
	[10716]={b=3000,s=750,d=20625,c=AUCT_CLAS_ARMOR},  -- Gnomish Shrink Ray
	[10717]={b=0,s=0,d=19658},  -- Kim'Jael's Compass
	[10718]={b=0,s=0,d=7842},  -- Kim'Jael's Wizzlegoober
	[10720]={b=3000,s=750,d=19662,c=AUCT_CLAS_ARMOR},  -- Gnomish Net-o-Matic Projector
	[10721]={b=16587,s=3317,d=14832,c=AUCT_CLAS_ARMOR},  -- Gnomish Harm Prevention Belt
	[10722]={b=0,s=0,d=19663},  -- Kim'Jael's Stuffed Chicken
	[10724]={b=23484,s=4696,d=19665,c=AUCT_CLAS_ARMOR},  -- Gnomish Rocket Boots
	[10725]={b=6000,s=1500,d=19666,c=AUCT_CLAS_ARMOR},  -- Gnomish Battle Chicken
	[10726]={b=27603,s=5520,d=19667,c=AUCT_CLAS_ARMOR},  -- Gnomish Mind Control Cap
	[10727]={b=8000,s=2000,d=20539,c=AUCT_CLAS_ARMOR},  -- Goblin Dragon Gun
	[10728]={b=1500,s=375,d=1102},  -- Pattern: Black Swashbuckler's Shirt
	[10738]={b=0,s=0,d=11448},  -- Shipment to Galvan
	[10739]={b=21170,s=5292,d=15422,c=AUCT_CLAS_ARMOR},  -- Ring of Fortitude
	[10740]={b=53464,s=10692,d=28310,c=AUCT_CLAS_ARMOR},  -- Centurion Legplates
	[10741]={b=50318,s=10063,d=28212,c=AUCT_CLAS_ARMOR},  -- Lordrec Helmet
	[10742]={b=47948,s=9589,d=19710,c=AUCT_CLAS_ARMOR},  -- Dragonflight Leggings
	[10743]={b=54150,s=10830,d=28143,c=AUCT_CLAS_ARMOR},  -- Drakefire Headguard
	[10744]={b=120797,s=24159,d=19130,c=AUCT_CLAS_WEAPON},  -- Axe of the Ebon Drake
	[10745]={b=42492,s=8498,d=28330,c=AUCT_CLAS_ARMOR},  -- Kaylari Shoulders
	[10746]={b=22748,s=4549,d=28343,c=AUCT_CLAS_ARMOR},  -- Runesteel Vambraces
	[10747]={b=11637,s=2327,d=19992,c=AUCT_CLAS_ARMOR},  -- Teacher's Sash
	[10748]={b=21903,s=4380,d=4385,c=AUCT_CLAS_ARMOR},  -- Wanderlust Boots
	[10749]={b=52774,s=10554,d=19728,c=AUCT_CLAS_ARMOR},  -- Avenguard Helm
	[10750]={b=176577,s=35315,d=20569,c=AUCT_CLAS_WEAPON},  -- Lifeforce Dirk
	[10751]={b=53170,s=10634,d=19920,c=AUCT_CLAS_ARMOR},  -- Gemburst Circlet
	[10752]={b=0,s=0,d=19745},  -- Emerald Encrusted Chest
	[10753]={b=0,s=0,d=19762},  -- Amulet of Grol
	[10754]={b=0,s=0,d=19763},  -- Amulet of Sevine
	[10755]={b=0,s=0,d=19764},  -- Amulet of Allistarj
	[10757]={b=0,s=0,d=19767},  -- Ward of the Defiler
	[10758]={b=100723,s=20144,d=19779,c=AUCT_CLAS_WEAPON},  -- X'caliboar
	[10759]={b=0,s=0,d=13122},  -- Severed Horn of the Defiler
	[10760]={b=12141,s=2428,d=28683,c=AUCT_CLAS_ARMOR},  -- Swine Fists
	[10761]={b=85966,s=17193,d=20572,c=AUCT_CLAS_WEAPON},  -- Coldrage Dagger
	[10762]={b=34519,s=6903,d=19953,c=AUCT_CLAS_ARMOR},  -- Robes of the Lich
	[10763]={b=25989,s=5197,d=28783,c=AUCT_CLAS_ARMOR},  -- Icemetal Barbute
	[10764]={b=52173,s=10434,d=28710,c=AUCT_CLAS_ARMOR},  -- Deathchill Armor
	[10765]={b=16837,s=3367,d=28688,c=AUCT_CLAS_ARMOR},  -- Bonefingers
	[10766]={b=48304,s=9660,d=21027,c=AUCT_CLAS_WEAPON},  -- Plaguerot Sprig
	[10767]={b=48260,s=9652,d=20974,c=AUCT_CLAS_WEAPON},  -- Savage Boar's Guard
	[10768]={b=22705,s=4541,d=28684,c=AUCT_CLAS_ARMOR},  -- Boar Champion's Belt
	[10769]={b=21110,s=5277,d=19785,c=AUCT_CLAS_ARMOR},  -- Glowing Eye of Mordresh
	[10770]={b=31340,s=7835,d=19786,c=AUCT_CLAS_WEAPON},  -- Mordresh's Lifeless Skull
	[10771]={b=14552,s=2910,d=19910,c=AUCT_CLAS_ARMOR},  -- Deathmage Sash
	[10772]={b=60853,s=12170,d=8466,c=AUCT_CLAS_WEAPON},  -- Glutton's Cleaver
	[10773]={b=0,s=0,d=15692},  -- Hakkar'i Urn
	[10774]={b=29787,s=5957,d=28744,c=AUCT_CLAS_ARMOR},  -- Fleshhide Shoulders
	[10775]={b=31888,s=6377,d=28694,c=AUCT_CLAS_ARMOR},  -- Carapace of Tuten'kash
	[10776]={b=23999,s=4799,d=22994,c=AUCT_CLAS_ARMOR},  -- Silky Spider Cape
	[10777]={b=20070,s=4014,d=28595,c=AUCT_CLAS_ARMOR},  -- Arachnid Gloves
	[10778]={b=67720,s=16930,d=1399,c=AUCT_CLAS_ARMOR},  -- Necklace of Sanctuary
	[10779]={b=35230,s=8807,d=16452,c=AUCT_CLAS_ARMOR},  -- Demon's Blood
	[10780]={b=22170,s=5542,d=9837,c=AUCT_CLAS_ARMOR},  -- Mark of Hakkar
	[10781]={b=75359,s=15071,d=18470,c=AUCT_CLAS_ARMOR},  -- Hakkar'i Breastplate
	[10782]={b=22694,s=4538,d=19930,c=AUCT_CLAS_ARMOR},  -- Hakkar'i Shroud
	[10783]={b=57381,s=11476,d=19995,c=AUCT_CLAS_ARMOR},  -- Atal'ai Spaulders
	[10784]={b=92164,s=18432,d=19793,c=AUCT_CLAS_ARMOR},  -- Atal'ai Breastplate
	[10785]={b=66003,s=13200,d=14776,c=AUCT_CLAS_ARMOR},  -- Atal'ai Leggings
	[10786]={b=59889,s=11977,d=19794,c=AUCT_CLAS_ARMOR},  -- Atal'ai Boots
	[10787]={b=31914,s=6382,d=19796,c=AUCT_CLAS_ARMOR},  -- Atal'ai Gloves
	[10788]={b=26693,s=5338,d=19996,c=AUCT_CLAS_ARMOR},  -- Atal'ai Girdle
	[10789]={b=0,s=0,d=1134,c=AUCT_CLAS_WRITTEN},  -- Manual of Engineering Disciplines
	[10790]={b=0,s=0,d=3032},  -- Gnome Engineer Membership Card
	[10791]={b=0,s=0,d=5567},  -- Goblin Engineer Membership Card
	[10792]={b=0,s=0,d=7744},  -- Nixx's Pledge of Secrecy
	[10793]={b=0,s=0,d=7744},  -- Overspark's Pledge of Secrecy
	[10794]={b=0,s=0,d=7744},  -- Oglethorpe's Pledge of Secrecy
	[10795]={b=22170,s=5542,d=9834,c=AUCT_CLAS_ARMOR},  -- Drakeclaw Band
	[10796]={b=35930,s=8982,d=21602,c=AUCT_CLAS_WEAPON},  -- Drakestone
	[10797]={b=175347,s=35069,d=20030,c=AUCT_CLAS_WEAPON},  -- Firebreather
	[10798]={b=31319,s=6263,d=28640,c=AUCT_CLAS_ARMOR},  -- Atal'alarion's Tusk Ring
	[10799]={b=196442,s=39288,d=22242,c=AUCT_CLAS_WEAPON},  -- Headspike
	[10800]={b=37812,s=7562,d=19806,c=AUCT_CLAS_ARMOR},  -- Darkwater Bracers
	[10801]={b=58520,s=11704,d=19912,c=AUCT_CLAS_ARMOR},  -- Slitherscale Boots
	[10802]={b=39156,s=7831,d=18968,c=AUCT_CLAS_ARMOR},  -- Wingveil Cloak
	[10803]={b=147207,s=29441,d=20035,c=AUCT_CLAS_WEAPON},  -- Blade of the Wretched
	[10804]={b=147758,s=29551,d=19892,c=AUCT_CLAS_WEAPON},  -- Fist of the Damned
	[10805]={b=148309,s=29661,d=19127,c=AUCT_CLAS_WEAPON},  -- Eater of the Dead
	[10806]={b=75731,s=15146,d=19810,c=AUCT_CLAS_ARMOR},  -- Vestments of the Atal'ai Prophet
	[10807]={b=76012,s=15202,d=19812,c=AUCT_CLAS_ARMOR},  -- Kilt of the Atal'ai Prophet
	[10808]={b=38146,s=7629,d=19813,c=AUCT_CLAS_ARMOR},  -- Gloves of the Atal'ai Prophet
	[10818]={b=0,s=0,d=3331},  -- Yeh'kinya's Scroll
	[10819]={b=0,s=0,d=19529,q=20,x=20},  -- Wildkin Feather
	[10820]={b=691,s=138,d=19932,c=AUCT_CLAS_ARMOR},  -- Jackseed Belt
	[10821]={b=1040,s=208,d=28298,c=AUCT_CLAS_ARMOR},  -- Sower's Cloak
	[10822]={b=10000,s=2500,d=20655},  -- Dark Whelpling
	[10823]={b=88981,s=17796,d=20086,c=AUCT_CLAS_WEAPON},  -- Vanquisher's Sword
	[10824]={b=23720,s=5930,d=9859,c=AUCT_CLAS_ARMOR},  -- Amberglow Talisman
	[10826]={b=127506,s=25501,d=20293,c=AUCT_CLAS_WEAPON},  -- Staff of Lore
	[10827]={b=51191,s=10238,d=28205,c=AUCT_CLAS_ARMOR},  -- Surveyor's Tunic
	[10828]={b=202136,s=40427,d=20273,c=AUCT_CLAS_WEAPON},  -- Dire Nail
	[10829]={b=42720,s=10680,d=6494,c=AUCT_CLAS_ARMOR},  -- Dragon's Eye
	[10830]={b=3000,s=750,d=25482,x=10},  -- M73 Frag Grenade
	[10831]={b=0,s=0,d=6506},  -- Fel Orb
	[10832]={b=0,s=0,d=1246,c=AUCT_CLAS_WRITTEN},  -- Fel Tracker Owner's Manual
	[10833]={b=42986,s=8597,d=19838,c=AUCT_CLAS_ARMOR},  -- Horns of Eranikus
	[10834]={b=0,s=0,d=15692},  -- Felhound Tracker Kit
	[10835]={b=123225,s=24645,d=19840,c=AUCT_CLAS_WEAPON},  -- Crest of Supremacy
	[10836]={b=144946,s=28989,d=20788,c=AUCT_CLAS_WEAPON},  -- Rod of Corrosion
	[10837]={b=194005,s=38801,d=19841,c=AUCT_CLAS_WEAPON},  -- Tooth of Eranikus
	[10838]={b=173325,s=34665,d=19869,c=AUCT_CLAS_WEAPON},  -- Might of Hakkar
	[10839]={b=0,s=0,d=16062,c=AUCT_CLAS_WRITTEN},  -- Crystallized Note
	[10840]={b=0,s=0,d=16062,c=AUCT_CLAS_WRITTEN},  -- Crystallized Note
	[10841]={b=340,s=85,d=19873,x=20,c=AUCT_CLAS_FOOD},  -- Goldthorn Tea
	[10842]={b=87976,s=17595,d=22427,c=AUCT_CLAS_ARMOR},  -- Windscale Sarong
	[10843]={b=52977,s=10595,d=22995,c=AUCT_CLAS_ARMOR},  -- Featherskin Cape
	[10844]={b=221570,s=44314,d=20258,c=AUCT_CLAS_WEAPON},  -- Spire of Hakkar
	[10845]={b=71166,s=14233,d=19893,c=AUCT_CLAS_ARMOR},  -- Warrior's Embrace
	[10846]={b=80717,s=16143,d=19898,c=AUCT_CLAS_ARMOR},  -- Bloodshot Greaves
	[10847]={b=284608,s=56921,d=20571,c=AUCT_CLAS_WEAPON},  -- Dragon's Call
	[10858]={b=3000,s=750,d=1102},  -- Plans: Solid Iron Maul
	[10918]={b=170,s=42,d=13708,x=10,c=AUCT_CLAS_POISON},  -- Wound Poison
	[10919]={b=1074,s=214,d=20476,c=AUCT_CLAS_ARMOR},  -- Apothecary Gloves
	[10920]={b=270,s=67,d=13708,x=10,c=AUCT_CLAS_POISON},  -- Wound Poison II
	[10921]={b=500,s=125,d=13708,x=10,c=AUCT_CLAS_POISON},  -- Wound Poison III
	[10922]={b=700,s=175,d=13708,x=10,c=AUCT_CLAS_POISON},  -- Wound Poison IV
	[10938]={b=800,s=0,d=20608,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Lesser Magic Essence
	[10939]={b=2400,s=0,d=20609,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Greater Magic Essence
	[10940]={b=800,s=0,d=20611,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Strange Dust
	[10958]={b=0,s=0,d=15658},  -- Hilary's Necklace
	[10959]={b=35000,s=8750,d=20342,c=AUCT_CLAS_CONTAINER},  -- Demon Hide Sack
	[10978]={b=4000,s=0,d=20612,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Small Glimmering Shard
	[10998]={b=3000,s=0,d=20610,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Lesser Astral Essence
	[10999]={b=0,s=0,d=20433},  -- Ironfel
	[11000]={b=0,s=0,d=13885},  -- Shadowforge Key
	[11018]={b=585,s=146,d=2480,x=10},  -- Un'Goro Soil
	[11020]={b=10000,s=0,d=20503},  -- Evergreen Pouch
	[11022]={b=1000,s=250,d=20505,x=20},  -- Packet of Tharlendris Seeds
	[11023]={b=10000,s=2500,d=17284},  -- Ancona Chicken
	[11024]={b=0,s=0,d=23217},  -- Evergreen Herb Casing
	[11038]={b=800,s=200,d=11431},  -- Formula: Enchant 2H Weapon - Lesser Spirit
	[11039]={b=800,s=200,d=11431},  -- Formula: Enchant Cloak - Minor Agility
	[11040]={b=4,s=1,d=1442,q=20,x=20},  -- Morrowgrain
	[11058]={b=0,s=0,d=20558},  -- Sha'ni's Nose-Ring
	[11078]={b=0,s=0,d=4287,q=20,x=20},  -- Relic Coffer Key
	[11079]={b=0,s=0,d=20597},  -- Gor'tesh's Lopped Off Head
	[11080]={b=0,s=0,d=20597},  -- Gor'tesh's Lopped Off Head
	[11081]={b=800,s=200,d=11431},  -- Formula: Enchant Shield - Lesser Protection
	[11082]={b=9000,s=0,d=20613,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Greater Astral Essence
	[11083]={b=2400,s=0,d=20614,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Soul Dust
	[11084]={b=6000,s=0,d=20615,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Large Glimmering Shard
	[11086]={b=137016,s=27403,d=20031,c=AUCT_CLAS_WEAPON},  -- Jang'thraze the Protector
	[11098]={b=2000,s=500,d=11431},  -- Formula: Enchant Cloak - Lesser Shadow Resistance
	[11101]={b=2500,s=625,d=11431},  -- Formula: Enchant Bracer - Lesser Strength
	[11102]={b=0,s=0,d=20692},  -- Unhatched Sprite Darter Egg
	[11103]={b=0,s=0,d=3093},  -- Seed Voucher
	[11104]={b=0,s=0,d=6562},  -- Large Compass
	[11105]={b=1,s=0,d=20710},  -- Curled Map Parchment
	[11106]={b=0,s=0,d=20711},  -- Lion-headed Key
	[11107]={b=0,s=0,d=20709},  -- A Small Pack
	[11108]={b=0,s=0,d=4110,c=AUCT_CLAS_WRITTEN},  -- Faded Photograph
	[11109]={b=25,s=6,d=7087},  -- Special Chicken Feed
	[11110]={b=10,s=2,d=18047},  -- Chicken Egg
	[11112]={b=0,s=0,d=20733},  -- Research Equipment
	[11113]={b=0,s=0,d=11448},  -- Crate of Foodstuffs
	[11114]={b=0,s=0,d=6668,q=20,x=20},  -- Dinosaur Bone
	[11116]={b=0,s=0,d=1317,c=AUCT_CLAS_QUEST},  -- A Mangled Journal
	[11118]={b=43180,s=10795,d=20769,c=AUCT_CLAS_ARMOR},  -- Archaedic Stone
	[11119]={b=0,s=0,d=21973,q=20,x=20},  -- Milly's Harvest
	[11120]={b=150720,s=30144,d=28262,c=AUCT_CLAS_WEAPON},  -- Belgrom's Hammer
	[11121]={b=14705,s=2941,d=20094,c=AUCT_CLAS_WEAPON},  -- Darkwater Talwar
	[11122]={b=28650,s=7162,d=21115,c=AUCT_CLAS_ARMOR},  -- Carrot on a Stick
	[11123]={b=75186,s=15037,d=14590,c=AUCT_CLAS_ARMOR},  -- Rainstrider Leggings
	[11124]={b=84900,s=16980,d=28196,c=AUCT_CLAS_ARMOR},  -- Helm of Exile
	[11125]={b=0,s=0,d=2247,c=AUCT_CLAS_WRITTEN},  -- Grape Manifest
	[11126]={b=0,s=0,d=20774},  -- Tablet of Kurniya
	[11127]={b=0,s=0,d=20775,q=20,x=20},  -- Scavenged Goods
	[11128]={b=2000,s=500,d=21206,u=AUCT_TYPE_ENCHANT},  -- Golden Rod
	[11129]={b=0,s=0,d=20784,q=20,x=20},  -- Essence of the Elements
	[11130]={b=2000,s=500,d=21206,u=AUCT_TYPE_ENCHANT},  -- Runed Golden Rod
	[11131]={b=0,s=0,d=20789},  -- Hive Wall Sample
	[11132]={b=0,s=0,d=20791},  -- Unused Scraping Vial
	[11133]={b=0,s=0,d=20797},  -- Linken's Training Sword
	[11134]={b=10000,s=0,d=20794,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Lesser Mystic Essence
	[11135]={b=30000,s=0,d=20795,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Greater Mystic Essence
	[11136]={b=0,s=0,d=20796},  -- Linken's Tempered Sword
	[11137]={b=4000,s=0,d=20798,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Vision Dust
	[11138]={b=8000,s=0,d=20799,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Small Glowing Shard
	[11139]={b=12000,s=0,d=20800,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Large Glowing Shard
	[11140]={b=0,s=0,d=20802},  -- Prison Cell Key
	[11141]={b=2000,s=0,d=20803},  -- Bait
	[11142]={b=0,s=0,d=9167},  -- Broken Samophlange
	[11143]={b=0,s=0,d=20818,q=20,x=20},  -- Nugget Slug
	[11144]={b=4000,s=1000,d=21209,u=AUCT_TYPE_ENCHANT},  -- Truesilver Rod
	[11145]={b=5000,s=1250,d=21209,u=AUCT_TYPE_ENCHANT},  -- Runed Truesilver Rod
	[11146]={b=0,s=0,d=9167},  -- Broken and Battered Samophlange
	[11147]={b=0,s=0,d=3426},  -- Samophlange Manual Cover
	[11148]={b=0,s=0,d=7629,q=20,x=20},  -- Samophlange Manual Page
	[11149]={b=0,s=0,d=6672},  -- Samophlange Manual
	[11150]={b=3000,s=750,d=11431},  -- Formula: Enchant Gloves - Mining
	[11151]={b=3000,s=750,d=11431},  -- Formula: Enchant Gloves - Herbalism
	[11152]={b=3000,s=750,d=11431},  -- Formula: Enchant Gloves - Fishing
	[11162]={b=0,s=0,d=20872},  -- Linken's Superior Sword
	[11163]={b=3000,s=750,d=11431},  -- Formula: Enchant Bracer - Lesser Deflection
	[11164]={b=3000,s=750,d=11431},  -- Formula: Enchant Weapon - Lesser Beastslayer
	[11165]={b=3000,s=750,d=11431},  -- Formula: Enchant Weapon - Lesser Elemental Slayer
	[11166]={b=4000,s=1000,d=11431},  -- Formula: Enchant Gloves - Skinning
	[11167]={b=4000,s=1000,d=11431},  -- Formula: Enchant Boots - Lesser Spirit
	[11168]={b=4000,s=1000,d=11431},  -- Formula: Enchant Shield - Lesser Block
	[11169]={b=0,s=0,d=21032},  -- Book of Aquor
	[11172]={b=0,s=0,d=20893,q=20,x=20},  -- Silvery Claws
	[11173]={b=0,s=0,d=20894},  -- Irontree Heart
	[11174]={b=20000,s=0,d=20895,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Lesser Nether Essence
	[11175]={b=60000,s=0,d=20896,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Greater Nether Essence
	[11176]={b=8000,s=0,d=20899,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Dream Dust
	[11177]={b=24000,s=0,d=20901,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Small Radiant Shard
	[11178]={b=36000,s=0,d=20902,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Large Radiant Shard
	[11179]={b=0,s=0,d=20912},  -- Golden Flame
	[11184]={b=0,s=0,d=6614,q=10,x=10},  -- Blue Power Crystal
	[11185]={b=0,s=0,d=7393,q=10,x=10},  -- Green Power Crystal
	[11186]={b=0,s=0,d=20977,q=10,x=10},  -- Red Power Crystal
	[11187]={b=25,s=5,d=25939,c=AUCT_CLAS_ARMOR},  -- Stemleaf Bracers
	[11188]={b=0,s=0,d=20978,q=10,x=10},  -- Yellow Power Crystal
	[11189]={b=52,s=10,d=28178,c=AUCT_CLAS_ARMOR},  -- Woodland Robes
	[11190]={b=26,s=5,d=28188,c=AUCT_CLAS_ARMOR},  -- Viny Gloves
	[11191]={b=227,s=45,d=28167,c=AUCT_CLAS_ARMOR},  -- Farmer's Boots
	[11192]={b=23,s=4,d=4685,c=AUCT_CLAS_ARMOR},  -- Outfitter Gloves
	[11193]={b=84692,s=16938,d=19002,c=AUCT_CLAS_ARMOR},  -- Blazewind Breastplate
	[11194]={b=102024,s=20404,d=28237,c=AUCT_CLAS_ARMOR},  -- Prismscale Hauberk
	[11195]={b=68278,s=13655,d=28185,c=AUCT_CLAS_ARMOR},  -- Warforged Chestplate
	[11196]={b=67500,s=16875,d=9859,c=AUCT_CLAS_ARMOR},  -- Mindburst Medallion
	[11197]={b=0,s=0,d=20983},  -- Dark Keeper Key
	[11202]={b=4400,s=1100,d=11431},  -- Formula: Enchant Shield - Stamina
	[11203]={b=4400,s=1100,d=11431},  -- Formula: Enchant Gloves - Advanced Mining
	[11204]={b=4400,s=1100,d=11431},  -- Formula: Enchant Bracer - Greater Spirit
	[11205]={b=5000,s=1250,d=11431},  -- Formula: Enchant Gloves - Advanced Herbalism
	[11206]={b=5000,s=1250,d=11431},  -- Formula: Enchant Cloak - Lesser Agility
	[11207]={b=12000,s=3000,d=11431},  -- Formula: Enchant Weapon - Fiery Weapon
	[11208]={b=5400,s=1350,d=11431},  -- Formula: Enchant Weapon - Demonslaying
	[11222]={b=0,s=0,d=9666},  -- Head of Krom'zar
	[11223]={b=5800,s=1450,d=11431},  -- Formula: Enchant Bracer - Deflection
	[11224]={b=5800,s=1450,d=11431},  -- Formula: Enchant Shield - Frost Resistance
	[11225]={b=6200,s=1550,d=11431},  -- Formula: Enchant Bracer - Greater Stamina
	[11226]={b=6200,s=1550,d=11431},  -- Formula: Enchant Gloves - Riding Skill
	[11227]={b=0,s=0,d=6748},  -- Piece of Krom'zar's Banner
	[11229]={b=8481,s=1696,d=28306,c=AUCT_CLAS_ARMOR},  -- Brightscale Girdle
	[11230]={b=0,s=0,d=20995},  -- Encased Fiery Essence
	[11231]={b=0,s=0,d=19502,q=10,x=10},  -- Altered Black Dragonflight Molt
	[11242]={b=0,s=0,d=18169},  -- Evoroot
	[11243]={b=0,s=0,d=15788,q=20,x=20,c=AUCT_CLAS_POTION},  -- Videre Elixir
	[11262]={b=32570,s=8142,d=28337,c=AUCT_CLAS_WEAPON},  -- Orb of Lorica
	[11263]={b=42097,s=8419,d=25077,c=AUCT_CLAS_WEAPON},  -- Nether Force Wand
	[11265]={b=82424,s=16484,d=28629,c=AUCT_CLAS_WEAPON},  -- Cragwood Maul
	[11266]={b=0,s=0,d=21072,q=20,x=20},  -- Fractured Elemental Shard
	[11267]={b=0,s=0,d=21072},  -- Elemental Shard Sample
	[11268]={b=0,s=0,d=3920},  -- Head of Argelmach
	[11269]={b=0,s=0,d=8560,q=10,x=10},  -- Intact Elemental Core
	[11270]={b=0,s=0,d=7744},  -- Nixx's Signed Pledge
	[11282]={b=0,s=0,d=7744},  -- Oglethorpe's Signed Pledge
	[11283]={b=0,s=0,d=7744},  -- Overspark's Signed Pledge
	[11284]={b=1000,s=1,d=19422,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Accurate Slugs
	[11285]={b=1000,s=2,d=21091,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Jagged Arrow
	[11286]={b=0,s=0,d=21092},  -- Thorium Shackles
	[11287]={b=521,s=104,d=21096,c=AUCT_CLAS_WEAPON},  -- Lesser Magic Wand
	[11288]={b=2329,s=465,d=21097,c=AUCT_CLAS_WEAPON},  -- Greater Magic Wand
	[11289]={b=10743,s=2148,d=21098,c=AUCT_CLAS_WEAPON},  -- Lesser Mystic Wand
	[11290]={b=15789,s=3157,d=21101,c=AUCT_CLAS_WEAPON},  -- Greater Mystic Wand
	[11291]={b=4500,s=1125,d=7290,x=20,u=AUCT_TYPE_ENCHANT},  -- Star Wood
	[11302]={b=28520,s=7130,d=6515,c=AUCT_CLAS_ARMOR},  -- Uther's Strength
	[11303]={b=3184,s=636,d=8104,c=AUCT_CLAS_WEAPON},  -- Fine Shortbow
	[11304]={b=4861,s=972,d=20550,c=AUCT_CLAS_WEAPON},  -- Fine Longbow
	[11305]={b=25814,s=5162,d=21111,c=AUCT_CLAS_WEAPON},  -- Dense Shortbow
	[11306]={b=19467,s=3893,d=20713,c=AUCT_CLAS_WEAPON},  -- Sturdy Recurve
	[11307]={b=67952,s=13590,d=21112,c=AUCT_CLAS_WEAPON},  -- Massive Longbow
	[11308]={b=78828,s=15765,d=21113,c=AUCT_CLAS_WEAPON},  -- Sylvan Shortbow
	[11309]={b=0,s=0,d=7050},  -- The Heart of the Mountain
	[11310]={b=32990,s=6598,d=5116,c=AUCT_CLAS_ARMOR},  -- Flameseer Mantle
	[11311]={b=25553,s=5110,d=28731,c=AUCT_CLAS_ARMOR},  -- Emberscale Cape
	[11312]={b=0,s=0,d=8927},  -- Lost Thunderbrew Recipe
	[11313]={b=0,s=0,d=1310},  -- Ribbly's Head
	[11315]={b=0,s=0,d=21149,q=10,x=10},  -- Bloodpetal Sprout
	[11316]={b=0,s=0,d=13489,q=20,x=20},  -- Bloodpetal
	[11318]={b=0,s=0,d=21164,q=20,x=20},  -- Atal'ai Haze
	[11319]={b=0,s=0,d=21175},  -- Unloaded Zapper
	[11320]={b=0,s=0,d=21189},  -- Bloodpetal Zapper
	[11324]={b=25000,s=6250,d=19595,c=AUCT_CLAS_CONTAINER},  -- Explorer's Knapsack
	[11325]={b=600,s=150,d=18099,x=20},  -- Dark Iron Ale Mug
	[11362]={b=1000,s=250,d=21329,c=AUCT_CLAS_CONTAINER},  -- Medium Quiver
	[11366]={b=0,s=0,d=7649},  -- Helendis Riverhorn's Letter
	[11367]={b=0,s=0,d=7726},  -- Solomon's Plea to Bolvar
	[11368]={b=0,s=0,d=16065,c=AUCT_CLAS_WRITTEN},  -- Bolvar's Decree
	[11370]={b=2000,s=500,d=4691,x=10,u=AUCT_TYPE_MINING},  -- Dark Iron Ore
	[11371]={b=2400,s=600,d=7389,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_MINING..", "..AUCT_TYPE_SMITH},  -- Dark Iron Bar
	[11382]={b=3000,s=750,d=7051,x=20,u=AUCT_TYPE_ENCHANT},  -- Blood of the Mountain
	[11384]={b=280,s=70,d=7350,x=20},  -- Broken Basilisk Teeth
	[11385]={b=580,s=145,d=21363,x=20},  -- Basilisk Scale
	[11386]={b=2705,s=676,d=9292,x=10},  -- Squishy Basilisk Eye
	[11387]={b=4055,s=1013,d=3422,x=5},  -- Basilisk Heart
	[11388]={b=6255,s=1563,d=2885,x=5},  -- Basilisk Venom
	[11389]={b=8655,s=2163,d=21364,x=5},  -- Shimmering Basilisk Skin
	[11390]={b=320,s=80,d=6002,x=20},  -- Broken Bat Fang
	[11391]={b=820,s=205,d=18517,x=10},  -- Spined Bat Wing
	[11392]={b=1612,s=403,d=3307,x=5},  -- Severed Bat Claw
	[11393]={b=3120,s=780,d=7103,x=10},  -- Small Bat Skull
	[11394]={b=2320,s=580,d=1438,x=10},  -- Bat Heart
	[11395]={b=3320,s=830,d=21365,x=10},  -- Bat Ear
	[11402]={b=4820,s=1205,d=21366,x=10},  -- Sleek Bat Pelt
	[11403]={b=6370,s=1592,d=6651,x=10},  -- Large Bat Fang
	[11404]={b=8320,s=2080,d=1504,x=10},  -- Evil Bat Eye
	[11405]={b=0,s=0,d=21367,q=20,x=20},  -- Giant Silver Vein
	[11406]={b=675,s=168,d=8794,x=5},  -- Rotting Bear Carcass
	[11407]={b=435,s=108,d=7170,x=10},  -- Torn Bear Pelt
	[11408]={b=3595,s=898,d=21368,x=10},  -- Bear Jaw
	[11409]={b=2015,s=503,d=2376,x=10},  -- Bear Flank
	[11410]={b=2315,s=578,d=1496,x=10},  -- Savage Bear Claw
	[11411]={b=7420,s=1484,d=6569,c=AUCT_CLAS_WEAPON},  -- Large Bear Bone
	[11412]={b=0,s=0,d=4136},  -- Nagmara's Vial
	[11413]={b=0,s=0,d=4136},  -- Nagmara's Filled Vial
	[11414]={b=7315,s=1828,d=7354,x=10},  -- Grizzled Mane
	[11415]={b=4000,s=200,d=21369,q=20,x=20},  -- Mixed Berries
	[11416]={b=1315,s=328,d=6631,x=10},  -- Delicate Ribcage
	[11417]={b=4816,s=1204,d=4433,x=5},  -- Feathery Wing
	[11418]={b=2416,s=604,d=7251,x=5},  -- Hollow Wing Bone
	[11419]={b=7600,s=1900,d=18047,x=10},  -- Mysterious Unhatched Egg
	[11420]={b=6850,s=1712,d=21370,x=10},  -- Elegant Writing Tool
	[11422]={b=0,s=0,d=21374},  -- Goblin Engineer's Renewal Gift
	[11423]={b=0,s=0,d=21375},  -- Gnome Engineer's Renewal Gift
	[11444]={b=4000,s=200,d=2376,q=20,x=20},  -- Grim Guzzler Boar
	[11445]={b=0,s=0,d=21402},  -- Flute of the Ancients
	[11446]={b=0,s=0,d=7695,c=AUCT_CLAS_QUEST},  -- A Crumpled Up Note
	[11462]={b=0,s=0,d=21411},  -- Discarded Knife
	[11463]={b=0,s=0,d=1244,c=AUCT_CLAS_QUEST},  -- Undelivered Parcel
	[11464]={b=0,s=0,d=20219},  -- Marshal Windsor's Lost Information
	[11465]={b=0,s=0,d=20219},  -- Marshal Windsor's Lost Information
	[11466]={b=0,s=0,d=1093},  -- Raschal's Report
	[11467]={b=0,s=0,d=18725,q=50,x=50},  -- Blackrock Medallion
	[11468]={b=0,s=0,d=1281,q=20,x=20},  -- Dark Iron Fanny Pack
	[11469]={b=17815,s=3563,d=14601,c=AUCT_CLAS_ARMOR},  -- Bloodband Bracers
	[11470]={b=0,s=0,d=7695},  -- Tablet Transcript
	[11471]={b=0,s=0,d=20692},  -- Fragile Sprite Darter Egg
	[11472]={b=0,s=0,d=2599,q=10,x=10},  -- Silvermane Stalker Flank
	[11474]={b=2000,s=500,d=18047},  -- Sprite Darter Egg
	[11475]={b=38,s=7,d=28181,c=AUCT_CLAS_ARMOR},  -- Wine-stained Cloak
	[11476]={b=0,s=0,d=7112},  -- U'cha's Pelt
	[11477]={b=0,s=0,d=21415,q=10,x=10},  -- White Ravasaur Claw
	[11478]={b=0,s=0,d=8952,q=10,x=10},  -- Un'Goro Gorilla Pelt
	[11479]={b=0,s=0,d=21416,q=10,x=10},  -- Un'Goro Stomper Pelt
	[11480]={b=0,s=0,d=3164,q=10,x=10},  -- Un'Goro Thunderer Pelt
	[11482]={b=0,s=0,d=21431,c=AUCT_CLAS_WRITTEN},  -- Crystal Pylon User's Manual
	[11502]={b=32551,s=6510,d=28217,c=AUCT_CLAS_ARMOR},  -- Loreskin Shoulders
	[11503]={b=0,s=0,d=21458,q=20,x=20},  -- Blood Amber
	[11504]={b=0,s=0,d=1116},  -- Piece of Threshadon Carcass
	[11507]={b=0,s=0,d=21463,q=20,x=20},  -- Spotted Hyena Pelt
	[11508]={b=5,s=1,d=22034,c=AUCT_CLAS_ARMOR},  -- Gamemaster's Slippers
	[11509]={b=0,s=0,d=1438,q=5,x=5},  -- Ravasaur Pheromone Gland
	[11510]={b=0,s=0,d=30111},  -- Lar'korwi's Head
	[11511]={b=0,s=0,d=21469},  -- Cenarion Beacon
	[11512]={b=0,s=0,d=21470,q=20,x=20},  -- Patch of Tainted Skin
	[11513]={b=4,s=1,d=19239,q=20,x=20},  -- Tainted Vitriol
	[11514]={b=4,s=1,d=21471,q=20,x=20},  -- Fel Creep
	[11515]={b=4,s=1,d=21472,q=20,x=20,c=AUCT_CLAS_WARLOCK},  -- Corrupted Soul Shard
	[11516]={b=0,s=0,d=21473,q=100,x=100},  -- Cenarion Plant Salve
	[11522]={b=0,s=0,d=21608,c=AUCT_CLAS_WEAPON},  -- Silver Totem of Aquementas
	[11562]={b=4000,s=1000,d=2516,x=20},  -- Crystal Restore
	[11563]={b=4000,s=1000,d=13496,x=20},  -- Crystal Force
	[11564]={b=4000,s=1000,d=4777,x=20},  -- Crystal Ward
	[11565]={b=4000,s=1000,d=7401,x=20},  -- Crystal Yield
	[11566]={b=4000,s=1000,d=6496,x=20},  -- Crystal Charge
	[11567]={b=4000,s=1000,d=1262,x=20},  -- Crystal Spire
	[11568]={b=0,s=0,d=8631},  -- Torwa's Pouch
	[11569]={b=0,s=0,d=2599},  -- Preserved Threshadon Meat
	[11570]={b=0,s=0,d=1275},  -- Preserved Pheromone Mixture
	[11582]={b=0,s=0,d=21531},  -- Fel Salve
	[11583]={b=0,s=0,d=6410,q=10,x=10,c=AUCT_CLAS_FOOD},  -- Cactus Apple
	[11584]={b=25,s=1,d=6410,q=20,x=20},  -- Cactus Apple Surprise
	[11590]={b=1000,s=250,d=21556,x=5},  -- Mechanical Repair Kit
	[11602]={b=0,s=0,d=4287},  -- Grim Guzzler Key
	[11603]={b=153283,s=30656,d=23270,c=AUCT_CLAS_WEAPON},  -- Vilerend Slicer
	[11604]={b=97143,s=19428,d=21580,c=AUCT_CLAS_ARMOR},  -- Dark Iron Plate
	[11605]={b=53880,s=10776,d=21574,c=AUCT_CLAS_ARMOR},  -- Dark Iron Shoulders
	[11606]={b=96279,s=19255,d=21577,c=AUCT_CLAS_ARMOR},  -- Dark Iron Mail
	[11607]={b=256125,s=51225,d=22218,c=AUCT_CLAS_WEAPON},  -- Dark Iron Sunderer
	[11608]={b=228803,s=45760,d=25046,c=AUCT_CLAS_WEAPON},  -- Dark Iron Pulverizer
	[11610]={b=12000,s=3000,d=1102},  -- Plans: Dark Iron Pulverizer
	[11611]={b=12000,s=3000,d=1102},  -- Plans: Dark Iron Sunderer
	[11612]={b=12000,s=3000,d=1102},  -- Plans: Dark Iron Plate
	[11614]={b=12000,s=3000,d=15274},  -- Plans: Dark Iron Mail
	[11615]={b=12000,s=3000,d=15274},  -- Plans: Dark Iron Shoulders
	[11617]={b=0,s=0,d=21586},  -- Eridan's Supplies
	[11622]={b=0,s=0,d=22651},  -- Lesser Arcanum of Rumination
	[11623]={b=41665,s=8333,d=26137,c=AUCT_CLAS_ARMOR},  -- Spritecaster Cape
	[11624]={b=37832,s=7566,d=28788,c=AUCT_CLAS_ARMOR},  -- Kentic Amice
	[11625]={b=41810,s=10452,d=21595,c=AUCT_CLAS_WEAPON},  -- Enthralled Sphere
	[11626]={b=40409,s=8081,d=26278,c=AUCT_CLAS_ARMOR},  -- Blackveil Cape
	[11627]={b=61120,s=12224,d=28658,c=AUCT_CLAS_ARMOR},  -- Fleetfoot Greaves
	[11628]={b=122167,s=24433,d=28780,c=AUCT_CLAS_WEAPON},  -- Houndmaster's Bow
	[11629]={b=122635,s=24527,d=28781,c=AUCT_CLAS_WEAPON},  -- Houndmaster's Rifle
	[11630]={b=20,s=5,d=2418,x=200,c=AUCT_CLAS_WEAPON},  -- Rockshard Pellets
	[11631]={b=82890,s=16578,d=21613,c=AUCT_CLAS_WEAPON},  -- Stoneshell Guard
	[11632]={b=39001,s=7800,d=28725,c=AUCT_CLAS_ARMOR},  -- Earthslag Shoulders
	[11633]={b=58650,s=11730,d=21898,c=AUCT_CLAS_ARMOR},  -- Spiderfang Carapace
	[11634]={b=29432,s=5886,d=28741,c=AUCT_CLAS_ARMOR},  -- Silkweb Gloves
	[11635]={b=177256,s=35451,d=28779,c=AUCT_CLAS_WEAPON},  -- Hookfang Shanker
	[11642]={b=0,s=0,d=22651},  -- Lesser Arcanum of Constitution
	[11643]={b=0,s=0,d=22651},  -- Lesser Arcanum of Tenacity
	[11644]={b=0,s=0,d=22651},  -- Lesser Arcanum of Resilience
	[11645]={b=0,s=0,d=22651},  -- Lesser Arcanum of Voracity
	[11646]={b=0,s=0,d=22651},  -- Lesser Arcanum of Voracity
	[11647]={b=0,s=0,d=22651},  -- Lesser Arcanum of Voracity
	[11648]={b=0,s=0,d=22651},  -- Lesser Arcanum of Voracity
	[11649]={b=0,s=0,d=22651},  -- Lesser Arcanum of Voracity
	[11662]={b=31094,s=6218,d=28642,c=AUCT_CLAS_ARMOR},  -- Ban'thok Sash
	[11665]={b=35550,s=7110,d=17263,c=AUCT_CLAS_ARMOR},  -- Ogreseer Fists
	[11668]={b=0,s=0,d=21402,c=AUCT_CLAS_QUEST},  -- Flute of Xavaric
	[11669]={b=68630,s=17157,d=9837,c=AUCT_CLAS_ARMOR},  -- Naglering
	[11674]={b=0,s=0,d=21651,q=20,x=20},  -- Jadefire Felbind
	[11675]={b=60266,s=12053,d=18979,c=AUCT_CLAS_ARMOR},  -- Shadefiend Boots
	[11677]={b=48563,s=9712,d=28381,c=AUCT_CLAS_ARMOR},  -- Graverot Cape
	[11678]={b=77981,s=15596,d=21578,c=AUCT_CLAS_ARMOR},  -- Carapace of Anub'shiah
	[11679]={b=48908,s=9781,d=28820,c=AUCT_CLAS_ARMOR},  -- Rubicund Armguards
	[11682]={b=0,s=0,d=21673},  -- Eridan's Vial
	[11684]={b=315430,s=63086,d=23618,c=AUCT_CLAS_WEAPON},  -- Ironfoe
	[11685]={b=58088,s=11617,d=28704,c=AUCT_CLAS_ARMOR},  -- Splinthide Shoulders
	[11686]={b=46645,s=9329,d=28763,c=AUCT_CLAS_ARMOR},  -- Girdle of Beastial Fury
	[11702]={b=153135,s=30627,d=28765,c=AUCT_CLAS_WEAPON},  -- Grizzle's Skinner
	[11703]={b=30743,s=6148,d=28686,c=AUCT_CLAS_ARMOR},  -- Stonewall Girdle
	[11722]={b=83052,s=16610,d=28721,c=AUCT_CLAS_ARMOR},  -- Dregmetal Spaulders
	[11723]={b=0,s=0,d=21692},  -- Goodsteel's Balanced Flameberge
	[11724]={b=0,s=0,d=7918},  -- Overdue Package
	[11725]={b=0,s=0,d=10530,q=20,x=20},  -- Solid Crystal Leg Shaft
	[11726]={b=167666,s=33533,d=28724,c=AUCT_CLAS_ARMOR},  -- Savage Gladiator Chain
	[11727]={b=0,s=0,d=1143,c=AUCT_CLAS_WRITTEN},  -- Goodsteel Ledger
	[11728]={b=126681,s=25336,d=21694,c=AUCT_CLAS_ARMOR},  -- Savage Gladiator Leggings
	[11729]={b=95365,s=19073,d=28826,c=AUCT_CLAS_ARMOR},  -- Savage Gladiator Helm
	[11730]={b=63813,s=12762,d=28723,c=AUCT_CLAS_ARMOR},  -- Savage Gladiator Grips
	[11731]={b=96500,s=19300,d=28666,c=AUCT_CLAS_ARMOR},  -- Savage Gladiator Greaves
	[11732]={b=0,s=0,d=1246,c=AUCT_CLAS_WRITTEN},  -- Libram of Rumination
	[11733]={b=0,s=0,d=7139,c=AUCT_CLAS_WRITTEN},  -- Libram of Constitution
	[11734]={b=0,s=0,d=1103,c=AUCT_CLAS_WRITTEN},  -- Libram of Tenacity
	[11735]={b=83349,s=16669,d=21701,c=AUCT_CLAS_ARMOR},  -- Ragefury Eyepatch
	[11736]={b=0,s=0,d=8093,c=AUCT_CLAS_WRITTEN},  -- Libram of Resilience
	[11737]={b=0,s=0,d=1134,c=AUCT_CLAS_WRITTEN},  -- Libram of Voracity
	[11742]={b=35000,s=8750,d=20709,c=AUCT_CLAS_CONTAINER},  -- Wayfarer's Knapsack
	[11743]={b=153672,s=30734,d=21714,c=AUCT_CLAS_WEAPON},  -- Rockfist
	[11744]={b=196213,s=39242,d=21715,c=AUCT_CLAS_WEAPON},  -- Bloodfist
	[11745]={b=32825,s=6565,d=28740,c=AUCT_CLAS_ARMOR},  -- Fists of Phalanx
	[11746]={b=59309,s=11861,d=21717,c=AUCT_CLAS_ARMOR},  -- Golem Skull Helm
	[11747]={b=83298,s=16659,d=21719,c=AUCT_CLAS_ARMOR},  -- Flamestrider Robes
	[11748]={b=125416,s=25083,d=28807,c=AUCT_CLAS_WEAPON},  -- Pyric Caduceus
	[11749]={b=100708,s=20141,d=28722,c=AUCT_CLAS_ARMOR},  -- Searingscale Leggings
	[11750]={b=216171,s=43234,d=21723,c=AUCT_CLAS_WEAPON},  -- Kindling Stave
	[11751]={b=0,s=0,d=21724,q=5,x=5},  -- Burning Essence
	[11752]={b=0,s=0,d=17974,q=5,x=5},  -- Black Blood of the Tormented
	[11753]={b=0,s=0,d=7986},  -- Eye of Kajal
	[11754]={b=0,s=0,d=22652,q=5,x=5},  -- Black Diamond
	[11755]={b=58510,s=14627,d=21725,c=AUCT_CLAS_ARMOR},  -- Verek's Collar
	[11764]={b=51990,s=10398,d=21753,c=AUCT_CLAS_ARMOR},  -- Cinderhide Armsplints
	[11765]={b=62625,s=12525,d=28806,c=AUCT_CLAS_ARMOR},  -- Pyremail Wristguards
	[11766]={b=43031,s=8606,d=21755,c=AUCT_CLAS_ARMOR},  -- Flameweave Cuffs
	[11767]={b=43188,s=8637,d=21754,c=AUCT_CLAS_ARMOR},  -- Emberplate Armguards
	[11768]={b=36121,s=7224,d=28785,c=AUCT_CLAS_ARMOR},  -- Incendic Bracers
	[11782]={b=63602,s=12720,d=21771,c=AUCT_CLAS_ARMOR},  -- Boreal Mantle
	[11783]={b=63838,s=12767,d=28696,c=AUCT_CLAS_ARMOR},  -- Chillsteel Girdle
	[11784]={b=169177,s=33835,d=21773,c=AUCT_CLAS_WEAPON},  -- Arbiter's Blade
	[11785]={b=145414,s=29082,d=18814,c=AUCT_CLAS_WEAPON},  -- Rock Golem Bulwark
	[11786]={b=253699,s=50739,d=21775,c=AUCT_CLAS_WEAPON},  -- Stone of the Earth
	[11787]={b=68664,s=13732,d=28669,c=AUCT_CLAS_ARMOR},  -- Shalehusk Boots
	[11802]={b=74901,s=14980,d=19843,c=AUCT_CLAS_ARMOR},  -- Lavacrest Leggings
	[11803]={b=209074,s=41814,d=21793,c=AUCT_CLAS_WEAPON},  -- Force of Magma
	[11804]={b=0,s=0,d=21794},  -- Spraggle's Canteen
	[11805]={b=202196,s=40439,d=28821,c=AUCT_CLAS_WEAPON},  -- Rubidium Hammer
	[11807]={b=45766,s=9153,d=28825,c=AUCT_CLAS_ARMOR},  -- Sash of the Burning Heart
	[11808]={b=96460,s=19292,d=28268,c=AUCT_CLAS_ARMOR},  -- Circle of Flame
	[11809]={b=256435,s=51287,d=22031,c=AUCT_CLAS_WEAPON},  -- Flame Wrath
	[11810]={b=40000,s=10000,d=19767,c=AUCT_CLAS_ARMOR},  -- Force of Will
	[11811]={b=6000,s=1500,d=21804,c=AUCT_CLAS_ARMOR},  -- Smoking Heart of the Mountain
	[11812]={b=69895,s=13979,d=22997,c=AUCT_CLAS_ARMOR},  -- Cape of the Fire Salamander
	[11813]={b=12000,s=3000,d=11431},  -- Formula: Smoking Heart of the Mountain
	[11814]={b=65415,s=13083,d=21805,c=AUCT_CLAS_ARMOR},  -- Molten Fists
	[11815]={b=40000,s=10000,d=6337,c=AUCT_CLAS_ARMOR},  -- Hand of Justice
	[11816]={b=203678,s=40735,d=22212,c=AUCT_CLAS_WEAPON},  -- Angerforge's Battle Axe
	[11817]={b=196273,s=39254,d=21809,c=AUCT_CLAS_WEAPON},  -- Lord General's Sword
	[11818]={b=0,s=0,d=21807,c=AUCT_CLAS_QUEST},  -- Grimsite Outhouse Key
	[11819]={b=40000,s=10000,d=18725,c=AUCT_CLAS_ARMOR},  -- Second Wind
	[11820]={b=111507,s=22301,d=28819,c=AUCT_CLAS_ARMOR},  -- Royal Decorated Armor
	[11821]={b=111924,s=22384,d=28623,c=AUCT_CLAS_ARMOR},  -- Warstrife Leggings
	[11822]={b=58973,s=11794,d=28660,c=AUCT_CLAS_ARMOR},  -- Omnicast Boots
	[11823]={b=98654,s=19730,d=28728,c=AUCT_CLAS_ARMOR},  -- Luminary Kilt
	[11824]={b=54630,s=13657,d=9847,c=AUCT_CLAS_ARMOR},  -- Cyclopean Band
	[11825]={b=10000,s=2500,d=21833},  -- Pet Bombling
	[11826]={b=10000,s=2500,d=9730},  -- Lil' Smoky
	[11827]={b=2700,s=675,d=15274},  -- Schematic: Lil' Smoky
	[11829]={b=0,s=0,d=2480,q=20,x=20},  -- Un'Goro Ash
	[11830]={b=0,s=0,d=21834,q=20,x=20},  -- Webbed Diemetradon Scale
	[11831]={b=0,s=0,d=21835,q=20,x=20},  -- Webbed Pterrordax Scale
	[11832]={b=40000,s=10000,d=19764,c=AUCT_CLAS_ARMOR},  -- Burst of Knowledge
	[11833]={b=0,s=0,d=21836},  -- Gorishi Queen Lure
	[11834]={b=0,s=0,d=9518,q=20,x=20},  -- Super Sticky Tar
	[11835]={b=0,s=0,d=10923},  -- Gorishi Queen Brain
	[11837]={b=0,s=0,d=1438},  -- Gorishi Scent Gland
	[11839]={b=55958,s=11191,d=21839,c=AUCT_CLAS_ARMOR},  -- Chief Architect's Monocle
	[11840]={b=28550,s=7137,d=21842,c=AUCT_CLAS_ARMOR},  -- Master Builder's Shirt
	[11841]={b=62636,s=12527,d=28720,c=AUCT_CLAS_ARMOR},  -- Senior Designer's Pantaloons
	[11842]={b=71043,s=14208,d=28792,c=AUCT_CLAS_ARMOR},  -- Lead Surveyor's Mantle
	[11843]={b=0,s=0,d=7798},  -- Bank Voucher
	[11844]={b=0,s=0,d=1301},  -- Pestlezugg's Un'Goro Report
	[11845]={b=250,s=62,d=1183,c=AUCT_CLAS_CONTAINER},  -- Handmade Leather Bag
	[11846]={b=120,s=30,d=21845,x=20},  -- Wizbang's Special Brew
	[11847]={b=38,s=7,d=28071,c=AUCT_CLAS_ARMOR},  -- Battered Cloak
	[11848]={b=26,s=5,d=28170,c=AUCT_CLAS_ARMOR},  -- Flax Belt
	[11849]={b=38,s=7,d=9644,c=AUCT_CLAS_ARMOR},  -- Rustmetal Bracers
	[11850]={b=35,s=7,d=23128,c=AUCT_CLAS_ARMOR},  -- Short Duskbat Cape
	[11851]={b=60,s=12,d=28249,c=AUCT_CLAS_ARMOR},  -- Scavenger Tunic
	[11852]={b=71,s=14,d=19575,c=AUCT_CLAS_ARMOR},  -- Roamer's Leggings
	[11853]={b=1941,s=388,d=28241,c=AUCT_CLAS_ARMOR},  -- Rambling Boots
	[11854]={b=7472,s=1494,d=28245,c=AUCT_CLAS_WEAPON},  -- Samophlange Screwdriver
	[11855]={b=3130,s=782,d=7494,c=AUCT_CLAS_WEAPON},  -- Tork Wrench
	[11856]={b=78876,s=15775,d=28312,c=AUCT_CLAS_WEAPON},  -- Ceremonial Elven Blade
	[11857]={b=106888,s=21377,d=28345,c=AUCT_CLAS_WEAPON},  -- Sanctimonial Rod
	[11858]={b=23842,s=4768,d=28260,c=AUCT_CLAS_ARMOR},  -- Battlehard Cape
	[11859]={b=28540,s=7135,d=21853,c=AUCT_CLAS_WEAPON},  -- Jademoon Orb
	[11860]={b=64854,s=12970,d=28108,c=AUCT_CLAS_WEAPON},  -- Charged Lightning Rod
	[11861]={b=26039,s=5207,d=28171,c=AUCT_CLAS_ARMOR},  -- Girdle of Reprisal
	[11862]={b=28170,s=7042,d=6486,c=AUCT_CLAS_ARMOR},  -- White Bone Band
	[11863]={b=135957,s=27191,d=21855,c=AUCT_CLAS_WEAPON},  -- White Bone Shredder
	[11864]={b=170542,s=34108,d=25632,c=AUCT_CLAS_WEAPON},  -- White Bone Spear
	[11865]={b=43541,s=8708,d=16766,c=AUCT_CLAS_ARMOR},  -- Rancor Boots
	[11866]={b=49098,s=9819,d=28219,c=AUCT_CLAS_ARMOR},  -- Nagmara's Whipping Belt
	[11867]={b=43848,s=8769,d=28332,c=AUCT_CLAS_ARMOR},  -- Maddening Gauntlets
	[11868]={b=26170,s=6542,d=9840,c=AUCT_CLAS_ARMOR},  -- Choking Band
	[11869]={b=26170,s=6542,d=9849,c=AUCT_CLAS_ARMOR},  -- Sha'ni's Ring
	[11870]={b=41150,s=10287,d=28226,c=AUCT_CLAS_WEAPON},  -- Oblivion Orb
	[11871]={b=53331,s=10666,d=28253,c=AUCT_CLAS_ARMOR},  -- Snarkshaw Spaulders
	[11872]={b=42830,s=8566,d=28164,c=AUCT_CLAS_ARMOR},  -- Eschewal Greaves
	[11873]={b=48309,s=9661,d=28325,c=AUCT_CLAS_ARMOR},  -- Ethereal Mist Cape
	[11874]={b=60620,s=12124,d=28313,c=AUCT_CLAS_ARMOR},  -- Clouddrift Mantle
	[11875]={b=28881,s=5776,d=28305,c=AUCT_CLAS_ARMOR},  -- Breezecloud Bracers
	[11876]={b=81437,s=16287,d=28233,c=AUCT_CLAS_ARMOR},  -- Plainstalker Tunic
	[11882]={b=102603,s=20520,d=27770,c=AUCT_CLAS_ARMOR},  -- Outrider Leggings
	[11883]={b=0,s=0,d=1281},  -- A Dingy Fanny Pack
	[11884]={b=9231,s=1846,d=14649,c=AUCT_CLAS_ARMOR},  -- Moonlit Amice
	[11885]={b=2846,s=711,d=12738},  -- Shadowforge Torch
	[11886]={b=0,s=0,d=7695,c=AUCT_CLAS_WRITTEN},  -- Urgent Message
	[11887]={b=50,s=12,d=20709},  -- Cenarion Circle Cache
	[11888]={b=24398,s=4879,d=28342,c=AUCT_CLAS_ARMOR},  -- Quintis' Research Gloves
	[11889]={b=36728,s=7345,d=28304,c=AUCT_CLAS_ARMOR},  -- Bark Iron Pauldrons
	[11902]={b=170973,s=34194,d=22227,c=AUCT_CLAS_WEAPON},  -- Linken's Sword of Mastery
	[11904]={b=55260,s=13815,d=21936,c=AUCT_CLAS_WEAPON},  -- Spirit of Aquementas
	[11905]={b=24813,s=6203,d=22753,c=AUCT_CLAS_ARMOR},  -- Linken's Boomerang
	[11906]={b=163615,s=32723,d=28075,c=AUCT_CLAS_WEAPON},  -- Beastsmasher
	[11907]={b=205250,s=41050,d=28073,c=AUCT_CLAS_WEAPON},  -- Beastslayer
	[11908]={b=49434,s=9886,d=28063,c=AUCT_CLAS_ARMOR},  -- Archaeologist's Quarry Boots
	[11909]={b=41337,s=8267,d=17121,c=AUCT_CLAS_ARMOR},  -- Excavator's Utility Belt
	[11910]={b=61727,s=12345,d=28076,c=AUCT_CLAS_ARMOR},  -- Bejeweled Legguards
	[11911]={b=61960,s=12392,d=28198,c=AUCT_CLAS_ARMOR},  -- Treetop Leggings
	[11912]={b=0,s=0,d=8928},  -- Package of Empty Ooze Containers
	[11913]={b=70224,s=14044,d=28132,c=AUCT_CLAS_ARMOR},  -- Clayridge Helm
	[11914]={b=0,s=0,d=20791,q=20,x=20},  -- Empty Cursed Ooze Jar
	[11915]={b=100623,s=20124,d=18750,c=AUCT_CLAS_WEAPON},  -- Shizzle's Drizzle Blocker
	[11916]={b=59171,s=11834,d=28254,c=AUCT_CLAS_ARMOR},  -- Shizzle's Muzzle
	[11917]={b=31674,s=6334,d=28255,c=AUCT_CLAS_ARMOR},  -- Shizzle's Nozzle Wiper
	[11918]={b=47687,s=9537,d=28186,c=AUCT_CLAS_ARMOR},  -- Grotslab Gloves
	[11919]={b=47862,s=9572,d=28136,c=AUCT_CLAS_ARMOR},  -- Cragplate Greaves
	[11920]={b=203662,s=40732,d=28679,c=AUCT_CLAS_WEAPON},  -- Wraith Scythe
	[11921]={b=270836,s=54167,d=25625,c=AUCT_CLAS_WEAPON},  -- Impervious Giant
	[11922]={b=217457,s=43491,d=25609,c=AUCT_CLAS_WEAPON},  -- Blood-etched Blade
	[11923]={b=218244,s=43648,d=21956,c=AUCT_CLAS_WEAPON},  -- The Hammer of Grace
	[11924]={b=102378,s=20475,d=28814,c=AUCT_CLAS_ARMOR},  -- Robes of the Royal Crown
	[11925]={b=82423,s=16484,d=28762,c=AUCT_CLAS_ARMOR},  -- Ghostshroud
	[11926]={b=122952,s=24590,d=28712,c=AUCT_CLAS_ARMOR},  -- Deathdealer Breastplate
	[11927]={b=82283,s=16456,d=21961,c=AUCT_CLAS_ARMOR},  -- Legplates of the Eternal Guardian
	[11928]={b=88181,s=22045,d=21962,c=AUCT_CLAS_WEAPON},  -- Thaurissan's Royal Scepter
	[11929]={b=82905,s=16581,d=28736,c=AUCT_CLAS_ARMOR},  -- Haunting Specter Leggings
	[11930]={b=72941,s=14588,d=21965,c=AUCT_CLAS_ARMOR},  -- The Emperor's New Cape
	[11931]={b=290516,s=58103,d=28719,c=AUCT_CLAS_WEAPON},  -- Dreadforge Retaliator
	[11932]={b=291612,s=58322,d=21968,c=AUCT_CLAS_WEAPON},  -- Guiding Stave of Wisdom
	[11933]={b=78585,s=19646,d=28784,c=AUCT_CLAS_ARMOR},  -- Imperial Jewel
	[11934]={b=79685,s=19921,d=28733,c=AUCT_CLAS_ARMOR},  -- Emperor's Seal
	[11935]={b=52650,s=13162,d=28795,c=AUCT_CLAS_WEAPON},  -- Magmus Stone
	[11936]={b=1421,s=284,d=28242,c=AUCT_CLAS_ARMOR},  -- Relic Hunter Belt
	[11937]={b=749,s=187,d=1168},  -- Fat Sack of Coins
	[11938]={b=854,s=213,d=4056},  -- Sack of Gems
	[11939]={b=2684,s=671,d=14432,x=20},  -- Shiny Bracelet
	[11940]={b=1558,s=389,d=9657,x=20},  -- Sparkly Necklace
	[11941]={b=23584,s=5896,d=7798,x=10},  -- False Documents
	[11942]={b=21215,s=5303,d=7629,x=10},  -- Legal Documents
	[11943]={b=85941,s=21485,d=7744},  -- Deed to Thandol Span
	[11944]={b=35284,s=8821,d=21970},  -- Dark Iron Baby Booties
	[11945]={b=26370,s=6592,d=9840,c=AUCT_CLAS_ARMOR},  -- Dark Iron Ring
	[11946]={b=31650,s=7912,d=9854,c=AUCT_CLAS_ARMOR},  -- Fire Opal Necklace
	[11947]={b=0,s=0,d=21971,q=20,x=20},  -- Filled Cursed Ooze Jar
	[11948]={b=0,s=0,d=20791,q=20,x=20},  -- Empty Tainted Ooze Jar
	[11949]={b=0,s=0,d=21972,q=20,x=20},  -- Filled Tainted Ooze Jar
	[11950]={b=0,s=0,d=21973,q=20,x=20},  -- Windblossom Berries
	[11951]={b=0,s=0,d=21974,q=20,x=20},  -- Whipper Root Tuber
	[11952]={b=0,s=0,d=21975,q=20,x=20},  -- Night Dragon's Breath
	[11953]={b=0,s=0,d=20791,q=20,x=20},  -- Empty Pure Sample Jar
	[11954]={b=0,s=0,d=21976,q=20,x=20},  -- Filled Pure Sample Jar
	[11955]={b=0,s=0,d=21977},  -- Bag of Empty Ooze Containers
	[11962]={b=39699,s=7939,d=17229,c=AUCT_CLAS_ARMOR},  -- Manacle Cuffs
	[11963]={b=50128,s=10025,d=28232,c=AUCT_CLAS_ARMOR},  -- Penance Spaulders
	[11964]={b=150783,s=30156,d=28203,c=AUCT_CLAS_WEAPON},  -- Swiftstrike Cudgel
	[11965]={b=1858,s=464,d=9837,c=AUCT_CLAS_ARMOR},  -- Quartz Ring
	[11966]={b=658,s=164,d=1168},  -- Small Sack of Coins
	[11967]={b=4351,s=1087,d=9835,c=AUCT_CLAS_ARMOR},  -- Zircon Band
	[11968]={b=3988,s=997,d=9836,c=AUCT_CLAS_ARMOR},  -- Amber Hoop
	[11969]={b=6887,s=1721,d=9839,c=AUCT_CLAS_ARMOR},  -- Jacinth Circle
	[11970]={b=6841,s=1710,d=9842,c=AUCT_CLAS_ARMOR},  -- Spinel Ring
	[11971]={b=15876,s=3969,d=9840,c=AUCT_CLAS_ARMOR},  -- Amethyst Band
	[11972]={b=18597,s=4649,d=4284,c=AUCT_CLAS_ARMOR},  -- Carnelian Loop
	[11973]={b=15887,s=3971,d=224,c=AUCT_CLAS_ARMOR},  -- Hematite Link
	[11974]={b=19885,s=4971,d=3666,c=AUCT_CLAS_ARMOR},  -- Aquamarine Ring
	[11975]={b=18958,s=4739,d=9835,c=AUCT_CLAS_ARMOR},  -- Topaz Ring
	[11976]={b=31112,s=7778,d=9834,c=AUCT_CLAS_ARMOR},  -- Sardonyx Knuckle
	[11977]={b=31587,s=7896,d=9833,c=AUCT_CLAS_ARMOR},  -- Serpentine Loop
	[11978]={b=29658,s=7414,d=9834,c=AUCT_CLAS_ARMOR},  -- Jasper Link
	[11979]={b=29885,s=7471,d=9836,c=AUCT_CLAS_ARMOR},  -- Perdiot Circle
	[11980]={b=42158,s=10539,d=9837,c=AUCT_CLAS_ARMOR},  -- Opal Ring
	[11981]={b=1985,s=496,d=3666,c=AUCT_CLAS_ARMOR},  -- Lead Band
	[11982]={b=4251,s=1062,d=9823,c=AUCT_CLAS_ARMOR},  -- Viridian Band
	[11983]={b=4521,s=1130,d=9837,c=AUCT_CLAS_ARMOR},  -- Chrome Ring
	[11984]={b=8756,s=2189,d=9832,c=AUCT_CLAS_ARMOR},  -- Cobalt Ring
	[11985]={b=8576,s=2144,d=9847,c=AUCT_CLAS_ARMOR},  -- Cerulean Ring
	[11986]={b=6981,s=1745,d=9849,c=AUCT_CLAS_ARMOR},  -- Thallium Hoop
	[11987]={b=11543,s=2885,d=9840,c=AUCT_CLAS_ARMOR},  -- Iridium Circle
	[11988]={b=28455,s=7113,d=9833,c=AUCT_CLAS_ARMOR},  -- Tellurium Band
	[11989]={b=29887,s=7471,d=9847,c=AUCT_CLAS_ARMOR},  -- Vanadium Loop
	[11990]={b=33225,s=8306,d=9834,c=AUCT_CLAS_ARMOR},  -- Selenium Loop
	[11991]={b=25268,s=6317,d=3666,c=AUCT_CLAS_ARMOR},  -- Quicksilver Ring
	[11992]={b=29585,s=7396,d=9839,c=AUCT_CLAS_ARMOR},  -- Vermilion Band
	[11993]={b=3498,s=874,d=9836,c=AUCT_CLAS_ARMOR},  -- Clay Ring
	[11994]={b=5251,s=1312,d=9832,c=AUCT_CLAS_ARMOR},  -- Coral Band
	[11995]={b=3658,s=914,d=9837,c=AUCT_CLAS_ARMOR},  -- Ivory Band
	[11996]={b=6854,s=1713,d=9823,c=AUCT_CLAS_ARMOR},  -- Basalt Ring
	[11997]={b=25876,s=6469,d=9847,c=AUCT_CLAS_ARMOR},  -- Greenstone Circle
	[11998]={b=11587,s=2896,d=3666,c=AUCT_CLAS_ARMOR},  -- Jet Loop
	[11999]={b=22155,s=5538,d=4284,c=AUCT_CLAS_ARMOR},  -- Lodestone Hoop
	[12000]={b=205269,s=41053,d=28207,c=AUCT_CLAS_WEAPON},  -- Limb Cleaver
	[12001]={b=19885,s=4971,d=3666,c=AUCT_CLAS_ARMOR},  -- Onyx Ring
	[12002]={b=25289,s=6322,d=9834,c=AUCT_CLAS_ARMOR},  -- Marble Circle
	[12003]={b=1000,s=250,d=18115,x=20},  -- Dark Dwarven Lager
	[12004]={b=36652,s=9163,d=3666,c=AUCT_CLAS_ARMOR},  -- Obsidian Band
	[12005]={b=35254,s=8813,d=3666,c=AUCT_CLAS_ARMOR},  -- Granite Ring
	[12006]={b=4258,s=1064,d=9833,c=AUCT_CLAS_ARMOR},  -- Meadow Ring
	[12007]={b=4258,s=1064,d=4284,c=AUCT_CLAS_ARMOR},  -- Prairie Ring
	[12008]={b=3581,s=895,d=224,c=AUCT_CLAS_ARMOR},  -- Savannah Ring
	[12009]={b=8698,s=2174,d=9837,c=AUCT_CLAS_ARMOR},  -- Tundra Ring
	[12010]={b=9876,s=2469,d=9834,c=AUCT_CLAS_ARMOR},  -- Fen Ring
	[12011]={b=18599,s=4649,d=9833,c=AUCT_CLAS_ARMOR},  -- Forest Hoop
	[12012]={b=9853,s=2463,d=9847,c=AUCT_CLAS_ARMOR},  -- Marsh Ring
	[12013]={b=18599,s=4649,d=9836,c=AUCT_CLAS_ARMOR},  -- Desert Ring
	[12014]={b=25158,s=6289,d=9835,c=AUCT_CLAS_ARMOR},  -- Arctic Ring
	[12015]={b=35245,s=8811,d=9833,c=AUCT_CLAS_ARMOR},  -- Swamp Ring
	[12016]={b=31125,s=7781,d=9847,c=AUCT_CLAS_ARMOR},  -- Jungle Ring
	[12017]={b=35853,s=8963,d=9839,c=AUCT_CLAS_ARMOR},  -- Prismatic Band
	[12018]={b=69211,s=13842,d=28135,c=AUCT_CLAS_ARMOR},  -- Conservator Helm
	[12019]={b=16881,s=4220,d=6539,c=AUCT_CLAS_ARMOR},  -- Cerulean Talisman
	[12020]={b=15878,s=3969,d=9860,c=AUCT_CLAS_ARMOR},  -- Thallium Choker
	[12021]={b=46636,s=9327,d=23483,c=AUCT_CLAS_ARMOR},  -- Shieldplate Sabatons
	[12022]={b=18875,s=4718,d=9658,c=AUCT_CLAS_ARMOR},  -- Iridium Chain
	[12023]={b=19885,s=4971,d=9853,c=AUCT_CLAS_ARMOR},  -- Tellurium Necklace
	[12024]={b=21587,s=5396,d=9859,c=AUCT_CLAS_ARMOR},  -- Vanadium Talisman
	[12025]={b=21130,s=5282,d=9852,c=AUCT_CLAS_ARMOR},  -- Selenium Chain
	[12026]={b=31030,s=7757,d=9657,c=AUCT_CLAS_ARMOR},  -- Quicksilver Pendant
	[12027]={b=25030,s=6257,d=9858,c=AUCT_CLAS_ARMOR},  -- Vermilion Necklace
	[12028]={b=16030,s=4007,d=9857,c=AUCT_CLAS_ARMOR},  -- Basalt Necklace
	[12029]={b=21581,s=5395,d=6539,c=AUCT_CLAS_ARMOR},  -- Greenstone Talisman
	[12030]={b=28574,s=7143,d=15420,c=AUCT_CLAS_ARMOR},  -- Jet Chain
	[12031]={b=31578,s=7894,d=9859,c=AUCT_CLAS_ARMOR},  -- Lodestone Necklace
	[12032]={b=21587,s=5396,d=15420,c=AUCT_CLAS_ARMOR},  -- Onyx Choker
	[12033]={b=0,s=0,d=22020},  -- Thaurissan Family Jewels
	[12034]={b=20050,s=5012,d=9859,c=AUCT_CLAS_ARMOR},  -- Marble Necklace
	[12035]={b=22053,s=5513,d=15420,c=AUCT_CLAS_ARMOR},  -- Obsidian Pendant
	[12036]={b=23930,s=5982,d=9860,c=AUCT_CLAS_ARMOR},  -- Granite Necklace
	[12037]={b=350,s=87,d=25480,x=10,u=AUCT_TYPE_COOK},  -- Mystery Meat
	[12038]={b=36370,s=9092,d=224,c=AUCT_CLAS_ARMOR},  -- Lagrave's Seal
	[12039]={b=16899,s=4224,d=9657,c=AUCT_CLAS_ARMOR},  -- Tundra Necklace
	[12040]={b=16658,s=4164,d=6539,c=AUCT_CLAS_ARMOR},  -- Forest Pendant
	[12041]={b=72233,s=14446,d=28429,c=AUCT_CLAS_ARMOR},  -- Windshear Leggings
	[12042]={b=18997,s=4749,d=9852,c=AUCT_CLAS_ARMOR},  -- Marsh Chain
	[12043]={b=21587,s=5396,d=9857,c=AUCT_CLAS_ARMOR},  -- Desert Choker
	[12044]={b=20581,s=5145,d=9859,c=AUCT_CLAS_ARMOR},  -- Arctic Pendant
	[12045]={b=31068,s=7767,d=15420,c=AUCT_CLAS_ARMOR},  -- Swamp Pendant
	[12046]={b=23030,s=5757,d=6539,c=AUCT_CLAS_ARMOR},  -- Jungle Necklace
	[12047]={b=19987,s=4996,d=9852,c=AUCT_CLAS_ARMOR},  -- Spectral Necklace
	[12048]={b=26030,s=6507,d=9657,c=AUCT_CLAS_ARMOR},  -- Prismatic Pendant
	[12049]={b=84251,s=16850,d=28244,c=AUCT_CLAS_ARMOR},  -- Splintsteel Armor
	[12050]={b=44818,s=8963,d=4272,c=AUCT_CLAS_ARMOR},  -- Hazecover Boots
	[12051]={b=44983,s=8996,d=28090,c=AUCT_CLAS_ARMOR},  -- Brazen Gauntlets
	[12052]={b=3350,s=837,d=9837,c=AUCT_CLAS_ARMOR},  -- Ring of the Moon
	[12053]={b=3350,s=837,d=3666,c=AUCT_CLAS_ARMOR},  -- Volcanic Rock Ring
	[12054]={b=3350,s=837,d=9834,c=AUCT_CLAS_ARMOR},  -- Demon Band
	[12055]={b=33500,s=8375,d=9840,c=AUCT_CLAS_ARMOR},  -- Stardust Band
	[12056]={b=33500,s=8375,d=9832,c=AUCT_CLAS_ARMOR},  -- Ring of the Heavens
	[12057]={b=33500,s=8375,d=9836,c=AUCT_CLAS_ARMOR},  -- Dragonscale Band
	[12058]={b=33505,s=8376,d=3666,c=AUCT_CLAS_ARMOR},  -- Demonic Bone Ring
	[12059]={b=49510,s=12377,d=4841,c=AUCT_CLAS_ARMOR},  -- Conqueror's Medallion
	[12060]={b=0,s=0,d=6270},  -- Shindrell's Note
	[12061]={b=201060,s=40212,d=28086,c=AUCT_CLAS_WEAPON},  -- Blade of Reckoning
	[12062]={b=201827,s=40365,d=25611,c=AUCT_CLAS_WEAPON},  -- Skilled Fighting Blade
	[12064]={b=4,s=1,d=22036,c=AUCT_CLAS_ARMOR},  -- Gamemaster Hood
	[12065]={b=31813,s=7953,d=22037,c=AUCT_CLAS_ARMOR},  -- Ward of the Elements
	[12066]={b=55747,s=11149,d=28251,c=AUCT_CLAS_ARMOR},  -- Shaleskin Cape
	[12082]={b=68634,s=13726,d=28176,c=AUCT_CLAS_ARMOR},  -- Wyrmhide Spaulders
	[12083]={b=36743,s=7348,d=28190,c=AUCT_CLAS_ARMOR},  -- Valconian Sash
	[12102]={b=36170,s=9042,d=9840,c=AUCT_CLAS_ARMOR},  -- Ring of the Aristocrat
	[12103]={b=48630,s=12157,d=23717,c=AUCT_CLAS_ARMOR},  -- Star of Mystaria
	[12108]={b=115274,s=23054,d=28070,c=AUCT_CLAS_ARMOR},  -- Basaltscale Armor
	[12109]={b=57845,s=11569,d=21771,c=AUCT_CLAS_ARMOR},  -- Azure Moon Amice
	[12110]={b=58054,s=11610,d=28240,c=AUCT_CLAS_ARMOR},  -- Raincaster Drape
	[12111]={b=38841,s=7768,d=28202,c=AUCT_CLAS_ARMOR},  -- Lavaplate Gauntlets
	[12112]={b=52034,s=10406,d=28139,c=AUCT_CLAS_ARMOR},  -- Crypt Demon Bracers
	[12113]={b=52219,s=10443,d=28210,c=AUCT_CLAS_ARMOR},  -- Sunborne Cape
	[12114]={b=43671,s=8734,d=28222,c=AUCT_CLAS_ARMOR},  -- Nightfall Gloves
	[12115]={b=35060,s=7012,d=28224,c=AUCT_CLAS_ARMOR},  -- Stalwart Clutch
	[12122]={b=0,s=0,d=2593},  -- Kum'isha's Junk
	[12144]={b=0,s=0,d=22299},  -- Eggscilloscope
	[12162]={b=3000,s=750,d=1102},  -- Plans: Hardened Iron Shortsword
	[12163]={b=4400,s=1100,d=1102},  -- Plans: Moonsteel Broadsword
	[12164]={b=4400,s=1100,d=1102},  -- Plans: Massive Iron Axe
	[12184]={b=350,s=87,d=25467,x=10,u=AUCT_TYPE_COOK},  -- Raptor Flesh
	[12185]={b=64477,s=12895,d=22184,c=AUCT_CLAS_ARMOR},  -- Bloodsail Admiral's Hat
	[12190]={b=1000,s=250,d=17403,x=5,c=AUCT_CLAS_POTION},  -- Dreamless Sleep Potion
	[12191]={b=0,s=0,d=22192},  -- Silver Dawning's Lockbox
	[12192]={b=0,s=0,d=16028},  -- Mist Veil's Lockbox
	[12202]={b=350,s=87,d=2599,x=10,u=AUCT_TYPE_COOK},  -- Tiger Meat
	[12203]={b=350,s=87,d=25466,x=10,u=AUCT_TYPE_COOK},  -- Red Wolf Meat
	[12204]={b=450,s=112,d=25472,x=10,u=AUCT_TYPE_COOK},  -- Heavy Kodo Meat
	[12205]={b=450,s=112,d=22193,x=10,u=AUCT_TYPE_COOK},  -- White Spider Meat
	[12206]={b=450,s=112,d=22193,x=10,u=AUCT_TYPE_COOK},  -- Tender Crab Meat
	[12207]={b=600,s=150,d=18052,x=10,u=AUCT_TYPE_COOK},  -- Giant Egg
	[12208]={b=600,s=150,d=2599,x=10,u=AUCT_TYPE_COOK},  -- Tender Wolf Meat
	[12209]={b=380,s=95,d=22194,x=20},  -- Lean Wolf Steak
	[12210]={b=1200,s=300,d=22195,x=20,c=AUCT_CLAS_FOOD},  -- Roast Raptor
	[12212]={b=1200,s=300,d=21473,x=20},  -- Jungle Stew
	[12213]={b=1200,s=300,d=22197,x=20,c=AUCT_CLAS_FOOD},  -- Carrion Surprise
	[12214]={b=1200,s=300,d=22198,x=20,c=AUCT_CLAS_FOOD},  -- Mystery Stew
	[12215]={b=1200,s=300,d=22198,x=20},  -- Heavy Kodo Stew
	[12216]={b=1200,s=300,d=22196,x=20},  -- Spiced Chili Crab
	[12217]={b=1200,s=300,d=21473,x=20},  -- Dragonbreath Chili
	[12218]={b=1200,s=300,d=6353,x=20,c=AUCT_CLAS_FOOD},  -- Monster Omelet
	[12219]={b=0,s=0,d=19330},  -- Unadorned Seal of Ascension
	[12220]={b=0,s=0,d=7025,q=20,x=20},  -- Intact Elemental Bracer
	[12223]={b=16,s=4,d=6704,x=10,u=AUCT_TYPE_COOK},  -- Meaty Bat Wing
	[12224]={b=40,s=10,d=22200,x=20},  -- Crispy Bat Wing
	[12225]={b=939,s=187,d=20618,c=AUCT_CLAS_FISHING},  -- Blump Family Fishing Pole
	[12226]={b=25,s=6,d=811},  -- Recipe: Crispy Bat Wing
	[12227]={b=1600,s=400,d=1102},  -- Recipe: Lean Wolf Steak
	[12228]={b=5000,s=1250,d=1301,c=AUCT_CLAS_FOOD},  -- Recipe: Roast Raptor
	[12229]={b=5000,s=1250,d=1301},  -- Recipe: Hot Wolf Ribs
	[12230]={b=0,s=0,d=22202,q=20,x=20},  -- Felwood Slime Sample
	[12231]={b=3000,s=750,d=1301},  -- Recipe: Jungle Stew
	[12232]={b=5000,s=1250,d=1301,c=AUCT_CLAS_FOOD},  -- Recipe: Carrion Surprise
	[12233]={b=3000,s=750,d=1301,c=AUCT_CLAS_FOOD},  -- Recipe: Mystery Stew
	[12234]={b=0,s=0,d=22203,q=20,x=20},  -- Corrupted Felwood Sample
	[12235]={b=0,s=0,d=22204,q=20,x=20},  -- Un'Goro Slime Sample
	[12236]={b=0,s=0,d=22205,q=20,x=20},  -- Pure Un'Goro Sample
	[12237]={b=0,s=0,d=22193,q=20,x=20},  -- Fine Crab Chunks
	[12238]={b=40,s=2,d=24698,q=20,x=20},  -- Darkshore Grouper
	[12239]={b=7000,s=1750,d=1301},  -- Recipe: Dragonbreath Chili
	[12240]={b=7000,s=1750,d=1301},  -- Recipe: Heavy Kodo Stew
	[12241]={b=0,s=0,d=1659,q=20,x=20},  -- Collected Dragon Egg
	[12242]={b=0,s=0,d=22207},  -- Sea Creature Bones
	[12243]={b=229901,s=45980,d=5290,c=AUCT_CLAS_WEAPON},  -- Smoldering Claw
	[12247]={b=28372,s=5674,d=22247,c=AUCT_CLAS_WEAPON},  -- Broad Bladed Knife
	[12248]={b=32029,s=6405,d=22248,c=AUCT_CLAS_WEAPON},  -- Daring Dirk
	[12249]={b=30195,s=6039,d=22249,c=AUCT_CLAS_WEAPON},  -- Merciless Axe
	[12250]={b=40341,s=8068,d=22250,c=AUCT_CLAS_WEAPON},  -- Midnight Axe
	[12251]={b=53896,s=10779,d=22252,c=AUCT_CLAS_WEAPON},  -- Big Stick
	[12252]={b=63095,s=12619,d=28699,c=AUCT_CLAS_WEAPON},  -- Staff of Protection
	[12253]={b=17728,s=3545,d=28690,c=AUCT_CLAS_ARMOR},  -- Brilliant Red Cloak
	[12254]={b=22416,s=4483,d=23079,c=AUCT_CLAS_ARMOR},  -- Well Oiled Cloak
	[12255]={b=34987,s=6997,d=4765,c=AUCT_CLAS_ARMOR},  -- Pale Leggings
	[12256]={b=43828,s=8765,d=16764,c=AUCT_CLAS_ARMOR},  -- Cindercloth Leggings
	[12257]={b=19429,s=3885,d=28777,c=AUCT_CLAS_ARMOR},  -- Heavy Notched Belt
	[12259]={b=40363,s=8072,d=4119,c=AUCT_CLAS_WEAPON},  -- Glinting Steel Dagger
	[12260]={b=51977,s=10395,d=22258,c=AUCT_CLAS_WEAPON},  -- Searing Golden Blade
	[12261]={b=3800,s=950,d=15274},  -- Plans: Searing Golden Blade
	[12262]={b=0,s=0,d=22271},  -- Empty Worg Pup Cage
	[12263]={b=0,s=0,d=22271},  -- Caged Worg Pup
	[12264]={b=6000,s=1500,d=20629},  -- Worg Carrier
	[12282]={b=43,s=8,d=22291,c=AUCT_CLAS_WEAPON},  -- Worn Battleaxe
	[12283]={b=0,s=0,d=7050,q=20,x=20},  -- Broodling Essence
	[12284]={b=0,s=0,d=22293},  -- Draco-Incarcinatrix 900
	[12286]={b=0,s=0,d=22299},  -- Eggscilloscope Prototype
	[12287]={b=0,s=0,d=22303},  -- Collectronic Module
	[12288]={b=0,s=0,d=8381},  -- Encased Corrupt Ooze
	[12289]={b=0,s=0,d=22304},  -- Sea Turtle Remains
	[12291]={b=0,s=0,d=6703},  -- Merged Ooze Sample
	[12292]={b=0,s=0,d=7913},  -- Strangely Marked Box
	[12293]={b=0,s=0,d=7331},  -- Fine Gold Thread
	[12295]={b=1413,s=282,d=28204,c=AUCT_CLAS_ARMOR},  -- Leggings of the People's Militia
	[12296]={b=3612,s=722,d=28248,c=AUCT_CLAS_WEAPON},  -- Spark of the People's Militia
	[12299]={b=82,s=16,d=28221,c=AUCT_CLAS_ARMOR},  -- Netted Gloves
	[12300]={b=0,s=0,d=6506},  -- Orb of Draconic Energy
	[12301]={b=0,s=0,d=22377},  -- Bamboo Cage Key
	[12302]={b=10000000,s=0,d=17608},  -- Reins of the Frostsaber
	[12303]={b=10000000,s=0,d=17608},  -- Reins of the Nightsaber
	[12323]={b=0,s=0,d=7366},  -- Unforged Seal of Ascension
	[12324]={b=0,s=0,d=7366},  -- Forged Seal of Ascension
	[12330]={b=10000000,s=0,d=16208},  -- Horn of the Red Wolf
	[12334]={b=0,s=0,d=6563,q=20,x=20},  -- Frostmaul Shards
	[12335]={b=0,s=0,d=6496},  -- Gemstone of Smolderthorn
	[12336]={b=0,s=0,d=2516},  -- Gemstone of Spirestone
	[12337]={b=0,s=0,d=6006},  -- Gemstone of Bloodaxe
	[12339]={b=0,s=0,d=18721},  -- Vaelan's Gift
	[12341]={b=0,s=0,d=22414},  -- Blackwood Fruit Sample
	[12342]={b=0,s=0,d=16206},  -- Blackwood Grain Sample
	[12343]={b=0,s=0,d=6417},  -- Blackwood Nut Sample
	[12344]={b=0,s=0,d=22415,c=AUCT_CLAS_ARMOR},  -- Seal of Ascension
	[12345]={b=0,s=0,d=19595},  -- Bijou's Belongings
	[12346]={b=0,s=0,d=22416},  -- Empty Cleansing Bowl
	[12347]={b=0,s=0,d=22417},  -- Filled Cleansing Bowl
	[12349]={b=0,s=0,d=15773},  -- Cliffspring River Sample
	[12350]={b=0,s=0,d=22429},  -- Empty Sampling Tube
	[12351]={b=10000000,s=0,d=16207},  -- Horn of the Arctic Wolf
	[12352]={b=0,s=0,d=7366},  -- Doomrigger's Clasp
	[12353]={b=10000000,s=0,d=13108},  -- White Stallion Bridle
	[12354]={b=10000000,s=0,d=25132},  -- Palomino Bridle
	[12355]={b=0,s=0,d=19462},  -- Talisman of Corruption
	[12356]={b=0,s=0,d=22436,q=20,x=20},  -- Highperch Wyvern Egg
	[12358]={b=0,s=0,d=22443},  -- Darkstone Tablet
	[12359]={b=2400,s=600,d=22444,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT},  -- Thorium Bar
	[12360]={b=20000,s=5000,d=14993,x=20},  -- Arcanite Bar
	[12361]={b=28000,s=7000,d=1659,x=20},  -- Blue Sapphire
	[12363]={b=8000,s=2000,d=18707,x=20,u=AUCT_TYPE_ALCHEM},  -- Arcane Crystal
	[12364]={b=40000,s=10000,d=6851,x=20},  -- Huge Emerald
	[12365]={b=1000,s=250,d=23148,x=20},  -- Dense Stone
	[12366]={b=0,s=0,d=21366,q=20,x=20},  -- Thick Yeti Fur
	[12367]={b=0,s=0,d=22464,q=20,x=20},  -- Pristine Yeti Horn
	[12368]={b=0,s=0,d=12332},  -- Dawn's Gambit
	[12382]={b=0,s=0,d=22477},  -- Key to the City
	[12383]={b=0,s=0,d=19528,q=20,x=20},  -- Moontouched Feather
	[12384]={b=0,s=0,d=22483},  -- Cache of Mau'ari
	[12402]={b=0,s=0,d=18050},  -- Ancient Egg
	[12404]={b=300,s=75,d=24677,x=20},  -- Dense Sharpening Stone
	[12405]={b=46199,s=9239,d=25751,c=AUCT_CLAS_ARMOR},  -- Thorium Armor
	[12406]={b=23183,s=4636,d=22550,c=AUCT_CLAS_ARMOR},  -- Thorium Belt
	[12408]={b=24991,s=4998,d=25753,c=AUCT_CLAS_ARMOR},  -- Thorium Bracers
	[12409]={b=51682,s=10336,d=25752,c=AUCT_CLAS_ARMOR},  -- Thorium Boots
	[12410]={b=51863,s=10372,d=25856,c=AUCT_CLAS_ARMOR},  -- Thorium Helm
	[12411]={b=0,s=0,d=22484},  -- Third Mosh'aru Tablet
	[12412]={b=0,s=0,d=20220},  -- Fourth Mosh'aru Tablet
	[12414]={b=86882,s=17376,d=22951,c=AUCT_CLAS_ARMOR},  -- Thorium Leggings
	[12415]={b=85018,s=17003,d=25742,c=AUCT_CLAS_ARMOR},  -- Radiant Breastplate
	[12416]={b=37979,s=7595,d=25740,c=AUCT_CLAS_ARMOR},  -- Radiant Belt
	[12417]={b=85174,s=17034,d=25826,c=AUCT_CLAS_ARMOR},  -- Radiant Circlet
	[12418]={b=51214,s=10242,d=25744,c=AUCT_CLAS_ARMOR},  -- Radiant Gloves
	[12419]={b=82107,s=16421,d=25741,c=AUCT_CLAS_ARMOR},  -- Radiant Boots
	[12420]={b=126654,s=25330,d=25745,c=AUCT_CLAS_ARMOR},  -- Radiant Leggings
	[12422]={b=81021,s=16204,d=25749,c=AUCT_CLAS_ARMOR},  -- Imperial Plate Chest
	[12424]={b=27665,s=5533,d=24514,c=AUCT_CLAS_ARMOR},  -- Imperial Plate Belt
	[12425]={b=30221,s=6044,d=24511,c=AUCT_CLAS_ARMOR},  -- Imperial Plate Bracers
	[12426]={b=60311,s=12062,d=24513,c=AUCT_CLAS_ARMOR},  -- Imperial Plate Boots
	[12427]={b=60530,s=12106,d=24510,c=AUCT_CLAS_ARMOR},  -- Imperial Plate Helm
	[12428]={b=43233,s=8646,d=24509,c=AUCT_CLAS_ARMOR},  -- Imperial Plate Shoulders
	[12429]={b=89615,s=17923,d=24506,c=AUCT_CLAS_ARMOR},  -- Imperial Plate Leggings
	[12430]={b=0,s=0,d=19800,q=20,x=20},  -- Frostsaber E'ko
	[12431]={b=0,s=0,d=19800,q=20,x=20},  -- Winterfall E'ko
	[12432]={b=0,s=0,d=19800,q=20,x=20},  -- Shardtooth E'ko
	[12433]={b=0,s=0,d=19800,q=20,x=20},  -- Wildkin E'ko
	[12434]={b=0,s=0,d=19800,q=20,x=20},  -- Chillwind E'ko
	[12435]={b=0,s=0,d=19800,q=20,x=20},  -- Ice Thistle E'ko
	[12436]={b=0,s=0,d=19800,q=20,x=20},  -- Frostmaul E'ko
	[12437]={b=0,s=0,d=8928},  -- Ridgewell's Crate
	[12438]={b=0,s=0,d=3029,c=AUCT_CLAS_WRITTEN},  -- Tinkee's Letter
	[12444]={b=0,s=0,d=16283,q=20,x=20},  -- Uncracked Chillwind Horn
	[12445]={b=0,s=0,d=11448},  -- Felnok's Package
	[12446]={b=95,s=19,d=28060,c=AUCT_CLAS_WEAPON},  -- Anvilmar Musket
	[12447]={b=96,s=19,d=20723,c=AUCT_CLAS_WEAPON},  -- Thistlewood Bow
	[12448]={b=96,s=19,d=28206,c=AUCT_CLAS_WEAPON},  -- Light Hunting Rifle
	[12449]={b=96,s=19,d=28235,c=AUCT_CLAS_WEAPON},  -- Primitive Bow
	[12450]={b=6000,s=1500,d=22634,x=20},  -- Juju Flurry
	[12451]={b=6000,s=1500,d=22636,x=20},  -- Juju Power
	[12455]={b=6000,s=1500,d=22639,x=20},  -- Juju Ember
	[12457]={b=6000,s=1500,d=22641,x=20},  -- Juju Chill
	[12458]={b=6000,s=1500,d=22642,x=20},  -- Juju Guile
	[12459]={b=6000,s=1500,d=22634,x=20},  -- Juju Escape
	[12460]={b=6000,s=1500,d=22643,x=20},  -- Juju Might
	[12462]={b=101370,s=20274,d=28272,c=AUCT_CLAS_ARMOR},  -- Embrace of the Wind Serpent
	[12463]={b=212231,s=42446,d=20198,c=AUCT_CLAS_WEAPON},  -- Drakefang Butcher
	[12464]={b=42601,s=8520,d=28680,c=AUCT_CLAS_ARMOR},  -- Bloodfire Talons
	[12465]={b=51309,s=10261,d=22989,c=AUCT_CLAS_ARMOR},  -- Nightfall Drape
	[12466]={b=34327,s=6865,d=28190,c=AUCT_CLAS_ARMOR},  -- Dawnspire Cord
	[12467]={b=0,s=0,d=6504},  -- Alien Egg
	[12470]={b=43922,s=8784,d=22656,c=AUCT_CLAS_ARMOR},  -- Sandstalker Ankleguards
	[12472]={b=0,s=0,d=7841},  -- Krakle's Thermometer
	[12522]={b=910,s=182,d=28077,c=AUCT_CLAS_ARMOR},  -- Bingles' Flying Gloves
	[12524]={b=0,s=0,d=22716},  -- Blue-feathered Amulet
	[12525]={b=0,s=0,d=9151},  -- Jaron's Supplies
	[12527]={b=176662,s=35332,d=21952,c=AUCT_CLAS_WEAPON},  -- Ribsplitter
	[12528]={b=189165,s=37833,d=28673,c=AUCT_CLAS_WEAPON},  -- The Judge's Gavel
	[12529]={b=6000,s=1500,d=22717},  -- Smolderweb Carrier
	[12530]={b=0,s=0,d=18047,q=20,x=20},  -- Spire Spider Egg
	[12531]={b=144416,s=28883,d=22721,c=AUCT_CLAS_WEAPON},  -- Searing Needle
	[12532]={b=242506,s=48501,d=22722,c=AUCT_CLAS_WEAPON},  -- Spire of the Stoneshaper
	[12533]={b=0,s=0,d=18125},  -- Roughshod Pike
	[12534]={b=0,s=0,d=9666},  -- Omokk's Head
	[12535]={b=174629,s=34925,d=22733,c=AUCT_CLAS_WEAPON},  -- Doomforged Straightedge
	[12542]={b=61781,s=12356,d=26053,c=AUCT_CLAS_ARMOR},  -- Funeral Pyre Vestment
	[12543]={b=28625,s=7156,d=9837,c=AUCT_CLAS_ARMOR},  -- Songstone of Ironforge
	[12544]={b=29630,s=7407,d=9837,c=AUCT_CLAS_ARMOR},  -- Thrall's Resolve
	[12545]={b=28330,s=7082,d=9837,c=AUCT_CLAS_ARMOR},  -- Eye of Orgrimmar
	[12546]={b=37316,s=7463,d=28637,c=AUCT_CLAS_ARMOR},  -- Aristocratic Cuffs
	[12547]={b=52596,s=10519,d=28797,c=AUCT_CLAS_ARMOR},  -- Mar Alom's Grip
	[12548]={b=28410,s=7102,d=9837,c=AUCT_CLAS_ARMOR},  -- Magni's Will
	[12549]={b=68349,s=13669,d=15501,c=AUCT_CLAS_ARMOR},  -- Braincage
	[12550]={b=32324,s=6464,d=28824,c=AUCT_CLAS_ARMOR},  -- Runed Golem Shackles
	[12551]={b=57972,s=11594,d=28695,c=AUCT_CLAS_ARMOR},  -- Stoneshield Cloak
	[12552]={b=54901,s=10980,d=23111,c=AUCT_CLAS_ARMOR},  -- Blisterbane Wrap
	[12553]={b=88496,s=17699,d=28670,c=AUCT_CLAS_ARMOR},  -- Swiftwalker Boots
	[12554]={b=47373,s=9474,d=28771,c=AUCT_CLAS_ARMOR},  -- Hands of the Exalted Herald
	[12555]={b=57032,s=11406,d=27829,c=AUCT_CLAS_ARMOR},  -- Battlechaser's Greaves
	[12556]={b=71585,s=14317,d=22779,c=AUCT_CLAS_ARMOR},  -- High Priestess Boots
	[12557]={b=71841,s=14368,d=28727,c=AUCT_CLAS_ARMOR},  -- Ebonsteel Spaulders
	[12558]={b=0,s=0,d=22765,c=AUCT_CLAS_QUEST},  -- Blue-feathered Necklace
	[12562]={b=0,s=0,d=3331,c=AUCT_CLAS_WRITTEN},  -- Important Blackrock Documents
	[12563]={b=0,s=0,d=5567,c=AUCT_CLAS_QUEST},  -- Warlord Goretooth's Command
	[12564]={b=0,s=0,d=22771,c=AUCT_CLAS_QUEST},  -- Assassination Note
	[12565]={b=0,s=0,d=20629},  -- Winna's Kitten Carrier
	[12566]={b=0,s=0,d=21673},  -- Hardened Flasket
	[12567]={b=0,s=0,d=22785},  -- Filled Flasket
	[12582]={b=255997,s=51199,d=28789,c=AUCT_CLAS_WEAPON},  -- Keris of Zul'Serak
	[12583]={b=371731,s=74346,d=22792,c=AUCT_CLAS_WEAPON},  -- Blackhand Doomsaw
	[12584]={b=152362,s=30472,d=27090,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Longsword
	[12586]={b=0,s=0,d=22793,q=50,x=50},  -- Immature Venom Sac
	[12587]={b=105159,s=21031,d=22794,c=AUCT_CLAS_ARMOR},  -- Eye of Rend
	[12588]={b=127233,s=25446,d=22795,c=AUCT_CLAS_ARMOR},  -- Bonespike Shoulder
	[12589]={b=51257,s=10251,d=21796,c=AUCT_CLAS_ARMOR},  -- Dustfeather Sash
	[12590]={b=378124,s=75624,d=25613,c=AUCT_CLAS_WEAPON},  -- Felstriker
	[12592]={b=476207,s=95241,d=22906,c=AUCT_CLAS_WEAPON},  -- Blackblade of Shahram
	[12602]={b=176064,s=35212,d=23419,c=AUCT_CLAS_WEAPON},  -- Draconian Deflector
	[12603]={b=125244,s=25048,d=8725,c=AUCT_CLAS_ARMOR},  -- Nightbrace Tunic
	[12604]={b=71844,s=14368,d=22833,c=AUCT_CLAS_ARMOR},  -- Starfire Tiara
	[12605]={b=145533,s=29106,d=24107,c=AUCT_CLAS_WEAPON},  -- Serpentine Skuller
	[12606]={b=63340,s=12668,d=22837,c=AUCT_CLAS_ARMOR},  -- Crystallized Girdle
	[12607]={b=32195,s=8048,d=22838,x=20},  -- Brilliant Chromatic Scale
	[12608]={b=55132,s=11026,d=28693,c=AUCT_CLAS_ARMOR},  -- Butcher's Apron
	[12609]={b=102494,s=20498,d=22843,c=AUCT_CLAS_ARMOR},  -- Polychromatic Visionwrap
	[12610]={b=61238,s=12247,d=23490,c=AUCT_CLAS_ARMOR},  -- Runic Plate Shoulders
	[12611]={b=61468,s=12293,d=23486,c=AUCT_CLAS_ARMOR},  -- Runic Plate Boots
	[12612]={b=64783,s=12956,d=23491,c=AUCT_CLAS_ARMOR},  -- Runic Plate Helm
	[12613]={b=91025,s=18205,d=19730,c=AUCT_CLAS_ARMOR},  -- Runic Breastplate
	[12614]={b=91363,s=18272,d=23485,c=AUCT_CLAS_ARMOR},  -- Runic Plate Leggings
	[12618]={b=119863,s=23972,d=25746,c=AUCT_CLAS_ARMOR},  -- Enchanted Thorium Breastplate
	[12619]={b=120290,s=24058,d=22882,c=AUCT_CLAS_ARMOR},  -- Enchanted Thorium Leggings
	[12620]={b=86225,s=17245,d=22886,c=AUCT_CLAS_ARMOR},  -- Enchanted Thorium Helm
	[12621]={b=225425,s=45085,d=22885,c=AUCT_CLAS_WEAPON},  -- Demonfork
	[12622]={b=0,s=0,d=2599,q=10,x=10},  -- Shardtooth Meat
	[12623]={b=0,s=0,d=2599,q=10,x=10},  -- Chillwind Meat
	[12624]={b=103212,s=20642,d=25754,c=AUCT_CLAS_ARMOR},  -- Wildthorn Mail
	[12626]={b=45956,s=9191,d=14618,c=AUCT_CLAS_ARMOR},  -- Funeral Cuffs
	[12627]={b=0,s=0,d=6338},  -- Temporal Displacer
	[12628]={b=83203,s=16640,d=22892,c=AUCT_CLAS_ARMOR},  -- Demon Forged Breastplate
	[12630]={b=0,s=0,d=1310},  -- Head of Rend Blackhand
	[12631]={b=44598,s=8919,d=25747,c=AUCT_CLAS_ARMOR},  -- Fiery Plate Gauntlets
	[12632]={b=70498,s=14099,d=25835,c=AUCT_CLAS_ARMOR},  -- Storm Gauntlets
	[12633]={b=74299,s=14859,d=22901,c=AUCT_CLAS_ARMOR},  -- Whitesoul Helm
	[12634]={b=76552,s=15310,d=22907,c=AUCT_CLAS_ARMOR},  -- Chiselbrand Girdle
	[12635]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- Simple Parchment
	[12636]={b=121428,s=24285,d=22908,c=AUCT_CLAS_ARMOR},  -- Helm of the Great Chief
	[12637]={b=51582,s=10316,d=22910,c=AUCT_CLAS_ARMOR},  -- Backusarian Gauntlets
	[12638]={b=0,s=0,d=22911,q=20,x=20},  -- Andorhal Watch
	[12639]={b=76359,s=15271,d=25750,c=AUCT_CLAS_ARMOR},  -- Stronghold Gauntlets
	[12640]={b=109471,s=21894,d=22920,c=AUCT_CLAS_ARMOR},  -- Lionheart Helm
	[12641]={b=219182,s=43836,d=25748,c=AUCT_CLAS_ARMOR},  -- Invulnerable Mail
	[12642]={b=0,s=0,d=1695},  -- Cleansed Infernal Orb
	[12643]={b=300,s=75,d=24687,x=20},  -- Dense Weightstone
	[12644]={b=800,s=200,d=24682,x=20},  -- Dense Grinding Stone
	[12645]={b=2000,s=500,d=22924,x=5},  -- Thorium Shield Spike
	[12646]={b=0,s=0,d=7393},  -- Infus Emerald
	[12647]={b=0,s=0,d=4777},  -- Felhas Ruby
	[12648]={b=0,s=0,d=7045},  -- Imprisoned Felhound Spirit
	[12649]={b=0,s=0,d=6851},  -- Imprisoned Infernal Spirit
	[12650]={b=0,s=0,d=22926},  -- Attuned Dampener
	[12651]={b=180279,s=36055,d=22929,c=AUCT_CLAS_WEAPON},  -- Blackcrow
	[12652]={b=0,s=0,d=7649},  -- Bijou's Reconnaissance Report
	[12653]={b=181593,s=36318,d=28813,c=AUCT_CLAS_WEAPON},  -- Riphook
	[12654]={b=250,s=62,d=22931,x=200,c=AUCT_CLAS_WEAPON},  -- Doomshot
	[12655]={b=2000,s=500,d=22445,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT},  -- Enchanted Thorium Bar
	[12662]={b=2400,s=600,d=22952,x=20,u=AUCT_TYPE_TAILOR},  -- Demonic Rune
	[12663]={b=0,s=0,d=22953},  -- Glyphed Oaken Branch
	[12682]={b=12000,s=3000,d=15274},  -- Plans: Thorium Armor
	[12683]={b=12000,s=3000,d=15274},  -- Plans: Thorium Belt
	[12684]={b=12000,s=3000,d=15274},  -- Plans: Thorium Bracers
	[12685]={b=12000,s=3000,d=15274},  -- Plans: Radiant Belt
	[12687]={b=12000,s=3000,d=1102},  -- Plans: Imperial Plate Shoulders
	[12688]={b=12000,s=3000,d=1102},  -- Plans: Imperial Plate Belt
	[12689]={b=14000,s=3500,d=15274},  -- Plans: Radiant Breastplate
	[12690]={b=12000,s=3000,d=1102},  -- Plans: Imperial Plate Bracers
	[12691]={b=16000,s=4000,d=1102},  -- Plans: Wildthorn Mail
	[12692]={b=16000,s=4000,d=15274},  -- Plans: Thorium Shield Spike
	[12693]={b=20000,s=5000,d=15274},  -- Plans: Thorium Boots
	[12694]={b=20000,s=5000,d=15274},  -- Plans: Thorium Helm
	[12695]={b=20000,s=5000,d=15274},  -- Plans: Radiant Gloves
	[12696]={b=20000,s=5000,d=1102},  -- Plans: Demon Forged Breastplate
	[12697]={b=22000,s=5500,d=15274},  -- Plans: Radiant Boots
	[12699]={b=20000,s=5000,d=1102},  -- Plans: Fiery Plate Gauntlets
	[12700]={b=25000,s=6250,d=1102},  -- Plans: Imperial Plate Boots
	[12701]={b=25000,s=6250,d=1102},  -- Plans: Imperial Plate Helm
	[12702]={b=25000,s=6250,d=15274},  -- Plans: Radiant Circlet
	[12703]={b=40000,s=10000,d=1102},  -- Plans: Storm Gauntlets
	[12704]={b=30000,s=7500,d=15274},  -- Plans: Thorium Leggings
	[12705]={b=30000,s=7500,d=1102},  -- Plans: Imperial Plate Chest
	[12707]={b=30000,s=7500,d=1102},  -- Plans: Runic Plate Boots
	[12708]={b=0,s=0,d=11449},  -- Crossroads' Supply Crates
	[12709]={b=289956,s=57991,d=22977,c=AUCT_CLAS_WEAPON},  -- Finkle's Skinner
	[12710]={b=0,s=0,d=22979},  -- Glowing Hunk of the Beast's Flesh
	[12711]={b=40000,s=10000,d=1102},  -- Plans: Whitesoul Helm
	[12712]={b=0,s=0,d=15794},  -- Warosh's Mojo
	[12713]={b=40000,s=10000,d=15274},  -- Plans: Radiant Leggings
	[12715]={b=40000,s=10000,d=1102},  -- Plans: Imperial Plate Leggings
	[12716]={b=60000,s=15000,d=1102},  -- Plans: Helm of the Great Chief
	[12717]={b=60000,s=15000,d=1102},  -- Plans: Lionheart Helm
	[12718]={b=60000,s=15000,d=1102},  -- Plans: Runic Breastplate
	[12719]={b=60000,s=15000,d=1102},  -- Plans: Runic Plate Leggings
	[12721]={b=0,s=0,d=23713},  -- Good Luck Half-Charm
	[12722]={b=0,s=0,d=23714},  -- Good Luck Other-Half-Charm
	[12723]={b=0,s=0,d=23715},  -- Good Luck Charm
	[12724]={b=0,s=0,d=23146},  -- Janice's Parcel
	[12725]={b=60000,s=15000,d=6270},  -- Plans: Enchanted Thorium Helm
	[12726]={b=60000,s=15000,d=6270},  -- Plans: Enchanted Thorium Leggings
	[12727]={b=60000,s=15000,d=6270},  -- Plans: Enchanted Thorium Breastplate
	[12728]={b=80000,s=20000,d=1102},  -- Plans: Invulnerable Mail
	[12730]={b=0,s=0,d=4110,c=AUCT_CLAS_WRITTEN},  -- Warosh's Scroll
	[12731]={b=0,s=0,d=23150},  -- Pristine Hide of the Beast
	[12732]={b=0,s=0,d=19497,q=20,x=20},  -- Incendia Agave
	[12733]={b=0,s=0,d=1116},  -- Sacred Frostsaber Meat
	[12734]={b=0,s=0,d=7403,q=10,x=10},  -- Enchanted Scarlet Thread
	[12735]={b=0,s=0,d=21416,q=20,x=20},  -- Frayed Abomination Stitching
	[12736]={b=0,s=0,d=21473,q=10,x=10},  -- Frostwhisper's Embalming Fluid
	[12737]={b=0,s=0,d=1442,q=20,x=20},  -- Gloom Weed
	[12738]={b=0,s=0,d=13290},  -- Dalson Outhouse Key
	[12739]={b=0,s=0,d=21807},  -- Dalson Cabinet Key
	[12740]={b=0,s=0,d=20220},  -- Fifth Mosh'aru Tablet
	[12741]={b=0,s=0,d=22484},  -- Sixth Mosh'aru Tablet
	[12752]={b=114539,s=22907,d=23197,c=AUCT_CLAS_ARMOR},  -- Cap of the Scarlet Savant
	[12753]={b=0,s=0,d=19316,q=10,x=10},  -- Skin of Shadow
	[12756]={b=175287,s=35057,d=23199,c=AUCT_CLAS_ARMOR},  -- Leggings of Arcana
	[12757]={b=175964,s=35192,d=23200,c=AUCT_CLAS_ARMOR},  -- Breastplate of Bloodthirst
	[12765]={b=0,s=0,d=23201,c=AUCT_CLAS_WRITTEN},  -- Secret Note #1
	[12766]={b=0,s=0,d=23201,c=AUCT_CLAS_WRITTEN},  -- Secret Note #2
	[12768]={b=0,s=0,d=23201,c=AUCT_CLAS_WRITTEN},  -- Secret Note #3
	[12770]={b=0,s=0,d=23229},  -- Bijou's Information
	[12771]={b=0,s=0,d=22429,c=AUCT_CLAS_QUEST},  -- Empty Firewater Flask
	[12773]={b=165399,s=33079,d=23234,c=AUCT_CLAS_WEAPON},  -- Ornate Thorium Handaxe
	[12774]={b=180220,s=36044,d=23236,c=AUCT_CLAS_WEAPON},  -- Dawn's Edge
	[12775]={b=199746,s=39949,d=23434,c=AUCT_CLAS_WEAPON},  -- Huge Thorium Battleaxe
	[12776]={b=240624,s=48124,d=23240,c=AUCT_CLAS_WEAPON},  -- Enchanted Battlehammer
	[12777]={b=193242,s=38648,d=23241,c=AUCT_CLAS_WEAPON},  -- Blazing Rapier
	[12780]={b=0,s=0,d=16161,c=AUCT_CLAS_QUEST},  -- General Drakkisath's Command
	[12781]={b=213605,s=42721,d=23244,c=AUCT_CLAS_WEAPON},  -- Serenity
	[12782]={b=284042,s=56808,d=24255,c=AUCT_CLAS_WEAPON},  -- Corruption
	[12783]={b=291079,s=58215,d=23248,c=AUCT_CLAS_WEAPON},  -- Heartseeker
	[12784]={b=365181,s=73036,d=23904,c=AUCT_CLAS_WEAPON},  -- Arcanite Reaper
	[12785]={b=0,s=0,d=3116},  -- Incendia Powder
	[12790]={b=373098,s=74619,d=24813,c=AUCT_CLAS_WEAPON},  -- Arcanite Champion
	[12791]={b=197059,s=39411,d=23262,c=AUCT_CLAS_WEAPON},  -- Barman Shanker
	[12792]={b=196279,s=39255,d=23267,c=AUCT_CLAS_WEAPON},  -- Volcanic Hammer
	[12793]={b=82691,s=16538,d=23266,c=AUCT_CLAS_ARMOR},  -- Mixologist's Tunic
	[12794]={b=281520,s=56304,d=7438,c=AUCT_CLAS_WEAPON},  -- Masterwork Stormhammer
	[12796]={b=354564,s=70912,d=25047,c=AUCT_CLAS_WEAPON},  -- Hammer of the Titans
	[12797]={b=284716,s=56943,d=23274,c=AUCT_CLAS_WEAPON},  -- Frostguard
	[12798]={b=285752,s=57150,d=28849,c=AUCT_CLAS_WEAPON},  -- Annihilator
	[12799]={b=28000,s=7000,d=6496,x=20},  -- Large Opal
	[12800]={b=40000,s=10000,d=4775,x=20},  -- Azerothian Diamond
	[12803]={b=2000,s=500,d=23285,x=10,u=AUCT_TYPE_LEATHER},  -- Living Essence
	[12804]={b=8000,s=2000,d=23286,x=20},  -- Powerful Mojo
	[12806]={b=0,s=0,d=23289},  -- Unforged Rune Covered Breastplate
	[12807]={b=0,s=0,d=6748},  -- Scourge Banner
	[12808]={b=4000,s=1000,d=23291,x=10},  -- Essence of Undeath
	[12809]={b=40000,s=10000,d=21072,x=20},  -- Guardian Stone
	[12810]={b=2000,s=500,d=23292,x=10},  -- Enchanted Leather
	[12811]={b=80000,s=20000,d=23293,x=20},  -- Righteous Orb
	[12812]={b=0,s=0,d=23294},  -- Unfired Plate Gauntlets
	[12813]={b=0,s=0,d=1288},  -- Flask of Mystery Goo
	[12814]={b=0,s=0,d=18080},  -- Flame in a Bottle
	[12815]={b=0,s=0,d=23295},  -- Beacon Torch
	[12819]={b=16000,s=4000,d=1102},  -- Plans: Ornate Thorium Handaxe
	[12820]={b=0,s=0,d=15787,q=10,x=10},  -- Winterfall Firewater
	[12821]={b=16000,s=4000,d=1102},  -- Plans: Dawn's Edge
	[12822]={b=0,s=0,d=2885,q=20,x=20},  -- Toxic Horror Droplet
	[12823]={b=20000,s=5000,d=1102},  -- Plans: Huge Thorium Battleaxe
	[12824]={b=20000,s=5000,d=15274},  -- Plans: Enchanted Battlehammer
	[12825]={b=20000,s=5000,d=15274},  -- Plans: Blazing Rapier
	[12827]={b=20000,s=5000,d=15274},  -- Plans: Serenity
	[12828]={b=22000,s=5500,d=15274},  -- Plans: Volcanic Hammer
	[12829]={b=0,s=0,d=7918},  -- Winterfall Crate
	[12830]={b=22000,s=5500,d=1102},  -- Plans: Corruption
	[12833]={b=80000,s=20000,d=1102},  -- Plans: Hammer of the Titans
	[12834]={b=80000,s=20000,d=1102},  -- Plans: Arcanite Champion
	[12835]={b=80000,s=20000,d=1102},  -- Plans: Annihilator
	[12836]={b=80000,s=20000,d=1102},  -- Plans: Frostguard
	[12837]={b=80000,s=20000,d=1102},  -- Plans: Masterwork Stormhammer
	[12838]={b=80000,s=20000,d=1102},  -- Plans: Arcanite Reaper
	[12839]={b=80000,s=20000,d=1102},  -- Plans: Heartseeker
	[12840]={b=0,s=0,d=23722,q=250,x=250},  -- Minion's Scourgestone
	[12841]={b=0,s=0,d=23720,q=250,x=250},  -- Invader's Scourgestone
	[12842]={b=0,s=0,d=1155,c=AUCT_CLAS_QUEST},  -- Crudely-written Log
	[12843]={b=0,s=0,d=23721,q=250,x=250},  -- Corruptor's Scourgestone
	[12844]={b=0,s=0,d=23717,q=500,x=500},  -- Argent Dawn Valor Token
	[12845]={b=0,s=0,d=9857},  -- Medallion of Faith
	[12846]={b=0,s=0,d=23716,c=AUCT_CLAS_ARMOR},  -- Argent Dawn Commission
	[12847]={b=0,s=0,d=23315},  -- Soul Stained Pike
	[12848]={b=0,s=0,d=23315},  -- Blood Stained Pike
	[12849]={b=0,s=0,d=20342},  -- Demon Kissed Sack
	[12871]={b=32195,s=8048,d=23332},  -- Chromatic Carapace
	[12884]={b=0,s=0,d=23358},  -- Arnak's Hoof
	[12885]={b=0,s=0,d=2622},  -- Pamela's Doll
	[12886]={b=0,s=0,d=23370},  -- Pamela's Doll's Head
	[12887]={b=0,s=0,d=23371},  -- Pamela's Doll's Left Side
	[12888]={b=0,s=0,d=23371},  -- Pamela's Doll's Right Side
	[12891]={b=0,s=0,d=23383},  -- Jaron's Pick
	[12894]={b=0,s=0,d=224},  -- Joseph's Wedding Ring
	[12895]={b=147308,s=29461,d=28335,c=AUCT_CLAS_ARMOR},  -- Breastplate of the Chromatic Flight
	[12896]={b=0,s=0,d=23398},  -- First Relic Fragment
	[12897]={b=0,s=0,d=23398},  -- Second Relic Fragment
	[12898]={b=0,s=0,d=23398},  -- Third Relic Fragment
	[12899]={b=0,s=0,d=23398},  -- Fourth Relic Fragment
	[12900]={b=0,s=0,d=1103,c=AUCT_CLAS_WRITTEN},  -- Annals of Darrowshire
	[12903]={b=227412,s=45482,d=23473,c=AUCT_CLAS_ARMOR},  -- Legguards of the Chromatic Defier
	[12905]={b=68165,s=13633,d=28605,c=AUCT_CLAS_ARMOR},  -- Wildfire Cape
	[12906]={b=0,s=0,d=2357},  -- Purified Moonwell Water
	[12907]={b=0,s=0,d=18059},  -- Corrupt Moonwell Water
	[12922]={b=0,s=0,d=18057},  -- Empty Canteen
	[12923]={b=0,s=0,d=23432},  -- Awbee's Scale
	[12924]={b=0,s=0,d=6623,q=5,x=5},  -- Ritual Candle
	[12925]={b=0,s=0,d=23436},  -- Arikara Serpent Skin
	[12926]={b=59630,s=14907,d=23435,c=AUCT_CLAS_ARMOR},  -- Flaming Band
	[12927]={b=95745,s=19149,d=28630,c=AUCT_CLAS_ARMOR},  -- Truestrike Shoulders
	[12928]={b=0,s=0,d=23440},  -- Umi's Mechanical Yeti
	[12929]={b=78585,s=19646,d=9658,c=AUCT_CLAS_ARMOR},  -- Emberfury Talisman
	[12930]={b=40000,s=10000,d=8232,c=AUCT_CLAS_ARMOR},  -- Briarwood Reed
	[12935]={b=115982,s=23196,d=28625,c=AUCT_CLAS_ARMOR},  -- Warmaster Legguards
	[12936]={b=58203,s=11640,d=22752,c=AUCT_CLAS_ARMOR},  -- Battleborn Armbraces
	[12938]={b=0,s=0,d=15788,q=20,x=20},  -- Blood of Heroes
	[12939]={b=301818,s=60363,d=25647,c=AUCT_CLAS_WEAPON},  -- Dal'Rend's Tribal Guardian
	[12940]={b=274063,s=54812,d=25648,c=AUCT_CLAS_WEAPON},  -- Dal'Rend's Sacred Charge
	[12942]={b=0,s=0,d=23458},  -- Panther Cage Key
	[12945]={b=212825,s=42565,d=23473,c=AUCT_CLAS_ARMOR},  -- Legplates of the Chromatic Defier
	[12946]={b=0,s=0,d=23475},  -- Hypercapacitor Gizmo
	[12952]={b=71682,s=14336,d=23519,c=AUCT_CLAS_ARMOR},  -- Skull of Gyth
	[12953]={b=107923,s=21584,d=15327,c=AUCT_CLAS_ARMOR},  -- Dragoneye Coif
	[12954]={b=0,s=0,d=1134},  -- Davil's Libram
	[12955]={b=0,s=0,d=23521},  -- Redpath's Shield
	[12956]={b=0,s=0,d=23527},  -- Skull of Horgus
	[12957]={b=0,s=0,d=23526},  -- Shattered Sword of Marduk
	[12958]={b=50000,s=12500,d=1301},  -- Recipe: Transmute Arcanite
	[12960]={b=85626,s=17125,d=23544,c=AUCT_CLAS_ARMOR},  -- Tribal War Feathers
	[12963]={b=138586,s=27717,d=23547,c=AUCT_CLAS_ARMOR},  -- Blademaster Leggings
	[12964]={b=166942,s=33388,d=23548,c=AUCT_CLAS_ARMOR},  -- Tristam Legguards
	[12965]={b=111721,s=22344,d=23551,c=AUCT_CLAS_ARMOR},  -- Spiritshroud Leggings
	[12966]={b=70092,s=14018,d=23552,c=AUCT_CLAS_ARMOR},  -- Blackmist Armguards
	[12967]={b=84420,s=16884,d=23553,c=AUCT_CLAS_ARMOR},  -- Bloodmoon Cloak
	[12968]={b=84740,s=16948,d=23554,c=AUCT_CLAS_ARMOR},  -- Frostweaver Cape
	[12969]={b=354420,s=70884,d=23557,c=AUCT_CLAS_WEAPON},  -- Seeping Willow
	[12973]={b=0,s=0,d=23562},  -- Scarlet Cannonball
	[12974]={b=30525,s=6105,d=28676,c=AUCT_CLAS_WEAPON},  -- The Black Knight
	[12975]={b=11026,s=2205,d=28804,c=AUCT_CLAS_WEAPON},  -- Prospector Axe
	[12976]={b=8852,s=1770,d=8272,c=AUCT_CLAS_WEAPON},  -- Ironpatch Blade
	[12977]={b=1776,s=355,d=16642,c=AUCT_CLAS_ARMOR},  -- Magefist Gloves
	[12978]={b=2674,s=534,d=28448,c=AUCT_CLAS_ARMOR},  -- Stormbringer Belt
	[12979]={b=3086,s=617,d=28661,c=AUCT_CLAS_ARMOR},  -- Firebane Cloak
	[12982]={b=4254,s=850,d=28452,c=AUCT_CLAS_ARMOR},  -- Silver-linked Footguards
	[12983]={b=11813,s=2362,d=28809,c=AUCT_CLAS_WEAPON},  -- Rakzur Club
	[12984]={b=7114,s=1422,d=28738,c=AUCT_CLAS_WEAPON},  -- Skycaller
	[12985]={b=4615,s=1153,d=28812,c=AUCT_CLAS_ARMOR},  -- Ring of Defense
	[12987]={b=4533,s=906,d=28648,c=AUCT_CLAS_ARMOR},  -- Darkweave Breeches
	[12988]={b=5687,s=1137,d=28375,c=AUCT_CLAS_ARMOR},  -- Starsight Tunic
	[12989]={b=14271,s=2854,d=28758,c=AUCT_CLAS_WEAPON},  -- Gargoyle's Bite
	[12990]={b=12946,s=2589,d=28810,c=AUCT_CLAS_WEAPON},  -- Razor's Edge
	[12992]={b=16302,s=3260,d=20071,c=AUCT_CLAS_WEAPON},  -- Searing Blade
	[12994]={b=3939,s=787,d=27778,c=AUCT_CLAS_ARMOR},  -- Thorbia's Gauntlets
	[12996]={b=6110,s=1527,d=24646,c=AUCT_CLAS_ARMOR},  -- Band of Purification
	[12997]={b=9600,s=1920,d=28811,c=AUCT_CLAS_WEAPON},  -- Redbeard Crest
	[12998]={b=5103,s=1020,d=28651,c=AUCT_CLAS_ARMOR},  -- Magician's Mantle
	[12999]={b=4267,s=853,d=28370,c=AUCT_CLAS_ARMOR},  -- Drakewing Bands
	[13000]={b=326129,s=65225,d=28701,c=AUCT_CLAS_WEAPON},  -- Staff of Hale Magefire
	[13001]={b=42594,s=10648,d=9833,c=AUCT_CLAS_ARMOR},  -- Maiden's Circle
	[13002]={b=58469,s=14617,d=4841,c=AUCT_CLAS_ARMOR},  -- Lady Alizabeth's Pendant
	[13003]={b=248203,s=49640,d=28794,c=AUCT_CLAS_WEAPON},  -- Lord Alexander's Battle Axe
	[13004]={b=167954,s=33590,d=28631,c=AUCT_CLAS_WEAPON},  -- Torch of Austen
	[13005]={b=6657,s=1331,d=28951,c=AUCT_CLAS_ARMOR},  -- Amy's Blanket
	[13006]={b=274202,s=54840,d=28799,c=AUCT_CLAS_WEAPON},  -- Mass of McGowan
	[13007]={b=67926,s=13585,d=28616,c=AUCT_CLAS_ARMOR},  -- Mageflame Cloak
	[13008]={b=64076,s=12815,d=28646,c=AUCT_CLAS_ARMOR},  -- Dalewind Trousers
	[13009]={b=75839,s=15167,d=28700,c=AUCT_CLAS_ARMOR},  -- Cow King's Hide
	[13010]={b=11207,s=2241,d=28438,c=AUCT_CLAS_ARMOR},  -- Dreamsinger Legguards
	[13011]={b=5155,s=1031,d=28372,c=AUCT_CLAS_ARMOR},  -- Silver-lined Belt
	[13012]={b=6208,s=1241,d=28596,c=AUCT_CLAS_ARMOR},  -- Yorgen Bracers
	[13013]={b=61778,s=12355,d=28643,c=AUCT_CLAS_ARMOR},  -- Elder Wizard's Mantle
	[13014]={b=173526,s=34705,d=25594,c=AUCT_CLAS_WEAPON},  -- Axe of Rin'ji
	[13015]={b=269788,s=53957,d=28748,c=AUCT_CLAS_WEAPON},  -- Serathil
	[13016]={b=23855,s=4771,d=28791,c=AUCT_CLAS_WEAPON},  -- Killmaim
	[13017]={b=86048,s=17209,d=25599,c=AUCT_CLAS_WEAPON},  -- Hellslayer Battle Axe
	[13018]={b=159835,s=31967,d=23228,c=AUCT_CLAS_WEAPON},  -- Executioner's Cleaver
	[13019]={b=23828,s=4765,d=28772,c=AUCT_CLAS_WEAPON},  -- Harpyclaw Short Bow
	[13020]={b=44927,s=8985,d=25602,c=AUCT_CLAS_WEAPON},  -- Skystriker Bow
	[13021]={b=83473,s=16694,d=28801,c=AUCT_CLAS_WEAPON},  -- Needle Threader
	[13022]={b=139952,s=27990,d=28766,c=AUCT_CLAS_WEAPON},  -- Gryphonwing Long Bow
	[13023]={b=213515,s=42703,d=25606,c=AUCT_CLAS_WEAPON},  -- Eaglehorn Long Bow
	[13024]={b=24319,s=4863,d=28671,c=AUCT_CLAS_WEAPON},  -- Beazel's Basher
	[13025]={b=52324,s=10464,d=28706,c=AUCT_CLAS_WEAPON},  -- Deadwood Sledge
	[13026]={b=97208,s=19441,d=28776,c=AUCT_CLAS_WEAPON},  -- Heaven's Light
	[13027]={b=169160,s=33832,d=28689,c=AUCT_CLAS_WEAPON},  -- Bonesnapper
	[13028]={b=263025,s=52605,d=28681,c=AUCT_CLAS_WEAPON},  -- Bludstone Hammer
	[13029]={b=22453,s=5613,d=24122,c=AUCT_CLAS_WEAPON},  -- Umbral Crystal
	[13030]={b=52453,s=13113,d=28647,c=AUCT_CLAS_WEAPON},  -- Basilisk Bone
	[13031]={b=5605,s=1401,d=28803,c=AUCT_CLAS_WEAPON},  -- Orb of Mistmantle
	[13032]={b=20693,s=4138,d=25639,c=AUCT_CLAS_WEAPON},  -- Sword of Corruption
	[13033]={b=40472,s=8094,d=28594,c=AUCT_CLAS_WEAPON},  -- Zealot Blade
	[13034]={b=73551,s=14710,d=28708,c=AUCT_CLAS_WEAPON},  -- Speedsteel Rapier
	[13035]={b=125706,s=25141,d=25640,c=AUCT_CLAS_WEAPON},  -- Serpent Slicer
	[13036]={b=204943,s=40988,d=25641,c=AUCT_CLAS_WEAPON},  -- Assassination Blade
	[13037]={b=23645,s=4729,d=22929,c=AUCT_CLAS_WEAPON},  -- Crystalpine Stinger
	[13038]={b=48150,s=9630,d=25607,c=AUCT_CLAS_WEAPON},  -- Swiftwind
	[13039]={b=89461,s=17892,d=25608,c=AUCT_CLAS_WEAPON},  -- Skull Splitting Crossbow
	[13040]={b=147220,s=29444,d=22929,c=AUCT_CLAS_WEAPON},  -- Heartseeking Crossbow
	[13041]={b=22582,s=4516,d=28768,c=AUCT_CLAS_WEAPON},  -- Guardian Blade
	[13042]={b=87983,s=17596,d=28678,c=AUCT_CLAS_WEAPON},  -- Sword of the Magistrate
	[13043]={b=161949,s=32389,d=28675,c=AUCT_CLAS_WEAPON},  -- Blade of the Titans
	[13044]={b=264000,s=52800,d=28714,c=AUCT_CLAS_WEAPON},  -- Demonslayer
	[13045]={b=54048,s=10809,d=25627,c=AUCT_CLAS_WEAPON},  -- Viscous Hammer
	[13046]={b=175213,s=35042,d=28677,c=AUCT_CLAS_WEAPON},  -- Blanchard's Stout
	[13047]={b=282942,s=56588,d=25626,c=AUCT_CLAS_WEAPON},  -- Twig of the World Tree
	[13048]={b=29858,s=5971,d=25623,c=AUCT_CLAS_WEAPON},  -- Looming Gavel
	[13049]={b=30958,s=6191,d=28707,c=AUCT_CLAS_WEAPON},  -- Deanship Claymore
	[13051]={b=114557,s=22911,d=28598,c=AUCT_CLAS_WEAPON},  -- Witchfury
	[13052]={b=208388,s=41677,d=28624,c=AUCT_CLAS_WEAPON},  -- Warmonger
	[13053]={b=295933,s=59186,d=28717,c=AUCT_CLAS_WEAPON},  -- Doombringer
	[13054]={b=79026,s=15805,d=28764,c=AUCT_CLAS_WEAPON},  -- Grim Reaper
	[13055]={b=146838,s=29367,d=18388,c=AUCT_CLAS_WEAPON},  -- Bonechewer
	[13056]={b=241653,s=48330,d=12562,c=AUCT_CLAS_WEAPON},  -- Frenzied Striker
	[13057]={b=26911,s=5382,d=25630,c=AUCT_CLAS_WEAPON},  -- Bloodpike
	[13058]={b=109167,s=21833,d=28790,c=AUCT_CLAS_WEAPON},  -- Khoo's Point
	[13059]={b=193598,s=38719,d=25633,c=AUCT_CLAS_WEAPON},  -- Stoneraven
	[13060]={b=303923,s=60784,d=28672,c=AUCT_CLAS_WEAPON},  -- The Needler
	[13062]={b=14957,s=2991,d=28633,c=AUCT_CLAS_WEAPON},  -- Thunderwood
	[13063]={b=29258,s=5851,d=28697,c=AUCT_CLAS_WEAPON},  -- Starfaller
	[13064]={b=57435,s=11487,d=28787,c=AUCT_CLAS_WEAPON},  -- Jaina's Firestarter
	[13065]={b=104728,s=20945,d=28626,c=AUCT_CLAS_WEAPON},  -- Wand of Allistarj
	[13066]={b=44989,s=8997,d=28351,c=AUCT_CLAS_ARMOR},  -- Wyrmslayer Spaulders
	[13067]={b=71709,s=14341,d=28355,c=AUCT_CLAS_ARMOR},  -- Hydralick Armor
	[13068]={b=23927,s=4785,d=28362,c=AUCT_CLAS_ARMOR},  -- Obsidian Greaves
	[13070]={b=70437,s=14087,d=28353,c=AUCT_CLAS_ARMOR},  -- Sapphiron's Scale Boots
	[13071]={b=20308,s=4061,d=28354,c=AUCT_CLAS_ARMOR},  -- Plated Fist of Hakoo
	[13072]={b=52134,s=10426,d=28352,c=AUCT_CLAS_ARMOR},  -- Stonegrip Gauntlets
	[13073]={b=45404,s=9080,d=28360,c=AUCT_CLAS_ARMOR},  -- Mugthol's Helm
	[13074]={b=40124,s=8024,d=21961,c=AUCT_CLAS_ARMOR},  -- Golem Shard Leggings
	[13075]={b=110454,s=22090,d=28716,c=AUCT_CLAS_ARMOR},  -- Direwing Legguards
	[13076]={b=23579,s=4715,d=28357,c=AUCT_CLAS_ARMOR},  -- Giantslayer Bracers
	[13077]={b=41132,s=8226,d=28364,c=AUCT_CLAS_ARMOR},  -- Girdle of Uther
	[13079]={b=16798,s=3359,d=28742,c=AUCT_CLAS_WEAPON},  -- Shield of Thorsen
	[13081]={b=35617,s=7123,d=18790,c=AUCT_CLAS_WEAPON},  -- Skullance Shield
	[13082]={b=66175,s=13235,d=25134,c=AUCT_CLAS_WEAPON},  -- Mountainside Buckler
	[13083]={b=173470,s=34694,d=25133,c=AUCT_CLAS_WEAPON},  -- Garrett Family Crest
	[13084]={b=26458,s=6614,d=6497,c=AUCT_CLAS_ARMOR},  -- Kaleidoscope Chain
	[13085]={b=36548,s=9137,d=9657,c=AUCT_CLAS_ARMOR},  -- Horizon Choker
	[13086]={b=10000000,s=0,d=23606},  -- Reins of the Winterspring Frostsaber
	[13087]={b=23584,s=5896,d=9860,c=AUCT_CLAS_ARMOR},  -- River Pride Choker
	[13088]={b=29654,s=7413,d=6522,c=AUCT_CLAS_ARMOR},  -- Gazlowe's Charm
	[13089]={b=32156,s=8039,d=6497,c=AUCT_CLAS_ARMOR},  -- Skibi's Pendant
	[13091]={b=42549,s=10637,d=23717,c=AUCT_CLAS_ARMOR},  -- Medallion of Grand Marshal Morris
	[13093]={b=13524,s=3381,d=28682,c=AUCT_CLAS_ARMOR},  -- Blush Ember Ring
	[13094]={b=10584,s=2646,d=26537,c=AUCT_CLAS_ARMOR},  -- The Queen's Jewel
	[13095]={b=26584,s=6646,d=9834,c=AUCT_CLAS_ARMOR},  -- Assault Band
	[13096]={b=31654,s=7913,d=23629,c=AUCT_CLAS_ARMOR},  -- Band of the Hierophant
	[13097]={b=8658,s=2164,d=9839,c=AUCT_CLAS_ARMOR},  -- Thunderbrow Ring
	[13098]={b=61130,s=15282,d=23608,c=AUCT_CLAS_ARMOR},  -- Painweaver Band
	[13099]={b=7155,s=1431,d=28617,c=AUCT_CLAS_ARMOR},  -- Moccasins of the White Hare
	[13100]={b=27107,s=5421,d=28645,c=AUCT_CLAS_ARMOR},  -- Furen's Boots
	[13101]={b=71592,s=14318,d=28597,c=AUCT_CLAS_ARMOR},  -- Wolfrunner Shoes
	[13102]={b=34399,s=6879,d=28974,c=AUCT_CLAS_ARMOR},  -- Cassandra's Grace
	[13103]={b=17268,s=3453,d=28612,c=AUCT_CLAS_ARMOR},  -- Pads of the Venom Spider
	[13105]={b=10737,s=2147,d=28657,c=AUCT_CLAS_ARMOR},  -- Sutarn's Ring
	[13106]={b=6081,s=1216,d=28656,c=AUCT_CLAS_ARMOR},  -- Glowing Magical Bracelets
	[13107]={b=56457,s=11291,d=28619,c=AUCT_CLAS_ARMOR},  -- Magiskull Cuffs
	[13108]={b=12231,s=2446,d=28614,c=AUCT_CLAS_ARMOR},  -- Tigerstrike Mantle
	[13109]={b=40762,s=8152,d=28609,c=AUCT_CLAS_ARMOR},  -- Blackflame Cape
	[13110]={b=24840,s=4968,d=28368,c=AUCT_CLAS_ARMOR},  -- Wolffear Harness
	[13111]={b=69968,s=13993,d=28664,c=AUCT_CLAS_ARMOR},  -- Sandals of the Insurgent
	[13112]={b=48124,s=9624,d=28601,c=AUCT_CLAS_ARMOR},  -- Winged Helm
	[13113]={b=102730,s=20546,d=28739,c=AUCT_CLAS_ARMOR},  -- Feathermoon Headdress
	[13114]={b=12870,s=2574,d=17031,c=AUCT_CLAS_ARMOR},  -- Troll's Bane Leggings
	[13115]={b=34954,s=6990,d=28745,c=AUCT_CLAS_ARMOR},  -- Sheepshear Mantle
	[13116]={b=96851,s=19370,d=28709,c=AUCT_CLAS_ARMOR},  -- Spaulders of the Unseen
	[13117]={b=19152,s=3830,d=28802,c=AUCT_CLAS_ARMOR},  -- Ogron's Sash
	[13118]={b=53007,s=10601,d=28369,c=AUCT_CLAS_ARMOR},  -- Serpentine Sash
	[13119]={b=15316,s=3063,d=28735,c=AUCT_CLAS_ARMOR},  -- Enchanted Kodo Bracers
	[13120]={b=47526,s=9505,d=28373,c=AUCT_CLAS_ARMOR},  -- Deepfury Bracers
	[13121]={b=17141,s=3428,d=28602,c=AUCT_CLAS_ARMOR},  -- Wing of the Whelping
	[13122]={b=57447,s=11489,d=28652,c=AUCT_CLAS_ARMOR},  -- Dark Phantom Cape
	[13123]={b=166939,s=33387,d=28663,c=AUCT_CLAS_ARMOR},  -- Dreamwalker Armor
	[13124]={b=19981,s=3996,d=28441,c=AUCT_CLAS_ARMOR},  -- Ravasaur Scale Boots
	[13125]={b=64770,s=12954,d=28439,c=AUCT_CLAS_ARMOR},  -- Elven Chain Boots
	[13126]={b=51870,s=10374,d=28434,c=AUCT_CLAS_ARMOR},  -- Battlecaller Gauntlets
	[13127]={b=15107,s=3021,d=28440,c=AUCT_CLAS_ARMOR},  -- Frostreaver Crown
	[13128]={b=52717,s=10543,d=28662,c=AUCT_CLAS_ARMOR},  -- High Bergg Helm
	[13129]={b=38107,s=7621,d=28437,c=AUCT_CLAS_ARMOR},  -- Firemane Leggings
	[13130]={b=125329,s=25065,d=28447,c=AUCT_CLAS_ARMOR},  -- Windrunner Legguards
	[13131]={b=11563,s=2312,d=28444,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Mantle
	[13132]={b=36702,s=7340,d=28443,c=AUCT_CLAS_ARMOR},  -- Skeletal Shoulders
	[13133]={b=115416,s=23083,d=28665,c=AUCT_CLAS_ARMOR},  -- Drakesfire Epaulets
	[13134]={b=38584,s=7716,d=28435,c=AUCT_CLAS_ARMOR},  -- Belt of the Gladiator
	[13135]={b=70008,s=14001,d=28668,c=AUCT_CLAS_ARMOR},  -- Lordly Armguards
	[13136]={b=7280,s=1456,d=21071,c=AUCT_CLAS_WEAPON},  -- Lil Timmy's Peashooter
	[13137]={b=29374,s=5874,d=28786,c=AUCT_CLAS_WEAPON},  -- Ironweaver
	[13138]={b=57661,s=11532,d=28634,c=AUCT_CLAS_WEAPON},  -- The Silencer
	[13139]={b=105149,s=21029,d=28769,c=AUCT_CLAS_WEAPON},  -- Guttbuster
	[13140]={b=0,s=0,d=7827,c=AUCT_CLAS_QUEST},  -- Blood Red Key
	[13141]={b=48373,s=12093,d=9860,c=AUCT_CLAS_ARMOR},  -- Tooth of Gnarr
	[13142]={b=58209,s=11641,d=23628,c=AUCT_CLAS_ARMOR},  -- Brigam Girdle
	[13143]={b=85490,s=21372,d=23629,c=AUCT_CLAS_ARMOR},  -- Mark of the Dragon Lord
	[13144]={b=34327,s=6865,d=28649,c=AUCT_CLAS_ARMOR},  -- Serenity Belt
	[13145]={b=13522,s=2704,d=28356,c=AUCT_CLAS_ARMOR},  -- Enormous Ogre Belt
	[13146]={b=173521,s=34704,d=28743,c=AUCT_CLAS_WEAPON},  -- Shell Launcher Shotgun
	[13148]={b=313145,s=62629,d=25631,c=AUCT_CLAS_WEAPON},  -- Chillpike
	[13155]={b=0,s=0,d=23658,q=20,x=20},  -- Resonating Skull
	[13156]={b=0,s=0,d=2516},  -- Mystic Crystal
	[13157]={b=0,s=0,d=23659,q=20,x=20},  -- Fetid Skull
	[13158]={b=0,s=0,d=1155,c=AUCT_CLAS_WRITTEN},  -- Words of the High Chief
	[13159]={b=0,s=0,d=6371,q=20,x=20},  -- Bone Dust
	[13161]={b=328748,s=65749,d=23673,c=AUCT_CLAS_WEAPON},  -- Trindlehaven Staff
	[13162]={b=52793,s=10558,d=23675,c=AUCT_CLAS_ARMOR},  -- Reiver Claws
	[13163]={b=347688,s=69537,d=23683,c=AUCT_CLAS_WEAPON},  -- Relentless Scythe
	[13164]={b=42158,s=10539,d=6006,c=AUCT_CLAS_ARMOR},  -- Heart of the Scale
	[13166]={b=71024,s=14204,d=23704,c=AUCT_CLAS_ARMOR},  -- Slamshot Shoulders
	[13167]={b=297052,s=59410,d=25180,c=AUCT_CLAS_WEAPON},  -- Fist of Omokk
	[13168]={b=95425,s=19085,d=23559,c=AUCT_CLAS_ARMOR},  -- Plate of the Shaman King
	[13169]={b=119741,s=23948,d=23710,c=AUCT_CLAS_ARMOR},  -- Tressermane Leggings
	[13170]={b=96151,s=19230,d=28713,c=AUCT_CLAS_ARMOR},  -- Skyshroud Leggings
	[13171]={b=28000,s=7000,d=24060,c=AUCT_CLAS_ARMOR},  -- Smokey's Lighter
	[13172]={b=0,s=0,d=11449},  -- Siabi's Premium Tobacco
	[13173]={b=47,s=11,d=23723,x=200,c=AUCT_CLAS_WEAPON},  -- Flightblade Throwing Axe
	[13174]={b=0,s=0,d=23725,q=30,x=30},  -- Plagued Flesh Sample
	[13175]={b=153095,s=30619,d=25603,c=AUCT_CLAS_WEAPON},  -- Voone's Twitchbow
	[13176]={b=0,s=0,d=23726},  -- Scourge Data
	[13177]={b=65585,s=16396,d=6494,c=AUCT_CLAS_ARMOR},  -- Talisman of Evasion
	[13178]={b=55130,s=13782,d=23728,c=AUCT_CLAS_ARMOR},  -- Rosewine Circle
	[13179]={b=74583,s=14916,d=23730,c=AUCT_CLAS_ARMOR},  -- Brazecore Armguards
	[13180]={b=0,s=0,d=23731,q=50,x=50},  -- Stratholme Holy Water
	[13181]={b=43988,s=8797,d=23732,c=AUCT_CLAS_ARMOR},  -- Demonskin Gloves
	[13182]={b=154429,s=30885,d=23734,c=AUCT_CLAS_WEAPON},  -- Phase Blade
	[13183]={b=258857,s=51771,d=24740,c=AUCT_CLAS_WEAPON},  -- Venomspitter
	[13184]={b=68191,s=13638,d=23736,c=AUCT_CLAS_ARMOR},  -- Fallbrush Handgrips
	[13185]={b=82111,s=16422,d=23737,c=AUCT_CLAS_ARMOR},  -- Sunderseer Mantle
	[13186]={b=0,s=0,d=21673},  -- Empty Felstone Field Bottle
	[13187]={b=0,s=0,d=21673},  -- Empty Dalson's Tears Bottle
	[13188]={b=0,s=0,d=21673},  -- Empty Writhing Haunt Bottle
	[13189]={b=0,s=0,d=21673},  -- Empty Gahrron's Withering Bottle
	[13190]={b=0,s=0,d=23739},  -- Filled Felstone Field Bottle
	[13191]={b=0,s=0,d=19547},  -- Filled Dalson's Tears Bottle
	[13192]={b=0,s=0,d=15791},  -- Filled Writhing Haunt Bottle
	[13193]={b=0,s=0,d=22191},  -- Filled Gahrron's Withering Bottle
	[13194]={b=0,s=0,d=23740},  -- Felstone Field Cauldron Key
	[13195]={b=0,s=0,d=23741},  -- Dalson's Tears Cauldron Key
	[13196]={b=0,s=0,d=23741},  -- Gahrron's Withering Cauldron Key
	[13197]={b=0,s=0,d=23740},  -- Writhing Haunt Cauldron Key
	[13198]={b=254256,s=50851,d=23742,c=AUCT_CLAS_WEAPON},  -- Hurd Smasher
	[13199]={b=21994,s=4398,d=28436,c=AUCT_CLAS_ARMOR},  -- Crushridge Bindings
	[13202]={b=0,s=0,d=1103,c=AUCT_CLAS_WRITTEN},  -- Extended Annals of Darrowshire
	[13203]={b=97492,s=19498,d=23747,c=AUCT_CLAS_ARMOR},  -- Armswake Cloak
	[13204]={b=196316,s=39263,d=25619,c=AUCT_CLAS_WEAPON},  -- Bashguuder
	[13205]={b=175155,s=35031,d=23750,c=AUCT_CLAS_WEAPON},  -- Rhombeard Protector
	[13206]={b=99402,s=19880,d=23753,c=AUCT_CLAS_ARMOR},  -- Wolfshear Leggings
	[13207]={b=0,s=0,d=1310},  -- Shadow Lord Fel'dan's Head
	[13208]={b=62602,s=12520,d=23760,c=AUCT_CLAS_ARMOR},  -- Bleak Howler Armguards
	[13209]={b=38462,s=9615,d=23763,c=AUCT_CLAS_ARMOR},  -- Seal of the Dawn
	[13210]={b=90122,s=18024,d=23765,c=AUCT_CLAS_ARMOR},  -- Pads of the Dread Wolf
	[13211]={b=60311,s=12062,d=23769,c=AUCT_CLAS_ARMOR},  -- Slashclaw Bracers
	[13212]={b=42683,s=10670,d=23766,c=AUCT_CLAS_ARMOR},  -- Halycon's Spiked Collar
	[13213]={b=38533,s=9633,d=16209,c=AUCT_CLAS_ARMOR},  -- Smolderweb's Eye
	[13216]={b=66252,s=13250,d=23777,c=AUCT_CLAS_ARMOR},  -- Crown of the Penitent
	[13217]={b=35258,s=8814,d=28830,c=AUCT_CLAS_ARMOR},  -- Band of the Penitent
	[13218]={b=266942,s=53388,d=23791,c=AUCT_CLAS_WEAPON},  -- Fang of the Crystal Spider
	[13243]={b=182578,s=36515,d=25133,c=AUCT_CLAS_WEAPON},  -- Argent Defender
	[13244]={b=60342,s=12068,d=23827,c=AUCT_CLAS_ARMOR},  -- Gilded Gauntlets
	[13245]={b=5323,s=1064,d=23835,c=AUCT_CLAS_WEAPON},  -- Kresh's Back
	[13246]={b=268114,s=53622,d=23836,c=AUCT_CLAS_WEAPON},  -- Argent Avenger
	[13247]={b=23350,s=5837,d=12333},  -- Quartermaster Zigris' Footlocker
	[13248]={b=148349,s=29669,d=8257,c=AUCT_CLAS_WEAPON},  -- Burstshot Harquebus
	[13249]={b=338914,s=67782,d=23837,c=AUCT_CLAS_WEAPON},  -- Argent Crusader
	[13250]={b=0,s=0,d=23842,c=AUCT_CLAS_QUEST},  -- Head of Balnazzar
	[13251]={b=0,s=0,d=23843},  -- Head of Baron Rivendare
	[13252]={b=62170,s=12434,d=23844,c=AUCT_CLAS_ARMOR},  -- Cloudrunner Girdle
	[13253]={b=49916,s=9983,d=23846,c=AUCT_CLAS_ARMOR},  -- Hands of Power
	[13254]={b=107849,s=21569,d=23847,c=AUCT_CLAS_WEAPON},  -- Astral Guard
	[13255]={b=59861,s=11972,d=23849,c=AUCT_CLAS_ARMOR},  -- Trueaim Gauntlets
	[13257]={b=90441,s=18088,d=23852,c=AUCT_CLAS_ARMOR},  -- Demonic Runed Spaulders
	[13258]={b=66715,s=13343,d=23853,c=AUCT_CLAS_ARMOR},  -- Slaghide Gauntlets
	[13259]={b=80348,s=16069,d=23856,c=AUCT_CLAS_ARMOR},  -- Ribsteel Footguards
	[13260]={b=112807,s=22561,d=23861,c=AUCT_CLAS_ARMOR},  -- Wind Dancer Boots
	[13261]={b=41810,s=10452,d=23867,c=AUCT_CLAS_WEAPON},  -- Globe of D'sak
	[13282]={b=68423,s=13684,d=18905,c=AUCT_CLAS_ARMOR},  -- Ogreseer Tower Boots
	[13283]={b=59630,s=14907,d=23435,c=AUCT_CLAS_ARMOR},  -- Magus Ring
	[13284]={b=86560,s=17312,d=23901,c=AUCT_CLAS_ARMOR},  -- Swiftdart Battleboots
	[13285]={b=274624,s=54924,d=23908,c=AUCT_CLAS_WEAPON},  -- The Nicker
	[13286]={b=220533,s=44106,d=23909,c=AUCT_CLAS_WEAPON},  -- Rivenspike
	[13287]={b=2500,s=625,d=1102},  -- Pattern: Raptor Hide Harness
	[13288]={b=2500,s=625,d=1102},  -- Pattern: Raptor Hide Belt
	[13289]={b=0,s=0,d=23914,c=AUCT_CLAS_WEAPON},  -- Egan's Blaster
	[13302]={b=0,s=0,d=4287,q=20,x=20},  -- Market Row Postbox Key
	[13303]={b=0,s=0,d=4287,q=20,x=20},  -- Crusaders' Square Postbox Key
	[13304]={b=0,s=0,d=4287,q=20,x=20},  -- Festival Lane Postbox Key
	[13305]={b=0,s=0,d=4287,q=20,x=20},  -- Elders' Square Postbox Key
	[13306]={b=0,s=0,d=4287,q=20,x=20},  -- King's Square Postbox Key
	[13307]={b=0,s=0,d=4287,q=20,x=20},  -- Fras Siabi's Postbox Key
	[13308]={b=1800,s=450,d=1102},  -- Schematic: Ice Deflector
	[13309]={b=1000,s=250,d=1102},  -- Schematic: Lovingly Crafted Boomstick
	[13310]={b=2000,s=500,d=1102,u=AUCT_TYPE_ENGINEER},  -- Schematic: Accurate Scope
	[13311]={b=10000,s=2500,d=1102},  -- Schematic: Mechanical Dragonling
	[13313]={b=0,s=0,d=1103},  -- Sacred Highborne Writings
	[13314]={b=151110,s=30222,d=24760,c=AUCT_CLAS_ARMOR},  -- Alanna's Embrace
	[13315]={b=45587,s=11396,d=23955,c=AUCT_CLAS_WEAPON},  -- Testament of Hope
	[13317]={b=10000000,s=0,d=17494},  -- Whistle of the Ivory Raptor
	[13320]={b=5000,s=0,d=23982},  -- Arcane Quickener
	[13321]={b=800000,s=0,d=17785},  -- Green Mechanostrider
	[13322]={b=800000,s=0,d=17785},  -- Unpainted Mechanostrider
	[13326]={b=10000000,s=0,d=17785},  -- White Mechanostrider Mod A
	[13327]={b=10000000,s=0,d=17785},  -- Icy Blue Mechanostrider Mod A
	[13328]={b=10000000,s=0,d=17343},  -- Black Ram
	[13329]={b=10000000,s=0,d=17343},  -- Frost Ram
	[13331]={b=800000,s=0,d=17786},  -- Red Skeletal Horse
	[13332]={b=800000,s=0,d=17786},  -- Blue Skeletal Horse
	[13333]={b=800000,s=0,d=17786},  -- Brown Skeletal Horse
	[13334]={b=10000000,s=0,d=17786},  -- Green Skeletal Warhorse
	[13335]={b=1000000,s=250000,d=24011},  -- Deathcharger's Reins
	[13340]={b=82494,s=16498,d=24013,c=AUCT_CLAS_ARMOR},  -- Cape of the Black Baron
	[13344]={b=86053,s=17210,d=29001,c=AUCT_CLAS_ARMOR},  -- Dracorian Gauntlets
	[13345]={b=61830,s=15457,d=24022,c=AUCT_CLAS_ARMOR},  -- Seal of Rivendare
	[13346]={b=115591,s=23118,d=24025,c=AUCT_CLAS_ARMOR},  -- Robes of the Exalted
	[13347]={b=0,s=0,d=6506,c=AUCT_CLAS_ARMOR},  -- Crystal of Zin-Malor
	[13348]={b=363849,s=72769,d=24049,c=AUCT_CLAS_WEAPON},  -- Demonshear
	[13349]={b=292144,s=58428,d=24033,c=AUCT_CLAS_WEAPON},  -- Scepter of the Unholy
	[13350]={b=0,s=0,d=22924},  -- Insignia of the Black Guard
	[13351]={b=0,s=0,d=24036},  -- Crimson Hammersmith's Apron
	[13352]={b=0,s=0,d=24037},  -- Vosh'gajin's Snakestone
	[13353]={b=41810,s=10452,d=24039,c=AUCT_CLAS_WEAPON},  -- Book of the Dead
	[13354]={b=0,s=0,d=24044,q=20,x=20},  -- Ectoplasmic Resonator
	[13356]={b=0,s=0,d=24057,q=20,x=20},  -- Somatic Intensifier
	[13357]={b=0,s=0,d=24058,q=20,x=20},  -- Osseous Agitator
	[13358]={b=105181,s=21036,d=18971,c=AUCT_CLAS_ARMOR},  -- Wyrmtongue Shoulders
	[13359]={b=126683,s=25336,d=24045,c=AUCT_CLAS_ARMOR},  -- Crown of Tyranny
	[13360]={b=282585,s=56517,d=24046,c=AUCT_CLAS_WEAPON},  -- Gift of the Elven Magi
	[13361]={b=283650,s=56730,d=25036,c=AUCT_CLAS_WEAPON},  -- Skullforge Reaver
	[13362]={b=8000,s=2000,d=3024,x=20},  -- Letter from the Front
	[13363]={b=8000,s=2000,d=1301,x=20},  -- Municipal Proclamation
	[13364]={b=8000,s=2000,d=4110,x=20},  -- Fras Siabi's Advertisement
	[13365]={b=8000,s=2000,d=24051,x=20},  -- Town Meeting Notice
	[13366]={b=12000,s=3000,d=24052,x=20},  -- Ingenious Toy
	[13367]={b=0,s=0,d=24053},  -- Wrapped Gift
	[13368]={b=277190,s=55438,d=25614,c=AUCT_CLAS_WEAPON},  -- Bonescraper
	[13369]={b=87634,s=17526,d=24054,c=AUCT_CLAS_ARMOR},  -- Fire Striders
	[13370]={b=0,s=0,d=24059},  -- Vitreous Focuser
	[13371]={b=26630,s=6657,d=24061,c=AUCT_CLAS_WEAPON},  -- Father Flame
	[13372]={b=318845,s=63769,d=24063,c=AUCT_CLAS_WEAPON},  -- Slavedriver's Cane
	[13373]={b=59387,s=14846,d=1225,c=AUCT_CLAS_ARMOR},  -- Band of Flesh
	[13374]={b=71576,s=14315,d=24064,c=AUCT_CLAS_ARMOR},  -- Soulstealer Mantle
	[13375]={b=153284,s=30656,d=23825,c=AUCT_CLAS_WEAPON},  -- Crest of Retribution
	[13376]={b=68693,s=13738,d=24065,c=AUCT_CLAS_ARMOR},  -- Royal Tribunal Cloak
	[13377]={b=30,s=7,d=2418,x=200,c=AUCT_CLAS_WEAPON},  -- Miniature Cannon Balls
	[13378]={b=109860,s=21972,d=24066,c=AUCT_CLAS_ARMOR},  -- Songbird Blouse
	[13379]={b=42939,s=10734,d=2618,c=AUCT_CLAS_ARMOR},  -- Piccolo of the Flaming Fire
	[13380]={b=192216,s=38443,d=18298,c=AUCT_CLAS_WEAPON},  -- Willey's Portable Howitzer
	[13381]={b=77167,s=15433,d=24068,c=AUCT_CLAS_ARMOR},  -- Master Cannoneer Boots
	[13382]={b=43400,s=10850,d=7888,c=AUCT_CLAS_ARMOR},  -- Cannonball Runner
	[13383]={b=134323,s=26864,d=24070,c=AUCT_CLAS_ARMOR},  -- Woollies of the Prancing Minstrel
	[13384]={b=44941,s=8988,d=24071,c=AUCT_CLAS_ARMOR},  -- Rainbow Girdle
	[13385]={b=52950,s=13237,d=24072,c=AUCT_CLAS_WEAPON},  -- Tome of Knowledge
	[13386]={b=81884,s=16376,d=24073,c=AUCT_CLAS_ARMOR},  -- Archivist Cape
	[13387]={b=65749,s=13149,d=24074,c=AUCT_CLAS_ARMOR},  -- Foresight Girdle
	[13388]={b=105586,s=21117,d=25049,c=AUCT_CLAS_ARMOR},  -- The Postmaster's Tunic
	[13389]={b=108730,s=21746,d=25050,c=AUCT_CLAS_ARMOR},  -- The Postmaster's Trousers
	[13390]={b=81837,s=16367,d=24292,c=AUCT_CLAS_ARMOR},  -- The Postmaster's Band
	[13391]={b=82127,s=16425,d=25051,c=AUCT_CLAS_ARMOR},  -- The Postmaster's Treads
	[13392]={b=48846,s=12211,d=24087,c=AUCT_CLAS_ARMOR},  -- The Postmaster's Seal
	[13393]={b=311904,s=62380,d=25629,c=AUCT_CLAS_WEAPON},  -- Malown's Slam
	[13394]={b=90880,s=18176,d=24102,c=AUCT_CLAS_ARMOR},  -- Skul's Cold Embrace
	[13395]={b=57019,s=11403,d=29009,c=AUCT_CLAS_ARMOR},  -- Skul's Fingerbone Claws
	[13396]={b=154265,s=30853,d=24106,c=AUCT_CLAS_WEAPON},  -- Skul's Ghastly Touch
	[13397]={b=76008,s=15201,d=24108,c=AUCT_CLAS_ARMOR},  -- Stoneskin Gargoyle Cape
	[13398]={b=100142,s=20028,d=9653,c=AUCT_CLAS_ARMOR},  -- Boots of the Shrieker
	[13399]={b=231560,s=46312,d=24109,c=AUCT_CLAS_WEAPON},  -- Gargoyle Shredder Talons
	[13400]={b=46482,s=9296,d=24110,c=AUCT_CLAS_ARMOR},  -- Vambraces of the Sadist
	[13401]={b=257201,s=51440,d=24111,c=AUCT_CLAS_WEAPON},  -- The Cruel Hand of Timmy
	[13402]={b=105842,s=21168,d=24112,c=AUCT_CLAS_ARMOR},  -- Timmy's Galoshes
	[13403]={b=47008,s=9401,d=24113,c=AUCT_CLAS_ARMOR},  -- Grimgore Noose
	[13404]={b=79478,s=15895,d=28798,c=AUCT_CLAS_ARMOR},  -- Mask of the Unforgiven
	[13405]={b=65511,s=13102,d=24115,c=AUCT_CLAS_ARMOR},  -- Wailing Nightbane Pauldrons
	[13408]={b=220713,s=44142,d=24119,c=AUCT_CLAS_WEAPON},  -- Soul Breaker
	[13409]={b=40596,s=8119,d=24120,c=AUCT_CLAS_ARMOR},  -- Tearfall Bracers
	[13422]={b=40,s=10,d=24131,x=20},  -- Stonescale Eel
	[13423]={b=500,s=125,d=24132,x=20,u=AUCT_TYPE_ALCHEM},  -- Stonescale Oil
	[13442]={b=2000,s=500,d=19547,x=5,c=AUCT_CLAS_POTION},  -- Mighty Rage Potion
	[13443]={b=1600,s=400,d=24151,x=5,u=AUCT_TYPE_TAILOR},  -- Superior Mana Potion
	[13444]={b=6000,s=1500,d=21672,x=5,u=AUCT_TYPE_TAILOR},  -- Major Mana Potion
	[13445]={b=2000,s=500,d=16321,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Superior Defense
	[13446]={b=4000,s=1000,d=24152,x=5,c=AUCT_CLAS_POTION},  -- Major Healing Potion
	[13447]={b=5000,s=1250,d=24211,x=5,c=AUCT_CLAS_POTION},  -- Elixir of the Sages
	[13448]={b=0,s=0,d=18010},  -- The Deed to Caer Darrow
	[13450]={b=0,s=0,d=24153},  -- The Deed to Southshore
	[13451]={b=0,s=0,d=24154},  -- The Deed to Tarren Mill
	[13452]={b=5000,s=1250,d=16836,x=5,c=AUCT_CLAS_POTION},  -- Elixir of the Mongoose
	[13453]={b=5000,s=1250,d=24212,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Brute Force
	[13454]={b=3000,s=750,d=17898,x=5,c=AUCT_CLAS_POTION},  -- Greater Arcane Elixir
	[13455]={b=3000,s=750,d=17974,x=5,c=AUCT_CLAS_POTION},  -- Greater Stoneshield Potion
	[13456]={b=3000,s=750,d=15794,x=5,c=AUCT_CLAS_POTION},  -- Greater Frost Protection Potion
	[13457]={b=3000,s=750,d=15741,x=5,c=AUCT_CLAS_POTION},  -- Greater Fire Protection Potion
	[13458]={b=3000,s=750,d=23739,x=5,c=AUCT_CLAS_POTION},  -- Greater Nature Protection Potion
	[13459]={b=400,s=100,d=17469,x=5,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_TAILOR},  -- Greater Shadow Protection Potion
	[13461]={b=3000,s=750,d=17403,x=5,c=AUCT_CLAS_POTION},  -- Greater Arcane Protection Potion
	[13462]={b=3000,s=750,d=24156,x=5,c=AUCT_CLAS_POTION},  -- Purification Potion
	[13463]={b=400,s=100,d=24689,x=20},  -- Dreamfoil
	[13464]={b=400,s=100,d=24690,x=20,u=AUCT_TYPE_ALCHEM},  -- Golden Sansam
	[13465]={b=600,s=150,d=24692,x=20,u=AUCT_TYPE_ALCHEM},  -- Mountain Silversage
	[13466]={b=1000,s=250,d=24693,x=20,u=AUCT_TYPE_ALCHEM},  -- Plaguebloom
	[13467]={b=1000,s=250,d=24691,x=20,u=AUCT_TYPE_ALCHEM..", "..AUCT_TYPE_ENCHANT},  -- Icecap
	[13468]={b=4000,s=1000,d=24688,x=20},  -- Black Lotus
	[13469]={b=0,s=0,d=3486},  -- Head of Weldon Barov
	[13470]={b=0,s=0,d=14023},  -- Head of Alexi Barov
	[13471]={b=0,s=0,d=16065},  -- The Deed to Brill
	[13473]={b=28658,s=7164,d=23715,c=AUCT_CLAS_ARMOR},  -- Felstone Good Luck Charm
	[13474]={b=123624,s=24724,d=13060,c=AUCT_CLAS_WEAPON},  -- Farmer Dalson's Shotgun
	[13475]={b=32436,s=8109,d=224,c=AUCT_CLAS_ARMOR},  -- Dalson Family Wedding Ring
	[13476]={b=12000,s=3000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Mighty Rage Potion
	[13477]={b=12000,s=3000,d=1301,u=AUCT_TYPE_TAILOR},  -- Recipe: Superior Mana Potion
	[13478]={b=13000,s=3250,d=1301},  -- Recipe: Elixir of Superior Defense
	[13479]={b=14000,s=3500,d=15274},  -- Recipe: Elixir of the Sages
	[13480]={b=15000,s=3750,d=1301,c=AUCT_CLAS_POTION},  -- Recipe: Major Healing Potion
	[13481]={b=15000,s=3750,d=15274},  -- Recipe: Elixir of Brute Force
	[13482]={b=15000,s=0,d=15274},  -- Recipe: Transmute Air to Fire
	[13483]={b=15000,s=0,d=15274},  -- Recipe: Transmute Fire to Earth
	[13484]={b=15000,s=0,d=15274},  -- Recipe: Transmute Earth to Water
	[13485]={b=15000,s=0,d=15274},  -- Recipe: Transmute Water to Air
	[13486]={b=15000,s=3750,d=15274},  -- Recipe: Transmute Undeath to Water
	[13487]={b=15000,s=3750,d=15274},  -- Recipe: Transmute Water to Undeath
	[13488]={b=15000,s=3750,d=15274},  -- Recipe: Transmute Life to Earth
	[13489]={b=15000,s=3750,d=15274},  -- Recipe: Transmute Earth to Life
	[13490]={b=16000,s=4000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Greater Stoneshield Potion
	[13491]={b=16000,s=4000,d=15274},  -- Recipe: Elixir of the Mongoose
	[13492]={b=20000,s=5000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Purification Potion
	[13493]={b=20000,s=5000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Greater Arcane Elixir
	[13494]={b=24000,s=6000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Greater Fire Protection Potion
	[13495]={b=24000,s=6000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Greater Frost Protection Potion
	[13496]={b=24000,s=6000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Greater Nature Protection Potion
	[13497]={b=24000,s=6000,d=15274,c=AUCT_CLAS_POTION},  -- Recipe: Greater Arcane Protection Potion
	[13498]={b=91372,s=18274,d=24162,c=AUCT_CLAS_ARMOR},  -- Handcrafted Mastersmith Leggings
	[13499]={b=24000,s=6000,d=15274,u=AUCT_TYPE_ENCHANT..", "..AUCT_TYPE_TAILOR},  -- Recipe: Greater Shadow Protection Potion
	[13501]={b=30000,s=7500,d=15274,u=AUCT_TYPE_TAILOR},  -- Recipe: Major Mana Potion
	[13502]={b=59937,s=11987,d=24164,c=AUCT_CLAS_ARMOR},  -- Handcrafted Mastersmith Girdle
	[13503]={b=100000,s=25000,d=3667,c=AUCT_CLAS_ARMOR},  -- Alchemists' Stone
	[13505]={b=456725,s=91345,d=24166,c=AUCT_CLAS_WEAPON},  -- Runeblade of Baron Rivendare
	[13506]={b=20000,s=5000,d=26865,x=5},  -- Flask of Petrification
	[13507]={b=0,s=0,d=7743,c=AUCT_CLAS_WRITTEN},  -- Cliffwatcher Longhorn Report
	[13508]={b=19115,s=4778,d=1504},  -- Eye of Arachnida
	[13509]={b=21573,s=5393,d=7247},  -- Clutch of Foresight
	[13510]={b=20000,s=5000,d=24213,x=5},  -- Flask of the Titans
	[13511]={b=20000,s=5000,d=21531,x=5},  -- Flask of Distilled Wisdom
	[13512]={b=20000,s=5000,d=19547,x=5},  -- Flask of Supreme Power
	[13513]={b=20000,s=5000,d=22191,x=5},  -- Flask of Chromatic Resistance
	[13514]={b=23280,s=5820,d=24169},  -- Wail of the Banshee
	[13515]={b=38400,s=9600,d=1236,c=AUCT_CLAS_ARMOR},  -- Ramstein's Lightning Bolts
	[13518]={b=40000,s=10000,d=15274},  -- Recipe: Flask of Petrification
	[13519]={b=40000,s=10000,d=15274},  -- Recipe: Flask of the Titans
	[13520]={b=40000,s=10000,d=15274},  -- Recipe: Flask of Distilled Wisdom
	[13521]={b=40000,s=10000,d=15274},  -- Recipe: Flask of Supreme Power
	[13522]={b=40000,s=10000,d=15274},  -- Recipe: Flask of Chromatic Resistance
	[13523]={b=0,s=0,d=15741},  -- Blood of Innocents
	[13524]={b=49835,s=12458,d=24176,c=AUCT_CLAS_WEAPON},  -- Skull of Burning Shadows
	[13525]={b=43492,s=8698,d=24177,c=AUCT_CLAS_ARMOR},  -- Darkbind Fingers
	[13526]={b=54485,s=10897,d=24178,c=AUCT_CLAS_ARMOR},  -- Flamescarred Girdle
	[13527]={b=65746,s=13149,d=24179,c=AUCT_CLAS_ARMOR},  -- Lavawalker Greaves
	[13528]={b=65993,s=13198,d=24180,c=AUCT_CLAS_ARMOR},  -- Twilight Void Bracers
	[13529]={b=161517,s=32303,d=4107,c=AUCT_CLAS_WEAPON},  -- Husk of Nerub'enkan
	[13530]={b=62269,s=12453,d=24181,c=AUCT_CLAS_ARMOR},  -- Fangdrip Runners
	[13531]={b=105959,s=21191,d=24182,c=AUCT_CLAS_ARMOR},  -- Crypt Stalker Leggings
	[13532]={b=63810,s=12762,d=24183,c=AUCT_CLAS_ARMOR},  -- Darkspinner Claws
	[13533]={b=64052,s=12810,d=24185,c=AUCT_CLAS_ARMOR},  -- Acid-etched Pauldrons
	[13534]={b=188639,s=37727,d=24186,c=AUCT_CLAS_WEAPON},  -- Banshee Finger
	[13535]={b=84146,s=16829,d=24189,c=AUCT_CLAS_ARMOR},  -- Coldtouch Phantom Wraps
	[13536]={b=0,s=0,d=24188},  -- Horn of Awakening
	[13537]={b=49420,s=9884,d=24190,c=AUCT_CLAS_ARMOR},  -- Chillhide Bracers
	[13538]={b=96115,s=19223,d=24193,c=AUCT_CLAS_ARMOR},  -- Windshrieker Pauldrons
	[13539]={b=42677,s=8535,d=24194,c=AUCT_CLAS_ARMOR},  -- Banshee's Touch
	[13542]={b=0,s=0,d=12925},  -- Demon Box
	[13544]={b=0,s=0,d=24220,c=AUCT_CLAS_ARMOR},  -- Spectral Essence
	[13545]={b=0,s=0,d=24221,q=20,x=20},  -- Shellfish
	[13546]={b=1250,s=62,d=4809,q=20,x=20},  -- Bloodbelly Fish
	[13562]={b=0,s=0,d=24231},  -- Remains of Trey Lightforge
	[13582]={b=0,s=0,d=24252},  -- Zergling Leash
	[13583]={b=0,s=0,d=24251},  -- Panda Collar
	[13584]={b=0,s=0,d=6689},  -- Diablo Stone
	[13585]={b=0,s=0,d=6672},  -- Keepsake of Remembrance
	[13602]={b=0,s=0,d=21610,c=AUCT_CLAS_WEAPON},  -- Greater Spellstone
	[13603]={b=0,s=0,d=21610,c=AUCT_CLAS_WEAPON},  -- Major Spellstone
	[13624]={b=0,s=0,d=6672},  -- Soulbound Keepsake
	[13626]={b=0,s=0,d=3486},  -- Human Head of Ras Frostwhisper
	[13699]={b=0,s=0,d=24380,c=AUCT_CLAS_WEAPON},  -- Firestone
	[13700]={b=0,s=0,d=24380,c=AUCT_CLAS_WEAPON},  -- Greater Firestone
	[13701]={b=0,s=0,d=24380,c=AUCT_CLAS_WEAPON},  -- Major Firestone
	[13702]={b=0,s=0,d=19498,q=20,x=20},  -- Doom Weed
	[13703]={b=0,s=0,d=24415,q=20,x=20},  -- Kodo Bone
	[13704]={b=0,s=0,d=22071},  -- Skeleton Key
	[13724]={b=6000,s=300,d=21203,q=20,x=20},  -- Enriched Manna Biscuit
	[13725]={b=0,s=0,d=24496},  -- Krastinov's Bag of Horrors
	[13752]={b=0,s=0,d=6672},  -- Soulbound Keepsake
	[13754]={b=120,s=6,d=7176,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Glossy Mightfish
	[13755]={b=140,s=7,d=18537,q=20,x=20,u=AUCT_TYPE_COOK},  -- Winter Squid
	[13756]={b=180,s=9,d=4813,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Summer Bass
	[13757]={b=1200,s=10,d=24522,q=20,x=20},  -- Lightning Eel
	[13758]={b=80,s=4,d=4809,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Redgill
	[13759]={b=200,s=10,d=24713,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Nightfin Snapper
	[13760]={b=200,s=10,d=24716,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Sunscale Salmon
	[13761]={b=0,s=0,d=11448},  -- Frozen Eggs
	[13810]={b=6000,s=300,d=24568,q=20,x=20},  -- Blessed Sunfruit
	[13813]={b=6000,s=300,d=24570,q=20,x=20},  -- Blessed Sunfruit Juice
	[13815]={b=0,s=0,d=24572},  -- Some Rune
	[13816]={b=52808,s=10561,d=20225,c=AUCT_CLAS_WEAPON},  -- Fine Longsword
	[13817]={b=93984,s=18796,d=20195,c=AUCT_CLAS_WEAPON},  -- Tapered Greatsword
	[13818]={b=67157,s=13431,d=8478,c=AUCT_CLAS_WEAPON},  -- Jagged Axe
	[13819]={b=99404,s=19880,d=19374,c=AUCT_CLAS_WEAPON},  -- Balanced War Axe
	[13820]={b=60211,s=12042,d=19716,c=AUCT_CLAS_WEAPON},  -- Clout Mace
	[13821]={b=89968,s=17993,d=28691,c=AUCT_CLAS_WEAPON},  -- Bulky Maul
	[13822]={b=57212,s=11442,d=4119,c=AUCT_CLAS_WEAPON},  -- Spiked Dagger
	[13823]={b=59622,s=11924,d=20309,c=AUCT_CLAS_WEAPON},  -- Stout War Staff
	[13824]={b=45078,s=9015,d=20550,c=AUCT_CLAS_WEAPON},  -- Recurve Long Bow
	[13825]={b=50841,s=10168,d=20721,c=AUCT_CLAS_WEAPON},  -- Primed Musket
	[13850]={b=0,s=0,d=24592},  -- Rumbleshot's Ammo
	[13851]={b=1250,s=312,d=21327,x=20},  -- Hot Wolf Ribs
	[13852]={b=0,s=0,d=16065},  -- The Grand Crusader's Command
	[13853]={b=0,s=0,d=22193,q=10,x=10},  -- Slab of Carrion Worm Meat
	[13856]={b=25564,s=5112,d=25235,c=AUCT_CLAS_ARMOR},  -- Runecloth Belt
	[13857]={b=54393,s=10878,d=25207,c=AUCT_CLAS_ARMOR},  -- Runecloth Tunic
	[13858]={b=54589,s=10917,d=24601,c=AUCT_CLAS_ARMOR},  -- Runecloth Robe
	[13860]={b=43705,s=8741,d=25232,c=AUCT_CLAS_ARMOR},  -- Runecloth Cloak
	[13863]={b=33085,s=6617,d=25231,c=AUCT_CLAS_ARMOR},  -- Runecloth Gloves
	[13864]={b=47767,s=9553,d=25233,c=AUCT_CLAS_ARMOR},  -- Runecloth Boots
	[13865]={b=67775,s=13555,d=25208,c=AUCT_CLAS_ARMOR},  -- Runecloth Pants
	[13866]={b=56794,s=11358,d=25230,c=AUCT_CLAS_ARMOR},  -- Runecloth Headband
	[13867]={b=62850,s=12570,d=25236,c=AUCT_CLAS_ARMOR},  -- Runecloth Shoulders
	[13868]={b=48328,s=9665,d=24612,c=AUCT_CLAS_ARMOR},  -- Frostweave Robe
	[13869]={b=48513,s=9702,d=24610,c=AUCT_CLAS_ARMOR},  -- Frostweave Tunic
	[13870]={b=27358,s=5471,d=24616,c=AUCT_CLAS_ARMOR},  -- Frostweave Gloves
	[13871]={b=67183,s=13436,d=24615,c=AUCT_CLAS_ARMOR},  -- Frostweave Pants
	[13872]={b=0,s=0,d=929,q=20,x=20},  -- Bundle of Wood
	[13873]={b=0,s=0,d=13824},  -- Viewing Room Key
	[13874]={b=4,s=1,d=8928},  -- Heavy Crate
	[13875]={b=4,s=1,d=12331},  -- Ironbound Locked Chest
	[13876]={b=100,s=25,d=16364},  -- 40 Pound Grouper
	[13877]={b=120,s=30,d=16364},  -- 47 Pound Grouper
	[13878]={b=130,s=32,d=16364},  -- 53 Pound Grouper
	[13879]={b=140,s=35,d=16364},  -- 59 Pound Grouper
	[13880]={b=150,s=37,d=16364},  -- 68 Pound Grouper
	[13881]={b=400,s=100,d=4809},  -- Bloated Redgill
	[13882]={b=240,s=60,d=16364,c=AUCT_CLAS_WEAPON},  -- 42 Pound Redgill
	[13883]={b=240,s=60,d=16364,c=AUCT_CLAS_WEAPON},  -- 45 Pound Redgill
	[13885]={b=200,s=50,d=16364,c=AUCT_CLAS_WEAPON},  -- 34 Pound Redgill
	[13886]={b=200,s=50,d=16364,c=AUCT_CLAS_WEAPON},  -- 37 Pound Redgill
	[13888]={b=240,s=12,d=24629,q=20,x=20,u=AUCT_TYPE_COOK},  -- Darkclaw Lobster
	[13889]={b=1000,s=5,d=24719,q=20,x=20,u=AUCT_TYPE_COOK},  -- Raw Whitescale Salmon
	[13890]={b=1400,s=70,d=4823,q=20,x=20},  -- Plated Armorfish
	[13892]={b=0,s=0,d=25456},  -- Kodo Kombobulator
	[13893]={b=60,s=15,d=11932,x=20,u=AUCT_TYPE_COOK},  -- Large Raw Mightfish
	[13896]={b=55102,s=11020,d=24643,c=AUCT_CLAS_ARMOR},  -- Blue Wedding Hanbok
	[13897]={b=2976,s=595,d=24641,c=AUCT_CLAS_ARMOR},  -- White Traditional Hanbok
	[13898]={b=288699,s=57739,d=24645,c=AUCT_CLAS_ARMOR},  -- Royal Dangui
	[13899]={b=17641,s=3528,d=24639,c=AUCT_CLAS_ARMOR},  -- Red Traditional Hanbok
	[13900]={b=137214,s=27442,d=24642,c=AUCT_CLAS_ARMOR},  -- Green Wedding Hanbok
	[13901]={b=100,s=25,d=18705,c=AUCT_CLAS_WEAPON},  -- 15 Pound Salmon
	[13902]={b=100,s=25,d=18705,c=AUCT_CLAS_WEAPON},  -- 18 Pound Salmon
	[13903]={b=100,s=25,d=18705,c=AUCT_CLAS_WEAPON},  -- 22 Pound Salmon
	[13904]={b=100,s=25,d=18705,c=AUCT_CLAS_WEAPON},  -- 25 Pound Salmon
	[13905]={b=100,s=25,d=18705,c=AUCT_CLAS_WEAPON},  -- 29 Pound Salmon
	[13907]={b=200,s=50,d=24629},  -- 7 Pound Lobster
	[13908]={b=220,s=55,d=24629},  -- 9 Pound Lobster
	[13909]={b=220,s=55,d=24629},  -- 12 Pound Lobster
	[13910]={b=250,s=62,d=24629},  -- 15 Pound Lobster
	[13911]={b=320,s=80,d=24629},  -- 19 Pound Lobster
	[13912]={b=360,s=90,d=24629},  -- 21 Pound Lobster
	[13914]={b=500,s=125,d=24715,c=AUCT_CLAS_WEAPON},  -- 70 Pound Mightfish
	[13915]={b=500,s=125,d=24715,c=AUCT_CLAS_WEAPON},  -- 85 Pound Mightfish
	[13918]={b=4,s=1,d=12331},  -- Reinforced Locked Chest
	[13920]={b=0,s=0,d=22838,c=AUCT_CLAS_QUEST},  -- Healthy Dragon Scale
	[13926]={b=40000,s=10000,d=24730,x=20,u=AUCT_TYPE_ENCHANT},  -- Golden Pearl
	[13927]={b=32,s=8,d=7176,x=20},  -- Cooked Glossy Mightfish
	[13928]={b=160,s=8,d=18537,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Grilled Squid
	[13929]={b=40,s=10,d=4813,x=20},  -- Hot Smoked Bass
	[13930]={b=100,s=5,d=4809,q=20,x=20},  -- Filet of Redgill
	[13931]={b=240,s=12,d=24733,q=20,x=20},  -- Nightfin Soup
	[13932]={b=240,s=12,d=24716,q=20,x=20},  -- Poached Sunscale Salmon
	[13933]={b=280,s=14,d=24733,q=20,x=20},  -- Lobster Stew
	[13934]={b=72,s=18,d=22194,x=20},  -- Mightfish Steak
	[13935]={b=1200,s=10,d=24719,q=20,x=20},  -- Baked Salmon
	[13937]={b=435067,s=87013,d=24771,c=AUCT_CLAS_WEAPON},  -- Headmaster's Charge
	[13938]={b=196521,s=39304,d=24743,c=AUCT_CLAS_WEAPON},  -- Bonecreeper Stylus
	[13939]={b=16000,s=4000,d=1301},  -- Recipe: Spotted Yellowtail
	[13940]={b=16000,s=4000,d=1301},  -- Recipe: Cooked Glossy Mightfish
	[13941]={b=16000,s=4000,d=1301},  -- Recipe: Filet of Redgill
	[13942]={b=16000,s=4000,d=1301,c=AUCT_CLAS_FOOD},  -- Recipe: Grilled Squid
	[13943]={b=16000,s=4000,d=1301},  -- Recipe: Hot Smoked Bass
	[13944]={b=134043,s=26808,d=28632,c=AUCT_CLAS_ARMOR},  -- Tombstone Breastplate
	[13945]={b=20000,s=5000,d=1301},  -- Recipe: Nightfin Soup
	[13946]={b=20000,s=5000,d=1301},  -- Recipe: Poached Sunscale Salmon
	[13947]={b=20000,s=5000,d=1301},  -- Recipe: Lobster Stew
	[13948]={b=20000,s=5000,d=1301},  -- Recipe: Mightfish Steak
	[13949]={b=20000,s=5000,d=1301},  -- Recipe: Baked Salmon
	[13950]={b=82235,s=16447,d=24748,c=AUCT_CLAS_ARMOR},  -- Detention Strap
	[13951]={b=55026,s=11005,d=24749,c=AUCT_CLAS_ARMOR},  -- Vigorsteel Vambraces
	[13952]={b=283415,s=56683,d=28782,c=AUCT_CLAS_WEAPON},  -- Iceblade Hacker
	[13953]={b=284402,s=56880,d=24756,c=AUCT_CLAS_WEAPON},  -- Silent Fang
	[13954]={b=101934,s=20386,d=28627,c=AUCT_CLAS_ARMOR},  -- Verdant Footpads
	[13955]={b=81837,s=16367,d=24777,c=AUCT_CLAS_ARMOR},  -- Stoneform Shoulders
	[13956]={b=54751,s=10950,d=24762,c=AUCT_CLAS_ARMOR},  -- Clutch of Andros
	[13957]={b=62139,s=12427,d=24768,c=AUCT_CLAS_ARMOR},  -- Gargoyle Slashers
	[13958]={b=47528,s=9505,d=24767,c=AUCT_CLAS_ARMOR},  -- Wyrmthalak's Shackles
	[13959]={b=47712,s=9542,d=30535,c=AUCT_CLAS_ARMOR},  -- Omokk's Girth Restrainer
	[13960]={b=51315,s=12828,d=19785,c=AUCT_CLAS_ARMOR},  -- Heart of the Fiend
	[13961]={b=90141,s=18028,d=24772,c=AUCT_CLAS_ARMOR},  -- Halycon's Muzzle
	[13962]={b=60324,s=12064,d=30391,c=AUCT_CLAS_ARMOR},  -- Vosh'gajin's Strand
	[13963]={b=72665,s=14533,d=29016,c=AUCT_CLAS_ARMOR},  -- Voone's Vice Grips
	[13964]={b=261533,s=52306,d=24775,c=AUCT_CLAS_WEAPON},  -- Witchblade
	[13965]={b=65000,s=16250,d=24776,c=AUCT_CLAS_ARMOR},  -- Blackhand's Breadth
	[13966]={b=65000,s=16250,d=24778,c=AUCT_CLAS_ARMOR},  -- Mark of Tyranny
	[13967]={b=116691,s=23338,d=28604,c=AUCT_CLAS_ARMOR},  -- Windreaver Greaves
	[13968]={b=65000,s=16250,d=24784,c=AUCT_CLAS_ARMOR},  -- Eye of the Beast
	[13969]={b=80097,s=16019,d=24793,c=AUCT_CLAS_ARMOR},  -- Loomguard Armbraces
	[13982]={b=349130,s=69826,d=26676,c=AUCT_CLAS_WEAPON},  -- Warblade of Caer Darrow
	[13983]={b=333772,s=66754,d=24816,c=AUCT_CLAS_WEAPON},  -- Gravestone War Axe
	[13984]={b=289034,s=57806,d=26679,c=AUCT_CLAS_WEAPON},  -- Darrowspike
	[13986]={b=87349,s=17469,d=26680,c=AUCT_CLAS_ARMOR},  -- Crown of Caer Darrow
	[14002]={b=183600,s=36720,d=22831,c=AUCT_CLAS_WEAPON},  -- Darrowshire Strongguard
	[14022]={b=35965,s=8991,d=26622,c=AUCT_CLAS_ARMOR},  -- Barov Peasant Caller
	[14023]={b=35965,s=8991,d=26622,c=AUCT_CLAS_ARMOR},  -- Barov Peasant Caller
	[14024]={b=262111,s=52422,d=20592,c=AUCT_CLAS_WEAPON},  -- Frightalon
	[14025]={b=941,s=188,d=25881,c=AUCT_CLAS_ARMOR},  -- Mystic's Belt
	[14042]={b=52808,s=10561,d=24893,c=AUCT_CLAS_ARMOR},  -- Cindercloth Vest
	[14043]={b=29778,s=5955,d=24896,c=AUCT_CLAS_ARMOR},  -- Cindercloth Gloves
	[14044]={b=47516,s=9503,d=23422,c=AUCT_CLAS_ARMOR},  -- Cindercloth Cloak
	[14045]={b=67404,s=13480,d=24895,c=AUCT_CLAS_ARMOR},  -- Cindercloth Pants
	[14046]={b=20000,s=5000,d=19595,c=AUCT_CLAS_CONTAINER},  -- Runecloth Bag
	[14047]={b=1600,s=400,d=24897,x=20,c=AUCT_CLAS_CLOTH,u=AUCT_TYPE_FSTAID..", "..AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Runecloth
	[14048]={b=8000,s=2000,d=24898,x=10,u=AUCT_TYPE_TAILOR},  -- Bolt of Runecloth
	[14086]={b=225,s=45,d=25871,c=AUCT_CLAS_ARMOR},  -- Beaded Sandals
	[14087]={b=82,s=16,d=25864,c=AUCT_CLAS_ARMOR},  -- Beaded Cuffs
	[14088]={b=124,s=24,d=23132,c=AUCT_CLAS_ARMOR},  -- Beaded Cloak
	[14089]={b=151,s=30,d=25867,c=AUCT_CLAS_ARMOR},  -- Beaded Gloves
	[14090]={b=597,s=119,d=7533,c=AUCT_CLAS_ARMOR},  -- Beaded Britches
	[14091]={b=599,s=119,d=25869,c=AUCT_CLAS_ARMOR},  -- Beaded Robe
	[14093]={b=106,s=21,d=25863,c=AUCT_CLAS_ARMOR},  -- Beaded Cord
	[14094]={b=606,s=121,d=25873,c=AUCT_CLAS_ARMOR},  -- Beaded Wraps
	[14095]={b=182,s=36,d=25874,c=AUCT_CLAS_ARMOR},  -- Native Bands
	[14096]={b=1627,s=325,d=25880,c=AUCT_CLAS_ARMOR},  -- Native Vest
	[14097]={b=1183,s=236,d=25876,c=AUCT_CLAS_ARMOR},  -- Native Pants
	[14098]={b=218,s=43,d=25875,c=AUCT_CLAS_ARMOR},  -- Native Cloak
	[14099]={b=237,s=47,d=14431,c=AUCT_CLAS_ARMOR},  -- Native Sash
	[14100]={b=60449,s=12089,d=15820,c=AUCT_CLAS_ARMOR},  -- Brightcloth Robe
	[14101]={b=30334,s=6066,d=16779,c=AUCT_CLAS_ARMOR},  -- Brightcloth Gloves
	[14102]={b=300,s=60,d=16586,c=AUCT_CLAS_ARMOR},  -- Native Handwraps
	[14103]={b=48582,s=9716,d=24928,c=AUCT_CLAS_ARMOR},  -- Brightcloth Cloak
	[14104]={b=77420,s=15484,d=24927,c=AUCT_CLAS_ARMOR},  -- Brightcloth Pants
	[14106]={b=90268,s=18053,d=24932,c=AUCT_CLAS_ARMOR},  -- Felcloth Robe
	[14107]={b=65704,s=13140,d=13679,c=AUCT_CLAS_ARMOR},  -- Felcloth Pants
	[14108]={b=55560,s=11112,d=24935,c=AUCT_CLAS_ARMOR},  -- Felcloth Boots
	[14109]={b=1705,s=341,d=25877,c=AUCT_CLAS_ARMOR},  -- Native Robe
	[14110]={b=420,s=84,d=25879,c=AUCT_CLAS_ARMOR},  -- Native Sandals
	[14111]={b=53875,s=10775,d=24933,c=AUCT_CLAS_ARMOR},  -- Felcloth Hood
	[14112]={b=67549,s=13509,d=24934,c=AUCT_CLAS_ARMOR},  -- Felcloth Shoulders
	[14113]={b=699,s=139,d=25858,c=AUCT_CLAS_ARMOR},  -- Aboriginal Sash
	[14114]={b=1211,s=242,d=25857,c=AUCT_CLAS_ARMOR},  -- Aboriginal Footwraps
	[14115]={b=351,s=70,d=14541,c=AUCT_CLAS_ARMOR},  -- Aboriginal Bands
	[14116]={b=530,s=106,d=25855,c=AUCT_CLAS_ARMOR},  -- Aboriginal Cape
	[14117]={b=816,s=163,d=14542,c=AUCT_CLAS_ARMOR},  -- Aboriginal Gloves
	[14119]={b=1891,s=378,d=11421,c=AUCT_CLAS_ARMOR},  -- Aboriginal Loincloth
	[14120]={b=2887,s=577,d=16531,c=AUCT_CLAS_ARMOR},  -- Aboriginal Robe
	[14121]={b=2897,s=579,d=17462,c=AUCT_CLAS_ARMOR},  -- Aboriginal Vest
	[14122]={b=1098,s=219,d=16664,c=AUCT_CLAS_ARMOR},  -- Ritual Bands
	[14123]={b=1439,s=287,d=25916,c=AUCT_CLAS_ARMOR},  -- Ritual Cape
	[14124]={b=1463,s=292,d=16657,c=AUCT_CLAS_ARMOR},  -- Ritual Gloves
	[14125]={b=3380,s=676,d=16656,c=AUCT_CLAS_ARMOR},  -- Ritual Kilt
	[14126]={b=1983,s=396,d=5394,c=AUCT_CLAS_ARMOR},  -- Ritual Amice
	[14127]={b=4999,s=999,d=15201,c=AUCT_CLAS_ARMOR},  -- Ritual Shroud
	[14128]={b=80465,s=16093,d=24945,c=AUCT_CLAS_ARMOR},  -- Wizardweave Robe
	[14129]={b=2079,s=415,d=25929,c=AUCT_CLAS_ARMOR},  -- Ritual Sandals
	[14130]={b=63843,s=12768,d=24942,c=AUCT_CLAS_ARMOR},  -- Wizardweave Turban
	[14131]={b=1214,s=242,d=25915,c=AUCT_CLAS_ARMOR},  -- Ritual Belt
	[14132]={b=62206,s=12441,d=24943,c=AUCT_CLAS_ARMOR},  -- Wizardweave Leggings
	[14133]={b=4752,s=950,d=25952,c=AUCT_CLAS_ARMOR},  -- Ritual Tunic
	[14134]={b=56401,s=11280,d=24946,c=AUCT_CLAS_ARMOR},  -- Cloak of Fire
	[14136]={b=85127,s=17025,d=25834,c=AUCT_CLAS_ARMOR},  -- Robe of Winter Night
	[14137]={b=90567,s=18113,d=17252,c=AUCT_CLAS_ARMOR},  -- Mooncloth Leggings
	[14138]={b=100210,s=20042,d=25228,c=AUCT_CLAS_ARMOR},  -- Mooncloth Vest
	[14139]={b=79204,s=15840,d=24966,c=AUCT_CLAS_ARMOR},  -- Mooncloth Shoulders
	[14140]={b=83469,s=16693,d=28414,c=AUCT_CLAS_ARMOR},  -- Mooncloth Circlet
	[14141]={b=64296,s=12859,d=25571,c=AUCT_CLAS_ARMOR},  -- Ghostweave Vest
	[14142]={b=30436,s=6087,d=24977,c=AUCT_CLAS_ARMOR},  -- Ghostweave Gloves
	[14143]={b=28817,s=5763,d=24978,c=AUCT_CLAS_ARMOR},  -- Ghostweave Belt
	[14144]={b=71871,s=14374,d=11166,c=AUCT_CLAS_ARMOR},  -- Ghostweave Pants
	[14145]={b=5161,s=1032,d=24981,c=AUCT_CLAS_WEAPON},  -- Cursed Felblade
	[14146]={b=70421,s=14084,d=24986,c=AUCT_CLAS_ARMOR},  -- Gloves of Spell Mastery
	[14147]={b=1559,s=311,d=24982,c=AUCT_CLAS_ARMOR},  -- Cavedweller Bracers
	[14148]={b=1043,s=208,d=24983,c=AUCT_CLAS_ARMOR},  -- Crystalline Cuffs
	[14149]={b=1538,s=307,d=24985,c=AUCT_CLAS_ARMOR},  -- Subterranean Cape
	[14150]={b=2103,s=420,d=24988,c=AUCT_CLAS_ARMOR},  -- Robe of Evocation
	[14151]={b=5279,s=1055,d=24990,c=AUCT_CLAS_WEAPON},  -- Chanting Blade
	[14152]={b=144076,s=28815,d=25205,c=AUCT_CLAS_ARMOR},  -- Robe of the Archmage
	[14153]={b=144603,s=28920,d=25201,c=AUCT_CLAS_ARMOR},  -- Robe of the Void
	[14154]={b=145144,s=29028,d=25203,c=AUCT_CLAS_ARMOR},  -- Truefaith Vestments
	[14155]={b=80000,s=20000,d=21586,c=AUCT_CLAS_CONTAINER},  -- Mooncloth Bag
	[14156]={b=160000,s=40000,d=20342,c=AUCT_CLAS_CONTAINER},  -- Bottomless Bag
	[14157]={b=2169,s=433,d=8374,c=AUCT_CLAS_ARMOR},  -- Pagan Mantle
	[14158]={b=6180,s=1236,d=9996,c=AUCT_CLAS_ARMOR},  -- Pagan Vest
	[14159]={b=2852,s=570,d=25893,c=AUCT_CLAS_ARMOR},  -- Pagan Shoes
	[14160]={b=1255,s=251,d=16907,c=AUCT_CLAS_ARMOR},  -- Pagan Bands
	[14161]={b=1685,s=337,d=23101,c=AUCT_CLAS_ARMOR},  -- Pagan Cape
	[14162]={b=2228,s=445,d=11144,c=AUCT_CLAS_ARMOR},  -- Pagan Mitts
	[14163]={b=5841,s=1168,d=25894,c=AUCT_CLAS_ARMOR},  -- Pagan Wraps
	[14164]={b=1563,s=312,d=14431,c=AUCT_CLAS_ARMOR},  -- Pagan Belt
	[14165]={b=5208,s=1041,d=25890,c=AUCT_CLAS_ARMOR},  -- Pagan Britches
	[14166]={b=1191,s=238,d=28050,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Bracers
	[14167]={b=1793,s=358,d=28054,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Cape
	[14168]={b=1379,s=275,d=28056,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Gloves
	[14169]={b=1433,s=286,d=25859,c=AUCT_CLAS_ARMOR},  -- Aboriginal Shoulder Pads
	[14170]={b=1655,s=331,d=28055,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Mantle
	[14171]={b=3693,s=738,d=13679,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Pants
	[14172]={b=4188,s=837,d=28098,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Robes
	[14173]={b=1405,s=281,d=28051,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Cord
	[14174]={b=1840,s=368,d=19950,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Boots
	[14175]={b=4235,s=847,d=28052,c=AUCT_CLAS_ARMOR},  -- Buccaneer's Vest
	[14176]={b=4600,s=920,d=9184,c=AUCT_CLAS_ARMOR},  -- Watcher's Boots
	[14177]={b=3159,s=631,d=25970,c=AUCT_CLAS_ARMOR},  -- Watcher's Cuffs
	[14178]={b=7661,s=1532,d=26302,c=AUCT_CLAS_ARMOR},  -- Watcher's Cap
	[14179]={b=3738,s=747,d=23109,c=AUCT_CLAS_ARMOR},  -- Watcher's Cape
	[14180]={b=9351,s=1870,d=26023,c=AUCT_CLAS_ARMOR},  -- Watcher's Jerkin
	[14181]={b=3877,s=775,d=25971,c=AUCT_CLAS_ARMOR},  -- Watcher's Handwraps
	[14182]={b=5836,s=1167,d=19991,c=AUCT_CLAS_ARMOR},  -- Watcher's Mantle
	[14183]={b=8550,s=1710,d=25974,c=AUCT_CLAS_ARMOR},  -- Watcher's Leggings
	[14184]={b=8584,s=1716,d=25976,c=AUCT_CLAS_ARMOR},  -- Watcher's Robes
	[14185]={b=3237,s=647,d=25969,c=AUCT_CLAS_ARMOR},  -- Watcher's Cinch
	[14186]={b=5897,s=1179,d=25986,c=AUCT_CLAS_ARMOR},  -- Raincaller Mantle
	[14187]={b=3587,s=717,d=14640,c=AUCT_CLAS_ARMOR},  -- Raincaller Cuffs
	[14188]={b=4911,s=982,d=23138,c=AUCT_CLAS_ARMOR},  -- Raincaller Cloak
	[14189]={b=7940,s=1588,d=15283,c=AUCT_CLAS_ARMOR},  -- Raincaller Cap
	[14190]={b=9660,s=1932,d=25984,c=AUCT_CLAS_ARMOR},  -- Raincaller Vest
	[14191]={b=4407,s=881,d=25987,c=AUCT_CLAS_ARMOR},  -- Raincaller Mitts
	[14192]={b=9732,s=1946,d=25989,c=AUCT_CLAS_ARMOR},  -- Raincaller Robes
	[14193]={b=10031,s=2006,d=18887,c=AUCT_CLAS_ARMOR},  -- Raincaller Pants
	[14194]={b=3781,s=756,d=28730,c=AUCT_CLAS_ARMOR},  -- Raincaller Cord
	[14195]={b=6262,s=1252,d=14645,c=AUCT_CLAS_ARMOR},  -- Raincaller Boots
	[14196]={b=8365,s=1673,d=26008,c=AUCT_CLAS_ARMOR},  -- Thistlefur Sandals
	[14197]={b=4625,s=925,d=26004,c=AUCT_CLAS_ARMOR},  -- Thistlefur Bands
	[14198]={b=7659,s=1531,d=26006,c=AUCT_CLAS_ARMOR},  -- Thistlefur Cloak
	[14199]={b=6200,s=1240,d=26007,c=AUCT_CLAS_ARMOR},  -- Thistlefur Gloves
	[14200]={b=11294,s=2258,d=15293,c=AUCT_CLAS_ARMOR},  -- Thistlefur Cap
	[14201]={b=10303,s=2060,d=26012,c=AUCT_CLAS_ARMOR},  -- Thistlefur Mantle
	[14202]={b=16681,s=3336,d=26049,c=AUCT_CLAS_ARMOR},  -- Thistlefur Jerkin
	[14203]={b=13770,s=2754,d=16719,c=AUCT_CLAS_ARMOR},  -- Thistlefur Pants
	[14204]={b=15206,s=3041,d=26011,c=AUCT_CLAS_ARMOR},  -- Thistlefur Robe
	[14205]={b=5212,s=1042,d=26005,c=AUCT_CLAS_ARMOR},  -- Thistlefur Belt
	[14206]={b=5232,s=1046,d=25970,c=AUCT_CLAS_ARMOR},  -- Vital Bracelets
	[14207]={b=15381,s=3076,d=26021,c=AUCT_CLAS_ARMOR},  -- Vital Leggings
	[14208]={b=11580,s=2316,d=26308,c=AUCT_CLAS_ARMOR},  -- Vital Headband
	[14209]={b=5980,s=1196,d=26022,c=AUCT_CLAS_ARMOR},  -- Vital Sash
	[14210]={b=8184,s=1636,d=26015,c=AUCT_CLAS_ARMOR},  -- Vital Cape
	[14211]={b=6626,s=1325,d=26020,c=AUCT_CLAS_ARMOR},  -- Vital Handwraps
	[14212]={b=10974,s=2194,d=28729,c=AUCT_CLAS_ARMOR},  -- Vital Shoulders
	[14213]={b=17768,s=3553,d=26017,c=AUCT_CLAS_ARMOR},  -- Vital Raiment
	[14214]={b=10048,s=2009,d=9184,c=AUCT_CLAS_ARMOR},  -- Vital Boots
	[14215]={b=17898,s=3579,d=25973,c=AUCT_CLAS_ARMOR},  -- Vital Tunic
	[14216]={b=24438,s=4887,d=26051,c=AUCT_CLAS_ARMOR},  -- Geomancer's Jerkin
	[14217]={b=8193,s=1638,d=24113,c=AUCT_CLAS_ARMOR},  -- Geomancer's Cord
	[14218]={b=13568,s=2713,d=16721,c=AUCT_CLAS_ARMOR},  -- Geomancer's Boots
	[14219]={b=10230,s=2046,d=26045,c=AUCT_CLAS_ARMOR},  -- Geomancer's Cloak
	[14220]={b=17214,s=3442,d=26044,c=AUCT_CLAS_ARMOR},  -- Geomancer's Cap
	[14221]={b=7554,s=1510,d=26042,c=AUCT_CLAS_ARMOR},  -- Geomancer's Bracers
	[14222]={b=9174,s=1834,d=26050,c=AUCT_CLAS_ARMOR},  -- Geomancer's Gloves
	[14223]={b=13494,s=2698,d=26054,c=AUCT_CLAS_ARMOR},  -- Geomancer's Spaulders
	[14224]={b=19508,s=3901,d=26052,c=AUCT_CLAS_ARMOR},  -- Geomancer's Trousers
	[14225]={b=23471,s=4694,d=26053,c=AUCT_CLAS_ARMOR},  -- Geomancer's Wraps
	[14226]={b=8658,s=1731,d=26055,c=AUCT_CLAS_ARMOR},  -- Embersilk Bracelets
	[14227]={b=10000,s=2500,d=18597,x=10,u=AUCT_TYPE_TAILOR},  -- Ironweb Spider Silk
	[14228]={b=17799,s=3559,d=26059,c=AUCT_CLAS_ARMOR},  -- Embersilk Coronet
	[14229]={b=11938,s=2387,d=26057,c=AUCT_CLAS_ARMOR},  -- Embersilk Cloak
	[14230]={b=25822,s=5164,d=26063,c=AUCT_CLAS_ARMOR},  -- Embersilk Tunic
	[14231]={b=9524,s=1904,d=26062,c=AUCT_CLAS_ARMOR},  -- Embersilk Mitts
	[14232]={b=15486,s=3097,d=26068,c=AUCT_CLAS_ARMOR},  -- Embersilk Mantle
	[14233]={b=22381,s=4476,d=26061,c=AUCT_CLAS_ARMOR},  -- Embersilk Leggings
	[14234]={b=26200,s=5240,d=26067,c=AUCT_CLAS_ARMOR},  -- Embersilk Robes
	[14235]={b=8948,s=1789,d=26058,c=AUCT_CLAS_ARMOR},  -- Embersilk Cord
	[14236]={b=14546,s=2909,d=26066,c=AUCT_CLAS_ARMOR},  -- Embersilk Boots
	[14237]={b=36030,s=7206,d=16599,c=AUCT_CLAS_ARMOR},  -- Darkmist Armor
	[14238]={b=18457,s=3691,d=26100,c=AUCT_CLAS_ARMOR},  -- Darkmist Boots
	[14239]={b=15881,s=3176,d=26101,c=AUCT_CLAS_ARMOR},  -- Darkmist Cape
	[14240]={b=11473,s=2294,d=16604,c=AUCT_CLAS_ARMOR},  -- Darkmist Bands
	[14241]={b=11558,s=2311,d=26102,c=AUCT_CLAS_ARMOR},  -- Darkmist Handguards
	[14242]={b=27068,s=5413,d=16600,c=AUCT_CLAS_ARMOR},  -- Darkmist Pants
	[14243]={b=20376,s=4075,d=26104,c=AUCT_CLAS_ARMOR},  -- Darkmist Mantle
	[14244]={b=34354,s=6870,d=28991,c=AUCT_CLAS_ARMOR},  -- Darkmist Wraps
	[14245]={b=11733,s=2346,d=24624,c=AUCT_CLAS_ARMOR},  -- Darkmist Girdle
	[14246]={b=22256,s=4451,d=26309,c=AUCT_CLAS_ARMOR},  -- Darkmist Wizard Hat
	[14247]={b=22337,s=4467,d=26116,c=AUCT_CLAS_ARMOR},  -- Lunar Mantle
	[14248]={b=11864,s=2372,d=14647,c=AUCT_CLAS_ARMOR},  -- Lunar Bindings
	[14249]={b=37798,s=7559,d=14646,c=AUCT_CLAS_ARMOR},  -- Lunar Vest
	[14250]={b=19364,s=3872,d=26117,c=AUCT_CLAS_ARMOR},  -- Lunar Slippers
	[14251]={b=16661,s=3332,d=26112,c=AUCT_CLAS_ARMOR},  -- Lunar Cloak
	[14252]={b=24571,s=4914,d=18992,c=AUCT_CLAS_ARMOR},  -- Lunar Coronet
	[14253]={b=14095,s=2819,d=26113,c=AUCT_CLAS_ARMOR},  -- Lunar Handwraps
	[14254]={b=38493,s=7698,d=26119,c=AUCT_CLAS_ARMOR},  -- Lunar Raiment
	[14255]={b=13144,s=2628,d=26111,c=AUCT_CLAS_ARMOR},  -- Lunar Belt
	[14256]={b=8000,s=2000,d=25028,x=20,c=AUCT_CLAS_CLOTH,u=AUCT_TYPE_TAILOR},  -- Felcloth
	[14257]={b=30973,s=6194,d=18887,c=AUCT_CLAS_ARMOR},  -- Lunar Leggings
	[14258]={b=15545,s=3109,d=26190,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Cord
	[14259]={b=25280,s=5056,d=26186,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Boots
	[14260]={b=14503,s=2900,d=26187,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Bracers
	[14261]={b=20222,s=4044,d=26189,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Cloak
	[14262]={b=15783,s=3156,d=26193,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Mitts
	[14263]={b=29936,s=5987,d=15308,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Mask
	[14264]={b=40066,s=8013,d=26196,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Pants
	[14265]={b=49268,s=9853,d=26198,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Wraps
	[14266]={b=28031,s=5606,d=26195,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Pads
	[14267]={b=49633,s=9926,d=26192,c=AUCT_CLAS_ARMOR},  -- Bloodwoven Jerkin
	[14268]={b=17432,s=3486,d=17262,c=AUCT_CLAS_ARMOR},  -- Gaea's Cuffs
	[14269]={b=28346,s=5669,d=26145,c=AUCT_CLAS_ARMOR},  -- Gaea's Slippers
	[14270]={b=24389,s=4877,d=23031,c=AUCT_CLAS_ARMOR},  -- Gaea's Cloak
	[14271]={b=32995,s=6599,d=26307,c=AUCT_CLAS_ARMOR},  -- Gaea's Circlet
	[14272]={b=19104,s=3820,d=26143,c=AUCT_CLAS_ARMOR},  -- Gaea's Handwraps
	[14273]={b=31874,s=6374,d=26147,c=AUCT_CLAS_ARMOR},  -- Gaea's Amice
	[14274]={b=52244,s=10448,d=26144,c=AUCT_CLAS_ARMOR},  -- Gaea's Leggings
	[14275]={b=55575,s=11115,d=26142,c=AUCT_CLAS_ARMOR},  -- Gaea's Raiment
	[14276]={b=17991,s=3598,d=26138,c=AUCT_CLAS_ARMOR},  -- Gaea's Belt
	[14277]={b=50656,s=10131,d=26311,c=AUCT_CLAS_ARMOR},  -- Gaea's Tunic
	[14278]={b=33626,s=6725,d=27928,c=AUCT_CLAS_ARMOR},  -- Opulent Mantle
	[14279]={b=21031,s=4206,d=14618,c=AUCT_CLAS_ARMOR},  -- Opulent Bracers
	[14280]={b=29596,s=5919,d=26137,c=AUCT_CLAS_ARMOR},  -- Opulent Cape
	[14281]={b=40890,s=8178,d=26128,c=AUCT_CLAS_ARMOR},  -- Opulent Crown
	[14282]={b=22760,s=4552,d=26132,c=AUCT_CLAS_ARMOR},  -- Opulent Gloves
	[14283]={b=58233,s=11646,d=26124,c=AUCT_CLAS_ARMOR},  -- Opulent Leggings
	[14284]={b=65678,s=13135,d=26131,c=AUCT_CLAS_ARMOR},  -- Opulent Robes
	[14285]={b=34527,s=6905,d=26134,c=AUCT_CLAS_ARMOR},  -- Opulent Boots
	[14286]={b=23103,s=4620,d=26136,c=AUCT_CLAS_ARMOR},  -- Opulent Belt
	[14287]={b=66414,s=13282,d=27927,c=AUCT_CLAS_ARMOR},  -- Opulent Tunic
	[14288]={b=70662,s=14132,d=26203,c=AUCT_CLAS_ARMOR},  -- Arachnidian Armor
	[14289]={b=25659,s=5131,d=25098,c=AUCT_CLAS_ARMOR},  -- Arachnidian Girdle
	[14290]={b=38628,s=7725,d=26206,c=AUCT_CLAS_ARMOR},  -- Arachnidian Footpads
	[14291]={b=24153,s=4830,d=26205,c=AUCT_CLAS_ARMOR},  -- Arachnidian Bracelets
	[14292]={b=33978,s=6795,d=26215,c=AUCT_CLAS_ARMOR},  -- Arachnidian Cape
	[14293]={b=49287,s=9857,d=26214,c=AUCT_CLAS_ARMOR},  -- Arachnidian Circlet
	[14294]={b=26119,s=5223,d=26208,c=AUCT_CLAS_ARMOR},  -- Arachnidian Gloves
	[14295]={b=66184,s=13236,d=26212,c=AUCT_CLAS_ARMOR},  -- Arachnidian Legguards
	[14296]={b=37840,s=7568,d=26213,c=AUCT_CLAS_ARMOR},  -- Arachnidian Pauldrons
	[14297]={b=67782,s=13556,d=26211,c=AUCT_CLAS_ARMOR},  -- Arachnidian Robes
	[14298]={b=48144,s=9628,d=26281,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Spaulders
	[14299]={b=43013,s=8602,d=26268,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Boots
	[14300]={b=38425,s=7685,d=26271,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Cape
	[14301]={b=27257,s=5451,d=26266,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Bindings
	[14302]={b=32587,s=6517,d=26275,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Gloves
	[14303]={b=81045,s=16209,d=18834,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Shroud
	[14304]={b=30973,s=6194,d=26280,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Belt
	[14305]={b=71747,s=14349,d=26282,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Sarong
	[14306]={b=84154,s=16830,d=26279,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Vest
	[14307]={b=60323,s=12064,d=26277,c=AUCT_CLAS_ARMOR},  -- Bonecaster's Crown
	[14308]={b=88997,s=17799,d=26256,c=AUCT_CLAS_ARMOR},  -- Celestial Tunic
	[14309]={b=34334,s=6866,d=26252,c=AUCT_CLAS_ARMOR},  -- Celestial Belt
	[14310]={b=58076,s=11615,d=26261,c=AUCT_CLAS_ARMOR},  -- Celestial Slippers
	[14311]={b=32621,s=6524,d=26253,c=AUCT_CLAS_ARMOR},  -- Celestial Bindings
	[14312]={b=67708,s=13541,d=26255,c=AUCT_CLAS_ARMOR},  -- Celestial Crown
	[14313]={b=46493,s=9298,d=26262,c=AUCT_CLAS_ARMOR},  -- Celestial Cape
	[14314]={b=39270,s=7854,d=26258,c=AUCT_CLAS_ARMOR},  -- Celestial Handwraps
	[14315]={b=82752,s=16550,d=26260,c=AUCT_CLAS_ARMOR},  -- Celestial Kilt
	[14316]={b=56355,s=11271,d=26263,c=AUCT_CLAS_ARMOR},  -- Celestial Pauldrons
	[14317]={b=83165,s=16633,d=26254,c=AUCT_CLAS_ARMOR},  -- Celestial Silk Robes
	[14318]={b=92044,s=18408,d=26288,c=AUCT_CLAS_ARMOR},  -- Resplendent Tunic
	[14319]={b=57007,s=11401,d=26285,c=AUCT_CLAS_ARMOR},  -- Resplendent Boots
	[14320]={b=34277,s=6855,d=26287,c=AUCT_CLAS_ARMOR},  -- Resplendent Bracelets
	[14321]={b=47190,s=9438,d=26299,c=AUCT_CLAS_ARMOR},  -- Resplendent Cloak
	[14322]={b=68563,s=13712,d=26292,c=AUCT_CLAS_ARMOR},  -- Resplendent Circlet
	[14323]={b=41612,s=8322,d=26290,c=AUCT_CLAS_ARMOR},  -- Resplendent Gauntlets
	[14324]={b=83533,s=16706,d=26300,c=AUCT_CLAS_ARMOR},  -- Resplendent Sarong
	[14325]={b=66023,s=13204,d=26298,c=AUCT_CLAS_ARMOR},  -- Resplendent Epaulets
	[14326]={b=97399,s=19479,d=28993,c=AUCT_CLAS_ARMOR},  -- Resplendent Robes
	[14327]={b=38296,s=7659,d=26284,c=AUCT_CLAS_ARMOR},  -- Resplendent Belt
	[14329]={b=70332,s=14066,d=26225,c=AUCT_CLAS_ARMOR},  -- Eternal Boots
	[14330]={b=44812,s=8962,d=26216,c=AUCT_CLAS_ARMOR},  -- Eternal Bindings
	[14331]={b=58273,s=11654,d=26227,c=AUCT_CLAS_ARMOR},  -- Eternal Cloak
	[14332]={b=78373,s=15674,d=26224,c=AUCT_CLAS_ARMOR},  -- Eternal Crown
	[14333]={b=49937,s=9987,d=26222,c=AUCT_CLAS_ARMOR},  -- Eternal Gloves
	[14334]={b=100221,s=20044,d=26223,c=AUCT_CLAS_ARMOR},  -- Eternal Sarong
	[14335]={b=75432,s=15086,d=26229,c=AUCT_CLAS_ARMOR},  -- Eternal Spaulders
	[14336]={b=100686,s=20137,d=26226,c=AUCT_CLAS_ARMOR},  -- Eternal Wraps
	[14337]={b=42731,s=8546,d=26221,c=AUCT_CLAS_ARMOR},  -- Eternal Cord
	[14338]={b=0,s=0,d=25038},  -- Empty Water Tube
	[14339]={b=0,s=0,d=15794},  -- Moonwell Water Tube
	[14340]={b=108891,s=21778,d=25039,c=AUCT_CLAS_ARMOR},  -- Freezing Lich Robes
	[14341]={b=5000,s=1250,d=25048,x=20,u=AUCT_TYPE_LEATHER..", "..AUCT_TYPE_TAILOR},  -- Rune Thread
	[14342]={b=16000,s=4000,d=25052,x=20,c=AUCT_CLAS_CLOTH,u=AUCT_TYPE_TAILOR},  -- Mooncloth
	[14343]={b=36000,s=0,d=25054,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Small Brilliant Shard
	[14344]={b=36000,s=0,d=25055,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Large Brilliant Shard
	[14364]={b=1624,s=324,d=16802,c=AUCT_CLAS_ARMOR},  -- Mystic's Slippers
	[14365]={b=1072,s=214,d=25884,c=AUCT_CLAS_ARMOR},  -- Mystic's Cape
	[14366]={b=948,s=189,d=16805,c=AUCT_CLAS_ARMOR},  -- Mystic's Bracelets
	[14367]={b=1259,s=251,d=25885,c=AUCT_CLAS_ARMOR},  -- Mystic's Gloves
	[14368]={b=1730,s=346,d=25887,c=AUCT_CLAS_ARMOR},  -- Mystic's Shoulder Pads
	[14369]={b=4048,s=809,d=25888,c=AUCT_CLAS_ARMOR},  -- Mystic's Wrap
	[14370]={b=2364,s=472,d=10079,c=AUCT_CLAS_ARMOR},  -- Mystic's Woolies
	[14371]={b=4079,s=815,d=25889,c=AUCT_CLAS_ARMOR},  -- Mystic's Robe
	[14372]={b=7151,s=1430,d=25954,c=AUCT_CLAS_ARMOR},  -- Sanguine Armor
	[14373]={b=2624,s=524,d=25957,c=AUCT_CLAS_ARMOR},  -- Sanguine Belt
	[14374]={b=3497,s=699,d=25966,c=AUCT_CLAS_ARMOR},  -- Sanguine Sandals
	[14375]={b=2644,s=528,d=25959,c=AUCT_CLAS_ARMOR},  -- Sanguine Cuffs
	[14376]={b=2759,s=551,d=25958,c=AUCT_CLAS_ARMOR},  -- Sanguine Cape
	[14377]={b=3011,s=602,d=25961,c=AUCT_CLAS_ARMOR},  -- Sanguine Handwraps
	[14378]={b=4987,s=997,d=25965,c=AUCT_CLAS_ARMOR},  -- Sanguine Mantle
	[14379]={b=8075,s=1615,d=25968,c=AUCT_CLAS_ARMOR},  -- Sanguine Trousers
	[14380]={b=7369,s=1473,d=25956,c=AUCT_CLAS_ARMOR},  -- Sanguine Robe
	[14381]={b=0,s=0,d=6430},  -- Grimtotem Satchel
	[14395]={b=0,s=0,d=7139},  -- Spells of Shadow
	[14396]={b=0,s=0,d=1246},  -- Incantations from the Nether
	[14397]={b=8001,s=1600,d=27872,c=AUCT_CLAS_ARMOR},  -- Resilient Mantle
	[14398]={b=11778,s=2355,d=26003,c=AUCT_CLAS_ARMOR},  -- Resilient Tunic
	[14399]={b=7328,s=1465,d=25995,c=AUCT_CLAS_ARMOR},  -- Resilient Boots
	[14400]={b=6078,s=1215,d=25997,c=AUCT_CLAS_ARMOR},  -- Resilient Cape
	[14401]={b=8933,s=1786,d=25996,c=AUCT_CLAS_ARMOR},  -- Resilient Cap
	[14402]={b=4189,s=837,d=25994,c=AUCT_CLAS_ARMOR},  -- Resilient Bands
	[14403]={b=5088,s=1017,d=25999,c=AUCT_CLAS_ARMOR},  -- Resilient Handgrips
	[14404]={b=12359,s=2471,d=12973,c=AUCT_CLAS_ARMOR},  -- Resilient Leggings
	[14405]={b=12402,s=2480,d=27873,c=AUCT_CLAS_ARMOR},  -- Resilient Robe
	[14406]={b=4675,s=935,d=25998,c=AUCT_CLAS_ARMOR},  -- Resilient Cord
	[14407]={b=21331,s=4266,d=26028,c=AUCT_CLAS_ARMOR},  -- Stonecloth Vest
	[14408]={b=11376,s=2275,d=26026,c=AUCT_CLAS_ARMOR},  -- Stonecloth Boots
	[14409]={b=8535,s=1707,d=26027,c=AUCT_CLAS_ARMOR},  -- Stonecloth Cape
	[14410]={b=13549,s=2709,d=26033,c=AUCT_CLAS_ARMOR},  -- Stonecloth Circlet
	[14411]={b=6938,s=1387,d=26029,c=AUCT_CLAS_ARMOR},  -- Stonecloth Gloves
	[14412]={b=11494,s=2298,d=26035,c=AUCT_CLAS_ARMOR},  -- Stonecloth Epaulets
	[14413]={b=19736,s=3947,d=26038,c=AUCT_CLAS_ARMOR},  -- Stonecloth Robe
	[14414]={b=6381,s=1276,d=26024,c=AUCT_CLAS_ARMOR},  -- Stonecloth Belt
	[14415]={b=17051,s=3410,d=11166,c=AUCT_CLAS_ARMOR},  -- Stonecloth Britches
	[14416]={b=6429,s=1285,d=26025,c=AUCT_CLAS_ARMOR},  -- Stonecloth Bindings
	[14417]={b=29440,s=5888,d=26084,c=AUCT_CLAS_ARMOR},  -- Silksand Tunic
	[14418]={b=15490,s=3098,d=26086,c=AUCT_CLAS_ARMOR},  -- Silksand Boots
	[14419]={b=9596,s=1919,d=26079,c=AUCT_CLAS_ARMOR},  -- Silksand Bracers
	[14420]={b=14446,s=2889,d=26080,c=AUCT_CLAS_ARMOR},  -- Silksand Cape
	[14421]={b=19725,s=3945,d=26093,c=AUCT_CLAS_ARMOR},  -- Silksand Circlet
	[14422]={b=11314,s=2262,d=26081,c=AUCT_CLAS_ARMOR},  -- Silksand Gloves
	[14423]={b=17033,s=3406,d=26096,c=AUCT_CLAS_ARMOR},  -- Silksand Shoulder Pads
	[14424]={b=26584,s=5316,d=26083,c=AUCT_CLAS_ARMOR},  -- Silksand Legwraps
	[14425]={b=31118,s=6223,d=26092,c=AUCT_CLAS_ARMOR},  -- Silksand Wraps
	[14426]={b=10626,s=2125,d=16781,c=AUCT_CLAS_ARMOR},  -- Silksand Girdle
	[14427]={b=45623,s=9124,d=26161,c=AUCT_CLAS_ARMOR},  -- Windchaser Wraps
	[14428]={b=23586,s=4717,d=26153,c=AUCT_CLAS_ARMOR},  -- Windchaser Footpads
	[14429]={b=13220,s=2644,d=26151,c=AUCT_CLAS_ARMOR},  -- Windchaser Cuffs
	[14430]={b=18432,s=3686,d=26175,c=AUCT_CLAS_ARMOR},  -- Windchaser Cloak
	[14431]={b=14388,s=2877,d=26154,c=AUCT_CLAS_ARMOR},  -- Windchaser Handguards
	[14432]={b=23397,s=4679,d=4904,c=AUCT_CLAS_ARMOR},  -- Windchaser Amice
	[14433]={b=33822,s=6764,d=26159,c=AUCT_CLAS_ARMOR},  -- Windchaser Woolies
	[14434]={b=43531,s=8706,d=26174,c=AUCT_CLAS_ARMOR},  -- Windchaser Robes
	[14435]={b=13893,s=2778,d=26149,c=AUCT_CLAS_ARMOR},  -- Windchaser Cinch
	[14436]={b=26351,s=5270,d=26150,c=AUCT_CLAS_ARMOR},  -- Windchaser Coronet
	[14437]={b=60014,s=12002,d=16631,c=AUCT_CLAS_ARMOR},  -- Venomshroud Vest
	[14438]={b=30961,s=6192,d=16634,c=AUCT_CLAS_ARMOR},  -- Venomshroud Boots
	[14439]={b=19180,s=3836,d=16636,c=AUCT_CLAS_ARMOR},  -- Venomshroud Armguards
	[14440]={b=26737,s=5347,d=26201,c=AUCT_CLAS_ARMOR},  -- Venomshroud Cape
	[14441]={b=35834,s=7166,d=26305,c=AUCT_CLAS_ARMOR},  -- Venomshroud Mask
	[14442]={b=22407,s=4481,d=16633,c=AUCT_CLAS_ARMOR},  -- Venomshroud Mitts
	[14443]={b=33729,s=6745,d=16637,c=AUCT_CLAS_ARMOR},  -- Venomshroud Mantle
	[14444]={b=54775,s=10955,d=16632,c=AUCT_CLAS_ARMOR},  -- Venomshroud Leggings
	[14445]={b=61765,s=12353,d=19901,c=AUCT_CLAS_ARMOR},  -- Venomshroud Silk Robes
	[14446]={b=21241,s=4248,d=21459,c=AUCT_CLAS_ARMOR},  -- Venomshroud Belt
	[14447]={b=44008,s=8801,d=26171,c=AUCT_CLAS_ARMOR},  -- Highborne Footpads
	[14448]={b=27777,s=5555,d=26168,c=AUCT_CLAS_ARMOR},  -- Highborne Bracelets
	[14449]={b=50628,s=10125,d=26170,c=AUCT_CLAS_ARMOR},  -- Highborne Crown
	[14450]={b=36824,s=7364,d=26184,c=AUCT_CLAS_ARMOR},  -- Highborne Cloak
	[14451]={b=27684,s=5536,d=18423,c=AUCT_CLAS_ARMOR},  -- Highborne Gloves
	[14452]={b=44184,s=8836,d=26182,c=AUCT_CLAS_ARMOR},  -- Highborne Pauldrons
	[14453]={b=78386,s=15677,d=26157,c=AUCT_CLAS_ARMOR},  -- Highborne Robes
	[14454]={b=27993,s=5598,d=26169,c=AUCT_CLAS_ARMOR},  -- Highborne Cord
	[14455]={b=78962,s=15792,d=26178,c=AUCT_CLAS_ARMOR},  -- Highborne Padded Armor
	[14457]={b=37878,s=7575,d=26235,c=AUCT_CLAS_ARMOR},  -- Elunarian Cuffs
	[14458]={b=62867,s=12573,d=26231,c=AUCT_CLAS_ARMOR},  -- Elunarian Boots
	[14459]={b=53991,s=10798,d=26233,c=AUCT_CLAS_ARMOR},  -- Elunarian Cloak
	[14460]={b=73309,s=14661,d=26243,c=AUCT_CLAS_ARMOR},  -- Elunarian Diadem
	[14461]={b=46714,s=9342,d=26236,c=AUCT_CLAS_ARMOR},  -- Elunarian Handgrips
	[14462]={b=93758,s=18751,d=26238,c=AUCT_CLAS_ARMOR},  -- Elunarian Sarong
	[14463]={b=70572,s=14114,d=26247,c=AUCT_CLAS_ARMOR},  -- Elunarian Spaulders
	[14465]={b=42980,s=8596,d=26230,c=AUCT_CLAS_ARMOR},  -- Elunarian Belt
	[14466]={b=12000,s=3000,d=1102},  -- Pattern: Frostweave Tunic
	[14467]={b=12000,s=3000,d=1102},  -- Pattern: Frostweave Robe
	[14468]={b=12000,s=3000,d=1102},  -- Pattern: Runecloth Bag
	[14469]={b=12000,s=3000,d=1102},  -- Pattern: Runecloth Robe
	[14470]={b=12000,s=3000,d=1102},  -- Pattern: Runecloth Tunic
	[14471]={b=12000,s=3000,d=1102},  -- Pattern: Cindercloth Vest
	[14472]={b=12000,s=3000,d=1102},  -- Pattern: Runecloth Cloak
	[14473]={b=12000,s=3000,d=1102},  -- Pattern: Ghostweave Belt
	[14474]={b=12000,s=3000,d=1102},  -- Pattern: Frostweave Gloves
	[14476]={b=14000,s=3500,d=1102},  -- Pattern: Cindercloth Gloves
	[14477]={b=14000,s=3500,d=1102},  -- Pattern: Ghostweave Gloves
	[14478]={b=14000,s=3500,d=1102},  -- Pattern: Brightcloth Robe
	[14479]={b=14000,s=3500,d=1102},  -- Pattern: Brightcloth Gloves
	[14480]={b=16000,s=4000,d=1102},  -- Pattern: Ghostweave Vest
	[14481]={b=16000,s=4000,d=1102},  -- Pattern: Runecloth Gloves
	[14482]={b=16000,s=4000,d=1102},  -- Pattern: Cindercloth Cloak
	[14483]={b=16000,s=4000,d=1102},  -- Pattern: Felcloth Pants
	[14484]={b=16000,s=4000,d=1102},  -- Pattern: Brightcloth Cloak
	[14485]={b=16000,s=4000,d=1102},  -- Pattern: Wizardweave Leggings
	[14486]={b=40000,s=10000,d=1102},  -- Pattern: Cloak of Fire
	[14487]={b=266113,s=53222,d=25096,c=AUCT_CLAS_WEAPON},  -- Bonechill Hammer
	[14488]={b=20000,s=5000,d=1102},  -- Pattern: Runecloth Boots
	[14489]={b=20000,s=5000,d=1102},  -- Pattern: Frostweave Pants
	[14490]={b=20000,s=5000,d=1102},  -- Pattern: Cindercloth Pants
	[14491]={b=20000,s=5000,d=1102},  -- Pattern: Runecloth Pants
	[14492]={b=20000,s=5000,d=1102},  -- Pattern: Felcloth Boots
	[14493]={b=20000,s=5000,d=1102},  -- Pattern: Robe of Winter Night
	[14494]={b=22000,s=5500,d=1102},  -- Pattern: Brightcloth Pants
	[14496]={b=22000,s=5500,d=1102},  -- Pattern: Felcloth Hood
	[14497]={b=22000,s=5500,d=1102},  -- Pattern: Mooncloth Leggings
	[14498]={b=25000,s=6250,d=1102},  -- Pattern: Runecloth Headband
	[14499]={b=30000,s=7500,d=1102},  -- Pattern: Mooncloth Bag
	[14500]={b=30000,s=7500,d=1102},  -- Pattern: Wizardweave Robe
	[14501]={b=30000,s=7500,d=1102},  -- Pattern: Mooncloth Vest
	[14502]={b=65259,s=13051,d=28757,c=AUCT_CLAS_ARMOR},  -- Frostbite Girdle
	[14503]={b=98260,s=19652,d=25104,c=AUCT_CLAS_ARMOR},  -- Death's Clutch
	[14504]={b=40000,s=10000,d=1102},  -- Pattern: Runecloth Shoulders
	[14505]={b=40000,s=10000,d=1102},  -- Pattern: Wizardweave Turban
	[14506]={b=40000,s=10000,d=1102},  -- Pattern: Felcloth Robe
	[14507]={b=40000,s=10000,d=1102},  -- Pattern: Mooncloth Shoulders
	[14508]={b=60000,s=15000,d=1102},  -- Pattern: Felcloth Shoulders
	[14512]={b=60000,s=15000,d=1102},  -- Pattern: Truefaith Vestments
	[14513]={b=60000,s=15000,d=1102},  -- Pattern: Robe of the Archmage
	[14514]={b=60000,s=15000,d=1102},  -- Pattern: Robe of the Void
	[14522]={b=156591,s=31318,d=25111,c=AUCT_CLAS_ARMOR},  -- Maelstrom Leggings
	[14523]={b=0,s=0,d=25118},  -- Demon Pick
	[14525]={b=52805,s=10561,d=25116,c=AUCT_CLAS_ARMOR},  -- Boneclenched Gauntlets
	[14526]={b=20000,s=5000,d=1102,c=AUCT_CLAS_CLOTH,u=AUCT_TYPE_TAILOR},  -- Pattern: Mooncloth
	[14528]={b=170909,s=34181,d=25138,c=AUCT_CLAS_WEAPON},  -- Rattlecage Buckler
	[14529]={b=2000,s=500,d=25146,x=20},  -- Runecloth Bandage
	[14530]={b=4000,s=1000,d=25147,x=20},  -- Heavy Runecloth Bandage
	[14531]={b=299458,s=59891,d=25148,c=AUCT_CLAS_WEAPON},  -- Frightskull Shaft
	[14536]={b=161356,s=32271,d=25157,c=AUCT_CLAS_ARMOR},  -- Bonebrace Hauberk
	[14537]={b=70839,s=14167,d=25160,c=AUCT_CLAS_ARMOR},  -- Corpselight Greaves
	[14538]={b=85312,s=17062,d=28705,c=AUCT_CLAS_ARMOR},  -- Deadwalker Mantle
	[14539]={b=107021,s=21404,d=25166,c=AUCT_CLAS_ARMOR},  -- Bone Ring Helm
	[14540]={b=0,s=0,d=3422},  -- Taragaman the Hungerer's Heart
	[14541]={b=342132,s=68426,d=25649,c=AUCT_CLAS_WEAPON},  -- Barovian Family Sword
	[14542]={b=0,s=0,d=11449},  -- Kravel's Crate
	[14543]={b=43661,s=8732,d=28703,c=AUCT_CLAS_ARMOR},  -- Darkshade Gloves
	[14544]={b=0,s=0,d=22952},  -- Lieutenant's Insignia
	[14545]={b=109989,s=21997,d=25169,c=AUCT_CLAS_ARMOR},  -- Ghostloom Leggings
	[14546]={b=0,s=0,d=5766},  -- Roon's Kodo Horn
	[14547]={b=0,s=0,d=25171},  -- Hand of Iruxos
	[14548]={b=103303,s=20660,d=28817,c=AUCT_CLAS_ARMOR},  -- Royal Cap Spaulders
	[14549]={b=39038,s=7807,d=28276,c=AUCT_CLAS_ARMOR},  -- Boots of Avoidance
	[14551]={b=53008,s=10601,d=28280,c=AUCT_CLAS_ARMOR},  -- Edgemaster's Handguards
	[14552]={b=76890,s=15378,d=28282,c=AUCT_CLAS_ARMOR},  -- Stockade Pauldrons
	[14553]={b=88667,s=17733,d=28386,c=AUCT_CLAS_ARMOR},  -- Sash of Mercy
	[14554]={b=149502,s=29900,d=25343,c=AUCT_CLAS_ARMOR},  -- Cloudkeeper Legplates
	[14555]={b=393863,s=78772,d=25612,c=AUCT_CLAS_WEAPON},  -- Alcor's Sunrazor
	[14557]={b=71520,s=17880,d=6338,c=AUCT_CLAS_ARMOR},  -- The Lion Horn of Stormwind
	[14558]={b=42000,s=10500,d=9857,c=AUCT_CLAS_ARMOR},  -- Lady Maye's Pendant
	[14559]={b=1398,s=279,d=27520,c=AUCT_CLAS_ARMOR},  -- Prospector's Sash
	[14560]={b=2421,s=484,d=27524,c=AUCT_CLAS_ARMOR},  -- Prospector's Boots
	[14561]={b=1225,s=245,d=17014,c=AUCT_CLAS_ARMOR},  -- Prospector's Cuffs
	[14562]={b=5199,s=1039,d=27518,c=AUCT_CLAS_ARMOR},  -- Prospector's Chestpiece
	[14563]={b=1377,s=275,d=27525,c=AUCT_CLAS_ARMOR},  -- Prospector's Cloak
	[14564]={b=1523,s=304,d=27519,c=AUCT_CLAS_ARMOR},  -- Prospector's Mitts
	[14565]={b=4045,s=809,d=27522,c=AUCT_CLAS_ARMOR},  -- Prospector's Woolies
	[14566]={b=5054,s=1010,d=27523,c=AUCT_CLAS_ARMOR},  -- Prospector's Pads
	[14567]={b=2648,s=529,d=27668,c=AUCT_CLAS_ARMOR},  -- Bristlebark Belt
	[14568]={b=3987,s=797,d=16997,c=AUCT_CLAS_ARMOR},  -- Bristlebark Boots
	[14569]={b=2360,s=472,d=13355,c=AUCT_CLAS_ARMOR},  -- Bristlebark Bindings
	[14570]={b=9350,s=1870,d=27669,c=AUCT_CLAS_ARMOR},  -- Bristlebark Blouse
	[14571]={b=2481,s=496,d=27673,c=AUCT_CLAS_ARMOR},  -- Bristlebark Cape
	[14572]={b=3047,s=609,d=27672,c=AUCT_CLAS_ARMOR},  -- Bristlebark Gloves
	[14573]={b=6445,s=1289,d=27667,c=AUCT_CLAS_ARMOR},  -- Bristlebark Amice
	[14574]={b=7840,s=1568,d=27670,c=AUCT_CLAS_ARMOR},  -- Bristlebark Britches
	[14576]={b=243853,s=48770,d=25173,c=AUCT_CLAS_WEAPON},  -- Ebon Hilt of Marduk
	[14577]={b=107926,s=21585,d=28715,c=AUCT_CLAS_ARMOR},  -- Skullsmoke Pants
	[14578]={b=4916,s=983,d=27963,c=AUCT_CLAS_ARMOR},  -- Dokebi Cord
	[14579]={b=8958,s=1791,d=27965,c=AUCT_CLAS_ARMOR},  -- Dokebi Boots
	[14580]={b=4093,s=818,d=27964,c=AUCT_CLAS_ARMOR},  -- Dokebi Bracers
	[14581]={b=14562,s=2912,d=27962,c=AUCT_CLAS_ARMOR},  -- Dokebi Chestguard
	[14582]={b=5444,s=1088,d=27584,c=AUCT_CLAS_ARMOR},  -- Dokebi Cape
	[14583]={b=6668,s=1333,d=27966,c=AUCT_CLAS_ARMOR},  -- Dokebi Gloves
	[14584]={b=13365,s=2673,d=27968,c=AUCT_CLAS_ARMOR},  -- Dokebi Hat
	[14585]={b=13438,s=2687,d=27967,c=AUCT_CLAS_ARMOR},  -- Dokebi Leggings
	[14587]={b=10153,s=2030,d=10179,c=AUCT_CLAS_ARMOR},  -- Dokebi Mantle
	[14588]={b=9947,s=1989,d=27976,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Cord
	[14589]={b=16473,s=3294,d=9169,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Shoes
	[14590]={b=9109,s=1821,d=14770,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Bracers
	[14591]={b=20903,s=4180,d=21311,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Helm
	[14592]={b=27974,s=5594,d=27979,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Tunic
	[14593]={b=11051,s=2210,d=27980,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Cloak
	[14594]={b=11182,s=2236,d=27977,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Gloves
	[14595]={b=22502,s=4500,d=27975,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Breeches
	[14596]={b=16942,s=3388,d=27978,c=AUCT_CLAS_ARMOR},  -- Hawkeye's Epaulets
	[14598]={b=13275,s=2655,d=27983,c=AUCT_CLAS_ARMOR},  -- Warden's Waistband
	[14599]={b=23316,s=4663,d=27982,c=AUCT_CLAS_ARMOR},  -- Warden's Footpads
	[14600]={b=13377,s=2675,d=27985,c=AUCT_CLAS_ARMOR},  -- Warden's Wristbands
	[14601]={b=36535,s=7307,d=14995,c=AUCT_CLAS_ARMOR},  -- Warden's Wraps
	[14602]={b=14975,s=2995,d=27986,c=AUCT_CLAS_ARMOR},  -- Warden's Cloak
	[14603]={b=21916,s=4383,d=27988,c=AUCT_CLAS_ARMOR},  -- Warden's Mantle
	[14604]={b=29930,s=5986,d=27987,c=AUCT_CLAS_ARMOR},  -- Warden's Wizard Hat
	[14605]={b=34340,s=6868,d=27984,c=AUCT_CLAS_ARMOR},  -- Warden's Woolies
	[14606]={b=14775,s=2955,d=15000,c=AUCT_CLAS_ARMOR},  -- Warden's Gloves
	[14607]={b=27906,s=5581,d=27981,c=AUCT_CLAS_WEAPON},  -- Hawkeye's Buckler
	[14608]={b=15810,s=3162,d=18487,c=AUCT_CLAS_WEAPON},  -- Dokebi Buckler
	[14610]={b=0,s=0,d=25184},  -- Araj's Scarab
	[14611]={b=162547,s=32509,d=25222,c=AUCT_CLAS_ARMOR},  -- Bloodmail Hauberk
	[14612]={b=135925,s=27185,d=25223,c=AUCT_CLAS_ARMOR},  -- Bloodmail Legguards
	[14613]={b=0,s=0,d=6505},  -- Taelan's Hammer
	[14614]={b=68445,s=13689,d=25219,c=AUCT_CLAS_ARMOR},  -- Bloodmail Belt
	[14615]={b=62152,s=12430,d=25221,c=AUCT_CLAS_ARMOR},  -- Bloodmail Gauntlets
	[14616]={b=93996,s=18799,d=25220,c=AUCT_CLAS_ARMOR},  -- Bloodmail Boots
	[14617]={b=25000,s=6250,d=25193,c=AUCT_CLAS_ARMOR},  -- Sawbones Shirt
	[14619]={b=0,s=0,d=13806,q=20,x=20},  -- Skeletal Fragments
	[14620]={b=42231,s=8446,d=25225,c=AUCT_CLAS_ARMOR},  -- Deathbone Girdle
	[14621]={b=63588,s=12717,d=25227,c=AUCT_CLAS_ARMOR},  -- Deathbone Sabatons
	[14622]={b=42553,s=8510,d=25224,c=AUCT_CLAS_ARMOR},  -- Deathbone Gauntlets
	[14623]={b=85428,s=17085,d=25226,c=AUCT_CLAS_ARMOR},  -- Deathbone Legguards
	[14624]={b=102891,s=20578,d=24102,c=AUCT_CLAS_ARMOR},  -- Deathbone Chestplate
	[14625]={b=0,s=0,d=23520},  -- Symbol of Lost Honor
	[14626]={b=103664,s=20732,d=25245,c=AUCT_CLAS_ARMOR},  -- Necropile Robe
	[14627]={b=800,s=200,d=1102},  -- Pattern: Bright Yellow Shirt
	[14628]={b=0,s=0,d=25246},  -- Imbued Skeletal Fragments
	[14629]={b=44825,s=8965,d=4607,c=AUCT_CLAS_ARMOR},  -- Necropile Cuffs
	[14630]={b=1000,s=250,d=1102},  -- Pattern: Enchanter's Cowl
	[14631]={b=67714,s=13542,d=18863,c=AUCT_CLAS_ARMOR},  -- Necropile Boots
	[14632]={b=90608,s=18121,d=25255,c=AUCT_CLAS_ARMOR},  -- Necropile Leggings
	[14633]={b=68197,s=13639,d=25247,c=AUCT_CLAS_ARMOR},  -- Necropile Mantle
	[14634]={b=2500,s=625,d=15274,u=AUCT_TYPE_ENGINEER..", "..AUCT_TYPE_SMITH..", "..AUCT_TYPE_TAILOR},  -- Recipe: Frost Oil
	[14635]={b=3000,s=750,d=1102},  -- Pattern: Gem-studded Leather Belt
	[14636]={b=51983,s=10396,d=25248,c=AUCT_CLAS_ARMOR},  -- Cadaverous Belt
	[14637]={b=125244,s=25048,d=25249,c=AUCT_CLAS_ARMOR},  -- Cadaverous Armor
	[14638]={b=104773,s=20954,d=26966,c=AUCT_CLAS_ARMOR},  -- Cadaverous Leggings
	[14639]={b=1500,s=375,d=1102},  -- Schematic: Minor Recombobulator
	[14640]={b=52783,s=10556,d=25253,c=AUCT_CLAS_ARMOR},  -- Cadaverous Gloves
	[14641]={b=79477,s=15895,d=11571,c=AUCT_CLAS_ARMOR},  -- Cadaverous Walkers
	[14644]={b=0,s=0,d=18204},  -- Skeleton Key Mold
	[14645]={b=0,s=0,d=22464},  -- Unfinished Skeleton Key
	[14646]={b=0,s=0,d=18499,c=AUCT_CLAS_QUEST},  -- Northshire Gift Voucher
	[14647]={b=0,s=0,d=18499,c=AUCT_CLAS_QUEST},  -- Coldridge Valley Gift Voucher
	[14648]={b=0,s=0,d=18499,c=AUCT_CLAS_QUEST},  -- Shadowglen Gift Voucher
	[14649]={b=0,s=0,d=18499,c=AUCT_CLAS_QUEST},  -- Valley of Trials Gift Voucher
	[14650]={b=0,s=0,d=18499,c=AUCT_CLAS_QUEST},  -- Camp Narache Gift Voucher
	[14651]={b=0,s=0,d=18499,c=AUCT_CLAS_QUEST},  -- Deathknell Gift Voucher
	[14652]={b=21079,s=4215,d=27579,c=AUCT_CLAS_ARMOR},  -- Scorpashi Sash
	[14653]={b=34271,s=6854,d=18944,c=AUCT_CLAS_ARMOR},  -- Scorpashi Slippers
	[14654]={b=19655,s=3931,d=27582,c=AUCT_CLAS_ARMOR},  -- Scorpashi Wristbands
	[14655]={b=51962,s=10392,d=27576,c=AUCT_CLAS_ARMOR},  -- Scorpashi Breastplate
	[14656]={b=21500,s=4300,d=27584,c=AUCT_CLAS_ARMOR},  -- Scorpashi Cape
	[14657]={b=20979,s=4195,d=27577,c=AUCT_CLAS_ARMOR},  -- Scorpashi Gloves
	[14658]={b=39422,s=7884,d=27581,c=AUCT_CLAS_ARMOR},  -- Scorpashi Skullcap
	[14659]={b=46912,s=9382,d=27578,c=AUCT_CLAS_ARMOR},  -- Scorpashi Leggings
	[14660]={b=35315,s=7063,d=27580,c=AUCT_CLAS_ARMOR},  -- Scorpashi Shoulder Pads
	[14661]={b=27305,s=5461,d=27566,c=AUCT_CLAS_ARMOR},  -- Keeper's Cord
	[14662]={b=47065,s=9413,d=27568,c=AUCT_CLAS_ARMOR},  -- Keeper's Hooves
	[14663]={b=25707,s=5141,d=27565,c=AUCT_CLAS_ARMOR},  -- Keeper's Bindings
	[14664]={b=75293,s=15058,d=27564,c=AUCT_CLAS_ARMOR},  -- Keeper's Armor
	[14665]={b=31072,s=6214,d=27573,c=AUCT_CLAS_ARMOR},  -- Keeper's Cloak
	[14666]={b=31836,s=6367,d=27567,c=AUCT_CLAS_ARMOR},  -- Keeper's Gloves
	[14667]={b=53852,s=10770,d=27572,c=AUCT_CLAS_ARMOR},  -- Keeper's Wreath
	[14668]={b=67984,s=13596,d=27570,c=AUCT_CLAS_ARMOR},  -- Keeper's Woolies
	[14669]={b=48270,s=9654,d=27569,c=AUCT_CLAS_ARMOR},  -- Keeper's Mantle
	[14670]={b=101980,s=20396,d=27649,c=AUCT_CLAS_ARMOR},  -- Pridelord Armor
	[14671]={b=65062,s=13012,d=18944,c=AUCT_CLAS_ARMOR},  -- Pridelord Boots
	[14672]={b=36548,s=7309,d=27582,c=AUCT_CLAS_ARMOR},  -- Pridelord Bands
	[14673]={b=41518,s=8303,d=27653,c=AUCT_CLAS_ARMOR},  -- Pridelord Cape
	[14674]={b=41353,s=8270,d=27579,c=AUCT_CLAS_ARMOR},  -- Pridelord Girdle
	[14675]={b=40910,s=8182,d=27648,c=AUCT_CLAS_ARMOR},  -- Pridelord Gloves
	[14676]={b=69205,s=13841,d=21299,c=AUCT_CLAS_ARMOR},  -- Pridelord Halo
	[14677]={b=92621,s=18524,d=27651,c=AUCT_CLAS_ARMOR},  -- Pridelord Pants
	[14678]={b=65780,s=13156,d=27652,c=AUCT_CLAS_ARMOR},  -- Pridelord Pauldrons
	[14679]={b=0,s=0,d=25271,c=AUCT_CLAS_WRITTEN},  -- Of Love and Family
	[14680]={b=125507,s=25101,d=18470,c=AUCT_CLAS_ARMOR},  -- Indomitable Vest
	[14681]={b=85696,s=17139,d=17258,c=AUCT_CLAS_ARMOR},  -- Indomitable Boots
	[14682]={b=49534,s=9906,d=17259,c=AUCT_CLAS_ARMOR},  -- Indomitable Armguards
	[14683]={b=59660,s=11932,d=27573,c=AUCT_CLAS_ARMOR},  -- Indomitable Cloak
	[14684]={b=52389,s=10477,d=15411,c=AUCT_CLAS_ARMOR},  -- Indomitable Belt
	[14685]={b=57970,s=11594,d=17263,c=AUCT_CLAS_ARMOR},  -- Indomitable Gauntlets
	[14686]={b=91636,s=18327,d=17321,c=AUCT_CLAS_ARMOR},  -- Indomitable Headdress
	[14687]={b=116787,s=23357,d=17265,c=AUCT_CLAS_ARMOR},  -- Indomitable Leggings
	[14688]={b=83712,s=16742,d=17267,c=AUCT_CLAS_ARMOR},  -- Indomitable Epaulets
	[14722]={b=2121,s=424,d=26983,c=AUCT_CLAS_ARMOR},  -- War Paint Anklewraps
	[14723]={b=1450,s=290,d=26982,c=AUCT_CLAS_ARMOR},  -- War Paint Bindings
	[14724]={b=1265,s=253,d=26958,c=AUCT_CLAS_ARMOR},  -- War Paint Cloak
	[14725]={b=1460,s=292,d=26987,c=AUCT_CLAS_ARMOR},  -- War Paint Waistband
	[14726]={b=1685,s=337,d=26985,c=AUCT_CLAS_ARMOR},  -- War Paint Gloves
	[14727]={b=3890,s=778,d=26986,c=AUCT_CLAS_ARMOR},  -- War Paint Legguards
	[14728]={b=2428,s=485,d=26988,c=AUCT_CLAS_ARMOR},  -- War Paint Shoulder Pads
	[14729]={b=4350,s=870,d=23835,c=AUCT_CLAS_WEAPON},  -- War Paint Shield
	[14730]={b=6119,s=1223,d=26984,c=AUCT_CLAS_ARMOR},  -- War Paint Chestpiece
	[14742]={b=5592,s=1118,d=27009,c=AUCT_CLAS_ARMOR},  -- Hulking Boots
	[14743]={b=2916,s=583,d=27007,c=AUCT_CLAS_ARMOR},  -- Hulking Bands
	[14744]={b=11551,s=2310,d=27010,c=AUCT_CLAS_ARMOR},  -- Hulking Chestguard
	[14745]={b=2221,s=444,d=27011,c=AUCT_CLAS_ARMOR},  -- Hulking Cloak
	[14746]={b=2947,s=589,d=27008,c=AUCT_CLAS_ARMOR},  -- Hulking Belt
	[14747]={b=3343,s=668,d=27012,c=AUCT_CLAS_ARMOR},  -- Hulking Gauntlets
	[14748]={b=7752,s=1550,d=27013,c=AUCT_CLAS_ARMOR},  -- Hulking Leggings
	[14749]={b=6625,s=1325,d=27014,c=AUCT_CLAS_ARMOR},  -- Hulking Spaulders
	[14750]={b=5340,s=1068,d=27026,c=AUCT_CLAS_ARMOR},  -- Slayer's Cuffs
	[14751]={b=17271,s=3454,d=27034,c=AUCT_CLAS_ARMOR},  -- Slayer's Surcoat
	[14752]={b=4892,s=978,d=27033,c=AUCT_CLAS_ARMOR},  -- Slayer's Cape
	[14753]={b=13052,s=2610,d=27191,c=AUCT_CLAS_ARMOR},  -- Slayer's Skullcap
	[14754]={b=5965,s=1193,d=27027,c=AUCT_CLAS_ARMOR},  -- Slayer's Gloves
	[14755]={b=5590,s=1118,d=27029,c=AUCT_CLAS_ARMOR},  -- Slayer's Sash
	[14756]={b=9300,s=1860,d=27035,c=AUCT_CLAS_ARMOR},  -- Slayer's Slippers
	[14757]={b=16491,s=3298,d=27028,c=AUCT_CLAS_ARMOR},  -- Slayer's Pants
	[14758]={b=11335,s=2267,d=27030,c=AUCT_CLAS_ARMOR},  -- Slayer's Shoulder Pads
	[14759]={b=10049,s=2009,d=27048,c=AUCT_CLAS_ARMOR},  -- Enduring Bracers
	[14760]={b=31318,s=6263,d=27049,c=AUCT_CLAS_ARMOR},  -- Enduring Breastplate
	[14761]={b=10122,s=2024,d=27046,c=AUCT_CLAS_ARMOR},  -- Enduring Belt
	[14762]={b=20373,s=4074,d=27047,c=AUCT_CLAS_ARMOR},  -- Enduring Boots
	[14763]={b=8425,s=1685,d=27051,c=AUCT_CLAS_ARMOR},  -- Enduring Cape
	[14764]={b=11254,s=2250,d=27053,c=AUCT_CLAS_ARMOR},  -- Enduring Gauntlets
	[14765]={b=22139,s=4427,d=27052,c=AUCT_CLAS_ARMOR},  -- Enduring Circlet
	[14766]={b=27430,s=5486,d=27050,c=AUCT_CLAS_ARMOR},  -- Enduring Breeches
	[14767]={b=22393,s=4478,d=27054,c=AUCT_CLAS_ARMOR},  -- Enduring Pauldrons
	[14768]={b=42834,s=8566,d=27092,c=AUCT_CLAS_ARMOR},  -- Ravager's Armor
	[14769]={b=27772,s=5554,d=27093,c=AUCT_CLAS_ARMOR},  -- Ravager's Sandals
	[14770]={b=15864,s=3172,d=27091,c=AUCT_CLAS_ARMOR},  -- Ravager's Armguards
	[14771]={b=15150,s=3030,d=26141,c=AUCT_CLAS_ARMOR},  -- Ravager's Cloak
	[14772]={b=16423,s=3284,d=29007,c=AUCT_CLAS_ARMOR},  -- Ravager's Handwraps
	[14773]={b=15263,s=3052,d=27094,c=AUCT_CLAS_ARMOR},  -- Ravager's Cord
	[14774]={b=31262,s=6252,d=28175,c=AUCT_CLAS_ARMOR},  -- Ravager's Crown
	[14775]={b=41836,s=8367,d=27097,c=AUCT_CLAS_ARMOR},  -- Ravager's Woolies
	[14776]={b=31633,s=6326,d=27096,c=AUCT_CLAS_ARMOR},  -- Ravager's Mantle
	[14777]={b=48551,s=9710,d=27099,c=AUCT_CLAS_WEAPON},  -- Ravager's Shield
	[14778]={b=24666,s=4933,d=21756,c=AUCT_CLAS_ARMOR},  -- Khan's Bindings
	[14779]={b=66738,s=13347,d=27147,c=AUCT_CLAS_ARMOR},  -- Khan's Chestpiece
	[14780]={b=71446,s=14289,d=20833,c=AUCT_CLAS_WEAPON},  -- Khan's Buckler
	[14781]={b=23089,s=4617,d=27152,c=AUCT_CLAS_ARMOR},  -- Khan's Cloak
	[14782]={b=25023,s=5004,d=27148,c=AUCT_CLAS_ARMOR},  -- Khan's Gloves
	[14783]={b=27123,s=5424,d=27146,c=AUCT_CLAS_ARMOR},  -- Khan's Belt
	[14784]={b=41011,s=8202,d=27149,c=AUCT_CLAS_ARMOR},  -- Khan's Greaves
	[14785]={b=47794,s=9558,d=27151,c=AUCT_CLAS_ARMOR},  -- Khan's Helmet
	[14786]={b=59209,s=11841,d=27150,c=AUCT_CLAS_ARMOR},  -- Khan's Legguards
	[14787]={b=41618,s=8323,d=16079,c=AUCT_CLAS_ARMOR},  -- Khan's Mantle
	[14788]={b=32042,s=6408,d=27154,c=AUCT_CLAS_ARMOR},  -- Protector Armguards
	[14789]={b=87708,s=17541,d=27155,c=AUCT_CLAS_ARMOR},  -- Protector Breastplate
	[14790]={b=93907,s=18781,d=27162,c=AUCT_CLAS_WEAPON},  -- Protector Buckler
	[14791]={b=30282,s=6056,d=27161,c=AUCT_CLAS_ARMOR},  -- Protector Cape
	[14792]={b=34800,s=6960,d=27156,c=AUCT_CLAS_ARMOR},  -- Protector Gauntlets
	[14793]={b=34926,s=6985,d=27159,c=AUCT_CLAS_ARMOR},  -- Protector Waistband
	[14794]={b=52818,s=10563,d=27158,c=AUCT_CLAS_ARMOR},  -- Protector Ankleguards
	[14795]={b=63454,s=12690,d=26115,c=AUCT_CLAS_ARMOR},  -- Protector Helm
	[14796]={b=84917,s=16983,d=27157,c=AUCT_CLAS_ARMOR},  -- Protector Legguards
	[14797]={b=57137,s=11427,d=27160,c=AUCT_CLAS_ARMOR},  -- Protector Pads
	[14798]={b=120185,s=24037,d=27194,c=AUCT_CLAS_ARMOR},  -- Bloodlust Breastplate
	[14799]={b=86542,s=17308,d=27192,c=AUCT_CLAS_ARMOR},  -- Bloodlust Boots
	[14800]={b=129132,s=25826,d=27202,c=AUCT_CLAS_WEAPON},  -- Bloodlust Buckler
	[14801]={b=40782,s=8156,d=27197,c=AUCT_CLAS_ARMOR},  -- Bloodlust Cape
	[14802]={b=48747,s=9749,d=27196,c=AUCT_CLAS_ARMOR},  -- Bloodlust Gauntlets
	[14803]={b=45438,s=9087,d=27185,c=AUCT_CLAS_ARMOR},  -- Bloodlust Belt
	[14804]={b=81482,s=16296,d=30800,c=AUCT_CLAS_ARMOR},  -- Bloodlust Helm
	[14805]={b=102886,s=20577,d=27195,c=AUCT_CLAS_ARMOR},  -- Bloodlust Britches
	[14806]={b=77804,s=15560,d=23490,c=AUCT_CLAS_ARMOR},  -- Bloodlust Epaulets
	[14807]={b=41058,s=8211,d=27193,c=AUCT_CLAS_ARMOR},  -- Bloodlust Bracelets
	[14808]={b=57907,s=11581,d=27137,c=AUCT_CLAS_ARMOR},  -- Warstrike Belt
	[14809]={b=101382,s=20276,d=27827,c=AUCT_CLAS_ARMOR},  -- Warstrike Sabatons
	[14810]={b=58345,s=11669,d=27136,c=AUCT_CLAS_ARMOR},  -- Warstrike Armsplints
	[14813]={b=53007,s=10601,d=27143,c=AUCT_CLAS_ARMOR},  -- Warstrike Cape
	[14814]={b=107967,s=21593,d=28986,c=AUCT_CLAS_ARMOR},  -- Warstrike Helmet
	[14815]={b=68803,s=13760,d=27536,c=AUCT_CLAS_ARMOR},  -- Warstrike Gauntlets
	[14816]={b=138101,s=27620,d=27140,c=AUCT_CLAS_ARMOR},  -- Warstrike Legguards
	[14817]={b=104419,s=20883,d=27142,c=AUCT_CLAS_ARMOR},  -- Warstrike Shoulder Pads
	[14821]={b=26452,s=5290,d=26811,c=AUCT_CLAS_ARMOR},  -- Symbolic Breastplate
	[14825]={b=42977,s=8595,d=25134,c=AUCT_CLAS_WEAPON},  -- Symbolic Crest
	[14826]={b=11557,s=2311,d=26812,c=AUCT_CLAS_ARMOR},  -- Symbolic Gauntlets
	[14827]={b=11600,s=2320,d=26810,c=AUCT_CLAS_ARMOR},  -- Symbolic Belt
	[14828]={b=18864,s=3772,d=26813,c=AUCT_CLAS_ARMOR},  -- Symbolic Greaves
	[14829]={b=25249,s=5049,d=26814,c=AUCT_CLAS_ARMOR},  -- Symbolic Legplates
	[14830]={b=19007,s=3801,d=26818,c=AUCT_CLAS_ARMOR},  -- Symbolic Pauldrons
	[14831]={b=20603,s=4120,d=27182,c=AUCT_CLAS_ARMOR},  -- Symbolic Crown
	[14832]={b=11819,s=2363,d=26815,c=AUCT_CLAS_ARMOR},  -- Symbolic Vambraces
	[14833]={b=14944,s=2988,d=29015,c=AUCT_CLAS_ARMOR},  -- Tyrant's Gauntlets
	[14834]={b=13889,s=2777,d=26685,c=AUCT_CLAS_ARMOR},  -- Tyrant's Armguards
	[14835]={b=40964,s=8192,d=26687,c=AUCT_CLAS_ARMOR},  -- Tyrant's Chestpiece
	[14838]={b=14460,s=2892,d=26686,c=AUCT_CLAS_ARMOR},  -- Tyrant's Belt
	[14839]={b=23509,s=4701,d=26690,c=AUCT_CLAS_ARMOR},  -- Tyrant's Greaves
	[14840]={b=39627,s=7925,d=26691,c=AUCT_CLAS_ARMOR},  -- Tyrant's Legplates
	[14841]={b=21423,s=4284,d=26688,c=AUCT_CLAS_ARMOR},  -- Tyrant's Epaulets
	[14842]={b=62415,s=12483,d=26693,c=AUCT_CLAS_WEAPON},  -- Tyrant's Shield
	[14843]={b=25180,s=5036,d=26692,c=AUCT_CLAS_ARMOR},  -- Tyrant's Helm
	[14844]={b=57358,s=11471,d=26820,c=AUCT_CLAS_ARMOR},  -- Sunscale Chestguard
	[14846]={b=22673,s=4534,d=27190,c=AUCT_CLAS_ARMOR},  -- Sunscale Gauntlets
	[14847]={b=21272,s=4254,d=26819,c=AUCT_CLAS_ARMOR},  -- Sunscale Belt
	[14848]={b=34271,s=6854,d=26822,c=AUCT_CLAS_ARMOR},  -- Sunscale Sabatons
	[14849]={b=41358,s=8271,d=27186,c=AUCT_CLAS_ARMOR},  -- Sunscale Helmet
	[14850]={b=52214,s=10442,d=26824,c=AUCT_CLAS_ARMOR},  -- Sunscale Legplates
	[14851]={b=37083,s=7416,d=26825,c=AUCT_CLAS_ARMOR},  -- Sunscale Spaulders
	[14852]={b=97100,s=19420,d=11925,c=AUCT_CLAS_WEAPON},  -- Sunscale Shield
	[14853]={b=20870,s=4174,d=26821,c=AUCT_CLAS_ARMOR},  -- Sunscale Wristguards
	[14854]={b=81023,s=16204,d=26846,c=AUCT_CLAS_ARMOR},  -- Vanguard Breastplate
	[14855]={b=32510,s=6502,d=26847,c=AUCT_CLAS_ARMOR},  -- Vanguard Gauntlets
	[14856]={b=30781,s=6156,d=26848,c=AUCT_CLAS_ARMOR},  -- Vanguard Girdle
	[14857]={b=46332,s=9266,d=26850,c=AUCT_CLAS_ARMOR},  -- Vanguard Sabatons
	[14858]={b=58702,s=11740,d=28985,c=AUCT_CLAS_ARMOR},  -- Vanguard Headdress
	[14859]={b=74102,s=14820,d=26849,c=AUCT_CLAS_ARMOR},  -- Vanguard Legplates
	[14860]={b=52616,s=10523,d=27876,c=AUCT_CLAS_ARMOR},  -- Vanguard Pauldrons
	[14861]={b=25227,s=5045,d=19760,c=AUCT_CLAS_ARMOR},  -- Vanguard Vambraces
	[14862]={b=91699,s=18339,d=26880,c=AUCT_CLAS_ARMOR},  -- Warleader's Breastplate
	[14863]={b=39759,s=7951,d=26881,c=AUCT_CLAS_ARMOR},  -- Warleader's Gauntlets
	[14864]={b=38012,s=7602,d=26879,c=AUCT_CLAS_ARMOR},  -- Warleader's Belt
	[14865]={b=60094,s=12018,d=26883,c=AUCT_CLAS_ARMOR},  -- Warleader's Greaves
	[14866]={b=66507,s=13301,d=27180,c=AUCT_CLAS_ARMOR},  -- Warleader's Crown
	[14867]={b=89014,s=17802,d=26884,c=AUCT_CLAS_ARMOR},  -- Warleader's Leggings
	[14868]={b=65547,s=13109,d=26885,c=AUCT_CLAS_ARMOR},  -- Warleader's Shoulders
	[14869]={b=37886,s=7577,d=26878,c=AUCT_CLAS_ARMOR},  -- Warleader's Bracers
	[14872]={b=0,s=0,d=15692},  -- Tirion's Gift
	[14894]={b=0,s=0,d=25542},  -- Lily Root
	[14895]={b=24524,s=4904,d=26654,c=AUCT_CLAS_ARMOR},  -- Saltstone Surcoat
	[14896]={b=17091,s=3418,d=26652,c=AUCT_CLAS_ARMOR},  -- Saltstone Sabatons
	[14897]={b=11434,s=2286,d=27838,c=AUCT_CLAS_ARMOR},  -- Saltstone Gauntlets
	[14898]={b=11475,s=2295,d=26650,c=AUCT_CLAS_ARMOR},  -- Saltstone Girdle
	[14899]={b=18655,s=3731,d=26656,c=AUCT_CLAS_ARMOR},  -- Saltstone Helm
	[14900]={b=21490,s=4298,d=26651,c=AUCT_CLAS_ARMOR},  -- Saltstone Legplates
	[14901]={b=17472,s=3494,d=26655,c=AUCT_CLAS_ARMOR},  -- Saltstone Shoulder Pads
	[14902]={b=37413,s=7482,d=23847,c=AUCT_CLAS_WEAPON},  -- Saltstone Shield
	[14903]={b=10866,s=2173,d=26646,c=AUCT_CLAS_ARMOR},  -- Saltstone Armsplints
	[14904]={b=46227,s=9245,d=27899,c=AUCT_CLAS_ARMOR},  -- Brutish Breastplate
	[14905]={b=16086,s=3217,d=27901,c=AUCT_CLAS_ARMOR},  -- Brutish Gauntlets
	[14906]={b=14947,s=2989,d=27902,c=AUCT_CLAS_ARMOR},  -- Brutish Belt
	[14907]={b=30619,s=6123,d=27906,c=AUCT_CLAS_ARMOR},  -- Brutish Helmet
	[14908]={b=40977,s=8195,d=27900,c=AUCT_CLAS_ARMOR},  -- Brutish Legguards
	[14909]={b=24486,s=4897,d=27904,c=AUCT_CLAS_ARMOR},  -- Brutish Shoulders
	[14910]={b=15168,s=3033,d=27903,c=AUCT_CLAS_ARMOR},  -- Brutish Armguards
	[14911]={b=26637,s=5327,d=27905,c=AUCT_CLAS_ARMOR},  -- Brutish Boots
	[14912]={b=76163,s=15232,d=11925,c=AUCT_CLAS_WEAPON},  -- Brutish Shield
	[14913]={b=33487,s=6697,d=26799,c=AUCT_CLAS_ARMOR},  -- Jade Greaves
	[14914]={b=17950,s=3590,d=26794,c=AUCT_CLAS_ARMOR},  -- Jade Bracers
	[14915]={b=57847,s=11569,d=26795,c=AUCT_CLAS_ARMOR},  -- Jade Breastplate
	[14916]={b=86272,s=17254,d=22805,c=AUCT_CLAS_WEAPON},  -- Jade Deflector
	[14917]={b=19659,s=3931,d=26798,c=AUCT_CLAS_ARMOR},  -- Jade Gauntlets
	[14918]={b=18273,s=3654,d=26792,c=AUCT_CLAS_ARMOR},  -- Jade Belt
	[14919]={b=38588,s=7717,d=27839,c=AUCT_CLAS_ARMOR},  -- Jade Circlet
	[14920]={b=48723,s=9744,d=26800,c=AUCT_CLAS_ARMOR},  -- Jade Legplates
	[14921]={b=32036,s=6407,d=26797,c=AUCT_CLAS_ARMOR},  -- Jade Epaulets
	[14922]={b=41366,s=8273,d=26874,c=AUCT_CLAS_ARMOR},  -- Lofty Sabatons
	[14923]={b=23024,s=4604,d=26869,c=AUCT_CLAS_ARMOR},  -- Lofty Armguards
	[14924]={b=70158,s=14031,d=26871,c=AUCT_CLAS_ARMOR},  -- Lofty Breastplate
	[14925]={b=52810,s=10562,d=28015,c=AUCT_CLAS_ARMOR},  -- Lofty Helm
	[14926]={b=27991,s=5598,d=26872,c=AUCT_CLAS_ARMOR},  -- Lofty Gauntlets
	[14927]={b=26505,s=5301,d=26870,c=AUCT_CLAS_ARMOR},  -- Lofty Belt
	[14928]={b=63368,s=12673,d=26873,c=AUCT_CLAS_ARMOR},  -- Lofty Legguards
	[14929]={b=44997,s=8999,d=26875,c=AUCT_CLAS_ARMOR},  -- Lofty Shoulder Pads
	[14930]={b=114751,s=22950,d=20974,c=AUCT_CLAS_WEAPON},  -- Lofty Shield
	[14931]={b=92743,s=18548,d=27932,c=AUCT_CLAS_ARMOR},  -- Heroic Armor
	[14932]={b=58922,s=11784,d=27829,c=AUCT_CLAS_ARMOR},  -- Heroic Greaves
	[14933]={b=39420,s=7884,d=27934,c=AUCT_CLAS_ARMOR},  -- Heroic Gauntlets
	[14934]={b=33770,s=6754,d=27935,c=AUCT_CLAS_ARMOR},  -- Heroic Girdle
	[14935]={b=59428,s=11885,d=27942,c=AUCT_CLAS_ARMOR},  -- Heroic Skullcap
	[14936]={b=83513,s=16702,d=27938,c=AUCT_CLAS_ARMOR},  -- Heroic Legplates
	[14937]={b=57030,s=11406,d=27940,c=AUCT_CLAS_ARMOR},  -- Heroic Pauldrons
	[14938]={b=32350,s=6470,d=27933,c=AUCT_CLAS_ARMOR},  -- Heroic Bracers
	[14939]={b=33965,s=6793,d=26636,c=AUCT_CLAS_ARMOR},  -- Warbringer's Chestguard
	[14940]={b=20297,s=4059,d=26643,c=AUCT_CLAS_ARMOR},  -- Warbringer's Sabatons 
	[14941]={b=12576,s=2515,d=26454,c=AUCT_CLAS_ARMOR},  -- Warbringer's Armsplints
	[14942]={b=12624,s=2524,d=26640,c=AUCT_CLAS_ARMOR},  -- Warbringer's Gauntlets
	[14943]={b=12671,s=2534,d=26634,c=AUCT_CLAS_ARMOR},  -- Warbringer's Belt
	[14944]={b=24031,s=4806,d=27512,c=AUCT_CLAS_ARMOR},  -- Warbringer's Crown
	[14945]={b=32162,s=6432,d=26641,c=AUCT_CLAS_ARMOR},  -- Warbringer's Legguards
	[14946]={b=20757,s=4151,d=26645,c=AUCT_CLAS_ARMOR},  -- Warbringer's Spaulders
	[14947]={b=55992,s=11198,d=23825,c=AUCT_CLAS_WEAPON},  -- Warbringer's Shield
	[14948]={b=51509,s=10301,d=26838,c=AUCT_CLAS_ARMOR},  -- Bloodforged Chestpiece
	[14949]={b=19535,s=3907,d=28996,c=AUCT_CLAS_ARMOR},  -- Bloodforged Gauntlets
	[14950]={b=18153,s=3630,d=26836,c=AUCT_CLAS_ARMOR},  -- Bloodforged Belt
	[14951]={b=29511,s=5902,d=26842,c=AUCT_CLAS_ARMOR},  -- Bloodforged Sabatons
	[14952]={b=36619,s=7323,d=26257,c=AUCT_CLAS_ARMOR},  -- Bloodforged Helmet
	[14953]={b=45794,s=9158,d=26840,c=AUCT_CLAS_ARMOR},  -- Bloodforged Legplates
	[14954]={b=76174,s=15234,d=26844,c=AUCT_CLAS_WEAPON},  -- Bloodforged Shield
	[14955]={b=27090,s=5418,d=26843,c=AUCT_CLAS_ARMOR},  -- Bloodforged Shoulder Pads
	[14956]={b=15543,s=3108,d=26837,c=AUCT_CLAS_ARMOR},  -- Bloodforged Bindings
	[14957]={b=36119,s=7223,d=26833,c=AUCT_CLAS_ARMOR},  -- High Chief's Sabatons
	[14958]={b=64694,s=12938,d=26827,c=AUCT_CLAS_ARMOR},  -- High Chief's Armor
	[14959]={b=25717,s=5143,d=26830,c=AUCT_CLAS_ARMOR},  -- High Chief's Gauntlets
	[14960]={b=24353,s=4870,d=26828,c=AUCT_CLAS_ARMOR},  -- High Chief's Belt
	[14961]={b=46295,s=9259,d=27835,c=AUCT_CLAS_ARMOR},  -- High Chief's Crown
	[14962]={b=58454,s=11690,d=26831,c=AUCT_CLAS_ARMOR},  -- High Chief's Legguards
	[14963]={b=41509,s=8301,d=26834,c=AUCT_CLAS_ARMOR},  -- High Chief's Pauldrons
	[14964]={b=108705,s=21741,d=23419,c=AUCT_CLAS_WEAPON},  -- High Chief's Shield
	[14965]={b=22252,s=4450,d=26829,c=AUCT_CLAS_ARMOR},  -- High Chief's Bindings
	[14966]={b=89006,s=17801,d=26859,c=AUCT_CLAS_ARMOR},  -- Glorious Breastplate
	[14967]={b=34337,s=6867,d=27833,c=AUCT_CLAS_ARMOR},  -- Glorious Gauntlets
	[14968]={b=32510,s=6502,d=26856,c=AUCT_CLAS_ARMOR},  -- Glorious Belt
	[14969]={b=61205,s=12241,d=28024,c=AUCT_CLAS_ARMOR},  -- Glorious Headdress
	[14970]={b=77992,s=15598,d=26861,c=AUCT_CLAS_ARMOR},  -- Glorious Legplates
	[14971]={b=55380,s=11076,d=26864,c=AUCT_CLAS_ARMOR},  -- Glorious Shoulder Pads
	[14972]={b=52430,s=10486,d=26862,c=AUCT_CLAS_ARMOR},  -- Glorious Sabatons
	[14973]={b=139051,s=27810,d=26868,c=AUCT_CLAS_WEAPON},  -- Glorious Shield
	[14974]={b=30045,s=6009,d=26857,c=AUCT_CLAS_ARMOR},  -- Glorious Bindings
	[14975]={b=101099,s=20219,d=26890,c=AUCT_CLAS_ARMOR},  -- Exalted Harness
	[14976]={b=41748,s=8349,d=26888,c=AUCT_CLAS_ARMOR},  -- Exalted Gauntlets
	[14977]={b=39913,s=7982,d=26889,c=AUCT_CLAS_ARMOR},  -- Exalted Girdle
	[14978]={b=69566,s=13913,d=27832,c=AUCT_CLAS_ARMOR},  -- Exalted Sabatons
	[14979]={b=73324,s=14664,d=26893,c=AUCT_CLAS_ARMOR},  -- Exalted Helmet
	[14980]={b=96008,s=19201,d=26891,c=AUCT_CLAS_ARMOR},  -- Exalted Legplates
	[14981]={b=68824,s=13764,d=26894,c=AUCT_CLAS_ARMOR},  -- Exalted Epaulets
	[14983]={b=39927,s=7985,d=26887,c=AUCT_CLAS_ARMOR},  -- Exalted Armsplints
	[15002]={b=0,s=0,d=25593},  -- Nimboya's Pike
	[15003]={b=100,s=20,d=28007,c=AUCT_CLAS_ARMOR},  -- Primal Belt
	[15004]={b=212,s=42,d=7537,c=AUCT_CLAS_ARMOR},  -- Primal Boots
	[15005]={b=141,s=28,d=17017,c=AUCT_CLAS_ARMOR},  -- Primal Bands
	[15006]={b=364,s=72,d=18508,c=AUCT_CLAS_WEAPON},  -- Primal Buckler
	[15007]={b=122,s=24,d=28011,c=AUCT_CLAS_ARMOR},  -- Primal Cape
	[15008]={b=186,s=37,d=28009,c=AUCT_CLAS_ARMOR},  -- Primal Mitts
	[15009]={b=812,s=162,d=28008,c=AUCT_CLAS_ARMOR},  -- Primal Leggings
	[15010]={b=815,s=163,d=9536,c=AUCT_CLAS_ARMOR},  -- Primal Wraps
	[15011]={b=919,s=183,d=27668,c=AUCT_CLAS_ARMOR},  -- Lupine Cord
	[15012]={b=1480,s=296,d=14276,c=AUCT_CLAS_ARMOR},  -- Lupine Slippers
	[15013]={b=430,s=86,d=27989,c=AUCT_CLAS_ARMOR},  -- Lupine Cuffs
	[15014]={b=2927,s=585,d=28579,c=AUCT_CLAS_WEAPON},  -- Lupine Buckler
	[15015]={b=433,s=86,d=23050,c=AUCT_CLAS_ARMOR},  -- Lupine Cloak
	[15016]={b=1001,s=200,d=27990,c=AUCT_CLAS_ARMOR},  -- Lupine Handwraps
	[15017]={b=3059,s=611,d=27991,c=AUCT_CLAS_ARMOR},  -- Lupine Leggings
	[15018]={b=3531,s=706,d=3390,c=AUCT_CLAS_ARMOR},  -- Lupine Vest
	[15019]={b=1833,s=366,d=27667,c=AUCT_CLAS_ARMOR},  -- Lupine Mantle
	[15042]={b=0,s=0,d=25661},  -- Empty Termite Jar
	[15043]={b=0,s=0,d=25662,q=100,x=100},  -- Plagueland Termites
	[15044]={b=0,s=0,d=25807},  -- Barrel of Plagueland Termites
	[15045]={b=99692,s=19938,d=25671,c=AUCT_CLAS_ARMOR},  -- Green Dragonscale Breastplate
	[15046]={b=112410,s=22482,d=25673,c=AUCT_CLAS_ARMOR},  -- Green Dragonscale Leggings
	[15047]={b=149181,s=29836,d=25675,c=AUCT_CLAS_ARMOR},  -- Red Dragonscale Breastplate
	[15048]={b=122046,s=24409,d=25676,c=AUCT_CLAS_ARMOR},  -- Blue Dragonscale Breastplate
	[15049]={b=102716,s=20543,d=25677,c=AUCT_CLAS_ARMOR},  -- Blue Dragonscale Shoulders
	[15050]={b=130357,s=26071,d=27943,c=AUCT_CLAS_ARMOR},  -- Black Dragonscale Breastplate
	[15051]={b=108683,s=21736,d=27945,c=AUCT_CLAS_ARMOR},  -- Black Dragonscale Shoulders
	[15052]={b=159667,s=31933,d=27944,c=AUCT_CLAS_ARMOR},  -- Black Dragonscale Leggings
	[15053]={b=86377,s=17275,d=25682,c=AUCT_CLAS_ARMOR},  -- Volcanic Breastplate
	[15054]={b=72799,s=14559,d=25683,c=AUCT_CLAS_ARMOR},  -- Volcanic Leggings
	[15055]={b=80097,s=16019,d=25685,c=AUCT_CLAS_ARMOR},  -- Volcanic Shoulders
	[15056]={b=104834,s=20966,d=8682,c=AUCT_CLAS_ARMOR},  -- Stormshroud Armor
	[15057]={b=93642,s=18728,d=25686,c=AUCT_CLAS_ARMOR},  -- Stormshroud Pants
	[15058]={b=73464,s=14692,d=25687,c=AUCT_CLAS_ARMOR},  -- Stormshroud Shoulders
	[15059]={b=123882,s=24776,d=25688,c=AUCT_CLAS_ARMOR},  -- Living Breastplate
	[15060]={b=106387,s=21277,d=25694,c=AUCT_CLAS_ARMOR},  -- Living Leggings
	[15061]={b=69017,s=13803,d=25695,c=AUCT_CLAS_ARMOR},  -- Living Shoulders
	[15062]={b=128545,s=25709,d=26071,c=AUCT_CLAS_ARMOR},  -- Devilsaur Leggings
	[15063]={b=58505,s=11701,d=26072,c=AUCT_CLAS_ARMOR},  -- Devilsaur Gauntlets
	[15064]={b=98585,s=19717,d=12368,c=AUCT_CLAS_ARMOR},  -- Warbear Harness
	[15065]={b=111165,s=22233,d=14547,c=AUCT_CLAS_ARMOR},  -- Warbear Woolies
	[15066]={b=118252,s=23650,d=25699,c=AUCT_CLAS_ARMOR},  -- Ironfeather Breastplate
	[15067]={b=63790,s=12758,d=25700,c=AUCT_CLAS_ARMOR},  -- Ironfeather Shoulders
	[15068]={b=109178,s=21835,d=19012,c=AUCT_CLAS_ARMOR},  -- Frostsaber Tunic
	[15069]={b=85064,s=17012,d=25701,c=AUCT_CLAS_ARMOR},  -- Frostsaber Leggings
	[15070]={b=47521,s=9504,d=25702,c=AUCT_CLAS_ARMOR},  -- Frostsaber Gloves
	[15071]={b=57218,s=11443,d=25703,c=AUCT_CLAS_ARMOR},  -- Frostsaber Boots
	[15072]={b=81169,s=16233,d=25705,c=AUCT_CLAS_ARMOR},  -- Chimeric Leggings
	[15073]={b=57650,s=11530,d=25709,c=AUCT_CLAS_ARMOR},  -- Chimeric Boots
	[15074]={b=34335,s=6867,d=25706,c=AUCT_CLAS_ARMOR},  -- Chimeric Gloves
	[15075]={b=92245,s=18449,d=25704,c=AUCT_CLAS_ARMOR},  -- Chimeric Vest
	[15076]={b=83020,s=16604,d=25710,c=AUCT_CLAS_ARMOR},  -- Heavy Scorpid Vest
	[15077]={b=38077,s=7615,d=25720,c=AUCT_CLAS_ARMOR},  -- Heavy Scorpid Bracers
	[15078]={b=48245,s=9649,d=25718,c=AUCT_CLAS_ARMOR},  -- Heavy Scorpid Gauntlet
	[15079]={b=108803,s=21760,d=25714,c=AUCT_CLAS_ARMOR},  -- Heavy Scorpid Leggings
	[15080]={b=91152,s=18230,d=28976,c=AUCT_CLAS_ARMOR},  -- Heavy Scorpid Helm
	[15081]={b=101305,s=20261,d=25713,c=AUCT_CLAS_ARMOR},  -- Heavy Scorpid Shoulders
	[15082]={b=51878,s=10375,d=25719,c=AUCT_CLAS_ARMOR},  -- Heavy Scorpid Belt
	[15083]={b=34363,s=6872,d=25724,c=AUCT_CLAS_ARMOR},  -- Wicked Leather Gauntlets
	[15084]={b=36555,s=7311,d=25726,c=AUCT_CLAS_ARMOR},  -- Wicked Leather Bracers
	[15085]={b=113662,s=22732,d=25721,c=AUCT_CLAS_ARMOR},  -- Wicked Leather Armor
	[15086]={b=65771,s=13154,d=25729,c=AUCT_CLAS_ARMOR},  -- Wicked Leather Headband
	[15087]={b=89463,s=17892,d=25722,c=AUCT_CLAS_ARMOR},  -- Wicked Leather Pants
	[15088]={b=49508,s=9901,d=25728,c=AUCT_CLAS_ARMOR},  -- Wicked Leather Belt
	[15090]={b=110012,s=22002,d=25731,c=AUCT_CLAS_ARMOR},  -- Runic Leather Armor
	[15091]={b=35978,s=7195,d=25735,c=AUCT_CLAS_ARMOR},  -- Runic Leather Gauntlets
	[15092]={b=38283,s=7656,d=25736,c=AUCT_CLAS_ARMOR},  -- Runic Leather Bracers
	[15093]={b=41843,s=8368,d=25737,c=AUCT_CLAS_ARMOR},  -- Runic Leather Belt
	[15094]={b=70777,s=14155,d=25739,c=AUCT_CLAS_ARMOR},  -- Runic Leather Headband
	[15095]={b=104426,s=20885,d=25732,c=AUCT_CLAS_ARMOR},  -- Runic Leather Pants
	[15096]={b=86664,s=17332,d=25734,c=AUCT_CLAS_ARMOR},  -- Runic Leather Shoulders
	[15102]={b=0,s=0,d=2885},  -- Un'Goro Tested Sample
	[15103]={b=0,s=0,d=2885},  -- Corrupt Tested Sample
	[15104]={b=15940,s=3188,d=28432,c=AUCT_CLAS_ARMOR},  -- Wingborne Boots
	[15105]={b=71989,s=14397,d=28231,c=AUCT_CLAS_WEAPON},  -- Staff of Noh'Orahil
	[15106]={b=72237,s=14447,d=28236,c=AUCT_CLAS_WEAPON},  -- Staff of Dar'Orahil
	[15107]={b=20000,s=5000,d=25072,c=AUCT_CLAS_WEAPON},  -- Orb of Noh'Orahil
	[15108]={b=20000,s=5000,d=25072,c=AUCT_CLAS_WEAPON},  -- Orb of Dar'Orahil
	[15109]={b=16723,s=3344,d=28225,c=AUCT_CLAS_WEAPON},  -- Staff of Soran'ruk
	[15110]={b=1758,s=351,d=27880,c=AUCT_CLAS_ARMOR},  -- Rigid Belt
	[15111]={b=3046,s=609,d=1981,c=AUCT_CLAS_ARMOR},  -- Rigid Moccasins
	[15112]={b=1771,s=354,d=27879,c=AUCT_CLAS_ARMOR},  -- Rigid Bracelets
	[15113]={b=6805,s=1361,d=2211,c=AUCT_CLAS_WEAPON},  -- Rigid Buckler
	[15114]={b=1862,s=372,d=27514,c=AUCT_CLAS_ARMOR},  -- Rigid Cape
	[15115]={b=2369,s=473,d=27878,c=AUCT_CLAS_ARMOR},  -- Rigid Gloves
	[15116]={b=5816,s=1163,d=11274,c=AUCT_CLAS_ARMOR},  -- Rigid Shoulders
	[15117]={b=6096,s=1219,d=1978,c=AUCT_CLAS_ARMOR},  -- Rigid Leggings
	[15118]={b=7812,s=1562,d=27877,c=AUCT_CLAS_ARMOR},  -- Rigid Tunic
	[15119]={b=68415,s=13683,d=26177,c=AUCT_CLAS_ARMOR},  -- Highborne Pants
	[15120]={b=3934,s=786,d=27887,c=AUCT_CLAS_ARMOR},  -- Robust Girdle
	[15121]={b=7167,s=1433,d=1966,c=AUCT_CLAS_ARMOR},  -- Robust Boots
	[15122]={b=3507,s=701,d=27888,c=AUCT_CLAS_ARMOR},  -- Robust Bracers
	[15123]={b=12319,s=2463,d=18449,c=AUCT_CLAS_WEAPON},  -- Robust Buckler
	[15124]={b=4237,s=847,d=27693,c=AUCT_CLAS_ARMOR},  -- Robust Cloak
	[15125]={b=4954,s=990,d=27881,c=AUCT_CLAS_ARMOR},  -- Robust Gloves
	[15126]={b=9947,s=1989,d=27884,c=AUCT_CLAS_ARMOR},  -- Robust Leggings
	[15127]={b=8237,s=1647,d=6775,c=AUCT_CLAS_ARMOR},  -- Robust Shoulders
	[15128]={b=12126,s=2425,d=27882,c=AUCT_CLAS_ARMOR},  -- Robust Tunic
	[15129]={b=9129,s=1825,d=27886,c=AUCT_CLAS_ARMOR},  -- Robust Helm
	[15130]={b=16262,s=3252,d=9548,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Vest
	[15131]={b=10117,s=2023,d=27710,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Boots
	[15132]={b=5085,s=1017,d=27706,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Armguards
	[15133]={b=19134,s=3826,d=27720,c=AUCT_CLAS_WEAPON},  -- Cutthroat's Buckler
	[15134]={b=16475,s=3295,d=27711,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Hat
	[15135]={b=6788,s=1357,d=28563,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Cape
	[15136]={b=6244,s=1248,d=27708,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Belt
	[15137]={b=7583,s=1516,d=27715,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Mitts
	[15138]={b=75993,s=15198,d=25921,c=AUCT_CLAS_ARMOR},  -- Onyxia Scale Cloak
	[15139]={b=15278,s=3055,d=27712,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Loincloth
	[15140]={b=12649,s=2529,d=27713,c=AUCT_CLAS_ARMOR},  -- Cutthroat's Mantle
	[15142]={b=13016,s=2603,d=27685,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Boots
	[15143]={b=7197,s=1439,d=3652,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Bindings
	[15144]={b=21160,s=4232,d=27689,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Rags
	[15145]={b=24717,s=4943,d=27690,c=AUCT_CLAS_WEAPON},  -- Ghostwalker Buckler
	[15146]={b=18652,s=3730,d=27687,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Crown
	[15147]={b=8769,s=1753,d=27686,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Cloak
	[15148]={b=8069,s=1613,d=27684,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Belt
	[15149]={b=9800,s=1960,d=3846,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Gloves
	[15150]={b=14756,s=2951,d=27688,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Pads
	[15151]={b=19747,s=3949,d=3442,c=AUCT_CLAS_ARMOR},  -- Ghostwalker Legguards
	[15152]={b=22247,s=4449,d=27725,c=AUCT_CLAS_ARMOR},  -- Nocturnal Shoes
	[15153]={b=13131,s=2626,d=23048,c=AUCT_CLAS_ARMOR},  -- Nocturnal Cloak
	[15154]={b=11860,s=2372,d=27724,c=AUCT_CLAS_ARMOR},  -- Nocturnal Sash
	[15155]={b=12856,s=2571,d=27722,c=AUCT_CLAS_ARMOR},  -- Nocturnal Gloves
	[15156]={b=26332,s=5266,d=27734,c=AUCT_CLAS_ARMOR},  -- Nocturnal Cap
	[15157]={b=31000,s=6200,d=27723,c=AUCT_CLAS_ARMOR},  -- Nocturnal Leggings
	[15158]={b=21602,s=4320,d=27732,c=AUCT_CLAS_ARMOR},  -- Nocturnal Shoulder Pads
	[15159]={b=33715,s=6743,d=27728,c=AUCT_CLAS_ARMOR},  -- Nocturnal Tunic
	[15160]={b=12151,s=2430,d=27727,c=AUCT_CLAS_ARMOR},  -- Nocturnal Wristbands
	[15161]={b=16596,s=3319,d=18980,c=AUCT_CLAS_ARMOR},  -- Imposing Belt
	[15162]={b=29146,s=5829,d=27916,c=AUCT_CLAS_ARMOR},  -- Imposing Boots
	[15163]={b=16723,s=3344,d=27922,c=AUCT_CLAS_ARMOR},  -- Imposing Bracers
	[15164]={b=45679,s=9135,d=27914,c=AUCT_CLAS_ARMOR},  -- Imposing Vest
	[15165]={b=18723,s=3744,d=22253,c=AUCT_CLAS_ARMOR},  -- Imposing Cape
	[15166]={b=19728,s=3945,d=27921,c=AUCT_CLAS_ARMOR},  -- Imposing Gloves
	[15167]={b=37421,s=7484,d=28979,c=AUCT_CLAS_ARMOR},  -- Imposing Bandana
	[15168]={b=39757,s=7951,d=17153,c=AUCT_CLAS_ARMOR},  -- Imposing Pants
	[15169]={b=27713,s=5542,d=27920,c=AUCT_CLAS_ARMOR},  -- Imposing Shoulders
	[15170]={b=65519,s=13103,d=27586,c=AUCT_CLAS_ARMOR},  -- Potent Armor
	[15171]={b=43487,s=8697,d=11832,c=AUCT_CLAS_ARMOR},  -- Potent Boots
	[15172]={b=23534,s=4706,d=27589,c=AUCT_CLAS_ARMOR},  -- Potent Bands
	[15173]={b=26939,s=5387,d=27593,c=AUCT_CLAS_ARMOR},  -- Potent Cape
	[15174]={b=30087,s=6017,d=27591,c=AUCT_CLAS_ARMOR},  -- Potent Gloves
	[15175]={b=48462,s=9692,d=27907,c=AUCT_CLAS_ARMOR},  -- Potent Helmet
	[15176]={b=60606,s=12121,d=14697,c=AUCT_CLAS_ARMOR},  -- Potent Pants
	[15177]={b=42628,s=8525,d=27592,c=AUCT_CLAS_ARMOR},  -- Potent Shoulders
	[15178]={b=24679,s=4935,d=27590,c=AUCT_CLAS_ARMOR},  -- Potent Belt
	[15179]={b=92965,s=18593,d=27663,c=AUCT_CLAS_ARMOR},  -- Praetorian Padded Armor
	[15180]={b=33433,s=6686,d=27560,c=AUCT_CLAS_ARMOR},  -- Praetorian Girdle
	[15181]={b=56561,s=11312,d=27562,c=AUCT_CLAS_ARMOR},  -- Praetorian Boots
	[15182]={b=29982,s=5996,d=28584,c=AUCT_CLAS_ARMOR},  -- Praetorian Wristbands
	[15183]={b=33756,s=6751,d=24159,c=AUCT_CLAS_ARMOR},  -- Praetorian Cloak
	[15184]={b=35986,s=7197,d=27661,c=AUCT_CLAS_ARMOR},  -- Praetorian Gloves
	[15185]={b=64529,s=12905,d=27666,c=AUCT_CLAS_ARMOR},  -- Praetorian Coif
	[15186]={b=76867,s=15373,d=27662,c=AUCT_CLAS_ARMOR},  -- Praetorian Leggings
	[15187]={b=54593,s=10918,d=27664,c=AUCT_CLAS_ARMOR},  -- Praetorian Pauldrons
	[15188]={b=43512,s=8702,d=27632,c=AUCT_CLAS_ARMOR},  -- Grand Armguards
	[15189]={b=78614,s=15722,d=27634,c=AUCT_CLAS_ARMOR},  -- Grand Boots
	[15190]={b=48070,s=9614,d=23051,c=AUCT_CLAS_ARMOR},  -- Grand Cloak
	[15191]={b=45174,s=9034,d=18980,c=AUCT_CLAS_ARMOR},  -- Grand Belt
	[15192]={b=52979,s=10595,d=27635,c=AUCT_CLAS_ARMOR},  -- Grand Gauntlets
	[15193]={b=87933,s=17586,d=28022,c=AUCT_CLAS_ARMOR},  -- Grand Crown
	[15194]={b=112063,s=22412,d=28019,c=AUCT_CLAS_ARMOR},  -- Grand Legguards
	[15195]={b=118089,s=23617,d=28018,c=AUCT_CLAS_ARMOR},  -- Grand Breastplate
	[15196]={b=10000,s=2500,d=31254,c=AUCT_CLAS_ARMOR},  -- Private's Tabard
	[15197]={b=10000,s=2500,d=31255,c=AUCT_CLAS_ARMOR},  -- Scout's Tabard
	[15198]={b=40000,s=10000,d=31253,c=AUCT_CLAS_ARMOR},  -- Knight's Colors
	[15199]={b=40000,s=10000,d=31252,c=AUCT_CLAS_ARMOR},  -- Stone Guard's Herald
	[15200]={b=20000,s=5000,d=30797,c=AUCT_CLAS_ARMOR},  -- Senior Sergeant's Insignia
	[15202]={b=2579,s=515,d=7834,c=AUCT_CLAS_ARMOR},  -- Wildkeeper Leggings
	[15203]={b=3107,s=621,d=28189,c=AUCT_CLAS_ARMOR},  -- Guststorm Legguards
	[15204]={b=3898,s=779,d=28218,c=AUCT_CLAS_WEAPON},  -- Moonstone Wand
	[15205]={b=5317,s=1063,d=28229,c=AUCT_CLAS_WEAPON},  -- Owlsight Rifle
	[15206]={b=3430,s=857,d=28197,c=AUCT_CLAS_WEAPON},  -- Jadefinger Baton
	[15207]={b=4342,s=868,d=26322,c=AUCT_CLAS_WEAPON},  -- Steelcap Shield
	[15208]={b=0,s=0,d=20614},  -- Cenarion Moondust
	[15209]={b=0,s=0,d=1168},  -- Relic Bundle
	[15210]={b=4128,s=825,d=28544,c=AUCT_CLAS_WEAPON},  -- Raider Shortsword
	[15211]={b=9584,s=1916,d=28567,c=AUCT_CLAS_WEAPON},  -- Militant Shortsword
	[15212]={b=17252,s=3450,d=28527,c=AUCT_CLAS_WEAPON},  -- Fighter Broadsword
	[15213]={b=40829,s=8165,d=28570,c=AUCT_CLAS_WEAPON},  -- Mercenary Blade
	[15214]={b=56781,s=11356,d=28561,c=AUCT_CLAS_WEAPON},  -- Nobles Brand
	[15215]={b=83720,s=16744,d=28528,c=AUCT_CLAS_WEAPON},  -- Furious Falchion
	[15216]={b=129661,s=25932,d=28530,c=AUCT_CLAS_WEAPON},  -- Rune Sword
	[15217]={b=154980,s=30996,d=28458,c=AUCT_CLAS_WEAPON},  -- Widow Blade
	[15218]={b=185239,s=37047,d=28346,c=AUCT_CLAS_WEAPON},  -- Crystal Sword
	[15219]={b=206882,s=41376,d=13078,c=AUCT_CLAS_WEAPON},  -- Dimensional Blade
	[15220]={b=217465,s=43493,d=28316,c=AUCT_CLAS_WEAPON},  -- Battlefell Sabre
	[15221]={b=259732,s=51946,d=28552,c=AUCT_CLAS_WEAPON},  -- Holy War Sword
	[15222]={b=6096,s=1219,d=28314,c=AUCT_CLAS_WEAPON},  -- Barbed Club
	[15223]={b=11884,s=2376,d=28571,c=AUCT_CLAS_WEAPON},  -- Jagged Star
	[15224]={b=13479,s=2695,d=28318,c=AUCT_CLAS_WEAPON},  -- Battlesmasher
	[15225]={b=29793,s=5958,d=28521,c=AUCT_CLAS_WEAPON},  -- Sequoia Hammer
	[15226]={b=43778,s=8755,d=28531,c=AUCT_CLAS_WEAPON},  -- Giant Club
	[15227]={b=109625,s=21925,d=28508,c=AUCT_CLAS_WEAPON},  -- Diamond-Tip Bludgeon
	[15228]={b=141543,s=28308,d=28512,c=AUCT_CLAS_WEAPON},  -- Smashing Star
	[15229]={b=159622,s=31924,d=19735,c=AUCT_CLAS_WEAPON},  -- Blesswind Hammer
	[15230]={b=13778,s=2755,d=28539,c=AUCT_CLAS_WEAPON},  -- Ridge Cleaver
	[15231]={b=25166,s=5033,d=28469,c=AUCT_CLAS_WEAPON},  -- Splitting Hatchet
	[15232]={b=30561,s=6112,d=28542,c=AUCT_CLAS_WEAPON},  -- Hacking Cleaver
	[15233]={b=52380,s=10476,d=28525,c=AUCT_CLAS_WEAPON},  -- Savage Axe
	[15234]={b=56770,s=11354,d=5640,c=AUCT_CLAS_WEAPON},  -- Greater Scythe
	[15235]={b=105454,s=21090,d=28341,c=AUCT_CLAS_WEAPON},  -- Crescent Edge
	[15236]={b=137428,s=27485,d=28566,c=AUCT_CLAS_WEAPON},  -- Moon Cleaver
	[15237]={b=152630,s=30526,d=28338,c=AUCT_CLAS_WEAPON},  -- Corpse Harvester
	[15238]={b=182480,s=36496,d=28459,c=AUCT_CLAS_WEAPON},  -- Warlord's Axe
	[15239]={b=212049,s=42409,d=28523,c=AUCT_CLAS_WEAPON},  -- Felstone Reaver
	[15240]={b=246405,s=49281,d=28504,c=AUCT_CLAS_WEAPON},  -- Demon's Claw
	[15241]={b=15060,s=3012,d=20414,c=AUCT_CLAS_WEAPON},  -- Battle Knife
	[15242]={b=22133,s=4426,d=28568,c=AUCT_CLAS_WEAPON},  -- Honed Stiletto
	[15243]={b=39357,s=7871,d=28348,c=AUCT_CLAS_WEAPON},  -- Deadly Kris
	[15244]={b=63848,s=12769,d=3175,c=AUCT_CLAS_WEAPON},  -- Razor Blade
	[15245]={b=116423,s=23284,d=6448,c=AUCT_CLAS_WEAPON},  -- Vorpal Dagger
	[15246]={b=228524,s=45704,d=20299,c=AUCT_CLAS_WEAPON},  -- Demon Blade
	[15247]={b=252880,s=50576,d=28327,c=AUCT_CLAS_WEAPON},  -- Bloodstrike Dagger
	[15248]={b=8959,s=1791,d=28535,c=AUCT_CLAS_WEAPON},  -- Gleaming Claymore
	[15249]={b=19388,s=3877,d=20080,c=AUCT_CLAS_WEAPON},  -- Polished Zweihander
	[15250]={b=34474,s=6894,d=28536,c=AUCT_CLAS_WEAPON},  -- Glimmering Flamberge
	[15251]={b=88428,s=17685,d=28546,c=AUCT_CLAS_WEAPON},  -- Headstriker Sword
	[15252]={b=139530,s=27906,d=28465,c=AUCT_CLAS_WEAPON},  -- Tusker Sword
	[15253]={b=157737,s=31547,d=28321,c=AUCT_CLAS_WEAPON},  -- Beheading Blade
	[15254]={b=177922,s=35584,d=28347,c=AUCT_CLAS_WEAPON},  -- Dark Espadon
	[15255]={b=212728,s=42545,d=28529,c=AUCT_CLAS_WEAPON},  -- Gallant Flamberge
	[15256]={b=237656,s=47531,d=28576,c=AUCT_CLAS_WEAPON},  -- Massacre Sword
	[15257]={b=276172,s=55234,d=26589,c=AUCT_CLAS_WEAPON},  -- Shin Blade
	[15258]={b=320928,s=64185,d=28517,c=AUCT_CLAS_WEAPON},  -- Divine Warblade
	[15259]={b=16533,s=3306,d=28548,c=AUCT_CLAS_WEAPON},  -- Hefty Battlehammer
	[15260]={b=57783,s=11556,d=28468,c=AUCT_CLAS_WEAPON},  -- Stone Hammer
	[15261]={b=67653,s=13530,d=28524,c=AUCT_CLAS_WEAPON},  -- Sequoia Branch
	[15262]={b=107763,s=21552,d=28540,c=AUCT_CLAS_WEAPON},  -- Greater Maul
	[15263]={b=144448,s=28889,d=28534,c=AUCT_CLAS_WEAPON},  -- Royal Mallet
	[15264]={b=207589,s=41517,d=28311,c=AUCT_CLAS_WEAPON},  -- Backbreaker
	[15265]={b=234116,s=46823,d=28499,c=AUCT_CLAS_WEAPON},  -- Painbringer
	[15266]={b=272026,s=54405,d=28526,c=AUCT_CLAS_WEAPON},  -- Fierce Mauler
	[15267]={b=301018,s=60203,d=28674,c=AUCT_CLAS_WEAPON},  -- Brutehammer
	[15268]={b=5121,s=1024,d=28460,c=AUCT_CLAS_WEAPON},  -- Twin-bladed Axe
	[15269]={b=15183,s=3036,d=28573,c=AUCT_CLAS_WEAPON},  -- Massive Battle Axe
	[15270]={b=113877,s=22775,d=28533,c=AUCT_CLAS_WEAPON},  -- Gigantic War Axe
	[15271]={b=218506,s=43701,d=28334,c=AUCT_CLAS_WEAPON},  -- Colossal Great Axe
	[15272]={b=258702,s=51740,d=28541,c=AUCT_CLAS_WEAPON},  -- Razor Axe
	[15273]={b=285543,s=57108,d=28349,c=AUCT_CLAS_WEAPON},  -- Death Striker
	[15274]={b=158334,s=31666,d=22144,c=AUCT_CLAS_WEAPON},  -- Diviner Long Staff
	[15275]={b=178574,s=35714,d=28467,c=AUCT_CLAS_WEAPON},  -- Thaumaturgist Staff
	[15276]={b=226315,s=45263,d=28580,c=AUCT_CLAS_WEAPON},  -- Magus Long Staff
	[15277]={b=800000,s=0,d=29448},  -- Gray Kodo
	[15278]={b=251429,s=50285,d=28502,c=AUCT_CLAS_WEAPON},  -- Solstice Staff
	[15279]={b=91338,s=18267,d=28569,c=AUCT_CLAS_WEAPON},  -- Ivory Wand
	[15280]={b=103018,s=20603,d=28457,c=AUCT_CLAS_WEAPON},  -- Wizard's Hand
	[15281]={b=130550,s=26110,d=28538,c=AUCT_CLAS_WEAPON},  -- Glowstar Rod
	[15282]={b=153142,s=30628,d=28518,c=AUCT_CLAS_WEAPON},  -- Dragon Finger
	[15283]={b=186825,s=37365,d=28577,c=AUCT_CLAS_WEAPON},  -- Lunar Wand
	[15284]={b=15199,s=3039,d=28572,c=AUCT_CLAS_WEAPON},  -- Long Battle Bow
	[15285]={b=20305,s=4061,d=28308,c=AUCT_CLAS_WEAPON},  -- Archer's Longbow
	[15286]={b=27843,s=5568,d=28575,c=AUCT_CLAS_WEAPON},  -- Long Redwood Bow
	[15287]={b=62583,s=12516,d=28344,c=AUCT_CLAS_WEAPON},  -- Crusader Bow
	[15288]={b=168715,s=33743,d=28322,c=AUCT_CLAS_WEAPON},  -- Blasthorn Bow
	[15289]={b=205809,s=41161,d=28309,c=AUCT_CLAS_WEAPON},  -- Archstrike Bow
	[15290]={b=800000,s=0,d=29447},  -- Brown Kodo
	[15291]={b=97958,s=19591,d=28543,c=AUCT_CLAS_WEAPON},  -- Harpy Needler
	[15292]={b=10000000,s=0,d=29449},  -- Green Kodo
	[15293]={b=10000000,s=0,d=29449},  -- Teal Kodo
	[15294]={b=100679,s=20135,d=28515,c=AUCT_CLAS_WEAPON},  -- Siege Bow
	[15295]={b=113560,s=22712,d=28547,c=AUCT_CLAS_WEAPON},  -- Quillfire Bow
	[15296]={b=173287,s=34657,d=28545,c=AUCT_CLAS_WEAPON},  -- Hawkeye Bow
	[15297]={b=227,s=45,d=28013,c=AUCT_CLAS_ARMOR},  -- Grizzly Bracers
	[15298]={b=1525,s=305,d=28017,c=AUCT_CLAS_WEAPON},  -- Grizzly Buckler
	[15299]={b=211,s=42,d=23054,c=AUCT_CLAS_ARMOR},  -- Grizzly Cape
	[15300]={b=432,s=86,d=12415,c=AUCT_CLAS_ARMOR},  -- Grizzly Gloves
	[15301]={b=541,s=108,d=28016,c=AUCT_CLAS_ARMOR},  -- Grizzly Slippers
	[15302]={b=237,s=47,d=28012,c=AUCT_CLAS_ARMOR},  -- Grizzly Belt
	[15303]={b=1495,s=299,d=28014,c=AUCT_CLAS_ARMOR},  -- Grizzly Pants
	[15304]={b=2071,s=414,d=12369,c=AUCT_CLAS_ARMOR},  -- Grizzly Jerkin
	[15305]={b=2062,s=412,d=28039,c=AUCT_CLAS_ARMOR},  -- Feral Shoes
	[15306]={b=1042,s=208,d=28045,c=AUCT_CLAS_ARMOR},  -- Feral Bindings
	[15307]={b=4077,s=815,d=20826,c=AUCT_CLAS_WEAPON},  -- Feral Buckler
	[15308]={b=1208,s=241,d=17114,c=AUCT_CLAS_ARMOR},  -- Feral Cord
	[15309]={b=1100,s=220,d=28042,c=AUCT_CLAS_ARMOR},  -- Feral Cloak
	[15310]={b=1398,s=279,d=28046,c=AUCT_CLAS_ARMOR},  -- Feral Gloves
	[15311]={b=4913,s=982,d=11382,c=AUCT_CLAS_ARMOR},  -- Feral Harness
	[15312]={b=3728,s=745,d=14522,c=AUCT_CLAS_ARMOR},  -- Feral Leggings
	[15313]={b=2572,s=514,d=9527,c=AUCT_CLAS_ARMOR},  -- Feral Shoulder Pads
	[15314]={b=0,s=0,d=1168},  -- Bundle of Relics
	[15322]={b=38726,s=7745,d=6591,c=AUCT_CLAS_WEAPON},  -- Smoothbore Gun
	[15323]={b=88956,s=17791,d=28557,c=AUCT_CLAS_WEAPON},  -- Percussion Shotgun
	[15324]={b=127828,s=25565,d=28331,c=AUCT_CLAS_WEAPON},  -- Burnside Rifle
	[15325]={b=158924,s=31784,d=8258,c=AUCT_CLAS_WEAPON},  -- Sharpshooter Harquebus
	[15326]={b=800,s=1,d=26358,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Gleaming Throwing Axe
	[15327]={b=800,s=1,d=26361,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Wicked Throwing Dagger
	[15329]={b=3114,s=622,d=27998,c=AUCT_CLAS_ARMOR},  -- Wrangler's Belt
	[15330]={b=5298,s=1059,d=27999,c=AUCT_CLAS_ARMOR},  -- Wrangler's Boots
	[15331]={b=2776,s=555,d=28001,c=AUCT_CLAS_ARMOR},  -- Wrangler's Wristbands
	[15332]={b=11319,s=2263,d=18493,c=AUCT_CLAS_WEAPON},  -- Wrangler's Buckler
	[15333]={b=2685,s=537,d=28006,c=AUCT_CLAS_ARMOR},  -- Wrangler's Cloak
	[15334]={b=4141,s=828,d=28005,c=AUCT_CLAS_ARMOR},  -- Wrangler's Gloves
	[15335]={b=2904,s=580,d=28093,c=AUCT_CLAS_WEAPON},  -- Briarsteel Shortsword
	[15336]={b=8345,s=1669,d=28003,c=AUCT_CLAS_ARMOR},  -- Wrangler's Leggings
	[15337]={b=10136,s=2027,d=27683,c=AUCT_CLAS_ARMOR},  -- Wrangler's Wraps
	[15338]={b=6937,s=1387,d=28002,c=AUCT_CLAS_ARMOR},  -- Wrangler's Mantle
	[15339]={b=12333,s=2466,d=27680,c=AUCT_CLAS_ARMOR},  -- Pathfinder Hat
	[15340]={b=5081,s=1016,d=27679,c=AUCT_CLAS_ARMOR},  -- Pathfinder Cloak
	[15341]={b=8486,s=1697,d=27678,c=AUCT_CLAS_ARMOR},  -- Pathfinder Footpads
	[15342]={b=14537,s=2907,d=28583,c=AUCT_CLAS_WEAPON},  -- Pathfinder Guard
	[15343]={b=5698,s=1139,d=27677,c=AUCT_CLAS_ARMOR},  -- Pathfinder Gloves
	[15344]={b=12582,s=2516,d=27681,c=AUCT_CLAS_ARMOR},  -- Pathfinder Pants
	[15345]={b=9471,s=1894,d=27682,c=AUCT_CLAS_ARMOR},  -- Pathfinder Shoulder Pads
	[15346]={b=13941,s=2788,d=27683,c=AUCT_CLAS_ARMOR},  -- Pathfinder Vest
	[15347]={b=4777,s=955,d=27674,c=AUCT_CLAS_ARMOR},  -- Pathfinder Belt
	[15348]={b=3962,s=792,d=27675,c=AUCT_CLAS_ARMOR},  -- Pathfinder Bracers
	[15349]={b=7749,s=1549,d=11953,c=AUCT_CLAS_ARMOR},  -- Headhunter's Belt
	[15350]={b=11924,s=2384,d=27702,c=AUCT_CLAS_ARMOR},  -- Headhunter's Slippers
	[15351]={b=5450,s=1090,d=27699,c=AUCT_CLAS_ARMOR},  -- Headhunter's Bands
	[15352]={b=20507,s=4101,d=28269,c=AUCT_CLAS_WEAPON},  -- Headhunter's Buckler
	[15353]={b=17337,s=3467,d=29134,c=AUCT_CLAS_ARMOR},  -- Headhunter's Headdress
	[15354]={b=8003,s=1600,d=27700,c=AUCT_CLAS_ARMOR},  -- Headhunter's Cloak
	[15355]={b=8100,s=1620,d=27701,c=AUCT_CLAS_ARMOR},  -- Headhunter's Mitts
	[15356]={b=19678,s=3935,d=18284,c=AUCT_CLAS_ARMOR},  -- Headhunter's Armor
	[15357]={b=13467,s=2693,d=27703,c=AUCT_CLAS_ARMOR},  -- Headhunter's Spaulders
	[15358]={b=18020,s=3604,d=27704,c=AUCT_CLAS_ARMOR},  -- Headhunter's Woolies
	[15359]={b=29776,s=5955,d=27956,c=AUCT_CLAS_ARMOR},  -- Trickster's Vest
	[15360]={b=11861,s=2372,d=27954,c=AUCT_CLAS_ARMOR},  -- Trickster's Bindings
	[15361]={b=11024,s=2204,d=27958,c=AUCT_CLAS_ARMOR},  -- Trickster's Sash
	[15362]={b=19357,s=3871,d=27957,c=AUCT_CLAS_ARMOR},  -- Trickster's Boots
	[15363]={b=24473,s=4894,d=27959,c=AUCT_CLAS_ARMOR},  -- Trickster's Headdress
	[15364]={b=12157,s=2431,d=27960,c=AUCT_CLAS_ARMOR},  -- Trickster's Cloak
	[15365]={b=12078,s=2415,d=27955,c=AUCT_CLAS_ARMOR},  -- Trickster's Handwraps
	[15366]={b=26251,s=5250,d=17155,c=AUCT_CLAS_ARMOR},  -- Trickster's Leggings
	[15367]={b=31233,s=6246,d=28026,c=AUCT_CLAS_WEAPON},  -- Trickster's Protector
	[15368]={b=18371,s=3674,d=12830,c=AUCT_CLAS_ARMOR},  -- Trickster's Pauldrons
	[15369]={b=15486,s=3097,d=17231,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Belt
	[15370]={b=27198,s=5439,d=27969,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Boots
	[15371]={b=17338,s=3467,d=27974,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Cloak
	[15372]={b=16917,s=3383,d=27970,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Gloves
	[15373]={b=34652,s=6930,d=27973,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Headgear
	[15374]={b=36816,s=7363,d=17153,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Leggings
	[15375]={b=25663,s=5132,d=19008,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Shoulder Pads
	[15376]={b=43266,s=8653,d=27971,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Padded Armor
	[15377]={b=15959,s=3191,d=27972,c=AUCT_CLAS_ARMOR},  -- Wolf Rider's Wristbands
	[15378]={b=21793,s=4358,d=14702,c=AUCT_CLAS_ARMOR},  -- Rageclaw Belt
	[15379]={b=38271,s=7654,d=15412,c=AUCT_CLAS_ARMOR},  -- Rageclaw Boots
	[15380]={b=21954,s=4390,d=15413,c=AUCT_CLAS_ARMOR},  -- Rageclaw Bracers
	[15381]={b=62967,s=12593,d=17094,c=AUCT_CLAS_ARMOR},  -- Rageclaw Chestguard
	[15382]={b=25215,s=5043,d=23018,c=AUCT_CLAS_ARMOR},  -- Rageclaw Cloak
	[15383]={b=26565,s=5313,d=15415,c=AUCT_CLAS_ARMOR},  -- Rageclaw Gloves
	[15384]={b=45778,s=9155,d=23544,c=AUCT_CLAS_ARMOR},  -- Rageclaw Helm
	[15385]={b=57248,s=11449,d=27555,c=AUCT_CLAS_ARMOR},  -- Rageclaw Leggings
	[15386]={b=36437,s=7287,d=27553,c=AUCT_CLAS_ARMOR},  -- Rageclaw Shoulder Pads
	[15387]={b=27919,s=5583,d=27655,c=AUCT_CLAS_ARMOR},  -- Jadefire Bracelets
	[15388]={b=31785,s=6357,d=27654,c=AUCT_CLAS_ARMOR},  -- Jadefire Belt
	[15389]={b=50734,s=10146,d=13343,c=AUCT_CLAS_ARMOR},  -- Jadefire Sabatons
	[15390]={b=80876,s=16175,d=27656,c=AUCT_CLAS_ARMOR},  -- Jadefire Chestguard
	[15391]={b=60890,s=12178,d=27660,c=AUCT_CLAS_ARMOR},  -- Jadefire Cap
	[15392]={b=31911,s=6382,d=27658,c=AUCT_CLAS_ARMOR},  -- Jadefire Cloak
	[15393]={b=32395,s=6479,d=27657,c=AUCT_CLAS_ARMOR},  -- Jadefire Gloves
	[15394]={b=73074,s=14614,d=27570,c=AUCT_CLAS_ARMOR},  -- Jadefire Pants
	[15395]={b=51898,s=10379,d=17190,c=AUCT_CLAS_ARMOR},  -- Jadefire Epaulets
	[15396]={b=2913,s=582,d=26602,c=AUCT_CLAS_WEAPON},  -- Curvewood Dagger
	[15397]={b=3656,s=731,d=10654,c=AUCT_CLAS_WEAPON},  -- Oakthrush Staff
	[15398]={b=542,s=108,d=28246,c=AUCT_CLAS_ARMOR},  -- Sandcomber Boots
	[15399]={b=755,s=151,d=28149,c=AUCT_CLAS_ARMOR},  -- Dryweed Belt
	[15400]={b=545,s=109,d=28130,c=AUCT_CLAS_ARMOR},  -- Clamshell Bracers
	[15401]={b=364,s=72,d=28183,c=AUCT_CLAS_ARMOR},  -- Welldrip Gloves
	[15402]={b=549,s=109,d=28223,c=AUCT_CLAS_ARMOR},  -- Noosegrip Gauntlets
	[15403]={b=1399,s=279,d=28243,c=AUCT_CLAS_ARMOR},  -- Ridgeback Bracers
	[15404]={b=1685,s=337,d=8295,c=AUCT_CLAS_ARMOR},  -- Breakwater Girdle
	[15405]={b=1225,s=245,d=9529,c=AUCT_CLAS_ARMOR},  -- Shucking Gloves
	[15406]={b=2012,s=402,d=28138,c=AUCT_CLAS_ARMOR},  -- Crustacean Boots
	[15407]={b=2000,s=500,d=6660,x=5,c=AUCT_CLAS_HIDE,u=AUCT_TYPE_LEATHER},  -- Cured Rugged Hide
	[15408]={b=2000,s=500,d=568,x=20,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Heavy Scorpid Scale
	[15409]={b=4000,s=1000,d=7127,x=20,u=AUCT_TYPE_LEATHER},  -- Refined Deeprock Salt
	[15410]={b=20000,s=5000,d=20914,x=20},  -- Scale of Onyxia
	[15411]={b=41135,s=10283,d=23716,c=AUCT_CLAS_ARMOR},  -- Mark of Fordring
	[15412]={b=2000,s=500,d=21363,x=20,c=AUCT_CLAS_LEATHER},  -- Green Dragonscale
	[15413]={b=112596,s=22519,d=26373,c=AUCT_CLAS_ARMOR},  -- Ornate Adamantium Breastplate
	[15414]={b=6000,s=1500,d=26374,x=20,c=AUCT_CLAS_LEATHER},  -- Red Dragonscale
	[15415]={b=2000,s=500,d=26375,x=20,c=AUCT_CLAS_LEATHER},  -- Blue Dragonscale
	[15416]={b=4000,s=1000,d=20914,x=20,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Black Dragonscale
	[15417]={b=2000,s=500,d=21366,x=10},  -- Devilsaur Leather
	[15418]={b=367988,s=73597,d=27412,c=AUCT_CLAS_WEAPON},  -- Shimmering Platinum Warhammer
	[15419]={b=2400,s=600,d=7170,x=10,c=AUCT_CLAS_LEATHER},  -- Warbear Leather
	[15420]={b=400,s=100,d=19572,x=50},  -- Ironfeather
	[15421]={b=89275,s=17855,d=26681,c=AUCT_CLAS_ARMOR},  -- Shroud of the Exile
	[15422]={b=2000,s=500,d=26378,x=10,c=AUCT_CLAS_LEATHER,u=AUCT_TYPE_LEATHER},  -- Frostsaber Leather
	[15423]={b=2000,s=500,d=7374,x=10,c=AUCT_CLAS_LEATHER},  -- Chimera Leather
	[15424]={b=7023,s=1404,d=3243,c=AUCT_CLAS_WEAPON},  -- Axe of Orgrimmar
	[15425]={b=41364,s=8272,d=28033,c=AUCT_CLAS_ARMOR},  -- Peerless Bracers
	[15426]={b=67098,s=13419,d=28031,c=AUCT_CLAS_ARMOR},  -- Peerless Boots
	[15427]={b=42683,s=8536,d=23048,c=AUCT_CLAS_ARMOR},  -- Peerless Cloak
	[15428]={b=40120,s=8024,d=28030,c=AUCT_CLAS_ARMOR},  -- Peerless Belt
	[15429]={b=45248,s=9049,d=28034,c=AUCT_CLAS_ARMOR},  -- Peerless Gloves
	[15430]={b=77176,s=15435,d=28035,c=AUCT_CLAS_ARMOR},  -- Peerless Headband
	[15431]={b=98368,s=19673,d=28029,c=AUCT_CLAS_ARMOR},  -- Peerless Leggings
	[15432]={b=70524,s=14104,d=28037,c=AUCT_CLAS_ARMOR},  -- Peerless Shoulders
	[15433]={b=109245,s=21849,d=28028,c=AUCT_CLAS_ARMOR},  -- Peerless Armor
	[15434]={b=54823,s=10964,d=27616,c=AUCT_CLAS_ARMOR},  -- Supreme Sash
	[15435]={b=90997,s=18199,d=27617,c=AUCT_CLAS_ARMOR},  -- Supreme Shoes
	[15436]={b=52596,s=10519,d=27608,c=AUCT_CLAS_ARMOR},  -- Supreme Bracers
	[15437]={b=66506,s=13301,d=26271,c=AUCT_CLAS_ARMOR},  -- Supreme Cape
	[15438]={b=61324,s=12264,d=29013,c=AUCT_CLAS_ARMOR},  -- Supreme Gloves
	[15439]={b=96936,s=19387,d=28850,c=AUCT_CLAS_ARMOR},  -- Supreme Crown
	[15440]={b=123537,s=24707,d=27615,c=AUCT_CLAS_ARMOR},  -- Supreme Leggings
	[15441]={b=92977,s=18595,d=27618,c=AUCT_CLAS_ARMOR},  -- Supreme Shoulders
	[15442]={b=137166,s=27433,d=27610,c=AUCT_CLAS_ARMOR},  -- Supreme Breastplate
	[15443]={b=5598,s=1119,d=28199,c=AUCT_CLAS_WEAPON},  -- Kris of Orgrimmar
	[15444]={b=7023,s=1404,d=28228,c=AUCT_CLAS_WEAPON},  -- Staff of Orgrimmar
	[15445]={b=5637,s=1127,d=28191,c=AUCT_CLAS_WEAPON},  -- Hammer of Orgrimmar
	[15447]={b=0,s=0,d=26382},  -- Living Rot
	[15448]={b=0,s=0,d=25469},  -- Coagulated Rot
	[15449]={b=2127,s=425,d=16850,c=AUCT_CLAS_ARMOR},  -- Ghastly Trousers
	[15450]={b=2669,s=533,d=28147,c=AUCT_CLAS_ARMOR},  -- Dredgemire Leggings
	[15451]={b=3216,s=643,d=2922,c=AUCT_CLAS_ARMOR},  -- Gargoyle Leggings
	[15452]={b=1075,s=215,d=28168,c=AUCT_CLAS_ARMOR},  -- Featherbead Bracers
	[15453]={b=1349,s=269,d=28247,c=AUCT_CLAS_ARMOR},  -- Savannah Bracers
	[15454]={b=0,s=0,d=26383},  -- Mortar and Pestle
	[15455]={b=17705,s=3541,d=28323,c=AUCT_CLAS_ARMOR},  -- Dustfall Robes
	[15456]={b=22211,s=4442,d=17155,c=AUCT_CLAS_ARMOR},  -- Lightstep Leggings
	[15457]={b=5671,s=1134,d=26012,c=AUCT_CLAS_ARMOR},  -- Desert Shoulders
	[15458]={b=7116,s=1423,d=28192,c=AUCT_CLAS_ARMOR},  -- Tundra Boots
	[15459]={b=5712,s=1142,d=28275,c=AUCT_CLAS_ARMOR},  -- Grimtoll Wristguards
	[15461]={b=4207,s=841,d=26086,c=AUCT_CLAS_ARMOR},  -- Lightheel Boots
	[15462]={b=3269,s=653,d=28286,c=AUCT_CLAS_ARMOR},  -- Loamflake Bracers
	[15463]={b=3937,s=787,d=28288,c=AUCT_CLAS_ARMOR},  -- Palestrider Gloves
	[15464]={b=22523,s=4504,d=28096,c=AUCT_CLAS_WEAPON},  -- Brute Hammer
	[15465]={b=13565,s=2713,d=28216,c=AUCT_CLAS_WEAPON},  -- Stingshot Wand
	[15466]={b=11619,s=2323,d=28269,c=AUCT_CLAS_WEAPON},  -- Clink Shield
	[15467]={b=34520,s=8630,d=23728,c=AUCT_CLAS_ARMOR},  -- Inventor's League Ring
	[15468]={b=6035,s=1207,d=28303,c=AUCT_CLAS_ARMOR},  -- Windsong Drape
	[15469]={b=5048,s=1009,d=28302,c=AUCT_CLAS_ARMOR},  -- Windsong Cinch
	[15470]={b=12162,s=2432,d=28290,c=AUCT_CLAS_ARMOR},  -- Plainsguard Leggings
	[15471]={b=10172,s=2034,d=28266,c=AUCT_CLAS_ARMOR},  -- Brawnhide Armor
	[15472]={b=167,s=33,d=26937,c=AUCT_CLAS_ARMOR},  -- Charger's Belt
	[15473]={b=328,s=65,d=26939,c=AUCT_CLAS_ARMOR},  -- Charger's Boots
	[15474]={b=119,s=23,d=26938,c=AUCT_CLAS_ARMOR},  -- Charger's Bindings
	[15475]={b=120,s=24,d=26980,c=AUCT_CLAS_ARMOR},  -- Charger's Cloak
	[15476]={b=220,s=44,d=28998,c=AUCT_CLAS_ARMOR},  -- Charger's Handwraps
	[15477]={b=960,s=192,d=26941,c=AUCT_CLAS_ARMOR},  -- Charger's Pants
	[15478]={b=260,s=52,d=3931,c=AUCT_CLAS_WEAPON},  -- Charger's Shield
	[15479]={b=897,s=179,d=26936,c=AUCT_CLAS_ARMOR},  -- Charger's Armor
	[15480]={b=422,s=84,d=26953,c=AUCT_CLAS_ARMOR},  -- War Torn Girdle
	[15481]={b=639,s=127,d=26956,c=AUCT_CLAS_ARMOR},  -- War Torn Greaves
	[15482]={b=271,s=54,d=26952,c=AUCT_CLAS_ARMOR},  -- War Torn Bands
	[15483]={b=209,s=41,d=26958,c=AUCT_CLAS_ARMOR},  -- War Torn Cape
	[15484]={b=342,s=68,d=26954,c=AUCT_CLAS_ARMOR},  -- War Torn Handgrips
	[15485]={b=1722,s=344,d=26955,c=AUCT_CLAS_ARMOR},  -- War Torn Pants
	[15486]={b=1229,s=245,d=26959,c=AUCT_CLAS_WEAPON},  -- War Torn Shield
	[15487]={b=2395,s=479,d=26957,c=AUCT_CLAS_ARMOR},  -- War Torn Tunic
	[15488]={b=4836,s=967,d=27004,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Surcoat
	[15489]={b=1817,s=363,d=27001,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Sabatons
	[15490]={b=526,s=105,d=27006,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Cloak
	[15491]={b=1057,s=211,d=27000,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Gloves
	[15492]={b=1061,s=212,d=27002,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Sash
	[15493]={b=3238,s=647,d=26998,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Loincloth
	[15494]={b=3467,s=693,d=23750,c=AUCT_CLAS_WEAPON},  -- Bloodspattered Shield
	[15495]={b=1100,s=220,d=27005,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Wristbands
	[15496]={b=2309,s=461,d=27003,c=AUCT_CLAS_ARMOR},  -- Bloodspattered Shoulder Pads
	[15497]={b=1938,s=387,d=27127,c=AUCT_CLAS_ARMOR},  -- Outrunner's Cord
	[15498]={b=3370,s=674,d=27541,c=AUCT_CLAS_ARMOR},  -- Outrunner's Slippers
	[15499]={b=1535,s=307,d=26993,c=AUCT_CLAS_ARMOR},  -- Outrunner's Cuffs
	[15500]={b=6889,s=1377,d=26990,c=AUCT_CLAS_ARMOR},  -- Outrunner's Chestguard
	[15501]={b=1346,s=269,d=26991,c=AUCT_CLAS_ARMOR},  -- Outrunner's Cloak
	[15502]={b=2055,s=411,d=26994,c=AUCT_CLAS_ARMOR},  -- Outrunner's Gloves
	[15503]={b=5457,s=1091,d=26995,c=AUCT_CLAS_ARMOR},  -- Outrunner's Legguards
	[15504]={b=5843,s=1168,d=26855,c=AUCT_CLAS_WEAPON},  -- Outrunner's Shield
	[15505]={b=2808,s=561,d=26997,c=AUCT_CLAS_ARMOR},  -- Outrunner's Pauldrons
	[15506]={b=3615,s=723,d=26970,c=AUCT_CLAS_ARMOR},  -- Grunt's AnkleWraps
	[15507]={b=1820,s=364,d=26971,c=AUCT_CLAS_ARMOR},  -- Grunt's Bracers
	[15508]={b=1827,s=365,d=26977,c=AUCT_CLAS_ARMOR},  -- Grunt's Cape
	[15509]={b=2426,s=485,d=26973,c=AUCT_CLAS_ARMOR},  -- Grunt's Handwraps
	[15510]={b=2117,s=423,d=26969,c=AUCT_CLAS_ARMOR},  -- Grunt's Belt
	[15511]={b=7371,s=1474,d=26974,c=AUCT_CLAS_ARMOR},  -- Grunt's Legguards
	[15512]={b=7891,s=1578,d=26978,c=AUCT_CLAS_WEAPON},  -- Grunt's Shield
	[15513]={b=6320,s=1264,d=26975,c=AUCT_CLAS_ARMOR},  -- Grunt's Pauldrons
	[15514]={b=9514,s=1902,d=26972,c=AUCT_CLAS_ARMOR},  -- Grunt's Chestpiece
	[15515]={b=4224,s=844,d=26960,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Belt
	[15516]={b=7939,s=1587,d=26964,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Slippers
	[15517]={b=4254,s=850,d=24793,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Wristbands
	[15518]={b=14128,s=2825,d=26961,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Breastplate
	[15519]={b=3035,s=607,d=26962,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Cloak
	[15520]={b=4397,s=879,d=26963,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Gauntlets
	[15521]={b=9712,s=1942,d=26968,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Leggings
	[15522]={b=12584,s=2516,d=18775,c=AUCT_CLAS_WEAPON},  -- Spiked Chain Shield
	[15523]={b=7373,s=1474,d=26965,c=AUCT_CLAS_ARMOR},  -- Spiked Chain Shoulder Pads
	[15524]={b=14383,s=2876,d=27081,c=AUCT_CLAS_ARMOR},  -- Sentry's Surcoat
	[15525]={b=8171,s=1634,d=27540,c=AUCT_CLAS_ARMOR},  -- Sentry's Slippers
	[15526]={b=3523,s=704,d=27082,c=AUCT_CLAS_ARMOR},  -- Sentry's Cape
	[15527]={b=5101,s=1020,d=27075,c=AUCT_CLAS_ARMOR},  -- Sentry's Gloves
	[15528]={b=4654,s=930,d=27079,c=AUCT_CLAS_ARMOR},  -- Sentry's Sash
	[15529]={b=12437,s=2487,d=27076,c=AUCT_CLAS_ARMOR},  -- Sentry's Leggings
	[15530]={b=16110,s=3222,d=27084,c=AUCT_CLAS_WEAPON},  -- Sentry's Shield
	[15531]={b=10380,s=2076,d=27080,c=AUCT_CLAS_ARMOR},  -- Sentry's Shoulderguards
	[15532]={b=4722,s=944,d=27074,c=AUCT_CLAS_ARMOR},  -- Sentry's Armsplints
	[15533]={b=11450,s=2290,d=27083,c=AUCT_CLAS_ARMOR},  -- Sentry's Headdress
	[15534]={b=11542,s=2308,d=27037,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Boots
	[15535]={b=6352,s=1270,d=27038,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Bracers
	[15536]={b=20537,s=4107,d=27039,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Chestpiece
	[15537]={b=5816,s=1163,d=27040,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Cloak
	[15538]={b=7063,s=1412,d=27041,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Gauntlets
	[15539]={b=6413,s=1282,d=27045,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Waistband
	[15540]={b=14139,s=2827,d=27042,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Helmet
	[15541]={b=17205,s=3441,d=27043,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Legguards
	[15542]={b=11827,s=2365,d=27044,c=AUCT_CLAS_ARMOR},  -- Wicked Chain Shoulder Pads
	[15543]={b=20898,s=4179,d=26060,c=AUCT_CLAS_WEAPON},  -- Wicked Chain Shield
	[15544]={b=12243,s=2448,d=27022,c=AUCT_CLAS_ARMOR},  -- Thick Scale Sabatons
	[15545]={b=6740,s=1348,d=27017,c=AUCT_CLAS_ARMOR},  -- Thick Scale Bracelets
	[15546]={b=23969,s=4793,d=27018,c=AUCT_CLAS_ARMOR},  -- Thick Scale Breastplate
	[15547]={b=6172,s=1234,d=26951,c=AUCT_CLAS_ARMOR},  -- Thick Scale Cloak
	[15548]={b=8245,s=1649,d=27019,c=AUCT_CLAS_ARMOR},  -- Thick Scale Gauntlets
	[15549]={b=7523,s=1504,d=27016,c=AUCT_CLAS_ARMOR},  -- Thick Scale Belt
	[15550]={b=16582,s=3316,d=30091,c=AUCT_CLAS_ARMOR},  -- Thick Scale Crown
	[15551]={b=22190,s=4438,d=27020,c=AUCT_CLAS_ARMOR},  -- Thick Scale Legguards
	[15552]={b=26130,s=5226,d=27024,c=AUCT_CLAS_WEAPON},  -- Thick Scale Shield
	[15553]={b=15306,s=3061,d=27023,c=AUCT_CLAS_ARMOR},  -- Thick Scale Shoulder Pads
	[15554]={b=9267,s=1853,d=27068,c=AUCT_CLAS_ARMOR},  -- Pillager's Girdle
	[15555]={b=14013,s=2802,d=27065,c=AUCT_CLAS_ARMOR},  -- Pillager's Boots
	[15556]={b=8485,s=1697,d=27066,c=AUCT_CLAS_ARMOR},  -- Pillager's Bracers
	[15557]={b=27430,s=5486,d=27067,c=AUCT_CLAS_ARMOR},  -- Pillager's Chestguard
	[15558]={b=20643,s=4128,d=27073,c=AUCT_CLAS_ARMOR},  -- Pillager's Crown
	[15559]={b=7250,s=1450,d=27072,c=AUCT_CLAS_ARMOR},  -- Pillager's Cloak
	[15560]={b=9686,s=1937,d=27069,c=AUCT_CLAS_ARMOR},  -- Pillager's Gloves
	[15561]={b=23527,s=4705,d=27070,c=AUCT_CLAS_ARMOR},  -- Pillager's Leggings
	[15562]={b=17790,s=3558,d=27071,c=AUCT_CLAS_ARMOR},  -- Pillager's Pauldrons
	[15563]={b=27814,s=5562,d=20973,c=AUCT_CLAS_WEAPON},  -- Pillager's Shield
	[15564]={b=4000,s=1000,d=26388,x=10},  -- Rugged Armor Kit
	[15565]={b=21370,s=4274,d=27059,c=AUCT_CLAS_ARMOR},  -- Marauder's Boots
	[15566]={b=10894,s=2178,d=27058,c=AUCT_CLAS_ARMOR},  -- Marauder's Bracers
	[15567]={b=33333,s=6666,d=27063,c=AUCT_CLAS_ARMOR},  -- Marauder's Tunic
	[15568]={b=9069,s=1813,d=27062,c=AUCT_CLAS_ARMOR},  -- Marauder's Cloak
	[15569]={b=35813,s=7162,d=27064,c=AUCT_CLAS_WEAPON},  -- Marauder's Crest
	[15570]={b=12159,s=2431,d=27060,c=AUCT_CLAS_ARMOR},  -- Marauder's Gauntlets
	[15571]={b=11093,s=2218,d=27057,c=AUCT_CLAS_ARMOR},  -- Marauder's Belt
	[15572]={b=23571,s=4714,d=30092,c=AUCT_CLAS_ARMOR},  -- Marauder's Circlet
	[15573]={b=29202,s=5840,d=27061,c=AUCT_CLAS_ARMOR},  -- Marauder's Leggings
	[15574]={b=25751,s=5150,d=25872,c=AUCT_CLAS_ARMOR},  -- Marauder's Shoulder Pads
	[15575]={b=11500,s=2300,d=27110,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Belt
	[15576]={b=22314,s=4462,d=27115,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Sabatons
	[15577]={b=11587,s=2317,d=27111,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Bracers
	[15578]={b=34814,s=6962,d=27112,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Breastplate
	[15579]={b=10614,s=2122,d=25910,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Cloak
	[15580]={b=24357,s=4871,d=15517,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Headwrap
	[15581]={b=13973,s=2794,d=27113,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Gauntlets
	[15582]={b=32721,s=6544,d=27114,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Legguards
	[15583]={b=26722,s=5344,d=27116,c=AUCT_CLAS_ARMOR},  -- Sparkleshell Shoulder Pads
	[15584]={b=37973,s=7594,d=25911,c=AUCT_CLAS_WEAPON},  -- Sparkleshell Shield
	[15585]={b=7234,s=1446,d=28289,c=AUCT_CLAS_ARMOR},  -- Pardoc Grips
	[15587]={b=9110,s=1822,d=28292,c=AUCT_CLAS_ARMOR},  -- Ringtail Girdle
	[15588]={b=10972,s=2194,d=28265,c=AUCT_CLAS_ARMOR},  -- Bracesteel Belt
	[15589]={b=27314,s=5462,d=27891,c=AUCT_CLAS_ARMOR},  -- Steadfast Stompers
	[15590]={b=13373,s=2674,d=27895,c=AUCT_CLAS_ARMOR},  -- Steadfast Bracelets
	[15591]={b=43699,s=8739,d=27889,c=AUCT_CLAS_ARMOR},  -- Steadfast Breastplate
	[15592]={b=42328,s=8465,d=27896,c=AUCT_CLAS_WEAPON},  -- Steadfast Buckler
	[15593]={b=27663,s=5532,d=27898,c=AUCT_CLAS_ARMOR},  -- Steadfast Coronet
	[15594]={b=12600,s=2520,d=27108,c=AUCT_CLAS_ARMOR},  -- Steadfast Cloak
	[15595]={b=14752,s=2950,d=27892,c=AUCT_CLAS_ARMOR},  -- Steadfast Gloves
	[15596]={b=34546,s=6909,d=27890,c=AUCT_CLAS_ARMOR},  -- Steadfast Legplates
	[15597]={b=28214,s=5642,d=27893,c=AUCT_CLAS_ARMOR},  -- Steadfast Shoulders
	[15598]={b=13816,s=2763,d=27894,c=AUCT_CLAS_ARMOR},  -- Steadfast Girdle
	[15599]={b=33156,s=6631,d=27120,c=AUCT_CLAS_ARMOR},  -- Ancient Greaves
	[15600]={b=18938,s=3787,d=27122,c=AUCT_CLAS_ARMOR},  -- Ancient Vambraces
	[15601]={b=51726,s=10345,d=27118,c=AUCT_CLAS_ARMOR},  -- Ancient Chestpiece
	[15602]={b=36055,s=7211,d=27124,c=AUCT_CLAS_ARMOR},  -- Ancient Crown
	[15603]={b=17731,s=3546,d=27082,c=AUCT_CLAS_ARMOR},  -- Ancient Cloak
	[15604]={b=55790,s=11158,d=27126,c=AUCT_CLAS_WEAPON},  -- Ancient Defender
	[15605]={b=19293,s=3858,d=27119,c=AUCT_CLAS_ARMOR},  -- Ancient Gauntlets
	[15606]={b=17928,s=3585,d=27117,c=AUCT_CLAS_ARMOR},  -- Ancient Belt
	[15607]={b=46529,s=9305,d=27121,c=AUCT_CLAS_ARMOR},  -- Ancient Legguards
	[15608]={b=35177,s=7035,d=27123,c=AUCT_CLAS_ARMOR},  -- Ancient Pauldrons
	[15609]={b=59033,s=11806,d=27322,c=AUCT_CLAS_ARMOR},  -- Bonelink Armor
	[15610]={b=21770,s=4354,d=27324,c=AUCT_CLAS_ARMOR},  -- Bonelink Bracers
	[15611]={b=21847,s=4369,d=27325,c=AUCT_CLAS_ARMOR},  -- Bonelink Cape
	[15612]={b=21426,s=4285,d=27326,c=AUCT_CLAS_ARMOR},  -- Bonelink Gauntlets
	[15613]={b=18440,s=3688,d=27323,c=AUCT_CLAS_ARMOR},  -- Bonelink Belt
	[15614]={b=35132,s=7026,d=27328,c=AUCT_CLAS_ARMOR},  -- Bonelink Sabatons
	[15615]={b=37920,s=7584,d=26098,c=AUCT_CLAS_ARMOR},  -- Bonelink Helmet
	[15616]={b=50755,s=10151,d=27327,c=AUCT_CLAS_ARMOR},  -- Bonelink Legplates
	[15617]={b=35538,s=7107,d=26091,c=AUCT_CLAS_ARMOR},  -- Bonelink Epaulets
	[15618]={b=58910,s=11782,d=26099,c=AUCT_CLAS_WEAPON},  -- Bonelink Wall Shield
	[15619]={b=29936,s=5987,d=27127,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Belt
	[15620]={b=27824,s=5564,d=27128,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Bracelets
	[15621]={b=78830,s=15766,d=27135,c=AUCT_CLAS_WEAPON},  -- Gryphon Mail Buckler
	[15622]={b=74173,s=14834,d=27129,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Breastplate
	[15623]={b=53579,s=10715,d=28977,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Crown
	[15624]={b=24855,s=4971,d=28565,c=AUCT_CLAS_ARMOR},  -- Gryphon Cloak
	[15625]={b=29094,s=5818,d=27131,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Gauntlets
	[15626]={b=43993,s=8798,d=27132,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Greaves
	[15627]={b=72468,s=14493,d=27133,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Legguards
	[15628]={b=47854,s=9570,d=27134,c=AUCT_CLAS_ARMOR},  -- Gryphon Mail Pauldrons
	[15629]={b=31871,s=6374,d=27208,c=AUCT_CLAS_ARMOR},  -- Formidable Bracers
	[15630]={b=51564,s=10312,d=27215,c=AUCT_CLAS_ARMOR},  -- Formidable Sabatons
	[15631]={b=83363,s=16672,d=27212,c=AUCT_CLAS_ARMOR},  -- Formidable Chestpiece
	[15632]={b=24989,s=4997,d=27220,c=AUCT_CLAS_ARMOR},  -- Formidable Cape
	[15633]={b=81050,s=16210,d=27222,c=AUCT_CLAS_WEAPON},  -- Formidable Crest
	[15634]={b=57208,s=11441,d=26330,c=AUCT_CLAS_ARMOR},  -- Formidable Circlet
	[15635]={b=29483,s=5896,d=27825,c=AUCT_CLAS_ARMOR},  -- Formidable Gauntlets
	[15636]={b=31669,s=6333,d=27206,c=AUCT_CLAS_ARMOR},  -- Formidable Belt
	[15637]={b=72786,s=14557,d=27214,c=AUCT_CLAS_ARMOR},  -- Formidable Legguards
	[15638]={b=48074,s=9614,d=27218,c=AUCT_CLAS_ARMOR},  -- Formidable Shoulder Pads
	[15639]={b=35200,s=7040,d=27170,c=AUCT_CLAS_ARMOR},  -- Ironhide Bracers
	[15640]={b=101168,s=20233,d=27171,c=AUCT_CLAS_ARMOR},  -- Ironhide Breastplate
	[15641]={b=37938,s=7587,d=27169,c=AUCT_CLAS_ARMOR},  -- Ironhide Belt
	[15642]={b=60811,s=12162,d=27173,c=AUCT_CLAS_ARMOR},  -- Ironhide Greaves
	[15643]={b=33379,s=6675,d=27176,c=AUCT_CLAS_ARMOR},  -- Ironhide Cloak
	[15644]={b=40651,s=8130,d=29006,c=AUCT_CLAS_ARMOR},  -- Ironhide Gauntlets
	[15645]={b=72887,s=14577,d=27178,c=AUCT_CLAS_ARMOR},  -- Ironhide Helmet
	[15646]={b=97534,s=19506,d=27174,c=AUCT_CLAS_ARMOR},  -- Ironhide Legguards
	[15647]={b=65628,s=13125,d=27177,c=AUCT_CLAS_ARMOR},  -- Ironhide Pauldrons
	[15648]={b=111061,s=22212,d=27179,c=AUCT_CLAS_WEAPON},  -- Ironhide Shield
	[15649]={b=39041,s=7808,d=27286,c=AUCT_CLAS_ARMOR},  -- Merciless Bracers
	[15650]={b=111154,s=22230,d=27290,c=AUCT_CLAS_ARMOR},  -- Merciless Surcoat
	[15651]={b=78925,s=15785,d=27293,c=AUCT_CLAS_ARMOR},  -- Merciless Crown
	[15652]={b=35699,s=7139,d=27292,c=AUCT_CLAS_ARMOR},  -- Merciless Cloak
	[15653]={b=40266,s=8053,d=27287,c=AUCT_CLAS_ARMOR},  -- Merciless Gauntlets
	[15654]={b=42848,s=8569,d=27285,c=AUCT_CLAS_ARMOR},  -- Merciless Belt
	[15655]={b=99310,s=19862,d=27289,c=AUCT_CLAS_ARMOR},  -- Merciless Legguards
	[15656]={b=66833,s=13366,d=27291,c=AUCT_CLAS_ARMOR},  -- Merciless Epaulets
	[15657]={b=113128,s=22625,d=27294,c=AUCT_CLAS_WEAPON},  -- Merciless Shield
	[15658]={b=89254,s=17850,d=27301,c=AUCT_CLAS_ARMOR},  -- Impenetrable Sabatons
	[15659]={b=47540,s=9508,d=27296,c=AUCT_CLAS_ARMOR},  -- Impenetrable Bindings
	[15660]={b=131577,s=26315,d=27297,c=AUCT_CLAS_ARMOR},  -- Impenetrable Breastplate
	[15661]={b=45180,s=9036,d=27304,c=AUCT_CLAS_ARMOR},  -- Impenetrable Cloak
	[15662]={b=54007,s=10801,d=27299,c=AUCT_CLAS_ARMOR},  -- Impenetrable Gauntlets
	[15663]={b=51130,s=10226,d=27295,c=AUCT_CLAS_ARMOR},  -- Impenetrable Belt
	[15664]={b=95355,s=19071,d=27306,c=AUCT_CLAS_ARMOR},  -- Impenetrable Helmet
	[15665]={b=127600,s=25520,d=27300,c=AUCT_CLAS_ARMOR},  -- Impenetrable Legguards
	[15666]={b=91877,s=18375,d=27302,c=AUCT_CLAS_ARMOR},  -- Impenetrable Pauldrons
	[15667]={b=143928,s=28785,d=27305,c=AUCT_CLAS_WEAPON},  -- Impenetrable Wall
	[15668]={b=58488,s=11697,d=27314,c=AUCT_CLAS_ARMOR},  -- Magnificent Bracers
	[15669]={b=142694,s=28538,d=27315,c=AUCT_CLAS_ARMOR},  -- Magnificent Breastplate
	[15670]={b=102277,s=20455,d=27908,c=AUCT_CLAS_ARMOR},  -- Magnificent Helmet
	[15671]={b=48912,s=9782,d=26141,c=AUCT_CLAS_ARMOR},  -- Magnificent Cloak
	[15672]={b=60821,s=12164,d=27317,c=AUCT_CLAS_ARMOR},  -- Magnificent Gauntlets
	[15673]={b=55375,s=11075,d=27313,c=AUCT_CLAS_ARMOR},  -- Magnificent Belt
	[15674]={b=92321,s=18464,d=27318,c=AUCT_CLAS_ARMOR},  -- Magnificent Greaves
	[15675]={b=144661,s=28932,d=26152,c=AUCT_CLAS_WEAPON},  -- Magnificent Guard
	[15676]={b=129644,s=25928,d=27319,c=AUCT_CLAS_ARMOR},  -- Magnificent Leggings
	[15677]={b=98029,s=19605,d=27320,c=AUCT_CLAS_ARMOR},  -- Magnificent Shoulders
	[15678]={b=108468,s=21693,d=27312,c=AUCT_CLAS_ARMOR},  -- Triumphant Sabatons
	[15679]={b=65540,s=13108,d=27307,c=AUCT_CLAS_ARMOR},  -- Triumphant Bracers
	[15680]={b=159918,s=31983,d=27308,c=AUCT_CLAS_ARMOR},  -- Triumphant Chestpiece
	[15681]={b=57033,s=11406,d=26259,c=AUCT_CLAS_ARMOR},  -- Triumphant Cloak
	[15682]={b=73050,s=14610,d=27309,c=AUCT_CLAS_ARMOR},  -- Triumphant Gauntlets
	[15683]={b=63333,s=12666,d=27310,c=AUCT_CLAS_ARMOR},  -- Triumphant Girdle
	[15684]={b=115893,s=23178,d=27151,c=AUCT_CLAS_ARMOR},  -- Triumphant Skullcap
	[15685]={b=147698,s=29539,d=27311,c=AUCT_CLAS_ARMOR},  -- Triumphant Legplates
	[15686]={b=111657,s=22331,d=16079,c=AUCT_CLAS_ARMOR},  -- Triumphant Shoulder Pads
	[15689]={b=16160,s=4040,d=26391,c=AUCT_CLAS_ARMOR},  -- Trader's Ring
	[15690]={b=19650,s=4912,d=9860,c=AUCT_CLAS_ARMOR},  -- Kodobone Necklace
	[15691]={b=34545,s=6909,d=26411,c=AUCT_CLAS_WEAPON},  -- Sidegunner Shottie
	[15692]={b=33815,s=6763,d=26412,c=AUCT_CLAS_WEAPON},  -- Kodo Brander
	[15693]={b=72665,s=14533,d=28020,c=AUCT_CLAS_ARMOR},  -- Grand Shoulders
	[15694]={b=66322,s=13264,d=27288,c=AUCT_CLAS_ARMOR},  -- Merciless Greaves
	[15695]={b=28856,s=5771,d=26413,c=AUCT_CLAS_WEAPON},  -- Studded Ring Shield
	[15696]={b=0,s=0,d=3426},  -- Ruined Tome
	[15697]={b=14129,s=2825,d=26415,c=AUCT_CLAS_ARMOR},  -- Kodo Rustler Boots
	[15698]={b=21368,s=4273,d=26419,c=AUCT_CLAS_ARMOR},  -- Wrangling Spaulders
	[15699]={b=100,s=25,d=26420},  -- Small Brown-wrapped Package
	[15702]={b=29585,s=7396,d=6486,c=AUCT_CLAS_ARMOR},  -- Chemist's Ring
	[15703]={b=45163,s=9032,d=26431,c=AUCT_CLAS_ARMOR},  -- Chemist's Smock
	[15704]={b=24580,s=6145,d=4841,c=AUCT_CLAS_ARMOR},  -- Hunter's Insignia Medal
	[15705]={b=169154,s=33830,d=26432,c=AUCT_CLAS_WEAPON},  -- Tidecrest Blade
	[15706]={b=169154,s=33830,d=26433,c=AUCT_CLAS_WEAPON},  -- Hunt Tracker Blade
	[15707]={b=36078,s=7215,d=26435,c=AUCT_CLAS_ARMOR},  -- Brantwood Sash
	[15708]={b=44825,s=8965,d=26436,c=AUCT_CLAS_ARMOR},  -- Blight Leather Gloves
	[15709]={b=36352,s=7270,d=26437,c=AUCT_CLAS_ARMOR},  -- Gearforge Girdle
	[15710]={b=0,s=0,d=20614},  -- Cenarion Lunardust
	[15722]={b=0,s=0,d=21794},  -- Spraggle's Canteen
	[15723]={b=11300,s=2825,d=19873},  -- Tea with Sugar
	[15724]={b=12000,s=3000,d=1102},  -- Pattern: Heavy Scorpid Bracers
	[15725]={b=12000,s=3000,d=1102},  -- Pattern: Wicked Leather Gauntlets
	[15726]={b=12000,s=3000,d=1102},  -- Pattern: Green Dragonscale Breastplate
	[15727]={b=12000,s=3000,d=1102},  -- Pattern: Heavy Scorpid Vest
	[15728]={b=12000,s=3000,d=1102},  -- Pattern: Wicked Leather Bracers
	[15729]={b=12000,s=3000,d=1102},  -- Pattern: Chimeric Gloves
	[15730]={b=12000,s=3000,d=1102},  -- Pattern: Red Dragonscale Breastplate
	[15731]={b=14000,s=3500,d=1102},  -- Pattern: Runic Leather Gauntlets
	[15732]={b=14000,s=3500,d=1102},  -- Pattern: Volcanic Leggings
	[15733]={b=14000,s=3500,d=1102},  -- Pattern: Green Dragonscale Leggings
	[15734]={b=14000,s=3500,d=1102},  -- Pattern: Living Shoulders
	[15735]={b=14000,s=3500,d=1102},  -- Pattern: Ironfeather Shoulders
	[15736]={b=0,s=0,d=26459},  -- Smokey's Special Compound
	[15737]={b=16000,s=4000,d=15274},  -- Pattern: Chimeric Boots
	[15738]={b=16000,s=4000,d=1102},  -- Pattern: Heavy Scorpid Gauntlets
	[15739]={b=16000,s=4000,d=1102},  -- Pattern: Runic Leather Bracers
	[15740]={b=16000,s=4000,d=1102},  -- Pattern: Frostsaber Boots
	[15741]={b=16000,s=4000,d=1102},  -- Pattern: Stormshroud Pants
	[15742]={b=16000,s=4000,d=1102},  -- Pattern: Warbear Harness
	[15743]={b=20000,s=5000,d=1102},  -- Pattern: Heavy Scorpid Belt
	[15744]={b=20000,s=5000,d=1102},  -- Pattern: Wicked Leather Headband
	[15745]={b=20000,s=5000,d=1102},  -- Pattern: Runic Leather Belt
	[15746]={b=20000,s=5000,d=15274},  -- Pattern: Chimeric Leggings
	[15747]={b=20000,s=5000,d=1102},  -- Pattern: Frostsaber Leggings
	[15748]={b=20000,s=5000,d=1102},  -- Pattern: Heavy Scorpid Leggings
	[15749]={b=20000,s=5000,d=1102},  -- Pattern: Volcanic Breastplate
	[15750]={b=0,s=0,d=26460},  -- Sceptre of Light
	[15751]={b=20000,s=5000,d=1102},  -- Pattern: Blue Dragonscale Breastplate
	[15752]={b=20000,s=5000,d=1102},  -- Pattern: Living Leggings
	[15753]={b=20000,s=5000,d=1102},  -- Pattern: Stormshroud Armor
	[15754]={b=20000,s=5000,d=1102},  -- Pattern: Warbear Woolies
	[15755]={b=22000,s=5500,d=15274},  -- Pattern: Chimeric Vest
	[15756]={b=22000,s=5500,d=1102},  -- Pattern: Runic Leather Headband
	[15757]={b=22000,s=5500,d=1102},  -- Pattern: Wicked Leather Pants
	[15758]={b=22000,s=5500,d=1102},  -- Pattern: Devilsaur Gauntlets
	[15759]={b=22000,s=5500,d=1102},  -- Pattern: Black Dragonscale Breastplate
	[15760]={b=22000,s=5500,d=1102},  -- Pattern: Ironfeather Breastplate
	[15761]={b=25000,s=6250,d=15274},  -- Pattern: Frostsaber Gloves
	[15762]={b=25000,s=6250,d=1102},  -- Pattern: Heavy Scorpid Helm
	[15763]={b=25000,s=6250,d=1102},  -- Pattern: Blue Dragonscale Shoulders
	[15764]={b=25000,s=6250,d=1102},  -- Pattern: Stormshroud Shoulders
	[15765]={b=30000,s=7500,d=1102},  -- Pattern: Runic Leather Pants
	[15766]={b=0,s=0,d=22651},  -- Gem of the Serpent
	[15767]={b=0,s=0,d=23740},  -- Hameya's Key
	[15768]={b=30000,s=7500,d=1102},  -- Pattern: Wicked Leather Belt
	[15770]={b=30000,s=7500,d=1102},  -- Pattern: Black Dragonscale Shoulders
	[15771]={b=30000,s=7500,d=1102},  -- Pattern: Living Breastplate
	[15772]={b=30000,s=7500,d=1102},  -- Pattern: Devilsaur Leggings
	[15773]={b=40000,s=10000,d=1102},  -- Pattern: Wicked Leather Armor
	[15774]={b=40000,s=10000,d=1102},  -- Pattern: Heavy Scorpid Shoulders
	[15775]={b=40000,s=10000,d=1102},  -- Pattern: Volcanic Shoulders
	[15776]={b=40000,s=10000,d=1102},  -- Pattern: Runic Leather Armor
	[15777]={b=60000,s=15000,d=1102},  -- Pattern: Runic Leather Shoulders
	[15778]={b=5000,s=1250,d=26461},  -- Mechanical Yeti
	[15779]={b=60000,s=15000,d=1102},  -- Pattern: Frostsaber Tunic
	[15781]={b=60000,s=15000,d=6270},  -- Pattern: Black Dragonscale Leggings
	[15782]={b=215714,s=43142,d=26463,c=AUCT_CLAS_WEAPON},  -- Beaststalker Blade
	[15783]={b=216460,s=43292,d=26464,c=AUCT_CLAS_WEAPON},  -- Beasthunter Dagger
	[15784]={b=57705,s=11541,d=26465,c=AUCT_CLAS_ARMOR},  -- Crystal Breeze Mantle
	[15785]={b=0,s=0,d=18136},  -- Zaeldarr's Head
	[15786]={b=94134,s=18826,d=26466,c=AUCT_CLAS_ARMOR},  -- Fernpulse Jerkin
	[15787]={b=112961,s=22592,d=26467,c=AUCT_CLAS_ARMOR},  -- Willow Band Hauberk
	[15788]={b=0,s=0,d=15274},  -- Everlook Report
	[15789]={b=47873,s=9574,d=26468,c=AUCT_CLAS_ARMOR},  -- Deep River Cloak
	[15790]={b=0,s=0,d=8093,c=AUCT_CLAS_WRITTEN},  -- Studies in Spirit Speaking
	[15791]={b=35860,s=7172,d=26470,c=AUCT_CLAS_ARMOR},  -- Turquoise Sash
	[15792]={b=70770,s=14154,d=26472,c=AUCT_CLAS_ARMOR},  -- Plow Wood Spaulders
	[15793]={b=200,s=50,d=26474,x=20},  -- A Chewed Bone
	[15794]={b=195,s=39,d=12413,c=AUCT_CLAS_ARMOR},  -- Ripped Ogre Loincloth
	[15795]={b=38157,s=7631,d=26473,c=AUCT_CLAS_ARMOR},  -- Emerald Mist Gauntlets
	[15796]={b=60317,s=12063,d=26475,c=AUCT_CLAS_ARMOR},  -- Seaspray Bracers
	[15797]={b=37653,s=7530,d=26476,c=AUCT_CLAS_ARMOR},  -- Shining Armplates
	[15798]={b=200,s=50,d=7054,x=20},  -- Chipped Ogre Teeth
	[15799]={b=28435,s=7108,d=4841,c=AUCT_CLAS_ARMOR},  -- Heroic Commendation Medal
	[15800]={b=180413,s=36082,d=26477,c=AUCT_CLAS_WEAPON},  -- Intrepid Shortsword
	[15801]={b=179303,s=35860,d=26479,c=AUCT_CLAS_WEAPON},  -- Valiant Shortsword
	[15802]={b=58243,s=11648,d=17256,c=AUCT_CLAS_ARMOR},  -- Mooncloth Boots
	[15803]={b=0,s=0,d=1246},  -- Book of the Ancients
	[15804]={b=47873,s=9574,d=25958,c=AUCT_CLAS_ARMOR},  -- Cerise Drape
	[15805]={b=58650,s=14662,d=26491,c=AUCT_CLAS_WEAPON},  -- Penelope's Rose
	[15806]={b=256366,s=51273,d=26494,c=AUCT_CLAS_WEAPON},  -- Mirah's Song
	[15807]={b=294,s=58,d=10671,c=AUCT_CLAS_WEAPON},  -- Light Crossbow
	[15808]={b=3640,s=728,d=10671,c=AUCT_CLAS_WEAPON},  -- Fine Light Crossbow
	[15809]={b=14691,s=2938,d=28911,c=AUCT_CLAS_WEAPON},  -- Heavy Crossbow
	[15810]={b=10145,s=2029,d=26500,c=AUCT_CLAS_WEAPON},  -- Short Spear
	[15811]={b=27132,s=5426,d=5636,c=AUCT_CLAS_WEAPON},  -- Heavy Spear
	[15812]={b=47873,s=9574,d=26501,c=AUCT_CLAS_ARMOR},  -- Orchid Amice
	[15813]={b=50568,s=10113,d=26502,c=AUCT_CLAS_ARMOR},  -- Gold Link Belt
	[15814]={b=209558,s=41911,d=26503,c=AUCT_CLAS_WEAPON},  -- Hameya's Slayer
	[15815]={b=59304,s=11860,d=23042,c=AUCT_CLAS_ARMOR},  -- Hameya's Cloak
	[15822]={b=56454,s=11290,d=26504,c=AUCT_CLAS_ARMOR},  -- Shadowskin Spaulders
	[15823]={b=45958,s=9191,d=26512,c=AUCT_CLAS_ARMOR},  -- Bricksteel Gauntlets
	[15824]={b=75307,s=15061,d=26513,c=AUCT_CLAS_ARMOR},  -- Astoria Robes
	[15825]={b=96512,s=19302,d=26514,c=AUCT_CLAS_ARMOR},  -- Traphook Jerkin
	[15826]={b=0,s=0,d=21845},  -- Curative Animal Salve
	[15827]={b=112961,s=22592,d=26515,c=AUCT_CLAS_ARMOR},  -- Jadescale Breastplate
	[15842]={b=0,s=0,d=8545},  -- Empty Dreadmist Peak Sampler
	[15843]={b=0,s=0,d=26531},  -- Filled Dreadmist Peak Sampler
	[15844]={b=0,s=0,d=8545},  -- Empty Cliffspring Falls Sampler
	[15845]={b=0,s=0,d=26531},  -- Filled Cliffspring Falls Sampler
	[15846]={b=30000,s=7500,d=18632},  -- Salt Shaker
	[15847]={b=0,s=0,d=1317,c=AUCT_CLAS_WRITTEN},  -- Quel'Thalas Registry
	[15848]={b=0,s=0,d=8928},  -- Crate of Ghost Magnets
	[15849]={b=0,s=0,d=2885,q=20,x=20},  -- Ghost-o-plasm
	[15850]={b=0,s=0,d=26533},  -- Patch of Duskwing's Fur
	[15851]={b=0,s=0,d=26534,q=20,x=20},  -- Lunar Fungus
	[15852]={b=0,s=0,d=11947,q=20,x=20},  -- Kodo Horn
	[15853]={b=257091,s=51418,d=26535,c=AUCT_CLAS_WEAPON},  -- Windreaper
	[15854]={b=322514,s=64502,d=26536,c=AUCT_CLAS_WEAPON},  -- Dancing Sliver
	[15855]={b=31555,s=7888,d=26537,c=AUCT_CLAS_ARMOR},  -- Ring of Protection
	[15856]={b=35155,s=8788,d=9657,c=AUCT_CLAS_ARMOR},  -- Archlight Talisman
	[15857]={b=61342,s=15335,d=26539,c=AUCT_CLAS_WEAPON},  -- Magebane Scion
	[15858]={b=37653,s=7530,d=26540,c=AUCT_CLAS_ARMOR},  -- Freewind Gloves
	[15859]={b=56480,s=11296,d=26541,c=AUCT_CLAS_ARMOR},  -- Seapost Girdle
	[15860]={b=39535,s=7907,d=26542,c=AUCT_CLAS_ARMOR},  -- Blinkstrike Armguards
	[15861]={b=74845,s=14969,d=26543,c=AUCT_CLAS_ARMOR},  -- Swiftfoot Treads
	[15862]={b=143946,s=28789,d=26545,c=AUCT_CLAS_WEAPON},  -- Blitzcleaver
	[15863]={b=144482,s=28896,d=5207,c=AUCT_CLAS_WEAPON},  -- Grave Scepter
	[15864]={b=9738,s=1947,d=3658,c=AUCT_CLAS_ARMOR},  -- Condor Bracers
	[15865]={b=32811,s=6562,d=26548,c=AUCT_CLAS_WEAPON},  -- Anchorhold Buckler
	[15866]={b=2250,s=562,d=26549,c=AUCT_CLAS_WEAPON},  -- Veildust Medicine Bag
	[15867]={b=29857,s=7464,d=26551,c=AUCT_CLAS_ARMOR},  -- Prismcharm
	[15868]={b=0,s=0,d=16065},  -- The Grand Crusader's Command
	[15869]={b=200,s=50,d=8031,x=20},  -- Silver Skeleton Key
	[15870]={b=1200,s=300,d=22477,x=20},  -- Golden Skeleton Key
	[15871]={b=2500,s=625,d=22071,x=20},  -- Truesilver Skeleton Key
	[15872]={b=2500,s=625,d=13885,x=20},  -- Arcanite Skeleton Key
	[15873]={b=32578,s=8144,d=18119,c=AUCT_CLAS_ARMOR},  -- Ragged John's Neverending Cup
	[15874]={b=0,s=0,d=26552},  -- Soft-shelled Clam
	[15875]={b=0,s=0,d=7856,c=AUCT_CLAS_FOOD},  -- Rotten Apple
	[15876]={b=0,s=0,d=26381},  -- Nathanos' Chest
	[15877]={b=0,s=0,d=26571,c=AUCT_CLAS_FISHING},  -- Shrine Bauble
	[15878]={b=0,s=0,d=4287},  -- Rackmore's Silver Key
	[15879]={b=0,s=0,d=1769},  -- Overlord Ror's Claw
	[15880]={b=0,s=0,d=7164},  -- Head of Ramstein the Gorger
	[15881]={b=0,s=0,d=6706},  -- Rackmore's Golden Key
	[15882]={b=0,s=0,d=26582},  -- Half Pendant of Aquatic Endurance
	[15883]={b=0,s=0,d=26583},  -- Half Pendant of Aquatic Agility
	[15884]={b=0,s=0,d=8093},  -- Augustus' Receipt Book
	[15885]={b=0,s=0,d=26584},  -- Pendant of the Sea Lion
	[15886]={b=0,s=0,d=1262},  -- Timolain's Phylactery
	[15887]={b=147908,s=29581,d=26921,c=AUCT_CLAS_WEAPON},  -- Heroic Guard
	[15890]={b=129157,s=25831,d=26855,c=AUCT_CLAS_WEAPON},  -- Vanguard Shield
	[15891]={b=10074,s=2014,d=23825,c=AUCT_CLAS_WEAPON},  -- Hulking Shield
	[15892]={b=17911,s=3582,d=27036,c=AUCT_CLAS_WEAPON},  -- Slayer's Shield
	[15893]={b=5410,s=1082,d=27527,c=AUCT_CLAS_WEAPON},  -- Prospector's Buckler
	[15894]={b=9010,s=1802,d=18483,c=AUCT_CLAS_WEAPON},  -- Bristlebark Buckler
	[15895]={b=265,s=53,d=28449,c=AUCT_CLAS_WEAPON},  -- Burnt Buckler
	[15902]={b=80000,s=20000,d=12333},  -- A Crazy Grab Bag
	[15903]={b=8117,s=1623,d=26593,c=AUCT_CLAS_WEAPON},  -- Right-Handed Claw
	[15904]={b=21708,s=4341,d=26596,c=AUCT_CLAS_WEAPON},  -- Right-Handed Blades
	[15905]={b=2130,s=426,d=26592,c=AUCT_CLAS_WEAPON},  -- Right-Handed Brass Knuckles
	[15906]={b=2138,s=427,d=26592,c=AUCT_CLAS_WEAPON},  -- Left-Handed Brass Knuckles
	[15907]={b=8237,s=1647,d=26594,c=AUCT_CLAS_WEAPON},  -- Left-Handed Claw
	[15908]={b=0,s=0,d=26595},  -- Taming Rod
	[15909]={b=22107,s=4421,d=26597,c=AUCT_CLAS_WEAPON},  -- Left-Handed Blades
	[15911]={b=0,s=0,d=26595},  -- Taming Rod
	[15912]={b=4594,s=1148,d=28471,c=AUCT_CLAS_WEAPON},  -- Buccaneer's Orb
	[15913]={b=0,s=0,d=26595},  -- Taming Rod
	[15914]={b=0,s=0,d=26595},  -- Taming Rod
	[15915]={b=0,s=0,d=26595},  -- Taming Rod
	[15916]={b=0,s=0,d=26595},  -- Taming Rod
	[15917]={b=0,s=0,d=26595},  -- Taming Rod
	[15918]={b=19392,s=4848,d=28472,c=AUCT_CLAS_WEAPON},  -- Conjurer's Sphere
	[15919]={b=0,s=0,d=26595},  -- Taming Rod
	[15920]={b=0,s=0,d=26595},  -- Taming Rod
	[15921]={b=0,s=0,d=26595},  -- Taming Rod
	[15922]={b=0,s=0,d=26595},  -- Taming Rod
	[15923]={b=0,s=0,d=26595},  -- Taming Rod
	[15924]={b=0,s=0,d=22193,q=10,x=10,u=AUCT_TYPE_COOK},  -- Soft-shelled Clam Meat
	[15925]={b=1758,s=439,d=28462,c=AUCT_CLAS_WEAPON},  -- Journeyman's Stave
	[15926]={b=3210,s=802,d=28464,c=AUCT_CLAS_WEAPON},  -- Spellbinder Orb
	[15927]={b=7458,s=1864,d=27556,c=AUCT_CLAS_WEAPON},  -- Bright Sphere
	[15928]={b=9548,s=2387,d=28466,c=AUCT_CLAS_WEAPON},  -- Silver-thread Rod
	[15929]={b=17585,s=4396,d=27558,c=AUCT_CLAS_WEAPON},  -- Nightsky Orb
	[15930]={b=36584,s=9146,d=27563,c=AUCT_CLAS_WEAPON},  -- Imperial Red Scepter
	[15931]={b=42584,s=10646,d=27575,c=AUCT_CLAS_WEAPON},  -- Arcane Star
	[15932]={b=2110,s=527,d=28473,c=AUCT_CLAS_WEAPON},  -- Disciple's Stein
	[15933]={b=2480,s=620,d=27851,c=AUCT_CLAS_WEAPON},  -- Simple Branch
	[15934]={b=10384,s=2596,d=28481,c=AUCT_CLAS_WEAPON},  -- Sage's Stave
	[15935]={b=13295,s=3323,d=27863,c=AUCT_CLAS_WEAPON},  -- Durable Rod
	[15936]={b=35802,s=8950,d=28475,c=AUCT_CLAS_WEAPON},  -- Duskwoven Branch
	[15937]={b=31690,s=7922,d=28455,c=AUCT_CLAS_WEAPON},  -- Hibernal Sphere
	[15938]={b=38203,s=9550,d=28480,c=AUCT_CLAS_WEAPON},  -- Mystical Orb
	[15939]={b=41823,s=10455,d=27612,c=AUCT_CLAS_WEAPON},  -- Councillor's Scepter
	[15940]={b=43829,s=10957,d=28476,c=AUCT_CLAS_WEAPON},  -- Elegant Scepter
	[15941]={b=49382,s=12345,d=27650,c=AUCT_CLAS_WEAPON},  -- High Councillor's Scepter
	[15942]={b=51029,s=12757,d=28478,c=AUCT_CLAS_WEAPON},  -- Master's Rod
	[15943]={b=138761,s=27752,d=27588,c=AUCT_CLAS_WEAPON},  -- Imbued Shield
	[15944]={b=2051,s=512,d=28483,c=AUCT_CLAS_WEAPON},  -- Ancestral Orb
	[15945]={b=3351,s=837,d=28488,c=AUCT_CLAS_WEAPON},  -- Runic Stave
	[15946]={b=4495,s=802,d=28487,c=AUCT_CLAS_WEAPON},  -- Mystic's Sphere
	[15947]={b=7548,s=1887,d=28489,c=AUCT_CLAS_WEAPON},  -- Sanguine Star
	[15962]={b=10864,s=2716,d=28492,c=AUCT_CLAS_WEAPON},  -- Satyr's Rod
	[15963]={b=19548,s=4887,d=28491,c=AUCT_CLAS_WEAPON},  -- Stonecloth Branch
	[15964]={b=25458,s=6364,d=28493,c=AUCT_CLAS_WEAPON},  -- Silksand Star
	[15965]={b=31986,s=7996,d=28490,c=AUCT_CLAS_WEAPON},  -- Windchaser Orb
	[15966]={b=36548,s=9137,d=27874,c=AUCT_CLAS_WEAPON},  -- Venomshroud Orb
	[15967]={b=41218,s=10304,d=28486,c=AUCT_CLAS_WEAPON},  -- Highborne Star
	[15969]={b=1700,s=425,d=28503,c=AUCT_CLAS_WEAPON},  -- Beaded Orb
	[15970]={b=2348,s=587,d=28554,c=AUCT_CLAS_WEAPON},  -- Native Branch
	[15971]={b=4258,s=1064,d=24014,c=AUCT_CLAS_WEAPON},  -- Aboriginal Rod
	[15972]={b=4685,s=1171,d=28562,c=AUCT_CLAS_WEAPON},  -- Ritual Stein
	[15973]={b=9254,s=2313,d=28551,c=AUCT_CLAS_WEAPON},  -- Watcher's Star
	[15974]={b=5846,s=1461,d=5072,c=AUCT_CLAS_WEAPON},  -- Pagan Rod
	[15975]={b=9684,s=2421,d=28514,c=AUCT_CLAS_WEAPON},  -- Raincaller Scepter
	[15976]={b=16584,s=4146,d=28555,c=AUCT_CLAS_WEAPON},  -- Thistlefur Branch
	[15977]={b=18456,s=4614,d=28025,c=AUCT_CLAS_WEAPON},  -- Vital Orb
	[15978]={b=21542,s=5385,d=28513,c=AUCT_CLAS_WEAPON},  -- Geomancer's Rod
	[15979]={b=23515,s=7215,d=18289,c=AUCT_CLAS_WEAPON},  -- Embersilk Stave
	[15980]={b=29878,s=7469,d=28505,c=AUCT_CLAS_WEAPON},  -- Darkmist Orb
	[15981]={b=31548,s=7215,d=28553,c=AUCT_CLAS_WEAPON},  -- Lunar Sphere
	[15982]={b=32568,s=8142,d=28510,c=AUCT_CLAS_WEAPON},  -- Bloodwoven Rod
	[15983]={b=33548,s=8387,d=28516,c=AUCT_CLAS_WEAPON},  -- Gaea's Scepter
	[15984]={b=38458,s=9614,d=27929,c=AUCT_CLAS_WEAPON},  -- Opulent Scepter
	[15985]={b=39548,s=9887,d=28500,c=AUCT_CLAS_WEAPON},  -- Arachnidian Branch
	[15986]={b=43254,s=10813,d=20384,c=AUCT_CLAS_WEAPON},  -- Bonecaster's Star
	[15987]={b=43985,s=10996,d=28501,c=AUCT_CLAS_WEAPON},  -- Astral Orb
	[15988]={b=49885,s=12471,d=15884,c=AUCT_CLAS_WEAPON},  -- Resplendent Orb
	[15989]={b=49995,s=12498,d=28511,c=AUCT_CLAS_WEAPON},  -- Eternal Rod
	[15990]={b=34252,s=6850,d=27055,c=AUCT_CLAS_WEAPON},  -- Enduring Shield
	[15991]={b=146151,s=29230,d=18775,c=AUCT_CLAS_WEAPON},  -- Warleader's Shield
	[15992]={b=1000,s=250,d=6379,x=20},  -- Dense Blasting Powder
	[15993]={b=6000,s=1500,d=25482,x=10},  -- Thorium Grenade
	[15994]={b=10000,s=2500,d=26611,x=10},  -- Thorium Widget
	[15995]={b=98697,s=19739,d=26616,c=AUCT_CLAS_WEAPON},  -- Thorium Rifle
	[15996]={b=10000,s=2500,d=26612},  -- Lifelike Mechanical Toad
	[15997]={b=4000,s=10,d=26613,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Thorium Shells
	[15998]={b=0,s=0,d=3029,c=AUCT_CLAS_WRITTEN},  -- Lewis' Note
	[15999]={b=45014,s=9002,d=26614,c=AUCT_CLAS_ARMOR},  -- Spellpower Goggles Xtreme Plus
	[16000]={b=15000,s=3750,d=19481,x=10},  -- Thorium Tube
	[16001]={b=0,s=0,d=26615},  -- SI:7 Insignia (Fredo)
	[16002]={b=0,s=0,d=26615},  -- SI:7 Insignia (Turyen)
	[16003]={b=0,s=0,d=26615},  -- SI:7 Insignia (Rutger)
	[16004]={b=145762,s=29152,d=26737,c=AUCT_CLAS_WEAPON},  -- Dark Iron Rifle
	[16005]={b=5000,s=1250,d=7626,x=10},  -- Dark Iron Bomb
	[16006]={b=40000,s=10000,d=26618,x=10},  -- Delicate Arcanite Converter
	[16007]={b=203125,s=40625,d=24721,c=AUCT_CLAS_WEAPON},  -- Flawless Arcanite Rifle
	[16008]={b=58696,s=11739,d=26621,c=AUCT_CLAS_ARMOR},  -- Master Engineer's Goggles
	[16009]={b=23720,s=5930,d=6497,c=AUCT_CLAS_ARMOR},  -- Voice Amplification Modulator
	[16022]={b=160000,s=40000,d=21632,c=AUCT_CLAS_ARMOR},  -- Arcanite Mechanical Dragonling
	[16023]={b=40000,s=10000,d=26631,x=10},  -- Masterwork Target Dummy
	[16039]={b=267990,s=53598,d=26674,c=AUCT_CLAS_WEAPON},  -- Ta'Kierthan Songblade
	[16040]={b=16000,s=4000,d=27453,x=10},  -- Arcane Bomb
	[16041]={b=12000,s=3000,d=1102},  -- Schematic: Thorium Grenade
	[16042]={b=12000,s=3000,d=1102},  -- Schematic: Thorium Widget
	[16043]={b=12000,s=3000,d=15274},  -- Schematic: Thorium Rifle
	[16044]={b=16000,s=4000,d=15274},  -- Schematic: Lifelike Mechanical Toad
	[16045]={b=16000,s=4000,d=15274},  -- Schematic: Spellpower Goggles Xtreme Plus
	[16046]={b=16000,s=4000,d=1301},  -- Schematic: Masterwork Target Dummy
	[16047]={b=16000,s=4000,d=1301},  -- Schematic: Thorium Tube
	[16048]={b=16000,s=4000,d=15274},  -- Schematic: Dark Iron Rifle
	[16049]={b=20000,s=5000,d=15274},  -- Schematic: Dark Iron Bomb
	[16050]={b=20000,s=5000,d=1301},  -- Schematic: Delicate Arcanite Converter
	[16051]={b=20000,s=5000,d=15274},  -- Schematic: Thorium Shells
	[16052]={b=20000,s=5000,d=15274},  -- Schematic: Voice Amplification Modulator
	[16053]={b=20000,s=5000,d=15274},  -- Schematic: Master Engineer's Goggles
	[16054]={b=24000,s=6000,d=15274},  -- Schematic: Arcanite Dragonling
	[16055]={b=24000,s=6000,d=15274},  -- Schematic: Arcane Bomb
	[16056]={b=24000,s=6000,d=15274},  -- Schematic: Flawless Arcanite Rifle
	[16058]={b=40625,s=10156,d=26001,c=AUCT_CLAS_ARMOR},  -- Fordring's Seal
	[16059]={b=400,s=100,d=26683,c=AUCT_CLAS_ARMOR},  -- Common Brown Shirt
	[16060]={b=400,s=100,d=10834,c=AUCT_CLAS_ARMOR},  -- Common White Shirt
	[16072]={b=10000,s=2500,d=1155},  -- Expert Cookbook
	[16083]={b=10000,s=2500,d=1155},  -- Expert Fishing - The Bass and You
	[16084]={b=10000,s=2500,d=1155},  -- Expert First Aid - Under Wraps
	[16110]={b=12000,s=3000,d=1301,c=AUCT_CLAS_FOOD},  -- Recipe: Monster Omelet
	[16111]={b=12000,s=3000,d=1301},  -- Recipe: Spiced Chili Crab
	[16112]={b=2200,s=550,d=8117},  -- Manual: Heavy Silk Bandage
	[16113]={b=5000,s=1250,d=8117},  -- Manual: Mageweave Bandage
	[16114]={b=0,s=0,d=7867},  -- Foreman's Blackjack
	[16115]={b=0,s=0,d=8928},  -- Osric's Crate
	[16166]={b=25,s=1,d=26731,q=20,x=20},  -- Bean Soup
	[16167]={b=125,s=6,d=26732,q=20,x=20},  -- Versicolor Treat
	[16168]={b=2000,s=100,d=26735,q=20,x=20},  -- Heaven Peach
	[16169]={b=1000,s=62,d=26736,q=20,x=20},  -- Wild Ricecake
	[16170]={b=500,s=25,d=26734,q=20,x=20},  -- Steamed Mandu
	[16171]={b=4000,s=200,d=26733,q=20,x=20},  -- Shinsollo
	[16189]={b=0,s=0,d=3018,c=AUCT_CLAS_WRITTEN},  -- Maggran's Reserve Letter
	[16190]={b=0,s=0,d=4045},  -- Bloodfury Ripper's Remains
	[16192]={b=0,s=0,d=7886},  -- Besseleth's Fang
	[16202]={b=40000,s=0,d=26771,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Lesser Eternal Essence
	[16203]={b=120000,s=0,d=26772,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Greater Eternal Essence
	[16204]={b=12000,s=0,d=26773,q=10,x=10,u=AUCT_TYPE_ENCHANT},  -- Illusion Dust
	[16205]={b=0,s=0,d=26774,q=10,x=10},  -- Gaea Seed
	[16206]={b=4000,s=1000,d=26776,u=AUCT_TYPE_ENCHANT},  -- Arcanite Rod
	[16207]={b=5000,s=1250,d=26775,u=AUCT_TYPE_ENCHANT},  -- Runed Arcanite Rod
	[16208]={b=0,s=0,d=7287},  -- Enchanted Gaea Seeds
	[16209]={b=0,s=0,d=3029,c=AUCT_CLAS_WRITTEN},  -- Podrig's Order
	[16210]={b=0,s=0,d=11448},  -- Gordon's Crate
	[16214]={b=12000,s=3000,d=7798},  -- Formula: Enchant Bracer - Greater Intellect
	[16215]={b=12000,s=3000,d=7798},  -- Formula: Enchant Boots - Greater Stamina
	[16216]={b=12000,s=3000,d=7798},  -- Formula: Enchant Cloak - Greater Resistance
	[16217]={b=12000,s=3000,d=7798},  -- Formula: Enchant Shield - Greater Stamina
	[16218]={b=14000,s=3500,d=7798},  -- Formula: Enchant Bracer - Superior Spirit
	[16219]={b=14000,s=3500,d=7798},  -- Formula: Enchant Gloves - Greater Agility
	[16220]={b=16000,s=4000,d=7798},  -- Formula: Enchant Boots - Spirit
	[16221]={b=16000,s=4000,d=7798},  -- Formula: Enchant Chest - Major Health
	[16222]={b=20000,s=5000,d=7798},  -- Formula: Enchant Shield - Superior Spirit
	[16223]={b=20000,s=5000,d=7798},  -- Formula: Enchant Weapon - Icy Chill
	[16224]={b=20000,s=5000,d=7798},  -- Formula: Enchant Cloak - Superior Defense
	[16242]={b=22000,s=5500,d=7798},  -- Formula: Enchant Chest - Major Mana
	[16243]={b=22000,s=5500,d=7798,u=AUCT_TYPE_ENCHANT},  -- Formula: Runed Arcanite Rod
	[16244]={b=24000,s=6000,d=7798},  -- Formula: Enchant Gloves - Greater Strength
	[16245]={b=24000,s=6000,d=7798},  -- Formula: Enchant Boots - Greater Agility
	[16246]={b=24000,s=6000,d=7798},  -- Formula: Enchant Bracer - Superior Strength
	[16247]={b=24000,s=6000,d=7798},  -- Formula: Enchant Weapon - Superior Impact
	[16248]={b=24000,s=6000,d=7798},  -- Formula: Enchant Weapon - Unholy
	[16249]={b=30000,s=7500,d=7798},  -- Formula: Enchant 2H Weapon - Major Intellect
	[16250]={b=30000,s=7500,d=7798},  -- Formula: Enchant Weapon - Superior Striking
	[16251]={b=30000,s=7500,d=7798},  -- Formula: Enchant Bracer - Superior Stamina
	[16252]={b=30000,s=7500,d=7798},  -- Formula: Enchant Weapon - Crusader
	[16254]={b=30000,s=7500,d=7798},  -- Formula: Enchant Weapon - Lifestealing
	[16255]={b=30000,s=7500,d=7798},  -- Formula: Enchant 2H Weapon - Major Spirit
	[16262]={b=0,s=0,d=6349},  -- Nessa's Collection
	[16263]={b=0,s=0,d=3023,c=AUCT_CLAS_WRITTEN},  -- Laird's Response
	[16282]={b=0,s=0,d=7382},  -- Bundle of Hides
	[16283]={b=0,s=0,d=1168},  -- Ahanu's Leather Goods
	[16302]={b=100,s=25,d=1246},  -- Grimoire of Firebolt (Rank 2)
	[16303]={b=0,s=0,d=26924,c=AUCT_CLAS_QUEST},  -- Ursangous's Paw
	[16304]={b=0,s=0,d=26925,c=AUCT_CLAS_QUEST},  -- Shadumbra's Head
	[16305]={b=0,s=0,d=7266,c=AUCT_CLAS_QUEST},  -- Sharptalon's Claw
	[16306]={b=0,s=0,d=2376},  -- Zargh's Meats
	[16307]={b=0,s=0,d=8927,c=AUCT_CLAS_WRITTEN},  -- Gryshka's Letter
	[16309]={b=0,s=0,d=26950,c=AUCT_CLAS_ARMOR},  -- Drakefire Amulet
	[16310]={b=0,s=0,d=3023,c=AUCT_CLAS_WRITTEN},  -- Brock's List
	[16311]={b=0,s=0,d=26976},  -- Honorary Picks
	[16312]={b=0,s=0,d=7119,q=10,x=10},  -- Incendrites
	[16313]={b=0,s=0,d=27056},  -- Felix's Chest
	[16314]={b=0,s=0,d=1236},  -- Felix's Bucket of Bolts
	[16316]={b=1500,s=375,d=1246},  -- Grimoire of Firebolt (Rank 3)
	[16317]={b=5000,s=1250,d=1246},  -- Grimoire of Firebolt (Rank 4)
	[16318]={b=10000,s=2500,d=1246},  -- Grimoire of Firebolt (Rank 5)
	[16319]={b=14000,s=3500,d=1246},  -- Grimoire of Firebolt (Rank 6)
	[16320]={b=24000,s=6000,d=1246},  -- Grimoire of Firebolt (Rank 7)
	[16321]={b=100,s=25,d=1246},  -- Grimoire of Blood Pact (Rank 1)
	[16322]={b=900,s=225,d=1246},  -- Grimoire of Blood Pact (Rank 2)
	[16323]={b=4000,s=1000,d=1246},  -- Grimoire of Blood Pact (Rank 3)
	[16324]={b=10000,s=2500,d=1246},  -- Grimoire of Blood Pact (Rank 4)
	[16325]={b=15000,s=3750,d=1246},  -- Grimoire of Blood Pact (Rank 5)
	[16326]={b=900,s=225,d=1246},  -- Grimoire of Fire Shield (Rank 1)
	[16327]={b=3000,s=750,d=1246},  -- Grimoire of Fire Shield (Rank 2)
	[16328]={b=8000,s=2000,d=1246},  -- Grimoire of Fire Shield (Rank 3)
	[16329]={b=12000,s=3000,d=1246},  -- Grimoire of Fire Shield (Rank 4)
	[16330]={b=20000,s=5000,d=1246},  -- Grimoire of Fire Shield (Rank 5)
	[16331]={b=600,s=150,d=1246},  -- Grimoire of Phase Shift
	[16332]={b=0,s=0,d=27086},  -- Thazz'ril's Pick
	[16333]={b=0,s=0,d=7099},  -- Samuel's Remains
	[16335]={b=40000,s=10000,d=30797,c=AUCT_CLAS_ARMOR},  -- Senior Sergeant's Insignia
	[16341]={b=21425,s=4285,d=27088,c=AUCT_CLAS_ARMOR},  -- Sergeant's Cloak
	[16342]={b=44154,s=8830,d=27087,c=AUCT_CLAS_ARMOR},  -- Sergeant's Cape
	[16345]={b=151892,s=30378,d=27089,c=AUCT_CLAS_WEAPON},  -- High Warlord's Blade
	[16346]={b=2000,s=500,d=1246},  -- Grimoire of Torment (Rank 2)
	[16347]={b=6000,s=1500,d=1246},  -- Grimoire of Torment (Rank 3)
	[16348]={b=11000,s=2750,d=1246},  -- Grimoire of Torment (Rank 4)
	[16349]={b=15000,s=3750,d=1246},  -- Grimoire of Torment (Rank 5)
	[16350]={b=26000,s=6500,d=1246},  -- Grimoire of Torment (Rank 6)
	[16351]={b=1200,s=300,d=1246},  -- Grimoire of Sacrifice (Rank 1)
	[16352]={b=3000,s=750,d=1246},  -- Grimoire of Sacrifice (Rank 2)
	[16353]={b=7000,s=1750,d=1246},  -- Grimoire of Sacrifice (Rank 3)
	[16354]={b=11000,s=2750,d=1246},  -- Grimoire of Sacrifice (Rank 4)
	[16355]={b=14000,s=3500,d=1246},  -- Grimoire of Sacrifice (Rank 5)
	[16356]={b=22000,s=5500,d=1246},  -- Grimoire of Sacrifice (Rank 6)
	[16357]={b=1500,s=375,d=1246},  -- Grimoire of Consume Shadows (Rank 1)
	[16358]={b=4000,s=1000,d=1246},  -- Grimoire of Consume Shadows (Rank 2)
	[16359]={b=8000,s=2000,d=1246},  -- Grimoire of Consume Shadows (Rank 3)
	[16360]={b=11000,s=2750,d=1246},  -- Grimoire of Consume Shadows (Rank 4)
	[16361]={b=15000,s=3750,d=1246},  -- Grimoire of Consume Shadows (Rank 5)
	[16362]={b=24000,s=6000,d=1246},  -- Grimoire of Consume Shadows (Rank 6)
	[16363]={b=3000,s=750,d=1246},  -- Grimoire of Suffering (Rank 1)
	[16364]={b=9000,s=2250,d=1246},  -- Grimoire of Suffering (Rank 2)
	[16365]={b=14000,s=3500,d=1246},  -- Grimoire of Suffering (Rank 3)
	[16366]={b=26000,s=6500,d=1246},  -- Grimoire of Suffering (Rank 4)
	[16368]={b=5000,s=1250,d=1246},  -- Grimoire of Lash of Pain (Rank 2)
	[16369]={b=42081,s=8416,d=31063,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Silk Boots
	[16371]={b=9000,s=2250,d=1246},  -- Grimoire of Lash of Pain (Rank 3)
	[16372]={b=12000,s=3000,d=1246},  -- Grimoire of Lash of Pain (Rank 4)
	[16373]={b=18000,s=4500,d=1246},  -- Grimoire of Lash of Pain (Rank 5)
	[16374]={b=26000,s=6500,d=1246},  -- Grimoire of Lash of Pain (Rank 6)
	[16375]={b=2500,s=625,d=1246},  -- Grimoire of Soothing Kiss (Rank 1)
	[16376]={b=8000,s=2000,d=1246},  -- Grimoire of Soothing Kiss (Rank 2)
	[16377]={b=13000,s=3250,d=1246},  -- Grimoire of Soothing Kiss (Rank 3)
	[16378]={b=24000,s=6000,d=1246},  -- Grimoire of Soothing Kiss (Rank 4)
	[16379]={b=4000,s=1000,d=1246},  -- Grimoire of Seduction
	[16380]={b=7000,s=1750,d=1246},  -- Grimoire of Lesser Invisibility
	[16381]={b=10000,s=2500,d=1246},  -- Grimoire of Devour Magic (Rank 2)
	[16382]={b=13000,s=3250,d=1246},  -- Grimoire of Devour Magic (Rank 3)
	[16383]={b=20000,s=5000,d=1246},  -- Grimoire of Devour Magic (Rank 4)
	[16384]={b=7000,s=1750,d=1246},  -- Grimoire of Tainted Blood (Rank 1)
	[16385]={b=11000,s=2750,d=1246},  -- Grimoire of Tainted Blood (Rank 2)
	[16386]={b=14000,s=3500,d=1246},  -- Grimoire of Tainted Blood (Rank 3)
	[16387]={b=22000,s=5500,d=1246},  -- Grimoire of Tainted Blood (Rank 4)
	[16388]={b=9000,s=2250,d=1246},  -- Grimoire of Spell Lock (Rank 1)
	[16389]={b=18000,s=4500,d=1246},  -- Grimoire of Spell Lock (Rank 2)
	[16390]={b=11000,s=2750,d=1246},  -- Grimoire of Paranoia
	[16391]={b=28261,s=5652,d=31064,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Silk Gloves
	[16392]={b=53190,s=10638,d=31068,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Leather Boots
	[16393]={b=53384,s=10676,d=31070,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Dragonhide Footwraps
	[16396]={b=36942,s=7388,d=31075,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Leather Gauntlets
	[16397]={b=37072,s=7414,d=31071,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Dragonhide Gloves
	[16401]={b=67983,s=13596,d=31244,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Chain Boots
	[16403]={b=41118,s=8223,d=31245,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Chain Gauntlets
	[16405]={b=41433,s=8286,d=26752,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Plate Boots
	[16406]={b=27728,s=5545,d=31086,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Plate Gauntlets
	[16408]={b=0,s=0,d=27227,c=AUCT_CLAS_QUEST},  -- Befouled Water Globe
	[16409]={b=42068,s=8413,d=31082,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Lamellar Sabatons
	[16410]={b=28152,s=5630,d=30321,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Lamellar Gauntlets
	[16413]={b=58463,s=11692,d=31057,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Silk Raiment
	[16414]={b=58676,s=11735,d=27230,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Silk Leggings
	[16415]={b=44167,s=8833,d=27231,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Silk Spaulders
	[16416]={b=44322,s=8864,d=27232,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Crown
	[16417]={b=74137,s=14827,d=31072,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Leather Armor
	[16418]={b=55802,s=11160,d=31077,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Leather Veil
	[16419]={b=74670,s=14934,d=31073,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Leather Legguards
	[16420]={b=56197,s=11239,d=31076,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Leather Spaulders
	[16421]={b=75195,s=15039,d=31074,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Dragonhide Tunic
	[16422]={b=75461,s=15092,d=27235,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Dragonhide Leggings
	[16423]={b=51392,s=10278,d=27236,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Dragonhide Epaulets
	[16424]={b=51586,s=10317,d=27234,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Dragonhide Shroud
	[16425]={b=82858,s=16571,d=31241,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Chain Hauberk
	[16426]={b=83178,s=16635,d=31242,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Chain Leggings
	[16427]={b=64619,s=12923,d=31247,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Chain Pauldrons
	[16428]={b=64573,s=12914,d=31246,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Chain Helmet
	[16429]={b=43208,s=8641,d=28934,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Plate Helm
	[16430]={b=57824,s=11564,d=31083,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Plate Chestguard
	[16431]={b=58031,s=11606,d=26659,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Plate Leggings
	[16432]={b=43683,s=8736,d=26662,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Plate Pauldrons
	[16433]={b=58457,s=11691,d=30315,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Lamellar Breastplate
	[16434]={b=44003,s=8800,d=30316,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Lamellar Headguard
	[16435]={b=58878,s=11775,d=31084,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Lamellar Leggings
	[16436]={b=44318,s=8863,d=31085,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Lamellar Shoulders
	[16437]={b=65383,s=13076,d=30337,c=AUCT_CLAS_ARMOR},  -- Marshal's Silk Footwraps
	[16440]={b=44054,s=8810,d=30339,c=AUCT_CLAS_ARMOR},  -- Marshal's Silk Gloves
	[16441]={b=66316,s=13263,d=30341,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Coronet
	[16442]={b=88726,s=17745,d=30342,c=AUCT_CLAS_ARMOR},  -- Marshal's Silk Leggings
	[16443]={b=82809,s=16561,d=30343,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Silk Vestments
	[16444]={b=62342,s=12468,d=30336,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Silk Spaulders
	[16446]={b=78506,s=15701,d=30333,c=AUCT_CLAS_ARMOR},  -- Marshal's Leather Footguards
	[16448]={b=52729,s=10545,d=30334,c=AUCT_CLAS_ARMOR},  -- Marshal's Dragonhide Gauntlets
	[16449]={b=79387,s=15877,d=30328,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Dragonhide Spaulders
	[16450]={b=106231,s=21246,d=30329,c=AUCT_CLAS_ARMOR},  -- Marshal's Dragonhide Legguards
	[16451]={b=79967,s=15993,d=30330,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Dragonhide Helmet
	[16452]={b=107014,s=21402,d=30327,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Dragonhide Breastplate
	[16453]={b=107405,s=21481,d=30327,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Leather Chestpiece
	[16454]={b=53893,s=10778,d=30334,c=AUCT_CLAS_ARMOR},  -- Marshal's Leather Handgrips
	[16455]={b=81133,s=16226,d=30330,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Leather Mask
	[16456]={b=108569,s=21713,d=30329,c=AUCT_CLAS_ARMOR},  -- Marshal's Leather Leggings
	[16457]={b=81712,s=16342,d=30328,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Leather Epaulets
	[16459]={b=76459,s=15291,d=30333,c=AUCT_CLAS_ARMOR},  -- Marshal's Dragonhide Boots
	[16462]={b=93211,s=18642,d=30323,c=AUCT_CLAS_ARMOR},  -- Marshal's Chain Boots
	[16463]={b=62100,s=12420,d=30326,c=AUCT_CLAS_ARMOR},  -- Marshal's Chain Grips
	[16465]={b=93846,s=18769,d=30312,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Chain Helm
	[16466]={b=125598,s=25119,d=30311,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Chain Breastplate
	[16467]={b=126068,s=25213,d=30313,c=AUCT_CLAS_ARMOR},  -- Marshal's Chain Legguards
	[16468]={b=95325,s=19065,d=30314,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Chain Spaulders
	[16471]={b=42644,s=8528,d=30321,c=AUCT_CLAS_ARMOR},  -- Marshal's Lamellar Gloves
	[16472]={b=64195,s=12839,d=30319,c=AUCT_CLAS_ARMOR},  -- Marshal's Lamellar Boots
	[16473]={b=85907,s=17181,d=30315,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Lamellar Chestplate
	[16474]={b=64665,s=12933,d=30316,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Lamellar Faceguard
	[16475]={b=88777,s=17755,d=30317,c=AUCT_CLAS_ARMOR},  -- Marshal's Lamellar Legplates
	[16476]={b=60456,s=12091,d=30318,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Lamellar Pauldrons
	[16477]={b=80921,s=16184,d=30315,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Plate Armor
	[16478]={b=60926,s=12185,d=30316,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Plate Helm
	[16479]={b=81548,s=16309,d=30317,c=AUCT_CLAS_ARMOR},  -- Marshal's Plate Legguards
	[16480]={b=61389,s=12277,d=30318,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Plate Shoulderguards
	[16483]={b=62094,s=12418,d=30319,c=AUCT_CLAS_ARMOR},  -- Marshal's Plate Boots
	[16484]={b=41548,s=8309,d=30321,c=AUCT_CLAS_ARMOR},  -- Marshal's Plate Gauntlets
	[16485]={b=42556,s=8511,d=31097,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Silk Footwraps
	[16486]={b=28477,s=5695,d=27255,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Silk Cuffs
	[16487]={b=28584,s=5716,d=31098,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Silk Gloves
	[16489]={b=43191,s=8638,d=31099,c=AUCT_CLAS_ARMOR},  -- Champion's Silk Hood
	[16490]={b=57801,s=11560,d=26144,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Silk Pants
	[16491]={b=59534,s=11906,d=31102,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Silk Robes
	[16492]={b=44810,s=8962,d=31100,c=AUCT_CLAS_ARMOR},  -- Champion's Silk Shoulderpads
	[16494]={b=56412,s=11282,d=27263,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Dragonhide Boots
	[16496]={b=34268,s=6853,d=27265,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Dragonhide Gauntlets
	[16497]={b=34402,s=6880,d=30801,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Leather Armguards
	[16498]={b=51802,s=10360,d=31035,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Leather Treads
	[16499]={b=34664,s=6932,d=31036,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Leather Vices
	[16501]={b=52396,s=10479,d=28935,c=AUCT_CLAS_ARMOR},  -- Champion's Dragonhide Spaulders
	[16502]={b=70128,s=14025,d=27267,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Dragonhide Trousers
	[16503]={b=52790,s=10558,d=28106,c=AUCT_CLAS_ARMOR},  -- Champion's Dragonhide Helm
	[16504]={b=70653,s=14130,d=31037,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Dragonhide Breastplate
	[16505]={b=70920,s=14184,d=31039,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Leather Hauberk
	[16506]={b=53384,s=10676,d=30358,c=AUCT_CLAS_ARMOR},  -- Champion's Leather Headguard
	[16507]={b=55014,s=11002,d=31038,c=AUCT_CLAS_ARMOR},  -- Champion's Leather Mantle
	[16508]={b=73619,s=14723,d=31040,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Leather Leggings
	[16509]={b=44331,s=8866,d=31050,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Plate Boots
	[16510]={b=29657,s=5931,d=31051,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Plate Gloves
	[16513]={b=59955,s=11991,d=27274,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Plate Armor
	[16514]={b=45121,s=9024,d=30071,c=AUCT_CLAS_ARMOR},  -- Champion's Plate Headguard
	[16515]={b=60375,s=12075,d=31052,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Plate Legguards
	[16516]={b=41118,s=8223,d=31049,c=AUCT_CLAS_ARMOR},  -- Champion's Plate Pauldrons
	[16518]={b=62426,s=12485,d=31183,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Mail Walkers
	[16519]={b=41593,s=8318,d=27279,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Mail Grips
	[16521]={b=62862,s=12572,d=30072,c=AUCT_CLAS_ARMOR},  -- Champion's Mail Helm
	[16522]={b=84136,s=16827,d=31185,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Mail Chestpiece
	[16523]={b=86745,s=17349,d=31186,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Mail Legguards
	[16524]={b=65588,s=13117,d=30382,c=AUCT_CLAS_ARMOR},  -- Champion's Mail Shoulders
	[16525]={b=87375,s=17475,d=31048,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Chain Breastplate
	[16526]={b=65771,s=13154,d=31184,c=AUCT_CLAS_ARMOR},  -- Champion's Chain Headguard
	[16527]={b=88015,s=17603,d=30367,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Chain Leggings
	[16528]={b=66545,s=13309,d=31047,c=AUCT_CLAS_ARMOR},  -- Champion's Chain Pauldrons
	[16530]={b=44482,s=8896,d=31182,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Chain Gauntlets
	[16531]={b=67261,s=13452,d=31181,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Chain Boots
	[16532]={b=44802,s=8960,d=27277,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Mail Wristguards
	[16533]={b=66087,s=13217,d=30352,c=AUCT_CLAS_ARMOR},  -- Warlord's Silk Cowl
	[16534]={b=88430,s=17686,d=27259,c=AUCT_CLAS_ARMOR},  -- General's Silk Trousers
	[16535]={b=88743,s=17748,d=30351,c=AUCT_CLAS_ARMOR},  -- Warlord's Silk Raiment
	[16536]={b=60437,s=12087,d=30350,c=AUCT_CLAS_ARMOR},  -- Warlord's Silk Amice
	[16539]={b=62818,s=12563,d=30344,c=AUCT_CLAS_ARMOR},  -- General's Silk Boots
	[16540]={b=42031,s=8406,d=30379,c=AUCT_CLAS_ARMOR},  -- General's Silk Handguards
	[16541]={b=84375,s=16875,d=30373,c=AUCT_CLAS_ARMOR},  -- Warlord's Plate Armor
	[16542]={b=63516,s=12703,d=30374,c=AUCT_CLAS_ARMOR},  -- Warlord's Plate Headpiece
	[16543]={b=85001,s=17000,d=30375,c=AUCT_CLAS_ARMOR},  -- General's Plate Leggings
	[16544]={b=63979,s=12795,d=30928,c=AUCT_CLAS_ARMOR},  -- Warlord's Plate Shoulders
	[16545]={b=64214,s=12842,d=30370,c=AUCT_CLAS_ARMOR},  -- General's Plate Boots
	[16548]={b=43275,s=8655,d=30371,c=AUCT_CLAS_ARMOR},  -- General's Plate Gauntlets
	[16549]={b=108580,s=21716,d=30357,c=AUCT_CLAS_ARMOR},  -- Warlord's Dragonhide Hauberk
	[16550]={b=81728,s=16345,d=30358,c=AUCT_CLAS_ARMOR},  -- Warlord's Dragonhide Helmet
	[16551]={b=82022,s=16404,d=30360,c=AUCT_CLAS_ARMOR},  -- Warlord's Dragonhide Epaulets
	[16552]={b=109744,s=21948,d=30359,c=AUCT_CLAS_ARMOR},  -- General's Dragonhide Leggings
	[16554]={b=82895,s=16579,d=30356,c=AUCT_CLAS_ARMOR},  -- General's Dragonhide Boots
	[16555]={b=51560,s=10312,d=30355,c=AUCT_CLAS_ARMOR},  -- General's Dragonhide Gloves
	[16558]={b=78221,s=15644,d=30356,c=AUCT_CLAS_ARMOR},  -- General's Leather Treads
	[16560]={b=52533,s=10506,d=30355,c=AUCT_CLAS_ARMOR},  -- General's Leather Mitts
	[16561]={b=79094,s=15818,d=30358,c=AUCT_CLAS_ARMOR},  -- Warlord's Leather Helm
	[16562]={b=79387,s=15877,d=30360,c=AUCT_CLAS_ARMOR},  -- Warlord's Leather Spaulders
	[16563]={b=106231,s=21246,d=30357,c=AUCT_CLAS_ARMOR},  -- Warlord's Leather Breastplate
	[16564]={b=106622,s=21324,d=30359,c=AUCT_CLAS_ARMOR},  -- General's Leather Legguards
	[16565]={b=128417,s=25683,d=30365,c=AUCT_CLAS_ARMOR},  -- Warlord's Chain Chestpiece
	[16566]={b=96665,s=19333,d=30366,c=AUCT_CLAS_ARMOR},  -- Warlord's Chain Helmet
	[16567]={b=129343,s=25868,d=30367,c=AUCT_CLAS_ARMOR},  -- General's Chain Legguards
	[16568]={b=97793,s=19558,d=30368,c=AUCT_CLAS_ARMOR},  -- Warlord's Chain Shoulders
	[16569]={b=98146,s=19629,d=30361,c=AUCT_CLAS_ARMOR},  -- General's Chain Boots
	[16571]={b=60932,s=12186,d=30363,c=AUCT_CLAS_ARMOR},  -- General's Chain Gloves
	[16573]={b=92513,s=18502,d=30361,c=AUCT_CLAS_ARMOR},  -- General's Mail Boots
	[16574]={b=61631,s=12326,d=30363,c=AUCT_CLAS_ARMOR},  -- General's Mail Gauntlets
	[16577]={b=124671,s=24934,d=30365,c=AUCT_CLAS_ARMOR},  -- Warlord's Mail Armor
	[16578]={b=93846,s=18769,d=30366,c=AUCT_CLAS_ARMOR},  -- Warlord's Mail Helm
	[16579]={b=125598,s=25119,d=30367,c=AUCT_CLAS_ARMOR},  -- General's Mail Leggings
	[16580]={b=94971,s=18994,d=30368,c=AUCT_CLAS_ARMOR},  -- Warlord's Mail Spaulders
	[16581]={b=0,s=0,d=6688,q=20,x=20},  -- Resonite Crystal
	[16583]={b=10000,s=2500,d=27454,x=5},  -- Demonic Figurine
	[16602]={b=0,s=0,d=27471,q=20,x=20},  -- Troll Charm
	[16603]={b=0,s=0,d=6689},  -- Enchanted Resonite Crystal
	[16604]={b=86,s=17,d=27472,c=AUCT_CLAS_ARMOR},  -- Moon Robes of Elune
	[16605]={b=87,s=17,d=27473,c=AUCT_CLAS_ARMOR},  -- Friar's Robes of the Light
	[16606]={b=87,s=17,d=27477,c=AUCT_CLAS_ARMOR},  -- Juju Hex Robes
	[16607]={b=80,s=16,d=27479,c=AUCT_CLAS_ARMOR},  -- Acolyte's Sacrificial Robes
	[16608]={b=969,s=193,d=16947,c=AUCT_CLAS_ARMOR},  -- Aquarius Belt
	[16622]={b=136535,s=27307,d=27492,c=AUCT_CLAS_WEAPON},  -- Thornflinger
	[16623]={b=31135,s=7783,d=9857,c=AUCT_CLAS_ARMOR},  -- Opaline Medallion
	[16642]={b=0,s=0,d=7596},  -- Shredder Operating Manual - Chapter 1
	[16643]={b=0,s=0,d=7596},  -- Shredder Operating Manual - Chapter 2
	[16644]={b=0,s=0,d=7596},  -- Shredder Operating Manual - Chapter 3
	[16645]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 1
	[16646]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 2
	[16647]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 3
	[16648]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 4
	[16649]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 5
	[16650]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 6
	[16651]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 7
	[16652]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 8
	[16653]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 9
	[16654]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 10
	[16655]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 11
	[16656]={b=250,s=62,d=7629},  -- Shredder Operating Manual - Page 12
	[16658]={b=8246,s=1649,d=27514,c=AUCT_CLAS_ARMOR},  -- Wildhunter Cloak
	[16659]={b=4282,s=856,d=28270,c=AUCT_CLAS_ARMOR},  -- Deftkin Belt
	[16660]={b=11004,s=2200,d=27517,c=AUCT_CLAS_WEAPON},  -- Driftmire Shield
	[16661]={b=4828,s=965,d=27521,c=AUCT_CLAS_ARMOR},  -- Soft Willow Cape
	[16662]={b=0,s=0,d=22652},  -- Fragment of the Dragon's Eye
	[16663]={b=0,s=0,d=16325},  -- Blood of the Black Dragon Champion
	[16665]={b=0,s=0,d=1317},  -- Tome of Tranquilizing Shot
	[16666]={b=179813,s=35962,d=31375,c=AUCT_CLAS_ARMOR},  -- Vest of Elements
	[16667]={b=128894,s=25778,d=30421,c=AUCT_CLAS_ARMOR},  -- Coif of Elements
	[16668]={b=152707,s=30541,d=31378,c=AUCT_CLAS_ARMOR},  -- Kilt of Elements
	[16669]={b=109977,s=21995,d=30925,c=AUCT_CLAS_ARMOR},  -- Pauldrons of Elements
	[16670]={b=105136,s=21027,d=31377,c=AUCT_CLAS_ARMOR},  -- Boots of Elements
	[16671]={b=62932,s=12586,d=31372,c=AUCT_CLAS_ARMOR},  -- Bindings of Elements
	[16672]={b=70299,s=14059,d=31373,c=AUCT_CLAS_ARMOR},  -- Gauntlets of Elements
	[16673]={b=67202,s=13440,d=31376,c=AUCT_CLAS_ARMOR},  -- Cord of Elements
	[16674]={b=172176,s=34435,d=29211,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Tunic
	[16675]={b=107105,s=21421,d=29214,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Boots
	[16676]={b=71344,s=14268,d=29213,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Gloves
	[16677]={b=124341,s=24868,d=29385,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Cap
	[16678]={b=158473,s=31694,d=28447,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Pants
	[16679]={b=114113,s=22822,d=29263,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Mantle
	[16680]={b=68941,s=13788,d=29215,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Belt
	[16681]={b=65275,s=13055,d=29218,c=AUCT_CLAS_ARMOR},  -- Beaststalker's Bindings
	[16682]={b=72914,s=14582,d=29594,c=AUCT_CLAS_ARMOR},  -- Magister's Boots
	[16683]={b=43827,s=8765,d=29597,c=AUCT_CLAS_ARMOR},  -- Magister's Bindings
	[16684]={b=45468,s=9093,d=29593,c=AUCT_CLAS_ARMOR},  -- Magister's Gloves
	[16685]={b=43470,s=8694,d=29596,c=AUCT_CLAS_ARMOR},  -- Magister's Belt
	[16686]={b=79562,s=15912,d=31087,c=AUCT_CLAS_ARMOR},  -- Magister's Crown
	[16687]={b=101407,s=20281,d=29273,c=AUCT_CLAS_ARMOR},  -- Magister's Leggings
	[16688]={b=112228,s=22445,d=29591,c=AUCT_CLAS_ARMOR},  -- Magister's Robes
	[16689]={b=72986,s=14597,d=30211,c=AUCT_CLAS_ARMOR},  -- Magister's Mantle
	[16690]={b=113080,s=22616,d=30422,c=AUCT_CLAS_ARMOR},  -- Devout Robe
	[16691]={b=70029,s=14005,d=30430,c=AUCT_CLAS_ARMOR},  -- Devout Sandals
	[16692]={b=46861,s=9372,d=30427,c=AUCT_CLAS_ARMOR},  -- Devout Gloves
	[16693]={b=81676,s=16335,d=31104,c=AUCT_CLAS_ARMOR},  -- Devout Crown
	[16694]={b=104102,s=20820,d=30424,c=AUCT_CLAS_ARMOR},  -- Devout Skirt
	[16695]={b=74627,s=14925,d=31103,c=AUCT_CLAS_ARMOR},  -- Devout Mantle
	[16696]={b=45292,s=9058,d=30425,c=AUCT_CLAS_ARMOR},  -- Devout Belt
	[16697]={b=42886,s=8577,d=30426,c=AUCT_CLAS_ARMOR},  -- Devout Bracers
	[16698]={b=83182,s=16636,d=31263,c=AUCT_CLAS_ARMOR},  -- Dreadmist Mask
	[16699]={b=106014,s=21202,d=29797,c=AUCT_CLAS_ARMOR},  -- Dreadmist Leggings
	[16700]={b=120358,s=24071,d=29792,c=AUCT_CLAS_ARMOR},  -- Dreadmist Robe
	[16701]={b=78254,s=15650,d=29798,c=AUCT_CLAS_ARMOR},  -- Dreadmist Mantle
	[16702]={b=42964,s=8592,d=29793,c=AUCT_CLAS_ARMOR},  -- Dreadmist Belt
	[16703]={b=40690,s=8138,d=29795,c=AUCT_CLAS_ARMOR},  -- Dreadmist Bracers
	[16704]={b=68196,s=13639,d=29799,c=AUCT_CLAS_ARMOR},  -- Dreadmist Sandals
	[16705]={b=45639,s=9127,d=29800,c=AUCT_CLAS_ARMOR},  -- Dreadmist Wraps
	[16706]={b=139205,s=27841,d=29974,c=AUCT_CLAS_ARMOR},  -- Wildheart Vest
	[16707]={b=99813,s=19962,d=28180,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Cap
	[16708]={b=90878,s=18175,d=28179,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Spaulders
	[16709]={b=127712,s=25542,d=28161,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Pants
	[16710]={b=52230,s=10446,d=24190,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Bracers
	[16711]={b=87528,s=17505,d=28162,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Boots
	[16712]={b=58570,s=11714,d=28166,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Gloves
	[16713]={b=55984,s=11196,d=28177,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Belt
	[16714]={b=53012,s=10602,d=29977,c=AUCT_CLAS_ARMOR},  -- Wildheart Bracers
	[16715]={b=88833,s=17766,d=29981,c=AUCT_CLAS_ARMOR},  -- Wildheart Boots
	[16716]={b=58104,s=11620,d=29976,c=AUCT_CLAS_ARMOR},  -- Wildheart Belt
	[16717]={b=61223,s=12244,d=29979,c=AUCT_CLAS_ARMOR},  -- Wildheart Gloves
	[16718]={b=96772,s=19354,d=30412,c=AUCT_CLAS_ARMOR},  -- Wildheart Spaulders
	[16719]={b=135964,s=27192,d=29975,c=AUCT_CLAS_ARMOR},  -- Wildheart Kilt
	[16720]={b=107453,s=21490,d=31228,c=AUCT_CLAS_ARMOR},  -- Wildheart Cowl
	[16721]={b=150952,s=30190,d=28160,c=AUCT_CLAS_ARMOR},  -- Shadowcraft Tunic
	[16722]={b=40528,s=8105,d=29968,c=AUCT_CLAS_ARMOR},  -- Lightforge Bracers
	[16723]={b=43127,s=8625,d=29966,c=AUCT_CLAS_ARMOR},  -- Lightforge Belt
	[16724]={b=45459,s=9091,d=29970,c=AUCT_CLAS_ARMOR},  -- Lightforge Gauntlets
	[16725]={b=68444,s=13688,d=29967,c=AUCT_CLAS_ARMOR},  -- Lightforge Boots
	[16726]={b=111353,s=22270,d=29969,c=AUCT_CLAS_ARMOR},  -- Lightforge Breastplate
	[16727]={b=79842,s=15968,d=31207,c=AUCT_CLAS_ARMOR},  -- Lightforge Helm
	[16728]={b=101773,s=20354,d=29972,c=AUCT_CLAS_ARMOR},  -- Lightforge Legplates
	[16729]={b=72964,s=14592,d=29971,c=AUCT_CLAS_ARMOR},  -- Lightforge Spaulders
	[16730]={b=113045,s=22609,d=29958,c=AUCT_CLAS_ARMOR},  -- Breastplate of Valor
	[16731]={b=81051,s=16210,d=31284,c=AUCT_CLAS_ARMOR},  -- Helm of Valor
	[16732]={b=106066,s=21213,d=29963,c=AUCT_CLAS_ARMOR},  -- Legplates of Valor
	[16733]={b=76038,s=15207,d=29964,c=AUCT_CLAS_ARMOR},  -- Spaulders of Valor
	[16734]={b=72680,s=14536,d=29960,c=AUCT_CLAS_ARMOR},  -- Boots of Valor
	[16735]={b=43690,s=8738,d=29961,c=AUCT_CLAS_ARMOR},  -- Bracers of Valor
	[16736]={b=46475,s=9295,d=29959,c=AUCT_CLAS_ARMOR},  -- Belt of Valor
	[16737]={b=48974,s=9794,d=29962,c=AUCT_CLAS_ARMOR},  -- Gauntlets of Valor
	[16738]={b=19468,s=3893,d=27910,c=AUCT_CLAS_ARMOR},  -- Witherseed Gloves
	[16739]={b=36502,s=7300,d=27911,c=AUCT_CLAS_ARMOR},  -- Rugwood Mantle
	[16740]={b=4712,s=942,d=27912,c=AUCT_CLAS_ARMOR},  -- Shredder Operating Gloves
	[16741]={b=5890,s=1178,d=27913,c=AUCT_CLAS_ARMOR},  -- Oilrag Handwraps
	[16742]={b=0,s=0,d=27953},  -- Warsong Saw Blades
	[16743]={b=0,s=0,d=10301,q=20,x=20},  -- Logging Rope
	[16744]={b=0,s=0,d=15773,q=20,x=20,c=AUCT_CLAS_POTION},  -- Warsong Oil
	[16745]={b=0,s=0,d=11449},  -- Warsong Axe Shipment
	[16746]={b=0,s=0,d=15274,q=20,x=20},  -- Warsong Report
	[16747]={b=110,s=27,d=7842,x=20},  -- Broken Lock
	[16748]={b=60,s=15,d=7418,x=20},  -- Padded Lining
	[16762]={b=0,s=0,d=24037},  -- Fathom Core
	[16763]={b=0,s=0,d=3023},  -- Warsong Runner Update
	[16764]={b=0,s=0,d=3023},  -- Warsong Scout Update
	[16765]={b=0,s=0,d=3023},  -- Warsong Outrider Update
	[16766]={b=2000,s=100,d=24733,q=20,x=20,c=AUCT_CLAS_FOOD},  -- Undermine Clam Chowder
	[16767]={b=3000,s=750,d=1102,c=AUCT_CLAS_FOOD},  -- Recipe: Undermine Clam Chowder
	[16768]={b=150000,s=37500,d=28187,c=AUCT_CLAS_WEAPON},  -- Furbolg Medicine Pouch
	[16769]={b=133081,s=26616,d=28194,c=AUCT_CLAS_WEAPON},  -- Furbolg Medicine Totem
	[16782]={b=0,s=0,d=27227,c=AUCT_CLAS_QUEST},  -- Strange Water Globe
	[16783]={b=0,s=0,d=1093,q=20,x=20},  -- Bundle of Reports
	[16784]={b=0,s=0,d=6614,q=20,x=20},  -- Sapphire of Aku'Mai
	[16785]={b=0,s=0,d=18010,c=AUCT_CLAS_WRITTEN},  -- Rexxar's Testament
	[16786]={b=0,s=0,d=1504,q=20,x=20},  -- Black Dragonspawn Eye
	[16787]={b=0,s=0,d=28261,c=AUCT_CLAS_ARMOR},  -- Amulet of Draconic Subversion
	[16788]={b=25476,s=5095,d=28407,c=AUCT_CLAS_WEAPON},  -- Captain Rackmore's Wheel
	[16789]={b=28464,s=5692,d=28408,c=AUCT_CLAS_WEAPON},  -- Captain Rackmore's Tiller
	[16790]={b=0,s=0,d=24153,c=AUCT_CLAS_QUEST},  -- Damp Note
	[16791]={b=9561,s=1912,d=26168,c=AUCT_CLAS_ARMOR},  -- Silkstream Cuffs
	[16793]={b=21765,s=4353,d=28454,c=AUCT_CLAS_ARMOR},  -- Arcmetal Shoulders
	[16794]={b=13525,s=2705,d=23729,c=AUCT_CLAS_ARMOR},  -- Gripsteel Wristguards
	[16795]={b=136797,s=27359,d=31227,c=AUCT_CLAS_ARMOR},  -- Arcanist Crown
	[16796]={b=169953,s=33990,d=30582,c=AUCT_CLAS_ARMOR},  -- Arcanist Leggings
	[16797]={b=127958,s=25591,d=30586,c=AUCT_CLAS_ARMOR},  -- Arcanist Mantle
	[16798]={b=171268,s=34253,d=30581,c=AUCT_CLAS_ARMOR},  -- Arcanist Robes
	[16799]={b=85962,s=17192,d=30584,c=AUCT_CLAS_ARMOR},  -- Arcanist Bindings
	[16800]={b=129425,s=25885,d=30587,c=AUCT_CLAS_ARMOR},  -- Arcanist Boots
	[16801]={b=86611,s=17322,d=30585,c=AUCT_CLAS_ARMOR},  -- Arcanist Gloves
	[16802]={b=86940,s=17388,d=30583,c=AUCT_CLAS_ARMOR},  -- Arcanist Belt
	[16803]={b=130904,s=26180,d=29840,c=AUCT_CLAS_ARMOR},  -- Felheart Slippers
	[16804]={b=87589,s=17517,d=29836,c=AUCT_CLAS_ARMOR},  -- Felheart Bracers
	[16805]={b=87918,s=17583,d=29838,c=AUCT_CLAS_ARMOR},  -- Felheart Gloves
	[16806]={b=88246,s=17649,d=29834,c=AUCT_CLAS_ARMOR},  -- Felheart Belt
	[16807]={b=132864,s=26572,d=29841,c=AUCT_CLAS_ARMOR},  -- Felheart Shoulder Pads
	[16808]={b=133344,s=26668,d=29843,c=AUCT_CLAS_ARMOR},  -- Felheart Skullcap
	[16809]={b=178450,s=35690,d=29832,c=AUCT_CLAS_ARMOR},  -- Felheart Robes
	[16810]={b=179107,s=35821,d=29845,c=AUCT_CLAS_ARMOR},  -- Felheart Pants
	[16811]={b=134811,s=26962,d=30622,c=AUCT_CLAS_ARMOR},  -- Boots of Prophecy
	[16812]={b=90203,s=18040,d=30620,c=AUCT_CLAS_ARMOR},  -- Gloves of Prophecy
	[16813]={b=139330,s=27866,d=31352,c=AUCT_CLAS_ARMOR},  -- Circlet of Prophecy
	[16814]={b=186431,s=37286,d=28198,c=AUCT_CLAS_ARMOR},  -- Pants of Prophecy
	[16815]={b=169278,s=33855,d=30616,c=AUCT_CLAS_ARMOR},  -- Robes of Prophecy
	[16816]={b=127452,s=25490,d=30623,c=AUCT_CLAS_ARMOR},  -- Mantle of Prophecy
	[16817]={b=85296,s=17059,d=30621,c=AUCT_CLAS_ARMOR},  -- Girdle of Prophecy
	[16818]={b=139475,s=27895,d=29870,c=AUCT_CLAS_ARMOR},  -- Netherwind Belt
	[16819]={b=85945,s=17189,d=30617,c=AUCT_CLAS_ARMOR},  -- Vambraces of Prophecy
	[16820]={b=215686,s=43137,d=29761,c=AUCT_CLAS_ARMOR},  -- Nightslayer Chestpiece
	[16821]={b=162380,s=32476,d=29937,c=AUCT_CLAS_ARMOR},  -- Nightslayer Cover
	[16822]={b=217329,s=43465,d=18969,c=AUCT_CLAS_ARMOR},  -- Nightslayer Pants
	[16823]={b=163597,s=32719,d=29768,c=AUCT_CLAS_ARMOR},  -- Nightslayer Shoulder Pads
	[16824]={b=164214,s=32842,d=6720,c=AUCT_CLAS_ARMOR},  -- Nightslayer Boots
	[16825]={b=109887,s=21977,d=29763,c=AUCT_CLAS_ARMOR},  -- Nightslayer Bracelets
	[16826]={b=110286,s=22057,d=29766,c=AUCT_CLAS_ARMOR},  -- Nightslayer Gloves
	[16827]={b=110698,s=22139,d=29762,c=AUCT_CLAS_ARMOR},  -- Nightslayer Belt
	[16828]={b=111109,s=22221,d=4503,c=AUCT_CLAS_ARMOR},  -- Cenarion Belt
	[16829]={b=171697,s=34339,d=28152,c=AUCT_CLAS_ARMOR},  -- Cenarion Boots
	[16830]={b=114864,s=22972,d=17316,c=AUCT_CLAS_ARMOR},  -- Cenarion Bracers
	[16831]={b=115275,s=23055,d=30918,c=AUCT_CLAS_ARMOR},  -- Cenarion Gloves
	[16832]={b=282661,s=56532,d=27664,c=AUCT_CLAS_ARMOR},  -- Bloodfang Spaulders
	[16833]={b=232195,s=46439,d=30922,c=AUCT_CLAS_ARMOR},  -- Cenarion Vestments
	[16834]={b=174746,s=34949,d=29936,c=AUCT_CLAS_ARMOR},  -- Cenarion Helm
	[16835]={b=211575,s=42315,d=17313,c=AUCT_CLAS_ARMOR},  -- Cenarion Leggings
	[16836]={b=159298,s=31859,d=30917,c=AUCT_CLAS_ARMOR},  -- Cenarion Spaulders
	[16837]={b=192750,s=38550,d=29820,c=AUCT_CLAS_ARMOR},  -- Earthfury Boots
	[16838]={b=128411,s=25682,d=29819,c=AUCT_CLAS_ARMOR},  -- Earthfury Belt
	[16839]={b=128905,s=25781,d=29822,c=AUCT_CLAS_ARMOR},  -- Earthfury Gauntlets
	[16840]={b=129398,s=25879,d=29821,c=AUCT_CLAS_ARMOR},  -- Earthfury Bracers
	[16841]={b=259783,s=51956,d=29818,c=AUCT_CLAS_ARMOR},  -- Earthfury Breastplate
	[16842]={b=195557,s=39111,d=29825,c=AUCT_CLAS_ARMOR},  -- Earthfury Helmet
	[16843]={b=261729,s=52345,d=29823,c=AUCT_CLAS_ARMOR},  -- Earthfury Legguards
	[16844]={b=197912,s=39582,d=29826,c=AUCT_CLAS_ARMOR},  -- Earthfury Epaulets
	[16845]={b=270742,s=54148,d=29828,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Breastplate
	[16846]={b=203796,s=40759,d=29893,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Helmet
	[16847]={b=272715,s=54543,d=4912,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Leggings
	[16848]={b=206187,s=41237,d=29835,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Epaulets
	[16849]={b=206911,s=41382,d=29830,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Boots
	[16850]={b=137824,s=27564,d=29831,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Bracers
	[16851]={b=138317,s=27663,d=29829,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Belt
	[16852]={b=138810,s=27762,d=29833,c=AUCT_CLAS_ARMOR},  -- Giantstalker's Gloves
	[16853]={b=185720,s=37144,d=29883,c=AUCT_CLAS_ARMOR},  -- Lawbringer Chestguard
	[16854]={b=139783,s=27956,d=29889,c=AUCT_CLAS_ARMOR},  -- Lawbringer Helm
	[16855]={b=169242,s=33848,d=25343,c=AUCT_CLAS_ARMOR},  -- Lawbringer Legplates
	[16856]={b=127425,s=25485,d=29891,c=AUCT_CLAS_ARMOR},  -- Lawbringer Spaulders
	[16857]={b=85269,s=17053,d=29887,c=AUCT_CLAS_ARMOR},  -- Lawbringer Bracers
	[16858]={b=85598,s=17119,d=29884,c=AUCT_CLAS_ARMOR},  -- Lawbringer Belt
	[16859]={b=128891,s=25778,d=29886,c=AUCT_CLAS_ARMOR},  -- Lawbringer Boots
	[16860]={b=86247,s=17249,d=29888,c=AUCT_CLAS_ARMOR},  -- Lawbringer Gauntlets
	[16861]={b=88931,s=17786,d=29847,c=AUCT_CLAS_ARMOR},  -- Bracers of Might
	[16862]={b=133891,s=26778,d=29850,c=AUCT_CLAS_ARMOR},  -- Sabatons of Might
	[16863]={b=89589,s=17917,d=31022,c=AUCT_CLAS_ARMOR},  -- Gauntlets of Might
	[16864]={b=89908,s=17981,d=29846,c=AUCT_CLAS_ARMOR},  -- Belt of Might
	[16865]={b=180476,s=36095,d=29844,c=AUCT_CLAS_ARMOR},  -- Breastplate of Might
	[16866]={b=135851,s=27170,d=31260,c=AUCT_CLAS_ARMOR},  -- Helm of Might
	[16867]={b=181792,s=36358,d=29849,c=AUCT_CLAS_ARMOR},  -- Legplates of Might
	[16868]={b=136824,s=27364,d=31024,c=AUCT_CLAS_ARMOR},  -- Pauldrons of Might
	[16869]={b=0,s=0,d=28497},  -- The Skull of Scryer
	[16870]={b=0,s=0,d=28497},  -- The Skull of Somnus
	[16871]={b=0,s=0,d=28497},  -- The Skull of Chronalis
	[16872]={b=0,s=0,d=28497},  -- The Skull of Axtroz
	[16873]={b=11271,s=2254,d=28522,c=AUCT_CLAS_ARMOR},  -- Braidfur Gloves
	[16882]={b=0,s=0,d=15692},  -- Battered Junkbox
	[16883]={b=0,s=0,d=15692},  -- Worn Junkbox
	[16884]={b=0,s=0,d=15590},  -- Sturdy Junkbox
	[16885]={b=0,s=0,d=15590},  -- Heavy Junkbox
	[16886]={b=27462,s=5492,d=28586,c=AUCT_CLAS_WEAPON},  -- Outlaw Sabre
	[16887]={b=7954,s=1988,d=28588,c=AUCT_CLAS_WEAPON},  -- Witch's Finger
	[16888]={b=0,s=0,d=26584},  -- Dull Drakefire Amulet
	[16889]={b=15467,s=3093,d=28592,c=AUCT_CLAS_WEAPON},  -- Polished Walking Staff
	[16890]={b=12416,s=2483,d=28593,c=AUCT_CLAS_WEAPON},  -- Slatemetal Cutlass
	[16891]={b=8485,s=1697,d=28608,c=AUCT_CLAS_WEAPON},  -- Claystone Shortsword
	[16892]={b=0,s=0,d=6009,c=AUCT_CLAS_WARLOCK},  -- Lesser Soulstone
	[16893]={b=0,s=0,d=6009,c=AUCT_CLAS_WARLOCK},  -- Soulstone
	[16894]={b=9967,s=1993,d=28610,c=AUCT_CLAS_WEAPON},  -- Clear Crystal Rod
	[16895]={b=0,s=0,d=6009,c=AUCT_CLAS_WARLOCK},  -- Greater Soulstone
	[16896]={b=0,s=0,d=6009,c=AUCT_CLAS_WARLOCK},  -- Major Soulstone
	[16898]={b=268546,s=53709,d=29772,c=AUCT_CLAS_ARMOR},  -- Stormrage Boots
	[16900]={b=270555,s=54111,d=29775,c=AUCT_CLAS_ARMOR},  -- Stormrage Cover
	[16902]={b=272536,s=54507,d=29778,c=AUCT_CLAS_ARMOR},  -- Stormrage Pauldrons
	[16906]={b=276527,s=55305,d=29748,c=AUCT_CLAS_ARMOR},  -- Bloodfang Boots
	[16907]={b=185021,s=37004,d=29749,c=AUCT_CLAS_ARMOR},  -- Bloodfang Gloves
	[16908]={b=278535,s=55707,d=29750,c=AUCT_CLAS_ARMOR},  -- Bloodfang Hood
	[16909]={b=346046,s=69209,d=25683,c=AUCT_CLAS_ARMOR},  -- Bloodfang Pants
	[16910]={b=173692,s=34738,d=29747,c=AUCT_CLAS_ARMOR},  -- Bloodfang Belt
	[16911]={b=174361,s=34872,d=21753,c=AUCT_CLAS_ARMOR},  -- Bloodfang Bracers
	[16913]={b=140546,s=28109,d=29781,c=AUCT_CLAS_ARMOR},  -- Netherwind Gloves
	[16914]={b=211623,s=42324,d=29873,c=AUCT_CLAS_ARMOR},  -- Netherwind Crown
	[16915]={b=283235,s=56647,d=29782,c=AUCT_CLAS_ARMOR},  -- Netherwind Pants
	[16917]={b=214012,s=42802,d=4924,c=AUCT_CLAS_ARMOR},  -- Netherwind Mantle
	[16919]={b=215619,s=43123,d=29767,c=AUCT_CLAS_ARMOR},  -- Boots of Transcendence
	[16920]={b=144281,s=28856,d=29781,c=AUCT_CLAS_ARMOR},  -- Handguards of Transcendence
	[16921]={b=217204,s=43440,d=29780,c=AUCT_CLAS_ARMOR},  -- Halo of Transcendence
	[16922]={b=290677,s=58135,d=29782,c=AUCT_CLAS_ARMOR},  -- Leggings of Transcendence
	[16925]={b=150767,s=30153,d=29783,c=AUCT_CLAS_ARMOR},  -- Belt of Transcendence
	[16926]={b=151303,s=30260,d=29779,c=AUCT_CLAS_ARMOR},  -- Bindings of Transcendence
	[16928]={b=137868,s=27573,d=29856,c=AUCT_CLAS_ARMOR},  -- Nemesis Gloves
	[16929]={b=207605,s=41521,d=29862,c=AUCT_CLAS_ARMOR},  -- Nemesis Skullcap
	[16932]={b=209994,s=41998,d=29866,c=AUCT_CLAS_ARMOR},  -- Nemesis Spaulders
	[16934]={b=141067,s=28213,d=29854,c=AUCT_CLAS_ARMOR},  -- Nemesis Bracers
	[16936]={b=213186,s=42637,d=29809,c=AUCT_CLAS_ARMOR},  -- Dragonstalker's Belt
	[16937]={b=322412,s=64482,d=29815,c=AUCT_CLAS_ARMOR},  -- Dragonstalker's Spaulders
	[16938]={b=429587,s=85917,d=29814,c=AUCT_CLAS_ARMOR},  -- Dragonstalker's Legguards
	[16939]={b=323363,s=64672,d=29817,c=AUCT_CLAS_ARMOR},  -- Dragonstalker's Helm
	[16940]={b=216379,s=43275,d=29811,c=AUCT_CLAS_ARMOR},  -- Dragonstalker's Gauntlets
	[16941]={b=335892,s=67178,d=29813,c=AUCT_CLAS_ARMOR},  -- Dragonstalker's Greaves
	[16943]={b=224522,s=44904,d=29787,c=AUCT_CLAS_ARMOR},  -- Bracers of Ten Storms
	[16944]={b=225326,s=45065,d=29786,c=AUCT_CLAS_ARMOR},  -- Belt of Ten Storms
	[16947]={b=341572,s=68314,d=29794,c=AUCT_CLAS_ARMOR},  -- Helmet of Ten Storms
	[16949]={b=312759,s=62551,d=29791,c=AUCT_CLAS_ARMOR},  -- Greaves of Ten Storms
	[16951]={b=139446,s=27889,d=29876,c=AUCT_CLAS_ARMOR},  -- Judgement Bindings
	[16952]={b=139981,s=27996,d=29875,c=AUCT_CLAS_ARMOR},  -- Judgement Belt
	[16954]={b=282077,s=56415,d=29878,c=AUCT_CLAS_ARMOR},  -- Judgement Legplates
	[16955]={b=212361,s=42472,d=29881,c=AUCT_CLAS_ARMOR},  -- Judgement Crown
	[16957]={b=219723,s=43944,d=29879,c=AUCT_CLAS_ARMOR},  -- Judgement Sabatons
	[16959]={b=147539,s=29507,d=29859,c=AUCT_CLAS_ARMOR},  -- Bracelets of Wrath
	[16960]={b=148074,s=29614,d=29864,c=AUCT_CLAS_ARMOR},  -- Waistband of Wrath
	[16962]={b=298263,s=59652,d=25226,c=AUCT_CLAS_ARMOR},  -- Legplates of Wrath
	[16963]={b=224501,s=44900,d=29865,c=AUCT_CLAS_ARMOR},  -- Helm of Wrath
	[16964]={b=150203,s=30040,d=29860,c=AUCT_CLAS_ARMOR},  -- Gauntlets of Wrath
	[16967]={b=0,s=0,d=24715,c=AUCT_CLAS_WEAPON},  -- Feralas Ahi
	[16968]={b=0,s=0,d=24702},  -- Sar'theris Striker
	[16969]={b=0,s=0,d=18535},  -- Savage Coast Blue Sailfin
	[16970]={b=0,s=0,d=28622},  -- Misty Reed Mahi Mahi
	[16971]={b=1200,s=300,d=16211,x=20},  -- Clamlette Surprise
	[16972]={b=0,s=0,d=6748},  -- Karang's Banner
	[16973]={b=0,s=0,d=17898},  -- Vial of Dire Water
	[16974]={b=0,s=0,d=28732},  -- Empty Water Vial
	[16975]={b=4067,s=813,d=28746,c=AUCT_CLAS_ARMOR},  -- Warsong Sash
	[16976]={b=0,s=0,d=10365},  -- Murgut's Totem
	[16977]={b=7242,s=1448,d=28749,c=AUCT_CLAS_ARMOR},  -- Warsong Boots
	[16978]={b=5794,s=1158,d=28750,c=AUCT_CLAS_ARMOR},  -- Warsong Gauntlets
	[16979]={b=74509,s=14901,d=28754,c=AUCT_CLAS_ARMOR},  -- Flarecore Gloves
	[16980]={b=106829,s=21365,d=28756,c=AUCT_CLAS_ARMOR},  -- Flarecore Mantle
	[16981]={b=1356,s=271,d=16664,c=AUCT_CLAS_ARMOR},  -- Owlbeard Bracers
	[16982]={b=121985,s=24397,d=28770,c=AUCT_CLAS_ARMOR},  -- Corehound Boots
	[16983]={b=128545,s=25709,d=28856,c=AUCT_CLAS_ARMOR},  -- Molten Helm
	[16984]={b=163269,s=32653,d=28760,c=AUCT_CLAS_ARMOR},  -- Black Dragonscale Boots
	[16985]={b=4238,s=847,d=26026,c=AUCT_CLAS_ARMOR},  -- Windseeker Boots
	[16986]={b=4254,s=850,d=28288,c=AUCT_CLAS_ARMOR},  -- Sandspire Gloves
	[16987]={b=4422,s=884,d=28767,c=AUCT_CLAS_ARMOR},  -- Screecher Belt
	[16988]={b=157303,s=31460,d=28773,c=AUCT_CLAS_ARMOR},  -- Fiery Chain Shoulders
	[16989]={b=93050,s=18610,d=28774,c=AUCT_CLAS_ARMOR},  -- Fiery Chain Girdle
	[16990]={b=4990,s=998,d=28775,c=AUCT_CLAS_ARMOR},  -- Spritekin Cloak
	[16991]={b=0,s=0,d=25147},  -- Triage Bandage
	[16992]={b=154370,s=30874,d=28786,c=AUCT_CLAS_WEAPON},  -- Smokey's Explosive Launcher
	[16993]={b=154945,s=30989,d=28818,c=AUCT_CLAS_WEAPON},  -- Smokey's Fireshooter
	[16994]={b=49420,s=9884,d=28822,c=AUCT_CLAS_ARMOR},  -- Duskwing Gloves
	[16995]={b=74130,s=14826,d=28823,c=AUCT_CLAS_ARMOR},  -- Duskwing Mantle
	[16996]={b=207256,s=41451,d=28827,c=AUCT_CLAS_WEAPON},  -- Gorewood Bow
	[16997]={b=208016,s=41603,d=28828,c=AUCT_CLAS_WEAPON},  -- Stormrager
	[16998]={b=178156,s=35631,d=28829,c=AUCT_CLAS_WEAPON},  -- Sacred Protector
	[16999]={b=42837,s=10709,d=28830,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Alexis
	[17001]={b=41258,s=10314,d=28831,c=AUCT_CLAS_ARMOR},  -- Elemental Circle
	[17002]={b=224127,s=44825,d=28834,c=AUCT_CLAS_WEAPON},  -- Ichor Spitter
	[17003]={b=224911,s=44982,d=28835,c=AUCT_CLAS_WEAPON},  -- Skullstone Hammer
	[17004]={b=282145,s=56429,d=28836,c=AUCT_CLAS_WEAPON},  -- Sarah's Guide
	[17005]={b=8161,s=1632,d=28837,c=AUCT_CLAS_ARMOR},  -- Boorguard Tunic
	[17006]={b=9831,s=1966,d=26995,c=AUCT_CLAS_ARMOR},  -- Cobalt Legguards
	[17007]={b=57238,s=11447,d=28838,c=AUCT_CLAS_ARMOR},  -- Stonerender Gauntlets
	[17008]={b=0,s=0,d=1301,c=AUCT_CLAS_QUEST},  -- Small Scroll
	[17009]={b=0,s=0,d=14023},  -- Ambassador Malcin's Head
	[17010]={b=8000,s=2000,d=28840,x=10},  -- Fiery Core
	[17011]={b=8000,s=2000,d=28841,x=10},  -- Lava Core
	[17012]={b=4000,s=1000,d=28842,x=10},  -- Core Leather
	[17013]={b=132207,s=26441,d=28843,c=AUCT_CLAS_ARMOR},  -- Dark Iron Leggings
	[17014]={b=63189,s=12637,d=28844,c=AUCT_CLAS_ARMOR},  -- Dark Iron Bracers
	[17015]={b=318693,s=63738,d=28848,c=AUCT_CLAS_WEAPON},  -- Dark Iron Reaver
	[17016]={b=319868,s=63973,d=23276,c=AUCT_CLAS_WEAPON},  -- Dark Iron Destroyer
	[17017]={b=180000,s=45000,d=1102},  -- Pattern: Flarecore Mantle
	[17018]={b=80000,s=20000,d=1102},  -- Pattern: Flarecore Gloves
	[17020]={b=1000,s=250,d=28854,x=20},  -- Arcane Powder
	[17021]={b=700,s=175,d=28855,x=20},  -- Wild Berries
	[17022]={b=150000,s=37500,d=1102},  -- Pattern: Corehound Boots
	[17023]={b=160000,s=40000,d=1102},  -- Pattern: Molten Helm
	[17025]={b=160000,s=40000,d=1102},  -- Pattern: Black Dragonscale Boots
	[17026]={b=1000,s=250,d=28858,x=20},  -- Wild Thornroot
	[17028]={b=700,s=175,d=28860,x=20},  -- Holy Candle
	[17029]={b=1000,s=250,d=28861,x=20},  -- Sacred Candle
	[17030]={b=2000,s=500,d=18725,x=5},  -- Ankh
	[17031]={b=1000,s=250,d=20984,x=10},  -- Rune of Teleportation
	[17032]={b=2000,s=500,d=28862,x=10},  -- Rune of Portals
	[17033]={b=2000,s=500,d=28863,x=5},  -- Symbol of Divinity
	[17034]={b=200,s=50,d=7287,x=20},  -- Maple Seed
	[17035]={b=400,s=100,d=7287,x=20},  -- Stranglethorn Seed
	[17036]={b=800,s=200,d=7287,x=20},  -- Ashwood Seed
	[17037]={b=1400,s=350,d=7287,x=20},  -- Hornbeam Seed
	[17038]={b=2000,s=500,d=7287,x=20},  -- Ironwood Seed
	[17039]={b=41585,s=8317,d=28869,c=AUCT_CLAS_WEAPON},  -- Skullbreaker
	[17042]={b=28464,s=5692,d=28870,c=AUCT_CLAS_WEAPON},  -- Nail Spitter
	[17043]={b=15274,s=3054,d=28871,c=AUCT_CLAS_ARMOR},  -- Zealot's Robe
	[17044]={b=60155,s=15038,d=23716,c=AUCT_CLAS_ARMOR},  -- Will of the Martyr
	[17045]={b=59387,s=14846,d=28682,c=AUCT_CLAS_ARMOR},  -- Blood of the Martyr
	[17046]={b=23983,s=4796,d=28873,c=AUCT_CLAS_WEAPON},  -- Gutterblade
	[17047]={b=6565,s=1313,d=12473,c=AUCT_CLAS_ARMOR},  -- Luminescent Amice
	[17048]={b=1600,s=400,d=18119,x=10},  -- Rumsey Rum
	[17049]={b=90000,s=22500,d=6270},  -- Plans: Fiery Chain Girdle
	[17050]={b=62683,s=12536,d=28990,c=AUCT_CLAS_ARMOR},  -- Chan's Imperial Robes
	[17051]={b=70000,s=17500,d=6270},  -- Plans: Dark Iron Bracers
	[17052]={b=180000,s=45000,d=6270},  -- Plans: Dark Iron Leggings
	[17053]={b=200000,s=50000,d=6270},  -- Plans: Fiery Chain Shoulders
	[17054]={b=143942,s=28788,d=28876,c=AUCT_CLAS_WEAPON},  -- Joonho's Mercy
	[17055]={b=133735,s=26747,d=15887,c=AUCT_CLAS_WEAPON},  -- Changuk Smasher
	[17056]={b=30,s=7,d=28877,x=20},  -- Light Feather
	[17057]={b=30,s=7,d=28878,x=20},  -- Shiny Fish Scales
	[17058]={b=30,s=7,d=15773,x=20,c=AUCT_CLAS_POTION},  -- Fish Oil
	[17059]={b=220000,s=55000,d=6270},  -- Plans: Dark Iron Reaver
	[17060]={b=220000,s=55000,d=6270},  -- Plans: Dark Iron Destroyer
	[17062]={b=2200,s=550,d=1102},  -- Recipe: Mithril Head Trout
	[17063]={b=95846,s=23961,d=9840,c=AUCT_CLAS_ARMOR},  -- Band of Accuria
	[17064]={b=183658,s=45914,d=26374,c=AUCT_CLAS_ARMOR},  -- Shard of the Scale
	[17065]={b=133525,s=33381,d=4841,c=AUCT_CLAS_ARMOR},  -- Medallion of Steadfast Might
	[17066]={b=289852,s=57970,d=29701,c=AUCT_CLAS_WEAPON},  -- Drillborer Disk
	[17067]={b=301810,s=75452,d=29717,c=AUCT_CLAS_WEAPON},  -- Ancient Cornerstone Grimoire
	[17068]={b=394169,s=78833,d=29161,c=AUCT_CLAS_WEAPON},  -- Deathbringer
	[17069]={b=311583,s=62316,d=30919,c=AUCT_CLAS_WEAPON},  -- Striker's Mark
	[17070]={b=546537,s=109307,d=29706,c=AUCT_CLAS_WEAPON},  -- Fang of the Mystics
	[17071]={b=522363,s=104472,d=29167,c=AUCT_CLAS_WEAPON},  -- Gutgore Ripper
	[17072]={b=308082,s=61616,d=29163,c=AUCT_CLAS_WEAPON},  -- Blastershot Launcher
	[17073]={b=568157,s=113631,d=29168,c=AUCT_CLAS_WEAPON},  -- Earthshaker
	[17074]={b=492571,s=98514,d=29176,c=AUCT_CLAS_WEAPON},  -- Shadowstrike
	[17075]={b=395437,s=79087,d=29132,c=AUCT_CLAS_WEAPON},  -- Vis'kag the Bloodletter
	[17076]={b=982192,s=196438,d=29170,c=AUCT_CLAS_WEAPON},  -- Bonereaver's Edge
	[17077]={b=284484,s=56896,d=29195,c=AUCT_CLAS_WEAPON},  -- Crimson Shocker
	[17078]={b=119909,s=23981,d=29719,c=AUCT_CLAS_ARMOR},  -- Sapphiron Drape
	[17102]={b=193445,s=38689,d=29824,c=AUCT_CLAS_ARMOR},  -- Cloak of the Shrouded Mists
	[17103]={b=559117,s=111823,d=29677,c=AUCT_CLAS_WEAPON},  -- Azuresong Mageblade
	[17105]={b=510891,s=102178,d=29714,c=AUCT_CLAS_WEAPON},  -- Aurastone Hammer
	[17106]={b=439804,s=87960,d=29702,c=AUCT_CLAS_WEAPON},  -- Malistar's Defender
	[17107]={b=187685,s=37537,d=29827,c=AUCT_CLAS_ARMOR},  -- Dragon's Blood Cape
	[17109]={b=134500,s=33625,d=9858,c=AUCT_CLAS_ARMOR},  -- Choker of Enlightenment
	[17110]={b=98595,s=24648,d=29697,c=AUCT_CLAS_ARMOR},  -- Seal of the Archmagus
	[17111]={b=138595,s=34648,d=6484,c=AUCT_CLAS_ARMOR},  -- Blazefury Medallion
	[17112]={b=452792,s=90558,d=29171,c=AUCT_CLAS_WEAPON},  -- Empyrean Demolisher
	[17113]={b=596390,s=119278,d=29703,c=AUCT_CLAS_WEAPON},  -- Amberseal Keeper
	[17114]={b=0,s=0,d=20784},  -- Araj's Phylactery Shard
	[17117]={b=0,s=0,d=2618},  -- Rat Catcher's Flute
	[17118]={b=0,s=0,d=28999,u=AUCT_TYPE_COOK},  -- Carton of Mystery Meat
	[17119]={b=125,s=6,d=29036,q=20,x=20},  -- Deeprun Rat Kabob
	[17124]={b=0,s=0,d=17655,q=100,x=100},  -- Syndicate Emblem
	[17125]={b=0,s=0,d=8918},  -- Seal of Ravenholdt
	[17126]={b=0,s=0,d=7726,c=AUCT_CLAS_QUEST},  -- Elegant Letter
	[17183]={b=34,s=6,d=2208,c=AUCT_CLAS_WEAPON},  -- Dented Buckler
	[17184]={b=34,s=6,d=18480,c=AUCT_CLAS_WEAPON},  -- Small Shield
	[17185]={b=243,s=48,d=18509,c=AUCT_CLAS_WEAPON},  -- Round Buckler
	[17186]={b=243,s=48,d=18506,c=AUCT_CLAS_WEAPON},  -- Small Targe
	[17187]={b=1078,s=215,d=27782,c=AUCT_CLAS_WEAPON},  -- Banded Buckler
	[17188]={b=2265,s=453,d=18468,c=AUCT_CLAS_WEAPON},  -- Ringed Buckler
	[17189]={b=12043,s=2408,d=18477,c=AUCT_CLAS_WEAPON},  -- Metal Buckler
	[17190]={b=34609,s=6921,d=18516,c=AUCT_CLAS_WEAPON},  -- Ornate Buckler
	[17191]={b=0,s=0,d=29730},  -- Scepter of Celebras
	[17192]={b=4399,s=879,d=2324,c=AUCT_CLAS_WEAPON},  -- Reinforced Targe
	[17193]={b=611554,s=122310,d=29699,c=AUCT_CLAS_WEAPON},  -- Sulfuron Hammer
	[17194]={b=10,s=0,d=29164,q=20,x=20},  -- Holiday Spices
	[17195]={b=10,s=0,d=29165,q=20,x=20},  -- Mistletoe
	[17196]={b=50,s=12,d=18079,x=20},  -- Holiday Spirits
	[17197]={b=40,s=10,d=29166,x=20},  -- Gingerbread Cookie
	[17198]={b=36,s=9,d=29172,x=20},  -- Egg Nog
	[17200]={b=25,s=6,d=811},  -- Recipe: Gingerbread Cookie
	[17201]={b=240,s=60,d=811},  -- Recipe: Egg Nog
	[17202]={b=10,s=0,d=29169,q=20,x=20},  -- Snowball
	[17203]={b=400000,s=100000,d=29174,x=20},  -- Sulfuron Ingot
	[17222]={b=1200,s=300,d=29193,x=20},  -- Spider Sausage
	[17223]={b=485373,s=97074,d=29191,c=AUCT_CLAS_WEAPON},  -- Thunderstrike
	[17242]={b=0,s=0,d=13290},  -- Key to Salem's Chest
	[17262]={b=0,s=0,d=13290},  -- James' Key
	[17303]={b=10,s=2,d=29442,x=10},  -- Blue Ribboned Wrapping Paper
	[17304]={b=10,s=2,d=29440,x=10},  -- Green Ribboned Wrapping Paper
	[17306]={b=0,s=0,d=15711,q=100,x=100},  -- Stormpike Soldier's Blood
	[17307]={b=10,s=2,d=29443,x=10},  -- Purple Ribboned Wrapping Paper
	[17309]={b=0,s=0,d=29311,q=20,x=20},  -- Discordant Bracers
	[17310]={b=0,s=0,d=21672},  -- Aspect of Neptulos
	[17322]={b=0,s=0,d=24730},  -- Eye of the Emberseer
	[17326]={b=0,s=0,d=22024,q=100,x=100},  -- Stormpike Soldier's Flesh
	[17327]={b=0,s=0,d=25475,q=100,x=100},  -- Stormpike Lieutenant's Flesh
	[17328]={b=0,s=0,d=25467,q=100,x=100},  -- Stormpike Commander's Flesh
	[17329]={b=0,s=0,d=29315},  -- Hand of Lucifron
	[17330]={b=0,s=0,d=29314},  -- Hand of Sulfuron
	[17331]={b=0,s=0,d=29317},  -- Hand of Gehennas
	[17332]={b=0,s=0,d=29316},  -- Hand of Shazzrah
	[17333]={b=0,s=0,d=21672},  -- Aqual Quintessence
	[17344]={b=25,s=1,d=29331,q=20,x=20},  -- Candy Cane
	[17345]={b=0,s=0,d=6703,q=20,x=20},  -- Silithid Goo
	[17346]={b=0,s=0,d=29351},  -- Encrusted Silithid Object
	[17355]={b=0,s=0,d=3093,c=AUCT_CLAS_WRITTEN},  -- Rabine's Letter
	[17402]={b=2000,s=500,d=18117,x=20},  -- Greatfather's Winter Ale
	[17403]={b=150,s=37,d=18080,x=20},  -- Steamwheedle Fizzy Spirits
	[17404]={b=125,s=6,d=19873,q=20,x=20},  -- Blended Bean Brew
	[17405]={b=1000,s=50,d=18091,q=20,x=20},  -- Green Garden Tea
	[17406]={b=125,s=6,d=6425,q=20,x=20},  -- Holiday Cheesewheel
	[17407]={b=1000,s=50,d=1041,q=20,x=20},  -- Graccu's Homemade Meat Pie
	[17408]={b=2000,s=100,d=25469,q=20,x=20},  -- Spicy Beefstick
	[17413]={b=31000,s=7750,d=1143},  -- Codex: Prayer of Fortitude
	[17414]={b=59000,s=14750,d=1143},  -- Codex: Prayer of Fortitude II
	[17422]={b=10,s=2,d=29468,x=100},  -- Armor Scraps
	[17508]={b=36350,s=7270,d=4405,c=AUCT_CLAS_WEAPON},  -- Forcestone Buckler
	[17523]={b=53790,s=10758,d=29630,c=AUCT_CLAS_ARMOR},  -- Smokey's Drape
	[17562]={b=43683,s=8736,d=31059,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Dreadweave Boots
	[17564]={b=29332,s=5866,d=31060,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Dreadweave Gloves
	[17566]={b=44318,s=8863,d=30341,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Headguard
	[17567]={b=59304,s=11860,d=30385,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Dreadweave Leggings
	[17568]={b=55273,s=11054,d=31053,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Dreadweave Robe
	[17569]={b=41614,s=8322,d=31066,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Dreadweave Mantle
	[17570]={b=41774,s=8354,d=27258,c=AUCT_CLAS_ARMOR},  -- Champion's Dreadweave Hood
	[17571]={b=55912,s=11182,d=31032,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Dreadweave Leggings
	[17572]={b=56119,s=11223,d=27260,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Dreadweave Robe
	[17573]={b=42249,s=8449,d=30381,c=AUCT_CLAS_ARMOR},  -- Champion's Dreadweave Shoulders
	[17576]={b=42724,s=8544,d=31026,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Dreadweave Boots
	[17577]={b=28589,s=5717,d=27256,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Dreadweave Gloves
	[17578]={b=63275,s=12655,d=30341,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Coronal
	[17579]={b=84680,s=16936,d=30385,c=AUCT_CLAS_ARMOR},  -- Marshal's Dreadweave Leggings
	[17580]={b=63738,s=12747,d=30336,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Dreadweave Shoulders
	[17581]={b=85298,s=17059,d=30343,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Dreadweave Robe
	[17583]={b=64437,s=12887,d=30337,c=AUCT_CLAS_ARMOR},  -- Marshal's Dreadweave Boots
	[17584]={b=44236,s=8847,d=30339,c=AUCT_CLAS_ARMOR},  -- Marshal's Dreadweave Gloves
	[17586]={b=60469,s=12093,d=30344,c=AUCT_CLAS_ARMOR},  -- General's Dreadweave Boots
	[17588]={b=40621,s=8124,d=30379,c=AUCT_CLAS_ARMOR},  -- General's Dreadweave Gloves
	[17590]={b=61402,s=12280,d=30350,c=AUCT_CLAS_ARMOR},  -- Warlord's Dreadweave Mantle
	[17591]={b=61631,s=12326,d=30352,c=AUCT_CLAS_ARMOR},  -- Warlord's Dreadweave Hood
	[17592]={b=82487,s=16497,d=30351,c=AUCT_CLAS_ARMOR},  -- Warlord's Dreadweave Robe
	[17593]={b=82801,s=16560,d=30380,c=AUCT_CLAS_ARMOR},  -- General's Dreadweave Pants
	[17594]={b=42405,s=8481,d=31061,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Satin Boots
	[17596]={b=28480,s=5696,d=31062,c=AUCT_CLAS_ARMOR},  -- Knight-Lieutenant's Satin Gloves
	[17598]={b=43035,s=8607,d=31065,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Diadem
	[17599]={b=57594,s=11518,d=25198,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Satin Leggings
	[17600]={b=59333,s=11866,d=31058,c=AUCT_CLAS_ARMOR},  -- Knight-Captain's Satin Robes
	[17601]={b=44659,s=8931,d=31067,c=AUCT_CLAS_ARMOR},  -- Lieutenant Commander's Satin Amice
	[17602]={b=65878,s=13175,d=30341,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Headdress
	[17603]={b=88150,s=17630,d=30385,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Satin Pants
	[17604]={b=66347,s=13269,d=30336,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Satin Mantle
	[17605]={b=88777,s=17755,d=30343,c=AUCT_CLAS_ARMOR},  -- Field Marshal's Satin Vestments
	[17607]={b=60691,s=12138,d=30337,c=AUCT_CLAS_ARMOR},  -- Marshal's Satin Sandals
	[17608]={b=40617,s=8123,d=30339,c=AUCT_CLAS_ARMOR},  -- Marshal's Satin Gloves
	[17610]={b=41761,s=8352,d=31030,c=AUCT_CLAS_ARMOR},  -- Champion's Satin Cowl
	[17611]={b=55895,s=11179,d=31033,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Satin Trousers
	[17612]={b=56108,s=11221,d=30351,c=AUCT_CLAS_ARMOR},  -- Legionnaire's Satin Vestments
	[17613]={b=42236,s=8447,d=31031,c=AUCT_CLAS_ARMOR},  -- Champion's Satin Shoulderpads
	[17616]={b=43860,s=8772,d=31027,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Satin Boots
	[17617]={b=29344,s=5868,d=31028,c=AUCT_CLAS_ARMOR},  -- Blood Guard's Satin Gloves
	[17618]={b=64938,s=12987,d=30344,c=AUCT_CLAS_ARMOR},  -- General's Satin Boots
	[17620]={b=43605,s=8721,d=30347,c=AUCT_CLAS_ARMOR},  -- General's Satin Gloves
	[17622]={b=65871,s=13174,d=30350,c=AUCT_CLAS_ARMOR},  -- Warlord's Satin Mantle
	[17623]={b=66106,s=13221,d=30352,c=AUCT_CLAS_ARMOR},  -- Warlord's Satin Cowl
	[17624]={b=88455,s=17691,d=30351,c=AUCT_CLAS_ARMOR},  -- Warlord's Satin Robes
	[17625]={b=88760,s=17752,d=30380,c=AUCT_CLAS_ARMOR},  -- General's Satin Leggings
	[17662]={b=0,s=0,d=8928},  -- Stolen Treats
	[17682]={b=35000,s=8750,d=1317},  -- Book: Gift of the Wild
	[17683]={b=59000,s=14750,d=1317},  -- Book: Gift of the Wild II
	[17684]={b=0,s=0,d=29731,q=30,x=30},  -- Theradric Crystal Carving
	[17685]={b=0,s=0,d=29692},  -- Smokywood Pastures Sampler
	[17686]={b=49686,s=9937,d=20555,c=AUCT_CLAS_WEAPON},  -- Master Hunter's Bow
	[17687]={b=49686,s=9937,d=8095,c=AUCT_CLAS_WEAPON},  -- Master Hunter's Rifle
	[17688]={b=15776,s=3155,d=29693,c=AUCT_CLAS_ARMOR},  -- Jungle Boots
	[17692]={b=3525,s=881,d=4284,c=AUCT_CLAS_ARMOR},  -- Horn Ring
	[17693]={b=0,s=0,d=22429},  -- Coated Cerulean Vial
	[17694]={b=3525,s=881,d=4284,c=AUCT_CLAS_ARMOR},  -- Band of the Fist
	[17695]={b=4654,s=930,d=16572,c=AUCT_CLAS_ARMOR},  -- Chestnut Mantle
	[17696]={b=0,s=0,d=29724},  -- Filled Cerulean Vial
	[17702]={b=0,s=0,d=29948},  -- Celebrian Rod
	[17703]={b=0,s=0,d=29691},  -- Celebrian Diamond
	[17704]={b=45890,s=9178,d=29759,c=AUCT_CLAS_WEAPON},  -- Edge of Winter
	[17705]={b=164272,s=32854,d=29769,c=AUCT_CLAS_WEAPON},  -- Thrash Blade
	[17706]={b=3800,s=950,d=15274},  -- Plans: Edge of Winter
	[17707]={b=46525,s=11631,d=29842,c=AUCT_CLAS_ARMOR},  -- Gemshard Heart
	[17708]={b=140,s=35,d=4136,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Frost Power
	[17709]={b=2000,s=500,d=1301},  -- Recipe: Elixir of Frost Power
	[17710]={b=177417,s=35483,d=29872,c=AUCT_CLAS_WEAPON},  -- Charstone Dirk
	[17711]={b=71223,s=14244,d=29880,c=AUCT_CLAS_ARMOR},  -- Elemental Rockridge Leggings
	[17712]={b=0,s=0,d=29903},  -- Winter Veil Disguise Kit
	[17713]={b=58565,s=14641,d=23629,c=AUCT_CLAS_ARMOR},  -- Blackstone Ring
	[17714]={b=51128,s=10225,d=29890,c=AUCT_CLAS_ARMOR},  -- Bracers of the Stone Princess
	[17715]={b=51128,s=10225,d=29894,c=AUCT_CLAS_ARMOR},  -- Eye of Theradras
	[17716]={b=30000,s=7500,d=29895},  -- SnowMaster 9000
	[17717]={b=132129,s=26425,d=4427,c=AUCT_CLAS_WEAPON},  -- Megashot Rifle
	[17718]={b=113150,s=22630,d=29896,c=AUCT_CLAS_WEAPON},  -- Gizlock's Hypertech Buckler
	[17719]={b=160530,s=32106,d=29897,c=AUCT_CLAS_WEAPON},  -- Inventor's Focal Sword
	[17720]={b=2400,s=600,d=15274},  -- Schematic: Snowmaster 9000
	[17721]={b=11340,s=2268,d=29898,c=AUCT_CLAS_ARMOR},  -- Gloves of the Greatfather
	[17722]={b=2800,s=700,d=1102},  -- Pattern: Gloves of the Greatfather
	[17723]={b=3000,s=750,d=29901,c=AUCT_CLAS_ARMOR},  -- Green Holiday Shirt
	[17724]={b=1500,s=375,d=1102},  -- Pattern: Green Holiday Shirt
	[17725]={b=3000,s=750,d=11431},  -- Formula: Enchant Weapon - Winter Might
	[17726]={b=0,s=0,d=29902},  -- Smokywood Pastures Special Gift
	[17727]={b=0,s=0,d=24053},  -- Smokywood Pastures Gift Pack
	[17728]={b=62291,s=12458,d=29904,c=AUCT_CLAS_ARMOR},  -- Albino Crocscale Boots
	[17730]={b=214759,s=42951,d=29907,c=AUCT_CLAS_WEAPON},  -- Gatorbite Axe
	[17732]={b=51916,s=10383,d=29908,c=AUCT_CLAS_ARMOR},  -- Rotgrip Mantle
	[17733]={b=173678,s=34735,d=29910,c=AUCT_CLAS_WEAPON},  -- Fist of Stone
	[17734]={b=52285,s=10457,d=29911,c=AUCT_CLAS_ARMOR},  -- Helm of the Mountain
	[17735]={b=0,s=0,d=1103,c=AUCT_CLAS_WRITTEN},  -- The Feast of Winter Veil
	[17736]={b=48234,s=9646,d=29912,c=AUCT_CLAS_ARMOR},  -- Rockgrip Gauntlets
	[17737]={b=40655,s=10163,d=29914,c=AUCT_CLAS_WEAPON},  -- Cloud Stone
	[17738]={b=166758,s=33351,d=29915,c=AUCT_CLAS_WEAPON},  -- Claw of Celebras
	[17739]={b=45504,s=9100,d=29916,c=AUCT_CLAS_ARMOR},  -- Grovekeeper's Drape
	[17740]={b=57006,s=11401,d=29941,c=AUCT_CLAS_ARMOR},  -- Soothsayer's Headdress
	[17741]={b=57238,s=11447,d=29918,c=AUCT_CLAS_ARMOR},  -- Nature's Embrace
	[17742]={b=72253,s=14450,d=29919,c=AUCT_CLAS_ARMOR},  -- Fungus Shroud Armor
	[17743]={b=203739,s=40747,d=22391,c=AUCT_CLAS_WEAPON},  -- Resurgence Rod
	[17744]={b=36125,s=9031,d=29922,c=AUCT_CLAS_ARMOR},  -- Heart of Noxxion
	[17745]={b=112599,s=22519,d=29924,c=AUCT_CLAS_WEAPON},  -- Noxious Shooter
	[17746]={b=28618,s=5723,d=29925,c=AUCT_CLAS_ARMOR},  -- Noxxion's Shackles
	[17747]={b=2000,s=500,d=6624,x=5},  -- Razorlash Root
	[17748]={b=45539,s=9107,d=29927,c=AUCT_CLAS_ARMOR},  -- Vinerot Sandals
	[17749]={b=57126,s=11425,d=29928,c=AUCT_CLAS_ARMOR},  -- Phytoskin Spaulders
	[17750]={b=23848,s=4769,d=29929,c=AUCT_CLAS_ARMOR},  -- Chloromesh Girdle
	[17751]={b=63936,s=12787,d=29930,c=AUCT_CLAS_ARMOR},  -- Brusslehide Leggings
	[17752]={b=143928,s=28785,d=29931,c=AUCT_CLAS_WEAPON},  -- Satyr's Lash
	[17753]={b=130233,s=26046,d=29932,c=AUCT_CLAS_WEAPON},  -- Verdant Keeper's Aim
	[17754]={b=86971,s=17394,d=29934,c=AUCT_CLAS_ARMOR},  -- Infernal Trickster Leggings
	[17755]={b=29093,s=5818,d=14456,c=AUCT_CLAS_ARMOR},  -- Satyrmane Sash
	[17756]={b=0,s=0,d=6688,q=20,x=20},  -- Shadowshard Fragment
	[17757]={b=0,s=0,d=13024},  -- Amulet of Spirits
	[17758]={b=0,s=0,d=29935},  -- Amulet of Union
	[17759]={b=41230,s=10307,d=23716,c=AUCT_CLAS_ARMOR},  -- Mark of Resolution
	[17760]={b=0,s=0,d=19492},  -- Seed of Life
	[17761]={b=0,s=0,d=4777},  -- Gem of the First Kahn
	[17762]={b=0,s=0,d=6851},  -- Gem of the Second Kahn
	[17763]={b=0,s=0,d=18707},  -- Gem of the Third Kahn
	[17764]={b=0,s=0,d=1659},  -- Gem of the Fourth Kahn
	[17765]={b=0,s=0,d=6496},  -- Gem of the Fifth Kahn
	[17766]={b=224317,s=44863,d=29939,c=AUCT_CLAS_WEAPON},  -- Princess Theradras' Scepter
	[17767]={b=68052,s=13610,d=29942,c=AUCT_CLAS_ARMOR},  -- Bloomsprout Headpiece
	[17768]={b=31565,s=7891,d=23608,c=AUCT_CLAS_ARMOR},  -- Woodseed Hoop
	[17770]={b=19258,s=3851,d=30957,c=AUCT_CLAS_ARMOR},  -- Branchclaw Gauntlets
	[17772]={b=28530,s=7132,d=15420,c=AUCT_CLAS_ARMOR},  -- Zealous Shadowshard Pendant
	[17773]={b=28530,s=7132,d=15420,c=AUCT_CLAS_ARMOR},  -- Prodigious Shadowshard Pendant
	[17774]={b=24535,s=6133,d=29947,c=AUCT_CLAS_ARMOR},  -- Mark of the Chosen
	[17775]={b=39207,s=7841,d=29951,c=AUCT_CLAS_ARMOR},  -- Acumen Robes
	[17776]={b=36888,s=7377,d=29952,c=AUCT_CLAS_ARMOR},  -- Sprightring Helm
	[17777]={b=54078,s=10815,d=29953,c=AUCT_CLAS_ARMOR},  -- Relentless Chain
	[17778]={b=22532,s=4506,d=29954,c=AUCT_CLAS_ARMOR},  -- Sagebrush Girdle
	[17779]={b=27736,s=5547,d=29955,c=AUCT_CLAS_ARMOR},  -- Hulkstone Pauldrons
	[17780]={b=233983,s=46796,d=29957,c=AUCT_CLAS_WEAPON},  -- Blade of Eternal Darkness
	[17781]={b=0,s=0,d=7798,c=AUCT_CLAS_WRITTEN},  -- The Pariah's Instructions
	[17922]={b=576,s=115,d=30171,c=AUCT_CLAS_ARMOR},  -- Lionfur Armor
	[17943]={b=160783,s=32156,d=29910,c=AUCT_CLAS_WEAPON},  -- Fist of Stone
	[17963]={b=854,s=213,d=3568},  -- Green Sack of Gems
	[17964]={b=22050,s=5512,d=1282},  -- Gray Sack of Gems
	[17965]={b=854,s=213,d=1168},  -- Yellow Sack of Gems
	[17966]={b=35000,s=8750,d=30271,c=AUCT_CLAS_CONTAINER},  -- Onyxia Hide Backpack
	[17982]={b=95846,s=23961,d=28682,c=AUCT_CLAS_ARMOR},  -- Ragnaros Core
	[18022]={b=42837,s=10709,d=28830,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Alexis
	[18042]={b=4000,s=10,d=30433,q=200,x=200,c=AUCT_CLAS_WEAPON},  -- Thorium Headed Arrow
	[18043]={b=64563,s=12912,d=2373,c=AUCT_CLAS_ARMOR},  -- Coal Miner Boots
	[18044]={b=169154,s=33830,d=30436,c=AUCT_CLAS_WEAPON},  -- Hurley's Tankard
	[18045]={b=1200,s=300,d=30437,x=20},  -- Tender Wolf Steak
	[18046]={b=12000,s=3000,d=1301},  -- Recipe: Tender Wolf Steak
	[18047]={b=122141,s=24428,d=30439,c=AUCT_CLAS_ARMOR},  -- Flame Walkers
	[18048]={b=217945,s=43589,d=30440,c=AUCT_CLAS_WEAPON},  -- Mastersmith's Hammer
	[18082]={b=140809,s=28161,d=30472,c=AUCT_CLAS_WEAPON},  -- Zum'rah's Vexing Cane
	[18083]={b=22613,s=4522,d=30474,c=AUCT_CLAS_ARMOR},  -- Jumanza Grips
	[18102]={b=85794,s=17158,d=14617,c=AUCT_CLAS_ARMOR},  -- Dragonrider Boots
	[18103]={b=61010,s=15252,d=24022,c=AUCT_CLAS_ARMOR},  -- Band of Rumination
	[18104]={b=86424,s=17284,d=30492,c=AUCT_CLAS_ARMOR},  -- Feralsurge Girdle
	[18151]={b=0,s=0,d=8547},  -- Filled Amethyst Phial
	[18152]={b=0,s=0,d=8547},  -- Amethyst Phial
	[18154]={b=0,s=0,d=30658},  -- Blizzard Stationery
	[18160]={b=200,s=50,d=1102},  -- Recipe: Thistle Tea
	[18168]={b=282082,s=56416,d=30561,c=AUCT_CLAS_WEAPON},  -- Force Reactive Disk
	[18169]={b=100000,s=25000,d=30562},  -- Flame Mantle of the Dawn
	[18170]={b=100000,s=25000,d=30563},  -- Frost Mantle of the Dawn
	[18171]={b=100000,s=25000,d=30564},  -- Arcane Mantle of the Dawn
	[18172]={b=100000,s=25000,d=30565},  -- Nature Mantle of the Dawn
	[18173]={b=100000,s=25000,d=30566},  -- Shadow Mantle of the Dawn
	[18182]={b=400000,s=100000,d=30567},  -- Chromatic Mantle of the Dawn
	[18202]={b=452881,s=90576,d=30594,c=AUCT_CLAS_WEAPON},  -- Eskhandar's Left Claw
	[18203]={b=454525,s=90905,d=30595,c=AUCT_CLAS_WEAPON},  -- Eskhandar's Right Claw
	[18204]={b=136851,s=27370,d=30577,c=AUCT_CLAS_ARMOR},  -- Eskhandar's Pelt
	[18205]={b=133150,s=33287,d=16132,c=AUCT_CLAS_ARMOR},  -- Eskhandar's Collar
	[18208]={b=145737,s=29147,d=15273,c=AUCT_CLAS_ARMOR},  -- Drape of Benediction
	[18222]={b=12280,s=3070,d=30600,x=20},  -- Thorny Vine
	[18223]={b=24568,s=6142,d=30601,x=20},  -- Serrated Petal
	[18224]={b=6912,s=1728,d=6501,x=40},  -- Lasher Root
	[18232]={b=40000,s=10000,d=19503},  -- Field Repair Bot 74A
	[18236]={b=10864,s=2716,d=13433,x=20},  -- Gordok Chew Toy
	[18237]={b=6490,s=1622,d=21368,x=20},  -- Mastiff Jawbone
	[18238]={b=16608,s=3321,d=15753,c=AUCT_CLAS_ARMOR},  -- Shadowskin Gloves
	[18239]={b=3500,s=875,d=1102},  -- Pattern: Shadowskin Gloves
	[18240]={b=0,s=0,d=292,q=20,x=20},  -- Ogre Tannin
	[18241]={b=1000000,s=0,d=30608},  -- Black War Steed Bridle
	[18242]={b=1000000,s=0,d=17606},  -- Reins of the Black War Tiger
	[18243]={b=1000000,s=0,d=17785},  -- Black Battlestrider
	[18244]={b=1000000,s=0,d=17343},  -- Black War Ram
	[18245]={b=1000000,s=0,d=16208},  -- Horn of the Black War Wolf
	[18246]={b=1000000,s=0,d=17494},  -- Whistle of the Black War Raptor
	[18247]={b=1000000,s=0,d=29447},  -- Black War Kodo
	[18248]={b=1000000,s=0,d=17786},  -- Red Skeletal Warhorse
	[18249]={b=0,s=0,d=20802},  -- Crescent Key
	[18250]={b=0,s=0,d=22071},  -- Gordok Shackle Key
	[18251]={b=20000,s=5000,d=30647,x=10},  -- Core Armor Kit
	[18253]={b=60,s=15,d=24217,x=5,c=AUCT_CLAS_POTION},  -- Major Rejuvenation Potion
	[18254]={b=72,s=18,d=26733,x=20},  -- Runn Tum Tuber Surprise
	[18255]={b=60,s=15,d=21974,x=20},  -- Runn Tum Tuber
	[18256]={b=30000,s=1500,d=18077,q=20,x=20},  -- Imbued Vial
	[18257]={b=200000,s=50000,d=6270,c=AUCT_CLAS_POTION},  -- Recipe: Major Rejuvination Potion
	[18258]={b=0,s=0,d=30611},  -- Gordok Ogre Suit
	[18261]={b=0,s=0,d=1103},  -- Book of Incantations
	[18262]={b=5000,s=1250,d=21072,x=20},  -- Elemental Sharpening Stone
	[18263]={b=84557,s=16911,d=27972,c=AUCT_CLAS_ARMOR},  -- Flarecore Wraps
	[18266]={b=0,s=0,d=7737},  -- Gordok Courtyard Key
	[18267]={b=20000,s=5000,d=1301},  -- Recipe: Runn Tum Tuber Surprise
	[18268]={b=0,s=0,d=3118},  -- Gordok Inner Door Key
	[18269]={b=1500,s=375,d=18119,x=10},  -- Gordok Green Grog
	[18282]={b=331739,s=66347,d=31210,c=AUCT_CLAS_WEAPON},  -- Core Marksman Rifle
	[18284]={b=1500,s=375,d=18115,x=10},  -- Kreeg's Stout Beatdown
	[18285]={b=18234,s=4558,d=2516,x=20},  -- Crystallized Mana Shard
	[18286]={b=11812,s=2953,d=30634,x=20},  -- Condensed Mana Fragment
	[18287]={b=200,s=50,d=18080,x=20},  -- Evermurky
	[18288]={b=1000,s=250,d=7921,x=20},  -- Molasses Firewater
	[18289]={b=38804,s=9701,d=9860,c=AUCT_CLAS_ARMOR},  -- Barbed Thorn Necklace
	[18291]={b=120000,s=30000,d=6270},  -- Schematic: Force Reactive Disk
	[18294]={b=1000,s=250,d=3665,x=5,c=AUCT_CLAS_POTION},  -- Elixir of Greater Water Breathing
	[18295]={b=57913,s=11582,d=30639,c=AUCT_CLAS_ARMOR},  -- Phasing Boots
	[18296]={b=57448,s=11489,d=30643,c=AUCT_CLAS_ARMOR},  -- Marksman Bands
	[18297]={b=0,s=0,d=30650,q=5,x=5},  -- Thornling Seed
	[18298]={b=103427,s=20685,d=30654,c=AUCT_CLAS_ARMOR},  -- Unbridled Leggings
	[18299]={b=0,s=0,d=17889},  -- Hydrospawn Essence
	[18301]={b=146815,s=29363,d=30660,c=AUCT_CLAS_WEAPON},  -- Lethtendris's Wand
	[18302]={b=30122,s=7530,d=30661,c=AUCT_CLAS_ARMOR},  -- Band of Vigor
	[18305]={b=71879,s=14375,d=30671,c=AUCT_CLAS_ARMOR},  -- Breakwater Legguards
	[18306]={b=36075,s=7215,d=30669,c=AUCT_CLAS_ARMOR},  -- Gloves of Shadowy Mist
	[18307]={b=55815,s=11163,d=30667,c=AUCT_CLAS_ARMOR},  -- Riptide Shoes
	[18308]={b=67239,s=13447,d=30670,c=AUCT_CLAS_ARMOR},  -- Clever Hat
	[18309]={b=56480,s=11296,d=30672,c=AUCT_CLAS_ARMOR},  -- Gloves of Restoration
	[18310]={b=237032,s=47406,d=30673,c=AUCT_CLAS_WEAPON},  -- Fiendish Machete
	[18311]={b=283224,s=56644,d=28511,c=AUCT_CLAS_WEAPON},  -- Quel'dorai Channeling Rod
	[18312]={b=90369,s=18073,d=30675,c=AUCT_CLAS_ARMOR},  -- Energized Chestplate
	[18313]={b=68474,s=13694,d=30677,c=AUCT_CLAS_ARMOR},  -- Helm of Awareness
	[18314]={b=48400,s=12100,d=24646,c=AUCT_CLAS_ARMOR},  -- Ring of Demonic Guile
	[18315]={b=48400,s=12100,d=28812,c=AUCT_CLAS_ARMOR},  -- Ring of Demonic Potency
	[18317]={b=50012,s=12503,d=9853,c=AUCT_CLAS_ARMOR},  -- Tempest Talisman
	[18318]={b=110286,s=22057,d=30679,c=AUCT_CLAS_ARMOR},  -- Merciful Greaves
	[18319]={b=104945,s=20989,d=30680,c=AUCT_CLAS_ARMOR},  -- Fervent Helm
	[18321]={b=246601,s=49320,d=30915,c=AUCT_CLAS_WEAPON},  -- Energetic Rod
	[18322]={b=80686,s=16137,d=6779,c=AUCT_CLAS_ARMOR},  -- Waterspout Boots
	[18323]={b=164943,s=32988,d=30683,c=AUCT_CLAS_WEAPON},  -- Satyr's Bow
	[18324]={b=275949,s=55189,d=13360,c=AUCT_CLAS_WEAPON},  -- Waveslicer
	[18325]={b=80686,s=16137,d=30685,c=AUCT_CLAS_ARMOR},  -- Felhide Cap
	[18326]={b=45184,s=9036,d=30686,c=AUCT_CLAS_ARMOR},  -- Razor Gauntlets
	[18327]={b=46880,s=9376,d=30688,c=AUCT_CLAS_ARMOR},  -- Whipvine Cord
	[18328]={b=70583,s=14116,d=30689,c=AUCT_CLAS_ARMOR},  -- Shadewood Cloak
	[18329]={b=0,s=0,d=30690},  -- Arcanum of Rapidity
	[18330]={b=0,s=0,d=30690},  -- Arcanum of Focus
	[18331]={b=0,s=0,d=30690},  -- Arcanum of Protection
	[18332]={b=0,s=0,d=12547,c=AUCT_CLAS_WRITTEN},  -- Libram of Rapidity
	[18333]={b=0,s=0,d=6672,c=AUCT_CLAS_WRITTEN},  -- Libram of Focus
	[18334]={b=0,s=0,d=1317,c=AUCT_CLAS_WRITTEN},  -- Libram of Protection
	[18335]={b=0,s=0,d=30690,q=5,x=5},  -- Pristine Black Diamond
	[18336]={b=0,s=0,d=30691},  -- Gauntlet of Gordok Might
	[18337]={b=40516,s=8103,d=30693,c=AUCT_CLAS_ARMOR},  -- Orphic Bracers
	[18338]={b=182979,s=36595,d=21016,c=AUCT_CLAS_WEAPON},  -- Wand of Arcane Potency
	[18339]={b=56853,s=11370,d=30703,c=AUCT_CLAS_ARMOR},  -- Eidolon Cloak
	[18340]={b=115412,s=28853,d=30696,c=AUCT_CLAS_ARMOR},  -- Eidolon Talisman
	[18343]={b=58462,s=14615,d=9836,c=AUCT_CLAS_ARMOR},  -- Petrified Band
	[18344]={b=56480,s=11296,d=25706,c=AUCT_CLAS_ARMOR},  -- Stonebark Gauntlets
	[18345]={b=58908,s=14727,d=9840,c=AUCT_CLAS_ARMOR},  -- Murmuring Ring
	[18346]={b=81726,s=16345,d=30698,c=AUCT_CLAS_ARMOR},  -- Threadbare Trousers
	[18347]={b=215336,s=43067,d=30699,c=AUCT_CLAS_WEAPON},  -- Well Balanced Axe
	[18348]={b=563257,s=112651,d=30858,c=AUCT_CLAS_WEAPON},  -- Quel'Serrar
	[18349]={b=62270,s=12454,d=30702,c=AUCT_CLAS_ARMOR},  -- Gauntlets of Accuracy
	[18350]={b=65319,s=13063,d=15217,c=AUCT_CLAS_ARMOR},  -- Amplifying Cloak
	[18351]={b=43702,s=8740,d=30704,c=AUCT_CLAS_ARMOR},  -- Magically Sealed Bracers
	[18352]={b=140363,s=28072,d=30706,c=AUCT_CLAS_WEAPON},  -- Petrified Bark Shield
	[18353]={b=275154,s=55030,d=30711,c=AUCT_CLAS_WEAPON},  -- Stoneflower Staff
	[18354]={b=69864,s=17466,d=1399,c=AUCT_CLAS_ARMOR},  -- Pimgib's Collar
	[18356]={b=0,s=0,d=1246,c=AUCT_CLAS_QUEST},  -- Garona: A Study on Stealth and Treachery
	[18357]={b=0,s=0,d=1103,c=AUCT_CLAS_QUEST},  -- Codex of Defense
	[18358]={b=0,s=0,d=7139,c=AUCT_CLAS_QUEST},  -- The Arcanist's Cookbook
	[18359]={b=0,s=0,d=1317,c=AUCT_CLAS_QUEST},  -- The Light and How to Swing It
	[18360]={b=0,s=0,d=8093,c=AUCT_CLAS_QUEST},  -- Harnessing Shadows
	[18361]={b=0,s=0,d=12547,c=AUCT_CLAS_QUEST},  -- The Greatest Race of Hunters
	[18362]={b=0,s=0,d=1155,c=AUCT_CLAS_QUEST},  -- Holy Bologna: What the Light Won't Tell You
	[18363]={b=0,s=0,d=6672,c=AUCT_CLAS_QUEST},  -- Frost Shock and You
	[18364]={b=0,s=0,d=1134,c=AUCT_CLAS_QUEST},  -- The Emerald Dream: Fact or Carefully Planned Out Farce Perpetrated By My Brother
	[18365]={b=0,s=0,d=5780},  -- A Thoroughly Read Copy of "Nat Pagle's Extreme' Anglin."
	[18366]={b=49025,s=9805,d=30721,c=AUCT_CLAS_ARMOR},  -- Gordok's Handguards
	[18367]={b=73814,s=14762,d=30720,c=AUCT_CLAS_ARMOR},  -- Gordok's Gauntlets
	[18368]={b=61742,s=12348,d=30719,c=AUCT_CLAS_ARMOR},  -- Gordok's Gloves
	[18369]={b=49577,s=9915,d=16710,c=AUCT_CLAS_ARMOR},  -- Gordok's Handwraps
	[18370]={b=86450,s=21612,d=30722,c=AUCT_CLAS_ARMOR},  -- Vigilance Charm
	[18371]={b=82948,s=20737,d=30723,c=AUCT_CLAS_ARMOR},  -- Mindtap Talisman
	[18372]={b=283580,s=56716,d=30724,c=AUCT_CLAS_WEAPON},  -- Blade of the New Moon
	[18373]={b=142297,s=28459,d=17099,c=AUCT_CLAS_ARMOR},  -- Chestplate of Tranquility
	[18374]={b=107093,s=21418,d=18971,c=AUCT_CLAS_ARMOR},  -- Flamescarred Shoulders
	[18375]={b=71649,s=14329,d=30727,c=AUCT_CLAS_ARMOR},  -- Bracers of the Eclipse
	[18376]={b=261534,s=52306,d=30728,c=AUCT_CLAS_WEAPON},  -- Timeworn Mace
	[18377]={b=65383,s=13076,d=30729,c=AUCT_CLAS_ARMOR},  -- Quickdraw Gloves
	[18378]={b=156920,s=31384,d=30730,c=AUCT_CLAS_ARMOR},  -- Silvermoon Leggings
	[18379]={b=118957,s=23791,d=30736,c=AUCT_CLAS_ARMOR},  -- Odious Greaves
	[18380]={b=105677,s=21135,d=30737,c=AUCT_CLAS_ARMOR},  -- Eldritch Reinforced Legplates
	[18381]={b=86542,s=21635,d=30738,c=AUCT_CLAS_ARMOR},  -- Evil Eye Pendant
	[18382]={b=79858,s=15971,d=30739,c=AUCT_CLAS_ARMOR},  -- Fluctuating Cloak
	[18383]={b=50897,s=10179,d=30740,c=AUCT_CLAS_ARMOR},  -- Force Imbued Gauntlets
	[18384]={b=80467,s=16093,d=30743,c=AUCT_CLAS_ARMOR},  -- Bile-etched Spaulders
	[18385]={b=107684,s=21536,d=30744,c=AUCT_CLAS_ARMOR},  -- Robe of Everlasting Night
	[18386]={b=102943,s=20588,d=21964,c=AUCT_CLAS_ARMOR},  -- Padre's Trousers
	[18387]={b=47443,s=9488,d=13656,c=AUCT_CLAS_ARMOR},  -- Brightspark Gloves
	[18388]={b=209641,s=41928,d=30747,c=AUCT_CLAS_WEAPON},  -- Stoneshatter
	[18389]={b=84152,s=16830,d=15247,c=AUCT_CLAS_ARMOR},  -- Cloak of the Cosmos
	[18390]={b=134059,s=26811,d=18935,c=AUCT_CLAS_ARMOR},  -- Tanglemoss Leggings
	[18391]={b=65383,s=13076,d=30749,c=AUCT_CLAS_ARMOR},  -- Eyestalk Cord
	[18392]={b=283553,s=56710,d=6443,c=AUCT_CLAS_WEAPON},  -- Distracting Dagger
	[18393]={b=74724,s=14944,d=30751,c=AUCT_CLAS_ARMOR},  -- Warpwood Binding
	[18394]={b=85666,s=17133,d=30753,c=AUCT_CLAS_ARMOR},  -- Demon Howl Wristguards
	[18395]={b=146580,s=36645,d=9842,c=AUCT_CLAS_ARMOR},  -- Emerald Flame Ring
	[18396]={b=287583,s=57516,d=30754,c=AUCT_CLAS_WEAPON},  -- Mind Carver
	[18397]={b=89857,s=22464,d=9859,c=AUCT_CLAS_ARMOR},  -- Elder Magus Pendant
	[18398]={b=108413,s=27103,d=9832,c=AUCT_CLAS_ARMOR},  -- Tidal Loop
	[18399]={b=108413,s=27103,d=28812,c=AUCT_CLAS_ARMOR},  -- Ocean's Breeze
	[18400]={b=59412,s=14853,d=26001,c=AUCT_CLAS_ARMOR},  -- Ring of Living Stone
	[18401]={b=0,s=0,d=1317,c=AUCT_CLAS_QUEST},  -- Foror's Compendium of Dragon Slaying
	[18402]={b=74651,s=18662,d=29697,c=AUCT_CLAS_ARMOR},  -- Glowing Crystal Ring
	[18403]={b=196240,s=49060,d=26391,c=AUCT_CLAS_ARMOR},  -- Dragonslayer's Signet
	[18404]={b=26856,s=6714,d=9860,c=AUCT_CLAS_ARMOR},  -- Onyxia Tooth Pendant
	[18405]={b=73720,s=14744,d=30763,c=AUCT_CLAS_ARMOR},  -- Belt of the Archmage
	[18406]={b=184123,s=46030,d=30764,c=AUCT_CLAS_ARMOR},  -- Onyxia Blood Talisman
	[18407]={b=55696,s=11139,d=17216,c=AUCT_CLAS_ARMOR},  -- Felcloth Gloves
	[18408]={b=55893,s=11178,d=30772,c=AUCT_CLAS_ARMOR},  -- Inferno Gloves
	[18409]={b=56096,s=11219,d=30774,c=AUCT_CLAS_ARMOR},  -- Mooncloth Gloves
	[18410]={b=227582,s=45516,d=30778,c=AUCT_CLAS_WEAPON},  -- Sprinter's Sword
	[18411]={b=63433,s=12686,d=30779,c=AUCT_CLAS_ARMOR},  -- Spry Boots
	[18412]={b=0,s=0,d=30780},  -- Core Fragment
	[18413]={b=85353,s=17070,d=30783,c=AUCT_CLAS_ARMOR},  -- Cloak of Warding
	[18414]={b=120000,s=30000,d=1096},  -- Pattern: Belt of the Archmage
	[18415]={b=40000,s=10000,d=6270},  -- Pattern: Felcloth Gloves
	[18416]={b=40000,s=10000,d=6270},  -- Pattern: Inferno Gloves
	[18417]={b=40000,s=10000,d=6270},  -- Pattern: Mooncloth Gloves
	[18418]={b=40000,s=10000,d=6270},  -- Pattern: Cloak of Warding
	[18420]={b=356184,s=71236,d=30792,c=AUCT_CLAS_WEAPON},  -- Bonecrusher
	[18421]={b=128705,s=25741,d=30793,c=AUCT_CLAS_ARMOR},  -- Backwood Helm
	[18422]={b=0,s=0,d=30794,c=AUCT_CLAS_QUEST},  -- Head of Onyxia
	[18423]={b=0,s=0,d=30794,c=AUCT_CLAS_QUEST},  -- Head of Onyxia
	[18424]={b=102979,s=20595,d=30795,c=AUCT_CLAS_ARMOR},  -- Sedge Boots
	[18425]={b=22150,s=5537,d=30796,c=AUCT_CLAS_WEAPON},  -- Kreeg's Mug
	[18426]={b=0,s=0,d=18597},  -- Lethtendris's Web
	[18427]={b=6611,s=1322,d=27088,c=AUCT_CLAS_ARMOR},  -- Sergeant's Cloak
	[18428]={b=30000,s=7500,d=30797,c=AUCT_CLAS_ARMOR},  -- Senior Sergeant's Insignia
	[18429]={b=29447,s=5889,d=27273,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Plate Bracers
	[18430]={b=14391,s=2878,d=27273,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Plate Bracers
	[18432]={b=21742,s=4348,d=27277,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Mail Wristguards
	[18434]={b=37468,s=7493,d=27262,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Dragonhide Armguards
	[18435]={b=18311,s=3662,d=30801,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Leather Armguards
	[18436]={b=17086,s=3417,d=27262,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Dragonhide Armguards
	[18437]={b=13721,s=2744,d=27255,c=AUCT_CLAS_ARMOR},  -- First Sergeant's Silk Cuffs
	[18440]={b=6443,s=1288,d=27087,c=AUCT_CLAS_ARMOR},  -- Sergeant's Cape
	[18441]={b=20891,s=4178,d=27087,c=AUCT_CLAS_ARMOR},  -- Sergeant's Cape
	[18442]={b=20000,s=5000,d=30799,c=AUCT_CLAS_ARMOR},  -- Master Sergeant's Insignia
	[18443]={b=40000,s=10000,d=30799,c=AUCT_CLAS_ARMOR},  -- Master Sergeant's Insignia
	[18444]={b=30000,s=7500,d=30799,c=AUCT_CLAS_ARMOR},  -- Master Sergeant's Insignia
	[18445]={b=29021,s=5804,d=27223,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Plate Wristguards
	[18447]={b=14235,s=2847,d=27223,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Plate Wristguards
	[18448]={b=44007,s=8801,d=31248,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Chain Armguards
	[18449]={b=21507,s=4301,d=31248,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Chain Armguards
	[18450]={b=79073,s=15814,d=30802,c=AUCT_CLAS_ARMOR},  -- Robe of Combustion
	[18451]={b=49420,s=9884,d=30803,c=AUCT_CLAS_ARMOR},  -- Hyena Hide Belt
	[18452]={b=34553,s=6910,d=30804,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Dragonhide Armsplints
	[18453]={b=16716,s=3343,d=30804,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Dragonhide Armsplints
	[18454]={b=5774,s=1154,d=30805,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Leather Armsplints
	[18455]={b=16716,s=3343,d=30805,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Leather Armsplints
	[18456]={b=28065,s=5613,d=30806,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Silk Cuffs
	[18457]={b=13373,s=2674,d=30806,c=AUCT_CLAS_ARMOR},  -- Sergeant Major's Silk Cuffs
	[18458]={b=61064,s=12212,d=26103,c=AUCT_CLAS_ARMOR},  -- Modest Armguards
	[18459]={b=39536,s=7907,d=30807,c=AUCT_CLAS_ARMOR},  -- Gallant's Wristguards
	[18460]={b=153811,s=30762,d=30809,c=AUCT_CLAS_WEAPON},  -- Unsophisticated Hand Cannon
	[18461]={b=42888,s=8577,d=27088,c=AUCT_CLAS_ARMOR},  -- Sergeant's Cloak
	[18462]={b=206595,s=41319,d=30813,c=AUCT_CLAS_WEAPON},  -- Jagged Bone Fist
	[18463]={b=197683,s=39536,d=30814,c=AUCT_CLAS_WEAPON},  -- Ogre Pocket Knife
	[18464]={b=116541,s=29135,d=9849,c=AUCT_CLAS_ARMOR},  -- Gordok Nose Ring
	[18465]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18466]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18467]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18468]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18469]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18470]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18471]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18472]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18473]={b=0,s=0,d=29712,c=AUCT_CLAS_ARMOR},  -- Royal Seal of Eldre'Thalas
	[18475]={b=39536,s=7907,d=15399,c=AUCT_CLAS_ARMOR},  -- Oddly Magical Belt
	[18476]={b=75747,s=15149,d=30817,c=AUCT_CLAS_ARMOR},  -- Mud Stained Boots
	[18477]={b=98841,s=19768,d=17142,c=AUCT_CLAS_ARMOR},  -- Shaggy Leggings
	[18478]={b=98841,s=19768,d=30819,c=AUCT_CLAS_ARMOR},  -- Hyena Hide Jerkin
	[18479]={b=88957,s=17791,d=30820,c=AUCT_CLAS_ARMOR},  -- Carrion Scorpid Helm
	[18480]={b=59304,s=11860,d=30821,c=AUCT_CLAS_ARMOR},  -- Scarab Plate Helm
	[18481]={b=257259,s=51451,d=5233,c=AUCT_CLAS_WEAPON},  -- Skullcracking Mace
	[18482]={b=148262,s=29652,d=8106,c=AUCT_CLAS_WEAPON},  -- Ogre Toothpick Shooter
	[18483]={b=186810,s=37362,d=25076,c=AUCT_CLAS_WEAPON},  -- Mana Channeling Wand
	[18484]={b=269110,s=53822,d=30822,c=AUCT_CLAS_WEAPON},  -- Cho'Rush's Blade
	[18485]={b=172849,s=34569,d=20900,c=AUCT_CLAS_WEAPON},  -- Observer's Shield
	[18486]={b=108417,s=21683,d=30824,c=AUCT_CLAS_ARMOR},  -- Mooncloth Robe
	[18487]={b=40000,s=10000,d=1102},  -- Pattern: Mooncloth Robe
	[18488]={b=0,s=0,d=6511},  -- Heated Ancient Blade
	[18489]={b=0,s=0,d=20797},  -- Unfired Ancient Blade
	[18490]={b=93277,s=18655,d=30825,c=AUCT_CLAS_ARMOR},  -- Insightful Hood
	[18491]={b=203475,s=40695,d=30827,c=AUCT_CLAS_WEAPON},  -- Lorespinner
	[18492]={b=0,s=0,d=30828},  -- Treated Ancient Blade
	[18493]={b=71165,s=14233,d=30829,c=AUCT_CLAS_ARMOR},  -- Bulky Iron Spaulders
	[18494]={b=107223,s=21444,d=30830,c=AUCT_CLAS_ARMOR},  -- Denwatcher's Shoulders
	[18495]={b=83851,s=16770,d=30831,c=AUCT_CLAS_ARMOR},  -- Redoubt Cloak
	[18496]={b=71165,s=14233,d=30832,c=AUCT_CLAS_ARMOR},  -- Heliotrope Cloak
	[18497]={b=47443,s=9488,d=30833,c=AUCT_CLAS_ARMOR},  -- Sublime Wristguards
	[18498]={b=237219,s=47443,d=30834,c=AUCT_CLAS_WEAPON},  -- Hedgecutter
	[18499]={b=172945,s=34589,d=30835,c=AUCT_CLAS_WEAPON},  -- Barrier Shield
	[18500]={b=125360,s=31340,d=9823,c=AUCT_CLAS_ARMOR},  -- Tarnished Elven Ring
	[18501]={b=0,s=0,d=21472},  -- Felvine Shard
	[18502]={b=350636,s=70127,d=30836,c=AUCT_CLAS_WEAPON},  -- Monstrous Glaive
	[18503]={b=112609,s=22521,d=30837,c=AUCT_CLAS_ARMOR},  -- Kromcrush's Chestplate
	[18504]={b=70634,s=14126,d=30839,c=AUCT_CLAS_ARMOR},  -- Girdle of Insight
	[18505]={b=65383,s=13076,d=30838,c=AUCT_CLAS_ARMOR},  -- Mugger's Belt
	[18506]={b=106702,s=21340,d=9080,c=AUCT_CLAS_ARMOR},  -- Mongoose Boots
	[18507]={b=78460,s=15692,d=19921,c=AUCT_CLAS_ARMOR},  -- Boots of the Full Moon
	[18508]={b=85970,s=17194,d=30848,c=AUCT_CLAS_ARMOR},  -- Swift Flight Bracers
	[18509]={b=115033,s=23006,d=30849,c=AUCT_CLAS_ARMOR},  -- Chromatic Cloak
	[18510]={b=104449,s=20889,d=30850,c=AUCT_CLAS_ARMOR},  -- Hide of the Wild
	[18511]={b=104855,s=20971,d=30851,c=AUCT_CLAS_ARMOR},  -- Shifting Cloak
	[18512]={b=16000,s=4000,d=30852,x=5},  -- Larval Acid
	[18513]={b=0,s=0,d=20797,c=AUCT_CLAS_QUEST},  -- A Dull and Flat Elven Blade
	[18514]={b=60000,s=15000,d=6270},  -- Pattern: Girdle of Insight
	[18515]={b=60000,s=15000,d=6270},  -- Pattern: Mongoose Boots
	[18516]={b=60000,s=15000,d=6270},  -- Pattern: Swift Flight Bracers
	[18517]={b=160000,s=40000,d=1096},  -- Pattern: Chromatic Cloak
	[18518]={b=160000,s=40000,d=1096},  -- Pattern: Hide of the Wild
	[18519]={b=160000,s=40000,d=1096},  -- Pattern: Shifting Cloak
	[18520]={b=343264,s=68652,d=30853,c=AUCT_CLAS_WEAPON},  -- Barbarous Blade
	[18521]={b=88032,s=17606,d=30854,c=AUCT_CLAS_ARMOR},  -- Grimy Metal Boots
	[18522]={b=145013,s=36253,d=23897,c=AUCT_CLAS_ARMOR},  -- Band of the Ogre King
	[18523]={b=139243,s=34810,d=30855,c=AUCT_CLAS_WEAPON},  -- Brightly Glowing Stone
	[18524]={b=177982,s=35596,d=30857,c=AUCT_CLAS_ARMOR},  -- Leggings of Destruction
	[18525]={b=68652,s=13730,d=30859,c=AUCT_CLAS_ARMOR},  -- Bracers of Prosperity
	[18526]={b=89621,s=17924,d=30860,c=AUCT_CLAS_ARMOR},  -- Crown of the Ogre King
	[18527]={b=89941,s=17988,d=30862,c=AUCT_CLAS_ARMOR},  -- Harmonious Gauntlets
	[18528]={b=102326,s=20465,d=30864,c=AUCT_CLAS_ARMOR},  -- Cyclone Spaulders
	[18529]={b=49816,s=9963,d=30865,c=AUCT_CLAS_ARMOR},  -- Elemental Plate Girdle
	[18530]={b=156657,s=31331,d=30866,c=AUCT_CLAS_ARMOR},  -- Ogre Forged Hauberk
	[18531]={b=326918,s=65383,d=30867,c=AUCT_CLAS_WEAPON},  -- Unyielding Maul
	[18532]={b=108145,s=21629,d=30868,c=AUCT_CLAS_ARMOR},  -- Mindsurge Robe
	[18533]={b=54922,s=10984,d=30869,c=AUCT_CLAS_ARMOR},  -- Gordok Bracers of Power
	[18534]={b=357515,s=71503,d=30870,c=AUCT_CLAS_WEAPON},  -- Rod of the Ogre Magi
	[18535]={b=151155,s=30231,d=30872,c=AUCT_CLAS_WEAPON},  -- Milli's Shield
	[18536]={b=154658,s=38664,d=30875,c=AUCT_CLAS_WEAPON},  -- Milli's Lexicon
	[18537]={b=264540,s=66135,d=21072,c=AUCT_CLAS_ARMOR},  -- Counterattack Lodestone
	[18538]={b=483741,s=96748,d=30881,c=AUCT_CLAS_WEAPON},  -- Treant's Bane
	[18539]={b=0,s=0,d=18721},  -- Reliquary of Purity
	[18540]={b=0,s=0,d=18721},  -- Sealed Reliquary of Purity
	[18541]={b=165144,s=33028,d=30882,c=AUCT_CLAS_ARMOR},  -- Puissant Cape
	[18542]={b=626393,s=125278,d=30886,c=AUCT_CLAS_WEAPON},  -- Typhoon
	[18543]={b=254912,s=63728,d=30661,c=AUCT_CLAS_ARMOR},  -- Ring of Entropy
	[18544]={b=146060,s=29212,d=30893,c=AUCT_CLAS_ARMOR},  -- Doomhide Gauntlets
	[18545]={b=212731,s=42546,d=24615,c=AUCT_CLAS_ARMOR},  -- Leggings of Arcane Supremacy
	[18546]={b=240179,s=48035,d=30889,c=AUCT_CLAS_ARMOR},  -- Infernal Headcage
	[18547]={b=118096,s=23619,d=30894,c=AUCT_CLAS_ARMOR},  -- Unmelting Ice Girdle
	[18564]={b=0,s=0,d=30912},  -- Bindings of the Wind Seeker
	[18565]={b=59413,s=14853,d=9839,c=AUCT_CLAS_ARMOR},  -- Band of Allegiance
	[18566]={b=59413,s=14853,d=9823,c=AUCT_CLAS_ARMOR},  -- Lonetree's Circle
	[18585]={b=59413,s=14853,d=9839,c=AUCT_CLAS_ARMOR},  -- Band of Allegiance
	[18586]={b=59413,s=14853,d=9823,c=AUCT_CLAS_ARMOR},  -- Lonetree's Circle
	[18587]={b=8000,s=2000,d=31203,c=AUCT_CLAS_ARMOR},  -- Goblin Jumper Cables XL
	[18588]={b=800,s=200,d=18063,x=20},  -- Ez-Thro Dynamite II
	[18590]={b=0,s=0,d=15788,q=30,x=30},  -- Raging Beast's Blood
	[18591]={b=0,s=0,d=30952},  -- Case of Blood
	[18594]={b=12000,s=3000,d=30999,x=10},  -- Powerful Seaforium Charge
	[18597]={b=0,s=0,d=30959},  -- Orcish Orphan Whistle
	[18598]={b=0,s=0,d=30959},  -- Human Orphan Whistle
	[18600]={b=48000,s=12000,d=1103},  -- Tome of Arcane Brilliance
	[18601]={b=0,s=0,d=6689},  -- Glowing Crystal Prison
	[18602]={b=0,s=0,d=30875,c=AUCT_CLAS_WEAPON},  -- Tome of Sacrifice
	[18603]={b=0,s=0,d=3663,q=15,x=15},  -- Satyr Blood
	[18604]={b=0,s=0,d=6688,q=5,x=5},  -- Tears of the Hederine
	[18605]={b=0,s=0,d=6689},  -- Imprisoned Doomguard
	[18606]={b=50000,s=12500,d=31256},  -- Alliance Battle Standard
	[18607]={b=50000,s=12500,d=31257},  -- Horde Battle Standard
	[18608]={b=0,s=0,d=31347,c=AUCT_CLAS_WEAPON},  -- Benediction
	[18609]={b=0,s=0,d=31346,c=AUCT_CLAS_WEAPON},  -- Anathema
	[18610]={b=181,s=36,d=5139,c=AUCT_CLAS_WEAPON},  -- Keen Machete
	[18611]={b=139,s=27,d=9975,c=AUCT_CLAS_ARMOR},  -- Gnarlpine Leggings
	[18612]={b=171,s=34,d=6845,c=AUCT_CLAS_ARMOR},  -- Bloody Chain Boots
	[18622]={b=0,s=0,d=21072},  -- Flawless Fel Essence (Jaedenar)
	[18623]={b=0,s=0,d=21072},  -- Flawless Fel Essence (Dark Portal)
	[18624]={b=0,s=0,d=21072},  -- Flawless Fel Essence (Azshara)
	[18625]={b=0,s=0,d=8560},  -- Kroshius' Infernal Core
	[18626]={b=0,s=0,d=20874},  -- Fel Fire
	[18629]={b=500000,s=0,d=19239},  -- Black Lodestone
	[18631]={b=12000,s=3000,d=30995,x=10},  -- Truesilver Transformer
	[18632]={b=1000,s=50,d=16837,q=20,x=20},  -- Moonbrook Riot Taffy
	[18633]={b=125,s=6,d=30996,q=20,x=20},  -- Styleen's Sour Suckerpop
	[18634]={b=50000,s=12500,d=31199,c=AUCT_CLAS_ARMOR},  -- Gyrofreeze Ice Reflector
	[18635]={b=2000,s=100,d=30997,q=20,x=20},  -- Bellara's Nutterbar
	[18636]={b=400,s=100,d=7064},  -- Ruined Jumper Cables XL
	[18637]={b=2400,s=600,d=31204,c=AUCT_CLAS_ARMOR},  -- Major Recombobulator
	[18638]={b=50000,s=12500,d=31198,c=AUCT_CLAS_ARMOR},  -- Hyper-Radiant Flame Reflector
	[18639]={b=50000,s=12500,d=31200,c=AUCT_CLAS_ARMOR},  -- Ultra-Flash Shadow Reflector
	[18640]={b=0,s=0,d=24591,q=2,x=2},  -- Happy Fun Rock
	[18641]={b=2000,s=500,d=18062,x=20},  -- Dense Dynamite
	[18642]={b=0,s=0,d=8927},  -- Jaina's Autograph
	[18643]={b=0,s=0,d=7629},  -- Cairne's Hoofprint
	[18645]={b=6000,s=1500,d=31202},  -- Alarm-O-Bot
	[18646]={b=0,s=0,d=31029,c=AUCT_CLAS_ARMOR},  -- The Eye of Divinity
	[18647]={b=1800,s=450,d=1301},  -- Schematic: Red Firework
	[18648]={b=1800,s=450,d=1301},  -- Schematic: Green Firework
	[18649]={b=1800,s=450,d=1301},  -- Schematic: Blue Firework
	[18650]={b=5000,s=1250,d=1102},  -- Schematic: EZ-Thro Dynamite II
	[18651]={b=12000,s=3000,d=1102},  -- Schematic: Truesilver Transformer
	[18652]={b=12000,s=3000,d=1301},  -- Schematic: Gyrofreeze Ice Reflector
	[18653]={b=16000,s=4000,d=15274},  -- Schematic: Goblin Jumper Cables XL
	[18654]={b=16000,s=4000,d=15274},  -- Schematic: Gnomish Alarm-O-Bot
	[18655]={b=16000,s=4000,d=15274},  -- Schematic: Major Recombobulator
	[18656]={b=16000,s=4000,d=1301},  -- Schematic: Powerful Seaforium Charge
	[18657]={b=20000,s=5000,d=15274},  -- Schematic: Hyper-Radiant Flame Reflector
	[18658]={b=24000,s=6000,d=15274},  -- Schematic: Ultra-Flash Shadow Reflector
	[18659]={b=0,s=0,d=31034},  -- Splinter of Nordrassil
	[18660]={b=30000,s=7500,d=31205},  -- World Enlarger
	[18661]={b=12000,s=3000,d=15274},  -- Schematic: World Enlarger
	[18662]={b=20,s=5,d=31197,x=5},  -- Heavy Leather Ball
	[18663]={b=1500000,s=0,d=7155},  -- J'eevee's Jar
	[18664]={b=100,s=25,d=31095,c=AUCT_CLAS_WRITTEN},  -- A Treatise on Military Ranks
	[18665]={b=0,s=0,d=31096,c=AUCT_CLAS_ARMOR},  -- The Eye of Shadow
	[18670]={b=500000,s=0,d=2616},  -- Xorothian Glyphs
	[18671]={b=225923,s=45184,d=31119,c=AUCT_CLAS_WEAPON},  -- Baron Charr's Sceptre
	[18672]={b=71420,s=17855,d=31120,c=AUCT_CLAS_WEAPON},  -- Elemental Ember
	[18673]={b=144591,s=28918,d=31121,c=AUCT_CLAS_WEAPON},  -- Avalanchion's Stony Hide
	[18674]={b=88014,s=22003,d=9836,c=AUCT_CLAS_ARMOR},  -- Hardened Stone Band
	[18675]={b=100,s=25,d=4742,c=AUCT_CLAS_WRITTEN},  -- Military Ranks of the Horde & Alliance
	[18676]={b=80404,s=16080,d=31122,c=AUCT_CLAS_ARMOR},  -- Sash of the Windreaver
	[18677]={b=62439,s=12487,d=15148,c=AUCT_CLAS_ARMOR},  -- Zephyr Cloak
	[18678]={b=106541,s=26635,d=9853,c=AUCT_CLAS_ARMOR},  -- Tempestria's Frozen Necklace
	[18679]={b=100546,s=25136,d=28831,c=AUCT_CLAS_ARMOR},  -- Frigid Ring
	[18680]={b=189474,s=37894,d=30926,c=AUCT_CLAS_WEAPON},  -- Ancient Bone Bow
	[18681]={b=76079,s=15215,d=10177,c=AUCT_CLAS_ARMOR},  -- Burial Shawl
	[18682]={b=127282,s=25456,d=10006,c=AUCT_CLAS_ARMOR},  -- Ghoul Skin Leggings
	[18683]={b=255504,s=51100,d=31126,c=AUCT_CLAS_WEAPON},  -- Hammer of the Vesper
	[18684]={b=144564,s=36141,d=9840,c=AUCT_CLAS_ARMOR},  -- Dimly Opalescent Ring
	[18686]={b=122638,s=24527,d=31130,c=AUCT_CLAS_ARMOR},  -- Bone Golem Shoulders
	[18687]={b=1500000,s=0,d=13123},  -- Xorothian Stardust
	[18688]={b=0,s=0,d=7155},  -- Imp in a Jar
	[18689]={b=82301,s=16460,d=31131,c=AUCT_CLAS_ARMOR},  -- Phantasmal Cloak
	[18690]={b=110130,s=22026,d=25226,c=AUCT_CLAS_ARMOR},  -- Wraithplate Leggings
	[18691]={b=125601,s=31400,d=15420,c=AUCT_CLAS_ARMOR},  -- Dark Advisor's Pendant
	[18692]={b=71877,s=14375,d=31133,c=AUCT_CLAS_ARMOR},  -- Death Knight Sabatons
	[18693]={b=57127,s=11425,d=31136,c=AUCT_CLAS_ARMOR},  -- Shivery Handwraps
	[18694]={b=129554,s=25910,d=7002,c=AUCT_CLAS_ARMOR},  -- Shadowy Mail Greaves
	[18695]={b=137801,s=34450,d=31138,c=AUCT_CLAS_WEAPON},  -- Spellbound Tome
	[18696]={b=167382,s=33476,d=18790,c=AUCT_CLAS_WEAPON},  -- Intricately Runed Shield
	[18697]={b=54339,s=10867,d=31140,c=AUCT_CLAS_ARMOR},  -- Coldstone Slippers
	[18698]={b=71811,s=14362,d=21958,c=AUCT_CLAS_ARMOR},  -- Tattered Leather Hood
	[18699]={b=76119,s=15223,d=31142,c=AUCT_CLAS_ARMOR},  -- Icy Tomb Spaulders
	[18700]={b=54552,s=10910,d=27048,c=AUCT_CLAS_ARMOR},  -- Malefic Bracers
	[18701]={b=145640,s=36410,d=28733,c=AUCT_CLAS_ARMOR},  -- Innervating Band
	[18702]={b=47443,s=9488,d=31143,c=AUCT_CLAS_ARMOR},  -- Belt of the Ordained
	[18703]={b=0,s=0,d=31144,c=AUCT_CLAS_QUEST},  -- Ancient Petrified Leaf
	[18704]={b=0,s=0,d=31145},  -- Mature Blue Dragon Sinew
	[18705]={b=0,s=0,d=31146},  -- Mature Black Dragon Sinew
	[18706]={b=40124,s=10031,d=31147,c=AUCT_CLAS_ARMOR},  -- Arena Master
	[18707]={b=0,s=0,d=31148},  -- Ancient Rune Etched Stave
	[18708]={b=0,s=0,d=31150,c=AUCT_CLAS_WRITTEN},  -- Petrified Bark
	[18709]={b=28794,s=5758,d=31151,c=AUCT_CLAS_ARMOR},  -- Arena Wristguards
	[18710]={b=36122,s=7224,d=31159,c=AUCT_CLAS_ARMOR},  -- Arena Bracers
	[18711]={b=43502,s=8700,d=31160,c=AUCT_CLAS_ARMOR},  -- Arena Bands
	[18712]={b=29105,s=5821,d=31161,c=AUCT_CLAS_ARMOR},  -- Arena Vambraces
	[18713]={b=0,s=0,d=31338,c=AUCT_CLAS_WEAPON},  -- Rhok'delar, Longbow of the Ancient Keepers
	[18714]={b=0,s=0,d=31162,c=AUCT_CLAS_CONTAINER},  -- Ancient Sinew Wrapped Lamina
	[18715]={b=903890,s=180778,d=31163,c=AUCT_CLAS_WEAPON},  -- Lok'delar, Stave of the Ancient Keepers
	[18716]={b=93277,s=18655,d=31166,c=AUCT_CLAS_ARMOR},  -- Ash Covered Boots
	[18717]={b=344091,s=68818,d=23239,c=AUCT_CLAS_WEAPON},  -- Hammer of the Grand Crusader
	[18718]={b=82901,s=16580,d=31167,c=AUCT_CLAS_ARMOR},  -- Grand Crusader's Helm
	[18719]={b=0,s=0,d=3422},  -- The Traitor's Heart
	[18720]={b=83532,s=16706,d=13672,c=AUCT_CLAS_ARMOR},  -- Shroud of the Nathrezim
	[18721]={b=74724,s=14944,d=31171,c=AUCT_CLAS_ARMOR},  -- Barrage Girdle
	[18722]={b=53442,s=10688,d=31173,c=AUCT_CLAS_ARMOR},  -- Death Grips
	[18723]={b=167814,s=41953,d=6539,c=AUCT_CLAS_ARMOR},  -- Animated Chain Necklace
	[18724]={b=0,s=0,d=31146},  -- Enchanted Black Dragon Sinew
	[18725]={b=299636,s=59927,d=31174,c=AUCT_CLAS_WEAPON},  -- Peacemaker
	[18726]={b=56480,s=11296,d=31175,c=AUCT_CLAS_ARMOR},  -- Magistrate's Cuffs
	[18727]={b=72438,s=14487,d=31177,c=AUCT_CLAS_ARMOR},  -- Crimson Felt Hat
	[18728]={b=129865,s=32466,d=9657,c=AUCT_CLAS_ARMOR},  -- Anastari Heirloom
	[18729]={b=191512,s=38302,d=31240,c=AUCT_CLAS_WEAPON},  -- Screeching Bow
	[18730]={b=51254,s=10250,d=31180,c=AUCT_CLAS_ARMOR},  -- Shadowy Laced Handwraps
	[18731]={b=2000,s=500,d=1301},  -- Pattern: Heavy Leather Ball
	[18734]={b=85970,s=17194,d=31351,c=AUCT_CLAS_ARMOR},  -- Pale Moon Cloak
	[18735]={b=86266,s=17253,d=31188,c=AUCT_CLAS_ARMOR},  -- Maleki's Footwraps
	[18736]={b=130561,s=26112,d=16133,c=AUCT_CLAS_ARMOR},  -- Plaguehound Leggings
	[18737]={b=262137,s=52427,d=31189,c=AUCT_CLAS_WEAPON},  -- Bone Slicing Hatchet
	[18738]={b=187966,s=37593,d=31239,c=AUCT_CLAS_WEAPON},  -- Carapace Spine Crossbow
	[18739]={b=100624,s=20124,d=31191,c=AUCT_CLAS_ARMOR},  -- Chitinous Plate Legguards
	[18740]={b=50505,s=10101,d=31192,c=AUCT_CLAS_ARMOR},  -- Thuzadin Sash
	[18741]={b=49816,s=9963,d=31193,c=AUCT_CLAS_ARMOR},  -- Morlune's Bracer
	[18742]={b=107223,s=21444,d=31194,c=AUCT_CLAS_ARMOR},  -- Stratholme Militia Shoulderguard
	[18743]={b=67777,s=13555,d=15163,c=AUCT_CLAS_ARMOR},  -- Gracious Cape
	[18744]={b=56859,s=11371,d=31196,c=AUCT_CLAS_ARMOR},  -- Plaguebat Fur Gloves
	[18745]={b=81194,s=16238,d=2311,c=AUCT_CLAS_ARMOR},  -- Sacred Cloth Leggings
	[18746]={b=0,s=0,d=31208},  -- Divination Scryer
	[18749]={b=0,s=0,d=1695},  -- Charger's Lost Soul
	[18752]={b=0,s=0,d=31211},  -- Exorcism Censer
	[18753]={b=0,s=0,d=31212},  -- Arcanite Barding
	[18754]={b=52306,s=10461,d=31213,c=AUCT_CLAS_ARMOR},  -- Fel Hardened Bracers
	[18755]={b=215646,s=43129,d=31237,c=AUCT_CLAS_WEAPON},  -- Xorothian Firestick
	[18756]={b=167101,s=33420,d=31216,c=AUCT_CLAS_WEAPON},  -- Dreadguard's Protector
	[18757]={b=80813,s=16162,d=31217,c=AUCT_CLAS_ARMOR},  -- Diabolic Mantle
	[18758]={b=270363,s=54072,d=20574,c=AUCT_CLAS_WEAPON},  -- Specter's Blade
	[18759]={b=339223,s=67844,d=31219,c=AUCT_CLAS_WEAPON},  -- Malicious Axe
	[18760]={b=123465,s=30866,d=9839,c=AUCT_CLAS_ARMOR},  -- Necromantic Band
	[18761]={b=196150,s=39230,d=31220,c=AUCT_CLAS_WEAPON},  -- Oblivion's Touch
	[18762]={b=110526,s=27631,d=31223,c=AUCT_CLAS_WEAPON},  -- Shard of the Green Flame
	[18766]={b=10000000,s=0,d=17608},  -- Reins of the Swift Frostsaber
	[18767]={b=10000000,s=0,d=17608},  -- Reins of the Swift Mistsaber
	[18769]={b=0,s=0,d=7139,c=AUCT_CLAS_QUEST},  -- Advanced Armorsmithing I - Enchanted Thorium Platemail
	[18770]={b=0,s=0,d=7139,c=AUCT_CLAS_QUEST},  -- Advanced Armorsmithing II - Enchanted Thorium Platemail
	[18771]={b=0,s=0,d=7139,c=AUCT_CLAS_QUEST},  -- Advanced Armorsmithing III - Enchanted Thorium Platemail
	[18772]={b=10000000,s=0,d=17785},  -- Swift Green Mechanostrider
	[18773]={b=10000000,s=0,d=17785},  -- Swift White Mechanostrider
	[18774]={b=10000000,s=0,d=17785},  -- Swift Yellow Mechanostrider
	[18775]={b=0,s=0,d=7087},  -- Manna-Enriched Horse Feed
	[18776]={b=10000000,s=0,d=25132},  -- Swift Palomino
	[18777]={b=10000000,s=0,d=25132},  -- Swift Brown Steed
	[18778]={b=10000000,s=0,d=25132},  -- Swift White Steed
	[18779]={b=0,s=0,d=24153},  -- Bottom Half of Advanced Armorsmithing: Volume I
	[18780]={b=0,s=0,d=24153},  -- Top Half of Advanced Armorsmithing: Volume I
	[18781]={b=0,s=0,d=31238},  -- Bottom Half of Advanced Armorsmithing: Volume II
	[18782]={b=0,s=0,d=31238},  -- Top Half of Advanced Armorsmithing: Volume II
	[18783]={b=0,s=0,d=8628},  -- Bottom Half of Advanced Armorsmithing: Volume III
	[18784]={b=0,s=0,d=8628},  -- Top Half of Advanced Armorsmithing: Volume III
	[18785]={b=10000000,s=0,d=17343},  -- Swift White Ram
	[18786]={b=10000000,s=0,d=17343},  -- Swift Brown Ram
	[18787]={b=10000000,s=0,d=17343},  -- Swift Gray Ram
	[18788]={b=10000000,s=0,d=17494},  -- Swift Blue Raptor
	[18789]={b=10000000,s=0,d=17494},  -- Swift Green Raptor
	[18790]={b=10000000,s=0,d=17494},  -- Swift Orange Raptor
	[18791]={b=10000000,s=0,d=17786},  -- Purple Skeletal Warhorse
	[18792]={b=0,s=0,d=31350},  -- Blessed Arcanite Barding
	[18793]={b=10000000,s=0,d=29448},  -- Great White Kodo
	[18794]={b=10000000,s=0,d=29447},  -- Great Brown Kodo
	[18795]={b=10000000,s=0,d=29448},  -- Great Gray Kodo
	[18796]={b=10000000,s=0,d=16208},  -- Horn of the Swift Brown Wolf
	[18797]={b=10000000,s=0,d=16207},  -- Horn of the Swift Timber Wolf
	[18798]={b=10000000,s=0,d=16207},  -- Horn of the Swift Gray Wolf
	[18799]={b=0,s=0,d=6014},  -- Charger's Redeemed Soul
	[18802]={b=60000,s=5000,d=16325,q=5,x=5,c=AUCT_CLAS_POTION},  -- Shadowy Potion
	[18803]={b=677972,s=135594,d=31265,c=AUCT_CLAS_WEAPON},  -- Finkle's Lava Dredger
	[18804]={b=0,s=0,d=6430},  -- Lord Grayson's Satchel
	[18805]={b=546375,s=109275,d=31266,c=AUCT_CLAS_WEAPON},  -- Core Hound Tooth
	[18806]={b=168806,s=33761,d=31271,c=AUCT_CLAS_ARMOR},  -- Core Forged Greaves
	[18807]={b=128980,s=25796,d=31268,c=AUCT_CLAS_ARMOR},  -- Helm of Latent Power
	[18808]={b=113326,s=22665,d=31276,c=AUCT_CLAS_ARMOR},  -- Gloves of the Hypnotic Flame
	[18809]={b=108057,s=21611,d=31278,c=AUCT_CLAS_ARMOR},  -- Sash of Whispered Secrets
	[18810]={b=203394,s=40678,d=16526,c=AUCT_CLAS_ARMOR},  -- Wild Growth Spaulders
	[18811]={b=163328,s=32665,d=24159,c=AUCT_CLAS_ARMOR},  -- Fireproof Cloak
	[18812]={b=162290,s=32458,d=31280,c=AUCT_CLAS_ARMOR},  -- Wristguards of True Flight
	[18813]={b=0,s=0,d=9823,c=AUCT_CLAS_ARMOR},  -- Ring of Binding
	[18814]={b=0,s=0,d=1399,c=AUCT_CLAS_ARMOR},  -- Choker of the Fire Lord
	[18815]={b=256380,s=64095,d=31282,c=AUCT_CLAS_ARMOR},  -- Essence of the Pure Flame
	[18817]={b=319878,s=63975,d=31286,c=AUCT_CLAS_ARMOR},  -- Crown of Destruction
	[18818]={b=0,s=0,d=8093,c=AUCT_CLAS_WRITTEN},  -- Mor'zul's Instructions
	[18819]={b=0,s=0,d=31211},  -- Rohan's Exorcism Censer
	[18820]={b=0,s=0,d=31287,c=AUCT_CLAS_ARMOR},  -- Talisman of Ephemeral Power
	[18821]={b=256120,s=64030,d=9835,c=AUCT_CLAS_ARMOR},  -- Quick Strike Ring
	[18822]={b=628843,s=125768,d=31288,c=AUCT_CLAS_WEAPON},  -- Obsidian Edged Blade
	[18823]={b=132532,s=26506,d=31290,c=AUCT_CLAS_ARMOR},  -- Aged Core Leather Gloves
	[18824]={b=167591,s=33518,d=31295,c=AUCT_CLAS_ARMOR},  -- Magma Tempered Boots
	[18825]={b=84340,s=16868,d=11257,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Aegis
	[18826]={b=84632,s=16926,d=23825,c=AUCT_CLAS_WEAPON},  -- High Warlord's Shield Wall
	[18827]={b=153626,s=30725,d=31299,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Handaxe
	[18828]={b=154170,s=30834,d=31300,c=AUCT_CLAS_WEAPON},  -- High Warlord's Cleaver
	[18829]={b=244517,s=48903,d=31298,c=AUCT_CLAS_ARMOR},  -- Deep Earth Spaulders
	[18830]={b=175663,s=35132,d=31302,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Sunderer
	[18831]={b=176343,s=35268,d=31303,c=AUCT_CLAS_WEAPON},  -- High Warlord's Battle Axe
	[18832]={b=520447,s=104089,d=31309,c=AUCT_CLAS_WEAPON},  -- Brutality Blade
	[18833]={b=106610,s=21322,d=31307,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Bullseye
	[18834]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18835]={b=107426,s=21485,d=30926,c=AUCT_CLAS_WEAPON},  -- High Warlord's Recurve
	[18836]={b=107834,s=21566,d=22929,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Repeater
	[18837]={b=108231,s=21646,d=31310,c=AUCT_CLAS_WEAPON},  -- High Warlord's Crossbow
	[18838]={b=148747,s=29749,d=31311,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Dirk
	[18839]={b=1000,s=250,d=29352,x=5,c=AUCT_CLAS_POTION},  -- Combat Healing Potion
	[18840]={b=149834,s=29966,d=31312,c=AUCT_CLAS_WEAPON},  -- High Warlord's Razor
	[18841]={b=1100,s=275,d=29354,x=5,u=AUCT_TYPE_TAILOR},  -- Combat Mana Potion
	[18842]={b=693232,s=138646,d=20298,c=AUCT_CLAS_WEAPON},  -- Staff of Dominance
	[18843]={b=151451,s=30290,d=31314,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Right Knuckles
	[18844]={b=151995,s=30399,d=31315,c=AUCT_CLAS_WEAPON},  -- High Warlord's Right Claw
	[18845]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18846]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18847]={b=153612,s=30722,d=31316,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Left Knuckles
	[18848]={b=154141,s=30828,d=31317,c=AUCT_CLAS_WEAPON},  -- High Warlord's Left Claw
	[18849]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18850]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18851]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18852]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18853]={b=15000,s=3750,d=31306,c=AUCT_CLAS_ARMOR},  -- Insignia of the Horde
	[18854]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18855]={b=110336,s=22067,d=28769,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Hand Cannon
	[18856]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18857]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18858]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18859]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18860]={b=112353,s=22470,d=31319,c=AUCT_CLAS_WEAPON},  -- High Warlord's Street Sweeper
	[18861]={b=142467,s=28493,d=31320,c=AUCT_CLAS_ARMOR},  -- Flamewaker Legplates
	[18862]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18863]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18864]={b=15000,s=3750,d=31318,c=AUCT_CLAS_ARMOR},  -- Insignia of the Alliance
	[18865]={b=152509,s=30501,d=19713,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Punisher
	[18866]={b=153053,s=30610,d=31321,c=AUCT_CLAS_WEAPON},  -- High Warlord's Bludgeon
	[18867]={b=191978,s=38395,d=31322,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Battle Hammer
	[18868]={b=192658,s=38531,d=31323,c=AUCT_CLAS_WEAPON},  -- High Warlord's Pulverizer
	[18869]={b=174946,s=34989,d=18306,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Glaive
	[18870]={b=156920,s=31384,d=31327,c=AUCT_CLAS_ARMOR},  -- Helm of the Lifegiver
	[18871]={b=181156,s=36231,d=31328,c=AUCT_CLAS_WEAPON},  -- High Warlord's Pig Sticker
	[18872]={b=151971,s=30394,d=31331,c=AUCT_CLAS_ARMOR},  -- Manastorm Leggings
	[18873]={b=182516,s=36503,d=31330,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Stave
	[18874]={b=183196,s=36639,d=31332,c=AUCT_CLAS_WEAPON},  -- High Warlord's War Staff
	[18875]={b=192227,s=38445,d=31333,c=AUCT_CLAS_ARMOR},  -- Salamander Scale Pants
	[18876]={b=184537,s=36907,d=20166,c=AUCT_CLAS_WEAPON},  -- Grand Marshal's Claymore
	[18877]={b=185217,s=37043,d=31334,c=AUCT_CLAS_WEAPON},  -- High Warlord's Greatsword
	[18878]={b=428226,s=85645,d=31337,c=AUCT_CLAS_WEAPON},  -- Sorcerous Dagger
	[18879]={b=213456,s=53364,d=9836,c=AUCT_CLAS_ARMOR},  -- Heavy Dark Iron Ring
	[18880]={b=0,s=0,d=14023},  -- Darkreaver's Head
	[18902]={b=10000000,s=0,d=17608},  -- Reins of the Swift Stormsaber
	[18922]={b=0,s=0,d=7235},  -- Simone's Head
	[18923]={b=0,s=0,d=31353},  -- Klinfran's Head
	[18924]={b=0,s=0,d=31353},  -- Solenor's Head
	[18925]={b=0,s=0,d=31353},  -- Artorius's Head
};
end

Auctioneer_BuildBaseData();

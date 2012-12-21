--
-- AutoBar
-- Item List Database
--
--  Author: Marc aka Saien on Hyjal
--  WOWSaien@gmail.com
--  http://64.168.251.69/wow
--

local ALTERACVALLEY = "Alterac Valley";
local WARSONGGULCH = "Warsong Gulch";
local ARATHIBASIN = "Arathi Basin";

if (GetLocale() == "frFR") then
	ALTERACVALLEY = "Vall\195\169e d'Alterac";
	WARSONGGULCH = "Goulet des Warsong";
	ARATHIBASIN = "Bassin d'Arathi";
elseif (GetLocale() == "deDE") then
	ALTERACVALLEY = "Alteractal";
	WARSONGGULCH = "Warsongschlucht";
	ARATHIBASIN = "Arathibecken";
elseif ( GetLocale() == "zhCN" ) then
elseif ( GetLocale() == "zhTW" ) then
end

AutoBar_Category_Info = { -- global
	["BANDAGES"] = {
		["description"] = "Bandages";
		["texture"] = "INV_Misc_Bandage_15";
		["targetted"] = true;
		["smarttarget"] = true;
	},
	["ALTERAC_BANDAGES"] = {
		["description"] = "Alterac Bandages";
		["texture"] = "INV_Misc_Bandage_12";
		["targetted"] = true;
		["location"] = ALTERACVALLEY;
		["smarttarget"] = true;
		["items"] = { 19307 },
	},
	["WARSONG_BANDAGES"] = {
		["description"] = "Warsong Bandages";
		["texture"] = "INV_Misc_Bandage_12";
		["targetted"] = true;
		["location"] = WARSONGGULCH;
		["smarttarget"] = true;
	},
	["ARATHI_BANDAGES"] = {
		["description"] = "Arathi Bandages";
		["texture"] = "INV_Misc_Bandage_12";
		["targetted"] = true;
		["location"] = ARATHIBASIN;
		["smarttarget"] = true;
	},
	["UNGORO_RESTORE"] = {
		["description"] = "Un'Goro: Crystal Restore";
		["texture"] = "INV_Misc_Gem_Diamond_02";
		["combatonly"] = true;
		["targetted"] = true;
		["smarttarget"] = true;
		["limit"] = { ["downhp"] = { 670 } },
		["items"] = { 11562 },
	},
	----------------
	["HEALPOTIONS"] = {
		["description"] = "Heal Potions";
		["texture"] = "INV_Potion_49";
		["limit"] = { ["downhp"] = { 70, 140, 140, 280, 455, 700, 1050} },
	},
	["PVP_HEALPOTIONS"] = {
		["description"] = "PVP Rank 6 - Heal Potions";
		["texture"] = "INV_Potion_39";
		["items"]  = { 18839 },
		["limit"] = { ["downhp"] = { 900 } },
	},
	["HEALTHSTONE"] = {
		["description"] = "Healthstones";
		["texture"] = "INV_Stone_04";
	},
	["WHIPPER_ROOT"] = {
		["description"] = "Whipper Root";
		["texture"] = "INV_Misc_Food_55";
		["items"] = { 11951 },
		["limit"] = { ["downhp"] = { 700 } },
	},
	["ALTERAC_HEAL"] = {
		["description"] = "Alterac Heal Potions";
		["texture"] = "INV_Potion_39";
		["location"] = ALTERACVALLEY;
		["items"] = {
			17349,	-- Superior Healing Draught
			17348,	-- Major Healing Draught
		},
	},
	----------------
	["PVP_MANAPOTIONS"] = {
		["description"] = "PVP Rank 6 - Mana Potions";
		["texture"] = "INV_Potion_81";
		["items"]  = { 18841 },
		["limit"] = { ["downmana"] = { 900 }, },
	},
	["MANAPOTIONS"] = {
		["description"] = "Mana Potions";
		["texture"] = "INV_Potion_70";
		["limit"] = { ["downmana"] = { 140, 280, 455, 700, 900, 1350} },
	},
	["MANASTONE"] = {
		["description"] = "Manastones";
		["texture"] = "INV_Misc_Gem_Emerald_01";
	},
	["ALTERAC_MANA"] = {
		["description"] = "Alterac Mana Potions";
		["texture"] = "INV_Potion_81";
		["location"] = ALTERACVALLEY;
		["items"] = {
			17352,	-- Superior Mana Draught
			17351,	-- Major Mana Draught
		},
	},
	----------------
	["NIGHT_DRAGONS_BREATH"] = {
		["description"] = "Night Dragon's Breath";
		["texture"] = "INV_Misc_Food_45";
		["limit"] = { ["downhp"] = { 456 }, ["downmana"] = { 456 }, },
		["items"] = { 11952 },
	},
	["REJUVENATION_POTIONS"] = {
		["description"] = "Rejuvenation Potions";
		["texture"] = "INV_Potion_47";
		["items"] = {
			2456,	-- Minor Rejuvenation Potion
			18253,	-- Major Rejuvenation Potion
		},
		["limit"] = { ["downhp"] = { 150, 1760 }, ["downmana"] = { 150, 1760 }, },
	},
	----------------
	["HEARTHSTONE"] = {
		["description"] = "Hearthstone";
		["texture"] = "INV_Misc_Rune_01";
		["items"] = { 6948 },
	},
	["WATER"] = {
		["description"] = "Water";
		["texture"] = "INV_Drink_10";
		["noncombat"] = true,
	},
	["WATER_CONJURED"] = {
		["description"] = "Water: Mage Conjured";
		["texture"] = "INV_Drink_10";
		["noncombat"] = true,
	},
	["RAGEPOTIONS"] = {
		["description"] = "Rage Potions";
		["texture"] = "INV_Potion_24";
	},
	["ENERGYPOTIONS"] = {
		["description"] = "Energy Potions";
		["texture"] = "INV_Drink_Milk_05";
		["items"] = { 7676 },
	},
	["SWIFTNESSPOTIONS"] = {
		["description"] = "Swiftness Potions";
		["texture"] = "INV_Potion_95";
		["items"] = { 2459 },
	},
	["SOULSHARDS"] = {
		["description"] = "Soul Shards";
		["texture"] = "INV_Misc_Gem_Amethyst_02";
		["notusable"] = true;
		["items"] = { 6265 },
	},
	--------------
	["ARROWS"] = {
		["description"] = "Arrows";
		["texture"] = "INV_Ammo_Arrow_02";
		["notusable"] = true;
	},
	["BULLETS"] = {
		["description"] = "Bullets";
		["texture"] = "INV_Ammo_Bullet_02";
		["notusable"] = true;
	},
	["THROWN"] = {
		["description"] = "Thrown Weapons";
		["texture"] = "INV_Axe_19";
		["notusable"] = true;
	},
	--------------
	["FOOD"] = {
		["description"] = "Food: No Bonus";
		["texture"] = "INV_Misc_Food_14";
		["noncombat"] = true,
	},
	["FOOD_WATER"] = {
		["description"] = "Food & Water Combo";
		["texture"] = "INV_Misc_Food_33";
		["noncombat"] = true,
		["items"] = { 13724, 19301 }
	},
	["FOOD_CONJURED"] = {
		["description"] = "Food: Mage Conjured";
		["texture"] = "INV_Misc_Food_10";
		["noncombat"] = true,
	},
	["FOOD_STAMINA"] = {
		["description"] = "Food: Stamina Bonus";
		["texture"] = "INV_Egg_03";
		["noncombat"] = true,
	},
	["FOOD_AGILITY"] = {
		["description"] = "Food: Agility Bonus";
		["texture"] = "INV_Misc_Fish_13";
		["noncombat"] = true,
	},
	["FOOD_MANAREGEN"] = {
		["description"] = "Food: Mana Regen Bonus";
		["texture"] = "INV_Misc_Food_14";
		["noncombat"] = true,
	},
	["FOOD_HPREGEN"] = {
		["description"] = "Food: HP Regen Bonus";
		["texture"] = "INV_Misc_Fish_19";
		["noncombat"] = true,
	},
	["FOOD_STRENGTH"] = {
		["description"] = "Food: Strength Bonus";
		["texture"] = "INV_Misc_Food_64";
		["noncombat"] = true,
	},
	["FOOD_INTELLIGENCE"] = {
		["description"] = "Food: Intelligence Bonus";
		["texture"] = "INV_Misc_Food_63";
		["noncombat"] = true,
	},
	["FOOD_ARATHI"] = {
		["description"] = "Food: Arathi Basin";
		["texture"] = "INV_Misc_Food_33";
		["noncombat"] = true,
		["location"] = ARATHIBASIN;
		["items"] = { 20062 },
	},
	["FOOD_WARSONG"] = {
		["description"] = "Food: Warsong Gulch";
		["texture"] = "INV_Misc_Food_33";
		["noncombat"] = true,
		["location"] = WARSONGGULCH;
		["items"] = { 19062, 19061, 19060 },
	},
	--------------
	["SHARPENINGSTONES"] = {
		["description"] = "Blacksmith created Sharpening stones";
		["texture"] = "INV_Stone_SharpeningStone_01";
		["targetted"] = "WEAPON";
	},
	["WEIGHTSTONE"] = {
		["description"] = "Blacksmith created Weight stones";
		["texture"] = "INV_Stone_WeightStone_02";
		["targetted"] = "WEAPON";
	},
	--------------
	["POISON-CRIPPLING"] = {
		["description"] = "Crippling Poison";
		["texture"] = "INV_Potion_19";
		["targetted"] = "WEAPON";
	},
	["POISON-DEADLY"] = {
		["description"] = "Deadly Poison";
		["texture"] = "Ability_Rogue_DualWeild";
		["targetted"] = "WEAPON";
	},
	["POISON-INSTANT"] = {
		["description"] = "Instant Poison";
		["texture"] = "Ability_Poisons";
		["targetted"] = "WEAPON";
	},
	["POISON-MINDNUMBING"] = {
		["description"] = "Mind-Numbing Poison";
		["texture"] = "Spell_Nature_NullifyDisease";
		["targetted"] = "WEAPON";
	},
	["POISON-WOUND"] = {
		["description"] = "Wounding Poison";
		["texture"] = "Ability_PoisonSting";
		["targetted"] = "WEAPON";
	},
	--------------
	["EXPLOSIVES"] = {
		["description"] = "Engineering Explosives";
		["texture"] = "INV_Misc_Bomb_08";
		["nosmartcast"] = true;
		["targetted"] = true;
	},
	--------------
	["MOUNTS_TROLL"] = {
		["description"] = "Mount: Troll - Raptor";
		["texture"] = "Ability_Mount_Raptor";
		["noncombat"] = true,
	},
	["MOUNTS_ORC"] = {
		["description"] = "Mount: Orc - Wolf";
		["texture"] = "Ability_Mount_BlackDireWolf",
		["noncombat"] = true,
	},
	["MOUNTS_UNDEAD"] = {
		["description"] = "Mount: Undead - Skeletal Horse";
		["texture"] = "Ability_Mount_Undeadhorse";
		["noncombat"] = true,
	},
	["MOUNTS_TAUREN"] = {
		["description"] = "Mount: Tauren - Kodo";
		["texture"] = "Ability_Mount_Kodo_01";
		["noncombat"] = true,
	},
	["MOUNTS_HUMAN"] = {
		["description"] = "Mount: Human - Horse";
		["texture"] = "Ability_Mount_NightmareHorse";
		["noncombat"] = true,
	},
	["MOUNTS_NIGHTELF"] = {
		["description"] = "Mount: Night Elf - Tiger";
		["texture"] = "Ability_Mount_BlackPanther";
		["noncombat"] = true,
	},
	["MOUNTS_DWARF"] = {
		["description"] = "Mount: Dwarf - Ram";
		["texture"] = "Ability_Mount_MountainRam";
		["noncombat"] = true,
	},
	["MOUNTS_GNOME"] = {
		["description"] = "Mount: Gnome - Strider";
		["texture"] = "Ability_Mount_MechaStrider";
		["noncombat"] = true,
	},
	["MOUNTS_SPECIAL"] = {
		["description"] = "Mount: Special";
		["texture"] = "Ability_Mount_JungleTiger";
		["noncombat"] = true,
	},
	--------------
	["MANA_OIL"] = {
		["texture"] = "INV_Misc_Gem_Emerald_01";
		["targetted"] = "WEAPON";
		["description"] = "Enchantment Oil: Mana Regen";
	},
	["WIZARD_OIL"] = {
		["texture"] = "INV_Potion_100";
		["targetted"] = "WEAPON";
		["description"] = "Enchantment Oil: Damage/Healing Bonus";
	},
	["FISHINGITEMS"] = {
		["texture"] = "INV_Misc_Food_26",
		["targetted"] = "WEAPON",
		["description"] = "Fishing Items",
		["items"] = {
        		6529, -- Shiny Bauble
		        6530, -- Nightcrawlers
			6811, -- Aquadynamic Fish Lens
		        6532, -- Bright Baubles
		        6533, -- Aquadynamic Fish Attractors
		},
	},
};

AutoBar_Category_Info["BANDAGES"].items = {
		1251,	-- Linen Bandage
		2581,	-- Heavy Linen Bandage
		3530,	-- Wool Bandage
		3531,	-- Heavy Wool Bandage
		6450,	-- Silk Bandage
		6451,	-- Heavy Silk Bandage
		8544,	-- Mageweave Bandage
		8545,	-- Heavy Mageweave Bandage
		14529,	-- Runecloth Bandage
		14530,	-- Heavy Runecloth Bandage
};
AutoBar_Category_Info["HEALPOTIONS"].items = {
		118,	-- Minor Healing Potion
		858,	-- Lesser Healing Potion
		4596,	-- Discolored Healing Potion
		929,	-- Healing Potion
		1710,	-- Greater Healing Potion
		3928,	-- Superior Healing Potion
		13446,	-- Major Healing Potion
};
AutoBar_Category_Info["MANAPOTIONS"].items = {
		2455,	-- Minor Mana Potion
		3385,	-- Lesser Mana Potion
		3827,	-- Mana Potion
		6149,	-- Greater Mana Potion
		13443,	-- Superior Mana Potion
		13444,	-- Major Mana Potion
};
AutoBar_Category_Info["HEALTHSTONE"].items = {
		5512,	-- Minor Healthstone
		19004,	-- 1pt Talent improved Minor Healthstone
		19005,	-- 2pt Talent improved Minor Healthstone
		5511,	-- Lesser Healthstone
		19006,	-- Talent improved Lesser Healthstone
		19007,	-- 1pt 2pt Talent improved Lesser Healthstone
		5509,	-- Healthstone
		19008,	-- 1pt Talent improved Healthstone
		19009,	-- 2pt Talent improved Healthstone
		5510,	-- Greater Healthstone
		19010,	-- 1pt Talent improved Greater Healthstone
		19011,	-- 2pt Talent improved Greater Healthstone
		9421,	-- Major Healthstone
		19012,	-- 1pt Talent improved Major Healthstone
		19013,	-- 2pt Talent improved Major Healthstone
};
AutoBar_Category_Info["MANASTONE"].items = {
		5514,	-- Mana Agate
		5513,	-- Mana Jade
		8007,	-- Mana Citrine
		8008,	-- Mana Ruby
};
AutoBar_Category_Info["WATER"].items = {
		19997,	-- Harvest Nectar
		159,	-- Refreshing Spring Water
		1179,	-- Ice Cold Milk
		1205,	-- Melon Juice
		9451,	-- Bubbling Water
		1708,	-- Sweet Nectar
		4791,	-- Enchanted Water
		10841,	-- Goldthorn Tea
		1645,	-- Moonberry Juice
		8766,	-- Morning Glory Dew
		19318,	-- Bottled Alterac Spring Water
};
AutoBar_Category_Info["WATER_CONJURED"].items = {
		5350,	-- Conjured Water
		2288,	-- Conjured Fresh Water
		2136,	-- Conjured Purified Water
		3772,	-- Conjured Spring Water
		8077,	-- Conjured Mineral Water
		8078,	-- Conjured Sparkling Water
		8079,	-- Conjured Crystal Water
};
AutoBar_Category_Info["RAGEPOTIONS"].items = {
		5631,	-- Rage Potion
		5633,	-- Great Rage Potion
		13442,	-- Mighty Rage Potion
};
AutoBar_Category_Info["BULLETS"].items = {
		2516,	-- Light Shot
		4960,	-- Flash Pellet 
		8067,	-- Crafted Light Shot
		2519,	-- Heavy Shot
		5568,	-- Smooth Pebble
		8068,	-- Crafted Heavy Shot
		3033,	-- Solid Shot
		8069,	-- Crafted Solid Shot
		3465,	-- Exploding Shot
		10512,	-- Hi-Impact Mithril Slugs
		11284,	-- Accurate Slugs
		10513,	-- Mithril Gyro-Shot
		11630,	-- Rockshard Pellets
		15997,	-- Thorium Shells
		13377,	-- Minature Cannon Balls
};
AutoBar_Category_Info["ARROWS"].items = {
		2512,	-- Rough Arrow
		2515,	-- Sharp Arrow
		3030,	-- Razor Arrow
		3464,	-- Feathered Arrow
		9399,	-- Precision Arrow
		11285,	-- Jagged Arrow
		18042,	-- Thorium Headed Arrow
		12654 ,	-- Doomshot
};	
AutoBar_Category_Info["THROWN"].items = {
		3111,	-- Crude Throwing Axe
		3463,	-- Silver Star
		2947,	-- Small Throwing Knife
		2946,	-- Balanced Throwing Dagger
		5379,	-- Boot Knife
		3131,	-- Weighted Throwing Axe
		4959,	-- Throwing Tomahawk
		3107,	-- Keen Throwing Knife
		3135,	-- Sharp Throwing Axe
		3137,	-- Deadly Throwing Axe
		3108,	-- Heavy Throwing Dagger
		15326,	-- Gleaming Throwing Axe
		15327,	-- Wicked Throwing Dagger
		13173,	-- Flightblade Throwing Axe
};
AutoBar_Category_Info["FOOD_CONJURED"].items = {
		5349,	-- Conjured Muffin		-- Mage    - Level 1, heals 61
		1113,	-- Conjured Bread		-- Mage    - Level 5, heals 243
		1114,	-- Conjured Rye 		-- Mage    - Level 15, heals 552
		1487,	-- Conjured Pumpernickel 	-- Mage    - Level 25, heals 874
		8075,	-- Conjured Sourdough		-- Mage    - Level 35, heals 1392
		8076,	-- Conjured Sweet Roll		-- Mage    - Level 45, heals 2148
};
AutoBar_Category_Info["FOOD"].items = {
		2070,	-- Darnassian Bleu		-- Vendor  - Level 1, heals 61
		4540,	-- Tough Hunk of Bread		-- Vendor  - Level 1, heals 61
		4536,	-- Shiny Red Apple		-- Vendor  - Level 1, heals 61
		117,	-- Tough Jerky			-- Vendor  - Level 1, heals 61
		4604,	-- Forest Mushroom Cap		-- Vendor  - Level 1, heals 61
		16166,	-- Bean Soup			-- Vendor  - Level 1, heals 61
		9681,	-- Charred Wolf Meat		-- Cooking - Level 1, heals 61
		2681,	-- Roasted Boar Meat		-- Cooking - Level 1, heals 61
		787,	-- Slitherskin Mackerel		-- Cooking - Level 1, heals 61
		6290,	-- Brilliant Smallfish		-- Cooking - Level 1, heals 61
		2680,	-- Spiced Wolf Meat		-- Cooking
		16167,	-- Versicolor Treat		-- Vendor - Level 5, heals 243 
		4605,	-- Red-speckled Mushroom	-- Vendor  - Level 5, heals 243
		2287,	-- Haunch of Meat		-- Vendor  - Level 5, heals 243
		4537,	-- Tel'Abim Banana		-- Vendor  - Level 5, heals 243
		414,	-- Dalaran Sharp		-- Vendor  - Level 5, heals 243
		4541,	-- Freshly Baked Bread		-- Vendor  - Level 5, heals 243
		6890,	-- Smoked Bear Meat		-- Cooking - Level 5, heals 243
		6316,	-- Loch Frenzy Delight		-- Cooking - Level 5, heals 243 
		5095,	-- Rainbow Fin Albacore		-- Cooking - Level 5, heals 243
		4592,	-- Longjaw Mud Snapper		-- Cooking - Level 5, heals 243
		2683,	-- Crab Cake			-- Cooking
		2684,	-- Coyote Steak			-- Cooking
		5525,	-- Boiled Clams			-- Cooking
		5473,	-- Scorpid Surprise		-- Cooking - Level 1, heals 294
		2682,	-- Cooked Crab Claw		-- Cooking - Level 5, heals 294
		733,	-- Westfall Stew		-- Cooking - Level 5, heals 552
		422,	-- Dwarven Mild			-- Vendor  - Level 15, heals 552
		4542,	-- Moist Cornbread		-- Vendor  - Level 15, heals 552
		4538,	-- Snapvine Watermelon		-- Vendor  - Level 15, heals 552
		3770,	-- Mutton Chop			-- Vendor  - Level 15, heals 552
		4606,	-- Spongy Morel			-- Vendor  - Level 15, heals 552
		16170,	-- Steamed Mandu		-- Vendor  - Level 15, heals 552
		5526,	-- Clam Chowder			-- Cooking - Level 10, heals 552
		5478,	-- Dig Rat Stew			-- Cooking - Level 10, heals 552
		2685,	-- Succulent Pork Ribs		-- Cooking - Level 10, heals 552 
		4593,	-- Bristle Whisker Catfish 	-- Cooking - Level 15, heals 552
		4594,	-- Rockscale Cod		-- Cooking - Level 25, heals 874
		8364,	-- Mithril Head Trout 		-- Cooking - Level 25, heals 874
		16169,	-- Wild Ricecake		-- Vendor  - Level 25, heals 874
		4607,	-- Delicious Cave Mold		-- Vendor  - Level 25, heals 874
		3771,	-- Wild Hog Shank 		-- Vendor  - Level 25, heals 874
		4539,	-- Goldenbark Apple 		-- Vendor  - Level 25, heals 874
		4544,	-- Mulgore Spice Bread 		-- Vendor  - Level 25, heals 874
		1707,	-- Stormwind Brie 		-- Vendor  - Level 25, heals 874
		13546,	-- Bloodbelly Fish		-- Quest   - Level 25, heals 1392
		3927,	-- Fine Aged Cheddar		-- Vendor  - Level 35, heals 1392
		4601,	-- Soft Banana Bread		-- Vendor  - Level 35, heals 1392
		4602,	-- Moon Harvest Pumpkin		-- Vendor  - Level 35, heals 1392
		4599,	-- Cured Ham Steak 		-- Vendor  - Level 35, heals 1392
		4608,	-- Raw Black Truffle 		-- Vendor  - Level 35, heals 1392
		18255,	-- Runn Tum Tuber		-- Uncooked
		16168,	-- Heaven Peach			-- Vendor  - Level 35, heals 1392
		16766,	-- Undermine Clam Chowder	-- Cooking - Level 35, heals 1392
		6887,	-- Spotted Yellowtail		-- Cooking - Level 35, heals 1392
		13930,	-- Filet of Redgill		-- Cooking - Level 35, heals 1392
		9681,	-- Grilled King Crawler Legs	-- Quest   - Level 35, heals 1392
		16171,	-- Shinsollo			-- Vendor  - Level 45, heals 2148
		8952,	-- Roasted Quail 		-- Vendor  - Level 45, heals 2148
		8953,	-- Deep Fried Plantains		-- Vendor  - Level 45, heals 2148
		8950,	-- Homemade Cherry Pie 		-- Vendor  - Level 45, heals 2148
		8932,	-- Alterac Swiss 		-- Vendor  - Level 45, heals 2148 
		8948,	-- Dried King Bolete 		-- Vendor  - Level 45, heals 2148
		8957,	-- Spinefin Halibut		-- Vendor  - Level 45, heals 2148
		13935,	-- Baked Salmon			-- Cooking - Level 45, heals 2148
		13933,	-- Lobster Stew			-- Cooking - Level 45, heals 2148
};
AutoBar_Category_Info["FOOD_STAMINA"].items = {
		6888,	-- Herb Baked Egg	-- Cooking - Level 1, heals 61, stamina/spirit
		12224,	-- Crispy Bat Wing	-- Cooking - Level 1, heals 61, stamina/spirit
		17197,	-- Gingerbread Cookie	-- Cooking - Level 1, heals 61, stamina/spirit
		17198,	-- Egg Nog		-- Cooking - Level 1, heals 61, stamina/spirit
		5472,	-- Kaldorei Spider Kabo	-- Cooking - Level 1, heals 61, with bonus
		2888,	-- Beer Basted Boar Rib	-- Cooking - Level 1, heals 61, with bonus
		5474,	-- Roasted Kodo Meat	-- Cooking - Level 1, heals 61, stamina/spirit
		11584,	-- Cactus Apple Surpris	-- Quest   - Level 1, heals 61, with bonus
		5476,	-- Fillet of Frenzy	-- Cooking - Level 5, heals 243, with bonus
		5477,	-- Strider Stew		-- Cooking - Level 5, heals 243, stamina/spirit
		724,	-- Goretusk Liver Pieo	-- Cooking - Level 5, heals 243, with bonus
		3220,	-- Blood Sausageo	-- Cooking - Level 5, heals 243, with bonus
		3662,	-- Crocolisk Steako	-- Cooking - Level 5, heals 243, with bonus
		2687,	-- Dry Pork Ribso	-- Cooking - Level 5, heals 243, stamina/spirit
		1082,	-- Redridge Goulash	-- Cooking - Level 10, heals 552, with bonus
		5479,	-- Crispy Lizard Tail	-- Cooking - Level 12, heals 552, stamina/spirit
		1017,	-- Seasoned Wolf Kabob	-- Cooking - Level 15, heals 552, with bonus
		3663,	-- Murloc Fin Soup	-- Cooking - Level 15, heals 552, with bonus 
		3726,	-- Big Bear Steak	-- Cooking - Level 15, heals 552, stamina/spirit
		5480,	-- Lean Venison		-- Cooking - Level 15, heals 552, stamina/spirit
		3666,	-- Gooey Spider Cake	-- Cooking - Level 15, heals 552, with bonus
		3664,	-- Crocolisk Gumbo	-- Cooking - Level 15, heals 552, with bonus 
		5527,	-- Goblin Deviled Clams	-- Cooking - Level 15, heals 552, stamina/spirit
		3727,	-- Hot Lion Chops	-- Cooking - Level 15, heals 552, stamina/spirit
		12209,	-- Lean Wolf Steak	-- Cooking - Level 15, heals 552, with bonus
		3665,	-- Curiously Tasty Omel	-- Cooking - Level 15, heals 552, stamina/spirit
		3728,	-- Tasty Lion Steak	-- Cooking - Level 20, heals 874, with bonus
		4457,	-- Barbecued Buzzard Win-- Cooking - Level 25, heals 874, stamina/spirit
		12213,	-- Carrion Surprise	-- Cooking - Level 25, heals 874, stamina/spirit
		6038,	-- Giant Clam Corcho	-- Cooking - Level 25, heals 874, stamina/spirit
		3729,	-- Soothing Turtle Bisqu-- Cooking - Level 25, heals 874, stamina/spirit
		13851,	-- Hot Wolf Ribs	-- Cooking - Level 25, heals 874, with bonus
		12214,	-- Mystery Stew		-- Cooking - Level 25, heals 874, with bonus
		12210,	-- Roast Raptor		-- Cooking - Level 25, heals 874, stamina/spirit
		12212,	-- Jungle Stew		-- Cooking - Level 25, heals 874, stamina/spirit
		13929,	-- Hot Smoked Bass	-- Cooking - Level 35, heals 874, with bonus
		17222,	-- Spider Sausage 	-- Cooking - Level 35, heals 1392, stamina/spirit
		12215,	-- Heavy Kodo Stew	-- Cooking - Level 35, heals 1392, stamina/spirit
		13927,	-- Cooked Glossy Mightfi-- Cooking - Level 35, heals 1392, stamina
		12216,	-- Spider Chilli Crab	-- Cooking - Level 35, heals 1392, stamina/spirit
		12218,	-- Monster Omlette	-- Cooking - Level 40, heals 1392, stamina/spirit
		16971,	-- Clamlette Surprise 	-- Cooking - Level 40, heals 1392, with bonus
		18045,	-- Tender Wolf Steak	-- Cooking - Level 40, heals 1392, stamina/spirit
		13934,	-- Mightfish Steak	-- Cooking - Level 45, heals 1933, stamina
		11950,	-- Windblossom Berries	-- Felwood - Level 45, heals 1933, stamina/spirit
};
AutoBar_Category_Info["FOOD_AGILITY"].items = {
		13928,	-- Grilled Squid	-- Cooking - Level 35, heals 874, agility
};
AutoBar_Category_Info["FOOD_MANAREGEN"].items = {
		3448,	-- Senggin Root		-- Horde Q - Level 1, heals 294, mana 294
		13931,	-- Nightfin Soup	-- Cooking - Level 35, heals 874, mana regen
};
AutoBar_Category_Info["FOOD_HPREGEN"].items = {
		13932,	-- Poached Sunscale Sal	-- Cooking - Level 35, heals 874, hp regen
};
AutoBar_Category_Info["FOOD_STRENGTH"].items = {
		20452,	-- Smoked Desert Dumpling-- Level 45, heals 2148, str bonus
};
AutoBar_Category_Info["FOOD_INTELLIGENCE"].items = {
		18254,	-- Runn Tum Tuber Surpris-- int bonus
};
AutoBar_Category_Info["SHARPENINGSTONES"].items = {
		2862,	-- Rough Sharpening Stone
		2863,	-- Coarse Sharpening Stone
		2871,	-- Heavy Sharpening Stone
		7964,	-- Solid Sharpening Stone
		12404,	-- Dense Sharpening Stone
		18262,	-- Elemental Sharpening Stone
}; 
AutoBar_Category_Info["WEIGHTSTONE"].items = {
		3239,	-- Rough Weightstone
		3240,	-- Coarse Weightstone
		3241,	-- Heavy Weightstone
		7965,	-- Solid Weightstone
		12643,	-- Dense Weightstone 
};
AutoBar_Category_Info["POISON-CRIPPLING"].items = {
		3775,	-- Crippling Poison
		3776,	-- Crippling Poison II
};
AutoBar_Category_Info["POISON-DEADLY"].items = {
		2892,	-- Deadly Poison
		2893,	-- Deadly Poison II
		8984,	-- Deadly Poison III
		8985,	-- Deadly Poison IV
};
AutoBar_Category_Info["POISON-INSTANT"].items = {
		6947,	-- Instant Poison
		6949,	-- Instant Poison II
		6950,	-- Instant Poison III
		8926,	-- Instant Poison IV
		8927,	-- Instant Poison V
		8928,	-- Instant Poison VI 
};
AutoBar_Category_Info["POISON-MINDNUMBING"].items = {
		5237,	-- Mind-numbing Poison
		6951,	-- Mind-numbing Poison II
		9186,	-- Mind-numbing Poison III 
};
AutoBar_Category_Info["POISON-WOUND"].items = {
		10918,	-- Wound Poison
		10920,	-- Wound Poison II
		10921,	-- Wound Poison III
		10922,	-- Wound Poison IV
};
AutoBar_Category_Info["EXPLOSIVES"].items = {
		4358,	-- Rough Dynamite
		4360,	-- Rough Copper Bomb
		4365,	-- Coarse Dynamite
		4370,	-- Large Copper Bomb
		6714,	-- EZ-Thro Dynamite
		4374,	-- Small Bronze Bomb
		4378,	-- Heavy Dynamite
		4380,	-- Big Bronze Bomb
		10507,	-- Solid Dynamite
		4390,	-- Iron Grenade
		4403,	-- Portable Bronze Mortar
		4394,	-- Big Iron Bomb
		18588,	-- EZ-Thro Dynamite II
		10514,	-- Mithril Frag Bomb
		10586,	-- The Big One
		10562,	-- Hi-Explosive Bomb
		15993,	-- Thorium Grenade
		16005,	-- Dark Iron Bomb
		16040,	-- Arcane Bomb
};
AutoBar_Category_Info["WARSONG_BANDAGES"].items = {
		19068,	-- Warsong Gulch Silk Bandage
		19067,	-- Warsong Gulch Mageweave Bandage
		19066,	-- Warsong Gulch Runecloth Bandage
};
AutoBar_Category_Info["ARATHI_BANDAGES"].items = {
		20067,	-- Arathi Basin Silk Bandage
		20244,	-- Highlander's Silk Bandage
		20235,	-- Defiler's Silk Bandage
		20065,	-- Arathi Basin Mageweave Bandage
		20237,	-- Highlander's Mageweave Bandage
		20232,	-- Defiler's Mageweave Bandage
		20066,	-- Arathi Basin Runecloth Bandage
		20243,	-- Highlander's Runecloth Bandage
		20234,	-- Defiler's Runecloth Bandage
};
AutoBar_Category_Info["MANA_OIL"].items = {
		20745, 	-- Minor Mana Oil 4mana/5sec
		20747, 	-- Lesser Mana Oil 8mana/5sec
		20748,	-- Brilliant Mana Oil 12mana/5sec
};
AutoBar_Category_Info["WIZARD_OIL"].items = {
		20744,	-- Minor Wizard Oil +8 spell damage
		20746,	-- Lesser Wizard Oil +16 spell damage
		20750, 	-- Wizard Oil +24 spell damage
		20749, 	-- Brilliant Wizard Oil +36 spell damage
};
AutoBar_Category_Info["MOUNTS_TROLL"].items = {
		8588,	-- Emerald Raptor
		8591,	-- Turquoise Raptor
		8592,	-- Violet Raptor
		18788,	-- Elite: Swift Blue Raptor
		18789,	-- Elite: Swift Olive Raptor
		18790,	-- Elite: Swift Orange Raptor
		18246,	-- Elite: PVP: Black War Raptor
};
AutoBar_Category_Info["MOUNTS_ORC"].items = {
		1132, 	-- Timber Wolf
		5665,	-- Dire Wolf
		5668,	-- Brown Wolf
		18796, 	-- Elite: Swift Brown Wolf
		18797,	-- Elite: Swift Timber Wolf
		18798,	-- Elite: Swift Gray Wolf
		18245,	-- Elite: PVP: Black War Wolf

};
AutoBar_Category_Info["MOUNTS_UNDEAD"].items = {
		13331,	-- Red Skeletal Horse
		13332,	-- Blue Skeleton Horse
		13333,	-- Brown Skeletal Horse
		13334, 	-- Elite: Green Skeletal Warhorse
		18791,	-- Elite: Purple Skeletal Warhorse
		18248,	-- Elite: PVP: Red Skeletal Warhorse
};
AutoBar_Category_Info["MOUNTS_TAUREN"].items = {
		15277, 	-- Gray Kodo
		15290,	-- Brown Kodo
		18793,	-- Elite: Great White Kodo
		18794,	-- Elite: Great Brown Kodo
		18795,	-- Elite: Great Grey Kodo
		18247,	-- Elite: PVP: Black War Kodo
};
AutoBar_Category_Info["MOUNTS_HUMAN"].items = {
		2414, 	-- Pinto
		5414,	-- Black Stallion
		5655,	-- Chestnut Mare
		5656,	-- Brown Horse
		18776,	-- Elite: Swift Palamino
		18777,	-- Elite: Swift Brown Steed
		18778,	-- Elite: Swift White Steed
		18241,	-- Elite: PVP: Black War Steed
};
AutoBar_Category_Info["MOUNTS_NIGHTELF"].items = {
		8629,	-- Striped Nightsaber
		8631,	-- Striped Frostsaber
		8632,	-- Spotted Frostsaber
		18766,	-- Elite: Swift Frostsaber
		18767,	-- Elite: Swift Mistsaber
		18902,	-- Elite: Swift Stormsaber
		13086,	-- Elite: Winterspring Frostsaber
		18242,	-- Elite: PVP: Black War Tiger
};
AutoBar_Category_Info["MOUNTS_DWARF"].items = {
		5864,	-- Gray
		5872,	-- Brown
		5873,	-- White
		18785,	-- Elite: Swift White
		18786,	-- Elite: Swift Brown
		18786,	-- Elite: Swift Gray
		18244,	-- Elite: PVP: Black War Ram
};
AutoBar_Category_Info["MOUNTS_GNOME"].items = {
		8595,	-- Blue
		13321,	-- Green
		13322,	-- Unpainted
		18772,	-- Swift Green
		18773,	-- Swift White
		18774,	-- Swift Yellow
		18243,	-- Elite: PVP: Black Battlestrider
};
AutoBar_Category_Info["MOUNTS_SPECIAL"].items = {
		19029,	-- Elite: Alterac Valley Wolf
		19030,	-- Elite: Alterac Valley Ram
		19872,	-- Elite: ZG Raptor
		19902,	-- Elite: ZG Tiger
};


-- Originally based on the table at http://www.goodintentionsguild.info/hunters.html
-- Additional information from http://www.tkasomething.com/petskills.php
-- And many individual contributors!

FHH_SpellIcons = {
	["Spell_Nature_StarFall"] = "resist",
	["Spell_Fire_FireArmor"] = "resist",
	["Spell_Frost_FrostWard"] = "resist",
	["Spell_Nature_ResistNature"] = "resist",
	["Spell_Shadow_AntiShadow"] = "resist",
	["Spell_Nature_UnyeildingStamina"] = "stamina",
	["Spell_Nature_SpiritArmor"] = "armor",
	["Ability_Racial_Cannibalize"] = "bite",
	["Ability_Druid_Cower"] = "cower",
	["Ability_Druid_Rake"] = "claw",
	["Ability_Druid_Dash"] = "dash",
	["Spell_Shadow_BurningSpirit"] = "dive",
	["Ability_Physical_Taunt"] = "growl",
	["Ability_Hunter_Pet_Wolf"] = "howl",
	["Spell_Nature_Lightning"] = "lightning",
	["Ability_PoisonSting"] = "poison",
	["Ability_Druid_SupriseAttack"] = "prowl",
	["Ability_Hunter_Pet_Bat"] = "screech",
	["Ability_Hunter_Pet_Boar"] = "charge",
	["Ability_Hunter_Pet_Turtle"] = "shell",
	["Ability_Hunter_Pet_Gorilla"] = "thunderstomp",
};

FHH_SpellNamesToIDs = {
	[FHH_ARCANE_RESIST] = "resist",
	[FHH_FIRE_RESIST] = "resist",
	[FHH_FROST_RESIST] = "resist",
	[FHH_NATURE_RESIST] = "resist",
	[FHH_SHADOW_RESIST] = "resist",
	[FHH_STAMINA] = "stamina",
	[FHH_ARMOR] = "armor",
	[FHH_BITE] = "bite",
	[FHH_CLAW] = "claw",
	[FHH_COWER] = "cower",
	[FHH_DASH] = "dash",
	[FHH_DIVE] = "dive",
	[FHH_GROWL] = "growl",
	[FHH_HOWL] = "howl",
	[FHH_LIGHTNING] = "lightning",
	[FHH_POISON] = "poison",
	[FHH_PROWL] = "prowl",
	[FHH_SCREECH] = "screech",
	[FHH_CHARGE] = "charge",
	[FHH_SHELL] = "shell",
	[FHH_THUNDERSTOMP] = "thunderstomp",
};

FHH_SpellIDsToNames = {
	["resist"] = FHH_ALL_RESISTS,
	["stamina"] = FHH_STAMINA,
	["armor"] = FHH_ARMOR,
	["bite"] = FHH_BITE,
	["claw"] = FHH_CLAW,
	["cower"] = FHH_COWER,
	["dash"] = FHH_DASH,
	["dive"] = FHH_DIVE,
	["growl"] = FHH_GROWL,
	["howl"] = FHH_HOWL,
	["lightning"] = FHH_LIGHTNING,
	["poison"] = FHH_POISON,
	["prowl"] = FHH_PROWL,
	["screech"] = FHH_SCREECH,
	["charge"] = FHH_CHARGE,
	["shell"] = FHH_SHELL,
	["thunderstomp"] = FHH_THUNDERSTOMP,
};

FHH_AllFamilies =  { FHH_BAT, FHH_BEAR, FHH_BOAR, FHH_CARRION_BIRD, FHH_CAT, FHH_CRAB, FHH_CROCOLISK, FHH_GORILLA, FHH_HYENA, FHH_OWL, FHH_RAPTOR, FHH_SCORPID, FHH_SPIDER, FHH_TALLSTRIDER, FHH_TURTLE, FHH_WIND_SERPENT, FHH_WOLF};

FHH_LearnableBy = {
	["growl"] = FHH_ALL_FAMILIES,
	["armor"] = FHH_ALL_FAMILIES,
	["stamina"] = FHH_ALL_FAMILIES, 
	["resist"] = FHH_ALL_FAMILIES,
	["cower"] = FHH_ALL_FAMILIES,
	["bite"] = { FHH_BAT, FHH_BEAR, FHH_BOAR, FHH_CARRION_BIRD, FHH_CAT, FHH_CROCOLISK, FHH_GORILLA, FHH_HYENA, FHH_RAPTOR, FHH_SPIDER, FHH_TALLSTRIDER, FHH_TURTLE, FHH_WIND_SERPENT, FHH_WOLF },
	["claw"] = { FHH_BEAR, FHH_CARRION_BIRD, FHH_CAT, FHH_CRAB, FHH_OWL, FHH_RAPTOR, FHH_SCORPID },
	["dash"] = { FHH_BOAR, FHH_CAT, FHH_HYENA, FHH_TALLSTRIDER, FHH_WOLF},
	["dive"] = { FHH_BAT, FHH_CARRION_BIRD, FHH_OWL, FHH_WIND_SERPENT },
	["prowl"] = { FHH_CAT },
	["screech"] = { FHH_BAT, FHH_CARRION_BIRD, FHH_OWL },
	["poison"] = { FHH_SCORPID },
	["howl"] = { FHH_WOLF },
	["lightning"] = { FHH_WIND_SERPENT },
	["charge"] = { FHH_BOAR },
	["shell"] = { FHH_TURTLE },
	["thunderstomp"] = { FHH_GORILLA },
};

FHH_RequiredLevel = {
	["growl"] = { 1, 10, 20, 30, 40, 50, 60, },
	["bite"] = { 1, 8, 16, 24, 32, 40, 48, 56, },
	["claw"] = { 1, 8, 16, 24, 32, 40, 48, 56, },
	["cower"] = { 5, 15, 25, 35, 45, 55, },
	["dash"] = { 30, 40, 50, },
	["dive"] = { 30, 40, 50, },
	["prowl"] = { 30, 40, 50, },
	["screech"] = { 8, 24, 48, 56 },
	["poison"] = { 8, 15, 40, 56 },
	["howl"] = { 10, 24, 40, 56 },
	["stamina"] = { 10, 12, 18, 24, 30, 36, 42, 48, 54, 60, },
	["armor"] = { 10, 12, 18, 24, 30, 36, 42, 48, 54, 60, },
	["resist"] = { 20, 30, 40, 50, },
	["lightning"] = { nil, 12, 24, 36, 48, 60 },	-- no rank 1
	["charge"] = { 1, 12, 24, nil, 48, 60 },		-- no rank 4
	["shell"] = { 20 },
	["thunderstomp"] = { 30, 40, 50 },
};

FHH_SpellInfo = {
	["growl"] = FHH_PET_TRAINER, -- ranks 1-2 are innate; this is special-cased in HuntersHelper.lua
	["stamina"] = FHH_PET_TRAINER,
	["armor"] = FHH_PET_TRAINER, 
	["resist"] = FHH_PET_TRAINER,
	["bite"] = {
		[1] = {
			["Dun Morogh"] = {
				"Snow Tracker Wolf",
				"Winter Wolf",
			},
			["Elwynn Forest"] = {
				"Gray Forest Wolf",
				"Forest Spider",
			},
			["Durotar"] = {
				"Dreadmaw Crocolisk",
			},
			["Mulgore"] = {
				"Prairie Stalker",
				"Prairie Wolf",
				"The Rake",
			},
			["Teldrassil"] = {
				"Githyiss the Vile",
				"Webwood Venomfang",
			},
			["Tirisfal Glades"] = {
				"Night Web Spider",
				"Night Web Matriarch",
				"Ragged Scavenger",
				"Sri'skulk",
			},
		},
		[2] = {
			["The Barrens"] = {
				"Oasis Snapjaw",
			},
			["Dun Morogh"] = {
				"Starving Winter Wolf",
				"Timber",
			},
			["Elwynn Forest"] = {
				"Mother Fang",
				"Prowler",
			},
			["Loch Modan"] = {
				"Forest Lurker",
				"Loch Crocolisk",
			},
			["Mulgore"] = {
				"Prairie Wolf Alpha",
			},
			["Redridge Mountains"] = {
				"Tarantula",
			},
			["Teldrassil"] = {
				"Giant Webwood Spider",
				"Lady Sathrah",
				"Webwood Silkspinner",
			},
			["Tirisfal Glades"] = {
				"Vicious Night Web Spider",
			},
			["Silverpine Forest"] = {
				"Worg",
			},
			["Westfall"] = {
				"Coyote",
				"Coyote Packleader",
			},
		},
		[3] = {
			["Ashenvale"] = {
				"Ghostpaw Runner",
			},
			["Blackfathom Deeps"] = {
				"Aku'mai Fisher",
			},
			["Duskwood"] = {
				"Green Recluse",
				"Lupos",
			},
			["Hillsbrad Foothills"] = {
				"Forest Moss Creeper",
			},
			["Loch Modan"] = {
				"Wood Lurker",
				"Shanda the Sinner",
			},
			["Redridge Mountains"] = {
				"Greater Tarantula",
			},
			["Silverpine Forest"] = {
				"Bloodsnout Worg",
			},
			["Stonetalon Mountains"] = {
				"Besseleth",
				"Deepmoss Creeper",
				"Deepmoss Webspinner",
			},
			["Wailing Caverns"] = {
				"Kresh",
				"Deviate Crocolisk",
			},
		},
		[4] = {
			["Ashenvale"] = {
				"Ghostpaw Alpha",
				"Wildthorn Lurker",
			},
			["Blackfathom Deeps"] = {
				"Aku'mai Snapjaw",
				"Ghamoo-Ra",
			},
			["Duskwood"] = {
				"Black Ravager Mastiff",
				"Black Ravager",
				"Naraxis",
			},
			["Hillsbrad Foothills"] = {
				"Elder Moss Creeper",
				"Giant Moss Creeper",
				"Snapjaw",
			},
			["Wetlands"] = {
				"Giant Wetlands Crocolisk",
			},
		},
		[5] = {
			["Arathi Highlands"] = {
				"Plains Creeper",
				"Giant Plains Creeper",
			},
			["Badlands"] = {
				"Crag Coyote",
			},
			["Dustwallow Marsh"] = {
				"Darkfang Creeper",
				"Darkfang Lurker",
				"Darkfang Spider",
				"Drywallow Crocolisk",
				"Mottled Drywallow Crocolisk",
				"Mudrock Tortoise",
			},
			["Thousand Needles"] = {
				"Sparkleshell Snapper",
			},
		},
		[6] = {
			["Azshara"] = {
				"Timberweb Recluse",
			},
			["Badlands"] = {
				"Barnabus",
			},
			["Dustwallow Marsh"] = {
				"Deadmire",
				"Ripscale",
				"Drywallow Daggermaw",
				"Mudrock Snapjaw",
			},
			["Felwood"] = {
				"Felpaw Wolf",
				"Death Howl",
			},
			["Feralas"] = {
				"Snarler",
				"Longtooth Runner",
			},
			["The Hinterlands"] = {
				"Old Cliff Jumper",
				"Witherbark Broodguard",
			},
			["Searing Gorge"] = {
				"Rekk'tilac",
			},
			["Swamp of Sorrows"] = {
				"Deathstrike Tarantula",
				"Sawtooth Snapper",
			},
		},
		[7] = {
			["Felwood"] = {
				"Felpaw Ravager",
			},
			["The Hinterlands"] = {
				"Ironback",
				"Saltwater Snapjaw",
				"Vilebranch Raiding Wolf",
			},
			["Stormwind City"] = {
				"Sewer Beast",
			},
			["Tanaris"] = {
				"Giant Surf Glider",
			},
			["Un'Goro Crater"] = {
				"Uhk'loc",
			},
			["Western Plaguelands"] = {
				"Diseased Wolf",
				"Plague Lurker",
			},
		},
		[8] = {
			["Blackrock Spire"] = {
				"Bloodaxe Worg",
			},
		},
	},
	["claw"] = {
		[1] = {
			["Dun Morogh"] = {
				"Ice Claw Bear",
			},
			["Durotar"] = {
				"Pygmy Surf Crawler",
				"Sarkoth",
				"Scorpid Worker",
			},
			["Teldrassil"] = {
				"Strigid Owl",
			},
		},
		[2] = {
			["Darkshore"] = {
				"Thistle Bear",
				"Tide Crawler",
			},
			["Dun Morogh"] = {
				"Bjarn",
				"Mangeclaw",
			},
			["Durotar"] = {
				"Death Flayer",
				"Encrusted Surf Crawler",
				"Venomtail Scorpid",
			},
			["Elwynn Forest"] = {
				"Young Forest Bear",
			},
			["Silverpine Forest"] = {
				"Ferocious Grizzled Bear",
			},
			["Teldrassil"] = {
				"Strigid Hunter",
			},
		},
		[3] = {
			["Ashenvale"] = {
				"Ashenvale Bear",
				"Clattering Crawler",
			},
			["Blackfathom Deeps"] = {
				"Skittering Crustacean",
				"Snapping Crustacean",
			},
			["Darkshore"] = {
				"Den Mother",
			},
			["Hillsbrad Foothills"] = {
				"Gray Bear",
			},
			["Loch Modan"] = {
				"Black Bear Patriarch",
				"Ol' Sooty",
			},
			["Westfall"] = {
				"Shore Crawler",
			},
		},
		[4] = {
			["Ashenvale"] = {
				"Elder Ashenvale Bear",
			},
			["Blackfathom Deeps"] = {
				"Barbed Crustacean",
			},
			["Desolace"] = {
				"Scorpashi Snapper",
			},
			["Thousand Needles"] = {
				"Scorpid Reaver",
			},
		},
		[5] = {
			["Desolace"] = {
				"Scorpashi Lasher",
			},
			["Dustwallow Marsh"] = {
				"Drywallow Snapper",
			},
			["Thousand Needles"] = {
				"Vile Sting",
			},
		},
		[6] = {
			["Feralas"] = {
				"Ironfur Bear",
				"Old Grizzlegut",
			},
			["Stranglethorn Vale"] = {
				"King Bangalash",
			},
			["Swamp of Sorrows"] = {
				"Monstrous Crawler",
				"Silt Crawler",
			},
			["Tanaris"] = {
				"Scorpid Hunter",
			},
		},
		[7] = {
			["Blasted Lands"] = {
				"Clack the Reaver",
			},
			["Burning Steppes"] = {
				"Deathlash Scorpid",
			},
			["Felwood"] = {
				"Angerclaw Mauler",
				"Ironbeak Hunter",
				"Olm the Wise",
			},
			["Feralas"] = {
				"Ironfur Patriarch",
			},
			["Western Plaguelands"] = {
				"Diseased Grizzly",
			},
			["Winterspring"] = {
				"Shardtooth Bear",
				"Winterspring Owl",
			},
		},
		[8] = {
			["Winterspring"] = {
				"Elder Shardtooth",
				"Winterspring Screecher",
			},
		},
	},
	["cower"] = {
		[1] = {
			["The Barrens"] = {
				"Elder Plainstrider",
				"Fleeting Plainstrider",
			},
			["Darkshore"] = {
				"Foreststrider Fledgling",
				"Moonstalker Runt",
			},
			["Dun Morogh"] = {
				"Juvenile Snow Leopard",
			},
			["Durotar"] = {
				"Durotar Tiger",
			},
			["Mulgore"] = {
				"Elder Plainstrider",
				"Flatland Cougar",
				"Mazzranache",
			},
			["Teldrassil"] = {
				"Mangy Nightsaber",
				"Nightsaber",
			},
			["Tirisfal Glades"] = {
				"Greater Duskbat",
			},
		},
		[2] = {
			["The Barrens"] = {
				"Ornery Plainstrider",
				"Savannah Patriarch",
			},
			["Darkshore"] = {
				"Giant Foreststrider",
				"Moonstalker Sire",
			},
			["Hillsbrad Foothills"] = {
				"Starving Mountain Lion",
			},
			["Stonetalon Mountains"] = {
				"Twilight Runner",
			},
		},
		[3] = {
			["Hillsbrad Foothills"] = {
				"Feral Mountain Lion",
			},
			["Razorfen Kraul"] = {
				"Blind Hunter",
				"Kraul Bat",
			},
			["Stranglethorn Vale"] = {
				"Young Stranglethorn Tiger",
				"Young Panther",
				"Panther",
			},
			["Thousand Needles"] = {
				"Crag Stalker",
			},
		},
		[4] = {
			["Badlands"] = {
				"Ridge Huntress",
				"Ridge Stalker",
			},
			["Uldaman"] = {
				"Shrike Bat",
			},
		},
		[5] = {
			["Eastern Plaguelands"] = {
				"Noxious Plaguebat",
				"Plaguebat",
			},
			["Stranglethorn Vale"] = {
				"Jaguero Stalker",
			},
		},
		[6] = {
			["Eastern Plaguelands"] = {
				"Monstrous Plaguebat",
			},
			["Winterspring"] = {
				"Frostsaber Cub",
			},
		},
	},
	["dash"] = {
		[1] = {
			["Badlands"] = {
				"Broken Tooth",
				"Crag Coyote",
				"Elder Crag Coyote",
				"Feral Crag Coyote",
			},
			["Desolace"] = {
				"Bonepaw Hyena",
				"Magram Bonepaw",
			},
			["Scarlet Monastery"] = {
				"Scarlet Tracking Hound",
			},
			["Stranglethorn Vale"] = {
				"Kurzen War Tiger",
				"Sin'Dall",
				"Stranglethorn Tiger",
			},
			["Swamp of Sorrows"] = {
				"Swamp Jaguar",
			},
		},
		[2] = {
			["Badlands"] = {
				"Ridge Stalker Patriarch",
			},
			["Blasted Lands"] = {
				"Grunter",
			},
			["Feralas"] = {
				"Longtooth Runner",
			},
			["The Hinterlands"] = {
				"Old Cliff Jumper",
				"Silvermane Stalker",
			},
			["Stranglethorn Vale"] = {
				"Bhag'Thera",
				"Elder Shadowmaw Panther",
				"King Bangalash",
			},
			["Tanaris"] = {
				"Blisterpaw Hyena",
				"Rabid Blisterpaw",
				"Starving Blisterpaw",
			},
		},
		[3] = {
			["Blackrock Spire"] = {
				"Bloodaxe Worg",
				"Blackrock Worg",
			},
			["Blasted Lands"] = {
				"Ravage",
			},
			["The Hinterlands"] = {
				"Vilebranch Raiding Wolf",
			},
			["Winterspring"] = {
				"Frostsaber Huntress",
				"Frostsaber Stalker",
				"Rak'shiri",
			},
		},
	},
	["dive"] = {
		[1] = {
			["Arathi Highlands"] = {
				"Mesa Buzzard",
				"Young Mesa Buzzard",
			},
			["Desolace"] = {
				"Dread Flyer",
			},
			["Razorfen Kraul"] = {
				"Kraul Bat",
			},
			["Uldaman"] = {
				"Shrike Bat",
			},
		},
		[2] = {
			["Felwood"] = {
				"Ironbeak Owl",
			},
			["Feralas"] = {
				"Arash-ethis",
				"Rogue Vale Screecher",
				"Vale Screecher",
			},
			["Tanaris"] = {
				"Fire Roc",
				"Roc",
			},
		},
		[3] = {
			["Badlands"] = {
				"Zaricotl",
			},
			["Blasted Lands"] = {
				"Spiteflayer",
			},
			["Felwood"] = {
				"Ironbeak Hunter",
				"Ironbeak Screecher",
				"Olm the Wise",
			},
			["Winterspring"] = {
				"Winterspring Screecher",
				"Winterspring Owl",
			},
			["Eastern Plaguelands"] = {
				"Plaguebat",
			},
			["Western Plaguelands"] = {
				"Carrion Vulture",
			},
			["The Temple of Atal'Hakkar"] = {
				"Hakkari Frostwing",
				"Hakkari Sapper",
				"Spawn of Hakkar",
			},
		},
	},
	["prowl"] = {
		[1] = {
			["Alterac Mountains"] = {
				"Hulking Mountain Lion",
				"Mountain Lion",
			},
			["Badlands"] = {
				"Ridge Stalker",
			},
			["Stranglethorn Vale"] = {
				"Shadowmaw Panther",
			},
			["Swamp of Sorrows"] = {
				"Shadow Panther",
			},
		},
		[2] = {
			["Badlands"] = {
				"Ridge Stalker Patriarch",
			},
			["Stranglethorn Vale"] = {
				"Elder Shadowmaw Panther",
			},
		},
		[3] = {
			["Winterspring"] = {
				"Frostsaber Stalker",
			},
			["Stranglethorn Vale"] = {
				"Jaguero Stalker",
			},
		},
	},
	["screech"] = {
		[1] = {
			["Westfall"] = {
				"Greater Fleshripper",
			},
		},
		[2] = {
			["Desolace"] = {
				"Dread Ripper",
			},
			["Thousand Needles"] = {
				"Salt Flats Vulture",
			},
			["Uldaman"] = {
				"Shrike Bat",
			},
		},
		[3] = {
			["Felwood"] = {
				"Ironbeak Owl",
				"Olm the Wise",
			},
			["Western Plaguelands"] = {
				"Carrion Vulture",
			},
		},
		[4] = {
			["Winterspring"] = {
				"Winterspring Screecher",
			},
			["Western Plaguelands"] = {
				"Monstrous Plaguebat",
			},
		},
	},
	["poison"] = {
		[1] = {
			["The Barrens"] = {
				"Silithid Creeper",
				"Silithid Swarmer",
			},
			["Durotar"] = {
				"Corrupted Scorpid",
				"Venomtail Scorpid",
				"Death Flayer",
			},
		},
		[2] = {
			["Desolace"] = {
				"Scorpashi Lasher",
				"Scorpashi Snapper",
				"Scorpashi Venomlash",
			},
			["Thousand Needles"] = {
				"Scorpid Reaver",
				"Scorpid Terror",
				"Vile Sting",
			},
		},
		[3] = {
			["Silithus"] = {
				"Stonelash Scorpid",
			},
			["Tanaris"] = {
				"Scorpid Dunestalker",
				"Scorpid Tail Lasher",
				"Scorpid Hunter",
			},
			["Uldaman"] = {
				"Deadly Cleft Scorpid",
			},
			["Burning Steppes"] = {
				"Deathlash Scorpid",
			},
			["Blasted Lands"] = {
				"Clack the Reaver",
				"Scorpok Stinger",
			},
		},
		[4] = {
			["Silithus"] = {
				"Krellack",
				"Stonelash Pincer",
				"Stonelash Flayer",
			},
			["Burning Steppes"] = {
				"Firetail Scorpid",
			},
		},
	},
	["howl"] = {
		[1] = {
			["Ashenvale"] = {
				"Mist Howler",
			},
			["Westfall"] = {
				"Coyote Packleader",
			},
			["Mulgore"] = {
				"Prairie Wolf Alpha",
			},
			["Silverpine Forest"] = {
				"Worg",
			},
		},
		[2] = {
			["Ashenvale"] = {
				"Ghostpaw Alpha",
			},
			["Duskwood"] = {
				"Black Ravager Mastiff",
			},
			["Badlands"] = {
				"Elder Crag Coyote",
			},
			["Feralas"] = {
				"Longtooth Howler",
			},
			["The Hinterlands"] = {
				"Silvermane Howler",
			},
		},
		[3] = {
			["Felwood"] = {
				"Felpaw Wolf",
				"Death Howl",
			},
			["Feralas"] = {
				"Longtooth Runner",
				"Snarler",
			},
			["The Hinterlands"] = {
				"Silvermane Wolf",
			},
		},
		[4] = {
			["Blackrock Spire"] = {
				"Bloodaxe Worg",
			},
		},
	},
	["lightning"] = {
		[2] = {
			["The Barrens"] = {
				"Thunderhawk Cloudscraper",
				"Thunderhawk Hatchling",
				"Greater Thunderhawk",
			},
			["Wailing Caverns"] = {
				"Deviate Coiler",
				"Deviate Dreadfang",
				"Deviate Stinglash",
				"Deviate Venomwing",
			},
		},
		[3] = {
			["The Barrens"] = {
				"Washte Pawne",
			},
			["Thousand Needles"] = {
				"Cloud Serpent",
				"Elder Cloud Serpent",
				"Venomous Cloud Serpent",
			},
		},
		[4] = {
			["Feralas"] = {
				"Rogue Vale Screecher",
				"Vale Screecher",
			},
		},
		[5] = {
			["Feralas"] = {
				"Arash-ethis",
			},
			["The Temple of Atal'Hakkar"] = {
				"Hakkari Frostwing",
				"Hakkari Sapper",
				"Spawn of Hakkar",
			},
		},
		[6] = {
			["Zul'Gurub"] = {
				"Son of Hakkar",
			},
		},
	},
	["charge"] = {
		[1] = {
			["Durotar"] = {
				"Mottled Boar",
				"Dire Mottled Boar",
				"Elder Mottled Boar",
				"Corrupted Mottled Boar",
			},
			["Teldrassil"] = {
				"Thistle Boar",
				"Young Thistle Boar",
			},
			["Dun Morogh"] = {
				"Crag Boar",
				"Small Crag Boar",
				"Large Crag Boar",
				"Elder Crag Boar",
				"Scarred Crag Boar",
			},
			["Mulgore"] = {
				"Battleboar",
				"Bristleback Battleboar",
			},
			["Elwynn Forest"] = {
				"Longsnout",
				"Porcine Entourage",
				"Princess",
				"Stonetusk Boar",
				"Rockhide Boar",
			},
			["Loch Modan"] = {
				"Mountain Boar",
			},
		},
		[2] = {
			["Westfall"] = {
				"Young Goretusk",
				"Goretusk",
				"Great Goretusk",
			},
			["Loch Modan"] = {
				"Mangy Mountain Boar",
				"Elder Mountain Boar",
			},
			["Redridge Mountains"] = {
				"Great Goretusk",
			},
		},
		[3] = {
			["Redridge Mountains"] = {
				"Bellygrub",
			},
			["Razorfen Kraul"] = {
				"Agam'ar",
				"Raging Agam'ar",
				"Rotting Agam'ar",
			},
		},
		[5] = {
			["Blasted Lands"] = {
				"Ashmane Boar",
			},
		},
		[6] = {
			["Eastern Plaguelands"] = {
				"Plagued Swine",
			},
		},
	},
	["shell"] = {
		[1] = {
			["Wailing Caverns"] = {
				"Kresh",
			},
			["Blackfathom Deeps"] = {
				"Aku'mai Fisher",
				"Aku'mai Snapjaw",
				"Ghamoo-Ra",
			},
			["Hillsbrad Foothills"] = {
				"Snapjaw",
			},
			["Tanaris"] = {
				"Giant Surf Glider",
			},
			["The Hinterlands"] = {
				"Ironback",
			},
		},
	},
	["thunderstomp"] = {
		[1] = {
			["Stranglethorn Vale"] = {
				"Jungle Thunderer",
				"Mistvale Gorilla",
			},
		},
		[2] = {
			["Stranglethorn Vale"] = {
				"Elder Mistvale Gorilla",
			},
			["Feralas"] = {
				"Groddoc Thunderer",
			},
		},
		[3] = {
			["Un'Goro Crater"] = {
				"Un'Goro Thunderer",
				"U'cha",
			},
		},
	},
};

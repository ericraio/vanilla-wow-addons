------------------------------------------------------
-- AdSpace_ItemInfo.lua
-- Originally based on the tables at http://members.cox.net/katy-w/Trades/Home.htm
-- Corrected / extended with info from http://wow.allakhazam.com and http://wowguru.com
------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (the recipe names are all in comments)
------------------------------------------------------

FAS_ItemInfo = {

-- Alchemy
	[13477]	= { b=12000 },	-- Recipe: Superior Mana Potion
	[13478]	= { b=13000 },	-- Recipe: Elixir of Superior Defense
	[5640]	= { b=100 },	-- Recipe: Rage Potion
	[5642]	= { b=1800 },	-- Recipe: Free Action Potion
	[5643]	= { b=2000 },	-- Recipe: Great Rage Potion
	[6053]	= { b=800 },	-- Recipe: Holy Protection Potion
	[6055]	= { b=1500 },	-- Recipe: Fire Protection Potion
	[6056]	= { b=2000 },	-- Recipe: Frost Protection Potion
	[6057]	= { b=2000 },	-- Recipe: Nature Protection Potion
	[9300]	= { b=10000 },	-- Recipe: Elixir of Demonslaying
	[9301]	= { b=10000 },	-- Recipe: Elixir of Shadow Power
	[9302]	= { b=9000 },	-- Recipe: Ghost Dye
	[6068]	= { b=1500 },	-- Recipe: Shadow Oil
	[6054]	= { b=900 },	-- Recipe: Shadow Protection Potion
	[14634]	= { b=2500 },	-- Recipe: Frost Oil
	[13480]	= { b=15000 },	-- Recipe: Major Healing Potion
	[9303]	= { b=8000 },	-- Recipe: Philosophers' Stone
	[12958]	= { b=50000 },	-- Recipe: Transmute Arcanite
	[9304]	= { b=8000 },	-- Recipe: Transmute Iron to Gold
	[9305]	= { b=8000 },	-- Recipe: Transmute Mithril to Truesilver
	[13501]	= { b=30000,	note=SCHOLO_QUEST  },	-- Recipe: Major Mana Potion
	[13483]	= { b=15000,	note=BRD_BARKEEP  },	-- Recipe: Transmute Fire to Earth
	[13482]	= { b=15000,	note=REQ_FACTION  },	-- Recipe: Transmute Air to Fire
	[13484]	= { b=15000, 	note=REQ_FACTION  },	-- Recipe: Transmute Earth to Water
	[13485]	= { b=15000,	note=SCHOLO_QUEST  },	-- Recipe: Transmute Water to Air
	[20013]	= { b=50000,	note=REQ_FACTION },		-- Recipe: Living Action Potion
	[20011]	= { b=50000,	note=REQ_FACTION },		-- Recipe: Mageblood Potion
	[20014]	= { b=50000,	note=REQ_FACTION },		-- Recipe: Major Troll's Blood Potion
	[20012]	= { b=50000,	note=REQ_FACTION },		-- Recipe: Greater Dreamless Sleep Potion
	[20761]	= { b=120000,	note=REQ_FACTION },		-- Recipe: Transmute Elemental Fire

-- Blacksmithing
	[12162]	= { b=3000 },	-- Plans: Hardened Iron Shortsword
	[12164]	= { b=4400 },	-- Plans: Massive Iron Axe
	[7995]	= { b=6000 },	-- Plans: Mithril Scale Bracers
	[10858]	= { b=3000 },	-- Plans: Solid Iron Maul
	[6047]	= { b=4400 },	-- Plans: Golden Scale Coif
	[12163]	= { b=4400 },	-- Plans: Moonsteel Broadsword
	[8030]	= { b=10000,	note=SCHOLO_QUEST  },		-- Plans: Ebon Shiv
	[12823]	= { b=20000,	note=SCHOLO_QUEST  },		-- Plans: Huge Thorium Battleaxe
	[12819]	= { b=16000,	note=SCHOLO_QUEST  },		-- Plans: Ornate Thorium Handaxe
	[12703]	= { b=40000,	note=SCHOLO_QUEST  },		-- Plans: Storm Gauntlets
	[19208]	= { b=70000,	note=THORIUM_REVERED },		-- Plans: Black Amnesty
	[19209]	= { b=70000,	note=THORIUM_EXALTED  },	-- Plans: Blackfury
	[19211]	= { b=120000,	note=THORIUM_EXALTED  },	-- Plans: Blackguard
	[19210]	= { b=120000,	note=THORIUM_EXALTED  },	-- Plans: Ebon Hand
	[19212]	= { b=120000,	note=THORIUM_EXALTED  },	-- Plans: Nightfall
	[17051]	= { b=70000,	note=THORIUM_FRIENDLY  },	-- Plans: Dark Iron Bracers
	[17060]	= { b=220000,	note=THORIUM_EXALTED  },	-- Plans: Dark Iron Destroyer
	[19207]	= { b=80000,	note=THORIUM_REVERED  },	-- Plans: Dark Iron Gauntlets
	[19206]	= { b=60000,	note=THORIUM_REVERED  },	-- Plans: Dark Iron Helm
	[17052]	= { b=180000,	note=THORIUM_EXALTED  },	-- Plans: Dark Iron Leggings
	[17059]	= { b=220000,	note=THORIUM_HONORED  },	-- Plans: Dark Iron Reaver
	[20040]	= { b=80000,	note=THORIUM_EXALTED  },	-- Plans: Dark Iron Boots
	[17049]	= { b=90000,	note=THORIUM_HONORED  },	-- Plans: Fiery Chain Girdle
	[17053]	= { b=200000,	note=THORIUM_REVERED  },	-- Plans: Fiery Chain Shoulders
	[19202]	= { b=22000,	note=REQ_FACTION  },		-- Plans: Heavy Timbermaw Belt
	[19204]	= { b=40000,	note=REQ_FACTION  },		-- Plans: Heavy Timbermaw Boots
	[19203]	= { b=22000,	note=REQ_FACTION  },		-- Plans: Girdle of the Dawn
	[19205]	= { b=40000,	note=REQ_FACTION  },		-- Plans: Gloves of the Dawn
	[19781]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Darksoul Shoulders
	[19780]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Darksoul Leggings
	[19779]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Darksoul Breastplate
	[19778]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Bloodsoul Gauntlets
	[19777]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Bloodsoul Shoulders
	[19776]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Bloodsoul Breastplate
	[22219]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Jagged Obsidian Shield
	[22221]	= { b=80000,	note=REQ_FACTION  },		-- Plans: Obsidian Mail Tunic
	[22209]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Heavy Obsidian Belt
	[22214]	= { b=50000,	note=REQ_FACTION  },		-- Plans: Light Obsidian Belt
	[22768] = { b=50000,	note=REQ_FACTION  }, 	-- Plans: Ironvine Belt 
	[22766] = { b=50000,	note=REQ_FACTION  }, 	-- Plans: Ironvine Breastplate 
	[22767] = { b=50000,	note=REQ_FACTION  }, 	-- Plans: Ironvine Gloves

-- Enchanting
	[6349]	= { b=500 },	-- Formula: Enchant 2H Weapon - Lesser Intellect
	[11223]	= { b=5800 },	-- Formula: Enchant Bracer - Deflection
	[11163]	= { b=3000 },	-- Formula: Enchant Bracer - Lesser Deflection
	[11101]	= { b=2500 },	-- Formula: Enchant Bracer - Lesser Strength
	[6342]	= { b=300 },	-- Formula: Enchant Chest - Minor Mana
	[11039]	= { b=800 },	-- Formula: Enchant Cloak - Minor Agility
	[11152]	= { b=3000 },	-- Formula: Enchant Gloves - Fishing
	[16217]	= { b=12000 },	-- Formula: Enchant Shield - Greater Stamina
	[6377]	= { b=1000 },	-- Formula: Enchant Boots - Minor Agility
	[6346]	= { b=400 },	-- Formula: Enchant Chest - Lesser Mana
	[16221]	= { b=16000 },	-- Formula: Enchant Chest - Major Health
	[16224]	= { b=20000 },	-- Formula: Enchant Cloak - Superior Defense
	[16243]	= { b=22000 },	-- Formula: Runed Arcanite Rod
	[20758]	= { b=500 },	-- Formula: Minor Wizard Oil
	[20752]	= { b=3000 },	-- Formula: Minor Mana Oil
	[20753]	= { b=4000 },	-- Formula: Lesser Wizard Oil
	[20754]	= { b=10000 },	-- Formula: Lesser Mana Oil
	[20755]	= { b=20000 },	-- Formula: Wizard Oil
	[19449]	= { b=100000, 	note=THORIUM_REVERED  },	-- Formula: Enchant Weapon - Mighty Intellect
	[19448]	= { b=80000,	note=THORIUM_REVERED  },	-- Formula: Enchant Weapon - Mighty Spirit
	[19444]	= { b=30000,	note=THORIUM_REVERED  },	-- Formula: Enchant Weapon - Strength
	[19445]	= { b=30000,	note=REQ_FACTION  },		-- Formula: Enchant Weapon - Agility
	[19447]	= { b=60000,	note=REQ_FACTION  },		-- Formula: Enchant Bracer - Healing
	[19446]	= { b=30000, 	note=REQ_FACTION  },		-- Formula: Enchant Bracer - Mana Regeneration
	[20756]	= { b=40000, 	note=REQ_FACTION  },		-- Formula: Brilliant Wizard Oil (zandalar)
	[20757]	= { b=40000, 	note=REQ_FACTION  },		-- Formula: Brilliant Mana Oil (zandalar)
	[20732]	= { b=90000, 	note=REQ_FACTION  },		-- Formula: Cloak - Greater Fire Resistance (cenarion)
	[20733]	= { b=90000, 	note=REQ_FACTION  },		-- Formula: Cloak - Greater Nature Resistance (cenarion)
	[22392]	= { b=25000, 	note=REQ_FACTION  },		-- Formula: 2H Weapon - Agility (timbermaw)
	
-- Engineering
	[18649]	= { b=1800 },	-- Schematic: Blue Firework
	[10607]	= { b=3600 },	-- Schematic: Deepdive Helmet
	[7560]	= { b=1200 },	-- Schematic: Gnomish Universal Remote
	[13309]	= { b=1000 },	-- Schematic: Lovingly Crafted Boomstick
	[14639]	= { b=1500 },	-- Schematic: Minor Recombobulator
	[10609]	= { b=4000 },	-- Schematic: Mithril Mechanical Dragonling
	[16041]	= { b=12000 },	-- Schematic: Thorium Grenade
	[16042]	= { b=12000 },	-- Schematic: Thorium Widget
	[18647]	= { b=1800 },	-- Schematic: Red Firework
	[13310]	= { b=2000 },	-- Schematic: Accurate Scope
	[10602]	= { b=3000 },	-- Schematic: Deadly Scope
	[16050]	= { b=20000 },	-- Schematic: Delicate Arcanite Converter
	[7742]	= { b=2400 },	-- Schematic: Gnomish Cloaking Device
	[7561]	= { b=2000 },	-- Schematic: Goblin Jumper Cables
	[18648]	= { b=1800 },	-- Schematic: Green Firework
	[18652]	= { b=12000 },	-- Schematic: Gyrofreeze Ice Reflector
	[13308]	= { b=1800 },	-- Schematic: Ice Deflector
	[16046]	= { b=16000 },	-- Schematic: Masterwork Target Dummy
	[13311]	= { b=10000 },	-- Schematic: Mechanical Dragonling
	[18656]	= { b=16000 },	-- Schematic: Powerful Seaforium Charge
	[16047]	= { b=16000 },	-- Schematic: Thorium Tube
	[18651]	= { b=12000 },	-- Schematic: Truesilver Transformer
	[20001]	= { b=50000,	note=REQ_FACTION  },		-- Schematic: Bloodvine Lens
	[20000]	= { b=50000,	note=REQ_FACTION  },		-- Schematic: Bloodvine Goggles
	
-- Leatherworking
	[18949]	= { b=2000 },	-- Pattern: Barbaric Bracers
	[5973]	= { b=650 },	-- Pattern: Barbaric Leggings
	[7289]	= { b=650 },	-- Pattern: Black Whelp Cloak
	[20576]	= { b=350 },	-- Pattern: Black Whelp Tunic
	[15751]	= { b=20000 },	-- Pattern: Blue Dragonscale Breastplate
	[15729]	= { b=12000 },	-- Pattern: Chimeric Gloves
	[7613]	= { b=2000 },	-- Pattern: Green Leather Armor
	[7451]	= { b=2800 },	-- Pattern: Green Whelp Bracers
	[18731]	= { b=2000 },	-- Pattern: Heavy Leather Ball
	[7361]	= { b=1800 },	-- Pattern: Herbalist's Gloves
	[15735]	= { b=14000 },	-- Pattern: Ironfeather Shoulders
	[15734]	= { b=14000 },	-- Pattern: Living Shoulders
	[5786]	= { b=550 },	-- Pattern: Murloc Scale Belt
	[5787]	= { b=600 },	-- Pattern: Murloc Scale Breastplate
	[5789]	= { b=2800 },	-- Pattern: Murloc Scale Bracers
	[8409]	= { b=4000 },	-- Pattern: Nightscape Shoulders
	[13288]	= { b=2500 },	-- Pattern: Raptor Hide Belt
	[7290]	= { b=1600 },	-- Pattern: Red Whelp Gloves
	[15741]	= { b=16000 },	-- Pattern: Stormshroud Pants
	[5788]	= { b=650 },	-- Pattern: Thick Murloc Armor
	[8385]	= { b=3500 },	-- Pattern: Turtle Scale Gloves
	[15725]	= { b=12000 },	-- Pattern: Wicked Leather Gauntlets
	[13287]	= { b=2500 },	-- Pattern: Raptor Hide Harness
	[6474]	= { b=550 },	-- Pattern: Deviate Scale Cloak
	[6475]	= { b=1500 },	-- Pattern: Deviate Scale Gloves
	[15758]	= { b=22000 },	-- Pattern: Devilsaur Gauntlets
	[7362]	= { b=2000 },	-- Pattern: Earthen Leather Shoulders
	[15740]	= { b=16000 },	-- Pattern: Frostsaber Boots
	[14635]	= { b=3000 },	-- Pattern: Gem-studded Leather Belt
	[15726]	= { b=12000 },	-- Pattern: Green Dragonscale Breastplate
	[15724]	= { b=12000 },	-- Pattern: Heavy Scorpid Bracers
	[15762]	= { b=25000 },	-- Pattern: Heavy Scorpid Helm
	[15756]	= { b=22000 },	-- Pattern: Runic Leather Headband
	[18239]	= { b=3500 },	-- Pattern: Shadowskin Gloves
	[15759]	= { b=22000, 	note=BRD_BARKEEP  },		-- Pattern: Black Dragonscale Breastplate
	[17025]	= { b=160000, 	note=THORIUM_HONORED },		-- Pattern: Black Dragonscale Boots
	[19331]	= { b=90000,	note=THORIUM_REVERED },		-- Pattern: Chromatic Gauntlets
	[19332]	= { b=90000,	note=THORIUM_REVERED },		-- Pattern: Corehound Belt
	[17022]	= { b=150000,	note=THORIUM_FRIENDLY },	-- Pattern: Corehound Boots
	[19330]	= { b=60000,	note=THORIUM_REVERED },		-- Pattern: Lava Belt
	[19333]	= { b=90000,	note=THORIUM_REVERED },		-- Pattern: Molten Belt
	[17023]	= { b=160000,	note=THORIUM_FRIENDLY },	-- Pattern: Molten Helm
	[15742]	= { b=16000,	note=TIMBERMAW_FRIENDLY },	-- Pattern: Warbear Harness
	[15754]	= { b=20000,	note=TIMBERMAW_FRIENDLY },	-- Pattern: Warbear Woolies
	[20253]	= { b=16000,	note=REQ_FACTION },			-- Pattern: Warbear Harness
	[20254]	= { b=20000,	note=REQ_FACTION },			-- Pattern: Warbear Woolies
	[19327]	= { b=40000,	note=REQ_FACTION },			-- Pattern: Timbermaw Brawlers
	[19326]	= { b=22000,	note=REQ_FACTION },			-- Pattern: Might of the Timbermaw
	[19328]	= { b=22000,	note=REQ_FACTION },		-- Pattern: Dawn Treaders
	[19329]	= { b=40000, 	note=REQ_FACTION },		-- Pattern: Golden Mantle of the Dawn
	[19771]	= { b=50000,	note=REQ_FACTION },		-- Pattern: Primal Batskin Bracers
	[19773]	= { b=50000,	note=REQ_FACTION },		-- Pattern: Blood Tiger Shoulders
	[19770]	= { b=50000,	note=REQ_FACTION },		-- Pattern: Primal Batskin Gloves
	[19772]	= { b=50000,	note=REQ_FACTION },		-- Pattern: Blood Tiger Breastplate
	[19769]	= { b=50000,	note=REQ_FACTION },		-- Pattern: Primal Batskin Jerkin
	[20382]	= { b=60000,	note=REQ_FACTION },		-- Pattern: Dreamscale Breastplate
	[20506]	= { b=40000,	note=REQ_FACTION },		-- Pattern: Spitfire Bracers
	[20507]	= { b=40000,	note=REQ_FACTION },		-- Pattern: Spitfire Gauntlets
	[20508]	= { b=40000,	note=REQ_FACTION },		-- Pattern: Spitfire Breastplate
	[20509]	= { b=40000,	note=REQ_FACTION },		-- Pattern: Sandstalker Bracers
	[20510]	= { b=40000,	note=REQ_FACTION },		-- Pattern: Sandstalker Gauntlets
	[20511]	= { b=40000,	note=REQ_FACTION },		-- Pattern: Sandstalker Breastplate
	[22769] = { b=50000,	note=REQ_FACTION }, -- Pattern: Bramblewood Belt 
	[22770] = { b=50000,	note=REQ_FACTION }, -- Pattern: Bramblewood Boots 
	[22771] = { b=50000,	note=REQ_FACTION }, -- Pattern: Bramblewood Helm 

-- Tailoring
	[7089]	= { b=1500 },	-- Pattern: Azure Silk Cloak
	[7114]	= { b=1000 },	-- Pattern: Azure Silk Gloves
	[6272]	= { b=300 },	-- Pattern: Blue Linen Robe
	[6270]	= { b=200 },	-- Pattern: Blue Linen Vest
	[6274]	= { b=400 },	-- Pattern: Blue Overalls
	[14627]	= { b=800 },	-- Pattern: Bright Yellow Shirt
	[6401]	= { b=1100 },	-- Pattern: Dark Silk Shirt
	[6275]	= { b=800 },	-- Pattern: Greater Adept's Robe
	[4355]	= { b=1500 },	-- Pattern: Icy Cloak
	[10314]	= { b=4000 },	-- Pattern: Lavender Mageweave Shirt
	[10311]	= { b=3000 },	-- Pattern: Orange Martial Shirt
	[10317]	= { b=4000 },	-- Pattern: Pink Mageweave Shirt
	[5771]	= { b=200 },	-- Pattern: Red Linen Bag
	[5772]	= { b=500 },	-- Pattern: Red Woolen Bag
	[10326]	= { b=5000 },	-- Pattern: Tuxedo Jacket
	[10323]	= { b=4500 },	-- Pattern: Tuxedo Pants
	[10321]	= { b=4500 },	-- Pattern: Tuxedo Shirt
	[10325]	= { b=10000 },	-- Pattern: White Wedding Dress
	[10318]	= { b=7000 },	-- Pattern: Admiral's Hat
	[10728]	= { b=1500 },	-- Pattern: Black Swashbuckler's Shirt
	[7087]	= { b=1200 },	-- Pattern: Crimson Silk Cloak
	[7088]	= { b=5000 },	-- Pattern: Crimson Silk Robe
	[14630]	= { b=1000 },	-- Pattern: Enchanter's Cowl
	[14483]	= { b=16000 },	-- Pattern: Felcloth Pants
	[14526]	= { b=20000 },	-- Pattern: Mooncloth
	[14468]	= { b=12000 },	-- Pattern: Runecloth Bag
	[14488]	= { b=12000 },	-- Pattern: Runecloth Boots
	[14472]	= { b=12000 },	-- Pattern: Runecloth Cloak
	[14481]	= { b=16000 },	-- Pattern: Runecloth Gloves
	[14469]	= { b=12000 },	-- Pattern: Runecloth Robe
	[21358]	= { b=12000 },	-- Pattern: Soul Pouch
	[18487]	= { b=40000,	note=DM_LIBRARY  },			-- Pattern: Mooncloth Robe
	[17018]	= { b=80000,	note=THORIUM_FRIENDLY  },	-- Pattern: Flarecore Gloves
	[19220]	= { b=90000,	note=THORIUM_REVERED  },	-- Pattern: Flarecore Leggings
	[17017]	= { b=180000,	note=THORIUM_HONORED  },	-- Pattern: Flarecore Mantle
	[19219]	= { b=60000,	note=THORIUM_REVERED  },	-- Pattern: Flarecore Robe
	[19215]	= { b=22000, 	note=REQ_FACTION  },		-- Pattern: Wisdom of the Timbermaw
	[19218]	= { b=40000, 	note=REQ_FACTION  },		-- Pattern: Mantle of the Timbermaw
	[19216]	= { b=22000,	note=REQ_FACTION  },		-- Pattern: Argent Boots
	[19217]	= { b=40000,	note=REQ_FACTION  },		-- Pattern: Argent Shoulders
	[19766]	= { b=50000,	note=REQ_FACTION  },		-- Pattern: Bloodvine Boots
	[19765]	= { b=50000,	note=REQ_FACTION  },		-- Pattern: Bloodvine Leggings
	[19764]	= { b=50000,	note=REQ_FACTION  },		-- Pattern: Bloodvine Vest
	[22310]	= { b=20000,	note=REQ_FACTION  },		-- Pattern: Cenarion Herb Bag
	[22312]	= { b=50000,	note=REQ_FACTION  },		-- Pattern: Satchel of Cenarius
	[22307]	= { b=6000,		note=REQ_FACTION  },		-- Pattern: Enchanted Mageweave Pouch
	[22308]	= { b=20000,	note=REQ_FACTION  },		-- Pattern: Enchanted Runecloth Bag
	[22683] = { b=90000,	note=REQ_FACTION }, -- Pattern: Gaea's Embrace 
	[22773] = { b=50000,	note=REQ_FACTION  }, -- Pattern: Sylvan Crown 
	[22772] = { b=50000,	note=REQ_FACTION  }, -- Pattern: Sylvan Shoulders 
	[22774] = { b=50000,	note=REQ_FACTION  }, -- Pattern: Sylvan Vest 
	

-- Cooking
	[16072]	= { b=10000 },	-- Expert Cookbook
	[13949]	= { b=20000 },	-- Recipe: Baked Salmon
	[4609]	= { b=1000 },	-- Recipe: Barbecued Buzzard Wing
	[2889]	= { b=240 },	-- Recipe: Beer Basted Boar Ribs
	[3734]	= { b=1600 },	-- Recipe: Big Bear Steak
	[3679]	= { b=400 },	-- Recipe: Blood Sausage
	[6325]	= { b=40 },		-- Recipe: Brilliant Smallfish
	[6330]	= { b=1200 },	-- Recipe: Bristle Whisker Catfish
	[5528]	= { b=800 },	-- Recipe: Clam Chowder
	[2698]	= { b=400 },	-- Recipe: Cooked Crab Claw
	[3681]	= { b=1600 },	-- Recipe: Crocolisk Gumbo
	[3678]	= { b=400 },	-- Recipe: Crocolisk Steak
	[3682]	= { b=1600 },	-- Recipe: Curiously Tasty Omelet
	[12239]	= { b=7000 },	-- Recipe: Dragonbreath Chili
	[5485]	= { b=400 },	-- Recipe: Fillet of Frenzy
	[3683]	= { b=1600 },	-- Recipe: Gooey Spider Cake
	[2697]	= { b=400 },	-- Recipe: Goretusk Liver Pie
	[12240]	= { b=7000 },	-- Recipe: Heavy Kodo Stew
	[20075]	= { b=2000 },	-- Recipe: Heavy Crocolisk Stew
	[3735]	= { b=1800 },	-- Recipe: Hot Lion Chops
	[12229]	= { b=5000 },	-- Recipe: Hot Wolf Ribs
	[12231]	= { b=3000 },	-- Recipe: Jungle Stew
	[5489]	= { b=1200 },	-- Recipe: Lean Venison
	[13947]	= { b=20000 },	-- Recipe: Lobster Stew
	[6329]	= { b=400 },	-- Recipe: Loch Frenzy Delight
	[6328]	= { b=400 },	-- Recipe: Longjaw Mud Snapper
	[13948]	= { b=20000 },	-- Recipe: Mightfish Steak
	[17062]	= { b=2200 },	-- Recipe: Mithril Head Trout
	[3680]	= { b=1600 },	-- Recipe: Murloc Fin Soup
	[12233]	= { b=3000 },	-- Recipe: Mystery Stew
	[6368]	= { b=400 },	-- Recipe: Rainbow Fin Albacore
	[2699]	= { b=800 },	-- Recipe: Redridge Goulash
	[12228]	= { b=5000 },	-- Recipe: Roast Raptor
	[6369]	= { b=2200 },	-- Recipe: Rockscale Cod
	[2701]	= { b=1600 },	-- Recipe: Seasoned Wolf Kabob
	[6326]	= { b=40 },		-- Recipe: Slitherskin Mackerel
	[6892]	= { b=250 },	-- Recipe: Smoked Bear Meat
	[16111]	= { b=12000 },	-- Recipe: Spiced Chili Crab
	[2700]	= { b=400 },	-- Recipe: Succulent Pork Ribs
	[18046]	= { b=12000 },	-- Recipe: Tender Wolf Steak
	[728]	= { b=200 },	-- Recipe: Westfall Stew
	[12226]	= { b=25 },		-- Recipe: Crispy Bat Wing
	[5488]	= { b=400 },	-- Recipe: Crispy Lizard Tail
	[5484]	= { b=240 },	-- Recipe: Roasted Kodo Meat
	[5483]	= { b=140 },	-- Recipe: Scorpid Surprise
	[5486]	= { b=440 },	-- Recipe: Strider Stew
	[12232]	= { b=5000 },	-- Recipe: Carrion Surprise
	[13940]	= { b=16000 },	-- Recipe: Cooked Glossy Mightfish
	[13941]	= { b=16000 },	-- Recipe: Filet of Redgill
	[6039]	= { b=5000 },	-- Recipe: Giant Clam Scorcho
	[13942]	= { b=16000 },	-- Recipe: Grilled Squid
	[13943]	= { b=16000 },	-- Recipe: Hot Smoked Bass
	[12227]	= { b=1600 },	-- Recipe: Lean Wolf Steak
	[16110]	= { b=12000 },	-- Recipe: Monster Omelet
	[13945]	= { b=20000 },	-- Recipe: Nightfin Soup
	[13946]	= { b=20000 },	-- Recipe: Poached Sunscale Salmon
	[13939]	= { b=16000 },	-- Recipe: Spotted Yellowtail
	[16767]	= { b=3000 },	-- Recipe: Undermine Clam Chowder
	[21099]	= { b=500 },	-- Recipe: Smoked Sagefish
	[21219]	= { b=5000 },	-- Recipe: Sagefish Delight
	[17201]	= { b=240,	note=SEASONAL_VENDOR  },	-- Recipe: Egg Nog
	[17200]	= { b=25,	note=SEASONAL_VENDOR  },	-- Recipe: Gingerbread Cookie

-- Fishing
	[16083]	= { b=10000 },	-- Expert Fishing - The Bass and You

-- First Aid
	[16084]	= { b=10000 },	-- Expert First Aid - Under Wraps
	[16112]	= { b=2200 },	-- Manual: Heavy Silk Bandage
	[16113]	= { b=5000 },	-- Manual: Mageweave Bandage
	[19442]	= { b=100000,	note=REQ_FACTION},	-- Formula: Powerful Anti-Venom

};

FAS_DarkmoonInfo = {
	[19933]	= DARKMOON,		-- Glowing Scorpid Blood
	[11404]	= DARKMOON,		-- Evil Bat Eye
	[5117]	= DARKMOON,		-- Vibrant Plume
	[11407]	= DARKMOON,		-- Torn Bear Pelt
	[4582]	= DARKMOON,		-- Soft Bushy Tail
	[5134]	= DARKMOON,		-- Small Furry Paw
};

FAS_TokenInfo = {
-- ZG uncommon/rare tokens are no longer used for class-gear quests (only remaining use is to turn in for rep)
--	[19698]	=	{ 19835, 19827, 19831, 19838, 19842, 20034 },	-- Zulian Coin
--	[19699]	=	{ 19841, 19830, 19832, 19835, 19839, 19845 },	-- Razzashi Coin
--	[19700]	=	{ 19834, 19840, 19842, 19828, 19832, 19849 },	-- Hakkari Coin
--	[19701]	=	{ 19838, 19824, 19845, 19831, 19829, 19848 },	-- Gurubashi Coin
--	[19702]	=	{ 19825, 19823, 19848, 19836, 19840, 19846 },	-- Vilebranch Coin
--	[19703]	=	{ 19828, 19849, 19846, 19827, 19841, 19824 },	-- Witherbark Coin
--	[19704]	=	{ 19839, 19843, 20034, 19825, 19822, 19833 },	-- Sandfury Coin
--	[19705]	=	{ 19833, 19829, 20033, 19826, 19834, 19823 },	-- Skullsplitter Coin
--	[19706]	=	{ 19836, 19826, 19822, 19843, 19830, 20033 },	-- Bloodscalp Coin
--
--	[19707]	=	{ 19827, 19840, 19848 },	-- Red Hakkari Bijou
--	[19708]	=	{ 19836, 19830, 19846 },	-- Blue Hakkari Bijou
--	[19709]	=	{ 19843, 19833, 19824 },	-- Yellow Hakkari Bijou
--	[19710]	=	{ 19842, 19849, 19845 },	-- Orange Hakkari Bijou
--	[19711]	=	{ 19839, 19823, 19832 },	-- Green Hakkari Bijou
--	[19712]	=	{ 19835, 19826, 19829 },	-- Purple Hakkari Bijou
--	[19713]	=	{ 19838, 19822, 19841 },	-- Bronze Hakkari Bijou
--	[19714]	=	{ 19831, 20033, 20034 },	-- Silver Hakkari Bijou
--	[19715]	=	{ 19825, 19834, 19828 },	-- Gold Hakkari Bijou

	[19813]	=	{ 19782 },	-- Punctured Voodoo Doll (warrior)
	[19814]	=	{ 19784 },	-- Punctured Voodoo Doll (rogue)
	[19815]	=	{ 19783 },	-- Punctured Voodoo Doll (paladin)
	[19816]	=	{ 19785 },	-- Punctured Voodoo Doll (hunter)
	[19817]	=	{ 19786 },	-- Punctured Voodoo Doll (shaman)
	[19818]	=	{ 19787 },	-- Punctured Voodoo Doll (mage)
	[19819]	=	{ 19788 },	-- Punctured Voodoo Doll (warlock)
	[19820]	=	{ 19789 },	-- Punctured Voodoo Doll (priest)
	[19821]	=	{ 19790 },	-- Punctured Voodoo Doll (druid)
	
	[22637]	=	{ 19782, 19783, 19784, 19785, 19786, 19787, 19788, 19789, 19790 },	-- Primal Hakkari Idol
	
	[19716]	=	{ 19827, 19833, 19846 },	-- Primal Hakkari Bindings
	[19717]	=	{ 19836, 19830, 19824 },	-- Primal Hakkari Armsplint
	[19718]	=	{ 19840, 19843, 19848 },	-- Primal Hakkari Stanchion
	[19719]	=	{ 19835, 19823, 19829 },	-- Primal Hakkari Girdle
	[19720]	=	{ 19839, 19842, 19849 },	-- Primal Hakkari Sash
	[19721]	=	{ 19826, 19832, 19845 },	-- Primal Hakkari Shawl
	[19722]	=	{ 19825, 19838, 19828 },	-- Primal Hakkari Tabard
	[19723]	=	{ 19822, 20033, 20034 },	-- Primal Hakkari Kossack
	[19724]	=	{ 19834, 19841, 19831 },	-- Primal Hakkari Aegis

	[20884]	=	{ 21408, 21393, 21399, 21414, 21396 },	-- Qiraji Magisterial Ring
	[20888]	=	{ 21405, 21402, 21417, 21411 },			-- Qiraji Ceremonial Ring
	[20886]	=	{ 21404, 21401, 21392, 21398, 21395 },	-- Qiraji Spiked Hilt
	[20890]	=	{ 21410, 21407, 21416, 21413 },			-- Qiraji Ornate Hilt
	[20885]	=	{ 21412, 21394, 21406, 21415 },			-- Qiraji Martial Drape
	[20889]	=	{ 21403, 21397, 21409, 21418, 21400 },	-- Qiraji Regal Drape

	[21232]	=	{ 21242, 21272, 21244, 21269 },			-- Imperial Qiraji Armaments
	[21237]	=	{ 21273, 21275, 21268 },				-- Imperial Qiraji Regalia

	[20928]	=	{ 21350, 21349, 21359, 21361, 21367, 
				  21365, 21333, 21330 },				-- Qiraji Bindings of Command
	[20932]	=	{ 21391, 21388, 21373, 21338, 21344, 
				  21345, 21354, 21355, 21335, 21376 },	-- Qiraji Bindings of Dominance
	[20927]	=	{ 21352, 21362, 21346, 21332 },			-- Ouro's Intact Hide
	[20931]	=	{ 21390, 21368, 21375, 21336, 21356 },	-- Skin of the Great Sandworm
	[20930]	=	{ 21387, 21360, 21366, 21372, 21353 },	-- Vek'lor's Diadem
	[20926]	=	{ 21337, 21347, 21329, 21348 },			-- Vek'nilash's Circlet
	[20929]	=	{ 21389, 21364, 21370, 21374, 21331 },	-- Carapace of the Old God
	[20933]	=	{ 21351, 21334, 21343, 21357 },			-- Husk of the Old God

	[20858]	=	{ 21405, 21403, 21387, 21351, 21417, 21362, 21365, 21372, 21345, 
				  21415, 21356, 21355, 21392, 21407, 21334, 21329, 21330 },			-- Stone Scarab
	[20859]	=	{ 21404, 21412, 21402, 21397, 21391, 21352, 21416, 21370, 21336, 
		 		  21343, 21414, 21354, 21353, 21376, 21349, 21360, 21400, 21333 },	-- Gold Scarab
	[20860]	=	{ 21401, 21389, 21350, 21361, 21368, 21374, 21337, 21413, 21344, 
		 		  21346, 21399, 21348, 21396, 21411, 21331, 21394, 21409, 21355 },	-- Silver Scarab
	[20861]	=	{ 21408, 21410, 21393, 21388, 21406, 21349, 21418, 21398, 21364, 
		 		  21366, 21373, 21347, 21332, 21357, 21395, 21335, 21390, 21345 },	-- Bronze Scarab
	[20862]	=	{ 21392, 21407, 21359, 21367, 21334, 21329, 21405, 21403, 21387, 
		 		  21391, 21351, 21417, 21362, 21372, 21344, 21415, 21356, 21376 },	-- Crystal Scarab
	[20863]	=	{ 21360, 21338, 21400, 21330, 21404, 21412, 21402, 21397, 21388, 
		 		  21352, 21416, 21361, 21370, 21373, 21336, 21343, 21414, 21353 },	-- Clay Scarab
	[20864]	=	{ 21394, 21409, 21401, 21389, 21359, 21368, 21365, 21374, 21337, 
		 		  21413, 21346, 21399, 21354, 21348, 21396, 21411, 21331, 21335 },	-- Bone Scarab
	[20865]	=	{ 21390, 21375, 21333, 21408, 21410, 21393, 21406, 21350, 21418, 
		 		  21398, 21364, 21367, 21366, 21338, 21347, 21332, 21357, 21395 },	-- Ivory Scarab

	[20866]	=	{ 21401, 21406, 21414 },		-- Azure Idol
	[20867]	=	{ 21405, 21394, 21416 },		-- Onyx Idol
	[20868]	=	{ 21410, 21403, 21393 },		-- Lambent Idol
	[20869]	=	{ 21402, 21418, 21398, 21395 },	-- Amber Idol
	[20870]	=	{ 21412, 21407, 21417 },		-- Jasper Idol
	[20871]	=	{ 21397, 21413, 21400, 21411 },	-- Obsidian Idol
	[20872]	=	{ 21404, 21409, 21399, 21396 },	-- Vermillion Idol
	[20873]	=	{ 21408, 21392, 21415 },		-- Alabaster Idol

	[20874]	=	{ 21361, 21368, 21344, 21343, 21329 },					-- Idol of the Sun
	[20875]	=	{ 21362, 21338, 21334, 21347, 21330 },					-- Idol of Night
	[20876]	=	{ 21351, 21349, 21337, 21345, 21332 },					-- Idol of Death
	[20877]	=	{ 21389, 21388, 21374, 21373, 21346, 21348, 21335 },	-- Idol of the Sage
	[20878]	=	{ 21387, 21350, 21372, 21336, 21355, 21357 },			-- Idol of Rebirth
	[20879]	=	{ 21391, 21352, 21370, 21365, 21353, 21376 },			-- Idol of Life
	[20881]	=	{ 21390, 21364, 21359, 21366, 21375, 21354 },			-- Idol of Strife
	[20882]	=	{ 21360, 21367, 21333, 21356, 21331 },					-- Idol of War
};

local ZG = "ZG_FACTION";
local AQ20 = "AQ20_FACTION";
local AQ40 = "AQ40_FACTION";
FAS_TokenFactions = { ZG, AQ20, AQ40 };
FAS_TokenRewards = {
	[19822]	=	{ class="WARRIOR",	faction=ZG,	rep=7,	type=INVTYPE_CHEST },		-- Vindicator's Breastplate
	[19823]	=	{ class="WARRIOR",	faction=ZG,	rep=6,	type=INVTYPE_WAIST },		-- Vindicator's Belt
	[19824]	=	{ class="WARRIOR",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Vindicator's Armguards
	[19825]	=	{ class="PALADIN",	faction=ZG,	rep=7,	type=INVTYPE_CHEST },		-- Freethinker's Breastplate
	[19826]	=	{ class="PALADIN",	faction=ZG,	rep=6,	type=INVTYPE_WAIST },		-- Freethinker's Belt
	[19827]	=	{ class="PALADIN",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Freethinker's Armguards
	[19828]	=	{ class="SHAMAN",	faction=ZG,	rep=7,	type=INVTYPE_CHEST },		-- Augur's Hauberk
	[19829]	=	{ class="SHAMAN",	faction=ZG,	rep=6,	type=INVTYPE_WAIST },		-- Augur's Belt
	[19830]	=	{ class="SHAMAN",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Augur's Bracers
	[19831]	=	{ class="HUNTER",	faction=ZG,	rep=7,	type=INVTYPE_SHOULDER },	-- Predator's Mantle
	[19832]	=	{ class="HUNTER",	faction=ZG,	rep=6,	type=INVTYPE_WAIST },		-- Predator's Belt
	[19833]	=	{ class="HUNTER",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Predator's Bracers
	[19834]	=	{ class="ROGUE",	faction=ZG,	rep=7,	type=INVTYPE_CHEST },		-- Madcap's Tunic
	[19835]	=	{ class="ROGUE",	faction=ZG,	rep=6,	type=INVTYPE_SHOULDER },	-- Madcap's Mantle
	[19836]	=	{ class="ROGUE",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Madcap's Bracers
	[19838]	=	{ class="DRUID",	faction=ZG,	rep=7,	type=INVTYPE_CHEST },		-- Haruspex's Tunic
	[19839]	=	{ class="DRUID",	faction=ZG,	rep=6,	type=INVTYPE_WAIST },		-- Haruspex's Belt
	[19840]	=	{ class="DRUID",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Haruspex's Bracers
	[19841]	=	{ class="PRIEST",	faction=ZG,	rep=7,	type=INVTYPE_SHOULDER },	-- Confessor's Mantle
	[19842]	=	{ class="PRIEST",	faction=ZG,	rep=6,	type=INVTYPE_WAIST },		-- Confessor's Bindings
	[19843]	=	{ class="PRIEST",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Confessor's Wraps
	[19845]	=	{ class="MAGE", 	faction=ZG,	rep=6,	type=INVTYPE_SHOULDER },	-- Illusionist's Mantle
	[19846]	=	{ class="MAGE", 	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Illusionist's Wraps
	[20034]	=	{ class="MAGE", 	faction=ZG,	rep=7,	type=INVTYPE_CHEST },		-- Illusionist's Robes
	[19848]	=	{ class="WARLOCK",	faction=ZG,	rep=5,	type=INVTYPE_WRIST },	-- Demoniac's Wraps
	[19849]	=	{ class="WARLOCK",	faction=ZG,	rep=6,	type=INVTYPE_SHOULDER },	-- Demoniac's Mantle
	[20033]	=	{ class="WARLOCK",	faction=ZG,	rep=7,	type=INVTYPE_CHEST },		-- Demoniac's Robes	

	[19782]	=	{ class="WARRIOR",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Presence of Might	
	[19783]	=	{ class="PALADIN",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Syncretist's Sigil	
	[19784]	=	{ class="ROGUE",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Death's Embrace	
	[19785]	=	{ class="HUNTER",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Falcon's Call	
	[19786]	=	{ class="SHAMAN",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Vodouisant's Vigilant Embrace	
	[19787]	=	{ class="MAGE", 	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Presence of Sight	
	[19788]	=	{ class="WARLOCK",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Hoodoo Hex	
	[19789]	=	{ class="PRIEST",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Prophetic Aura	
	[19790]	=	{ class="DRUID",	faction=ZG,	rep=5,	type=ENSCRIBE },	-- Animist's Caress	

	[21392]	=	{ class="WARRIOR",	faction=AQ20,	rep=8,	type=AXE },	-- Sickle of Unyielding Strength	
	[21393]	=	{ class="WARRIOR",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Signet of Unyielding Strength	
	[21394]	=	{ class="WARRIOR",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Drape of Unyielding Strength	
	[21395]	=	{ class="PALADIN",	faction=AQ20,	rep=8,	type=SWORD },	-- Blade of Eternal Justice	
	[21396]	=	{ class="PALADIN",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Ring of Eternal Justice	
	[21397]	=	{ class="PALADIN",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Cape of Eternal Justice	
	[21398]	=	{ class="SHAMAN",	faction=AQ20,	rep=8,	type=MACE },	-- Hammer of the Gathering Storm	
	[21399]	=	{ class="SHAMAN",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Ring of the Gathering Storm	
	[21400]	=	{ class="SHAMAN",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Cloak of the Gathering Storm	
	[21401]	=	{ class="HUNTER",	faction=AQ20,	rep=8,	type=AXE },	-- Scythe of the Unseen Path	
	[21402]	=	{ class="HUNTER",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Signet of the Unseen Path	
	[21403]	=	{ class="HUNTER",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Cloak of the Unseen Path	
	[21404]	=	{ class="ROGUE",	faction=AQ20,	rep=8,	type=DAGGER },	-- Dagger of Veiled Shadows	
	[21405]	=	{ class="ROGUE",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Band of Veiled Shadows	
	[21406]	=	{ class="ROGUE",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Cloak of Veiled Shadows	
	[21407]	=	{ class="DRUID",	faction=AQ20,	rep=8,	type=MACE },	-- Mace of Unending Life	
	[21408]	=	{ class="DRUID",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Band of Unending Life	
	[21409]	=	{ class="DRUID",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Cloak of Unending Life	
	[21410]	=	{ class="PRIEST",	faction=AQ20,	rep=8,	type=MACE },	-- Gavel of Infinite Wisdom	
	[21411]	=	{ class="PRIEST",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Ring of Infinite Wisdom	
	[21412]	=	{ class="PRIEST",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Shroud of Infinite Wisdom	
	[21413]	=	{ class="MAGE", 	faction=AQ20,	rep=8,	type=SWORD },		-- Blade of Vaulted Secrets	
	[21414]	=	{ class="MAGE", 	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Band of Vaulted Secrets
	[21415]	=	{ class="MAGE", 	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Drape of Vaulted Secrets	
	[21416]	=	{ class="WARLOCK",	faction=AQ20,	rep=8,	type=DAGGER },	-- Kris of Unspoken Names	
	[21417]	=	{ class="WARLOCK",	faction=AQ20,	rep=6,	type=INVTYPE_FINGER },		-- Ring of Unspoken Names	
	[21418]	=	{ class="WARLOCK",	faction=AQ20,	rep=7,	type=INVTYPE_CLOAK },		-- Shroud of Unspoken Names	

	[21273]	=	{ class="ANY",	faction=AQ40,	type=STAFF },		-- Blessed Qiraji Acolyte Staff	
	[21275]	=	{ class="ANY",	faction=AQ40,	type=STAFF },		-- Blessed Qiraji Augur Staff	
	[21268]	=	{ class="ANY",	faction=AQ40,	type=MACE },	-- Blessed Qiraji War Hammer	
	[21355]	=	{ class="ANY",	faction=AQ40,	type=AXE },		-- Blessed Qiraji War Axe	
	[21388]	=	{ class="ANY",	faction=AQ40,	type=GUN },		-- Blessed Qiraji Musket	
	[21333]	=	{ class="ANY",	faction=AQ40,	type=DAGGER },	-- Blessed Qiraji Pugio	
	[21359]	=	{ class="ANY",	faction=AQ40,	type=SHIELD },	-- Blessed Qiraji Bulwark	

	[21329]	=	{ class="WARRIOR",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Conqueror's Crown	
	[21330]	=	{ class="WARRIOR",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Conqueror's Spaulders	
	[21331]	=	{ class="WARRIOR",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Conqueror's Breastplate	
	[21332]	=	{ class="WARRIOR",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Conqueror's Legguards	
	[21333]	=	{ class="WARRIOR",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Conqueror's Greaves	
	[21334]	=	{ class="WARLOCK",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Doomcaller's Robes	
	[21335]	=	{ class="WARLOCK",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Doomcaller's Mantle	
	[21336]	=	{ class="WARLOCK",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Doomcaller's Trousers	
	[21337]	=	{ class="WARLOCK",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Doomcaller's Circlet	
	[21338]	=	{ class="WARLOCK",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Doomcaller's Footwraps	
	[21343]	=	{ class="MAGE", 	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Enigma Robes	
	[21344]	=	{ class="MAGE", 	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Enigma Boots	
	[21345]	=	{ class="MAGE", 	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Enigma Shoulderpads	
	[21346]	=	{ class="MAGE", 	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Enigma Leggings	
	[21347]	=	{ class="MAGE", 	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Enigma Circlet	
	[21348]	=	{ class="PRIEST",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Tiara of the Oracle	
	[21349]	=	{ class="PRIEST",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Footwraps of the Oracle	
	[21350]	=	{ class="PRIEST",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Mantle of the Oracle	
	[21351]	=	{ class="PRIEST",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Vestments of the Oracle	
	[21352]	=	{ class="PRIEST",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Trousers of the Oracle	
	[21353]	=	{ class="DRUID",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Genesis Helm	
	[21354]	=	{ class="DRUID",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Genesis Shoulderpads	
	[21355]	=	{ class="DRUID",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Genesis Boots	
	[21356]	=	{ class="DRUID",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Genesis Trousers	
	[21357]	=	{ class="DRUID",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Genesis Vest	
	[21359]	=	{ class="ROGUE",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Deathdealer's Boots	
	[21360]	=	{ class="ROGUE",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Deathdealer's Helm	
	[21361]	=	{ class="ROGUE",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Deathdealer's Spaulders	
	[21362]	=	{ class="ROGUE",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Deathdealer's Leggings	
	[21364]	=	{ class="ROGUE",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Deathdealer's Vest	
	[21365]	=	{ class="HUNTER",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Striker's Footguards	
	[21366]	=	{ class="HUNTER",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Striker's Diadem	
	[21367]	=	{ class="HUNTER",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Striker's Pauldrons	
	[21368]	=	{ class="HUNTER",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Striker's Leggings	
	[21370]	=	{ class="HUNTER",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Striker's Hauberk	
	[21372]	=	{ class="SHAMAN",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Stormcaller's Diadem	
	[21373]	=	{ class="SHAMAN",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Stormcaller's Footguards	
	[21374]	=	{ class="SHAMAN",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Stormcaller's Hauberk	
	[21375]	=	{ class="SHAMAN",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Stormcaller's Leggings	
	[21376]	=	{ class="SHAMAN",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Stormcaller's Pauldrons	
	[21387]	=	{ class="PALADIN",	faction=AQ40,	rep=5,	type=INVTYPE_HEAD },		-- Avenger's Crown	
	[21388]	=	{ class="PALADIN",	faction=AQ40,	rep=4,	type=INVTYPE_FEET },		-- Avenger's Greaves	
	[21389]	=	{ class="PALADIN",	faction=AQ40,	rep=6,	type=INVTYPE_CHEST },		-- Avenger's Breastplate	
	[21390]	=	{ class="PALADIN",	faction=AQ40,	rep=5,	type=INVTYPE_LEGS },		-- Avenger's Legguards	
	[21391]	=	{ class="PALADIN",	faction=AQ40,	rep=4,	type=INVTYPE_SHOULDER },	-- Avenger's Pauldrons	
};

FAS_TokenNames = {
-- ZG uncommon/rare tokens are no longer used for class-gear quests (only remaining use is to turn in for rep)
	[19698]	=	"Zulian Coin",
	[19699]	=	"Razzashi Coin",
	[19700]	=	"Hakkari Coin",
	[19701]	=	"Gurubashi Coin",
	[19702]	=	"Vilebranch Coin",
	[19703]	=	"Witherbark Coin",
	[19704]	=	"Sandfury Coin",
	[19705]	=	"Skullsplitter Coin",
	[19706]	=	"Bloodscalp Coin",
                
	[19707]	=	"Red Hakkari Bijou",
	[19708]	=	"Blue Hakkari Bijou",
	[19709]	=	"Yellow Hakkari Bijou",
	[19710]	=	"Orange Hakkari Bijou",
	[19711]	=	"Green Hakkari Bijou",
	[19712]	=	"Purple Hakkari Bijou",
	[19713]	=	"Bronze Hakkari Bijou",
	[19714]	=	"Silver Hakkari Bijou",
	[19715]	=	"Gold Hakkari Bijou",
                
	[19813]	=	"Punctured Voodoo Doll",	-- (warrior)
	[19814]	=	"Punctured Voodoo Doll",	-- (rogue)
	[19815]	=	"Punctured Voodoo Doll",	-- (paladin)
	[19816]	=	"Punctured Voodoo Doll",	-- (hunter)
	[19817]	=	"Punctured Voodoo Doll",	-- (shaman)
	[19818]	=	"Punctured Voodoo Doll",	-- (mage)
	[19819]	=	"Punctured Voodoo Doll",	-- (warlock)
	[19820]	=	"Punctured Voodoo Doll",	-- (priest)
	[19821]	=	"Punctured Voodoo Doll",	-- (druid)
	
	[22637]	=	"Primal Hakkari Idol",

	[19716]	=	"Primal Hakkari Bindings",
	[19717]	=	"Primal Hakkari Armsplint",
	[19718]	=	"Primal Hakkari Stanchion",
	[19719]	=	"Primal Hakkari Girdle",
	[19720]	=	"Primal Hakkari Sash",
	[19721]	=	"Primal Hakkari Shawl",
	[19722]	=	"Primal Hakkari Tabard",
	[19723]	=	"Primal Hakkari Kossack",
	[19724]	=	"Primal Hakkari Aegis",
                
	[20884]	=	"Qiraji Magisterial Ring",
	[20888]	=	"Qiraji Ceremonial Ring",
	[20885]	=	"Qiraji Martial Drape",
	[20889]	=	"Qiraji Regal Drape",
	[20886]	=	"Qiraji Spiked Hilt",
	[20890]	=	"Qiraji Ornate Hilt",
                
	[21232]	=	"Imperial Qiraji Armaments",
	[21237]	=	"Imperial Qiraji Regalia",
                
	[20928]	=	"Qiraji Bindings of Command",
	[20932]	=	"Qiraji Bindings of Dominance",
	[20927]	=	"Ouro's Intact Hide",
	[20931]	=	"Skin of the Great Sandworm",
	[20930]	=	"Vek'lor's Diadem",
	[20926]	=	"Vek'nilash's Circlet",
	[20929]	=	"Carapace of the Old God",
	[20933]	=	"Husk of the Old God",
                
	[20858]	=	"Stone Scarab",
	[20859]	=	"Gold Scarab",
	[20860]	=	"Silver Scarab",
	[20861]	=	"Bronze Scarab",
	[20862]	=	"Crystal Scarab",
	[20863]	=	"Clay Scarab",
	[20864]	=	"Bone Scarab",
	[20865]	=	"Ivory Scarab",
                
	[20866]	=	"Azure Idol",
	[20867]	=	"Onyx Idol",
	[20868]	=	"Lambent Idol",
	[20869]	=	"Amber Idol",
	[20870]	=	"Jasper Idol",
	[20871]	=	"Obsidian Idol",
	[20872]	=	"Vermillion Idol",
	[20873]	=	"Alabaster Idol",
                
	[20874]	=	"Idol of the Sun",
	[20875]	=	"Idol of Night",
	[20876]	=	"Idol of Death",
	[20877]	=	"Idol of the Sage",
	[20878]	=	"Idol of Rebirth",
	[20879]	=	"Idol of Life",
	[20881]	=	"Idol of Strife",
	[20882]	=	"Idol of War",
};

FAS_TokenQuality = {
-- ZG uncommon/rare tokens are no longer used for class-gear quests (only remaining use is to turn in for rep)
	[19698]	=	2,	-- Zulian Coin
	[19699]	=	2,	-- Razzashi Coin
	[19700]	=	2,	-- Hakkari Coin
	[19701]	=	2,	-- Gurubashi Coin
	[19702]	=	2,	-- Vilebranch Coin
	[19703]	=	2,	-- Witherbark Coin
	[19704]	=	2,	-- Sandfury Coin
	[19705]	=	2,	-- Skullsplitter Coin
	[19706]	=	2,	-- Bloodscalp Coin

	[19707]	=	3,	-- Red Hakkari Bijou
	[19708]	=	3,	-- Blue Hakkari Bijou
	[19709]	=	3,	-- Yellow Hakkari Bijou
	[19710]	=	3,	-- Orange Hakkari Bijou
	[19711]	=	3,	-- Green Hakkari Bijou
	[19712]	=	3,	-- Purple Hakkari Bijou
	[19713]	=	3,	-- Bronze Hakkari Bijou
	[19714]	=	3,	-- Silver Hakkari Bijou
	[19715]	=	3,	-- Gold Hakkari Bijou

	[19813]	=	2,	-- Punctured Voodoo Doll (warrior)
	[19814]	=	2,	-- Punctured Voodoo Doll (rogue)
	[19815]	=	2,	-- Punctured Voodoo Doll (paladin)
	[19816]	=	2,	-- Punctured Voodoo Doll (hunter)
	[19817]	=	2,	-- Punctured Voodoo Doll (shaman)
	[19818]	=	2,	-- Punctured Voodoo Doll (mage)
	[19819]	=	2,	-- Punctured Voodoo Doll (warlock)
	[19820]	=	2,	-- Punctured Voodoo Doll (priest)
	[19821]	=	2,	-- Punctured Voodoo Doll (druid)
	
	[22637]	=	3,	-- Primal Hakkari Idol

	[19716]	=	4,	-- Primal Hakkari Bindings
	[19717]	=	4,	-- Primal Hakkari Armsplint
	[19718]	=	4,	-- Primal Hakkari Stanchion
	[19719]	=	4,	-- Primal Hakkari Girdle
	[19720]	=	4,	-- Primal Hakkari Sash
	[19721]	=	4,	-- Primal Hakkari Shawl
	[19722]	=	4,	-- Primal Hakkari Tabard
	[19723]	=	4,	-- Primal Hakkari Kossack
	[19724]	=	4,	-- Primal Hakkari Aegis

	-- we use this quality array to also determine how many of an item you need for a quest,
	-- because there's currently a consistent formula for it. (5x green A, 5x green B, 2x blue, 1x epic)
	-- except in AQ20 the "epic" piece is in some cases actually a blue, so we label it 3.1 here;
	-- it still shows shows up blue, but we catch that it's not the same as a 3(.0) item.
	[20884]	=	3.1,	-- Qiraji Magisterial Ring
	[20888]	=	3.1,	-- Qiraji Ceremonial Ring
	[20885]	=	3.1,	-- Qiraji Martial Drape
	[20889]	=	3.1,	-- Qiraji Regal Drape
	[20886]	=	4,	-- Qiraji Spiked Hilt
	[20890]	=	4,	-- Qiraji Ornate Hilt

	[21232]	=	4,	-- Imperial Qiraji Armaments
	[21237]	=	4,	-- Imperial Qiraji Regalia

	[20928]	=	4,	-- Qiraji Bindings of Command
	[20932]	=	4,	-- Qiraji Bindings of Dominance
	[20927]	=	4,	-- Ouro's Intact Hide
	[20931]	=	4,	-- Skin of the Great Sandworm
	[20930]	=	4,	-- Vek'lor's Diadem
	[20926]	=	4,	-- Vek'nilash's Circlet
	[20929]	=	4,	-- Carapace of the Old God
	[20933]	=	4,	-- Husk of the Old God

	[20858]	=	2,	-- Stone Scarab
	[20859]	=	2,	-- Gold Scarab
	[20860]	=	2,	-- Silver Scarab
	[20861]	=	2,	-- Bronze Scarab
	[20862]	=	2,	-- Crystal Scarab
	[20863]	=	2,	-- Clay Scarab
	[20864]	=	2,	-- Bone Scarab
	[20865]	=	2,	-- Ivory Scarab

	[20866]	=	3,	-- Azure Idol
	[20867]	=	3,	-- Onyx Idol
	[20868]	=	3,	-- Lambent Idol
	[20869]	=	3,	-- Amber Idol
	[20870]	=	3,	-- Jasper Idol
	[20871]	=	3,	-- Obsidian Idol
	[20872]	=	3,	-- Vermillion Idol
	[20873]	=	3,	-- Alabaster Idol

	[20874]	=	3,	-- Idol of the Sun
	[20875]	=	3,	-- Idol of Night
	[20876]	=	3,	-- Idol of Death
	[20877]	=	3,	-- Idol of the Sage
	[20878]	=	3,	-- Idol of Rebirth
	[20879]	=	3,	-- Idol of Life
	[20881]	=	3,	-- Idol of Strife
	[20882]	=	3,	-- Idol of War
}

FAS_FactionTokenSets = {
	["ZG"] = {
		{ 19698, 19699, 19700 }, 	-- Zulian, Razzashi, and Hakkari Coins	
		{ 19701, 19702, 19703 },	-- Gurubashi, Vilebranch, and Witherbark Coins
		{ 19704, 19705, 19706 },	-- Sandfury, Skullsplitter, and Bloodscalp Coins
	
		{ 19707 },		-- Red Hakkari Bijou
		{ 19708 },		-- Blue Hakkari Bijou
		{ 19709 },		-- Yellow Hakkari Bijou
		{ 19710 },		-- Orange Hakkari Bijou
		{ 19711 },		-- Green Hakkari Bijou
		{ 19712 },		-- Purple Hakkari Bijou
		{ 19713 },		-- Bronze Hakkari Bijou
		{ 19714 },		-- Silver Hakkari Bijou
		{ 19715 },		-- Gold Hakkari Bijou
	},
	["AD"] = {
		{ 22525 },		-- Crypt Fiend Parts
		{ 22526 },		-- Bone Fragments
		{ 22527 },		-- Core of Elements
		{ 22528 },		-- Dark Iron Scraps
		{ 22529 },		-- Savage Frond
	},
};


------------------------------------------------------
-- AdSpace_Vendors.lua
-- Originally based on the tables at http://members.cox.net/katy-w/Trades/Home.htm
-- Corrected / extended with info from http://wow.allakhazam.com and http://wowguru.com
------------------------------------------------------
-- LOCALIZATION NOTE: the english recipe names in here are just comments;
--  it won't do anything in-game if you translate them.
------------------------------------------------------

FAS_VendorLocations = {
-- not actually splitting this up by faction, but I've got it sorted that way in case I decide to later.
--	["Alliance"] = {
		["Alexandra Bolero"] = "Stormwind City",
		["Amy Davenport"] = "Redridge Mountains",
		["Androd Fadran"] = "Arathi Highlands",
		["Blimo Gadgetspring"] = "Azshara",
		["Bombus Finespindle"] = "Ironforge",
		["Brienna Starglow"] = "Feralas",
		["Catherine Leland"] = "Stormwind City",
		["Clyde Ranthal"] = "Redridge Mountains",
		["Corporal Bluth"] = "Stranglethorn Vale",
		["Dalria"] = "Ashenvale",
		["Danielle Zipstitch"] = "Duskwood",
		["Darian Singh"] = "Stormwind City",
		["Defias Profiteer"] = "Westfall",
		["Deneb Walker"] = "Arathi Highlands",
		["Drac Roughcut"] = "Loch Modan",
		["Drake Lindgren"] = "Elwynn Forest",
		["Drovnar Strongbrew"] = "Arathi Highlands",
		["Elynna"] = "Darnassus",
		["Erika Tate"] = "Stormwind City",
		["Fradd Swiftgear"] = "Wetlands",
		["Fyldan"] = "Darnassus",
		["Gearcutter Cogspinner"] = "Ironforge",
		["Gigget Zipcoil"] = "The Hinterlands",
		["Gina MacGregor"] = "Westfall",
		["Gloria Femmel"] = "Redridge Mountains",
		["Gretta Ganter"] = "Dun Morogh",
		["Hammon Karwn"] = "Arathi Highlands",
		["Harggan"] = "The Hinterlands",
		["Harklan Moongrove"] = "Ashenvale",
		["Harlown Darkweave"] = "Ashenvale",
		["Heldan Galesong"] = "Darkshore",
		["Helenia Olden"] = "Dustwallow Marsh",
		["Janet Hommers"] = "Desolace",
		["Jannos Ironwill"] = "Arathi Highlands",
		["Jennabink Powerseam"] = "Wetlands",
		["Rann Flamespinner"] = "Loch Modan",
		["Jessara Cordell"] = "Stormwind City",
		["Jubie Gadgetspring"] = "Azshara",
		["Kaita Deepforge"] = "Stormwind City",
		["Kendor Kabonka"] = "Stormwind City",
		["Khara Deepwater"] = "Loch Modan",
		["Khole Jinglepocket"] = "Stormwind City",
		["Kriggon Talsone"] = "Westfall",
		["Laird"] = "Darkshore",
		["Lardan"] = "Ashenvale",
		["Leonard Porter"] = "Western Plaguelands",
		["Lindea Rabonne"] = "Hillsbrad Foothills",
		["Logannas"] = "Feralas",
		["Malygen"] = "Felwood",
		["Maria Lumere"] = "Stormwind City",
		["Mavralyn"] = "Darkshore",
		["Micha Yance"] = "Hillsbrad Foothills",
		["Mythrin'dir"] = "Darnassus",
		["Namdo Bizzfizzle"] = "Gnomeregan",
		["Nandar Branson"] = "Hillsbrad Foothills",
		["Narj Deepslice"] = "Arathi Highlands",
		["Nessa Shadowsong"] = "Teldrassil",
		["Nina Lightbrew"] = "Blasted Lands",
		["Nioma"] = "The Hinterlands",
		["Nyoma"] = "Teldrassil",
		["Outfitter Eric"] = "Ironforge",
		["Pratt McGrubben"] = "Feralas",
		["Rann Flamespinner"] = "Loch Modan",
		["Ruppo Zipcoil"] = "The Hinterlands",
		["Saenorion"] = "Darnassus",
		["Shandrina"] = "Ashenvale",
		["Sheri Zipstitch"] = "Duskwood",
		["Soolie Berryfizz"] = "Ironforge",
		["Stuart Fleming"] = "Wetlands",
		["Tansy Puddlefizz"] = "Ironforge",
		["Tharynn Bouden"] = "Elwynn Forest",
		["Tilli Thistlefuzz"] = "Ironforge",
		["Truk Wildbeard"] = "The Hinterlands",
		["Ulthaan"] = "Ashenvale",
		["Ulthir"] = "Darnassus",
		["Vaean"] = "Darkshore",
		["Valdaron"] = "Darkshore",
		["Vivianna"] = "Feralas",
		["Wenna Silkbeard"] = "Wetlands",
		["Wulmort Jinglepocket"] = "Ironforge",
		["Xandar Goodbeard"] = "Loch Modan",
--	},
--	["Horde"] = {
		["Abigail Shiel"] = "Tirisfal Glades",
		["Algernon"] = "Undercity",
		["Andrew Hilbert"] = "Silverpine Forest",
		["Balai Lok'Wein"] = "Dustwallow Marsh",
		["Bale"] = "Felwood",
		["Banalash"] = "Swamp of Sorrows",
		["Borya"] = "Orgrimmar",
		["Bronk"] = "Feralas",
		["Christoph Jeffcoat"] = "Hillsbrad Foothills",
		["Constance Brisboise"] = "Tirisfal Glades",
		["Daniel Bartlett"] = "Undercity",
		["Derak Nightfall"] = "Hillsbrad Foothills",
		["Emrul Riknussun"] = "Ironforge",
		["George Candarte"] = "Hillsbrad Foothills",
		["Gharash"] = "Swamp of Sorrows",
		["Ghok'kah"] = "Dustwallow Marsh",
		["Grimtak"] = "Durotar",
		["Hagrus"] = "Orgrimmar",
		["Harn Longcast"] = "Mulgore",
		["Hula'mahi"] = "The Barrens",
		["Jandia"] = "Thousand Needles",
		["Jangdor Swiftstrider"] = "Feralas",
		["Jeeda"] = "Stonetalon Mountains",
		["Joseph Moore"] = "Undercity",
		["Jun'ha"] = "Arathi Highlands",
		["Keena"] = "Arathi Highlands",
		["Killian Sanatha"] = "Silverpine Forest",
		["Kireena"] = "Desolace",
		["Kithas"] = "Orgrimmar",
		["Kor'geld"] = "Orgrimmar",
		["Kulwia"] = "Stonetalon Mountains",
		["Leo Sarn"] = "Silverpine Forest",
		["Lilly"] = "Silverpine Forest",
		["Lizbeth Cromwell"] = "Undercity",
		["Mahu"] = "Thunder Bluff",
		["Mallen Swain"] = "Hillsbrad Foothills",
		["Martine Tramblay"] = "Tirisfal Glades",
		["Millie Gregorian"] = "Undercity",
		["Montarr"] = "Thousand Needles",
		["Muuran"] = "Desolace",
		["Naal Mistrunner"] = "Thunder Bluff",
		["Nata Dawnstrider"] = "Thunder Bluff",
		["Nerrist"] = "Stranglethorn Vale",
		["Ogg'marr"] = "Dustwallow Marsh",
		["Otho Moji'ko"] = "The Hinterlands",
		["Penney Copperpinch"] = "Orgrimmar",
		["Rartar"] = "Swamp of Sorrows",
		["Ronald Burch"] = "Undercity",
		["Sewa Mistrunner"] = "Thunder Bluff",
		["Shankys"] = "Orgrimmar",
		["Sheendra Tallgrass"] = "Feralas",
		["Sovik"] = "Orgrimmar",
		["Sumi"] = "Orgrimmar",
		["Tamar"] = "Orgrimmar",
		["Tarban Hearthgrain"] = "The Barrens",
		["Tari'qa"] = "The Barrens",
		["Thaddeus Webb"] = "Undercity",
		["Tunkk"] = "Arathi Highlands",
		["Uthok"] = "Stranglethorn Vale",
		["Vharr"] = "Stranglethorn Vale",
		["Werg Thickblade"] = "Tirisfal Glades",
		["Wik'Tar"] = "Ashenvale",
		["Worb Strongstitch"] = "Feralas",
		["Wrahk"] = "The Barrens",
		["Wulan"] = "Desolace",
		["Wunna Darkmane"] = "Mulgore",
		["Yonada"] = "The Barrens",
		["Zansoa"] = "Durotar",
		["Zargh"] = "The Barrens",
--	},
--	["Neutral"] = {
		["Aendel Windspear"] = "Silithus",
		["Alchemist Pestlezugg"] = "Tanaris",
		["Argent Quartermaster Hasana"] = "Tirisfal Glades",
		["Argent Quartermaster Lightspark"] = "Western Plaguelands",
		["Blixrez Goodstitch"] = "Stranglethorn Vale",
		["Bliztik"] = "Duskwood",
		["Bro'kin"] = "Alterac Mountains",
		["Cowardly Crosby"] = "Stranglethorn Vale",
		["Crazk Sparks"] = "Stranglethorn Vale",
		["Darnall"] = "Moonglade",
		["Dirge Quikcleave"] = "Tanaris",
		["Evie Whirlbrew"] = "Winterspring",
		["Gagsprocket"] = "The Barrens",
		["Gikkix"] = "Tanaris",
		["Glyx Brewright"] = "Stranglethorn Vale",
		["Gnaz Blunderflame"] = "Stranglethorn Vale",
		["Himmik"] = "Winterspring",
		["Jabbey"] = "Tanaris",
		["Jaquilina Dramet"] = "Stranglethorn Vale",
		["Jase Farlane"] = "Eastern Plaguelands",
		["Jazzrik"] = "Badlands",
		["Jinky Twizzlefixxit"] = "Thousand Needles",
		["Jutak"] = "Stranglethorn Vale",
		["Kalldan Felmoon"] = "Wailing Caverns",
		["Kania"] = "Silithus",
		["Kelsey Yance"] = "Stranglethorn Vale",
		["Kiknikle"] = "The Barrens",
		["Kilxx"] = "The Barrens",
		["Knaz Blunderflame"] = "Stranglethorn Vale",
		["Krinkle Goodsteel"] = "Tanaris",
		["Kzixx"] = "Duskwood",
		["Lieutenant General Andorov"] = "Ruins of Ahn'Qiraj",
		["Lokhtos Darkbargainer"] = "Blackrock Depths",
		["Lorelae Wintersong"] = "Moonglade",
		["Magnus Frostwake"] = "Western Plaguelands",
		["Masat T'andr"] = "Swamp of Sorrows",
		["Master Craftsman Omarion"] = "Naxxramas",
		["Mazk Snipeshot"] = "Stranglethorn Vale",
		["Meilosh"] = "Felwood",
		["Mishta"] = "Silithus",
		["Narkk"] = "Stranglethorn Vale",
		["Nergal"] = "Un'Goro Crater",
		["Old Man Heming"] = "Stranglethorn Vale",
		["Plugger Spazzring"] = "Blackrock Depths",
		["Qia"] = "Winterspring",
		["Quartermaster Miranda Breechlock"] = "Eastern Plaguelands",
		["Ranik"] = "The Barrens",
		["Rikqiz"] = "Stranglethorn Vale",
		["Rin'wosho the Trader"] = "Stranglethorn Vale",
		["Rizz Loosebolt"] = "Alterac Mountains",
		["Shen'dralar Provisioner"] = "Dire Maul",
		["Super-Seller 680"] = "Desolace",
		["Vargus"] = "Silithus",
		["Veenix"] = "Stonetalon Mountains",
		["Vendor-Tron 1000"] = "Desolace",
		["Vizzklick"] = "Tanaris",
		["Xizk Goodstitch"] = "Stranglethorn Vale",
		["Xizzer Fizzbolt"] = "Winterspring",
		["Yuka Screwspigot"] = "Burning Steppes",
		["Zan Shivsproket"] = "Hillsbrad Foothills",
		["Zannok Hidepiercer"] = "Silithus",
		["Zarena Cromwind"] = "Stranglethorn Vale",
		["Zixil"] = "Hillsbrad Foothills",
		
-- Libram turnin NPCs
		["Lorekeeper Lydros"] = "Dire Maul",
		["Mathredis Firestar"] = "Burning Steppes",

--	},
};

FAS_VendorInfo = {
	["Alliance"] = {
	-- Alchemy
		[9300]	= { "Nina Lightbrew" },						-- Recipe: Elixir of Demonslaying
		[9301]	= { "Maria Lumere" },						-- Recipe: Elixir of Shadow Power
		[13478]	= { "Soolie Berryfizz" },					-- Recipe: Elixir of Superior Defense
		[6055]	= { "Nandar Branson" },						-- Recipe: Fire Protection Potion
		[5642]	= { "Soolie Berryfizz", "Ulthir" },			-- Recipe: Free Action Potion
		[6056]	= { "Drovnar Strongbrew" },					-- Recipe: Frost Protection Potion
		[9302]	= { "Logannas" },							-- Recipe: Ghost Dye
		[5643]	= { "Ulthir" },								-- Recipe: Great Rage Potion
		[6053]	= { "Xandar Goodbeard" },					-- Recipe: Holy Protection Potion
		[6057]	= { "Logannas" },							-- Recipe: Nature Protection Potion
		[5640]	= { "Defias Profiteer", "Xandar Goodbeard", "Harklan Moongrove" },	-- Recipe: Rage Potion
		[13477]	= { "Ulthir" },														-- Recipe: Superior Mana Potion
		
	-- Blacksmithing
		[12162]	= { "Kaita Deepforge"},		-- Plans: Hardened Iron Shortsword
		[7995]	= { "Harggan" },			-- Plans: Mithril Scale Bracers
		[10858]	= { "Jannos Ironwill" },	-- Plans: Solid Iron Maul

	-- Enchanting
		[6349]	= { "Tilli Thistlefuzz" },								-- Formula: Enchant 2H Weapon - Lesser Intellect
		[11223]	= { "Mythrin'dir" },									-- Formula: Enchant Bracer - Deflection
		[11163]	= { "Micha Yance" },									-- Formula: Enchant Bracer - Lesser Deflection
		[11101]	= { "Dalria" },											-- Formula: Enchant Bracer - Lesser Strength
		[6342]	= { "Jessara Cordell", "Tilli Thistlefuzz", "Vaean" },	-- Formula: Enchant Chest - Minor Mana
		[11039]	= { "Dalria" },											-- Formula: Enchant Cloak - Minor Agility
		[11152]	= { "Tharynn Bouden" },									-- Formula: Enchant Gloves - Fishing
		[16217]	= { "Mythrin'dir" },									-- Formula: Enchant Shield - Greater Stamina
		[20758]	= { "Jessara Cordell", "Tilli Thistlefuzz", "Vaean" },	-- Formula: Minor Wizard Oil
		[20752]	= { "Jessara Cordell", "Tilli Thistlefuzz", "Vaean" },	-- Formula: Minor Mana Oil
		[20753]	= { "Jessara Cordell", "Tilli Thistlefuzz", "Vaean" },	-- Formula: Lesser Wizard Oil

	-- Engineering
		[18649]	= { "Darian Singh", "Gearcutter Cogspinner" },	-- Schematic: Blue Firework
		[10607]	= { "Jubie Gadgetspring" },						-- Schematic: Deepdive Helmet
		[7560]	= { "Gearcutter Cogspinner" },					-- Schematic: Gnomish Universal Remote
		[13309]	= { "Fradd Swiftgear" },						-- Schematic: Lovingly Crafted Boomstick
		[14639]	= { "Fradd Swiftgear", "Namdo Bizzfizzle" },	-- Schematic: Minor Recombobulator
		[10609]	= { "Ruppo Zipcoil" },							-- Schematic: Mithril Mechanical Dragonling
		[16041]	= { "Gearcutter Cogspinner" },					-- Schematic: Thorium Grenade
		[16042]	= { "Gearcutter Cogspinner" },					-- Schematic: Thorium Widget

	-- Leatherworking
		[18949]	= { "Saenorion" },						-- Pattern: Barbaric Bracers
		[5973]	= { "Hammon Karwn", "Lardan" },			-- Pattern: Barbaric Leggings
		[7289]	= { "Clyde Ranthal" },					-- Pattern: Black Whelp Cloak
		[20576]	= { "Amy Davenport" },					-- Pattern: Black Whelp Tunic
		[15751]	= { "Blimo Gadgetspring" },				-- Pattern: Blue Dragonscale Breastplate
		[15729]	= { "Blimo Gadgetspring" },				-- Pattern: Chimeric Gloves
		[7613]	= { "Wenna Silkbeard" },				-- Pattern: Green Leather Armor
		[7451]	= { "Pratt McGrubben", "Saenorion" },	-- Pattern: Green Whelp Bracers
		[18731]	= { "Bombus Finespindle" },				-- Pattern: Heavy Leather Ball
		[7361]	= { "Harlown Darkweave" },				-- Pattern: Herbalist's Gloves
		[15735]	= { "Gigget Zipcoil" },					-- Pattern: Ironfeather Shoulders
		[15734]	= { "Pratt McGrubben" },				-- Pattern: Living Shoulders
		[5786]	= { "Gina MacGregor", "Mavralyn" },		-- Pattern: Murloc Scale Belt
		[5789]	= { "Helenia Olden" },					-- Pattern: Murloc Scale Bracers
		[5787]	= { "Gina MacGregor", "Mavralyn" },		-- Pattern: Murloc Scale Breastplate
		[8409]	= { "Nioma" },							-- Pattern: Nightscape Shoulders
		[13288]	= { "Androd Fadran" },					-- Pattern: Raptor Hide Belt
		[7290]	= { "Wenna Silkbeard" },				-- Pattern: Red Whelp Gloves
		[15741]	= { "Leonard Porter" },					-- Pattern: Stormshroud Pants
		[5788]	= { "Micha Yance" },					-- Pattern: Thick Murloc Armor
		[8385]	= { "Pratt McGrubben" },				-- Pattern: Turtle Scale Gloves
		[15725]	= { "Leonard Porter" },					-- Pattern: Wicked Leather Gauntlets
		
	-- Tailoring
		[7089]	= { "Brienna Starglow" },									-- Pattern: Azure Silk Cloak
		[7114]	= { "Wenna Silkbeard" },									-- Pattern: Azure Silk Gloves
		[6272]	= { "Drake Lindgren", "Elynna" },							-- Pattern: Blue Linen Robe
		[6270]	= { "Tharynn Bouden", "Valdaron" },							-- Pattern: Blue Linen Vest
		[6274]	= { "Gina MacGregor", "Alexandra Bolero" },					-- Pattern: Blue Overalls
		[14627]	= { "Danielle Zipstitch" },									-- Pattern: Bright Yellow Shirt
		[6401]	= { "Sheri Zipstitch" },									-- Pattern: Dark Silk Shirt
		[6275]	= { "Elynna", "Jennabink Powerseam", "Rann Flamespinner", "Sheri Zipstitch" },	-- Pattern: Greater Adept's Robe
		[4355]	= { "Micha Yance" },										-- Pattern: Icy Cloak
		[10314]	= { "Outfitter Eric" },										-- Pattern: Lavender Mageweave Shirt
		[10311]	= { "Elynna" },												-- Pattern: Orange Martial Shirt
		[10317]	= { "Outfitter Eric" },										-- Pattern: Pink Mageweave Shirt
		[5771]	= { "Gina MacGregor", "Valdaron" },							-- Pattern: Red Linen Bag
		[5772]	= { "Amy Davenport", "Jennabink Powerseam",  "Rann Flamespinner", "Valdaron" },	-- Pattern: Red Woolen Bag
		[10326]	= { "Outfitter Eric" },										-- Pattern: Tuxedo Jacket
		[10323]	= { "Outfitter Eric" },										-- Pattern: Tuxedo Pants
		[10321]	= { "Outfitter Eric" },										-- Pattern: Tuxedo Shirt
		[10325]	= { "Alexandra Bolero" },									-- Pattern: White Wedding Dress
		[22307]	= { "Jessara Cordell", "Tilli Thistlefuzz", "Vaean" },		-- Pattern: Enchanted Mageweave Pouch

	-- Cooking
		[16072]	= { "Shandrina" },													-- Expert Cookbook
		[13949]	= { "Vivianna" },													-- Recipe: Baked Salmon
		[4609]	= { "Narj Deepslice" },												-- Recipe: Barbecued Buzzard Wing
		[2889]	= { "Kendor Kabonka" },												-- Recipe: Beer Basted Boar Ribs
		[3734]	= { "Ulthaan" },													-- Recipe: Big Bear Steak
		[3679]	= { "Kendor Kabonka" },												-- Recipe: Blood Sausage
		[6325]	= { "Catherine Leland", "Gretta Ganter", "Khara Deepwater", "Nyoma", "Tharynn Bouden" },	-- Recipe: Brilliant Smallfish
		[6330]	= { "Catherine Leland", "Lindea Rabonne", "Tharynn Bouden" },		-- Recipe: Bristle Whisker Catfish
		[5528]	= { "Heldan Galesong", "Kriggon Talsone" },							-- Recipe: Clam Chowder
		[2698]	= { "Kendor Kabonka" },												-- Recipe: Cooked Crab Claw
		[3681]	= { "Kendor Kabonka" },												-- Recipe: Crocolisk Gumbo
		[3678]	= { "Kendor Kabonka" },												-- Recipe: Crocolisk Steak
		[3682]	= { "Kendor Kabonka" },												-- Recipe: Curiously Tasty Omelet
		[12239]	= { "Helenia Olden" },												-- Recipe: Dragonbreath Chili
		[17201]	= { "Khole Jinglepocket", "Wulmort Jinglepocket" },					-- Recipe: Egg Nog
		[5485]	= { "Laird" },														-- Recipe: Fillet of Frenzy
		[17200]	= { "Khole Jinglepocket", "Wulmort Jinglepocket" },					-- Recipe: Gingerbread Cookie
		[3683]	= { "Kendor Kabonka" },												-- Recipe: Gooey Spider Cake
		[2697]	= { "Kendor Kabonka" },												-- Recipe: Goretusk Liver Pie
		[12240]	= { "Janet Hommers" },												-- Recipe: Heavy Kodo Stew
		[12229]	= { "Vivianna" },													-- Recipe: Hot Wolf Ribs
		[12231]	= { "Corporal Bluth" },												-- Recipe: Jungle Stew
		[5489]	= { "Ulthaan" },													-- Recipe: Lean Venison
		[13947]	= { "Vivianna" },													-- Recipe: Lobster Stew
		[6329]	= { "Khara Deepwater" },											-- Recipe: Loch Frenzy Delight
		[6328]	= { "Khara Deepwater", "Nyoma", "Tansy Puddlefizz", "Tharynn Bouden" },	-- Recipe: Longjaw Mud Snapper
		[13948]	= { "Vivianna" },													-- Recipe: Mightfish Steak
		[17062]	= { "Heldan Galesong", "Lindea Rabonne", "Stuart Fleming", "Tansy Puddlefizz" },	-- Recipe: Mithril Head Trout
		[16110]	= { "Malygen" },													-- Recipe: Monster Omelet
		[3680]	= { "Kendor Kabonka" },												-- Recipe: Murloc Fin Soup
		[12233]	= { "Helenia Olden", "Janet Hommers" },								-- Recipe: Mystery Stew
		[6368]	= { "Catherine Leland" , "Heldan Galesong", "Kriggon Talsone" , "Nessa Shadowsong" , "Stuart Fleming" },	-- Recipe: Rainbow Fin Albacore
		[2699]	= { "Kendor Kabonka" },												-- Recipe: Redridge Goulash
		[12228]	= { "Corporal Bluth", "Hammon Karwn" , "Helenia Olden" },			-- Recipe: Roast Raptor
		[6369]	= { "Heldan Galesong", "Lindea Rabonne" , "Stuart Fleming" , "Tansy Puddlefizz" },	-- Recipe: Rockscale Cod
		[2701]	= { "Kendor Kabonka" },												-- Recipe: Seasoned Wolf Kabob
		[6326]	= { "Kriggon Talsone", "Nessa Shadowsong", "Tansy Puddlefizz" },	-- Recipe: Slitherskin Mackerel
		[6892]	= { "Drac Roughcut" },												-- Recipe: Smoked Bear Meat
		[16111]	= { "Kriggon Talsone" },											-- Recipe: Spiced Chili Crab
		[2700]	= { "Kendor Kabonka" },												-- Recipe: Succulent Pork Ribs
		[18046]	= { "Truk Wildbeard" },												-- Recipe: Tender Wolf Steak
		[728]	= { "Kendor Kabonka" },												-- Recipe: Westfall Stew
		[21099]	= { "Micha Yance", "Fyldan", "Emrul Riknussun", "Gloria Femmel", "Erika Tate", "Nyoma" },	-- Recipe: Smoked Sagefish
		[21219]	= { "Micha Yance", "Fyldan", "Emrul Riknussun", "Gloria Femmel", "Erika Tate", "Nyoma" },	-- Recipe: Sagefish Delight
		
	-- First Aid
		[16084]	= { "Deneb Walker" },	-- Expert First Aid - Under Wraps
		[16112]	= { "Deneb Walker" },	-- Manual: Heavy Silk Bandage
		[16113]	= { "Deneb Walker" },	-- Manual: Mageweave Bandage
	},
	
	["Horde"] = {
	-- Alchemy
		[9300]	= { "Rartar" },				-- Recipe: Elixir of Demonslaying
		[9301]	= { "Algernon" },			-- Recipe: Elixir of Shadow Power
		[13478]	= { "Kor'geld" },			-- Recipe: Elixir of Superior Defense
		[6055]	= { "Jeeda" },				-- Recipe: Fire Protection Potion
		[5642]	= { "Kor'geld" },			-- Recipe: Free Action Potion
		[9302]	= { "Bronk" },				-- Recipe: Ghost Dye
		[5643]	= { "Hagrus" },				-- Recipe: Great Rage Potion
		[6053]	= { "Hula'mahi" },			-- Recipe: Holy Protection Potion
		[6057]	= { "Bronk" },				-- Recipe: Nature Protection Potion
		[5640]	= { "Hagrus" },				-- Recipe: Rage Potion
		[6068]	= { "Montarr" },			-- Recipe: Shadow Oil
		[6054]	= { "Christoph Jeffcoat" },	-- Recipe: Shadow Protection Potion
		[13477]	= { "Algernon" },			-- Recipe: Superior Mana Potion
		
	-- Blacksmithing
		[12162]	= { "Sumi" },		-- Plans: Hardened Iron Shortsword
		[12164]	= { "Vharr" },		-- Plans: Massive Iron Axe
		[7995]	= { "Gharash" },	-- Plans: Mithril Scale Bracers
		[10858]	= { "Muuran" },		-- Plans: Solid Iron Maul

	-- Enchanting
		[6349]	= { "Kithas", "Leo Sarn", "Nata Dawnstrider" },		-- Formula: Enchant 2H Weapon - Lesser Intellect
		[6377]	= { "Nata Dawnstrider" },							-- Formula: Enchant Boots - Minor Agility
		[11223]	= { "Banalash" },									-- Formula: Enchant Bracer - Deflection
		[11163]	= { "Keena" },										-- Formula: Enchant Bracer - Lesser Deflection
		[11101]	= { "Kulwia" },										-- Formula: Enchant Bracer - Lesser Strength
		[6346]	= { "Kithas", "Lilly" },							-- Formula: Enchant Chest - Lesser Mana
		[6342]	= { "Kithas", "Leo Sarn", "Lilly", "Nata Dawnstrider", "Thaddeus Webb" },	-- Formula: Enchant Chest - Minor Mana
		[11039]	= { "Kulwia" },										-- Formula: Enchant Cloak - Minor Agility
		[16217]	= { "Daniel Bartlett" },							-- Formula: Enchant Shield - Greater Stamina
		[20758]	= { "Kithas", "Nata Dawnstrider", "Thaddeus Webb", "Lilly", "Leo Sarn" },	-- Formula: Minor Wizard Oil
		[20752]	= { "Kithas", "Nata Dawnstrider", "Thaddeus Webb", "Lilly", "Leo Sarn" },	-- Formula: Minor Mana Oil
		[20753]	= { "Kithas", "Nata Dawnstrider", "Thaddeus Webb", "Lilly", "Leo Sarn" },	-- Formula: Lesser Wizard Oil
		
	-- Engineering
		[18647]	= { "Sovik" },	-- Schematic: Red Firework
		[16041]	= { "Sovik" },	-- Schematic: Thorium Grenade
		[16042]	= { "Sovik" },	-- Schematic: Thorium Widget

	-- Leatherworking
		[18949]	= { "Joseph Moore" },								-- Pattern: Barbaric Bracers
		[5973]	= { "Jandia", "Keena" },							-- Pattern: Barbaric Leggings
		[7613]	= { "George Candarte" },							-- Pattern: Green Leather Armor
		[7451]	= { "Jangdor Swiftstrider", "Joseph Moore" },		-- Pattern: Green Whelp Bracers
		[18731]	= { "Tamar" },										-- Pattern: Heavy Leather Ball
		[15734]	= { "Jangdor Swiftstrider" },						-- Pattern: Living Shoulders
		[5786]	= { "Andrew Hilbert" },								-- Pattern: Murloc Scale Belt
		[5787]	= { "Andrew Hilbert" },								-- Pattern: Murloc Scale Breastplate
		[8409]	= { "Jangdor Swiftstrider", "Worb Strongstitch" },	-- Pattern: Nightscape Shoulders
		[13287]	= { "Tunkk" },										-- Pattern: Raptor Hide Harness
		[15741]	= { "Werg Thickblade" },							-- Pattern: Stormshroud Pants
		[5788]	= { "Christoph Jeffcoat" },							-- Pattern: Thick Murloc Armor
		[8385]	= { "Jangdor Swiftstrider" },						-- Pattern: Turtle Scale Gloves
		[15725]	= { "Werg Thickblade" },							-- Pattern: Wicked Leather Gauntlets
		
	-- Tailoring
		[7089]	= { "Jun'ha" },													-- Pattern: Azure Silk Cloak
		[7114]	= { "Kireena" },												-- Pattern: Azure Silk Gloves
		[6272]	= { "Andrew Hilbert", "Wrahk" },								-- Pattern: Blue Linen Robe
		[6270]	= { "Borya", "Constance Brisboise", "Wrahk" },					-- Pattern: Blue Linen Vest
		[6274]	= { "Borya", "Mallen Swain", "Yonada" },						-- Pattern: Blue Overalls
		[6401]	= { "Mallen Swain" },											-- Pattern: Dark Silk Shirt
		[6275]	= { "Millie Gregorian" },										-- Pattern: Greater Adept's Robe
		[4355]	= { "Ghok'kah" },												-- Pattern: Icy Cloak
		[10314]	= { "Borya" },													-- Pattern: Lavender Mageweave Shirt
		[10311]	= { "Mahu" },													-- Pattern: Orange Martial Shirt
		[10317]	= { "Borya" },													-- Pattern: Pink Mageweave Shirt
		[5771]	= { "Andrew Hilbert", "Mahu" },									-- Pattern: Red Linen Bag
		[5772]	= { "Borya", "Mahu", "Millie Gregorian", "Wrahk", "Yonada" },	-- Pattern: Red Woolen Bag
		[10326]	= { "Millie Gregorian" },										-- Pattern: Tuxedo Jacket
		[10323]	= { "Millie Gregorian" },										-- Pattern: Tuxedo Pants
		[10321]	= { "Millie Gregorian" },										-- Pattern: Tuxedo Shirt
		[10325]	= { "Mahu" },													-- Pattern: White Wedding Dress
		[22307]	= { "Kithas", "Nata Dawnstrider", "Thaddeus Webb", "Lilly", "Leo Sarn" },		-- Pattern: Enchanted Mageweave Pouch

	-- Cooking
		[16072]	= { "Wulan" },									-- Expert Cookbook
		[13949]	= { "Sheendra Tallgrass" },						-- Recipe: Baked Salmon
		[6325]	= { "Harn Longcast", "Martine Tramblay", "Sewa Mistrunner", "Lizbeth Cromwell" },	-- Recipe: Brilliant Smallfish
		[6330]	= { "Derak Nightfall", "Naal Mistrunner", "Sewa Mistrunner", "Ronald Burch" },	-- Recipe: Bristle Whisker Catfish
		[12232]	= { "Banalash", "Kireena", "Ogg'marr" },		-- Recipe: Carrion Surprise
		[12226]	= { "Abigail Shiel" },							-- Recipe: Crispy Bat Wing
		[5488]	= { "Tari'qa" },								-- Recipe: Crispy Lizard Tail
		[3682]	= { "Keena", "Nerrist" },						-- Recipe: Curiously Tasty Omelet
		[12239]	= { "Ogg'marr" },								-- Recipe: Dragonbreath Chili
		[17201]	= { "Penney Copperpinch" },						-- Recipe: Egg Nog
		[17200]	= { "Penney Copperpinch" },						-- Recipe: Gingerbread Cookie
		[12240]	= { "Kireena" },								-- Recipe: Heavy Kodo Stew
		[20075]	= { "Ogg'marr" },								-- Recipe: Heavy Crocolisk Stew
		[3735]	= { "Zargh" },									-- Recipe: Hot Lion Chops
		[12229]	= { "Sheendra Tallgrass" },						-- Recipe: Hot Wolf Ribs
		[12231]	= { "Nerrist" },								-- Recipe: Jungle Stew
		[13947]	= { "Sheendra Tallgrass" },						-- Recipe: Lobster Stew
		[6328]	= { "Harn Longcast", "Killian Sanatha", "Naal Mistrunner", "Lizbeth Cromwell" },	-- Recipe: Longjaw Mud Snapper
		[13948]	= { "Sheendra Tallgrass" },						-- Recipe: Mightfish Steak
		[17062]	= { "Shankys", "Wik'Tar", "Wulan" },			-- Recipe: Mithril Head Trout
		[16110]	= { "Bale" },									-- Recipe: Monster Omelet
		[6368]	= { "Killian Sanatha", "Shankys", "Zansoa", "Ronald Burch" },	-- Recipe: Rainbow Fin Albacore
		[12228]	= { "Keena", "Nerrist", "Ogg'marr" },			-- Recipe: Roast Raptor
		[5484]	= { "Wunna Darkmane" },							-- Recipe: Roasted Kodo Meat
		[6369]	= { "Shankys", "Wik'Tar", "Wulan" },			-- Recipe: Rockscale Cod
		[5483]	= { "Grimtak" },								-- Recipe: Scorpid Surprise
		[6326]	= { "Martine Tramblay", "Zansoa" },				-- Recipe: Slitherskin Mackerel
		[6892]	= { "Andrew Hilbert" },							-- Recipe: Smoked Bear Meat
		[16111]	= { "Banalash", "Uthok" },						-- Recipe: Spiced Chili Crab
		[5486]	= { "Tari'qa" },								-- Recipe: Strider Stew
		[21099]	= { "Wulan", "Derak Nightfall", "Naal Mistrunner", "Tarban Hearthgrain", "Ronald Burch", "Otho Moji'ko" },	-- Recipe: Smoked Sagefish
		[21219]	= { "Wulan", "Derak Nightfall", "Naal Mistrunner", "Tarban Hearthgrain", "Ronald Burch", "Otho Moji'ko" },	-- Recipe: Sagefish Delight
		
	-- First Aid
		[16084]	= { "Balai Lok'Wein", "Ghok'kah" },	-- Expert First Aid - Under Wraps
		[16112]	= { "Balai Lok'Wein", "Ghok'kah" },	-- Manual: Heavy Silk Bandage
		[16113]	= { "Balai Lok'Wein", "Ghok'kah" },	-- Manual: Mageweave Bandage
	},
	
	["Neutral"] = {
	-- Alchemy
		[13501]	= { "Magnus Frostwake" },						-- Recipe: Major Mana Potion
		[13485]	= { "Magnus Frostwake" },						-- Recipe: Transmute Water to Air
		[13482]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Recipe: Transmute Air to Fire
		[13484]	= { "Meilosh" },								-- Recipe: Transmute Earth to Water
		[13483]	= { "Plugger Spazzring" },						-- Recipe: Transmute Fire to Earth
		[20013]	= { "Rin'wosho the Trader" },					-- Recipe: Living Action Potion
		[20011]	= { "Rin'wosho the Trader" },					-- Recipe: Mageblood Potion
		[20014]	= { "Rin'wosho the Trader" },					-- Recipe: Major Troll's Blood Potion
		[20012]	= { "Rin'wosho the Trader" },					-- Recipe: Greater Dreamless Sleep Potion

		[5642]	= { "Vendor-Tron 1000" },						-- Recipe: Free Action Potion
		[14634]	= { "Bro'kin" },								-- Recipe: Frost Oil
		[6056]	= { "Glyx Brewright" },							-- Recipe: Frost Protection Potion
		[5643]	= { "Vendor-Tron 1000" },						-- Recipe: Great Rage Potion
		[6053]	= { "Kzixx" },									-- Recipe: Holy Protection Potion
		[13480]	= { "Evie Whirlbrew" },							-- Recipe: Major Healing Potion
		[6057]	= { "Glyx Brewright", "Alchemist Pestlezugg"},	-- Recipe: Nature Protection Potion
		[9303]	= { "Alchemist Pestlezugg" },					-- Recipe: Philosophers' Stone
		[5640]	= { "Ranik" },									-- Recipe: Rage Potion
		[6068]	= { "Bliztik" },								-- Recipe: Shadow Oil
		[12958]	= { "Alchemist Pestlezugg" },					-- Recipe: Transmute Arcanite
		[9304]	= { "Alchemist Pestlezugg" },					-- Recipe: Transmute Iron to Gold
		[9305]	= { "Alchemist Pestlezugg" },					-- Recipe: Transmute Mithril to Truesilver
		[20761]	= { "Lokhtos Darkbargainer" },		-- Recipe: Transmute Elemental Fire
		
	-- Blacksmithing
		[8030]	= { "Magnus Frostwake" },		-- Plans: Ebon Shiv
		[12823]	= { "Magnus Frostwake" },		-- Plans: Huge Thorium Battleaxe
		[12819]	= { "Magnus Frostwake" },		-- Plans: Ornate Thorium Handaxe
		[12703]	= { "Magnus Frostwake" },		-- Plans: Storm Gauntlets
		[19208]	= { "Lokhtos Darkbargainer" },	-- Plans: Black Amnesty
		[19209]	= { "Lokhtos Darkbargainer" },	-- Plans: Blackfury
		[19211]	= { "Lokhtos Darkbargainer" },	-- Plans: Blackguard
		[17051]	= { "Lokhtos Darkbargainer" },	-- Plans: Dark Iron Bracers
		[17060]	= { "Lokhtos Darkbargainer" },	-- Plans: Dark Iron Destroyer
		[19207]	= { "Lokhtos Darkbargainer" },	-- Plans: Dark Iron Gauntlets
		[19206]	= { "Lokhtos Darkbargainer" },	-- Plans: Dark Iron Helm
		[17052]	= { "Lokhtos Darkbargainer" },	-- Plans: Dark Iron Leggings
		[17059]	= { "Lokhtos Darkbargainer" },	-- Plans: Dark Iron Reaver
		[20040]	= { "Lokhtos Darkbargainer" },	-- Plans: Dark Iron Boots
		[19210]	= { "Lokhtos Darkbargainer" },	-- Plans: Ebon Hand
		[17049]	= { "Lokhtos Darkbargainer" },	-- Plans: Fiery Chain Girdle
		[17053]	= { "Lokhtos Darkbargainer" },	-- Plans: Fiery Chain Shoulders
		[19212]	= { "Lokhtos Darkbargainer" },	-- Plans: Nightfall
		[19202]	= { "Meilosh" },				-- Plans: Heavy Timbermaw Belt
		[19204]	= { "Meilosh" },				-- Plans: Heavy Timbermaw Boots
		[19203]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Plans: Girdle of the Dawn
		[19205]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Plans: Gloves of the Dawn
		[19781]	= { "Rin'wosho the Trader" },	-- Plans: Darksoul Shoulders
		[19780]	= { "Rin'wosho the Trader" },	-- Plans: Darksoul Leggings
		[19779]	= { "Rin'wosho the Trader" },	-- Plans: Darksoul Breastplate
		[19778]	= { "Rin'wosho the Trader" },	-- Plans: Bloodsoul Gauntlets
		[19777]	= { "Rin'wosho the Trader" },	-- Plans: Bloodsoul Shoulders
		[19776]	= { "Rin'wosho the Trader" },	-- Plans: Bloodsoul Breastplate
		[22219]	= { "Lieutenant General Andorov" },		-- Plans: Jagged Obsidian Shield
		[22221]	= { "Lieutenant General Andorov" },		-- Plans: Obsidian Mail Tunic
		[22209]	= { "Vargus" },		-- Plans: Heavy Obsidian Belt
		[22214]	= { "Vargus" },		-- Plans: Light Obsidian Belt
		[22768] = { "Vargus" }, 	-- Plans: Ironvine Belt 
		[22766] = { "Vargus" }, 	-- Plans: Ironvine Breastplate 
		[22767] = { "Vargus" }, 	-- Plans: Ironvine Gloves
		--[00000] = { "Master Craftsman Omarion" }, -- Plans: Icebane Bracers
		--[00000] = { "Master Craftsman Omarion" }, -- Plans: Icebane Gauntlests
		--[00000] = { "Master Craftsman Omarion" }, -- Plans: Icebane Breastplate
		
		[6047]	= { "Krinkle Goodsteel" },	-- Plans: Golden Scale Coif
		[12162]	= { "Jutak" },				-- Plans: Hardened Iron Shortsword
		[12164]	= { "Jaquilina Dramet" },	-- Plans: Massive Iron Axe
		[12163]	= { "Zarena Cromwind" },	-- Plans: Moonsteel Broadsword
		[10858]	= { "Jazzrik" },			-- Plans: Solid Iron Maul

	-- Enchanting
		[19449]	= { "Lokhtos Darkbargainer" },	-- Formula: Enchant Weapon - Mighty Intellect
		[19448]	= { "Lokhtos Darkbargainer" },	-- Formula: Enchant Weapon - Mighty Spirit
		[19444]	= { "Lokhtos Darkbargainer" },	-- Formula: Enchant Weapon - Strength
		[19445]	= { "Meilosh" },				-- Formula: Enchant Weapon - Agility
		[22392]	= { "Meilosh" },		-- Formula: 2H Weapon - Agility (timbermaw)
		[19447]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Formula: Enchant Bracer - Healing
		[19446]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Formula: Enchant Bracer - Mana Regeneration
		[20732]	= { "Kania" },	-- Formula: Cloak - Greater Fire Resistance
		[20733]	= { "Kania" },	-- Formula: Cloak - Greater Nature Resistance
		[20756]	= { "Rin'wosho the Trader" },	-- Formula: Brilliant Wizard Oil
		[20757]	= { "Rin'wosho the Trader" },	-- Formula: Brilliant Mana Oil

		[6377]	= { "Zixil" },					-- Formula: Enchant Boots - Minor Agility
		[16221]	= { "Qia" },					-- Formula: Enchant Chest - Major Health
		[16224]	= { "Lorelae Wintersong" },		-- Formula: Enchant Cloak - Superior Defense
		[16243]	= { "Lorelae Wintersong" },		-- Formula: Runed Arcanite Rod
		[6342]	= { "Kania" },					-- Formula: Enchant Chest - Minor Mana
		[20758]	= { "Kania" },					-- Formula: Minor Wizard Oil
		[20752]	= { "Kania" },					-- Formula: Minor Mana Oil
		[20753]	= { "Kania" },					-- Formula: Lesser Wizard Oil
		[20754]	= { "Kania" },					-- Formula: Lesser Mana Oil
		[20755]	= { "Kania" },					-- Formula: Wizard Oil

	-- Engineering
		[20001]	= { "Rin'wosho the Trader" },	-- Schematic: Bloodvine Lens
		[20000]	= { "Rin'wosho the Trader" },	-- Schematic: Bloodvine Goggles

		[13310]	= { "Mazk Snipeshot", "Super-Seller 680" },				-- Schematic: Accurate Scope
		[10602]	= { "Knaz Blunderflame", "Yuka Screwspigot" },			-- Schematic: Deadly Scope
		[16050]	= { "Xizzer Fizzbolt" },								-- Schematic: Delicate Arcanite Converter
		[7742]	= { "Zan Shivsproket" },								-- Schematic: Gnomish Cloaking Device
		[7560]	= { "Jinky Twizzlefixxit" },							-- Schematic: Gnomish Universal Remote
		[7561]	= { "Kzixx", "Super-Seller 680", "Veenix", "Zixil" },	-- Schematic: Goblin Jumper Cables
		[18648]	= { "Crazk Sparks", "Gagsprocket" },					-- Schematic: Green Firework
		[18652]	= { "Xizzer Fizzbolt" },								-- Schematic: Gyrofreeze Ice Reflector
		[13308]	= { "Rizz Loosebolt", "Super-Seller 680" },				-- Schematic: Ice Deflector
		[13309]	= { "Jinky Twizzlefixxit" },							-- Schematic: Lovingly Crafted Boomstick
		[16046]	= { "Xizzer Fizzbolt" },								-- Schematic: Masterwork Target Dummy
		[13311]	= { "Gnaz Blunderflame" },								-- Schematic: Mechanical Dragonling
		[18656]	= { "Xizzer Fizzbolt" },								-- Schematic: Powerful Seaforium Charge
		[16047]	= { "Xizzer Fizzbolt" },								-- Schematic: Thorium Tube
		[18651]	= { "Mazk Snipeshot" },									-- Schematic: Truesilver Transformer

	-- Leatherworking
		[17025]	= { "Lokhtos Darkbargainer" },	-- Pattern: Black Dragonscale Boots
		[19331]	= { "Lokhtos Darkbargainer" },	-- Pattern: Chromatic Gauntlets
		[19332]	= { "Lokhtos Darkbargainer" },	-- Pattern: Corehound Belt
		[17022]	= { "Lokhtos Darkbargainer" },	-- Pattern: Corehound Boots
		[19330]	= { "Lokhtos Darkbargainer" },	-- Pattern: Lava Belt
		[19333]	= { "Lokhtos Darkbargainer" },	-- Pattern: Molten Belt
		[17023]	= { "Lokhtos Darkbargainer" },	-- Pattern: Molten Helm
		[19326]	= { "Meilosh" },				-- Pattern: Might of the Timbermaw
		[19327]	= { "Meilosh" },				-- Pattern: Timbermaw Brawlers
		[15742]	= { "Meilosh" },				-- Pattern: Warbear Harness
		[15754]	= { "Meilosh" },				-- Pattern: Warbear Woolies
		[20253]	= { "Meilosh" },			-- Pattern: Warbear Harness
		[20254]	= { "Meilosh" },			-- Pattern: Warbear Woolies
		[19328]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Pattern: Dawn Treaders
		[19329]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Pattern: Golden Mantle of the Dawn
		[19771]	= { "Rin'wosho the Trader" },		-- Pattern: Primal Batskin Bracers
		[19773]	= { "Rin'wosho the Trader" },		-- Pattern: Blood Tiger Shoulders
		[19770]	= { "Rin'wosho the Trader" },		-- Pattern: Primal Batskin Gloves
		[19772]	= { "Rin'wosho the Trader" },		-- Pattern: Blood Tiger Breastplate
		[19769]	= { "Rin'wosho the Trader" },		-- Pattern: Primal Batskin Jerkin
		[20382]	= { "Aendel Windspear" },		-- Pattern: Dreamscale Breastplate
		[20506]	= { "Aendel Windspear" },		-- Pattern: Spitfire Bracers
		[20507]	= { "Aendel Windspear" },		-- Pattern: Spitfire Gauntlets
		[20508]	= { "Aendel Windspear" },		-- Pattern: Spitfire Breastplate
		[20509]	= { "Aendel Windspear" },		-- Pattern: Sandstalker Bracers
		[20510]	= { "Aendel Windspear" },		-- Pattern: Sandstalker Gauntlets
		[20511]	= { "Aendel Windspear" },		-- Pattern: Sandstalker Breastplate
		[22769] = { "Aendel Windspear" }, -- Pattern: Bramblewood Belt 
		[22770] = { "Aendel Windspear" }, -- Pattern: Bramblewood Boots 
		[22771] = { "Aendel Windspear" }, -- Pattern: Bramblewood Helm 
		[22698] = { "Master Craftsman Omarion" }, -- Pattern: Icy Scale Bracers 
		[22696] = { "Master Craftsman Omarion" }, -- Pattern: Icy Scale Breastplate 
		[22697] = { "Master Craftsman Omarion" }, -- Pattern: Icy Scale Gauntlets 
		--[00000] = { "Master Craftsman Omarion" }, -- Pattern: Polar Bracers 
		--[00000] = { "Master Craftsman Omarion" }, -- Pattern: Polar Tunic 
		--[00000] = { "Master Craftsman Omarion" }, -- Pattern: Polar Gloves 

		[15759]	= { "Plugger Spazzring" },			-- Pattern: Black Dragonscale Breastplate
		[6474]	= { "Kalldan Felmoon" },			-- Pattern: Deviate Scale Cloak
		[6475]	= { "Kalldan Felmoon" },			-- Pattern: Deviate Scale Gloves
		[15758]	= { "Nergal" },						-- Pattern: Devilsaur Gauntlets
		[7362]	= { "Zixil" },						-- Pattern: Earthen Leather Shoulders
		[15740]	= { "Qia" },						-- Pattern: Frostsaber Boots
		[14635]	= { "Rikqiz", "Vendor-Tron 1000" },	-- Pattern: Gem-studded Leather Belt
		[15726]	= { "Masat T'andr" },				-- Pattern: Green Dragonscale Breastplate
		[7613]	= { "Vendor-Tron 1000" },			-- Pattern: Green Leather Armor
		[7451]	= { "Vendor-Tron 1000" },			-- Pattern: Green Whelp Bracers
		[15724]	= { "Zannok Hidepiercer" },			-- Pattern: Heavy Scorpid Bracers
		[15762]	= { "Zannok Hidepiercer" },			-- Pattern: Heavy Scorpid Helm
		[5789]	= { "Blixrez Goodstitch" },			-- Pattern: Murloc Scale Bracers
		[15756]	= { "Jase Farlane" },				-- Pattern: Runic Leather Headband
		[18239]	= { "Rikqiz" },						-- Pattern: Shadowskin Gloves
		[5788]	= { "Blixrez Goodstitch" },			-- Pattern: Thick Murloc Armor
		
	-- Tailoring
		[17018]	= { "Lokhtos Darkbargainer" },	-- Pattern: Flarecore Gloves
		[19220]	= { "Lokhtos Darkbargainer" },	-- Pattern: Flarecore Leggings
		[17017]	= { "Lokhtos Darkbargainer" },	-- Pattern: Flarecore Mantle
		[19219]	= { "Lokhtos Darkbargainer" },	-- Pattern: Flarecore Robe
		[19215]	= { "Meilosh" },				-- Pattern: Wisdom of the Timbermaw
		[19218]	= { "Meilosh" },				-- Pattern: Mantle of the Timbermaw
		[19216]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Pattern: Argent Boots
		[19217]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Pattern: Argent Shoulders
		[19766]	= { "Rin'wosho the Trader" },	-- Pattern: Bloodvine Boots
		[19765]	= { "Rin'wosho the Trader" },	-- Pattern: Bloodvine Leggings
		[19764]	= { "Rin'wosho the Trader" },	-- Pattern: Bloodvine Vest
		[22310]	= { "Mishta" },		-- Pattern: Cenarion Herb Bag
		[22312]	= { "Mishta" },		-- Pattern: Satchel of Cenarius
		[22773] = { "Mishta" }, -- Pattern: Sylvan Crown 
		[22772] = { "Mishta" }, -- Pattern: Sylvan Shoulders 
		[22774] = { "Mishta" }, -- Pattern: Sylvan Vest 
		[22683] = { "Mishta" }, -- Pattern: Gaea's Embrace 
		[22308]	= { "Kania" },		-- Pattern: Enchanted Runecloth Bag
		[22307]	= { "Kania" },		-- Pattern: Enchanted Mageweave Pouch
		--[00000] = { "Master Craftsman Omarion" }, -- Pattern: Glacial Wrists 
		--[00000] = { "Master Craftsman Omarion" }, -- Pattern: Glacial Vest 
		--[00000] = { "Master Craftsman Omarion" }, -- Pattern: Glacial Gloves 
		--[00000] = { "Master Craftsman Omarion" }, -- Pattern: Glacial Cloak 

		[10318]	= { "Cowardly Crosby" },						-- Pattern: Admiral's Hat
		[10728]	= { "Narkk" },									-- Pattern: Black Swashbuckler's Shirt
		[6272]	= { "Ranik" },									-- Pattern: Blue Linen Robe
		[7087]	= { "Super-Seller 680", "Xizk Goodstitch" },	-- Pattern: Crimson Silk Cloak
		[7088]	= { "Vizzklick" },								-- Pattern: Crimson Silk Robe
		[6401]	= { "Super-Seller 680" },						-- Pattern: Dark Silk Shirt
		[14630]	= { "Super-Seller 680", "Xizk Goodstitch" },	-- Pattern: Enchanter's Cowl
		[14483]	= { "Lorelae Wintersong" },						-- Pattern: Felcloth Pants
		[6275]	= { "Ranik" },									-- Pattern: Greater Adept's Robe
		[18487]	= { "Shen'dralar Provisioner" },				-- Pattern: Mooncloth Robe
		[14526]	= { "Qia", "Evie Whirlbrew" },					-- Pattern: Mooncloth
		[5772]	= { "Kiknikle", "Zixil" },						-- Pattern: Red Woolen Bag
		[14468]	= { "Qia" },									-- Pattern: Runecloth Bag
		[14488]	= { "Darnall" },								-- Pattern: Runecloth Boots
		[14472]	= { "Darnall" },								-- Pattern: Runecloth Cloak
		[14481]	= { "Qia" },									-- Pattern: Runecloth Gloves
		[14469]	= { "Darnall" },								-- Pattern: Runecloth Robe
		[21358]	= { "Vizzklick" },								-- Pattern: Soul Pouch

	-- Cooking
		[4609]	= { "Super-Seller 680" },	-- Recipe: Barbecued Buzzard Wing
		[3734]	= { "Super-Seller 680" },	-- Recipe: Big Bear Steak
		[6330]	= { "Kilxx" },				-- Recipe: Bristle Whisker Catfish
		[12232]	= { "Vendor-Tron 1000" },	-- Recipe: Carrion Surprise
		[13940]	= { "Kelsey Yance" },		-- Recipe: Cooked Glossy Mightfish
		[12239]	= { "Super-Seller 680" },	-- Recipe: Dragonbreath Chili
		[13941]	= { "Kelsey Yance" },		-- Recipe: Filet of Redgill
		[6039]	= { "Kelsey Yance" },		-- Recipe: Giant Clam Scorcho
		[13942]	= { "Gikkix" },				-- Recipe: Grilled Squid
		[12240]	= { "Vendor-Tron 1000" },	-- Recipe: Heavy Kodo Stew
		[3735]	= { "Vendor-Tron 1000" },	-- Recipe: Hot Lion Chops
		[13943]	= { "Kelsey Yance" },		-- Recipe: Hot Smoked Bass
		[12229]	= { "Super-Seller 680" },	-- Recipe: Hot Wolf Ribs
		[12231]	= { "Vendor-Tron 1000" },	-- Recipe: Jungle Stew
		[5489]	= { "Vendor-Tron 1000" },	-- Recipe: Lean Venison
		[12227]	= { "Super-Seller 680" },	-- Recipe: Lean Wolf Steak
		[17062]	= { "Kelsey Yance" },		-- Recipe: Mithril Head Trout
		[16110]	= { "Himmik", "Qia" },		-- Recipe: Monster Omelet
		[12233]	= { "Super-Seller 680" },	-- Recipe: Mystery Stew
		[13945]	= { "Gikkix" },				-- Recipe: Nightfin Soup
		[13946]	= { "Gikkix" },				-- Recipe: Poached Sunscale Salmon
		[6368]	= { "Kilxx" },				-- Recipe: Rainbow Fin Albacore
		[12228]	= { "Vendor-Tron 1000" },	-- Recipe: Roast Raptor
		[6369]	= { "Kelsey Yance" },		-- Recipe: Rockscale Cod
		[13939]	= { "Gikkix" },				-- Recipe: Spotted Yellowtail
		[18046]	= { "Dirge Quikcleave" },	-- Recipe: Tender Wolf Steak
		[16767]	= { "Jabbey" },				-- Recipe: Undermine Clam Chowder
		[21099]	= { "Kelsey Yance" },	-- Recipe: Smoked Sagefish
		[21219]	= { "Kelsey Yance" },	-- Recipe: Sagefish Delight

	-- Fishing
		[16083]	= { "Old Man Heming" },	-- Expert Fishing - The Bass and You
		
	-- First Aid
		[19442]	= { "Argent Quartermaster Hasana", "Argent Quartermaster Lightspark", "Quartermaster Miranda Breechlock" },	-- Formula: Powerful anti-venom

	},
};

FAS_LibramInfo = {
	[18333] = { name="Lorekeeper Lydros", bonus="+8 Spell damage/healing" },	-- Libram of Focus
	[18334] = { name="Lorekeeper Lydros", bonus="+1% Dodge" },					-- Libram of Protection
	[18332] = { name="Lorekeeper Lydros", bonus="+1% Haste" },					-- Libram of Rapidity
	[11736] = { name="Mathredis Firestar", bonus="+20 Fire Resistance" },		-- Libram of Resilience
	[11732] = { name="Mathredis Firestar", bonus="+150 Mana" },					-- Libram of Rumination
	[11734] = { name="Mathredis Firestar", bonus="+125 Armor" },				-- Libram of Tenacity
	[11737] = { name="Mathredis Firestar", bonus="+8 any single stat" },		-- Libram of Voracity
	[11733] = { name="Mathredis Firestar", bonus="+100 Health" },				-- Libram of Constitution
};

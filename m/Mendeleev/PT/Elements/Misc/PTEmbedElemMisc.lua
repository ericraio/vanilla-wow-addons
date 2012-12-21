
--	Data was pulled from a number of sources including:
--	wow.allakhazam.com
--	www.thottbot.com
--	Saien's AutoBar
--	GFW_FeedOMatic
--	ReagentData
--	Rowne's Zookeeper
--	Rhodri's Picking Skill


--	Be aware that "Relative quality" values may not be valid for multi-sets
--	They should usually only be used in single-set comparisons (IE comparing vials to vials, not vials to herbs)


local setname, coremajor = "Misc", "1"
local vmajor, vminor = "Misc 1", tonumber(string.sub("$Revision: 2938 $", 12, -3))

--	Todo:
--	Potions (need split out)
--	1.9 WSG/AB items


-- Check to see if an update is needed
-- if not then just return out now before we do anything
if not TekLibStub or not PeriodicTableEmbed or not PeriodicTableEmbed:NeedsUpgraded(vmajor, vminor) then return end

local mem = gcinfo()
local t = {

	-- Value == DPS*10 (to make it an int)
	ammo        = {"ammoarrows", "ammobullets", "ammothrown"},
	ammoarrows  = "2512:5 2515:12 3030:25 3464:32 9399:38 11285:43 12654:67 18042:58 19316:55",
	ammobullets = "2516:5 2519:12 3033:25 3465:32 4960:7 5568:13 8067:7 8068:15 8069:28 10512:42 10513:50 11284:43 11630:60 13377:68 15997 19317:55",
	ammothrown  = "2946:30 2947:10 3107:63 3108:117 3111:10 3131:30 3135:63 3137:117 3463:176 4959:15 5379:21 13173:355 15326:183 15327:183 20086:30",

	-- Value == Poison level capable of curing
	antivenom = "6452:25 6453:35 19440:60",

	-- Value == General quality
	argentdawncommission = "12846:1 13209:2 19812:2",

	-- Value == bag size
	bags        = {"bagsnormal", "bagsammo", "bagsquiver", "bagssoul", "bagsherb", "bagsench", "bagsengin"},
	bagsnormal  = "19291:14 4957:6 1623:12 3233:8 6754:8 6756:6 6446:10 10683:16 10959:16 2082:6 11324:14 1470:10 11742:16 4930:6 4981:12 5763:8 11845:4 3343:8 5081:6 20400:16 4499:12 1537:4 5765:10 19914:18 828:6 1729:10 14156:18 9587:14 3762:12 932:10 3352:10 14046:14 1652:12 933:10 1685:14 2657:8 17966:18 5603:8 918:10 856:8 857:10 5764:10 10050:12 10051:12 14155:16 4496:6 1725:12 5762:6 4245:10 5571:6 4238:6 5572:6 4240:8 5574:8 4241:8 5575:10 5576:10 4497:10 4498:8 4500:16 5573:8 804:10 3914:14 805:6",
	bagsspecial = {"bagsammo", "bagsquiver", "bagssoul", "bagsherb", "bagsench", "bagsengin"},
	bagsammo    = "2102:6 2663:16 3574:10 3604:12 5441:8 7279:8 7372:14 8218:16 19320:16",
	bagsquiver  = "2101:6 2662:16 3573:10 3605:12 5439:8 7278:8 7371:14 8217:16 11362:10 18714:18 19319:16",
	bagssoul    = "21340:20 21341:24 21342:28",
	bagsherb    = "22251:20 22250:12 22252:24",
	bagsench    = "22246:16 22248:20 22249:24",
	bagsengin   = "",

	-- Value == Total health recovered
	bandages        = {"bandagesgeneral", "bandagesalterac", "bandagesarathi", "bandageswarsong"},
	bandagesgeneral = "1251:66 2581:114 3530:161 3531:301 6450:400 6451:640 8544:800 8545:1104 14529:1360 14530:2000",
	bandagesalterac = "19307:2000",
	bandagesarathi  = "20065:1104 20066:2000 20067:640 20232:1104 20234:2000 20235:640 20237:1104 20243:2000 20244:640",
	bandageswarsong = "19066:2000 19067:1104 19068:640",

	-- Darkmoon faire cards/decks
	decks          = "19228 19257 19267 19277",
	cards          = "19287 19288 19289 19290",
	deckbeasts     = "19227 19228 19230 19231 19232 19233 19234 19235 19236", -- Reward Card: Blue Dragon
	deckwarlords   = "19257 19258 19259 19260 19261 19262 19263 19264 19265", -- Reward Card: Heroism
	deckportals    = "19276 19277 19278 19279 19280 19281 19282 19283 19284", -- Reward Card: Twisting Nether
	deckelementals = "19267 19268 19269 19270 19271 19272 19273 19274 19275", -- Reward Card: Maelstrom

	explosives = "4358 4360 4365 4370 4374 4378 4380 4390 4394 4403 6714 10507 10514 10562 10577 10586 15993 16005 16040 18588",

	-- Items turned in for faire tickets
	-- Value == Number of tickets rewarded for item turnin
	faire        = {"faireengin", "fairegreys", "faireleather", "fairesmithy"},
	faireengin   = "4363:1 4375:4 9313:8 11590:12 15994:20",
	fairegreys   = "4582:5 5117:12 5134:1 11404:20 11407:4 19933:20",
	faireleather = "2309:1 2314:4 5739:8 8185:12 15564:20",
	fairesmithy  = "3240:1 3486:4 3835:8 7945:12 12644:20",

	fireworks = "9315 9317 9314 9318 19026 9313 9312 21569 5740 21570 21557 21558 21559 21561 21595 21593 21589 21562 21592 21590 21571 21574 21576 21744 21716 21714 21718",

	-- The halloween wands (I got a crapton on my alt)
	hallowedwands = "20397 20398 20399 20409 20410 20411 20413 20414",

	healthstone = "5509 5510 5511 5512 9421 19004 19005 19006 19007 19008 19009 19010 19011 19012 19013",

	-- Value == Lockpicking skill equiv
	keyskeleton = "15869:25 15870:125 15871:200 15872:300",
	seaforium = "4367:150 18594:300 4398:250",

	-- BS set are world drops, turnin to high elf in Burning Steppes
	-- DM set are dropped in Dire Maul (one per wing) and turn in in DM North library
	librambs = "11732 11733 11734 11736 11737",
	libramdm = "18332 18333 18334",

	-- Value == Lockpicking skill needed to open.  Basically anything that contains items, like clams, bag, boxes, etc
	lockboxes = "4632:1 4633:1 4634:75 4636:125 4637:175 4638:225 5758:225 5759:225 5760:225 6354:1 6355:125 6356:1 13875:175 13918:75 16882:75 16883:125 16884:175 16885:250",

	manastone = "5513 5514 8007 8008",

	--gems mined from ore nodes
	minedgem = {"minedgemcopper", "minedgemtin", "minedgemsilver", "minedgemiron", "minedgemgold", "minedgemmithril", "minedgemtruesilver", "minedgemthorium", "minedgemzgthorium", "minedgemrichthorium", "minedgemdarkiron"},
	minedgemcopper = "774 818 1210 2835",
	minedgemtin = "1206 1210 1529 1705 2836",
	minedgemsilver = "1206 1210 1705",
	minedgemiron = "1529 1705 3864 7909 2838",
	minedgemgold = "1529 1705 3864",
	minedgemmithril = "3864 7909 7910 9262 7912",
	minedgemtruesilver = "3864 7909 7910",
	minedgemthorium = "7910 9262 12361 12364 12800 12799 12365",
	minedgemzgthorium = "19774 12365",
	minedgemrichthorium = "12363 12365",
	minedgemdarkiron = "11382 11754",

	-- Holiday pets require a snowball to lure out of their kitty-carriers
	minipetall = {"minipet", "minipetholiday"},
	minipet = "18597 23007 23015 23002 18598 22235 21277 4401 8485 8486 8487 8488 8489 8490 8491 8492 8494 8495 8496 8497 8498 8499 8500 8501 10360 10361 10392 10393 10394 10398 10822 11023 11026 11110 11474 11825 11826 12264 12529 13582 13583 13584 15996 19450 20371 20769",
	minipetholiday = "21301 21305 21308 21309",

	-- mountsaq can only be used in AQ40
	-- Value == speed
	mounts = "21176:100 1132:60 2411:60 2414:60 5655:60 5656:60 5665:60 5668:60 5864:60 5872:60 5873:60 8588:60 8591:60 8592:60 8595:60 8629:60 8631:60 8632:60 8653:60 13321:60 13322:60 13331:60 13332:60 13333:60 15277:60 15290:60 15292:60 8586:100 12302:100 12303:100 12330:100 12351:100 12353:100 12354:100 13086:100 13317:100 13326:100 13327:100 13328:100 13329:100 13334:100 13335:100 15293:100 18241:100 18242:100 18243:100 18244:100 18245:100 18246:100 18247:100 18248:100 18766:100 18767:100 18772:100 18773:100 18774:100 18776:100 18777:100 18778:100 18785:100 18786:100 18787:100 18788:100 18789:100 18790:100 18791:100 18793:100 18794:100 18795:100 18796:100 18797:100 18798:100 18902:100 19029:100 19030:100 19872:100",
	mountsaq = "21218:100 21321:100 21323:100 21324:100 21176:100",

	-- Value == Mana gained per 5 sec
	oilmana = "20745:4 20747:8 20748:12",

	-- Value == Spell damage increase
	oilwizard = "20744:8 20746:16 20750:24 20749:36",

	-- Rogue poisons by type
	poisons           = {"poisoncrippling", "poisondeadly", "poisoninstant", "poisonmindnumbing", "poisonwound"},
	poisoncrippling   = "3775 3776",
	poisondeadly      = "2892 2893 8984 8985",
	poisoninstant     = "6947 6949 6950 8926 8927 8928",
	poisonmindnumbing = "5237 6951 9186",
	poisonwound       = "10918 10920 10921 10922",

	--Need to sort these out
	potionall = "6662 3823 2458 2459 8951 3825 3826 3382 3827 9088 3383 3828 3384 9224 3386 3387 9233 17708 3388 3928 6048 3389 6049 6050 3390 6051 6052 3391 13442 13443 13444 13445 13446 13447 13452 13453 13454 13455 13457 13459 12190 13462 9154 9155 9030 929 9036 8949 5631 5996 858 13513 5633 9172 5634 2457 10592 9197 1710 9144 9179 3385 5997 9264 2454 9187 6372 4623 6149 13506 2455 9206 2456 13510 13511 13512 118 6373 4596 2633 8529",

	-- Value == Avg health recovered
	potionhealall = {"potionheal", "potionhealalterac"},
	potionheal = "118:80 858:160 929:320 1710:520 3928:800 4596:160 13446:1400 18839:800",
	potionhealalterac = "17348:1120 17349:640",

	-- Value == Avg mana recovered
	potionmanaall = {"potionmana", "potionmanaalterac"},
	potionmana = "2455:160 3385:320 3827:520 6149:800 13443:1200 13444:1800 18841:1200",
	potionmanaalterac = "17351:1120 17352:640",

	-- Value == Avg rage gained (Mighty Rage Potion	also gives a stat buff)
	potionrage = "5631:30 5633:45 13442:45",

	-- Class spell reagents (Rogue reagents are powders, poisons are in above sets)
	-- Value == Earliest level reagent is needed
	reagent = {"reagentpaladin", "reagentdruid", "reagentmage", "reagentpriest", "reagentrogue", "reagentshaman", "reagentwarlock"},
	reagentpaladin = "17033:30",
	reagentdruid   = "17021:50 17026:60 17034:20 17035:30 17036:40 17037:50 17038:60",
	reagentmage    = "17020:56 17031:20 17032:40 17056:12",
	reagentpriest  = "17028:48 17029:60 17056:34",
	reagentrogue   = "5140:22 5530:34",
	reagentshaman  = "17030:30 17057:22 17058:28",
	reagentwarlock = "5565:50 6265 16583:60",

	-- Value == Stat boost granted
	scrolls    = {"scrollagi", "scrollint", "scrollprot", "scrollspi", "scrollsta", "scrollstr"},
	scrollagi  = "3012:5 1477:9 4425:13 10309:17",
	scrollint  = "955:4 2290:8 4419:12 10308:16",
	scrollprot = "3013:60 1478:120 4421:180 10305:240",
	scrollspi  = "1181:3 1712:7 4424:11 10306:15",
	scrollsta  = "1180:4 1711:8 4422:12 10307:16",
	scrollstr  = "954:5 2289:9 4426:13 10310:17",

	-- Value == Damage bonus (elemental has no value, it increases crit chance)
	sharpeningstones = "2862:2 2863:3 2871:4 7964:6 12404:8 18262",

	-- devices ... engineered items
	devices = "18639 18638 18283 16022 18634 10576 10548 10546 4396 4391 4386 4407 4376 4406 4405 11825 11826 15846 15996 21277 16023 18660 18645 18637 17716 18232 11590 10727 4388 4392 4397 4401 4403 4366 5507 6533 6715 7148 7506 10577 10587 10645 10716 10720 10725 4381",

	-- These items will transport the play to a certain location
	-- "Items" can be used directly from inventory, "Equips" must be equipped to be used.
	transporteritems = "6948 18150 18149",
	transporterequips = "18984 18986 17690 17905 17906 17907 17908 17909 17691 17900 17901 17902 17903 17904",

	-- Player-consumable Un'goro crystals
	ungorocrystalsbuff = "11562 11563 11564 11565 11566 11567",

	-- Harvestabe Un'goro Crystals
	ungorocrystalspower = "11184 11185 11186 11188",

	weapontempenchants = {"weightstones", "sharpeningstones", "poisons", "oilmana", "oilwizard"},

	-- Value == Damage bonus
	weightstones = "3239:2 3240:3 3241:4 7965:6 12643:8",

	arcanumoffocus      = "18333 18335 14344 12753",
	arcanumofprotection = "18334 18335 14344 12735",
	arcanumofrapidity   = "18332 18335 14344 12938",
	lesserarcanumofconstitution = "11754 8411 11733 11952",
	lesserarcanumofresilience   = "11754 11567 11751 11736",
	lesserarcanumofrumination   = "11754 11752 8424 11732",
	lesserarcanumoftenacity     = "11754 11734 11564 11753",
	lesserarcanumofvoracity     = "11754 11737 11951 11563",
}


local lib = {}


-- Return the library's current version
function lib:GetLibraryVersion()
	return vmajor, vminor
end


-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	self.dataset = t
	t = nil
	PeriodicTableEmbed:GetInstance(coremajor):AddModule(setname, self.dataset, self.memuse)
end

lib.memuse = gcinfo() - mem


--------------------------------
--      Load this bitch!      --
--------------------------------
PeriodicTableEmbed:Register(lib)



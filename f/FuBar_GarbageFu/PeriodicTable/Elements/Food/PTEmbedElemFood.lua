
--	Data was pulled from a number of sources including:
--	wow.allakhazam.com
--	www.thottbot.com
--	Saien's AutoBar
--	GFW_FeedOMatic
--	ReagentData
--	Rowne's Zookeeper
--	Rhodri's Picking Skill


--------------------------          About food sets          ----------------------------
--  Foods are sorted out by type (for pets) and quality                                --
--  Raw foods are feedable to a pet or cookable (some are player-consumable)           --
--  Normal food recovers health (duh!)                                                 --
--  Bonus foods give the Well Fed buff (Spirit/Stamina)                                --
--  Stat foods give a stat different from Well Fed (ex: Agility, mana regen)           --
--  Foods that recover a static amount of HP and MP are listed in the 'combo' groups   --
--  Foods that recover a percentage of HP/MP are listed in the 'perc' group            --
-----------------------------------------------------------------------------------------


local setname, coremajor = "Food", "1"
local vmajor, vminor = "Food 1", tonumber(string.sub("$Revision: 9298 $", 12, -3))


-- Check to see if an update is needed
-- if not then just return out now before we do anything
if not TekLibStub or not PeriodicTableEmbed or not PeriodicTableEmbed:NeedsUpgraded(vmajor, vminor) then return end

local mem = gcinfo()
local t = {
	-- Gets you drunk! Not all items here are consumables ~~~~ Value == alchohol content
	booze = "21171:3 21721:5 2593:10 2594:20 2595:20 2596:10 2686:5 2723:5 2894:5 3703:10 4595:20 4600:20 744:20 9260:20 9360:20 9361:50 11846:10 12003:50 1262:20 17048:20 17196:5 17198:10 17402:20 17403:10 18269:20 18284:20 18287:10 18288:20 19221:50 19222:5 21151:20 21114:10 20709:10",

	foodspecial = {"foodcombohealth", "foodcombomana", "foodcomboperc", "foodperc", "foodpercbonus"},
	foodcombohealth = "2682:294 3448:294 13724:2148", -- Value == Total health recovered
	foodcombomana   = "2682:294 3448:294 13724:4410", -- Value == Total mana recovered
	foodcomboperc   = "21537:100 20388:75 20389:75 20390:75 21215:100", -- Value == Total percentage HP/MP recovered
	foodperc        = "19696:50 19994:50 19995:50 19996:50", -- Value == Percentage HP recovered
	foodpercbonus   = "20516:48 21235:50 21254:48", -- Value == Percentage HP recovered (with Well Fed buff)

	--New fish in 1.9:
	-- 21071 155hp 315mp Raw Sagefish
	-- 21153 567hp 882mp Raw Greater Sagefish
	-- 21072 378hp 567mp +3manaregen Smoked Sagefish
	-- 21217 840hp 1260mp +6manaregen Sagefish Delight

	-- Value == Total health recovered

	foodall = {"food", "foodbonus", "foodstat", "foodspecial", "foodraw"},
	foodalledible = {"food", "foodbonus", "foodstat", "foodspecial"},

	-- Raw food with no value is not player-consumable but can be fed to a pet
	foodraw           = {"foodfishraw", "foodmeatraw"},
	foodfishraw       = "2675 4603:874 4655 5468 5503 5504 6289:61 6291:30 6303:30 6308:243 6317:61 6361:61 6362:552 7974 8365:552 8959:1392 12206 13754:874 13755:874 13756:874 13758:874 13759:874 13760:874 13889:1392 13893:1392 15924",
	foodmeatraw       = "20424 769 1015 1081 2672 2673 2677 2924 3173 3404 3667 3712 3730 3731 4739 5051 5465 5467 5469 5470 5471 12037 12184 12202 12203 12204 12205 12208 12223 17119",

	-- Normal food, no stats
	food              = {"foodbread", "foodbreadconjured", "foodcheese", "foodfish", "foodfruit", "foodfungus", "foodmeat", "foodmisc"},
	foodbread         = "4540:61 4541:243 4542:552 4544:874 4601:1392 8950:2148 16169:874",
	foodbreadconjured = "1113:243 1114:552 1487:874 5349:61 8075:1392 8076:2148",
	foodcheese        = "414:243 422:552 1707:874 2070:61 3927:1392 8932:2148",
	foodfish          = "16766:1392 2682:294 4592:243 4593:552 4594:874 5095:243 6290:61 6887:1392 787:61 8364:874 8957:2148 13546:1392 13930:1392 13935:2148",
	foodfruit         = "22324:2148 4536:61 4537:243 4538:552 4539:874 4602:1392 8953:2148 16168:1392 21033:2148 21031:2148 21030:1392",
	foodfungus        = "3448:294 4604:61 4605:243 4606:552 4607:874 4608:1392 8948:2148",
	foodmeat          = "19306:1392 19305:552 19224:874 19223:61 19304:243 117:61 2287:243 2681:61 2685:552 3770:552 3771:874 4599:1392 5478:552 6890:243 8952:2148 9681:1392 9681:61",
	foodmisc          = "19225:2148 733:552 5473:294 5526:552 6316:243 13933:2148 16166:61 16167:243 16170:552 16171:2148 18255:1392",

	-- Foods that give the Well Fed buff
	foodbonus         = {"foodbreadbonus", "foodfishbonus", "foodmeatbonus", "foodmiscbonus", "foodcheesebonus", "foodpercbonus"},
	foodbreadbonus    = "2683:243 3666:552 17197:61",
	foodfishbonus     = "5476:243 6038:874 12216:1392 5527:552 16971:1392",
	foodmeatbonus     = "1017:552 2680:61 2684:243 2687:243 2888:61 3220:243 3662:243 3726:552 3727:552 3728:874 3729:874 4457:874 5472:61 5474:61 5477:243 5479:552 5480:552 12209:552 12210:874 12213:874 12224:61 13851:874 17222:1392 18045:1392",
	foodcheesebonus   = "3665:552 12218:1392",
	foodmiscbonus     = "724:243 1082:552 3663:552 3664:552 5525:243 6038:874 6888:61 11584:61 12212:874 12214:874 12215:1392 12216:1392 17198:61 20452:2148",

	-- Foods that give a stat (not Well Fed)
	foodstat          = {"foodfishstats", "foodfruitstats", "foodmeatstats", "foodmiscstats"},
	foodfishstats     = "13927:1392 13928:874 13929:874 13932:874",
	foodfruitstats    = "11950:1933",
	foodmeatstats     = "12217",
	foodmiscstats     = "13931:874 13934:1933 18254:1933",

	-- Foods sorted out by type
	foodclass       = {"foodclassbread", "foodclassfish", "foodclassmeat", "foodclasscheese", "foodclassfruit", "foodclassfungus", "foodclassmisc"},
	foodclassbread  = {"foodbread", "foodbreadbonus", "foodbreadconjured"},
	foodclassfish   = {"foodfishraw", "foodfish", "foodfishbonus", "foodfishstats"},
	foodclassmeat   = {"foodmeatraw", "foodmeat", "foodmeatbonus", "foodmeatstats"},
	foodclasscheese = {"foodcheese", "foodcheesebonus"},
	foodclassfruit  = {"foodfruit", "foodfruitstats"},
	foodclassfungus = {"foodfungus"},
	foodclassmisc   = {"foodmisc", "foodmiscbonus", "foodmiscstats"},

	-- Value == Mana recovered
	waterall = {"water", "waterperc", "waterconjured", "foodcomboperc", "foodcombomana"},
	water         = "19229:835 19300:1992 159:151 1179:436 1205:835 1401:60 1645:1992 1708:1344 4791:1344 8766:2934 9451:835 10841:1344 17405:1344 19299:835 19318:4410",
	waterperc     = "19997:60 21241:60",
	waterconjured = "2136:835 2288:436 3772:1344 5350:151 8077:1992 8078:2934 8079:4200",
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

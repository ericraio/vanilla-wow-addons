
local setname, coremajor = "Instance Loot", "1"
local vmajor, vminor = "Instance Loot 1", tonumber(string.sub("$Revision: 902 $", 12, -3))


-- Check to see if an update is needed
-- if not then just return out now before we do anything
if not TekLibStub or not PeriodicTableEmbed or not PeriodicTableEmbed:NeedsUpgraded(vmajor, vminor) then return end

local mem = gcinfo()
local t = {

	---------------------------
	--      World Drops      --
	---------------------------

	-- World Drops == can drop anywhere
	-- Boss drops == only drops off instance/world bosses, but not static to certain ones
	bossdrops = "14509 12720 12716 14558 12717 12728 14511 14510",
	worlddrops = "12994 13131 13054 12974 12992 12989 12978 12975 12979 12982 13137 12984 12983 13127 12997 13124 12996 12976 12977 12985 1728 4415 12999 13005 13105 12998 9395 1265 1722 19236 14549 1980 13038 13071 13199 13042 1713 868 1981 13034 1716 13068 13051 1714 13136 1718 1982 2815 13088 14557 13026 13058 1715 867 9434 869 870 13020 13029 873 2825 13095 13064 2164 2802 1204 10608 7734 4091 13121 19259 13123 940 19265 13119 19269 19271 13129 13139 13004 19279 13133 13014 811 2291 14501 13030 13006 13107 19231 13109 13113 13000 12703 9402 1721 833 13146 13018 14552 13091 12711 754 812 1979 1168 13135 9433 13117 3075 18335 2244 1607 6622 2915 5267 17007 13065 13067 13027 18600 13144 19270 2163 810 13145 1720 19278 10605 2099 13022 17413 12691 13073 13075 2824 1263 17414 14551 13028 14553 14554 13077 2100 13001 13035 13039 13043 2246 13083 13085 11302 13089 13047 5266 13053 13055 13059 13003 13007 13009 13013 13015 1447 13021 13023 14555 4696 943 944 17683 8028 14497 19275 13122 13126 13128 13130 13132 13134 13138 7991 809 19232 19261 1315 1443 2243 13096 13100 13102 19260 19284 19233 19272 19281 19262 13112 19280 13116 13118 13120 19235 19274 19283 19264 19234 19273 19282 19263 7976 1203 8190 2564 13044 13125 13070 13072 13074 13076 17682 13082 13111 13002 1973 14507 13008 14497 19230 942 13101 647 2245 6660 13036 13040 13046 13052 13056 871 13060 13066",
	NOTworlddrops = "14343 13161 14344 16867 16722 16845 16716 12607 2801 20725",
	worlddropstoverify = "",

	---------------------
	--      Zones      --
	---------------------

	instancezones = {"blackrockspiretrash", "upperblackrockspire", "lowerblackrockspire", "diremaulnorth", "diremaulwest", "diremauleast", "scholomance", "stratholme", "blackrockspire", "blackrockdepths", "maraudon", "templeofatalhakkar", "shadowfangkeep"},

	["blackrockdepths"] = "11610 11611 11612 11744 11746 11747 11748 11749 11750 11625 11628 11629 11630 11635 17049 11764 17053 12528 11767 17059 12531 12532 12535 12791 12542 11782 11783 12546 12547 11786 12549 12550 12551 12552 12553 12554 12555 12556 12557 11923 11924 11925 11926 11927 11928 11929 11930 11931 11678 11933 11807 11935 11809 11810 11684 11812 11686 11814 11815 11817 11819 11821 11824 17052 11832 15770 11808 11839 11805 12527 16724 11766 15781 11765 11785 11934 11932 11722 11669 11755 11920 11726 11922 11728 11729 11730 11731 11784 11921 11787 11735 17060 17051",
	["maraudon"] = "13081 17719 4090 13115 1726 17728 17730 13025 17732 9435 17734 17736 17737 17738 17739 934 13093 17742 937 17744 17745 17746 17733 17748 17749 8006 17741 17752 4354 17754 17755 4301 17717 1169 9385 17715 13103 2276 9719 17710 17780 17766 17767 17740 17718 17707 13045 17943 8384 17711 13110 17713 17714 13017 936",
	["scholomance"] = "14531 14024 14536 14537 14538 14539 14541 14543 14545 18680 18682 18684 18686 18690 18692 18694 18696 18698 18700 18702 16684 16686 16698 13938 14576 14577 16710 13944 16720 13314 13950 13951 13952 13953 13955 13956 13957 14340 13960 18782 13964 13967 16254 13969 14611 18683 14487 18689 18691 18693 18695 18697 16667 18701 14624 16677 14626 14502 14503 16689 16693 13983 14637 19276 16705 16707 14514 16711 16701 18758 16734 14525 13937 16727 14522 18759 18761 16731 13398 18760 14528 18681 18699 14548",
	["stratholme"] = "13515 13389 13390 13391 18783 13393 13394 13395 13396 13397 13399 13400 13401 13529 13403 13404 13405 13534 13408 13409 16668 16678 16682 18716 18718 18720 18722 16692 16694 18728 18730 16702 16704 18738 18740 18742 18744 16714 16691 16728 16685 13954 18781 13385 13402 18745 18736 18734 18726 13379 13505 16708 16719 14512 13524 13373 18743 13335 18741 13388 12830 13369 13340 12833 18735 13392 13344 13345 13346 12839 13348 13349 13359 16697 16671 13353 16675 16687 13361 16681 13358 18717 13360 18721 18723 18725 18727 18729 16699 13378 13368 18737 18739 16709 13372 12103 13374 13375 13376 13377 16723 16725 13380 13381 13382 13383 13384 16737 13386 13387 16732",
	["templeofatalhakkar"] = "10783 1169 10795 10797 10799 10801 10829 10835 10837 10843 10845 10847 3875 10626 10628 10630 10632 12463 12465 10784 8244 10796 10798 10806 10808 13115 10828 10836 10838 10842 10846 10623 10625 10627 10629 10631 10800 10634 10844 12462 12464 12466 7452 15733 4090 10633 10624 12243 10787 10807 10833",


	-------------------------
	--      Dire Maul      --
	-------------------------

	diremaulnorth = {"chorushtheobserver", "kinggordok", "captainkromcrush", "guardslipkik", "guardfengus", "stomperkreeg", "guardmoldar"},
	["knotthimblejackscache"] = "18414:101 18517:93 18518:129 18519:113 18415:962 18416:1065 18417:1026 18418:981 18514:1082 18515:1125 18516:1032",
	["kinggordok"] = "18360 18500 18361 18780 18362 18533 18363 18534 18364 18520 18359 18521 18537 18522 18499 18523 18531 18524 18525 18401 18495 18526 18356 18527 18357 18528 18358 18529 19258:166 18530 18532",
	["chorushtheobserver"] = "18485:2339 18484:2273 18490:2150 18483:1846",
	["captainkromcrush"] = "18505 18359 18363 18502 18401 18360 18364 18503 18507 18361 18358 18362 18356 18357",
	["guardfengus"] = "18359 18363 18401 18360 18364 18357 18361 18358 18362 18356",
	["guardmoldar"] = "18359 18363 18496 18356 18360 18364 18497 18357 18361 18498 18493 18358 18362 18494 18401",
	["guardslipkik"] = "18359 18363 18496 18356 18360 18364 18497 18357 18361 18498 18493 18358 18362 18494 18401",
	["stomperkreeg"] = "18359 18363 18356 18360 18364 18357 18361 18358 18362",

	diremaulwest = {"diremaulwesttrash", "lordhelnurath", "princetortheldrin", "immolthar", "illyannaravenoak", "tendriswarpwood", "tsuzee", "magisterkalendris"},
	["diremaulwesttrash"] = "18340:64 18338:87",
	["lordhelnurath"] = "18757:2290 18755:2277 18756:2072 18754:1803",
	["illyannaravenoak"] = "18359 18363 18401 18360 18364 18383 18357 18361 18358 18362 18386 18356",
	["immolthar"] = "18391 18361 18377 18362 18394 18379 18364 18381 18384 18385 18370 18356 18372 18357 18401 18358 18363 18359 18360 18389",
	["magisterkalendris"] = "18374 18363 18397 18401 18360 18364 18357 18361 18359 18358 18362 18356 18371",
	["tendriswarpwood"] = "18359 18393 18401 18360 18364 18357 18361 18390 18358 18362 18356 18363",
	["princetortheldrin"] = "18378 18382 18375 18376 18380 18395 18388 18392 18396 18373",
	["tsuzee"] = "18387:2460",

	diremauleast = {"diremauleasttrash", "pimgib", "alzzinthewildshaper", "zevrimthornhoof", "hydrospawn", "lethtendris", "pusillin"},
	["diremauleasttrash"] = "18298:66 18296:61 18344:61 18289:96 18295:130",
	["pimgib"] = "18354:2008",
	["alzzinthewildshaper"] = "18360 18314 18361 18315 18362 18363 18364 18318 18321 18401 18309 18356 18310 18326 18357 18358 18312 18359 18327 18328",
	["zevrimthornhoof"] = "18359 18363 18356 18360 18364 18323 18357 18361 18401 18358 18362 18319 18313",
	["hydrospawn"] = "19268:120 18359 18363 18322 18401 18360 18364 18357 18361 18324 18358 18362 18356 18317",
	["lethtendris"] = "18325 18359 18363 18356 18360 18364 18357 18361 18358 18362 18311 18401",
	["pusillin"] = "18359 18363 18401 18360 18364 18357 18361 18358 18362 18356",


	-------------------------------
	--      Blackrock Spire      --
	-------------------------------

	blackrockspiretrash = "16735 16683 16680 16703 16696 16713 12812 16673 16717",

	upperblackrockspire = {"solakarflamewreath", "thebeast", "pyroguardemberseer", "generaldrakkisath", "goralukanvilcrack", "gyth", "rendblackhand", "jedrunewatcher"},
	["generaldrakkisath"] = "16690 13141 13098 12592 16721 16706 16688 13142 12602 16730 16674 16700 15730 16726 16666",
	["rendblackhand"] = "18103:1421 18104:1559 12587:1907 12588:1079 12935:2402 16733:1319 12936:1105 12590:33 12939:1091 12583:1327 12940:346 3475 18102:1205",
	["gyth"] = "16669 12871 13260",
	["goralukanvilcrack"] = "12834:715 18779:1351 13502:1031 18047:1356 12837:686 12806:5",
	["pyroguardemberseer"] = "16672 12927 12929",
	["jedrunewatcher"] = "12604:2758 12930:2878 12605:3118",
	["solakarflamewreath"] = "12589:1623 12609:1427 12606:1503 12603:1449 16695:1438 18657:915",

	lowerblackrockspire = {"burningfelguard", "quartermasterzigris", "crystalfang", "warmastervoone", "shadowhuntervoshgajin", "overlordwyrmthalak", "highlordomokk", "mothersmolderweb", "halycon", "gizrultheslavener"},
	["halycon"] = "13210:944 13211:2343 13212:1985 22313:1779",
	["crystalfang"] = "13184:3539 13218:1398 13185:3491",
	["thebeast"] = "12963 12967 12965 12969 16729 12968 19227:555 12709 12966 12731 12964",
	["mothersmolderweb"] = "13213:1064 16715:1619 13183:81",
	["overlordwyrmthalak"] = "13162 16679 13163 13143 13164 13148",
	["highlordomokk"] = "13168 13169 13166 13170 13167 16736",
	["warmastervoone"] = "13179 13173 12582 13178 16676:1030",
	["shadowhuntervoshgajin"] = "12654 12651 13257 16712 12653 12626",
	["gizrultheslavener"] = "13206:1809 13208:1777 13205:1701 16718:1289",
	["quartermasterzigris"] = "12835:1126 13252:1351 13253:1532",
	["burningfelguard"] = "13181:909 13182:227",


	--------------------------------
	--      Elemental Bosses      --
	--------------------------------

	elementalbosses = {"avalanchion", "thewindreaver", "baroncharr", "princesstempestria"},
	avalanchion = "18673:1481 19268:585 18674:4229",
	thewindreaver = "18676:1779 19268:1014 21548:405 18677:5180",
	baroncharr = "18671:1018 19268:714 18672:5426",
	princesstempestria = "18678:1351 19268:445 21548:273 18679:5431",


	----------------------
	--      Bosses      --
	----------------------

	instancebosses = {
		"diremaulwesttrash", "diremauleasttrash", "blackrockspiretrash", "shadowfangkeeptrash",
		"avalanchion", "thewindreaver", "baroncharr", "princesstempestria",
		"burningfelguard", "quartermasterzigris", "gizrultheslavener", "solakarflamewreath", "jedrunewatcher",
		"crystalfang", "mothersmolderweb", "goralukanvilcrack", "ambassadorflamelash", "angerrel", "baelgar", "doomrel", "doperel", "emperordagranthaurissian", "fineousdarkvire", "generalangerforge", "gloomrel", "golemlordargelmach", "haterel", "highinterrogatorgerstahn", "hurleyblackbreath", "lordincendius", "magmus", "phalanx", "pluggerspazzring", "princessmoirabronzebeard", "ribblyscrewspigot", "seethrel", "vilerel",
		"generaldrakkisath", "gyth", "rendblackhand", "highlordomokk", "halycon", "overlordwyrmthalak", "pyroguardemberseer", "thebeast", "shadowhuntervoshgajin", "warmastervoone", "lordhelnurath",
		"princetortheldrin", "immolthar", "illyannaravenoak", "tendriswarpwood", "magisterkalendris", "tsuzee", "kinggordok", "captainkromcrush", "guardslipkik", "guardfengus", "stomperkreeg", "guardmoldar", "pusillin", "zevrimthornhoof", "hydrospawn", "lethtendris", "alzzinthewildshaper",
		"princesstheradras", "noxxion", "razorlash", "lordvyletongue", "meshloktheharvester", "celebrasthecursed", "landslide", "tinkerergizlock", "rotgrip", "chorushtheobserver", "pimgib",
		"lordalexeibarov", "darkmastergandling", "kirtonostheherald", "rattlegore", "vectus", "mardukblackpool", "rasfrostwhisper", "jandicebarov", "doctortheolenkrastinov", "theravenian", "lorekeeperpolkelt", "instructormalicia", "ladyilluciabarov",
		"baronrivendare", "baronessanastari", "magistratebarthilas", "malekithepallid", "nerubenkan", "ramsteinthegorger", "archivistgalford", "cannonmasterwilley", "balnazzar", "timmythecruel", "hearthsingerforresten", "postmastermalown",
		"weaver", "zolo", "loro", "gasher", "hukku", "mijan", "zullor", "avatarofhakkar", "shadeoferanikus", "jammalantheprophet", "atalalarion", "dreamscythe", "ogomthewretched", "morphaz", "hazzas",
		"archmagearugal", "deathsworncaptain", "commanderspringvale", "razorclawthebutcher", "odotheblindwatcher", "baronsilverlaine", "wolfmasternandos", "fenrusthedevourer", "arugalsvoidwalker",
	},

	blackrockdepthsbosses = {"ambassadorflamelash", "angerrel", "baelgar", "doomrel", "doperel", "emperordagranthaurissian", "fineousdarkvire", "generalangerforge", "gloomrel", "golemlordargelmach", "haterel", "highinterrogatorgerstahn", "hurleyblackbreath", "lordincendius", "magmus", "phalanx", "pluggerspazzring", "princessmoirabronzebeard", "ribblyscrewspigot", "seethrel", "vilerel"},
	maraudonbosses = {"princesstheradras", "noxxion", "razorlash", "lordvyletongue", "meshloktheharvester", "celebrasthecursed", "landslide", "tinkerergizlock", "rotgrip"},
	scholomancebosses = {"lordalexeibarov", "darkmastergandling", "kirtonostheherald", "rattlegore", "vectus", "mardukblackpool", "rasfrostwhisper", "jandicebarov", "doctortheolenkrastinov", "theravenian", "lorekeeperpolkelt", "instructormalicia", "ladyilluciabarov"},
	stratholmebosses = {"baronrivendare", "baronessanastari", "magistratebarthilas", "malekithepallid", "nerubenkan", "ramsteinthegorger", "archivistgalford", "cannonmasterwilley", "balnazzar", "timmythecruel", "hearthsingerforresten", "postmastermalown"},
	templeofatalhakkarbosses = {"weaver", "zolo", "loro", "gasher", "hukku", "mijan", "zullor", "avatarofhakkar", "shadeoferanikus", "jammalantheprophet", "atalalarion", "dreamscythe", "ogomthewretched", "morphaz", "hazzas"},

	["ambassadorflamelash"] = "11812 12528 11832 12547 12549 12551 12550 11808 12527 11809 12546 12542 12535 12552 11814",
	["angerrel"] = "11926 11921 11923 11925 11927 11929 11920 11922",
	["archivistgalford"] = "13385 13386 18741 13387 16692 18716 18736",
	["atalalarion"] = "10799:1775 10623:1 10798:3031 10800:3265 10630:1",
	["avatarofhakkar"] = "10846:3260 10624:5 10632:1 10842:3351 12462:8 10843:3080 10634:2 10627:2 10844:1588 10845:3018 10625:1 10838:1629 10633:2",
	["baelgar"] = "12528 11807 11805 12542 12555 12535",
	["balnazzar"] = "13353 14512 13359 12103 18717 18720 13369 18718 13358 13360 16725 13348",
	["baronessanastari"] = "18730 18728 18736 13534 16704 18745 18744 18729",
	["baronrivendare"] = "16687 13505 16719 13335 18736 13344 13368 13345 16678 16694 18741 18742 16728 13346 13340 16699 16732 16709 13361 13349 16668",
	["cannonmasterwilley"] = "12839 13382 13380 18721 13377 13381 16708",
	["celebrasthecursed"] = "17740 17738 17739",
	["darkmastergandling"] = "16686 18702 19276:291 16720 14514 13964 16707 16677 16693 13950 16727 13953 13944 16667 13951 13937 18701 16731 16698 13938 13398",
	["doctortheolenkrastinov"] = "14624 14626 18682 16684 18698 14637 18680 18684 18700 14611 18681 18683",
	["doomrel"] = "11926 11921 11923 11925 11927 11929 11920 11922",
	["doperel"] = "11926 11921 11923 11925 11927 11929 11920 11922",
	["dreamscythe"] = "12464:515 12466:420 12243:437 10625:1 10627:3 10629:1 10796:410 12463:449 12465:412 10632:1 10795:352 10797:439 10634:1",
	["emperordagranthaurissian"] = "11924 16724 12528 11930 11932 11934 12547 11931 11933 11928 11684 11810",
	["fineousdarkvire"] = "12547 12549 12555 12527 11839 12546 12535 12531",
	["gasher"] = "10784:215 10786:625 10623:2 10629:2 10631:1 10783:324 10785:459 10787:492 10624:1 10630:3 10788:675",
	["generalangerforge"] = "11821 12528 12547 12549 12551 11817 12550 12527 11815 12546 12531 12535 12552 12542",
	["gloomrel"] = "11926 11921 11923 11925 11927 11929 11920 11922",
	["golemlordargelmach"] = "12531 12532 12552 11819 11669 12555 12551",
	["haterel"] = "11926 11921 11923 11925 11927 11929 11920 11922",
	["hazzas"] = "12466:440 10623:2 10631:1 10624:1 10632:1 10795:423 10625:2 10633:2 10796:483 10626:1 10634:1 10797:446 10627:2 12464:488 12465:416 12463:468 12243:455",
	["hearthsingerforresten"] = "18745 13379 13383 13384 18744 13378",
	["highinterrogatorgerstahn"] = "12528 12549 11625 12542 12546 12535 12552 12550",
	["hukku"] = "10629:2 10630:1 10623:1 10624:4 10787:535 10625:1 10626:2 10634:2 10784:197 10783:325 10786:619 10785:445 10788:708",
	["hurleyblackbreath"] = "12552 12535 18044 11735 18043 12555 12542",
	["instructormalicia"] = "14624 14626 18682 16710 18683 18702 18680 18684 18681 14637 14611",
	["jammalantheprophet"] = "10623:1 10625:1 10807:2216 10631:1 10806:2377 10808:2712 10626:2 10632:1",
	["jandicebarov"] = "14536 18690 14548 14541 14543 14545 16701 18689",
	["kirtonostheherald"] = "14024 14536 13983 13955 13957 18702 13967 13969 16734 13960 13956 18699",
	["ladyilluciabarov"] = "14624 14626 18682 18701 18698 14637 18680 18684 14611 18697 18681 18683",
	["landslide"] = "17737 17733 17734 17736 17943",
	["lordalexeibarov"] = "14624 14626 18682 18683 14637 18680 18699 18684 14611 18681 18700",
	["lordincendius"] = "19268:166 12528 11765 11767 12549 12551 12542 12555 12527 11764 11766 12550 12535 12552 12532",
	["lordvyletongue"] = "17752 17754 17755 4090 13115",
	["lorekeeperpolkelt"] = "14624 14626 18682 16705 14536 18683 18702 18698 18680 18684 18700 14611 18681 14637",
	["loro"] = "10629:2 10630:3 10623:2 10631:1 10624:2 10632:2 10625:1 10788:717 10626:1 10634:1 10627:1 10784:256 10786:655 10783:302 10785:441 10787:539",
	["magistratebarthilas"] = "18725 18726 18727 18742 18722 13376",
	["magmus"] = "12531 12528 11935 12527 12542",
	["malekithepallid"] = "18745 18734 18742 16691 18735 18743 18744 12833 18737 18741 13524",
	["mardukblackpool"] = "14576 18692",
	["meshloktheharvester"] = "17767 17741 17742",
	["mijan"] = "10634:1 10786:596 10788:749 10625:5 10784:207 10633:5 10785:403 10787:516 10624:2 10783:313 10630:3",
	["morphaz"] = "12464:446 12466:404 10623:2 10627:1 10629:1 10796:420 12463:425 12465:430 12243:398 10795:409 10630:1 10797:426 10631:2",
	["nerubenkan"] = "18738 13529 16675 18741 18745 18740 18739",
	["noxxion"] = "17746 17744 17745",
	["ogomthewretched"] = "10805:2814 10804:3026 10803:2829",
	["phalanx"] = "11744 11746 12528 12547 12549 12551 12527 12535 12550 12552 12532",
	["pluggerspazzring"] = "12547 12549 12791 12555 12531 12535 12552 12550",
	["postmastermalown"] = "13389 13391 13393 13392 13388 16682 18741 13390",
	["princessmoirabronzebeard"] = "12556 12553 12557 12554",
	["princesstheradras"] = "17710 17714 17707 17711 17715 17780 17713 17766",
	["ramsteinthegorger"] = "18723 13372 13374 13515 13373 13375 18741 16737",
	["rasfrostwhisper"] = "18701 14536 16689 14522 13314 18693 18694 18695 18696 14525 14502 13952 14487 14340 18699 14503",
	["rattlegore"] = "18700 14538 18697 18686 14531 18698 18702 14537 14539 18699 14528 18782 16711",
	["razorlash"] = "17749 4090 17748",
	["ribblyscrewspigot"] = "11612",
	["rotgrip"] = "17728 17732 17730",
	["seethrel"] = "11922 11926 11920 11929 11921 11925 11927",
	["shadeoferanikus"] = "10630:1 10833:2556 10624:1 10835:1876 10626:1 10634:1 10828:1094 10836:2194 10829:2765 10837:1014 10847:5",
	["theravenian"] = "14624 14626 18682 18683 18698 18680 18684 14611 18697 18681 14637",
	["timmythecruel"] = "13403 13400 13401 18744 13402",
	["tinkerergizlock"] = "17719 17717 17718",
	["vectus"] = "18691 14577",
	["vilerel"] = "11926 11921 11923 11925 11927 11929 11920 11922",
	["weaver"] = "12464:424 12466:385 12243:435 10629:2 10796:436 12463:505 12465:415 10632:1 10795:436 10797:385 10633:1",
	["zolo"] = "10629:1 10630:1 10623:4 10632:3 10625:1 10788:767 10626:2 10784:206 10786:590 10783:322 10785:429 10787:525",
	["zullor"] = "10784:208 10788:718 10627:1 10783:312 10787:541 10626:1 10785:496 10632:1 10786:600",


	-------------------------
	--   Shadowfang Keep   --
	-------------------------

	shadowfangkeep = {"shadowfangkeeptrash", "archmagearugal", "deathsworncaptain", "commanderspringvale", "razorclawthebutcher", "odotheblindwatcher", "baronsilverlaine", "wolfmasternandos", "fenrusthedevourer", "arugalsvoidwalker"},
	["shadowfangkeeptrash"] = "1935:2 3194:2 2205:1 1483:2 1489:1 2807:1 1974:2 2292:1 1318:1 1482:1 1484:1",
	["archmagearugal"] = "6392:3000 6220:1600 6324:3000",
	["razorclawthebutcher"] = "1292:900 6633:4000 6226:4000",
	["commanderspringvale"] = "6320:3000 3191:3000",
	["wolfmasternandos"] = "3748:5000 6314:3500",
	["odotheblindwatcher"] = "6318:3000 6319:6000",
	["deathsworncaptain"] = "6642:3000 6641:6000",
	["baronsilverlaine"] = "6321:2000",
	["fenrusthedevourer"] = "3230:1500 6340:6000",
	["arugalsvoidwalker"] = "5943:3",
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

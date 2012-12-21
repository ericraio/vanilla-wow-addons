
local setname, coremajor = "Equipment Sets", "1"
local vmajor, vminor = "Equipment Sets 1", tonumber(string.sub("$Revision: 666 $", 12, -3))


-- Check to see if an update is needed
-- if not then just return out now before we do anything
if not TekLibStub or not PeriodicTableEmbed or not PeriodicTableEmbed:NeedsUpgraded(vmajor, vminor) then return end

local mem = gcinfo()
local t = {

	-----------------------------
	--      Instance Sets      --
	-----------------------------
	ironweavebattlesuit = "22301 22302 22303 22304 22305 22306 22311 22313", -- iLVL 61 (Misc level 60 instances)
	thepostmaster = "13388 13389 13390 13391 13392", -- iLVL 61 (Stratholme - Postmaster Malown)
	deathboneguardian = "14620 14621 14622 14623 14624", -- iLVL 61 (Scholomance)
	cadaverousgarb = "14636 14637 14638 14640 14641", -- iLVL 61 (Scholomance)
	necropileraiment = "14626 14629 14631 14632 14633", -- iLVL 61 (Scholomance)
	bloodmailregalia = "14611 14612 14614 14615 14616", -- iLVL 61 (Scholomance)
	thegladiator = "11726 11728 11729 11730 11731", -- iLVL 57 (Blackrock Depths)
	chainofthescarletcrusade = "10328 10329 10330 10331 10332 10333", -- iLVL 38 (Scarlet Monestary)
	embraceoftheviper = "6473 10410 10411 10412 10413", -- iLVL 21 (Wailing Caverns)
	defiasleather = "10399 10400 10401 10402 10403", -- iLVL 20 (Deadmines)


	-------------------------
	--      Dungeon 1      --
	--       iLVL 59       --
	-------------------------
	dungeon1 = {"lightforgearmor", "wildheartraiment", "shadowcraftarmor", "magistersregalia", "battlegearofvalor", "vestmentsofthedevout", "dreadmistraiment", "theelements", "beaststalkerarmor"},
	theelements          = "16666 16667 16668 16669 16670 16671 16672 16673", -- Shaman
	beaststalkerarmor    = "16674 16675 16676 16677 16678 16679 16680 16681", -- Hunter
	magistersregalia     = "16682 16683 16684 16685 16686 16687 16688 16689", -- Mage
	vestmentsofthedevout = "16690 16691 16692 16693 16694 16695 16696 16697", -- Priest
	dreadmistraiment     = "16698 16699 16700 16701 16702 16703 16704 16705", -- Warlock
	wildheartraiment     = "16706 16714 16715 16716 16717 16718 16719 16720", -- Druid
	shadowcraftarmor     = "16707 16708 16709 16710 16711 16712 16713 16721", -- Rogue
	lightforgearmor      = "16722 16723 16724 16725 16726 16727 16728 16729", -- Paladin
	battlegearofvalor    = "16730 16731 16732 16733 16734 16735 13736 16737", -- Warrior


	-------------------------
	--      Dungeon 2      --
	--       iLVL 62       --
	-------------------------
	dungeon2 = {"battlegearofheroism", "darkmantlearmor", "beastmasterarmor", "sorcerersregalia", "deathmistraiment", "vestmentsofthevirtuous", "soulforgearmor", "thefivethunders", "feralheartraiment"},
	battlegearofheroism    = "21994 21995 21996 21997 21998 21999 22000 22001", -- Warrior
	darkmantlearmor        = "22002 22003 22004 22005 22006 22007 22008 22009", -- Rogue
	beastmasterarmor       = "22010 22011 22013 22015 22016 22017 22060 22061", -- Hunter
	sorcerersregalia       = "22062 22063 22064 22065 22066 22067 22068 22069", -- Mage
	deathmistraiment       = "22070 22071 22072 22073 22074 22075 22076 22077", -- Warlock
	vestmentsofthevirtuous = "22078 22079 22080 22081 22082 22083 22084 22085", -- Priest
	soulforgearmor         = "22086 22087 22088 22089 22090 22091 22092 22093", -- Paladin
	thefivethunders        = "22095 22096 22097 22098 22099 22100 22101 22102", -- Shaman
	feralheartraiment      = "22106 22107 22108 22109 22110 22111 22112 22113", -- Druid


	------------------------------
	--      Zandalar Tribe      --
	--        Zul'Gurub         --
	--         iLVL 66          --
	------------------------------
	zandalartribesets = {"illusionistsattire", "augursregalia", "freethinkersarmor", "predatorsarmor", "haruspexsgarb", "confessorsraiment", "vindicatorsbattlegear", "madcapsoutfit", "demoniacsthreads"},
	augursregalia         = "19609 19956 19830 19829 19828", -- Shaman
	freethinkersarmor     = "19952 19588 19825 19826 19827", -- Paladin
	confessorsraiment     = "19594 19958 19843 19841 19842", -- Priest
	demoniacsthreads      = "19605 19957 19848 20033 19849", -- Warlock
	madcapsoutfit         = "19617 19954 19836 19834 19835", -- Rogue
	haruspexsgarb         = "19613 19955 19840 19838 19839", -- Druid
	predatorsarmor        = "19621 19953 19833 19831 19832", -- Hunter
	vindicatorsbattlegear = "19951 19577 19824 19822 19823", -- Warrior
	illusionistsattire    = "20034 19601 19959 19846 19845", -- Mage


	---------------------------
	--      Tier 1 Raid      --
	--      Molten Core      --
	--        iLVL 66        --
	---------------------------
	tier1raid = {"vestmentsofprophecy", "nightslayerarmor", "theearthfury", "battlegearofmight", "lawbringerarmor", "cenarionraiment", "giantstalkerarmor", "arcanistregalia", "felheartraiment"},
	arcanistregalia     = "16795 16796 16797 16798 16799 16800 16801 16802", -- Mage
	felheartraiment     = "16803 16804 16805 16806 16807 16808 16809 16810", -- Warlock
	cenarionraiment     = "16828 16829 16830 16831 16833 16834 16835 16836", -- Druid
	theearthfury        = "16837 16838 16839 16840 16841 16842 16843 16844", -- Shaman
	giantstalkerarmor   = "16845 16846 16847 16848 16849 16850 16851 16852", -- Hunter
	lawbringerarmor     = "16853 16854 16855 16856 16857 16858 16859 16860", -- Paladin
	vestmentsofprophecy = "16811 16812 16813 16814 16815 16816 16817 16819", -- Priest
	nightslayerarmor    = "16820 16821 16822 16823 16824 16825 16826 16827", -- Rogue
	battlegearofmight   = "16861 16862 16863 16864 16865 16866 16867 16868", -- Warrior


	----------------------------
	--      Tier 2 Raid       --
	--     Blackwing Lair     --
	--        iLVL 76         --
	----------------------------
	tier2raid = {"stormrageraiment", "bloodfangarmor", "netherwindregalia", "vestmentsoftrancendance", "nemesisraiment", "dragonstalkerarmor", "thetenstorms", "judgementarmor", "battlregearofwrath"},
	stormrageraiment        = "16897 16898 16899 16900 16901 16902 16903 16904", -- Druid
	bloodfangarmor          = "16832 16905 16906 16907 16908 16909 16910 16911", -- Rogue
	netherwindregalia       = "16818 16912 16913 16914 16915 16916 16917 16918", -- Mage
	vestmentsoftrancendance = "16919 16920 16921 16922 16923 16924 16925 16926", -- Priest
	nemesisraiment          = "16927 16928 16929 16930 16931 16932 16933 16934", -- Warlock
	dragonstalkerarmor      = "16935 16936 16937 16938 16939 16940 16941 16942", -- Hunter
	thetenstorms            = "16943 16944 16945 16946 16947 16948 16949 16950", -- Shaman
	judgementarmor          = "16951 16952 16953 16954 16955 16956 16957 16958", -- Paladin
	battlregearofwrath      = "16959 16960 16961 16962 16963 16964 16965 16966", -- Warrior


	-------------------------------
	--      Cenarion Circle      --
	--       Ahn'Qiraj 20        --
	--          iLVL 70          --
	-------------------------------


	---------------------------------
	--      Brood of Nozdormu      --
	--        Ahn'Qiraj 20         --
	--           iLVL 81           --
	---------------------------------


	----------------------------
	--      Crafted Sets      --
	----------------------------
	blackdragonmail   = "16984 15050 15052 15051", -- iLVL 60
	thedarksoul       = "19693 19694 19695", -- iLVL 65
	bloodtigerharness = "19689 19688", -- iLVL 65
	primalbatskin     = "19685 19687 19686", -- iLVL 65
	bloodsoulembrace  = "19690 19691 19692", -- iLVL 65
	bloodvinegarb     = "19682 19683 19684", -- iLVL 65
	devilsaurarmor    = "15062 15063", -- iLVL 59
	bluedragonmail    = "15048 20295 15049", -- iLVL 58
	stormshroudarmor  = "15056 15057 15058 21278", -- iLVL 58
	imperialplate     = "12422 12424 12425 12426 12427 12428 12429", -- iLVL 57
	volcanicarmor     = "15053 15054 15055", -- iLVL 57
	ironfeatherarmor  = "15066 15067", -- iLVL 56
	greendragonmail   = "15045 15046 20296", --iLVL 54


	---------------------------
	--      Weapon Sets      --
	---------------------------
	thetwinbladesofhakkari = "19865 19866", -- iLVL 67
	spiritofeskhandar = "18202 18203 18204 18205", -- iLVL 67
	primalblessing = "19896 19910", -- iLVL 65
	dalrendsarms = "12940 12939", -- iLVL 63
	spiderskiss = "13218 13183", -- iLVL 60


	-------------------------
	--      Ring Sets      --
	-------------------------
	prayeroftheprimal    = "19863 19920", -- iLVL 69
	zanzilsconcentration = "19905 19893", -- iLVL 69
	overlordsresolution  = "19873 19912", -- iLVL 69
	majormojoinfusion    = "19898 19925", -- iLVL 69


	-------------------------
	--      Misc sets      --
	-------------------------
	shardofthegods = "17082 17064",  -- iLVL 72 (Trinkets)
	twilighttrappings = "20406 20407 20408", -- iLVL 60 (not like that matters)
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


local setname, coremajor = "Ahn'Qiraj Quest", "1"
local vmajor, vminor = "Ahn'Qiraj Quest 1", tonumber(string.sub("$Revision: 666 $", 12, -3))


-- Check to see if an update is needed
-- if not then just return out now before we do anything
if not TekLibStub or not PeriodicTableEmbed or not PeriodicTableEmbed:NeedsUpgraded(vmajor, vminor) then return end

local mem = gcinfo()
local t = {
	-- AQ's green tokens are common between the two zones, but the blue/purple tokens are zone-specific.
	-- Each class/faction set appears to fit the same pattern:
	-- Cenarion Circle (CC): Ring (Honored), Back (Revered), Weapon (Exalted)
	-- Brood of Nozdormu (BoN): Shoulder (Neutral), Feet (Neutral), Head (Friendly), Legs (Friendly), Chest (Honored)

	-- Ahn'Qiraj items by type
	ahnqirajquests      = {"ahnqirajscarab", "ahnqirajidol20", "ahnqirajidol40", "ahnqirajequipment20", "ahnqirajequipment40"},
	ahnqirajscarab      = "20858 20859 20860 20861 20862 20863 20864 20865",
	ahnqirajidol20      = "20866 20867 20868 20869 20870 20871 20872 20873",
	ahnqirajidol40      = "20874 20875 20876 20877 20878 20879 20881 20882",
	ahnqirajequipment20 = "20884 20885 20886 20888 20889 20890",
	ahnqirajequipment40 = "20926 20927 20928 20929 20930 20931 20932 20933",

	-- Ahn'Qiraj items by class need and faction requirements
	-- Value = Reputation index of:
	-- {"Hated", "Hostile", "Unfirendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}
	ahnqirajclassescc = {"ahnqirajdruidcc", "ahnqirajhuntercc", "ahnqirajmagecc", "ahnqirajpaladincc", "ahnqirajpriestcc", "ahnqirajroguecc", "ahnqirajshamancc", "ahnqirajwarlockcc", "ahnqirajwarriorcc"},
	ahnqirajclassesbon = {"ahnqirajdruidbon", "ahnqirajhunterbon", "ahnqirajmagebon", "ahnqirajpaladinbon", "ahnqirajpriestbon", "ahnqirajroguebon", "ahnqirajshamanbon", "ahnqirajwarlockbon", "ahnqirajwarriorbon"},

	ahnqirajdruidcc     = {"ahnqirajdruidring", "ahnqirajdruidback", "ahnqirajdruidweapon"},
	ahnqirajdruidring   = "20865:6 20861:6 20873:6 20884:6 ", -- CC Honored
	ahnqirajdruidback   = "20860:7 20864:7 20872:7 20889:7", -- CC Revered
	ahnqirajdruidweapon = "20858:8 20862:8 20870:8 20890:8", -- CC Exalted

	ahnqirajdruidbon      = {"ahnqirajdruidshoulder", "ahnqirajdruidfeet", "ahnqirajdruidhead", "ahnqirajdruidlegs", "ahnqirajdruidchest"},
	ahnqirajdruidshoulder = "20932:4 20881:4 20859:4 20864:4", -- BoN Neutral
	ahnqirajdruidfeet     = "20860:4 20858:4 20878:4 20932:4", -- BoN Neutral
	ahnqirajdruidhead     = "20863:5 20859:5 20879:5 20930:5", -- BoN Friendly
	ahnqirajdruidlegs     = "20862:5 20858:5 20882:5 20931:2", -- BoN Friendly
	ahnqirajdruidchest    = "20865:6 20861:6 20878:6 20933:3", -- BoN Honored

	ahnqirajhuntercc     = {"ahnqirajhunterring", "ahnqirajhunterback", "ahnqirajhunterweapon"},
	ahnqirajhunterring   = "20863:6 20859:6 20869:6 20888:6", -- CC Honored
	ahnqirajhunterback   = "20889:7 20868:7 20858:7 20862:7", -- CC Revered
	ahnqirajhunterweapon = "20886:8 20866:8 20860:8 820864:8", -- CC Exalted

	ahnqirajhunterbon      = {"ahnqirajhuntershoulder", "ahnqirajhunterfeet", "ahnqirajhunterhead", "ahnqirajhunterlegs", "ahnqirajhunterchest"},
	ahnqirajhuntershoulder = "20865:4 20862:4 20882:4 20928:4", -- BoN Neutral
	ahnqirajhunterfeet     = "20864:4 20858:4 20879:4 20928:4", -- BoN Neutral
	ahnqirajhunterhead     = "20865:5 20861:5 20881:5 20930:5", -- BoN Friendly
	ahnqirajhunterlegs     = "20864:5 20860:5 20874:5 20931:5", -- BoN Friendly
	ahnqirajhunterchest    = "20863:6 20859:6 20879:6 20929:6", -- BoN Honored

	ahnqirajmagecc     = {"ahnqirajmagering", "ahnqirajmageback", "ahnqirajmageweapon"},
	ahnqirajmagering   = "20863:6 20859:6 20866:6 20884:6", -- CC Honored
	ahnqirajmageback   = "20862:7 20858:7 20873:2 20885:7", -- CC Revered
	ahnqirajmageweapon = "20864:8 20860:8 20871:8 20890:8", -- CC Exalted

	ahnqirajmagebon      = {"ahnqirajmageshoulder", "ahnqirajmagefeet", "ahnqirajmagehead", "ahnqirajmagelegs", "ahnqirajmagechest"},
	ahnqirajmageshoulder = "20861:4 20858:4 20876:4 20932:4", -- BoN Neutral
	ahnqirajmagefeet     = "20862:4 20860:4 20874:4 20932:4", -- BoN Neutral
	ahnqirajmagehead     = "20865:5 20861:5 20875:5 20926:5", -- BoN Friendly
	ahnqirajmagelegs     = "20864:5 20860:5 20877:5 20927:5", -- BoN Friendly
	ahnqirajmagechest    = "20863:6 20859:6 20874:6 20933:6", -- BoN Honored

	ahnqirajpaladincc     = {"ahnqirajpaladinring", "ahnqirajpaladinback", "ahnqirajpaladinweapon"},
	ahnqirajpaladinring   = "20864:6 20860:6 20872:6 20884:6", -- CC Honored
	ahnqirajpaladinback   = "20863:7 20859:7 20871:7 20889:7", -- CC Revered
	ahnqirajpaladinweapon = "20865:8 20861:8 20869:8 20886:8", -- CC Exalted

	ahnqirajpaladinbon      = {"ahnqirajpaladinshoulder", "ahnqirajpaladinfeet", "ahnqirajpaladinhead", "ahnqirajpaladinlegs", "ahnqirajpaladinchest"},
	ahnqirajpaladinshoulder = "20862:4 20859:4 20879:4 20932:4", -- BoN Neutral
	ahnqirajpaladinfeet     = "20863:4 20861:4 20877:4 20932:4", -- BoN Neutral
	ahnqirajpaladinhead     = "20862:5 20858:5 20878:5 20930:5", -- BoN Friendly
	ahnqirajpaladinlegs     = "20861:5 20865:5 20881:5 20931:5", -- BoN Friendly
	ahnqirajpaladinchest    = "20864:6 20860:6 20877:6 20929:6", -- BoN Honored

	ahnqirajpriestcc     = {"ahnqirajpriestring", "ahnqirajpriestback", "ahnqirajpriestweapon"},
	ahnqirajpriestring   = "20864:6 20860:6 20871:6 20888:6", -- CC Honored
	ahnqirajpriestback   = "20863:7 20859:7 20870:7 20885:7", -- CC Revered
	ahnqirajpriestweapon = "20865:8 20861:8 20868:8 20890:8", -- CC Exalted

	ahnqirajpriestbon      = {"ahnqirajpriestshoulder", "ahnqirajpriestfeet", "ahnqirajpriesthead", "ahnqirajpriestlegs", "ahnqirajpriestchest"},
	ahnqirajpriestshoulder = "20865:4 20860:4 20878:4 20928:4", -- BoN Neutral
	ahnqirajpriestfeet     = "20859:4 20861:4 20876:4 20928:4", -- BoN Neutral
	ahnqirajpriesthead     = "20864:5 20860:5 20877:5 20926:5", -- BoN Friendly
	ahnqirajpriestlegs     = "20863:5 20859:5 20879:5 20927:5", -- BoN Friendly
	ahnqirajpriestchest    = "20862:6 20858:6 20876:6 20933:6", -- BoN Honored

	ahnqirajroguecc     = {"ahnqirajroguering", "ahnqirajrogueback", "ahnqirajrogueweapon"},
	ahnqirajroguering   = "20862:6 20858:6 20867:6 20888:6", -- CC Honored
	ahnqirajrogueback   = "20865:7 20861:7 20866:7 20885:7", -- CC Revered
	ahnqirajrogueweapon = "20863:8 20859:8 20872:8 20886:8", -- CC Exalted

	ahnqirajroguebon      = {"ahnqirajrogueshoulder", "ahnqirajroguefeet", "ahnqirajroguehead", "ahnqirajroguelegs", "ahnqirajroguechest"},
	ahnqirajrogueshoulder = "20863:4 20860:4 20874:4 20928:4", -- BoN Neutral
	ahnqirajroguefeet     = "20864:4 20862:4 20881:4 20928:4", -- BoN Neutral
	ahnqirajroguehead     = "20859:5 20863:5 20882:5 20930:5", -- BoN Friendly
	ahnqirajroguelegs     = "20862:5 20858:5 20875:5 20927:5", -- BoN Friendly
	ahnqirajroguechest    = "20865:6 20861:6 20881:6 20929:6", -- BoN Honored

	ahnqirajshamancc     = {"ahnqirajshamanring", "ahnqirajshamanback", "ahnqirajshamanweapon"},
	ahnqirajshamanring   = "20884:6 20872:6 20860:6 20864:6", -- CC Honored
	ahnqirajshamanback   = "20859:7 20863:7 20871:7 20889:7", -- CC Revered
	ahnqirajshamanweapon = "20865:8 20861:8 20869:8 20886:8", -- CC Exalted

	ahnqirajshamanbon      = {"ahnqirajshamanshoulder", "ahnqirajshamanfeet", "ahnqirajshamanhead", "ahnqirajshamanlegs", "ahnqirajshamanchest"},
	ahnqirajshamanshoulder = "20862:4 20859:4 20879:4 20932:4", -- BoN Neutral
	ahnqirajshamanfeet     = "20863:4 20861:4 20877:4 20932:4", -- BoN Neutral
	ahnqirajshamanhead     = "20862:5 20858:5 20878:5 20930:5", -- BoN Friendly
	ahnqirajshamanlegs     = "20861:5 20865:5 20881:5 20931:5", -- BoN Friendly
	ahnqirajshamanchest    = "20864:6 20860:6 20877:6 20929:6", -- BoN Honored

	ahnqirajwarlockcc     = {"ahnqirajwarlockring", "ahnqirajwarlockback", "ahnqirajwarlockweapon"},
	ahnqirajwarlockring   = "20862:6 20858:6 20870:6 20888:6", -- CC Honored
	ahnqirajwarlockback   = "20865:7 20861:7 20869:7 20889:7", -- CC Revered
	ahnqirajwarlockweapon = "20863:8 20859:8 20867:8 20890:8", -- CC Exalted

	ahnqirajwarlockbon      = {"ahnqirajwarlockshoulder", "ahnqirajwarlockfeet", "ahnqirajwarlockhead", "ahnqirajwarlocklegs", "ahnqirajwarlockchest"},
	ahnqirajwarlockshoulder = "20864:4 20861:4 20877:4 20932:4", -- BoN Neutral
	ahnqirajwarlockfeet     = "20865:4 20863:4 20875:4 20932:4", -- BoN Neutral
	ahnqirajwarlockhead     = "20864:5 20860:5 20876:5 20926:5", -- BoN Friendly
	ahnqirajwarlocklegs     = "20863:5 20859:5 20878:5 20931:5", -- BoN Friendly
	ahnqirajwarlockchest    = "20858:6 20862:6 20875:6 20933:6", -- BoN Honored

	ahnqirajwarriorcc     = {"ahnqirajwarriorring", "ahnqirajwarriorback", "ahnqirajwarriorweapon"},
	ahnqirajwarriorring   = "20865:6 20861:6 20868:6 20884:6", -- CC Honored
	ahnqirajwarriorback   = "20885:7 20867:7 20864:7 20860:7", -- CC Revered
	ahnqirajwarriorweapon = "20858:8 20862:8 20873:8 20886:8", -- CC Exalted

	ahnqirajwarriorbon      = {"ahnqirajwarriorshoulder", "ahnqirajwarriorfeet", "ahnqirajwarriorhead", "ahnqirajwarriorlegs", "ahnqirajwarriorchest"},
	ahnqirajwarriorshoulder = "20858:4 20863:4 20875:4 20928:4", -- BoN Neutral
	ahnqirajwarriorfeet     = "20859:4 20865:4 20882:4 20928:4", -- BoN Neutral
	ahnqirajwarriorhead     = "20858:5 20862:5 20874:5 20926:5", -- BoN Friendly
	ahnqirajwarriorlegs     = "20865:5 20861:5 20867:5 20927:5", -- BoN Friendly
	ahnqirajwarriorchest    = "20864:6 20860:6 20882:6 20929:6", -- BoN Honored
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

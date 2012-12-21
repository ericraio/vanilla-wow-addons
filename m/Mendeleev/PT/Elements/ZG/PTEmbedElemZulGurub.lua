
local setname, coremajor = "Zul'Gurub Quest", "1"
local vmajor, vminor = "Zul'Gurub Quest 1", tonumber(string.sub("$Revision: 666 $", 12, -3))


-- Check to see if an update is needed
-- if not then just return out now before we do anything
if not TekLibStub or not PeriodicTableEmbed or not PeriodicTableEmbed:NeedsUpgraded(vmajor, vminor) then return end

local mem = gcinfo()
local t = {

	-- Zul'Gurub items by type
	zulgurubquests = {"zulgurubcoin", "zulgurubbijou", "zulgurubprimal"},
	zulgurubcoin   = "19698 19699 19700 19701 19702 19703 19704 19705 19706",
	zulgurubbijou  = "19707 19708 19709 19710 19711 19712 19713 19714 19715",
	zulgurubprimal = "19716 19717 19718 19719 19720 19721 19722 19723 19724",

	-- Coin trios for repeatable rep quests
	zulgurubcoinrep1 = "19698 19699 19700",
	zulgurubcoinrep2 = "19701 19702 19703",
	zulgurubcoinrep3 = "19704 19705 19706",

	-- Zul'Gurub items by class need
	-- Value = Reputation index of:
	-- {"Hated", "Hostile", "Unfirendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}
	zulgurubclasses = {"zulgurubdruid", "zulgurubhunter", "zulgurubmage", "zulgurubpaladin", "zulgurubpriest", "zulgurubrogue", "zulgurubshaman", "zulgurubwarlock", "zulgurubwarrior"},
	zulgurubenchants = {"zulgurubdruidenchant", "zulgurubhunterenchant", "zulgurubmageenchant", "zulgurubpaladinenchant", "zulgurubpriestenchant", "zulgurubrogueenchant", "zulgurubshamanenchant", "zulgurubwarlockenchant", "zulgurubwarriorenchant"},

	zulgurubdruid           = {"zulgurubdruidenchant", "zulgurubdruidbelt", "zulgurubdruidbracer", "zulgurubdruidchest"},
	zulgurubdruidbelt       = "19699:6 19704:6 19711:6 19720:6 ", -- Honored
	zulgurubdruidbracer     = "19700:5 19702:5 19707:5 19718:5", -- Friendly
	zulgurubdruidchest      = "19701:7 19698:7 19713:7 19722:7", -- Revered
	zulgurubdruidenchant    = "19716:5 19821:5 18331:5",

	zulgurubhunter          = {"zulgurubhunterenchant", "zulgurubhunterbelt", "zulgurubhunterbracer", "zulgurubhuntershoulder"},
	zulgurubhunterbelt      = "19700:6 19699:6 19711:6 19721:6", -- Honored
	zulgurubhunterbracer    = "19704:5 19705:5 19709:5 19716:5", -- Friendly
	zulgurubhuntershoulder  = "19701:7 19698:7 19714:7 19724:7", -- Revered
	zulgurubhunterenchant   = "19718:5 19816:5 18329:5",

	zulgurubmage            = {"zulgurubmageenchant", "zulgurubmagebracer", "zulgurubmagechest", "zulgurubmageshoulder"},
	zulgurubmagebracer      = "19702:5 19703:5 19708:5 19716:5", -- Friendly
	zulgurubmagechest       = "19704:7 19698:7 19714:7 19723:7", -- Revered
	zulgurubmageshoulder    = "19701:6 19699:6 19710:6 19721:6", -- Honored
	zulgurubmageenchant     = "19719:5 19818:5 18330:5",

	zulgurubpaladin         = {"zulgurubpaladinenchant", "zulgurubpaladinbelt", "zulgurubpaladinbracer", "zulgurubpaladinchest"},
	zulgurubpaladinbelt     = "19706:7 19705:7 19712:7 19721:7", -- Revered
	zulgurubpaladinbracer   = "19703:5 19698:5 19707:5 19716:5", -- Friendly
	zulgurubpaladinchest    = "19704:6 19702:6 19715:6 19722:6", -- Honored
	zulgurubpaladinenchant  = "19721:5 19815:5 18331:5",

	zulgurubpriest          = {"zulgurubpriestenchant", "zulgurubpriestbelt", "zulgurubpriestbracer", "zulgurubpriestshoulder"},
	zulgurubpriestbelt      = "19700:6 19698:6 19710:6 19720:6", -- Honored
	zulgurubpriestbracer    = "19706:5 19704:5 19709:5 19718:5", -- Friendly
	zulgurubpriestshoulder  = "19699:7 19703:7 19713:7 19724:7", -- Revered
	zulgurubpriestenchant   = "19722:5 19820:5 18330:5",

	zulgurubrogue           = {"zulgurubrogueenchant", "zulgurubroguebracer", "zulgurubroguechest", "zulgurubrogueshoulder"},
	zulgurubroguebracer     = "19706:5 19702:5 19708:5 19717:5", -- Friendly
	zulgurubroguechest      = "19700:7 19705:7 19715:7 19724:7", -- Revered
	zulgurubrogueshoulder   = "19699:6 19698:6 19712:6 19719:6", -- Honored
	zulgurubrogueenchant    = "19723:5 19814:5 18329:5",

	zulgurubshaman          = {"zulgurubshamanenchant", "zulgurubshamanbelt", "zulgurubshamanbracer", "zulgurubshamanchest"},
	zulgurubshamanbelt      = "19701:6 19705:6 19712:6 19719:6", -- Honored
	zulgurubshamanbracer    = "19706:5 19699:5 19708:5 19717:5", -- Friendly
	zulgurubshamanchest     = "19700:7 19703:7 19715:7 19722:7", -- Revered
	zulgurubshamanenchant   = "19720:5 19817:5 18330:5",

	zulgurubwarlock         = {"zulgurubwarlockenchant", "zulgurubwarlockbracer", "zulgurubwarlockchest", "zulgurubwarlockshoulder"},
	zulgurubwarlockbracer   = "19701:5 19702:5 19707:5 19718:5", -- Friendly
	zulgurubwarlockchest    = "19706:7 19705:7 19714:7 19723:7", -- Revered
	zulgurubwarlockshoulder = "19700:6 19703:6 19710:6 19720:6", -- Honored
	zulgurubwarlockenchant  = "19717:5 19819:5 18330:5",

	zulgurubwarrior         = {"zulgurubwarriorenchant", "zulgurubwarriorbelt", "zulgurubwarriorbracer", "zulgurubwarriorchest"},
	zulgurubwarriorbelt     = "19705:6 19702:6 19711:6 19719:6", -- Honored
	zulgurubwarriorbracer   = "19701:5 19703:5 19709:5 19717:5", -- Friendly
	zulgurubwarriorchest    = "19706:7 19704:7 19713:7 19723:7", -- Revered
	zulgurubwarriorenchant  = "19724:5 19813:5 18331:5",
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

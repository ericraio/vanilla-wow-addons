--[[
	Bagnon_Overrides
		Function Overrides
		Yeah I know the formatting doesn't resemble my normal formatting
		
	OpenBackpack, and CloseBackPack are called automatically
--]]

local function Bagnon_BagIsControlledByBagnon(id)
	return Bagnon_IsAddOnEnabled("Bagnon") and ( (not BagnonSets["Bagnon"] and Bagnon_IsInventoryBag(id) ) or Bagnon_FrameHasBag("Bagnon", id) );
end

local bToggleBag = ToggleBag;
ToggleBag = function(id)
	--bag slots
	if( Bagnon_BagIsControlledByBagnon(id) ) then
		BagnonFrame_Toggle("Bagnon");
	--bank slots
	elseif( BagnonSets.showBankAtBank and Bagnon_IsAddOnEnabled("Banknon") and Bagnon_FrameHasBag("Banknon", id)  ) then
		return;
	--the blizzard way
	else
		bToggleBag(id);
	end
end

local bToggleBackpack = ToggleBackpack;
ToggleBackpack = function()
	if( Bagnon_IsAddOnEnabled("Bagnon") ) then
		BagnonFrame_Toggle("Bagnon");
	else
		bToggleBackpack();
	end
end

local bOpenBag = OpenBag;
OpenBag = function(id)
	if( Bagnon_BagIsControlledByBagnon(id) ) then
		BagnonFrame_Open("Bagnon", 1);
	else
		bOpenBag(id);
	end
end

local bCloseBag = CloseBag;
CloseBag = function(id)
	if( Bagnon_BagIsControlledByBagnon(id) ) then
		BagnonFrame_Close("Bagnon", 1);
	else
		bCloseBag(id);
	end
end

local bOpenBackpack = OpenBackpack;
OpenBackpack = function()
	if( Bagnon_IsAddOnEnabled("Bagnon") ) then
		BagnonFrame_Open("Bagnon", 1);
	else
		bOpenBackpack();
	end
end

local bCloseBackpack = CloseBackpack;
CloseBackpack = function()
	if( Bagnon_IsAddOnEnabled("Bagnon") ) then
		BagnonFrame_Close("Bagnon", 1);
	else
		bCloseBackpack();
	end
end

--OpenAllBags is actually a toggle
local bOpenAllBags = OpenAllBags;
OpenAllBags = function(forceOpen)
	if( Bagnon_IsAddOnEnabled("Bagnon") ) then
		BagnonFrame_Toggle("Bagnon");
	else
		bOpenAllBags(forceOpen);
	end
end

local bCloseAllBags = CloseAllBags;
CloseAllBags = function()
	if( Bagnon_IsAddOnEnabled("Bagnon") ) then
		BagnonFrame_Close("Bagnon");
	else
		bCloseAllBags();
	end
end

local bToggleKeyring = ToggleKeyRing;
ToggleKeyRing = function()
	if( Bagnon_IsAddOnEnabled("Bagnon") and Bagnon_FrameHasBag("Bagnon", KEYRING_CONTAINER) ) then
		BagnonFrame_Toggle("Bagnon");
	else
		bToggleKeyring();
	end
end
--[[
	Bagnon_Overrides
		Function Overrides
		Yeah I know the formatting doesn't resemble my normal formatting
--]]


--[[
	The overrides
--]]

local bToggleBag = ToggleBag;
ToggleBag = function(id)
	--bag slots
	if( (id == 0 or Bagnon_FrameHasBag("Bagnon", id) ) and IsAddOnEnabled("Bagnon") ) then
		BagnonCore_Toggle("Bagnon");
	--bank slots
	elseif( IsAddOnEnabled("Banknon") and Bagnon_FrameHasBag("Banknon", id) and BagnonSets.overrideBank ) then
		return;
	--the blizzard way
	else
		bToggleBag(id);
	end
end;

local bToggleBackpack = ToggleBackpack;
ToggleBackpack = function()
	if(IsAddOnEnabled("Bagnon")) then
		BagnonCore_Toggle("Bagnon");
	else
		bToggleBackpack();
	end
end;

local bOpenBag = OpenBag;
OpenBag = function(id)
	if( (id == 0 or Bagnon_FrameHasBag("Bagnon", id) ) and IsAddOnEnabled("Bagnon") ) then
		BagnonCore_Open("Bagnon");
	else
		bOpenBag(id);
	end
end;

local bCloseBag = CloseBag;
CloseBag = function(id)
	if( (id == 0 or Bagnon_FrameHasBag("Bagnon", id) ) and IsAddOnEnabled("Bagnon") ) then
		BagnonCore_Close("Bagnon");
	else
		bCloseBag(id);
	end
end;

local bOpenBackpack = OpenBackpack;
OpenBackpack = function()
	if(IsAddOnEnabled("Bagnon")) then
		BagnonCore_Open("Bagnon");
	else
		bOpenBackpack();
	end
end;

local bCloseBackpack = CloseBackpack;
CloseBackpack = function()
	if(IsAddOnEnabled("Bagnon")) then
		BagnonCore_Close("Bagnon");
	else
		bCloseBackpack();
	end
end;

local bOpenAllBags = OpenAllBags;
--OpenAllBags is actually a toggle
OpenAllBags = function(forceOpen)
	if(IsAddOnEnabled("Bagnon")) then
		BagnonCore_Toggle("Bagnon");
	else
		bOpenAllBags(forceOpen);
	end
end;

local bCloseAllBags = CloseAllBags;
CloseAllBags = function()
	if(IsAddOnEnabled("Bagnon")) then
		BagnonCore_Close("Bagnon");
	else
		bCloseAllBags();
	end
end;
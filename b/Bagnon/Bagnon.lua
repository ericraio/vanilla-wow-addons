--[[
	Bagnon
		Displays the player's inventory in a single frame
--]]

local bBagSlotButton_OnEnter, bMainBag_OnEnter, bKeyRingButton_OnEnter;
local bBagSlotButton_OnClick, bKeyRingButton_OnClick, bMainBag_OnClick;

--[[ Loading Functions ]]--

function Bagnon_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
end

--[[ Event Handler ]]--

function Bagnon_OnEvent(event)
	if ( event == "ADDON_LOADED" and arg1 == "Bagnon") then
		Bagnon:UnregisterEvent("ADDON_LOADED");
		Bagnon_Load();
	end
end

function Bagnon_Load()
	BagnonFrame_Load(Bagnon, {-2, 0, 1, 2, 3, 4}, BAGNON_INVENTORY_TITLE);
	Bagnon_AddBagHooks();
end

--[[ UI Functions ]]--

--OnShow
function Bagnon_OnShow()
	MainMenuBarBackpackButton:SetChecked(1);
	PlaySound("igBackPackOpen");
end

--OnHide
function Bagnon_OnHide()
	MainMenuBarBackpackButton:SetChecked(0);
	PlaySound("igBackPackClose");
end

--Show Bags
function Bagnon_ToggleBags()
	if( not BagnonBags:IsShown() ) then
		BagnonBags:Show();
		BagnonSets["Bagnon"].bagsShown = 1;
		this:SetText(BAGNON_HIDEBAGS);
	else
		BagnonBags:Hide();
		BagnonSets["Bagnon"].bagsShown = nil;
		this:SetText(BAGNON_SHOWBAGS);
	end
	
	BagnonFrame_TrimToSize(Bagnon);
end

--[[ Bag Overrides ]]--

function Bagnon_AddBagHooks()
	bMainBag_OnEnter = MainMenuBarBackpackButton:GetScript("OnEnter");
	bMainBag_OnClick = MainMenuBarBackpackButton:GetScript("OnClick");
	MainMenuBarBackpackButton:SetScript("OnEnter", BagnonBlizMainBag_OnEnter);
	MainMenuBarBackpackButton:SetScript("OnLeave", BagnonBlizBag_OnLeave);
	MainMenuBarBackpackButton:SetScript("OnClick", BagnonBlizMainBag_OnClick);
	
	bBagSlotButton_OnEnter = BagSlotButton_OnEnter;
	BagSlotButton_OnEnter = BagnonBlizBag_OnEnter;
	bBagSlotButton_OnClick = getglobal("CharacterBag0Slot"):GetScript("OnClick");
	for i = 0, 3 do
		getglobal("CharacterBag" .. i .. "Slot"):SetScript("OnLeave", BagnonBlizBag_OnLeave);
		getglobal("CharacterBag" .. i .. "Slot"):SetScript("OnClick", BagnonBlizBag_OnClick);
	end
	
	bKeyRingButton_OnEnter = KeyRingButton:GetScript("OnEnter");
	bKeyRingButton_OnClick = KeyRingButton:GetScript("OnClick");
	KeyRingButton:SetScript("OnEnter", BagnonBlizKeyRing_OnEnter);
	KeyRingButton:SetScript("OnLeave", BagnonBlizBag_OnLeave);
	KeyRingButton:SetScript("OnClick", BagnonBlizKeyRing_OnClick);
end

--Main Bag
function BagnonBlizMainBag_OnEnter()
	if( Bagnon:IsShown() ) then
		BagnonFrame_HighlightSlots(Bagnon, this:GetID());
	end
	bMainBag_OnEnter();
end

function BagnonBlizMainBag_OnClick()
	if( IsShiftKeyDown() ) then
		BagnonFrame_ToggleBag(Bagnon, this:GetID());
	else
		bMainBag_OnClick();
	end
end

--Normal Bags
function BagnonBlizBag_OnEnter()
	if(Bagnon:IsShown() ) then
		BagnonFrame_HighlightSlots(Bagnon, this:GetID() - 19);
	end
	
	bBagSlotButton_OnEnter();
end

function BagnonBlizBag_OnClick()
	if( IsShiftKeyDown() ) then
		BagnonFrame_ToggleBag(Bagnon, this:GetID() - 19);
	else
		bBagSlotButton_OnClick();
	end
end

function BagnonBlizBag_OnLeave()
	GameTooltip:Hide();
	BagnonFrame_UnhighlightAll(Bagnon);
end

--KeyRing
function BagnonBlizKeyRing_OnEnter()
	if(Bagnon:IsShown() ) then
		BagnonFrame_HighlightSlots(Bagnon, this:GetID());
	end
	bKeyRingButton_OnEnter();
end

function BagnonBlizKeyRing_OnClick()
	if( IsShiftKeyDown() ) then
		BagnonFrame_ToggleBag(Bagnon, this:GetID());
	else
		bKeyRingButton_OnClick();
	end
end
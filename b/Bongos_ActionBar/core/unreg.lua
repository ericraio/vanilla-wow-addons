--[[
	unreg.lua
		Gets rid of the main actionbar
		
	Frames Unregistered:
		MainMenuBar
		Experience Bar
		Action Bar
		Multibars
		Bonusbars
		Shapeshift
		Pet
--]]

--[[ Unregistering Functions ]]--

--Unregister action buttons
local function UnregisterActionButton(button)
	button:ClearAllPoints()
	button:UnregisterAllEvents();
	button:Hide();
end

--Hide action bar
local function UnregisterActionBars()
	BonusActionBarFrame:Hide();
	
	--Action Buttons
	for i = 1, 12, 1 do
		--main action bar
		UnregisterActionButton( getglobal("ActionButton"..i) );
		getglobal("ActionButton"..i).showgrid = nil;
		getglobal("ActionButton"..i).flashing = nil;
		getglobal("ActionButton"..i).flashtime = nil;
		
		--multibars
		UnregisterActionButton( getglobal("MultiBarBottomLeftButton"..i) );
		UnregisterActionButton( getglobal("MultiBarBottomRightButton"..i) );
		UnregisterActionButton( getglobal("MultiBarLeftButton"..i) );
		UnregisterActionButton( getglobal("MultiBarRightButton"..i) );
		
		--bonus bar
		UnregisterActionButton( getglobal("BonusActionButton"..i) );
	end	
	
	ActionBarUpButton:UnregisterEvent("ACTIONBAR_PAGE_CHANGED");
	BonusActionBarFrame:UnregisterAllEvents();
	MultiActionBar_ShowAllGrids = function() return; end;
	MultiActionBar_HideAllGrids = function() return; end;
end

--Hide shapeshift bars
local function UnregisterShapeshiftBar()
	ShapeshiftBarFrame:UnregisterAllEvents();
end

--Hide pet bar
local function UnregisterPetBar()
	PetActionBarFrame:UnregisterAllEvents();
	PetActionBarFrame:Hide();
	PetActionBarFrame.showgrid = nil;
	
	for i=1, NUM_PET_ACTION_SLOTS do
		getglobal("PetActionButton" .. i):UnregisterAllEvents();
	end
end

--[[ Startup ]]--
MainMenuBar:Hide();
ExhaustionTick:UnregisterAllEvents();
UnregisterActionBars();
UnregisterShapeshiftBar();
UnregisterPetBar();
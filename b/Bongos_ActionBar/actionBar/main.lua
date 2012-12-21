--[[
	BActionButtonMain
		This is the event handler for Bongos ActonBars and ActionButtons.
	
	TODO:
		Nothing, I think.  Should be fairly optimized.
--]]

bg_showGrid = nil; --is determines if empty buttons are being shown or not.

--[[ Helper Functions ]]--

function BActionMain_ForAllButtons(action, arg1)
	local numActionBars = BActionBar.GetNumber();
	
	for i = 1, numActionBars do
		if getglobal("BActionBar" .. i) then	
			for j = BActionBar.GetStart(i), BActionBar.GetEnd(i) do
				local button = getglobal("BActionButton" .. j);
				if button and button:GetParent() then
					action(button, arg1);
				else
					break;
				end
			end
		end
	end
end

function BActionMain_ForAllShownButtons(action, arg1)
	local numActionBars = BActionBar.GetNumber();
	
	for i = 1, numActionBars do
		local bar = getglobal("BActionBar" .. i);
		if bar and bar:IsShown() then
			for j = BActionBar.GetStart(i), BActionBar.GetEnd(i) do
				local button = getglobal("BActionButton" .. j);
				if button then
					action(button, arg1);
				else
					break;
				end
			end
		end
	end
end

--[[ Update Functions ]]--

--Enable/disable the OnUpdate function depending on if contextual paging is enabled or not
function BActionMain_UpdateOnUpdateHandler()
	for i = 1, BActionBar.GetNumber() do
		if BActionBar.CanContextPage(i) then
			BActionMain:Show();
			return;
		end
	end
	BActionMain:Hide();
end

local function UpdateButtonsWithID(id)
	local numActionBars = BActionBar.GetNumber();
	for i = 1, numActionBars do
		local bar = getglobal("BActionBar" .. i);
		if bar and bar:IsShown() then
			for j = BActionBar.GetStart(i), BActionBar.GetEnd(i) do
				local button = getglobal("BActionButton" .. j);
				if button and BActionButton.GetPagedID(button:GetID()) == id then
					BActionButton.Update(button);
				end
			end
		end
	end
end

function BActionMain_UpdatePage()
	for i = 1, BActionBar.GetNumber() do
		if BActionBar.CanPage(i) then
			BActionBar.Update(i);
		end
	end
end

local function GetTargetOffset()
	if not bg_quickPaged and UnitCanAttack("player", "target") then
		return 0;
	end
	return 1;
end

function BActionMain_UpdateContext(barID)
	local offset = GetTargetOffset();
	if barID then
		if BActionBar.CanContextPage(barID) then
			BActionBar.SetContextOffset(barID, offset);
		end
	else
		for i = 1, BActionBar.GetNumber() do
			if BActionBar.CanContextPage(i) then
				BActionBar.SetContextOffset(i, offset);
			end
		end
	end
end

--[[ OnX Functions ]]--

--in theory, I've optimized the if/then/else order of event frequency
local function OnEvent()
	if arg1 == "player" and (event == "UNIT_MANA" or event == "UNIT_HEALTH" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY") or event == "PLAYER_COMBO_POINTS" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable);
	elseif event == "ACTIONBAR_UPDATE_COOLDOWN" or event == "ACTIONBAR_UPDATE_USABLE" or event == "UPDATE_INVENTORY_ALERTS" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsableAndCooldown);
	elseif event == "UNIT_AURASTATE" and (arg1 == "player" or arg1 == "target") then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable);
	elseif event == "ACTIONBAR_UPDATE_STATE" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateState);
	elseif event == "UNIT_INVENTORY_CHANGED" and arg1=="player" then
		BActionMain_ForAllShownButtons(BActionButton.Update);
	elseif event == "PLAYER_TARGET_CHANGED" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable);
		if this:IsShown() then
			BActionMain_UpdateContext();
		end
	elseif event == "PLAYER_AURAS_CHANGED" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateUsable);
	elseif event == "ACTIONBAR_PAGE_CHANGED" then
		BActionMain_UpdatePage();
	elseif event == "PLAYER_ENTER_COMBAT" then
		IN_ATTACK_MODE = 1;
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash);
	elseif event == "PLAYER_LEAVE_COMBAT" then
		IN_ATTACK_MODE = nil;
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash);
	elseif event == "START_AUTOREPEAT_SPELL" then
		IN_AUTOREPEAT_MODE = 1;
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash);
	elseif event == "STOP_AUTOREPEAT_SPELL" then
		IN_AUTOREPEAT_MODE = nil;
		BActionMain_ForAllShownButtons(BActionButton.UpdateFlash);
	elseif event == "ACTIONBAR_SLOT_CHANGED" then
		UpdateButtonsWithID(arg1);
	elseif event == "ACTIONBAR_SHOWGRID" then
		bg_showGrid = 1;
		BActionMain_ForAllButtons(BActionButton.ShowGrid);
	elseif event == "ACTIONBAR_HIDEGRID" then
		bg_showGrid = nil;
		if not BActionSets_ShowGrid() then
			BActionMain_ForAllButtons(BActionButton.HideGrid);
		end
	elseif event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" then
		BActionMain_ForAllShownButtons(BActionButton.UpdateState);
	elseif event == "UPDATE_BINDINGS" then
		BActionMain_ForAllButtons(BActionButton.UpdateHotkey);
	elseif event == "PLAYER_LOGIN" then
		BActionMain_ForAllShownButtons(BActionButton.Update);
		if this:IsShown() then
			BActionMain_UpdateContext();
		end
	end
end

local function OnUpdate()
	if this.update <= 0 then
		if not bg_quickPaged then
			if BActionSets_IsSelfCastHotkeyDown() then
				bg_quickPaged = 1;
				BActionMain_UpdateContext();
			end
		elseif not BActionSets_IsSelfCastHotkeyDown() then
			bg_quickPaged = nil;
			BActionMain_UpdateContext();
		end
		this.update = 0.01;
	else
		this.update = this.update - arg1;
	end
end

--[[ Function Overrides ]]--

--increment page
ActionBar_PageUp = function()
	CURRENT_ACTIONBAR_PAGE = CURRENT_ACTIONBAR_PAGE + 1;
	if CURRENT_ACTIONBAR_PAGE > BActionBar.GetNumber() then
		CURRENT_ACTIONBAR_PAGE = 1;
	end
	ChangeActionBarPage();
end

--decrement page
ActionBar_PageDown = function()
	CURRENT_ACTIONBAR_PAGE = CURRENT_ACTIONBAR_PAGE - 1;
	if CURRENT_ACTIONBAR_PAGE < 1 then
		CURRENT_ACTIONBAR_PAGE = BActionBar.GetNumber();
	end
	ChangeActionBarPage();
end

--[[ Startup ]]--

local function RegisterEvents(frame)
	frame:RegisterEvent("PLAYER_TARGET_CHANGED");
	frame:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	frame:RegisterEvent("PLAYER_AURAS_CHANGED");
	frame:RegisterEvent("ACTIONBAR_SHOWGRID");
	frame:RegisterEvent("ACTIONBAR_HIDEGRID");
	frame:RegisterEvent("UPDATE_BINDINGS");
	
	frame:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	frame:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	frame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	frame:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	frame:RegisterEvent("UNIT_AURASTATE");
	frame:RegisterEvent("CRAFT_SHOW");
	frame:RegisterEvent("CRAFT_CLOSE");
	frame:RegisterEvent("TRADE_SKILL_SHOW");
	frame:RegisterEvent("TRADE_SKILL_CLOSE");
	frame:RegisterEvent("UNIT_HEALTH");
	frame:RegisterEvent("UNIT_MANA");
	frame:RegisterEvent("UNIT_RAGE");
	frame:RegisterEvent("UNIT_FOCUS");
	frame:RegisterEvent("UNIT_ENERGY");
	frame:RegisterEvent("PLAYER_ENTER_COMBAT");
	frame:RegisterEvent("PLAYER_LEAVE_COMBAT");
	frame:RegisterEvent("PLAYER_COMBO_POINTS");
	frame:RegisterEvent("START_AUTOREPEAT_SPELL");
	frame:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	
	frame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	frame:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	frame:RegisterEvent("PLAYER_LOGIN");
end

BScript.AddStartupAction(function()
	if not BActionMain then
		--create the event frame
		local frame = CreateFrame("Frame", "BActionMain");
		frame:Hide();
		frame.update = 0.01;
		frame:SetScript("OnEvent", OnEvent);
		frame:SetScript("OnUpdate", OnUpdate);
		
		RegisterEvents(frame);
	end
	
	--Create actionbars
	for i = 1, BActionBar.GetNumber() do
		BActionBar.Create(i);
	end
	BActionMain_UpdateOnUpdateHandler();
end)
--[[
		global.lua
			scripts for the "Global" panel of the Bongos Options Menu
--]]

function BOptionsGlobal_OnLoad()
	local name = this:GetName();
	
	if IsAddOnLoaded("Bongos_ActionBar") then
		local lockButtons = CreateFrame("CheckButton", name .. "LockButtons", this, "BongosCheckButtonTemplate");
		lockButtons:SetText("Lock Buttons");
		lockButtons:SetPoint("TOPLEFT", name .. "StickyBars", "BOTTOMLEFT")
		lockButtons:SetScript("OnClick", function()
			BActionSets_SetButtonsLocked(this:GetChecked());
		end);
		
		local showGrid = CreateFrame("CheckButton", name .. "ShowGrid", this, "BongosCheckButtonTemplate");
		showGrid:SetText("Show Empty Buttons");
		showGrid:SetPoint("TOPLEFT", lockButtons, "BOTTOMLEFT")
		showGrid:SetScript("OnClick", function()
			BActionSets_SetShowGrid(this:GetChecked());
		end);
		
		local quickMove = CreateFrame("Frame", name .. "QuickMove", this, "BongosOptionsDropDown");
		quickMove:SetPoint("TOPLEFT", showGrid, "BOTTOMLEFT", -14, 0);
		quickMove:SetScript("OnShow", BOptionsQuickMove_OnShow);
		getglobal(quickMove:GetName() .. "Label"):SetText("Quick Move Key");
		UIDropDownMenu_Initialize(quickMove, BOptionsQuickMove_Initialize);
		UIDropDownMenu_SetSelectedValue(quickMove, BActionSets_GetQuickMoveMode());
	end
end

function BOptionsGlobal_OnShow()
	this.onShow = 1;
	
	local name = this:GetName();
	
	getglobal(name .. "Lock"):SetChecked(BongosSets.locked);
	getglobal(name .. "StickyBars"):SetChecked(BongosSets.sticky);
	getglobal(name .. "Alpha"):SetValue(100);
	getglobal(name .. "Scale"):SetValue(100);
	
	if IsAddOnLoaded("Bongos_ActionBar") then
		getglobal(name .. "LockButtons"):SetChecked(BActionSets_ButtonsLocked());
		getglobal(name .. "ShowGrid"):SetChecked(BActionSets_ShowGrid());
	end
	
	this.onShow = nil;
end

--[[ Quick Move Dropdown ]]--
function BOptionsQuickMove_OnShow()
	UIDropDownMenu_Initialize(this, BOptionsQuickMove_Initialize);
	
	UIDropDownMenu_SetWidth(72, this);
end

local function QuickMove_OnClick()
	UIDropDownMenu_SetSelectedValue(BOptionsPanelGlobalQuickMove, this.value);
	BActionSets_SetQuickMoveMode(this.value);
end

local function QuickMove_AddButton(text, value, selectedValue)
	--no hotkey
	local info = {};
	info.text = text;
	info.func = QuickMove_OnClick;
	info.value = value;
	if selectedValue == value then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);
end


--add all buttons to the dropdown menu
function BOptionsQuickMove_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(BOptionsPanelGlobalQuickMove);
	
	--no hotkey
	QuickMove_AddButton("None", nil, selectedValue);
	QuickMove_AddButton("Shift", 1, selectedValue);
	QuickMove_AddButton("Control", 2, selectedValue);
	QuickMove_AddButton("Alt", 3, selectedValue);
end
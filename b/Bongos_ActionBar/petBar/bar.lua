--[[
	BPetBar
		Scripts used by the Bongos Pet Action Bar replacement

	Buttons:
		PetActionButton1 .. PetActionButton10
	
	Saved Variables:
		Bongos.pet = {
			<All variables from BBar>
			space
				The spacing between action buttons, in pixels.  A nil value means that the bar is using default spacing
			rows
				How many rows the bar is organized into.
		}
	
	TODO:
		Add the ability to specify the number of rows.
		Don't hid the bar itself, but hide its buttons.
		Code cleanup
--]]

--constants
local DEFAULT_SPACING = 3;
local DEFAULT_ROWS = 1;

--[[ Helper Functions ]]--

function BPetBar_ForAllButtons(action, arg1)
	for i=1, NUM_PET_ACTION_SLOTS do
		action(getglobal("BPetActionButton"..i), arg1);
	end
end

--[[ Layout Functions ]]--

local function SaveSettings(bar, rows, space)
	if not space or space == DEFAULT_SPACING then
		space = nil;
	end
	bar.sets.space = space;

	if not rows or rows == DEFAULT_ROWS then
		rows = nil
	end
	bar.sets.rows = rows;
	
	return rows or DEFAULT_ROWS, space or DEFAULT_SPACING;
end

local function Layout(bar, rows, space)
	rows, space = SaveSettings(bar, rows, space);
	local columns = math.ceil(NUM_PET_ACTION_SLOTS / rows);
	
	--resize the bar
	bar:SetWidth((30 + space) * columns - space);
	bar:SetHeight((30 + space) * math.ceil(NUM_PET_ACTION_SLOTS / columns) - space);
	
	--set the position of the first button of the bar
	local button = getglobal("BPetActionButton1");
	if not button or button:GetParent() ~= bar then
		for i=1, NUM_PET_ACTION_SLOTS do
			BPetButton.Create(i, bar);
		end
		button = getglobal("BPetActionButton1");
	end
		
	button:ClearAllPoints();
	button:SetPoint("TOPLEFT", bar);
	
	--set the positions of the remaining buttons
	local index = 1;
	for i = 1, rows, 1 do 
		for j = 1, columns, 1 do
			index = index + 1;
			if index > NUM_PET_ACTION_SLOTS then return; end
			button = getglobal("BPetActionButton" .. index);
			button:ClearAllPoints();
			button:SetPoint("LEFT", "BPetActionButton" .. index - 1, "RIGHT", space, 0);
		end
		if index > NUM_PET_ACTION_SLOTS then return; end
		button = getglobal("BPetActionButton" .. index);
		button:ClearAllPoints();
		button:SetPoint("TOP", "BPetActionButton" .. index - columns, "BOTTOM", 0, -space);
	end
end
--[[ Event Functions ]]--

local function OnEvent()
	if event == "UPDATE_BINDINGS" then
		BPetBar_ForAllButtons(BPetButton.UpdateHotkey);
	elseif PetHasActionBar() then
		if (event == "UNIT_FLAGS" or event == "UNIT_AURA") and arg1 == "pet" then
			BPetBar_ForAllButtons(BPetButton.Update);
		elseif  event == "PET_BAR_UPDATE" then
			BPetBar_ForAllButtons(BPetButton.Update);
		elseif event =="PET_BAR_UPDATE_COOLDOWN" then
			BPetBar_ForAllButtons(BPetButton.UpdateCooldown);
		elseif event =="PET_BAR_SHOWGRID" then
			bg_showGridPet = 1;
			BPetBar_ForAllButtons(BPetButton.ShowGrid);
		elseif event =="PET_BAR_HIDEGRID" then
			bg_showGridPet = nil;
			if not BActionSets_ShowGrid() then
				BPetBar_ForAllButtons(BPetButton.HideGrid);
			end
		end
	else
		BPetBar_ForAllButtons(BPetButton.Hide);
	end
end

--[[ Rightclick Menu Functions ]]--
local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu");
	menu:SetText("Pet Bar");
	menu:SetWidth(220);
	menu:SetHeight(236);
	
	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate");
	
	local rowsSlider = CreateFrame("Slider", name .. "Rows", menu, "BongosSlider");
	rowsSlider:SetPoint("TOPLEFT", hideButton, "BOTTOMLEFT", 2, -10);
	rowsSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			Layout(BPetBar, this:GetValue(), BPetBar.sets.space);
		end
		getglobal(this:GetName() .. "ValText"):SetText(this:GetValue());
	end);
	rowsSlider:SetValueStep(1);
	rowsSlider:SetMinMaxValues(1, NUM_PET_ACTION_SLOTS);
	getglobal(name .. "RowsText"):SetText("Rows");
	getglobal(name .. "RowsLow"):SetText(1);
	getglobal(name .. "RowsHigh"):SetText(NUM_PET_ACTION_SLOTS);
	
	local spacingSlider = CreateFrame("Slider", name .. "Spacing", menu, "BongosSpaceSlider");
	spacingSlider:SetPoint("TOP", rowsSlider, "BOTTOM", 0, -24);
	spacingSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			Layout(BPetBar, BPetBar.sets.rows, this:GetValue());
		end
		getglobal(this:GetName() .. "ValText"):SetText(this:GetValue());
	end);
	
	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider");
	scaleSlider:SetPoint("TOP", spacingSlider, "BOTTOM", 0, -24);
	
	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider");
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24);
end

--Called when the right click menu is shown, loads the correct values to the checkbuttons/sliders/text
local function ShowMenu(bar)
	if not BongosPetBarMenu then
		CreateConfigMenu("BongosPetBarMenu");
	end
	
	BongosPetBarMenu.onShow = 1;
	BongosPetBarMenu.frame = bar;
	
	BongosPetBarMenuHide:SetChecked(not bar.sets.vis);
	BongosPetBarMenuSpacing:SetValue(bar.sets.space or DEFAULT_SPACING);
	BongosPetBarMenuRows:SetValue(bar.sets.rows or DEFAULT_ROWS);
	
	BongosPetBarMenuScale:SetValue(bar:GetScale() * 100);
	BongosPetBarMenuOpacity:SetValue(bar:GetAlpha() * 100);
	
	BMenu.ShowMenuForBar(BongosPetBarMenu, bar);
	BongosPetBarMenu.onShow = nil;
end

--[[ Startup ]]--

BScript.AddStartupAction(function()
	local bar = BBar.Create("pet", "BPetBar", "BActionSets.pet", ShowMenu);
	if not bar:IsUserPlaced() then
		bar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 528);
	end
	
	bar:SetScript("OnEvent", OnEvent);
	bar:RegisterEvent("UNIT_FLAGS");
	bar:RegisterEvent("UNIT_AURA");
	bar:RegisterEvent("PET_BAR_UPDATE");
	bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN");
	bar:RegisterEvent("PET_BAR_SHOWGRID");
	bar:RegisterEvent("PET_BAR_HIDEGRID");
	bar:RegisterEvent("UPDATE_BINDINGS");

	Layout(bar, bar.sets.rows, bar.sets.space);
end)
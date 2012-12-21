--[[
	BClassBar
		<description>
		
	Saved Variables:
		Bongos.class = {
			<All variables from BBar>
			space
				The spacing between action buttons, in pixels.  A nil value means that the bar is using default spacing
			rows
				How many rows the bar is organized into.
		}
--]]

--constants
local DEFAULT_SPACING = 2;
local DEFAULT_ROWS = 1;

--[[ Utility Functions ]]--

function BClassBar_ForAllButtons(action, arg1)
	for i = 1, GetNumShapeshiftForms() do
		local button = getglobal("BClassBarButton" .. i);
		if button then
			action(button, arg1);
		else
			return;
		end
	end
end

--[[ Layout Functions ]]--

local function SaveSettings(bar, rows, space)
	if not space or space == DEFAULT_SPACING then
		space = nil;
	end
	bar.sets.space = space;
	
	if not rows or rows == DEFAULT_ROWS then
		rows = nil;
	end
	bar.sets.rows = rows;
	
	return (rows or DEFAULT_ROWS), (space or DEFAULT_SPACING);
end

local function Layout(bar, rows, space)
	rows, space = SaveSettings(bar, rows, space);
	
	local numForms = GetNumShapeshiftForms();
	local columns = math.ceil(numForms / rows);
	
	--resize the bar
	bar:SetWidth((30 + space) * columns - space);
	bar:SetHeight((30 + space) * math.ceil(numForms / columns) - space);
	
	local index = 1;
	local buttonPrefix = bar:GetName() .. "Button";
	
	--set the position of the first button of the bar
	local button = getglobal(buttonPrefix .. index);
	button:ClearAllPoints();
	button:SetPoint("TOPLEFT", bar);
	
	--set the positions of the remaining buttons
	for i = 1, rows, 1 do 
		for j = 1, columns, 1 do
			index = index + 1;
			if index > numForms then return; end
			
			button = getglobal(buttonPrefix .. index);
			button:ClearAllPoints();
			button:SetPoint("LEFT", buttonPrefix .. index - 1, "RIGHT", space, 0);
		end
		if(index > numForms) then return; end
		
		button = getglobal(buttonPrefix .. index);
		button:ClearAllPoints();
		button:SetPoint("TOP", buttonPrefix .. index - columns, "BOTTOM", 0, -space);
	end
end

--[[ OnX Functions ]]--

local function OnEvent()
	if event == "UPDATE_BINDINGS" then
		BClassBar_ForAllButtons(BClassButton.UpdateHotkey);
		return;
	end
	local bar = this;
	
	--Update buttons
	for i=1, GetNumShapeshiftForms() do
		local button = getglobal(bar:GetName() .. "Button" .. i);
		if not button then
			button = BClassButton.Create(i, bar);
			layoutChanged = 1;
		else
			BClassButton.Update(button);
		end
	end
	
	if layoutChanged then
		Layout(bar, bar.sets.rows, bar.sets.space);
	end
end

--[[  Rightclick Menu Functions  ]]--

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu");
	menu:SetText("Class Bar");
	menu:SetWidth(220);
	menu:SetHeight(236);
	
	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate");
	
	local rowsSlider = CreateFrame("Slider", name .. "Rows", menu, "BongosSlider");
	rowsSlider:SetPoint("TOPLEFT", hideButton, "BOTTOMLEFT", 2, -10);
	rowsSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			Layout(BClassBar, this:GetValue(), BClassBar.sets.space);
		end
		getglobal(this:GetName() .. "ValText"):SetText( this:GetValue() );
	end);
	rowsSlider:SetValueStep(1);
	rowsSlider:SetMinMaxValues(1, GetNumShapeshiftForms());
	getglobal(name .. "RowsText"):SetText("Rows");
	getglobal(name .. "RowsLow"):SetText(1);
	
	local spacingSlider = CreateFrame("Slider", name .. "Spacing", menu, "BongosSpaceSlider");
	spacingSlider:SetPoint("TOP", rowsSlider, "BOTTOM", 0, -24);
	spacingSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			Layout(BClassBar, BClassBar.sets.rows, this:GetValue());
		end
		getglobal(this:GetName() .. "ValText"):SetText( this:GetValue() );
	end);
	
	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider");
	scaleSlider:SetPoint("TOP", spacingSlider, "BOTTOM", 0, -24);
	
	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider");
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24);
end

--Called when the right click menu is shown, loads the correct values to the checkbuttons/sliders/text
local function ShowMenu(bar)
	if not BongosClassBarMenu then
		CreateConfigMenu("BongosClassBarMenu");
	end
	
	BongosClassBarMenu.onShow = 1;
	BongosClassBarMenu.frame = bar;
	
	BongosClassBarMenuHide:SetChecked(not bar.sets.vis);
	BongosClassBarMenuSpacing:SetValue(bar.sets.space or DEFAULT_SPACING);
	BongosClassBarMenuRows:SetValue(bar.sets.rows or DEFAULT_ROWS);

	BongosClassBarMenuRowsHigh:SetText(GetNumShapeshiftForms());
	BongosClassBarMenuRows:SetMinMaxValues(1, GetNumShapeshiftForms());
	
	BongosClassBarMenuScale:SetValue(bar:GetScale() * 100);
	BongosClassBarMenuOpacity:SetValue(bar:GetAlpha() * 100);
	
	--Position menu then show it
	BMenu.ShowMenuForBar(BongosClassBarMenu, bar);
	BongosClassBarMenu.onShow = nil;
end

--[[ Startup ]]--

BScript.AddStartupAction(function()
	local bar = BBar.Create("class", "BClassBar", "BActionSets.class", ShowMenu);
	if not bar:IsUserPlaced() then
		bar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 480);
	end
	
	bar:SetScript("OnEvent", OnEvent);
	
	bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
	bar:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	bar:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	bar:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	bar:RegisterEvent("SPELL_UPDATE_USABLE");
	bar:RegisterEvent("PLAYER_AURAS_CHANGED");
	bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	bar:RegisterEvent("UNIT_HEALTH");
	bar:RegisterEvent("UNIT_HEALTH");
	bar:RegisterEvent("UNIT_RAGE");
	bar:RegisterEvent("UNIT_FOCUS");
	bar:RegisterEvent("UNIT_ENERGY");
	bar:RegisterEvent("UPDATE_BINDINGS");
end);
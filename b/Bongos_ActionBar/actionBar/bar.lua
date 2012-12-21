--[[
	BActionBar
		Bongos Actionbars.  Bongos ActionBars mimic the functionality of the Blizzard MainActionBar, but can be 
		customized to a much higher degree.  In theory, you can have an infinite number of actionbars; but in reality,  
		there's a hard limit of 120 action buttons.

	Saved Variables:
		BActionSets[barID] = {
			<All variables from BBar>
			space
				The spacing between action buttons, in pixels.  A nil value means that the bar is using default spacing
			rows
				How many rows the bar is organized into, should be replaced with columns.  nil means default
			size
				How many buttons the bar has.  nil for max
		}
--]]

local DEFAULT_SPACING = 2;
local DEFAULT_ROWS = 1;
local MAX_BUTTONS = 120;
local DEFAULT_NUM_ACTIONBARS = 10;

local stanceOffset = {};
local contextOffset = {};

--[[ Layout Functions ]]--

--update the settings of a specific bar with its new size, rows, and spacing
local function UpdateSettings(id, rows, space, size, start)
	local maxButtonsPerBar = math.floor(MAX_BUTTONS / BActionBar.GetNumber());
	
	--save size
	if not size or size > maxButtonsPerBar then
		size = maxButtonsPerBar;
		BActionSets[id].size = nil;
	else
		BActionSets[id].size = size;
	end
	if (size + start) > (MAX_BUTTONS + 1) then
		size = size - (size + start - MAX_BUTTONS + 1);
	end
	
	--save rows
	if not rows or rows == DEFAULT_ROWS then
		rows = DEFAULT_ROWS;
		BActionSets[id].rows = nil;
	else
		BActionSets[id].rows = rows;
	end
	if rows > size then
		rows = size;
	end
	
	--save spacing
	if not space or space == DEFAULT_SPACING then
		space = nil;
	end
	BActionSets[id].space = space;
	
	return rows, (space or DEFAULT_SPACING), size;
end

--layout a bar with the given settings
local function PlaceButtons(bar, rows, space, size, start)
	local columns = math.ceil(size / rows);

	--resize the bar
	bar:SetWidth((37 + space) * columns - space);
	bar:SetHeight((37 + space) * math.ceil(size / columns) - space);
	
	--set the start and end IDs
	local index = start;
	if index > MAX_BUTTONS then return; end
	
	local endIndex = start + size;
	if endIndex > MAX_BUTTONS + 1 then
		endIndex = MAX_BUTTONS + 1;
	end
	
	--set the position of the first button of the bar
	local button = getglobal("BActionButton" .. index) or BActionButton.Create(index, bar);
	button:SetParent(bar);
	button:SetAlpha(bar:GetAlpha());
	button:ClearAllPoints();
	button:SetPoint("TOPLEFT", bar);
	
	--set the positions of the remaining buttons
	for i = 1, rows, 1 do 
		for j = 1, columns, 1 do
			index = index + 1;
			if index >= endIndex then  return; end
			
			button = getglobal("BActionButton" .. index) or BActionButton.Create(index, bar);
			button:SetParent(bar);
			button:SetAlpha(bar:GetAlpha());
			
			button:ClearAllPoints();
			button:SetPoint("LEFT", "BActionButton" .. index - 1, "RIGHT", space + 1, 0);
		end	
		if index >= endIndex then return; end
		
		button = getglobal("BActionButton" .. index) or BActionButton_Create(index, bar);
		button:SetParent(bar);
		button:SetAlpha(bar:GetAlpha());
		
		button:ClearAllPoints();
		button:SetPoint("TOP", "BActionButton" .. index - columns, "BOTTOM", 0, -space - 1);
	end
end

--sets up the given bar to have the given settings
local function Layout(id, rows, space, size)
	local start = BActionBar.GetStart(id);
	
	--remove all currently used buttons	from the bar
	for i = start, start + BActionBar.GetSize(id) - 1 do
		local button = getglobal("BActionButton" .. i);
		if button then
			button:Hide();
		else
			break;
		end
	end
	
	--update the bar's settings
	rows, space, size = UpdateSettings(id, rows, space, size, start);
	
	--layout the bar if its currently shown
	local bar = getglobal("BActionBar" .. id);
	if bar and bar:IsShown() then
		PlaceButtons(bar, rows, space, size, start);
	end
	
	--hide unused buttons
	for i = start, start + size - 1 do
		local button = getglobal("BActionButton" .. i);
		if button then
			BActionButton.ShowIfUsed(button);
		else
			break;
		end
	end
end

--[[  Rightclick Menu Stuff ]]--

--create the menu
local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu");
	menu:SetWidth(220);
	menu:SetHeight(306);
	
	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate");
	
	local pageButton = CreateFrame("CheckButton", name .. "Page", menu, "BongosCheckButtonTemplate");
	pageButton:SetScript("OnClick", function()
		local bar = this:GetParent().frame;		
		if bar.sets.paging then
			bar.sets.paging = nil;
		else
			bar.sets.paging = 1;
		end
		BActionBar.Update(bar.id);
	end);
	pageButton:SetPoint("TOP", hideButton, "BOTTOM", 0, 4);
	pageButton:SetText("Allow Paging");
	
	local sizeSlider = CreateFrame("Slider", name .. "Size", menu, "BongosSlider");
	sizeSlider:SetPoint("TOPLEFT", name .. "Page", "BOTTOMLEFT", 2, -10);
	sizeSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			local bar = this:GetParent().frame;
			Layout(bar.id, bar.sets.rows, bar.sets.space, this:GetValue());

			BongosActionBarMenuRowsHigh:SetText(bar.sets.size);
			BongosActionBarMenuRows:SetMinMaxValues(1, bar.sets.size);
		end
		getglobal(this:GetName() .. "ValText"):SetText(this:GetValue());
	end);
	sizeSlider:SetValueStep(1);
	getglobal(name .. "SizeText"):SetText("Size");
	getglobal(name .. "SizeLow"):SetText(1);
	
	local rowsSlider = CreateFrame("Slider", name .. "Rows", menu, "BongosSlider");
	rowsSlider:SetPoint("TOP", sizeSlider, "BOTTOM", 0, -24);
	rowsSlider:SetScript("OnValueChanged", function()
		if(not this:GetParent().onShow) then
			local bar = this:GetParent().frame;
			Layout(bar.id, this:GetValue(), bar.sets.space, bar.sets.size);
		end
		getglobal(this:GetName() .. "ValText"):SetText(this:GetValue());
	end);
	rowsSlider:SetValueStep(1);
	getglobal(name .. "RowsText"):SetText("Rows");
	getglobal(name .. "RowsLow"):SetText(1);
	
	local spacingSlider = CreateFrame("Slider", name .. "Spacing", menu, "BongosSpaceSlider");
	spacingSlider:SetPoint("TOP", rowsSlider, "BOTTOM", 0, -24);
	spacingSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			local bar = this:GetParent().frame;
			Layout(bar.id, bar.sets.rows, this:GetValue(), bar.sets.size);
		end
		getglobal(this:GetName() .. "ValText"):SetText(this:GetValue());
	end);
	
	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider");
	scaleSlider:SetPoint("TOP", spacingSlider, "BOTTOM", 0, -24);
	
	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider");
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24);
end

--Show the menu, loading all values
local function ShowMenu(bar)
	if not BongosActionBarMenu then
		CreateConfigMenu("BongosActionBarMenu");
	end
	
	BongosActionBarMenu.onShow = 1;
	BongosActionBarMenu.frame = bar;
	
	BongosActionBarMenuText:SetText("Action Bar " .. bar.id);
	BongosActionBarMenuHide:SetChecked(not bar.sets.vis);
	BongosActionBarMenuPage:SetChecked(bar.sets.paging);
	
	local maxSize = math.floor(MAX_BUTTONS / BActionBar.GetNumber());
	local currentSize = BActionBar.GetSize(bar.id);
	BongosActionBarMenuSizeHigh:SetText(maxSize);
	BongosActionBarMenuSize:SetMinMaxValues(1, maxSize);
	BongosActionBarMenuSize:SetValue(currentSize);
	
	BongosActionBarMenuRows:SetMinMaxValues(1, currentSize);
	BongosActionBarMenuRowsHigh:SetText(currentSize);
	BongosActionBarMenuRows:SetValue(bar.sets.rows or DEFAULT_ROWS);
	
	BongosActionBarMenuSpacing:SetValue(bar.sets.space or DEFAULT_SPACING);
	BongosActionBarMenuScale:SetValue(bar:GetScale() * 100);
	BongosActionBarMenuOpacity:SetValue(bar:GetAlpha() * 100);
	
	BMenu.ShowMenuForBar(BongosActionBarMenu, bar);
	BongosActionBarMenu.onShow = nil;
end

--[[ Called when an ActionBar is deleted ]]--
local function OnDelete(bar)
	local start = BActionBar.GetStart(bar.id)
	for i = start, start + BActionBar.GetSize(bar.id) - 1 do
		button = getglobal("BActionButton" .. i);
		if button then
			button:SetParent(nil);
			button:ClearAllPoints();
			button:Hide();
		else
			break;
		end 
	end
end

--[[ Usable Functions ]]--
BActionBar = {
	--constructor
	Create = function(id)
		assert(id, "Invalid Actionbar ID");
		
		if not id == 1 and not BActionSets[1] then
			BActionSets[1] = {
				vis = 1,
				paging = 1,
			}
		end

		local bar = BBar.Create(id, "BActionBar" .. id,  "BActionSets." .. id, ShowMenu, false, OnDelete);
		bar:SetID(id);
		bar:SetScript("OnShow", function() BActionBar.OnShow(); end);

		if not bar:IsUserPlaced() then
			local col = mod(BActionBar.GetStart(id),12)
			if col == 0 then col = 12; end
			local row = ceil(BActionBar.GetStart(id) / 12) - 1
			bar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOM", -38*(12-col)+222, 38*row);
		end
		if bar:IsShown() then
			Layout(id, bar.sets.rows, bar.sets.space, bar.sets.size);
		end
		
		return bar;
	end,
		
	--[[ OnX ]]--
	
	OnShow = function()
		if not getglobal("BActionButton" .. BActionBar.GetStart(this.id)) then	
			Layout(this.id, this.sets.rows, this.sets.space, this.sets.size);
		end
		BActionBar.Update(this.id)
	end,

	--[[ Update ]]--

	Update = function(barID)
		local bar = getglobal("BActionBar" .. barID);
		if bar and bar:IsShown() then
			for i = BActionBar.GetStart(barID), BActionBar.GetEnd(barID) do
				local button = getglobal("BActionButton" .. i);
				if button then
					BActionButton.Update(button);
					BActionButton.UpdateState(button);
				else
					break;
				end
			end
		end
	end,
	
	GetStart = function(barID)
		return floor(MAX_BUTTONS / BActionBar.GetNumber()) *(barID - 1) + 1;
	end,
	
	GetSize = function(barID)
		return BActionSets[barID].size or floor(MAX_BUTTONS / BActionBar.GetNumber());
	end,
	
	GetEnd = function(barID)
		return BActionBar.GetStart(barID) + BActionBar.GetSize(barID) - 1;
	end,

	--[[
		Paging Functions

		Precedence:
			1. paged manually  return (BActionSets[id].page and CURRENT_ACTIONBAR_PAGE ~= 1)
				special key held down, shift + number
			2. paged via shapeshift return (BActionSets[id].switchOnShift and BActionMain.shapeshifted) 
				in bear form, in cat form, in fury stance
			3. contextual paging
				should be used for such things as, if targeting a friendly unit, 
	--]]
	
	--normal paging
	CanPage = function(barID)
		return BActionSets[barID].paging;
	end,
	
	SetPaging = function(barID, enable)
		if enable then
			BActionSets[barID].paging = 1;
		else
			BActionSets[barID].paging = nil;
		end
		BActionBar.Update(barID);
	end,
	
	GetPage = function(barID)
		if BActionSets[barID].paging then	
			return (CURRENT_ACTIONBAR_PAGE - 1) * (BActionSets.g.skip or 0) + (CURRENT_ACTIONBAR_PAGE - 1);
		end
		return 0;
	end,

	--stance paging
	GetStance = function(barID)
		return stanceOffset[barID] or 0;
	end,
	
	SetStanceOffset = function(barID, offset)
		stanceOffset[barID] = offset;
		BActionBar.Update(barID);
	end,
	
	--context paging
	GetContext = function(barID)
		return contextOffset[barID] or 0;
	end,
	
	SetContextOffset = function(barID, offset)
		contextOffset[barID] = offset;
		BActionBar.Update(barID);
	end,
	
	CanContextPage = function(barID)
		return BActionSets[barID].inContext;
	end,
	
	SetContextPaging = function(barID, enable)
		if enable then
			BActionSets[barID].inContext = 1;
			BActionMain_UpdateOnUpdateHandler();
			BActionMain_UpdateContext(barID);
		else
			BActionSets[barID].inContext = nil;
			contextOffset[barID] = 0;
		end
		BActionBar.Update(barID);
	end,
	
	--[[
		Sets how many actionbars to use.  This function deletes all actionbars, then recreates them.
		This is done to make it easier to layout bars after adjusting how many there are.
	--]]
	SetNumber = function(numBars)
		local diff = (numBars or 10) - BActionBar.GetNumber();
		if diff ~= 0 then	
			for i = 1, BActionBar.GetNumber() do
				BBar.Delete(i);
			end
			
			BActionSets.g.numActionBars = numBars;
			for i = 1, BActionBar.GetNumber() do
				BActionBar.Create(i);
			end	
			BActionMain_UpdateOnUpdateHandler();
		end
	end,
	
	GetNumber = function()
		return BActionSets.g.numActionBars or DEFAULT_NUM_ACTIONBARS;
	end,
}
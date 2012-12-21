--[[
	bar.lua
		Scripts used for the Bongos Bag bar

	Saved Variables:
		Bongos.bag = {
			<All variables from BBar>
			space
				The spacing between action buttons, in pixels.  A nil value means that the bar is using default spacing
			rows
				How many rows the bar is organized into.
			oneBag
				Flag for if we're only showing the main bag.
		}
--]]

--constants
local DEFAULT_SPACING = 4;
local DEFAULT_ROWS = 1;

--[[ UI Functions ]]--

local function Layout(bar, rows, space)
	if not rows or rows == DEFAULT_ROWS then
		rows = nil;
	end
	bar.sets.rows = rows;
	
	if not space or space == DEFAULT_SPACING then
		bar.sets.space = nil;
		space = DEFAULT_SPACING;
	else
		bar.sets.space = space;
	end
	
	--clear all button positions
	for i = 0, 3 do
		getglobal("CharacterBag" .. i .. "Slot"):ClearAllPoints();
	end
	MainMenuBarBackpackButton:ClearAllPoints();
	
	if bar.sets.oneBag then
		--hide all bag buttons, show the main bag
		for i = 0, 3 do
			getglobal("CharacterBag" .. i .. "Slot"):Hide();
		end	
		MainMenuBarBackpackButton:SetPoint("TOPLEFT", bar);
		
		bar:SetWidth(37);
		bar:SetHeight(37);
	else
		--arrange all bag buttons, and the backpack
		for i = 0, 3 do
			getglobal("CharacterBag" .. i .. "Slot"):Show();
		end
		CharacterBag3Slot:SetPoint("TOPLEFT", bar);
		
		--vertical alignment
		if rows then
			for i = 0, 2 do
				getglobal("CharacterBag" .. i .. "Slot"):SetPoint("TOP", "CharacterBag" .. i+1 .. "Slot", "BOTTOM", 0, -space);
			end
			MainMenuBarBackpackButton:SetPoint("TOP", CharacterBag0Slot, "BOTTOM", 0, -space);
			
			bar:SetWidth((37 + space) - space);
			bar:SetHeight((37 + space) * 5 - space);
		--horizontal alignment
		else
			for i = 0, 2 do
				getglobal("CharacterBag" .. i .. "Slot"):SetPoint("LEFT", "CharacterBag" .. i+1 .. "Slot", "RIGHT", space, 0);
			end
			MainMenuBarBackpackButton:SetPoint("LEFT", CharacterBag0Slot, "RIGHT", space, 0);
			
			bar:SetWidth((37 + space) * 5 - space);
			bar:SetHeight((37 + space) - space);
		end
	end
end

--[[ Config Functions ]]--

local function ShowAsOneBag(enable)
	if enable then
		BBagBar.sets.oneBag = 1;
	else
		BBagBar.sets.oneBag = nil;
	end
	Layout(BBagBar, BBagBar.sets.rows, BBagBar.sets.space);
end

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu");
	menu:SetText("Bag Bar");
	menu:SetWidth(220);
	menu:SetHeight(250);
	
	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate");
	
	local oneBagButton = CreateFrame("CheckButton", name .. "OneBag", menu, "BongosCheckButtonTemplate");
	oneBagButton:SetScript("OnClick", function()
		ShowAsOneBag(this:GetChecked());
	end);
	oneBagButton:SetPoint("TOP", hideButton, "BOTTOM", 0, 4);
	oneBagButton:SetText("One Bag");
	
	local verticalButton = CreateFrame("CheckButton", name .. "Vertical", menu, "BongosCheckButtonTemplate");
	verticalButton:SetScript("OnClick", function()
		if this:GetChecked() then
			Layout(BBagBar, 5, BBagBar.sets.space);
		else
			Layout(BBagBar, nil, BBagBar.sets.space);
		end
	end);
	verticalButton:SetPoint("TOP", name .. "OneBag", "BOTTOM", 0, 4);
	verticalButton:SetText("Vertical");
	
	local spacingSlider = CreateFrame("Slider", name .. "Spacing", menu, "BongosSpaceSlider");
	spacingSlider:SetPoint("TOPLEFT", name .. "Vertical", "BOTTOMLEFT", 2, -10);
	spacingSlider:SetScript("OnValueChanged", function()
		if not this:GetParent().onShow then
			Layout(BBagBar, BBagBar.sets.rows, this:GetValue());
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
	if not BongosBagBarMenu then
		CreateConfigMenu("BongosBagBarMenu");
	end
	
	BongosBagBarMenu.onShow = 1;
	BongosBagBarMenu.frame = this:GetParent();
	
	BongosBagBarMenuHide:SetChecked(not bar.sets.vis);
	BongosBagBarMenuOneBag:SetChecked(bar.sets.oneBag);
	BongosBagBarMenuVertical:SetChecked(bar.sets.rows);
	BongosBagBarMenuSpacing:SetValue(bar.sets.space or DEFAULT_SPACING);
	
	BongosBagBarMenuScale:SetValue(bar:GetScale() * 100);
	BongosBagBarMenuOpacity:SetValue(bar:GetAlpha() * 100);
	
	BMenu.ShowMenuForBar(BongosBagBarMenu, bar);
	BongosBagBarMenu.onShow = nil;
end

--[[ Startup ]]--

local function AddFrameToBar(frame, parent)
	frame:SetParent(parent);
	frame:SetAlpha(parent:GetAlpha());
	frame:SetFrameLevel(0);
end

BScript.AddStartupAction(function()	
	local bar = BBar.Create("bags", "BBagBar", "BActionSets.bags", ShowMenu);
	if not bar:IsUserPlaced() then
		bar:SetPoint("BOTTOMRIGHT", UIParent);
	end

	for i = 0, 3 do
		AddFrameToBar(getglobal("CharacterBag" .. i .. "Slot"), bar);
	end
	AddFrameToBar(MainMenuBarBackpackButton, bar);
	MainMenuBarBackpackButton:Show();
	
	Layout(bar, bar.sets.rows, bar.sets.space);
end)
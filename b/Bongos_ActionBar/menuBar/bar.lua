--[[
	BMenuBar
		A 

	Saved Variables:
		Bongos.menu = {
			<All variables from BBar>
			space
				The spacing between action buttons, in pixels.  A nil value means that the bar is using default spacing
			rows
				How many rows the bar is organized into.
		}
--]]

local DEFAULT_SPACING = 2;
local DEFAULT_ROWS = 1;

--[[ Update Functions ]]--

local function Layout(bar, rows, space)
	if not space or space == DEFAULT_SPACING then
		bar.sets.space = nil;
		space = DEFAULT_SPACING;
	else
		bar.sets.space = space;
	end	
	if not rows or rows == DEFAULT_ROWS then
		bar.sets.rows = nil;
		rows = DEFAULT_ROWS;
	else
		bar.sets.rows = rows;
	end
	
	SpellbookMicroButton:ClearAllPoints();
	TalentMicroButton:ClearAllPoints();
	QuestLogMicroButton:ClearAllPoints();
	SocialsMicroButton:ClearAllPoints();
	WorldMapMicroButton:ClearAllPoints();
	MainMenuMicroButton:ClearAllPoints();
	HelpMicroButton:ClearAllPoints();
	
	local actSpace = space;
	if rows == DEFAULT_ROWS then
		space = space - 4; --apparently the anchors are weird on the micro buttons, and need to be adjusted
		--horizontal layout
		SpellbookMicroButton:SetPoint("LEFT", CharacterMicroButton, "RIGHT", space, 0);
		TalentMicroButton:SetPoint("LEFT", SpellbookMicroButton, "RIGHT", space, 0);
		QuestLogMicroButton:SetPoint("LEFT", TalentMicroButton, "RIGHT", space, 0);
		SocialsMicroButton:SetPoint("LEFT", QuestLogMicroButton, "RIGHT", space, 0);
		WorldMapMicroButton:SetPoint("LEFT", SocialsMicroButton, "RIGHT", space, 0);
		MainMenuMicroButton:SetPoint("LEFT", WorldMapMicroButton, "RIGHT", space, 0);
		HelpMicroButton:SetPoint("LEFT", MainMenuMicroButton, "RIGHT", space, 0);
		
		bar:SetHeight(39);
		bar:SetWidth(14 + (24 + actSpace) * 8 - actSpace);
	else
		--vertical layout
		space = space - 24; --apparently the anchors are weird on the micro buttons, and need to be adjusted
		
		SpellbookMicroButton:SetPoint("TOP", CharacterMicroButton, "BOTTOM", 0, -space);
		TalentMicroButton:SetPoint("TOP", SpellbookMicroButton, "BOTTOM", 0, -space);
		QuestLogMicroButton:SetPoint("TOP", TalentMicroButton, "BOTTOM", 0, -space);
		SocialsMicroButton:SetPoint("TOP", QuestLogMicroButton, "BOTTOM", 0, -space);
		WorldMapMicroButton:SetPoint("TOP", SocialsMicroButton, "BOTTOM", 0, -space);
		MainMenuMicroButton:SetPoint("TOP", WorldMapMicroButton, "BOTTOM", 0, -space);
		HelpMicroButton:SetPoint("TOP", MainMenuMicroButton, "BOTTOM", 0, -space);
		
		bar:SetHeight(12 + (33 + actSpace) * 8 - actSpace);
		bar:SetWidth(28);
	end
end

--[[ Overrides ]]--

--Prevents the talent button from always showing up even when the bar is hidden
UpdateTalentButton = function()
	if UnitLevel("player") < 10 then
		TalentMicroButton:Hide();
	elseif BMenuBar and BMenuBar.sets.vis then
		TalentMicroButton:Show();
	end
end

--[[ Rightclick Menu Functions ]]--
local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu");
	menu:SetText("Menu Bar");
	menu:SetWidth(220);
	menu:SetHeight(220);
	
	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate");

	local verticalButton = CreateFrame("CheckButton", name .. "Vertical", menu, "BongosCheckButtonTemplate");
	verticalButton:SetScript("OnClick", function()
		if this:GetChecked() then
			Layout(BMenuBar, 5, BMenuBar.sets.space);
		else
			Layout(BMenuBar, nil, BMenuBar.sets.space);
		end
	end);
	verticalButton:SetPoint("TOP", hideButton, "BOTTOM", 0, 4);
	verticalButton:SetText("Vertical");
	
	local spacingSlider = CreateFrame("Slider", name .. "Spacing", menu, "BongosSpaceSlider");
	spacingSlider:SetPoint("TOPLEFT", name .. "Vertical", "BOTTOMLEFT", 2, -10);
	spacingSlider:SetScript("OnValueChanged", function()
		if(not this:GetParent().onShow) then
			Layout(BMenuBar, BMenuBar.sets.rows, this:GetValue() );
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
	if(not BongosMenuBarMenu) then
		CreateConfigMenu("BongosMenuBarMenu");
	end
	
	BongosMenuBarMenu.onShow = 1;
	BongosMenuBarMenu.frame = bar;	
	
	BongosMenuBarMenuHide:SetChecked(not bar.sets.vis);
	BongosMenuBarMenuVertical:SetChecked(bar.sets.rows);
	BongosMenuBarMenuSpacing:SetValue(bar.sets.space or DEFAULT_SPACING);
	BongosMenuBarMenuScale:SetValue(bar:GetScale() * 100);
	BongosMenuBarMenuOpacity:SetValue(bar:GetAlpha() * 100);
	
	BMenu.ShowMenuForBar(BongosMenuBarMenu, bar);
	BongosMenuBarMenu.onShow = nil;
end

--[[ Startup ]]--

local function AddFrameToBar(frame, bar)
	frame:SetParent(bar);
	frame:SetFrameLevel(0);
	frame:SetAlpha(bar:GetAlpha());
end

BScript.AddStartupAction(function()
	local bar = BBar.Create("menu", "BMenuBar", "BActionSets.menu", ShowMenu);
	if not bar:IsUserPlaced() then
		bar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -224, 0);
	end
	
	AddFrameToBar(CharacterMicroButton, bar);
	AddFrameToBar(SpellbookMicroButton, bar);
	AddFrameToBar(TalentMicroButton, bar);
	AddFrameToBar(QuestLogMicroButton, bar);
	AddFrameToBar(SocialsMicroButton, bar);
	AddFrameToBar(WorldMapMicroButton, bar);
	AddFrameToBar(MainMenuMicroButton, bar);
	AddFrameToBar(HelpMicroButton, bar);
	
	CharacterMicroButton:ClearAllPoints();
	CharacterMicroButton:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 20);
	
	Layout(bar, bar.sets.rows, bar.sets.space);
	
	if bar:IsShown() then
		bar:Hide();
		bar:Show();
	end
end)
--[[
	Bongos MapBar
		Makes the minimap frame movable
--]]

function BongosMinimapScrollFrame_OnMouseWheel()
	if (Minimap:GetZoom() + arg1 <= Minimap:GetZoomLevels()) and (Minimap:GetZoom() + arg1 >= 0) then
		Minimap:SetZoom(Minimap:GetZoom() + arg1);
	end
end

--[[ Config Functions ]]--
local function ToggleTitle(enable)
	if enable then
		BMapBarSets.showTitle = 1;
		MinimapZoneTextButton:Show();
		MinimapToggleButton:Show();
		MinimapBorderTop:Show();
		BMapBar:SetHeight(MinimapCluster:GetHeight());
		
		MinimapCluster:ClearAllPoints();
		MinimapCluster:SetPoint("TOPLEFT", BMapBar, "TOPLEFT", 1, -2);
	else
		BMapBarSets.showTitle = nil;
		BMapBar:SetHeight(MinimapCluster:GetHeight() - 12);
		
		MinimapZoneTextButton:Hide();
		MinimapToggleButton:Hide();
		MinimapBorderTop:Hide();
		
		MinimapCluster:ClearAllPoints();
		MinimapCluster:SetPoint("TOPLEFT", BMapBar, "TOPLEFT", 1, 10);
	end
end

local function ToggleZoomButtons(enable)
	if enable then
		BMapBarSets.showZoom = 1;
		
		MinimapZoomIn:Show();
		MinimapZoomOut:Show();
	else
		BMapBarSets.showZoom = nil;
		
		MinimapZoomIn:Hide();
		MinimapZoomOut:Hide();
	end
end

local function ToggleDayIndicator(enable)
	if enable then
		BMapBarSets.showDay = 1;	
		GameTimeFrame:Show();
	else
		BMapBarSets.showDay = nil;
		GameTimeFrame:Hide();
	end
end

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu");
	menu:SetWidth(220);
	menu:SetHeight(222);
	menu:SetText("Map Bar");
	
	local showTitleButton = CreateFrame("CheckButton", name .. "ShowTitle", menu, "BongosCheckButtonTemplate");
	showTitleButton:SetScript("OnClick", function()
		ToggleTitle( this:GetChecked() );
	end);
	showTitleButton:SetPoint("TOPLEFT", menu, "TOPLEFT", 8, -28);
	showTitleButton:SetText("Show Title");
	
	local showZoomButton = CreateFrame("CheckButton", name .. "ShowZoom", menu, "BongosCheckButtonTemplate");
	showZoomButton:SetScript("OnClick", function()
		ToggleZoomButtons( this:GetChecked() );
	end);
	showZoomButton:SetPoint("TOP", showTitleButton, "BOTTOM", 0, 0);
	showZoomButton:SetText("Show Zoom Buttons");
	
	local showDayNight = CreateFrame("CheckButton", name .. "ShowDay", menu, "BongosCheckButtonTemplate");
	showDayNight:SetScript("OnClick", function()
		ToggleDayIndicator( this:GetChecked() );
	end);
	showDayNight:SetPoint("TOP", showZoomButton, "BOTTOM", 0, 0);
	showDayNight:SetText("Show Time Indicator");
	
	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider");
	scaleSlider:SetPoint("TOPLEFT", showDayNight, "BOTTOMLEFT", 2, -16);
	
	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider");
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24);
end

local function ShowMenu(bar)
	if not BongosMapBarMenu then
		CreateConfigMenu("BongosMapBarMenu");
	end
	
	BongosMapBarMenu.onShow = 1;
	BongosMapBarMenu.frame = bar;
	
	BongosMapBarMenuShowTitle:SetChecked(bar.sets.showTitle);
	BongosMapBarMenuShowZoom:SetChecked(bar.sets.showZoom);
	BongosMapBarMenuShowDay:SetChecked(bar.sets.showDay);
	
	BongosMapBarMenuScale:SetValue( bar:GetScale() * 100 );
	BongosMapBarMenuOpacity:SetValue( bar:GetAlpha() * 100 );
	
	--Position menu then show it
	BMenu.ShowMenuForBar(BongosMapBarMenu, bar);
	BongosMapBarMenu.onShow = nil;
end

--[[ Startup ]]--
BScript.AddStartupAction(function()
	--create the mapbar
	local bar = BBar.Create("map", "BMapBar", "BMapBarSets", ShowMenu, 1);
	bar:SetFrameStrata("BACKGROUND");
	bar:SetWidth(MinimapCluster:GetWidth());
	if not bar:IsUserPlaced() then
		bar:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT");
	end
	
	--attach the minimap to the bar
	MinimapCluster:SetParent(bar);
	--hack, this one is to make sure the frame levels of the minimap cluster aren't broken via setparent
	MinimapCluster:SetFrameLevel(0);
	--another hack, should be inherited by its parent
	MinimapCluster:SetAlpha(bar:GetAlpha());
	
	--load settings
	--toggle title actually places the minimap on the bar, and adjusts the bar's height
	ToggleTitle(bar.sets.showTitle);
	ToggleZoomButtons(bar.sets.showZoom);
	ToggleDayIndicator(bar.sets.showDay);
end)

--[[ 
	Compatibility Fixes 
		These functions are for fixing issues with other addons
--]]

--Make titan not take control of the minimap
if IsAddOnLoaded("Titan") then
	local oTitanMovableFrame_CheckTopFrame = TitanMovableFrame_CheckTopFrame;
	TitanMovableFrame_CheckTopFrame = function(frameTop, top, frameName)
		if frameName ~= "MinimapCluster" then
			oTitanMovableFrame_CheckTopFrame(frameTop, top, frameName)
		end
	end
	TitanMovableData["MinimapCluster"] = nil;
end
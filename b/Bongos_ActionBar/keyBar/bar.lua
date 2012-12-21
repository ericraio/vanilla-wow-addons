--[[
	BKeyBar
		Makes the keyring button movable

	Saved Variables:
		Bongos.keys = {
			<All variables from BBar>
			space
				The spacing between action buttons, in pixels.  A nil value means that the bar is using default spacing
			rows
				How many rows the bar is organized into.
		}
--]]

--[[ Rightclick Menu Functions ]]--

local function CreateConfigMenu(name)
	local menu = CreateFrame("Button", name, UIParent, "BongosRightClickMenu");
	menu:SetText("Key Bar");
	menu:SetWidth(220);
	menu:SetHeight(152);
	
	local hideButton = CreateFrame("CheckButton", name .. "Hide", menu, "BongosHideButtonTemplate");

	local scaleSlider = CreateFrame("Slider", name .. "Scale", menu, "BongosScaleSlider");
	scaleSlider:SetPoint("TOPLEFT", hideButton, "BOTTOMLEFT", 2, -10);
	
	local opacitySlider = CreateFrame("Slider", name .. "Opacity", menu, "BongosOpacitySlider");
	opacitySlider:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -24);
end

--Called when the right click menu is shown, loads the correct values to the checkbuttons/sliders/text
local function  ShowMenu(bar)
	if not BongosKeyBarMenu then
		CreateConfigMenu("BongosKeyBarMenu");
	end
	
	BongosKeyBarMenu.onShow = 1;
	BongosKeyBarMenu.frame = bar;
	
	BongosKeyBarMenuHide:SetChecked(not bar.sets.vis);
	BongosKeyBarMenuScale:SetValue(bar:GetScale() * 100);
	BongosKeyBarMenuOpacity:SetValue(bar:GetAlpha() * 100);
	
	BMenu.ShowMenuForBar(BongosKeyBarMenu, bar);
	BongosKeyBarMenu.onShow = nil;
end

BScript.AddStartupAction(function()
	local bar = BBar.Create("key", "BKeyBar", "BActionSets.key", ShowMenu);
	bar:SetWidth(19);
	bar:SetHeight(37);
	if not bar:IsUserPlaced() then
		bar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -210, 0);
	end

	KeyRingButton:ClearAllPoints();
	KeyRingButton:SetPoint("TOPLEFT", bar);
	KeyRingButton:SetParent(bar);
	KeyRingButton:SetAlpha(bar:GetAlpha());
	KeyRingButton:Show();
end)
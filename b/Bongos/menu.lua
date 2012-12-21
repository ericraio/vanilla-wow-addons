--[[
	menu.lua
		Functions for Bongos Right Click Menus
--]]

BMenu = {
	ShowMenuForBar = function(menu, bar)
		local dragButton = getglobal(bar:GetName()  .. "DragButton");
		local ratio = UIParent:GetScale() / dragButton:GetEffectiveScale();
		local x = dragButton:GetLeft();
		local y = dragButton:GetTop();
		
		menu:ClearAllPoints();
		menu:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", x  / ratio, y / ratio);
		menu:Show();
	end,
}
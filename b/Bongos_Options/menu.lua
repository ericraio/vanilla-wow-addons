--[[
	BOptions
		A GUI Options frame for Bongos
--]]

local currentFrameName = "Global";

function BOptions_OnLoad()
	if not IsAddOnLoaded("Bongos_ActionBar") then
		BOptionsMenuActionBar:Hide();
		BOptionsMenuPaging:Hide();
		BOptionsMenuContext:Hide();
		BOptionsMenu:SetHeight(BOptionsMenu:GetHeight() - 66);
		BOptionsMenuProfiles:ClearAllPoints();
		BOptionsMenuProfiles:SetPoint("TOP", BOptionsMenuVisibility, "BOTTOM", 0, -4);
	end
end

function BOptions_OnShow()
	local currentFrame = getglobal("BOptionsPanel" .. currentFrameName);
	if not currentFrame:IsShown() then
		currentFrame:Show()
		getglobal("BOptionsMenu" .. currentFrameName):LockHighlight();
	end
end

function BOptions_SwitchTab(newFrameName)
	if newFrameName ~= currentFrameName and getglobal("BOptionsPanel" .. newFrameName) then
		this:LockHighlight();
		getglobal("BOptionsMenu" .. currentFrameName):UnlockHighlight();
		getglobal("BOptionsPanel" .. currentFrameName):Hide();
		getglobal("BOptionsPanel" .. newFrameName):Show();
		currentFrameName = newFrameName;
	end
end
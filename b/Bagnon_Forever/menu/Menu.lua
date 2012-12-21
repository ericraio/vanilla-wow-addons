--[[
	Bagnon_Menu
		Functions for the dropdown menu for Bagnon_Forever

	Essentially the dropdown is used to switch between the inventory of other characters
	Why not use a normal dropdown?  It takes a lot of memory
--]]

--[[ Dropdown Menus --]]--

--create a player button, which is used to switch between characters
local function CreatePlayerButton(id, parent)
	local button = CreateFrame("CheckButton", parent:GetName() .. id, parent, "BagnonForeverMenuNameBox");
	if(id == 1) then
		button:SetPoint("TOPLEFT", getglobal(parent:GetName() .. "Text"), "BOTTOMLEFT", -24, 2);
	else
		button:SetPoint("TOP", getglobal(parent:GetName() .. (id - 1) ), "BOTTOM", 0, 6);
	end
	return button;
end

function BagnonForeverMenu_Show(frame)
	BagnonForeverMenu.frame = frame;
	
	--update button info
	local button, player;
	local index = 0;
		
	for player in BagnonDB[GetRealmName()] do
		index = index + 1;

		button = getglobal("BagnonForeverMenu" .. index) or CreatePlayerButton(index, BagnonForeverMenu);
		button:SetText(player);

		if(frame.player == player) then
			button:SetChecked(true);
			button:Show();
		else
			button:SetChecked(false);
		end
	end
		
	local i = index + 1;
	while getglobal("BagnonForeverMenu" .. i) do
		getglobal("BagnonForeverMenu" .. i):Hide();
		i = i + 1;
	end
		
	--resize and position the frame
	BagnonForeverMenu:SetHeight(38 + index * 20);
	local x, y = GetCursorPosition();
	x = x / UIParent:GetScale();
	y = y / UIParent:GetScale();

	BagnonForeverMenu:ClearAllPoints();
	BagnonForeverMenu:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 32, y + 32);
	BagnonForeverMenu:Show();
end
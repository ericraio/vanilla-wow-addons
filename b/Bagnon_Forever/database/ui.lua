--[[
	BagnonDBUI
		Functions for the dropdown menu for showing cached data
		No alterations if this code should be needed to make it work with other databases
	
	Essentially the dropdown is used to switch between the inventory of other characters
	Why not use a normal dropdown?  It takes a lot of memory
--]]

local minWidth = 120;

--switch to view a different character's data
function BagnonDBUI_ChangePlayer(frame, player)
	frame.player = player;
	
	--update the frame's title
	getglobal(frame:GetName() .. "Title"):SetText(string.format(frame.title, player));
	
	--update the frame's contents
	BagnonFrame_Generate(frame);
	
	--update the frame's bags, if they exist and are shown
	local bagFrame = getglobal(frame:GetName() .. "Bags");
	if bagFrame and bagFrame:IsShown() then
		for i = 1, 10 do
			BagnonBag_UpdateTexture(frame, i);
		end
	end
	
	--update banknon's purchase button
	if frame == Banknon then
		Banknon_UpdatePurchaseButtonVis();
	end
end

--[[ Character List ]]--

--create a player button, which is used to switch between characters
local function CreatePlayerButton(id, parent)
	local button = CreateFrame("CheckButton", parent:GetName() .. id, parent, "BagnonDBUINameBox");
	if id == 1 then
		button:SetPoint("TOPLEFT", parent, "TOPLEFT", 6, -4);
	else
		button:SetPoint("TOP", getglobal(parent:GetName() .. (id - 1) ), "BOTTOM", 0, 6);
	end
	return button;
end

function BagnonDBUI_ShowCharacterList(parentFrame)
	BagnonDBUICharacterList.frame = parentFrame;
	
	local width = 0;
	
	--update button info
	local index = 0;		
	for player in BagnonDB.GetPlayers() do
		index = index + 1;
		
		local button = getglobal("BagnonDBUICharacterList" .. index) or CreatePlayerButton(index, BagnonDBUICharacterList);
		button:SetText(player);
		if button:GetTextWidth() + 40 > width then
			width = button:GetTextWidth() + 40;
		end

		if parentFrame.player == player then
			button:SetChecked(true);
			button:Show();
		else
			button:SetChecked(false);
		end
	end
		
	local i = index + 1;
	while getglobal("BagnonDBUICharacterList" .. i) do
		getglobal("BagnonDBUICharacterList" .. i):Hide();
		i = i + 1;
	end
		
	--resize and position the frame
	BagnonDBUICharacterList:SetHeight(12 + index * 19);
	BagnonDBUICharacterList:SetWidth(width);
	BagnonDBUICharacterList:ClearAllPoints();
	BagnonDBUICharacterList:SetPoint("TOPLEFT", parentFrame:GetName() .. "DropDown", "BOTTOMLEFT", 0, 4);
	BagnonDBUICharacterList:Show();
end

--[[ Function Hooks and Overrides ]]--

--hide any menus attached to the frame, if they're visible and we're hiding the frame
local oBagnonFrame_OnHide = BagnonFrame_OnHide;
BagnonFrame_OnHide = function()
	oBagnonFrame_OnHide()
	
	if BagnonDBUICharacterList.frame == this then
		BagnonDBUICharacterList:Hide()
	end
end
--[[
	visibility.lua
		Scripts for the Visibility panel of the Bongos Options menu
--]]

local list;

local function sortList(bar1, bar2)
	if tonumber(bar1.id) and tonumber(bar2.id) then
		return bar1.id < bar2.id;
	elseif not(tonumber(bar1.id) or tonumber(bar2.id)) then
		return bar1.id < bar2.id;
	elseif tonumber(bar1.id) then
		return false;
	end
	return true;
end

function BOptionsVisibility_OnMousewheel(scrollframe, direction)
	local scrollbar = getglobal(scrollframe:GetName() .. "ScrollBar");
	scrollbar:SetValue(scrollbar:GetValue() - direction * (scrollbar:GetHeight() / 2));
	BOptionsVisibilityScrollBar_Update()
end

function BOptionsVisibility_OnLoad()
	local name = this:GetName()
	
	local allButton = CreateFrame("CheckButton", name .. "All", this, "BOptionsShowButton");
	allButton:SetPoint("TOPLEFT", this, "TOPLEFT", 4, 4);
	allButton:SetText("all");
	allButton:SetScript("OnClick", function()
		if this:GetChecked() then
			BBar.ForAll(BBar.Show, 1);
		else
			BBar.ForAll(BBar.Hide, 1);
		end
		BOptionsVisibilityScrollBar_Update();
	end)
	allButton:SetChecked(true);
	
	if IsAddOnLoaded("Dominos_ActionBar") then
		local allActionBars = CreateFrame("CheckButton", name .. "AllActionBars", this, "BOptionsShowButton");
		allActionBars:SetPoint("LEFT", allButton, "RIGHT", 34, 0);
		allActionBars:SetText("actionbars");
		allActionBars:SetScript("OnClick", function()
			if this:GetChecked() then
				for i = 1, BActionBar.GetNumber() do
					BBar.Show(BBar.IDToBar(i), 1);
				end
			else
				for i = 1, BActionBar.GetNumber() do
					BBar.Hide(BBar.IDToBar(i), 1);
				end
			end
			BOptionsVisibilityScrollBar_Update();
		end)
		allActionBars:SetChecked(true)
	end
	
	local firstOfRow;	
	local name = this:GetName();
	for i = 1, 7 do
		local button = CreateFrame("CheckButton", name .. (i-1)*3 + 1, this, "BOptionsShowButton");
		if not firstOfRow then
			button:SetPoint("TOPLEFT", allButton, "BOTTOMLEFT", 0, -8);
		else
			button:SetPoint("TOPLEFT", firstOfRow, "BOTTOMLEFT");
		end
		firstOfRow = button;
		for j = 2, 3 do
			local button = CreateFrame("CheckButton", name .. (i-1)*3 + j, this, "BOptionsShowButton");
			button:SetPoint("LEFT", name .. (i-1)*3 + j-1, "RIGHT", 34, 0);
		end
	end
end

function BOptionsVisibility_OnShow()
	list = BBar.GetAll();	
	for i, bar in pairs(list) do
		if bar.alwaysShow then
			table.remove(list, i)
		end
	end
	table.sort(list, sortList);
	
	BOptionsVisibilityScrollBar_Update();
end

function BOptionsVisibilityScrollBar_Update()
	local size = table.getn(list);
	local offset = BOptionsPanelVisibilityScrollFrame.offset;
	FauxScrollFrame_Update(BOptionsPanelVisibilityScrollFrame, size - 1, 21, 21);
	
	for index = 1, 21 do
		local rIndex = index + offset;
		local button = getglobal("BOptionsPanelVisibility".. index);
		
		if rIndex <= size then
			button:SetText(list[rIndex].id);
			button:SetChecked(list[rIndex].sets.vis);
			button:Show();
		else
			button:Hide();
		end
	end
end
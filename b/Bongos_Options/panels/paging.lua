--[[
	Paging.lua
		Scripts for the Paging panel of the Bongos Options menu
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

function BOptionsPaging_OnMousewheel(scrollframe, direction)
	local scrollbar = getglobal(scrollframe:GetName() .. "ScrollBar");
	scrollbar:SetValue(scrollbar:GetValue() - direction * (scrollbar:GetHeight() / 2));
	BOptionsPagingScrollBar_Update()
end

function BOptionsPaging_OnLoad()
	local name = this:GetName()
	
	local allButton = CreateFrame("CheckButton", name .. "All", this, "BOptionsPagingButton");
	allButton:SetPoint("TOPLEFT", this, "TOPLEFT", 4, 4);
	allButton:SetText("all");
	allButton:SetScript("OnClick", function()
		for i = 1, BActionBar.GetNumber() do
			BActionBar.SetPaging(i, this:GetChecked())
		end
		BOptionsPagingScrollBar_Update();
	end)
	
	local firstOfRow;	
	local name = this:GetName();
	for i = 1, 6 do
		local button = CreateFrame("CheckButton", name .. (i-1)*3 + 1, this, "BOptionsPagingButton");
		if not firstOfRow then
			button:SetPoint("TOPLEFT", allButton, "BOTTOMLEFT");
		else
			button:SetPoint("TOPLEFT", firstOfRow, "BOTTOMLEFT");
		end
		firstOfRow = button;
		for j = 2, 3 do
			local button = CreateFrame("CheckButton", name .. (i-1)*3 + j, this, "BOptionsPagingButton");
			button:SetPoint("LEFT", name .. (i-1)*3 + j-1, "RIGHT", 34, 0);
		end
	end
end

function BOptionsPaging_OnShow()
	this.onShow = 1
	getglobal(this:GetName() .. "Skip"):SetMinMaxValues(0, BActionBar.GetNumber() - 1);
	getglobal(this:GetName() .. "SkipHigh"):SetText(BActionBar.GetNumber() - 1);
	getglobal(this:GetName() .. "Skip"):SetValue(BActionSets.g.skip or 0);
	BOptionsPagingScrollBar_Update();
	this.onShow = nil
end

function BOptionsPagingScrollBar_Update()
	local size = BActionBar.GetNumber();
	local offset = BOptionsPanelPagingScrollFrame.offset;
	FauxScrollFrame_Update(BOptionsPanelPagingScrollFrame, size - 1, 18, 18);
	
	for index = 1, 18 do
		local rIndex = index + offset;
		local button = getglobal("BOptionsPanelPaging".. index);
		
		if rIndex <= size then
			button:SetText(rIndex);
			button:SetChecked(BActionBar.CanPage(rIndex));
			button:Show();
		else
			button:Hide();
		end
	end
end
--[[
	Context.lua
		Scripts for the Context panel of the Bongos Options menu
--]]

function BOptionsContext_OnMousewheel(scrollframe, direction)
	local scrollbar = getglobal(scrollframe:GetName() .. "ScrollBar");
	scrollbar:SetValue(scrollbar:GetValue() - direction * (scrollbar:GetHeight() / 2));
	BOptionsContextScrollBar_Update()
end

function BOptionsContext_OnLoad()
	local name = this:GetName()
	
	local allButton = CreateFrame("CheckButton", name .. "All", this, "BOptionsContextButton");
	allButton:SetPoint("TOPLEFT", this, "TOPLEFT", 4, 4);
	allButton:SetText("all");
	allButton:SetScript("OnClick", function()
		for i = 1, BActionBar.GetNumber() do
			BActionBar.SetContextPaging(i, this:GetChecked())
		end
		BOptionsContextScrollBar_Update();
	end)
	
	local firstOfRow;	
	local name = this:GetName();
	for i = 1, 7 do
		local button = CreateFrame("CheckButton", name .. (i-1)*3 + 1, this, "BOptionsContextButton");
		if not firstOfRow then
			button:SetPoint("TOPLEFT", allButton, "BOTTOMLEFT", 0, -4);
		else
			button:SetPoint("TOPLEFT", firstOfRow, "BOTTOMLEFT");
		end
		firstOfRow = button;
		for j = 2, 3 do
			local button = CreateFrame("CheckButton", name .. (i-1)*3 + j, this, "BOptionsContextButton");
			button:SetPoint("LEFT", name .. (i-1)*3 + j-1, "RIGHT", 34, 0);
		end
	end
end

function BOptionsContextScrollBar_Update()
	local size = BActionBar.GetNumber();
	local offset = BOptionsPanelContextScrollFrame.offset;
	FauxScrollFrame_Update(BOptionsPanelContextScrollFrame, size - 1, 21, 21);
	
	for index = 1, 21 do
		local rIndex = index + offset;
		local button = getglobal("BOptionsPanelContext".. index);
		
		if rIndex <= size then
			button:SetText(rIndex);
			button:SetChecked(BActionBar.CanContextPage(rIndex));
			button:Show();
		else
			button:Hide();
		end
	end
end
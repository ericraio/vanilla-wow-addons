local MIN_DROPDOWN_WIDTH = 120;

--create a player button, which is used to switch between characters
local function CreateButton(id, parent, clickAction)
	local button = CreateFrame("CheckButton", parent:GetName() .. id, parent, "BongosOptionsDropDownItem");
	if id == 1 then
		button:SetPoint("TOPLEFT", parent, "TOPLEFT", 4, -2);
	else
		button:SetPoint("TOP", parent:GetName() .. (id - 1), "BOTTOM", 0, 6);
	end
	button:SetScript("OnClick", function() clickAction(); end);
	return button;
end

local function BarListItem_OnClick()
	getglobal(this:GetParent():GetParent():GetName() .. "BarNameBox"):SetText(this:GetText());
	this:GetParent():Hide();
end

function BOptionsScript_ShowBarList(parent)
	local parentName = parent:GetName();
	local currentBar = getglobal(parent:GetParent():GetName() .. "BarNameBox"):GetText()
	currentBar = tonumber(currentBar) or currentBar;
	
	local index = 0;
	local barList = BongosCustomScripts;
	local maxWidth = MIN_DROPDOWN_WIDTH;
	if barList then
		for barID in barList do
			index = index + 1;

			local button = getglobal(parentName .. index) or CreateButton(index, parent, BarListItem_OnClick);
			button:SetText(barID);
			if 24 + button:GetTextWidth() > maxWidth then
				maxWidth = 32 + button:GetTextWidth();
			end
			if barID == currentBar then
				button:SetChecked(true);
			else
				button:SetChecked(false);
			end
			button:Show();
		end

		local i = index + 1;
		while getglobal(parentName .. i) do
			getglobal(parentName .. i):Hide();
			i = i + 1;
		end

		parent:SetWidth(maxWidth);
		parent:SetHeight(10 + 18 * index);
		parent:Show();
	end
end

local function BarListItem_OnClick()
	getglobal(this:GetParent():GetParent():GetName() .. "EventBox"):SetText(this:GetText());
	local currentBar = getglobal(this:GetParent():GetParent():GetName() .. "BarNameBox"):GetText();
	currentBar = tonumber(currentBar) or currentBar;
	
	local scriptData = BongosCustomScripts[currentBar][this:GetText()]
	if scriptData then	
		getglobal(this:GetParent():GetParent():GetName() .. "ActionBox"):SetText((scriptData.script or ""));
		getglobal(this:GetParent():GetParent():GetName() .. "RunNow"):SetChecked(scriptData.runNow);
	else
		getglobal(this:GetParent():GetParent():GetName() .. "ActionBox"):SetText("");
		getglobal(this:GetParent():GetParent():GetName() .. "RunNow"):SetChecked(false);
	end
	this:GetParent():Hide();
end

function BOptionsScript_ShowEventList(parent)
	local parentName = parent:GetName();
	local currentBar = getglobal(parent:GetParent():GetName() .. "BarNameBox"):GetText();
	local currentEvent = getglobal(parent:GetParent():GetName() .. "EventBox"):GetText();
	local index = 0;
	local maxWidth = MIN_DROPDOWN_WIDTH;
	
	if BongosCustomScripts then
		local eventList = BongosCustomScripts[tonumber(currentBar) or currentBar];
		if eventList then
			for event in eventList do
				index = index + 1;

				local button = getglobal(parentName .. index) or CreateButton(index, parent, BarListItem_OnClick);
				button:SetText(event);
				if 24 + button:GetTextWidth() > maxWidth then
					maxWidth = 32 + button:GetTextWidth();
				end
			
				if event == currentEvent then
					button:SetChecked(true);
				else
					button:SetChecked(false);
				end
				button:Show();
			end

			local i = index + 1;
			while getglobal(parentName .. i) do
				getglobal(parentName .. i):Hide();
				i = i + 1;
			end

			parent:SetWidth(maxWidth);
			parent:SetHeight(10 + 18 * index);
			parent:Show();
		end
	end
end
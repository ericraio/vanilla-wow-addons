--[[
	spot.lua
		Scripts for Bagnon_Spot, which provides filtering functionality for Bagnon
--]]

local nameFilter;

--[[ Search Functions ]]--

function BagnonSpot_Search(text)
	if text and text ~= "" then
		nameFilter = string.lower(text)
	else
		nameFilter = nil
	end
	
	if Bagnon and Bagnon:IsShown() then	
		BagnonFrame_Generate(Bagnon)
	end
	if Banknon and Banknon:IsShown() then	
		BagnonFrame_Generate(Banknon)
	end
end

function BagnonSpot_ClearSearch()
	nameFilter = nil
	
	if Bagnon and Bagnon:IsShown() then	
		BagnonFrame_Generate(Bagnon)
	end
	if Banknon and Banknon:IsShown() then	
		BagnonFrame_Generate(Banknon)
	end
end

--[[ Function Overrides ]]--

BagnonFrame_OnDoubleClick = function(frame)
	if arg1 == "LeftButton" then
		BagnonSpot:Hide()
		BagnonSpot.frame = frame

		BagnonSpot:ClearAllPoints()
		BagnonSpot:SetPoint("TOPLEFT", frame:GetName() .. "Title", "TOPLEFT", -2, 1)
		BagnonSpot:SetPoint("BOTTOMRIGHT", frame:GetName() .. "Title", "BOTTOMRIGHT", 4, -1)
		BagnonSpot:Show()
	end
end

local function ToItemID(hyperLink)
	if hyperLink then
		local _, _, w = string.find(hyperLink, "item:(%d+)")
		return w
	end
end

-- Darkens items we're not searching for
local oBagnonItem_Update = BagnonItem_Update;
BagnonItem_Update = function(item)
	oBagnonItem_Update(item)
	
	if nameFilter then		
		local link;	
		if item.isLink then
			if BagnonDB then
				link = BagnonDB.GetItemData(item:GetParent():GetParent().player, item:GetParent():GetID() , item:GetID())
			end
		else
			link = ToItemID(GetContainerItemLink(item:GetParent():GetID() , item:GetID()))
		end
		
		if link then
			local name = (GetItemInfo(link))		
			if name and not string.find(string.lower(name), nameFilter) then
				item:SetAlpha(item:GetParent():GetParent():GetAlpha()/3)
			else
				item:SetAlpha(item:GetParent():GetParent():GetAlpha())
			end
		end
	else
		item:SetAlpha(item:GetParent():GetParent():GetAlpha())
	end
end

local oBagnonFrame_OnHide = BagnonFrame_OnHide
BagnonFrame_OnHide = function()
	oBagnonFrame_OnHide()
	
	if BagnonSpot:IsVisible() and BagnonSpot.frame == this then
		BagnonSpot:Hide()
	end
end

local oBagnonFrame_OnEnter = BagnonFrame_OnEnter;
BagnonFrame_OnEnter = function()
	oBagnonFrame_OnEnter()
	
	if BagnonSets.showTooltips then
		GameTooltip:AddLine(BAGNON_SPOT_TOOLTIP)
		GameTooltip:Show()
	end
end
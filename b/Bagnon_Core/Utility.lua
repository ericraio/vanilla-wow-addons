--[[
	Utility.lua
		bgn_atBank is a global completely controled by Banknon
--]]

local currentPlayer = UnitName("player");

--[[
	Boolean functions
--]]

function IsAddOnEnabled(addon)
	local _, _, _, enabled = GetAddOnInfo(addon);
	return enabled;
end

function Bagnon_IsInventoryBag(bagID)
	return (bagID >= 0 and bagID < 5);
end

function Bagnon_IsBankBag(bagID)
	return ( bagID == -1 or (bagID > 4 and bagID < 11) );
end

function Bagnon_FrameHasBag(frameName, bagID)
	if(not ( BagnonSets[frameName] and BagnonSets[frameName].bags ) ) then
		return false;
	end
	
	for i in BagnonSets[frameName].bags do
		if(BagnonSets[frameName].bags[i] == bagID) then
			return true;
		end
	end
	return false;
end

--returns if the given bag is an ammo bag/soul bag
function Bagnon_IsAmmoBag(bagID)
	--bank and the main bag are never ammo bags
	if(bagID == 0 or bagID == -1) then
		return nil;
	end
	
	local link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagID) );
	
	if(link) then
		local _, _, id = string.find(link, "item:(%d+)");
		local _, _, _, _, itemType, subType = GetItemInfo(id);

		return ( itemType == BAGNON_ITEMTYPE_QUIVER or subType == BAGNON_SUBTYPE_SOULBAG );
	end
	
	return nil;
end

--returns if the given bag is a profession bag (herb bag, engineering bag, etc)
function Bagnon_IsProfessionBag(bagID)
	if(bagID == 0 or bagID == -1) then
		return nil;
	end

	local link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagID) );

	if(link) then
		local _, _, id = string.find(link, "item:(%d+)");
		local _, _, _, _, itemType, subType = GetItemInfo(id);

		return ( itemType == BAGNON_ITEMTYPE_CONTAINER and not (subType == BAGNON_SUBTYPE_BAG or subType == BAGNON_SUBTYPE_SOULBAG)  );
	end
		
	return nil;
end

--[[
	Detection for Cached Frames
		Only enabled if BagnonForever is enabled
--]]

function Bagnon_IsCachedFrame(frame) 
	if(not BagnonForever) then
		return false;
	end
	
	return ( currentPlayer ~= frame.player or (not bgn_atBank and frame:GetName() == "Banknon") );
end

function Bagnon_IsCachedBag(player, bagID) 
	if(not BagnonForever) then
		return false;
	end
	
	return ( currentPlayer ~= player or (not bgn_atBank and Bagnon_IsBankBag(bagID)) );
end

--returns true if the item is being viewed from a cache 
function Bagnon_IsCachedItem(item)
	if(not BagnonForever) then
		return false;
	end
	--we're not looking at the current player's items
	if( currentPlayer ~= item:GetParent():GetParent().player ) then
		return true;
	end
	
	--the bank frame is visible in the normal way
	if( bgn_atBank ) then
		return false;
	end
	
	--we're looking at the player's bank away from the actual bank
	return ( Bagnon_IsBankBag( item:GetParent():GetID() ) );
end

function Bagnon_AnchorTooltip(frame)
	GameTooltip:ClearAllPoints();
	
	if( frame:GetLeft() < ( UIParent:GetRight() / 2) ) then
		if(frame:GetTop() < (UIParent:GetTop() / 2) ) then
			GameTooltip:SetPoint("BOTTOMLEFT", frame, "TOPLEFT");
		else
			GameTooltip:SetPoint("TOPLEFT", frame, "BOTTOMRIGHT");
		end
	else
		if(frame:GetTop() < (UIParent:GetTop() / 2) ) then
			GameTooltip:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT");
		else
			GameTooltip:SetPoint("TOPRIGHT", frame, "BOTTOMLEFT");
		end
	end
end

--[[
	Messaging
--]]

--send a message to the player
function BagnonMsg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg, 0, 0.7, 1);
end
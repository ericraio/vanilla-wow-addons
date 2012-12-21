--[[
	Utility.lua - functions that don't belong anywhere else
--]]

local currentPlayer = UnitName("player");

--[[ Boolean functions ]]--

function Bagnon_IsAddOnEnabled(addon)
	local _, _, _, enabled = GetAddOnInfo(addon);
	return enabled;
end

function Bagnon_IsInventoryBag(bagID)
	return (bagID == KEYRING_CONTAINER or ( bagID >= 0 and bagID < 5) );
end

function Bagnon_IsBankBag(bagID)
	return ( bagID == -1 or (bagID > 4 and bagID < 11) );
end

function Bagnon_FrameHasBag(frameName, bagID)
	if(not (BagnonSets and BagnonSets[frameName] and BagnonSets[frameName].bags ) ) then
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
function Bagnon_IsAmmoBag(bagID, player)
	--bankslots, main bag, and the keyring have IDs -2 to 0
	if( bagID <= 0 ) then return nil; end
	
	local id;
	if(player) then
		if(BagnonDB) then
			_, id = BagnonDB.GetBagData(player, bagID);
		end
	else
		local link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagID) );
		if(link) then
			_, _, id = string.find(link, "item:(%d+)");
		end
	end
	
	if(id) then
		local _, _, _, _, itemType, subType = GetItemInfo(id);
		return ( itemType == BAGNON_ITEMTYPE_QUIVER or subType == BAGNON_SUBTYPE_SOULBAG );
	end
	
	return nil;
end

--returns if the given bag is a profession bag (herb bag, engineering bag, etc)
function Bagnon_IsProfessionBag(bagID)
	if( bagID <= 0 ) then
		return nil;
	end
	
	local id;
	if(player) then
		if(BagnonDB) then
			_, id = BagnonDB.GetBagData(player, bagID);
		end
	else
		local link = GetInventoryItemLink("player", ContainerIDToInventoryID(bagID) );
		if(link) then
			_, _, id = string.find(link, "item:(%d+)");
		end
	end
	
	if(id) then
		local _, _, _, _, itemType, subType = GetItemInfo(id);
		return ( itemType == BAGNON_ITEMTYPE_CONTAINER and not (subType == BAGNON_SUBTYPE_BAG or subType == BAGNON_SUBTYPE_SOULBAG)  );
	end
		
	return nil;
end

--[[ Detection for Cached Frames.  Only works if we have cached data available ]]--

function Bagnon_IsCachedFrame(frame) 
	if(not BagnonDB) then
		return false;
	end
	
	return ( currentPlayer ~= frame.player or (not bgn_atBank and frame:GetName() == "Banknon") );
end

function Bagnon_IsCachedBag(player, bagID) 
	if(not BagnonDB) then
		return false;
	end
	
	return ( currentPlayer ~= player or (not bgn_atBank and Bagnon_IsBankBag(bagID) ) );
end

--returns true if the item is being viewed from a cache 
function Bagnon_IsCachedItem(item)
	if( not (BagnonDB and item) ) then
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

--[[ Messaging ]]--

--send a message to the player
function BagnonMsg(msg, r, g, b)
	if(r and g and b) then
		DEFAULT_CHAT_FRAME:AddMessage(msg or "error", r, g, b);
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg or "error", 0, 0.7, 1);
	end
end
--[[
	BagnonForeverTooltip
		Adds extra stuff to tooltips based on knowledge from BagnonForever
--]]

--gives a summary of characters who also have this item, and how many of the item they have.
function BagnonForever_AddTooltipInfo(item)
	local character;
	local player = item:GetParent():GetParent().player;
	local link = BagnonDB_GetItemData(item);
				
	for character in BagnonDB[GetRealmName()] do
		if(character ~= player) then
			local countForChar = BagnonForever_GetTotalOfItemForPlayer(character, link);
			if(countForChar > 0) then
				GameTooltip:AddLine(character .. " has " .. countForChar);
			end
		end
	end
	GameTooltip:Show();
end

--gets the total amount of the given item the player has
function BagnonForever_GetTotalOfItemForPlayer(player, itemID)
	local count = 0;
	local bagID;
	itemID = BagnonDB_ToID(itemID);
	for bagID = -1, 10 do
		local size = BagnonDB_GetBagData(player, bagID);
		
		for itemSlot = 0, size do
			local id, _, itemCount = BagnonDB_GetItemDataFromSlot(player, bagID, itemSlot);
			if( id and BagnonDB_ToID(id) == itemID ) then
				count = count + itemCount;
			end
		end
	end
	return count;
end
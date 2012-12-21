--FeedOMatic functions used for non-En clients
--This file's contents are, for the most part, ripped from FeedOMatic

function PF_FOM_IsFood(item)
	--DEFAULT_CHAT_FRAME:AddMessage("item.id "..item.id);
	
	if ( PF_FOM_IsInDiet(item.id) ) then
		--DEFAULT_CHAT_FRAME:AddMessage("IsFood=true");
		return true;
	else
		--DEFAULT_CHAT_FRAME:AddMessage("IsFood=false");
		return false;
	end
	
end

function PF_FOM_IsInDiet(food, dietList)

	if ( dietList == nil ) then
		dietList = {GetPetFoodTypes()};
	end
	if ( dietList == nil ) then
		return false;
	end
	if (type(dietList) ~= "table") then
		dietList = {dietList};
	end
	
	local itemId = PetFeeder_IdFromLink(food)
	for _, diet in dietList do 
		diet = string.lower(diet); -- let's be case insensitive
		
		if (PF_FOM_Foods[diet] ~= nil) then
			if (PF_FOM_Foods[diet] == itemId) then
				return true;
			else
				return false;
			end
		else
			return false;
		end
	end
	
	return false;

end

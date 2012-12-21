------------------------------------------------------------------------------------------
--			Nurfed Item Functions
------------------------------------------------------------------------------------------

if (not Nurfed_Items) then
	Nurfed_Items = {};
	
	function Nurfed_Items:New ()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_Items:linkdecode(link)
		local id;
		local name;
		_, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
		if (id and name) then
			id = id * 1;
			return name, id;
		end
	end

	function Nurfed_Items:getslot(item)
		local bag, size, itemLink, itemName, itemID;
		for bag = 0, 4, 1 do
			if (bag == 0) then
				size = 16;
			else
				size = GetContainerNumSlots(bag);
			end
			if (size and size > 0) then
				for slot = 1, size, 1 do
					itemLink = GetContainerItemLink(bag,slot);
					if (itemLink) then
						itemName, itemID = self:linkdecode(itemLink);
						if (itemName == item or itemID == item) then
							return bag, slot;
						end
					end
				end
			end
		end
		return nil;
	end
end
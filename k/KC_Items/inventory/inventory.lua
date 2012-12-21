local locals = KC_ITEMS_LOCALS.modules.inventory

KC_Inventory = KC_ItemsModule:new({
	type		 = "inventory",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	db			 = AceDatabase:new("KC_InvDB")
})

KC_Items:Register(KC_Inventory)

function KC_Inventory:Enable()
	for bag = 0, 4 do
		self:SaveInv(bag)
	end
	self:RegisterEvent("BAG_UPDATE", "SaveInv")
end

function KC_Inventory:SaveInv(bag)
	if (not tonumber(bag) and not tonumber(arg1)) then
		for bag = 0, 4 do
			self:SaveInv(bag)
		end

		return
	end

	if ((bag or arg1) < 0 or (bag or arg1) > 4) then return end

	local slots = GetContainerNumSlots((bag or arg1)) or 0
	if (slots > 0) then
		if ((bag or arg1) > 0) then
			local link = GetInventoryItemLink("player", (bag or arg1) + 19)
			local code = self.common:GetCode(link)
			local info = code and (code .. "," .. slots) or nil
			self.db:set({ace.char.faction, ace.char.id}, (bag or arg1) .. 0, info)
			self.common:AddCode(link)
		elseif((bag or arg1) == 0) then
			self.db:set({ace.char.faction, ace.char.id}, (bag or arg1) .. 0, "nil,16")
		end

		for item = 1, slots do
			local link = GetContainerItemLink((bag or arg1), item)
			local _, qty = GetContainerItemInfo((bag or arg1), item)
			local code = self.common:GetCode(link, true)
			local info = code and (code .. "," .. qty) or nil
			self.db:set({ace.char.faction, ace.char.id}, (bag or arg1) .. item, info)
			self.common:AddCode(link)
		end
	end

	self:TriggerEvent("KCI_INV_DATA_UPDATE")
end


function KC_Inventory:Count(code, faction, char)
	local count = 0; local stacks = 0;
	for bag = 0, 4 do
		local _, slots = self:BagInfo(bag, faction, char)
		for item = 1, (tonumber(slots) or 0) do
			local id, qty = self:SlotInfo(bag, item, faction, char)
			local match = (code == id) or (self.common:GetCode(id) == code) or (self.common:GetCode(code) == id)
			if (match) then count = count + qty; stacks = stacks + 1; end
		end
	end
	return count, stacks
end

function KC_Inventory:SlotInfo(bag, slot, faction, char)
	local info = self.db:get({faction or ace.char.faction, char or ace.char.id}, bag .. slot) or ""
	return self.common:Split(info, ",")
end

function KC_Inventory:BagInfo(bag, faction, char)
	local info = self.db:get({faction or ace.char.faction, char or ace.char.id}, bag .. 0) or ""
	return self.common:Split(info, ",")
end
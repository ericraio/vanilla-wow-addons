local locals = KC_ITEMS_LOCALS.modules.bank

KC_Bank = KC_ItemsModule:new({
	type		 = "bank",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	db			 = AceDatabase:new("KC_BankDB")
})

KC_Items:Register(KC_Bank)

function KC_Bank:Enable()
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED"	, "SaveBank")
	self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED"	, "SaveBank")
	self:RegisterEvent("BAG_UPDATE"					, "SaveBank")

	if (not self.db:get({ace.char.faction, ace.char.id}, "-10")) then
		ace:print({1.0,0.0,0.0,UIErrorsFrame,12}, format(locals.msgs.nodata, ace.char.name));
	end
end

function KC_Bank:BANKFRAME_OPENED()
	self.ShouldScan = true
	local bags = {-1, 5, 6, 7, 8, 9, 10}
	for _, bag in bags do
		self:SaveBank(bag)
	end
end

function KC_Bank:BANKFRAME_CLOSED()
	self.ShouldScan = false
end

function KC_Bank:SaveBank(bag)
	
	if (not tonumber(bag) and not tonumber(arg1)) then
		local bags = {-1, 5, 6, 7, 8, 9, 10}
		for _, bag in bags do
			self:SaveBank(bag)
		end
		return
	end

	if (not self.ShouldScan or (tonumber(bag or arg1) > 10 and tonumber(bag or arg1) < 5 and tonumber(bag or arg1) ~= -1)) then return end
	
	local slots  = GetContainerNumSlots(bag or arg1)
	if (slots > 0) then
		if (bag or arg1 > 0) then
			local link = GetInventoryItemLink("player", (bag or arg1) + 59)
			local code = self.common:GetCode(link)
			local info = code and (code .. "," .. slots) or nil
			self.db:set({ace.char.faction, ace.char.id}, (bag or arg1) .. 0, info)
			self.common:AddCode(link)
		elseif ((bag or arg1) == -1) then
			self.db:set({ace.char.faction, ace.char.id}, (bag or arg1) .. 0, "nil,24")
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
	self:TriggerEvent("KCI_BANK_DATA_UPDATE")
end

function KC_Bank:Count(code, faction, char)
	local count = 0; local stacks = 0;
	local bags = {-1, 5, 6, 7, 8, 9, 10}
	for _, bag in bags do
		local _, slots = self:BagInfo(bag, faction, char)
		for item = 1, (tonumber(slots) or 0) do
			local id, qty = self:SlotInfo(bag, item, faction, char)
			local match = (code == id) or (self.common:GetCode(id) == code) or (self.common:GetCode(code) == id)
			if (match) then count = count + qty; stacks = stacks + 1; end
		end
	end
	return count, stacks
end

function KC_Bank:SlotInfo(bag, slot, faction, char)
	local info = self.db:get({faction or ace.char.faction, char or ace.char.id}, bag .. slot) or ""
	return self.common:Split(info, ",")
end

function KC_Bank:BagInfo(bag, faction, char)
	local info = self.db:get({faction or ace.char.faction, char or ace.char.id}, bag .. 0) or ""
	return self.common:Split(info, ",")
end
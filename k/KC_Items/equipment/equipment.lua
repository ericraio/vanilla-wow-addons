local locals = KC_ITEMS_LOCALS.modules.equipment

KC_Equipment = KC_ItemsModule:new({
	type		 = "equipment",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	db			 = AceDatabase:new("KC_EquipmentDB")
})

KC_Items:Register(KC_Equipment)

function KC_Equipment:Enable()
	self:Save()
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
end

function KC_Equipment:UNIT_INVENTORY_CHANGED()
	if (arg1 == "player") then
		self:Save()
	end
end

function KC_Equipment:Save()
	for slot = 0, 19 do
		local link = GetInventoryItemLink("player",slot)
		if (link) then 
			local code = self.common:GetCode(link,true)
			self.db:set({ace.char.faction, ace.char.id}, slot, code)
		else
			self.db:set({ace.char.faction, ace.char.id}, slot, nil)
		end
	end
	self.db:set({ace.char.faction, ace.char.id}, "relic", UnitHasRelicSlot("player"))
end

function KC_Equipment:HasRelic(faction, char)
	return self.db:get({faction, char}, "relic")
end

function KC_Equipment:SlotInfo(faction, char, slot)
	return self.db:get({faction, char}, slot)
end
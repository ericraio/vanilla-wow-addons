local locals = KC_ITEMS_LOCALS.modules.iteminfo

KC_ItemInfo = KC_ItemsModule:new({
	type		 = "iteminfo",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common", "tooltip"},
	dataPath	 = {"iteminfo"},
	optPath		 = {"iteminfo", "options"},
})

KC_Items:Register(KC_ItemInfo)

function KC_ItemInfo:Enable()
	self.app.tooltip:RegisterFunc(self, "Tooltip")
end

function KC_ItemInfo:Disable()
	KC_ItemsModule.Disable(self)
	if (self.app.tooltip) then
		self.app.tooltip:UnregisterFunc(self, "Tooltip")
	end
end

function KC_ItemInfo:Tooltip(tooltip, code, lcode, qty, hooker)
	hooker:AddTextLine(tooltip, format(locals.maxstack, self.common:GetItemInfo(code).maxstack or 1))
end
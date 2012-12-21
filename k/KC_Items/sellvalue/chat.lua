local locals = KC_ITEMS_LOCALS.modules.sellvalue
local map = KC_ITEMS_LOCALS.maps.enabled

function KC_SellValue:short()
	local status = self:TogOpt(self.optPath, "short");
	self:Result(locals.msg.short, status, map);
end
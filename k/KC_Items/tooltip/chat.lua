local locals = KC_ITEMS_LOCALS.modules.tooltip
local map = KC_ITEMS_LOCALS.maps.enabled

function KC_Tooltip:modeswitch()
	local status = self:TogOpt(self.optPath, "separated")
	self:Result(locals.msg.separated, status, map)
end

function KC_Tooltip:separatortog()
	local status = self:TogOpt(self.optPath, "separator")
	self:Result(locals.msg.separator, status, map)
end

function KC_Tooltip:splitline()
	local status = self:TogOpt(self.optPath, "splitline")
	self:Result(locals.msg.splitting, status, map)
end

function KC_Tooltip:moneyframe()
	local status = self:TogOpt(self.optPath, "moneyframe")
	self:Result(locals.msg.moneyframe, status, map)
end


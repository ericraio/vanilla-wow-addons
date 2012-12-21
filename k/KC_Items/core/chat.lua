local locals = KC_ITEMS_LOCALS
local map = locals.maps.onOff

function KC_Items:ShowStatsFrame()
	local status = self:TogOpt(self.optPath, "showstatsframe")

	if (status) then
		self.common.frame:Show()
	else
		self.common.frame:Hide()
	end

	self:Result(locals.msg.statsframe, status, map)
end
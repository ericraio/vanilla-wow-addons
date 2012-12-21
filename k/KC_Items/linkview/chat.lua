local locals = KC_ITEMS_LOCALS.modules.linkview
local map = KC_ITEMS_LOCALS.maps.enabled

function KC_Linkview:show()
	self.gui:Show();
end

function KC_Linkview:side()
	local side = (self:GetOpt(self.optPath, "side") == "right") and "left" or "right"
	
	self:SetOpt(self.optPath,"side", side)

	self:Result(locals.msg.tooltip, side);
end
local locals = KC_ITEMS_LOCALS.modules.auction
local map = KC_ITEMS_LOCALS.maps.enabled

function KC_Auction:short()
	local status = self:TogOpt(self.optPath, "short");
	self:Result(locals.msg.short, status, map);
end

function KC_Auction:single()
	local status = self:TogOpt(self.optPath, "single");
	self:Result(locals.msg.single, status, map);
end

function KC_Auction:showbid()
	local status = self:TogOpt(self.optPath, "showbid");
	self:Result(locals.msg.bid, status, map);
end

function KC_Auction:showstats()
	local status = self:TogOpt(self.optPath, "showstats");
	self:Result(locals.msg.stats, status, map);
end
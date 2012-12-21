local locals = KC_ITEMS_LOCALS.modules.common

function KC_Common:RebuildStats()
	local itemCount, subCount, sellCount, buyCount;
	for index, value in KC_ItemsDB do
		if (type(value) ~= "table" and index ~= "stats" and index ~= "v" and index ~= "profiles") then
			local subs, sell, buy = self:Explode(value, ",")
			
			if (type(sell) ~= "number" or type(buy) ~= "number") then self.app.optimizer:UpgradeDB() return end
			
			itemCount = (itemCount or 0) + 1
			subCount = (subCount or 0) + self:CharCount(value, "!") - 1
			sellCount = (sell > 0) and ((sellCount or 0) + 1) or (sellCount or 0)
			buyCount = (buy > 0) and ((buyCount or 0) + 1) or (buyCount or 0)
		end
	end

	if (not sellCount) then
		self.app.db:set("stats", format("%d,%d,%d,%d,%.2f,%.2f", 0, 0, 0, 0, 0, 0))
	else
		self.app.db:set("stats", format("%d,%d,%d,%d,%.2f,%.2f", itemCount, subCount, sellCount, buyCount, sellCount/itemCount * 100, buyCount/itemCount * 100))
	end

	if (self.frame) then
		self.frame:RefreshStats()
	end
end

function KC_Common:UpdateStats(itemCount, subCount, sellCount, buyCount)
	local sItemCount, sSubCount, sSellCount, sBuyCount, sSellPercent, sBuyPercent = self:Explode(self.app.db:get("stats"), ",")
	if (not sItemCount) then
		self.app.db:set("stats", format("%d,%d,%d,%d,%.2f,%.2f", itemCount or 0, subCount or 0, sellCount or 0, buyCount or 0, sellCount or 0 / itemCount, buyCount or 0 / itemCount))
	else
		self.app.db:set("stats", format("%d,%d,%d,%d,%.2f,%.2f", sItemCount + (itemCount or 0), sSubCount + (subCount or 0), sSellCount + (sellCount or 0), sBuyCount + (buyCount or 0), (sSellCount + (sellCount or 0))/(sItemCount + (itemCount or 0)) * 100, (sBuyCount + (buyCount or 0))/(sItemCount + (itemCount or 0)) * 100))
	end
	if (self.frame) then
		self.frame:RefreshStats()
	end
end
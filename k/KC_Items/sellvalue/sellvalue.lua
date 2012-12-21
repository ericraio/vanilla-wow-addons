local locals = KC_ITEMS_LOCALS.modules.sellvalue

KC_SellValue = KC_ItemsModule:new({
	type		 = "sellvalue",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	optPath		 = {"sellvalue", "options"},
})

KC_Items:Register(KC_SellValue)

function KC_SellValue:Enable()
	self:RegisterEvent("MERCHANT_SHOW", "MerchantOpen")
	if (self.app.tooltip) then
		self.app.tooltip:RegisterFunc(self, "Tooltip")
	end
end

function KC_SellValue:Disable()
	KC_ItemsModule.Disable(self)
	if (self.app.tooltip) then
		self.app.tooltip:UnregisterFunc(self, "Tooltip")
	end
end

function KC_SellValue:MerchantOpen()
	self:GetSellPrices();
	self:GetBuyPrices();
end

function KC_SellValue:GetSellPrices()
	self:Hook("SetTooltipMoney")
	self._itemPrice = nil

	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			GameTooltip:SetBagItem(bag, slot)
			if(self._itemPrice) then
				local _, qty = GetContainerItemInfo(bag, slot)
				self.common:SetItemPrices(GetContainerItemLink(bag, slot), self._itemPrice/qty, nil)
				self._itemPrice = nil
			end
		end
	end
	self:Unhook("SetTooltipMoney")
end

function KC_SellValue:SetTooltipMoney(obj, money)
	self._itemPrice = money
	self:CallHook("SetTooltipMoney", obj, money)
end

function KC_SellValue:GetBuyPrices()
	for item = 1, GetMerchantNumItems() do
		local name, texture, price, qty, numAvailable, isUsable = GetMerchantItemInfo(item);
		self.common:SetItemPrices(GetMerchantItemLink(item), nil, price/qty);
	end
end

function KC_SellValue:Tooltip(tooltip, code, lcode, qty, hooker)
	local sell, buy = self.common:GetItemPrices(code)

	local short = self:GetOpt(self.optPath, "short")
	local single = self:GetOpt(self.optPath, "single")
	
	local sLabel = format(short and locals.labels.sell.short or locals.labels.sell.long, qty, single and qty > 1)
	local bLabel = format(short and locals.labels.buy.short  or locals.labels.buy.long,  qty, single and qty > 1)
	
	_ = (sell and sell > 0) and hooker:AddPriceLine(tooltip, sell * qty, sLabel, locals.sep, locals.sepcolor);
	_ = (buy and buy > 0) and hooker:AddPriceLine(tooltip, buy  * qty, bLabel,  locals.sep, locals.sepcolor);
end
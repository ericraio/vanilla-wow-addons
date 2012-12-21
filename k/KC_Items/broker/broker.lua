local locals = KC_ITEMS_LOCALS.modules.broker

KC_Broker = KC_ItemsModule:new({
	type		 = "broker",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common", "auction"},
	optPath		 = {"Options"},
	db			 = AceDatabase:new("KC_AuctionBrokerDB")
})

KC_Items:Register(KC_Broker)

function KC_Broker:Enable()
	self:RegisterEvent("AUCTION_HOUSE_SHOW")
	-- One Click Auctions
	self:Hook("ContainerFrameItemButton_OnClick", "BagClick")
end

function KC_Broker:Disable()
	KC_ItemsModule.Disable(self)
	if (not AuctionFrame) then return end
	AuctionsItemText:SetText(self.AuctionsItemText or AuctionsItemText:GetText())
	BrowseTitle:SetText(self.BrowseTitle or BrowseTitle:GetText())
end

function KC_Broker:AUCTION_HOUSE_SHOW()
	-- Data Caching
	self.AuctionsItemText = AuctionsItemText:GetText()
	self.BrowseTitle = BrowseTitle:GetText()
	-- Autofill
	_ = self:GetOpt(self.optPath, "autofill") and self:RegisterEvent("NEW_AUCTION_UPDATE", "AutoFill")
	_ = self:GetOpt(self.optPath, "autofill") and self:Hook("StartAuction", "Remember")
	-- Duration Memory
	_ = self:GetOpt(self.optPath, "remduration") and self:Hook("AuctionsRadioButton_OnClick", "UpdateDuration")
	_ = self:GetOpt(self.optPath, "remduration") and AuctionsRadioButton_OnClick(self:GetOpt(self.optPath, "duration"))
	-- Coloration
	if (self.app.auction and self:GetOpt(self.optPath, "ahcolor")) then
		self:Hook("AuctionFrameBrowse_Update")
		self:UpdateGuide()
		BrowseTitle:SetPoint("TOP",35 , -18)
		BrowseTitle:SetText( format("%s  -  %s", self.BrowseTitle, locals.labels.guide))		
	end
	self:UnregisterEvent("AUCTION_HOUSE_SHOW")
end

function KC_Broker:AutoFill()
	local name, texture, qty, quality, canUse, price = GetAuctionSellItemInfo()
	
	if (not name) then return end

	local factionID = self.common:GetRealmFactionID()
	local code		= self.common:GetCodeFromInv(name, true)
	local mode		= self:GetOpt(self.optPath, "fillmode") or locals.modes.mixed
	local cut		= self:GetOpt(self.optPath, "cut") or 1
	local skipmem	= self:GetOpt(self.optPath, "skipmem")
	local min, buy = 0, 0
	local used = locals.modes.none

	if (mode == locals.modes.memory or (mode == locals.modes.mixed and not skipmem)) then
		min, buy = self:GetLastPrices(code, factionID)
		used = locals.modes.memory
	end

	if ((mode == locals.modes.smart or (mode == locals.modes.mixed and min == 0)) and self.app.auction) then
		_, _, min, _, _, _, buy = self.app.auction:GetItemData(code)
		min = min and min * cut or 0
		buy = buy and buy * cut or 0
		used = locals.modes.smart
	end

	if ((mode == locals.modes.vendor or (mode == locals.modes.mixed and min == 0)) and self.app.sellvalue) then
		local vsell = self.common:GetItemPrices(code)
		min = min > 0 and min or vsell * 2.5
		buy = buy > 0 and buy or vsell * 3.5

		min = min < vsell and vsell * 1.1 or min

		min = buy < vsell and vsell * 1.5 or min
		buy = buy < vsell and vsell * 1.8 or buy
		used = locals.modes.vendor
	end

	buy = buy < min and min * 1.1 or buy

	_ = min > 0 and MoneyInputFrame_SetCopper(StartPrice, floor(min * qty))
	_ = buy < 1 and MoneyInputFrame_SetCopper(BuyoutPrice, floor(price * 2.5))
	_ = buy > 0 and	MoneyInputFrame_SetCopper(BuyoutPrice, floor(buy * qty))
	
	AuctionsItemText:SetText(format("%s  -  |cff00ff33Mode: %s", self.AuctionsItemText, used))
end

function KC_Broker:GetLastPrices(code, factionID)
	return self.common:Split(self.db:get({factionID}, code) or "0,0", ",")
end

function KC_Broker:Remember(min, buy, dur)
	local name, _, qty	= GetAuctionSellItemInfo()
	local factionID		= self.common:GetRealmFactionID()
	local code			= self.common:GetCodeFromInv(name, true)

	self.db:set({factionID}, code, format("%s,%s", self.common:Round(min / qty,3), self.common:Round(buy / qty, 3)))

	self.Hooks["StartAuction"].orig(min, buy, dur)
end

function KC_Broker:UpdateDuration(index)
	self:SetOpt(self.optPath, "duration", index)
	self.Hooks["AuctionsRadioButton_OnClick"].orig(index)
end

function KC_Broker:BagClick(button, ignore)
	if (AuctionFrame and AuctionFrame:IsVisible()) then
		if (button == "LeftButton" and IsAltKeyDown()and GetContainerItemLink(this:GetParent():GetID(), this:GetID())) then
			PickupContainerItem(this:GetParent():GetID(), this:GetID())
			ClickAuctionSellItemButton()
			self:AutoFill()
			StartAuction(MoneyInputFrame_GetCopper(StartPrice), MoneyInputFrame_GetCopper(BuyoutPrice), AuctionFrameAuctions.duration)
		elseif (button == "RightButton" and IsControlKeyDown()) then
			local link = GetContainerItemLink(this:GetParent():GetID(),this:GetID())
			if (not link) then return end
			BrowseName:SetText(self.common:GetItemInfo(self.common:GetCode(link))["name"])
			AuctionFrameBrowse_Search();
			BrowseNoResultsText:SetText(BROWSE_NO_RESULTS);		
			BrowseName:ClearFocus();
		elseif (button == "RightButton" and IsAltKeyDown()) then
			self:SmartSplit()
		else
			self.Hooks["ContainerFrameItemButton_OnClick"].orig(button, ignore)
		end
	elseif (button == "RightButton" and IsAltKeyDown()) then
		self:SmartSplit()
	else
		self.Hooks["ContainerFrameItemButton_OnClick"].orig(button, ignore)
	end
end

function KC_Broker:SmartSplit()
	SplitContainerItem(this:GetParent():GetID(), this:GetID(), 1)
	for bag=0,4 do
		for slot=1, GetContainerNumSlots(bag) do
			if (not GetContainerItemLink(bag, slot)) then
				PickupContainerItem(bag, slot)
				return	
			end
		end
	end
end

function KC_Broker:AuctionFrameBrowse_Update()
	self.Hooks["AuctionFrameBrowse_Update"].orig()
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
	
	local knownColor	= {self.common:Explode(self:GetOpt(self.optPath, "knownColor") or ".1!.1!1", "!")}
	local sellColor		= {self.common:Explode(self:GetOpt(self.optPath, "sellColor")  or "1!.5!.8", "!")}
	local buyColor		= {self.common:Explode(self:GetOpt(self.optPath, "buyColor")   or "1!1!0", "!")}
	local minColor		= {self.common:Explode(self:GetOpt(self.optPath, "minColor")   or "0!.8!1", "!")}

	for i=1, NUM_BROWSE_TO_DISPLAY do

		local code = self.common:GetCode(GetAuctionItemLink("list", i+offset), true);
		
		if (not code) then return; end

		local _, _, count, _, _, _, min, _, buy, bid, _, _ = GetAuctionItemInfo("list", i+offset);
		local sSeen, sAvgStack, sMin, sBidcount, sBid, sBuycount, sBuy = self.app.auction:GetItemData(code);
		local sell = self.common:GetItemPrices(code)
		
		local sellPass		= sSeen and buy < (sell * count) and buy > 0
		local buyPass		= sBuy and buy / count < sBuy * .75 and buy > 0
		local minPass		= sMin and min / count < sMin * .75

		--FilterKnown Code
		KCITooltip:SetAuctionItem("list", i+offset);
		local text = format("%s %s %s", getglobal("KCITooltipTextLeft2"):GetText() or "", getglobal("KCITooltipTextLeft3"):GetText() or "", getglobal("KCITooltipTextLeft4"):GetText() or ""); 
		local knownPass = strfind(text, ITEM_SPELL_KNOWN);
		
		if (knownPass) then
			local iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
			iconTexture:SetVertexColor(unpack(knownColor));
		elseif (sellPass) then
			local iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
			iconTexture:SetVertexColor(unpack(sellColor));
		elseif (buyPass) then
			local iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
			iconTexture:SetVertexColor(unpack(buyColor));
		elseif (minPass) then
			local iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
			iconTexture:SetVertexColor(unpack(minColor));
		end
	end
	KCITooltip:Hide()
end

function KC_Broker:UpdateGuide()
	local kc	= {self.common:Explode(self:GetOpt(self.optPath, "knownColor") or ".1!.1!1", "!")}
	local sc	= {self.common:Explode(self:GetOpt(self.optPath, "sellColor")  or "1!.5!.8", "!")}
	local bc	= {self.common:Explode(self:GetOpt(self.optPath, "buyColor")   or "1!1!0", "!")}
	local mc	= {self.common:Explode(self:GetOpt(self.optPath, "minColor")   or "0!.8!1", "!")}

	locals.labels.guide = format(locals.labels.guidebase, self.common:GetHexCode(kc[1], kc[2], kc[3], true), self.common:GetHexCode(sc[1], sc[2], sc[3], true), self.common:GetHexCode(bc[1], bc[2], bc[3], true),self.common:GetHexCode(mc[1], mc[2], mc[3], true))
end
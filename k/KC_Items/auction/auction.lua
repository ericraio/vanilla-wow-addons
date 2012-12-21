local locals = KC_ITEMS_LOCALS.modules.auction

KC_Auction = KC_ItemsModule:new({
	type		 = "auction",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	optPath		 = {"options"},
	db			 = AceDatabase:new("KC_AuctionDB")
	
})

KC_Items:Register(KC_Auction)

function KC_Auction:Enable()
	if (not self:GetOpt({"options"}, "filters") ) then
		self:SetOpt({"options"}, "filters", "1,1,1,1,1,1,1,1,1,1")
	end
	self:RegisterEvent("AUCTION_HOUSE_SHOW")
	self.classes = {GetAuctionItemClasses()}
	if (self.app.tooltip) then
		self.app.tooltip:RegisterFunc(self, "Tooltip")
	end
end

function KC_Auction:Disable()
	KC_ItemsModule.Disable(self)
	if (self.app.tooltip) then
		self.app.tooltip:UnregisterFunc(self, "Tooltip")
	end
end

function KC_Auction:AUCTION_HOUSE_SHOW()
	self.gui.frame:SetParents();
	self.gui.frame:Initialize(self, self.gui.config)	
	self.gui.frame:OnLoad()
	self:UnregisterEvent("AUCTION_HOUSE_SHOW");
end

-- Auction Scanning Code.
function KC_Auction:Scan()
	
	if(not AuctionFrame:IsVisible()) then
		self:ScanCleanup(true)
		self:Msg(locals.auction.cantscan)
		return
	end

	local targets = self:GetOpt({"options"}, "filters")

	BrowseNoResultsText:Show()
	BrowseNoResultsText:SetText("")

	for i=1, NUM_BROWSE_TO_DISPLAY do
		button = getglobal("BrowseButton"..i)
		button:Hide()
	end

	if (strfind(targets, "1")) then
		self.scanning = true
		self.done = false
		self.targets = {}
		
		for i,v in {self.common:Explode(targets, ",")} do
			_ = ((v == 1) and tinsert(self.targets, i))
		end

		for i = 0, 15 do
			local chk = self.gui.frame["FilterChk" .. i]
			chk:Disable()
		end

		self:Hook("CanSendAuctionQuery", function () if (self.Hooks.CanSendAuctionQuery.orig()) then self:NextPage() end end)
		self:Hook("AuctionFrameBrowse_OnEvent", function () end)

 		self:RegisterEvent("AUCTION_ITEM_LIST_UPDATE"	, "AuctionUpdate")
		self:RegisterEvent("AUCTION_HOUSE_CLOSED"		, "ScanCanceled")

	else
		self:ScanCleanup(true)
		BrowseNoResultsText:SetText(locals.auction.notargets)
	end
end

function KC_Auction:NextPage()
	local maxPages
	if (self.page) then
		local numBatchAuctions, totalAuctions = GetNumAuctionItems("list")
		maxPages= floor(totalAuctions / NUM_AUCTION_ITEMS_PER_PAGE)

		if (totalAuctions == 0 or self.done) then
			self:ScanDone()
			return;
		end

		BrowseNoResultsText:SetText(format(locals.auction.scanning, self.page + 1, (maxPages or 0) + 1, self.classes[self.target]))
		
		if (self.page < maxPages) then
			self.page = self.page + 1
		else
			if (getn(self.targets) > 0) then
				self.target = tremove(self.targets, 1)
				self.page = 0
			else
				self.done = true
				self.page = self.page +1
			end
		end
	else
		self.page = 0
		self.target = tremove(self.targets, 1)
		BrowseNoResultsText:SetText(locals.auction.settingup)
	end
	self.needScan = true
	
	QueryAuctionItems("", "", "", nil, self.target, nil, self.page, nil, nil)

end

function KC_Auction:AuctionUpdate()
	if (not self.needScan) then return	end

	for id = 1, GetNumAuctionItems("list") do
		local link = GetAuctionItemLink("list", id)
		local _, _, count, _, _, _, minBid, _, buyoutPrice, bidAmount, _, _ = GetAuctionItemInfo("list", id)
		self:ProcessItem(link, count, minBid, bidAmount, buyoutPrice)
	end

	self.needScan = false
end

function KC_Auction:ScanDone()
		BrowseNoResultsText:SetText(locals.auction.done)
		self:ScanCleanup()
end

function KC_Auction:ScanCanceled()
		BrowseNoResultsText:SetText(locals.auction.canceled)
		self:ScanCleanup()
end

function KC_Auction:ScanCleanup(lite)

	if (not lite) then
		self:Unhook("CanSendAuctionQuery")
		self:Unhook("AuctionFrameBrowse_OnEvent")

		self:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE")
		self:UnregisterEvent("AUCTION_HOUSE_CLOSED")	
	
		self:ProcessSnapshot()
	end

	for i = 0, 15 do
		local chk = self.gui.frame["FilterChk" .. i]
		chk:Enable()
	end

	self.gui.frame.ScanButton:SetValue(locals.labels.scan)

	self.snapshot = (self.snapshot and self.persistent) and self.snapshot or nil

	self.page = nil
	self.needScan = false
	self.target = nil
	self.targets = nil
	self.done = false
	self.scanning = nil
	self.gui.frame.scanning = nil

end

function KC_Auction:ProcessItem(link, count, min, bid, buy)
	local code = self.common:GetCode(link, true);
	
	self.snapshot				= self.snapshot or {}
	self.snapshot[code]			= self.snapshot[code] or {}
	self.snapshot[code].buys	= (buy > 0) and ((self.snapshot[code].buys or "") .. self.common:Round(buy/count,3) .. ",") or self.snapshot[code].buys 
	self.snapshot[code].buycount= (buy > 0) and (self.snapshot[code].buycount or 0) + 1 or self.snapshot[code].buycount
	self.snapshot[code].bids	= (bid > 0) and ((self.snapshot[code].bids or "") .. self.common:Round(bid/count,3) .. ",") or self.snapshot[code].bids 
	self.snapshot[code].bidcount= (bid > 0) and (self.snapshot[code].bidcount or 0) + 1 or self.snapshot[code].bidcount
	self.snapshot[code].mins	= (self.snapshot[code].mins or "") .. self.common:Round(min/count,3) .. "," 
	self.snapshot[code].stacks	= (self.snapshot[code].stacks or "") .. count .. "," 
	self.snapshot[code].seen	= (self.snapshot[code].seen or 0) + 1 
end 

function KC_Auction:ProcessSnapshot()
	if (not self.snapshot) then return end
	
	local realmFactionID = self.common:GetRealmFactionID()
	local nWeight		 = .65
	local sWeight		 = .35

	for item in self.snapshot do
		local sSeen, sAvgStack, sMin, sBidcount, sBid, sBuycount, sBuy = self:GetItemData(item)
		
		local buys   = {self.common:Explode(self.snapshot[item].buys, ",")}
		local bids   = {self.common:Explode(self.snapshot[item].bids, ",")}
		local mins   = {self.common:Explode(self.snapshot[item].mins, ",")}
		local stacks = {self.common:Explode(self.snapshot[item].stacks, ",")}

		buys	= getn(buys) > 0 and buys or nil
		bids	= getn(bids) > 0 and bids or nil
		mins	= getn(mins) > 0 and mins or nil
		stacks	= getn(stacks) > 0 and stacks or nil

		local nMin = mins and self.common:BellCurve(mins) or 0
		local nBid = bids and self.common:BellCurve(bids) or 0
		local nBuy = buys and self.common:BellCurve(buys) or 0

		local nAvgStack = stacks and self.common:Avg(stacks) or 0

		nMin = (sMin and sMin > 0) and self.common:WeightedAvg(nMin, sMin, nWeight, sWeight) or nMin
		nBid = (sBid and sBid > 0) and self.common:WeightedAvg(nBid, sBid, nWeight, sWeight) or nBid
		nBuy = (sMin and sMin > 0) and self.common:WeightedAvg(nBuy, sMin, nWeight, sWeight) or nBuy

		nAvgStack = (sAvgStack and sAvgStack > 0) and self.common:WeightedAvg(nAvgStack, sAvgStack, nWeight, sWeight) or nAvgStack

		local nSeen		=  self.snapshot[item].seen + (sSeen or 0)
		local nBidcount = (self.snapshot[item].bidcount or 0) + (sBidcount or 0)
		local nBuycount = (self.snapshot[item].buycount or 0) + (sBuycount or 0)
	
		self.db:set({realmFactionID}, item, format("%s:%s:%s:%s:%s:%s:%s", nSeen, nAvgStack, nMin, nBidcount, nBid, nBuycount, nBuy))
	end
end

function KC_Auction:GetItemData(code)
	return self.common:Explode(self.db:get({self.common:GetRealmFactionID()}, code) or "0", ":");
end

function KC_Auction:EnablePersistence()
	self.persistent = true;
end

function KC_Auction:Tooltip(tooltip, code, lcode, qty, hooker)
	local sSeen, sAvgStack, sMin, sBidcount, sBid, sBuycount, sBuy = self:GetItemData(lcode)
	
	if (sSeen == 0) then return end

	local short		= self:GetOpt(self.optPath, "short")
	local single	= self:GetOpt(self.optPath, "single")
	local stats		= self:GetOpt(self.optPath, "showstats")
	local showbid	= self:GetOpt(self.optPath, "showbid")
	
	local mLabel = format(short and locals.labels.min.short or locals.labels.min.long, qty)
	local bLabel = format(short and locals.labels.buy.short or locals.labels.buy.long, qty)
	local iLabel = format(short and locals.labels.bid.short or locals.labels.bid.long, qty)
	local hLabel = format(locals.labels.header, qty)
	local sLabel = format(locals.labels.stats,  sSeen, self.common:Round(sAvgStack, 2))

	_ = (not short)						and hooker:AddTextLine( tooltip, hLabel)
	_ = (sMin and sMin > 0)				and hooker:AddPriceLine(tooltip, sMin * qty, mLabel, locals.sep, locals.sepcolor)
	_ = (sBuy and sBuy > 0)				and hooker:AddPriceLine(tooltip, sBuy * qty, bLabel, locals.sep, locals.sepcolor)
	_ = (showbid and tonumber(sBid) and sBid > 0)	and hooker:AddPriceLine(tooltip, sBid * qty, iLabel, locals.sep, locals.sepcolor)
	_ = (stats)							and hooker:AddTextLine( tooltip, sLabel)
end
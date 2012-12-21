--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucScanner.lua 924 2006-07-06 02:01:43Z luke1410 $

	Auctioneer scanning functions
	Functions to handle the auction scan procedure

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]

--Local function prototypes
local processLink, invalidateAHSnapshot, auctionStartHook, finishedAuctionScanHook, auctionEntryHook, startAuction, placeAuctionBid, relevel, configureAH, insertAHTab, auctionFrameFiltersUpdateClasses, rememberPrice, auctionsClear, auctionsSetWarn, auctionsSetLine, newAuction, auctHouseShow, auctHouseClose, auctHouseUpdate, filterButtonSetType, onChangeAuctionDuration, setAuctionDuration

-- Hook into this function if you want notification when we find a link.
function processLink(link)
	if (ItemsMatrix_ProcessLinks ~= nil) then
		ItemsMatrix_ProcessLinks(	link, -- itemlink
											nil,  -- not used atm
											nil,  -- vendorprice - TODO: not calculatable in AH?
											nil	-- event - TODO: donno, maybe only for chatevents?
										)
	end
	if (LootLink_ProcessLinks ~= nil) then
		LootLink_ProcessLinks(	link, -- itemlink
										true  -- TODO: uncertain? - ah is a trustable source?
									);
	end
end


-- This function sets the dirty flag to true for all the auctions in the snapshot
-- This is done to indicate that the snapshot is out of date.
function invalidateAHSnapshot()
	-- Invalidate the snapshot
	local auctKey = Auctioneer.Util.GetAuctionKey();
	if (not AuctionConfig.snap) then
		AuctionConfig.snap = {};
	end
	if (not AuctionConfig.snap[auctKey]) then
		AuctionConfig.snap[auctKey] = {};
	end
	for cat,cData in pairs(AuctionConfig.snap[auctKey]) do
		-- Only invalidate the class group if we will be scanning it.
		if (Auctioneer.Command.GetFilter("scan-class"..cat)) then
			for iKey, iData in pairs(cData) do
				-- The first char is the dirty flag (purposely)
				AuctionConfig.snap[auctKey][cat][iKey] = "1" .. string.sub(iData,2);
			end
		end
	end
end

-- Called when the auction scan starts
function auctionStartHook() --Auctioneer_AuctionStart_Hook
	Auction_DoneItems = {};
	Auctioneer.Core.Variables.SnapshotItemPrices = {};
	invalidateAHSnapshot();

	-- Make sure AuctionConfig.data is initialized
	local serverFaction = Auctioneer.Util.GetAuctionKey();
	if (AuctionConfig.data == nil) then AuctionConfig.data = {}; end
	if (AuctionConfig.data[serverFaction] == nil) then
		AuctionConfig.data[serverFaction] = {};
	end

	-- Reset scan audit counters
	Auctioneer.Core.Variables.TotalAuctionsScannedCount = 0;
	Auctioneer.Core.Variables.NewAuctionsCount = 0;
	Auctioneer.Core.Variables.OldAuctionsCount = 0;
	Auctioneer.Core.Variables.DefunctAuctionsCount = 0;

	-- Protect AuctionFrame if we should
	if (Auctioneer.Command.GetFilterVal('protect-window') == 1) then
		Auctioneer.Util.ProtectAuctionFrame(true);
	end
end

-- This is called when an auction scan finishes and is used for clean up
function finishedAuctionScanHook() --Auctioneer_FinishedAuctionScan_Hook
	-- Only remove defunct auctions from snapshot if there was a good amount of auctions scanned.
	local auctKey = Auctioneer.Util.GetAuctionKey();

	if (not AuctionConfig.sbuy) then AuctionConfig.sbuy = {}; end
	if (not AuctionConfig.sbuy[auctKey]) then AuctionConfig.sbuy[auctKey] = {}; end

	if Auctioneer.Core.Variables.TotalAuctionsScannedCount >= 50 then
		local snap, id, rprop, enchant, sig;

		if (AuctionConfig and AuctionConfig.snap and AuctionConfig.snap[auctKey]) then
			for cat,cData in pairs(AuctionConfig.snap[auctKey]) do
				for iKey, iData in pairs(cData) do
					snap = Auctioneer.Core.GetSnapshotFromData(iData);
					if (snap.dirty == "1") then
						id, rprop, enchant = Auctioneer.Core.GetItemSignature(iKey);

						-- Clear defunct auctions
						if (id and rprop and enchant) then
							sig = id..":"..rprop..":"..enchant;
							AuctionConfig.sbuy[auctKey][sig] = nil;
							Auctioneer.Storage.SetSnapMed(auctKey, sig, nil);
						end
						AuctionConfig.snap[auctKey][cat][iKey] = nil;
						Auctioneer.Core.Variables.DefunctAuctionsCount = Auctioneer.Core.Variables.DefunctAuctionsCount + 1;
					end
				end
			end
		end
	end

	-- Copy the item prices into the Saved item prices table
	if (Auctioneer.Core.Variables.SnapshotItemPrices) then
		for sig, iData in pairs(Auctioneer.Core.Variables.SnapshotItemPrices) do
			AuctionConfig.sbuy[auctKey][sig] = Auctioneer.Core.StoreMedianList(iData.buyoutPrices);
			Auctioneer.Storage.SetSnapMed(auctKey, sig, Auctioneer.Statistic.GetMedian(iData.buyoutPrices));
			Auctioneer.Core.Variables.SnapshotItemPrices[sig] = nil;
		end
	end

	local lDiscrepencyCount = Auctioneer.Core.Variables.TotalAuctionsScannedCount - (Auctioneer.Core.Variables.NewAuctionsCount + Auctioneer.Core.Variables.OldAuctionsCount);

	local totalAuctionsMessage = string.format(_AUCT('AuctionTotalAucts'), Auctioneer.Util.ColorTextWhite(Auctioneer.Core.Variables.TotalAuctionsScannedCount))
	local newAuctionsMessage = string.format(_AUCT('AuctionNewAucts'), Auctioneer.Util.ColorTextWhite(Auctioneer.Core.Variables.NewAuctionsCount))
	local oldAuctionsMessage = string.format(_AUCT('AuctionOldAucts'), Auctioneer.Util.ColorTextWhite(Auctioneer.Core.Variables.OldAuctionsCount))
	local defunctAuctionsMessage = string.format(_AUCT('AuctionDefunctAucts'), Auctioneer.Util.ColorTextWhite(Auctioneer.Core.Variables.DefunctAuctionsCount))
	local discrepanciesMessage

	Auctioneer.Util.ChatPrint(totalAuctionsMessage);
	Auctioneer.Util.ChatPrint(newAuctionsMessage);
	Auctioneer.Util.ChatPrint(oldAuctionsMessage);
	Auctioneer.Util.ChatPrint(defunctAuctionsMessage);

	if (Auctioneer.Util.NullSafe(lDiscrepencyCount) > 0) then
		discrepanciesMessage = string.format(_AUCT('AuctionDiscrepancies'), Auctioneer.Util.ColorTextWhite(lDiscrepencyCount))
		Auctioneer.Util.ChatPrint(discrepanciesMessage);
	end

	--Add the preceding information to the AH frame too
	BrowseNoResultsText:SetText(totalAuctionsMessage.."\n"..newAuctionsMessage.."\n"..oldAuctionsMessage.."\n"..defunctAuctionsMessage.."\n"..(discrepanciesMessage or ""))

	--The followng was added by MentalPower to implement the "/auc finish" command
	local finish = Auctioneer.Command.GetFilterVal('finish');

	if (finish == 1) then
		Logout();

	elseif (finish == 2) then
		Quit();

	elseif (finish == 3) then
		if(ReloadUIHandler) then
			ReloadUIHandler("10");
		else
			ReloadUI();
		end
	end

	--Cleaning up after oneself is always a good idea.
	collectgarbage()
end

-- Called by scanning hook when an auction item is scanned from the Auction house
-- we save the aution item to our tables, increment our counts etc
function auctionEntryHook(funcVars, retVal, page, index, category) --Auctioneer_AuctionEntry_Hook
	EnhTooltip.DebugPrint("Processing page", page, "item", index);
	local auctionDoneKey;
	if (not page or not index or not category) then
		return;
	else
		auctionDoneKey = category.."-"..page.."-"..index;
	end
	if (not Auction_DoneItems[auctionDoneKey]) then
		Auction_DoneItems[auctionDoneKey] = true;
	else
		return;
	end

	Auctioneer.Core.Variables.TotalAuctionsScannedCount = Auctioneer.Core.Variables.TotalAuctionsScannedCount + 1;

	local aiName, aiTexture, aiCount, aiQuality, aiCanUse, aiLevel, aiMinBid, aiMinIncrement, aiBuyoutPrice, aiBidAmount, aiHighBidder, aiOwner = GetAuctionItemInfo("list", index);
	if (aiOwner == nil) then aiOwner = "unknown"; end

	-- do some validation of the auction data that was returned
	if (aiName == nil or tonumber(aiBuyoutPrice) > Auctioneer.Core.Constants.MaxAllowedFormatInt or tonumber(aiMinBid) > Auctioneer.Core.Constants.MaxAllowedFormatInt) then return; end
	if (aiCount < 1) then aiCount = 1; end

	-- get other auctiondata
	local aiTimeLeft = GetAuctionItemTimeLeft("list", index);
	local aiLink = GetAuctionItemLink("list", index);

	-- Call some interested iteminfo addons
	processLink(aiLink);

	local aiItemID, aiRandomProp, aiEnchant, aiUniqID = EnhTooltip.BreakLink(aiLink);
	local aiKey = aiItemID..":"..aiRandomProp..":"..aiEnchant;
	local hyperlink = string.format("item:%d:%d:%d:%d", aiItemID, aiEnchant, aiRandomProp, aiUniqID);

	-- Get all item data
	local iName, iLink, iQuality, iLevel, iClass, iSubClass, iCount, iMaxStack = GetItemInfo(hyperlink);
	local itemCat = Auctioneer.Util.GetCatNumberByName(iClass);

	-- construct the unique auction signature for this aution
	local lAuctionSignature = string.format("%d:%d:%d:%s:%d:%d:%d:%d", aiItemID, aiRandomProp, aiEnchant, Auctioneer.Util.NilSafeString(aiName), Auctioneer.Util.NullSafe(aiCount), Auctioneer.Util.NullSafe(aiMinBid), Auctioneer.Util.NullSafe(aiBuyoutPrice), aiUniqID);

	-- add this item's buyout price to the buyout price history for this item in the snapshot
	if aiBuyoutPrice > 0 then
		local buyoutPriceForOne = Auctioneer.Util.PriceForOne(aiBuyoutPrice, aiCount);
		if (not Auctioneer.Core.Variables.SnapshotItemPrices[aiKey]) then
			Auctioneer.Core.Variables.SnapshotItemPrices[aiKey] = {buyoutPrices={buyoutPriceForOne}, name=aiName};
		else
			table.insert(Auctioneer.Core.Variables.SnapshotItemPrices[aiKey].buyoutPrices, buyoutPriceForOne);
			table.sort(Auctioneer.Core.Variables.SnapshotItemPrices[aiKey].buyoutPrices);
		end
	end


	-- if this auction is not in the snapshot add it
	local auctKey = Auctioneer.Util.GetAuctionKey();
	local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, lAuctionSignature);

	-- If we haven't seen this item (its not in the old snapshot)
	if (not snap) then
		EnhTooltip.DebugPrint("No snap");
		Auctioneer.Core.Variables.NewAuctionsCount = Auctioneer.Core.Variables.NewAuctionsCount + 1;

		-- now build the list of buyout prices seen for this auction to use to get the median
		local newBuyoutPricesList = Auctioneer.BalancedList.NewBalancedList(Auctioneer.Core.Constants.MaxBuyoutHistorySize);

		local auctionPriceItem = Auctioneer.Core.GetAuctionPriceItem(aiKey, auctKey);
		if (not auctionPriceItem) then auctionPriceItem = {} end

		local seenCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = Auctioneer.Core.GetAuctionPrices(auctionPriceItem.data);
		seenCount = seenCount + 1;
		minCount = minCount + 1;
		minPrice = minPrice + Auctioneer.Util.PriceForOne(aiMinBid, aiCount);
		if (Auctioneer.Util.NullSafe(aiBidAmount) > 0) then
			bidCount = bidCount + 1;
			bidPrice = bidPrice + Auctioneer.Util.PriceForOne(aiBidAmount, aiCount);
		end
		if (Auctioneer.Util.NullSafe(aiBuyoutPrice) > 0) then
			buyCount = buyCount + 1;
			buyPrice = buyPrice + Auctioneer.Util.PriceForOne(aiBuyoutPrice, aiCount);
		end
		auctionPriceItem.data = string.format("%d:%d:%d:%d:%d:%d:%d", seenCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice);

		local bph = auctionPriceItem.buyoutPricesHistoryList;
		if (bph and table.getn(bph) > 0) then
			newBuyoutPricesList.setList(bph);
		end
		if (Auctioneer.Util.NullSafe(aiBuyoutPrice) > 0) then
			newBuyoutPricesList.insert(Auctioneer.Util.PriceForOne(aiBuyoutPrice, aiCount));
		end

		auctionPriceItem.buyoutPricesHistoryList = newBuyoutPricesList.getList();
		auctionPriceItem.name = aiName;
		auctionPriceItem.category = itemCat;
		Auctioneer.Core.SaveAuctionPriceItem(auctKey, aiKey, auctionPriceItem);

		-- finaly add the auction to the snapshot
		if (aiOwner == nil) then aiOwner = "unknown"; end
		local initialTimeSeen = time();

		snap = {
			initialSeenTime=initialTimeSeen,
			lastSeenTime=initialTimeSeen,
			itemLink=aiLink,
			quality=Auctioneer.Util.NullSafe(aiQuality),
			level=Auctioneer.Util.NullSafe(aiLevel),
			bidamount=Auctioneer.Util.NullSafe(aiBidAmount),
			highBidder=aiHighBidder,
			owner=aiOwner,
			timeLeft=Auctioneer.Util.NullSafe(aiTimeLeft),
			category=itemCat,
			dirty=0
		};

	else
		EnhTooltip.DebugPrint("Snap!");
		Auctioneer.Core.Variables.OldAuctionsCount = Auctioneer.Core.Variables.OldAuctionsCount + 1;
		--this is an auction that was already in the snapshot from a previous scan and is still in the auction house
		snap.dirty = 0;											--set its dirty flag to false so we know to keep it in the snapshot
		snap.lastSeenTime = time();								--set the time we saw it last
		snap.timeLeft = Auctioneer.Util.NullSafe(aiTimeLeft);	--update the time left
		snap.bidamount = Auctioneer.Util.NullSafe(aiBidAmount);	--update the current bid amount
		snap.highBidder = aiHighBidder;							--update the high bidder
	end

	-- Commit the snapshot back to the table.
	Auctioneer.Core.SaveSnapshot(auctKey, itemCat, lAuctionSignature, snap);
end

-- hook into the auction starting process
function startAuction(funcArgs, retVal, start, buy, duration)
	if (AuctPriceRememberCheck:GetChecked()) then
		Auctioneer.Storage.SetFixedPrice(Auctioneer_CurAuctionItem, start, buy, duration, Auctioneer_CurAuctionCount)
	end
	Auctioneer_CurAuctionItem = nil
	Auctioneer_CurAuctionCount = nil
	AuctPriceRememberCheck:SetChecked(false)
end

-- hook to capture data about an auction that was boughtout
function placeAuctionBid(funcVars, retVal, itemtype, itemindex, bidamount)
	-- get the info for this auction
	local aiLink = GetAuctionItemLink(itemtype, itemindex);
	local aiItemID, aiRandomProp, aiEnchant, aiUniqID = EnhTooltip.BreakLink(aiLink);
	local aiKey = aiItemID..":"..aiRandomProp..":"..aiEnchant;
	local aiName, aiTexture, aiCount, aiQuality, aiCanUse, aiLevel, aiMinBid, aiMinIncrement, aiBuyout, aiBidAmount, aiHighBidder, aiOwner = GetAuctionItemInfo(itemtype, itemindex);

	local auctionSignature = string.format("%d:%d:%d:%s:%d:%d:%d:%d", aiItemID, aiRandomProp, aiEnchant, Auctioneer.Util.NilSafeString(aiName), Auctioneer.Util.NullSafe(aiCount), Auctioneer.Util.NullSafe(aiMinBid), Auctioneer.Util.NullSafe(aiBuyout), aiUniqID);

	local playerName = UnitName("player");
	local eventTime = "e"..time();
	if (not AuctionConfig.bids) then AuctionConfig.bids = {} end
	if (not AuctionConfig.bids[playerName]) then
		AuctionConfig.bids[playerName] = {};
	end

	AuctionConfig.bids[playerName][eventTime] = string.format("%s|%s|%s|%s|%s", auctionSignature, bidamount, 0, aiOwner, aiHighBidder or "unknown");

	if bidamount == aiBuyout then -- only capture buyouts
		local foundInSnapshot = false

		-- remove from snapshot
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActRemove'), auctionSignature));
		local auctKey = Auctioneer.Util.GetAuctionKey();
		local itemCat = Auctioneer.Util.GetCatForKey(aiKey);
		if (itemCat and AuctionConfig and AuctionConfig.snap and AuctionConfig.snap[auctKey] and AuctionConfig.snap[auctKey][itemCat]) then
			if (AuctionConfig.snap[auctKey][itemCat][auctionSignature]) then
				foundInSnapshot = true;
				AuctionConfig.snap[auctKey][itemCat][auctionSignature] = nil;
			end
		end
		if (not AuctionConfig.bids) then AuctionConfig.bids = {} end
		if (not AuctionConfig.bids[playerName]) then AuctionConfig.bids[playerName] = {} end
		AuctionConfig.bids[playerName][eventTime] = string.format("%s|%s|%s|%s|%s", auctionSignature, bidamount, 1, aiOwner, aiHighBidder or "unknown");

		if (foundInSnapshot) then
			if (Auctioneer_HSPCache and Auctioneer_HSPCache[auctKey]) then
				Auctioneer_HSPCache[auctKey][aiKey] = nil;
			end
			Auctioneer_Lowests = nil;

			-- Remove from snapshot buyout list
			local sbuy = Auctioneer.Core.GetSnapshotInfo(auctKey, aiKey)
			if sbuy then
				local price = Auctioneer.Util.PriceForOne(aiBuyout, aiCount);
				-- Find price in buyout list
				local found = table.foreachi(sbuy.buyoutPrices, function(k, v) if tonumber(v) == price then return k end end)
				if found then
					table.remove(sbuy.buyoutPrices, found)
					Auctioneer.Core.SaveSnapshotInfo(auctKey, aiKey, sbuy)
				end
			end
		end
	end
end

function relevel(frame) --Local
	local myLevel = frame:GetFrameLevel() + 1
	local children = { frame:GetChildren() }
	for _,child in pairs(children) do
		child:SetFrameLevel(myLevel)
		relevel(child)
	end
end

local lAHConfigPending = true
function configureAH()
	if (lAHConfigPending and IsAddOnLoaded("Blizzard_AuctionUI")) then
		EnhTooltip.DebugPrint("Configuring AuctionUI");
		AuctionsPriceText:ClearAllPoints();
		AuctionsPriceText:SetPoint("TOPLEFT", "AuctionsItemText", "TOPLEFT", 0, -53);
		AuctionsBuyoutText:ClearAllPoints();
		AuctionsBuyoutText:SetPoint("TOPLEFT", "AuctionsPriceText", "TOPLEFT", 0, -33);
		AuctionsBuyoutErrorText:ClearAllPoints();
		AuctionsBuyoutErrorText:SetPoint("TOPLEFT", "AuctionsBuyoutText", "TOPLEFT", 0, -29);
		AuctionsDurationText:ClearAllPoints();
		AuctionsDurationText:SetPoint("TOPLEFT", "AuctionsBuyoutErrorText", "TOPLEFT", 0, -7);
		AuctionsDepositText:ClearAllPoints();
		AuctionsDepositText:SetPoint("TOPLEFT", "AuctionsDurationText", "TOPLEFT", 0, -31);
		if (AuctionInfo ~= nil) then
			AuctionInfo:ClearAllPoints();
			AuctionInfo:SetPoint("TOPLEFT", "AuctionsDepositText", "TOPLEFT", -4, -33);
		end

		AuctionsShortAuctionButtonText:SetText("2");
		AuctionsMediumAuctionButton:SetPoint("TOPLEFT", "AuctionsDurationText", "BOTTOMLEFT", 3, 1);
		AuctionsMediumAuctionButtonText:SetText("8");
		AuctionsMediumAuctionButton:ClearAllPoints();
		AuctionsMediumAuctionButton:SetPoint("BOTTOMLEFT", "AuctionsShortAuctionButton", "BOTTOMRIGHT", 20,0);
		AuctionsLongAuctionButtonText:SetText("24 "..HOURS);
		AuctionsLongAuctionButton:ClearAllPoints();
		AuctionsLongAuctionButton:SetPoint("BOTTOMLEFT", "AuctionsMediumAuctionButton", "BOTTOMRIGHT", 20,0);

		-- set UI-texts
		BrowseScanButton:SetText(_AUCT('TextScan'));
		BrowseScanButton:SetParent("AuctionFrameBrowse");
		BrowseScanButton:SetPoint("LEFT", "AuctionFrameMoneyFrame", "RIGHT", 5,0);
		BrowseScanButton:Show();

		if (AuctionInfo) then
			AuctionInfo:SetParent("AuctionFrameAuctions")
			AuctionInfo:SetPoint("TOPLEFT", "AuctionsDepositText", "TOPLEFT", -4, -51)
			AuctionInfo:Show()

			AuctPriceRemember:SetParent("AuctionFrameAuctions")
			AuctPriceRemember:SetPoint("TOPLEFT", "AuctionsDepositText", "BOTTOMLEFT", 0, -6)
			AuctPriceRemember:Show()
			AuctPriceRememberText:SetText(_AUCT('GuiRememberText'))
			AuctPriceRememberCheck:SetParent("AuctionFrameAuctions")
			AuctPriceRememberCheck:SetPoint("TOPLEFT", "AuctionsDepositText", "BOTTOMLEFT", 0, -2)
			AuctPriceRememberCheck:Show()
		end

		-- Protect the auction frame from being closed.
		-- This call is to ensure the window is protected even after you
		-- manually load Auctioneer while already showing the AuctionFrame
		if (Auctioneer.Command.GetFilterVal('protect-window') == 2) then
			Auctioneer.Util.ProtectAuctionFrame(true);
		end

		Auctioneer.Core.HookAuctionHouse()
		AuctionFrameFilters_UpdateClasses()
		lAHConfigPending = nil

		-- Count the number of auction house tabs
		local tabCount = 0;
		while (getglobal("AuctionFrameTab"..(tabCount + 1)) ~= nil) do
			tabCount = tabCount + 1;
		end

		-- Find the correct location to insert our Search Auctions and Post Auctions
		-- tabs. We want to insert them at the end or before BeanCounter's
		-- Transactions tab.
		local tabIndex = 1;
		while (getglobal("AuctionFrameTab"..(tabIndex)) ~= nil and
			   getglobal("AuctionFrameTab"..(tabIndex)):GetName() ~= "AuctionFrameTabTransactions") do
			tabIndex = tabIndex + 1;
		end
		insertAHTab(tabIndex, AuctionFrameTabSearch, AuctionFrameSearch);
		insertAHTab(tabIndex + 1, AuctionFrameTabPost, AuctionFramePost);

		if (not AuctionUI_Hooked) then
			Stubby.RegisterFunctionHook("AuctionFrameTab_OnClick", 200, AuctioneerUI_AuctionFrameTab_OnClickHook)
			AuctionUI_Hooked = true
		end
	end
end

function insertAHTab(tabIndex, tabButton, tabFrame)
	-- Count the number of auction house tabs (including the tab we are going
	-- to insert).
	local tabCount = 1;
	while (getglobal("AuctionFrameTab"..(tabCount)) ~= nil) do
		tabCount = tabCount + 1;
	end

	-- Adjust the tabIndex to fit within the current tab count.
	if (tabIndex < 1 or tabIndex > tabCount) then
		tabIndex = tabCount;
	end

	-- Make room for the tab, if needed.
	for index = tabCount, tabIndex + 1, -1  do
		setglobal("AuctionFrameTab"..(index), getglobal("AuctionFrameTab"..(index - 1)));
		getglobal("AuctionFrameTab"..(index)):SetID(index);
	end

	-- Configure the frame.
	tabFrame:SetParent("AuctionFrame");
	tabFrame:SetPoint("TOPLEFT", "AuctionFrame", "TOPLEFT", 0, 0);
	relevel(tabFrame);

	-- Configure the tab button.
	setglobal("AuctionFrameTab"..tabIndex, tabButton);
	tabButton:SetParent("AuctionFrame");
	tabButton:SetPoint("TOPLEFT", getglobal("AuctionFrameTab"..(tabIndex - 1)):GetName(), "TOPRIGHT", -8, 0);
	tabButton:SetID(tabIndex);
	tabButton:Show();

	-- If we inserted a tab in the middle, adjust the layout of the next tab button.
	if (tabIndex < tabCount) then
		nextTabButton = getglobal("AuctionFrameTab"..(tabIndex + 1));
		nextTabButton:SetPoint("TOPLEFT", tabButton:GetName(), "TOPRIGHT", -8, 0);
	end

	-- Update the tab count.
	PanelTemplates_SetNumTabs(AuctionFrame, tabCount)
end

function auctionFrameFiltersUpdateClasses() --Auctioneer_AuctionFrameFilters_UpdateClasses
	local obj
	for i=1, 15 do
		obj = getglobal("AuctionFilterButton"..i.."Checkbox")
		if (obj) then
			obj:SetParent("AuctionFilterButton"..i)
			obj:SetPoint("RIGHT", "AuctionFilterButton"..i, "RIGHT", -5,0)
		end
	end
end

function rememberPrice()
	if (not Auctioneer_CurAuctionItem) then
		AuctPriceRememberCheck:SetChecked(false)
		return
	end

	if (not AuctPriceRememberCheck:GetChecked()) then
		Auctioneer.Storage.DeleteFixedPrice(Auctioneer_CurAuctionItem)
	else
		local count = Auctioneer_CurAuctionCount
		local start = MoneyInputFrame_GetCopper(StartPrice)
		local buy = MoneyInputFrame_GetCopper(BuyoutPrice)
		local dur = AuctionFrameAuctions.duration
		Auctioneer.Storage.SetFixedPrice(Auctioneer_CurAuctionItem, start, buy, dur, count)
	end
end

function auctionsClear() --Auctioneer_Auctions_Clear
	for i = 1, 5 do
		getglobal("AuctionInfoText"..i):Hide();
		getglobal("AuctionInfoMoney"..i):Hide();
	end
	AuctionInfoWarnText:Hide();
end

function auctionsSetWarn(textStr) --Auctioneer_Auctions_SetWarn
	if (AuctionInfoWarnText == nil) then EnhTooltip.DebugPrint("Error, no text for AuctionInfo line "..line); end
	local cHex, cRed, cGreen, cBlue = Auctioneer.Util.GetWarnColor(textStr)
	AuctionInfoWarnText:SetText(textStr);
	AuctionInfoWarnText:SetTextColor(cRed, cGreen, cBlue);
	AuctionInfoWarnText:Show();
end

function auctionsSetLine(line, textStr, moneyAmount) --Auctioneer_Auctions_SetLine
	local text = getglobal("AuctionInfoText"..line);
	local money = getglobal("AuctionInfoMoney"..line);
	if (text == nil) then EnhTooltip.DebugPrint("Error, no text for AuctionInfo line "..line); end
	if (money == nil) then EnhTooltip.DebugPrint("Error, no money for AuctionInfo line "..line); end
	text:SetText(textStr);
	text:Show();
	if (money ~= nil) then
		MoneyFrame_Update("AuctionInfoMoney"..line, math.ceil(Auctioneer.Util.NullSafe(moneyAmount)));
		getglobal("AuctionInfoMoney"..line.."SilverButtonText"):SetTextColor(1.0,1.0,1.0);
		getglobal("AuctionInfoMoney"..line.."CopperButtonText"):SetTextColor(0.86,0.42,0.19);
		money:Show();
	else
		money:Hide();
	end
end


function newAuction()
	local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo()
	local countFix = count
	if countFix == 0 then
		countFix = 1
	end

	if (not name) then
		Auctioneer.Scanner.AuctionsClear()
		return
	end

	local bag, slot, id, rprop, enchant, uniq = EnhTooltip.FindItemInBags(name);
	if (bag == nil) then
		-- is the item one of your bags?
		local i
		for i = 0, 4, 1 do
			if name == GetBagName(i) then
				id, rprop, enchant, uniq = breakLink(GetInventoryItemLink("player", ContainerIDToInventoryID(i)))
				break
			end
		end
	end

	-- still no corresponding item found?
	if id == nil then
		Auctioneer.Scanner.AuctionsClear()
		return
	end

	local startPrice, buyoutPrice, x;
	local itemKey = id..":"..rprop..":"..enchant;
	Auctioneer_CurAuctionItem = itemKey;
	Auctioneer_CurAuctionCount = countFix;
	local auctionPriceItem = Auctioneer.Core.GetAuctionPriceItem(itemKey);
	local aCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = Auctioneer.Core.GetAuctionPrices(auctionPriceItem.data);

	if (Auctioneer.Storage.GetFixedPrice(itemKey)) then
		AuctPriceRememberCheck:SetChecked(true)
	else
		AuctPriceRememberCheck:SetChecked(false)
	end

	-- Find the current lowest buyout for 1 of these in the current snapshot
	local currentLowestBuyout = Auctioneer.Statistic.FindLowestAuctions(itemKey);
	if currentLowestBuyout then
		x,x,x,x,lowStackCount,x,currentLowestBuyout = Auctioneer.Core.GetItemSignature(currentLowestBuyout);
		currentLowestBuyout = currentLowestBuyout / lowStackCount;
	end

	local historicalMedian, historicalMedCount = Auctioneer.Statistic.GetItemHistoricalMedianBuyout(itemKey);
	local snapshotMedian, snapshotMedCount = Auctioneer.Statistic.GetItemSnapshotMedianBuyout(itemKey);

	auctionsClear();
	Auctioneer.Scanner.AuctionsSetLine(1, string.format(_AUCT('FrmtAuctinfoHist'), historicalMedCount), historicalMedian * count);
	Auctioneer.Scanner.AuctionsSetLine(2, string.format(_AUCT('FrmtAuctinfoSnap'), snapshotMedCount), snapshotMedian * count);
	if (snapshotMedCount and snapshotMedCount > 0 and currentLowestBuyout) then
		Auctioneer.Scanner.AuctionsSetLine(3, _AUCT('FrmtAuctinfoLow'), currentLowestBuyout * count);
	else
		Auctioneer.Scanner.AuctionsSetLine(3, _AUCT('FrmtAuctinfoNolow'));
	end
	local blizPrice = MoneyInputFrame_GetCopper(StartPrice);

	local hsp, hspCount, mktPrice, warn = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
	if hsp == 0 and buyCount > 0 then
		hsp = math.ceil(buyPrice / buyCount); -- use mean buyout if median not available
	end
	local discountBidPercent = tonumber(Auctioneer.Command.GetFilterVal('pct-bidmarkdown'));
	local buyPrice = Auctioneer.Statistic.RoundDownTo95(Auctioneer.Util.NullSafe(hsp) * countFix);
	local bidPrice = Auctioneer.Statistic.RoundDownTo95(Auctioneer.Statistic.SubtractPercent(buyPrice, discountBidPercent));

	if (Auctioneer.Storage.GetFixedPrice(itemKey)) then
		local start, buy, dur = Auctioneer.Storage.GetFixedPrice(itemKey, countFix)
		Auctioneer.Scanner.AuctionsSetLine(4, _AUCT('FrmtAuctinfoSugbid'), bidPrice);
		Auctioneer.Scanner.AuctionsSetLine(5, _AUCT('FrmtAuctinfoSugbuy'), buyPrice);
		auctionsSetWarn(_AUCT('FrmtWarnUser'));
		MoneyInputFrame_SetCopper(StartPrice, start);
		MoneyInputFrame_SetCopper(BuyoutPrice, buy);
		setAuctionDuration(tonumber(dur));
	elseif (Auctioneer.Command.GetFilter('autofill')) then
		Auctioneer.Scanner.AuctionsSetLine(4, _AUCT('FrmtAuctinfoMktprice'), Auctioneer.Util.NullSafe(mktPrice)*countFix);
		Auctioneer.Scanner.AuctionsSetLine(5, _AUCT('FrmtAuctinfoOrig'), blizPrice);
		auctionsSetWarn(warn);
		MoneyInputFrame_SetCopper(StartPrice, bidPrice);
		MoneyInputFrame_SetCopper(BuyoutPrice, buyPrice);
	else
		Auctioneer.Scanner.AuctionsSetLine(4, _AUCT('FrmtAuctinfoSugbid'), bidPrice);
		Auctioneer.Scanner.AuctionsSetLine(5, _AUCT('FrmtAuctinfoSugbuy'), buyPrice);
		auctionsSetWarn(warn);
	end
end

function auctHouseShow()
	-- Set the default auction duration
	if (Auctioneer.Command.GetFilterVal('auction-duration') > 0) then
		setAuctionDuration(Auctioneer.Command.GetFilterVal('auction-duration'))
	else
		setAuctionDuration(Auctioneer.Command.GetFilterVal('last-auction-duration'))
	end

	-- Protect the auction frame from being closed if we should
	if (Auctioneer.Command.GetFilterVal('protect-window') == 2) then
		Auctioneer.Util.ProtectAuctionFrame(true);
	end

	-- Start scanning if so requested
	if Auctioneer.Scanning.IsScanningRequested then
		Auctioneer.Scanning.StartAuctionScan();
	end
end


function auctHouseClose()
	if Auctioneer.Scanning.IsScanningRequested then
		Auctioneer.Scanning.StopAuctionScan();
	end

	-- Unprotect the auction frame
	Auctioneer.Util.ProtectAuctionFrame(false);
end

function auctHouseUpdate()
	if (Auctioneer.Scanning.IsScanningRequested and Auctioneer.Scanning.CheckCompleteScan()) then
		Auctioneer.Scanning.ScanAuction();
	end
end

function filterButtonSetType(funcVars, retVal, button, type, text, isLast) --Auctioneer_FilterButton_SetType
	EnhTooltip.DebugPrint("Setting button", button:GetName(), type, text, isLast);

	local buttonName = button:GetName();
	local i,j, buttonID = string.find(buttonName, "(%d+)$");
	buttonID = tonumber(buttonID);

	local checkbox = getglobal(button:GetName().."Checkbox");
	if checkbox then
		if (type == "class") then
			local classid, maxid = Auctioneer.Command.FindFilterClass(text);
			if (classid > 0) then
				Auctioneer.Command.FilterSetFilter(checkbox, "scan-class"..classid);
				if (classid == maxid) and (buttonID < 15) then
					for i=buttonID+1, 15 do
						getglobal("AuctionFilterButton"..i):Hide();
					end
				end
			else
				checkbox:Hide();
			end
		else
			checkbox:Hide();
		end
	end
end

local ignoreAuctionDurationChange = nil
function onChangeAuctionDuration()
	if (ignoreAuctionDurationChange) then
		ignoreAuctionDurationChange = nil;
		return
	end
	Auctioneer.Command.SetFilter('last-auction-duration', AuctionFrameAuctions.duration)
end

function setAuctionDuration(duration, persist)
	local durationIndex
	if (duration >= 1 and duration <= 3) then
		durationIndex = duration
	elseif (duration == 120) then
		durationIndex = 1
	elseif (duration == 480) then
		durationIndex = 2
	elseif (duration == 1440) then
		durationIndex = 3
	else
		EnhTooltip.DebugPrint("Auctioneer.Scanner.SetAuctionDuration(): invalid duration ", duration)
		return
	end

	if (not persist) then ignoreAuctionDurationChange = true; end
	AuctionsRadioButton_OnClick(durationIndex);
end

Auctioneer.Scanner = {
	ProcessLink = processLink,
	InvalidateAHSnapshot = invalidateAHSnapshot,
	AuctionStartHook = auctionStartHook,
	FinishedAuctionScanHook = finishedAuctionScanHook,
	AuctionEntryHook = auctionEntryHook,
	StartAuction = startAuction,
	PlaceAuctionBid = placeAuctionBid,
	ConfigureAH = configureAH,
	AuctionFrameFiltersUpdateClasses = auctionFrameFiltersUpdateClasses,
	RememberPrice = rememberPrice,
	AuctionsClear = auctionsClear,
	AuctionsSetWarn = auctionsSetWarn,
	AuctionsSetLine = auctionsSetLine,
	NewAuction = newAuction,
	AuctHouseShow = auctHouseShow,
	AuctHouseClose = auctHouseClose,
	AuctHouseUpdate = auctHouseUpdate,
	FilterButtonSetType = filterButtonSetType,
	OnChangeAuctionDuration = onChangeAuctionDuration,
	SetAuctionDuration = setAuctionDuration,
}

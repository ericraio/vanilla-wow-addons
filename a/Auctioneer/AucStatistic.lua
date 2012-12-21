--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucStatistic.lua 872 2006-05-21 09:24:08Z luke1410 $

	Auctioneer statistical functions.
	Functions to calculate various forms of statistics from the auction data.

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
local subtractPercent, addPercent, percentLessThan, getLowest, getMedian, getPercentile, getMeans, getItemSnapshotMedianBuyout, getItemHistoricalMedianBuyout, getUsableMedian, getCurrentBid, isBadResaleChoice, profitComparisonSort, roundDownTo95, findLowestAuctions, buildLowestCache, doLow, doMedian, doHSP, getBidBasedSellablePrice, getMarketPrice, getHSP, determinePrice

-- Subtracts/Adds given percentage from/to a value

function subtractPercent(value, percentLess) --function subtractPercent(value, percentLess)
	return math.floor(value * ((100 - percentLess)/100));
end

function addPercent(value, percentMore)
	return math.floor(value * ((100 + percentMore)/100));
end

-- returns the integer representation of the percent less value2 is from value1
-- example: value1=10, value2=7,  percentLess=30
function percentLessThan(value1, value2)
	if Auctioneer.Util.NullSafe(value1) > 0 and Auctioneer.Util.NullSafe(value2) < Auctioneer.Util.NullSafe(value1) then
		return 100 - math.floor((100 * Auctioneer.Util.NullSafe(value2))/Auctioneer.Util.NullSafe(value1));
	else
		return 0;
	end
end

function getLowest(valuesTable)
	if (not valuesTable or table.getn(valuesTable) == 0) then
		return nil, nil;
	end
	local tableSize = table.getn(valuesTable);
	local lowest = tonumber(valuesTable[1]) or 0;
	local second = nil
	if (tableSize > 1) then
		for i=2, tableSize do
			second = tonumber(valuesTable[i]) or 0;
			if (second > lowest) then
				return lowest, second;
			end
		end
	end
	return lowest, nil;
end

-- Returns the median value of a given table one-dimentional table
function getMedian(valuesTable)
	return getPercentile(valuesTable, 0.5)
end

-- Return weighted average percentile such that returned value
-- is larger than or equal to (100*pct)% of the table values
-- 0 <= pct <= 1
function getPercentile(valuesTable, pct)
	if (type(valuesTable) ~= "table") or (not tonumber(pct)) then
		return nil   -- make valuesTable a required table argument
	end
	pct = math.min(math.max(pct, 0), 1) -- Make sure 0 <= pct <= 1

	local _percentile = function(sortedTable, p, first, last)
		local f = (last - first) * p + first
		local i1, i2 = math.floor(f), math.ceil(f)
		f = f - i1

		return sortedTable[i1] * (1 - f) + sortedTable[i2] * f
	end

	local tableSize = table.getn(valuesTable) or 0

	if (tableSize == 0) then
		return 0, 0; -- if there is an empty table, returns median = 0, count = 0
	elseif (tableSize == 1) then
		return tonumber(valuesTable[1]), 1
	end

	-- The following calculations require a sorted table
	table.sort(valuesTable)

	-- Skip IQR calculations if table is too small to have outliers
	if tableSize <= 4 then
		return _percentile(valuesTable, pct, 1, tableSize), tableSize
	end

	--  REWORK by Karavirs to use IQR*1.5 to ignore outliers
	-- q1 is median 1st quartile q2 is median of set q3 is median of 3rd quartile iqr is q3 - q1
	local q1 = _percentile(valuesTable, 0.25, 1, tableSize)
	local q3 = _percentile(valuesTable, 0.75, 1, tableSize)
	assert(q3 >= q1)

	local iqr = (q3 - q1) * 1.5
	local iqlow, iqhigh = q1 - iqr, q3 + iqr

	-- Find first and last index to include in median calculation
	local first, last = 1, tableSize

	-- Skip low outliers
	while valuesTable[first] < iqlow do
		first = first + 1
	end

	-- Skip high outliers
	while valuesTable[last] > iqhigh do
		last = last - 1
	end
	assert(last >= first)

	return _percentile(valuesTable, pct, first, last), last - first + 1
end


-- Return all of the averages for an item
-- Returns: avgMin,avgBuy,avgBid,bidPct,buyPct,avgQty,aCount
function getMeans(itemKey, from)
	local auctionPriceItem = Auctioneer.Core.GetAuctionPriceItem(itemKey, from);
	if (not auctionPriceItem.data) then
		EnhTooltip.DebugPrint("Error, GetAuctionPriceItem", itemKey, from, "returns", auctionPriceItem);
	end
	local aCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = Auctioneer.Core.GetAuctionPrices(auctionPriceItem.data);
	local avgMin,avgBuy,avgBid,bidPct,buyPct,avgQty;

	if aCount > 0 then
		avgQty = math.floor(minCount / aCount);
		avgMin = math.floor(minPrice / minCount);
		bidPct = math.floor(bidCount / minCount * 100);
		buyPct = math.floor(buyCount / minCount * 100);

		avgBid = 0;
		if (bidCount > 0) then
			avgBid = math.floor(bidPrice / bidCount);
		end

		avgBuy = 0;
		if (buyCount > 0) then
			avgBuy = math.floor(buyPrice / buyCount);
		end
	end
	return avgMin,avgBuy,avgBid,bidPct,buyPct,avgQty,aCount;
end

-- Returns the current snapshot median for an item
function getItemSnapshotMedianBuyout(itemKey, auctKey, buyoutPrices)
	if (not auctKey) then auctKey = Auctioneer.Util.GetAuctionKey() end

	local stat, count;

	if (AuctionConfig.stats and AuctionConfig.stats.snapmed and AuctionConfig.stats.snapmed[auctKey]) then
		stat = AuctionConfig.stats.snapmed[auctKey][itemKey];
		count = AuctionConfig.stats.snapcount[auctKey][itemKey];
	end

	if (not stat) or (not count) then
		if (not buyoutPrices) then
			local sbuy = Auctioneer.Core.GetSnapshotInfo(auctKey, itemKey);
			if (sbuy) then
				buyoutPrices = sbuy.buyoutPrices;
			end
		end

		if (buyoutPrices) then
			stat, count = getMedian(buyoutPrices);
		else
			stat, count = 0, 0;
		end

		-- save median to the savedvariablesfile
		Auctioneer.Storage.SetSnapMed(auctKey, itemKey, stat, count)
	end

	return stat, count;
end

-- Returns the historical median for an item
function getItemHistoricalMedianBuyout(itemKey, auctKey, buyoutHistoryTable)
	if (not auctKey) then auctKey = Auctioneer.Util.GetAuctionKey() end

	local stat, count;

	if (AuctionConfig.stats and AuctionConfig.stats.histmed and AuctionConfig.stats.histmed[auctKey]) then
		stat = AuctionConfig.stats.histmed[auctKey][itemKey];
		count = AuctionConfig.stats.histcount[auctKey][itemKey];
	end

	if (not stat) or (not count) then
		if (not buyoutHistoryTable) then
			buyoutHistoryTable = Auctioneer.Core.GetAuctionBuyoutHistory(itemKey, auctKey);
		end

		if (buyoutHistoryTable) then
			stat, count = getMedian(buyoutHistoryTable);
		else
			stat, count = 0, 0;
		end

		-- save median to the savedvariablesfile
		Auctioneer.Storage.SetHistMed(auctKey, itemKey, stat, count);
	end

	return stat, count;
end

-- this function returns the most accurate median possible,
-- if an accurate median cannot be obtained based on min seen counts then nil is returned
function getUsableMedian(itemKey, realm, buyoutPrices)
	if not realm then
		realm = Auctioneer.Util.GetAuctionKey();
	end

	--get snapshot median
	local snapshotMedian, snapCount = getItemSnapshotMedianBuyout(itemKey, realm, buyoutPrices)
	--get history median
	local historyMedian, histCount = getItemHistoricalMedianBuyout(itemKey, realm);

	local median, count
	if (histCount >= Auctioneer.Core.Constants.MinBuyoutSeenCount) then
		median, count = historyMedian, histCount;
	end
	if (snapCount >= Auctioneer.Core.Constants.MinBuyoutSeenCount) then
		if (histCount < snapCount) then
			-- History median isn't shown in tooltip if histCount < snapCount so use snap median in this case
			median, count = snapshotMedian, snapCount;
		elseif (snapshotMedian < 1.2 * historyMedian) then
			median, count = snapshotMedian, snapCount;
		end
	end
	return median, count;
end

-- Returns the current bid on an auction
function getCurrentBid(auctionSignature)
	local x,x,x, x, x,min,x,_ = Auctioneer.Core.GetItemSignature(auctionSignature);
	local auctKey = Auctioneer.Util.GetAuctionKey();
	local itemCat = Auctioneer.Util.GetCatForSig(auctionSignature);
	local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, auctionSignature);
	if (not snap) then return 0 end
	local currentBid = tonumber(snap.bidamount) or 0;
	if currentBid == 0 then currentBid = min end
	return currentBid;
end

-- This filter will return true if an auction is a bad choice for reselling
function isBadResaleChoice(auctSig, auctKey)
	if (not auctKey) then auctKey = Auctioneer.Util.GetAuctionKey() end

	local isBadChoice = false;
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(auctSig);
	local itemKey = id..":"..rprop..":"..enchant;
	local itemCat = Auctioneer.Util.GetCatForKey(itemKey);
	local auctionItem = Auctioneer.Core.GetSnapshot(auctKey, itemCat, auctSig);
	local auctionPriceItem = Auctioneer.Core.GetAuctionPriceItem(itemKey, auctKey);
	local aCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = Auctioneer.Core.GetAuctionPrices(auctionPriceItem.data);
	local bidPercent = math.floor(bidCount / minCount * 100);

	if (auctionItem) then
		local itemLevel = tonumber(auctionItem.level);
		local itemQuality = tonumber(auctionItem.quality);

		-- bad choice conditions
		if Auctioneer.Core.Constants.BidBasedCategories[auctionItem.category] and bidPercent < Auctioneer.Core.Constants.MinBidPercent then
			isBadChoice = true; -- bidbased items should have a minimum bid percent
		elseif (itemLevel >= 50 and itemQuality == Auctioneer.Core.Constants.Quality.Uncommon and bidPercent < Auctioneer.Core.Constants.MinBidPercent) then
			isBadChoice = true; -- level 50 and greater greens that do not have bids do not sell well
		elseif auctionItem.owner == UnitName("player") or auctionItem.highBidder then
			isBadChoice = true; -- don't display auctions that we own, or are high bidder on
		elseif itemQuality == Auctioneer.Core.Constants.Quality.Poor then
			isBadChoice = true; -- gray items are never a good choice
		end
	end

	return isBadChoice;
end

-- method to pass to table.sort() that sorts auctions by profit descending
function profitComparisonSort(a, b)
	local aid,arprop,aenchant, aName, aCount, x, aBuyout, x = Auctioneer.Core.GetItemSignature(a.signature);
	local bid,brprop,benchant, bName, bCount, x, bBuyout, x = Auctioneer.Core.GetItemSignature(b.signature);
	local aItemKey = aid .. ":" .. arprop..":"..aenchant;
	local bItemKey = bid .. ":" .. brprop..":"..benchant;
	local realm = Auctioneer.Util.GetAuctionKey()
	local aProfit = (getHSP(aItemKey, realm) * aCount) - aBuyout;
	local bProfit = (getHSP(bItemKey, realm) * bCount) - bBuyout;
	return (aProfit > bProfit)
end

-- this function takes copper and rounds to 5 silver below the the nearest gold if it is less than 15 silver above of an even gold
-- example: this function changes 1g9s to 95s
-- example: 1.5g will be unchanged and remain 1.5g
function roundDownTo95(copper)
	local g,s,c = EnhTooltip.GetGSC(copper);
	if g > 0 and s < 10 then
		return (copper - ((s + 5) * 100)); -- subtract enough copper to round to 95 silver
	end
	return copper;
end


-- given an item name, find the lowest price for that item in the current AHSnapshot
-- if the item does not exist in the snapshot or the snapshot does not exist
-- a nil is returned.
function findLowestAuctions(itemKey, auctKey)
	local itemID, itemRand, enchant = Auctioneer.Util.BreakItemKey(itemKey);
	if (itemID == nil) then return nil; end
	if (not auctKey) then
		auctKey = Auctioneer.Util.GetAuctionKey();
	end
	if not (Auctioneer_Lowests and Auctioneer_Lowests[auctKey]) then buildLowestCache(auctKey) end

	local lowKey = itemID..":"..itemRand;

	local itemCat = nil;
	local lowSig = nil;
	local nextSig = nil;
	local lowestPrice = 0;
	local nextLowest = 0;

	local lows = Auctioneer_Lowests[auctKey][lowKey];
	if (lows) then
		lowSig = lows.lowSig;
		nextSig = lows.nextSig;
		lowestPrice = lows.lowestPrice or 0;
		nextLowest = lows.nextLowest or 0;
		itemCat = lows.cat;
	end

	return lowSig, lowestPrice, nextSig, nextLowest, itemCat;
end

function buildLowestCache(auctKey)
	if (Auctioneer_Lowests == nil) then Auctioneer_Lowests = {}; end
	Auctioneer_Lowests[auctKey] = {}

	local id, rprop, enchant, name, count, min, buyout, uniq, lowKey, priceForOne, lowests;
	if (AuctionConfig and AuctionConfig.snap and AuctionConfig.snap[auctKey]) then
		for itemCat, cData in pairs(AuctionConfig.snap[auctKey]) do
			for sig, sData in pairs(cData) do
				id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(sig);

				lowKey = id..":"..rprop;
				if (not Auctioneer_Lowests[auctKey][lowKey]) then Auctioneer_Lowests[auctKey][lowKey] = {cat = itemCat} end
				lowests = Auctioneer_Lowests[auctKey][lowKey]

				if (Auctioneer.Util.NullSafe(buyout) > 0) then
					priceForOne = Auctioneer.Util.PriceForOne(buyout, count)

					if (lowests.lowestPrice == nil) or (priceForOne < lowests.lowestPrice) then
						lowests.lowestPrice, lowests.nextLowest = priceForOne, lowests.lowestPrice
						lowests.lowSig, lowests.nextSig = sig, lowests.lowSig
					elseif (lowests.nextLowest == nil) or (priceForOne < lowests.nextLowest) then
						lowests.nextLowest = priceForOne
						lowests.nextSig = sig
					end
				end
			end
		end
	end
end

-- execute the '/auctioneer low <itemName>' that returns the auction for an item with the lowest buyout
function doLow(link)

	local auctKey = Auctioneer.Util.GetAuctionKey();
	local items = Auctioneer.Util.GetItems(link);
	local itemLinks = Auctioneer.Util.GetItemHyperlinks(link);

	if (items) then
		for pos,itemKey in pairs(items) do

			local auctionSignature = findLowestAuctions(itemKey);
			if (not auctionSignature) then
				Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtNoauct'), itemLinks[pos]));

			else
				local itemCat = Auctioneer.Util.GetCatForKey(itemKey);
				local auction = Auctioneer.Core.GetSnapshot(auctKey, itemCat, auctionSignature);
				local x,x,x, x, count, x, buyout, x = Auctioneer.Core.GetItemSignature(auctionSignature);
					Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtLowLine'), Auctioneer.Util.ColorTextWhite(count.."x")..auction.itemLink, EnhTooltip.GetTextGSC(buyout), Auctioneer.Util.ColorTextWhite(auction.owner), EnhTooltip.GetTextGSC(buyout / count), Auctioneer.Util.ColorTextWhite(percentLessThan(getUsableMedian(itemKey), buyout / count).."%")));
			end
		end
	end
end

function doMedian(link)

	local items = Auctioneer.Util.GetItems(link);
	local itemLinks = Auctioneer.Util.GetItemHyperlinks(link);

	if (items) then
		for pos,itemKey in pairs(items) do

			local median, count = getUsableMedian(itemKey);
			if (not median) then
				Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtMedianNoauct'), Auctioneer.Util.ColorTextWhite(itemName)));
			else
				if (not count) then count = 0 end
				Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtMedianLine'), count, Auctioneer.Util.ColorTextWhite(itemName), EnhTooltip.GetTextGSC(median)));
			end
		end
	end
end

function doHSP(link)

	local items = Auctioneer.Util.GetItems(link);
	local itemLinks = Auctioneer.Util.GetItemHyperlinks(link);

	if (items) then
		for pos,itemKey in pairs(items) do

			local highestSellablePrice = getHSP(itemKey, Auctioneer.Util.GetAuctionKey());
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtHspLine'), itemLinks[pos], EnhTooltip.GetTextGSC(Auctioneer.Util.NilSafeString(highestSellablePrice))));
		end
	end
end

function getBidBasedSellablePrice(itemKey,realm, avgMin,avgBuy,avgBid,bidPct,buyPct,avgQty,seenCount)
	-- We can pass these values along if we have them.
	if (seenCount == nil) then
		avgMin,avgBuy,avgBid,bidPct,buyPct,avgQty,seenCount = getMeans(itemKey, realm);
	end
	local bidBasedSellPrice = 0;
	local typicalBuyout = 0;

	local medianBuyout = getUsableMedian(itemKey, realm);
	if medianBuyout and avgBuy then
		typicalBuyout = math.min(avgBuy, medianBuyout);
	elseif medianBuyout then
		typicalBuyout = medianBuyout;
	else
		typicalBuyout = avgBuy or 0;
	end

	if (avgBid) then
		bidBasedSellPrice = math.floor((3*typicalBuyout + avgBid) / 4);
	else
		bidBasedSellPrice = typicalBuyout;
	end
	return bidBasedSellPrice;
end

-- returns the best market price - 0, if no market price could be calculated
function getMarketPrice(itemKey, realm, buyoutValues)
	-- make sure to call this function with valid parameters! No check is being performed!
	local buyoutMedian = Auctioneer.Util.NullSafe(getUsableMedian(itemKey, realm, buyoutValues))
	local avgMin, avgBuy, avgBid, bidPct, buyPct, avgQty, meanCount = getMeans(itemKey, realm)
	local commonBuyout = 0

	-- assign the best common buyout
	if buyoutMedian > 0 then
		commonBuyout = buyoutMedian
	elseif meanCount and meanCount > 0 then
		-- if a usable median does not exist, use the average buyout instead
		commonBuyout = avgBuy;
	end

	local playerMade, skill, level = Auctioneer.Core.IsPlayerMade(itemKey);
	if Auctioneer.Core.Constants.BidBasedCategories[Auctioneer.Core.GetItemCategory(itemKey)] and not (playerMade and level < 250 and commonBuyout < 100000) then
		-- returns bibasedSellablePrice for bidbaseditems, playermade items or if the buyoutprice is not present or less than 10g
		return getBidBasedSellablePrice(itemKey,realm, avgMin,avgBuy,avgBid,bidPct,buyPct,avgQty,seenCount)
	end

	-- returns buyoutMedian, if present - returns avgBuy otherwise, if meanCount > 0 - returns 0 otherwise
	return commonBuyout
end

-- Returns market information relating to the HighestSellablePrice for one of the given items.
-- If you use cached data it may be affected by buying/selling items.
HSPCOUNT = 0; CACHECOUNT = 0;
function getHSP(itemKey, realm, buyoutValues, itemCat)
	if (itemKey == nil) then                                 -- make itemKey a required parameter
		EnhTooltip.DebugPrint("ERROR: Calling Auctioneer.Statistic.GetHSP(itemKey, realm) - Function requires valid itemKey.");
		return nil;
	end
	if (realm == nil) then
		EnhTooltip.DebugPrint("WARNING: Auctioneer.Statistic.GetHSP(itemKey, realm) - Defaulting to player realm.");
		EnhTooltip.DebugPrint("This is only some debugging code. THIS IS NO BUG!");
		realm = Auctioneer.Util.GetAuctionKey();
	end

	if (not Auctioneer_HSPCache) then Auctioneer_HSPCache = {}; end
	CACHECOUNT = CACHECOUNT + 1;

	if (not Auctioneer_HSPCache[realm]) then Auctioneer_HSPCache[realm] = {} end
	local cached = Auctioneer_HSPCache[realm][itemKey];
	if (cached) then
		local cache = Auctioneer.Util.Split(cached, ";");
		return tonumber(cache[1]), tonumber(cache[2]), tonumber(cache[3]), cache[4], tonumber(cache[5]), cache[6];
	end
	HSPCOUNT = HSPCOUNT + 1;

	local highestSellablePrice = 0;
	local warn = _AUCT('FrmtWarnNodata');
	EnhTooltip.DebugPrint("Getting HSP, calling GetMarketPrice", itemKey, realm);
	if (not buyoutValues) then
		local sbuy = Auctioneer.Core.GetSnapshotInfo(realm, itemKey);
		if sbuy then
			buyoutValues = sbuy.buyoutPrices;
		end
	end

	local marketPrice = getMarketPrice(itemKey, realm, buyoutValues);

	-- Get our user-set pricing parameters
	local lowestAllowedPercentBelowMarket = tonumber(Auctioneer.Command.GetFilterVal('pct-maxless'));
	local discountLowPercent              = tonumber(Auctioneer.Command.GetFilterVal('pct-underlow'));
	local discountMarketPercent           = tonumber(Auctioneer.Command.GetFilterVal('pct-undermkt'));
	local discountNoCompetitionPercent    = tonumber(Auctioneer.Command.GetFilterVal('pct-nocomp'));
	local vendorSellMarkupPercent         = tonumber(Auctioneer.Command.GetFilterVal('pct-markup'));

	local x, histCount = getUsableMedian(itemKey, realm, buyoutValues);
	histCount = Auctioneer.Util.NullSafe(histCount);

	local id = Auctioneer.Util.BreakItemKey(itemKey);

	-- Get the snapshot sigs of the two lowest auctions
	local currentLowestSig = nil;
	local currentLowestBuyout = nil;
	local currentLowestCount = nil;

	local nextLowestSig = nil;
	local nextLowestBuyout = nil;
	local nextLowestCount = nil;

	local lowSig, lowPrice, nextSig, nextPrice, itemCat = findLowestAuctions(itemKey, realm);
	if lowSig then
		currentLowestSig = lowSig;
		currentLowestBuyout = lowPrice;
		nextLowestSig = nextSig;
		nextLowestBuyout = nextPrice;
	end

	if (not itemCat) then itemCat = Auctioneer.Util.GetCatForKey(itemKey) end

	local hsp, market, warn = determinePrice(id, realm, marketPrice, currentLowestBuyout, currentLowestSig, lowestAllowedPercentBelowMarket, discountLowPercent, discountMarketPercent, discountNoCompetitionPercent, vendorSellMarkupPercent, itemCat);
	local nexthsp, x, nextwarn = determinePrice(id, realm, marketPrice, nextLowestBuyout, nextLowestSig, lowestAllowedPercentBelowMarket, discountLowPercent, discountMarketPercent, discountNoCompetitionPercent, vendorSellMarkupPercent, itemCat);


	if (not hsp) then
		EnhTooltip.DebugPrint("Unable to calc HSP for",id, realm, marketPrice, currentLowestBuyout, currentLowestSig);
		hsp = 0;
		warn = "";
	end
	if (not nexthsp) then nexthsp = 0; nextwarn = ""; end

	EnhTooltip.DebugPrint("Auction data: ", hsp, histCount, market, warn, nexthsp, nextwarn);

	local cache = string.format("%d;%d;%d;%s;%d;%s", hsp,histCount,market,warn, nexthsp,nextwarn);
	Auctioneer_HSPCache[realm][itemKey] = cache;

	return hsp, histCount, market, warn, nexthsp, nextwarn;
end

function determinePrice(id, realm, marketPrice, currentLowestBuyout, currentLowestSig, lowestAllowedPercentBelowMarket, discountLowPercent, discountMarketPercent, discountNoCompetitionPercent, vendorSellMarkupPercent, itemCat)

	local warn, highestSellablePrice, lowestBuyoutPriceAllowed;

	if marketPrice and marketPrice > 0 then
		if currentLowestBuyout and currentLowestBuyout > 0 then
			lowestBuyoutPriceAllowed = subtractPercent(marketPrice, lowestAllowedPercentBelowMarket);
			if (not itemCat) then itemCat = Auctioneer.Util.GetCatForSig(currentLowestSig) end

			-- since we don't want to decode the full data unless there's a chance it belongs to the player
			-- do a substring search for the players name first.
			-- For some reason AuctionConfig.snap[realm][itemCat][currentLowestSig] sometimes doesn't
			-- exist, even if currentLowestBuyout is set. Added a check for this as a workaround, but
			-- the real cause should probably be tracked down - Thorarin
			local snap;
			if (AuctionConfig.snap[realm][itemCat][currentLowestSig] and string.find(AuctionConfig.snap[realm][itemCat][currentLowestSig], UnitName("player"), 1, true)) then
				snap = Auctioneer.Core.GetSnapshot(realm, itemCat, currentLowestSig);
			end
			if snap and snap.owner == UnitName("player") then
				highestSellablePrice = currentLowestBuyout; -- If I am the lowest seller use same low price
				warn = _AUCT('FrmtWarnMyprice');
			elseif (currentLowestBuyout < lowestBuyoutPriceAllowed) then
				highestSellablePrice = subtractPercent(marketPrice, discountMarketPercent);
				warn = _AUCT('FrmtWarnToolow');
			else
				if (currentLowestBuyout > marketPrice) then
					highestSellablePrice = subtractPercent(marketPrice, discountNoCompetitionPercent);
					warn = _AUCT('FrmtWarnAbovemkt');
				end
				-- Account for negative discountNoCompetitionPercent values
				if (currentLowestBuyout <= marketPrice or highestSellablePrice >= currentLowestBuyout) then
					-- set highest price to "Discount low"
					highestSellablePrice = subtractPercent(currentLowestBuyout, discountLowPercent);
					warn = string.format(_AUCT('FrmtWarnUndercut'), discountLowPercent);
				end
			end
		else -- no low buyout, use discount no competition
			-- set highest price to "Discount no competition"
			highestSellablePrice = subtractPercent(marketPrice, discountNoCompetitionPercent);
			warn = _AUCT('FrmtWarnNocomp');
		end
	else -- no market
		-- Note: urentLowestBuyout is nil, incase the realm is not the current player's realm
		if currentLowestBuyout and currentLowestBuyout > 0 then
			-- set highest price to "Discount low"
			EnhTooltip.DebugPrint("Discount low case 2");
			highestSellablePrice = subtractPercent(currentLowestBuyout, discountLowPercent);
			warn = string.format(_AUCT('FrmtWarnUndercut'), discountLowPercent);
		else
			local baseData;
			if (Informant) then baseData = Informant.GetItem(id) end

			if (baseData and baseData.sell) then
				-- use vendor prices if no auction data available
				local vendorSell = Auctioneer.Util.NullSafe(baseData.sell); -- use vendor prices
				highestSellablePrice = addPercent(vendorSell, vendorSellMarkupPercent);
				warn = string.format(_AUCT('FrmtWarnMarkup'), vendorSellMarkupPercent);
			end
		end
	end

	return highestSellablePrice, marketPrice, warn;
end

Auctioneer.Statistic = {
	SubtractPercent = subtractPercent,
	AddPercent = addPercent,
	PercentLessThan = percentLessThan,
	GetLowest = getLowest,
	GetMedian = getMedian,
	GetPercentile = getPercentile,
	GetMeans = getMeans,
	GetItemSnapshotMedianBuyout = getItemSnapshotMedianBuyout,
	GetSnapMedian = getItemSnapshotMedianBuyout,
	GetItemHistoricalMedianBuyout = getItemHistoricalMedianBuyout,
	GetHistMedian = getItemHistoricalMedianBuyout,
	GetUsableMedian = getUsableMedian,
	GetCurrentBid = getCurrentBid,
	IsBadResaleChoice = isBadResaleChoice,
	ProfitComparisonSort = profitComparisonSort,
	RoundDownTo95 = roundDownTo95,
	FindLowestAuctions = findLowestAuctions,
	BuildLowestCache = buildLowestCache,
	DoLow = doLow,
	DoMedian = doMedian,
	DoHSP = doHSP,
	GetBidBasedSellablePrice = getBidBasedSellablePrice,
	GetMarketPrice = getMarketPrice,
	GetHSP = getHSP,
	DeterminePrice = determinePrice,
}

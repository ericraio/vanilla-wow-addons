--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucFilter.lua 856 2006-05-11 00:23:22Z luke1410 $

	Auctioneer filtering functions.
	Functions to filter auctions based upon various parameters.

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
local brokerFilter, bidBrokerFilter, auctionOwnerFilter, competingFilter, percentLessFilter, plainFilter,  querySnapshot, doBroker, doBidBroker, doCompeting, doPercentLess

function brokerFilter (minProfit, signature) --function brokerFilter(minProfit, signature)
	local filterAuction = true;
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	local itemKey = id..":"..rprop..":"..enchant;

	if (buyout and buyout > 0 and buyout <= Auctioneer.Core.Constants.MaxBuyoutPrice and Auctioneer.Statistic.GetUsableMedian(itemKey)) then
		local auctKey = Auctioneer.Util.GetAuctionKey();
		local itemCat = Auctioneer.Util.GetCatForKey(itemKey);
		local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, signature);

		if (snap) then
			local timeLeft = snap.timeLeft;
			local elapsedTime = time() - snap.lastSeenTime;
			local secondsLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[timeLeft] - elapsedTime;

			if (secondsLeft > 0) then
				local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, auctKey);
				local profit = (hsp * count) - buyout;
				local profitPricePercent = math.floor((profit / buyout) * 100);

				if (profit >= minProfit and profitPricePercent >= Auctioneer.Core.Constants.MinProfitPricePercent and seenCount >= Auctioneer.Core.Constants.MinBuyoutSeenCount and not Auctioneer.Statistic.IsBadResaleChoice(signature)) then
					filterAuction = false;
				end
			end

		end
	end

	return filterAuction;
end

-- filters out all auctions except those that have no more than maximumTime remaining and meet profit requirements
function bidBrokerFilter(minProfit, signature, maximumTime, category, minQuality,itemName)
	local filterAuction = true;
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	local itemKey = id..":"..rprop..":"..enchant;
	if (not maximumTime) then maximumTime = 100000 end
	if (not category) then category = 0 end
	if (not minQuality) then minQuality = 0 end

	if (itemName) then
		local iName
		local oName = string.lower(name)
		local iCount = table.getn(itemName)
		local match = false
		for iPos=1, iCount do
			iName = itemName[iPos]
			if (iName and iName ~= "") then
				local i,j = string.find(oName, string.lower(iName))
				if (i) then match = true end
			end
		end
		if (not match) then return true end
	end

	if Auctioneer.Statistic.GetUsableMedian(itemKey) then  -- only add if we have seen it enough times to have a usable median
		local auctKey = Auctioneer.Util.GetAuctionKey();
		local currentBid = Auctioneer.Statistic.GetCurrentBid(signature);
		local sbuy = Auctioneer.Core.GetSnapshotInfo(auctKey, itemKey);
		local buyoutValues = {};
		if (sbuy) then buyoutValues = sbuy.buyoutPrices end
		local lowest, second = Auctioneer.Statistic.GetLowest(buyoutValues);

		local itemCat = Auctioneer.Util.GetCatForKey(itemKey);
		if (category == 0 or itemCat == category) then
			local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, signature);

			if (snap) then
				if (tonumber(snap.quality) >= tonumber(minQuality)) then
					local timeLeft = tonumber(snap.timeLeft);
					local elapsedTime = time() - tonumber(snap.lastSeenTime);
					local secondsLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[timeLeft] - elapsedTime;

					if (secondsLeft <= maximumTime and secondsLeft > 0) then
						-- hsp is the HSP with the lowest priced item still in the auction, nshp is the next highest price.
						local hsp, seenCount, x, x, nhsp = Auctioneer.Statistic.GetHSP(itemKey, auctKey, buyoutValues);
						local profit = (hsp * count) - currentBid;
						local profitPricePercent = math.floor((profit / currentBid) * 100);

						if ((minProfit == 0 or profit >= minProfit) and seenCount >= Auctioneer.Core.Constants.MinBuyoutSeenCount and not Auctioneer.Statistic.IsBadResaleChoice(signature)) then
							filterAuction = false;
						end
					end
				end
			end
		end
	end

	return filterAuction;
end

function auctionOwnerFilter(owner, signature)
	local auctKey = Auctioneer.Util.GetAuctionKey();
	local itemCat = Auctioneer.Util.GetCatForSig(signature);
	local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, signature);
	if (snap and snap.owner == owner) then
		return false;
	end
	return true;
end

function competingFilter(minLess, signature, myAuctions)
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	if (count > 1) then buyout = buyout/count; end
	local itemKey = id..":"..rprop..":"..enchant;

	local auctKey = Auctioneer.Util.GetAuctionKey();
	local itemCat = Auctioneer.Util.GetCatForSig(signature);
	local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, signature);
	if (snap and snap.owner ~= UnitName("player")) and
		(myAuctions[itemKey]) and
		(buyout > 0) and
		(buyout+minLess < myAuctions[itemKey]) then
		return false;
	end
	return true;
end

-- filters out all auctions that are not a given percentless than the median for that item.
function percentLessFilter(percentLess, signature, category, minQuality, itemName)
	local filterAuction = true;
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	local itemKey = id .. ":" .. rprop..":"..enchant;
	local auctKey = Auctioneer.Util.GetAuctionKey();

	if (not category) then category = 0 end
	if (not minQuality) then minQuality = 0 end

	if (itemName) then
		local iName
		local oName = string.lower(name)
		local iCount = table.getn(itemName)
		local match = false
		for iPos=1, iCount do
			iName = itemName[iPos]
			if (iName and iName ~= "") then
				local i,j = string.find(oName, string.lower(iName))
				if (i) then match = true end
			end
		end
		if (not match) then return true end
	end

	local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, auctKey)

	if hsp > 0 and seenCount >= Auctioneer.Core.Constants.MinBuyoutSeenCount then
		local profit = (hsp * count) - buyout;
		--see if this auction should not be filtered
		if (buyout > 0 and Auctioneer.Statistic.PercentLessThan(hsp, buyout / count) >= tonumber(percentLess) and profit >= Auctioneer.Core.Constants.MinProfitMargin) then
			local itemCat = Auctioneer.Util.GetCatForKey(itemKey);
			if (category == 0 or itemCat == category) then
				local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, signature);
				if (snap) then
					if (tonumber(snap.quality) >= tonumber(minQuality)) then
						local timeLeft = tonumber(snap.timeLeft);
						local elapsedTime = time() - tonumber(snap.lastSeenTime);
						local secondsLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[timeLeft] - elapsedTime;

						if (secondsLeft > 0) then
							filterAuction = false;
						end
					end
				end
			end
		end
	end

	return filterAuction;
end

-- filters out all auctions that are not below a certain price.
function plainFilter(maxPrice, signature, category, minQuality, itemName)
	local filterAuction = true;
	local id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	local itemKey = id .. ":" .. rprop..":"..enchant;
	local auctKey = Auctioneer.Util.GetAuctionKey();

	if (not category) then category = 0 end
	if (not minQuality) then minQuality = 0 end
	if (not maxPrice or maxPrice == 0) then maxPrice = 100000000 end

	if (itemName) then
		local iName
		local oName = string.lower(name)
		local iCount = table.getn(itemName)
		local match = false
		for iPos=1, iCount do
			iName = itemName[iPos]
			if (iName and iName ~= "") then
				local i,j = string.find(oName, string.lower(iName))
				if (i) then match = true end
			end
		end
		if (not match) then return true end
	end

	if (count and count > 1) then maxPrice = maxPrice * count end

	-- check to see if we need to retrieve the current bid before actually getting it
	local currentBid = min
	if (min <= maxPrice and (not buyout or buyout == 0 or buyout > maxPrice)) then
		local bid = Auctioneer.Statistic.GetCurrentBid(signature);
		if (bid) then currentBid = bid end
	end

	if (currentBid <= maxPrice or (buyout and buyout > 0 and buyout <= maxPrice)) then
		local itemCat = Auctioneer.Util.GetCatForKey(itemKey);
		if (category == 0 or itemCat == category) then
			local snap = Auctioneer.Core.GetSnapshot(auctKey, itemCat, signature);
			if (snap) then
				if (tonumber(snap.quality) >= tonumber(minQuality)) then
					local timeLeft = tonumber(snap.timeLeft);
					local elapsedTime = time() - tonumber(snap.lastSeenTime);
					local secondsLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[timeLeft] - elapsedTime;

					if (secondsLeft > 0) then
						filterAuction = false;
					end
				end
			end
		end
	end

	return filterAuction;
end


--[[
	generic function for querying the snapshot with a filter function that returns true if an auction should be filtered out of the result set.

	@return (array)
		all items in the current snapshot which are not filtered out by the given filter.
		Each entry of the array contains:
		   {snapshotdata, (see Auctioneer.Core.GetSnapshotFromData for details)
		    [signature]   (snapshot signature)
		   }
		If there are no matching entries in the snapshot, the function returns an empty array.
]]
function querySnapshot(filter, param, e1,e2,e3,e4,e5)
	local queryResults = {};
	param = param or "";

	local a;
	local auctKey = Auctioneer.Util.GetAuctionKey();

	if (AuctionConfig and AuctionConfig.snap and AuctionConfig.snap[auctKey]) then
		for itemCat, iData in pairs(AuctionConfig.snap[auctKey]) do
			for auctionSignature, data in pairs(iData) do
				if (not filter(param, auctionSignature, e1,e2,e3,e4,e5)) then
					a = Auctioneer.Core.GetSnapshotFromData(data);
					a.signature = auctionSignature;
					table.insert(queryResults, a);
				end
			end
		end
	end

	return queryResults;
end

-- builds the list of auctions that can be bought and resold for profit
function doBroker(minProfit)
	if not minProfit or minProfit == "" then
		minProfit = Auctioneer.Core.Constants.MinProfitMargin
	elseif (tonumber(minProfit)) then
		minProfit = tonumber(minProfit) * 100
	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), minProfit))
		return
	end

	local output = string.format(_AUCT('FrmtBrokerHeader'), EnhTooltip.GetTextGSC(minProfit));
	Auctioneer.Util.ChatPrint(output);

	local resellableAuctions = querySnapshot(brokerFilter, minProfit);

	-- sort by profit decending
	table.sort(resellableAuctions, Auctioneer.Statistic.ProfitComparisonSort);

	-- output the list of auctions
	local id,rprop,enchant,name,count,min,buyout,uniq,itemKey,hsp,seenCount,profit,output;
	if (resellableAuctions) then
		for pos,a in pairs(resellableAuctions) do
			id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
			itemKey = id .. ":" .. rprop..":"..enchant;
			hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
			profit = (hsp * count) - buyout;
			output = string.format(_AUCT('FrmtBrokerLine'), Auctioneer.Util.ColorTextWhite(count.."x")..a.itemLink, seenCount, EnhTooltip.GetTextGSC(hsp * count), EnhTooltip.GetTextGSC(buyout), EnhTooltip.GetTextGSC(profit));
			Auctioneer.Util.ChatPrint(output);
		end
	end

	Auctioneer.Util.ChatPrint(_AUCT('FrmtBrokerDone'));
end

-- builds the list of auctions that can be bought and resold for profit
function doBidBroker(minProfit)
	if not minProfit or minProfit == "" then
		minProfit = Auctioneer.Core.Constants.MinProfitMargin
	elseif (tonumber(minProfit)) then
		minProfit = tonumber(minProfit) * 100
	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), minProfit))
		return
	end

	local output = string.format(_AUCT('FrmtBidbrokerHeader'), EnhTooltip.GetTextGSC(minProfit));
	Auctioneer.Util.ChatPrint(output);

	local bidWorthyAuctions = querySnapshot(bidBrokerFilter, minProfit, Auctioneer.Core.Constants.TimeLeft.Seconds[Auctioneer.Core.Constants.TimeLeft.Medium]);

	table.sort(bidWorthyAuctions, function(a, b) return (a.timeLeft < b.timeLeft) end);

	-- output the list of auctions
	local id,rprop,enchant, name, count,min,buyout,uniq,itemKey,hsp,seenCount,currentBid,profit,bidText,output;
	if (bidWorthyAuctions) then
		for pos,a in pairs(bidWorthyAuctions) do
			id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
			itemKey = id .. ":" .. rprop..":"..enchant;
			hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
			currentBid = Auctioneer.Statistic.GetCurrentBid(a.signature);
			profit = (hsp * count) - currentBid;

			bidText = _AUCT('FrmtBidbrokerCurbid');
			if (currentBid == min) then
				bidText = _AUCT('FrmtBidbrokerMinbid');
			end
			EnhTooltip.DebugPrint("a", a);

			-- local secondsLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[a.timeLeft] + a.lastSeenTime - time()
			output = string.format(_AUCT('FrmtBidbrokerLine'), Auctioneer.Util.ColorTextWhite(count.."x")..a.itemLink, seenCount, EnhTooltip.GetTextGSC(hsp * count), bidText, EnhTooltip.GetTextGSC(currentBid), EnhTooltip.GetTextGSC(profit), Auctioneer.Util.ColorTextWhite(Auctioneer.Util.GetTimeLeftString(a.timeLeft)));
			Auctioneer.Util.ChatPrint(output);
		end
	end

	Auctioneer.Util.ChatPrint(_AUCT('FrmtBidbrokerDone'));
end

function doCompeting(minLess)
	if not minLess or minLess == "" then
		minLess = Auctioneer.Core.Constants.DefaultCompeteLess * 100
	elseif (tonumber(minLess)) then
		minLess = tonumber(minLess) * 100
	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), minLess))
		return
	end

	local output = string.format(_AUCT('FrmtCompeteHeader'), EnhTooltip.GetTextGSC(minLess));
	Auctioneer.Util.ChatPrint(output);

	local myAuctions = querySnapshot(auctionOwnerFilter, UnitName("player"));
	local myHighestPrices = {}
	local id,rprop,enchant,name,count,min,buyout,uniq,itemKey,competingAuctions,currentBid,buyoutForOne,bidForOne,bidPrice,myBuyout,buyPrice,myPrice,priceLess,lessPrice,output;
	if (myAuctions) then
		for pos,a in pairs(myAuctions) do
			id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
			if (count > 1) then buyout = buyout/count; end
			itemKey = id .. ":" .. rprop..":"..enchant;
			if (not myHighestPrices[itemKey]) or (myHighestPrices[itemKey] < buyout) then
				myHighestPrices[itemKey] = buyout;
			end
		end
	end
	competingAuctions = querySnapshot(competingFilter, minLess, myHighestPrices);

	table.sort(competingAuctions, Auctioneer.Statistic.ProfitComparisonSort);

	-- output the list of auctions
	if (competingAuctions) then
		for pos,a in pairs(competingAuctions) do
			id,rprop,enchant, name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
			itemKey = id .. ":" .. rprop..":"..enchant;
			currentBid = Auctioneer.Statistic.GetCurrentBid(a.signature);

			buyoutForOne = buyout;
			bidForOne = currentBid;
			if (count > 1) then
				buyoutForOne = buyout/count;
				bidForOne = currentBid/count;
			end

			bidPrice = EnhTooltip.GetTextGSC(bidForOne).."ea";
			if (currentBid == min) then
				bidPrice = "No bids ("..bidPrice..")";
			end

			myBuyout = myHighestPrices[itemKey];
			buyPrice = EnhTooltip.GetTextGSC(buyoutForOne).."ea";
			myPrice = EnhTooltip.GetTextGSC(myBuyout).."ea";
			priceLess = myBuyout - buyoutForOne;
			lessPrice = EnhTooltip.GetTextGSC(priceLess);

			output = string.format(_AUCT('FrmtCompeteLine'), Auctioneer.Util.ColorTextWhite(count.."x")..a.itemLink, bidPrice, buyPrice, myPrice, lessPrice);
			Auctioneer.Util.ChatPrint(output);
		end
	end

	Auctioneer.Util.ChatPrint(_AUCT('FrmtCompeteDone'));
end

-- builds the list of auctions that can be bought and resold for profit
function doPercentLess(percentLess)
	if not percentLess or percentLess == "" then percentLess = Auctioneer.Core.Constants.MinPercentLessThanHSP end
	local output = string.format(_AUCT('FrmtPctlessHeader'), percentLess);
	Auctioneer.Util.ChatPrint(output);

	local auctionsBelowHSP = querySnapshot(percentLessFilter, percentLess);

	-- sort by profit based on median
	table.sort(auctionsBelowHSP, Auctioneer.Statistic.ProfitComparisonSort);

	-- output the list of auctions
	local id,rprop,enchant,name,count,buyout,itemKey,hsp,seenCount,profit,output,x;
	if (auctionsBelowHSP) then
		for pos,a in pairs(auctionsBelowHSP) do
			id,rprop,enchant, name, count,x,buyout,x = Auctioneer.Core.GetItemSignature(a.signature);
			itemKey = id ..":"..rprop..":"..enchant;
			hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
			profit = (hsp * count) - buyout;
			output = string.format(_AUCT('FrmtPctlessLine'), Auctioneer.Util.ColorTextWhite(count.."x")..a.itemLink, seenCount, EnhTooltip.GetTextGSC(hsp * count), EnhTooltip.GetTextGSC(buyout), EnhTooltip.GetTextGSC(profit), Auctioneer.Util.ColorTextWhite(Auctioneer.Statistic.PercentLessThan(hsp, buyout / count).."%"));
			Auctioneer.Util.ChatPrint(output);
		end
	end

	Auctioneer.Util.ChatPrint(_AUCT('FrmtPctlessDone'));
end
-- Auctioneer.Filter.
Auctioneer.Filter = {
	BrokerFilter = brokerFilter,
	BidBrokerFilter = bidBrokerFilter,
	AuctionOwnerFilter = auctionOwnerFilter,
	CompetingFilter = competingFilter,
	PercentLessFilter = percentLessFilter,
	PlainFilter = plainFilter,
	QuerySnapshot = querySnapshot,
	DoBroker = doBroker,
	DoBidBroker = doBidBroker,
	DoCompeting = doCompeting,
	DoPercentLess = doPercentLess,
}

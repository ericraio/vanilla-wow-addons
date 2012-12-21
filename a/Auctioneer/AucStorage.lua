--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucStorage.lua 846 2006-05-04 05:10:19Z aradan $

	Auctioneer storage functions.
	Functions that allow auctioneer writing/reading data to/from its savedvariables file.

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
local setHistMed, setSnapMed, getFixedPrice, setFixedPrice, deleteFixedPrice

function setHistMed(auctKey, itemKey, median, count)
	if (not AuctionConfig.stats)					then AuctionConfig.stats = {}						end
	if (not AuctionConfig.stats.histmed)			then AuctionConfig.stats.histmed = {}				end
	if (not AuctionConfig.stats.histmed[auctKey])	then AuctionConfig.stats.histmed[auctKey] = {}		end
	if (not AuctionConfig.stats.histcount)			then AuctionConfig.stats.histcount = {}				end
	if (not AuctionConfig.stats.histcount[auctKey])	then AuctionConfig.stats.histcount[auctKey] = {}	end

	if (not median) or (not count) then
		AuctionConfig.stats.histmed[auctKey][itemKey]   = nil
		AuctionConfig.stats.histcount[auctKey][itemKey] = nil
	elseif (count > 0) and (median > 0) then
		AuctionConfig.stats.histmed[auctKey][itemKey]   = median
		AuctionConfig.stats.histcount[auctKey][itemKey] = count
	else
		AuctionConfig.stats.histmed[auctKey][itemKey]   = 0
		AuctionConfig.stats.histcount[auctKey][itemKey] = 0
	end
	-- Clear HSP cache when median changes
	if (Auctioneer_HSPCache and Auctioneer_HSPCache[auctKey]) then
		Auctioneer_HSPCache[auctKey][itemKey] = nil
	end
end

function setSnapMed(auctKey, itemKey, median, count)
	if (not AuctionConfig.stats)					then AuctionConfig.stats = {}						end
	if (not AuctionConfig.stats.snapmed)			then AuctionConfig.stats.snapmed = {}				end
	if (not AuctionConfig.stats.snapmed[auctKey])	then AuctionConfig.stats.snapmed[auctKey] = {}		end
	if (not AuctionConfig.stats.snapcount)			then AuctionConfig.stats.snapcount = {}				end
	if (not AuctionConfig.stats.snapcount[auctKey])	then AuctionConfig.stats.snapcount[auctKey] = {}	end

	if (not median) or (not count) then
		AuctionConfig.stats.snapmed[auctKey][itemKey]   = nil
		AuctionConfig.stats.snapcount[auctKey][itemKey] = nil
	elseif (count > 0) and (median > 0) then
		AuctionConfig.stats.snapmed[auctKey][itemKey]   = median
		AuctionConfig.stats.snapcount[auctKey][itemKey] = count
	else
		AuctionConfig.stats.snapmed[auctKey][itemKey]   = 0
		AuctionConfig.stats.snapcount[auctKey][itemKey] = 0
	end
	-- Clear HSP cache when median changes
	if (Auctioneer_HSPCache and Auctioneer_HSPCache[auctKey]) then
		Auctioneer_HSPCache[auctKey][itemKey] = nil
	end
end

function getFixedPrice(itemKey, count, auctKey)
	if (auctKey == nil) then
		auctKey = Auctioneer.Util.GetAuctionKey();
	end

	if (not count) then count = 1; end

	local i, j;
	local start, buy, stackSize, dur;
	if (not AuctionConfig or not AuctionConfig.fixedprice) then
		-- No fixed prices stored at all, do nothing
	elseif (auctKey and AuctionConfig.fixedprice[auctKey] and AuctionConfig.fixedprice[auctKey][itemKey]) then
		-- Get fixed price for this realm/faction
		i,j, start,buy,stackSize,dur = string.find(AuctionConfig.fixedprice[auctKey][itemKey], "(%d+):(%d+):(%d+):(%d+)");
	elseif (AuctionConfig.fixedprice["global"] and AuctionConfig.fixedprice["global"][itemKey]) then
		-- Get global fixed price
		i,j, start,buy,stackSize,dur = string.find(AuctionConfig.fixedprice["global"][itemKey], "(%d+):(%d+):(%d+):(%d+)");
	end

	-- Return nil when no fixed price is found
	if (not i) then	return nil;	end

	-- Calculate and return prices for desired stack size
	if (not stackSize) then stackSize = 1; end
	return Auctioneer.Util.Round(start*count/stackSize), Auctioneer.Util.Round(buy*count/stackSize), tonumber(dur);
end

function setFixedPrice(itemKey, startingBid, buyout, duration, count, auctKey)
	if (auctKey == nil) then
		auctKey = Auctioneer.Util.GetAuctionKey();
	elseif (auctKey == false) then
		auctKey = "global";
	end

	if (not count) then count = 1; end

	-- Check if any of the data actually changed, to avoid drifting prices when
	-- auctioned with different stack sizes
	oldStart, oldBuyout, oldDur = getFixedPrice(itemKey, count, auctKey);
	if (oldStart == startingBid and oldBuyout == buyout and oldDur == duration) then return; end

	-- Create table structure for storage if needed
	if (not AuctionConfig) then AuctionConfig = {}; end
	if (not AuctionConfig.fixedprice) then AuctionConfig.fixedprice = {}; end
	if (not AuctionConfig.fixedprice[auctKey]) then AuctionConfig.fixedprice[auctKey] = {}; end

	-- Store the new fixed price
	AuctionConfig.fixedprice[auctKey][itemKey] = string.format("%d:%d:%d:%d", startingBid, buyout, count, duration)
end

function deleteFixedPrice(itemKey, auctKey)
	if (auctKey == nil) then
		auctKey = Auctioneer.Util.GetAuctionKey();
	end

	-- No fixed prices, we're done here
	if (not AuctionConfig or not AuctionConfig.fixedprice) then return; end

	-- Delete realm/faction specific fixed price
	if (auctKey and AuctionConfig.fixedprice[auctKey]) then
		AuctionConfig.fixedprice[auctKey][itemKey] = nil;
	end

	-- Delete global fixed price
	if (AuctionConfig.fixedprice["global"]) then
		AuctionConfig.fixedprice["global"][itemKey] = nil;
	end
end

Auctioneer.Storage = {
	SetHistMed = setHistMed,
	SetSnapMed = setSnapMed,
	GetFixedPrice = getFixedPrice,
	SetFixedPrice = setFixedPrice,
	DeleteFixedPrice = deleteFixedPrice,
}

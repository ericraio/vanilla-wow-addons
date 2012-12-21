--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucCore.lua 928 2006-07-06 02:25:08Z luke1410 $

	Auctioneer core functions and variables.
	Functions central to the major operation of Auctioneer.

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
local getItemData, getItemDataByID, storeMedianList, loadMedianList, getAuctionPriceItem, saveAuctionPriceItem, getAuctionBuyoutHistory, getAuctionPrices, getItemSignature, getItemCategory, isPlayerMade, getInfo, getSnapshot, getSnapshotFromData, getSnapshotInfo, getSnapshotInfoFromData, saveSnapshot, saveSnapshotInfo, addonLoaded, hookAuctionHouse, lockAndLoad;

--Local variables

-- Counter to count the total number of auctions scanned
local totalAuctionsScannedCount = 0;
local newAuctionsCount = 0;
local oldAuctionsCount = 0;
local defunctAuctionsCount = 0;

-- Temp table that is copied into AHSnapshotItemPrices only when a scan fully completes
local snapshotItemPrices = {};

--Local constants
local maxAllowedFormatInt = 2000000000; -- numbers much greater than this overflow when using format("%d") --MAX_ALLOWED_FORMAT_INT

-- Auction time constants
--Auctioneer.Core.Constants.TimeLeft.
local timeLeft = {
	Short = 1;		--TIME_LEFT_SHORT
	Medium = 2;		--TIME_LEFT_MEDIUM
	Long = 3;		--TIME_LEFT_LONG
	VeryLong = 4;	--TIME_LEFT_VERY_LONG

	Seconds = {		--TIME_LEFT_SECONDS
		[0] = 0,		-- Could expire any second... the current bid is relatively accurate.
		[1] = 1800,		-- If it disappears within 30 mins of last seing it, it was BO'd
		[2] = 7200,		-- Ditto but for 2 hours.
		[3] = 28800,	-- 8 hours.
		[4] = 86400,	-- 24 hours.
	}
}

-- Item quality constants
--Auctioneer.Core.Constants.Quality
local quality = {
	Legendary	=	5;	--QUALITY_LEGENDARY
	Epic		=	4;	--QUALITY_EPIC
	Rare		=	3;	--QUALITY_RARE
	Uncommon	=	2;	--QUALITY_UNCOMMON
	Common		=	1;	--QUALITY_COMMON
	Poor		=	0;	--QUALITY_POOR
}


-- The maximum number of elements we store in our buyout prices history table
local maxBuyoutHistorySize = 35;

-- Min median buyout price for an item to show up in the list of items below median
local minProfitMargin = 5000; --MIN_PROFIT_MARGIN

-- Min median buyout price for an item to show up in the list of items below median
local defaultCompeteLess = 5; --DEFAULT_COMPETE_LESS

-- Min times an item must be seen before it can show up in the list of items below median
local minBuyoutSeenCount = 5; --MIN_BUYOUT_SEEN_COUNT

-- Max buyout price for an auction to display as a good deal item
local maxBuyoutPrice = 800000; --MAX_BUYOUT_PRICE

-- The default percent less, only find auctions that are at a minimum this percent less than the median
local minPercentLessThanHSP = 60; -- 60% default --MIN_PERCENT_LESS_THAN_HSP

-- The minimum profit/price percent that an auction needs to be displayed as a resellable auction
local minProfitPricePercent = 30; -- 30% default --MIN_PROFIT_PRICE_PERCENT

-- The minimum percent of bids placed on an item to be considered an "in-demand" enough item to be traded, this is only applied to Weapons and Armor and Recipies
local minBidPercent = 10; --MIN_BID_PERCENT

-- categories that the brokers and HSP look at the bid data for
--  1 = weapon
--  2 = armor
--  3 = container
--  4 = dissipatable
--  5 = tradeskillitems
--  6 = projectile
--  7 = quiver
--  8 = recipe
--  9 = reagence
-- 10 = miscellaneous
local bidBasedCategories = {[1]=true, [2]=true, [8]=true, [10]=true} --BID_BASED_CATEGORIES

--[[ SavedVariables --]]
AuctionConfig = {};			--Table that stores config settings
Auction_DoneItems = {};		--Table to keep a record of auction items that have been scanned
AuctionBackup = {}			--Table to backup old data which can't be converted at once
AuctionConfig.version = 30200;

-- Table to store our cached HSP values (since they're expensive to calculate)
Auctioneer_HSPCache = {};
Auctioneer_Lowests = {};

-- Default filter configuration
local filterDefaults = { --Auctioneer_FilterDefaults
	["all"]						=	"on",
	["autofill"]				=	"on",
	["embed"]					=	"off",
	["also"]					=	"off",
	["auction-click"]			=	"on",
	["show-link"]				=	"off",
	["show-embed-blankline"]	=	"off",
	["show-verbose"]			=	"on",
	["show-stats"]				=	"on",
	["show-average"]			=	"on",
	["show-median"]				=	"on",
	["show-suggest"]			=	"on",
	["show-warning"]			=	"on",
	["scan-class1"]				=	"on",
	["scan-class2"]				=	"on",
	["scan-class3"]				=	"on",
	["scan-class4"]				=	"on",
	["scan-class5"]				=	"on",
	["scan-class6"]				=	"on",
	["scan-class7"]				=	"on",
	["scan-class8"]				=	"on",
	["scan-class9"]				=	"on",
	["scan-class10"]			=	"on",
	["warn-color"]				=	"on",
	["printframe"]				=	1,
	["last-auction-duration"]	=	1440,
	["auction-duration"]		=	3,
	["protect-window"]			=	1,
	["finish"]					=	0,
	["pct-bidmarkdown"]			=	20,
	["pct-markup"]				=	300,
	["pct-maxless"]				=	30,
	["pct-nocomp"]				=	2,
	["pct-underlow"]			=	5,
	["pct-undermkt"]			=	20,
	["locale"]					=	"default",

	--AskPrice related commands
	["askprice"]				=	"on",
	["askprice-vendor"]			=	"off",
	["askprice-guild"]			=	"off",
	["askprice-party"]			=	"off",
	["askprice-smart"]			=	"off",
	["askprice-trigger"]		=	"?",
	["askprice-ad"]				=	"on",

	-- Auction House tab UI
	["bid-limit"]				=	1,
	["update-price"]			=	"off",
}

function getItemData(itemKey)
	local itemID, itemRand, enchant = Auctioneer.Util.BreakItemKey(itemKey);
	if (Informant) then
		return Informant.GetItem(itemID);
	end
	return nil;
end

function getItemDataByID(itemID)
	if (Informant) then
		return Informant.GetItem(itemID);
	end
	return nil;
end

function storeMedianList(list)
	local hist = "";
	local function GrowList(last, n)
		if (n == 1) then
			if (hist == "") then hist = last;
			else hist = string.format("%s:%d", hist, last); end
		elseif (n ~= 0) then
			if (hist == "") then hist = string.format("%dx%d", last, n);
			else hist = string.format("%s:%dx%d", hist, last, n); end
		end
	end
	local n = 0;
	local last = 0;
	for pos, hPrice in pairs(list) do
		if (pos == 1) then
			last = hPrice;
		elseif (hPrice ~= last) then
			GrowList(last, n)
			last = hPrice;
			n = 0;
		end
		n = n + 1
	end
	GrowList(last, n)
	return hist;
end

function loadMedianList(str)
	local splut = {};
	if (str) then
		for x,c in string.gfind(str, '([^%:]*)(%:?)') do
			local _,_,y,n = string.find(x, '(%d*)x(%d*)')
			if (y == nil) then
				table.insert(splut, tonumber(x));
			else
				for i = 1,n do
					table.insert(splut, tonumber(y));
				end
			end
			if (c == '') then break end
		end
	end
	return splut;
end

-- Returns an AuctionConfig.data item from the table based on an item name
function getAuctionPriceItem(itemKey, from)
	local serverFaction;
	local auctionPriceItem, data,info;

	if (from ~= nil) then serverFaction = from;
	else serverFaction = Auctioneer.Util.GetAuctionKey(); end;

	EnhTooltip.DebugPrint("Getting data from/for", serverFaction, itemKey);
	if (AuctionConfig.data == nil) then AuctionConfig.data = {}; end
	if (AuctionConfig.info == nil) then AuctionConfig.info = {}; end
	if (AuctionConfig.data[serverFaction] == nil) then
		EnhTooltip.DebugPrint("Data from serverfaction is nil");
		AuctionConfig.data[serverFaction] = {};
	else
		data = AuctionConfig.data[serverFaction][itemKey];
		info = AuctionConfig.info[itemKey];
	end

	auctionPriceItem = {};
	if (data) then
		local dataItem = Auctioneer.Util.Split(data, "|");
		auctionPriceItem.data = dataItem[1];
		auctionPriceItem.buyoutPricesHistoryList = loadMedianList(dataItem[2]);
	end
	if (info) then
		local infoItem = Auctioneer.Util.Split(info, "|");
		auctionPriceItem.category = infoItem[1];
		auctionPriceItem.name = infoItem[2];
	end

	local playerMade, reqSkill, reqLevel = isPlayerMade(itemKey);
	auctionPriceItem.playerMade = playerMade;
	auctionPriceItem.reqSkill = reqSkill;
	auctionPriceItem.reqLevel = reqLevel;

	return auctionPriceItem;
end

function saveAuctionPriceItem(auctKey, itemKey, iData)
	if (not auctKey) then return end
	if (not itemKey) then return end
	if (not iData) then return end

	if (not AuctionConfig.info) then AuctionConfig.info = {}; end
	if (not AuctionConfig.data) then AuctionConfig.data = {}; end
	if (not AuctionConfig.data[auctKey]) then AuctionConfig.data[auctKey] = {}; end

	local hist = storeMedianList(iData.buyoutPricesHistoryList);

	AuctionConfig.data[auctKey][itemKey] = string.format("%s|%s", iData.data, hist);
	AuctionConfig.info[itemKey] = string.format("%s|%s", iData.category, iData.name);
	Auctioneer_Lowests = nil;

	-- save median to the savedvariablesfile
	Auctioneer.Storage.SetHistMed(auctKey, itemKey, Auctioneer.Statistic.GetMedian(iData.buyoutPricesHistoryList))
end

-- Returns the auction buyout history for this item
function getAuctionBuyoutHistory(itemKey, auctKey)
	local auctionItem = getAuctionPriceItem(itemKey, auctKey);
	local buyoutHistory = {};
	if (auctionItem) then
		buyoutHistory = auctionItem.buyoutPricesHistoryList;
	end
	return buyoutHistory;
end

-- Returns the parsed auction price data
function getAuctionPrices(priceData)
	if (not priceData) then return 0,0,0,0,0,0,0 end
	local i,j, count,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = string.find(priceData, "^(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)");
	return Auctioneer.Util.NullSafe(count),Auctioneer.Util.NullSafe(minCount),Auctioneer.Util.NullSafe(minPrice),Auctioneer.Util.NullSafe(bidCount),Auctioneer.Util.NullSafe(bidPrice),Auctioneer.Util.NullSafe(buyCount),Auctioneer.Util.NullSafe(buyPrice);
end

-- Parse the data from the auction signature
function getItemSignature(sigData)
	if (not sigData) then return nil end
	for id,rprop,enchant,name,count,min,buyout,uniq in string.gfind(sigData, "(%d+):(%d+):(%d+):(.-):(%d+):(.-):(%d+):(.+)") do
		if (name == nil) then name = ""; end
		return tonumber(id),tonumber(rprop),tonumber(enchant),name,tonumber(count),tonumber(min),tonumber(buyout),tonumber(uniq);
	end
	return nil;
end

-- Returns the category i.e. 1, 2 for an item
function getItemCategory(itemKey)
	local category;
	local auctionItem = getAuctionPriceItem(itemKey);
	if auctionItem then
		category = auctionItem.category;
	end

	return category;
end

function isPlayerMade(itemKey, itemData)
	if (not itemData) and (Informant) then
		local itemID, itemRand, enchant = Auctioneer.Util.BreakItemKey(itemKey)
		itemData = Informant.GetItem(itemID)
	end

	local reqSkill = 0
	local reqLevel = 0
	if (itemData) then
		reqSkill = itemData.reqSkill
		reqLevel = itemData.reqLevel
	end
	return (reqSkill ~= 0), reqSkill, reqLevel
end

function getInfo(itemKey)
	if (not AuctionConfig.info[itemKey]) then return {}; end
	local info = AuctionConfig.info[itemKey];
	local infosplit = Auctioneer.Util.Split(info, "|");
	local cat = tonumber(infosplit[1]);
	local name = infosplit[2];
	return {
		category = cat,
		name = name,
	};
end

function getSnapshot(auctKey, catID, auctSig)
	if (not catID) then catID = 0 end

	if (not AuctionConfig.snap[auctKey]) then
		AuctionConfig.snap[auctKey] = {};
	end
	if (not AuctionConfig.snap[auctKey][catID]) then
		AuctionConfig.snap[auctKey][catID] = {};
	end
	if (not AuctionConfig.snap[auctKey][catID][auctSig]) then
		return nil;
	end

	local snap = AuctionConfig.snap[auctKey][catID][auctSig];
	return getSnapshotFromData(snap);
end

function getSnapshotFromData(snap)
	if (not snap) then return nil end

	for dirty,bid,level,quality,left,fseen,last,link,owner in string.gfind(snap, "(%d+);(%d+);(%d+);(%d+);(%d+);(%d+);(%d+);([^;]+);(.+)") do
		return {
			bidamount = tonumber(bid),
			owner = owner,
			dirty = dirty,
			lastSeenTime = tonumber(last),
			itemLink = link,
			category = cat,
			initialSeenTime = tonumber(fseen),
			level = level,
			timeLeft = tonumber(left),
			quality = quality,
		};
	end
	return nil;
end

function getSnapshotInfo(auctKey, itemKey)
	if (not AuctionConfig.sbuy) then AuctionConfig.sbuy = {}; end
	if (not AuctionConfig.sbuy[auctKey]) then AuctionConfig.sbuy[auctKey] = {}; end
	if (not AuctionConfig.sbuy[auctKey][itemKey]) then return nil; end

	local buy = AuctionConfig.sbuy[auctKey][itemKey];
	return getSnapshotInfoFromData(buy);
end

function getSnapshotInfoFromData(buy)
	local buysplit = loadMedianList(buy);
	return {
		buyoutPrices = buysplit,
	};
end

function saveSnapshot(auctKey, cat, sig, iData)
	local bid = iData.bidamount;
	local owner = iData.owner;
	local dirty = iData.dirty;
	local last = iData.lastSeenTime;
	local link = iData.itemLink;
	local fseen = iData.initialSeenTime;
	local level = iData.level;
	local left = iData.timeLeft;
	local qual = iData.quality;

	if (not cat) then cat = 0 end

	if (not AuctionConfig.snap[auctKey]) then
		AuctionConfig.snap[auctKey] = {};
	end
	if (not AuctionConfig.snap[auctKey][cat]) then
		AuctionConfig.snap[auctKey][cat] = {};
	end
	if (dirty~=nil and bid~=nil and level~=nil and qual~=nil and left~=nil and fseen~=nil and last~=nil and link~=nil and owner~=nil) then
		local saveData = string.format("%d;%d;%d;%d;%d;%d;%d;%s;%s", dirty, bid, level, qual, left, fseen, last, link, owner);
		EnhTooltip.DebugPrint("Saving", auctKey, cat, sig, "as", saveData);
		AuctionConfig.snap[auctKey][cat][sig] = saveData;
		local itemKey = Auctioneer.Util.GetKeyFromSig(sig);
		Auctioneer_Lowests = nil;
		Auctioneer.Storage.SetSnapMed(auctKey, itemKey, nil)
	else
		EnhTooltip.DebugPrint("Not saving", auctKey, cat, sig, "because", dirty, bid, level, qual, left, fseen, last, link, owner);
	end
end

function saveSnapshotInfo(auctKey, itemKey, iData)
	AuctionConfig.sbuy[auctKey][itemKey] = storeMedianList(iData.buyoutPrices);
	Auctioneer_Lowests = nil;

	Auctioneer.Storage.SetSnapMed(auctKey, itemKey, Auctioneer.Statistic.GetMedian(iData.buyoutPrices))
end


function addonLoaded()
	-- Load the category and subcategory id's
	Auctioneer.Util.LoadCategories();

	Auctioneer.Util.SetFilterDefaults();

	if (not AuctionConfig.version) then AuctionConfig.version = 30000; end
	if (AuctionConfig.version < 30600) then
		StaticPopupDialogs["CONVERT_AUCTIONEER"] = {
			text = _AUCT('MesgConvert'),
			button1 = _AUCT('MesgConvertYes'),
			button2 = _AUCT('MesgConvertNo'),
			OnAccept = function()
				Auctioneer.Convert.Convert();
			end,
			OnCancel = function()
				Auctioneer.Util.ChatPrint(_AUCT('MesgNotconverting'));
			end,
			timeout = 0,
			whileDead = 1,
			exclusive = 1
		};
		StaticPopup_Show("CONVERT_AUCTIONEER", "","");
	end

	lockAndLoad();
end

-- This is the old (local) hookAuctionHouse() function
function hookAuctionHouse()
	Stubby.RegisterEventHook("NEW_AUCTION_UPDATE", "Auctioneer", Auctioneer.Scanner.NewAuction);
	Stubby.RegisterFunctionHook("AuctionFrame_Show", 200, Auctioneer.Scanner.AuctHouseShow);
	Stubby.RegisterEventHook("AUCTION_HOUSE_CLOSED", "Auctioneer", Auctioneer.Scanner.AuctHouseClose);
	Stubby.RegisterEventHook("AUCTION_ITEM_LIST_UPDATE", "Auctioneer", Auctioneer.Scanner.AuctHouseUpdate);

	Stubby.RegisterFunctionHook("Auctioneer.Event.StartAuctionScan", 200, Auctioneer.Scanner.AuctionStartHook);
	Stubby.RegisterFunctionHook("Auctioneer.Event.ScanAuction", 200, Auctioneer.Scanner.AuctionEntryHook);
	Stubby.RegisterFunctionHook("Auctioneer.Event.FinishedAuctionScan", 200, Auctioneer.Scanner.FinishedAuctionScanHook);

	Stubby.RegisterFunctionHook("StartAuction", 200, Auctioneer.Scanner.StartAuction)
	Stubby.RegisterFunctionHook("PlaceAuctionBid", 200, Auctioneer.Scanner.PlaceAuctionBid)
	Stubby.RegisterFunctionHook("FilterButton_SetType", 200, Auctioneer.Scanner.FilterButtonSetType);
	Stubby.RegisterFunctionHook("AuctionFrameFilters_UpdateClasses", 200, Auctioneer.Scanner.AuctionFrameFiltersUpdateClasses);
	Stubby.RegisterFunctionHook("AuctionsRadioButton_OnClick", 200, Auctioneer.Scanner.OnChangeAuctionDuration);

end

function lockAndLoad()
	Stubby.RegisterFunctionHook("AuctionFrame_LoadUI", 200, Auctioneer.Scanner.ConfigureAH);
	Stubby.RegisterFunctionHook("ContainerFrameItemButton_OnClick", -200, Auctioneer.Util.ContainerFrameItemButtonOnClick);

	SLASH_AUCTIONEER1 = "/auctioneer";
	SLASH_AUCTIONEER2 = "/auction";
	SLASH_AUCTIONEER3 = "/auc";
	SlashCmdList["AUCTIONEER"] = function(msg)
		Auctioneer.Command.MainHandler(msg);
	end

	-- Rearranges elements in the AH window.
	Auctioneer.Scanner.ConfigureAH();

	--GUI Registration code added by MentalPower
	Auctioneer.Command.Register();

	--Init AskPrice
	Auctioneer.AskPrice.Init();
--[[
	--Register Auctioneer with Babylonian
	if not Babylonian.IsAddOnRegistered("Auctioneer") then
		Babylonian.RegisterAddOn("Auctioneer", Auctioneer.Command.SetLocale);
	end
]]
	Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtWelcome'), Auctioneer.Version), 0.8, 0.8, 0.2);
end

Auctioneer.Core = {
	Variables = {},
	Constants = {},
	GetItemData = getItemData,
	GetItemDataByID = getItemDataByID,
	StoreMedianList = storeMedianList,
	LoadMedianList = loadMedianList,
	GetAuctionPriceItem = getAuctionPriceItem,
	SaveAuctionPriceItem = saveAuctionPriceItem,
	GetAuctionBuyoutHistory = getAuctionBuyoutHistory,
	GetAuctionPrices = getAuctionPrices,
	GetItemSignature = getItemSignature,
	GetItemCategory = getItemCategory,
	IsPlayerMade = isPlayerMade,
	GetInfo = getInfo,
	GetSnapshot = getSnapshot,
	GetSnapshotFromData = getSnapshotFromData,
	GetSnapshotInfo = getSnapshotInfo,
	GetSnapshotInfoFromData = getSnapshotInfoFromData,
	SaveSnapshot = saveSnapshot,
	SaveSnapshotInfo = saveSnapshotInfo,
	AddonLoaded = addonLoaded,
	HookAuctionHouse = hookAuctionHouse,
	LockAndLoad = lockAndLoad,
}

Auctioneer.Core.Variables = {
	TotalAuctionsScannedCount = totalAuctionsScannedCount,
	NewAuctionsCount = newAuctionsCount,
	OldAuctionsCount = oldAuctionsCount,
	DefunctAuctionsCount = defunctAuctionsCount,
	SnapshotItemPrices = snapshotItemPrices,
}

Auctioneer.Core.Constants = {
	MaxAllowedFormatInt = maxAllowedFormatInt,
	TimeLeft = timeLeft,
	Quality = quality,
	MaxBuyoutHistorySize = maxBuyoutHistorySize,
	MinProfitMargin = minProfitMargin,
	DefaultCompeteLess = defaultCompeteLess,
	MinBuyoutSeenCount = minBuyoutSeenCount,
	MaxBuyoutPrice = maxBuyoutPrice,
	MinPercentLessThanHSP = minPercentLessThanHSP,
	MinProfitPricePercent = minProfitPricePercent,
	MinBidPercent = minBidPercent,
	BidBasedCategories = bidBasedCategories,
	FilterDefaults = filterDefaults,
}

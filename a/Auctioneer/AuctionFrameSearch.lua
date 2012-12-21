--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AuctionFrameSearch.lua 857 2006-05-11 01:21:25Z luke1410 $

	Auctioneer Search Auctions tab

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
--]]

local TIME_LEFT_NAMES =
{
	AUCTION_TIME_LEFT1, -- Short
	AUCTION_TIME_LEFT2, -- Medium
	AUCTION_TIME_LEFT3, -- Long
	AUCTION_TIME_LEFT4  -- Very Long
};

local AUCTION_STATUS_UNKNOWN = 1;
local AUCTION_STATUS_HIGH_BIDDER = 2;
local AUCTION_STATUS_NOT_FOUND = 3;
local AUCTION_STATUS_BIDDING = 4;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_OnLoad()
	-- Methods
	this.SearchBids = AuctionFrameSearch_SearchBids;
	this.SearchBuyouts = AuctionFrameSearch_SearchBuyouts;
	this.SearchCompetition = AuctionFrameSearch_SearchCompetition;
	this.SearchPlain = AuctionFrameSearch_SearchPlain;
	this.SelectResultByIndex = AuctionFrameSearch_SelectResultByIndex;

	-- Controls
	this.savedSearchDropDown = getglobal(this:GetName().."SavedSearchDropDown");
	this.searchDropDown = getglobal(this:GetName().."SearchDropDown");
	this.bidFrame = getglobal(this:GetName().."Bid");
	this.buyoutFrame = getglobal(this:GetName().."Buyout");
	this.competeFrame = getglobal(this:GetName().."Compete");
	this.plainFrame = getglobal(this:GetName().."Plain");
	this.resultsList = getglobal(this:GetName().."List");
	this.bidButton = getglobal(this:GetName().."BidButton");
	this.buyoutButton = getglobal(this:GetName().."BuyoutButton");
	this.pendingBidStatusText = getglobal(this:GetName().."PendingBidStatusText");

	-- Data members
	this.results = {};
	this.resultsType = nil;
	this.selectedResult = nil;

	-- Initialize the Search drop down
	AuctioneerDropDownMenu_Initialize(this.searchDropDown, AuctionFrameSearch_SearchDropDown_Initialize);
	AuctionFrameSearch_SearchDropDownItem_SetSelectedID(this.searchDropDown, 1);

	-- Configure the logical columns
	this.logicalColumns =
	{
		Quantity =
		{
			title = _AUCT("UiQuantityHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.count end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.count < record2.count end);
			compareDescendingFunc = (function(record1, record2) return record1.count > record2.count end);
		},
		Name =
		{
			title = _AUCT("UiNameHeader");
			dataType = "String";
			valueFunc = (function(record) return record.name end);
			colorFunc = AuctionFrameSearch_GetItemColor;
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.name < record2.name end);
			compareDescendingFunc = (function(record1, record2) return record1.name > record2.name end);
		},
		TimeLeft =
		{
			title = _AUCT("UiTimeLeftHeader");
			dataType = "String";
			valueFunc = (function(record) return Auctioneer.Util.GetTimeLeftString(record.timeLeft) end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.timeLeft < record2.timeLeft end);
			compareDescendingFunc = (function(record1, record2) return record1.timeLeft > record2.timeLeft end);
		},
		Bid =
		{
			title = _AUCT("UiBidHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bid end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bid < record2.bid end);
			compareDescendingFunc = (function(record1, record2) return record1.bid > record2.bid end);
		},
		BidPer =
		{
			title = _AUCT("UiBidPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bidPer end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bidPer < record2.bidPer end);
			compareDescendingFunc = (function(record1, record2) return record1.bidPer > record2.bidPer end);
		},
		Buyout =
		{
			title = _AUCT("UiBuyoutHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyout end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyout < record2.buyout end);
			compareDescendingFunc = (function(record1, record2) return record1.buyout > record2.buyout end);
		},
		BuyoutPer =
		{
			title = _AUCT("UiBuyoutPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyoutPer end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyoutPer < record2.buyoutPer end);
			compareDescendingFunc = (function(record1, record2) return record1.buyoutPer > record2.buyoutPer end);
		},
		Profit =
		{
			title = _AUCT("UiProfitHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.profit end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.profit < record2.profit end);
			compareDescendingFunc = (function(record1, record2) return record1.profit > record2.profit end);
		},
		ProfitPer =
		{
			title = _AUCT("UiProfitPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.profitPer end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.profitPer < record2.profitPer end);
			compareDescendingFunc = (function(record1, record2) return record1.profitPer > record2.profitPer end);
		},
		PercentLess =
		{
			title = _AUCT("UiPercentLessHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.percentLess end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.percentLess < record2.percentLess end);
			compareDescendingFunc = (function(record1, record2) return record1.percentLess > record2.percentLess end);
		},
		ItemLevel =
		{
			title = _AUCT("UiItemLevelHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.level end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.level < record2.level end);
			compareDescendingFunc = (function(record1, record2) return record1.level > record2.level end);
		},
	};

	-- Configure the bid search physical columns
	this.bidSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = this.logicalColumns.Quantity;
			logicalColumns = { this.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 160;
			logicalColumn = this.logicalColumns.Name;
			logicalColumns = { this.logicalColumns.Name };
			sortAscending = true;
		},
		{
			width = 90;
			logicalColumn = this.logicalColumns.TimeLeft;
			logicalColumns = { this.logicalColumns.TimeLeft };
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Bid;
			logicalColumns =
			{
				this.logicalColumns.Bid,
				this.logicalColumns.BidPer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Profit;
			logicalColumns =
			{
				this.logicalColumns.Profit,
				this.logicalColumns.ProfitPer,
				this.logicalColumns.Buyout,
				this.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = this.logicalColumns.PercentLess;
			logicalColumns =
			{
				this.logicalColumns.PercentLess
			};
			sortAscending = true;
		},
	};

	-- Configure the buyout search physical columns
	this.buyoutSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = this.logicalColumns.Quantity;
			logicalColumns = { this.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 250;
			logicalColumn = this.logicalColumns.Name;
			logicalColumns = { this.logicalColumns.Name };
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Buyout;
			logicalColumns =
			{
				this.logicalColumns.Bid,
				this.logicalColumns.BidPer,
				this.logicalColumns.Buyout,
				this.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Profit;
			logicalColumns =
			{
				this.logicalColumns.Bid,
				this.logicalColumns.BidPer,
				this.logicalColumns.Profit,
				this.logicalColumns.ProfitPer
			};
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = this.logicalColumns.PercentLess;
			logicalColumns =
			{
				this.logicalColumns.PercentLess
			};
			sortAscending = true;
		},
	};

	-- Configure the compete search physical columns
	this.competeSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = this.logicalColumns.Quantity;
			logicalColumns = { this.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 250;
			logicalColumn = this.logicalColumns.Name;
			logicalColumns = { this.logicalColumns.Name };
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Bid;
			logicalColumns =
			{
				this.logicalColumns.Bid,
				this.logicalColumns.BidPer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Buyout;
			logicalColumns =
			{
				this.logicalColumns.Buyout,
				this.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = this.logicalColumns.PercentLess;
			logicalColumns =
			{
				this.logicalColumns.PercentLess
			};
			sortAscending = true;
		},
	};

	-- Configure the plain search physical columns
	this.plainSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = this.logicalColumns.Quantity;
			logicalColumns = { this.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 160;
			logicalColumn = this.logicalColumns.Name;
			logicalColumns = { this.logicalColumns.Name };
			sortAscending = true;
		},
		{
			width = 90;
			logicalColumn = this.logicalColumns.TimeLeft;
			logicalColumns = { this.logicalColumns.TimeLeft };
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Bid;
			logicalColumns =
			{
				this.logicalColumns.Bid,
				this.logicalColumns.BidPer,
				this.logicalColumns.Buyout,
				this.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.Buyout;
			logicalColumns =
			{
				this.logicalColumns.Profit,
				this.logicalColumns.ProfitPer,
				this.logicalColumns.Buyout,
				this.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = this.logicalColumns.PercentLess;
			logicalColumns =
			{
				this.logicalColumns.PercentLess,
				this.logicalColumns.ItemLevel
			};
			sortAscending = true;
		},
	};


	-- Initialize the list to show nothing at first.
	ListTemplate_Initialize(this.resultsList, this.results, this.results);
	this:SelectResultByIndex(nil);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_OnShow()
	AuctionFrameSearch_UpdatePendingBidStatus(this);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
AUCTIONEER_SEARCH_TYPES = {}
function AuctionFrameSearch_SearchDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();

	AUCTIONEER_SEARCH_TYPES[1] = _AUCT("UiSearchTypeBids");
	AUCTIONEER_SEARCH_TYPES[2] = _AUCT("UiSearchTypeBuyouts");
	AUCTIONEER_SEARCH_TYPES[3] = _AUCT("UiSearchTypeCompetition");
	AUCTIONEER_SEARCH_TYPES[4] = _AUCT("UiSearchTypePlain");

	for i=1, 4 do
		UIDropDownMenu_AddButton({
			text = AUCTIONEER_SEARCH_TYPES[i],
			func = AuctionFrameSearch_SearchDropDownItem_OnClick,
			owner = dropdown
		})
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_MinQualityDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();

	for i=0, 6 do
		UIDropDownMenu_AddButton({
			text = getglobal("ITEM_QUALITY"..i.."_DESC"),
			func = AuctionFrameSearch_MinQualityDropDownItem_OnClick,
			value = i,
			owner = dropdown
		});
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SavedSearchDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	local frame = dropdown:GetParent();
	local frameName = frame:GetName();
	local text = "";

	if (index > 1) then
		text = this.value
		local searchData = AuctionConfig.SavedSearches[text];
		local searchParams = Auctioneer.Util.Split(searchData, "\t");

		local searchType = tonumber(searchParams[1])
		getglobal(frameName.."SearchDropDown").selectedID = searchType;
		getglobal(frameName.."SearchDropDownText"):SetText(AUCTIONEER_SEARCH_TYPES[searchType]);

		frame.bidFrame:Hide();
		frame.buyoutFrame:Hide();
		frame.competeFrame:Hide();
		frame.plainFrame:Hide();
		if (searchType == 1) then
			-- Bid search
			MoneyInputFrame_SetCopper(getglobal(frameName.."BidMinProfit"), tonumber(searchParams[2]))

			getglobal(frameName.."BidMinPercentLessEdit"):SetText(searchParams[3])

			local timeLeft = tonumber(searchParams[4]) or 2
			AuctioneerDropDownMenu_Initialize(getglobal(frameName.."BidTimeLeftDropDown"), AuctionFrameSearch_TimeLeftDropDown_Initialize);
			AuctioneerDropDownMenu_SetSelectedID(getglobal(frameName.."BidTimeLeftDropDown"), timeLeft);

			local catid = tonumber(searchParams[5]) or 1
			local catName = ""
			if (AuctionConfig.classes[catid-1]) then catName = AuctionConfig.classes[catid-1].name end
			AuctioneerDropDownMenu_Initialize(getglobal(frameName.."BidCategoryDropDown"), AuctionFrameSearch_CategoryDropDown_Initialize);
			AuctioneerDropDownMenu_SetSelectedID(getglobal(frameName.."BidCategoryDropDown"), catid);

			local quality = tonumber(searchParams[6]) or 1
			AuctioneerDropDownMenu_Initialize(getglobal(frameName.."BidMinQualityDropDown"), AuctionFrameSearch_MinQualityDropDown_Initialize);
			AuctioneerDropDownMenu_SetSelectedID(getglobal(frameName.."BidMinQualityDropDown"), quality);

			getglobal(frameName.."BidSearchEdit"):SetText(searchParams[7])

			frame.bidFrame:Show();
		elseif (searchType == 2) then
			-- Buyout search
			MoneyInputFrame_SetCopper(getglobal(frameName.."BuyoutMinProfit"), tonumber(searchParams[2]))

			getglobal(frameName.."BuyoutMinPercentLessEdit"):SetText(searchParams[3])

			local catid = tonumber(searchParams[4]) or 1
			local catName = ""
			if (AuctionConfig.classes[catid-1]) then catName = AuctionConfig.classes[catid-1].name end
			AuctioneerDropDownMenu_Initialize(getglobal(frameName.."BuyoutCategoryDropDown"), AuctionFrameSearch_CategoryDropDown_Initialize);
			AuctioneerDropDownMenu_SetSelectedID(getglobal(frameName.."BuyoutCategoryDropDown"), catid);

			local quality = tonumber(searchParams[5]) or 1
			AuctioneerDropDownMenu_Initialize(getglobal(frameName.."BuyoutMinQualityDropDown"), AuctionFrameSearch_MinQualityDropDown_Initialize);
			AuctioneerDropDownMenu_SetSelectedID(getglobal(frameName.."BuyoutMinQualityDropDown"), quality);

			getglobal(frameName.."BuyoutSearchEdit"):SetText(searchParams[6])

			frame.buyoutFrame:Show();
		elseif (searchType == 3) then
			-- Compete search
			MoneyInputFrame_SetCopper(getglobal(frameName.."CompeteUndercut"), tonumber(searchParams[2]))

			frame.competeFrame:Show();
		elseif (searchType == 4) then
			-- Plain search
			MoneyInputFrame_SetCopper(getglobal(frameName.."PlainMaxPrice"), tonumber(searchParams[2]))

			local catid = tonumber(searchParams[3]) or 1
			local catName = ""
			if (AuctionConfig.classes[catid-1]) then catName = AuctionConfig.classes[catid-1].name end
			AuctioneerDropDownMenu_Initialize(getglobal(frameName.."PlainCategoryDropDownText"), AuctionFrameSearch_CategoryDropDown_Initialize);
			AuctioneerDropDownMenu_SetSelectedID(getglobal(frameName.."PlainCategoryDropDownText"), catid);

			local quality = tonumber(searchParams[4]) or 1
			AuctioneerDropDownMenu_Initialize(getglobal(frameName.."PlainMinQualityDropDown"), AuctionFrameSearch_MinQualityDropDown_Initialize);
			AuctioneerDropDownMenu_SetSelectedID(getglobal(frameName.."PlainMinQualityDropDown"), quality);

			getglobal(frameName.."PlainSearchEdit"):SetText(searchParams[5])

			frame.plainFrame:Show();
		end
	end
	getglobal(frameName.."SaveSearchEdit"):SetText(text);
	AuctioneerDropDownMenu_SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SavedSearchDropDown_Initialize()
	local dropdown = AuctionFrameSearchSavedSearchDropDown
	local frame = dropdown:GetParent()

	if (not AuctionConfig.SavedSearches) then
		UIDropDownMenu_AddButton({
			text = "",
			func = AuctionFrameSearch_SavedSearchDropDownItem_OnClick,
			owner = dropdown
		});
		return
	end

	local savedSearchDropDownElements = {}
	for name, search in pairs(AuctionConfig.SavedSearches) do
		table.insert(savedSearchDropDownElements, name);
	end
	table.sort(savedSearchDropDownElements);

	UIDropDownMenu_AddButton({
		text = "",
		func = AuctionFrameSearch_SavedSearchDropDownItem_OnClick,
		owner = dropdown
	});
	for pos, name in savedSearchDropDownElements do
		UIDropDownMenu_AddButton({
			text = name,
			func = AuctionFrameSearch_SavedSearchDropDownItem_OnClick,
			owner = dropdown
		});
	end
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_MinQualityDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	AuctioneerDropDownMenu_SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	AuctionFrameSearch_SearchDropDownItem_SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchDropDownItem_SetSelectedID(dropdown, index)
	local frame = dropdown:GetParent();
	frame.bidFrame:Hide();
	frame.buyoutFrame:Hide();
	frame.competeFrame:Hide();
	frame.plainFrame:Hide();
	if (index == 1) then
		frame.bidFrame:Show();
	elseif (index == 2) then
		frame.buyoutFrame:Show();
	elseif (index == 3) then
		frame.competeFrame:Show();
	elseif (index == 4) then
		frame.plainFrame:Show();
	end
	AuctioneerDropDownMenu_SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_RemoveSearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();

	local searchName = getglobal(frameName.."SaveSearchEdit"):GetText()
	if (AuctionConfig.SavedSearches) then
		AuctionConfig.SavedSearches[searchName] = nil
	end
	getglobal(frameName.."SaveSearchEdit"):SetText("")
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SaveSearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();
	local searchDropdown = getglobal(frameName.."SearchDropDown")

	local searchType = UIDropDownMenu_GetSelectedID(searchDropdown);
	local searchData = nil
	if (searchType == 1) then
		-- Bid-based search
		searchData = string.format("%d\t%d\t%s\t%d\t%d\t%d\t%s",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."BidMinProfit")),
			getglobal(frameName.."BidMinPercentLessEdit"):GetText(),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BidTimeLeftDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BidCategoryDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BidMinQualityDropDown")),
			getglobal(frameName.."BidSearchEdit"):GetText()
		);
	elseif (searchType == 2) then
		-- Buyout-based search
		searchData = string.format("%d\t%d\t%s\t%d\t%d\t%s",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."BuyoutMinProfit")),
			getglobal(frameName.."BuyoutMinPercentLessEdit"):GetText(),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BuyoutCategoryDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BuyoutMinQualityDropDown")),
			getglobal(frameName.."BuyoutSearchEdit"):GetText()
		);
	elseif (searchType == 3) then
		-- Compete-based search
		searchData = string.format("%d\t%d",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."CompeteUndercut"))
		);
	elseif (searchType == 4) then
		-- Plain-based search
		searchData = string.format("%d\t%d\t%d\t%d\t%s",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."PlainMaxPrice")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."PlainCategoryDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."PlainMinQualityDropDown")),
			getglobal(frameName.."PlainSearchEdit"):GetText()
		);
	end

	if (searchData) then
		local searchName = getglobal(frameName.."SaveSearchEdit"):GetText()
		if (not AuctionConfig.SavedSearches) then
			AuctionConfig.SavedSearches = {}
		end

		AuctionConfig.SavedSearches[searchName] = searchData
	end
end

-------------------------------------------------------------------------------
-- The Bid button has been clicked
-------------------------------------------------------------------------------
function AuctionFrameSearch_BidButton_OnClick(button)
	local frame = button:GetParent();
	local result = frame.selectedResult;
	if (result and result.name and result.count and result.bid) then
		result.status = AUCTION_STATUS_BIDDING;
		result.pendingBidCount = result.pendingBidCount + 1;
		local bidLimit = Auctioneer.Command.GetFilterVal('bid-limit');
		local context = { frame = frame, auction = result };
		AucBidManager.BidAuction(result.bid, result.signature, bidLimit, AuctionFrameSearch_OnBidResult, context);
		AuctionFrameSearch_UpdateButtons(frame);
		AuctionFrameSearch_UpdatePendingBidStatus(frame);
		ListTemplateScrollFrame_Update(getglobal(frame.resultsList:GetName().."ScrollFrame"));
	end
end

-------------------------------------------------------------------------------
-- The Buyout button has been clicked.
-------------------------------------------------------------------------------
function AuctionFrameSearch_BuyoutButton_OnClick(button)
	local frame = button:GetParent();
	local result = frame.selectedResult;
	if (result and result.name and result.count and result.buyout) then
		result.status = AUCTION_STATUS_BIDDING;
		result.pendingBidCount = result.pendingBidCount + 1;
		local bidLimit = Auctioneer.Command.GetFilterVal('bid-limit');
		local context = { frame = frame, auction = result };
		AucBidManager.BidAuction(result.buyout, result.signature, bidLimit, AuctionFrameSearch_OnBidResult, context);
		AuctionFrameSearch_UpdateButtons(frame);
		AuctionFrameSearch_UpdatePendingBidStatus(frame);
		ListTemplateScrollFrame_Update(getglobal(frame.resultsList:GetName().."ScrollFrame"));
	end
end

-------------------------------------------------------------------------------
-- Updates the pending bid status text
-------------------------------------------------------------------------------
function AuctionFrameSearch_UpdatePendingBidStatus(frame)
	local count = AucBidManager.GetRequestCount();
	if (count == 1) then
		frame.pendingBidStatusText:SetText(_AUCT('UiPendingBidInProgress'));
	elseif (count > 1) then
		local output = string.format(_AUCT('UiPendingBidsInProgress'), count);
		frame.pendingBidStatusText:SetText(output);
	elseif (frame.pendingBidStatusText:GetText() ~= "") then
		frame.pendingBidStatusText:SetText(_AUCT('UiNoPendingBids'));
	end
end

-------------------------------------------------------------------------------
-- Returns the item color for the specified result
-------------------------------------------------------------------------------
function AuctionFrameSearch_GetItemColor(result)
	_, _, rarity = GetItemInfo(result.item);
	if (rarity) then
		return ITEM_QUALITY_COLORS[rarity];
	end
	return { r = 1.0, g = 1.0, b = 1.0 };
end

-------------------------------------------------------------------------------
-- Perform a bid search (aka bidBroker)
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchBids(frame, minProfit, minPercentLess, maxTimeLeft, category, minQuality, itemName)
	-- Create the content from auctioneer.
	frame.results = {};
	local itemNames = Auctioneer.Util.Split(itemName, "|");
	local bidWorthyAuctions = Auctioneer.Filter.QuerySnapshot(Auctioneer.Filter.BidBrokerFilter, minProfit, maxTimeLeft, category, minQuality, itemNames);
	if (bidWorthyAuctions) then
		local player = UnitName("player");
		for pos,a in pairs(bidWorthyAuctions) do
			if (a.owner ~= player) then
				local id,rprop,enchant,name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
				local itemKey = id .. ":" .. rprop..":"..enchant;
				local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
				local currentBid = Auctioneer.Statistic.GetCurrentBid(a.signature);
				-- rounding down the hsp, to get a better selling price
				local hspBuyout = Auctioneer.Statistic.RoundDownTo95(hsp * count);
				local percentLess = 100 - math.floor(100 * currentBid / (hspBuyout));
				if (percentLess >= minPercentLess) then
					local auction = {};
					auction.id = id;
					auction.item = string.format("item:%s:%s:%s:0", id, enchant, rprop);
					auction.link = a.itemLink;
					auction.name = name;
					auction.count = count;
					auction.owner = a.owner;
					auction.timeLeft = a.timeLeft;
					auction.bid = currentBid;
					auction.bidPer = math.floor(auction.bid / count);
					auction.buyout = buyout;
					auction.buyoutPer = math.floor(auction.buyout / count);
					auction.profit = hspBuyout - currentBid;
					auction.profitPer = math.floor(auction.profit / count);
					auction.percentLess = percentLess;
					auction.signature = a.signature;
					if (a.highBidder) then
						auction.status = AUCTION_STATUS_HIGH_BIDDER;
					else
						auction.status = AUCTION_STATUS_UNKNOWN;
					end
					auction.pendingBidCount = 0;
					table.insert(frame.results, auction);
				end
			end
		end
	end

	-- Hand the updated results to the list.
	frame.resultsType = "BidSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.bidSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
	ListTemplate_Sort(frame.resultsList, 2);
	ListTemplate_Sort(frame.resultsList, 3);
end

-------------------------------------------------------------------------------
-- Perform a buyout search (aka percentLess)
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchBuyouts(frame, minProfit, minPercentLess, category, minQuality, itemName)
	-- Create the content from auctioneer.
	frame.results = {};
	local itemNames = Auctioneer.Util.Split(itemName, "|");
	local buyoutWorthyAuctions = Auctioneer.Filter.QuerySnapshot(Auctioneer.Filter.PercentLessFilter, minPercentLess, category, minQuality, itemNames);
	if (buyoutWorthyAuctions) then
		local player = UnitName("player");
		for pos,a in pairs(buyoutWorthyAuctions) do
			if (a.owner ~= player) then
				local id,rprop,enchant,name,count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
				local itemKey = id .. ":" .. rprop..":"..enchant;
				local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
				-- rounding down the hsp, to get a better selling price
				local hspBuyout = Auctioneer.Statistic.RoundDownTo95(hsp * count);
				local profit = hspBuyout - buyout;
				if (profit >= minProfit) then
					local auction = {};
					auction.id = id;
					auction.item = string.format("item:%s:%s:%s:0", id, enchant, rprop);
					auction.link = a.itemLink;
					auction.name = name;
					auction.count = count;
					auction.owner = a.owner;
					auction.timeLeft = a.timeLeft;
					auction.buyout = buyout;
					auction.buyoutPer = math.floor(auction.buyout / count);
					auction.profit = profit;
					auction.profitPer = math.floor(auction.profit / count);
					auction.percentLess = 100 - math.floor(100 * buyout / hspBuyout);
					auction.signature = a.signature;
					if (a.highBidder) then
						auction.status = AUCTION_STATUS_HIGH_BIDDER;
					else
						auction.status = AUCTION_STATUS_UNKNOWN;
					end
					auction.pendingBidCount = 0;
					table.insert(frame.results, auction);
				end
			end
		end
	end

	-- Hand the updated content to the list.
	frame.resultsType = "BuyoutSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.buyoutSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
	ListTemplate_Sort(frame.resultsList, 5);
end

-------------------------------------------------------------------------------
-- Perform a competition search (aka compete)
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchCompetition(frame, minUndercut)
	-- Create the content from auctioneer.
	frame.results = {};

	-- Get the highest prices for my auctions.
	local myAuctions = Auctioneer.Filter.QuerySnapshot(Auctioneer.Filter.AuctionOwnerFilter, UnitName("player"));
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

	-- Search for competing auctions less than mine.
	competingAuctions = Auctioneer.Filter.QuerySnapshot(Auctioneer.Filter.CompetingFilter, minUndercut, myHighestPrices);
	if (competingAuctions) then
		table.sort(competingAuctions, Auctioneer.Statistic.ProfitComparisonSort);
		for pos,a in pairs(competingAuctions) do
			local id,rprop,enchant,name,count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
			local itemKey = id .. ":" .. rprop..":"..enchant;
			local myBuyout = myHighestPrices[itemKey];
			local currentBid = Auctioneer.Statistic.GetCurrentBid(a.signature);

			local auction = {};
			auction.id = id;
			auction.item = string.format("item:%s:%s:%s:0", id, enchant, rprop);
			auction.link = a.itemLink;
			auction.name = name;
			auction.count = count;
			auction.owner = a.owner;
			auction.timeLeft = a.timeLeft;
			auction.bid = currentBid;
			auction.bidPer = math.floor(auction.bid / count);
			auction.buyout = buyout;
			auction.buyoutPer = math.floor(auction.buyout / count);
			auction.percentLess = math.floor(((myBuyout - auction.buyoutPer) / myBuyout) * 100);
			auction.signature = a.signature;
			if (a.highBidder) then
				auction.status = AUCTION_STATUS_HIGH_BIDDER;
			else
				auction.status = AUCTION_STATUS_UNKNOWN;
			end
			auction.pendingBidCount = 0;
			table.insert(frame.results, auction);
		end
	end

	-- Hand the updated content to the list.
	frame.resultsType = "CompeteSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.competeSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
end

-------------------------------------------------------------------------------
-- Perform a plain search
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchPlain(frame, maxPrice, category, minQuality, itemName)
	-- Create the content from auctioneer.
	frame.results = {};
	local itemNames = Auctioneer.Util.Split(itemName, "|");
	local bidWorthyAuctions = Auctioneer.Filter.QuerySnapshot(Auctioneer.Filter.PlainFilter, maxPrice, category, minQuality, itemNames);
	if (bidWorthyAuctions) then
		local player = UnitName("player");
		for pos,a in pairs(bidWorthyAuctions) do
			if (a.owner ~= player) then
				local id,rprop,enchant,name, count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
				local itemKey = id .. ":" .. rprop..":"..enchant;
				local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
				local currentBid = Auctioneer.Statistic.GetCurrentBid(a.signature);
				-- rounding down the hsp, to get a better selling price
				local hspBuyout = Auctioneer.Statistic.RoundDownTo95(hsp * count);
				local percentLess = 100 - math.floor(100 * currentBid / hspBuyout);

				local _,_,_,iLevel = GetItemInfo(id);

				local auction = {};
				auction.id = id;
				auction.item = string.format("item:%s:%s:%s:0", id, enchant, rprop);
				auction.link = a.itemLink;
				auction.level = iLevel;
				auction.name = name;
				auction.count = count;
				auction.owner = a.owner;
				auction.timeLeft = a.timeLeft;
				auction.bid = currentBid;
				auction.bidPer = math.floor(auction.bid / count);
				auction.buyout = buyout;
				auction.buyoutPer = math.floor(auction.buyout / count);
				auction.profit = hspBuyout - currentBid;
				auction.profitPer = math.floor(auction.profit / count);
				auction.percentLess = percentLess;
				auction.signature = a.signature;
				if (a.highBidder) then
					auction.status = AUCTION_STATUS_HIGH_BIDDER;
				else
					auction.status = AUCTION_STATUS_UNKNOWN;
				end
				auction.pendingBidCount = 0;
				table.insert(frame.results, auction);
			end
		end
	end

	-- Hand the updated results to the list.
	frame.resultsType = "PlainSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.plainSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
	ListTemplate_Sort(frame.resultsList, 2);
	ListTemplate_Sort(frame.resultsList, 3);
end


-------------------------------------------------------------------------------
-- Select a search result by index.
-------------------------------------------------------------------------------
function AuctionFrameSearch_SelectResultByIndex(frame, index)
	if (index and index <= table.getn(frame.results) and frame.resultsType) then
		-- Select the item
		frame.selectedResult = frame.results[index];
		ListTemplate_SelectRow(frame.resultsList, index);
	else
		-- Clear the selection
		frame.selectedResult = nil;
		ListTemplate_SelectRow(frame.resultsList, nil);
	end

	AuctionFrameSearch_UpdateButtons(frame);
end

-------------------------------------------------------------------------------
-- Update the enabled/disabled state of the Bid and Buyout buttons
-------------------------------------------------------------------------------
function AuctionFrameSearch_UpdateButtons(frame)
	if (frame.selectedResult) then
		if (frame.selectedResult.status == AUCTION_STATUS_UNKNOWN) then
			if (frame.resultsType == "BidSearch") then
				frame.bidButton:Enable();
				frame.buyoutButton:Disable();
			elseif (frame.resultsType == "BuyoutSearch") then
				frame.bidButton:Disable();
				frame.buyoutButton:Enable();
			elseif (frame.resultsType == "CompeteSearch") then
				frame.bidButton:Enable();
				frame.buyoutButton:Enable();
			elseif (frame.resultsType == "PlainSearch") then
				frame.bidButton:Enable();
				frame.buyoutButton:Enable();
			else
				frame.bidButton:Disable();
				frame.buyoutButton:Disable();
			end
		else
			frame.bidButton:Disable();
			frame.buyoutButton:Disable();
		end
	else
		frame.bidButton:Disable();
		frame.buyoutButton:Disable();
	end
end

-------------------------------------------------------------------------------
-- An item in the list is moused over.
-------------------------------------------------------------------------------
function AuctionFrameSearch_ListItem_OnEnter(row)
	local frame = this:GetParent():GetParent();
	local results = frame.results;
	if (results and row <= table.getn(results)) then
		local result = results[row];
		if (result) then
			local _, link, rarity = GetItemInfo(result.item);
			if (link) then
				local name = result.name;
				local count = result.count;
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
				GameTooltip:SetHyperlink(link);
				GameTooltip:Show();
				EnhTooltip.TooltipCall(GameTooltip, name, result.link, rarity, count);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- An item in the list is clicked.
-------------------------------------------------------------------------------
function AuctionFrameSearch_ListItem_OnClick(row)
	local frame = this:GetParent():GetParent();

	-- Select the item clicked.
	frame:SelectResultByIndex(row);

	-- Bid or buyout the item if the alt key is down.
	if (frame.resultsType and IsAltKeyDown()) then
		if (IsShiftKeyDown()) then
			-- Bid or buyout the item.
			if (frame.resultsType == "BidSearch") then
				AuctionFrameSearch_BidButton_OnClick(frame.bidButton);

			elseif (frame.resultsType == "BuyoutSearch") then
				AuctionFrameSearch_BuyoutButton_OnClick(frame.buyoutButton);
			end

		else
			-- Search for the item and switch to the Browse tab.
			BrowseName:SetText(frame.results[row].name)
			BrowseMinLevel:SetText("")
			BrowseMaxLevel:SetText("")
			AuctionFrameBrowse.selectedInvtype = nil
			AuctionFrameBrowse.selectedInvtypeIndex = nil
			AuctionFrameBrowse.selectedClass = nil
			AuctionFrameBrowse.selectedClassIndex = nil
			AuctionFrameBrowse.selectedSubclass = nil
			AuctionFrameBrowse.selectedSubclassIndex = nil
			AuctionFrameFilters_Update()
			IsUsableCheckButton:SetChecked(0)
			UIDropDownMenu_SetSelectedValue(BrowseDropDown, -1)
			AuctionFrameBrowse_Search()
			AuctionFrameTab_OnClick(1);
		end

	--Thanks to Miravlix (from irc://irc.datavertex.com/cosmostesters) for the following codeblocks.
	elseif (IsControlKeyDown()) then
		DressUpItemLink(frame.results[row].item);

	elseif (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
		-- Trim leading whitespace
		ChatFrameEditBox:Insert(string.gsub(frame.results[row].link, " *(.*)", "%1"));
	end
end

-------------------------------------------------------------------------------
-- Initialize the content of a Category dropdown list
-------------------------------------------------------------------------------
function AuctionFrameSearch_CategoryDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();
	UIDropDownMenu_AddButton({
		text = "",
		func = AuctionFrameSearch_CategoryDropDownItem_OnClick,
		owner = dropdown
	})

	if (AuctionConfig.classes) then
		for classid, cdata in AuctionConfig.classes do
			UIDropDownMenu_AddButton({
				text = cdata.name,
				func = AuctionFrameSearch_CategoryDropDownItem_OnClick,
				owner = dropdown
			});
		end
	end
end

-------------------------------------------------------------------------------
-- An item in a CategoryDrownDown has been clicked
-------------------------------------------------------------------------------
function AuctionFrameSearch_CategoryDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	AuctioneerDropDownMenu_SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-- Initialize the content of a TimeLeft dropdown list
-------------------------------------------------------------------------------
function AuctionFrameSearch_TimeLeftDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();
	for index in TIME_LEFT_NAMES do
		local info = {};
		info.text = TIME_LEFT_NAMES[index];
		info.func = AuctionFrameSearch_TimeLeftDropDownItem_OnClick;
		info.owner = dropdown;
		UIDropDownMenu_AddButton(info);
	end
end

-------------------------------------------------------------------------------
-- An item a TimeLeftDrownDown has been clicked
-------------------------------------------------------------------------------
function AuctionFrameSearch_TimeLeftDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	AuctioneerDropDownMenu_SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchBid_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();
	local profitMoneyFrame = getglobal(frameName.."MinProfit");
	local percentLessEdit = getglobal(frameName.."MinPercentLessEdit");
	local timeLeftDropDown = getglobal(frameName.."TimeLeftDropDown");

	local minProfit = MoneyInputFrame_GetCopper(profitMoneyFrame);
	local minPercentLess = percentLessEdit:GetNumber();
	local catID = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."CategoryDropDown")) or 1) - 1;
	local minQuality = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."MinQualityDropDown")) or 1) - 1;
	local itemName = getglobal(frameName.."SearchEdit"):GetText();
	if (itemName == "") then itemName = nil end

	local timeLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[UIDropDownMenu_GetSelectedID(timeLeftDropDown)];
	frame:GetParent():SearchBids(minProfit, minPercentLess, timeLeft, catID, minQuality, itemName);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchBuyout_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();
	local profitMoneyFrame = getglobal(frame:GetName().."MinProfit");
	local percentLessEdit = getglobal(frame:GetName().."MinPercentLessEdit");

	local minProfit = MoneyInputFrame_GetCopper(profitMoneyFrame);
	local minPercentLess = percentLessEdit:GetNumber();
	local catID = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."CategoryDropDown")) or 1) - 1
	local minQuality = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."MinQualityDropDown")) or 1) - 1;
	local itemName = getglobal(frameName.."SearchEdit"):GetText();
	if (itemName == "") then itemName = nil end

	frame:GetParent():SearchBuyouts(minProfit, minPercentLess, catID, minQuality, itemName);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchPlain_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();

	local maxPrice = MoneyInputFrame_GetCopper(getglobal(frameName.."MaxPrice")) or 0
	local catID = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."CategoryDropDown")) or 1) - 1
	local minQuality = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."MinQualityDropDown")) or 1) - 1;
	local itemName = getglobal(frameName.."SearchEdit"):GetText();
	if (itemName == "") then itemName = nil end

	frame:GetParent():SearchPlain(maxPrice, catID, minQuality, itemName);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchCompete_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local undercutMoneyFrame = getglobal(frame:GetName().."Undercut");

	local minUndercut = MoneyInputFrame_GetCopper(undercutMoneyFrame);
	frame:GetParent():SearchCompetition(minUndercut);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_OnBidResult(context, bidRequest)
	context.auction.pendingBidCount = context.auction.pendingBidCount - 1;
	if (context.auction.pendingBidCount == 0) then
		if (table.getn(bidRequest.results) == 0) then
			-- No auctions matched.
			context.auction.status = AUCTION_STATUS_NOT_FOUND;
		else
			-- Assume we are now the high bidder on all the matching auctions
			-- until proven otherwise.
			context.auction.status = AUCTION_STATUS_HIGH_BIDDER;
			for _,result in pairs(bidRequest.results) do
				if (result ~= BidResultCodes["BidAccepted"] and
					result ~= BidResultCodes["AlreadyHighBidder"] and
					result ~= BidResultCodes["OwnAuction"]) then
					context.auction.status = AUCTION_STATUS_UNKNOWN;
					break;
				end
			end
		end
		AuctionFrameSearch_UpdateButtons(context.frame);
		ListTemplateScrollFrame_Update(getglobal(context.frame.resultsList:GetName().."ScrollFrame"));
	end
	AuctionFrameSearch_UpdatePendingBidStatus(context.frame);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_GetAuctionAlpha(auction)
	local status = auction.status;
	if (status and (status == AUCTION_STATUS_NOT_FOUND or status == AUCTION_STATUS_HIGH_BIDDER)) then
		return 0.4;
	end
	return 1.0;
end



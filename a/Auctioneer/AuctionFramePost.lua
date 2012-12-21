--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AuctionFramePost.lua 930 2006-07-06 06:52:52Z vindicator $

	Auctioneer Post Auctions tab

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

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_OnLoad()
	-- Methods
	this.CalculateAuctionDeposit = AuctionFramePost_CalculateAuctionDeposit;
	this.UpdateDeposit = AuctionFramePost_UpdateDeposit;
	this.GetItemID = AuctionFramePost_GetItemID;
	this.GetItemSignature = AuctionFramePost_GetItemSignature;
	this.GetItemName = AuctionFramePost_GetItemName;
	this.SetNoteText = AuctionFramePost_SetNoteText;
	this.GetSavePrice = AuctionFramePost_GetSavePrice;
	this.GetStartPrice = AuctionFramePost_GetStartPrice;
	this.SetStartPrice = AuctionFramePost_SetStartPrice;
	this.GetBuyoutPrice = AuctionFramePost_GetBuyoutPrice;
	this.SetBuyoutPrice = AuctionFramePost_SetBuyoutPrice;
	this.GetStackSize = AuctionFramePost_GetStackSize;
	this.SetStackSize = AuctionFramePost_SetStackSize;
	this.GetStackCount = AuctionFramePost_GetStackCount;
	this.SetStackCount = AuctionFramePost_SetStackCount;
	this.GetDuration = AuctionFramePost_GetDuration;
	this.SetDuration = AuctionFramePost_SetDuration;
	this.GetDeposit = AuctionFramePost_GetDeposit;
	this.SetAuctionItem = AuctionFramePost_SetAuctionItem;
	this.ValidateAuction = AuctionFramePost_ValidateAuction;
	this.UpdateAuctionList = AuctionFramePost_UpdateAuctionList;
	this.UpdatePriceModels = AuctionFramePost_UpdatePriceModels;

	-- Data Members
	this.itemID = nil;
	this.itemSignature = nil;
	this.itemName = nil;
	this.updating = false;
	this.prices = {};

	-- Controls
	this.auctionList = getglobal(this:GetName().."List");
	this.bidMoneyInputFrame = getglobal(this:GetName().."StartPrice");
	this.buyoutMoneyInputFrame = getglobal(this:GetName().."BuyoutPrice");
	this.stackSizeEdit = getglobal(this:GetName().."StackSize");
	this.stackSizeCount = getglobal(this:GetName().."StackCount");
	this.depositMoneyFrame = getglobal(this:GetName().."DepositMoneyFrame");
	this.depositErrorLabel = getglobal(this:GetName().."UnknownDepositText");

	-- Setup the tab order for the money input frames.
	MoneyInputFrame_SetPreviousFocus(this.bidMoneyInputFrame, this.stackSizeCount);
	MoneyInputFrame_SetNextFocus(this.bidMoneyInputFrame, getglobal(this.buyoutMoneyInputFrame:GetName().."Gold"));
	MoneyInputFrame_SetPreviousFocus(this.buyoutMoneyInputFrame, getglobal(this.bidMoneyInputFrame:GetName().."Copper"));
	MoneyInputFrame_SetNextFocus(this.buyoutMoneyInputFrame, this.stackSizeEdit);

	-- Configure the logical columns
	this.logicalColumns =
	{
		Quantity =
		{
			title = _AUCT("UiQuantityHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.quantity end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.quantity < record2.quantity end);
			compareDescendingFunc = (function(record1, record2) return record1.quantity > record2.quantity end);
		},
		Name =
		{
			title = _AUCT("UiNameHeader");
			dataType = "String";
			valueFunc = (function(record) return record.name end);
			colorFunc = AuctionFramePost_GetItemColor;
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.name < record2.name end);
			compareDescendingFunc = (function(record1, record2) return record1.name > record2.name end);
		},
		TimeLeft =
		{
			title = _AUCT("UiTimeLeftHeader");
			dataType = "String";
			valueFunc = (function(record) return Auctioneer.Util.GetTimeLeftString(record.timeLeft) end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.timeLeft < record2.timeLeft end);
			compareDescendingFunc = (function(record1, record2) return record1.timeLeft > record2.timeLeft end);
		},
		Bid =
		{
			title = _AUCT("UiBidHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bid end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bid < record2.bid end);
			compareDescendingFunc = (function(record1, record2) return record1.bid > record2.bid end);
		},
		BidPer =
		{
			title = _AUCT("UiBidPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bidPer end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bidPer < record2.bidPer end);
			compareDescendingFunc = (function(record1, record2) return record1.bidPer > record2.bidPer end);
		},
		Buyout =
		{
			title = _AUCT("UiBuyoutHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyout end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyout < record2.buyout end);
			compareDescendingFunc = (function(record1, record2) return record1.buyout > record2.buyout end);
		},
		BuyoutPer =
		{
			title = _AUCT("UiBuyoutPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyoutPer end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyoutPer < record2.buyoutPer end);
			compareDescendingFunc = (function(record1, record2) return record1.buyoutPer > record2.buyoutPer end);
		},
	};

	-- Configure the physical columns
	this.physicalColumns =
	{
		{
			width = 50;
			logicalColumn = this.logicalColumns.Quantity;
			logicalColumns = { this.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 210;
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
			logicalColumn = this.logicalColumns.Buyout;
			logicalColumns =
			{
				this.logicalColumns.Buyout,
				this.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
	};

	this.auctions = {};
	ListTemplate_Initialize(this.auctionList, this.physicalColumns, this.logicalColumns);
	ListTemplate_SetContent(this.auctionList, this.auctions);

	this:ValidateAuction();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_UpdatePriceModels(frame)
	if (not frame.updating) then
		frame.prices = {};

		local name = frame:GetItemName();
		local count = frame:GetStackSize();
		if (name and count) then
			local bag, slot, id, rprop, enchant, uniq = EnhTooltip.FindItemInBags(name);
			local itemKey = id..":"..rprop..":"..enchant;
			local hsp, histCount, market, warn, nexthsp, nextwarn = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());

			-- Get the fixed price
			if (Auctioneer.Storage.GetFixedPrice(itemKey)) then
				local startPrice, buyPrice = Auctioneer.Storage.GetFixedPrice(itemKey, count);
				local fixedPrice = {};
				fixedPrice.text = _AUCT('UiPriceModelFixed');
				fixedPrice.note = "";
				fixedPrice.bid = startPrice;
				fixedPrice.buyout = buyPrice;
				table.insert(frame.prices, fixedPrice);
			end

			-- Calculate auctioneer's suggested resale price.
			if (hsp == 0) then
				local auctionPriceItem = Auctioneer.Core.GetAuctionPriceItem(itemKey, Auctioneer.Util.GetAuctionKey());
				local aCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = Auctioneer.Core.GetAuctionPrices(auctionPriceItem.data);
				hsp = math.floor(buyPrice / buyCount); -- use mean buyout if median not available
			end
			local discountBidPercent = tonumber(Auctioneer.Command.GetFilterVal('pct-bidmarkdown'));
			local auctioneerPrice = {};
			auctioneerPrice.text = _AUCT('UiPriceModelAuctioneer');
			auctioneerPrice.note = warn;
			auctioneerPrice.buyout = Auctioneer.Statistic.RoundDownTo95(Auctioneer.Util.NullSafe(hsp) * count);
			auctioneerPrice.bid = Auctioneer.Statistic.RoundDownTo95(Auctioneer.Statistic.SubtractPercent(auctioneerPrice.buyout, discountBidPercent));
			table.insert(frame.prices, auctioneerPrice);

			-- Add the fallback custom price
			local customPrice = {}
			customPrice.text = _AUCT('UiPriceModelCustom');
			customPrice.note = "";
			customPrice.bid = nil;
			customPrice.buyout = nil;
			table.insert(frame.prices, customPrice);

			-- Update the price model combo.
			local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
			local index = UIDropDownMenu_GetSelectedID(dropdown);
			if (index == nil) then
				index = 1;
			end
			AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index);
		else
			-- Update the price model combo.
			local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
			AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, nil);
		end
	end
end

-------------------------------------------------------------------------------
-- Updates the content of the auction list based on the current auction item.
-------------------------------------------------------------------------------
function AuctionFramePost_UpdateAuctionList(frame)
	frame.auctions = {};
	local itemSignature = frame:GetItemSignature();
	if (itemSignature) then
		local auctions = Auctioneer.Filter.QuerySnapshot(AuctionFramePost_ItemSignatureFilter, itemSignature);
		if (auctions) then
			for _,a in pairs(auctions) do
				local id,rprop,enchant,name,count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(a.signature);
				local auction = {};
				auction.item = string.format("item:%s:%s:%s:0", id, enchant, rprop);
				auction.quantity = count;
				auction.name = name;
				auction.owner = a.owner;
				auction.timeLeft = a.timeLeft;
				auction.bid = Auctioneer.Statistic.GetCurrentBid(a.signature);
				auction.bidPer = math.floor(auction.bid / auction.quantity);
				auction.buyout = buyout;
				auction.buyoutPer = math.floor(auction.buyout / auction.quantity);
				table.insert(frame.auctions, auction);
			end
		end
	end
	ListTemplate_SetContent(frame.auctionList, frame.auctions);
	ListTemplate_Sort(frame.auctionList, 5);
end

-------------------------------------------------------------------------------
-- Updates the deposit value.
-------------------------------------------------------------------------------
function AuctionFramePost_UpdateDeposit(frame)
	if (not frame.updating) then
		local itemID = frame:GetItemID();
		local duration = frame:GetDuration();
		local stackSize = frame:GetStackSize();
		local stackCount = frame:GetStackCount();
		if (itemID) then
			local deposit = AuctionFramePost_CalculateAuctionDeposit(itemID, stackSize, duration);
			if (deposit) then
				MoneyFrame_Update(frame.depositMoneyFrame:GetName(), deposit * stackCount);
				frame.depositMoneyFrame:Show();
				frame.depositErrorLabel:Hide();
			else
				MoneyFrame_Update(frame.depositMoneyFrame:GetName(), 0);
				frame.depositMoneyFrame:Hide();
				frame.depositErrorLabel:Show();
			end
		else
			MoneyFrame_Update(frame.depositMoneyFrame:GetName(), 0);
			frame.depositMoneyFrame:Hide();
			frame.depositErrorLabel:Hide();
		end
	end
end

-------------------------------------------------------------------------------
-- Gets the item ID.
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemID(frame)
	return frame.itemID;
end

-------------------------------------------------------------------------------
-- Gets the item signature.
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemSignature(frame)
	return frame.itemSignature;
end

-------------------------------------------------------------------------------
-- Gets the item name.
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemName(frame)
	return frame.itemName;
end

-------------------------------------------------------------------------------
-- Sets the price model note (i.e. "Undercutting 5%")
-------------------------------------------------------------------------------
function AuctionFramePost_SetNoteText(frame, text)
	local cHex, cRed, cGreen, cBlue = Auctioneer.Util.GetWarnColor(text);

	getglobal(frame:GetName().."PriceModelNoteText"):SetText(text);
	getglobal(frame:GetName().."PriceModelNoteText"):SetTextColor(cRed, cGreen, cBlue);
end

-------------------------------------------------------------------------------
-- Gets whether or not to save the current price information as the fixed
-- price.
-------------------------------------------------------------------------------
function AuctionFramePost_GetSavePrice(frame)
	local checkbox = getglobal(frame:GetName().."SavePriceCheckBox");
	return (checkbox and checkbox:IsVisible() and checkbox:GetChecked());
end

-------------------------------------------------------------------------------
-- Gets the starting price.
-------------------------------------------------------------------------------
function AuctionFramePost_GetStartPrice(frame)
	return MoneyInputFrame_GetCopper(getglobal(frame:GetName().."StartPrice"));
end

-------------------------------------------------------------------------------
-- Sets the starting price.
-------------------------------------------------------------------------------
function AuctionFramePost_SetStartPrice(frame, price)
	frame.ignoreStartPriceChange = true;
	MoneyInputFrame_SetCopper(getglobal(frame:GetName().."StartPrice"), price);
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the buyout price.
-------------------------------------------------------------------------------
function AuctionFramePost_GetBuyoutPrice(frame)
	return MoneyInputFrame_GetCopper(getglobal(frame:GetName().."BuyoutPrice"));
end

-------------------------------------------------------------------------------
-- Sets the buyout price.
-------------------------------------------------------------------------------
function AuctionFramePost_SetBuyoutPrice(frame, price)
	frame.ignoreBuyoutPriceChange = true;
	MoneyInputFrame_SetCopper(getglobal(frame:GetName().."BuyoutPrice"), price);
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the stack size.
-------------------------------------------------------------------------------
function AuctionFramePost_GetStackSize(frame)
	return getglobal(frame:GetName().."StackSize"):GetNumber();
end

-------------------------------------------------------------------------------
-- Sets the stack size.
-------------------------------------------------------------------------------
function AuctionFramePost_SetStackSize(frame, size)
	-- Update the stack size.
	getglobal(frame:GetName().."StackSize"):SetNumber(size);

	-- Update the deposit cost.
	frame:UpdateDeposit();
	frame:UpdatePriceModels();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the stack count.
-------------------------------------------------------------------------------
function AuctionFramePost_GetStackCount(frame)
	return getglobal(frame:GetName().."StackCount"):GetNumber();
end

-------------------------------------------------------------------------------
-- Sets the stack count.
-------------------------------------------------------------------------------
function AuctionFramePost_SetStackCount(frame, count)
	-- Update the stack count.
	getglobal(frame:GetName().."StackCount"):SetNumber(count);

	-- Update the deposit cost.
	frame:UpdateDeposit();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the duration.
-------------------------------------------------------------------------------
function AuctionFramePost_GetDuration(frame)
	if (getglobal(frame:GetName().."ShortAuctionRadio"):GetChecked()) then
		return 120;
	elseif(getglobal(frame:GetName().."MediumAuctionRadio"):GetChecked()) then
		return 480;
	else
		return 1440;
	end
end

-------------------------------------------------------------------------------
-- Sets the duration.
-------------------------------------------------------------------------------
function AuctionFramePost_SetDuration(frame, duration)
	local shortRadio = getglobal(frame:GetName().."ShortAuctionRadio");
	local mediumRadio = getglobal(frame:GetName().."MediumAuctionRadio");
	local longRadio = getglobal(frame:GetName().."LongAuctionRadio");

	-- Figure out radio to set as checked.
	if (duration == 120) then
		shortRadio:SetChecked(1);
		mediumRadio:SetChecked(nil);
		longRadio:SetChecked(nil);
	elseif (duration == 480) then
		shortRadio:SetChecked(nil);
		mediumRadio:SetChecked(1);
		longRadio:SetChecked(nil);
	else
		shortRadio:SetChecked(nil);
		mediumRadio:SetChecked(nil);
		longRadio:SetChecked(1);
	end

	-- Update the deposit cost.
	frame:UpdateDeposit();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the deposit amount required to post.
-------------------------------------------------------------------------------
function AuctionFramePost_GetDeposit(frame)
	return getglobal(frame:GetName().."DepositMoneyFrame").staticMoney;
end

-------------------------------------------------------------------------------
-- Sets the item to display in the create auction frame.
-------------------------------------------------------------------------------
function AuctionFramePost_SetAuctionItem(frame, bag, item, count)
	-- Prevent validation while updating.
	frame.updating = true;

	-- Update the controls with the item.
	local button = getglobal(frame:GetName().."AuctionItem");
	if (bag and item) then
		-- Get the item's information.
		local itemLink = GetContainerItemLink(bag, item);
		local itemID, randomProp, enchant, uniqueId, name = EnhTooltip.BreakLink(itemLink);
		local itemTexture, itemCount = GetContainerItemInfo(bag, item);
		if (count == nil) then
			count = itemCount;
		end

		-- Save the item's information.
		frame.itemID = itemID;
		frame.itemSignature = AucPostManager.CreateItemSignature(itemID, randomProp, enchant);
		frame.itemName = name;

		-- Show the item
		getglobal(button:GetName().."Name"):SetText(name);
		getglobal(button:GetName().."Name"):Show();
		getglobal(button:GetName().."IconTexture"):SetTexture(itemTexture);
		getglobal(button:GetName().."IconTexture"):Show();

		-- Set the defaults.
		local duration = Auctioneer.Command.GetFilterVal('auction-duration')
		if duration == 1 then
			-- 2h
			frame:SetDuration(120)
		elseif duration == 2 then
			-- 8h
			frame:SetDuration(480)
		elseif duration == 3 then
			-- 24h
			frame:SetDuration(1440)
		else
			-- last
			frame:SetDuration(Auctioneer.Command.GetFilterVal('last-auction-duration'))
		end
		frame:SetStackSize(count);
		frame:SetStackCount(1);

		-- Clear the current pricing model so that the default one gets selected.
		local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
		AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, nil);
		
		-- Update the Transactions tab if BeanCounter is loaded.
		if (AuctionFrameTransactions) then
			AuctionFrameTransactions:SearchTransactions(name, true, nil);
		end
	else
		-- Clear the item's information.
		frame.itemID = nil;
		frame.itemSignature = nil;
		frame.itemName = nil;

		-- Hide the item
		getglobal(button:GetName().."Name"):Hide();
		getglobal(button:GetName().."IconTexture"):Hide();

		-- Clear the defaults.
		frame:SetStackSize(1);
		frame:SetStackCount(1);
	end

	-- Update the deposit cost and validate the auction.
	frame.updating = false;
	frame:UpdateDeposit();
	frame:UpdatePriceModels();
	frame:UpdateAuctionList();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Validates the current auction.
-------------------------------------------------------------------------------
function AuctionFramePost_ValidateAuction(frame)
	-- Only validate if its not turned off.
	if (not frame.updating) then
		-- Check that we have an item.
		local valid = false;
		if (frame.itemID) then
			valid = (frame.itemID ~= nil);
		end

		-- Check that there is a starting price.
		local startPrice = frame:GetStartPrice();
		local startErrorText = getglobal(frame:GetName().."StartPriceInvalidText");
		if (startPrice == 0) then
			valid = false;
			startErrorText:Show();
		else
			startErrorText:Hide();
		end

		-- Check that the starting price is less than or equal to the buyout.
		local buyoutPrice = frame:GetBuyoutPrice();
		local buyoutErrorText = getglobal(frame:GetName().."BuyoutPriceInvalidText");
		if (buyoutPrice > 0 and buyoutPrice < startPrice) then
			valid = false;
			buyoutErrorText:Show();
		else
			buyoutErrorText:Hide();
		end

		-- Check that the item stacks to the amount specified and that the player
		-- has enough of the item.
		local stackSize = frame:GetStackSize();
		local stackCount = frame:GetStackCount();
		local quantityErrorText = getglobal(frame:GetName().."QuantityInvalidText");
		if (frame.itemID and frame.itemSignature) then
			local quantity = AucPostManager.GetItemQuantityBySignature(frame.itemSignature);
			local maxStackSize = AuctionFramePost_GetMaxStackSize(frame.itemID);
			if (stackSize == 0) then
				valid = false;
				quantityErrorText:SetText(_AUCT('UiStackTooSmallError'));
				quantityErrorText:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				quantityErrorText:Show();
			elseif (stackSize > 1 and (maxStackSize == nil or stackSize > maxStackSize)) then
				valid = false;
				quantityErrorText:SetText(_AUCT('UiStackTooBigError'));
				quantityErrorText:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				quantityErrorText:Show();
			elseif (quantity < (stackSize * stackCount)) then
				valid = false;
				quantityErrorText:SetText(_AUCT('UiNotEnoughError'));
				quantityErrorText:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				quantityErrorText:Show();
			else
				local msg = string.format(_AUCT('UiMaxError'), quantity);
				quantityErrorText:SetText(msg);
				quantityErrorText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				quantityErrorText:Show();
			end
		else
			quantityErrorText:Hide();
		end

		-- TODO: Check that the player can afford the deposit cost.
		local deposit = frame:GetDeposit();

		-- Update the state of the Create Auction button.
		local button = getglobal(frame:GetName().."CreateAuctionButton");
		if (valid) then
			button:Enable();
		else
			button:Disable();
		end

		-- Update the price model to reflect bid and buyout prices.
		local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
		local index = UIDropDownMenu_GetSelectedID(dropdown);
		if (index and frame.prices and index <= table.getn(frame.prices)) then
			-- Check if the current selection matches
			local currentPrice = frame.prices[index];
			if ((currentPrice.bid and currentPrice.bid ~= startPrice) or
				(currentPrice.buyout and currentPrice.buyout ~= buyoutPrice)) then
				-- Nope, find one that does.
				for index,price in pairs(frame.prices) do
					if ((price.bid == nil or price.bid == startPrice) and (price.buyout == nil or price.buyout == buyoutPrice)) then
						if (UIDropDownMenu_GetSelectedID(dropdown) ~= index) then
							AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index);
						end
						break;
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_AuctionItem_OnClick(button)
	local frame = button:GetParent();

	-- If the cursor has an item, get it and put it back down in its container.
	local item = AuctioneerUI_GetCursorContainerItem();
	if (item) then
		PickupContainerItem(item.bag, item.slot);
	end

	-- Update the current item displayed
	if (item) then
		local itemLink = GetContainerItemLink(item.bag, item.slot)
		local _, _, _, _, itemName = EnhTooltip.BreakLink(itemLink);
		local _, count = GetContainerItemInfo(item.bag, item.slot);
		frame:SetAuctionItem(item.bag, item.slot, count);
	else
		frame:SetAuctionItem(nil, nil, nil);
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_DurationRadioButton_OnClick(button, index)
	local frame = button:GetParent();
	if (index == 1) then
		Auctioneer.Command.SetFilter('last-auction-duration', 120)
		frame:SetDuration(120);
	elseif (index == 2) then
		Auctioneer.Command.SetFilter('last-auction-duration', 480)
		frame:SetDuration(480);
	else
		Auctioneer.Command.SetFilter('last-auction-duration', 1440)
		frame:SetDuration(1440);
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_StartPrice_OnChanged()
	local frame = this:GetParent():GetParent();
	if (not frame.ignoreStartPriceChange and not updating) then
		frame:ValidateAuction();
	end
	frame.ignoreStartPriceChange = false;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_BuyoutPrice_OnChanged()
	local frame = this:GetParent():GetParent();
	if (not frame.ignoreBuyoutPriceChange and not frame.updating) then
		local updatePrice = Auctioneer.Command.GetFilter('update-price');
		if (updatePrice) then
			frame.updating = true;
			local discountBidPercent = tonumber(Auctioneer.Command.GetFilterVal('pct-bidmarkdown'));
			local bidPrice = Auctioneer.Statistic.SubtractPercent(frame:GetBuyoutPrice(), discountBidPercent);
			frame:SetStartPrice(bidPrice);
			frame.updating = false;
		end
		frame:ValidateAuction();
	end
	frame.ignoreBuyoutPriceChange = false;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_StackSize_OnTextChanged()
	local frame = this:GetParent();

	-- Update the stack size displayed on the graphic.
	local itemID = frame:GetItemID();
	local stackSize = frame:GetStackSize();
	if (itemID and stackSize > 1) then
		getglobal(frame:GetName().."AuctionItemCount"):SetText(stackSize);
		getglobal(frame:GetName().."AuctionItemCount"):Show();
	else
		getglobal(frame:GetName().."AuctionItemCount"):Hide();
	end

	-- Update the deposit and validate the auction.
	frame:UpdateDeposit();
	frame:UpdatePriceModels();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_StackCount_OnTextChanged()
	local frame = this:GetParent();
	frame:UpdateDeposit();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_CreateAuctionButton_OnClick(button)
	local frame = button:GetParent();
	local itemSignature = frame:GetItemSignature();
	local name = frame:GetItemName();
	local startPrice = frame:GetStartPrice();
	local buyoutPrice = frame:GetBuyoutPrice();
	local stackSize = frame:GetStackSize();
	local stackCount = frame:GetStackCount();
	local duration = frame:GetDuration();
	local deposit = frame:GetDeposit();

	-- Check if we should save the pricing information.
	if (frame:GetSavePrice()) then
		local bag, slot, id, rprop, enchant, uniq = EnhTooltip.FindItemInBags(name);
		local itemKey = id..":"..rprop..":"..enchant;
		Auctioneer.Storage.SetFixedPrice(itemKey, startPrice, buyoutPrice, duration, stackSize, Auctioneer.Util.GetAuctionKey());
	end

	-- Post the auction.
	AucPostManager.PostAuction(itemSignature, stackSize, stackCount, startPrice, buyoutPrice, duration);

	-- Clear the current auction item.
	frame:SetAuctionItem(nil, nil, nil);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_PriceModelDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();
	if (frame.prices) then
		for index in frame.prices do
			local price = frame.prices[index];
			local info = {};
			info.text = price.text;
			info.func = AuctionFramePost_PriceModelDropDownItem_OnClick;
			info.owner = dropdown;
			UIDropDownMenu_AddButton(info);
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_PriceModelDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	local frame = dropdown:GetParent();
	if (frame.prices) then
		AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index);
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index)
	local frame = dropdown:GetParent();
	frame.updating = true;
	if (index) then
		local price = frame.prices[index]
		if (price.note) then
			frame:SetNoteText(price.note);
		end
		if (price.buyout) then
			frame:SetBuyoutPrice(price.buyout);
		end
		if (price.bid) then
			frame:SetStartPrice(price.bid);
		end

		if (price.text == _AUCT('UiPriceModelCustom')) then
			getglobal(frame:GetName().."SavePriceText"):Show();
			getglobal(frame:GetName().."SavePriceCheckBox"):Show();
			getglobal(frame:GetName().."PriceModelNoteText"):Hide();
		elseif (price.text == _AUCT('UiPriceModelAuctioneer')) then
			getglobal(frame:GetName().."SavePriceText"):Hide();
			getglobal(frame:GetName().."SavePriceCheckBox"):Hide();
			getglobal(frame:GetName().."PriceModelNoteText"):Show();
		else
			getglobal(frame:GetName().."SavePriceText"):Hide();
			getglobal(frame:GetName().."SavePriceCheckBox"):Hide();
			getglobal(frame:GetName().."PriceModelNoteText"):Hide();
		end

		AuctioneerDropDownMenu_Initialize(dropdown, AuctionFramePost_PriceModelDropDown_Initialize);
		AuctioneerDropDownMenu_SetSelectedID(dropdown, index);
	else
		frame:SetNoteText("");
		frame:SetStartPrice(0);
		frame:SetBuyoutPrice(0);
		getglobal(frame:GetName().."SavePriceText"):Hide();
		getglobal(frame:GetName().."SavePriceCheckBox"):Hide();
		getglobal(frame:GetName().."PriceModelNoteText"):Hide();
		UIDropDownMenu_ClearAll(dropdown);
	end
	frame.updating = false;
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Calculate the deposit required for the specified item.
-------------------------------------------------------------------------------
function AuctionFramePost_CalculateAuctionDeposit(itemID, count, duration)
	local price = Auctioneer.API.GetVendorSellPrice(itemID);
	if (price) then
		local base = math.floor(count * price * GetAuctionHouseDepositRate() / 100);
		return base * duration / 120;
	end
end

-------------------------------------------------------------------------------
-- Calculate the maximum stack size for an item based on the information returned by GetItemInfo()
-------------------------------------------------------------------------------
function AuctionFramePost_GetMaxStackSize(itemID)
	local _, _, _, _, _, _, itemStackCount = GetItemInfo(itemID);
	return itemStackCount;
end

-------------------------------------------------------------------------------
-- Filter for Auctioneer.Filter.QuerySnapshot that filters on item name.
-------------------------------------------------------------------------------
function AuctionFramePost_ItemSignatureFilter(item, signature)
	local id,rprop,enchant,name,count,min,buyout,uniq = Auctioneer.Core.GetItemSignature(signature);
	if (item == AucPostManager.CreateItemSignature(id, rprop, enchant)) then
		return false;
	end
	return true;
end

-------------------------------------------------------------------------------
-- Returns 1.0 for player auctions and 0.4 for competing auctions
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemAlpha(record)
	if (record.owner ~= UnitName("player")) then
		return 0.4;
	end
	return 1.0;
end

-------------------------------------------------------------------------------
-- Returns the item color for the specified result
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemColor(auction)
	_, _, rarity = GetItemInfo(auction.item);
	if (rarity) then
		return ITEM_QUALITY_COLORS[rarity];
	end
	return { r = 1.0, g = 1.0, b = 1.0 };
end

--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucPostManager.lua 930 2006-07-06 06:52:52Z vindicator $

	AucPostManager - manages posting auctions in the AH

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
-- Data Members
-------------------------------------------------------------------------------
local RequestQueue = {};
local ProcessingRequestQueue = false;

-------------------------------------------------------------------------------
-- State machine states for a request.
-------------------------------------------------------------------------------
local READY_STATE = "Ready";
local COMBINING_STACK_STATE = "CombiningStacks";
local SPLITTING_STACK_STATE = "SplittingStack";
local SPLITTING_AND_COMBINING_STACK_STATE = "SplittingAndCombiningStacks";
local AUCTIONING_STACK_STATE = "AuctioningStack";

-------------------------------------------------------------------------------
-- Function hooks that are used when processing requests
-------------------------------------------------------------------------------
local Original_PickupContainerItem;
local Original_SplitContainerItem;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local postAuction;
local addRequestToQueue;
local removeRequestFromQueue;
local processRequestQueue;
local run;
local onEvent;
local setState;
local findEmptySlot;
local findStackBySignature;
local getContainerItemName;
local getContainerItemSignature;
local clearAuctionItem;
local findAuctionItem;
local getItemQuantityBySignature;
local createItemSignature;
local breakItemSignature;
local printBag;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AucPostManagerFrame_OnLoad()
	this:RegisterEvent("AUCTION_HOUSE_CLOSED");
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AucPostManagerFrame_OnEvent(event)
	-- Toss all the pending requests when the AH closes.
	if (event == "AUCTION_HOUSE_CLOSED") then
		while (table.getn(RequestQueue) > 0) do
			removeRequestFromQueue();
		end

	-- Hand off the event to the current request
	elseif (table.getn(RequestQueue) > 0) then
		local request = RequestQueue[1];
		if (request.state ~= READY_STATE) then
			onEvent(request, event);
			processRequestQueue();
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AucPostManager_PickupContainerItem(bag, slot)
	-- Intentionally empty; don't allow items to be picked up while posting
	-- auctions.
	debugPrint("Prevented call to PickupContainerItem()");
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AucPostManager_SplitContainerItem(bag, slot, count)
	-- Intentionally empty; don't allow items to be picked up while posting
	-- auctions.
	debugPrint("Prevented call to SplitContainerItem()");
end

-------------------------------------------------------------------------------
-- Wrapper around PickupContainerItem() that always calls the Blizzard version.
-------------------------------------------------------------------------------
function pickupContainerItem(bag, slot)
	if (Original_PickupContainerItem) then
		return Original_PickupContainerItem(bag, slot);
	end
	return PickupContainerItem(bag, slot);
end

-------------------------------------------------------------------------------
-- Wrapper around SplitContainerItem() that always calls the Blizzard version.
-------------------------------------------------------------------------------
function splitContainerItem(bag, slot, count)
	if (Original_SplitContainerItem) then
		return Original_SplitContainerItem(bag, slot, count);
	end
	return SplitContainerItem(bag, slot, count);
end

-------------------------------------------------------------------------------
-- Start an auction.
-------------------------------------------------------------------------------
function postAuction(itemSignature, stackSize, stackCount, bid, buyout, duration, callbackFunc, callbackParam)
	-- Problems can occur if the Auctions tab hasn't been shown at least once.
	if (not AuctionFrameAuctions:IsVisible()) then
		AuctionFrameAuctions:Show();
		AuctionFrameAuctions:Hide();
	end

	-- Get the item id and name
	local itemId = breakItemSignature(itemSignature);
	local itemName = GetItemInfo(itemId);

	-- Add the request to the queue.
	local request = {};
	request.itemSignature = itemSignature;
	request.name = itemName;
	request.stackSize = stackSize;
	request.stackCount = stackCount;
	request.bid = bid;
	request.buyout = buyout;
	request.duration = duration;
	request.callback = { func = callbackFunc, param = callbackParam };
	addRequestToQueue(request);
	processRequestQueue();
end

-------------------------------------------------------------------------------
-- Adds a request to the queue.
-------------------------------------------------------------------------------
function addRequestToQueue(request)
	request.state = READY_STATE;
	request.stackPostCount = 0;
	request.lockEventsInCurrentState = 0;
	request.stack = nil;
	table.insert(RequestQueue, request);
end

-------------------------------------------------------------------------------
-- Removes a request at the head of the queue.
-------------------------------------------------------------------------------
function removeRequestFromQueue()
	if (table.getn(RequestQueue) > 0) then
		local request = RequestQueue[1];

		-- Make absolutely sure we are back in the READY_STATE so that we
		-- correctly unregister for events.
		setState(request, READY_STATE);

		-- Perform the callback
		local callback = request.callback;
		if (callback and callback.func) then
			callback.func(callback.param, request);
		end

		-- Report the auctions posted
		if (request.stackPostCount == 1) then
			local output = string.format(_AUCT('FrmtPostedAuction'), request.name, request.stackSize);
			chatPrint(output);
		else
			local output = string.format(_AUCT('FrmtPostedAuctions'), request.stackPostCount, request.name, request.stackSize);
			chatPrint(output);
		end
		table.remove(RequestQueue, 1);

		-- If this was the last request, end processing the queue.
		if (table.getn(RequestQueue) == 0) then
			endProcessingRequestQueue()
		end
	end
end

-------------------------------------------------------------------------------
-- Executes the request at the head of the queue.
-------------------------------------------------------------------------------
function processRequestQueue()
	if (beginProcessingRequestQueue()) then
		run(RequestQueue[1]);
	end
end

-------------------------------------------------------------------------------
-- Starts processing the request queue if possible. Returns true if started.
-------------------------------------------------------------------------------
function beginProcessingRequestQueue()
	if (not ProcessingRequestQueue and
		AuctionFrame and AuctionFrame:IsVisible() and
		table.getn(RequestQueue) > 0) then

		ProcessingRequestQueue = true;
		debugPrint("Begin processing the post queue");

		-- Hook the functions to disable picking up items. This prevents
		-- spurious ITEM_LOCK_CHANGED events from confusing us.
		if (not Original_PickupContainerItem) then
			Original_PickupContainerItem = PickupContainerItem;
			PickupContainerItem = AucPostManager_PickupContainerItem;
		end
		if (not Original_SplitContainerItem) then
			Original_SplitContainerItem = SplitContainerItem;
			SplitContainerItem = AucPostManager_SplitContainerItem;
		end
	end
	return ProcessingRequestQueue;
end

-------------------------------------------------------------------------------
-- Ends processing the request queue
-------------------------------------------------------------------------------
function endProcessingRequestQueue()
	if (ProcessingRequestQueue) then
		-- Unhook the functions.
		if (Original_PickupContainerItem) then
			PickupContainerItem = Original_PickupContainerItem;
			Original_PickupContainerItem = nil;
		end
		if (Original_SplitContainerItem) then
			SplitContainerItem = Original_SplitContainerItem;
			Original_SplitContainerItem = nil;
		end

		debugPrint("End processing the post queue");
		ProcessingRequestQueue = false;
	end
end

-------------------------------------------------------------------------------
-- Performs the next step in fulfilling the request.
-------------------------------------------------------------------------------
function run(request)
	if (request.state == READY_STATE) then
		-- Locate a stack of the items. If the request has a stack associated
		-- with it, that's a hint to try and use it. Otherwise we'll search
		-- for a stack of the exact size. Failing that, we'll start with the
		-- first stack we find.
		local stack1 = nil;
		if (request.stack and request.itemSignature == getContainerItemSignature(request.stack.bag, request.stack.slot)) then
			-- Use the stack hint.
			stack1 = request.stack;
		else
			-- Find the first stack.
			stack1 = findStackBySignature(request.itemSignature);

			-- Now look for a stack of the exact size to use instead.
			if (stack1) then
				local stack2 = { bag = stack1.bag, slot = stack1.slot };
				local _, stack2Size = GetContainerItemInfo(stack2.bag, stack2.slot);
				while (stack2 and stack2Size ~= request.stackSize) do
					stack2 = findStackBySignature(request.itemSignature, stack2.bag, stack2.slot + 1);
					if (stack2) then
						_, stack2Size = GetContainerItemInfo(stack2.bag, stack2.slot);
					end
				end
				if (stack2) then
					stack1 = stack2;
				end
			end
		end

		-- If we have found a stack, figure out what we should do with it.
		if (stack1) then
			local _, stack1Size = GetContainerItemInfo(stack1.bag, stack1.slot);
			if (stack1Size == request.stackSize) then
				-- We've done it! Now move the stack to the auction house.
				request.stack = stack1;
				setState(request, AUCTIONING_STACK_STATE);
				pickupContainerItem(stack1.bag, stack1.slot);
				ClickAuctionSellItemButton();

				-- Start the auction if requested.
				if (request.bid and request.buyout and request.duration) then
					StartAuction(request.bid, request.buyout, request.duration);
				else
					removeRequestFromQueue();
				end
			elseif (stack1Size < request.stackSize) then
				-- The stack we have is less than needed. Locate more of the item.
				local stack2 = findStackBySignature(request.itemSignature, stack1.bag, stack1.slot + 1);
				if (stack2) then
					local _, stack2Size = GetContainerItemInfo(stack2.bag, stack2.slot);
					if (stack1Size + stack2Size <= request.stackSize) then
						-- Combine all of stack2 with stack1.
						setState(request, COMBINING_STACK_STATE);
						pickupContainerItem(stack2.bag, stack2.slot);
						pickupContainerItem(stack1.bag, stack1.slot);
						request.stack = stack1;
					else
						-- Combine part of stack2 with stack1.
						setState(request, SPLITTING_AND_COMBINING_STACK_STATE);
						splitContainerItem(stack2.bag, stack2.slot, request.stackSize - stack1Size);
						pickupContainerItem(stack1.bag, stack1.slot);
						request.stack = stack1;
					end
				else
					-- Not enough of the item found!
					chatPrint(_AUCT('FrmtNoEmptyPackSpace'));
					removeRequestFromQueue();
				end
			else
				-- The stack we have is more than needed. Locate an empty slot.
				local stack2 = findEmptySlot();
				if (stack2) then
					setState(request, SPLITTING_STACK_STATE);
					splitContainerItem(stack1.bag, stack1.slot, request.stackSize);
					pickupContainerItem(stack2.bag, stack2.slot);
					request.stack = stack2;
				else
					-- Not enough of the item!
					local output = string.format(_AUCT('FrmtNotEnoughOfItem'), request.name);
					chatPrint(output);
					removeRequestFromQueue();
				end
			end
		else
			-- Item not found!
			local output = string.format(_AUCT('FrmtNotEnoughOfItem'), request.name);
			chatPrint(output);
			removeRequestFromQueue();
		end
	end
end

-------------------------------------------------------------------------------
-- Processes the event.
-------------------------------------------------------------------------------
function onEvent(request, event)
	debugPrint("Received event "..event.. " in state "..request.state);

	-- Process the event.
	if (event == "ITEM_LOCK_CHANGED") then
		-- Check if we are waiting for a stack to be complete.
		request.lockEventsInCurrentState = request.lockEventsInCurrentState + 1;
		if (request.lockEventsInCurrentState == 3 and
			(request.state == SPLITTING_STACK_STATE or
			 request.state == COMBINING_STACK_STATE or
			 request.state == SPLITTING_AND_COMBINING_STACK_STATE)) then
			-- Ready to move onto the next step.
			setState(request, READY_STATE);
		end
	elseif (event == "BAG_UPDATE") then
		-- Check if we are waiting for StartAuction() to complete. If so, check
		-- if the stack we are trying to auction is now gone.
		if (request.state == AUCTIONING_STACK_STATE and GetContainerItemInfo(request.stack.bag, request.stack.slot) == nil) then
			-- Ready to move onto the next step.
			setState(request, READY_STATE);

			-- Decrement the auction target count.
			request.stackPostCount = request.stackPostCount + 1;
			if (request.stackPostCount == request.stackCount) then
				removeRequestFromQueue();
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Changes the request state.
-------------------------------------------------------------------------------
function setState(request, newState)
	if (request.state ~= newState) then
		debugPrint("Entered state: "..newState);

		-- Unregister for events needed in the old state.
		if (request.state == SPLITTING_STACK_STATE or
			request.state == COMBINING_STACK_STATE or
			request.state == SPLITTING_AND_COMBINING_STACK_STATE) then
			debugPrint("Unregistering for ITEM_LOCK_CHANGED");
			AucPostManagerFrame:UnregisterEvent("ITEM_LOCK_CHANGED");
		elseif (request.state == AUCTIONING_STACK_STATE) then
			debugPrint("Unregistering for BAG_UPDATE");
			AucPostManagerFrame:UnregisterEvent("BAG_UPDATE");
		end

		-- Update the request's state.
		request.state = newState;
		request.lockEventsInCurrentState = 0;

		-- Register for events needed in the new state.
		if (request.state == SPLITTING_STACK_STATE or
			request.state == COMBINING_STACK_STATE or
			request.state == SPLITTING_AND_COMBINING_STACK_STATE) then
			debugPrint("Registering for ITEM_LOCK_CHANGED");
			AucPostManagerFrame:RegisterEvent("ITEM_LOCK_CHANGED");
		elseif (request.state == AUCTIONING_STACK_STATE) then
			debugPrint("Registering for BAG_UPDATE");
			AucPostManagerFrame:RegisterEvent("BAG_UPDATE");
		end
	end
end

-------------------------------------------------------------------------------
-- Finds an empty slot in the player's containers.
--
-- TODO: Correctly handle containers like ammo packs
-------------------------------------------------------------------------------
function findEmptySlot()
	for bag = 0, 4, 1 do
		if (GetBagName(bag)) then
			for item = GetContainerNumSlots(bag), 1, -1 do
				if (not GetContainerItemInfo(bag, item)) then
					return { bag=bag, slot=item };
				end
			end
		end
	end
	return nil;
end

-------------------------------------------------------------------------------
-- Finds the specified item by id
--
-- TODO: Correctly handle containers like ammo packs
-------------------------------------------------------------------------------
function findStackBySignature(itemSignature, startingBag, startingSlot)
	if (startingBag == nil) then
		startingBag = 0;
	end
	if (startingSlot == nil) then
		startingSlot = 1;
	end
	for bag = startingBag, 4, 1 do
		if (GetBagName(bag)) then
			local numItems = GetContainerNumSlots(bag);
			if (startingSlot <= numItems) then
				for slot = startingSlot, GetContainerNumSlots(bag), 1 do
					local thisItemSignature = getContainerItemSignature(bag, slot);
					if (itemSignature == thisItemSignature) then
						return { bag=bag, slot=slot };
					end
				end
			end
			startingSlot = 1;
		end
	end
	return nil;
end


-------------------------------------------------------------------------------
-- Gets the name of the specified
-------------------------------------------------------------------------------
function getContainerItemName(bag, slot)
	local link = GetContainerItemLink(bag, slot);
	if (link) then
		local _, _, _, _, name = EnhTooltip.BreakLink(link);
		return name;
	end
end

-------------------------------------------------------------------------------
-- Gets the signature of the specified item (itemId:suffixId:enchantId)
-------------------------------------------------------------------------------
function getContainerItemSignature(bag, slot)
	local link = GetContainerItemLink(bag, slot);
	if (link) then
		local itemId, suffixId, enchantId = EnhTooltip.BreakLink(link);
		return createItemSignature(itemId, suffixId, enchantId);
	end
end

-------------------------------------------------------------------------------
-- Clears the current auction item, if any.
-------------------------------------------------------------------------------
function clearAuctionItem()
	local bag, item = findAuctionItem();
	if (bag and item) then
		ClickAuctionSellItemButton();
		pickupContainerItem(bag, item);
	end
end

-------------------------------------------------------------------------------
-- Finds the bag and slot for the current auction item.
--
-- TODO: Correctly handle containers like ammo packs
-------------------------------------------------------------------------------
function findAuctionItem()
	local auctionName, _, auctionCount = GetAuctionSellItemInfo();
	--debugPrint("Searching for "..auctionName.." in a stack of "..auctionCount);
	if (auctionName and auctionCount) then
		for bag = 0, 4, 1 do
			if (GetBagName(bag)) then
				for item = GetContainerNumSlots(bag), 1, -1 do
					--debugPrint("Checking "..bag..", "..item);
					local _, itemCount, itemLocked = GetContainerItemInfo(bag, item);
					if (itemLocked and itemCount == auctionCount) then
						local itemName = getContainerItemName(bag, item);
						--debugPrint("Item "..itemName.." locked");
						if (itemName == auctionName) then
							return bag, item;
						end
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Creates an item signature (itemId:suffixId:enchantId)
-------------------------------------------------------------------------------
function createItemSignature(itemId, suffixId, enchantId)
	return itemId..":"..suffixId..":"..enchantId;
end

-------------------------------------------------------------------------------
-- Breaks an item signature (itemId:suffixId:enchantId)
-------------------------------------------------------------------------------
function breakItemSignature(itemSignature)
	_, _, itemId, suffixId, enchantId = string.find(itemSignature, "(.+):(.+):(.+)");
	itemId = tonumber(itemId);
	suffixId = tonumber(suffixId);
	enchantId = tonumber(enchantId);
	return itemId, suffixId, enchantId;
end

-------------------------------------------------------------------------------
-- Gets the quanity of the specified item
--
-- TODO: Correctly handle containers like ammo packs
-------------------------------------------------------------------------------
function getItemQuantityBySignature(itemSignature)
	local quantity = 0;
	for bag = 0, 4, 1 do
		if (GetBagName(bag)) then
			for item = GetContainerNumSlots(bag), 1, -1 do
				local thisItemSignature = getContainerItemSignature(bag, item);
				if (itemSignature == thisItemSignature) then
					local _, itemCount = GetContainerItemInfo(bag, item);
					quantity = quantity + itemCount;
				end
			end
		end
	end
	return quantity;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function nilSafe(string)
	if (string) then
		return string;
	end
	return "<nil>";
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
chatPrint = Auctioneer.Util.ChatPrint;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
debugPrint = EnhTooltip.DebugPrint;

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
AucPostManager =
{
	-- Exported functions
	PostAuction = postAuction;
	CreateItemSignature = createItemSignature;
	BreakItemSignature = breakItemSignature;
	GetItemQuantityBySignature = getItemQuantityBySignature;
};

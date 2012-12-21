------------------------------------------------------
-- GFWTooltip.lua
-- Generic tooltip hooking
-- Credit where due: mostly based on GDI's Reagent Info (which in turn uses code from ItemsMatrix, LootLink, and Auctioneer)
-- Additional inspiration from Reagent Watch and EnhTooltip
------------------------------------------------------
local GFWTOOLTIP_THIS_VERSION = 8;
------------------------------------------------------

------------------------------------------------------
-- External API
------------------------------------------------------

--[[ GFWTooltip_AddCallback(modName, callbackFunction)

Allows you to have a function called whenever a tooltip is displayed. 
The function is called with arguments (frame, name, link, source):

	frame: the instance of GameTooltip being shown, which you can modify via its API
	name: the first line of the tooltip, typically an item name.
	link: a hyperlink to the item being shown in the tooltip
	source: a non-localized string identifying why this tooltip is being shown 
			(e.g. "MERCHANT" for an item seen in the MerchantFrame)
	
Your callback function should return true if it modifies the tooltip, so we know not to modify the same tooltip twice.

Example:

	function MyTooltipCallback(frame, name, link, source)
		frame:AddLine("some stuff");
		return true;
	end
	function MyMod_OnLoad()
		GFWTooltip_AddCallback("MyMod", MyTooltipCallback);
	end
]]

local function addCallback(modName, callbackFunction)
	GFWTooltip_Callbacks[modName] = callbackFunction;
end

------------------------------------------------------
-- Initial setup
------------------------------------------------------

if (GFWTooltip == nil) then
	GFWTooltip = {};
end
if (GFWTooltip_Callbacks == nil) then
	GFWTooltip_Callbacks = {};
end
if (GFWTooltip_OriginalFunctions == nil) then
	GFWTooltip_OriginalFunctions = {};
end
local hookTableName = "GFWTooltip_"..GFWTOOLTIP_THIS_VERSION.."_HookFunctions";
if (getglobal(hookTableName) == nil) then
	setglobal(hookTableName, {});
end
local G = GFWTooltip;
local Orig = GFWTooltip_OriginalFunctions;
local Hook = getglobal(hookTableName);

------------------------------------------------------
-- Internal functions
------------------------------------------------------

local checkTimer; -- Timer for frequency of tooltip checks
local gameToolTipOwner; -- The current owner of the GameTooltip
local currentTooltip; -- Current Tooltip frame
local itemsMatrixEnabled; -- Boolean to watch if ItemsMatrix is running

local function hookFunction(functionName)
	if (Orig[functionName] == nil) then
		Orig[functionName] = getglobal(functionName);
	end
	setglobal(functionName, Hook[functionName]);
end

local function hookMethod(objectName, functionName)
	local signature = objectName.."_"..functionName;
	local object = getglobal(objectName);
	if (Orig[signature] == nil) then
		Orig[signature] = object[functionName];
	end
	object[functionName] = Hook[signature];
end

-- We call this at the bottom of this file to get things started. 
local function setupHookFunctions()

	-- Hooks for Blizzard's GameTooltip functions
	hookMethod("GameTooltip", "SetHyperlink");
	hookMethod("GameTooltip", "SetLootItem");
	hookMethod("GameTooltip", "SetQuestItem");
	hookMethod("GameTooltip", "SetQuestLogItem");
	hookMethod("GameTooltip", "SetInventoryItem");
	hookMethod("GameTooltip", "SetMerchantItem");
	hookMethod("GameTooltip", "SetCraftItem");
	hookMethod("GameTooltip", "SetTradeSkillItem");
	hookMethod("GameTooltip", "SetAuctionSellItem");
	hookMethod("GameTooltip", "SetOwner");
	hookFunction("GameTooltip_OnHide");
	
	-- Hooks for other Blizzard functions
	hookFunction("ContainerFrameItemButton_OnEnter");
	hookFunction("ContainerFrame_Update");
	hookFunction("SetItemRef");

	-- Dynamic-load Blizzard functions
	hookFunction("AuctionFrame_LoadUI");

	-- Hook ItemsMatrix's functions if they're available
	if (type(ItemsMatrix_AddExtraTooltipInfo) == "function") then
		itemsMatrixEnabled = true;
	end

	-- Hook AIOI's stuff if it's available and we're not running ItemsMatrix
	if(AllInOneInventory_Enabled and not itemsMatrixEnabled) then
		hookFunction("AllInOneInventory_ModifyItemTooltip");
	end

	-- Hook for MyInventory
	if (MyInventoryProfile and not itemsMatrixEnabled) then
		hookFunction("MyInventory_ContainerFrameItemButton_OnEnter");
		hookFunction("MyInventoryFrame_Update");
	end

	-- Hook for the LootLink window's tooltip (not using LL's tooltip hook because we already cover everything else it does)
	if (LootLinkItemButton_OnEnter) then
		hookFunction("LootLinkItemButton_OnEnter");
	end
end

local function addTooltipInfo(frame, name, link, source)
	if (frame.gfwDone == 1) then return; end -- we've already been here

	local changedTooltip = false;
	for modName, callback in GFWTooltip_Callbacks do
		if (callback ~= nil and type(callback) == "function") then
			local modifiedInCallback = callback(frame, name, link, source);
			changedTooltip = changedTooltip or modifiedInCallback;
			if (modifiedInCallback) then
				--GFWUtils.DebugLog("Ran tooltip callback for ".. modName..", tooltip modified.");
			else
				--GFWUtils.DebugLog("Ran tooltip callback for ".. modName..", tooltip not modified.");
			end
		end
	end
	--GFWUtils.DebugLog("Done with tooltip callbacks.");
	if (changedTooltip) then
		frame.gfwDone = 1;
		frame:Show();
	end

end

-- Checks the tooltip info for an item name.  If one is found and we haven't updated the tip already, process it.
local function checkTooltipInfo(frame, link, source)
	if (link and link ~= GFWTooltip_LastLink) then
		frame.gfwDone = nil;
	end
	if (link == nil) then
		link = GFWTooltip_LastLink;
	end

	-- If we've already added our information, no need to do it again
	currentTooltip = frame;
	if ( frame == nil ) then
		return;
	end
	if (not frame:IsVisible()) then
		frame.gfwDone = nil;
	end
	local _, _, itemLink = string.find(link, "(item:%d+:%d+:%d+:%d+)");
	if (itemLink) then 
		local name = GetItemInfo(itemLink);
		if (name and name ~= GFWTooltip_LastName) then
			frame.gfwDone = nil;
		end
		if ( not frame.gfwDone) then
			addTooltipInfo(frame, name, link, source);
			GFWTooltip_LastLink = link;
			GFWTooltip_LastName = name;
			return;
		end
	end
end

local function nameFromLink(link)
	local name;
	if ( not link ) then
		return nil;
	end
	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end
	return nil;
end

-- Calling this will allow us to automatically add information to tooltips when needed
local function autoInfoOn()
	lSuppressInfoAdd = nil;
end

-- Calling this will prevent us from automatically adding information to tooltips
local function autoInfoOff()
	lSuppressInfoAdd = 1;
end

local function findItemInBags(findName)
	for bag = 0, 4, 1 do
		size = GetContainerNumSlots(bag);
		if (size) then
			for slot = size, 1, -1 do
				local link = GetContainerItemLink(bag, slot);
				if (link) then
					local itemName = nameFromLink(link);
					if (itemName == findName) then
						return bag, slot;
					end
				end
			end
		end
	end
end


--------------------
-- Hook Functions --
--------------------

function Hook.AuctionFrame_LoadUI()
	Orig.AuctionFrame_LoadUI();

	if (Orig.AuctionFrameItem_OnEnter == nil) then
		hookFunction("AuctionFrameItem_OnEnter");

		GFWUtils.DebugLog("GFWTooltip AuctionFrame hooks installed.");
	end
end

function Hook.GameTooltip_SetHyperlink(tooltip, link)
	Orig.GameTooltip_SetHyperlink(tooltip, link);

	local name = GetItemInfo(link);
	addTooltipInfo(tooltip, name, link, "LINK");
end

function Hook.GameTooltip_SetLootItem(this, slot)
	Orig.GameTooltip_SetLootItem(this, slot);

	local link = GetLootSlotLink(slot);
	local name = nameFromLink(link);
	addTooltipInfo(this, name, link, "LOOT");
end

function Hook.GameTooltip_SetQuestItem(this, qtype, slot)
	Orig.GameTooltip_SetQuestItem(this, qtype, slot);

	local link = GetQuestItemLink(qtype, slot);
	local name = nameFromLink(link);
	addTooltipInfo(this, name, link, "QUEST");
end

function Hook.GameTooltip_SetQuestLogItem(this, qtype, slot)
	Orig.GameTooltip_SetQuestLogItem(this, qtype, slot);

	local link = GetQuestLogItemLink(qtype, slot);
	local name = nameFromLink(link);
	addTooltipInfo(this, name, link, "QUESTLOG");
end

function Hook.GameTooltip_SetMerchantItem(this, slot)
	Orig.GameTooltip_SetMerchantItem(this, slot);

	local link = GetMerchantItemLink(slot);
	local name = nameFromLink(link);
	addTooltipInfo(this, name, link, "MERCHANT");
end

function Hook.AuctionFrameItem_OnEnter(type, index)
	Orig.AuctionFrameItem_OnEnter(type, index);

	local link = GetAuctionItemLink(type, index);
	local name = nameFromLink(link);
	addTooltipInfo(GameTooltip, name, link, "AUCTION");
end

function Hook.GameTooltip_SetInventoryItem(this, unit, slot)
	local hasItem, hasCooldown, repairCost = Orig.GameTooltip_SetInventoryItem(this, unit, slot);
	local link = GetInventoryItemLink(unit, slot);
	local name = nameFromLink(link);
	addTooltipInfo(this, name, link, "INVENTORY");

	return hasItem, hasCooldown, repairCost;
end

function Hook.GameTooltip_SetCraftItem(this, skill, slot)
	Orig.GameTooltip_SetCraftItem(this, skill, slot);
	local link;
	if (slot) then
		link = GetCraftReagentItemLink(skill, slot);
		local name = nameFromLink(link);
		addTooltipInfo(this, name, link, "CRAFT_REAGENT");
	else
		link = GetCraftItemLink(skill);
		local name = nameFromLink(link);
		addTooltipInfo(this, name, link, "CRAFT_ITEM");
	end
end

function Hook.GameTooltip_SetTradeSkillItem(this, skill, slot)
	Orig.GameTooltip_SetTradeSkillItem(this, skill, slot);
	local link;
	if (slot) then
		link = GetTradeSkillReagentItemLink(skill, slot);
		local name = nameFromLink(link);
		addTooltipInfo(this, name, link, "TRADESKILL_REAGENT");
	else
		link = GetTradeSkillItemLink(skill);
		local name = nameFromLink(link);
		addTooltipInfo(this, name, link, "TRADESKILL_ITEM");
	end
end

function Hook.GameTooltip_SetAuctionSellItem(this)
	Orig.GameTooltip_SetAuctionSellItem(this);
    local name, texture, quantity, quality, canUse, price = GetAuctionSellItemInfo();
	if (name) then
		local bag, slot = findItemInBags(name);
		if (bag) then
			local link = GetContainerItemLink(bag, slot);
			addTooltipInfo(this, name, link, "AUCTION_SELL");
		end
	end
end

function Hook.ContainerFrameItemButton_OnEnter()
	Orig.ContainerFrameItemButton_OnEnter();
	autoInfoOff();

	if (itemsMatrixEnabled) then
		autoInfoOn();
		return;
	end

	if (not InRepairMode()) then
		local frameID = this:GetParent():GetID();
		local buttonID = this:GetID();
		local link = GetContainerItemLink(frameID, buttonID);
		local name = nameFromLink(link);

		if( name ) then
			local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
			checkTooltipInfo(GameTooltip, link, "CONTAINER");
			GameTooltip:Show();
		end
	end
	autoInfoOn();
end

function Hook.ContainerFrame_Update(frame)
	Orig.ContainerFrame_Update(frame);
	autoInfoOff();

	if (itemsMatrixEnabled) then
		autoInfoOn();
		return;
	end

	if( not InRepairMode() and GameTooltip:IsVisible() ) then
		local frameID = frame:GetID();
		local frameName = frame:GetName();
		local iButton;
		for iButton = 1, frame.size do
			local button = getglobal(frameName.."Item"..iButton);
			if( GameTooltip:IsOwned(button) ) then
				local buttonID = button:GetID();
				local link = GetContainerItemLink(frameID, buttonID);
				local name = nameFromLink(link);

				if( name ) then
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
					checkTooltipInfo(GameTooltip, link, "CONTAINER");
					GameTooltip:Show();
				end
			end
		end
	end
	autoInfoOn();
end

function Hook.GameTooltip_OnHide()
	Orig.GameTooltip_OnHide();
	GFWTooltip_LastLink = nil;
	GFWTooltip_LastName = nil;
	GameTooltip.gfwDone = nil;
	if ( currentTooltip ) then
		currentTooltip.gfwDone = nil;
		currentTooltip = nil;
	end
end

function Hook.GameTooltip_SetOwner(this, owner, anchor)
	Orig.GameTooltip_SetOwner(this, owner, anchor);
	gameToolTipOwner = owner;
end

function Hook.SetItemRef(link, text, button)
	if (not ItemRefTooltip:IsVisible()) then
		ItemRefTooltip.gfwDone = nil;
	end
	Orig.SetItemRef(link, text, button);
	checkTooltipInfo(ItemRefTooltip, link, "ITEMREF");
end

-- AIOI Hooks
function Hook.AllInOneInventory_ModifyItemTooltip(bag, slot, tooltipName)
	Orig.AllInOneInventory_ModifyItemTooltip(bag, slot, tooltipName);

	-- Verify AIOI is installed and running
	if(not AllInOneInventory_Enabled or itemsMatrixEnabled) then
		return;	
	end

	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		tooltip = getglobal("GameTooltip");
		tooltipName = "GameTooltip";
	end
	if ( not tooltip ) then
		return false;
	end

	if ( not InRepairMode() ) then
		local link = GetContainerItemLink(bag, slot);
		local name = nameFromLink(link);

		addTooltipInfo(GameTooltip, name, link, "AIOI");
	end
end

-- MyInventory Hooks
function Hook.MyInventory_ContainerFrameItemButton_OnEnter()
	Orig.MyInventory_ContainerFrameItemButton_OnEnter();

	if (GameTooltip:IsVisible() and not InRepairMode()) then
		local bag, slot = MyInventory_GetIdAsBagSlot(this:GetID());
		local _, stack = GetContainerItemInfo(bag, slot);

		local link = GetContainerItemLink(bag, slot);
		local name = nameFromLink(link);

		if(link and name) then
			addTooltipInfo(GameTooltip, name, link, "MYINV");
		end
	end
end

function Hook.MyInventoryFrame_Update(frame)
	Orig.MyInventoryFrame_Update(frame);

	local name = frame:GetName();
	for j=1, frame.size, 1 do
		local itemButton = getglobal(name.."Item"..j);

		if (GameTooltip:IsVisible() and GameTooltip:IsOwned(itemButton)) then
			tooltip = getglobal("GameTooltip");
			tooltipName = "GameTooltip";

			if ( not tooltip ) then
				return false;
			end

			local bag, slot = MyInventory_GetIdAsBagSlot(itemButton:GetID());
			local link = GetContainerItemLink(bag, slot);
			local name = nameFromLink(link);

			if (name ~= nil) then
				addTooltipInfo(GameTooltip, name, link, "MYINV");
			end
		end
	end
end

function Hook.LootLinkItemButton_OnEnter()
	Orig.LootLinkItemButton_OnEnter();
	local name = this:GetText();
	local itemLink = ItemLinks[name];
	local link;
	if (itemLink and itemLink.c and itemLink.i and LootLink_CheckItemServer(itemLink, LootLinkState.ServerNamesToIndices[GetCVar("realmName")])) then
		local item = string.gsub(itemLink.i, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:%4");
		link = "|c"..itemLink.c.."|Hitem:"..item.."|h["..name.."]|h|r";
	end
	if (link) then
		addTooltipInfo(LootLinkTooltip, name, link, "LOOTLINK");
	end
end

------------------------------------------------------
-- load only if not already loaded
------------------------------------------------------

if (G.Version == nil or (tonumber(G.Version) and G.Version < GFWTOOLTIP_THIS_VERSION)) then

	-- Initialize state variables
	checkTimer = 0; -- Timer for frequency of tooltip checks
	itemsMatrixEnabled = false; -- Boolean to watch if ItemsMatrix is running

	-- Export functions
	setupHookFunctions();
	G.AddCallback = addCallback;
	GFWTooltip_AddCallback = addCallback;
	GFWTooltip.FindItemInBags = findItemInBags;
	GFWTooltip.NameFromLink = nameFromLink;
	
	-- Set version number
	G.Version = GFWTOOLTIP_THIS_VERSION;

	GFWUtils.Print("GFWTooltip v"..GFWTOOLTIP_THIS_VERSION.." loaded.");

end



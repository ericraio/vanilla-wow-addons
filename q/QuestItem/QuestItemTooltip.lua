----------------------------------------------------------
-- Add tooltip information to the existing GameTooltip
----------------------------------------------------------
----------------------------------------------------------
function QuestItem_AddTooltip(frame, name, link, quantity, itemCount)
	--QuestItem_OldTooltip(frame, name, link, quality, itemCount);
	if(QuestItem_Settings["Enabled"] == nil or QuestItem_Settings["Enabled"] == false) then
		return;
	end
	
	local tooltip = frame;
	local embed = true;
    if ( not tooltip ) then
		return;
    end
	
    local tooltipInfo = QuestItem_ScanTooltip(frame);
    if ( tooltipInfo[1] ) then
		-- Item not found in the database - look for it of it is a quest item
		if(not QuestItems[name] or QuestItem_SearchString(QuestItems[name].QuestName, QUESTITEM_UNIDENTIFIED) ) then
			-- Check if the item is a Quest Item
			if(QuestItem_IsQuestItem(tooltip) ) then
				local name = tooltipInfo[1].left;

				local QuestName, total, count, texture = QuestItem_FindQuest(name);
				if(not QuestName) then
					QuestItem_UpdateItem(name, QUESTITEM_UNIDENTIFIED, quantity, 0, 3)
				else
					QuestItem_UpdateItem(name, QuestName, count, total, 0)
				end
			end
		end
		-- Quest was found in the database
		if(QuestItems[name]) then
			-- There is data for the current player
			if(QuestItems[name][UnitName("player")]) then
				-- Total and Count is set, and is grater than 0 - don't want to display i.e 1/0
				if( (QuestItems[name].Total and QuestItems[name].Total > 0) and (QuestItems[name][UnitName("player")].Count and QuestItems[name][UnitName("player")].Count > 0) ) then
					tooltip:AddLine(QuestItems[name].QuestName .. " " .. QuestItems[name][UnitName("player")].Count .. "/" .. QuestItems[name].Total, 0.4, 0.5, 0.8);
				else
					tooltip:AddLine(QuestItems[name].QuestName, 0.4, 0.5, 0.8);
				end
				
				-- Check status for quest - if it can't be found change status to abandoned/complete
				if(QuestItems[name][UnitName("player")].QuestStatus ~= 0) then
					if(not QuestItem_FindQuest(name)) then
						QuestItems[name][UnitName("player")].QuestStatus = 1;
					end
				end
				-- Do not display status on the quest if it is unidentified
				if(not QuestItem_SearchString(QuestItems[name].QuestName, QUESTITEM_UNIDENTIFIED) ) then
					-- Display quest status
					if(QuestItems[name][UnitName("player")].QuestStatus == 0) then
						tooltip:AddLine(QUESTITEM_QUESTACTIVE, 0, 1, 0);
					elseif(QuestItems[name][UnitName("player")].QuestStatus == 1 or QuestItems[name][UnitName("player")].QuestStatus == 2) then
						tooltip:AddLine(QUESTITEM_COMPLETEABANDONED, 0.7, 0.7, 07);
					end
				end
			else
				tooltip:AddLine(QuestItems[name].QuestName, 0.4, 0.5, 0.8);
			end
			tooltip:Show();
		end
	end
end

local base_ContainerFrameItemButton_OnEnter;
local base_Chat_OnHyperlinkShow;
local base_GameTooltip_SetLootItem;
local base_ContainerFrame_Update;
local base_GameTooltip_SetInventoryItem;
local base_AIOI_ModifyItemTooltip;
local base_LootLinkItemButton_OnEnter;
local base_IMInv_ItemButton_OnEnter
local base_ItemsMatrixItemButton_OnEnter;
local base_ContainerFrameItemButton_OnClick;
local base_QuestItem_AIOI_ContainerFrameItemButton_OnClick;
local base_BankFrameItemButtonGeneric_OnClick;
local base_BankFrameItemButtonBag_OnClick;
--local base_EngInventory_ModifyItemTooltip;

----------------------------------
-- [[ Hook tooltip functions ]] --
----------------------------------
function QuestItem_HookTooltip()
	-- Hook in alternative Chat/Hyperlinking code
	base_Chat_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = QuestItem_Chat_OnHyperlinkShow;
		
	-- ContainerFrame
	base_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
	ContainerFrameItemButton_OnEnter = QuestItem_ContainerFrameItemButton_OnEnter;
	base_ContainerFrame_Update = ContainerFrame_Update;
	ContainerFrame_Update = QuestItem_ContainerFrameItemButton_Update;

	base_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
	GameTooltip.SetLootItem = QuestItem_GameTooltip_SetLootItem;
	
	base_GameTooltip_SetInventoryItem = GameTooltip.SetInventoryItem;
	GameTooltip.SetInventoryItem = QuestItem_GameTooltip_SetInventoryItem;

	--[[ LootLink support - grabbed from Norganna's EnhTooltip ]]--
	-- Hook the LootLink tooltip function
	if(LootLinkItemButton_OnEnter ~= nil) then
		base_LootLinkItemButton_OnEnter = LootLinkItemButton_OnEnter;
		LootLinkItemButton_OnEnter = QuestItem_LootLinkItemButton_OnEnter;
		QuestItem_Debug("Hooking to LootLink");
	end

	--[[ AllInOneInventory support - grabbed from Norganna's EnhTooltip ]]--
	if (AllInOneInventory_ModifyItemTooltip ~= nil) then
		base_AIOI_ModifyItemTooltip = AllInOneInventory_ModifyItemTooltip;
		AllInOneInventory_ModifyItemTooltip = QuestItem_AIOI_ModifyItemTooltip;
		QuestItem_Debug("Hooking to AIOI");
	end
	
	-- Hook click on inventory item
	if(AllInOneInventoryFrameItemButton_OnClick ~= nil) then
		base_ContainerFrameItemButton_OnClick = AllInOneInventoryFrameItemButton_OnClick;
		AllInOneInventoryFrameItemButton_OnClick = QuestItem_ContainerFrameItemButton_OnClick;
	else
		base_ContainerFrameItemButton_OnClick = ContainerFrameItemButton_OnClick;
		ContainerFrameItemButton_OnClick = QuestItem_ContainerFrameItemButton_OnClick;
	end
	
	-- Hook bank item 
	base_BankFrameItemButtonGeneric_OnClick = BankFrameItemButtonGeneric_OnClick;
	BankFrameItemButtonGeneric_OnClick = QuestItem_BankFrameItemButtonGeneric_OnClick;
	
	--base_BankFrameItemButtonBag_OnClick = BankFrameItemButtonBag_OnClick;
	--BankFrameItemButtonBag_OnClick = QuestItem_BankFrameItemButtonBag_OnClick;
	
	
	-- [[
	if(EngInventory_ModifyItemTooltip ~= nil) then
		base_EngInventory_ModifyItemTooltip = EngInventory_ModifyItemTooltip;
		EngInventory_ModifyItemTooltip = QuestItem_AIOI_ModifyItemTooltip;
		QuestItem_Debug("Hooking to EngInventory");
	end
	-- ]] --
end

--[[ LootLink support - grabbed from Norganna's EnhTooltip ]]--
function QuestItem_getLootLinkLink(name)
	local itemLink = ItemLinks[name];
	if (itemLink and itemLink.c and itemLink.i and LootLink_CheckItemServer(itemLink, QuestItem_getLootLinkServer())) then
		local item = string.gsub(itemLink.i, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:%4");
		local link = "|c"..itemLink.c.."|Hitem:"..item.."|h["..name.."]|h|r";
		return link;
	end
	return nil;
end

function QuestItem_getLootLinkServer()
	return LootLinkState.ServerNamesToIndices[GetCVar("realmName")];
end

--[[ LootLink support - grabbed from Norganna's EnhTooltip ]]--
function QuestItem_LootLinkItemButton_OnEnter()
	base_LootLinkItemButton_OnEnter();

	local name = this:GetText();
	local link = QuestItem_getLootLinkLink(name);
	if (link) then
		local quality = QuestItem_qualityFromLink(link);
		QuestItem_AddTooltip(LootLinkTooltip, name, link, quality, 0)
	end
end

--------------------------------------------------
-- [[ Hook up with AllInOneInventory tooltip ]] --
--------------------------------------------------
function QuestItem_AIOI_ModifyItemTooltip(bag, slot, tooltipName, empty)
	if(base_AIOI_ModifyItemTooltip ~= nil) then
		base_AIOI_ModifyItemTooltip(bag, slot, tooltipName);
	elseif(base_EngInventory_ModifyItemTooltip ~= nil) then
		base_EngInventory_ModifyItemTooltip(bag, slot, tooltipName, nil);
	end
	local tooltip = getglobal(tooltipName);
	if (not tooltip) then
		tooltip = getglobal("GameTooltip");
	end
	
	if (not tooltip) then 
		return false; 
	end

	local link = GetContainerItemLink(bag, slot);
	local name = QuestItem_nameFromLink(link);
	if (name) then
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
		if (quality == nil) then 
			quality = QuestItem_qualityFromLink(link); 
		end
		QuestItem_AddTooltip(GameTooltip, name, link, itemCount, 0)
	end
end
--------------------------------------
-- [[ Set tooltip for bank items ]] --
--------------------------------------
function QuestItem_GameTooltip_SetInventoryItem(userData, unit, slot)
	local hasItem, hasCooldown, repairCost = base_GameTooltip_SetInventoryItem(userData, unit, slot);
	local link = GetInventoryItemLink(unit, slot);
	if (link) then
		local name = QuestItem_nameFromLink(link);
		local quantity = GetInventoryItemCount(unit, slot);
		local quality = GetInventoryItemQuality(unit, slot);
		if (quality == nil) 
			then quality = QuestItem_qualityFromLink(link); 
		end
		QuestItem_AddTooltip(GameTooltip, name, link, quality, quantity)
	end
	return hasItem, hasCooldown, repairCost;
end

--------------------------------------
-- [[ Set tooltip for loot items ]] --
--------------------------------------
function QuestItem_GameTooltip_SetLootItem(this, slot)
	base_GameTooltip_SetLootItem(this, slot);
	local link = GetLootSlotLink(slot);
	local name = QuestItem_nameFromLink(link);
	if (name) then
		local texture, item, quantity, quality = GetLootSlotInfo(slot);
		
		if (quality == nil) then 
			quality = QuestItem_qualityFromLink(link); 
		end

		QuestItem_AddTooltip(GameTooltip, name, link, quantity, quantity)
	end
end

------------------------------------------------------
-- [[ QuestItem_ContainerFrameItemButton_OnEnter ]] --
------------------------------------------------------
function QuestItem_ContainerFrameItemButton_OnEnter()
	base_ContainerFrameItemButton_OnEnter();
	local frameID = this:GetParent():GetID();
	local buttonID = this:GetID();
	local link = GetContainerItemLink(frameID, buttonID);
	local name = QuestItem_nameFromLink(link);
	
	if (name) then
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
		if (quality==nil or quality==-1) then 
			quality = QuestItem_qualityFromLink(link); 
		end

		QuestItem_AddTooltip(GameTooltip, name, link, quantity, itemCount)
	end
end

------------------------------------
-- Hook for click on container items
------------------------------------
------------------------------------
function QuestItem_ContainerFrameItemButton_OnClick(button, ignoreModifiers)
	local executeBase = true;
	if(QuestItem_Settings["AltOpen"] == true) then
		if(button == "RightButton" and not ignoreModifiers and IsAltKeyDown()) then
			local bag, slot;
			-- Look for bag and slot id
			if(AllInOneInventoryFrameItemButton_OnClick ~= nil) then
				bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());
			else
				bag = this:GetParent():GetID();		
				slot = this:GetID();
			end
			
			local link = GetContainerItemLink(bag, slot);
			QuestItem_OpenLink(link);
		end
	end
	-- Execute base method
	if(executeBase) then
		base_ContainerFrameItemButton_OnClick(button, ignoreModifiers);
	end
end

function QuestItem_OpenLink(link)
	local name = QuestItem_nameFromLink(link);
	-- Open questlog for quest
	if(name) then
		if(QuestItems[name] and QuestItems[name].QuestName) then
			QuestItem_OpenQuestLog(QuestItems[name].QuestName);
			executeBase = false;
		end
	end
end

function QuestItem_BankFrameItemButtonGeneric_OnClick(button)
	local executeBase = true;
	if(QuestItem_Settings["AltOpen"] == true) then
		if(button == "RightButton" and not ignoreModifiers and IsAltKeyDown()) then
			local link = GetContainerItemLink(BANK_CONTAINER, this:GetID());
			QuestItem_OpenLink(link);
			executeBase = false;
		end
	end
	if(executeBase) then
		base_BankFrameItemButtonGeneric_OnClick(button, ignoreModifiers);
	end
end

function QuestItem_BankFrameItemButtonBag_OnClick(button)
	--QuestItem_Debug(this:GetID());
end



----------------------------------------
-- [[ Set tooltip for linked items ]] --
----------------------------------------
function QuestItem_Chat_OnHyperlinkShow(reference, link, button)
	base_Chat_OnHyperlinkShow(reference, link, button);
	if(button == "LeftButton") then
		if (ItemRefTooltip:IsVisible()) then
			local name = ItemRefTooltipTextLeft1:GetText();
			if (name) then
				local fabricatedLink = "|cff000000|H"..link.."|h["..name.."]|h|r";
				
				QuestItem_AddTooltip(ItemRefTooltip, name, fabricatedLink, -1, 1, 0);
			end
		end
	end
end

function QuestItem_ContainerFrameItemButton_Update(frame)
	base_ContainerFrame_Update(frame);
end

----------------------------------
-- [[ QuestItem_NameFromLink ]] --
----------------------------------
function QuestItem_nameFromLink(link)
	local name;
	if( not link ) then
		return nil;
	end
	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end
	return nil;
end

---------------------------
-- [[ qualityFromLink ]] --
---------------------------
function QuestItem_qualityFromLink(link)
	local color;
	if (not link) then return nil; end
	for color in string.gfind(link, "|c(%x+)|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r") do
		if (color == "ffa335ee") then return 4;--[[ Epic ]] end
		if (color == "ff0070dd") then return 3;--[[ Rare ]] end
		if (color == "ff1eff00") then return 2;--[[ Uncommon ]] end
		if (color == "ffffffff") then return 1;--[[ Common ]] end
		if (color == "ff9d9d9d") then return 0;--[[ Poor ]] end
	end
	return -1;
end
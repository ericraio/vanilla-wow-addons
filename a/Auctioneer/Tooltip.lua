--[[
  Additional function hooks to allow hooks into more tooltips
  3.0.4
  $Id: Tooltip.lua,v 1.14 2005/06/14 04:37:04 norganna Exp $
]]

-- Example: /script TT_Clear(); TT_AddLine("ItemName"); TT_LineQuality(3); TT_AddLine("Average bid: ", 105000); TT_AddLine("Median bid: ", 110000); TT_AddLine("Vendor buy: ", 9050); TT_AddLine("Vendor sell: ", 25000); TT_Show(GameTooltip);

if (TOOLTIPS_INCLUDED == nil) then
TOOLTIPS_INCLUDED = true;

TT_CurrentTip = nil;

local Orig_Chat_OnHyperlinkShow;
local Orig_AuctionFrameItem_OnEnter;
local Orig_ContainerFrameItemButton_OnEnter;
local Orig_ContainerFrame_Update;
local Orig_GameTooltip_SetLootItem;
local Orig_GameTooltip_SetQuestItem;
local Orig_GameTooltip_SetQuestLogItem;
local Orig_GameTooltip_SetInventoryItem;
local Orig_GameTooltip_SetMerchantItem;
local Orig_GameTooltip_SetTradeSkillItem;
local Orig_GameTooltip_SetAuctionSellItem;
local Orig_GameTooltip_SetOwner;
local Orig_IMInv_ItemButton_OnEnter;
local Orig_ItemsMatrixItemButton_OnEnter;
local Orig_LootLinkItemButton_OnEnter;
local Orig_GameTooltip_OnHide;

function TT_OnLoad()
        if (TT_LOADED ~= nil) then 
                return; 
        end
		EnhancedTooltip:SetBackdropColor(0,0,0);
		TT_Clear();

        -- Hook in alternative Chat/Hyperlinking code
        Orig_Chat_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
        ChatFrame_OnHyperlinkShow = TT_Chat_OnHyperlinkShow;

        -- Hook in alternative Auctionhouse tooltip code
        Orig_AuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter;
        AuctionFrameItem_OnEnter = TT_AuctionFrameItem_OnEnter;

		-- Container frame linking
		Orig_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
		ContainerFrameItemButton_OnEnter = TT_ContainerFrameItemButton_OnEnter;
		Orig_ContainerFrame_Update = ContainerFrame_Update;
		ContainerFrame_Update = TT_ContainerFrame_Update;

		-- Game tooltips
		Orig_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
		GameTooltip.SetLootItem = TT_GameTooltip_SetLootItem;
		Orig_GameTooltip_SetQuestItem = GameTooltip.SetQuestItem;
		GameTooltip.SetQuestItem = TT_GameTooltip_SetQuestItem;
		Orig_GameTooltip_SetQuestLogItem = GameTooltip.SetQuestLogItem;
		GameTooltip.SetQuestLogItem = TT_GameTooltip_SetQuestLogItem;
		Orig_GameTooltip_SetInventoryItem = GameTooltip.SetInventoryItem;
		GameTooltip.SetInventoryItem = TT_GameTooltip_SetInventoryItem;
		Orig_GameTooltip_SetMerchantItem = GameTooltip.SetMerchantItem;
		GameTooltip.SetMerchantItem = TT_GameTooltip_SetMerchantItem;
		Orig_GameTooltip_SetTradeSkillItem = GameTooltip.SetTradeSkillItem;
		GameTooltip.SetTradeSkillItem = TT_GameTooltip_SetTradeSkillItem;
		Orig_GameTooltip_SetAuctionSellItem = GameTooltip.SetAuctionSellItem;
		GameTooltip.SetAuctionSellItem = TT_GameTooltip_SetAuctionSellItem;

		Orig_GameTooltip_SetOwner = GameTooltip.SetOwner;
		GameTooltip.SetOwner = TT_GameTooltip_SetOwner;

		-- Hook the ItemsMatrix tooltip functions
		Orig_IMInv_ItemButton_OnEnter = IMInv_ItemButton_OnEnter;
		IMInv_ItemButton_OnEnter = TT_IMInv_ItemButton_OnEnter;
		Orig_ItemsMatrixItemButton_OnEnter = ItemsMatrixItemButton_OnEnter;
		ItemsMatrixItemButton_OnEnter = TT_ItemsMatrixItemButton_OnEnter;

		-- Hook the LootLink tooltip function
		Orig_LootLinkItemButton_OnEnter = LootLinkItemButton_OnEnter;
		LootLinkItemButton_OnEnter = TT_LootLinkItemButton_OnEnter;

		-- Hook the AllInOneInventory tooltip function
		if (AllInOneInventory_ModifyItemTooltip ~= nil) then
			Orig_AllInOneInventory_ModifyItemTooltip = AllInOneInventory_ModifyItemTooltip;
			AllInOneInventory_ModifyItemTooltip = TT_AllInOneInventory_ModifyItemTooltip;
			TT_AIOI_Hooked = true;
		else
			TT_AIOI_Hooked = false;
			this:RegisterEvent("PLAYER_ENTERING_WORLD");
		end

		-- Hook the hide function so we can disappear
		Orig_GameTooltip_OnHide = GameTooltip_OnHide;
		GameTooltip_OnHide = TT_GameTooltip_OnHide;


        TT_LOADED = true;
end

function TT_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then

		-- Since AIOI lists Auctioneer as an option dependancy, we may not have 
		-- registered the event hooks above... Check here to make certain!
		if (not TT_AIOI_Hooked) then
			if (AllInOneInventory_ModifyItemTooltip ~= nil) then
				Orig_AllInOneInventory_ModifyItemTooltip = AllInOneInventory_ModifyItemTooltip;
				AllInOneInventory_ModifyItemTooltip = TT_AllInOneInventory_ModifyItemTooltip;
				this:UnregisterEvent(event);
				TT_AIOI_Hooked = true;
			end
		else
			this:UnregisterEvent(event);
		end
	end
end


local function getRect(object)
	local rect = {};
	rect.t = object:GetTop() or 0; 
	rect.l = object:GetLeft() or 0;
	rect.b = object:GetBottom() or 0;
	rect.r = object:GetRight() or 0;
	rect.w = object:GetWidth() or 0;
	rect.h = object:GetHeight() or 0;
	rect.cx = rect.l + (rect.w / 2);
	rect.cy = rect.t - (rect.h / 2);
	return rect;
end

function TT_Show(currentTooltip)
	if (Auctioneer_GetFilter(AUCT_CMD_EMBED)) then
		currentTooltip:Show();
		return;
	end

	local height = 20;
	local width = EnhancedTooltip.minWidth;
	local lineCount = EnhancedTooltip.lineCount;
	if (lineCount == 0) then TT_Hide(); return; end

	local firstLine = EnhancedTooltipText1;
	local trackHeight = firstLine:GetHeight();
	for i = 2, lineCount do
		local currentLine = getglobal("EnhancedTooltipText"..i);
		trackHeight = trackHeight + currentLine:GetHeight() + 1;
	end
	height = 20 + trackHeight;

	local minWidth = width;

	if (EnhancedTooltipPreview:IsVisible()) then
		if (width < 256) then width = 256; end
		EnhancedTooltipPreview:SetHeight(128 + 40);
		EnhancedTooltipPreview:ClearAllPoints();
		EnhancedTooltipPreview:SetWidth(width + 40);
		EnhancedTooltipPreview:SetPoint("TOP", "EnhancedTooltip", "TOP", 0, 76-height);
		height = height + 72;
	end

	local sWidth = GetScreenWidth();
	local sHeight = GetScreenHeight();

	local parentObject = currentTooltip.owner;
	if (parentObject) then
		local align = currentTooltip.anchor;

		local parentRect = getRect(currentTooltip.owner);
		
		local xAnchor, yAnchor;
		if (align == "ANCHOR_RIGHT") then
			xAnchor = "RIGHT";
		elseif (align == "ANCHOR_LEFT") then
			xAnchor = "LEFT";
		elseif (parentRect.cx < 6*sWidth/10) then
			xAnchor = "RIGHT";
		else
			xAnchor = "LEFT";
		end
		if (parentRect.cy < sHeight/2) then
			yAnchor = "TOP";
		else
			yAnchor = "BOTTOM";
		end

		currentTooltip:ClearAllPoints();
		EnhancedTooltip:ClearAllPoints();
		local anchor = yAnchor..xAnchor;

		if (anchor == "TOPLEFT") then
			EnhancedTooltip:SetPoint("BOTTOMRIGHT", parentObject:GetName(), "TOPLEFT", -5,5);
			currentTooltip:SetPoint("BOTTOMRIGHT", "EnhancedTooltip", "TOPRIGHT", 0,5);
		elseif (anchor == "TOPRIGHT") then
			EnhancedTooltip:SetPoint("BOTTOMLEFT", parentObject:GetName(), "TOPRIGHT", 5,5);
			currentTooltip:SetPoint("BOTTOMLEFT", "EnhancedTooltip", "TOPLEFT", 0,0);
		elseif (anchor == "BOTTOMLEFT") then
			currentTooltip:SetPoint("TOPRIGHT", parentObject:GetName(), "BOTTOMLEFT", -5,-5);
			EnhancedTooltip:SetPoint("TOPRIGHT", currentTooltip:GetName(), "BOTTOMRIGHT", 0,0);
		else -- BOTTOMRIGHT
			currentTooltip:SetPoint("TOPLEFT", parentObject:GetName(), "BOTTOMRIGHT", 5,-5);
			EnhancedTooltip:SetPoint("TOPLEFT", currentTooltip:GetName(), "BOTTOMLEFT", 0,0);
		end

		if (EquipCompare_OnUpdate ~= nil) then EquipCompare_OnUpdate(); end
		if (ComparisonTooltip1 and ComparisonTooltip1:IsVisible() and ComparisonTooltip1:GetHeight()+10 > currentTooltip:GetHeight()) then
			if (xAnchor == "RIGHT") then
				ComparisonTooltip1:ClearAllPoints();
				ComparisonTooltip1:SetPoint("BOTTOMLEFT", currentTooltip:GetName(), "BOTTOMRIGHT", 0,0);
				ComparisonTooltip2:ClearAllPoints();
				ComparisonTooltip2:SetPoint("BOTTOMLEFT", "ComparisonTooltip1", "BOTTOMRIGHT", 0,0);
			else
				ComparisonTooltip1:ClearAllPoints();
				ComparisonTooltip1:SetPoint("BOTTOMRIGHT", currentTooltip:GetName(), "BOTTOMLEFT", 0,0);
				ComparisonTooltip2:ClearAllPoints();
				ComparisonTooltip2:SetPoint("BOTTOMRIGHT", "ComparisonTooltip1", "BOTTOMLEFT", 0,0);
			end
		end
	else
		-- No parent
		-- The only option is to tack the object underneath / shuffle it up if there aint enuff room
		currentTooltip:Show();
		local tipRect = getRect(currentTooltip);

		if (tipRect.b - height < 60) then
			currentTooltip:ClearAllPoints();
			currentTooltip:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", tipRect.l, height+60);
		end;
		EnhancedTooltip:ClearAllPoints();
		if (tipRect.cx < 6*sWidth/10) then
			EnhancedTooltip:SetPoint("TOPLEFT", currentTooltip:GetName(), "BOTTOMLEFT", 0,0);
		else
			EnhancedTooltip:SetPoint("TOPRIGHT", currentTooltip:GetName(), "BOTTOMRIGHT", 0,0);
		end

		if (ComparisonTooltip1 and ComparisonTooltip1:IsVisible() and ComparisonTooltip1:GetHeight()+10 > currentTooltip:GetHeight()) then
			ComparisonTooltip1:ClearAllPoints();
			ComparisonTooltip1:SetPoint("BOTTOMRIGHT", currentTooltip:GetName(), "BOTTOMLEFT", 0,0);
			ComparisonTooltip2:ClearAllPoints();
			ComparisonTooltip2:SetPoint("BOTTOMRIGHT", "ComparisonTooltip1", "BOTTOMLEFT", 0,0);
		end
	end
	
	
	
	EnhancedTooltip:SetHeight(height);
	EnhancedTooltip:SetWidth(width);
	EnhancedTooltip:Show();
end

function TT_Hide()
	EnhancedTooltip:Hide();
	TT_ChatCurrentItem = "";
end

function TT_Clear()
	TT_Hide();
	EnhancedTooltipPreview:Hide();
	EnhancedTooltipIcon:Hide();
	EnhancedTooltipIcon:SetTexture("Interface\\Buttons\\UI-Quickslot2");
	for i = 1, 20 do
		local ttText = getglobal("EnhancedTooltipText"..i);
		ttText:Hide();
		ttText:SetTextColor(1.0,1.0,1.0);
	end
	for i = 1, 10 do
		local ttMoney = getglobal("EnhancedTooltipMoney"..i);
		ttMoney:Hide();
	end
	EnhancedTooltip.lineCount = 0;
	EnhancedTooltip.moneyCount = 0;
	EnhancedTooltip.minWidth = 0;
end

TT_MoneySpacing = 4;
function TT_AddLine(lineText, moneyAmount)
	if (Auctioneer_GetFilter(AUCT_CMD_EMBED)) and (TT_CurrentTip) then
		if (moneyAmount) then
			TT_CurrentTip:AddLine(lineText .. ": " .. Auctioneer_GetTextGSC(moneyAmount));
		else
			TT_CurrentTip:AddLine(lineText);
		end
		return;
	end

	local curLine = EnhancedTooltip.lineCount + 1;
	local line = getglobal("EnhancedTooltipText"..curLine);
	line:SetText(lineText);
	local lineWidth = line:GetWidth();
	line:SetTextColor(1.0, 1.0, 1.0);
	line:Show();
	EnhancedTooltip.lineCount = curLine;
	if (moneyAmount ~= nil) and (moneyAmount > 0) then
		local curMoney = EnhancedTooltip.moneyCount + 1;
		local money = getglobal("EnhancedTooltipMoney"..curMoney);
		money:SetPoint("LEFT", line:GetName(), "RIGHT", TT_MoneySpacing, 0);
		lineWidth = lineWidth + money:GetWidth() + TT_MoneySpacing;
		MoneyFrame_Update(money:GetName(), math.floor(moneyAmount));
		getglobal("EnhancedTooltipMoney"..curMoney.."SilverButtonText"):SetTextColor(1.0,1.0,1.0);
		getglobal("EnhancedTooltipMoney"..curMoney.."CopperButtonText"):SetTextColor(0.86,0.42,0.19);
		money:Show();
		EnhancedTooltip.moneyCount = curMoney;
	end
	lineWidth = lineWidth + 20;
	if (lineWidth > EnhancedTooltip.minWidth) then
		EnhancedTooltip.minWidth = lineWidth;
	end
end

function TT_LineColor(r, g, b)
	if (Auctioneer_GetFilter(AUCT_CMD_EMBED)) and (TT_CurrentTip) then
		local lastLine = getglobal(TT_CurrentTip:GetName().."TextLeft"..TT_CurrentTip:NumLines());
		lastLine:SetTextColor(r,g,b);
		return;
	end
	local curLine = EnhancedTooltip.lineCount;
	if (curLine == 0) then return; end
	local line = getglobal("EnhancedTooltipText"..curLine);
	line:SetTextColor(r, g, b);
end

function TT_LineQuality(quality)
	if ( quality ) then
		local color = ITEM_QUALITY_COLORS[quality];
		TT_LineColor(color.r, color.g, color.b);
	else
		TT_LineColor(1.0, 1.0, 1.0);
	end
end

function TT_SetIcon(iconPath)
	EnhancedTooltipIcon:SetTexture(iconPath);
	EnhancedTooltipIcon:Show();
	local width = EnhancedTooltipIcon:GetWidth();
	local tWid = EnhancedTooltipText1:GetWidth() + width + 20;
	if (tWid > EnhancedTooltip.minWidth) then
		EnhancedTooltip.minWidth = tWid;
	end
	tWid = EnhancedTooltipText2:GetWidth() + width + 20;
	if (tWid > EnhancedTooltip.minWidth) then
		EnhancedTooltip.minWidth = tWid;
	end
end

function TT_SetModel(class, file)
	local scale = 1.0;
	local pos = 0.6;
	local gender = "M";
	local _, race = UnitRace("player");
	if (strsub(class, -1) == "*") then
		class = strsub(class, 0, -2);
		race = strsub(race, 0, 2);
		if (UnitSex("player") > 0) then gender = "F"; end
		file = file .. "_" .. race .. gender;
	end
	if (gender == "F") then scale = scale * 1.1; end
	if (race == "Ta") or (race == "Or") then scale = scale * 0.9; end
	if (race == "Gn") or (race == "Dw") then scale = scale * 1.1; end
	if (class == "Head") then scale = scale * 1.8; pos = 0.3; end
	if (class == "Shoulder") then scale = scale * 1.8; pos = 0.5; end
	if (class == "Weapon") then
		local typ = strsub(file, 0, 3);
		if (typ == "Axe") then scale = 0.8; pos = 0.9; end
		if (typ == "Bow") then scale = 1.0; pos = 0.5; end
		if (typ == "Clu") then scale = 0.9; pos = 0.8; end
		if (typ == "Fir") then scale = 0.8; pos = 1.0; end
		if (typ == "Gla") then scale = 1.0; end
		if (typ == "Ham") then scale = 0.8; end
		if (typ == "Han") then scale = 1.3; end
		if (typ == "Kni") then scale = 2.0; end
		if (typ == "Mac") then scale = 1.0; end
		if (typ == "Mis") then scale = 1.5; end
		if (typ == "Pol") then scale = 0.8; end
		if (typ == "Sta") then scale = 0.8; pos = 0.3; end
		if (typ == "Swo") then scale = 1.0; pos = 0.8; end
		if (typ == "Thr") then scale = 1.6; pos = 0.8; end
		if (typ == "Tot") then scale = 1.5; end
		if (typ == "Wan") then scale = 1.8; end
	end
--	p("Setting model: ", class, file);
	local model = "Item\\ObjectComponents\\" .. class .. "\\" .. file .. ".mdx";
	EnhancedTooltipPreview:SetModel(model);
	EnhancedTooltipPreview:SetLight(1, 0.2, 0, -0.9, -0.707, 0.7, 0.9, 0.6, 0.25, 0.8, 0.25, 0.6, 0.9);
	EnhancedTooltipPreview:SetPosition(pos, -0.1, 0);
	EnhancedTooltipPreview:SetScale(scale);
	if (EnhancedTooltipPreview.model ~= model) then
		EnhancedTooltipPreview.model = model;
		EnhancedTooltipPreview:SetRotation(1.5);
	end
	EnhancedTooltipPreview:Show();
end

function TT_GameTooltip_OnHide()
	Orig_GameTooltip_OnHide();
	local curName = "";
	local hidingName = this:GetName();
	if (TT_CurrentTip) then curName = TT_CurrentTip:GetName(); end
	if (curName == hidingName) then
		TT_Hide();
	end
end

local function nameFromLink(link)
        local name;
        if( not link ) then
                return nil;
        end
        for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
                return name;
        end
        return nil;
end
local function  qualityFromLink(link)
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
local function fakeLink(item, quality, name)
	if (quality == nil) then quality = -1; end
	if (name == nil) then name = "unknown"; end
	local color = "ffffff";
	if (quality == 4) then color = "a335ee";
	elseif (quality == 3) then color = "0070dd";
	elseif (quality == 2) then color = "1eff00";
	elseif (quality == 0) then color = "9d9d9d";
	end
	return "|cff"..color.. "|H"..item.."|h["..name.."]|h|r";
end

function TT_TooltipCall(frame, name, link, quality, count, price)
	TT_CurrentTip = frame;
	TT_AddTooltip(frame, name, link, quality, count, price);
end

function TT_AddTooltip(frame, name, link, quality, count, price)
	-- Empty function; hook here if you want in on the action!
end

function TT_Chat_OnHyperlinkShow(link)
	Orig_Chat_OnHyperlinkShow(link);

	if (ItemRefTooltip:IsVisible()) then
		local name = ItemRefTooltipTextLeft1:GetText();
		if (name and TT_ChatCurrentItem ~= name) then
			local fabricatedLink = "|H"..link.."|h["..name.."]|h";
			TT_ChatCurrentItem = name;
			
			TT_Clear();
			TT_TooltipCall(ItemRefTooltip, name, fabricatedLink, -1, 1);
			TT_Show(ItemRefTooltip);
		end
	end
end

function TT_AuctionFrameItem_OnEnter(type, index)
	Orig_AuctionFrameItem_OnEnter(type, index);

	local link = GetAuctionItemLink(type, index);
	if (link) then
		local name = nameFromLink(link);
		if (name) then
			local aiName, aiTexture, aiCount, aiQuality, aiCanUse, aiLevel, aiMinBid, aiMinIncrement, aiBuyoutPrice, aiBidAmount, aiHighBidder, aiOwner = GetAuctionItemInfo(type, index);
			TT_Clear();
			TT_TooltipCall(GameTooltip, name, link, aiQuality, aiCount);
			TT_Show(GameTooltip);
		end
	end
end

function TT_ContainerFrameItemButton_OnEnter()
	Orig_ContainerFrameItemButton_OnEnter();

	local frameID = this:GetParent():GetID();
	local buttonID = this:GetID();
	local link = GetContainerItemLink(frameID, buttonID);
	local name = nameFromLink(link);
	
	if (name) then
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
		if (quality == nil) then quality = qualityFromLink(link); end

		TT_Clear();
		TT_TooltipCall(GameTooltip, name, link, quality, itemCount);
		TT_Show(GameTooltip);
	end
end

function TT_ContainerFrame_Update(frame)
	Orig_ContainerFrame_Update(frame);

	local frameID = frame:GetID();
	local frameName = frame:GetName();
	local iButton;
	for iButton = 1, frame.size do
		local button = getglobal(frameName.."Item"..iButton);
		if (GameTooltip:IsOwned(button)) then
			local buttonID = button:GetID();
			local link = GetContainerItemLink(frameID, buttonID);
			local name = nameFromLink(link);
			
			if (name) then
				local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
				if (quality == nil) then quality = qualityFromLink(link); end

				TT_Clear()
				TT_TooltipCall(GameTooltip, name, link, quality, itemCount);
				TT_Show(GameTooltip);
			end
		end
	end
end


function TT_GameTooltip_SetLootItem(this, slot)
	Orig_GameTooltip_SetLootItem(this, slot);
	
	local link = GetLootSlotLink(slot);
	local name = nameFromLink(link);
	if (name) then
		local texture, item, quantity, quality = GetLootSlotInfo(slot);
		if (quality == nil) then quality = qualityFromLink(link); end
		TT_Clear()
		TT_TooltipCall(GameTooltip, name, link, quality, quantity);
		TT_Show(GameTooltip);
	end
end

function TT_GameTooltip_SetQuestItem(this, qtype, slot)
	Orig_GameTooltip_SetQuestItem(this, qtype, slot);
	local link = GetQuestItemLink(qtype, slot);
	if (link) then
		local name, texture, quantity, quality, usable = GetQuestItemInfo(qtype, slot);
		TT_Clear();
		TT_TooltipCall(GameTooltip, name, link, quality, quantity);
		TT_Show(GameTooltip);
	end
end

function TT_GameTooltip_SetQuestLogItem(this, qtype, slot)
	Orig_GameTooltip_SetQuestLogItem(this, qtype, slot);
	local link = GetQuestLogItemLink(qtype, slot);
	if (link) then
		local name, texture, quantity, quality, usable = GetQuestLogRewardInfo(slot);
		if (name == nil) then name = nameFromLink(link); end
		quality = qualityFromLink(link); -- I don't trust the quality returned from the above function.

		TT_Clear();
		TT_TooltipCall(GameTooltip, name, link, quality, quantity);
		TT_Show(GameTooltip);
	end
end

function TT_GameTooltip_SetInventoryItem(this, unit, slot)
	local hasItem, hasCooldown, repairCost = Orig_GameTooltip_SetInventoryItem(this, unit, slot);
	local link = GetInventoryItemLink(unit, slot);
	if (link) then
		local name = nameFromLink(link);
		local quantity = GetInventoryItemCount(unit, slot);
		local quality = GetInventoryItemQuality(unit, slot);
		if (quality == nil) then quality = qualityFromLink(link); end

		TT_Clear();
		TT_TooltipCall(GameTooltip, name, link, quality, quantity);
		TT_Show(GameTooltip);
	end

	return hasItem, hasCooldown, repairCost;
end

function TT_GameTooltip_SetMerchantItem(this, slot)
	Orig_GameTooltip_SetMerchantItem(this, slot);
	local link = GetMerchantItemLink(slot);
	if (link) then
		local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(slot);
		local quality = qualityFromLink(link);
		TT_Clear();
		TT_TooltipCall(GameTooltip, name, link, quality, quantity, price);
		TT_Show(GameTooltip);
	end
end

function TT_GameTooltip_SetTradeSkillItem(this, skill, slot)
	Orig_GameTooltip_SetTradeSkillItem(this, skill, slot);
	local link;
	if (slot) then
		link = GetTradeSkillReagentItemLink(skill, slot);
		if (link) then
			local name, texture, quantity, quantityHave = GetTradeSkillReagentInfo(skill, slot);
			local quality = qualityFromLink(link);
			TT_Clear();
			TT_TooltipCall(GameTooltip, name, link, quality, quantity, 0);
			TT_Show(GameTooltip);
		end
	else
		link = GetTradeSkillItemLink(skill);
		if (link) then
			local name = nameFromLink(link);
			local quality = qualityFromLink(link);
			TT_Clear();
			TT_TooltipCall(GameTooltip, name, link, quality, 1, 0);
			TT_Show(GameTooltip);
		end
	end
end

function TT_GameTooltip_SetAuctionSellItem(this)
	Orig_GameTooltip_SetAuctionSellItem(this);
    local name, texture, quantity, quality, canUse, price = GetAuctionSellItemInfo();
	if (name) then
		local bag, slot = Auctioneer_FindItemInBags(name);
		if (bag) then
			local link = GetContainerItemLink(bag, slot);
			if (link) then
				TT_Clear();
				TT_TooltipCall(GameTooltip, name, link, quality, quantity, price);
				TT_Show(GameTooltip);
			end
		end
	end
end

function TT_IMInv_ItemButton_OnEnter()
	Orig_IMInv_ItemButton_OnEnter();
	if(not IM_InvList) then return; end
	local id = this:GetID();

	if(id == 0) then
		id = this:GetParent():GetID();
	end
	local offset = FauxScrollFrame_GetOffset(ItemsMatrix_IC_ScrollFrame);
	local item = IM_InvList[id + offset];

	if (not item) then return; end
	local imlink = ItemsMatrix_GetHyperlink(item.name);
	local link = fakeLink(imlink, item.quality, item.name);
	if (link) then
		TT_Clear();
		TT_TooltipCall(GameTooltip, item.name, link, item.quality, item.count, 0);
		TT_Show(GameTooltip);
	end
end

function TT_ItemsMatrixItemButton_OnEnter()
	Orig_ItemsMatrixItemButton_OnEnter();
	local imlink = ItemsMatrix_GetHyperlink(this:GetText());
	if (link) then
		local name = this:GetText();
		link = fakeLink(imlink, -1, name);
		TT_Clear();
		TT_TooltipCall(GameTooltip, name, link, -1, 1, 0);
		TT_Show(GameTooltip);
	end
end

local function getLootLinkServer()
	return LootLinkState.ServerNamesToIndices[GetCVar("realmName")];
end

local function getLootLinkLink(name)
	local itemLink = ItemLinks[name];
	if (itemLink and itemLink.c and itemLink.i and LootLink_CheckItemServer(itemLink, getLootLinkServer())) then
		local item = string.gsub(itemLink.i, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:%4");
		local link = "|c"..itemLink.c.."|Hitem:"..item.."|h["..name.."]|h|r";
		return link;
	end
	return nil;
end

function TT_LootLinkItemButton_OnEnter()
	Orig_LootLinkItemButton_OnEnter();
	local name = this:GetText();
	local link = getLootLinkLink(name);
	if (link) then
		local quality = qualityFromLink(link);
		TT_Clear();
		TT_TooltipCall(LootLinkTooltip, name, link, quality, 1, 0);
		TT_Show(LootLinkTooltip);
	end
end

function TT_AllInOneInventory_ModifyItemTooltip(bag, slot, tooltip)
	Orig_AllInOneInventory_ModifyItemTooltip(bag, slot, tooltip);

	local tooltip = getglobal(tooltipName);
	if (not tooltip) then
		tooltip = getglobal("GameTooltip");
		tooltipName = "GameTooltip";
	end
	if (not tooltip) then return false; end

	local link = GetContainerItemLink(bag, slot);
	local name = nameFromLink(link);
	if (name) then
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
		if (quality == nil) then quality = qualityFromLink(link); end

		TT_Clear();
		TT_TooltipCall(GameTooltip, name, link, quality, itemCount, 0);
		TT_Show(GameTooltip);
	end
end

function TT_GameTooltip_SetOwner(this, owner, anchor)
	Orig_GameTooltip_SetOwner(this, owner, anchor);
	this.owner = owner;
	this.anchor = anchor;
--	p("This tooltip owned by", owner:GetName());
--	TT_Align(this);
end


end

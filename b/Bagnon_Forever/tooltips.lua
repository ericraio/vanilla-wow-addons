--[[
	Ludwig_SellValue -
		Originally based on SellValueLite, this addon allows viewing of sellvalues
--]]

local currentPlayer = UnitName("player")

--[[ Local Functions ]]--

local function LinkToID(link)
	if link then
		local _, _, id = string.find(link, "(%d+):");
		return tonumber(id);
	end
end

local function AddOwners(frame, id)
	if not(frame and id and BagnonSets.showForeverTooltips) then return; end
	
	for player in BagnonDB.GetPlayers() do
		if player ~= currentPlayer then
			local invCount = BagnonDB.GetItemTotal(id, player, -2)
			for bagID = 0, 4 do
				invCount = invCount + BagnonDB.GetItemTotal(id, player, bagID)
			end

			local bankCount = BagnonDB.GetItemTotal(id, player, -1)
			for bagID = 5, 10 do
				bankCount = bankCount + BagnonDB.GetItemTotal(id, player, bagID)
			end

			if (invCount + bankCount) > 0 then
				local tooltipString = player .. " has"
				if invCount > 0 then
					tooltipString = tooltipString .. " " .. invCount .. " (Bags)";
				end
				if bankCount > 0 then
					tooltipString = tooltipString .. " " .. bankCount .. " (Bank)";
				end
				frame:AddLine(tooltipString, 0, 0.8, 1);
			end
		end
	end
end

--[[  Function Hooks ]]--

local Blizz_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
ContainerFrameItemButton_OnEnter = function()
	Blizz_ContainerFrameItemButton_OnEnter();

	local bag = this:GetParent():GetID();
	local slot = this:GetID();
	
	AddOwners(GameTooltip, LinkToID(GetContainerItemLink(bag, slot)));
	GameTooltip:Show();
end

local Bliz_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
GameTooltip.SetLootItem = function(self, slot)
	Bliz_GameTooltip_SetLootItem(self, slot);
	
	AddOwners(self, LinkToID(GetLootSlotLink(slot)));
	self:Show();
end

local Bliz_SetHyperlink = GameTooltip.SetHyperlink;
GameTooltip.SetHyperlink = function(self, link, count)
	if link then
		Bliz_SetHyperlink(self, link, count);
		
		if not count then
			count = 1; 
		end
		
		local id = LinkToID(link);
		if id then
			AddOwners(self, id);
		else
			AddOwners(self, link);
		end
		self:Show();
	end
end

local Bliz_GameTooltip_SetLootRollItem = GameTooltip.SetLootRollItem;
GameTooltip.SetLootRollItem = function(self, rollID) 
	Bliz_GameTooltip_SetLootRollItem(self, rollID);
	
	AddOwners(self, LinkToID(GetLootRollItemLink(rollID)));
	self:Show();
end

local Bliz_SetItemRef = SetItemRef;
SetItemRef = function(link, text, button)
	Bliz_SetItemRef(link, text, button);
	
	AddOwners(ItemRefTooltip, LinkToID(link));
	ItemRefTooltip:Show();
end

local Bliz_GameTooltip_SetAuctionItem = GameTooltip.SetAuctionItem;
GameTooltip.SetAuctionItem = function(self, type, index)
	Bliz_GameTooltip_SetAuctionItem(self, type, index);
	
	AddOwners(self, LinkToID(GetAuctionItemLink(type, index)));
	self:Show();
end

--[[ Money Frame Tooltip ]]--

--Alters the tooltip of bagnon moneyframes to show total gold across all characters on the current realm
function BagnonFrameMoney_OnEnter()
	if this:GetLeft() > (UIParent:GetRight() / 2) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end	
	GameTooltip:SetText(string.format(BAGNON_FOREVER_MONEY_ON_REALM, GetRealmName()));
	
	local money = 0;
	for player in BagnonDB.GetPlayers() do
		money = money + BagnonDB.GetMoney(player);
	end
	
	SetTooltipMoney(GameTooltip, money);
	GameTooltip:Show();
end
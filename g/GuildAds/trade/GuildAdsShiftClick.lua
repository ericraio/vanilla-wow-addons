GuildAdsShiftClick = {

	metaInformations = {
		name = "GuildAdsShiftClick",
		guildadsCompatible = 100,
	};
	
	-- hook
	callHook = {};
	hookName = {};
	
	hook = function(id, hook, new)
		if getglobal(hook) then
			GuildAdsShiftClick.hookName[id] = hook;
			GuildAdsShiftClick.callHook[id] = getglobal(hook);
			setglobal(hook, new);
		end
	end;
	
	unhook = function(id)
		if id and GuildAdsShiftClick.hookName[id] then
			setglobal(GuildAdsShiftClick.hookName[id], GuildAdsShiftClick.callHook[id]);
			GuildAdsShiftClick.hookName[id] = nil;
			GuildAdsShiftClick.callHook[id] = nil;
		end
	end;
	
	-- onInit
	onInit = function()
		-- Patch in inventory OnClick
		GuildAdsShiftClick.hook("inventory", "ContainerFrameItemButton_OnClick", GuildAdsShiftClick.inventoryOnClick);
		
		-- Patch in chat link
		GuildAdsShiftClick.hook("chatFrameHyperlink", "ChatFrame_OnHyperlinkShow", GuildAdsShiftClick.chatFrameOnHyperlinkShow);
		
		-- Patch in bank OnClick
		GuildAdsShiftClick.hook("bank", "BankFrameItemButtonGeneric_OnClick", GuildAdsShiftClick.bankOnClick);
		
		-- Patch in paperdoll
		GuildAdsShiftClick.hook("paperdoll", "PaperDollItemSlotButton_OnClick", GuildAdsShiftClick.paperdollOnClick)
		
		-- Patch in merchant OnClick
		GuildAdsShiftClick.hook("merchant", "MerchantItemButton_OnClick", GuildAdsShiftClick.merchantOnClick);
		
		-- Patch in quest item OnClick
		-- GuildAdsShiftClick.hook("questProgress", "QuestItem_OnClick", GuildAdsShiftClick.quest.progressOnClick);
		-- GuildAdsShiftClick.hook("questReward", "QuestRewardItem_OnClick", GuildAdsShiftClick.quest.rewardOnClick);
		
		-- Patch in inspect : on parse of the LUA file
		
		-- Patch in auction house : on parse of the LUA file
		
		-- Patch in trade skill : on parse of the LUA file
		
		-- Patch in craft : on parse of the LUA file
		
		-- Patch in AllInOneInventory item OnClick
		GuildAdsShiftClick.hook("allInOneInventory", "AllInOneInventoryFrameItemButton_OnClick", GuildAdsShiftClick.allInOneInventoryOnClick)

		-- Patch in MyInventory item OnlLick
		GuildAdsShiftClick.hook("myInventory", "MyInventoryFrameItemButton_OnClick", GuildAdsShiftClick.myInventoryOnClick);
		
		-- Patch in EngInventory
		GuildAdsShiftClick.hook("engInventory", "EngInventory_ItemButton_OnClick", GuildAdsShiftClick.engInventoryOnClick);

		-- Patch in MyBank
		GuildAdsShiftClick.hook("myBank", "MyBankFrameItemButton_OnClick", GuildAdsShiftClick.myBankOnClick);
		
		-- Patch in BankItems OnClick
		GuildAdsShiftClick.hook("bankItemsItem", "BankItems_Button_OnClick", GuildAdsShiftClick.bankItems.itemOnClick);
		GuildAdsShiftClick.hook("bankItemsBag", "BankItems_BagItem_OnClick", GuildAdsShiftClick.bankItems.bagOnClick);
		
		-- Patch in BankStatement
		GuildAdsShiftClick.hook("bankStatementItem", "BankStatementItemButton_OnClick", GuildAdsShiftClick.bankStatement.itemOnClick);
		GuildAdsShiftClick.hook("bankStatementBag", "BankStatementContainerFrameItemButton_OnClick", GuildAdsShiftClick.bankStatement.bagOnClick);
		
		-- Patch in ItemsMatrix item  OnClick
		GuildAdsShiftClick.hook("itemMatrix", "ItemsMatrixItemButton_OnClick", GuildAdsShiftClick.itemMatrixOnClick);
		
		-- Patch in LootLink item OnClick
		GuildAdsShiftClick.hook("lootLink", "LootLinkItemButton_OnClick", GuildAdsShiftClick.lootLink.onClick);
	end;
	
	-- hook this click ?
	hookTest = function(button)
		return GuildAdsFrame:IsVisible() and IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown();
	end;
	
	-- set current item in GuildAds window
	setItem = function(button, link, texture, itemCount, text)
		if(link) then
			GuildAds_MyAdsEdit(nil);
			GuildAds_setEditItem(text, link, texture, itemCount);
		else
			GuildAdsShiftClick.debug("Clicked on empty");
		end
	end;
	
	-- Inventory
	inventoryOnClick = function(button, ignoreShift)
		if(not ignoreShift and GuildAdsShiftClick.hookTest(button)) then
			local texture, itemCount = GetContainerItemInfo(this:GetParent():GetID(), this:GetID());
			local link = GetContainerItemLink(this:GetParent():GetID(), this:GetID());
			GuildAdsShiftClick.setItem(button, link, texture, itemCount);
		else
			GuildAdsShiftClick.callHook.inventory(button, ignoreShift);
		end
	end;

	-- Link into chatframe	
	chatFrameOnHyperlinkShow = function(link, text, button)
		if (GuildAdsShiftClick.hookTest(button)) then
			if string.sub(link, 1, 5) == "item:" then
				local info = GAS_GetItemInfo(link);
				GuildAdsShiftClick.setItem(button, text, info.texture, 1);
			else
				GuildAdsShiftClick.callHook.chatFrameHyperlink(link, text, button);
			end
		else
			GuildAdsShiftClick.callHook.chatFrameHyperlink(link, text, button);
		end		
	end;
	
	-- Bank
	bankOnClick = function(button)
		if(GuildAdsShiftClick.hookTest(button)) then
			local texture, itemCount = GetContainerItemInfo(BANK_CONTAINER, this:GetID());
			local link = GetContainerItemLink(BANK_CONTAINER, this:GetID());
			GuildAdsShiftClick.setItem(button, link, texture, itemCount);
		else
			GuildAdsShiftClick.callHook.bank(button);
		end
	end;
	
	-- Paperdoll
	paperdollOnClick = function(button, ignoreModifiers)
		if (GuildAdsShiftClick.hookTest(button) and not ignoreModifiers) then
			local texture = GetInventoryItemTexture("player", this:GetID());
			local count;
			if texture then
				count = GetInventoryItemCount("player", this:GetID());
			end
			local link = GetInventoryItemLink("player", this:GetID());
			GuildAdsShiftClick.setItem(button, link, texture, count);
		else
			GuildAdsShiftClick.callHook.paperdoll(button, ignoreModifiers);
		end
	end;
	
	-- Merchant
	merchantOnClick = function(button, ignoreModifiers)
		if button=="LeftButton" and not ignoreModifiers and GuildAdsShiftClick.hookTest(button) then
			local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(this:GetID());
			local link = GetMerchantItemLink(this:GetID());
			if (quantity == 1) then
				quantity = nil;
			end
			GuildAdsShiftClick.setItem(button, link, texture, quantity);
		else
			GuildAdsShiftClick.callHook.merchant(button, ignoreModifiers);
		end
	end;
	
	-- Quest 
	quest = {
	
		itemOnClick = function(hookToCall, button, ignoreModifiers)
			if GuildAdsShiftClick.hookTest(button) and this.rewardType ~= "spell" then
				local name, texture, numItems, quality, isUsable = GetQuestItemInfo(this.type, this:GetID());
				local link = GetQuestItemLink(this.type, this:GetID());
				GuildAdsShiftClick.setItem(button, link, texture, nil);
			else
				hookToCall(button, ignoreModifiers);
			end
		end;
		
		progressOnClick = function(button, ignoreModifiers)
			GuildAdsShiftClick.quest.itemOnClick(GuildAdsShiftClick.callHook.questProgress);
		end;
		
		rewardOnClick = function(button, ignoreModifiers)
			GuildAdsShiftClick.quest.itemOnClick(GuildAdsShiftClick.callHook.questReward);
		end;
		
	};
	
	-- Inspect
	inspect = {
		
		notHook = true;
	
		loadUI = function()
			GuildAdsShiftClick.callHook.inspectLoadUI();
			
			if GuildAdsShiftClick.inspect.notHook then
				GuildAdsShiftClick.inspect.notHook = nil;
				GuildAdsShiftClick.hook("inspect", "InspectPaperDollItemSlotButton_OnClick", GuildAdsShiftClick.inspect.onClick);
			end
		end;
	
		onClick = function(button)
			if GuildAdsShiftClick.hookTest(button) then
				local link = GetInventoryItemLink(InspectFrame.unit, this:GetID());
				local texture = GetInventoryItemTexture(InspectFrame.unit, this:GetID());
				local count;
				if ( textureName ) then
					count = GetInventoryItemCount(unit, button:GetID());
				end
				GuildAdsShiftClick.setItem(button, link, texture, count);
			else
				GuildAdsShiftClick.callHook.inspect(button);
			end
		end;
		
	};
	
	-- Auction House
	auctionHouse = {
	
		notHook = true;
	
		loadUI = function()
			GuildAdsShiftClick.callHook.auctionHouseLoadUI();
			
			if GuildAdsShiftClick.auctionHouse.notHook then
				GuildAdsShiftClick.auctionHouse.notHook = nil;
				
				-- Patch in auction OnClick
				GuildAdsShiftClick.callHook.auctionHouseItemOnClick = BrowseButton1Item:GetScript("OnClick");
				GuildAdsShiftClick.callHook.auctionHouseLineOnClick = BrowseButton1:GetScript("OnClick");
				for i=1,9 do 
					local button = getglobal("BrowseButton"..i.."Item");
					if button then
						button:SetScript("OnClick", GuildAdsShiftClick.auctionHouse.itemOnClick);
					end;
					button = getglobal("BrowseButton"..i);
					if button then
						button:SetScript("OnClick", GuildAdsShiftClick.auctionHouse.lineOnClick);
					end;
				end
				
			end
		end;
		
		itemOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local index = this:GetParent():GetID()+FauxScrollFrame_GetOffset(BrowseScrollFrame);
				local name, texture, itemCount = GetAuctionItemInfo("list", index);
				local link = GetAuctionItemLink("list", index);
				GuildAdsShiftClick.setItem(button, link, texture, itemCount);
			else
				GuildAdsShiftClick.callHook.auctionHouseItemOnClick(button);
			end
		end;
		
		lineOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local index = this:GetID()+FauxScrollFrame_GetOffset(BrowseScrollFrame);
				local name, texture, itemCount = GetAuctionItemInfo("list", index);
				local link = GetAuctionItemLink("list", index);
				GuildAdsShiftClick.setItem(button, link, texture, itemCount);
			else
				GuildAdsShiftClick.callHook.auctionHouseLineOnClick(button);
			end
		end;

	};
	
	-- Tradeskill
	tradeSkill = {
	
		notHook = true;
		
		loadUI = function()
			GuildAdsShiftClick.callHook.tradeSkillLoadUI();
			
			if GuildAdsShiftClick.tradeSkill.notHook then
				GuildAdsShiftClick.tradeSkill.notHook = nil;
				
				-- TradeSkillSkillIcon
				GuildAdsShiftClick.callHook.tradeSkillSkillOnClick = TradeSkillSkillIcon:GetScript("OnClick");
				TradeSkillSkillIcon:SetScript("OnClick", GuildAdsShiftClick.tradeSkill.SkillOnClick);

				-- TradeSkillReagent1 .. TradeSkillReagent8
				GuildAdsShiftClick.callHook.tradeSkillReagentOnClick = TradeSkillReagent1:GetScript("OnClick");
				for i=1,TRADE_SKILLS_DISPLAYED do
					local button = getglobal("TradeSkillReagent"..i);
					if button then
						button:SetScript("OnClick", GuildAdsShiftClick.tradeSkill.ReagentOnClick);
					end;
				end
				
			end
		end;
		
		SkillOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local id = TradeSkillFrame.selectedSkill;
				local link = GetTradeSkillItemLink(id);
				local texture = GetTradeSkillIcon(id);
				local minMade, maxMade = GetTradeSkillNumMade(id);
				GuildAdsShiftClick.setItem(button, link, texture, minMade);
			else
				GuildAdsShiftClick.callHook.tradeSkillSkillOnClick(button);
			end;
		end;
		
		ReagentOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(TradeSkillFrame.selectedSkill, this:GetID());
				local link = GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, this:GetID());
				GuildAdsShiftClick.setItem(button, link, reagentTexture, reagentCount);
			else
				GuildAdsShiftClick.callHook.tradeSkillReagentOnClick(button);
			end;
		end;
		
	};
	
	-- Craft 
	craft = {
	
		notHook = true;
	
		loadUI = function()
		
			-- call old function
			GuildAdsShiftClick.callHook.craftLoadUI();
			
			if GuildAdsShiftClick.craft.notHook then
				GuildAdsShiftClick.craft.notHook = nil;			
		
				-- CraftIcon
				GuildAdsShiftClick.callHook.craftIconOnClick = CraftIcon:GetScript("OnClick");
				CraftIcon:SetScript("OnClick", GuildAdsShiftClick.craft.iconOnClick);
	
				-- CraftReagent1 .. CraftReagent8
				GuildAdsShiftClick.callHook.reagentIconOnClick = CraftReagent1:GetScript("OnClick");
				for i=1,CRAFTS_DISPLAYED do
					local button = getglobal("CraftReagent"..i);
					if button then
						button:SetScript("OnClick", GuildAdsShiftClick.craft.reagentOnClick);
					end;
				end	
			end
		end;
		
		iconOnClick = function(button)
			if GuildAdsShiftClick.hookTest(button) then
				local id = GetCraftSelectionIndex();
				local craftName, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(id);
				local texture = GetCraftIcon(id);
				local craftDesc = GetCraftDescription(id);		
				GuildAdsShiftClick.setItem(button, GAS_PackLink("ffffffff", nil, craftName), texture, nil, craftDesc);
			else
				GuildAdsShiftClick.callHook.craftIconOnClick(button);
			end
		end;
		
		reagentOnClick = function(button)
			if GuildAdsShiftClick.hookTest(button) then
				local id = GetCraftSelectionIndex();
				local link = GetCraftReagentItemLink(id, this:GetID());
				local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(id, this:GetID());
				GuildAdsShiftClick.setItem(button, link, reagentTexture, reagentCount);
			else
				GuildAdsShiftClick.callHook.reagentIconOnClick(button);
			end
		end;
	
	};	
	
	-- AllInOneInventory
	allInOneInventoryOnClick = function(button, ignoreShift)
		if(not ignoreShift and GuildAdsShiftClick.hookTest(button)) then
			local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());
			local texture, itemCount = GetContainerItemInfo(bag, slot);
			local link = GetContainerItemLink(bag,slot);
			GuildAdsShiftClick.setItem(button, link, texture, itemCount);
		else
			GuildAdsShiftClick.callHook.allInOneInventory(button, ignoreShift);
		end
	end;
	
	-- MyInventory
	myInventoryOnClick = function(button, ignoreShift)
		if(not ignoreShift and GuildAdsShiftClick.hookTest(button)) then
			local texture, itemCount = GetContainerItemInfo(this.bagIndex, this.itemIndex);
			local link = GetContainerItemLink(this.bagIndex, this.itemIndex);
			GuildAdsShiftClick.setItem(button, link, texture, itemCount);
		else
			GuildAdsShiftClick.callHook.myInventory(button, ignoreShift);
		end
	end;
	
	-- EngInventory
	engInventoryOnClick = function(arg1)
		if GuildAdsShiftClick.hookTest(arg1) then
			if (EngInventory_buttons[this:GetName()] ~= nil) then
				bar = EngInventory_buttons[this:GetName()]["bar"];
				position = EngInventory_buttons[this:GetName()]["position"];
	
				bag = EngInventory_bar_positions[bar][position]["bagnum"];
				slot = EngInventory_bar_positions[bar][position]["slotnum"];
			
				local texture, itemCount = GetContainerItemInfo(bag, slot);
				local link = GetContainerItemLink(bag,slot);
				GuildAdsShiftClick.setItem(button, link, texture, itemCount);			
			end
		else
			GuildAdsShiftClick.callHook.engInventory(arg1);
		end
	end;
	
	-- MyBank
	myBankOnClick = function(button, ignoreShift)
		if(GuildAdsShiftClick.hookTest(button)) then
			local myLink;
			local item = MyBank_GetBag(this.bagIndex)[this.itemIndex];
			if ItemsMatrix_GetLink then
				myLink = ItemsMatrix_GetLink(item["name"]);
			elseif LootLink_GetLink then
				myLink = LootLink_GetLink(item["name"]);
			else
				myLink = MyBank_GetLink(item);
			end
			local icon, count = GetContainerItemInfo(this.bagIndex, this.itemIndex);
			GuildAdsShiftClick.setItem(button, myLink, icon, count);
		else
			GuildAdsShiftClick.callHook.myBank(button, ignoreShift);
		end
	end;
	
	-- BankItems
	bankItems = {
		
		itemOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local playerName = UIDropDownMenu_GetSelectedValue(BankItems_UserDropdown) 
				local item = BankItems_Save[playerName][this:GetID()];
				if (item) then
					GuildAdsShiftClick.setItem(button, item.link, item.icon, item.count);
				end
			else
				GuildAdsShiftClick.callHook.bankItemsItem(button);
			end
		end;
		
		bagOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local playerName = UIDropDownMenu_GetSelectedValue(BankItems_UserDropdown) 
				local bag = BankItems_Save[playerName]["Bag"..this:GetParent():GetID()];
				local itemID = bag.size - ( this:GetID() - 1 );
				local item = bag[itemID];
				if (item) then
					GuildAdsShiftClick.setItem(button, item.link, item.icon, item.count);
				end
			else
				GuildAdsShiftClick.callHook.bankItemsBag(button);
			end
		end;
	
	};
	
	-- BankStatement
	bankStatement = {
	
		getItemInfo = function(container, itemNum)
			local item;
			local player = BankStatementGetBSIIndex();
			if (BankStatementItems and BankStatementItems[player]) then
				if (itemNum == "bag") then
					item = BankStatementItems[player][container];
				else
					if (BankStatementItems[player][container]) then
						item = BankStatementItems[player][container][itemNum];
					end
				end
			end
			return item.link, item.icon, item.quantity;
		end;
		
		itemOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local link, icon, count = GuildAds_BS_GetItemInfo("bank", this:GetID());
				GuildAdsShiftClick.setItem(button, link, icon, count);
			else
				GuildAdsShiftClick.callHook.bankStatementItem(button);
			end
		end;
		
		bagOnClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local link, icon, count = GuildAds_BS_GetItemInfo("bag"..this:GetParent():GetID(), this:GetID());
				GuildAdsShiftClick.setItem(button, link, icon, count);		
			else
				GuildAdsShiftClick.callHook.bankStatementBag(button);
			end
		end;
	
	};
	
	-- ItemMatrix
	itemMatrixOnClick = function(button)
		if GuildAdsShiftClick.hookTest(button) then
			--only input if link is linkable
			if(IM_GetData(this:GetText(), "item")) then
				local nameGIF, linkGIF, qualityGIF, minLevelGIF, classGIF, subclassGIF, maxStackGIF = GetItemInfo(IM_GetData(this:GetText(), "item"));
				if(linkGIF and qualityGIF and nameGIF) then
					if(qualityGIF == 5) then --legendary
						useColor = "ffff8000";
					elseif(qualityGIF == 4) then --epic
						useColor = "ffa335ee";
					elseif(qualityGIF == 3) then --rare
						useColor = "ff0070dd";
					elseif(qualityGIF == 2) then --uncommon
						useColor = "ff1eff00";
					elseif(qualityGIF == 1) then--white
						useColor = "ffffffff";
					elseif(qualityGIF == 0) then--poor
						useColor = "ff9d9d9d";
					elseif(qualityGIF == -1) then--poor
						useColor = "ff9d9d9d";
					else
						useColor = "ff57BDFB";
					end

					--now insert it
					if(useColor) then	
						GuildAdsShiftClick.setItem(button, "|c"..useColor.."|H"..linkGIF.."|h["..nameGIF.."]|h|r", nil, nil);
					end
				end
			end
		else
			GuildAdsShiftClick.callHook.itemMatrix(button);
		end
	end;

	
	-- LootLink
	lootLink = {
	
		-- Handle Lootlink OnClick events
		checkItemServer = function(item)
		-- If we haven't converted and this item predates multiple server support, count it as valid
			if      (not item._) 
			    and ((not LootLinkState or not LootLinkState.DataVersion) or (LootLinkState.DataVersion < 110) ) then
				return 1;
			end
	
			-- normal case (LootLink_CheckItemServerRaw function)
			if item.s then
				local index = LootLinkState.ServerNamesToIndices[GetRealmName()];
				for server in string.gfind(item.s, "(%d+)") do
					if tonumber(server) == index then
						return 1;
					end
				end
			end
	
			if( not item.s ) then
				return nil;
			end
	
			return nil;
		end;
		
		getLink = function(name)
			local itemLink = ItemLinks[name];
			if( itemLink and itemLink.c and itemLink.i and GuildAdsShiftClick.lootLink.checkItemServer(itemLink) ) then
				-- Remove instance-specific data that we captured from the link we return
				local item = string.gsub(itemLink.i, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:%4");
				return "|c"..itemLink.c.."|Hitem:"..item.."|h["..name.."]|h|r";
			end
			return nil;
		end;
		
		onClick = function(button)
			if(GuildAdsShiftClick.hookTest(button)) then
				local link = GuildAdsShiftClick.lootLink.getLink(this:GetText());
				GuildAdsShiftClick.setItem(button, link, nil, nil);
			else
				GuildAdsShiftClick.callHook.lootLink(button);
			end
		end;
	
	};

};

GuildAdsPlugin.UIregister(GuildAdsShiftClick);
GuildAdsShiftClick.hook("inspectLoadUI", "InspectFrame_LoadUI", GuildAdsShiftClick.inspect.loadUI);
GuildAdsShiftClick.hook("auctionHouseLoadUI", "AuctionFrame_LoadUI", GuildAdsShiftClick.auctionHouse.loadUI);
GuildAdsShiftClick.hook("tradeSkillLoadUI", "TradeSkillFrame_LoadUI", GuildAdsShiftClick.tradeSkill.loadUI);
GuildAdsShiftClick.hook("craftLoadUI", "CraftFrame_LoadUI", GuildAdsShiftClick.craft.loadUI);

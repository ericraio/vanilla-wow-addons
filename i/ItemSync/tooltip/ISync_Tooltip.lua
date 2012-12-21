--[[--------------------------------------------------------------------------------
  ItemSyncCore Tooltip Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]


local ISync_lOriginal_GameTooltip_SetOwner;
local ISync_lOriginal_GameTooltip_SetHyperlink;
local ISync_lOriginal_GameTooltip_SetInventoryItem;
local ISync_lOriginal_GameTooltip_SetBagItem;
local ISync_lOriginal_GameTooltip_SetLootItem;
local ISync_lOriginal_GameTooltip_SetQuestItem;
local ISync_lOriginal_GameTooltip_SetQuestLogItem;
local ISync_lOriginal_GameTooltip_SetCraftItem;
local ISync_lOriginal_GameTooltip_SetTradeSkillItem;
local ISync_lOriginal_GameTooltip_SetMerchantItem;
local ISync_lOriginal_GameTooltip_SetTradePlayerItem;
local ISync_lOriginal_GameTooltip_SetTradeTargetItem;
local ISync_lOriginal_GameTooltip_SetAuctionItem;

local ISync_lOriginal_GameTooltip_OnEvent;
local ISync_lOriginal_GameTooltip_OnHide;
local ISync_lOriginal_SetItemRef;

local ISync_GameTooltip_HookedMoney;
local ISync_GameTooltip_HookedOnShow;

--GLOBALS
ISYNC_ITEMCOST = 0;

local lastTooltip = { };

---------------------------------------------------
-- ISync:HookTooltip()
---------------------------------------------------
function ISync:HookTooltip()


	------------------------------------------------------------------
	-- DO GAMETOOLTIP HOOKS
	------------------------------------------------------------------
	--GameTooltip.SetOwner
	ISync_lOriginal_GameTooltip_SetOwner = GameTooltip.SetOwner;
	GameTooltip.SetOwner = ISync_ToolTip_GT_SetOwner;
	
	--GameTooltip.SetHyperlink
	ISync_lOriginal_GameTooltip_SetHyperlink = GameTooltip.SetHyperlink;
	GameTooltip.SetHyperlink = ISync_ToolTip_GT_SetHyperlink;
	
	--GameTooltip.SetInventoryItem
	ISync_lOriginal_GameTooltip_SetInventoryItem = GameTooltip.SetInventoryItem;
	GameTooltip.SetInventoryItem = ISync_ToolTip_GT_SetInventoryItem;
	
	--GameTooltip.SetBagItem  
	ISync_lOriginal_GameTooltip_SetBagItem = GameTooltip.SetBagItem;
	GameTooltip.SetBagItem = ISync_ToolTip_GT_SetBagItem;
	
	--GameTooltip.SetLootItem
	ISync_lOriginal_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
	GameTooltip.SetLootItem = ISync_ToolTip_GT_SetLootItem;
	
	--GameTooltip.SetQuestItem
	ISync_lOriginal_GameTooltip_SetQuestItem = GameTooltip.SetQuestItem;
	GameTooltip.SetQuestItem = ISync_ToolTip_GT_SetQuestItem;
	
	--GameTooltip.SetQuestLogItem
	ISync_lOriginal_GameTooltip_SetQuestLogItem = GameTooltip.SetQuestLogItem;
	GameTooltip.SetQuestLogItem = ISync_ToolTip_GT_SetQuestLogItem;
	
	--GameTooltip.SetCraftItem
	ISync_lOriginal_GameTooltip_SetCraftItem = GameTooltip.SetCraftItem;
	GameTooltip.SetCraftItem = ISync_ToolTip_GT_SetCraftItem;
	
	--GameTooltip.SetTradeSkillItem
	ISync_lOriginal_GameTooltip_SetTradeSkillItem = GameTooltip.SetTradeSkillItem;
	GameTooltip.SetTradeSkillItem = ISync_ToolTip_GT_SetTradeSkillItem;
	
	--GameTooltip.SetMerchantItem
	ISync_lOriginal_GameTooltip_SetMerchantItem = GameTooltip.SetMerchantItem;
	GameTooltip.SetMerchantItem = ISync_ToolTip_GT_SetMerchantItem;
	
	--GameTooltip.SetTradePlayerItem
	ISync_lOriginal_GameTooltip_SetTradePlayerItem = GameTooltip.SetTradePlayerItem;
	GameTooltip.SetTradePlayerItem = ISync_ToolTip_GT_SetTradePlayerItem;
	
	--GameTooltip.SetTradeTargetItem
	ISync_lOriginal_GameTooltip_SetTradeTargetItem = GameTooltip.SetTradeTargetItem;
	GameTooltip.SetTradeTargetItem = ISync_ToolTip_GT_SetTradeTargetItem;

	--GameTooltip.SetAuctionItem
	ISync_lOriginal_GameTooltip_SetAuctionItem = GameTooltip.SetAuctionItem;
	GameTooltip.SetAuctionItem = ISync_ToolTip_GT_SetAuctionItem;
	
	--Hook for GameTooltip_OnEvent Function
	ISync_lOriginal_GameTooltip_OnEvent = GameTooltip_OnEvent;
	GameTooltip_OnEvent = ISync_ToolTip_GT_OnEvent;
	
	--Hook the gametooltip onhide
	ISync_lOriginal_GameTooltip_OnHide = GameTooltip_OnHide;
	GameTooltip_OnHide = ISync_ToolTip_GT_OnHide;
	
	--Hook the gametooltip OnAddMoney
	ISync_GameTooltip_HookedMoney = GameTooltip:GetScript("OnTooltipAddMoney");
	GameTooltip:SetScript("OnTooltipAddMoney", ISync_ToolTip_GT_AddMoney);
	
	--Hook the gametooltip OnShow
	ISync_GameTooltip_HookedOnShow = GameTooltip:GetScript("OnShow");
	GameTooltip:SetScript("OnShow", ISync_ToolTip_GT_OnShow);
	
	------------------------------------------------------------------
	------------------------------------------------------------------	
	
	--for items that are clicked on in chat
	ISync_lOriginal_SetItemRef = SetItemRef;
	SetItemRef = ISync_SetItemRef;
	

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync_ToolTip_GT_OnEvent
---------------------------------------------------
function ISync_ToolTip_GT_OnEvent()

    if event ~= "CLEAR_TOOLTIP" then
        return ISync_lOriginal_GameTooltip_OnEvent();
    end 
    
end


---------------------------------------------------
-- ISync_ToolTip_GT_OnHide
---------------------------------------------------
function ISync_ToolTip_GT_OnHide()
	 ISync_lOriginal_GameTooltip_OnHide();
	
	--don't do anything with the parsing tooltip
	if(this:GetName() == "ISyncTooltip") then return nil; end
	
	--make sure this is only applied to the GameTooltip
	if(this:GetName() == "GameTooltip") then
	
		GameTooltip.isDisplayDone = nil;
		GameTooltip.SendtoMods = nil;
		GameTooltip_ClearMoney();
		ISync_GameTooltipIcon:Hide();
		ISync_MoneyTooltip:Hide();
	end
	
end


---------------------------------------------------
-- ISync_ToolTip_GT_SetOwner
---------------------------------------------------
function ISync_ToolTip_GT_SetOwner(this, owner, anchor)

	--return to original to prevent errors
	ISync_lOriginal_GameTooltip_SetOwner(this, owner, anchor);
		
	--we want to store this for later use (like for Auctioneer)
	this.owner = owner;
	this.anchor = anchor;
		
end


---------------------------------------------------
-- ISync_ToolTip_GT_AddMoney
---------------------------------------------------
function ISync_ToolTip_GT_AddMoney()
	 ISync_GameTooltip_HookedMoney(); --call the old function

	if(ISYNC_LOADYES == 1 and arg1 and not InRepairMode()) then ISYNC_ITEMCOST = arg1; end
	
end



---------------------------------------------------
-- ISync_ToolTip_GT_OnShow
---------------------------------------------------
function ISync_ToolTip_GT_OnShow()
	if(ISync_GameTooltip_HookedOnShow) then ISync_GameTooltip_HookedOnShow(); end

	--ISync_ToolTip_GT_OnHide();
end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync_SetItemRef
---------------------------------------------------
function ISync_SetItemRef( link, name, button)
	ISync_lOriginal_SetItemRef(link, name, button); --return
         
	--make sure we have a link to work with
	if(not link or not name) then return nil; end
	
	--make sure we have a tooltip to work with duh
	if(not ItemRefTooltip) then return nil; end
	
	--we need to weed out item links and player tooltips.
	if( strsub(link, 1, 6) ~= "Player" ) then
	
		if( ItemRefTooltip:IsVisible() and link) then
		
			if (link) then
				
				if(not DressUpFrame:IsVisible()) then
					ISync:AddTooltipInfo(ItemRefTooltip, link, 1);
				end
				
				--reset it after it's been added so that we can always see it
				ItemRefTooltip.isDisplayDone = nil;
			end

		end
		
	end
	
	
end

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------
-- ISync_ToolTip_GT_SetHyperlink
---------------------------------------------------
function ISync_ToolTip_GT_SetHyperlink(this, link)

	if( link ) then
	
		local _,_,id = string.find(link, "^.*item:([0-9]+):.*$");
	
		if (id) then

			ISync_lOriginal_GameTooltip_SetHyperlink(this, link);
			ISync:AddTooltipInfo(this, link, 1);
		end
	end
end 




---------------------------------------------------
-- ISync_ToolTip_GT_SetInventoryItem
---------------------------------------------------
function ISync_ToolTip_GT_SetInventoryItem(this, unit, slot)

	local sItem, sCooldown, sRepair = ISync_lOriginal_GameTooltip_SetInventoryItem(this, unit, slot);
	
	if(not sItem) then return nil; end

	local link = (unit) and GetInventoryItemLink(unit, slot) or GetContainerItemLink(BANK_CONTAINER,this:GetID());
	local _, qty;

	if(unit) then
		qty = GetInventoryItemCount(unit, slot);
	else
		_, qty = GetContainerItemInfo(BANK_CONTAINER,this:GetID());
	end
	
	ISync:AddTooltipInfo(this, link, qty, 1);

	--return to original one	
	return sItem, sCooldown, sRepair;

end



---------------------------------------------------
-- ISync_ToolTip_GT_SetBagItem
---------------------------------------------------
function ISync_ToolTip_GT_SetBagItem(this, bag, slot)
	ISync_lOriginal_GameTooltip_SetBagItem(this, bag, slot);
	
	local link = GetContainerItemLink(bag, slot);
	local _, qty = GetContainerItemInfo(bag, slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);
				
end



---------------------------------------------------
-- ISync_ToolTip_GT_SetLootItem
---------------------------------------------------
function ISync_ToolTip_GT_SetLootItem(this, slot)
	ISync_lOriginal_GameTooltip_SetLootItem(this, slot);
	
	local link = GetLootSlotLink(slot);
	local _,_, qty = GetLootSlotInfo(slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);

end



---------------------------------------------------
-- ISync_ToolTip_GT_SetQuestItem
---------------------------------------------------
function ISync_ToolTip_GT_SetQuestItem(this, unit, slot)
	ISync_lOriginal_GameTooltip_SetQuestItem(this, unit, slot);

	local link = GetQuestItemLink(unit, slot);
	local _,_, qty = GetQuestItemInfo(unit, slot);

	ISync:AddTooltipInfo(this, link, qty, 1);
	
end



---------------------------------------------------
-- ISync_ToolTip_GT_SetQuestLogItem
---------------------------------------------------
function ISync_ToolTip_GT_SetQuestLogItem(this, sOpt, slot)
	ISync_lOriginal_GameTooltip_SetQuestLogItem(this, sOpt, slot);
	
	local link = GetQuestLogItemLink(sOpt, slot);
	local name, texture, qty, quality, usable = GetQuestLogRewardInfo(slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);

end



---------------------------------------------------
-- ISync_ToolTip_GT_SetCraftItem
---------------------------------------------------
function ISync_ToolTip_GT_SetCraftItem(this, skill, slot)
	ISync_lOriginal_GameTooltip_SetCraftItem(this, skill, slot);
	
	local link = (slot) and GetCraftReagentItemLink(skill, slot) or GetCraftItemLink(skill);
	local _, _, qty = GetCraftReagentInfo(skill, slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);
				
end



---------------------------------------------------
-- ISync_ToolTip_GT_SetTradeSkillItem
---------------------------------------------------
function ISync_ToolTip_GT_SetTradeSkillItem(this, skill, slot)
	ISync_lOriginal_GameTooltip_SetTradeSkillItem(this, skill, slot);

	local link = (slot) and GetTradeSkillReagentItemLink(skill, slot) or GetTradeSkillItemLink(skill);
	local _, _, qty;

	if(slot) then
		_, _, qty = GetTradeSkillReagentInfo(skill, slot);
	else
		qty = 1;
	end

	ISync:AddTooltipInfo(this, link, qty, 1);					
	
end


---------------------------------------------------
-- ISync_ToolTip_GT_SetMerchantItem
---------------------------------------------------
function ISync_ToolTip_GT_SetMerchantItem(this, slot)
	ISync_lOriginal_GameTooltip_SetMerchantItem(this, slot);

	local link = GetMerchantItemLink(slot);
	local _,_,_, qty = GetMerchantItemInfo(slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);
						
end


---------------------------------------------------
-- ISync_ToolTip_GT_SetTradePlayerItem
---------------------------------------------------
function ISync_ToolTip_GT_SetTradePlayerItem(this, slot)
	ISync_lOriginal_GameTooltip_SetTradePlayerItem(this, slot);
	
	local link = GetTradePlayerItemLink(slot);
	local _,_, qty = GetTradeTargetItemInfo(slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);
	
end


---------------------------------------------------
-- ISync_ToolTip_GT_SetTradeTargetItem
---------------------------------------------------
function ISync_ToolTip_GT_SetTradeTargetItem(this, slot)
	ISync_lOriginal_GameTooltip_SetTradeTargetItem(this, slot);
	
	local link = GetTradeTargetItemLink(slot);
	local _,_, qty = GetTradeTargetItemInfo(slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);
end



---------------------------------------------------
-- ISync_ToolTip_GT_SetAuctionItem
---------------------------------------------------
function ISync_ToolTip_GT_SetAuctionItem(this, unit, slot)
	ISync_lOriginal_GameTooltip_SetAuctionItem(this, unit, slot);
	
	local link = GetAuctionItemLink(unit, slot);
	local _,_,qty = GetAuctionItemInfo(unit, slot);
	
	ISync:AddTooltipInfo(this, link, qty, 1);
end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------
-- ISync:AddTooltipInfo
---------------------------------------------------
function ISync:AddTooltipInfo(sTooltip, sLink, sQty, sChk)

	--check
	if(not sTooltip) then return nil; end
	if(not sLink and not sQty) then return nil; end --if we don't have both, then ignore
	if(tonumber(sLink) and tonumber(sLink) == 0) then return nil; end--if we have a link but it's zero then ignore
	if(sLink and not sQty) then sQty = 1; end --if we have an item but no qty, then set qty to 1
	if(tonumber(sQty) and tonumber(sQty) == 0) then sQty = 1; end --fix incorrect qty
	if(not tonumber(sQty)) then sQty = 1; end --fix stupid errors
	if(sTooltip.isDisplayDone) then return nil; end
	
	--we don't want the information to be placed while we are at a merchant, EXCEPT if it's the clickable links.
	if(MerchantFrame:IsVisible() and sTooltip:GetName() ~= "ItemRefTooltip") then return nil; end
	
		--grab the itemid we need
		sLink = ISync:GetItemID(sLink);
		if(not sLink) then return nil; end --exit if nothing

		--grab the coreid
		local sID = ISync:GetCoreID(sLink);
		if(not tonumber(sID)) then return nil; end --exit if nothing

		sID = tonumber(sID); --convert
		
	
	local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X, equipType_X, iconTexture_X  = GetItemInfo("item:"..sLink);
	if(not name_X) then return nil; end --make sure
	

	--don't show for certain things cause it's annoying
	if(ISync:SetVar({"OPT","TOOLTIPITEMICONS"}, 1, "COMPARE") and not sChk) then--show the tooltip icon
		
		getglobal("ISync_"..sTooltip:GetName().."IconTexture"):SetTexture(iconTexture_X);

		if(sTooltip:GetName() == "ItemRefTooltip") then --move if equipcompare is installed
			if(EquipCompare_Enabled) then
				getglobal("ISync_"..sTooltip:GetName().."Icon"):SetPoint("TOPLEFT", "ItemRefTooltip", "TOPLEFT" , 3, 39);
			end
		end
		
		getglobal("ISync_"..sTooltip:GetName().."Icon"):Show();
	else
		getglobal("ISync_"..sTooltip:GetName().."Icon"):Hide();
	end

	--to prevent continous fetching
	if(not lastTooltip.item or lastTooltip.item ~= sID) then
		lastTooltip.getPrice = nil;
		lastTooltip.vendPrice = nil;
		lastTooltip.vendQty = nil;
		lastTooltip.getPrice = ISync:FetchDB(sID, "price");
		lastTooltip.vendPrice = ISync:FetchDB(sID, "vendor");
		lastTooltip.vendQty = ISync:FetchDB(sID, "vendorqty");
		lastTooltip.item = sID;
	end

		
		
	if(ISync:SetVar({"OPT","SHOWMONEYICONS"}, 1, "COMPARE")) then --show money icons
		
		local chkAddLine	= 0;
		local getPrice		= lastTooltip.getPrice;
		local sFrameGet;
		local priceChk = 0;
		local vendorChk = 0;
		
		if(sTooltip == ItemRefTooltip) then
			sFrameGet = "ISync_MoneyTooltipItemRef";
		else
			sFrameGet = "ISync_MoneyTooltip";
		end
		
			--start off hidden
			local text = getglobal(sFrameGet.."Text1");
			local money = getglobal(sFrameGet.."Money1");
			local text2 = getglobal(sFrameGet.."Text2");
			local money2 = getglobal(sFrameGet.."Money2");
			money:Hide();
			text:Hide();
			money2:Hide();
			text2:Hide();
						
					
		if(getPrice and tonumber(getPrice) and tonumber(getPrice) == -1) then --item has no value
			
			local text = getglobal(sFrameGet.."Text1");
			local money = getglobal(sFrameGet.."Money1");
			money:Hide();
			text:Hide();
					
			if(chkAddLine == 0) then sTooltip:AddLine(" "); chkAddLine = 1; end		
			sTooltip:AddLine("|c00FFFF00"..ISYNC_NOSELLPRICE.."|r");	
			sTooltip.isDisplayDone = 1;
			priceChk = 0;
	
		elseif(getPrice and tonumber(getPrice) and tonumber(getPrice) > 0) then
		
			getPrice = tonumber(getPrice) * sQty;

			--PRICE
			if(ISync:SetVar({"OPT","PRICE"}, 1, "COMPARE")) then
			
					if(chkAddLine == 0) then sTooltip:AddLine(" "); chkAddLine = 1; end
					sTooltip:AddLine(" ", 0, 0, 0);

					local numLines = sTooltip:NumLines();
					local text = getglobal(sFrameGet.."Text1");
					local money = getglobal(sFrameGet.."Money1");
					local newLine = sTooltip:GetName().."TextLeft"..numLines;

					MoneyFrame_Update(sFrameGet.."Money1", getPrice);
					text:SetText("|c00FFFF00"..ISYNC_COST.."[|r|c00BDFCC9"..sQty.."|r|c00FFFF00]:  |r");
					text:Show();
					money:Show();

					--set the point at it's new location
					text:ClearAllPoints();
					text:SetPoint("LEFT", newLine, "LEFT", 0, 0);
					text:SetWidth(text:GetStringWidth());
					
					--fix the tooltip width if small
					local getTextWidth = text:GetWidth();
					local getMoneyWidth = money:GetWidth();
					local getTooltipWidth= getglobal(sTooltip:GetName().."TextLeft1"):GetWidth();

					--check, expand the tooltip if we need to
					if( (getTextWidth + getMoneyWidth) > getTooltipWidth ) then

						getglobal(sTooltip:GetName().."TextLeft1"):SetWidth((getTextWidth + getMoneyWidth) + 10);	

					end
					
					sTooltip.isDisplayDone = 1;
					priceChk = 1;

			end--if(ISync:SetVar({"OPT","PRICE"}, 1, "COMPARE")) then
		
		else--don't show the first money line
		
			local text = getglobal(sFrameGet.."Text1");
			local money = getglobal(sFrameGet.."Money1");
			money:Hide();
			text:Hide();

			priceChk = 0;
		
		end--if(getPrice < 0) then
		
		
		--VENDOR
		if(ISync:SetVar({"OPT","VENDOR"}, 1, "COMPARE")) then

			local vendPrice = lastTooltip.vendPrice;
			local vendQty = lastTooltip.vendQty;

			if(vendPrice and vendQty and tonumber(vendPrice) and tonumber(vendPrice) > 0) then

				if(chkAddLine == 0) then sTooltip:AddLine(" "); chkAddLine = 1; end
				sTooltip:AddLine(" ", 0, 0, 0);

				local numLines = sTooltip:NumLines();
				local text = getglobal(sFrameGet.."Text2");
				local money = getglobal(sFrameGet.."Money2");
				local newLine = sTooltip:GetName().."TextLeft"..numLines;


				MoneyFrame_Update(sFrameGet.."Money2", vendPrice);
				text:SetText("|c00FFFF00"..ISYNC_VENDORCOST.."[|r|c00BDFCC9"..vendQty.."|r|c00FFFF00]:  |r");
				text:Show();
				money:Show();

				--set the point at it's new location
				text:ClearAllPoints();
				text:SetPoint("LEFT", newLine, "LEFT", 0, 0);
				text:SetWidth(text:GetStringWidth());

				--fix the tooltip width if small
				local getTextWidth = text:GetWidth();
				local getMoneyWidth = money:GetWidth();
				local getTooltipWidth= getglobal(sTooltip:GetName().."TextLeft1"):GetWidth();

				--check, expand the tooltip if we need to
				if( (getTextWidth + getMoneyWidth) > getTooltipWidth ) then

					getglobal(sTooltip:GetName().."TextLeft1"):SetWidth((getTextWidth + getMoneyWidth) + 10);	

				end

				--set as done
				sTooltip.isDisplayDone = 1;
				vendorChk = 1;
					
			end--if(vendPrice and vendQty) then
			
		else
		
			local text = getglobal(sFrameGet.."Text2");
			local money = getglobal(sFrameGet.."Money2");
			money:Hide();
			text:Hide();
			
			vendorChk = 0;
					
		end
		
		--show and update the frame accordingly
		if(priceChk == 1 and vendorChk == 1) then
		
			local getPriceWidth = getglobal(sFrameGet.."Text1"):GetWidth();
			local getVendorWidth = getglobal(sFrameGet.."Text2"):GetWidth();
			local diffWidth = 0;

			--if vendor is bigger then price
			if(getPriceWidth < getVendorWidth) then
				 getglobal(sFrameGet.."Text1"):SetWidth(getVendorWidth);
				 getglobal(sFrameGet.."Text1"):SetJustifyH("LEFT");
			--if price is bigger then vendor
			elseif(getVendorWidth < getPriceWidth) then	 
				 getglobal(sFrameGet.."Text2"):SetWidth(getPriceWidth);
				 getglobal(sFrameGet.."Text2"):SetJustifyH("LEFT");
			end	
			
		end
		
		--show the tooltipmoneyframe if we have information
		if(priceChk == 1 or vendorChk == 1) then

			if(sTooltip == ItemRefTooltip) then
				ISync_MoneyTooltipItemRef:Show();
			else
				ISync_MoneyTooltip:Show();
			end
			
		else
			ISync_MoneyTooltipItemRef:Hide();
			ISync_MoneyTooltip:Hide();
		end
		
		--show the tooltip
		sTooltip:Show();
		
		return nil;
		
		
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	else--SHOW MONEY TEXT

		local chkAddLine	= 0;
		local getPrice		= lastTooltip.getPrice;
		
			
		if(getPrice and tonumber(getPrice) and tonumber(getPrice) == -1 and ISync:SetVar({"OPT","PRICE"}, 1, "COMPARE")) then --item has no value
			
			if(chkAddLine == 0) then sTooltip:AddLine(" "); chkAddLine = 1; end		
			sTooltip:AddLine("|c00FFFF00"..ISYNC_NOSELLPRICE.."|r");	
			sTooltip.isDisplayDone = 1;
	
		elseif(getPrice and tonumber(getPrice) and tonumber(getPrice) > 0) then
		
			getPrice = tonumber(getPrice) * sQty;
			local gold, silver, copper = ISync:ReturnCurrency(getPrice);
			local currencySTR = "";
			
			local goldLay = ISync:SetVar({"LAYOUT","GOLD"}, "|c00FFFFFF%s|r|c00E2CD54"..ISYNC_OPTGOLD1.."|r ");
			local silverLay = ISync:SetVar({"LAYOUT","SILVER"}, "|c00FFFFFF%s|r|c00AEAEAE"..ISYNC_OPTSILVER1.."|r ");
			local copperLay = ISync:SetVar({"LAYOUT","COPPER"}, "|c00FFFFFF%s|r|c00D7844D"..ISYNC_OPTCOPPER1.."|r");
			
			--PRICE
			if(ISync:SetVar({"OPT","PRICE"}, 1, "COMPARE")) then
			
				if(gold and gold ~= 0) then --GOLD
					currencySTR = string.format(goldLay, gold);
				end
				
				if(silver and silver ~= 0) then--SILVER
					currencySTR = currencySTR..string.format(silverLay, silver);
				end
				
				if(copper and copper ~= 0) then--COPPER
					currencySTR = currencySTR..string.format(copperLay, copper);
				end
				
				
				if(chkAddLine == 0) then sTooltip:AddLine(" "); chkAddLine = 1; end
				sTooltip:AddDoubleLine("|c00FFFF00"..ISYNC_COST.."[|r|c00BDFCC9"..sQty.."|r|c00FFFF00]:|r", currencySTR,1,1,1,1,1,1);
				sTooltip.isDisplayDone = 1;
						
			end
		
		
		end--if(getPrice < 0) then
		
		
		--VENDOR
		if(ISync:SetVar({"OPT","VENDOR"}, 1, "COMPARE")) then

			local vendPrice = lastTooltip.vendPrice;
			local vendQty = lastTooltip.vendQty;

			if(vendPrice and vendQty and tonumber(vendPrice) and tonumber(vendPrice) > 0) then

				vendPrice = tonumber(vendPrice);
				vendQty = tonumber(vendQty);
				if(vendQty < 1) then vendQty = 1; end
				
				local gold, silver, copper = ISync:ReturnCurrency(vendPrice);
				local currencySTR = "";
				
				local goldLay = ISync:SetVar({"LAYOUT","GOLD"}, "|c00FFFFFF%s|r|c00E2CD54"..ISYNC_OPTGOLD1.."|r ");
				local silverLay = ISync:SetVar({"LAYOUT","SILVER"}, "|c00FFFFFF%s|r|c00AEAEAE"..ISYNC_OPTSILVER1.."|r ");
				local copperLay = ISync:SetVar({"LAYOUT","COPPER"}, "|c00FFFFFF%s|r|c00D7844D"..ISYNC_OPTCOPPER1.."|r");
			

				if(gold and gold ~= 0) then --GOLD
					currencySTR = string.format(goldLay, gold);
				end

				if(silver and silver ~= 0) then--SILVER
					currencySTR = currencySTR..string.format(silverLay, silver);
				end

				if(copper and copper ~= 0) then--COPPER
					currencySTR = currencySTR..string.format(copperLay, copper);
				end


				if(chkAddLine == 0) then sTooltip:AddLine(" "); chkAddLine = 1; end
				sTooltip:AddDoubleLine("|c00FFFF00"..ISYNC_VENDORCOST.."[|r|c00BDFCC9"..vendQty.."|r|c00FFFF00]:|r", currencySTR,1,1,1,1,1,1);
				sTooltip.isDisplayDone = 1;

			end--if(vendPrice and vendQty) then
		end
			
		
		--show the tooltip
		sTooltip:Show();
		
		--hide the money icons since we aren't using them
		ISync_MoneyTooltipItemRef:Hide();
		ISync_MoneyTooltip:Hide();
		
		return nil;
		
	end--if(ISync:SetVar({"OPT","SHOWMONEYICONS"}, 1, "COMPARE")) then
	

end


---------------------------------------------------
-- ISync:ReturnCurrency
---------------------------------------------------
function ISync:ReturnCurrency(sMoney)

	--convert the long money value into seperate variables
	local gold = floor(sMoney / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((sMoney - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(sMoney, COPPER_PER_SILVER);


	return gold, silver, copper;

end




--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

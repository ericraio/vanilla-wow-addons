--[[
	Bags.lua
		Functions used by Bagnon Bags
--]]

--This loading function and the event handler are actually called by the frame that contains all the bag buttons, not the bag buttons themselves
function BagnonBagMain_OnLoad()
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("CURSOR_UPDATE");
	this:RegisterEvent("BAG_UPDATE_COOLDOWN");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
end

function BagnonBag_OnLoad()
	this:RegisterForDrag("LeftButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

function BagnonBag_OnEvent(event)
	if ( not this:IsVisible() or Bagnon_IsCachedFrame(this:GetParent())  ) then
		return;
	end
	
	if ( event == "UNIT_INVENTORY_CHANGED") then
		if ( arg1 == "player" ) then
			BagnonBag_ForAllBags(BagnonBag_Update);
		end
	elseif ( event == "ITEM_LOCK_CHANGED" ) then
		BagnonBag_ForAllBags(BagnonBag_UpdateLock);
	elseif ( event == "BAG_UPDATE_COOLDOWN" ) then
		BagnonBag_ForAllBags(BagnonBag_UpdateLock, 1);
	elseif ( event == "CURSOR_UPDATE" ) then
		BagnonBag_UpdateCursor();
	elseif ( event == "BAG_UPDATE" ) then
		BagnonBag_UpdateBagsAndSize(this);
	elseif ( event == "UPDATE_INVENTORY_ALERTS" ) then
		BagnonBag_ForAllBags(BagnonBag_Update);
	end
end

function BagnonBag_UpdateCursor()
	local bags = { this:GetChildren() };
	for bag in bags do
		if ( CursorCanGoInSlot( ContainerIDToInventoryID( bags[bag]:GetID() ) ) ) then
			bags[bag]:LockHighlight();
		else
			bags[bag]:UnlockHighlight();
		end
	end
end

function BagnonBag_Update(bag, cooldownOnly)
	if(bag:GetID() == KEYRING_CONTAINER) then
		return;
	end
	
	local invID = ContainerIDToInventoryID(bag:GetID());
	
	local textureName = GetInventoryItemTexture("player", invID);
	local cooldown = getglobal(bag:GetName().."Cooldown");
	if ( textureName ) then
		SetItemButtonTexture(bag, textureName);
		BagnonBag_SetBagCount(bag, GetInventoryItemCount("player", invID));
		
		if ( not IsInventoryItemLocked(invID) ) then 
			SetItemButtonTextureVertexColor(bag, 1.0, 1.0, 1.0);
			SetItemButtonNormalTextureVertexColor(bag, 1.0, 1.0, 1.0);
		end
		bag.hasItem = 1;
	else
		SetItemButtonTexture(bag, nil);
		BagnonBag_SetBagCount(bag, 0);
		SetItemButtonTextureVertexColor(bag, 1.0, 1.0, 1.0);
		SetItemButtonNormalTextureVertexColor(bag, 1.0, 1.0, 1.0);
		cooldown:Hide();
		bag.hasItem = nil;
	end

	local start, duration, enable = GetInventoryItemCooldown("player", invID);
	CooldownFrame_SetTimer(cooldown, start, duration, enable);


	if ( GameTooltip:IsOwned(bag) ) then
		if ( textureName or cooldownOnly ) then
			BagnonBag_OnEnter(bag);
		else
			GameTooltip:Hide();
			ResetCursor();
		end
	end
	BagnonBag_UpdateLock(bag);

	-- Update repair all button status
	if ( MerchantRepairAllIcon ) then
		local repairAllCost, canRepair = GetRepairAllCost();
		if ( canRepair ) then
			SetDesaturation(MerchantRepairAllIcon, nil);
			MerchantRepairAllButton:Enable();
		else
			SetDesaturation(MerchantRepairAllIcon, 1);
			MerchantRepairAllButton:Disable();
		end	
	end
end

function BagnonBag_UpdateLock(bag)
	if ( IsInventoryItemLocked( ContainerIDToInventoryID(bag:GetID()) ) ) then
		SetItemButtonDesaturated(bag, 1, 0.5, 0.5, 0.5);
	else 
		SetItemButtonDesaturated(bag, nil);
	end
end

function BagnonBag_OnClick()
	if ( Bagnon_IsCachedBag(this:GetParent():GetParent().player, this:GetID() ) ) then
		return;
	end

	if(not IsShiftKeyDown() ) then
		--damn you blizzard for making the keyring specific code!
		if( this:GetID() == KEYRING_CONTAINER ) then
			PutKeyInKeyRing();
		else
			PutItemInBag( ContainerIDToInventoryID(this:GetID()) );
		end
		BagnonCore_GenerateFrame(this:GetParent():GetParent());
	else
		BagnonCore_ToggleBagForFrame(this:GetParent():GetParent(), this:GetID());
	end
end

function BagnonBag_OnDrag()
	if (Bagnon_IsCachedBag(this:GetParent():GetParent().player, this:GetID()) )  then 
		return;
	end

	PickupBagFromSlot( ContainerIDToInventoryID(this:GetID()) );
	BagnonCore_GenerateFrame(this:GetParent():GetParent());
	PlaySound("BAGMENUBUTTONPRESS");
end

function BagnonBag_OnEnter(bag)
	if(not bag) then
		bag = this;
	end
	
	local frame = bag:GetParent():GetParent();
	
	BagnonCore_HighlightSlots(frame, bag:GetID());
	
	if( bag:GetLeft() < ( UIParent:GetRight() / 2) ) then
		GameTooltip:SetOwner(bag, "ANCHOR_RIGHT");
	else
		GameTooltip:SetOwner(bag, "ANCHOR_LEFT");
	end
	
	if( Bagnon_IsCachedBag(frame.player, bag:GetID()) ) then
		local size, link = BagnonDB_GetBagData(frame.player, bag:GetID());
		
		if(link) then
			GameTooltip:SetHyperlink( link );
			GameTooltip:Show();
			return;
		end
	--keyring specific code...again
	elseif ( bag:GetID() == KEYRING_CONTAINER ) then
		GameTooltip:SetText(KEYRING, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine();
		
		--add the usage tooltip
		if(BagnonSets.showTooltips) then
			if( Bagnon_FrameHasBag(frame:GetName(), bag:GetID()) ) then
				GameTooltip:AddLine(BAGNON_BAGS_HIDE);
			else
				GameTooltip:AddLine(BAGNON_BAGS_SHOW);
			end
		end
		GameTooltip:Show();
		return;
	elseif ( GameTooltip:SetInventoryItem("player", ContainerIDToInventoryID(bag:GetID()) ) ) then
	
		--add the usage tooltip
		if(BagnonSets.showTooltips) then
			if( Bagnon_FrameHasBag(frame:GetName(), bag:GetID()) ) then
				GameTooltip:AddLine(BAGNON_BAGS_HIDE);
			else
				GameTooltip:AddLine(BAGNON_BAGS_SHOW);
			end
		end
		
		GameTooltip:Show();
		return;
	end
	GameTooltip:SetText(TEXT(EQUIP_CONTAINER), 1.0, 1.0, 1.0);
end


function BagnonBag_OnShow()
	local bags = { this:GetChildren() };
	local parent = this:GetParent();
	
	for bag in bags do
		BagnonBag_UpdateTexture(parent, bags[bag]:GetID());
	end
end


--[[
	Update the texture and count of the bag
		Used mainly for cached bags
--]]

function BagnonBag_UpdateTexture(frame, bagID)
	if(bagID == KEYRING_CONTAINER) then
		return;
	end
	
	local bag = getglobal(frame:GetName() .. "Bags" .. bagID);
	if(not bag ) then 
		return; 
	end
	
	if( Bagnon_IsCachedBag(frame.player, bagID) ) then
		local size, link, count = BagnonDB_GetBagData(frame.player, bagID);
		if(link) then
			local _, _, _, _, _, _, _, _, texture = GetItemInfo(link);
			SetItemButtonTexture(bag, texture);
		else
			SetItemButtonTexture(bag, nil);
		end
		if(count) then
			BagnonBag_SetBagCount(bag, count);
		end
	else
		local texture = GetInventoryItemTexture("player", ContainerIDToInventoryID(bagID));
		if(texture) then
			SetItemButtonTexture(bag, texture);
		else
			SetItemButtonTexture(bag, nil);
		end
		BagnonBag_SetBagCount(bag, GetInventoryItemCount("player", ContainerIDToInventoryID(bagID)));
	end
end

function BagnonBag_UpdateBagsAndSize(frame)
	local bags = { frame:GetChildren() };

	local size = 0;
	for bag in bags do
		BagnonBag_Update(bags[bag]);
		size = size + GetContainerNumSlots(bags[bag]:GetID());
	end
	
	--only generate the frame again if the size of the frame changed
	if(frame.size ~= size) then
		BagnonCore_GenerateFrame(frame:GetParent());
	end
end

function BagnonBag_SetBagCount(button, count)
	if ( not button ) then
		return;
	end

	if ( not count ) then
		count = 0;
	end

	button.count = count;
	if ( count > 1 or (button.isBag and count > 0) ) then
		local countText = getglobal(button:GetName().."Count");
		if(count > 9999) then
			countText:SetFont(NumberFontNormal:GetFont(), 10, "OUTLINE");
		elseif(count > 999) then
			countText:SetFont(NumberFontNormal:GetFont(), 11, "OUTLINE");
		else
			countText:SetFont(NumberFontNormal:GetFont(), 12, "OUTLINE");
		end
		countText:SetText(count);
		countText:Show();
	else
		getglobal(button:GetName().."Count"):Hide();
	end
end

--does an action to all bags, except the keyring
function BagnonBag_ForAllBags(action, arg1)
	local bags = { this:GetChildren() };
	for bag in bags do
		if(bags[bag]:GetID() ~= KEYRING_CONTAINER) then
			action(bags[bag], arg1);
		end
	end
end
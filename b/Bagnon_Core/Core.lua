--[[
	BagnonCore
		Core bag functionality
		
	BagSlots:
		-2: Key (1.11)
		-1: Bank (24 slots)
		0:  Main Inventory (16 slots)
		1, 2, 3, 4: Inventory Bags (16 - 32?)
		5, 6, 7, 8, 9, 10:  Bank Bags (16 - 32?)	
		
	TODO
		Add in 1.11 functionality
--]]

--Local constants
local DEFAULT_COLS = 8;
local DEFAULT_SPACING = 2;

--[[
	Load settings for the frame
--]]

function BagnonCore_LoadSettings(frame, bags, title)
	local frameName = frame:GetName()
	--make frame close on escape
	tinsert(UISpecialFrames, frameName);
	
	--initialize variables for the frame if there are none
	if(not BagnonSets[frameName] ) then
		BagnonSets[frameName] = {
			stayOnScreen = 1,
		};
	end
	
	--add what bags are controlled by the frame
	if(not BagnonSets[frameName].bags) then
		BagnonSets[frameName].bags = bags;
	end
	
	--set the frame's transparency
	if(BagnonSets[frameName].alpha) then
		frame:SetAlpha(BagnonSets[frameName].alpha);
	end
	
	--set the frame's background
	if(not BagnonSets[frameName].bg or tonumber(BagnonSets[frameName].bg) ) then
		BagnonSets[frameName].bg = {r = 0, g = 0, b = 0, a = 1};
	end
	
	local bgSets= BagnonSets[frameName].bg;
	frame:SetBackdropColor(bgSets.r, bgSets.g, bgSets.b, bgSets.a);
	frame:SetBackdropBorderColor(1, 1, 1, bgSets.a); 
	
	--set the frame's layer (low, medium, or high)
	if(BagnonSets[frameName].strata) then
		BagnonMenu_SetStrata(frame, BagnonSets[frameName].strata);
	end
	
	local bagFrame = getglobal(frameName .. "Bags");
	if(BagnonSets[frameName].bagsShown) then
		bagFrame:Show();
		getglobal(frameName .. "ShowBags"):SetText(BAGNON_HIDEBAGS);
	end
	
	frame:SetClampedToScreen(BagnonSets[frameName].stayOnScreen);
	
	--load any settings related to BagnonForever/BagnonKC
	if(BagnonForever) then
		frame.player = UnitName("player");
		frame.defaultBags = bags;
	end
	
	--set the frame's ordering. this is dependent on BagnonForever's data
	BagnonCore_OrderBags(frame, BagnonSets[frameName].reverse);
	
	--set the frame's title
	frame.title = title;
	getglobal(frameName .. "Title"):SetText( format(frame.title, UnitName("player") ) );
	frame:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonUp");
	
	--create the frame
	--reposition actually handles rescaling
	BagnonCore_Reposition(frame);
	BagnonCore_GenerateFrame(frame);
	BagnonCore_LayoutFrame(frame, BagnonSets[frameName].cols, BagnonSets[frameName].space);
end

--[[
	Generate the frame (add all items, resize)
--]]

function BagnonCore_GenerateFrame(frame)
	frame.size = 0;
	local frameName = frame:GetName();
	
	--generate a cached frame
	if( Bagnon_IsCachedFrame(frame) ) then
		MoneyFrame_Update(frameName .. "MoneyFrame", BagnonDB_GetMoney(frame.player));
		
		for bag in frame.defaultBags do
			BagnonCore_AddBag(frame, frame.defaultBags[bag]);
		end
	--generate a normal frame
	else
		MoneyFrame_Update(frameName .. "MoneyFrame", GetMoney());
		
		for bag in BagnonSets[frameName].bags do
			BagnonCore_AddBag(frame, BagnonSets[frameName].bags[bag]);
		end
	end
	
	BagnonCore_LayoutFrame(frame, BagnonSets[frame:GetName()].cols, BagnonSets[frame:GetName()].space);
	frame:Show();
end

--[[ 
	Add all the slots of the given bag to the given frame.
	Increase the total size of frame to include the size of the bag
--]]

function BagnonCore_AddBag(frame, bagID)
	local frameName = frame:GetName();
	local slot, index, bagSize, link, item; --slot refers to the itemslot in <frame>, index refers to the item slot in the bag
	
	slot = frame.size;
	
	if( Bagnon_IsCachedBag(frame.player, bagID) ) then
		bagSize = BagnonDB_GetBagData(frame.player, bagID);
	else
		if(bagID == KEYRING_CONTAINER) then
			bagSize = GetKeyRingSize();
		else
			bagSize = GetContainerNumSlots(bagID);
		end
	end
	
	--update used slots
	for index = 1, bagSize, 1 do
		slot = slot + 1;

		item = getglobal( frameName .. "Item".. slot) or BagnonItem_Create(frameName .. "Item".. slot, frame);	
		item:SetID(index);
		item:GetParent():SetID(bagID);
		item:Show();
		
		BagnonCore_UpdateItemInfo(item);
	end
	
	frame.size = frame.size + bagSize;
end

--[[ 
	Resize and hide any unusable bag slots in the frame.
		This function needs to know about the size and layout of the frame
--]]

function BagnonCore_TrimToSize(frame)
	if( not frame.space ) then
		return;
	end

	local frameName = frame:GetName();
	local slot, height;
	
	--hide unused slots
	if(frame.size) then
		local slot = frame.size + 1;
		local button = getglobal( frameName .. "Item".. slot ); 
		
		while button do
			button:Hide();
			slot = slot + 1;
			button = getglobal( frameName .. "Item".. slot ); 
		end
	end
	
	--set the frame's width
	--correction for any frame that's completely empty
	if(not frame.size or frame.size == 0  ) then
		height = 64;
		frame:SetWidth(256);
	else
		--24 is the estimated border width of the frame, 37 is about the width of an item slot
		if(frame.size < frame.cols) then
			frame:SetWidth( ( 37 + frame.space ) * frame.size + 23 - frame.space );
		else
			frame:SetWidth( ( 37 + frame.space ) * frame.cols + 23 - frame.space );
		end

		--set the frame's height, adjusted to fit a bag frame if its shown/there is one
		height = ( 37 + frame.space ) * math.ceil( frame.size / frame.cols )  + 64 - frame.space;
	end
	
	--adjust for the bag frame
	local bagFrame = getglobal(frame:GetName() .. "Bags");	
	
	if( bagFrame and bagFrame:IsShown() ) then
		frame:SetHeight(height + bagFrame:GetHeight());

		if(frame:GetWidth() < bagFrame:GetWidth()) then
			frame:SetWidth(bagFrame:GetWidth());
		end
	else
		frame:SetHeight(height);
	end
	
	--reposition the frame to not be out of bounds
	BagnonCore_SavePosition(frame);
end


-- Update all item information for usable slots
function BagnonCore_Update(frame)
	if( not frame.size or Bagnon_IsCachedFrame(frame) ) then
		return;
	end

	local frameName = frame:GetName();
	local slot;
	
	for slot = 1, frame.size, 1 do
		BagnonCore_UpdateItemInfo( getglobal( frameName .. "Item" .. slot ) );
	end
end

-- Update the texture, lock status, and other information about an item
function BagnonCore_UpdateItemInfo(item)

	if( Bagnon_IsCachedItem(item) ) then
		item.isLink = 1;
		
		local link, texture, count = BagnonDB_GetItemData(item);
		--update texture and count
		SetItemButtonTexture( item, texture );
		SetItemButtonCount( item, count );
		BagnonItem_UpdateLinkBorder(item);
		
		if ( texture ) then
			item.hasItem = 1;
		else
			item.hasItem = nil;
		end
		
		--hide cooldown since there isn't one for linked items
		BagnonItem_UpdateCooldown( item:GetParent():GetID() , item);
	else
		item.isLink = nil;
		
		local texture, itemCount, locked, quality, readable = GetContainerItemInfo(item:GetParent():GetID(), item:GetID());

		BagnonItem_UpdateBorder(item);
		SetItemButtonTexture(item, texture);
		SetItemButtonCount(item, itemCount);
		SetItemButtonDesaturated(item, locked, 0.5, 0.5, 0.5);

		if ( texture ) then
			BagnonItem_UpdateCooldown( item:GetParent():GetID() , item);
			item.hasItem = 1;
		else
			getglobal(item:GetName() .. "Cooldown"):Hide();
			item.hasItem = nil;
		end

		item.readable = readable;
	end
end

-- Layout the frame with given number of columns and button spacing
function BagnonCore_LayoutFrame(frame, cols, space)
	if(not frame.size) then 
		return; 
	end
	
	local frameName = frame:GetName();
	
	if(not cols) then
		cols = DEFAULT_COLS;
	end
	
	if(not space) then
		space = DEFAULT_SPACING;
	end
	
	if(cols == DEFAULT_COLS) then
		BagnonSets[frameName].cols = nil
	else
		BagnonSets[frameName].cols = cols
	end
	
	if(space == DEFAULT_SPACING) then
		BagnonSets[frameName].space = nil;
	else
		BagnonSets[frameName].space = space;
	end
	
	local rows = math.ceil( frame.size / cols );
	local index = 1;
	local button;
	
	--resize the frame
	frame.cols = cols;
	frame.space = space;
	
	
	button = getglobal(frameName .. "Item1");
	if(button) then
		button:ClearAllPoints();
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -32);
	
		for i = 1, rows, 1 do 
			for j = 1, cols, 1 do

				index = index + 1;
				button = getglobal(frameName .. "Item" .. index);

				if(not button) then
					break;
				end

				button:ClearAllPoints();
				button:SetPoint("LEFT", frameName .. "Item" .. index - 1, "RIGHT", space, 0);
			end

			button = getglobal(frameName .. "Item" .. index);

			if(not button) then
				break;
			end

			button:ClearAllPoints();
			button:SetPoint("TOP", frameName .. "Item" .. index - cols, "BOTTOM", 0, -space);
		end
	end
	
	BagnonCore_TrimToSize(frame);
end

--[[
	Safe Open/Close/Toggle <frame>
--]]

function BagnonCore_Open(frameName)
	local frame = getglobal(frameName);
	if( frame ) then
		BagnonCore_GenerateFrame(frame);
	else
		LoadAddOn(frameName);
	end
end

function BagnonCore_Close(frameName)
	local frame = getglobal(frameName);
	if ( frame ) then
		frame:Hide();
	end
end

function BagnonCore_Toggle(frameName)
	local frame = getglobal(frameName);
	if( frame ) then
		if ( frame:IsVisible() ) then
			BagnonCore_Close(frameName);
		else
			BagnonCore_Open(frameName);
		end
	else
		LoadAddOn(frameName);
	end
end

--[[
	Highlight all the slots of <bag>
--]]

function BagnonCore_HighlightSlots(frame, bagID)
	if(not frame.size) then return; end

	local frameName = frame:GetName();
	local slot;

	--update only the slots the player can use
	for slot = 1, frame.size, 1 do
		local item = getglobal( frameName .. "Item" .. slot );

		if( item:GetParent():GetID() == bagID ) then
			item:LockHighlight();
		end
	end
end

function BagnonCore_UnhighlightAll(frame)
	if(not frame.size) then return; end

	local frameName = frame:GetName();
	local slot;

	--update only the slots the player can use
	for slot = 1, frame.size, 1 do
		getglobal( frameName .. "Item" .. slot ):UnlockHighlight();
	end
end

--[[
	Add/Remove <Bag> from the frame
--]]

function BagnonCore_ToggleBagForFrame(frame, bagID)
	if(not frame) then return; end
	
	local frameName = frame:GetName();
	
	--add bag
	if(not Bagnon_FrameHasBag(frameName, bagID) ) then
		table.insert(BagnonSets[frameName].bags, bagID);
	--remove bag
	else
		local index;
		
		for index in BagnonSets[frameName].bags do
			if( BagnonSets[frameName].bags[index] and BagnonSets[frameName].bags[index] == bagID) then
				table.remove(BagnonSets[frame:GetName()].bags, index);
			end
		end
	end

	BagnonCore_OrderBags(frame, BagnonSets.reverseOrder);
	
	--update frame
	if(frame:IsShown()) then
		BagnonCore_GenerateFrame(frame);
	end
end

--[[ 
	Frame Positioning Functions 
--]]

function BagnonCore_StartMoving(frame)
	if(not BagnonSets[frame:GetName()].locked) then
		frame.isMoving = 1;
		frame:StartMoving();
	end
end

function BagnonCore_StopMoving(frame)
	frame.isMoving = nil;
	frame:StopMovingOrSizing();
	BagnonCore_SavePosition(frame);
end

--Place the frame at the last place it was at.  
--This is used when the frame first loads because the game currently does not remember the last position of a frame that's dynamically loaded
function BagnonCore_Reposition(frame)
	local frameName = frame:GetName();
	
	if(not (BagnonSets[frameName] and BagnonSets[frameName].top) ) then
		return;
	end
	
	local ratio;
	--this step is to take care of a potential flaw if the UI scale changes between loadings of the frame
	if(BagnonSets[frameName].parentScale ) then
		ratio = BagnonSets[frameName].parentScale / frame:GetParent():GetScale();
	else
		ratio = 1;
	end
	
	frame:ClearAllPoints();
	frame:SetScale(BagnonSets[frameName].scale);
	frame:SetPoint("TOPLEFT", frame:GetParent(), "BOTTOMLEFT", BagnonSets[frameName].left * ratio, BagnonSets[frameName].top * ratio);
end

--Save the frame's current position.  Needed because frames don't remember their positions if dynamically loaded.
function BagnonCore_SavePosition(frame)
	local frameName = frame:GetName();
	
	if(not BagnonSets[frameName] ) then
		BagnonSets[frameName] = {};
	end
	
	BagnonSets[frameName].top = frame:GetTop();
	BagnonSets[frameName].left = frame:GetLeft();
	BagnonSets[frameName].scale = frame:GetScale();
	BagnonSets[frameName].parentScale = frame:GetParent():GetScale();
end

--[[
	Tooltip Functions
--]]

--tooltips for the title
function BagnonCore_OnHide()
	if(BagnonMenu:IsVisible() and BagnonMenu.frame == this) then
		BagnonMenu:Hide();
	end
	
	if(BagnonForeverMenu and BagnonForeverMenu:IsVisible() and BagnonForeverMenu.frame == this) then
		BagnonForeverMenu:Hide();
	end
end

function BagnonCore_OnEnter()
	if(BagnonSets.showTooltips) then
		GameTooltip_SetDefaultAnchor(GameTooltip,this);

		GameTooltip:SetText(this:GetText(), 1, 1, 1);
		GameTooltip:AddLine(BAGNON_TITLE_TOOLTIP);

		if(BagnonForever) then
			GameTooltip:AddLine(BAGNON_TITLE_FOREVERTOOLTIP);
		end
		GameTooltip:Show();
	end
end

function BagnonCore_OnLeave()
	GameTooltip:Hide();
end

--money frame tooltips, ment to be overriden by forever/kc
function BagnonCoreMoney_OnEnter()
	return;
end

function BagnonCoreMoney_OnLeave()
	GameTooltip:Hide();
end

-- This is a hack that enables tooltips but still allows clicking on the money frame
function BagnonCoreMoney_OnClick()
	local parentName = this:GetParent():GetName();
	
	if( MouseIsOver(getglobal(parentName .. "GoldButton")) ) then
		local parent = this:GetParent();
		OpenCoinPickupFrame(COPPER_PER_GOLD, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
		parent.hasPickup = 1;
	elseif( MouseIsOver(getglobal(parentName .. "SilverButton")) ) then
		local parent = this:GetParent();
		OpenCoinPickupFrame(COPPER_PER_SILVER, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
		parent.hasPickup = 1;
	elseif( MouseIsOver(getglobal(parentName .. "CopperButton")) ) then
		local parent = this:GetParent();
		OpenCoinPickupFrame(1, MoneyTypeInfo[parent.moneyType].UpdateFunc(), parent);
		parent.hasPickup = 1;
	end
end

--[[
		Rightclick Menu Stuff
--]]

--this function is there so that it can be overriden
function BagnonCore_OnDoubleClick(frame)
	return;
end

function BagnonCore_OnClick(frame, mouseButton)
	if(mouseButton == "RightButton") then
		BagnonMenu_Show(frame);
	end
end

--[[
		Bag Sorting
--]]

function BagnonCore_ReverseSort(a, b)
	if(a == KEYRING_CONTAINER) then
		return true;
	elseif(b == KEYRING_CONTAINER) then
		return false;
	elseif(a and b) then 
		return a > b; 
	end;
end

function BagnonCore_NormalSort(a, b)
	if(a == KEYRING_CONTAINER) then
		return false;
	elseif(b == KEYRING_CONTAINER) then
		return true;
	elseif(a and b) then 
		return a < b; 
	end
end

function BagnonCore_OrderBags(frame, reverse)
	if(reverse) then
		if(frame) then
			table.sort(BagnonSets[frame:GetName()].bags, BagnonCore_ReverseSort);
			if(frame.defaultBags) then
				table.sort(frame.defaultBags, BagnonCore_ReverseSort);
			end
		end
	else
		if(frame) then
			table.sort(BagnonSets[frame:GetName()].bags, BagnonCore_NormalSort);
			if(frame.defaultBags) then
				table.sort(frame.defaultBags, BagnonCore_NormalSort);
			end
		end
	end
end
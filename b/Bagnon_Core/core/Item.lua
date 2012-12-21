--[[
	item.lua
		Functions used by the item slots in Bagnon
		
	TODO:
		Code review
		Ability to disable item borders 
--]]

--[[ 
	Item Button Constructor
		The dummyBag is purely for compatibility with mods that need the same structure as a blizzard bag
		Blizzard bag functions use item:GetID() to reference the item slot, and item:GetParent():GetID() to reference their bag
		
		I'm fairly certain that the memory impact is still quite minimal.
--]]

function BagnonItem_Create(name, parent)
	--create the button
	local button = CreateFrame("Button", name, parent, "BagnonItemTemplate");
	button:SetAlpha(parent:GetParent():GetAlpha());
	
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	button:RegisterForDrag("LeftButton");
	
	--Fix for AxuItemMenus
	if(AxuItemMenus_DropDown) then
		button.SplitStack = function(itemButton, split) SplitContainerItem( itemButton:GetParent():GetID() , itemButton:GetID(), split); end;
	end

	return button;
end

function BagnonItem_OnClick(mouseButton, ignoreModifiers)
	if ( this.isLink ) then
		if(this.hasItem) then
			if ( mouseButton == "LeftButton" ) then
				if ( IsControlKeyDown() ) then
					local itemSlot = this:GetID(); 
					local bagID = this:GetParent():GetID();
					local player = this:GetParent():GetParent().player;
					
					DressUpItemLink( (BagnonDB.GetItemData(player, bagID, itemSlot)) );
				elseif( IsShiftKeyDown() ) then
					local itemSlot = this:GetID(); 
					local bagID = this:GetParent():GetID();
					local player = this:GetParent():GetParent().player;
					
					ChatFrameEditBox:Insert( BagnonDB.GetItemHyperlink(player, bagID, itemSlot) );
				end
			end
		end
	else
		ContainerFrameItemButton_OnClick(mouseButton, ignoreModifiers);
	end
end

--[[
	Show tooltip on hover
--]]

function BagnonItem_OnEnter(item)
	--link case
	if(item.isLink) then
		if(item.hasItem)then
			GameTooltip:SetOwner(item);
			
			local itemSlot = item:GetID(); 
			local bagID = item:GetParent():GetID();
			local player = item:GetParent():GetParent().player;
			
			local link, count = BagnonDB.GetItemData(player, bagID, itemSlot);
			GameTooltip:SetHyperlink( link, count );
			
			Bagnon_AnchorTooltip(item);
		end
	--normal bag case
	else	
		--blizzard totally needs to make the bank item not a special case
		if( item:GetParent():GetID() == -1) then
			GameTooltip:SetOwner(item);
			GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID( item:GetID() ) );
		--normal item case
		else
			ContainerFrameItemButton_OnEnter(item);
		end
		
		--Don't reposition tooltips for things using EnhTooltip
		if(not EnhTooltip) then
			Bagnon_AnchorTooltip(item);
		end
	end
end

function BagnonItem_OnUpdate()
	if ( GameTooltip:IsOwned(this) ) then
		BagnonItem_OnEnter(this);
	end
end

--[[
	Update Functions
--]]

-- Update the texture, lock status, and other information about an item
function BagnonItem_Update(item)
	local itemLink, texture, itemCount, readable, locked;
	
	if( Bagnon_IsCachedItem(item) ) then
		item.isLink = 1;
		
		local itemSlot = item:GetID(); 
		local bagID = item:GetParent():GetID();
		local player = item:GetParent():GetParent().player;
		
		_, itemCount, texture, quality = BagnonDB.GetItemData(player, bagID, itemSlot);
		BagnonItem_UpdateLinkBorder(item, quality);
		
		if ( texture ) then
			item.hasItem = 1;
		else
			item.hasItem = nil;
		end
		
		--hide cooldown since there isn't one for linked items
		BagnonItem_UpdateCooldown(bagID, item);
	else
		item.isLink = nil;
		
		texture, itemCount, locked, _, readable = GetContainerItemInfo(item:GetParent():GetID(), item:GetID());
		BagnonItem_UpdateBorder(item);

		if ( texture ) then
			BagnonItem_UpdateCooldown(item:GetParent():GetID() , item);
			item.hasItem = 1;
		else
			getglobal(item:GetName() .. "Cooldown"):Hide();
			item.hasItem = nil;
		end
		
		SetItemButtonDesaturated(item, locked, 0.5, 0.5, 0.5);
		item.readable = readable;
	end
	
	--update texture and count
	SetItemButtonTexture( item, texture );
	SetItemButtonCount( item, itemCount );
end

function BagnonItem_UpdateBorder(button)
	local bagID = button:GetParent():GetID();
	
	if BagnonSets.qualityBorders then
		--Adapted from OneBag.  The author had a clever idea of using the link to generate the color
		local link = ( GetContainerItemLink(bagID , button:GetID()) );
		if link then
			local _, _, hexString = strfind(link ,"|cff([%l%d]+)|H");
			local red = tonumber(strsub(hexString, 1, 2), 16)/256;
			local green = tonumber(strsub(hexString, 3, 4), 16)/256;
			local blue = tonumber(strsub(hexString, 5, 6), 16)/256;
			if red ~= green and red ~= blue then
				getglobal(button:GetName() .. "Border"):SetVertexColor(red, green, blue, 0.5);
				getglobal(button:GetName() .. "Border"):Show();
			else
				getglobal(button:GetName() .. "Border"):Hide();
			end
		else
			getglobal(button:GetName() .. "Border"):Hide();
		end
	else
		getglobal(button:GetName() .. "Border"):Hide();
	end
	
	--ammo slot coloring
	if( bagID == KEYRING_CONTAINER ) then
		getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(1, 0.7, 0);
	elseif( Bagnon_IsAmmoBag( bagID ) ) then
		getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(1, 1, 0);
	elseif( Bagnon_IsProfessionBag( bagID ) ) then
		getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(0, 1, 0);
	else
		getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(1, 1, 1);
	end
end

function BagnonItem_UpdateLinkBorder(item, quality)
	local itemSlot = item:GetID(); 
	local bagID = item:GetParent():GetID();
	local player = item:GetParent():GetParent().player;
		
	if( BagnonSets.qualityBorders ) then
		if(not quality) then
			local link = (BagnonDB.GetItemData(player, bagID, itemSlot));
			if(link) then
				_, _, quality = GetItemInfo(link);
			end
		end
		if(quality and quality > 1) then
			local red, green, blue = GetItemQualityColor(quality);		
			getglobal(item:GetName() .. "Border"):SetVertexColor(red, green, blue, 0.5);
			getglobal(item:GetName() .. "Border"):Show();
		else
			getglobal(item:GetName() .. "Border"):Hide();
		end
	else
		getglobal(item:GetName() .. "Border"):Hide();
	end
	
	if( bagID == KEYRING_CONTAINER ) then
		getglobal(item:GetName() .. "NormalTexture"):SetVertexColor(1, 0.7, 0);
	elseif( Bagnon_IsAmmoBag(bagID, player) ) then
		getglobal(item:GetName() .. "NormalTexture"):SetVertexColor(1, 1, 0);
	elseif( Bagnon_IsProfessionBag(bagID , player) ) then
		getglobal(item:GetName() .. "NormalTexture"):SetVertexColor(0, 1, 0);
	else
		getglobal(item:GetName() .. "NormalTexture"):SetVertexColor(1, 1, 1);
	end
end

--Update cooldown
function BagnonItem_UpdateCooldown(container, button)
	if(button.isLink) then
		CooldownFrame_SetTimer(getglobal(button:GetName().."Cooldown"), 0, 0, 0);
	else
		local cooldown = getglobal(button:GetName().."Cooldown");
		local start, duration, enable = GetContainerItemCooldown( container, button:GetID() );

		CooldownFrame_SetTimer(cooldown, start, duration, enable);

		if ( duration > 0 and enable == 0 ) then
			SetItemButtonTextureVertexColor(button, 0.4, 0.4, 0.4);
		end
	end
end
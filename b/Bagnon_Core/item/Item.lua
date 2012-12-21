--[[
		item.lua
			Functions used by the item slots in Bagnon
			
		TODO:
			Code review
			Ability to disable item borders 
			1.11 code improvements
--]]

BAGNON_HEX = {
	["a"] = 10,
	["b"] = 11,
	["c"] = 12,
	["d"] = 13,
	["e"] = 14,
	["f"] = 15,
	["0"] = 0,
	["1"] = 1,
	["2"] = 2,
	["3"] = 3,
	["4"] = 4,
	["5"] = 5,
	["6"] = 6,
	["7"] = 7,
	["8"] = 8,
	["9"] = 9,
};

--[[ Item Button Constructor ]]--
function BagnonItem_Create(name, parent)
	--[[ 
			this is purely for compatibility with mods that need the same structure as a blizzard bag
			Blizzard bag functions use item:GetID() to reference the item slot, and item:GetParent():GetID() to reference their bag
			
			I'm fairly certain that the memory impact is still quite minimal.
	--]]
	local dummyBag = CreateFrame("Frame", nil, parent);
	
	--create the button
	local button = CreateFrame("Button", name, dummyBag);
	button:SetHeight(37);
	button:SetWidth(37);
	
	--[[ Textures ]]--
	
	--border
	local border = button:CreateTexture(name .. "Border", "OVERLAY");
	border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
	border:SetBlendMode("ADD");
	border:SetHeight(68);
	border:SetWidth(68);
	border:SetPoint("CENTER", button, "CENTER", 0, 1);
	
	--icon texture
	local iconTexture = button:CreateTexture(name .. "IconTexture", "BORDER");
	iconTexture:SetAllPoints(button);
	
	--normal, pushed, highlight
	local normalTexture = button:CreateTexture(name .. "NormalTexture");
	normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot2");
	normalTexture:SetHeight(64);
	normalTexture:SetWidth(64);
	normalTexture:SetPoint("CENTER", button, "CENTER", 0, -1);
	button:SetNormalTexture(normalTexture);
	button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress");
	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
	
	--[[ Font Strings ]]--
	local count = button:CreateFontString(name .. "Count", "BORDER");
	count:SetFontObject(NumberFontNormal);
	count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2);
	count:SetJustifyH("RIGHT");
	count:Hide();
	
	local stock = button:CreateFontString(name .. "Stock", "BORDER");
	stock:SetFontObject(NumberFontNormalYellow);
	stock:SetPoint("TOPLEFT", button, "TOPLEFT", 0, -2);
	stock:SetJustifyH("LEFT");
	stock:Hide();
	
	--[[ Frames ]]--
	
	--cooldown model
	local cooldown = CreateFrame("Model", name .. "Cooldown", button);
	cooldown:SetScale(0.85);
	cooldown:SetAllPoints(button);
	cooldown:SetModel("Interface\\Cooldown\\UI-Cooldown-Indicator.mdx");
	cooldown:Hide();
	
	cooldown:SetScript("OnUpdateModel", CooldownFrame_OnUpdateModel);
	cooldown:SetScript("OnAnimFinished", CooldownFrame_OnAnimFinished);	
	
	button:Hide();
	
	--[[ Scripts ]]--
	
	button:SetScript("OnUpdate", function()
		BagnonItem_OnUpdate()
	end);
	
	button:SetScript("OnClick", function()
		BagnonItem_OnClick(arg1);
	end);
	
	button:SetScript("OnHide", function() 
		if ( this.hasStackSplit and (this.hasStackSplit == 1) ) then
			StackSplitFrame:Hide();
		end
	end);
	
	button:SetScript("OnEnter", function() 
		BagnonItem_OnEnter(this);
	end);
	
	button:SetScript("OnLeave", function()
		this.updateTooltip = nil;
		GameTooltip:Hide();
		ResetCursor();
	end);
	
	button:SetScript("OnDragStart", function() 
		BagnonItem_OnClick("LeftButton", 1);
	end);
	
	button:SetScript("OnReceiveDrag", function() 
		BagnonItem_OnClick("LeftButton", 1);
	end);
	
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
					DressUpItemLink( BagnonDB_GetItemData(this) );
				elseif( IsShiftKeyDown() ) then
					ChatFrameEditBox:Insert( BagnonDB_GetFullItemLink(this) );
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

function BagnonItem_OnEnter(button)
	--link case
	if(button.isLink) then
		if(button.hasItem)then
			GameTooltip:SetOwner(button);
			local link, _, count = BagnonDB_GetItemData(button);
			--this is a tweak for one of my personal mods, Ludwig.  It allows for mods to add sellvalue to linked items.
			GameTooltip:SetHyperlink( link, count );
			
			Bagnon_AnchorTooltip(button);
		end
	--normal bag case
	else	
		--blizzard totally needs to make the bank button not a special case
		if( button:GetParent():GetID() == -1) then
			GameTooltip:SetOwner(button);
			GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID( button:GetID() ) );
		--normal item case
		else
			ContainerFrameItemButton_OnEnter(button);
		end
		
		--Don't reposition tooltips for things using EnhTooltip
		if(not EnhTooltip) then
			Bagnon_AnchorTooltip(button);
		end
	end
end

function BagnonItem_OnUpdate()
	if ( GameTooltip:IsOwned(this) ) then
		BagnonItem_OnEnter(this);
	end
end

--[[
	Update tooltip info
--]]

--Adapted from OneBag.  The author had a clever idea of using the link to generate the color instead of getting the quality, then the color
function BagnonItem_UpdateBorder(button)
	local link = GetContainerItemLink(button:GetParent():GetID() , button:GetID());
	
	if(link) then
		--item border coloring
		local _, _, hexString = strfind( link ,"|cff(%w+)|H");
		local red = ( 16 * BAGNON_HEX[string.sub(hexString, 1, 1)] + BAGNON_HEX[string.sub(hexString, 2, 2)] ) / 256;
		local green = ( 16 * BAGNON_HEX[string.sub(hexString, 3, 3)] + BAGNON_HEX[string.sub(hexString, 4, 4)] ) / 256;
		local blue = ( 16 * BAGNON_HEX[string.sub(hexString, 5, 5)] + BAGNON_HEX[string.sub(hexString, 6, 6)] ) / 256;
		
		local border = getglobal(button:GetName() .. "Border");
		if( border and (red ~= green and red ~= blue ) ) then
			border:SetVertexColor(red, green, blue, 0.4);
			border:Show();
		else
			border:Hide();
		end
	else
		--ammo slot coloring
		getglobal(button:GetName() .. "Border"):Hide();
		
		local bagID = button:GetParent():GetID();
		if( bagID == KEYRING_CONTAINER) then
			getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(1, 0.7, 0);
		elseif( Bagnon_IsAmmoBag( bagID ) ) then
			getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(1, 1, 0);
		elseif( Bagnon_IsProfessionBag( bagID ) ) then
			getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(0, 1, 0);
		else
			getglobal(button:GetName() .. "NormalTexture"):SetVertexColor(1, 1, 1);
		end
	end
end

function BagnonItem_UpdateLinkBorder(item)
	local iLink = ( BagnonDB_GetItemData(item) );
	
	if(iLink) then
		local name, link, quality = GetItemInfo( iLink );
		local red, green, blue;
		
		if(quality) then
			red, green, blue = GetItemQualityColor(quality);
		end
		
		if( getglobal(item:GetName() .. "Border") and (red ~= green and red ~= blue) ) then
			getglobal(item:GetName() .. "Border"):SetVertexColor(red, green, blue, 0.4);
			getglobal(item:GetName() .. "Border"):Show();
		else
			getglobal(item:GetName() .. "Border"):Hide();
		end
	else
		getglobal(item:GetName() .. "Border"):Hide();
	end
	
	getglobal(item:GetName() .. "NormalTexture"):SetVertexColor(1, 1, 1);
end

--[[ 
	Update cooldown
		It mainly handles the special case of 
--]]

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
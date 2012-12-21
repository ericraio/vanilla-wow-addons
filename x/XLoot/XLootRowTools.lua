-- Various functions both Group and Monitor share

local _G = getfenv(0)

function XLoot:QualityColorRow(row, quality)
	if quality == "coin" then
		row.border:Hide()
		row.button.border:Hide()
		row:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))				
		row.button:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
		row.button.wrapper:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
	else
		local r, g, b, hex = GetItemQualityColor(quality)
		if quality >= XLoot.db.profile.loothighlightthreshold then
			if XLoot.db.profile.texcolor then
				row.button.border:SetVertexColor(r, g, b, .5)
				row.button.border:Show()
			else button.border:Hide() end
			if XLoot.db.profile.loothighlightframe and not row.status then
				row.border:SetVertexColor(r, g, b, .3)
				row.border:Show()
			else row.border:Hide() end
		else
			row.button.border:Hide()
			row.border:Hide()
		end
		if XLoot.db.profile.lootqualityborder then
			row:SetBackdropBorderColor(r, g, b, 1)				
			row.button:SetBackdropBorderColor(r, g, b, 1)				
			row.button.wrapper:SetBackdropBorderColor(r, g, b, 1)
		else
			row:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))				
			row.button:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
			row.button.wrapper:SetBackdropBorderColor(unpack(XLoot.db.profile.lootbordercolor))
		end
		if row.status then
			row.status:SetStatusBarColor(r, g, b, .7)
		end
	end
end

function XLoot:OnRowClick(button, stack, row, AA)
	if button == "LeftButton" then
		if ( IsControlKeyDown() ) then
			DressUpItemLink(row.link);
		elseif ( IsShiftKeyDown() ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(row.link);
			end
		end
	elseif button == "RightButton" and not IsControlKeyDown() and not IsShiftKeyDown() and row.candismiss then
		AA:PopRow(stack, row.id, nil, nil, 0.3, function() AA:Restack(stack) end)
	end
end

function XLoot:SizeRow(stack, row)
	local row = row
	local playerwidth, lootwidth, rollswidth = row.fsplayer:GetStringWidth(), row.fsloot:GetStringWidth(), (row.bgreed and XLootGroup.db.profile.buttonscale or 0)
	local framewidth = playerwidth+lootwidth+rollswidth
	row:SetWidth(framewidth+38+(row.sizeoffset or 0))
	XLoot:QualityBorderResize(row, 1.76, 1.34, 2, 1)
end


function XLoot:GenericItemRow(stack, id, AA)
	local row = CreateFrame("Frame", "XLRow"..stack.name..id, UIParent)
	local button = CreateFrame("Button", "XLRowButton"..stack.name..id, row, "ItemButtonTemplate")
	button:EnableMouse(false)
	_G[button:GetName().."NormalTexture"]:SetWidth(66)
	_G[button:GetName().."NormalTexture"]:SetHeight(66)
	local overlay = CreateFrame("Button", "XLMonitorRowOverlay"..stack.name..id, row)
	row.overlay = overlay

	row.fsplayer = row:CreateFontString("XLRow"..stack.name..id.."Player", "ARTWORK", "GameFontNormalSmall")
	row.fsloot = row:CreateFontString("XLRow"..stack.name..id.."Loot", "ARTWORK", "GameFontNormalSmall")
	row.fsextra = row:CreateFontString("XLRow"..stack.name..id.."Extra", "ARTWORK", "GameFontNormalSmall")

	row:SetWidth(316)
	row:SetHeight(22)
	button:SetScale(.55)
	button:ClearAllPoints()
	button:SetPoint("LEFT", row, "LEFT", 5, 0)
	button:Disable()
	overlay:ClearAllPoints()
	overlay:SetAllPoints(row)
	row.fsplayer:SetHeight(16)
	row.fsloot:SetHeight(16)
	row.fsplayer:ClearAllPoints()
	row.fsplayer:SetPoint("LEFT", button, "RIGHT", 3, 0)
	row.fsloot:ClearAllPoints()
	row.fsloot:SetPoint("LEFT", row.fsplayer, "RIGHT", 2, 0)
	row.fsplayer:SetJustifyH("LEFT")
	row.fsloot:SetJustifyH("LEFT")
	row.fsextra:SetHeight(16)
	row.fsextra:ClearAllPoints()
	row.fsextra:SetPoint("RIGHT", button, "LEFT")
	row.fsextra:SetJustifyH("RIGHT")
	
	overlay:RegisterForDrag("LeftButton")
	overlay:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	overlay:SetScript("OnDragStart", function() AA:DragStart(stack, row) end)
	overlay:SetScript("OnDragStop", function() AA:DragStop(stack, row) end)
	overlay:SetScript("OnClick", function(button) XLoot:OnRowClick(arg1, stack, row, AA) end)
	overlay:SetScript("OnEnter", function() if row.itemid then GameTooltip:SetOwner(row.fsloot, "ANCHOR_TOPLEFT"); GameTooltip:SetHyperlink(row.itemid); CursorUpdate(); end end )
	overlay:SetScript("OnHide", function() AA:OnRowHide(stack, row) end)
	overlay:SetScript("OnLeave", function() GameTooltip:Hide(); ResetCursor(); end)
	overlay:SetScript("OnUpdate", function() CursorOnUpdate(); end)
	
	button.wrapper = XLoot:ItemButtonWrapper(button, 9, 9, 20)
	row.border = XLoot:QualityBorder(row)
	button.border = XLoot:QualityBorder(button.wrapper)
	XLoot:QualityBorderResize(button.wrapper, 1.6, 1.6, 0, 1)
	button:Show()
	button:SetAlpha(1)
	
	XLoot:Skin(row)
	
	row.candismiss = true
	row.sizeoffset = 0
	
	row.button = button
	row.id = id
	
	row:Hide()
	stack.rows[id] = row
	
	stack.built = table.getn(stack.rows)
	return row
end
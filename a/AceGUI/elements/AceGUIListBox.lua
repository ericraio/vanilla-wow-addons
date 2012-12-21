
AceGUIListBox = AceGUIBorderFrame:new({
	isUnit	= TRUE,

	defaultRowHeight	= 16,
	frameWidthOffset	= 25,
	rowLeftOffset		= 8,
	scrollBarOffset		= 16,
	heightOffset		= 15,
	buttonHeightOffset	= -1
})

function AceGUIListBox:Setup()
	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	if( not self._def.backdrop ) then self._def.backdrop = "small" end
	elements.Label			= {type = ACEGUI_FONTSTRING}
	elements.NormalBackdrop = {type = ACEGUI_FRAME}
	elements.SmallBackdrop  = {type = ACEGUI_FRAME}
	elements.ScrollBox		= {
		type	= ACEGUI_SCROLL_FRAME,
		anchors	= {
			topleft		= {
				xOffset = 10,
				yOffset = -5
			},
			bottomleft	= {
				xOffset = 10,
				yOffset = 4
			},
			topright	= {
				xOffset = -27,
				yOffset = -5
			},
			bottomright	= {
				xOffset = -27,
				yOffset = 4
			}
		}
	}
	elements.Spacer			= {
		type	= ACEGUI_FRAME,
		anchors = {
			topright	= {xOffset = 0, yOffset = 0},
			bottomright	= {xOffset = 0, yOffset = 0}
		}
	}
	self:AddRows()
end

function AceGUIListBox:AddRows()
	local r, c = 0, 0
	local prevRow, row, prevCol, col

	self.Rows = {}

	repeat
		r = r + 1
		prevRow = row
		row		= getglobal(self:GetName().."Row"..r)
		if( row ) then
			self.Rows[r] = row
			row.Cols = {}
			self._def.elements["Row"..r] = {
				type	 = ACEGUI_BUTTON,
				anchors	 = {
					topleft	 = {
						relTo	 = (prevRow or self):GetName(),
						relPoint = prevRow and "bottomleft",
						xOffset	 = (not prevRow) and self.rowLeftOffset or 0,
						yOffset	 = (not prevRow) and -8 or self.buttonHeightOffset
					},
					topright = {
						relTo	 = prevRow and prevRow:GetName() or "$parentSpacer",
						relPoint = prevRow and "bottomright" or "topleft",
						xOffset	 = 0,
						yOffset	 = (not prevRow) and -8 or self.buttonHeightOffset
					}
				},
				elements = {
					Highlight		= {type = ACEGUI_TEXTURE},
					NormalText		= {type = ACEGUI_FONTSTRING},
					HighlightText	= {type = ACEGUI_FONTSTRING},
					DisabledText	= {type = ACEGUI_FONTSTRING}
				}
			}
			c	= 1
			col	= getglobal(row:GetName().."Col"..c)
			if( col ) then
				prevCol = nil
				while( col ) do
					self._def.elements["Row"..r].elements["Col"..c] = {
						type	= self._def.colTypes
									and self._def.colTypes[c]
									or	ACEGUI_BUTTON,
						anchors	= {
							left = {
								relTo	 = (prevCol or row):GetName(),
								relPoint = prevCol and "right",
								xOffset	 = prevCol and 0 or 2
							}
						},
					}
					self.Rows[r].Cols[c] = col
					col.colID	 = c
					col.rowIndex = r
					if( getglobal(col:GetName().."Text") ) then
						self._def.elements["Row"..r].elements["Col"..c].elements = {
							Text = {type = ACEGUI_FONTSTRING}
						}
					end
					col:SetScript("OnClick", function() self:CallHandler("OnItemClick") end)
					col:SetScript("OnEnter", function() self:CallHandler("OnItemEnter") end)
					col:SetScript("OnLeave", function() self:CallHandler("OnItemLeave") end)

					c = c + 1
					prevCol = col
					col = getglobal(row:GetName().."Col"..c)
				end
			else
				self.Rows[r].Cols[c] = row
				row.colID	 = 1
				row.rowIndex = r
				row:SetScript("OnClick", function() self:CallHandler("OnItemClick") end)
				row:SetScript("OnEnter", function() self:CallHandler("OnItemEnter") end)
				row:SetScript("OnLeave", function() self:CallHandler("OnItemLeave") end)
			end
		end
	until( not row )
end

function AceGUIListBox:Configure()
	AceGUIBorderFrame.Configure(self)
	if( self._def.barTexture ) then self.ScrollBox:ShowBarTexture() end
	self:SetLabel()
end

function AceGUIListBox:DynamicSize(w, h)
	if( not w ) then
		w = 0
		for r = 1, getn(self.list), 1 do
			local width = 0
			if( (type(self.list[r]) == "table") and (getn(self.list[r]) > 0) ) then
				for c = 1, getn(self.list[r]) do
					width = width + self.Rows[1].Cols[1]:GetWidth()
				end
			elseif( self.Rows[1].Cols[1].NormalText ) then
				self.Rows[1].Cols[1]:SetText(self:GetListText(r))
				width = width + self.Rows[1].Cols[1].NormalText:GetWidth()
			elseif( self.Rows[1].Cols[1].Text ) then
				self.Rows[1].Cols[1]:SetText(self:GetListText(r))
				width = width + self.Rows[1].Cols[1].Text:GetWidth()
			end
			if( width > w ) then w = width end
		end
		w = w + self.frameWidthOffset + self.Spacer:GetWidth()
		if( w < self._def.minWidth ) then w = self._def.minWidth end
	end

	if( not h ) then
		if( getn(self.list) > self.visibleRows ) then
			h = self.visibleRows * (self.rowHeight + abs(self.buttonHeightOffset)) + self.heightOffset
		else
			h = getn(self.list) * (self.rowHeight + abs(self.buttonHeightOffset)) + self.heightOffset
		end
	end

	return w, h
end

function AceGUIListBox:Resize(width, height, rh, cw)
	local cwList

	if( not width ) then width = self._def.width end
	if( not height ) then height = self._def.height end
	if( not rh ) then rh = self._def.rowHeight end
	if( not cw ) then cw = self._def.colWidth end

	self.rowHeight = rh or self.defaultRowHeight
	self.ScrollBox.rowHeight = self.rowHeight

	width, height = self:DynamicSize(width, height)

	if( not cw ) then
		cw = floor(
				(width - self.rowLeftOffset - self.scrollBarOffset)
				/ getn(self.Rows[1].Cols)
			 )
	elseif( type(cw) == "table" ) then
		cwList = cw
		cw = nil
	end

	self:SetWidth(width)
	self:SetHeight(height)

	for r = 1, getn(self.Rows) do
		self.Rows[r]:SetHeight(self.rowHeight)
		for c = 1, getn(self.Rows[r].Cols) do
			self.Rows[r].Cols[c]:SetWidth(cw or cwList[c])
			self.Rows[r].Cols[c]:SetHeight(self.rowHeight)
		end
	end
end

function AceGUIListBox:Refresh()
	if( (not self.list) or (self.list ~= self._def.options) ) then
		self.list = self._def.options or self:CallMethod("fill")
	end

	if( not self.list ) then return end

	self.visibleRows = self._def.visibleRows or getn(self.Rows)
	self.totalLines  = getn(self.list)

	if( self.totalLines < self.visibleRows ) then self.visibleRows = self.totalLines end

	for r = 1, getn(self.Rows) do
		if( r <= self.visibleRows ) then
			self.Rows[r]:Show()
		else
			self.Rows[r]:Hide()
		end
	end

	if( self.visibleRows < self.totalLines ) then
		self.ScrollBox:SetWidth(self:GetWidth())
		self.ScrollBox:Show()
		self.Spacer:SetWidth(self.scrollBarOffset)
	else
		self.ScrollBox:Hide()
		self.Spacer:SetWidth(1)
	end

	self:Resize()
end

-- Mostly borrowed from FauxScrollFrame_Update()
function AceGUIListBox:UpdateScrollBox()
	if( (self.ScrollBox.ScrollBar:GetValue() or 0) <= 0 ) then
		self.ScrollBox.ScrollBar:SetValue(0)
	end

	local scrollFrameHeight, scrollChildHeight

	if( self.totalLines > 0 ) then
		scrollFrameHeight = (self.totalLines - self.visibleRows) * self.rowHeight
		scrollChildHeight = self.totalLines * self.rowHeight
		if( scrollFrameHeight < 0 ) then
			scrollFrameHeight = 0
		end
		self.ScrollBox.ScrollChildFrame:Show()
	else
		self.ScrollBox.ScrollChildFrame:Hide()
	end
	self.ScrollBox.ScrollBar:SetMinMaxValues(0, scrollFrameHeight or 0)
	self.ScrollBox.ScrollBar:SetValueStep(self.rowHeight or 0)
	self.ScrollBox.ScrollChildFrame:SetHeight(scrollChildHeight or 0)

	-- Arrow button handling
	if( self.ScrollBox.ScrollBar:GetValue() == 0 ) then
		self.ScrollBox.ScrollBar.ScrollUpButton:Disable()
	else
		self.ScrollBox.ScrollBar.ScrollUpButton:Enable()
	end
	if( (self.ScrollBox.ScrollBar:GetValue() - scrollFrameHeight) == 0) then
		self.ScrollBox.ScrollBar.ScrollDownButton:Disable()
	else
		self.ScrollBox.ScrollBar.ScrollDownButton:Enable()
	end
end

function AceGUIListBox:Update()
	if( (not self.list) or (self.totalLines ~= getn(self.list)) ) then self:Refresh() end
	if( not self.list ) then return end

	local i

	self:UpdateScrollBox()

	if( self._lockedRow ) then self._lockedRow = nil end

	for r = 1, self.visibleRows do
		i = r + self.ScrollBox.offset

		self.Rows[r].rowID = i
		for c = 1, getn(self.Rows[r].Cols) do
			self.Rows[r].Cols[c]:SetValue(self:GetListText(i, c) or "")
			self.Rows[r].Cols[c].rowID = i
			if( self:GetListVal(i, c) == self.selectedValue ) then
				self:SetSelected(i, c)
			end
		end
		if( i == self.selectedRowID ) then
			self.Rows[r].Highlight:Show()
			self.Rows[r]:LockHighlight()
			self._lockedRow = self.Rows[r]
		else
			self.Rows[r].Highlight:Hide()
			self.Rows[r]:UnlockHighlight()
		end
	end
end

function AceGUIListBox:OnVerticalScroll()
	self.ScrollBox:OnVerticalScroll()
	self:Update()
end

function AceGUIListBox:OnMouseWheel()
	self.ScrollBox:OnMouseWheel()
end


--[[--------------------------------------------------------------------------------
  Values
-----------------------------------------------------------------------------------]]

function AceGUIListBox:GetListText(r, c)
	if( not r ) then return end
	if( type(self.list[r]) == "table" ) then
		return (self.list[r][c or 0] or self.list[r]).text or
			   (self.list[r][c or 0] or self.list[r]).val
	else
		return self.list[r]
	end
end

function AceGUIListBox:GetListVal(r, c)
	if( not r ) then return end
	if( type(self.list[r]) == "table" ) then
		return (self.list[r][c or 0] or self.list[r]).val
	else
		return self.list[r]
	end
end

function AceGUIListBox:GetListTip(r, c)
	if( not r ) then return end
	if( type(self.list[r]) == "table" ) then
		return (self.list[r][c or 0] or self.list[r]).tip
	end
end

function AceGUIListBox:GetValue()
	return self.selectedValue
end

function AceGUIListBox:SetValue(val)
	self.selectedRowID = nil
	self.selectedColID = nil
	self.selectedValue = nil

	if( not val ) then return end

	for r = 1, getn(self.list) do
		if( type(self.list[r]) == "table" ) then
			for c = 1, getn(self.list[r]) do
				if( self.GetListVal(r, c) == val ) then
					self:SetSelected(r, c)
					return
				end
			end
		else
			if( self.GetListVal(r) == val ) then
				self:SetSelected(r, c)
				return
			end
		end
	end
end

function AceGUIListBox:GetSelected()
	return self.selectedRowID, self.selectedColID, self.selectedValue
end

function AceGUIListBox:SetSelected(r, c)
	if( (r == self.selectedRowID) and (c == self.selectedColID) ) then return end

	self.selectedRowID = r
	self.selectedColID = c
	self.selectedValue = self:GetListVal(r, c)
end

function AceGUIListBox:Clear()
	self:SetValue()
end

function AceGUIListBox:ClearList()
	self:SetValue()
	self.ScrollBox:Clear()
	self.list = nil
end


--[[--------------------------------------------------------------------------------
  Events
-----------------------------------------------------------------------------------]]

function AceGUIListBox:OnShow()
	self:Update()
end

function AceGUIListBox:OnItemClick()
	self:CloseDropDowns()

	if( self._lockedRow ) then
		self._lockedRow:UnlockHighlight()
		if( self._lockedRow ~= self.Rows[this.rowIndex] ) then
			self._lockedRow.Highlight:Hide()
		end
		self._lockedRow = nil
	end

	if( self.selectedRowID ~= this.rowID ) then
		self:SetSelected(this.rowID, this.colID)
		self.Rows[this.rowIndex].Highlight:Show()
		self.Rows[this.rowIndex]:LockHighlight()
		self._lockedRow = self.Rows[this.rowIndex]
	else
		self:SetSelected()
	end

	self:CallHandler("OnSelect")
end

function AceGUIListBox:OnItemEnter()
	local tip = self:GetListTip(this.rowID, this.colID)
	self.Rows[this.rowIndex].Highlight:Show()
	if( tip ) then self:ShowTooltip(self.Rows[this.rowIndex], tip) end
end

function AceGUIListBox:OnItemLeave()
	if( self._lockedRow ~= self.Rows[this.rowIndex] ) then
		self.Rows[this.rowIndex]:UnlockHighlight()
		self.Rows[this.rowIndex].Highlight:Hide()
	end
	if( GameTooltip:IsVisible() ) then GameTooltip:Hide() end
end

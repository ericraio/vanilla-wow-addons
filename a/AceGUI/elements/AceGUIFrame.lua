
AceGUIFrame = AceGUIElement:new()

function AceGUIFrame:Configure()
	if( self._def.backdropColor and self.SetBackdropColor ) then
		self:SetBackdropColor(unpack(self._def.backdropColor))
	end
	if( self._def.backdropBorderColor and self.SetBackdropBorderColor ) then
		self:SetBackdropBorderColor(unpack(self._def.backdropBorderColor))
	end
end


AceGUIBorderFrame = AceGUIElement:new()

function AceGUIBorderFrame:Setup()
	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.NormalBackdrop = {type = ACEGUI_FRAME}
	elements.SmallBackdrop  = {type = ACEGUI_FRAME}
end

function AceGUIBorderFrame:Configure()
	if( self._def.backdrop == "small" ) then
		self:ShowSmallBackdrop()
	elseif( self._def.backdrop == "none" ) then
		self:HideBackdrop()
	else
		self:ShowNormalBackdrop()
	end
	self:SetBackdropColor()
	self:SetBackdropBorderColor()
end

function AceGUIBorderFrame:ShowSmallBackdrop()
	self.NormalBackdrop:Hide()
	self.SmallBackdrop:Show()
	self.Backdrop = self.SmallBackdrop
	self.backdropColor = self.defSmallBackdropColor
	self.backdropBorderColor = self.defSmallBackdropBorderColor
end

function AceGUIBorderFrame:ShowNormalBackdrop()
	self.SmallBackdrop:Hide()
	self.NormalBackdrop:Show()
	self.Backdrop = self.NormalBackdrop
	self.backdropColor = nil
	self.backdropBorderColor = nil
end

function AceGUIBorderFrame:HideBackdrop()
	self.SmallBackdrop:Hide()
	self.NormalBackdrop:Hide()
	self.Backdrop = nil
	self.backdropColor = nil
	self.backdropBorderColor = nil
end

function AceGUIBorderFrame:SetBackdropColor(r, g, b)
	if( r and g and b ) then
		self.Backdrop:SetBackdropColor(r, g, b)
	elseif( self._def.backdropColor or self.backdropColor ) then
		self.Backdrop:SetBackdropColor(unpack(self._def.backdropColor or self.backdropColor))
	end
end

function AceGUIBorderFrame:SetBackdropBorderColor(r, g, b)
	if( r and g and b ) then
		self.Backdrop:SetBackdropBorderColor(r, g, b)
	elseif( self._def.backdropBorderColor or self.backdropBorderColor ) then
		self.Backdrop:SetBackdropBorderColor(
			unpack(self._def.backdropBorderColor or self.backdropBorderColor)
		)
	end
end

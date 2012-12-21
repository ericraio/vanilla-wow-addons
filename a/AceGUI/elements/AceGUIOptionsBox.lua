
AceGUIOptionsBox = AceGUIElement:new()

function AceGUIOptionsBox:Setup()
	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.Title = {type = ACEGUI_FONTSTRING}
end

function AceGUIOptionsBox:Configure()
	self:SetBackdropBorderColor(
		unpack(self._def.backdropBorderColor or self.defSmallBackdropBorderColor)
	)
	self:SetBackdropColor(unpack(self._def.backdropColor or self.defSmallBackdropColor))
	self:SetLabel()
end

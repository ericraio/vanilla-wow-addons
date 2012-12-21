
AceGUICheckButton = AceGUIElement:new()

function AceGUICheckButton:SetValue(val)
	self:SetChecked(val)
end

function AceGUICheckButton:OnEnter()
	if( self._def.tooltip ) then self:ShowTooltip(self, self._def.tooltip) end
end

function AceGUICheckButton:OnLeave()
	if( GameTooltip:IsVisible() ) then GameTooltip:Hide() end
end


AceGUICheckBox = AceGUICheckButton:new()

function AceGUICheckBox:Setup()
	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.Label = {type = ACEGUI_FONSTRING}
end

function AceGUICheckBox:Configure()
	self:SetLabel()
end

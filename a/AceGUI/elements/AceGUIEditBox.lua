
AceGUIEditBox = AceGUIElement:new()

function AceGUIEditBox:Enable()
	self.disabled = nil
	self:SetTextColor(unpack(self.highlightFontColor))
end

function AceGUIEditBox:Disable()
	self.disabled = true
	self:SetTextColor(unpack(self.disabledFontColor))
	self:SetText("")
	self:ClearFocus()
end


function AceGUIEditBox:OnEnterPressed()
	self:ClearFocus()
end

function AceGUIEditBox:OnEscapePressed()
	this:ClearFocus()
end

function AceGUIEditBox:OnEditFocusGained()
	-- Part of the enable/disable hack. If the edit box is disabled, then disallow
	-- focus by immediately clearing it when gained.
	if( self.disabled ) then self:ClearFocus() end
	if( self._def.highlight ) then self:HighlightText() end
end

function AceGUIEditBox:OnEditFocusLost()
	self:HighlightText(0, 0)
end


AceGUIInputBox = AceGUIEditBox:new({labelHorzAdjust=-7, labelVertAdjust=-1})

function AceGUIInputBox:Setup()
	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.Label = {type = ACEGUI_FONTSTRING}
end

function AceGUIInputBox:Configure()
	self:SetLabel()
end

function AceGUIInputBox:Enable()
	AceGUIEditBox.Enable(self)
	self.Label:SetTextColor(unpack(self.normalFontColor))
end

function AceGUIInputBox:Disable()
	AceGUIEditBox.Disable(self)
	self.Label:SetTextColor(unpack(self.disabledFontColor))
end

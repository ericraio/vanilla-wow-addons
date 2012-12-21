
AceGUIButton = AceGUIElement:new()

function AceGUIButton:Configure()
	self:SetLabel()
end

function AceGUIButton:SetLabel(text)
	if( (not text) and (not self._def.title) ) then return end
	self:SetText(text or self._def.title)
end

function AceGUIButton:SetValue(val)
	if( self.Text ) then
		self.Text:SetText(val or "")
	else
		self:SetText(val or "")
	end
end

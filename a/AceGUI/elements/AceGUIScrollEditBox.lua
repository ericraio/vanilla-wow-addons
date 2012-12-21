
AceGUIScrollEditBox = AceGUIOptionsBox:new({isUnit=TRUE})

function AceGUIScrollEditBox:Setup()
	AceGUIOptionsBox.Setup(self)

	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.Title		= {type = ACEGUI_FONTSTRING}
	elements.ScrollBox	= {
		type	 = ACEGUI_SCROLL_FRAME,
		elements = {
			EditBox = {
				type	 = ACEGUI_EDITBOX,
				disabled = TRUE
			}
		}
	}
end

function AceGUIScrollEditBox:Configure()
	AceGUIOptionsBox.Configure(self)

	local width  = self:GetWidth()
	local height = self:GetHeight()

	self.ScrollBox:SetWidth(width - 32)
	self.ScrollBox:SetHeight(height - 9)
	self.ScrollBox.EditBox:SetWidth(width - 32)
	self.ScrollBox.EditBox:SetHeight(height - 9)
end


function AceGUIScrollEditBox:SetFocus()
	self.ScrollBox.EditBox:SetFocus()
end

function AceGUIScrollEditBox:ClearFocus()
	self.ScrollBox.EditBox:ClearFocus()
end

function AceGUIScrollEditBox:GetValue()
	return self.ScrollBox.EditBox:GetText()
end

function AceGUIScrollEditBox:SetValue(val)
	self.ScrollBox.EditBox:SetText(val or "")
end


function AceGUIScrollEditBox:Enable()
	self.ScrollBox.EditBox:Enable()
end

function AceGUIScrollEditBox:Disable()
	self.ScrollBox.EditBox:Disable()
end


function AceGUIScrollEditBox:OnChar()
	if( (arg1 == "\n") and (self._def.OnEnterPressed) ) then
		self:SetValue(gsub(self:GetValue(), "\n$", "", 1))
		self:CallHandler("OnEnterPressed")
	end
end

function AceGUIScrollEditBox:OnTextChanged()
	self.ScrollBox:UpdateScrollChildRect()
	local min, max = self.ScrollBox.ScrollBar:GetMinMaxValues()
	if( (max > 0) and (self.max ~= max) ) then
		self.max = max
		self.ScrollBox.ScrollBar:SetValue(max)
	end
end

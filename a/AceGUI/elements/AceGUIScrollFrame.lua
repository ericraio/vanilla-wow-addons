
AceGUIScrollFrame = AceGUIElement:new({offset=0})

function AceGUIScrollFrame:Setup()
	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.ScrollBar	= {
		type	 = ACEGUI_SCROLLBAR,
		elements = {
			ScrollUpButton	 = {type = ACEGUI_BUTTON, disabled = TRUE},
			ScrollDownButton = {type = ACEGUI_BUTTON, disabled = TRUE},
		}
	}
	elements.ScrollChildFrame = {type = ACEGUI_SCROLL_CHILD}
	elements.BarTop		= {type = ACEGUI_TEXTURE}
	elements.BarBottom	= {type = ACEGUI_TEXTURE}
	elements.BarCenter	= {type = ACEGUI_TEXTURE}
end

function AceGUIScrollFrame:ShowBarTexture()
	self.BarTop:Show()
	self.BarBottom:Show()
	self.BarCenter:Show()
end

function AceGUIScrollFrame:HideBarTexture()
	self.BarTop:Hide()
	self.BarBottom:Hide()
	self.BarCenter:Hide()
end

function AceGUIScrollFrame:OnVerticalScroll()
	self.ScrollBar:SetValue(arg1)
	self.offset = floor((arg1 / (self.rowHeight or self._def.rowHeight)) + 0.5)
	GameTooltip:Hide()
end

function AceGUIScrollFrame:OnMouseWheel()
	if( arg1 > 0 ) then
		self.ScrollBar:SetValue(self.ScrollBar:GetValue() - (self.ScrollBar:GetHeight() / 2))
	else
		self.ScrollBar:SetValue(self.ScrollBar:GetValue() + (self.ScrollBar:GetHeight() / 2))
	end
end

function AceGUIScrollFrame:Clear()
	self.offset = 0
	self.ScrollBar:SetValue(0)
end

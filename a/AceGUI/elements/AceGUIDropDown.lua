
AceGUIDropDown = AceGUIElement:new({
	isUnit				= TRUE,
	defaultVisibleRows	= 12,
	menuMinWidthAdjust	= 12
})

--[[--------------------------------------------------------------------------------
  Element Definition
-----------------------------------------------------------------------------------]]

function AceGUIDropDown:Setup()
	tinsert(ACEGUI_REGISTRY.dropDowns, self)

	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.Label		= {type = ACEGUI_FONTSTRING}
	elements.Selection	= {type = ACEGUI_FONTSTRING}
	elements.Button		= {type = ACEGUI_BUTTON}
	elements.Menu		= {
		type		= ACEGUI_LISTBOX,
		visibleRows = self._def.visibleRows or self.defaultVisibleRows,
		minWidth	= self._def.width,
		options		= self._def.options,
		fill		= self._def.fill,
		OnSelect	= self._def.OnSelect
	}
end

function AceGUIDropDown:Configure()
	self:SetBackdropBorderColor(0.4, 0.4, 0.4)
	self:SetBackdropColor(0.1, 0.1, 0.1)
	self:SetLabel()
end


--[[--------------------------------------------------------------------------------
  Display Management
-----------------------------------------------------------------------------------]]

function AceGUIDropDown:ToggleMenu()
	local vis = self.Menu:IsVisible()
	self:CloseDropDowns()
	if( not vis ) then
		self.Menu:Show()
	end
	PlaySound("igMainMenuOptionCheckBoxOn")
end

function AceGUIDropDown:CloseMenu()
	self.Menu:Hide()
end

function AceGUIDropDown:CloseAllDropDowns()
	for _, ctl in ACEGUI_REGISTRY.dropDowns do
		if( ctl.Menu:IsVisible() ) then ctl.Menu:Hide() end
	end
end


--[[--------------------------------------------------------------------------------
  Values
-----------------------------------------------------------------------------------]]

function AceGUIDropDown:GetValue()
	return self.Menu:GetValue()
end

function AceGUIDropDown:SetValue(val)
	self.Menu:SetValue(val)
	self.Selection:SetText(val)
end

function AceGUIDropDown:Clear()
	self.Menu:SetSelected()
	self.Selection:SetText("")
end

function AceGUIDropDown:ClearList()
	self:Clear()
	self.Menu:ClearList()
	self.Menu:Hide()
end


--[[--------------------------------------------------------------------------------
  State Management
-----------------------------------------------------------------------------------]]

function AceGUIDropDown:Enable()
	self:_CALL("Enable")
	self.Selection:SetTextColor(unpack(self.highlightFontColor))
	self.Label:SetTextColor(unpack(self.normalFontColor))
	self.Button:Enable()
	self.disabled = nil
end

function AceGUIDropDown:Disable()
	self:_CALL("Disable")
	self.Selection:SetTextColor(unpack(self.disabledFontColor))
	self.Label:SetTextColor(unpack(self.disabledFontColor))
	self.Button:Disable()
	self.disabled = true
end


--[[--------------------------------------------------------------------------------
  Events
-----------------------------------------------------------------------------------]]

function AceGUIDropDown:OnHide()
	self:CloseMenu()
end

function AceGUIDropDown:OnEnter()
	local r, c = self.Menu:GetSelected()
	if( r ) then
		local tip = self.Menu:GetListTip(self.Menu:GetSelected())
		if( tip ) then self:ShowTooltip(self, tip) end
	end
end

function AceGUIDropDown:OnLeave()
	if( GameTooltip:IsVisible() ) then GameTooltip:Hide() end
end


--[[--------------------------------------------------------------------------------
  Overridden ListBox Handlers
-----------------------------------------------------------------------------------]]

function AceGUIDropDown:OnItemClick()
	self.Menu:OnItemClick()
	self.Menu:Hide()
	self.Selection:SetText(self.Menu:GetValue() or "")
end

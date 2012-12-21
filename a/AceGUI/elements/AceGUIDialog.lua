
AceGUIBasicDialog = AceGUIBorderFrame:new()

function AceGUIBasicDialog:Setup()
	if( self._def.isUIPanel ) then
		UIPanelWindows[self._def.name] = {area = "center", pushable = 0}
	elseif( self._def.isSpecial ) then
		tinsert(UISpecialFrames, self._def.name)
	end

	if( (not self._def.backdrop) and (self._def.type == ACEGUI_BASIC_DIALOG) ) then
		self._def.backdrop = "small"
	end

	AceGUIBorderFrame.Setup(self)
end


AceGUIDialog = AceGUIBasicDialog:new()

function AceGUIDialog:Setup()
	AceGUIBasicDialog.Setup(self)

	if( not self._def.elements ) then self._def.elements = {} end
	local elements = self._def.elements
	elements.Header = {
		type	 = ACEGUI_FRAME,
		elements = {
			Bar   = {type = ACEGGUI_TEXTURE},
			Title = {type = ACEGUI_FONTSTRING}
		}
	}
	elements.Close = {
		type  = ACEGUI_BUTTON,
		title = CLOSE
	}
end

function AceGUIDialog:Configure()
	AceGUIBorderFrame.Configure(self)
	self:SetLabel()
end

function AceGUIDialog:SetLabel(text)
	if( not self.Header ) then return end
	self.Header.Title:SetText(text or self._def.title)
	if( text or self._def.title ) then
		self.Header:Show()
	else
		self.Header:Hide()
	end
end

function AceGUIDialog:Show()
	if( self.isUIPanel ) then
		ShowUIPanel(self)
	else
		self:_CALL("Show")
	end
end

function AceGUIDialog:Hide()
	PlaySound(self.closeSound or "gsTitleOptionExit")
	if( self.isUIPanel ) then
		HideUIPanel(self)
	else
		self:_CALL("Hide")
	end
end

function AceGUIDialog:OnHide()
	-- Check if this dialog was opened by myAddOns
	if ( MYADDONS_ACTIVE_OPTIONSFRAME == self ) then
		ShowUIPanel(myAddOnsFrame)
	end
end

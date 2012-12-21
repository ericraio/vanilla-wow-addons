
--[[--------------------------------------------------------------------------------
  Definition
-----------------------------------------------------------------------------------]]

AceGUIElement = AceModuleClass:new({
	defSmallBackdropColor		= {0.1, 0.1, 0.1},
	defSmallBackdropBorderColor	= {0.4, 0.4, 0.4},
	normalFontColor		= {NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b},
	highlightFontColor	= {HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b},
	disabledFontColor	= {GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b},
})

function AceGUIElement:Initialize(parent, name, def, unit, handler)
	local ctl

	if( parent ) then
		ctl = getglobal(parent:GetName()..name)
		if( not ctl ) then
			error("'"..parent:GetName().."' has no child '"..name.."'.", 3)
		end
		parent[name] = ctl
		ctl.handler	 = handler or parent.handler
	else
		ctl = getglobal(name)
		if( not ctl ) then
			error("'"..parent:GetName().."' has no child '"..name.."'.", 3)
		end
		ctl.handler = handler
	end

	ctl.parentUnit = unit or (parent and parent.parentUnit)
	ctl._driver	= self
	ctl._def	= def
	ctl._lookup	= getmetatable(ctl).__index

	setmetatable(ctl, {__index =
		function(self, key)
			return self._driver[key] or self:_lookup(key)
		end
	})

	ctl:Setup()
	ctl:BuildElements()
	ctl:ApplySettings()
	ctl:Configure()
	return ctl
end


--[[--------------------------------------------------------------------------------
  Method Handlers
-----------------------------------------------------------------------------------]]

function AceGUIElement:_CALL(key, ...)
	return self:_lookup(key)(self, unpack(arg))
end

function AceGUIElement:CallHandler(handler, ...)
	if( self._def[handler] ) then
		self.handler[self._def[handler]](self.handler, unpack(arg))
	end
	if( self.parentUnit and self.parentUnit[handler] ) then
		self.parentUnit[handler](self.parentUnit, unpack(arg))
	elseif( self[handler] ) then
		self[handler](self, unpack(arg))
	end
end

function AceGUIElement:CallMethod(meth, ...)
	if( self._def[meth] ) then
		return self.handler[self._def[meth]](self.handler, unpack(arg))
	end
end


--[[--------------------------------------------------------------------------------
  Create the Element
-----------------------------------------------------------------------------------]]

function AceGUIElement:Setup() end
function AceGUIElement:Configure() end

function AceGUIElement:ApplySettings()
	local def = self._def

	if( def.value )  then self:SetValue(def.value) end
	if( def.width )  then self:SetWidth(def.width) end
	if( def.height ) then self:SetHeight(def.height) end
	if( def.anchors ) then self:ApplyAnchors(def.anchors) end
end

function AceGUIElement:ApplyAnchors(anchors, clear)
	if( clear ) then self:ClearAllPoints() end
	for anchor, options in anchors do
		if( options.relTo ) then
			options.relTo = gsub(options.relTo, "$parent", self:GetParent():GetName(), 1)
		end
		self:SetPoint(strupper(anchor),
					  options.relTo or self:GetParent():GetName(),
					  strupper(options.relPoint or anchor),
					  options.xOffset or 0,
					  options.yOffset or 0
					 )
	end
end

function AceGUIElement:BuildElements()
	if( not self._def.elements ) then return end

	for name, def in self._def.elements do
		local ctl = ACEGUI_DRIVER_MAP[def.type or 0]:Initialize(
						self,
						name,
						def,
						self.isUnit and self
					)
		if( ctl ) then
			if( def.disabled ) then ctl:Disable() end
			if( def.OnLoad ) then self:CallHandler("OnLoad") end
		end
	end
end

function AceGUIElement:SetLabel(text)
	if( self.Title ) then
		self.Title:SetText(text or self._def.title)
	elseif( self.Label ) then
		self.Label:SetText(text or self._def.title)
	else
		return
	end

	if( not self._def.labelOptions ) then return end

	local options = self._def.labelOptions
	if( options.align == "left" ) then
		self.Label:ClearAllPoints()
		self.Label:SetPoint("RIGHT",
							self:GetName(),
							"LEFT",
							(options.hOffset or 0) + (self.labelHorzAdjust or 0),
							(options.vOffset or 0) + (self.labelVertAdjust or 0)
						   )
	elseif( options.align == "right" ) then
		self.Label:ClearAllPoints()
		self.Label:SetPoint("LEFT",
							self:GetName(),
							"RIGHT",
							(options.hOffset or 0) + (self.labelHorzAdjust or 0),
							(options.vOffset or 0) + (self.labelVertAdjust or 0)
						   )
	else
		self.Label:ClearAllPoints()
		self.Label:SetPoint("BOTTOMLEFT",
							self:GetName(),
							"TOPLEFT",
							(options.hOffset or 5) + (self.labelHorzAdjust or 0),
							(options.vOffset or 1) + (self.labelVertAdjust or 0)
						   )
	end
end


--[[--------------------------------------------------------------------------------
  Value Access
-----------------------------------------------------------------------------------]]

function AceGUIElement:GetValue()
	if( self:_lookup("GetValue") ) then
		return self:_CALL("GetValue")
	elseif( self.SetText ) then
		return self:GetText()
	end
end

function AceGUIElement:SetValue(val)
	if( self:_lookup("SetValue") ) then
		self:_CALL("SetValue", val)
	elseif( self.SetText ) then
		self:SetText(val or "")
	end
end

function AceGUIElement:Clear()
	if( self.SetText ) then self:SetText("") end
end


--[[--------------------------------------------------------------------------------
  Miscellaneous Shared Tools
-----------------------------------------------------------------------------------]]

function AceGUIElement:ShowTooltip(owner, text)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetOwner(owner, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOMLEFT", owner:GetName(), "TOPLEFT", 20, 2)
	GameTooltip:SetText(text, nil, nil, nil, nil, 1)
end

function AceGUIElement:CloseDropDowns()
	for _, ctl in ACEGUI_REGISTRY.dropDowns do
		if( ctl.Menu:IsVisible() ) then ctl.Menu:Hide() end
	end
end

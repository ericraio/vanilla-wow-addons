
ACEGUI_GENERIC			= 0
ACEGUI_FRAME			= 1
ACEGUI_BORDER_FRAME 	= 2
ACEGUI_BASIC_DIALOG		= 3
ACEGUI_DIALOG			= 4
ACEGUI_OPTIONSBOX		= 5
ACEGUI_BUTTON			= 6
ACEGUI_CHECK_BUTTON		= 7
ACEGUI_DROPDOWN			= 8
ACEGUI_LISTBOX			= 9
ACEGUI_EDITBOX			= 10
ACEGUI_INPUTBOX			= 11
ACEGUI_CHECKBOX			= 12
ACEGUI_SCROLL_EDITBOX	= 13
ACEGUI_SCROLL_FRAME		= 14
ACEGUI_SCROLLBAR		= 15
ACEGUI_SCROLL_CHILD		= 16
ACEGUI_SLIDER			= 17
ACEGUI_FONTSTRING		= 18
ACEGUI_TEXTURE			= 19
ACEGUI_BACKDROP			= 20

ACEGUI_DRIVER_MAP	= {
	[ACEGUI_GENERIC]		= AceGUIElement,
	[ACEGUI_FRAME]			= AceGUIFrame,
	[ACEGUI_BORDER_FRAME]	= AceGUIBorderFrame,
	[ACEGUI_BASIC_DIALOG]	= AceGUIBasicDialog,
	[ACEGUI_DIALOG]			= AceGUIDialog,
	[ACEGUI_OPTIONSBOX]		= AceGUIOptionsBox,
	[ACEGUI_BUTTON]			= AceGUIButton,
	[ACEGUI_CHECK_BUTTON]	= AceGUICheckButton,
	[ACEGUI_DROPDOWN]		= AceGUIDropDown,
	[ACEGUI_LISTBOX]		= AceGUIListBox,
	[ACEGUI_EDITBOX]		= AceGUIEditBox,
	[ACEGUI_INPUTBOX]		= AceGUIInputBox,
	[ACEGUI_CHECKBOX]		= AceGUICheckBox,
	[ACEGUI_SCROLL_EDITBOX]	= AceGUIScrollEditBox,
	[ACEGUI_SCROLL_FRAME]	= AceGUIScrollFrame,
	[ACEGUI_SCROLLBAR]		= AceGUIElement,
	[ACEGUI_SCROLL_CHILD]	= AceGUIElement,
	[ACEGUI_SLIDER]			= AceGUIElement,
	[ACEGUI_FONTSTRING]		= AceGUIElement,
	[ACEGUI_TEXTURE]		= AceGUIElement,
	[ACEGUI_BACKDROP]		= AceGUIElement
}

ACEGUI_REGISTRY	= {dropDowns={}}


--[[--------------------------------------------------------------------------------
  Definition
-----------------------------------------------------------------------------------]]

AceGUI = AceModuleClass:new()


--[[--------------------------------------------------------------------------------
  Initialization
-----------------------------------------------------------------------------------]]

function AceGUI:Initialize(app, def)
	if( self.initialized ) then return end

	self.app = app
	if( def.type ) then
		self.topUnit = ACEGUI_DRIVER_MAP[def.type]:Initialize(nil, def.name, def, nil, self)
	else
		self.topUnit = AceGUIContainer:Initialize(def, self)
	end

	self._lookup = getmetatable(self)
	if( self._lookup and self.topUnit ) then
		setmetatable(self, {__index =
			function(self, key)
				return self._lookup[key] or
					(type(self.topUnit[key]) == "function")
						and function(self, ...)
								self.topUnit[key](self.topUnit, unpack(arg))
							end
						or	self.topUnit[key]
			end
		})
	end

	if( def.OnLoad ) then self:CallHandler("OnLoad") end
	self.initialized = TRUE
end

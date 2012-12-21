--[[ MyMinimapButton v0.4

	This is an embedded library intended to be used by other mods.
	It's not a standalone mod.

	See MyMinimapButton_API_readme.txt for more info.
]]

local version = 0.4

if not MyMinimapButton or MyMinimapButton.Version<version then

  MyMinimapButton = {

	Version = version,		-- for version checking

	-- Dynamically create a button
	--   modName = name of the button (mandatory)
	--   modSettings = table where SavedVariables are stored for the button (optional)
	--   initSettings = table of default settings (optional)
	Create = function(self,modName,modSettings,initSettings)
		if not modName or getglobal(modName.."MinimapButton") then
			return
		end
		initSettings = initSettings or {}
		modSettings = modSettings or {}
		self.Buttons = self.Buttons or {}
		CreateFrame("Button",modName.."MinimapButton",Minimap)
		local frameName = modName.."MinimapButton"
		local frame = getglobal(frameName)
		frame:SetWidth(31)
		frame:SetHeight(31)
		frame:SetFrameStrata("MEDIUM")
		frame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
		frame:CreateTexture(frameName.."Icon","BACKGROUND")
		local icon = getglobal(frameName.."Icon")
		icon:SetTexture(initSettings.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
		icon:SetWidth(20)
		icon:SetHeight(20)
		icon:SetPoint("TOPLEFT",frame,"TOPLEFT",7,-5)
		frame:CreateTexture(frameName.."Overlay","OVERLAY")
		local overlay = getglobal(frameName.."Overlay")
		overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
		overlay:SetWidth(53)
		overlay:SetHeight(53)
		overlay:SetPoint("TOPLEFT",frame,"TOPLEFT")

		frame:RegisterForClicks("LeftButtonUp","RightButtonUp")
		frame:SetScript("OnClick",self.OnClick)

		frame:SetScript("OnMouseDown",self.OnMouseDown)
		frame:SetScript("OnMouseUp",self.OnMouseUp)
		frame:SetScript("OnEnter",self.OnEnter)
		frame:SetScript("OnLeave",self.OnLeave)

		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart",self.OnDragStart)
		frame:SetScript("OnDragStop",self.OnDragStop)

		frame.tooltipTitle = modName
		frame.leftClick = initSettings.left
		frame.rightClick = initSettings.right
		frame.tooltipText = initSettings.tooltip
		
		if (modSettings.drag==nil) then modSettings.drag=initSettings.drag or "CIRCLE" end
		if (modSettings.enabled==nil) then modSettings.enabled =initSettings.enabled or 1 end
		if (modSettings.position==nil) then modSettings.position = initSettings.position or self:GetDefaultPosition() end
		
		frame.modSettings = modSettings

		table.insert(self.Buttons,modName)
		if frame.modSettings.enabled==1 or frame.modSettings.enabled=="ON" then
			self:Enable(modName)
		end
		frame:Show()
	end,

	-- Changes the icon of the button.
	--   value = texture path, ie: "Interface\\AddOn\\MyMod\\MyModIcon"
	SetIcon = function(self,modName,value)
		if value and getglobal(modName.."MinimapButton") then
			getglobal(modName.."MinimapButtonIcon"):SetTexture(value)
		end
	end,

	-- Sets the left-click function.
	--   value = function
	SetLeftClick = function(self,modName,value)
		if value and getglobal(modName.."MinimapButton") then
			getglobal(modName.."MinimapButton").leftClick = value
		end
	end,

	-- Sets the right-click function.
	--  value = function
	SetRightClick = function(self,modName,value)
		if value and getglobal(modName.."MinimapButton") then
			getglobal(modName.."MinimapButton").rightClick = value
		end
	end,

	-- Sets the drag route.
	--   value = "NONE", "CIRCLE", or "SQUARE"
	SetDrag = function(self,modName,value)
		local button = getglobal(modName.."MinimapButton")
		if button and (value=="NONE" or value=="CIRCLE" or value=="SQUARE") then
			button.modSettings.drag = value
			self:Move(modName)
		end
	end,

	-- Sets the tooltip text.
	--   value = string (can include \n)
	SetTooltip = function(self,modName,value)
		local button = getglobal(modName.."MinimapButton")
		if button and value then
			button.tooltipText = value
		end
	end,

	-- Enables the button and shows it.
	Enable = function(self,modName)
		local button = getglobal(modName.."MinimapButton")
		if button then
			button:Show()
			button.modSettings.enabled = 1
			self:Move(modName)
		end
	end,

	-- Disables the button and hides it.
	Disable = function(self,modName)
		local button = getglobal(modName.."MinimapButton")
		if button then
			button:Hide()
			button.modSettings.enabled =false
		end
	end,

	-- Moves the button.
	--  newPosition = degree angle to display the button (optional)
	Move = function(self,modName,newPosition)
		local button = getglobal(modName.."MinimapButton")
		if button and button.modSettings.drag~="NONE" then
			button.modSettings.position = newPosition or button.modSettings.position
			local xpos,ypos
			local angle = button.modSettings.position
			if button.modSettings.drag=="SQUARE" then
				xpos = 110 * cos(angle)
				ypos = 110 * sin(angle)
				xpos = math.max(-82,math.min(xpos,84))
				ypos = math.max(-86,math.min(ypos,82))
			else
				xpos = 80 * cos(angle)
				ypos = 80 * sin(angle)
			end
			button:SetPoint("TOPLEFT","Minimap","TOPLEFT",54-xpos,ypos-54)
		end
	end,

	-- Debug. Use no parameters to list all created buttons.
	Debug = function(self,modName)
		DEFAULT_CHAT_FRAME:AddMessage("MyMinimapButton version = "..self.Version)
		if modName then
			DEFAULT_CHAT_FRAME:AddMessage("Button: \""..modName.."\"")
			local button = getglobal(modName.."MinimapButton")
			if button then
				DEFAULT_CHAT_FRAME:AddMessage("positon = "..tostring(button.modSettings.position))
				DEFAULT_CHAT_FRAME:AddMessage("enabled = "..tostring(button.modSettings.enabled))
				DEFAULT_CHAT_FRAME:AddMessage("drag = "..tostring(button.modSettings.drag))
			else
				DEFAULT_CHAT_FRAME:AddMessage("button not defined")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Buttons created:")
			for i=1,table.getn(self.Buttons) do
				DEFAULT_CHAT_FRAME:AddMessage("\""..self.Buttons[i].."\"")
			end
		end
	end,

	--[[ Internal functions: do not call anything below here ]]

	-- this gets a new default position by increments of 20 degrees
	GetDefaultPosition = function(self)
		local position,found = 0,1,0

		while found do
			found = nil
			for i=1,table.getn(self.Buttons) do
				if getglobal(self.Buttons[i].."MinimapButton").modSettings.position==position then
					position = position + 20
					found = 1
				end
			end
			found = (position>340) and 1 or found -- leave if we've done full circle
		end
		return position
	end,

	OnMouseDown = function()
		getglobal(this:GetName().."Icon"):SetTexCoord(.1,.9,.1,.9)
	end,

	OnMouseUp = function()
		getglobal(this:GetName().."Icon"):SetTexCoord(0,1,0,1)
	end,

	OnEnter = function()
		local tooltip=getglobal(this.tooltipTitle.."MinimapButton")
		--GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
		GameTooltip:SetOwner(tooltip, "ANCHOR_LEFT");
		GameTooltip:AddLine(this.tooltipTitle)
		GameTooltip:AddLine(this.tooltipText,.8,.8,.8,1)
		GameTooltip:Show()
	end,

	OnLeave = function()
		GameTooltip:Hide()
	end,

	OnDragStart = function()
		MyMinimapButton:OnMouseDown()
		this:LockHighlight()
		this:SetScript("OnUpdate",MyMinimapButton.OnUpdate)
	end,

	OnDragStop = function()
		this:SetScript("OnUpdate",nil)
		this:UnlockHighlight()
		MyMinimapButton:OnMouseUp()
	end,

	OnUpdate = function()
		local xpos,ypos = GetCursorPosition()
		local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
		xpos = xmin-xpos/Minimap:GetEffectiveScale()+70
		ypos = ypos/Minimap:GetEffectiveScale()-ymin-70
		this.modSettings.position = math.deg(math.atan2(ypos,xpos))
		local modName = string.gsub(this:GetName() or "","MinimapButton$","")
		MyMinimapButton:Move(modName)
	end,

	OnClick = function()
		if arg1=="LeftButton" and this.leftClick then
			this.leftClick()
		elseif arg1=="RightButton" and this.rightClick then
			this.rightClick()
		end
	end

  }

end

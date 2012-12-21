--[[
Name: FuBarPlugin-2.0
Revision: $Rev: 9336 $
Author: Cameron Kenneth Knight (ckknight@gmail.com)
Website: http://wiki.wowace.com/index.php/FuBarPlugin-2.0
Documentation: http://wiki.wowace.com/index.php/FuBarPlugin-2.0
SVN: svn://svn.wowace.com/root/branches/FuBar/FuBarPlugin-2.0/FuBarPlugin-2.0/
Description: Plugin for FuBar.
Dependencies: AceLibrary, AceOO-2.0, AceEvent-2.0, Tablet-2.0, Dewdrop-2.0
]]

local MAJOR_VERSION = "FuBarPlugin-2.0"
local MINIMAPCONTAINER_MAJOR_VERSION = "FuBarPlugin-MinimapContainer-2.0"
local MINOR_VERSION = "$Revision: 9336 $"

-- This ensures the code is only executed if the libary doesn't already exist, or is a newer version
if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("AceOO-2.0") then error(MAJOR_VERSION .. " requires AceOO-2.0.") end

local AceEvent = AceLibrary:HasInstance("AceEvent-2.0") and AceLibrary("AceEvent-2.0")
local Tablet = AceLibrary:HasInstance("Tablet-2.0") and AceLibrary("Tablet-2.0")
local Dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")

local epsilon = 1e-5
local _G = getfenv(0)

local FuBarPlugin = AceLibrary("AceOO-2.0").Mixin {
													"GetTitle",
													"GetName",
													"GetCategory",
													"SetFontSize",
													"GetFrame",
													"Show",
													"Hide",
													"GetPanel",
													"IsTextColored",
													"ToggleTextColored",
													"IsMinimapAttached",
													"ToggleMinimapAttached",
													"Update",
													"UpdateDisplay",
													"UpdateData",
													"UpdateText",
													"UpdateTooltip",
													"SetIcon",
													"GetIcon",
													"CheckWidth",
													"SetText",
													"GetText",
													"IsIconShown",
													"ToggleIconShown",
													"ShowIcon",
													"HideIcon",
													"IsTextShown",
													"ToggleTextShown",
													"ShowText",
													"HideText",
													"IsTooltipDetached",
													"ToggleTooltipDetached",
													"DetachTooltip",
													"ReattachTooltip",
													"GetDefaultPosition",
													"SetPanel",
													"IsLoadOnDemand",
													"IsDisabled",
													"CreateBasicPluginFrame",
													"CreatePluginChildFrame",
													"OpenMenu",
													"AddImpliedMenuOptions",
												  }

local good = nil
local function CheckFuBar()
	if not good then
		good = FuBar and tonumber(string.sub(FuBar.version, 1, 3)) and tonumber(string.sub(FuBar.version, 1, 3)) >= 2 and true
	end
	return good
end

function FuBarPlugin:GetTitle()
	local name = self.title or self.name
	FuBarPlugin:assert(name, "You must provide self.title or self.name")
	local _,_,title = string.find(name, "FuBar %- (.+)")
	if not title then
		title = name
	end
	return (string.gsub(string.gsub(title, "|c%x%x%x%x%x%x%x%x", ""), "|r", ""))
end

function FuBarPlugin:GetName()
	return self.name
end

function FuBarPlugin:GetCategory()
	return self.category or "Other"
end

function FuBarPlugin:GetFrame()
	return self.frame
end

function FuBarPlugin:GetPanel()
	return self.panel
end

function FuBarPlugin:IsTextColored()
	return not self.db or not self.db.profile or not self.db.profile.uncolored
end

function FuBarPlugin:ToggleTextColored()
	FuBarPlugin:assert(self.db, "Cannot change text color if self.db is not available. (" .. self:GetTitle() .. ")")
	self.db.profile.uncolored = not self.db.profile.uncolored or nil
	self:UpdateText()
end

function FuBarPlugin:ToggleMinimapAttached()
	if CheckFuBar() and not self.cannotAttachToMinimap then
		local value = self:IsMinimapAttached()
		if value then
			self.panel:RemovePlugin(self)
			FuBar:GetPanel(1):AddPlugin(self, nil, self.defaultPosition)
		else
			self.panel:RemovePlugin(self)
			AceLibrary(MINIMAPCONTAINER_MAJOR_VERSION):AddPlugin(self)
		end
	end
	Dewdrop:Close()
end

function FuBarPlugin:IsMinimapAttached()
	if not CheckFuBar() then
		return true
	end
	return self.panel == AceLibrary(MINIMAPCONTAINER_MAJOR_VERSION)
end

function FuBarPlugin:Update()
	self:UpdateData()
	self:UpdateText()
	self:UpdateTooltip()
end

function FuBarPlugin:UpdateDisplay()
	self:UpdateText()
	self:UpdateTooltip()
end

function FuBarPlugin:UpdateData()
	if type(self.OnDataUpdate) == "function" then
		if not self:IsDisabled() then
			self:OnDataUpdate()
		end
	end
end

function FuBarPlugin:UpdateText()
	if type(self.OnTextUpdate) == "function" then
		if not self:IsDisabled() then
			self:OnTextUpdate()
		end
	elseif self:IsTextShown() then
		self:SetText(self:GetTitle())
	end
end

function FuBarPlugin:RegisterTablet()
	if not Tablet:IsRegistered(self.frame) then
		if self.db and self.db.profile and not self.db.profile.detachedTooltip then
			self.db.profile.detachedTooltip = {}
		end
		Tablet:Register(self.frame,
			'children', function()
				Tablet:SetTitle(self:GetTitle())
				if type(self.OnTooltipUpdate) == "function" then
					if not self:IsDisabled() then
						self:OnTooltipUpdate()
					end
				end
			end,
			'clickable', self.clickableTooltip,
			'data', CheckFuBar() and FuBar.db.profile.tooltip or self.db and self.db.profile.detachedTooltip or {},
			'detachedData', self.db and self.db.profile.detachedTooltip or {},
			'point', function(frame)
				if frame:GetTop() > GetScreenHeight() / 2 then
					local x = frame:GetCenter()
					if x < GetScreenWidth() / 3 then
						return "TOPLEFT", "BOTTOMLEFT"
					elseif x < GetScreenWidth() * 2 / 3 then
						return "TOP", "BOTTOM"
					else
						return "TOPRIGHT", "BOTTOMRIGHT"
					end
				else
					local x = frame:GetCenter()
					if x < GetScreenWidth() / 3 then
						return "BOTTOMLEFT", "TOPLEFT"
					elseif x < GetScreenWidth() * 2 / 3 then
						return "BOTTOM", "TOP"
					else
						return "BOTTOMRIGHT", "TOPRIGHT"
					end
				end
			end,
			'menu', self.OnMenuRequest and function(level, value, valueN_1, valueN_2, valueN_3, valueN_4)
				if level == 1 then
					local name = tostring(self)
					if not string.find(name, '^table:') then
						name = string.gsub(name, "|c%x%x%x%x%x%x%x%x(.-)|r", "%1")
						Dewdrop:AddLine(
							'text', name,
							'isTitle', true
						)
					end
				end
				if type(self.OnMenuRequest) == "function" then
					self:OnMenuRequest(level, value, true, valueN_1, valueN_2, valueN_3, valueN_4)
				elseif type(self.OnMenuRequest) == "table" then
					Dewdrop:FeedAceOptionsTable(self.OnMenuRequest)
				end
			end,
			'hideWhenEmpty', self.tooltipHiddenWhenEmpty
		)
	end
end

function FuBarPlugin:UpdateTooltip()
	FuBarPlugin.RegisterTablet(self)
	if self:IsMinimapAttached() and not self:IsTooltipDetached() then
		Tablet:Refresh(self.minimapFrame)
	else
		Tablet:Refresh(self.frame)
	end
end

function FuBarPlugin:OnProfileEnable()
	self:Update()
end

function FuBarPlugin:Show(panelId)
	if self.frame:IsShown() or (self.minimapFrame and self.minimapFrame:IsShown()) then
		return
	end
	if panelId ~= false then
		if self.db then
			self.db.profile.hidden = nil
		end
	end
	if self.IsActive and not self:IsActive() then
		self.panelIdTmp = panelId
		self:ToggleActive()
		self.panelIdTmp = nil
		if self.db then
			self.db.profile.disabled = nil
		end
	elseif not self.db or not self.db.profile.hidden then
		if panelId == 0 or not CheckFuBar() then
			AceLibrary(MINIMAPCONTAINER_MAJOR_VERSION):AddPlugin(self)
		else
			FuBar:ShowPlugin(self, panelId or self.panelIdTmp)
		end
		if not self:IsTextShown() then
			self.textFrame:SetText("")
			self.textFrame:SetWidth(epsilon)
			self.textFrame:Hide()
		end
		if not self:IsIconShown() then
			self.iconFrame:SetWidth(epsilon)
			self.iconFrame:Hide()
		end
		self:Update()
	end
end

function FuBarPlugin:Hide()
	if not self.frame:IsShown() and (not self.minimapFrame or not self.minimapFrame:IsShown()) then
		return
	end
	if self.hideWithoutStandby then
		if self.db then
			self.db.profile.hidden = true
		end
	end
	if not self.hideWithoutStandby then
		if self.db and not self.overrideTooltip and not self.cannotDetachTooltip and self:IsTooltipDetached() and self.db.profile.detachedTooltip and self.db.profile.detachedTooltip.detached then
			self:ReattachTooltip()
			self.db.profile.detachedTooltip.detached = true
		end
		if self.IsActive and self:IsActive() and self.ToggleActive and (not CheckFuBar() or not FuBar:IsChangingProfile()) then
			self:ToggleActive()
		end
	end
	if self.panel then
		self.panel:RemovePlugin(self)
	end
	self.frame:Hide()
	if self.minimapFrame then
		self.minimapFrame:Hide()
	end

	if Dewdrop:IsOpen(self.frame) or (self.minimapFrame and Dewdrop:IsOpen(self.minimapFrame)) then
		Dewdrop:Close()
	end
end

function FuBarPlugin:SetIcon(path)
	if not path then
		return
	end
	FuBarPlugin:argCheck(path, 2, "string", "boolean")
	FuBarPlugin:assert(self.hasIcon, "Cannot set icon unless self.hasIcon is set. (" .. self:GetTitle() .. ")")
	if not self.iconFrame then
		return
	end
	if type(path) ~= "string" then
		path = format("Interface\\AddOns\\%s\\icon", self.folderName)
	elseif not string.find(path, '^Interface[\\/]') then
		path = format("Interface\\AddOns\\%s\\%s", self.folderName, path)
	end
	if string.sub(path, 1, 16) == "Interface\\Icons\\" then
		self.iconFrame:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	else
		self.iconFrame:SetTexCoord(0, 1, 0, 1)
	end
	self.iconFrame:SetTexture(path)
	if self.minimapIcon then
		if string.sub(path, 1, 16) == "Interface\\Icons\\" then
			self.minimapIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		else
			self.minimapIcon:SetTexCoord(0, 1, 0, 1)
		end
		self.minimapIcon:SetTexture(path)
	end
end

function FuBarPlugin:GetIcon()
	if self.hasIcon then
		return self.iconFrame:GetTexture()
	end
end

function FuBarPlugin:CheckWidth(force)
	FuBarPlugin:argCheck(force, 2, "boolean", "nil")
	if (self.iconFrame and self.iconFrame:IsShown()) or (self.textFrame and self.textFrame:IsShown()) then
		if (self.db and self.db.profile and not self:IsIconShown()) or not self.hasIcon then
			self.iconFrame:SetWidth(epsilon)
		end
		local width
		if not self.hasNoText then
			self.textFrame:SetHeight(0)
			self.textFrame:SetWidth(500)
			width = self.textFrame:GetStringWidth() + 1
			self.textFrame:SetWidth(width)
			self.textFrame:SetHeight(self.textFrame:GetHeight())
		end
		if self.hasNoText or not self.textFrame:IsShown() then
			self.frame:SetWidth(self.iconFrame:GetWidth())
			if self.panel and self.panel:GetPluginSide(self) == "CENTER" then
				self.panel:UpdateCenteredPosition()
			end
		elseif force or not self.textWidth or self.textWidth < width or self.textWidth - 8 > width then
			self.textWidth = width
			self.textFrame:SetWidth(width)
			if self.iconFrame and self.iconFrame:IsShown() then
				self.frame:SetWidth(width + self.iconFrame:GetWidth())
			else
				self.frame:SetWidth(width)
			end
			if self.panel and self.panel:GetPluginSide(self) == "CENTER" then
				self.panel:UpdateCenteredPosition()
			end
		end
	end
end

function FuBarPlugin:SetText(text)
	if not self.textFrame then
		return
	end
	FuBarPlugin:assert(not self.hasNoText, "Cannot set text if self.hasNoText has been set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:argCheck(text, 2, "string", "number")
	if text == "" then
		if self.hasIcon then
			self:ShowIcon()
		else
			text = self:GetTitle()
		end
	end
	if not self:IsTextColored() then
		text = string.gsub(text, "|c%x%x%x%x%x%x%x%x(.-)|r", "%1")
	end
	self.textFrame:SetText(text)
	self:CheckWidth()
end

function FuBarPlugin:GetText()
	FuBarPlugin:assert(self.textFrame, "Cannot get text without a self.textFrame (" .. self:GetTitle() .. ")")
	if not self.hasNoText then
		return self.textFrame:GetText() or ""
	end
end

function FuBarPlugin:IsIconShown()
	if not self.hasIcon then
		return false
	elseif self.hasNoText then
		return true
	elseif not self.db then
		return true
	elseif self.db.profile.showIcon == nil then
		return true
	else
		return (self.db.profile.showIcon == 1 or self.db.profile.showIcon == true) and true or false
	end
end

function FuBarPlugin:ToggleIconShown()
	FuBarPlugin:assert(self.iconFrame, "Cannot toggle icon without a self.iconFrame (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.hasIcon, "Cannot show icon unless self.hasIcon is set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(not self.hasNoText, "Cannot hide icon if self.hasNoText is set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.textFrame, "Cannot hide icon if self.textFrame is not set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.iconFrame, "Cannot hide icon if self.iconFrame is not set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.db, "Cannot hide icon if self.db is not available. (" .. self:GetTitle() .. ")")
	local value = not self:IsIconShown()
	self.db.profile.showIcon = value
	if value then
		if not self:IsTextShown() and self.textFrame:IsShown() and self.textFrame:GetText() == self:GetTitle() then
			self.textFrame:Hide()
			self.textFrame:SetText("")
		end
		self.iconFrame:Show()
		self.iconFrame:SetWidth(self.iconFrame:GetHeight())
	else
		if not self.textFrame:IsShown() or not self.textFrame:GetText() then
			self.textFrame:Show()
			self.textFrame:SetText(self:GetTitle())
		end
		self.iconFrame:Hide()
		self.iconFrame:SetWidth(epsilon)
	end
	self:CheckWidth(true)
	return value
end

function FuBarPlugin:ShowIcon()
	if not self:IsIconShown() then
		self:ToggleIconShown()
	end
end

function FuBarPlugin:HideIcon()
	if self:IsIconShown() then
		self:ToggleIconShown()
	end
end

function FuBarPlugin:IsTextShown()
	if self.hasNoText then
		return false
	elseif not self.hasIcon then
		return true
	elseif not self.db then
		return true
	elseif self.db.profile.showText == nil then
		return true
	else
		return (self.db.profile.showText == 1 or self.db.profile.showText == true) and true or false
	end
end

function FuBarPlugin:ToggleTextShown()
	FuBarPlugin:assert(not self.cannotHideText, "Cannot hide text unless self.cannotHideText is unset. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.hasIcon, "Cannot show text unless self.hasIcon is set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(not self.hasNoText, "Cannot hide text if self.hasNoText is set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.textFrame, "Cannot hide text if self.textFrame is not set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.iconFrame, "Cannot hide text if self.iconFrame is not set. (" .. self:GetTitle() .. ")")
	FuBarPlugin:assert(self.db, "Cannot hide text if self.db is not available. (" .. self:GetTitle() .. ")")
	local value = not self:IsTextShown()
	self.db.profile.showText = value
	if value then
		self.textFrame:Show()
		self:UpdateText()
	else
		self.textFrame:SetText("")
		self.textFrame:SetWidth(epsilon)
		self.textFrame:Hide()
		if not self:IsIconShown() then
			DropDownList1:Hide()
		end
		self:ShowIcon()
	end
	self:CheckWidth(true)
	return value
end

function FuBarPlugin:ShowText()
	if not self:IsTextShown() then
		self:ToggleTextShown()
	end
end

function FuBarPlugin:HideText()
	if self:IsTextShown() then
		self:ToggleTextShown()
	end
end

function FuBarPlugin:IsTooltipDetached()
	FuBarPlugin.RegisterTablet(self)
	return not Tablet:IsAttached(self.frame)
end

function FuBarPlugin:ToggleTooltipDetached()
	FuBarPlugin.RegisterTablet(self)
	if self:IsTooltipDetached() then
		Tablet:Attach(self.frame)
	else
		Tablet:Detach(self.frame)
	end
end

function FuBarPlugin:DetachTooltip()
	FuBarPlugin.RegisterTablet(self)
	Tablet:Detach(self.frame)
end

function FuBarPlugin:ReattachTooltip()
	FuBarPlugin.RegisterTablet(self)
	Tablet:Attach(self.frame)
end

function FuBarPlugin:GetDefaultPosition()
	return self.defaultPosition or "LEFT"
end

local function IsCorrectPanel(panel)
	if type(panel) ~= "table" then
		return false
	elseif type(panel.AddPlugin) ~= "function" then
		return false
	elseif type(panel.RemovePlugin) ~= "function" then
		return false
	elseif type(panel.GetNumPlugins) ~= "function" then
		return false
	elseif type(panel:GetNumPlugins()) ~= "number" then
		return false
	elseif type(panel.GetPlugin) ~= "function" then
		return false
	elseif type(panel.HasPlugin) ~= "function" then
		return false
	elseif type(panel.GetPluginSide) ~= "function" then
		return false
	end
	return true
end

function FuBarPlugin:SetPanel(panel)
	if panel then
		FuBarPlugin:assert(IsCorrectPanel(panel), "Bad argument #2 to `SetPanel'. Panel does not have the correct API.")
	end
	self.panel = panel
end

function FuBarPlugin:SetFontSize(size)
	FuBarPlugin:assert(not self.userDefinedFrame, "You must provide a SetFontSize(size) method if you provide your own frame.")
	if self.hasIcon then
		FuBarPlugin:assert(self.iconFrame, (self.name and self.name .. ": " or "") .. "No iconFrame found")
		self.iconFrame:SetWidth(size + 3)
		self.iconFrame:SetHeight(size + 3)
	end
	if not self.hasNoText then
		FuBarPlugin:assert(self.textFrame, (self.name and self.name .. ": " or "") .. "No textFrame found")
		local font, _, flags = self.textFrame:GetFont()
		self.textFrame:SetFont(font, size, flags)
	end
	self:CheckWidth()
end

function FuBarPlugin:IsLoadOnDemand()
	return IsAddOnLoadOnDemand(self.folderName)
end

function FuBarPlugin:IsDisabled()
	return self.IsActive and not self:IsActive() or false
end

function FuBarPlugin:OnInstanceInit(target)
	if not AceEvent then
		self:error(MAJOR_VERSION .. " requires AceEvent-2.0.")
	elseif not Tablet then
		self:error(MAJOR_VERSION .. " requires Tablet-2.0.")
	elseif not Dewdrop then
		self:error(MAJOR_VERSION .. " requires Dewdrop-2.0.")
	end
	self.registry[target] = true
	
	local _,_,folderName = string.find(debugstack(6, 1, 0), "\\AddOns\\(.*)\\")
	target.folderName = folderName
	self.folderNames[target] = folderName
end

function FuBarPlugin:CreateBasicPluginFrame(name)
	local frame = CreateFrame("Button", name, UIParent)
	frame:SetFrameStrata("HIGH")
	frame:EnableMouse(true)
	frame:EnableMouseWheel(true)
	frame:SetMovable(true)
	frame:SetWidth(150)
	frame:SetHeight(24)
	frame:SetPoint("CENTER", UIParent, "CENTER")

	frame:SetScript("OnClick", function()
		if type(self.OnClick) == "function" then
			self:OnClick(arg1)
		end
	end)
	frame:SetScript("OnDoubleClick", function()
		if type(self.OnDoubleClick) == "function" then
			self:OnDoubleClick(arg1)
		end
	end)
	frame:SetScript("OnMouseDown", function()
		if arg1 == "RightButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
			self:OpenMenu()
			return
		else
			HideDropDownMenu(1)
			if type(self.OnMouseDown) == "function" then
				self:OnMouseDown(arg1)
			end
		end
	end)
	frame:SetScript("OnMouseUp", function()
		if type(self.OnMouseUp) == "function" then
			self:OnMouseUp(arg1)
		end
	end)
	frame:SetScript("OnReceiveDrag", function()
		if type(self.OnReceiveDrag) == "function" then
			self:OnReceiveDrag()
		end
	end)
	return frame
end

function FuBarPlugin:CreatePluginChildFrame(frameType, name, parent)
	FuBarPlugin:assert(self.frame, "You must have self.frame declared in order to add child frames")
	FuBarPlugin:argCheck(frameType, 1, "string")
	local child = CreateFrame(frameType, name, parent)
	if parent then
		child:SetFrameLevel(parent:GetFrameLevel() + 2)
	end
	child:SetScript("OnEnter", function()
		if self.frame:GetScript("OnEnter") then
			self.frame:GetScript("OnEnter")()
		end
	end)
	child:SetScript("OnLeave", function()
		if self.frame:GetScript("OnLeave") then
			self.frame:GetScript("OnLeave")()
		end
	end)
	if child:HasScript("OnClick") then
		child:SetScript("OnClick", function()
			if self.frame:HasScript("OnClick") and self.frame:GetScript("OnClick") then
				self.frame:GetScript("OnClick")()
			end
		end)
	end
	if child:HasScript("OnDoubleClick") then
		child:SetScript("OnDoubleClick", function()
			if self.frame:HasScript("OnDoubleClick") and self.frame:GetScript("OnDoubleClick") then
				self.frame:GetScript("OnDoubleClick")()
			end
		end)
	end
	child:SetScript("OnMouseDown", function()
		if self.frame:GetScript("OnMouseDown") then
			self.frame:GetScript("OnMouseDown")()
		end
	end)
	child:SetScript("OnMouseUp", function()
		if self.frame:GetScript("OnMouseUp") then
			self.frame:GetScript("OnMouseUp")()
		end
	end)
	child:SetScript("OnReceiveDrag", function()
		if self.frame:GetScript("OnReceiveDrag") then
			self.frame:GetScript("OnReceiveDrag")()
		end
	end)
	return child
end

function FuBarPlugin:OpenMenu(frame)
	if not frame then
		frame = self:GetFrame()
	end
	if not frame or not self:GetFrame() or Dewdrop:IsOpen(frame) then
		Dewdrop:Close()
		return
	end
	Tablet:Close()

	if not Dewdrop:IsRegistered(self:GetFrame()) then
		if type(self.OnMenuRequest) == "table" and (not self.OnMenuRequest.handler or self.OnMenuRequest.handler == self) and self.OnMenuRequest.type == "group" then
			Dewdrop:InjectAceOptionsTable(self, self.OnMenuRequest)
			if self.OnMenuRequest.args and CheckFuBar() and not self.independentProfile then
				self.OnMenuRequest.args.profile = nil
			end
		end
		Dewdrop:Register(self:GetFrame(),
			'children', type(self.OnMenuRequest) == "table" and self.OnMenuRequest or function(level, value, valueN_1, valueN_2, valueN_3, valueN_4)
				if level == 1 then
					Dewdrop:AddLine(
						'text', self:GetTitle(),
						'isTitle', true
					)
				end
				
				if level == 1 then
					if self.OnMenuRequest then
						self:OnMenuRequest(level, value, false, valueN_1, valueN_2, valueN_3, valueN_4)
					end

					if not self.overrideMenu then
						if self.MenuSettings then
							Dewdrop:AddLine()
						end
						self:AddImpliedMenuOptions()
					end
				else
					if not self.overrideMenu and self:AddImpliedMenuOptions() then
					else
						if self.OnMenuRequest then
							self:OnMenuRequest(level, value, false, valueN_1, valueN_2, valueN_3, valueN_4)
						end
					end
				end
				if level == 1 then
					Dewdrop:AddLine(
						'text', CLOSE,
						'func', Dewdrop.Close,
						'arg1', Dewdrop
					)
				end
			end,
			'point', function(frame)
				local x, y = frame:GetCenter()
				local leftRight
				if x < GetScreenWidth() / 2 then
					leftRight = "LEFT"
				else
					leftRight = "RIGHT"
				end
				if y < GetScreenHeight() / 2 then
					return "BOTTOM" .. leftRight, "TOP" .. leftRight
				else
					return "TOP" .. leftRight, "BOTTOM" .. leftRight
				end
			end,
			'dontHook', true
		)
	end
	if frame == self:GetFrame() then
		Dewdrop:Open(self:GetFrame())
	else
		Dewdrop:Open(frame, self:GetFrame())
	end
end

local impliedMenuOptions
function FuBarPlugin:AddImpliedMenuOptions(level)
	FuBarPlugin:argCheck(level, 2, "number", "nil")
	if not impliedMenuOptions then
		impliedMenuOptions = {}
	end
	if not impliedMenuOptions[self] then
		impliedMenuOptions[self] = { type = 'group', args = {} }
		Dewdrop:InjectAceOptionsTable(self, impliedMenuOptions[self])
		if impliedMenuOptions[self].args and CheckFuBar() and not self.independentProfile then
			impliedMenuOptions[self].args.profile = nil
		end
	end
	return Dewdrop:FeedAceOptionsTable(impliedMenuOptions[self], level and level - 1)
end

function FuBarPlugin.OnEmbedInitialize(FuBarPlugin, self)
	if not self.frame then
		local name = "FuBarPlugin" .. self:GetTitle() .. "Frame"
		local frame = _G[name]
		if not frame or not _G[self.frame:GetName() .. "Text"] or not _G[self.frame:GetName() .. "Icon"] then
			frame = self:CreateBasicPluginFrame(name)

			local icon = frame:CreateTexture(name .. "Icon", "ARTWORK")
			icon:SetWidth(16)
			icon:SetHeight(16)
			icon:SetPoint("LEFT", frame, "LEFT")

			local text = frame:CreateFontString(name .. "Text", "ARTWORK")
			text:SetWidth(134)
			text:SetHeight(24)
			text:SetPoint("LEFT", icon, "RIGHT", 0, 1)
			text:SetFontObject(GameFontNormal)
		end
		self.frame = frame
		self.textFrame = _G[self.frame:GetName() .. "Text"]
		self.iconFrame = _G[self.frame:GetName() .. "Icon"]
	else
		self.userDefinedFrame = true
	end

	self.frame.plugin = self
	self.frame:SetParent(UIParent)
	self.frame:SetPoint("RIGHT", UIParent, "LEFT", -5, 0)
	self.frame:Hide()

	if self.hasIcon then
		self:SetIcon(self.hasIcon)
	end

	if CheckFuBar() then
		FuBar:RegisterPlugin(self)
	end
end

local CheckShow = function(self, panelId)
	if not self.frame:IsShown() and (not self.minimapFrame or not self.minimapFrame:IsShown()) then
		self:Show(panelId)
		Dewdrop:Refresh(2)
	end
end

local recheckPlugins
function FuBarPlugin.OnEmbedEnable(FuBarPlugin, self)
	if self:IsIconShown() then
		self.iconFrame:Show()
	else
		self.iconFrame:Hide()
	end
	self:CheckWidth(true)

	if not self.hideWithoutStandby or not self.db.profile.hidden then
		if FuBarPlugin.enabledPlugins[self] then
			CheckShow(self, self.panelIdTmp)
		else
			FuBarPlugin:ScheduleEvent(CheckShow, 0, self, self.panelIdTmp)
		end
	end
	FuBarPlugin.enabledPlugins[self] = true

	if not self.overrideTooltip and not self.cannotDetachTooltip and self.db and self.db.profile.detachedTooltip and self.db.profile.detachedTooltip.detached then
		FuBarPlugin:ScheduleEvent(self.DetachTooltip, 0, self)
	end
	
	if self:IsLoadOnDemand() and CheckFuBar() then
		if not FuBar.db.profile.loadOnDemand then
			FuBar.db.profile.loadOnDemand = {}
		end
		if not FuBar.db.profile.loadOnDemand[self.folderName] then
			FuBar.db.profile.loadOnDemand[self.folderName] = {}
		end
		FuBar.db.profile.loadOnDemand[self.folderName].disabled = nil
	end
	
	if CheckFuBar() and AceLibrary:HasInstance("AceConsole-2.0") then
		if not recheckPlugins then
			local AceConsole = AceLibrary("AceConsole-2.0")
			local AceOO = AceLibrary("AceOO-2.0")
			function recheckPlugins()
				for k,v in pairs(AceConsole.registry) do
					if type(v) == "table" and v.args and AceOO.inherits(v.handler, FuBarPlugin) and not v.independentProfile then
						v.args.profile = nil
					end
				end
			end
		end
		FuBarPlugin:ScheduleEvent(recheckPlugins, 0)
	end
end

function FuBarPlugin.OnEmbedDisable(FuBarPlugin, self)
	self:Hide()
	
	if self:IsLoadOnDemand() and CheckFuBar() then
		if not FuBar.db.profile.loadOnDemand then
			FuBar.db.profile.loadOnDemand = {}
		end
		if not FuBar.db.profile.loadOnDemand[self.folderName] then
			FuBar.db.profile.loadOnDemand[self.folderName] = {}
		end
		FuBar.db.profile.loadOnDemand[self.folderName].disabled = true
	end
end

function FuBarPlugin.OnEmbedProfileEnable(FuBarPlugin, self)
	self:Update()
	if self.db and self.db.profile then
		if not self.db.profile.detachedTooltip then
			self.db.profile.detachedTooltip = {}
		end
		if Tablet.registry[self.frame] then
			Tablet:UpdateDetachedData(self.frame, self.db.profile.detachedTooltip)
		else
			FuBarPlugin.RegisterTablet(self)
		end
	end
end

function FuBarPlugin.GetAceOptionsDataTable(FuBarPlugin, self)
	return {
		icon = {
			type = "toggle",
			name = "Show icon",
			desc = "Show icon",
			set = "ToggleIconShown",
			get = "IsIconShown",
			hidden = function()
				return not self.hasIcon or self.hasNoText or self:IsMinimapAttached() or not self.db
			end,
			order = -13.7,
			handler = self,
		},
		text = {
			type = "toggle",
			name = "Show text",
			desc = "Show text",
			set = "ToggleTextShown",
			get = "IsTextShown",
			hidden = function()
				return self.cannotHideText or not self.hasIcon or self.hasNoText or self:IsMinimapAttached() or not self.db
			end,
			order = -13.6,
			handler = self,
		},
		colorText = {
			type = "toggle",
			name = "Show colored text",
			desc = "Show colored text",
			set = "ToggleTextColored",
			get = "IsTextColored",
			hidden = function()
				return self.userDefinedFrame or self.hasNoText or self.hasNoColor or self:IsMinimapAttached() or not self.db
			end,
			order = -13.5,
			handler = self,
		},
		detachTooltip = {
			type = "toggle",
			name = "Detach tooltip",
			desc = "Detach tooltip",
			get = "IsTooltipDetached",
			set = "ToggleTooltipDetached",
			hidden = function()
				return self.overrideTooltip or self.cannotDetachTooltip
			end,
			order = -13.4,
			handler = self,
		},
		lockTooltip = {
			type = "toggle",
			name = "Lock tooltip",
			desc = "Lock tooltip",
			get = function()
				return Tablet:IsLocked(self.frame)
			end,
			set = function()
				return Tablet:ToggleLocked(self.frame)
			end,
			disabled = function()
				return not self:IsTooltipDetached()
			end,
			hidden = function()
				return self.overrideTooltip or self.cannotDetachTooltip
			end,
			order = -13.3,
			handler = self,
		},
		position = {
			type = "text",
			name = "Position",
			desc = "Position",
			validate = {
				LEFT = "Left",
				CENTER = "Center",
				RIGHT = "Right"
			},
			get = function()
				return self.panel:GetPluginSide(self)
			end,
			set = function(value)
				self.panel:SetPluginSide(self, value)
			end,
			hidden = function()
				return self:IsMinimapAttached() or self:IsDisabled() or not self.panel
			end,
			order = -13.2,
			handler = self,
		},
		minimapAttach = {
			type = "toggle",
			name = "Attach to minimap",
			desc = "Attach to minimap",
			get = "IsMinimapAttached",
			set = "ToggleMinimapAttached",
			hidden = function()
				return (self.cannotAttachToMinimap and not self:IsMinimapAttached()) or not CheckFuBar() or self:IsDisabled()
			end,
			order = -13.1,
			handler = self,
		},
		hide = {
			type = "toggle",
			name = "Hidden",
			desc = "Hidden",
			get = function()
				return not self.frame:IsShown() and (not self.minimapFrame or not self.minimapFrame:IsShown())
			end,
			set = function()
				if not self.frame:IsShown() and (not self.minimapFrame or not self.minimapFrame:IsShown()) then
					self:Show()
				else
					self:Hide()
				end
			end,
			hidden = function()
				return not self.hideWithoutStandby or self:IsDisabled()
			end,
			order = -13,
			handler = self,
		},
	}
end

local function activate(self, oldLib, oldDeactivate)
	FuBarPlugin = self

	if oldLib then
		self.registry = oldLib.registry
		self.folderNames = oldLib.folderNames
		self.enabledPlugins = oldLib.enabledPlugins
	end
	
	if not self.registry then
		self.registry = {}
	end
	if not self.folderNames then
		self.folderNames = {}
	end
	if not self.enabledPlugins then
		self.enabledPlugins = {}
	end

	FuBarPlugin.activate(self, oldLib, oldDeactivate)

	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		AceEvent = instance

		AceEvent:embed(self)
	elseif major == "Tablet-2.0" then
		Tablet = instance
	elseif major == "Dewdrop-2.0" then
		Dewdrop = instance
	end
end

AceLibrary:Register(FuBarPlugin, MAJOR_VERSION, MINOR_VERSION, activate, nil, external)

local MinimapContainer = {}

function MinimapContainer:AddPlugin(plugin)
	if CheckFuBar() and FuBar:IsChangingProfile() then
		return
	end
	if plugin.panel ~= nil then
		plugin.panel:RemovePlugin(plugin)
	end
	plugin.panel = self
	if not plugin.minimapFrame then
		local frame = CreateFrame("Button", plugin.frame:GetName() .. "MinimapButton", Minimap)
		plugin.minimapFrame = frame
		AceLibrary(MAJOR_VERSION).RegisterTablet(plugin)
		Tablet:Register(frame, plugin.frame)
		frame.plugin = plugin
		frame:SetWidth(31)
		frame:SetHeight(31)
		frame:SetFrameStrata("BACKGROUND")
		frame:SetFrameLevel(4)
		frame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
		local icon = frame:CreateTexture(frame:GetName() .. "Icon", "BACKGROUND")
		plugin.minimapIcon = icon
		local path = plugin:GetIcon() or (plugin.iconFrame and plugin.iconFrame:GetTexture()) or "Interface\\Icons\\INV_Misc_QuestionMark"
		icon:SetTexture(path)
		if string.sub(path, 1, 16) == "Interface\\Icons\\" then
			icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		else
			icon:SetTexCoord(0, 1, 0, 1)
		end
		icon:SetWidth(20)
		icon:SetHeight(20)
		icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -5)
		local overlay = frame:CreateTexture(frame:GetName() .. "Overlay","OVERLAY")
overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
		overlay:SetWidth(53)
		overlay:SetHeight(53)
		overlay:SetPoint("TOPLEFT",frame,"TOPLEFT")
		frame:EnableMouse(true)
		frame:RegisterForClicks("LeftButtonUp")
		frame.plugin = plugin
		frame:SetScript("OnClick", function()
			if type(plugin.OnClick) == "function" then
				if not this.dragged then
					plugin:OnClick(arg1)
				end
			end
		end)
		frame:SetScript("OnDoubleClick", function()
			if type(plugin.OnDoubleClick) == "function" then
				plugin:OnDoubleClick(arg1)
			end
		end)
		frame:SetScript("OnReceiveDrag", function()
			if type(plugin.OnReceiveDrag) == "function" then
				if not this.dragged then
					plugin:OnReceiveDrag()
				end
			end
		end)
		frame:SetScript("OnMouseDown", function()
			this.dragged = false
			if arg1 == "LeftButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
				HideDropDownMenu(1)
				if type(plugin.OnMouseDown) == "function" then
					plugin:OnMouseDown(arg1)
				end
			elseif arg1 == "RightButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
				plugin:OpenMenu(frame)
			else
				HideDropDownMenu(1)
				if type(plugin.OnMouseDown) == "function" then
					plugin:OnMouseDown(arg1)
				end
			end
			if plugin.OnClick or plugin.OnMouseDown or plugin.OnMouseUp or plugin.OnDoubleClick then
				if string.sub(this.plugin.minimapIcon:GetTexture(), 1, 16) == "Interface\\Icons\\" then
					plugin.minimapIcon:SetTexCoord(0.14, 0.86, 0.14, 0.86)
				else
					plugin.minimapIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				end
			end
		end)
		frame:SetScript("OnMouseUp", function()
			if not this.dragged and type(plugin.OnMouseUp) == "function" then
				plugin:OnMouseUp(arg1)
			end
			if string.sub(this.plugin.minimapIcon:GetTexture(), 1, 16) == "Interface\\Icons\\" then
				plugin.minimapIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
			else
				plugin.minimapIcon:SetTexCoord(0, 1, 0, 1)
			end
		end)
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", self.OnDragStart)
		frame:SetScript("OnDragStop", self.OnDragStop)
	end
	plugin.frame:Hide()
	plugin.minimapFrame:Show()
	self:ReadjustLocation(plugin)
	table.insert(self.plugins, plugin)
	local exists = false
	return true
end

function MinimapContainer:RemovePlugin(index)
	if CheckFuBar() and FuBar:IsChangingProfile() then
		return
	end
	if type(index) == "table" then
		index = self:IndexOfPlugin(index)
		if not index then
			return
		end
	end
	local t = self.plugins
	local plugin = t[index]
	assert(plugin.panel == self, "Plugin has improper panel field")
	plugin:SetPanel(nil)
	table.remove(t, index)
	return true
end

function MinimapContainer:ReadjustLocation(plugin)
	local frame = plugin.minimapFrame
	if plugin.db and plugin.db.profile.minimapPositionWild then
		frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", plugin.db.profile.minimapPositionX, plugin.db.profile.minimapPositionY)
	elseif not plugin.db and plugin.minimapPositionWild then
		frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", plugin.minimapPositionX, plugin.minimapPositionY)
	else
		local position
		if plugin.db then
			position = plugin.db.profile.minimapPosition or plugin.defaultMinimapPosition or math.random(1, 360)
		else
			position = plugin.minimapPosition or plugin.defaultMinimapPosition or math.random(1, 360)
		end
		local angle = math.rad(position or 0)
		local x = math.cos(angle) * 80
		local y = math.sin(angle) * 80
		frame:SetPoint("CENTER", Minimap, "CENTER", x, y)
	end
end

function MinimapContainer:GetPlugin(index)
	return self.plugins[index]
end

function MinimapContainer:GetNumPlugins()
	return table.getn(self.plugins)
end

function MinimapContainer:IndexOfPlugin(plugin)
	for i,p in ipairs(self.plugins) do
		if p == plugin then
			return i, "MINIMAP"
		end
	end
end

function MinimapContainer:HasPlugin(plugin)
	return self:IndexOfPlugin(plugin) ~= nil
end

function MinimapContainer:GetPluginSide(plugin)
	local index = self:IndexOfPlugin(plugin)
	assert(index, "Plugin not in panel")
	return "MINIMAP"
end

function MinimapContainer.OnDragStart()
	this.dragged = true
	this:LockHighlight()
	this:SetScript("OnUpdate", MinimapContainer.OnUpdate)
	if string.sub(this.plugin.minimapIcon:GetTexture(), 1, 16) == "Interface\\Icons\\" then
		this.plugin.minimapIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	else
		this.plugin.minimapIcon:SetTexCoord(0, 1, 0, 1)
	end
end

function MinimapContainer.OnDragStop()
	this:SetScript("OnUpdate", nil)
	this:UnlockHighlight()
end

function MinimapContainer.OnUpdate()
	if not IsAltKeyDown() then
		local mx, my = Minimap:GetCenter()
		local px, py = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		px, py = px / scale, py / scale
		local position = math.deg(math.atan2(py - my, px - mx))
		if position <= 0 then
			position = position + 360
		elseif position > 360 then
			position = position - 360
		end
		if this.plugin.db then
			this.plugin.db.profile.minimapPosition = position
			this.plugin.db.profile.minimapPositionX = nil
			this.plugin.db.profile.minimapPositionY = nil
			this.plugin.db.profile.minimapPositionWild = nil
		else
			this.plugin.minimapPosition = position
			this.plugin.minimapPositionX = nil
			this.plugin.minimapPositionY = nil
			this.plugin.minimapPositionWild = nil
		end
	else
		local px, py = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		px, py = px / scale, py / scale
		if this.plugin.db then
			this.plugin.db.profile.minimapPositionX = px
			this.plugin.db.profile.minimapPositionY = py
			this.plugin.db.profile.minimapPosition = nil
			this.plugin.db.profile.minimapPositionWild = true
		else
			this.plugin.minimapPositionX = px
			this.plugin.minimapPositionY = py
			this.plugin.minimapPosition = nil
			this.plugin.minimapPositionWild = true
		end
	end
	MinimapContainer:ReadjustLocation(this.plugin)
end

local function activate(self, oldLib, oldDeactivate)
	MinimapContainer = self

	if oldLib then
		self.plugins = oldLib.plugins
	end

	if not self.plugins then
		self.plugins = {}
	end

	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

AceLibrary:Register(MinimapContainer, MINIMAPCONTAINER_MAJOR_VERSION, MINOR_VERSION, activate)

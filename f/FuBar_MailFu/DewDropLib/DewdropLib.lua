local MAJOR_VERSION = "1.0"
local MINOR_VERSION = tonumber(string.sub("$Revision: 1868 $", 12, -3))
if DewdropLib and DewdropLib.versions[MAJOR_VERSION] and DewdropLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

-------------IRIEL'S-STUB-CODE--------------
local stub = {};

-- Instance replacement method, replace contents of old with that of new
function stub:ReplaceInstance(old, new)
   for k,v in pairs(old) do old[k]=nil; end
   for k,v in pairs(new) do old[k]=v; end
end

-- Get a new copy of the stub
function stub:NewStub()
  local newStub = {};
  self:ReplaceInstance(newStub, self);
  newStub.lastVersion = '';
  newStub.versions = {};
  return newStub;
end

-- Get instance version
function stub:GetInstance(version)
   if (not version) then version = self.lastVersion; end
   local versionData = self.versions[version];
   if (not versionData) then
      message("Cannot find library instance with version '"
              .. version .. "'");
      return;
   end
   return versionData.instance;
end

-- Register new instance
function stub:Register(newInstance)
   local version,minor = newInstance:GetLibraryVersion();
   self.lastVersion = version;
   local versionData = self.versions[version];
   if (not versionData) then
      -- This one is new!
      versionData = { instance = newInstance,
         minor = minor,
         old = {}
      };
      self.versions[version] = versionData;
      newInstance:LibActivate(self);
      return newInstance;
   end
   if (minor <= versionData.minor) then
      -- This one is already obsolete
      if (newInstance.LibDiscard) then
         newInstance:LibDiscard();
      end
      return versionData.instance;
   end
   -- This is an update
   local oldInstance = versionData.instance;
   local oldList = versionData.old;
   versionData.instance = newInstance;
   versionData.minor = minor;
   local skipCopy = newInstance:LibActivate(self, oldInstance, oldList);
   table.insert(oldList, oldInstance);
   if (not skipCopy) then
      for i, old in ipairs(oldList) do
         self:ReplaceInstance(old, newInstance);
      end
   end
   return newInstance;
end

-- Bind stub to global scope if it's not already there
if (not DewdropLib) then
   DewdropLib = stub:NewStub();
end

-- Nil stub for garbage collection
stub = nil;
-----------END-IRIEL'S-STUB-CODE------------

local function assert(condition, message)
	if not condition then
		local stack = debugstack()
		local first = string.gsub(stack, "\n.*", "")
		local file = string.gsub(first, "^(.*\\.*)%.lua:%d+: .*", "%1")
		if not message then
			local _,_,second = string.find(stack, "\n(.-)\n")
			message = "assertion failed! " .. second
		end
		message = "DewdropLib: " .. message
		local i = 1
		for s in string.gfind(stack, "\n(.-)\n") do
			i = i + 1
			if not string.find(s, file .. "%.lua:%d+:") then
				error(message, i)
				return
			end
		end
		error(message, 2)
		return
	end
	return condition
end

local lib = {}
local ipairs = ipairs
local tinsert = table.insert
local tremove = table.remove
local tgetn = table.getn
local function new(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	local t = {}
	if k1 then t[k1] = v1
	if k2 then t[k2] = v2
	if k3 then t[k3] = v3
	if k4 then t[k4] = v4
	if k5 then t[k5] = v5
	if k6 then t[k6] = v6
	if k7 then t[k7] = v7
	if k8 then t[k8] = v8
	if k9 then t[k9] = v9
	if k10 then t[k10] = v10
	if k11 then t[k11] = v11
	if k12 then t[k12] = v12
	if k13 then t[k13] = v13
	if k14 then t[k14] = v14
	if k15 then t[k15] = v15
	if k16 then t[k16] = v16
	if k17 then t[k17] = v17
	if k18 then t[k18] = v18
	if k19 then t[k19] = v19
	if k20 then t[k20] = v20
	end end end end end end end end end end end end end end end end end end end end
	return t
end
local tmp
do
	local t
	function tmp(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
		for k in pairs(t) do
			t[k] = nil
		end
		if k1 then t[k1] = v1
		if k2 then t[k2] = v2
		if k3 then t[k3] = v3
		if k4 then t[k4] = v4
		if k5 then t[k5] = v5
		if k6 then t[k6] = v6
		if k7 then t[k7] = v7
		if k8 then t[k8] = v8
		if k9 then t[k9] = v9
		if k10 then t[k10] = v10
		if k11 then t[k11] = v11
		if k12 then t[k12] = v12
		if k13 then t[k13] = v13
		if k14 then t[k14] = v14
		if k15 then t[k15] = v15
		if k16 then t[k16] = v16
		if k17 then t[k17] = v17
		if k18 then t[k18] = v18
		if k19 then t[k19] = v19
		if k20 then t[k20] = v20
		end end end end end end end end end end end end end end end end end end end end
		return t
	end
	local x = tmp
	function tmp(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
		t = {}
		tmp = x
		x = nil
		return tmp(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	end
end
local tmp2
do
	local t
	function tmp2(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
		for k in pairs(t) do
			t[k] = nil
		end
		if k1 then t[k1] = v1
		if k2 then t[k2] = v2
		if k3 then t[k3] = v3
		if k4 then t[k4] = v4
		if k5 then t[k5] = v5
		if k6 then t[k6] = v6
		if k7 then t[k7] = v7
		if k8 then t[k8] = v8
		if k9 then t[k9] = v9
		if k10 then t[k10] = v10
		if k11 then t[k11] = v11
		if k12 then t[k12] = v12
		if k13 then t[k13] = v13
		if k14 then t[k14] = v14
		if k15 then t[k15] = v15
		if k16 then t[k16] = v16
		if k17 then t[k17] = v17
		if k18 then t[k18] = v18
		if k19 then t[k19] = v19
		if k20 then t[k20] = v20
		end end end end end end end end end end end end end end end end end end end end
		return t
	end
	local x = tmp2
	function tmp2(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
		t = {}
		tmp2 = x
		x = nil
		return tmp2(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	end
end
--local levels
local buttons

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
	if oldLib and oldLib.registry then
		self.registry = oldLib.registry
		self.onceRegistered = oldLib.onceRegistered
	else
		self.registry = {}
		self.onceRegistered = {}

		local WorldFrame_OnMouseDown = WorldFrame:GetScript("OnMouseDown")
		local WorldFrame_OnMouseUp = WorldFrame:GetScript("OnMouseUp")
		local oldX, oldY, clickTime
		WorldFrame:SetScript("OnMouseDown", function()
			oldX,oldY = GetCursorPosition()
			clickTime = GetTime()
			if WorldFrame_OnMouseDown then
				WorldFrame_OnMouseDown()
			end
		end)

		WorldFrame:SetScript("OnMouseUp", function()
			local x,y = GetCursorPosition()
			if not oldX or not oldY or not x or not y or not clickTime then
				self:Close()
				if WorldFrame_OnMouseUp then
					WorldFrame_OnMouseUp()
				end
				return
			end
			local d = math.abs(x - oldX) + math.abs(y - oldY)
			if d <= 5 and GetTime() - clickTime < 0.5 then
				self:Close()
			end
			if WorldFrame_OnMouseUp then
				WorldFrame_OnMouseUp()
			end
		end)

		local DropDownList1_Show = DropDownList1.Show
		function DropDownList1.Show(DropDownList1)
			if levels[1] and levels[1]:IsVisible() then
				self:Close()
			end
			DropDownList1_Show(DropDownList1)
		end

		local old_HideDropDownMenu = HideDropDownMenu
		function HideDropDownMenu(num)
			if levels[1] and levels[1]:IsVisible() then
				self:Close()
			end
			old_HideDropDownMenu(num)
		end

		local old_CloseDropDownMenus = CloseDropDownMenus
		function CloseDropDownMenus(num)
			if levels[1] and levels[1]:IsVisible() then
				self:Close()
			end
			old_CloseDropDownMenus(num)
		end
	end
	levels = {}
	buttons = {}
end

function lib:LibDeactivate(stub)
	levels = nil
	buttons = nil
end

local function StartCounting(self, levelNum)
	for i = levelNum, tgetn(levels) do
		if levels[i] then
			levels[i].count = 3
		end
	end
end

local function StopCounting(self, level)
	for i = level, 1, -1 do
		if levels[i] then
			levels[i].count = nil
		end
	end
end

local function OnUpdate(self, arg1)
	for _,level in ipairs(levels) do
		if level.count then
			level.count = level.count - arg1
			if level.count < 0 then
				level.count = nil
				self:Close(level.num)
			end
		end
	end
end

local function CheckDualMonitor(self, frame)
	local ratio = GetScreenWidth() / GetScreenHeight()
	if ratio >= 2.4 and frame:GetRight() > GetScreenWidth() / 2 and frame:GetLeft() < GetScreenWidth() / 2 then
		local offsetx
		if GetCursorPosition() / GetScreenHeight() * 768 < GetScreenWidth() / 2 then
			offsetx = GetScreenWidth() / 2 - frame:GetRight()
		else
			offsetx = GetScreenWidth() / 2 - frame:GetLeft()
		end
		local point, parent, relativePoint, x, y = frame:GetPoint(1)
		frame:SetPoint(point, parent, relativePoint, (x or 0) + offsetx, y or 0)
	end
end

local function CheckSize(self, level)
	if not level.buttons then
		return
	end
	local height = 20
	for _, button in ipairs(level.buttons) do
		height = height + button:GetHeight()
	end
	level:SetHeight(height)
	local width = 160
	for _, button in ipairs(level.buttons) do
		local extra = 1
		if button.hasArrow or button.hasColorSwatch then
			extra = extra + 16
		end
		if not button.notCheckable then
			extra = extra + 24
		end
		button.text:SetFont(STANDARD_TEXT_FONT, button.textHeight)
		if button.text:GetWidth() + extra > width then
			width = button.text:GetWidth() + extra
		end
	end
	level:SetWidth(width + 20)
	if level:GetLeft() and level:GetTop() and level:GetLeft() < 0 or level:GetRight() > GetScreenWidth() or level:GetTop() > GetScreenHeight() or level:GetBottom() < 0 then
		level:ClearAllPoints()
		if level.lastDirection == "RIGHT" then
			if level.lastVDirection == "DOWN" then
				level:SetPoint("TOPLEFT", level.parent or level:GetParent(), "TOPRIGHT", 5, 10)
			else
				level:SetPoint("BOTTOMLEFT", level.parent or level:GetParent(), "BOTTOMRIGHT", 5, -10)
			end
		else
			if level.lastVDirection == "DOWN" then
				level:SetPoint("TOPRIGHT", level.parent or level:GetParent(), "TOPLEFT", -5, 10)
			else
				level:SetPoint("BOTTOMRIGHT", level.parent or level:GetParent(), "BOTTOMLEFT", -5, -10)
			end
		end
	end
	local dirty = false
	if not level:GetRight() then
		self:Close()
		return
	end
	if level:GetRight() > GetScreenWidth() and level.lastDirection == "RIGHT" then
		level.lastDirection = "LEFT"
		dirty = true
	elseif level:GetLeft() < 0 and level.lastDirection == "LEFT" then
		level.lastDirection = "RIGHT"
		dirty = true
	end
	if level:GetTop() > GetScreenHeight() and level.lastVDirection == "UP" then
		level.lastVDirection = "DOWN"
		dirty = true
	elseif level:GetBottom() < 0 and level.lastVDirection == "DOWN" then
		level.lastVDirection = "UP"
		dirty = true
	end
	if dirty then
		level:ClearAllPoints()
		if level.lastDirection == "RIGHT" then
			if level.lastVDirection == "DOWN" then
				level:SetPoint("TOPLEFT", level.parent or level:GetParent(), "TOPRIGHT", 5, 10)
			else
				level:SetPoint("BOTTOMLEFT", level.parent or level:GetParent(), "BOTTOMRIGHT", 5, -10)
			end
		else
			if level.lastVDirection == "DOWN" then
				level:SetPoint("TOPRIGHT", level.parent or level:GetParent(), "TOPLEFT", -5, 10)
			else
				level:SetPoint("BOTTOMRIGHT", level.parent or level:GetParent(), "BOTTOMLEFT", -5, -10)
			end
		end
	end
	if level:GetTop() > GetScreenHeight() then
		local top = level:GetTop()
		local point, parent, relativePoint, x, y = level:GetPoint(1)
		level:ClearAllPoints()
		level:SetPoint(point, parent, relativePoint, x or 0, (y or 0) + GetScreenHeight() - top)
	elseif level:GetBottom() < 0 then
		local bottom = level:GetBottom()
		local point, parent, relativePoint, x, y = level:GetPoint(1)
		level:ClearAllPoints()
		level:SetPoint(point, parent, relativePoint, x or 0, (y or 0) - bottom)
	end
	CheckDualMonitor(self, level)
	if mod(level.num, 5) == 0 then
		local left, bottom = level:GetLeft(), level:GetBottom()
		level:ClearAllPoints()
		level:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
	end
end

local Open
local OpenSlider
local Refresh
local Clear
local function ReleaseButton(self, level, index)
	if not level.buttons then
		return
	end
	if not level.buttons[index] then
		return
	end
	local button = level.buttons[index]
	button:Hide()
	if button.highlight then
		button.highlight:Hide()
	end
	tremove(level.buttons, index)
	tinsert(buttons, button)
	for k in pairs(button) do
		if k ~= 0 and k ~= "text" and k ~= "check" and k ~= "arrow" and k ~= "colorSwatch" and k ~= "highlight" and k ~= "radioHighlight" then
			button[k] = nil
		end
	end
	return true
end

local function Scroll(self, level, down)
	if down then
		if level:GetBottom() < 0 then
			local point, parent, relativePoint, x, y = level:GetPoint(1)
			level:SetPoint(point, parent, relativePoint, x, y + 50)
			if level:GetBottom() > 0 then
				level:SetPoint(point, parent, relativePoint, x, y + 50 - level:GetBottom())
			end
		end
	else
		if level:GetTop() > GetScreenHeight() then
			local point, parent, relativePoint, x, y = level:GetPoint(1)
			level:SetPoint(point, parent, relativePoint, x, y - 50)
			if level:GetTop() < GetScreenHeight() then
				level:SetPoint(point, parent, relativePoint, x, y - 50 + GetScreenHeight() - level:GetTop())
			end
		end
	end
end

local sliderFrame

local function AcquireButton(self, level)
	if not levels[level] then
		return
	end
	level = levels[level]
	if not level.buttons then
		level.buttons = {}
	end
	local button
	if tgetn(buttons) == 0 then
		button = CreateFrame("Button")
		button:SetFrameStrata("FULLSCREEN_DIALOG")
		button:SetHeight(16)
		local highlight = button:CreateTexture(nil, "BACKGROUND")
		highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		button.highlight = highlight
		highlight:SetBlendMode("ADD")
		highlight:SetAllPoints(button)
		highlight:Hide()
		local check = button:CreateTexture(nil, "ARTWORK")
		button.check = check
		check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		check:SetPoint("CENTER", button, "LEFT", 12, 0)
		check:SetWidth(24)
		check:SetHeight(24)
		local radioHighlight = button:CreateTexture(nil, "ARTWORK")
		button.radioHighlight = radioHighlight
		radioHighlight:SetTexture("Interface\\Buttons\\UI-RadioButton")
		radioHighlight:SetAllPoints(check)
		radioHighlight:SetBlendMode("ADD")
		radioHighlight:SetTexCoord(0.5, 0.75, 0, 1)
		radioHighlight:Hide()
		button:SetScript("OnEnter", function()
			if sliderFrame and sliderFrame:IsShown() and sliderFrame.mouseDown and sliderFrame.level == this.level.num + 1 then
				Refresh(self, this.level)
				return
			end
			self:Close(this.level.num + 1)
			if this.hasSlider then
				OpenSlider(self, this)
			elseif this.hasArrow then
				Open(self, this, nil, this.level.num + 1, this.value)
			end
			StopCounting(self, this.level.num + 1)
			if not this.disabled then
				highlight:Show()
				if this.isRadio then
					button.radioHighlight:Show()
				end
			end
			if this.tooltipTitle then
				GameTooltip_AddNewbieTip(this.tooltipTitle, 1.0, 1.0, 1.0, this.tooltipText, 1)
			end
		end)
		button:SetScript("OnLeave", function()
			highlight:Hide()
			button.radioHighlight:Hide()
			if this.level then
				StartCounting(self, this.level.num)
			end
			GameTooltip:Hide()
		end)
		button:SetScript("OnClick", function()
			if not this.disabled then
				if this.hasColorSwatch then
					local func = button.swatchFunc
					ColorPickerFrame.func = function()
						if func then
							func(ColorPickerFrame:GetColorRGB())
						end
					end
					ColorPickerFrame.hasOpacity = this.hasOpacity
					local func = this.opacityFunc
					ColorPickerFrame.opacityFunc = function()
						if func then
							func(1 - OpacitySliderFrame:GetValue())
						end
					end
					ColorPickerFrame.opacity = 1 - this.opacity
					ColorPickerFrame:SetColorRGB(this.r, this.g, this.b)
					if this.cancelFunc then
						local r, g, b, a = this.r, this.g, this.b, this.opacity
						local func = this.cancelFunc
						ColorPickerFrame.cancelFunc = function()
							func(r, g, b, a)
						end
					end
					self:Close(1)
					ShowUIPanel(ColorPickerFrame)
				elseif this.func then
					local level = button.level
					if type(this.func) == "string" then
						assert(type(this.arg1[this.func]) == "function", "Cannot call method " .. this.func)
						this.arg1[this.func](this.arg1, this.arg2, this.arg3, this.arg4)
					else
						this.func(this.arg1, this.arg2, this.arg3, this.arg4)
					end
					if this.closeWhenClicked then
						self:Close()
					elseif level:IsShown() then
						Refresh(self, level)
					end
				elseif this.closeWhenClicked then
					self:Close()
				end
			end
		end)
		local text = button:CreateFontString(nil, "ARTWORK")
		button.text = text
		text:SetFontObject(GameFontHighlightSmall)
		button.text:SetFont(STANDARD_TEXT_FONT, UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
		button:SetScript("OnMouseDown", function()
			if not this.disabled and (this.func or this.swatchFunc or this.closeWhenClicked) then
				text:SetPoint("LEFT", button, "LEFT", this.notCheckable and 1 or 25, -1)
			end
		end)
		button:SetScript("OnMouseUp", function()
			if not this.disabled and (this.func or this.swatchFunc or this.closeWhenClicked) then
				text:SetPoint("LEFT", button, "LEFT", this.notCheckable and 0 or 24, 0)
			end
		end)
		local arrow = button:CreateTexture(nil, "ARTWORK")
		button.arrow = arrow
		arrow:SetPoint("RIGHT", button, "RIGHT", 0, 0)
		arrow:SetWidth(16)
		arrow:SetHeight(16)
		arrow:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
		local colorSwatch = button:CreateTexture(nil, "OVERLAY")
		button.colorSwatch = colorSwatch
		colorSwatch:SetWidth(20)
		colorSwatch:SetHeight(20)
		colorSwatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
		local texture = button:CreateTexture(nil, "OVERLAY")
		colorSwatch.texture = texture
		texture:SetTexture(1, 1, 1)
		texture:SetWidth(11.5)
		texture:SetHeight(11.5)
		texture:Show()
		texture:SetPoint("CENTER", colorSwatch, "CENTER")
		colorSwatch:SetPoint("RIGHT", button, "RIGHT", 0, 0)
	else
		button = buttons[tgetn(buttons)]
		tremove(buttons, tgetn(buttons))
	end
	button:SetParent(level)
	button:SetFrameStrata(level:GetFrameStrata())
	button:SetFrameLevel(level:GetFrameLevel() + 1)
	button:SetPoint("LEFT", level, "LEFT", 10, 0)
	button:SetPoint("RIGHT", level, "RIGHT", -10, 0)
	if tgetn(level.buttons) == 0 then
		button:SetPoint("TOP", level, "TOP", 0, -10)
	else
		button:SetPoint("TOP", level.buttons[tgetn(level.buttons)], "BOTTOM", 0, 0)
	end
	button.text:SetPoint("LEFT", button, "LEFT", 24, 0)
	button:Show()
	button.level = level
	tinsert(level.buttons, button)
	if not level.parented then
		level.parented = true
		level:ClearAllPoints()
		if level.num == 1 then
			if level.parent ~= UIParent then
				level:SetPoint("TOPRIGHT", level.parent, "TOPLEFT")
			else
				level:SetPoint("CENTER", level.parent, "CENTER")
			end
		else
			if level.lastDirection == "RIGHT" then
				if level.lastVDirection == "DOWN" then
					level:SetPoint("TOPLEFT", level.parent, "TOPRIGHT", 5, 10)
				else
					level:SetPoint("BOTTOMLEFT", level.parent, "BOTTOMRIGHT", 5, -10)
				end
			else
				if level.lastVDirection == "DOWN" then
					level:SetPoint("TOPRIGHT", level.parent, "TOPLEFT", -5, 10)
				else
					level:SetPoint("BOTTOMRIGHT", level.parent, "BOTTOMLEFT", -5, -10)
				end
			end
		end
		level:SetFrameStrata("TOOLTIP")
	end
	return button
end

local function AcquireLevel(self, level)
	if not levels[level] then
		for i = tgetn(levels) + 1, level, -1 do
			local i = i
			local frame = CreateFrame("Button")
			if i == 1 then
				local old_CloseWindows = CloseWindows
				function CloseWindows(ignoreCenter)
					local found = old_CloseWindows(ignoreCenter)
					if levels[1]:IsShown() then
						self:Close()
						return 1
					end
					return found
				end
			end
			levels[i] = frame
			frame.num = i
			frame:SetParent(UIParent)
			frame:SetFrameStrata("TOOLTIP")
			frame:Hide()
			frame:SetWidth(180)
			frame:SetHeight(10)
			frame:SetFrameLevel(i * 3)
			frame:SetScript("OnHide", function()
				self:Close(level + 1)
			end)
			frame:SetFrameStrata("FULLSCREEN_DIALOG")
			if frame.SetTopLevel then
				frame:SetTopLevel(true)
			end
			frame:EnableMouse(true)
			frame:EnableMouseWheel(true)
			local backdrop = CreateFrame("Frame", nil, frame)
			backdrop:SetAllPoints(frame)
			backdrop:SetBackdrop(tmp(
				'bgFile', "Interface\\Tooltips\\UI-Tooltip-Background",
				'edgeFile', "Interface\\Tooltips\\UI-Tooltip-Border",
				'tile', true,
				'insets', tmp2(
					'left', 5,
					'right', 5,
					'top', 5,
					'bottom', 5
				),
				'tileSize', 16,
				'edgeSize', 16
			))
			backdrop:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
			backdrop:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
			frame:SetScript("OnClick", function()
				self:Close(i)
			end)
			frame:SetScript("OnEnter", function()
				StopCounting(self, i)
			end)
			frame:SetScript("OnLeave", function()
				StartCounting(self, i)
			end)
			frame:SetScript("OnMouseWheel", function()
				Scroll(self, frame, arg1 < 0)
			end)
			if i == 1 then
				frame:SetScript("OnUpdate", function()
					OnUpdate(self, arg1)
				end)
				levels[1].lastDirection = "RIGHT"
				levels[1].lastVDirection = "DOWN"
			else
				levels[i].lastDirection = levels[i - 1].lastDirection
				levels[i].lastVDirection = levels[i - 1].lastVDirection
			end
		end
	end
	return levels[level]
end

local baseFunc, currentLevel
function Refresh(self, level)
	if type(level) == "number" then
		level = levels[level]
	end
	if not level then
		return
	end
	if baseFunc then
		currentLevel = level.num
		Clear(self, level)
		baseFunc(currentLevel, level.value, levels[level.num - 1] and levels[level.num - 1].value, levels[level.num - 2] and levels[level.num - 2].value, levels[level.num - 3] and levels[level.num - 3].value, levels[level.num - 4] and levels[level.num - 4].value)
		CheckSize(self, level)
	end
end

function lib:Refresh(level)
	Refresh(self, levels[level])
end

function OpenSlider(self, parent)
	if not sliderFrame then
		sliderFrame = CreateFrame("Frame", nil, UIParent)
		sliderFrame:SetWidth(80)
		sliderFrame:SetHeight(170)
		sliderFrame:SetBackdrop(tmp(
			'bgFile', "Interface\\Tooltips\\UI-Tooltip-Background",
			'edgeFile', "Interface\\Tooltips\\UI-Tooltip-Border",
			'tile', true,
			'insets', tmp2(
				'left', 5,
				'right', 5,
				'top', 5,
				'bottom', 5
			),
			'tileSize', 16,
			'edgeSize', 16
		))
		sliderFrame:SetFrameStrata("TOOLTIP")
		if sliderFrame.SetTopLevel then
			sliderFrame:SetTopLevel(true)
		end
		sliderFrame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
		sliderFrame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
		sliderFrame:EnableMouse(TRUE)
		sliderFrame:Hide()
		sliderFrame:SetPoint("CENTER", UIParent, "CENTER")
		local slider = CreateFrame("Slider", nil, sliderFrame)
		sliderFrame.slider = slider
		slider:SetOrientation("VERTICAL")
		slider:SetMinMaxValues(0, 1)
		slider:SetValueStep(0.01)
		slider:SetValue(0.5)
		slider:SetWidth(16)
		slider:SetHeight(128)
		slider:SetPoint("LEFT", sliderFrame, "LEFT", 15, 0)
		slider:SetBackdrop(tmp(
			'bgFile', "Interface\\Buttons\\UI-SliderBar-Background",
			'edgeFile', "Interface\\Buttons\\UI-SliderBar-Border",
			'tile', true,
			'edgeSize', 8,
			'tileSize', 8,
			'insets', tmp2(
				'left', 3,
				'right', 3,
				'top', 3,
				'bottom', 3
			)
		))
		local texture = slider:CreateTexture()
		slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")
		local text = slider:CreateFontString(nil, "ARTWORK")
		sliderFrame.topText = text
		text:SetFontObject(GameFontGreenSmall)
		text:SetText("100%")
		text:SetPoint("BOTTOM", slider, "TOP")
		local text = slider:CreateFontString(nil, "ARTWORK")
		sliderFrame.bottomText = text
		text:SetFontObject(GameFontGreenSmall)
		text:SetText("0%")
		text:SetPoint("TOP", slider, "BOTTOM")
		local text = slider:CreateFontString(nil, "ARTWORK")
		sliderFrame.currentText = text
		text:SetFontObject(GameFontHighlightSmall)
		text:SetText("50%")
		text:SetPoint("LEFT", slider, "RIGHT")
		text:SetPoint("RIGHT", sliderFrame, "RIGHT", -6, 0)
		text:SetJustifyH("CENTER")
		local changed = false
		local inside = false
		slider:SetScript("OnValueChanged", function()
			if sliderFrame.changing then
				return
			end
			changed = true
			local done = false
			if sliderFrame.parent then
				if sliderFrame.parent.sliderFunc then
					local text = sliderFrame.parent.sliderFunc(1 - slider:GetValue())
					if text then
						sliderFrame.currentText:SetText(text)
						done = true
					end
				end
			end
			if not done then
				sliderFrame.currentText:SetText(format("%.0f%%", (1 - slider:GetValue()) * 100))
			end
		end)
		sliderFrame:SetScript("OnEnter", function()
			StopCounting(self, sliderFrame.level)
		end)
		sliderFrame:SetScript("OnLeave", function()
			StartCounting(self, sliderFrame.level)
		end)
		slider:SetScript("OnMouseDown", function()
			sliderFrame.mouseDown = true
		end)
		slider:SetScript("OnMouseUp", function()
			sliderFrame.mouseDown = false
			if changed and not inside then
				local parent = sliderFrame.parent
				Refresh(self, levels[sliderFrame.level - 1])
				OpenSlider(self, parent)
			end
		end)
		slider:SetScript("OnEnter", function()
			inside = true
			StopCounting(self, sliderFrame.level)
		end)
		slider:SetScript("OnLeave", function()
			inside = false
			StartCounting(self, sliderFrame.level)
			if changed and not sliderFrame.mouseDown then
				local parent = sliderFrame.parent
				Refresh(self, levels[sliderFrame.level - 1])
				OpenSlider(self, parent)
			end
		end)
	end
	sliderFrame.parent = parent
	sliderFrame.level = parent.level.num + 1
	sliderFrame.parentValue = parent.level.value
	sliderFrame:SetFrameLevel(parent.level:GetFrameLevel() + 3)
	sliderFrame.slider:SetFrameLevel(sliderFrame:GetFrameLevel() + 1)
	sliderFrame.changing = true
	if not parent.sliderValue then
		parent.sliderValue = 0.5
	end
	sliderFrame.slider:SetValue(1 - parent.sliderValue)
	sliderFrame.changing = false
	sliderFrame.bottomText:SetText(parent.sliderBottom or "0%")
	sliderFrame.topText:SetText(parent.sliderTop or "100%")
	local text
	if parent.sliderFunc then
		text = parent.sliderFunc(parent.sliderValue)
	end
	sliderFrame.currentText:SetText(text or format("%.0f%%", parent.sliderValue * 100))

	local level = parent.level
	sliderFrame:Show()
	sliderFrame:ClearAllPoints()
	if level.lastDirection == "RIGHT" then
		if level.lastVDirection == "DOWN" then
			sliderFrame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 5, 10)
		else
			sliderFrame:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", 5, -10)
		end
	else
		if level.lastVDirection == "DOWN" then
			sliderFrame:SetPoint("TOPRIGHT", parent, "TOPLEFT", -5, 10)
		else
			sliderFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", -5, -10)
		end
	end
	local dirty
	if level.lastDirection == "RIGHT" then
		if sliderFrame:GetRight() > GetScreenWidth() then
			level.lastDirection = "LEFT"
			dirty = true
		end
	elseif sliderFrame:GetLeft() < 0 then
		level.lastDirection = "RIGHT"
		dirty = true
	end
	if level.lastVDirection == "DOWN" then
		if sliderFrame:GetBottom() < 0 then
			level.lastVDirection = "UP"
			dirty = true
		end
	elseif sliderFrame:GetTop() > GetScreenWidth() then
		level.lastVDirection = "DOWN"
		dirty = true
	end
	if dirty then
		sliderFrame:ClearAllPoints()
		if level.lastDirection == "RIGHT" then
			if level.lastVDirection == "DOWN" then
				sliderFrame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 5, 10)
			else
				sliderFrame:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", 5, -10)
			end
		else
			if level.lastVDirection == "DOWN" then
				sliderFrame:SetPoint("TOPRIGHT", parent, "TOPLEFT", -5, 10)
			else
				sliderFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", -5, -10)
			end
		end
	end
	local left, bottom = sliderFrame:GetLeft(), sliderFrame:GetBottom()
	sliderFrame:ClearAllPoints()
	sliderFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
	if mod(level.num, 5) == 0 then
		local left, bottom = level:GetLeft(), level:GetBottom()
		level:ClearAllPoints()
		level:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
	end
end

function lib:IsOpen(parent)
	return levels[1] and levels[1]:IsShown() and (parent == levels[1].parent or parent == levels[1]:GetParent())
end

function Open(self, parent, func, level, value, point, relativePoint, cursorX, cursorY)
	self:Close(level)
	local frame = AcquireLevel(self, level)
	if level == 1 then
		frame.lastDirection = "RIGHT"
		frame.lastVDirection = "DOWN"
	else
		frame.lastDirection = levels[level - 1].lastDirection
		frame.lastVDirection = levels[level - 1].lastVDirection
	end
	frame:SetFrameStrata("TOOLTIP")
	frame:ClearAllPoints()
	frame.parent = parent
	frame:SetPoint("LEFT", UIParent, "RIGHT", 10000, 0)
	frame:Show()
	if level == 1 then
		baseFunc = func
	end
	levels[level].value = value
	relativePoint = relativePoint or point
	Refresh(self, levels[level])
	if point then
		frame:ClearAllPoints()
		frame:SetPoint(point, parent, relativePoint)
		if cursorX then
			local left = frame:GetLeft()
			local width = frame:GetWidth()
			local curX, curY = GetCursorPosition()
			frame:ClearAllPoints()
			relativePoint = relativePoint or point
			if point == "BOTTOM" or point == "TOP" then
				if curX < GetScreenWidth() / 2 then
					point = point .. "LEFT"
				else
					point = point .. "RIGHT"
				end
			elseif point == "CENTER" then
				if curX < GetScreenWidth() / 2 then
					point = "LEFT"
				else
					point = "RIGHT"
				end
			end
			frame:SetPoint(point, parent, relativePoint, curX - left - width / 2, 0)
			if level == 1 then
				frame.lastDirection = "RIGHT"
			end
		elseif cursorY then
			local bottom = frame:GetBottom()
			local height = frame:GetHeight()
			local curX, curY = GetCursorPosition()
			frame:ClearAllPoints()
			relativePoint = relativePoint or point
			if point == "LEFT" or point == "RIGHT" then
				if curX < GetScreenHeight() / 2 then
					point = point .. "BOTTOM"
				else
					point = point .. "TOP"
				end
			elseif point == "CENTER" then
				if curX < GetScreenHeight() / 2 then
					point = "BOTTOM"
				else
					point = "TOP"
				end
			end
			frame:SetPoint(point, parent, relativePoint, 0, curY - bottom - height / 2)
			if level == 1 then
				frame.lastDirection = "DOWN"
			end
		end
		if (strsub(point, 1, 3) ~= strsub(relativePoint, 1, 3)) then
			if frame:GetBottom() < 0 then
				local point, parent, relativePoint, x, y = frame:GetPoint(1)
				local change = GetScreenHeight() - frame:GetTop()
				local otherChange = -frame:GetBottom()
				if otherChange < change then
					change = otherChange
				end
				frame:SetPoint(point, parent, relativePoint, x, y + change)
			elseif frame:GetTop() > GetScreenHeight() then
				local point, parent, relativePoint, x, y = frame:GetPoint(1)
				local change = GetScreenHeight() - frame:GetTop()
				local otherChange = -frame:GetBottom()
				if otherChange < change then
					change = otherChange
				end
				frame:SetPoint(point, parent, relativePoint, x, y + change)
			end
		end
	end
	CheckDualMonitor(self, frame)
	StartCounting(self, level)
end

function lib:IsRegistered(parent)
	assert(parent, "You must provide a parent frame to check")
	return not not self.registry[parent]
end

function lib:Register(parent, k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	assert(parent, "You must provide a parent frame to register with")
	if self.registry[parent] then
		self:Unregister(parent)
	end
	local info = new(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	self.registry[parent] = info
	if not info.dontHook and not self.onceRegistered[parent] then
		if parent:HasScript("OnMouseUp") then
			local script = parent:GetScript("OnMouseUp")
			parent:SetScript("OnMouseUp", function()
				if script then
					script()
				end
				if arg1 == "RightButton" and self.registry[parent] then
					if self:IsOpen(parent) then
						self:Close()
					else
						self:Open(parent)
					end
				end
			end)
		end
		if parent:HasScript("OnMouseDown") then
			local script = parent:GetScript("OnMouseDown")
			parent:SetScript("OnMouseDown", function()
				if script then
					script()
				end
				if self.registry[parent] then
					self:Close()
				end
			end)
		end
	end
	self.onceRegistered[parent] = true
end

function lib:Unregister(parent)
	assert(self.registry[parent], "You cannot unregister a parent frame if it has not been registered already.")
	self.registry[parent] = nil
end

function lib:Open(parent, k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	local info
	if type(k1) == "table" and k1[0] and k1.IsFrameType and self.registry[k1] then
		info = tmp()
		for k,v in pairs(self.registry[k1]) do
			info[k] = v
		end
	else
		info = tmp(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
		if self.registry[parent] then
			for k,v in pairs(self.registry[parent]) do
				if info[k] == nil then
					info[k] = v
				end
			end
		end
	end
	local point = info.point
	local relativePoint = info.relativePoint
	local cursorX = info.cursorX
	local cursorY = info.cursorY
	if type(point) == "function" then
		local b
		point, b = point(parent)
		if b then
			relativePoint = b
		end
	end
	if type(relativePoint) == "function" then
		relativePoint = relativePoint(parent)
	end
	Open(self, parent, info.children, 1, nil, point, relativePoint, cursorX, cursorY)
end

function Clear(self, level)
	if level then
		if level.buttons then
			for i = tgetn(level.buttons), 1, -1 do
				ReleaseButton(self, level, i)
			end
		end
	end
end

function lib:Close(level)
	if DropDownList1:IsShown() then
		DropDownList1:Hide()
	end
	if not level then
		level = 1
	end
	if level == 1 and levels[level] then
		levels[level].parented = false
	end
	if sliderFrame and sliderFrame.level == level then
		sliderFrame:Hide()
	end
	if levels[level] and levels[level]:IsShown() then
		Clear(self, levels[level])
		levels[level]:Hide()
	end
end

function lib:AddLine(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	local info = tmp(k1, v1, k2, v2, k3, v3, k4, v4, k5, v5, k6, v6, k7, v7, k8, v8, k9, v9, k10, v10, k11, v11, k12, v12, k13, v13, k14, v14, k15, v15, k16, v16, k17, v17, k18, v18, k19, v19, k20, v20)
	local level = info.level or currentLevel
	info.level = nil
	local button = AcquireButton(self, level)
	if not next(info) then
		info.disabled = true
	end
	button.disabled = info.isTitle or info.notClickable or info.disabled
	button.isTitle = info.isTitle
	button.notClickable = info.notClickable
	if button.isTitle then
		button.text:SetFontObject(GameFontNormalSmall)
	elseif button.notClickable then
		button.text:SetFontObject(GameFontHighlightSmall)
	elseif button.disabled then
		button.text:SetFontObject(GameFontDisableSmall)
	else
		button.text:SetFontObject(GameFontHighlightSmall)
	end
	if info.textR and info.textG and info.textB then
		button.textR = info.textR
		button.textG = info.textG
		button.textB = info.textB
		button.text:SetTextColor(button.textR, button.textG, button.textB)
	else
		button.text:SetTextColor(button.text:GetFontObject():GetTextColor())
	end
	button.notCheckable = info.notCheckable
	button.text:SetPoint("LEFT", button, "LEFT", button.notCheckable and 0 or 24, 0)
	button.checked = not info.notCheckable and info.checked
	button.isRadio = not info.notCheckable and info.isRadio
	if info.isRadio then
		button.check:Show()
		button.check:SetTexture(info.checkIcon or "Interface\\Buttons\\UI-RadioButton")
		if button.checked then
			button.check:SetTexCoord(0.25, 0.5, 0, 1)
			button.check:SetVertexColor(1, 1, 1, 1)
		else
			button.check:SetTexCoord(0, 0.25, 0, 1)
			button.check:SetVertexColor(1, 1, 1, 0.5)
		end
		button.radioHighlight:SetTexture(info.checkIcon or "Interface\\Buttons\\UI-RadioButton")
		button.check:SetWidth(16)
		button.check:SetHeight(16)
	else
		if button.checked then
			button.check:SetTexCoord(0, 1, 0, 1)
			if info.checkIcon then
				button.check:SetWidth(16)
				button.check:SetHeight(16)
				button.check:SetTexture(info.checkIcon)
			else
				button.check:SetWidth(24)
				button.check:SetHeight(24)
				button.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
			end
			button.check:SetVertexColor(1, 1, 1, 1)
		else
			button.check:SetVertexColor(1, 1, 1, 0)
		end
	end
	if not button.disabled then
		button.func = info.func
	end
	button.hasColorSwatch = info.hasColorSwatch
	if button.hasColorSwatch then
		button.colorSwatch:Show()
		button.colorSwatch.texture:Show()
		button.r = info.r or 1
		button.g = info.g or 1
		button.b = info.b or 1
		button.colorSwatch.texture:SetTexture(button.r, button.g, button.b)
		button.checked = false
		button.func = nil
		button.swatchFunc = info.swatchFunc
		button.hasOpacity = info.hasOpacity
		button.opacityFunc = info.opacityFunc
		button.opacity = info.opacity or 1
		button.cancelFunc = info.cancelFunc
	else
		button.colorSwatch:Hide()
		button.colorSwatch.texture:Hide()
	end
	button.hasArrow = not button.hasColorSwatch and (info.value or info.hasSlider) and info.hasArrow
	if button.hasArrow then
		button.arrow:SetAlpha(1)
		if info.hasSlider then
			button.hasSlider = info.hasSlider
			button.sliderTop = info.sliderTop or "100%"
			button.sliderBottom = info.sliderBottom or "0%"
			button.sliderFunc = info.sliderFunc
			button.sliderValue = info.sliderValue
		else
			button.value = info.value
		end
	else
		button.arrow:SetAlpha(0)
	end
	button.arg1 = info.arg1
	button.arg2 = info.arg2
	button.arg3 = info.arg3
	button.arg4 = info.arg4
	button.closeWhenClicked = info.closeWhenClicked
	button.textHeight = info.textHeight or UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT
	local font,_ = button.text:GetFont()
	button.text:SetFont(STANDARD_TEXT_FONT, button.textHeight)
	button:SetHeight(button.textHeight + 6)
	button.text:SetPoint("RIGHT", button.arrow, (button.hasColorSwatch or button.hasArrow) and "LEFT" or "RIGHT")
	button.text:SetJustifyH(info.justifyH or "LEFT")
	button.text:SetText(info.text)
	button.tooltipTitle = info.tooltipTitle
	button.tooltipText = info.tooltipText
	if type(button.func) == "string" then
		assert(type(button.arg1) == "table", "Cannot call method " .. button.func .. " on a non-table")
		assert(type(button.arg1[button.func]) == "function", "Method " .. button.func .. " nonexistant.")
	end
end

DewdropLib:Register(lib)
lib = nil

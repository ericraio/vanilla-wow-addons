local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local metro = AceLibrary("Metrognome-2.0")
local abacus = AceLibrary("Abacus-2.0")
local compost = AceLibrary("Compost-2.0")
local L = AceLibrary("AceLocale-2.0"):new("MoneyFu")

MoneyFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0")
MoneyFu.hasIcon = true
MoneyFu:RegisterDB("MoneyFuDB", "MoneyFuCharDB")
MoneyFu:RegisterDefaults('profile', {
	style = "GRAPHICAL",
	trackByRealm = true,
	simpleTooltip = false
})
MoneyFu:RegisterDefaults('char', {
	spent = {},
	gained = {},
	time = {}
})
MoneyFu:RegisterDefaults('realm', {
	chars = {},
	spent = {},
	gained = {},
	time = {}
})
MoneyFu:RegisterChatCommand(L["COMMANDS"], {
	desc = L["DESCRIPTION"],
	type = 'group',
	args = {},
})
MoneyFu.frame = MoneyFu:CreateBasicPluginFrame("MoneyFuFrame")

function MoneyFu:SetStyle(style)
	style = string.upper(style)
	if style ~= "GRAPHICAL" and style ~= "FULL" and style ~= "SHORT" and style ~= "CONDENSED" then
		style = "GRAPHICAL"
	end
	self.db.profile.style = style
	self:UpdateText()
end

function MoneyFu:ResetSession()
	self.initialMoney = GetMoney()
	self.sessionTime = time()
	self.gained = 0
	self.spent = 0
end

function MoneyFu:OnInitialize()
	self.hasIcon = true
	self.canHideText = true
	local frame = self.frame
	local icon = frame:CreateTexture("MoneyFuFrameIcon", "ARTWORK")
	icon:SetWidth(16)
	icon:SetHeight(16)
	icon:SetPoint("LEFT", frame, "LEFT")
	self.iconFrame = icon
	
	local text = frame:CreateFontString("MoneyFuFrameText", "OVERLAY")
	text:SetJustifyH("RIGHT")
	text:SetPoint("RIGHT", frame, "RIGHT", 0, 1)
	text:SetFontObject(GameFontNormal)
	self.textFrame = text
	
	self:SetIcon(true)
	
	local goldIcon = frame:CreateTexture("MoneyFuFrameGoldIcon", "ARTWORK")
	goldIcon:SetWidth(16)
	goldIcon:SetHeight(16)
	goldIcon:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
	goldIcon:SetTexCoord(0, 0.25, 0, 1)
	
	local silverIcon = frame:CreateTexture("MoneyFuFrameSilverIcon", "ARTWORK")
	silverIcon:SetWidth(16)
	silverIcon:SetHeight(16)
	silverIcon:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
	silverIcon:SetTexCoord(0.25, 0.5, 0, 1)
	
	local copperIcon = frame:CreateTexture("MoneyFuFrameCopperIcon", "ARTWORK")
	copperIcon:SetWidth(16)
	copperIcon:SetHeight(16)
	copperIcon:SetTexture("Interface\\MoneyFrame\\UI-MoneyIcons")
	copperIcon:SetTexCoord(0.5, 0.75, 0, 1)
	
	local goldText = frame:CreateFontString("MoneyFuFrameGoldText", "OVERLAY")
	goldText:SetJustifyH("RIGHT")
	goldText:SetPoint("RIGHT", goldIcon, "LEFT", 0, 1)
	goldText:SetFontObject(GameFontNormal)
	
	local silverText = frame:CreateFontString("MoneyFuFrameSilverText", "OVERLAY")
	silverText:SetJustifyH("RIGHT")
	silverText:SetPoint("RIGHT", silverIcon, "LEFT", 0, 1)
	silverText:SetFontObject(GameFontNormal)
	
	local copperText = frame:CreateFontString("MoneyFuFrameCopperText", "OVERLAY")
	copperText:SetJustifyH("RIGHT")
	copperText:SetPoint("RIGHT", copperIcon, "LEFT", 0, 1)
	copperText:SetFontObject(GameFontNormal)
	
	copperIcon:SetPoint("RIGHT", frame, "RIGHT")
	silverIcon:SetPoint("RIGHT", copperText, "LEFT")
	goldIcon:SetPoint("RIGHT", silverText, "LEFT")
end

local function GetToday(self)
	return floor((time() / 60 / 60 + self:GetServerOffset()) / 24)
end

function MoneyFu:OnEnable()
	self.initialMoney = GetMoney()
	self.lastMoney = self.initialMoney
	self.lastTime = GetToday(self)
	local lastWeek = self.lastTime - 6
	for day in pairs(self.db.char.gained) do
		if day < lastWeek then
			self.db.char.gained[day] = nil
		end
	end
	for day in pairs(self.db.char.spent) do
		if day < lastWeek then
			self.db.char.spent[day] = nil
		end
	end
	for day in pairs(self.db.char.time) do
		if day < lastWeek then
			self.db.char.time[day] = nil
		end
	end
	for day in pairs(self.db.realm.gained) do
		if day < lastWeek then
			self.db.realm.gained[day] = nil
		end
	end
	for day in pairs(self.db.realm.spent) do
		if day < lastWeek then
			self.db.realm.spent[day] = nil
		end
	end
	for day in pairs(self.db.realm.time) do
		if day < lastWeek then
			self.db.realm.time[day] = nil
		end
	end
	for i = self.lastTime - 6, self.lastTime do
		if not self.db.char.gained[i] then
			self.db.char.gained[i] = 0
		end
		if not self.db.char.spent[i] then
			self.db.char.spent[i] = 0
		end
		if not self.db.char.time[i] then
			self.db.char.time[i] = 0
		end
		if not self.db.realm.gained[i] then
			self.db.realm.gained[i] = 0
		end
		if not self.db.realm.spent[i] then
			self.db.realm.spent[i] = 0
		end
		if not self.db.realm.time[i] then
			self.db.realm.time[i] = 0
		end
	end
	self.gained = 0
	self.spent = 0
	self.sessionTime = time()
	self.savedTime = time()
	
	if self.db.profile.style == "GRAPHICAL" then
		self:HideIcon()
		self.iconFrame:Hide()
		self.hasIcon = false
	end
	self:RegisterEvent("PLAYER_MONEY", "Update")
	self:RegisterEvent("PLAYER_TRADE_MONEY", "Update")
	self:RegisterEvent("TRADE_MONEY_CHANGED", "Update")
	self:RegisterEvent("SEND_MAIL_MONEY_CHANGED", "Update")
	self:RegisterEvent("SEND_MAIL_COD_CHANGED", "Update")
	
	self:Hook("OpenCoinPickupFrame")
	
	MoneyFuFrameGoldIcon:ClearAllPoints()
	MoneyFuFrameGoldIcon:SetPoint("RIGHT", MoneyFuFrameSilverText, "LEFT", 0, -1)
	MoneyFuFrameSilverIcon:ClearAllPoints()
	MoneyFuFrameSilverIcon:SetPoint("RIGHT", MoneyFuFrameCopperText, "LEFT", 0, -1)
	
	metro:RegisterMetro(self.name, self.UpdateTooltip, 1, self)
	metro:StartMetro(self.name)
end

function MoneyFu:OnDisable()
	metro:UnregisterMetro(self.name)
end

function MoneyFu:OnMenuRequest(level, value)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["MENU_RESET_SESSION"],
			'arg1', self,
			'func', "ResetSession",
			'closeWhenClicked', true
		)
		
		dewdrop:AddLine(
			'text', L["MENU_CHARACTER_SPECIFIC_CASHFLOW"],
			'arg1', self,
			'func', function()
				self.db.profile.trackByRealm = not self.db.profile.trackByRealm
				self:UpdateTooltip()
			end,
			'checked', not self.db.profile.trackByRealm
		)
		
		dewdrop:AddLine()
		
		dewdrop:AddLine(
			'text', L["MENU_SHOW_GRAPHICAL"],
			'arg1', self,
			'func', self.db.profile.style ~= "GRAPHICAL" and "SetStyle",
			'arg2', "GRAPHICAL",
			'checked', self.db.profile.style == "GRAPHICAL",
			'isRadio', true
		)
		
		dewdrop:AddLine(
			'text', L["MENU_SHOW_FULL"],
			'arg1', self,
			'func', self.db.profile.style ~= "FULL" and "SetStyle",
			'arg2', "FULL",
			'checked', self.db.profile.style == "FULL",
			'isRadio', true
		)
		
		dewdrop:AddLine(
			'text', L["MENU_SHOW_SHORT"],
			'arg1', self,
			'func', self.db.profile.style ~= "SHORT" and "SetStyle",
			'arg2', "SHORT",
			'checked', self.db.profile.style == "SHORT",
			'isRadio', true
		)
		
		dewdrop:AddLine(
			'text', L["MENU_SHOW_CONDENSED"],
			'arg1', self,
			'func', self.db.profile.style ~= "CONDENSED" and "SetStyle",
			'arg2', "CONDENSED",
			'checked', self.db.profile.style == "CONDENSED",
			'isRadio', true
		)
		
		dewdrop:AddLine(
			'text', L["SIMPLIFIED_TOOLTIP"],
			'arg1', self,
			'func', function()
				self.db.profile.simpleTooltip = not self.db.profile.simpleTooltip
				self:Update()
			end,
			'checked', self.db.profile.simpleTooltip
		)

		if next(self.db.realm.chars) ~= UnitName("player") or next(self.db.realm.chars, UnitName("player")) then
			dewdrop:AddLine()
			
			dewdrop:AddLine(
				'text', L["MENU_PURGE"],
				'hasArrow', true,
				'value', "purge"
			)
		end
	elseif level == 2 then
		if value == "purge" then
			for name in self.db.realm.chars do
				if name ~= UnitName("player") then
					dewdrop:AddLine(
						'text', name,
						'arg1', name,
						'func', function(name)
							self.db.realm.chars[name] = nil
						end,
						'closeWhenClicked', true
					)
				end
			end
		end
	end
end

function MoneyFu:UpdateData()
	local today = GetToday(self)
	if not self.lastTime then
		self.lastTime = today
	end
	if today > self.lastTime then
		self.db.char.gained[today - 7] = nil
		self.db.char.spent[today - 7] = nil
		self.db.char.time[today - 7] = nil
		self.db.realm.gained[today - 7] = nil
		self.db.realm.spent[today - 7] = nil
		self.db.realm.time[today - 7] = nil
		self.db.char.gained[today] = self.db.char.gained[today] or 0
		self.db.char.spent[today] = self.db.char.spent[today] or 0
		self.db.char.time[today] = self.db.char.time[today] or 0
		self.db.realm.gained[today] = self.db.realm.gained[today] or 0
		self.db.realm.spent[today] = self.db.realm.spent[today] or 0
		self.db.realm.time[today] = self.db.realm.time[today] or 0
		self.lastTime = today
	end
	local current = GetMoney()
	if not self.lastMoney then
		self.lastMoney = current
	end
	if self.lastMoney < current then
		self.gained = (self.gained or 0) + current - self.lastMoney
		self.db.char.gained[today] = (self.db.char.gained[today] or 0) + current - self.lastMoney
		self.db.realm.gained[today] = (self.db.realm.gained[today] or 0) + current - self.lastMoney
	elseif self.lastMoney > current then
		self.spent = (self.spent or 0) + self.lastMoney - current
		self.db.char.spent[today] = (self.db.char.spent[today] or 0) + self.lastMoney - current
		self.db.realm.spent[today] = (self.db.realm.spent[today] or 0) + self.lastMoney - current
	end
	self.lastMoney = current
	self.db.realm.chars[UnitName("player")] = current
	local now = time()
	self.db.char.time[today] = self.db.char.time[today] + now - self.savedTime
	self.db.realm.time[today] = self.db.realm.time[today] + now - self.savedTime
	self.savedTime = now
end

function MoneyFu:UpdateText()
	if self.db.profile == nil then
		return
	end
	if self.db.profile.style == "GRAPHICAL" then
		if self:IsIconShown() then
			self.db.profile.iconVisible = true
			self:HideIcon()
		end
		self.hasIcon = false
		MoneyFuFrameIcon:Hide()
		MoneyFuFrameText:Hide()
		local copper = GetMoney()
		local gold = floor(copper / 10000)
		local silver = mod(floor(copper / 100), 100)
		copper = mod(copper, 100)
		local width = 0
		if gold == 0 then
			MoneyFuFrameGoldIcon:Hide()
			MoneyFuFrameGoldText:Hide()
		else
			MoneyFuFrameGoldIcon:Show()
			MoneyFuFrameGoldText:Show()
			MoneyFuFrameGoldText:SetWidth(0)
			MoneyFuFrameGoldText:SetText(gold)
			width = width + MoneyFuFrameGoldIcon:GetWidth() + MoneyFuFrameGoldText:GetWidth()
		end
		if gold == 0 and silver == 0 then
			MoneyFuFrameSilverIcon:Hide()
			MoneyFuFrameSilverText:Hide()
		else
			MoneyFuFrameSilverIcon:Show()
			MoneyFuFrameSilverText:Show()
			MoneyFuFrameSilverText:SetWidth(0)
			MoneyFuFrameSilverText:SetText(silver)
			width = width + MoneyFuFrameSilverIcon:GetWidth() + MoneyFuFrameSilverText:GetWidth()
		end
		MoneyFuFrameCopperIcon:Show()
		MoneyFuFrameCopperText:Show()
		MoneyFuFrameCopperText:SetWidth(0)
		MoneyFuFrameCopperText:SetText(copper)
		width = width + MoneyFuFrameCopperIcon:GetWidth() + MoneyFuFrameCopperText:GetWidth()
		self.frame:SetWidth(width)
	else
		if not self.hasIcon then
			self.hasIcon = true
			if self.db.profile.iconVisible then
				self:ShowIcon()
			end
		end
		self.db.profile.iconVisible = false
		MoneyFuFrameGoldIcon:Hide()
		MoneyFuFrameSilverIcon:Hide()
		MoneyFuFrameCopperIcon:Hide()
		MoneyFuFrameGoldText:Hide()
		MoneyFuFrameSilverText:Hide()
		MoneyFuFrameCopperText:Hide()
		MoneyFuFrameText:Show()
		if self.db.profile.style == "CONDENSED" then
			self:SetText(abacus:FormatMoneyCondensed(GetMoney(), true))
		elseif self.db.profile.style == "FULL" then
			self:SetText(abacus:FormatMoneyFull(GetMoney(), true))
		else
			self:SetText(abacus:FormatMoneyShort(GetMoney(), true))
		end
		self:CheckWidth(true)
	end
end

function MoneyFu:OnTooltipUpdate()
	local now = time()
	local today = self.lastTime
	self.db.char.time[today] = self.db.char.time[today] + now - self.savedTime
	self.db.realm.time[today] = self.db.realm.time[today] + now - self.savedTime
	self.savedTime = now
	local func
	if self.db.profile.style == "CONDENSED" then
		func = abacus.FormatMoneyCondensed
	elseif self.db.profile.style == "SHORT" then
		func = abacus.FormatMoneyShort
	else
		func = abacus.FormatMoneyFull
	end
	
	local supercat = tablet:AddCategory(
		'columns', 3,
		'child_text2', L["TEXT_AMOUNT"],
		'child_text3', L["TEXT_PER_HOUR"],
		'child_child_textR', 1,
		'child_child_textG', 1,
		'child_child_textB', 0,
		'child_child_text2R', 1,
		'child_child_text2G', 1,
		'child_child_text2B', 1,
		'child_child_text3R', 1,
		'child_child_text3G', 1,
		'child_child_text3B', 1
	)
	
	------------
	if not self.db.profile.simpleTooltip then	
		local cat = supercat:AddCategory(
			'text', L["TEXT_THIS_SESSION"]
		)
	
		cat:AddLine(
			'text', L["TEXT_GAINED"],
			'text2', func(abacus, self.gained, true),
			'text3', func(abacus, self.gained / (now - self.sessionTime) * 3600, true)
		)
		cat:AddLine(
			'text', L["TEXT_SPENT"],
			'text2', func(abacus, self.spent, true),
			'text3', func(abacus, self.spent / (now - self.sessionTime) * 3600, true)
		)
		local profit = self.gained - self.spent
		cat:AddLine(
			'text', profit >= 0 and L["TEXT_PROFIT"] or L["TEXT_LOSS"],
			'text2', func(abacus, profit, true, true),
			'text3', func(abacus, profit / (now - self.sessionTime) * 3600, true, true)
		)

		local t
		if self.db.profile.trackByRealm then
			t = self.db.realm
		else
			t = self.db.char
		end
		local gained = t.gained
		local spent = t.spent
		local time = t.time

		-- ------------
		-- Session totals
		-- ------------
		cat = supercat:AddCategory(
			'text', HONOR_THIS_SESSION
		)
	
		cat:AddLine(
			'text', L["TEXT_GAINED"],
			'text2', func(abacus, gained[self.lastTime], true),
			'text3', func(abacus, gained[self.lastTime] / time[self.lastTime] * 3600, true)
		)
		cat:AddLine(
			'text', L["TEXT_SPENT"],
			'text2', func(abacus, spent[self.lastTime], true),
			'text3', func(abacus, spent[self.lastTime] / time[self.lastTime] * 3600, true)
		)
		local profit = gained[self.lastTime] - spent[self.lastTime]
		cat:AddLine(
			'text', profit >= 0 and L["TEXT_PROFIT"] or L["TEXT_LOSS"],
			'text2', func(abacus, profit, true, true),
			'text3', func(abacus, profit / time[self.lastTime] * 3600, true, true)
		)

		-- -----------
		-- Yesterday totals
		-- -----------
		cat = supercat:AddCategory(
			'text', HONOR_YESTERDAY
		)
	
		cat:AddLine(
			'text', L["TEXT_GAINED"],
			'text2', func(abacus, gained[self.lastTime - 1], true),
			'text3', func(abacus, gained[self.lastTime - 1] / time[self.lastTime - 1] * 3600, true)
		)
		cat:AddLine(
			'text', L["TEXT_SPENT"],
			'text2', func(abacus, spent[self.lastTime - 1], true),
			'text3', func(abacus, spent[self.lastTime - 1] / time[self.lastTime - 1] * 3600, true)
		)
		local profit = gained[self.lastTime - 1] - spent[self.lastTime - 1]
		cat:AddLine(
			'text', profit >= 0 and L["TEXT_PROFIT"] or L["TEXT_LOSS"],
			'text2', func(abacus, profit, true, true),
			'text3', func(abacus, profit / time[self.lastTime - 1] * 3600, true, true)
		)

		-- -----------
		-- Week totals
		-- -----------
		local weekGained = 0
		local weekSpent = 0
		local weekTime = 0
		for i = self.lastTime - 6, self.lastTime do
			weekGained = weekGained + gained[i]
			weekSpent = weekSpent + spent[i]
			weekTime = weekTime + time[i]
		end
		cat = supercat:AddCategory(
			'text', HONOR_THISWEEK
		)
	
		cat:AddLine(
			'text', L["TEXT_GAINED"],
			'text2', func(abacus, weekGained, true),
			'text3', func(abacus, weekGained / weekTime * 3600, true)
		)
		cat:AddLine(
			'text', L["TEXT_SPENT"],
			'text2', func(abacus, weekSpent, true),
			'text3', func(abacus, weekSpent / weekTime * 3600, true)
		)
		local profit = weekGained - weekSpent
		cat:AddLine(
			'text', profit >= 0 and L["TEXT_PROFIT"] or L["TEXT_LOSS"],
			'text2', func(abacus, profit, true, true),
			'text3', func(abacus, profit / weekTime * 3600, true, true)
		)
	end
	-- -------------
	-- Character Totals, we always show this bit.
	-- -------------
	local total = 0
	local addedCat = false
	if next(self.db.realm.chars) ~= UnitName("player") or next(self.db.realm.chars, UnitName("player")) then
		local t = compost:Acquire()
		for name in pairs(self.db.realm.chars) do
			table.insert(t, name)
		end
		if not self.sort_func then
			self.sort_func = function(alpha, bravo)
				return self.db.realm.chars[alpha] < self.db.realm.chars[bravo]
			end
		end
		table.sort(t, self.sort_func)
		
		cat = tablet:AddCategory(
			'columns', 2,
			'text', L["TEXT_CHARACTERS"],
			'text2', "Amount",
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0,
			'child_text2R', 1,
			'child_text2G', 1,
			'child_text2B', 1
		)
		for _,name in t do
			local value = self.db.realm.chars[name]
			cat:AddLine(
				'text', name,
				'text2', func(abacus, value, true)
			)
			total = total + value
		end
	else
		total = self.db.realm.chars[UnitName("player")]
	end
	
	cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 1,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	cat:AddLine(
		'text', L["TEXT_TOTAL"],
		'text2', func(abacus, total, true)
	)
	
	tablet:SetHint(L["HINT"])
end

local function getsecond(_, value)
	return value
end

function MoneyFu:OnClick(button)
	local money = GetMoney()
	if money < 100 then
		money = 1
	elseif money < 10000 then
		money = 100
	else
		money = 10000
	end
	self.frame.moneyType = "PLAYER"
	OpenCoinPickupFrame(money, GetMoney(), self.frame)
	self.frame.hasPickup = 1
	
	CoinPickupFrame:ClearAllPoints()
	local frame = self.frame
	if self:IsMinimapAttached() then
		frame = self.minimapFrame
	end
	if frame:GetCenter() < GetScreenWidth()/2 then
		if getsecond(frame:GetCenter()) < GetScreenHeight()/2 then
			CoinPickupFrame:SetPoint("BOTTOMLEFT", frame, "TOPLEFT")
		else
			CoinPickupFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT")
		end
	else
		if getsecond(frame:GetCenter()) < GetScreenHeight()/2 then
			CoinPickupFrame:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT")
		else
			CoinPickupFrame:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT")
		end
	end
end

function MoneyFu:OpenCoinPickupFrame(multiplier, maxMoney, parent)
	CoinPickupFrame:ClearAllPoints()
	self.hooks.OpenCoinPickupFrame.orig(multiplier, maxMoney, parent)
end

function MoneyFu:SetFontSize(size)
	if MoneyFuFrameGoldIcon == nil then
		self.fontSize = size
		return
	end
	MoneyFuFrameGoldIcon:SetWidth(size)
	MoneyFuFrameGoldIcon:SetHeight(size)
	MoneyFuFrameSilverIcon:SetWidth(size)
	MoneyFuFrameSilverIcon:SetHeight(size)
	MoneyFuFrameCopperIcon:SetWidth(size)
	MoneyFuFrameCopperIcon:SetHeight(size)
	self.iconFrame:SetWidth(size)
	self.iconFrame:SetHeight(size)
	local font,_,flags = MoneyFuFrameGoldText:GetFont()
	if font ~= nil then
		MoneyFuFrameGoldText:SetFont(font, size, flags)
		MoneyFuFrameSilverText:SetFont(font, size, flags)
		MoneyFuFrameCopperText:SetFont(font, size, flags)
		self.textFrame:SetFont(font, size)
	end
	self:UpdateText()
end

local offset
function MoneyFu:GetServerOffset()
	if offset then
		return offset
	end
	local serverHour, serverMinute = GetGameTime()
	local utcHour = tonumber(date("!%H"))
	local utcMinute = tonumber(date("!%M"))
	local ser = serverHour + serverMinute / 60
	local utc = utcHour + utcMinute / 60
	offset = floor((ser - utc) * 2 + 0.5) / 2
	if offset >= 12 then
		offset = offset - 24
	elseif offset < -12 then
		offset = offset + 24
	end
	return offset
end

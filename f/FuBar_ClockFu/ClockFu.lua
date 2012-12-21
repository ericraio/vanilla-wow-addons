local Tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.0"):new("FuBar_ClockFu")

ClockFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

ClockFu:RegisterDB("ClockFuDB")
ClockFu:RegisterDefaults('profile', {
	twentyFour = false,
	showSeconds = false,
	localTime = false,
	bothTimes = false,
	bubble = false,
	r = 1,
	g = 1,
	b = 1,
})

ClockFu.version = "2.0." .. string.sub("$Revision: 9785 $", 12, -3)
ClockFu.date = string.sub("$Date: 2006-09-01 15:25:39 -1000 (Fri, 01 Sep 2006) $", 8, 17)
ClockFu.hasIcon = false
ClockFu.defaultPosition = 'RIGHT'
ClockFu.hideWithoutStandby = true
ClockFu.independantProfile = true

function ClockFu:OnInitialize()
	if GroupCalendar_OnLoad then
		self.db.profile.bubble = true
	end
end

function ClockFu:OnEnable()
	self.timeSinceLastUpdate = 0
	self.secondsDifference = 0
	_,self.lastMinute = GetGameTime()
	if not self:IsShowingBubble() then
		self.db.profile.bubble = true
		self:ToggleShowingBubble()
	end
	self:ScheduleRepeatingEvent(self.Update, 1, self)
end

function ClockFu:OnDisable()
	if not self:IsShowingBubble() then
		self:ToggleShowingBubble()
		self.db.profile.bubble = not self.db.profile.bubble
	end
end

function ClockFu:GetColor()
	return self.db.profile.r, self.db.profile.g, self.db.profile.b
end

function ClockFu:GetHexColor()
	return string.format("%02x%02x%02x", self.db.profile.r * 255, self.db.profile.g * 255, self.db.profile.b * 255)
end

function ClockFu:SetColor(r, g, b)
	self.db.profile.r = r
	self.db.profile.g = g
	self.db.profile.b = b
	self:UpdateText()
end

function ClockFu:IsTwentyFour()
	return self.db.profile.twentyFour
end

function ClockFu:ToggleTwentyFour()
	self.db.profile.twentyFour = not self.db.profile.twentyFour
	self:Update()
	return self.db.profile.twentyFour
end

function ClockFu:IsShowingSeconds()
	return self.db.profile.showSeconds
end

function ClockFu:ToggleShowingSeconds()
	self.db.profile.showSeconds = not self.db.profile.showSeconds
	self:Update()
	return self.db.profile.showSeconds
end

function ClockFu:IsLocalTime()
	return self.db.profile.localTime
end

function ClockFu:ToggleLocalTime()
	self.db.profile.localTime = not self.db.profile.localTime
	self:Update()
	return self.db.profile.localTime
end

function ClockFu:IsBothTimes()
	return self.db.profile.bothTimes
end

function ClockFu:ToggleBothTimes()
	self.db.profile.bothTimes = not self.db.profile.bothTimes
	self:Update()
	return self.db.profile.bothTimes
end

function ClockFu:IsShowingBubble()
	return self.db.profile.bubble
end

function ClockFu:ToggleShowingBubble()
	self.db.profile.bubble = not self.db.profile.bubble
	if not self.db.profile.bubble then
		GameTimeFrame:Hide()
	else
		GameTimeFrame:Show()
	end
	return self.db.profile.bubble
end

function ClockFu:GetLocalOffset()
	if self.localOffset ~= nil then
		return self.localOffset
	end
	local localHour = tonumber(date("%H"))
	local localMinute = tonumber(date("%M"))
	local utcHour = tonumber(date("!%H"))
	local utcMinute = tonumber(date("!%M"))
	local loc = localHour + localMinute / 60
	local utc = utcHour + utcMinute / 60
	self.localOffset = floor((loc - utc) * 2 + 0.5) / 2
	if self.localOffset >= 12 then
		self.localOffset = self.localOffset - 24
	end
	return self.localOffset
end

function ClockFu:GetServerOffset()
	if self.serverOffset ~= nil then
		return self.serverOffset
	end
	local serverHour, serverMinute = GetGameTime()
	local utcHour = tonumber(date("!%H"))
	local utcMinute = tonumber(date("!%M"))
	local ser = serverHour + serverMinute / 60
	local utc = utcHour + utcMinute / 60
	self.serverOffset = floor((ser - utc) * 2 + 0.5) / 2
	if self.serverOffset >= 12 then
		self.serverOffset = self.serverOffset - 24
	elseif self.serverOffset < -12 then
		self.serverOffset = self.serverOffset + 24
	end
	return self.serverOffset
end

local optionsTable = {
	handler = ClockFu,
	type = 'group',
	args = {
		twentyFour = {
			type = 'toggle',
			name = L["24-hour format"],
			desc = L["Toggle between 12-hour and 24-hour format"],
			get = "IsTwentyFour",
			set = "ToggleTwentyFour",
		},
		seconds = {
			type = 'toggle',
			name = L["Show seconds"],
			desc = L["Show seconds"],
			get = "IsShowingSeconds",
			set = "ToggleShowingSeconds",
		},
		["local"] = {
			type = 'toggle',
			name = L["Local time"],
			desc = L["Toggle between local time and server time"],
			get = "IsLocalTime",
			set = "ToggleLocalTime",
		},
		both = {
			type = 'toggle',
			name = L["Both times"],
			desc = L["Toggle between showing two times or just one"],
			get = "IsBothTimes",
			set = "ToggleBothTimes",
		},
		bubble = {
			type = 'toggle',
			name = L["Show day/night bubble"],
			desc = L["Show the day/night bubble on the upper-right corner of the minimap"],
			get = "IsShowingBubble",
			set = "ToggleShowingBubble",
		},
		color = {
			type = 'color',
			name = COLOR,
			desc = L["Set the color of the text"],
			get = "GetColor",
			set = "SetColor",
			disabled = function()
				return not ClockFu:IsTextColored()
			end
		}
	}
}
ClockFu:RegisterChatCommand(L:GetTable("AceConsole-commands"), optionsTable)
ClockFu.OnMenuRequest = optionsTable

function ClockFu:FormatTime(hour, minute, second, colorize)
	if self:IsTwentyFour() then
		if not colorize then
			if self:IsShowingSeconds() then
				return string.format("%d:%02d:%02d", hour, minute, second)
			else
				return string.format("%d:%02d", hour, minute)
			end
		else
			local color = self:GetHexColor()
			if self:IsShowingSeconds() then
				return string.format("|cff%s%d|r:|cff%s%02d|r:|cff%s%02d|r", color, hour, color, minute, color, second)
			else
				return string.format("|cff%s%d|r:|cff%s%02d|r", color, hour, color, minute)
			end
		end
	else
		pm = floor(hour / 12) == 1
		hour = mod(hour, 12)
		if hour == 0 then
			hour = 12
		end
		if not colorize then
			if self:IsShowingSeconds() then
				return string.format("%d:%02d:%02d %s", hour, minute, second, pm and " PM" or " AM")
			else
				return string.format("%d:%02d %s", hour, minute, pm and " PM" or " AM")
			end
		else
			local color = self:GetHexColor()
			if self:IsShowingSeconds() then
				return string.format("|cff%s%d|r:|cff%s%02d|r:|cff%s%02d|r %s", color, hour, color, minute, color, second, pm and " PM" or " AM")
			else
				return string.format("|cff%s%d|r:|cff%s%02d|r %s", color, hour, color, minute, pm and " PM" or " AM")
			end
		end
	end
end

function ClockFu:GetServerTime(colorize)
	local hour, minute = GetGameTime()
	if self.lastMinute ~= minute then
		_,self.lastMinute = GetGameTime()
		self.secondsDifference = mod(time(), 60)
	end
	local second = mod(time() - self.secondsDifference, 60)
	return self:FormatTime(hour, minute, second, colorize)
end

function ClockFu:GetLocalTime(colorize)
	local hour = tonumber(date("%H"))
	local minute = tonumber(date("%M"))
	local second = tonumber(date("%S"))
	return self:FormatTime(hour, minute, second, colorize)
end

function ClockFu:GetUtcTime()
	local hour = tonumber(date("!%H"))
	local minute = tonumber(date("!%M"))
	local second = tonumber(date("!%S"))
	return self:FormatTime(hour, minute, second)
end

function ClockFu:OnTextUpdate()
	local hour, minute = GetGameTime()
	if self.lastMinute ~= minute then
		_,self.lastMinute = GetGameTime()
		self.secondsDifference = mod(time(), 60)
	end
	if self:IsBothTimes() then
		if self:IsLocalTime() then
			self:SetText(string.format("%s || %s", self:GetLocalTime(true), self:GetServerTime(true)))
		else
			self:SetText(string.format("%s || %s", self:GetServerTime(true), self:GetLocalTime(true)))
		end
	elseif self:IsLocalTime() then
		self:SetText(self:GetLocalTime(true))
	else
		self:SetText(self:GetServerTime(true))
	end
end

function ClockFu:OnTooltipUpdate()
	local s = self:GetServerOffset()
	local l = self:GetLocalOffset()
	
	local cat = Tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	cat:AddLine(
		'text', string.format(L["Local time"] .. " (%+03d:%02d)", l, mod(l * 60, 60)),
		'text2', self:GetLocalTime()
	)
	cat:AddLine(
		'text', string.format(L["Server time"] .. " (%+03d:%02d)", s, mod(s * 60, 60)),
		'text2', self:GetServerTime()
	)
	cat:AddLine(
		'text', L["UTC"],
		'text2', self:GetUtcTime()
	)
	
	Tablet:AddCategory():AddLine(
		'text', date("%A, %B %d, %Y"),
		'textR', 1,
		'textG', 1,
		'textB', 1,
		'justify', "CENTER"
	)
end
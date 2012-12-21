local L = AceLibrary("AceLocale-2.0"):new("FuBar_PerformanceFu")
local Tablet = AceLibrary("Tablet-2.0")
local Abacus = AceLibrary("Abacus-2.0")
local Crayon = AceLibrary("Crayon-2.0")

PerformanceFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0")

PerformanceFu.version = "2.0" .. string.sub("$Revision: 7559 $", 12, -3)
PerformanceFu.date = string.sub("$Date: 2006-08-09 22:43:29 -1000 (Wed, 09 Aug 2006) $", 8, 17)
PerformanceFu.hasIcon = true

local string_format = string.format
local table_concat = table.concat
local table_insert = table.insert
local table_setn = table.setn

PerformanceFu:RegisterDB("PerformanceFuDB")
PerformanceFu:RegisterDefaults("profile", {
	showFramerate = true,
	showLatency = true,
	showMemory = true,
	showRate = true,
	warnGC = false,
})

function PerformanceFu:IsShowingFramerate()
	return self.db.profile.showFramerate
end

function PerformanceFu:ToggleShowingFramerate()
	self.db.profile.showFramerate = not self.db.profile.showFramerate
	self:Update()
end

function PerformanceFu:IsShowingLatency()
	return self.db.profile.showLatency
end

function PerformanceFu:ToggleShowingLatency()
	self.db.profile.showLatency = not self.db.profile.showLatency
	self:Update()
end

function PerformanceFu:IsShowingRate()
	return self.db.profile.showRate
end

function PerformanceFu:ToggleShowingRate()
	self.db.profile.showRate = not self.db.profile.showRate
	self:Update()
end

function PerformanceFu:IsShowingMemory()
	return self.db.profile.showMemory
end

function PerformanceFu:ToggleShowingMemory()
	self.db.profile.showMemory = not self.db.profile.showMemory
	self:Update()
end

function PerformanceFu:IsWarningOnGC()
	return self.db.profile.warnGC
end

function PerformanceFu:ToggleWarningOnGC()
	self.db.profile.warnGC = not self.db.profile.warnGC
end

local beeps5 = 0
local beeps15 = 0
local beeps30 = 0
local beeps60 = 0
local beeps180 = 0
local beeps600 = 0

local initialMemory, gcThreshold, currentMemory
local mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10
local timeSinceLastUpdate
local justEntered
local gcTime

function PerformanceFu:OnEnable()
	initialMemory, gcThreshold = gcinfo()
	currentMemory = initialMemory
	mem1 = currentMemory
	mem2 = currentMemory
	mem3 = currentMemory
	mem4 = currentMemory
	mem5 = currentMemory
	mem6 = currentMemory
	mem7 = currentMemory
	mem8 = currentMemory
	mem9 = currentMemory
	mem10 = currentMemory
	timeSinceLastUpdate = 0
	gcTime = time()
	justEntered = true
	self:ScheduleRepeatingEvent(self.OnUpdate, 1, self)
end

local options = {
	type = 'group',
	args = {
		framerate = {
			type = 'toggle',
			name = L"Show framerate",
			desc = L"Toggle whether to framerate",
			get = "IsShowingFramerate",
			set = "ToggleShowingFramerate",
		},
		latency = {
			type = 'toggle',
			name = L"Show latency",
			desc = L"Toggle whether to latency (lag)",
			get = "IsShowingLatency",
			set = "ToggleShowingLatency",
		},
		memory = {
			type = 'toggle',
			name = L"Show memory usage",
			desc = L"Toggle whether to show current memory usage",
			get = "IsShowingMemory",
			set = "ToggleShowingMemory",
		},
		rate = {
			type = 'toggle',
			name = L"Show rate of increasing memory usage",
			desc = L"Toggle whether to show increasing rate of memory",
			get = "IsShowingRate",
			set = "ToggleShowingRate",
		},
		warn = {
			type = 'toggle',
			name = L"Warn on garbage collection",
			desc = L"Toggle whether to warn on an upcoming garbage collection",
			get = "IsWarningOnGC",
			set = "ToggleWarningOnGC",
		},
		forcegc = {
			type = 'execute',
			name = L"Force garbage collection",
			desc = L"Force a garbage collection to happen",
			order = 101,
			func = collectgarbage
		}
	}
}
PerformanceFu:RegisterChatCommand(L:GetTable("AceConsole-options"), options)
PerformanceFu.OnMenuRequest = options

local gccheck = setmetatable({[{}]=true}, {__mode = "k"})

function PerformanceFu:OnUpdate()
	if justEntered then
		if not timeSinceLastUpdate then
			timeSinceLastUpdate = 0
		end
		timeSinceLastUpdate = timeSinceLastUpdate + 1
		if timeSinceLastUpdate >= 10 then
			initialMemory, gcThreshold = gcinfo()
			currentMemory = initialMemory
			mem1 = currentMemory
			mem2 = currentMemory
			mem3 = currentMemory
			mem4 = currentMemory
			mem5 = currentMemory
			mem6 = currentMemory
			mem7 = currentMemory
			mem8 = currentMemory
			mem9 = currentMemory
			mem10 = currentMemory
			timeSinceLastUpdate = nil
			gcTime = time()
			justEntered = false
		end
	else
		local t = time()
		timeSinceLastUpdate = 0
		mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10 =
			currentMemory, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9
		currentMemory, gcThreshold = gcinfo()
		if not next(gccheck) then
			gccheck[{}] = true
			initialMemory = currentMemory
			gcTime = t
			mem10, mem9, mem9, mem8, mem7, mem6, mem5, mem4, mem3, mem2, mem1 =
				currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory
			beeps5 = 0
			beeps5 = 0
			beeps15 = 0
			beeps30 = 0
			beeps60 = 0
			beeps180 = 0
			beeps600 = 0
			if self:IsWarningOnGC() then
				self:Print(L"Garbage collection occurred")
			end
		end
		local averageRate = (currentMemory - initialMemory) / (t - gcTime)
		local totalSecs = (gcThreshold - currentMemory) / averageRate
		if self:IsWarningOnGC() then
			if totalSecs <= 5 and beeps5 < t - 15 then
				self:Print(L"Garbage collection in %s", Abacus:FormatDurationShort(totalSecs, false, true))
				beeps600 = t
				beeps180 = t
				beeps60 = t
				beeps30 = t
				beeps15 = t
				beeps5 = t
			elseif totalSecs <= 15 and beeps15 < t - 30 then
				self:Print(L"Garbage collection in %s", Abacus:FormatDurationShort(totalSecs, false, true))
				beeps600 = t
				beeps180 = t
				beeps60 = t
				beeps30 = t
				beeps15 = t
			elseif totalSecs <= 30 and beeps30 < t - 45 then
				self:Print(L"Garbage collection in %s", Abacus:FormatDurationShort(totalSecs, false, true))
				beeps600 = t
				beeps180 = t
				beeps60 = t
				beeps30 = t
			elseif totalSecs <= 60 and beeps60 < t - 90 then
				self:Print(L"Garbage collection in %s", Abacus:FormatDurationShort(totalSecs, false, true))
				beeps600 = t
				beeps180 = t
				beeps60 = t
			elseif totalSecs <= 180 and beeps180 < t - 270 then
				self:Print(L"Garbage collection in %s", Abacus:FormatDurationShort(totalSecs, false, true))
				beeps600 = t
				beeps180 = t
			elseif totalSecs <= 600 and beeps600 < t - 900 then
				self:Print(L"Garbage collection in %s", Abacus:FormatDurationShort(totalSecs, false, true))
				beeps600 = t
			end
		end
		self:Update()
	end
end

local t = {}
function PerformanceFu:OnTextUpdate()
	if not mem10 then
		mem10 = currentMemory
	end
	local currentRate = (currentMemory - mem10) / 10
	
	if self:IsShowingFramerate() then
		local framerate = floor(GetFramerate() + 0.5)
		table_insert(t, format("|cff%s%d|r fps", Crayon:GetThresholdHexColor(framerate / 60), framerate))
	end
	if self:IsShowingLatency() then
		local _,_,latency = GetNetStats()
		table_insert(t, format("|cff%s%d|r ms", Crayon:GetThresholdHexColor(latency, 1000, 500, 250, 100, 0), latency))
	end
	if self:IsShowingMemory() then
		table_insert(t, format("|cff%s%.1f|r MiB", Crayon:GetThresholdHexColor(currentMemory, 51200, 40960, 30520, 20480, 10240), currentMemory / 1024))
	end
	if self:IsShowingRate() then
		table_insert(t, format("|cff%s%.1f|r KiB/s", Crayon:GetThresholdHexColor(currentRate, 30, 10, 3, 1, 0), currentRate))
	end
	self:SetText(table_concat(t, " "))
	for k in pairs(t) do
		t[k] = nil
		k = nil
	end
	table_setn(t, 0)
end

function PerformanceFu:OnTooltipUpdate()
	local cat = Tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0
	)
	local framerate = GetFramerate()
	local r, g, b = Crayon:GetThresholdColor(framerate / 60)
	cat:AddLine(
		'text', L"Framerate:",
		'text2', string_format("%.1f fps", framerate),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	cat = Tablet:AddCategory(
		'text', L"Network status",
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	local bandwidthIn, bandwidthOut, latency = GetNetStats()
	bandwidthIn, bandwidthOut = bandwidthIn * 1024, bandwidthOut * 1024
	local r, g, b = Crayon:GetThresholdColor(latency, 3000, 1000, 250, 100, 0)
	cat:AddLine(
		'text', L"Latency:",
		'text2', string_format("%d ms", latency),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	cat:AddLine(
		'text', L"Bandwidth in:",
		'text2', string_format("%d B/s", bandwidthIn)
	)
	
	cat:AddLine(
		'text', L"Bandwidth out:",
		'text2', string_format("%d B/s", bandwidthOut)
	)
	
	local averageRate = (currentMemory - initialMemory) / (time() - gcTime)
	cat = Tablet:AddCategory(
		'text', L"Memory usage",
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	local currentRate = (currentMemory - mem10) / 10
	
	local r, g, b = Crayon:GetThresholdColor(currentMemory, 51200, 40960, 30520, 20480, 10240)
	cat:AddLine(
		'text', L"Current memory:",
		'text2', string_format("%.1f MiB", currentMemory / 1024),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	r, g, b = Crayon:GetThresholdColor(initialMemory, 51200, 40960, 30520, 20480, 10240)
	cat:AddLine(
		'text', L"Initial memory:",
		'text2', string_format("%.1f MiB", initialMemory / 1024),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	r, g, b = Crayon:GetThresholdColor(currentRate, 30, 10, 3, 1, 0)
	cat:AddLine(
		'text', L"Increasing rate:",
		'text2', string_format("%.1f KiB/s", currentRate),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	r, g, b = Crayon:GetThresholdColor(averageRate, 30, 10, 3, 1, 0)
	cat:AddLine(
		'text', L"Average increasing rate:",
		'text2', format("%.1f KiB/s", averageRate),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	cat = Tablet:AddCategory(
		'text', L"Garbage collection",
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	
	local totalSecs = (gcThreshold - currentMemory) / averageRate
	local timeToNext = Abacus:FormatDurationFull(totalSecs)
	
	local r, g, b = Crayon:GetThresholdColor(gcThreshold, 51200, 40960, 30520, 20480, 10240)
	cat:AddLine(
		'text', L"Threshold:",
		'text2', format("%.1f MiB", gcThreshold / 1024),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
	
	local r, g, b = Crayon:GetThresholdColor(totalSecs, 0, 900, 1800, 2700, 3600)
	cat:AddLine(
		'text', L"Time to next:",
		'text2', timeToNext,
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
end

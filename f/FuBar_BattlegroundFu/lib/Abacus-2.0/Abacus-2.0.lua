--[[
Name: Abacus-2.0
Revision: $Rev: 11599 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Abacus-2.0
SVN: http://svn.wowace.com/root/trunk/AbacusLib/Abacus-2.0
Description: A library to provide tools for formatting money and time.
Dependencies: AceLibrary
]]

local MAJOR_VERSION = "Abacus-2.0"
local MINOR_VERSION = "$Revision: 11599 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local Abacus = {}

local table_setn
do
	local version = GetBuildInfo()
	if string.find(version, "^2%.") then
		-- 2.0.0
		table_setn = function() end
	else
		table_setn = table.setn
	end
end

local COPPER_ABBR = string.lower(string.sub(COPPER, 1, 1))
local SILVER_ABBR = string.lower(string.sub(SILVER, 1, 1))
local GOLD_ABBR = string.lower(string.sub(GOLD, 1, 1))
if (string.byte(COPPER_ABBR) or 128) > 127 then
	-- non-western
	COPPER_ABBR = COPPER
	SILVER_ABBR = SILVER
	GOLD_ABBR = GOLD
end

local COLOR_WHITE = "ffffff"
local COLOR_GREEN = "00ff00"
local COLOR_RED = "ff0000"
local COLOR_COPPER = "eda55f"
local COLOR_SILVER = "c7c7cf"
local COLOR_GOLD = "ffd700"

local L_DAY_ONELETTER_ABBR    = string.sub(DAY_ONELETTER_ABBR, 4)
local L_HOUR_ONELETTER_ABBR   = string.sub(HOUR_ONELETTER_ABBR, 4) 
local L_MINUTE_ONELETTER_ABBR = string.sub(MINUTE_ONELETTER_ABBR, 4)
local L_SECOND_ONELETTER_ABBR = string.sub(SECOND_ONELETTER_ABBR, 4)

local inf = 1/0

function Abacus:FormatMoneyExtended(value, colorize, textColor)
	self:argCheck(value, 2, "number")
	local gold = value / 10000
	local silver = abs(mod(value / 100, 100))
	local copper = abs(mod(value, 100))
	
	local color = COLOR_WHITE
	if textColor then
		if value > 0 then
			color = COLOR_GREEN
		elseif value < 0 then
			color = COLOR_RED
		end
	end
	if colorize then
		if value == inf or value == -inf then
			return format("|cff%s%s|r", color, value)
		elseif value ~= value then
			return format("|cff%s0|r|cff%s %s|r", COLOR_WHITE, COLOR_COPPER, COPPER)
		elseif value >= 10000 or value <= -10000 then
			return format("|cff%s%d|r|cff%s %s|r |cff%s%d|r|cff%s %s|r |cff%s%d|r|cff%s %s|r", color, gold, COLOR_GOLD, GOLD, color, silver, COLOR_SILVER, SILVER, color, copper, COLOR_COPPER, COPPER)
		elseif value >= 100 or value <= -100 then
			return format("|cff%s%d|r|cff%s %s|r |cff%s%d|r|cff%s %s|r", color, silver, COLOR_SILVER, SILVER, color, copper, COLOR_COPPER, COPPER)
		else
			return format("|cff%s%d|r|cff%s %s|r", color, copper, COLOR_COPPER, COPPER)
		end
	else
		if value == inf or value == -inf then
			return format("%s", value)
		elseif value ~= value then
			return format("0 %s", COPPER)
		elseif value >= 10000 or value <= -10000 then
			return format("%d %s %d %s %d %s", gold, GOLD, silver, SILVER, copper, COPPER)
		elseif value >= 100 or value <= -100 then
			return format("%d %s %d %s", silver, SILVER, copper, COPPER)
		else
			return format("%d %s", copper, COPPER)
		end
	end
end

function Abacus:FormatMoneyFull(value, colorize, textColor)
	self:argCheck(value, 2, "number")
	local gold = value / 10000
	local silver = abs(mod(value / 100, 100))
	local copper = abs(mod(value, 100))
	
	local color = COLOR_WHITE
	if textColor then
		if value > 0 then
			color = COLOR_GREEN
		elseif value < 0 then
			color = COLOR_RED
		end
	end
	if colorize then
		if value == inf or value == -inf then
			return format("|cff%s%s|r", color, value)
		elseif value ~= value then
			return format("|cff%s0|r|cff%s%s|r", COLOR_WHITE, COLOR_COPPER, COPPER_ABBR)
		elseif value >= 10000 or value <= -10000 then
			return format("|cff%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r", color, gold, COLOR_GOLD, GOLD_ABBR, color, silver, COLOR_SILVER, SILVER_ABBR, color, copper, COLOR_COPPER, COPPER_ABBR)
		elseif value >= 100 or value <= -100 then
			return format("|cff%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r", color, silver, COLOR_SILVER, SILVER_ABBR, color, copper, COLOR_COPPER, COPPER_ABBR)
		else
			return format("|cff%s%d|r|cff%s%s|r", color, copper, COLOR_COPPER, COPPER_ABBR)
		end
	else
		if value == inf or value == -inf then
			return format("%s", value)
		elseif value ~= value then
			return format("0%s", COPPER_ABBR)
		elseif value >= 10000 or value <= -10000 then
			return format("%d%s %d%s %d%s", gold, GOLD_ABBR, silver, SILVER_ABBR, copper, COPPER_ABBR)
		elseif value >= 100 or value <= -100 then
			return format("%d%s %d%s", silver, SILVER_ABBR, copper, COPPER_ABBR)
		else
			return format("%d%s", copper, COPPER_ABBR)
		end
	end
end

function Abacus:FormatMoneyShort(copper, colorize, textColor)
	self:argCheck(copper, 2, "number")
	local color = COLOR_WHITE
	if textColor then
		if copper > 0 then
			color = COLOR_GREEN
		elseif copper < 0 then
			color = COLOR_RED
		end
	end
	if colorize then
		if value == inf or value == -inf then
			return format("|cff%s%s|r", color, value)
		elseif value ~= value then
			return format("|cff%s0|r|cff%s%s|r", COLOR_WHITE, COLOR_COPPER, COPPER_ABBR)
		elseif copper >= 10000 or copper <= -10000 then
			return format("|cff%s%.1f|r|cff%s%s|r", color, copper / 10000, COLOR_GOLD, GOLD_ABBR)
		elseif copper >= 100 or copper <= -100 then
			return format("|cff%s%.1f|r|cff%s%s|r", color, copper / 100, COLOR_SILVER, SILVER_ABBR)
		else
			return format("|cff%s%d|r|cff%s%s|r", color, copper, COLOR_COPPER, COPPER_ABBR)
		end
	else
		if value == inf or value == -inf then
			return format("%s", value)
		elseif value ~= value then
			return format("0%s", COPPER_ABBR)
		elseif copper >= 10000 or copper <= -10000 then
			return format("%.1f%s", copper / 10000, GOLD_ABBR)
		elseif copper >= 100 or copper <= -100 then
			return format("%.1f%s", copper / 100, SILVER_ABBR)
		else
			return format("%.0f%s", copper, COPPER_ABBR)
		end
	end
end

function Abacus:FormatMoneyCondensed(value, colorize, textColor)
	self:argCheck(value, 2, "number")
	local negl = value < 0 and "(-" or ""
	local negr = value < 0 and ")" or ""
	if value < 0 then
		if colorize and textColor then
			negl = "|cffff0000-(|r"
			negr = "|cffff0000)|r"
		else
			negl = "-("
			negr = ")"
		end
	else
		negl = ""
		negr = ""
	end
	local gold = floor(math.abs(value) / 10000)
	local silver = mod(floor(math.abs(value) / 100), 100)
	local copper = mod(floor(math.abs(value)), 100)
	if colorize then
		if value == inf or value == -inf then
			return format("%s|cff%s%s|r%s", negl, COLOR_COPPER, math.abs(value), negr)
		elseif value ~= value then
			return format("|cff%s0|r", COLOR_COPPER)
		elseif gold ~= 0 then
			return format("%s|cff%s%d|r.|cff%s%02d|r.|cff%s%02d|r%s", negl, COLOR_GOLD, gold, COLOR_SILVER, silver, COLOR_COPPER, copper, negr)
		elseif silver ~= 0 then
			return format("%s|cff%s%d|r.|cff%s%02d|r%s", negl, COLOR_SILVER, silver, COLOR_COPPER, copper, negr)
		else
			return format("%s|cff%s%d|r%s", negl, COLOR_COPPER, copper, negr)
		end
	else
		if value == inf or value == -inf then
			return tostring(value)
		elseif value ~= value then
			return "0"
		elseif gold ~= 0 then
			return format("%s%d.%02d.%02d%s", negl, gold, silver, copper, negr)
		elseif silver ~= 0 then
			return format("%s%d.%02d%s", negl, silver, copper, negr)
		else
			return format("%s%d%s", negl, copper, negr)
		end
	end
end

local t
function Abacus:FormatDurationExtended(duration, colorize, hideSeconds)
	self:argCheck(duration, 2, "number")
	local negative = ""
	if duration ~= duration then
		duration = 0
	end
	if duration < 0 then
		negative = "-"
		duration = -duration
	end
	local days = floor(duration / 86400)
	local hours = mod(floor(duration / 3600), 24)
	local mins = mod(floor(duration / 60), 60)
	local secs = mod(floor(duration), 60)
	if not t then
		t = {}
	else
		for k in pairs(t) do
			t[k] = nil
		end
		table_setn(t, 0)
	end
	if not colorize then
		if not duration or duration > 86400*365 then
			return "Undetermined"
		end
		if days > 1 then
			table.insert(t, format("%d %s", days, DAYS_ABBR_P1))
		elseif days == 1 then
			table.insert(t, format("%d %s", days, DAYS_ABBR))
		end
		if hours > 1 then
			table.insert(t, format("%d %s", hours, HOURS_ABBR_P1))
		elseif hours == 1 then
			table.insert(t, format("%d %s", hours, HOURS_ABBR))
		end
		if mins > 1 then
			table.insert(t, format("%d %s", mins, MINUTES_ABBR_P1))
		elseif mins == 1 then
			table.insert(t, format("%d %s", mins, MINUTES_ABBR))
		end
		if not hideSeconds then
			if secs > 1 then
				table.insert(t, format("%d %s", secs, SECONDS_ABBR_P1))
			elseif secs == 1 then
				table.insert(t, format("%d %s", secs, SECONDS_ABBR))
			end
		end
		if table.getn(t) == 0 then
			if not hideSeconds then
				return "0 " .. SECONDS_ABBR_P1
			else
				return "0 " .. MINUTES_ABBR_P1
			end
		else
			return negative .. table.concat(t, " ")
		end
	else
		if not duration or duration > 86400*365 then
			return "|cffffffffUndetermined|r"
		end
		if days > 1 then
			table.insert(t, format("|cffffffff%d|r %s", days, DAYS_ABBR_P1))
		elseif days == 1 then
			table.insert(t, format("|cffffffff%d|r %s", days, DAYS_ABBR))
		end
		if hours > 1 then
			table.insert(t, format("|cffffffff%d|r %s", hours, HOURS_ABBR_P1))
		elseif hours == 1 then
			table.insert(t, format("|cffffffff%d|r %s", hours, HOURS_ABBR))
		end
		if mins > 1 then
			table.insert(t, format("|cffffffff%d|r %s", mins, MINUTES_ABBR_P1))
		elseif mins == 1 then
			table.insert(t, format("|cffffffff%d|r %s", mins, MINUTES_ABBR))
		end
		if not hideSeconds then
			if secs > 1 then
				table.insert(t, format("|cffffffff%d|r %s", secs, SECONDS_ABBR_P1))
			elseif secs == 1 then
				table.insert(t, format("|cffffffff%d|r %s", secs, SECONDS_ABBR))
			end
		end
		if table.getn(t) == 0 then
			if not hideSeconds then
				return "|cffffffff0|r " .. SECONDS_ABBR_P1
			else
				return "|cffffffff0|r " .. MINUTES_ABBR_P1
			end
		elseif negative == "-" then
			return "|cffffffff-|r" .. table.concat(t, " ")
		else
			return table.concat(t, " ")
		end
	end
end

local DAY_ONELETTER_ABBR = string.gsub(DAY_ONELETTER_ABBR, "%s*%%d%s*", "")
local HOUR_ONELETTER_ABBR = string.gsub(HOUR_ONELETTER_ABBR, "%s*%%d%s*", "")
local MINUTE_ONELETTER_ABBR = string.gsub(MINUTE_ONELETTER_ABBR, "%s*%%d%s*", "")
local SECOND_ONELETTER_ABBR = string.gsub(SECOND_ONELETTER_ABBR, "%s*%%d%s*", "")

function Abacus:FormatDurationFull(duration, colorize, hideSeconds)
	self:argCheck(duration, 2, "number")
	local negative = ""
	if duration ~= duration then
		duration = 0
	end
	if duration < 0 then
		negative = "-"
		duration = -duration
	end
	if not colorize then
		if not hideSeconds then
			if not duration or duration > 86400*365 then
				return "Undetermined"
			elseif duration >= 86400 then
				return format("%s%d%s %02d%s %02d%s %02d%s", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR, mod(duration, 60), L_SECOND_ONELETTER_ABBR)
			elseif duration >= 3600 then
				return format("%s%d%s %02d%s %02d%s", negative, duration/3600, L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR, mod(duration, 60), L_SECOND_ONELETTER_ABBR)
			elseif duration >= 120 then
				return format("%s%d%s %02d%s", negative, duration/60, L_MINUTE_ONELETTER_ABBR, mod(duration, 60), L_SECOND_ONELETTER_ABBR)
			else
				return format("%s%d%s", negative, duration, L_SECOND_ONELETTER_ABBR)
			end
		else
			if not duration or duration > 86400*365 then
				return "Undetermined"
			elseif duration >= 86400 then
				return format("%s%d%s %02d%s %02d%s", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR)
			elseif duration >= 3600 then
				return format("%s%d%s %02d%s", negative, duration/3600, L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR)
			else
				return format("%s%d%s", negative, duration/60, L_MINUTE_ONELETTER_ABBR)
			end
		end
	else
		if not hideSeconds then
			if not duration or duration > 86400*365 then
				return "|cffffffffUndetermined|r"
			elseif duration >= 86400 then
				return format("|cffffffff%s%d|r%s |cffffffff%02d|r%s |cffffffff%02d|r%s |cffffffff%02d|r%s", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR, mod(duration, 60), L_SECOND_ONELETTER_ABBR)
			elseif duration >= 3600 then
				return format("|cffffffff%s%d|r%s |cffffffff%02d|r%s |cffffffff%02d|r%s", negative, duration/3600, L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR, mod(duration, 60), L_SECOND_ONELETTER_ABBR)
			elseif duration >= 120 then
				return format("|cffffffff%s%d|r%s |cffffffff%02d|r%s", negative, duration/60, L_MINUTE_ONELETTER_ABBR, mod(duration, 60), L_SECOND_ONELETTER_ABBR)
			else
				return format("|cffffffff%s%d|r%s", negative, duration, L_SECOND_ONELETTER_ABBR)
			end
		else
			if not duration or duration > 86400*365 then
				return "|cffffffffUndetermined|r"
			elseif duration >= 86400 then
				return format("|cffffffff%s%d|r%s |cffffffff%02d|r%s |cffffffff%02d|r%s", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR)
			elseif duration >= 3600 then
				return format("|cffffffff%s%d|r%s |cffffffff%02d|r%s", negative, duration/3600, L_HOUR_ONELETTER_ABBR, mod(duration/60, 60), L_MINUTE_ONELETTER_ABBR)
			else
				return format("|cffffffff%s%d|r%s", negative, duration/60, L_MINUTE_ONELETTER_ABBR)
			end
		end
	end
end

function Abacus:FormatDurationShort(duration, colorize, hideSeconds)
	self:argCheck(duration, 2, "number")
	local negative = ""
	if duration ~= duration then
		duration = 0
	end
	if duration < 0 then
		negative = "-"
		duration = -duration
	end
	if not colorize then
		if not duration or duration >= 86400*365 then
			return "***"
		elseif duration >= 172800 then
			return format("%s%.1f %s", negative, duration/86400, DAYS_ABBR_P1)
		elseif duration >= 7200 then
			return format("%s%.1f %s", negative, duration/3600, HOURS_ABBR_P1)
		elseif duration >= 120 or not hideSeconds then
			return format("%s%.1f %s", negative, duration/60, MINUTES_ABBR_P1)
		else
			return format("%s%.0f %s", negative, duration, SECONDS_ABBR_P1)
		end
	else
		if not duration or duration >= 86400*365 then
			return "|cffffffff***|r"
		elseif duration >= 172800 then
			return format("|cffffffff%s%.1f|r %s", negative, duration/86400, DAYS_ABBR_P1)
		elseif duration >= 7200 then
			return format("|cffffffff%s%.1f|r %s", negative, duration/3600, HOURS_ABBR_P1)
		elseif duration >= 120 or not hideSeconds then
			return format("|cffffffff%s%.1f|r %s", negative, duration/60, MINUTES_ABBR_P1)
		else
			return format("|cffffffff%s%.0f|r %s", negative, duration, SECONDS_ABBR_P1)
		end
	end
end

function Abacus:FormatDurationCondensed(duration, colorize, hideSeconds)
	self:argCheck(duration, 2, "number")
	local negative = ""
	if duration ~= duration then
		duration = 0
	end
	if duration < 0 then
		negative = "-"
		duration = -duration
	end
	if not colorize then
		if hideSeconds then
			if not duration or duration >= 86400*365 then
				return format("%s**%s **:**", negative, L_DAY_ONELETTER_ABBR)
			elseif duration >= 86400 then
				return format("%s%d%s %d:%02d", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), mod(duration/60, 60))
			else
				return format("%s%d:%02d", negative, duration/3600, mod(duration/60, 60))
			end
		else
			if not duration or duration >= 86400*365 then
				return negative .. "**:**:**:**"
			elseif duration >= 86400 then
				return format("%s%d%s %d:%02d:%02d", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), mod(duration/60, 60), mod(duration, 60))
			elseif duration >= 3600 then
				return format("%s%d:%02d:%02d", negative, duration/3600, mod(duration/60, 60), mod(duration, 60))
			else
				return format("%s%d:%02d", negative, duration/60, mod(duration, 60))
			end
		end
	else
		if hideSeconds then
			if not duration or duration >= 86400*365 then
				return format("|cffffffff%s**|r%s |cffffffff**|r:|cffffffff**|r", negative, L_DAY_ONELETTER_ABBR)
			elseif duration >= 86400 then
				return format("|cffffffff%s%d|r%s |cffffffff%d|r:|cffffffff%02d|r", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), mod(duration/60, 60))
			else
				return format("|cffffffff%s%d|r:|cffffffff%02d|r", negative, duration/3600, mod(duration/60, 60))
			end
		else
			if not duration or duration >= 86400*365 then
				return format("|cffffffff%s**|r%s |cffffffff**|r:|cffffffff**|r:|cffffffff**|r", negative, L_DAY_ONELETTER_ABBR)
			elseif duration >= 86400 then
				return format("|cffffffff%s%d|r%s |cffffffff%d|r:|cffffffff%02d|r:|cffffffff%02d|r", negative, duration/86400, L_DAY_ONELETTER_ABBR, mod(duration/3600, 24), mod(duration/60, 60), mod(duration, 60))
			elseif duration >= 3600 then
				return format("|cffffffff%s%d|r:|cffffffff%02d|r:|cffffffff%02d|r", negative, duration/3600, mod(duration/60, 60), mod(duration, 60))
			else
				return format("|cffffffff%s%d|r:|cffffffff%02d|r", negative, duration/60, mod(duration, 60))
			end
		end
	end
end

AceLibrary:Register(Abacus, MAJOR_VERSION, MINOR_VERSION)
Abacus = nil

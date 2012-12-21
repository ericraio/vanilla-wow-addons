local compost = CompostLib:GetInstance('compost-1')

local COLOR_HEX_RED       = "ff0000"
local COLOR_HEX_ORANGE    = "ff7f00"
local COLOR_HEX_YELLOW    = "ffff00"
local COLOR_HEX_GREEN     = "00ff00"
local COLOR_HEX_WHITE     = "ffffff"
local COLOR_HEX_COPPER    = "eda55f"
local COLOR_HEX_SILVER    = "c7c7cf"
local COLOR_HEX_GOLD      = "ffd700"

local function VersionToNumber(version)
	if version == nil then
		return 0
	elseif type(version) == "number" then
		return version
	end
	local num = 0
	local place = 1
	string.gsub(version, "(%d+)", function (w)
		num = num + tonumber(w) * math.pow(10, place * 2)
		if place > 0 then
			place = place - 1
		else
			place = place - 2
		end
	end)
	return num
end

local function GetVersionPoint(version, point)
	if version == nil then
		return 0
	elseif type(version) == "number" then
		if point == 1 then
			return floor(version / 100)
		elseif point == 2 then
			return mod(floor(version), 100)
		elseif point == 3 then
			return mod(floor(version * 10000), 10000)
		elseif point == 4 then
			return mod(floor(version * 100000000), 10000)
		elseif point < 1 then
			return 0
		elseif point > 4 then
			return mod(floor(version * math.pow(10000, point - 2)), 10000)
		end
	end
	local place = 1
	local num = 0
	string.gsub(version, "(%d+)", function (w)
		if place == point
			then num = tonumber(w)
			return
		end
		place = place + 1
	end)
	return num
end

local function GetMajorNumber(version)
	return GetVersionPoint(version, 1)
end

local function GetMinorNumber(version)
	return GetVersionPoint(version, 2)
end

local function GetRevisionNumber(version)
	return GetVersionPoint(version, 3)
end

local function GetTrivialNumber(version)
	return GetVersionPoint(version, 4)
end

local crayon = CrayonLib:GetInstance('1.0')
local abacus = AbacusLib:GetInstance('1.0')

FuBarUtils = {
	COLOR_HEX_RED = crayon.COLOR_HEX_RED,
	COLOR_HEX_ORANGE = crayon.COLOR_HEX_ORANGE,
	COLOR_HEX_YELLOW = crayon.COLOR_HEX_YELLOW,
	COLOR_HEX_GREEN = crayon.COLOR_HEX_GREEN,
	COLOR_HEX_WHITE = crayon.COLOR_HEX_WHITE,
	COLOR_HEX_COPPER = crayon.COLOR_HEX_COPPER,
	COLOR_HEX_SILVER = crayon.COLOR_HEX_SILVER,
	COLOR_HEX_GOLD = crayon.COLOR_HEX_GOLD,
	
	Colorize = function(hexColor, text)
		return crayon:Colorize(hexColor, text)
	end,
	
	Red = function(text)
		return crayon:Red(text)
	end,
	
	Orange = function(text)
		return crayon:Orange(text)
	end,
	
	Yellow = function(text)
		return crayon:Yellow(text)
	end,
	
	Green = function(text)
		return crayon:Green(text)
	end,
	
	White = function(text)
		return crayon:White(text)
	end,
	
	GetThresholdHexColor = function(quality, a, b, c, d, e)
		return crayon:GetThresholdHexColor(quality, a, b, c, d, e)
	end,
	
	GetThresholdColor = function(quality, a, b, c, d, e)
		return crayon:GetThresholdColor(quality, a, b, c, d, e)
	end,
	
	GetThresholdHexColorTrivial = function(quality, a, b, c, d, e)
		return crayon:GetThresholdHexColorTrivial(quality, a, b, c, d, e)
	end,
	
	GetThresholdColorTrivial = function(quality, a, b, c, d, e)
		return crayon:GetThresholdColorTrivial(quality, a, b, c, d, e)
	end,
	
	FormatMoneyExtended = function(value, colorize, textColor)
		return abacus:FormatMoneyExtended(value, colorize, textColor)
	end,
	
	FormatMoneyFull = function(value, colorize, textColor)
		return abacus:FormatMoneyFull(value, colorize, textColor)
	end,
	
	FormatMoneyShort = function(value, colorize, textColor)
		return abacus:FormatMoneyShort(value, colorize, textColor)
	end,
	
	FormatMoneyCondensed = function(value, colorize, textColor)
		return abacus:FormatMoneyCondensed(value, colorize, textColor)
	end,
	
	FormatDurationExtended = function(duration, colorize, hideSeconds)
		return abacus:FormatDurationExtended(duration, colorize, hideSeconds)
	end,
	
	FormatDurationFull = function(duration, colorize, hideSeconds)
		return abacus:FormatDurationFull(duration, colorize, hideSeconds)
	end,
	
	FormatDurationShort = function(duration, colorize, hideSeconds)
		return abacus:FormatDurationShort(duration, colorize, hideSeconds)
	end,
	
	FormatDurationCondensed = function(duration, colorize, hideSeconds)
		return abacus:FormatDurationCondensed(duration, colorize, hideSeconds)
	end,
	
	VersionToNumber = VersionToNumber,
	GetVersionPoint = GetVersionPoint,
	GetMajorNumber = GetMajorNumber,
	GetMinorNumber = GetMinorNumber,
	GetRevisionNumber = GetRevisionNumber,
	GetTrivialNumber = GetTrivialNumber,
}

local old_UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local spacerDropDown = nil
function FuBarUtils.AddSpacerDropDownMenu(level)
	if spacerDropDown ~= (level or 1) then
		spacerDropDown = level or 1
		local info = compost:AcquireHash(
			'disabled', true
		)
		old_UIDropDownMenu_AddButton(info, level or 1)
		compost:Reclaim(info)
	end
end

UIDropDownMenu_AddButton = function(info, level)
	spacerDropDown = nil
	old_UIDropDownMenu_AddButton(info, level)
end

local old_ToggleDropDownMenu = ToggleDropDownMenu
ToggleDropDownMenu = function(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	spacerDropDown = nil
	old_ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
end

print = function(...)
	local s = ""
	for i = 1, table.getn(arg) do
		if s ~= "" then
			s = s .. " "
		end
		if type(arg[i]) == "table" and type(arg[i][0]) == "userdata" then
			local name = arg[i]:GetName()
			if name == "" or name == nil then
				name = ""
			else
				name = ":" .. name
			end
			s = s .. "<" .. arg[i]:GetObjectType() .. name .. ">"
		else
			s = s .. tostring(arg[i])
		end
	end
	if string.len(s) == 0 then
		s = "\n"
	end
	DEFAULT_CHAT_FRAME:AddMessage(s)
end

local start
tableToString = function(t, depth)
	if t[".recurse"] then
		return "<recursion>"
	end
	t[".recurse"] = 1
	if depth == nil then
		depth = 0
		start = GetTime()
	end
	if GetTime() - start >= 0.05 then
		return "{too large}"
	end
	local s = ""
	s = "{\n"
	for k,v in pairs(t) do
		if k ~= ".recurse" then
			s = s .. string.rep("    ", depth + 1)
			if type(k) == "table" then
				s = s .. "[" .. tableToString(k, depth + 1) .. "]"
			elseif type(k) == "string" then
				local u = format("[%q]", k)
				if not string.find(k, "[^A-Za-z0-9_]") and string.sub(u, 3, -3) == k then
					s = s .. k
				else
					s = s .. u
				end
			else
				s = s .. "[" .. tostring(k) .. "]"
			end
			s = s .. " = "
			if type(v) == "table" then
				s = s .. tableToString(v, depth + 1)
			elseif type(v) == "string" then
				s = s .. format("%q", v)
			else
				s = s .. tostring(v)
			end
			s = s .. ",\n"
		end
	end
	s = s .. string.rep("    ", depth) .. "}"
	t[".recurse"] = nil
	if depth == 0 then
		start = nil
	end
	return s
end
local tableToString = tableToString

printFull = function(k, t)
	if t == nil then
		k, t = nil, k
	end
	local s
	if type(t) == "table" and type(t[0]) == "userdata" then
		local name = t:GetName()
		if name == "" or name == nil then
			name = ""
		else
			name = ":" .. name
		end
		t = "<" .. t:GetObjectType() .. name .. ">"
	end
	if type(t) == "table" and type(t[0]) ~= "userdata" then
		if k == nil then
			s = tableToString(t)
		else
			s = k .. " = " .. tableToString(t)
		end
	else
		if k == nil then
			s = t
		else
			s = k .. " = " .. t
		end
	end
	string.gsub(s, "[^\n]+", print)
end

codeposition = function(num)
	return strsub(debugstack((num or 0) + 2, 1, 0), 0, -5)
end


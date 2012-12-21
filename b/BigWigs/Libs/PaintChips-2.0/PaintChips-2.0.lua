
--[[
Name: PaintChips-2.0
Revision: $Rev: 14862 $
Author: Tekkub Stoutwrithe (tekkub@gmail.com)
Website: http://wiki.wowace.com/index.php/Metrognome_Embedded_Library
Documentation: http://wiki.wowace.com/index.php/Metrognome_Embedded_Library_Methods
SVN: svn://svn.wowace.com/root/trunk/Metrognome/Metrognome-2.0
Description: Color managing library
Dependencies: AceLibrary

Need hex codes?  http://www.december.com/html/spec/colorcodes.html
]]

local vmajor, vminor = "PaintChips-2.0", "$Revision: 14862 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end


local colors = " white:FFFFFF black:000000 blue:0000FF magenta:ff00ff cyan:00ffff green:00ff00 yellow:ffff00 orange:ff7f00 red:ff0000"

local lib = {}
local lib_mt = {}
setmetatable(lib, lib_mt)


-- Activate a new instance of this library
local function activate(self, oldLib, oldDeactivate)
	if oldLib then self.vars = oldLib.vars
	else
		self.vars = {
			rgb = {},
			rgbperc = {},
			hex = {},
		}
	end

	-- Register the Blizzy UI's colors
	for i,v in pairs(DebuffTypeColor) do self:RegisterColor("DebuffType"..i, v.r*255, v.g*255, v.b*255) end
	for i,v in pairs(RAID_CLASS_COLORS) do self:RegisterColor(i, v.r*255, v.g*255, v.b*255) end
	for i=0,6 do
		local r,g,b = GetItemQualityColor(i)
		r,g,b = r*255, g*255, b*255
		self:RegisterColor("ItemQuality"..i, r,g,b)
		self:RegisterColor("ItemQuality"..getglobal("ITEM_QUALITY".. i.. "_DESC"), r,g,b)
	end

	if oldDeactivate then oldDeactivate(oldLib) end
end


function lib:RegisterColor(name, hexorred, green, blue)
	if type(name) == "string" and type(hexorred) == "number" and type(green) == "number" and type(blue) == "number" then
		name = string.lower(name)
		if hexorred <=1 and green <= 1 and blue <= 1 then hexorred, green, blue = hexorred*255, green*255, blue*255 end
		local hex = string.format("%02x%02x%02x", hexorred, green, blue)
		if not self.vars.hex[name] then self.vars.hex[name] = hex end
	elseif type(name) == "string" and type(hexorred) == "string" and string.len(hexorred) == 6 then
		name = string.lower(name)
		if not self.vars.hex[name] then self.vars.hex[name] = hexorred end
	else
		self:error('Usage: RegisterColor("name", "hexcode") or RegisterColor("name", red, green, blue)')
	end
end


-- Accepts hex strings in three formats: "|cAARRGGBB", "AARRGGBB", "RRGGBB"
-- string will be indexed by the exact string you pass, use this as the name for any query calls
function lib:RegisterHex(hex)
	local l = string.len(hex)
	if l < 6 then self:error("Invalid hex string") end
	if l > 6 then hex = string.sub(hex, l-5) end

	local name = string.lower(hex)
	if not self.vars.hex[name] then self.vars.hex[name] = hex end
end


function lib:GetHex(name)
	if not name then return end
	name = string.lower(name)

	if not self.vars.hex[name] then
		local _, _, hex = string.find(colors, " "..name..":(%S+)")
		if hex then self.vars.hex[name] = hex end
	end

	return self.vars.hex[name]
end


function lib:GetRGB(name)
	local hex = self:GetHex(name)
	if not hex then return end

	if not self.vars.rgb[hex] then
		local rhex, ghex,bhex = string.sub(hex,1,2), string.sub(hex,3,4), string.sub(hex,5,6)
		local r,g,b = tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)

		self.vars.rgb[hex] = {r,g,b}
	end

	return self.vars.rgb[hex], unpack(self.vars.rgb[hex])
end


function lib:GetRGBPercent(name)
	local hex = self:GetHex(name)
	if not hex then return end

	if not self.vars.rgbperc[hex] then
		local rhex, ghex,bhex = string.sub(hex,1,2), string.sub(hex,3,4), string.sub(hex,5,6)
		local r,g,b = tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255

		self.vars.rgbperc[hex] = {r,g,b}
	end

	return self.vars.rgbperc[hex], unpack(self.vars.rgbperc[hex])
end


-- Syntax sugar.
-- local C = AceLibrary("PaintChips-2.0")
-- local hexcolor = C"white"
lib_mt.__call = lib.GetHex


--------------------------------
--      Load this bitch!      --
--------------------------------
AceLibrary:Register(lib, vmajor, vminor, activate)


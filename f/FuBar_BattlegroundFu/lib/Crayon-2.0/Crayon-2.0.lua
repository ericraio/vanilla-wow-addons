--[[
Name: Crayon-2.0
Revision: $Rev: 7622 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Crayon-2.0
SVN: http://svn.wowace.com/root/trunk/CrayonLib/Crayon-2.0
Description: A library to provide coloring tools.
Dependencies: AceLibrary
]]

--Theondry (theondry@gmail.com) added the purple.  yell at me if it's wrong, please

local MAJOR_VERSION = "Crayon-2.0"
local MINOR_VERSION = "$Revision: 7622 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local Crayon = {}

Crayon.COLOR_HEX_RED       = "ff0000"
Crayon.COLOR_HEX_ORANGE    = "ff7f00"
Crayon.COLOR_HEX_YELLOW    = "ffff00"
Crayon.COLOR_HEX_GREEN     = "00ff00"
Crayon.COLOR_HEX_WHITE     = "ffffff"
Crayon.COLOR_HEX_COPPER    = "eda55f"
Crayon.COLOR_HEX_SILVER    = "c7c7cf"
Crayon.COLOR_HEX_GOLD      = "ffd700"
Crayon.COLOR_HEX_PURPLE    = "9980CC"

function Crayon:Colorize(hexColor, text)
	return "|cff" .. tostring(hexColor or 'ffffff') .. tostring(text) .. "|r"
end
function Crayon:Red(text) return self:Colorize(self.COLOR_HEX_RED, text) end
function Crayon:Orange(text) return self:Colorize(self.COLOR_HEX_ORANGE, text) end
function Crayon:Yellow(text) return self:Colorize(self.COLOR_HEX_YELLOW, text) end
function Crayon:Green(text) return self:Colorize(self.COLOR_HEX_GREEN, text) end
function Crayon:White(text) return self:Colorize(self.COLOR_HEX_WHITE, text) end
function Crayon:Copper(text) return self:Colorize(self.COLOR_HEX_COPPER, text) end
function Crayon:Silver(text) return self:Colorize(self.COLOR_HEX_SILVER, text) end
function Crayon:Gold(text) return self:Colorize(self.COLOR_HEX_GOLD, text) end
function Crayon:Purple(text) return self:Colorize(self.COLOR_HEX_PURPLE, text) end

local inf = 1/0

function Crayon:GetThresholdColor(quality, worst, worse, normal, better, best)
	self:argCheck(quality, 2, "number")
	if quality ~= quality or quality == inf or quality == -inf then
		return 1, 1, 1
	end
	if not best then
		worst = 0
		worse = 0.25
		normal = 0.5
		better = 0.75
		best = 1
	end
	
	if worst < best then
		if (worse == better and quality == worse) or (worst == best and quality == worst) then
			return 1, 1, 0
		elseif quality <= worst then
			return 1, 0, 0
		elseif quality <= worse then
			return 1, 0.5 * (quality - worst) / (worse - worst), 0
		elseif quality <= normal then
			return 1, 0.5 + 0.5 * (quality - worse) / (normal - worse), 0
		elseif quality <= better then
			return 1 - 0.5 * (quality - normal) / (better - normal), 1, 0
		elseif quality <= best then
			return 0.5 - 0.5 * (quality - better) / (best - better), 1, 0
		else
			return 0, 1, 0
		end
	else
		if (worse == better and quality == worse) or (worst == best and quality == worst) then
			return 1, 1, 0
		elseif quality >= worst then
			return 1, 0, 0
		elseif quality >= worse then
			return 1, 0.5 - 0.5 * (quality - worse) / (worst - worse), 0
		elseif quality >= normal then
			return 1, 1 - 0.5 * (quality - normal) / (worse - normal), 0
		elseif quality >= better then
			return 0.5 + 0.5 * (quality - better) / (normal - better), 1, 0
		elseif quality >= best then
			return 0.5 * (quality - best) / (better - best), 1, 0
		else
			return 0, 1, 0
		end
	end
end

function Crayon:GetThresholdHexColor(quality, worst, worse, normal, better, best)
	local r, g, b = self:GetThresholdColor(quality, worst, worse, normal, better, best)
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

function Crayon:GetThresholdColorTrivial(quality, worst, worse, normal, better, best)
	self:argCheck(quality, 2, "number")
	if quality ~= quality or quality == inf or quality == -inf then
		return 1, 1, 1
	end
	if not best then
		worst = 0
		worse = 0.25
		normal = 0.5
		better = 0.75
		best = 1
	end
	
	if worst < best then
		if worse == better and normal == worse then
			return 1, 1, 0
		elseif quality <= worst then
			return 1, 0, 0
		elseif quality <= worse then
			return 1, 0.5 * (quality - worst) / (worse - worst), 0
		elseif quality <= normal then
			return 1, 0.5 + 0.5 * (quality - worse) / (normal - worse), 0
		elseif quality <= better then
			return 1 - (quality - normal) / (better - normal), 1, 0
		elseif quality <= best then
			local x = 0.5 * (quality - better) / (best - better)
			return x, 1 - x, x
		else
			return 0.5, 0.5, 0.5
		end
	else
		if worse == better and normal == worse then
			return 1, 1, 0
		elseif quality >= worst then
			return 1, 0, 0
		elseif quality >= worse then
			return 1, 0.5 - 0.5 * (quality - worse) / (worst - worse), 0
		elseif quality >= normal then
			return 1, 1 - 0.5 * (quality - normal) / (worse - normal), 0
		elseif quality >= better then
			return (quality - better) / (normal - better), 1, 0
		elseif quality >= best then
			local x = 0.5 * (quality - best) / (better - best)
			return 0.5 - x, 0.5 + x, 0.5 - x
		else
			return 0.5, 0.5, 0.5
		end
	end
end

function Crayon:GetThresholdHexColorTrivial(quality, worst, worse, normal, better, best)
	local r, g, b = self:GetThresholdColorTrivial(quality, worst, worse, normal, better, best)
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

AceLibrary:Register(Crayon, MAJOR_VERSION, MINOR_VERSION)
Crayon = nil

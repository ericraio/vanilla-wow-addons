--[[

	Babylonian
	A sub-addon that manages the locales for other addons.
	3.4.1 (Platypus)
	$Id: Babylonian.lua 716 2006-02-09 15:25:17Z mentalpower $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

]]

local self = {}
if (not self.update) then self.update = {}; end
--Local function prototypes
local split, setOrder, getOrder, fetchString, getString, registerAddOn, unRegisterAddOn, updateKhaos, isAddOnRegistered

function split(str, at)
	local splut = {}
	if (type(str) ~= "string") then return nil end
	if (not str) then str = "" end
	if (not at) then table.insert(splut, str)
	else for n, c in string.gfind(str, '([^%'..at..']*)(%'..at..'?)') do
		table.insert(splut, n); if (c == '') then break end
	end end
	return splut
end

function setOrder(order)
	if (not order) then self.order = {}
	else self.order = split(order, ",") end
	table.insert(self.order, GetLocale())
	table.insert(self.order, "enUS")
	if not(self.order[1] == getOrder()) then
		SetCVar("BabylonianOrder", order)
		updateKhaos()
	end
	SetCVar("BabylonianOrder", order)
end

function getOrder()
	return GetCVar("BabylonianOrder")
end

function fetchString(stringTable, locale, stringKey)
	if (type(stringTable)=="table" and
		type(stringTable[locale])=="table" and
		stringTable[locale][stringKey]) then
			return stringTable[locale][stringKey]
	end
end

function getString(stringTable, stringKey, default)
	local val
	for i=1, table.getn(self.order) do
		val = fetchString(stringTable, self.order[i], stringKey)
		if (val) then return val end
	end
	return default
end

--The following three functions were added to work around some Khaos behaviours.
function registerAddOn(AddOn, updateFunction)

	--Make both arguments required and make sure that they're the right type
	if ((not AddOn) or (not type(AddOn) == "string")) or ((not updateFunction) or (not type(updateFunction) == "function")) then
		EnhTooltip.DebugPrint("Invalid arguments passed to Babylonian.RegisterAddOn() |"..AddOn.." | "..updateFunction);
		return
	end

	EnhTooltip.DebugPrint("Registering '"..AddOn.."' with Babylonian");
	self.update[AddOn] = updateFunction;
end

function unRegisterAddOn(AddOn)

	--Again make sure the argument exists and that its the right type
	if ((not AddOn) or (not type(AddOn) == "string")) then
		return
	end

	EnhTooltip.DebugPrint("UnRegistering '"..AddOn.."' with Babylonian");
	self.update[AddOn] = nil;
end

function isAddOnRegistered(AddOn)

	--Again make sure the argument exists and that its the right type
	if ((not AddOn) or (not type(AddOn) == "string")) then
		return nil;
	end

	return (self.update[AddOn] ~= nil);
end

function updateKhaos()
local table = self.update

	for AddOn, updateFunction in table do
		EnhTooltip.DebugPrint("Updating '"..AddOn.."'s Khaos Locale");
		updateFunction(getOrder(), nil, true);
	end
end

if (not Babylonian) then
	Babylonian = {
		['SetOrder'] = setOrder,
		['GetOrder'] = getOrder,
		['GetString'] = getString,
		['FetchString'] = fetchString,
		['RegisterAddOn'] = registerAddOn,
		['UnRegisterAddOn'] = unRegisterAddOn,
		['IsAddOnRegistered'] = isAddOnRegistered,
	}
	RegisterCVar("BabylonianOrder", "")
	setOrder(getOrder())
end

--[[

	Babylonian
	A sub-addon that manages the locales for other addons.
	<%version%> (<%codename%>)
	$Id: Babylonian.lua 962 2006-08-18 03:03:29Z mentalpower $

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
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

]]

local self = {}
if (not self.update) then self.update = {}; end
--Local function prototypes
local split, setOrder, getOrder, fetchString, getString, registerAddOn

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
	end
	SetCVar("BabylonianOrder", order)
end

function getOrder()
	return GetCVar("BabylonianOrder")
end

function fetchString(stringTable, locale, stringKey)
	if (type(stringTable)=="table" and type(stringTable[locale])=="table" and stringTable[locale][stringKey]) then
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

if (not Babylonian) then
	Babylonian = {
		['SetOrder'] = setOrder,
		['GetOrder'] = getOrder,
		['GetString'] = getString,
		['FetchString'] = fetchString,
	}
	RegisterCVar("BabylonianOrder", "")
	setOrder(getOrder())
end

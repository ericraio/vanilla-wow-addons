--[[
	Informant
	An addon for World of Warcraft that shows pertinent information about
	an item in a tooltip when you hover over the item in the game.

	3.8.0 (Kangaroo)
	$Id: InfLocale.lua 632 2005-12-18 14:36:34Z norganna $

	Localization routines

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

Informant_CustomLocalizations = {
}

function _INFM(stringKey, locale)
	if (locale) then
		if (type(locale) == "string") then
			return Babylonian.FetchString(InformantLocalizations, locale, stringKey);
		else
			return Babylonian.FetchString(InformantLocalizations, GetLocale(), stringKey);
		end
	elseif (Informant_CustomLocalizations[stringKey]) then
		return Babylonian.FetchString(InformantLocalizations, Informant_CustomLocalizations[stringKey])
	else
		return Babylonian.GetString(InformantLocalizations, stringKey)
	end
end


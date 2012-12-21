--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucAPI.lua 699 2006-01-23 23:03:01Z mentalpower $

	Auctioneer data access and management.
	Functions central to setting/getting any data from Auctioneer.

	Note to authors of any addons wanting to utilize Auctioneer data:
	If you do not see the function you want here, please ask for it to be added.
	This is the only place that we guarantee the function prototypes will not change.
	If you use any of the internal functions, one day your addon will stop working :)

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

--Local function prototypes
local getVendorBuyPrice, getVendorSellPrice;
--[[
	Auctioneer.API.GetVendorBuyPrice(itemId)

	This function gets the buy price (how much it costs for the player to buy) from
	Auctioneer's database of item prices.

	@param itemId The ID portion of the item link (the first of the four numbers).
	@returns A price if known (may be 0 if known to have no price) or nil if unknown.
]]
function getVendorBuyPrice(itemId)
	if (Informant) then
		local ret = Informant.GetItem(itemId)
		if (ret) then return ret.buy end
	end
	return nil;
end
--[[
	Auctioneer.API.GetVendorSellPrice(itemId)

	This function gets the sell price (how much it the player will get if they sell it)
	from Auctioneer's database of item prices.

	@param itemId The ID portion of the item link (the first of the four numbers).
	@returns A price if known (may be 0 if known to have no price) or nil if unknown.
]]
function getVendorSellPrice(itemId)
	if (Informant) then
		local ret = Informant.GetItem(itemId)
		if (ret) then return ret.sell end
	end
	return nil;
end

Auctioneer.API = {
GetVendorBuyPrice = getVendorBuyPrice,
GetVendorSellPrice = getVendorSellPrice,
}

--Backwards compatiblity, please use the new prototypes whenever possible.
Auctioneer_GetVendorBuyPrice = getVendorBuyPrice;
Auctioneer_GetVendorSellPrice = getVendorSellPrice;
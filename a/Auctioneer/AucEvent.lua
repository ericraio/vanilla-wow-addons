--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucEvent.lua 675 2006-01-05 19:33:38Z mentalpower $

	Auctioneer event functions
	Functions to hook when other addons want to recieve events when we do certain things

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

local eventScanAuction, eventStartAuctionScan, eventStopAuctionScan, eventFinishedAuctionScan, eventAuctionQuery

-- Hook this function to be called whenever an auction entry is successfully inspected
function scanAuction(auctionpage, auctionid)
	-- auctionpage: the page number this item was found on
	-- auctionid: the id of the inspected item
end

-- Hook this function to be called whenever Auctioneer starts an auction scan
function startAuctionScan()
end

-- Hook this function to be called whenever Auctioneer stops an auction scan
function stopAuctionScan()
end

-- Hook this function to be called whenever Auctioneer completes a full auction scan
function finishedAuctionScan()
end

-- Hook this function to be called whenever Auctioneer sends a new auction query
function auctionQuery(auctionpage)
	-- auctionpage: the page number for the query that was just sent
end



Auctioneer.Event = {
	ScanAuction = scanAuction,
	StartAuctionScan = startAuctionScan,
	StopAuctionScan = stopAuctionScan,
	FinishedAuctionScan = finishedAuctionScan,
	AuctionQuery = auctionQuery,
}
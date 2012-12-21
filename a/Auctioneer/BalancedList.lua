--[[
	Version: 3.6.1 (Platypus)
	Revision: $Id: BalancedList.lua 715 2006-02-09 15:21:58Z mentalpower $

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
-----------------------------------------------------------------------------
-- A balanced list object that always does ordered inserts and pushes off the end
-- values in the correct direction to keep the list balanced and median values
-- in the center
-----------------------------------------------------------------------------
local function newBalancedList(paramSize)
	local self = {maxSize = paramSize, list = {}};

	-- Does an ordered insert and pushes the an end value off if maxsize
	-- is exceeded. The end value that is pushed of depends on the location in
	-- the list that the value was inserted. If it is inserted on the left half
	-- of the list then the right end value will be pushed off and vise versa.
	-- This is what keeps the list balanced. For example if your list is {1,2,3,4}
	-- and you insert(2) then your list would become {1,2,2,3}.
	local insert =  function (value)
	if (not value) then return; end
		local val = tonumber(value) or 0;

		local insertPos	= 0
		local left		= 1
		local right		= table.getn(self.list)
		local middleVal
		local middle
		-- insert in sorted order
		if (right) then
			while (left <= right) do
				middle = math.floor((right-left) / 2) + left
				middleVal = tonumber(self.list[middle]) or 0
				if (val < middleVal) then
					right = middle - 1
				elseif (val > middleVal) then
					left = middle + 1
				else
					insertPos = middle
					break
				end
			end
		end
		-- TODO: Check how to optimize that too
		if (insertPos == 0) then
			insertPos = left;
		end

		table.insert(self.list, insertPos, val);

		-- see if we need to balance the list
		if (self.maxSize ~= nil and table.getn(self.list) > self.maxSize) then
			if (insertPos <= math.floor(self.maxSize / 2) + 1) then
				table.remove(self.list); -- remove from the right side
			else
				table.remove(self.list, 1); -- remove from the left side
			end
		end
	end

	local clear = function()
		self.list = {};
	end

	-- set the list from a list, if the size exeeds maxSize it it truncated
	local setList = function(externalList)
		clear();
		if (externalList ~= nil) then
			for i,v in externalList do
				insert(v);
			end
		end
	end

	-- returns the median value of the list
	local getMedian = function()
		return getMedian(self.list);
	end

	-- returns the current size of the list
	local size = function()
		return table.getn(self.list);
	end

	-- retrieves the value in the list at this position
	local get = function(pos)
		return tonumber(self.list[pos]);
	end

	local getMaxSize = function()
		return self.maxSize;
	end

	local getList = function ()
		return self.list;
	end

	return {
		['insert']		= insert,
		['getMedian']	= getMedian,
		['size']		= size,
		['get']			= get,
		['clear']		= clear,
		['getMaxSize']	= getMaxSize,
		['setList']		= setList,
		['getList']		= getList
	}
end


Auctioneer.BalancedList = {
	NewBalancedList = newBalancedList,
}
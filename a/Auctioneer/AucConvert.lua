--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucConvert.lua 928 2006-07-06 02:25:08Z luke1410 $

	Auctioneer intra-version conversion.
	Functions that allow auctioneer to upgrade the data formats when necessary.

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

--Local Function Prototypes
local backup, convert

-- helperfunction to backup data, which can't be converted atm
function backup(auctKey, sig, data) --Local
	if AuctionBackup[auctKey] == nil then
		AuctionBackup[auctKey] = {}
	end

	AuctionBackup[auctKey][sig] = data
end

function convert()
	if (not AuctionConfig.version) then AuctionConfig.version = 30000; end
	if (AuctionConfig.version < 30200) then
		AuctionConfig.data = {};
		AuctionConfig.info = {};
		AuctionConfig.snap = {};
		AuctionConfig.sbuy = {};
		if (AHSnapshot) then
			for auctKey, sData in pairs(AHSnapshot) do
				local colon = string.find(auctKey, ":");
				local hyphen = string.find(auctKey, "-");
				if (hyphen and not colon) then
					if (not AuctionConfig.snap[auctKey]) then
						AuctionConfig.snap[auctKey] = {};
					end
					for sig, iData in pairs(sData) do
						local catName = Auctioneer.Util.GetCatName(tonumber(iData.category));
						if (not catName) then iData.category = Auctioneer.Util.GetCatNumberByName(iData.category) end
						local cat = iData.category;
						Auctioneer.Core.SaveSnapshot(auctKey, cat, sig, iData);
					end
				end
			end
		end

		if (AHSnapshotItemPrices) then
			for auctKey, sData in pairs(AHSnapshotItemPrices) do
				local colon = string.find(auctKey, ":");
				local hyphen = string.find(auctKey, "-");
				if (hyphen and not colon) and (sData.buyoutPrices == nil) then
					if (not AuctionConfig.sbuy[auctKey]) then
						AuctionConfig.sbuy[auctKey] = {};
					end
					for itemKey, iData in pairs(sData) do
						Auctioneer.Core.SaveSnapshotInfo(auctKey, itemKey, iData);
					end
				end
			end
		end

		if (AuctionPrices) then
			for auctKey, sData in pairs(AuctionPrices) do
				local colon = string.find(auctKey, ":");
				local hyphen = string.find(auctKey, "-");
				if (hyphen and not colon) then
					AuctionConfig.data[auctKey] = {};
					for sig, iData in pairs(sData) do
						local catName
						local cat
						local data
						local name = nil
						local hist = ""
						local newsig = sig
						if type(iData) == "string" then
							-- 2.x -> 3.1
							local oldData = iData
							local s1, s2, s3, s4, s5, s6, s7, sname

							-- category
							name, _, _, _, catName = GetItemInfo(sig)
							if catName == nil then
								-- !!!item not seen since serverrestart!!!
								cat = 0 -- mark as unknown
							else
								cat = Auctioneer.Util.GetCatNumberByName(catName)
							end

							-- signatue
							newsig = newsig..':0:0'

							-- data/name
							_, _, s1, s2, s3, s4, s5, s6, s7, sname = string.find(iData, "(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(.+)")
							if s1 == nil then
								_, _, s1, s2, s3, s4, s5, s6, s7 = string.find(iData, "(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")
							end
							if s1 == nil then
								-- unsuported, likely corrupt format (for example: s7 = -727389968)

								-- set name = '' to name = nil
								name = nil

								-- backing it up so we might convert it later
								backup(auctKey, sig, iData)
							else
								if (name == nil) or (name == '') then
									name = sname
								end
								if (name == nil) or (name == '') then
									-- ouch ! can't convert the old data atm since no valid itemname can be found

									-- set name = '' to name = nil
									name = nil

									-- backing it up so we might convert it later
									backup(auctKey, sig, iData)
								else
									-- only set the data, if the name has successfully been identified
									data = s1..":"..s2..":"..s3..":"..s4..":"..s5..":"..s6..":"..s7
								end
							end
						elseif iData.category == nil then
							-- unknown dataformat
							-- ouch ! strange dataformat, can't convert atm since there is no way to get the itemid right now
							-- backing it up so we might convert it later
							backup(auctKey, sig, iData)
						else
							-- 3.0 -> 3.1
							catName = Auctioneer.Util.GetCatName(tonumber(iData.category));
							if (not catName) then iData.category = Auctioneer.Util.GetCatNumberByName(iData.category) end
							cat = iData.category;
							data = iData.data;
							name = iData.name;
							if (iData.buyoutPricesHistoryList) then
								-- Check history list for corrupted data that several people seem to have.
								-- Looks like some other item's "data" string. Example:
								--	["9778:1182:0"] = {
								--		["playerMade"] = false,
								--		["name"] = "Bandit Buckler of the Bear",
								--		["category"] = 2,
								--		["data"] = "4:4:8230:0:0:3:11500",
								--		["buyoutPricesHistoryList"] = {
								--			[1] = 2500,
								--			[2] = 3000,
								--			[3] = "16:16:12756:0:0:9:23888",
								--		},
								--	},
								for pos, hPrice in pairs(iData.buyoutPricesHistoryList) do
									if (type(hPrice) ~= "number") then
										-- unrecognized entry in the history list, nuke it :(
										iData.buyoutPricesHistoryList[pos] = nil;
									end
								end
								hist = Auctioneer.Core.StoreMedianList(iData.buyoutPricesHistoryList);
							end
						end
						if (name) then
							local newData = string.format("%s|%s", data, hist);
							local newInfo = string.format("%s|%s", cat, name);
							AuctionConfig.data[auctKey][newsig] = newData;
							AuctionConfig.info[newsig] = newInfo;
						end
					end
				end
			end
		end

		AuctionConfig.bids = {};
		if (AuctionBids) then
			for player, pData in pairs(AuctionBids) do
				AuctionConfig.bids[player] = {};
				for time, bData in pairs(pData) do
					local amount = bData.bidAmount;
					local sig = bData.signature;
					local owner = bData.itemOwner or "unknown";
					local won = bData.itemWon;
					if (won) then won = "1"; else won = "0"; end

					if (player and time and amount and sig and won) then
						local newBid = string.format("%s|%s|%s|%s", sig, amount, won, owner);
						AuctionConfig.bids[player][time] = newBid;
					end
				end
			end
		end
		
		AuctionConfig.version = 30200
	end
	
	if AuctionConfig.version < 30201 then
		-- Auto-convert to per-auctKey fixed prices
		if (AuctionConfig.fixedprice) then
			local fixedPrices = AuctionConfig.fixedprice;
			for k, v in fixedPrices do
				local i,j, start,buy,dur = string.find(v, "(%d+):(%d+):(%d+)");
				fixedPrices[k] = string.format("%s:%s:%d:%s", start, buy, 1, dur)
			end
			AuctionConfig.fixedprice = { ["global"] = fixedPrices };
		end

		AuctionConfig.version = 30201
   end
	
	if AuctionConfig.version < 30600 then
	   AuctionConfig.success = nil

	   AuctionConfig.version = 30600
	end

	-- Now the conversion is complete, wipe out the old data
	AHSnapshot = nil;
	AHSnapshotItemPrices = nil;
	AuctionPrices = nil;
	AuctionBids = nil;
end

Auctioneer.Convert = {
Convert = convert,
}

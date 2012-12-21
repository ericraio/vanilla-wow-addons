--[[
	Enchantrix Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: EnxUtil.lua 878 2006-05-28 16:50:50Z aradan $

	General utility functions

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

-- Global functions
local isDisenchantable
local getReagentInfo
local getLinkFromName
local getReagentPrice
local getItemType
local getItemIdFromSig
local getItemIdFromLink
local getSigFromLink

local getRevision
local split
local spliterator
local chatPrint

local gcd
local roundUp
local round
local confidenceInterval

local createProfiler

------------------------
--   Item functions   --
------------------------

-- Return false if item id can't be disenchanted
function isDisenchantable(id)
	if (id) then
		local _, _, quality, _, _, _, count, equip = GetItemInfo(id)
		if (not quality) then
			-- GetItemInfo() failed, item might be disenchantable
			return true
		end
		if (not Enchantrix.Constants.InventoryTypes[equip]) then
			-- Neither weapon nor armor
			return false
		end
		if (quality and quality < 2) then
			-- Low quality
			return false
		end
		if (count and count > 1) then
			-- Stackable item
			return false
		end
		return true
	end
	return false
end

-- Frontend to GetItemInfo()
-- Information for disenchant reagents are kept in a saved variable cache
function getReagentInfo(id)
	local cache = EnchantConfig.cache.reagentinfo

	if type(id) == "string" then
		local _, _, i = string.find(id, "item:(%d+):")
		id = i
	end
	id = tonumber(id)

	local sName, sLink, iQuality, iLevel, sType, sSubtype, iStack, sEquip, sTexture = GetItemInfo(id)
	if id and Enchantrix.Constants.StaticPrices[id] then
		if sName then
			cache[id] = sName.."|"..iQuality.."|"..sTexture
			cache["t"] = sType
		elseif type(cache[id]) == "string" then
			local cdata = split(cache[id], "|")

			sName = cdata[1]
			iQuality = tonumber(cdata[2])
			iLevel = 0
			sType = cache["t"]
			sSubtype = cache["t"]
			iStack = 10
			sEquip = ""
			sTexture = cdata[3]
			sLink = "item:"..id..":0:0:0"
		end
	end

	if sName and id then
		-- Might as well save this name while we have the data
		EnchantConfig.cache.names[sName] = "item:"..id..":0:0:0"
	end

	return sName, sLink, iQuality, iLevel, sType, sSubtype, iStack, sEquip, sTexture
end

function getLinkFromName(name)
	assert(type(name) == "string")

	if not EnchantConfig.cache then
		EnchantConfig.cache = {}
	end
	if not EnchantConfig.cache.names then
		EnchantConfig.cache.names = {}
	end

	local link = EnchantConfig.cache.names[name]
	if link then
		local n = GetItemInfo(link)
		if n ~= name then
			EnchantConfig.cache.names[name] = nil
		end
	end
	if not EnchantConfig.cache.names[name] then
		for i = 1, Enchantrix.State.MAX_ITEM_ID + 4000 do
			local n, link = GetItemInfo(i)
			if n then
				if n == name then
					EnchantConfig.cache.names[name] = link
					break
				end
				Enchantrix.State.MAX_ITEM_ID = math.max(Enchantrix.State.MAX_ITEM_ID, i)
			end
		end
	end
	return EnchantConfig.cache.names[name]
end

-- Returns HSP, median and static price for reagent
-- Auctioneer values are kept in cache for 48h in case Auctioneer isn't loaded
function getReagentPrice(reagentID)
	-- reagentID ::= number | hyperlink
	if type(reagentID) == "string" then
		local _, _, i = string.find(reagentID, "item:(%d+):")
		reagentID = i
	end
	reagentID = tonumber(reagentID)
	if not reagentID then return nil end

	local hsp, median, market

	market = Enchantrix.Constants.StaticPrices[reagentID]

	if Enchantrix.State.Auctioneer_Loaded then
		local itemKey = string.format("%d:0:0", reagentID);
		local realm = Auctioneer.Util.GetAuctionKey()
		hsp = Auctioneer.Statistic.GetHSP(itemKey, realm)
		median = Auctioneer.Statistic.GetUsableMedian(itemKey, realm)
	end

	if not EnchantConfig.cache then EnchantConfig.cache = {} end
	if not EnchantConfig.cache.prices then EnchantConfig.cache.prices = {} end
	if not EnchantConfig.cache.prices[reagentID] then EnchantConfig.cache.prices[reagentID] = {} end
	local cache = EnchantConfig.cache.prices[reagentID]
	if cache.timestamp and time() - cache.timestamp > 172800 then
		cache = {}
	end

	cache.hsp = hsp or cache.hsp
	cache.median = median or cache.median
	cache.market = market or cache.market
	cache.timestamp = time()

	return cache.hsp, cache.median, cache.market
end

-- Return item level (rounded up to nearest 5 levels), quality and type as string,
-- e.g. "20:2:Armor" for uncommon level 20 armor
function getItemType(id)
	if (id) then
		local _, _, quality, level, _, _, _, equip = GetItemInfo(id)
		if (quality and quality >= 2 and level > 0 and Enchantrix.Constants.InventoryTypes[equip]) then
			return string.format("%d:%d:%s", Enchantrix.Util.RoundUp(level, 5), quality, Enchantrix.Constants.InventoryTypes[equip])
		end
	end
end

-- Return item id as integer
function getItemIdFromSig(sig)
	if type(sig) == "string" then
		_, _, sig = string.find(sig, "(%d+)")
	end
	return tonumber(sig)
end

function getItemIdFromLink(link)
	return (EnhTooltip.BreakLink(link))
end

function getSigFromLink(link)
	assert(type(link) == "string")

	local _, _, id, rand = string.find(link, "item:(%d+):%d+:(%d+):%d+")
	if id and rand then
		return id..":0:"..rand
	end
end

-----------------------------------
--   General Utility Functions   --
-----------------------------------

-- Extract the revision number from SVN keyword string
function getRevision(str)
	if not str then return 0 end
	local _, _, rev = string.find(str, "Revision: (%d+)")
	return tonumber(rev) or 0
end

function split(str, at)
	local splut = {};

	if (type(str) ~= "string") then return nil end
	if (not str) then str = "" end

	if (not at)
		then table.insert(splut, str)

	else
		for n, c in string.gfind(str, '([^%'..at..']*)(%'..at..'?)') do
			table.insert(splut, n);

			if (c == '') then break end
		end
	end
	return splut;
end

-- Iterator version of split()
--   for i in spliterator(a, b) do
-- is equivalent to
--   for _, i in ipairs(split(a, b)) do
-- but puts less strain on the garbage collector
function spliterator(str, at)
	local start
	local found = 0
	local done = (type(str) ~= "string")
	return function()
		if done then return nil end
		start = found + 1
		found = string.find(str, at, start, true)
		if not found then
			found = 0
			done = true
		end
		return string.sub(str, start, found - 1)
	end
end

function chatPrint(text, cRed, cGreen, cBlue, cAlpha, holdTime)
	local frameIndex = Enchantrix.Config.GetFrameIndex();

	if (cRed and cGreen and cBlue) then
		if getglobal("ChatFrame"..frameIndex) then
			getglobal("ChatFrame"..frameIndex):AddMessage(text, cRed, cGreen, cBlue, cAlpha, holdTime);

		elseif (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(text, cRed, cGreen, cBlue, cAlpha, holdTime);
		end

	else
		if getglobal("ChatFrame"..frameIndex) then
			getglobal("ChatFrame"..frameIndex):AddMessage(text, 1.0, 0.5, 0.25);
		elseif (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(text, 1.0, 0.5, 0.25);
		end
	end
end


------------------------
--   Math Functions   --
------------------------

function gcd(a, b)
	-- Greatest Common Divisor, Euclidean algorithm
	local m, n = tonumber(a), tonumber(b) or 0
	while (n ~= 0) do
		m, n = n, math.mod(m, n)
	end
	return m
end

-- Round up m to nearest multiple of n
function roundUp(m, n)
	return math.ceil(m / n) * n
end

-- Round m to n digits in given base
function round(m, n, base, offset)
	base = base or 10 -- Default to base 10
	offset = offset or 0.5

	if (n or 0) == 0 then
		return math.floor(m + offset)
	end

	if m == 0 then
		return 0
	elseif m < 0 then
		return -round(-m, n, base, offset)
	end

	-- Get integer and fractional part of n
	local f = math.floor(n)
	n, f = f, n - f

	-- Pre-rounding multiplier is 1 / f
	local mul = 1
	if f > 0.1 then
		mul = math.floor(1 / f + 0.5)
	end

	local d
	if n > 0 then
		d = base^(n - math.floor(math.log(m) / math.log(base)) - 1)
	else
		d = 1
	end
	if offset >= 1 then
		return math.ceil(m * d * mul) / (d * mul)
	else
		return math.floor(m * d * mul + offset) / (d * mul)
	end
end

-- Returns confidence interval for binomial distribution given observed
-- probability p, sample size n, and z-value
function confidenceInterval(p, n, z)
	if not z then
		--[[
		z		conf
		1.282	80%
		1.645	90%
		1.960	95%
		2.326	98%
		2.576	99%
		3.090	99.8%
		3.291	99.9%
		]]
		z = 1.645
	end
	assert(p >= 0 and p <= 1)
	assert(n > 0)

	local a = p + z^2 / (2 * n)
	local b = z * math.sqrt(p * (1 - p) / n + z^2 / (4 * n^2))
	local c = 1 + z^2 / n

	return (a - b) / c, (a + b) / c
end

---------------------
-- Debug functions --
---------------------

-- profiler:Start()
-- Record start time and memory, set state to running
local function _profilerStart(this)
	this.t = GetTime()
	this.m = gcinfo()
	this.r = true
end

-- profiler:Stop()
-- Record time and memory change, set state to stopped
local function _profilerStop(this)
	this.m = (gcinfo()) - this.m
	this.t = GetTime() - this.t
	this.r = false
end

-- profiler:DebugPrint()
local function _profilerDebugPrint(this)
	if this.n then
		EnhTooltip.DebugPrint("Profiler ["..this.n.."]")
	else
		EnhTooltip.DebugPrint("Profiler")
	end
	if this.r == nil then
		EnhTooltip.DebugPrint("  Not started")
	else
		EnhTooltip.DebugPrint(string.format("  Time: %0.3f s", this:Time()))
		EnhTooltip.DebugPrint(string.format("  Mem: %0.0f KiB", this:Mem()))
		if this.r then
			EnhTooltip.DebugPrint("  Running...")
		end
	end
end

-- time = profiler:Time()
-- Return time (in seconds) from Start() [until Stop(), if stopped]
local function _profilerTime(this)
	if this.r == false then
		return this.t
	elseif this.r == true then
		return GetTime() - this.t
	end
end

-- mem = profiler:Mem()
-- Return memory change (in kilobytes) from Start() [until Stop(), if stopped]
local function _profilerMem(this)
	if this.r == false then
		return this.m
	elseif this.r == true then
		return (gcinfo()) - this.m
	end
end

-- profiler = Enchantrix.Util.CreateProfiler("foobar")
function createProfiler(name)
	return {
		Start = _profilerStart,
		Stop = _profilerStop,
		DebugPrint = _profilerDebugPrint,
		Time = _profilerTime,
		Mem = _profilerMem,
		n = name,
	}
end

Enchantrix.Util = {
	Revision			= "$Revision: 878 $",

	IsDisenchantable	= isDisenchantable,
	GetReagentInfo		= getReagentInfo,
	GetLinkFromName		= getLinkFromName,
	GetReagentPrice		= getReagentPrice,
	GetItemType			= getItemType,
	GetItemIdFromSig	= getItemIdFromSig,
	GetItemIdFromLink	= getItemIdFromLink,
	GetSigFromLink		= getSigFromLink,
	SigFromLink			= sigFromLink,

	GetRevision			= getRevision,
	Split				= split,
	Spliterator			= spliterator,
	ChatPrint			= chatPrint,

	GCD					= gcd,
	RoundUp				= roundUp,
	Round				= round,
	ConfidenceInterval	= confidenceInterval,

	CreateProfiler		= createProfiler,
}

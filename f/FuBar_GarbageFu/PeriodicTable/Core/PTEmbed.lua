
local vmajor, vminor = "1", tonumber(string.sub("$Revision: 9298 $", 12, -3))


-- Check to see if an update is needed
-- if not then just return out now before we do anything
local libobj = PeriodicTableEmbed
if libobj and not libobj:NeedsUpgraded(vmajor, vminor) then return end


local stubobj = TekLibStub
if not stubobj then
	stubobj = {}
	TekLibStub = stubobj


	-- Instance replacement method, replace contents of old with that of new
	function stubobj:ReplaceInstance(old, new)
		 for k,v in pairs(old) do old[k]=nil end
		 for k,v in pairs(new) do old[k]=v end
	end


	-- Get a new copy of the stub
	function stubobj:NewStub(name)
		local newStub = {}
		self:ReplaceInstance(newStub, self)
		newStub.libName = name
		newStub.lastVersion = ''
		newStub.versions = {}
		return newStub
	end


	-- Get instance version
	function stubobj:NeedsUpgraded(vmajor, vminor)
		local versionData = self.versions[vmajor]
		if not versionData or versionData.minor < vminor then return true end
	end


	-- Get instance version
	function stubobj:GetInstance(version)
		if not version then version = self.lastVersion end
		local versionData = self.versions[version]
		if not versionData then print(string.format("<%s> Cannot find library version: %s", self.libName, version or "")) return end
		return versionData.instance
	end


	-- Register new instance
	function stubobj:Register(newInstance)
		 local version,minor = newInstance:GetLibraryVersion()
		 self.lastVersion = version
		 local versionData = self.versions[version]
		 if not versionData then
				-- This one is new!
				versionData = {
					instance = newInstance,
					minor = minor,
					old = {},
				}
				self.versions[version] = versionData
				newInstance:LibActivate(self)
				return newInstance
		 end
		 -- This is an update
		 local oldInstance = versionData.instance
		 local oldList = versionData.old
		 versionData.instance = newInstance
		 versionData.minor = minor
		 local skipCopy = newInstance:LibActivate(self, oldInstance, oldList)
		 table.insert(oldList, oldInstance)
		 if not skipCopy then
				for i, old in ipairs(oldList) do self:ReplaceInstance(old, newInstance) end
		 end
		 return newInstance
	end
end


if not libobj then
	libobj = stubobj:NewStub("PeriodicTableEmbed")
	PeriodicTableEmbed = libobj
end

local lib = {}


-- Return the library's current version
function lib:GetLibraryVersion()
	return vmajor, vminor
end


-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	local maj, min = self:GetLibraryVersion()

	if oldLib then
		local omaj, omin = oldLib:GetLibraryVersion()
		self.vars, self.k, self.loadstats = oldLib.vars, oldLib.k, oldLib.loadstats
	else
		self.vars = {numcustoms = 0}
		self.k, self.loadstats = {}, {}
	end
	self.compost = AceLibrary and AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
	-- nil return makes stub do object copy
end


-----------------------------------------------------------------
-- *********************************************************** --
-- **      Everything in this section is internal code      ** --
-- **      please see the API section for external use      ** --
-- *********************************************************** --
-----------------------------------------------------------------


function lib:Print(a1,a2,a3,a4,a5)
	if not a1 then return end
	ChatFrame1:AddMessage("|cffffff78Periodic Table: |r"..string.format(a1,a2,a3,a4,a5))
end


-- Called internally, you probably shouldn't be calling it directly, but hey do what you want :P
function lib:CacheSet(set)
	if not set then return end

	local rset = self:GetSet(set)
	if not rset or type(rset) ~= "string" then return end

	if not self.vars.cache then self.vars.cache = {} end
	if not self.vars.cache[set] then
		self.vars.cache[set] = {}
		for word in string.gfind(rset, "%S+") do
			local _, _, id, val = string.find(word, "(%d+):(%d+)")
			id, val = tonumber(id) or tonumber(word), tonumber(val) or 0
			self.vars.cache[set][id] = val
		end
	end

	return true
end


function lib:GetID(item)
	if type(item) == "number" then return item
	elseif type(item) == "string" then
		local _, _, id = string.find(item, "item:(%d+):%d+:%d+:%d+")
		if id then return tonumber(id) end
	end
end


function lib:GetSet(set)
	if not set then return end
	for i,vals in pairs(self.k) do if vals[set] then return vals[set] end end
end


function lib:GetSetModule(set)
	if not set then return end
	for i,vals in pairs(self.k) do if vals[set] then return i end end
end


function lib:GetSetString(set)
	if type(set) == "string" then
		return
	elseif type(set) == "table" then
		local retval
		for i,val in pairs(set) do
			if type(i) == "number" then
				local valstr = (val > 0) and string.format("%s:%s", i, val) or tostring(i)
				retval = retval and string.format("%s %s", retval, valstr) or valstr
			end
		end

		return retval
	end
end


function lib:CreateTrashTable(set, bosses)
	local retval, t = {}, self:GetSetTable(set)
	if not t then return end
	for i,v in pairs(t) do if not self:ItemInSet(i, bosses) then retval[i] = v end end
	return self:GetSetString(retval)
end


function lib:FindWorldDrops()
	local t, retval = {}, {}
	for _,set in self.k["Instance Loot"].instancezones do t = self:MergeSetToTable(t, set) end
	for _,set in self.k["Raid Loot"].raidzones do         t = self:MergeSetToTable(t, set) end
	for item,val in t do if val > 1 then retval[item] = val end end
	return self:GetSetString(retval)
end


function lib:MergeSetToTable(table, set)
	local t = self:GetSetTable(set)
	if t then
		for item,val in t do
			if table[item] then table[item] = table[item] + 1
			else table[item] = 1 end
		end
	end
	return table
end


function lib:RemoveAllWorldDrops()
	local retval = {instancezones = {}, raidzones = {}, instancebosses = {}, raidbosses = {}}
	for _,set in self.k["Instance Loot"].instancezones do retval.instancezones[set] = self:RemoveWorldDrops(set) end
	for _,set in self.k["Raid Loot"].raidzones do retval.raidzones[set] = self:RemoveWorldDrops(set) end
	for _,set in self.k["Instance Loot"].instancebosses do retval.instancebosses[set] = self:RemoveWorldDrops(set) end
	for _,set in self.k["Raid Loot"].raidbosses do retval.raidbosses[set] = self:RemoveWorldDrops(set) end
	return retval
end


function lib:RemoveWorldDrops(set)
	local t = self:GetSetTable(set)
	if t then
		local retval = ""
		for item,val in t do
			if not self:ItemInSet(item, {"worlddrops", "bossdrops", "NOTworlddrops"}) then
				local v = item..(val > 0 and (":"..val) or "")
				if retval == "" then retval = v else retval = retval.." "..v end
			end
		end

		return retval
	end
end


-----------------------------
--      Module Loadup      --
-----------------------------

function lib:AddModule(name, table, memory)
	if not name or not table or not memory then return end
	if self.k[name] and self.compost then self.compost:Reclaim(self.k[name]) end
	self.k[name] = table
	self.loadstats[name] = self.loadstats[name] or 0 + memory
end


---------------------------------
-- *************************** --
-- **      API Section      ** --
-- *************************** --
---------------------------------



-- item:     ItemID (a number) or ItemLink (a string)
-- set:      set to check (a string) or sets to check (a table of strings)
-- returns:  value (a number) ~~~ 0 indicates no value defined
--           set (a string) ~~~ the set that the item was found in
-- *** it is up to you to make sure all sets passed share a common value, the first matching value is returned!
function lib:ItemInSet(item, set)
	local item = self:GetID(item)
	if not item then return end

	if type(set) == "string" then
		local rset = self:GetSet(set)
		if rset and type(rset) == "string" then
			local t = self:GetSetTable(set)
			if t and t[item] then return t[item], set end
		elseif type(rset) == "table" then
			for _,s in rset do
				local retval = self:ItemInSet(item, s)
				if retval then return retval, s end
			end
		end
	elseif type(set) == "table" then
		for i,s in pairs(set) do
			local retval = self:ItemInSet(item, s)
			if retval then return retval, s end
		end
	end
end


-- item:     ItemID (a number) or ItemLink (a string)
-- sets:     sets to check (a table of strings)
-- returns:  a table of the sets found, or nil if not found
-- ** key difference between this and ItemInSet, this wil check for every match
-- ** ItemInSet will just return the first one found.  Also this func does not return the numeric values
function lib:ItemInSets(item, sets)
	local item = self:GetID(item)
	if not item then return end

	if type(sets) == "string" then
		local rset = self:GetSet(sets)
		if type(rset) == "string" then
			local inset = self:ItemInSet(item, sets)
			if inset then return self.compost and self.compost:Acquire(sets) or {sets} end
		elseif type(rset) == "table" then
			return self:ItemInSets(item, rset)
		end
	elseif type(sets) == "table" then
		local founds

		for i,s in pairs(sets) do
			if self:ItemInSet(item, s) then
				if not founds then founds = self.compost and self.compost:Acquire() or {} end
				table.insert(founds, s)
			end
		end

		return founds
	end
end


-- Iterator for scanning bags for set matches
-- Returns back bag, slot, value
function lib:BagIter(set)
	if not set then return end

	local bag, slot = 0, 1

	return function()
		if slot > GetContainerNumSlots(bag) then bag, slot = bag + 1, 1 end
		if bag > 4 then return end

		for b=bag,4 do
			for s=slot,GetContainerNumSlots(b) do
				slot = s + 1

				local link = GetContainerItemLink(b,s)
				local val = link and self:ItemInSet(link, set)
				if val then return b, s, val end
			end

			bag, slot = b+1, 1
	  end
   end
end


-- Returns the bag/slot of the "best" item in the set,
-- if there are two "matching" items the first one in your bags is returned
-- By default this will just compare PT values, however, if comparefunc is passed this will be used as the evaluation function
-- Args:
--   set - the set you wish to match
--   comparefunc(optional) - a function to test two items against each other
--     this function must take 6 args (item1_bag, item1_slot, item1_value, item2_bag, item2_slot, item2_value)
--     and should return true if item1 is "better" than item2
--   validatefunc (optional) - a function to check an item with, if it returns false/nil the item isn't used
--     Ideal for checking that an item is "good enough" or not too high of value
-- Returns: Bag, Slot and PT Value of best match, if a match is found
local defaultcomparefunc = function(abag, aslot, aval, bbag, bslot, bval) return aval > bval end
local defaultvalidatefunc = function(bag, slot, val) return true end
function lib:GetBest(set, comparefunc, validatefunc)
	comparefunc = comparefunc or defaultcomparefunc
	validatefunc = validatefunc or defaultvalidatefunc
	local ibag, islot, ival

	for bag,slot,val in self:BagIter(set) do
		if validatefunc(bag,slot,val) and (not ival or comparefunc(bag, slot, val, ibag, islot, ival)) then
				ibag, islot, ival = bag, slot, val
		end
	end
	return ibag, islot, ival
end


-- Returns a reference to the set specified's expanded table
-- this is the table in the cache so don't go erasing it or anything!
-- **** This only works for atomic sets, not multisets ****
function lib:GetSetTable(set)
	if self:CacheSet(set) then return self.vars.cache[set] end
end


-- Register a custom set
-- Args:
-- setcode (a string) - must be space-delimited itemid's of the format below
-- name (an optional string) - the name of the set
-- setcode format:
-- int or int:int  where the first or only int is itemid, the second is a relative value
-- the relative value can be anything you wish, it is intended to aid in sorting
-- if the item's level isn't enough
-- Returns a string, the index/setname of your set, or nil if that setname already exists
function lib:RegisterCustomSet(setcode, name)
	local setname = name or "customset"..self.vars.numcustoms
	if not setcode then return end
	if self:GetSetModule(setname) then return end

	self.k.customsets = self.k.customsets or {}
	self.k.customsets[setname] = setcode
	if not name then self.vars.numcustoms = self.vars.numcustoms + 1 end
	return setname
end


-- Loads up every module, dumps the memory used and time taken by each to chat
function lib:Benchmark()
	self.vars.cache = {}
	collectgarbage()

	local loadsize, tt, tmem = 0, GetTime(), gcinfo()
	for i,vals in self.k do
		local t, mem = GetTime(), gcinfo()
		for j,v in vals do
			if (type(v) == "string") then self:CacheSet(j) end
		end

		local compsize = self.loadstats[i] or 0
		loadsize = loadsize + compsize
		t, mem = (GetTime() - t), (gcinfo() - mem)
		self:Print("|cff80ff80%d ms|r %s set |cffff8000(%d --> %d KiB)", t*1000, i, compsize, mem)
	end
	tt, tmem = (GetTime() - tt), (gcinfo() - tmem)
	self:Print("|cff80ff80%d ms|r All sets |cffff8000(%d --> %d KiB)", tt*1000, loadsize, tmem)
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

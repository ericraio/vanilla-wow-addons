
-------------------------------------------------------------------
--***************************************************************--
--**    All authors using this library please see the wiki:    **--
--** http://wiki.wowace.com/index.php/Compost_Embedded_Library **--
--***************************************************************--
-------------------------------------------------------------------

local vmajor, vminor = "compost-1", tonumber(string.sub("$Revision: 658 $", 12, -3))
local stubvarname = "TekLibStub"
local libvarname = "CompostLib"
local usedebug = false


local libobj = getglobal(libvarname)
if libobj and not libobj:NeedsUpgraded(vmajor, vminor) then return end


---------------------------------------------------------------------------
-- Based off Embedded Library template
-- Written by Iriel <iriel@vigilance-committee.org>
-- Version 0.1 - 2006-03-05
-- Modified by Tekkub <tekkub@gmail.com>
---------------------------------------------------------------------------

local stubobj = getglobal(stubvarname)
if not stubobj then
	stubobj = {}
	setglobal(stubvarname, stubobj)


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


--------------------------------
--      Embedded Library      --
--------------------------------

if not libobj then
	libobj = stubobj:NewStub(libvarname)
	setglobal(libvarname, libobj)
end

local lib = {}


-- Return the library's current version
function lib:GetLibraryVersion()
	return vmajor, vminor
end


-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	local maj, min = self:GetLibraryVersion()
	if usedebug then print(string.format("<%s> Activating version %s - %d", libvarname, maj, min)) end

	if oldLib then
		local omaj, omin = oldLib:GetLibraryVersion()
		if usedebug then print(string.format("<%s> Replacing old version %s - %d", libvarname, omaj, omin)) end
		self.var, self.k = oldLib.var, oldLib.k
	else
		self.k = {  -- Constants go here
			maxcache = 10,		-- I think this is a good number, I'll change it later if necessary
		}
		self.var = {  -- "Local" variables go here
			cache = {},
			secondarycache = {},
		}

		-- This makes the secondary cache table a weak table, any values in it will be reclaimed
		-- during a GC if there are no other references to them
		setmetatable(self.var.secondarycache, {__mode = "v"})
	end
	-- nil return makes stub do object copy
end


-- Removes an empty table from the cache and returns it
-- or generates a new table if none available
function lib:GetTable()
	if self.var.disabled then return {} end
	if table.getn(self.var.cache) > 0 then
		self:IncDec("totn", -1)
		self:IncDec("numrecycled", 1)
		return table.remove(self.var.cache)
	elseif self:ItemsInSecondaryCache() then
		self:IncDec("totn", -1)
		self:IncDec("numrecycled", 1)
		for i in pairs(self.var.secondarycache) do return table.remove(self.var.secondarycache, i) end
	else
		self:IncDec("numnew", 1)
		return {}
	end
end


-- Returns a table, populated with any variables passed
-- basically: return {a1, a2, ... a20}
function lib:Acquire(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	local t = self:GetTable()
	return self:Populate(t,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
end


-- Acquires a table and fills it with values, hash style
-- basically: return {k1 = v1, k2 = v2, ... k10 = v10}
function lib:AcquireHash(k1,v1,k2,v2,k3,v3,k4,v4,k5,v5,k6,v6,k7,v7,k8,v8,k9,v9,k10,v10)
	local t = self:GetTable()
	return self:PopulateHash(t,k1,v1,k2,v2,k3,v3,k4,v4,k5,v5,k6,v6,k7,v7,k8,v8,k9,v9,k10,v10)
end


-- Erases the table passed, fills it with the args passed, and returns it
-- Essentially the same as doing Reclaim then Acquire, except the same table is reused
function lib:Recycle(t,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	t = self:Erase(t)
	return self:Populate(t,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
end


-- Erases the table passed, fills it with the args passed, and returns it
-- Essentially the same as doing Reclaim then AcquireHash, except the same table is reused
function lib:RecycleHash(t,k1,v1,k2,v2,k3,v3,k4,v4,k5,v5,k6,v6,k7,v7,k8,v8,k9,v9,k10,v10)
	t = self:Erase(t)
	return self:PopulateHash(t,k1,v1,k2,v2,k3,v3,k4,v4,k5,v5,k6,v6,k7,v7,k8,v8,k9,v9,k10,v10)
end


-- Returns a table to the cache
-- All tables referenced inside the passed table will be reclaimed also
-- If a depth is passed, Reclaim will call itsself recursivly
-- to reclaim all tables contained in t to the depth specified
function lib:Reclaim(t, depth)
	if type(t) ~= "table" or self.var.disabled then return end

	if not self:ItemsInSecondaryCache() then self.var.totn = table.getn(self.var.cache) end

	if depth and depth > 0 then
		for i in pairs(t) do
			if type(t[i]) == "table" then self:Reclaim(t[i], depth - 1) end
		end
	end
	self:Erase(t)
	if self.k.maxcache and table.getn(self.var.cache) >= self.k.maxcache then
		table.insert(self.var.secondarycache, t)
	else
		table.insert(self.var.cache, t)
	end
	self:IncDec("numreclaim", 1)
	self:IncDec("totn", 1)
	self.var.maxn = math.max(self.var.maxn or 0, self.var.totn)
end


-- Reclaims multiple tables, can take 10 recursive sets or 20 non-recursives,
-- or any combination of the two.  Pass args in the following manner:
-- table1, depth1, tabl2, depth2, table3, table4, table5, depth5, ...
function lib:ReclaimMulti(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	if not a1 then return end
	if type(a2) == "number" then
		self:Reclaim(a1, a2)
		self:ReclaimMulti(a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	else
		self:Reclaim(a1)
		self:ReclaimMulti(a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	end
end


-- Erases the table passed, nothing more nothing less :)
-- Tables referenced inside the passed table are NOT erased
function lib:Erase(t)
	if type(t) ~= "table" then return end
	if self.var.disabled then return {} end
	local mem = gcinfo()
	for i in pairs(t) do
		t[i] = nil
	end
	t.reset = 1
	t.reset = nil
	table.setn(t, 0)
	self:IncDec("memfreed", math.abs(gcinfo() - mem))
	self:IncDec("numerased", 1)
	return t
end


-- Fills the table passed with the args passed
function lib:Populate(t,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
	if not t then return end
	if a1 ~= nil then table.insert(t, a1) end
	if a2 ~= nil then table.insert(t, a2) end
	if a3 ~= nil then table.insert(t, a3) end
	if a4 ~= nil then table.insert(t, a4) end
	if a5 ~= nil then table.insert(t, a5) end
	if a6 ~= nil then table.insert(t, a6) end
	if a7 ~= nil then table.insert(t, a7) end
	if a8 ~= nil then table.insert(t, a8) end
	if a9 ~= nil then table.insert(t, a9) end
	if a10 ~= nil then table.insert(t, a10) end
	if a11 ~= nil then table.insert(t, a11) end
	if a12 ~= nil then table.insert(t, a12) end
	if a13 ~= nil then table.insert(t, a13) end
	if a14 ~= nil then table.insert(t, a14) end
	if a15 ~= nil then table.insert(t, a15) end
	if a16 ~= nil then table.insert(t, a16) end
	if a17 ~= nil then table.insert(t, a17) end
	if a18 ~= nil then table.insert(t, a18) end
	if a19 ~= nil then table.insert(t, a19) end
	if a20 ~= nil then table.insert(t, a20) end
	return t
end


-- Same as Populate, but takes 10 key-value pairs instead
function lib:PopulateHash(t,k1,v1,k2,v2,k3,v3,k4,v4,k5,v5,k6,v6,k7,v7,k8,v8,k9,v9,k10,v10)
	if not t then return end
	if k1 ~= nil then t[k1] = v1 end
	if k2 ~= nil then t[k2] = v2 end
	if k3 ~= nil then t[k3] = v3 end
	if k4 ~= nil then t[k4] = v4 end
	if k5 ~= nil then t[k5] = v5 end
	if k6 ~= nil then t[k6] = v6 end
	if k7 ~= nil then t[k7] = v7 end
	if k8 ~= nil then t[k8] = v8 end
	if k9 ~= nil then t[k9] = v9 end
	if k10 ~= nil then t[k10] = v10 end
	return t
end


function lib:IncDec(variable, diff)
	self.var[variable] = (self.var[variable] or 0) + diff
end


function lib:ItemsInSecondaryCache()
	for i in pairs(self.var.secondarycache) do return true end
end


function lib:GetSecondaryCacheSize()
	local n = 0
	for i in pairs(self.var.secondarycache) do n = n + 1 end
	return n
end


-- Prints out statistics on table recycling
-- /script CompostLib:GetInstance("compost-1"):Stats()
function lib:Stats()
	if self.var.disabled then ChatFrame1:AddMessage("CompostLib is disabled!")
	else ChatFrame1:AddMessage(
		string.format(
			"|cff00ff00New: %d|r | |cffffff00Recycled: %d|r | |cff00ffffMain: %d|r | |cffff0000Secondary: %d|r | |cffff8800Max %d|r | |cff888888Erases: %d|r | |cffff00ffMem Saved: %d KiB|r | |cffff0088Lost to GC: %d",
			self.var.numnew or 0,
			self.var.numrecycled or 0,
			table.getn(self.var.cache),
			self:GetSecondaryCacheSize(),
			self.var.maxn or 0,
			(self.var.numerased or 0) - (self.var.numreclaim or 0),
			(self.var.memfreed or 0) + 32/1024*(self.var.numrecycled or 0),
			(self.var.numreclaim or 0) - (self.var.numrecycled or 0) - table.getn(self.var.cache)))
	end
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

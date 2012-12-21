---------------------------------------------------------------------------
-- Embedded Library Registration Stub
-- Written by Iriel <iriel@vigilance-committee.org>
-- Version 0.1 - 2006-03-05
-- Modified by Tekkub <tekkub@gmail.com>
---------------------------------------------------------------------------
-- YOU DON'T NEED TO TOUCH ANYTHING IN THIS BLOCK OF CODE
---------------------------------------------------------------------------

if not EmbedLibStub then
	EmbedLibStub = {}


	-- Instance replacement method, replace contents of old with that of new
	function EmbedLibStub:ReplaceInstance(old, new)
		 for k,v in pairs(old) do old[k]=nil end
		 for k,v in pairs(new) do old[k]=v end
	end


	-- Get a new copy of the stub
	function EmbedLibStub:NewStub(name)
		local newStub = {}
		self:ReplaceInstance(newStub, self)
		newStub.libName = name
		newStub.lastVersion = ''
		newStub.versions = {}
		return newStub
	end


	-- Get instance version
	function EmbedLibStub:NeedsUpgraded(vmajor, vminor)
		local versionData = self.versions[vmajor]
		if not versionData or versionData.minor < vminor then return true end
	end


	-- Get instance version
	function EmbedLibStub:GetInstance(version)
		if not version then version = self.lastVersion end
		local versionData = self.versions[version]
		if not versionData then print(string.format("<%s> Cannot find library version: %s", self.libName, version or "")) return end
		return versionData.instance
	end


	-- Register new instance
	function EmbedLibStub:Register(newInstance)
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



----------------------------------
--      Library Definition      --
----------------------------------

local vmajor, vminor = "compost-1", 1
local libvarname = "CompostLib"
local usedebug = false


---------------------------------------------------------------------------
-- This code is the Library's management code
-- You don't need to change anything here
---------------------------------------------------------------------------

local libobj = getglobal(libvarname)
if not libobj then
	libobj = EmbedLibStub:NewStub(libvarname)
	setglobal(libvarname, libobj)
end


if libobj:NeedsUpgraded(vmajor, vminor) then

	local lib = {}


	-- Return the library's current version
	function lib:GetLibraryVersion() return vmajor, vminor end


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
	function lib:Acquire()
		if self.var.disabled then return {} end
		if table.getn(self.var.cache) > 0 then
			self:IncDec("totn", -1)
			self:IncDec("numr", 1)
			local t = self.var.cache[1]
			table.remove(self.var.cache, 1)
			return t
		elseif self:ItemsInSecondaryCache() then
			self:IncDec("totn", -1)
			self:IncDec("numr", 1)
			for i in pairs(self.var.secondarycache) do
				local t = self.var.secondarycache[i]
				table.remove(self.var.secondarycache, i)
				return t
			end
		else
			self:IncDec("numn", 1)
			return {}
		end
	end


	-- Returns a table to the cache
	-- All tables referenced inside the passed table will be reclaimed also
	-- If depth is passed any tables referenced in t will also be reclaimed ***USE THIS CAREFULLY***
	function lib:Reclaim(t, depth)
		if type(t) ~= "table" or self.var.disabled then return end

		if not self:ItemsInSecondaryCache() then self.var.totn = table.getn(self.var.cache) end

		if depth and depth > 0 then
			for i in pairs(t) do
				if type(t[i]) == "table" then self:Reclaim(t[i], depth - 1) end
			end
		end
		self:Erase(t)
		if self.var.maxcache and table.getn(self.var.cache) >= self.var.maxcache then
			table.insert(self.var.secondarycache, t)
		else
			table.insert(self.var.cache, t)
		end
		self:IncDec("totn", 1)
		self.var.maxn = math.max(self.var.maxn or 0, self.var.totn)
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
		self:IncDec("memf", math.abs(gcinfo() - mem))
		self:IncDec("nume", 1)
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
				"|cff00ff00New: %d|r | |cffffff00Recycled: %d|r | |cff00ffffSaved: %d|r | |cffff0000Secondary: %d|r | |cffff8800Max %d|r | |cff888888Erases: %d|r | |cffff00ffMem Freed: %d KiB",
				self.var.numn or 0, self.var.numr or 0, table.getn(self.var.cache), self:GetSecondaryCacheSize(), self.var.maxn or 0,
				(self.var.nume or 0) - (self.var.numr or 0) - table.getn(self.var.cache) - self:GetSecondaryCacheSize(),
				(self.var.memf or 0) + 32/1024*(self.var.numr or 0)))
		end
	end


	--------------------------------
	--      Load this bitch!      --
	--------------------------------
	libobj:Register(lib)
end

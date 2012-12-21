
local vmajor, vminor = "1", tonumber(string.sub("$Revision: 12749 $", 12, -3))
local stubvarname = "TekLibStub"
local libvarname = "Metrognome"


-- Check to see if an update is needed
-- if not then just return out now before we do anything
local libobj = getglobal(libvarname)
if libobj and not libobj:NeedsUpgraded(vmajor, vminor) then return end


---------------------------------------------------------------------------
-- Embedded Library Registration Stub
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


if not libobj then
	libobj = stubobj:NewStub(libvarname)
	setglobal(libvarname, libobj)
end

local lib = {}


-- Return the library's current version
function lib:GetLibraryVersion()
	return vmajor, vminor
end

local compost
-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	local maj, min = self:GetLibraryVersion()

	if oldLib then
		local omaj, omin = oldLib:GetLibraryVersion()
		self.var = oldLib.var
	else
		self.var = {  -- "Local" variables go here
			frame = CreateFrame("Frame"),
			handlers = {},
		}
		self.var.frame:Hide()
		self.var.frame.name = "Metrognome Frame"
	end
	self.var.frame:SetScript("OnUpdate", self.OnUpdate)
	self.var.frame.owner = self
	compost = CompostLib and CompostLib:GetInstance("compost-1")
	-- nil return makes stub do object copy
end


-- Sets up a new OnUpdate handler
-- name - A unique name, if you only need one handler then your addon's name will suffice here
-- func - Function to be called
-- rate (optional but highly reccomended) - The rate (in seconds) at which your function should be called
-- a1-4 (optional) - A args to be passed to func, this is a great place to pass self
--                   if a2 is defined then the elapsed time will not be passed to your function!
-- Returns true if you've been registered
function lib:Register(name, func, rate, a1, a2, a3, a4, a5, a6)
	assert(name, "Register: No timer name was passed")
	assert(func, "Register: No timer function was passed")
	if not name or not func or self.var.handlers[name] then return end
	local t = compost and compost:Acquire() or {}
	t.name, t.func, t.rate = name, func, rate or 0
	t.a1, t.a2, t.a3, t.a4, t.a5, t.a6 = a1, a2, a3, a4, a5, a6
	self.var.handlers[name] = t
	return true
end


-- Removes an OnUpdate handler
-- name - the hander you want to remove
-- Returns true if successful
function lib:Unregister(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
	assert(a1, "Unregister: No timer name was passed")
	if not self.var.handlers[a1] then return end
	if compost then compost:Reclaim(self.var.handlers[a1]) end
	self.var.handlers[a1] = nil
	if a2 then self:Unregister(a2,a3,a4,a5,a6,a7,a8,a9,a10)
	elseif not self:HasHandlers() then self.var.frame:Hide() end
	return true
end


-- Begins triggering updates
-- name - the hander you want to start
-- numexec (optional) - Limit the number of times the timer runs
-- Returns true if successful
function lib:Start(name, numexec)
	assert(name, "Start: No timer name was passed")
	if not self.var.handlers[name] then return end
	self.var.handlers[name].limit = numexec
	self.var.handlers[name].elapsed = 0
	self.var.handlers[name].running = true
	self.var.frame:Show()
	return true
end


-- Stops triggering updates
-- name - the hander you want to stop
-- Returns true if successful
function lib:Stop(name)
	assert(name, "Stop: No timer name was passed")
	if not self.var.handlers[name] then return end
	self.var.handlers[name].running = nil
	self.var.handlers[name].limit = nil
	if not self:HasHandlers() then self.var.frame:Hide() end
	return true
end


-- Changes the execution rate of a timer.
-- This will also reset the timer's elapsed time to 0
-- name - The timer you wish to change
-- newrate (optional)- The new exec rate, in seconds.  If nil or 0 default OnUpdate timing will be used
-- n#,r# (optional) - Recusivly calls ChangeRate to allow you to set up to 5 rates in one call.
-- Returns true if successful
function lib:ChangeRate(name, newrate, n2,r2,n3,r3,n4,r4,n5,r5)
	assert(name, "ChangeRate: No timer name was passed")
	if not self.var.handlers[name] then
		if n2 then return nil, self:ChangeRate(n2,r2,n3,r3,n4,r4,n5,r5)
		else return end
	end

	local t = self.var.handlers[name]
	t.elapsed = 0
	t.rate = newrate or 0
	if n2 then return true, self:ChangeRate(n2,r2,n3,r3,n4,r4,n5,r5)
	else return true end
end


-- Resets the profile stats for a timer
-- Accepts up to 10 timer names to clear
function lib:ClearStats(name, n2, n3, n4, n5, n6, n7, n8, n9, n10)
	assert(name, "ChangeRate: No timer name was passed")
	if not self.var.handlers[name] then
		if n2 then return nil, self:ClearStats(n2,r2,n3,r3,n4,r4,n5,r5)
		else return end
	end

	local t = self.var.handlers[name]
	t.count, t.mem, t.time = 0, 0, 0
	if n2 then return true, self:ClearStats(n2,r2,n3,r3,n4,r4,n5,r5)
	else return true end
end


-- Query a timer's status
-- Args: name - the schedule you wish to look up
-- Returns: registered - true if a schedule exists with this name
--          rate - the registered rate, if defined
--          running - true if this schedule is currently running
function lib:Status(name)
	assert(name, "Status: No timer name was passed")
	if not self.var.handlers[name] then return end
	return true, self.var.handlers[name].rate, self.var.handlers[name].running, self.var.handlers[name].limit
end


-- Query a timer's profile info
-- Args: name - the schedule you wish to look up
-- Returns: mem - the total memory consumed by the timer's execution (in KiB)
--          time - the total time consumed by the timer's execution (in sec)
--          count - the number of times the timer has been triggered
--          rate - the rate at which the timer triggers (0 means the default OnUpdate rate)
function lib:Profile(name)
	assert(name, "Profile: No timer name was passed")
	if not self.var.handlers[name] then return end
	local t = self.var.handlers[name]
	return t.mem, t.time, t.count, t.rate
end


function lib:OnUpdate()
	for i,v in pairs(this.owner.var.handlers) do
		if v.running then
			v.elapsed = v.elapsed + arg1
			if v.elapsed >= v.rate then
				local mem, time = gcinfo(), GetTime()
				v.func(v.a1 or v.arg, v.a2 or v.elapsed, v.a3, v.a4, v.a5, v.a6)
				mem, time = gcinfo() - mem, GetTime() - time
				if mem >= 0 then v.mem, v.time, v.count = (v.mem or 0) + mem, (v.time or 0) + time, (v.count or 0) + 1 end
				v.elapsed = 0
				if v.limit then v.limit = v.limit - 1 end
				if v.limit and v.limit <= 0 then this.owner:Stop(i) end
			end
		end
	end
end


function lib:HasHandlers()
	for i in pairs(self.var.handlers) do return true end
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

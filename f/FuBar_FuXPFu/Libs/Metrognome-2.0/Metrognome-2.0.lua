
--[[
Name: Metrognome-2.0
Revision: $Rev: 5623 $
Author: Tekkub Stoutwrithe (tekkub@gmail.com)
Website: http://wiki.wowace.com/index.php/Metrognome_Embedded_Library
Documentation: http://wiki.wowace.com/index.php/Metrognome_Embedded_Library_Methods
SVN: svn://svn.wowace.com/root/trunk/Metrognome/Metrognome-2.0
Description: OnUpdate timer managing library
Dependencies: AceLibrary, AceOO-2.0, Compost-2.0 (optional)
]]

local vmajor, vminor = "Metrognome-2.0", "$Revision: 5623 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end

if not AceLibrary:HasInstance("AceOO-2.0") then error(vmajor .. " requires AceOO-2.0") end


local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")

local AceOO = AceLibrary:GetInstance("AceOO-2.0")
local Mixin = AceOO.Mixin
local Metrognome = Mixin {
	"RegisterMetro",
	"UnregisterMetro",
	"StartMetro",
	"StopMetro",
	"ChangeMetroRate",
	"ClearMetroStats",
	"MetroStatus",
	"MetroProfile",
}

local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end


-- Sets up a new OnUpdate handler
-- name - A unique name, if you only need one handler then your addon's name will suffice here
-- func - Function to be called
-- rate (optional but highly reccomended) - The rate (in seconds) at which your function should be called
-- a1-4 (optional) - A args to be passed to func, this is a great place to pass self
--                   if a2 is defined then the elapsed time will not be passed to your function!
-- Returns true if you've been registered
function Metrognome:Register(name, func, rate, a1, a2, a3, a4, a5, a6)
	Metrognome:argCheck(name, 2, "string")
	Metrognome:argCheck(func, 3, "function")
	Metrognome:assert(not Metrognome.var.handlers[name], "A timer with the name "..name.." is already registered")

	local t = getnewtable()
	t.name, t.func, t.rate = name, func, rate or 0
	t.a1, t.a2, t.a3, t.a4, t.a5, t.a6 = a1, a2, a3, a4, a5, a6
	Metrognome.var.handlers[name] = t
	return true
end


-- Removes an OnUpdate handler
-- name - the hander you want to remove
-- Returns true if successful
function Metrognome:Unregister(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
	Metrognome:argCheck(a1, 2, "string")

	if not Metrognome.var.handlers[a1] then return end
	reclaimtable(Metrognome.var.handlers[a1])
	Metrognome.var.handlers[a1] = nil
	if a2 then Metrognome:Unregister(a2,a3,a4,a5,a6,a7,a8,a9,a10)
	elseif not Metrognome:HasHandlers() then Metrognome.var.frame:Hide() end
	return true
end


-- Begins triggering updates
-- name - the hander you want to start
-- numexec (optional) - Limit the number of times the timer runs
-- Returns true if successful
function Metrognome:Start(name, numexec)
	Metrognome:argCheck(name, 2, "string")

	if not Metrognome.var.handlers[name] then return end
	Metrognome.var.handlers[name].limit = numexec
	Metrognome.var.handlers[name].elapsed = 0
	Metrognome.var.handlers[name].running = true
	Metrognome.var.frame:Show()
	return true
end


-- Stops triggering updates
-- name - the hander you want to stop
-- Returns true if successful
function Metrognome:Stop(name)
	Metrognome:argCheck(name, 2, "string")

	if not Metrognome.var.handlers[name] then return end
	Metrognome.var.handlers[name].running = nil
	Metrognome.var.handlers[name].limit = nil
	if not Metrognome:HasHandlers() then Metrognome.var.frame:Hide() end
	return true
end


-- Changes the execution rate of a timer.
-- This will also reset the timer's elapsed time to 0
-- name - The timer you wish to change
-- newrate (optional)- The new exec rate, in seconds.  If nil or 0 default OnUpdate timing will be used
-- n#,r# (optional) - Recusivly calls ChangeRate to allow you to set up to 5 rates in one call.
-- Returns true if successful
function Metrognome:ChangeRate(name, newrate, n2,r2,n3,r3,n4,r4,n5,r5)
	Metrognome:argCheck(name, 2, "string")

	if not Metrognome.var.handlers[name] then
		if n2 then return nil, Metrognome:ChangeRate(n2,r2,n3,r3,n4,r4,n5,r5)
		else return end
	end

	local t = Metrognome.var.handlers[name]
	t.elapsed = 0
	t.rate = newrate or 0
	if n2 then return true, Metrognome:ChangeRate(n2,r2,n3,r3,n4,r4,n5,r5)
	else return true end
end


-- Resets the profile stats for a timer
-- Accepts up to 10 timer names to clear
function Metrognome:ClearStats(name, n2, n3, n4, n5, n6, n7, n8, n9, n10)
	Metrognome:argCheck(name, 2, "string")

	if not Metrognome.var.handlers[name] then
		if n2 then return nil, Metrognome:ClearStats(n2,r2,n3,r3,n4,r4,n5,r5)
		else return end
	end

	local t = Metrognome.var.handlers[name]
	t.count, t.mem, t.time = 0, 0, 0
	if n2 then return true, Metrognome:ClearStats(n2,r2,n3,r3,n4,r4,n5,r5)
	else return true end
end


-- Query a timer's status
-- Args: name - the schedule you wish to look up
-- Returns: registered - true if a schedule exists with this name
--          rate - the registered rate, if defined
--          running - true if this schedule is currently running
--          limit - limit of times to repeat this timer
--          elapsed - time elapsed this cycle of the timer
function Metrognome:Status(name)
	Metrognome:argCheck(name, 2, "string")

	if not Metrognome.var.handlers[name] then return end
	return true, Metrognome.var.handlers[name].rate, Metrognome.var.handlers[name].running, Metrognome.var.handlers[name].limit, Metrognome.var.handlers[name].elapsed
end


-- Query a timer's profile info
-- Args: name - the schedule you wish to look up
-- Returns: mem - the total memory consumed by the timer's execution (in KiB)
--          time - the total time consumed by the timer's execution (in sec)
--          count - the number of times the timer has been triggered
--          rate - the rate at which the timer triggers (0 means the default OnUpdate rate)
function Metrognome:Profile(name)
	Metrognome:argCheck(name, 2, "string")

	if not Metrognome.var.handlers[name] then return end
	local t = Metrognome.var.handlers[name]
	return t.mem, t.time, t.count, t.rate
end


function Metrognome:OnUpdate()
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


function Metrognome:HasHandlers()
	if next(Metrognome.var.handlers) then return true end
end


------------------------------
--      Mixins Methods      --
------------------------------

Metrognome.StartMetro = Metrognome.Start
Metrognome.StopMetro = Metrognome.Stop
Metrognome.ChangeMetroRate = Metrognome.ChangeRate
Metrognome.ClearMetroStats = Metrognome.ClearStats
Metrognome.MetroStatus = Metrognome.Status
Metrognome.MetroProfile = Metrognome.Profile


function Metrognome:RegisterMetro(name, func, rate, a1, a2, a3, a4, a5, a6)
	if not Metrognome.var.addons[self] then Metrognome.var.addons[self] = getnewtable() end
	Metrognome.var.addons[self][name] = Metrognome:Register(name, func, rate, a1, a2, a3, a4, a5, a6)
end


function Metrognome:UnregisterMetro(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
	Metrognome:argCheck(a1, 2, "string")

	if Metrognome.var.addons[self] then Metrognome.var.addons[self][a1] = nil end
	Metrognome:Unregister(a1)
	if a2 then self:UnregisterMetro(a2,a3,a4,a5,a6,a7,a8,a9,a10) end
end


function Metrognome:OnEmbedDisable(target)
	if self.var.addons[target] then
		for i in pairs(Metrognome.var.addons[target]) do
			self:Stop(i)
		end
	end
end


--------------------------------
--      Load this bitch!      --
--------------------------------

function Metrognome:activate(oldLib, oldDeactivate)
	Metrognome = self

	if oldLib then self.var = oldLib.var
	else
		self.var = {  -- "Local" variables go here
			frame = CreateFrame("Frame"),
			handlers = {},
			addons = {},
		}
		self.var.frame:Hide()
		self.var.frame.name = "Metrognome-2.0 Frame"
	end
	if not self.var.addons then self.var.addons = {} end
	self.var.frame:SetScript("OnUpdate", self.OnUpdate)
	self.var.frame.owner = self

	self.super.activate(self, oldLib, oldDeactivate)
	if oldDeactivate then oldDeactivate(oldLib) end
end


local function external(self, major, instance)
	if major == "Compost-2.0" then compost = instance end
end


AceLibrary:Register(Metrognome, vmajor, vminor, Metrognome.activate, nil, external)


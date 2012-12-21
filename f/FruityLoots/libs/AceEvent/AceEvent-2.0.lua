--[[
Name: AceEvent-2.0
Revision: $Rev: 4599 $
Author(s): ckknight (ckknight@gmail.com)
Inspired By: AceEvent 1.x by Turan (<email here>)
Website: http://www.wowace.com/
Documentation: http://wiki.wowace.com/index.php/AceEvent-2.0
SVN: http://svn.wowace.com/root/trunk/Ace2/AceEvent-2.0
Description: Mixin to allow for event handling and inter-addon communication.
Dependencies: AceLibrary, AceOO-2.0, Compost-2.0 (optional)
]]

local MAJOR_VERSION = "AceEvent-2.0"
local MINOR_VERSION = "$Revision: 4599 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("AceOO-2.0") then error(MAJOR_VERSION .. " requires AceOO-2.0") end

local AceOO = AceLibrary:GetInstance("AceOO-2.0")
local Mixin = AceOO.Mixin
local AceEvent = Mixin {
						"RegisterEvent",
						"UnregisterEvent",
						"UnregisterAllEvents",
						"TriggerEvent",
						"ScheduleEvent",
						"ScheduleRepeatingEvent",
						"CancelScheduledEvent",
						"CancelAllScheduledEvents",
						"TriggerDelayedEvent", -- remove on July 23
						"CancelDelayedEvent", -- remove on July 23
						"IsEventRegistered",
						"IsEventScheduled",
					   }

local Compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")

function AceEvent:RegisterEvent(event, method, once)
	AceEvent:argCheck(event, 2, "string")
	AceEvent:argCheck(method, 3, "string", "function", "nil")
	AceEvent:argCheck(once, 4, "boolean", "nil")
	if not method then
		method = event
	end
	if type(method) == "string" and type(self[method]) ~= "function" then
		AceEvent:error("Cannot register event %q to method %q, it does not exist", event, method)
	end
	
	if not AceEvent.registry[event] then
		AceEvent.registry[event] = Compost and Compost:Acquire() or {}
		AceEvent.frame:RegisterEvent(event)
	end
	
	AceEvent.registry[event][self] = method
	
	if once then
		if not AceEvent.onceRegistry then
			AceEvent.onceRegistry = Compost and Compost:Acquire() or {}
		end
		if not AceEvent.onceRegistry[event] then
			AceEvent.onceRegistry[event] = Compost and Compost:Acquire() or {}
		end
		AceEvent.onceRegistry[event][self] = true
	else
		if AceEvent.onceRegistry and AceEvent.onceRegistry[event] then
			AceEvent.onceRegistry[event][self] = nil
		end
	end
end

local _G = getfenv(0)
function AceEvent:TriggerEvent(event, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	AceEvent:argCheck(event, 2, "string")
	local _G_event = _G.event
	_G.event = event

	if AceEvent.registry[event] then
		if AceEvent.onceRegistry and AceEvent.onceRegistry[event] then
			for obj in pairs(AceEvent.onceRegistry[event]) do
				local mem, time
				if AceEvent.debugTable then
					if not AceEvent.debugTable[event] then
						AceEvent.debugTable[event] = Compost and Compost:Acquire() or {}
					end
					if not AceEvent.debugTable[event][obj] then
						AceEvent.debugTable[event][obj] = Compost and Compost:AcquireHash(
							'mem', 0,
							'time', 0
						) or {
							mem = 0,
							time = 0
						}
					end
					mem, time = gcinfo(), GetTime()
				end
				local method = AceEvent.registry[event][obj]
				AceEvent.registry[event][obj] = nil
				AceEvent.onceRegistry[event][obj] = nil
				if type(method) == "string" then
					if obj[method] then
						obj[method](obj, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
					end
				elseif method then -- function
					method(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
				end
				if AceEvent.debugTable then
					mem, time = mem - gcinfo(), time - GetTime()
					AceEvent.debugTable[event][obj].mem = AceEvent.debugTable[event][obj].mem + mem
					AceEvent.debugTable[event][obj].time = AceEvent.debugTable[event][obj].time + time
				end
				obj = nil
			end
		end
		for obj, method in pairs(AceEvent.registry[event]) do
			local mem, time
			if AceEvent.debugTable then
				if not AceEvent.debugTable[event] then
					AceEvent.debugTable[event] = Compost and Compost:Acquire() or {}
				end
				if not AceEvent.debugTable[event][obj] then
					AceEvent.debugTable[event][obj] = Compost and Compost:AcquireHash(
						'mem', 0,
						'time', 0
					) or {
						mem = 0,
						time = 0
					}
				end
				mem, time = gcinfo(), GetTime()
			end
			if type(method) == "string" then
				if obj[method] then
					obj[method](obj, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
				end
			else -- function
				method(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
			end
			if AceEvent.debugTable then
				mem, time = mem - gcinfo(), time - GetTime()
				AceEvent.debugTable[event][obj].mem = AceEvent.debugTable[event][obj].mem + mem
				AceEvent.debugTable[event][obj].time = AceEvent.debugTable[event][obj].time + time
			end
		end
	end
	_G.event = _G_event
end

local GetTime = GetTime
local delayRegistry
local function OnUpdate()
	local t = GetTime()
	local last = nil
	for k,v in pairs(delayRegistry) do
		if v.time <= t then
			if v.repeatDelay then
				v.time = t + v.repeatDelay
				last = k
			else
				delayRegistry[k] = nil
			end
			local event = v.event
			if type(event) == "function" then
				event(unpack(v))
			else
				AceEvent:TriggerEvent(event, unpack(v))
			end
			if not v.repeatDelay and Compost then
				Compost:Reclaim(v)
			end
			k = last
		else
			last = k
		end
	end
	if not next(delayRegistry) then
		AceEvent.frame:Hide()
	end
end

local stage = 3
if tonumber(date("%Y%m%d")) < 20060716 then
	stage = 1
elseif tonumber(date("%Y%m%d")) < 20060723 then
	stage = 2
end

if stage <= 2 then
	function AceEvent:TriggerDelayedEvent(event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
		if stage == 2 then
			local line = string.gsub(debugstack(), ".-\n(.-)\n.*", "%1")
			DEFAULT_CHAT_MESSAGE:AddMessage(line .. " - `TriggerDelayedEvent' has been replaced with `ScheduleEvent'. This will cause an error on July 23, 2006.")
		end
		self:ScheduleEvent(event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	end
	function AceEvent:CancelDelayedEvent(t)
		if stage == 2 then
			local line = string.gsub(debugstack(), ".-\n(.-)\n.*", "%1")
			DEFAULT_CHAT_MESSAGE:AddMessage(line .. " - `CancelDelayedEvent' has been replaced with `CancelScheduledEvent'. This will cause an error on July 23, 2006.")
		end
		self:CancelScheduledEvent(t)
	end
end

local function ScheduleEvent(self, repeating, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	local id
	if type(event) == "string" or type(event) == "table" then
		if type(event) == "table" then
			if not delayRegistry[event] then
				AceEvent:error("Bad argument #2 to `ScheduleEvent'. Improper id table fed in.")
			end
		end
		if type(delay) ~= "number" then
			id, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20 = event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20
			AceEvent:argCheck(event, 3, "string", "function", --[[ so message is right ]] "number")
			AceEvent:argCheck(delay, 4, "number")
			self:CancelScheduledEvent(id)
		end
	else
		AceEvent:argCheck(event, 2, "string", "function")
		AceEvent:argCheck(delay, 3, "number")
	end
	
	if not AceEvent.delayRegistry then
		AceEvent.delayRegistry = Compost and Compost:Acquire() or {}
		delayRegistry = AceEvent.delayRegistry
		AceEvent.frame:SetScript("OnUpdate", OnUpdate)
	end
	local t
	if type(id) == "table" then
		for k in pairs(id) do
			id[k] = nil
		end
		table.setn(id, 0)
		t = id
	else
		t = Compost and Compost:Acquire() or {}
	end
	t.n = 0
	table.insert(t, a1)
	table.insert(t, a2)
	table.insert(t, a3)
	table.insert(t, a4)
	table.insert(t, a5)
	table.insert(t, a6)
	table.insert(t, a7)
	table.insert(t, a8)
	table.insert(t, a9)
	table.insert(t, a10)
	table.insert(t, a11)
	table.insert(t, a12)
	table.insert(t, a13)
	table.insert(t, a14)
	table.insert(t, a15)
	table.insert(t, a16)
	table.insert(t, a17)
	table.insert(t, a18)
	table.insert(t, a19)
	table.insert(t, a20)
	t.event = event
	t.time = GetTime() + delay
	t.self = self
	t.id = id or t
	t.repeatDelay = repeating and delay
	AceEvent.delayRegistry[t.id] = t
	AceEvent.frame:Show()
	return t.id
end

function AceEvent:ScheduleEvent(event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	return ScheduleEvent(self, false, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
end

function AceEvent:ScheduleRepeatingEvent(event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	return ScheduleEvent(self, true, event, delay, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
end

function AceEvent:CancelScheduledEvent(t)
	AceEvent:argCheck(t, 2, "string", "table")
	if AceEvent.delayRegistry then
		local v = AceEvent.delayRegistry[t]
		if v then
			AceEvent.delayRegistry[t] = nil
			if Compost then
				Compost:Reclaim(v)
			end
			if not next(AceEvent.delayRegistry) then
				AceEvent.frame:Hide()
			end
			return true
		end
	end
	return false
end

function AceEvent:IsEventScheduled(t)
	AceEvent:argCheck(t, 2, "string", "table")
	if AceEvent.delayRegistry then
		local v = AceEvent.delayRegistry[t]
		if v then
			if Compost then
				Compost:Reclaim(v)
			end
			return true, v.time - GetTime()
		end
	end
	return false, nil
end

function AceEvent:UnregisterEvent(event)
	AceEvent:argCheck(event, 2, "string")

	if AceEvent.registry[event] and AceEvent.registry[event][self] then
		AceEvent.registry[event][self] = nil
	else
		AceEvent:error("Cannot unregister an event that you are not registered with.")
	end
end

function AceEvent:UnregisterAllEvents()
	for event, data in pairs(AceEvent.registry) do
		data[self] = nil
	end
end

function AceEvent:CancelAllScheduledEvents()
	if AceEvent.delayRegistry then
		for k,v in pairs(AceEvent.delayRegistry) do
			if v.self == target then
				if Compost then
					Compost:Reclaim(v)
				end
				AceEvent.delayRegistry[k] = nil
			end
		end
	end
end

function AceEvent:IsEventRegistered(event)
	AceEvent:argCheck(event, 2, "string")
	if AceEvent.registry[event] and AceEvent.registry[event][self] then
		return true, AceEvent.registry[event][self]
	end
	return false, nil
end

function AceEvent:OnEmbedDisable(target)
	self.UnregisterAllEvents(target)

	self.CancelAllScheduledEvents(target)
end

function AceEvent:EnableDebugging()
	if not self.debugTable then
		self.debugTable = {}
	end
end

function AceEvent:IsFullyInitialized()
	return self.postInit or false
end

function AceEvent:IsPostPlayerLogin()
	return self.playerLogin or false
end

function AceEvent:activate(oldLib, oldDeactivate)
	AceEvent = self

	if oldLib then
		self.onceRegistry = oldLib.onceRegistry
		self.delayRegistry = oldLib.delayRegistry
		self.registry = oldLib.registry
		self.frame = oldLib.frame
		self.debugTable = oldLib.debugTable
		self.playerLogin = oldLib.pew or DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.defaultLanguage and true
		self.postInit = oldLib.postInit or self.playerLogin and ChatTypeInfo and ChatTypeInfo.WHISPER and ChatTypeInfo.WHISPER.r and true
	end
	if not self.registry then
		self.registry = {}
	end
	if not self.frame then
		self.frame = CreateFrame("Frame")
	end
	self.frame:SetScript("OnEvent", function()
		if event then
			self:TriggerEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
		end
	end)
	if self.delayRegistry then
		delayRegistry = self.delayRegistry
		self.frame:SetScript("OnUpdate", OnUpdate)
	end
	
	self:UnregisterAllEvents()
	self:CancelAllScheduledEvents()
	
	if not self.playerLogin then
		self:RegisterEvent("PLAYER_LOGIN", function()
			self.playerLogin = true
		end, true)
	end
	
	if not self.postInit then
		local isReload = true
		local function func()
			self.postInit = true
			self:TriggerEvent("AceEvent_FullyInitialized")
			self:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")
			self:UnregisterEvent("SPELLS_CHANGED")
		end
		self:RegisterEvent("MEETINGSTONE_CHANGED", function()
			self.playerLogin = true
			self:ScheduleEvent("AceEvent_FullyInitialized", func, isReload and 1 or 4)
		end, true)
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE", function()
			self:ScheduleEvent("AceEvent_FullyInitialized", func, 0.05)
		end)
		self:RegisterEvent("SPELLS_CHANGED", function()
			isReload = false
		end)
	end
	
	self.super.activate(self, oldLib, oldDeactivate)
	if oldLib then
		oldDeactivate(oldLib)
	end
end

local function external(self, major, instance)
	if major == "Compost-2.0" then
		Compost = instance
	end
end

AceLibrary:Register(AceEvent, MAJOR_VERSION, MINOR_VERSION, AceEvent.activate, nil, external)
AceEvent = AceLibrary(MAJOR_VERSION)

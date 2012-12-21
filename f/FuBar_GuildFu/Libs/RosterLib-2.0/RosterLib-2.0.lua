--[[
Name: RosterLib-2.0
Revision: $Revision: 8205 $
X-ReleaseDate: "$Date: 2006-08-10 08:55:29 +0200 (Thu, 10 Aug 2006) $
Author: Maia (maia.proudmoore@gmail.com)
Website: http://wiki.wowace.com/index.php/RosterLib-2.0
Documentation: http://wiki.wowace.com/index.php/RosterLib-2.0_API_Documentation
SVN: http://svn.wowace.com/root/trunk/RosterLib-2.0/
Description: party/raid roster management
Dependencies: AceLibrary, AceOO-2.0, AceEvent-2.0
]]

local MAJOR_VERSION = "RosterLib-2.0"
local MINOR_VERSION = "$Revision: 8205 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end
if not AceLibrary:HasInstance("AceOO-2.0") then error(MAJOR_VERSION .. " requires AceOO-2.0") end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(MAJOR_VERSION .. " requires AceEvent-2.0") end

local Compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local rosterCount, addonCount, standby
local updatedUnits = Compost and Compost:Acquire() or {}
local RosterLib = {}

AceLibrary("AceEvent-2.0"):embed(RosterLib)

------------------------------------------------
-- activate, enable, disable
------------------------------------------------

local function print(text)
	DEFAULT_CHAT_FRAME:AddMessage(text)
end

local function activate(self, oldLib, oldDeactivate)
	RosterLib = self
	if oldLib then
		self.registry = oldLib.registry
	end
	if not self.registry then
		self.registry = {}
	end
	if oldDeactivate then
		oldDeactivate(oldLib)
	end
	addonCount = 0
end


function RosterLib:Enable()
	addonCount = addonCount + 1
	if addonCount > 1 then return end
	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() or standby then
		RosterLib:AceEvent_FullyInitialized()
	else
		self:RegisterEvent("AceEvent_FullyInitialized")
	end
	standby = false
	self.roster = Compost and Compost:Acquire() or {}
	rosterCount = 0
end


function RosterLib:Disable()
	addonCount = addonCount - 1
	if addonCount > 0 then return end
	self:TriggerEvent("RosterLib_Disabled")
	self:UnregisterAllEvents()
	standby = true
	rosterAvailable = false
	for name in pairs(self.roster) do
		if Compost then Compost:Reclaim(self.roster[name]) end
		self.roster[name] = nil
	end
	rosterCount = 0
end

------------------------------------------------
-- Internal functions
------------------------------------------------

function RosterLib:AceEvent_FullyInitialized()
	self:TriggerEvent("RosterLib_Enabled")
	self:RegisterEvent("RAID_ROSTER_UPDATE","UpdateRoster")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED","UpdateRoster")
	self:RegisterEvent("UNIT_PET","UpdateRoster")
	self:CheckRoster()
end

--[[

roster checks:

1.	AceEvent_FullyInitialized() is triggered when data *should* be available. It will
	register party/raid/pet events as we don't want then to fire before.
	Also, it will trigger CheckRoster().

2.	CheckRoster() will compare the roster table with the currently available data. If
	there's a difference, it will schedule UpdateRoster() with a delay of 0.5sec.

3.	UpdateRoster() will create/update the roster. To see if everything worked fine,
	it will call CheckRoster() when it's done, this time with a silent flag.

4.	Now the saved data should be valid. If it is, it'll trigger the event
	RosterLib_RosterChanged your addon can listen to. It'll pass a table with the unit
	names that have changed as first argument. If not (server lag?) it'll send a
	RosterLib_PendingRefresh event in case the roster was valid before (to not spam
	this event when we're waiting for the server)

5.	WOW events that are related to roster updates directly trigger UpdateRoster().

]]

local function GetName(unit)
	if not UnitExists(unit) then return nil end
	local n = UnitName(unit)
	if n and n ~= UNKNOWNOBJECT and n ~= UKNOWNBEING then return n end
end


local function UnitIterator()
	local pmem, rmem = GetNumPartyMembers(), GetNumRaidMembers()
	local playersent = false
	local petsent = false
	local unitcount = 1
	local petcount = 1
	local unit, name
	return function()
		-- STEP 1: pet
		if not petsent then
			petsent = true
			if rmem == 0 then
				unit = "pet"
				name = GetName(unit)
				if name and not UnitIsCharmed(unit) then
					return unit, name
				end
			end
		end
		-- STEP 2: player
		if not playersent then
			playersent = true
			if rmem == 0 then
				unit = "player"
				name = GetName(unit)
				if name then
					return unit, name
				end
			end
		end
		-- STEP 3: raid units
		if rmem > 0 then
			-- STEP 3a: pet units
			for i = petcount, rmem do
				unit = string.format("raidpet%d", i)
				petcount = petcount + 1
				name = GetName(unit)
				if name and not UnitIsCharmed(unit) then
					return unit, name
				end
			end
			-- STEP 3b: player units
			for i = unitcount, rmem do
				unit = string.format("raid%d", i)
				unitcount = unitcount + 1
				name = GetName(unit)
				if name then
					return unit, name
				end
			end
		-- STEP 4: party units
		elseif pmem > 0 then
			-- STEP 3a: pet units
			for i = petcount, pmem do
				unit = string.format("partypet%d", i)
				petcount = petcount + 1
				name = GetName(unit)
				if name and not UnitIsCharmed(unit) then
					return unit, name
				end
			end
			-- STEP 3b: player units
			for i = unitcount, pmem do
				unit = string.format("party%d", i)
				unitcount = unitcount + 1
				name = GetName(unit)
				if name then
					return unit, name
				end
			end
		end
	end
end



local function RosterValid(silent)
	local mem = 0
	local n, u
	-- STEP 1: count how many units the roster should have
	-- note: if the player has joined a raid but doesnt have a raid id yet
	-- (can take a second or two), the count will be one less.
	local testRoster = Compost and Compost:Acquire() or {}
	for u,n in UnitIterator(true) do
		testRoster[n] = true
	end
	for i in testRoster do
		mem = mem + 1
	end
	if Compost then Compost:Reclaim(testRoster) end
	if mem ~= rosterCount then
		if rosterAvailable then
			print(string.format("RosterLib: count mismatch: roster:%d members:%d (TELL MAIA)", rosterCount, mem))
		end
		return false
	end
	-- STEP 2: compare unit names
	for n in pairs(RosterLib.roster) do
		u = RosterLib.roster[n]
		if n ~= UnitName(u.unitid) then
			if rosterAvailable then
				print(string.format("name mismatch: name:%s, UnitName(%s):%q (TELL MAIA)", n or "nil", u.unitid or "nil", UnitName(u.unitid) or "nil"))
			end
			return false
		end
	end
	return true
end


function RosterLib:CheckRoster(silent)
	local wasAvailable = rosterAvailable
	if RosterValid(silent) then
		rosterAvailable = true
		if silent then
			local cnt = 0
			for name in pairs(updatedUnits) do cnt = cnt + 1 end
			if cnt > 0 then
				self:TriggerEvent("RosterLib_RosterChanged", updatedUnits)
				for name in pairs(updatedUnits) do
					local u = updatedUnits[name]
					self:TriggerEvent("RosterLib_UnitChanged", u.unitid, u.name, u.class, u.subgroup, u.rank, u.oldname, u.oldunitid, u.oldclass, u.oldsubgroup, u.oldrank)
					if Compost then Compost:Reclaim(updatedUnits[name]) end
					updatedUnits[name] = nil
				end
			end
		end
	else
		rosterAvailable = false
		if wasAvailable then
			print("RosterLib_PendingRefresh")
			self:TriggerEvent("RosterLib_PendingRefresh")
		end
		self:ScheduleEvent(self.UpdateRoster, 0.5, self)  --what do we need to change here to convert it to a local schedule?
	end
end


function RosterLib:UpdateRoster()
	local unitid, name
--	print("RosterLib:UpdateRoster")
	-- STEP 1: copy the roster to be able to compare it later.
	local oldRoster = Compost and Compost:Acquire() or {}
	for name in self.roster do
		oldRoster[name]          = Compost and Compost:Acquire() or {}
		oldRoster[name].name     = self.roster[name].name
		oldRoster[name].unitid   = self.roster[name].unitid
		oldRoster[name].class    = self.roster[name].class
		oldRoster[name].rank     = self.roster[name].rank
		oldRoster[name].subgroup = self.roster[name].subgroup
	end
	-- STEP 2: clear the .unitids, as we're replacing them and removing old units later
	for name in pairs(self.roster) do self.roster[name].unitid = nil end
	-- STEP 3: add all units and see if something has changed.
	for unitid, name in UnitIterator(true) do
		-- object
		if not self.roster[name] then
			self.roster[name] = Compost and Compost:Acquire() or {}
		end
		-- name
		self.roster[name].name = name
		-- unitid
		self.roster[name].unitid = unitid
		-- class
		if string.find(unitid,"pet") then
			self.roster[name].class = "PET"
		else
			_,self.roster[name].class = UnitClass(unitid)
		end
		-- subgroup and rank
		if GetNumRaidMembers() > 0 then
			local _,_,num = string.find(unitid, "(%d+)")
			_,self.roster[name].rank,self.roster[name].subgroup = GetRaidRosterInfo(num)
		else
			self.roster[name].subgroup = 1
			self.roster[name].rank = 0
		end
		-- compare data
		if not oldRoster[name]
		or self.roster[name].name     ~= oldRoster[name].name
		or self.roster[name].unitid   ~= oldRoster[name].unitid
		or self.roster[name].class    ~= oldRoster[name].class
		or self.roster[name].subgroup ~= oldRoster[name].subgroup
		or self.roster[name].rank     ~= oldRoster[name].rank
		then
			updatedUnits[name]             = Compost and Compost:Acquire() or {}
			updatedUnits[name].oldname     = (oldRoster[name] and oldRoster[name].name) or nil
			updatedUnits[name].oldunitid   = (oldRoster[name] and oldRoster[name].unitid) or nil
			updatedUnits[name].oldclass    = (oldRoster[name] and oldRoster[name].class) or nil
			updatedUnits[name].oldsubgroup = (oldRoster[name] and oldRoster[name].subgroup) or nil
			updatedUnits[name].oldrank     = (oldRoster[name] and oldRoster[name].rank) or nil
			updatedUnits[name].name        = self.roster[name].name
			updatedUnits[name].unitid      = self.roster[name].unitid
			updatedUnits[name].class       = self.roster[name].class
			updatedUnits[name].subgroup    = self.roster[name].subgroup
			updatedUnits[name].rank        = self.roster[name].rank
		end
	end
	-- STEP 4: now delete the old units in roster that have left your group
	for name in pairs(self.roster) do
		if not self.roster[name].unitid then
			if Compost then Compost:Reclaim(self.roster[name]) end
			self.roster[name] = nil
			updatedUnits[name]             = Compost and Compost:Acquire() or {}
			updatedUnits[name].oldname     = oldRoster[name].name
			updatedUnits[name].oldunitid   = oldRoster[name].unitid
			updatedUnits[name].oldclass    = oldRoster[name].class
			updatedUnits[name].oldsubgroup = oldRoster[name].subgroup
			updatedUnits[name].oldrank     = oldRoster[name].rank
		end
	end
	-- STEP 5: save the number of units, we need that in RosterValid()
	rosterCount = 0
	for name in pairs(self.roster) do rosterCount = rosterCount + 1 end
	-- STEP 6: clear oldRoster
	if Compost then Compost:Reclaim(oldRoster, 1) end
	-- STEP 6: we're done. Hopefully.
	self:CheckRoster(true)
end


------------------------------------------------
-- API
------------------------------------------------

function RosterLib:GetUnitIDFromName(name)
	if rosterAvailable and self.roster[name] then
		return self.roster[name].unitid
	else
		return nil
	end
end


function RosterLib:GetUnitIDFromUnit(unit)
	local name = UnitName(unit)
	if rosterAvailable and name and self.roster[name] then
		return self.roster[name].unitid
	else
		return nil
	end
end


function RosterLib:GetUnitObjectFromName(name)
	if rosterAvailable and self.roster[name] then
		return self.roster[name]
	else
		return nil
	end
end


function RosterLib:GetUnitObjectFromUnit(unit)
	local name = UnitName(unit)
	if rosterAvailable and self.roster[name] then
		return self.roster[name]
	else
		return nil
	end
end


function RosterLib:IterateRoster(pets)
	local key
	return function()
		key = next(self.roster, key)
		if key and (pets or self.roster[key].class ~= "PET") then
			return self.roster[key]
		end
	end
end


--[[
TODO:
- use events AceEvent_EventRegistered, AceEvent_EventUnregistered plus :IsEventRegistered("event") to see if we can disable the library
- optimize GC in IterateRoster()
]]


AceLibrary:Register(RosterLib, MAJOR_VERSION, MINOR_VERSION, activate)
RosterLib = AceLibrary(MAJOR_VERSION)

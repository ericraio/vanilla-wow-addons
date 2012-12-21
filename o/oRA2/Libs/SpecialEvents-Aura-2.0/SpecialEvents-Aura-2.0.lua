--[[
Name: SpecialEvents-Aura-2.0
Revision: $Rev: 14863 $
Author: Tekkub Stoutwrithe (tekkub@gmail.com)
Website: http://www.wowace.com/
Description: Special events for Aura's, (de)buffs gained, lost etc.
Dependencies: AceLibrary, AceEvent-2.0, Gratuity-2.0
]]


local vmajor, vminor = "SpecialEvents-Aura-2.0", "$Revision: 14863 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(vmajor .. " requires AceEvent-2.0.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end

local lib = {}
AceLibrary("AceEvent-2.0"):embed(lib)

local gratuity = AceLibrary("Gratuity-2.0")
local RL
local debuffTextureCache = {}
local buffTextureCache = {}

local table_setn
do
	local version = GetBuildInfo()
	if string.find(version, "^2%.") then
		-- 2.0.0
		table_setn = function() end
	else
		table_setn = table.setn
	end
end

----------------------------
--      Compost Heap      --
----------------------------

local heap = {}
setmetatable(heap, {__mode = "kv"})


local function acquire(a1,a2,a3,a4,a5)
	local t = next(heap)
	if t then
		heap[t] = nil
		assert(not next(t), "A table in the compost heap has been modified!")
	end
	t = t or {}

	if a1 ~= nil then table.insert(t, a1) end
	if a2 ~= nil then table.insert(t, a2) end
	if a3 ~= nil then table.insert(t, a3) end
	if a4 ~= nil then table.insert(t, a4) end
	if a5 ~= nil then table.insert(t, a5) end
	return t
end


local function reclaim(t, d)
	if type(t) ~= "table" then return end

	if d and d > 0 then
		for i in pairs(t) do
			if type(t[i]) == "table" then reclaim(t[i], d - 1) end
		end
	end

	for i in pairs(t) do t[i] = nil end
	t.reset = 1
	t.reset = nil
	table_setn(t, 0)

	heap[t] = true
end


----------------------------
--     Initialization     --
----------------------------

local function registerevents(self)
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterEvent("UNIT_AURA", "AuraScan")
	self:RegisterEvent("UNIT_AURASTATE", "AuraScan")
	self:RegisterEvent("PLAYER_AURAS_CHANGED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	-- check if RosterLib exists. We need to do that here and not earlier.
	RL = AceLibrary:HasInstance("RosterLib-2.0") and AceLibrary("RosterLib-2.0") or nil
	if RL then
		RL:Enable()
		self:RegisterBucketEvent("RosterLib_UnitChanged",0.2)
	else
		self:RegisterEvent("PARTY_MEMBERS_CHANGED",1)
		self:RegisterEvent("RAID_ROSTER_UPDATE",1)
	end
end


-- Activate a new instance of this library
function activate(self, oldLib, oldDeactivate)
	if oldLib then
		self.vars = oldLib.vars
		if oldLib:IsEventRegistered("UNIT_AURA") then registerevents(self) end
		if oldLib:IsEventRegistered("RosterLib_UnitChanged") then
			if RL then RL:Disable() end
			oldLib:UnregisterAllEvents()
		end
	else self.vars = {buffs = {}, debuffs = {}} end

	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	if oldDeactivate then oldDeactivate(oldLib) end
end


function lib:PLAYER_ENTERING_WORLD()
	self:ScanAllAuras()
	registerevents(self)
end


function lib:PLAYER_LEAVING_WORLD()
	self:UnregisterAllEvents()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	if RL then
		RL:Disable()
	end
end


--------------------------------
--      Tracking methods      --
--------------------------------

function lib:PLAYER_AURAS_CHANGED()
	self:AuraScan("player")
	if GetNumRaidMembers() > 0 then
		local u
		for i=1,GetNumRaidMembers() do
			if UnitIsUnit("raid"..i, "player") then u = "raid"..i end
		end
		self:AuraScan(u)
	end
end


function lib:PLAYER_TARGET_CHANGED()
	self:AuraScan("target")
	self:TriggerEvent("SpecialEvents_AuraTargetChanged")
end


function lib:RosterLib_UnitChanged(units)
	for unit in pairs(units) do
		if unit and UnitExists(unit) then
			self:AuraScan(unit)
		end
	end
	if GetNumRaidMembers() > 0 then
		self:TriggerEvent("SpecialEvents_AuraRaidRosterUpdate")
	else
		self:TriggerEvent("SpecialEvents_AuraPartyMembersChanged")
	end
end


function lib:PARTY_MEMBERS_CHANGED()
	if UnitExists("pet") then self:AuraScan("pet") end

	for i=1,4 do
		if UnitExists("party"..i) then self:AuraScan("party"..i) end
		if UnitExists("partypet"..i) then self:AuraScan("partypet"..i) end
	end
	self:TriggerEvent("SpecialEvents_AuraPartyMembersChanged")
end


function lib:RAID_ROSTER_UPDATE()
	for i=1,40 do
		if UnitExists("raid"..i) then self:AuraScan("raid"..i) end
		if UnitExists("raidpet"..i) then self:AuraScan("raidpet"..i) end
	end
	self:TriggerEvent("SpecialEvents_AuraRaidRosterUpdate")
end

function lib:PLAYER_REGEN_ENABLED()
	reclaim(debuffTextureCache)
	debuffTextureCache = acquire()
	reclaim(buffTextureCache)
	buffTextureCache = acquire()
end

function lib:ScanAllAuras()
	if UnitExists("player") then self:AuraScan("player") end
	if UnitExists("pet") then self:AuraScan("pet") end

	for i=1,4 do
		if UnitExists("party"..i) then self:AuraScan("party"..i) end
		if UnitExists("partypet"..i) then self:AuraScan("partypet"..i) end
	end

	for i=1,40 do
		if UnitExists("raid"..i) then self:AuraScan("raid"..i) end
		if UnitExists("raidpet"..i) then self:AuraScan("raidpet"..i) end
	end

	if UnitExists("target") then self:AuraScan("target") end
--~~ 	if UnitExists("mouseover") then self:AuraScan("mouseover") end
end


function lib:AuraScan(targ)
	local maxbuffs, maxdebuffs, t = 16, 16, targ or arg1
	local oldd, oldb = self.vars.debuffs[t], self.vars.buffs[t]
	local newd, newb = acquire(), acquire()

	if t == "player" then
		for i=0,(maxbuffs-1) do
			local bidx = GetPlayerBuff(i, "HELPFUL")
			if bidx and bidx ~= -1 then
				gratuity:SetPlayerBuff(bidx)
				local txt = gratuity:GetLine(1)
				if txt then newb[txt] = i end
			end
		end

		for i=0,(maxdebuffs-1) do
			local didx = GetPlayerBuff(i, "HARMFUL")
			if didx and didx ~= -1 then
				gratuity:SetPlayerBuff(didx)
				local txt, txtr = gratuity:GetLine(1)

				local apps = GetPlayerBuffApplications(didx)
				local texture = GetPlayerBuffTexture(didx)
				local dbtype = GetPlayerBuffDispelType(didx)

				if txt then
					local txtindex = txt
					if texture then txtindex = txtindex..texture end
					newd[txtindex] = acquire(i, txt, apps, dbtype, texture)
				end
			end
		end
	else
		for i=1,maxbuffs do
			local txt
			local texture, apps = UnitBuff (t, i)
			if texture then
				if not buffTextureCache[texture] then
					gratuity:SetUnitBuff(t,i)
					txt = gratuity:GetLine(1)
					buffTextureCache[texture] = txt
				else
					txt = buffTextureCache[texture]
				end
				if txt then newb[txt] = i end
			end
		end

		for i=1,maxdebuffs do
			local txt
			local texture, apps, dbtype = UnitDebuff (t, i)
			if texture then
				if not debuffTextureCache[texture] then
					gratuity:SetUnitDebuff(t,i)
					txt = gratuity:GetLine(1)
					debuffTextureCache[texture] = txt
				else
					txt = debuffTextureCache[texture]
				end
				if txt then
					local txtindex = txt .. texture
					reclaim(newd[txtindex])
					newd[txtindex] = acquire(i, txt, apps, dbtype, texture)
				end
			end
		end
	end

	self.vars.buffs[t] = newb
	self.vars.debuffs[t] = newd

	if oldb then
		for b,i in pairs(oldb) do
			if not newb[b] then
				self:TriggerEvent("SpecialEvents_UnitBuffLost", t, b)
				if t == "player" then self:TriggerEvent("SpecialEvents_PlayerBuffLost", b) end
			end
		end
	end

	if oldd then
		for d,i in pairs(oldd) do
			if type(i) ~= "table" then
				local t = ""
				for d,i in pairs(oldd) do t = t.." "..d.."="..i end
				error(string.format("Debuff error! Unit: %s, Table dump:%s", targ, t))
			elseif not newd[d] then
				self:TriggerEvent("SpecialEvents_UnitDebuffLost", t, i[2], i[3], i[4], i[5])
				if t == "player" then self:TriggerEvent("SpecialEvents_PlayerDebuffLost", i[2], i[3], i[4], i[5]) end
			end
		end
	end

	for b,i in pairs(newb) do
		if (not oldb or not oldb[b]) then
			self:TriggerEvent("SpecialEvents_UnitBuffGained", t, b)
			if t == "player" then self:TriggerEvent("SpecialEvents_PlayerBuffGained", b, i) end
		end
	end

	for d,i in pairs(newd) do
		assert(type(i) == "table", string.format("Debuff: %s - Value not a table: %s", d, type(i) == "table" and "table" or i or "nil"))

		local o2 = oldd and type(oldd[d]) == "table" and oldd[d][2]
		if not o2 or o2 ~= i[2] then
			self:TriggerEvent("SpecialEvents_UnitDebuffGained", t, i[2], i[3], i[4], i[5])
			if t == "player" then self:TriggerEvent("SpecialEvents_PlayerDebuffGained", i[2], i[3], i[4], i[5]) end
		end
	end

	reclaim(oldb)
	reclaim(oldd, 1)
end


-----------------------------
--      Query Methods      --
-----------------------------

function lib:UnitHasBuff(targ, buff)
	if self.vars.buffs[targ] then return self.vars.buffs[targ][buff] end
end


function lib:UnitHasDebuff(targ, debuff)
	if self.vars.debuffs[targ] then
		for i, v in pairs(self.vars.debuffs[targ]) do
			if v[2] == debuff then
				return v[1], v[3]
			end
		end
	end
end


function lib:UnitHasDebuffType(targ, debufftype)
	if self.vars.debuffs[targ] then
		for i,v in pairs(self.vars.debuffs[targ]) do
			if v[4] == debufftype then return v end
		end
	end
end


function lib:BuffIter(unitid)
	local f = function(unitid, i)
		if not self.vars.buffs[unitid] then return end
		local idx = next(self.vars.buffs[unitid], i)
		local v = self.vars.buffs[unitid][idx]
		if v then return idx, v end
	end
	return f, unitid, nil
end

function lib:DebuffIter(unitid)
	local idx = nil
	local f = function(unitid)
		if not self.vars.debuffs[unitid] then return end
		idx = next(self.vars.debuffs[unitid], idx)
		local v = self.vars.debuffs[unitid][idx]
		if v then return v[2], v[3], v[4], v[5] end
	end
	return f, unitid, nil
end

--------------------------------
--      Load this bitch!      --
--------------------------------
AceLibrary:Register(lib, vmajor, vminor, activate)

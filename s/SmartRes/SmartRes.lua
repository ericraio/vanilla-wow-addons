--[[---------------------------------------------------------------------------------
 locals
------------------------------------------------------------------------------------]]

BINDING_HEADER_SMARTRES = "SmartRes"
BINDING_NAME_RES = "Resurrect"

local resTable        = {}
local resAttempt      = {}
local enabled         = {}
local isCasting       = nil
local resSpell        = ""
local corpseCount     = 0
local class           = ""

local BS              = AceLibrary("Babble-Spell-2.2")

local resSpell        = {
	PRIEST            = BS["Resurrection"],
	SHAMAN            = BS["Ancestral Spirit"],
	PALADIN           = BS["Redemption"]
}

local locals          = {
	NotGrouped        = "You're not in a group.",
	NotInRange        = "No one in range to res or you're out of mana.",
	NoDeadUnits       = "Coudnt't find any dead (non-released) units.",
	AllDeadRessed     = "All dead units are already being ressed.",
}

--[[---------------------------------------------------------------------------------
 defaults and AceOptions table
------------------------------------------------------------------------------------]]

local defaults = {
    ResMessage = "Ressing: %s",
	ChannelType = "SAY",
	CustomChannel = "OFF",
	CustomChannelName = nil
}

local options = {
	type = 'group',
	args = {
		res = {
			type = 'execute',
			name = "Resurrect", 
		    desc = "Will attempt to resurrect a grouped player",
		    func = function()
		        SmartRes:Resurrect()
		    end
		},
		msgtype = {
			type = 'text',
			name = "Message Type", 
			desc = "Set the Res Message output channel type.  (Valid Types: SAY, YELL, PARTY, RAID, GUILD, OFFICER) Setting the channel type to 'OFF' will disable this feature.",
			validate = {"SAY", "YELL", "PARTY", "RAID", "GUILD", "OFFICER", "OFF"},
			get = function() return SmartRes.db.profile.ChannelType end,
			set = function(text)
				SmartRes.db.profile.ChannelType = text
			end
		},
		msg = {
			type = 'text',
			name = "Res Message", 
			desc = "Change the Res Message.",
			get = function()
				return string.format(SmartRes.db.profile.ResMessage, "%s")
			end,
			set = function(text)
				SmartRes.db.profile.ResMessage = text
			end,
			usage = "<msg> (Example: Ressing: %s) **Be sure to include %s where you want the target's name to be**"
		},
		chan = {
			type = 'text',
			name = "Custom Channel", 
			desc = "Send the Res Message to a custom chat channel.",
			validate = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "OFF"},
			get = function() 
				if SmartRes.db.profile.CustomChannel ~= "OFF" then 
					return SmartRes.db.profile.CustomChannel..". "..SmartRes.db.profile.CustomChannelName
				end
			end,
			set = function(num)
				SmartRes:SetCustomChan(num)
			end
		},
		reset = {
			type = 'execute',
			name = "Reset",
		    desc = "Resets SmartRes to the default settings",
		    func = function()
				SmartRes:ResetDB("profile")
		        SmartRes:Print("All options have been reset to default.")
		    end
		}
	}
}

--[[---------------------------------------------------------------------------------
 Initialization
------------------------------------------------------------------------------------]]

SmartRes = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")


function SmartRes:OnInitialize()
	self:RegisterDB("SmartResDB")
	self:RegisterDefaults('profile', defaults )
	self:RegisterChatCommand({ "/smartres", "/sr" }, options )
end


function SmartRes:OnEnable()
	_,class = UnitClass("player")
	if not resSpell[class] then return end
	enabled = true
	self:RegisterEvent("SPELLCAST_START", function() isCasting = true end )
	self:RegisterEvent("SPELLCAST_STOP", function() isCasting = false end )
	self:RegisterEvent("SPELLCAST_FAILED", function() isCasting = false end )
	self:RegisterEvent("SPELLCAST_INTERRUPTED", function() isCasting = false end )
end


function SmartRes:OnDisable()
	enabled = nil
end

--[[---------------------------------------------------------------------------------
 The real stuff
------------------------------------------------------------------------------------]]

function SmartRes:SetCustomChan(num)
	if num == "OFF" then
		self.db.profile.CustomChannel = "OFF"
		self.db.profile.CustomChannelName = nil
		return
	end
	local id, channame = GetChannelName(num)
	if id ~= 0 then
		self.db.profile.CustomChannel = id
		self.db.profile.CustomChannelName = channame
	end
end


function SmartRes:Resurrect()
	if not enabled then 
		self:Print("Mod not 'enabled', bypassing function") 
		return
	end
	if isCasting then return end
	if GetNumPartyMembers() == 0 then
		self:Print(locals.NotGrouped)
		return
	end	
	resTable = {}
	if UnitInRaid("player") then
		self:BuildResTable("raid")
	else
		self:BuildResTable("party")
	end
	if corpseCount == 0 then
		self:Print(locals.NoDeadUnits)
		return
	end
	if corpseCount - corpseCountRessed == 0 then
		self:Print(locals.AllDeadRessed)
		return
	end
	table.sort( resTable, function(a,b) return a[2] < b[2] end )
	CastSpellByName(resSpell[class],0)
	local corpse = self:ChooseDeadUnitInRange()
	if corpse then 
		SpellTargetUnit(corpse)
		resAttempt[UnitName(corpse)] = GetTime()
		if not SpellIsTargeting() then
			if self.db.profile.ChannelType ~= "OFF" then 
				SendChatMessage(string.format(self.db.profile.ResMessage, UnitName(corpse)), self.db.profile.ChannelType)
			end
			if self.db.profile.CustomChannel ~= "OFF" then 
				local chanid, channame = GetChannelName(self.db.profile.CustomChannel)
				if (chanid == self.db.profile.CustomChannel and channame == self.db.profile.CustomChannelName) then
					SendChatMessage(string.format(self.db.profile.ResMessage, UnitName(corpse)), "CHANNEL", nil, self.db.profile.CustomChannel)
				end
			end
		else
			SpellStopTargeting()
		end
	else
		SpellStopTargeting()
		self:Print(locals.NotInRange)
	end
end


function SmartRes:BuildResTable(type)
	local x
	if type == "raid" then x = GetNumRaidMembers()
	elseif type == "party" then x = GetNumPartyMembers()
	end
	corpseCount = 0
	corpseCountRessed = 0
	for i = 1, x do
		if UnitIsConnected(type..i) then
			if UnitIsDead(type..i) then
				corpseCount = corpseCount + 1
				if not self:UnitDoesntNeedRes(UnitName(type..i)) then
					tinsert(resTable, { type..i, self:GetResModifier(type..i) })
				else
					corpseCountRessed = corpseCountRessed + 1
				end
			else
				local name = UnitName(type..i)
				if resAttempt[name] then
					resAttempt[name] = nil
				end
			end
		end
	end
end


function SmartRes:GetResModifier(unit)
	local m = 0
	local _,c = UnitClass(unit)
	if     c == "PRIEST"   then m = 0
	elseif c == "SHAMAN"   then m = 5
	elseif c == "PALADIN"  then m = 5
	elseif c == "DRUID"    then m = 10
	elseif c == "MAGE"     then m = 15
	elseif c == "WARRIOR"  then m = 20
	elseif c == "WARLOCK"  then m = 25
	elseif c == "HUNTER"   then m = 30
	elseif c == "ROGUE"    then m = 35
	end
	if UnitInParty(unit) then m = m - 1 end
	-- we don't want to get stuck on someone out of LOS
	m = m + math.random(5)
	return m
end


function SmartRes:UnitDoesntNeedRes(name)
	-- check who we attempted to res in the past minute:
	if resAttempt[name] then
		if GetTime() - resAttempt[name] < 60 then
			return true
		end
	end
	-- see who is being ressed by others this moment
	if CT_RA_Ressers then 
		for key, val in CT_RA_Ressers do
			if val == name then
				return true
			end
		end
	end	
	if oRA_Resurrection and oRA_Resurrection.ressers then
		for key, val in oRA_Resurrection.ressers do
			if val == name then
				return true
			end
		end
	end
	if oRAOResurrection and oRAOResurrection.ressers then
		for key, val in oRAOResurrection.ressers do
			if val == name then
				return true
			end
		end
	end
	-- see who's ressed already
	if CT_RA_Stats and
	CT_RA_Stats[name] and 
	CT_RA_Stats[name]["Ressed"] and 
	CT_RA_Stats[name]["Ressed"] == 1 then
		return true
	end
	return false
end


function SmartRes:ChooseDeadUnitInRange()
	for key, val in resTable do
		if SpellCanTargetUnit(val[1]) then
			return val[1]
		end
	end
	return nil
end


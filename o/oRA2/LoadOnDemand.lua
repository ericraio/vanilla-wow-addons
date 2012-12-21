
------------------------------
--      Are you local?      --
------------------------------

local LC = AceLibrary("AceLocale-2.2"):new("oRA")

local withcore = {}
local asleader = {}

------------------------------
--    Addon Declaration     --
------------------------------

oRALoD = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")

------------------------------
--      Initialization      --
------------------------------

function oRALoD:OnInitialize()
	self.roster = AceLibrary("RosterLib-2.0")
	self:InitializeLoD()
end

function oRALoD:OnEnable()

	self:RegisterEvent("RosterLib_UnitChanged")
	self:RegisterEvent("oRA_CoreEnabled")

	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("oRA_JoinedGroup")
	self:RegisterEvent("oRA_LeftGroup")
	self:RegisterEvent("oRA_PlayerPromoted")

	self:ScheduleRepeatingEvent("oRALoDCheckPromote", function() if IsRaidLeader() or IsRaidOfficer() then self:TriggerEvent("oRA_PlayerPromoted") end end, 5 )

	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() then
		if IsRaidLeader() or IsRaidOfficer() then
			self:TriggerEvent("oRA_PlayerPromoted")
		end
	else
		self:RegisterEvent("AceEvent_FullyInitialized", function() if IsRaidLeader() or IsRaidOfficer() then self:TriggerEvent("oRA_PlayerPromoted") end end )
	end
end

------------------------------
--     Event Handlers       --
------------------------------

function oRALoD:oRA_CoreEnabled()

	local loaded = false
	for k,v in pairs( withcore ) do
		if not IsAddOnLoaded( v ) then
			loaded = true
			LoadAddOn( v )
		end
	end	

	withcore = {}

	-- Fire an event to have the target monitor check it's stuff
	if loaded then
		self:TriggerEvent("oRA_ModulePackLoaded")
	end
end

function oRALoD:oRA_PlayerPromoted()
	for k,v in pairs( asleader ) do
		if not IsAddOnLoaded( v ) then
			loaded = true
			LoadAddOn( v )
		end
	end	

	asleader = {}

	-- loaded the stuff, no need for these events anymore
	if self:IsEventRegistered("oRA_PlayerPromoted") then self:UnregisterEvent("oRA_PlayerPromoted") end
	if self:IsEventRegistered("RosterLib_UnitChanged") then self:UnregisterEvent("RosterLib_UnitChanged") end
	if self:IsEventScheduled("oRALoDCheckPromote") then self:CancelScheduledEvent("oRALoDCheckPromote") end
	
	if loaded then
		self:TriggerEvent("oRA_ModulePackLoaded")
		self:TriggerEvent("oRA_JoinedRaid")
	end
end

function oRALoD:CHAT_MSG_SYSTEM( msg )
	if string.find(msg, "^"..ERR_RAID_YOU_LEFT) then
		self:TriggerEvent("oRA_LeftGroup")
	elseif string.find(msg, ERR_RAID_YOU_JOINED) then
		self:TriggerEvent("oRA_JoinedGroup")
	end
end

function oRALoD:oRA_JoinedGroup()
	oRA:ToggleActive(true)
	-- Right when joining a raid oRA might not have detected it yet, so we fire the joined event.
	self:TriggerEvent("oRA_JoinedRaid")
end

function oRALoD:oRA_LeftGroup()
	oRA:ToggleActive(false)
end

function oRALoD:RosterLib_UnitChanged( id, name, class, subgroup, rank, oldname, oldid, oldclass, oldsubgroup, oldrank )
	if name == UnitName("player") and rank > 0 then
		self:TriggerEvent("oRA_PlayerPromoted")
	end
end

------------------------------
--     Utility Functions    --
------------------------------

function oRALoD:InitializeLoD()
	local numAddons = GetNumAddOns()
	for i = 1, numAddons do
		if not IsAddOnLoaded(i) and IsAddOnLoadOnDemand(i) then
			local meta = GetAddOnMetadata(i, "X-oRA-LoadAsLeader")
			if meta then
				table.insert( asleader, i )
			end
			meta = GetAddOnMetadata(i, "X-oRA-LoadWithCore")
			if meta then
				-- register this addon for loading with core
				table.insert( withcore, i )
			end
		end
	end
end


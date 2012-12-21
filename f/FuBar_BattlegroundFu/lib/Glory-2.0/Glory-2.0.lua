--[[
Name: Glory-2.0
Revision: $Rev: 11849 $
Author(s): ckknight (ckknight@gmail.com)
           Elkano (elkano@gmx.de)
           hyperactiveChipmunk (hyperactiveChipmunk@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Glory-2.0
SVN: http://svn.wowace.com/root/trunk/GloryLib/Glory-2.0
Description: A library for PvP and Battlegrounds.
Dependencies: AceLibrary, Babble-Zone-2.0, Deformat-2.0, AceEvent-2.0, AceConsole-2.0 (optional)

Notes: To use this library, the per-character saved variable Glory2DB must be available.
]]

local MAJOR_VERSION = "Glory-2.0"
local MINOR_VERSION = "$Revision: 11849 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("Babble-Zone-2.0") then error(MAJOR_VERSION .. " requires Babble-Zone-2.0") end
if not AceLibrary:HasInstance("Deformat-2.0") then error(MAJOR_VERSION .. " requires Deformat-2.0") end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(MAJOR_VERSION .. " requires AceEvent-2.0") end

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

local math_mod = math.fmod or math.mod

local new, del
do
	local list = setmetatable({}, {__mode="k"})
	function new()
		local t = next(list)
		if t then
			list[t] = nil
			return t
		else
			return {}
		end
	end
	function del(t)
		setmetatable(t, nil)
		for k in pairs(t) do
			t[k] = nil
		end
		table_setn(t, 0)
		list[t] = true
	end
end

local PATTERN_HORDE_FLAG_PICKED_UP, PATTERN_HORDE_FLAG_DROPPED, PATTERN_HORDE_FLAG_CAPTURED, PATTERN_ALLIANCE_FLAG_PICKED_UP, PATTERN_ALLIANCE_FLAG_DROPPED, PATTERN_ALLIANCE_FLAG_CAPTURED, FACTION_DEFILERS, FACTION_FROSTWOLF_CLAN, FACTION_WARSONG_OUTRIDERS, FACTION_LEAGUE_OF_ARATHOR, FACTION_STORMPIKE_GUARD, FACTION_SILVERWING_SENTINELS

local PATTERN_GWSUII_SCORE, PATTERN_GWSUII_BASES
local BGObjectiveDescriptions, BGChatAnnouncements, BGPatternReplacements, BGAcronyms, BattlefieldZoneObjectiveTimes, BattlefieldZoneResourceData   --hC

local deformat = AceLibrary("Deformat-2.0")
local Z = AceLibrary("Babble-Zone-2.0")
local AceEvent = AceLibrary("AceEvent-2.0")

local WARSONG_GULCH = Z["Warsong Gulch"]
local ALTERAC_VALLEY = Z["Alterac Valley"]
local ARATHI_BASIN = Z["Arathi Basin"]

local locale = GetLocale()
if locale ~= "deDE" then
	locale = "enUS"
end

if locale == "enUS" then
	PATTERN_HORDE_FLAG_PICKED_UP = "The Horde [Ff]lag was picked up by ([^!]+)!"
	PATTERN_HORDE_FLAG_DROPPED = "The Horde [Ff]lag was dropped by (%a+)!"
	PATTERN_HORDE_FLAG_CAPTURED = "(%a+) captured the Horde [Ff]lag!"
	PATTERN_ALLIANCE_FLAG_PICKED_UP = "The Alliance [Ff]lag was picked up by (%a+)!"
	PATTERN_ALLIANCE_FLAG_DROPPED = "The Alliance [Ff]lag was dropped by (%a+)!"
	PATTERN_ALLIANCE_FLAG_CAPTURED = "(%a+) captured the Alliance [Ff]lag!"
	
	FACTION_DEFILERS = "Defilers"
	FACTION_FROSTWOLF_CLAN = "Frostwolf Clan"
	FACTION_WARSONG_OUTRIDERS = "Warsong Outriders"
	
	FACTION_LEAGUE_OF_ARATHOR = "League of Arathor"
	FACTION_STORMPIKE_GUARD = "Stormpike Guard"
	FACTION_SILVERWING_SENTINELS = "Silverwing Sentinels"
	
	BGObjectiveDescriptions = {
		ALLIANCE_CONTROLLED = "Alliance Controlled",
		HORDE_CONTROLLED = "Horde Controlled",
		IN_CONFLICT = "In Conflict",
		UNCONTROLLED = "Uncontrolled",
		DESTROYED = "Destroyed",
	}

	BGChatAnnouncements = {
		BGObjectiveClaimedAnnouncements = {
			PATTERN_OBJECTIVE_CLAIMED_AB = "claims the ([%w ]+).* (%a+) will control",
		},

		BGObjectiveAttackedAnnouncements = {
			PATTERN_OBJECTIVE_ATTACKED_AB = "assaulted the ([%w ]+)",
			PATTERN_OBJECTIVE_ATTACKED_AV0 = "The ([%w ]+) is under attack",
			PATTERN_OBJECTIVE_ATTACKED_AV1 = "^([%w ]+) is under attack",
		},

		BGObjectiveDefendedAnnouncements = {
			PATTERN_OBJECTIVE_DEFENDED_AB = "defended the ([%w ]+)",
		},

		BGObjectiveCapturedAnnouncements = {
			PATTERN_OBJECTIVE_CAPTURED_AB = "The (%a+) has taken the ([%w ]+)",
			PATTERN_OBJECTIVE_CAPTURED_AV0 = "The ([%w ]+) was taken by the (%a+)",
			PATTERN_OBJECTIVE_CAPTURED_AV1 = "^([%w ]+) was taken by the (%a+)",
			PATTERN_OBJECTIVE_CAPTURED_AV2 = "the ([%w ]+) is.*MINE", --and the Irondeep Mine is...MINE!
			PATTERN_OBJECTIVE_CAPTURED_AV3 = "claims the ([%w ]+)",   --Snivvle claims the Coldtooth Mine!
		},

		BGObjectiveDestroyedAnnouncements = {
			PATTERN_OBJECTIVE_DESTROYED_AV0 = "The ([%w ]+) was destroyed",
			PATTERN_OBJECTIVE_DESTROYED_AV1 = "^([%w ]+) was destroyed",
		},
	}

	BGPatternReplacements = {
		["mine"] = "gold mine",
		["southern farm"] = "farm"
	}

	BGAcronyms = {
		[ALTERAC_VALLEY] = "AV",
		[ARATHI_BASIN] = "AB",
		[WARSONG_GULCH] = "WSG",
	}

	PATTERN_GWSUII_SCORE = "(%d+/%d+)"			  --for lifting the score out of the first return value of GetWorldStateUIInfo(index)
	PATTERN_GWSUII_BASES = "Bases: (%d+)"		   --for lifting the number of bases held in Arathi Basin
	PATTERN_GWSUII_RESOURCES = "Resources: (%d+)"   --for lifting the number of bases held in Arathi Basin
	PATTERN_OBJECTIVE_HOLDER = "([%w ]+) Controlled"

elseif locale == "deDE" then
	PATTERN_HORDE_FLAG_PICKED_UP = "([^!]+) hat die [Ff]lagge der Horde aufgenommen!"
	PATTERN_HORDE_FLAG_DROPPED = "(%a+) hat die [Ff]lagge der Horde fallen lassen!"
	PATTERN_HORDE_FLAG_CAPTURED = "(%a+) hat die [Ff]lagge der Horde errungen!"
	PATTERN_ALLIANCE_FLAG_PICKED_UP = "(%a+) hat die [Ff]lagge der Allianz aufgenommen!"
	PATTERN_ALLIANCE_FLAG_DROPPED = "(%a+) hat die [Ff]lagge der Allianz fallen lassen!"
	PATTERN_ALLIANCE_FLAG_CAPTURED = "(%a+) hat die [Ff]lagge der Allianz errungen!"
	
	FACTION_DEFILERS = "Die Entweihten"
	FACTION_FROSTWOLF_CLAN = "Frostwolfklan"
	FACTION_WARSONG_OUTRIDERS = "Warsongvorhut"
	
	FACTION_LEAGUE_OF_ARATHOR = "Liga von Arathor"
	FACTION_STORMPIKE_GUARD = "Stormpike Garde"
	FACTION_SILVERWING_SENTINELS = "Silverwing Schildwache"
	
	BGObjectiveDescriptions = {
		ALLIANCE_CONTROLLED = "Kontrolliert von der Allianz",
		HORDE_CONTROLLED = "Kontrolliert von der Horde",
		IN_CONFLICT = "Umk\195\164mpft",
		UNCONTROLLED = "Unkontrolliert",
		DESTROYED = "Zerst\195\182rt",
	}

	BGChatAnnouncements = {
		BGObjectiveClaimedAnnouncements = {
			PATTERN_OBJECTIVE_CLAIMED_AB0 = "hat das (.+) besetzt.* die (%a+) in",
			PATTERN_OBJECTIVE_CLAIMED_AB1 = "hat den (.+) besetzt.* die (%a+) in",
			PATTERN_OBJECTIVE_CLAIMED_AB2 = "hat die (.+) besetzt.* die (%a+) in",
			PATTERN_OBJECTIVE_CLAIMED_AB3 = "hat (S\195\164gewerk) besetzt.* die (%a+) in",
			PATTERN_OBJECTIVE_CLAIMED_AV0 = "hat den (.+) besetzt.* erlangt die (%a+) die Kontrolle"
		},

		BGObjectiveAttackedAnnouncements = {
			PATTERN_OBJECTIVE_ATTACKED_AB0 = "das (.+) angegriffen",
			PATTERN_OBJECTIVE_ATTACKED_AB1 = "den (.+) angegriffen",
			PATTERN_OBJECTIVE_ATTACKED_AB2 = "die (.+) angegriffen",
			PATTERN_OBJECTIVE_ATTACKED_AV0 = "Das (.+) wird angegriffen.*wird die (%a+) es",
			PATTERN_OBJECTIVE_ATTACKED_AV1 = "Der (.+) wird angegriffen.*wird die (%a+) ihn",
			PATTERN_OBJECTIVE_ATTACKED_AV2 = "Die (.+) wird angegriffen.*wird die (%a+) sie",
		},

		BGObjectiveDefendedAnnouncements = {
			PATTERN_OBJECTIVE_DEFENDED_AB0 = "das (.+) verteidigt",
			PATTERN_OBJECTIVE_DEFENDED_AB1 = "den (.+) verteidigt",
			PATTERN_OBJECTIVE_DEFENDED_AB2 = "die (.+) verteidigt",
		},

		BGObjectiveCapturedAnnouncements = {
			PATTERN_OBJECTIVE_CAPTURED_AB0 = "Die (%a+) hat das (.+) eingenommen",
			PATTERN_OBJECTIVE_CAPTURED_AB1 = "Die (%a+) hat den (.+) eingenommen",
			PATTERN_OBJECTIVE_CAPTURED_AB2 = "Die (%a+) hat die (.+) eingenommen",
			PATTERN_OBJECTIVE_CAPTURED_AV0 = "Das (.+) wurde von der (%a+) erobert",
			PATTERN_OBJECTIVE_CAPTURED_AV1 = "Der (.+) wurde von der (%a+) erobert",
			PATTERN_OBJECTIVE_CAPTURED_AV2 = "geh\195\182rt jetzt die (.+)!",
		},

		BGObjectiveDestroyedAnnouncements = {
			PATTERN_OBJECTIVE_DESTROYED_AV0 = "Der (.+) wurde von der (%a+) zerst\195\182rt",
		},
	}

	BGPatternReplacements = {
		["Schmiede"] = "Schmied",
		["Mine"] = "Goldmine",
		["s\195\188dlichen Hof"] = "Hof",
	}

	BGAcronyms = {
		[ALTERAC_VALLEY] = "AV", -- CHECK
		[ARATHI_BASIN] = "AB", -- CHECK
		[WARSONG_GULCH] = "WSG", -- CHECK
	}

	PATTERN_GWSUII_SCORE = "(%d+/%d+)"	  --for lifting the score out of the first return value of GetWorldStateUIInfo(index)
	PATTERN_GWSUII_BASES = "Basen: (%d+)"   --for lifting the number of bases held in Arathi Basin
	PATTERN_GWSUII_RESOURCES = "Ressourcen: (%d+)"   --for lifting the number of bases held in Arathi Basin -- CHECK
	PATTERN_OBJECTIVE_HOLDER = "Kontrolliert von der ([%w ]+)"
end

BattlefieldZoneObjectiveTimes = {
	[ARATHI_BASIN] = 62.5,
	[ALTERAC_VALLEY] = 302.5,
}

BattlefieldZoneResourceData = {
	[ARATHI_BASIN] = { [0]=0, 5/6, 10/9, 5/3, 10/3, 30, 2000 }
}

local Glory = {}
local events = {}

AceEvent:embed(events)

local _,race = UnitRace("player")
local isHorde = (race == "Orc" or race == "Troll" or race == "Tauren" or race == "Scourge")
local playerName = UnitName("player")
local playerRealm = GetRealmName()

local enemyList = {}

local function CheckNewWeek(self)
	local _,_,lastWeekHonor,_ = GetPVPLastWeekStats()
	if lastWeekHonor ~= self.data.lastWeek then
		self.data.lastWeek = lastWeekHonor
		events:TriggerEvent("Glory_NewWeek")
	end
end

local function CheckNewDay(self)
	local _,_,yesterdayHonor = GetPVPYesterdayStats()
	local lifetimeHK,_,_ = GetPVPLifetimeStats()	
	if yesterdayHonor ~= self.data.yesterday and not (yesterdayHonor == 0 and lifetimeHK == 0) then
		self.data.yesterday = yesterdayHonor
		self.data.hks = {}
		self.data.todayHK = 0
		self.data.todayHKHonor = 0
		self.data.todayBonusHonor = 0
		self.data.todayDeaths = 0
		events:TriggerEvent("Glory_NewDay")
	end
end

local function IncreaseHKs(self, person)
	self.data.todayHK = self.data.todayHK + 1
	self.data.hks[person] = (self.data.hks[person] or 0) + 1
	return self.data.hks[person]
end

local function IncreaseHKHonor(self, amount)
	self.data.todayHKHonor = self.data.todayHKHonor + amount
end

local function IncreaseBonusHonor(self, amount)
	self.data.todayBonusHonor = self.data.todayBonusHonor + amount
end

local function IncreaseBattlegroundsWins(self)
	if self:IsInAlteracValley() then
		self.data.avWin = self.data.avWin + 1
		events:TriggerEvent("Glory_BGWinAV")
	elseif self:IsInArathiBasin() then
		self.data.abWin = self.data.abWin + 1
		events:TriggerEvent("Glory_BGWinAB")
	else
		self.data.wsgWin = self.data.wsgWin + 1
		events:TriggerEvent("Glory_BGWinWSG")
	end
	events:TriggerEvent("Glory_BGWin")
end

local function IncreaseBattlegroundsLosses(self)
	if self:IsInAlteracValley() then
		self.data.avLoss = self.data.avLoss + 1
		events:TriggerEvent("Glory_BGLossAV")
	elseif self:IsInArathiBasin() then
		self.data.abLoss = self.data.abLoss + 1
		events:TriggerEvent("Glory_BGLossAB")
	else
		self.data.wsgLoss = self.data.wsgLoss + 1
		events:TriggerEvent("Glory_BGLossWSG")
	end
	events:TriggerEvent("Glory_BGLoss")
end

local function IncreaseDeaths(self)
	self.data.todayDeaths = self.data.todayDeaths + 1
	events:TriggerEvent("Glory_Death")
end

local db

local function VerifyData(self)
	if not self.data then
		if type(Glory2DB) ~= "table" then
			Glory2DB = {}
		end
		db = Glory2DB
		if type(db[MAJOR_VERSION]) ~= "table" then
			db[MAJOR_VERSION] = {}
		end
		self.data = db[MAJOR_VERSION]
	elseif db ~= Glory2DB then
		local old = db
		local new = Glory2DB
		if type(new) ~= "table" then
			Glory2DB = old
		else
			for k in pairs(old) do
				if not new[k] then
					new[k] = old[k]
				elseif new[k].time == nil then
					new[k] = old[k]
				elseif old[k].time == nil then
					-- keep new
				elseif new[k].time < old[k].time then
					new[k] = old[k]
				end
			end
			db = new
			self.data = db[MAJOR_VERSION]
		end
	end
	if not self.data.hks then self.data.hks = {} end
	if not self.data.todayDeaths then self.data.todayDeaths = 0 end
	if not self.data.todayHK then self.data.todayHK = 0 end
	if not self.data.todayHKHonor then self.data.todayHKHonor = 0 end
	if not self.data.todayBonusHonor then self.data.todayBonusHonor = 0 end
	if not self.data.wsgWin then self.data.wsgWin = 0 end
	if not self.data.wsgLoss then self.data.wsgLoss = 0 end
	if not self.data.abWin then self.data.abWin = 0 end
	if not self.data.abLoss then self.data.abLoss = 0 end
	if not self.data.avWin then self.data.avWin = 0 end
	if not self.data.avLoss then self.data.avLoss = 0 end
	if not self.data.yesterday then self.data.yesterday = 0 end
	if not self.data.lastWeek then self.data.lastWeek = 0 end
	
	CheckNewDay(self)
	CheckNewWeek(self)
	events:UNIT_PVP_UPDATE()
end

function events:ADDON_LOADED()
	VerifyData(Glory)
end

function events:VARIABLES_LOADED()
	VerifyData(Glory)
end

function events:PLAYER_LOGOUT()
	Glory.data.time = time()
end

function events:CHAT_MSG_COMBAT_HONOR_GAIN(text)
	CheckNewDay(Glory)
	local name, rank, honor = deformat(text, COMBATLOG_HONORGAIN)
	if name then
		local realm = enemyList[name] or playerRealm
		if realm ~= playerRealm then
			name = name .. "-" .. realm
		end
		local kills = IncreaseHKs(Glory, name)
		local factor
		factor = (11 - kills) / 10
		if factor < 0 then
			factor = 0
		end
		local realHonor = ceil(honor * factor)
		IncreaseHKHonor(Glory, realHonor)
		events:TriggerEvent("Glory_GainHK", rank, name, realHonor, kills)
		return
	end
	
	local bonus = deformat(text, COMBATLOG_HONORAWARD)
	if bonus then
		bonus = tonumber(bonus)
		IncreaseBonusHonor(Glory, bonus)
		events:TriggerEvent("Glory_GainBonusHonor", bonus)
	end
end

function events:CHAT_MSG_BG_SYSTEM_NEUTRAL(text)
	if string.find(string.lower(text), string.lower(VICTORY_TEXT0)) then
		if isHorde then
			IncreaseBattlegroundsWins(Glory)
		else
			IncreaseBattlegroundsLosses(Glory)
		end
	elseif string.find(string.lower(text), string.lower(VICTORY_TEXT1)) then
		if not isHorde then
			IncreaseBattlegroundsWins(Glory)
		else
			IncreaseBattlegroundsLosses(Glory)
		end
	end
end

function events:CHAT_MSG_BG_SYSTEM_HORDE(text)
	if Glory:IsInWarsongGulch() then
		local _, _, hordeFC = string.find(text, PATTERN_ALLIANCE_FLAG_PICKED_UP)
		if hordeFC then
			Glory.hordeFC = hordeFC
			events:TriggerEvent("Glory_AllianceFlagPickedUp", Glory.hordeFC)
			events:TriggerEvent("Glory_AllianceFlagCarrierUpdate", Glory.hordeFC)
			if not isHorde then
				events:TriggerEvent("Glory_FriendlyFlagPickedUp", Glory.hordeFC)
				events:TriggerEvent("Glory_FriendlyFlagCarrierUpdate", Glory.hordeFC)
			else
				events:TriggerEvent("Glory_HostileFlagPickedUp", Glory.hordeFC)
				events:TriggerEvent("Glory_HostileFlagCarrierUpdate", Glory.hordeFC)
			end
			return
		end
		
		if string.find(text, PATTERN_ALLIANCE_FLAG_CAPTURED) then
			local hordeFC = Glory.hordeFC
			Glory.allianceFC = nil
			Glory.hordeFC = nil
			events:TriggerEvent("Glory_AllianceFlagCaptured", hordeFC)
			if not isHorde then
				events:TriggerEvent("Glory_FriendlyFlagCaptured", hordeFC)
			else
				events:TriggerEvent("Glory_HostileFlagCaptured", hordeFC)
			end
			events:TriggerEvent("Glory_FriendlyFlagCarrierUpdate", nil)
			events:TriggerEvent("Glory_HostileFlagCarrierUpdate", nil)
			events:TriggerEvent("Glory_AllianceFlagCarrierUpdate", nil)
			events:TriggerEvent("Glory_HordeFlagCarrierUpdate", nil)
			return
		end
		
		if string.find(text, PATTERN_HORDE_FLAG_DROPPED) then
			local allianceFC = Glory.allianceFC
			Glory.allianceFC = nil
			events:TriggerEvent("Glory_HordeFlagDropped", allianceFC)
			if isHorde then
				events:TriggerEvent("Glory_FriendlyFlagDropped", allianceFC)
				events:TriggerEvent("Glory_HostileFlagCarrierUpdate", nil)
			else
				events:TriggerEvent("Glory_HostileFlagDropped", allianceFC)
				events:TriggerEvent("Glory_FriendlyFlagCarrierUpdate", nil)
			end
			return
		end
	elseif Glory:IsInArathiBasin() or Glory:IsInAlteracValley() then
		events:BattlefieldObjectiveEventProcessing(text)
	end
end
 
function events:CHAT_MSG_BG_SYSTEM_ALLIANCE(text)
	if Glory:IsInWarsongGulch() then
		local _, _, allianceFC = string.find(text, PATTERN_HORDE_FLAG_PICKED_UP)
		if allianceFC then
			Glory.allianceFC = allianceFC
			events:TriggerEvent("Glory_HordeFlagPickedUp", Glory.allianceFC)
			if isHorde then
				events:TriggerEvent("Glory_FriendlyFlagPickedUp", Glory.allianceFC)
				events:TriggerEvent("Glory_HostileFlagCarrierUpdate", Glory.allianceFC)
			else
				events:TriggerEvent("Glory_HostileFlagPickedUp", Glory.allianceFC)
				events:TriggerEvent("Glory_FriendlyFlagCarrierUpdate", Glory.allianceFC)
			end
			return
		end
		
		if string.find(text, PATTERN_HORDE_FLAG_CAPTURED) then
			local alliance = Glory.allianceFC
			Glory.allianceFC = nil
			Glory.hordeFC = nil
			events:TriggerEvent("Glory_HordeFlagCaptured", allianceFC)
			if isHorde then
				events:TriggerEvent("Glory_FriendlyFlagCaptured", allianceFC)
			else
				events:TriggerEvent("Glory_HostileFlagCaptured", allianceFC)
			end
			events:TriggerEvent("Glory_FriendlyFlagCarrierUpdate", nil)
			events:TriggerEvent("Glory_HostileFlagCarrierUpdate", nil)
			events:TriggerEvent("Glory_AllianceFlagCarrierUpdate", nil)
			events:TriggerEvent("Glory_HordeFlagCarrierUpdate", nil)
			return
		end
		
		if string.find(text, PATTERN_ALLIANCE_FLAG_DROPPED) then
			local hordeFC = Glory.hordeFC
			Glory.hordeFC = nil
			events:TriggerEvent("Glory_AllianceFlagDropped", hordeFC)
			if not isHorde then
				events:TriggerEvent("Glory_FriendlyFlagDropped", hordeFC)
				events:TriggerEvent("Glory_HostileFlagCarrierUpdate", nil)
			else
				events:TriggerEvent("Glory_HostileFlagDropped", hordeFC)
				events:TriggerEvent("Glory_FriendlyFlagCarrierUpdate", nil)
			end
			return
		end
	elseif Glory:IsInArathiBasin() or Glory:IsInAlteracValley() then
		events:BattlefieldObjectiveEventProcessing(text)
	end
end

function events:CHAT_MSG_MONSTER_YELL(text)
	if Glory:IsInAlteracValley() then
		if string.find(string.lower(text), string.lower(VICTORY_TEXT0)) then
			if isHorde then
				IncreaseBattlegroundsWins(Glory)
			else
				IncreaseBattlegroundsLosses(Glory)
			end
		elseif string.find(string.lower(text), string.lower(VICTORY_TEXT1)) then
			if not isHorde then
				IncreaseBattlegroundsWins(Glory)
			else
				IncreaseBattlegroundsLosses(Glory)
			end
		else
			events:BattlefieldObjectiveEventProcessing(text)
		end
	end
end
 
function events:BattlefieldObjectiveEventProcessing(text) 
	local node, faction
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveClaimedAnnouncements) do
		_, _, node, faction = string.find(text, pattern)
		if node then
			if node == FACTION_ALLIANCE or node == FACTION_HORDE then
				node, faction = faction, node
			end
			events:OnObjectiveClaimed(BGPatternReplacements[node] or node, faction)
			events:TriggerEvent("Glory_ObjectiveClaimed", BGPatternReplacements[node] or node, faction)
			return
		end
	end
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveCapturedAnnouncements) do
		_, _, node, faction = string.find(text, pattern)
		if node then
			if node == FACTION_ALLIANCE or node == FACTION_HORDE then
				node, faction = faction, node
			end
			events:OnObjectiveCaptured(BGPatternReplacements[node] or node, faction)
			events:TriggerEvent("Glory_ObjectiveCaptured", BGPatternReplacements[node] or node, faction)
			return
		end
	end
	for  k, pattern in pairs(BGChatAnnouncements.BGObjectiveAttackedAnnouncements) do
		_, _, node = string.find(text, pattern)
		if node then
			events:OnObjectiveAttacked(BGPatternReplacements[node] or node)
			events:TriggerEvent("Glory_ObjectiveAttacked", BGPatternReplacements[node] or node)
			return
		end
	end
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveDefendedAnnouncements) do
		_, _, node = string.find(text, pattern)
		if node then
			events:OnObjectiveDefended(BGPatternReplacements[node] or node)
			events:TriggerEvent("Glory_ObjectiveDefended", BGPatternReplacements[node] or node)
			return
		end
	end
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveDestroyedAnnouncements) do
		_, _, node = string.find(text, pattern)
		if node then
			events:OnObjectiveDestroyed(BGPatternReplacements[node] or node)
			events:TriggerEvent("Glory_ObjectiveDestroyed", BGPatternReplacements[node] or node)
			return
		end
	end
end 

function events:CHAT_MSG_COMBAT_FACTION_CHANGE(text)
	local faction, rep = deformat(text, FACTION_STANDING_INCREASED)
	if faction and rep then
		if faction == FACTION_DEFILERS or faction == FACTION_FROSTWOLF_CLAN or faction == FACTION_WARSONG_OUTRIDERS or faction == FACTION_LEAGUE_OF_ARATHOR or faction == FACTION_STORMPIKE_GUARD or faction == FACTION_SILVERWING_SENTINELS then
			events:TriggerEvent("Glory_FactionGain", faction, rep)
		end
	end
end

function events:CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS()
	Glory.lastHostileTime = GetTime()
end
events.CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE = events.CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS

function events:UNIT_PVP_UPDATE()
	if not UnitIsPVP("player") and Glory.permaPvP then
		Glory.permaPvP = false
		events:TriggerEvent("Glory_UpdatePermanentPvP", Glory.permaPvP)
	end
	if UnitIsPVP("player") or Glory:IsInBattlegrounds() then
		Glory.pvpTime = GetTime()
		events:TriggerEvent("Glory_UpdatePvPCooldown", Glory:GetPvPCooldown())
	else
		events:TriggerEvent("Glory_UpdatePvPCooldown", 0)
	end
end

function events:UPDATE_WORLD_STATES()
	local resData = BattlefieldZoneResourceData[Glory:GetActiveBattlefieldZone()]
	if resData and Glory:GetNumAllianceBases() and Glory:GetNumHordeBases() then
		-- Common
		local goalResources = resData[table.getn(resData)]
		-- Alliance
		_, _, resources = string.find(Glory:GetAllianceScoreString(), "(%d+)/")
		bases = Glory:GetNumAllianceBases()
		if resources and bases and (resources ~= Glory.aLastResources or bases ~= Glory.aLastBases) then
			Glory.aResourceTTV = (goalResources - resources) / resData[bases]
			Glory.aLastResources = resources
			Glory.aLastBases = bases
			Glory.aLastUpdate = GetTime()
		end
		-- Horde
		_, _, resources = string.find(Glory:GetHordeScoreString(), "(%d+)/")
		bases = Glory:GetNumHordeBases()
		if resources and bases and (resources ~= Glory.hLastResources or bases ~= Glory.hLastBases) then
			Glory.hResourceTTV = (goalResources - resources) / resData[bases]
			Glory.hLastResources = resources
			Glory.hLastBases = bases
			Glory.hLastUpdate = GetTime()
		end
	end
end

function events:PLAYER_ENTERING_WORLD()
	events:UNIT_PVP_UPDATE()
	SetMapToCurrentZone()
	if Glory:IsInBattlegrounds() and GetNumMapLandmarks() > 0 then
		events:InitializeBattlefieldObjectives()
	else
		events:ClearBattlefieldObjectives()
	end
end

function events:PLAYER_DEAD()
	if GetTime() <= Glory.lastHostileTime + 15 then
		IncreaseDeaths(Glory)
	end
end

function events:UPDATE_BATTLEFIELD_SCORE()
	for k,v in pairs(enemyList) do
		enemyList[k] = nil
	end
	for i = 1, GetNumBattlefieldScores() do
		local name, _, _, _, _, faction = GetBattlefieldScore(i)
		if faction == (isHorde and 1 or 0) then
			local _,_,realName, realm = string.find(name, "(.*)%-(.*)")
			if not realName then
				realName = name
				realm = playerRealm
			end
			enemyList[realName] = realm
		end
	end
end

function Glory:IsInBattlegrounds()
--	local zone = GetRealZoneText()
--	return zone == WARSONG_GULCH or zone == ARATHI_BASIN or zone == ALTERAC_VALLEY
	return (MiniMapBattlefieldFrame.status == "active")
end

function Glory:IsInWarsongGulch()
	return GetRealZoneText() == WARSONG_GULCH
end

function Glory:IsInArathiBasin()
	return GetRealZoneText() == ARATHI_BASIN
end

function Glory:IsInAlteracValley()
	return GetRealZoneText() == ALTERAC_VALLEY
end

local function copyTable(to, from)
	for k, v in pairs(from) do
		to[k] = v
	end
	return to
end

local tdate, start, done
local firstbg = { [2006] = 2, }
local function GetBattlegroundWeek(bgdate)
	Glory:assert(bgdate.year >= 2006, "Cannot calculate battleground weekends for dates before year 2006. A date in year %s was given.", bgdate.year)
	local bgweekday = math_mod(bgdate.wday + 4, 7) + 1
	local bgweek = math.floor((bgdate.yday + 6 - bgweekday) / 7) + 1
	if not firstbg[bgdate.year] then
		if not tdate then
			tdate = {}
		end
		tdate = copyTable(tdate, bgdate)
		tdate.day = 1
		tdate.month = 1
		tdate = date("*t", time(tdate))
		local d = math_mod(tdate.wday + 4, 7) + 1
		tdate.day = 31
		tdate.month = 12
		tdate.year = tdate.year - 1
		tdate = date("*t", time(tdate))
		local _, _, bg = GetBattlegroundWeek(tdate)
		if d == 1 then
			firstbg[bgdate.year] = math_mod(bg, 4) + 1
		else
			firstbg[bgdate.year] = bg
		end
	end
	local bg = math_mod(bgweek -1 + firstbg[bgdate.year], 4) + 1
	return bgweekday, bgweek, bg
end

local function GetCurrentOrNextBattlegroundWeekend(week)
	local now = date("*t")
	local bgweekday, bgweek, bg = GetBattlegroundWeek(now)
	local bginweeks
	if bg <= week then
		bginweeks = week - bg
	else
		bginweeks = week + 4 - bg
	end
	if not start then
		start = {}
	end
	start = copyTable(start, now)
	start.day = start.day + 4 - bgweekday + 7 * bginweeks
	start.hour = 0
	start.min = 0
	start.sec = 0
	start = date("*t", time(start))
	if not done then
		done = {}
	end
	done = copyTable(done, now)
	done.day = done.day + 7 - bgweekday + 7 * bginweeks
	done.hour = 23
	done.min = 59
	done.sec = 59
	done = date("*t", time(done))
	local sMonth
	local dMonth
	if start.month == done.month then
		sMonth = date("%B", time(start))
		dMonth = sMonth
	else
		sMonth = date("%b", time(start))
		dMonth = date("%b", time(done))
	end
	return sMonth, start.day, dMonth, done.day, time(start) <= time(now) and time(now) <= time(done)
end

function Glory:GetCurrentOrNextArathiWeekend()
	return GetCurrentOrNextBattlegroundWeekend(4)
end

function Glory:GetCurrentOrNextWarsongWeekend()
	return GetCurrentOrNextBattlegroundWeekend(3)
end

function Glory:GetCurrentOrNextAlteracWeekend()
	return GetCurrentOrNextBattlegroundWeekend(2)
end

function Glory:_TogglePVP()
	self.permaPvP = not self.permaPvP
	if not UnitIsPVP("player") then
		self.permaPvP = true
	end
	events:TriggerEvent("Glory_UpdatePermanentPvP", self.permaPvP)
	self.pvpTime = GetTime()
end

function Glory:GetTodayHKs(person, realm)
	if person then
		self:argCheck(person, 2, "string")
		if realm and realm ~= playerRealm then
			self:argCheck(realm, 3, "string")
			person = person .. "-" .. realm
		end
		return self.data.hks[person] or 0
	else
		return self.data.todayHK
	end
end

function Glory:GetTodayDeaths()
	return self.data.todayDeaths
end

function Glory:GetTodayHKHonor()
	return self.data.todayHKHonor
end

function Glory:GetTodayBonusHonor()
	return self.data.todayBonusHonor
end

function Glory:GetTodayHonor()
	return self.data.todayHKHonor + self.data.todayBonusHonor
end

function Glory:GetBattlegroundsWins()
	return self.data.wsgWin + self.data.abWin + self.data.avWin
end

function Glory:GetWarsongGulchWins()
	return self.data.wsgWin
end

function Glory:GetArathiBasinWins()
	return self.data.abWin
end

function Glory:GetAlteracValleyWins()
	return self.data.avWin
end

function Glory:GetBattlegroundsLosses()
	return self.data.wsgLoss + self.data.abLoss + self.data.avLoss
end

function Glory:GetWarsongGulchLosses()
	return self.data.wsgLoss
end

function Glory:GetArathiBasinLosses()
	return self.data.abLoss
end

function Glory:GetAlteracValleyLosses()
	return self.data.avLoss
end

function Glory:ResetBGScores()
	self.data.wsgWin = 0
	self.data.wsgLoss = 0
	self.data.abWin = 0
	self.data.abLoss = 0
	self.data.avWin = 0
	self.data.avLoss = 0
	events:TriggerEvent("Glory_BGResetScores")
end

function Glory:IsPermanentPvP()
	return self.permaPvP
end

function Glory:GetPvPCooldown()
	if self:IsInBattlegrounds() or self.permaPvP then
		return 300
	end
	local t = self.pvpTime - GetTime() + 300
	if t < 0 or not UnitIsPVP("player") then
		return 0
	else
		return t
	end
end

function Glory:GetRankLimitInfo()
	local level = UnitLevel("player")
	if level < 10 then
		return NONE, 0
	elseif level <= 32 then
		return GetPVPRankInfo(7)
	elseif level <= 37 then
		return GetPVPRankInfo(8)
	elseif level <= 40 then
		return GetPVPRankInfo(9)
	elseif level <= 43 then
		return GetPVPRankInfo(10)
	elseif level <= 45 then
		return GetPVPRankInfo(11)
	elseif level <= 47 then
		return GetPVPRankInfo(12)
	elseif level <= 50 then
		return GetPVPRankInfo(13)
	elseif level <= 52 then
		return GetPVPRankInfo(14)
	elseif level <= 54 then
		return GetPVPRankInfo(15)
	elseif level <= 56 then
		return GetPVPRankInfo(16)
	elseif level <= 58 then
		return GetPVPRankInfo(17)
	else
		return GetPVPRankInfo(18)
	end
end

function Glory:GetRatingLimit()
	local level = UnitLevel("player")
	if level < 10 then
		return 0
	elseif level <= 29 then
		return 6500
	elseif level <= 35 then
		return 7150 + (level - 30) * 975
	elseif level <= 39 then
		return 13325 + (level - 36) * 1300
	elseif level <= 43 then
		return 18850 + (level - 40) * 1625
	elseif level <= 52 then
		return 26000 + (level - 44) * 2275
	elseif level <= 59 then
		return 46800 + (level - 53) * 2600
	else
		return 65000
	end
end

function Glory:GetStanding(name)
	name = name or playerName
	self:argCheck(name, 2, "string")
	for i=1, GetNumBattlefieldScores() do
		if name == GetBattlefieldScore(i) then
			return i
		end
	end
end

function Glory:GetKillingBlows(name)
	name = name or playerName
	self:argCheck(name, 2, "string")
	for i=1, GetNumBattlefieldScores() do
		local unit, killingBlows = GetBattlefieldScore(i)
		if unit == name then
			return killingBlows
		end
	end
end

function Glory:GetHonorableKills(name)
	name = name or playerName
	self:argCheck(name, 2, "string")
	for i=1, GetNumBattlefieldScores() do
		local unit, _, honorableKills = GetBattlefieldScore(i)
		if unit == name then
			return honorableKills
		end
	end
end

function Glory:GetDeaths(name)
	name = name or playerName
	self:argCheck(name, 2, "string")
	for i=1, GetNumBattlefieldScores() do
		local unit, _, _, deaths = GetBattlefieldScore(i)
		if unit == name then
			return deaths
		end
	end
end

function Glory:GetBonusHonor(name)
	name = name or playerName
	self:argCheck(name, 2, "string")
	for i=1, GetNumBattlefieldScores() do
		local unit, _, _, _, bonusHonor = GetBattlefieldScore(i)
		if unit == name then
			return bonusHonor
		end
	end
end

function Glory:GetActiveBattlefieldZone()
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName = GetBattlefieldStatus(i)
		if status == "active" then
			return mapName
		end
	end
end

function Glory:GetActiveBattlefieldUniqueID()
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i)
		if status == "active" then
			return mapName .. " " .. instanceID
		end
	end
end

local function queuedBattlefieldIndicesIter(_, position)
	position = position + 1
	while position <= MAX_BATTLEFIELD_QUEUES do
		local status, name = GetBattlefieldStatus(position)
		if status == "queued" then
			return position, name
		end
		position = position + 1
	end
	return nil
end
function Glory:IterateQueuedBattlefieldZones()
	return queuedBattlefieldIndicesIter, nil, 0
end

local function GetHolder(self, node)
	local poi = self:NodeToPOI(node)
	if self:IsUncontrolled(node) then
		return BGObjectiveDescriptions.UNCONTROLLED
	end
	if poi and not self:IsDestroyed(poi) then
		_, description = GetMapLandmarkInfo(poi)
		if string.find(description, PATTERN_OBJECTIVE_HOLDER) then
			local _, _, faction = string.find(description, PATTERN_OBJECTIVE_HOLDER)
			return faction
		end
	end
end

function Glory:IsBattlefieldObjective(node)
	self:argCheck(node, 2, "string", "number")
	local poi = self:NodeToPOI(node)
	if poi and (GetHolder(self, node) or self:IsInConflict(node) or self:IsDestroyed(node)) then
		return true
	end
	return false
end

function Glory:IsInConflict(node)
	self:argCheck(node, 2, "string", "number")
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.IN_CONFLICT then
			return true
		end
	end
	return false
end

function Glory:IsAllianceControlled(node)
	self:argCheck(node, 2, "string", "number")
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.ALLIANCE_CONTROLLED then
			return true
		end
	end
	return false
end

function Glory:IsHordeControlled(node)
	self:argCheck(node, 2, "string", "number")
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.HORDE_CONTROLLED then
			return true
		end
	end
	return false
end

if isHorde then
	Glory.IsFriendlyControlled = Glory.IsHordeControlled
	Glory.IsHostileControlled = Glory.IsAllianceControlled
else
	Glory.IsFriendlyControlled = Glory.IsAllianceControlled
	Glory.IsHostileControlled = Glory.IsHordeControlled
end

function Glory:IsUncontrolled(node)
	self:argCheck(node, 2, "string", "number")
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.UNCONTROLLED then
			return true
		end
	end
	return
end

function Glory:IsDestroyed(node)
	self:argCheck(node, 2, "string", "number")
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.DESTROYED then
			return true
		end
	end
	return
end

function Glory:GetTimeAttacked(node)
	self:argCheck(node, 2, "string", "number")
	return self.battlefieldObjectiveStatus[node].timeAttacked
end

function Glory:GetTimeToCapture(node)
	self:argCheck(node, 2, "string", "number")
	local t = BattlefieldZoneObjectiveTimes[self:GetActiveBattlefieldZone()] or 0
	return self.battlefieldObjectiveStatus and self.battlefieldObjectiveStatus[node] and self.battlefieldObjectiveStatus[node].timeAttacked and t - GetTime() + self.battlefieldObjectiveStatus[node].timeAttacked
end

function Glory:GetName(node)
	self:argCheck(node, 2, "string", "number")
	return self.battlefieldObjectiveStatus[node].name
end

function Glory:GetDefender(node)
	self:argCheck(node, 2, "string", "number")
	return self.battlefieldObjectiveStatus[node].defender 
end

function Glory:GetAttacker(node)
	self:argCheck(node, 2, "string", "number")
	return self.battlefieldObjectiveStatus[node].attacker
end

local function objectiveNodesIter(t, position)
	local k = next(t, position)
	while k ~= nil and type(k) ~= "number" do
		k = next(t, position)
	end
	return k
end

function Glory:IterateObjectiveNodes()
	return objectiveNodesIter, self.battlefieldObjectiveStatus, nil
end

local function sortedObjectiveNodesIter(t, position)
	position = position + 1
	if position <= table.getn(t) then
		return position, t[position]
	else
		t = del(t)
		return nil
	end
end
local mySort
function Glory:IterateSortedObjectiveNodes()
	local t = new()
	for poi in pairs(self.battlefieldObjectiveStatus) do
		if type(poi) == "number" then
			table.insert(t, poi)
		end
	end
	if not mySort then
		mySort = function(a, b)
			return self.battlefieldObjectiveStatus[a].ypos and self.battlefieldObjectiveStatus[b].ypos and self.battlefieldObjectiveStatus[a].ypos < self.battlefieldObjectiveStatus[b].ypos
		end
	end
	table.sort(t, mySort)
	return sortedObjectiveNodesIter, t, 0
end

function events:ClearBattlefieldObjectives()
	for i = 1, table.getn(Glory.battlefieldObjectiveStatus) do
		local o = Glory.battlefieldObjectiveStatus[i]
		if Glory.battlefieldObjectiveStatus[o.node] == o then
			Glory.battlefieldObjectiveStatus[o.node] = nil
		end
		Glory.battlefieldObjectiveStatus[i] = del(o)
	end
	for k in pairs(Glory.battlefieldObjectiveStatus) do
		Glory.battlefieldObjectiveStatus[k] = del(Glory.battlefieldObjectiveStatus[k])
		k = nil
	end
end

function events:InitializeBattlefieldObjectives()
	events:ClearBattlefieldObjectives()
	SetMapToCurrentZone()
	local numPOIS = GetNumMapLandmarks()
	for i=1, numPOIS do
		if Glory:IsBattlefieldObjective(i) then
			local node, _, _, _, y = GetMapLandmarkInfo(i)
			Glory.battlefieldObjectiveStatus[i] = {
				name = node,
				ypos = y,
				defender = GetHolder(Glory, i),
				inConflict = Glory:IsInConflict(i),
				isDestroyed = Glory:IsDestroyed(i),
			}
			Glory.battlefieldObjectiveStatus[node] = Glory.battlefieldObjectiveStatus[i]
		end
	end
end

function events:OnObjectiveClaimed(node, faction)
	local poi = Glory:NodeToPOI(node)
	if poi then
		if not next(Glory.battlefieldObjectiveStatus) then
			events:InitializeBattlefieldObjectives()
		end
		local n = Glory.battlefieldObjectiveStatus[poi]
		if n then
			n.attacker = faction
			n.inConflict = true
			n.timeAttacked = GetTime()
		end
	end	
end

function events:OnObjectiveCaptured(node, faction)
	local poi = Glory:NodeToPOI(node)
	if poi then
		if not next(Glory.battlefieldObjectiveStatus) then
			events:InitializeBattlefieldObjectives()
		end
		local n = Glory.battlefieldObjectiveStatus[poi]
		if n then
			n.defender = GetHolder(Glory, node) or faction
			n.attacker = nil
			n.inConflict = nil
			n.timeAttacked = nil
		end
	end
end

function events:OnObjectiveAttacked(node)
	local poi = Glory:NodeToPOI(node)
	if poi then
		if not next(Glory.battlefieldObjectiveStatus) then
			events:InitializeBattlefieldObjectives()
		end
		local n = Glory.battlefieldObjectiveStatus[poi]
		if n then
			if n.defender == FACTION_ALLIANCE then
				n.attacker = FACTION_HORDE
			else
				n.attacker = FACTION_ALLIANCE
			end
			n.inConflict = true
			n.timeAttacked = GetTime()
		end
	end
end

function events:OnObjectiveDefended(node)
	local poi = Glory:NodeToPOI(node)
	if poi then
		if not next(Glory.battlefieldObjectiveStatus) then
			events:InitializeBattlefieldObjectives()
		end
		local n = Glory.battlefieldObjectiveStatus[poi]
		if n then
			n.attacker = nil
			n.inConflict = nil
			n.timeAttacked = nil
		end
	end
end

function events:OnObjectiveDestroyed(node)
	local poi = Glory:NodeToPOI(node)
	if poi then
		if not next(Glory.battlefieldObjectiveStatus) then
			events:InitializeBattlefieldObjectives()
		end
		local n = Glory.battlefieldObjectiveStatus[poi]
		if n then
			n.isDestroyed = true
			n.defender = nil
			n.attacker = nil
			n.inConflict = nil
			n.timeAttacked = nil
		end
	end
end

function Glory:GetAllianceFlagCarrier()
	return self.allianceFC
end

function Glory:GetHordeFlagCarrier()
	return self.hordeFC
end

function Glory:TargetAllianceFlagCarrier()
	if self.allianceFC then
		TargetByName(self.allianceFC)
	end
end

function Glory:TargetHordeFlagCarrier()
	if self.hordeFC then
		TargetByName(self.hordeFC)
	end
end

if isHorde then
	Glory.GetFriendlyFlagCarrier = Glory.GetHordeFlagCarrier
	Glory.GetHostileFlagCarrier = Glory.GetAllianceFlagCarrier
	Glory.TargetFriendlyFlagCarrier = Glory.TargetHordeFlagCarrier
	Glory.TargetHostileFlagCarrier = Glory.TargetAllianceFlagCarrier
else
	Glory.GetFriendlyFlagCarrier = Glory.GetAllianceFlagCarrier
	Glory.GetHostileFlagCarrier = Glory.GetHordeFlagCarrier
	Glory.TargetFriendlyFlagCarrier = Glory.TargetAllianceFlagCarrier
	Glory.TargetHostileFlagCarrier = Glory.TargetHordeFlagCarrier
end

function Glory:GetFlagCarrier(faction)
	self:argCheck(faction, 2, "string", "number")
	if faction == FACTION_ALLIANCE or faction == "Alliance" or faction == 1 then
		return self.allianceFC
	else
		return self.hordeFC
	end
end

function Glory:TargetFlagCarrier(faction)
	self:argCheck(faction, 2, "string", "number")
	if faction == FACTION_ALLIANCE or faction == "Alliance" or faction == 1 then
		if self.allianceFC then
			TargetByName(self.allianceFC)
		end
	elseif self.hordeFC then
		TargetByName(self.hordeFC)
	end
end

function Glory:GetNumAllianceBases()
	local _, s = GetWorldStateUIInfo(1)
	if s then
		local _, _, bases = string.find(s, PATTERN_GWSUII_BASES)
		return tonumber(bases)
	end
end

function Glory:GetNumHordeBases()
	local _, s = GetWorldStateUIInfo(2)
	if s then
		local _, _, bases = string.find(s, PATTERN_GWSUII_BASES)
		return tonumber(bases)
	end
end

if isHorde then
	Glory.GetNumFriendlyBases = Glory.GetNumHordeBases
	Glory.GetNumHostileBases = Glory.GetNumAllianceBases
else
	Glory.GetNumFriendlyBases = Glory.GetNumAllianceBases
	Glory.GetNumHostileBases = Glory.GetNumHordeBases
end

function Glory:GetNumBases(team)
	self:argCheck(team, 2, "string", "number")
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetNumAllianceBases()
	else
		return self:GetNumHordeBases()
	end
end

function Glory:GetNumAllianceResources()
	local _, s = GetWorldStateUIInfo(1)
	if s then
		local _, _, resources = string.find(s, PATTERN_GWSUII_RESOURCES)
		return tonumber(resources)
	end
end

function Glory:GetNumHordeResources()
	local _, s = GetWorldStateUIInfo(2)
	if s then
		local _, _, resources = string.find(s, PATTERN_GWSUII_RESOURCES)
		return tonumber(resources)
	end
end

if isHorde then
	Glory.GetNumFriendlyResources = Glory.GetNumHordeResources
	Glory.GetNumHostileResources = Glory.GetNumAllianceResources
else
	Glory.GetNumFriendlyResources = Glory.GetNumAllianceResources
	Glory.GetNumHostileResources = Glory.GetNumHordeResources
end

function Glory:GetNumTeamResources(team)
	self:argCheck(team, 2, "string", "number")
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetNumAllianceResources()
	else
		return self:GetNumHordeResources()
	end
end

function Glory:GetAllianceTTV()
	return self.aResourceTTV - GetTime() + self.aLastUpdate
end

function Glory:GetHordeTTV()
	return self.hResourceTTV - GetTime() + self.hLastUpdate
end

function Glory:GetTeamTTV(team)
	self:argCheck(team, 2, "string", "number")
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetAllianceTTV()
	else
		return self:GetHordeTTV()
	end
end

if isHorde then
	Glory.GetFriendlyTTV = Glory.GetHordeTTV
	Glory.GetHostileTTV = Glory.GetAllianceTTV
else
	Glory.GetFriendlyTTV = Glory.GetAllianceTTV
	Glory.GetHostileTTV = Glory.GetHordeTTV
end
	
function Glory:GetAllianceScoreString()
	local _, s = GetWorldStateUIInfo(1)
	if s then
		local _, _, scoreString = string.find(s, PATTERN_GWSUII_SCORE)
		return scoreString
	end
end

function Glory:GetHordeScoreString()
	local _, s = GetWorldStateUIInfo(2)
	if s then
		local _, _, scoreString = string.find(s, PATTERN_GWSUII_SCORE)
		return scoreString
	end
end

if isHorde then
	Glory.GetFriendlyScoreString = Glory.GetHordeScoreString
	Glory.GetHostileScoreString = Glory.GetAllianceScoreString
else
	Glory.GetFriendlyScoreString = Glory.GetAllianceScoreString
	Glory.GetHostileScoreString = Glory.GetHordeScoreString
end

function Glory:GetTeamScoreString(team)
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetAllianceScoreString()
	else
		return self:GetHordeScoreString()
	end
end

function Glory:GetNumAlliancePlayers()
	local numPlayers = 0
	for i = 1, GetNumBattlefieldScores() do
		local _, _, _, _, _, faction = GetBattlefieldScore(i)
		if faction == 1 then
			numPlayers = numPlayers + 1
		end
	end
	return numPlayers
end

function Glory:GetNumHordePlayers()
	local numPlayers = 0
	for i = 1, GetNumBattlefieldScores() do
		local _, _, _, _, _, faction = GetBattlefieldScore(i)
		if faction == 0 then
			numPlayers = numPlayers + 1
		end
	end
	return numPlayers
end

if isHorde then
	Glory.GetNumFriendlyPlayers = Glory.GetNumHordePlayers
	Glory.GetNumHostilePlayers = Glory.GetNumAlliancePlayers
else
	Glory.GetNumFriendlyPlayers = Glory.GetNumAlliancePlayers
	Glory.GetNumHostilePlayers = Glory.GetNumHordePlayers
end

function Glory:GetNumPlayers(team)
	self:argCheck(team, 2, "string", "number")
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetNumAlliancePlayers()
	else
		return self:GetNumHordePlayers()
	end
end

function Glory:SafeNodeToPOI(node)
	if type(node) == "number" and node > 0 and node <= GetNumMapLandmarks() then
		return node
	elseif type(node) == "string" then
		for i = 1, GetNumMapLandmarks() do
			if string.lower(node) == string.lower(GetMapLandmarkInfo(i)) then
				return i
			end
		end
	elseif type(node) ~= "number" then
		self:error("Bad argument #2 to `NodeToPOI' (string or number expected, got %s)", tostring(type(node)))
	else
		self:error("Bad argument #2 to `NodeToPOI' (out of bounds: [1, %d] expected, got %d)", GetNumMapLandmarks(), node)
	end
end

function Glory:NodeToPOI(node)
	if type(node) == "number" then return node end
	if type(node) == "string" then
		for i = 1, GetNumMapLandmarks() do
			if string.lower(node) == string.lower(GetMapLandmarkInfo(i)) then return i end
		end
	end
end

function Glory:GetBGAcronym(bgName)
	self:argCheck(bgName, 2, "string")
	return BGAcronyms[bgName] or bgName
end

function Glory:GetFactionColor(faction)
	self:argCheck(faction, 2, "string", "number", "nil")
	if faction then
		if faction == "Alliance" or faction == FACTION_ALLIANCE or faction == 1 then
			faction = "ALLIANCE"
		elseif faction == "Horde" or faction == FACTION_HORDE or faction == 0 or faction == 2 then
			faction = "HORDE"
		end
		local cti = ChatTypeInfo["BG_SYSTEM_" .. faction]
		if cti then
			return cti.r, cti.g, cti.b
		end
	end
	return 0.7, 0.7, 0.7
end

function Glory:GetFactionHexColor(faction)
	local r, g, b = self:GetFactionColor(faction)
	return string.format("%02X%02X%02X", 255*r, 255*g, 255*b)
end

local function activate(self, oldLib, oldDeactivate)
	Glory = self
	if oldLib then
		self.registry = oldLib.registry
	else
		self.registry = {}
	end
	events:CancelAllScheduledEvents()
	events:UnregisterAllEvents()
	events:RegisterEvent("ADDON_LOADED")
	events:RegisterEvent("VARIABLES_LOADED")
	events:RegisterEvent("PLAYER_LOGOUT")
	events:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
	events:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
	events:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
	events:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	events:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
	events:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	events:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	events:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS")
	events:RegisterEvent("UPDATE_WORLD_STATES")
	events:RegisterEvent("PLAYER_ENTERING_WORLD")
	events:RegisterEvent("UNIT_PVP_UPDATE")
	events:RegisterEvent("PLAYER_DEAD")
	events:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
	events:VARIABLES_LOADED()
	events:ScheduleRepeatingEvent(function()
		if self:IsInBattlegrounds() then
			RequestBattlefieldScoreData()
		end
	end, 15)
	
	if not oldLib then
		local old_TogglePVP = TogglePVP
		function TogglePVP()
			AceLibrary(MAJOR_VERSION):_TogglePVP()
			
			old_TogglePVP()
		end
	end
	
	self.battlefieldObjectiveStatus = new()
	self.pvpTime = 0
	self.currentBonusHonor = 0
	self.lastHostileTime = 0
	self.aLastResources = 0
	self.hLastResources = 0
	self.aLastBases = 0
	self.hLastBases	= 0
	self.aLastUpdate = 0
	self.hLastUpdate = 0
	self.aResourceTTV = 0
	self.hResourceTTV = 0
	
	SLASH_TARFLAG1 = "/tarflag"
	SLASH_TARFLAG2 = "/tflag"
	SlashCmdList.TARFLAG = function()
		self:TargetHostileFlagCarrier()
	end
	
	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

local function external(self, major, instance)
	if major == "AceConsole-2.0" then
		local print = print
		if DEFAULT_CHAT_FRAME then
			function print(key, value)
				DEFAULT_CHAT_FRAME:AddMessage("|cffffff7f" .. key .. ": [|r" .. value .. "|cffffff7f]|r")
			end
		end
		instance.RegisterChatCommand(self, { "/glory", "/glorylib" }, {
			name = MAJOR_VERSION .. "." .. string.gsub(MINOR_VERSION, ".-(%d+).*", "%1"),
			desc = "A library for PvP and Battlegrounds.",
			type = "group",
			args = {
				bg = {
					name = "Battlegrounds",
					desc = "Show battlegrounds information",
					type = "execute",
					func = function()
						print("BG Score", self:GetBattlegroundsWins() .. "-" .. self:GetBattlegroundsLosses())
						print("WSG Score", self:GetWarsongGulchWins() .. "-" .. self:GetWarsongGulchLosses())
						print("AB Score", self:GetArathiBasinWins() .. "-" .. self:GetArathiBasinLosses())
						print("AV Score", self:GetAlteracValleyWins() .. "-" .. self:GetAlteracValleyLosses())
						if self:IsInBattlegrounds() then
							print("Current", self:GetActiveBattlegroundUniqueID())
							print("Standing", self:GetStanding())
							print("Killing Blows", self:GetKillingBlows())
							print("Honorable Kills", self:GetHonorableKills())
							print("Deaths", self:GetDeaths())
							print("Bonus Honor", self:GetBonusHonor())
							if self:IsInWarsongGulch() then
								print("Friendly FC", (self:GetFriendlyFlagCarrier() or NONE))
								print("Hostile FC", (self:GetHostileFlagCarrier() or NONE))
							else
								print("Friendly Bases", self:GetNumFriendlyBases())
								print("Hostile Bases", self:GetNumHostileBases())
								print("Friendly Resources", self:GetNumFriendlyResources())
								print("Hostile Resources", self:GetNumHostileResources())
							end
							print("Friendly Players", self:GetNumFriendlyPlayers())
							print("Hostile Players", self:GetNumHostilePlayers())
						end
					end
				},
				honor = {
					name = "Honor",
					desc = "Show honor information",
					type = "execute",
					func = function()
						print("Today's HKs", self:GetTodayHKs())
						print("Today's Deaths", self:GetTodayDeaths())
						print("Today's HK Honor", self:GetTodayHKHonor())
						print("Today's Bonus Honor", self:GetTodayBonusHonor())
						print("Today's Honor", self:GetTodayHonor())
						local s
						if self:IsPermanentPvP() then
							s = "Flagged"
						elseif self:IsInBattlegrounds() then
							s = "Battlegrounds"
						else
							local t = self:GetPvPCooldown()
							if t == 0 then
								s = "None"
							else
								local min = floor(t / 60)
								local sec = floor(mod(t, 60))
								s = format("%d:%02d", min, sec)
							end
						end
						print("PvP Cooldown", s)
						print("Rank Limit", string.format("%s (%d)", self:GetRankLimitInfo()))
						print("Rating Limit", self:GetRatingLimit())
					end
				}
			}
		}, "GLORY")
	end
end

AceLibrary:Register(Glory, MAJOR_VERSION, MINOR_VERSION, activate, nil, external)

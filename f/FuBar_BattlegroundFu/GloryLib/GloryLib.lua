local MAJOR_VERSION = "1.0"
local MINOR_VERSION = tonumber(string.sub("$Revision: 2231 $", 12, -3))
if GloryLib and GloryLib.versions[MAJOR_VERSION] and GloryLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

local compost
if CompostLib then
	compost = CompostLib:GetInstance('compost-1')
end

local PATTERN_HORDE_FLAG_PICKED_UP, PATTERN_HORDE_FLAG_DROPPED, PATTERN_HORDE_FLAG_CAPTURED, PATTERN_ALLIANCE_FLAG_PICKED_UP, PATTERN_ALLIANCE_FLAG_DROPPED, PATTERN_ALLIANCE_FLAG_CAPTURED, FACTION_DEFILERS, FACTION_FROSTWOLF_CLAN, FACTION_WARSONG_OUTRIDERS, FACTION_LEAGUE_OF_ARATHOR, FACTION_STORMPIKE_GUARD, FACTION_SILVERWING_SENTINELS

local PATTERN_GWSUII_SCORE, PATTERN_GWSUII_BASES
local BGObjectiveDescriptions, BGChatAnnouncements, BGPatternReplacements, BGAcronyms, BattlefieldZoneObjectiveTimes, BattlefieldZoneResourceData   --hC

local babbleCore = BabbleLib:GetInstance('Core 1.1')
local babbleZone = BabbleLib:GetInstance('Zone 1.1')

local WARSONG_GULCH = babbleZone:GetLocalized("WARSONG_GULCH")
local ALTERAC_VALLEY = babbleZone:GetLocalized("ALTERAC_VALLEY")
local ARATHI_BASIN = babbleZone:GetLocalized("ARATHI_BASIN")

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
			PATTERN_OBJECTIVE_CLAIMED_AV0 = "hat den (.+) besetzt.+erlangt die (%a) die Kontrolle"
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
-------------IRIEL'S-STUB-CODE--------------
local stub = {};

-- Instance replacement method, replace contents of old with that of new
function stub:ReplaceInstance(old, new)
   for k,v in pairs(old) do old[k]=nil; end
   for k,v in pairs(new) do old[k]=v; end
end

-- Get a new copy of the stub
function stub:NewStub()
  local newStub = {};
  self:ReplaceInstance(newStub, self);
  newStub.lastVersion = '';
  newStub.versions = {};
  return newStub;
end

-- Get instance version
function stub:GetInstance(version)
   if (not version) then version = self.lastVersion; end
   local versionData = self.versions[version];
   if (not versionData) then
	  message("Cannot find library instance with version '" 
			  .. version .. "'");
	  return;
   end
   return versionData.instance;
end

-- Register new instance
function stub:Register(newInstance)
   local version,minor = newInstance:GetLibraryVersion();
   self.lastVersion = version;
   local versionData = self.versions[version];
   if (not versionData) then
	  -- This one is new!
	  versionData = { instance = newInstance,
		 minor = minor,
		 old = {} 
	  };
	  self.versions[version] = versionData;
	  newInstance:LibActivate(self);
	  return newInstance;
   end
   if (minor <= versionData.minor) then
	  -- This one is already obsolete
	  if (newInstance.LibDiscard) then
		 newInstance:LibDiscard();
	  end
	  return versionData.instance;
   end
   -- This is an update
   local oldInstance = versionData.instance;
   local oldList = versionData.old;
   versionData.instance = newInstance;
   versionData.minor = minor;
   local skipCopy = newInstance:LibActivate(self, oldInstance, oldList);
   table.insert(oldList, oldInstance);
   if (not skipCopy) then
	  for i, old in ipairs(oldList) do
		 self:ReplaceInstance(old, newInstance);
	  end
   end
   return newInstance;
end

-- Bind stub to global scope if it's not already there
if (not GloryLib) then
   GloryLib = stub:NewStub();
end

-- Nil stub for garbage collection
stub = nil;
-----------END-IRIEL'S-STUB-CODE------------

local lib = {}
local events = {}

local playerFaction = UnitFactionGroup("player")
local isHorde = playerFaction == "Horde"
local playerName = UnitName("player")

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
	if oldLib then
		for i = 1, 9 do
			setglobal("SLASH_GLORY" .. i, nil)
		end
	end
	SLASH_GLORY1 = "/glory"
	SLASH_GLORY2 = "/glorylib"
	local function print(msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
	SlashCmdList["GLORY"] = function(msg)
		msg = string.gsub(string.gsub(msg, "^%s*(.-)%s*$", "%1"), "%s+", " ")
		local _, _, first, rest = string.find(msg, "^(.-) (.*)$")
		if not first then
			if msg ~= "" then
				first = msg
			end
		end
		if first then
			first = string.lower(first)
		end
		if not first then
			print("|cffffff7fGloryLib v" .. MAJOR_VERSION .. "." .. MINOR_VERSION .. ":|r")
			print("  |cffffff7fhonor|r - general honor information.")
			print("  |cffffff7fbg|r - battleground information.")
		elseif first == "honor" then
			print("|cffffff7fToday's HKs:|r - " .. self:GetTodayHKs())
			print("|cffffff7fToday's Deaths:|r - " .. self:GetTodayDeaths())
			print("|cffffff7fToday's HK Honor:|r - " .. self:GetTodayHKHonor())
			print("|cffffff7fToday's Bonus Honor:|r - " .. self:GetTodayBonusHonor())
			print("|cffffff7fToday's Honor:|r - " .. self:GetTodayHonor())
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
			print("|cffffff7fPvP Cooldown:|r - " .. s)
			print("|cffffff7fRank Limit:|r - " .. format("%s (%d)", self:GetRankLimitInfo()))
			print("|cffffff7fRating Limit:|r - " .. self:GetRatingLimit())
		elseif first == "bg" then
			print("|cffffff7fBG Score:|r - " .. self:GetBattlegroundsWins() .. "-" .. self:GetBattlegroundsLosses())
			print("|cffffff7fWSG Score:|r - " .. self:GetWarsongGulchWins() .. "-" .. self:GetWarsongGulchLosses())
			print("|cffffff7fAB Score:|r - " .. self:GetArathiBasinWins() .. "-" .. self:GetArathiBasinLosses())
			print("|cffffff7fAV Score:|r - " .. self:GetAlteracValleyWins() .. "-" .. self:GetAlteracValleyLosses())
			if self:IsInBattlegrounds() then
				print("|cffffff7fCurrent:|r - " .. self:GetActiveBattlegroundUniqueID())
				print("|cffffff7fStanding:|r - " .. self:GetStanding())
				print("|cffffff7fKilling Blows:|r - " .. self:GetKillingBlows())
				print("|cffffff7fHonorable Kills:|r - " .. self:GetHonorableKills())
				print("|cffffff7fDeaths:|r - " .. self:GetDeaths())
				print("|cffffff7fBonus Honor:|r - " .. self:GetBonusHonor())
				if self:IsInWarsongGulch() then
					print("|cffffff7fFriendly FC:|r - " .. (self:GetFriendlyFlagCarrier() or NONE))
					print("|cffffff7fHostile FC:|r - " .. (self:GetHostileFlagCarrier() or NONE))
				else
					print("|cffffff7fFriendly Bases:|r - " .. self:GetNumFriendlyBases())
					print("|cffffff7fHostile Bases:|r - " .. self:GetNumHostileBases())
					print("|cffffff7fFriendly Resources:|r - " .. self:GetNumFriendlyResources())
					print("|cffffff7fHostile Resources:|r - " .. self:GetNumHostileResources())
				end
				print("|cffffff7fFriendly Players:|r - " .. self:GetNumFriendlyPlayers())
				print("|cffffff7fHostile Players:|r - " .. self:GetNumHostilePlayers())
			end
		end
	end
	
	if oldLib then
		self.frame = oldLib.frame
		self.frame:UnregisterAllEvents()
		self.registry = oldLib.registry
	else
		self.frame = CreateFrame("Frame", "GloryLibFrame", UIParent)
		self.registry = {}
	end
	self.frame:RegisterEvent("ADDON_LOADED")
	self.frame:RegisterEvent("VARIABLES_LOADED")
	self.frame:RegisterEvent("PLAYER_LOGOUT")
	self.frame:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
	self.frame:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
	self.frame:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
	self.frame:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self.frame:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
	self.frame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	self.frame:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	self.frame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS")
	self.frame:RegisterEvent("UPDATE_WORLD_STATES")
	self.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	self.frame:RegisterEvent("UNIT_PVP_UPDATE")
	self.frame:RegisterEvent("PLAYER_DEAD")
	self.frame:SetScript("OnEvent", function()
		events[event](self)
	end)
	events.VARIABLES_LOADED(self)
	
	if not oldLib then
		local old_TogglePVP = TogglePVP
		function TogglePVP()
			GloryLib:GetInstance(MAJOR_VERSION):_TogglePVP()
			
			old_TogglePVP()
		end
	end
	
	self.battlefieldObjectiveStatus = compost and compost:Acquire() or {}
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
end

function lib:LibDeactivate(stub)
	events = nil
	if compost then
		compost:Reclaim(self.battlefieldObjectiveStatus)
	end
	self.battlefieldObjectiveStatus = nil
end

local function Trigger(self, event, a1, a2, a3, a4, a5, a6, a7, a8)
	if self.registry[event] then
		for func, arg in pairs(self.registry[event]) do
			if type(func) == "function" then
				func(arg, a1, a2, a3, a4, a5, a6, a7, a8)
			else
				func[arg](func, a1, a2, a3, a4, a5, a6, a7, a8)
			end
		end
	end
end

local function CheckNewWeek(self)
	local _,_,lastWeekHonor,_ = GetPVPLastWeekStats()
	if lastWeekHonor ~= self.data.lastWeek then
		self.data.lastWeek = lastWeekHonor
		Trigger(self, "NEW_WEEK")
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
		Trigger(self, "NEW_DAY")
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
		Trigger(self, "BG_WIN_AV")
	elseif self:IsInArathiBasin() then
		self.data.abWin = self.data.abWin + 1
		Trigger(self, "BG_WIN_AB")
	else
		self.data.wsgWin = self.data.wsgWin + 1
		Trigger(self, "BG_WIN_WSG")
	end
	Trigger(self, "BG_WIN")
end

local function IncreaseBattlegroundsLosses(self)
	if self:IsInAlteracValley() then
		self.data.avLoss = self.data.avLoss + 1
		Trigger(self, "BG_LOSS_AV")
	elseif self:IsInArathiBasin() then
		self.data.abLoss = self.data.abLoss + 1
		Trigger(self, "BG_LOSS_AB")
	else
		self.data.wsgLoss = self.data.wsgLoss + 1
		Trigger(self, "BG_LOSS_WSG")
	end
	Trigger(self, "BG_LOSS")
end

local function IncreaseDeaths(self)
	self.data.todayDeaths = self.data.todayDeaths + 1
	Trigger(self, "DEATH")
end

local db

local function VerifyData(self)
	if not self.data then
		if type(GloryLibDB) ~= "table" then
			GloryLibDB = {}
		end
		db = GloryLibDB
		if type(db[MAJOR_VERSION]) ~= "table" then
			db[MAJOR_VERSION] = {}
		end
		self.data = db[MAJOR_VERSION]
	elseif db ~= GloryLibDB then
		local old = db
		local new = GloryLibDB
		if type(new) ~= "table" then
			GloryLibDB = old
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
	events.UNIT_PVP_UPDATE(self)
end

function events:ADDON_LOADED()
	VerifyData(self)
end

function events:VARIABLES_LOADED()
	VerifyData(self)
end

function events:PLAYER_LOGOUT()
	self.data.time = time()
end

function events:CHAT_MSG_COMBAT_HONOR_GAIN()
	CheckNewDay(self)
	local name, rank, honor = babbleCore:Deformat(arg1, COMBATLOG_HONORGAIN)
	if name then
		local kills = IncreaseHKs(self, name)
		local factor = (5 - kills) / 4
		if factor < 0 then
			factor = 0
		end
		local realHonor = ceil(honor * factor)
		IncreaseHKHonor(self, realHonor)
		Trigger(self, "GAIN_HK", rank, name, realHonor, kills)
		return
	end
	
	local bonus = babbleCore:Deformat(arg1, COMBATLOG_HONORAWARD)
	if bonus then
		bonus = tonumber(bonus)
		IncreaseBonusHonor(self, bonus)
		Trigger(self, "GAIN_BONUS_HONOR", bonus)
	end
end

function events:CHAT_MSG_BG_SYSTEM_NEUTRAL()
	if string.find(string.lower(arg1), string.lower(VICTORY_TEXT0)) then
		if isHorde then
			IncreaseBattlegroundsWins(self)
		else
			IncreaseBattlegroundsLosses(self)
		end
	elseif string.find(string.lower(arg1), string.lower(VICTORY_TEXT1)) then
		if not isHorde then
			IncreaseBattlegroundsWins(self)
		else
			IncreaseBattlegroundsLosses(self)
		end
	end
end

function events:CHAT_MSG_BG_SYSTEM_HORDE()
	if self:IsInWarsongGulch() then
		local _, _, hordeFC = string.find(arg1, PATTERN_ALLIANCE_FLAG_PICKED_UP)
		if hordeFC then
			self.hordeFC = hordeFC
			Trigger(self, "ALLIANCE_FLAG_PICKED_UP", self.hordeFC)
			Trigger(self, "ALLIANCE_FLAGCARRIER_UPDATE", self.hordeFC)
			if not isHorde then
				Trigger(self, "FRIENDLY_FLAG_PICKED_UP", self.hordeFC)
				Trigger(self, "FRIENDLY_FLAGCARRIER_UPDATE", self.hordeFC)
			else
				Trigger(self, "HOSTILE_FLAG_PICKED_UP", self.hordeFC)
				Trigger(self, "HOSTILE_FLAGCARRIER_UPDATE", self.hordeFC)
			end
			return
		end
		
		if string.find(arg1, PATTERN_ALLIANCE_FLAG_CAPTURED) then
			local hordeFC = self.hordeFC
			self.allianceFC = nil
			self.hordeFC = nil
			Trigger(self, "ALLIANCE_FLAG_CAPTURED", hordeFC)
			if not isHorde then
				Trigger(self, "FRIENDLY_FLAG_CAPTURED", hordeFC)
			else
				Trigger(self, "HOSTILE_FLAG_CAPTURED", hordeFC)
			end
			Trigger(self, "FRIENDLY_FLAGCARRIER_UPDATE", nil)
			Trigger(self, "HOSTILE_FLAGCARRIER_UPDATE", nil)
			return
		end
		
		if string.find(arg1, PATTERN_HORDE_FLAG_DROPPED) then
			local allianceFC = self.allianceFC
			self.allianceFC = nil
			Trigger(self, "HORDE_FLAG_DROPPED", allianceFC)
			if isHorde then
				Trigger(self, "FRIENDLY_FLAG_DROPPED", allianceFC)
				Trigger(self, "HOSTILE_FLAGCARRIER_UPDATE", nil)
			else
				Trigger(self, "HOSTILE_FLAG_DROPPED", allianceFC)
				Trigger(self, "FRIENDLY_FLAGCARRIER_UPDATE", nil)
			end
			return
		end
	elseif self:IsInArathiBasin() or self:IsInAlteracValley() then
		events.BattlefieldObjectiveEventProcessing(self)
	end
end
 
function events:CHAT_MSG_BG_SYSTEM_ALLIANCE()
	if self:IsInWarsongGulch() then
		local _, _, allianceFC = string.find(arg1, PATTERN_HORDE_FLAG_PICKED_UP)
		if allianceFC then
			self.allianceFC = allianceFC
			Trigger(self, "HORDE_FLAG_PICKED_UP", self.allianceFC)
			if isHorde then
				Trigger(self, "FRIENDLY_FLAG_PICKED_UP", self.allianceFC)
				Trigger(self, "HOSTILE_FLAGCARRIER_UPDATE", self.allianceFC)
			else
				Trigger(self, "HOSTILE_FLAG_PICKED_UP", self.allianceFC)
				Trigger(self, "FRIENDLY_FLAGCARRIER_UPDATE", self.allianceFC)
			end
			return
		end
		
		if string.find(arg1, PATTERN_HORDE_FLAG_CAPTURED) then
			Trigger(self, "HORDE_FLAG_CAPTURED", self.allianceFC)
			if isHorde then
				Trigger(self, "FRIENDLY_FLAG_CAPTURED", self.allianceFC)
			else
				Trigger(self, "HOSTILE_FLAG_CAPTURED", self.allianceFC)
			end
			self.allianceFC = nil
			self.hordeFC = nil
			Trigger(self, "FRIENDLY_FLAGCARRIER_UPDATE", nil)
			Trigger(self, "HOSTILE_FLAGCARRIER_UPDATE", nil)
			return
		end
		
		if string.find(arg1, PATTERN_ALLIANCE_FLAG_DROPPED) then
			Trigger(self, "ALLIANCE_FLAG_DROPPED", self.hordeFC)
			if not isHorde then
				Trigger(self, "FRIENDLY_FLAG_DROPPED", self.hordeFC)
				Trigger(self, "HOSTILE_FLAGCARRIER_UPDATE", nil)
			else
				Trigger(self, "HOSTILE_FLAG_DROPPED", self.hordeFC)
				Trigger(self, "FRIENDLY_FLAGCARRIER_UPDATE", nil)
			end
			self.hordeFC = nil
			return
		end
	elseif self:IsInArathiBasin() or self:IsInAlteracValley() then
		events.BattlefieldObjectiveEventProcessing(self)
	end
end

function events:CHAT_MSG_MONSTER_YELL()
	if self:IsInAlteracValley() then
		if string.find(string.lower(arg1), string.lower(VICTORY_TEXT0)) then
			if isHorde then
				IncreaseBattlegroundsWins(self)
			else
				IncreaseBattlegroundsLosses(self)
			end
		elseif string.find(string.lower(arg1), string.lower(VICTORY_TEXT1)) then
			if not isHorde then
				IncreaseBattlegroundsWins(self)
			else
				IncreaseBattlegroundsLosses(self)
			end
		else
			events.BattlefieldObjectiveEventProcessing(self)
		end
	end
end
 
function events:BattlefieldObjectiveEventProcessing() 
	local node, faction
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveClaimedAnnouncements) do
		_, _, node, faction = string.find(arg1, pattern)
		if node then
			if node == FACTION_ALLIANCE or node == FACTION_HORDE then
				node, faction = faction, node
			end
			Trigger(self, "OBJECTIVE_CLAIMED", BGPatternReplacements[node] or node, faction)
			events.OnObjectiveClaimed(self, BGPatternReplacements[node] or node, faction)
			return
		end
	end
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveCapturedAnnouncements) do
		_, _, node, faction = string.find(arg1, pattern)
		if node then
			if node == FACTION_ALLIANCE or node == FACTION_HORDE then
				node, faction = faction, node
			end
			Trigger(self, "OBJECTIVE_CAPTURED", BGPatternReplacements[node] or node, faction)
			events.OnObjectiveCaptured(self, BGPatternReplacements[node] or node, faction)
			return
		end
	end
	for  k, pattern in pairs(BGChatAnnouncements.BGObjectiveAttackedAnnouncements) do
		_, _, node = string.find(arg1, pattern)
		if node then
			Trigger(self, "OBJECTIVE_ATTACKED", BGPatternReplacements[node] or node)
			events.OnObjectiveAttacked(self, BGPatternReplacements[node] or node)
			return
		end
	end
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveDefendedAnnouncements) do
		_, _, node = string.find(arg1, pattern)
		if node then
			Trigger(self, "OBJECTIVE_DEFENDED", BGPatternReplacements[node] or node)
			events.OnObjectiveDefended(self, BGPatternReplacements[node] or node)
			return
		end
	end
	for k, pattern in pairs(BGChatAnnouncements.BGObjectiveDestroyedAnnouncements) do
		_, _, node = string.find(arg1, pattern)
		if node then
			Trigger(self, "OBJECTIVE_DESTROYED", BGPatternReplacements[node] or node)
			events.OnObjectiveDestroyed(self, BGPatternReplacements[node] or node)
			return
		end
	end
end 

if not FACTION_STANDING_INCREASED then -- 1.10
	function events:CHAT_MSG_COMBAT_FACTION_CHANGE()
		local faction, rep = babbleCore:Deformat(arg1, FACTION_STANDING_INCREASED1)
		if not faction then
			faction, rep = babbleCore:Deformat(arg1, FACTION_STANDING_INCREASED2)
			if not faction then
				faction, rep = babbleCore:Deformat(arg1, FACTION_STANDING_INCREASED3)
				if not faction then
					faction, rep = babbleCore:Deformat(arg1, FACTION_STANDING_INCREASED4)
				end
			end
		end
		if faction and rep then
			if faction == FACTION_DEFILERS or faction == FACTION_FROSTWOLF_CLAN or faction == FACTION_WARSONG_OUTRIDERS or faction == FACTION_LEAGUE_OF_ARATHOR or faction == FACTION_STORMPIKE_GUARD or faction == FACTION_SILVERWING_SENTINELS then
				Trigger(self, "FACTION_GAIN", faction, rep)
			end
		end
	end
else -- 1.11
	function events:CHAT_MSG_COMBAT_FACTION_CHANGE()
		local faction, rep = babbleCore:Deformat(arg1, FACTION_STANDING_INCREASED)
		if faction and rep then
			if faction == FACTION_DEFILERS or faction == FACTION_FROSTWOLF_CLAN or faction == FACTION_WARSONG_OUTRIDERS or faction == FACTION_LEAGUE_OF_ARATHOR or faction == FACTION_STORMPIKE_GUARD or faction == FACTION_SILVERWING_SENTINELS then
				Trigger(self, "FACTION_GAIN", faction, rep)
			end
		end
	end
end

function events:CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS()
	self.lastHostileTime = GetTime()
end
events.CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE = events.CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS

function events:UNIT_PVP_UPDATE()
	if not UnitIsPVP("player") and self.permaPvP then
		self.permaPvP = false
		Trigger(self, "UPDATE_PERMANENT_PVP", self.permaPvP)
	end
	if UnitIsPVP("player") or self:IsInBattlegrounds() then
		self.pvpTime = GetTime()
		Trigger(self, "UPDATE_PVP_COOLDOWN", self:GetPvPCooldown())
	else
		Trigger(self, "UPDATE_PVP_COOLDOWN", 0)
	end
end

function events:UPDATE_WORLD_STATES()
	local resData = BattlefieldZoneResourceData[self:GetActiveBattlefieldZone()]
	if resData and self:GetNumAllianceBases() and self:GetNumHordeBases() then
		-- Common
		local goalResources = resData[table.getn(resData)]
		-- Alliance
		_, _, resources = string.find(self:GetAllianceScoreString(), "(%d+)/")
		bases = self:GetNumAllianceBases()
		if resources and bases and (resources ~= self.aLastResources or bases ~= self.aLastBases) then
			self.aResourceTTV = (goalResources - resources) / resData[bases]
			self.aLastResources = resources
			self.aLastBases = bases
			self.aLastUpdate = GetTime()
		end
		-- Horde
		_, _, resources = string.find(self:GetHordeScoreString(), "(%d+)/")
		bases = self:GetNumHordeBases()
		if resources and bases and (resources ~= self.hLastResources or bases ~= self.hLastBases) then
			self.hResourceTTV = (goalResources - resources) / resData[bases]
			self.hLastResources = resources
			self.hLastBases = bases
			self.hLastUpdate = GetTime()
		end
	end
end

function events:PLAYER_ENTERING_WORLD()
	playerFaction = UnitFactionGroup("player")
	isHorde = playerFaction == "Horde"
	events.UNIT_PVP_UPDATE(self)
	SetMapToCurrentZone()
	if self:IsInBattlegrounds() and GetNumMapLandmarks() > 0 then
		events.InitializeBattlefieldObjectives(self)
	else
		events.ClearBattlefieldObjectives(self)
	end
end

function events:PLAYER_DEAD()
	if GetTime() <= self.lastHostileTime + 15 then
		IncreaseDeaths(self)
	end
end

function lib:IsInBattlegrounds(self)
	local zone = GetRealZoneText()
	return zone == WARSONG_GULCH or zone == ARATHI_BASIN or zone == ALTERAC_VALLEY
end

function lib:IsInWarsongGulch()
	return GetRealZoneText() == WARSONG_GULCH
end

function lib:IsInArathiBasin()
	return GetRealZoneText() == ARATHI_BASIN
end

function lib:IsInAlteracValley()
	return GetRealZoneText() == ALTERAC_VALLEY
end

local function copyTable(to, from)
	for k, v in pairs(from) do
		to[k] = v
	end
	return to
end

local first, done, start
local function GetCurrentOrNextBattlegroundWeekend(week)
	local weekFactor = (week - 1) * 7
	local now = date("*t")
	local nowTime = time(now)
	if not first then
		first = {}
	end
	first = copyTable(first, now)
	first.day = 1
	--first.month = first.month - floor(week / 4)
	first.sec = 0
	first.min = 0
	first.hour = 1
	first = date("*t", time(first))
	if not done then
		done = {}
	end
	done = copyTable(done, first)
	done.day = weekFactor + 10 - first.wday
	done.hour = 23
	done.min = 59
	done.sec = 59
	if done.day == weekFactor + 3 then
		done.day = weekFactor + 10
	end
	while nowTime > time(done) do
		first.month = first.month + 1
		first = date("*t", time(first))
		done = copyTable(done, first)
		done.day = weekFactor + 10 - first.wday
		if done.day == weekFactor + 3 then
			done.day = weekFactor + 10
		end
	end
	done = date("*t", time(done))
	if not start then
		start = {}
	end
	start = copyTable(start, done)
	start.day = start.day - 3
	start = date("*t", time(start))
	local sMonth
	local dMonth
	if start.month == done.month then
		sMonth = date("%B", time(start))
		dMonth = sMonth
	else
		sMonth = date("%b", time(start))
		dMonth = date("%b", time(done))
	end
	start.hour = 1
	start.min = 0
	start.sec = 0
	return sMonth, start.day, dMonth, done.day, time(start) <= time(now) and time(now) <= time(done)
end

function lib:GetCurrentOrNextArathiWeekend()
	return GetCurrentOrNextBattlegroundWeekend(4)
end

function lib:GetCurrentOrNextWarsongWeekend()
	return GetCurrentOrNextBattlegroundWeekend(3)
end

function lib:GetCurrentOrNextAlteracWeekend()
	return GetCurrentOrNextBattlegroundWeekend(2)
end

function lib:_TogglePVP()
	self.permaPvP = not self.permaPvP
	if not UnitIsPVP("player") then
		self.permaPvP = true
	end
	Trigger(self, "UPDATE_PERMANENT_PVP", self.permaPvP)
	self.pvpTime = GetTime()
end

function lib:GetTodayHKs(person)
	if person then
		return self.data.hks[person] or 0
	else
		return self.data.todayHK
	end
end

function lib:GetTodayDeaths()
	return self.data.todayDeaths
end

function lib:GetTodayHKHonor()
	return self.data.todayHKHonor
end

function lib:GetTodayBonusHonor()
	return self.data.todayBonusHonor
end

function lib:GetTodayHonor()
	return self.data.todayHKHonor + self.data.todayBonusHonor
end

function lib:GetBattlegroundsWins()
	return self.data.wsgWin + self.data.abWin + self.data.avWin
end

function lib:GetWarsongGulchWins()
	return self.data.wsgWin
end

function lib:GetArathiBasinWins()
	return self.data.abWin
end

function lib:GetAlteracValleyWins()
	return self.data.avWin
end

function lib:GetBattlegroundsLosses()
	return self.data.wsgLoss + self.data.abLoss + self.data.avLoss
end

function lib:GetWarsongGulchLosses()
	return self.data.wsgLoss
end

function lib:GetArathiBasinLosses()
	return self.data.abLoss
end

function lib:GetAlteracValleyLosses()
	return self.data.avLoss
end

function lib:ResetBGScores()
	self.data.wsgWin = 0
	self.data.wsgLoss = 0
	self.data.abWin = 0
	self.data.abLoss = 0
	self.data.avWin = 0
	self.data.avLoss = 0
	Trigger(self, "BG_RESET_SCORES")
end

function lib:IsPermanentPvP()
	return self.permaPvP
end

function lib:GetPvPCooldown()
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

function lib:GetRankLimitInfo()
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
	elseif level <= 60 then
		return GetPVPRankInfo(18)
	end
end

function lib:GetRatingLimit()
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

function lib:GetStanding(name)
	name = name or playerName
	for i=1, GetNumBattlefieldScores() do
		if name == GetBattlefieldScore(i) then
			return i
		end
	end
end

function lib:GetKillingBlows(name)
	local unit, killingBlows
	name = name or playerName
	for i=1, GetNumBattlefieldScores() do
		unit, killingBlows = GetBattlefieldScore(i)
		if unit == name then
			return killingBlows
		end
	end
end

function lib:GetHonorableKills(name)
	name = name or playerName
	local unit, honorableKills
	for i=1, GetNumBattlefieldScores() do
		unit, _, honorableKills = GetBattlefieldScore(i)
		if unit == name then
			return honorableKills
		end
	end
end

function lib:GetDeaths(name)
	name = name or playerName
	local unit, deaths
	for i=1, GetNumBattlefieldScores() do
		unit, _, _, deaths = GetBattlefieldScore(i)
		if unit == name then
			return deaths
		end
	end
end

function lib:GetBonusHonor(name)
	name = name or playerName
	local unit, bonusHonor
	for i=1, GetNumBattlefieldScores() do
		unit, _, _, _, bonusHonor = GetBattlefieldScore(i)
		if unit == name then
			return bonusHonor
		end
	end
end

function lib:GetActiveBattlefieldZone()
	local status, mapName
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		status, mapName = GetBattlefieldStatus(i)
		if status == "active" then
			return mapName
		end
	end
end

function lib:GetActiveBattlefieldUniqueID()
	local status, mapName, instanceID
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		status, mapName, instanceID = GetBattlefieldStatus(i)
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
function lib:IterateQueuedBattlefieldZones()
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

function lib:IsBattlefieldObjective(node)
	local poi = self:NodeToPOI(node)
	if poi and (GetHolder(self, node) or self:IsInConflict(node) or self:IsDestroyed(node)) then
		return true
	end
	return false
end

function lib:IsInConflict(node)
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.IN_CONFLICT then
			return true
		end
	end
	return false
end

function lib:IsAllianceControlled(node)
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.ALLIANCE_CONTROLLED then
			return true
		end
	end
	return false
end

function lib:IsHordeControlled(node)
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
	lib.IsFriendlyControlled = lib.IsHordeControlled
	lib.IsHostileControlled = lib.IsAllianceControlled
else
	lib.IsFriendlyControlled = lib.IsAllianceControlled
	lib.IsHostileControlled = lib.IsHordeControlled
end

function lib:IsUncontrolled(node)
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.UNCONTROLLED then
			return true
		end
	end
	return
end

function lib:IsDestroyed(node)
	local poi = self:NodeToPOI(node)
	if poi then
		local _, description = GetMapLandmarkInfo(poi)
		if description == BGObjectiveDescriptions.DESTROYED then
			return true
		end
	end
	return
end

function lib:GetTimeAttacked(node)
	return self.battlefieldObjectiveStatus[node].timeAttacked
end

function lib:GetTimeToCapture(node)
	local t = BattlefieldZoneObjectiveTimes[self:GetActiveBattlefieldZone()] or 0
	return t - GetTime() + self.battlefieldObjectiveStatus[node].timeAttacked
end

function lib:GetName(node)
	return self.battlefieldObjectiveStatus[node].name
end

function lib:GetDefender(node)
	return self.battlefieldObjectiveStatus[node].defender 
end

function lib:GetAttacker(node)
	return self.battlefieldObjectiveStatus[node].attacker
end

local function objectiveNodesIter(_, position)
	local k = next(self.battlefieldObjectiveStatus, position)
	while k ~= nil and type(k) ~= "number" do
		k = next(self.battlefieldObjectiveStatus, position)
	end
	return k
end

function lib:IterateObjectiveNodes()
	return objectiveNodesIter, nil, nil
end

local function sortedObjectiveNodesIter(t, position)
	position = position + 1
	if position <= table.getn(t) then
		return position, t[position]
	else
		if compost then
			compost:Reclaim(t)
		end
		return nil
	end
end
function lib:IterateSortedObjectiveNodes()
	local t = compost and compost:Acquire() or {}
	for poi in pairs(self.battlefieldObjectiveStatus) do
		if type(poi) == "number" then
			table.insert(t, poi)
		end
	end
	table.sort(t, function(a, b)
		return self.battlefieldObjectiveStatus[a].ypos and self.battlefieldObjectiveStatus[b].ypos and self.battlefieldObjectiveStatus[a].ypos < self.battlefieldObjectiveStatus[b].ypos
	end)
	if not next(t) then
		if compost then
			compost:Reclaim(t)
		end
	else
		return sortedObjectiveNodesIter, t, 0
	end
end

function events:ClearBattlefieldObjectives()
	for k in pairs(self.battlefieldObjectiveStatus) do
		if compost then
			compost:Reclaim(self.battlefieldObjectiveStatus[k])
		end
		self.battlefieldObjectiveStatus[k] = nil
	end
end

function events:InitializeBattlefieldObjectives()
	local n, node, y
	events.ClearBattlefieldObjectives(self)
	SetMapToCurrentZone()
	local numPOIS = GetNumMapLandmarks()
	for i=1, numPOIS do
		if self:IsBattlefieldObjective(i) then
			node, _, _, _, y = GetMapLandmarkInfo(i)
			self.battlefieldObjectiveStatus[i] = false and compost and compost:AcquireHash(
				'name', node,
				'ypos', y,
				'defender', GetHolder(self, i),
				'inConflict', self:IsInConflict(i),
				'isDestroyed', self:IsDestroyed(i)
			) or {
				name = node,
				ypos = y,
				defender = GetHolder(self, i),
				inConflict = self:IsInConflict(i),
				isDestroyed = self:IsDestroyed(i),
			}
			self.battlefieldObjectiveStatus[node] = self.battlefieldObjectiveStatus[i]
		end
	end
end

function events:OnObjectiveClaimed(node, faction)
	local poi = self:NodeToPOI(node)
	if poi then
		if not next(self.battlefieldObjectiveStatus) then
			events.InitializeBattlefieldObjectives(self)
		end
		local n = self.battlefieldObjectiveStatus[poi]
		if n then
			n.attacker = faction
			n.inConflict = true
			n.timeAttacked = GetTime()
		end
	end	
end

function events:OnObjectiveCaptured(node, faction)
	local poi = self:NodeToPOI(node)
	if poi then
		if not next(self.battlefieldObjectiveStatus) then
			events.InitializeBattlefieldObjectives(self)
		end
		local n = self.battlefieldObjectiveStatus[poi]
		if n then
			n.defender = GetHolder(self, node) or faction
			n.attacker = nil
			n.inConflict = nil
			n.timeAttacked = nil
		end
	end
end

function events:OnObjectiveAttacked(node)
	local poi = self:NodeToPOI(node)
	if poi then
		if not next(self.battlefieldObjectiveStatus) then
			events.InitializeBattlefieldObjectives(self)
		end
		local n = self.battlefieldObjectiveStatus[poi]
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
	local poi = self:NodeToPOI(node)
	if poi then
		if not next(self.battlefieldObjectiveStatus) then
			events.InitializeBattlefieldObjectives(self)
		end
		local n = self.battlefieldObjectiveStatus[poi]
		if n then
			n.attacker = nil
			n.inConflict = nil
			n.timeAttacked = nil
		end
	end
end

function events:OnObjectiveDestroyed(node)
	local poi = self:NodeToPOI(node)
	if poi then
		if not next(self.battlefieldObjectiveStatus) then
			events.InitializeBattlefieldObjectives(self)
		end
		local n = self.battlefieldObjectiveStatus[poi]
		if n then
			n.isDestroyed = true
			n.defender = nil
			n.attacker = nil
			n.inConflict = nil
			n.timeAttacked = nil
		end
	end
end

function lib:GetAllianceFlagCarrier()
	return self.allianceFC
end

function lib:GetHordeFlagCarrier()
	return self.hordeFC
end

function lib:TargetAllianceFlagCarrier()
	if self.allianceFC then
		TargetByName(self.allianceFC)
	end
end

function lib:TargetHordeFlagCarrier()
	if self.hordeFC then
		TargetByName(self.hordeFC)
	end
end

if isHorde then
	lib.GetFriendlyFlagCarrier = lib.GetHordeFlagCarrier
	lib.GetHostileFlagCarrier = lib.GetAllianceFlagCarrier
	lib.TargetFriendlyFlagCarrier = lib.TargetHordeFlagCarrier
	lib.TargetHostileFlagCarrier = lib.TargetAllianceFlagCarrier
else
	lib.GetFriendlyFlagCarrier = lib.GetAllianceFlagCarrier
	lib.GetHostileFlagCarrier = lib.GetHordeFlagCarrier
	lib.TargetFriendlyFlagCarrier = lib.TargetAllianceFlagCarrier
	lib.TargetHostileFlagCarrier = lib.TargetHordeFlagCarrier
end

function lib:GetFlagCarrier(faction)
	if faction == FACTION_ALLIANCE or faction == "Alliance" or faction == 1 then
		return self.allianceFC
	else
		return self.hordeFC
	end
end

function lib:TargetFlagCarrier(faction)
	if faction == FACTION_ALLIANCE or faction == "Alliance" or faction == 1 then
		if self.allianceFC then
			TargetByName(self.allianceFC)
		end
	elseif self.hordeFC then
		TargetByName(self.hordeFC)
	end
end

function lib:GetNumAllianceBases()
	if GetWorldStateUIInfo(1) then
		local _, _, bases = string.find(GetWorldStateUIInfo(1), PATTERN_GWSUII_BASES)
		return tonumber(bases)
	end
end

function lib:GetNumHordeBases()
	if GetWorldStateUIInfo(2) then
		local _, _, bases = string.find(GetWorldStateUIInfo(2), PATTERN_GWSUII_BASES)
		return tonumber(bases)
	end
end

if isHorde then
	lib.GetNumFriendlyBases = lib.GetNumHordeBases
	lib.GetNumHostileBases = lib.GetNumAllianceBases
else
	lib.GetNumFriendlyBases = lib.GetNumAllianceBases
	lib.GetNumHostileBases = lib.GetNumHordeBases
end

function lib:GetNumBases(team)
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		team = 1
	else
		team = 2
	end
	if GetWorldStateUIInfo(team) then
		local _, _, bases = string.find(GetWorldStateUIInfo(team), PATTERN_GWSUII_BASES)
		return tonumber(bases)
	end
end

function lib:GetNumAllianceResources()
	if GetWorldStateUIInfo(1) then
		local _, _, resources = string.find(GetWorldStateUIInfo(1), PATTERN_GWSUII_RESOURCES)
		return tonumber(resources)
	end
end

function lib:GetNumHordeResources()
	if GetWorldStateUIInfo(2) then
		local _, _, resources = string.find(GetWorldStateUIInfo(2), PATTERN_GWSUII_RESOURCES)
		return tonumber(resources)
	end
end

if isHorde then
	lib.GetNumFriendlyResources = lib.GetNumHordeResources
	lib.GetNumHostileResources = lib.GetNumAllianceResources
else
	lib.GetNumFriendlyResources = lib.GetNumAllianceResources
	lib.GetNumHostileResources = lib.GetNumHordeResources
end

function lib:GetNumTeamResources(team)
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetNumAllianceResources()
	else
		return self:GetNumHordeResources()
	end
end

function lib:GetAllianceTTV()
	return self.aResourceTTV - GetTime() + self.aLastUpdate
end

function lib:GetHordeTTV()
	return self.hResourceTTV - GetTime() + self.hLastUpdate
end

function lib:GetTeamTTV(team)
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetAllianceTTV()
	else
		return self:GetHordeTTV()
	end
end

if isHorde then
	lib.GetFriendlyTTV = lib.GetHordeTTV
	lib.GetHostileTTV = lib.GetAllianceTTV
else
	lib.GetFriendlyTTV = lib.GetAllianceTTV
	lib.GetHostileTTV = lib.GetHordeTTV
end
	
function lib:GetAllianceScoreString()
	if GetWorldStateUIInfo(1) then
		local _, _, scoreString = string.find(GetWorldStateUIInfo(1), PATTERN_GWSUII_SCORE)
		return scoreString
	end
end

function lib:GetHordeScoreString()
	if GetWorldStateUIInfo(2) then
		local _, _, scoreString = string.find(GetWorldStateUIInfo(2), PATTERN_GWSUII_SCORE)
		return scoreString
	end
end

if isHorde then
	lib.GetFriendlyScoreString = lib.GetHordeScoreString
	lib.GetHostileScoreString = lib.GetAllianceScoreString
else
	lib.GetFriendlyScoreString = lib.GetAllianceScoreString
	lib.GetHostileScoreString = lib.GetHordeScoreString
end

function lib:GetTeamScoreString(team)
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetAllianceScoreString()
	else
		return self:GetHordeScoreString()
	end
end

function lib:GetNumAlliancePlayers()
	local numPlayers = 0
	for i = 1, GetNumBattlefieldScores() do
		local _, _, _, _, _, faction = GetBattlefieldScore(i)
		if faction == 1 then
			numPlayers = numPlayers + 1
		end
	end
	return numPlayers
end

function lib:GetNumHordePlayers()
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
	lib.GetNumFriendlyPlayers = lib.GetNumHordePlayers
	lib.GetNumHostilePlayers = lib.GetNumAlliancePlayers
else
	lib.GetNumFriendlyPlayers = lib.GetNumAlliancePlayers
	lib.GetNumHostilePlayers = lib.GetNumHordePlayers
end

function lib:GetNumPlayers(team)
	if team == FACTION_ALLIANCE or team == "Alliance" or team == 1 then
		return self:GetNumAlliancePlayers()
	else
		return self:GetNumHordePlayers()
	end
end

function lib:NodeToPOI(node)
	local landmark, description
	if type(node) == "number" and node > 0 and node <= GetNumMapLandmarks() then
		return node
	elseif type(node) == "string" then
		for i = 1, GetNumMapLandmarks() do
			if string.lower(node) == string.lower(GetMapLandmarkInfo(i)) then
				return i
			end
		end
	end
end

function lib:GetBGAcronym(bgName)
	return BGAcronyms[bgName] or bgName
end

function lib:GetFactionColor(faction)
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

function lib:GetFactionHexColor(faction)
	local r, g, b = self:GetFactionColor(faction)
	return string.format("%02X%02X%02X", 255*r, 255*g, 255*b)
end

function lib:Register(event, func, arg)
	if not self.registry[event] then
		self.registry[event] = compost and compost:Acquire() or {}
	end
	if arg == nil then
		arg = event
	end
	self.registry[event][func] = arg
end

function lib:Unregister(event, func)
	if self.registry[event][func] then
		self.registry[event][func] = nil
	end
	if not next(self.registry[event]) then
		if compost then
			compost:Reclaim(self.registry[event])
		end
		self.registry[event] = nil
	end
end

function lib:UnregisterAll(object)
	for event in pairs(self.registry) do
		self.registry[event][object] = nil
		for func, u in pairs(self.registry[event]) do
			if u == object then
				self.registry[event][func] = nil
			end
		end
	end
end

GloryLib:Register(lib)
lib = nil

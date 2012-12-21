--[[
Name: Tourist-2.0
Revision: $Rev: 5925 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Tourist-2.0
SVN: http://svn.wowace.com/root/trunk/TouristLib/Tourist-2.0
Description: A library to provide information about zones and instances.
Dependencies: AceLibrary, Babble-Zone-2.0, AceConsole-2.0 (optional)
]]

local MAJOR_VERSION = "Tourist-2.0"
local MINOR_VERSION = "$Revision: 5925 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("Babble-Zone-2.0") then error(MAJOR_VERSION .. " requires Babble-Zone-2.0") end

local Tourist = {}
local events = {}

local loc
do
	local Z = AceLibrary("Babble-Zone-2.0")
	loc = {
		BOOTY_BAY = Z"Booty Bay",
		DEEPRUN_TRAM = Z"Deeprun Tram",
		IRONFORGE = Z"Ironforge",
		STORMWIND_CITY = Z"Stormwind City",
		ELWYNN_FOREST = Z"Elwynn Forest",
		DUN_MOROGH = Z"Dun Morogh",
		TIRISFAL_GLADES = Z"Tirisfal Glades",
		LOCH_MODAN = Z"Loch Modan",
		SILVERPINE_FOREST = Z"Silverpine Forest",
		WESTFALL = Z"Westfall",
		REDRIDGE_MOUNTAINS = Z"Redridge Mountains",
		DUSKWOOD = Z"Duskwood",
		HILLSBRAD_FOOTHILLS = Z"Hillsbrad Foothills",
		WETLANDS = Z"Wetlands",
		ALTERAC_MOUNTAINS = Z"Alterac Mountains",
		ARATHI_HIGHLANDS = Z"Arathi Highlands",
		STRANGLETHORN_VALE = Z"Stranglethorn Vale",
		BADLANDS = Z"Badlands",
		SWAMP_OF_SORROWS = Z"Swamp of Sorrows",
		DEADWIND_PASS = Z"Deadwind Pass",
		HINTERLANDS = Z"The Hinterlands",
		SEARING_GORGE = Z"Searing Gorge",
		BLASTED_LANDS = Z"Blasted Lands",
		BURNING_STEPPES = Z"Burning Steppes",
		WESTERN_PLAGUELANDS = Z"Western Plaguelands",
		EASTERN_PLAGUELANDS = Z"Eastern Plaguelands",
		RATCHET = Z"Ratchet",
		GADGETZAN = Z"Gadgetzan",
		ORGRIMMAR = Z"Orgrimmar",
		THUNDER_BLUFF = Z"Thunder Bluff",
		UNDERCITY = Z"Undercity",
		DUROTAR = Z"Durotar",
		MULGORE = Z"Mulgore",
		DARKSHORE = Z"Darkshore",
		BARRENS = Z"The Barrens",
		STONETALON_MOUNTAINS = Z"Stonetalon Mountains",
		ASHENVALE = Z"Ashenvale",
		THOUSAND_NEEDLES = Z"Thousand Needles",
		DESOLACE = Z"Desolace",
		DUSTWALLOW_MARSH = Z"Dustwallow Marsh",
		FERALAS = Z"Feralas",
		TANARIS = Z"Tanaris",
		AZSHARA = Z"Azshara",
		FELWOOD = Z"Felwood",
		UN_GORO_CRATER = Z"Un'Goro Crater",
		SILITHUS = Z"Silithus",
		WINTERSPRING = Z"Winterspring",
		HYJAL = Z"Hyjal",
		MOONGLADE = Z"Moonglade",
		DARNASSUS = Z"Darnassus",
		TELDRASSIL = Z"Teldrassil",
		ALTERAC_VALLEY = Z"Alterac Valley",
		WARSONG_GULCH = Z"Warsong Gulch",
		ARATHI_BASIN = Z"Arathi Basin",
		STOCKADE = Z"The Stockade",
		RAGEFIRE_CHASM = Z"Ragefire Chasm",
		ZUL_FARRAK = Z"Zul'Farrak",
		DEADMINES = Z"The Deadmines",
		WAILING_CAVERNS = Z"Wailing Caverns",
		GNOMEREGAN = Z"Gnomeregan",
		RAZORFEN_KRAUL = Z"Razorfen Kraul",
		BLACKFATHOM_DEEPS = Z"Blackfathom Deeps",
		SHADOWFANG_KEEP = Z"Shadowfang Keep",
		SCARLET_MONASTERY = Z"Scarlet Monastery",
		ULDAMAN = Z"Uldaman",
		RAZORFEN_DOWNS = Z"Razorfen Downs",
		MARAUDON = Z"Maraudon",
		ONYXIAS_LAIR = Z"Onyxia's Lair",
		BLACKROCK_MOUNTAIN = Z"Blackrock Mountain",
		CAVERNS_OF_TIME = Z"Caverns of Time",
		TEMPLE_OF_ATAL_HAKKAR = Z"The Temple of Atal'Hakkar",
		DIRE_MAUL = Z"Dire Maul",
		BLACKROCK_DEPTHS = Z"Blackrock Depths",
		BLACKROCK_SPIRE = Z"Blackrock Spire",
		STRATHOLME = Z"Stratholme",
		MOLTEN_CORE = Z"Molten Core",
		SCHOLOMANCE = Z"Scholomance",
		BLACKWING_LAIR = Z"Blackwing Lair",
		ZUL_GURUB = Z"Zul'Gurub",
		RUINS_OF_AHN_QIRAJ = Z"Ruins of Ahn'Qiraj",
		TEMPLE_OF_AHN_QIRAJ = Z"Temple of Ahn'Qiraj",
		NAXXRAMAS = Z"Naxxramas",
	}
end

local playerLevel = 1
local _,race = UnitRace("player")
local isHorde = (race == "Orc" or race == "Troll" or race == "Tauren" or race == "Scourge")

function events:PLAYER_LEVEL_UP()
	playerLevel = UnitLevel("player")
	for k in pairs(self.recZones) do
		self.recZones[k] = nil
	end
	for k in pairs(self.recInstances) do
		self.recInstances[k] = nil
	end
	for zone in self.lowZones do
		if not self:IsHostile(zone) then
			local low, high = self:GetLevel(zone)
			if not self:IsInstance(zone) then
				if low <= playerLevel and playerLevel <= high then
					self.recZones[zone] = true
				end
			elseif self:IsBattleground(zone) then
				if playerLevel >= low and (playerLevel == 60 or math.mod(playerLevel, 10) >= 6) then
					self.recInstances[zone] = true
				end
			else
				if low <= playerLevel and playerLevel <= high then
					self.recInstances[zone] = true
				end
			end
		end
	end
end

events.PLAYER_ENTERING_WORLD = events.PLAYER_LEVEL_UP

function Tourist:GetLevel(zone)
	self:argCheck(zone, 2, "string")
	if self:IsBattleground(zone) then
		if zone == loc.ALTERAC_VALLEY then
			return 51, 60
		elseif playerLevel == 60 then
			return 60, 60
		elseif playerLevel >= 50 then
			return 50, 59
		elseif playerLevel >= 40 then
			return 40, 49
		elseif playerLevel >= 30 then
			return 30, 39
		elseif playerLevel >= 20 or zone == loc.ARATHI_BASIN then
			return 20, 29
		else
			return 10, 19
		end
	end
	return self.lowZones[zone] or -6, self.highZones[zone] or -6
end

function Tourist:GetLevelColor(zone)
	self:argCheck(zone, 2, "string")
	if self:IsBattleground(zone) then
		if (playerLevel < 51 and zone == loc.ALTERAC_VALLEY) or (playerLevel < 20 and zone == loc.ARATHI_BASIN) or (playerLevel < 10 and zone == loc.WARSONG_GULCH) then
			return 1, 0, 0
		end
		local playerLevel = playerLevel
		if zone == loc.ALTERAC_VALLEY then
			playerLevel = playerLevel - 1
		end
		if playerLevel == 60 then
			return 1, 1, 0
		end
		playerLevel = math.mod(playerLevel, 10)
		if playerLevel <= 5 then
			return 1, playerLevel / 10, 0
		elseif playerLevel <= 7 then
			return 1, (playerLevel - 3) / 4, 0
		else
			return (9 - playerLevel) / 2, 1, 0
		end
	end
	local low, high = self:GetLevel(zone)
	
	if playerLevel <= low - 3 then
		return 1, 0, 0
	elseif playerLevel <= low then
		return 1, (playerLevel - low - 3) / -6, 0
	elseif playerLevel <= (low + high) / 2 then
		return 1, (playerLevel - low) / (high - low) + 0.5, 0
	elseif playerLevel <= high then
		return 2 * (playerLevel - high) / (low - high), 1, 0
	elseif playerLevel <= high + 3 then
		local num = (playerLevel - high) / 6
		return num, 1 - num, num
	else
		return 0.5, 0.5, 0.5
	end
end

function Tourist:GetFactionColor(zone)
	self:argCheck(zone, 2, "string")
	if self:IsAlliance(zone) then
		if not isHorde then
			return 0, 1, 0
		else
			return 1, 0, 0
		end
	elseif self:IsHorde(zone) then
		if isHorde then
			return 0, 1, 0
		else
			return 1, 0, 0
		end
	else
		return 1, 1, 0
	end
end

local retNil = function() end
local retOne = function(zone, state)
	if state ~= nil then
		return
	else
		return zone
	end
end

local function iterZoneInstances(zone, position)
	local k = next(zone, position)
	return k
end

function Tourist:IterateZoneInstances(zone)
	self:argCheck(zone, 2, "string")
	if type(self.zoneInstances[zone]) == nil then
		return retNil, nil, nil
	elseif type(self.zoneInstances[zone]) == "table" then
		return iterZoneInstances, self.zoneInstances[zone], nil
	else
		return retOne, self.zoneInstances[zone], nil
	end
end

function Tourist:DoesZoneHaveInstances(zone)
	self:argCheck(zone, 2, "string")
	return self.zoneInstances[zone] ~= nil
end

local zonesInstances
local function initZonesInstances()
	if not zonesInstances then
		zonesInstances = {}
		for zone in pairs(self.lowZones) do
			zonesInstances[zone] = true
		end
	end
	initZonesInstances = nil
end

local function zoneInstanceIter(_, position)
	local k = next(zonesInstances, position)
	return k
end
function Tourist:IterateZonesAndInstances()
	if initZonesInstances then
		initZonesInstances()
	end
	return zoneInstanceIter, nil, nil
end

local function zoneIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and self:IsInstance(k) do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateZones()
	if initZonesInstances then
		initZonesInstances()
	end
	return zoneIter, nil, nil
end

local function instanceIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and not self:IsInstance(k) do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateInstances()
	if initZonesInstances then
		initZonesInstances()
	end
	return instanceIter, nil, nil
end

local function bgIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and not self:IsBattleground(k) do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateBattlegrounds()
	if initZonesInstances then
		initZonesInstances()
	end
	return bgIter, nil, nil
end

local function allianceIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and not self:IsAlliance(k) do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateAlliance()
	if initZonesInstances then
		initZonesInstances()
	end
	return allianceIter, nil, nil
end

local function hordeIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and not self:IsHorde(k) do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateHorde()
	if initZonesInstances then
		initZonesInstances()
	end
	return hordeIter, nil, nil
end

function Tourist:IterateFriendly()
	if isHorde then
		return self:IterateHordeZonesInstances()
	else
		return self:IterateAllianceZonesInstances()
	end
end

function Tourist:IterateHostile()
	if isHorde then
		return self:IterateAllianceZonesInstances()
	else
		return self:IterateHordeZonesInstances()
	end
end

local function contestedIter(_, position)
	local k = next(zonesInstances, position)
	while k ~= nil and (self:IsAlliance(k) or self:IsHorde(k)) do
		k = next(zonesInstances, k)
	end
	return k
end
function Tourist:IterateContested()
	if initZonesInstances then
		initZonesInstances()
	end
	return contestedIter, nil, nil
end

local function recZoneIter(recZones, position)
	local k = next(recZones, position)
	return k
end
function Tourist:IterateRecommendedZones()
	return recZoneIter, self.recZones, nil
end

function Tourist:IterateRecommendedInstances()
	return recZoneIter, self.recInstances, nil
end

function Tourist:HasRecommendedInstances()
	return next(self.recInstances) ~= nil
end

function Tourist:IsInstance(zone)
	self:argCheck(zone, 2, "string")
	return self.instances[zone] ~= nil
end

function Tourist:IsZone(zone)
	self:argCheck(zone, 2, "string")
	return self.instances[zone] == nil and not self.lowZones[zone] ~= nil
end

function Tourist:IsZoneOrInstance(zone)
	self:argCheck(zone, 2, "string")
	return self.lowZones[zone] ~= nil
end

function Tourist:IsBattleground(zone)
	self:argCheck(zone, 2, "string")
	return zone == loc.WARSONG_GULCH or zone == loc.ARATHI_BASIN or zone == loc.ALTERAC_VALLEY
end

function Tourist:IsAlliance(zone)
	self:argCheck(zone, 2, "string")
	return zone == loc.IRONFORGE or zone == loc.STORMWIND_CITY or zone == loc.DUN_MOROGH or zone == loc.ELWYNN_FOREST or zone == loc.LOCH_MODAN or zone == loc.WESTFALL or zone == loc.DARNASSUS or zone == loc.TELDRASSIL or zone == loc.DARKSHORE or zone == loc.STOCKADE or zone == loc.GNOMEREGAN or zone == loc.DEADMINES
end

function Tourist:IsHorde(zone)
	self:argCheck(zone, 2, "string")
	return zone == loc.UNDERCITY or zone == loc.ORGRIMMAR or zone == loc.THUNDER_BLUFF or zone == loc.TIRISFAL_GLADES or zone == loc.SILVERPINE_FOREST or zone == loc.DUROTAR or zone == loc.MULGORE or zone == loc.BARRENS or zone == loc.RAGEFIRE_CHASM or zone == loc.SHADOWFANG_KEEP or zone == loc.WAILING_CAVERNS
end

function Tourist:IsFriendly(zone)
	self:argCheck(zone, 2, "string")
	if isHorde then
		return self:IsHorde(zone)
	else
		return self:IsAlliance(zone)
	end
end

function Tourist:IsHostile(zone)
	self:argCheck(zone, 2, "string")
	if isHorde then
		return self:IsAlliance(zone)
	else
		return self:IsHorde(zone)
	end
end

function Tourist:IsContested(zone)
	self:argCheck(zone, 2, "string")
	return not self:IsAlliance(zone) and not self:IsHorde(zone)
end

local function activate(self, oldLib, oldDeactivate)
	if oldLib then
		self.frame = oldLib.frame
		self.frame:UnregisterAllEvents()
		self.lowZones = oldLib.lowZones
		self.highZones = oldLib.highZones
		self.zoneInstances = oldLib.zoneInstances
		self.instances = oldLib.instances
		self.recZones = oldLib.recZones
		self.recInstances = oldLib.recInstances
		for k in pairs(self.lowZones) do
			self.lowZones[k] = nil
		end
		for k in pairs(self.highZones) do
			self.highZones[k] = nil
		end
		for k in pairs(self.zoneInstances) do
			self.zoneInstances[k] = nil
		end
		for k in pairs(self.instances) do
			self.instances[k] = nil
		end
	else
		self.frame = CreateFrame("Frame", "TouristLibFrame", UIParent)
		self.lowZones = {}
		self.highZones = {}
		self.zoneInstances = {}
		self.instances = {}
		self.recZones = {}
		self.recInstances = {}
	end
	self.frame:RegisterEvent("PLAYER_LEVEL_UP")
	self.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	self.frame:SetScript("OnEvent", function()
		events[event](self)
	end)
	-- Eastern Kingdoms
	self.lowZones[loc.BOOTY_BAY] = -6
	self.highZones[loc.BOOTY_BAY] = -6
	self.lowZones[loc.DEEPRUN_TRAM] = -6
	self.highZones[loc.DEEPRUN_TRAM] = -6
	self.lowZones[loc.IRONFORGE] = -6
	self.highZones[loc.IRONFORGE] = -6
	self.lowZones[loc.STORMWIND_CITY] = -6
	self.highZones[loc.STORMWIND_CITY] = -6
	self.lowZones[loc.ELWYNN_FOREST] = 1
	self.highZones[loc.ELWYNN_FOREST] = 10
	self.lowZones[loc.DUN_MOROGH] = 1
	self.highZones[loc.DUN_MOROGH] = 10
	self.lowZones[loc.TIRISFAL_GLADES] = 1
	self.highZones[loc.TIRISFAL_GLADES] = 10
	self.lowZones[loc.LOCH_MODAN] = 10
	self.highZones[loc.LOCH_MODAN] = 20
	self.lowZones[loc.SILVERPINE_FOREST] = 10
	self.highZones[loc.SILVERPINE_FOREST] = 20
	self.lowZones[loc.WESTFALL] = 10
	self.highZones[loc.WESTFALL] = 20
	self.lowZones[loc.REDRIDGE_MOUNTAINS] = 15
	self.highZones[loc.REDRIDGE_MOUNTAINS] = 25
	self.lowZones[loc.DUSKWOOD] = 18
	self.highZones[loc.DUSKWOOD] = 30
	self.lowZones[loc.HILLSBRAD_FOOTHILLS] = 20
	self.highZones[loc.HILLSBRAD_FOOTHILLS] = 30
	self.lowZones[loc.WETLANDS] = 20
	self.highZones[loc.WETLANDS] = 30
	self.lowZones[loc.ALTERAC_MOUNTAINS] = 30
	self.highZones[loc.ALTERAC_MOUNTAINS] = 40
	self.lowZones[loc.ARATHI_HIGHLANDS] = 30
	self.highZones[loc.ARATHI_HIGHLANDS] = 40
	self.lowZones[loc.STRANGLETHORN_VALE] = 30
	self.highZones[loc.STRANGLETHORN_VALE] = 45
	self.lowZones[loc.BADLANDS] = 35
	self.highZones[loc.BADLANDS] = 45
	self.lowZones[loc.SWAMP_OF_SORROWS] = 35
	self.highZones[loc.SWAMP_OF_SORROWS] = 45
	self.lowZones[loc.DEADWIND_PASS] = 37
	self.highZones[loc.DEADWIND_PASS] = 60
	self.lowZones[loc.HINTERLANDS] = 40
	self.highZones[loc.HINTERLANDS] = 50
	self.lowZones[loc.SEARING_GORGE] = 43
	self.highZones[loc.SEARING_GORGE] = 50
	self.lowZones[loc.BLASTED_LANDS] = 45
	self.highZones[loc.BLASTED_LANDS] = 55
	self.lowZones[loc.BURNING_STEPPES] = 50
	self.highZones[loc.BURNING_STEPPES] = 58
	self.lowZones[loc.WESTERN_PLAGUELANDS] = 51
	self.highZones[loc.WESTERN_PLAGUELANDS] = 58
	self.lowZones[loc.EASTERN_PLAGUELANDS] = 53
	self.highZones[loc.EASTERN_PLAGUELANDS] = 60

	-- Kalimdor
	self.lowZones[loc.RATCHET] = -6
	self.highZones[loc.RATCHET] = -6
	self.lowZones[loc.GADGETZAN] = -6
	self.highZones[loc.GADGETZAN] = -6
	self.lowZones[loc.ORGRIMMAR] = -6
	self.highZones[loc.ORGRIMMAR] = -6
	self.lowZones[loc.THUNDER_BLUFF] = -6
	self.highZones[loc.THUNDER_BLUFF] = -6
	self.lowZones[loc.UNDERCITY] = -6
	self.highZones[loc.UNDERCITY] = -6
	self.lowZones[loc.DUROTAR] = 1
	self.highZones[loc.DUROTAR] = 10
	self.lowZones[loc.MULGORE] = 1
	self.highZones[loc.MULGORE] = 10
	self.lowZones[loc.DARKSHORE] = 10
	self.highZones[loc.DARKSHORE] = 20
	self.lowZones[loc.BARRENS] = 10
	self.highZones[loc.BARRENS] = 25
	self.lowZones[loc.STONETALON_MOUNTAINS] = 15
	self.highZones[loc.STONETALON_MOUNTAINS] = 27
	self.lowZones[loc.ASHENVALE] = 18
	self.highZones[loc.ASHENVALE] = 30
	self.lowZones[loc.THOUSAND_NEEDLES] = 25
	self.highZones[loc.THOUSAND_NEEDLES] = 35
	self.lowZones[loc.DESOLACE] = 30
	self.highZones[loc.DESOLACE] = 40
	self.lowZones[loc.DUSTWALLOW_MARSH] = 35
	self.highZones[loc.DUSTWALLOW_MARSH] = 45
	self.lowZones[loc.FERALAS] = 40
	self.highZones[loc.FERALAS] = 50
	self.lowZones[loc.TANARIS] = 40
	self.highZones[loc.TANARIS] = 50
	self.lowZones[loc.AZSHARA] = 45
	self.highZones[loc.AZSHARA] = 55
	self.lowZones[loc.FELWOOD] = 48
	self.highZones[loc.FELWOOD] = 55
	self.lowZones[loc.UN_GORO_CRATER] = 48
	self.highZones[loc.UN_GORO_CRATER] = 55
	self.lowZones[loc.SILITHUS] = 55
	self.highZones[loc.SILITHUS] = 60
	self.lowZones[loc.WINTERSPRING] = 55
	self.highZones[loc.WINTERSPRING] = 60
	self.lowZones[loc.HYJAL] = 60
	self.highZones[loc.HYJAL] = 60
	self.lowZones[loc.MOONGLADE] = -6
	self.highZones[loc.MOONGLADE] = -6
	self.lowZones[loc.DARNASSUS] = -6
	self.highZones[loc.DARNASSUS] = -6
	self.lowZones[loc.TELDRASSIL] = 1
	self.highZones[loc.TELDRASSIL] = 10

	-- Battlegrounds (Tiered)
	self.lowZones[loc.ALTERAC_VALLEY] = -6
	self.highZones[loc.ALTERAC_VALLEY] = -6
	self.lowZones[loc.WARSONG_GULCH] = -6
	self.highZones[loc.WARSONG_GULCH] = -6
	self.lowZones[loc.ARATHI_BASIN] = -6
	self.highZones[loc.ARATHI_BASIN] = -6

	-- Instances
	if GetLocale() == "enUS" then
		self.lowZones[loc.STOCKADE] = 24
		self.highZones[loc.STOCKADE] = 32
		self.lowZones[loc.RAGEFIRE_CHASM] = 13
		self.highZones[loc.RAGEFIRE_CHASM] = 18
		self.lowZones[loc.ZUL_FARRAK] = 44
		self.highZones[loc.ZUL_FARRAK] = 54
		self.lowZones[loc.DEADMINES] = 17
		self.highZones[loc.DEADMINES] = 26
		self.lowZones[loc.WAILING_CAVERNS] = 17
		self.highZones[loc.WAILING_CAVERNS] = 24
		self.lowZones[loc.GNOMEREGAN] = 29
		self.highZones[loc.GNOMEREGAN] = 38
		self.lowZones[loc.RAZORFEN_KRAUL] = 29
		self.highZones[loc.RAZORFEN_KRAUL] = 38
		self.lowZones[loc.BLACKFATHOM_DEEPS] = 24
		self.highZones[loc.BLACKFATHOM_DEEPS] = 32
		self.lowZones[loc.SHADOWFANG_KEEP] = 22
		self.highZones[loc.SHADOWFANG_KEEP] = 30
		self.lowZones[loc.SCARLET_MONASTERY] = 34
		self.highZones[loc.SCARLET_MONASTERY] = 45
		self.lowZones[loc.ULDAMAN] = 41
		self.highZones[loc.ULDAMAN] = 51
		self.lowZones[loc.RAZORFEN_DOWNS] = 37
		self.highZones[loc.RAZORFEN_DOWNS] = 46
		self.lowZones[loc.MARAUDON] = 46
		self.highZones[loc.MARAUDON] = 55
		self.lowZones[loc.ONYXIAS_LAIR] = 60
		self.highZones[loc.ONYXIAS_LAIR] = 62
		self.lowZones[loc.BLACKROCK_MOUNTAIN] = 42
		self.highZones[loc.BLACKROCK_MOUNTAIN] = 54
		self.lowZones[loc.CAVERNS_OF_TIME] = 43
		self.highZones[loc.CAVERNS_OF_TIME] = 61
		self.lowZones[loc.TEMPLE_OF_ATAL_HAKKAR] = 50
		self.highZones[loc.TEMPLE_OF_ATAL_HAKKAR] = 60
		self.lowZones[loc.DIRE_MAUL] = 56
		self.highZones[loc.DIRE_MAUL] = 60
		self.lowZones[loc.BLACKROCK_DEPTHS] = 52
		self.highZones[loc.BLACKROCK_DEPTHS] = 60
		self.lowZones[loc.BLACKROCK_SPIRE] = 55
		self.highZones[loc.BLACKROCK_SPIRE] = 60
		self.lowZones[loc.STRATHOLME] = 58
		self.highZones[loc.STRATHOLME] = 60
		self.lowZones[loc.MOLTEN_CORE] = 60
		self.highZones[loc.MOLTEN_CORE] = 62
		self.lowZones[loc.SCHOLOMANCE] = 58
		self.highZones[loc.SCHOLOMANCE] = 60
		self.lowZones[loc.BLACKWING_LAIR] = 60
		self.highZones[loc.BLACKWING_LAIR] = 62
		self.lowZones[loc.ZUL_GURUB] = 60
		self.highZones[loc.ZUL_GURUB] = 62
		self.lowZones[loc.RUINS_OF_AHN_QIRAJ] = 60
		self.highZones[loc.RUINS_OF_AHN_QIRAJ] = 65
		self.lowZones[loc.TEMPLE_OF_AHN_QIRAJ] = 60
		self.highZones[loc.TEMPLE_OF_AHN_QIRAJ] = 65
		self.lowZones[loc.NAXXRAMAS] = 60
		self.highZones[loc.NAXXRAMAS] = 70
	else
		self.lowZones[loc.STOCKADE] = 23
		self.highZones[loc.STOCKADE] = 26
		self.lowZones[loc.RAGEFIRE_CHASM] = 13
		self.highZones[loc.RAGEFIRE_CHASM] = 15
		self.lowZones[loc.ZUL_FARRAK] = 43
		self.highZones[loc.ZUL_FARRAK] = 47
		self.lowZones[loc.DEADMINES] = 15
		self.highZones[loc.DEADMINES] = 20
		self.lowZones[loc.WAILING_CAVERNS] = 15
		self.highZones[loc.WAILING_CAVERNS] = 21
		self.lowZones[loc.GNOMEREGAN] = 24
		self.highZones[loc.GNOMEREGAN] = 33
		self.lowZones[loc.RAZORFEN_KRAUL] = 25
		self.highZones[loc.RAZORFEN_KRAUL] = 35
		self.lowZones[loc.BLACKFATHOM_DEEPS] = 20
		self.highZones[loc.BLACKFATHOM_DEEPS] = 27
		self.lowZones[loc.SHADOWFANG_KEEP] = 18
		self.highZones[loc.SHADOWFANG_KEEP] = 25
		self.lowZones[loc.SCARLET_MONASTERY] = 30
		self.highZones[loc.SCARLET_MONASTERY] = 40
		self.lowZones[loc.ULDAMAN] = 35
		self.highZones[loc.ULDAMAN] = 45
		self.lowZones[loc.RAZORFEN_DOWNS] = 35
		self.highZones[loc.RAZORFEN_DOWNS] = 40
		self.lowZones[loc.MARAUDON] = 40
		self.highZones[loc.MARAUDON] = 49
		self.lowZones[loc.ONYXIAS_LAIR] = 60
		self.highZones[loc.ONYXIAS_LAIR] = 62
		self.lowZones[loc.BLACKROCK_MOUNTAIN] = 42
		self.highZones[loc.BLACKROCK_MOUNTAIN] = 54
		self.lowZones[loc.CAVERNS_OF_TIME] = -6
		self.highZones[loc.CAVERNS_OF_TIME] = -6
		self.lowZones[loc.TEMPLE_OF_ATAL_HAKKAR] = 44
		self.highZones[loc.TEMPLE_OF_ATAL_HAKKAR] = 50
		self.lowZones[loc.DIRE_MAUL] = 56
		self.highZones[loc.DIRE_MAUL] = 60
		self.lowZones[loc.BLACKROCK_DEPTHS] = 48
		self.highZones[loc.BLACKROCK_DEPTHS] = 56
		self.lowZones[loc.BLACKROCK_SPIRE] = 53
		self.highZones[loc.BLACKROCK_SPIRE] = 60
		self.lowZones[loc.STRATHOLME] = 55
		self.highZones[loc.STRATHOLME] = 60
		self.lowZones[loc.MOLTEN_CORE] = 60
		self.highZones[loc.MOLTEN_CORE] = 62
		self.lowZones[loc.SCHOLOMANCE] = 56
		self.highZones[loc.SCHOLOMANCE] = 60
		self.lowZones[loc.BLACKWING_LAIR] = 60
		self.highZones[loc.BLACKWING_LAIR] = 62
		self.lowZones[loc.ZUL_GURUB] = 60
		self.highZones[loc.ZUL_GURUB] = 62
		self.lowZones[loc.RUINS_OF_AHN_QIRAJ] = 60
		self.highZones[loc.RUINS_OF_AHN_QIRAJ] = 65
		self.lowZones[loc.TEMPLE_OF_AHN_QIRAJ] = 60
		self.highZones[loc.TEMPLE_OF_AHN_QIRAJ] = 65
		self.lowZones[loc.NAXXRAMAS] = 60
		self.highZones[loc.NAXXRAMAS] = 70
	end
	
	self.zoneInstances[loc.STORMWIND_CITY] = loc.STOCKADE
	self.zoneInstances[loc.ELWYNN_FOREST] = self.zoneInstances[loc.ELWYNN_FOREST]
	self.zoneInstances[loc.ORGRIMMAR] = loc.RAGEFIRE_CHASM
	self.zoneInstances[loc.DUROTAR] = self.zoneInstances[loc.ORGRIMMAR]
	self.zoneInstances[loc.DUN_MOROGH] = loc.GNOMEREGAN
	self.zoneInstances[loc.IRONFORGE] = self.zoneInstances[loc.DUN_MOROGH]
	self.zoneInstances[loc.TIRISFAL_GLADES] = loc.SCARLET_MONASTERY
	self.zoneInstances[loc.UNDERCITY] = self.zoneInstances[loc.TIRISFAL_GLADES]
	self.zoneInstances[loc.WESTFALL] = loc.DEADMINES
	self.zoneInstances[loc.SILVERPINE_FOREST] = loc.SHADOWFANG_KEEP
	self.zoneInstances[loc.ALTERAC_MOUNTAINS] = loc.ALTERAC_VALLEY
	self.zoneInstances[loc.ARATHI_HIGHLANDS] = loc.ARATHI_BASIN
	self.zoneInstances[loc.STRANGLETHORN_VALE] = loc.ZUL_GURUB
	self.zoneInstances[loc.SWAMP_OF_SORROWS] = loc.TEMPLE_OF_ATAL_HAKKAR
	self.zoneInstances[loc.SEARING_GORGE] = {
		[loc.MOLTEN_CORE] = true,
		[loc.BLACKWING_LAIR] = true,
		[loc.BLACKROCK_SPIRE] = true,
		[loc.BLACKROCK_DEPTHS] = true,
	}
	self.zoneInstances[loc.BLACKROCK_MOUNTAIN] = self.zoneInstances[loc.SEARING_GORGE]
	self.zoneInstances[loc.BURNING_STEPPES] = self.zoneInstances[loc.SEARING_GORGE]
	self.zoneInstances[loc.EASTERN_PLAGUELANDS] = {
		[loc.STRATHOLME] = true,
		[loc.NAXXRAMAS] = true
	}
	self.zoneInstances[loc.WESTERN_PLAGUELANDS] = loc.SCHOLOMANCE
	self.zoneInstances[loc.BARRENS] = {
		[loc.WAILING_CAVERNS] = true,
		[loc.RAZORFEN_KRAUL] = true,
		[loc.RAZORFEN_DOWNS] = true
	}
	self.zoneInstances[loc.ASHENVALE] = loc.BLACKFATHOM_DEEPS
	if UnitFactionGroup("player") == "Horde" then
		self.zoneInstances[loc.BARRENS][loc.WARSONG_GULCH] = true
	else
		self.zoneInstances[loc.ASHENVALE] = {
			[loc.BLACKFATHOM_DEEPS] = true,
			[loc.WARSONG_GULCH] = true
		}
	end
	self.zoneInstances[loc.DESOLACE] = loc.MARAUDON
	self.zoneInstances[loc.DUSTWALLOW_MARSH] = loc.ONYXIAS_LAIR
	self.zoneInstances[loc.FERALAS] = loc.DIRE_MAUL
	self.zoneInstances[loc.SILITHUS] = {
		[loc.RUINS_OF_AHN_QIRAJ] = true,
		[loc.TEMPLE_OF_AHN_QIRAJ] = true
	}
	self.zoneInstances[loc.TANARIS] = loc.ZUL_FARRAK
	self.zoneInstances[loc.BADLANDS] = loc.ULDAMAN
	
	for _,instances in pairs(self.zoneInstances) do
		if type(instances) == "table" then
			for instance in pairs(instances) do
				self.instances[instance] = true
			end
		else
			self.instances[instances] = true
		end
	end
	
	events.PLAYER_LEVEL_UP(self)
	
	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

local function external(self, major, instance)
	if major == "AceConsole-2.0" then
		local print = print
		if DEFAULT_CHAT_FRAME then
			function print(text)
				DEFAULT_CHAT_FRAME:AddMessage(text)
			end
		end
		instance.RegisterChatCommand(self, { "/tourist", "/touristLib" }, {
			name = MAJOR_VERSION .. "." .. string.gsub(MINOR_VERSION, ".-(%d+).*", "%1"),
			desc = "A library to provide information about zones and instances.",
			type = "group",
			args = {
				zone = {
					name = "Zone",
					desc = "Get information about a zone",
					type = "text",
					usage = "<zone name>",
					get = false,
					set = function(text)
						local type
						if self:IsBattleground(text) then
							type = "Battleground"
						elseif self:IsInstance(text) then
							type = "Instance"
						else
							type = "Zone"
						end
						local faction
						if self:IsAlliance(text) then
							faction = "Alliance"
						elseif self:IsHorde(text) then
							faction = "Horde"
						else
							faction = "Contested"
						end
						if self:IsHostile(text) then
							faction = faction .. " (hostile)"
						elseif self:IsFriendly(text) then
							faction = faction .. " (friendly)"
						end
						local low, high = self:GetLevel(text)
						print("|cffffff7f" .. text .. "|r")
						print("  |cffffff7fType: [|r" .. type .. "|cffffff7f]|r")
						print("  |cffffff7fFaction: [|r" .. faction .. "|cffffff7f]|r")
						if low ~= -6 and high ~= -6 then
							print("  |cffffff7fLevels: [|r" .. low .. "-" .. high .. "|cffffff7f]|r")
						end
						if self:DoesZoneHaveInstances(text) then
							print("  |cffffff7fInstances:|r")
							for instance in self:IterateZoneInstances(text) do
								local isBG = self:IsBattleground(instance) and " (BG)" or ""
								local low, high = self:GetLevel(instance)
								local faction = ""
								if self:IsAlliance(instance) then
									faction = " - Alliance"
								elseif self:IsHorde(instance) then
									faction = " - Horde"
								end
								if self:IsHostile(instance) then
									faction = faction .. " (hostile)"
								elseif self:IsFriendly(instance) then
									faction = faction .. " (friendly)"
								end
								print("    " .. instance .. isBG .. " - " .. low .. "-" .. high .. faction)
							end
						end
					end,
					validate = function(text)
						return self:IsZoneOrInstance(text)
					end
				},
				recommend = {
					name = "Recommended Zones",
					desc = "List recommended zones",
					type = "execute",
					func = function()
						print("|cffffff7fRecomended zones:|r")
						for zone in self:IterateRecommendedZones() do
							local low, high = self:GetLevel(zone)
							local faction = ""
							if self:IsAlliance(zone) then
								faction = " - Alliance"
							elseif self:IsHorde(zone) then
								faction = " - Horde"
							end
							if self:IsHostile(zone) then
								faction = faction .. " (hostile)"
							elseif self:IsFriendly(zone) then
								faction = faction .. " (friendly)"
							end
							print("  |cffffff7f" .. zone .. "|r - " .. low .. "-" .. high .. faction)
						end
						if self:HasRecommendedInstances() then
							print("|cffffff7fRecomended instances:|r")
							for instance in self:IterateRecommendedInstances() do
								local isBG = self:IsBattleground(instance) and " (BG)" or ""
								local low, high = self:GetLevel(instance)
								local faction = ""
								if self:IsAlliance(instance) then
									faction = " - Alliance"
								elseif self:IsHorde(instance) then
									faction = " - Horde"
								end
								if self:IsHostile(instance) then
									faction = faction .. " (hostile)"
								elseif self:IsFriendly(instance) then
									faction = faction .. " (friendly)"
								end
								print("  |cffffff7f" .. instance .. "|r" .. isBG .. " - " .. low .. "-" .. high .. faction)
							end
						end
					end
				}
			}
		}, "TOURIST")
	end
end

AceLibrary:Register(Tourist, MAJOR_VERSION, MINOR_VERSION, activate, nil, external)
Tourist = nil

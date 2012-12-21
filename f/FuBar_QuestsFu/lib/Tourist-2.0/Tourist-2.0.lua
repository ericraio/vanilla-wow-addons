--[[
Name: Tourist-2.0
Revision: $Rev: 10004 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Tourist-2.0
SVN: http://svn.wowace.com/root/trunk/TouristLib/Tourist-2.0
Description: A library to provide information about zones and instances.
Dependencies: AceLibrary, Babble-Zone-2.0, AceConsole-2.0 (optional)
]]

local MAJOR_VERSION = "Tourist-2.0"
local MINOR_VERSION = "$Revision: 10004 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("Babble-Zone-2.0") then error(MAJOR_VERSION .. " requires Babble-Zone-2.0") end

local Tourist = {}
local events = {}

local Z = AceLibrary("Babble-Zone-2.0")

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
		if zone == Z["Alterac Valley"] then
			return 51, 60
		elseif playerLevel == 60 then
			return 60, 60
		elseif playerLevel >= 50 then
			return 50, 59
		elseif playerLevel >= 40 then
			return 40, 49
		elseif playerLevel >= 30 then
			return 30, 39
		elseif playerLevel >= 20 or zone == Z["Arathi Basin"] then
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
		if (playerLevel < 51 and zone == Z["Alterac Valley"]) or (playerLevel < 20 and zone == Z["Arathi Basin"]) or (playerLevel < 10 and zone == Z["Warsong Gulch"]) then
			return 1, 0, 0
		end
		local playerLevel = playerLevel
		if zone == Z["Alterac Valley"] then
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
	return zone == Z["Warsong Gulch"] or zone == Z["Arathi Basin"] or zone == Z["Alterac Valley"]
end

function Tourist:IsAlliance(zone)
	self:argCheck(zone, 2, "string")
	return zone == Z["Ironforge"] or zone == Z["Stormwind City"] or zone == Z["Dun Morogh"] or zone == Z["Elwynn Forest"] or zone == Z["Loch Modan"] or zone == Z["Westfall"] or zone == Z["Darnassus"] or zone == Z["Teldrassil"] or zone == Z["Darkshore"] or zone == Z["The Stockade"] or zone == Z["Gnomeregan"] or zone == Z["The Deadmines"]
end

function Tourist:IsHorde(zone)
	self:argCheck(zone, 2, "string")
	return zone == Z["Undercity"] or zone == Z["Orgrimmar"] or zone == Z["Thunder Bluff"] or zone == Z["Tirisfal Glades"] or zone == Z["Silverpine Forest"] or zone == Z["Durotar"] or zone == Z["Mulgore"] or zone == Z["The Barrens"] or zone == Z["Ragefire Chasm"] or zone == Z["Shadowfang Keep"] or zone == Z["Wailing Caverns"]
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
	self.lowZones[Z["Booty Bay"]] = -6
	self.highZones[Z["Booty Bay"]] = -6
	self.lowZones[Z["Deeprun Tram"]] = -6
	self.highZones[Z["Deeprun Tram"]] = -6
	self.lowZones[Z["Ironforge"]] = -6
	self.highZones[Z["Ironforge"]] = -6
	self.lowZones[Z["Stormwind City"]] = -6
	self.highZones[Z["Stormwind City"]] = -6
	self.lowZones[Z["Elwynn Forest"]] = 1
	self.highZones[Z["Elwynn Forest"]] = 10
	self.lowZones[Z["Dun Morogh"]] = 1
	self.highZones[Z["Dun Morogh"]] = 10
	self.lowZones[Z["Tirisfal Glades"]] = 1
	self.highZones[Z["Tirisfal Glades"]] = 10
	self.lowZones[Z["Loch Modan"]] = 10
	self.highZones[Z["Loch Modan"]] = 20
	self.lowZones[Z["Silverpine Forest"]] = 10
	self.highZones[Z["Silverpine Forest"]] = 20
	self.lowZones[Z["Westfall"]] = 10
	self.highZones[Z["Westfall"]] = 20
	self.lowZones[Z["Redridge Mountains"]] = 15
	self.highZones[Z["Redridge Mountains"]] = 25
	self.lowZones[Z["Duskwood"]] = 18
	self.highZones[Z["Duskwood"]] = 30
	self.lowZones[Z["Hillsbrad Foothills"]] = 20
	self.highZones[Z["Hillsbrad Foothills"]] = 30
	self.lowZones[Z["Wetlands"]] = 20
	self.highZones[Z["Wetlands"]] = 30
	self.lowZones[Z["Alterac Mountains"]] = 30
	self.highZones[Z["Alterac Mountains"]] = 40
	self.lowZones[Z["Arathi Highlands"]] = 30
	self.highZones[Z["Arathi Highlands"]] = 40
	self.lowZones[Z["Stranglethorn Vale"]] = 30
	self.highZones[Z["Stranglethorn Vale"]] = 45
	self.lowZones[Z["Badlands"]] = 35
	self.highZones[Z["Badlands"]] = 45
	self.lowZones[Z["Swamp of Sorrows"]] = 35
	self.highZones[Z["Swamp of Sorrows"]] = 45
	self.lowZones[Z["Deadwind Pass"]] = 37
	self.highZones[Z["Deadwind Pass"]] = 60
	self.lowZones[Z["The Hinterlands"]] = 40
	self.highZones[Z["The Hinterlands"]] = 50
	self.lowZones[Z["Searing Gorge"]] = 43
	self.highZones[Z["Searing Gorge"]] = 50
	self.lowZones[Z["Blasted Lands"]] = 45
	self.highZones[Z["Blasted Lands"]] = 55
	self.lowZones[Z["Burning Steppes"]] = 50
	self.highZones[Z["Burning Steppes"]] = 58
	self.lowZones[Z["Western Plaguelands"]] = 51
	self.highZones[Z["Western Plaguelands"]] = 58
	self.lowZones[Z["Eastern Plaguelands"]] = 53
	self.highZones[Z["Eastern Plaguelands"]] = 60

	-- Kalimdor
	self.lowZones[Z["Ratchet"]] = -6
	self.highZones[Z["Ratchet"]] = -6
	self.lowZones[Z["Gadgetzan"]] = -6
	self.highZones[Z["Gadgetzan"]] = -6
	self.lowZones[Z["Orgrimmar"]] = -6
	self.highZones[Z["Orgrimmar"]] = -6
	self.lowZones[Z["Thunder Bluff"]] = -6
	self.highZones[Z["Thunder Bluff"]] = -6
	self.lowZones[Z["Undercity"]] = -6
	self.highZones[Z["Undercity"]] = -6
	self.lowZones[Z["Durotar"]] = 1
	self.highZones[Z["Durotar"]] = 10
	self.lowZones[Z["Mulgore"]] = 1
	self.highZones[Z["Mulgore"]] = 10
	self.lowZones[Z["Darkshore"]] = 10
	self.highZones[Z["Darkshore"]] = 20
	self.lowZones[Z["The Barrens"]] = 10
	self.highZones[Z["The Barrens"]] = 25
	self.lowZones[Z["Stonetalon Mountains"]] = 15
	self.highZones[Z["Stonetalon Mountains"]] = 27
	self.lowZones[Z["Ashenvale"]] = 18
	self.highZones[Z["Ashenvale"]] = 30
	self.lowZones[Z["Thousand Needles"]] = 25
	self.highZones[Z["Thousand Needles"]] = 35
	self.lowZones[Z["Desolace"]] = 30
	self.highZones[Z["Desolace"]] = 40
	self.lowZones[Z["Dustwallow Marsh"]] = 35
	self.highZones[Z["Dustwallow Marsh"]] = 45
	self.lowZones[Z["Feralas"]] = 40
	self.highZones[Z["Feralas"]] = 50
	self.lowZones[Z["Tanaris"]] = 40
	self.highZones[Z["Tanaris"]] = 50
	self.lowZones[Z["Azshara"]] = 45
	self.highZones[Z["Azshara"]] = 55
	self.lowZones[Z["Felwood"]] = 48
	self.highZones[Z["Felwood"]] = 55
	self.lowZones[Z["Un'Goro Crater"]] = 48
	self.highZones[Z["Un'Goro Crater"]] = 55
	self.lowZones[Z["Silithus"]] = 55
	self.highZones[Z["Silithus"]] = 60
	self.lowZones[Z["Winterspring"]] = 55
	self.highZones[Z["Winterspring"]] = 60
	self.lowZones[Z["Hyjal"]] = 60
	self.highZones[Z["Hyjal"]] = 60
	self.lowZones[Z["Moonglade"]] = -6
	self.highZones[Z["Moonglade"]] = -6
	self.lowZones[Z["Darnassus"]] = -6
	self.highZones[Z["Darnassus"]] = -6
	self.lowZones[Z["Teldrassil"]] = 1
	self.highZones[Z["Teldrassil"]] = 10

	-- Battlegrounds (Tiered)
	self.lowZones[Z["Alterac Valley"]] = -6
	self.highZones[Z["Alterac Valley"]] = -6
	self.lowZones[Z["Warsong Gulch"]] = -6
	self.highZones[Z["Warsong Gulch"]] = -6
	self.lowZones[Z["Arathi Basin"]] = -6
	self.highZones[Z["Arathi Basin"]] = -6

	-- Instances
	if GetLocale() == "enUS" then
		self.lowZones[Z["The Stockade"]] = 24
		self.highZones[Z["The Stockade"]] = 32
		self.lowZones[Z["Ragefire Chasm"]] = 13
		self.highZones[Z["Ragefire Chasm"]] = 18
		self.lowZones[Z["Zul'Farrak"]] = 44
		self.highZones[Z["Zul'Farrak"]] = 54
		self.lowZones[Z["The Deadmines"]] = 17
		self.highZones[Z["The Deadmines"]] = 26
		self.lowZones[Z["Wailing Caverns"]] = 17
		self.highZones[Z["Wailing Caverns"]] = 24
		self.lowZones[Z["Gnomeregan"]] = 29
		self.highZones[Z["Gnomeregan"]] = 38
		self.lowZones[Z["Razorfen Kraul"]] = 29
		self.highZones[Z["Razorfen Kraul"]] = 38
		self.lowZones[Z["Blackfathom Deeps"]] = 24
		self.highZones[Z["Blackfathom Deeps"]] = 32
		self.lowZones[Z["Shadowfang Keep"]] = 22
		self.highZones[Z["Shadowfang Keep"]] = 30
		self.lowZones[Z["Scarlet Monastery"]] = 34
		self.highZones[Z["Scarlet Monastery"]] = 45
		self.lowZones[Z["Uldaman"]] = 41
		self.highZones[Z["Uldaman"]] = 51
		self.lowZones[Z["Razorfen Downs"]] = 37
		self.highZones[Z["Razorfen Downs"]] = 46
		self.lowZones[Z["Maraudon"]] = 46
		self.highZones[Z["Maraudon"]] = 55
		self.lowZones[Z["Onyxia's Lair"]] = 60
		self.highZones[Z["Onyxia's Lair"]] = 62
		self.lowZones[Z["Blackrock Mountain"]] = 42
		self.highZones[Z["Blackrock Mountain"]] = 54
		self.lowZones[Z["Caverns of Time"]] = 43
		self.highZones[Z["Caverns of Time"]] = 61
		self.lowZones[Z["The Temple of Atal'Hakkar"]] = 50
		self.highZones[Z["The Temple of Atal'Hakkar"]] = 60
		self.lowZones[Z["Dire Maul"]] = 56
		self.highZones[Z["Dire Maul"]] = 60
		self.lowZones[Z["Blackrock Depths"]] = 52
		self.highZones[Z["Blackrock Depths"]] = 60
		self.lowZones[Z["Blackrock Spire"]] = 55
		self.highZones[Z["Blackrock Spire"]] = 60
		self.lowZones[Z["Stratholme"]] = 58
		self.highZones[Z["Stratholme"]] = 60
		self.lowZones[Z["Molten Core"]] = 60
		self.highZones[Z["Molten Core"]] = 62
		self.lowZones[Z["Scholomance"]] = 58
		self.highZones[Z["Scholomance"]] = 60
		self.lowZones[Z["Blackwing Lair"]] = 60
		self.highZones[Z["Blackwing Lair"]] = 62
		self.lowZones[Z["Zul'Gurub"]] = 60
		self.highZones[Z["Zul'Gurub"]] = 62
		self.lowZones[Z["Ruins of Ahn'Qiraj"]] = 60
		self.highZones[Z["Ruins of Ahn'Qiraj"]] = 65
		self.lowZones[Z["Temple of Ahn'Qiraj"]] = 60
		self.highZones[Z["Temple of Ahn'Qiraj"]] = 65
		self.lowZones[Z["Naxxramas"]] = 60
		self.highZones[Z["Naxxramas"]] = 70
	else
		self.lowZones[Z["The Stockade"]] = 23
		self.highZones[Z["The Stockade"]] = 26
		self.lowZones[Z["Ragefire Chasm"]] = 13
		self.highZones[Z["Ragefire Chasm"]] = 15
		self.lowZones[Z["Zul'Farrak"]] = 43
		self.highZones[Z["Zul'Farrak"]] = 47
		self.lowZones[Z["The Deadmines"]] = 15
		self.highZones[Z["The Deadmines"]] = 20
		self.lowZones[Z["Wailing Caverns"]] = 15
		self.highZones[Z["Wailing Caverns"]] = 21
		self.lowZones[Z["Gnomeregan"]] = 24
		self.highZones[Z["Gnomeregan"]] = 33
		self.lowZones[Z["Razorfen Kraul"]] = 25
		self.highZones[Z["Razorfen Kraul"]] = 35
		self.lowZones[Z["Blackfathom Deeps"]] = 20
		self.highZones[Z["Blackfathom Deeps"]] = 27
		self.lowZones[Z["Shadowfang Keep"]] = 18
		self.highZones[Z["Shadowfang Keep"]] = 25
		self.lowZones[Z["Scarlet Monastery"]] = 30
		self.highZones[Z["Scarlet Monastery"]] = 40
		self.lowZones[Z["Uldaman"]] = 35
		self.highZones[Z["Uldaman"]] = 45
		self.lowZones[Z["Razorfen Downs"]] = 35
		self.highZones[Z["Razorfen Downs"]] = 40
		self.lowZones[Z["Maraudon"]] = 40
		self.highZones[Z["Maraudon"]] = 49
		self.lowZones[Z["Onyxia's Lair"]] = 60
		self.highZones[Z["Onyxia's Lair"]] = 62
		self.lowZones[Z["Blackrock Mountain"]] = 42
		self.highZones[Z["Blackrock Mountain"]] = 54
		self.lowZones[Z["Caverns of Time"]] = -6
		self.highZones[Z["Caverns of Time"]] = -6
		self.lowZones[Z["The Temple of Atal'Hakkar"]] = 44
		self.highZones[Z["The Temple of Atal'Hakkar"]] = 50
		self.lowZones[Z["Dire Maul"]] = 56
		self.highZones[Z["Dire Maul"]] = 60
		self.lowZones[Z["Blackrock Depths"]] = 48
		self.highZones[Z["Blackrock Depths"]] = 56
		self.lowZones[Z["Blackrock Spire"]] = 53
		self.highZones[Z["Blackrock Spire"]] = 60
		self.lowZones[Z["Stratholme"]] = 55
		self.highZones[Z["Stratholme"]] = 60
		self.lowZones[Z["Molten Core"]] = 60
		self.highZones[Z["Molten Core"]] = 62
		self.lowZones[Z["Scholomance"]] = 56
		self.highZones[Z["Scholomance"]] = 60
		self.lowZones[Z["Blackwing Lair"]] = 60
		self.highZones[Z["Blackwing Lair"]] = 62
		self.lowZones[Z["Zul'Gurub"]] = 60
		self.highZones[Z["Zul'Gurub"]] = 62
		self.lowZones[Z["Ruins of Ahn'Qiraj"]] = 60
		self.highZones[Z["Ruins of Ahn'Qiraj"]] = 65
		self.lowZones[Z["Temple of Ahn'Qiraj"]] = 60
		self.highZones[Z["Temple of Ahn'Qiraj"]] = 65
		self.lowZones[Z["Naxxramas"]] = 60
		self.highZones[Z["Naxxramas"]] = 70
	end
	
	self.zoneInstances[Z["Stormwind City"]] = Z["The Stockade"]
	self.zoneInstances[Z["Elwynn Forest"]] = self.zoneInstances[Z["Stormwind City"]]
	self.zoneInstances[Z["Orgrimmar"]] = Z["Ragefire Chasm"]
	self.zoneInstances[Z["Durotar"]] = self.zoneInstances[Z["Orgrimmar"]]
	self.zoneInstances[Z["Dun Morogh"]] = Z["Gnomeregan"]
	self.zoneInstances[Z["Ironforge"]] = self.zoneInstances[Z["Dun Morogh"]]
	self.zoneInstances[Z["Tirisfal Glades"]] = Z["Scarlet Monastery"]
	self.zoneInstances[Z["Undercity"]] = self.zoneInstances[Z["Tirisfal Glades"]]
	self.zoneInstances[Z["Westfall"]] = Z["The Deadmines"]
	self.zoneInstances[Z["Silverpine Forest"]] = Z["Shadowfang Keep"]
	self.zoneInstances[Z["Alterac Mountains"]] = Z["Alterac Valley"]
	self.zoneInstances[Z["Arathi Highlands"]] = Z["Arathi Basin"]
	self.zoneInstances[Z["Stranglethorn Vale"]] = Z["Zul'Gurub"]
	self.zoneInstances[Z["Swamp of Sorrows"]] = Z["The Temple of Atal'Hakkar"]
	self.zoneInstances[Z["Searing Gorge"]] = {
		[Z["Molten Core"]] = true,
		[Z["Blackwing Lair"]] = true,
		[Z["Blackrock Spire"]] = true,
		[Z["Blackrock Depths"]] = true,
	}
	self.zoneInstances[Z["Blackrock Mountain"]] = self.zoneInstances[Z["Searing Gorge"]]
	self.zoneInstances[Z["Burning Steppes"]] = self.zoneInstances[Z["Searing Gorge"]]
	self.zoneInstances[Z["Eastern Plaguelands"]] = {
		[Z["Stratholme"]] = true,
		[Z["Naxxramas"]] = true
	}
	self.zoneInstances[Z["Western Plaguelands"]] = Z["Scholomance"]
	self.zoneInstances[Z["The Barrens"]] = {
		[Z["Wailing Caverns"]] = true,
		[Z["Razorfen Kraul"]] = true,
		[Z["Razorfen Downs"]] = true
	}
	self.zoneInstances[Z["Ashenvale"]] = Z["Blackfathom Deeps"]
	if UnitFactionGroup("player") == "Horde" then
		self.zoneInstances[Z["The Barrens"]][Z["Warsong Gulch"]] = true
	else
		self.zoneInstances[Z["Ashenvale"]] = {
			[Z["Blackfathom Deeps"]] = true,
			[Z["Warsong Gulch"]] = true
		}
	end
	self.zoneInstances[Z["Desolace"]] = Z["Maraudon"]
	self.zoneInstances[Z["Dustwallow Marsh"]] = Z["Onyxia's Lair"]
	self.zoneInstances[Z["Feralas"]] = Z["Dire Maul"]
	self.zoneInstances[Z["Silithus"]] = {
		[Z["Ruins of Ahn'Qiraj"]] = true,
		[Z["Temple of Ahn'Qiraj"]] = true
	}
	self.zoneInstances[Z["Tanaris"]] = Z["Zul'Farrak"]
	self.zoneInstances[Z["Badlands"]] = Z["Uldaman"]
	
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

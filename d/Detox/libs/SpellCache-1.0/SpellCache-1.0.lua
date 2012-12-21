--[[
Name: SpellCache-1.0
Revision: $Rev: 11059 $
Author(s): Nightdew (denzsolnightdew@gmail.com)
Website: http://www.wowace.com/index.php/SpellCache-1.0
Documentation: http://www.wowace.com/index.php/SpellCache-1.0
SVN: http://svn.wowace.com/root/trunk/SpellCache/SpellCache-1.0
Description: Library that caches spells to speed up look ups
Dependencies: AceLibrary, AceDebug-2.0, AceEvent-2.0, Deformat-2.0
]]

--, Gratuity-2.0

local MAJOR_VERSION = "SpellCache-1.0"
local MINOR_VERSION = "$Revision: 11059 $"

if (not AceLibrary) then 
	error(MAJOR_VERSION .. " requires AceLibrary.") 
elseif (not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION)) then 
	return 
end

local function CheckDependencies(dependencies)
	for index, value in ipairs(dependencies) do
		if (not AceLibrary:HasInstance(value)) then 
			error(format("%s requires %s to function properly", MAJOR_VERSION, value))
		end
	end
end

local dependencyLibraries = {
	"AceDebug-2.0", 
	"AceEvent-2.0", 
	"Deformat-2.0",
	--"Gratuity-2.0"
}

CheckDependencies(dependencyLibraries)

local aceDebug = AceLibrary("AceDebug-2.0")
local aceEvent = AceLibrary("AceEvent-2.0")
local deformat = AceLibrary("Deformat-2.0")

--Create Library Object
local SpellCache = {}

--Embed all needed mixins into the Library Object SpellCache
aceDebug:embed(SpellCache)
aceEvent:embed(SpellCache)

--
-- Initialization methods.
--

local function GetSpellRankPattern(self, spellRank)
	local rankPattern, changeCount = string.gsub(spellRank, "%d+", "%%d")
	if (changeCount > 0) then
		self.RankPattern = rankPattern;
		self.FullPattern = format("%s(%s)", "%s", rankPattern)
		self:LevelDebug(2, "DetectRankPattern", spellRank, self.RankPattern, self.FullPattern)
		return rankPattern
	end
end

local function GetSpellRankNumber(self, spellRank)
	self:LevelDebug(3, "GetSpellRankNumber1", spellRank)
	if (spellRank and (spellRank ~= "")) then
		local rankPattern = self.RankPattern or GetSpellRankPattern(self, spellRank)
		if (rankPattern) then
			self:LevelDebug(3, "GetSpellRankNumber2", rankPattern, spellRank)
			local spellRankNumber = self:GetRankNumber(spellRank)
			return spellRankNumber
		end
	end
end

local function ResetVariables(self)
	if (not self:IsInitialized()) then
		return
	end

	--clear hash
	setmetatable(self.hash, nil) 
	for k in pairs(self.hash) do 
		self.hash[k] = nil
	end
	table.setn(self.hash, 0);

    local spellTabCount = GetNumSpellTabs()
    local tabName, tabTexture, tabStart, tabOffset = GetSpellTabInfo(spellTabCount)
    local spellCount = tabStart + tabOffset

	self:LevelDebug(3, "ResetVariables", spellTabCount, tabName, tabTexture, tabStart, tabOffset, spellCount)
    
    local spellData, spellName, spellRank, spellNamePrevious, spellNameNew = nil;
    for i = 1, spellCount do
        spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)

		spellNameNew = spellNamePrevious ~= spellName
		spellNamePrevious = spellName
	
		spellData = self.data[spellName] or {}

		if (spellNameNew) then
			self.hash[i] = spellName
			self.data[spellName] = spellData
			spellData.IdStart = i
		else
			self.hash[i] = spellData.IdStart
		end

		spellData.IdStop = i
		
		spellData.Rank = GetSpellRankNumber(self, spellRank);
		
		self:LevelDebug(3, 
			spellData.IdStart,
			spellData.IdStop,
			spellData.Rank 
		)
    end
   	self:TriggerEvent("SpellCache_Updated")
end

local function InitializeVariables(self)
	--will collect spells as they are being cast.
	--SpellName -> Data
	self.data = {}
	--SpellId -> SpellName or SpellId
	self.hash = {}
	
	ResetVariables(self)
end

--
-- Event Registration
--

local function InitializeEventRegisters(self)
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "LEARNED_SPELL_IN_TAB")
	--Supposedly not needed, and will spam too much
	--self:RegisterEvent("SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")
end

--update whatever spells are there!
function SpellCache:LEARNED_SPELL_IN_TAB()
	self.isInitialized = true
	ResetVariables(self)
end

function SpellCache:IsInitialized()
	return self.isInitialized == true
end

--
-- Activate method
--

local function activate(self, oldLib, oldDeactivate)
	--self:SetDebugLevel(3);
	if (oldLib) then
		oldLib:UnregisterAllEvents()
	end

	--Default code to clean up the oldlib
	if (oldDeactivate) then
		oldDeactivate(oldLib)
	end

	InitializeVariables(self)
	InitializeEventRegisters(self)	
end

--
-- Util Methods
--

--
-- External Methods
--

function SpellCache:GetRankNumber(spellRankText)
	self:LevelDebug(3, "SpellCache:GetRankNumber1", spellRankText)
	self:argCheck(spellRankText, 2, "string")
	local spellRankNumber = deformat:Deformat(spellRankText, self.RankPattern)
	self:LevelDebug(3, "SpellCache:GetRankNumber2", spellRankText, self.RankPattern, spellRankNumber)
	return spellRankNumber
end

function SpellCache:GetRankText(spellRankNumber)
	self:argCheck(spellRankNumber, 2, "number")
	local spellRankText = format(self.RankPattern, spellRankNumber)
	self:LevelDebug(2, "GetRankText", spellRankNumber, self.RankPattern, spellRankText)
	return spellRankText
end

function SpellCache:GetRanklessSpellName(spellName)
	self:argCheck(spellName, 2, "string")

	--self:LevelDebug(2, "GetRanklessSpellName1", spellName)
	--For those that like to cast spells with SpellName() lets take out the () 
	spellName = string.gsub(spellName, "%(%)$", "")
	--self:LevelDebug(2, "GetRanklessSpellName2", spellName)

	local sName, sRank = deformat:Deformat(spellName, self.FullPattern)
	self:LevelDebug(2, "GetRanklessSpellName", spellName, sName, sRank)
	if (sName and sRank) then
		return sName, sRank
	end
	return spellName
end

function SpellCache:GetSpellNameText(spellName, spellRankNumber)
	self:argCheck(spellName, 2, "string")
	self:argCheck(spellRankNumber, 3, "number", "nil")

	local fullSpellName
	if (not spellRankNumber) then
		fullSpellName = spellName
	else
		fullSpellName = format(self.FullPattern, spellName, spellRankNumber)
	end
	self:LevelDebug(2, "GetSpellNameText", spellName, spellRankNumber, self.FullPattern, fullSpellName)
	return fullSpellName
end

-- 24, ignore all
-- Arcane Intellect, nil
-- Arcane Intellect, 3
-- Arcane Intellect, Rank 3
-- Arcane Intellect(Rank 2), nil
-- Arcane Intellect(Rank 2), 3
-- Arcane Intellect(Rank 2), Rank 3
function SpellCache:GetSpellData(spellNameOrId, spellRankNumberOrText)
	self:argCheck(spellNameOrId, 2, "string", "number")
	self:argCheck(spellRank, 3, "string", "number", "nil")
	self:LevelDebug(2, ">GetSpellData", spellNameOrId, spellRankNumberOrText)

	local sId, sName, sRank
	if (type(spellNameOrId) == "number") then
		sId = tonumber(spellNameOrId)
		sName = self.hash[sId]
		--Doesnt exist
		if (not sName) then
			return
		end
		--sId > IdStart 
		if (type(sName) == "number") then
			sName = self.hash[sName]
		end
		self:LevelDebug(2, "GetSpellData1", sId, sName)
	else
		sName, sRank = self:GetRanklessSpellName(spellNameOrId)

		if (not sRank) then
			sRank = spellRankNumberOrText;
			if (type(sRank) == "string") then
				self:LevelDebug(2, "GetSpellData2", sRank)
				sRank = GetSpellRankNumber(self, sRank);
				self:LevelDebug(2, "GetSpellData3", sRank)
			end
		end
	end
	
	--if we cant find any data
	local spellData = self.data[sName]
	if (not spellData) then
		self:LevelDebug(1, "<GetSpellData", spellNameOrId)
		return;
	end;
		
	if (sId) then
		sRank = spellData.Rank and sId - spellData.IdStart + 1 or nil
	else
		if (not spellData.Rank) then
			sRank = nil
		elseif (not sRank) then
			sRank = spellData.Rank
		elseif ((sRank) and (sRank > spellData.Rank)) then
			sRank = spellData.Rank
		elseif ((sRank) and (sRank < 1)) then
			sRank = 1
		end
		sId = sRank and spellData.IdStart + sRank -1 or spellData.IdStart
	end

	local sRankText, sFullText
	if (sRank) then
		sRankText = self:GetRankText(sRank)
	end
	sFullText = self:GetSpellNameText(sName, sRank)
		
	self:LevelDebug(1, "<GetSpellData", sName, sRankText, sId, sFullText, sRank, spellData.IdStart, spellData.IdStop, spellData.Rank)
	return sName, sRankText, sId, sFullText, sRank, spellData.IdStart, spellData.IdStop, spellData.Rank
end

--
-- Final Registration of the library.
--
AceLibrary:Register(SpellCache, MAJOR_VERSION, MINOR_VERSION, activate)
SpellCache = AceLibrary(MAJOR_VERSION)

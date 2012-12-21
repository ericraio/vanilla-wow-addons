local MAJOR_VERSION = "SpellTree 1.1"
local MINOR_VERSION = tonumber(string.sub("$Revision: 1536 $", 12, -3))

if BabbleLib and BabbleLib.versions[MAJOR_VERSION] and BabbleLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

local locale = GetLocale and GetLocale() or "enUS"
if locale ~= "frFR" and locale ~= "deDE" then
	locale = "enUS"
end

local initTrees, trees
if locale == "enUS" then
	function initTrees()
		trees = {
			-- Druid
			BALANCE = "Balance",
			FERAL_COMBAT = "Feral Combat",
			RESTORATION = "Restoration",
			-- Hunter
			BEAST_MASTERY = "Beast Mastery",
			MARKSMANSHIP = "Marksmanship",
			SURVIVAL = "Survival",
			-- Mage
			ARCANE = "Arcane",
			FIRE = "Fire",
			FROST = "Frost",
			-- Paladin
			HOLY = "Holy",
			PROTECTION = "Protection",
			RETRIBUTION = "Retribution",
			-- Priest
			DISCIPLINE = "Discipline",
			HOLY = "Holy", -- same as Paladin
			SHADOW = "Shadow",
			-- Rogue
			ASSASSINATION = "Assassination",
			COMBAT = "Combat",
			SUBTLETY = "Subtlety",
			-- Shaman
			ELEMENTAL = "Elemental",
			ENHANCEMENT = "Enhancement",
			RESTORATION = "Restoration", -- same as Druid
			-- Warrior
			ARMS = "Arms",
			FURY = "Fury",
			PROTECTION = "Protection", -- same as Paladin
			-- Warlock
			AFFLICTION = "Affliction",
			DEMONOLOGY = "Demonology",
			DESTRUCTION = "Destruction",
		}
	end
elseif locale == "deDE" then
	function initTrees()
		trees = {
			-- Druid
			BALANCE = "Gleichgewicht",
			FERAL_COMBAT = "Wilder Kampf",
			RESTORATION = "Wiederherstellung",
			-- Hunter
			BEAST_MASTERY = "Tierherrschaft",
			MARKSMANSHIP = "Treffsicherheit",
			SURVIVAL = "\195\156berleben",
			-- Mage
			ARCANE = "Arcan",
			FIRE = "Feuer",
			FROST = "Frost",
			-- Paladin
			HOLY = "Heilig",
			PROTECTION = "Schutz",
			RETRIBUTION = "Vergeltung",
			-- Priest
			DISCIPLINE = "Disziplin",
			HOLY = "Heilig", -- same as Paladin
			SHADOW = "Schatten",
			-- Rogue
			ASSASSINATION = "Meucheln",
			COMBAT = "Kampf",
			SUBTLETY = "T\195\164uschung",
			-- Shaman
			ELEMENTAL = "Elementar",
			ENHANCEMENT = "Verst\195\164rkung",
			RESTORATION = "Wiederherstellung", -- same as Druid
			-- Warrior
			ARMS = "Waffen",
			FURY = "Furor",
			PROTECTION = "Schutz", -- same as Paladin
			-- Warlock
			AFFLICTION = "Gebrechen",
			DEMONOLOGY = "D\195\164monologie",
			DESTRUCTION = "Zerst\195\182rung",
		}
	end
elseif locale == "frFR" then
	function initTrees()
		trees = {
			-- Druid
			BALANCE = "Equilibre",
			FERAL_COMBAT = "Combat sauvage",
			RESTORATION = "Restauration",
			-- Hunter
			BEAST_MASTERY = "Ma\195\174trise des b\195\170tes",
			MARKSMANSHIP = "Pr\195\169cision",
			SURVIVAL = "Survie",
			-- Mage
			ARCANE = "Arcanes",
			FIRE = "Feu",
			FROST = "Givre",
			-- Paladin
			HOLY = "Sacr\195\169",
			PROTECTION = "Protection",
			RETRIBUTION = "Vindicte",
			-- Priest
			DISCIPLINE = "Discipline",
			HOLY = "Sacr\195\169", -- same as Paladin
			SHADOW = "Ombre",
			-- Rogue
			ASSASSINATION = "Assassinat",
			COMBAT = "Combat",
			SUBTLETY = "Finesse",
			-- Shaman
			ELEMENTAL = "\195\137l\195\169mentaire",
			ENHANCEMENT = "Am\195\169lioration",
			RESTORATION = "Restauration", -- same as Druid
			-- Warrior
			ARMS = "Armes",
			FURY = "Fureur",
			PROTECTION = "Protection", -- same as Paladin
			-- Warlock
			AFFLICTION = "Affliction",
			DEMONOLOGY = "D\195\169monologie",
			DESTRUCTION = "Destruction",
		}
	end
end

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
if (not BabbleLib) then
   BabbleLib = stub:NewStub();
end

-- Nil stub for garbage collection
stub = nil;
-----------END-IRIEL'S-STUB-CODE------------

local lib = {}
local localTrees

function lib:GetEnglish(tree)
	return localTrees[tree] or tree
end

function lib:GetLocalized(tree)
	return trees[tree] or tree
end

function lib:GetIterator()
	return pairs(trees)
end

function lib:GetReverseIterator()
	return pairs(localTrees)
end

function lib:HasSpellTree(tree)
	return (trees[tree] or localTrees[tree]) and true or false
end

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
	initTrees()
	initTrees = nil
	
	localTrees = {}
	for english, localized in pairs(trees) do
		if string.sub(english, -4) == "_ALT" then
			localTrees[localized] = string.sub(english, 0, -5)
		elseif string.sub(english, -5, -2) == "_ALT" then
			localTrees[localized] = string.sub(english, 0, -6)
		else
			localTrees[localized] = english
		end
	end
end

function lib:LibDeactivate()
	trees, localTrees, initTrees = nil
end

BabbleLib:Register(lib)
lib = nil

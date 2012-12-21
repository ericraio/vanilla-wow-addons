-- this is a compatibility package. it is recommended
-- to use the components individually.

local MAJOR_VERSION = "1.0"
local MINOR_VERSION = tonumber(string.sub("$Revision: 1536 $", 12, -3))

if BabbleLib and BabbleLib.versions[MAJOR_VERSION] and BabbleLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
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

local core, class, boss, zone, spell, tree

function lib.Deformat(text, a1, a2, a3, a4)
	if not core then
		core = BabbleLib:GetInstance("Core 1.1")
	end
	return core:Deformat(text, a1, a2, a3, a4)
end

function lib.GetEnglishClass(alpha)
	if not class then
		class = BabbleLib:GetInstance("Class 1.1")
	end
	return class:GetEnglish(alpha)
end

function lib.GetLocalizedClass(alpha)
	if not class then
		class = BabbleLib:GetInstance("Class 1.1")
	end
	return class:GetLocalized(alpha)
end

function lib.GetClassIterator()
	if not class then
		class = BabbleLib:GetInstance("Class 1.1")
	end
	return class:GetIterator()
end

function lib.GetReverseClassIterator()
	if not class then
		class = BabbleLib:GetInstance("Class 1.1")
	end
	return class:GetReverseIterator()
end

function lib.GetClassColor(alpha)
	if not class then
		class = BabbleLib:GetInstance("Class 1.1")
	end
	return class:GetColor(alpha)
end

function lib.GetClassHexColor(alpha)
	if not class then
		class = BabbleLib:GetInstance("Class 1.1")
	end
	return class:GetHexColor(alpha)
end

function lib.HasClass(alpha)
	if not class then
		class = BabbleLib:GetInstance("Class 1.1")
	end
	return class:HasClass(alpha)
end

function lib.GetEnglishBoss(alpha)
	if not boss then
		boss = BabbleLib:GetInstance("Boss 1.1")
	end
	return boss:GetEnglish(alpha)
end

function lib.GetLocalizedBoss(alpha)
	if not boss then
		boss = BabbleLib:GetInstance("Boss 1.1")
	end
	return boss:GetLocalized(alpha)
end

function lib.GetBossIterator()
	if not boss then
		boss = BabbleLib:GetInstance("Boss 1.1")
	end
	return boss:GetIterator()
end

function lib.GetReverseBossIterator()
	if not boss then
		boss = BabbleLib:GetInstance("Boss 1.1")
	end
	return boss:GetReverseIterator()
end

function lib.HasBoss(alpha)
	if not boss then
		boss = BabbleLib:GetInstance("Boss 1.1")
	end
	return boss:HasBoss(alpha)
end

function lib.GetEnglishZone(alpha)
	if not zone then
		zone = BabbleLib:GetInstance("Zone 1.1")
	end
	return zone:GetEnglish(alpha)
end

function lib.GetLocalizedZone(alpha)
	if not zone then
		zone = BabbleLib:GetInstance("Zone 1.1")
	end
	return zone:GetLocalized(alpha)
end

function lib.GetZoneIterator()
	if not zone then
		zone = BabbleLib:GetInstance("Zone 1.1")
	end
	return zone:GetIterator()
end

function lib.GetReverseZoneIterator()
	if not zone then
		zone = BabbleLib:GetInstance("Zone 1.1")
	end
	return zone:GetReverseIterator()
end

function lib.HasZone(alpha)
	if not zone then
		zone = BabbleLib:GetInstance("Zone 1.1")
	end
	return zone:HasZone(alpha)
end

function lib.GetEnglishSpell(alpha)
	if not spell then
		spell = BabbleLib:GetInstance("Spell 1.1")
	end
	return spell:GetEnglish(alpha)
end

function lib.GetLocalizedSpell(alpha)
	if not spell then
		spell = BabbleLib:GetInstance("Spell 1.1")
	end
	return spell:GetLocalized(alpha)
end

function lib.GetSpellIterator()
	if not spell then
		spell = BabbleLib:GetInstance("Spell 1.1")
	end
	return spell:GetIterator()
end

function lib.GetReverseSpellIterator()
	if not spell then
		spell = BabbleLib:GetInstance("Spell 1.1")
	end
	return spell:GetReverseIterator()
end

function lib.HasSpell(alpha)
	if not spell then
		spell = BabbleLib:GetInstance("Spell 1.1")
	end
	return spell:HasSpell(alpha)
end

function lib.GetSpellIcon(alpha)
	if not spell then
		spell = BabbleLib:GetInstance("Spell 1.1")
	end
	return spell:GetSpellIcon(alpha)
end

function lib.GetEnglishSpellTree(alpha)
	if not tree then
		tree = BabbleLib:GetInstance("SpellTree 1.1")
	end
	return tree:GetEnglish(alpha)
end

function lib.GetLocalizedSpellTree(alpha)
	if not tree then
		tree = BabbleLib:GetInstance("SpellTree 1.1")
	end
	return tree:GetLocalized(alpha)
end

function lib.GetSpellTreeIterator()
	if not tree then
		tree = BabbleLib:GetInstance("SpellTree 1.1")
	end
	return tree:GetIterator()
end

function lib.GetReverseSpellTreeIterator()
	if not tree then
		tree = BabbleLib:GetInstance("SpellTree 1.1")
	end
	return tree:GetReverseIterator()
end

function lib.HasSpellTree(alpha)
	if not tree then
		tree = BabbleLib:GetInstance("SpellTree 1.1")
	end
	return tree:HasSpellTree(alpha)
end

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
end

function lib:LibDeactivate()
end

BabbleLib:Register(lib)
lib = nil

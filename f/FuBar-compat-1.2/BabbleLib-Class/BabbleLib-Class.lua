local MAJOR_VERSION = "Class 1.1"
local MINOR_VERSION = tonumber(string.sub("$Revision: 1537 $", 12, -3))

if BabbleLib and BabbleLib.versions[MAJOR_VERSION] and BabbleLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

local locale = GetLocale and GetLocale() or "enUS"
if locale ~= "frFR" and locale ~= "deDE" and locale ~= "zhCN" then
	locale = "enUS"
end

local initClasses, classes
if locale == "enUS" then
	function initClasses()
		classes = {
			WARLOCK = "Warlock",
			WARRIOR = "Warrior",
			HUNTER = "Hunter",
			MAGE = "Mage",
			PRIEST = "Priest",
			DRUID = "Druid",
			PALADIN = "Paladin",
			SHAMAN = "Shaman",
			ROGUE = "Rogue",
		}
	end
elseif locale == "deDE" then
	function initClasses()
		classes = {
			WARLOCK = "Hexenmeister",
			WARRIOR = "Krieger",
			HUNTER = "J\195\164ger",
			MAGE = "Magier",
			PRIEST = "Priester",
			DRUID = "Druide",
			PALADIN = "Paladin",
			SHAMAN = "Schamane",
			ROGUE = "Schurke",
		}
	end
elseif locale == "frFR" then
	function initClasses()
		classes = {
			WARLOCK = "D\195\169moniste",
			WARRIOR = "Guerrier",
			HUNTER = "Chasseur",
			MAGE = "Mage",
			PRIEST = "Pr\195\170tre",
			DRUID = "Druide",
			PALADIN = "Paladin",
			SHAMAN = "Chaman",
			ROGUE = "Voleur",
		}
	end
elseif locale == "zhCN" then
	function initClasses()
		classes = {
			WARLOCK = "\230\156\175\229\163\171",
			WARRIOR = "\230\136\152\229\163\171",
			HUNTER = "\231\140\142\228\186\186",
			MAGE = "\230\179\149\229\184\136",
			PRIEST = "\231\137\167\229\184\136",
			DRUID = "\229\190\183\233\178\129\228\188\138",
			PALADIN = "\229\156\163\233\170\145\229\163\171",
			SHAMAN = "\232\144\168\230\187\161\231\165\173\231\165\128",
			ROGUE = "\231\155\151\232\180\188",
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
local localClasses

function lib:GetEnglish(class)
	return localClasses[class] or class
end

function lib:GetLocalized(class)
	return classes[class] or class
end

function lib:GetIterator()
	return pairs(classes)
end

function lib:GetReverseIterator()
	return pairs(localClasses)
end

function lib:GetColor(class)
	class = self:GetEnglish(class)
	if class == "WARLOCK" then
		return 0.784314, 0.509804, 0.588235
	elseif class == "WARRIOR" then
		return 0.784314, 0.607843, 0.431373
	elseif class == "HUNTER" then
		return 0.666667, 0.823529, 0.666667
	elseif class == "MAGE" then
		return 0.411765, 0.803922, 0.941176
	elseif class == "PRIEST" then
		return 1, 1, 1
	elseif class == "DRUID" then
		return 1, 0.490196, 0.039216
	elseif class == "PALADIN" or class == "SHAMAN" then
		return 0.960784, 0.549020, 0.725490
	elseif class == "ROGUE" then
		return 1, 0.960784, 0.411765
	end
	return 0.627451, 0.627451, 0.627451
end

function lib:GetHexColor(class)
	local r, g, b = self:GetColor(class)
	return format("%02x%02x%02x", r * 255, g * 255, b * 255)
end

function lib:HasClass(class)
	return (classes[class] or localClasses[class]) and true or false
end

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
	initClasses()
	initClasses = nil
	
	localClasses = {}
	for english, localized in pairs(classes) do
		if string.sub(english, -4) == "_ALT" then
			localClasses[localized] = string.sub(english, 0, -5)
		elseif string.sub(english, -5, -2) == "_ALT" then
			localClasses[localized] = string.sub(english, 0, -6)
		else
			localClasses[localized] = english
		end
	end
end

function lib:LibDeactivate()
	classes, localClasses, initClasses = nil
end

BabbleLib:Register(lib)
lib = nil

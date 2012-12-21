local MAJOR_VERSION = "Class 1.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 3860 $", 12, -3))

if BabbleLib and BabbleLib.versions[MAJOR_VERSION] and BabbleLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

local locale = GetLocale and GetLocale() or "enUS"

local totalClasses = {
	["Warlock"] = "Warlock",
	["Warrior"] = "Warrior",
	["Hunter"] = "Hunter",
	["Mage"] = "Mage",
	["Priest"] = "Priest",
	["Druid"] = "Druid",
	["Paladin"] = "Paladin",
	["Shaman"] = "Shaman",
	["Rogue"] = "Rogue",
}

local englishToLocal
if locale == "koKR" then 
	englishToLocal = {
		["Warlock"] = "흑마법사",
		["Warrior"] = "전사",
		["Hunter"] = "사냥꾼",
		["Mage"] = "마법사",
		["Priest"] = "사제",
		["Druid"] = "드루이드",
		["Paladin"] = "성기사",
		["Shaman"] = "주술사",
		["Rogue"] = "도적",
	}
elseif locale == "deDE" then
	englishToLocal = {
		["Warlock"] = "Hexenmeister",
		["Warrior"] = "Krieger",
		["Hunter"] = "J\195\164ger",
		["Mage"] = "Magier",
		["Priest"] = "Priester",
		["Druid"] = "Druide",
		["Paladin"] = "Paladin",
		["Shaman"] = "Schamane",
		["Rogue"] = "Schurke",
	}
elseif locale == "frFR" then
	englishToLocal = {
		["Warlock"] = "D\195\169moniste",
		["Warrior"] = "Guerrier",
		["Hunter"] = "Chasseur",
		["Mage"] = "Mage",
		["Priest"] = "Pr\195\170tre",
		["Druid"] = "Druide",
		["Paladin"] = "Paladin",
		["Shaman"] = "Chaman",
		["Rogue"] = "Voleur",
	}
elseif locale == "zhCN" then
	englishToLocal = {
		["Warlock"] = "\230\156\175\229\163\171",
		["Warrior"] = "\230\136\152\229\163\171",
		["Hunter"] = "\231\140\142\228\186\186",
		["Mage"] = "\230\179\149\229\184\136",
		["Priest"] = "\231\137\167\229\184\136",
		["Druid"] = "\229\190\183\233\178\129\228\188\138",
		["Paladin"] = "\229\156\163\233\170\145\229\163\171",
		["Shaman"] = "\232\144\168\230\187\161\231\165\173\231\165\128",
		["Rogue"] = "\231\155\151\232\180\188",
	}
elseif locale ~= "enUS" then
	-- no translations
	englishToLocal = {
	}
end

if englishToLocal then
	for key in pairs(englishToLocal) do
		if not totalClasses[key] then
			error("Improper translation exists. %q is likely misspelled for locale %s.", key, locale)
			break
		end
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

local function assert(condition, message)
	if not condition then
		local stack = debugstack()
		local first = string.gsub(stack, "\n.*", "")
		local file = string.gsub(first, "^(.*\\.*).lua:%d+: .*", "%1")
		file = string.gsub(file, "([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1")
		if not message then
			local _,_,second = string.find(stack, "\n(.-)\n")
			message = "assertion failed! " .. second
		end
		message = "BabbleLib-Class: " .. message
		local i = 1
		for s in string.gfind(stack, "\n([^\n]*)") do
			i = i + 1
			if not string.find(s, file .. "%.lua:%d+:") then
				error(message, i)
				return
			end
		end
		error(message, 2)
		return
	end
	return condition
end

local function argCheck(arg, num, kind, kind2, kind3, kind4)
	if tostring(type(arg)) ~= kind then
		if kind2 then
			if tostring(type(arg)) ~= kind2 then
				if kind3 then
					if tostring(type(arg)) ~= kind3 then
						if kind4 then
							if tostring(type(arg)) ~= kind4 then
								local _,_,func = string.find(debugstack(), "\n.-`(.-)'\n")
								assert(false, format("Bad argument #%d to `%s' (%s, %s, %s, or %s expected, got %s)", num, func, kind, kind2, kind3, kind4, type(arg)))
							end
						else
							local _,_,func = string.find(debugstack(), "\n.-`(.-)'\n")
							assert(false, format("Bad argument #%d to `%s' (%s, %s, or %s expected, got %s)", num, func, kind, kind2, kind3, type(arg)))
						end
					end
				else
					local _,_,func = string.find(debugstack(), "\n.-`(.-)'\n")
					assert(false, format("Bad argument #%d to `%s' (%s or %s expected, got %s)", num, func, kind, kind2, type(arg)))
				end
			end
		else
			local _,_,func = string.find(debugstack(), "\n.-`(.-)'\n")
			assert(false, format("Bad argument #%d to `%s' (%s expected, got %s)", num, func, kind, type(arg)))
		end
	end
end

local lib = {}
local localToEnglish

if locale == "enUS" then
	function lib:GetEnglish(class)
		argCheck(class, 2, "string")
		assert(totalClasses[class], format("Class %q does not exist", class))
		return class
	end
	
	function lib:GetLocalized(class)
		argCheck(class, 2, "string")
		if totalClasses[class] then
			return class
		elseif string.find(class, "^[A-Z]*$") then
			local lowClass = strupper(strsub(class, 1, 1)) .. strlower(strsub(class, 2))
			assert(totalClasses[lowClass], format("Class %q does not exist", class))
			return lowClass
		else
			assert(false, format("Class %q does not exist", class))
		end
	end
	
	function lib:GetIterator()
		return pairs(totalClasses)
	end
	
	lib.GetReverseIterator = lib.GetIterator
	
	function lib:HasClass(class)
		argCheck(class, 2, "string")
		return totalClasses[class] and true or false
	end
else
	function lib:GetEnglish(class)
		argCheck(class, 2, "string")
		local c = localToEnglish[class]
		assert(c, format("Class %q does not exist or is not translated into %s", class, locale))
		return c
	end
	
	function lib:GetLocalized(class)
		argCheck(class, 2, "string")
		if totalClasses[class] then
			local c = englishToLocal[class]
			assert(c, format("Class %q is not translated into %s", class, locale))
			return c
		elseif string.find(class, "^[A-Z]*$") then
			local lowClass = strupper(strsub(class, 1, 1)) .. strlower(strsub(class, 2))
			assert(totalClasses[lowClass], format("Class %q does not exist", class))
			local c = englishToLocal[lowClass]
			assert(c, format("Class %q is not translated into %s", class, locale))
			return c
		else
			assert(false, format("Class %q does not exist", class))
		end
	end
	
	local improperTranslation = nil
	for zone in pairs(totalClasses) do
		if not englishToLocal[zone] then
			improperTranslation = zone
			break
		end
	end
	
	if improperTranslation then
		function lib:GetIterator()
			assert(false, "Class %q not translated into %s", improperTranslation, locale)
		end
		
		lib.GetReverseIterator = lib.GetIterator
	else
		function lib:GetIterator()
			return pairs(englishToLocal)
		end
		
		function lib:GetReverseIterator()
			return pairs(localToEnglish)
		end
	end
	
	function lib:HasClass(class)
		argCheck(class, 2, "string")
		return (totalClasses[class] or localToEnglish[class]) and true or false
	end
end

function lib:GetColor(class)
	argCheck(class, 2, "string")
	if string.find(class, "^[A-Z]*$") then
		class = strupper(strsub(class, 1, 1)) .. strlower(strsub(class, 2))
	elseif localToEnglish then
		class = localToEnglish[class] or class
	end
	if class == "Warlock" then
		return 0.784314, 0.509804, 0.588235
	elseif class == "Warrior" then
		return 0.784314, 0.607843, 0.431373
	elseif class == "Hunter" then
		return 0.666667, 0.823529, 0.666667
	elseif class == "Mage" then
		return 0.411765, 0.803922, 0.941176
	elseif class == "Priest" then
		return 1, 1, 1
	elseif class == "Druid" then
		return 1, 0.490196, 0.039216
	elseif class == "Paladin" or class == "Shaman" then
		return 0.960784, 0.549020, 0.725490
	elseif class == "Rogue" then
		return 1, 0.960784, 0.411765
	end
	return 0.627451, 0.627451, 0.627451
end

function lib:GetHexColor(class)
	argCheck(class, 2, "string")
	local r, g, b = self:GetColor(class)
	return format("%02x%02x%02x", r * 255, g * 255, b * 255)
end

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
	if locale ~= "enUS" then
		localToEnglish = {}
		for english, localized in pairs(englishToLocal) do
			localToEnglish[localized] = english
		end
	end
	
	local mt = getmetatable(self) or {}
	mt.__call = self.GetLocalized
	setmetatable(self, mt)
end

function lib:LibDeactivate()
	totalClasses, localToEnglish, englishToLocal = nil
end

BabbleLib:Register(lib)
lib = nil

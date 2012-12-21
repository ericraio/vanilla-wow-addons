local MAJOR_VERSION = "1.0"
local MINOR_VERSION = tonumber(string.sub("$Revision: 2427 $", 12, -3))
if CrayonLib and CrayonLib.versions[MAJOR_VERSION] and CrayonLib.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
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
if (not CrayonLib) then
   CrayonLib = stub:NewStub();
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
		message = "CrayonLib: " .. message
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

lib.COLOR_HEX_RED       = "ff0000"
lib.COLOR_HEX_ORANGE    = "ff7f00"
lib.COLOR_HEX_YELLOW    = "ffff00"
lib.COLOR_HEX_GREEN     = "00ff00"
lib.COLOR_HEX_WHITE     = "ffffff"
lib.COLOR_HEX_COPPER    = "eda55f"
lib.COLOR_HEX_SILVER    = "c7c7cf"
lib.COLOR_HEX_GOLD      = "ffd700"

function lib:Colorize(hexColor, text)
	return "|cff" .. tostring(hexColor or 'ffffff') .. tostring(text) .. "|r"
end
function lib:Red(text) return self:Colorize(self.COLOR_HEX_RED, text) end
function lib:Orange(text) return self:Colorize(self.COLOR_HEX_ORANGE, text) end
function lib:Yellow(text) return self:Colorize(self.COLOR_HEX_YELLOW, text) end
function lib:Green(text) return self:Colorize(self.COLOR_HEX_GREEN, text) end
function lib:White(text) return self:Colorize(self.COLOR_HEX_WHITE, text) end
function lib:Copper(text) return self:Colorize(self.COLOR_HEX_COPPER, text) end
function lib:Silver(text) return self:Colorize(self.COLOR_HEX_SILVER, text) end
function lib:Gold(text) return self:Colorize(self.COLOR_HEX_GOLD, text) end

local inf = 1/0

function lib:GetThresholdColor(quality, worst, worse, normal, better, best)
	argCheck(quality, 2, "number")
	if quality ~= quality or quality == inf or quality == -inf then
		return 1, 1, 1
	end
	if not best then
		worst = 0
		worse = 0.25
		normal = 0.5
		better = 0.75
		best = 1
	end
	
	if worst < best then
		if (worse == better and quality == worse) or (worst == best and quality == worst) then
			return 1, 1, 0
		elseif quality <= worst then
			return 1, 0, 0
		elseif quality <= worse then
			return 1, 0.5 * (quality - worst) / (worse - worst), 0
		elseif quality <= normal then
			return 1, 0.5 + 0.5 * (quality - worse) / (normal - worse), 0
		elseif quality <= better then
			return 1 - 0.5 * (quality - normal) / (better - normal), 1, 0
		elseif quality <= best then
			return 0.5 - 0.5 * (quality - better) / (best - better), 1, 0
		else
			return 0, 1, 0
		end
	else
		if (worse == better and quality == worse) or (worst == best and quality == worst) then
			return 1, 1, 0
		elseif quality >= worst then
			return 1, 0, 0
		elseif quality >= worse then
			return 1, 0.5 - 0.5 * (quality - worse) / (worst - worse), 0
		elseif quality >= normal then
			return 1, 1 - 0.5 * (quality - normal) / (worse - normal), 0
		elseif quality >= better then
			return 0.5 + 0.5 * (quality - better) / (normal - better), 1, 0
		elseif quality >= best then
			return 0.5 * (quality - best) / (better - best), 1, 0
		else
			return 0, 1, 0
		end
	end
end

function lib:GetThresholdHexColor(quality, worst, worse, normal, better, best)
	local r, g, b = self:GetThresholdColor(quality, worst, worse, normal, better, best)
	return format("%02x%02x%02x", r*255, g*255, b*255)
end

function lib:GetThresholdColorTrivial(quality, worst, worse, normal, better, best)
	argCheck(quality, 2, "number")
	if quality ~= quality or quality == inf or quality == -inf then
		return 1, 1, 1
	end
	if not best then
		worst = 0
		worse = 0.25
		normal = 0.5
		better = 0.75
		best = 1
	end
	
	if worst < best then
		if worse == better and normal == worse then
			return 1, 1, 0
		elseif quality <= worst then
			return 1, 0, 0
		elseif quality <= worse then
			return 1, 0.5 * (quality - worst) / (worse - worst), 0
		elseif quality <= normal then
			return 1, 0.5 + 0.5 * (quality - worse) / (normal - worse), 0
		elseif quality <= better then
			return 1 - (quality - normal) / (better - normal), 1, 0
		elseif quality <= best then
			local x = 0.5 * (quality - better) / (best - better)
			return x, 1 - x, x
		else
			return 0.5, 0.5, 0.5
		end
	else
		if worse == better and normal == worse then
			return 1, 1, 0
		elseif quality >= worst then
			return 1, 0, 0
		elseif quality >= worse then
			return 1, 0.5 - 0.5 * (quality - worse) / (worst - worse), 0
		elseif quality >= normal then
			return 1, 1 - 0.5 * (quality - normal) / (worse - normal), 0
		elseif quality >= better then
			return (quality - better) / (normal - better), 1, 0
		elseif quality >= best then
			local x = 0.5 * (quality - best) / (better - best)
			return 0.5 - x, 0.5 + x, 0.5 - x
		else
			return 0.5, 0.5, 0.5
		end
	end
end

function lib:GetThresholdHexColorTrivial(quality, worst, worse, normal, better, best)
	local r, g, b = self:GetThresholdColorTrivial(quality, worst, worse, normal, better, best)
	return format("%02x%02x%02x", r*255, g*255, b*255)
end

function lib:GetLibraryVersion()
	return MAJOR_VERSION, MINOR_VERSION
end

function lib:LibActivate(stub, oldLib, oldList)
end

function lib:LibDeactivate(stub)
end

CrayonLib:Register(lib)
lib = nil

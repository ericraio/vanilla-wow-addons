
-------------------------------------------
-- ************************************* --
-- ** This embed requires Metrognome! ** --
-- ************************************* --
-------------------------------------------

if not Metrognome then ChatFrame1:AddMessage("<SEEmbedKeys> Metrognome is not installed!") return end

local vmajor, vminor = "Keys 1", tonumber(string.sub("$Revision: 7132 $", 12, -3))
local stubvarname = "TekLibStub"
local libvarname = "SpecialEventsEmbed"


-- Check to see if an update is needed
-- if not then just return out now before we do anything
local libobj = getglobal(libvarname)
if libobj and not libobj:NeedsUpgraded(vmajor, vminor) then return end


local stubobj = getglobal(stubvarname)
if not stubobj then
	stubobj = {}
	setglobal(stubvarname, stubobj)


	-- Instance replacement method, replace contents of old with that of new
	function stubobj:ReplaceInstance(old, new)
		 for k,v in pairs(old) do old[k]=nil end
		 for k,v in pairs(new) do old[k]=v end
	end


	-- Get a new copy of the stub
	function stubobj:NewStub(name)
		local newStub = {}
		self:ReplaceInstance(newStub, self)
		newStub.libName = name
		newStub.lastVersion = ''
		newStub.versions = {}
		return newStub
	end


	-- Get instance version
	function stubobj:NeedsUpgraded(vmajor, vminor)
		local versionData = self.versions[vmajor]
		if not versionData or versionData.minor < vminor then return true end
	end


	-- Get instance version
	function stubobj:GetInstance(version)
		if not version then version = self.lastVersion end
		local versionData = self.versions[version]
		if not versionData then print(string.format("<%s> Cannot find library version: %s", self.libName, version or "")) return end
		return versionData.instance
	end


	-- Register new instance
	function stubobj:Register(newInstance)
		 local version,minor = newInstance:GetLibraryVersion()
		 self.lastVersion = version
		 local versionData = self.versions[version]
		 if not versionData then
				-- This one is new!
				versionData = {
					instance = newInstance,
					minor = minor,
					old = {},
				}
				self.versions[version] = versionData
				newInstance:LibActivate(self)
				return newInstance
		 end
		 -- This is an update
		 local oldInstance = versionData.instance
		 local oldList = versionData.old
		 versionData.instance = newInstance
		 versionData.minor = minor
		 local skipCopy = newInstance:LibActivate(self, oldInstance, oldList)
		 table.insert(oldList, oldInstance)
		 if not skipCopy then
				for i, old in ipairs(oldList) do self:ReplaceInstance(old, newInstance) end
		 end
		 return newInstance
	end
end


if not libobj then
	libobj = stubobj:NewStub(libvarname)
	setglobal(libvarname, libobj)
end

local lib = {}


-- Return the library's current version
function lib:GetLibraryVersion()
	return vmajor, vminor
end


function lib:RegisterEvent(caller, eventname, method)
	if not eventname or not caller then return end

	if not self.registrar[eventname] then self.registrar[eventname] = {} end
	self.registrar[eventname][caller] = method or eventname
	return true
end


function lib:UnregisterEvent(caller, eventname)
	if not eventname or not caller or not self.registrar[eventname]
		or not self.registrar[eventname][caller] then return end

	self.registrar[eventname][caller] = nil
	return true
end


function lib:UnregisterAllEvents(caller)
	if not caller then return end

	for _,v in pairs(self.registrar) do v[caller] = nil end
	return true
end


function lib:TriggerEvent(eventname)
	if not eventname or not self.registrar[eventname] then return end

	for i,v in pairs(self.registrar[eventname]) do
		if type(v) == "function" then v(i)
		elseif i[v] then i[v](i) end
	end
end


-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	self.metrognome = Metrognome:GetInstance("1")
	if oldLib then
		self.vars, self.registrar = oldLib.vars or {}, oldLib.registrar or {}
		self.metrognome:Unregister("SEEmbedKeys")
		self.metrognome:Unregister("SEEmbedKeys2") -- cause I forgot to change this crap before I committed it up ><
	else
		self.registrar, self.vars = {}, {}
	end
	self.metrognome:Register("SEEmbedKeys", self.OnTick, nil, self)
	self.metrognome:Start("SEEmbedKeys")
end


function lib:OnTick()
	local ctrl, shift, alt = IsControlKeyDown(), IsShiftKeyDown(), IsAltKeyDown()

	if ctrl  and not self.vars.ctrl  then self:TriggerEvent("SPECIAL_CTRLKEY_DOWN")  end
	if shift and not self.vars.shift then self:TriggerEvent("SPECIAL_SHIFTKEY_DOWN") end
	if alt   and not self.vars.alt   then self:TriggerEvent("SPECIAL_ALTKEY_DOWN")   end

	if not ctrl  and self.vars.ctrl  then self:TriggerEvent("SPECIAL_CTRLKEY_UP")  end
	if not shift and self.vars.shift then self:TriggerEvent("SPECIAL_SHIFTKEY_UP") end
	if not alt   and self.vars.alt   then self:TriggerEvent("SPECIAL_ALTKEY_UP")   end

	self.vars.ctrl, self.vars.shift, self.vars.alt = ctrl, shift, alt
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

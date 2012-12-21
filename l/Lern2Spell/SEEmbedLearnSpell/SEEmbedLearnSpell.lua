
local vmajor, vminor = "Learn Spell 1", tonumber(string.sub("$Revision: 1481 $", 12, -3))
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


function lib:TriggerEvent(eventname, a1,a2,a3,a4)
	if not eventname or not self.registrar[eventname] then return end

	for i,v in pairs(self.registrar[eventname]) do
		if type(v) == "function" then v(i,a1,a2,a3,a4)
		elseif i[v] then i[v](i,a1,a2,a3,a4) end
	end
end


-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	if oldLib then
		self.vars, self.registrar = oldLib.vars, oldLib.registrar
		self.frame = oldLib.frame
	else
		self.registrar, self.vars = {}, {}
		self.frame = CreateFrame("Frame")
		self.frame.name = "SEEmbed LearnSpell Frame"
		self.frame:RegisterEvent("SPELLS_CHANGED")
		self.vars.spells = self:GetSpellList()
	end
	self.frame:SetScript("OnEvent", self.OnEvent)
end


function lib:OnEvent()
	local self = lib
	local newsp, oldsp = self:GetSpellList(), self.vars.spells

	for spell,rank in pairs(newsp) do
		if oldsp[spell] ~= rank then
			self:TriggerEvent("SPECIAL_LEARNED_SPELL", spell, rank)
		end
	end

	for i in pairs(oldsp) do oldsp[i] = nil end
	self.vars.empty = oldsp
	self.vars.spells = newsp
end


function lib:GetSpellList()
  local i, rt = 1, self.vars.empty or {}
	self.vars.empty = nil

  repeat
    local sname, srank = GetSpellName(i, BOOKTYPE_SPELL)
   	if sname then rt[sname] = srank end
  	i = i+1
	until not GetSpellName(i, BOOKTYPE_SPELL)

	return rt
end


function lib:GetRank(spell)
	assert(spell, "No spell passed")
	return self.vars.spells[spell][1], self.vars.spells[spell][2]
end


function lib:GetSpells()
	return self.vars.spells
end


--------------------------------
--      Tracking methods      --
--------------------------------

function lib:GetNumSlots(bag)
	if not self.vars.bags[bag] then return GetContainerNumSlots(bag) end

	local n = 0
	for i in pairs(self.vars.bags[bag]) do n = n + 1 end
	return math.max(n, GetContainerNumSlots(bag))
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

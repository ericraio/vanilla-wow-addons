
local vmajor, vminor = "Bank 1", tonumber(string.sub("$Revision: 1519 $", 12, -3))
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
		self.frame.name = "SEEmbed Bank Frame"
		self.frame:RegisterEvent("BANKFRAME_OPENED")
		self.frame:RegisterEvent("BANKFRAME_CLOSED")
	end
	self.frame:SetScript("OnEvent", self.OnEvent)
end


function lib:OnEvent()
	local self = lib
	if self[event] then self[event](self) end
end


--------------------------------
--      Tracking methods      --
--------------------------------

function lib:BANKFRAME_OPENED()
	self.frame:RegisterEvent("BAG_UPDATE")
	self.frame:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	if self.vars.bank then return end

	self.vars.bank = {}

	for bag=-1,10 do
		if bag >= 0 and bag <= 4 then break end
		self.vars.bank[bag] = {}

		for slot=1,GetContainerNumSlots(bag) do
			local itemlink = GetContainerItemLink(bag, slot)
			local _, stack = GetContainerItemInfo(bag, slot)

			self.vars.bank[bag][slot] = {itemlink, stack}
		end
	end
end


function lib:BANKFRAME_CLOSED()
	self.frame:UnregisterEvent("BAG_UPDATE")
	self.frame:UnregisterEvent("PLAYERBANKSLOTS_CHANGED")
end


function lib:PLAYERBANKSLOTS_CHANGED()
	self:BAG_UPDATE(-1)
end


function lib:BAG_UPDATE(bagnum)
	local bag = bagnum or arg1
	if not bag then self:TriggerEvent("SPECIAL_WTF", "No bag!") return end
	if bag >= 0 and bag <= 4 then return end

	for slot=1,self:GetNumSlots(bag) do
		local itemlink = GetContainerItemLink(bag, slot)
		local _, stack = GetContainerItemInfo(bag, slot)

		if not self.vars.bank[bag] then self.vars.bank[bag] = {} end
		if not self.vars.bank[bag][slot] then self.vars.bank[bag][slot] = {} end

		local oldlink, oldstack = self.vars.bank[bag][slot][1], self.vars.bank[bag][slot][2]

		if (oldlink ~= itemlink) or (oldstack ~= stack) then
			self:TriggerEvent("SPECIAL_BANKBAGSLOT_UPDATE", bag, slot, itemlink, stack, oldlink, oldstack)
			self.vars.bank[bag][slot][1], self.vars.bank[bag][slot][2] = itemlink, stack
		end
	end
end


function lib:GetNumSlots(bag)
	if not self.vars.bank[bag] then return GetContainerNumSlots(bag) end

	local n = 0
	for i in pairs(self.vars.bank[bag]) do n = n + 1 end
	return math.max(n, GetContainerNumSlots(bag))
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

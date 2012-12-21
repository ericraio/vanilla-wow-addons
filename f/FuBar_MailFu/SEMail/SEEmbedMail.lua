
local vmajor, vminor = "Mail 1", tonumber(string.sub("$Revision: 1745 $", 12, -3))
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
		self.frame.name = "SEEmbed Mail Frame"
		self.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
		self.frame:RegisterEvent("MAIL_CLOSED")
		self.frame:RegisterEvent("UPDATE_PENDING_MAIL")
		self.frame:RegisterEvent("CHAT_MSG_SYSTEM")
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

function lib:PLAYER_ENTERING_WORLD()
	self.vars.zoneevent = true
end


function lib:MAIL_CLOSED()
	self.vars.lastclose = GetTime()
end


local closedelay = 5
function lib:UPDATE_PENDING_MAIL()
	if self.vars.lastclose and (self.vars.lastclose + closedelay) > GetTime() then self.vars.ignorenext = true end

	if self.vars.zoneevent then
		self.vars.zoneevent = nil
		self:TriggerEvent("SPECIAL_MAIL_INIT")
		return
	end

	if self.vars.ignorenext then
		self.vars.ignorenext = nil
		return
	end

	self:TriggerEvent("SPECIAL_MAIL_RECEIVED")
end


-- Events that don't fire UPDATE_PENDING_MAIL like they should
local brokenevents = {
	[ERR_AUCTION_WON_S]     = false,
	[ERR_AUCTION_SOLD_S]    = true,
	[ERR_AUCTION_OUTBID_S]  = true,
	[ERR_AUCTION_EXPIRED_S] = true,
	[ERR_AUCTION_REMOVED_S] = false,
}
local eventnames = {
	[ERR_AUCTION_WON_S]     = "WON",
	[ERR_AUCTION_SOLD_S]    = "SOLD",
	[ERR_AUCTION_OUTBID_S]  = "OUTBID",
	[ERR_AUCTION_EXPIRED_S] = "EXPIRED",
	[ERR_AUCTION_REMOVED_S] = "REMOVED",
}
local aucstr = {}
for i in pairs(brokenevents) do aucstr[i] = string.gsub(i, "%%[^%s]+", "(.+)") end

function lib:CHAT_MSG_SYSTEM()
	local msg = arg1
	if not msg then return end

	for i,searchstr in pairs(aucstr) do
		local _, _, item = string.find(msg, searchstr)
		if item then
			self:TriggerEvent("SPECIAL_AH_ALERT", eventnames[i], item)
			if brokenevents[i] then
				self:TriggerEvent("SPECIAL_MAIL_RECEIVED")
				return
			end
		end
	end
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

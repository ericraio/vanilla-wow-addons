
local vmajor, vminor = "1", tonumber(string.sub("$Revision: 666 $", 12, -3))
local stubvarname = "TekLibStub"
local libvarname = "PTTradeskillsEmbed"


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


-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	local maj, min = self:GetLibraryVersion()

	if oldLib then
		local omaj, omin = oldLib:GetLibraryVersion()
		self.compost = oldLib.compost or CompostLib and CompostLib:GetInstance("compost-1")
		self.quals, self.tradedata, self.eventframe = oldLib.quals, oldLib.tradedata, oldLib.eventframe
	else
		self.compost = CompostLib and CompostLib:GetInstance("compost-1")
		self.quals = {trivial = 0, easy = 1, medium = 2, optimal = 3, difficult = 4}
		self.tradedata = {}

		self.eventframe = CreateFrame("Frame")
		self.eventframe.master = self
		self.eventframe:SetScript("OnEvent", function() this.master[event](this.master) end)
		self.eventframe:RegisterEvent("CRAFT_SHOW")
		self.eventframe:RegisterEvent("TRADE_SKILL_SHOW")
	end
	-- nil return makes stub do object copy
end


------------------------------
--      Lookup methods      --
------------------------------

-- Returns a table of recepies this item is used in, or nil if no known use
-- Return table elements are as follows:
-- [recepieid] = {recepiename, skilllevel, numberneeded}
-- recepieid == an itemid for the product (or an enchantid if the recepie is an enchant)
-- recepiename == name of the item made
-- skilllevel == relative difficulty of the recepie
-- numberneeded == number of the ingred item called for in the recepie
function lib:GetRecepieUse(itemid)
	if type(itemid) == "string" then
		_, _, id = string.find(itemid, "item:(%d+):%d+:%d+:%d+")
		if id then itemid = tonumber(id)
		else return end
	end
	if type(itemid) ~= "number" then return end

	local retval
	for trade,data in self.tradedata do
		for recid,recdata in data do
			for id,num in recdata.ing do
				if id == itemid then
					if not retval then retval = self.compost and self.compost:Acquire() or {} end
					local name = recdata.name or GetItemInfo(recid)
					retval[recid] = self.compost and self.compost:Acquire(name, recdata.skill, num) or {name, recdata.skill, num}
				end
			end
		end
	end

	return retval
end


-- returns true if the tradeskill passed uses the itemid, nil otherwise
function lib:TradeUsesItem(trade, itemid)
	if not self.tradedata[trade] then return end

	for recid,recdata in self.tradedata[trade] do
		for id,num in recdata.ing do
			if id == itemid then return true end
		end
	end
end


-- Returns a list of tradeskills the player know which can use the itemid, or nil if none
function lib:TradesUseItem(itemid)
	local retval
	for trade,data in self.tradedata do
		if self:TradeUsesItem(trade, itemid) then
			if not retval then retval = self.compost and self.compost:Acquire() or {} end
			table.insert(retval, trade)
		end
	end

	return retval
end


----------------------------------
--      Tradeskill parsing      --
----------------------------------

function lib:TRADE_SKILL_SHOW()
	local trade = GetTradeSkillLine()
	if not self.tradedata[trade] then self.tradedata[trade] = {} end

	for i=1,GetNumTradeSkills() do
		local _, t = GetTradeSkillInfo(i)
		if (t ~= "header") then
			local link = GetTradeSkillItemLink(i)
			if link then
				local _, _, id = string.find(link, "item:(%d+):%d+:%d+:%d+")
				self.tradedata[trade][tonumber(id)] = self.tradedata[trade][tonumber(id)] or {ing = self:ParseTradeskillItem(i), skill = self.quals[t]}
			end
		end
	end
end


function lib:ParseTradeskillItem(tidx)
	local retval = {}

	for i=1,GetTradeSkillNumReagents(tidx) do
		local _, _, num = GetTradeSkillReagentInfo(tidx, i)
		local link = GetTradeSkillReagentItemLink(tidx, i)
		if link then
			local _, _, id = string.find(link, "item:(%d+):%d+:%d+:%d+")
			retval[tonumber(id)] = num
		end
	end

	return retval
end


-----------------------------
--      Craft parsing      --
-----------------------------

-- Craft == enchanting, tradeskill == everything else
function lib:CRAFT_SHOW()
	local trade = GetCraftName()
	if not self.tradedata[trade] then self.tradedata[trade] = {} end

	for i=1,GetNumCrafts() do
		local name, _, t = GetCraftInfo(i)
		if (t ~= "header") then
			local link = GetCraftItemLink(i)
			if link then
				local _, _, id = string.find(link, "enchant:(%d+)")
				self.tradedata[trade][tonumber(id)] = self.tradedata[trade][tonumber(id)] or {ing = self:ParseCraftItem(i), skill = self.quals[t], name = name}
			end
		end
	end
end


function lib:ParseCraftItem(idx)
	local retval = {}

	for i=1,GetCraftNumReagents(idx) do
		local _, _, num = GetCraftReagentInfo(idx, i)
		local link = GetCraftReagentItemLink(idx, i)
		if link then
			local _, _, id = string.find(link, "item:(%d+):%d+:%d+:%d+")
			retval[tonumber(id)] = num
		end
	end

	return retval
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

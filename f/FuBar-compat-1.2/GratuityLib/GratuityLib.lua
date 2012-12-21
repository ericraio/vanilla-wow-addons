
local vmajor, vminor = "1", tonumber(string.sub("$Revision: 3764 $", 12, -3))
local stubvarname = "TekLibStub"
local libvarname = "Gratuity"


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

----------------------------
--      Library Code      --
----------------------------
if not libobj then
	libobj = stubobj:NewStub(libvarname)
	setglobal(libvarname, libobj)
end

local lib = {}


-- Return the library's current version
function lib:GetLibraryVersion()
	return vmajor, vminor
end

local methods = {
	"SetBagItem", "SetAction", "SetAuctionItem", "SetAuctionSellItem", "SetBuybackItem",
	"SetCraftItem", "SetCraftSpell", "SetHyperlink", "SetInboxItem", "SetInventoryItem",
	"SetLootItem", "SetLootRollItem", "SetMerchantItem", "SetPetAction", "SetPlayerBuff",
	"SetQuestItem", "SetQuestLogItem", "SetQuestRewardSpell", "SetSendMailItem", "SetShapeshift",
	"SetSpell", "SetTalent", "SetTrackingSpell", "SetTradePlayerItem", "SetTradeSkillItem", "SetTradeTargetItem",
	"SetTrainerService", "SetUnit", "SetUnitBuff", "SetUnitDebuff",
}

local function err(message)
	local stack = debugstack()
	local first = string.gsub(stack, "\n.*", "")
	local file = string.gsub(first, "^(.*\\.*).lua:%d+: .*", "%1")
	file = string.gsub(file, "([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1")
	if not message then
		local _,_,second = string.find(stack, "\n(.-)\n")
		message = "An error occured! " .. second
	end
	message = "Gratuity: " .. message
	local i = 1
	for s in string.gfind(stack, "\n([^\n]*)") do
		i = i + 1
		if not string.find(s, file .. "%.lua:%d+:") then
			error(message, i)
			return
		end
	end
	error(message, 2)
end

local function assert(condition, message)
	if not condition then
		if not message then
			local _,_,second = string.find(debugstack(), "\n(.-)\n")
			message = "assertion failed! " .. second
		end
		err(message)
		return
	end
	return condition
end

-- Activate a new instance of this library
function lib:LibActivate(stub, oldLib, oldList)
	local maj, min = self:GetLibraryVersion()

	if oldLib then
		local omaj, omin = oldLib:GetLibraryVersion()
		for _,m in pairs(methods) do
			self[m] = oldLib[m]
		end
		self.vars = oldLib.vars
		if self.vars.tooltip then self:CreateSetMethods() end
	else
		self.vars = {}
	end
	if not self.vars.tooltip then self:CreateTooltip() end
	-- nil return makes stub do object copy
end


function lib:InitCompost()
	if not self.vars.compost and CompostLib then self.vars.compost = CompostLib:GetInstance("compost-1") end
end


-- Retreive the tooltip assigned to Gratuity
function lib:GetTooltip(tooltip)
	return self.vars.tooltip
end


-------------------------------------------------------------------------------------
-- Pass a tooltip frame to be used (make sure the tooltip does not have a parent!!!)
-- You can use this line in your XML to define the tooltip:
-- <GameTooltip name="NameGoesHere" inherits="GameTooltipTemplate"/>
-- This *would* be part of the EmbedLib but the game throws an error
-- when you try to declare two tooltips with the same name *growl*
-------------------------------------------------------------------------------------
-- Returns the stored tooltip (this may not match what you passed!)
-- You need to be careful how you use the tooltip or it can
-- get "detached" from it's owner and stop parsing.  Please make sure you read up
-- about tips here: http://www.wowwiki.com/UIOBJECT_GameTooltip
-------------------------------------------------------------------------------------
-- ******************************************************************************* --
-- **  THIS METHOD IS NOW DEPRICIATED! Patch 1.11 now allows me to dynamically  ** --
-- **                  create a viable GameTooltip with pure LUA.               ** --
-- **                  Mods no longer need to register a tooltip!               ** --
-- ******************************************************************************* --
-------------------------------------------------------------------------------------
function lib:RegisterTooltip(tooltip)
	return self.vars.tooltip
end


function lib:CreateTooltip()
	local tt = CreateFrame("GameTooltip")

	self.vars.tooltip = tt
	tt:SetOwner(tt, "ANCHOR_NONE")
--	tooltip:SetParent()

	self.vars.Llines, self.vars.Rlines = {}, {}
	for i=1,30 do
		self.vars.Llines[i] = tt:CreateFontString()
		self.vars.Rlines[i] = tt:CreateFontString()
		self.vars.Llines[i]:SetFontObject(GameFontNormal)
		self.vars.Rlines[i]:SetFontObject(GameFontNormal)
		tt:AddFontStrings(self.vars.Llines[i], self.vars.Rlines[i])
	end

	if not self.SetBagItem then self:CreateSetMethods() end

	return tt
end


--	Clears the tooltip completely, none of this "erase left, hide right" crap blizzard does
-- returns true is successful, nil if no tooltip assigned
function lib:Erase()
	assert(self.vars.tooltip, "No tooltip declared!")

	self.vars.tooltip:ClearLines() -- Ensures tooltip's NumLines is reset
	for i=1,30 do self.vars.Rlines[i]:SetText() end -- Clear text from right side (ClearLines only hides them)

	if not self.vars.tooltip:IsVisible() then self.vars.tooltip:SetOwner(self.vars.tooltip, "ANCHOR_NONE") end

	return true
end


-- Get the number of lines
-- Arg: endln - If passed and tooltip's NumLines is higher, endln is returned back
function lib:NumLines(endln)
	local num = self.vars.tooltip:NumLines()
	return endln and num > endln and endln or num or 0
end


--	If text is found on tooltip then results of string.find are returned
--  Args:
--    txt      - The text string to find
--    startln  - First tooltip line to check, default 1
--    endln    - Last line to test, default 30
--    ignoreleft / ignoreright - Causes text on one side of the tooltip to be ignored
function lib:Find(txt, startln, endln, ignoreleft, ignoreright)
	assert(txt, "No search string passed")
	local t1, t2 = type(startln or 1), type(self:NumLines(endln))
	if (t1 ~= "number" or t2 ~= "number") then print(t1, t2, (startln or 1),self:NumLines(endln)) end
	for i=(startln or 1),self:NumLines(endln) do
		if not ignoreleft then
			local txtl = self.vars.Llines[i]:GetText()
			if (txtl and string.find(txtl, txt)) then return string.find(txtl, txt) end
		end

		if not ignoreright then
			local txtr = self.vars.Rlines[i]:GetText()
			if (txtr and string.find(txtr, txt)) then return string.find(txtr, txt) end
		end
	end
end


--  Calls Find many times.
--  Args are passed directly to Find, t1-t10 replace the txt arg
function lib:MultiFind(startln, endln, ignoreleft, ignoreright, t1,t2,t3,t4,t5,t6,t7,t8,t9,t10)
	assert(t1, "No search string passed")
	if t1 and self:Find(t1, startln, endln, ignoreleft, ignoreright) then return self:Find(t1, startln, endln, ignoreleft, ignoreright)
	elseif t2 then return self:MultiFind(startln, endln, ignoreleft, ignoreright, t2,t3,t4,t5,t6,t7,t8,t9,t10) end
end


local deformat
--	If text is found on tooltip then results of deformat:Deformat are returned
--  Args:
--    txt      - The text string to deformat and serach for
--    startln  - First tooltip line to check, default 1
--    endln    - Last line to test, default 30
--    ignoreleft / ignoreright - Causes text on one side of the tooltip to be ignored
function lib:FindDeformat(txt, startln, endln, ignoreleft, ignoreright)
	assert(txt, "No search string passed")
	if not deformat then
		assert(BabbleLib, "You must have BabbleLib-Core 1.1 or BabbleLib-Deformat 1.2 available")
		if BabbleLib.versions["Deformat 1.2"] then
			deformat = BabbleLib:GetInstance("Deformat 1.2")
		elseif BabbleLib.versions["Core 1.1"] then
			deformat = BabbleLib:GetInstance("Core 1.1")
		else
            assert(false, "You must have BabbleLib-Core 1.1 or BabbleLib-Deformat 1.2 available")
		end
	end

	for i=(startln or 1),self:NumLines(endln) do
		if not ignoreleft then
			local txtl = self.vars.Llines[i]:GetText()
			if (txtl and deformat:Deformat(txtl, txt)) then return deformat:Deformat(txtl, txt) end
		end

		if not ignoreright then
			local txtr = self.vars.Rlines[i]:GetText()
			if (txtr and deformat:Deformat(txtr, txt)) then return deformat:Deformat(txtr, txt) end
		end
	end
end


--	Returns a table of strings pulled from the tooltip, or nil if no strings in tooltip
--  Args:
--    startln  - First tooltip line to check, default 1
--    endln    - Last line to test, default 30
--    ignoreleft / ignoreright - Causes text on one side of the tooltip to be ignored
function lib:GetText(startln, endln, ignoreleft, ignoreright)
	self:InitCompost()
	local retval

	for i=(startln or 1),(endln or 30) do
		local txtl, txtr
		if not ignoreleft then txtl = self.vars.Llines[i]:GetText() end
		if not ignoreright then txtr = self.vars.Rlines[i]:GetText() end
		if txtl or txtr then
			if not retval then retval = self.vars.compost and self.vars.compost:Acquire() or {} end
			local t = self.vars.compost and self.vars.compost:Acquire(txtl, txtr) or {txtl, txtr}
			table.insert(retval, t)
		end
	end

	return retval
end


--	Returns the text from a specific line (both left and right unless second arg is true)
--  Args:
--    line     - the line number you wish to retrieve
--    getright - if passed the right line will be returned, if not the left will be returned
function lib:GetLine(line, getright)
	assert(type(line) == "number", "No line number passed")
	if self.vars.tooltip:NumLines() < line then return end
	if getright then return self.vars.Rlines[line] and self.vars.Rlines[line]:GetText()
	elseif self.vars.Llines[line] then
		return self.vars.Llines[line]:GetText(), self.vars.Rlines[line]:GetText()
	end
end


-----------------------------------
--      Set tooltip methods      --
-----------------------------------

-- These methods are designed to immitate the GameTooltip API
-- CreateSetMethods is called on RegisterTooltip if not yet defined

local testmethods = {
	SetAction = function(id) return HasAction(id) end,
}
local gettrue = function() return true end
function lib:CreateSetMethods()
	for _,m in pairs(methods) do
		local meth = m
		local func = testmethods[meth] or gettrue
		lib[meth] = function(self,a1,a2,a3,a4)
			self:Erase()
			if not func(a1,a2,a3,a4) then return end
			local s, r1,r2,r3,r4,r5,r6,r7,r8,r9,r10 = pcall(self.vars.tooltip[meth], self.vars.tooltip,a1,a2,a3,a4)
			if s then return r1,r2,r3,r4,r5,r6,r7,r8,r9,r10
			else err(r1) end
		end
	end
end


--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

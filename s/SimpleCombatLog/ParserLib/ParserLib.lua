---------------------------------------------------------------------------
-- You MUST update the major version whenever you make an incompatible
-- change
---------------------------------------------------------------------------
-- You MUST update the minor version whenever you make a compatible
-- change (And check LibActivate is still valid!)
---------------------------------------------------------------------------
-- Set usedebug = true if you want to see output
-- ** THIS ONLY APPLIES TO THIS INSTANCE OF THE LIBRARY **
---------------------------------------------------------------------------

local vmajor, vminor = "1.1", 15  		-- Set your version numbers here
local stubvarname = "TekLibStub"       -- Change this to your library stub's global name
local libvarname = "ParserLib"    -- Change this to your library's global name




-- ************************************* --
-- ** This embed requires CompostLib! ** --
-- ************************************* --
if not CompostLib then ChatFrame1:AddMessage("<ParserLib> CompostLib is not installed!", 1, 0, 0) return end
compost = CompostLib:GetInstance("compost-1")



---------------------------------------------------------------------------
-- **************************************************************
-- **** YOU DON'T NEED TO EDIT ANYTHING BELOW UNTIL LINE 146 ****
-- **************************************************************
---------------------------------------------------------------------------

-- Check to see if an update is needed
-- if not then just return out now before we do anything
local libobj = getglobal(libvarname)
if libobj and not libobj:NeedsUpgraded(vmajor, vminor) then return end


---------------------------------------------------------------------------
-- Embedded Library Registration Stub
-- Written by Iriel <iriel@vigilance-committee.org>
-- Version 0.1 - 2006-03-05
-- Modified by Tekkub <tekkub@gmail.com>
---------------------------------------------------------------------------

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
		----------------------------------------------------
		-- ********************************************** --
		-- **** Copy over any old data you need here **** --
		-- ********************************************** --
		----------------------------------------------------
		self.frame = oldLib.frame
		self:OnLoad()

		if omin < 11 and oldLib.clients then
			for event in oldLib.clients do
				for i in oldLib.clients[event] do
					if type(oldLib.clients[event][i]["func"]) == "string" then
						oldLib.clients[event][i]["func"] = getglobal(oldLib.clients[event][i]["func"])
					end
				end
			end
		end
		self.clients = oldLib.clients

		
	else
		---------------------------------------------------
		-- ********************************************* --
		-- **** Do any initialization you need here **** --
		-- ********************************************* --
		---------------------------------------------------
		self:OnLoad()
	end
	-- nil return makes stub do object copy
end


-------------------------------------
-- ******************************* --
-- **** Add your methods here **** --
-- ******************************* --
-------------------------------------



-- Constants
ParserLib_SELF = 103
ParserLib_MELEE = 112
ParserLib_DAMAGESHIELD = 113


-- Public Methods

function lib:RegisterEvent(addonID, event, handler)

	local eventExist
	for i, v in self.supportedEvents do
		if v == event then
			eventExist = true
			break
		end
	end
	
	if not eventExist then
		self:Print( string.format("Event %s is not supported. (AddOnID %s)", event, addonID), 1, 0, 0 )
		return
	end
	

	self:Debug(string.format("Registering %s for addon %s.", event, addonID) );	

	if type(handler) == "string" then handler = getglobal(handler) end
	
	if not handler then self:Print("nil handler from " .. addonID, 1, 0, 0) return end


	if self.clients[event] == nil then
		self.clients[event] = {};	
	end
	
	table.insert(self.clients[event], { ["id"]=addonID, ["func"]=handler } );
	self.frame:RegisterEvent(event);

end

function lib:IsEventRegistered(addonID, event)
	if self.clients[event] then
		for i, v in self.clients[event] do
			if v.id == addonID then return true end
		end
	end
end

function lib:UnregisterEvent(addonID, event)
	local empty = true
	
	
	if not self.clients[event] then return end
	
	for i, v in self.clients[event] do
		if v.id == addonID then
			self:Debug( format("Removing %s from %s", v.id, event) )		
			table.remove(self.clients[event], i)
		else
			empty = false
		end
	end
	
	if empty then
		self:Debug("Unregistering event " .. event)
		self.frame:UnregisterEvent(event)
		self.clients[event] = nil
	end
end

function lib:UnregisterAllEvents(addonID)
	local event, index, empty;
	
	for event in self.clients do
		empty = true;
		
		for i, v in self.clients[event] do
			if v.id == addonID then
				self:Debug( format("Removing %s for %s", v.id, event) )
				table.remove(self.clients[event], i)
--				self.clients[event][index] = nil;
			else
				empty = false;
			end
		end
		
		if empty then
			self:Debug("Unregistering event " .. event)
			self.frame:UnregisterEvent(event);
			self.clients[event] = nil;
		end
		
	end	

end


function lib:Deformat(text, pattern)
	if not self.customPatterns then self.customPatterns = {} end		
	if not self.customPatterns[pattern] then
		self.customPatterns[pattern] = self:Curry(pattern)
	end
	return self.customPatterns[pattern](text)
end


-- Convert "%s hits %s for %d." to "(.+) hits (.+) for (%d+)."
-- Will additionaly return the sequence of tokens, for example:	                    
--  "%2$s reflects %3$d %4$s damage to %1$s."   will return: 
--    "(.-) reflects (%+) (.-) damage to (.-)%.",  4 1 2 3. 
--  (    [1]=2,[2]=3,[3]=4,[4]=1  Reverting indexes and become  [1]=4, [2]=[1],[3]=2,[4]=3. )
function lib:ConvertPattern(pattern, anchor)

	local seq

	-- Add % to escape all magic characters used in LUA pattern matching, except $ and %
	pattern = string.gsub(pattern,"([%^%(%)%.%[%]%*%+%-%?])","%%%1");
	
	-- Do these AFTER escaping the magic characters.
	pattern = string.gsub(pattern,"%%s","(.-)"); -- %s to (.-)
	pattern = string.gsub(pattern,"%%d","(%%d+)"); -- %d to (%d+)			

	if string.find(pattern,"%$") then
		seq = {}; -- fills with ordered list of $s as they appear
		local idx = 1; -- incremental index into field[]

		local tmpSeq = {}
		for i in string.gfind(pattern,"%%(%d)%$.") do
			tmpSeq[idx] = tonumber(i);
			idx = idx + 1
		end
		for i, j in ipairs(tmpSeq) do
			seq[j] = i
		end
		table.setn(seq, table.getn(tmpSeq))
		pattern = string.gsub(pattern,"%%%d%$s","(.-)"); -- %1$s to (.-)
		pattern = string.gsub(pattern,"%%%d%$d","(%%d+)"); -- %1$d to (%d+)
	end

	-- Escape $ now.
	pattern = string.gsub(pattern,"%$","%%$");

	-- Anchor tag can improve string.find() performance by 100%.
	if anchor then pattern = "^"..pattern end	
	
	-- If the pattern ends with (.-), replace it with (.+), or the capsule will be lost.
	if string.sub(pattern, -4) == "(.-)" then
		pattern = string.sub(pattern, 0, -5) .. "(.+)";
	end
	
	if not seq then return pattern end
	
	return pattern, seq[1], seq[2], seq[3], seq[4], seq[5], seq[6], seq[7], seq[8], seq[9], seq[10]
end

lib.debug = nil
local function ParserOnEvent() lib:OnEvent() end


-- Currently supported event list.
lib.supportedEvents = {

	"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES",
	"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
	"CHAT_MSG_COMBAT_FACTION_CHANGE",
	"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
	"CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES",
	"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
	"CHAT_MSG_COMBAT_HONOR_GAIN",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
	"CHAT_MSG_COMBAT_HOSTILE_DEATH",
	"CHAT_MSG_COMBAT_PARTY_HITS",
	"CHAT_MSG_COMBAT_PARTY_MISSES",
	"CHAT_MSG_COMBAT_PET_HITS",
	"CHAT_MSG_COMBAT_PET_MISSES",
	"CHAT_MSG_COMBAT_SELF_HITS",
	"CHAT_MSG_COMBAT_SELF_MISSES",
	"CHAT_MSG_COMBAT_XP_GAIN",
	"CHAT_MSG_SPELL_AURA_GONE_OTHER",
	"CHAT_MSG_SPELL_AURA_GONE_SELF",
	"CHAT_MSG_SPELL_AURA_GONE_PARTY",
	"CHAT_MSG_SPELL_BREAK_AURA",
	"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
	"CHAT_MSG_SPELL_FAILED_LOCALPLAYER",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_ITEM_ENCHANTMENTS",
	"CHAT_MSG_SPELL_PARTY_BUFF",
	"CHAT_MSG_SPELL_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
	"CHAT_MSG_SPELL_PET_BUFF",
	"CHAT_MSG_SPELL_PET_DAMAGE",
	"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_SPELL_TRADESKILLS",

}

-- Sort the pattern so that they can be parsed in a correct sequence, will only do once for each registered event.
local function PatternCompare(a, b)
	
	local pa = getglobal(a)
	local pb = getglobal(b)
	
	if not pa then ChatFrame1:AddMessage("|cffff0000Nil pattern: ".. a.."|r") end
	if not pb then ChatFrame1:AddMessage("|cffff0000Nil pattern: ".. b.."|r") end
		
	local ca=0
	for _ in string.gfind(pa, "%%%d?%$?[sd]") do ca=ca+1 end
	local cb=0
	for _ in string.gfind(pb, "%%%d?%$?[sd]") do cb=cb+1 end

	pa = string.gsub(pa, "%%%d?%$?[sd]", "")	
	pb = string.gsub(pb, "%%%d?%$?[sd]", "")
	
	if string.len(pa) == string.len(pb) then
		return  ca < cb;
	else
		return string.len(pa) > string.len(pb)
	end
	
end


-- local timing = true -- timer


function lib:OnLoad()

	-- Both table starts out empty, and load the data only when required.
	self.eventTable = {}
	self.patternTable = {}


	if timing then
		ctimer = {
			acquire = 0,
			recycle = 0,
			reclaim = 0,
		}
			
		self.time = {
			find = 0,
			list = 0,
			parse = 0,
			trailer = 0,
			notify = 0,
			LoadPatternInfo = 0
		}
	end

	if not self.clients then self.clients = {} end
	
	if not self.frame then
		self.frame = CreateFrame("FRAME", "ParserLibFrame")
		self.frame:SetScript("OnEvent", ParserOnEvent );		
	end
	
	
end
	
	
function lib:OnEvent(e, a1)
	local info, infoBackup, func;
	
	if not e then e = event end
	if not a1 then a1 = arg1 end


	self:Debug("Event: |cff3333ff"..e.."|r")
	
-- 	local timer = GetTime() -- timer
	info = compost:Acquire()
-- 	ctimer.acquire = GetTime() - timer + ctimer.acquire -- timer
	
	if self:ParseMessage(a1, e, info) then
		
-- 		currTime = GetTime() -- timer
		self:NotifyClients(e, info)
-- 		self.time.notify = self.time.notify + GetTime() - currTime -- timer
				
	end
	
-- 	local timer = GetTime() -- timer
	compost:Reclaim(info)
-- 	ctimer.reclaim = GetTime() - timer + ctimer.reclaim -- timer

end

function lib:NotifyClients(event, info)

-- 	local timer = GetTime() -- timer
	local infoBackup = compost:Acquire()	
-- 	ctimer.acquire = GetTime() - timer + ctimer.acquire -- timer

	-- Backup info, because clients may modify it.
	for i in info do
		infoBackup[i] = info[i]
	end
	

	if not self.clients[event] then 
		self:Debug(event .. " has no client to notify.")
		return 
	end
	
	for i in self.clients[event] do
	
		self:Debug(event .. ",Calling " .. self.clients[event][i].id)
		local func = self.clients[event][i].func

		func(event, info)
		
-- --		local timer = GetTime()	 -- timer
		info = compost:Recycle(info) 
-- 		ctimer.recycle = GetTime() - timer + ctimer.recycle -- timer
		
		-- Copy back old info
		for j in infoBackup do
			info[j] = infoBackup[j]
		end
			
			
	end
	
-- 	timer = GetTime() -- timer
	compost:Reclaim(infoBackup)
-- 	ctimer.reclaim = GetTime() - timer + ctimer.reclaim -- timer

end


function lib:Print(msg, r, g, b)	
	ChatFrame1:AddMessage(string.format("<%s-%s-%s> %s", libvarname, vmajor, vminor, msg), r, g, b)
end

function lib:Debug(msg, r, g, b)
	if self.debug then
		ChatFrame1:AddMessage(string.format("<%s-%s-%s>(Debug) %s", libvarname, vmajor, vminor, msg), r, g, b)
	end
end


-- message : the arg1 in the event
-- event : name says it all.
-- info : the table which will store the passed result, so THIS IS THE OUTPUT.
-- return : true if pattern found and parsed, nil otherwise.
function lib:ParseMessage(message, event, info)

	local currTime
	
-- 	currTime = GetTime() -- timer
	if not self.eventTable[event] then self.eventTable[event] = self:LoadPatternList(event) end
	local list = self.eventTable[event] --:LoadPatternList(event)
-- 	self.time.list = self.time.list + GetTime() - currTime -- timer
	
	if not list then return end
	
-- 	currTime = GetTime() -- timer
	local pattern = self:FindPattern(message, list, info)
-- 	self.time.find = GetTime() - currTime + self.time.find -- timer

	
	if not pattern then 
		self:Print(message .. " -> not found in event " .. event, 1, 0.3, 0.3)
		return false 
	end
	
-- 	currTime = GetTime() -- timer
	self:ParseInformation(pattern, info)
-- 	self.time.parse = GetTime() - currTime + self.time.parse -- timer
	
	
-- 	currTime = GetTime() -- timer
	if info.type == "hit" or info.type == "environment" then
		self:ParseTrailers(message, info)
	end
-- 	self.time.trailer = GetTime() - currTime + self.time.trailer -- timer
	
	self:ConvertTypes(info)

	return true

	
end

-- Search for pattern in 'patternList' which matches 'message', parsed tokens will be stored in 'info'
function lib:FindPattern(message, patternList, info)
	
	local pattern, patternName, found, n

	local n = table.getn(patternList)
	for i=1, n do
	
		patternName = patternList[i]
		
-- 		timer = GetTime() -- timer
		if not self.patternTable[patternName] then self.patternTable[patternName] = self:LoadPatternInfo(patternName) end
-- 		self.time.LoadPatternInfo = GetTime() - timer + self.time.LoadPatternInfo -- timer
		
		if not self.patternTable[patternName] then
			self:Print(patternName .. " cannot be found in the pattern table.", 1, 0, 0)
			return
		end

-- 		timer = GetTime() -- timer
		info = compost:Recycle(info)
-- 		ctimer.recycle = GetTime() - timer + ctimer.recycle -- timer
		
		pattern = self.patternTable[patternName].pattern
		n = self.patternTable[patternName].tc
		found = false
		if self:OptimizerCheck(message, patternName) then
			if n == 0 then
				found = string.find(message, pattern)
			elseif n == 1 then
				found, _, info[1] = string.find(message, pattern)
			elseif n == 2 then
				found, _, info[1], info[2] = string.find(message, pattern)
			elseif n == 3 then
				found, _, info[1], info[2], info[3]= string.find(message, pattern)
			elseif n == 4 then
				found, _, info[1], info[2], info[3], info[4] = string.find(message, pattern)
			elseif n == 5 then
				found, _, info[1], info[2], info[3], info[4], info[5] = string.find(message, pattern)
			elseif n == 6 then
				found, _, info[1], info[2], info[3], info[4], info[5], info[6] = string.find(message, pattern)
			elseif n == 7 then
				found, _, info[1], info[2], info[3], info[4], info[5], info[6], info[7] = string.find(message, pattern)
			elseif n == 8 then
				found, _, info[1], info[2], info[3], info[4], info[5], info[6], info[7], info[8] = string.find(message, pattern)
			elseif n == 9 then
				found, _, info[1], info[2], info[3], info[4], info[5], info[6], info[7], info[8], info[9] = string.find(message, pattern)
			end
				
				
--			found, _, info[1], info[2], info[3], info[4], info[5], info[6], info[7], info[8] = string.find(message, pattern)
		end
		if found then
			self:Debug(message.." -> |cff3333ff" .. self.patternTable[patternName].pattern .. "|r")
			return patternName				
		end
	end	
end


-- Parses for trailors.
function lib:ParseTrailers(message, info)
	local found, amount
	
	
	if not self.trailers then 
		self.trailers = {
			CRUSHING_TRAILER = self:ConvertPattern(CRUSHING_TRAILER),
			GLANCING_TRAILER = self:ConvertPattern(GLANCING_TRAILER),
			ABSORB_TRAILER = self:ConvertPattern(ABSORB_TRAILER),
			BLOCK_TRAILER = self:ConvertPattern(BLOCK_TRAILER),
			RESIST_TRAILER = self:ConvertPattern(RESIST_TRAILER),
			VULNERABLE_TRAILER = self:ConvertPattern(VULNERABLE_TRAILER),
		}
	end
	
	found = string.find(message, self.trailers.CRUSHING_TRAILER)
	if found then 
		info.isCrushing = true
	end
	found = string.find(message, self.trailers.GLANCING_TRAILER)
	if found then 
		info.isGlancing = true
	end
	found, _, amount = string.find(message, self.trailers.ABSORB_TRAILER)
	if found then 
		info.amountAbsorb = amount
	end
	found, _, amount = string.find(message, self.trailers.BLOCK_TRAILER)
	if found then 
		info.amountBlock = amount
	end
	found, _, amount = string.find(message, self.trailers.RESIST_TRAILER)
	if found then 
		info.amountResist = amount
	end
	found, _, amount = string.find(message, self.trailers.VULNERABLE_TRAILER)
	if found then 
		info.amountVulnerable = amount
	end

end
	


function lib:ParseInformation(patternName, info)

	-- Create an info table from pattern table, copies everything except the pattern string.
	for i, v in self.patternTable[patternName] do	
		if i ~= "pattern" and i ~= 'tc' then
			if type(v) == "number" and v < 100 then
				info[i] = info[v]				
			else
				info[i] = v
			end
		end
	end
	
	
	for i in ipairs(info) do
		info[i] = nil
	end
	
end

function lib:ConvertTypes(info)
	for i in info do
		if string.find(i, "^amount") then info[i] = tonumber(info[i]) end
	end
end

function lib:OptimizerCheck(message, patternName)

	if not ParserLibOptimizer then return true end
	
	if not ParserLibOptimizer[patternName] then return true end
	
	if string.find(message, ParserLibOptimizer[patternName], 1, true) then return true end
	
	return false
end


-- Most of the parts were learnt from BabbleLib by chknight, so credits goes to him.
function lib:Curry(pattern)
	local cp, tt, n, f, o
	local DoNothing = function(tok) return tok end	
	
	tt = {}
	for tk in string.gfind(pattern, "%%%d?%$?([sd])") do
		table.insert(tt, tk)
	end	
	
	cp = { self:ConvertPattern(pattern, true) }
	cp.p = cp[1]
	
	n = table.getn(cp)
	for i=1,n-1 do
		cp[i] = cp[i+1]
	end
	table.remove(cp, n)
	
	f = {}
	o = {}
	n = table.getn(tt)
	for i=1, n do
		if tt[i] == "s" then
			f[i] = DoNothing
		else
			f[i] = tonumber
		end
	end

	if not cp[1] then
		if n == 0 then
			return function() end
		elseif n == 1 then
			return function(text)
				_, _, o[1] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1])
				end
			end
		elseif n == 2 then
			return function(text)
				_, _, o[1], o[2]= string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2])
				end
			end
		elseif n == 3 then
			return function(text)
				_, _, o[1], o[2], o[3] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2]), f[3](o[3])
				end
			end
		elseif n == 4 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2]), f[3](o[3]), f[4](o[4])
				end
			end
		elseif n == 5 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2]), f[3](o[3]), f[4](o[4]), f[5](o[5])
				end
			end
		elseif n == 6 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2]), f[3](o[3]), f[4](o[4]), f[5](o[5]), f[6](o[6])
				end
			end
		elseif n == 7 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6], o[7] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2]), f[3](o[3]), f[4](o[4]), f[5](o[5]), f[6](o[6]), f[7](o[7])
				end
			end
		elseif n == 8 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2]), f[3](o[3]), f[4](o[4]), f[5](o[5]), f[6](o[6]), f[7](o[7]), f[8](o[8])
				end
			end
		elseif n == 9 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8], o[9] = string.find(text, cp.p)
				if o[1] then
					return f[1](o[1]), f[2](o[2]), f[3](o[3]), f[4](o[4]), f[5](o[5]), f[6](o[6]), f[7](o[7]), f[8](o[8]), f[9](o[9])
				end
			end
		end
	else	
		if n == 0 then
			return function() end
		elseif n == 1 then
			return function(text)
				_, _, o[1] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]])
				end
			end				elseif n == 2 then
			return function(text)
				_, _, o[1], o[2] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]])
				end
			end				elseif n == 3 then
			return function(text)
				_, _, o[1], o[2], o[3] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]]), f[cp[3]](o[cp[3]])
				end
			end		
		elseif n == 4 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]]), f[cp[3]](o[cp[3]]), f[cp[4]](o[cp[4]])
				end
			end				elseif n == 5 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]]), f[cp[3]](o[cp[3]]), f[cp[4]](o[cp[4]]), f[cp[5]](o[cp[5]])
				end
			end				elseif n == 6 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]]), f[cp[3]](o[cp[3]]), f[cp[4]](o[cp[4]]), f[cp[5]](o[cp[5]]), f[cp[6]](o[cp[6]])
				end
			end				elseif n == 7 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6], o[7] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]]), f[cp[3]](o[cp[3]]), f[cp[4]](o[cp[4]]), f[cp[5]](o[cp[5]]), f[cp[6]](o[cp[6]]), f[cp[7]](o[cp[7]])
				end
			end				elseif n == 8 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]]), f[cp[3]](o[cp[3]]), f[cp[4]](o[cp[4]]), f[cp[5]](o[cp[5]]), f[cp[6]](o[cp[6]]), f[cp[7]](o[cp[7]]), f[cp[8]](o[cp[8]])
				end
			end				elseif n == 9 then
			return function(text)
				_, _, o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8], o[9] = string.find(text, cp.p)
				if o[1] then
					return f[cp[1]](o[cp[1]]), f[cp[2]](o[cp[2]]), f[cp[3]](o[cp[3]]), f[cp[4]](o[cp[4]]), f[cp[5]](o[cp[5]]), f[cp[6]](o[cp[6]]), f[cp[7]](o[cp[7]]), f[cp[8]](o[cp[8]]), f[cp[9]](o[cp[9]])
				end
			end		
		end		
	end
end


-- Used to test the correcteness of ParserLib on different languages.
function lib:TestPatterns(sendToClients)
	
	self:LoadEverything()
	
	
	-- Check for valid variable types.
	local pattern
	local cnt = 1
	for i, v in self.patternTable do
		pattern = getglobal(i)
		cnt = 1
		for tok in string.gfind(pattern, "%%%d?%$?([sd])") do
			for j, w in v do
				if j ~= "tc"
				and w == cnt 
				and ( (	string.find(j, "^amount") and tok ~= "d" )
				or ( not string.find(j, "^amount") and tok == "d") )then
					self:Print(pattern..","..j..","..cnt..","..tok)
				end
			end
			cnt = cnt+1
		end
	end
	
	
	
	
	
	-- Creating the combat messages.	
	local messages = compost:Acquire();	
	for patternName in self.patternTable do		
		messages[patternName] = getglobal(patternName)
	end
	
	local testString = "<s>";
	local testNumber = "123";

	for i in messages do
		messages[i] = string.gsub(messages[i], "%%%d?%$?s", testString); 
		messages[i] = string.gsub(messages[i], "%%%d?%$?d", testNumber);	
	end	
	


	-- Begin the test.
	
	testNumber = tonumber(testNumber)
-- 	local timer = GetTime() -- timer
	local info = compost:Acquire()
-- 	ctimer.acquire = GetTime() - timer + ctimer.acquire -- timer

	local startTime = GetTime() 
	local startMem = gcinfo()

	for _, event in self.supportedEvents do

		for _, pattern in self:LoadPatternList(event) do
		
			local msg = messages[pattern]
			
			if sendToClients then self:OnEvent(event, msg)	end
			
			if self:ParseMessage(msg, event, info) then

				for i, v in info do
				
					if type(i) ~= "number" then
						if type(v) == "number" and ( v == ParserLib_SELF or v == ParserLib_MELEE or v == ParserLib_DAMAGESHIELD ) then
							v = testString
						end
						
						if i == "type" or i == "missType"  or i == "damageType" then v = testString end					
						
						if ( type(v) == "string" and v ~= testString )
						or ( type(v) == "number" and v ~= testNumber )
						then
							self:Print(string.format("E[%s],M[%s],[%s]=[%s]", event, msg, i, v), 1, 0.3, 0)
						end
					end
				end
			end
			
			info = compost:Recycle(info)

		end
	end

	
	self:Print( string.format("Test completed in %.4fs, memory cost %.2fKB.", GetTime() - startTime, gcinfo() - startMem) )

	-- Cleaning up.
	compost:Reclaim(info)
	compost:Reclaim(messages)
	
end

-- Not working.
function lib:TestDeformat()
	
	self:LoadEverything()
	
	
	-- Creating the combat messages.
	
	local messages = compost:Acquire();	
	for patternName in self.patternTable do		
		messages[patternName] = getglobal(patternName)
	end
	
	local testString = "<s>";
	local testNumber = "123";

	for i in messages do
		messages[i] = string.gsub(messages[i], "%%%d?%$?s", testString); 
		messages[i] = string.gsub(messages[i], "%%%d?%$?d", testNumber);	
	end	
	


	-- Begin the test.
	local o = compost:Acquire()
	local tt = compost:Acquire()
	
	testNumber = tonumber(testNumber)

	local startTime = GetTime() 
	local startMem = gcinfo()

	for _, event in self.supportedEvents do

		for _, pattern in self:LoadPatternList(event) do
		

			for i, v in self.patternTable[pattern] do
				if i ~= 'pattern' and i ~= 'tc' then
					if string.find(i, "^amount") then
						tt[v] = "number"
					else
						tt[v] = "string"
					end
				end
			end
		
			local msg = messages[pattern]
			
			o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8], o[9] = self:Deformat(msg, getglobal(pattern))
			for i=1, self.patternTable[pattern].tc do
				if type(o[i]) ~= tt[i] 
				or ( type(o[i]) == "string" and not o[i] == testString)	
				or ( type(o[i]) == "number" and not o[i] == testNumber) then
					self:Print(string.format("E[%s],M[%s],[%s]=%s (%s)", event, msg, o[i], type(o[i]), tt[i]), 1, 0.3, 0)
					PrintTable(o)
					PrintTable(tt)
					print(pattern)
					PrintTable(self.patternTable[pattern])
				end
			end
			compost:Recycle(o)
			compost:Recycle(tt)

		end
	end

	
	self:Print( string.format("Test completed in %.4fs, memory cost %.2fKB.", GetTime() - startTime, gcinfo() - startMem) )

	-- Cleaning up.
--	compost:Reclaim(info)
	compost:Reclaim(messages)
	
end

function lib:LoadEverything()

	-- Load all patterns and events.
	for _, v in self.supportedEvents do	
		for _, w in self:LoadPatternList(v) do
			if not self.patternTable[w] then
				self.patternTable[w] = self:LoadPatternInfo(w)
			end
		end
	end
	
end



-- Used to load patternTable elements on demand.
function lib:LoadPatternInfo(patternName)

	local patternInfo
	
	-- DebuffOther
	if patternName == "AURAADDEDOTHERHARMFUL" then patternInfo = { -- %s is afflicted by %s."; -- Combat log text for aura even
		type = "debuff",
		victim = 1,
		skill = 2
	}
	elseif patternName == "AURAAPPLICATIONADDEDOTHERHARMFUL" then patternInfo = { -- %s is afflicted by %s (%d).
		type = "debuff",
		victim = 1,
		skill = 2,
		amountRank = 3,
	}

	
	-- DebuffSelf
	elseif patternName == "AURAADDEDSELFHARMFUL" then patternInfo = { -- You are afflicted by %s."; -- Combat log text for aura even
		type = "debuff",
		victim = ParserLib_SELF,
		skill = 1,
	}
	elseif patternName == "AURAAPPLICATIONADDEDSELFHARMFUL" then patternInfo = { -- You are afflicted by %s (%d).
		type = "debuff",
		victim = ParserLib_SELF,
		skill = 1,
		amountRank = 2,
	}

	-- BuffOther
	elseif patternName == "AURAADDEDOTHERHELPFUL" then patternInfo = { -- %s gains %s."; -- Combat log text for aura even
		type = "buff",
		victim = 1,
		skill = 2,		
	}
	elseif patternName == "AURAAPPLICATIONADDEDOTHERHELPFUL" then patternInfo = { -- %s gains %s (%d).
		type = "buff",
		victim = 1,
		skill = 2,
		amountRank = 3,
	}

	-- BuffSelf
	elseif patternName == "AURAADDEDSELFHELPFUL" then patternInfo = { -- You gain %s."; -- Combat log text for aura even
		type = "buff",
		victim = ParserLib_SELF,
		skill = 1,
	}
	elseif patternName == "AURAAPPLICATIONADDEDSELFHELPFUL" then patternInfo = { -- You gain %s (%d).
		type  = "buff",
		victim = ParserLib_SELF,
		skill = 1,
		amountRank = 2,
	}

	-- AuraDispell
	elseif patternName == "AURADISPELOTHER" then patternInfo = { -- %s's %s is removed.
		type = "dispel",
		victim = 1,
		skill = 2,		
	}
	elseif patternName == "AURADISPELSELF" then patternInfo = { -- Your %s is removed.
		type = "dispel",
		victim = ParserLib_SELF,
		skill = 1,		
	}

	-- Fade
	elseif patternName == "AURAREMOVEDOTHER" then patternInfo = { -- %s fades from %s."; -- Combat log text for aura even
		type = "fade",
		victim = 2,
		skill = 1,		
	}
	elseif patternName == "AURAREMOVEDSELF" then patternInfo = { -- %s fades from you."; -- Combat log text for aura even
		type = "fade",
		victim = ParserLib_SELF,
		skill = 1,		
	}

	
	-- HitOther
	elseif patternName == "COMBATHITCRITOTHEROTHER" then patternInfo = {	-- %s crits %s for %d.
		type = "hit",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		amount = 3,
		isCrit = true,
	}
	elseif patternName == "COMBATHITCRITOTHERSELF" then patternInfo = { -- %s crits you for %d.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		amount = 2,
		isCrit = true,		
	}
	elseif patternName == "COMBATHITCRITSCHOOLOTHEROTHER" then patternInfo = { -- %s crits %s for %d %s damage.
		type = "hit",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		amount = 3,
		element = 4,
		isCrit = true
	}
	elseif patternName == "COMBATHITCRITSCHOOLOTHERSELF" then patternInfo = { -- %s crits you for %d %s damage.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		amount = 2,
		element = 3,
		isCrit = true	
	}
	elseif patternName == "COMBATHITOTHEROTHER" then patternInfo = { -- %s hits %s for %d.
		type = "hit",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		amount = 3,
	}
	elseif patternName == "COMBATHITOTHERSELF" then patternInfo = { -- %s hits you for %d.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		amount = 2,		
	}
	elseif patternName == "COMBATHITSCHOOLOTHEROTHER" then patternInfo = { -- %s hits %s for %d %s damage.
		type = "hit",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		amount = 3,
		element = 4
	}
	elseif patternName == "COMBATHITSCHOOLOTHERSELF" then patternInfo = { -- %s hits you for %d %s damage.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		amount = 2,
		element = 3
	}

	-- HitSelf
	elseif patternName == "COMBATHITSCHOOLSELFOTHER" then patternInfo = { -- You hit %s for %d %s damage.
		type = "hit",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		amount = 2,
		element = 3
	}
	elseif patternName == "COMBATHITSELFOTHER" then patternInfo = { -- You hit %s for %d.
		type = "hit",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		amount = 2,	
	}
	elseif patternName == "COMBATHITCRITSCHOOLSELFOTHER" then patternInfo = { -- You crit %s for %d %s damage.
		type = "hit",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		amount = 2,
		element = 3,
		isCrit = true	
	}
	elseif patternName == "COMBATHITCRITSELFOTHER" then patternInfo = { -- You crit %s for %d.
		type = "hit",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		amount = 2,
		isCrit = true,	
	}

	-- Honor
	elseif patternName == "COMBATLOG_DISHONORGAIN" then patternInfo = { -- %s dies, dishonorable kill.
		type = "honor",	
		source = 1,
		isDishonor = true
	}
	elseif patternName == "COMBATLOG_HONORAWARD" then patternInfo = { -- You have been awarded %d honor points.
		type = "honor",	
		amount = 1,
	}
	elseif patternName == "COMBATLOG_HONORGAIN" then patternInfo = { -- "%s dies, honorable kill Rank: %s (Estimated Honor Points: %d)";
		type = "honor",
		source = 1,
		sourceRank = 2,
		amount = 3,
		
	}
	elseif patternName == "COMBATLOG_XPGAIN" then patternInfo = { -- %s gains %d experience.
		type = "experience",
		amount = 2,	
		victim = 1,
	}

	
	-- Exp
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION1" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s bonus)
		type = "experience",
		amount = 2,	
		source = 1,
		bonusAmount = 3,
		bonusType = 4,
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION1_GROUP" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)
		type = "experience",
		amount = 2,	
		source = 1,
		bonusAmount = 3,
		bonusType = 4,
		amountGroupBonus = 5	
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION1_RAID" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s bonus, -%d raid penalty)
		type = "experience",
		amount = 2,	
		source = 1,
		bonusAmount = 3,
		bonusType = 4,
		amountRaidPenalty = 5
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION2" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s bonus)
		type = "experience",
		amount = 2,	
		source = 1,
		bonusAmount = 3,
		bonusType = 4,
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION2_GROUP" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)
		type = "experience",
		amount = 2,	
		source = 1,
		bonusAmount = 3,
		bonusType = 4,
		amountGroupBonus = 5	
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION2_RAID" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s bonus, -%d raid penalty)
		type = "experience",
		amount = 2,	
		source = 1,
		bonusAmount = 3,
		bonusType = 4,
		amountRaidPenalty = 5
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION4" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s penalty)
		type = "experience",
		amount = 2,	
		source = 1,
		penaltyAmount = 3,
		penaltyType = 4,
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION4_GROUP" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s penalty, +%d group bonus)
		type = "experience",
		amount = 2,	
		source = 1,
		penaltyAmount = 3,
		penaltyType = 4,
		amountGroupBonus = 5
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION4_RAID" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s penalty, -%d raid penalty)
		type = "experience",
		amount = 2,	
		source = 1,
		penaltyAmount = 3,
		penaltyType = 4,
		amountGroupBonus = 5
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION5" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s penalty)
		type = "experience",
		amount = 2,	
		source = 1,
		penaltyAmount = 3,
		penaltyType = 4,
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION5_GROUP" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s penalty, +%d group bonus)
		type = "experience",
		amount = 2,	
		source = 1,
		penaltyAmount = 3,
		penaltyType = 4,
		amountGroupBonus = 5
	}
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION5_RAID" then patternInfo = { -- %s dies, you gain %d experience. (%s exp %s penalty, -%d raid penalty)
		type = "experience",
		amount = 2,	
		source = 1,
		penaltyAmount = 3,
		penaltyType = 4,
		amountRaidPenalty = 5
	}
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON" then patternInfo = { -- %s dies, you gain %d experience.
		type = "experience",
		amount = 2,
		source = 1,
	}
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_GROUP" then patternInfo = { -- %s dies, you gain %d experience. (+%d group bonus)
		type = "experience",
		amount = 2,	
		source = 1,
		amountGroupBonus = 3
	}
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_RAID" then patternInfo = { -- %s dies, you gain %d experience. (-%d raid penalty)
		type = "experience",
		amount = 2,		
		source = 1,
		amountRaidPenalty = 3
	}
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED" then patternInfo = { -- You gain %d experience.
		type = "experience",
		amount = 1,		
	}
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_GROUP" then patternInfo = { -- You gain %d experience. (+%d group bonus)
		type = "experience",
		amount = 1,
		amountGroupBonus = 2
	}
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_RAID" then patternInfo = { -- You gain %d experience. (-%d raid penalty)
		type = "experience",
		amount = 1,
		amountRaidPenalty = 2
	}
	elseif patternName == "COMBATLOG_XPLOSS_FIRSTPERSON_UNNAMED" then patternInfo = { -- You lose %d experience.
		type = "experience",
		amount = 1,
		isNegative = true
	}


	-- DmgShieldOther
	elseif patternName == "DAMAGESHIELDOTHEROTHER" then patternInfo = { -- %s reflects %d %s damage to %s.
		type = "hit",
		source = 1,
		victim = 4,
		skill = ParserLib_DAMAGESHIELD,
		amount = 2,
		element = 3,
	}
	elseif patternName == "DAMAGESHIELDOTHERSELF" then patternInfo = { -- %s reflects %d %s damage to you.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_DAMAGESHIELD,
		amount = 2,
		element = 3,	
	}

	-- DmgShieldSelf
	elseif patternName == "DAMAGESHIELDSELFOTHER" then patternInfo = { -- You reflect %d %s damage to %s.
		type = "hit",
		source = ParserLib_SELF,
		victim = 3,
		skill = ParserLib_DAMAGESHIELD,
		amount = 1,
		element = 2,		
	}
	
	-- DispellFailOther
	elseif patternName == "DISPELFAILEDOTHEROTHER" then patternInfo = { -- %s fails to dispel %s's %s.
		type = "dispel",
		source = 1,
		victim = 2,
		skill = 3,
		isFailed = true
	}
	elseif patternName == "DISPELFAILEDOTHERSELF" then patternInfo = { -- %s fails to dispel your %s.
		type = "dispel",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		isFailed = true
	}

	-- DispellFailSelf
	elseif patternName == "DISPELFAILEDSELFOTHER" then patternInfo = { -- You fail to dispel %s's %s.
		type = "dispel",
		source = ParserLib_SELF,
		victim = 1,
		skill = 2,
		isFailed = true
	}
	
	-- WoW 1.11 new pattern.
	elseif patternName == "DISPELFAILEDSELFSELF" then patternInfo = { -- You fail to dispel your %s.
		type = "dispel",
		source = ParserLib_SELF,
		victim = ParserLb_SELF,
		skill = 1,
		isFailed = true
	}

	--[[   Seems no longer used
	elseif patternName == "DISPELLEDOTHEROTHER" then patternInfo = { -- %s casts %s on %s.
		type = "dispel",
		source = 1,
		victim = 3,
		skill = 2
	}
	elseif patternName == "DISPELLEDOTHERSELF" then patternInfo = { -- %s casts %s on you.
		type = "dispel",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2
	}
	elseif patternName == "DISPELLEDSELFOTHER" then patternInfo = { -- You cast %s on %s.
		type = "dispel",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1
	}
	elseif patternName == "DISPELLEDSELFSELF" then patternInfo = { -- You cast %s.
		type = "dispel",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1
	}
]]
	
	-- Rep
	elseif patternName == "FACTION_STANDING_CHANGED" then patternInfo = { -- You are now %s with %s.
		type = "reputation",
		rank = 1,
		faction = 2
	}
	
	-- These will be removed in WoW 1.11.
	elseif patternName == "FACTION_STANDING_DECREASED2" then patternInfo = { -- Your reputation with %s has slightly decreased. (%d reputation lost)
		type = "reputation",
		faction = 1,
		amount = 2,
		isNegative = true
	}
	elseif patternName == "FACTION_STANDING_DECREASED4" then patternInfo = { -- Your reputation with %s has greatly decreased. (%d reputation lost)
		type = "reputation",
		faction = 1,
		amount = 2,
		isNegative = true,
	}
	elseif patternName == "FACTION_STANDING_DECREASED3" then patternInfo = { -- Your reputation with %s has decreased. (%d reputation lost)
		type = "reputation",
		faction = 1,
		amount = 2,
		isNegative = true,
	}
	elseif patternName == "FACTION_STANDING_DECREASED1" then patternInfo = { -- Your reputation with %s has very slightly decreased. (%d reputation lost)
		type = "reputation",
		faction = 1,
		amount = 2,
		isNegative = true,
	}
	elseif patternName == "FACTION_STANDING_INCREASED1" then patternInfo = { -- Your reputation with %s has very slightly increased. (%d reputation gained)
		type = "reputation",
		faction = 1,
		amount = 2,
	}
	elseif patternName == "FACTION_STANDING_INCREASED2" then patternInfo = { -- Your reputation with %s has slightly increased. (%d reputation gained)
		type = "reputation",
		faction = 1,
		amount = 2,
	}
	elseif patternName == "FACTION_STANDING_INCREASED3" then patternInfo = { -- Your reputation with %s has increased. (%d reputation gained)
		type = "reputation",
		faction = 1,
		amount = 2,
	}
	elseif patternName == "FACTION_STANDING_INCREASED4" then patternInfo = { -- Your reputation with %s has greatly increased. (%d reputation gained)
		type = "reputation",
		faction = 1,
		amount = 2,
	}
	
	-- These 2 are WoW 1.11 new  patterns.
	elseif patternName == "FACTION_STANDING_DECREASED" then patternInfo = { -- "Your %s reputation has decreased by %d.";
		type = "reputation",
		faction = 1,
		amount = 2,
		isNegative = true,
	}
	elseif patternName == "FACTION_STANDING_INCREASED" then patternInfo = { -- "Your %s reputation has increased by %d.";
		type = "reputation",
		faction = 1,
		amount = 2,	
	}
	
	
	elseif patternName == "FEEDPET_LOG_FIRSTPERSON" then patternInfo = { -- Your pet begins eating the %s.
		type = "feedpet",
		victim = ParserLib_SELF,
		item = 1
	}
	elseif patternName == "FEEDPET_LOG_THIRDPERSON" then patternInfo = { -- %s's pet begins eating a %s."
		type = "feedpet",
		victim = 1,
		item = 2
	}

	-- HealOther
	elseif patternName == "HEALEDCRITOTHEROTHER" then patternInfo = { -- %s's %s critically heals %s for %d.
		type = "heal",
		source = 1,
		victim = 3,
		skill = 2,
		amount = 4,
		isCrit = true,
	}
	elseif patternName == "HEALEDCRITOTHERSELF" then patternInfo = { -- %s's %s critically heals you for %d.
		type = "heal",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
		isCrit = true,
	}
	elseif patternName == "HEALEDOTHEROTHER" then patternInfo = { -- %s's %s heals %s for %d.
		type = "heal",
		source = 1,
		victim = 3,
		skill = 2,
		amount = 4,
	}
	elseif patternName == "HEALEDOTHERSELF" then patternInfo = { -- %s's %s heals you for %d.
		type = "heal",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
	}

	-- HealSelf
	elseif patternName == "HEALEDCRITSELFOTHER" then patternInfo = { -- Your %s critically heals %s for %d.
		type = "heal",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		amount = 3,
		isCrit = true,
	}
	elseif patternName == "HEALEDCRITSELFSELF" then patternInfo = { -- Your %s critically heals you for %d.
		type = "heal",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		amount = 2,
		isCrit = true,
	}
	elseif patternName == "HEALEDSELFOTHER" then patternInfo = { -- Your %s heals %s for %d.
		type = "heal",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		amount = 3,
	}
	elseif patternName == "HEALEDSELFSELF" then patternInfo = { -- Your %s heals you for %d.
		type = "heal",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		amount = 2,
	}

	--[[
	elseif patternName == "IMMUNEDAMAGECLASSOTHEROTHER" then patternInfo = { -- %s is immune to %s's %s damage.
		type = "miss",
		source = 2,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "immune",
		element = 3
	}
	elseif patternName == "IMMUNEDAMAGECLASSOTHERSELF" then patternInfo = { -- You are immune to %s's %s damage.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "immune",
		element = 2
	}
	elseif patternName == "IMMUNEDAMAGECLASSSELFOTHER" then patternInfo = { -- %s is immune to your %s damage.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "immune",
		element = 2
	}
	elseif patternName == "IMMUNEOTHEROTHER" then patternInfo = { -- %s hits %s, who is  immune.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "immune",
	}
	elseif patternName == "IMMUNEOTHERSELF" then patternInfo = { -- %s hits you, but you are immune.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "immune",
	}	
	elseif patternName == "IMMUNESELFOTHER" then patternInfo = { -- You hit %s, who is immune.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "immune",
	}
	elseif patternName == "IMMUNESELFSELF" then patternInfo = { -- You hit yourself, but you are immune.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "immune",
	}
	]]




	-- EnchantOther
	elseif patternName == "ITEMENCHANTMENTADDOTHEROTHER" then patternInfo = { -- %s casts %s on %s's %s.
		type = "enchant",
		source = 1,
		victim = 3,
		skill = 2,
		item = 4		
	}	
	elseif patternName == "ITEMENCHANTMENTADDOTHERSELF" then patternInfo = { -- %s casts %s on your %s.
		type = "enchant",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		item = 3		
	}

	-- EnchantSelf
	elseif patternName == "ITEMENCHANTMENTADDSELFOTHER" then patternInfo = { -- You cast %s on %s's %s.
		type = "enchant",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		item = 3	
	}
	elseif patternName == "ITEMENCHANTMENTADDSELFSELF" then patternInfo = { -- You cast %s on your %s.
		type = "enchant",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		item = 2
	}
--[[
	elseif patternName == "ITEMENCHANTMENTREMOVEOTHER" then patternInfo = { -- %s has faded from %s's %s.
		type = "enchant",
		victim = 2,
		skill = 1,
		item = 3,
		isFade = true
	}
	elseif patternName == "ITEMENCHANTMENTREMOVESELF" then patternInfo = { -- %s has faded from your %s.
		type = "enchant",
		victim = ParserLib_SELF,
		skill = 1,
		item = 2,
		isFade = true
	}
]]

	

	elseif patternName == "PARTYKILLOTHER" then patternInfo = { -- %s is slain by %s!
		type = "death",
		source = 2,
		victim = 1,		
	}
	
	-- WoW 1.11 Pattern.
	elseif patternName == "SELFKILLOTHER" then patternInfo = { -- "You have slain %s!";
		type = "death",
		source = ParserLib_SELF,
		victim = 1,
	}

	-- DotOther
	elseif patternName == "PERIODICAURADAMAGEOTHEROTHER" then patternInfo = { -- %s suffers %d %s damage from %s's %s.
		type = "hit",
		source = 4,
		victim = 1,
		skill = 5,
		amount = 2,
		element = 3,
		isDOT = true,
	}
	elseif patternName == "PERIODICAURADAMAGEOTHERSELF" then patternInfo = { -- You suffer %d %s damage from %s's %s.
		type = "hit",
		source = 3,
		victim = ParserLib_SELF,
		skill = 4,
		amount = 1,
		element = 2,
		isDOT = true,
	}

	-- DotSelf
	elseif patternName == "PERIODICAURADAMAGESELFOTHER" then patternInfo = { -- %s suffers %d %s damage from your %s.
		type = "hit",
		source = ParserLib_SELF,
		victim = 1,
		skill = 4,
		amount = 2,
		element = 3,
		isDOT = true,
	}
	elseif patternName == "PERIODICAURADAMAGESELFSELF" then patternInfo = { -- You suffer %d %s damage from your %s.
		type = "hit",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 3,
		amount = 1,
		element = 2,
		isDOT = true,
	}

	-- HotOther
	elseif patternName == "PERIODICAURAHEALOTHEROTHER" then patternInfo = { -- %s gains %d health from %s's %s.
		type = "heal",
		source = 3,
		victim = 1,
		skill = 4,
		amount = 2,
		isDOT = true,
	}
	elseif patternName == "PERIODICAURAHEALOTHERSELF" then patternInfo = { -- You gain %d health from %s's %s.
		type = "heal",
		source = 2,
		victim = ParserLib_SELF,
		skill = 3,
		amount = 1,
		isDOT = true,
	}
	-- HotSelf
	elseif patternName == "PERIODICAURAHEALSELFOTHER" then patternInfo = { -- %s gains %d health from your %s.
		type = "heal",
		source = ParserLib_SELF,
		victim = 1,
		skill = 3,
		amount = 2,
		isDOT = true,
	}
	elseif patternName == "PERIODICAURAHEALSELFSELF" then patternInfo = { -- You gain %d health from %s.
		type = "heal",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 1,
		isDOT = true,
	}

	
	-- PowerGainOther
	elseif patternName == "POWERGAINOTHEROTHER" then patternInfo = { -- %s gains %d %s from %s's %s.
		type = "gain",
		source = 4,
		victim = 1,
		skill = 5,
		amount = 2,
		attribute = 3,
	}
	elseif patternName == "POWERGAINOTHERSELF" then patternInfo = { -- You gain %d %s from %s's %s.
		type = "gain",
		source = 3,
		victim = ParserLib_SELF,
		skill = 4,
		amount = 1,
		attribute = 2,	
	}

	-- PowerGainSelf
	elseif patternName == "POWERGAINSELFOTHER" then patternInfo = { -- %s gains %d %s from %s.
		type = "gain",
		source = ParserLib_SELF,
		victim = 1,
		skill = 4,
		amount = 2,
		attribute = 3,	
	}
	elseif patternName == "POWERGAINSELFSELF" then patternInfo = { -- You gain %d %s from %s.
		type = "gain",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 3,
		amount = 1,
		attribute = 2,	
	}

	-- ProcResistOther
	elseif patternName == "PROCRESISTOTHEROTHER" then patternInfo = { -- %s resists %s's %s.
		type = "miss",
		source = 2,
		victim = 1,
		skill = 3,
		missType =  "resist",
		isProc = true,
	}
	elseif patternName == "PROCRESISTOTHERSELF" then patternInfo = { -- You resist %s's %s.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "resist",
		isProc = true,
	}

	-- ProcResistSelf
	elseif patternName == "PROCRESISTSELFOTHER" then patternInfo = { -- %s resists your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = 2,
		missType =  "resist",
		isProc = true,
	}
	elseif patternName == "PROCRESISTSELFSELF" then patternInfo = { -- You resist your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "resist",
		isProc = true,
	}	

	

--[[
	elseif patternName == "SPELLDISMISSPETOTHER" then patternInfo = { -- %s's %s is dismissed.
	}
	elseif patternName == "SPELLDISMISSPETSELF" then patternInfo = { -- Your %s is dismissed.
	}
]]

--[[
	elseif patternName == "SPELLCASTGOOTHER" then patternInfo = { -- %s casts %s.
		type = "cast",
		source = 1,
		skill = 2
	}
	elseif patternName == "SPELLCASTGOOTHERTARGETTED" then patternInfo = { -- %s casts %s on %s.
		type = "cast",
		source = 1,
		victim = 3,
		skill = 2
	}

	elseif patternName == "SPELLCASTGOSELF" then patternInfo = { -- You cast %s.
		type = "cast",		
		source = ParserLib_SELF,
		skill = 1
	}
	elseif patternName == "SPELLCASTGOSELFTARGETTED" then patternInfo = { -- You cast %s on %s.
		type = "cast",		
		source = ParserLib_SELF,
		victim = 2,
		skill = 1
	}
]]
	-- SpellMissSelf
	elseif patternName == "IMMUNESPELLSELFOTHER" then patternInfo = { -- %s is immune to your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = 2,
		missType =  "immune",
	}
	elseif patternName == "IMMUNESPELLSELFSELF" then patternInfo = { -- You are immune to your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "immune",
	}
	elseif patternName == "SPELLBLOCKEDSELFOTHER" then patternInfo = { -- Your %s was blocked by %s."
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "block",
	}
	elseif patternName == "SPELLDEFLECTEDSELFOTHER" then patternInfo = { -- "Your %s was deflected by %s.";
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "deflect"
	}
	elseif patternName == "SPELLDEFLECTEDSELFSELF" then patternInfo = { -- "You deflected your %s.";
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "deflect"
	}
	elseif patternName == "SPELLDODGEDSELFOTHER" then patternInfo = { -- Your %s was dodged by %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "dodge",	
	}
	elseif patternName == "SPELLDODGEDSELFSELF" then patternInfo = { -- "You dodged your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "dodge",		
	}
	elseif patternName == "SPELLEVADEDSELFOTHER" then patternInfo = { -- Your %s was evaded by %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "evade",	
	}
	elseif patternName == "SPELLEVADEDSELFSELF" then patternInfo = { -- You evaded your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "evade",	
	}
	elseif patternName == "SPELLIMMUNESELFOTHER" then patternInfo = { -- Your %s failed. %s is immune.	
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "immune",	
	}
	elseif patternName == "SPELLIMMUNESELFSELF" then patternInfo = { -- Your %s failed.  You are immune.	
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "immune",	
	}
	elseif patternName == "SPELLLOGABSORBSELFOTHER" then patternInfo = { -- Your %s is absorbed by %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "absorb",	
	}
	elseif patternName == "SPELLLOGABSORBSELFSELF" then patternInfo = { -- You absorb your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "absorb",	
	}
	elseif patternName == "SPELLMISSSELFOTHER" then patternInfo = { -- Your %s missed %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "miss",
	}
	elseif patternName == "SPELLMISSSELFSELF" then patternInfo = { -- Your %s misses you.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "miss",
	}
	elseif patternName == "SPELLPARRIEDSELFOTHER" then patternInfo = { -- Your %s is parried by %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "parry",
	}
	elseif patternName == "SPELLPARRIEDSELFSELF" then patternInfo = { -- You parried your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "parry",
	}
	elseif patternName == "SPELLREFLECTSELFOTHER" then patternInfo = { -- Your %s is reflected back by %s.
		type = "miss",
		source = 1,
		skill = 2,
		victim = ParserLib_SELF,
		missType =  "reflect"
	}
	elseif patternName == "SPELLREFLECTSELFSELF" then patternInfo = { -- You reflected your %s.
		type = "miss",
		source = ParserLib_SELF,
		skill = 1,
		victim = ParserLib_SELF,
		missType =  "reflect"
	}
	elseif patternName == "SPELLRESISTSELFOTHER" then patternInfo = { -- Your %s was resisted by %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		missType =  "resist",	
	}
	elseif patternName == "SPELLRESISTSELFSELF" then patternInfo = { -- You resisted your %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		missType =  "resist",	
	}


	
	elseif patternName == "SPELLCASTOTHERSTART" then patternInfo = { -- %s begins to cast %s.
		type = "cast",	
		source = 1,
		skill = 2,
		isBegin = true
	}
	elseif patternName == "SPELLCASTSELFSTART" then patternInfo = { -- You begin to cast %s.
		type = "cast",
		source = ParserLib_SELF,
		skill = 1,
		isBegin = true
	}
	
	
	
	elseif patternName == "SPELLDURABILITYDAMAGEALLOTHEROTHER" then patternInfo = { -- "%s casts %s on %s: all items damaged.
		type = 'durability',
		source = 1,
		skill = 2,
		victim = 3,
		isAllItems = true
	}
	elseif patternName == "SPELLDURABILITYDAMAGEALLOTHERSELF" then patternInfo = { -- "%s casts %s on you: all items damaged.
		type = 'durability',
		source = 1,
		skill = 2,
		victim = ParserLib_SELF,
		isAllItems = true
	}
	elseif patternName == "SPELLDURABILITYDAMAGEALLSELFOTHER" then patternInfo = { -- "You cast %s on %s: all items damaged.
		type = 'durability',
		source = ParserLib_SELF,
		skill = 1,
		victim = 2,
		isAllItems = true
	}
	elseif patternName == "SPELLDURABILITYDAMAGEOTHEROTHER" then patternInfo = { -- "%s casts %s on %s: %s damaged.
		type = 'durability',
		source = 1,
		skill = 2,
		victim = 3,
		item = 4,
	}
	elseif patternName == "SPELLDURABILITYDAMAGEOTHERSELF" then patternInfo = { -- "%s casts %s on you: %s damaged.
		type = 'durability',
		source = 1,
		skill = 2,
		victim = ParserLib_SELF,
		item = 3,
	}
	elseif patternName == "SPELLDURABILITYDAMAGESELFOTHER" then patternInfo = { -- "You cast %s on %s: %s damaged."; -- Example:  You cast Destruction on Fred: helmet damage
		type = 'durability',
		source = ParserLib_SELF,
		skill = 1,
		victim = 2,
		item = 3,	
	}

	
		-- SpellMissOther
	elseif patternName == "IMMUNESPELLOTHEROTHER" then patternInfo = { -- %s is immune to %s's %s.
		type = "miss",
		source = 2,
		victim = 1,
		skill = 3,
		missType =  "immune",
	}
	elseif patternName == "IMMUNESPELLOTHERSELF" then patternInfo = { -- You are immune to %s's %s.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "immune",
	}
	elseif patternName == "SPELLBLOCKEDOTHEROTHER" then patternInfo = { -- %s's %s was blocked by %s.
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "block",
	}
	elseif patternName == "SPELLBLOCKEDOTHERSELF" then patternInfo = { -- %s's %s was blocked.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "block",
	}
	elseif patternName == "SPELLDODGEDOTHEROTHER" then patternInfo = { -- %s's %s was dodged by %s.
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "dodge",
	}
	elseif patternName == "SPELLDODGEDOTHERSELF" then patternInfo = { -- %s's %s was dodged.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "dodge",
	}
	elseif patternName == "SPELLDEFLECTEDOTHEROTHER" then patternInfo = { -- "%s's %s was deflected by %s.";
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "deflect"
	}
	elseif patternName == "SPELLDEFLECTEDOTHERSELF" then patternInfo = { -- "%s's %s was deflected.";
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "deflect"
	}
	elseif patternName == "SPELLEVADEDOTHEROTHER" then patternInfo = { -- %s's %s was evaded by %s.
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "evade",	
	}
	elseif patternName == "SPELLEVADEDOTHERSELF" then patternInfo = { -- %s's %s was evaded.	
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "evade",	
	}
	elseif patternName == "SPELLIMMUNEOTHEROTHER" then patternInfo = { -- %s's %s fails. %s is immune.	
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "immune",	
	}
	elseif patternName == "SPELLIMMUNEOTHERSELF" then patternInfo = { -- %s's %s failed. You are immune.	
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "immune",	
	}
	elseif patternName == "SPELLLOGABSORBOTHEROTHER" then patternInfo = { -- %s's %s is absorbed by %s.
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "absorb",	
	}
	elseif patternName == "SPELLLOGABSORBOTHERSELF" then patternInfo = { -- You absorb %s's %s.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "absorb",	
	}
	elseif patternName == "SPELLMISSOTHEROTHER" then patternInfo = { -- %s's %s missed %s.
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "miss",
	}
	elseif patternName == "SPELLMISSOTHERSELF" then patternInfo = { -- %s's %s misses you.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "miss",
	}
	elseif patternName == "SPELLPARRIEDOTHEROTHER" then patternInfo = { -- %s's %s was parried by %s.
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "parry",
	}
	elseif patternName == "SPELLPARRIEDOTHERSELF" then patternInfo = { -- %s's %s was parried.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "parry",
	}
	elseif patternName == "SPELLREFLECTOTHEROTHER" then patternInfo = { -- %s's %s is reflected back by %s.
		type = "miss",
		source = 1,
		skill = 2,
		victim = 3,
		missType =  "reflect"
	}
	elseif patternName == "SPELLREFLECTOTHERSELF" then patternInfo = { -- You reflect %s's %s.
		type = "miss",
		source = 1,
		skill = 2,
		victim = ParserLib_SELF,
		missType =  "reflect"
	}
	elseif patternName == "SPELLRESISTOTHEROTHER" then patternInfo = { -- %s's %s was resisted by %s.
		type = "miss",
		source = 1,
		victim = 3,
		skill = 2,
		missType =  "resist",	
	}
	elseif patternName == "SPELLRESISTOTHERSELF" then patternInfo = { -- %s's %s was resisted.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		missType =  "resist",	
	}



	-- ExtraAttackOther
	elseif patternName == "SPELLEXTRAATTACKSOTHER" then patternInfo = { -- %s gains %d extra attacks through %s."; -- Victim gains 3 extra attacks through Thras
		type = "extraattack",
		victim = 1,
		skill = 3,
		amount = 2
	}
	elseif patternName == "SPELLEXTRAATTACKSOTHER_SINGULAR" then patternInfo = { -- %s gains %d extra attack through %s.
		type = "extraattack",
		victim = 1,
		skill = 3,
		amount = 2
	}
	
	-- ExtraAttackSelf
	elseif patternName == "SPELLEXTRAATTACKSSELF" then patternInfo = { -- You gain %d extra attacks through %s."; -- You gain 3 extra attacks through Thras
		type = "extraattack",
		victim = ParserLib_SELF,
		skill = 2,
		amount = 1
	}
	elseif patternName == "SPELLEXTRAATTACKSSELF_SINGULAR" then patternInfo = { -- You gain %d extra attack through %s.
		type = "extraattack",
		victim = ParserLib_SELF,
		skill = 2,
		amount = 1
	}

	
	elseif patternName == "SPELLFAILCASTOTHER" then patternInfo = { -- %s fails to cast %s: %s.
		type = "fail",
		source = 1,
		skill = 2,
		reason = 3,
	}
	elseif patternName == "SPELLFAILCASTSELF" then patternInfo = { -- You fail to cast %s: %s.
		type = "fail",
		source = ParserLib_SELF,
		skill = 1,
		reason = 2,
	}
	
	elseif patternName == "SPELLFAILPERFORMOTHER" then patternInfo = { -- %s fails to perform %s: %s.
		type = "fail",
		source = 1,
		skill = 2,
		reason = 3,
		isPerform = true,
	}
	elseif patternName == "SPELLFAILPERFORMSELF" then patternInfo = { -- You fail to perform %s: %s.
		type = "fail",
		source = ParserLib_SELF,
		skill = 1,
		reason = 2,
		isPerform = true
	}

	elseif patternName == "SPELLHAPPINESSDRAINOTHER" then patternInfo = { -- %s's %s loses %d happiness.
	}
	elseif patternName == "SPELLHAPPINESSDRAINSELF" then patternInfo = { -- Your %s loses %d happiness.
	}

	elseif patternName == "SPELLINTERRUPTOTHEROTHER" then patternInfo = { -- %s interrupts %s's %s.
		type = "interrupt",
		source = 1,
		victim = 2,
		skill = 3
	}
	elseif patternName == "SPELLINTERRUPTOTHERSELF" then patternInfo = { -- %s interrupts your %s.
		type = "interrupt",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2
	}
	elseif patternName == "SPELLINTERRUPTSELFOTHER" then patternInfo = { -- You interrupt %s's %s.
		type = "interrupt",
		source = ParserLib_SELF,
		victim = 1,
		skill = 2
	}

	-- SpellHitOther
	elseif patternName == "SPELLLOGCRITOTHEROTHER" then patternInfo = { -- %s's %s crits %s for %d.
		type = "hit",
		source = 1,
		victim = 3,
		skill = 2,
		amount = 4,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGCRITOTHERSELF" then patternInfo = { -- %s's %s crits you for %d.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGCRITSCHOOLOTHEROTHER" then patternInfo = { -- %s's %s crits %s for %d %s damage.
		type = "hit",
		source = 1,
		victim = 3,
		skill = 2,
		amount = 4,
		element = 5,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGCRITSCHOOLOTHERSELF" then patternInfo = { -- %s's %s crits you for %d %s damage.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
		element = 4,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGOTHEROTHER" then patternInfo = { -- %s's %s hits %s for %d.
		type = "hit",
		source = 1,
		victim = 3,
		skill = 2,
		amount = 4,
	}
	elseif patternName == "SPELLLOGOTHERSELF" then patternInfo = { -- %s's %s hits you for %d.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
	}
	elseif patternName == "SPELLLOGSCHOOLOTHEROTHER" then patternInfo = { -- %s's %s hits %s for %d %s damage.
		type = "hit",
		source = 1,
		victim = 3,
		skill = 2,
		amount = 4,
		element = 5,
	}
	elseif patternName == "SPELLLOGSCHOOLOTHERSELF" then patternInfo = { -- %s's %s hits you for %d %s damage.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
		element = 4,
	}


	
	-- SpellHitSelf
	elseif patternName == "SPELLLOGCRITSCHOOLSELFOTHER" then patternInfo = { -- Your %s crits %s for %d %s damage.
		type = "hit",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		amount = 3,
		element = 4,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGCRITSCHOOLSELFSELF" then patternInfo = { -- Your %s crits you for %d %s damage.
		type = "hit",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		amount = 2,
		element = 3,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGCRITSELFOTHER" then patternInfo = { -- Your %s crits %s for %d.
		type = "hit",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		amount = 3,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGCRITSELFSELF" then patternInfo = { -- Your %s crits you for %d.
		type = "hit",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		amount = 2,
		isCrit = true,
	}
	elseif patternName == "SPELLLOGSCHOOLSELFOTHER" then patternInfo = { -- Your %s hits %s for %d %s damage.
		type = "hit",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		amount = 3,
		element = 4,
	}
	elseif patternName == "SPELLLOGSCHOOLSELFSELF" then patternInfo = { -- Your %s hits you for %d %s damage.
		type = "hit",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		amount = 2,
		element = 3,
	}
	elseif patternName == "SPELLLOGSELFOTHER" then patternInfo = { -- Your %s hits %s for %d.
		type = "hit",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		amount = 3,
	}
	elseif patternName == "SPELLLOGSELFSELF" then patternInfo = { -- Your %s hits you for %d.
		type = "hit",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		amount = 2,
	}


--[[
	elseif patternName == "SPELLPERFORMGOOTHER" then patternInfo = { -- %s performs %s.
		
	}
	elseif patternName == "SPELLPERFORMGOOTHERTARGETTED" then patternInfo = { -- %s performs %s on %s.
	}
	elseif patternName == "SPELLPERFORMGOSELF" then patternInfo = { -- You perform %s.
	}
	elseif patternName == "SPELLPERFORMGOSELFTARGETTED" then patternInfo = { -- You perform %s on %s.
	}
]]	
	elseif patternName == "SPELLPERFORMOTHERSTART" then patternInfo = { -- %s begins to perform %s.
		type = "cast",
		source = 1,
		skill = 2,
		isBegin = true,
		isPerform = true
	}
	elseif patternName == "SPELLPERFORMSELFSTART" then patternInfo = { -- You begin to perform %s.
		type = "cast",
		source = ParserLib_SELF,
		skill = 1,
		isBegin = true,
		isPerform = true
	}

	
	-- DrainOther
	elseif patternName == "SPELLPOWERDRAINOTHEROTHER" then patternInfo = { -- %s's %s drains %d %s from %s.
		type = "drain",
		source = 1,
		victim = 5,
		skill = 2,
		amount = 3,
		attribute = 4
	}
	elseif patternName == "SPELLPOWERDRAINOTHERSELF" then patternInfo = { -- %s's %s drains %d %s from you.
		type = "drain",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
		attribute = 4
	}
	elseif patternName == "SPELLPOWERLEECHOTHEROTHER" then patternInfo = { -- %s's %s drains %d %s from %s. %s gains %d %s.
		type = "leech",
		source = 1,
		skill = 2,
		amount = 3,
		attribute = 4,
		victim = 5,
		sourceGained = 6,
		amountGained = 7,
		attributeGained = 8
	}
	elseif patternName == "SPELLPOWERLEECHOTHERSELF" then patternInfo = { -- %s's %s drains %d %s from you. %s gains %d %s.
		type = "leech",
		source = 1,
		skill = 2,
		amount = 3,
		attribute = 4,
		victim = ParserLib_SELF,
		sourceGained = 5,
		amountGained = 6,
		attributeGained = 7
	}
	
	-- DrainSelf
	elseif patternName == "SPELLPOWERDRAINSELFOTHER" then patternInfo = { -- Your %s drains %d %s from %s.
		type = "drain",
		source = ParserLib_SELF,
		victim = 4,
		skill = 1,
		amount = 2,
		attribute = 3
	}
	elseif patternName == "SPELLPOWERLEECHSELFOTHER" then patternInfo = { -- Your %s drains %d %s from %s. You gain %d %s.
		type = "leech",
		source = ParserLib_SELF,
		skill = 1,
		amount = 2,
		attribute = 3,
		victim = 4,
		sourceGained = ParserLib_SELF,
		amountGained = 5,
		attributeGained = 6
	}

	-- SplitDamage
	elseif patternName == "SPELLSPLITDAMAGEOTHEROTHER" then patternInfo = { -- %s's %s causes %s %d damage.
		type = "hit",
		source = 1,
		victim = 3,
		skill = 2,
		amount = 4,
		isSplit = true,
	}
	elseif patternName == "SPELLSPLITDAMAGEOTHERSELF" then patternInfo = { -- %s's %s causes you %d damage.
		type = "hit",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		amount = 3,
		isSplit = true,
	}
	elseif patternName == "SPELLSPLITDAMAGESELFOTHER" then patternInfo = { -- Your %s causes %s %d damage.
		type = "hit",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		amount = 3,
		isSplit = true,
	}

	

	elseif patternName == "TRADESKILL_LOG_FIRSTPERSON" then patternInfo = { -- You create %s.
		type = "create",
		source = ParserLib_SELF,
		item = 1
	}
	elseif patternName == "TRADESKILL_LOG_THIRDPERSON" then patternInfo = { -- %s creates %s.
		type = "create",
		source = 1,
		item = 2
	}

	elseif patternName == "UNITDESTROYEDOTHER" then patternInfo = { -- %s is destroyed.
		type = "death",
		victim = 1,
		isItem = true
	}
	elseif patternName == "UNITDIESOTHER" then patternInfo = { -- %s dies.
		type = "death",
		victim = 1,
	}
	elseif patternName == "UNITDIESSELF" then patternInfo = { -- You die.
		type = "death",
		victim = ParserLib_SELF
	}


	-- MissSelf
	elseif patternName == "MISSEDSELFOTHER" then patternInfo = { -- You miss %s.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "miss",	
	}
	elseif patternName == "VSABSORBSELFOTHER" then patternInfo = { -- You attack. %s absorbs all the damage.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "absorb",	
	}
	elseif patternName == "VSBLOCKSELFOTHER" then patternInfo = { -- You attack. %s blocks.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "block",	
	}
	elseif patternName == "VSDEFLECTSELFOTHER" then patternInfo = { -- You attack. %s deflects.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "deflect",	
	}
	elseif patternName == "VSDODGESELFOTHER" then patternInfo = { -- You attack. %s dodges.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "dodge",	
	}
	elseif patternName == "VSEVADESELFOTHER" then patternInfo = { -- You attack. %s evades.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "evade",	
	}
	elseif patternName == "VSIMMUNESELFOTHER" then patternInfo = { -- You attack but %s is immune.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "immune",	
	}
	elseif patternName == "VSPARRYSELFOTHER" then patternInfo = { -- You attack. %s parries.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "parry",	
	}
	elseif patternName == "VSRESISTSELFOTHER" then patternInfo = { -- You attack. %s resists all the damage.
		type = "miss",
		source = ParserLib_SELF,
		victim = 1,
		skill = ParserLib_MELEE,
		missType =  "resist",	
	}

	
	-- MissOther
	elseif patternName == "MISSEDOTHEROTHER" then patternInfo = { -- %s misses %s.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "miss",
	}
	elseif patternName == "MISSEDOTHERSELF" then patternInfo = { -- %s misses you.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "miss",	
	}
	elseif patternName == "VSABSORBOTHEROTHER" then patternInfo = { -- %s attacks. %s absorbs all the damage.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "absorb",	
	}
	elseif patternName == "VSABSORBOTHERSELF" then patternInfo = { -- %s attacks. You absorb all the damage.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "absorb",	
	}
	elseif patternName == "VSBLOCKOTHEROTHER" then patternInfo = { -- %s attacks. %s blocks.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "block",	
	}
	elseif patternName == "VSBLOCKOTHERSELF" then patternInfo = { -- %s attacks. You block.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "block",	
	}
	elseif patternName == "VSDEFLECTOTHEROTHER" then patternInfo = { -- %s attacks. %s deflects.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "deflect",	
	}
	elseif patternName == "VSDEFLECTOTHERSELF" then patternInfo = { -- %s attacks. You deflect.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "deflect",	
	}
	elseif patternName == "VSDODGEOTHEROTHER" then patternInfo = { -- %s attacks. %s dodges.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "dodge",	
	}
	elseif patternName == "VSDODGEOTHERSELF" then patternInfo = { -- %s attacks. You dodge.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "dodge",	
	}
	elseif patternName == "VSEVADEOTHEROTHER" then patternInfo = { -- %s attacks. %s evades.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "evade",	
	}
	elseif patternName == "VSEVADEOTHERSELF" then patternInfo = { -- %s attacks. You evade.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "evade",	
	}
	elseif patternName == "VSIMMUNEOTHEROTHER" then patternInfo = { -- %s attacks but %s is immune.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "immune",	
	}
	elseif patternName == "VSIMMUNEOTHERSELF" then patternInfo = { -- %s attacks but you are immune.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "immune",	
	}
	elseif patternName == "VSPARRYOTHEROTHER" then patternInfo = { -- %s attacks. %s parries.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "parry",	
	}
	elseif patternName == "VSPARRYOTHERSELF" then patternInfo = { -- %s attacks. You parry.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "parry",	
	}
	elseif patternName == "VSRESISTOTHEROTHER" then patternInfo = { -- %s attacks. %s resists all the damage.
		type = "miss",
		source = 1,
		victim = 2,
		skill = ParserLib_MELEE,
		missType =  "resist",	
	}
	elseif patternName == "VSRESISTOTHERSELF" then patternInfo = { -- %s attacks. You resist all the damage.
		type = "miss",
		source = 1,
		victim = ParserLib_SELF,
		skill = ParserLib_MELEE,
		missType =  "resist",	
	}


	-- EnvOther
	elseif patternName == "VSENVIRONMENTALDAMAGE_DROWNING_OTHER" then patternInfo = { -- %s is drowning and loses %d health.
		type = "environment",
		victim = 1,
		amount = 2,
		damageType = "drown",	
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_FALLING_OTHER" then patternInfo = { -- %s falls and loses %d health.
		type = "environment",
		victim = 1,
		amount = 2,
		damageType = "fall",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_FATIGUE_OTHER" then patternInfo = { -- %s is exhausted and loses %d health.
		type = "environment",
		victim = 1,
		amount = 2,
		damageType = "exhaust",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_FIRE_OTHER" then patternInfo = { -- %s suffers %d points of fire damage.
		type = "environment",
		victim = 1,
		amount = 2,
		damageType = "fire",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_LAVA_OTHER" then patternInfo = { -- %s loses %d health for swimming in lava.
		type = "environment",
		victim = 1,
		amount = 2,
		damageType = "lava",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_SLIME_OTHER" then patternInfo = { -- %s loses %d health for swimming in slime.
		type = "environment",
		victim = 1,
		amount = 2,
		damageType = "slime",
	}

	-- EnvSelf
	elseif patternName == "VSENVIRONMENTALDAMAGE_DROWNING_SELF" then patternInfo = { -- You are drowning and lose %d health.
		type = "environment",
		victim = ParserLib_SELF,
		amount = 1,
		damageType = "drown",		
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_FALLING_SELF" then patternInfo = { -- You fall and lose %d health.
		type = "environment",
		victim = ParserLib_SELF,
		amount = 1,
		damageType = "fall",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_FATIGUE_SELF" then patternInfo = { -- You are exhausted and lose %d health.
		type = "environment",
		victim = ParserLib_SELF,
		amount = 1,
		damageType = "exhaust",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_FIRE_SELF" then patternInfo = { -- You suffer %d points of fire damage.
		type = "environment",
		victim = ParserLib_SELF,
		amount = 1,
		damageType = "fire",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_LAVA_SELF" then patternInfo = { -- You lose %d health for swimming in lava.
		type = "environment",
		victim = ParserLib_SELF,
		amount = 1,
		damageType = "lava",
	}
	elseif patternName == "VSENVIRONMENTALDAMAGE_SLIME_SELF" then patternInfo = { -- You lose %d health for swimming in slime.
		type = "environment",
		victim = ParserLib_SELF,
		amount = 1,
		damageType = "slime",
	}

	
	-- PerformOther
	elseif patternName == "OPEN_LOCK_OTHER" then patternInfo = { -- %s performs %s on %s.
		type = "cast",
		source = 1,
		victim = 3,
		skill = 2,
		isPerform = true
	}	
	elseif patternName == "SIMPLEPERFORMOTHEROTHER" then patternInfo = { -- %s performs %s on %s.
		type = "cast",
		source = 1,
		victim = 3,
		skill = 2,
		isPerform = true
	}
	elseif patternName == "SIMPLEPERFORMOTHERSELF" then patternInfo = { -- %s performs %s on you.
		type = "cast",
		source = 1,
		victim = ParserLib_SELF,
		skill = 2,
		isPerform = true
	}
	elseif patternName == "SPELLTERSEPERFORM_OTHER" then patternInfo = { -- %s performs %s.
		type = "cast",
		source = 1,
		skill = 2,
		isPerform = true
	}

	
	-- PerformSelf
	elseif patternName == "OPEN_LOCK_SELF" then patternInfo = { -- You perform %s on %s.
		type = "cast",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		isPerform = true
	}
	elseif patternName == "SIMPLEPERFORMSELFOTHER" then patternInfo = { -- You perform %s on %s.
		type = "cast",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1,
		isPerform = true
	}
	elseif patternName == "SIMPLEPERFORMSELFSELF" then patternInfo = { -- You perform %s.
		type = "cast",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1,
		isPerform = true
	}
	elseif patternName == "SPELLTERSEPERFORM_SELF" then patternInfo = { -- You perform %s.
		type = "cast",
		source = ParserLib_SELF,
		skill = 1,
		isPerform = true
	}

	
	-- CastOther
	elseif patternName == "SIMPLECASTOTHEROTHER" then patternInfo = { -- %s casts %s on %s.
		type = "cast",
		source = 1,
		victim = 3,
		skill = 2	
	}
	elseif patternName == "SIMPLECASTOTHERSELF" then patternInfo = { -- %s casts %s on you.
		type = "cast",
		source = 1,
		victim = 2,
		skill = ParserLib_SELF		
	}
	elseif patternName == "SPELLTERSE_OTHER" then patternInfo = { -- %s casts %s.
		type = "cast",
		source = 1,
		skill = 2		
	}

	-- CastSelf
	elseif patternName == "SIMPLECASTSELFOTHER" then patternInfo = { -- You cast %s on %s.
		type = "cast",
		source = ParserLib_SELF,
		victim = 2,
		skill = 1		
	}
	elseif patternName == "SIMPLECASTSELFSELF" then patternInfo = { -- "You cast %s.
		type = "cast",
		source = ParserLib_SELF,
		victim = ParserLib_SELF,
		skill = 1	
	}
	elseif patternName == "SPELLTERSE_SELF" then patternInfo = { -- You cast %s.
		type = "cast",
		source = ParserLib_SELF,
		skill = 1
	}



	end

	
	
	if not patternInfo then
		self:Print("LoadPatternInfo(): Cannot find " .. patternName );
		return
	end
	
	local pattern = getglobal(patternName);	-- Get the pattern from GlobalStrings.lua
	
	local tc = 0
	for _ in string.gfind(pattern, "%%%d?%$?([sd])") do 	tc = tc + 1	end
	
	pattern = { self:ConvertPattern(pattern, true) }	
	local n = table.getn(pattern)	
	if n > 1 then			
		for j in patternInfo do
			if type(patternInfo[j]) == "number" and patternInfo[j] < 100 then
				patternInfo[j] = pattern[patternInfo[j]+1]
			end
		end
	end	

	patternInfo.tc = tc
	patternInfo.pattern = pattern[1]
	
	
	return patternInfo

end


-- Used to load eventTable elements on demand.
-- 1.1.4 : Now many events share pattern list.
function lib:LoadPatternList(eventName)
	local list
	
--------------- Melee Hits ----------------	

	if eventName == "CHAT_MSG_COMBAT_SELF_HITS" then		
	
		if not self.eventTable["CHAT_MSG_COMBAT_SELF_HITS"] then
			
			self.eventTable["CHAT_MSG_COMBAT_SELF_HITS"] = 
				self:LoadPatternCategoryTree(
				{
					"HitSelf",
					"EnvSelf",
				}
			)
			
		end

		list = self.eventTable["CHAT_MSG_COMBAT_SELF_HITS"] 
		
	elseif eventName == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" 
	or eventName == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" 
	or eventName == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" 
	or eventName == "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS" 
	or eventName == "CHAT_MSG_COMBAT_PARTY_HITS" 
	or eventName == "CHAT_MSG_COMBAT_PET_HITS" then

		if not self.eventTable["CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"] then 
			self.eventTable["CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"] = 
				self:LoadPatternCategoryTree( {
					"HitOtherOther",
					"EnvOther",
				} )
		end
		list = self.eventTable["CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"]
	
	
	elseif eventName == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" 
	or eventName == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS"  then

		if not self.eventTable["CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"] then 
			self.eventTable["CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"] = 
				self:LoadPatternCategoryTree( {
					{
						"HitOtherOther",
						"HitOtherSelf",
					},
					"EnvOther",
				} )
		end
		list = self.eventTable["CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"]

	

--------------- Melee Misses ----------------	


		
	elseif eventName == "CHAT_MSG_COMBAT_SELF_MISSES" then
		if not self.eventTable["CHAT_MSG_COMBAT_SELF_MISSES"] then
			self.eventTable["CHAT_MSG_COMBAT_SELF_MISSES"] = 
				self:LoadPatternCategoryTree( {
					"MissSelf",
				} )
		end
		list = self.eventTable["CHAT_MSG_COMBAT_SELF_MISSES"]
		
	elseif eventName == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES"
	or eventName == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES"
	or eventName == "CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES"
	or eventName == "CHAT_MSG_COMBAT_PARTY_MISSES"
	or eventName == "CHAT_MSG_COMBAT_PET_MISSES" then

		if not self.eventTable["CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES"] then
			self.eventTable["CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES"] = 
			self:LoadPatternCategoryTree( {
					"MissOtherOther",
			} )
		end

		list = self.eventTable["CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES"]	
	
	
	elseif eventName == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES"
	or eventName == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES" then

		if not self.eventTable["CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES"] then
			self.eventTable["CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES"] = 
			self:LoadPatternCategoryTree( {
				{
					"MissOtherOther",
					"MissOtherSelf",
				}
			} )
		end

		list = self.eventTable["CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES"]	
		
--------------- Spell Buffs ----------------	
	elseif eventName == "CHAT_MSG_SPELL_SELF_BUFF" then
		if not self.eventTable["CHAT_MSG_SPELL_SELF_BUFF"] then
			self.eventTable["CHAT_MSG_SPELL_SELF_BUFF"] = 
			self:LoadPatternCategoryTree(
				{
					"HealSelf",
					"EnchantSelf",
					"CastSelf",
					"PerformSelf",
					"DISPELFAILEDSELFOTHER",
					"SPELLCASTSELFSTART",
					"SPELLPERFORMSELFSTART",
					{
						"DrainSelf",
						"PowerGainSelf",
						"ExtraAttackSelf",
					},
					"SPELLSPLITDAMAGESELFOTHER",
					"ProcResistSelf",
					"SpellMissSelf",
				}
			)
		end		

		list = self.eventTable["CHAT_MSG_SPELL_SELF_BUFF"]

		
	elseif eventName == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF"
	or eventName == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF"  
	or eventName == "CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF"  
	or eventName == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF"  
	or eventName == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" 
	or eventName == "CHAT_MSG_SPELL_PARTY_BUFF" 
	or eventName == "CHAT_MSG_SPELL_PET_BUFF" then
	
		if not self.eventTable["CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"] then
			self.eventTable["CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"] = self:LoadPatternCategoryTree(
				{
					{
						"HealOther",
						"PowerGainOther",
						"ExtraAttackOther",
						"DrainOther",
					},
					"SPELLCASTOTHERSTART",
					{
						"EnchantOther",
						"CastOther",
						"PerformOther",
					},
					"SPELLPERFORMOTHERSTART",
					"SpellMissOther",
					{
						"PROCRESISTOTHEROTHER",
						"PROCRESISTOTHERSELF",
					},
					{
						"SPELLSPLITDAMAGEOTHEROTHER",
						"SPELLSPLITDAMAGEOTHERSELF",
					},
					"DispellFailOther",
				}
			)
			
			
		end
		
		list = self.eventTable["CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"]


--------------- Spell Damages ----------------	
		
	elseif eventName == "CHAT_MSG_SPELL_SELF_DAMAGE" then	
		if not self.eventTable["CHAT_MSG_SPELL_SELF_DAMAGE"] then
			self.eventTable["CHAT_MSG_SPELL_SELF_DAMAGE"] = 
				self:LoadPatternCategoryTree( {
					"SpellHitSelf",
					"CastSelf",
					"PerformSelf",
					"SpellMissSelf",
					"SPELLCASTSELFSTART",
					"SPELLPERFORMSELFSTART",
					"InterruptSelf",
					"DISPELFAILEDSELFOTHER",
				} )

		end		
		list = self.eventTable["CHAT_MSG_SPELL_SELF_DAMAGE"]	


	elseif eventName == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" 
	or eventName == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE"  
	or eventName == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"  
	or eventName == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"  
	or eventName == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" 
	or eventName == "CHAT_MSG_SPELL_PARTY_DAMAGE"  
	or eventName == "CHAT_MSG_SPELL_PET_DAMAGE"  then

		if not self.eventTable["CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"] then
			self.eventTable["CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"] = 
				self:LoadPatternCategoryTree( {
					"SpellHitOther",
					"SPELLCASTOTHERSTART",
					"SPELLPERFORMOTHERSTART",
					"DrainOther",
					"SpellMissOther",
					{
						"PROCRESISTOTHEROTHER",
						"PROCRESISTOTHERSELF",
					},
					{
						"SPELLSPLITDAMAGEOTHEROTHER",
						"SPELLSPLITDAMAGEOTHERSELF",
					},
					{
						"CastOther",
						"InterruptOther",
						{
							"SPELLDURABILITYDAMAGEALLOTHEROTHER",
							"SPELLDURABILITYDAMAGEALLOTHERSELF",
							"SPELLDURABILITYDAMAGEOTHEROTHER",
							"SPELLDURABILITYDAMAGEOTHERSELF",
						},
					},
					"PerformOther",
					"ExtraAttackOther",
					{
						"DISPELFAILEDOTHEROTHER",
						"DISPELFAILEDOTHERSELF",						
					},
				})

		end
		list = self.eventTable["CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE"]
	
		
--------------- Periodic Buffs ----------------	
		
	elseif eventName == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" then
	
		if not self.eventTable["CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"] then
		
			self.eventTable["CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"] = 
				self:LoadPatternCategoryTree( {
					{
						"HotOther",
						"HotSelf",
					},
					{
						"BuffSelf",
						"BuffOther",
						"PowerGainSelf",
					},
					"DrainSelf",
				} )
		end		
		list = self.eventTable["CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS"]	


	elseif eventName == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS"
	or eventName == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"
	or eventName == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"
	or eventName == "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" then
		
		if not self.eventTable["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"] then
			self.eventTable["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"] = 
				self:LoadPatternCategoryTree( {
					{
						"HotOther",
--						"DrainOther",	-- Dont think this would happen but add it anyway.
					},
					{
						"BuffOther",
						"PowerGainOther",
					},
					"DebuffOther", -- Was fired on older WoW version.
				} )
		end
		
		list = self.eventTable["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS"]


		
--------------- Periodic Damages ----------------	
		
	elseif eventName == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" then
		if not self.eventTable["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] then
		
			self.eventTable["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"] = 
				self:LoadPatternCategoryTree( {
					{
						"DotSelf",
						"DotOther",
					},
					{
						"DebuffSelf",
						"DebuffOther",
					},
					{
						"SPELLLOGABSORBOTHEROTHER",
						"SPELLLOGABSORBOTHERSELF",
						"SPELLLOGABSORBSELFSELF",
						"SPELLLOGABSORBSELFOTHER",
					},
					"DrainSelf",
				}	)
		end	
		list = self.eventTable["CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"]	
		
		

	elseif eventName == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
	or eventName == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"
	or eventName == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
	or eventName == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" then
	
		if not self.eventTable["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"] then
			self.eventTable["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"] = 
				self:LoadPatternCategoryTree( {
					"DebuffOther",
					"DotOther",
					{
						"SPELLLOGABSORBOTHEROTHER",
						"SPELLLOGABSORBSELFOTHER",
					},					
					"DrainOther",
					{
						"PowerGainOther",
						"BuffOther", -- Was fired on older WoW version.					
					}
				} )
		end			
		list = self.eventTable["CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"]

--------------- Damage Shields ----------------	
		
		
	elseif eventName == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF" then
		if not self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF"] then
			self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF"] = {
				"SPELLRESISTOTHEROTHER",
				"SPELLRESISTSELFOTHER",
				"DAMAGESHIELDOTHEROTHER",
				"DAMAGESHIELDSELFOTHER",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF"] , PatternCompare)
		end
		list = self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF"]	
		
	elseif eventName == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS" then
		if not self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS"] then
			self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS"] = {
				"SPELLRESISTOTHEROTHER",
				"SPELLRESISTOTHERSELF",
				"DAMAGESHIELDOTHEROTHER",
				"DAMAGESHIELDOTHERSELF",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS"]
		
		
		
--------------- Auras ----------------	

	elseif eventName == "CHAT_MSG_SPELL_AURA_GONE_PARTY"
	or eventName == "CHAT_MSG_SPELL_AURA_GONE_OTHER"
	or eventName == "CHAT_MSG_SPELL_AURA_GONE_SELF" then
	
		if not self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"] then
			self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = {
				"AURAREMOVEDOTHER",
				"AURAREMOVEDSELF",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"] , PatternCompare)
		end
		list = self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"]
	elseif eventName == "CHAT_MSG_SPELL_BREAK_AURA" then
	
		if not self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"] then
			self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"] = {
				"AURADISPELSELF",
				"AURADISPELOTHER",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"]			
	elseif string.find(eventName, "ITEM_ENCHANT", 1, true) then
	
		if not self.eventTable["CHAT_MSG_SPELL_ITEM_ENCHANTMENTS"] then
			self.eventTable["CHAT_MSG_SPELL_ITEM_ENCHANTMENTS"] = {
				"ITEMENCHANTMENTADDSELFSELF",
				"ITEMENCHANTMENTADDSELFOTHER",
				"ITEMENCHANTMENTADDOTHEROTHER",
				"ITEMENCHANTMENTADDOTHERSELF",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_ITEM_ENCHANTMENTS"] , PatternCompare)
		end			
		list = self.eventTable["CHAT_MSG_SPELL_ITEM_ENCHANTMENTS"]	

--------------- Trade Skills ----------------	

		
	elseif eventName == "CHAT_MSG_SPELL_TRADESKILLS" then
		if not self.eventTable["CHAT_MSG_SPELL_TRADESKILLS"] then
			self.eventTable["CHAT_MSG_SPELL_TRADESKILLS"] = {
				"TRADESKILL_LOG_FIRSTPERSON",
				"TRADESKILL_LOG_THIRDPERSON",
				"FEEDPET_LOG_FIRSTPERSON",
				"FEEDPET_LOG_THIRDPERSON",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_TRADESKILLS"], PatternCompare )
		end		
		list = self.eventTable["CHAT_MSG_SPELL_TRADESKILLS"]	
		
	elseif eventName == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER" then
	
		if not self.eventTable["CHAT_MSG_SPELL_FAILED_LOCALPLAYER"] then
			self.eventTable["CHAT_MSG_SPELL_FAILED_LOCALPLAYER"] = {
				"SPELLFAILPERFORMSELF",
				"SPELLFAILCASTSELF",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_FAILED_LOCALPLAYER"], PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_SPELL_FAILED_LOCALPLAYER"] 	
			
	
	elseif eventName == "CHAT_MSG_COMBAT_FACTION_CHANGE" then
	
		if not self.eventTable["CHAT_MSG_COMBAT_FACTION_CHANGE"] then
		
			if FACTION_STANDING_DECREASED then -- WoW 1.11
				self.eventTable["CHAT_MSG_COMBAT_FACTION_CHANGE"] = {
					"FACTION_STANDING_DECREASED",
					"FACTION_STANDING_INCREASED",
				}
			else	-- WoW 1.10
			
				self.eventTable["CHAT_MSG_COMBAT_FACTION_CHANGE"] = {
					"FACTION_STANDING_CHANGED",
					"FACTION_STANDING_INCREASED1",
					"FACTION_STANDING_INCREASED2",
					"FACTION_STANDING_INCREASED3",
					"FACTION_STANDING_INCREASED4",
					"FACTION_STANDING_DECREASED1",
					"FACTION_STANDING_DECREASED2",
					"FACTION_STANDING_DECREASED3",
					"FACTION_STANDING_DECREASED4",		
				}
			end
			table.sort(self.eventTable["CHAT_MSG_COMBAT_FACTION_CHANGE"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_COMBAT_FACTION_CHANGE"]
		
	elseif eventName == "CHAT_MSG_COMBAT_HONOR_GAIN" then
	
		if not self.eventTable["CHAT_MSG_COMBAT_HONOR_GAIN"] then
			self.eventTable["CHAT_MSG_COMBAT_HONOR_GAIN"] = {
			"COMBATLOG_HONORAWARD",
			"COMBATLOG_HONORGAIN",
			"COMBATLOG_DISHONORGAIN",
			}
			table.sort(self.eventTable["CHAT_MSG_COMBAT_HONOR_GAIN"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_COMBAT_HONOR_GAIN"]
	elseif eventName == "CHAT_MSG_COMBAT_XP_GAIN" then
	
		if not self.eventTable["CHAT_MSG_COMBAT_XP_GAIN"] then
			self.eventTable["CHAT_MSG_COMBAT_XP_GAIN"] = {
				"COMBATLOG_XPGAIN",
				"COMBATLOG_XPGAIN_EXHAUSTION1",
				"COMBATLOG_XPGAIN_EXHAUSTION1_GROUP",
				"COMBATLOG_XPGAIN_EXHAUSTION1_RAID",
				"COMBATLOG_XPGAIN_EXHAUSTION2",
				"COMBATLOG_XPGAIN_EXHAUSTION2_GROUP",
				"COMBATLOG_XPGAIN_EXHAUSTION2_RAID",
				"COMBATLOG_XPGAIN_EXHAUSTION4",
				"COMBATLOG_XPGAIN_EXHAUSTION4_GROUP",
				"COMBATLOG_XPGAIN_EXHAUSTION4_RAID",
				"COMBATLOG_XPGAIN_EXHAUSTION5",
				"COMBATLOG_XPGAIN_EXHAUSTION5_GROUP",
				"COMBATLOG_XPGAIN_EXHAUSTION5_RAID",
				"COMBATLOG_XPGAIN_FIRSTPERSON",
				"COMBATLOG_XPGAIN_FIRSTPERSON_GROUP",
				"COMBATLOG_XPGAIN_FIRSTPERSON_RAID",
				"COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED",
				"COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_GROUP",
				"COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_RAID",
				"COMBATLOG_XPLOSS_FIRSTPERSON_UNNAMED",
			}
			table.sort(self.eventTable["CHAT_MSG_COMBAT_XP_GAIN"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_COMBAT_XP_GAIN"]		
		
	elseif eventName == "CHAT_MSG_COMBAT_FRIENDLY_DEATH" 
	or eventName == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
	
		if not self.eventTable["CHAT_MSG_COMBAT_HOSTILE_DEATH"] then
			self.eventTable["CHAT_MSG_COMBAT_HOSTILE_DEATH"] = {
				"PARTYKILLOTHER",
				"UNITDESTROYEDOTHER",
				"UNITDIESOTHER",
				"UNITDIESSELF",
			}
			
			if SELFKILLOTHER then -- WoW 1.11
				table.insert(self.eventTable["CHAT_MSG_COMBAT_HOSTILE_DEATH"], "SELFKILLOTHER")
			end
			
			table.sort(self.eventTable["CHAT_MSG_COMBAT_HOSTILE_DEATH"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_COMBAT_HOSTILE_DEATH"]	

	end


	if not list then
		self:Print("Cannot find event " .. eventName);
	end

	return list

end





function lib:LoadPatternCategory(category)

	local list

	if category == "DebuffOther" then
		list = {
			"AURAADDEDOTHERHARMFUL",
			"AURAAPPLICATIONADDEDOTHERHARMFUL",
		}
	elseif category == "DebuffSelf" then
		list = {
			"AURAADDEDSELFHARMFUL",
			"AURAAPPLICATIONADDEDSELFHARMFUL",
		}
	elseif category == "BuffOther" then
		list = {
			"AURAADDEDOTHERHELPFUL",
			"AURAAPPLICATIONADDEDOTHERHELPFUL",
		}
	elseif category == "BuffSelf" then
		list = {
			"AURAADDEDSELFHELPFUL",
			"AURAAPPLICATIONADDEDSELFHELPFUL",
		}
	elseif category == "ExtraAttackOther" then
		list = {
			"SPELLEXTRAATTACKSOTHER",
			"SPELLEXTRAATTACKSOTHER_SINGULAR",
		}		

	elseif category == "ExtraAttackSelf" then
		list = {
			"SPELLEXTRAATTACKSSELF",
			"SPELLEXTRAATTACKSSELF_SINGULAR",
		}		

	elseif category == "AuraChange" then
		list = {
			"AURACHANGEDOTHER",
			"AURACHANGEDSELF",
		}
	elseif category == "AuraDispell" then
		list = {
			"AURADISPELOTHER",
			"AURADISPELSELF",
		}
	elseif category == "Fade" then
		list = {
			"AURAREMOVEDOTHER",
			"AURAREMOVEDSELF",
		}
	elseif category == "HitOtherOther" then
		list = {
			"COMBATHITCRITOTHEROTHER",
			"COMBATHITCRITSCHOOLOTHEROTHER",
			"COMBATHITOTHEROTHER",
			"COMBATHITSCHOOLOTHEROTHER",
		}
	elseif category == "HitOtherSelf" then
		list = {
	
			"COMBATHITCRITOTHERSELF",
			"COMBATHITCRITSCHOOLOTHERSELF",
			"COMBATHITOTHERSELF",
			"COMBATHITSCHOOLOTHERSELF",
		}
	
	elseif category == "HitSelf" then
		list = {
			"COMBATHITSCHOOLSELFOTHER",
			"COMBATHITSELFOTHER",
			"COMBATHITCRITSCHOOLSELFOTHER",
			"COMBATHITCRITSELFOTHER",
		}
	elseif category == "MissOtherOther" then
		list = {
			"MISSEDOTHEROTHER",
			"VSABSORBOTHEROTHER",
			"VSBLOCKOTHEROTHER",
			"VSDEFLECTOTHEROTHER",
			"VSDODGEOTHEROTHER",
			"VSEVADEOTHEROTHER",
			"VSIMMUNEOTHEROTHER",
			"VSPARRYOTHEROTHER",
			"VSRESISTOTHEROTHER",				
		}	
	elseif category == "MissOtherSelf" then
		list = {
			"MISSEDOTHERSELF",
			"VSABSORBOTHERSELF",
			"VSBLOCKOTHERSELF",
			"VSDEFLECTOTHERSELF",
			"VSDODGEOTHERSELF",
			"VSEVADEOTHERSELF",
			"VSIMMUNEOTHERSELF",
			"VSPARRYOTHERSELF",
			"VSRESISTOTHERSELF",	
		}	
	
	
	elseif category == "MissSelf" then
	
		list = {
				"MISSEDSELFOTHER",
				"VSABSORBSELFOTHER",
				"VSBLOCKSELFOTHER",
				"VSDEFLECTSELFOTHER",
				"VSDODGESELFOTHER",
				"VSEVADESELFOTHER",
				"VSIMMUNESELFOTHER",
				"VSPARRYSELFOTHER",
				"VSRESISTSELFOTHER",			
		}
	
	elseif category == "DispellFailOther" then
		
		list = {
			"DISPELFAILEDOTHEROTHER",
			"DISPELFAILEDOTHERSELF",
		
		}

	elseif category == "DispellFailSelf" then
		
		list = {
			"DISPELFAILEDSELFOTHER",
		
		}
	

		
	elseif category == "DmgShieldOther" then
		list = {
			"DAMAGESHIELDOTHEROTHER",
			"DAMAGESHIELDOTHERSELF",
		}
	elseif category == "DmgShieldSelf" then
		list = {
			"DAMAGESHIELDSELFOTHER",
		}
		
	elseif category == "DispelFailOther" then
		list = {
			"DISPELFAILEDOTHEROTHER",
			"DISPELFAILEDOTHERSELF",
		}
		
	elseif category == "DispellFailSelf" then
		list = {
			"DISPELFAILEDSELFOTHER",
		}
	
	elseif category == "HealOther" then
		list = {
			"HEALEDCRITOTHEROTHER",
			"HEALEDCRITOTHERSELF",
			"HEALEDOTHEROTHER",
			"HEALEDOTHERSELF",
		}
	elseif category == "HealSelf" then
		list = {
			"HEALEDCRITSELFOTHER",
			"HEALEDCRITSELFSELF",
			"HEALEDSELFOTHER",
			"HEALEDSELFSELF",
		}
		
	elseif category == "SpellMissOther" then
		list = {
			"IMMUNESPELLOTHEROTHER",
			"IMMUNESPELLOTHERSELF",
			"SPELLBLOCKEDOTHEROTHER",
			"SPELLBLOCKEDOTHERSELF",
			"SPELLDODGEDOTHEROTHER",
			"SPELLDODGEDOTHERSELF",
			"SPELLDEFLECTEDOTHEROTHER",
			"SPELLDEFLECTEDOTHERSELF",
			"SPELLEVADEDOTHEROTHER",
			"SPELLEVADEDOTHERSELF",
			"SPELLIMMUNEOTHEROTHER",
			"SPELLIMMUNEOTHERSELF",
			"SPELLLOGABSORBOTHEROTHER",
			"SPELLLOGABSORBOTHERSELF",
			"SPELLMISSOTHEROTHER",
			"SPELLMISSOTHERSELF",
			"SPELLPARRIEDOTHEROTHER",
			"SPELLPARRIEDOTHERSELF",
			"SPELLREFLECTOTHEROTHER",
			"SPELLREFLECTOTHERSELF",
			"SPELLRESISTOTHEROTHER",
			"SPELLRESISTOTHERSELF",
		}
			
	elseif category == "SpellMissSelf" then
		list = {
			"IMMUNESPELLSELFOTHER",
			"IMMUNESPELLSELFSELF",
			"SPELLBLOCKEDSELFOTHER",
			"SPELLDEFLECTEDSELFOTHER",
			"SPELLDEFLECTEDSELFSELF",
			"SPELLDODGEDSELFOTHER",
			"SPELLDODGEDSELFSELF",
			"SPELLEVADEDSELFOTHER",
			"SPELLEVADEDSELFSELF",
			"SPELLIMMUNESELFOTHER",
			"SPELLIMMUNESELFSELF",
			"SPELLLOGABSORBSELFOTHER",
			"SPELLLOGABSORBSELFSELF",
			"SPELLMISSSELFOTHER",
			"SPELLMISSSELFSELF",
			"SPELLPARRIEDSELFOTHER",
			"SPELLPARRIEDSELFSELF",
			"SPELLREFLECTSELFOTHER",
			"SPELLREFLECTSELFSELF",
			"SPELLRESISTSELFOTHER",
			"SPELLRESISTSELFSELF",
		}
			
	elseif category == "PowerGainOther" then
		list = {
			"POWERGAINOTHEROTHER",
			"POWERGAINOTHERSELF",
		}
		
	elseif category == "EnchantOther" then
		list  =  {
			"ITEMENCHANTMENTADDOTHEROTHER",
			"ITEMENCHANTMENTADDOTHERSELF",
		}
		
	elseif category == "EnchantSelf" then
		list = {
			"ITEMENCHANTMENTADDSELFOTHER",
			"ITEMENCHANTMENTADDSELFSELF",
		}
		
	elseif category == "CastOther" then
	
		list = {
			"SIMPLECASTOTHEROTHER",
			"SIMPLECASTOTHERSELF",
			"SPELLTERSE_OTHER",
		}

	elseif category == "CastSelf" then
	
		list = {
			"SIMPLECASTSELFOTHER",
			"SIMPLECASTSELFSELF",
			"SPELLTERSE_SELF",
		}
		
	elseif category == "PerformOther" then

		list = {
			"OPEN_LOCK_OTHER",
			"SIMPLEPERFORMOTHEROTHER",
			"SIMPLEPERFORMOTHERSELF",
			"SPELLTERSEPERFORM_OTHER",
		}
		
	elseif category == "PerformSelf" then

		list = {
			"OPEN_LOCK_SELF",
			"SIMPLEPERFORMSELFOTHER",
			"SIMPLEPERFORMSELFSELF",
			"SPELLTERSEPERFORM_SELF",
		}

	
	elseif category == "ProcResistOther" then
	
	elseif category == "ProcResistSelf" then
		list = {
			"PROCRESISTSELFOTHER",
			"PROCRESISTSELFSELF",
		}
		

	elseif category == "EnvOther" then
	
		list = {
			"VSENVIRONMENTALDAMAGE_DROWNING_OTHER",
			"VSENVIRONMENTALDAMAGE_FALLING_OTHER",
			"VSENVIRONMENTALDAMAGE_FATIGUE_OTHER",
			"VSENVIRONMENTALDAMAGE_FIRE_OTHER",
			"VSENVIRONMENTALDAMAGE_LAVA_OTHER",
			"VSENVIRONMENTALDAMAGE_SLIME_OTHER",
		}
	
	elseif category == "EnvSelf" then
	
		list = {
			"VSENVIRONMENTALDAMAGE_DROWNING_SELF",
			"VSENVIRONMENTALDAMAGE_FALLING_SELF",
			"VSENVIRONMENTALDAMAGE_FATIGUE_SELF",
			"VSENVIRONMENTALDAMAGE_FIRE_SELF",
			"VSENVIRONMENTALDAMAGE_LAVA_SELF",
			"VSENVIRONMENTALDAMAGE_SLIME_SELF",
		}
	
	-- HoT effects on others. (not casted by others)
	elseif category == "HotOther" then
		list = {
			"PERIODICAURAHEALOTHEROTHER",
			"PERIODICAURAHEALSELFOTHER",
		}

	-- HoT effects on you. (not casted by you)
	elseif category == "HotSelf" then
		list = {
			"PERIODICAURAHEALSELFSELF",
			"PERIODICAURAHEALOTHERSELF",
		}
	elseif category == "PowerGainSelf" then
		list = {
			"POWERGAINSELFSELF",
			"POWERGAINSELFOTHER",
		}
	elseif category == "BuffOther" then
		list = {
		"AURAAPPLICATIONADDEDOTHERHELPFUL",
		"AURAADDEDOTHERHELPFUL",
		}
	elseif category == "BuffSelf" then
		list = {
			"AURAADDEDSELFHELPFUL",
			"AURAAPPLICATIONADDEDSELFHELPFUL",
		}
	elseif category == "DrainSelf" then
		list = {	
			"SPELLPOWERLEECHSELFOTHER",
			"SPELLPOWERDRAINSELFOTHER",
		}
	elseif category == "DrainOther" then
		list = {	
			"SPELLPOWERLEECHOTHEROTHER",
			"SPELLPOWERLEECHOTHERSELF",
			"SPELLPOWERDRAINOTHEROTHER",
			"SPELLPOWERDRAINOTHERSELF",
		}

	-- DoT effects on others (not casted by others)
	elseif category == "DotOther" then
		list = {
			"PERIODICAURADAMAGEOTHEROTHER",
			"PERIODICAURADAMAGESELFOTHER",
		}
		
	-- DoT effects on you (not casted by you)
	elseif category == "DotSelf" then
		list = {
			"PERIODICAURADAMAGEOTHERSELF",
			"PERIODICAURADAMAGESELFSELF",
		}
	elseif category == "SpellHitOther" then
		list = {
			"SPELLLOGCRITOTHEROTHER",
			"SPELLLOGCRITOTHERSELF",
			"SPELLLOGCRITSCHOOLOTHEROTHER",
			"SPELLLOGCRITSCHOOLOTHERSELF",
			"SPELLLOGOTHEROTHER",
			"SPELLLOGOTHERSELF",
			"SPELLLOGSCHOOLOTHEROTHER",
			"SPELLLOGSCHOOLOTHERSELF",
		}

					
	elseif category == "SpellHitSelf" then
		list = {
			"SPELLLOGCRITSELFOTHER",
			"SPELLLOGCRITSELFSELF",
			"SPELLLOGCRITSCHOOLSELFOTHER",
			"SPELLLOGCRITSCHOOLSELFSELF",
			"SPELLLOGSELFOTHER",
			"SPELLLOGSELFSELF",
			"SPELLLOGSCHOOLSELFOTHER",
			"SPELLLOGSCHOOLSELFSELF",
		}
		
	elseif category == "InterruptOther" then
		list = {
			"SPELLINTERRUPTOTHEROTHER",
			"SPELLINTERRUPTOTHERSELF",
		}
	elseif category == "InterruptSelf" then
		list = {
			"SPELLINTERRUPTSELFOTHER",
		}
	else
		
		return { category }
		
	end
	
	return list
	
end


-- Load categories recursively. First layer will not be sorted.
function lib:LoadPatternCategoryTree(catTree, reSort)
	if type(catTree) ~= "table" then return end
	
	local resultList = {}
	local list
	
	for i, v in catTree do
	
		if type(v) == "table" then
			list = self:LoadPatternCategoryTree(v, true)
		else -- should be string.		
			list = self:LoadPatternCategory(v)
			table.sort(list, PatternCompare)
		end
		
		for j, w in list do
			table.insert(resultList, w)
		end
		
	end
	
	if reSort then
		table.sort(resultList, PatternCompare)
	end
	
	return resultList


end
 

--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

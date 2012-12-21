---------------------------------------------------------------------------
--	To Get an instance of ParserLib, call this:
-- 	local parser = ParserLib:GetInstance(version)
-- 	where the version is the variable 'vmajor' you see here.
---------------------------------------------------------------------------
local vmajor, vminor = "1.1", 24

---------------------------------------------------------------------------
-- **Public ParserLib methods begins at line 155.
---------------------------------------------------------------------------

local stubvarname = "TekLibStub"
local libvarname = "ParserLib"

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







----------------------------------------------
--	*ParserLib Public Methods*      --
----------------------------------------------

-- Register an event to ParserLib.
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
	

	-- self:Print(string.format("Registering %s for addon %s.", event, addonID) );	 -- debug

	if type(handler) == "string" then handler = getglobal(handler) end
	
	-- if not handler then self:Print("nil handler from " .. addonID, 1, 0, 0) end -- debug

	if self.clients[event] == nil then
		self.clients[event] = {};	
	end
	
	table.insert(self.clients[event], { ["id"]=addonID, ["func"]=handler } );
	self.frame:RegisterEvent(event);

end

-- Check if you have registered an event.
function lib:IsEventRegistered(addonID, event)
	if self.clients[event] then
		for i, v in self.clients[event] do
			if v.id == addonID then return true end
		end
	end
end

-- Unregister an event.
function lib:UnregisterEvent(addonID, event)
	local empty = true
	
	
	if not self.clients[event] then return end
	
	for i, v in self.clients[event] do
		if v.id == addonID then
			-- self:Print( format("Removing %s from %s", v.id, event) )		 -- debug
			table.remove(self.clients[event], i)
		else
			empty = false
		end
	end
	
	if empty then
		-- self:Print("Unregistering event " .. event) -- debug
		self.frame:UnregisterEvent(event)
		self.clients[event] = nil
	end
end

-- Unregister all events.
function lib:UnregisterAllEvents(addonID)
	local event, index, empty;
	
	for event in self.clients do
		empty = true;
		
		for i, v in self.clients[event] do
			if v.id == addonID then
				-- self:Print( format("Removing %s for %s", v.id, event) ) -- debug
				table.remove(self.clients[event], i)
--				self.clients[event][index] = nil;
			else
				empty = false;
			end
		end
		
		if empty then
			-- self:Print("Unregistering event " .. event) -- debug
			self.frame:UnregisterEvent(event);
			self.clients[event] = nil;
		end
		
	end	

end

-- Parse custom messages, check documentation.html for more info.
function lib:Deformat(text, pattern)
	if not self.customPatterns then self.customPatterns = {} end		
	if not self.customPatterns[pattern] then
		self.customPatterns[pattern] = self:Curry(pattern)
	end
	return self.customPatterns[pattern](text)
end

--------------------------------------------------------
-- Methods to control ParserLib behaviour --
--------------------------------------------------------

-- Use CompostLib or not?
-- Not that at 1.1-23 CompostLib no longer slows down the speed of ParserLib, 
--   because I found out that I was calling CompostLib:Recycle too frequently, which can be avoided.
function lib:UseCompost(flag)
	self.vars.noCompost = not flag
end


---------------------------------------------------
--	*End of ParserLib Public Methods* --
---------------------------------------------------


----------------------------------------------
--	ParserLib Private Methods
----------------------------------------------

-- Constants
ParserLib_SELF = 103
ParserLib_MELEE = 112
ParserLib_DAMAGESHIELD = 113

-- lib.timing = true -- timer

-- Stub function called by frame.OnEvent
local function ParserOnEvent() lib:OnEvent() end

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

local FindString = {
	[0] = function(m,p,t) return string.find(m,p), t end,
	[1] = function(m,p,t) _,_,t[1] = string.find(m,p) if t[1] then return true, t else return false, t end end,
	[2] = function(m,p,t) _,_,t[1],t[2] = string.find(m,p) if t[2] then return true, t else return false, t end end,
	[3] = function(m,p,t) _,_,t[1],t[2],t[3] = string.find(m,p) if t[3] then return true, t else return false, t end end,
	[4] = function(m,p,t) _,_,t[1],t[2],t[3],t[4] = string.find(m,p) if t[4] then return true, t else return false, t end end,
	[5] = function(m,p,t) _,_,t[1],t[2],t[3],t[4],t[5] = string.find(m,p) if t[5] then return true, t else return false, t end end,
	[6] = function(m,p,t) _,_,t[1],t[2],t[3],t[4],t[5],t[6] = string.find(m,p) if t[6] then return true, t else return false, t end end,
	[7] = function(m,p,t) _,_,t[1],t[2],t[3],t[4],t[5],t[6],t[7] = string.find(m,p) if t[7] then return true, t else return false, t end end,
	[8] = function(m,p,t) _,_,t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8] = string.find(m,p) if t[8] then return true, t else return false, t end end,
	[9] = function(m,p,t) _,_,t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9] = string.find(m,p) if t[9] then return true, t else return false, t end end,
}

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

function lib:GetCompost()

	if self.vars.noCompost then
	
		if not self.myCompost then
			self.myCompost = {
				Recycle = function() return {} end,
				Acquire = function() return {} end,
				Reclaim = function() end,
			}					
		end
		return self.myCompost

	else
	
		if not self.compost then
			if AceLibrary and AceLibrary:HasInstance("Compost-2.0") then
				self.compost = AceLibrary:GetInstance("Compost-2.0")
			elseif CompostLib then
				self.compost = CompostLib:GetInstance("compost-1")
			else
				-- Cannot find the existance of CompostLib
				self.vars.noCompost = true
				return self:GetCompost()
			end			
		end
		return self.compost

	end
	
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
	pattern = string.gsub(pattern,"%%d","(%-?%%d+)"); -- %d to (%d+)			

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
		pattern = string.gsub(pattern,"%%%d%$d","(%-?%%d+)"); -- %1$d to (%d+)
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

function lib:OnLoad()

	-- Both table starts out empty, and load the data only when required.
	self.eventTable = {}
	self.patternTable = {}
	
	
	self.vars = {}
	
	if self.timing then
		self.timer = {
			ParseMessage_LoadPatternList = 0,
			ParseMessage_FindPattern = 0,
			ParseMessage_FindPattern_Regexp = 0,
			ParseMessage_FindPattern_Regexp_FindString = 0,
			ParseMessage_FindPattern_LoadPatternInfo = 0,			
			ParseMessage_ParseInformation = 0,
			ParseMessage_ParseTrailers = 0,
			ParseMessage_ConvertTypes = 0,
			NotifyClients = 0,
			Compost_Acquire = 0,
			Compost_Recycle = 0,
			Compost_Reclaim = 0,
		}
	end

	if not self.clients then self.clients = {} end
	
	if not self.frame then
		self.frame = CreateFrame("FRAME", "ParserLibFrame")
		self.frame:SetScript("OnEvent", ParserOnEvent )
		self.frame:Hide()
	end
	
	
end
	
function lib:OnEvent(e, a1)

	if not e then e = event end
	if not a1 then a1 = arg1 end

	-- self:Print("Event: |cff3333ff"..e.."|r") -- debug
	
	-- Titan Honor+ was changing the global events... just change it back.
	if e == "CHAT_MSG_HONORPLUS" then e = "CHAT_MSG_COMBAT_HONOR_GAIN" end
	

	if self:ParseMessage(a1, e) then
		
-- 		local timer = GetTime() -- timer
		self:NotifyClients(e)
-- 		self.timer.NotifyClients = self.timer.NotifyClients + GetTime() - timer -- timer
				
	end
	

end

function lib:NotifyClients(event)

	if not self.clients or not self.clients[event] then 
		-- self:Print(event .. " has no client to notify.") -- debug
		return 
	end
	
	-- Noneed to recycle the table if there is only one client.
	if table.getn(self.clients[event]) == 1 then
		-- self:Print(event .. ", calling " .. self.clients[event][1].id) -- debug
		self.clients[event][1].func(event, self.info)
		return
	end

-- 	local timer = GetTime() -- timer
	local info = self:GetCompost():Acquire()	
-- 	self.timer.Compost_Acquire = GetTime() - timer + self.timer.Compost_Acquire -- timer

	for i, client in self.clients[event] do
		-- self:Print(event .. ", calling " .. client.id) -- debug
				
		-- I can just do a compost:Recycle() here, but I hope this can improve the performance.
		for j in info do if not self.info[j] then info[j] = nil end end
		for j, v in self.info do info[j] = v end
		
		client.func(event, info)
	end
	
-- 	timer = GetTime() -- timer
	self:GetCompost():Reclaim(info)
-- 	self.timer.reclaim = GetTime() - timer + self.timer.reclaim -- timer

end

function lib:Print(msg, r, g, b)	
	ChatFrame1:AddMessage(string.format("<%s-%s-%s> %s", libvarname, vmajor, vminor, msg), r, g, b)
end


-- message : the arg1 in the event
-- event : name says it all.
-- info : the table which will store the passed result, so THIS IS THE OUTPUT.
-- return : true if pattern found and parsed, nil otherwise.
function lib:ParseMessage(message, event)

-- --	local currTime -- timer

	
-- 	currTime = GetTime() -- timer
	if not self.eventTable[event] then self.eventTable[event] = self:LoadPatternList(event) end
	local list = self.eventTable[event]
-- 	self.timer.ParseMessage_LoadPatternList = self.timer.ParseMessage_LoadPatternList + GetTime() - currTime -- timer
	
	if not list then return end

	-- Get the table to store parsed results.
	if not self.info then 
-- 		timer = GetTime() -- timer
		self.info = self:GetCompost():Acquire() 
-- 		self.timer.Compost_Acquire = GetTime() - timer + self.timer.Compost_Acquire -- timer
	else 
-- 		timer = GetTime() -- timer
		self.info = self:GetCompost():Recycle(self.info) 
-- 		self.timer.Compost_Recycle = GetTime() - timer + self.timer.Compost_Recycle -- timer
	end

	
-- 	currTime = GetTime() -- timer
	local pattern = self:FindPattern(message, list)
-- 	self.timer.ParseMessage_FindPattern = GetTime() - currTime + self.timer.ParseMessage_FindPattern -- timer

	
	if not pattern then 
		-- create "unknown" event type.
		self.info.type = "unknown"
		self.info.message = message		
		return true
	end
	
-- 	currTime = GetTime() -- timer
	self:ParseInformation(pattern)
-- 	self.timer.ParseMessage_ParseInformation = GetTime() - currTime + self.timer.ParseMessage_ParseInformation -- timer
	
	
-- 	currTime = GetTime() -- timer
	if self.info.type == "hit" or self.info.type == "environment" then
		self:ParseTrailers(message)
	end
-- 	self.timer.ParseMessage_ParseTrailers = GetTime() - currTime + self.timer.ParseMessage_ParseTrailers -- timer
	
-- 	currTime = GetTime() -- timer
	self:ConvertTypes(self.info)
-- 	self.timer.ParseMessage_ConvertTypes = GetTime() - currTime + self.timer.ParseMessage_ConvertTypes -- timer

	return true

	
end


-- Search for pattern in 'patternList' which matches 'message', parsed tokens will be stored in table self.info
function lib:FindPattern(message, patternList)
	
	local pt, timer, found

	for i, v in patternList do
	
-- 		timer = GetTime() -- timer
		if not self.patternTable[v] then self.patternTable[v] = self:LoadPatternInfo(v) end
-- 		self.timer.ParseMessage_FindPattern_LoadPatternInfo = GetTime() - timer + self.timer.ParseMessage_FindPattern_LoadPatternInfo -- timer
		
		pt = self.patternTable[v]
		
		found = false

-- 		timer = GetTime() -- timer
		if self:OptimizerCheck(message, v) then
-- 			timer = GetTime() -- timer
			found, self.info = FindString[pt.tc](message, pt.pattern, self.info)
-- 			self.timer.ParseMessage_FindPattern_Regexp_FindString = GetTime() - timer + self.timer.ParseMessage_FindPattern_Regexp_FindString -- timer
		end
-- 		self.timer.ParseMessage_FindPattern_Regexp = GetTime() - timer + self.timer.ParseMessage_FindPattern_Regexp -- timer
		
		if found then 
			-- self:Print(message.." = " .. v .. ":" .. pt.pattern)  -- debug
			return v	
		end


	end
	
	
end


-- Parses for trailors.
function lib:ParseTrailers(message)
	local found, amount, info
	
	info = self.info
	
	
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

function lib:ParseInformation(patternName)

	local patternInfo = self.patternTable[patternName]
	local info = self.info

	-- Create an info table from pattern table, copies everything except the pattern string.	
	for i, v in patternInfo do
		if i == 1 then
			info.type = v
		elseif type(i) == "number" then
			if type(v) == "number" and v < 100 then
				info[ self:GetInfoFieldName( self.patternTable[patternName][1], i) ] = info[v]
			else
				info[ self:GetInfoFieldName( self.patternTable[patternName][1], i) ] = v
			end
		end
	end

	if info.type == "honor" and not info.amount then
		info.isDishonor = true
	
	elseif info.type == "durability" and not info.item  then
		info.isAllItems = true
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

	--if 1 then return true end
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


function lib:PrintTable(args)
	for k, v in args do
		ChatFrame1:AddMessage(tostring(k) .. " = " .. tostring(v));
	end
	ChatFrame1:AddMessage("");
end

-- Used to test the correcteness of ParserLib on different languages.
function lib:TestPatterns(sendToClients)
	
	
	self:LoadEverything()
	

	-- Creating the combat messages.	
	local testNumber = 123
	local message
	local messages = self:GetCompost():Acquire()
	for patternName in self.patternTable do
		messages[patternName] = self:GetCompost():Acquire()
		messages[patternName].message = getglobal(patternName)
		for i, v in self.patternTable[patternName] do
			if i ~= "tc" and type(v) == "number" and v < 100 and i~=1 then
				messages[patternName][v] =  self:GetInfoFieldName(self.patternTable[patternName][1], i)
			end
		end
		for i, v in ipairs(messages[patternName]) do
			if string.find(v, "^amount") then
				messages[patternName].message = string.gsub(messages[patternName].message, "%%%d?%$?d", testNumber, 1)
			else
				messages[patternName].message = string.gsub(messages[patternName].message, "%%%d?%$?s", string.upper(v), 1)
			end
		end
	end
	

	-- Begin the test.
	
	local info, msg
	local startTime = GetTime() 
	local startMem = gcinfo()
	
	for _, event in self.supportedEvents do
		for _, pattern in self:LoadPatternList(event) do
			msg = messages[pattern].message
			if sendToClients then self:OnEvent(event, msg)	end
			if self:ParseMessage(msg, event) then
				info = self.info
				for i, v in ipairs(messages[pattern]) do
					if not info[v] 
					or ( string.find(v, "^amount") and info[v] ~= testNumber ) 
					or ( not string.find(v, "^amount") and info[v] ~= string.upper(v) ) then
						self:Print("Event: " .. event)
						self:Print("Pattern: " .. pattern)
						self:Print("Message: " .. msg)
						self:PrintTable(messages[pattern])
						self:PrintTable(info)
					end
				end
			end
		end
	end

	self:Print( string.format("Test completed in %.4fs, memory cost %.2fKB.", GetTime() - startTime, gcinfo() - startMem) )

	self:GetCompost():Reclaim(messages, 1)
	
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

function lib:PrintTimers()
	if not self.timer then return end

	local total = 0
	for i in self.timer do
		total = total + self.timer[i]
	end

	if not self.timerIndex then 
		self.timerIndex = {}
		for i in self.timer do
			table.insert(self.timerIndex, i)
		end
		table.sort(self.timerIndex)
	end

	DEFAULT_CHAT_FRAME:AddMessage("Time\t%\tDescription")
	for i, idx in self.timerIndex do
		DEFAULT_CHAT_FRAME:AddMessage(string.format("%.3f\t%.1f\t%s", self.timer[idx], 100*self.timer[idx]/total, idx) )
	end	
	
	DEFAULT_CHAT_FRAME:AddMessage(total .. "\t100\tTotal")
end
-- Used to load eventTable elements on demand.
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
		
			if GetLocale() ~= "deDE"  then
			self.eventTable["CHAT_MSG_SPELL_SELF_BUFF"] =  self:LoadPatternCategoryTree(
				{
					"HealSelf",
					"EnchantSelf",
					"CastSelf",
					"PerformSelf",
					"DispelFailSelf",
					"SPELLCASTSELFSTART",
					"SPELLPERFORMSELFSTART",
					{
						"DrainSelf",
						"PowerGainSelf",
						"ExtraAttackSelf",
					},
					"SPELLSPLITDAMAGESELFOTHER",
					{
						"ProcResistSelf",
						"SpellMissSelf",
					}
				}
			)

			else
			self.eventTable["CHAT_MSG_SPELL_SELF_BUFF"] =  self:LoadPatternCategoryTree(
				{
					"HealSelf",
					"CastSelf",
					"PerformSelf",
					"DispelFailSelf",
					"SPELLCASTSELFSTART",
					"SPELLPERFORMSELFSTART",
					{
						"DrainSelf",
						"PowerGainSelf",
						"ExtraAttackSelf",
					},
					"SPELLSPLITDAMAGESELFOTHER",
					{
						"ProcResistSelf",
						"SpellMissSelf",
					}
				}
			)
			end

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
		
			if GetLocale() ~= "deDE"  then
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
						"ProcResistOther",
						"SplitDamageOther",
						"DispelFailOther",
					}
				)

			else -- Remove "EnchantOther" from German, since it's 100% ambiguous with SIMPLECASTOTHEROTHER, which is unsolvable.
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
							"CastOther",
							"PerformOther",
						},
						"SPELLPERFORMOTHERSTART",
						"SpellMissOther",
						"ProcResistOther",
						"SplitDamageOther",
						"DispelFailOther",
					}
				)
			end
		end
		
		list = self.eventTable["CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"]


--------------- Spell Damages ----------------	
		
	elseif eventName == "CHAT_MSG_SPELL_SELF_DAMAGE" then	
		if not self.eventTable["CHAT_MSG_SPELL_SELF_DAMAGE"] then
			self.eventTable["CHAT_MSG_SPELL_SELF_DAMAGE"] = 
				self:LoadPatternCategoryTree( {
					"SpellHitSelf",
					{
						"CastSelf",
						"DurabilityDamageSelf",
					},
					"PerformSelf",
					"SpellMissSelf",
					"SPELLCASTSELFSTART",
					"SPELLPERFORMSELFSTART",
					"InterruptSelf",
					"DISPELFAILEDSELFOTHER",
					"ExtraAttackSelf"
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
					"SplitDamageOther",
					{
						"CastOther",
						"InterruptOther",
						"DurabilityDamageOther",
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
						"PowerGainOther",
						"PowerGainSelf",
					},
					"DrainSelf",
					"DotSelf",	-- Don't think this will hapen but add it anyway.
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
						"DrainOther",	-- When other players use Skull of Impending Doom.
					},
					"DotOther",	-- Dont think this will happen but add anyway.
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
	or eventName == "CHAT_MSG_SPELL_AURA_GONE_OTHER" then
	
		if not self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"] then
			self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = {
				"AURAREMOVEDOTHER",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"] , PatternCompare)
		end
		list = self.eventTable["CHAT_MSG_SPELL_AURA_GONE_OTHER"]
	
	elseif  eventName == "CHAT_MSG_SPELL_AURA_GONE_SELF" then
	
		if not self.eventTable["CHAT_MSG_SPELL_AURA_GONE_SELF"] then
			self.eventTable["CHAT_MSG_SPELL_AURA_GONE_SELF"] = {
				"AURAREMOVEDOTHER",
				"AURAREMOVEDSELF",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_AURA_GONE_SELF"] , PatternCompare)
		end
		list = self.eventTable["CHAT_MSG_SPELL_AURA_GONE_SELF"]
		
	elseif eventName == "CHAT_MSG_SPELL_BREAK_AURA" then
	
		if not self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"] then
			self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"] = {
				"AURADISPELSELF",
				"AURADISPELOTHER",
			}
			table.sort(self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_SPELL_BREAK_AURA"]			
		
		
		
	elseif eventName == "CHAT_MSG_SPELL_ITEM_ENCHANTMENTS" then
	
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
		
			self.eventTable["CHAT_MSG_COMBAT_FACTION_CHANGE"] = {
				"FACTION_STANDING_CHANGED",
				"FACTION_STANDING_DECREASED",
				"FACTION_STANDING_INCREASED",
			}
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
				"SELFKILLOTHER",
				"PARTYKILLOTHER",
				"UNITDESTROYEDOTHER",
				"UNITDIESOTHER",
				"UNITDIESSELF",
			}
			
			table.sort(self.eventTable["CHAT_MSG_COMBAT_HOSTILE_DEATH"] , PatternCompare)
		end		
		list = self.eventTable["CHAT_MSG_COMBAT_HOSTILE_DEATH"]	

	end


	if not list then
		-- self:Print(string.format("Event '%s' not found.", eventName), 1, 0,0); -- debug
	end

	return list

end

function lib:LoadPatternCategory(category)

	local list

	if category == "AuraChange" then		list = {
			"AURACHANGEDOTHER",
			"AURACHANGEDSELF",
		}
	elseif category == "AuraDispel" then		list = {
			"AURADISPELOTHER",
			"AURADISPELSELF",
		}
	elseif category == "BuffOther" then		list = {
			"AURAADDEDOTHERHELPFUL",
			"AURAAPPLICATIONADDEDOTHERHELPFUL",
		}
	elseif category == "BuffSelf" then		list = {
			"AURAADDEDSELFHELPFUL",
			"AURAAPPLICATIONADDEDSELFHELPFUL",
		}
	elseif category == "CastOther" then	list = {
			"SIMPLECASTOTHEROTHER",
			"SIMPLECASTOTHERSELF",
			"SPELLTERSE_OTHER",
		}
	elseif category == "CastSelf" then	list = {
			"SIMPLECASTSELFOTHER",
			"SIMPLECASTSELFSELF",
			"SPELLTERSE_SELF",
		}
	elseif category == "DebuffOther" then		list = {
			"AURAADDEDOTHERHARMFUL",
			"AURAAPPLICATIONADDEDOTHERHARMFUL",
		}
	elseif category == "DebuffSelf" then		list = {
			"AURAADDEDSELFHARMFUL",
			"AURAAPPLICATIONADDEDSELFHARMFUL",
		}
	elseif category == "DispelFailOther" then	list = {
			"DISPELFAILEDOTHEROTHER",
			"DISPELFAILEDOTHERSELF",
		
		}
	elseif category == "DispelFailSelf" then		list = {
			"DISPELFAILEDSELFOTHER",
			"DISPELFAILEDSELFSELF",
		}
	elseif category == "DmgShieldOther" then list = {
			"DAMAGESHIELDOTHEROTHER",
			"DAMAGESHIELDOTHERSELF",
		}
	elseif category == "DmgShieldSelf" then		list = {
			"DAMAGESHIELDSELFOTHER",
		}
	elseif category == "DurabilityDamageSelf" then list = {
		"SPELLDURABILITYDAMAGEALLSELFOTHER",
		"SPELLDURABILITYDAMAGESELFOTHER",	
	}
	elseif category == "DurabilityDamageOther" then list = {
			"SPELLDURABILITYDAMAGEALLOTHEROTHER",
			"SPELLDURABILITYDAMAGEALLOTHERSELF", 
			"SPELLDURABILITYDAMAGEOTHEROTHER", 
			"SPELLDURABILITYDAMAGEOTHERSELF",
	}
	elseif category == "EnchantOther" then		list  =  {
			"ITEMENCHANTMENTADDOTHEROTHER",
			"ITEMENCHANTMENTADDOTHERSELF",
		}
	elseif category == "EnchantSelf" then		list = {
			"ITEMENCHANTMENTADDSELFOTHER",
			"ITEMENCHANTMENTADDSELFSELF",
		}
	elseif category == "ExtraAttackOther" then		list = {
			"SPELLEXTRAATTACKSOTHER",
			"SPELLEXTRAATTACKSOTHER_SINGULAR",
		}		
	elseif category == "ExtraAttackSelf" then		list = {
			"SPELLEXTRAATTACKSSELF",
			"SPELLEXTRAATTACKSSELF_SINGULAR",
		}		
	elseif category == "Fade" then		list = {
			"AURAREMOVEDOTHER",
			"AURAREMOVEDSELF",
		}
	elseif category == "HealOther" then		list = {
			"HEALEDCRITOTHEROTHER",
			"HEALEDCRITOTHERSELF",
			"HEALEDOTHEROTHER",
			"HEALEDOTHERSELF",
		}
	elseif category == "HealSelf" then		list = {
			"HEALEDCRITSELFOTHER",
			"HEALEDCRITSELFSELF",
			"HEALEDSELFOTHER",
			"HEALEDSELFSELF",
		}
	elseif category == "HitOtherOther" then		list = {
			"COMBATHITCRITOTHEROTHER",
			"COMBATHITCRITSCHOOLOTHEROTHER",
			"COMBATHITOTHEROTHER",
			"COMBATHITSCHOOLOTHEROTHER",
		}
	elseif category == "HitOtherSelf" then		list = {
	
			"COMBATHITCRITOTHERSELF",
			"COMBATHITCRITSCHOOLOTHERSELF",
			"COMBATHITOTHERSELF",
			"COMBATHITSCHOOLOTHERSELF",
		}
	elseif category == "HitSelf" then		list = {
			"COMBATHITSCHOOLSELFOTHER",
			"COMBATHITSELFOTHER",
			"COMBATHITCRITSCHOOLSELFOTHER",
			"COMBATHITCRITSELFOTHER",
		}
	elseif category == "MissOtherOther" then	list = {
			"MISSEDOTHEROTHER",
			"VSABSORBOTHEROTHER",
			"VSBLOCKOTHEROTHER",
			"VSDEFLECTOTHEROTHER",
			"VSDODGEOTHEROTHER",
			"VSEVADEOTHEROTHER",
			"VSIMMUNEOTHEROTHER",
			"VSPARRYOTHEROTHER",
			"VSRESISTOTHEROTHER",
			"IMMUNEDAMAGECLASSOTHEROTHER",
			"IMMUNEOTHEROTHER",
			
		}	
	elseif category == "MissOtherSelf" then	list = {
			"MISSEDOTHERSELF",
			"VSABSORBOTHERSELF",
			"VSBLOCKOTHERSELF",
			"VSDEFLECTOTHERSELF",
			"VSDODGEOTHERSELF",
			"VSEVADEOTHERSELF",
			"VSIMMUNEOTHERSELF",
			"VSPARRYOTHERSELF",
			"VSRESISTOTHERSELF",	
			"IMMUNEDAMAGECLASSOTHERSELF",
			"IMMUNEOTHERSELF",
		}	
	elseif category == "MissSelf" then	list = {
				"MISSEDSELFOTHER",
				"VSABSORBSELFOTHER",
				"VSBLOCKSELFOTHER",
				"VSDEFLECTSELFOTHER",
				"VSDODGESELFOTHER",
				"VSEVADESELFOTHER",
				"VSIMMUNESELFOTHER",
				"VSPARRYSELFOTHER",
				"VSRESISTSELFOTHER",
				"IMMUNEDAMAGECLASSSELFOTHER",
				"IMMUNESELFOTHER",
				"IMMUNESELFSELF",
		}
	elseif category == "PowerGainOther" then		list = {
			"POWERGAINOTHEROTHER",
			"POWERGAINOTHERSELF",
		}
	elseif category == "PerformOther" then list = {
			"OPEN_LOCK_OTHER",
			"SIMPLEPERFORMOTHEROTHER",
			"SIMPLEPERFORMOTHERSELF",
			"SPELLTERSEPERFORM_OTHER",
		}
	elseif category == "PerformSelf" then	list = {
			"OPEN_LOCK_SELF",
			"SIMPLEPERFORMSELFOTHER",
			"SIMPLEPERFORMSELFSELF",
			"SPELLTERSEPERFORM_SELF",
		}
	elseif category == "ProcResistOther" then list = {
			"PROCRESISTOTHEROTHER",
			"PROCRESISTOTHERSELF",
		}
	elseif category == "ProcResistSelf" then	list = {
			"PROCRESISTSELFOTHER",
			"PROCRESISTSELFSELF",
		}
	elseif category == "EnvOther" then list = {
			"VSENVIRONMENTALDAMAGE_DROWNING_OTHER",
			"VSENVIRONMENTALDAMAGE_FALLING_OTHER",
			"VSENVIRONMENTALDAMAGE_FATIGUE_OTHER",
			"VSENVIRONMENTALDAMAGE_FIRE_OTHER",
			"VSENVIRONMENTALDAMAGE_LAVA_OTHER",
			"VSENVIRONMENTALDAMAGE_SLIME_OTHER",
		}
	elseif category == "EnvSelf" then	list = {
			"VSENVIRONMENTALDAMAGE_DROWNING_SELF",
			"VSENVIRONMENTALDAMAGE_FALLING_SELF",
			"VSENVIRONMENTALDAMAGE_FATIGUE_SELF",
			"VSENVIRONMENTALDAMAGE_FIRE_SELF",
			"VSENVIRONMENTALDAMAGE_LAVA_SELF",
			"VSENVIRONMENTALDAMAGE_SLIME_SELF",
		}
	-- HoT effects on others. (not casted by others)
	elseif category == "HotOther" then	list = {
			"PERIODICAURAHEALOTHEROTHER",
			"PERIODICAURAHEALSELFOTHER",
		}
	-- HoT effects on you. (not casted by you)
	elseif category == "HotSelf" then	list = {
			"PERIODICAURAHEALSELFSELF",
			"PERIODICAURAHEALOTHERSELF",
		}
	elseif category == "PowerGainSelf" then	list = {
			"POWERGAINSELFSELF",
			"POWERGAINSELFOTHER",
		}
	elseif category == "BuffOther" then	list = {
		"AURAAPPLICATIONADDEDOTHERHELPFUL",
		"AURAADDEDOTHERHELPFUL",
		}
	elseif category == "BuffSelf" then	list = {
			"AURAADDEDSELFHELPFUL",
			"AURAAPPLICATIONADDEDSELFHELPFUL",
		}
	elseif category == "DrainSelf" then	list = {	
			"SPELLPOWERLEECHSELFOTHER",
			"SPELLPOWERDRAINSELFOTHER",
			"SPELLPOWERDRAINSELFSELF",
		}
	elseif category == "DrainOther" then	list = {	
			"SPELLPOWERLEECHOTHEROTHER",
			"SPELLPOWERLEECHOTHERSELF",
			"SPELLPOWERDRAINOTHEROTHER",
			"SPELLPOWERDRAINOTHERSELF",
		}
	-- DoT effects on others (not casted by others)
	elseif category == "DotOther" then	list = {
			"PERIODICAURADAMAGEOTHEROTHER",
			"PERIODICAURADAMAGESELFOTHER",
		}
	-- DoT effects on you (not casted by you)
	elseif category == "DotSelf" then	list = {
			"PERIODICAURADAMAGEOTHERSELF",
			"PERIODICAURADAMAGESELFSELF",
		}
	elseif category == "SpellHitOther" then	list = {
			"SPELLLOGCRITOTHEROTHER",
			"SPELLLOGCRITOTHERSELF",
			"SPELLLOGCRITSCHOOLOTHEROTHER",
			"SPELLLOGCRITSCHOOLOTHERSELF",
			"SPELLLOGOTHEROTHER",
			"SPELLLOGOTHERSELF",
			"SPELLLOGSCHOOLOTHEROTHER",
			"SPELLLOGSCHOOLOTHERSELF",
		}
	elseif category == "SpellHitSelf" then	list = {
			"SPELLLOGCRITSELFOTHER",
			"SPELLLOGCRITSELFSELF",
			"SPELLLOGCRITSCHOOLSELFOTHER",
			"SPELLLOGCRITSCHOOLSELFSELF",
			"SPELLLOGSELFOTHER",
			"SPELLLOGSELFSELF",
			"SPELLLOGSCHOOLSELFOTHER",
			"SPELLLOGSCHOOLSELFSELF",
		}
	elseif category == "SpellMissSelf" then		list = {
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
	elseif category == "SpellMissOther" then		list = {
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
	elseif category == "InterruptOther" then	list = {
			"SPELLINTERRUPTOTHEROTHER",
			"SPELLINTERRUPTOTHERSELF",
		}
	elseif category == "InterruptSelf" then	list = {
			"SPELLINTERRUPTSELFOTHER",
		}
	elseif category == "SplitDamageOther" then list = {
		"SPELLSPLITDAMAGEOTHEROTHER",
		"SPELLSPLITDAMAGEOTHERSELF",
	}		
	else return { category }
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
 
-- Used to load patternTable elements on demand.
function lib:LoadPatternInfo(patternName)

	local patternInfo
	
	if patternName == "AURAADDEDOTHERHELPFUL" then
		patternInfo = { "buff", 1, 2, nil, }
	elseif patternName == "AURAADDEDSELFHELPFUL" then
		patternInfo = { "buff", ParserLib_SELF, 1, nil, }
	elseif patternName == "AURAAPPLICATIONADDEDOTHERHELPFUL" then
		patternInfo = { "buff", 1, 2, 3, }
	elseif patternName == "AURAAPPLICATIONADDEDSELFHELPFUL" then
		patternInfo = { "buff", ParserLib_SELF, 1, 2, }
	
	elseif patternName == "OPEN_LOCK_OTHER" then
		patternInfo = { "cast", 1, 2, 3, nil, nil, }
	elseif patternName == "OPEN_LOCK_SELF" then
		patternInfo = { "cast", ParserLib_SELF, 1, 2, nil, nil, }
	elseif patternName == "SIMPLECASTOTHEROTHER" then
		patternInfo = { "cast", 1, 2, 3, nil, nil, }
	elseif patternName == "SIMPLECASTOTHERSELF" then
		patternInfo = { "cast", 1, 2, ParserLib_SELF, nil, nil, }
	elseif patternName == "SIMPLECASTSELFOTHER" then
		patternInfo = { "cast", ParserLib_SELF, 1, 2, nil, nil, }
	elseif patternName == "SIMPLECASTSELFSELF" then
		patternInfo = { "cast", ParserLib_SELF, 1, ParserLib_SELF, nil, nil, }
	elseif patternName == "SIMPLEPERFORMOTHEROTHER" then
		patternInfo = { "cast", 1, 2, 3, nil, nil, }
	elseif patternName == "SIMPLEPERFORMOTHERSELF" then
		patternInfo = { "cast", 1, 2, ParserLib_SELF, nil, nil, }
	elseif patternName == "SIMPLEPERFORMSELFOTHER" then
		patternInfo = { "cast", ParserLib_SELF, 1, 2, nil, nil, }
	elseif patternName == "SIMPLEPERFORMSELFSELF" then
		patternInfo = { "cast", ParserLib_SELF, 1, ParserLib_SELF, nil, nil, }
	elseif patternName == "SPELLCASTOTHERSTART" then
		patternInfo = { "cast", 1, 2, nil, true, nil, }
	elseif patternName == "SPELLCASTSELFSTART" then
		patternInfo = { "cast", ParserLib_SELF, 1, nil, true, nil, }
	elseif patternName == "SPELLPERFORMOTHERSTART" then
		patternInfo = { "cast", 1, 2, nil, true, nil, }
	elseif patternName == "SPELLPERFORMSELFSTART" then
		patternInfo = { "cast", ParserLib_SELF, 1, nil, true, nil, }
	elseif patternName == "SPELLTERSEPERFORM_OTHER" then
		patternInfo = { "cast", 1, 2, nil, nil, nil, }
	elseif patternName == "SPELLTERSEPERFORM_SELF" then
		patternInfo = { "cast", ParserLib_SELF, 1, nil, nil, nil, }
	elseif patternName == "SPELLTERSE_OTHER" then
		patternInfo = { "cast", 1, 2, nil, nil, nil, }
	elseif patternName == "SPELLTERSE_SELF" then
		patternInfo = { "cast", ParserLib_SELF, 1, nil, nil, nil, }
	
	elseif patternName == "TRADESKILL_LOG_FIRSTPERSON" then
		patternInfo = { "create", ParserLib_SELF, 1, }
	elseif patternName == "TRADESKILL_LOG_THIRDPERSON" then
		patternInfo = { "create", 1, 2, }
	
	elseif patternName == "PARTYKILLOTHER" then
		patternInfo = { "death", 1, 2, nil, }
	elseif patternName == "SELFKILLOTHER" then
		patternInfo = { "death", 1, ParserLib_SELF, nil, }
	elseif patternName == "UNITDESTROYEDOTHER" then
		patternInfo = { "death", 1, nil, true, }
	elseif patternName == "UNITDIESOTHER" then
		patternInfo = { "death", 1, nil, nil, }
	elseif patternName == "UNITDIESSELF" then
		patternInfo = { "death", ParserLib_SELF, nil, nil, }
	
	elseif patternName == "AURAADDEDOTHERHARMFUL" then
		patternInfo = { "debuff", 1, 2, nil, }
	elseif patternName == "AURAADDEDSELFHARMFUL" then
		patternInfo = { "debuff", ParserLib_SELF, 1, nil, }
	elseif patternName == "AURAAPPLICATIONADDEDOTHERHARMFUL" then
		patternInfo = { "debuff", 1, 2, 3, }
	elseif patternName == "AURAAPPLICATIONADDEDSELFHARMFUL" then
		patternInfo = { "debuff", ParserLib_SELF, 1, 2, }
	
	elseif patternName == "AURADISPELOTHER" then
		patternInfo = { "dispel", 1, 2, nil, nil, }
	elseif patternName == "AURADISPELSELF" then
		patternInfo = { "dispel", ParserLib_SELF, 1, nil, nil, }
	elseif patternName == "DISPELFAILEDOTHEROTHER" then
		patternInfo = { "dispel", 2, 3, 1, true, }
	elseif patternName == "DISPELFAILEDOTHERSELF" then
		patternInfo = { "dispel", ParserLib_SELF, 2, 1, true, }
	elseif patternName == "DISPELFAILEDSELFOTHER" then
		patternInfo = { "dispel", 1, 2, ParserLib_SELF, true, }
	elseif patternName == "DISPELFAILEDSELFSELF" then
		patternInfo = { "dispel", ParserLib_SELF, 1, ParserLib_SELF, true, }
	
	elseif patternName == "SPELLPOWERDRAINOTHEROTHER" then
		patternInfo = { "drain", 1, 5, 2, 3, 4, }
	elseif patternName == "SPELLPOWERDRAINOTHERSELF" then
		patternInfo = { "drain", 1, ParserLib_SELF, 2, 3, 4, }
	elseif patternName == "SPELLPOWERDRAINSELFOTHER" then
		patternInfo = { "drain", ParserLib_SELF, 4, 1, 2, 3, }
	elseif patternName == "SPELLPOWERDRAINSELFSELF" then
		patternInfo = { "drain", ParserLib_SELF, ParserLib_SELF, 1, 2, 3, }
	
	elseif patternName == "SPELLDURABILITYDAMAGEALLOTHEROTHER" then
		patternInfo = { "durability", 1, 2, 3, nil, }
	elseif patternName == "SPELLDURABILITYDAMAGEALLOTHERSELF" then
		patternInfo = { "durability", 1, 2, ParserLib_SELF, nil, }
	elseif patternName == "SPELLDURABILITYDAMAGEALLSELFOTHER" then
		patternInfo = { "durability", ParserLib_SELF, 1, 2, nil, }
	elseif patternName == "SPELLDURABILITYDAMAGEOTHEROTHER" then
		patternInfo = { "durability", 1, 2, 3, 4, }
	elseif patternName == "SPELLDURABILITYDAMAGEOTHERSELF" then
		patternInfo = { "durability", 1, 2, ParserLib_SELF, 3, }
	elseif patternName == "SPELLDURABILITYDAMAGESELFOTHER" then
		patternInfo = { "durability", ParserLib_SELF, 1, 2, 3, }
	
	elseif patternName == "ITEMENCHANTMENTADDOTHEROTHER" then
		patternInfo = { "enchant", 1, 3, 2, 4, }
	elseif patternName == "ITEMENCHANTMENTADDOTHERSELF" then
		patternInfo = { "enchant", 1, ParserLib_SELF, 2, 3, }
	elseif patternName == "ITEMENCHANTMENTADDSELFOTHER" then
		patternInfo = { "enchant", ParserLib_SELF, 2, 1, 3, }
	elseif patternName == "ITEMENCHANTMENTADDSELFSELF" then
		patternInfo = { "enchant", ParserLib_SELF, ParserLib_SELF, 1, 2, }
	
	elseif patternName == "VSENVIRONMENTALDAMAGE_DROWNING_OTHER" then
		patternInfo = { "environment", 1, 2, "drown", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_DROWNING_SELF" then
		patternInfo = { "environment", ParserLib_SELF, 1, "drown", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_FALLING_OTHER" then
		patternInfo = { "environment", 1, 2, "fall", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_FALLING_SELF" then
		patternInfo = { "environment", ParserLib_SELF, 1, "fall", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_FATIGUE_OTHER" then
		patternInfo = { "environment", 1, 2, "exhaust", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_FATIGUE_SELF" then
		patternInfo = { "environment", ParserLib_SELF, 1, "exhaust", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_FIRE_OTHER" then
		patternInfo = { "environment", 1, 2, "fire", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_FIRE_SELF" then
		patternInfo = { "environment", ParserLib_SELF, 1, "fire", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_LAVA_OTHER" then
		patternInfo = { "environment", 1, 2, "lava", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_LAVA_SELF" then
		patternInfo = { "environment", ParserLib_SELF, 1, "lava", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_SLIME_OTHER" then
		patternInfo = { "environment", 1, 2, "slime", }
	elseif patternName == "VSENVIRONMENTALDAMAGE_SLIME_SELF" then
		patternInfo = { "environment", ParserLib_SELF, 1, "slime", }
	
	elseif patternName == "COMBATLOG_XPGAIN" then
		patternInfo = { "experience", 2, nil, nil, nil, nil, nil, nil, nil, 1, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION1" then
		patternInfo = { "experience", 2, 1, 3, 4, nil, nil, nil, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION1_GROUP" then
		patternInfo = { "experience", 2, 1, 3, 4, nil, nil, nil, 5, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION1_RAID" then
		patternInfo = { "experience", 2, 1, 3, 4, nil, nil, 5, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION2" then
		patternInfo = { "experience", 2, 1, 3, 4, nil, nil, nil, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION2_GROUP" then
		patternInfo = { "experience", 2, 1, 3, 4, nil, nil, nil, 5, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION2_RAID" then
		patternInfo = { "experience", 2, 1, 3, 4, nil, nil, 5, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION4" then
		patternInfo = { "experience", 2, 1, nil, nil, 3, 4, nil, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION4_GROUP" then
		patternInfo = { "experience", 2, 1, nil, nil, 3, 4, nil, 5, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION4_RAID" then
		patternInfo = { "experience", 2, 1, nil, nil, 3, 4, 5, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION5" then
		patternInfo = { "experience", 2, 1, nil, nil, 3, 4, nil, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION5_GROUP" then
		patternInfo = { "experience", 2, 1, nil, nil, 3, 4, nil, 5, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_EXHAUSTION5_RAID" then
		patternInfo = { "experience", 2, 1, nil, nil, 3, 4, 5, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON" then
		patternInfo = { "experience", 2, 1, nil, nil, nil, nil, nil, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_GROUP" then
		patternInfo = { "experience", 2, 1, nil, nil, nil, nil, nil, 3, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_RAID" then
		patternInfo = { "experience", 2, 1, nil, nil, nil, nil, 3, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED" then
		patternInfo = { "experience", 1, nil, nil, nil, nil, nil, nil, nil, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_GROUP" then
		patternInfo = { "experience", 1, nil, nil, nil, nil, nil, nil, 2, nil, }
	elseif patternName == "COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_RAID" then
		patternInfo = { "experience", 1, nil, nil, nil, nil, nil, 2, nil, nil, }
	elseif patternName == "COMBATLOG_XPLOSS_FIRSTPERSON_UNNAMED" then
		patternInfo = { "experience", 1, nil, nil, nil, nil, nil, nil, nil, nil, }
	
	elseif patternName == "SPELLEXTRAATTACKSOTHER" then
		patternInfo = { "extraattack", 1, 3, 2, }
	elseif patternName == "SPELLEXTRAATTACKSOTHER_SINGULAR" then
		patternInfo = { "extraattack", 1, 3, 2, }
	elseif patternName == "SPELLEXTRAATTACKSSELF" then
		patternInfo = { "extraattack", ParserLib_SELF, 2, 1, }
	elseif patternName == "SPELLEXTRAATTACKSSELF_SINGULAR" then
		patternInfo = { "extraattack", ParserLib_SELF, 2, 1, }
	
	elseif patternName == "AURAREMOVEDOTHER" then
		patternInfo = { "fade", 2, 1, }
	elseif patternName == "AURAREMOVEDSELF" then
		patternInfo = { "fade", ParserLib_SELF, 1, }
	
	elseif patternName == "SPELLFAILCASTSELF" then
		patternInfo = { "fail", ParserLib_SELF, 1, 2, }
	elseif patternName == "SPELLFAILPERFORMSELF" then
		patternInfo = { "fail", ParserLib_SELF, 1, 2, }
	
	elseif patternName == "FEEDPET_LOG_FIRSTPERSON" then
		patternInfo = { "feedpet", ParserLib_SELF, 1, }
	elseif patternName == "FEEDPET_LOG_THIRDPERSON" then
		patternInfo = { "feedpet", 1, 2, }
	
	elseif patternName == "POWERGAINOTHEROTHER" then
		patternInfo = { "gain", 4, 1, 5, 2, 3, }
	elseif patternName == "POWERGAINOTHERSELF" then
		patternInfo = { "gain", 3, ParserLib_SELF, 4, 1, 2, }
	elseif patternName == "POWERGAINSELFOTHER" then
		patternInfo = { "gain", ParserLib_SELF, 1, 4, 2, 3, }
	elseif patternName == "POWERGAINSELFSELF" then
		patternInfo = { "gain", ParserLib_SELF, ParserLib_SELF, 3, 1, 2, }
	
	elseif patternName == "HEALEDCRITOTHEROTHER" then
		patternInfo = { "heal", 1, 3, 2, 4, true, nil, }
	elseif patternName == "HEALEDCRITOTHERSELF" then
		patternInfo = { "heal", 1, ParserLib_SELF, 2, 3, true, nil, }
	elseif patternName == "HEALEDCRITSELFOTHER" then
		patternInfo = { "heal", ParserLib_SELF, 2, 1, 3, true, nil, }
	elseif patternName == "HEALEDCRITSELFSELF" then
		patternInfo = { "heal", ParserLib_SELF, ParserLib_SELF, 1, 2, true, nil, }
	elseif patternName == "HEALEDOTHEROTHER" then
		patternInfo = { "heal", 1, 3, 2, 4, nil, nil, }
	elseif patternName == "HEALEDOTHERSELF" then
		patternInfo = { "heal", 1, ParserLib_SELF, 2, 3, nil, nil, }
	elseif patternName == "HEALEDSELFOTHER" then
		patternInfo = { "heal", ParserLib_SELF, 2, 1, 3, nil, nil, }
	elseif patternName == "HEALEDSELFSELF" then
		patternInfo = { "heal", ParserLib_SELF, ParserLib_SELF, 1, 2, nil, nil, }
	elseif patternName == "PERIODICAURAHEALOTHEROTHER" then
		patternInfo = { "heal", 3, 1, 4, 2, nil, true, }
	elseif patternName == "PERIODICAURAHEALOTHERSELF" then
		patternInfo = { "heal", 2, ParserLib_SELF, 3, 1, nil, true, }
	elseif patternName == "PERIODICAURAHEALSELFOTHER" then
		patternInfo = { "heal", ParserLib_SELF, 1, 3, 2, nil, true, }
	elseif patternName == "PERIODICAURAHEALSELFSELF" then
		patternInfo = { "heal", ParserLib_SELF, ParserLib_SELF, 2, 1, nil, true, }
	
	elseif patternName == "COMBATHITCRITOTHEROTHER" then
		patternInfo = { "hit", 1, 2, ParserLib_MELEE, 3, nil, true, nil, nil, }
	elseif patternName == "COMBATHITCRITOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, ParserLib_MELEE, 2, nil, true, nil, nil, }
	elseif patternName == "COMBATHITCRITSCHOOLOTHEROTHER" then
		patternInfo = { "hit", 1, 2, ParserLib_MELEE, 3, 4, true, nil, nil, }
	elseif patternName == "COMBATHITCRITSCHOOLOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, ParserLib_MELEE, 2, 3, true, nil, nil, }
	elseif patternName == "COMBATHITCRITSCHOOLSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 1, ParserLib_MELEE, 2, 3, true, nil, nil, }
	elseif patternName == "COMBATHITCRITSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 1, ParserLib_MELEE, 2, nil, true, nil, nil, }
	elseif patternName == "COMBATHITOTHEROTHER" then
		patternInfo = { "hit", 1, 2, ParserLib_MELEE, 3, nil, nil, nil, nil, }
	elseif patternName == "COMBATHITOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, ParserLib_MELEE, 2, nil, nil, nil, nil, }
	elseif patternName == "COMBATHITSCHOOLOTHEROTHER" then
		patternInfo = { "hit", 1, 2, ParserLib_MELEE, 3, 4, nil, nil, nil, }
	elseif patternName == "COMBATHITSCHOOLOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, ParserLib_MELEE, 2, 3, nil, nil, nil, }
	elseif patternName == "COMBATHITSCHOOLSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 1, ParserLib_MELEE, 2, 3, nil, nil, nil, }
	elseif patternName == "COMBATHITSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 1, ParserLib_MELEE, 2, nil, nil, nil, nil, }
	elseif patternName == "DAMAGESHIELDOTHEROTHER" then
		patternInfo = { "hit", 1, 4, ParserLib_DAMAGESHIELD, 2, 3, nil, nil, nil, }
	elseif patternName == "DAMAGESHIELDOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, ParserLib_DAMAGESHIELD, 2, 3, nil, nil, nil, }
	elseif patternName == "DAMAGESHIELDSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 3, ParserLib_DAMAGESHIELD, 1, 2, nil, nil, nil, }
	elseif patternName == "PERIODICAURADAMAGEOTHEROTHER" then
		patternInfo = { "hit", 4, 1, 5, 2, 3, nil, true, nil, }
	elseif patternName == "PERIODICAURADAMAGEOTHERSELF" then
		patternInfo = { "hit", 3, ParserLib_SELF, 4, 1, 2, nil, true, nil, }
	elseif patternName == "PERIODICAURADAMAGESELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 1, 4, 2, 3, nil, true, nil, }
	elseif patternName == "PERIODICAURADAMAGESELFSELF" then
		patternInfo = { "hit", ParserLib_SELF, ParserLib_SELF, 3, 1, 2, nil, true, nil, }
	elseif patternName == "SPELLLOGCRITOTHEROTHER" then
		patternInfo = { "hit", 1, 3, 2, 4, nil, true, nil, nil, }
	elseif patternName == "SPELLLOGCRITOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, 2, 3, nil, true, nil, nil, }
	elseif patternName == "SPELLLOGCRITSCHOOLOTHEROTHER" then
		patternInfo = { "hit", 1, 3, 2, 4, 5, true, nil, nil, }
	elseif patternName == "SPELLLOGCRITSCHOOLOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, 2, 3, 4, true, nil, nil, }
	elseif patternName == "SPELLLOGCRITSCHOOLSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 2, 1, 3, 4, true, nil, nil, }
	elseif patternName == "SPELLLOGCRITSCHOOLSELFSELF" then
		patternInfo = { "hit", ParserLib_SELF, ParserLib_SELF, 1, 2, 3, true, nil, nil, }
	elseif patternName == "SPELLLOGCRITSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 2, 1, 3, nil, true, nil, nil, }
	elseif patternName == "SPELLLOGCRITSELFSELF" then
		patternInfo = { "hit", ParserLib_SELF, ParserLib_SELF, 1, 2, nil, true, nil, nil, }
	elseif patternName == "SPELLLOGOTHEROTHER" then
		patternInfo = { "hit", 1, 3, 2, 4, nil, nil, nil, nil, }
	elseif patternName == "SPELLLOGOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, 2, 3, nil, nil, nil, nil, }
	elseif patternName == "SPELLLOGSCHOOLOTHEROTHER" then
		patternInfo = { "hit", 1, 3, 2, 4, 5, nil, nil, nil, }
	elseif patternName == "SPELLLOGSCHOOLOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, 2, 3, 4, nil, nil, nil, }
	elseif patternName == "SPELLLOGSCHOOLSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 2, 1, 3, 4, nil, nil, nil, }
	elseif patternName == "SPELLLOGSCHOOLSELFSELF" then
		patternInfo = { "hit", ParserLib_SELF, ParserLib_SELF, 1, 2, 3, nil, nil, nil, }
	elseif patternName == "SPELLLOGSELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 2, 1, 3, nil, nil, nil, nil, }
	elseif patternName == "SPELLLOGSELFSELF" then
		patternInfo = { "hit", ParserLib_SELF, ParserLib_SELF, 1, 2, nil, nil, nil, nil, }
	elseif patternName == "SPELLSPLITDAMAGEOTHEROTHER" then
		patternInfo = { "hit", 1, 3, 2, 4, nil, nil, nil, true, }
	elseif patternName == "SPELLSPLITDAMAGEOTHERSELF" then
		patternInfo = { "hit", 1, ParserLib_SELF, 2, 3, nil, nil, nil, true, }
	elseif patternName == "SPELLSPLITDAMAGESELFOTHER" then
		patternInfo = { "hit", ParserLib_SELF, 2, 1, 3, nil, nil, nil, true, }
	
	elseif patternName == "COMBATLOG_DISHONORGAIN" then
		patternInfo = { "honor", nil, 1, nil, }
	elseif patternName == "COMBATLOG_HONORAWARD" then
		patternInfo = { "honor", 1, nil, nil, }
	elseif patternName == "COMBATLOG_HONORGAIN" then
		patternInfo = { "honor", 3, 1, 2, }
	
	elseif patternName == "SPELLINTERRUPTOTHEROTHER" then
		patternInfo = { "interrupt", 1, 2, 3, }
	elseif patternName == "SPELLINTERRUPTOTHERSELF" then
		patternInfo = { "interrupt", 1, ParserLib_SELF, 2, }
	elseif patternName == "SPELLINTERRUPTSELFOTHER" then
		patternInfo = { "interrupt", ParserLib_SELF, 1, 2, }
	
	elseif patternName == "SPELLPOWERLEECHOTHEROTHER" then
		patternInfo = { "leech", 1, 5, 2, 3, 4, 6, 7, 8, }
	elseif patternName == "SPELLPOWERLEECHOTHERSELF" then
		patternInfo = { "leech", 1, ParserLib_SELF, 2, 3, 4, 5, 6, 7, }
	elseif patternName == "SPELLPOWERLEECHSELFOTHER" then
		patternInfo = { "leech", ParserLib_SELF, 4, 1, 2, 3, ParserLib_SELF, 5, 6, }
	
	elseif patternName == "IMMUNEDAMAGECLASSOTHEROTHER" then
		patternInfo = { "miss", 2, 1, ParserLib_MELEE, "immune", }
	elseif patternName == "IMMUNEDAMAGECLASSOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "immune", }
	elseif patternName == "IMMUNEDAMAGECLASSSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "immune", }
	elseif patternName == "IMMUNEOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "immune", }
	elseif patternName == "IMMUNEOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "immune", }
	elseif patternName == "IMMUNESELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "immune", }
	elseif patternName == "IMMUNESELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, ParserLib_MELEE, "immune", }
	elseif patternName == "IMMUNESPELLOTHEROTHER" then
		patternInfo = { "miss", 2, 1, 3, "immune", }
	elseif patternName == "IMMUNESPELLOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "immune", }
	elseif patternName == "IMMUNESPELLSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, 2, "immune", }
	elseif patternName == "IMMUNESPELLSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "immune", }
	elseif patternName == "MISSEDOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "miss", }
	elseif patternName == "MISSEDOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "miss", }
	elseif patternName == "MISSEDSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "miss", }
	elseif patternName == "PROCRESISTOTHEROTHER" then
		patternInfo = { "miss", 2, 1, 3, "resist", }
	elseif patternName == "PROCRESISTOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "resist", }
	elseif patternName == "PROCRESISTSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, 2, "resist", }
	elseif patternName == "PROCRESISTSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "resist", }
	elseif patternName == "SPELLBLOCKEDOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "block", }
	elseif patternName == "SPELLBLOCKEDOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "block", }
	elseif patternName == "SPELLBLOCKEDSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "block", }
	elseif patternName == "SPELLDEFLECTEDOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "deflect", }
	elseif patternName == "SPELLDEFLECTEDOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "deflect", }
	elseif patternName == "SPELLDEFLECTEDSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "deflect", }
	elseif patternName == "SPELLDEFLECTEDSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "deflect", }
	elseif patternName == "SPELLDODGEDOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "dodge", }
	elseif patternName == "SPELLDODGEDOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "dodge", }
	elseif patternName == "SPELLDODGEDSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "dodge", }
	elseif patternName == "SPELLDODGEDSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "dodge", }
	elseif patternName == "SPELLEVADEDOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "evade", }
	elseif patternName == "SPELLEVADEDOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "evade", }
	elseif patternName == "SPELLEVADEDSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "evade", }
	elseif patternName == "SPELLEVADEDSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "evade", }
	elseif patternName == "SPELLIMMUNEOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "immune", }
	elseif patternName == "SPELLIMMUNEOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "immune", }
	elseif patternName == "SPELLIMMUNESELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "immune", }
	elseif patternName == "SPELLIMMUNESELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "immune", }
	elseif patternName == "SPELLLOGABSORBOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "absorb", }
	elseif patternName == "SPELLLOGABSORBOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "absorb", }
	elseif patternName == "SPELLLOGABSORBSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "absorb", }
	elseif patternName == "SPELLLOGABSORBSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "absorb", }
	elseif patternName == "SPELLMISSOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "miss", }
	elseif patternName == "SPELLMISSOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "miss", }
	elseif patternName == "SPELLMISSSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "miss", }
	elseif patternName == "SPELLMISSSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "miss", }
	elseif patternName == "SPELLPARRIEDOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "parry", }
	elseif patternName == "SPELLPARRIEDOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "parry", }
	elseif patternName == "SPELLPARRIEDSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "parry", }
	elseif patternName == "SPELLPARRIEDSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "parry", }
	elseif patternName == "SPELLREFLECTOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "reflect", }
	elseif patternName == "SPELLREFLECTOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "reflect", }
	elseif patternName == "SPELLREFLECTSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "reflect", }
	elseif patternName == "SPELLREFLECTSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "reflect", }
	elseif patternName == "SPELLRESISTOTHEROTHER" then
		patternInfo = { "miss", 1, 3, 2, "resist", }
	elseif patternName == "SPELLRESISTOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, 2, "resist", }
	elseif patternName == "SPELLRESISTSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 2, 1, "resist", }
	elseif patternName == "SPELLRESISTSELFSELF" then
		patternInfo = { "miss", ParserLib_SELF, ParserLib_SELF, 1, "resist", }
	elseif patternName == "VSABSORBOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "absorb", }
	elseif patternName == "VSABSORBOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "absorb", }
	elseif patternName == "VSABSORBSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "absorb", }
	elseif patternName == "VSBLOCKOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "block", }
	elseif patternName == "VSBLOCKOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "block", }
	elseif patternName == "VSBLOCKSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "block", }
	elseif patternName == "VSDEFLECTOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "deflect", }
	elseif patternName == "VSDEFLECTOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "deflect", }
	elseif patternName == "VSDEFLECTSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "deflect", }
	elseif patternName == "VSDODGEOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "dodge", }
	elseif patternName == "VSDODGEOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "dodge", }
	elseif patternName == "VSDODGESELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "dodge", }
	elseif patternName == "VSEVADEOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "evade", }
	elseif patternName == "VSEVADEOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "evade", }
	elseif patternName == "VSEVADESELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "evade", }
	elseif patternName == "VSIMMUNEOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "immune", }
	elseif patternName == "VSIMMUNEOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "immune", }
	elseif patternName == "VSIMMUNESELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "immune", }
	elseif patternName == "VSPARRYOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "parry", }
	elseif patternName == "VSPARRYOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "parry", }
	elseif patternName == "VSPARRYSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "parry", }
	elseif patternName == "VSRESISTOTHEROTHER" then
		patternInfo = { "miss", 1, 2, ParserLib_MELEE, "resist", }
	elseif patternName == "VSRESISTOTHERSELF" then
		patternInfo = { "miss", 1, ParserLib_SELF, ParserLib_MELEE, "resist", }
	elseif patternName == "VSRESISTSELFOTHER" then
		patternInfo = { "miss", ParserLib_SELF, 1, ParserLib_MELEE, "resist", }
	
	elseif patternName == "FACTION_STANDING_CHANGED" then
		patternInfo = { "reputation", 2, nil, 1, nil, }
	elseif patternName == "FACTION_STANDING_DECREASED" then
		patternInfo = { "reputation", 1, 2, nil, true, }
	elseif patternName == "FACTION_STANDING_INCREASED" then
		patternInfo = { "reputation", 1, 2, nil, nil, }
	end
	
	if not patternInfo then
		-- self:Print("LoadPatternInfo(): Cannot find " .. patternName ); -- debug
		return
	end
	
	local pattern = getglobal(patternName);	-- Get the pattern from GlobalStrings.lua
	
	-- How many regexp tokens in this pattern?
	local tc = 0
	for _ in string.gfind(pattern, "%%%d?%$?([sd])") do 	tc = tc + 1	end
	
	-- Convert string.format tokens into LUA regexp tokens.
	pattern = { self:ConvertPattern(pattern, true) }		

	local n = table.getn(pattern)	
	if n > 1 then	-- Extra return values are the remapped token sequences.
	
		for j in patternInfo do
			if type(patternInfo[j]) == "number" and patternInfo[j] < 100 then
				patternInfo[j] = pattern[patternInfo[j]+1]	-- Remap to correct token sequence.
			end
		end
		
	end	

	patternInfo.tc = tc
	patternInfo.pattern = pattern[1]
	
	return patternInfo

end

-- Fields of the patternTable.
lib.infoMap = {
	hit = { "source", "victim", "skill", "amount", "element", "isCrit", "isDOT", "isSplit" },
	heal = { "source", "victim", "skill", "amount", "isCrit", "isDOT" },
	miss = { "source", "victim", "skill", "missType" },
	death = { "victim", "source", "isItem" },
	debuff = { "victim", "skill", "amountRank" },
	buff = { "victim", "skill", "amountRank" },
	fade = { "victim", "skill" },
	cast = { "source", "skill", "victim", "isBegin", "isVictim" },	
	gain = { "source", "victim", "skill", "amount", "attribute" },
	drain = { "source", "victim", "skill", "amount", "attribute" },
	leech = { "source", "victim", "skill", "amount", "attribute", "sourceGained", "amountGained", "attributeGained" },
	dispel = { "victim", "skill", "source", "isFailed" },
	extraattack = { "victim", "skill", "amount" },
	environment = { "victim", "amount", "damageType" },
	experience = { "amount", "source", "bonusAmount", "bonusType", "penaltyAmount", "penaltyType", "amountRaidPenalty", "amountGroupBonus", "victim" },
	reputation = { "faction", "amount", "rank", "isNegative" },
	feedpet = { "victim", "item" },
	enchant = { "source", "victim", "skill", "item" },
	fail = { "source", "skill", "reason" },
	interrupt = { "source", "victim", "skill" },
	create = { "source", "item" },
	honor = { "amount", "source", "sourceRank" }, -- if amount == nil then isDishonor = true.
	durability = { "source", "skill", "victim", "item" }, -- is not item then isAllItems = true 
	unknown = { "message" },	
}

function lib:GetInfoFieldName(infoType, fieldIndex)
	if self.infoMap[infoType] then
		return self.infoMap[infoType][fieldIndex-1]	-- Skip the first field in patternTable which is 'type'.
	end
end

--------------------------------
--      Load this bitch!      --
--------------------------------
libobj:Register(lib)

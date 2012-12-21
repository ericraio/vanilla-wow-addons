--[[
Name: AceTab-2.0
Revision: $Rev: 16217 $
Developed by: The Ace Development Team (http://www.wowace.com/index.php/The_Ace_Development_Team)
Website: http://www.wowace.com/
Documentation: http://www..wowace.com/index.php/AceTab-2.0
SVN: http://svn.wowace.com/root/trunk/Ace2/AceTab-2.0
Description: A tab-completion library
Dependencies: AceLibrary, AceEvent-2.0
]]

local MAJOR_VERSION = "AceTab-2.0"
local MINOR_VERSION = "$Revision: 16217 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local AceEvent
local AceTab = {}
local _G = getfenv()

local hookedFrames = {}
local framesHooked = {}

function AceTab:RegisterTabCompletion(descriptor, regex, wlfunc, usage, editframes)
	self:argCheck(descriptor, 2, "string")
	self:argCheck(regex, 3, "string", "table")
	self:argCheck(wlfunc, 4, "string", "function", "nil")
	self:argCheck(usage, 5, "string", "function", "boolean", "nil")
	self:argCheck(editframe, 6, "string", "table", "nil")

	if type(regex) == "string" then regex = {regex} end

	if type(wlfunc) == "string" and type(self[wlfunc]) ~= "function" then
		self:error("Cannot register function %q; it does not exist", wlfunc)
	end

	if type(usage) == "string" and type(self[usage]) ~= "function" then
		self:error("Cannot register usage function %q; it does not exist", usage)
	end

	if not editframes then editframes = {"ChatFrameEditBox"} end

	if type(editframes) == "table" and editframes.Show then editframes = {editframes:GetName()} end
	
	for _, frame in pairs(editframes) do
		local Gframe
		if type(frame) == "table" then
			Gframe = frame
			frame  = frame:GetName()
		else
			Gframe = _G[frame]
		end

		if type(Gframe) ~= "table" or not Gframe.Show then
			self:error("Cannot register frame %q; it does not exist", frame)
			frame = nil
		end
		
		if frame then
			if Gframe:GetFrameType() ~= "EditBox" then
				self:error("Cannot register frame %q; it is not an EditBox", frame)
				frame = nil
			else
				if AceEvent and AceEvent:IsFullyInitialized() then
					if not framesHooked[Gframe] then
						framesHooked[Gframe] = true
						local orig = Gframe:GetScript("OnTabPressed")
						if type(orig) ~= "function" then
							orig = function() end
						end
						Gframe:SetScript("OnTabPressed", function()
							if self:OnTabPressed(Gframe) then
								return orig()
							end
						end)
						Gframe.curMatch = 0
						Gframe.matches = {}
						Gframe.pMatchLen = 0
					end
				else
					hookedFrames[frame] = true
				end
			end
		end
	end
	
	if not self.registry[descriptor] then
		self.registry[descriptor] = {}
	end
	
	if not self.registry[descriptor][self] then
		self.registry[descriptor][self] = {}
	end
	self.registry[descriptor][self] = {patterns = regex, wlfunc = wlfunc,  usage = usage, frames = editframes}
	
	
	if not AceEvent and AceLibrary:HasInstance("AceEvent-2.0") then
		external(AceTab, "AceEvent-2.0", AceLibrary("AceEvent-2.0"))
	end
	if AceEvent then
		if not self:IsEventRegistered("AceEvent_FullyInitialized") then
			self:RegisterEvent("AceEvent_FullyInitialized", "AceEvent_FullyInitialized", true)
		end
	end
end

function AceTab:IsTabCompletionRegistered(descriptor)
	self:argCheck(descriptor, 2, "string")
	return self.registry[descriptor] and self.registry[descriptor][self]
end

function AceTab:UnregisterTabCompletion(descriptor)
	self:argCheck(descriptor, 2, "string")
	if self.registry[descriptor] and self.registry[descriptor][self] then
		self.registry[descriptor][self] = nil
	else
		self:error("Cannot unregister a tab completion (%s) that you have not registered.", descriptor)
	end
end

local GCS
GCS = function(s1, s2)
	if not s1 and not s2 then return end
	if not s1 then s1 = s2 end
	if not s2 then s2 = s1 end
	local s1len, s2len = string.len(s1), string.len(s2)
	if s2len < s1len then
		s1, s2 = s2, s1
	end
	if string.find(string.lower(s2), string.lower(s1)) then
		return s1
	else
		return GCS(string.sub(s1, 1, -2), s2)
	end
end
local pos
local function CycleTab()
	this.pMatchLen = string.len(this.lMatch)
	local cMatch = 0
	local matched = false
	for desc, mList in pairs(this.matches) do
		if not matched then
			for _, m in ipairs(mList) do
				cMatch = cMatch + 1
				if cMatch == this.curMatch then
					this.lMatch = m
					this.curMatch = this.curMatch + 1
					matched = true
					break
				end
			end
		end
	end
	if not matched then
		this.curMatch = 1
		this.lMatch = this.origWord
	end
	this:HighlightText(pos - this.pMatchLen, pos)
	this:Insert(this.lMatch)
end

function AceTab:OnTabPressed()
	local ost = this:GetScript("OnTextSet")
	if type(ost) ~= "function" then
		ost = nil
	end
	if ost then this:SetScript("OnTextSet", nil) end
	if this:GetText() == "" then return true end
	this:Insert("\255")
	pos = string.find(this:GetText(), "\255", 1) - 1
	this:HighlightText(pos, pos+1)
	this:Insert("\0")
	if ost then this:SetScript("OnTextSet", ost) end
	local fulltext = this:GetText()
	local text = string.sub(fulltext, 0, pos) or ""

	local left = string.find(string.sub(text, 1, pos), "%w+$")
	left = left and left-1 or pos
	if not left or left == 1 and string.sub(text, 1, 1) == "/" then return true end

	local _, _, word = string.find(string.sub(text, left, pos), "(%w+)")
	word = word or ""
	this.lMatch = this.curMatch > 0 and (this.lMatch or this.origWord)

	if this.lMatch and this.lMatch ~= "" and string.find(string.sub(text, 1, pos), this.lMatch.."$") then
		return CycleTab()
	else
		this.matches = {}
		this.curMatch = 0
		this.lMatch = nil
	end

	local completions = {}
	local numMatches = 0
	local firstMatch, hasNonFallback
	
	for desc, entry in pairs(AceTab.registry) do
		for _, s in pairs(entry) do
			for _, f in pairs(s.frames) do
				if _G[f] == this then
					for _, regex in ipairs(s.patterns) do
						local cands = {}
						if string.find(string.sub(text, 1, left), regex.."$") then
							local c = s.wlfunc(cands, fulltext, left)
							if c ~= false then
								local mtemp = {}
								this.matches[desc] = this.matches[desc] or {}
								for _, cand in ipairs(cands) do
									if string.find(string.lower(cand), string.lower(word), 1, 1) == 1 then
										mtemp[cand] = true
										numMatches = numMatches + 1
										if numMatches == 1 then firstMatch = cand end
									end
								end
								for i in pairs(mtemp) do
									table.insert(this.matches[desc], i)
								end
								this.matches[desc].usage = s.usage
								if regex ~= "" and this.matches[desc][1] then
									hasNonFallback = true
									this.matches[desc].notFallback = true
								end
							end
						end
					end
				end
			end
		end
	end

	local _, set = next(this.matches)
	if not set or numMatches == 0 and not hasNonFallback then return true end
	
	this:HighlightText(left, left + string.len(word))
	if numMatches == 1 then
		this:Insert(firstMatch)
		this:Insert(" ")
	else
		if this.curMatch == 0 then
			this.curMatch = 1
			this.origWord = word
			this.lMatch = word
			CycleTab()
		end
		local gcs
		for h, c in pairs(this.matches) do
			if hasNonFallback and not c.notFallback then break end
			local u = c.usage
			c.usage = nil
			local candUsage = u and {}
			local gcs2
			if next(c) then
				if not u then DEFAULT_CHAT_FRAME:AddMessage(h..":") end
				for _, m in ipairs(c) do
					if not u then DEFAULT_CHAT_FRAME:AddMessage(m) end
					gcs2 = GCS(gcs2, m)
				end
			end
			gcs = GCS(gcs, gcs2)
			if u then
				if type(u) == "function" then
					local us = u(candUsage, c, gcs2, string.sub(text, 1, left))
					if candUsage and next(candUsage) then us = candUsage end
					if type(us) == "string" then
						DEFAULT_CHAT_FRAME:AddMessage(us)
					elseif type(us) == "table" and numMatches > 0 then
						for _, v in ipairs(c) do
							if us[v] then DEFAULT_CHAT_FRAME:AddMessage(string.format("%s - %s", v, us[v])) end
						end
					end
				end
			end
		end
		if curMatch == 0 then
			this:Insert(gcs or word)
		end
	end
end

function AceTab:AceEvent_FullyInitialized()
	for frame in pairs(hookedFrames) do
		local Gframe = _G[frame]
		if not framesHooked[Gframe] then
			framesHooked[Gframe] = true
			local orig = Gframe:GetScript("OnTabPressed")
			if type(orig) ~= "function" then
				orig = function() end
			end
			Gframe:SetScript("OnTabPressed", function()
				if self:OnTabPressed(Gframe) then
					return orig()
				end
			end)
			Gframe.curMatch = 0
			Gframe.matches = {}
			Gframe.pMatchLen = 0
		end
	end
end

local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		if not AceEvent then
			AceEvent = instance
			
			AceEvent:embed(self)
		end
	end
end

local function activate(self, oldLib, oldDeactivate)
	if oldLib then
		self.registry = oldLib.registry
	end

	if not self.registry then
		self.registry = {}
	end

	if oldDeactivate then
		oldDeactivate(oldLib)
	end
end

AceLibrary:Register(AceTab, MAJOR_VERSION, MINOR_VERSION, activate, nil, external)
AceTab = AceLibrary(MAJOR_VERSION)

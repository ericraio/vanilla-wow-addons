local compost = AceLibrary("Compost-2.0")
local parser = ParserLib:GetInstance("1.1")
local roster = AceLibrary("RosterLib-2.0")

-- Link these after all files are loaded.
local defaultFormats
local defaultColors
local L

------------------------
--         Core         --
------------------------

SimpleCombatLog = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDebug-2.0")

-- Return a deep copy of the table.
function SimpleCombatLog.CopyTable(into, from)
	for key, val in pairs(from) do
		if( type(val) == "table" ) then
			if not into[key] then into[key] = {} end
			SimpleCombatLog.CopyTable(into[key], val)
		else
			into[key] = val
		end
	end
	return into
end

--- SimpleCombatLog.modulePrototype.core = SimpleCombatLog

-- Hook the FCF_Tab_OnClick() to check for alt-rightclick.
function SimpleCombatLog:FCF_Tab_OnClick(button)
	if IsAltKeyDown() and button == 'RightButton' then
		self:LoadSettingMenu(this:GetID())
	else
		self.old_FCF_Tab_OnClick(button)
	end
end

-- Hook ChatFrame_OnEvent to suppress the default combat log.
function SimpleCombatLog:ChatFrame_OnEvent(event)
	local id = this:GetID()
	
	-- Note to self: must do ( self.events[event] == nil ) here, cannot do  ( not self.events[event] ), since some events can be 'false' by default.
	if self.events[event] == nil or not id or not self.settings[id] or not self.settings[id].suppress then
		self.old_ChatFrame_OnEvent(event)
	end
end



-- Interested events, the flag are also used as the default theme event settings. (So false has a different meaning to nil here)
SimpleCombatLog.events = {
	['CHAT_MSG_COMBAT_PET_HITS'] = true,
	['CHAT_MSG_COMBAT_PET_MISSES'] = true,
	['CHAT_MSG_COMBAT_SELF_HITS'] = true,
	['CHAT_MSG_COMBAT_SELF_MISSES'] = true,	
	['CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS'] = true,
	['CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES'] = true,
	['CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS'] = true,
	['CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES'] = true,
	['CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS'] = true,
	['CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES'] = true,
	['CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS'] = true,
	['CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES'] = true,
	['CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS'] = true,
	['CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES'] = true,
	['CHAT_MSG_COMBAT_PARTY_HITS'] = true,
	['CHAT_MSG_COMBAT_PARTY_MISSES'] = true,
	['CHAT_MSG_SPELL_PET_BUFF'] = true,
	['CHAT_MSG_SPELL_PET_DAMAGE'] = true,
	['CHAT_MSG_SPELL_SELF_BUFF'] = true,
	['CHAT_MSG_SPELL_SELF_DAMAGE'] = true,
	['CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF'] = true,
	['CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE'] = true,
	['CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF'] = true,
	['CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE'] = true,
	['CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF'] = true,
	['CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE'] = true,
	['CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF'] = true,
	['CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE'] = true,
	['CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF'] = true,
	['CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE'] = true,
	['CHAT_MSG_SPELL_PARTY_BUFF'] = true,
	['CHAT_MSG_SPELL_PARTY_DAMAGE'] = true,
	['CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS'] = true,
	['CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE'] = true,
	['CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS'] = true,	
	['CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF'] = true,	
	['CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS'] = true,
	['CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE'] = true,
	['CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS'] = true,
	['CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE'] = true,
	['CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS'] = true,
	['CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE'] = true,
	['CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS'] = true,
	['CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE'] = true,
	['CHAT_MSG_SPELL_AURA_GONE_OTHER'] = true,
	['CHAT_MSG_SPELL_AURA_GONE_SELF'] = true,
	['CHAT_MSG_SPELL_AURA_GONE_PARTY'] = true,
	['CHAT_MSG_SPELL_BREAK_AURA'] = true,
	['CHAT_MSG_COMBAT_FRIENDLY_DEATH'] = true,
	['CHAT_MSG_COMBAT_HOSTILE_DEATH'] = true,
	['CHAT_MSG_SPELL_ITEM_ENCHANTMENTS'] = true,
	['CHAT_MSG_COMBAT_XP_GAIN'] = true,
	['CHAT_MSG_COMBAT_HONOR_GAIN'] = true,
	['CHAT_MSG_COMBAT_FACTION_CHANGE'] = true,
	['CHAT_MSG_SPELL_TRADESKILLS'] = true,
	['CHAT_MSG_SPELL_FAILED_LOCALPLAYER'] = false,
}

SimpleCombatLog.defaultColors = {

	player = "7f7fff",
	pet = "7f4c26",
	raid = "ff7133",
	party = "a5ffa5",
	target = "ff77ff",
	targettarget = "994c99",
	other = "ffffff",
	
	physical = "ffffff",
	holy = "ffff4c",
	fire = "ff262d",
	nature = "66ff66",
	frost = "4c4ce5",
	shadow = "ffb2ff",
	arcane = "bfbfbf",
	
	heal = "ffff4c",
	miss = "ff7f7f",
	buff = "33ff33",
	debuff = "ff3333",
	skill = "ffff66",
	
	dirty = "eda55f",
}


function SimpleCombatLog:OnInitialize()
	
	defaultFormats = self.loc.defaultFormats
	defaultColors = self.defaultColors
	L = self.loc.core
	
	-- nil out the localization table, so that unused part will be GC'ed out.
	self.loc = nil
	
	self.old_FCF_Tab_OnClick = FCF_Tab_OnClick
	FCF_Tab_OnClick = function(button) self:FCF_Tab_OnClick(button) end
	
	self.old_ChatFrame_OnEvent = ChatFrame_OnEvent
	ChatFrame_OnEvent = function(event) self:ChatFrame_OnEvent(event) end

	-- index to Blizzard chat frames.
	self.chatFrames = { ChatFrame1, ChatFrame2, ChatFrame3, ChatFrame4, ChatFrame5, ChatFrame6, ChatFrame7 } 
	
	self:RegisterChatCommand( { "/scl" }, {
		type = 'group',
		args = {
			help = {	
				type = 'execute',
				name = 'help',
				desc = L["CmdHelpDesc"],
				func = "ShowHelp",
			},
			reset = {
				type = 'execute',
				name = 'reset',
				desc = L["CmdResetDesc"],
				func = "LoadInitialSettings",
			},
			show = {
				type = 'text',
				name = 'show',
				desc = L["CmdShowDesc"],
				get = false,
				set = function(id) self:LoadSettingMenu(tonumber(id)) end,
-- 				input = true, 	-- dunno why, this isn't working.
				validate = { '1', '2', '3', '4', '5', '6', '7' },
				usage = "<ChatFrame ID>",
			}
		}
	} )
	

	self:InitGlobalDB()
	self:LoadThemes()

	self.settings = {}

	self:InitPerCharDB()
	self:LoadSettings()
	
	if self.firstLoad then
		self:LoadInitialSettings()
		self:ShowHelp()
	end

	
end

function SimpleCombatLog:InitGlobalDB()
	
	if not SimpleCombatLogDB or not SimpleCombatLogDB.version then
		self:Print("SCL version changed, resetting global data.")
		SimpleCombatLogDB = {
			version = self.version,
			themes = {}
		}
	end
	
	self.themeDB = SimpleCombatLogDB.themes	
end

function SimpleCombatLog:InitPerCharDB()

	if not SimpleCombatLogDBPerChar or not SimpleCombatLogDBPerChar.version then
		self:Print("SCL version changed, resetting per-char data.")
		self.firstLoad = true		
		SimpleCombatLogDBPerChar = {
			version = self.version,
			settings = {}
		}
	end	
	
	self.settingDB = SimpleCombatLogDBPerChar.settings
end

-- Load themes into 
function SimpleCombatLog:LoadThemes()
	for i, theme in pairs(self.themeDB) do
		self.themes[i] = theme
	end	
end

function SimpleCombatLog:SetTheme(id, themeName)
	local themeTable
	
	if self.themes[themeName] then
		self.settingDB[id] = themeName
		self.settings[id] = self.themes[themeName]
	end		
	
	self:RefreshSettings()
end

function SimpleCombatLog:LoadSettings()
	for id, setting in pairs(self.settingDB) do
		if type(setting) == 'string' then -- this is a theme.
			self:SetTheme(id, setting)
			-- self.settings[id] = self.themes[setting]
		else
			self.settings[id] = setting
		end
	end
end

function SimpleCombatLog:ShowHelp()
	for i, msg in ipairs(L["Welcome"]) do
		self:Print(msg)
	end
end

function SimpleCombatLog:OnEnable()
	self:RefreshSettings()
end

function SimpleCombatLog:OnDisable()
	parser:UnregisterAllEvents("SimpleCombatLog")
end


function SimpleCombatLog:OnCombatEvent(event, info)
	self:Debug("OnCombatEvent", event, arg1, info.type)

	-- Parse for the message type.
	local infoType = info.type
	local msgType
	if infoType == 'hit' then
		if info.isCrit then 
			msgType = 'hitCrit'
		elseif info.isDOT then 
			msgType = 'hitDOT'
		else
			msgType = 'hit'
		end
	elseif infoType == 'heal' then
		if info.isCrit then
			msgType = 'healCrit'
		elseif info.isDOT then
			msgType = 'healDOT'
		else
			msgType = 'heal'
		end
	elseif infoType == 'dispel' then
		if info.isFailed then
			msgType = 'dispelFailed'
		else
			msgType = 'dispel'
		end
	elseif infoType == 'cast' then
		if info.isBegin then
			msgType = 'castBegin'
		elseif info.victim then
			msgType = 'castTargeted'
		else
			msgType = 'cast'
		end
	elseif infoType == 'honor' then
		if not info.amount then
			msgType = 'dishonor'
		elseif info.source then
			msgType = 'honorKill'
		else
			msgType = 'honor'
		end
	elseif info.type == 'reputation' then
		if info.rank then
			msgType = 'reputationRank'
		elseif info.isNegative then
			msgType = 'reputationMinus'
		else
			msgType = 'reputation'
		end
	elseif info.type == 'death' then
		if info.source then
			msgType = 'deathSource'
		elseif info.skill then
			msgType = 'deathSkill'
		else
			msgType = 'death'
		end
	elseif info.type == 'unknown' then
		ChatFrame1:AddMessage(string.format("%s: %s", event, info.message),1,0,0)
		return
	else
		msgType = infoType
	end

	-- Get necessary fields out of info table.
	local tokens = compost:Acquire()
	local fields = defaultFormats[msgType][2]
	for i, v in pairs(fields) do
		tokens[v] = info[v]
	end
	
	-- Common conversion for all chat frames.
	if tokens.skill == ParserLib_MELEE then tokens.skill = L["Melee"] end
	if tokens.skill == ParserLib_DAMAGESHIELD then tokens.skill = L["Damage Shields"] end
	
	if infoType == 'hit' then
		if not info.element then
			tokens.element = 'physical'
		else
			tokens.element = self:GetElementType(info.element)
		end
	elseif infoType == 'heal' then
		tokens.element = 'heal'
	elseif infoType == 'buff' or infoType == 'debuff' then
		if info.amountRank then
			tokens.skill = string.format("%s(%d)", tokens.skill, info.amountRank)
		end
		tokens.element = infoType
	elseif infoType == 'durability' then
		if not tokens.item then tokens.item = L["All Items"] end
	elseif infoType == 'miss' then
		tokens.missType = L.missType[tokens.missType]
	elseif infoType == 'environment' then
		tokens.damageType = L.damageType[tokens.damageType]
	end

	for id, settings in pairs(self.settings) do
		if settings.events and settings.events[event] and self:FilterCheck(id, info) then
			if infoType == 'hit' or infoType == 'environment' then
				tokens.trailers = self:GetTrailerString(id, info)
			elseif info.type == 'experience' then
				tokens.trailers = self:GetExpTrailerString(id, info)
			end
			self:ParseInfo(id, msgType, tokens)
		end
	end
	
	compost:Reclaim(tokens)

end

function SimpleCombatLog:ParseInfo(id, msgType, tokens)
	self:Debug("ParseInfo", id, msgType)
	
	local settings = self.settings[id]
	
	local myTokens = compost:Acquire()
	for i, v in pairs(tokens) do
		myTokens[i] = v
	end
	
	if myTokens.source then 
		if myTokens.source == ParserLib_SELF then
			myTokens.source = self:Colorize(L["You"], self:GetColorHex(id, 'player' ) )
		else
			myTokens.source = self:Colorize(myTokens.source, self:GetColorHex(id, self:GetUnitType(myTokens.source, true) ) )
		end
	end	
	if myTokens.victim then 
		if myTokens.victim == ParserLib_SELF then
			myTokens.victim = self:Colorize(L["You"], self:GetColorHex(id, 'player' ) )
		else
			myTokens.victim = self:Colorize(myTokens.victim, self:GetColorHex(id, self:GetUnitType(myTokens.victim, true) ) )
		end
	end
	if myTokens.sourceGained then 
		if myTokens.sourceGained == ParserLib_SELF then
			myTokens.sourceGained = self:Colorize(L["You"], self:GetColorHex(id, 'player' ) )
		else
			myTokens.sourceGained = self:Colorize(myTokens.sourceGained, self:GetColorHex(id, self:GetUnitType(myTokens.sourceGained, true) ) )
		end
	end	
	
	if myTokens.skill then
		if	settings.colorspell and myTokens.element then
			myTokens.skill = self:Colorize(myTokens.skill, self:GetColorHex(id, myTokens.element) )
		else
			myTokens.skill = self:Colorize(myTokens.skill, self:GetColorHex(id, "skill") )
		end
	end
	
	if myTokens.amount and myTokens.element then
		myTokens.amount = self:Colorize(myTokens.amount, self:GetColorHex(id, myTokens.element) )
	end
	
	local fields = defaultFormats[msgType][2]
	local fieldCount = table.getn(fields)
	
	local outputString
	if fieldCount == 0 then
		outputString = self:GetFormat(id, msgType)
	elseif fieldCount == 1 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ] )
	elseif fieldCount == 2 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ] )
	elseif fieldCount == 3 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ], myTokens[fields[3] ] )
	elseif fieldCount == 4 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ], myTokens[fields[3] ], myTokens[fields[4] ] )
	elseif fieldCount == 5 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ], myTokens[fields[3] ], myTokens[fields[4] ], myTokens[fields[5] ] )
	elseif fieldCount == 6 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ], myTokens[fields[3] ], myTokens[fields[4] ], myTokens[fields[5] ], myTokens[fields[6] ] )
	elseif fieldCount == 7 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ], myTokens[fields[3] ], myTokens[fields[4] ], myTokens[fields[5] ], myTokens[fields[6] ], myTokens[fields[7] ] )
	elseif fieldCount == 8 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ], myTokens[fields[3] ], myTokens[fields[4] ], myTokens[fields[5] ], myTokens[fields[6] ], myTokens[fields[7] ], myTokens[fields[8] ] )
	elseif fieldCount == 9 then
		outputString = string.format( self:GetFormat(id, msgType), myTokens[fields[1] ], myTokens[fields[2] ], myTokens[fields[3] ], myTokens[fields[4] ], myTokens[fields[5] ], myTokens[fields[6] ], myTokens[fields[7] ], myTokens[fields[8] ], myTokens[fields[9] ] )
	end
	

	-- Get the ChatFrame to display.
	
	local chatframe
	if type(id) == 'number' then -- this is a default chat frame.
		chatframe = getglobal("ChatFrame" .. id)
	elseif type(id) == 'string' then -- this is a custom chat frame.
		chatframe = getglobal(id)
	end
	
	if chatframe then
		if settings.colorEvent then
			local e = string.sub(event, 10)
			local info = ChatTypeInfo[e]
			chatframe:AddMessage(outputString, info.r, info.g, info.b)
		else	
			chatframe:AddMessage(outputString)
		end
	end

	compost:Reclaim(myTokens)

	
end

function SimpleCombatLog:Colorize(text, hexColor)
	return string.format('|cff%s%s|r', hexColor, text)
end


function SimpleCombatLog:GetValue(id, field)
	if not self.settings[id] then
		return false
	else
		return self.settings[id][field]
	end
end


function SimpleCombatLog:GetEvent(id, event)
	local db = self.settings[id]
	if not db or not db.events or not db.events[event] then
		return false
	else
		return db.events[event]
	end
end


SimpleCombatLog.filterFlags = {
	{
		player = 1,
		pet = 2,
		party = 3,
		raid = 4,
		target = 5,
		targettarget = 6,
		other = 7		
	},
	{
		player = 8,
		pet = 9,
		party = 10,
		raid = 11,
		target = 12,
		targettarget = 13,
		other = 14	
	}
}

function SimpleCombatLog:GetFilter(id, filterType, nameFilter, isSource)
	local db = self.settings[id]
	if not db or not db.filters or not db.filters[filterType] then
		return false
	else	
		local source
		if isSource then source = 1 else source = 2 end
		local flag = self.filterFlags[source][nameFilter]
		return db.filters[filterType][flag]
	end
end




-- Return values: hex, isDefault
function SimpleCombatLog:GetColorHex(id, colorType)
	assert( id and colorType )
	local hex, isDefault
	if not self.settings[id] or not self.settings[id].colors or not self.settings[id].colors[colorType] then
		hex = defaultColors[colorType]	
		isDefault = true
	else
		hex = self.settings[id].colors[colorType]
		isDefault = false
	end
	return hex, isDefault
end




function SimpleCombatLog:GetFormat(id, msgType)
	assert( id and msgType )
	local db = self.settings[id]
	if not db or not db.formats or not db.formats[msgType] then
		return defaultFormats[msgType][1], true
	else
		return db.formats[msgType], false
	end
end


function SimpleCombatLog:GetWatchList(id, watchType)
	local db = self.settings[id]
	if db and db.watchList and db.watchList[watchType] then
		return db.watchList[watchType]
	end
end


function SimpleCombatLog:RefreshSettings()

	local usedEvents = {}
	
	for event in pairs(self.events) do
		for j in pairs(self.settings) do			
			if self:GetEvent(j, event) then
				usedEvents[event] = true
				if not parser:IsEventRegistered("SimpleCombatLog", event) then
					parser:RegisterEvent("SimpleCombatLog", event, function(event, info) self:OnCombatEvent(event, info) end)
				end
			end
			
		end
	end

	
	-- Unregister non-used events from ParserLib.
	for event in pairs(self.events) do
		if not usedEvents[event] and parser:IsEventRegistered("SimpleCombatLog", event) then
			parser:UnregisterEvent("SimpleCombatLog", event)
		end
	end
	

	for id, setting in self.settings do
		local chatframe = getglobal("ChatFrame" .. id)
		if chatframe then
			if setting.resize then				
				chatframe:SetMaxResize(1000, 700)
				chatframe:SetMinResize(40, 40)	
			else
				chatframe:SetMaxResize(608, 400)
				chatframe:SetMinResize(296, 75)		
			end
		end
	end
		
	

end

-- Get constant element string from localized element string.
function SimpleCombatLog:GetElementType(element)
	for elementType, keyword in self.fixCombatLog do
		if element == keyword then
			return elementType
		end
	end
		
--[[
	if element == SPELL_SCHOOL0_CAP then return 'physical'
	elseif element == SPELL_SCHOOL1_CAP then return 'holy'
	elseif element == SPELL_SCHOOL2_CAP then return 'fire'
	elseif element == SPELL_SCHOOL3_CAP then return 'nature'
	elseif element == SPELL_SCHOOL4_CAP then return 'frost'
	elseif element == SPELL_SCHOOL5_CAP then return 'shadow'
	elseif element == SPELL_SCHOOL6_CAP then return 'arcane'
	end
]]
	self:Debug("Unknown element:", element)
	return 'physical'
end

-- Get trailer string by parsing info.
function SimpleCombatLog:GetTrailerString(id, info)
	local trailer = ''
	if info.isCrushing then trailer = trailer .. self:GetFormat(id, 'crushing')end
	if info.isGlancing then trailer = trailer .. self:GetFormat(id, 'glancing')end
	if info.amountAbsorb then trailer = trailer .. format(self:GetFormat(id, 'absorb'), info.amountAbsorb) end
	if info.amountResist then trailer = trailer .. format(self:GetFormat(id, 'resist'), info.amountResist) end
	if info.amountBlock then trailer = trailer .. format(self:GetFormat(id, 'block'), info.amountBlock) end
	if info.amountVulnerable then trailer = trailer .. format(self:GetFormat(id, 'vulnerable'), info.amountVulnerable) end
	return trailer
end

function SimpleCombatLog:GetExpTrailerString(id, info)
	local trailer = ''
	if info.source then trailer = trailer .. format(self:GetFormat(id, 'expSource'), info.source) end
	if info.bonusAmount then 
		trailer = trailer .. format(self:GetFormat(id, 'expBonus'), info.bonusType, info.bonusAmount) 
	elseif info.penaltyAmount then
		trailer = trailer .. format(self:GetFormat(id, 'expBonus'), info.penaltyType, info.penaltyAmount) 
	end
	if info.amountGroupBonus then
		trailer = trailer .. format(self:GetFormat(id, 'expGroup'), info.amountGroupBonus)
	elseif info.amountRaidPenalty  then
		trailer = trailer .. format(self:GetFormat(id, 'expRaid'), info.amountGroupBonus)
	end
	return trailer
end

-- Check for the filter settings, return true if this message can be shown, false if the message is filtered.
function SimpleCombatLog:FilterCheck(id, info)
	
	-- These message ignore name filters.
	if info.type == 'experience'
	or info.type == 'honor'
	or info.type == 'reputation' 
	or info.type == 'fail' then
		return true
	end	
	
	if not self.settings[id] then
		return true
	end
	
	local watch = self:GetWatchList(id, 'skill')
	
	-- Custom skill watch?
	if watch and info.skill and watch[info.skill] then
		return true
	end
	
	
	-- Checking names
	if not info.source and not info.victim then return true end
	
	if info.source then
		local name = info.source
		
		-- Custom name watch.
		watch = self:GetWatchList(id, 'source')
		if watch and watch[name]  then return true end
		
		if self:GetFilter(id, info.type, self:GetUnitType(name), true) then
			return true
		end
		if self:IsTarget(name) and self:GetFilter(id, info.type, 'target', true) then
			return true
		end
		if self:IsTargetTarget(name) and self:GetFilter(id, info.type, 'targettarget', true) then
			return true
		end
	end
	
	if info.victim then
		local name = info.victim
		
		-- Custom name watch.
		watch = self:GetWatchList(id, 'victim')
		if watch and watch[name]  then return true end
		
		if self:GetFilter(id, info.type, self:GetUnitType(name)) then
			return true
		end
		if self:IsTarget(name) and self:GetFilter(id, info.type, 'target') then
			return true
		end
		if self:IsTargetTarget(name) and self:GetFilter(id, info.type, 'targettarget') then
			return true
		end
	end
	
	-- The message does not match any filter setting, block.
	return false
	
end

function SimpleCombatLog:IsTarget(name)
	return name == UnitName("target")
end

function SimpleCombatLog:IsTargetTarget(name)
	return name == UnitName("targettarget")
end


-- Get what is this name : player, pet, party, raid, or others.
function SimpleCombatLog:GetUnitType(name, checkTarget)
	if not name then return end
	
	if checkTarget then
		if name == UnitName('target') then return 'target' end
		if name == UnitName('targettarget') then return 'targettarget' end
	end
	
	if name == ParserLib_SELF then return 'player' end
		
	-- This is NOT player, but someone which has an identical name to player ( most likely a pet name).
	if name == UnitName('player') then return 'other' end	

	local unit = roster:GetUnitIDFromName(name)
	
	if not unit then return 'other' end
	
	if unit == 'pet' then return 'pet' end
	
	if string.find(unit, 'party', 1, true) then return 'party' end
	
	return 'raid'
	
end


function SimpleCombatLog:LoadInitialSettings()
	SimpleCombatLogDB = nil
	SimpleCombatLogDBPerChar = nil
	self:InitGlobalDB()
	self:InitPerCharDB()
	self.settings = {}
	self:SetTheme(2, 'default')
	self:Print("Loaded default settings (custom themes will exist until next login).")
end

function SimpleCombatLog:LoadSettingMenu(id)
	if not self.ShowSettingMenu then
		self:Print("Dropdown menu component is not loaded.")
	else
		self:ShowSettingMenu(id)
	end
end


-- Save the table as base locales if there isn't one, update the current locales if there is one.
function SimpleCombatLog:UpdateLocales(loc)
	if not self.loc then
		self.loc = loc
	else
		self.CopyTable(self.loc, loc)
	end
end



local parser = ParserLib:GetInstance("1.1")
local dewdrop = DewdropLib:GetInstance("1.0")
local version = "0.4.7"



SimpleCombatLog = {}
local self = SimpleCombatLog


-- Unnamed frame for events.
if not self.frame then
	self.frame = CreateFrame("Frame");
	self.frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	self.frame:SetScript("OnEvent", function() self:OnEvent() end );
end


-- Event handler for ParserLib.
local function OnCombatEvent(event, info)
	self:OnCombatEvent(event, info)
end



-- Search for the event in eventList.
local function SearchList(list, text)
	for i in list do
		for j in list[i] do
			if list[i][j] == text then return true end
		end
	end
end


		

self.eventTypes = {
	"selfhit", 
	"otherhit", 
	"selfspell", 
	"otherspell", 
	"selfdot", 
	"otherdot", 
	"death", 
	"aura", 
	"enchant", 
	"trade",
	"experience", 
	"honor", 
	"reputation",
	"fail",
}



self.eventList = {

	otherhit = {
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
		"CHAT_MSG_COMBAT_PARTY_HITS",
		"CHAT_MSG_COMBAT_PARTY_MISSES",
	},
		
	reputation = {
		"CHAT_MSG_COMBAT_FACTION_CHANGE",
	},
		
	death = {
		"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
		"CHAT_MSG_COMBAT_HOSTILE_DEATH",
	},

	honor = {
		"CHAT_MSG_COMBAT_HONOR_GAIN",
	},

	selfhit = {
		"CHAT_MSG_COMBAT_PET_HITS",
		"CHAT_MSG_COMBAT_PET_MISSES",
		"CHAT_MSG_COMBAT_SELF_HITS",
		"CHAT_MSG_COMBAT_SELF_MISSES",
		
	},
	
	experience = {
		"CHAT_MSG_COMBAT_XP_GAIN",
	},
	
	aura = {
		"CHAT_MSG_SPELL_AURA_GONE_OTHER",
		"CHAT_MSG_SPELL_AURA_GONE_SELF",
		"CHAT_MSG_SPELL_AURA_GONE_PARTY",
		"CHAT_MSG_SPELL_BREAK_AURA",
	},
	
	otherspell = {
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PARTY_BUFF",
		"CHAT_MSG_SPELL_PARTY_DAMAGE",
	},


	fail = {
		"CHAT_MSG_SPELL_FAILED_LOCALPLAYER",
	},
	
	enchant = {
		"CHAT_MSG_SPELL_ITEM_ENCHANTMENTS",
	},
	
	otherdot = {
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
	},


	selfdot = {
		"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
	},
	
	selfspell = {
		"CHAT_MSG_SPELL_PET_BUFF",
		"CHAT_MSG_SPELL_PET_DAMAGE",
		"CHAT_MSG_SPELL_SELF_BUFF",
		"CHAT_MSG_SPELL_SELF_DAMAGE",
	},

	trade = {
		"CHAT_MSG_SPELL_TRADESKILLS",
	}
}




function SimpleCombatLog:Colorize(value, valueType)
	local c = self:GetColor(valueType)
	
	if not c then return value end

	if not c.b or not c.g or not c.r then
		self:Print("Invalid color field for value " .. valueType, 1, true, 1, 0, 0)
	end
	
	return string.format("|cff%02x%02x%02x%s|r", (c.r*255), (c.g*255), (c.b*255), value)

end

function SimpleCombatLog:GetColor(valueType)
	if not self.savedVars.colors or not self.savedVars.colors[valueType] then
		return self.defaultColors[valueType]
	else
		return self.savedVars.colors[valueType]
	end
end





function SimpleCombatLog:OnEvent()
	if event == "PLAYER_ENTERING_WORLD" then
		self:Initialize()
	end
end

function SimpleCombatLog:Initialize()

	if self.initialized then return end
	
	
	-- Checking saved variables.	
	if not SCL_Config then self:LoadDefaultSettings() else self.savedVars = SCL_Config end

	-- Check for old version saved variables.
	if self.savedVars and not self.savedVars.events then self:LoadDefaultSettings()	end

	if not self.savedVars.minimapButton then self.savedVars.minimapButton = {} end
	
	
	-- Slash commands.
	SLASH_SCL1 = "/scl";
	SlashCmdList["SCL"] = function (msg) self:SlashCommand(msg) end		

	MyMinimapButton:Create("SimpleCombatLog", self.savedVars.minimapButton)
	MyMinimapButton:SetIcon("SimpleCombatLog","Interface\\Icons\\INV_Misc_Food_66")
	MyMinimapButton:SetTooltip("SimpleCombatLog", self.loc.buttonTooltip)

	dewdrop:Register(SimpleCombatLogMinimapButton, 'children', function(level, value) self:OptionOpen(level, value) end )
	
	self.needRefreshChatEvent = true

	self:RefreshSettings()

	self.frame:UnregisterEvent("PLAYER_ENTERING_WORLD")

	
	self.initialized = true

	
end



function SimpleCombatLog:SlashCommand(msg)

	if msg == "suppress" then
		self.savedVars.nosuppress = not self.savedVars.nosuppress
		self.needRefreshChatEvent = true
		self:RefreshSettings()
		self:PrintHelp()
	elseif msg == "optionbutton" then	
		self.savedVars.nooptionbutton = not self.savedVars.nooptionbutton		
		self:RefreshSettings()
	elseif msg == "defaults" then	
		self:Print(self.loc.loaddefault, 1, true)
		self:LoadDefaultSettings()
	elseif msg == "option"  then
		dewdrop:Open(SimpleCombatLogMinimapButton)
		self:PrintHelp()
	else
		self:PrintHelp()
	end
	
	
	
end

function SimpleCombatLog:PrintHelp()
	
	local on
	
	if self.savedVars.nooptionbutton then	on = "Off"	else	on = "On"	end
	
	self:Print(string.format(	"optionbutton (|cff3333ff%s|r) : %s", on, self.loc.help.optionbutton), 1)
	
	if self.savedVars.nosuppress then		on = "Off"	else	on = "On"	end
		
	self:Print(string.format(	"suppress (|cff3333ff%s|r) : %s", on, self.loc.help.suppress), 1 )	
	self:Print(string.format(	"defaults : %s", self.loc.help.defaults), 1)
	self:Print(string.format( "option : %s", self.loc.help.option), 1)

end
		

function SimpleCombatLog:RefreshSettings()


	if self.savedVars.nooptionbutton then
--		MyMinimapButton:Disable("SimpleCombatLog")
	else
--		MyMinimapButton:Enable("SimpleCombatLog")
	end

	if self.needRefreshChatEvent then
		if self.savedVars.nosuppress then
			self:RefreshChatFrameEvents(true)
		else
			self:RefreshChatFrameEvents(false)
		end
		self.needRefreshChatEvent = nil
	end

	for i, v in self.eventTypes do
		if self.savedVars.events[v] and not parser:IsEventRegistered("SimpleCombatLog", self.eventList[v][1]) then
			for j in self.eventList[v] do
				parser:RegisterEvent("SimpleCombatLog", self.eventList[v][j], OnCombatEvent)
			end
		elseif not self.savedVars.events[v] and parser:IsEventRegistered("SimpleCombatLog", self.eventList[v][1]) then
			for j in self.eventList[v] do
				parser:UnregisterEvent("SimpleCombatLog", self.eventList[v][j], OnCombatEvent)
			end
		end
	end
		

	
end



function SimpleCombatLog:OnCombatEvent(event, info)




	if not self:FilterCheck(info) then return end
	
	if info.source == ParserLib_SELF then info.source = self.loc.you end
	if info.victim == ParserLib_SELF then info.victim = self.loc.you end
	if info.sourceGained == ParserLib_SELF then info.sourceGained = self.loc.you end
	
	info.source = self:ColorizeName(info.source)
	info.victim = self:ColorizeName(info.victim)
	info.sourceGained = self:ColorizeName(info.sourceGained)
	
	local extra, trailer
		
	if info.skill == ParserLib_MELEE then info.skill = "melee" end
	if info.skill == ParserLib_DAMAGESHIELD then info.skill = "damage shield" end
	
	if info.isCrit then info.amount = string.format("*%s*", info.amount) end
	if info.isDOT then info.amount = string.format("~%s~", info.amount) end
	
	if info.skill then
		info.skill = self:Colorize(info.skill, "skill")
	end
	
	
	if info.type == "hit" then

	
		if info.element then 
			info.amount = self:Colorize(info.amount, self:GetElementType(info.element))
		else
			info.amount = self:Colorize(info.amount, "physical")
		end
	
	
		if info.isCrit then
			extra = "crit"
		elseif info.isDOT then
			extra = "dot"
		else
			extra = "hit"
		end
		
		trailer = self:GetTrailerString(info)
		self:Print(string.format(self.patterns.hit, info.source, info.skill, extra, info.victim, info.amount) ..  trailer)
				
	elseif info.type == "heal" then
	
		info.amount = self:Colorize(info.amount, "heal")
		self:Print(string.format(self.patterns.heal, info.source, info.skill, info.victim, info.amount))
		
	elseif info.type == "debuff" then
	
		extra = self:Colorize("++", "debuff")
		if info.amountRank then
			info.skill = string.format("%s(%s)", info.skill, info.amountRank)
		end
		
		self:Print(string.format(self.patterns.debuff, info.victim, extra, info.skill))
		
	elseif info.type == "buff" then
	
		extra = self:Colorize("++", "buff")
		if info.amountRank then
			info.skill = string.format("%s(%s)", info.skill, info.amountRank)
		end		
		self:Print(string.format(self.patterns.buff, info.victim, extra, info.skill))
	
		
	elseif info.type == "fade" then
	
		self:Print(string.format(self.patterns.fade, info.victim, info.skill))
		
	elseif info.type == "dispel" then
	
		if not info.isFailed then
			self:Print(string.format(self.patterns.fade, info.victim, info.skill)) -- Use the same pattern 
		else
			self:Print(string.format(self.patterns.failDispel, info.source, info.victim, info.skill))
		end
		
	elseif info.type == "gain" then
		self:Print(string.format(self.patterns.gain, info.source, info.skill, info.victim, info.amount, info.attribute))
		
	elseif info.type == "extraattack" then

		self:Print(string.format(self.patterns.extraattack, info.victim, info.amount, info.skill))
		
	elseif info.type == "honor" then
		
		if info.isDishonor then
			self:Print(string.format(self.patterns.dishonor, info.source))
		else
			
			if info.source then
				trailer = string.format(" (%s %s)", info.sourceRank, info.source)
			else
				trailer = ""
			end
			
			self:Print(string.format(self.patterns.honor, info.amount)..trailer)
		
		end
		
	elseif info.type == "experience" then
		
		trailer = ""
		if info.source then trailer = string.format("%s(%s)", trailer, info.source) end
		if info.bonusAmount then	trailer = string.format("%s(%s%s)", trailer, info.bonusType, info.bonusAmount)	end
		if info.penaltyAmount then trailer = string.format("%s(%s%s)", trailer, info.penaltyType, info.penaltyAmount) end
		if info.amountGroupBonus then trailer = string.format("%s(G+%s)", trailer, info.amountGroupBonus) end
		if info.amountRaidPenalty then trailer = string.format("%s(R-%s)", trailer, info.amountRaidPenalty) end		
		self:Print(string.format(self.patterns.experience, info.amount).. trailer)
		
	elseif info.type == "reputation" then
	
		
		if not info.amount then
			trailer = info.rank
		else
			if info.isNegative then 
				trailer = string.format("-%s", info.amount)
			else
				trailer = string.format("+%s", info.amount)
			end
		end

		self:Print(string.format(self.patterns.reputation, info.faction, trailer))
		
		
	elseif info.type == "feedpet" then

		self:Print(string.format(self.patterns.feedpet, info.victim, info.item))		

	elseif info.type == "enchant" then
			
		self:Print(string.format(self.patterns.enchant, info.source, info.skill, info.victim, info.item))
		
	elseif info.type == "miss" then
			
		self:Print(string.format(self.patterns.miss, info.source, info.skill, self:Colorize(info.missType, "miss"), info.victim))

	elseif info.type == "cast" then
		
		if info.isBegin then
			self:Print(string.format(self.patterns.beginCast, info.source, info.skill))
		else
			if info.victim then
				self:Print(string.format(self.patterns.castTargetted, info.source, info.skill, info.victim))
			else
				self:Print(string.format(self.patterns.cast, info.source, info.skill))
			end
		end
		
	elseif info.type == "interrupt" then
	
		self:Print(string.format(self.patterns.interrupt, info.source, info.victim, info.skill))
				
	elseif info.type == "death" then
	
		if info.source then trailer = string.format("(%s)", info.source) else trailer = "" end
		self:Print(string.format(self.patterns.death, info.victim)..trailer)		
		
	elseif info.type == "environment" then

		trailer = self:GetTrailerString(info)
		self:Print(string.format(self.patterns.environment, info.victim, info.damageType, info.amount)..trailer)
		
	elseif info.type == "create" then
	
		self:Print(string.format(self.patterns.create, info.source, info.item))
				
	elseif info.type == "fail" and self.savedVars.showfailure then
	
		self:Print(string.format(self.patterns.fail, info.skill, info.reason))		
		
	elseif info.type == "drain" then
		
		self:Print(string.format(self.patterns.drain, info.source, info.skill, info.victim, info.amount, info.attribute))
		
		
	elseif info.type == "leech" then
	
		self:Print(string.format(self.patterns.leech, info.source, info.skill, info.victim, info.amount, info.attribute, info.sourceGained, info.amountGained, info.attributeGained))
		
	end
		
end

function SimpleCombatLog:GetElementType(element)
	if element == SPELL_SCHOOL0_CAP then return 'physical'
	elseif element == SPELL_SCHOOL1_CAP then return 'holy'
	elseif element == SPELL_SCHOOL2_CAP then return 'fire'
	elseif element == SPELL_SCHOOL3_CAP then return 'nature'
	elseif element == SPELL_SCHOOL4_CAP then return 'frost'
	elseif element == SPELL_SCHOOL5_CAP then return 'shadow'
	elseif element == SPELL_SCHOOL6_CAP then return 'arcane'
	else return element end
end


function SimpleCombatLog:GetTrailerString(info)
	local trailer = ""
	if info.isCrushing then trailer = trailer .. self.patterns.crushing end
	if info.isGlancing then trailer = trailer .. self.patterns.glancing end
	if info.amountAbsorb then trailer = trailer .. format(self.patterns.absorb, info.amountAbsorb) end
	if info.amountResist then trailer = trailer .. format(self.patterns.resist, info.amountResist) end
	if info.amountBlock then trailer = trailer .. format(self.patterns.block, info.amountBlock) end
	if info.amountVulnerable then trailer = trailer .. format(self.patterns.vulnerable, info.amountVulnerable) end
	return trailer
end

function SimpleCombatLog:FilterCheck(info)
	
	local f = self.savedVars.filters

	if info.type == "hit" then
		if f.hit then return false end
	elseif info.type == "heal" then
		if f.heal then return false end
	elseif info.type == "miss" then
		if f.miss then return false end
	elseif info.type == "gain" then
		if f.gain then return false end
	elseif info.type == "drain" or info.type == "leech" then
		if f.drain then return false end
	elseif info.type == "cast" then
		if f.cast then return false end
	end
	
	if not ( info.source or info.victim ) then return true end
	
	if info.source and not f[self:SearchName(info.source)] then return true end
	if info.victim and not f[self:SearchName(info.victim)] then return true end
	
	return false
	
end

function SimpleCombatLog:RefreshChatFrameEvents(enable)
	for index, value in ChatFrame2.messageTypeList do
		for eventIndex, eventValue in ChatTypeGroup[value] do
			if SearchList(self.eventList, eventValue) then
				if enable then
					ChatFrame2:RegisterEvent(eventValue);
				else
					ChatFrame2:UnregisterEvent(eventValue);
				end
			end
		end
	end
end



function SimpleCombatLog:SearchName(name)
	if name == ParserLib_SELF then return "player" end
	if name == UnitName("player") then return "player" end
	if name == UnitName("pet") then return "pet" end
	for i=1, GetNumPartyMembers() do 
		if name == UnitName("party"..i) then return "party" end
	end
	for i=1, GetNumRaidMembers() do
		if name == UnitName("raid"..i) then return "raid" end
	end
	if name == UnitName("target") then return "target" end	
	
	return 'other'
end

function SimpleCombatLog:ColorizeName(name)
	if not name then return end
	if name == self.loc.you then return self:Colorize(name, "player") end
	
	return self:Colorize(name, self:SearchName(name) )
end

function SimpleCombatLog:Print(msg, id, title, r,g,b)
	if not id then id = self.savedVars.outputframe end
	
	if title then
		msg = "SimpleCombatLog " .. version .. " : " .. msg
	end
		
	getglobal("ChatFrame"..id):AddMessage(msg,r,g,b)
end


function SimpleCombatLog:OptionOpen(level, value)

	if level == 1 then

		dewdrop:AddLine(
			'text', self.loc.title .. version,
			'isTitle', true
		)
		
		dewdrop:AddLine()

		dewdrop:AddLine(
			'text', self.loc.color,
			'hasArrow', true,
			'value', "color"
		)		
	
		dewdrop:AddLine(
			'text', self.loc.filter,
			'hasArrow', true,
			'value', "filter"
		)
		
		dewdrop:AddLine(
			'text', self.loc.event,
			'hasArrow', true,
			'value', "event"
		)		

		dewdrop:AddLine()

		dewdrop:AddLine(
			'text', self.loc.suppress,
			'func', 
			function() 
				self.savedVars.nosuppress = not self.savedVars.nosuppress
				self.needRefreshChatEvent = true
				self:RefreshSettings()
			end,
			'checked', not self.savedVars.nosuppress
		)
		
		dewdrop:AddLine()
		
		dewdrop:AddLine(
			'text', self.loc.default,
			'notCheckable', true,
			'func', function() self:LoadDefaultSettings() end
		)

		
	elseif level == 2 then
	
	
		if value == "color" then

			local c
			
			c = self:GetColor('player')
			dewdrop:AddLine(
				'text', self.loc.player,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,		
				'swatchFunc', function(r,g,b) self:OptionColorChange('player',r,g,b) end
			)
			
			c = self:GetColor('pet')
			dewdrop:AddLine(
				'text', self.loc.pet,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('pet',r,g,b) end
			)
			
			c = self:GetColor('party')
			dewdrop:AddLine(
				'text', self.loc.party,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('party',r,g,b) end
			)
			
			c = self:GetColor('raid')
			dewdrop:AddLine(
				'text', self.loc.raid,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('raid',r,g,b) end
			)
			
			c = self:GetColor('target')
			dewdrop:AddLine(
				'text', self.loc.target,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('target',r,g,b) end
			)
			
			c = self:GetColor('other')
			dewdrop:AddLine(
				'text', self.loc.other,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('other',r,g,b) end
			)
			
			dewdrop:AddLine() 
			
						
			c = self:GetColor('skill')
			dewdrop:AddLine(
				'text', self.loc.skill,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('skill',r,g,b) end
			)


			c = self:GetColor('buff')
			dewdrop:AddLine(
				'text', self.loc.buff,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('buff',r,g,b) end
			)

			c = self:GetColor('debuff')
			dewdrop:AddLine(
				'text', self.loc.debuff,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('debuff',r,g,b) end
			)
			
			c = self:GetColor('heal')
			dewdrop:AddLine(
				'text', self.loc.heal,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('heal',r,g,b) end
			)
			
			c = self:GetColor('miss')
			dewdrop:AddLine(
				'text', self.loc.miss,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('miss',r,g,b) end
			)
						
			c = self:GetColor('physical')
			dewdrop:AddLine(
				'text', self.loc.physical,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('physical',r,g,b) end
			)
			
			c = self:GetColor('holy')
			dewdrop:AddLine(
				'text', self.loc.holy,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('holy',r,g,b) end
			)
			
			c = self:GetColor('fire')
			dewdrop:AddLine(
				'text', self.loc.fire,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('fire',r,g,b) end
			)
			
			c = self:GetColor('nature')
			dewdrop:AddLine(
				'text', self.loc.nature,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('nature',r,g,b) end
			)
			
			c = self:GetColor('frost')
			dewdrop:AddLine(
				'text', self.loc.frost,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('frost',r,g,b) end
			)
			
			c = self:GetColor('shadow')
			dewdrop:AddLine(
				'text', self.loc.shadow,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('shadow',r,g,b) end
			)
			
			c = self:GetColor('arcane')
			dewdrop:AddLine(
				'text', self.loc.arcane,
				'hasColorSwatch', true,
				'r', c.r,
				'g', c.g,
				'b', c.b,
				'swatchFunc', function(r,g,b) self:OptionColorChange('arcane',r,g,b) end
			)
			

		
		elseif value == 'filter' then

			dewdrop:AddLine(
				'text', self.loc.player,
				'func', function() self.savedVars.filters.player = not self.savedVars.filters.player end,
				'checked', not self.savedVars.filters.player
			)
			dewdrop:AddLine(
				'text', self.loc.pet,
				'func', function() self.savedVars.filters.pet = not self.savedVars.filters.pet end,
				'checked', not self.savedVars.filters.pet
			)
			dewdrop:AddLine(
				'text', self.loc.party,
				'func', function() self.savedVars.filters.party = not self.savedVars.filters.party end,
				'checked', not self.savedVars.filters.party
			)
			dewdrop:AddLine(
				'text', self.loc.raid,
				'func', function() self.savedVars.filters.raid = not self.savedVars.filters.raid end,
				'checked', not self.savedVars.filters.raid
			)
			dewdrop:AddLine(
				'text', self.loc.target,
				'func', function() self.savedVars.filters.target = not self.savedVars.filters.target end,
				'checked', not self.savedVars.filters.target
			)
			dewdrop:AddLine(
				'text', self.loc.other,
				'func', function() self.savedVars.filters.other = not self.savedVars.filters.other end,
				'checked', not self.savedVars.filters.other
			)
			
			dewdrop:AddLine()
			
			dewdrop:AddLine(
				'text', self.loc.hit,
				'func', function() self.savedVars.filters.hit = not self.savedVars.filters.hit end,
				'checked', not self.savedVars.filters.hit
			)
			dewdrop:AddLine(
				'text', self.loc.heal,
				'func', function() self.savedVars.filters.heal = not self.savedVars.filters.heal end,
				'checked', not self.savedVars.filters.heal
			)
			dewdrop:AddLine(
				'text', self.loc.miss,
				'func', function() self.savedVars.filters.miss = not self.savedVars.filters.miss end,
				'checked', not self.savedVars.filters.miss
			)			
			dewdrop:AddLine(
				'text', self.loc.cast,
				'func', function() self.savedVars.filters.cast = not self.savedVars.filters.cast end,
				'checked', not self.savedVars.filters.cast
			)			
			dewdrop:AddLine(
				'text', self.loc.gain,
				'func', function() self.savedVars.filters.gain = not self.savedVars.filters.gain end,
				'checked', not self.savedVars.filters.gain
			)
			dewdrop:AddLine(
				'text', self.loc.drain,
				'func', function() self.savedVars.filters.drain = not self.savedVars.filters.drain end,
				'checked', not self.savedVars.filters.drain
			)
			
			
					
		elseif value == 'event' then
		
			dewdrop:AddLine(
				'text', self.loc.selfhit,
				'func', function() self.savedVars.events.selfhit = not self.savedVars.events.selfhit; self:RefreshSettings() end,
				'checked', self.savedVars.events.selfhit
			)
			dewdrop:AddLine(
				'text', self.loc.otherhit,
				'func', function() self.savedVars.events.otherhit = not self.savedVars.events.otherhit; self:RefreshSettings() end,
				'checked', self.savedVars.events.otherhit
			)
			dewdrop:AddLine(
				'text', self.loc.selfspell,
				'func', function() self.savedVars.events.selfspell = not self.savedVars.events.selfspell; self:RefreshSettings() end,
				'checked', self.savedVars.events.selfspell
			)
			dewdrop:AddLine(
				'text', self.loc.otherspell,
				'func', function() self.savedVars.events.otherspell = not self.savedVars.events.otherspell; self:RefreshSettings() end,
				'checked', self.savedVars.events.otherspell
			)
			dewdrop:AddLine(
				'text', self.loc.selfdot,
				'func', function() self.savedVars.events.selfdot = not self.savedVars.events.selfdot; self:RefreshSettings() end,
				'checked', self.savedVars.events.selfdot
			)
			dewdrop:AddLine(
				'text', self.loc.otherdot,
				'func', function() self.savedVars.events.otherdot = not self.savedVars.events.otherdot; self:RefreshSettings() end,
				'checked', self.savedVars.events.otherdot
			)
			dewdrop:AddLine(
				'text', self.loc.death,
				'func', function() self.savedVars.events.death = not self.savedVars.events.death; self:RefreshSettings() end,
				'checked', self.savedVars.events.death
			)
			dewdrop:AddLine(
				'text', self.loc.aura,
				'func', function() self.savedVars.events.aura = not self.savedVars.events.aura; self:RefreshSettings() end,
				'checked', self.savedVars.events.aura
			)
			dewdrop:AddLine(
				'text', self.loc.enchant,
				'func', function() self.savedVars.events.enchant = not self.savedVars.events.enchant; self:RefreshSettings() end,
				'checked', self.savedVars.events.enchant
			)
			dewdrop:AddLine(
				'text', self.loc.trade,
				'func', function() self.savedVars.events.trade = not self.savedVars.events.trade; self:RefreshSettings() end,
				'checked', self.savedVars.events.trade
			)
			dewdrop:AddLine(
				'text', self.loc.experience,
				'func', function() self.savedVars.events.experience = not self.savedVars.events.experience; self:RefreshSettings() end,
				'checked', self.savedVars.events.experience
			)
			dewdrop:AddLine(
				'text', self.loc.honor,
				'func', function() self.savedVars.events.honor = not self.savedVars.events.honor; self:RefreshSettings() end,
				'checked', self.savedVars.events.honor
			)
			dewdrop:AddLine(
				'text', self.loc.reputation,
				'func', function() self.savedVars.events.reputation = not self.savedVars.events.reputation; self:RefreshSettings() end,
				'checked', self.savedVars.events.reputation
			)
			dewdrop:AddLine(
				'text', self.loc.fail,
				'func', function() self.savedVars.events.fail = not self.savedVars.events.fail; self:RefreshSettings() end,
				'checked', self.savedVars.events.fail
			)
		end
	end


end



function SimpleCombatLog:OptionColorChange(item, r,g,b)

	if not self.savedVars.colors[item] then self.savedVars.colors[item] = {} end
	
	self.savedVars.colors[item].r = r
	self.savedVars.colors[item].g = g
	self.savedVars.colors[item].b = b
end


function SimpleCombatLog:LoadDefaultSettings()

	SCL_Config = {}
	
	self.savedVars = SCL_Config
	self.savedVars.colors = {}
	self.savedVars.filters = {}
	self.savedVars.minimapButton = {}
	
	self.savedVars.events = {}
	for i, v in self.eventTypes do
		if v ~= 'fail' then
			self.savedVars.events[v] = true
		end
	end
	
	self.savedVars.outputframe = 2
	self.savedVars.nosuppress = nil
	self.savedVars.nooptionbutton = nil
	self:RefreshSettings()
end


if not GetParser then function GetParser() 	return parser end end


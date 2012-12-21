local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local parser = ParserLib:GetInstance('1.1')
local compost = AceLibrary("Compost-2.0")

local L = AceLibrary("AceLocale-2.0"):new("FuBar_DPS")

FuBar_DPS = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "Metrognome-2.0" )

FuBar_DPS:RegisterDB("FuBar_DPS_DB")
FuBar_DPS:RegisterDefaults('profile', {
	myDmgDone = true,
	myDmgTaken = true
})

local _, isPetClass = UnitClass('player')
if not (isPetClass == "WARLOCK" or isPetClass == "HUNTER" ) then
	isPetClass = nil
end

local OnCombatEvent = function(event, info)
	FuBar_DPS:OnCombatEvent(event, info);
end

local optionsTable = {
	type = 'group',
	args = {
		player = {
			order = 1,
			type = 'group',
			name = L["MENU_PLAYER"],
			desc = L["TOOLTIP_PLAYER"],
			args = {
				dps = {
					order = 1,
					type = 'toggle',
					name = L["myDmgDone"],
					desc = L["myDmgDone"],
					set = 'SetMyDmgDone',
					get = 'IsMyDmgDone',
				},
				dtps = {
					order = 2,
					type = 'toggle',
					name = L["myDmgTaken"],
					desc = L["myDmgTaken"],
					set = 'SetMyDmgTaken',
					get = 'IsMyDmgTaken',
				},
				hps = {
					order = 3,
					type = 'toggle',
					name = L["myHealDone"],
					desc = L["myHealDone"],
					set = 'SetMyHealDone',
					get = 'IsMyHealDone',
				},
				htps = {
					order = 4,
					type = 'toggle',
					name = L["myHealTaken"],
					desc = L["myHealTaken"],
					set = 'SetMyHealTaken',
					get = 'IsMyHealTaken',
				},
			},
		},
		hideLabel = {
			order = 5,
			type = 'toggle',
			name = L["MENU_HIDE_LABEL"],
			desc = L["MENU_HIDE_LABEL"],
			set = 'SetHideLabel',
			get = "IsHideLabel",
		},
		reset = {
			order = 7,
			type = 'execute',
			name = L["MENU_RESET"],
			desc = L["MENU_RESET"],
			func = 'ResetSession',
		}
	
	}
}

FuBar_DPS.eventList = {
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_SELF_HITS",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
	"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
	"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
--		"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
--		"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_PARTY_BUFF",
--		"CHAT_MSG_SPELL_PARTY_DAMAGE",
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
	"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_COMBAT_PET_HITS",
	"CHAT_MSG_SPELL_PET_BUFF",
	"CHAT_MSG_SPELL_PET_DAMAGE",	
}
	
FuBar_DPS.myDPS = { "myDmgDone", "myDmgTaken", "myHealDone", "myHealTaken" }
FuBar_DPS.petDPS = {}
FuBar_DPS.colors = {
	myDmgDone = "ff0000",
	myDmgTaken = "ff7f00",
	myHealDone = "00ff00",
	myHealTaken = "2020ff",
	petDmgDone = "ff3030",
	petDmgTaken = "ff7f30",
	petHealDone = "30ff30",
	petHealTaken = "5050ff",
}

FuBar_DPS.stats = {
	session = {
		myDmgDone = 0,
		myDmgTaken = 0,
		myHealDone = 0,
		myHealTaken = 0,
		duration = 0,
	},
	last = {
		myDmgDone = 0,
		myDmgTaken = 0,
		myHealDone = 0,
		myHealTaken = 0,
		duration = 0,
	},
}

FuBar_DPS.vars = {
	inCombat = false
}
	

	
function FuBar_DPS:OnInitialize()

	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterMetro(self.name, self.TickCombat, 1, self)

	if isPetClass then
		self:InitializePetClass()
	end
	
end

function FuBar_DPS:OnEnable()
	for i, event in self.eventList do
		parser:RegisterEvent(self.name, event, OnCombatEvent)
	end
end

function FuBar_DPS:OnDisable()
	parser:UnregisterAllEvents(self.name)
end
	
function FuBar_DPS:PLAYER_REGEN_DISABLED()
	for i in self.stats.last do
		self.stats.last[i] = 0
	end
	self.vars.inCombat = true;
	self:StartMetro(self.name)	
end

function FuBar_DPS:PLAYER_REGEN_ENABLED()	
	self:StopMetro(self.name)
	for i, v in self.stats.last do
		self.stats.session[i] = self.stats.session[i] + v
	end	
	self.vars.inCombat = false
end

function FuBar_DPS:OnCombatEvent(event, info)

	if self.vars.inCombat then
		
		if info.type == "hit" then
		
			if info.source == ParserLib_SELF then
				self.stats.last.myDmgDone = self.stats.last.myDmgDone + tonumber(info.amount);
			elseif isPetClass and info.source == UnitName("pet") then
				self.stats.last.petDmgDone = self.stats.last.petDmgDone + tonumber(info.amount);
			end
			
			if info.victim == ParserLib_SELF then
				self.stats.last.myDmgTaken = self.stats.last.myDmgTaken + tonumber(info.amount);
			elseif isPetClass and info.victim == UnitName("pet") then
				self.stats.last.petDmgTaken = self.stats.last.petDmgTaken + tonumber(info.amount);
			end
			
		elseif info.type == "heal" then
		
			if info.source == ParserLib_SELF then
				self.stats.last.myHealDone = self.stats.last.myHealDone + tonumber(info.amount);
			elseif isPetClass and info.source == UnitName("pet") then
				self.stats.last.petHealDone = self.stats.last.petHealDone + tonumber(info.amount);
			end
			
			if info.victim == ParserLib_SELF then
				self.stats.last.myHealTaken = self.stats.last.myHealTaken + tonumber(info.amount);
			elseif isPetClass and info.victim == UnitName("pet") then
				self.stats.last.petHealTaken = self.stats.last.petHealTaken + tonumber(info.amount);
			end
			
		end
		
	end

			
end


	
function FuBar_DPS:TickCombat(difference)
	self.stats.last.duration = self.stats.last.duration + difference
	self:Update()	
end

function FuBar_DPS:GetDPS(category, field)
	local duration = self.stats[category].duration
	if duration < 1 then duration = 1 end	
	return string.format("|cff%s%.1f|r", self.colors[field], self.stats[category][field] / duration)
end



function FuBar_DPS:ResetSession()
	for i in self.stats.session do
		self.stats.session[i] = 0
	end
end
		
function FuBar_DPS:OnTextUpdate()

	local label, text, petLabel, petText

	if not self.db.profile.hideLabel then
		label = L.LABEL_DPS
		petLabel = L.LABEL_PET
	end
	
	if isPetClass and self.db.profile.mergeDPS then
		self:SetAddedStats();
	end

	text = ""
	for i, v in self.myDPS do
		if self.db.profile[v] then text = text .. "/" .. self:GetDPS("last", v) end
	end
	if string.sub(text, 1, 1) == "/" then text = string.sub(text, 2) end
	if text == "" then label = "" end

	if isPetClass and self.db.profile.mergeDPS then
		self:UnsetAddedStats();
	end

	petText = ""
	for i, v in self.petDPS do
		if self.db.profile[v] then petText = petText .. "/" .. self:GetDPS("last", v) end
	end
	if string.sub(petText, 1, 1) == "/" then petText = string.sub(petText, 2) end		
	if petText == "" then petLabel = nil end
	
	-- Do not turn everything off!
	if text == "" and not label and petText == "" and not petLabel then
		label = L.LABEL_DPS
	end
	
	local t = compost:Acquire()
	if label then table.insert(t, label) end
	if text ~= "" then table.insert(t, text) end
	if petLabel then table.insert(t, petLabel) end
	if petText ~= "" then table.insert(t, petText) end
	self:SetText( table.concat(t, " ") )
	compost:Reclaim(t)	
	
end
	
function FuBar_DPS:OnTooltipUpdate()

	if not self.statsCats then
		self.statsCats = { 'session', 'last' }
	end
	
	for i, statsCat in self.statsCats do
	
		local cat = tablet:AddCategory(
			'columns', 3,
			'text', L[statsCat],
			'text2', string.format("%ds", self.stats[statsCat].duration),
			'text3', L.TOTAL,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0
		);	
		
		if isPetClass and self.db.profile.showPetTooltip then
			cat:AddLine(
				'text', string.format("|cffeda55f%s|r", L.MENU_PLAYER)
			)
		end
		
		for i, statsType in self.myDPS do			
			cat:AddLine(
				'text', L[statsType], 
				'text2', self:GetDPS(statsCat, statsType),
				'text3', self.stats[statsCat][statsType]
			);
		end
		
		if isPetClass and self.db.profile.showPetTooltip then		
			cat:AddLine(
				'text', string.format("|cffeda55f%s|r", L.MENU_PET)
			)
			for i, statsType in self.petDPS do				
				cat:AddLine(
					'text', L[statsType], 
					'text2', self:GetDPS(statsCat, statsType),
					'text3', self.stats[statsCat][statsType]
				);
			end
		end	
	end
	
end
	


-- Set()s and Get()S
function FuBar_DPS:SetHideLabel(v)
	self.db.profile.hideLabel = v
	self:Update()
end

function FuBar_DPS:SetMyDmgDone(v)
 self.db.profile.myDmgDone = v
	self:Update()
end

function FuBar_DPS:SetMyDmgTaken(v)
 self.db.profile.myDmgTaken = v
	self:Update()
end

function FuBar_DPS:SetMyHealDone(v)
	self.db.profile.myHealDone = v
	self:Update()
end

function FuBar_DPS:SetMyHealTaken(v)
	self.db.profile.myHealTaken = v
	self:Update()
end

function FuBar_DPS:IsHideLabel()
	return self.db.profile.hideLabel
end

function FuBar_DPS:IsMyDmgDone()
	return self.db.profile.myDmgDone
end

function FuBar_DPS:IsMyDmgTaken()
	return self.db.profile.myDmgTaken
end

function FuBar_DPS:IsMyHealDone()
	return self.db.profile.myHealDone
end

function FuBar_DPS:IsMyHealTaken()
	return self.db.profile.myHealTaken
end


if isPetClass then
	function FuBar_DPS:SetMergeDPS(v)
		self.db.profile.mergeDPS = v
		self:Update()
	end

	function FuBar_DPS:SetShowPetTooltip(v)
		self.db.profile.showPetTooltip = v
		self:Update()
	end

	function FuBar_DPS:IsMergeDPS()
		return self.db.profile.mergeDPS
	end

	function FuBar_DPS:IsShowPetTooltip()
		return self.db.profile.showPetTooltip
	end

	function FuBar_DPS:SetPetDmgDone(v)
		self.db.profile.petDmgDone = v
		self:Update()
	end

	function FuBar_DPS:SetPetDmgTaken(v)
		self.db.profile.petDmgTaken = v
		self:Update()
	end

	function FuBar_DPS:SetPetHealDone(v)
		self.db.profile.petHealDone = v
		self:Update()
	end

	function FuBar_DPS:SetPetHealTaken(v)
		self.db.profile.petHealTaken = v
		self:Update()
	end

	function FuBar_DPS:IsPetDmgDone()
		return self.db.profile.petDmgDone
	end

	function FuBar_DPS:IsPetDmgTaken()
		return self.db.profile.petDmgTaken
	end

	function FuBar_DPS:IsPetHealDone()
		return self.db.profile.petHealDone
	end

	function FuBar_DPS:IsPetHealTaken()
		return self.db.profile.petHealTaken
	end


	function FuBar_DPS:SetAddedStats()
		if not self.stats.oldLast then self.stats.oldLast = {} end
		
		-- Switch stats to oldStats.
		local tmp = self.stats.oldLast		
		self.stats.oldLast = self.stats.last
		self.stats.last = tmp
		
		local stats = self.stats.last
		local oldStats = self.stats.oldLast
		
		stats.myDmgDone = oldStats.myDmgDone + oldStats.petDmgDone
		stats.myDmgTaken = oldStats.myDmgTaken + oldStats.petDmgTaken
		stats.myHealDone = oldStats.myHealDone + oldStats.petHealDone
		stats.myHealTaken = oldStats.myHealTaken + oldStats.petHealTaken
		stats.duration = oldStats.duration
	end
		
	function FuBar_DPS:UnsetAddedStats()	
		-- Switch back.
		local tmp = self.stats.last
		self.stats.last = self.stats.oldLast
		self.stats.oldLast = tmp
	end


	function FuBar_DPS:InitializePetClass()
		self.stats.session.petDmgDone = 0
		self.stats.session.petDmgTaken = 0
		self.stats.session.petHealDone = 0
		self.stats.session.petHealTaken = 0
		self.stats.last.petDmgDone = 0
		self.stats.last.petDmgTaken = 0
		self.stats.last.petHealDone = 0	
		self.stats.last.petHealTaken = 0
		self.petDPS = { "petDmgDone", "petDmgTaken", "petHealDone", "petHealTaken" }		
	end

	optionsTable.args.mergeDPS = {
		order = 3,
		type = 'toggle',
		name = L["MENU_MERGE_DPS"],
		desc = L["MENU_MERGE_DPS"],
		set = 'SetMergeDPS',
		get = "IsMergeDPS",
	}
	
	optionsTable.args.showPetTooltip = {
		order = 4,
		type = 'toggle',
		name = L["MENU_SHOW_PET_TOOLTIP"],
		desc = L["MENU_SHOW_PET_TOOLTIP"],
		set = 'SetShowPetTooltip',
		get = "IsShowPetTooltip",
	}

	optionsTable.args.pet = {
		order = 2,
		type = 'group',
		name = L["MENU_PET"],
		desc = L["TOOLTIP_PET"],
		args = {
			petDmgDone = {
				order = 1,
				type = 'toggle',
				name = L["petDmgDone"],
				desc = L["petDmgDone"],
				set = 'SetPetDmgDone',
				get = 'IsPetDmgDone',
			},
			petDmgTaken = {
				order = 2,
				type = 'toggle',
				name = L["petDmgTaken"],
				desc = L["petDmgTaken"],
				set = 'SetPetDmgTaken',
				get = 'IsPetDmgTaken',
			},
			petHealDone = {
				order = 3,
				type = 'toggle',
				name = L["petHealDone"],
				desc = L["petHealDone"],
				set = 'SetPetHealDone',
				get = 'IsPetHealDone',
			},
			petHealTaken = {
				order = 4,
				type = 'toggle',
				name = L["petHealTaken"],
				desc = L["petHealTaken"],
				set = 'SetPetHealTaken',
				get = 'IsPetHealTaken',
			},
		},
	}

end

FuBar_DPS.OnMenuRequest = optionsTable
FuBar_DPS:RegisterChatCommand( { "/fbdps" }, optionsTable )
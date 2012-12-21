--[[---------------------------------------------------------------------------------
 Detox
 written by Maia/Proudmoore, 
 code based on the Decursive 1.9.7 core code by Archarodim and Quu.
 The name 'Detox' was provided by Tem.
------------------------------------------------------------------------------------]]

local vmajor,vminor = "0.4", tonumber(string.sub("$Revision: 12266 $", 12, -3))

--[[---------------------------------------------------------------------------------
 locals
------------------------------------------------------------------------------------]]

local compost           = AceLibrary("Compost-2.0")
local L                 = AceLibrary("AceLocale-2.0"):new("Detox")
local BS                = AceLibrary("Babble-Spell-2.0")
local BC                = AceLibrary("Babble-Class-2.0")
local tablet            = AceLibrary("Tablet-2.0")
local aura              = nil -- AceLibrary("SpecialEvents-Aura-2.0")
local RL                = nil -- AceLibrary("RosterLib-2.0")

local last_DemonType    = nil
local curr_DemonType    = nil
local castTarget        = nil
local soundPlayed       = false
local hasSpells         = false
local blacklist         = {}
local outofrange        = {}
local spells            = {} -- will be filled with available spells
local priorityIndex     = {} -- this table references name to index of the priority table
local priority          = {} -- this integer keyed table will hold subtables containing name, unitid and priority for each unit in our roster

local DebuffTypeColor      = {}
DebuffTypeColor["none"]    = { r = 0.80, g = 0, b = 0 }
DebuffTypeColor["Magic"]   = { r = 0.20, g = 0.60, b = 1.00 }
DebuffTypeColor["Curse"]   = { r = 0.60, g = 0.00, b = 1.00 }
DebuffTypeColor["Disease"] = { r = 0.60, g = 0.40, b = 0 }
DebuffTypeColor["Poison"]  = { r = 0.00, g = 0.60, b = 0 }

local invisible = {
	[BS["Prowl"]]                 = true,
	[BS["Stealth"]]               = true,
	[BS["Shadowmeld"]]            = true,
}

local ignore = {
	[BS["Banish"]]                = true,
	[BS["Phase Shift"]]           = true,
	[L["Frost Trap Aura"]]        = true,
}

local skip = {
	[L["Dreamless Sleep"]]        = true,
	[L["Greater Dreamless Sleep"]] = true,
}

local cleaningSpells = {
	[BS["Cure Disease"]]          = true,
	[BS["Abolish Disease"]]       = true,
	[BS["Purify"]]                = true,
	[BS["Cleanse"]]               = true,
	[BS["Dispel Magic"]]          = true,
	[BS["Cure Poison"]]           = true,
	[BS["Abolish Poison"]]        = true,
	[BS["Remove Lesser Curse"]]   = true,
	[BS["Remove Curse"]]          = true,
	[BS["Purge"]]                 = true,
	[BS["Devour Magic"]]          = true,
	[BS["Stoneform"]]             = true,
}

BINDING_HEADER_DETOX              = "Detox"
BINDING_NAME_CLEAN                = L["Clean group"]
BINDING_NAME_PRIORITYTOGGLE       = L["Toggle target priority"]
BINDING_NAME_PRIORITYTOGGLEGROUP  = L["Toggle target group priority"]
BINDING_NAME_PRIORITYTOGGLECLASS  = L["Toggle target class priority"]

--[[---------------------------------------------------------------------------------
 defaults and AceOptions table
------------------------------------------------------------------------------------]]

local defaults = {
	showPriorities = true,
	ignoreStealthed = true,
	blacklistTime = 5,
	checkAbolish = true,
	ignorePets = false,
	liveDisplay = 5,
	filter = true,
	range = true,
	sound = true,
	feedback = true,
	updateSpeed = 0.5,
	priorityNames = {},
	priorityGroups = {},
	priorityClasses = {},
	debuffsInSkipList = {
		BS["Silence"],
		L["Ancient Hysteria"],
		L["Ignite Mana"],
		L["Tainted Mind"],
		L["Magma Shackles"],
		L["Cripple"],
		L["Dust Cloud"],
		L["Widow's Embrace"],
		L["Curse of Tongues"],
		L["Sonic Burst"],
		L["Thunderclap"],
		L["Delusions of Jin'do"]
	},
	skipByClass = {
		["WARRIOR"] = {
			[L["Ancient Hysteria"]]   = true,
			[L["Ignite Mana"]]        = true,
			[L["Tainted Mind"]]       = true,
			[L["Widow's Embrace"]]    = true,
			[L["Curse of Tongues"]]   = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["ROGUE"] = {
			[BS["Silence"]]           = true,
			[L["Ancient Hysteria"]]   = true,
			[L["Ignite Mana"]]        = true,
			[L["Tainted Mind"]]       = true,
			[L["Widow's Embrace"]]    = true,
			[L["Curse of Tongues"]]   = true,
			[L["Sonic Burst"]]        = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["HUNTER"] = {
			[L["Magma Shackles"]]     = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["MAGE"] = {
			[L["Magma Shackles"]]     = true,
			[L["Cripple"]]            = true,
			[L["Dust Cloud"]]         = true,
			[L["Thunderclap"]]        = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["WARLOCK"] = {
			[L["Cripple"]]            = true,
			[L["Dust Cloud"]]         = true,
			[L["Thunderclap"]]        = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["DRUID"] = {
			[L["Cripple"]]            = true,
			[L["Dust Cloud"]]         = true,
			[L["Thunderclap"]]        = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["PALADIN"] = {
			[L["Cripple"]]            = true,
			[L["Dust Cloud"]]         = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["PRIEST"] = {
			[L["Cripple"]]            = true,
			[L["Dust Cloud"]]         = true,
			[L["Thunderclap"]]        = true,
			[L["Delusions of Jin'do"]]= true,
		},
		["SHAMAN"] = {
			[L["Cripple"]]            = true,
			[L["Dust Cloud"]]         = true,
			[L["Delusions of Jin'do"]]= true,
		}
	}
}

local options = {
	type = 'group',
	args = {
		clean = {
			type = 'execute',
			name = L["Clean group"],
			desc = L["Will attempt to clean a player in your raid/party."],
			func = function()
				Detox:Clean()
			end,
			order = 101,
		},
		spacer = { type = "header", order = 102 },
		livelistoptions = {
			type = 'group',
			name = L["Live list"],
			desc = L["Options for the live list."],
			order = 110,
			args = {
				show = {
					type = 'toggle',
					name = L["Show live list"],
					desc = L["Detaches the live list from the Detox icon."],
					get = function() return Detox:IsTooltipDetached() end,
					set = function() Detox:ToggleTooltipDetached() end,
					order = 100
				},
				sound = {
					type = 'toggle',
					name = L["Play sound if unit needs decursing"],
					desc = L["Play sound if unit needs decursing"]..".",
					get = function() return Detox.db.profile.sound end,
					set = function()
						Detox.db.profile.sound = not Detox.db.profile.sound
					end,
					order = 101
				},
				showpriorizations = {
					type = 'toggle',
					name = L["Show priorities"],
					desc = L["Displays who is prioritized in the live list."],
					get = function() return Detox.db.profile.showPriorities end,
					set = function() Detox.db.profile.showPriorities = not Detox.db.profile.showPriorities end,
					order = 102,
				},
				live = {
					type = 'range',
					name = L["Max debuffs shown"],
					desc = L["Defines the max number of debuffs to display in the live list."],
					get = function() return Detox.db.profile.liveDisplay end,
					set = function(v) 
						Detox.db.profile.liveDisplay = v
					end,
					min = 0,
					max = 20,
					step = 1,
					isPercent = false,
					order = 103,
				},
				speed = {
					type = 'range',
					name = L["Update speed"],
					desc = L["Defines the speed the live list is updated, in seconds."],
					get = function() return Detox.db.profile.updateSpeed end,
					set = function(v) 
						Detox.db.profile.updateSpeed = v
						Detox:CancelScheduledEvent("liveList")
						Detox:ScheduleRepeatingEvent("liveList", Detox.Update, v, Detox)
					end,
					min = 0.2,
					max = 2,
					step = 0.1,
					isPercent = false,
					order = 104,
				},
			},
		},
		priority = {
			type = 'group',
			name = L["Priority"],
			desc = L["These units will be priorized when curing."],
			order = 120,
			args = {}
		},
		filter = {
			type = 'group',
			name = L["Filter"],
			desc = L["Options for filtering various debuffs and conditions."],
			order = 130,
			args = {
				filter = {
					type = 'toggle',
					name = L["Filter by type"],
					desc = L["Only show debuffs you can cure."],
					get = function() return Detox.db.profile.filter end,
					set = function()
						Detox.db.profile.filter = not Detox.db.profile.filter
					end,
					order = 103,
				},
				range = {
					type = 'toggle',
					name = L["Filter by range"],
					desc = L["Only show units in range."],
					get = function() return Detox.db.profile.range end,
					set = function()
						Detox.db.profile.range = not Detox.db.profile.range
					end,
					order = 104
				},
				stealth = {
					type = 'toggle',
					name = L["Filter stealthed units"],
					desc = L["It is recommended not to cure stealthed units."],
					get = function() return Detox.db.profile.ignoreStealthed end,
					set = function()
						Detox.db.profile.ignoreStealthed = not Detox.db.profile.ignoreStealthed
					end,
					order = 105
				},
				abolish = {
					type = 'toggle',
					name = L["Filter Abolished units"],
					desc = L["Skip units that have an active Abolish buff."],
					get = function() return Detox.db.profile.checkAbolish end,
					set = function()
						Detox.db.profile.checkAbolish = not Detox.db.profile.checkAbolish
					end,
					order = 106
				},
				pets = {
					type = 'toggle',
					name = L["Filter pets"],
					desc = L["Pets are also your friends."],
					get = function() return Detox.db.profile.ignorePets end,
					set = function()
						Detox.db.profile.ignorePets = not Detox.db.profile.ignorePets
						Detox:UpdatePriority()
					end,
					order = 107
				},
				debuff = {
					type = 'group',
					name = L["Debuff"],
					desc = L["Filter by debuff and class."],
					order = 400,
					args = {}
				},
			},
		},
		blacklist = {
			type = 'range',
			name = L["Seconds to blacklist"],
			desc = L["Units that are out of Line of Sight will be blacklisted for the set duration."],
			get = function() return Detox.db.profile.blacklistTime end,
			set = function(v) 
				Detox.db.profile.blacklistTime = v
			end,
			min = 1,
			max = 20,
			step = 1,
			isPercent = false,
			order = 140
		},
		feedback = {
			type = 'toggle',
			name = L["Show detoxing in scrolling combat frame"],
			desc = L["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."],
			get = function() return Detox.db.profile.feedback end,
			set = function()
				Detox.db.profile.feedback = not Detox.db.profile.feedback
			end,
			order = 150
		},
	},
}

--[[---------------------------------------------------------------------------------
 Initialization
------------------------------------------------------------------------------------]]

Detox = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0", "FuBarPlugin-2.0")

-- stuff for FuBar:
Detox.hasIcon = true
Detox.defaultPosition = "LEFT"
Detox.defaultMinimapPosition = 250
Detox.cannotDetachTooltip = false
Detox.tooltipHiddenWhenEmpty = true
Detox.hideWithoutStandby = true
Detox.clickableTooltip = true
Detox.independentProfile = true

function Detox:OnInitialize()
	self:RegisterDB("DetoxDB")
	self:RegisterDefaults('profile', defaults )
	self:RegisterChatCommand({'/detox'}, options )
	self.OnMenuRequest = options
	self.OnMenuRequest.args.lockTooltip.hidden = true
	self.OnMenuRequest.args.detachTooltip.hidden = true
	if not FuBar then
		self.OnMenuRequest.args.hide.guiName = "Hide minimap icon"
		self.OnMenuRequest.args.hide.desc = "Hide minimap icon"
	end
end


function Detox:OnEnable()
	if not aura then aura = AceLibrary("SpecialEvents-Aura-2.0") end
	if not RL then RL = AceLibrary("RosterLib-2.0") end

	self:RegisterEvent("SPELLCAST_STOP")
	self:RegisterEvent("UNIT_PET",1)
	self:RegisterEvent("SPELLS_CHANGED","RescanSpellbook",1)
	self:RegisterEvent("LEARNED_SPELL_IN_TAB","RescanSpellbook",1)
	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:RegisterEvent("RosterLib_RosterChanged")
	self:ParseSpellbook()
	self:ScheduleRepeatingEvent(self.OnUpdate, 1, self)
	self:ScheduleRepeatingEvent("liveList", self.Update, Detox.db.profile.updateSpeed or 0.5, self)	-- this is the FuBar live list update!
	self.debugging = self:IsDebugging()
	self:PopulateSkipList()
end


function Detox:OnDisable()
	local detached = self:IsTooltipDetached()
	if detached then
		self:ReattachTooltip()
		self.db.profile.detachedTooltip.detached = true
	end
end


function Detox:OnClick()  -- FuBarPlugin
	self:Clean()
end

function Detox:IsDebugging() return self.db.profile.debugging end
function Detox:SetDebugging(debugging) self.db.profile.debugging = debugging; self.debugging = debugging; end

--[[---------------------------------------------------------------------------------
 Events
------------------------------------------------------------------------------------]]

function Detox:OnUpdate()
	self:UpdateBlacklist()
end


function Detox:UpdateBlacklist()
	for unit in pairs(blacklist) do
		blacklist[unit] = blacklist[unit] - 1
		if blacklist[unit] < 0 then
			blacklist[unit] = nil
		end
	end
end


function Detox:RosterLib_RosterChanged(tbl)
	for name in pairs(tbl) do
		local u = tbl[name]
		if not u.name then -- someone left the raid
			for i = table.getn(priority), 1, -1 do
				if not RL.roster[priority[i].name] then
					priorityIndex[priority[i].name] = nil
					compost:Reclaim(priority[i])
					priority[i] = nil
					table.remove(priority, i)
				end
			end
		end
	end
	self:UpdatePriority()
end


function Detox:SPELLCAST_STOP()
	castTarget = nil
end


function Detox:UNIT_PET(unit)
	if unit == "player" then
		self:ScheduleEvent(self.CheckPet, 2, self)
	end
end


function Detox:UI_ERROR_MESSAGE(arg1)
	if arg1 == SPELL_FAILED_LINE_OF_SIGHT then
		if castTarget and not UnitIsUnit(castTarget, "player") then
			blacklist[castTarget] = Detox.db.profile.blacklistTime
		end
	end
end


--[[---------------------------------------------------------------------------------
 Spellbook
------------------------------------------------------------------------------------]]


function Detox:ParseSpellbook()
	compost:Reclaim(spells,1)
	spells = compost:Acquire()
	hasSpells = false
	local BookType    = BOOKTYPE_SPELL
	local break_flag  = false
	local i = 1
	local maxRankMagic      = 0
	local maxRankEnemyMagic = 0
	while not break_flag do
		while (true) do --  HUH?
			local name, rank = GetSpellName(i, BookType)
			if not name then
				if BookType == BOOKTYPE_PET then
					break_flag = true
					break
				end
				BookType = BOOKTYPE_PET
				i = 1
				break
			end
			if cleaningSpells[name] then
				hasSpells = true
				spells["cooldown"] = compost:Acquire(i, BookType)
				if name == BS["Cure Disease"] or name == BS["Purify"] then
					spells["disease1"] = compost:Acquire(i, BookType, name)
				end
				if name == BS["Abolish Disease"] or name == BS["Cleanse"] then
					spells["disease2"] = compost:Acquire(i, BookType, name)
				end
				if name == BS["Cure Poison"] or name == BS["Purify"] then
					spells["poison1"] = compost:Acquire(i, BookType, name)
				end
				if name == BS["Abolish Poison"] or name == BS["Cleanse"] then
					spells["poison2"] = compost:Acquire(i, BookType, name)
				end
				if name == BS["Remove Curse"] or name == BS["Remove Lesser Curse"] then
					spells["curse"] = compost:Acquire(i, BookType, name)
				end
				if name == BS["Stoneform"] then
					spells["poison3"] = compost:Acquire(i, BookType, name)
				end
				if name == BS["Cleanse"] or name == BS["Dispel Magic"] or name == BS["Devour Magic"] then
					if rank and string.find(rank, L["Rank (%d+)"]) then
						local ranknum = string.gsub(rank, L["Rank (%d+)"], "%1")
						if tonumber(ranknum) > maxRankMagic then
							spells["magic"] = compost:Acquire(i, BookType, name)
							maxRankMagic = tonumber(ranknum)
						end
					else
						spells["magic"] = compost:Acquire(i, BookType, name)
					end
				end
				if name == BS["Dispel Magic"] or name == BS["Purge"] or name == BS["Devour Magic"] then
					if rank and string.find(rank, L["Rank (%d+)"]) then
						local ranknum = string.gsub(rank, L["Rank (%d+)"], "%1")
						if tonumber(ranknum) > maxRankEnemyMagic then
							spells["enemymagic"] = compost:Acquire(i, BookType, name)
							maxRankEnemyMagic = tonumber(ranknum)
						end
					else
						spells["enemymagic"] = compost:Acquire(i, BookType, name)
					end
				end
			end
			i = i + 1
		end
	end
end


function Detox:RescanSpellbook()
	if not hasSpells then return end
	local valid = true
	for spell in pairs(spells) do
		if GetSpellName(spells[spell][1], spells[spell][2]) ~= spells[spell][3] then 
			valid = false
		end
	end
	if not valid then
		self:ParseSpellbook()
	end
end


function Detox:CheckPet()
	curr_DemonType = UnitCreatureFamily("pet")
	if last_DemonType ~= curr_DemonType then
		last_DemonType = curr_DemonType
		self:ParseSpellbook()
	end
end


--[[---------------------------------------------------------------------------------
 Cleaning
------------------------------------------------------------------------------------]]


function Detox:Clean()
	if not hasSpells then
		self:ParseSpellbook()
		if not hasSpells then
			return false
		end
	end
	-- check for cooldown
	local _, cooldown = GetSpellCooldown(spells["cooldown"][1], spells["cooldown"][2])
	if cooldown ~= 0 then
		return false
	end
	-- temporarily disable selfcasting
	local selfCast = GetCVar("autoSelfCast")
	SetCVar("autoSelfCast", "0")
	local cleanedType = nil
	local cleanedName = nil
	castTarget = nil
	-- save original target
	local targetIsEnemy = false
	local targetFriendlyName = nil
	if UnitExists("target") then
		if UnitIsFriend("target","player") then 
			targetFriendlyName = UnitName("target")
		else 
			targetIsEnemy = true
		end
	end	
	if SpellIsTargeting() then SpellStopTargeting() end
	-- try to clean target first
	if UnitExists("target") then
		cleanedType = self:CureUnit("target")
		if cleanedType then
			cleanedName = UnitName("target")
		end
	end
	-- couldn't clean target, check for MCd units
	if not cleanedType and spells["enemymagic"] then
		for k,v in ipairs(priority) do
			if v.pri == 0 then break end
			local unit = v.unitid
			if      UnitIsCharmed(unit) 
			and not blacklist[unit] then
				cleanedType = self:CureUnit(unit)
				if cleanedType then
					cleanedName = UnitName(unit)
					break
				end
			end
		end
	end
	-- now do the rest (this is duplicated code, gah!)
	if not cleanedType then
		for k,v in ipairs(priority) do
			if v.pri == 0 then break end
			local unit = v.unitid
			if  not blacklist[unit] 
			and not UnitIsCharmed(unit) then
				cleanedType = self:CureUnit(unit)
				if cleanedType then
					cleanedName = UnitName(unit)
					break
				end
			end
		end	
	end	
	-- now try blacklist
	if not cleanedType then
		for unit in pairs(blacklist) do
			cleanedType = self:CureUnit(unit)
			if cleanedType then
				cleanedName = UnitName(unit)
				blacklist[unit] = nil
				break
			end
		end
	end
	-- now try enemies
	if not cleanedType and spells["enemymagic"] then
		for n, u in pairs(RL.roster) do
			if UnitExists(u.unitid.."target") then
				cleanedType = self:CureUnit(u.unitid.."target")
				if cleanedType then
					cleanedName = UnitName(u.unitid.."target")
					self:Debug("dispelled enemy",cleanedName)
					break
				end
			end
		end
	end
	--restore original target
	if targetIsEnemy then
		if not UnitIsEnemy("target","player") then 
			TargetLastEnemy() 
		end
	elseif targetFriendlyName then
		if targetFriendlyName ~= UnitName("target") then 
			TargetByName(targetFriendlyName) 
		end
	elseif UnitExists("target") then 
		ClearTarget() 
	end
	-- restore self-cast
	SetCVar("autoSelfCast", selfCast)  -- maybe not do this here but on a delayed timer?
	-- scrolling combat text notification
	if cleanedType and cleanedName and self.db.profile.feedback then
		local text = string.format(L["Cleaned %s"], cleanedName)
		local color = DebuffTypeColor[cleanedType]
		if SCT and SCT_MSG_FRAME then -- SCT 5.x
			SCT_MSG_FRAME:AddMessage( text, color.r, color.g, color.b, 1 )
		elseif MikSBT then -- Mik's Scrolling Battle Text(MSBT)
			MikSBT.DisplayMessage(text, MikSBT.DISPLAYTYPE_NOTIFICATION, true, color.r * 255, color.g * 255, color.b * 255)
		elseif CombatText_AddMessage then
			-- CHECK FOR COMBAT TEXT
			CombatText_AddMessage(text, COMBAT_TEXT_SCROLL_FUNCTION, color.r, color.g, color.b, nil, nil)
		end
	end
	return cleanedType and true or false
end


function Detox:UnitCurable(unit)
	if not UnitExists(unit) then return false end
	if not UnitIsVisible(unit) then return false end
	if Detox.db.profile.range and not CheckInteractDistance(unit, 4) and not curr_DemonType then return false end
	-- check if unit is stealthed
	if Detox.db.profile.ignoreStealthed then
		for buff in pairs(invisible) do
			if aura:UnitHasBuff(unit, buff) then return false end
		end
	end
	-- check if we need to ignore unit
	for debuff in pairs(ignore) do
		if aura:UnitHasDebuff(unit, debuff) then return false end
	end
	-- check for debuffs that are buffs
	for debuff in pairs(skip) do
		if aura:UnitHasDebuff(unit, debuff) then return false end
	end
	-- check for debuffs we want to skip for specific classes when in combat
	if UnitAffectingCombat("player") then
		local _, class = UnitClass(unit)
		if Detox.db.profile.skipByClass[class] then
			for debuff in Detox.db.profile.skipByClass[class] do
				if Detox.db.profile.skipByClass[class][debuff] then
					if aura:UnitHasDebuff(unit, debuff) then return false end
				end
			end
		end
	end
	if Detox.db.profile.checkAbolish and aura:UnitHasBuff(unit, BS["Abolish Poison"]) then return false end
	if Detox.db.profile.checkAbolish and aura:UnitHasBuff(unit, BS["Abolish Disease"]) then return false end
	return true
end


function Detox:CureUnit(unit)
	if not self:UnitCurable(unit) then return false end
	local cleaned = false
	local skip
	local type
	-- check if we can clean a magic debuff
	if (spells["magic"] or spells["enemymagic"]) and aura:UnitHasDebuffType(unit, "Magic") then
		type = "Magic"
		-- check for MC
		if spells["enemymagic"] and UnitIsCharmed(unit) and UnitCanAttack("player", unit) then
				cleaned = self:CastCuringSpell(spells["enemymagic"], unit)
		elseif spells["magic"] and not UnitCanAttack("player", unit) then
				cleaned = self:CastCuringSpell(spells["magic"], unit)
		end
	end
	-- check if we can clean a curse
	if not cleaned and spells["curse"] and not UnitIsCharmed(unit) and aura:UnitHasDebuffType(unit, "Curse") then
		type = "Curse"
		cleaned = self:CastCuringSpell(spells["curse"], unit)
	end
	-- check if we can clean poison
	skip = ( Detox.db.profile.checkAbolish and aura:UnitHasBuff(unit, BS["Abolish Poison"]) ) or false
	if not cleaned and ( spells["poison1"] or spells["poison2"] ) and not UnitIsCharmed(unit) and not skip and aura:UnitHasDebuffType(unit, "Poison") then
		type = "Poison"
		if spells["poison2"] and not aura:UnitHasBuff(unit, BS["Abolish Poison"]) then
			cleaned = self:CastCuringSpell(spells["poison2"], unit)
		else
			cleaned = self:CastCuringSpell(spells["poison1"], unit)
		end
	end
	-- check if we can use stoneform to clean our own poison
	if not cleaned and unit == "player" and spells["poison3"] and aura:UnitHasDebuffType(unit, "Poison") then
		type = "Poison"
		cleaned = self:CastCuringSpell(spells["poison3"], unit)
	end
	-- check if we can clean disease
	skip = ( Detox.db.profile.checkAbolish and aura:UnitHasBuff(unit, BS["Abolish Disease"]) ) or false
	if not cleaned and ( spells["disease1"] or spells["disease2"] ) and not UnitIsCharmed(unit) and not skip and aura:UnitHasDebuffType(unit, "Disease") then
		type = "Disease"
		if spells["disease2"] and not aura:UnitHasBuff(unit, BS["Abolish Disease"]) then
			cleaned = self:CastCuringSpell(spells["disease2"], unit)
		else
			cleaned = self:CastCuringSpell(spells["disease1"], unit)
		end
	end
	if cleaned then return type else return nil end
end


function Detox:CastCuringSpell(spellID, unit)
	if UnitIsDeadOrGhost("player") then return false end
	if spellID[1] == 0 then return false end
	if spellID[2] ~= BOOKTYPE_PET and not CheckInteractDistance(unit, 4) then return false end
	local spellCasted = false
	local castingOnTarget = false
	-- check if we plan to clean our current target
	if unit ~= "target" then 
		ClearTarget()
	end
	-- cast spell
	castTarget = unit
	CastSpell(spellID[1], spellID[2])
	if SpellIsTargeting() then -- check if spell is usable
		SpellTargetUnit(unit)
	end
	spellCasted = true
	-- if spell is still targetting, we had a problem with casting on the unit
	if SpellIsTargeting() then 
		SpellStopTargeting()
		spellCasted = false
	end
	-- we're done
	return spellCasted
end


--[[---------------------------------------------------------------------------------
 Debuff skipping
------------------------------------------------------------------------------------]]


function Detox:AddSkippedDebuff(debuffName)
	for k, name in Detox.db.profile.debuffsInSkipList do
		if name == debuffName then return end
	end
	table.insert(Detox.db.profile.debuffsInSkipList, debuffName)
	self:PopulateSkipList()
end

-- XXX Please note that we don't remove the class ignores for this debuff.
-- XXX Should we?
function Detox:RemoveSkippedDebuff(debuffName)
	for k, name in Detox.db.profile.debuffsInSkipList do
		if name == debuffName then
			table.remove(Detox.db.profile.debuffsInSkipList, k)
		end
	end
	self:PopulateSkipList()
end


function Detox:PopulateSkipList()
	local classes = { "Warrior", "Priest", "Druid", "Shaman", "Paladin", "Mage", "Warlock", "Hunter", "Rogue" }

	if options.args.filter.args.debuff.args["add"] then
		compost:Reclaim(options.args.filter.args.debuff.args["add"])
		options.args.filter.args.debuff.args["add"] = nil

		for k, debuff in pairs(Detox.db.profile.debuffsInSkipList) do
			local d = string.gsub(debuff, " ", "")
			compost:Reclaim(options.args.filter.args.debuff.args["remove"][d])
			options.args.filter.args.debuff.args["remove"][d] = nil
		end
		compost:Reclaim(options.args.filter.args.debuff.args["remove"])
		options.args.filter.args.debuff.args["remove"] = nil
	end

	-- |class| is also the spacer some time during the loop
	for class in pairs(options.args.filter.args.debuff.args) do
		for debuff in pairs(options.args.filter.args.debuff.args[class]) do
			local d = string.gsub(debuff, " ", "")
			-- If we just added a debuff, it will not be in the menu yet, so
			-- check in case we try to reclaim it.
			if options.args.filter.args.debuff.args[class][d] then
				compost:Reclaim(options.args.filter.args.debuff.args[class][d])
				options.args.filter.args.debuff.args[class][d] = nil
			end
		end
		compost:Reclaim(options.args.filter.args.debuff.args[class])
		options.args.filter.args.debuff.args[class] = nil
	end

	-- create add option in dewdrop
	options.args.filter.args.debuff.args["add"] = compost:Acquire()
	options.args.filter.args.debuff.args["add"].type = 'text'
	options.args.filter.args.debuff.args["add"].name = L["Add"]
	options.args.filter.args.debuff.args["add"].desc = L["Adds a new debuff to the class submenus."]
	options.args.filter.args.debuff.args["add"].get = false
	options.args.filter.args.debuff.args["add"].set = function(v) self:AddSkippedDebuff(v) end
	options.args.filter.args.debuff.args["add"].usage = L["<debuff name>"]
	options.args.filter.args.debuff.args["add"].order = 101

	-- create remove option in dewdrop
	options.args.filter.args.debuff.args["remove"] = compost:Acquire()
	options.args.filter.args.debuff.args["remove"].type = 'group'
	options.args.filter.args.debuff.args["remove"].name = L["Remove"]
	options.args.filter.args.debuff.args["remove"].desc = L["Removes a debuff from the class submenus."]
	options.args.filter.args.debuff.args["remove"].args = compost:Acquire()
	options.args.filter.args.debuff.args["remove"].order = 102
	-- create list of debuffs in subfolder
	for k, debuff in pairs(Detox.db.profile.debuffsInSkipList) do
		local debuffName = debuff
		local d = string.gsub(debuffName, " ", "")
		options.args.filter.args.debuff.args["remove"].args[d] = compost:Acquire()
		options.args.filter.args.debuff.args["remove"].args[d].type = 'execute'
		options.args.filter.args.debuff.args["remove"].args[d].name = debuffName
		options.args.filter.args.debuff.args["remove"].args[d].desc = string.format(L["Remove %s from the class submenus."], debuffName)
		options.args.filter.args.debuff.args["remove"].args[d].func = function() return self:RemoveSkippedDebuff(debuffName) end
	end
	
	-- create spacer
	options.args.filter.args.debuff.args.spacer = { type = "header", order = 103 }

	-- create list of debuffs
	for k, debuff in pairs(Detox.db.profile.debuffsInSkipList) do
		local debuffName = debuff
		local d = string.gsub(debuffName, " ", "")
		options.args.filter.args.debuff.args[d] = compost:Acquire()
		options.args.filter.args.debuff.args[d].type = 'group'
		options.args.filter.args.debuff.args[d].name = debuffName
		options.args.filter.args.debuff.args[d].desc = string.format(L["Classes to filter for: %s."], debuffName)
		options.args.filter.args.debuff.args[d].args = compost:Acquire()
		options.args.filter.args.debuff.args[d].order = 200
		-- create submenu for classes
		for k, class in pairs(classes) do
			local className = class
			options.args.filter.args.debuff.args[d].args[className] = compost:Acquire()
			options.args.filter.args.debuff.args[d].args[className].type = 'toggle'
			options.args.filter.args.debuff.args[d].args[className].name = BC[className]
			options.args.filter.args.debuff.args[d].args[className].desc = string.format(L["Toggle filtering %s on %s."], debuffName, BC[className])
			options.args.filter.args.debuff.args[d].args[className].get =
				function() return Detox.db.profile.skipByClass[string.upper(className)][debuffName] end
			options.args.filter.args.debuff.args[d].args[className].set =
				function()
					Detox.db.profile.skipByClass[string.upper(className)][debuffName] = not Detox.db.profile.skipByClass[string.upper(className)][debuffName]
				end
		end
	end
	
	
	
end


--[[---------------------------------------------------------------------------------
 Priority
------------------------------------------------------------------------------------]]

function Detox:PriorityPrint(target, priority)
	if priority then
		self:Print(string.format(L["%s was added to the priority list."], target))
	else
		self:Print(string.format(L["%s has been removed from the priority list."], target))
	end
end

function Detox:PriorityToggle(targetType)
	if not UnitExists("target") then
		self:Print(L["Can't add/remove current target to priority list, it doesn't exist."])
		return
	end
	local target = UnitName("target")
	if not targetType then
		if not RL.roster[target] then
			self:Print(L["Can't add/remove current target to priority list, it's not in your raid."])
			return
		end
		Detox.db.profile.priorityNames[target] = not Detox.db.profile.priorityNames[target]
		self:PriorityPrint(target, Detox.db.profile.priorityNames[target])
	else
		local targetGroup = nil
		local targetClass = nil

		for n, u in pairs(RL.roster) do
			if u and u.name and u.class ~= "PET" then
				if not targetGroup and u.name == target then
					targetGroup = u.subgroup
					targetClass = u.class
					break
				end
			end
		end

		if targetType == "class" and targetClass then
			Detox.db.profile.priorityClasses[targetClass] = not Detox.db.profile.priorityClasses[targetClass]
			self:PriorityPrint(string.format(L["Class %s"], targetClass), Detox.db.profile.priorityClasses[targetClass])
		elseif targetType == "group" and targetGroup then
			Detox.db.profile.priorityGroups[targetGroup] = not Detox.db.profile.priorityGroups[targetGroup]
			self:PriorityPrint(string.format(L["Group %s"], targetGroup), Detox.db.profile.priorityGroups[targetGroup])
		else
			self:Print(L["Can't add/remove current target to priority list, it's not in your raid."])
			return
		end
	end
	self:UpdatePriority()
end

local function sortPri(a,b) 
	return a.pri > b.pri 
end

function Detox:UpdatePriority()
	self:CreateOptionsTable()
	-- update and sort all units. this task has a few steps:
	local datasubtable, index
	for name, u in pairs(RL.roster) do
		-- see if that unit is in our priorityIndex table
		index = priorityIndex[name]
		-- either use the existing subtable or create a new one
		datasubtable = index and priority[index] or compost:Acquire()
		datasubtable.pri = self:GetPriority(name)
		datasubtable.unitid = u.unitid
		if not index then
			-- our subtable still needs a name
			datasubtable.name = name
			-- add that subtable to the priority table
			table.insert(priority, datasubtable)
			priorityIndex[name] = table.getn(priority)  -- maybe not needed, but for safety reasons it can't hurt.
		end
	end
	-- now re-sort the priority table
	table.sort(priority, sortPri)
	-- save the current index for all names
	for k,v in ipairs(priority) do
		priorityIndex[v.name] = k
	end
end


function Detox:CreateOptionsTable()
	-- we need to update the dewdrop menu, so lets clear the old one and inject new stuff:
	for class in options.args.priority.args do
		for unit in options.args.priority.args[class].args do
			compost:Reclaim(options.args.priority.args[class].args[unit])
			options.args.priority.args[class].args[unit] = nil
		end
		compost:Reclaim(options.args.priority.args[class])
		options.args.priority.args[class] = nil
	end

	compost:Reclaim(options.args.priority.args["group"])

	options.args.priority.args["group"] = compost:Acquire()
	options.args.priority.args["group"].type = 'group'
	options.args.priority.args["group"].name = L["Groups"]
	options.args.priority.args["group"].desc = L["Prioritize by group."]
	options.args.priority.args["group"].order = 100
	options.args.priority.args["group"].args = compost:Acquire()
	for i = 1, 8 do
		local x = i
		options.args.priority.args["group"].args["group"..i] = compost:Acquire()
		options.args.priority.args["group"].args["group"..i].type = 'toggle'
		options.args.priority.args["group"].args["group"..i].name = string.format(L["Group %s"], i)
		options.args.priority.args["group"].args["group"..i].desc = string.format(L["Prioritize group %s."], i)
		options.args.priority.args["group"].args["group"..i].order = 100 + i
		options.args.priority.args["group"].args["group"..i].get =
			function() return Detox.db.profile.priorityGroups[x] end
		options.args.priority.args["group"].args["group"..i].set =
			function()
				Detox.db.profile.priorityGroups[x] = not Detox.db.profile.priorityGroups[x]
				Detox:UpdatePriority()
			end
	end

	-- create subgroups
	for name, unit in pairs(RL.roster) do
		if unit and unit.class ~= "PET" then
			local n = name
			local u = unit
			if not options.args.priority.args[u.class] then
				options.args.priority.args[u.class] = compost:Acquire()
				options.args.priority.args[u.class].type = 'group'
				-- convert class name. gah.
				-- we need this as Babble-Class doesnt know capitalized class names, nor does it know "PET"
				local c = strupper(strsub(u.class, 1, 1)) .. strlower(strsub(u.class, 2))
				if c ~= "Pet" then c = BC[c] end
				options.args.priority.args[u.class].name = c
				options.args.priority.args[u.class].desc = c
				options.args.priority.args[u.class].order = 101
				options.args.priority.args[u.class].args = compost:Acquire()

				-- Create "all <class>" item
				if not options.args.priority.args[u.class].args[c] then
					options.args.priority.args[u.class].args[c] = compost:Acquire()
					options.args.priority.args[u.class].args[c].type = 'toggle'
					options.args.priority.args[u.class].args[c].name = string.format(L["Every %s"], c)
					options.args.priority.args[u.class].args[c].desc = string.format(L["Prioritize every %s."], c)
					options.args.priority.args[u.class].args[c].order = 100
					options.args.priority.args[u.class].args[c].get = 
						function() return Detox.db.profile.priorityClasses[u.class] end
					options.args.priority.args[u.class].args[c].set =
						function()
							Detox.db.profile.priorityClasses[u.class] = not Detox.db.profile.priorityClasses[u.class]
							Detox:UpdatePriority()
						end
				end
			end
			options.args.priority.args[u.class].args[n] = compost:Acquire()
			options.args.priority.args[u.class].args[n].type = 'toggle'
			options.args.priority.args[u.class].args[n].name = n
			options.args.priority.args[u.class].args[n].desc = string.format(L["Prioritize %s."], n)
			options.args.priority.args[u.class].args[n].order = 101
			options.args.priority.args[u.class].args[n].get = 
				function() return Detox.db.profile.priorityNames[n] end
			options.args.priority.args[u.class].args[n].set = 
				function() 
					Detox.db.profile.priorityNames[n] = not Detox.db.profile.priorityNames[n]
					Detox:UpdatePriority()
				end
		end
	end
end


function Detox:GetPriority(name)
	local playergroup = (RL.roster[UnitName("player")] and RL.roster[UnitName("player")].subgroup) or 1
	local pri
	local grp = RL.roster[name].subgroup
	local cls = RL.roster[name].class
	-- priority range 1000 - 0.
	if     name == UnitName("player") then  pri = 800
	elseif playergroup == grp         then  pri = 700
	elseif playergroup < grp          then  pri = 700 - (grp - playergroup)*10
	else                                    pri = 700 - (grp + 8 - playergroup)*10
	end
	if cls == "PET" then
		if Detox.db.profile.ignorePets then pri = 0 else pri = pri - 200 end
	end
	if Detox.db.profile.priorityNames[name] then pri = pri + 200 end  -- unit in individual priority list
	if Detox.db.profile.priorityClasses[cls] then pri = pri + 200 end  -- unit in prioritized class
	if Detox.db.profile.priorityGroups[grp] then pri = pri + 200 end  -- unit in prioritized group
	return pri
end


--[[---------------------------------------------------------------------------------
 Live display and other FuBar stuff
------------------------------------------------------------------------------------]]


function Detox:OnTooltipUpdate()
	local cat = nil
	local lines = 0
	for k,v in ipairs(priority) do
		if v.pri == 0 then break end
		if lines > Detox.db.profile.liveDisplay then break end
		local unit = v.unitid
		if UnitIsVisible(unit) and not blacklist[unit] and self:UnitCurable(unit) then
			for debuffname, count, type, texture in aura:DebuffIter(unit) do
				if ( not Detox.db.profile.filter and ( type == "Magic" or type == "Poison" or type == "Disease" or type == "Curse" ) )
				or ( type == "Magic" and spells["magic"] )
				or ( type == "Poison" and ( spells["poison1"] or spells["poison2"] ) )
				or ( type == "Disease" and ( spells["disease1"] or spells["disease2"] ) )
				or ( type == "Curse" and spells["curse"] )
				then
					local r,g,b = self:GetRaidColors(unit)
					if count == 0 then count = 1 end
					lines = lines + 1
					if not cat then
						cat = tablet:AddCategory("columns", 2, "text", "", "text2", "", "showWithoutChildren", false, "hideBlankLine", false)
					end
					cat:AddLine(
						"text", string.format("%s (%dx)", debuffname, count), 
						"textR", DebuffTypeColor[type].r,
						"textG", DebuffTypeColor[type].g,
						"textB", DebuffTypeColor[type].b,
						"text2", UnitName(unit),
						"text2R", r,
						"text2G", g,
						"text2B", b,
						"hasCheck", true, 
						"checked", true, 
						"checkIcon", texture,
						"func", function(unit) Detox:CureUnit(unit) end,
						"arg1", unit,
						"justify", "LEFT",
						"justify2", "LEFT"
					)
					-- update fubar display (icon + text) to display the first
					-- debuff we find.
					if lines == 1 then
						self:SetIcon(texture)
						self:SetText(string.format("|cff%02x%02x%02x%s|r", DebuffTypeColor[type].r*255, DebuffTypeColor[type].g*255, DebuffTypeColor[type].b*255, UnitName(unit)))
					end
				end
			end
		end
	end
	-- play sound
	if Detox.db.profile.sound then
		if lines == 0 then
			soundPlayed = false
		elseif not soundPlayed then
			PlaySoundFile("Sound\\interface\\AuctionWindowOpen.wav")
			soundPlayed = true
		end
	end
	-- Reset FuBar text and display
	if lines == 0 then
		self:SetIcon(true)
		self:SetText("Detox")
	end
	-- Show the prioritized units
	if Detox.db.profile.showPriorities then
		local priCat = nil
		local text = nil
		for k,v in ipairs(priority) do
			if v.pri > 700 then
				if not priCat then priCat = tablet:AddCategory("columns", 1, "text", L["Priorities"]) end
				local name = v.name
				if not text then
					text = name
				else
					text = text..", "..name
				end
			end
		end
		if priCat then priCat:AddLine("text", text..".", "wrap", true) end
	end
end


function Detox:OnClick()
	self:Clean()
end


function Detox:GetRaidColors(unit)
	local _,class = UnitClass(unit)
	if RAID_CLASS_COLORS[class] then
		return RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	else
		return 0.5, 0.5, 0.5
	end
end

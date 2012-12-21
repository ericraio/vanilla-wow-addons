aUF = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceDB-2.0", "AceConsole-2.0")
aUF.Layouts = {}

local L = AceLibrary("AceLocale-2.0"):new("ag_UnitFrames")
local AceOO = AceLibrary("AceOO-2.0")

local print = function(msg) if msg then DEFAULT_CHAT_FRAME:AddMessage(msg) end end

-- SYSTEM

function aUF:OnInitialize()
	self:RegisterDB("aUFDB")
	self:RegisterDefaults('profile', aUF_DEFAULT_OPTIONS)
	
	self:SetupVariables()
	self:UpdateBlizzVisibility()
	self:InitMenu()
	self:RegisterEvents()
	self:LoadStringFormats()
	if UnitInRaid("player") == 1 then
		self:RAID_ROSTER_UPDATE()
	end
	aUF:ScheduleRepeatingEvent("agUF_auraPoolSchedule",self.AuraPool, 0.3, self)	
end

function aUF:AuraPool()
	local n = 0
	for k,v in pairs(self.auraUpdatePool) do
		if v == true and self.auraUpdates + n < 5 then
			self.units[k]:UpdateAuras(true)
			n = n + 1
		else
			break
		end
	end
	aUF.auraUpdates = 0
end

function aUF:Reset()
	self:ResetDB("profile")
	self:LoadStringFormats()
	self:CallUnitMethods("Reset")
	self:CallUnitMethods("Reset",nil,nil,nil,"subgroups")
end

function aUF:OnProfileEnable()
	self:CallUnitMethods("Reset")					
end

-- EVENT REGISTERING

function aUF:RegisterEvents()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("UNIT_PET","PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")

	self:RegisterEvent("agUF_UpdateGroups")		
end

function aUF:SetupVariables()
	self.auraUpdates = 0
	self.auraUpdatePool = {}
	
	self.feedback = {}
	
	self.imagePath = "Interface\\AddOns\\ag_UnitFrames\\images\\"
	self.fontPath = "Interface\\AddOns\\ag_UnitFrames\\fonts\\"
	
	self.wowClasses = {"player","pet","party","partypet","target","targettarget","raid","raidpet"}
	
	-- Which auras can the player see?
	self.CanDispel = {
		["PRIEST"] = {
			["Magic"] = true,
			["Disease"] = true,
		},
		["SHAMAN"] = {
			["Poison"] = true,
			["Disease"] = true,
		},
		["PALADIN"] = {
			["Magic"] = true,
			["Poison"] = true,
			["Disease"] = true,
		},
		["MAGE"] = {
			["Curse"] = true,
		},
		["DRUID"] = {
			["Curse"] = true,
			["Poison"] = true,
		}			
	}
	
	-- Various constants like colors, textures...
	
	self.DebuffColor = {
		["Magic"] = {
			r = 1,
			g = 0,
			b = 0,
		},
		["Disease"] = {
			r = 0.25,
			g = 1,
			b = 0,		
		},
		["Poison"] = {
			r = 0,
			g = 0.25,
			b = 1,		
		},	
		["Curse"] = {
			r = 0.75,
			g = 0,
			b = 0.75,		
		}	
	}
	
	self.RepColor = {
		[1] = {r = 226/255, g = 45/255, b = 75/255},
		[2] = {r = 226/255, g = 45/255, b = 75/255},
		[3] = {r = 0.75, g = 0.27, b = 0},
		[4] = {r = 1, g = 1, b = 34/255},
		[5] = {r = 0.2, g = 0.8, b = 0.15},
		[6] = {r = 0.2, g = 0.8, b = 0.15},
		[7] = {r = 0.2, g = 0.8, b = 0.15},
		[8] = {r = 0.2, g = 0.8, b = 0.15},
	}
	
	self.HealthColor = {
		r = 0.11,
		g = 0.84,
		b = 0.3,
	}
	
	self.ManaColor = {
		[0] = { r = 48/255, g = 113/255, b = 191/255}, -- Mana
		[1] = { r = 226/255, g = 45/255, b = 75/255}, -- Rage
		[2] = { r = 255/255, g = 210/255, b = 0}, -- Focus
		[3] = { r = 255, g = 220/255, b = 25/255}, -- Energy
		[4] = { r = 0.00, g = 1.00, b = 1.00} -- Happiness
	}
	
	self.Borders = {
		["Classic"] 	= {["texture"] = "Interface\\Tooltips\\UI-Tooltip-Border",["size"] = 16,["insets"] = 5},
		["Nurfed"]	 	= {["texture"] = "Interface\\DialogFrame\\UI-DialogBox-Border",["size"] = 16,["insets"] = 5},
		["Hidden"] 		= {["texture"] = "",["size"] = 0,["insets"] = 3},
	}
	self.Bars	= {
		["Default"]		= self.imagePath.."AceBarFrames.tga",
		["Classic"]		= "Interface\\TargetingFrame\\UI-StatusBar",
		["Smooth"]		= self.imagePath.."smooth.tga",
		["Bumps"]		= self.imagePath.."Bumps.tga",
		["Perl"]			= self.imagePath.."Perl.tga",
		["Gloss"]			= self.imagePath.."Gloss.tga",
		["Wisps"]		= self.imagePath.."Wisps.tga",
		["Bars"]			= self.imagePath.."Bars.tga",
		["Smudge"]	= self.imagePath.."Smudge.tga",
		["Dabs"]			= self.imagePath.."Dabs.tga",
		["Rain"]			= self.imagePath.."Rain.tga",
		["Hatched"]	= self.imagePath.."Hatched.tga",
		["Cracked"]	= self.imagePath.."Cracked.tga",
		["Grid"]			= self.imagePath.."Grid.tga",
		["Button"]		= self.imagePath.."Button.tga",
		["Skewed"]		= self.imagePath.."Skewed.tga",
		["Diagonal"]	= self.imagePath.."Diagonal.tga",
		["Cloud"]			= self.imagePath.."Cloud.tga",
		["Water"]			= self.imagePath.."Water.tga",
		["Charcoal"]			= self.imagePath.."Charcoal.tga",
		["BantoBar"]			= self.imagePath.."BantoBar.tga",
	}

	self.RaidColors = {
		["DRUID"]	= "|cffff7c0a",
		["HUNTER"]	= "|cffaad372",
		["MAGE"]	= "|cff68ccef",
		["PALADIN"]	= "|cfff48cba",
		["PRIEST"]	= "|cffffffff",
		["ROGUE"]	= "|cfffff468",
		["SHAMAN"]	= "|cfff48cba",
		["WARLOCK"]	= "|cff9382C9",
		["WARRIOR"]	= "|cffc69b6d",
	}

	self.RaidRole = {
		["DRUID"]	= "healer",
		["HUNTER"]	= "dps",
		["MAGE"]	= "dps",
		["PALADIN"]	= "healer",
		["PRIEST"]	= "healer",
		["ROGUE"]	= "dps",
		["SHAMAN"]	= "healer",
		["WARLOCK"]	= "dps",
		["WARRIOR"]	= "tank",
	}

	self.UnitInformation = {
	["name"] = function(u) local type = string.gsub(u, "%d", "") if self.db.profile[type].RaidColorName and UnitIsPlayer(u) then local _,x=UnitClass(u) return string.format("%s%s%s",aUF.RaidColors[x] or "",UnitName(u) or "","|cFFFFFFFF") else return UnitName(u) or "" end end,
	
	["status"] = function (u) if UnitIsDead(u) then return "Dead" elseif UnitIsGhost(u) then return "Ghost" elseif (not UnitIsConnected(u)) then return "Offline" elseif (UnitAffectingCombat(u)) then return "Combat" elseif (u== "player" and IsResting()) then return "Resting" else return "" end end,
	["statuscolor"] = function (u) if UnitIsDead(u) then return "|cffff0000" elseif UnitIsGhost(u) then return "|cff9d9d9d" elseif (not UnitIsConnected(u)) then return "|cffff8000" elseif (UnitAffectingCombat(u)) then return "|cffFF0000" elseif (u== "player" and IsResting()) then return WatchDog:GetHex(UnitReactionColor[4]) else return "" end end,
	["happycolor"] = function (u) local x=GetPetHappiness() return ( (x==2) and "|cffFFFF00" or (x==1) and "|cffFF0000" or "" ) end,

    ["aghp"] = function(u) return self:Tag_aghp(u) or "" end,
    ["agpercenthp"] = function(u) return self:Tag_aghp(u,1) or "" end,
    ["agmissinghp"] = function(u) return self:Tag_aghp(u,2) or "" end,
    ["agsmarthp"] = function(u) return self:Tag_aghp(u,3) or "" end,
	
    ["agmana"] = function(u) return self:Tag_agmana(u) or "" end,
    ["agpercentmana"] = function(u) return self:Tag_agmana(u,1) or "" end,
    ["agmissingmana"] = function(u) return self:Tag_agmana(u,2) or "" end,
    ["agsmartmana"] = function(u) return self:Tag_agmana(u,3) or "" end,
	
	["agclass"] = function (u) if UnitIsPlayer(u) then return (UnitClass(u) or "Unknown") else return (UnitCreatureFamily(u) or UnitCreatureType(u) or "") end end,
	["agrace"] = function (u) if string.find(u,"target") then return UnitRace(u) or "" else return "" end end,
	["agtype"] = function (u) if (UnitIsPlusMob(u)) then return aUF:TargetGetMobType(u) or "" else return "" end end,
	
	["curhp"] = function (u) return UnitHealth(u) or 0 end,
	["maxhp"] = function (u) return UnitHealthMax(u) or 1 end,
	["percenthp"] = function (u) local hpmax = UnitHealthMax(u) return (hpmax ~= 0) and floor((UnitHealth(u) / hpmax) * 100) or 0 end,
	["missinghp"] = function (u) return UnitHealthMax(u) - UnitHealth(u) or 0 end,
	
	["curmana"] = function (u) return UnitMana(u) or 1 end,
	["maxmana"] = function (u) return UnitManaMax(u) or 0 end,
	["percentmana"] = function (u) local mpmax = UnitManaMax(u) return (mpmax ~= 0) and floor((UnitMana(u) / mpmax) * 100) or 0 end,
	["missingmana"] = function (u) return UnitHealthMax(u) - UnitHealth(u) or 0 end,

	["typemana"] = function (u) local p=UnitPowerType(u) return ( (p==1) and "Rage" or (p==2) and "Focus" or (p==3) and "Energy" or "Mana" ) end,
	["level"] = function (u) local x = UnitLevel(u) return ((x>0) and x or "??") end,
	["class"] = function (u) return (UnitClass(u) or "Unknown") end,
	["creature"] = function (u) return (UnitCreatureFamily(u) or UnitCreatureType(u) or "Unknown") end,
	["smartclass"] = function (u) if UnitIsPlayer(u) then return self.UnitInformation["class"](u) else return self.UnitInformation["creature"](u) end end,
	["combos"] = function (u) return (GetComboPoints() or 0) end,
	["combos2"] = function (u) return string.rep("@", GetComboPoints()) end,
	["classification"] = function (u) if UnitClassification(u) == "rare" then return "Rare " elseif UnitClassification(u) == "eliterare" then return "Rare Elite " elseif UnitClassification(u) == "elite" then return "Elite " elseif UnitClassification(u) == "worldboss" then return "Boss " else return "" end end, 
	["faction"] = function (u) return (UnitFactionGroup(u) or "") end,
	["connect"] = function (u) return ( (UnitIsConnected(u)) and "" or "Offline" ) end,
	["race"] = function (u) return ( UnitRace(u) or "") end,
	["pvp"] = function (u) return ( UnitIsPVP(u) and "PvP" or "" ) end,
	["plus"] = function (u) return ( UnitIsPlusMob(u) and "+" or "" ) end,
	["sex"] = function (u) local x = UnitSex(u) return ( (x==0) and "Male" or (x==1) and "Female" or "" ) end,
	["rested"] = function (u) return (GetRestState()==1 and "Rested" or "") end,
	["leader"] = function (u) return (UnitIsPartyLeader(u) and "(L)" or "") end,
	["leaderlong"] = function (u) return (UnitIsPartyLeader(u) and "(Leader)" or "") end,
	
	["happynum"] = function (u) return (GetPetHappiness() or 0) end,
	["happytext"] = function (u) return ( getglobal("PET_HAPPINESS"..(GetPetHappiness() or 0)) or "" ) end,
	["happyicon"] = function (u) local x=GetPetHappiness() return ( (x==3) and ":)" or (x==2) and ":|" or (x==1) and ":(" or "" ) end,
		
	["curxp"] = function (u) return (UnitXP(u) or "") end,
	["maxxp"] = function (u) return (UnitXPMax(u) or "") end,
	["percentxp"] = function (u) local x=UnitXPMax(u) if (x>0) then return floor( UnitXP(u)/x*100+0.5) else return 0 end end,
	["missingxp"] = function (u) return (UnitXPMax(u) - UnitXP(u)) end,
	["restedxp"] = function (u) return (GetXPExhaustion() or "") end,

	["tappedbyme"] = function (u) if UnitIsTappedByPlayer("target") then return "*" else return "" end end,
	["istapped"] = function (u) if UnitIsTapped(u) and (not UnitIsTappedByPlayer("target")) then return "*" else return "" end end,
	["pvpranknum"] = function (u) if (UnitPVPRank(u) >= 1) then return ((UnitPVPRank(u)-4) or "") else return "" end end,
	["pvprank"] = function (u) if (UnitPVPRank(u) >= 1) then return (GetPVPRankInfo(UnitPVPRank(u), u) or "" ) else return "" end end,
	["fkey"] = function (u)
		local _,_,fkey = string.find(u, "^party(%d)$")
		if u == "player" then
			fkey = 0
		end
		if not fkey then
			return ""
		else
			return "F"..(fkey+1)
		end
	end,
	["white"] = function (u) return "|cFFFFFFFF" end,
	["aggro"] = function (u)
		local x = (UnitReaction("player",u) or 5)
		return self:GiveHex(UnitReactionColor[x].r, UnitReactionColor[x].g, UnitReactionColor[x].b)
	end,
	["difficulty"] = function (u) if UnitCanAttack("player",u) then local x = (UnitLevel(u)>0) and UnitLevel(u) or 99 local color = GetDifficultyColor(x) return aUF:GiveHex(color.r,color.g,color.b) else return "" end end,
	["colormp"] = function (u) local x = ManaBarColor[UnitPowerType(u)] return self:GiveHex(x.r, x.g, x.b) end,  
	["inmelee"] = function (u) if PlayerFrame.inCombat then return "|cffFF0000" else return "" end end,
	["incombat"] = function (u) if UnitAffectingCombat(u) then return "|cffFF0000" else return "" end end,
	["raidcolor"] = function (u) local _,x=UnitClass(u) if x and UnitIsPlayer(u) then return (self.RaidColors[x] or "") else return "" end end,
	}
	
	self.formats = {
		["Health"] = {
			["Absolute"]	= "[aghp]",
			["Difference"]	= "[agmissinghp]",
			["Percent"]		= "[agpercenthp]",
			["Smart"]		= "[agsmarthp]",
			["Hide"]		= "",
		},
		["Mana"] = {
			["Absolute"]	= "[agmana]",
			["Difference"]	= "[agmissingmana]",
			["Percent"]		= "[agpercentmana]",
			["Smart"]		= "[agsmartmana]",
			["Hide"]		= "",
		},
		["Name"] = {
			["Default"]	= "[name]",
			["Hide"]		= "",			
		},
		["Class"] = {
			["Default"]	= "[agtype][difficulty][level][white] [raidcolor][agclass][white] [agrace]",
			["Hide"]		= "",			
		}		
	}
	
	
	self.HelperFunctions = {}
	self.units = {}
	self.subgroups = {}
	self.changedSubgroups = {}
end

-- EVENTS

function aUF:PLAYER_LOGIN()
	aUF:CreateObject("player","player","XP")
	aUF:CreateObject("pet","pet","XP")
	aUF:CreateObject("target","target","Combo")
	aUF:CreateObject("targettarget","targettarget","Metro")
	
	self:PARTY_MEMBERS_CHANGED()
end

function aUF:PLAYER_TARGET_CHANGED()
	if self.units.target then
		self.units.target:UpdateAll()
	end
	if self.units.targettarget then
		if UnitExists("target")	then
			self.units.targettarget:Start()
		else
			self.units.targettarget:Stop()
		end
	end
end

function aUF:PARTY_MEMBERS_CHANGED()
	for i = 1,4 do
		if aUF:CheckVisibility("party"..i) == true then
			aUF:CreateObject("party"..i)
		end
		if aUF:CheckVisibility("partypet"..i) == true then
			aUF:CreateObject("partypet"..i)
		end		
	end
end

function aUF:RAID_ROSTER_UPDATE()
	for i = 1,40 do
		if aUF:CheckVisibility("raid"..i) == true then
			aUF:CreateObject("raid"..i,"raid"..i,"Raid")
		end			
	end	
	self:PARTY_MEMBERS_CHANGED()
end

function aUF:agUF_UpdateGroups()
	for name in self.changedSubgroups do
		if string.find(name,"party") then
			self.subgroups[name].raid = false
		end		
		self.subgroups[name]:Update()
	end
	self.changedSubgroups = {}
end

-- UTILITY FUNCTIONS

function aUF:CreateObject(name,unit,type,db)
	if not self.units[name] then
		if not unit then
			unit = name
		end
		if not type then
			self.units[name] = self.classes.aUFunit:new(name,unit,db)
		else
			self.units[name] = self.classes["aUFunit"..type]:new(name,unit,db)
		end
	end
end

function aUF:FindObjects(sortBy,object)
	local table = {}
	if not object then object = "units" end
	if self[object] then
		for _,v in self[object] do
			if v[sortBy] then
				if not table[v[sortBy]] then
					table[v[sortBy]] = {}
				end
				tinsert(table[v[sortBy]],v)
			end
		end
	end
	return table
end

function aUF:CallUnitMethods(func,arg,find,type,object)
	if not func then return end
	if find and type then
		if aUF:FindObjects(type)[find] then
			for _,unitObject in aUF:FindObjects(type,object)[find] do
				if unitObject[func] then
					unitObject[func](unitObject,arg)
				end
			end
		end
	else
		if not object then object = "units" end
		if self[object] then
			for _,unitObject in self[object] do
				unitObject[func](unitObject,arg)		
			end
		end
	end
end

function aUF:CheckVisibility(unit)
	local _,_,type = string.find(unit, "(%a+)")
	
--	if  self.db.profile[type].AlwaysShow == true then
--		return true
--	end
	-- Special cases
	   -- Hide targettarget if player is targetting self
	if unit == "targettarget" then
		if UnitName("player") == UnitName("target") then
			return false
		end
		-- Hide partyframes in raid
	elseif type == "party" then
		if self.db.profile.RaidHideParty == true and UnitInRaid("player") == 1 then
			return false
		end
	elseif type == "partypet" then
		if self.db.profile.RaidHideParty == true and UnitInRaid("player") == 1 then
			return false
		end	
		local parent = string.gsub(unit,"pet","")
		if aUF:CheckVisibility(parent) == false then
			return false
		end
	elseif type == "raidpet" then
		local parent = string.gsub(unit,"pet","")
		if not aUF:CheckVisibility(parent) then
			return false
		end
	end
		
	if (UnitExists(unit) and not self.db.profile[type].HideFrame == true) then
		return true
	end
end

function aUF:UtilFactionColors(unit)
	local r, g, b = 0,0,0	
	local a = 0.5
	if ( UnitPlayerControlled(unit) ) then
		if ( UnitCanAttack(unit, "player") ) then
			if ( not UnitCanAttack("player", unit) ) then
				r = self.ManaColor[0].r
				g = self.ManaColor[0].g
				b = self.ManaColor[0].b			
			else
				r = self.ManaColor[1].r
				g = self.ManaColor[1].g
				b = self.ManaColor[1].b			
			end
		elseif ( UnitCanAttack("player", unit) ) then
				r = self.ManaColor[3].r
				g = self.ManaColor[3].g
				b = self.ManaColor[3].b
		elseif ( UnitIsPVP(unit) ) then
			r = self.HealthColor.r
			g = self.HealthColor.g
			b = self.HealthColor.b			
		else
			r = self.ManaColor[0].r
			g = self.ManaColor[0].g
			b = self.ManaColor[0].b
		end
	elseif ( UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) ) or UnitIsDead(unit) then
		r = 0.5
		g = 0.5
		b = 0.5
	else
		local reaction = UnitReaction(unit, "player")
		if ( reaction ) then
			if reaction == 5 or reaction == 6 or reaction == 7 then
				r = self.HealthColor.r
				g = self.HealthColor.g
				b = self.HealthColor.b
			elseif reaction == 4 then
				r = self.ManaColor[3].r
				g = self.ManaColor[3].g
				b = self.ManaColor[3].b
			elseif reaction == 1 or reaction == 2 or reaction == 3 then
				r = self.ManaColor[1].r
				g = self.ManaColor[1].g
				b = self.ManaColor[1].b			
			else
				r = UnitReactionColor[reaction].r
				g = UnitReactionColor[reaction].g
				b = UnitReactionColor[reaction].b
			end
		end
	end
	return {r = r,g = g,b = b}
end	

function aUF:GiveHex(r,g,b)
	r=r*255
	g=g*255
	b=b*255
	return string.format("|cff%2x%2x%2x", r, g, b) or ""
end

function aUF:GetRaidColors(class)
	if self.RaidColors[class] then
		return self.RaidColors[class]
	else 
		return "|r"
	end
end

function aUF:TargetGetMobType(unit)
	local classification = UnitClassification(unit)
	if ( classification == "worldboss" ) then
		return "Boss "
	elseif ( classification == "rareelite"  ) then
		return "Rare-Elite "
	elseif ( classification == "elite"  ) then
		return "Elite "
	elseif ( classification == "rare"  ) then
		return "Rare "
	else
		return nil;
	end
end

function aUF:UnitDebuff(unit,id,filter)
	local aura, count, t = UnitDebuff(unit,id)
	local _, eClass = UnitClass("player")
	
	if filter == 1 then
		if ( self.CanDispel[eClass] and self.CanDispel[eClass][t] == true or ( eClass == "PRIEST" and aura == "Interface\\Icons\\Spell_Holy_AshesToAshes") ) then
			return aura, count or 0, t
		end
	else
		return aura, count or 0, t
	end
end

function aUF:FeedbackUpdate()
	local maxalpha = 0.6
	local found
	for objectName,v in self.feedback do
		found = true
		local unitOjbect = aUF.units[objectName]
		local elapsedTime = GetTime() - unitOjbect.feedbackStartTime
		if ( elapsedTime < COMBATFEEDBACK_FADEINTIME ) then
			local alpha = maxalpha*(elapsedTime / COMBATFEEDBACK_FADEINTIME)
			unitOjbect.HitIndicator:SetAlpha(alpha)
		elseif ( elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME) ) then
			unitOjbect.HitIndicator:SetAlpha(maxalpha)
		elseif ( elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME) ) then
			local alpha = maxalpha - maxalpha*((elapsedTime - COMBATFEEDBACK_HOLDTIME - COMBATFEEDBACK_FADEINTIME) / COMBATFEEDBACK_FADEOUTTIME)
			unitOjbect.HitIndicator:SetAlpha(alpha)
		else
			unitOjbect.HitIndicator:Hide()
			aUF.feedback[objectName] = nil
		end
	end
	if not found then 
		self:CancelScheduledEvent("agUF_CombatSchedule")
	end
end

-- Dewdrop stuff

function aUF:CreateMenu()
	self.dewdrop = AceLibrary("Dewdrop-2.0")

	local unitTable = {}
	unitTable.UnitHeader = {
		name = L"unitsettings",
		type = 'header',
		desc = "desc",
		order = 1,
	}	
	for order,unit in ipairs(self.wowClasses) do
		unitTable[unit] = aUF:CreateDewdrop(unit,(order + 1),true)
	end
	
	local agDewdropMenu = {
		type= 'group',
		args = {
			AddonHeader = {
				name = L"addonname",
				type = 'header',
				desc = "desc",
				order = 1,
			},		
			Units = {
				name = L"units",
				type = 'group',
				desc = L"UnitDesc",
				args = unitTable,
				order = 2,
			},			
			Borders = {
				name = L"borders",
				type = 'text',
				desc = L"BordersDesc",
				get = function()
					return self.db.profile.BorderStyle
				end,
				set = function(option)
					self.db.profile.BorderStyle = option
					self:CallUnitMethods("BorderBackground")
					self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
				end,
				validate = {"Classic", "Nurfed", "Hidden"},
				order = 3,
			},
			FrameColors = {
				type= 'group',
				name = L"framecolors",
				desc = L"framecolorsdesc",
				args = {
					partybg = {
						name = L"partybg",
						type = 'color',
						desc = L"partybgdesc",
						hasAlpha = true,
						get = function()
							return self.db.profile.PartyFrameColors.r, self.db.profile.PartyFrameColors.g, self.db.profile.PartyFrameColors.b, self.db.profile.PartyFrameColors.a
						end,
						set = function(r, g, b, a)
							self.db.profile.PartyFrameColors.r, self.db.profile.PartyFrameColors.g, self.db.profile.PartyFrameColors.b, self.db.profile.PartyFrameColors.a = r, g, b, a
							self:CallUnitMethods("BorderBackground")
							self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
						end,
						order = 1,
					},
					targetbg = {
						name = L"targetbg",
						type = 'color',
						desc = L"targetbgdesc",
						hasAlpha = true,
						get = function()
							return self.db.profile.TargetFrameColors.r, self.db.profile.TargetFrameColors.g, self.db.profile.TargetFrameColors.b, self.db.profile.TargetFrameColors.a
						end,
						set = function(r, g, b, a)
							self.db.profile.TargetFrameColors.r, self.db.profile.TargetFrameColors.g, self.db.profile.TargetFrameColors.b, self.db.profile.TargetFrameColors.a = r, g, b, a
							self:CallUnitMethods("BorderBackground")
							self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
						end,
						order = 2,
					},
					border = {
						name = L"bordercolor",
						type = 'color',
						desc = L"bordercolordesc",
						hasAlpha = true,
						get = function()
							return self.db.profile.FrameBorderColors.r, self.db.profile.FrameBorderColors.g, self.db.profile.FrameBorderColors.b, self.db.profile.FrameBorderColors.a
						end,
						set = function(r, g, b, a)
							self.db.profile.FrameBorderColors.r, self.db.profile.FrameBorderColors.g, self.db.profile.FrameBorderColors.b, self.db.profile.FrameBorderColors.a = r, g, b, a
							self:CallUnitMethods("BorderBackground")
							self:CallUnitMethods("BorderBackground",nil,nil,nil,"subgroups")
						end,
						order = 3,
					},
				},
				order = 4,
			},
			BarColors = {
				type= 'group',
				args = {
					Health = {
						name = L"health",
						type = 'color',
						desc = L"healthDesc",
						get = function()
							return self.db.profile.HealthColor.r, self.db.profile.HealthColor.g, self.db.profile.HealthColor.b
						end,
						set = function(r, g, b)
							self.db.profile.HealthColor.r, self.db.profile.HealthColor.g, self.db.profile.HealthColor.b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 1,
					},
					Mana = {
						name = L"mana",
						type = 'color',
						desc = L"manaDesc",
						get = function()
							return self.db.profile.ManaColor[0].r, self.db.profile.ManaColor[0].g, self.db.profile.ManaColor[0].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[0].r, self.db.profile.ManaColor[0].g, self.db.profile.ManaColor[0].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 2,
					},
					Rage = {
						name = L"rage",
						type = 'color',
						desc = L"rageDesc",
						get = function()
							return self.db.profile.ManaColor[1].r, self.db.profile.ManaColor[1].g, self.db.profile.ManaColor[1].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[1].r, self.db.profile.ManaColor[1].g, self.db.profile.ManaColor[1].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 3,
					},
					Energy = {
						name = L"energy",
						type = 'color',
						desc = L"energyDesc",
						get = function()
							return self.db.profile.ManaColor[3].r, self.db.profile.ManaColor[3].g, self.db.profile.ManaColor[3].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[3].r, self.db.profile.ManaColor[3].g, self.db.profile.ManaColor[3].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 4,
					},
					PetFocus = {
						name = L"petfocus",
						type = 'color',
						desc = L"petfocusDesc",
						get = function()
							return self.db.profile.ManaColor[2].r, self.db.profile.ManaColor[2].g, self.db.profile.ManaColor[2].b
						end,
						set = function(r, g, b)
							self.db.profile.ManaColor[2].r, self.db.profile.ManaColor[2].g, self.db.profile.ManaColor[2].b = r, g, b
							self:CallUnitMethods("StatusBarsColor")
						end,
						order = 5,
					},					
				},
				order = 5,
				name = L"barcolors",
				desc = L"barcolorsDesc",
			},
			BarStyle = {
				name = L"barstyle",
				type = 'text',
				desc = L"BarStyleDesc",
				get = function()
					return self.db.profile.BarStyle
				end,
				set = function(option)
					self.db.profile.BarStyle = option
					self:CallUnitMethods("BarTexture")					
				end,
				validate = {"Classic", "Default","Smooth", "Bars", "Bumps", "Button", "Cloud", "Cracked", "Dabs", "Diagonal", "Gloss", "Grid", "Hatched", "Perl", "Rain", "Skewed", "Smudge", "Water", "Wisps","Charcoal","BantoBar"},
				order = 6,
			},		
			ShowPvPIcon = {
				name = L"pvpicon",
				type = 'toggle',
				desc = L"ShowPVPIconDesc",
				get = function()
					return self.db.profile.ShowPvPIcon
				end,
				set = function(option)
					self.db.profile.ShowPvPIcon = option
					self:CallUnitMethods("UpdatePvP",true)					
				end,
				order = 7,				
			},		
			ShowGroupIcons = {
				name = L"groupicon",
				type = 'toggle',
				desc = L"ShowGroupIconsDesc",
				get = function()
					return self.db.profile.ShowGroupIcons
				end,
				set = function(option)
					self.db.profile.ShowGroupIcons = option
					self:CallUnitMethods("LabelsCheckLeader")					
				end,
				order = 8,				
			},
            HighlightSelected = {
				name = L"highlightselected",
				type = 'toggle',
				desc = L"HighlightSelectedDesc",
				get = function()
					return self.db.profile.HighlightSelected
				end,
				set = function(option)
					self.db.profile.HighlightSelected = option
				end,
				order = 9,				
			},			
			Locked = {
				name = L"lock",
				type = 'toggle',
				desc = L"LockedDesc",
				get = function()
					return self.db.profile.Locked
				end,
				set = function(option)
					self.db.profile.Locked = option
				end,
				order = 12,				
			},		
		}
	}
	self.dewdrop:InjectAceOptionsTable(self, agDewdropMenu)
	return agDewdropMenu
end

function aUF:InitMenu()
	if not self.menu then
		self.menu = aUF:CreateMenu()
	end
	
	local agSlashMenu = {
		type = "group",
		args = {
			config = {
				name = L('config'),
				desc = L('configdesc'),
				type = 'execute',
				func = function()
					self.dewdrop:Open(UIParent, 'children', function() self.dewdrop:FeedAceOptionsTable(self.menu) end,'cursorX', true, 'cursorY', true)
				end,
			},
			reset = {
				name = L('reset'),
				desc = L('resetdesc'),
				type = 'execute',
				func = function()
					self:Reset()
				end,
			}			
		}
	}
	
	self:RegisterChatCommand({ "/aguf", "/ag_unitframes" }, agSlashMenu )
end

function aUF:CreateDewdrop(type,order,mainmenu)
	local class = type
    local prettyname = L(class)

	local strings = {"Health","Mana","Name","Class"}
--	local strings = {"Health","Mana"}

	local stringArgs = {}

	for k,v in strings do
		local name = v
		local order = k
		local validate
		if v == "Health" or v == "Mana" then
			validate = {"Absolute", "Difference", "Percent", "Smart","Custom", "Hide"}
		else
			validate = {"Default","Custom", "Hide"}
		end
		stringArgs[v] = {
			name = name.." Text",
			type = 'group',
			desc = L"UnitDesc",
			order = order,
			args = {
				StatusTextStyle = {
					name = "Style",
					type = 'text',
					desc = L"StatusTextDesc",
					get = function()
						return self.db.profile[class][name.."Style"]
					end,
					set = function(option)
						self.db.profile[class][name.."Style"] = option
						
						self:SetStringFormats(class)
						self:CallUnitMethods("UpdateTextStrings",nil,class,"type")				
					end,
					validate = validate,
					order = 1,				
				},								
				HealthCustom = {
					name = "Custom",
					type = 'text',
					desc = L"StatusTextDesc",
					get = function()
						return self.db.profile[class][name.."Format"]
					end,
					set = function(option)
						self.db.profile[class][name.."Format"] = option
						
						self:SetStringFormats(class)				
						self:CallUnitMethods("UpdateTextStrings",nil,class,"type")				
					end,
					usage = "",
					order = 2,
				}
			}
		}
	end



	local table = {
		name = prettyname, 
		type = 'group',
		desc = prettyname.." Settings",
		order = order,
		args = {
			UnitHeader = {
				name = prettyname.." "..L"layoutsettings",
				type = 'header',
				desc = "desc",
				order = 1,
			},
			FrameStyle = {
				name = L"framestyle",
				type = 'text',
				desc = L"FrameStyleDesc",
				validate = {},
				get = function()
					return self.db.profile[class].FrameStyle
				end,
				set = function(option)
					self.db.profile[class].FrameStyle = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")				
					self:CallUnitMethods("UpdateName",true,class,"type")					
				end,
				order = 2,
			},

			Width = {
				name = L"widthadjust",
				type = 'range',
				desc = L"widthadjustDesc",
				min = 50,
				max = 400,
				step = 1,
				get = function()
					return self.db.profile[class].Width
				end,
				set = function(option)
					self.db.profile[class].Width = option
					self:CallUnitMethods("SetWidth",nil,class,"type")
				end,
				order = 3,
			},
			
			StatusTextStyle = {
				name = "Status Text",
				type = 'group',
				desc = L"UnitDesc",
				order = 5,
				args = stringArgs,
			},
			Scale = {
				name = L"scale",
				type = 'range',
				desc = L"ScaleDesc",
				min = 0.5,
				max = 2,
				step = 0.01,
				isPercent = true,
				get = function()
					return self.db.profile[class].Scale
				end,
				set = function(option)
					self.db.profile[class].Scale = option
					self:CallUnitMethods("LoadScale",nil,class,"type")
					self:CallUnitMethods("LoadPosition",nil,class,"type")					
				end,
				order = 7,
			},
			ClassColorBars = {
				name = L"classcolorbar",
				type = 'toggle',
				desc = L"ClassColorBarsDesc",
				get = function()
					return self.db.profile[class].ClassColorBars
				end,
				set = function(option)
					self.db.profile[class].ClassColorBars = option
					self:CallUnitMethods("StatusBarsColor",nil,class,"type")				
				end,
				order = 20,				
			},
			RaidColorName = {
				name = L"raidcolorname",
				type = 'toggle',
				desc = L"RaidColorNameDesc",
				get = function()
					return self.db.profile[class].RaidColorName
				end,
				set = function(option)
					self.db.profile[class].RaidColorName = option
					self:CallUnitMethods("UpdateTextStrings",nil,class,"type")				
				end,
				order = 21,				
			},
			ShowCombat = {
				name = L"showcombat",
				type = 'toggle',
				desc = L"ShowCombatDesc",
				get = function()
					return self.db.profile[class].ShowCombat
				end,
				set = function(option)
					self.db.profile[class].ShowCombat = option
				end,
				order = 23,				
			},				
			ShowInCombatIcon = {
			        name = L"showincombat",
			        type =  'toggle',
			        desc = L"ShowInCombatDesc",
			        get = function ()
				        return self.db.profile[class].ShowInCombatIcon
				end,
				set = function(option)
					self.db.profile[class].ShowInCombatIcon = option
				end,
			        order = 24,
			},
			ShowRaidTargetIcon = {
			        name = L"showraidicon",
			        type =  'toggle',
			        desc = L"ShowRaidIconDesc",
			        get = function ()
				        return self.db.profile[class].ShowRaidTargetIcon
				end,
				set = function(option)
					self.db.profile[class].ShowRaidTargetIcon = option
					self:CallUnitMethods("UpdateRaidTargetIcon",true,class,"type")	
				end,
			        order = 25,
			},
			LongStatusbars = {
				name = L"longbars",
				type = 'toggle',
				desc = L"LongBarsDesc",
				get = function()
					return self.db.profile[class].LongStatusbars
				end,
				set = function(option)
					self.db.profile[class].LongStatusbars = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")
				end,
				order = 26,
			},
			HideMana = {
				name = L"hidemana",
				type = 'toggle',
				desc = L"HideManaDesc",
				get = function()
					return self.db.profile[class].HideMana
				end,
				set = function(option)
					self.db.profile[class].HideMana = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")
					self:CallUnitMethods("UpdateName",true,class,"type")					
				end,
				order = 27,
			},
			HideFrame = {
				name = L"hideframe",
				type = 'toggle',
				desc = L"HideFrameDesc",
				get = function()
					return self.db.profile[class].HideFrame
				end,
				set = function(option)
					self.db.profile[class].HideFrame = option
					self:RAID_ROSTER_UPDATE()
					self:CallUnitMethods("UpdateAll",nil,class,"type")				
				end,
				order = 29,
			},
			Spacing1 = {
				name = " ",
				type = 'header',
				order = 35,
			},			
			AuraHeader = {
				name = L"aurasettings",
				type = 'header',
				order = 39,
			},			
			AuraStyle = {
				name = L"aurastyle",
				type = 'text',
				desc = L"AuraStyleDesc",
				get = function()
					return self.db.profile[class].AuraStyle
				end,
				set = function(option)
					self.db.profile[class].AuraStyle = option
					self:CallUnitMethods("UpdateAuras",true,class,"type")				
					self:CallUnitMethods("AuraPosition",true,class,"type")					
				end,
				validate = {OneLine = L"oneline", TwoLines = L"twolines", Hide = L"hide"},
				order = 40,				
			},
			AuraPos = {
				name = L"aurapos",
				type = 'text',
				desc = L"AuraPosDesc",
				get = function()
					return self.db.profile[class].AuraPos
				end,
				set = function(option)
					self.db.profile[class].AuraPos = option
					self:CallUnitMethods("UpdateAuras",true,class,"type")				
					self:CallUnitMethods("AuraPosition",true,class,"type")
				end,
				validate = {"Right", "Left", "Above", "Below"},
				order = 41,				
			},			
			DebuffColoring = {
				name = L"debuffcoloring",
				type = 'toggle',
				desc = L"DebuffColoringDesc",
				get = function()
					return self.db.profile[class].AuraDebuffC
				end,
				set = function(option)
					self.db.profile[class].AuraDebuffC = option
					self:CallUnitMethods("UpdateAuras",true,class,"type")								
				end,
				order = 42,
			},				
			AuraFilter = {
				name = L"aurafilter",
				type = 'toggle',
				desc = L"AuraFilterDesc",
				get = function()
					if self.db.profile[class].AuraFilter == 1 then
						return true
					else
						return false
					end
				end,
				set = function(option)
					if option == true then
						self.db.profile[class].AuraFilter = 1
					else
						self.db.profile[class].AuraFilter = 0
					end
					self:CallUnitMethods("UpdateAuras",true,class,"type")				
				end,
				order = 43,
			}	
		}
	}
	-- Inject themes from the theme table
	local themetable = {}
	for k, v in self.Layouts do
		tinsert(themetable,k)
	end
	table.args.FrameStyle.validate = themetable
	
	-- PLAYER/PET
	--[[
	if class == "player" then
		local ShowRestingIcon = {
				name = L"showresting",
				type = 'toggle',
				desc = L"ShowRestingDesc",
				get = function()
					return self.db.profile[class].ShowRestingIcon
				end,
				set = function(option)
					self.db.profile[class].ShowRestingIcon = option
					self:CallUnitMethods("UpdateResting",nil,class,"type")	
				end,
				order = 26,
			}
		table.args.ShowRestingIcon = ShowRestingIcon
	end
	]]
	if class == "player" or class == "pet" then
		local ShowXP = {
				name = L"showxp",
				type = 'toggle',
				desc = L"ShowXPDesc",
				get = function()
					return self.db.profile[class].ShowXP
				end,
				set = function(option)
					self.db.profile[class].ShowXP = option
					self:CallUnitMethods("ApplyTheme",nil,class,"type")	
				end,
				order = 26,
			}
		table.args.ShowXP = ShowXP
	end

	if class == "pet" then
		local PetGrouping = {
				name = L"petgrouping",
				type = 'text',
                desc = L"PetGroupingDesc",
				get = function()
					return self.db.profile.PetGrouping
				end,
				set = function(option)
					self.db.profile.PetGrouping = option
					self:CallUnitMethods("UpdateAll")				
				end,
				validate = {["withplayer"] = L"withplayer", ["nogroup"] = L"nogroup"},				
				order = 6,
			}	
		table.args.PetGrouping = PetGrouping
	end
	
	if class == "pet" or class == "partypet" or class == "raidpet" then
		table.args.RaidColorName = nil
		table.args.ClassColorBars = nil
	end
	
	-- TARGET
	if string.find(class,"target") then	
		local TargetShowHostile = {
				name = L"targetshowhostile",
				type = 'toggle',
				desc = L"TargetHostileDesc",
				get = function()
					return self.db.profile.TargetShowHostile
				end,
				set = function(option)
					self.db.profile.TargetShowHostile = option
					self:CallUnitMethods("StatusBarsColor",nil,class,"type")
				end,
				order = 22,				
			}
		table.args.TargetShowHostile = TargetShowHostile
	end	
		
	-- PARTY
	if class == "party" then
		local RaidHideParty = {
				name = L"raidhideparty",
				type = 'toggle',
				desc = L"RaidHidePartyDesc",
				get = function()
					return self.db.profile.RaidHideParty
				end,
				set = function(option)
					self.db.profile.RaidHideParty = option
					self:CallUnitMethods("UpdateAll",nil,"party","type")				
					self:CallUnitMethods("UpdateAll",nil,"partypet","type")				
				end,
				order = 28,
			}
		table.args.RaidHideParty = RaidHideParty
		
		local PartyGrouping = {
				name = L"partygrouping",
				type = 'text',
                desc = L"PartyGroupingDesc",
				get = function()
					return self.db.profile.PartyGrouping
				end,
				set = function(option)
					self.db.profile.PartyGrouping = option
					self:PARTY_MEMBERS_CHANGED()
					self:CallUnitMethods("UpdateAll")				
				end,
				validate = {["withplayer"] = L"withplayer", ["withoutplayer"] = L"withoutplayer", ["nogroup"] = L"nogroup"},				
				order = 6,
			}	
		table.args.PartyGrouping = PartyGrouping
	end
	
	-- RAID
	if class == "raid" then
		local RaidGrouping = {
				name = L"raidgrouping",
				type = 'text',
                desc = L"RaidGroupingDesc",
				get = function()
					return self.db.profile.RaidGrouping
				end,
				set = function(option)
					self.db.profile.RaidGrouping = option
					self:CallUnitMethods("UpdateAll")				
				end,
				validate = {["bysubgroup"] = L"bysubgroup", ["byclass"] = L"byclass", ["byrole"] = L"byrole", ["nogroup"] = L"nogroup", ["onebiggroup"] = L"onebiggroup"},				
				order = 6,
			}	
		table.args.RaidGrouping = RaidGrouping
	end
	
	if not mainmenu then
		table.args.UnitHeader.name = L(class).." "..L"frame"
		local EndSpacing = {
			name = " ",
			type = 'header',
			order = 51,
		}
		table.args.EndSpacing = EndSpacing
	end
	
	return table
end

function aUF:LoadStringFormats()
	for order,unit in ipairs(self.wowClasses) do
		self:SetStringFormats(unit)
	end
end

function aUF:SetStringFormats(type)
	local db = self.db.profile[type]
	local strings = {"Health","Mana","Name","Class"}
	if not aUF.HelperFunctions[type] then
		aUF.HelperFunctions[type] = {}
	end
		
	for k,v in strings do
		local format
		if db[v.."Style"] == "Custom" then
				format = db[v.."Format"]
		else
			format = self.formats[v][db[v.."Style"]]
		end
		aUF.HelperFunctions[type][v.."Text"] = self:Parse(format)
	end
end


-- Clads code-- Clads code-- Clads code-- Clads code
-- Clads code-- Clads code-- Clads code-- Clads code

-- Code Begins here
local work = {}
local strgsub, strsub, strgfind, strformat, strfind = string.gsub, string.sub, string.gfind, string.format, string.find

function aUF:Parse(format)
   if not format then
      return nil
   end

   local formatArgs, formatString = {}
   
   for s,data,e in strgfind(format, "()(%b[])()") do
      local tag = strsub(data, 2, -2)
      local func = aUF:GetTagFunction(tag)
      if func then
         table.insert(formatArgs, func)
      else
         error(strformat("\"%s\" is not a valid format tag.", data))
      end
    end
   
    formatString = strgsub(format, "%%", "%%%%")
    formatString = strgsub(formatString, "%b[]", "%%s")

   -- Lets avoid unpacking extra results
   local num = table.getn(formatArgs)
   local tmp = work[num]
   if not tmp then
      tmp = {}
      work[num] = tmp
   end
   
   if num == 0 then
        return function(unit, fontstring)
            fontstring:SetText(formatString)
        end
    else
       return function(unit, fontstring)
          for i,func in ipairs(formatArgs) do 
             work[i] = func(unit)
          end
          fontstring:SetText(strformat(formatString, unpack(work)))
       end
    end
end

local helpers = {}

function aUF:GetTagFunction(tag)
   -- Check if this is just a unit tag
   if aUF.UnitInformation[tag] then return aUF.UnitInformation[tag] end
   
   local s,e,tag,args = strfind(tag, "^(%a+)%s+(.*)$")
   if not tag then
      -- Not a pattern we can recognize
      return nil
   end
   
   -- Bind the unit function to a local for closure purposes
   local func = aUF.UnitInformation[tag]
   if not func then
      -- Not a tag we support
      return nil
   end
   local _,_,width = strfind(args, "^(%d+)$")
   if width then
      local id = strformat("%s-%d", tag, width)
      local hFunc = helpers[id]
      if not hFunc then
         hFunc = function(unit)
            return strsub(func(unit), 1, width)
         end
         
         helpers[id] = hFunc
      end
      return hFunc
   end
   
   local _,_,oc,ec = strfind(args, "^(.)(.)$")
   if oc then
      local id = strformat("%s-%s%s", tag, oc, ec)
      local hFunc = helpers[id]
      if not hFunc then
         hFunc = function(unit)
            local t = func(unit)
            if t ~= "" then return
               strformat("%s%s%s",oc,t,ec)
            else
               return t
            end
         end
         
         helpers[id] = hFunc
      end
      return hFunc
   end
end

function aUF:Tag_agmana(unit,flag)
	local currValue,maxValue = UnitMana(unit),UnitManaMax(unit)
	local perc = currValue/maxValue * 100	
	local manaDiff = maxValue - currValue	
	local text = ""
	
	if ( not UnitExists(unit) or UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) ) then
		return ""
	end
	if currValue > maxValue then
		maxValue = currValue
	end
	if currValue > 9999 then
		currValue = string.format("%.1fk", currValue / 1000)
	end
	if maxValue > 9999 then
		maxValue = string.format("%.1fk", maxValue / 1000)
	end
	
	if flag == 1 then
		return string.format("%.0f%%", perc)
	elseif flag == 2 then
		if manaDiff > 9999 then
			manaDiff = string.format("%.1fk", manaDiff / 1000)
		end	
		return (currValue.."|cffff7f7f-"..manaDiff.."|r")
	elseif flag == 3 then
		return currValue	
	else
		return (currValue.."/"..maxValue)
	end
	
	return text
end
	
function aUF:Tag_aghp(unit,flag)
	local currValue,maxValue = UnitHealth(unit),UnitHealthMax(unit)
	local perc = currValue/maxValue * 100
	local text = ""
	local MHfound = false
	if ( UnitIsDead(unit) ) then
		return L("dead")
	elseif ( UnitIsGhost(unit) ) then
		return L("ghost")
	elseif ( not UnitIsConnected(unit) or maxValue == 1 ) then
		return L("disc")
	end	
	if (MobHealth3 and not UnitIsFriend("player", unit) ) then
		currValue,maxValue,MHfound = MobHealth3:GetUnitHealth(unit, currValue,maxValue)
	end
	if currValue > maxValue then
		maxValue = currValue
	end	
	local hpDiff = maxValue - currValue
	if currValue > 9999 then
		currValue = string.format("%.1fk", currValue / 1000)
	end
	if maxValue > 9999 then
		maxValue = string.format("%.1fk", maxValue / 1000)
	end	
	
	if not flag and MHfound and not UnitIsFriend("player", unit) then
		return currValue .." (".. perc .."%)"
	end
	
	if not (flag == 1) and (MHfound or unit == "pet" or unit == "player" or UnitInParty(unit) or UnitInRaid(unit)) then
		if flag == 2 then
			if hpDiff > 0 then
				if hpDiff > 9999 then
					hpDiff = string.format("%.1fk", hpDiff / 1000)
				end			
				return (currValue.."|cffff7f7f-"..hpDiff.."|r")
			else
				return currValue
			end
		elseif flag == 3 and hpDiff > 0 then
			if hpDiff > 9999 then
				hpDiff = string.format("%.1fk", hpDiff / 1000)
			end
			return "|cffff7f7f-"..hpDiff.."|r"
		elseif flag == 3 then
			return ""
		else
			return (currValue.."/"..maxValue)
		end
	else
		return string.format("%.0f%%", perc)
	end
	return text
end






-- Blizzard hide and show

function aUF:UpdateBlizzVisibility()
	if aUF.db.profile.BlizFramesVisibility.HidePlayerFrame == true then
		aUF:HideBlizzPlayer()
	else
		aUF:ShowBlizzPlayer()
	end
	if aUF.db.profile.BlizFramesVisibility.HidePartyFrame == true then
		aUF:HideBlizzParty()
	else
		aUF:ShowBlizzParty()
	end
	if aUF.db.profile.BlizFramesVisibility.HideTargetFrame == true then
		aUF:HideBlizzTarget()
	else
		aUF:ShowBlizzTarget()
	end	
end

function aUF:HideBlizzPlayer()
	PlayerFrame:UnregisterEvent("UNIT_LEVEL")
	PlayerFrame:UnregisterEvent("UNIT_COMBAT")
	PlayerFrame:UnregisterEvent("UNIT_SPELLMISS")
	PlayerFrame:UnregisterEvent("UNIT_PVP_UPDATE")
	PlayerFrame:UnregisterEvent("UNIT_MAXMANA")
	PlayerFrame:UnregisterEvent("PLAYER_ENTER_COMBAT")
	PlayerFrame:UnregisterEvent("PLAYER_LEAVE_COMBAT")
	PlayerFrame:UnregisterEvent("PLAYER_UPDATE_RESTING")
	PlayerFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	PlayerFrame:UnregisterEvent("PARTY_LEADER_CHANGED")
	PlayerFrame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
	PlayerFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	PlayerFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
	PlayerFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
	PlayerFrameHealthBar:UnregisterEvent("UNIT_HEALTH")
	PlayerFrameHealthBar:UnregisterEvent("UNIT_MAXHEALTH")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MANA")
	PlayerFrameManaBar:UnregisterEvent("UNIT_RAGE")
	PlayerFrameManaBar:UnregisterEvent("UNIT_FOCUS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_ENERGY")
	PlayerFrameManaBar:UnregisterEvent("UNIT_HAPPINESS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXMANA")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXRAGE")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXFOCUS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXENERGY")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXHAPPINESS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:UnregisterEvent("UNIT_NAME_UPDATE")
	PlayerFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
	PlayerFrame:UnregisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:Hide()
end

function aUF:ShowBlizzPlayer()
	PlayerFrame:RegisterEvent("UNIT_LEVEL")
	PlayerFrame:RegisterEvent("UNIT_COMBAT")
	PlayerFrame:RegisterEvent("UNIT_SPELLMISS")
	PlayerFrame:RegisterEvent("UNIT_PVP_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_MAXMANA")
	PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
	PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
	PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
	PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED")
	PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
	PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	PlayerFrameHealthBar:RegisterEvent("UNIT_HEALTH")
	PlayerFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
	PlayerFrameManaBar:RegisterEvent("UNIT_MANA")
	PlayerFrameManaBar:RegisterEvent("UNIT_RAGE")
	PlayerFrameManaBar:RegisterEvent("UNIT_FOCUS")
	PlayerFrameManaBar:RegisterEvent("UNIT_ENERGY")
	PlayerFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXMANA")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
	PlayerFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:RegisterEvent("UNIT_NAME_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:Show()
end

function aUF:HideBlizzParty()
	self:Hook("RaidOptionsFrame_UpdatePartyFrames", function() end)
	for i=1,4 do
		local frame = getglobal("PartyMemberFrame"..i)
		frame:UnregisterAllEvents()
		frame:Hide()
	end
end

function aUF:ShowBlizzParty()
	self:Unhook("RaidOptionsFrame_UpdatePartyFrames")
	for i=1,4 do
		local frame = getglobal("PartyMemberFrame"..i)
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		frame:RegisterEvent("PARTY_LEADER_CHANGED")
		frame:RegisterEvent("PARTY_MEMBER_ENABLE")
		frame:RegisterEvent("PARTY_MEMBER_DISABLE")
		frame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
		frame:RegisterEvent("UNIT_PVP_UPDATE")
		frame:RegisterEvent("UNIT_AURA")
		frame:RegisterEvent("UNIT_PET")
		frame:RegisterEvent("VARIABLES_LOADED")
		frame:RegisterEvent("UNIT_NAME_UPDATE")
		frame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
		frame:RegisterEvent("UNIT_DISPLAYPOWER")

		UnitFrame_OnEvent("PARTY_MEMBERS_CHANGED")

		PartyMemberFrame_UpdateMember()
	end
end

function aUF:HideBlizzTarget()
	TargetFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
	TargetFrame:UnregisterEvent("UNIT_HEALTH")
	TargetFrame:UnregisterEvent("UNIT_LEVEL")
	TargetFrame:UnregisterEvent("UNIT_FACTION")
	TargetFrame:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED")
	TargetFrame:UnregisterEvent("UNIT_AURA")
	TargetFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED")
	TargetFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	TargetFrame:Hide()
	
	ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
	ComboFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
end

function aUF:ShowBlizzTarget()
	TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	TargetFrame:RegisterEvent("UNIT_HEALTH")
	TargetFrame:RegisterEvent("UNIT_LEVEL")
	TargetFrame:RegisterEvent("UNIT_FACTION")
	TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
	TargetFrame:RegisterEvent("UNIT_AURA")
	TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
	TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	TargetFrame:Show()
	
	ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
end


function aUF:tonum(val, base)
	return tonumber((val or 0), base) or 0
end

function aUF:round(num)
	return floor(aUF:tonum(num)+.5)
end

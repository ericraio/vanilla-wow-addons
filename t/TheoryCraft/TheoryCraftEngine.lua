local _, class = UnitClass("player")
local returndata = {}
local summeddata = {}

local function findpattern(text, pattern, start)
	if (text and pattern and (string.find(text, pattern, start))) then
		return string.sub(text, string.find(text, pattern, start))
	else
		return ""
	end
end

local function round(arg1, decplaces)
	if (decplaces == nil) then decplaces = 0 end
	if arg1 == nil then arg1 = 0 end
	return string.format ("%."..decplaces.."f", arg1)
end

local function TheoryCraft_AddData(arg1, data, summeddata)
	if data == nil then return end
	summeddata["tmpincrease"] = summeddata["tmpincrease"] + (data[arg1.."modifier"] or 0)
	summeddata["tmpincreaseupfront"] = summeddata["tmpincreaseupfront"] + (data[arg1.."UpFrontmodifier"] or 0)
	if summeddata["baseincrease"] ~= 0 then
		summeddata["baseincrease"] = summeddata["baseincrease"] * ((data[arg1.."baseincrease"] or 0)+1)
	else
		summeddata["baseincrease"] = summeddata["baseincrease"] + (data[arg1.."baseincrease"] or 0)
	end
	if summeddata["baseincreaseupfront"] ~= 0 then
		summeddata["baseincreaseupfront"] = summeddata["baseincreaseupfront"] * ((data[arg1.."UpFrontbaseincrease"] or 0)+1)
	else
		summeddata["baseincreaseupfront"] = summeddata["baseincreaseupfront"] + (data[arg1.."UpFrontbaseincrease"] or 0)
	end
	summeddata["talentmod"] = summeddata["talentmod"] + (data[arg1.."talentmod"] or 0)
	summeddata["talentmodupfront"] = summeddata["talentmodupfront"] + (data[arg1.."UpFronttalentmod"] or 0)
	if (summeddata["doshatter"] ~= 0) then
		summeddata["critchance"] = summeddata["critchance"] + (data[arg1.."shatter"] or 0)
	end
	summeddata["illum"] = summeddata["illum"] + (data[arg1.."illum"] or 0)
	summeddata["plusdam"] = summeddata["plusdam"] + (data[arg1] or 0)
	summeddata["manacostmod"] = summeddata["manacostmod"] + (data[arg1.."manacost"] or 0)
	summeddata["critchance"] = summeddata["critchance"] + (data[arg1.."critchance"] or 0)
	summeddata["critbonus"] = summeddata["critbonus"] + (data[arg1.."critbonus"] or 0)
	summeddata["ignitemodifier"] = summeddata["ignitemodifier"] + (data[arg1.."ignitemodifier"] or 0)
	summeddata["sepignite"] = summeddata["sepignite"] + (data[arg1.."sepignite"] or 0)
	summeddata["hitbonus"] = summeddata["hitbonus"] - (data[arg1.."hitchance"] or 0)
	summeddata["casttime"] = summeddata["casttime"] + (data[arg1.."casttime"] or 0)
	summeddata["regencasttime"] = summeddata["regencasttime"] + (data[arg1.."casttime"] or 0)
	summeddata["penetration"] = summeddata["penetration"] + (data[arg1.."penetration"] or 0)
	summeddata["grace"] = summeddata["grace"] + (data[arg1.."grace"] or 0)
	summeddata["threat"] = summeddata["threat"] + (data[arg1.."threat"] or 0)
	if data[arg1.."Netherwind"] == 1 then
		summeddata["netherwind"] = 1
	end
end

local function TheoryCraft_DoSchool(arg1, summeddata)
	if TheoryCraft_Data.Testing then
		TheoryCraft_AddData(arg1, TheoryCraft_Data.TalentsTest, summeddata)
	else
		TheoryCraft_AddData(arg1, TheoryCraft_Data.Talents, summeddata)
	end
	TheoryCraft_AddData(arg1, TheoryCraft_Data.BaseData, summeddata)
	TheoryCraft_AddData(arg1, TheoryCraft_Data.Stats, summeddata)
	TheoryCraft_AddData(arg1, TheoryCraft_Data.PlayerBuffs, summeddata)
	TheoryCraft_AddData(arg1, TheoryCraft_Data.TargetBuffs, summeddata)
	TheoryCraft_AddData(arg1, TheoryCraft_Data.EquipEffects, summeddata)
	TheoryCraft_AddData(arg1, TheoryCraft_Data.Target, summeddata)
end

local function SummateData(name, schools)
	TheoryCraft_DeleteTable(summeddata)
	summeddata["doshatter"] = (TheoryCraft_Data.TargetBuffs["doshatter"] or 0)
	summeddata["tmpincrease"] = 0
	summeddata["tmpincreaseupfront"] = 0
	summeddata["baseincrease"] = 0
	summeddata["baseincreaseupfront"] = 0
	summeddata["talentmod"] = 0
	summeddata["talentmodupfront"] = 0
	summeddata["critchance"] = (TheoryCraft_Data.Stats["critchance"] or 0)
	summeddata["illum"] = 0
	summeddata["plusdam"] = 0
	summeddata["manacostmod"] = 1
	summeddata["critbonus"] = 0
	summeddata["ignitemodifier"] = 0
	summeddata["sepignite"] = 0
	summeddata["hitbonus"] = 0
	summeddata["casttime"] = 0
	summeddata["regencasttime"] = 0
	summeddata["penetration"] = 0
	summeddata["grace"] = 0
	summeddata["netherwind"] = 0
	summeddata["threat"] = 0
	for k, v in pairs (schools) do
		TheoryCraft_DoSchool(v, summeddata)
	end
	TheoryCraft_DoSchool(name, summeddata)
end

local function getcooldown(frame)
	index = 1
	local rtext = getglobal(frame:GetName().."TextRight"..index):GetText()
	local cooldown = 1.5
	while (rtext) do
		if (getglobal(frame:GetName().."TextRight"..index):IsVisible()) then
			if (strfind(rtext, "%d+.%d+"..TheoryCraft_Locale.Cooldown)) then
				cooldown = findpattern(rtext, "%d+.%d+");
			elseif (strfind(rtext, "%d+"..TheoryCraft_Locale.Cooldown)) then
				cooldown = findpattern(rtext, "%d+");
			end
		end
		index = index + 1;
		rtext = getglobal(frame:GetName().."TextRight"..index):GetText()
	end
	return cooldown
end

local function getlifetap(returndata)
	local i2 = 1
	local spellname = 1
	local spellrank = 1
	local quit = 0
	local found = 0
	while (spellname) do
		spellname, spellrank = GetSpellName(i2,BOOKTYPE_SPELL)
		spellrank = tonumber(findpattern(spellrank, "%d+"))
		if (spellname == TheoryCraft_Locale.lifetap) then
			found = 1
		elseif (found == 1) then
			TCTooltip:SetOwner(UIParent,"ANCHOR_NONE")
			TCTooltip:SetSpell(i2-1,BOOKTYPE_SPELL)
			if (TCTooltip:NumLines() > 0) then
				local description = getglobal("TCTooltipTextLeft"..TCTooltip:NumLines()):GetText()
				returndata["lifetapHealth"] = findpattern(description, "%d+ health")
				returndata["lifetapMana"] = findpattern(description, "%d+ mana")
				if returndata["lifetapHealth"] then
					returndata["lifetapHealth"] = tonumber(findpattern(returndata["lifetapHealth"], "%d+"))
				end
				if returndata["lifetapMana"] then
					returndata["lifetapMana"] = tonumber(findpattern(returndata["lifetapMana"], "%d+"))
				end
			end
			return
		end
		i2 = i2 + 1
	end
end

function TheoryCraft_GetStat(statname)
	if TheoryCraft_Data.testing then
		return 	(TheoryCraft_Data.BaseData[statname] or 0)+
			(TheoryCraft_Data.TalentsTest[statname] or 0)+
			(TheoryCraft_Data.Stats[statname] or 0)+
			(TheoryCraft_Data.PlayerBuffs[statname] or 0)+
			(TheoryCraft_Data.TargetBuffs[statname] or 0)+
			(TheoryCraft_Data.EquipEffects[statname] or 0)+
			(TheoryCraft_Data.Target[statname] or 0)
	else
		return 	(TheoryCraft_Data.BaseData[statname] or 0)+
			(TheoryCraft_Data.Talents[statname] or 0)+
			(TheoryCraft_Data.Stats[statname] or 0)+
			(TheoryCraft_Data.PlayerBuffs[statname] or 0)+
			(TheoryCraft_Data.TargetBuffs[statname] or 0)+
			(TheoryCraft_Data.EquipEffects[statname] or 0)+
			(TheoryCraft_Data.Target[statname] or 0)
	end
end

local function agipercrit()
	if TheoryCraft_agipercrit then
		return TheoryCraft_agipercrit
	else
		return TheoryCraft_CritChance[class][1]
	end
end

function TheoryCraft_intpercrit()
	local critdivider
	local agipercrit = agipercrit()
	if agipercrit == TheoryCraft_CritChance[class][1] then
		critdivider = UnitLevel("player")/60*TheoryCraft_CritChance[class][2]
		if (critdivider < 5) then
			critdivider = 5
		end
	else
		critdivider = agipercrit/TheoryCraft_CritChance[class][1]*TheoryCraft_CritChance[class][2]
	end
	return critdivider
end

--- Returns the cast time from the spell tooltip ---

local function getcasttime(frame)
	index = 1;
	local ltext = getglobal(frame:GetName().."TextLeft"..index):GetText()
	local castTime = 0
	while (ltext) do
   		ltext = string.gsub(ltext, ",", ".")
		if (strfind(ltext, "%d+.%d+"..TheoryCraft_Locale.SecCast)) then
			castTime = findpattern(findpattern(ltext, "%d+.%d+"..TheoryCraft_Locale.SecCast), "%d+.%d+")
		elseif (strfind(ltext, "%d+"..TheoryCraft_Locale.SecCast)) then
			castTime = findpattern(findpattern(ltext, "%d+"..TheoryCraft_Locale.SecCast), "%d+")
		end
		index = index + 1
		ltext = getglobal(frame:GetName().."TextLeft"..index):GetText()
	end
	castTime = tonumber(castTime)
	return castTime
end

--- Returns the dot duration from the spell tooltip ---

local function TheoryCraft_getDotDuration(description)
	local i = 1
	local _, found
	while TheoryCraft_DotDurations[i] do
		if (strfind(description, TheoryCraft_DotDurations[i].text)) then
			if TheoryCraft_DotDurations[i].amount == "n" then
				_, _, found = strfind(description, TheoryCraft_DotDurations[i].text)
				return found
			else
				return TheoryCraft_DotDurations[i].amount
			end
		end
		i = i + 1
	end
	return 1
end

local function getmanacost(frame)
	index = 1
	local ltext = getglobal(frame:GetName().."TextLeft"..index):GetText()
	local manaCost = 0
	while (ltext) do
		if (strfind(ltext, TheoryCraft_Locale.Mana)) then
			manaCost = findpattern(ltext, "%d+")
		end
		index = index + 1;
		ltext = getglobal(frame:GetName().."TextLeft"..index):GetText()
	end
	manaCost = tonumber(manaCost)
	if manaCost then
		return manaCost
	else
		return 0
	end
end

local function TheoryCraft_GetRangedSpeed()
	TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
	TheoryCraftTooltip:SetInventoryItem ("player", GetInventorySlotInfo("RangedSlot"))
	local index = 1
	ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..index)
	rtext = getglobal(TheoryCraftTooltip:GetName().."TextRight"..index)
	if ltext then
		ltext = ltext:GetText()
	end
	if rtext then
		if not (getglobal(TheoryCraftTooltip:GetName().."TextRight"..index):IsVisible()) then
			rtext = nil
		else
			rtext = rtext:GetText()
		end
	end
	while (ltext ~= nil) do
		if (rtext) then
			for k, v in pairs(TheoryCraft_EquipEveryRight) do
				if (v.slot == nil) or (v.slot == "Ranged") then
					_, start, found = strfind(rtext, v.text)
					if found then
						if v.amount then
							TheoryCraftTooltip:ClearLines()
							return v.amount
						else
							TheoryCraftTooltip:ClearLines()
							return found
						end
					end
				end
			end
		end
		index = index + 1;
		ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..index)
		rtext = getglobal(TheoryCraftTooltip:GetName().."TextRight"..index)
		if ltext then
			ltext = ltext:GetText()
		end
		if rtext then
			if not (getglobal(TheoryCraftTooltip:GetName().."TextRight"..index):IsVisible()) then
				rtext = nil
			else
				rtext = rtext:GetText()
			end
		end
	end
	TheoryCraftTooltip:ClearLines()
	return 2.8
end

local function GetCritChance(critreport)
	local critChance, iCritInfo, critNum
	local remove = 0
	local id = 1
	local attackSpell = GetSpellName(id,BOOKTYPE_SPELL)
	if (attackSpell ~= TheoryCraft_Locale.Attack) then
		name, texture, offset, numSpells = GetSpellTabInfo(1)
		for i=1, numSpells do
			if (GetSpellName(i,BOOKTYPE_SPELL) == TheoryCraft_Locale.Attack) then
				id = i
			end
		end
	end
	if GetSpellName(id,BOOKTYPE_SPELL) ~= TheoryCraft_Locale.Attack then
		return 0
	end
	TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
	TheoryCraftTooltip:SetSpell(id, BOOKTYPE_SPELL)
	local spellName = TheoryCraftTooltipTextLeft2:GetText()
	if not spellName then return 0 end
	iCritInfo = string.find(spellName, "%s")
	critNum = string.sub(spellName,0,(iCritInfo -2))
	critChance = string.gsub(critNum, ",", ".")
	critChance = tonumber(critChance)
	if critreport == nil then critreport = 0 end
	if (critChance) and (critChance ~= critreport) then
		local doweaponskill = true
		if class == "DRUID" then
 			local _, _, active = GetShapeshiftFormInfo(1)
			if active then doweaponskill = nil end
 			local _, _, active = GetShapeshiftFormInfo(3)
			if active then doweaponskill = nil end
		end
		if doweaponskill then
			TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
			TheoryCraftTooltip:SetInventoryItem ("player", GetInventorySlotInfo("MainHandSlot"))
			local i, i2 = 1
			local ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..i):GetText()
			local rtext = getglobal(TheoryCraftTooltip:GetName().."TextRight"..i):GetText()
			local skill = TheoryCraft_WeaponSkillOther
			local english = "Unarmed"
			while ltext do
				ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..i):GetText()
				rtext = getglobal(TheoryCraftTooltip:GetName().."TextRight"..i):GetText()
				if (rtext) and (getglobal(TheoryCraftTooltip:GetName().."TextRight"..i):IsVisible()) then
					i2 = 1
					while TheoryCraft_WeaponSkills[i2] do
						if (((TheoryCraft_WeaponSkills[i2].ltext) and (TheoryCraft_WeaponSkills[i2].ltext == ltext)) or (TheoryCraft_WeaponSkills[i2].ltext == nil)) and (TheoryCraft_WeaponSkills[i2].text == rtext) then
							skill = TheoryCraft_WeaponSkills[i2].skill
							english = TheoryCraft_WeaponSkills[i2].english
							break
						end
						i2 = i2 + 1
					end
				end
				if skill ~= TheoryCraft_WeaponSkillOther then
					break
				end
				i = i + 1
			end
			local i = 1
			local skillTitle, header, isExpanded, skillRank
			while GetSkillLineInfo(i) do
				skillTitle, header, isExpanded, skillRank = GetSkillLineInfo(i)
				if (skillTitle == skill) then
					critChance = critChance + (UnitLevel("player")*5 - skillRank)*0.04
					break
				end
				i = i + 1
			end
 -- remove weapon specs
			critChance = critChance - TheoryCraft_GetStat(english.."specreal")
		end
		critChance = critChance - (TheoryCraft_GetStat("CritChangeTalents") or 0)
		if doweaponskill == nil then
			critChance = critChance - (TheoryCraft_Data.Talents["Formcritchancereal"] or 0)
			remove = -1*(TheoryCraft_Data.Talents["Formcritchancereal"] or 0)
		end
		local critchance2 = critChance-TheoryCraft_GetStat("CritReport")
		if doweaponskill == nil then
			critChance = critChance + (TheoryCraft_Data.Talents["Formcritchance"] or 0)
		end
		if class == "WARRIOR" then
			local _, _, active = GetShapeshiftFormInfo(3)
			if active then
				critchance2 = critchance2 - 3
				remove = -3
			end
		end
		if UnitLevel("player") == 60 then
			if (class == "DRUID") then
				if doweaponskill == nil then
					remove = -1*(TheoryCraft_Data.Talents["Formcritchance"] or 0)
				end
			end
			TheoryCraft_agipercrit = TheoryCraft_CritChance[class][1]
		else
			if (TheoryCraft_Data["outfit"] == nil) or (TheoryCraft_Data["outfit"] == 1) then
				local _, agi = UnitStat("player", 2)
				TheoryCraft_agipercrit = agi/(critchance2-TheoryCraft_CritChance[class][3])
			end
		end
		return (critChance or 0), remove
	else
		return 0, remove
	end
end

function TheoryCraft_LoadStats(talents)
	if talents == nil then talents = TheoryCraft_Data.Talents end
	TheoryCraft_DeleteTable(TheoryCraft_Data.Stats)
	local remove
	TheoryCraft_Data.Stats["meleecritchance"], remove = GetCritChance()
	TheoryCraft_Data.Stats["Rangedhastebonus"] = UnitRangedDamage("player")/TheoryCraft_GetRangedSpeed()
	local outfit = (TheoryCraft_Data["outfit"] or 1)
	if outfit == -1 then
		outfit = 1
	end

	local _, tmp = UnitStat("player", 1)
	TheoryCraft_Data.Stats["strength"] = tmp
	_, tmp = UnitStat("player", 2)
	TheoryCraft_Data.Stats["agility"] = tmp
	_, tmp = UnitStat("player", 3)
	TheoryCraft_Data.Stats["stamina"] = tmp
	_, tmp = UnitStat("player", 4)
	TheoryCraft_Data.Stats["intellect"] = tmp
	_, tmp = UnitStat("player", 5)
	TheoryCraft_Data.Stats["spirit"] = tmp
	TheoryCraft_Data.Stats["agipercrit"] = agipercrit()

	local _, catform, bearform
	if class == "DRUID" then
		_, _, bearform = GetShapeshiftFormInfo(1)
		_, _, catform = GetShapeshiftFormInfo(3)
		TheoryCraft_Data.Stats["agilityapranged"] = 2
		TheoryCraft_Data.Stats["strengthapmelee"] = 2
		if catform then
			TheoryCraft_Data.Stats["agilityapmelee"] = 1
		else
			TheoryCraft_Data.Stats["agilityapmelee"] = 0
		end
	elseif (class == "WARRIOR") or (class == "PALADIN") or (class == "SHAMAN") then
		TheoryCraft_Data.Stats["agilityapranged"] = 2
		TheoryCraft_Data.Stats["strengthapmelee"] = 2
		TheoryCraft_Data.Stats["agilityapmelee"] = 0
	elseif (class == "ROGUE") or (class == "HUNTER") then
		TheoryCraft_Data.Stats["agilityapranged"] = 2
		TheoryCraft_Data.Stats["strengthapmelee"] = 1
		TheoryCraft_Data.Stats["agilityapmelee"] = 1
	else
		TheoryCraft_Data.Stats["agilityapranged"] = 0
		TheoryCraft_Data.Stats["strengthapmelee"] = 1
		TheoryCraft_Data.Stats["agilityapmelee"] = 0
	end

	local base, pos, neg = UnitAttackPower("player")
	TheoryCraft_Data.Stats["attackpower"] = base+pos+neg-TheoryCraft_Data.Stats["strengthapmelee"]*TheoryCraft_Data.Stats["strength"]-TheoryCraft_Data.Stats["agilityapmelee"]*TheoryCraft_Data.Stats["agility"]+(talents["AttackPowerTalents"] or 0)
	base, pos, neg = UnitRangedAttackPower("player")
	TheoryCraft_Data.Stats["rangedattackpower"] = (TheoryCraft_Data.TargetBuffs["huntersmark"] or 0)+base+pos+neg-TheoryCraft_Data.Stats["agilityapranged"]*TheoryCraft_Data.Stats["agility"]

	TheoryCraft_Data.Stats["totalmana"] = UnitManaMax("player")/talents["manamultiplierreal"]
	TheoryCraft_Data.Stats["totalhealth"] = UnitHealthMax("player")/talents["healthmultiplierreal"]

	TheoryCraft_Data.Stats["meleecritchance"] = TheoryCraft_Data.Stats["meleecritchance"]-TheoryCraft_Data.Stats["agility"]/TheoryCraft_Data.Stats["agipercrit"]
	TheoryCraft_Data.Stats["totalhealth"] = TheoryCraft_Data.Stats["totalhealth"] - TheoryCraft_Data.Stats["stamina"]*10
	TheoryCraft_Data.Stats["totalmana"] = TheoryCraft_Data.Stats["totalmana"] - TheoryCraft_Data.Stats["intellect"]*15

	TheoryCraft_Data.Stats["strength"] = TheoryCraft_Data.Stats["strength"]/talents["strmultiplierreal"]
	TheoryCraft_Data.Stats["agility"] = TheoryCraft_Data.Stats["agility"]/talents["agimultiplierreal"]
	TheoryCraft_Data.Stats["stamina"] = TheoryCraft_Data.Stats["stamina"]/talents["stammultiplierreal"]
	TheoryCraft_Data.Stats["intellect"] = TheoryCraft_Data.Stats["intellect"]/talents["intmultiplierreal"]
	TheoryCraft_Data.Stats["spirit"] = TheoryCraft_Data.Stats["spirit"]/talents["spiritmultiplierreal"]
	TheoryCraft_Data.Stats["formattackpower"] = 0

	if (TheoryCraft_Outfits[outfit].meleecritchance) then TheoryCraft_Data.Stats["meleecritchance"] = TheoryCraft_Data.Stats["meleecritchance"]+TheoryCraft_Outfits[outfit].meleecritchance end
	if (TheoryCraft_Outfits[outfit].rangedattackpower) then TheoryCraft_Data.Stats["rangedattackpower"] = TheoryCraft_Data.Stats["rangedattackpower"]+TheoryCraft_Outfits[outfit].rangedattackpower end
	if (TheoryCraft_Outfits[outfit].attackpower) then TheoryCraft_Data.Stats["attackpower"] = TheoryCraft_Data.Stats["attackpower"]+TheoryCraft_Outfits[outfit].attackpower end
	if (TheoryCraft_Outfits[outfit].formattackpower) then TheoryCraft_Data.Stats["formattackpower"] = TheoryCraft_Data.Stats["formattackpower"]+TheoryCraft_Outfits[outfit].formattackpower end
	if (TheoryCraft_Outfits[outfit].strength) then TheoryCraft_Data.Stats["strength"] = TheoryCraft_Data.Stats["strength"]+TheoryCraft_Outfits[outfit].strength end
	if (TheoryCraft_Outfits[outfit].agility) then TheoryCraft_Data.Stats["agility"] = TheoryCraft_Data.Stats["agility"]+TheoryCraft_Outfits[outfit].agility end
	if (TheoryCraft_Outfits[outfit].stamina) then TheoryCraft_Data.Stats["stamina"] = TheoryCraft_Data.Stats["stamina"]+TheoryCraft_Outfits[outfit].stamina end
	if (TheoryCraft_Outfits[outfit].intellect) then TheoryCraft_Data.Stats["intellect"] = TheoryCraft_Data.Stats["intellect"]+TheoryCraft_Outfits[outfit].intellect end
	if (TheoryCraft_Outfits[outfit].spirit) then TheoryCraft_Data.Stats["spirit"] = TheoryCraft_Data.Stats["spirit"]+TheoryCraft_Outfits[outfit].spirit end
	if (TheoryCraft_Outfits[outfit].totalmana) then TheoryCraft_Data.Stats["totalmana"] = TheoryCraft_Data.Stats["totalmana"]+TheoryCraft_Outfits[outfit].totalmana end
	if (TheoryCraft_Outfits[outfit].totalhealth) then TheoryCraft_Data.Stats["totalhealth"] = TheoryCraft_Data.Stats["totalhealth"]+TheoryCraft_Outfits[outfit].totalhealth end

	local i = 1
	TheoryCraft_Data.DequippedSets = {}
	while (TheoryCraft_Outfits[outfit].destat[i]) do
		TheoryCraft_Data.Stats = TheoryCraft_DequipEffect(TheoryCraft_Outfits[outfit].destat[i], TheoryCraft_Data.Stats, TheoryCraft_Data.DequippedSets)
		i = i + 1
	end

	local returndata
	for k,count in pairs(TheoryCraft_Data.DequippedSets) do
		if TheoryCraft_SetBonuses[k] then
			for k,v in pairs(TheoryCraft_SetBonuses[k]) do
				if (v["pieces"] <= count) then
					returndata = {}
					returndata = TheoryCraft_DequipLine(v["text"], returndata)
					for k,v in pairs(returndata) do
						TheoryCraft_Data.Stats[k] = (TheoryCraft_Data.Stats[k] or 0) + v
					end
					returndata = {}
					returndata = TheoryCraft_DequipSpecial(v["text"], returndata)
					for k,v in pairs(returndata) do
						TheoryCraft_Data.Stats[k] = (TheoryCraft_Data.Stats[k] or 0) + v
					end
				end
			end
		end
	end

	if catform or bearform then TheoryCraft_Data.Stats["attackpower"] = TheoryCraft_Data.Stats["attackpower"] + TheoryCraft_Data.Stats["formattackpower"] end
	TheoryCraft_Data.Stats["strength"] = math.floor(TheoryCraft_Data.Stats["strength"] * talents["strmultiplier"])
	TheoryCraft_Data.Stats["agility"] = math.floor(TheoryCraft_Data.Stats["agility"] * talents["agimultiplier"])
	TheoryCraft_Data.Stats["rangedattackpower"] = math.floor(TheoryCraft_Data.Stats["rangedattackpower"]+TheoryCraft_Data.Stats["agilityapranged"]*TheoryCraft_Data.Stats["agility"])
	TheoryCraft_Data.Stats["attackpower"] = math.floor(TheoryCraft_Data.Stats["attackpower"]+TheoryCraft_Data.Stats["strengthapmelee"]*TheoryCraft_Data.Stats["strength"]+TheoryCraft_Data.Stats["agilityapmelee"]*TheoryCraft_Data.Stats["agility"])
	TheoryCraft_Data.Stats["intellect"] = math.floor(TheoryCraft_Data.Stats["intellect"] * talents["intmultiplier"])
	TheoryCraft_Data.Stats["stamina"] = math.floor(TheoryCraft_Data.Stats["stamina"] * talents["stammultiplier"])
	TheoryCraft_Data.Stats["spirit"] = math.floor(TheoryCraft_Data.Stats["spirit"] * talents["spiritmultiplier"])
	TheoryCraft_Data.Stats["totalhealth"] = (TheoryCraft_Data.Stats["totalhealth"] + TheoryCraft_Data.Stats["stamina"]*10)*talents["healthmultiplier"]
	TheoryCraft_Data.Stats["totalmana"] = (TheoryCraft_Data.Stats["totalmana"] + TheoryCraft_Data.Stats["intellect"]*15)*talents["manamultiplier"]
	TheoryCraft_Data.Stats["meleecritchance"] = TheoryCraft_Data.Stats["meleecritchance"]+TheoryCraft_Data.Stats["agility"]/TheoryCraft_Data.Stats["agipercrit"]
	TheoryCraft_Data.Stats["rangedcritchance"] = TheoryCraft_Data.Stats["meleecritchance"]+(talents["Huntercritchance"] or 0)
	TheoryCraft_Data.Stats["critchance"] = TheoryCraft_Data.Stats["intellect"]/TheoryCraft_intpercrit()+TheoryCraft_CritChance[class][4]
	if class == "MAGE" then
		TheoryCraft_Data.Stats["regenfromspirit"] = TheoryCraft_Data.Stats["spirit"]/8+6.25
	elseif class == "PRIEST" then
		TheoryCraft_Data.Stats["regenfromspirit"] = TheoryCraft_Data.Stats["spirit"]/8+6.25
	elseif class == "WARLOCK" then
		TheoryCraft_Data.Stats["regenfromspirit"] = TheoryCraft_Data.Stats["spirit"]/10+7.5
	elseif class == "DRUID" then
		TheoryCraft_Data.Stats["regenfromspirit"] = TheoryCraft_Data.Stats["spirit"]/10+7.5
	elseif class == "SHAMAN" then
		TheoryCraft_Data.Stats["regenfromspirit"] = TheoryCraft_Data.Stats["spirit"]/10+8.5
	elseif class == "HUNTER" then
		TheoryCraft_Data.Stats["regenfromspirit"] = TheoryCraft_Data.Stats["spirit"]/10+7.5
	elseif class == "PALADIN" then
		TheoryCraft_Data.Stats["regenfromspirit"] = TheoryCraft_Data.Stats["spirit"]/10+7.5
	elseif class == "ROGUE" then
		TheoryCraft_Data.Stats["regenfromspirit"] = 0
	elseif class == "WARRIOR" then
		TheoryCraft_Data.Stats["regenfromspirit"] = 0
	end

	TheoryCraft_Data.Stats["meleecritchancereal"] = TheoryCraft_Data.Stats["meleecritchance"]+(remove or 0)
	if (TheoryCraft_Data.EquipEffects["FistEquipped"] or 0) >= 1 then
		TheoryCraft_Data.Stats["meleecritchance"] = TheoryCraft_Data.Stats["meleecritchance"]+TheoryCraft_GetStat("Fistspec")
	end
	if (TheoryCraft_Data.EquipEffects["DaggerEquipped"] or 0) >= 1 then
		TheoryCraft_Data.Stats["meleecritchance"] = TheoryCraft_Data.Stats["meleecritchance"]+TheoryCraft_GetStat("Daggerspec")
	end
	if (TheoryCraft_Data.EquipEffects["AxeEquipped"] or 0) >= 1 then
		TheoryCraft_Data.Stats["meleecritchance"] = TheoryCraft_Data.Stats["meleecritchance"]+TheoryCraft_GetStat("Axespec")
	end
	if (TheoryCraft_Data.EquipEffects["PolearmEquipped"] or 0) >= 1 then
		TheoryCraft_Data.Stats["meleecritchance"] = TheoryCraft_Data.Stats["meleecritchance"]+TheoryCraft_GetStat("Polearmspec")
	end
	local meleeapmult = TheoryCraft_GetStat("MeleeAPMult")
	if meleeapmult > 3 then
		TheoryCraft_Data.Stats["Meleemodifier"] = (talents["Twohandmodifier"] or 0)+(talents["Twohandtalentmod"] or 0)
	elseif meleeapmult > 1 then
		TheoryCraft_Data.Stats["Meleemodifier"] = (talents["Onehandmodifier"] or 0)+(talents["Onehandtalentmod"] or 0)
	end
	local manaregen = TheoryCraft_GetStat("manaperfive")/5
	manaregen = manaregen+TheoryCraft_Data.Stats["totalmana"]*TheoryCraft_GetStat("FelEnergy")/4
	TheoryCraft_Data.Stats["regen"] = manaregen+TheoryCraft_Data.Stats["regenfromspirit"]
	TheoryCraft_Data.Stats["icregen"] = manaregen+(TheoryCraft_Data.Stats["regenfromspirit"])*TheoryCraft_GetStat("ICPercent")
 	if (class == "MAGE") then
		TheoryCraft_Data.Stats["maxtotalmana"] = TheoryCraft_Data.Stats["totalmana"]+TheoryCraft_Data.Stats["regenfromspirit"]*15*8+1100+manaregen*8
	end
	if (class == "WARLOCK") then
		getlifetap(TheoryCraft_Data.Stats)
	end

	TheoryCraft_Data.Stats["All"] = math.floor(TheoryCraft_Data.Stats["spirit"]*(talents["Allspiritual"] or 0))
	TheoryCraft_Data.Stats["BlockValue"] = TheoryCraft_GetStat("BlockValueReport")+(TheoryCraft_Data.Stats["strength"]/20) - 1
end

local function AddProcs(casttime, returndata, spelldata)
	TheoryCraft_Data.Procs = {}
	if TheoryCraft_Settings["procs"] == nil then return end
	if (spelldata == nil) or (spelldata.Schools == nil) then return end
	if TheoryCraft_Data.EquipEffects["procs"] then
		local i = 1
		local amount, procduration
		while TheoryCraft_Data.EquipEffects["procs"][i] do
			amount = TheoryCraft_Data.EquipEffects["procs"][i].amount
			if TheoryCraft_Data.EquipEffects["procs"][i].exact then
				procduration = 1 - (1 - TheoryCraft_Data.EquipEffects["procs"][i].proc)^math.floor(TheoryCraft_Data.EquipEffects["procs"][i].duration/casttime)
			else
				procduration = 1 - (1 - TheoryCraft_Data.EquipEffects["procs"][i].proc)^(TheoryCraft_Data.EquipEffects["procs"][i].duration/casttime)
			end
			TheoryCraft_Data.Procs[TheoryCraft_Data.EquipEffects["procs"][i].type] = (TheoryCraft_Data.Procs[TheoryCraft_Data.EquipEffects["procs"][i].type] or 0)+amount*procduration
			i = i + 1
		end
		i = 1
		while (spelldata.Schools[i]) do
			TheoryCraft_AddData(spelldata.Schools[i], TheoryCraft_Data.Procs, returndata)
			i = i+1
		end
		if TheoryCraft_Data.Procs["ICPercent"] then
			TheoryCraft_Data.Stats["icregen"] = TheoryCraft_GetStat("manaperfive")/5+(TheoryCraft_Data.Stats["regenfromspirit"])*(TheoryCraft_GetStat("ICPercent")+TheoryCraft_Data.Procs["ICPercent"])
		end
	end
end

local function CleanUp(spelldata, returndata)
	if spelldata.percent == 0 then
		returndata["plusdam"] = nil
		returndata["damfinal"] = nil
		returndata["damcoef"] = nil
	end
	if spelldata.ismelee then
		returndata["manacost"] = nil
		returndata["plusdam"] = nil
	end
	if spelldata.isheal then
		returndata["penetration"] = nil
	end
	if spelldata.armor then
		returndata["plusdam"] = nil
		returndata["penetration"] = nil
	end
	if spelldata.dodps == nil then
		returndata["hps"] = nil
		returndata["withhothps"] = nil
		returndata["hpsdam"] = nil
		returndata["hpsdampercent"] = nil
		returndata["dps"] = nil
		returndata["withdotdps"] = nil
		returndata["dpsdam"] = nil
		returndata["dpsdampercent"] = nil
	end
	if (spelldata.usemelee) or (spelldata.petspell) then
		returndata["nextpendam"] = nil
		returndata["nextpen"] = nil
		returndata["penetration"] = nil
	end
	if spelldata.petspell then
		returndata["damcoef"] = nil
		returndata["dpsdam"] = nil
		returndata["dpsdampercent"] = nil
		returndata["plusdam"] = nil
		returndata["dameff"] = nil
		returndata["damfinal"] = nil
		returndata["lifetapdps"] = nil
		returndata["lifetapdpm"] = nil
		returndata["nextagidps"] = nil
		returndata["nexthitdps"] = nil
		returndata["nextcritdps"] = nil
		returndata["nextstrdpsequive"] = nil
		returndata["nextagidpsequive"] = nil
		returndata["nexthitdpsequive"] = nil
		returndata["nextcritdpsequive"] = nil
		returndata["nextagidam"] = nil
		returndata["nextpendam"] = nil
		returndata["nexthitdam"] = nil
		returndata["nextcritdam"] = nil
		returndata["nextstrdamequive"] = nil
		returndata["nextagidamequive"] = nil
		returndata["nextpendamequive"] = nil
		returndata["nexthitdamequive"] = nil
		returndata["nextcritdamequive"] = nil
		returndata["regendam"] = nil
		returndata["icregendam"] = nil
		returndata["nextcritheal"] = nil
		returndata["nextcrithealequive"] = nil
		returndata["hpsdam"] = nil
		returndata["hpsdampercent"] = nil
		returndata["regenheal"] = nil
		returndata["icregenheal"] = nil
	end

	if (spelldata.dontdpsafterresists) then
		returndata["nexthitdam"] = nil
	end

	if (spelldata.cancrit == nil) then
		returndata["nextcritdam"] = nil
		returndata["nextcritdamequive"] = nil
		returndata["nextcritdps"] = nil
		returndata["nextcritdpsequive"] = nil
		returndata["critchance"] = nil
		returndata["critdmgchance"] = nil
		returndata["crithealchance"] = nil
		returndata["critdmgmin"] = nil
		returndata["critdmgmax"] = nil
		returndata["critdmgminminusignite"] = nil
		returndata["critdmgmaxminusignite"] = nil
		returndata["crithealmin"] = nil
		returndata["crithealmax"] = nil
	end
end

local function GenerateTooltip(frame, returndata, spelldata, spellrank)
	returndata["RangedAPMult"] = 2.8
	if (frame == nil) or (frame:NumLines() == 0) then
		CleanUp(spelldata, returndata)
		return
	end
	if spelldata.evocation then
		CleanUp(spelldata, returndata)
		returndata["evocation"] = TheoryCraft_GetStat("maxtotalmana")-TheoryCraft_GetStat("totalmana")-1100
		return
	end
	if (spelldata.isranged) then
		if TheoryCraft_Data.EquipEffects["RangedSpeed"] == nil then
			CleanUp(spelldata, returndata)
			return
		end
	end
	if (spelldata.isseal) then
		if TheoryCraft_Data.EquipEffects["MainSpeed"] == nil then
			CleanUp(spelldata, returndata)
			return
		end
	end
	if (spelldata.id == "Backstab") then
		if TheoryCraft_GetStat("DaggerEquipped") == 0 then
			CleanUp(spelldata, returndata)
			return
		end
	end
	if (spelldata.ismelee) then
		if TheoryCraft_Data.EquipEffects["MainSpeed"] == nil then
			CleanUp(spelldata, returndata)
			return
		end
		local i = 1
		returndata["critchance"] = TheoryCraft_Data.Stats["meleecritchance"]+TheoryCraft_GetStat(spelldata.id.."critchance")
		while spelldata.Schools[i] do
			returndata["critchance"] = returndata["critchance"]+TheoryCraft_GetStat(spelldata.Schools[i].."critchance")
			i = i + 1
		end
	end
	if (spelldata.bearform) then
		local _, _, active = GetShapeshiftFormInfo(1)
		if active == nil then
			CleanUp(spelldata, returndata)
			return
		end
	end
	if (spelldata.catform) then
		local _, _, active = GetShapeshiftFormInfo(3)
		if active == nil then
			CleanUp(spelldata, returndata)
			return
		end
	end
	if (spelldata.usemelee) then
		returndata["critchance"] = (TheoryCraft_Data.Stats["meleecritchance"] or 0)+TheoryCraft_GetStat("Holycritchance")
		returndata["critbonus"] = 1
	end
	if (spelldata.isranged) or ((class == "HUNTER") and (spelldata.ismelee == nil)) then
		returndata["critchance"] = TheoryCraft_Data.Stats["rangedcritchance"]
	end
	returndata["description"] = getglobal(frame:GetName().."TextLeft"..frame:NumLines()):GetText()
	returndata["casttime"] = getcasttime(frame)+(returndata["casttime"] or 0)
	returndata["manacost"] = getmanacost(frame)
	if not (spelldata.shoot or spelldata.ismelee or spelldata.isranged) then
		returndata["basemanacost"] = returndata["manacost"]
	end
	if returndata["casttime"] < 1.5 then
		returndata["casttime"] = 1.5
	end
	returndata["regencasttime"] = returndata["casttime"]
	if (spelldata.casttime) then
		returndata["casttime"] = spelldata.casttime
	end
	AddProcs(returndata["casttime"], returndata, spelldata)
	if (spelldata.regencasttime) then
		returndata["regencasttime"] = spelldata.regencasttime
	end
	if (returndata["netherwind"] == 1) and (TheoryCraft_Settings["procs"]) then
		if (returndata["casttime"] > 1.5) then returndata["casttime"] = (returndata["casttime"]-1.5)*0.9+1.5 end
		if (returndata["regencasttime"] > 1.5) then returndata["regencasttime"] = (returndata["regencasttime"]-1.5)*0.9+1.5 end
	end
	local spelllevel = 60
	local levelpercent = 1
	returndata["manamultiplier"] = spelldata.manamultiplier
	if (spelldata["level"..spellrank]) then spelllevel = spelldata["level"..spellrank] end
	if (spelldata["level"..spellrank.."per"]) then levelpercent = spelldata["level"..spellrank.."per"] end
	if (spelldata["level"..spellrank.."manamult"]) then returndata["manamultiplier"] = spelldata["level"..spellrank.."manamult"] end
	if (spelldata["level"..spellrank.."ct"]) then 
		returndata["casttime"] = spelldata["level"..spellrank.."ct"]
		returndata["regencasttime"] = spelldata["level"..spellrank.."ct"]
	end
	if (spelllevel < 20) then
		levelpercent = levelpercent*(0.0375*spelllevel+0.25)
	end

	returndata["dotduration"] = TheoryCraft_getDotDuration(returndata["description"])
	returndata["basedotduration"] = spelldata.basedotduration
	if (spelldata.ismelee == nil) and (spelldata.isranged == nil) then
		if (spelldata.isheal == nil) and (spelldata.talentsbeforegear == nil) then
			returndata["damcoef"] = spelldata.percent*returndata["tmpincrease"]*returndata["tmpincreaseupfront"]*levelpercent
		else
			returndata["damcoef"] = spelldata.percent*levelpercent
		end
		if (spelldata.righteousness) then
			if (TheoryCraft_Data.EquipEffects["MeleeAPMult"] >= 3) then
				returndata["damcoef"] = spelldata.percent2*returndata["tmpincrease"]*levelpercent
			end
		end
		if (spelldata.hasdot == 1) then
			returndata["damcoef2"] = spelldata.percentdot
			returndata["plusdam2"] = math.floor(returndata["plusdam"] * returndata["damcoef2"] * levelpercent)
		end
		if (newcasttime) and (spelldata.isdot) then
			returndata["damcoef"] = returndata["damcoef"]*newcasttime/returndata["basedotduration"]
			returndata["casttime"] = newcasttime
		end
		returndata["damfinal"] = returndata["plusdam"] * returndata["damcoef"]
	end

	if returndata["critchance"] > 100 then
		returndata["critchance"] = 100
	end
	returndata["critbonus"] = returndata["critbonus"]+returndata["sepignite"]*(returndata["baseincrease"]+returndata["ignitemodifier"]-1)
	returndata["sepignite"] = returndata["sepignite"]*returndata["baseincrease"]

	returndata["talentbaseincrease"] = (1/returndata["tmpincrease"])*(returndata["talentmod"]+returndata["tmpincrease"])
	returndata["talentbaseincreaseupfront"] = (1/returndata["tmpincreaseupfront"])*(returndata["talentmodupfront"]+returndata["tmpincreaseupfront"])
	if (spelldata.talentsbeforegear == nil) and (returndata["damcoef"]) then
		returndata["damcoef"] = returndata["damcoef"]*returndata["talentbaseincrease"]*returndata["talentbaseincreaseupfront"]
	end
	if class == "DRUID" then
		local _, bearform, catform
		_, _, bearform = GetShapeshiftFormInfo(1)
		_, _, catform = GetShapeshiftFormInfo(3)
		if catform then
			TheoryCraft_Data.EquipEffects["MeleeAPMult"] = 1
			TheoryCraft_Data.EquipEffects["MainSpeed"] = 1
		elseif bearform then
			TheoryCraft_Data.EquipEffects["MeleeAPMult"] = 2.5
			TheoryCraft_Data.EquipEffects["MainSpeed"] = 2.5
		end
		if (bearform) or (catform) then
			local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player")
			local base, pos, neg = UnitAttackPower("player")
			base = (base+pos+neg)/14*TheoryCraft_Data.EquipEffects["MeleeAPMult"]
			TheoryCraft_Data.EquipEffects["MeleeMin"] = lowDmg-base
			TheoryCraft_Data.EquipEffects["MeleeMax"] = hiDmg-lowDmg+TheoryCraft_Data.EquipEffects["MeleeMin"]
		end
	end
	TheoryCraft_getMinMax(spelldata, returndata, frame)
	if spelldata.cancrit then
		if spelldata.drain then
			returndata["critdmgchance"] = returndata["critchance"]
			returndata["crithealchance"] = returndata["critchance"]
		elseif spelldata.isheal then
			returndata["crithealchance"] = returndata["critchance"]
		else
			returndata["critdmgchance"] = returndata["critchance"]
		end
	end

	if spelldata.isheal == nil then
		returndata["manacost"] = returndata["manacost"]-returndata["manacost"]*(TheoryCraft_Data.Talents["clearcast"] or 0)
	end
	if (returndata["manamultiplier"]) then
		returndata["manacost"] = returndata["manacost"]*returndata["manamultiplier"]
	end
	returndata["manacost"] = returndata["manacost"]-TheoryCraft_Data.Stats["icregen"]*returndata["regencasttime"]
	returndata["manacost"] = returndata["manacost"]*returndata["manacostmod"]

	if (returndata["crithealchance"]) and (returndata["crithealchance"] > 100) then
		returndata["crithealchance"] = 100
	end
	if (returndata["critdmgchance"]) and (returndata["critdmgchance"] > 100) then
		returndata["critdmgchance"] = 100
	end

	if spelldata.dontusemelee then
		returndata["critbonus"] = 0.5
	end
	if (spelldata.isseal) or (spelldata.ismelee) or (spelldata.isranged) then
		if (returndata["mindamage"] and returndata["maxdamage"] and (spelldata.isseal == nil)) and (spelldata.block == nil) then 
			returndata["critdmgmin"] = returndata["mindamage"]*(returndata["critbonus"]+1)
			returndata["critdmgmax"] = returndata["maxdamage"]*(returndata["critbonus"]+1)
			returndata["averagedamnocrit"] = (returndata["maxdamage"]+returndata["mindamage"])/2
			returndata["averagecritdam"] = returndata["averagedamnocrit"]*returndata["critbonus"]
			returndata["averagedam"] = returndata["averagedamnocrit"]+returndata["averagecritdam"]*returndata["critdmgchance"]/100
			returndata["nextagidam"] = 10*TheoryCraft_Data.Talents["agimultiplier"]
			if spelldata.ismelee then
				if spelldata.nextattack then
					local attackpower = 10*TheoryCraft_Data.Talents["agimultiplier"]*TheoryCraft_Data.Stats["agilityapmelee"]
					local addeddamage = attackpower*(TheoryCraft_Data.EquipEffects["MainSpeed"])*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Meleemodifier")/14
					local addedcritpercent = 10*TheoryCraft_Data.Talents["agimultiplier"]/TheoryCraft_Data.Stats["agipercrit"]/100
					returndata["nextagidam"] = addedcritpercent*returndata["averagecritdam"]+addeddamage*(addedcritpercent+returndata["critdmgchance"]/100)*returndata["critbonus"]+addeddamage
					returndata["damworth"] = (1+(returndata["critchance"]/100)*returndata["critbonus"])*(TheoryCraft_Data.EquipEffects["MainSpeed"])/14*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Meleemodifier")
				elseif returndata["bloodthirstmult"] then
					local attackpower = 10*TheoryCraft_Data.Talents["agimultiplier"]*TheoryCraft_Data.Stats["agilityapmelee"]
					local addeddamage = attackpower*returndata["bloodthirstmult"]*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Meleemodifier")/14
					local addedcritpercent = 10*TheoryCraft_Data.Talents["agimultiplier"]/TheoryCraft_Data.Stats["agipercrit"]/100
					returndata["nextagidam"] = addedcritpercent*returndata["averagecritdam"]+addeddamage*(addedcritpercent+returndata["critdmgchance"]/100)*returndata["critbonus"]+addeddamage
					returndata["damworth"] = (1+(returndata["critchance"]/100)*returndata["critbonus"])*returndata["bloodthirstmult"]*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Meleemodifier")
				else
					local attackpower = 10*TheoryCraft_Data.Talents["agimultiplier"]*TheoryCraft_Data.Stats["agilityapmelee"]
					local addeddamage = attackpower*TheoryCraft_Data.EquipEffects["MeleeAPMult"]*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Meleemodifier")/14
					local addedcritpercent = 10*TheoryCraft_Data.Talents["agimultiplier"]/TheoryCraft_Data.Stats["agipercrit"]/100
					returndata["nextagidam"] = addedcritpercent*returndata["averagecritdam"]+addeddamage*(addedcritpercent+returndata["critdmgchance"]/100)*returndata["critbonus"]+addeddamage
					returndata["damworth"] = (1+(returndata["critchance"]/100)*returndata["critbonus"])*TheoryCraft_Data.EquipEffects["MeleeAPMult"]/14*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Meleemodifier")
				end
				returndata["nextstrdam"] = 10*TheoryCraft_Data.Talents["strmultiplier"]*TheoryCraft_Data.Stats["strengthapmelee"]*returndata["damworth"]
			else
				local attackpower = 10*TheoryCraft_Data.Talents["agimultiplier"]*TheoryCraft_Data.Stats["agilityapranged"]
				local addeddamage = attackpower*returndata["RangedAPMult"]*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Rangedmodifier")/14
				local addedcritpercent = 10*TheoryCraft_Data.Talents["agimultiplier"]/TheoryCraft_Data.Stats["agipercrit"]/100
				returndata["nextagidam"] = addedcritpercent*returndata["averagecritdam"]+addeddamage*(addedcritpercent+returndata["critdmgchance"]/100)*returndata["critbonus"]+addeddamage
				returndata["damworth"] = (1+(returndata["critchance"]/100)*returndata["critbonus"])*returndata["RangedAPMult"]/14*returndata["backstabmult"]*returndata["baseincrease"]*TheoryCraft_GetStat("Rangedmodifier")
			end

			returndata["nextcritdam"] = returndata["averagecritdam"]/100
			returndata["nexthitdam"] = returndata["averagedamnocrit"]/100
			if (returndata["damworth"] ~= 0) then
				if returndata["nextstrdam"] then
					returndata["nextstrdamequive"] = returndata["nextstrdam"]/returndata["damworth"]
				end
				returndata["nexthitdamequive"] = returndata["nexthitdam"]/returndata["damworth"]
				returndata["nextcritdamequive"] = returndata["nextcritdam"]/returndata["damworth"]
				returndata["nextagidamequive"] = returndata["nextagidam"]/returndata["damworth"]
			end
			if (spelldata.isranged) and (spelldata.shoot == nil) then
				if (spelldata.autoshot) then
					returndata["dpm"] = returndata["msrotationlength"]*returndata["msrotationdps"]/returndata["manacost"]
					returndata["maxoomdam"] = (TheoryCraft_Data.Stats["totalmana"]+TheoryCraft_GetStat("manarestore"))*returndata["dpm"]
					returndata["maxoomdamtime"] = returndata["maxoomdam"]/returndata["dps"]
					returndata["regendam"] = TheoryCraft_Data.Stats["regen"]*10*returndata["dpm"]
					returndata["icregendam"] = TheoryCraft_Data.Stats["icregen"]*10*returndata["dpm"]
				else
					if TheoryCraft_Settings["dontcritdpm"] then
						returndata["dpm"] = returndata["averagedamnocrit"]/returndata["manacost"]
					else
						returndata["dpm"] = returndata["averagedam"]/returndata["manacost"]
					end
					returndata["regendam"] = TheoryCraft_Data.Stats["regen"]*10*returndata["dpm"]
					returndata["icregendam"] = TheoryCraft_Data.Stats["icregen"]*10*returndata["dpm"]
				end
			end
		end
	else
		if class == "DRUID" then
			if (spelldata.cancrit) and (returndata["grace"] ~= 0) and (not TheoryCraft_Settings["dontcrit"]) then
				returndata["casttime"] = returndata["casttime"]-(returndata["critchance"]/100)*returndata["grace"]
				if returndata["casttime"] < 1.5 then
					returndata["casttime"] = 1.5
				end
			end
		end
		if (class == "MAGE") then
			if (returndata["critdmgchance"]) and (not TheoryCraft_Settings["dontcrit"]) then
				returndata["manacost"] = returndata["manacost"]-returndata["manacost"]*((returndata["critdmgchance"]/100)*returndata["illum"])
			end
		end

		if returndata["mindamage"] then
			if returndata["maxdamage"] == nil then
				returndata["maxdamage"] = returndata["mindamage"]
			end
			returndata["critdmgmin"] = returndata["mindamage"]*(returndata["critbonus"]+1)
			returndata["critdmgmax"] = returndata["maxdamage"]*(returndata["critbonus"]+1)
			returndata["averagedamnocrit"] = (returndata["maxdamage"]+returndata["mindamage"])/2
			returndata["averagedpsdamnocrit"] = returndata["damfinal"]
			if spelldata.cancrit then
				returndata["critdmgmin"] = returndata["mindamage"]*(returndata["critbonus"]+1)
				returndata["critdmgmax"] = returndata["maxdamage"]*(returndata["critbonus"]+1)
				if (returndata["sepignite"] ~= 0) then
					returndata["critdmgminminusignite"] = ((returndata["critdmgmin"]/(returndata["critbonus"]+1))*(1+returndata["critbonus"]-returndata["sepignite"]))
					returndata["critdmgmaxminusignite"] = ((returndata["critdmgmax"]/(returndata["critbonus"]+1))*(1+returndata["critbonus"]-returndata["sepignite"]))
				end

				if (TheoryCraft_Settings["rollignites"]) and (not spelldata.dontdomax) and (returndata["sepignite"] ~= 0) and (returndata["critdmgchance"] < 99) then
					local ignitecritmin = returndata["critdmgmin"]-(returndata["critdmgmin"]/(returndata["critbonus"]+1))*(1+returndata["critbonus"]-returndata["sepignite"])
					local ignitecritmax = returndata["critdmgmax"]-(returndata["critdmgmax"]/(returndata["critbonus"]+1))*(1+returndata["critbonus"]-returndata["sepignite"])
					local igniteaverage = (ignitecritmax-ignitecritmin)/2+ignitecritmin
					local noignitecritmin = returndata["critdmgmin"]-ignitecritmin-returndata["mindamage"]
					local noignitecritmax = returndata["critdmgmax"]-ignitecritmax-returndata["maxdamage"]
					local noigniteaverage = (noignitecritmin+noignitecritmax)/2
					local rollchance = (returndata["critdmgchance"]/100)
					local ignitelength = 4+rollchance*4+(rollchance^2)*4+(rollchance^3)*4+(rollchance^4)*4+(rollchance^5)*4+(rollchance^6)*4
					returndata["averagecritdam"] = noigniteaverage+ignitelength*igniteaverage/4
					rollchance = ((returndata["critdmgchance"]+1)/100)
					local newignitelength = 4+rollchance*4+(rollchance^2)*4+(rollchance^3)*4+(rollchance^4)*4+(rollchance^5)*4+(rollchance^6)*4
					-- Average Crit Damage
					returndata["nextcritdam"] = noigniteaverage+newignitelength*igniteaverage/4
					-- Damage from extra ignite length
					returndata["nextcritdam"] = (returndata["nextcritdam"]+(newignitelength-ignitelength)*igniteaverage/4*returndata["critdmgchance"])/100
				else
					returndata["averagecritdam"] = returndata["averagedamnocrit"]*returndata["critbonus"]
					returndata["nextcritdam"] = returndata["averagecritdam"]/100
				end
				returndata["damhitworth"] = returndata["damcoef"]
				returndata["damcritworth"] = returndata["damcoef"]*(returndata["critbonus"]+1)
				returndata["damworth"] = returndata["damcoef"]*(1+returndata["critdmgchance"]*returndata["critbonus"]/100)
				returndata["averagedam"] = returndata["averagedamnocrit"]+returndata["averagecritdam"]*returndata["critdmgchance"]/100
				returndata["nextcritdam"] = returndata["nextcritdam"] + returndata["averagedam"]*returndata["grace"]
				returndata["nextcritdamequive"] = returndata["nextcritdam"]/returndata["damworth"]
			else
				returndata["averagecritdam"] = 0
				returndata["averagedam"] = returndata["averagedamnocrit"]
				returndata["damhitworth"] = returndata["damcoef"]
				returndata["damcritworth"] = 0
				returndata["damworth"] = returndata["damcoef"]
			end
			returndata["averagedamthreat"] = returndata["averagedam"]*returndata["threat"]
			returndata["averagedamthreatpercent"] = returndata["averagedamthreat"]/returndata["averagedam"]*100
			if (not TheoryCraft_Settings["dontcrit"]) then
				returndata["averagedpsdam"] = returndata["averagedpsdamnocrit"]*(returndata["averagedam"]/returndata["averagedamnocrit"])
			else
				returndata["averagedpsdam"] = returndata["averagedpsdamnocrit"]
			end
			if spelldata.tickinterval then
				if (spelldata.hasdot) and (returndata["dotdamage"]) then
					returndata["averagedamtick"] = returndata["dotdamage"]/returndata["dotduration"]*spelldata.tickinterval
					returndata["averagedamticknocrit"] = returndata["dotdamage"]/returndata["dotduration"]*spelldata.tickinterval
				else
					if returndata["manamultiplier"] then
						if (TheoryCraft_Settings["dontcrit"]) then
							returndata["averagedamtick"] = returndata["averagedamnocrit"]/returndata["manamultiplier"]/returndata["dotduration"]*spelldata.tickinterval
						else
							returndata["averagedamtick"] = returndata["averagedam"]/returndata["manamultiplier"]/returndata["dotduration"]*spelldata.tickinterval
						end
					else
						if (TheoryCraft_Settings["dontcrit"]) then
							returndata["averagedamtick"] = returndata["averagedamnocrit"]/returndata["dotduration"]*spelldata.tickinterval
						else
							returndata["averagedamtick"] = returndata["averagedam"]/returndata["dotduration"]*spelldata.tickinterval
						end
					end
				end
			end
			if spelldata.coa then
				local tick1 = round((returndata["averagedam"]-returndata["damfinal"]*returndata["baseincrease"])/24+returndata["damfinal"]*returndata["baseincrease"]/12)
				local tick2 = round((returndata["averagedam"]-returndata["damfinal"]*returndata["baseincrease"])/12+returndata["damfinal"]*returndata["baseincrease"]/12)
				local tick3 = round((returndata["averagedam"]-returndata["damfinal"]*returndata["baseincrease"])/8+returndata["damfinal"]*returndata["baseincrease"]/12)
				returndata["averagedamtick"] = tick1..", "..tick2..", "..tick3
			end
			if spelldata.starshards then
				local tick1 = round((returndata["averagedam"]-returndata["damfinal"]*returndata["baseincrease"])/10+returndata["damfinal"]*returndata["baseincrease"]/6)
				local tick2 = round((returndata["averagedam"]-returndata["damfinal"]*returndata["baseincrease"])/6+returndata["damfinal"]*returndata["baseincrease"]/6)
				local tick3 = round((returndata["averagedam"]-returndata["damfinal"]*returndata["baseincrease"])/4.5+returndata["damfinal"]*returndata["baseincrease"]/6)
				returndata["averagedamtick"] = tick1..", "..tick2..", "..tick3
			end
			if (TheoryCraft_Settings["dontcrit"]) then
				returndata["dpm"] = returndata["averagedamnocrit"]/returndata["manacost"]
			else
				returndata["dpm"] = returndata["averagedam"]/returndata["manacost"]
			end
			if (TheoryCraft_Data.Stats["lifetapMana"]) and (TheoryCraft_Data.Stats["lifetapHealth"]) then
				returndata["lifetapdpm"] = returndata["dpm"]*returndata["manacost"]/(returndata["manacost"]/TheoryCraft_Data.Stats["lifetapMana"]*TheoryCraft_Data.Stats["lifetapHealth"])
			end
			if (spelldata.overcooldown) then
				if (TheoryCraft_Settings["dontcrit"]) then
					returndata["dps"] = returndata["averagedamnocrit"]/getcooldown(frame)
				else
					returndata["dps"] = returndata["averagedam"]/getcooldown(frame)
				end
				returndata["dpsdam"] = returndata["averagedpsdam"]/getcooldown(frame)
			else
				if (TheoryCraft_Settings["dotoverct"]) and (spelldata.isdot) then
					if (TheoryCraft_Settings["dontcrit"]) then
						returndata["dps"] = returndata["averagedamnocrit"]/returndata["casttime"]
					else
						returndata["dps"] = returndata["averagedam"]/returndata["casttime"]
					end
					returndata["dpsdam"] = returndata["averagedpsdam"]/returndata["casttime"]
				else
					if spelldata.isdot then
						if (TheoryCraft_Settings["dontcrit"]) then
							returndata["dps"] = returndata["averagedamnocrit"]/returndata["dotduration"]
						else
							returndata["dps"] = returndata["averagedam"]/returndata["dotduration"]
						end
						returndata["dpsdam"] = returndata["averagedpsdam"]/returndata["dotduration"]
					else
						if (TheoryCraft_Settings["dontcrit"]) then
							returndata["dps"] = returndata["averagedamnocrit"]/returndata["casttime"]
						else
							returndata["dps"] = returndata["averagedam"]/returndata["casttime"]
						end
						returndata["dpsdam"] = returndata["averagedpsdam"]/returndata["casttime"]
						if TheoryCraft_Data.Stats["lifetapMana"] then
							if (TheoryCraft_Settings["dontcrit"]) then
								returndata["lifetapdps"] = returndata["averagedamnocrit"]/(returndata["casttime"]+(returndata["manacost"]/TheoryCraft_Data.Stats["lifetapMana"])*1.5)
							else
								returndata["lifetapdps"] = returndata["averagedam"]/(returndata["casttime"]+(returndata["manacost"]/TheoryCraft_Data.Stats["lifetapMana"])*1.5)
							end
						end
					end
				end
			end

			if returndata["dotdamage"] then
				returndata["withdotdpm"] = (returndata["dpm"]*returndata["manacost"]+returndata["dotdamage"])/returndata["manacost"]
				if (TheoryCraft_Settings["combinedot"]) then
					if (TheoryCraft_Settings["dontcrit"]) then
						returndata["withdotdps"] = (returndata["averagedamnocrit"]+returndata["dotdamage"])/returndata["casttime"]
					else
						returndata["withdotdps"] = (returndata["averagedam"]+returndata["dotdamage"])/returndata["casttime"]
					end
				else
					returndata["withdotdps"] = returndata["dotdamage"]/returndata["dotduration"]
				end
			end

			if spelldata.isdot then
				returndata["dameff"] = returndata["damcoef"]*returndata["baseincrease"]/returndata["dotduration"]*3.5
			else
				if returndata["damcoef2"] then
					returndata["dameff"] = ((returndata["damcoef"]+returndata["damcoef2"])*returndata["baseincrease"])/returndata["casttime"]*3.5
				else
					returndata["dameff"] = returndata["damcoef"]*returndata["baseincrease"]/returndata["casttime"]*3.5
				end
			end
			if spelldata.dontdomax == nil then
				returndata["maxoomdam"] = (TheoryCraft_Data.Stats["totalmana"]+TheoryCraft_GetStat("manarestore"))*returndata["dpm"]
				returndata["maxoomdamtime"] = returndata["maxoomdam"]/returndata["dps"]
				if TheoryCraft_Data.Stats["maxtotalmana"] then
					returndata["maxevocoomdam"] = (TheoryCraft_Data.Stats["maxtotalmana"]+TheoryCraft_GetStat("manarestore"))*returndata["dpm"]
					returndata["maxevocoomdamtime"] = returndata["maxevocoomdam"]/returndata["dps"]+8
				end
			end
			if (spelldata.isdot == nil) then
				returndata["nexthitdam"] = returndata["averagedamnocrit"]/100
				returndata["nexthitdamequive"] = returndata["nexthitdam"]/returndata["damworth"]
			end
			returndata["nextpendam"] = returndata["averagedam"]*UnitLevel("player")/2400
			returndata["nextpendamequive"] = returndata["nextpendam"]/returndata["damworth"]
			returndata["regendam"] = TheoryCraft_Data.Stats["regen"]*10*returndata["dpm"]
			returndata["icregendam"] = TheoryCraft_Data.Stats["icregen"]*10*returndata["dpm"]
			returndata["penetration"] = returndata["penetration"]/((20/3)*UnitLevel("player"))*returndata["dps"]
			if (returndata["manamultiplier"]) and (spelldata.lightningshield == nil) then
				returndata["averagedam"] = returndata["averagedam"]/returndata["manamultiplier"]
				returndata["averagedamnocrit"] = returndata["averagedamnocrit"]/returndata["manamultiplier"]
				returndata["averagedamthreat"] = returndata["averagedamthreat"]/returndata["manamultiplier"]
			end
		end

		if (returndata["minheal"]) then
			if (class == "PALADIN") or (class == "MAGE") then
				if (returndata["crithealchance"]) then
					if (returndata["illum"] ~= 0) and (returndata["mindamage"]) then
						returndata["manacost2"] = returndata["manacost"]
					end
					returndata["manacost"] = returndata["manacost"]-returndata["manacost"]*((returndata["crithealchance"]/100)*returndata["illum"])
				end
			end
			if returndata["maxheal"] == nil then
				returndata["maxheal"] = returndata["minheal"]
			end
			returndata["averagehealnocrit"] = (returndata["maxheal"]-returndata["minheal"])/2+returndata["minheal"]
			returndata["averagehpsdamnocrit"] = returndata["damfinal"]
			if spelldata.cancrit then
				if returndata["crithealchance"] == nil then returndata["crithealchance"] = 0 end
				returndata["crithealmin"] = returndata["minheal"]*(returndata["critbonus"]+1)
				returndata["crithealmax"] = returndata["maxheal"]*(returndata["critbonus"]+1)
				returndata["averagecritheal"] = returndata["averagehealnocrit"]*returndata["critbonus"]
				returndata["nextcrit"] = returndata["averagecritheal"]/100
				returndata["healworth"] = returndata["damcoef"]*(1+returndata["crithealchance"]*returndata["critbonus"]/100)
				returndata["averageheal"] = returndata["averagehealnocrit"]+returndata["averagecritheal"]*returndata["crithealchance"]/100
				returndata["nextcritheal"] = returndata["averagecritheal"]/100
				returndata["nextcrithealequive"] = returndata["nextcritheal"]/returndata["healworth"]
			else
				returndata["averagecritheal"] = 0
				returndata["averageheal"] = returndata["averagehealnocrit"]
				returndata["healworth"] = returndata["damcoef"]
			end
			returndata["averagehealthreat"] = returndata["averageheal"]*returndata["threat"]
			returndata["averagehealthreatpercent"] = returndata["averagehealthreat"]/returndata["averageheal"]*100
			returndata["averagehpsdam"] = returndata["averagehpsdamnocrit"]*(returndata["averageheal"]/returndata["averagehealnocrit"])
			if spelldata.tickinterval then
				if (spelldata.hasdot) and (returndata["hotheal"]) then
					returndata["averagehealtick"] = returndata["hotheal"]/returndata["dotduration"]*spelldata.tickinterval
				else
					if returndata["manamultiplier"] then
						returndata["averagehealtick"] = returndata["averageheal"]/returndata["manamultiplier"]/returndata["dotduration"]*spelldata.tickinterval
					else
						returndata["averagehealtick"] = returndata["averageheal"]/returndata["dotduration"]*spelldata.tickinterval
					end
				end
			end
			if TheoryCraft_Settings["dontcrithpm"] then
				returndata["hpm"] = returndata["averagehealnocrit"]/returndata["manacost"]
			else
				returndata["hpm"] = returndata["averageheal"]/returndata["manacost"]
			end
			if (TheoryCraft_Data.Stats["lifetapMana"]) and (TheoryCraft_Data.Stats["lifetapHealth"]) then
				returndata["lifetaphpm"] = returndata["hpm"]*returndata["manacost"]/(returndata["manacost"]/TheoryCraft_Data.Stats["lifetapMana"]*TheoryCraft_Data.Stats["lifetapHealth"])
			end
			if (TheoryCraft_Settings["dotoverct"]) and (spelldata.isdot) then
				returndata["hps"] = returndata["averageheal"]/returndata["casttime"]
				returndata["hpsdam"] = returndata["averagehpsdam"]/returndata["casttime"]
			else
				if spelldata.isdot then
					returndata["hps"] = returndata["averageheal"]/returndata["dotduration"]
					returndata["hpsdam"] = returndata["averagehpsdam"]/returndata["dotduration"]
				else
					returndata["hps"] = returndata["averageheal"]/returndata["casttime"]
					returndata["hpsdam"] = returndata["averagehpsdam"]/returndata["casttime"]
				end
			end
			if TheoryCraft_Data.Stats["lifetapMana"] then
				returndata["lifetaphps"] = returndata["averageheal"]/(returndata["casttime"]+(returndata["manacost"]/TheoryCraft_Data.Stats["lifetapMana"])*1.5)
			end

			if returndata["hotheal"] then
				returndata["withhothpm"] = (returndata["hpm"]*returndata["manacost"]+returndata["hotheal"])/returndata["manacost"]
				if (TheoryCraft_Settings["combinedot"]) then
					returndata["withhothps"] = (returndata["averageheal"]+returndata["hotheal"])/returndata["casttime"]
				else
					returndata["withhothps"] = returndata["hotheal"]/returndata["dotduration"]
				end
			end

			if spelldata.isdot then
				returndata["dameff"] = returndata["damcoef"]*returndata["baseincrease"]/returndata["dotduration"]*3.5
			else
				if returndata["damcoef2"] then
					returndata["dameff"] = ((returndata["damcoef"]+returndata["damcoef2"])*returndata["baseincrease"])/returndata["casttime"]*3.5
				else
					returndata["dameff"] = returndata["damcoef"]*returndata["baseincrease"]/returndata["casttime"]*3.5
				end
			end
			if spelldata.dontdomax == nil then
				returndata["maxoomheal"] = (TheoryCraft_Data.Stats["totalmana"]+TheoryCraft_GetStat("manarestore"))*returndata["hpm"]
				returndata["maxoomhealtime"] = returndata["maxoomheal"]/returndata["hps"]
				if returndata["maxtotalmana"] then
					returndata["maxevocoomheal"] = TheoryCraft_Data.Stats["maxtotalmana"]*returndata["hpm"]
					returndata["maxevocoomhealtime"] = returndata["maxevocoomheal"]/returndata["hps"]+8
				end
			end
			returndata["regenheal"] = TheoryCraft_Data.Stats["regen"]*10*returndata["hpm"]
			returndata["icregenheal"] = TheoryCraft_Data.Stats["icregen"]*10*returndata["hpm"]
			if returndata["manamultiplier"] then
				returndata["averageheal"] = returndata["averageheal"]/returndata["manamultiplier"]
				returndata["averagehealnocrit"] = returndata["averagehealnocrit"]/returndata["manamultiplier"]
				returndata["averagehealthreat"] = returndata["averagehealthreat"]/returndata["manamultiplier"]
			end
		end
	end
	if (returndata["dps"]) then
		if (returndata["dpsdam"]) then
			returndata["dpsdampercent"] = returndata["dpsdam"]/returndata["dps"]*100
		end
	end
	if (returndata["hps"]) then
		if (returndata["hpsdam"]) then
			returndata["hpsdampercent"] = returndata["hpsdam"]/returndata["hps"]*100
		end
	end
	if (returndata["manamultiplier"]) then
		returndata["manacost"] = returndata["manacost"]/returndata["manamultiplier"]
	end
	if (spelldata.manamultiplier) and (returndata["damcoef"]) and (spelldata.lightningshield == nil) then 
		returndata["damcoef"] = returndata["damcoef"]/spelldata.manamultiplier
	end

	if (returndata["nextcritdam"]) and (returndata["critdmgchance"]) and (returndata["critdmgchance"] > 99) then
		if returndata["critdmgchance"] < 100 then
			returndata["nextcritdam"] = returndata["nextcritdam"]*(1 - (returndata["critdmgchance"] - 99))
			returndata["nextcritdamequive"] = returndata["nextcritdamequive"]*(1 - (returndata["critdmgchance"] - 99))
		else
			returndata["nextcritdam"] = 0
			returndata["nextcritdamequive"] = 0
		end
	end
	if (returndata["nextcritheal"]) and (returndata["crithealchance"]) and (returndata["crithealchance"] > 99) then
		if returndata["crithealchance"] < 100 then
			returndata["nextcritheal"] = returndata["nextcritheal"]*(1 - (returndata["crithealchance"] - 99))
			returndata["nextcrithealequive"] = returndata["nextcrithealequive"]*(1 - (returndata["crithealchance"] - 99))
		else
			returndata["nextcritheal"] = 0
			returndata["nextcrithealequive"] = 0
		end
	end

	CleanUp(spelldata, returndata)

	if returndata["basemindamage"] then
		if returndata["basemaxdamage"] == nil then
			returndata["basemaxdamage"] = returndata["basemindamage"]
		end
		returndata["damtodouble"] = (returndata["basemindamage"]+returndata["basemaxdamage"])/2/returndata["damcoef"]
	end

	if returndata["damcoef"] then returndata["damcoef"] = returndata["damcoef"]*100 end
	if returndata["dameff"] then returndata["dameff"] = returndata["dameff"]*100 end
	
	if returndata["dps"] and returndata["manacost"] then
		returndata["dpsmana"] = returndata["dps"]/returndata["manacost"]
	end
	if returndata["manacost"] then
		returndata["maxspellcasts"] = 1+math.floor((TheoryCraft_GetStat("totalmana")-(returndata["basemanacost"] or returndata["manacost"]))/returndata["manacost"])
		if returndata["maxoomdam"] then
			returndata["maxoomdamfloored"] = returndata["dpm"]*returndata["manacost"]*returndata["maxspellcasts"]
		end
		if returndata["maxoomheal"] then
			returndata["maxoomhealfloored"] = returndata["hpm"]*returndata["manacost"]*returndata["maxspellcasts"]
		end
	end

	return
end

function TheoryCraft_GenerateTooltip(frame, spellname, spellrank, i2, showonbutton, macro, force)
	local timer = GetTime()
	local oldspellname = spellname
	local olddesc
	if i2 == nil then
		if (frame) and (frame ~= TCTooltip2) then
			if frame:NumLines() == 0 then return end
			i2 = 1
			if getglobal(frame:GetName().."TextRight1") and getglobal(frame:GetName().."TextRight1"):IsVisible() then
				spellrank = getglobal(frame:GetName().."TextRight1"):GetText()
				spellrank = tonumber(findpattern(spellrank, "%d+"))
				if spellrank == nil then spellrank = 0 end
			else
				spellrank = nil
			end
			if getglobal(frame:GetName().."TextLeft1") and getglobal(frame:GetName().."TextLeft1"):GetText() then
				spellname = getglobal(frame:GetName().."TextLeft1"):GetText()
			else
				spellname = ""
			end
			local spellname2, spellrank2
			while (true) do
				spellname2, spellrank2 = GetSpellName(i2,BOOKTYPE_SPELL)
				if spellname2 == nil then return end
				spellrank2 = tonumber(findpattern(spellrank2, "%d+"))
				if spellrank2 == nil then spellrank2 = 0 end
				if (spellname == spellname2) and ((spellrank == nil) or (spellrank == spellrank2)) then break end
				i2 = i2 + 1
			end
			if spellname ~= spellname2 then return end
			if (spellrank) and (spellrank ~= spellrank2) then return end
			if (spellname == "Attack") then spellrank = 0 end
			if (spellrank == nil) then
				olddesc = getglobal(frame:GetName().."TextLeft"..frame:NumLines()):GetText()
				while (spellname == spellname2) do
					spellname2, spellrank = GetSpellName(i2,BOOKTYPE_SPELL)
					if spellname == nil then return end
					spellrank = tonumber(findpattern(spellrank, "%d+"))
					if spellrank == nil then spellrank = 0 end
					TCTooltip:SetOwner(UIParent,"ANCHOR_NONE")
					TCTooltip:SetSpell(i2,BOOKTYPE_SPELL)
					if (getglobal("TCTooltipTextLeft"..TCTooltip:NumLines())) and (getglobal("TCTooltipTextLeft"..TCTooltip:NumLines()):GetText() == olddesc) then
						break
					end
					i2 = i2 + 1
				end
				if (TCTooltip) and (getglobal("TCTooltipTextLeft"..TCTooltip:NumLines())) and (getglobal("TCTooltipTextLeft"..TCTooltip:NumLines()):GetText() ~= olddesc) then
					return
				end
			end
		else
			i2 = 1
			local spellname2, spellrank2
			if (string.len(spellrank) == 1) and (string.len(spellname) ~= 13) then
				macro = nil
			end
			if (string.len(spellrank) == 2) and (string.len(spellname) ~= 12) then
				macro = nil
			end
			while (true) do
				spellname2, spellrank2 = GetSpellName(i2,BOOKTYPE_SPELL)
				if spellname2 == nil then return end
				spellrank2 = tonumber(findpattern(spellrank2, "%d+"))
				if spellrank2 == nil then spellrank2 = 0 end
				if (spellname == spellname2) or ((macro) and (spellname == string.sub(spellname2, 1, string.len(spellname)))) then 
					spellname = spellname2
					if spellrank == spellrank2 then
						break
					end
				end
				i2 = i2 + 1
			end
			if spellname ~= spellname2 then return end
			if spellrank ~= spellrank2 then return end
			if frame == nil then
				frame = TCTooltip
			end
			frame:SetOwner(UIParent,"ANCHOR_NONE")
			frame:SetSpell(i2,BOOKTYPE_SPELL)
			if frame:NumLines() == 0 then return end
		end
	end
	if spellname == TheoryCraft_Locale.MinMax.autoshotname then
		local highestaimed, highestmulti, highestarcane
		local i2 = 1
		local spellname, spellrank = GetSpellName(i2,BOOKTYPE_SPELL)
		while (spellname) do
			spellrank = tonumber(findpattern((spellrank or "0"), "%d+"))
			if (spellname == TheoryCraft_Locale.MinMax.aimedshotname) and ((highestaimed == nil) or (highestaimed < spellrank)) then
				highestaimed = spellrank
			end
			if (spellname == TheoryCraft_Locale.MinMax.multishotname) and ((highestmulti == nil) or (highestmulti < spellrank)) then
				highestmulti = spellrank
			end
			if (spellname == TheoryCraft_Locale.MinMax.arcaneshotname) and ((highestarcane == nil) or (highestarcane < spellrank)) then
				highestarcane = spellrank
			end
			i2 = i2 + 1
			spellname, spellrank = GetSpellName(i2,BOOKTYPE_SPELL)
		end
		if (highestaimed) and (TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.aimedshotname.."("..highestaimed..")"] == nil) then
			TheoryCraft_GenerateTooltip(TCTooltip2, TheoryCraft_Locale.MinMax.aimedshotname, highestaimed, nil, nil, nil, true)
		end
		if (highestmulti) and (TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.multishotname.."("..highestmulti..")"] == nil) then
			TheoryCraft_GenerateTooltip(TCTooltip2, TheoryCraft_Locale.MinMax.multishotname, highestmulti, nil, nil, nil, true)
		end
		if (highestarcane) and (TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.arcaneshotname.."("..highestarcane..")"] == nil) then
			TheoryCraft_GenerateTooltip(TCTooltip2, TheoryCraft_Locale.MinMax.arcaneshotname, highestarcane, nil, nil, nil, true)
		end
	end
	if (not force) and (TheoryCraft_Settings["GenerateList"] ~= "") and (not string.find(TheoryCraft_Settings["GenerateList"], string.gsub(spellname, "-", "%%-").."%("..spellrank.."%)")) then
		return
	end
	local i
	for k, v in pairs(TheoryCraft_Spells[class]) do
		if v.name == spellname then
			i = v
			break
		end
	end
	if not i then return end
--	TheoryCraft_Data.Testing = nil
	SummateData(i.id, i.Schools)
	olddesc = getglobal(frame:GetName().."TextLeft"..frame:NumLines()):GetText()

	if TheoryCraft_TooltipData[olddesc] == nil then
		TheoryCraft_TooltipData[olddesc] = {}
	end
	TheoryCraft_DeleteTable(TheoryCraft_TooltipData[olddesc])
	TheoryCraft_CopyTable(summeddata, TheoryCraft_TooltipData[olddesc])
	if TheoryCraft_TooltipData[olddesc]["schools"] == nil then
		TheoryCraft_TooltipData[olddesc]["schools"] = {}
	end
	TheoryCraft_CopyTable(i.Schools, TheoryCraft_TooltipData[olddesc]["schools"])
	GenerateTooltip(frame, TheoryCraft_TooltipData[olddesc], i, spellrank)
	if macro then
		TheoryCraft_TooltipData[oldspellname.."MACRO("..spellrank..")"] = olddesc
	end
	TheoryCraft_TooltipData[spellname.."("..spellrank..")"] = olddesc
	TheoryCraft_TooltipData[olddesc]["basedescription"] = olddesc
	if (i.shoot) or (i.ismelee) or (i.isranged) then
		if getglobal(frame:GetName().."TextLeft2") then
			TheoryCraft_TooltipData[olddesc]["wandlineleft2"] = getglobal(frame:GetName().."TextLeft2"):GetText()
		end
		if getglobal(frame:GetName().."TextRight2") and getglobal(frame:GetName().."TextRight2"):IsVisible() then
			TheoryCraft_TooltipData[olddesc]["wandlineright2"] = getglobal(frame:GetName().."TextRight2"):GetText()
		end
		if getglobal(frame:GetName().."TextLeft3") and getglobal(frame:GetName().."TextLeft3"):IsVisible() then
			TheoryCraft_TooltipData[olddesc]["wandlineleft3"] = getglobal(frame:GetName().."TextLeft3"):GetText()
		end
		if getglobal(frame:GetName().."TextRight3") and getglobal(frame:GetName().."TextRight3"):IsVisible() then
			TheoryCraft_TooltipData[olddesc]["wandlineright3"] = getglobal(frame:GetName().."TextRight3"):GetText()
		end
		if getglobal(frame:GetName().."TextLeft4") then
			if getglobal(frame:GetName().."TextLeft4"):GetText() ~= olddesc then
				TheoryCraft_TooltipData[olddesc]["wandlineleft4"] = getglobal(frame:GetName().."TextLeft4"):GetText()
			end
		end
	else
		if getglobal(frame:GetName().."TextLeft3") then
			if (getglobal(frame:GetName().."TextLeft3"):GetText()) then
				if (getglobal(frame:GetName().."TextLeft3"):GetText() ~= olddesc) and (strfind(getglobal(frame:GetName().."TextLeft3"):GetText(), (TheoryCraft_Locale.CooldownRem) or "Cooldown remaining: ") == nil) then
					TheoryCraft_TooltipData[olddesc]["basecasttime"] = getglobal(frame:GetName().."TextLeft3"):GetText()
				end
			end
		end
		if getglobal(frame:GetName().."TextRight2") and getglobal(frame:GetName().."TextRight2"):IsVisible() then
			TheoryCraft_TooltipData[olddesc]["spellrange"] = getglobal(frame:GetName().."TextRight2"):GetText()
		end
		if getglobal(frame:GetName().."TextRight3") and getglobal(frame:GetName().."TextRight3"):IsVisible() then
			TheoryCraft_TooltipData[olddesc]["cooldown"] = getglobal(frame:GetName().."TextRight3"):GetText()
			if (i.overcooldown) and (TheoryCraft_TooltipData[olddesc]["averagedam"]) then
				if (strfind(TheoryCraft_TooltipData[olddesc]["cooldown"], "%d+.%d+"..TheoryCraft_Locale.Cooldown)) then
					TheoryCraft_TooltipData[olddesc]["dps"] = TheoryCraft_TooltipData[olddesc]["averagedam"]/tonumber(findpattern(TheoryCraft_TooltipData[olddesc]["cooldown"], "%d+.%d+"))
				elseif (strfind(TheoryCraft_TooltipData[olddesc]["cooldown"], "%d+"..TheoryCraft_Locale.Cooldown)) then
					TheoryCraft_TooltipData[olddesc]["dps"] = TheoryCraft_TooltipData[olddesc]["averagedam"]/tonumber(findpattern(TheoryCraft_TooltipData[olddesc]["cooldown"], "%d+"))
				end
			end
		end
	end
	TheoryCraft_TooltipData[olddesc]["spellname"] = spellname
	TheoryCraft_TooltipData[olddesc]["spellrank"] = spellrank
	TheoryCraft_TooltipData[olddesc]["spellnumber"] = i2
	TheoryCraft_TooltipData[olddesc]["dontdpsafterresists"] = i.dontdpsafterresists
	TheoryCraft_TooltipData[olddesc]["isheal"] = i.isheal
	TheoryCraft_TooltipData[olddesc]["iscombo"] = i.iscombo
	TheoryCraft_TooltipData[olddesc]["cancrit"] = i.cancrit
	TheoryCraft_TooltipData[olddesc]["shoot"] = i.shoot
	TheoryCraft_TooltipData[olddesc]["ismelee"] = i.ismelee
	TheoryCraft_TooltipData[olddesc]["isranged"] = i.isranged
	TheoryCraft_TooltipData[olddesc]["autoshot"] = i.autoshot
	TheoryCraft_TooltipData[olddesc]["armor"] = i.armor
	TheoryCraft_TooltipData[olddesc]["binary"] = i.binary
	TheoryCraft_TooltipData[olddesc]["dodps"] = i.dodps
	TheoryCraft_TooltipData[olddesc]["isseal"] = i.isseal
	TheoryCraft_TooltipData[olddesc]["drain"] = i.drain
	TheoryCraft_TooltipData[olddesc]["holynova"] = i.holynova
	TheoryCraft_TooltipData[olddesc]["dontdomax"] = i.dontdomax
	TheoryCraft_TooltipData[olddesc]["overcd"] = i.overcooldown
	if (TheoryCraft_Settings["GenerateList"] == "") or (string.find(TheoryCraft_Settings["GenerateList"], string.gsub(spellname, "-", "%%-").."%("..spellrank.."%)")) then
		TheoryCraft_TooltipData[olddesc]["showonbutton"] = true
	end
	if TheoryCraft_Data["reporttimes"] then
		TheoryCraft_Data["buttonsgenerated"] = TheoryCraft_Data["buttonsgenerated"]+1
		TheoryCraft_Data["timetaken"] = TheoryCraft_Data["timetaken"]+GetTime()-timer
	end
end

local data2 = {}

local function UpdateTarget(data)
	if data == nil then return end
	data["resistscore"] = 0
	if data["basemanacost"] and data["manacost"] then
		if UnitMana("player") >= data["basemanacost"] then
			data["spellcasts"] = 1+math.floor((UnitMana("player")-(data["basemanacost"] or data["manacost"]))/data["manacost"])
			if data["dpm"] and data["maxoomdam"] then
				data["maxoomdamremaining"] = data["dpm"]*data["manacost"]*data["spellcasts"]
			end
			if data["hpm"] and data["maxoomheal"] then
				data["maxoomhealremaining"] = data["hpm"]*data["manacost"]*data["spellcasts"]
			end
		else
			data["spellcasts"] = 0
			if data["maxoomdam"] then
				data["maxoomdamremaining"] = 0
			end
			if data["maxoomheal"] then
				data["maxoomdamremaining"] = 0
			end
		end
	end

	if data.iscombo then
		if data["description"] == nil then return end
		local points = GetComboPoints()
		data["mindamage"] = data["combo"..points.."mindamage"] or 0
		data["maxdamage"] = data["combo"..points.."maxdamage"] or 0
		if (data["comboconvert"]) and (points > 0) then
			local add = (UnitMana("player")-35)*data["comboconvert"]
			data["mindamage"] = data["mindamage"]+add
			data["maxdamage"] = data["maxdamage"]+add
		end
		data["critdmgmin"] = data["mindamage"]*(data["critbonus"]+1)
		data["critdmgmax"] = data["maxdamage"]*(data["critbonus"]+1)
		data["averagedamnocrit"] = (data["maxdamage"]+data["mindamage"])/2
		data["averagecritdam"] = data["averagedamnocrit"]*data["critbonus"]
		data["averagedam"] = data["averagedamnocrit"]+data["averagecritdam"]*(data["critdmgchance"] or 0)/100
		data["description"] = data["beforecombo"]
		local search = TheoryCraft_MeleeComboReader
		search = string.gsub(search, "%(%%d%+%)", points, 1)
		local replace = TheoryCraft_MeleeComboReplaceWith
		replace = "%*"..string.gsub(replace, "%$points%$", points).."%*"
		data["description"] = string.gsub(data["description"], search, replace)
	end
	if data["isheal"] then return end
	if data["armor"] and TheoryCraft_Settings["mitigation"] then
		TheoryCraft_DeleteTable(data2)
		TheoryCraft_CopyTable(data, data2)
		data = data2

		local armormult = TheoryCraft_Data.armormultinternal
		if data["description"] then
			if data["mindamage"] then
				data["description"] = string.gsub(data["description"], round(data["mindamage"]), round(data["mindamage"]*armormult))
			end
				if data["maxdamage"] then
				data["description"] = string.gsub(data["description"], round(data["maxdamage"]), round(data["maxdamage"]*armormult))
			end
		end

		if data["mindamage"] then data["mindamage"] = data["mindamage"]*armormult end
		if data["maxdamage"] then data["maxdamage"] = data["maxdamage"]*armormult end
		if data["critdmgmin"] then data["critdmgmin"] = data["critdmgmin"]*armormult end
		if data["critdmgmax"] then data["critdmgmax"] = data["critdmgmax"]*armormult end
		if data["nextstrdam"] then data["nextstrdam"] = data["nextstrdam"]*armormult end
		if data["nextagidam"] then data["nextagidam"] = data["nextagidam"]*armormult end
		if data["nexthitdam"] then data["nexthitdam"] = data["nexthitdam"]*armormult end
		if data["nextcritdam"] then data["nextcritdam"] = data["nextcritdam"]*armormult end
		if data["dpm"] then data["dpm"] = data["dpm"]*armormult end
		if data["dps"] then data["dps"] = data["dps"]*armormult end
		if data["averagedam"] then data["averagedam"] = data["averagedam"]*armormult end
		if data["averagedamnocrit"] then data["averagedamnocrit"] = data["averagedamnocrit"]*armormult end
		if data["maxoomdam"] then data["maxoomdam"] = data["maxoomdam"]*armormult end
		if data["maxoomdamremaining"] then data["maxoomdamremaining"] = data["maxoomdamremaining"]*armormult end
		if data["maxoomdamfloored"] then data["maxoomdamfloored"] = data["maxoomdamfloored"]*armormult end


		if data["asrotationdps"] then data["asrotationdps"] = data["asrotationdps"]*armormult end
		if data["msrotationdps"] then data["asrotationdps"] = data["asrotationdps"]*armormult end
		if data["arcrotationdps"] then data["arcrotationdps"] = (data["arcrotationdps"] - (data["arcmagicdps"] or 0))*armormult + (data["arcmagicdps"] or 0) end

		return data
	end
	if data["ismelee"] then return end
	if data["isseal"] then return end
	if data["autoshot"] then return end

	local penamount = 0
	if data["schools"] then
		for k, v in pairs(data["schools"]) do
			penamount = penamount + TheoryCraft_GetStat(v.."penetration")
			for k, v2 in pairs(TheoryCraft_PrimarySchools) do
				if (type(v2) == "table") and (v2.name == v) and (TheoryCraft_Settings["resistscores"][v2.name]) then
					if TheoryCraft_Settings["resistscores"][v2.name] == "~" then
						data["resistscore"] = data["resistscore"]+1000
					else
						data["resistscore"] = data["resistscore"]+TheoryCraft_Settings["resistscores"][v2.name]
					end
				end
			end
		end
	end
	if data["resistscore"] > 0 then
		if data["resistscore"] < penamount then
			data["resistscore"] = 0
		else
			data["resistscore"] = data["resistscore"]-penamount
		end
	end
	penamount = data["resistscore"]
	if penamount < 0 then
		penamount = 0
	end

	data["resistscore"] = data["resistscore"]/(UnitLevel("player")*20/3)
	if (data["resistscore"] > 0.75) and (data["resistscore"] < 2.5) then
		data["resistscore"] = 0.75
	end

	data["resistlevel"] = UnitLevel("target")
	local playerlevel = UnitLevel("player")
	if data["resistlevel"] == -1 then
		data["resistlevel"] = 63
	end
	if data["resistlevel"] == 0 then
		data["resistlevel"] = playerlevel
	end
	data["resistrate"] = data["resistlevel"]-playerlevel
	if UnitIsPlayer("target") then
		if (data["resistrate"] < -2) then
			data["resistrate"] = 1
		elseif (data["resistrate"] == -2) then
			data["resistrate"] = 2
		elseif (data["resistrate"] == -1) then
			data["resistrate"] = 3
		elseif (data["resistrate"] == 0) then
			data["resistrate"] = 4
		elseif (data["resistrate"] == 1) then
			data["resistrate"] = 5
		elseif (data["resistrate"] == 2) then
			data["resistrate"] = 6
		elseif (data["resistrate"] > 2) then
			data["resistrate"] = 13+(data["resistrate"]-3)*7
		end
	else
		if (data["resistrate"] < -2) then
			data["resistrate"] = 1
		elseif (data["resistrate"] == -2) then
			data["resistrate"] = 2
		elseif (data["resistrate"] == -1) then
			data["resistrate"] = 3
		elseif (data["resistrate"] == 0) then
			data["resistrate"] = 4
		elseif (data["resistrate"] == 1) then
			data["resistrate"] = 5
		elseif (data["resistrate"] == 2) then
			data["resistrate"] = 6
		elseif (data["resistrate"] > 2) then
			data["resistrate"] = 17+(data["resistrate"]-3)*11
		end
	end
	if (data["resistrate"] > 99) then
		data["resistrate"] = 99
	end
	data["resistrate"] = data["resistrate"]+(data["hitbonus"] or 0)
	local toomuchhit
	if (data["resistrate"] < 2) then
		toomuchhit = 1
		data["resistrate"] = 1
	end
	local damworth
	if (data["nexthitdam"]) and (not data["dontdpsafterresists"]) then

		local misschance = data["resistrate"]

		local critchance = (data["critchance"] or 0)
		if (misschance + critchance) > 100 then
			critchance = 100-misschance
		end
		local hitchance = 100-critchance-misschance

		local averagehitdam = (data["averagedamnocrit"] or 0)*(data["manamultiplier"] or 1)
		local averagecritdam = ((data["averagedamnocrit"] or 0)*(data["manamultiplier"] or 1)+(data["averagecritdam"] or 0))
		if TheoryCraft_Settings["dontcrit"] then
			hitchance = hitchance + critchance
			critchance = 0
		end
		hitchance = hitchance/100*averagehitdam
		critchance = critchance/100*averagecritdam
		data["dpsafterresists"] = round((hitchance+critchance)/data["casttime"], 1)
	end

	if not TheoryCraft_Settings["dontresist"] then
		return
	end
	TheoryCraft_DeleteTable(data2)
	TheoryCraft_CopyTable(data, data2)
	data = data2

	local resistmult = (1-data["resistscore"])
	if data["binary"] then
		if resistmult > 1 then
			resistmult = 1
		end
	end
	if resistmult < 0 then
		resistmult = 0
		penamount = 0
	end

	if data["nextcritdam"] then data["nextcritdam"] = data["nextcritdam"] * resistmult end
	if data["nexthitdam"] then data["nexthitdam"] = data["nexthitdam"] * resistmult end

	if data["overcd"] == nil then
		if data["dps"] and data["dpsafterresists"] then
			resistmult = resistmult * data["dpsafterresists"]/data["dps"]
			data["dps"] = data["dpsafterresists"]
		end
	end
	if data["binary"] then
		data["resistrate"] = data["resistrate"] + data["resistscore"]*100
		if data["resistrate"] > 100 then
			data["resistrate"] = 100
		end
	end

	if data["damworth"] then data["damworth"] = data["damworth"] * resistmult end

	if penamount < 10 then
		if data["nextpendam"] then
			data["nextpendam"] = data["nextpendam"] * (penamount/10)
		end
	end
	data["dontshowupto"] = ""

	if data["nexthitdamequive"] and data["nexthitdam"] and data["damworth"] then data["nexthitdamequive"] = data["nexthitdam"] / data["damworth"] end
	if data["nextcritdamequive"] and data["nextcritdam"] and data["damworth"] then data["nextcritdamequive"] = data["nextcritdam"] / data["damworth"] end
	if data["nextpendamequive"] and data["nextpendam"] and data["damworth"] then data["nextpendamequive"] = data["nextpendam"] / data["damworth"] end

	if data["damworth"] == 0 then data["nexthitdamequive"] = 0 end
	if data["damworth"] == 0 then data["nextcritdamequive"] = 0 end

	if data["dps"] then data["dps"] = data["dps"] * resistmult end
	if data["withdotdps"] then data["withdotdps"] = data["withdotdps"] * resistmult end
	if data["dpsdam"] then data["dpsdam"] = data["dpsdam"] * resistmult end
	if data["averagedam"] then data["averagedam"] = data["averagedam"] * resistmult end
	if data["averagedamnocrit"] then data["averagedamnocrit"] = data["averagedamnocrit"] * resistmult end
	if data["dpm"] then data["dpm"] = data["dpm"] * resistmult end
	if data["withdotdpm"] then data["withdotdpm"] = data["withdotdpm"] * resistmult end
	if data["maxoomdam"] then data["maxoomdam"] = data["maxoomdam"] * resistmult end
	if data["maxevocoomdam"] then data["maxevocoomdam"] = data["maxevocoomdam"] * resistmult end
	if toomuchhit then data["nexthitdam"] = 0 data["nexthitdamequive"] = "At max, 0.00" end
	if penamount == 0 then data["nextpendamequive"] = "At max, 0.00" end
	return data
end

function TheoryCraft_GetSpellDataByFrame(frame, force)
	if frame == nil then return nil end
	if frame:NumLines() == 0 then return nil end
	if getglobal(frame:GetName().."TextLeft"..frame:NumLines()) == nil then return nil end
	local desc = getglobal(frame:GetName().."TextLeft"..frame:NumLines()):GetText()
	if (frame:NumLines() == 1) and (desc ~= "Attack") then
		local pos = strfind(desc, "%(%d+%)")
		if not pos then return nil end
		local data = TheoryCraft_GetSpellDataByName(string.sub(desc, 1, pos-1), tonumber(string.sub(desc, pos+1, string.len(desc)-1)), force, true)
		if data == nil then return nil end
		if data.spellnumber == nil then return nil end
		frame:SetSpell(data.spellnumber,BOOKTYPE_SPELL)
		return data
	end
	if TheoryCraft_TooltipData[desc] and TheoryCraft_TooltipData[desc].spellname then
		return UpdateTarget(TheoryCraft_TooltipData[desc]) or TheoryCraft_TooltipData[desc]
	end
	TheoryCraft_GenerateTooltip(frame, nil, nil, nil, true, nil, force)
	return UpdateTarget(TheoryCraft_TooltipData[desc]) or TheoryCraft_TooltipData[desc]
end

function TheoryCraft_GetSpellDataByName(spellname, spellrank, force, macro)
	if spellrank == nil then spellrank = 0 end
	local description = TheoryCraft_TooltipData[spellname.."("..spellrank..")"] or (macro and TheoryCraft_TooltipData[spellname.."MACRO("..spellrank..")"])
	if (description) then
		if TheoryCraft_TooltipData[description] and TheoryCraft_TooltipData[description].spellname then
			return UpdateTarget(TheoryCraft_TooltipData[description]) or TheoryCraft_TooltipData[description]
		end
	end
	TheoryCraft_GenerateTooltip(nil, spellname, spellrank, nil, true, macro)
	if TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."("..spellrank..")"]] and TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."("..spellrank..")"]].spellname then
		return UpdateTarget(TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."("..spellrank..")"]]) or TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."("..spellrank..")"]]
	elseif TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."MACRO("..spellrank..")"]] and TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."MACRO("..spellrank..")"]].spellname then
		return UpdateTarget(TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."MACRO("..spellrank..")"]]) or TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."MACRO("..spellrank..")"]]
	end
end

function TheoryCraft_GetSpellDataByDescription(description, force)
	if TheoryCraft_TooltipData[description] and TheoryCraft_TooltipData[description].spellname then
		return UpdateTarget(TheoryCraft_TooltipData[description]) or TheoryCraft_TooltipData[description]
	end
	if (force ~= true) and (TheoryCraft_Settings["GenerateList"] ~= "") then
		return
	end
	local i = 1
	local spellname, spellrank
	local testdesc
	while (true) do
		spellname, spellrank = GetSpellName(i,BOOKTYPE_SPELL)
		if spellname == nil then break end
		spellrank = tonumber(findpattern(spellrank, "%d+"))
		if spellrank == nil then spellrank = 0 end
		TCTooltip:SetOwner(UIParent,"ANCHOR_NONE")
		TCTooltip:SetSpell(i,BOOKTYPE_SPELL)
		testdesc = getglobal("TCTooltipTextLeft"..TCTooltip:NumLines()):GetText()
		if testdesc == description then
			TheoryCraft_GenerateTooltip(TCTooltip, spellname, spellrank, i, true)
			return UpdateTarget(TheoryCraft_TooltipData[description]) or TheoryCraft_TooltipData[description]
		end
		i = i + 1
	end
end

function TheoryCraft_GenerateAll()
	TheoryCraft_DeleteTable(TheoryCraft_TooltipData)
	TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	if TheoryCraft_UpdateOutfitTab then TheoryCraft_UpdateOutfitTab() end
end
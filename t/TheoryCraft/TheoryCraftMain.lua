-- This lua file is mostly used for initialization

TheoryCraft_TooltipData = {}
TheoryCraft_OldText = {}
TheoryCraft_Data = {}
TheoryCraft_Data.armormult = 1
TheoryCraft_Data.armormultinternal = 1
TheoryCraft_Data.Target = {}
TheoryCraft_Data.BaseData = {}
TheoryCraft_Data.BaseData["Allcritbonus"] = 0.5
TheoryCraft_Data.BaseData["Allthreat"] = 1
TheoryCraft_Data.BaseData["Allmodifier"] = 1
TheoryCraft_Data.BaseData["Allbaseincrease"] = 1
TheoryCraft_Data.BaseData["Huntercritbonus"] = 0.5
TheoryCraft_Data.BaseData["Rangedcritbonus"] = 1
TheoryCraft_Data.BaseData["Rangedmodifier"] = 1
TheoryCraft_Data.BaseData["Rangedbaseincrease"] = 1
TheoryCraft_Data.BaseData["Meleecritbonus"] = 1
TheoryCraft_Data.BaseData["Meleemodifier"] = 1
TheoryCraft_Data.BaseData["Meleebaseincrease"] = 1
TheoryCraft_Data.BaseData["AllUpFrontmodifier"] = 1
TheoryCraft_Data.BaseData["AllUpFrontbaseincrease"] = 1
TheoryCraft_Data.BaseData["manacostall"] = 1
TheoryCraft_Data.Talents = {}
TheoryCraft_Data.Talents["strmultiplier"] = 1
TheoryCraft_Data.Talents["agimultiplier"] = 1
TheoryCraft_Data.Talents["stammultiplier"] = 1
TheoryCraft_Data.Talents["intmultiplier"] = 1
TheoryCraft_Data.Talents["spiritmultiplier"] = 1
TheoryCraft_Data.Talents["manamultiplier"] = 1
TheoryCraft_Data.Talents["healthmultiplier"] = 1
local _, class = UnitClass("player")
local _, race = UnitRace("player")
if (race == "Gnome") then
	TheoryCraft_Data.Talents["intmultiplier"] = 1.05
end
if (race == "Human") then
	TheoryCraft_Data.Talents["spiritmultiplier"] = 1.05
end
if (race == "Tauren") then
	TheoryCraft_Data.Talents["healthmultiplier"] = 1.05
end
TheoryCraft_Data.Talents["strmultiplierreal"] = 1
TheoryCraft_Data.Talents["agimultiplierreal"] = 1
TheoryCraft_Data.Talents["stammultiplierreal"] = 1
TheoryCraft_Data.Talents["intmultiplierreal"] = TheoryCraft_Data.Talents["intmultiplier"]
TheoryCraft_Data.Talents["spiritmultiplierreal"] = TheoryCraft_Data.Talents["spiritmultiplier"]
TheoryCraft_Data.Talents["manamultiplierreal"] = 1
TheoryCraft_Data.Talents["healthmultiplierreal"] = TheoryCraft_Data.Talents["healthmultiplier"]
TheoryCraft_Data.Stats = {}

TheoryCraft_UpdatedButtons = {}

function Print(text, begin, spaces)
	if spaces and string.len(spaces) > 10 then
		return
	end
	if text == nil then text = "nil" end
	if text == true then text = "true" end
	if text == false then text = "false" end
	if type(text) == "function" then
		text = "function ("..tostring(text)..")"
	end
	if type(text) == "table" then
		for k, v in pairs(text) do
			if type(v) == "table" then
				Print(k..": (Table)", "", (spaces or "").."    ")
			end
			Print(v, k..": ", (spaces or "").."    ")
		end
		return
	end
	text = (spaces or "")..(begin or "")..text
	DEFAULT_CHAT_FRAME:AddMessage(text)
end

function TheoryCraft_CopyTable(tab1, tab2)
	for k, v in pairs(tab1) do
		if type(v) == "table" then
			tab2[k] = {}
			TheoryCraft_CopyTable(v, tab2[k])
		else
			tab2[k] = v
		end
	end
end

function TheoryCraft_DeleteTable(tab1)
	for k, v in pairs(tab1) do
		if type(v) == "table" then
			TheoryCraft_DeleteTable(v)
		else
			tab1[k] = nil
		end
	end
end

function TheoryCraftCast(spellname, overheal)
	if UnitHealthMax("target") == 100 then
		CastSpellByName(spellname)
		return
	end
	if overheal == nil then overheal = 1 end
	local u, highest, s = UnitHealthMax("target")-UnitHealth("target"), 1
	u = u * overheal
	for i = 1,20 do
		s = TheoryCraft_GetSpellDataByName(spellname, i)
		if (s) and (s.averagehealnocrit) and (s.averagehealnocrit > u) then
			CastSpellByName(spellname.."(Rank "..i..")")
			return
		end
	end
	CastSpellByName(spellname)
end

local function round(arg1, decplaces)
	if (decplaces == nil) then decplaces = 0 end
	if arg1 == nil then arg1 = 0 end
	return string.format ("%."..decplaces.."f", arg1)
end

function TheoryCraft_WatchCritRate(arg1)
	local _, _, hit = strfind(arg1, "Your (.+) heals ")
	local _, _, crit= strfind(arg1, "Your (.+) critically")
	if (not hit) and (not crit) then return end
	if crit then hit = crit end
	local foundcc
	for k = 1,20 do
		if TheoryCraft_TooltipData[hit.."("..k..")"] then
			foundcc = TheoryCraft_TooltipData[TheoryCraft_TooltipData[hit.."("..k..")"]]["crithealchance"]
		end
	end
	if foundcc == nil then
		return
	end
	if not TheoryCraft_Settings["critchancedata"] then
		TheoryCraft_Settings["critchancedata"] = {}
	end
	if (TheoryCraft_Data.outfit) and (TheoryCraft_Data.outfit ~= -1) and (TheoryCraft_Data.outfit ~= 1) then
		return
	end
	local _, tmp2 = UnitStat("player", 4)
	local tmp = tmp2..":"..(foundcc-TheoryCraft_Data.Stats["critchance"])
	if not TheoryCraft_Settings["critchancedata"][tmp] then
		TheoryCraft_Settings["critchancedata"][tmp] = {}
		TheoryCraft_Settings["critchancedata"][tmp].casts = 0
		TheoryCraft_Settings["critchancedata"][tmp].crits = 0
	end
	TheoryCraft_Settings["critchancedata"][tmp].casts = TheoryCraft_Settings["critchancedata"][tmp].casts+1
	if crit then
		TheoryCraft_Settings["critchancedata"][tmp].crits = TheoryCraft_Settings["critchancedata"][tmp].crits+1
	end
	if class == "PALADIN" then
		if (TheoryCraft_Settings["critchancedata"][tmp].casts == 15000) or ((TheoryCraft_Settings["critchancedata"][tmp].casts > 15000) and (math.floor(TheoryCraft_Settings["critchancedata"][tmp].casts/100) == TheoryCraft_Settings["critchancedata"][tmp].casts/100)) then
			if TheoryCraft_Settings["hidecritdata"] then return end
			local cc = (TheoryCraft_Settings["critchancedata"][tmp].crits/TheoryCraft_Settings["critchancedata"][tmp].casts-(foundcc-TheoryCraft_Data.Stats["critchance"])/100)*100
			Print("You've cast "..TheoryCraft_Settings["critchancedata"][tmp].casts.." heals with "..tmp2.." intellect and +"..(foundcc-TheoryCraft_Data.Stats["critchance"]).." crit chance.")
			Print("Over this you had a base crit rate of "..round((TheoryCraft_Settings["critchancedata"][tmp].crits/TheoryCraft_Settings["critchancedata"][tmp].casts-(foundcc-TheoryCraft_Data.Stats["critchance"])/100)*100,4).."%")
			Print("TC was expecting a base crit rate of "..TheoryCraft_Data.Stats["critchance"].."%")
			Print("*Please* post this info on the Curse Gaming message board for TheoryCraft, as this is a very significant amount of casts,")
			Print("and currently the correct crit formula for Paladins is not known.")
			Print("This message will show every 100 heals from now on.  To hide it, type")
			Print("/tc hidecritdata")
		end
	end
end

local function findpattern(text, pattern, start)
	if (text and pattern and (string.find(text, pattern, start))) then
		return string.sub(text, string.find(text, pattern, start))
	else
		return ""
	end
end

function TheoryCraft_UpdateArmor()
	local oldmit = TheoryCraft_Data.armormultinternal
	TheoryCraft_Data.armormultinternal = 1
	local armor
	if UnitIsPlayer("target") then
		if (TheoryCraft_MitigationPlayers[UnitName("target")]) and (TheoryCraft_MitigationPlayers[UnitName("target")][1]) then
			armor = TheoryCraft_MitigationPlayers[UnitName("target")][1]-TheoryCraft_GetStat("Sunder")
		else
			local unitlevel = UnitLevel("target")
			if unitlevel == -1 then unitlevel = 60 end
			local uc = UnitClass("target")
			if UnitClass("target") == nil then
				return
			end
			for i = 0,60 do
				if (TheoryCraft_MitigationPlayers[uc..":"..unitlevel+i]) and (TheoryCraft_MitigationPlayers[uc..":"..unitlevel+i][1]) then
					armor = TheoryCraft_MitigationPlayers[uc..":"..unitlevel+i][1]-TheoryCraft_GetStat("Sunder")
					break
				end
				if (TheoryCraft_MitigationPlayers[uc..":"..unitlevel-i]) and (TheoryCraft_MitigationPlayers[uc..":"..unitlevel-i][1]) then
					armor = TheoryCraft_MitigationPlayers[uc..":"..unitlevel-i][1]-TheoryCraft_GetStat("Sunder")
					break
				end
			end
		end
	else
		if (TheoryCraft_MitigationMobs[UnitName("target")]) and (TheoryCraft_MitigationMobs[UnitName("target")][1]) then
			armor = TheoryCraft_MitigationMobs[UnitName("target")][1]-TheoryCraft_GetStat("Sunder")
		end
	end
	if armor then
		if armor < 0 then armor = 0 end
		TheoryCraft_Data.armormultinternal = 1 - (armor / (85 * UnitLevel("player") + 400 + armor))
	end
	if TheoryCraft_Data.armormultinternal ~= oldmit then
		TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	end
end

local old = {}

function TheoryCraft_UpdateTarget(dontgen)
	if UnitName("target") == nil and TheoryCraft_Settings["useglock"] then
		TheoryCraft_Settings["resistscores"]["Arcane"] = 0
		TheoryCraft_Settings["resistscores"]["Fire"] = 0
		TheoryCraft_Settings["resistscores"]["Nature"] = 0
		TheoryCraft_Settings["resistscores"]["Frost"] = 0
		TheoryCraft_Settings["resistscores"]["Shadow"] = 0
		TheoryCraftresistArcane:SetText(TheoryCraft_Settings["resistscores"]["Arcane"])
		TheoryCraftresistFire:SetText(TheoryCraft_Settings["resistscores"]["Fire"])
		TheoryCraftresistNature:SetText(TheoryCraft_Settings["resistscores"]["Nature"])
		TheoryCraftresistFrost:SetText(TheoryCraft_Settings["resistscores"]["Frost"])
		TheoryCraftresistShadow:SetText(TheoryCraft_Settings["resistscores"]["Shadow"])
	end
	TheoryCraft_DeleteTable(old)
	TheoryCraft_CopyTable(TheoryCraft_Data.Target, old)
	TheoryCraft_DeleteTable(TheoryCraft_Data.Target)
	local race, raceen = UnitRace("player")
	local racetar = UnitCreatureType("target")
	if (raceen == "Troll") and (racetar == TheoryCraft_Locale.ID_Beast) then
		TheoryCraft_Data.Target["Allbaseincrease"] = 0.05
		TheoryCraft_Data.Target["Rangedmodifier"] = 0.05
		TheoryCraft_Data.Target["Meleemodifier"] = 0.05
	end
	local slaying = 0
	if (racetar == TheoryCraft_Locale.ID_Humanoid) then
		slaying = TheoryCraft_GetStat("humanoidslaying")
	end
	if (racetar == TheoryCraft_Locale.ID_Beast) or (racetar == TheoryCraft_Locale.ID_Giant) or (racetar == TheoryCraft_Locale.ID_Dragonkin) then
		slaying = TheoryCraft_GetStat("monsterslaying")
	end
	if racetar then
		TheoryCraft_Data.Target["All"] = TheoryCraft_GetStat(racetar)
	end
	TheoryCraft_Data.Target["Allbaseincrease"] = (TheoryCraft_Data.Target["Allbaseincrease"] or 0)+slaying
	TheoryCraft_Data.Target["Rangedmodifier"] = (TheoryCraft_Data.Target["Rangedmodifier"] or 0)+slaying
	TheoryCraft_Data.Target["Meleemodifier"] = (TheoryCraft_Data.Target["Meleemodifier"] or 0)+slaying
	TheoryCraft_Data.Target["Allcritbonus"] = slaying
	TheoryCraft_Data.Target["Rangedcritbonus"] = slaying
	TheoryCraft_Data.Target["Meleecritbonus"] = slaying
	if (dontgen == nil) and (TheoryCraft_IsDifferent(old, TheoryCraft_Data.Target)) then
		TheoryCraft_GenerateAll()
	end
	if TheoryCraft_Settings["dontresist"] then
		TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	end
	TheoryCraft_UpdateArmor()
end

--- IsDifferent, returns true if the two tables are different else nil ---

function TheoryCraft_IsDifferent(oldtable, newtable)
	if newtable == nil then return true end
	if oldtable == nil then return true end
	for k,v in pairs(oldtable) do
		if type(v) == "table" then
			if TheoryCraft_IsDifferent(v, newtable[k]) then
				return true
			end
		elseif newtable[k] ~= v then
			if not (((v == nil) and (newtable[k] == 0)) or ((newtable[k] == nil) and (v == 0))) then
				return true
			end
		end
	end
	for k,v in pairs(newtable) do
		if type(v) == "table" then
			if TheoryCraft_IsDifferent(v, oldtable[k]) then
				return true
			end
		elseif (oldtable[k] ~= v) then
			if not (((v == nil) and (oldtable[k] == 0)) or ((oldtable[k] == nil) and (v == 0))) then
				return true
			end
		end
	end
end

--- OnLoad ---

local function SetDefaults()
	TheoryCraft_Settings = {}
	TheoryCraft_Settings["embed"] = true
	TheoryCraft_Settings["combinedot"] = true
	TheoryCraft_Settings["procs"] = true
	TheoryCraft_Settings["healanddamage"] = true
	TheoryCraft_Settings["embedstyle1"] = true
	TheoryCraft_Settings["buttontext"] = true
	if TheoryCraft_NotStripped then
		TheoryCraft_Settings["mitigation"] = true
	end
	TheoryCraft_Settings["tryfirst"] = "averagedam"
	TheoryCraft_Settings["trysecond"] = "averagehealnocrit"
	TheoryCraft_Settings["tryfirstsfg"] = 0
	TheoryCraft_Settings["trysecondsfg"] = -1
	TheoryCraft_Settings["dataversion"] = TheoryCraft_DataVersion
	TheoryCraft_Settings["GenerateList"] = ""
	TheoryCraft_Settings["dontresist"] = true
	if (MobResistDB) and type(MobResistDB) == "table" then
		TheoryCraft_Settings["useglock"] = true
	end
	TheoryCraft_Settings["resistscores"] = {}
	TheoryCraft_Settings["resistscores"]["Arcane"] = 0
	TheoryCraft_Settings["resistscores"]["Fire"] = 0
	TheoryCraft_Settings["resistscores"]["Nature"] = 0
	TheoryCraft_Settings["resistscores"]["Frost"] = 0
	TheoryCraft_Settings["resistscores"]["Shadow"] = 0
end

function TheoryCraft_SetItemRef(link, text, button)
	if (IsAltKeyDown()) and (string.sub(link, 1, 4) == "item") then
		TheoryCraft_AddToCustom(link)
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
	else
		TheoryCraft_Data["SetItemRef"](link, text, button)
	end
end

function TheoryCraft_ContainerFrameItemButton_OnClick(button, ignoremodifiers)
	if (IsAltKeyDown()) and (button == "LeftButton") and (not ignoremodifiers) and ((AuctionFrame == nil) or (not AuctionFrame:IsVisible())) then
		TheoryCraft_AddToCustom(GetContainerItemLink(this:GetParent():GetID(), this:GetID()))
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
	end
	TheoryCraft_Data["ContainerFrameItemButton_OnClick"](button, ignoremodifiers)
end

function TheoryCraft_PaperDollItemSlotButton_OnClick(arg1)
	if (arg1 == "LeftButton") and (IsAltKeyDown()) then
		TheoryCraft_AddToCustom(GetInventoryItemLink("player", this:GetID()))
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
	end
	TheoryCraft_Data["PaperDollItemSlotButton_OnClick"](arg1)
end

function TheoryCraft_SuperInspect_InspectPaperDollItemSlotButton_OnClick(arg1)
	if (arg1 == "LeftButton") and (IsAltKeyDown()) then
		TheoryCraft_AddToCustom(GetInventoryItemLink("target", GetInventorySlotInfo(string.sub(this:GetName(), 21))))
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
	end
	TheoryCraft_Data["SuperInspect_InspectPaperDollItemSlotButton_OnClick"](arg1)
end


function TheoryCraft_InspectPaperDollItemSlotButton_OnClick(arg1)
	if (arg1 == "LeftButton") and (IsAltKeyDown()) then
		Print(this:GetName())
		TheoryCraft_AddToCustom(GetInventoryItemLink("target", this:GetID()))
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
	end
	TheoryCraft_Data["InspectPaperDollItemSlotButton_OnClick"](arg1)
end

function TheoryCraft_ISyncButtonClick(arg1, sButton)
	if (sButton == "LeftButton") and (IsAltKeyDown()) then
		TheoryCraft_AddToCustom("item:"..this.storeID)
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
	end
	TheoryCraft_Data["ISync:ButtonClick"](arg1, sButton)
end

function TheoryCraft_OnLoad()
	if not TheoryCraft_NotStripped then
		TheoryCraft_Locale.LoadText = string.gsub(TheoryCraft_Locale.LoadText, TheoryCraft_Version, TheoryCraft_Version.." STRIPPED")
		TheoryCraft_DataVersion = TheoryCraft_DataVersion.." STRIPPED"
		TheoryCraft_Version = TheoryCraft_Version.." STRIPPED"
	end
	TheoryCraft_MitigationMobs = {}
	TheoryCraft_MitigationPlayers = {}
	tinsert(UISpecialFrames,"TheoryCraft")
	SLASH_TheoryCraft1 = "/theorycraft"
	SLASH_TheoryCraft2 = "/tc"
	SlashCmdList["TheoryCraft"] = TheoryCraft_Command
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_LOGIN")
	SetDefaults()

	-- Translates and expands out "schoolname" fields

	local s
	local function bothcase(a)
		return "["..string.upper(a)..string.lower(a).."]"
	end
	for k, v in pairs(TheoryCraft_PrimarySchools) do
		if (type(v) == "table") and v.text then
			v.text = string.gsub(v.text, "(.)", bothcase)
		end
	end

	local i = 1
	local s2 = 1
	local i3 = 1
	local newones = {}
	while (TheoryCraft_EquipEveryLine[i]) do
		s2 = TheoryCraft_EquipEveryLine[i].text
		if (strfind(TheoryCraft_EquipEveryLine[i].text, "schoolname")) then
			local i2 = 1
			local type = 1
			local s3 = 1
			while TheoryCraft_PrimarySchools[i2] do
				s3 = s2
				
				s3 = string.gsub(s2, "schoolname", TheoryCraft_PrimarySchools[i2].text)
				if i2 == 1 then
					TheoryCraft_EquipEveryLine[i].text = s3
					TheoryCraft_EquipEveryLine[i].type = TheoryCraft_PrimarySchools[i2].name
				else
					newones[i3] = {}
					newones[i3].me = TheoryCraft_EquipEveryLine[i].me
					newones[i3].amount = TheoryCraft_EquipEveryLine[i].amount
					newones[i3].text = s3
					newones[i3].type = TheoryCraft_PrimarySchools[i2].name
					i3 = i3 + 1
				end
				i2 = i2 + 1
			end
		end
		i = i + 1
	end
	i2 = 1
	while newones[i2] do
		TheoryCraft_EquipEveryLine[i] = {}
		TheoryCraft_EquipEveryLine[i].me = newones[i2].me
		TheoryCraft_EquipEveryLine[i].amount = newones[i2].amount
		TheoryCraft_EquipEveryLine[i].text = newones[i2].text
		TheoryCraft_EquipEveryLine[i].type = newones[i2].type
		i2 = i2 + 1
		i = i + 1
	end

	local i = 1
	local s2 = 1
	local i3 = 1
	local newones = {}
	while (TheoryCraft_EquipEveryRight[i]) do
		s2 = TheoryCraft_EquipEveryRight[i].text
		if (strfind(TheoryCraft_EquipEveryRight[i].text, "schoolname")) then
			local i2 = 1
			local type = 1
			local s3 = 1
			while TheoryCraft_PrimarySchools[i2] do
				s3 = s2
				s3 = string.gsub(s2, "schoolname", TheoryCraft_PrimarySchools[i2].text)
				if i2 == 1 then
					TheoryCraft_EquipEveryRight[i].text = s3
					TheoryCraft_EquipEveryRight[i].type = TheoryCraft_PrimarySchools[i2].name
				else
					newones[i3] = {}
					newones[i3].me = TheoryCraft_EquipEveryRight[i].me
					newones[i3].amount = TheoryCraft_EquipEveryRight[i].amount
					newones[i3].text = s3
					newones[i3].type = TheoryCraft_PrimarySchools[i2].name
					i3 = i3 + 1
				end
				i2 = i2 + 1
			end
		end
		i = i + 1
	end
	i2 = 1
	while newones[i2] do
		TheoryCraft_EquipEveryRight[i] = {}
		TheoryCraft_EquipEveryRight[i].me = newones[i2].me
		TheoryCraft_EquipEveryRight[i].amount = newones[i2].amount
		TheoryCraft_EquipEveryRight[i].text = newones[i2].text
		TheoryCraft_EquipEveryRight[i].type = newones[i2].type
		i2 = i2 + 1
		i = i + 1
	end

	local i = 1
	local s2 = 1
	local i3 = 1
	local newones = {}
	while (TheoryCraft_Equips[i]) do
		s2 = TheoryCraft_Equips[i].text
		if (strfind(TheoryCraft_Equips[i].text, "schoolname")) then
			local i2 = 1
			local type = 1
			local s3 = 1
			while TheoryCraft_PrimarySchools[i2] do
				s3 = string.gsub(s2, "schoolname", TheoryCraft_PrimarySchools[i2].text)
				if i2 == 1 then
					TheoryCraft_Equips[i].text = s3
					TheoryCraft_Equips[i].type = TheoryCraft_PrimarySchools[i2].name
				else
					newones[i3] = {}
					newones[i3].me = TheoryCraft_Equips[i].me
					newones[i3].amount = TheoryCraft_Equips[i].amount
					newones[i3].text = s3
					newones[i3].type = TheoryCraft_PrimarySchools[i2].name
					i3 = i3 + 1
				end
				i2 = i2 + 1
			end
		end
		i = i + 1
	end
	i2 = 1
	while newones[i2] do
		TheoryCraft_Equips[i] = {}
		TheoryCraft_Equips[i].me = newones[i2].me
		TheoryCraft_Equips[i].amount = newones[i2].amount
		TheoryCraft_Equips[i].text = newones[i2].text
		TheoryCraft_Equips[i].type = newones[i2].type
		i2 = i2 + 1
		i = i + 1
	end

	i = 1
	while TheoryCraft_Spells[class][i] do
		if TheoryCraft_Spells[class][i].id then
			if TheoryCraft_Spells[class][i].id == "Aimed Shot" then
				TheoryCraft_Locale.MinMax.aimedshotname = TheoryCraft_Locale.SpellTranslator[TheoryCraft_Spells[class][i].id]
			elseif TheoryCraft_Spells[class][i].id == "Multi-Shot" then
				TheoryCraft_Locale.MinMax.multishotname = TheoryCraft_Locale.SpellTranslator[TheoryCraft_Spells[class][i].id]
			elseif TheoryCraft_Spells[class][i].id == "Arcane Shot" then
				TheoryCraft_Locale.MinMax.arcaneshotname = TheoryCraft_Locale.SpellTranslator[TheoryCraft_Spells[class][i].id]
			elseif TheoryCraft_Spells[class][i].id == "Auto Shot" then
				TheoryCraft_Locale.MinMax.autoshotname = TheoryCraft_Locale.SpellTranslator[TheoryCraft_Spells[class][i].id]
			end
			if TheoryCraft_Locale.SpellTranslator[TheoryCraft_Spells[class][i].id] then
				TheoryCraft_Spells[class][i].name = TheoryCraft_Locale.SpellTranslator[TheoryCraft_Spells[class][i].id]
			else
				Print("TheoryCraft error, no translation found for: "..TheoryCraft_Spells[class][i].id)
				TheoryCraft_Spells[class][i].name = TheoryCraft_Spells[class][i].id
			end
		end
		i = i + 1
	end

	Print(TheoryCraft_Locale.LoadText)
end

--- OnShow ---

function TheoryCraft_OnShow()
    	TheoryCraft_AddTooltipInfo(GameTooltip)
	if (TheoryCraft_OnShow_Save) then
	    	TheoryCraft_OnShow_Save()
	end
end

function TheoryCraft_GLOCK_UpdateResist(this, arg1)
	this:OldSetText(arg1)
	if not TheoryCraft_Settings["useglock"] then
		return
	end
	if strfind(arg1, "I") then
		TheoryCraft_Settings["resistscores"][this.TCType] = "~"
	elseif strfind(arg1, "V") then
		TheoryCraft_Settings["resistscores"][this.TCType] = -50
	else
		TheoryCraft_Settings["resistscores"][this.TCType] = tonumber(arg1) or 0
	end
	getglobal("TheoryCraftresist"..this.TCType):SetText(TheoryCraft_Settings["resistscores"][this.TCType])
end

	if BActionButton and type(BActionButton) == "table" then
		TheoryCraft_Data["oldBongo"] = BActionButton.Create
		function TheoryCraft_BActionButtonCreate(index, bar)
			local tmp = TheoryCraft_Data["oldBongo"](index, bar)
			TheoryCraft_SetUpButton(tmp:GetName(), "Normal")
			return tmp
		end
		BActionButton.Create = TheoryCraft_BActionButtonCreate
	end

function TheoryCraft_OnEvent()
	local UIMem = gcinfo()
	if event == "VARIABLES_LOADED" then
		if TheoryCraft_AddButtonText then TheoryCraft_AddButtonText() end
		TheoryCraft_Mitigation = nil
		TheoryCraft_Data["SetItemRef"] = SetItemRef
		SetItemRef = TheoryCraft_SetItemRef

		if (MobResistDB) and (GLOCK_UIschools) and type(MobResistDB) == "table" then
			for k, v in TheoryCraft_PrimarySchools do
				for k, v2 in GLOCK_UIschools do
					if v2 == v.name then
						if getglobal("GMin"..v.name.."TxT") and getglobal("GMin"..v.name.."TxT").SetText then
							getglobal("GMin"..v.name.."TxT").TCType = v.name
							getglobal("GMin"..v.name.."TxT").OldSetText = getglobal("GMin"..v.name.."TxT").SetText
							getglobal("GMin"..v.name.."TxT").SetText = TheoryCraft_GLOCK_UpdateResist
							break
						end
					end
				end
			end
		end

		-- Hooking Nurfed Action Bars onUpdate event for button text purposes
		TheoryCraft_Data["oldGBMSB"] = GB_Spellbook_UpdatePage
		GB_Spellbook_UpdatePage = TheoryCraft_GB_Spellbook_UpdatePage

		TheoryCraft_Data["oldNurfed"] = Nurfed_ActionButton_OnUpdate
		Nurfed_ActionButton_OnUpdate = TheoryCraft_Nurfed_ActionButton_OnUpdate

		TheoryCraft_Data["PaperDollItemSlotButton_OnClick"] = PaperDollItemSlotButton_OnClick
		PaperDollItemSlotButton_OnClick = TheoryCraft_PaperDollItemSlotButton_OnClick

		TheoryCraft_Data["InspectPaperDollItemSlotButton_OnClick"] = InspectPaperDollItemSlotButton_OnClick
		InspectPaperDollItemSlotButton_OnClick = TheoryCraft_InspectPaperDollItemSlotButton_OnClick

		TheoryCraft_Data["SuperInspect_InspectPaperDollItemSlotButton_OnClick"] = SuperInspect_InspectPaperDollItemSlotButton_OnClick
		SuperInspect_InspectPaperDollItemSlotButton_OnClick = TheoryCraft_SuperInspect_InspectPaperDollItemSlotButton_OnClick

		TheoryCraft_Data["ContainerFrameItemButton_OnClick"] = ContainerFrameItemButton_OnClick
		ContainerFrameItemButton_OnClick = TheoryCraft_ContainerFrameItemButton_OnClick

		if ISync then
			TheoryCraft_Data["ISync:ButtonClick"] = ISync.ButtonClick
			ISync.ButtonClick = TheoryCraft_ISyncButtonClick
		end

		if TheoryCraft_OnShow_Save ~= nil then
			return
		end

		--hooking GameTooltip's OnShow
		TheoryCraft_OnShow_Save = GameTooltip:GetScript("OnShow")
		GameTooltip:SetScript( "OnShow", TheoryCraft_OnShow )
		if TheoryCraft_Mitigation == nil then
			TheoryCraft_Mitigation = {}
		end
		if (TheoryCraft_Settings["dataversion"] ~= TheoryCraft_DataVersion) then
			SetDefaults()
		end
		if TheoryCraft_Settings["ColR2"] == nil then
			TheoryCraft_Settings["buttontextx"] = 1.111
			TheoryCraft_Settings["buttontexty"] = 10.22
			TheoryCraft_Settings["ColR"] = 1
			TheoryCraft_Settings["ColG"] = 1
			TheoryCraft_Settings["ColB"] = 1
			TheoryCraft_Settings["ColR2"] = 1
			TheoryCraft_Settings["ColG2"] = 1
			TheoryCraft_Settings["ColB2"] = 175/255
			TheoryCraft_Settings["FontSize"] = 12
			TheoryCraft_Settings["FontPath"] = "Fonts\\ArialN.TTF"
		end
		if TheoryCraftGenBox_Text then TheoryCraftGenBox_Text:SetText(TheoryCraft_Settings["GenerateList"]) end
		if TheoryCraft_Settings["off"] then
			Print("TheoryCraft is currently switched off, type in '/tc on' to enabled")
		end
	elseif event == "PLAYER_LOGIN" then
		this:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
		this:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
		this:RegisterEvent("SPELLS_CHANGED")
		this:RegisterEvent("UNIT_AURA")
		this:RegisterEvent("UNIT_INVENTORY_CHANGED")
		this:RegisterEvent("PLAYER_TARGET_CHANGED")
		this:RegisterEvent("UNIT_MANA")
		this:RegisterEvent("CHARACTER_POINTS_CHANGED")
		this:RegisterEvent("PLAYER_LEAVING_WORLD")
		this:RegisterEvent("PLAYER_ENTERING_WORLD")
		this:RegisterEvent("PLAYER_COMBO_POINTS")
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
		this:RegisterEvent("PLAYER_REGEN_ENABLED")
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	elseif event == "PLAYER_LEAVING_WORLD" then
		this:UnregisterEvent("ACTIONBAR_PAGE_CHANGED")
		this:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
		this:UnregisterEvent("SPELLS_CHANGED")
		this:UnregisterEvent("UNIT_AURA")
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED")
		this:UnregisterEvent("PLAYER_TARGET_CHANGED")
		this:UnregisterEvent("UNIT_MANA")
		this:UnregisterEvent("CHARACTER_POINTS_CHANGED")
		this:UnregisterEvent("PLAYER_LEAVING_WORLD")
		this:UnregisterEvent("PLAYER_COMBO_POINTS")
		this:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
		this:UnregisterEvent("PLAYER_REGEN_ENABLED")
		this:UnregisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	elseif event == "PLAYER_ENTERING_WORLD" then
		TheoryCraft_UpdateTalents(true)
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_UpdateBuffs("player", true)
		TheoryCraft_UpdateBuffs("target", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
		this:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
		this:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
		this:RegisterEvent("SPELLS_CHANGED")
		this:RegisterEvent("UNIT_AURA")
		this:RegisterEvent("UNIT_INVENTORY_CHANGED")
		this:RegisterEvent("PLAYER_TARGET_CHANGED")
		this:RegisterEvent("UNIT_MANA")
		this:RegisterEvent("CHARACTER_POINTS_CHANGED")
		this:RegisterEvent("PLAYER_LEAVING_WORLD")
		this:RegisterEvent("PLAYER_COMBO_POINTS")
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
		this:RegisterEvent("PLAYER_REGEN_ENABLED")
		this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		if TheoryCraft_ParseCombat then
			TheoryCraft_ParseCombat(arg1)
		end
	elseif event == "CHAT_MSG_SPELL_SELF_BUFF" then
		TheoryCraft_WatchCritRate(arg1)
	elseif event == "UNIT_INVENTORY_CHANGED" then
		TheoryCraft_UpdateGear(arg1)
	elseif event == "PLAYER_REGEN_ENABLED" then
		if TheoryCraft_Data.regenaftercombat then
			TheoryCraft_Data.regenaftercombat = nil
			TheoryCraft_UpdateGear("player", nil, true)
		end
	elseif event == "SPELLS_CHANGED" then
		local autoshotname = TheoryCraft_Locale.SpellTranslator["Auto Shot"]
		if autoshotname then
			local olddesc = TheoryCraft_TooltipData[autoshotname.."(0)"]
			if olddesc then
				TheoryCraft_TooltipData[autoshotname.."(0)"] = nil
				TheoryCraft_TooltipData[olddesc] = nil
			end
		end
		TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	elseif event == "ACTIONBAR_PAGE_CHANGED" then
		TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	elseif event == "ACTIONBAR_SLOT_CHANGED" then
		TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	elseif event == "UNIT_AURA" then
		TheoryCraft_UpdateBuffs(arg1)
	elseif event == "CHARACTER_POINTS_CHANGED" then
		TheoryCraft_UpdateTalents()
	elseif event == "PLAYER_TARGET_CHANGED" then
		TheoryCraft_UpdateTarget()
		TheoryCraft_UpdateBuffs("target")
	elseif event == "PLAYER_COMBO_POINTS" then
		TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	elseif (event == "UNIT_MANA") and (arg1 == "player") then
		if UnitClass("player") == "DRUID" then
			local _, _, catform = GetShapeshiftFormInfo(3)
			if catform then
				TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
			end
		end
		if ((string.find(TheoryCraft_Settings["tryfirst"], "remaining")) or (string.find(TheoryCraft_Settings["trysecond"], "remaining"))) or
		   ((TheoryCraft_Settings["tryfirst"] == "spellcasts") or (TheoryCraft_Settings["trysecond"] == "spellcasts")) then
			TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
		end
	end
	if TheoryCraft_Settings["showmem"] then
		Print(event..": "..gcinfo()-UIMem)
	end
end

function TheoryCraft_CheckBoxShowDescription(arg1)
	local name = this:GetName()
	name = string.sub(name, 12)
	if (TheoryCraft_CheckButtons[name] == nil) then
		return
	end
	local text = 1
	if (TheoryCraft_CheckButtons[name].descriptionmelee) and ((class == "ROGUE") or (class == "WARRIOR")) then
		text = TheoryCraft_CheckButtons[name].descriptionmelee
	else
		text = TheoryCraft_CheckButtons[name].description
	end
	if string.find(text, "$cr") then
		text = string.gsub(text, "$cr", round(TheoryCraft_intpercrit(), 2))
	end
	GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
	if TheoryCraft_CheckButtons[name].tooltiptitle then
		GameTooltip:AddLine(TheoryCraft_CheckButtons[name].tooltiptitle, 1,1,1)
	else
		GameTooltip:AddLine(TheoryCraft_CheckButtons[name].short, 1,1,1)
	end
	GameTooltip:AddLine(text, 1,1,0)
	GameTooltip:Show()
end

function TheoryCraft_SetCheckBox(variablename)
	if getglobal("TheoryCraft"..variablename) then
		getglobal("TheoryCraft"..variablename):SetChecked(TheoryCraft_Settings[variablename])
	end
end

function TheoryCraft_CheckBoxSetText(arg1)
	local name = this:GetName()
	name = string.sub(name, 12)
	if TheoryCraft_CheckButtons[name] == nil then return end
	if TheoryCraft_CheckButtons[name].hide then
		for k,v in pairs(TheoryCraft_CheckButtons[name].hide) do
			if (class == v) or ((v == "STRIPPED") and (not TheoryCraft_NotStripped)) then
				getglobal(this:GetName()):Disable()
				getglobal(this:GetName().."Text"):SetTextColor(0.5, 0.5, 0.5)
			end
		end
	end
	getglobal(this:GetName().."Text"):SetText(TheoryCraft_CheckButtons[name].short)
end

function TheoryCraft_CheckBoxToggle(arg1)
	local onoff
	if (this:GetChecked()) then
		onoff = true
	end
	local name = this:GetName()
	name = string.sub(name, 12)
	if (name == "embedstyle1") or (name == "embedstyle2") or (name == "embedstyle3") then
		TheoryCraft_Settings["embedstyle1"] = nil
		TheoryCraft_Settings["embedstyle2"] = nil
		TheoryCraft_Settings["embedstyle3"] = nil
		TheoryCraft_Settings[name] = onoff
		TheoryCraft_SetCheckBox("embedstyle1")
		TheoryCraft_SetCheckBox("embedstyle2")
		TheoryCraft_SetCheckBox("embedstyle3")
	elseif (name == "alignleft") or (name == "alignright") then
		TheoryCraft_Settings["alignleft"] = nil
		TheoryCraft_Settings["alignright"] = nil
		TheoryCraft_Settings[name] = onoff
		TheoryCraft_SetCheckBox("alignleft")
		TheoryCraft_SetCheckBox("alignright")
		TheoryCraft_UpdateDummyButtonText()
	elseif name == "useglock" then
		if (MobResistDB) and (type(MobResistDB) == "table") and (onoff == true) then
			TheoryCraft_Settings[name] = onoff
		elseif (not MobResistDB) then
			TheoryCraft_Settings[name] = nil
			this:SetChecked(false)
			Print("GLOCK can be found at Curse Gaming. (TC couldn't find it installed)")
		end
	else
		TheoryCraft_Settings[name] = onoff
	end
	if name == "dontresist" then
		if TheoryCraft_Settings["dontresist"] then
			TheoryCraftresistArcane:Show()
			TheoryCraftresistFire:Show()
			TheoryCraftresistNature:Show()
			TheoryCraftresistFrost:Show()
			TheoryCraftresistShadow:Show()
			TheoryCraftuseglock:Show()
		else
			TheoryCraftresistArcane:Hide()
			TheoryCraftresistFire:Hide()
			TheoryCraftresistNature:Hide()
			TheoryCraftresistFrost:Hide()
			TheoryCraftresistShadow:Hide()
			TheoryCraftuseglock:Hide()
		end
	end
	if (name == "procs") or (name == "rollignites") or (name == "sepignites") or (name == "combinedot") or (name == "dotoverct") or (name == "dontcrit") then
		TheoryCraft_GenerateAll()
	end
	if (name == "buttontext") or (name == "tryfirstlarge") or (name == "trysecondlarge") or (name == "dontresist") or (name == "useglock")  then
		TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
	end
end

function TheoryCraft_Command(cmd)
	if (cmd == "") then
		if TheoryCraft_Data["firstrun"] == nil then
			if TheoryCraft_NotStripped then
				PanelTemplates_SetNumTabs(TheoryCraft, 3)
				TheoryCraft.selectedTab=1
				PanelTemplates_UpdateTabs(TheoryCraft)
			end
		end
		TheoryCraft_Data["firstrun"] = 1

		TheoryCraft_SetCheckBox("embedstyle1")
		TheoryCraft_SetCheckBox("embedstyle2")
		TheoryCraft_SetCheckBox("embedstyle3")
		TheoryCraft_SetCheckBox("titles")
		TheoryCraft_SetCheckBox("embed")
		TheoryCraft_SetCheckBox("crit")
		TheoryCraft_SetCheckBox("critdam")
		TheoryCraft_SetCheckBox("sepignite")
		TheoryCraft_SetCheckBox("rollignites")
		TheoryCraft_SetCheckBox("dps")
		TheoryCraft_SetCheckBox("combinedot")
		TheoryCraft_SetCheckBox("dotoverct")
		TheoryCraft_SetCheckBox("hps")
		TheoryCraft_SetCheckBox("dpsdam")
		TheoryCraft_SetCheckBox("averagedam")
		TheoryCraft_SetCheckBox("procs")
		TheoryCraft_SetCheckBox("mitigation")
		TheoryCraft_SetCheckBox("resists")
		TheoryCraft_SetCheckBox("averagethreat")
		TheoryCraft_SetCheckBox("plusdam")
		TheoryCraft_SetCheckBox("damcoef")
		TheoryCraft_SetCheckBox("dameff")
		TheoryCraft_SetCheckBox("damfinal")
		TheoryCraft_SetCheckBox("healanddamage")
		TheoryCraft_SetCheckBox("nextagi")
		TheoryCraft_SetCheckBox("nextstr")
		TheoryCraft_SetCheckBox("nextcrit")
		TheoryCraft_SetCheckBox("nexthit")
		TheoryCraft_SetCheckBox("nextpen")
		TheoryCraft_SetCheckBox("mana")
		TheoryCraft_SetCheckBox("dpm")
		TheoryCraft_SetCheckBox("hpm")
		TheoryCraft_SetCheckBox("max")
		TheoryCraft_SetCheckBox("maxevoc")
		TheoryCraft_SetCheckBox("lifetap")
		TheoryCraft_SetCheckBox("dontcrit")
		TheoryCraft_SetCheckBox("dontresist")
		TheoryCraft_SetCheckBox("useglock")
		TheoryCraft_SetCheckBox("buttontext")
		TheoryCraft_SetCheckBox("tryfirstlarge")
		TheoryCraft_SetCheckBox("trysecondlarge")
		TheoryCraft_SetCheckBox("framebyframe")

		TheoryCraftresistArcane:SetText(TheoryCraft_Settings["resistscores"]["Arcane"])
		TheoryCraftresistFire:SetText(TheoryCraft_Settings["resistscores"]["Fire"])
		TheoryCraftresistNature:SetText(TheoryCraft_Settings["resistscores"]["Nature"])
		TheoryCraftresistFrost:SetText(TheoryCraft_Settings["resistscores"]["Frost"])
		TheoryCraftresistShadow:SetText(TheoryCraft_Settings["resistscores"]["Shadow"])

		if TheoryCraft_Settings["dontresist"] then
			TheoryCraftresistArcane:Show()
			TheoryCraftresistFire:Show()
			TheoryCraftresistNature:Show()
			TheoryCraftresistFrost:Show()
			TheoryCraftresistShadow:Show()
			TheoryCraftuseglock:Show()
		else
			TheoryCraftresistArcane:Hide()
			TheoryCraftresistFire:Hide()
			TheoryCraftresistNature:Hide()
			TheoryCraftresistFrost:Hide()
			TheoryCraftresistShadow:Hide()
			TheoryCraftuseglock:Hide()
		end

		if (TheoryCraft:IsVisible()) then
			TheoryCraft:Hide()
		else
			if TheoryCraft_UpdateDummyButtonText then TheoryCraft_UpdateDummyButtonText() end
			TheoryCraft:Show()
		end
	end
	local onoff = nil
	if strfind(cmd, " ") then
		onoff = string.sub(cmd, strfind(cmd, " ")+1)
		cmd = string.sub(cmd, 1, strfind(cmd, " ")-1)
	end
	if (cmd == "custom") then
		local linkid = string.sub(onoff, string.find(onoff, "item:%d+:%d+:%d+:%d+"))
		TheoryCraft_Settings["CustomOutfitName"] = "Custom"
		TheoryCraft_AddToCustom(linkid)
	end
	if (cmd == "calccrits") then
		if TheoryCraft_Settings["critchancedata"] == nil then
			Print("No crits found - this feature works for heals only")
			return
		end
		local _, critrate, int, gear
		local crittable = {}
		for k, v in pairs(TheoryCraft_Settings["critchancedata"]) do
			_, _, int, gear = strfind(k, "(.+):(.+)")
			if crittable[int] == nil then
				crittable[int] = {}
			end
			critrate = v.crits/v.casts-gear/100
			crittable[int].casts = v.casts+(crittable[int].casts or 0)
			crittable[int].critrate = v.casts*(v.crits/v.casts-gear/100)/crittable[int].casts
		end
		local minint = 1000
		local maxint = 0
		local mincrit = 0
		local maxcrit = 0
		for k, v in pairs(crittable) do
			if (tonumber(k) < minint) and (v.casts > 400) then
				minint = tonumber(k)
				mincrit = v.critrate
			end
			if (tonumber(k) > maxint) and (v.casts > 400) then
				maxint = tonumber(k)
				maxcrit = v.critrate
			end
		end
		mincrit = mincrit * 100
		maxcrit = maxcrit * 100
		Print("Int | Casts | Crit Chance")
		for k, v in crittable do
			Print(k.." | "..v.casts.." | "..round(v.critrate*100,4).."%")
		end
		if minint == 1000 then
			Print("Insufficient data to calculate crit rates")
		elseif minint == maxint then
			Print("Insufficient range to calculate base crit, assuming 0")
			Print("Int Per Crit = "..round(maxint/maxcrit,3))
			Print("Base Crit = 0")
		else
			Print("Using this data:")
			Print("Int Per Crit = "..round((maxint-minint)/(maxcrit-mincrit),3))
			Print("Base Crit = "..round((mincrit-minint/((maxint-minint)/(maxcrit-mincrit))),3).."%")
		end
	end
	if (cmd == "armor") or (cmd == "playerarmor") then
		if onoff == nil then onoff = "" end
		onoff = string.upper(onoff)
		local test = {}
		local i = 1
		local ul = UnitLevel("player")
		Print(" ")
		if cmd == "armor" then
			for k, v in pairs(TheoryCraft_MitigationMobs) do
				if strfind(string.upper(k), onoff) then
					test[i] = round((v[1] / (85 * ul + 400 + v[1]))*100,1).." | "..v[1].." | "..k
					i = i + 1
					if i > 250 then
						Print("Please limit your search - more than 250 mobs were found")
						return
					end
				end
			end
			Print("DR | Armor | Mob Name")
		else
			local classname, level, _
			for k, v in pairs(TheoryCraft_MitigationPlayers) do
				if strfind(string.upper(k), onoff) and strfind(string.upper(k), ":") then
					_, _, classname, level = strfind(k, "(.+):(.+)")
					test[i] = classname.." | "..level.." | "..v[1].." | "..round((v[1] / (85 * ul + 400 + v[1]))*100,1)
					i = i + 1
					if i > 250 then
						Print("Please limit your search - more than 250 mobs were found")
						return
					end
				end
			end
			Print(" ")
			Print("Class | Lvl | Armor | DR")
			table.sort(test)
			for k, v in pairs(test) do
				Print(v)
			end
			test = {}
			for k, v in pairs(TheoryCraft_MitigationPlayers) do
				if strfind(string.upper(k), onoff) and (not strfind(k, ":")) then
					test[i] = round((v[1] / (85 * ul + 400 + v[1]))*100,1).." | "..v[1].." | "..k
					i = i + 1
					if i > 250 then
						Print("Please limit your search - more than 250 mobs were found")
						return
					end
				end
			end
			Print(" ")
			Print("DR | Armor | Player Name")
		end
		table.sort(test)
		for k, v in pairs(test) do
			Print(v)
		end
	end
	if (cmd == "off") then
		Print("TheoryCraft is now switched OFF")
		TheoryCraft_Settings["off"] = true
	end
	if (cmd == "on") then
		Print("TheoryCraft is now switched ON")
		TheoryCraft_Settings["off"] = nil
	end
	if (cmd == "more") then
		Print("/tc showmem")
		Print("    Debug infomation, shows the memory usage (in bytes) as each event occurs")
		Print("/tc damtodouble")
		Print("    Shows how much +damage/+heal is required to double a spells base damage")
		Print("/tc dpsmana")
		Print("    Adds a dps/mana field to the tooltip")
		Print("/tc armorchanges")
		Print("    Prints whenever the armor value of the target changes")
		Print("/tc armor (mob name)")
		Print("    Prints the mobs armor. Leave blank for all.")
		Print("/tc playerarmor (player name, or class)")
		Print("    Prints a players armor. Leave blank for all.")
		Print("/tc calccrits")
		Print("    Shows your actual crit rate, from combat. Only works for healers.")
		Print("Macro Tooltips")
		Print("    If you name a macro the same as the name of the spell, in the format: Pyroblast(x), where x is the rank (or 0 if N/A), TC will show the correct tooltip. If the spell name does not fit, only use as many characters as can fit without leaving the rank off.")
		Print('/script TheoryCraftCast("Greater Heal", 1)')
		Print("    Casts the lowest rank Greater Heal that'll bring your target to full health.  The 1 represents overheal amount, eg change to 1.2 to attempt to overheal by 20% (to account for damage while casting). Can be used in macros.")
	end
	if (cmd == "titles") or (cmd == "dpsmana") or (cmd == "damtodouble") or (cmd == "hidecritdata") or (cmd == "dpsdampercent") or (cmd == "armorchanges") or (cmd == "procs") or (cmd == "hideadvanced") or (cmd == "showregenheal") or (cmd == "showregendam") or (cmd == "hpm") or (cmd == "dpm") or (cmd == "dontcritdpm") or (cmd == "dontcrithpm") or (cmd == "nextagi") or (cmd == "nextpen") or (cmd == "embed") or (cmd == "dam") or (cmd == "averagedam") or (cmd == "averagedamnocrit") or (cmd == "crit") or (cmd == "critdam") or (cmd == "sepignite") or (cmd == "rollignites") or (cmd == "dps") or (cmd == "dpsdam") or (cmd == "resists") or (cmd == "timeit") or (cmd == "plusdam") or (cmd == "damcoef") or (cmd == "dameff") or (cmd == "damfinal") or (cmd == "nextcrit") or (cmd == "nexthit") or (cmd == "mana") or (cmd == "max") or (cmd == "maxevoc") or (cmd == "maxtime") or (cmd == "averagethreat") or (cmd == "healanddamage") or (cmd == "lifetap") or (cmd == "showmore") or (cmd == "showmem") then
		if (TheoryCraft_Settings[cmd]) then
			onoff = nil
		else
			onoff = true
		end
		if onoff then
			DEFAULT_CHAT_FRAME:AddMessage(cmd.." is now set to 'on'")
		else
			DEFAULT_CHAT_FRAME:AddMessage(cmd.." is now set to 'off'")
		end
		TheoryCraft_Settings[cmd] = onoff
	end
end

function TheoryCraft_OutfitChange(arg1)
	local id = this:GetName()
	local name = this:GetText()
	if (id == "TheoryCraftSetToAll") then
		TheoryCraftGenBox_Text:SetText("")
		local spellname, spellrank
		local i, i2 = 1
		local first = true
		while (true) do
			spellname, spellrank = GetSpellName(i,BOOKTYPE_SPELL)
			if spellname == nil then break end
			spellrank = tonumber(findpattern(spellrank, "%d+"))
			if spellrank == nil then spellrank = 0 end
			i2 = 1
			while (TheoryCraft_Spells[class][i2]) and (spellname ~= TheoryCraft_Spells[class][i2].name) do
				i2 = i2 + 1
			end
			if (TheoryCraft_Spells[class][i2] ~= nil) then
				if first then
					TheoryCraftGenBox_Text:SetText(spellname.."("..spellrank..")")
					first = false
				else
					TheoryCraftGenBox_Text:SetText(TheoryCraftGenBox_Text:GetText().."\n"..spellname.."("..spellrank..")")
				end
			end
			i = i + 1
		end
		return
	end
	if (id == "TheoryCraftGenAll") then
		local timer = GetTime()
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		timer = round((GetTime()-timer)*1000)
		Print(" ")
		Print("TheoryCraft takes: "..timer.."ms to read your gear. This will only occur out of combat, and only when your gear changes.")
		TheoryCraft_Data["reporttimes"] = true
		TheoryCraft_Data["buttonsgenerated"] = 0
		TheoryCraft_Data["timetaken"] = 0
		TheoryCraft_GenerateAll()
		return
	end
	if (id == "TheoryCraftResetButton") then
		TheoryCraft_Data["outfit"] = 1
		local i = 1
		while (TheoryCraft_Talents[i]) do
			TheoryCraft_Talents[i].forceto = -1
			i = i + 1
		end
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_UpdateTalents(true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
		UIDropDownMenu_SetSelectedID(TheoryCraftoutfit, 1)
		TheoryCraftCustomOutfit:Hide()
		return
	end
	if (id == "TheoryCraftClearButton") then
		TheoryCraft_Settings["CustomOutfitName"] = "Custom"
		TheoryCraft_Settings["CustomOutfit"] = nil
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
		return
	end
	if (id == "TheoryCraftClose") then
		TheoryCraft:Hide()
		return
	end
	if (id == "TheoryCraftEquipTargetButton") then
		TheoryCraft_Settings["CustomOutfitName"] = UnitName("target")
		TheoryCraft_Settings["CustomOutfit"] = nil
		TheoryCraft_Data["outfit"] = 2
		TheoryCraft_UpdateGear("player", true)
		local i = 20
		while i > 0 do
			TheoryCraft_AddToCustom(GetInventoryItemLink("target", i))
			i=i-1
		end
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
		return
	end
	if (id == "TheoryCraftEquipSelfButton") then
		TheoryCraft_Settings["CustomOutfitName"] = "Self"
		TheoryCraft_Settings["CustomOutfit"] = nil
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
		TheoryCraft_Data["outfit"] = 2
		local i = 20
		while i > 0 do
			TheoryCraft_AddToCustom(GetInventoryItemLink("player", i))
			i=i-1
		end
		TheoryCraft_UpdateGear("player", true)
		TheoryCraft_LoadStats()
		TheoryCraft_GenerateAll()
		return
	end
end

function TheoryCraft_UpdateEditBox()
	local s = string.gsub(this:GetName(), "TheoryCraft", "")
	local text = this:GetText()
	if s ~= "FontPath" then
		if text == "~" and strfind(s, "resist") then
			TheoryCraft_Settings["resistscores"][string.gsub(s, "resist", "")] = "~"
			TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
			return
		end
		text = tonumber(text)
		if text == nil then
			if strfind(s, "resist") then
				TheoryCraft_Settings["resistscores"][string.gsub(s, "resist", "")] = 0
				TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
			end
			return
		end
		if strfind(s, "Col") then
			if text > 255 then
				text = 255
			end
			if text < 0 then
				text = 0
			end
			text = text/255
		end
	end
	if strfind(s, "resist") then
		TheoryCraft_Settings["resistscores"][string.gsub(s, "resist", "")] = text
		if TheoryCraft_Settings["dontresist"] then
			TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
		end
	else
		TheoryCraft_Settings[s] = text
		if TheoryCraft_UpdateDummyButtonText then
			TheoryCraft_UpdateDummyButtonText(true)
		end
	end
end
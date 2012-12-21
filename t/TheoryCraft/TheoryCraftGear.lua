TheoryCraft_Data.EquipEffects = {}
local _, class = UnitClass("player")

local function findpattern(text, pattern, start)
	if (text and pattern and (string.find(text, pattern, start))) then
		return string.sub(text, string.find(text, pattern, start))
	else
		return ""
	end
end

local function TheoryCraft_AddEquipEffect (slotname, test, data, equippedsets)
	if (test ~= "test") then
		TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
		TheoryCraftTooltip:SetInventoryItem ("player", GetInventorySlotInfo(slotname.."Slot"))
	end
	if (getglobal("TheoryCraftTooltipTextLeft1") == nil) then
		return
	end
	local ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft1"):GetText()
	if (data["name"] == ltext) and (data["numlines"] == TheoryCraftTooltip:NumLines()) then
		return
	end
	for k,v in pairs(data) do
		data[k] = nil
	end
	if data["procs"] == nil then data["procs"] = {} end
	for k,v in pairs(equippedsets) do
		equippedsets[k] = nil
	end
	data["name"] = ltext
	data["numlines"] = TheoryCraftTooltip:NumLines()
	local index = 2
	ltext = getglobal("TheoryCraftTooltipTextLeft"..index)
	if ltext then
		ltext = ltext:GetText()
	end
	rtext = getglobal("TheoryCraftTooltipTextRight"..index)
	if rtext then
		if (not getglobal("TheoryCraftTooltipTextRight"..index):IsVisible()) then
			rtext = nil
		else
			rtext = rtext:GetText()
		end
	end
	local s2 = 1
	local is = 1
	local i2 = 1
	local ignoreline = false
	local startpos, endpos, found, foundme
	while (ltext ~= nil) do
		if strfind(ltext, TheoryCraft_Locale.Set) then
			local numpieces = tonumber(findpattern(findpattern(ltext, TheoryCraft_Locale.Set), "%d+"))
			while (string.len(ltext) > 0) and (string.sub(ltext, string.len(ltext), string.len(ltext)) == " ") do
				ltext = string.sub(ltext, 1, string.len(ltext)-1)
			end
			while (string.len(ltext) > 0) and (string.sub(ltext, string.len(ltext), string.len(ltext)) ~= " ") do
				ltext = string.sub(ltext, 1, string.len(ltext)-1)
			end
			while (string.len(ltext) > 0) and (string.sub(ltext, string.len(ltext), string.len(ltext)) == " ") do
				ltext = string.sub(ltext, 1, string.len(ltext)-1)
			end
			local setname = ltext
			equippedsets[setname] = (equippedsets[setname] or 0)+1
			if TheoryCraft_SetBonuses[setname] == nil then 
				TheoryCraft_SetBonuses[setname] = {}
			end
			local foundbonuses = {}
			local idx = 1
			index = index + 1
			ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..index)
			while (ltext ~= nil) do
				ltext = ltext:GetText()
				if ltext == nil then break end
				if strfind(string.sub(ltext, 1, 4), "%d+") then
					foundbonuses[idx] = {}
					foundbonuses[idx]["pieces"] = tonumber(findpattern(ltext, "%d+"))
					ltext = string.sub(ltext, 5+string.len(TheoryCraft_Locale.ID_Set))
					foundbonuses[idx]["text"] = ltext
					idx = idx + 1
				end
				index = index + 1
				ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..index)
			end
			local newbonuses = {}
			i = 1
			for k,v in TheoryCraft_SetBonuses[setname] do
				if (v["pieces"] <= numpieces) then
					newbonuses[i] = v
					i = i + 1
				end
			end
			for k,v in pairs(foundbonuses) do
				newbonuses[i] = v
				i = i + 1
			end
			TheoryCraft_SetBonuses[setname] = newbonuses
			break
		end
		if (strfind(ltext, "^"..TheoryCraft_Locale.ID_Equip)) then
			foundme = false
			for k, v in pairs(TheoryCraft_Equips) do
				if (v.slot == nil) or (v.slot == slotname) then
					if ((foundme == false) or (v.me == nil)) then
						_, start, found = strfind(ltext, v.text)
						if _ then
							if v.proc then
								i2 = 1
								if data["procs"] == nil then
									data["procs"] = {}
								end
								while data["procs"][i2] do i2 = i2 + 1 end
								data["procs"][i2] = {}
								data["procs"][i2].amount = v.amount
								data["procs"][i2].proc = v.proc
								data["procs"][i2].duration = v.duration
								data["procs"][i2].exact = v.exact
								data["procs"][i2].type = v.type
							else
								if (v.amount) then
									data[v.type] = (data[v.type] or 0) + v.amount
								else
									data[v.type] = (data[v.type] or 0) + tonumber(found)
								end
								if (v.me) then
									foundme = true
								end
							end
						end
					end
				end
			end
		else
			foundme = false
			if rtext then
				for k, v in pairs(TheoryCraft_EquipEveryRight) do
					if (v.slot == nil) or (v.slot == slotname) then
						if (foundme == false) or (v.me == nil) then
							_, start, found = strfind(rtext, v.text)
							if _ then
								if (v.amount) then
									data[v.type] = (data[v.type] or 0) + v.amount
								else
									data[v.type] = (data[v.type] or 0) + found
								end	
								if (v.me) then foundme = true end
							end
						end
					end
				end
			end
			ignoreline = false
			for k, v in pairs(TheoryCraft_IgnoreLines) do
				if strfind(ltext, v) then
					ignoreline = true
					break
				end
			end
			if not ignoreline then
				foundme = false
				for k, v in pairs(TheoryCraft_EquipEveryLine) do
					if (v.slot == nil) or (v.slot == slotname) then
						if (not foundme) or (not v.me) then
							_, start, found = strfind(ltext, v.text)
							if _ then
								if (v.amount) then
									data[v.type] = (data[v.type] or 0) + v.amount
								else
									data[v.type] = (data[v.type] or 0) + found
								end	
								if (v.me) then foundme = true end
							end
						end
					end
				end
			end
		end

		index = index + 1
		ltext = getglobal("TheoryCraftTooltipTextLeft"..index)
		rtext = getglobal("TheoryCraftTooltipTextRight"..index)
		if ltext then
			ltext = ltext:GetText()
		end
		if rtext then
			if (not getglobal("TheoryCraftTooltipTextRight"..index):IsVisible()) then
				rtext = nil
			else
				rtext = rtext:GetText()
			end
		end
	end
	TheoryCraftTooltip:ClearLines()
	return true
end

function TheoryCraft_CombineTables(tab1, tab2)
	if tab2 == nil then tab2 = tab1 return end
	for k,v in pairs(tab1) do
		if type(v) == "table" then
			tab2[k] = TheoryCraft_CombineTables(v, tab2[k])
		elseif tonumber(v) and tonumber(tab2[k] or 0) then
			tab2[k] = v + (tab2[k] or 0)
		end
	end
end

local function TheoryCraft_AddAllEquips(outfit, force)
	local i2 = 1
	local resetall = true
	if not force and UnitAffectingCombat("player") then
		resetall = false
	end
	if (TheoryCraft_Outfits[outfit]) == nil then
		outfit = 1
	end
	if TheoryCraft_Data["SlotData"] == nil then
		TheoryCraft_Data["SlotData"] = {}
		TheoryCraft_Data["SetData"] = {}
	end
	TheoryCraft_Data.OldOutfit = outfit
	if TheoryCraft_Data.StatsToDo == nil then
		TheoryCraft_Data.StatsToDo = {}
	end
	TheoryCraft_DeleteTable(TheoryCraft_Data.StatsToDo)
	for k, v in pairs(TheoryCraft_Outfits[outfit].wear) do
		TheoryCraft_Data.StatsToDo[v] = true
		if TheoryCraft_Data["SlotData"][v] == nil then
			TheoryCraft_Data["SlotData"][v] = {}
			TheoryCraft_Data["SlotData"][v]["procs"] = {}
		end
		if TheoryCraft_Data["SetData"][v] == nil then
			TheoryCraft_Data["SetData"][v] = {}
		end
		if (v == "MainHand") or (v == "SecondaryHand") or (v == "Ranged") or (v == "Ammo") then
			changed = TheoryCraft_AddEquipEffect(v, nil, TheoryCraft_Data["SlotData"][v], TheoryCraft_Data["SetData"][v])
		elseif (resetall) then
			changed = TheoryCraft_AddEquipEffect(v, nil, TheoryCraft_Data["SlotData"][v], TheoryCraft_Data["SetData"][v])
		end
	end
	if not TheoryCraft_Data.EquipEffects then
		TheoryCraft_Data.EquipEffects  = {}
	end
	if not TheoryCraft_Data.EquipedSets then
		TheoryCraft_Data.EquippedSets  = {}
	end
	TheoryCraft_DeleteTable(TheoryCraft_Data.EquipEffects)
	TheoryCraft_DeleteTable(TheoryCraft_Data.EquippedSets)
	for k, v in pairs(TheoryCraft_Data.StatsToDo) do
		TheoryCraft_CombineTables(TheoryCraft_Data.SlotData[k], TheoryCraft_Data.EquipEffects)
		TheoryCraft_CombineTables(TheoryCraft_Data.SetData[k], TheoryCraft_Data.EquippedSets)
	end
	data = TheoryCraft_Data.EquipEffects
	local i = 1
	if (outfit == 2) then
		TheoryCraft_Outfits[outfit].meleecritchance = 0
		TheoryCraft_Outfits[outfit].formattackpower = 0
		TheoryCraft_Outfits[outfit].rangedattackpower = 0
		TheoryCraft_Outfits[outfit].attackpower = 0
		TheoryCraft_Outfits[outfit].strength = 0
		TheoryCraft_Outfits[outfit].agility = 0
		TheoryCraft_Outfits[outfit].stamina = 0
		TheoryCraft_Outfits[outfit].intellect = 0
		TheoryCraft_Outfits[outfit].spirit = 0
		TheoryCraft_Outfits[outfit].totalmana = 0
		TheoryCraft_Outfits[outfit].totalhealth = 0
		if (TheoryCraft_Settings["CustomOutfit"] == nil) then
			TheoryCraft_Settings["CustomOutfit"] = TheoryCraft_Outfits[outfit]
			TheoryCraft_Settings["CustomOutfit"].slots = {}
		end
		local k, v
		while (TheoryCraft_SlotNames[i]) do
			if ((TheoryCraft_SlotNames[i-1] == nil) or (TheoryCraft_SlotNames[i].slot ~= TheoryCraft_SlotNames[i-1].slot)) and (TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot]) then
				if TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot] == nil then
					TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot] = {}
				end
				if TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot]["stats"] == nil then TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot]["stats"] = {} end
				local a = TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot]["stats"]
				TheoryCraft_Outfits[outfit].meleecritchance = TheoryCraft_Outfits[outfit].meleecritchance+(a.meleecritchance or 0)
				TheoryCraft_Outfits[outfit].formattackpower = TheoryCraft_Outfits[outfit].formattackpower+(a.formattackpower or 0)
				TheoryCraft_Outfits[outfit].rangedattackpower = TheoryCraft_Outfits[outfit].rangedattackpower+(a.rangedattackpower or 0)
				TheoryCraft_Outfits[outfit].attackpower = TheoryCraft_Outfits[outfit].attackpower+(a.attackpower or 0)
				TheoryCraft_Outfits[outfit].strength = TheoryCraft_Outfits[outfit].strength+(a.strength or 0)
				TheoryCraft_Outfits[outfit].agility = TheoryCraft_Outfits[outfit].agility+(a.agility or 0)
				TheoryCraft_Outfits[outfit].stamina = TheoryCraft_Outfits[outfit].stamina+(a.stamina or 0)
				TheoryCraft_Outfits[outfit].intellect = TheoryCraft_Outfits[outfit].intellect+(a.intellect or 0)
				TheoryCraft_Outfits[outfit].spirit = TheoryCraft_Outfits[outfit].spirit+(a.spirit or 0)
				TheoryCraft_Outfits[outfit].totalmana = TheoryCraft_Outfits[outfit].totalmana+(a.totalmana or 0)
				TheoryCraft_Outfits[outfit].totalhealth = TheoryCraft_Outfits[outfit].totalhealth+(a.totalhealth or 0)
				if a.settype then
					TheoryCraft_Data.EquippedSets[a.settype] = (TheoryCraft_Data.EquippedSets[a.settype] or 0) + 1
				end
				a = TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot]["data"]
				if type(a) == "table" then
					for k,v in pairs(a) do
						if k ~= "procs" then
							if tonumber(v) then
								data[k] = (tonumber(data[k]) or 0)+v
							end
						else
							for k,v in pairs(a["procs"]) do
								i2 = 1
								if data["procs"] == nil then
									data["procs"] = {}
								end
								while data["procs"][i2] do i2 = i2 + 1 end
								data["procs"][i2] = {}
								data["procs"][i2].amount = v.amount
								data["procs"][i2].proc = v.proc
								data["procs"][i2].duration = v.duration
								data["procs"][i2].exact = v.exact
								data["procs"][i2].type = v.type
							end
						end
					end
				end
			end
			i = i + 1
		end

		local returndata
		for k,count in pairs(TheoryCraft_Data.EquippedSets) do
			if TheoryCraft_SetBonuses[k] then
				for k,v in pairs(TheoryCraft_SetBonuses[k]) do
					if (v["pieces"] <= count) then
						returndata = {}
						returndata = TheoryCraft_DequipLine(v["text"], returndata)
						for k,v in pairs(returndata) do
							TheoryCraft_Outfits[outfit][k] = (TheoryCraft_Outfits[outfit][k] or 0) - v
						end
						returndata = {}
						returndata = TheoryCraft_DequipSpecial(v["text"], returndata)
						for k,v in pairs(returndata) do
							data[k] = (data[k] or 0) - v
						end
					end
				end
			end
		end
	else
		while (TheoryCraft_Outfits[outfit].newstat[i]) do
			if TheoryCraft_Outfits[outfit].newstat[i].proc then
				i2 = 1
				if data["procs"] == nil then
					data["procs"] = {}
				end
				while data["procs"][i2] do i2 = i2 + 1 end
				data["procs"][i2] = {}
				data["procs"][i2].amount = TheoryCraft_Outfits[outfit].newstat[i].amount
				data["procs"][i2].proc = TheoryCraft_Outfits[outfit].newstat[i].proc
				data["procs"][i2].duration = TheoryCraft_Outfits[outfit].newstat[i].duration
				data["procs"][i2].exact = TheoryCraft_Outfits[outfit].newstat[i].exact
				data["procs"][i2].type = TheoryCraft_Outfits[outfit].newstat[i].type
			else
				data[TheoryCraft_Outfits[outfit].newstat[i].type] = (data[TheoryCraft_Outfits[outfit].newstat[i].type] or 0) + TheoryCraft_Outfits[outfit].newstat[i].amount
			end
			i = i + 1
		end
		for k,v in pairs(TheoryCraft_Locale.SetTranslator) do
			if v.id == TheoryCraft_Outfits[outfit].name then
				if TheoryCraft_SetBonuses[v.translated] then
					local returndata
					TheoryCraft_Data.EquippedSets[v.translated] = 100
					for k,v in pairs(TheoryCraft_SetBonuses[v.translated]) do
						returndata = {}
						returndata = TheoryCraft_DequipSpecial(v["text"], returndata)
						for k,v in pairs(returndata) do
							data[k] = (data[k] or 0) - v
						end
					end
				end
				break
			end
		end
	end
	local i2, ltext, _, start, found, foundme
	for k,count in pairs(TheoryCraft_Data.EquippedSets) do
		if TheoryCraft_SetBonuses[k] then
			foundme = false
			for k,v in pairs(TheoryCraft_SetBonuses[k]) do
				if (v["pieces"] <= count) then
					ltext = v["text"]
					foundme = false
					for k, v in pairs(TheoryCraft_Equips) do
						if (v.slot == nil) or (v.slot == slotname) then
							if ((foundme == false) or (v.me == nil)) then
								_, start, found = strfind(ltext, v.text)
								if _ then
									if v.proc then
										i2 = 1
										if data["procs"] == nil then
											data["procs"] = {}
										end
										while data["procs"][i2] do i2 = i2 + 1 end
										data["procs"][i2] = {}
										data["procs"][i2].amount = v.amount
										data["procs"][i2].proc = v.proc
										data["procs"][i2].duration = v.duration
										data["procs"][i2].exact = v.exact
										data["procs"][i2].type = v.type
									else
										if (v.amount) then
											data[v.type] = (data[v.type] or 0) + v.amount
										else
											data[v.type] = (data[v.type] or 0) + tonumber(found)
										end
										if (v.me) then
											foundme = true
										end
									end
								end
							end
						end
					end
					foundme = false
					for k, v in pairs(TheoryCraft_Sets) do
						if (v.slot == nil) or (v.slot == slotname) then
							if ((foundme == false) or (v.me == nil)) then
								_, start, found = strfind(ltext, v.text)
								if _ then
									if v.proc then
										i2 = 1
										if data["procs"] == nil then
											data["procs"] = {}
										end
										while data["procs"][i2] do i2 = i2 + 1 end
										data["procs"][i2] = {}
										data["procs"][i2].amount = v.amount
										data["procs"][i2].proc = v.proc
										data["procs"][i2].duration = v.duration
										data["procs"][i2].exact = v.exact
										data["procs"][i2].type = v.type
									else
										if (v.amount) then
											if v.amount == "n/100" then
												data[v.type] = (data[v.type] or 0) + tonumber(found)/100
											else
												data[v.type] = (data[v.type] or 0) + v.amount
											end
										else
											data[v.type] = (data[v.type] or 0) + tonumber(found)
										end
										if (v.me) then
											foundme = true
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local old = {}
local old2 = {}

function TheoryCraft_UpdateGear(arg1, dontgen, force)
	if TheoryCraft_SetBonuses == nil then
		TheoryCraft_SetBonuses = {}
	end
	if (arg1 ~= "player") then return end
	if not force then
		if UnitAffectingCombat("player") then
			TheoryCraft_Data.regenaftercombat = true
		end
	end
	TheoryCraft_DeleteTable(old)
	TheoryCraft_CopyTable(TheoryCraft_Data.EquipEffects, old)
	TheoryCraft_AddAllEquips(TheoryCraft_Data["outfit"], force)
	if TheoryCraft_Data.EquipEffects["MeleeAPMult"] == nil then
		TheoryCraft_Data.EquipEffects["MeleeAPMult"] = 1
	end
	if (dontgen == nil) then
		TheoryCraft_DeleteTable(old2)
		TheoryCraft_CopyTable(TheoryCraft_Data.Stats, old2)
		TheoryCraft_DeleteTable(TheoryCraft_Data.Stats)
		TheoryCraft_LoadStats()
		if (TheoryCraft_IsDifferent(old, TheoryCraft_Data.EquipEffects)) or (TheoryCraft_IsDifferent(old2, TheoryCraft_Data.Stats)) then
			TheoryCraft_GenerateAll()
		end
	end
end


function TheoryCraft_DequipLine(line, returndata)
	local _, start, found
	for k, v in pairs(TheoryCraft_Dequips) do
		if strfind(line, TheoryCraft_Locale.Set) then
			return returndata
		end
		_, start, found = strfind(line, v.text)
		if found then
			if v.type == "all" then
				returndata["strength"] = (returndata["strength"] or 0)-found
				returndata["agility"] = (returndata["agility"] or 0)-found
				returndata["stamina"] = (returndata["stamina"] or 0)-found
				returndata["intellect"] = (returndata["intellect"] or 0)-found
				returndata["spirit"] = (returndata["spirit"] or 0)-found
			elseif v.type == "formattackpower" then
				returndata[v.type] = (returndata[v.type] or 0)-found
				break
			elseif v.type == "attackpower" then
				returndata[v.type] = (returndata[v.type] or 0)-found
				returndata["rangedattackpower"] = (returndata["rangedattackpower"] or 0)-found
				break
			else
				returndata[v.type] = (returndata[v.type] or 0)-found
			end
		end
	end
	return returndata
end

local b = TheoryCraft_SetsDequipOnly

function TheoryCraft_DequipSpecial(line, returndata)
	local i = 1
	local amount
	while (b[i]) do
		if strfind(line, TheoryCraft_Locale.Set) then
			return returndata
		end
		if string.find(line, b[i].text) then
			if b[i].amount == "n" then
				amount = tonumber(findpattern(findpattern(line, b[i].text), "%d+"))
			elseif b[i].amount == "n/100" then
				amount = tonumber(findpattern(findpattern(line, b[i].text), "%d+"))/100
			else
				amount = b[i].amount
			end
			returndata[b[i].type] = (returndata[b[i].type] or 0)-amount
		end
		i = i + 1
	end
	return returndata
end

function TheoryCraft_DequipEffect (slotname, returndata, equippedsets)
	if (slotname ~= "test") then
		TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
		TheoryCraftTooltip:SetInventoryItem ("player", GetInventorySlotInfo(slotname.."Slot"))
	end
	local index = 1
	local i, found
	local ltext
	while (getglobal("TheoryCraftTooltipTextLeft"..index) ~= nil) do
		ltext = getglobal("TheoryCraftTooltipTextLeft"..index):GetText();
		if (ltext == nil) then
			break
		end
		if strfind(ltext, TheoryCraft_Locale.Set) then
			if equippedsets then
				ltext = string.sub(ltext, 1, string.find(ltext, TheoryCraft_Locale.Set)-2)
				equippedsets[ltext] = (equippedsets[ltext] or 0)+1
			end
			break
		else
			returndata = TheoryCraft_DequipLine(ltext, returndata)
		end
		index = index + 1
	end
	TheoryCraftTooltip:ClearLines()
	return returndata
end

function TheoryCraft_AddToCustom(linkid)
	if (TheoryCraft_Settings["CustomOutfit"] == nil) then
		TheoryCraft_Settings["CustomOutfit"] = TheoryCraft_Outfits[3]
	end
	if (TheoryCraft_Settings["CustomOutfit"].slots == nil) then
		TheoryCraft_Settings["CustomOutfit"].slots = {}
	end
	if (linkid == nil) or (string.find(linkid, "item:%d+:%d+:%d+:%d+") == nil) then
		return
	end
	linkid = string.sub(linkid, string.find(linkid, "item:%d+:%d+:%d+:%d+"))
	if linkid == nil then
		return
	end
	TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
	TheoryCraftTooltip:SetHyperlink(linkid)
	if (getglobal(TheoryCraftTooltip:GetName().."TextLeft1") == nil) then
		return
	end
	local itemname, itemlink, itemrarity = GetItemInfo(linkid)
	local r, g, b, hex = GetItemQualityColor(itemrarity) 
	itemname = hex.."|H"..itemlink.."|h["..itemname.."]|h|r"
	local index = 1
	local ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..index):GetText()
	if ltext == nil then
		return
	end
	local found = false
	local realslot = false
	local both = false
	while (ltext ~= nil) and (found == false) do
		local i = 1
		while (TheoryCraft_SlotNames[i]) do
			if (ltext == TheoryCraft_SlotNames[i].text) then
				if (found) then
					if TheoryCraft_Settings["CustomOutfit"].slots[found] then
						TheoryCraft_Settings["CustomOutfit"].slots[TheoryCraft_SlotNames[i].slot] = TheoryCraft_Settings["CustomOutfit"].slots[found]
					end
				else
					found = TheoryCraft_SlotNames[i].slot
					realslot = TheoryCraft_SlotNames[i].realslot
					both = TheoryCraft_SlotNames[i].both
				end
			end
			i = i + 1
		end
		ltext = getglobal(TheoryCraftTooltip:GetName().."TextLeft"..index):GetText()
		index = index + 1
	end
	if found == false then
		return
	end
	if both then
		TheoryCraft_Settings["CustomOutfit"].slots["Off HandItemName"] = nil
		TheoryCraft_Settings["CustomOutfit"].slots["Off Hand"] = nil
	end
	local itemdata = {}
	local equippedsets = {}
	TheoryCraft_AddEquipEffect (realslot, "test", itemdata, equippedsets)
	TheoryCraft_Settings["CustomOutfit"].slots[found] = {}
	TheoryCraft_Settings["CustomOutfit"].slots[found]["data"] = itemdata
	TheoryCraft_Settings["CustomOutfit"].slots[found]["name"] = itemname
	TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
	TheoryCraftTooltip:SetHyperlink(linkid)
	if (getglobal(TheoryCraftTooltip:GetName().."TextLeft1") == nil) then
		return
	end
	local returndata = {}
	returndata = TheoryCraft_DequipEffect ("test", returndata)
	TheoryCraft_Settings["CustomOutfit"].slots[found]["stats"] = {}
	local a = TheoryCraft_Settings["CustomOutfit"].slots[found]["stats"]
	for k,v in pairs(equippedsets) do
		a.settype = k
	end
	if returndata["meleecritchance"] then a.meleecritchance = -returndata["meleecritchance"] end
	if returndata["formattackpower"] then a.formattackpower = -returndata["formattackpower"] end
	if returndata["rangedattackpower"] then a.rangedattackpower = -returndata["rangedattackpower"] end
	if returndata["attackpower"] then a.attackpower = -returndata["attackpower"] end
	if returndata["strength"] then a.strength = -returndata["strength"] end
	if returndata["agility"] then a.agility = -returndata["agility"] end
	if returndata["stamina"] then a.stamina = -returndata["stamina"] end
	if returndata["intellect"] then a.intellect = -returndata["intellect"] end
	if returndata["spirit"] then a.spirit = -returndata["spirit"] end
	if returndata["totalmana"] then a.totalmana = -returndata["totalmana"] end
	if returndata["totalhealth"] then a.totalhealth = -returndata["totalhealth"] end
end
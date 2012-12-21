-- These functions still need rewriting
-- They were written before I new about for in pairs, captures
-- or even patterns other then %d+... you gotta start somewhere =)

local data = {}
local _, class = UnitClass("player")

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

function TheoryCraft_getMinMax(spelldata, returndata, frame)
	if returndata["description"] == nil then return end

	local description = returndata["description"]
	local baseincrease = returndata["baseincrease"]
	local dotbaseincrease = baseincrease
	local gearbaseincrease = baseincrease
	if spelldata.ismelee == nil then
		baseincrease = baseincrease*returndata["talentbaseincreaseupfront"]
		if spelldata.talentsbeforegear == nil then
			gearbaseincrease = gearbaseincrease*returndata["talentbaseincrease"]*returndata["talentbaseincreaseupfront"]
		end
		baseincrease = baseincrease*returndata["talentbaseincrease"]
		dotbaseincrease = dotbaseincrease*returndata["talentbaseincrease"]
	end
	local plusdam = (returndata["damfinal"] or 0)*gearbaseincrease
	local plusdam2 = returndata["plusdam2"] or 0
	local to = TheoryCraft_Locale.to
	returndata["backstabmult"] = 1

	if spelldata.autoattack then
		returndata["mindamage"] = (TheoryCraft_GetStat("MeleeMin")+(TheoryCraft_Data.Stats["attackpower"]/14)*TheoryCraft_GetStat("MainSpeed"))
		returndata["maxdamage"] = returndata["mindamage"]-TheoryCraft_GetStat("MeleeMin")+TheoryCraft_GetStat("MeleeMax")
		baseincrease = TheoryCraft_GetStat("Meleemodifier")+TheoryCraft_GetStat("Meleetalentmod")
		returndata["mindamage"] = returndata["mindamage"]*baseincrease
		returndata["maxdamage"] = returndata["maxdamage"]*baseincrease
		returndata["critdmgchance"] = TheoryCraft_Data.Stats["meleecritchance"]/100
		if TheoryCraft_GetStat("OffhandMin") == 0 then
			returndata["description"] = "Attacks the target for "..math.floor(returndata["mindamage"]).." to "..math.floor(returndata["maxdamage"]).."."
		else
			returndata["offhandmindamage"] = (TheoryCraft_GetStat("OffhandMin")+(TheoryCraft_Data.Stats["attackpower"]/14)*TheoryCraft_GetStat("OffhandSpeed"))
			returndata["offhandmaxdamage"] = returndata["offhandmindamage"]-TheoryCraft_GetStat("OffhandMin")+TheoryCraft_GetStat("OffhandMax")
			local offhandbaseincrease = baseincrease/2
			returndata["offhandmindamage"] = returndata["offhandmindamage"]*offhandbaseincrease
			returndata["offhandmaxdamage"] = returndata["offhandmaxdamage"]*offhandbaseincrease
			if TheoryCraft_GetStat("MeleeMin") == 0 then
				returndata["description"] = "Off-hand attacks for "..math.floor(returndata["offhandmindamage"]).." to "..math.floor(returndata["offhandmaxdamage"]).."."
			else
				returndata["description"] = "Main hand attacks the target for "..math.floor(returndata["mindamage"]).." to "..math.floor(returndata["maxdamage"])..", off-hand for "..math.floor(returndata["offhandmindamage"]).." to "..math.floor(returndata["offhandmaxdamage"]).."."
			end
		end
		return
	end
	if spelldata.iscombo then
		local _, convert
		_, _, convert = strfind(returndata["description"], TheoryCraft_MeleeComboEnergyConverter)
		returndata["comboconvert"] = tonumber(convert)
		for points, tmp, mindamage, maxdamage in string.gfind(returndata["description"], TheoryCraft_MeleeComboReader) do
			returndata["combo"..points.."mindamage"] = mindamage
			returndata["combo"..points.."maxdamage"] = maxdamage
		end
		returndata["beforecombo"] = returndata["description"]
	elseif spelldata.shoot then
		local a = TheoryCraft_Locale.MinMax
		if (TheoryCraft_Data.EquipEffects["RangedMin"]) and (TheoryCraft_Data.EquipEffects["RangedMin"] ~= 0) then
			returndata["mindamage"] = TheoryCraft_Data.EquipEffects["RangedMin"]
			returndata["maxdamage"] = TheoryCraft_Data.EquipEffects["RangedMax"]
			returndata["description"] = a.autoshotbefore..returndata["mindamage"]..to..returndata["maxdamage"]..a.autoshotafter
		else
			returndata["mindamage"] = 0
			returndata["maxdamage"] = 0
			description = a.shooterror
		end
		returndata["critchance"] = 5
		returndata["critbonus"] = 0.5
		if (TheoryCraft_Data.EquipEffects["RangedSpeed"]) and (TheoryCraft_Data.EquipEffects["RangedSpeed"] ~= 0) then
			local tmp = (returndata["mindamage"]+returndata["maxdamage"])/2
			returndata["dps"] = (tmp+tmp*returndata["critbonus"]*returndata["critchance"]/100)/TheoryCraft_Data.EquipEffects["RangedSpeed"]
		else
			returndata["dps"] = 0
		end
	elseif spelldata.autoshot then
-- Autoshot is calculated here
		returndata["mindamage"] = TheoryCraft_GetStat("RangedMin")+TheoryCraft_Data.Stats["rangedattackpower"]/14*TheoryCraft_GetStat("RangedSpeed")
		returndata["maxdamage"] = returndata["mindamage"]-TheoryCraft_GetStat("RangedMin")+TheoryCraft_GetStat("RangedMax")
		baseincrease = TheoryCraft_GetStat("Rangedmodifier")+TheoryCraft_GetStat("Rangedtalentmod")
		returndata["maxdamage"] = returndata["maxdamage"]*baseincrease+TheoryCraft_GetStat("AmmoDPS")*TheoryCraft_GetStat("RangedSpeed")
		returndata["mindamage"] = returndata["mindamage"]*baseincrease+TheoryCraft_GetStat("AmmoDPS")*TheoryCraft_GetStat("RangedSpeed")
		returndata["description"] = TheoryCraft_Locale.MinMax.autoshotbefore..(round(returndata["mindamage"]))..to..(round(returndata["maxdamage"]))..TheoryCraft_Locale.MinMax.autoshotafter

		local averageauto, averageaimed, averagemulti, averagearcane = 0, 0, 0, 0
		local aimedmana, multimana = 0, 0
		averageauto = (returndata["maxdamage"]+returndata["mindamage"])/2
		averageauto = averageauto+averageauto*TheoryCraft_Data.Stats["rangedcritchance"]/100*returndata["critbonus"]
		for i = 1, 20 do
			if TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.aimedshotname.."("..i..")"] and TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.aimedshotname.."("..i..")"]].averagedam then
				averageaimed = TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.aimedshotname.."("..i..")"]].averagedam
				aimedmana = TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.aimedshotname.."("..i..")"]].manacost
			end
			if TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.multishotname.."("..i..")"] and TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.multishotname.."("..i..")"]].averagedam then
				averagemulti = TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.multishotname.."("..i..")"]].averagedam
				multimana = TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.multishotname.."("..i..")"]].manacost
			end
			if TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.arcaneshotname.."("..i..")"] and TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.arcaneshotname.."("..i..")"]].dps then
				averagearcane = TheoryCraft_TooltipData[TheoryCraft_TooltipData[TheoryCraft_Locale.MinMax.arcaneshotname.."("..i..")"]].dps
			end
		end
--		averageauto = 651
--		averageaimed = 1293
--		averagemulti = 662

		local rotationlength1, rotationlength2, rotationdps1, rotationdps2, autoshotcount1, autoshotcount2
		local speed = TheoryCraft_GetStat("RangedSpeed")*TheoryCraft_GetStat("Rangedhastebonus")
--		speed = 2.19
		returndata["dps"] = averageauto/speed

		returndata["manacost"] = aimedmana+multimana
		returndata["basemanacost"] = aimedmana+multimana
		returndata["dontshowmana"] = true

-- MS Rotation Calculated Here:

		rotationlength1 = 10
		rotationlength2 = math.ceil(7/speed)*speed+3
		if (speed > 3) or (averageaimed == 0) then
			autoshotcount1 = math.floor(rotationlength1/speed)
			autoshotcount2 = math.floor(rotationlength2/speed)
		else
			autoshotcount1 = math.floor((rotationlength1-3)/speed)+1
			autoshotcount2 = math.floor((rotationlength2-3)/speed)+1
		end

		rotationdps1 = (averageaimed+averagemulti+averageauto*autoshotcount1)/rotationlength1
		rotationdps2 = (averageaimed+averagemulti+averageauto*autoshotcount2)/rotationlength2
		if (rotationdps1 > rotationdps2) then
			returndata["msrotationdps"] = rotationdps1
			returndata["msrotationlength"] = rotationlength1
			if TheoryCraft_Settings["procs"] then
				returndata["manacost"] = returndata["manacost"]-autoshotcount1*0.04*TheoryCraft_GetStat("Beastmanarestore")
			end
		else
			returndata["msrotationdps"] = rotationdps2
			returndata["msrotationlength"] = rotationlength2
			if TheoryCraft_Settings["procs"] then
				returndata["manacost"] = returndata["manacost"]-autoshotcount2*0.04*TheoryCraft_GetStat("Beastmanarestore")
			end
		end
		returndata["regencasttime"] = returndata["msrotationlength"]-3

-- AS Rotation Calculated Here:

		rotationlength1 = 9
		rotationlength2 = math.ceil(6/speed)*speed+3
		if rotationlength2 > 10 then
			rotationlength2 = 9
		end
		if (speed > 3) or (averageaimed == 0) then
			autoshotcount1 = math.floor(rotationlength1/speed)
			autoshotcount2 = math.floor(rotationlength2/speed)
		else
			autoshotcount1 = math.floor((rotationlength1-3)/speed)+1
			autoshotcount2 = math.floor((rotationlength2-3)/speed)+1
		end

		rotationdps1 = (averageaimed*6+averagemulti*5+averageauto*autoshotcount1*6)/(rotationlength1*6)
		rotationdps2 = (averageaimed*6+averagemulti*5+averageauto*autoshotcount2*6)/(rotationlength2*6)
		if (rotationdps1 > rotationdps2) then
			returndata["asrotationdps"] = rotationdps1
			returndata["asrotationlength"] = rotationlength1
		else
			returndata["asrotationdps"] = rotationdps2
			returndata["asrotationlength"] = rotationlength2
		end

-- MS/Arc Rotation Calculated Here:

		returndata["arcrotationdps"] = (averagearcane*10+averagemulti+averageauto*(10/speed))/10
		returndata["arcmagicdps"] = averagearcane
	elseif (spelldata.ismelee) or (spelldata.isranged) then
		local normalized
		if spelldata.noscale then
			returndata["backstabmult"] = 0
		end
		if spelldata.isranged then
			normalized = (TheoryCraft_Data.Stats["rangedattackpower"]/14)*returndata["RangedAPMult"]
			returndata["mindamage"] = TheoryCraft_Data.EquipEffects["RangedMin"]
			returndata["maxdamage"] = TheoryCraft_Data.EquipEffects["RangedMax"]
		else
			if spelldata.forcemult then
				normalized = TheoryCraft_Data.Stats["attackpower"]/14*spelldata.forcemult
			elseif spelldata.nextattack then
				normalized = TheoryCraft_Data.Stats["attackpower"]/14*TheoryCraft_Data.EquipEffects["MainSpeed"]
			else
				normalized = TheoryCraft_Data.Stats["attackpower"]/14*(TheoryCraft_Data.EquipEffects["MeleeAPMult"] or 1)
			end
			returndata["mindamage"] = TheoryCraft_Data.EquipEffects["MeleeMin"]
			returndata["maxdamage"] = TheoryCraft_Data.EquipEffects["MeleeMax"]
		end

		local i = 1
		local removetalents = 1
		baseincrease = 0
		removetalents = removetalents + TheoryCraft_GetStat(spelldata.id.."modifier")
		baseincrease = baseincrease + TheoryCraft_GetStat(spelldata.id.."baseincrease")
		baseincrease = baseincrease + TheoryCraft_GetStat(spelldata.id.."modifier")+TheoryCraft_GetStat(spelldata.id.."talentmod")
		while spelldata.Schools[i] do
			if (spelldata.Schools[i] ~= "Ranged") and (spelldata.Schools[i] ~= "Melee") then
				removetalents = removetalents + TheoryCraft_GetStat(spelldata.Schools[i].."modifier")
				baseincrease = baseincrease + TheoryCraft_GetStat(spelldata.Schools[i].."baseincrease")
			end
			baseincrease = baseincrease+TheoryCraft_GetStat(spelldata.Schools[i].."modifier")+TheoryCraft_GetStat(spelldata.Schools[i].."talentmod")
			i = i + 1
		end
		local a = TheoryCraft_MeleeMinMaxReader
		local _
		local found
		if spelldata.dontusemelee then
			baseincrease = 1
		end
		TheoryCraft_DeleteTable(data)
		returndata["addeddamage"] = 0
		local range
		for k, pattern in pairs(a) do
			if strfind(returndata["description"], pattern.pattern) then
				_, _, data[1], data[2], data[3], data[4], data[5], data[6] = strfind(returndata["description"], pattern.pattern)
				for k, type in pairs(pattern.type) do
					if (type == "mindamage") or (type == "maxdamage") then
						returndata[type] = data[k]
						range = true
					end
				end
			end
		end
		if range then
			range = nil
		elseif strfind(returndata["description"], "%d+"..to.."%d+") then
			range = true
			returndata["description"] = string.gsub(returndata["description"], "%d+"..to.."%d+", findpattern(findpattern(returndata["description"], "%d+"..to.."%d+"), "%d+"))
		end
		for k, pattern in pairs(a) do
			if strfind(returndata["description"], pattern.pattern) then
				_, _, data[1], data[2], data[3], data[4], data[5], data[6] = strfind(returndata["description"], pattern.pattern)
				for k, type in pairs(pattern.type) do
					if (type == "backstabmult") or (type == "bloodthirstmult") then
						returndata[type] = tonumber(data[k])/100
					else
						returndata[type] = data[k]
					end
				end
			end
		end
		if returndata["bloodthirstmult"] then
			returndata["mindamage"] = returndata["bloodthirstmult"]*TheoryCraft_Data.Stats["attackpower"]
			returndata["maxdamage"] = returndata["mindamage"]
			returndata["backstabmult"] = 1
			normalized = 0
		end
		if range then
			returndata["addeddamage"] = returndata["addeddamage"] + 0.5
		end
		if class ~= "ROGUE" then
			returndata["addeddamage"] = returndata["addeddamage"]/removetalents
		end
		if returndata["backstabmult"] ~= 1 then
			returndata["backstabmult"] = returndata["backstabmult"]/removetalents
		end
--		Print("("..round(normalized).."+"..returndata["mindamage"]..")*"..returndata["backstabmult"].."+"..returndata["addeddamage"]..")*"..baseincrease)
		local ranged
		for k,v in pairs(returndata["schools"]) do
			if v == "Ranged" then
				ranged = true
			end
		end
		returndata["mindamage"] = ((normalized+returndata["mindamage"])*returndata["backstabmult"] + returndata["addeddamage"])*baseincrease
		returndata["maxdamage"] = ((normalized+returndata["maxdamage"])*returndata["backstabmult"] + returndata["addeddamage"])*baseincrease
		if ranged then
			returndata["mindamage"] = returndata["mindamage"]+TheoryCraft_GetStat("AmmoDPS")*TheoryCraft_GetStat("RangedSpeed")
			returndata["maxdamage"] = returndata["maxdamage"]+TheoryCraft_GetStat("AmmoDPS")*TheoryCraft_GetStat("RangedSpeed")
		end

		a = TheoryCraft_MeleeMinMaxReplacer
		local damagetext
		if returndata["mindamage"] == returndata["maxdamage"] then
			damagetext = round(returndata["mindamage"])
		else
			damagetext = round(returndata["mindamage"])..to..round(returndata["maxdamage"])
		end
		local blocktext
		if TheoryCraft_Data.EquipEffects["ShieldEquipped"] then
			blocktext = floor(TheoryCraft_GetStat("BlockValue"))
		end
		for k, pattern in pairs(a) do
			if strfind(returndata["description"], pattern.search) then
				local replace = string.gsub(pattern.replacewith, "%$damage%$", damagetext)
				if (not strfind(replace, "%$blockvalue%$")) or (blocktext) then
					if blocktext then
						replace = string.gsub(replace, "%$blockvalue%$", blocktext)
					end
					returndata["description"] = string.gsub(returndata["description"], pattern.search, replace)
				end
				break
			end
		end
		return
	elseif (spelldata.isseal) then
		local a = TheoryCraft_Locale.MinMax
		local alreadybuffedbonus = TheoryCraft_GetStat("AttackPowerCrusader")
		local attackbaseincrease = TheoryCraft_GetStat(spelldata.id.."baseincrease")
		attackbaseincrease = attackbaseincrease + TheoryCraft_GetStat("Meleemodifier")+TheoryCraft_GetStat("Meleetalentmod")
		attackbaseincrease = attackbaseincrease + TheoryCraft_GetStat(spelldata.id.."modifier")+TheoryCraft_GetStat(spelldata.id.."talentmod")
		local minDamage, maxDamage, lengthofdamagetext
		local baseincrease = 1
		while spelldata.Schools[i] do
			if (spelldata.Schools[i] ~= "Ranged") and (spelldata.Schools[i] ~= "Melee") then
				baseincrease = baseincrease + TheoryCraft_GetStat(spelldata.Schools[i].."baseincrease")
			end
			baseincrease = baseincrease+TheoryCraft_GetStat(spelldata.Schools[i].."modifier")+TheoryCraft_GetStat(spelldata.Schools[i].."talentmod")
			i = i + 1
		end
		if (spelldata.crusader) then
			local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player");
			local attackspeed = UnitAttackSpeed("player")
			lowDmg = lowDmg/attackspeed
			hiDmg = hiDmg/attackspeed
			local apbonus = findpattern(description, a.crusader)
			apbonus = tonumber(findpattern(apbonus, "%d+")) or 0

			maxDamage = ((TheoryCraft_Data.Stats["attackpower"]-alreadybuffedbonus)/14*TheoryCraft_Data.EquipEffects["MainSpeed"]+TheoryCraft_Data.EquipEffects["MeleeMax"])
			minDamage = ((TheoryCraft_Data.Stats["attackpower"]-alreadybuffedbonus)/14*TheoryCraft_Data.EquipEffects["MainSpeed"]+TheoryCraft_Data.EquipEffects["MeleeMin"])
			local averagehit = (maxDamage+minDamage)/2*attackbaseincrease
			averagehit = (averagehit + averagehit * TheoryCraft_Data.Stats["meleecritchance"]/100)/TheoryCraft_Data.EquipEffects["MainSpeed"]

			returndata["sealunbuffed"] = averagehit
			maxDamage = ((TheoryCraft_Data.Stats["attackpower"]+apbonus-alreadybuffedbonus)/14*TheoryCraft_Data.EquipEffects["MainSpeed"]+TheoryCraft_Data.EquipEffects["MeleeMax"])
			minDamage = ((TheoryCraft_Data.Stats["attackpower"]+apbonus-alreadybuffedbonus)/14*TheoryCraft_Data.EquipEffects["MainSpeed"]+TheoryCraft_Data.EquipEffects["MeleeMin"])
			local averagehit = (maxDamage+minDamage)/2*attackbaseincrease
			averagehit = (averagehit + averagehit * TheoryCraft_Data.Stats["meleecritchance"]/100)/TheoryCraft_Data.EquipEffects["MainSpeed"]
			returndata["sealbuffed"] = averagehit
		elseif (spelldata.command) then
			minDamage = findpattern(description, "%d+"..to.."%d+")
			maxDamage = findpattern(minDamage, to.."%d+")
			minDamage = string.sub(minDamage, string.find(minDamage, "%d+", 0))
			maxDamage = string.sub(maxDamage, string.find(maxDamage, "%d+", 0))
			lengthofdamagetext = string.len(minDamage..to..maxDamage);
			minDamage = math.floor((minDamage + plusdam)*baseincrease)
			maxDamage = math.floor((maxDamage + plusdam)*baseincrease)
			local tmp2 = string.sub(description, string.find(description, "%d+"..to.."%d+", 0)+lengthofdamagetext)
			local minDamage2 = findpattern(tmp2, "%d+"..to.."%d+")
			local maxDamage2 = findpattern(minDamage2, to.."%d+")
			minDamage2 = string.sub(minDamage2, string.find(minDamage2, "%d+", 0))
			maxDamage2 = string.sub(maxDamage2, string.find(maxDamage2, "%d+", 0))
			minDamage2 = math.floor((minDamage2 + plusdam2)*baseincrease)
			maxDamage2 = math.floor((maxDamage2 + plusdam2)*baseincrease)

			description = string.gsub(description, "%d+"..to.."%d+", "tmpABC", 1)
			description = string.gsub(description, "%d+"..to.."%d+", minDamage2..to..maxDamage2)
			description = string.gsub(description, "tmpABC", minDamage..to..maxDamage)

			maxDamage = ((TheoryCraft_Data.Stats["attackpower"]-alreadybuffedbonus)/14*TheoryCraft_Data.EquipEffects["MainSpeed"]+TheoryCraft_Data.EquipEffects["MeleeMax"])*attackbaseincrease
			minDamage = ((TheoryCraft_Data.Stats["attackpower"]-alreadybuffedbonus)/14*TheoryCraft_Data.EquipEffects["MainSpeed"]+TheoryCraft_Data.EquipEffects["MeleeMin"])*attackbaseincrease
			local averagehit = (maxDamage+minDamage)/2
			averagehit = averagehit + averagehit * TheoryCraft_Data.Stats["meleecritchance"]/100

			returndata["sealunbuffed"] = averagehit/TheoryCraft_Data.EquipEffects["MainSpeed"]
			averagehit = averagehit+(7/(60/TheoryCraft_Data.EquipEffects["MainSpeed"])*0.7)*averagehit
			returndata["sealbuffed"] = averagehit/TheoryCraft_Data.EquipEffects["MainSpeed"]
		elseif (spelldata.righteousness) then
			minDamage = findpattern(description, "%d+"..to.."%d+")
			maxDamage = findpattern(minDamage, to.."%d+")
			minDamage = string.sub(minDamage, string.find(minDamage, "%d+", 0))
			maxDamage = string.sub(maxDamage, string.find(maxDamage, "%d+", 0))
			lengthofdamagetext = string.len(minDamage..to..maxDamage);
			minDamage = math.floor((minDamage + plusdam)*baseincrease)
			maxDamage = math.floor((maxDamage + plusdam)*baseincrease)
			local tmp2 = string.sub(description, string.find(description, "%d+"..to.."%d+", 0)+lengthofdamagetext)
			local minDamage2 = findpattern(tmp2, "%d+"..to.."%d+")
			local maxDamage2 = findpattern(minDamage2, to.."%d+")
			if minDamage2 and string.find(minDamage2, "%d+") then
				minDamage2 = string.sub(minDamage2, string.find(minDamage2, "%d+", 0))
				maxDamage2 = string.sub(maxDamage2, string.find(maxDamage2, "%d+", 0))
				minDamage2 = math.floor((minDamage2 + plusdam2)*baseincrease)
				maxDamage2 = math.floor((maxDamage2 + plusdam2)*baseincrease)
				description = string.gsub(description, "%d+"..to.."%d+", "tmpABC", 1)
				description = string.gsub(description, "%d+"..to.."%d+", minDamage2..to..maxDamage2)
				description = string.gsub(description, "tmpABC", minDamage..to..maxDamage)
			else
				description = string.gsub(description, "%d+"..to.."%d+", minDamage..to..maxDamage)
			end
		end
		returndata["description"] = description
	elseif (spelldata.holynova) then
		local minDamage = findpattern(description, "%d+"..to.."%d+")
		local maxDamage = findpattern(minDamage, to.."%d+")
		minDamage = findpattern(minDamage, "%d+")
		maxDamage = findpattern(maxDamage, "%d+")
		local lengthofdamagetext = string.len(minDamage..to..maxDamage);
		minDamage = minDamage*baseincrease + plusdam
		maxDamage = maxDamage*baseincrease + plusdam

		local minHeal = string.sub(description, string.find(description, "%d+"..to.."%d+")+lengthofdamagetext)
		minHeal = findpattern(minHeal, "%d+"..to.."%d+")
		local maxHeal = findpattern(minHeal, to.."%d+")
		minHeal = findpattern(minHeal, "%d+")
		maxHeal = findpattern(maxHeal, "%d+")
		local basehealincrease = TheoryCraft_GetStat("Allbaseincrease")+(TheoryCraft_GetStat("Holybaseincrease") or 0)+(TheoryCraft_GetStat("Healingbaseincrease") or 0)
		local plusheal = (TheoryCraft_GetStat("All") + TheoryCraft_GetStat("Holy") + TheoryCraft_GetStat("Healing"))*spelldata.percentheal

		local lengthofhealtext = string.len(minHeal..to..maxHeal);
		minHeal = (minHeal + plusheal)*basehealincrease
		maxHeal = (maxHeal + plusheal)*basehealincrease

		description = 	string.sub(description, 0, string.find(description, "%d+"..to.."%d+", 0)-1)..
				round(minDamage)..to..round(maxDamage)..
				string.sub(description, string.find(description, "%d+"..to.."%d+", 0)+lengthofdamagetext)
		local descriptionbegin = string.sub(description, 0, string.find(description, "%d+"..to.."%d+")+string.len(minDamage..to..maxDamage))
		local descriptionrest = string.sub(description, string.find(description, "%d+"..to.."%d+")+string.len(minDamage..to..maxDamage)+1)
		descriptionrest=string.sub(descriptionrest, 0, string.find(descriptionrest, "%d+"..to.."%d+", 0)-1)..
				round(minHeal)..to..round(maxHeal)..
				string.sub(descriptionrest, string.find(descriptionrest, "%d+"..to.."%d+", 0)+lengthofhealtext)
		description = descriptionbegin..descriptionrest
		returndata["description"] = description
		returndata["critdmgchance"] = returndata["critchance"]
		returndata["crithealchance"] = returndata["critchance"]
		returndata["mindamage"] = minDamage
		returndata["maxdamage"] = maxDamage
		returndata["minheal"] = minHeal
		returndata["maxheal"] = maxHeal
		return
	else
		local a = TheoryCraft_SpellMinMaxReader
		local _
		TheoryCraft_DeleteTable(data)
		local found
		for k, pattern in pairs(a) do
			if strfind(returndata["description"], pattern.pattern) then
				_, _, data[1], data[2], data[3], data[4], data[5], data[6] = strfind(returndata["description"], pattern.pattern)
				for k, type in pairs(pattern.type) do
					if type == "bothdamage" then
						returndata["mindamage"] = tonumber(data[k])
						returndata["maxdamage"] = tonumber(data[k])
					elseif type == "dotbothdamage" then
						returndata["dotmindamage"] = tonumber(data[k])
						returndata["dotmaxdamage"] = tonumber(data[k])
					else
						returndata[type] = data[k]
						returndata[type] = data[k]
					end
				end
				found = pattern
				break
			end
		end
		if found == nil then return end

		local baseincrease = returndata["baseincrease"]
		local dotbaseincrease = baseincrease
		local gearbaseincrease = baseincrease
		baseincrease = baseincrease*returndata["talentbaseincreaseupfront"]
		if spelldata.talentsbeforegear == nil then
			gearbaseincrease = gearbaseincrease*returndata["talentbaseincrease"]*returndata["talentbaseincreaseupfront"]
		end
		baseincrease = baseincrease*returndata["talentbaseincrease"]
		dotbaseincrease = dotbaseincrease*returndata["talentbaseincrease"]
		local plusdam = (returndata["damfinal"] or 0)*gearbaseincrease
		local plusdam2 = returndata["plusdam2"] or 0
		returndata["backstabmult"] = 1

		returndata["basemindamage"] = returndata["mindamage"]
		returndata["basemaxdamage"] = returndata["maxdamage"]
		if returndata["mindamage"] then
			returndata["mindamage"] = returndata["mindamage"]*baseincrease + plusdam
		end
		if returndata["maxdamage"] then
			returndata["maxdamage"] = returndata["maxdamage"]*baseincrease + plusdam
		end
		if returndata["dotmindamage"] then
			returndata["dotmindamage"] = returndata["dotmindamage"]*dotbaseincrease + plusdam2
		end
		if returndata["dotmaxdamage"] then
			returndata["dotmaxdamage"] = returndata["dotmaxdamage"]*dotbaseincrease + plusdam2
		end
		if returndata["dotmindamage"] and returndata["dotmaxdamage"] then
			returndata["dotdamage"] = (returndata["dotmindamage"]+returndata["dotmaxdamage"])/2
		end
		if returndata["hotheal"] then
			returndata["hotheal"] = returndata["hotheal"]*dotbaseincrease + plusdam2
		end
		if returndata["oversecs"] then
			if returndata["dotdamage"] then
				returndata["dotdps"] = returndata["dotdamage"]/returndata["oversecs"]
			end
			if returndata["hotheal"] then
				returndata["hothps"] = returndata["hotheal"]/returndata["oversecs"]
			end
		end

		for k, type in pairs(found.type) do
			if type == "bothdamage" then
				data[k] = round(returndata["mindamage"])
			elseif type == "dotbothdamage" then
				data[k] = round(returndata["dotmindamage"])
			else
				if tonumber(returndata[type]) then
					data[k] = round(returndata[type])
				else
					data[k] = returndata[type]
				end
			end
		end

		local counter = 0
		local function replacer()
			counter = counter + 1
			return data[counter]
		end
		returndata["description"] = string.gsub(returndata["description"], found.pattern, string.gsub(found.pattern, "(%(.-%))", replacer), 1)
	end
	if (spelldata.isheal) then
		returndata["minheal"] = returndata["mindamage"]
		returndata["maxheal"] = returndata["maxdamage"]
		if spelldata.hasdot then
			returndata["hothps"] = returndata["dotdps"]
			returndata["hotheal"] = returndata["dotdamage"]
		end
		returndata["mindamage"] = nil
		returndata["maxdamage"] = nil
		returndata["dotdps"] = nil
		returndata["dotdamage"] = nil
	end
	if (spelldata.drain) then
		returndata["minheal"] = returndata["mindamage"]+returndata["mindamage"]*returndata["illum"]*baseincrease
		returndata["maxheal"] = returndata["maxdamage"]+returndata["maxdamage"]*returndata["illum"]*baseincrease
	end
end

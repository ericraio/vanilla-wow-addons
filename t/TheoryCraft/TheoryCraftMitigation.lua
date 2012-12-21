local _, class = UnitClass("player")
local _, spellname, spellrank, targetname, damage, crit, armor, i, spelldata, idx
local damagereduction, ul, oldarmor, oldarmorvalue, sunder, absorbed

function TheoryCraft_ParseCombat(arg1)
	if TheoryCraft_GetStat("DontMitigate") ~= 0 then return end
	if (TheoryCraft_Data["outfit"]) and (TheoryCraft_Data["outfit"] ~= -1) and (TheoryCraft_Data["outfit"] ~= 1) then
		return
	end
	_, _, absorbed = strfind(arg1, TheoryCraft_Locale.Absorbed)
	_, _, spellname, targetname, damage = strfind(arg1, TheoryCraft_Locale.HitMessage)
	crit = nil
	ul = UnitLevel("player")
	if spellname == nil then
		_, _, spellname, targetname, damage = strfind(arg1, TheoryCraft_Locale.CritMessage)
		crit = true
	end
	if (spellname == nil) or (damage == nil) or (tonumber(damage) == nil) then return end
	damage = tonumber(damage)+tonumber(absorbed or 0)
	i = 1
	while (TheoryCraft_Spells[class][i]) and (TheoryCraft_Spells[class][i].name ~= spellname) do
		i = i + 1
	end
	if (TheoryCraft_Spells[class][i] == nil) or (TheoryCraft_Spells[class][i].name ~= spellname) then
		return
	end
	if (TheoryCraft_Spells[class][i].iscombo) then return end
	armor = TheoryCraft_Spells[class][i].armor
	i = 0
	while (i < 25) do
		if (TheoryCraft_TooltipData[spellname.."("..i..")"]) then
			spellrank = i
		end
		i = i + 1
	end
	if spellrank == nil then return end
	spelldata = TheoryCraft_TooltipData[TheoryCraft_TooltipData[spellname.."("..(spellrank)..")"]]
	if armor then
		if (spelldata == nil) then return end
		if (spelldata.mindamage == nil) then return end
		if (spelldata.maxdamage == nil) then return end
		if (crit) and (spelldata.critbonus) then damage = damage/(spelldata.critbonus+1) end

		local isplayer = "not found"
		if UnitName("target") == targetname then
			isplayer = UnitIsPlayer("target")
		end
		if TheoryCraft_MitigationMobs[targetname] then
			isplayer = false
		end
		if TheoryCraft_MitigationPlayers[targetname] then
			isplayer = true
		end
		if isplayer == "not found" then
			return
		end

		sunder = TheoryCraft_GetStat("Sunder")
		if isplayer then
			if (TheoryCraft_MitigationPlayers[targetname] == nil) or (TheoryCraft_MitigationPlayers[targetname][1] == nil) then
				oldarmorvalue = 0
				for i = 0,60 do
					if (TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")+i]) and (TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")+i][1]) then
						oldarmorvalue = TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")+i][1]-TheoryCraft_GetStat("Sunder")
						break
					end
					if (TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")-i]) and (TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")-i][1]) then
						oldarmorvalue = TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")-i][1]-TheoryCraft_GetStat("Sunder")
						break
					end
				end
				TheoryCraft_MitigationPlayers[targetname] = {}
				TheoryCraft_MitigationPlayers[targetname][1] = oldarmorvalue
			end
			oldarmorvalue = TheoryCraft_MitigationPlayers[targetname][1]
			if not TheoryCraft_MitigationPlayers[targetname] then
				if (damage > spelldata.mindamage-1) or (damage < spelldata.maxdamage+1) then
					damagereduction = 1-damage/((spelldata.maxdamage+spelldata.mindamage)/2)
					if TheoryCraft_MitigationPlayers[targetname] == nil then TheoryCraft_MitigationPlayers[targetname] = {} end
					TheoryCraft_MitigationPlayers[targetname][1] = math.floor((85 * damagereduction * ul + 400 * damagereduction)/(1 - damagereduction))
					if TheoryCraft_MitigationPlayers[targetname][1] > 0 then
						TheoryCraft_MitigationPlayers[targetname][1] = TheoryCraft_MitigationPlayers[targetname][1] + sunder
					end
					TheoryCraft_Data.armormultinternal = 1
					if TheoryCraft_Data.armormultinternal and (TheoryCraft_MitigationPlayers[targetname]) and (TheoryCraft_MitigationPlayers[targetname][1]) then
						TheoryCraft_Data.armormultinternal = 1 - (TheoryCraft_MitigationPlayers[targetname][1] / (85 * UnitLevel("player") + 400 + TheoryCraft_MitigationPlayers[targetname][1]))
					end
					TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
				end
			else
				oldarmor = TheoryCraft_MitigationPlayers[targetname][1]-sunder
				if oldarmor < 0 then
					oldarmor = 0
				end
				oldarmor = 1 - (oldarmor / (85 * UnitLevel("player") + 400 + oldarmor))
				if damage < spelldata.mindamage*oldarmor-1 then
					damagereduction = 1-damage/(spelldata.mindamage-1)
					if TheoryCraft_MitigationPlayers[targetname] == nil then TheoryCraft_MitigationPlayers[targetname] = {} end
					TheoryCraft_MitigationPlayers[targetname][1] = math.floor((85 * damagereduction * ul + 400 * damagereduction)/(1 - damagereduction))
					if TheoryCraft_MitigationPlayers[targetname][1] > 0 then
						TheoryCraft_MitigationPlayers[targetname][1] = TheoryCraft_MitigationPlayers[targetname][1] + sunder
					end
					TheoryCraft_Data.armormultinternal = 1
					if TheoryCraft_Data.armormultinternal and (TheoryCraft_MitigationPlayers[targetname]) and (TheoryCraft_MitigationPlayers[targetname][1]) then
						TheoryCraft_Data.armormultinternal = 1 - (TheoryCraft_MitigationPlayers[targetname][1] / (85 * UnitLevel("player") + 400 + TheoryCraft_MitigationPlayers[targetname][1]))
					end
					TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
				end
				if damage > spelldata.maxdamage*oldarmor+1 then
					damagereduction = 1-damage/(spelldata.maxdamage+1)
					if TheoryCraft_MitigationPlayers[targetname] == nil then TheoryCraft_MitigationPlayers[targetname] = {} end
					TheoryCraft_MitigationPlayers[targetname][1] = math.floor((85 * damagereduction * ul + 400 * damagereduction)/(1 - damagereduction))
					if TheoryCraft_MitigationPlayers[targetname][1] > 0 then
						TheoryCraft_MitigationPlayers[targetname][1] = TheoryCraft_MitigationPlayers[targetname][1] + sunder
					end
					TheoryCraft_Data.armormultinternal = 1
					if (TheoryCraft_Data.armormultinternal) and (TheoryCraft_MitigationPlayers[targetname]) and (TheoryCraft_MitigationPlayers[targetname][1]) then
						TheoryCraft_Data.armormultinternal = 1 - (TheoryCraft_MitigationPlayers[targetname][1] / (85 * UnitLevel("player") + 400 + TheoryCraft_MitigationPlayers[targetname][1]))
					end
					TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
				end
			end
			if (TheoryCraft_Settings["armorchanges"]) and (oldarmorvalue ~= TheoryCraft_MitigationPlayers[targetname][1]) then
				if oldarmorvalue > TheoryCraft_MitigationPlayers[targetname][1] then
					Print(targetname.." Armor "..TheoryCraft_MitigationPlayers[targetname][1].." (-"..oldarmorvalue-TheoryCraft_MitigationPlayers[targetname][1]..")")
				else
					Print(targetname.." Armor "..TheoryCraft_MitigationPlayers[targetname][1].." (+"..TheoryCraft_MitigationPlayers[targetname][1]-oldarmorvalue..")")
				end
			end
			if UnitName("target") == targetname then
				if UnitLevel("target") == -1 then
					if TheoryCraft_MitigationPlayers[UnitClass("target")..":60"] == nil then
						TheoryCraft_MitigationPlayers[UnitClass("target")..":60"] = {}
					end
					TheoryCraft_MitigationPlayers[UnitClass("target")..":60"][1] = TheoryCraft_MitigationPlayers[targetname][1]
				else
					if TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")] == nil then
						TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")] = {}
					end
					TheoryCraft_MitigationPlayers[UnitClass("target")..":"..UnitLevel("target")][1] = TheoryCraft_MitigationPlayers[targetname][1]
				end
			end
		else
			if TheoryCraft_MitigationMobs[targetname] then
				oldarmorvalue = TheoryCraft_MitigationMobs[targetname][1] or 0
			else
				oldarmorvalue = 0
			end
			if not TheoryCraft_MitigationMobs[targetname] then
				if (damage > spelldata.mindamage-1) or (damage < spelldata.maxdamage+1) then
					damagereduction = 1-damage/((spelldata.maxdamage+spelldata.mindamage)/2)
					if TheoryCraft_MitigationMobs[targetname] == nil then TheoryCraft_MitigationMobs[targetname] = {} end
					TheoryCraft_MitigationMobs[targetname][1] = math.floor((85 * damagereduction * ul + 400 * damagereduction)/(1 - damagereduction))
					if TheoryCraft_MitigationMobs[targetname][1] > 0 then
						TheoryCraft_MitigationMobs[targetname][1] = TheoryCraft_MitigationMobs[targetname][1] + sunder
					end
					TheoryCraft_Data.armormultinternal = 1
					if TheoryCraft_Data.armormultinternal and (TheoryCraft_MitigationMobs[targetname]) and (TheoryCraft_MitigationMobs[targetname][1]) then
						TheoryCraft_Data.armormultinternal = 1 - (TheoryCraft_MitigationMobs[targetname][1] / (85 * UnitLevel("player") + 400 + TheoryCraft_MitigationMobs[targetname][1]))
					end
					TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
				end
			else
				oldarmor = TheoryCraft_MitigationMobs[targetname][1]-sunder
				if oldarmor < 0 then
					oldarmor = 0
				end
				oldarmor = 1 - (oldarmor / (85 * UnitLevel("player") + 400 + oldarmor))
				if damage < spelldata.mindamage*oldarmor-1 then
					damagereduction = 1-damage/(spelldata.mindamage-1)
					if TheoryCraft_MitigationMobs[targetname] == nil then TheoryCraft_MitigationMobs[targetname] = {} end
					TheoryCraft_MitigationMobs[targetname][1] = math.floor((85 * damagereduction * ul + 400 * damagereduction)/(1 - damagereduction))
					if TheoryCraft_MitigationMobs[targetname][1] > 0 then
						TheoryCraft_MitigationMobs[targetname][1] = TheoryCraft_MitigationMobs[targetname][1] + sunder
					end
					TheoryCraft_Data.armormultinternal = 1
					if TheoryCraft_Data.armormultinternal and (TheoryCraft_MitigationMobs[targetname]) and (TheoryCraft_MitigationMobs[targetname][1]) then
						TheoryCraft_Data.armormultinternal = 1 - (TheoryCraft_MitigationMobs[targetname][1] / (85 * UnitLevel("player") + 400 + TheoryCraft_MitigationMobs[targetname][1]))
					end
					TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
				end
				if damage > spelldata.maxdamage*oldarmor+1 then
					damagereduction = 1-damage/(spelldata.maxdamage+1)
					if TheoryCraft_MitigationMobs[targetname] == nil then TheoryCraft_MitigationMobs[targetname] = {} end
					TheoryCraft_MitigationMobs[targetname][1] = math.floor((85 * damagereduction * ul + 400 * damagereduction)/(1 - damagereduction))
					if TheoryCraft_MitigationMobs[targetname][1] > 0 then
						TheoryCraft_MitigationMobs[targetname][1] = TheoryCraft_MitigationMobs[targetname][1] + sunder
					end
					TheoryCraft_Data.armormultinternal = 1
					if TheoryCraft_Data.armormultinternal and (TheoryCraft_MitigationMobs[targetname]) and (TheoryCraft_MitigationMobs[targetname][1]) then
						TheoryCraft_Data.armormultinternal = 1 - (TheoryCraft_MitigationMobs[targetname][1] / (85 * UnitLevel("player") + 400 + TheoryCraft_MitigationMobs[targetname][1]))
					end
					TheoryCraft_DeleteTable(TheoryCraft_UpdatedButtons)
				end
			end
			if (TheoryCraft_Settings["armorchanges"]) and (oldarmorvalue ~= TheoryCraft_MitigationMobs[targetname][1]) then
				if oldarmorvalue > TheoryCraft_MitigationMobs[targetname][1] then
					Print(targetname.." Armor "..TheoryCraft_MitigationMobs[targetname][1].." (-"..oldarmorvalue-TheoryCraft_MitigationMobs[targetname][1]..")")
				else
					Print(targetname.." Armor "..TheoryCraft_MitigationMobs[targetname][1].." (+"..TheoryCraft_MitigationMobs[targetname][1]-oldarmorvalue..")")
				end
			end
		end
	end
end
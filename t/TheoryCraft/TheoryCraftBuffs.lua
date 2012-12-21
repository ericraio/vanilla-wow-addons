local _, class = UnitClass("player")

TheoryCraft_Data.TargetBuffs = {}
TheoryCraft_Data.PlayerBuffs = {}

local function findpattern(text, pattern, start)
	if (text and pattern and (string.find(text, pattern, start))) then
		return string.sub(text, string.find(text, pattern, start))
	else
		return ""
	end
end

local function TheoryCraft_AddAllBuffs(target, data, buffs)
	TheoryCraftTooltip:ClearLines()
	local i, buff, a, defaulttarget, _, start, found, type
	if target == "player" then
		local _, _, _, _, _, _, meleemod = UnitDamage("player")
		data["Meleemodifier"] = -1+meleemod
		data["Rangedmodifier"] = -1+meleemod
	end
	if class == "DRUID" then
		local oldstance = TheoryCraft_Data.currentstance
		TheoryCraft_Data.currentstance = nil
		local _, active
		_, _, active = GetShapeshiftFormInfo(1)
		if active then TheoryCraft_Data.currentstance = 1 end
		_, _, active = GetShapeshiftFormInfo(3)
		if active then TheoryCraft_Data.currentstance = 3 end
		if TheoryCraft_Data.currentstance ~= oldstance then
			TheoryCraft_Data.redotalents = true
		end
	end
	if buffs == "debuffs" then
		a = TheoryCraft_Debuffs
		defaulttarget = "target"
	else
		a = TheoryCraft_Buffs
		defaulttarget = "player"
	end
	for i = 1, 16 do
		if buffs == "debuffs" then
			buff = UnitDebuff(target, i)
		else
			buff = UnitBuff(target, i)
		end
		if buff then
			TheoryCraftTooltipTextLeft1:SetText(nil)
			TheoryCraftTooltip:SetOwner(UIParent,"ANCHOR_NONE")
			if buffs == "debuffs" then
				TheoryCraftTooltip:SetUnitDebuff(target, i)
			else
				TheoryCraftTooltip:SetUnitBuff(target, i)
			end
			ltext = TheoryCraftTooltipTextLeft2
			if (ltext) and (not ltext:IsVisible()) then
				ltext = nil
			end
			if (ltext) then ltext = ltext:GetText() end
			if ltext then
				for k, v in pairs(a) do
					if ((not v.target) and (target == defaulttarget)) or (v.target == target) then
						_, start, found = strfind(ltext, v.text)
						if _ then
							type = v.type
							if (v.amount == nil) then
								data[type] = (data[type] or 0) + tonumber(found)
							elseif (v.amount == "n/100") then
								data[type] = (data[type] or 0) + tonumber(found)/100
							elseif (v.amount == "totem") then
								data[type] = (data[type] or 0) + tonumber(found)/2*5
							elseif (v.amount == "hl") then
								data[type] = (data[type] or 0) + tonumber(found)/2.5*3.5
							elseif (v.amount == "fol") then
								data[type] = (data[type] or 0) + tonumber(found)/1.5*3.5
							else
								data[type] = (data[type] or 0) + v.amount
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

function TheoryCraft_UpdateBuffs(arg1, dontgen)
	if (arg1 == "player") then
		TheoryCraft_DeleteTable(TheoryCraft_Data.PlayerBuffs)
		TheoryCraft_AddAllBuffs("player", TheoryCraft_Data.PlayerBuffs)
		TheoryCraft_AddAllBuffs("player", TheoryCraft_Data.PlayerBuffs, "debuffs")
		if dontgen == nil then
			if TheoryCraft_Data.redotalents then
				TheoryCraft_UpdateTalents(true)
				TheoryCraft_Data.redotalents = nil
			end
			TheoryCraft_LoadStats()
			TheoryCraft_UpdateArmor()
			TheoryCraft_GenerateAll()
		end
	elseif (arg1 == "target") then
		TheoryCraft_DeleteTable(old)
		TheoryCraft_CopyTable(TheoryCraft_Data.TargetBuffs, old)
		TheoryCraft_DeleteTable(TheoryCraft_Data.TargetBuffs)
		TheoryCraft_AddAllBuffs("target", TheoryCraft_Data.TargetBuffs)
		TheoryCraft_AddAllBuffs("target", TheoryCraft_Data.TargetBuffs, "debuffs")
		if dontgen == nil then
			if TheoryCraft_Data.redotalents then
				TheoryCraft_UpdateTalents(true)
				TheoryCraft_Data.redotalents = nil
			end
			TheoryCraft_DeleteTable(old2)
			TheoryCraft_CopyTable(TheoryCraft_Data.Stats, old2)
			TheoryCraft_LoadStats()
			if (TheoryCraft_IsDifferent(old, TheoryCraft_Data.TargetBuffs)) or (TheoryCraft_IsDifferent(old2, TheoryCraft_Data.Stats)) then
				TheoryCraft_UpdateArmor()
				TheoryCraft_GenerateAll()
			end
		end
	end
end
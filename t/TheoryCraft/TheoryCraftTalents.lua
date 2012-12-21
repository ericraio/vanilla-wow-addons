TheoryCraft_Data.Talents = {}
local _, class = UnitClass("player")

local function findpattern(text, pattern, start)
	if (text and pattern and (string.find(text, pattern, start))) then
		return string.sub(text, string.find(text, pattern, start))
	else
		return ""
	end
end

local function TheoryCraft_AddAllTalents(data, ignoreforce)
	local i = 1
	local forcedrank = 0


	data["strmultiplier"] = 1
	data["agimultiplier"] = 1
	data["stammultiplier"] = 1
	data["intmultiplier"] = 1
	data["spiritmultiplier"] = 1
	data["manamultiplier"] = 1
	data["healthmultiplier"] = 1
	local _, race = UnitRace("player")
	if (race == "Gnome") then
		data["intmultiplier"] = 1.05
	end
	if (race == "Human") then
		data["spiritmultiplier"] = 1.05
	end
	if (race == "Tauren") then
		data["healthmultiplier"] = 1.05
	end
	data["strmultiplierreal"] = data["strmultiplier"]
	data["agimultiplierreal"] = data["agimultiplier"]
	data["stammultiplierreal"] = data["stammultiplier"]
	data["intmultiplierreal"] = data["intmultiplier"]
	data["spiritmultiplierreal"] = data["spiritmultiplier"]
	data["manamultiplierreal"] = data["manamultiplier"]
	data["healthmultiplierreal"] = data["healthmultiplier"]

	local nameTalent, icon, iconx, icony, currank, maxRank = GetTalentInfo(1, 1)
	if nameTalent == nil then return end
	TheoryCraft_Data.TalentsHaveBeenRead = true

	local _, catform, bearform
	if class == "DRUID" then
		_, _, bearform = GetShapeshiftFormInfo(1)
		_, _, catform = GetShapeshiftFormInfo(3)
	end

	while (TheoryCraft_Talents[i]) do
		if (class == TheoryCraft_Talents[i].class) then
			if (TheoryCraft_Talents[i].tree) and (TheoryCraft_Talents[i].number) then
				nameTalent, icon, iconx, icony, currank, maxRank= GetTalentInfo(TheoryCraft_Talents[i].tree, TheoryCraft_Talents[i].number)
				if (currank > 0) then
					if (TheoryCraft_Talents[i].firstrank) then
						if currank > 1 then
							currank = TheoryCraft_Talents[i].firstrank + (currank-1)*TheoryCraft_Talents[i].perrank
						else
							currank = TheoryCraft_Talents[i].firstrank
						end
					else
						currank = currank*TheoryCraft_Talents[i].perrank
					end
				end
			else
				currank = 0
			end
			if ((TheoryCraft_Talents[i].forceto == nil) or (TheoryCraft_Talents[i].forceto == -1) or (ignoreforce)) then
				if (TheoryCraft_Talents[i].forceonly == nil) then
					data[TheoryCraft_Talents[i].bonustype] = (data[TheoryCraft_Talents[i].bonustype] or 0) + currank
				end
			else
				if (TheoryCraft_Talents[i].firstrank) and (TheoryCraft_Talents[i].forceto > 0) then
					forcedrank = TheoryCraft_Talents[i].firstrank
					if TheoryCraft_Talents[i].forceto > 1 then
						forcedrank = forcedrank + (TheoryCraft_Talents[i].forceto-1)*TheoryCraft_Talents[i].perrank
					end
				else
					forcedrank = TheoryCraft_Talents[i].forceto*TheoryCraft_Talents[i].perrank
				end
				if (TheoryCraft_Talents[i].bonustype == "Predatory") and ((catform) or (bearform)) then
					data["AttackPowerTalents"] = (data["AttackPowerTalents"] or 0)-UnitLevel("player")*currank+UnitLevel("player")*forcedrank
				end
				if TheoryCraft_Talents[i].bonustype == "CritReport" then
					data["CritChangeTalents"] = (data["CritChangeTalents"] or 0)+currank-forcedrank
				end
				if strfind(TheoryCraft_Talents[i].bonustype, "modifier") then
					data[TheoryCraft_Talents[i].bonustype] = (data[TheoryCraft_Talents[i].bonustype] or 0) + currank
					data[string.sub(TheoryCraft_Talents[i].bonustype, 1, string.find(TheoryCraft_Talents[i].bonustype, "modifier")-1).."talentmod"] = forcedrank - currank + (data[string.sub(TheoryCraft_Talents[i].bonustype, 1, string.find(TheoryCraft_Talents[i].bonustype, "modifier")-1).."talentmod"] or 0)
				elseif strfind(TheoryCraft_Talents[i].bonustype, "manacost") then
					data[TheoryCraft_Talents[i].bonustype] = (((data[TheoryCraft_Talents[i].bonustype] or 0)+1)*((1+forcedrank)/(1+currank)))-1
				else
					if strfind(TheoryCraft_Talents[i].bonustype, "casttime") then
						data[TheoryCraft_Talents[i].bonustype] = (data[TheoryCraft_Talents[i].bonustype] or 0) - currank + forcedrank
					else
						data[TheoryCraft_Talents[i].bonustype] = (data[TheoryCraft_Talents[i].bonustype] or 0) + forcedrank
					end
				end
			end
			if TheoryCraft_Talents[i].bonustype == "Formcritchance" then
				data["Formcritchancereal"] = (data["Formcritchancereal"] or 0)+currank
			end
			local _, _, spec = strfind(TheoryCraft_Talents[i].bonustype, "(.+)spec")
			if spec then
				data[spec.."specreal"] = (data[spec.."specreal"] or 0)+currank
			end
			if (TheoryCraft_Talents[i].bonustype == "HotW") then
				if catform then
					if ((TheoryCraft_Talents[i].forceto == nil) or (TheoryCraft_Talents[i].forceto == -1) or (ignoreforce)) then
						data["strmultiplier"] = data["strmultiplier"]+currank
					else
						data["strmultiplier"] = data["strmultiplier"]+forcedrank
					end
					data["strmultiplierreal"] = data["strmultiplierreal"]+currank
				end
				if bearform then
					if ((TheoryCraft_Talents[i].forceto == nil) or (TheoryCraft_Talents[i].forceto == -1) or (ignoreforce)) then
						data["stammultiplier"] = data["stammultiplier"]+currank
					else
						data["stammultiplier"] = data["stammultiplier"]+forcedrank
					end
					data["stammultiplierreal"] = data["stammultiplierreal"]+currank
				end
			end
			if (TheoryCraft_Talents[i].bonustype == "healthmultiplier") then
				data["healthmultiplierreal"] = data["healthmultiplierreal"]+currank
			end
			if (TheoryCraft_Talents[i].bonustype == "manamultiplier") then
				data["manamultiplierreal"] = data["manamultiplierreal"]+currank
			end
			if (TheoryCraft_Talents[i].bonustype == "strmultiplier") then
				data["strmultiplierreal"] = data["strmultiplierreal"]+currank
			end
			if (TheoryCraft_Talents[i].bonustype == "agimultiplier") then
				data["agimultiplierreal"] = data["agimultiplierreal"]+currank
			end
			if (TheoryCraft_Talents[i].bonustype == "stammultiplier") then
				data["stammultiplierreal"] = data["stammultiplierreal"]+currank
			end
			if (TheoryCraft_Talents[i].bonustype == "intmultiplier") then
				data["intmultiplierreal"] = data["intmultiplierreal"]+currank
			end
			if (TheoryCraft_Talents[i].bonustype == "spiritmultiplier") then
				data["spiritmultiplierreal"] = data["spiritmultiplierreal"]+currank
			end
		end
		i = i + 1
	end
end

function TheoryCraft_UpdateTalents(dontgen)
	local old = TheoryCraft_Data.Talents
--	local old3 = TheoryCraft_Data.TalentsTest
	TheoryCraft_Data.Talents = {}
	TheoryCraft_AddAllTalents(TheoryCraft_Data.Talents)
--	TheoryCraft_Data.TalentsTest = {}
--	TheoryCraft_AddAllTalents(TheoryCraft_Data.TalentsTest)
	if dontgen == nil then
		local old2 = TheoryCraft_Data.Stats
		TheoryCraft_Data.Stats = {}
		TheoryCraft_LoadStats()
		if TheoryCraft_IsDifferent(old, TheoryCraft_Data.Talents) or TheoryCraft_IsDifferent(old2, TheoryCraft_Data.Stats) then
			TheoryCraft_GenerateAll()
		end
	end
end
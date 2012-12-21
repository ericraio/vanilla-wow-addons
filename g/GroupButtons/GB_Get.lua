function GB_Get(bar, button, param3)
	if (not GB_INITIALIZED) then return; end
	if (param3) then
		return GB_Settings[GB_INDEX][bar].Button[button][param3];
	elseif (button) then
		return GB_Settings[GB_INDEX][bar].Button[button];
	else
		return GB_Settings[GB_INDEX][bar];
	end
end

function GB_Set(bar, arg2, arg3, arg4)
	if (arg4 ~= nil) then
		GB_Settings[GB_INDEX][bar].Button[arg2][arg3] = arg4;
	elseif (arg3 ~= nil) then
		GB_Settings[GB_INDEX][bar][arg2] = arg3;
	else
		GB_Settings[GB_INDEX][bar] = arg2;
	end
end

function GB_Get_ActionUsuable(name, rank, button)
	if (GB_Get("disableActionInProgressSpam") and GB_SPELLISCASTING) then
		return false;
	end
	if (GB_Get("disableOutOfRangeSpam")) then
		local range = GB_SPELLS[name][rank].range;
		if (range) then
			if (IsActionInRange(range) == 0 and button:GetParent().unit == "target") then
				return false;
			end
		end
	end
	if (GB_Get("disableCantDoYetSpam")) then
		local _,duration = GetSpellCooldown(GB_SPELLS[name][rank].id, BOOKTYPE_SPELL);
		if (duration ~= 0) then return; end
	end
	return true;
end

function GB_Get_AnnounceText(spellName, spellRank, unit, announceNum)
	local text = GB_Settings[GB_INDEX].announcements[announceNum];
	local target = UnitName(unit);
	if (not target) then target = ""; end
	local castingTime = GB_SPELLS[spellName][spellRank].castingTime;
	if (not castingTime) then castingTime = ""; end
	local healAmount = math.floor(GB_SPELLS[spellName][spellRank].avg);
	if (not healAmount) then healAmount = ""; end
	local manaRemaining = math.floor(UnitMana("player") / UnitManaMax("player") * 100);
	if (manaRemaining) then
		manaRemaining = manaRemaining.."%%";
	else
		manaRemaining = "";
	end
	text = string.gsub(text, '$t', target);
	text = string.gsub(text, '$r', spellRank);
	text = string.gsub(text, '$s', spellName);
	text = string.gsub(text, '$c', castingTime);
	text = string.gsub(text, '$m', manaRemaining);
	text = string.gsub(text, '$a', healAmount);

	GB_ANNOUNCED = {};
	GB_ANNOUNCED.spellName = spellName;
	GB_ANNOUNCED.spellRank = spellRank;
	GB_ANNOUNCED.target = target;

	return text;
end

function GB_Get_BuffMatch(buff, target)
	if (GB_BUFFS[target] and GB_BUFFS[target][buff]) then
		return GB_BUFFS[target][buff];
	elseif (GB_BUFFS[target] and GB_SPELLS[buff]) then
		for i in GB_SPELLS[buff] do
			return GB_BUFFS[target][GetSpellTexture(GB_SPELLS[buff][i].id, "BOOKTYPE_SPELL")];
		end
	end
end

function GB_Get_BuffTarget(name)
	if (not GB_Get_BuffMatch(name, "player")) then
		return "player";
	end
	local unit;
	for i=1,4 do
		if (UnitIsVisible("party"..i)) then
			if ((not GB_Get("limitlhrange")) or CheckInteractDistance("party"..i, 4)) then
				unit = "party"..i;
				if ((not GB_Get_BuffMatch(name, unit)) and UnitName(unit)) then
					return unit;
				end
			end
		end
	end
	if (GB_Settings[GB_INDEX].includePets) then
		if ((not GB_Get_BuffMatch(name, "pet")) and UnitName("pet")) then return "pet"; end
		for i=1,4 do
			if (UnitIsVisible("partypet"..i)) then
				if ((not GB_Get("limitlhrange")) or CheckInteractDistance("partypet"..i, 4)) then
					unit = "partypet"..i;
					if ((not GB_Get_BuffMatch(name, unit)) and UnitName(unit)) then
						return unit;
					end
				end
			end
		end
	end
	if (GB_Settings[GB_INDEX].includeRaid) then
		for i=1,GetNumRaidMembers() do
			if (UnitIsVisible("raid"..i)) then
				unit = "raid"..i;
				if ((not GB_Get("limitlhrange")) or CheckInteractDistance(unit, 4)) then
					if ((not GB_Get_BuffMatch(name, unit)) and UnitName(unit)) then
						return unit;
					end
				end
			end
		end
	end
	return;
end

function GB_Get_CorrectSpell(bar, button, target, overridePO)
	local name = GB_Settings[GB_INDEX][bar].Button[button].name;
	local rank = GB_Settings[GB_INDEX][bar].Button[button].rank;

	if (not name) then
		return;
	end

	if (GB_Settings[GB_INDEX][bar].Button[button].preventRebuff) then
		local buffFound = GB_Get_BuffMatch(name, target);
		if (not buffFound) then
			buffFound = GB_Get_DebuffMatch(name, target);
		end
		if (buffFound) then
			GB_Feedback(GB_TEXT.PreventedRebuff);
			return;
		end
	end

	if (name and GB_Settings[GB_INDEX][bar].Button[button].scaleRank) then
		name, rank = GB_Get_ScaledRank(name, rank, target);
	end

	if (name and GB_Settings[GB_INDEX][bar].Button[button].preventOverhealing and (not overridePO)) then
		name, rank = GB_Get_EfficientHeal(name, rank, target, GB_Settings[GB_INDEX][bar].Button[button].matchCastingTime, GB_Settings[GB_INDEX][bar].Button[button].matchSpellName);
	end

	if (name and GB_Settings[GB_INDEX][bar].Button[button].preventOverkill and (not overridePO)) then
		name, rank = GB_Get_EfficientDamage(name, rank);
	end

	if (name and GB_Settings[GB_INDEX][bar].Button[button].lowManaRank) then
		name, rank = GB_Get_EnoughManaRank(name, rank);
	end

	return name, rank;
end

function GB_Get_CureTarget(name)
	local effects;
	for _, v in GB_CURES do
		if (v.text == name) then
			effects = v.effects;
			break;
		end
	end
	for _, status in effects do
		if (GB_Get_DebuffMatch(status, "player", 1)) then
			return "player";
		end
		local unit;
		for i=1,4 do
			if (UnitIsVisible("party"..i)) then
				unit = "party"..i;
				if ((not GB_Get("limitlhrange")) or CheckInteractDistance(unit, 4)) then
					if (GB_Get_DebuffMatch(status, unit, 1)) then
						return unit;
					end
				end
			end
		end
		if (GB_Settings[GB_INDEX].includePets) then
			if (GB_Get_DebuffMatch(status, "pet", 1)) then return "pet"; end
			for i=1,4 do
				if (UnitIsVisible("partypet"..i)) then
					unit = "partypet"..i;
					if ((not GB_Get("limitlhrange")) or CheckInteractDistance(unit, 4)) then
						if (GB_Get_DebuffMatch(status, unit, 1)) then
							return unit;
						end
					end
				end
			end
		end
		if (GB_Settings[GB_INDEX].includeRaid) then
			for i=1,GetNumRaidMembers() do
				if (UnitIsVisible("raid"..i)) then
					unit = "raid"..i;
					if ((not GB_Get("limitlhrange")) or CheckInteractDistance(unit, 4)) then
						if (GB_Get_DebuffMatch(status, unit, 1)) then
							return unit;
						end
					end
				end
			end
		end
	end
	return;
end

function GB_Get_CurrentForm()
	for i=1,GetNumShapeshiftForms() do
		local _, _, isActive = GetShapeshiftFormInfo(i);
		if isActive then return i; end
	end
	return 0;
end

function GB_Get_DebuffMatch(buff, target, statustoggle)
	if (GB_DEBUFFS[target]) then
		return GB_DEBUFFS[target][buff];		
	end
end

function GB_Get_DefaultButtonSettings()
	local value = {
			name = nil,
			rank = nil,
			idType = "",
			hide = false,
			context = "Always",
			inCombat = false,
			notInCombat = false,
			outdoors = false,
			form = nil,
			preventOverhealing = false,
			preventOverkill = false,
			preventRebuff = false,
			matchCastingTime = false,
			matchSpellName = false,
			assist = false,
			autoUpdate = false,
			validTarget = false,
			classes = {	[GB_TEXT.Priest] = true,
						[GB_TEXT.Warrior] = true,
						[GB_TEXT.Paladin] = true,
						[GB_TEXT.Mage] = true,
						[GB_TEXT.Hunter] = true,
						[GB_TEXT.Shaman] = true,
						[GB_TEXT.Druid] = true,
						[GB_TEXT.Rogue] = true,
						[GB_TEXT.Warlock] = true
					},
			scaleRank = false,
			announce = false,
			announceText = 1,
			lowManaRank = false,
			OOCoption = "hide",
			flashInContext = false
		};
	return value;
end

function GB_Get_EfficientDamage(name, rank)
	if (not MobHealthFrame) then return name, rank; end
	if (GB_SPELLS[name][rank].type ~= "damage") then
		if (GB_SPELLS[name][rank].type == "DoT") then
			if (GB_SPELLS[name][rank].avg == 0) then
				return name, rank;
			end
		else
			return name, rank;
		end
	end
	health = MobHealth_GetTargetCurHP();
	if ((not health) or health == 0) then return name, rank; end
	local difference = math.abs(GB_SPELLS[name][rank].min - health);
	local origRank = rank;
	for spellrank, spelldata in GB_SPELLS[name] do
		local diff2 = math.abs(spelldata.min - health);
		if (diff2 < difference and spelldata.min > health) then
			difference = diff2;
			rank = spellrank;
		end
	end
	if (origRank ~= rank) then
		GB_SpellChanged(GB_TEXT.POkillChangedSpell, name, rank);
	end
	return name, rank;
end

function GB_Get_EfficientHeal(name, rank, target, matchTime, matchName)
	if (UnitHealthMax(target) == 100) then
		return name, rank;
	end
	if (GB_SPELLS[name][rank].type ~= "heal") then
		if (GB_SPELLS[name][rank].type == "HoT") then
			if (GB_SPELLS[name][rank].avg == 0) then
				return name, rank;
			end
		else
			return name, rank;
		end
	end
	local origName, origRank = name, rank;
	local damage = UnitHealthMax(target) - UnitHealth(target);
	local pastThreshold = GB_Get_PastThreshold("cancelHealThreshold", target);
	if ((not pastThreshold) or damage == 0) then
		GB_Feedback(GB_TEXT.HealPrevented);
		return;
	end
	local modifier = 1;
	if (GB_Get_BuffMatch(GB_TEXT.PowerInfusion, "player")) then
		modifier = 1.2;
	end
	local difference = math.abs(GB_SPELLS[name][rank].avg * modifier - damage);
	if ((not matchTime) and (not matchName)) then
		local lowestMana = 99999;
		for spellname, ranks in GB_SPELLS do
			for spellrank, spelldata in ranks do
				if (spelldata.type == "heal" and spelldata.avg > 0 and spelldata.avg * modifier > damage and (not GB_SKIP_SPELLS[spellname])) then
					if (spelldata.mana and spelldata.mana < lowestMana) then
						lowestMana = spelldata.mana;
						name = spellname;
						rank = spellrank;
					end
				end
			end
		end
	elseif (matchName) then
		for spellrank, spelldata in GB_SPELLS[name] do
			local diff2 = math.abs(spelldata.avg * modifier - damage);
			if (diff2 < difference) then
				difference = diff2;
				rank = spellrank;
			end
		end
	elseif (matchTime) then
		local basetime = GB_SPELLS[name][rank].castingTime;
		for spellname, ranks in GB_SPELLS do
			for spellrank, spelldata in ranks do
				if (spelldata.type == "heal" and spelldata.castingTime == basetime and (not GB_SKIP_SPELLS[spellname])) then
					local diff2 = math.abs(spelldata.avg * modifier - damage);
					if (diff2 < difference) then
						difference = diff2;
						name = spellname;
						rank = spellrank;
					end
				end
			end
		end
	end
	if (origName == name) then
		local _,_,orignum = string.find(origRank, " (%d*)");
		local _,_,ranknum = string.find(rank, " (%d*)");
		orignum = tonumber(orignum);
		ranknum = tonumber(ranknum);
		if (orignum and ranknum) then
			if (ranknum > orignum) then
				name = origName;
				rank = origRank;
			end
		end		
	end
	if (origName ~= name or origRank ~= rank) then
		GB_SpellChanged(GB_TEXT.POChangedSpell, name, rank);
	end
	return name, rank;
end

function GB_Get_EnoughManaRank(name, rank)
	if (GB_Get_BuffMatch(GB_TEXT.InnerFocus, "player") or GB_Get_BuffMatch(GB_TEXT.Clearcasting, "player") or GB_Get_BuffMatch(GB_TEXT.SpiritOfRedemption, "player")) then return name, rank; end
	local mana = UnitMana("player");
	local newrank = rank;
	local _,_,ranknum = string.find(rank, " (%d*)");
	ranknum = tonumber(ranknum);
	local difference = 99999;
	for spellrank, data in GB_SPELLS[name] do
		if (data.mana < mana) then
			if ( (mana - data.mana) < difference) then
				local _,_,newranknum = string.find(spellrank, " (%d*)");
				newranknum = tonumber(newranknum);
				if (ranknum and newranknum) then
					if (newranknum <= ranknum) then
						difference = mana - data.mana;
						newrank = spellrank;	
					end
				end
			end
		end
	end
	if (GB_SPELLS[name][newrank].mana > mana) then
		GB_Feedback(GB_TEXT.TooLowForAnyRank);
		return;
	end
	if (newrank ~= rank) then
		GB_SpellChanged(GB_TEXT.NotEnoughMana, name, newrank);
	end
	return name, newrank;
end

function GB_Get_HealthPercent(unit)
	if (UnitIsGhost(unit)) then
		return 2;
	elseif (UnitHealthMax(unit) <= 0) then
		return 1;
	elseif (UnitHealth(unit) <= 0) then
		return 2;
	else
		return UnitHealth(unit)/UnitHealthMax(unit);
	end
end

function GB_Get_InContext(button)
	local context = 0;
	if (button.InContext) then
		for i, value in button.InContext do
			if (value == -1) then return false; end
		end
	end
	return true;
end

function GB_Get_ItemName(bag, slot)
	local itemname, itemlink;
	if (slot) then
		itemlink = GetContainerItemLink(bag,slot);
	else
		itemlink = GetInventoryItemLink("player", bag);
	end
	if (itemlink) then
		itemname = string.sub(itemlink, string.find(itemlink, "[", 1, true) + 1, string.find(itemlink, "]", 1, true) - 1);
	end
	return itemname;
end

function GB_Get_ItemCount(itemname)
	local itemCount = 0;
	for bag = 0,  4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				itemlink = GetContainerItemLink(bag,slot);
				if (itemlink) then
					local itemname2 = GB_Get_ItemName(bag, slot);
					if (itemname == itemname2) then
						local ic2;
						_, ic2 = GetContainerItemInfo(bag, slot);
						itemCount = itemCount + ic2;
					end
				end
			end
		end
	end
	return itemCount;
end

function GB_Get_LowestHealthUnit()
	local unit = "player";
	local lowest = GB_Get_HealthPercent("player");
	local check;
	for i=1,4 do
		if (UnitIsVisible("party"..i)) then
			if ((not GB_Get("limitlhrange")) or CheckInteractDistance("party"..i, 4)) then
				check = GB_Get_HealthPercent("party"..i);
				if (check < lowest) then
					lowest = check;
					unit = "party"..i;
				end
			end
		end
	end
	if (GB_Settings[GB_INDEX].includePets) then
		if ((not GB_Get("limitlhrange")) or CheckInteractDistance("pet", 4)) then
			check = GB_Get_HealthPercent("pet");
			if (check < lowest) then
				lowest = check;
				unit = "pet";
			end
		end
		for i=1,4 do
			if (UnitIsVisible("partypet"..i)) then
				if ((not GB_Get("limitlhrange")) or CheckInteractDistance("partypet"..i, 4)) then
					check = GB_Get_HealthPercent("partypet"..i);
					if (check < lowest) then
						lowest = check;
						unit = "partypet"..i;
					end
				end
			end
		end
	end
	if (GB_Settings[GB_INDEX].includeRaid) then
		for i=1,GetNumRaidMembers() do
			if (UnitIsVisible("raid"..i)) then
				if ((not GB_Get("limitlhrange")) or CheckInteractDistance("raid"..i, 4)) then
					check = GB_Get_HealthPercent("raid"..i);
					if (check < lowest) then
						lowest = check;
						unit = "raid"..i;
					end
				end
			end
		end
	end
	return unit;
end

function GB_Get_PastThreshold(threshold, target, thresholdnum)
	if ((not thresholdnum) or thresholdnum == "mana") then
		threshold = GB_Settings[GB_INDEX][threshold];		
	else
		threshold = GB_Settings[GB_INDEX][threshold][thresholdnum];
	end

	if ((not threshold) or threshold == "") then return true; end
	if (UnitHealthMax(target) == 0 or (not UnitHealthMax(target))) then return 0; end

	local damage = UnitHealthMax(target) - UnitHealth(target);
	local percent = 100 - UnitHealth(target) / UnitHealthMax(target) * 100;
	if (thresholdnum == "mana") then
		damage = UnitManaMax(target) - UnitMana(target);
		percent = 100 - UnitMana(target) / UnitManaMax(target) * 100;
	end
	if (threshold) then
		if (string.find(threshold, "%%")) then
			_,_,threshold = string.find(threshold, "(%d*)%%");
			threshold = tonumber(threshold);
			if (threshold and percent < threshold) then
				return false;
			end
		else
			threshold = tonumber(threshold);
			if (UnitHealthMax(target) == 100 or (not threshold)) then return 0; end
			if (damage < threshold) then
				return false;
			end
		end
	end
	return true;
end

function GB_Get_ScaledRank(name, rank, target)
	local level = UnitLevel(target);
	if (level == -1) then return name, rank; end
	local _,_,orignum = string.find(rank, " (%d*)");
	orignum = tonumber(orignum);
	local ranknum = orignum;
	if (name==GB_MINLVL_SPELLS.Renew) then
		if (level < 4) then ranknum = 1;
		elseif (level < 10) then ranknum = 2;
		elseif (level < 16) then ranknum = 3;
		elseif (level < 22) then ranknum = 4;
		elseif (level < 28) then ranknum = 5;
		elseif (level < 34) then ranknum = 6;
		elseif (level < 40) then ranknum = 7;
		elseif (level < 46) then ranknum = 8;
		elseif (level < 50) then ranknum = 9;
		else ranknum = 10; end
		if (ranknum == 10 and GB_SPELLS[GB_MINLVL_SPELLS.Renew][GB_TEXT.Rank..11]) then
			ranknum = 11;
		end
	elseif (name==GB_MINLVL_SPELLS.PWFortitude) then
		if (level < 2) then ranknum = 1;
		elseif (level < 14) then ranknum = 2;
		elseif (level < 26) then ranknum = 3;
		elseif (level < 38) then ranknum = 4;
		elseif (level < 50) then ranknum = 5;
		else ranknum = 6; end
	elseif (name==GB_MINLVL_SPELLS.DampenMagic) then
		if (level < 2) then ranknum = 0;
		elseif (level < 14) then ranknum = 1;
		elseif (level < 26) then ranknum = 2;
		elseif (level < 38) then ranknum = 3;
		elseif (level < 50) then ranknum = 4;
		else ranknum = 5; end
	elseif (name==GB_MINLVL_SPELLS.AmplifyMagic) then
		if (level < 8) then ranknum = 0;
		elseif (level < 20) then ranknum = 1;
		elseif (level < 32) then ranknum = 2;
		elseif (level < 44) then ranknum = 3;
		else ranknum = 4; end
	elseif (name==GB_MINLVL_SPELLS.DivineSpirit) then
		if (level < 20) then ranknum = 0;
		elseif (level < 30) then ranknum = 1;
		elseif (level < 40) then ranknum = 2;
		elseif (level < 50) then ranknum = 3;
		else ranknum = 4; end
	elseif (name==GB_MINLVL_SPELLS.ShadowProtection) then
		if (level < 20) then ranknum = 0;
		elseif (level < 32) then ranknum = 1;
		elseif (level < 46) then ranknum = 2;
		else ranknum = 3; end
	elseif (name==GB_MINLVL_SPELLS.PWShield) then
		if (level < 2) then ranknum = 1;
		elseif (level < 8) then ranknum = 2;
		elseif (level < 14) then ranknum = 3;
		elseif (level < 20) then ranknum = 4;
		elseif (level < 26) then ranknum = 5;
		elseif (level < 32) then ranknum = 6;
		elseif (level < 38) then ranknum = 7;
		elseif (level < 44) then ranknum = 8;
		elseif (level < 50) then ranknum = 9;
		else ranknum = 10; end
	elseif (name==GB_MINLVL_SPELLS.MarkOfTheWild) then
		if (level < 10) then ranknum = 2;
		elseif (level < 20) then ranknum = 3;
		elseif (level < 30) then ranknum = 4;
		elseif (level < 40) then ranknum = 5;
		elseif (level < 50) then ranknum = 6;
		else ranknum = 7; end
	elseif (name==GB_MINLVL_SPELLS.Rejuvenation) then
		if (level < 6) then ranknum = 2;
		elseif (level < 12) then ranknum = 3;
		elseif (level < 18) then ranknum = 4;
		elseif (level < 24) then ranknum = 5;
		elseif (level < 30) then ranknum = 6;
		elseif (level < 36) then ranknum = 7;
		elseif (level < 42) then ranknum = 8;
		elseif (level < 48) then ranknum = 9;
		else ranknum = 10; end
	elseif (name==GB_MINLVL_SPELLS.Thorns) then
		if (level < 4) then ranknum = 1;
		elseif (level < 14) then ranknum = 2;
		elseif (level < 24) then ranknum = 3;
		elseif (level < 34) then ranknum = 4;
		elseif (level < 44) then ranknum = 5;
		else ranknum = 6; end
	elseif (name==GB_MINLVL_SPELLS.Regrowth) then
		if (level < 2) then ranknum = 0;
		elseif (level < 8) then ranknum = 1;
		elseif (level < 14) then ranknum = 2;
		elseif (level < 20) then ranknum = 3;
		elseif (level < 26) then ranknum = 4;
		elseif (level < 32) then ranknum = 5;
		elseif (level < 38) then ranknum = 6;
		elseif (level < 44) then ranknum = 7;
		elseif (level < 50) then ranknum = 8;
		else ranknum = 9; end
	elseif (name==GB_MINLVL_SPELLS.ArcaneIntellect) then
		if (level < 4) then ranknum = 1;
		elseif (level < 18) then ranknum = 2;
		elseif (level < 32) then ranknum = 3;
		elseif (level < 46) then ranknum = 4;
		else ranknum = 5; end
	elseif (name==GB_MINLVL_SPELLS.BlessingMight) then
		if (level < 2) then ranknum = 1;
		elseif (level < 12) then ranknum = 2;
		elseif (level < 22) then ranknum = 3;
		elseif (level < 32) then ranknum = 4;
		elseif (level < 42) then ranknum = 5;
		elseif (level < 52) then ranknum = 6;
		else ranknum = 7; end
		if (ranknum == 7 and GB_SPELLS[GB_MINLVL_SPELLS.BlessingMight][GB_TEXT.Rank..8]) then
		   ranknum = 8;
		end
	elseif (name==GB_MINLVL_SPELLS.BlessingProtection) then
		if (level < 14) then ranknum = 1;
		elseif (level < 28) then ranknum = 2;
		else ranknum = 3; end
	elseif (name==GB_MINLVL_SPELLS.BlessingWisdom) then
		if (level < 4) then ranknum = 0;
		elseif (level < 14) then ranknum = 1;
		elseif (level < 24) then ranknum = 2;
		elseif (level < 34) then ranknum = 3;
		elseif (level < 44) then ranknum = 4;
		else ranknum = 5; end
		if (ranknum == 5 and GB_SPELLS[GB_MINLVL_SPELLS.BlessingWisdom][GB_TEXT.Rank..6] and level > 49) then
			ranknum = 6;
		end
	elseif (name==GB_MINLVL_SPELLS.BlessingFreedom) then
		if (level < 8) then ranknum = 0; end
	elseif (name==GB_MINLVL_SPELLS.BlessingSalvation) then
		if (level < 16) then ranknum = 0; end
	elseif (name==GB_MINLVL_SPELLS.AbolishDisease) then
		if (level < 22) then ranknum = 0; end
	elseif (name==GB_MINLVL_SPELLS.AbolishPoison) then
		if (level < 16) then ranknum = 0; end
	elseif (name==GB_MINLVL_SPELLS.BlessingSanctuary) then
		if (level < 20) then ranknum = 0;
		elseif (level < 30) then ranknum = 1;
		elseif (level < 40) then ranknum = 2;
		elseif (level < 50) then ranknum = 3;
		else ranknum = 4; end
	elseif (name==GB_MINLVL_SPELLS.BlessingLight) then
		if (level < 30) then ranknum = 0;
		elseif (level < 40) then ranknum = 1;
		elseif (level < 50) then ranknum = 2;
		else ranknum = 3; end
	elseif (name==GB_MINLVL_SPELLS.BlessingKings) then
		if (level < 30) then ranknum = 0; end
	elseif (name==GB_MINLVL_SPELLS.BlessingSacrifice) then
		if (level < 36) then ranknum = 0;
		elseif (level < 44) then ranknum = 1;
		else ranknum = 2; end
	end
	if ( ranknum == 0 ) then
		GB_Feedback(GB_TEXT.LevelTooLow);
		return false;
	else
		if (ranknum and ranknum < orignum) then
			rank = GB_TEXT.Rank..ranknum;				
			GB_SpellChanged(GB_TEXT.RankScaled, name, rank);
		end
		return name, rank;
	end
end

function GB_Get_Texture(bar, button)
	if (not GB_INITIALIZED) then return; end
	local name = GB_Settings[GB_INDEX][bar].Button[button].name;
	local idType = GB_Settings[GB_INDEX][bar].Button[button].idType;
	local texture = "Interface\\AddOns\\GroupButtons\\EmptyButton";
	if (not name) then
		return texture;
	end
	local id;
	if (idType == "spell") then
		id = GB_SPELLS[name][GB_Settings[GB_INDEX][bar].Button[button].rank].id;
		texture = GetSpellTexture(id, "BOOKTYPE_SPELL");
	elseif (idType == "item" and GB_ITEMS[name]) then
		id = GB_ITEMS[name];
		texture = GetContainerItemInfo(id.bag, id.slot);
	elseif (idType == "inv" and GB_INVENTORY[name]) then
		id = GB_INVENTORY[name].id;
		texture = GetInventoryItemTexture("player", id);
	elseif (idType == "macro" and GB_MACROS[name]) then
		id = GB_MACROS[name].id;
		_, texture = GetMacroInfo(id);
	end
	return texture;
end

function GB_Get_UnitBar(param)
	if (not param) then return; end
	local value;
	if (param == "self" or param == "player") then
		value =  "GB_PlayerBar";
	elseif (param == "party1") then
		value =  "GB_PartyBar1";
	elseif (param == "party2") then
		value =  "GB_PartyBar2";
	elseif (param == "party3") then
		value =  "GB_PartyBar3";
	elseif (param == "party4") then
		value =  "GB_PartyBar4";
	elseif (param == "target") then
		if (GB_HostileTargetBar:IsVisible()) then
			value =  "GB_HostileTargetBar";
		elseif (GB_FriendlyTargetBar:IsVisible()) then
			value =  "GB_FriendlyTargetBar";
		elseif (UnitName(param)) then
			if (UnitCanAttack("player", param)) then
				value =  "GB_HostileTargetBar";
			elseif (UnitIsPlayer(param) and UnitFactionGroup("player") ~= UnitFactionGroup(param)) then
				value =  "GB_HostileTargetBar";
			else
				value =  "GB_FriendlyTargetBar";
			end
		end
	elseif (param == "targettarget") then
		if (UnitName(param)) then
			if (UnitCanAttack("player", param)) then
				value =  "GB_HostileTargetBar";
			elseif (UnitIsPlayer(param) and UnitFactionGroup("player") ~= UnitFactionGroup(param)) then
				value =  "GB_HostileTargetBar";
			else
				value =  "GB_FriendlyTargetBar";
			end
		end
	elseif (param == "lowesthealth") then
		value =  "GB_LowestHealthBar";
	elseif (param == "hostiletarget") then
		value =  "GB_HostileTargetBar";
	elseif (param == "friendlytarget") then
		value =  "GB_FriendlyTargetBar";
	elseif (type(param) == "function") then
		value =  "GB_LowestHealthBar";
	elseif (string.find(param, "raid")) then
		local _,_,raidnum = string.find(param, "raid(%d*)");
		value = "GB_RaidBar"..raidnum;
	elseif (param == "pet") then
		value = "GB_PetBar0";
	elseif (string.find(param, "partypet")) then
		local _,_,petnum = string.find(param, "partypet(%d*)");
		value = "GB_PetBar"..petnum;
	end
	return value;
end
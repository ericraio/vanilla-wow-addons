function DUF_Get_ClassColor(unit, defaultcolor)
	local index;
	local class = UnitClass(unit);
		if (class == DUF_TEXT.Druid) then
			index = "classcolorDruid";
		elseif (class == DUF_TEXT.Hunter) then
			index = "classcolorHunter";
		elseif (class == DUF_TEXT.Mage) then
			index = "classcolorMage";
		elseif (class == DUF_TEXT.Paladin) then
			index = "classcolorPaladin";
		elseif (class == DUF_TEXT.Priest) then
			index = "classcolorPriest";
		elseif (class == DUF_TEXT.Rogue) then
			index = "classcolorRogue";
		elseif (class == DUF_TEXT.Shaman) then
			index = "classcolorShaman";
		elseif (class == DUF_TEXT.Warlock) then
			index = "classcolorWarlock";
		elseif (class == DUF_TEXT.Warrior) then
			index = "classcolorWarrior";
		end
	if (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
		return DUF_Settings[DUF_INDEX].reactioncolor6.r, DUF_Settings[DUF_INDEX].reactioncolor6.g, DUF_Settings[DUF_INDEX].reactioncolor6.b;
	elseif (index) then
		return DUF_Settings[DUF_INDEX][index].r, DUF_Settings[DUF_INDEX][index].g, DUF_Settings[DUF_INDEX][index].b;
	elseif (defaultcolor) then
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
end

function DUF_Get_DifficultyColor(unit, defaultcolor)
	local diff = UnitLevel(unit) - UnitLevel("player");
	local difficulty;
	if (UnitLevel(unit) == -1) then
		difficulty = 6;
	elseif (diff < -GetQuestGreenRange()) then
		difficulty = 1;
	elseif (diff < -2) then
		difficulty = 2;
	elseif (diff < 3) then
		difficulty = 3;
	elseif (diff < 5) then
		difficulty = 4;
	elseif (diff < 11) then
		difficulty = 5;
	else
		difficulty = 6;
	end
	if (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
		return DUF_Settings[DUF_INDEX].reactioncolor6.r, DUF_Settings[DUF_INDEX].reactioncolor6.g, DUF_Settings[DUF_INDEX].reactioncolor6.b;
	elseif (difficulty) then
		return DUF_Settings[DUF_INDEX]["lvlcolor"..difficulty].r, DUF_Settings[DUF_INDEX]["lvlcolor"..difficulty].g, DUF_Settings[DUF_INDEX]["lvlcolor"..difficulty].b;
	elseif (defaultcolor) then
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
end

function DUF_Get_ElementName(index, subindex)
	if (index == "StatusBar") then
		if (subindex == 1) then
			return "_HealthBar";
		elseif (subindex == 2) then
			return "_ManaBar";
		elseif (subindex == 3) then
			return "_XPBar";
		elseif (subindex == 4) then
			return "_TargetHealthBar";
		elseif (subindex == 5) then
			return "_TargetManaBar";
		elseif (subindex == 6) then
			return "_HonorBar";
		end
	elseif (index == "TextBox") then
		return "_TextBox_"..subindex;
	else
		return "_"..index;
	end
end

function DUF_Get_Health(unit)
	local health;
	if (unit == "target" and MobHealth_GetTargetCurHP) then
		health = MobHealth_GetTargetCurHP();
		if ((not health) or health == 0) then health = UnitHealth(unit); end
	elseif (string.find(unit, "target") and MobHealth_PPP) then
		if (UnitName(unit) and UnitLevel(unit)) then
			local mhindex = UnitName(unit)..":"..UnitLevel(unit);
			local ppp = MobHealth_PPP(mhindex);
			health = math.floor(UnitHealth(unit) * ppp + 0.5);
		end
		if (health == 0 or (not health)) then health = UnitHealth(unit); end
	else
		health = UnitHealth(unit);
	end
	return health;
end

function DUF_Get_HealthColor(unit, defaultcolor)
	if (not defaultcolor) then
		return;
	end
	local percent;
	if (UnitHealth(unit) and UnitHealthMax(unit)) then
		percent = UnitHealth(unit)/UnitHealthMax(unit);
	else
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
	local r, g, b, diff;
	if (percent <= DUF_Settings[DUF_INDEX].healththreshold2) then
		r = DUF_Settings[DUF_INDEX].healthcolor2.r;
		g = DUF_Settings[DUF_INDEX].healthcolor2.g;
		b = DUF_Settings[DUF_INDEX].healthcolor2.b;
	elseif (percent <= DUF_Settings[DUF_INDEX].healththreshold1) then
		diff = 1 - (percent - DUF_Settings[DUF_INDEX].healththreshold2) / (DUF_Settings[DUF_INDEX].healththreshold1 - DUF_Settings[DUF_INDEX].healththreshold2);
		r = DUF_Settings[DUF_INDEX].healthcolor1.r - (DUF_Settings[DUF_INDEX].healthcolor1.r - DUF_Settings[DUF_INDEX].healthcolor2.r) * diff;
		g = DUF_Settings[DUF_INDEX].healthcolor1.g - (DUF_Settings[DUF_INDEX].healthcolor1.g - DUF_Settings[DUF_INDEX].healthcolor2.g) * diff;
		b = DUF_Settings[DUF_INDEX].healthcolor1.b - (DUF_Settings[DUF_INDEX].healthcolor1.b - DUF_Settings[DUF_INDEX].healthcolor2.b) * diff;
	elseif (percent < 1) then
		diff = 1 - (percent - DUF_Settings[DUF_INDEX].healththreshold1) / (1 - DUF_Settings[DUF_INDEX].healththreshold1);
		r = defaultcolor.r - (defaultcolor.r - DUF_Settings[DUF_INDEX].healthcolor1.r) * diff;
		g = defaultcolor.g - (defaultcolor.g - DUF_Settings[DUF_INDEX].healthcolor1.g) * diff;
		b = defaultcolor.b - (defaultcolor.b - DUF_Settings[DUF_INDEX].healthcolor1.b) * diff;
	else
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
	if (r < 0) then r = 0; end
	if (r > 1) then r = 1; end
	if (g < 0) then g = 0; end
	if (g > 1) then g = 1; end
	if (b < 0) then b = 0; end
	if (b > 1) then b = 1; end
	if (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
		return DUF_Settings[DUF_INDEX].reactioncolor6.r, DUF_Settings[DUF_INDEX].reactioncolor6.g, DUF_Settings[DUF_INDEX].reactioncolor6.b;
	else
		return r, g, b;
	end
end

function DUF_Get_HealthDamage(unit)
	local healthmax = DUF_Get_MaxHealth(unit);
	local health = DUF_Get_Health(unit);
	local damage = healthmax - health;
	if (healthmax == 0) then
		damage = 0;
	end
	return damage;
end

function DUF_Get_ManaColor(unit, defaultcolor)
	if (UnitPowerType(unit) and (not DUF_Settings[DUF_INDEX]["usefor"..UnitPowerType(unit)])) then
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
	local percent;
	if (UnitMana(unit) and UnitManaMax(unit)) then
		percent = UnitMana(unit)/UnitManaMax(unit);
	else
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
	local r, g, b, diff;
	if (percent <= DUF_Settings[DUF_INDEX].manathreshold2) then
		r = DUF_Settings[DUF_INDEX].manacolor2.r;
		g = DUF_Settings[DUF_INDEX].manacolor2.g;
		b = DUF_Settings[DUF_INDEX].manacolor2.b;
	elseif (percent <= DUF_Settings[DUF_INDEX].manathreshold1) then
		diff = 1 - (percent - DUF_Settings[DUF_INDEX].manathreshold2) / (DUF_Settings[DUF_INDEX].manathreshold1 - DUF_Settings[DUF_INDEX].manathreshold2);
		r = DUF_Settings[DUF_INDEX].manacolor1.r - (DUF_Settings[DUF_INDEX].manacolor1.r - DUF_Settings[DUF_INDEX].manacolor2.r) * diff;
		g = DUF_Settings[DUF_INDEX].manacolor1.g - (DUF_Settings[DUF_INDEX].manacolor1.g - DUF_Settings[DUF_INDEX].manacolor2.g) * diff;
		b = DUF_Settings[DUF_INDEX].manacolor1.b - (DUF_Settings[DUF_INDEX].manacolor1.b - DUF_Settings[DUF_INDEX].manacolor2.b) * diff;
	elseif (percent < 1) then
		diff = 1 - (percent - DUF_Settings[DUF_INDEX].manathreshold1) / (1 - DUF_Settings[DUF_INDEX].manathreshold1);
		r = defaultcolor.r - (defaultcolor.r - DUF_Settings[DUF_INDEX].manacolor1.r) * diff;
		g = defaultcolor.g - (defaultcolor.g - DUF_Settings[DUF_INDEX].manacolor1.g) * diff;
		b = defaultcolor.b - (defaultcolor.b - DUF_Settings[DUF_INDEX].manacolor1.b) * diff;
	else
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
	if (r < 0) then r = 0; end
	if (r > 1) then r = 1; end
	if (g < 0) then g = 0; end
	if (g > 1) then g = 1; end
	if (b < 0) then b = 0; end
	if (b > 1) then b = 1; end
	if (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
		return DUF_Settings[DUF_INDEX].reactioncolor6.r, DUF_Settings[DUF_INDEX].reactioncolor6.g, DUF_Settings[DUF_INDEX].reactioncolor6.b;
	else
		return r, g, b;
	end
end

function DUF_Get_MaxHealth(unit)
	local healthmax;
	if (unit == "target" and MobHealth_GetTargetMaxHP and UnitHealth(unit) > 0) then
		healthmax = MobHealth_GetTargetMaxHP();
		if ((not healthmax) or healthmax == 0) then healthmax = UnitHealthMax(unit); end
	elseif (string.find(unit, "target") and MobHealth_PPP) then
		if (UnitName(unit) and UnitLevel(unit)) then
			local mhindex = UnitName(unit)..":"..UnitLevel(unit);
			local ppp = MobHealth_PPP(mhindex);
			healthmax = math.floor(100 * ppp + 0.5);
		end
		if (healthmax == 0 or (not healthmax)) then healthmax = UnitHealthMax(unit); end
	else
		healthmax = UnitHealthMax(unit);
	end
	if (not healthmax) then healthmax = 0; end
	return healthmax;
end

function DUF_Get_Reaction(unit)
	local index;
	if (UnitIsPlayer(unit)) then
		if (UnitIsPVP(unit)) then
			if (UnitCanAttack("player", unit)) then
				index = 1;
			else
				index = 5;
			end
		else
			if (UnitCanAttack("player", unit) or UnitFactionGroup(unit) ~= UnitFactionGroup("player")) then
				index = 2;
			else
				index = 4;
			end
		end
	elseif (UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))) then
		index = 6;
	else
		local reaction = UnitReaction(unit, "player");
		if (reaction) then
			if (reaction < 4) then
				index = 1;
			elseif (reaction == 4) then
				index = 2;
			else
				index = 3;
			end
		end
	end
	return index;
end

function DUF_Get_ReactionColor(unit, defaultcolor)
	local index = DUF_Get_Reaction(unit);
	if (index) then
		return DUF_Settings[DUF_INDEX]["reactioncolor"..index].r, DUF_Settings[DUF_INDEX]["reactioncolor"..index].g, DUF_Settings[DUF_INDEX]["reactioncolor"..index].b;
	elseif (defaultcolor) then
		return defaultcolor.r, defaultcolor.g, defaultcolor.b;
	end
end
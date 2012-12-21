function DUF_HealthBar_Update()
	if ((not this.health) or (not this.healthmax) or this.healthmax == 0) then return; end
	local value = this.health / this.healthmax * 100;
	local value2 = 0;
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].fade and this.lasthealth < this.healthmax) then
		value2 = this.lasthealth / this.healthmax * 100;		
	end
	if (this.lasthealth > this.health and value2 > 0) then
		this.lasthealthalpha = 1;
	end

	local width = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].width
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].resizemax and this.lasthealthmax ~= this.healthmax) then
		this.lasthealthmax = this.healthmax;
		local percent = this.healthmax / UnitHealthMax("player");
		width = width * percent;
		local padding = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].bgpadding * 2;
		getglobal(this:GetName().."_HealthBar").dynamicsize = percent;
		getglobal(this:GetName().."_HealthBar_Background"):SetWidth(width + padding);
	end
	this.lasthealth = this.health;
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].fill) then
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_HealthBar_Bar"), 100 - value, 1, width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_HealthBar_Bar2"), 0, 1, width);
	else
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_HealthBar_Bar"), value, 1, width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_HealthBar_Bar2"), value2, 1, width);
	end
end

function DUF_HonorBar_Update()
	if (DUF_Settings[DUF_INDEX].player.StatusBar[6].trackRep) then
		DUF_ReputationBar_Update(2)
		return
	end
	DUF_StatusBar_SetValue(DUF_PlayerFrame_HonorBar_Bar, GetPVPRankProgress() * 100, 1, DUF_Settings[DUF_INDEX].player.StatusBar[6].width);
	DUF_StatusBar_SetValue(DUF_PlayerFrame_HonorBar_Bar2, GetPVPRankProgress() * 100, 1, DUF_Settings[DUF_INDEX].player.StatusBar[6].width);
end

function DUF_ManaBar_Update()
	if ((not this.mana) or (not this.manamax) or this.manamax == 0) then
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].hideifnomana and (not DUF_OPTIONS_VISIBLE)) then
			getglobal(this:GetName().."_ManaBar"):Hide();
			return;
		else
			if ((not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].hide) and (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].mouseover)) then
				getglobal(this:GetName().."_ManaBar"):Show();
			else
				return;
			end
			if (DUF_OPTIONS_VISIBLE) then
				this.mana = 100;
				this.manamax = 100;
				this.lastmana = 100;
			else
				this.mana = 0;
				this.manamax = 0;
				this.lastmana = 0;
			end
		end
	elseif ((not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].hide) and (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].mouseover)) then
		getglobal(this:GetName().."_ManaBar"):Show();
	end
	if (not this.mana) then this.mana = 0 end
	local value = this.mana / this.manamax * 100;
	local value2 = 0;
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].fade and this.lastmana < this.manamax) then
		value2 = this.lastmana / this.manamax * 100;
	end
	if (this.manamax == 0) then
		value = 0;
		value2 = 0;
	end
	if (this.lastmana > this.mana and value2 > 0) then
		this.lastmanaalpha = 1;
	end
	this.lastmana = this.mana;

	local width = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].width;
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].resizemax and this.lastmanamax ~= this.manamax) then
		this.lastmanamax = this.manamax;
		local percent = this.manamax / UnitManaMax("player");
		width = width * percent;
		local padding = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].bgpadding * 2;
		getglobal(this:GetName().."_ManaBar").dynamicsize = percent;
		getglobal(this:GetName().."_ManaBar_Background"):SetWidth(width + padding);
	end
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].fill) then
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_ManaBar_Bar"), 100 - value, 1, width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_ManaBar_Bar2"), 0, 1, width);
	else
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_ManaBar_Bar"), value, 1, width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_ManaBar_Bar2"), value2, 1, width);
	end
end

function DUF_ManaBar_UpdateType()
	local color;
	if (this.manatype == 0) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].manacolor;
	elseif (this.manatype == 1) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].ragecolor;
	elseif (this.manatype == 2) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].focuscolor;
	elseif (this.manatype == 3) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].energycolor;
	end
	if (color) then
		getglobal(this:GetName().."_ManaBar").manacolor = color;
		getglobal(this:GetName().."_ManaBar_Bar"):SetVertexColor(color.r, color.g, color.b);
	end
end

function DUF_PetXPBar_Update()
	local current, needed = GetPetExperience();
	local percent = current / needed * 100;
	if (needed == 0) then
		percent = 0;
	end
	DUF_StatusBar_SetValue(DUF_PetFrame_XPBar_Bar, percent, 1, DUF_Settings[DUF_INDEX].pet.StatusBar[3].width);
	DUF_StatusBar_SetValue(DUF_PetFrame_XPBar_Bar2, percent, 1, DUF_Settings[DUF_INDEX].pet.StatusBar[3].width);
end

function DUF_TargetHealthBar_Update()
	if ((not this.healthtarget) or (not this.healthmaxtarget) or this.healthmaxtarget == 0) then
		if (DUF_OPTIONS_VISIBLE) then
			if (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[4].hide) then
				getglobal(this:GetName().."_TargetHealthBar"):Show();
			else
				return;
			end
			this.healthtarget = 100;
			this.healthmaxtarget = 100;
		else
			getglobal(this:GetName().."_TargetHealthBar"):Hide();
			return;
		end
	end
	if (not this.unit) then return; end
	if ( (not DL_UnitName(this.unit.."target")) and (not DUF_OPTIONS_VISIBLE) ) then
		getglobal(this:GetName().."_TargetHealthBar"):Hide();
		return;
	elseif (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[4].hide) then
		getglobal(this:GetName().."_TargetHealthBar"):Show();
	end
	local value = this.healthtarget / this.healthmaxtarget * 100;
	if (this.healthmaxtarget == 0) then
		value = 100;
	end
	local width = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[4].width;
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[4].fill) then
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetHealthBar_Bar"), 100 - value, 1, width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetHealthBar_Bar2"), 0, 1, width);
	else
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetHealthBar_Bar"), value, 1, width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetHealthBar_Bar2"), 0, 1, width);
	end
end

function DUF_TargetManaBar_Update()
	if ((not this.manatarget) or (not this.manamaxtarget) or this.manamaxtarget == 0) then
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].hideifnomana and (not DUF_OPTIONS_VISIBLE)) then
			getglobal(this:GetName().."_TargetManaBar"):Hide();
			return;
		elseif (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].hide) then
			getglobal(this:GetName().."_TargetManaBar"):Show();
			this.manatarget = 0;
			this.manamaxtarget = 0;
		else
			return;
		end
	end
	if (not this.unit) then return; end
	if ((not DL_UnitName(this.unit.."target")) and (not DUF_OPTIONS_VISIBLE)) then
		getglobal(this:GetName().."_TargetManaBar"):Hide();
		return;
	elseif (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].hide) then
		getglobal(this:GetName().."_TargetManaBar"):Show();
	end
	local value = this.manatarget / this.manamaxtarget * 100;
	if (this.manamaxtarget == 0) then
		value = 100;
	end
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].fill) then
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetManaBar_Bar"), 100 - value, 1, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetManaBar_Bar2"), 0, 1, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].width);
	else
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetManaBar_Bar"), value, 1, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].width);
		DUF_StatusBar_SetValue(getglobal(this:GetName().."_TargetManaBar_Bar2"), 0, 1, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].width);
	end
end

function DUF_TargetManaBar_UpdateType()
	local color;
	if (this.manatypetarget == 0) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].manacolor;
	elseif (this.manatypetarget == 1) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].ragecolor;
	elseif (this.manatypetarget == 2) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].focuscolor;
	elseif (this.manatypetarget == 3) then
		color = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[5].energycolor;
	end
	if (color) then
		getglobal(this:GetName().."_TargetManaBar").manacolor = color;
		getglobal(this:GetName().."_TargetManaBar_Bar"):SetVertexColor(color.r, color.g, color.b);
	end
end

function DUF_XPBar_Update()
	if (DUF_Settings[DUF_INDEX].player.StatusBar[3].trackRep) then
		DUF_ReputationBar_Update(1)
		return
	end
	local percent = UnitXP("player") / UnitXPMax("player") * 100;
	if (UnitXPMax("player") == 0) then
		percent = 0;
	end
	local bonusxp = GetXPExhaustion();
	local bonusxp2 = 0;
	if (bonusxp) then
		bonusxp2 = bonusxp;
		bonusxp = math.floor(bonusxp / 2);
	else
		bonusxp = 0;
	end
	local bonuspercent = (UnitXP("player") + bonusxp2)/ UnitXPMax("player") * 100;
	if (UnitXPMax("player") == 0) then
		bonuspercent = 0;
	end
	if (bonuspercent > 100) then
		bonuspercent = 100;
	end
	DUF_StatusBar_SetValue(DUF_PlayerFrame_XPBar_Bar, percent, 1, DUF_Settings[DUF_INDEX].player.StatusBar[3].width);
	DUF_StatusBar_SetValue(DUF_PlayerFrame_XPBar_Bar2, bonuspercent, 1, DUF_Settings[DUF_INDEX].player.StatusBar[3].width);
end

function DUF_ReputationBar_Update(bar)
	local _, _, min, max, value = GetWatchedFactionInfo();
	local percent = (value - min) / (max - min) * 100;
	if (max - min == 0) then
		percent = 0
	end
	local frame, frame2, sbi
	if (bar == 1) then
		frame = DUF_PlayerFrame_XPBar_Bar
		frame2 = DUF_PlayerFrame_XPBar_Bar2
		sbi = 3
	else
		frame = DUF_PlayerFrame_HonorBar_Bar
		frame2 = DUF_PlayerFrame_HonorBar_Bar2
		sbi = 6
	end
	DUF_StatusBar_SetValue(frame, percent, 1, DUF_Settings[DUF_INDEX].player.StatusBar[sbi].width);
	DUF_StatusBar_SetValue(frame2, percent, 1, DUF_Settings[DUF_INDEX].player.StatusBar[sbi].width);
end

function DUF_StatusBar_SetValue(bar, value)
	if (value == 0) then value = .01; end
	value = value / 100;
	if (value > 1) then value = 1; end

	if (bar.direction < 3) then
		bar:SetWidth(bar.length * value);
	else
		bar:SetHeight(bar.length * value);
	end

	if (bar.direction == 1) then
		bar:SetTexCoord(0, value, 0, 1);
	elseif (bar.direction == 2) then
		bar:SetTexCoord(value, 0, 0, 1);
	elseif (bar.direction == 3) then
		bar:SetTexCoord(0, 1, value, 0);
	elseif (bar.direction == 4) then
		bar:SetTexCoord(0, 1, 0, value);
	end
end
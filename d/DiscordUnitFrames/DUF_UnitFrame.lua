function DUF_Aura_OnUpdate(elapsed, filter)
	if (not DUF_INITIALIZED) then return; end
	if (this.flashing) then
		this.timer = this.timer - elapsed;
		if (this.timer < 0) then
			this.timer = .5;
			if (this.direction) then
				this.direction = nil;
			else
				this.direction = true;
			end
		end
		if (this.direction) then
			this:SetAlpha(this.timer + .5);
		else
			this:SetAlpha(1 - this.timer);
		end
	end
	if (not this.playerbuff) then return; end
	local buffID = this:GetID();
	local altformat;
	if (filter == "HELPFUL") then
		altformat = DUF_Settings[DUF_INDEX].player.Buffs.altformat;
	else
		altformat = DUF_Settings[DUF_INDEX].player.Debuffs.altformat;
	end
	if (filter == "HELPFUL" and DUF_Settings[DUF_INDEX].player.Buffs.reverse) then
		buffID = 17 - buffID;
	elseif (filter == "HARMFUL" and DUF_Settings[DUF_INDEX].player.Debuffs.reverse) then
		buffID = 17 - buffID;
	end
	local buffIndex, untilCancelled = GetPlayerBuff(buffID - 1, filter);
	local buffText = getglobal(this:GetName().."_Text");
	local timeLeft = math.floor(GetPlayerBuffTimeLeft(buffIndex));
	if (timeLeft and timeLeft > 0) then
		if (altformat) then
			if (timeLeft > 60) then
				local seconds = timeLeft - math.floor(timeLeft / 60) * 60;
				if (seconds < 10) then
					buffText:SetText(math.floor(timeLeft / 60)..":0"..seconds);
				else
					buffText:SetText(math.floor(timeLeft / 60)..":"..seconds);
				end
			else
				if (timeLeft < 10) then
					buffText:SetText("0:0"..timeLeft);
				else
					buffText:SetText("0:"..timeLeft);
				end
			end
		else
			buffText:SetText(SecondsToTimeAbbrev(timeLeft));
		end			
		if ((not untilCancelled) and timeLeft < 61 and timeLeft > 0) then
			if (not this.flashing) then
				this.flashing = true;
				this.timer = .5;
				this.direction = 1;
			end
		elseif (this.flashing) then
			if (filter == "HELPFUL") then
				this.flashing = nil;
				this:SetAlpha(1);
			elseif (not DUF_Settings[DUF_INDEX].player.Debuffs.flash) then
				this.flashing = nil;
				this:SetAlpha(1);
			end
		end
	elseif (DUF_OPTIONS_VISIBLE) then
		if (altformat) then
			buffText:SetText("99:99");
		else
			buffText:SetText("99 m");
		end
	else
		buffText:SetText("");
	end
	if ( GameTooltip:IsOwned(this) ) then
		GameTooltip:SetPlayerBuff(buffIndex);
	end
end

function DUF_Buff_OnClick(button)
	if (this.playerbuff and button == "RightButton") then
		local buffID = this:GetID();
		if (DUF_Settings[DUF_INDEX].player.Buffs.reverse) then
			buffID = 17 - buffID;
		end
		CancelPlayerBuff(GetPlayerBuff(buffID - 1, "HELPFUL"));
	end
end

function DUF_Buff_OnEnter()
	local buffID = this:GetID();
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this:GetParent():GetParent().unit].index].Buffs.reverse) then
		buffID = 17 - buffID;
	end
	if (this:GetRight() > UIParent:GetRight() / 2) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	if (this.playerbuff) then
		GameTooltip:SetPlayerBuff(GetPlayerBuff(buffID - 1, "HELPFUL"));
	else
		GameTooltip:SetUnitBuff(this:GetParent():GetParent().unit, buffID);
	end
end


function DUF_Buff_OnLeave()
	GameTooltip:Hide();
end

function DUF_Debuff_OnClick(button)
	if (this.playerbuff and button == "RightButton") then
		local buffID = this:GetID();
		if (DUF_Settings[DUF_INDEX].player.Debuffs.reverse) then
			buffID = 17 - buffID;
		end
		CancelPlayerBuff(GetPlayerBuff(buffID - 1, "HARMFUL"));
	end
end

function DUF_Debuff_OnEnter()
	local buffID = this:GetID();
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this:GetParent():GetParent().unit].index].Debuffs.reverse) then
		buffID = 17 - buffID;
	end
	if (this:GetRight() > UIParent:GetRight() / 2) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	if (this.playerbuff) then
		GameTooltip:SetPlayerBuff(GetPlayerBuff(buffID - 1, "HARMFUL"));
	else
		GameTooltip:SetUnitDebuff(this:GetParent():GetParent().unit, buffID);
	end
end

function DUF_Debuff_OnLeave()
	GameTooltip:Hide();
end

function DUF_UnitFrame_OnClick(button)
	local unit = this.unit;

	if ( SpellIsTargeting() ) then
		if (button == "RightButton") then
			SpellStopTargeting();
		else
			SpellTargetUnit(unit);
		end
		return;
	elseif (CursorHasItem()) then
		DropItemOnUnit(unit);
		return;
	end

	local frameindex = DUF_FRAME_DATA[unit].index
	local action;
	if (button == "LeftButton") then
		action = DUF_Settings[DUF_INDEX][frameindex].leftclick;
	elseif (button == "RightButton") then
		action = DUF_Settings[DUF_INDEX][frameindex].rightclick;
	elseif (button == "MiddleButton") then
		action = DUF_Settings[DUF_INDEX][frameindex].middleclick;
	end
	if (action == 1) then
		TargetUnit(unit);
	elseif (action == 2) then
		AssistUnit(unit);
	elseif (action == 3) then
		DUF_UnitPopup_ShowMenu(unit);
	end
end

function DUF_UnitFrame_OnDragStart()
	if (DUF_FRAMES_UNLOCKED) then
		this:StartMoving();
		this.moving = true;
	end
end

function DUF_UnitFrame_OnDragStop()
	if (DUF_FRAMES_UNLOCKED) then
		this:StopMovingOrSizing();
		this.moving = nil;
		local frameindex = DUF_FRAME_DATA[this.unit].index;
		local xoffset, yoffset = DL_Get_Offsets(this, UIParent, "TOPLEFT", "TOPLEFT");
		DUF_Settings[DUF_INDEX][frameindex].xos[this:GetID()] = xoffset;
		DUF_Settings[DUF_INDEX][frameindex].yos[this:GetID()] = yoffset;
		this:ClearAllPoints();
		this:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", xoffset, yoffset);
	end
end

function DUF_UnitFrame_OnEnter()
	local unit = this.unit;
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index];

	if (settings.usemouseovercolor) then
		getglobal(this:GetName().."_Background"):SetBackdropColor(settings.mouseovercolor.r, settings.mouseovercolor.g, settings.mouseovercolor.b, settings.bgalpha);
	end

	if (settings.mouseovergroup) then
		local unitFrame = this;
		local unitFrameName = unitFrame:GetName();
		local element;
		for index, value in DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index] do
			if (type(value) == "table") then
				if (index == "StatusBar") then
					for i = 1,6 do
						if (value[i]) then
							if (value[i].mouseovergroup == settings.mouseovergroup) then
								if (value[i].mouseover) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Show();
								end
								if (value[i].usemouseovercolor) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i).."_Background"):SetBackdropColor(value[i].mouseovercolor.r, value[i].mouseovercolor.g, value[i].mouseovercolor.b, value[i].bgalpha);
								end
							end
						end
					end
				elseif (index == "TextBox") then
					for i = 1,10 do
						if (value[i].mouseovergroup == settings.mouseovergroup) then
							if (value[i].mouseover) then
								getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Show();
							end
							if (value[i].usemouseovercolor) then
								getglobal(unitFrameName..DUF_Get_ElementName(index, i).."_Background"):SetBackdropColor(value[i].mouseovercolor.r, value[i].mouseovercolor.g, value[i].mouseovercolor.b, value[i].bgalpha);
							end
						end
					end
				else
					if (value.mouseovergroup == settings.mouseovergroup) then
						if (value.mouseover) then
							getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Show();
						end
						if (value.usemouseovercolor) then
							getglobal(unitFrameName..DUF_Get_ElementName(index).."_Background"):SetBackdropColor(value.mouseovercolor.r, value.mouseovercolor.g, value.mouseovercolor.b, value.bgalpha);
						end
					end
				end
			end
		end
	end

	if (settings.disabletooltip) then
		return;
	end
	if (unit and UnitName(unit)) then
		if (settings.usecustomtooltip) then
			local text = settings.customtooltip;
			if (text) then
				for var, value in DUF_VARIABLE_FUNCTIONS do
					if (string.find(text, var)) then
						text = value.func(text, unit);
					end
				end
				GameTooltip_SetDefaultAnchor(GameTooltip, this)	
				GameTooltip:SetText(text, 1, 1, 1, 1, 1);
				GameTooltip:Show();
			end
		else
			UnitFrame_OnEnter();
		end
	end
end

function DUF_UnitFrame_OnEvent(event)
	if (not DUF_INITIALIZED) then return; end
	if (not this:IsVisible()) then return; end

	if (event == DUF_UNIT_CHANGED_EVENTS[this.unit]) then
		this:Hide()
		this:Show()
	elseif (event == "RAID_TARGET_UPDATE") then
		DUF_Set_RaceIcon(this.unit)
		DUF_Set_RankIcon(this.unit)
	end

	if (arg1 ~= this.unit) then return; end

	if (event == "UNIT_AURA") then
		this.updateauras = true;
	elseif (event == "UNIT_NAME_UPDATE") then
		DUF_Set_ClassIcon(this.unit);
		DUF_Set_RaceIcon(this.unit);
	elseif (event == "UNIT_PORTRAIT_UPDATE") then
		DUF_Set_Portrait(this.unit)
	end
end

function DUF_UnitFrame_OnHide()
	if (this.unit == "target") then
		PlaySound("INTERFACESOUND_LOSTTARGETUNIT");
	end
	if (this.moving) then
		DUF_UnitFrame_OnDragStop();
	end
end

function DUF_UnitFrame_OnLeave()
	local unit = this.unit;
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index];

	if (settings.usemouseovercolor) then
		getglobal(this:GetName().."_Background"):SetBackdropColor(settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	end

	if (settings.mouseovergroup) then
		local unitFrame = this;
		local unitFrameName = unitFrame:GetName();
		local element;

		for index, value in DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index] do
			if (type(value) == "table") then
				if (index == "StatusBar") then
					for i = 1,6 do
						if (value[i]) then
							if (value[i].mouseovergroup == settings.mouseovergroup) then
								if (value[i].mouseover) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Hide();
								end
								if (value[i].usemouseovercolor) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i).."_Background"):SetBackdropColor(value[i].bgcolor.r, value[i].bgcolor.g, value[i].bgcolor.b, value[i].bgalpha);
								end
							end
						end
					end
				elseif (index == "TextBox") then
					for i = 1,10 do
						if (value[i].mouseovergroup == settings.mouseovergroup) then
							if (value[i].mouseover) then
								getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Hide();
							end
							if (value[i].usemouseovercolor) then
								getglobal(unitFrameName..DUF_Get_ElementName(index, i).."_Background"):SetBackdropColor(value[i].bgcolor.r, value[i].bgcolor.g, value[i].bgcolor.b, value[i].bgalpha);
							end
						end
					end
				else
					if (value.mouseovergroup == settings.mouseovergroup) then
						if (value.mouseover) then
							getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Hide();
						end
						if (value.usemouseovercolor) then
							getglobal(unitFrameName..DUF_Get_ElementName(index).."_Background"):SetBackdropColor(value.bgcolor.r, value.bgcolor.g, value.bgcolor.b, value.bgalpha);
						end
					end
				end
			end
		end
	end
	if (UnitName(this.unit)) then
		UnitFrame_OnLeave();
	end
end

function DUF_UnitFrame_OnLoad()
	for unit, data in DUF_FRAME_DATA do
		if (this:GetName() == data.frame) then
			this.unit = unit;
		end
	end

	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_COMBAT");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	this:RegisterEvent("RAID_TARGET_UPDATE");
	if (DUF_UNIT_CHANGED_EVENTS[this.unit]) then
		this:RegisterEvent(DUF_UNIT_CHANGED_EVENTS[this.unit])
	end
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
end

function DUF_UnitFrame_OnShow()
	if (not DUF_INITIALIZED) then return; end
	DUF_HealthBar_Update();
	DUF_LootIcon_Update(this.unit);
	DUF_LeaderIcon_Update(this.unit);
	DUF_PVPIcon_Update(this.unit);
	DUF_StatusIcon_Update(this.unit);
	DUF_UnitFrame_UpdateBuffs(this.unit);
	DUF_UnitFrame_UpdateDebuffs(this.unit);
	DUF_Set_ClassIcon(this.unit);
	DUF_Set_Portrait(this.unit);
	DUF_Set_RaceIcon(this.unit);
	DUF_Set_RankIcon(this.unit);

	local background = getglobal(this:GetName().."_Background");
	if (not background) then return end
	local r, g, b;
	local context = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].context;
	local bgcontext = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcontext;
	local bordercontext = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercontext;
	if (context == 1 or bgcontext == 1) then
		r, g, b = DUF_Get_DifficultyColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcolor);
	elseif (context == 2 or bgcontext == 2) then
		r, g, b = DUF_Get_ReactionColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcolor);
	elseif (context == 3 or bgcontext == 3) then
		r, g, b = DUF_Get_ClassColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcolor);
	else
		r, g, b = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcolor.r, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcolor.g, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcolor.b;
	end
	this.basecolor = {};
	this.basecolor.r = r;
	this.basecolor.g = g;
	this.basecolor.b = b;
	background:SetBackdropColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgalpha);

	if (bordercontext == 1) then
		r, g, b = DUF_Get_DifficultyColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor);
	elseif (bordercontext == 2) then
		r, g, b = DUF_Get_ReactionColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor);
	elseif (bordercontext == 3) then
		r, g, b = DUF_Get_ClassColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor);
	else
		r, g, b = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor.r, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor.g, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor.b;
	end
	background:SetBackdropBorderColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].borderalpha);

	this.mana = nil;
	this.health = nil;
	this.manatarget = nil;
	this.healthtarget = nil;

	if (this.unit == "target") then
		if ( UnitIsEnemy("target", "player") ) then
			PlaySound("igCreatureAggroSelect");
		elseif ( UnitIsFriend("player", "target") ) then
			PlaySound("igCharacterNPCSelect");
		else
			PlaySound("igCreatureNeutralSelect");
		end
	end

	local frame = DUF_FRAME_DATA[this.unit].frame
	for i=1,10 do
		this = getglobal(frame.."_TextBox_"..i);
		DUF_TextBox_Update();
	end
end

function DUF_UnitFrame_OnUpdate(elapsed)
	if (not DUF_INITIALIZED) then return; end
	local targettarget;
	if (this.index == "targettarget" and (not UnitName("targettarget")) and (not DUF_OPTIONS_VISIBLE)) then
		this:Hide();
		return;
	end
	if (not this.timer) then this.timer = DUF_Settings[DUF_INDEX].updatespeed; end
	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = DUF_Settings[DUF_INDEX].updatespeed;
		local health = UnitHealth(this.unit);
		local healthmax = UnitHealthMax(this.unit);
		local healthtarget = UnitHealth(this.unit.."target");
		local healthmaxtarget = UnitHealthMax(this.unit.."target");
		local manatarget = UnitMana(this.unit.."target");
		local manamaxtarget = UnitManaMax(this.unit.."target");
		local targetname = UnitName(this.unit.."target");
		local mana = UnitMana(this.unit);
		local manamax = UnitManaMax(this.unit);
		local manatype = UnitPowerType(this.unit);
		local manatypetarget = UnitPowerType(this.unit.."target");
		local status = 0;
		local leader = UnitIsPartyLeader(this.unit);
		local inParty = GetNumPartyMembers() + GetNumRaidMembers();
		if (inParty == 0) then
			leader = nil;
		end
		local pvp = UnitIsPVP(this.unit);
		local pvpfree = UnitIsPVPFreeForAll(this.unit);
		local _,loot = GetLootMethod();
		local level = UnitLevel(this.unit);
		local reaction = DUF_Get_Reaction(this.unit);
		local optionsvisible = DUF_OPTIONS_VISIBLE;
		local targetIndex
		if (this.unit == "target" or this.unit == "targettarget") then
			targetIndex = GetRaidTargetIndex(this.unit)
		else
			targetIndex = GetRaidTargetIndex(this.unit.."target")
		end
		

		if ((not this.lastmana) or mana > this.lastmana) then this.lastmana = mana; end
		if ((not this.lasthealth) or health > this.lasthealth) then this.lasthealth = health; end

		if (targetIndex ~= this.targetIndex) then
			this.targetIndex = targetIndex
			if (targetIndex) then
				if (this.targetIcon == 1) then
					getglobal(this:GetName().."_RankIcon"):Show()
					SetRaidTargetIconTexture(getglobal(this:GetName().."_RankIcon_Texture"), targetIndex)
				elseif (this.targetIcon == 2) then
					getglobal(this:GetName().."_RaceIcon"):Show()
					SetRaidTargetIconTexture(getglobal(this:GetName().."_RaceIcon_Texture"), targetIndex)
				elseif (this.targetIcon == 3) then
					getglobal(this:GetName().."_RankIcon"):Show()
					getglobal(this:GetName().."_RaceIcon"):Show()
					SetRaidTargetIconTexture(getglobal(this:GetName().."_RankIcon_Texture"), targetIndex)
					SetRaidTargetIconTexture(getglobal(this:GetName().."_RaceIcon_Texture"), targetIndex)
				end
			else
				if (this.targetIcon == 1) then
					getglobal(this:GetName().."_RankIcon"):Hide()
				elseif (this.targetIcon == 2) then
					getglobal(this:GetName().."_RaceIcon"):Hide()
				elseif (this.targetIcon == 3) then
					getglobal(this:GetName().."_RankIcon"):Hide()
					getglobal(this:GetName().."_RaceIcon"):Hide()
				end
			end
		end

		if ((not inParty) or inParty == 0) then
			loot = nil;
		end
		local rank = UnitPVPRank(this.unit);
		if (health <= 0 or UnitIsGhost(this.unit)) then
			status = 1;
		elseif (this.unit == "player" and DL_ATTACKING) then
			status = 2;
		elseif (this.unit == "player" and DL_INCOMBAT) then
			status = 2;
		elseif (UnitAffectingCombat(this.unit)) then
			status = 2;
		elseif (this.unit == "player" and IsResting()) then
			status = 3;
		end

		if (reaction ~= this.reaction) then
			this.reaction = reaction;
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].context == 2 or DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcontext == 2) then
				local r, g, b = DUF_Get_ReactionColor(this.unit, this.basecolor);
				getglobal(this:GetName().."_Background"):SetBackdropColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgalpha);
			end
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercontext == 2) then
				local r, g, b = DUF_Get_ReactionColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor);
				getglobal(this:GetName().."_Background"):SetBackdropBorderColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].borderalpha);
			end
		end
		if (this.health ~= health or this.healthmax ~= healthmax) then
			this.health = health;
			this.healthmax = healthmax;
			DUF_HealthBar_Update();
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].context == 4 or DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcontext == 4) then
				local r, g, b = DUF_Get_HealthColor(this.unit, this.basecolor);
				getglobal(this:GetName().."_Background"):SetBackdropColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgalpha);
			end
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercontext == 4) then
				local r, g, b = DUF_Get_HealthColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor);
				getglobal(this:GetName().."_Background"):SetBackdropBorderColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].borderalpha);
			end
		end
		if (this.mana ~= mana or this.manamax ~= manamax) then
			this.mana = mana;
			this.manamax = manamax;
			DUF_ManaBar_Update();
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].context == 5 or DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgcontext == 5) then
				local r, g, b = DUF_Get_ManaColor(this.unit, this.basecolor);
				getglobal(this:GetName().."_Background"):SetBackdropColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bgalpha);
			end
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercontext == 5) then
				local r, g, b = DUF_Get_ManaColor(this.unit, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].bordercolor);
				getglobal(this:GetName().."_Background"):SetBackdropBorderColor(r, g, b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].borderalpha);
			end
			for i=1,10 do
				if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[i].hideifnomana) then
					if ((not this.mana) or (not this.manamax) or this.manamax == 0) then
						if (DUF_OPTIONS_VISIBLE and (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[i].hide) and (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[i].mouseover)) then
							getglobal(this:GetName().."_TextBox_"..i):Show();
						else
							getglobal(this:GetName().."_TextBox_"..i):Hide();
						end
					elseif ((not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[i].hide) and (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[i].mouseover)) then
						getglobal(this:GetName().."_TextBox_"..i):Show();
					end
				end
			end
		end
		if (this.status ~= status or this.optionsvisible ~= optionsvisible) then
			this.status = status;
			DUF_StatusIcon_Update(this.unit);
		end
		if (leader ~= this.leader or this.optionsvisible ~= optionsvisible) then
			this.leader = leader;
			DUF_LeaderIcon_Update(this.unit);
		end
		if (this.pvp ~= pvp or this.pvpfree ~= pvpfree or this.optionsvisible ~= optionsvisible) then
			this.pvp = pvp;
			this.pvpfree = pvpfree;
			DUF_PVPIcon_Update(this.unit);
			if (this.unit == "player") then
				if (this.pvp or this.pvpfree) then
					PlaySound("igPVPUpdate");
				end
			end
		end
		if (this.loot ~= loot or this.optionsvisible ~= optionsvisible) then
			this.loot = loot;
			DUF_LootIcon_Update(this.unit);
		end
		if (this.rank ~= rank or this.optionsvisible ~= optionsvisible) then
			this.rank = rank;
			DUF_Set_RankIcon(this.unit);
		end
		if (this.healthtarget ~= healthtarget or this.healthmaxtarget ~= healthmaxtarget) then
			this.healthtarget = healthtarget;
			this.healthmaxtarget = healthmaxtarget;
			DUF_TargetHealthBar_Update();
		end
		if (this.manatarget ~= manatarget or this.manamaxtarget ~= manamaxtarget) then
			this.manatarget = manatarget;
			this.manamaxtarget = manamaxtarget;
			DUF_TargetManaBar_Update();
		end
		if (this.manatype ~= manatype) then
			this.manatype = manatype;
			DUF_ManaBar_UpdateType();
		end
		if (this.manatypetarget ~= manatypetarget) then
			this.manatypetarget = manatypetarget;
			DUF_TargetManaBar_UpdateType();
		end
		if (this.updateauras) then
			this.updateauras = nil;
			DUF_UnitFrame_UpdateBuffs(this.unit);
			DUF_UnitFrame_UpdateDebuffs(this.unit);
		end
		if (this.targetname ~= targetname) then
			this.targetname = targetname;
			local textbox;
			for i=1,10 do
				textbox = getglobal(this:GetName().."_TextBox_"..i);
				if (textbox.checkname) then
					if (targetname and (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[i].hide) and (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[i].mouseover)) then
						textbox:Show();
					elseif (not DUF_OPTIONS_VISIBLE) then
						textbox:Hide();
					end
				end
			end
		end

		if (this.unit == "targettarget") then
			targettarget = true;
			for i=1,10 do
				this = getglobal("DUF_TargetOfTargetFrame_TextBox_"..i);
				DUF_TextBox_Update();
			end
			this = DUF_TargetOfTargetFrame;
			DUF_UnitFrame_UpdateBuffs("targettarget");
			DUF_UnitFrame_UpdateDebuffs("targettarget");
		end

		this.optionsvisible = optionsvisible;
	end

	if (targettarget) then
		this = DUF_TargetOfTargetFrame;
	end

	if (this.lastmanaalpha and this.lastmanaalpha > 0) then
		getglobal(this:GetName().."_ManaBar_Bar2"):SetAlpha(this.lastmanaalpha);
		this.lastmanaalpha = this.lastmanaalpha - elapsed;
	end
	if (this.lasthealthalpha and this.lasthealthalpha > 0) then
		getglobal(this:GetName().."_HealthBar_Bar2"):SetAlpha(this.lasthealthalpha);
		this.lasthealthalpha = this.lasthealthalpha - elapsed;
	end

	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].incombat or DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].healthupdating or DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].manaupdating) then
		local show;
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].incombat and this.status == 2) then
			show = 1;
		end
		if (this.health and this.healthmax) then
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].healthupdating and this.health < this.healthmax) then
				show = 1;
			end
		end
		if (this.mana and this.manamax and DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[1].manaupdating) then
			local _, class = UnitClass(this.unit);
			if (class == "WARRIOR") then
				if (this.mana > 0) then
					show = 1;
				end
			else
				if (this.mana < this.manamax) then
					show = 1;
				end
			end
		end
		if (show) then
			getglobal(this:GetName().."_HealthBar"):Show();
		else
			getglobal(this:GetName().."_HealthBar"):Hide();
		end
	end

	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].incombat or DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].healthupdating or DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].manaupdating) then
		local show;
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].incombat and this.status == 2) then
			show = 1;
		end
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].healthupdating and this.health < this.healthmax) then
			show = 1;
		end
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].StatusBar[2].manaupdating and this.mana and this.manamax and this.mana < this.manamax) then
			show = 1;
		end
		if (show) then
			getglobal(this:GetName().."_ManaBar"):Show();
		else
			getglobal(this:GetName().."_ManaBar"):Hide();
		end
	end

	for t=1,10 do
		local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].TextBox[t];
		if (settings.incombat or settings.healthupdating or settings.manaupdating) then
			local show;
			if (settings.incombat and this.status == 2) then
				show = 1;
			end
			if (settings.healthupdating and this.health and this.healthmax and this.health < this.healthmax) then
				show = 1;
			end
			if (settings.manaupdating and this.mana and this.manamax and this.mana < this.manamax) then
				show = 1;
			end
			if (show) then
				getglobal(this:GetName().."_TextBox_"..t):Show();
			else
				getglobal(this:GetName().."_TextBox_"..t):Hide();
			end
		end
	end

	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[this.unit].index].flash) then
		if (UnitHealth(this.unit) / UnitHealthMax(this.unit) <= DUF_Settings[DUF_INDEX].flashthreshold and UnitHealth(this.unit) > 0 and (not UnitIsGhost(this.unit))) then
			this.Flashing = true;
			if (not this.flashTimer) then
				this.flashTimer = .5;
			end
		elseif (this.Flashing) then
			this.Flashing = nil;
			getglobal(this:GetName().."_Background"):SetAlpha(1);
			return;
		else
			return;
		end
		this.flashTimer = this.flashTimer - arg1;
		if (this.flashTimer < 0) then
			this.flashTimer = .5;
			if (this.Direction) then
				this.Direction = nil;
			else
				this.Direction = 1;
			end
		else
			if (this.Direction) then
				getglobal(this:GetName().."_Background"):SetAlpha(this.flashTimer * 2);
			else
				getglobal(this:GetName().."_Background"):SetAlpha(1 - this.flashTimer * 2);
			end
		end
	end
end

function DUF_UnitFrame_UpdateBuffs(unit)
	local buffcount = 0;
	local buff, button, icon, count;
	for j=1,16 do
		local i = j;
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.reverse) then
			i = 17 - j;
		end
		button = getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs_"..i);
		if (j <= DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.shown) then
			if (button.playerbuff) then
				buff = GetPlayerBuffTexture(GetPlayerBuff(j - 1, "HELPFUL"));
				count = GetPlayerBuffApplications(GetPlayerBuff(j - 1, "HELPFUL"));
			else
				buff = UnitBuff(unit, j);
			end
			icon = getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs_"..i.."_Texture");
			if (buff) then
				icon:SetTexture(buff);
				button:Show();
				buffcount = j;
				if (count and count > 0) then
					getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs_"..i.."_Stack"):Show()
					getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs_"..i.."_Stack"):SetText(count);
				else
					getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs_"..i.."_Stack"):Hide()
				end
			elseif (DUF_OPTIONS_VISIBLE) then
				icon:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Buff");
				button:Show();
				buffcount = j;
			else
				button:Hide();
			end
		else
			button:Hide();
		end
	end
	local background = getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs");
	if (buffcount == 0) then
		background:Hide();
		background:SetHeight(.5);
		background:SetWidth(.5);
		return;
	elseif (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.hide) then
		background:Show();
	else
		return;
	end
	local size = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.size;
	local hspacing = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.hspacing;
	local vspacing = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.vspacing;
	local height, width;
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.tworows) then
		local row2start = math.ceil(DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.shown / 2);
		local rows = 1;
		if (buffcount > row2start) then
			buffcount = row2start;
			rows = 2;
		end
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.vertical) then
			height = size * buffcount + vspacing * (buffcount - 1);
			width = size * rows + hspacing * (rows - 1);
		else
			width = size * buffcount + hspacing * (buffcount - 1);
			height = size * rows + vspacing * (rows - 1);
		end
	else
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.vertical) then
			height = size * buffcount + vspacing * (buffcount - 1);
			width = size;
		else
			width = size * buffcount + hspacing * (buffcount - 1);
			height = size;
		end
	end
	background:SetWidth(width);
	background:SetHeight(height);
	background = getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs_Background");
	background:SetWidth(width + DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.bgpadding * 2);
	background:SetHeight(height + DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs.bgpadding * 2);
end

function DUF_UnitFrame_UpdateDebuffs(unit)
	local buffcount = 0;
	local buff, button, icon, debuffApplications, color, debuffType, border;
	for j=1,16 do
		local i = j;
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.reverse) then
			i = 17 - j;
		end
		button = getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs_"..i);
		border = getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs_"..i.."Border");
		if (j <= DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.shown) then
			if (button.playerbuff) then
				buff = GetPlayerBuffTexture(GetPlayerBuff(j - 1, "HARMFUL"));
				debuffApplications = GetPlayerBuffApplications(GetPlayerBuff(j - 1, "HARMFUL"));
				debuffType = GetPlayerBuffDispelType(GetPlayerBuff(j - 1, "HARMFUL"));
			else
				buff, debuffApplications, debuffType = UnitDebuff(unit, j);
			end

			if ( debuffType ) then
				color = DebuffTypeColor[debuffType];
			else
				color = DebuffTypeColor["none"];
			end
			border:SetVertexColor(color.r, color.g, color.b);

			icon = getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs_"..i.."_Texture")
			if (buff) then
				icon:SetTexture(buff);
				button:Show();
				buffcount = j;
			elseif (DUF_OPTIONS_VISIBLE) then
				icon:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Debuff");
				button:Show();
				buffcount = j;
				debuffApplications = 5;
			else
				button:Hide();
			end
			if (debuffApplications and debuffApplications > 1) then
				getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs_"..i.."_Stack"):SetText(debuffApplications);
			else
				getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs_"..i.."_Stack"):SetText("");
			end
		else
			button:Hide();
		end
	end
	local background = getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs");
	if (buffcount == 0) then
		background:Hide();
		background:SetHeight(.5);
		background:SetWidth(.5);
		return;
	elseif (not DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.hide) then
		background:Show();
	else
		return;
	end
	local size = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.size;
	local hspacing = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.hspacing;
	local vspacing = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.vspacing;
	local height, width;
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.tworows) then
		local row2start = math.ceil(DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.shown / 2);
		local rows = 1;
		if (buffcount > row2start) then
			buffcount = row2start;
			rows = 2;
		end
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.vertical) then
			height = size * buffcount + vspacing * (buffcount - 1);
			width = size * rows + hspacing * (rows - 1);
		else
			width = size * buffcount + hspacing * (buffcount - 1);
			height = size * rows + vspacing * (rows - 1);
		end
	else
		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.vertical) then
			height = size * buffcount + vspacing * (buffcount - 1);
			width = size;
		else
			width = size * buffcount + hspacing * (buffcount - 1);
			height = size;
		end
	end
	background:SetWidth(width);
	background:SetHeight(height);
	background = getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs_Background");
	background:SetWidth(width + DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.bgpadding * 2);
	background:SetHeight(height + DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs.bgpadding * 2);
end

function DUF_UnitPopup_OnLoad()
	local unit = "player";
	local frame = this:GetName();
	if (string.find(frame, "PartyFrame")) then
		unit = "party";
	elseif (string.find(frame, "PetFrame")) then
		unit = "pet";
	elseif (string.find(frame, "TargetFrame")) then
		unit = "target";
	end
	UIDropDownMenu_Initialize(this, getglobal("DUF_UnitPopup_"..unit.."_Initialize"), "MENU");
end

function DUF_UnitPopup_party_Initialize()
	local dropdown;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	UnitPopup_ShowMenu(dropdown, "PARTY", dropdown:GetParent().unit);
end

function DUF_UnitPopup_pet_Initialize()
	if ( UnitExists("pet") ) then
		UnitPopup_ShowMenu(DUF_PetFrame_DropDown, "PET", "pet");
	end
end

function DUF_UnitPopup_player_Initialize()
	UnitPopup_ShowMenu(DUF_PlayerFrame_DropDown, "SELF", "player");
end

function DUF_UnitPopup_target_Initialize()
	local menu;
	local name;
	if ( UnitExists("target") and UnitReaction("player", "target") and (((UnitReaction("player", "target") >= 4 and not UnitIsPlayer("target")) and not UnitIsUnit("player", "target")) or (UnitReaction("player", "target") < 4  and not UnitIsPlayer("target"))) ) then
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	elseif ( UnitIsUnit("target", "player") ) then
		menu = "SELF";
	elseif ( UnitIsUnit("target", "pet") ) then
		menu = "PET";
	elseif ( UnitIsPlayer("target") ) then
		if ( UnitInParty("target") ) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if ( menu ) then
		UnitPopup_ShowMenu(DUF_TargetFrame_DropDown, menu, "target");
	end
end

function DUF_UnitPopup_ShowMenu(unit)
	if (unit == "targettarget" or string.find(unit, "partypet")) then return; end
	local popup = getglobal(DUF_FRAME_DATA[unit].frame.."_DropDown");
	DUF_ToggleDropDownMenu(1, nil, popup, "cursor", 0, 0);
end

-- Ugly piece of work to stop TitanPanel from throwing an error.
function DUF_ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	if ( not level ) then
		level = 1;
	end
	UIDROPDOWNMENU_MENU_LEVEL = level;
	UIDROPDOWNMENU_MENU_VALUE = value;
	local listFrame = getglobal("DropDownList"..level);
	local listFrameName = "DropDownList"..level;
	local tempFrame;
	local point, relativePoint, relativeTo;
	if ( not dropDownFrame ) then
		tempFrame = this:GetParent();
	else
		tempFrame = dropDownFrame;
	end
	if ( listFrame:IsVisible() and (UIDROPDOWNMENU_OPEN_MENU == tempFrame:GetName()) ) then
		listFrame:Hide();
	else
		-- Set the dropdownframe scale
		local uiScale = 1.0;
		if ( GetCVar("useUiScale") == "1" ) then
			if ( tempFrame ~= WorldMapContinentDropDown and tempFrame ~= WorldMapZoneDropDown ) then
				uiScale = tonumber(GetCVar("uiscale"));
			end
		end
		listFrame:SetScale(uiScale);
		
		-- Hide the listframe anyways since it is redrawn OnShow() 
		listFrame:Hide();
		
		-- Frame to anchor the dropdown menu to
		local anchorFrame;

		-- Display stuff
		-- Level specific stuff
		if ( level == 1 ) then
			if ( not dropDownFrame ) then
				dropDownFrame = this:GetParent();
			end
			UIDROPDOWNMENU_OPEN_MENU = dropDownFrame:GetName();
			listFrame:ClearAllPoints();
			-- If there's no specified anchorName then use left side of the dropdown menu
			if ( not anchorName ) then
				-- See if the anchor was set manually using setanchor
				if ( dropDownFrame.xOffset ) then
					xOffset = dropDownFrame.xOffset;
				end
				if ( dropDownFrame.yOffset ) then
					yOffset = dropDownFrame.yOffset;
				end
				if ( dropDownFrame.point ) then
					point = dropDownFrame.point;
				end
				if ( dropDownFrame.relativeTo ) then
					relativeTo = dropDownFrame.relativeTo;
				else
					relativeTo = UIDROPDOWNMENU_OPEN_MENU.."Left";
				end
				if ( dropDownFrame.relativePoint ) then
					relativePoint = dropDownFrame.relativePoint;
				end
			elseif ( anchorName == "cursor" ) then
				relativeTo = "UIParent";
				local cursorX, cursorY = GetCursorPosition();
				cursorX = cursorX/uiScale;
				cursorY =  cursorY/uiScale;

				if ( not xOffset ) then
					xOffset = 0;
				end
				if ( not yOffset ) then
					yOffset = 0;
				end
				xOffset = cursorX + xOffset;
				yOffset = cursorY + yOffset;
			else
				relativeTo = anchorName;
			end
			if ( not xOffset or not yOffset ) then
				xOffset = 8;
				yOffset = 22;
			end
			if ( not point ) then
				point = "TOPLEFT";
			end
			if ( not relativePoint ) then
				relativePoint = "BOTTOMLEFT";
			end
			listFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset);
		else
			if ( not dropDownFrame ) then
				dropDownFrame = getglobal(UIDROPDOWNMENU_OPEN_MENU);
			end
			listFrame:ClearAllPoints();
			-- If this is a dropdown button, not the arrow anchor it to itself
			if ( strsub(this:GetParent():GetName(), 0,12) == "DropDownList" and strlen(this:GetParent():GetName()) == 13 ) then
				anchorFrame = this:GetName();
			else
				anchorFrame = this:GetParent():GetName();
			end
			listFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 0, 0);
		end
		
		-- Change list box appearance depending on display mode
		if ( dropDownFrame and dropDownFrame.displayMode == "MENU" ) then
			getglobal(listFrameName.."Backdrop"):Hide();
			getglobal(listFrameName.."MenuBackdrop"):Show();
		else
			getglobal(listFrameName.."Backdrop"):Show();
			getglobal(listFrameName.."MenuBackdrop"):Hide();
		end

		UIDropDownMenu_Initialize(dropDownFrame, dropDownFrame.initialize, nil, level);
		-- If no items in the drop down don't show it
		if ( listFrame.numButtons == 0 ) then
			return;
		end

		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		listFrame:Show();
		-- Hack since GetCenter() is returning coords relative to 1024x768
		local x, y = listFrame:GetCenter();
		-- Hack will fix this in next revision of dropdowns
		if ( not x or not y ) then
			listFrame:Hide();
			return;
		end
		-- Determine whether the menu is off the screen or not
		local offscreenY, offscreenX;
		if ( (y - listFrame:GetHeight()/2) < 0 ) then
			offscreenY = 1;
		end
		if ( listFrame:GetRight() > GetScreenWidth() ) then
			offscreenX = 1;	
		end
		
		--  If level 1 can only go off the bottom of the screen
		if ( level == 1 ) then
			if ( offscreenY and offscreenX ) then
				anchorPoint = "BOTTOMRIGHT";
				relativePoint = "BOTTOMLEFT";
			elseif ( offscreenY ) then
				anchorPoint = "BOTTOMLEFT";
				relativePoint = "TOPLEFT";
			elseif ( offscreenX ) then
				anchorPoint = "TOPRIGHT";
				relativePoint = "TOPLEFT";
			else
				anchorPoint = "TOPLEFT";
			end
			
			listFrame:ClearAllPoints();
			if ( anchorName == "cursor" ) then
				listFrame:SetPoint(anchorPoint, relativeTo, "BOTTOMLEFT", xOffset, yOffset);
			else
				listFrame:SetPoint(anchorPoint, relativeTo, relativePoint, xOffset, yOffset);
			end
		else
			local anchorPoint, relativePoint, offsetX, offsetY;
			if ( offscreenY and offscreenX ) then
				anchorPoint = "BOTTOMRIGHT";
				relativePoint = "BOTTOMLEFT";
				offsetX = -11;
				offsetY = -14;
			elseif ( offscreenY ) then
				anchorPoint = "BOTTOMLEFT";
				relativePoint = "BOTTOMRIGHT";
				offsetX = 0;
				offsetY = -14;
			elseif ( offscreenX ) then
				anchorPoint = "TOPRIGHT";
				relativePoint = "TOPLEFT";
				offsetX = -11;
				offsetY = 14;
			else
				anchorPoint = "TOPLEFT";
				relativePoint = "TOPRIGHT";
				offsetX = 0;
				offsetY = 14;
			end
			
			listFrame:ClearAllPoints();
			listFrame:SetPoint(anchorPoint, anchorFrame, relativePoint, offsetX, offsetY);
		end
	end
end
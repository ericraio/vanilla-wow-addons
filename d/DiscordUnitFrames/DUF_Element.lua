function DUF_Element_OnClick(button)
	if (this.moving) then
		DUF_Element_OnDragStop();
	end

	local unit = this.unit;
	if (not unit) then
		unit = this:GetParent().unit;
	end

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
		if (this.subindex) then
			action = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].leftclick;
		else
			action = DUF_Settings[DUF_INDEX][frameindex][this.index].leftclick;
		end
	elseif (button == "RightButton") then
		if (this.subindex) then
			action = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].rightclick;
		else
			action = DUF_Settings[DUF_INDEX][frameindex][this.index].rightclick;
		end
	elseif (button == "MiddleButton") then
		if (this.subindex) then
			action = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].middleclick;
		else
			action = DUF_Settings[DUF_INDEX][frameindex][this.index].middleclick;
		end
	end
	if (action == 1) then
		TargetUnit(unit);
	elseif (action == 2) then
		AssistUnit(unit);
	elseif (action == 3) then
		DUF_UnitPopup_ShowMenu(unit);
	end
end

function DUF_Element_OnDragStart()
	if (DUF_ELEMENTS_UNLOCKED) then
		this.moving = true;
		if (this.moveparent) then
			this:GetParent():StartMoving();
		else
			this:StartMoving();
		end
	elseif (DUF_FRAMES_UNLOCKED) then
		if (this.moveparent) then
			this:GetParent():GetParent():StartMoving();
		else
			this:GetParent():StartMoving();
		end
	end
end

function DUF_Element_GetOffsets(element, baseframe, settings)
	if (settings.attach ~= "Unit Frame" and settings.attach ~= "UIParent") then
		baseframe = getglobal(baseframe:GetName()..settings.attach);
	elseif (settings.attach == "UIParent") then
		baseframe = UIParent;
	end
	local xoffset, yoffset = DL_Get_Offsets(element, baseframe, settings.attachpoint, settings.attachto)
	return xoffset, yoffset;
end

function DUF_Element_OnDragStop()
	if (DUF_ELEMENTS_UNLOCKED) then
		this.moving = nil;
		if (this.moveparent) then
			this:GetParent():StopMovingOrSizing();
		else
			this:StopMovingOrSizing();
		end
		local frameindex, unitframe, xoffset, yoffset, settings;
		if (this.moveparent) then
			frameindex = DUF_FRAME_DATA[this:GetParent():GetParent().unit].index;
			if (this:GetParent().subindex) then
				settings = DUF_Settings[DUF_INDEX][frameindex][this:GetParent().index][this:GetParent().subindex];
			else
				settings = DUF_Settings[DUF_INDEX][frameindex][this:GetParent().index];
			end
			unitframe = getglobal(this:GetParent():GetParent():GetName());
			xoffset, yoffset = DUF_Element_GetOffsets(this:GetParent(), unitframe, settings);
		else
			frameindex = DUF_FRAME_DATA[this:GetParent().unit].index;
			if (this.subindex) then
				settings = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex];
			else
				settings = DUF_Settings[DUF_INDEX][frameindex][this.index];
			end
			unitframe = getglobal(this:GetParent():GetName());
			xoffset, yoffset = DUF_Element_GetOffsets(this, unitframe, settings);
		end
		if (this.subindex) then
			DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].xoffset = xoffset;
			DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].yoffset = yoffset;
		elseif (this.moveparent) then
			DUF_Settings[DUF_INDEX][frameindex][this:GetParent().index].xoffset = xoffset;
			DUF_Settings[DUF_INDEX][frameindex][this:GetParent().index].yoffset = yoffset;
		else
			DUF_Settings[DUF_INDEX][frameindex][this.index].xoffset = xoffset;
			DUF_Settings[DUF_INDEX][frameindex][this.index].yoffset = yoffset;
		end
		if (this.moveparent) then
			local settings = DUF_Settings[DUF_INDEX][frameindex][this:GetParent().index];
			local element = DUF_Get_ElementName(this:GetParent().index, this:GetParent().subindex);
			if (frameindex == "party" or frameindex == "partypet") then
				for i=1,4 do
					local unitFrame = DUF_FRAME_DATA[frameindex..i].frame;
					DUF_Set_ElementPosition(getglobal(unitFrame..element), unitFrame, settings);
				end
			else
				local unitFrame = DUF_FRAME_DATA[frameindex].frame;
				DUF_Set_ElementPosition(getglobal(unitFrame..element), unitFrame, settings);
			end
		else
			local settings;
			if (this.subindex) then
				settings = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex];
			else
				settings = DUF_Settings[DUF_INDEX][frameindex][this.index];
			end
			local element = DUF_Get_ElementName(this.index, this.subindex);
			if (frameindex == "party" or frameindex == "partypet") then
				for i=1,4 do
					local unitFrame = DUF_FRAME_DATA[frameindex..i].frame;
					DUF_Set_ElementPosition(getglobal(unitFrame..element), unitFrame, settings);
				end
			else
				local unitFrame = DUF_FRAME_DATA[frameindex].frame;
				DUF_Set_ElementPosition(getglobal(unitFrame..element), unitFrame, settings);
			end
		end
		if (DUF_Options) then
			DUF_Init_BaseOptions();
		end
	elseif (DUF_FRAMES_UNLOCKED) then
		if (this.moveparent) then
			this = this:GetParent():GetParent();
		else
			this = this:GetParent();
		end
		DUF_UnitFrame_OnDragStop();
	end
end

function DUF_Element_OnEnter()
	local unit = this:GetParent().unit;
	local settings;
	if (this.subindex) then
		settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index][this.index][this.subindex];
	else
		settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index][this.index];
	end

	if (settings.usemouseovercolor) then
		getglobal(this:GetName().."_Background"):SetBackdropColor(settings.mouseovercolor.r, settings.mouseovercolor.g, settings.mouseovercolor.b, settings.bgalpha);
	end

	if (settings.mouseovergroup) then
		local unitFrame = this:GetParent();
		local unitFrameName = unitFrame:GetName();
		local element;

		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].mouseovergroup == settings.mouseovergroup) then
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].usemouseovercolor) then
				getglobal(this:GetParent():GetName().."_Background"):SetBackdropColor(DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].mouseovercolor.r, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].mouseovercolor.g, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].mouseovercolor.b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].bgalpha);
			end
		end

		for index, value in DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index] do
			if (type(value) == "table") then
				if (index == "StatusBar") then
					for i = 1,6 do
						if (value[i]) then
							if (value[i].mouseovergroup == settings.mouseovergroup) then
								if (value[i].mouseover) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Show();
								elseif (value[i].hidemouseover) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i)):SetAlpha(0);
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
							elseif (value[i].hidemouseover) then
								getglobal(unitFrameName..DUF_Get_ElementName(index, i)):SetAlpha(0);
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
						elseif (value.hidemouseover) then
							getglobal(unitFrameName..DUF_Get_ElementName(index, i)):SetAlpha(0);
						end
						if (value.usemouseovercolor) then
							getglobal(unitFrameName..DUF_Get_ElementName(index).."_Background"):SetBackdropColor(value.mouseovercolor.r, value.mouseovercolor.g, value.mouseovercolor.b, value.bgalpha);
						end
					end
				end
			end
		end
	end

	if (settings.hidemouseover) then
		this.oldalpha = this:GetAlpha();
		this:SetAlpha(0);
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
			this.unit = unit;
			UnitFrame_OnEnter();
		end
	end
end

function DUF_Element_OnEvent(event)
	
end

function DUF_Element_OnHide()
	if (this.moving) then
		DUF_Element_OnDragStop();
	end
end

function DUF_Element_OnLeave()
	if (this:GetParent().unit and UnitName(this:GetParent().unit)) then
		this.unit = this:GetParent().unit;
		UnitFrame_OnLeave();
	end

	if (this.moving) then
		DUF_Element_OnDragStop();
	end

	local unit = this:GetParent().unit;

	local settings;
	if (this.subindex) then
		settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index][this.index][this.subindex];
	else
		settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index][this.index];
	end

	if (this.oldalpha) then
		this:SetAlpha(this.oldalpha);
		this.oldalpha = nil;
	end

	if (settings.usemouseovercolor) then
		getglobal(this:GetName().."_Background"):SetBackdropColor(settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	end

	if (settings.mouseovergroup) then
		local unitFrame = this:GetParent();
		local unitFrameName = unitFrame:GetName();
		local element;

		if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].mouseovergroup == settings.mouseovergroup) then
			if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].usemouseovercolor) then
				getglobal(this:GetParent():GetName().."_Background"):SetBackdropColor(DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].bgcolor.r, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].bgcolor.g, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].bgcolor.b, DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].bgalpha);
			end
		end

		for index, value in DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index] do
			if (type(value) == "table") then
				if (index == "StatusBar") then
					for i = 1,6 do
						if (value[i]) then
							if (value[i].mouseovergroup == settings.mouseovergroup) then
								if (value[i].mouseover) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i)):Hide();
								elseif (value[i].hidemouseover) then
									getglobal(unitFrameName..DUF_Get_ElementName(index, i)):SetAlpha(value[i].alpha);
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
							elseif (value[i].hidemouseover) then
								getglobal(unitFrameName..DUF_Get_ElementName(index, i)):SetAlpha(value[i].alpha);
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
						elseif (value.hidemouseover) then
							getglobal(unitFrameName..DUF_Get_ElementName(index, i)):SetAlpha(value.alpha);
						end
						if (value.usemouseovercolor) then
							getglobal(unitFrameName..DUF_Get_ElementName(index).."_Background"):SetBackdropColor(value.bgcolor.r, value.bgcolor.g, value.bgcolor.b, value.bgalpha);
						end
					end
				end
			end
		end
	end
end

function DUF_Element_OnLoad()
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
	if (string.find(this:GetName(), "Bar")) then
		this.index = "StatusBar";
		this.subindex = this:GetID();
	elseif (string.find(this:GetName(), "Portrait")) then
		this.index = "Portrait";
	elseif (string.find(this:GetName(), "ClassIcon")) then
		this.index = "ClassIcon";
	elseif (string.find(this:GetName(), "RankIcon")) then
		this.index = "RankIcon";
	elseif (string.find(this:GetName(), "RaceIcon")) then
		this.index = "RaceIcon";
	elseif (string.find(this:GetName(), "Buffs")) then
		this.index = "Buffs";
	elseif (string.find(this:GetName(), "Debuffs")) then
		this.index = "Debuffs";
	elseif (string.find(this:GetName(), "LootIcon")) then
		this.index = "LootIcon";
	elseif (string.find(this:GetName(), "PVPIcon")) then
		this.index = "PVPIcon";
	elseif (string.find(this:GetName(), "LeaderIcon")) then
		this.index = "LeaderIcon";
	elseif (string.find(this:GetName(), "StatusIcon")) then
		this.index = "StatusIcon";
	elseif (string.find(this:GetName(), "TextBox")) then
		this.index = "TextBox";
		this.subindex = this:GetID();
	elseif (string.find(this:GetName(), "HappinessIcon")) then
		this.index = "HappinessIcon";
	elseif (string.find(this:GetName(), "ComboPoints")) then
		this.index = "ComboPoints";
	elseif (string.find(this:GetName(), "EliteTexture")) then
		this.index = "EliteTexture";
	end
	this.baseframelevel = this:GetFrameLevel();
end

function DUF_Element_OnShow()
	if (not DUF_INITIALIZED) then return; end
	local unit = this:GetParent().unit;
	local frameindex = DUF_FRAME_DATA[unit].index;
	if (string.find(this:GetName(), "TargetHealthBar") or string.find(this:GetName(), "TargetManaBar") or this.checkname) then
		unit = unit.."target";
	end
	local color, bgcolor, bordercolor;
	local context, bgcontext, bordercontext, bgstyle;

	if (this.subindex) then
		context = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].context;
		bgcontext = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bgcontext;
		bordercontext = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bordercontext;
	else
		context = DUF_Settings[DUF_INDEX][frameindex][this.index].context;
		bgcontext = DUF_Settings[DUF_INDEX][frameindex][this.index].bgcontext;
		bordercontext = DUF_Settings[DUF_INDEX][frameindex][this.index].bordercontext;
	end

	if ((not context) and (not bgcontext) and (not bordercontext)) then return; end

	if (this.subindex) then
		bgcolor = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bgcolor;
		bordercolor = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bordercolor;
		bgalpha = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bgalpha;
		borderalpha = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].borderalpha;
	else
		bgcolor = DUF_Settings[DUF_INDEX][frameindex][this.index].bgcolor;
		bordercolor = DUF_Settings[DUF_INDEX][frameindex][this.index].bordercolor;
		bgalpha = DUF_Settings[DUF_INDEX][frameindex][this.index].bgalpha;
		borderalpha = DUF_Settings[DUF_INDEX][frameindex][this.index].borderalpha;
	end

	local background = getglobal(this:GetName().."_Background");

	if (this.index == "StatusBar") then
		if (this.subindex == 2 or this.subindex == 5) then
			color = this.manacolor;
		else
			color = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].color;
		end
	elseif (this.index == "TextBox") then
		color = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].textcolor;
	else
		color = bgcolor;
	end
	
	local r, g, b;
	if (context and context < 4) then
		if (context == 1) then
			r, g ,b = DUF_Get_DifficultyColor(unit, color);
		elseif (context == 2) then
			r, g ,b = DUF_Get_ReactionColor(unit, color);
		elseif (context == 3) then
			r, g ,b = DUF_Get_ClassColor(unit, color);
		end
		DUF_Element_SetColor(r, g, b, bgstyle, bgalpha);
	end
	if (bgcontext and bgcontext < 4) then
		if (bgcontext == 1) then
			r, g ,b = DUF_Get_DifficultyColor(unit, bgcolor);
		elseif (bgcontext == 2) then
			r, g ,b = DUF_Get_ReactionColor(unit, bgcolor);
		elseif (bgcontext == 3) then
			r, g ,b = DUF_Get_ClassColor(unit, bgcolor);
		end
		background:SetBackdropColor(r, g, b, bgalpha);
	end
	if (bordercontext and bordercontext < 4) then
		if (bordercontext == 1) then
			r, g ,b = DUF_Get_DifficultyColor(unit, color);
		elseif (bordercontext == 2) then
			r, g ,b = DUF_Get_ReactionColor(unit, color);
		elseif (bordercontext == 3) then
			r, g ,b = DUF_Get_ClassColor(unit, color);
		end
		background:SetBackdropBorderColor(r, g, b, borderalpha);
	end
end

function DUF_Element_OnUpdate(elapsed)
	if (not DUF_INITIALIZED) then return; end

	if (not this.timer) then this.timer = DUF_Settings[DUF_INDEX].updatespeed; end
	if (not this.index) then return; end

	if (this.flashing) then
		this.flashtime = this.flashtime - elapsed;
		if (this.flashtime < 0) then
			this.flashtime = .5;
			if (this.direction) then
				this.direction = nil;
			else
				this.direction = 1;
			end
		end
		if (this.direction) then
			this:SetAlpha(1 - this.flashtime);
		else
			this:SetAlpha(this.flashtime + .5);
		end
	end

	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = DUF_Settings[DUF_INDEX].updatespeed;
		if (this.index == "TextBox") then
			this.update = true;
		end
		local unit = this:GetParent().unit;
		local frameindex = DUF_FRAME_DATA[unit].index;
		if (string.find(this:GetName(), "TargetHealthBar") or string.find(this:GetName(), "TargetManaBar") or this.checkname) then
			unit = unit.."target";
		end
	
		local context, bgcontext, bordercontext, flash, targetIcon;
		if (this.subindex) then
			context = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].context;
			bgcontext = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bgcontext;
			bordercontext = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bordercontext;
			flash = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].flashlowhealth;
		else
			context = DUF_Settings[DUF_INDEX][frameindex][this.index].context;
			bgcontext = DUF_Settings[DUF_INDEX][frameindex][this.index].bgcontext;
			bordercontext = DUF_Settings[DUF_INDEX][frameindex][this.index].bordercontext;
			flash = DUF_Settings[DUF_INDEX][frameindex][this.index].flashlowhealth;
		end

		if (flash) then
			if (UnitHealth(unit) and UnitHealthMax(unit)) then
				if (UnitHealth(unit) / UnitHealthMax(unit) <= DUF_Settings[DUF_INDEX].flashthreshold and UnitHealth(unit) > 0) then
					if (not this.flashing) then
						this.flashing = true;
						this.direction = 1;
						this.flashtime = .5;
					end
				else
					this.flashing = nil;
					if (this.subindex) then
						this:SetAlpha(DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].alpha);
					else
						this:SetAlpha(DUF_Settings[DUF_INDEX][frameindex][this.index].alpha);
					end
				end
			end
		end

		if ((not context) and (not bgcontext) and (not bordercontext)) then return; end

		local color, bgcolor, bordercolor;
		if (this.subindex) then
			bgcolor = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bgcolor;
			bordercolor = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bordercolor;
			bgstyle = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].backgroundstyle;
			bgalpha = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].bgalpha;
			borderalpha = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].borderalpha;
		else
			bgcolor = DUF_Settings[DUF_INDEX][frameindex][this.index].bgcolor;
			bordercolor = DUF_Settings[DUF_INDEX][frameindex][this.index].bordercolor;
			bgstyle = DUF_Settings[DUF_INDEX][frameindex][this.index].backgroundstyle;
			bgalpha = DUF_Settings[DUF_INDEX][frameindex][this.index].bgalpha;
			borderalpha = DUF_Settings[DUF_INDEX][frameindex][this.index].borderalpha;
		end

		if (this.index == "StatusBar") then
			if (this.subindex == 2 or this.subindex == 5) then
				color = this.manacolor;
			else
				color = DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].color;
			end
		elseif (this.index == "TextBox") then
			color =  DUF_Settings[DUF_INDEX][frameindex][this.index][this.subindex].textcolor;
		else
			color = bgcolor;
		end
		local r, g, b;
		if (context == 4 or bgcontext == 4 or bordercontext == 4) then
			local health = UnitHealth(unit);
			local healthmax = UnitHealthMax(unit);
			if (this.health ~= health or this.healthmax ~= this.healthmax) then
				this.health = health;
				this.healthmax = healthmax;
				if (context == 4) then
					r, g, b = DUF_Get_HealthColor(unit, color);
					DUF_Element_SetColor(r, g, b, bgstyle, bgalpha);
				end
				if (bgcontext == 4) then
					r, g, b = DUF_Get_HealthColor(unit, bgcolor);
					getglobal(this:GetName().."_Background"):SetBackdropColor(r, g, b, bgalpha);
				end
				if (bordercontext == 4) then
					r, g, b = DUF_Get_HealthColor(unit, bordercolor);
					getglobal(this:GetName().."_Background"):SetBackdropBorderColor(r, g, b, borderalpha);
				end
			end
		end
		if (context == 5 or bgcontext == 5 or bordercontext == 5) then
			local mana = UnitMana(unit);
			local manamax = UnitManaMax(unit);
			if (this.mana ~= mana or this.manamax ~= this.manamax) then
				this.mana = mana;
				this.manamax = manamax;
				if (context == 5) then
					if (not color) then return; end
					r, g, b = DUF_Get_ManaColor(unit, color);
					DUF_Element_SetColor(r, g, b, bgstyle, bgalpha);
				end
				if (bgcontext == 5) then
					r, g, b = DUF_Get_ManaColor(unit, bgcolor);
					getglobal(this:GetName().."_Background"):SetBackdropColor(r, g, b, bgalpha);
				end
				if (bordercontext == 5) then
					r, g, b = DUF_Get_ManaColor(unit, bordercolor);
					getglobal(this:GetName().."_Background"):SetBackdropBorderColor(r, g, b, borderalpha);
				end
			end
		end
		if (context == 2 or bgcontext == 2 or bordercontext == 2) then
			local reaction = DUF_Get_Reaction(unit);
			if (this.reaction ~= reaction) then
				this.reaction = reaction;
				if (context == 2) then
					if (not color) then return; end
					r, g, b = DUF_Get_ReactionColor(unit, color);
					DUF_Element_SetColor(r, g, b, bgstyle, bgalpha);
				end
				if (bgcontext == 2) then
					r, g, b = DUF_Get_ReactionColor(unit, bgcolor);
					getglobal(this:GetName().."_Background"):SetBackdropColor(r, g, b, bgalpha);
				end
				if (bordercontext == 2) then
					r, g, b = DUF_Get_ReactionColor(unit, bordercolor);
					getglobal(this:GetName().."_Background"):SetBackdropBorderColor(r, g, b, borderalpha);
				end
			end
		end
	end
end

function DUF_Element_SetColor(r, g, b, bgstyle, alpha)
	if (this.index == "StatusBar") then
		getglobal(this:GetName().."_Bar"):SetVertexColor(r, g, b);
	elseif (this.index == "TextBox") then
		getglobal(this:GetName().."_Text"):SetTextColor(r, g, b);
	else
		getglobal(this:GetName().."_Background"):SetBackdropColor(r, g, b, alpha);
	end
end
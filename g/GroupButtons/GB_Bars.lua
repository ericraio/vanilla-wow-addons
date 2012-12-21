function GB_Bar_OnEvent(event)
	if (not GB_INITIALIZED) then return; end
	local hidden = GB_Settings[GB_INDEX][this.index].hide;
	if (not hidden) then
		hidden = GB_Settings[GB_INDEX][this.index].mouseover;
	end
	if (event == "PARTY_MEMBERS_CHANGED") then
		local numParty = GetNumPartyMembers();
		if (this.index == "lowesthealth") then
			if (numParty > 0) then
				this.noshow = false;
				if (not hidden) then this:Show(); end
			else
				this.noshow = true;
				this:Hide();
			end
		elseif (not hidden) then
			local partyBar, petBar;
			for i=1,4 do
				partyBar = getglobal(GB_Get_UnitBar("party"..i));
				petBar = getglobal(GB_Get_UnitBar("partypet"..i));
				partyBar.noshow = true;
				petBar.noshow = true;
				partyBar:Hide();
				petBar:Hide();
			end
			if (GB_Settings[GB_INDEX].hideInRaid and GetNumRaidMembers() > 0) then
				return;
			end
			for i=1,numParty do
				partyBar = getglobal(GB_Get_UnitBar("party"..i));
				partyBar.noshow = false;
				partyBar:Show();
				if (UnitName("partypet"..i) and UnitExists("partypet"..i) and (not GB_Settings[GB_INDEX].partypet.hide)) then
					petBar = getglobal(GB_Get_UnitBar("partypet"..i));
					petBar.noshow = false;
					petBar:Show();
				end
			end
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		this.noshow = true;
		if (UnitName("target")) then
			if (UnitCanAttack("player", "target")) then
				if (this.index == "hostiletarget" and UnitHealth("target") > 0) then
					this.noshow = false
				end
			else
				if (UnitIsPlayer("target") and UnitFactionGroup("target") ~= UnitFactionGroup("player")) then
					if (this.index == "hostiletarget" and UnitHealth("target") > 0) then
						this.noshow = false;
					end
				else
					if (this.index == "friendlytarget") then
						this.noshow = false;
					end
				end
			end
		end
		if (this.noshow) then
			this:Hide();
		else
			if (not hidden) then this:Show(); end
		end
	elseif (event == "RAID_ROSTER_UPDATE") then
		this.noshow = true;
		if (UnitExists(this.unit) and GB_RAID_MEMBERS[UnitName(this.unit)]) then
			this.noshow = false;
		end
		if (this.noshow) then
			this:Hide();
		else
			if (not hidden) then this:Show(); end
		end
	elseif (event == "UNIT_PET") then
		if (GB_Settings[GB_INDEX].hideInRaid and GetNumRaidMembers() > 0) then
			hidden = true;
		end
		this.noshow = true;
		if (UnitExists(this.unit)) then
			this.noshow = false;
		end
		if (this.noshow) then
			this:Hide();
		else
			if (not hidden) then this:Show(); end
		end
	end
end

function GB_Bar_OnUpdate()
	if (this.index == "friendlytarget" and GB_INITIALIZED) then
		if (UnitCanAttack("player", "target")) then
			this.noshow = true;
			this:Hide();
			if (not GB_Settings[GB_INDEX]["hostiletarget"].hide) then
				GB_HostileTargetBar.noshow = false;
				GB_HostileTargetBar:Show();
			end
		end
	end
	if (this.timer) then
		this.timer = this.timer - arg1;
		if (this.timer < 0) then
			this.timer = nil;
			this:Hide();
		end
	end
end

function GB_Bars_Raise()
	for index in GB_UNITS_ARRAY do
		for _, unitBar in GB_UNITS_ARRAY[index].frames do
			getglobal(unitBar):Raise();
		end
	end
end

function GB_Initialize_AllBars()
	for index in GB_UNITS_ARRAY do
		if (index ~= "lowesthealth") then
			for _, unitBar in GB_UNITS_ARRAY[index].frames do
				GB_Update_Auras(getglobal(unitBar).unit);
			end
		end
		for i=1, GB_UNITS_ARRAY[index].buttons do
			GB_ActionButton_Initialize(index, i);
		end
		GB_Set_Appearance(index);
	end
end

function GB_Labels_Hide()
	for unit, value in GB_UNITS_ARRAY do
		for index in value.frames do
			getglobal(value.frames[index].."_Label"):Hide();
		end
	end
end

function GB_Labels_Show()
	for unit, value in GB_UNITS_ARRAY do
		for index in value.frames do
			getglobal(value.frames[index].."_Label"):Show();
		end
	end
end

function GB_Set_Appearance(bar)
	local settings = GB_Get(bar);
	for _, unitBar in GB_UNITS_ARRAY[bar].frames do
		getglobal(unitBar):SetAlpha(settings.alpha);
		if (settings.hide or getglobal(unitBar).noshow or settings.mouseover) then
			getglobal(unitBar):Hide();
		elseif (GB_Settings[GB_INDEX].hideInRaid and GetNumRaidMembers() > 0 and string.find(bar, "party")) then
			getglobal(unitBar):Hide();
		else
			getglobal(unitBar):Show();
		end
		if (settings.attach and bar ~= "lowesthealth") then
			getglobal(unitBar):ClearAllPoints();
			if (unitBar == "GB_PetBar0") then
				local unitFrame = GB_UNITFRAMES.pet.frames[1];
				getglobal(unitBar):SetPoint(settings.attachPoint, unitFrame, settings.attachTo, settings.xoffset, settings.yoffset);
			elseif (bar == "raid") then
				if (CT_RAMember1) then
					local unitFrame = "CT_RAMember"..getglobal(unitBar):GetID();
					getglobal(unitBar):SetPoint(settings.attachPoint, unitFrame, settings.attachTo, settings.xoffset, settings.yoffset);
				elseif (beyondRaidGroup1) then
					GB_SHUFFLE_RAID = true;
					local found;
					for i=1, 8 do
						for j = 1, 5 do
							local raidframe = "beyondRaidGroup"..i.."Member"..j;
							if (getglobal(raidframe).unitID == "raid"..getglobal(unitBar):GetID()) then
								found = true;
								getglobal(raidframe):RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
								getglobal(unitBar):SetPoint(settings.attachPoint, raidframe, settings.attachTo, settings.xoffset, settings.yoffset);
								break;
							end
						end
					end
					if (not found) then
						getglobal(unitBar):SetPoint(settings.attachPoint, "beyondRaidGroup1Member1", settings.attachTo, settings.xoffset, settings.yoffset);
					end
				elseif (MRConfigPanel) then
					GB_SHUFFLE_RAID = true;
					local found;
					for i=1, 100 do
						local raidframe = "MRF"..i;
						if (getglobal(raidframe).unit == "raid"..getglobal(unitBar):GetID()) then
							found = true;
							getglobal(raidframe):RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
							getglobal(unitBar):SetPoint(settings.attachPoint, raidframe, settings.attachTo, settings.xoffset, settings.yoffset);
							break;
						end
					end
					if (not found) then
						getglobal(unitBar):SetPoint(settings.attachPoint, "MRF1", settings.attachTo, settings.xoffset, settings.yoffset);
					end
				else
					GB_SHUFFLE_RAID = true;
					if (RaidPullout1Button1) then
						local found;
						for i = 1, 12 do
							for j = 1, 15 do
								local raidframe = "RaidPullout"..i.."Button"..j;
								if (getglobal(raidframe).unit == "raid"..getglobal(unitBar):GetID()) then
									found = true;
									getglobal(unitBar):SetPoint(settings.attachPoint, raidframe, settings.attachTo, settings.xoffset, settings.yoffset);
									break;
								end
							end
						end
						if (not found) then
							getglobal(unitBar):SetPoint(settings.attachPoint, "RaidPullout1Button1", settings.attachTo, settings.xoffset, settings.yoffset);
						end
					end
				end
			else
				local id = getglobal(unitBar):GetID();
				if (id == 0) then id = 1; end
				local bar2 = bar;
				if (string.find(bar, "target")) then bar2 = "target"; end
				local unitFrame = GB_UNITFRAMES[bar2].frames[id];
				getglobal(unitBar):SetPoint(settings.attachPoint, unitFrame, settings.attachTo, settings.xoffset, settings.yoffset);
			end
		end
		local button, cooldown, modelscale, textscale;
		for i=1, GB_UNITS_ARRAY[bar].buttons do
			button = getglobal(unitBar.."_Button_"..i);
			cooldown = getglobal(button:GetName().."_Cooldown");
			if (GB_Settings[GB_INDEX].modifybyUIscale) then
				modelscale = settings.buttonSize / 36 * UIParent:GetScale();
			else
				modelscale = settings.buttonSize / 36;
			end
			textscale = settings.buttonSize / 36;
			getglobal(button:GetName().."TextFrame").textscale = textscale;
			getglobal(button:GetName().."TextFrame"):SetScale(textscale);
			button:SetHeight(settings.buttonSize);
			button:SetWidth(settings.buttonSize);
			cooldown:SetScale(modelscale);
			cooldown.scale = modelscale;
		end
		if (GB_Options:IsVisible()) then
			getglobal(unitBar):Show();
		end
		GB_Set_Layout(bar, unitBar, 1);
	end
end

function GB_Set_Layout(bar, unitBar, override)
	if (not GB_INITIALIZED) then return; end
	local rows = GB_Settings[GB_INDEX][bar].rows;
	local buttonSize = GB_Settings[GB_INDEX][bar].buttonSize;
	local spacing = GB_Settings[GB_INDEX][bar].spacing;
	local frameheight = rows * buttonSize;
	local framewidth;
	if (not override) then
		if (rows == 1 and (not GB_Settings[GB_INDEX][bar].collapse)) then
			framewidth = GB_UNITS_ARRAY[bar].buttons * buttonSize;
			getglobal(unitBar):SetHeight(frameheight);
			getglobal(unitBar):SetWidth(framewidth);
			return;
		end
	end
	local count = 0;
	local row = 0;
	local visiblecount = 0;
	local highest = 0;
	local prevrowstart = nil;
	local newrow = math.ceil(GB_UNITS_ARRAY[bar].buttons / rows);
	local resetrow = math.mod(GB_UNITS_ARRAY[bar].buttons, rows);
	local lastbutton = unitBar;
	for i=1, GB_UNITS_ARRAY[bar].buttons do
		local button = getglobal(unitBar.."_Button_"..i);
		button:ClearAllPoints();
		if (count == newrow) then
			local attachto = unitBar.."_Button_"..(i - count);
			button:SetPoint("TOP", attachto, "BOTTOM", 0, -spacing);
			if (button:IsVisible() or (not GB_Settings[GB_INDEX][bar].collapse)) then
				lastbutton = button:GetName();
			else
				prevrowstart = attachto;
			end
			count = 0;
			row = row + 1;
			if (visiblecount > highest) then
				highest = visiblecount;
			end
			visiblecount = 0;
			if (button:IsVisible()) then
				visiblecount = 1;
			end
			if (row == resetrow) then
				newrow = newrow - 1;
			end
		else
			if (lastbutton == unitBar) then
				button:SetPoint("TOPLEFT", lastbutton, "TOPLEFT", 0, 0);
			elseif (prevrowstart) then
				button:SetPoint("TOP", prevrowstart, "BOTTOM", 0, -spacing);
				if (button:IsVisible()) then
					lastbutton = button:GetName();
					prevrowstart = nil;
				end
			else
				button:SetPoint("LEFT", lastbutton, "RIGHT", spacing, 0);
			end
			if (button:IsVisible() or (not GB_Settings[GB_INDEX][bar].collapse)) then
				visiblecount = visiblecount + 1;
				lastbutton = button:GetName();
			end
		end
		count = count + 1;
	end
	if (highest == 0) then highest = visiblecount; end
	framewidth = highest * buttonSize;
	getglobal(unitBar):SetHeight(frameheight);
	getglobal(unitBar):SetWidth(framewidth);
end
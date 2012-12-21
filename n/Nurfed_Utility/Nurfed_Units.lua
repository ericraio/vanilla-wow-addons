
if (not Nurfed_Units) then

	local framelib = Nurfed_Frames:New();

	Nurfed_Units = {};

	Nurfed_Units.class = {
		DRUID = { right = 0.75, left = 1, top = 0, bottom = 0.25, color = "|cffff8a00" },
		HUNTER = { right = 0, left = 0.25, top = 0.25, bottom = 0.5, color = "|cff00ff00" },
		MAGE = { right = 0.25, left = 0.5, top = 0, bottom = 0.25, color = "|cff00ffff" },
		PALADIN = { right = 0, left = 0.25, top = 0.5, bottom = 0.75, color = "|cffff71a8" },
		PRIEST = { right = 0.5, left = 0.75, top = 0.25, bottom = 0.5, color = "|cffffffff" },
		ROGUE = { right = 0.5, left = 0.75, top = 0, bottom = 0.25, color = "|cffffff00" },
		SHAMAN = { right = 0.25, left = 0.5, top = 0.25, bottom = 0.5, color = "|cffff71a8" },
		WARLOCK = { right = 0.75, left = 1, top = 0.25, bottom = 0.5, color = "|cff8d54fb" },
		WARRIOR = { right = 0, left = 0.25, top = 0, bottom = 0.25, color = "|cffb39442" },
	};

	Nurfed_Units.classification = {
		["worldboss"] = BOSS,
		["rareelite"] = ITEM_QUALITY3_DESC.."-"..ELITE,
		["rare"] = ITEM_QUALITY3_DESC,
		["elite"] = ELITE,
	};

	Nurfed_Units.unitlist = {};
	
	function Nurfed_Units:New ()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_Units:UpdateUnits()
		local i;
		self.unitlist = nil;
		self.unitlist = {};
		if (GetNumPartyMembers() > 0) then
			for i = 1, GetNumPartyMembers() do
				self.unitlist[UnitName("party"..i)] = { t = "Party", c = UnitClass("party"..i) };
			end
		end
		if (GetNumRaidMembers() > 0) then
			for i = 1, GetNumRaidMembers() do
				local name, rank, subgroup, _, class, _, _, _, _ = GetRaidRosterInfo(i);
				if (name and rank and subgroup and class) then
					if (self.unitlist[name]) then
						self.unitlist[name].g = subgroup;
						self.unitlist[name].r = rank;
					else
						self.unitlist[name] = { t = "Raid", c = class, g = subgroup, r = rank };
					end
				end
			end
		end
	end

	function Nurfed_Units:GetUnit(name)
		if (self.unitlist[name]) then
			return self.unitlist[name];
		end
		return nil;
	end

	function Nurfed_Units:GetHealth(unit)
		local currhp, maxhp = UnitHealth(unit), UnitHealthMax(unit);
		if (maxhp == 100 and (IsAddOnLoaded("MobHealth") or IsAddOnLoaded			("MobInfo2")) and unit == "target") then
			local check = MobHealth_GetTargetMaxHP();
			if (check and check > 0) then
				maxhp = check;
				currhp = MobHealth_GetTargetCurHP();
			else
				currhp = UnitHealth(unit);
			end
		else
			currhp = UnitHealth(unit);
		end
		if (not UnitIsConnected(unit)) then
			currhp = 0;
		end
		local perc = currhp/maxhp;
		local color = {};
		if(perc > 0.5) then
			color.r = (1.0 - perc) * 2;
			color.g = 1.0;
		else
			color.r = 1.0;
			color.g = perc * 2;
		end
		color.b = 0.0;
		perc = format("%.0f", floor(perc * 100));
		return currhp, maxhp, perc, color;
	end

	function Nurfed_Units:GetMana(unit)
		local currmp, maxmp = UnitMana(unit), UnitManaMax(unit);
		if (not UnitIsConnected(unit)) then
			currmp = 0;
		end
		local perc = format("%.0f", (currmp / maxmp) * 100);
		return currmp, maxmp, perc;
	end

	function Nurfed_Units:GetXP(unit)
		if (not UnitExists(unit)) then
			return 0, 0, 0;
		end
		local name, reaction, min, max, value = GetWatchedFactionInfo();
		local currxp, maxxp, perc;
		if (name) then
			currxp = value - min;
			maxxp = max - min;
		else
			currxp = UnitXP(unit);
			maxxp = UnitXPMax(unit);
		end
		local perc = format("%.0f", (currxp / maxxp) * 100);
		return currxp, maxxp, perc;
	end

	function Nurfed_Units:GetReaction(unit)
		local info = {};
		if (UnitPlayerControlled(unit)) then
			if (UnitCanAttack(unit, "player")) then
				-- Hostile players are red
				if (not UnitCanAttack("player", unit)) then
					info.r = 0.0;
					info.g = 0.0;
					info.b = 1.0;
				else
					info.r = UnitReactionColor[2].r;
					info.g = UnitReactionColor[2].g;
					info.b = UnitReactionColor[2].b;
				end
			elseif (UnitCanAttack("player", unit)) then
				-- Players we can attack but which are not hostile are yellow
				info.r = UnitReactionColor[4].r;
				info.g = UnitReactionColor[4].g;
				info.b = UnitReactionColor[4].b;
			elseif (UnitIsPVP(unit)) then
				-- Players we can assist but are PvP flagged are green
				info.r = UnitReactionColor[6].r;
				info.g = UnitReactionColor[6].g;
				info.b = UnitReactionColor[6].b;
			else
				-- All other players are blue (the usual state on the "blue" server)
				info.r = 0.0;
				info.g = 1.0;
				info.b = 1.0;
			end
		elseif (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
			info.r = 0.5;
			info.g = 0.5;
			info.b = 0.5;
		else
			local reaction = UnitReaction(unit, "player");
			if (reaction) then
				info.r = UnitReactionColor[reaction].r;
				info.g = UnitReactionColor[reaction].g;
				info.b = UnitReactionColor[reaction].b;
			else
				info.r = 0.0;
				info.g = 1.0;
				info.b = 1.0;
			end
		end
		return info;
	end

	function Nurfed_Units:StatusBarUpdate(arg1)
		if (this.fade < 1) then
			this.fade = this.fade + arg1;
			if this.fade > 1 then
				this.fade = 1;
			end
			local delta = this.endvalue - this.startvalue;
			local diff = delta * (this.fade / 1);
			this.startvalue = this.startvalue + diff;
			this:SetValue(this.startvalue);
		end
	end

	function Nurfed_Units:Fade(arg1)
		this.update = this.update + arg1;
		if (this.update > 0.04) then
			this.update = 0;
			local now = GetTime();
			local frame, texture, p;
			if (now - this.flashtime > 0.3) then
				this.flashdct = this.flashdct * (-1);
				this.flashtime = now;
			end

			if (this.flashdct == 1) then
				p = (1 - (now - this.flashtime + 0.001) / 0.3 * 0.7);
			else
				p = ( (now - this.flashtime + 0.001) / 0.3 * 0.7 + 0.3);
			end
			this:SetAlpha(p);
		end
	end

	local tbl = {
		type = "Frame",
		OnEvent = function() Nurfed_Units:UpdateUnits() end,
		events = {
			"PLAYER_ENTERING_WORLD",
			"PARTY_MEMBERS_CHANGED",
			"RAID_ROSTER_UPDATE",
		},
	};

	framelib:ObjectInit("Nurfed_UnitsFrame", tbl, UIParent);
	tbl = nil;
end

function Nurfed_RaidFrameDropDown_Initialize()
	UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "RAID", this.unit, this.name, this.id);
end

function Nurfed_Unit_OnClick(arg1)
	local name, dropdown;
	if (SpellIsTargeting() and arg1 == "RightButton") then
		SpellStopTargeting();
		return;
	end
	if (arg1 == "LeftButton") then
		if (SpellIsTargeting() and  SpellCanTargetUnit(this.unit)) then
			SpellTargetUnit(this.unit);
		elseif (CursorHasItem()) then
			if (this.unit == "player") then
				AutoEquipCursorItem();
			else
				DropItemOnUnit(this.unit);
			end
		else
			TargetUnit(this.unit);
		end
	else
		if (string.find(this.unit, "party[1-4]")) then
			name = "PartyMemberFrame"..this:GetID();
			dropdown = getglobal(name.."DropDown");
		elseif (string.find(this.unit, "^raid")) then
			FriendsDropDown.initialize = Nurfed_RaidFrameDropDown_Initialize;
			FriendsDropDown.displayMode = "MENU";
			dropdown = FriendsDropDown;
		else
			name = string.gsub(this.unit, "^%l", string.upper);
			dropdown = getglobal(name.."FrameDropDown");
		end
		if (dropdown) then
			ToggleDropDownMenu(1, nil, dropdown, "cursor");
		end
		return;
	end
end

function Nurfed_SetAuraTooltip()
	if (not this:IsVisible()) then return; end
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	local unit = this:GetParent().unit;
	if (this.isdebuff) then
		GameTooltip:SetUnitDebuff(unit, this.id);
	else
		GameTooltip:SetUnitBuff(unit, this.id);
	end
end
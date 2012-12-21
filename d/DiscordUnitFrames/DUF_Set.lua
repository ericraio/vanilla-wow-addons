function DUF_Set_BackgroundPadding(frame, padding)
	getglobal(frame.."_Background"):ClearAllPoints();
	getglobal(frame.."_Background"):SetPoint("TOPLEFT", frame, "TOPLEFT", -padding, padding);
	getglobal(frame.."_Background"):SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", padding, -padding);
end

function DUF_Set_ClassIcon(unit)
	local class = UnitClass(unit);
	local texture = getglobal(DUF_FRAME_DATA[unit].frame.."_ClassIcon_Texture");
	local left, right, top, bottom;
	if (class == DUF_TEXT.Warrior) then
		left, right, top, bottom = .25, 0, 0, .25;
	elseif (class == DUF_TEXT.Mage) then
		left, right, top, bottom = .5, .25, 0, .25;
	elseif (class == DUF_TEXT.Rogue) then
		left, right, top, bottom = .75, .5, 0, .25;
	elseif (class == DUF_TEXT.Druid) then
		left, right, top, bottom = 1, .75, 0, .25;
	elseif (class == DUF_TEXT.Hunter) then
		left, right, top, bottom = .25, 0, .25, .5;
	elseif (class == DUF_TEXT.Shaman) then
		left, right, top, bottom = .5, .25, .25, .5;
	elseif (class == DUF_TEXT.Priest) then
		left, right, top, bottom = .75, .5, .25, .5;
	elseif (class == DUF_TEXT.Warlock) then
		left, right, top, bottom = 1, .75, .25, .5;
	elseif (class == DUF_TEXT.Paladin) then
		left, right, top, bottom = .25, 0, .5, .75;
	end
	if (class) then
		texture:SetTexCoord(right, left, top, bottom);	
	else
		texture:SetTexCoord(0, .25, 0, .25);
	end
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].ClassIcon.userace) then
		if (UnitIsPlayer(unit)) then
			texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
		else
			DUF_Set_RaceIcon(unit, 1);
		end
	end
end

function DUF_Set_ElementPosition(frame, unitFrame, settings)
	local attachframe = unitFrame..settings.attach;
	if (settings.attach == "Unit Frame") then
		attachframe = unitFrame;
	elseif (settings.attach == "UIParent") then
		attachframe = "UIParent";
	end
	frame:ClearAllPoints();
	frame:SetPoint(settings.attachpoint, attachframe, settings.attachto, settings.xoffset, settings.yoffset);
end

function DUF_Set_EliteTexture()
	local texture;
	if (DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture and DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture ~= "") then
		texture = "Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture;
	elseif (DUF_Settings[DUF_INDEX].target.EliteTexture.faceleft) then
		texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\EliteLeft";
	else
		texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\Elite";
	end
	if (DUF_OPTIONS_VISIBLE and (not DUF_Settings[DUF_INDEX].target.EliteTexture.hide)) then
		DUF_TargetFrame_EliteTexture_Texture:SetTexture(texture);
		DUF_TargetFrame_EliteTexture:Show();
		return;
	end
	local classification = UnitClassification("target");
	if (classification == "elite" or classification == "worldboss") then
		if (not DUF_Settings[DUF_INDEX].target.EliteTexture.hide) then
			DUF_TargetFrame_EliteTexture_Texture:SetTexture(texture);
			DUF_TargetFrame_EliteTexture:Show();
		end
	elseif (classification == "rare" or classification == "rareelite") then
		if (not DUF_Settings[DUF_INDEX].target.EliteTexture.hide) then
			if (DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture and DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture ~= "") then
				texture = "Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture;
			elseif (DUF_Settings[DUF_INDEX].target.EliteTexture.faceleft) then
				texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\RareLeft";
			else
				texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\Rare";
			end
			DUF_TargetFrame_EliteTexture_Texture:SetTexture(texture);
			DUF_TargetFrame_EliteTexture:Show();
		end
	else
		DUF_TargetFrame_EliteTexture:Hide();
	end
end

function DUF_Set_Portrait(unit)
	local texture = getglobal(DUF_FRAME_DATA[unit].frame.."_Portrait_Texture");
	texture:SetTexCoord(0, 1, 0, 1);
	if (UnitName(unit)) then
		SetPortraitTexture(texture, unit);
	else
		SetPortraitTexture(texture, "player");
		return;
	end

	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Portrait.useclass and UnitIsPlayer(unit)) then
		local class = UnitClass(unit);
		local left, right, top, bottom;
		if (class == DUF_TEXT.Warrior) then
			left, right, top, bottom = .25, 0, 0, .25;
		elseif (class == DUF_TEXT.Mage) then
			left, right, top, bottom = .5, .25, 0, .25;
		elseif (class == DUF_TEXT.Rogue) then
			left, right, top, bottom = .75, .5, 0, .25;
		elseif (class == DUF_TEXT.Druid) then
			left, right, top, bottom = 1, .75, 0, .25;
		elseif (class == DUF_TEXT.Hunter) then
			left, right, top, bottom = .25, 0, .25, .5;
		elseif (class == DUF_TEXT.Shaman) then
			left, right, top, bottom = .5, .25, .25, .5;
		elseif (class == DUF_TEXT.Priest) then
			left, right, top, bottom = .75, .5, .25, .5;
		elseif (class == DUF_TEXT.Warlock) then
			left, right, top, bottom = 1, .75, .25, .5;
		elseif (class == DUF_TEXT.Paladin) then
			left, right, top, bottom = .25, 0, .5, .75;
		end
		if (class) then
			texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
			texture:SetTexCoord(right, left, top, bottom);	
		end
	end
end

function DUF_Set_RaceIcon(unit, toggle)
	local race = UnitRace(unit);
	local sex = UnitSex(unit);
	local ctype = UnitCreatureType(unit);
	local faction = UnitFactionGroup(unit);
	local texture = getglobal(DUF_FRAME_DATA[unit].frame.."_RaceIcon_Texture");
	if (texture.targetIcon) then
		local targetIndex
		if (unit == "target" or unit == "targettarget") then
			targetIndex = GetRaidTargetIndex(unit)
		else
			targetIndex = GetRaidTargetIndex(unit.."target")
		end
		if (targetIndex) then
			SetRaidTargetIconTexture(texture, targetIndex)
		end
		return
	end
	if (toggle) then
		texture = getglobal(DUF_FRAME_DATA[unit].frame.."_ClassIcon_Texture");
	end
	if (not UnitName(unit)) then
		race=DUF_TEXT.Human;
		sex=1;
	end
	texture:Show();
	if (UnitIsCivilian(unit)) then
		texture:SetTexCoord(0, 1, 0, 1);
		texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Civilian")
	elseif (race and sex) then
		texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races");
		if (sex == 2) then
			if (race == DUF_TEXT.Human) then texture:SetTexCoord(0, 0.25, 0, 0.25); end
			if (race == DUF_TEXT.Dwarf) then texture:SetTexCoord(0.25, 0.5, 0, 0.25); end
			if (race == DUF_TEXT.Gnome) then texture:SetTexCoord(0.5, 0.75, 0, 0.25); end
			if (race == DUF_TEXT.NightElf) then texture:SetTexCoord(0.75, 1.0, 0, 0.25); end
			if (race == DUF_TEXT.Tauren) then texture:SetTexCoord(0, 0.25, 0.25, 0.5); end
			if (race == DUF_TEXT.Undead) then texture:SetTexCoord(0.25, 0.5, 0.25, 0.5); end
			if (race == DUF_TEXT.Troll) then texture:SetTexCoord(0.5, 0.75, 0.25, 0.5); end
			if (race == DUF_TEXT.Orc) then texture:SetTexCoord(0.75, 1.0, 0.25, 0.5); end
		else
			if (race == DUF_TEXT.Human) then texture:SetTexCoord(0, 0.25, 0.5, 0.75); end
			if (race == DUF_TEXT.Dwarf) then texture:SetTexCoord(0.25, 0.5, 0.5, 0.75); end
			if (race == DUF_TEXT.Gnome) then texture:SetTexCoord(0.5, 0.75, 0.5, 0.75); end
			if (race == DUF_TEXT.NightElf) then texture:SetTexCoord(0.75, 1.0, 0.5, 0.75); end
			if (race == DUF_TEXT.Tauren) then texture:SetTexCoord(0, 0.25, 0.75, 1.0); end
			if (race == DUF_TEXT.Undead) then texture:SetTexCoord(0.25, 0.5, 0.75, 1.0); end
			if (race == DUF_TEXT.Troll) then texture:SetTexCoord(0.5, 0.75, 0.75, 1.0); end
			if (race == DUF_TEXT.Orc) then texture:SetTexCoord(0.75, 1.0, 0.75, 1.0); end
		end
	elseif (UnitPlayerControlled(unit)) then
		texture:SetTexCoord(0, 1, 0, 1);
		texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Sheep")
	elseif (ctype) then
		texture:SetTexCoord(0, 1, 0, 1);
		if (ctype == DUF_TEXT.Beast) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Beast")
		elseif (ctype == DUF_TEXT.Dragonkin) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Dragonkin")
		elseif (ctype == DUF_TEXT.Critter) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Critter")
		elseif (ctype == DUF_TEXT.Demon) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Demon")
		elseif (ctype == DUF_TEXT.Elemental) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Elemental")
		elseif (ctype == DUF_TEXT.Giant) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Giant")
		elseif (ctype == DUF_TEXT.Humanoid) then
			if (faction == DUF_TEXT.Horde) then
				texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Horde")
			elseif (faction == DUF_TEXT.Alliance) then
				texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Alliance")
			else
				texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Humanoid")
			end
		elseif (ctype == DUF_TEXT.NotSpecified) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\NotSpecified")
		elseif (ctype == DUF_TEXT.Summoned) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Summoned")
		elseif (ctype == DUF_TEXT.Undead) then texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Undead")
		else texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Gryphon")
		end
	else
		texture:SetTexCoord(0, 1, 0, 1);
		texture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\Icons\\Unknown")
	end
end

function DUF_Set_RankIcon(unit)
	local _, rankNumber = GetPVPRankInfo(UnitPVPRank(unit));
	local texture = getglobal(DUF_FRAME_DATA[unit].frame.."_RankIcon_Texture");
	if (texture.targetIcon) then
		local targetIndex
		if (unit == "target" or unit == "targettarget") then
			targetIndex = GetRaidTargetIndex(unit)
		else
			targetIndex = GetRaidTargetIndex(unit.."target")
		end
		if (targetIndex) then
			SetRaidTargetIconTexture(texture, targetIndex)
		end
		return
	end
	if (not UnitName(unit)) then
		rankNumber=9;
	elseif (not UnitIsPlayer(unit)) then
		texture:Hide();
		return;
	end
	if (rankNumber > 0) then
		texture:Show();
		texture:SetTexture(format("%s%02d","Interface\\PvPRankBadges\\PvPRank",rankNumber));
	else
		texture:Hide();
	end
end
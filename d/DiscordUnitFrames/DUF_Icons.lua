function DUF_HappinessIcon_OnEnter()
	if ( this.tooltip ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(this.tooltip);
		if ( this.tooltipDamage ) then
			GameTooltip:AddLine(this.tooltipDamage, "", 1, 1, 1);
		end
		if ( this.tooltipLoyalty ) then
			GameTooltip:AddLine(this.tooltipLoyalty, "", 1, 1, 1);
		end
		GameTooltip:Show();
	end
end

function DUF_HappinessIcon_Update()
	if (not DUF_INITIALIZED) then return; end
	local happiness, damagePercentage, loyaltyRate = GetPetHappiness();
	if (not UnitName("pet")) then
		happiness = 1;
		damagePercentage = 1.25;
		loyaltyRate = 1;
	elseif ( (not happiness) or DUF_Settings[DUF_INDEX].pet.HappinessIcon.hide) then
		DUF_PetFrame_HappinessIcon:Hide();
		return;	
	end
	DUF_PetFrame_HappinessIcon:Show();
	if ( happiness == 1 ) then
		DUF_PetFrame_HappinessIcon_Texture:SetTexCoord(0.375, 0.5625, 0, 0.359375);
	elseif ( happiness == 2 ) then
		DUF_PetFrame_HappinessIcon_Texture:SetTexCoord(0.1875, 0.375, 0, 0.359375);
	elseif ( happiness == 3 ) then
		DUF_PetFrame_HappinessIcon_Texture:SetTexCoord(0, 0.1875, 0, 0.359375);
	end
	DUF_PetFrame_HappinessIcon.tooltip = getglobal("PET_HAPPINESS"..happiness);
	DUF_PetFrame_HappinessIcon.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage);
	if ( loyaltyRate < 0 ) then
		DUF_PetFrame_HappinessIcon.tooltipLoyalty = getglobal("LOSING_LOYALTY");
	elseif ( loyaltyRate > 0 ) then
		DUF_PetFrame_HappinessIcon.tooltipLoyalty = getglobal("GAINING_LOYALTY");
	else
		DUF_PetFrame_HappinessIcon.tooltipLoyalty = nil;
	end
end

function DUF_LeaderIcon_Update(unit)
	if (not DUF_INITIALIZED) then return; end
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].LeaderIcon.hide) then return; end
	local icon = getglobal(DUF_FRAME_DATA[unit].frame.."_LeaderIcon_Texture");
	local inParty = GetNumPartyMembers() + GetNumRaidMembers();
	if (DUF_OPTIONS_VISIBLE) then
		icon:Show();
	elseif (UnitIsPartyLeader(unit) and inParty > 0) then
		icon:Show();
	else
		icon:Hide();
	end
end

function DUF_LootIcon_Update(unit)
	if (not DUF_INITIALIZED) then return; end
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].LootIcon.hide) then return; end
	local icon = getglobal(DUF_FRAME_DATA[unit].frame.."_LootIcon_Texture");
	if (DUF_OPTIONS_VISIBLE) then
		icon:Show();
		return;
	end
	icon:Hide();
	if (unit == "target") then return; end

	local looterNum;
	if (unit == "player") then
		looterNum = 0;
	elseif (unit == "party1") then
		looterNum = 1;
	elseif (unit == "party2") then
		looterNum = 2;
	elseif (unit == "party3") then
		looterNum = 3;
	elseif (unit == "party4") then
		looterNum = 4;
	end

	local _, lootMaster = GetLootMethod();
	local inParty = GetNumPartyMembers() + GetNumRaidMembers();
	if ( lootMaster == looterNum and (inParty > 0) ) then
		icon:Show();
	end
end

function DUF_PVPIcon_Update(unit)
	if (not DUF_INITIALIZED) then return; end
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].PVPIcon.hide) then return; end
	local icon = getglobal(DUF_FRAME_DATA[unit].frame.."_PVPIcon_Texture");
	icon:Show();
	local factionGroup = UnitFactionGroup(unit);
	if ( UnitIsPVPFreeForAll(unit) ) then
		icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
	elseif ( factionGroup and UnitIsPVP(unit)) then
		icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
	elseif (DUF_OPTIONS_VISIBLE) then
			factionGroup = UnitFactionGroup("player");
			icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
			return;
	else
		icon:Hide();
	end
end

function DUF_StatusIcon_Update(unit)
	if (not DUF_INITIALIZED) then return; end
	if (DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].StatusIcon.hide) then return; end
	local icon = getglobal(DUF_FRAME_DATA[unit].frame.."_StatusIcon_Texture");
	icon:Show();
	if (DUF_OPTIONS_VISIBLE) then
		icon:SetTexCoord(.5625, .9, .08, .4375);
		icon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
	elseif (not UnitIsConnected(unit)) then
		icon:SetTexture("Interface\\CharacterFrame\\Disconnect-Icon");
		icon:SetTexCoord(0, 1, 0, 1);
	elseif (UnitHealth(unit) <= 0 or UnitIsGhost(unit)) then
		icon:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Skull");
		icon:SetTexCoord(0, 1, 0, 1);
	elseif (unit == "player" and DL_ATTACKING) then
		icon:SetTexCoord(.5625, .9, .08, .4375);
		icon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
	elseif (unit == "player" and DL_INCOMBAT) then
		icon:SetTexCoord(.5625, .9, .08, .4375);
		icon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
	elseif (UnitAffectingCombat(unit)) then
		icon:SetTexCoord(.5625, .9, .08, .4375);
		icon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
	elseif (unit == "player" and IsResting()) then
		icon:SetTexCoord(.0625, .4375, .0625, .4375);
		icon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
	else
		icon:Hide();
	end
end
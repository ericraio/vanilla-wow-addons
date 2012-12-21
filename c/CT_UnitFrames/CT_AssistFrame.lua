if ( CT_AddMovable ) then
	CT_AddMovable("CT_AssistFrame", CT_ASSISTFRAME_MOVABLE, "TOPLEFT", "TOPLEFT", "UIParent", 480, -25, function(status)
		if ( status ) then
			CT_AssistFrame_Drag:Show();
		else
			CT_AssistFrame_Drag:Hide();
		end
	end);
end

function CT_AssistFrame_OnLoad()
	this.statusCounter = 0;
	this.statusSign = -1;
	this.unitHPPercent = 1;
	this.update = 1;
	CT_AssistFrame_Update();
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
end

function CT_AssistFrame_OnUpdate(elapsed)
	this.update = this.update - elapsed;
	if ( this.update <= 0 ) then
		this.update = 1;
		if ( this == CT_AssistFrame ) then
			CT_AssistFrame_Update();
		elseif ( UnitExists("targettarget") and CT_UnitFramesOptions.shallDisplayAssist ) then
			CT_AssistFrame:Show();
		end
	end
end

function CT_AssistFrame_ShallDisplay(offset)
	return CT_UnitFramesOptions.styles[4][offset][1];
end

function CT_AssistFrame_GetHealth(id)
	if ( not UnitExists("target") or not UnitExists("player") or not UnitExists("targettarget") ) then
		return "";
	end
	if ( CT_AssistFrame_CheckDead() ) then
		return "";
	end
	if ( UnitHealthMax("targettarget") == 100 ) then
		id = 2;
	end
	if ( id == 2 ) then
		return floor(( UnitHealth("targettarget") or 1 ) / ( UnitHealthMax("targettarget") or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitHealth("targettarget") or 1 ) - ( UnitHealthMax("targettarget") or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitHealth("targettarget") or "?" ) .. "/" .. ( UnitHealthMax("targettarget") or "?" );
	end
end

function CT_AssistFrame_GetMana(id)
	if ( not UnitExists("target") or not UnitExists("player") or not UnitExists("targettarget") ) then
		return "";
	end
	if ( UnitPowerType("targettarget") > 0 or UnitManaMax("targettarget") == 0 or ( UnitIsDead("targettarget") and UnitIsConnected("targettarget") ) ) then
		return "";
	end
	if ( id == 2 ) then
		return floor(( UnitMana("targettarget") or 1 ) / ( UnitManaMax("targettarget") or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitMana("targettarget") or 1 ) - ( UnitManaMax("targettarget") or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitMana("targettarget") or "?" ) .. "/" .. ( UnitManaMax("targettarget") or "?" );
	end
end

function CT_ShowAssistHealth()
	if ( not UnitExists("target") or not UnitExists("player") or not UnitExists("targettarget") ) then
		return "";
	end
	local typeOnHealth = CT_AssistFrame_ShallDisplay(1);
	if ( typeOnHealth > 1 ) then
		CT_AssistHealthBar:Show();
		CT_AssistHealthBar:SetText(CT_AssistFrame_GetHealth(typeOnHealth));
	else
		CT_AssistHealthBar:Hide();
	end
	CT_AssistHealthBar:SetTextColor(CT_UnitFramesOptions.styles[4][1][2], CT_UnitFramesOptions.styles[4][1][3], CT_UnitFramesOptions.styles[4][1][4], CT_UnitFramesOptions.styles[4][1][5]);
	local hp = ( UnitHealth("targettarget") or 1 ) / ( UnitHealthMax("targettarget") or 1 );
	local r, g = 1, 1;
	if ( hp > 0.5 ) then
		r = (1.0 - hp) * 2;
		g = 1.0;
	else
		r = 1.0;
		g = hp * 2;
	end
	if ( r < 0 ) then r = 0; elseif ( r > 1 ) then r = 1; end
	if ( g < 0 ) then g = 0; elseif ( g > 1 ) then g = 1; end
	CT_AssistFrameHealthBar:SetStatusBarColor(r, g, 0);
end

function CT_ShowAssistMana()
	if ( not UnitExists("target") or not UnitExists("player") or not UnitExists("targettarget") ) then
		return "";
	end
	local typeOnMana = CT_AssistFrame_ShallDisplay(2);
	if ( typeOnMana > 1 ) then
		CT_AssistManaBar:SetText(CT_AssistFrame_GetMana(typeOnMana));
		CT_AssistManaBar:Show();
	else
		CT_AssistManaBar:Hide();
	end
	CT_AssistManaBar:SetTextColor(CT_UnitFramesOptions.styles[4][2][2], CT_UnitFramesOptions.styles[4][2][3], CT_UnitFramesOptions.styles[4][2][4], CT_UnitFramesOptions.styles[4][2][5]);
end

function CT_AssistFrame_Update()
	if ( UnitExists("player") and UnitExists("targettarget") and not UnitIsUnit("target", "player") and CT_UnitFramesOptions.shallDisplayAssist ) then
		CT_ShowAssistHealth();
		CT_ShowAssistMana();
		this:Show();
		UnitFrame_Update();
		CT_AssistFrame_CheckLevel();
		CT_AssistFrame_CheckFaction();
		CT_AssistFrame_CheckClassification();
		CT_AssistFrame_CheckDishonorableKill();
		if ( UnitIsPartyLeader("targettarget") ) then
			CT_AssistLeaderIcon:Show();
		else
			CT_AssistLeaderIcon:Hide();
		end
		CT_AssistDebuffButton_Update();
		CT_AssistPortrait:SetAlpha(1.0);
		
		local hp = CT_AssistFrame.unitHPPercent;
		if ( hp ) then
			if ( hp > 0 ) then
				if ( hp > 0.5 ) then
					r = (1.0 - hp) * 2;
					g = 1.0;
				else
					r = 1.0;
					g = hp * 2;
				end
			else
				r = 0; g = 1;
			end
		else
			r = 0; g = 1;
		end
		CT_AssistFrameHealthBar:SetStatusBarColor(r, g, 0);
	else
		this:Hide();
	end
end

function CT_AssistFrame_OnEvent(event)
	UnitFrame_OnEvent(event);

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		CT_AssistFrame_Update();
	end
end

function CT_AssistFrame_OnShow()
	CT_AssistFrame_Update();
end

function CT_AssistFrame_OnHide()
end

function CT_AssistFrame_CheckLevel()
	local targetLevel = UnitLevel("targettarget");
	
	if ( UnitIsCorpse("targettarget") ) then
		CT_AssistLevelText:Hide();
		CT_AssistHighLevelTexture:Show();
	elseif ( targetLevel > 0 ) then
		-- Normal level target
		CT_AssistLevelText:SetText(targetLevel);
		-- Color level number
		if ( UnitCanAttack("player", "targettarget") ) then
			local color = GetDifficultyColor(targetLevel);
			CT_AssistLevelText:SetVertexColor(color.r, color.g, color.b);
		else
			CT_AssistLevelText:SetVertexColor(1.0, 0.82, 0.0);
		end
		CT_AssistLevelText:Show();
		CT_AssistHighLevelTexture:Hide();
	else
		-- Target is too high level to tell
		CT_AssistLevelText:Hide();
		CT_AssistHighLevelTexture:Show();
	end
end

function CT_AssistFrame_CheckFaction()
	if ( UnitPlayerControlled("targettarget") ) then
		local r, g, b;
		if ( UnitCanAttack("targettarget", "player") ) then
			-- Hostile players are red
			if ( not UnitCanAttack("player", "targettarget") ) then
				r = 0.0;
				g = 0.0;
				b = 1.0;
			else
				r = UnitReactionColor[2].r;
				g = UnitReactionColor[2].g;
				b = UnitReactionColor[2].b;
			end
		elseif ( UnitCanAttack("player", "targettarget") ) then
			-- Players we can attack but which are not hostile are yellow
			r = UnitReactionColor[4].r;
			g = UnitReactionColor[4].g;
			b = UnitReactionColor[4].b;
		elseif ( UnitIsPVP("targettarget") ) then
			-- Players we can assist but are PvP flagged are green
			r = UnitReactionColor[6].r;
			g = UnitReactionColor[6].g;
			b = UnitReactionColor[6].b;
		else
			-- All other players are blue (the usual state on the "blue" server)
			r = 0.0;
			g = 0.0;
			b = 1.0;
		end
		CT_AssistFrameNameBackground:SetVertexColor(r, g, b);
		CT_AssistPortrait:SetVertexColor(1.0, 1.0, 1.0);
	elseif ( UnitIsTapped("targettarget") and not UnitIsTappedByPlayer("targettarget") ) then
		CT_AssistFrameNameBackground:SetVertexColor(0.5, 0.5, 0.5);
		CT_AssistPortrait:SetVertexColor(0.5, 0.5, 0.5);
	else
		local reaction = UnitReaction("targettarget", "player");
		if ( reaction ) then
			local r, g, b;
			r = UnitReactionColor[reaction].r;
			g = UnitReactionColor[reaction].g;
			b = UnitReactionColor[reaction].b;
			CT_AssistFrameNameBackground:SetVertexColor(r, g, b);
		else
			CT_AssistFrameNameBackground:SetVertexColor(0, 0, 1.0);
		end
		CT_AssistPortrait:SetVertexColor(1.0, 1.0, 1.0);
	end

	local factionGroup = UnitFactionGroup("targettarget");
	if ( UnitIsPVPFreeForAll("targettarget") ) then
		CT_AssistPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		CT_AssistPVPIcon:Show();
	elseif ( factionGroup and UnitIsPVP("targettarget") ) then
		CT_AssistPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		CT_AssistPVPIcon:Show();
	else
		CT_AssistPVPIcon:Hide();
	end
end

function CT_AssistFrame_CheckClassification()
	local classification = UnitClassification("targettarget");
	if ( classification == "worldboss" ) then
		CT_AssistFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
	elseif ( classification == "rareelite"  ) then
		CT_AssistFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
	elseif ( classification == "elite"  ) then
		CT_AssistFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
	elseif ( classification == "rare"  ) then
		CT_AssistFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
	else
		CT_AssistFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
	end
end

function CT_AssistFrame_CheckDead()
	if ( UnitHealth("targettarget") <= 0 and UnitIsConnected("targettarget") ) then
		CT_AssistDeadText:Show();
		return true;
	else
		CT_AssistDeadText:Hide();
		return false;
	end
end

function CT_AssistFrame_CheckDishonorableKill()
	if ( UnitIsCivilian("targettarget") ) then
		-- Is a dishonorable kill
		this.name:SetText(RED_FONT_COLOR_CODE..PVP_RANK_CIVILIAN..FONT_COLOR_CODE_CLOSE);
		CT_AssistFrameNameBackground:SetVertexColor(0.36, 0.05, 0.05);
		CT_AssistFrameNameBackground:SetVertexColor(1.0, 1.0, 1.0);
	end
end

function CT_AssistFrame_OnClick(button)
	if ( SpellIsTargeting() and button == "RightButton" ) then
		SpellStopTargeting();
		return;
	end
	if ( button == "LeftButton" ) then
		if ( SpellIsTargeting() ) then
			SpellTargetUnit("targettarget");
		elseif ( CursorHasItem() ) then
			DropItemOnUnit("targettarget");
		else
			TargetUnit("targettarget");
		end
	else
		ToggleDropDownMenu(1, nil, CT_AssistFrameDropDown, "CT_AssistFrame", 120, 10);
	end
end

function CT_AssistDebuffButton_Update()
	local debuff, debuffApplications, debuffType, debuffButton, buff, buffButton, button, color;
	local numBuffs = 0;
	for i=1, MAX_TARGET_BUFFS do
		buff = UnitBuff("targettarget", i);
		button = getglobal("CT_AssistFrameBuff"..i);
		if ( buff ) then
			getglobal("CT_AssistFrameBuff"..i.."Icon"):SetTexture(buff);
			button:Show();
			button.id = i;
			numBuffs = numBuffs + 1;
		else
			button:Hide();
		end
	end
	local debuffCount;
	local numDebuffs = 0;
	for i=1, MAX_TARGET_DEBUFFS do
		debuff, debuffApplications, debuffType = UnitDebuff("targettarget", i);
		button = getglobal("CT_AssistFrameDebuff"..i);
		if ( debuff ) then
			if ( debuffType ) then
				color = DebuffTypeColor[debuffType];
			else
				color = DebuffTypeColor["none"];
			end
			getglobal("CT_AssistFrameDebuff"..i.."Icon"):SetTexture(debuff);
			getglobal("CT_AssistFrameDebuff" .. i .. "Border"):SetVertexColor(color.r, color.g, color.b);
			debuffCount = getglobal("CT_AssistFrameDebuff"..i.."Count");
			if ( debuffApplications > 1 ) then
				debuffCount:SetText(debuffApplications);
				debuffCount:Show();
			else
				debuffCount:Hide();
			end
			button:Show();
			numDebuffs = numDebuffs + 1;
		else
			button:Hide();
		end
		button.id = i;
	end
	
	-- If more than 5 debuffs then make the first 5 small
	local debuffFrame;
	local debuffSize, debuffFrameSize;
	if ( numDebuffs > 5 ) then
		debuffSize = 17;
		debuffFrameSize = 19;
	else
		debuffSize = 21;
		debuffFrameSize = 23;
	end
	for i=1, MAX_TARGET_DEBUFFS do
		button = getglobal("CT_AssistFrameDebuff"..i);
		debuffFrame = getglobal("CT_AssistFrameDebuff"..i.."Border");
		button:SetWidth(debuffSize);
		button:SetHeight(debuffSize);
		debuffFrame:SetWidth(debuffFrameSize);
		debuffFrame:SetHeight(debuffFrameSize);
	end
	
	if ( UnitIsFriend("player", "targettarget") ) then
		CT_AssistFrameBuff1:SetPoint("TOPLEFT", "CT_AssistFrame", "BOTTOMLEFT", 5, 32);
		CT_AssistFrameBuff7:ClearAllPoints();
		CT_AssistFrameBuff7:SetPoint("TOPLEFT", "CT_AssistFrameBuff1", "BOTTOMLEFT", 0, -2);
		if ( numBuffs > 6 ) then
			CT_AssistFrameDebuff1:SetPoint("TOPLEFT", "CT_AssistFrameBuff7", "BOTTOMLEFT", 0, -2);
		else
			CT_AssistFrameDebuff1:SetPoint("TOPLEFT", "CT_AssistFrameBuff1", "BOTTOMLEFT", 0, -2);
		end
		CT_AssistFrameBuff11:ClearAllPoints();
		CT_AssistFrameBuff11:SetPoint("LEFT", "CT_AssistFrameBuff10", "RIGHT", 3, 0);
	else
		CT_AssistFrameBuff1:SetPoint("TOPLEFT", "CT_AssistFrame", "BOTTOMLEFT", 5, 32);
		CT_AssistFrameBuff7:ClearAllPoints();
		CT_AssistFrameBuff7:SetPoint("LEFT", "CT_AssistFrameBuff6", "RIGHT", 3, 0);
		CT_AssistFrameDebuff1:SetPoint("TOPLEFT", "CT_AssistFrameBuff1", "BOTTOMLEFT", 0, -2);
		CT_AssistFrameBuff11:ClearAllPoints();
		CT_AssistFrameBuff11:SetPoint("TOPLEFT", "CT_AssistFrameBuff1", "BOTTOMLEFT", 0, -2);
	end
	local buffSize, button = 21;
	if ( numBuffs > 5 ) then
		buffSize = 17;
	end
	for i = 1, MAX_TARGET_BUFFS, 1 do
		button = getglobal("CT_AssistFrameBuff" .. i);
		button:SetWidth(buffSize);
		button:SetHeight(buffSize);
	end
end

function CT_AssistFrame_HealthUpdate(elapsed)
	if ( UnitIsPlayer("targettarget") ) then
		if ( (this.unitHPPercent > 0) and (this.unitHPPercent <= 0.2) ) then
			local alpha = 255;
			local counter = this.statusCounter + elapsed;
			local sign    = this.statusSign;
	
			if ( counter > 0.5 ) then
				sign = -sign;
				this.statusSign = sign;
			end
			counter = mod(counter, 0.5);
			this.statusCounter = counter;
	
			if ( sign == 1 ) then
				alpha = (127  + (counter * 256)) / 255;
			else
				alpha = (255 - (counter * 256)) / 255;
			end
			CT_AssistPortrait:SetAlpha(alpha);
		end
	end
end

function CT_AssistHealthCheck()
	if ( UnitExists("targettarget") ) then
		local unitMinHP, unitMaxHP, unitCurrHP;
		unitHPMin, unitHPMax = this:GetMinMaxValues();
		unitCurrHP = this:GetValue();
		this:GetParent().unitHPPercent = unitCurrHP / unitHPMax;
		if ( UnitIsDead("targettarget") ) then
			CT_AssistPortrait:SetVertexColor(0.35, 0.35, 0.35, 1.0);
		elseif ( UnitIsGhost("targettarget") ) then
			CT_AssistPortrait:SetVertexColor(0.2, 0.2, 0.75, 1.0);
		elseif ( (this:GetParent().unitHPPercent > 0) and (this:GetParent().unitHPPercent <= 0.2) ) then
			CT_AssistPortrait:SetVertexColor(1.0, 0.0, 0.0);
		else
			CT_AssistPortrait:SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
	end
	if ( not UnitIsPlayer("targettarget") ) then
		CT_AssistFrame_CheckFaction();
	end
end

function CT_AssistFrameDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_AssistFrameDropDown_Initialize, "MENU");
end

function CT_AssistFrameDropDown_Initialize()
	local menu = nil;
	if ( UnitIsEnemy("targettarget", "player") ) then
		return;
	end
	if ( UnitIsUnit("targettarget", "player") ) then
		menu = "SELF";
	elseif ( UnitIsUnit("targettarget", "pet") ) then
		menu = "PET";
	elseif ( UnitIsPlayer("targettarget") ) then
		if ( UnitInParty("targettarget") ) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	end
	if ( menu ) then
		UnitPopup_ShowMenu(CT_AssistFrameDropDown, menu, "targettarget");
	end
end
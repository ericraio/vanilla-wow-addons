if ( CT_AddMovable ) then
	CT_AddMovable("CT_TargetFrame_Drag", CT_TARGETFRAME_MOVABLE, "TOPLEFT", "TOPLEFT", "UIParent", 278, -25, function(status)
		if ( status ) then
			CT_TargetFrame_Drag:Show();
		else
			CT_TargetFrame_Drag:Hide();
		end
	end);
end

function CT_TargetFrameOnEvent(event)

	if( ( event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" ) and arg1 == "target" ) then
		CT_ShowTargetHealth();
		return;
	end
	
	if( ( event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY" or event == "UPDATE_SHAPESHIFT_FORMS" or event == "UNIT_MAXMANA" or event == "UNIT_MAXRAGE" or event == "UNIT_MAXMENERGY" or event == "UNIT_MAXFOCUS" ) and arg1 == "target" ) then
		CT_ShowTargetMana();
		return;
	end
	
	if ( event == "PLAYER_TARGET_CHANGED" or ( event == "UNIT_DISPLAYPOWER" and arg1 == "target" ) ) then
		CT_ShowTargetHealth();
		CT_ShowTargetMana();
	end
end

function CT_TargetFrame_ShallDisplay(offset)
	return CT_UnitFramesOptions.styles[3][offset][1];
end

function CT_TargetFrame_GetHealth(id)
	if ( not UnitExists("target") or not UnitExists("player") ) then
		return "";
	end
	if ( UnitHealth("target") <= 0 and UnitIsConnected("target") ) then
		return "";
	end
	if ( UnitHealthMax("target") == 100 ) then
		id = 2;
	end
	if ( id == 2 ) then
		return floor(( UnitHealth("target") or 1 ) / ( UnitHealthMax("target") or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitHealth("target") or 1 ) - ( UnitHealthMax("target") or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitHealth("target") or "?" ) .. "/" .. ( UnitHealthMax("target") or "?" );
	end
end

function CT_TargetFrame_GetMana(id)
	if ( not UnitExists("target") or not UnitExists("player") ) then
		return "";
	end
	if ( UnitPowerType("target") > 0 or UnitManaMax("target") == 0 or ( UnitHealth("target") <= 0 and UnitIsConnected("target") ) ) then
		return "";
	end
	if ( id == 2 ) then
		return floor(( UnitMana("target") or 1 ) / ( UnitManaMax("target") or 1)*100) .. "%";
	elseif ( id == 3 ) then
		local deficit = ( UnitMana("target") or 1 ) - ( UnitManaMax("target") or 1 );
		if ( deficit == 0 ) then
			deficit = "";
		end
		return deficit;
	elseif ( id == 4 ) then
		return ( UnitMana("target") or "?" ) .. "/" .. ( UnitManaMax("target") or "?" );
	end
end

function CT_ShowTargetHealth()
	if ( not UnitExists("target") or not UnitExists("player") or not UnitHealth("target") or not UnitHealthMax("target") ) then
		return;
	end
	local typeOnHealth = CT_TargetFrame_ShallDisplay(1);
	if ( typeOnHealth > 1 ) then
		CT_TargetHealthBar:Show();
		CT_TargetHealthBar:SetText(CT_TargetFrame_GetHealth(typeOnHealth));
	else
		CT_TargetHealthBar:Hide();
	end
	CT_TargetHealthBar:SetTextColor(CT_UnitFramesOptions.styles[3][1][2], CT_UnitFramesOptions.styles[3][1][3], CT_UnitFramesOptions.styles[3][1][4], CT_UnitFramesOptions.styles[3][1][5]);
end

-- Hack HealthBar_OnValueChanged to smoothly change the color
CT_TargetFrame_oldHealthBar_OnValueChanged = HealthBar_OnValueChanged;
function HealthBar_OnValueChanged(value, smooth)
	CT_TargetFrame_oldHealthBar_OnValueChanged(value, 1);
end

function CT_ShowTargetMana()
	if ( not UnitExists("target") or not UnitExists("player") ) then
		return;
	end
	local typeOnMana = CT_TargetFrame_ShallDisplay(2);
	if ( typeOnMana > 0 ) then
		CT_TargetManaBar:SetText(CT_TargetFrame_GetMana(typeOnMana));
		CT_TargetManaBar:Show();
	else
		CT_TargetManaBar:Hide();
	end
	CT_TargetManaBar:SetTextColor(CT_UnitFramesOptions.styles[3][2][2], CT_UnitFramesOptions.styles[3][2][3], CT_UnitFramesOptions.styles[3][2][4], CT_UnitFramesOptions.styles[3][2][5]);
end

function CT_SetTargetClass()
	if ( not CT_UnitFramesOptions.displayTargetClass ) then
		return;
	end
	if ( not UnitExists("target") or not UnitExists("player") ) then return; end
	if ( UnitIsPlayer("target") ) then
		CT_TargetFrameClassFrameText:SetText(UnitClass("target") or "");
	else
		CT_TargetFrameClassFrameText:SetText(UnitCreatureType("target") or "");
	end
end

MAX_TARGET_BUFFS = 20;
CT_UnitFrames_oldTargetDebuffButton_Update = TargetDebuffButton_Update;
function CT_UnitFrames_newTargetDebuffButton_Update()
	CT_UnitFrames_oldTargetDebuffButton_Update();
	
	local numBuffs = 0;
	while ( numBuffs < MAX_TARGET_BUFFS and UnitBuff("target", numBuffs+1) ) do
		numBuffs = numBuffs + 1;
	end
	if ( UnitIsFriend("player", "target") ) then
		TargetFrameBuff1:SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 32);
		 if ( numBuffs > 6 ) then
			TargetFrameDebuff1:SetPoint("TOPLEFT", "TargetFrameBuff7", "BOTTOMLEFT", 0, -2);
		else
			TargetFrameDebuff1:SetPoint("TOPLEFT", "TargetFrameBuff1", "BOTTOMLEFT", 0, -2);
		end
		TargetFrameBuff7:ClearAllPoints();
		TargetFrameBuff7:SetPoint("TOPLEFT", "TargetFrameBuff1", "BOTTOMLEFT", 0, -2);
		TargetFrameBuff11:ClearAllPoints();
		TargetFrameBuff11:SetPoint("LEFT", "TargetFrameBuff10", "RIGHT", 3, 0);
	else
		TargetFrameBuff7:ClearAllPoints();
		TargetFrameBuff7:SetPoint("LEFT", "TargetFrameBuff6", "RIGHT", 3, 0);
		TargetFrameBuff11:ClearAllPoints();
		TargetFrameBuff11:SetPoint("TOPLEFT", "TargetFrameBuff1", "BOTTOMLEFT", 0, -2);
	end
	
	local buffSize, button = 21;
	if ( numBuffs > 5 ) then
		buffSize = 17;
	end
	for i = 1, 5, 1 do
		button = getglobal("TargetFrameBuff" .. i);
		button:SetWidth(buffSize);
		button:SetHeight(buffSize);
	end
end
TargetDebuffButton_Update = CT_UnitFrames_newTargetDebuffButton_Update;
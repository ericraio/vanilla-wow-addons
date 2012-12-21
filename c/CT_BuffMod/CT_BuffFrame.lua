CT_AddMovable("CT_BuffMod_Drag", CT_BUFFMOD_MOVABLE_BUFFBAR, "BOTTOMLEFT", "BOTTOMLEFT", "MinimapCluster", 10, -20, function(status)
	if ( status ) then
		CT_BuffMod_Drag:Show()
	else
		CT_BuffMod_Drag:Hide();
	end
end, BuffModResetFunction);

CT_ExpireBuffs = { };
CT_BuffNames = { };
CT_LastExpiredBuffs = { };
CT_PlaySound = 0;
local CT_UsingTooltip = 0;

CT_BuffMod_BuffSides = "RIGHT";

CT_ShowDuration = 1;
CT_ShowExpire = 1;
CT_ShowRed = 0;

-- Buffs not to recast
CT_BuffMod_NoRecastBuffs = {
	["Mind Control"] = 1
};

function CT_BuffFrame_OnLoad()
	MinBuffDurationExpireMessage = 51; 	-- Never display an expire message if the buff duration is less than this.
	ExpireMessageTime = 15;		-- How long before the buff expires to display the expire message.
	ExpireMessageColors = { };
	ExpireMessageColors["r"] = 1.0;
	ExpireMessageColors["g"] = 0.0;
	ExpireMessageColors["b"] = 0.0;
	ExpireMessageFrame = DEFAULT_CHAT_FRAME; -- The frame in which to display the expire message.

	BuffStartFlashTime = 16;	-- How long before the buff expires to start flashing.
	BuffFlashOn = 0.50;		-- How long to flash.
	BuffFlashOff = 0.50;		-- How long between each flash.
	BuffMinOpacity = 0.30;		-- Minimum level of opacity.

	BuffFlashState = 0;
	BuffFlashTime = 0;
	BuffFlashUpdateTime = 0;
	BuffFrame:Hide();
	CT_BuffFrame:Show();
end

function CT_BuffFrame_OnUpdate(elapsed)

	if ( BuffFlashUpdateTime > 0 ) then
		BuffFlashUpdateTime = BuffFlashUpdateTime - elapsed;
	else
		BuffFlashUpdateTime = BuffFlashUpdateTime + TOOLTIP_UPDATE_TIME;
	end

	BuffFlashTime = BuffFlashTime - elapsed;

	if ( BuffFlashTime < 0 ) then
		local overtime = -BuffFlashTime;
		if ( BuffFlashState == 1 ) then
			BuffFlashState = 0;
			BuffFlashTime = BuffFlashOff;
		else
			BuffFlashState = 1;
			BuffFlashTime = BuffFlashOn;
		end
		if ( overtime < BuffFlashTime ) then
			BuffFlashTime = BuffFlashTime - overtime;
		end
	end
end

function CT_BuffIsDebuff(id)
	for z=0, 23, 1 do
		local dbIndex, dbTemp = GetPlayerBuff(z, "HARMFUL");
		if ( dbIndex == -1 ) then return 0; end

		if ( dbIndex == id ) then
			return 1;
		end
	end
	return 0;
end

function CT_GetBuffName(unit, i, filt)
	CT_UsingTooltip = 1;
	local filter;
	if ( not filt ) then
		filter = "HELPFUL|HARMFUL";
	else
		filter = filt;
	end
	local buffIndex, untilCancelled = GetPlayerBuff(i, filter);
	local buff;

	if ( buffIndex < 24 ) then
		buff = buffIndex;
		if (buff == -1) then
			buff = nil;
		end
	end

	if (buff) then
		local tooltip = BTooltip;
		if (unit == "player" and tooltip ) then
			tooltip:SetPlayerBuff(buffIndex);
		end
		local tooltiptext = getglobal("BTooltipTextLeft1");
		if ( tooltiptext ) then
			local name = tooltiptext:GetText();
			if ( name ~= nil ) then
				CT_UsingTooltip = 0;
				return name;
			end
		end
	end
	CT_UsingTooltip = 0;
	return nil;
end


function CT_BuffButton_Update()
	local buffIndex, untilCancelled = GetPlayerBuff(this:GetID(), "HELPFUL|HARMFUL");
	this.buffIndex = buffIndex;
	this.untilCancelled = untilCancelled;

	if ( buffIndex < 0 ) then
		this:Hide();
		return;
	else
		this:SetAlpha(1.0);
		this:Show();
	end

	local icon = getglobal(this:GetName().."Icon");
	icon:SetTexture(GetPlayerBuffTexture(buffIndex, "HELPFUL|HARMFUL"));

	if ( GameTooltip:IsOwned(this) ) then
		GameTooltip:SetPlayerBuff(buffIndex, "HELPFUL|HARMFUL");
	end
	local name = CT_GetBuffName("player", this:GetID(), "HELPFUL|HARMFUL");
	if ( name ) then
		getglobal(this:GetName() .. "DescribeText"):SetText( name );
	end
	CT_BuffNames[this:GetID()] = nil;

end

function CT_BuffButton_OnLoad()
	getglobal(this:GetName() .. "DurationText"):SetTextColor(1, 1, 0);
	local bIndex, untilCancelled = GetPlayerBuff(this:GetID(), "HELPFUL|HARMFUL");
	if ( CT_BuffIsDebuff( temp ) == 1 ) then
		if ( CT_ShowRed == 1 ) then
			getglobal(this:GetName() .. "DescribeText"):SetTextColor(1, 0, 0);
		else
			getglobal(this:GetName() .. "DescribeText"):SetTextColor(1, 1, 0);
		end
		getglobal(this:GetName() .. "Debuff"):Show();
	else
		getglobal(this:GetName() .. "DescribeText"):SetTextColor(1, 1, 0);
		getglobal(this:GetName() .. "Debuff"):Hide();
	end
	if ( untilCancelled == 1 or CT_ShowDuration == 0 ) then
		getglobal(this:GetName() .. "DurationText"):SetText("");
	end

	CT_BuffButton_Update();
	this:RegisterForClicks("RightButtonUp");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");

	local descript = getglobal(this:GetName() .. "DescribeText");
	if ( descript ) then descript:Show(); end
end

function CT_BuffButton_OnEvent(event)
	CT_BuffButton_Update();
end

function CT_GetStringTime(seconds)
	local str = "";
	if ( seconds >= 60 ) then
		local minutes = ceil(seconds / 60);
		str = minutes .. " " .. CT_BUFFMOD_MINUTE;
		if ( minutes > 1 ) then
			str = minutes .. " " .. CT_BUFFMOD_MINUTES;
		else
			str = minutes .. " " .. CT_BUFFMOD_MINUTE;
		end
	else
		if ( seconds > 1 ) then
			str = floor(seconds) .. " " .. CT_BUFFMOD_SECONDS;
		else
			str = floor(seconds) .. " " .. CT_BUFFMOD_SECOND;
		end
	end
	return str;
end

function CT_BuffButton_OnUpdate(elapsed)
	local buffname;
	local bIndex, untilCancelled = GetPlayerBuff( this:GetID(), "HELPFUL|HARMFUL" );
	local isDebuff = CT_BuffIsDebuff(bIndex);
	local buffnum = GetPlayerBuffApplications(bIndex)
	if ( buffnum > 1 ) then
		getglobal(this:GetName() .. "Count"):SetText(buffnum);
	else
		getglobal(this:GetName() .. "Count"):SetText("");
	end
	if ( isDebuff == 1 ) then
		if ( CT_ShowRed == 1 ) then
			getglobal(this:GetName() .. "DescribeText"):SetTextColor(1, 0, 0);
		else
			getglobal(this:GetName() .. "DescribeText"):SetTextColor(1, 1, 0);
		end
		getglobal(this:GetName() .. "Debuff"):Show();
	else
		getglobal(this:GetName() .. "DescribeText"):SetTextColor(1, 1, 0);
		getglobal(this:GetName() .. "Debuff"):Hide();
	end
	if ( untilCancelled == 1 ) then
		getglobal(this:GetName() .. "DurationText"):SetText("");
		return;
	end
	if ( not CT_BuffNames[this:GetID()] ) then
		buffname = CT_GetBuffName( "player", this:GetID() );
		CT_BuffNames[this:GetID()] = buffname;
	else
		buffname = CT_BuffNames[this:GetID()];
	end
	local timeLeft = GetPlayerBuffTimeLeft(bIndex);
	local buffAlphaValue;
	if ( timeLeft >= 1 and CT_ShowDuration == 1 ) then 
		getglobal(this:GetName() .. "DurationText"):SetText(CT_GetStringTime(timeLeft)); 
	else
		getglobal(this:GetName() .. "DurationText"):SetText("");
	end

	if ( floor(timeLeft) == MinBuffDurationExpireMessage and not CT_ExpireBuffs[buffname] ) then
		CT_ExpireBuffs[buffname] = 1;
	end

	if ( ceil(timeLeft) == ExpireMessageTime and CT_ExpireBuffs[buffname] and CT_BuffIsDebuff(bIndex) == 0 ) then
		if ( CT_ShowExpire == 1 and not CT_BuffMod_NoRecastBuffs[buffname]) then
			if ( CT_PlaySound == 1 ) then
				PlaySound("TellMessage");
			end
			CT_BuffMod_AddToQueue(buffname);
			local message;
			if ( CT_PlayerSpells[buffname] and GetBindingKey("CT_RECASTBUFF") ) then
				message = format(ExpireMessageRecastString, buffname, GetBindingText(GetBindingKey("CT_RECASTBUFF"), "KEY_"));
			else
				message = format(ExpireMessageString, buffname);
			end
			ExpireMessageFrame:AddMessage(message, ExpireMessageColors["r"], ExpireMessageColors["g"], ExpireMessageColors["b"]);
		end
		CT_ExpireBuffs[buffname] = nil;
		CT_BuffNames[this:GetID()] = nil;
	end
	if ( timeLeft < BuffStartFlashTime ) then
		if ( BuffFlashState == 1 ) then
			buffAlphaValue = (BuffFlashOn - BuffFlashTime) / BuffFlashOn;
			buffAlphaValue = buffAlphaValue * (1 - BuffMinOpacity) + BuffMinOpacity;
		else
			buffAlphaValue = BuffFlashTime / BuffFlashOn;
			buffAlphaValue = (buffAlphaValue * (1 - BuffMinOpacity)) + BuffMinOpacity;
			this:SetAlpha(BuffFlashTime / BuffFlashOn);
		end
		this:SetAlpha(buffAlphaValue);
	else
		this:SetAlpha(1.0);
	end

	if ( BuffFlashUpdateTime > 0 ) then
		return;
	end
	if ( GameTooltip:IsOwned(this) ) then
		GameTooltip:SetPlayerBuff(bIndex);
	end
end

function CT_BuffButton_OnClick()
	CancelPlayerBuff(this.buffIndex);
end

function CT_Buffs_SwapSides(onLoad)
	local i;
	for i = 0, 23, 1 do
		getglobal("CT_BuffButton" .. i .. "DescribeText"):ClearAllPoints();
		getglobal("CT_BuffButton" .. i .. "DurationText"):ClearAllPoints();
		if ( CT_BuffMod_BuffSides == "RIGHT" or onLoad ) then
			getglobal("CT_BuffButton" .. i .. "DescribeText"):SetPoint("RIGHT", "CT_BuffButton" .. i, "LEFT", -8, 7);
			getglobal("CT_BuffButton" .. i .. "DurationText"):SetPoint("RIGHT", "CT_BuffButton" .. i, "LEFT", -8, -7);
		elseif ( CT_BuffMod_BuffSides == "LEFT" ) then
			getglobal("CT_BuffButton" .. i .. "DescribeText"):SetPoint("LEFT", "CT_BuffButton" .. i, "LEFT", 40, 7);
			getglobal("CT_BuffButton" .. i .. "DurationText"):SetPoint("LEFT", "CT_BuffButton" .. i, "LEFT", 40, -7);
		end
	end
	if ( onLoad ) then return; end
	if ( CT_BuffMod_BuffSides == "LEFT" ) then
		CT_BuffMod_BuffSides = "RIGHT";
	else
		CT_BuffMod_BuffSides = "LEFT";
	end
end

expirefunction = function(modId, count)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "1min" ) then
		CT_Mods[modId]["modValue"] = "Off";
		if ( count ) then count:SetText("Off"); end
		CT_ShowExpire = 0;
		CT_Print(CT_BUFFMOD_ON_EXPIRE, 1.0, 1.0, 0.0);
	else
		CT_ShowExpire = 1;
		if ( val == "15sec" ) then
			CT_Mods[modId]["modValue"] = "1min";
			if ( count ) then count:SetText("1min"); end
			CT_Print(CT_BUFFMOD_MIN_EXPIRE, 1.0, 1.0, 0.0);
			ExpireMessageTime = 60;
			MinBuffDurationExpireMessage = 120;
		elseif ( val == "Off" ) then
			CT_Mods[modId]["modValue"] = "15sec";
			if ( count ) then count:SetText("15sec"); end
			CT_Print(CT_BUFFMOD_SEC_EXPIRE, 1.0, 1.0, 0.0);
			ExpireMessageTime = 15;
			MinBuffDuratioonExpireMessage = 51;
		end
	end
end

durationfunction = function(modId)
	if ( CT_ShowDuration == 1 ) then
		CT_ShowDuration = 0;
		CT_SetModStatus(modId, "off");
		CT_Print(CT_BUFFMOD_OFF_DURATION, 1.0, 1.0, 0.0);
	else
		CT_ShowDuration = 1;
		CT_SetModStatus(modId, "on");
		CT_Print(CT_BUFFMOD_ON_DURATION, 1.0, 1.0, 0.0);
	end
end

expireinitfunction = function(modId)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "Off" ) then
		CT_ShowExpire = 0;
	else
		CT_ShowExpire = 1;
		if ( val == "1min" ) then
			ExpireMessageTime = 60;
			MinBuffDurationExpireMessage = 120;
		elseif ( val == "15sec" ) then
			ExpireMessageTime = 15;
			MinBuffDurationExpireMessage = 51;
		end
	end
end
durationinitfunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_ShowDuration = 1;
	else
		CT_ShowDuration = 0;
	end
end

debuffnamesfunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_ShowRed = 1;
		CT_Print(CT_BUFFMOD_ON_DEBUFF, 1.0, 1.0, 0.0);
	else
		CT_ShowRed = 0;
		CT_Print(CT_BUFFMOD_OFF_DEBUFF, 1.0, 1.0, 0.0);
	end
end

debuffnamesinitfunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_ShowRed = 1;
	else
		CT_ShowRed = 0;
	end
end

lockframefunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_Print(CT_BUFFMOD_OFF_LOCK, 1, 1, 0);
		CT_BuffMod_Drag:Hide();
	else
		CT_Print(CT_BUFFMOD_ON_LOCK, 1, 1, 0);
		CT_BuffMod_Drag:Show();
	end
end

lockframeinitfunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_BuffMod_Drag:Hide();
	else
		CT_BuffMod_Drag:Show();
	end
end

buffmodfunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_Print(CT_BUFFMOD_OFF_TOGGLE, 1, 1, 0);
		CT_BuffFrame:Hide();
		BuffFrame:Show();
		if ( TemporaryEnchantFrame ) then
			TemporaryEnchantFrame:Show();
		end
	else
		CT_Print(CT_BUFFMOD_ON_TOGGLE, 1, 1, 0);
		CT_BuffFrame:Show();
		BuffFrame:Hide();
		if ( TemporaryEnchantFrame and CT_ItemBuffFrame ) then
			TemporaryEnchantFrame:Hide();
		elseif ( TemporaryEnchantFrame ) then
			TemporaryEnchantFrame:Show();
		end
	end
end

buffmodinitfunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_BuffFrame:Hide();
		BuffFrame:Show();
		if ( TemporaryEnchantFrame ) then
			TemporaryEnchantFrame:Show();
		end
	else
		CT_BuffFrame:Show();
		BuffFrame:Hide();
		if ( TemporaryEnchantFrame and CT_ItemBuffFrame ) then
			TemporaryEnchantFrame:Hide();
		elseif ( TemporaryEnchantFrame ) then
			TemporaryEnchantFrame:Show();
		end
	end
end

CT_RegisterMod(CT_BUFFMOD_MODNAME_TOGGLE, CT_BUFFMOD_MODNAME_SUB_TOGGLE, 4, "Interface\\Icons\\Spell_Holy_Renew", CT_BUFFMOD_MODNAME_TOOLTIP_TOGGLE, "on", nil, buffmodfunction, buffmodinitfunction);
CT_RegisterMod(CT_BUFFMOD_MODNAME_EXPIRE, CT_BUFFMOD_MODNAME_SUB_EXPIRE, 4, "Interface\\Icons\\INV_Misc_Note_03", CT_BUFFMOD_MODNAME_TOOLTIP_EXPIRE, "switch", "15sec", expirefunction, expireinitfunction);
CT_RegisterMod(CT_BUFFMOD_MODNAME_DURATION, CT_BUFFMOD_MODNAME_SUB_DURATION, 4, "Interface\\Icons\\INV_Misc_PocketWatch_01", CT_BUFFMOD_MODNAME_TOOLTIP_DURATION, "on", nil, durationfunction, durationinitfunction);
CT_RegisterMod(CT_BUFFMOD_MODNAME_DEBUFF, CT_BUFFMOD_MODNAME_SUB_DEBUFF, 4, "Interface\\Icons\\Spell_Holy_SealOfSacrifice", CT_BUFFMOD_MODNAME_TOOLTIP_DEBUFF, "off", nil, debuffnamesfunction, debuffnamesinitfunction);

function CT_BuffMod_RecastLastBuff()
	local buff = CT_BuffMod_GetExpiredBuff();
	if ( buff and CT_PlayerSpells[buff] ) then
		if ( CT_PlayerSpells[buff] ) then
			CT_BuffMod_LastCastSpell = buff;
			CT_BuffMod_LastCast = GetTime();
			if ( UnitExists("target") and UnitIsFriend("player", "target") ) then
				TargetUnit("player");
			end
			CastSpell(CT_PlayerSpells[buff]["spell"], CT_PlayerSpells[buff]["tab"]+1);
			if ( SpellIsTargeting() and SpellCanTargetUnit("player") ) then
				SpellTargetUnit("player");
			end
		end
	end
end

function CT_BuffButton_OnEnter()
	if ( this:GetCenter() < UIParent:GetCenter() ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	end
	GameTooltip:SetPlayerBuff(this.buffIndex);
end

function CT_BuffMod_AddToQueue(name)
	local hKey = 0;
	local hVal = 0;
	for key, val in CT_LastExpiredBuffs do
		if ( val > hVal ) then
			hKey = key; hVal = val;
		end
	end
	if ( hKey == name ) then return; end
	
	CT_LastExpiredBuffs[name] = hVal+1;
end

function CT_BuffMod_GetExpiredBuff()
	local hKey = 0;
	local hVal = 0;
	for key, val in CT_LastExpiredBuffs do
		if ( val > hVal ) then
			hKey = key; hVal = val;
		end
	end
	if ( hKey ~= 0 and hVal ~= 0 ) then
		CT_LastExpiredBuffs[hKey] = nil;
		return hKey;
	else
		return nil;
	end
end

function CT_BuffMod_OnEvent(event)
	if ( CT_BuffMod_LastCast and (GetTime()-CT_BuffMod_LastCast) <= 0.1 ) then
		CT_BuffMod_AddToQueue(CT_BuffMod_LastCastSpell);
		CT_BuffMod_LastCast = nil;
		CT_BuffMod_LastCastSpell = nil;
	end
end

function BuffModResetFunction()
	if ( CT_BuffMod_BuffSides == "LEFT" ) then
		CT_Buffs_SwapSides();
	end
end

ChirpFunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_Print(CT_BUFFMOD_OFF_CHIRP, 1, 1, 0);
		CT_PlaySound = 0;
	else
		CT_Print(CT_BUFFMOD_ON_CHIRP, 1, 1, 0);
		CT_PlaySound = 1;
	end
end

ChirpInitFunction = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_PlaySound = 0;
	else
		CT_PlaySound = 1;
	end
end

CT_RegisterMod(CT_BUFFMOD_MODNAME_SOUND, CT_BUFFMOD_SUB_SOUND, 4, "Interface\\Icons\\INV_Misc_Bell_01", CT_BUFFMOD_TOOLTIP_SOUND, "off", nil, ChirpFunction, ChirpInitFunction);
CT_ItemBuff_MinBuffMessageTime = 16;
CT_ItemBuff_MinBuffDuration = 15;
CT_ItemBuff_HasMainBuff = -1;
CT_ItemBuff_HasOffBuff = -1;

-- Credits to Telo for the following 2 functions
local CT_GameTooltip_ClearMoney;

local function CT_ItemBuff_MoneyToggle()
	if( CT_GameTooltip_ClearMoney ) then
		GameTooltip_ClearMoney = CT_GameTooltip_ClearMoney;
		CT_GameTooltip_ClearMoney = nil;
	else
		CT_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = CT_GameTooltipFunc_ClearMoney;
	end
end

function CT_GameTooltipFunc_ClearMoney()

end

function CT_ItemBuffFrame_OnUpdate(elapsed)
	local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	
	-- No enchants, kick out early
	if ( ( not hasMainHandEnchant and not hasOffHandEnchant ) or not CT_BuffFrame:IsVisible() ) then
		CT_ItemBuffButton1:Hide();
		CT_ItemBuffButton2:Hide();
		return;
	end

	-- Has enchants
	local enchantButton;
	local textureName;
	local buffAlphaValue;
	local enchantIndex = 0;
	local name;
	local duration;

	if ( hasOffHandEnchant ) then
		local showIcon = 1;
		local timeLeft = floor(offHandExpiration/1000);
		if ( CT_ItemBuff_HasOffBuff == -1 ) then
			CT_ItemBuff_HasOffBuff = timeLeft;
		end
		if ( CT_ItemBuff_HasOffBuff >= CT_ItemBuff_MinBuffDuration ) then
			name = CT_ItemBuff_GetEnchantInfo(17);
			local type = 2;
			local typeLeft = timeLeft;
			if ( timeLeft >= 60 ) then
				type = 1;
				typeLeft = ceil(timeLeft/60);
			end
			duration = CT_ItemBuff_FixString(typeLeft, type, offHandCharges);
			enchantIndex = enchantIndex + 1;
			textureName = GetInventoryItemTexture("player", 17);
			CT_ItemBuffButton1:SetID(17);
			CT_ItemBuffButton1Icon:SetTexture(textureName);
			CT_ItemBuffButton1:Show();
			CT_ItemBuffButton1DurationText:SetText(duration);
			CT_ItemBuffButton1DescribeText:SetText(name);
			hasEnchant = 1;

			if ( floor(timeLeft) == CT_ItemBuff_MinBuffMessageTime ) then
				CT_ExpireBuffs[name] = 1;
			end

			if ( ceil(timeLeft) == ExpireMessageTime and CT_ExpireBuffs[name] and CT_ExpireBuffs[name] == 1 ) then
				CT_ExpireBuffs[name] = nil;
				if ( CT_ShowExpire == 1 and name ) then
					local message = format( ExpireMessageString, name );
					CT_Print( message, ExpireMessageColors["r"], ExpireMessageColors["g"], ExpireMessageColors["b"] );
				end
			end
			if ( timeLeft < BuffStartFlashTime ) then
				if ( BuffFlashState == 1 ) then
					buffAlphaValue = (BuffFlashOn - BuffFlashTime) / BuffFlashOn;
					buffAlphaValue = buffAlphaValue * (1 - BuffMinOpacity) + BuffMinOpacity;
				else
					buffAlphaValue = BuffFlashTime / BuffFlashOn;
					buffAlphaValue = (buffAlphaValue * (1 - BuffMinOpacity)) + BuffMinOpacity;
					CT_ItemBuffButton1:SetAlpha(BuffFlashTime / BuffFlashOn);
				end
				CT_ItemBuffButton1:SetAlpha(buffAlphaValue);
			else
				CT_ItemBuffButton1:SetAlpha(1.0);
			end
		else
			CT_ItemBuff_HasOffBuff = -1;
		end
		
	end
	if ( hasMainHandEnchant ) then
		local showIcon = 1;
		local timeLeft = floor(mainHandExpiration/1000);
		if ( CT_ItemBuff_HasMainBuff == -1 ) then
			CT_ItemBuff_HasMainBuff = timeLeft;
		end
		if ( CT_ItemBuff_HasMainBuff >= CT_ItemBuff_MinBuffDuration ) then

			name = CT_ItemBuff_GetEnchantInfo(16);
			local type = 2;
			local typeLeft = timeLeft;
			if ( timeLeft >= 60 ) then
				type = 1;
				typeLeft = ceil(timeLeft/60);
			end
			duration = CT_ItemBuff_FixString(typeLeft, type, mainHandCharges);
			enchantIndex = enchantIndex + 1;
			enchantButton = getglobal("CT_ItemBuffButton"..enchantIndex);
			textureName = GetInventoryItemTexture("player", 16);
			enchantButton:SetID(16);
			getglobal(enchantButton:GetName().."Icon"):SetTexture(textureName);
			enchantButton:Show();
			getglobal("CT_ItemBuffButton"..enchantIndex .. "DurationText"):SetText(duration);
			getglobal("CT_ItemBuffButton"..enchantIndex .. "DescribeText"):SetText(name);
			hasEnchant = 1;

			if ( timeLeft == CT_ItemBuff_MinBuffMessageTime ) then
				CT_ExpireBuffs[name] = 1;
			end

			if ( timeLeft == ExpireMessageTime and CT_ExpireBuffs[name] and CT_ExpireBuffs[name] == 1 ) then
				CT_ExpireBuffs[name] = nil;
				if ( CT_ShowExpire == 1 and name ) then
					local message = format( ExpireMessageString, name );
					CT_Print( message, ExpireMessageColors["r"], ExpireMessageColors["g"], ExpireMessageColors["b"] );
				end
			end
			if ( timeLeft < BuffStartFlashTime ) then
				if ( BuffFlashState == 1 ) then
					buffAlphaValue = (BuffFlashOn - BuffFlashTime) / BuffFlashOn;
					buffAlphaValue = buffAlphaValue * (1 - BuffMinOpacity) + BuffMinOpacity;
				else
					buffAlphaValue = BuffFlashTime / BuffFlashOn;
					buffAlphaValue = (buffAlphaValue * (1 - BuffMinOpacity)) + BuffMinOpacity;
					enchantButton:SetAlpha(BuffFlashTime / BuffFlashOn);
				end
				enchantButton:SetAlpha(buffAlphaValue);
			else
				enchantButton:SetAlpha(1.0);
			end
		else
			CT_ItemBuff_HasMainBuff = -1;
		end
	end

	--Hide unused enchants
	for i=enchantIndex+1, 2 do
		getglobal("CT_ItemBuffButton"..i):Hide();
	end

	if ( not CT_BuffButton0:IsVisible() ) then
		CT_ItemBuffButton1:ClearAllPoints();
		CT_ItemBuffButton1:SetPoint("TOPLEFT", "CT_BuffButton0", "TOPLEFT", 0, 0);
	else
		for i = 1, 23, 1 do
			if ( not getglobal("CT_BuffButton" .. i):IsVisible() ) then
				CT_ItemBuffButton1:ClearAllPoints();
				CT_ItemBuffButton1:SetPoint("TOPLEFT", "CT_BuffButton" .. (i-1), "BOTTOMLEFT", 0, -5);
				break;
			end
		end
	end
end

function CT_ItemBuff_FixString(num, type, charges)
	local chargestring = "";
	if ( charges == 1 ) then
		chargestring = " 1 charge";
		charges = 2;
	elseif ( charges > 1 ) then
		chargestring = " " .. charges .. " charges";
		charges = 2;
	end

	local types = {
		{ "minute", "second", "min", "sec" },
		{ "minutes", "seconds", "min", "sec" }
	};

	if ( num == 1 ) then
		return num .. " " .. types[1][(type+charges)] .. chargestring;
	else
		return num .. " " .. types[2][(type+charges)] .. chargestring;
	end
end

function CT_ItemBuff_GetEnchantInfo(id)
	CT_IB_TempTooltip:ClearLines();
	CT_ItemBuff_MoneyToggle();
	local val = CT_IB_TempTooltip:SetInventoryItem("player", id)
	CT_ItemBuff_MoneyToggle();

	if ( val ) then
		for i = 1, 15, 1 do
			text = getglobal("CT_IB_TempTooltipTextLeft"..i);
			local text = text:GetText();
			if ( strlen(text or "") > 0 )then
				iStart, iEnd, temp = string.find(text, "([^%(]+) %(%d+.+%)$");
				if ( temp ) then
					return temp;
				end
			end
		end
	end
	return nil;
end

function CT_ItemBuffs_InitFunc(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_ItemBuff_MinBuffDuration = 0;
	else
		CT_ItemBuff_MinBuffDuration = 16;
	end
end

function CT_ItemBuffs_Func(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_Print("<CTMod> " .. CT_ITEMBUFFS_SHORTDURATION_SHOWN, 1, 1, 0);
		CT_ItemBuff_MinBuffDuration = 0;
	else
		CT_Print("<CTMod> " .. CT_ITEMBUFFS_SHORTDURATION_HIDDEN, 1, 1, 0);
		CT_ItemBuff_MinBuffDuration = 16;
	end
end

CT_RegisterMod(CT_ITEMBUFFS_MODNAME, CT_ITEMBUFFS_SUBNAME, 3, "Interface\\Icons\\INV_Misc_PocketWatch_01", CT_ITEMBUFFS_TOOLTIP, "off", nil, CT_ItemBuffs_Func, CT_ItemBuffs_InitFunc);

-- Hook our own function ;)

CT_Old_SwapSides = CT_Buffs_SwapSides;

function CT_ItemBuffs_SwapSides(onLoad)
	CT_Old_SwapSides(onLoad);
	local i;
	for i = 1, 2, 1 do
		getglobal("CT_ItemBuffButton" .. i .. "DescribeText"):ClearAllPoints();
		getglobal("CT_ItemBuffButton" .. i .. "DurationText"):ClearAllPoints();
		if ( CT_BuffMod_BuffSides == "LEFT" or onLoad ) then
			getglobal("CT_ItemBuffButton" .. i .. "DescribeText"):SetPoint("RIGHT", "CT_ItemBuffButton" .. i, "LEFT", -8, 7);
			getglobal("CT_ItemBuffButton" .. i .. "DurationText"):SetPoint("RIGHT", "CT_ItemBuffButton" .. i, "LEFT", -8, -7);
		elseif ( CT_BuffMod_BuffSides == "RIGHT" ) then
			getglobal("CT_ItemBuffButton" .. i .. "DescribeText"):SetPoint("LEFT", "CT_ItemBuffButton" .. i, "LEFT", 40, 7);
			getglobal("CT_ItemBuffButton" .. i .. "DurationText"):SetPoint("LEFT", "CT_ItemBuffButton" .. i, "LEFT", 40, -7);
		end
	end
end

CT_Buffs_SwapSides = CT_ItemBuffs_SwapSides;

function CT_ItemBuffs_GetStrTime(time)
	local min, sec;
	if ( time >= 60 ) then
		min = floor(time/60);
		sec = time - min*60;
	else
		sec = time;
		min = 0;
	end
	if ( sec <= 9 ) then sec = "0" .. sec; end
	if ( min <= 9 ) then min = "0" .. min; end
	return min .. ":" .. sec;
end

CT_oldBuffFrame_UpdateDuration = BuffFrame_UpdateDuration;

function CT_newBuffFrame_UpdateDuration(buffButton, timeLeft)
	CT_oldBuffFrame_UpdateDuration(buffButton, timeLeft);
	local duration = getglobal(buffButton:GetName().."Duration");
	if ( SHOW_BUFF_DURATIONS == "1" and timeLeft ) then
		duration:SetText(CT_ItemBuffs_GetStrTime(floor(timeLeft)));
	end
end

BuffFrame_UpdateDuration = CT_newBuffFrame_UpdateDuration;
--Hemco's Pet Info Titan UI plugin.
--Version 1.4 beta 07-Aug-05
--Thanks to Scarabeus for the German localization.
--1.4 - Added support for warlocks.
--1.3 - Added attributes display.
--		Added XP info to the XP bar.
--1.2 - Added DPS stats.
--		Fixed name/level display settings bug.
--		Upated German localization -- Thanks again Scarabeus.
--1.1 - German localization -- Thanks Scarabeus
--		Added options to show name, level, or both.
--		1600 update.
--1.0 - Initial release.



TITAN_PETINFO_ID = "PetInfo";
TITAN_PETINFO_FREQ = 1;
TITAN_PETTINFO_PERCENT_FORMAT = "%d (%.1f%%)";
TITAN_PETTINFO_AS_FORMAT = "%.2f";
TITAN_PETTINFO_DPS_FORMAT = "%.1f";
avgSpan = 30;
uiLoaded = true;
xpHistory = {};
dpsHistory = {};
petAttribs = {};
battleDamage = 0;
battleStartTime = 0;
petLevel = "";
petName = "";
petNameChk = "";
petSex = "";
petHappiness = 0;
happinessStart = 0;
happiness = 0;
playerClass = "";
englishClass = "";
isHunter = false;

--Slash commands

function TitanPanelPetInfoButton_SlashCmd(command)
	local cmd;
	cmd = string.lower(command);
	if cmd == "start" then
		happiness = 0;
		happinessStart = GetTime();
	end
end

--Button creation functions

function TitanPanelPetInfoButton_OnLoad()

	this.registry = {
		id = TITAN_PETINFO_ID,
		menuText = TITAN_PETINFO_MENU_TEXT,
		buttonTextFunction = "TitanPanelPetInfoButton_GetButtonText", 
		tooltipTitle = TITAN_PETINFO_TOOLTIP,
		tooltipTextFunction = "TitanPanelPetInfoButton_GetTooltipText",
		frequency = TITAN_PETINFO_FREQ,	
		iconWidth = 16,
		savedVariables = {
			ShowPetName = 1,
			ShowPetLevel = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
			ShowBarText = 1,
			ShowPetAttrb = 1,
		}
	};	

	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	--this:RegisterEvent("PET_UI_UPDATE");
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");

	SlashCmdList["TITAN_PET_INFO"] = TitanPanelPetInfoButton_SlashCmd;
	SLASH_TITAN_PET_INFO1 = "/tpi";
	
	playerClass, englishClass = UnitClass("player");
	if englishClass == "HUNTER" then
		isHunter = true;
	end

end

function TitanPanelPetInfoButton_OnEvent()
	if (event == "PET_ATTACK_START") then
		battleDamage = 0;
		battleStartTime = GetTime();
		happiness = 0;
		happinessStart = GetTime();
	elseif (event == "PET_ATTACK_STOP") then
		length = GetTime() - battleStartTime;		
		TitanPanelPetInfoButton_AddDPSEntry(length, battleDamage);
	elseif (event == "PET_UI_UPDATE") then
		--TitanPanelPetInfoButton_OnXPUpdate();
	elseif (event == "CHAT_MSG_COMBAT_PET_HITS" or event == "CHAT_MSG_SPELL_PET_DAMAGE") then
		TitanPanelPetInfoButton_AddDamageEntry(arg1);
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		--TitanPanelPetInfoButton_GetHappyGain(arg1);
	end
end

function TitanPanelPetInfoButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);

	if HasPetUI() then
		petName = UnitName("pet");
		petLevel = UnitLevel("pet");
		if UnitSex("pet") == 2 then
			petSex = TITAN_PETINFO_MENU_FEMALE;
		else
			petSex = TITAN_PETINFO_MENU_MALE;
		end
		
		local currentXP, totalXP, toLevelXP = TitanPanelPetInfoButton_GetPetExperience();
		local timeLeft, XPPerMin = TitanPanelPetInfoButton_XPTimeLeft();
		local barText = TitanPanelPetInfoButton_BarText(toLevelXP, timeLeft);
		--TitanPanelPetInfoButton_HappinessCheck();
		TitanPetInfoText:SetText(barText)

		if TitanGetVar(TITAN_PETINFO_ID, "ShowPetLevel") and TitanGetVar(TITAN_PETINFO_ID, "ShowPetName") then
			return TITAN_PETINFO_BUTTON_LABEL_PETINFO, TitanUtils_GetHighlightText(petName),
			TITAN_PETINFO_BUTTON_LABEL_PETLEVEL, TitanUtils_GetHighlightText(petLevel);
		elseif TitanGetVar(TITAN_PETINFO_ID, "ShowPetName") then
			return TITAN_PETINFO_BUTTON_LABEL_PETINFO, TitanUtils_GetHighlightText(petName);
		else
			return TITAN_PETINFO_BUTTON_LABEL_PETLEVEL, TitanUtils_GetHighlightText(petLevel);
		end

	else
		TitanPetInfoText:SetText("");
		return TITAN_PETINFO_BUTTON_LABEL_NOPET;
	end
	
end

function TitanPanelPetInfoButton_GetTooltipText()
	local currentXP, totalXP, toLevelXP = TitanPanelPetInfoButton_GetPetExperience();
	local petType = UnitCreatureFamily("pet");
	local currentXPPercent = currentXP / totalXP * 100;
	local toLevelXPPercent = toLevelXP / totalXP * 100;
	local totalTP, usedTP = GetPetTrainingPoints();
	local freeTP = totalTP - usedTP;
	local atkSpeed = UnitAttackSpeed("pet");
	local atkRate = UnitAttackBothHands("pet");
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentMod = UnitDamage("pet");
	local listedDPS = (((lowDmg + hiDmg) * .5 + posBuff + negBuff) * percentMod) / atkSpeed;
	local actualDPS = TitanPanelPetInfoButton_GetActualDPS();
	TitanPanelPetInfoButton_OnXPUpdate();
    if HasPetUI() then
	    if isHunter then
			return ""..
				TITAN_PETINFO_BUTTON_LABEL_TYPE.."\t"..TitanUtils_GetHighlightText(petType).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_FOOD.."\t"..TitanUtils_GetHighlightText(BuildListString(GetPetFoodTypes())).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_LOYALTY.."\t"..TitanUtils_GetHighlightText(GetPetLoyalty()).."\n"..
				TITAN_PETINFO_MENU_GENDER.."\t"..TitanUtils_GetHighlightText(petSex).."\n"..
				"\n"..
				TITAN_PETINFO_BUTTON_LABEL_TRAINING_POINTS.."\t"..TitanUtils_GetHighlightText(freeTP).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_ARMOR_CLASS.."\t"..TitanUtils_GetHighlightText(UnitArmor("pet")).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_ATTACK_RATE.."\t"..TitanUtils_GetHighlightText(atkRate).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_ATTACK_SPEED.."\t"..TitanUtils_GetHighlightText(format(TITAN_PETTINFO_AS_FORMAT, atkSpeed)).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_DPS_LISTED.."\t"..TitanUtils_GetHighlightText(format(TITAN_PETTINFO_DPS_FORMAT, listedDPS)).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_DPS_ACTUAL.."\t"..TitanUtils_GetHighlightText(actualDPS).."\n"..
				"\n"..
				TitanPanelPetInfoButton_SetStats().."\n"..
				TitanPanelPetInfoButton_ShowXPInfo(currentXP,currentXPPercent,toLevelXP,toLevelXPPercent,totalXP,timeLeft);
		else
            return ""..
				TITAN_PETINFO_BUTTON_LABEL_TYPE.."\t"..TitanUtils_GetHighlightText(petType).."\n"..
				TITAN_PETINFO_MENU_GENDER.."\t"..TitanUtils_GetHighlightText(petSex).."\n"..
				"\n"..
				TITAN_PETINFO_BUTTON_LABEL_ARMOR_CLASS.."\t"..TitanUtils_GetHighlightText(UnitArmor("pet")).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_ATTACK_RATE.."\t"..TitanUtils_GetHighlightText(atkRate).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_ATTACK_SPEED.."\t"..TitanUtils_GetHighlightText(format(TITAN_PETTINFO_AS_FORMAT, atkSpeed)).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_DPS_LISTED.."\t"..TitanUtils_GetHighlightText(format(TITAN_PETTINFO_DPS_FORMAT, listedDPS)).."\n"..
				TITAN_PETINFO_BUTTON_LABEL_DPS_ACTUAL.."\t"..TitanUtils_GetHighlightText(actualDPS).."\n"..
				"\n"..
				TitanPanelPetInfoButton_SetStats();
		end
	else
		return
	end
		
end

function TitanPanelRightClickMenu_PreparePetInfoMenu()	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_PETINFO_ID].menuText);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PETINFO_MENU_RESET_SESSION, TITAN_PETINFO_ID, "TitanPanelPetInfoButton_ResetSession");

	TitanPanelRightClickMenu_AddSpacer();
	local info = {};
	info.text = TITAN_PETINFO_MENU_SHOW_PET_LEVEL;
	info.func = TitanPanelPetInfoButton_ShowPetLevel
	info.checked = TitanGetVar(TITAN_PETINFO_ID, "ShowPetLevel");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_PETINFO_MENU_SHOW_PET_NAME;
	info.func = TitanPanelPetInfoButton_ShowPetName
	info.checked = TitanGetVar(TITAN_PETINFO_ID, "ShowPetName");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	info = {};
	info.text = TITAN_PETINFO_MENU_SHOW_BAR_TEXT;
	info.func = TitanPanelPetInfoButton_ShowBarText
	info.checked = TitanGetVar(TITAN_PETINFO_ID, "ShowBarText");
	UIDropDownMenu_AddButton(info);
	info = {};
	info.text = TITAN_PETINFO_MENU_SHOW_PET_ATTRIB;
	info.func = TitanPanelPetInfoButton_ShowPetAttrb
	info.checked = TitanGetVar(TITAN_PETINFO_ID, "ShowPetAttrb");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_PETINFO_ID);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_PETINFO_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelPetInfoButton_ResetSession()
	xpHistory = {};
	dpsHistory = {};
end

function TitanPanelPetInfoButton_ShowPetName()
	if TitanGetVar(TITAN_PETINFO_ID, "ShowPetLevel") and TitanGetVar(TITAN_PETINFO_ID, "ShowPetName") then
		TitanSetVar(TITAN_PETINFO_ID, "ShowPetName", nil);
	else
		TitanSetVar(TITAN_PETINFO_ID, "ShowPetName", 1);
	end

	TitanPanelButton_UpdateButton(TITAN_PETINFO_ID);
end

function TitanPanelPetInfoButton_ShowPetLevel()
	if TitanGetVar(TITAN_PETINFO_ID, "ShowPetLevel") and TitanGetVar(TITAN_PETINFO_ID, "ShowPetName") then
		TitanSetVar(TITAN_PETINFO_ID, "ShowPetLevel", nil);
	else
		TitanSetVar(TITAN_PETINFO_ID, "ShowPetLevel", 1);
	end

	TitanPanelButton_UpdateButton(TITAN_PETINFO_ID);
end

function TitanPanelPetInfoButton_ShowBarText()
	TitanSetVar(TITAN_PETINFO_ID, "ShowBarText", TitanUtils_Toggle(TitanGetVar(TITAN_PETINFO_ID, "ShowBarText")))
end

function TitanPanelPetInfoButton_ShowPetAttrb()
	TitanSetVar(TITAN_PETINFO_ID, "ShowPetAttrb", TitanUtils_Toggle(TitanGetVar(TITAN_PETINFO_ID, "ShowPetAttrb")))
end

function TitanPanelPetInfoButton_SetStats()
	local attrbStr = "";
	for i=1, NUM_PET_STATS, 1 do
		local label = getglobal("PetStatFrame"..i.."Label");
		local text = getglobal("PetStatFrame"..i.."StatText");
		local frame = getglobal("PetStatFrame"..i);
		local stat;
		local effectiveStat;
		local posBuff;
		local negBuff;
		attrbStr = attrbStr..TEXT(getglobal("SPELL_STAT"..(i-1).."_NAME")).."\t";
		stat, effectiveStat, posBuff, negBuff = UnitStat("pet", i);

		if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
			attrbStr = attrbStr..TitanUtils_GetHighlightText(effectiveStat);
		else 
			
			-- If there are any negative buffs then show the main number in red even if there are
			-- positive buffs. Otherwise show in green.
			if ( negBuff < 0 ) then
				attrbStr = attrbStr..RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE;
			else
				attrbStr = attrbStr..GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE;
			end
		end
		attrbStr = attrbStr.."\n"
	end
	if TitanGetVar(TITAN_PETINFO_ID, "ShowPetAttrb") then
		return attrbStr;
	else
		return "";
	end
end


function TitanPanelPetInfoButton_ShowXPInfo(currentXP,currentXPPercent,toLevelXP,toLevelXPPercent,totalXP,timeLeft)
	local timeLeft, XPPerMin = TitanPanelPetInfoButton_XPTimeLeft();
	return ""..
		"\n"..
			TITAN_PETINFO_BUTTON_LABEL_CURRENT_XP.."\t"..TitanUtils_GetHighlightText(format(TITAN_PETTINFO_PERCENT_FORMAT, currentXP, currentXPPercent)).."\n"..
			TITAN_PETINFO_BUTTON_LABEL_NEEDED_XP.."\t"..TitanUtils_GetHighlightText(format(TITAN_PETTINFO_PERCENT_FORMAT, toLevelXP, toLevelXPPercent)).."\n"..
			TITAN_PETINFO_BUTTON_LABEL_TOTAL_XP.."\t"..TitanUtils_GetHighlightText(totalXP).."\n"..
			TITAN_PETINFO_BUTTON_LABEL_LEVEL_TIME_LEFT.."\t"..TitanUtils_GetHighlightText(timeLeft).."\n"..
			TITAN_PETINFO_BUTTON_LABEL_XP_PER_MIN.."\t"..TitanUtils_GetHighlightText(XPPerMin);
end

--Pet time-to-level funtions

function TitanPanelPetInfoButton_SecondsToTime(seconds)

   if not seconds or seconds < 0 then
      return '-:--:--';
   end

   local s = math.mod(seconds, 60);
   local m = math.floor(math.mod(seconds, 3600) / 60);
   local h = math.floor(seconds / 3600);

   return string.format('%d:%02d:%02d', h, m, s);

end

function TitanPanelPetInfoButton_GetPetExperience()

	local currentXP, totalXP = GetPetExperience();
	local toLevelXP = totalXP - currentXP;

	return currentXP, totalXP, toLevelXP;

end

function TitanPanelPetInfoButton_XPTimeLeft()

	local xpRate = TitanPanelPetInfoButton_GetXPRate()
	if (UnitLevel("pet") == UnitLevel("player")) then
		return TITAN_PETINFO_NOLEVEL1, TITAN_PETINFO_NOLEVEL2;
	else
		if xpRate then
			local timeString = TitanPanelPetInfoButton_GetTimeToLevel(xpRate);
			local xpPerMin = string.format('%.1f', xpRate * 60);
			return timeString, xpPerMin;
		else
			return "-:--:--", "0.0";
		end
	end

end

function TitanPanelPetInfoButton_OnXPUpdate()

   local xp = GetPetExperience();

	if uiLoaded then
		runningXP = xp;
		uiLoaded = false;
	else
      local xpChange = xp - runningXP;
      runningXP = xp;
		if xpChange > 0 then
			TitanPanelPetInfoButton_AddXPEntry(xpChange);
			TitanPanelPetInfoButton_RemoveOldXP();
		end
	end

end

function TitanPanelPetInfoButton_RemoveOldXP()
   local earliest = GetTime() - avgSpan * 60;
   while xpHistory[1] and xpHistory[1].time < earliest do
      table.remove(xpHistory, 1);
   end
   if xpHistory[1] then
      xpHistory[1].xpChange = 0;
   end
end

function TitanPanelPetInfoButton_AddXPEntry(xpChange)
   table.insert(xpHistory, {time = GetTime(), xpChange = xpChange});
end

function TitanPanelPetInfoButton_GetXPRate()

   if table.getn(xpHistory) <= 1 then
      return
   end

   local start   = xpHistory[1].time;
   local elapsed = GetTime() - start;

   if elapsed < 1 then
      return
   end

   local xpEarned = 0;

   for i,j in pairs(xpHistory) do
      xpEarned = xpEarned + j.xpChange;
   end

   return xpEarned / elapsed;

end

function TitanPanelPetInfoButton_GetTimeToLevel(xpRate)
	local currentXP, totalXP, toLevelXP = TitanPanelPetInfoButton_GetPetExperience();
	return TitanPanelPetInfoButton_SecondsToTime(tonumber(math.floor(toLevelXP / xpRate)));
end

function TitanPanelPetInfoButton_BarText(toLevelXP, timeLeft)
	local barText;
	if TitanGetVar(TITAN_PETINFO_ID, "ShowBarText") and isHunter then
		local ttl = timeLeft;
		if timeLeft == TITAN_PETINFO_NOLEVEL1 then
			ttl = "-:--:--"
		end
		barText = petName.."'s needed XP:"..toLevelXP.." TTL:"..ttl;
		return barText;
	else
		return
	end
end

--Actual pet DPS functions

function TitanPanelPetInfoButton_AddDPSEntry(length, damage)
	table.insert(dpsHistory, {time = GetTime(), length = length, damage = damage});
end

function TitanPanelPetInfoButton_AddDamageEntry(str)
	local dam = TitanPanelPetInfoButton_GetPetDamage(str);
	battleDamage = battleDamage + dam;
end

function TitanPanelPetInfoButton_GetPetDamage(str)
	local damage = 0;
	local sStart,sEnd = string.find(str, '%d+') ;

	if (sStart ~= nil) then
		damage = tonumber(string.sub(str,sStart,sEnd));
	end
	return damage;
end

function TitanPanelPetInfoButton_GetActualDPS()

	if table.getn(dpsHistory) < 1 then
		return "--";
	end

	local totalDam = 0;
	local elapsed = 0;

	for i,j in pairs(dpsHistory) do
		totalDam = totalDam + j.damage;
		elapsed = elapsed + j.length;
	end
	return format(TITAN_PETTINFO_DPS_FORMAT, totalDam / elapsed);

end

function TitanPanelPetInfoButton_RemoveOldDPS()
   local earliest = GetTime() - avgSpan * 60;
   while dpsHistory[1] and dpsHistory[1].time < earliest do
      table.remove(dpsHistory, 1);
   end
end

--Happiness functions

function TitanPanelPetInfoButton_GetHappyGain(arg1)
	local effect = 0;
	if string.find(arg1, '^'..petName..' .* Happiness') then
		effect = tonumber(string.find(arg1, '%d+'));
		happiness = happiness + effect;
		if effect < 35 then
			TitanPanelPetInfoButton_HappinessCalc();
		end
	end
end

function TitanPanelPetInfoButton_HappinessCalc()
	local loss = 0;
	
	loss = happiness / (GetTime() - happinessStart);
	--TPPIB_Debug(loss);
	happinessStart = 0
end

function TitanPanelPetInfoButton_HappinessCheck()
	if happinessStart > 0 then
		if (GetTime() - happinessStart > 60) and (GetTime() - happinessStart < 61) then
			PetFeeder_Feed();
		end
	end
end

--Debug function

function TPPIB_Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

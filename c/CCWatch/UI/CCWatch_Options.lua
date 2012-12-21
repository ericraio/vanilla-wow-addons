CCWatchEffectSelection = "";
local STATUS_COLOR = "|c000066FF";
local bModify = false;
local AR_DiagOpen = false;

local DisplayTable = {}

CCWatchConfig_SwatchFunc_SetColor =
{
	 ["Urge"]	= function(x) CCWatch_SetColorCallback("Urge") end,
	 ["Low"]	= function(x) CCWatch_SetColorCallback("Low") end,
	 ["Normal"]	= function(x) CCWatch_SetColorCallback("Normal") end,
	 ["Effect"]	= function(x) CCWatch_SetColorCallback("Effect") end,
}

CCWatchConfig_SwatchFunc_CancelColor =
{
	 ["Urge"]	= function(x) CCWatch_CancelColorCallback("Urge", x) end,
	 ["Low"]	= function(x) CCWatch_CancelColorCallback("Low", x) end,
	 ["Normal"]	= function(x) CCWatch_CancelColorCallback("Normal", x) end,
	 ["Effect"]	= function(x) CCWatch_CancelColorCallback("Effect", x) end,
}


--[[
function POBJI(k, v)
	local str = k.." : ";
	if type(v) ~= "table" and type(v) ~= "userdata" and type(v) ~= "function" and type(v) ~= "nil" then
		CCWatch_AddMessage(str..v);
	else
		str = str.."type = "..type(v);
		if type(v) == "table" then
			CCWatch_AddMessage(str.." -> ");
			POBJ(v);
		else
			CCWatch_AddMessage(str);
		end
	end
end

function POBJ(obj)
	table.foreach(obj, POBJI);
end
--]]

local function SetButtonPickerColor(button, color)
	getglobal(button.."_SwatchTexture"):SetVertexColor(color.r, color.g, color.b);
	getglobal(button.."_BorderTexture"):SetVertexColor(color.r, color.g, color.b);
	getglobal(button).r = color.r;
	getglobal(button).g = color.g;
	getglobal(button).b = color.b;
end

function CCWatch_DisableDropDown(dropDown)
	getglobal(dropDown:GetName().."Text"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(dropDown:GetName().."Button"):Disable();
end

function CCWatch_EnableDropDown(dropDown)
	getglobal(dropDown:GetName().."Text"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	getglobal(dropDown:GetName().."Button"):Enable();
end


function UpdateSortTable()
	DisplayTable = {}
	table.foreach(CCWATCH.CCS, function (k, v) table.insert(DisplayTable, k) end);
	table.sort(DisplayTable);
end

function CCWatchOptions_Toggle()
	if(CCWatchOptionsFrame:IsVisible()) then
		CCWatchOptionsFrame:Hide();
	else
		CCWatchOptionsFrame:Show();
	end
end


--------------------------------------------------------------------------------
-- Main Frame
--------------------------------------------------------------------------------

function CCWatchOptionsBarsTab_OnClick()
	CCWatchOptionsBarsFrame:Show();
	CCWatchOptionsEffectsFrame:Hide();
	CCWatchOptionsLearnFrame:Hide();

	PlaySound("igMainMenuOptionCheckBoxOn");
end

function CCWatchOptionsEffectsTab_OnClick()
	CCWatchOptionsBarsFrame:Hide();
	CCWatchOptionsEffectsFrame:Show();
	CCWatchOptionsLearnFrame:Hide();

	PlaySound("igMainMenuOptionCheckBoxOn");
end

function CCWatchOptionsLearnTab_OnClick()
	CCWatchOptionsBarsFrame:Hide();
	CCWatchOptionsEffectsFrame:Hide();
	CCWatchOptionsLearnFrame:Show();

	PlaySound("igMainMenuOptionCheckBoxOn");
end

function CCWatchOptionsBarsFrame_OnShow()
	CCWatchOptionsBarsTabTexture:Show();
	CCWatchOptionsBarsTab:SetBackdropBorderColor(1, 1, 1, 1);
end

function CCWatchOptionsEffectsFrame_OnShow()
	CCWatchOptionsEffectsTabTexture:Show();
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(1, 1, 1, 1);
end

function CCWatchOptionsLearnFrame_OnShow()
	CCWatchOptionsLearnTabTexture:Show();
	CCWatchOptionsLearnTab:SetBackdropBorderColor(1, 1, 1, 1);
end

function CCWatchOptionsBarsFrame_OnHide()
	CCWatchOptionsBarsTabTexture:Hide();
	CCWatchOptionsBarsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
end

function CCWatchOptionsEffectsFrame_OnHide()
	CCWatchOptionsEffectsTabTexture:Hide();
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
end

function CCWatchOptionsLearnFrame_OnHide()
	CCWatchOptionsLearnTabTexture:Hide();
	CCWatchOptionsLearnTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
end

--------------------------------------------------------------------------------
-- Bars Frame
--------------------------------------------------------------------------------

function CCWatchOptions_UnlockToggle()
	if CCWATCH.STATUS == 2 then
		CCWatch_BarLock();
		CCWatch_AddMessage(CCWATCH_LOCKED);
	else
		CCWatch_BarUnlock();
		CCWatch_AddMessage(CCWATCH_UNLOCKED);
	end
end

function CCWatchOptions_InvertToggle()
	CCWATCH.INVERT = not CCWATCH.INVERT;
	CCWatch_Save[CCWATCH.PROFILE].invert = CCWATCH.INVERT;
	if CCWATCH.INVERT then
		CCWatch_AddMessage(CCWATCH_INVERSION_ON);
	else
		CCWatch_AddMessage(CCWATCH_INVERSION_OFF);
	end
end

function CCWatchOptions_LeadingToggle()
	CCWATCH.LEADINGTIMER = not CCWATCH.LEADINGTIMER;
	CCWatch_Save[CCWATCH.PROFILE].LeadingTimer = CCWATCH.LEADINGTIMER;
	if CCWATCH.LEADINGTIMER then
		CCWatch_SetLeadingTimer(true);
		CCWatch_AddMessage(CCWATCH_LEADINGTIMER_ON);
	else
		CCWatch_SetLeadingTimer(false);
		CCWatch_AddMessage(CCWATCH_LEADINGTIMER_OFF);
	end
end

function CCWatchOptions_ColorOverTimeToggle()
	CCWATCH.COLOROVERTIME = not CCWATCH.COLOROVERTIME;
	CCWatch_Save[CCWATCH.PROFILE].ColorOverTime = CCWATCH.COLOROVERTIME;
	if CCWATCH.COLOROVERTIME then
		CCWatch_AddMessage(CCWATCH_COLOROVERTIME_ON);
	else
		CCWatch_AddMessage(CCWATCH_COLOROVERTIME_OFF);
	end
end

function CCWatchOptions_SetBarColorUrge()
	CCWatch_Save[CCWATCH.PROFILE].CoTUrgeValue = CCWatchOptionsBarColorUrgeEdit:GetNumber();
	CCWATCH.COTURGEVALUE = CCWatch_Save[CCWATCH.PROFILE].CoTUrgeValue;
end

function CCWatchOptions_SetBarColorLow()
	CCWatch_Save[CCWATCH.PROFILE].CoTLowValue = CCWatchOptionsBarColorLowEdit:GetNumber();
	CCWATCH.COTLOWVALUE = CCWatch_Save[CCWATCH.PROFILE].CoTLowValue;
end

function CCWatchGrowthDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsMenuGrowthDropDown";
	local info = { };

	info.text = CCWATCH_OPTION_GROWTH_OFF;
	info.value = "off";
	info.owner = this;
	info.func = CCWatchGrowthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_GROWTH_UP;
	info.value = "up";
	info.owner = this;
	info.func = CCWatchGrowthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = CCWATCH_OPTION_GROWTH_DOWN;
	info.value = "down";
	info.owner = this;
	info.func = CCWatchGrowthDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchTimersDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsMenuTimersDropDown";
	local info = { };

	info.text = CCWATCH_OPTION_TIMERS_OFF;
	info.value = "off";
	info.owner = this;
	info.func = CCWatchTimersDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_TIMERS_ON;
	info.value = "on";
	info.owner = this;
	info.func = CCWatchTimersDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = CCWATCH_OPTION_TIMERS_REVERSE;
	info.value = "reverse";
	info.owner = this;
	info.func = CCWatchTimersDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchGrowthDropDown_OnClick()
	if (this.value == "off") then
		CCWatch_Save[CCWATCH.PROFILE].growth = 0;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
		CCWatch_AddMessage(CCWATCH_GROW_OFF);
	elseif( this.value == "up" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 1;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
		CCWatch_AddMessage(CCWATCH_GROW_UP);
	elseif( this.value == "down" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 2;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
		CCWatch_AddMessage(CCWATCH_GROW_DOWN);
	end
end

function CCWatchTimersDropDown_OnClick()
	if (this.value == "off") then
		CCWatch_Save[CCWATCH.PROFILE].timers = 0;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_OFF);
		CCWatch_AddMessage(CCWATCH_TIMERS_OFF);
	elseif( this.value == "on" ) then
		CCWatch_Save[CCWATCH.PROFILE].timers = 1;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_ON);
		CCWatch_AddMessage(CCWATCH_TIMERS_ON);
	elseif( this.value == "reverse" ) then
		CCWatch_Save[CCWATCH.PROFILE].timers = 2;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_REVERSE);
		CCWatch_AddMessage(CCWATCH_TIMERS_REVERSE);
	end
end

--------------------------------------------------------------------------------
-- Monitor Frame
--------------------------------------------------------------------------------

function CCWatchOptions_MonitorCCToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_CC);
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING;
	if bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) == 0 then
		if bit.band(CCWATCH.MONITORING, ETYPE_CC) ~= 0 then
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		else
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		end
	end
end

function CCWatchOptions_MonitorDebuffToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_DEBUFF);
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING;
	if bit.band(CCWATCH.MONITORING, ETYPE_CC) == 0 then
		if bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF) ~= 0 then
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		else
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
			CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
		end
	end
end

function CCWatchOptions_MonitorBuffToggle()
	CCWATCH.MONITORING = bit.bxor(CCWATCH.MONITORING, ETYPE_BUFF);
	CCWatch_Save[CCWATCH.PROFILE].Monitoring = CCWATCH.MONITORING;
	if bit.band(CCWATCH.MONITORING, ETYPE_BUFF) ~= 0 then
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
		CCWatchObject:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	else
		CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
		CCWatchObject:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	end
end

function CCWatchOptions_ArcanistToggle()
	CCWATCH.ARCANIST = not CCWATCH.ARCANIST;
	CCWatch_Save[CCWATCH.PROFILE].arcanist = CCWATCH.ARCANIST;
	if CCWATCH.ARCANIST then
		CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH = CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH + 15;
		CCWatch_AddMessage(CCWATCH_ARCANIST_ON);
	else
		CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH = CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH - 15;
		CCWatch_AddMessage(CCWATCH_ARCANIST_OFF);
	end
	CCWatchOptionsFrameArcanist:SetChecked(CCWATCH.ARCANIST);
end

function CCWatchOptions_WarnAppliedToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_APPLIED);
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG;
	CCWatchOptionsFrameWarnApplied:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_APPLIED));
end

function CCWatchOptions_WarnFadedToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_FADED);
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG;
	CCWatchOptionsFrameWarnFaded:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_FADED));
end

function CCWatchOptions_WarnBrokenToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_BROKEN);
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG;
	CCWatchOptionsFrameWarnBroken:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_BROKEN));
end

function CCWatchOptions_WarnLowTimeToggle()
	CCWATCH.WARNMSG = bit.bxor(CCWATCH.WARNMSG, CCW_EWARN_LOWTIME);
	CCWatch_Save[CCWATCH.PROFILE].WarnMsg = CCWATCH.WARNMSG;
	CCWatchOptionsFrameWarnLowTime:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_LOWTIME));
end

function CCWatchOptions_SetWarnLow()
	CCWatch_Save[CCWATCH.PROFILE].WarnLow = CCWatchOptionsFrameWarnLowEdit:GetNumber();
	CCWATCH.WARNLOW = CCWatch_Save[CCWATCH.PROFILE].WarnLow;
end

function CCWatchOptionsStyleDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsStyleDropDown";
	local info = { };

	info.text = CCWATCH_OPTION_STYLE_CURRENT;
	info.value = "normal";
	info.owner = this;
	info.func = CCWatchOptionsStyleDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_STYLE_RECENT;
	info.value = "recent";
	info.owner = this;
	info.func = CCWatchOptionsStyleDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = CCWATCH_OPTION_STYLE_ALL;
	info.value = "all";
	info.owner = this;
	info.func = CCWatchOptionsStyleDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsStyleDropDown_OnClick()
	if (this.value == "normal") then
		CCWatch_Save[CCWATCH.PROFILE].style = 0;
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style;
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_CURRENT);
		CCWatch_AddMessage(CCWATCH_STYLE_CURRENT);
	elseif( this.value == "recent" ) then
		CCWatch_Save[CCWATCH.PROFILE].style = 1;
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style;
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_RECENT);
		CCWatch_AddMessage(CCWATCH_STYLE_RECENT);
	elseif( this.value == "all" ) then
		CCWatch_Save[CCWATCH.PROFILE].style = 2;
		CCWATCH.STYLE = CCWatch_Save[CCWATCH.PROFILE].style;
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_ALL);
		CCWatch_AddMessage(CCWATCH_STYLE_ALL);
	end
end


function CCWatchOptionsWarnCCDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsWarnCCDropDown";
	local info = { };

	info.text = "EMOTE";
	info.value = "EMOTE";
	info.owner = this;
	info.func = CCWatchOptionsWarnCCDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "SAY";
	info.value = "SAY";
	info.owner = this;
	info.func = CCWatchOptionsWarnCCDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = "PARTY";
	info.value = "PARTY";
	info.owner = this;
	info.func = CCWatchOptionsWarnCCDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "RAID";
	info.value = "RAID";
	info.owner = this;
	info.func = CCWatchOptionsWarnCCDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "YELL";
	info.value = "YELL";
	info.owner = this;
	info.func = CCWatchOptionsWarnCCDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "CHANNEL";
	info.value = "CHANNEL";
	info.owner = this;
	info.func = CCWatchOptionsWarnCCDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsWarnCCDropDown_OnClick()
	if (this.value == "EMOTE") or (this.value == "SAY") or (this.value == "PARTY") 
		or (this.value == "RAID") or (this.value == "YELL") or (this.value == "CHANNEL") then
		CCWatch_Save[CCWATCH.PROFILE].WarnType = this.value;
		CCWATCH.WARNTYPE = CCWatch_Save[CCWATCH.PROFILE].WarnType;
		CCWatchOptionsWarnCCDropDownText:SetText(this.value);
		if (this.value == "CHANNEL") then
			CCWatchOptionsFrameCustomCCEdit:Show();
		else
			CCWatchOptionsFrameCustomCCEdit:Hide();
		end
		CCWatch_AddMessage(CCWATCH_WARNCC_SETTO..this.value);
	end
end

function CCWatchOptions_SetCustomCC()
	CCWatch_Save[CCWATCH.PROFILE].WarnCustomCC = CCWatchOptionsFrameCustomCCEdit:GetText();
	CCWATCH.WARNCUSTOMCC = CCWatch_Save[CCWATCH.PROFILE].WarnCustomCC;
end

--------------------------------------------------------------------------------
-- Learn Frame
--------------------------------------------------------------------------------

function CCWatchOptions_MonitorToggle()
end

function CCWatchOptions_WarnToggle()
end

function CCWatchOptions_UseColorToggle()
	if CCWatchOptionsEffectUseColor:GetChecked() then
		CCWatchOptionsBarColorEffect:Enable();
	else
		CCWatchOptionsBarColorEffect:Disable();
	end
end

function CCWatchOptionsEffectTypeDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsEffectTypeDropDown";
	local info = { };

	info.text = "CC";
	info.value = "cc";
	info.owner = this;
	info.func = CCWatchOptionsEffectTypeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "DEBUFF";
	info.value = "debuff";
	info.owner = this;
	info.func = CCWatchOptionsEffectTypeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
	
	info.text = "BUFF";
	info.value = "buff";
	info.owner = this;
	info.func = CCWatchOptionsEffectTypeDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsEffectGroupDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsEffectGroupDropDown";
	local info = { };

	info.text = "1";
	info.value = "1";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "2";
	info.value = "2";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "3";
	info.value = "3";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "4";
	info.value = "4";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = "5";
	info.value = "5";
	info.owner = this;
	info.func = CCWatchOptionsEffectGroupDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsEffectDRDropDown_OnInit()
	UIDROPDOWNMENU_INIT_MENU = "CCWatch_OptionsEffectDRDropDown";
	local info = { };

	info.text = CCWATCH_OPTION_DR_NEVER;
	info.value = "0";
	info.owner = this;
	info.func = CCWatchOptionsEffectDRDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_DR_MOBPLAYERS;
	info.value = "1";
	info.owner = this;
	info.func = CCWatchOptionsEffectDRDropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info.text = CCWATCH_OPTION_DR_PLAYERS;
	info.value = "2";
	info.owner = this;
	info.func = CCWatchOptionsEffectDRDropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CCWatchOptionsEffectTypeDropDown_OnClick()
	if (this.value == "cc") then
		CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	elseif( this.value == "debuff" ) then
		CCWatchOptionsEffectTypeDropDownText:SetText("DEBUFF");
	elseif( this.value == "buff" ) then
		CCWatchOptionsEffectTypeDropDownText:SetText("BUFF");
	end
end

function CCWatchOptionsEffectDRDropDown_OnClick()
	if (this.value == "0") then
		CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_NEVER);
	elseif( this.value == "1") then
		CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_MOBPLAYERS);
	else
		CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_PLAYERS);
	end
end

function CCWatchOptionsEffectGroupDropDown_OnClick()
	CCWatchOptionsEffectGroupDropDownText:SetText(this.value);
end

function CCWatchOptionsLearnDelete_OnClick()
-- Pop alert to confirm deletion
	CCWatch_ShowDeletePrompt();
end


function CCWatchOptionsLearnClear_OnClick()
	CCWatchOptionsEffectNameEdit:SetText("");
	CCWatchOptionsEffectNameStatic:SetText("");
	CCWatchOptionsEffectDurationEdit:SetText("");
	CCWatchOptionsEffectDurationStatic:SetText("");

	CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	CCWatchOptionsEffectGroupDropDownText:SetText("1");
	CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_NEVER);
	CCWatchOptionsEffectMonitor:SetChecked(true);
	CCWatchOptionsEffectWarn:SetChecked(false);
	CCWatchOptionsEffectUseColor:SetChecked(false);
	CCWatchOptionsBarColorEffect:Disable();
	SetButtonPickerColor("CCWatchOptionsBarColorEffect", {r=0,g=0,b=0});

	CCWatchOptionsLearnModify:SetText("Add");
	bModify = false;

	CCWatch_EnableDropDown(CCWatchOptionsEffectTypeDropDown);
	CCWatch_EnableDropDown(CCWatchOptionsEffectGroupDropDown);
	CCWatch_EnableDropDown(CCWatchOptionsEffectDRDropDown);
	CCWatchOptionsEffectNameEdit:Show();
	CCWatchOptionsEffectDurationEdit:Show();
end

function CCWatchOptionsLearnModify_OnClick()
	local effect = CCWatchOptionsEffectNameEdit:GetText();
	local duration = CCWatchOptionsEffectDurationEdit:GetNumber();
	local group = CCWatchOptionsEffectGroupDropDownText:GetText();
	local stype = CCWatchOptionsEffectTypeDropDownText:GetText();
	local sdr = CCWatchOptionsEffectDRDropDownText:GetText();
	local monitor = CCWatchOptionsEffectMonitor:GetChecked();
	local warn = CCWatchOptionsEffectWarn:GetChecked();

	local color = {r=0, g=0, b=0};

	local etype;
	local edr;
	if stype == "BUFF" then
		etype = ETYPE_BUFF;
	elseif stype == "DEBUFF" then
		etype = ETYPE_DEBUFF;
	else
		etype = ETYPE_CC;
	end

	if dr == CCWATCH_OPTION_DR_NEVER then
		edr = 0;
	elseif sdr == CCWATCH_OPTION_DR_MOBPLAYERS then
		edr = 1;
	else
		edr = 2;
	end

	if effect == "" then
		message("Invalid Effect name");
		return;
	end
	if duration <= 0 then
		message("Invalid duration.");
		return;
	end

	if CCWatchOptionsEffectUseColor:GetChecked() then
		color.r = CCWatchOptionsBarColorEffect.r;
		color.g = CCWatchOptionsBarColorEffect.g;
		color.b = CCWatchOptionsBarColorEffect.b;
	else
		color = nil;
	end

	if bModify then
-- modifying
		-- check if existing custom effect
		if CCWatch_Save[CCWATCH.PROFILE].SavedCC[effect] ~= nil then
			if effect ~= CCWatchEffectSelection then -- skillname change...
				-- remove old effect
				CCWATCH.CCS[CCWatchEffectSelection] = nil;
				CCWatch_Save[CCWATCH.PROFILE].ConfCC[CCWatchEffectSelection] = nil;
				CCWatch_Save[CCWATCH.PROFILE].SavedCC[CCWatchEffectSelection] = nil;
			end
			-- add/update effect
			CCWatchAddEffect(false, effect, group, etype, duration, edr, monitor, warn, color);
		else -- if not we are modifying a builtin effect
			if effect ~= CCWatchEffectSelection then -- skillname change...
				message("WARNING : adding an effect require to select the NEW button");
			end
			CCWatchAddEffect(true, effect, group, etype, duration, edr, monitor, warn, color);
		end
	else
-- add
		if CCWATCH.CCS[effect] ~= nil then
			message("Effect '"..effect.."' already exist.\nPlease select Edit to modify it");
			return;
		else
			CCWatchAddEffect(false, effect, group, etype, duration, edr, monitor, warn, color);
		end
	end
	UpdateSortTable();	
	CCWatchOptionsEffects_Update();
	CCWatch_AddMessage(CCWATCH_EFFECT.." "..effect..CCWATCH_ADDEDMODIFIED);
end

--------------------------------------------------------------------------------
-- Custom effect management
--------------------------------------------------------------------------------

function CCWatchAddEffect(builtin, effect, group, etype, duration, diminishes, monitor, warn, color)
	local iWarn;
	if warn then
		iWarn = 1;
	else
		iWarn = 0;
	end
	CCWATCH.CCS[effect] = {
		GROUP = tonumber(group),
		ETYPE = etype,
		LENGTH = duration,
		DIMINISHES = diminishes,
		MONITOR = monitor,
		WARN = iWarn,
		COLOR = color,

		TARGET = "",
		PLAYER = nil,
		TIMER_START = 0,
		TIMER_END = 0,
		DIMINISH = 1
	};

	if builtin then
		CCWatch_Save[CCWATCH.PROFILE].ConfCC[effect] = {
			MONITOR = monitor,
			WARN = iWarn,
			COLOR = color
		};
	else
		CCWatch_Save[CCWATCH.PROFILE].SavedCC[effect] = {
			GROUP = tonumber(group),
			ETYPE = etype,
			LENGTH = duration,
			DIMINISHES = diminishes,
			MONITOR = monitor,
			WARN = iWarn,
			COLOR = color
		};
	end
end

function CCWatch_SetColorCallback(id)
	local iRed, iGreen, iBlue = ColorPickerFrame:GetColorRGB();
	local swatch, button, border;

	button = getglobal("CCWatchOptionsBarColor" .. id);
	swatch = getglobal("CCWatchOptionsBarColor" .. id .. "_SwatchTexture");
	border = getglobal("CCWatchOptionsBarColor" .. id .. "_BorderTexture");

	swatch:SetVertexColor(iRed, iGreen, iBlue);
	border:SetVertexColor(iRed, iGreen, iBlue);
	button.r = iRed;
	button.g = iGreen;
	button.b = iBlue;

	if id == "Urge" then
		CCWATCH.COTURGECOLOR.r = iRed;
		CCWATCH.COTURGECOLOR.g = iGreen;
		CCWATCH.COTURGECOLOR.b = iBlue;
		CCWatch_Save[CCWATCH.PROFILE].CoTUrgeColor = CCWATCH.COTURGECOLOR;
	elseif id == "Low" then
		CCWATCH.COTLOWCOLOR.r = iRed;
		CCWATCH.COTLOWCOLOR.g = iGreen;
		CCWATCH.COTLOWCOLOR.b = iBlue;
		CCWatch_Save[CCWATCH.PROFILE].CoTLowColor = CCWATCH.COTLOWCOLOR;
	elseif id == "Normal" then
		CCWATCH.COTNORMALCOLOR.r = iRed;
		CCWATCH.COTNORMALCOLOR.g = iGreen;
		CCWATCH.COTNORMALCOLOR.b = iBlue;
		CCWatch_Save[CCWATCH.PROFILE].CoTNormalColor = CCWATCH.COTNORMALCOLOR;
	end
end

function CCWatch_CancelColorCallback(id, prev)
	local iRed = prev.r;
	local iGreen = prev.g;
	local iBlue = prev.b;

	local swatch, button, border;

	button = getglobal("CCWatchOptionsBarColor" .. id);
	swatch = getglobal("CCWatchOptionsBarColor" .. id .. "_SwatchTexture");
	border = getglobal("CCWatchOptionsBarColor" .. id .. "_BorderTexture");
	
	swatch:SetVertexColor(iRed, iGreen, iBlue);
	border:SetVertexColor(iRed, iGreen, iBlue);
	button.r = iRed;
	button.g = iGreen;
	button.b = iBlue;
end



function CCWatchOptionsLearnFillFields()
	if CCWatchEffectSelection == nil then
		return;
	end

	-- check if builtin effect to disable editing
	if CCWatch_Save[CCWATCH.PROFILE].SavedCC[CCWatchEffectSelection] == nil then
		CCWatch_DisableDropDown(CCWatchOptionsEffectTypeDropDown);
		CCWatch_DisableDropDown(CCWatchOptionsEffectGroupDropDown);
		CCWatch_DisableDropDown(CCWatchOptionsEffectDRDropDown);
		-- hack because I have no other idea
		CCWatchOptionsEffectNameEdit:Hide();
		CCWatchOptionsEffectDurationEdit:Hide();
		CCWatchOptionsEffectNameStatic:SetText(CCWatchEffectSelection);
		CCWatchOptionsEffectDurationStatic:SetText(CCWATCH.CCS[CCWatchEffectSelection].LENGTH);
	else
		CCWatch_EnableDropDown(CCWatchOptionsEffectTypeDropDown);
		CCWatch_EnableDropDown(CCWatchOptionsEffectGroupDropDown);
		CCWatch_EnableDropDown(CCWatchOptionsEffectDRDropDown);
		CCWatchOptionsEffectNameEdit:Show();
		CCWatchOptionsEffectDurationEdit:Show();
		CCWatchOptionsEffectNameStatic:SetText("");
		CCWatchOptionsEffectDurationStatic:SetText("");
	end
	CCWatchOptionsEffectNameEdit:SetText(CCWatchEffectSelection);
	CCWatchOptionsEffectDurationEdit:SetText(CCWATCH.CCS[CCWatchEffectSelection].LENGTH);

	if CCWATCH.CCS[CCWatchEffectSelection].ETYPE == ETYPE_BUFF then
		CCWatchOptionsEffectTypeDropDownText:SetText("BUFF");
	elseif CCWATCH.CCS[CCWatchEffectSelection].ETYPE == ETYPE_DEBUFF then
		CCWatchOptionsEffectTypeDropDownText:SetText("DEBUFF");
	else
		CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	end
	CCWatchOptionsEffectGroupDropDownText:SetText(CCWATCH.CCS[CCWatchEffectSelection].GROUP);

	if CCWATCH.CCS[CCWatchEffectSelection].DIMINISHES == 0 then
		CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_NEVER);
	elseif CCWATCH.CCS[CCWatchEffectSelection].DIMINISHES == 1 then
		CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_MOBPLAYERS);
	else
		CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_PLAYERS);
	end

	CCWatchOptionsEffectMonitor:SetChecked(CCWATCH.CCS[CCWatchEffectSelection].MONITOR);
	local bFlag = CCWATCH.CCS[CCWatchEffectSelection].WARN > 0;
	CCWatchOptionsEffectWarn:SetChecked(bFlag);

	if CCWATCH.CCS[CCWatchEffectSelection].COLOR ~= nil then
		CCWatchOptionsEffectUseColor:SetChecked(true);
		CCWatchOptionsBarColorEffect:Enable();
		SetButtonPickerColor("CCWatchOptionsBarColorEffect", CCWATCH.CCS[CCWatchEffectSelection].COLOR);
	else
		CCWatchOptionsEffectUseColor:SetChecked(false);
		CCWatchOptionsBarColorEffect:Disable();
		SetButtonPickerColor("CCWatchOptionsBarColorEffect", {r=1,g=1,b=1});
	end

	bModify = true;
	CCWatchOptionsLearnModify:SetText("Modify");
end

function CCWatch_DeleteLearntEffect()
	CCWATCH.CCS[CCWatchEffectSelection] = nil;
--	CCWatch_Save[CCWATCH.PROFILE].SavedCC[CCWatchEffectSelection] = nil;
	CCWatch_Save[CCWATCH.PROFILE].SavedCC[CCWatchEffectSelection] = {}

	UpdateSortTable();
	CCWatchOptionsEffects_Update();
	CCWatch_OpenDiagToggle();

	CCWatch_AddMessage(CCWATCH_REMOVED_NOTICE..CCWatchEffectSelection..".");
	CCWatchEffectSelection = "";
end


function CCWatchOptions_OnLoad()
	UIPanelWindows['CCWatchOptionsFrame'] = {area = 'center', pushable = 1};
end

--------------------------------------------------------------------------------
-- Init
--------------------------------------------------------------------------------
function CCWatchOptions_Init()
	CCWatchSliderAlpha:SetValue(CCWATCH.ALPHA);
	CCWatchSliderScale:SetValue(CCWATCH.SCALE);
	CCWatchSliderWidth:SetValue(CCWATCH.WIDTH);

	CCWatchOptionsFrameMonitorCC:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_CC));
	CCWatchOptionsFrameMonitorDebuff:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_DEBUFF));
	CCWatchOptionsFrameMonitorBuff:SetChecked(bit.band(CCWATCH.MONITORING, ETYPE_BUFF));

	CCWatchOptionsFrameUnlock:SetChecked(CCWATCH.STATUS == 2);
	CCWatchOptionsFrameInvert:SetChecked(CCWATCH.INVERT);
	CCWatchOptionsFrameArcanist:SetChecked(CCWATCH.ARCANIST);
	CCWatchOptionsWarnCCDropDownText:SetText(CCWATCH.WARNTYPE);
	CCWatchOptionsFrameCustomCCEdit:SetText(CCWATCH.WARNCUSTOMCC);
	if CCWATCH.WARNTYPE == "CHANNEL" then
		CCWatchOptionsFrameCustomCCEdit:Show();
	else
		CCWatchOptionsFrameCustomCCEdit:Hide();
	end

	CCWatchOptionsEffectTypeDropDownText:SetText("CC");
	CCWatchOptionsEffectGroupDropDownText:SetText("1");
	CCWatchOptionsEffectDRDropDownText:SetText(CCWATCH_OPTION_DR_NEVER);
	CCWatchOptionsEffectMonitor:SetChecked(true);
	CCWatchOptionsEffectWarn:SetChecked(false);

	if CCWATCH.GROWTH == 0 then
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
	elseif CCWATCH.GROWTH == 1 then
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
	else
		CCWatchGrowthDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
	end

	if CCWATCH.TIMERS == 0 then
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_OFF);
	elseif CCWATCH.TIMERS == 1 then
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_ON);
	else
		CCWatchTimersDropDownText:SetText(CCWATCH_OPTION_TIMERS_REVERSE);
	end

	if CCWATCH.STYLE == 0 then
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_CURRENT);
	elseif CCWATCH.STYLE == 1 then
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_RECENT);
	else
		CCWatchOptionsStyleDropDownText:SetText(CCWATCH_OPTION_STYLE_ALL);
	end

	UpdateSortTable();
	CCWatchOptionsEffects_Update();

	CCWatchOptionsUseColorOverTime:SetChecked(CCWATCH.COLOROVERTIME);

	CCWatchOptionsBarColorUrge.swatchFunc = CCWatchConfig_SwatchFunc_SetColor["Urge"];
	CCWatchOptionsBarColorUrge.cancelFunc = CCWatchConfig_SwatchFunc_CancelColor["Urge"];
	CCWatchOptionsBarColorLow.swatchFunc = CCWatchConfig_SwatchFunc_SetColor["Low"];
	CCWatchOptionsBarColorLow.cancelFunc = CCWatchConfig_SwatchFunc_CancelColor["Low"];
	CCWatchOptionsBarColorNormal.swatchFunc = CCWatchConfig_SwatchFunc_SetColor["Normal"];
	CCWatchOptionsBarColorNormal.cancelFunc = CCWatchConfig_SwatchFunc_CancelColor["Normal"];

	CCWatchOptionsBarColorEffect.swatchFunc = CCWatchConfig_SwatchFunc_SetColor["Effect"];
	CCWatchOptionsBarColorEffect.cancelFunc = CCWatchConfig_SwatchFunc_CancelColor["Effect"];
	CCWatchOptionsBarColorEffect:Disable();

	SetButtonPickerColor("CCWatchOptionsBarColorUrge", CCWATCH.COTURGECOLOR);
	SetButtonPickerColor("CCWatchOptionsBarColorLow", CCWATCH.COTLOWCOLOR);
	SetButtonPickerColor("CCWatchOptionsBarColorNormal", CCWATCH.COTNORMALCOLOR);

	CCWatchOptionsFrameWarnApplied:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_APPLIED));
	CCWatchOptionsFrameWarnFaded:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_FADED));
	CCWatchOptionsFrameWarnBroken:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_BROKEN));
	CCWatchOptionsFrameWarnLowTime:SetChecked(bit.band(CCWATCH.WARNMSG, CCW_EWARN_LOWTIME));

	CCWatchOptionsFrameLeading:SetChecked(CCWATCH.LEADINGTIMER);

	CCWatchOptionsBarsFrame:Show();
	CCWatchOptionsEffectsTabTexture:Hide();
	CCWatchOptionsEffectsTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);
	CCWatchOptionsLearnTabTexture:Hide();
	CCWatchOptionsLearnTab:SetBackdropBorderColor(0.25, 0.25, 0.25, 1.0);

	CCWatchOptionsBarColorUrgeEdit:SetText(CCWATCH.COTURGEVALUE);
	CCWatchOptionsBarColorLowEdit:SetText(CCWATCH.COTLOWVALUE);
	CCWatchOptionsFrameWarnLowEdit:SetText(CCWATCH.WARNLOW);
end

--------------------------------------------------------------------------------
-- Scroll Frame functions
--------------------------------------------------------------------------------

local item;
local CCcount;
local curoffset;

local function EffectsUpdate(k, v)
	item = item + 1;
	if (curoffset > item) or ((item - curoffset) >= 11) then
		return;
	end

	local itemSlot = getglobal("CCWatchOptionsEffectsItem"..(item-curoffset+1));
	local name = v;
	if (name == CCWatchEffectSelection) then
		itemSlot:SetTextColor(1, 1, 0);
	else
		itemSlot:SetTextColor(1, 1, 1);
	end
	itemSlot:SetText(name);
	itemSlot:Show();
end

function CCWatchOptionsEffects_Update()
--	CCWatch_AddMessage("CCWatchOptionsEffects_Update");

	CCcount = 0;

	CCcount = table.getn(DisplayTable);

	FauxScrollFrame_Update(CCWatchOptionsEffectsListScrollFrame, CCcount, 11, 16);

	item = -1;
	curoffset = FauxScrollFrame_GetOffset(CCWatchOptionsEffectsListScrollFrame);
--	CCWatch_AddMessage("We're at "..curoffset);

	table.foreach(DisplayTable, EffectsUpdate);
end

-- Tooltip Window

function CCWatchOptionsEffects_OnEnter()
--	CCWatch_AddMessage("CCWatchOptionsEffects_OnEnter");
	
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");

	local spellname = this:GetText();
	if spellname == nil then
		return;
	end

	if CCWATCH.CCS[spellname] == nil then
		CCWatch_AddMessage("Error : '"..spellname.."' not found in effect array.");
		return;
	end
	local str = spellname.."\nDuration: "..CCWATCH.CCS[spellname].LENGTH.."\nType: ";
	if CCWATCH.CCS[spellname].ETYPE == ETYPE_BUFF then
		str = str.."Buff";
	elseif CCWATCH.CCS[spellname].ETYPE == ETYPE_DEBUFF then
		str = str.."DeBuff";
	else
		str = str.."CC";
	end
	str = str.."\nDR: ";
	if CCWATCH.CCS[spellname].DIMINISHES == 0 then
		str = str..CCWATCH_OPTION_DR_NEVER;
	elseif CCWATCH.CCS[spellname].DIMINISHES == 1 then
		str = str..CCWATCH_OPTION_DR_MOBPLAYERS;
	else
		str = str..CCWATCH_OPTION_DR_PLAYERS;
	end
	str = str.."\nMonitor: ";
	if CCWATCH.CCS[spellname].MONITOR then
		str = str.."on";
	else
		str = str.."off";
	end
	str = str.."\nWarn: ";
	if CCWATCH.CCS[spellname].WARN > 0 then
		str = str.."on";
	else
		str = str.."off";
	end

	GameTooltip:SetText(str, 1, 1, 1);
end


-- Confirm dialog frame

function CCWatch_OpenDiagToggle()
	if (CCWatch_DiagOpen) then
		CCWatch_DiagOpen = false;
	else
		CCWatch_DiagOpen = true;
	end
end

function CCWatch_ShowDeletePrompt(cost) 
	StaticPopupDialogs["CCWATCH_DELETE_EFFECT"] = {
		text = TEXT(STATUS_COLOR..CCWATCH_FULLVERSION.." (Elwen)\n\n\n"..CCWATCH_LEARN_DELETE_PROMPT.."'"..CCWatchEffectSelection.."' ?"),
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			CCWatch_DeleteLearntEffect();
		end,
		OnShow = function()
			CCWatch_OpenDiagToggle();
		end,
		OnHide = function()
			CCWatch_OpenDiagToggle();
		end,
		showAlert = 1,
		timeout = 0,
		exclusive = 0,
		whileDead = 1,
		interruptCinematic = 1
	};
	PlaySound("QUESTADDED");
	StaticPopup_Show("CCWATCH_DELETE_EFFECT");
end


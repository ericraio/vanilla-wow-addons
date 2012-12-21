function CCWatchOptions_Toggle()
	if(CCWatchOptionsFrame:IsVisible()) then
		CCWatchOptionsFrame:Hide();
	else
		CCWatchOptionsFrame:Show();
	end
end

function CCWatchOptions_MageCCToggle()
	local bState = not CCWATCH.MONITORMAGE;
	CCWATCH.MONITORMAGE = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorMage = bState;
	CCWATCH.CCS[CCWATCH_POLYMORPH].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FROSTNOVA].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FROSTBITE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_ICEBLOCK].MONITOR = bState;
end

function CCWatchOptions_PriestCCToggle()
	local bState = not CCWATCH.MONITORPRIEST;
	CCWATCH.MONITORPRIEST = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorPriest = bState;
	CCWATCH.CCS[CCWATCH_SHACKLE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_PSYCHICSCREAM].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BLACKOUT].MONITOR = bState;
end


function CCWatchOptions_DruidCCToggle()
	local bState = not CCWATCH.MONITORDRUID;
	CCWATCH.MONITORDRUID = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorDruid = bState;
	CCWATCH.CCS[CCWATCH_ROOTS].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_HIBERNATE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FERALCHARGE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_POUNCE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BASH].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPSTARFIRE].MONITOR = bState;
end

function CCWatchOptions_HunterCCToggle()
	local bState = not CCWATCH.MONITORHUNTER;
	CCWATCH.MONITORHUNTER = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorHunter = bState;
	CCWATCH.CCS[CCWATCH_FREEZINGTRAP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPCS].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SCAREBEAST].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SCATTERSHOT].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_INTIMIDATION].MONITOR = bState;
end

function CCWatchOptions_PaladinCCToggle()
	local bState = not CCWATCH.MONITORPALADIN;
	CCWATCH.MONITORPALADIN = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorPaladin = bState;
	CCWATCH.CCS[CCWATCH_HOJ].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_REPENTANCE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_TURNUNDEAD].MONITOR = bState;
end

function CCWatchOptions_WarlockCCToggle()
	local bState = not CCWATCH.MONITORWARLOCK;
	CCWATCH.MONITORWARLOCK = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorWarlock = bState;
	CCWATCH.CCS[CCWATCH_SEDUCE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_FEAR].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BANISH].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_HOWLOFTERROR].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_DEATHCOIL].MONITOR = bState;
end

function CCWatchOptions_WarriorCCToggle()
	local bState = not CCWATCH.MONITORWARRIOR;
	CCWATCH.MONITORWARRIOR = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorWarrior = bState;
	CCWATCH.CCS[CCWATCH_INTERCEPT].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_MACESPE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPHAMSTRING].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_INTIMIDATINGSHOUT].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_IMPREVENGE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_CONCUSSIONBLOW].MONITOR = bState;
end

function CCWatchOptions_RogueCCToggle()
	local bState = not CCWATCH.MONITORROGUE;
	CCWATCH.MONITORROGUE = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorRogue = bState;
	CCWATCH.CCS[CCWATCH_GOUGE].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_BLIND].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SAP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_KS].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_CS].MONITOR = bState;
end

function CCWatchOptions_MiscCCToggle()
	local bState = not CCWATCH.MONITORMISC;
	CCWATCH.MONITORMISC = bState;
	CCWatch_Save[CCWATCH.PROFILE].MonitorMisc = bState;
	CCWATCH.CCS[CCWATCH_WARSTOMP].MONITOR = bState;
	CCWATCH.CCS[CCWATCH_SLEEP].MONITOR = bState;
end

function CCWatchOptions_UnlockToggle()
	if CCWATCH.STATUS == 2 then
		CCWATCH.STATUS = 1;
		CCWatch:EnableMouse(0);
		CCWatchBar1:Hide();
		CCWatchBar2:Hide();
		CCWatchBar3:Hide();
		CCWatchBar4:Hide();
		CCWatchBar5:Hide();
		CCWatch_AddMessage(CCWATCH_LOCKED);
	else
		CCWATCH.STATUS = 2;
		CCWatch:EnableMouse(1);
		CCWatchBar1:Show();
		CCWatchBar2:Show();
		CCWatchBar3:Show();
		CCWatchBar4:Show();
		CCWatchBar5:Show();
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


function CCWatchOptions_OnLoad()
	UIPanelWindows['CCWatchOptionsFrame'] = {area = 'center', pushable = 0};
end

function CCWatchOptions_Init()
	CCWatchOptionsFrameMageCC:SetChecked(CCWATCH.MONITORMAGE);
	CCWatchOptionsFramePriestCC:SetChecked(CCWATCH.MONITORPRIEST);
	CCWatchOptionsFrameDruidCC:SetChecked(CCWATCH.MONITORDRUID);
	CCWatchOptionsFrameHunterCC:SetChecked(CCWATCH.MONITORHUNTER);
	CCWatchOptionsFramePaladinCC:SetChecked(CCWATCH.MONITORPALADIN);
	CCWatchOptionsFrameWarlockCC:SetChecked(CCWATCH.MONITORWARLOCK);
	CCWatchOptionsFrameWarriorCC:SetChecked(CCWATCH.MONITORWARRIOR);
	CCWatchOptionsFrameRogueCC:SetChecked(CCWATCH.MONITORROGUE);
	CCWatchOptionsFrameMiscCC:SetChecked(CCWATCH.MONITORMISC);
	CCWatchSliderAlpha:SetValue(CCWATCH.ALPHA);
	CCWatchSliderScale:SetValue(CCWATCH.SCALE);
	CCWatchSliderWidth:SetValue(CCWATCH.WIDTH);

	CCWatchOptionsFrameUnlock:SetChecked(CCWATCH.STATUS == 2);
	CCWatchOptionsFrameInvert:SetChecked(CCWATCH.INVERT);
	CCWatchOptionsFrameArcanist:SetChecked(CCWATCH.ARCANIST);
	if CCWATCH.ARCANIST then
		CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH = CCWATCH.CCS[CCWATCH_POLYMORPH].LENGTH + 15;
	end

	if CCWATCH.GROWTH == 0 then
		CCWatchGrowthSelectDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
	elseif CCWATCH.GROWTH == 1 then
		CCWatchGrowthSelectDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
	else
		CCWatchGrowthSelectDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
	end

	if CCWATCH.TIMERS == 0 then
		CCWatchTimersSelectDropDownText:SetText(CCWATCH_OPTION_TIMERS_OFF);
	elseif CCWATCH.TIMERS == 1 then
		CCWatchTimersSelectDropDownText:SetText(CCWATCH_OPTION_TIMERS_ON);
	else
		CCWatchTimersSelectDropDownText:SetText(CCWATCH_OPTION_TIMERS_REVERSE);
	end

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
		CCWatchGrowthSelectDropDownText:SetText(CCWATCH_OPTION_GROWTH_OFF);
		CCWatch_AddMessage(CCWATCH_GROW_OFF);
	elseif( this.value == "up" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 1;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthSelectDropDownText:SetText(CCWATCH_OPTION_GROWTH_UP);
		CCWatch_AddMessage(CCWATCH_GROW_UP);
	elseif( this.value == "down" ) then
		CCWatch_Save[CCWATCH.PROFILE].growth = 2;
		CCWATCH.GROWTH = CCWatch_Save[CCWATCH.PROFILE].growth;
		CCWatchGrowthSelectDropDownText:SetText(CCWATCH_OPTION_GROWTH_DOWN);
		CCWatch_AddMessage(CCWATCH_GROW_DOWN);
	end
end


function CCWatchTimersDropDown_OnClick()
	if (this.value == "off") then
		CCWatch_Save[CCWATCH.PROFILE].timers = 0;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersSelectDropDownText:SetText(CCWATCH_OPTION_TIMERS_OFF);
		CCWatch_AddMessage(CCWATCH_TIMERS_OFF);
	elseif( this.value == "on" ) then
		CCWatch_Save[CCWATCH.PROFILE].timers = 1;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersSelectDropDownText:SetText(CCWATCH_OPTION_TIMERS_ON);
		CCWatch_AddMessage(CCWATCH_TIMERS_ON);
	elseif( this.value == "reverse" ) then
		CCWatch_Save[CCWATCH.PROFILE].timers = 2;
		CCWATCH.TIMERS = CCWatch_Save[CCWATCH.PROFILE].timers;
		CCWatchTimersSelectDropDownText:SetText(CCWATCH_OPTION_TIMERS_REVERSE);
		CCWatch_AddMessage(CCWATCH_TIMERS_REVERSE);
	end
end

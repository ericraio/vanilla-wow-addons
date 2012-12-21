function DAB_Main_OnEvent()
	if (not DAB_INITIALIZED) then return; end
	if (event == "ACTIONBAR_HIDEGRID") then
		DiscordActionBarsFrame.updatenewactions = .1;
	elseif (event == "ACTIONBAR_SHOWGRID") then
		DiscordActionBarsFrame.updatenewactions = nil;
		DAB_SHOWING_EMPTY = true;
		for i=1,10 do
			if (DAB_Settings[DAB_INDEX].Bar[i].hideEmpty) then
				DAB_Bar_Update(i);
			end
			if (DAB_Settings[DAB_INDEX].Bar[i].expandHidden) then
				local bar = getglobal("DAB_ActionBar_"..i);
				DAB_Bar_FauxShow(i);
				bar:Show();
				bar.activeConditions = {};
				local page = DAB_Settings[DAB_INDEX].Bar[i].page;
				if (bar.pagemap[page]) then
					page = bar.pagemap[page];
				end
				for b=1,120 do
					if (DAB_Settings[DAB_INDEX].Buttons[b].Bar == i) then
						local button = getglobal("DAB_ActionButton_"..b);
						DAB_ActionButton_FauxShow(b);
						DAB_ActionButton_Show(b);
						button.activeConditions = {};
					end
				end
			end
			for b in DAB_Settings[DAB_INDEX].Floaters do
				if (DAB_Settings[DAB_INDEX].Floaters[b].expandHidden) then
					local button = getglobal("DAB_ActionButton_"..b);
					DAB_ActionButton_FauxShow(b);
					DAB_ActionButton_Show(b);
					button.activeConditions = {};
				end
			end
		end
	--elseif (event == "ACTIONBAR_SLOT_CHANGED") then
		--DiscordActionBarsFrame.updateactionlist = .5;
	elseif (event == "DISPLAY_SIZE_CHANGED") then
		DL_Debug("Size changed.  Updating DAB settings.");
		DAB_Initialize_Everything();
	elseif (event == "UPDATE_SHAPESHIFT_FORMS") then
		DAB_OTHER_BAR[12][0].numButtons = GetNumShapeshiftForms();
		DAB_OtherBar_Initialize(12);
		DL_Update_Forms();
	elseif (event == "UNIT_PET" and arg1 == "player") then
		if (PetHasActionBar()) then
			DAB_OtherBar_Pet.nopet = nil;
			DAB_OtherBar_Pet:Show();
			DAB_OtherBar_Pet.mouseover = 1;
		else
			DAB_OtherBar_Pet.nopet = true;
			DAB_OtherBar_Pet:Hide();
		end
	--elseif (event == "PLAYER_AURAS_CHANGED") then
		--DiscordActionBarsFrame.updateactionlist = nil;
	end
end

function DAB_Main_OnLoad()
	DiscordLib_RegisterInitFunc(DAB_Initialize);

	SlashCmdList["DAB"] = DAB_Slash_Handler;
	SLASH_DAB1 = "/dab";
	SLASH_DAB2 = "/discordactionbars";

	this:RegisterEvent("ACTIONBAR_HIDEGRID");
	this:RegisterEvent("ACTIONBAR_SHOWGRID");
	--this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	this:RegisterEvent("DISPLAY_SIZE_CHANGED");
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
	this:RegisterEvent("UNIT_PET");
	--this:RegisterEvent("PLAYER_AURAS_CHANGED");
	--this:RegisterEvent("");
end

function DAB_Add_AutoCast(actionID, unit)
	if (not DAB_AUTOCAST_QUEUE) then
		DAB_AUTOCAST_QUEUE = {};
	end
	for i in DAB_AUTOCAST_QUEUE  do
		if (DAB_AUTOCAST_QUEUE[i].a == actionID and DAB_AUTOCAST_QUEUE[i].u == unit) then
			return;
		end
	end
	tinsert(DAB_AUTOCAST_QUEUE, {a=actionID, u=unit});
end

function DAB_AutoCast()
	if (DAB_AUTOCAST_QUEUE and DAB_AUTOCAST_QUEUE[1]) then
		local max = table.getn(DAB_AUTOCAST_QUEUE);
		local usableAction;
		for i=1, max do
			if (DL_ActionUsable(DAB_AUTOCAST_QUEUE[i].a)) then
				usableAction = i;
				break;
			end
		end
		if (not usableAction) then return; end
		local hadTarget;
		if ( (not UnitCanAttack("player", "target")) and UnitName("target") ) then
			hadTarget = true;
			TargetUnit(DAB_AUTOCAST_QUEUE[usableAction].u);
		end
		UseAction(DAB_AUTOCAST_QUEUE[usableAction].a);
		if (hadTarget) then
			TargetLastTarget();
		elseif (DAB_AUTOCAST_QUEUE[usableAction].u) then
			SpellTargetUnit(DAB_AUTOCAST_QUEUE[usableAction].u);
		end
		tremove(DAB_AUTOCAST_QUEUE, usableAction);
	end
end

function DAB_BonusCooldown_OnUpdate(elapsed)
	if (this.cooldowncount) then
		this.cooldowncount = this.cooldowncount - elapsed;
		if (this.cooldowncount <= 0) then
			this.cooldowncount = nil;
			getglobal(this:GetName().."_Text"):SetText("");
		else
			local count = math.ceil(this.cooldowncount);
			if (DAB_Settings[DAB_INDEX].CDFormat == 1) then
				if (count < 60) then
					getglobal(this:GetName().."_Text"):SetText(count);
				else
					count = math.ceil(count / 60);
					getglobal(this:GetName().."_Text"):SetText(count.."m");
				end
			elseif (DAB_Settings[DAB_INDEX].CDFormat == 2) then
				getglobal(this:GetName().."_Text"):SetText(count);
			else
				local min = math.floor(count / 60);
				local sec = count - min * 60;
				if (min < 10) then
					min = "0"..min;
				end
				if (sec < 10) then
					sec = "0"..sec;
				end
				getglobal(this:GetName().."_Text"):SetText(min..":"..sec);
			end
		end
	end
end

function DAB_Check_ModifierKey(index)
	if (index == 0) then
		return;
	elseif (index == 1) then
		return IsAltKeyDown();
	elseif (index == 2) then
		return IsControlKeyDown();
	else
		return IsShiftKeyDown();
	end
end

function DAB_EventMacro_Compile()
	for _, v in DAB_EVENTS do
		DAB_EventMacroFrame:UnregisterEvent(v.value);
	end
	for event, script in DAB_Settings[DAB_INDEX].EventMacros do
		setglobal("DAB_EventMacros_"..event, nil);
		if (script and script ~= "") then
			DAB_EventMacroFrame:RegisterEvent(event);
			RunScript("function DAB_EventMacros_"..event.."(arg1, arg2, arg3, arg4, arg5)\n"..script.."\nend");
		elseif (script == "") then
			DAB_Settings[DAB_INDEX].EventMacros[event] = nil;
		end
	end
	if (DAB_VL_CHANGED) then
		DAB_VL_CHANGED = nil;
		if (DAB_EventMacros_VARIABLES_LOADED) then
			DAB_EventMacros_VARIABLES_LOADED();
		end
	end
end

function DAB_EventMacro_OnEvent(event)
	if (not DAB_INITIALIZED) then return; end
	if (DAB_EDITTING_MACRO) then return; end
	if (getglobal("DAB_EventMacros_"..event)) then
		getglobal("DAB_EventMacros_"..event)(arg1, arg2, arg3, arg4, arg5);
	end
end

function DAB_EventMacro_Update()
	if (DAB_MACRO_EVENT) then
		DAB_Settings[DAB_INDEX].EventMacros[DAB_MACRO_EVENT] = DAB_OnEventMacros_EditBox_Text:GetText();
		DAB_Update_EventList();
	end
	if (DAB_MACRO_EVENT == "VARIABLES_LOADED") then
		DAB_VL_CHANGED = true;
	end
end

function DAB_EventMacro_OnUpdate(elapsed)
	if (not DAB_INITIALIZED) then return; end
	if (DAB_EDITTING_MACRO) then return; end
	if (not DAB_EventMacros_OnUpdate) then return; end
	if (not this.timer) then
		this.timer = DAB_UPDATE_SPEED;
		this.lasttime = GetTime();
	end
	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = DAB_UPDATE_SPEED;
		local time = GetTime();
		local trueelapsed = time - this.lasttime;
		this.lasttime = time;
		DAB_EventMacros_OnUpdate(trueelapsed);
	end
end

function DAB_Get_ActionName(id)
	if (not id) then return ""; end
	if (not HasAction(id)) then return ""; end
	DiscordLib_Tooltip:SetAction(id);
	local name, rank = "", "";
	if (DiscordLib_TooltipTextLeft1:IsShown()) then
		name = DiscordLib_TooltipTextLeft1:GetText();
	end
	if (DiscordLib_TooltipTextRight1:IsShown()) then
		rank = DiscordLib_TooltipTextRight1:GetText();
	end
	if (rank == "") then
		return name;
	else
		return name.." ("..rank..")";
	end
end

function DAB_Get_BarButtonID(bar, page, loc)
	local count = 0;
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			count = count + 1;
			if (count == loc) then
				return i;
			end
		end
	end
end

function DAB_Get_MatchingButton(bar, button, bar2)
	if (bar == bar2) then return button; end
	local count = 0;
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			count = count + 1;
			if (i == button) then break; end
		end
	end
	local count2 = 0
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar2) then
			count2 = count2 + 1;
			if (count2 == count) then return i; end
		end
	end
	return getglobal("DAB_ActionButton_"..button):GetID();
end

function DAB_Global_Response(response, values)
	if (response == 100) then
		DL_Feedback(values.rtext);
	elseif (response == 101) then
		UIErrorsFrame:AddMessage(values.rtext, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	elseif (response == 102) then
		DAB_Bar_FauxHide(values.rnumber);
	elseif (response == 103) then
		DAB_Bar_FauxShow(values.rnumber);
		DAB_Bar_Show(values.rnumber);
	elseif (response == 104) then
		DAB_ControlBox_Hide(values.rnumber);
	elseif (response == 105) then
		DAB_ControlBox_Show(values.rnumber);
	elseif (response == 106) then
		DAB_ActionButton_FauxHide(values.rnumber);
	elseif (response == 107) then
		DAB_ActionButton_FauxShow(values.rnumber);
		DAB_Floater_Show(values.rnumber);
	elseif (response == 108) then
		setglobal(values.rtext, false);
	elseif (response == 109) then
		setglobal(values.rtext, true);
	elseif (response == 110) then
		DAB_Add_AutoCast(values.raction, values.runit);
	elseif (response == 111) then
		for index, value in DAB_AUTOCAST_QUEUE do
			if (DAB_AUTOCAST_QUEUE.a == values.raction) then
				tremove(DAB_AUTOCAST_QUEUE, index);
			end
		end
	elseif (response == 112) then
		SpellStopCasting();
	elseif (response == 113) then
		DL_Set_Timer(values.rtext, values.rnumber);
	elseif (response == 114) then
		PlaySoundFile(values.rtext);
	elseif (response == 115) then
		RunScript(values.rtext);
	end
end

function DAB_Hide_Group(group)
	for i=1,10 do
		if (DAB_Settings[DAB_INDEX].Bar[i].cbgroup == group) then
			DAB_Bar_Hide(i);
		end
		if (DAB_Settings[DAB_INDEX].ControlBox[i].cbgroup == group) then
			DAB_ControlBox_Hide(i);
		end
	end
	for i=11,14 do
		if (DAB_Settings[DAB_INDEX].OtherBar[i].cbgroup == group) then
			DAB_OtherBar_Hide(i);
		end
	end
	for b in DAB_Settings[DAB_INDEX].Floaters do
		if (DAB_Settings[DAB_INDEX].Floaters[b].cbgroup == group) then
			DAB_Floater_Hide(b);
		end
	end
end

function DAB_KeybindingDown(id)
	if (not DAB_INITIALIZED) then return; end
	local kb = DAB_Settings[DAB_INDEX].Keybindings[id];
	if (not kb.down) then return; end
	if (kb.option == 0) then return; end
	if (kb.option == 1 or kb.option == 10) then
		local button = DAB_Get_BarButtonID(kb.suboption, page, kb.suboption2);
		if (button) then
			local selfcast;
			if (kb.option == 10) then
				selfcast = 1;
			end
			DAB_Run_Script("OnKeybindingDownBefore", "Bar", kb.suboption, button);
			DAB_ActionButton_OnClick(button, "LeftButton", 1, selfcast);
			DAB_Run_Script("OnKeybindingDownAfter", "Bar", kb.suboption, button);
		end
	elseif (kb.option == 2) then
		if (not DAB_Settings[DAB_INDEX].KBGroups[kb.suboption]) then return; end
		local bar = DAB_Settings[DAB_INDEX].KBGroups[kb.suboption];
		local button = DAB_Get_BarButtonID(bar, page, kb.suboption2);
		if (button) then
			DAB_Run_Script("OnKeybindingDownBefore", "Bar", bar, button);
			DAB_ActionButton_OnClick(button, "LeftButton", 1);
			DAB_Run_Script("OnKeybindingDownAfter", "Bar", bar, button);
		end
	elseif (kb.option == 3 or kb.option == 11) then
		local selfcast;
		if (kb.option == 11) then
			selfcast = 1;
		end
		DAB_Run_Script("OnKeybindingDownBefore", "Floaters", kb.suboption);
		DAB_ActionButton_OnClick(kb.suboption, "LeftButton", 1, selfcast);
		DAB_Run_Script("OnKeybindingDownAfter", "Floaters", kb.suboption);
	elseif (kb.option == 4) then
		DAB_Run_Script("OnKeybindingDownBefore", "ControlBox", kb.suboption);
		DAB_ControlBox_KeybindingDown(kb.suboption);
		DAB_Run_Script("OnKeybindingDownAfter", "ControlBox", kb.suboption);
	elseif (kb.option == 5) then
		DAB_Set_KeybindingGroup(kb.suboption, kb.suboption2);
	elseif (kb.option == 6) then
		DAB_Bar_SetPage(kb.suboption, kb.suboption2);
	elseif (kb.option == 7) then
		DAB_Bar_PageUp(kb.suboption);
	elseif (kb.option == 8) then
		DAB_Bar_PageDown(kb.suboption);
	elseif (kb.option == 9) then
		DAB_VariableKeybinding_Down(kb.suboption);
	elseif (kb.option == 12) then
		local _, _, bar, page = string.find(kb.suboption, "(%d*)_(%d*)");
		bar = tonumber(bar);
		page = tonumber(page);
		page = DAB_Bar_GetRealPage(bar, page);
		local button = DAB_Get_BarButtonID(bar, page, kb.suboption2);
		if (button) then
			local action = DAB_Settings[DAB_INDEX].Bar[bar].pages[page][kb.suboption2];
			DAB_Run_Script("OnKeybindingDownBefore", "Bar", bar, button);
			DAB_ActionButton_OnClick(button, "LeftButton", 1, nil, action);
			DAB_Run_Script("OnKeybindingDownAfter", "Bar", bar, button);
		end
	elseif (kb.option == 13) then
		UseAction(kb.suboption);
	elseif (kb.option == 14) then
		local retarget;
		if (UnitName("target") and (not UnitCanAttack("player", "target")) and (not UnitIsUnit("player", "target"))) then
			retarget = 1;
			TargetUnit("player");
		end
		UseAction(kb.suboption);
		if (SpellIsTargeting()) then
			SpellTargetUnit("player");
		elseif (retarget) then
			TargetLastTarget();
		end
	end
end

function DAB_KeybindingUp(id)
	if (not DAB_INITIALIZED) then return; end
	local kb = DAB_Settings[DAB_INDEX].Keybindings[id];
	if (not kb.up) then return; end
	if (kb.option == 0) then return; end
	if (kb.option == 1 or kb.option == 10) then
		local selfcast;
		if (kb.option == 10) then
			selfcast = 1;
		end
		local button = DAB_Get_BarButtonID(kb.suboption, page, kb.suboption2);
		if (button) then
			DAB_Run_Script("OnKeybindingUpBefore", "Bar", kb.suboption, button);
			DAB_ActionButton_OnClick(button, "LeftButton", 2, selfcast);
			DAB_Run_Script("OnKeybindingUpAfter", "Bar", kb.suboption, button);
		end
	elseif (kb.option == 2) then
		if (not DAB_Settings[DAB_INDEX].KBGroups[kb.suboption]) then return; end
		local bar = DAB_Settings[DAB_INDEX].KBGroups[kb.suboption];
		local button = DAB_Get_BarButtonID(bar, page, kb.suboption2);
		if (button) then
			DAB_Run_Script("OnKeybindingUpBefore", "Bar", bar, button);
			DAB_ActionButton_OnClick(button, "LeftButton", 2);
			DAB_Run_Script("OnKeybindingUpAfter", "Bar", bar, button);
		end
	elseif (kb.option == 3 or kb.option == 11) then
		local selfcast;
		if (kb.option == 11) then
			selfcast = 1;
		end
		DAB_Run_Script("OnKeybindingUpBefore", "Floaters", kb.suboption);
		DAB_ActionButton_OnClick(kb.suboption, "LeftButton", 2, selfcast);
		DAB_Run_Script("OnKeybindingUpAfter", "Floaters", kb.suboption);
	elseif (kb.option == 4) then
		DAB_Run_Script("OnKeybindingUpBefore", "ControlBox", kb.suboption);
		DAB_ControlBox_KeybindingDown(kb.suboption);
		DAB_Run_Script("OnKeybindingUpAfter", "ControlBox", kb.suboption);
	elseif (kb.option == 5) then
		DAB_Set_KeybindingGroup(kb.suboption, kb.suboption2);
	elseif (kb.option == 6) then
		DAB_Bar_SetPage(kb.suboption, kb.suboption2);
	elseif (kb.option == 7) then
		DAB_Bar_PageUp(kb.suboption);
	elseif (kb.option == 8) then
		DAB_Bar_PageDown(kb.suboption);
	elseif (kb.option == 9) then
		DAB_VariableKeybinding_Up(kb.suboption);
	elseif (kb.option == 12) then
		local _, _, bar, page = string.find(kb.suboption, "(%d*)_(%d*)");
		bar = tonumber(bar);
		page = tonumber(page);
		page = DAB_Bar_GetRealPage(bar, page);
		local button = DAB_Get_BarButtonID(bar, page, kb.suboption2);
		if (button) then
			local action = DAB_Settings[DAB_INDEX].Bar[bar].pages[page][kb.suboption2];
			DAB_Run_Script("OnKeybindingUpBefore", "Bar", bar, button);
			DAB_ActionButton_OnClick(button, "LeftButton", 2);
			DAB_Run_Script("OnKeybindingUpAfter", "Bar", bar, button);
		end
	elseif (kb.option == 13) then
		UseAction(kb.suboption);
	elseif (kb.option == 14) then
		local retarget;
		if (UnitName("target") and (not UnitCanAttack("player", "target")) and (not UnitIsUnit("player", "target"))) then
			retarget = 1;
			TargetUnit("player");
		end
		UseAction(kb.suboption);
		if (SpellIsTargeting()) then
			SpellTargetUnit("player");
		elseif (retarget) then
			TargetLastTarget();
		end
	end
end

function DAB_PetCooldown_OnEvent()
	if (not DAB_INITIALIZED) then return; end

	local id = this:GetID();
	local start, duration, enable = GetPetActionCooldown(id);
	local cdcount = DAB_Settings[DAB_INDEX].OtherBar[11].cooldownCount;
	local hideGlobal = DAB_Settings[DAB_INDEX].OtherBar[11].hideGlobalCD;
	if (cdcount and getglobal(this:GetParent():GetName().."Cooldown"):IsShown()) then
		if (start and start > 0) then
			local timeRemaining = duration - (GetTime() - start);
			if (((not this.cooldowncount) or this.cooldowncount == 0) and timeRemaining <= 2.5 and hideGlobal) then
				this.cooldowncount = 0;
			else
				this.cooldowncount = timeRemaining;
			end
		else
			this.cooldowncount = 0;
		end
	end
end

function DAB_Run_Script(script, object, index, param)
	if (getglobal("DAB_"..object.."_"..index.."_"..script)) then
		getglobal("DAB_"..object.."_"..index.."_"..script)(param);
	end
end

function DAB_Save_Keybindings()
	if (not DAB_INITIALIZED) then return; end
	for i=1,120 do
		local key1, key2 = GetBindingKey("DAB_"..i);
		DAB_Settings[DAB_INDEX].Keybindings[i].key1 = key1;
		DAB_Settings[DAB_INDEX].Keybindings[i].key2 = key2;
	end
end

function DAB_Set_KeybindingGroup(group, bar)
	local oldBar = DAB_Settings[DAB_INDEX].KBGroups[group];
	if (bar == oldBar) then return; end
	DAB_Unset_KeybindingGroup(group);
	for k=1,120 do
		local option = DAB_Settings[DAB_INDEX].Keybindings[k].option;
		local kbgroup = DAB_Settings[DAB_INDEX].Keybindings[k].suboption;
		local buttonLoc = DAB_Settings[DAB_INDEX].Keybindings[k].suboption2;
		if (option == 2 and kbgroup == group) then
			local kbtext = DL_Get_KeybindingText("DAB_"..k, nil, 1);
			for page=1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
				local realPage = DAB_Bar_GetRealPage(bar, page);
				local button = DAB_Get_BarButtonID(bar, realPage, buttonLoc);
				if (button) then
					if (kbtext == "" or (not kbtext)) then
						kbtext = getglobal("DAB_ActionButton_"..button).basekb;
					end
					getglobal("DAB_ActionButton_"..button.."_HotKey"):SetText(kbtext);
				end
			end
		end
	end
	DAB_Settings[DAB_INDEX].KBGroups[group] = bar;
end

function DAB_ShapeshiftCooldown_OnEvent()
	if (not DAB_INITIALIZED) then return; end

	local id = this:GetID();
	local start, duration, enable = GetShapeshiftFormCooldown(id);
	local cdcount = DAB_Settings[DAB_INDEX].OtherBar[12].cooldownCount;
	local hideGlobal = DAB_Settings[DAB_INDEX].OtherBar[12].hideGlobalCD;
	if (cdcount and getglobal(this:GetParent():GetName().."Cooldown"):IsShown()) then
		if (start and start > 0) then
			local timeRemaining = duration - (GetTime() - start);
			if (((not this.cooldowncount) or this.cooldowncount == 0) and timeRemaining <= 2.5 and hideGlobal) then
				this.cooldowncount = 0;
			else
				this.cooldowncount = timeRemaining;
			end
		else
			this.cooldowncount = 0;
		end
	end
end

function DAB_Show_Group(group)
	for i=1,10 do
		if (DAB_Settings[DAB_INDEX].Bar[i].cbgroup == group) then
			DAB_Bar_Show(i);
			DAB_Bar_FauxShow(i);
		end
		if (DAB_Settings[DAB_INDEX].ControlBox[i].cbgroup == group) then
			DAB_ControlBox_Show(i);
		end
	end
	for i=11,14 do
		if (DAB_Settings[DAB_INDEX].OtherBar[i].cbgroup == group) then
			DAB_OtherBar_Show(i);
		end
	end
	for b in DAB_Settings[DAB_INDEX].Floaters do
		if (DAB_Settings[DAB_INDEX].Floaters[b].cbgroup == group) then
			DAB_Floater_Show(b);
			DAB_ActionButton_FauxShow(b);
		end
	end
end

function DAB_Slash_Handler(msg)
	local command, param;
	local index = string.find(msg, " ");

	if( index) then
		command = string.sub(msg, 1, (index - 1));
		param = string.sub(msg, (index + 1)  );
	else
		command = msg;
	end

	if ( command == "" ) then
		DAB_Toggle_Options();
	elseif (command == "clearbar") then
		bar = tonumber(param);
		if (bar) then
			for page=1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
				for button=1, DAB_Settings[DAB_INDEX].Bar[bar].numButtons do
					local action = DAB_Settings[DAB_INDEX].Bar[bar].pages[page][button];
					PickupAction(action);
					PickupSpell(999, BOOKTYPE_SPELL);
				end
			end
		end
	elseif (command == "barhide") then
		local bar = tonumber(param);
		if (bar and DAB_Settings[DAB_INDEX].Bar[bar]) then
			DAB_Bar_Hide(bar);
		elseif (param == "pet" ) then
			DAB_OtherBar_Hide(11);
		elseif (param == "shapeshift" ) then
			DAB_OtherBar_Hide(12);
		elseif (param == "bag" ) then
			DAB_OtherBar_Hide(13);
		elseif (param == "menu" ) then
			DAB_OtherBar_Hide(14);
		end
	elseif (command == "barpage") then
		local _,_,bar, page = string.find(param, '(%d*) (%d*)');
		page = tonumber(page);
		bar = tonumber(bar);
		if (bar and page) then
			DAB_Bar_SetPage(bar, page);
		end
	elseif (command == "barshow") then
		local bar = tonumber(param);
		if (bar and DAB_Settings[DAB_INDEX].Bar[bar]) then
			DAB_Bar_Show(bar);
		elseif (param == "pet" ) then
			DAB_OtherBar_Show(11);
		elseif (param == "shapeshift" ) then
			DAB_OtherBar_Show(12);
		elseif (param == "bag" ) then
			DAB_OtherBar_Show(13);
		elseif (param == "menu" ) then
			DAB_OtherBar_Show(14);
		end
	elseif (command == "bartoggle") then
		local bar = tonumber(param);
		if (bar and DAB_Settings[DAB_INDEX].Bar[bar]) then
			DAB_Bar_Toggle(bar);
		elseif (param == "pet" ) then
			DAB_OtherBar_Toggle(11);
		elseif (param == "shapeshift" ) then
			DAB_OtherBar_Toggle(12);
		elseif (param == "bag" ) then
			DAB_OtherBar_Toggle(13);
		elseif (param == "menu" ) then
			DAB_OtherBar_Toggle(14);
		end
	elseif (command == "hideallbars") then
		for i=1,10 do
			DAB_Bar_Hide(i);
		end
	elseif (command == "showallbars") then
		for i=1,10 do
			DAB_Bar_Show(i);
		end
	elseif (command == "floaterhide") then
		local bar = tonumber(param);
		if (bar and DAB_Settings[DAB_INDEX].Floaters[bar]) then
			DAB_Floater_Hide(bar);
		end
	elseif (command == "floatershow") then
		local bar = tonumber(param);
		if (bar and DAB_Settings[DAB_INDEX].Floaters[bar]) then
			DAB_Floater_Show(bar);
		end
	elseif (command == "floatertoggle") then
		local bar = tonumber(param);
		if (bar and DAB_Settings[DAB_INDEX].Floaters[bar]) then
			DAB_Floater_Toggle(bar);
		end
	elseif (command == "setkeygroup") then
		local _,_,group, bar = string.find(param, '(%d*) (%d*)');
		group = tonumber(group);
		bar = tonumber(bar);
		if (group and bar) then
			DAB_Set_KeybindingGroup(group, bar);
		end
	elseif (command == "groupshow") then
		local group = tonumber(param);
		if (group) then
			DAB_Show_Group(group);
		end
	elseif (command == "grouphide") then
		local group = tonumber(param);
		if (group) then
			DAB_Hide_Group(group);
		end
	elseif (command == "grouptoggle") then
		local group = tonumber(param);
		if (group) then
			DAB_Toggle_Group(group);
		end
	elseif (command == "drag") then
		DAB_Toggle_Dragging();
	elseif (command == "ids") then
		DAB_Toggle_IDs();
	elseif (command == "actions") then
		DAB_Toggle_ActionIDs();
	elseif (command == "buttonlock") then
		DAB_Toggle_ButtonLock();
	elseif (command == "load") then
		DAB_Load_Profile(param);
	else
		for _, line in DAB_HELP_TEXT do
			DL_Feedback(line);
		end
	end
end

function DAB_Toggle_ActionIDs()
	if (DAB_SHOWING_IDS) then
		DAB_SHOWING_IDS = nil;
		DAB_SHOWING_ACTIONIDS = nil;
		if (DAB_Options) then
			DAB_Options_ActionIDToggle:SetText(DAB_TEXT.ShowActionIDs);
			DAB_Options_IDToggle:SetText(DAB_TEXT.ShowButtonIDs);
		end
	else
		DAB_SHOWING_IDS = true;
		DAB_SHOWING_ACTIONIDS = true;
		if (DAB_Options) then
			DAB_Options_ActionIDToggle:SetText(DAB_TEXT.HideActionIDs);
		end
	end
	for i=1,120 do
		DAB_ActionButton_Update(i);
	end
end

function DAB_Toggle_ButtonLock()
	for bar=1,10 do
		if (DAB_Settings[DAB_INDEX].Bar[bar].buttonsLocked) then
			DAB_Settings[DAB_INDEX].Bar[bar].buttonsLocked = nil;
		else
			DAB_Settings[DAB_INDEX].Bar[bar].buttonsLocked = 1;
		end
	end
	for floater in DAB_Settings[DAB_INDEX].Floaters do
		if (DAB_Settings[DAB_INDEX].Floaters[floater].buttonLocked) then
			DAB_Settings[DAB_INDEX].Floaters[floater].buttonLocked = nil;
		else
			DAB_Settings[DAB_INDEX].Floaters[floater].buttonLocked = 1;
		end
	end
end

function DAB_Toggle_Dragging()
	if (DAB_DRAGGING_UNLOCKED) then
		DAB_DRAGGING_UNLOCKED = nil;
		if (DAB_Options) then
			DAB_Options_DraggingToggle:SetText(DAB_TEXT.UnlockDragging);
		end
		DAB_XPBar:EnableMouse(false);
		DAB_LatencyBar:EnableMouse(false);
		DAB_KeyringBox:EnableMouse(false);
		for i=11,14 do
			for b=1, DAB_OTHER_BAR[i][0].numButtons do
				getglobal(DAB_OTHER_BAR[i][b]):EnableMouse(1);
			end
		end
	else
		DAB_DRAGGING_UNLOCKED = true;
		if (DAB_Options) then
			DAB_Options_DraggingToggle:SetText(DAB_TEXT.LockDragging);
		end
		DAB_XPBar:EnableMouse(1);
		DAB_LatencyBar:EnableMouse(1);
		DAB_KeyringBox:EnableMouse(1);
		for i=11,14 do
			for b=1, DAB_OTHER_BAR[i][0].numButtons do
				getglobal(DAB_OTHER_BAR[i][b]):EnableMouse(false);
			end
		end
	end
end

function DAB_Toggle_Group(group)
	for i=1,10 do
		if (DAB_Settings[DAB_INDEX].Bar[i].cbgroup == group) then
			DAB_Bar_Toggle(i);
		end
		if (DAB_Settings[DAB_INDEX].ControlBox[i].cbgroup == group) then
			DAB_ControlBox_Toggle(i);
		end
	end
	for i=11,14 do
		if (DAB_Settings[DAB_INDEX].OtherBar[i].cbgroup == group) then
			DAB_OtherBar_Toggle(i);
		end
	end
	for b in DAB_Settings[DAB_INDEX].Floaters do
		if (DAB_Settings[DAB_INDEX].Floaters[b].cbgroup == group) then
			DAB_Floater_Toggle(b);
		end
	end
end

function DAB_Toggle_IDs()
	if (DAB_SHOWING_IDS) then
		DAB_SHOWING_IDS = nil;
		DAB_SHOWING_ACTIONIDS = nil;
		if (DAB_Options) then
			DAB_Options_ActionIDToggle:SetText(DAB_TEXT.ShowActionIDs);
			DAB_Options_IDToggle:SetText(DAB_TEXT.ShowButtonIDs);
		end
	else
		DAB_SHOWING_IDS = true;
		if (DAB_Options) then
			DAB_Options_IDToggle:SetText(DAB_TEXT.HideButtonIDs);
		end
	end
	for i=1,120 do
		DAB_ActionButton_Update(i);
	end
end

function DAB_Toggle_Options()
	if (not DAB_Options) then
		DAB_Load_Options();
	elseif (DAB_Options:IsVisible()) then
		DAB_Options:Hide();
	else
		DAB_Options:Show();
	end
end

function DAB_Unset_KeybindingGroup(group)
	local oldBar = DAB_Settings[DAB_INDEX].KBGroups[group];
	if (oldBar) then
		for i=1,120 do
			if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == oldBar) then
				getglobal("DAB_ActionButton_"..i.."_HotKey"):SetText(getglobal("DAB_ActionButton_"..i).basekb);
			end
		end
	end
	DAB_Settings[DAB_INDEX].KBGroups[group] = nil;
end

function DAB_Update_Location(frame, base, point, to)
	this:StopMovingOrSizing();
	local x, y = DL_Get_Offsets(frame, base, point, to);
	this:ClearAllPoints();
	this:SetPoint(point, base, to, x, y);
	DAB_Settings[DAB_INDEX].FrameLocs[frame:GetName()] = {
		point = point,
		to = to,
		frame = base:GetName(),
		x = x,
		y = y
	};
end

function DAB_Update_NewActions(elapsed)
	if (DiscordActionBarsFrame.updateactionlist) then
		DiscordActionBarsFrame.updateactionlist = DiscordActionBarsFrame.updateactionlist - elapsed;
		if (DiscordActionBarsFrame.updateactionlist < 0) then
			DAB_Update_ActionList();
			DiscordActionBarsFrame.updateactionlist = nil;
		end
	end
	if (CursorHasItem() or CursorHasSpell()) then
		DiscordActionBarsFrame.updatenewactions = nil;
	end
	if (not DiscordActionBarsFrame.updatenewactions) then return; end
	DiscordActionBarsFrame.updatenewactions = DiscordActionBarsFrame.updatenewactions - elapsed;
	if (DiscordActionBarsFrame.updatenewactions < 0) then
		DiscordActionBarsFrame.updatenewactions = nil;
		DAB_SHOWING_EMPTY = nil;
		for i=1,10 do
			if (DAB_Settings[DAB_INDEX].Bar[i].hide) then
				getglobal("DAB_ActionBar_"..i):Hide();
			end
			if (DAB_Settings[DAB_INDEX].Bar[i].hideEmpty) then
				DAB_Bar_Update(i);
			end
		end
		for b in DAB_Settings[DAB_INDEX].Floaters do
			if (DAB_Settings[DAB_INDEX].Floaters[b].hide) then
				getglobal("DAB_ActionButton_"..b):Hide();
			end
		end
	end
end

function DAB_VariableKeybinding_Down(number)
	DAB_VARIABLE_KEYBINDINGS[number] = 1;
	if (DAB_EventMacros_VariableKeybinding) then
		DAB_EventMacros_VariableKeybinding(number, 1);
	end
end

function DAB_VariableKeybinding_Up(number)
	DAB_VARIABLE_KEYBINDINGS[number] = 2;
	if (DAB_EventMacros_VariableKeybinding) then
		DAB_EventMacros_VariableKeybinding(number, 2);
	end
end
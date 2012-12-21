-- default Variables
configdata = {
							activetab = 1,
							mainframeposx = 10 , 
							mainframeposy = -300,
							namessize = 200,
							usenamebar = true,
							hidenamebar = true,
							namebartext = "!trigger - !count",
							titletext = "!tNext [!iExpired/!iAll]",
							namebarposx = 10,
							namebarposy = -450,
							minimizedposx = 10,
							minimizedposy = -500,
							minimized = true,
							triggerconfposx = 300,
							triggerconfposx = -400,							
							timersort = 1,
							timersortascending = false,
							triggersort = 1,
							triggersortascending = false,	
							spamto = TIMERS_LOC_ALLWOSELF,
							spamonpress = 10,
							alldisabled = false,
							framescale = 100						
							};

TimerscurrentTime = nil;

timerdata = {};

-- Hooks
local Timers_OldSpellHook;
local Timers_OldSpellHookByName;
local Timers_OldUseAction;

-- local variables
local timerUpdateFlag = false;
local triggerPointer = {};
local timeIsCorrect = false;
local timers_dropdown_row;
local trigger_edit;
local triggerdata_DEFAULT = {};
local configdata_DEFAULT = {};
local groupdata_DEFAULT = {};
local inCombat = false;
local timeSinceUpdate = 0;
local currSpellCast;
local IconArray = {};
local Timers_Debug = false;

-- GUI Functions
function TimersDropDownMainMenu_Init()
	UIDropDownMenu_Initialize(this, TimersMenu_CreateMainMenuDropDown, "MENU");
end

function TimersDropDownTimerRowMenu_Init()
	UIDropDownMenu_Initialize(this, TimersMenu_CreateTimerRowDropDown, "MENU");
end

function TimersDropDownTimerRowMenuEntry_Init()
	if string.find(this:GetName(),"ChanBox") ~= nil then
		UIDropDownMenu_Initialize(this, TimersMenu_CreateTimerRowChannelDropDown, "SELECTOR");
	elseif string.find(this:GetName(),"TypeBox") ~= nil then
		UIDropDownMenu_Initialize(this, TimersMenu_CreateTimerRowTypeDropDown, "SELECTOR");
	elseif string.find(this:GetName(),"ModeBox") ~= nil then	
		UIDropDownMenu_Initialize(this, TimersMenu_CreateTimerRowModeDropDown, "SELECTOR");
	elseif string.find(this:GetName(), "TextBox") or string.find(this:GetName(), "EditBox4") then
		UIDropDownMenu_Initialize(this, TimersMenu_CreateTimerRowTextDropDown, "SELECTOR");	
	end
end	

function TimersMenu_CreateTimerRowTextDropDown(level)
	if level == 1 then
		info = {["text"] = TIMERS_LOC_COMBATSTART, ["func"] = TimersEdit_SaveTextImplicit, ["arg1"] = this ,["arg2"] = TIMERS_LOC_COMBATSTART};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_COMBATSTOP, ["func"] = TimersEdit_SaveTextImplicit, ["arg1"] = this ,["arg2"] = TIMERS_LOC_COMBATSTOP};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_ZONEENTER, ["func"] = TimersEdit_SaveTextImplicit, ["arg1"] = this ,["arg2"] = TIMERS_LOC_ZONEENTER};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_SPELL_CAST, ["func"] = TimersEdit_SaveTextImplicit, ["arg1"] = this ,["arg2"] = TIMERS_LOC_SPELL_CAST};
		UIDropDownMenu_AddButton(info, 1);		
	end
end

function TimersConfig_CreateSpamToDropDown(level)
	if level == 1 then
		info = {["text"] = TIMERS_LOC_ALL, ["func"] = TimersMenu_SetConfigSpam, ["arg1"] = this , ["arg2"] = TIMERS_LOC_ALL};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_ALLWOSELF, ["func"] = TimersMenu_SetConfigSpam, ["arg1"] = this ,["arg2"] = TIMERS_LOC_ALLWOSELF};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_ONLYSELECTED, ["func"] = TimersMenu_SetConfigSpam, ["arg1"] = this ,["arg2"] = TIMERS_LOC_ONLYSELECTED};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_ONLYHIGHER, ["func"] = TimersMenu_SetConfigSpam, ["arg1"] = this ,["arg2"] = TIMERS_LOC_ONLYHIGHER};
		UIDropDownMenu_AddButton(info, 1);
	end
end	

function TimersMenu_CreateTimerRowChannelDropDown(level)
	if level == 1 then
		if not (triggerdata[trigger_edit].name == "default") then
			info = {["text"] = TIMERS_LOC_DEFAULT, ["func"] = TimersEdit_SaveChannel, ["arg1"] = this , ["arg2"] = TIMERS_LOC_DEFAULT};
			UIDropDownMenu_AddButton(info, 1);	
		end
		info = {["text"] = TIMERS_LOC_SELF, ["func"] = TimersEdit_SaveChannel, ["arg1"] = this ,["arg2"] = TIMERS_LOC_SELF};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_PARTY, ["func"] = TimersEdit_SaveChannel, ["arg1"] = this ,["arg2"] = TIMERS_LOC_PARTY};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_RAID, ["func"] = TimersEdit_SaveChannel, ["arg1"] = this ,["arg2"] = TIMERS_LOC_RAID};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_CTRAID, ["func"] = TimersEdit_SaveChannel, ["arg1"] = this ,["arg2"] = TIMERS_LOC_CTRAID};
		UIDropDownMenu_AddButton(info, 1);
	end
end

function TimersMenu_CreateTimerRowTypeDropDown(level)
	if level == 1 then
		if not (triggerdata[trigger_edit].name == "default") then
			info = {["text"] = TIMERS_LOC_DEFAULT, ["func"] = TimersEdit_SaveType, ["arg1"] = this ,["arg2"] = TIMERS_LOC_DEFAULT};
			UIDropDownMenu_AddButton(info, 1);	
		end
		info = {["text"] = TIMERS_LOC_MULTIPLE, ["func"] = TimersEdit_SaveType, ["arg1"] = this ,["arg2"] = TIMERS_LOC_MULTIPLE};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_ONCE, ["func"] = TimersEdit_SaveType, ["arg1"] = this ,["arg2"] = TIMERS_LOC_ONCE};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_ONCEGROUP, ["func"] = TimersEdit_SaveType, ["arg1"] = this ,["arg2"] = TIMERS_LOC_ONCEGROUP};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_PAUSE, ["func"] = TimersEdit_SaveType, ["arg1"] = this ,["arg2"] = TIMERS_LOC_PAUSE};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_STOP, ["func"] = TimersEdit_SaveType, ["arg1"] = this ,["arg2"] = TIMERS_LOC_STOP};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_WARNONLY, ["func"] = TimersEdit_SaveType, ["arg1"] = this ,["arg2"] = TIMERS_LOC_WARNONLY};
		UIDropDownMenu_AddButton(info, 1);
	end
end

function TimersMenu_CreateTimerRowModeDropDown(level)
	if level == 1 then
		if not (triggerdata[trigger_edit].name == "default") then
			info = {["text"] = TIMERS_LOC_DEFAULT, ["func"] = TimersEdit_SaveMode, ["arg1"] = this ,["arg2"] = TIMERS_LOC_DEFAULT};
			UIDropDownMenu_AddButton(info, 1);
		end
		info = {["text"] = TIMERS_LOC_CONTINUE, ["func"] = TimersEdit_SaveMode, ["arg1"] = this ,["arg2"] = TIMERS_LOC_CONTINUE};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_DELETE, ["func"] = TimersEdit_SaveMode, ["arg1"] = this ,["arg2"] = TIMERS_LOC_DELETE};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_RESET, ["func"] = TimersEdit_SaveMode, ["arg1"] = this ,["arg2"] = TIMERS_LOC_RESET};
		UIDropDownMenu_AddButton(info, 1);
		info = {["text"] = TIMERS_LOC_INC, ["func"] = TimersEdit_SaveMode, ["arg1"] = this ,["arg2"] = TIMERS_LOC_INC};
		UIDropDownMenu_AddButton(info, 1);
	end
end

function TimersMenu_CreateMainMenuDropDown(level)
	if configdata.activetab == 1 then
		if level == 1 then
			if configdata.alldisabled then
				info = {["text"] = TIMERS_LOC_ENABLEALL, ["func"] = TimersEdit_ToggleDisableAll};
				UIDropDownMenu_AddButton(info, 1);
			else
				info = {["text"] = TIMERS_LOC_DISABLEALL, ["func"] = TimersEdit_ToggleDisableAll};
				UIDropDownMenu_AddButton(info, 1);
			end
			info = {["text"] = " -------- ",["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_DELETEXPIRED, ["func"] = TimersEdit_DeleteExpired};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_DELETEBYGROUP, ["hasArrow"] = 1};
			UIDropDownMenu_AddButton(info, 1);		
			info = {["text"] = TIMERS_LOC_DELETALL, ["func"] = TimersEdit_DeleteAllTimer};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = " -------- ",["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_RESETEXPIRED, ["func"] = TimersEdit_ResetExpired};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_RESETBYGROUP, ["hasArrow"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_RESETALL, ["func"] = TimersEdit_ResetAll};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = " -------- ",["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_SPAMALLTO,["hasArrow"] = 1};
			UIDropDownMenu_AddButton(info, 1);
		elseif level == 2 and string.find(this:GetName(), "Button4") then
			if table.getn(timerdata) == 0 then
				info = {["text"] = TIMERS_LOC_NO_TIMERS,["notClickable"] = 1};
				UIDropDownMenu_AddButton(info, 2);
			else
				for i=1, table.getn(groupdata) do
					local hasTimer = false;
					for j=1, table.getn(timerdata) do
						if triggerdata[Timers_TriggerNameToNumber(timerdata[j].trigger)].group == groupdata[i].name or (not triggerdata[Timers_TriggerNameToNumber(timerdata[j].trigger)].group and groupdata[i].name == TIMERS_LOC_NOGROUP) then
							hasTimer = i;
						end
					end
					if hasTimer then
						info = {["text"] = groupdata[i].name, ["func"] = TimersEdit_DeleteByGroup, ["arg1"] = groupdata[i].name};
						UIDropDownMenu_AddButton(info, 2);
					end
				end
			end
		elseif level == 2 and string.find(this:GetName(), "Button8") then
			if table.getn(timerdata) == 0 then
				info = {["text"] = TIMERS_LOC_NO_TIMERS,["notClickable"] = 1};
				UIDropDownMenu_AddButton(info, 2);
			else
				for i=1, table.getn(groupdata) do
					local hasTimer = false;
					for j=1, table.getn(timerdata) do
						if triggerdata[Timers_TriggerNameToNumber(timerdata[j].trigger)].group == groupdata[i].name or (not triggerdata[Timers_TriggerNameToNumber(timerdata[j].trigger)].group and groupdata[i].name == TIMERS_LOC_NOGROUP) then
							hasTimer = i;
						end
					end
					if hasTimer then
						info = {["text"] = groupdata[i].name, ["func"] = TimersEdit_ResetByGroup, ["arg1"] = groupdata[i].name};
						UIDropDownMenu_AddButton(info, 2);
					end
				end
			end 					 				
		elseif level == 2 and string.find(this:GetName(), "Button11") then
			if ChatEdit_GetLastTellTarget(ChatFrameEditBox) ~= "" then
				info = {["text"] = TIMERS_LOC_REPLY.." ("..ChatEdit_GetLastTellTarget(ChatFrameEditBox)..")", ["func"]=TimersSend_AllTimer,  ["arg1"]="REPLY"};
				UIDropDownMenu_AddButton(info, 2);
			end
			info = {["text"] = TIMERS_LOC_SELF, ["func"]=TimersSend_AllTimer,  ["arg1"]=TIMERS_LOC_SELF};
			UIDropDownMenu_AddButton(info, 2);
			info = {["text"] = TIMERS_LOC_PARTY, ["func"]=TimersSend_AllTimer,  ["arg1"]=TIMERS_LOC_PARTY};
			UIDropDownMenu_AddButton(info, 2);
			info = {["text"] = TIMERS_LOC_RAID, ["func"]=TimersSend_AllTimer,  ["arg1"]=TIMERS_LOC_RAID};
			UIDropDownMenu_AddButton(info, 2);
			info = {["text"] = TIMERS_LOC_OFFICER, ["func"]=TimersSend_AllTimer,  ["arg1"]=TIMERS_LOC_OFFICER};
			UIDropDownMenu_AddButton(info, 2);			
		end
	elseif configdata.activetab == 3 then
		if level == 1 then
			if configdata.hideinactive then
				info = {["text"] = TIMERS_LOC_TOGGLEALLINACTIVSHOW, ["func"] = Timers_ToggleShowInactive};
				UIDropDownMenu_AddButton(info, 1);
			else
				info = {["text"] = TIMERS_LOC_TOGGLEALLINACTIVHIDE, ["func"] = Timers_ToggleShowInactive};
				UIDropDownMenu_AddButton(info, 1);
			end
			info = {["text"] = TIMERS_LOC_TOGGLEALLFOLD, ["func"]= Timers_ToggleFoldAll};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_TOGGLEALL, ["func"] = Timers_ToggleActiveAll};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = " -------- ",["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_RESETALLCNT, ["func"] = Timers_ResetAllCnt};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = " -------- ",["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_ADDGROUP, ["func"] = Timers_AddGroup };
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_DELETEGROUP, ["hasArrow"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_ADDTRIGGER, ["func"] = Timers_AddTrigger};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = " -------- ",["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_RESETALLTRIGGER, ["func"] = Timers_ResetAllTrigger};
			UIDropDownMenu_AddButton(info, 1);			
		elseif level == 2 then
			local onlydefault = true;
			for i = 1, table.getn(groupdata) do
				if groupdata[i].isnotdefault then
					info = {["text"] = groupdata[i].name, ["func"] = Timers_DeleteGroup, ["arg1"] = i};
					UIDropDownMenu_AddButton(info, 2);
					onlydefault = false;
				end				
			end
			if onlydefault then
				info = {["text"] = TIMERS_LOC_NOT_DELETE_DEFAULT, ["notClickable"] = 1};
				UIDropDownMenu_AddButton(info, 2);
			end					
		end
	end
end

function TimersMenu_CreateTimerRowDropDown(level)
	if (configdata.activetab == 1 or configdata.activetab == 2) then
		if level == 1 then
			local i = Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
			timers_dropdown_row = Timers_GetRow(this);
			info = {["text"] = TIMERS_LOC_INVOKED,["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = timerdata[i].trigger,["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = " -------- ",["notClickable"] = 1};
			UIDropDownMenu_AddButton(info, 1);					
			info = {["text"] = TIMERS_LOC_DELETE, ["func"] = TimersEdit_DeleteTimer, ["arg1"] = this};
			UIDropDownMenu_AddButton(info, 1);
			info = {["text"] = TIMERS_LOC_RESET, ["func"] = TimersEdit_ResetTimer, ["arg1"] = this};
			UIDropDownMenu_AddButton(info, 1);
			if not timerdata[i].stopped then
				if not timerdata[i].paused then
					info = {["text"] = TIMERS_LOC_PAUSE, ["func"] = TimersEdit_TogglePaused, ["arg1"] = this};
					UIDropDownMenu_AddButton(info, 1);
				else
					info = {["text"] = TIMERS_LOC_RESUME, ["func"] = TimersEdit_TogglePaused, ["arg1"] = this};
					UIDropDownMenu_AddButton(info, 1);
				end
				if triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].mode == TIMERS_LOC_INC then		
					info = {["text"] = TIMERS_LOC_STOP, ["func"] = TimersEdit_StopTimer, ["arg1"] = this};
					UIDropDownMenu_AddButton(info, 1);
				end
			end
			info = {["text"] = TIMERS_LOC_SPAMTO,["hasArrow"] = 1};
			UIDropDownMenu_AddButton(info, 1);
		elseif level == 2 then
			if ChatEdit_GetLastTellTarget(ChatFrameEditBox) ~= "" then
				info = {["text"] = TIMERS_LOC_REPLY.." ("..ChatEdit_GetLastTellTarget(ChatFrameEditBox)..")", ["func"] = TimersSend_Timer, ["arg1"] = timers_dropdown_row, ["arg2"] = "REPLY"};
				UIDropDownMenu_AddButton(info, 2);
			end
			info = {["text"] = TIMERS_LOC_PARTY, ["func"] = TimersSend_Timer, ["arg1"] = timers_dropdown_row, ["arg2"] = TIMERS_LOC_PARTY};
			UIDropDownMenu_AddButton(info, 2);
			info = {["text"] = TIMERS_LOC_RAID, ["func"] = TimersSend_Timer, ["arg1"] = timers_dropdown_row, ["arg2"] = TIMERS_LOC_RAID};
			UIDropDownMenu_AddButton(info, 2);
			info = {["text"] = TIMERS_LOC_CTRAID, ["func"] = TimersSend_Timer, ["arg1"] = timers_dropdown_row, ["arg2"] = TIMERS_LOC_CTRAID};
			UIDropDownMenu_AddButton(info, 2);
			info = {["text"] = TIMERS_LOC_OFFICER, ["func"] = TimersSend_Timer, ["arg1"] = timers_dropdown_row, ["arg2"] = TIMERS_LOC_OFFICER};
			UIDropDownMenu_AddButton(info, 2);					
		end
	else
		if level == 1 then
			timers_dropdown_row = Timers_GetRow(this);
			info = {["text"] = TIMERS_LOC_ADVANCEDCONF, ["func"] = Timers_ShowAdvancedConfig};
			UIDropDownMenu_AddButton(info, 1);			
			info = {["text"] = TIMERS_LOC_RESETCNT, ["func"] = Timers_ResetCnt, ["arg1"] = this};
			UIDropDownMenu_AddButton(info, 1);
			if triggerdata[Timers_RowToTrigger(timers_dropdown_row+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].isnotdefault then
				info = {["text"] = TIMERS_LOC_DELETETRIGGER, ["func"] = Timers_DeleteTrigger, ["arg1"] = this};
				UIDropDownMenu_AddButton(info, 1);
			end
			if not (triggerdata[Timers_RowToTrigger(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].name == "default") then
				info = {["text"] = TIMERS_LOC_MOVETOGROUP,["hasArrow"] = 1};
				UIDropDownMenu_AddButton(info, 1);
			end	
			if Timers_TriggerNameToDefaultNumber(triggerdata[Timers_RowToTrigger(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].name) then
				info = {["text"] = TIMERS_LOC_RESETTRIGGER, ["func"] = Timers_ResetTriggerByRow, ["arg1"] = this};
				UIDropDownMenu_AddButton(info, 1);
			end
		elseif level == 2 then
			for i = 1, table.getn(groupdata) do
				info = {["text"] = groupdata[i].name, ["func"] = Timers_MoveToGroup, ["arg1"] = timers_dropdown_row, ["arg2"] = i};
				UIDropDownMenu_AddButton(info, 2);		
			end
		end
	end
end

function TimersMenu_SetConfigSpam(arg,text)
	configdata.spamto = text;
	TimersMenu_SetEditBoxText(arg,text);
end	

function TimersMenu_SetEditBoxText(caller,text)
	getglobal(caller:GetParent():GetName().."Text"):SetText(text);
end

	
function Timers_TabControl(arg) -- Tab Control

	 activeset = 0; -- Verschiebung für das Active Tab
	
	-- Erstes Tab Testen
	if arg == TimersMainFrameTabButton1 then	
		TimersMainFrameTabButton1MiddleDisabled:Show();
		TimersMainFrameTabButton1RightDisabled:Show();
		TimersMainFrameTabButton1LeftDisabled:Show();
		TimersMainFrameTabButton1Middle:Hide();
		TimersMainFrameTabButton1Right:Hide();
		TimersMainFrameTabButton1Left:Hide();		
		arg:SetPoint("TOPLEFT","TimersMainFrame","BOTTOMLEFT",2,0);
		activeset = 4;
		configdata.activetab = 1;
	else
		TimersMainFrameTabButton1MiddleDisabled:Hide();
		TimersMainFrameTabButton1RightDisabled:Hide();
		TimersMainFrameTabButton1LeftDisabled:Hide();
		TimersMainFrameTabButton1Middle:Show();
		TimersMainFrameTabButton1Right:Show();
		TimersMainFrameTabButton1Left:Show();
		TimersMainFrameTabButton1:SetPoint("TOPLEFT","TimersMainFrame","BOTTOMLEFT",2,4);
	end
	
	-- Tab 2 bis 5 setzen	
	for i = 2, 5 do
		if arg == getglobal("TimersMainFrameTabButton"..i) then
			getglobal("TimersMainFrameTabButton"..i.."MiddleDisabled"):Show();
			getglobal("TimersMainFrameTabButton"..i.."RightDisabled"):Show();
			getglobal("TimersMainFrameTabButton"..i.."LeftDisabled"):Show();
			getglobal("TimersMainFrameTabButton"..i.."Middle"):Hide();
			getglobal("TimersMainFrameTabButton"..i.."Right"):Hide();
			getglobal("TimersMainFrameTabButton"..i.."Left"):Hide();
			getglobal("TimersMainFrameTabButton"..i):SetPoint("TOPLEFT",getglobal("TimersMainFrameTabButton"..(i-1)),"TOPRIGHT",0,-4);
			activeset = 4;
			configdata.activetab = i;
		else
			getglobal("TimersMainFrameTabButton"..i.."MiddleDisabled"):Hide();
			getglobal("TimersMainFrameTabButton"..i.."RightDisabled"):Hide();
			getglobal("TimersMainFrameTabButton"..i.."LeftDisabled"):Hide();
			getglobal("TimersMainFrameTabButton"..i.."Middle"):Show();
			getglobal("TimersMainFrameTabButton"..i.."Right"):Show();
			getglobal("TimersMainFrameTabButton"..i.."Left"):Show();
			getglobal("TimersMainFrameTabButton"..i):SetPoint("TOPLEFT",getglobal("TimersMainFrameTabButton"..(i-1)),"TOPRIGHT",0,activeset);
			activeset = 0;
		end
	end
	Timers_TabContentControl(); 
end

function Timers_TabContentControl()

	-- creating default window sys (timerframe)
	TimersMainFrame:SetBackdropBorderColor(1, 1, 1, 1);
	TimersMainFrame:SetBackdropColor(0,0, 0, 0.8);
	TimersMainFrameTitle:Show();
	TimersMainFrameScrollFrame:Show();
	TimersMainFrameCloseButton:Show();
	TimersMainFrameMenuButton:Show();
	TimersMainFrameMinimizeButton:Show();	
	TimersMainFrameSortButton1:Show();
	TimersMainFrameSortButton2:Show();
	TimersMainFrameToggleNameBoxButton:Show();
	TimersMainFrameScrollFrame:Show();
		
	for i = 2, 5 do
		getglobal("TimersMainFrameTabButton"..i):Show();
	end
		
	TimersMainFrameTabButton1Middle:SetAlpha(1);
	TimersMainFrameTabButton1Left:SetAlpha(1);
	TimersMainFrameTabButton1Right:SetAlpha(1);
		
	for i = 1, 10 do
		getglobal("TimersMainFrameTimerRow"..i):Hide();
		getglobal("TimersMainFrameTimerRow"..i.."GrpByPlaytime"):Hide();
		getglobal("TimersMainFrameTimerRow"..i.."GrpByPlaytimeTitle"):Hide();
		getglobal("TimersMainFrameTimerRow"..i.."GrpResetCnt"):Hide();
		getglobal("TimersMainFrameTimerRow"..i.."GrpResetCntTitle"):Hide();
		getglobal("TimersMainFrameTimerRow"..i.."GrpDeleteTimer"):Hide();					
		getglobal("TimersMainFrameTimerRow"..i.."GrpDeleteTimerTitle"):Hide();
		getglobal("TimersMainFrameTimerRow"..i.."GrpOnStartTitle"):Hide();	
		getglobal("TimersMainFrameTimerRow"..i.."DeleteButton"):Show();				
		getglobal("TimersMainFrameTimerRow"..i.."Active"):Hide();
		getglobal("TimersMainFrameTimerRow"..i.."MenuButton"):SetText("!");
		getglobal("TimersMainFrameTimerRow"..i.."MenuButton"):Show();
		getglobal("TimersMainFrameTimerRow"..i.."EditBox1"):SetPoint("TOPLEFT","$parentMenuButton","TOPRIGHT",0,0);
		getglobal("TimersMainFrameTimerRow"..i.."Middle"):SetWidth(80+configdata.namessize);
		getglobal("TimersMainFrameTimerRow"..i.."EditBox1"):SetWidth(configdata.namessize-40);
		getglobal("TimersMainFrameTimerRow"..i.."Middle"):SetAlpha(0.8);
		getglobal("TimersMainFrameTimerRow"..i.."Left"):SetAlpha(0.8);
		getglobal("TimersMainFrameTimerRow"..i.."Right"):SetAlpha(0.8);
		getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetPoint("TOPLEFT","$parentEditBox1","TOPRIGHT",20,0);	
		getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):Show();	
		for j = 3, 5 do
			getglobal("TimersMainFrameTimerRow"..i.."EditBox"..j):Hide();
		end
	end
	
	TimersMainFrame:SetWidth(130+configdata.namessize);
	TimersMainFrameScrollFrame:SetWidth(95+configdata.namessize);

	TimersMainFrameSortButton1:Show();
	TimersMainFrameSortButton1:SetWidth(configdata.namessize);
	TimersMainFrameSortButton2:Show();
	for i = 3, 5 do
		getglobal("TimersMainFrameSortButton"..i):Hide();
	end	
	
	TimersMainFrameConfig:Hide();
	TimersMainFrameHelp:Hide();
	TimersMainFrameTextFrame:Hide();	
	
	if configdata.activetab == 1 then
		Timers_SetTimerData();	
	elseif configdata.activetab == 2 then
		TimersMainFrame:SetBackdropBorderColor(0, 0, 0, 0);
		TimersMainFrame:SetBackdropColor(0, 0, 0, 0);
		TimersMainFrameTitle:Hide();
		TimersMainFrameMenuButton:Hide();
		TimersMainFrameCloseButton:Hide();
		TimersMainFrameMinimizeButton:Hide();	
		TimersMainFrameSortButton1:Hide();
		TimersMainFrameSortButton2:Hide();
		TimersMainFrameToggleNameBoxButton:Hide();
		
		for i = 2, 5 do
			getglobal("TimersMainFrameTabButton"..i):Hide();
		end
		
		TimersMainFrameTabButton1Middle:SetAlpha(0);
		TimersMainFrameTabButton1Left:SetAlpha(0);
		TimersMainFrameTabButton1Right:SetAlpha(0);
		
		for i = 1, 10 do
			getglobal("TimersMainFrameTimerRow"..i.."Middle"):SetAlpha(0);
			getglobal("TimersMainFrameTimerRow"..i.."Left"):SetAlpha(0);
			getglobal("TimersMainFrameTimerRow"..i.."Right"):SetAlpha(0);
			getglobal("TimersMainFrameTimerRow"..i.."MenuButton"):Hide();
			getglobal("TimersMainFrameTimerRow"..i.."DeleteButton"):Hide();						
		end
		Timers_SetTimerData();
	elseif configdata.activetab == 3 then
		TimersMainFrame:SetWidth(710);
		TimersMainFrameScrollFrame:SetWidth(675);
		for i = 3, 5 do
			getglobal("TimersMainFrameSortButton"..i):Show();
		end
	
	TimersMainFrameSortButton1:SetWidth(200);
	
		for i = 1, 10 do
			getglobal("TimersMainFrameTimerRow"..i.."Active"):Show();
			getglobal("TimersMainFrameTimerRow"..i.."DeleteButton"):Hide();	
			getglobal("TimersMainFrameTimerRow"..i.."EditBox1"):SetPoint("TOPLEFT","$parentMenuButton","TOPRIGHT",20,0);			
			getglobal("TimersMainFrameTimerRow"..i.."Middle"):SetWidth(660);
			getglobal("TimersMainFrameTimerRow"..i.."EditBox1"):SetWidth(160);
			getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetPoint("TOPLEFT","$parentEditBox1","TOPRIGHT",0,0);	
			for j = 3, 5 do
				getglobal("TimersMainFrameTimerRow"..i.."EditBox"..j):Show();
			end
		end
		Timers_SetTriggerData();
	elseif configdata.activetab == 4 then
		for i = 1, 10 do
			getglobal("TimersMainFrameTimerRow"..i):Hide();	
		end
		TimersMainFrame:SetWidth(330);
		TimersMainFrameScrollFrame:Hide();
		TimersMainFrameMenuButton:Hide();
		TimersMainFrameSortButton1:Hide();
		TimersMainFrameSortButton2:Hide();
		TimersMainFrameConfig:Show();
	elseif configdata.activetab == 5 then
		for i = 1, 10 do
			getglobal("TimersMainFrameTimerRow"..i):Hide();	
		end
		TimersMainFrame:SetWidth(330);
		TimersMainFrameScrollFrame:Hide();
		TimersMainFrameMenuButton:Hide();
		TimersMainFrameSortButton1:Hide();
		TimersMainFrameSortButton2:Hide();
		TimersMainFrameHelp:Show();
	end			
end 

function Timers_ShowHelp(nr)
	TimersMainFrameHelp:Hide();
	TimersMainFrameTextFrame:Show();
	if nr == 1 then
		TimersMainFrameHelpFrameText:SetText(TIMERS_LOC_HELP_CAT1);
	elseif nr == 2 then
		TimersMainFrameHelpFrameText:SetText(TIMERS_LOC_HELP_CAT2);
	elseif nr == 3 then
		TimersMainFrameHelpFrameText:SetText(TIMERS_LOC_HELP_CAT3);
	elseif nr == 4 then
		TimersMainFrameHelpFrameText:SetText(TIMERS_LOC_HELP_CAT4);
	elseif nr == 5 then
		TimersMainFrameHelpFrameText:SetText(TIMERS_LOC_HELP_CAT5);
	elseif nr == 6 then
		TimersMainFrameHelpFrameText:SetText(TIMERS_LOC_HELP_CAT6);
	elseif nr == 7 then
		TimersMainFrameHelpFrameText:SetText(TIMERS_LOC_HELP_CAT7);
	end		
end

function Timers_WindowControl()	
	TimersMainFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", configdata.mainframeposx, configdata.mainframeposy);
	TimersNameBar:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", configdata.namebarposx , configdata.namebarposy);
	TimersMinimizedFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", configdata.minimizedposx , configdata.minimizedposy);
	TimersTriggersConfigFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", configdata.triggerconfposx , configdata.triggerconfposy);	
	if configdata.usenamebar and not (configdata.hidenamebar) then
		TimersNameBar:Show();
	else
		TimersNameBar:Hide();
	end
	Timers_MinimizedControl();
end

function Timers_ScaleControl()
	TimersMainFrame:SetScale(configdata.framescale/100);
	TimersNameBar:SetScale(configdata.framescale/100);
	TimersMinimizedFrame:SetScale(configdata.framescale/100);
end

function Timers_MinimizedControl()
	if configdata.minimized then
		TimersMainFrame:Hide();
		TimersMinimizedFrame:Show();
		if (not (configdata.titletext)) or configdata.titletext == "" then
			TimersMinimizedFrame:SetWidth(100);
		else
			TimersMinimizedFrame:SetWidth(207);
		end		
	else
		TimersMainFrame:Show();
		TimersMinimizedFrame:Hide();
	end	
end

function TimersConfig_ToggleNameBar()
	if(this:GetChecked() ~= nil) then
		TimersNameBar:Show();
		configdata.usenamebar = true;
	else 
		TimersNameBar:Hide();
		configdata.usenamebar = false;
	end
end

function Timers_ToggleNamebox()
	if(configdata.hidenamebar) then
		configdata.hidenamebar = nil;
		TimersNameBar:Show();
	else
		configdata.hidenamebar = true;
		TimersNameBar:Hide();
	end
end	

function Timers_ShowAdvancedConfig()
	trigger_edit = Timers_RowToTrigger(timers_dropdown_row+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame));
	TimersTriggersConfigFrameNameInput:SetText(triggerdata[trigger_edit].name);
	TimersTriggersConfigFrameTimeInput:SetText(Timers_TimeToText(tonumber(Timers_GetFieldValue(triggerdata[trigger_edit],"time"))));
	TimersTriggersConfigFrameTextBox:SetText(triggerdata[trigger_edit].text);
	if triggerdata[trigger_edit].mode then
		TimersTriggersConfigFrameModeBox:SetText(triggerdata[trigger_edit].mode);
	else
		TimersTriggersConfigFrameModeBox:SetText(TIMERS_LOC_DEFAULT);
	end
	if triggerdata[trigger_edit].type then	
		TimersTriggersConfigFrameTypeBox:SetText(triggerdata[trigger_edit].type);
	else
		TimersTriggersConfigFrameTypeBox:SetText(TIMERS_LOC_DEFAULT);
	end	
	if triggerdata[trigger_edit].warnchannel then	
		TimersTriggersConfigFrameWarnChanBox:SetText(triggerdata[trigger_edit].warnchannel);	
	else
		TimersTriggersConfigFrameWarnChanBox:SetText(TIMERS_LOC_DEFAULT);		
	end
	TimersTriggersConfigFrameWarnTimeInput:SetText(Timers_GetFieldValue(triggerdata[trigger_edit],"prewarn"));	
	TimersTriggersConfigFrameWarnMessInput:SetText(Timers_GetFieldValue(triggerdata[trigger_edit],"warnmessage"));	
	if triggerdata[trigger_edit].channel then	
		TimersTriggersConfigFrameExpChanBox:SetText(triggerdata[trigger_edit].channel);
	else
		TimersTriggersConfigFrameExpChanBox:SetText(TIMERS_LOC_DEFAULT);
	end
	TimersTriggersConfigFrameExpMessInput:SetText(Timers_GetFieldValue(triggerdata[trigger_edit],"message"));	
	TimersTriggersConfigFrameThresholdInput:SetText(Timers_GetFieldValue(triggerdata[trigger_edit],"threshold"));	
	TimersTriggersConfigFrameCountInput:SetText(Timers_GetFieldValue(triggerdata[trigger_edit],"count"));	
	TimersTriggersConfigFrame:Show();
end


function TimersSlash_Reset()
	configdata = Timers_cloneTable(configdata_DEFAULT);
	TimersNameBarNameBox:SetText(configdata.namebartext);
	Timers_ScaleControl();
	Timers_WindowControl();
	Timers_TabContentControl();	
	Timers_PrintText(TIMERS_LOC_RESETTED);
end

function TimersSlash_Invoke(name)
	local NotSucc = true;
	for i = 1, table.getn(triggerdata) do
		if triggerdata[i].name == name then
			Timers_StartTimer(triggerdata[i],nil);
			Timers_PrintText(name..TIMERS_LOC_MSGINVOKED);
			NotSucc = false;
			timerUpdateFlag = true;
		end
	end
	if NotSucc then
		Timers_PrintText(TIMERS_LOC_NO_TRIGGERNAME);
	end
end


function TimersConfig_Reset()
	configdata = Timers_cloneTable(configdata_DEFAULT);
	configdata.activetab = 4;
	TimersNameBarNameBox:SetText(configdata.namebartext);
	Timers_ScaleControl();
	Timers_WindowControl();
	Timers_TabContentControl();
end

function TimersEdit_ToggleDisableAll()
	if configdata.alldisabled then
		configdata.alldisabled = false;
		Timers_PrintText(TIMERS_LOC_ALLTRIGGER_ENABLED);
	else
		configdata.alldisabled = true;
		Timers_PrintText(TIMERS_LOC_ALLTRIGGER_DISABLED);
	end
end

function Timers_SetSort(arg)
	if configdata.activetab == 1 then
		if not IsShiftKeyDown() then
			if configdata.timersortascending then
				configdata.timersortascending = false;
			else
				configdata.timersortascending = true;
			end
			configdata.timersort = arg;
			table.sort(timerdata, Timers_CompareTimers);
			timerUpdateFlag = true;
		else
			Timers_SpamOnPress(arg);
		end
	else
		if configdata.triggersortascending then
			configdata.triggersortascending = false;
		else
			configdata.triggersortascending = true;
		end
		configdata.triggersort = arg;
		table.sort(triggerdata, Timers_CompareTriggers);
		Timers_SetTriggerData();
	end
	if not IsShiftKeyDown() then
		Timers_UpdateSortArrows();
	end
end

function Timers_UpdateSortArrows()
	for i = 1, 5 do
		getglobal("TimersMainFrameSortButton"..i.."Arrow"):Hide();
	end
	if configdata.activetab == 1 or configdata.activetab == 2 then
		getglobal("TimersMainFrameSortButton"..configdata.timersort.."Arrow"):Show();
	else
		getglobal("TimersMainFrameSortButton"..configdata.triggersort.."Arrow"):Show();
	end
end

function Timers_MsgSendTo(msg, channel)
	if channel == TIMERS_LOC_RAID or channel == TIMERS_LOC_CTRAID then
		if GetNumRaidMembers() == 0 then
			msg = TIMERS_LOC_NOT_IN_RAID..": "..msg;
			channel = TIMERS_LOC_SELF;
		elseif channel == TIMERS_LOC_RAID then
			SendChatMessage(msg,"RAID");
		else
			CT_RA_AddMessage("MS "..msg);
		end
	end
	if channel == TIMERS_LOC_PARTY then
		if GetNumPartyMembers() == 0 then
			msg = TIMERS_LOC_NOT_IN_PARTY..": "..msg;
			channel = TIMERS_LOC_SELF;
		else
			SendChatMessage(msg,"PARTY");
		end
	end
	if channel == TIMERS_LOC_SELF then
		Timers_PrintText(msg);
	end
	if channel == TIMERS_LOC_REPLY then
		SendChatMessage(msg,"WHISPER",nil,ChatEdit_GetLastTellTarget(ChatFrameEditBox));
	end
	if channel == TIMERS_LOC_OFFICER then
		SendChatMessage(msg,"OFFICER");
	end
end

function TimersSend_Timer(row, channel)
	local Offset = FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	TimersSend_TimerByNr(row+Offset,channel);
end

function TimersSend_TimerByNr(i,channel)
	if not (Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"mode") == TIMERS_LOC_INC) then
		msg = timerdata[i].name.." "..TIMERS_LOC_EXPIRES_IN..": "..Timers_TimeToText(timerdata[i].time-Timers_GetLocalTime());
	else
		msg = timerdata[i].name.." "..TIMERS_LOC_IS_CURRENTLY_AT..": "..Timers_TimeToText(Timers_GetLocalTime()-timerdata[i].time);
	end	 	
	if not channel then
		channel = Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"channel");
	end
	Timers_MsgSendTo(msg, channel);
end

function TimersSend_AllTimer(channel)
	for i = 1, table.getn(timerdata) do
		TimersSend_TimerByNr(i,channel);
	end
end		

function TimersSend_ToActive(msg)
	local channel = ChatFrameEditBox.chatType;	
	if channel == "WHISPER" then
		SendChatMessage(msg,"WHISPER",nil,ChatFrameEditBox.tellTarget);
	else
		SendChatMessage(msg,ChatFrameEditBox.chatType);
	end
end

function Timers_SpamOnPress(arg)
	if arg == 1 then
		if configdata.spamonpress < table.getn(timerdata) then
			max = configdata.spamonpress
		else
			max = table.getn(timerdata)
		end
	 	for i = 1, max do
			if not (Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"mode") == TIMERS_LOC_INC) then
				msg = timerdata[i].name.." "..TIMERS_LOC_EXPIRES_IN..": "..Timers_TimeToText(timerdata[i].time-Timers_GetLocalTime());
	 		else
				msg = timerdata[i].name.." "..TIMERS_LOC_IS_CURRENTLY_AT..": "..Timers_TimeToText(Timers_GetLocalTime()-timerdata[i].time);
			end	 		
	 		TimersSend_ToActive(msg);
	 	end
	else
		for i = 1, table.getn(timerdata) do
			if timerdata[i].time-Timers_GetLocalTime() < configdata.spamonpress*60 then
				if not (Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"mode") == TIMERS_LOC_INC) then
					msg = timerdata[i].name.." "..TIMERS_LOC_EXPIRES_IN..": "..Timers_TimeToText(timerdata[i].time-Timers_GetLocalTime());
	 			else
					msg = timerdata[i].name.." "..TIMERS_LOC_IS_CURRENTLY_AT..": "..Timers_TimeToText(Timers_GetLocalTime()-timerdata[i].time);
				end	 	
				TimersSend_ToActive(msg);
	 		end
	 	end
	end
end	

function Timers_SpamOnWhisper(arg,name)
	if arg == nil or arg == "" then
		arg = configdata.spamonpress;
	else
		arg = tonumber(arg);
	end
	local NotSend = true;
	for i = 1, table.getn(timerdata) do
		if timerdata[i].time-Timers_GetLocalTime() < arg*60 then
			if not (Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"mode") == TIMERS_LOC_INC) then
				msg = timerdata[i].name.." "..TIMERS_LOC_EXPIRES_IN..": "..Timers_TimeToText(timerdata[i].time-Timers_GetLocalTime());
	 		else
				msg = timerdata[i].name.." "..TIMERS_LOC_IS_CURRENTLY_AT..": "..Timers_TimeToText(timerdata[i].time-Timers_GetLocalTime());
			end	 	
	 		SendChatMessage(msg,"WHISPER",nil,name);
	 		NotSend = false;
	 	end
	end
	if NotSend then
		SendChatMessage(TIMERS_LOC_NO_TIMERS_EXPIRING,"WHISPER",nil,name);
	end
end

function Timers_GetLocalTime()
	local strtime = date("%j%H%M%S");
	local time = tonumber(string.sub(strtime,-2));
	time = time + tonumber(string.sub(strtime,-4,-3)) * 60;			
	time = time + tonumber(string.sub(strtime,-6,-5)) * 3600;	
	time = time + tonumber(string.sub(strtime,-9,-7)) * 86400;
	return time;
end			 

-- OnEvent Functions

function Timers_OnEvent(event)
	if event == "VARIABLES_LOADED" then
		if state and state.triggerList then
			Timers_ImportTrigger();
		end
		Timers_VersionCorrections();
		Timers_CheckForNewTrigger();
		Timers_CorrectTimerData();
		Timers_SetSort(configdata.timersort);
		Timers_WindowControl();
		Timers_TabControl(getglobal("TimersMainFrameTabButton"..configdata.activetab));
	  TimersNameBarNameBox:SetText(configdata.namebartext);
	elseif event == "CHAT_MSG_WHISPER" then
		if (string.find(arg1, "showtime") ~= nil) then
			local _,n = string.find(arg1,"showtime");
			n = tonumber(string.sub(arg1, n+2));
			Timers_SpamOnWhisper(n,arg2);
		end
	elseif event == "TRAINER_CLOSED" or event == "SPELLS_CHANGED" then
		Timers_CreateIconArray();	
	else
		local text;
		if (event == "SPELLCAST_START" or event == "SPELLCAST_STOP" or event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
			Timers_SpellEvent(event,arg1,arg2);
		else
			if (event == "CHAT_MSG_MONSTER_EMOTE") then
				text = arg2.." "..arg1;
			elseif (event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS") then
				Timers_ZoneEvent();
			elseif (event ~= nil) then
				text = arg1;
			end
			if text then
				Timers_EventParser(event,text);
			end
		end
	end
end 

function Timers_OnLoad()

	Timers_OldSpellHook = CastSpell;
	Timers_OldSpellHookByName = CastSpellByName;
	Timers_OldUseAction = UseAction;
	CastSpell = Timers_SpellHook;
	CastSpellByName = Timers_SpellHookByName;
	UseAction = Timers_UseActionHook;
	this:SetBackdropColor(0.0, 0.0, 0.0, 0.8);
	
	this:RegisterEvent("CHAT_MSG_SPELL_TRADESKILLS");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("CHAT_MSG_MONSTER_SAY");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_MONSTER_WHISPER");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("ZONE_CHANGED_INDOORS");
	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("TRAINER_CLOSED");
	this:RegisterEvent("SPELLS_CHANGED");
	
	SlashCmdList["TIMERCOMMANDS"] = Timers_SlashCommandHandler;
	SLASH_TIMERCOMMANDS1 = "/atimer";
	SLASH_TIMERCOMMANDS2 = "/ati";
	triggerdata_DEFAULT = Timers_cloneTable(triggerdata);
	configdata_DEFAULT = Timers_cloneTable(configdata);
	groupdata_DEFAULT = Timers_cloneTable(groupdata);
end

function Timers_CheckForOnce(name)
	for i = 1, table.getn(timerdata) do
		if timerdata[i].trigger == name then
			return false;
		end
	end
	return true;
end

function Timers_CheckForOnceGroup(name)
	for i = 1, table.getn(timerdata) do
		if triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].group == name then
			return false;
		end
	end
	return true;
end

function Timers_ZoneEvent(event)
	if event == "ZONE_CHANGED_NEW_AREA" then
		currentZone = GetZoneText();
	else
		currentZone = GetSubZoneText();
	end
	for i = 1, table.getn(triggerdata) do
		if string.find(triggerdata[i].text,currentZone) and string.find(triggerdata[i].text,TIMERS_LOC_ZONEENTER) then
			Timers_EventParser(event,triggerdata[i].text);
		end
	end
end

function Timers_SpellEvent(event,arg1,arg2)
	if event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then
		currSpellCast = nil;
	elseif event == "SPELLCAST_STOP" then
		if currSpellCast then
			Timers_EventParser(event,currSpellCast.text);
			currSpellCast = nil;
		end	
	end
end

function Timers_ParseSpellName(name)
	Timers_PrintDebug("Action: "..name);
	for i = 1, table.getn(triggerdata) do
		if string.find(triggerdata[i].text, TIMERS_LOC_SPELL_CAST) and string.find(triggerdata[i].text, name) then
			currSpellCast = triggerdata[i];
		end
	end
end	

function Timers_SpellHook(ID,book)
 Timers_ParseSpellName(GetSpellName(ID,book));
 Timers_OldSpellHook(ID,book);
end

function Timers_SpellHookByName(name)
	Timers_ParseSpellName(name);
	Timers_OldSpellHookByName(name);
end

function Timers_UseActionHook(slot,arg1,arg2)
	if (not (GetActionText(slot))) and IconArray[GetActionTexture(slot)] then
		Timers_ParseSpellName(IconArray[GetActionTexture(slot)]);
	end
	Timers_OldUseAction(slot,arg1,arg2);
end
				
function Timers_EventParser(event,msg)
	for i = 1, table.getn(triggerdata) do
		if string.find(msg,triggerdata[i].text) then
			if (not (triggerdata[i].lastinvoked) or triggerdata[i].lastinvoked+tonumber(Timers_GetFieldValue(triggerdata[i],"threshold"))<Timers_GetLocalTime()) and not (triggerdata[i].inactive or groupdata[Timers_GroupNameToNumber(triggerdata[i].group)].inactive) then
				if Timers_GetFieldValue(triggerdata[i],"type") == TIMERS_LOC_MULTIPLE then
					Timers_StartTimer(triggerdata[i],msg);
				elseif Timers_GetFieldValue(triggerdata[i],"type") == TIMERS_LOC_ONCE and Timers_CheckForOnce(triggerdata[i].name) then
					Timers_StartTimer(triggerdata[i],msg);
				elseif Timers_GetFieldValue(triggerdata[i],"type") == TIMERS_LOC_ONCEGROUP and Timers_CheckForOnceGroup(triggerdata[i].group) then
					Timers_StartTimer(triggerdata[i],msg);
				elseif Timers_GetFieldValue(triggerdata[i],"type") == TIMERS_LOC_PAUSE then
					if Timers_CheckForOnceGroup(triggerdata[i].group) then
						Timers_StartTimer(triggerdata[i],msg);
					else
						for j = 1, table.getn(timerdata) do
							if triggerdata[Timers_TriggerNameToNumber(timerdata[j].trigger)].group == triggerdata[i].group then
								TimersEdit_TogglePaused(nil,j);
								Timers_WarnOnly(triggerdata[i],msg,timerdata[j].time);
							end
						end
					end
				elseif Timers_GetFieldValue(triggerdata[i],"type") == TIMERS_LOC_STOP then
					for j = 1, table.getn(timerdata) do
						if triggerdata[Timers_TriggerNameToNumber(timerdata[j].trigger)].group == triggerdata[i].group then
							TimersEdit_StopTimer(arg,j);
						end
					end						
				elseif Timers_GetFieldValue(triggerdata[i],"type") == TIMERS_LOC_WARNONLY then
					Timers_WarnOnly(triggerdata[i],msg);
				end	
			end
			timerUpdateFlag = true;
		end
	end
end

function Timers_StartTimer(trigger,msg)
	trigger.lastinvoked = Timers_GetLocalTime();
	if trigger.count then
		trigger.count = trigger.count + 1;
	else
		trigger.count = 1;
	end
	if configdata.usenamebar then
		Timers_StartByEvent(configdata.namebartext,trigger,msg);
	else
		if not (StaticPopup_Visible(TIMERS_MESSAGE_POPUP)) then
			StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].text = TIMERS_LOC_NEW_TIMER_NAME;
			StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].arg1 = trigger;
			StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].arg2 = msg;
			Timers_OnMessageBoxAccept = Timers_StartByEvent;
			StaticPopup_Show("TIMERS_MESSAGE_POPUP");
		elseif trigger.type == TIMERS_LOC_PAUSE then
			if Timers_OnMessageBoxAccept == Timers_StartPausedByEvent then
				Timers_OnMessageBoxAccept = Timers_StartByEvent;
			else
				Timers_OnMessageBoxAccept = Timers_StartPausedByEvent;
			end
		end			
	end	
end

function Timers_StartByEvent(name,trigger,msg)
	name = string.gsub(name,"!count",Timers_GetFieldValue(trigger,"count"));
	name = string.gsub(name,"!coord",TimersString_Replace_Coord());
	name = string.gsub(name,"!trigger",trigger.name);
	if Timers_GetFieldValue(trigger,"mode") == TIMERS_LOC_INC then		
		table.insert(timerdata, {name=name, time=Timers_GetLocalTime()-tonumber(Timers_GetFieldValue(trigger,"time")), trigger=trigger.name, msg = msg});
	else	
		table.insert(timerdata, {name=name, time=tonumber(Timers_GetFieldValue(trigger,"time"))+Timers_GetLocalTime(), trigger=trigger.name, msg = msg});
	end
	timerUpdateFlag = true;
end

function Timers_StartPausedByEvent(name,trigger,msg)				
	name = string.gsub(name,"!count",Timers_GetFieldValue(trigger,"count"));
	name = string.gsub(name,"!coord",TimersString_Replace_Coord());
	name = string.gsub(name,"!trigger",trigger.name);
	if Timers_GetFieldValue(trigger,"mode") == TIMERS_LOC_INC then		
		table.insert(timerdata, {name=name, time=Timers_GetLocalTime()-tonumber(Timers_GetFieldValue(trigger,"time")), trigger=trigger.name, msg = msg, paused = Timers_GetLocalTime()});
	else	
		table.insert(timerdata, {name=name, time=tonumber(Timers_GetFieldValue(trigger,"time"))+Timers_GetLocalTime(), trigger=trigger.name, msg = msg, paused = Timers_GetLocalTime()});
	end
	timerUpdateFlag = true;
end
	
function Timers_OnUpdate(arg1)
	timeSinceUpdate = timeSinceUpdate + arg1;
	if (timeSinceUpdate > 0.25) then
		if (not UnitAffectingCombat("player")) and inCombat then
			inCombat = false;
			Timers_EventParser(nil,TIMERS_LOC_COMBATSTOP);
		end
		if UnitAffectingCombat("player") and not inCombat then
			inCombat = true;
			Timers_EventParser(nil,TIMERS_LOC_COMBATSTART);
		end
		if configdata.activetab == 1 or configdata.activetab == 2 then 
			if timerUpdateFlag then 
				table.sort(timerdata,Timers_CompareTimers);		
				Timers_SetTimerData();		
				timerUpdateFlag = false;
			end	
			Timers_UpdateTimes();
		end
		if timeIsCorrect then
			TimerscurrentTime = Timers_GetLocalTime();
		end
		if TimersMainFrame:GetScale() ~= (configdata.framescale/100) then
			Timers_ScaleControl();
			-- Timers_WindowControl();
		end
		Timers_UpdateTitle();
		Timers_CheckWarnAllTimers();
		timeSinceUpdate = 0;
	end
end

function TimersMainFrame_OnScroll()
	if configdata.activetab == 1 then
		Timers_SetTimerData();
	elseif configdata.activetab == 3 then
		Timers_SetTriggerData();
	end
end

function TimersFrame_ToggleMinimized()
	if configdata.minimized then
		configdata.minimized = false;
	else
		configdata.minimized = true;
	end
	Timers_MinimizedControl();
end

function Timers_TriggerMenuButton()
	if configdata.activetab == 3 and not getglobal(this:GetParent():GetName().."EditBox2"):IsVisible() then
		local i = Timers_GetRow(this) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
		local k = Timers_RowToGroup(i);
		if groupdata[k].fold then
			groupdata[k].fold = false;
		else
			groupdata[k].fold = true;
		end
		Timers_SetTriggerData();
	else
		ToggleDropDownMenu(1, nil, getglobal(this:GetParent():GetName().."DropDownMenu"), this, 0, 0);
	end
end

function Timers_ToggleFoldAll()
	local fold = 0;
	local unfold = 0;
	for i = 1, table.getn(groupdata) do
		if groupdata[i].fold then
			fold = fold + 1;
		else
			unfold = unfold + 1;
		end
	end
	local set;
	if fold > unfold then
		set = false;
	else
		set = true;
	end
	for i = 1, table.getn(groupdata) do
		groupdata[i].fold = set;
	end
	Timers_SetTriggerData();
end

function Timers_ToggleActiveAll()
	local active = 0;
	local inactive = 0;
	for i = 1, table.getn(triggerdata) do
		if triggerdata[i].inactive then
			inactive = inactive + 1;
		else
			active = active + 1;
		end
	end
	local set;
	if inactive > active then
		set = false;
	else
		set = true;
	end
	for i = 1, table.getn(groupdata) do
		groupdata[i].inactive = set;
	end
	for i = 1, table.getn(triggerdata) do
		triggerdata[i].inactive = set;
	end
	Timers_SetTriggerData();
end

function Timers_ResetAllCnt()
	for i = 1, table.getn(timerdata) do
		timerdata[i].count = 0;
	end
	Timers_SetTriggerData();
end

function Timers_ResetCnt(arg)
	local i = Timers_GetRow(arg) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	triggerdata[Timers_RowToTrigger(i)].count = "0";
	Timers_SetTriggerData();
end

function Timers_DeleteTrigger(arg)
	local i = Timers_GetRow(arg) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	table.remove(triggerdata,Timers_RowToTrigger(i));
	Timers_SetTriggerData();
end



-- System functions

function Timers_CompareTimers(item1, item2)
	if configdata.timersort == 1 then	
		if configdata.timersortascending then
			return item1.name < item2.name;
		else
			return item1.name > item2.name;
		end
	elseif configdata.timersort == 2 then
		if configdata.timersortascending then
			return tonumber(item1.time) < tonumber(item2.time);
		else
			return tonumber(item1.time) > tonumber(item2.time);
		end
	end		
end

function Timers_CompareTriggers(item1, item2)
	if configdata.triggersort == 1 then	
		return Timers_SortByText(item1,item2,"name");
	elseif configdata.triggersort == 2 then
		return Timers_SortByNumber(item1,item2,"time");
	elseif configdata.triggersort == 3 then
		return Timers_SortByNumber(item1, item2,"prewarn");
	elseif configdata.triggersort == 4 then
		return Timers_SortByText(item1,item2,"text");
	elseif configdata.triggersort == 5 then
		return Timers_SortByText(item1,item2,"message");
	elseif configdata.triggersort == 6 then
		return Timers_SortByText(item1,item2,"channel");
	elseif configdata.triggersort == 7 then
		return Timers_SortByNumber(item1,item2,"count");
	elseif configdata.triggersort == 8 then
		return Timers_SortByNumber(item1,item2,"threshold");
	elseif configdata.triggersort == 9 then
		return Timers_SortByText(item1,item2,"type");
	elseif configdata.triggersort == 10 then
		return Timers_SortByText(item1,item2,"mode");
	end							
end

function Timers_CompareGroups(item1, item2)
	return item1.name < item2.name;
end

function Timers_SortByNumber(item1,item2,field)
	if not tonumber(item1[field]) or not tonumber(item2[field]) then
		if not tonumber(item1[field]) and not tonumber(item2[field]) then
			return false;
		elseif not tonumber(item1[field]) then
			if configdata.triggersortascending then
				return tonumber(Timers_GetDefaultValue(field)) < tonumber(item2[field]);
			else
				return tonumber(Timers_GetDefaultValue(field)) > tonumber(item2[field]);
			end
		else
			if configdata.triggersortascending then
				return tonumber(item1[field]) < tonumber(Timers_GetDefaultValue(field));
			else
				return tonumber(item1[field]) > tonumber(Timers_GetDefaultValue(field));
			end
		end						
	elseif configdata.triggersortascending then				
		return tonumber(item1[field]) < tonumber(item2[field]);
	else
		return tonumber(item1[field]) > tonumber(item2[field]);
	end
end

function Timers_SortByText(item1,item2,field)
	if not item1[field] or not item2[field] then
		if not item1[field] and not item2[field] then
			return false;
		elseif not item1[field] then
			if configdata.triggersortascending then
				return Timers_GetDefaultValue(field) < item2[field];
			else
				return Timers_GetDefaultValue(field) > item2[field];
			end
		elseif configdata.triggersortascending then
			return item1[field] < Timers_GetDefaultValue(field);
		else
			return item1[field] > Timers_GetDefaultValue(field);
		end
	else
		if configdata.triggersortascending then
			return item1[field] < item2[field];
		else
			return item1[field] > item2[field];
		end
	end										
end

function Timers_DeleteGroup(nr)
	local hasTrigger = false;
	for i = 1, table.getn(triggerdata) do
		if triggerdata[i].group == groupdata[nr].name then
			hasTrigger = true;
			triggerdata[i].fromGroup = true;
		end
	end
	table.remove(groupdata, nr);
	if hasTrigger then
		StaticPopupDialogs["TIMERS_ACCEPT_POPUP"].text = TIMERS_LOC_DELETE_GROUP_NOT_EMPTY;
		Timers_OnAcceptBoxButton = Timers_SetNewGroupByBox;
		StaticPopup_Show("TIMERS_ACCEPT_POPUP");	
	else	
		Timers_SetTriggerData();
	end
end

function Timers_TextToTime(text)
	local i = 0;
	local mul = 1;
	local time = 0;
	local minus = false;
	if string.sub(text,1,1) == "-" then
		minus = true;
		text = string.sub(text,2);
	end
	while string.find(text,":") do
		Pos = string.find(text,":",-3);
		time = time + mul*tonumber(string.sub(text,Pos+1));
		text = string.sub(text,1,Pos-1);
		mul = mul*60;
		i=i+1;
	end
	if i == 3 then 
		mul = 86400;
	end
	time = time + mul*tonumber(text);	
	if minus then
		time = -time;
	end
	return time;	
end

function Timers_GetRow(arg)
	local i = 10;
	while i > 0 do
		if string.find(arg:GetName(),"Row"..i) then
			return i;
		end
		i = i - 1;
	end
end

function Timers_ParseArguments(msg)
	local args = {};
	local tmp = {};

	-- Find all space delimited words.
	for value in string.gfind(msg, "[^ ]+") do
		table.insert(tmp, value);
	end
	
	-- Make a pass through the table, and concatenate all words that have quotes.
	local quoteOpened = false;
	local quotedArg = "";
	for i = 1, table.getn(tmp) do
		if (string.find(tmp[i], "\"") == nil) then
			if (quoteOpened) then
				quotedArg = quotedArg.." "..string.gsub(tmp[i], "\"", "");
			else
				table.insert(args, tmp[i]);
			end
		else
			for value in string.gfind(tmp[i], "\"") do
				quoteOpened = not quoteOpened;
			end

			if (quoteOpened) then
				quotedArg = string.gsub(tmp[i], "\"", "");
			else
				if (string.len(quotedArg) > 0) then
					quotedArg = quotedArg.." "..string.gsub(tmp[i], "\"", "");
				else
					quotedArg = string.gsub(tmp[i], "\"", "");
				end
				
				table.insert(args, quotedArg);
				quotedArg = "";
			end
		end
	end
	
	if (string.len(quotedArg) > 0) then
		table.insert(args, quotedArg);
	end
	
	return args;
end

function Timers_SlashCommandHandler(msg)
	local command;
	local args;

	args = Timers_ParseArguments(msg);

	if (args[1] ~= nil) then
		command = string.lower(args[1]);
	end	

	if (command == "add") and (args[2] ~= nil and args[3] ~=nil) then
		Timers_add(args[2], args[3], args[4]);
	elseif (command == "reset") then
		TimersSlash_Reset();
	elseif (command == "invoke" and args[2] ~= nil) then
		TimersSlash_Invoke(args[2]);		
	elseif (command == "show") then
		ShowUIPanel(TimersMainFrame);
	elseif (command == "debug") then
		Timers_ToggleDebug()
	end		
end

function Timers_ShowMainPanel()
	ShowUIPanel(TimersMainFrame);
	if configdata.minimized then
		TimersFrame_ToggleMinimized();
	end
end

function Timers_PrintDebug(text)
	if Timers_Debug then
		Timers_PrintText("[DEBUG] "..text);
	end
end

function Timers_ToggleDebug()
	if Timers_Debug then
		Timers_Debug = false;
	else
		Timers_Debug = true;
	end
end

function Timers_PrintText(text)
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00[Timers]: "..text.."|r");
end

function Timers_TimeToText(time)
	local TIME_FORMAT = "%02d:%02d:%02d";
	local TIME_FORMAT_D = "%02d:%02d:%02d:%02d";
	local absTime = math.abs(time);

	local days=0;
	local hours = absTime / 3600;
	local minutes = math.mod(absTime / 60, 60);
	local seconds = math.mod(absTime, 60);
	
	if(hours>=24) then
		days = hours/24;
		hours = math.mod(hours, 24);
	end

	if (time >= 0) then
		if (days>0) then
			return format(TIME_FORMAT_D, days, hours, minutes, seconds);
		else
			return format(TIME_FORMAT, hours, minutes, seconds);
		end
	else
		return format("-"..TIME_FORMAT, hours, minutes, seconds);
	end
end

function Timers_GetDefaultValue(field)
	if field == "text" then
		return " ";
	end
	for i = 1, table.getn(triggerdata) do
		if triggerdata[i].name == "default" then
			return triggerdata[i][field];
		end
	end
end

-- Core Functions

function Timers_AddGroup()
	StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].text = TIMERS_LOC_NEW_GROUP_NAME;
	Timers_OnMessageBoxAccept = Timers_GetNewGroupName;
	StaticPopup_Show("TIMERS_MESSAGE_POPUP");
end

function Timers_AddTrigger()
	table.insert(triggerdata, {["name"] = "New Trigger", ["text"] = TIMERS_LOC_EMPTYTEXT, ["isnotdefault"] = true});
	groupdata[Timers_GroupNameToNumber(TIMERS_LOC_NOGROUP)].fold = false;
	Timers_SetTriggerData();
end

function Timers_ResetAllTrigger()
	StaticPopupDialogs["TIMERS_ACCEPT_POPUP"].text = TIMERS_LOC_DELETE_ALL_NON_DEFAULT;
	Timers_OnAcceptBoxButton = Timers_ResetAllTriggerMsg;
	StaticPopup_Show("TIMERS_ACCEPT_POPUP");
end

function Timers_ResetAllTriggerMsg(nondefault)
	if nondefault then
		triggerdata = {};
	end
	for i = 1, table.getn(triggerdata_DEFAULT) do
		Timers_ResetByTrigger(triggerdata_DEFAULT[i]);
	end
	table.sort(triggerdata,Timers_CompareTriggers);
	Timers_SetTriggerData();
end	

function Timers_ResetTriggerByRow(arg)
	local trigger = triggerdata_DEFAULT[Timers_TriggerNameToDefaultNumber(triggerdata[Timers_RowToTrigger(Timers_GetRow(arg)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].name)];
	Timers_ResetByTrigger(trigger);
	Timers_SetTriggerData();
end

function Timers_ResetByTrigger(trigger)
	local j = table.getn(triggerdata);
	while j > 0 do
		if triggerdata[j].name == trigger.name then
			table.remove(triggerdata,j); 
		end
		j = j - 1;
	end
	table.insert(triggerdata,Timers_cloneTable(trigger));	
end

function Timers_cloneTable(t)            
  local new = {};             
  local i, v = next(t, nil);  
  while i do
 		if type(v)=="table" then 
 			v=Timers_cloneTable(v);
 		end
    new[i] = v;
    i, v = next(t, i);        
  end
  return new;
end

function Timers_GetNewGroupName(text)
	table.insert(groupdata, {["name"] = text, ["isnotdefault"] = true});
	Timers_SetTriggerData();
end

function Timers_SetNewGroupByBox(state)
	local i = table.getn(triggerdata);
	while i > 0 do
		if triggerdata[i].fromGroup then
			if state then
				table.remove(triggerdata,i);
			else
				triggerdata[i].group = nil;
				triggerdata[i].fromGroup = nil;
			end
		end
	i = i - 1;
	end
	Timers_SetTriggerData();
end 

function Timers_SetTriggerData()
	table.sort(groupdata,Timers_CompareGroups);
	table.sort(timerdata,Timers_CompareTimers);
	local group;
	-- create Pointer list
	Timers_Init_TriggerPointer();
	local Max = 0
	for i = 1, table.getn(triggerPointer) do
		if triggerPointer[i] then
			Max = Max + 1;
		end
	end
	for i = 1, table.getn(triggerdata) do
		group = Timers_GroupNameToNumber(triggerdata[i].group);
		if(not(groupdata[group].fold) and not((groupdata[group].inactive or triggerdata[i].inactive) and configdata.hideinactive)) then
			table.insert(triggerPointer[group],i);
			Max = Max + 1;
		end 
	end	
	FauxScrollFrame_Update(TimersMainFrameScrollFrame, Max, 10, 20);
	Timers_Print_TriggerPointer();
end	

function Timers_Print_TriggerPointer()
	local Offset = FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	local Alli = 1;
	for i = 1, table.getn(triggerPointer) do
		if triggerPointer[i] then
			if Alli > Offset and Alli - Offset <= 10 then
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox1"):SetText("--- "..groupdata[i].name.." ---");
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox1"):SetTextColor(0.2,0.2,1,1);
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpByPlaytime"):Show();
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpByPlaytime"):SetChecked(groupdata[i].byplaytime);
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpByPlaytimeTitle"):Show();
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpResetCnt"):Show();
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpResetCnt"):SetChecked(groupdata[i].onstartreset);
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpResetCntTitle"):Show();
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpDeleteTimer"):Show();
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpDeleteTimer"):SetChecked(groupdata[i].onstartdelete);				
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpDeleteTimerTitle"):Show();
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpOnStartTitle"):Show();
				getglobal("TimersMainFrameTimerRow"..(Alli-Offset)):Show();
				if groupdata[i].inactive then
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."Active"):SetChecked(false);
				else
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."Active"):SetChecked(true);
				end
				if groupdata[i].fold then
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."MenuButton"):SetText("+");
				else
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."MenuButton"):SetText("-");
				end
				for j = 2, 5 do
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox"..j):Hide();
				end
			end													
			Alli = Alli + 1;
			for j = 1, table.getn(triggerPointer[i]) do
				if Alli > Offset and Alli - Offset <= 10 then
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox1"):SetText(triggerdata[triggerPointer[i][j]].name);
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox1"):SetTextColor(1,1,1,1);
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpByPlaytime"):Hide();
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpByPlaytimeTitle"):Hide();
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpResetCnt"):Hide();
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpResetCntTitle"):Hide();
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpDeleteTimer"):Hide();					
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpDeleteTimerTitle"):Hide();
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."GrpOnStartTitle"):Hide();	
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."MenuButton"):SetText("!");
					if triggerdata[triggerPointer[i][j]].inactive then
						getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."Active"):SetChecked(false);
					else
						getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."Active"):SetChecked(true);
					end
					for j = 2, 5 do
						getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox"..j):Show();
					end	
					Timers_SetEditBox(triggerdata[triggerPointer[i][j]],"time",(Alli-Offset),"2");
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox2"):SetTextColor(1,1,1,1);	
					Timers_SetEditBox(triggerdata[triggerPointer[i][j]],"prewarn",(Alli-Offset),"3");	
					Timers_SetEditBox(triggerdata[triggerPointer[i][j]],"text",(Alli-Offset),"4");						
					if triggerdata[triggerPointer[i][j]].count == nil then
						triggerdata[triggerPointer[i][j]].count = 0;
					end
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset).."EditBox5"):SetText(triggerdata[triggerPointer[i][j]].count);												
					getglobal("TimersMainFrameTimerRow"..(Alli-Offset)):Show();
				end
				Alli = Alli + 1;
			end
		end
	end
	if Alli-Offset <= 10 then
		if Alli <= Offset then
			Alli = Offset + 1;
		end 
		for k = Alli-Offset, 10 do
			getglobal("TimersMainFrameTimerRow"..k):Hide();
		end
	end			
end

function Timers_ToggleShowInactive()
	if configdata.hideinactive then
		configdata.hideinactive = false;
		Timers_PrintText(TIMERS_LOC_SHOWINACTIVE);
	else
		configdata.hideinactive = true;
		Timers_PrintText(TIMERS_LOC_HIDEINACTIVE);
	end
	Timers_SetTriggerData();
end

function Timers_GroupNameToNumber(name)
	if name == nil then
		name = TIMERS_LOC_NOGROUP;
	end
	for i = 1, table.getn(groupdata) do
		if groupdata[i].name == name then
			return i;
		end
	end
	return Timers_GroupNameToNumber(nil);
end

function Timers_TriggerNameToNumber(name)
	if name == nil then
		name = "default";
	end
	for i = 1, table.getn(triggerdata) do
		if triggerdata[i].name == name then
			return i;
		end
	end
	return Timers_TriggerNameToNumber(nil);
end

function Timers_TriggerNameToDefaultNumber(name)
	for i = 1, table.getn(triggerdata_DEFAULT) do
		if triggerdata_DEFAULT[i].name == name then
			return i;
		end
	end
	return nil;
end

function Timers_RowToGroup(i)
	local j = 1;
	local k = 1;
	while j < i do
		j = j + 1 + table.getn(triggerPointer[k]);
		k = k + 1;
	end
	return k;
end

function Timers_RowToTrigger(i)
	local j = 0;
	local k = 0;
	while j < i do
		j = j + 1 + table.getn(triggerPointer[k+1]);
		k = k + 1;
	end
	return triggerPointer[k][(table.getn(triggerPointer[k])-(j-i))];
end

function Timers_ToggleTriggerActive()
	if getglobal(this:GetParent():GetName().."EditBox2"):IsVisible() then
		if this:GetChecked() then
			triggerdata[Timers_RowToTrigger(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].inactive = false;
		else
			triggerdata[Timers_RowToTrigger(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].inactive = true;
		end
	else
		if this:GetChecked() then
			groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].inactive = false;
		else
			groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].inactive = true;
		end
	end
	Timers_SetTriggerData();
end

function Timers_ToggleGrpByPlaytime()
	if this:GetChecked() then
		groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].byplaytime = true;
	else
		groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].byplaytime = nil;
	end
end

function Timers_ToggleGrpDeleteTimer()
	if this:GetChecked() then
		groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].onstartdelete = true;
	else
		groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].onstartdelete = nil;
	end
end

function Timers_ToggleGrpResetCnt()
	if this:GetChecked() then
		groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].onstartreset = true;
	else
		groupdata[Timers_RowToGroup(Timers_GetRow(this)+FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].onstartreset = nil;
	end
end

function Timers_Init_TriggerPointer()
	triggerPointer = {};
	for i = 1, table.getn(groupdata) do
		if groupdata[i].inactive and configdata.hideinactive then
			triggerPointer[i] = false;
		else
			triggerPointer[i] = {};
		end
	end
end

function Timers_GetFieldValue(trigger,field)
	if trigger[field] and trigger[field] ~= TIMERS_LOC_DEFAULT then 
		return trigger[field];
	else
		if field == "count" then
			return "0";
		elseif field == "group" then
			return TIMERS_LOC_NOGROUP;
		else
			for i = 1, table.getn(triggerdata) do
				if triggerdata[i].name == "default" then
					return triggerdata[i][field];
				end
			end
		end
	end
end

function Timers_SetEditBox(trigger,field,row,nr)
	if trigger[field] == nil and (field == "channel" or field == "mode" or field == "type") then
		trigger[field] = TIMERS_LOC_DEFAULT;
	end
	if trigger[field] == nil then
		for i = 1, table.getn(triggerdata) do
			if triggerdata[i].name == "default" then
				if field == "time" then
					getglobal("TimersMainFrameTimerRow"..row.."EditBox"..nr):SetText(Timers_TimeToText(tonumber(triggerdata[i][field])));
				else		
					getglobal("TimersMainFrameTimerRow"..row.."EditBox"..nr):SetText(triggerdata[i][field]);
				end
			end
		end
	elseif field == "time" then
		getglobal("TimersMainFrameTimerRow"..row.."EditBox"..nr):SetText(Timers_TimeToText(tonumber(trigger[field])));
	else		
		getglobal("TimersMainFrameTimerRow"..row.."EditBox"..nr):SetText(trigger[field]);
	end
end
	
function Timers_add(name,time,trigger)
	if tonumber(time) then
		time = time*60;
	else
		time = Timers_TextToTime(time);
	end
	local isnotValid = true;
	for i = 1, table.getn(triggerdata) do
		if triggerdata[i].name == trigger then
			if not time then
				time = triggerdata[i].time;
			end
			isnotValid = false;
		end
	end
	if isnotValid then
		trigger = "default";
	end
	if Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(trigger)],"mode") == TIMERS_LOC_INC then		
		table.insert(timerdata, {name=name, time=Timers_GetLocalTime(), trigger=trigger});
	else	
		table.insert(timerdata, {name=name, time=time+Timers_GetLocalTime(), trigger=trigger});
	end
	timerUpdateFlag = true;
	Timers_PrintText(TIMERS_LOC_TIMERADDED);
end

function Timers_SetTimerData()	
	local Offset = FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	local Max = table.getn(timerdata);
	for i = 1 , 10 do
		if Max < i+Offset then 
			getglobal("TimersMainFrameTimerRow"..i):Hide();
		else
			getglobal("TimersMainFrameTimerRow"..i.."EditBox1"):SetText(timerdata[i+Offset].name);
			getglobal("TimersMainFrameTimerRow"..i.."EditBox1"):SetTextColor(1,1,1,1);			
			getglobal("TimersMainFrameTimerRow"..i):Show();
		end
	end
	FauxScrollFrame_Update(TimersMainFrameScrollFrame, table.getn(timerdata), 10, 20);
end	

function Timers_UpdateTimes()					
	local Offset = FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	local Max = table.getn(timerdata);
	for i = 1 , 10 do
		if Max >= i+Offset then 
			if not timerdata[i+Offset].paused and not timerdata[i+Offset].editing then	
				if Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i+Offset].trigger)],"mode") == TIMERS_LOC_INC then		
					getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetText(Timers_TimeToText(Timers_GetLocalTime()-timerdata[i+Offset].time));							
					getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetTextColor(1,1,1,1);	
				else
					getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetText(Timers_TimeToText(timerdata[i+Offset].time-Timers_GetLocalTime()));			
					if timerdata[i+Offset].time-Timers_GetLocalTime() > 0 then
						getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetTextColor(1,1,1,1);				
					else
						getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetTextColor(1,0,0,1);
					end			
					if timerdata[i+Offset].paused then
						getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetTextColor(1,1,0,1);
					end	
				end
			elseif timerdata[i+Offset].paused and not timerdata[i+Offset].editing then
				getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetText(Timers_TimeToText(timerdata[i+Offset].paused-timerdata[i+Offset].time));						
				getglobal("TimersMainFrameTimerRow"..i.."EditBox2"):SetTextColor(1,1,0,1);	
			end					
		end
	end
end	

function Timers_UpdateTitle()
	local Title = "Timers "..configdata.titletext;
	Title = string.gsub(Title,"!tNext",TimersString_Replace_tNext());
	Title = string.gsub(Title,"!iAll",TimersString_Replace_iAll());
	Title = string.gsub(Title,"!iExpired",TimersString_Replace_iExpired());
	Title = string.gsub(Title,"!nNext",TimersString_Replace_nNext());
	if configdata.minimized then
		TimersMinimizedFrameTitle:SetText(Title);
	else
		TimersMainFrameTitle:SetText(Title);
	end
end

function Timers_CheckForNewTrigger()
	for i = 1, table.getn(groupdata_DEFAULT) do
		local notFound = true;
		for j = 1, table.getn(groupdata) do
			if groupdata_DEFAULT[i].name == groupdata[j].name then
				notFound = false;
			end
		end
		if notFound then
			table.insert(groupdata,Timers_cloneTable(groupdata_DEFAULT[i]));
		end
	end
	for i = 1, table.getn(triggerdata_DEFAULT) do
		local notFound = true;
		for j = 1, table.getn(triggerdata) do
			if triggerdata_DEFAULT[i].name == triggerdata[j].name then
				notFound = false;
			end
		end
		if notFound then
			table.insert(triggerdata,Timers_cloneTable(triggerdata_DEFAULT[i]));
		end
	end
end

function Timers_CorrectTimerData()
	if TimerscurrentTime then
		local Div = Timers_GetLocalTime() - TimerscurrentTime;
		local i = table.getn(timerdata);
		while i > 0 do
			if groupdata[Timers_GroupNameToNumber(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].group)].byplaytime then
				timerdata[i].time = timerdata[i].time + Div;
				if timerdata[i].paused then
					timerdata[i].paused = timerdata[i].paused + Div;
				end
				error("corrected");
			end
			if groupdata[Timers_GroupNameToNumber(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].group)].onstartdelete then		
				table.remove(timerdata,i);
			end
			i = i -1;
		end
	end
	timeIsCorrect = true;
	for i = 1, table.getn(triggerdata) do
		if groupdata[Timers_GroupNameToNumber(triggerdata[i].group)].onstartreset then
			triggerdata[i].count = 0;
		end
	end
end

function Timers_VersionCorrections()
-- zu 3.2 (reload default trigger vor warnmessage/channel
	if (not (Timers_GetDefaultValue("warnmessage"))) then
		local trigger;
		for i = 1, table.getn(triggerdata_DEFAULT) do
			if triggerdata_DEFAULT[i].name == "default" then
				trigger = triggerdata_DEFAULT[i];
			end
		end
		Timers_ResetByTrigger(trigger);
	end
end

-- String replacements
function TimersString_Replace_tNext()
	local time;
	for i = 1, table.getn(timerdata) do
		if timerdata[i].time > Timers_GetLocalTime() and (time == nil or timerdata[i].time < time) and triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].mode ~= TIMERS_LOC_INC then 
			time = timerdata[i].time;
		end
	end
	if time ~= nil then
		return Timers_TimeToText(time-Timers_GetLocalTime());
	else 
		return 0;
	end
end

function TimersString_Replace_Coord()
	local x,y = GetPlayerMapPosition("player");
	x = math.ceil(x*1000)/10;
	y = math.ceil(y*1000)/10;
	return (x.."/"..y)
end

function TimersString_Replace_iAll()
	return table.getn(timerdata);
end

function TimersString_Replace_iExpired()
	local Expired = 0;
	for i = 1, table.getn(timerdata) do
		if timerdata[i].time < Timers_GetLocalTime() then 
			Expired = Expired + 1;
		end
	end
	return Expired;
end

function TimersString_Replace_nNext()
	local time, name;
	for i = 1, table.getn(timerdata) do
		if timerdata[i].time > Timers_GetLocalTime() and (time == nil or timerdata[i].time < time) then 
			time = timerdata[i].time;
			name = timerdata[i].name;
		end
	end
	if name ~= nil then
		return name;
	else 
		return "--";
	end
end

function TimersString_Replace_Msgsub(timer)
	return string.gsub(timer.msg,triggerdata[Timers_TriggerNameToNumber(timer.trigger)].text," ");
end

function TimersString_Replace_Msgsub_4Warn(trigger,msg)
	return string.gsub(msg,trigger.text," ");
end
	
-- Edit Functions

function TimersEdit_SaveName()
	if this:GetText() == "" then
		this:SetText(TIMERS_LOC_NO_NAME_SET);
	end
	if this:GetText() == "default" then
		this:SetText("newdefault");
	end
	if string.find(this:GetName(),"Row") then
		local i = Timers_GetRow(this) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
		if configdata.activetab == 1 or configdata.activetab == 2 then
			timerdata[i].name = this:GetText();
		elseif getglobal(this:GetParent():GetName().."EditBox2"):IsVisible() then
			triggerdata[Timers_RowToTrigger(i)].name = this:GetText();
		else
			for j = 1, table.getn(triggerdata) do
				if triggerdata[j].group == groupdata[Timers_RowToGroup(i)].name then
					triggerdata[j].group = this:GetText();
				end
			end
			groupdata[Timers_RowToGroup(i)].name = this:GetText();
		end
	else
		triggerdata[trigger_edit].name = this:GetText();
	end
	Timers_SetTriggerData();	
end

function TimersEdit_DeleteAllTimer()
	timerdata = {};
	timerUpdateFlag = true;
end

function TimersEdit_DeleteExpired()
 	local i = table.getn(timerdata);
 	while i > 0 do
 		if timerdata[i].time-Timers_GetLocalTime() < 0 then
 			table.remove(timerdata, i);
 		end
 		i = i - 1;
	end
	timerUpdateFlag = true;
end

function TimersEdit_DeleteByGroup(grp)
 	local i = table.getn(timerdata);
 	while i > 0 do
 		if triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].group == grp or (grp == TIMERS_LOC_NOGROUP and not triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].group) then
 			table.remove(timerdata, i);
 		end
 		i = i - 1;
	end
	timerUpdateFlag = true;
end

function TimersEdit_DeleteTimer(arg)
	local i = Timers_GetRow(arg) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	table.remove(timerdata, i);
	timerUpdateFlag = true;
end

function TimersEdit_TogglePaused(arg,i)
	if i == nil then
		i = Timers_GetRow(arg) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	end
	if timerdata[i].paused == nil then
		timerdata[i].paused = Timers_GetLocalTime();
	else
		timerdata[i].time = timerdata[i].time + (Timers_GetLocalTime() - timerdata[i].paused);
		timerdata[i].paused = nil;
	end
end 

function TimersEdit_StopTimer(arg,i)
	if i == nil then
		i = Timers_GetRow(arg) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	end
	timerdata[i].paused = Timers_GetLocalTime();
	timerdata[i].stopped = true;
	timerUpdateFlag = true;
end

function TimersEdit_ResetTimer(arg,i)
	if i == nil then
		i = Timers_GetRow(arg) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	end
	TimersEdit_ResetTimerByNr(i);
	timerUpdateFlag = true;
end

function TimersEdit_ResetTimerByNr(i)
	timerdata[i].time = triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].time+Timers_GetLocalTime();
	timerdata[i].prewarned = nil;
	timerdata[i].warned = nil;
end

function TimersEdit_ResetExpired()
	for i = 1, table.getn(timerdata) do
		if timerdata[i].time-Timers_GetLocalTime() < 0 then
			TimersEdit_ResetTimerByNr(i);
		end
	end			
	timerUpdateFlag = true;
end

function TimersEdit_ResetByGroup(grp)
	for i = 1, table.getn(timerdata) do
		if triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].group == grp or (grp == TIMERS_LOC_NOGROUP and not triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)].group) then
			TimersEdit_ResetTimerByNr(i);		
		end
	end			
	timerUpdateFlag = true;
end
	
function TimersEdit_ResetAll()
	for i = 1, table.getn(timerdata) do
		TimersEdit_ResetTimerByNr(i)
	end			
	timerUpdateFlag = true;
end

function TimersEdit_EditTime()
	local i = Timers_GetRow(this) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);	
	if configdata.activetab == 1 or configdata.activetab == 2 then
		timerdata[i].editing = true;
	end
end 

function TimersEdit_EditName()
	if not (configdata.activetab == 1 or configdata.activetab == 2) then
		if not getglobal(this:GetParent():GetName().."EditBox2"):IsVisible() then
			if groupdata[Timers_RowToGroup(Timers_GetRow(this) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame))].isnotdefault then
				this:SetText(string.sub(this:GetText(),5,-5));
			else
				this:ClearFocus();
				StaticPopupDialogs["TIMERS_ERROR_POPUP"].text = TIMERS_LOC_NOT_EDIT_DEFAULT_GROUPS;
				StaticPopup_Show("TIMERS_ERROR_POPUP");
			end
		else
			if this:GetText() == "default" then
				this:ClearFocus();
				StaticPopupDialogs["TIMERS_ERROR_POPUP"].text = TIMERS_LOC_NOT_EDIT_DEFAULT;
				StaticPopup_Show("TIMERS_ERROR_POPUP");
			end
		end			
	end
end

function TimersEdit_EditNameAdv()
	if this:GetText() == "default" then
		this:ClearFocus();
		StaticPopupDialogs["TIMERS_ERROR_POPUP"].text = TIMERS_LOC_NOT_EDIT_DEFAULT;
		StaticPopup_Show("TIMERS_ERROR_POPUP");
	end
end

function TimersEdit_SaveTime()
	if this:GetText() == "" then
		this:SetText("0");
	end
	if string.find(this:GetName(),"Row") then
		local i = Timers_GetRow(this) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);	
		if configdata.activetab == 1 or configdata.activetab == 2 then
			local time = Timers_TextToTime(this:GetText());
			timerdata[i].time = Timers_GetLocalTime()+time;
			timerdata[i].editing = nil;
		else
			triggerdata[Timers_RowToTrigger(i)].time = Timers_TextToTime(this:GetText());
		end
	else
		triggerdata[trigger_edit].time = Timers_TextToTime(this:GetText());
	end		
	Timers_SetTriggerData();
end

function TimersEdit_SaveChannel(caller,text)
	TimersMenu_SetEditBoxText(caller,text);
	if string.find(caller:GetName(),"Warn") then
		triggerdata[trigger_edit].warnchannel = text;
	else	
		triggerdata[trigger_edit].channel = text;
	end
	Timers_SetTriggerData();
end

function TimersEdit_SaveMode(caller, text)
	TimersMenu_SetEditBoxText(caller,text);
	triggerdata[trigger_edit].mode = text;
	Timers_SetTriggerData();
end	

function TimersEdit_SaveType(caller, text)
	TimersMenu_SetEditBoxText(caller,text);
	triggerdata[trigger_edit].type = text;
	Timers_SetTriggerData();
end	

function TimersEdit_SaveTextImplicit(arg,text)
	local i;
	if string.find(arg:GetName(),"Row") then
		i = Timers_RowToTrigger(Timers_GetRow(arg) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame));
	else
		i = trigger_edit;
	end
	if triggerdata[i].name == "default" then
		StaticPopupDialogs["TIMERS_ERROR_POPUP"].text = TIMERS_LOC_NOT_TEXT;
		StaticPopup_Show("TIMERS_ERROR_POPUP");
	else		
		triggerdata[i].text = text;
	end
	if i == trigger_edit then
		TimersTriggersConfigFrameTextBox:SetText(text);
	end
	Timers_SetTriggerData();
end
	
function TimersEdit_SaveText()
	local i;
	if string.find(this:GetName(),"Row") then
		i = Timers_RowToTrigger(Timers_GetRow(this) + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame));
	else
		i = trigger_edit;
	end
	if triggerdata[i].name == "default" then
		StaticPopupDialogs["TIMERS_ERROR_POPUP"].text = TIMERS_LOC_NOT_TEXT;
		StaticPopup_Show("TIMERS_ERROR_POPUP");
	else		
		triggerdata[i].text = this:GetText();
	end
end	

function TimersEdit_SaveMessage()
	if string.find(this:GetName(),"Warn") then
		if Timers_GetDefaultValue("warnmessage") ~= this:GetText() then
			triggerdata[trigger_edit].warnmessage = this:GetText();	
		end
	else
		if Timers_GetDefaultValue("message") ~= this:GetText() then
			triggerdata[trigger_edit].message = this:GetText();	
		end
	end
	Timers_SetTriggerData();
end	

function TimersEdit_SaveCount()
	triggerdata[trigger_edit].count = this:GetText();
end	

function TimersEdit_SaveThreshold()
	triggerdata[trigger_edit].threshold = this:GetText();
end	

function TimersEdit_SavePrewarn()
	triggerdata[trigger_edit].prewarn = this:GetText();
end	

function Timers_MoveToGroup(row, nr)
	local i = row + FauxScrollFrame_GetOffset(TimersMainFrameScrollFrame);
	triggerdata[Timers_RowToTrigger(i)].group = groupdata[nr].name;
	Timers_SetTriggerData();
end

function Timers_StartMoving(frame)
	if not (configdata.activetab == 2) then
		frame:StartMoving();
	end
end

function Timers_OnMessageBoxAccept(text)
end

function Timers_OnAcceptBoxButton(state)
end

function Timers_CheckWarnAllTimers()
	local msg;
	local i = table.getn(timerdata);
	while i > 0 do
		if not (Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"mode") == TIMERS_LOC_INC) then
			local currTrigger = Timers_TriggerNameToNumber(timerdata[i].trigger);
			if (not timerdata[i].prewarned and Timers_GetFieldValue(triggerdata[currTrigger],"prewarn") ~= "0" and timerdata[i].time-Timers_GetLocalTime() <= tonumber(Timers_GetFieldValue(triggerdata[currTrigger],"prewarn"))*60) then
				Timers_WarnTimer(timerdata[i],true);
				timerdata[i].prewarned = true;
			end		
			if (not timerdata[i].warned and timerdata[i].time-Timers_GetLocalTime() <= 0) then
				Timers_WarnTimer(timerdata[i],false);
				timerdata[i].warned = true;
				if Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"mode") == TIMERS_LOC_DELETE then
					table.remove(timerdata,i);
					timerUpdateFlag = true;
				elseif Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timerdata[i].trigger)],"mode") == TIMERS_LOC_RESET then
					TimersEdit_ResetTimer(nil,i);
				end
			end			
		end
	i = i - 1;
	end
end	

function Timers_ImportTrigger()
	Timers_PrintText(TIMERS_LOC_IMPORTING);
	local counter = 0;
	for index, trigger in state.triggerList do
		local notfound = true;
		for i = 1, table.getn(triggerdata) do
			if string.tolower(triggerdata[i].name) == string.tolower(index) then
				notfound = false;
			end
		end
		if notfound then
			table.insert(triggerdata,{name=index, time=state.triggerList[index].time, isnotdefault = true});
			counter = counter + 1;
		end
	end
	Timers_PrintText(counter..TIMERS_LOC_IMPORTED);
end

function Timers_WarnTimer(timer,prewarn)
	local msg;
	local channel;
	if prewarn then
		msg = Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timer.trigger)],"warnmessage");
		channel = Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timer.trigger)],"warnchannel");	
	else
		msg = Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timer.trigger)],"message");
		channel = Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timer.trigger)],"channel");
	end
	if Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timer.trigger)],"mode") == TIMERS_LOC_INC then
		msg = string.gsub(msg,"!time",Timers_TimeToText(Timers_GetLocalTime()-timer.time));
	else			
		msg = string.gsub(msg,"!time",Timers_TimeToText(timer.time-Timers_GetLocalTime()));
	end
	msg = string.gsub(msg,"!name",timer.name);
	msg = string.gsub(msg,"!trigger",timer.trigger);
	msg = string.gsub(msg,"!count",Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timer.trigger)],"count"));
	msg = string.gsub(msg,"!group",Timers_GetFieldValue(triggerdata[Timers_TriggerNameToNumber(timer.trigger)],"group"));
	if timer.msg then
		msg = string.gsub(msg,"!msgsub",TimersString_Replace_Msgsub(timer));
		msg = string.gsub(msg,"!msg",timer.msg);
	else
		msg = string.gsub(msg,"!msgsub",TIMERS_LOC_INVOKED_MANUAL);
		msg = string.gsub(msg,"!msg",TIMERS_LOC_INVOKED_MANUAL);
	end				
	Timers_MsgSendTo(msg,channel);
end

function Timers_WarnOnly(trigger,Invokemsg,time)
	local msg = Timers_GetFieldValue(trigger,"message");
	local channel = Timers_GetFieldValue(trigger,"channel");
	msg = string.gsub(msg,"!trigger",trigger.name);
	msg = string.gsub(msg,"!count",Timers_GetFieldValue(trigger,"count"));
	msg = string.gsub(msg,"!group",Timers_GetFieldValue(trigger,"group"));
	msg = string.gsub(msg,"!msgsub",TimersString_Replace_Msgsub_4Warn(trigger,Invokemsg));
	msg = string.gsub(msg,"!msg",Invokemsg);
	if time then
		if Timers_GetFieldValue(trigger,"mode") == TIMERS_LOC_INC then
			msg = string.gsub(msg,"!time",Timers_TimeToText(Timers_GetLocalTime()-time));
		else			
			msg = string.gsub(msg,"!time",Timers_TimeToText(time-Timers_GetLocalTime()));
		end
	end		
	Timers_MsgSendTo(msg,channel);
end

function Timers_CreateIconArray()
	local i = 1;
	while GetSpellName(i,BOOKTYPE_SPELL) do
		if GetSpellTexture(i,BOOKTYPE_SPELL) then
			IconArray[GetSpellTexture(i,BOOKTYPE_SPELL)] = GetSpellName(i,BOOKTYPE_SPELL);
		end
		i = i + 1;
	end
end 
	
-- PopupBox

StaticPopupDialogs["TIMERS_MESSAGE_POPUP"] = {
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1,
	maxLetters = 20,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		Timers_OnMessageBoxAccept("!trigger"..editBox:GetText(),StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].arg1,StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].arg2);
	end,
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetFocus();
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
	end,
	EditBoxOnEnterPressed = function()
		local editBox = getglobal(this:GetParent():GetName().."EditBox");
		Timers_OnMessageBoxAccept("!trigger"..editBox:GetText(),StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].arg1,StaticPopupDialogs["TIMERS_MESSAGE_POPUP"].arg2);
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

StaticPopupDialogs["TIMERS_ACCEPT_POPUP"] = {
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		Timers_OnAcceptBoxButton(true);
	end,
	OnCancel = function()
		Timers_OnAcceptBoxButton(false);
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};

StaticPopupDialogs["TIMERS_ERROR_POPUP"] = {
	button1 = TEXT(OKAY),
	timeout = 0,
	exclusive = 1,
	whileDead = 1
};
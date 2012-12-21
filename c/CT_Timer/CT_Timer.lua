-- Does not get called if the timer is paused or stopped.
-- The function is called with two parameters:

-- First parameter (integer): The time remaining (if counting down)/time elapsed(if counting up), both in seconds.
-- Second parameter (integer): Whether the timer is counting up or down (1 for up, -1 for down).

CT_Timer_CallFunctions = { };
-- Global variable. Add your function to the list to get it called every time the timer counts 1 second (works both counting up and counting down).
-- You can add the function using "tinsert(CT_Timer_CallFunctions, functionName);"

CT_Timer = { };
function CT_Timer_OnMouseOver()
	CT_TimerFrameDragClickFrame.step = 0.05;
end

function CT_Timer_OnMouseOut()
	CT_TimerFrameDragClickFrame.step = -0.05;
end

function CT_Timer_Toggle(btn)
	if ( not btn ) then btn = this:GetParent(); end
	if ( CT_Timer.status and CT_Timer.status == 1 ) then
		CT_Timer.status = 0;
		getglobal(btn:GetName() .. "Time"):SetTextColor(1, 0.5, 0);
		CT_Timer.color = { 1, 0.5, 0 };
	else
		if ( not CT_Timer.status ) then
			if ( CT_Timer.time > 0 ) then
				CT_Timer.countfrom = CT_Timer_GetTimeString(CT_Timer.time);
				CT_Timer.step = -1;
			else
				CT_Timer.step = 1;
			end
		end
		getglobal(btn:GetName() .. "Time"):SetTextColor(0, 1, 0);
		CT_Timer.color = { 0, 1, 0 };
		CT_Timer.status = 1;
	end
end

function CT_Timer_UpdateTime(elapsed)
	if ( CT_Timer.hideBG ) then
		CT_Timer.alphaUpdate = ( CT_Timer.alphaUpdate or 0 ) + elapsed;
		if ( CT_Timer.alphaUpdate > 0.05 ) then
			if ( ( not CT_Timer.alphaWait or CT_Timer.alphaWait < 1 ) and ( CT_TimerFrameDragClickFrame.step or 0 ) > 0 ) then
				CT_Timer.alphaWait = ( CT_Timer.alphaWait or 0 ) + elapsed;
				CT_TimerFrameHeaderTexture:SetAlpha(0);
				CT_TimerFrameScrollDownHour:SetAlpha(0);
				CT_TimerFrameScrollDownMin:SetAlpha(0);
				CT_TimerFrameScrollUpHour:SetAlpha(0);
				CT_TimerFrameScrollUpMin:SetAlpha(0);
			else
				CT_Timer.alpha = ( CT_Timer.alpha or 0 ) + ( CT_TimerFrameDragClickFrame.step or 0 );
				if ( CT_Timer.alpha < 0 ) then
					CT_Timer.alpha = 0;
					CT_Timer.alphaWait = nil;
				elseif ( CT_Timer.alpha > 1 ) then
					CT_Timer.alpha = 1;
				end
				CT_TimerFrameHeaderTexture:SetAlpha(CT_Timer.alpha);
				CT_TimerFrameScrollDownHour:SetAlpha(CT_Timer.alpha);
				CT_TimerFrameScrollDownMin:SetAlpha(CT_Timer.alpha);
				CT_TimerFrameScrollUpHour:SetAlpha(CT_Timer.alpha);
				CT_TimerFrameScrollUpMin:SetAlpha(CT_Timer.alpha);
			end
		end
	else
		CT_Timer.alpha = nil;
		CT_Timer.alphaWait = nil;
		CT_Timer.alphaUpdate = nil;
		CT_TimerFrameHeaderTexture:SetAlpha(1);
		CT_TimerFrameScrollDownHour:SetAlpha(1);
		CT_TimerFrameScrollDownMin:SetAlpha(1);
		CT_TimerFrameScrollUpHour:SetAlpha(1);
		CT_TimerFrameScrollUpMin:SetAlpha(1);
	end
	if ( not CT_Timer.status or CT_Timer.status == 0 ) then
		if ( CT_Timer.color ) then
			CT_TimerFrameTime:SetTextColor(CT_Timer.color[1], CT_Timer.color[2], CT_Timer.color[3]);
		end
		return;
	end
	CT_TimerFrame.update = ( CT_TimerFrame.update or 0 ) + elapsed;
	if ( CT_TimerFrame.update >= 1 ) then
		if ( CT_Timer.color ) then
			CT_TimerFrameTime:SetTextColor(CT_Timer.color[1], CT_Timer.color[2], CT_Timer.color[3]);
		end
		CT_Timer.time = CT_Timer.time + CT_Timer.step;

		-- Process call list
		for k, v in CT_Timer_CallFunctions do
			if ( type(v) == "function" ) then
				v(CT_Timer.time, CT_Timer.step);
			end
		end

		if ( CT_Timer.time == 0 ) then
			DEFAULT_CHAT_FRAME:AddMessage(format(CT_TIMER_FINISHCOUNT, CT_Timer.countfrom), 1, 0.5, 0);
			PlaySound("TellMessage");
			CT_Timer_Reset();
		else
			CT_Timer_SetTime(CT_Timer.time, CT_TimerFrame);
		end
		CT_TimerFrame.update = CT_TimerFrame.update - 1;
	end
end

function CT_Timer_Start(seconds)
	CT_Timer.status = 1;
	if ( seconds ) then
		CT_Timer.step = -1;
		CT_Timer.countfrom = CT_Timer_GetTimeString(seconds);
	else
		CT_Timer.step = 1;
	end
	if ( seconds ) then
		CT_Timer.time = seconds;
	else
		CT_Timer.time = 0;
	end
	CT_TimerFrameTime:SetTextColor(0, 1, 0);
	CT_Timer.color = { 0, 1, 0 };
end

function CT_Timer_Pause(newStatus)
	if ( not newStatus and ( not CT_Timer.status or CT_Timer.status == 0 ) ) then
		newStatus = 1;
	elseif ( newStatus and newStatus ~= 0 and newStatus ~= 1 ) then
		newStatus = nil;
	end

	if ( newStatus ) then
		if ( not CT_Timer.status ) then
			if ( CT_Timer.time > 0 ) then
				CT_Timer.countfrom = CT_Timer_GetTimeString(CT_Timer.time);
				CT_Timer.step = -1;
			else
				CT_Timer.step = 1;
			end
		end
		CT_Timer.status = 1;
		CT_TimerFrameTime:SetTextColor(0, 1, 0);
		CT_Timer.color = { 0, 1, 0 };
	else
		CT_Timer.status = 0;
		CT_TimerFrameTime:SetTextColor(1, 0.5, 0);
		CT_Timer.color = { 1, 0.5, 0 };
	end
end

function CT_Timer_SetTime(num, field)
	if ( not num ) then return; end
	local hours, mins, secs, temp;

	if ( num >= 3600 ) then
		hours = floor(num / 3600);
		temp = num - (hours*3600);
		mins = floor(temp / 60);
		secs = temp - (mins*60);
	elseif ( num >= 60 ) then
		hours = 0;
		mins = floor(num / 60);
		secs = num - (mins*60);
	else
		hours = 0;
		mins = 0;
		secs = num;
	end
	if ( not CT_Timer.showsecs ) then
		getglobal(field:GetName() .. "Time"):SetText(CT_Timer_AddZeros(hours) .. ":" .. CT_Timer_AddZeros(mins));
	else
		getglobal(field:GetName() .. "Time"):SetText(CT_Timer_AddZeros(hours) .. ":" .. CT_Timer_AddZeros(mins) .. ":" .. CT_Timer_AddZeros(secs));
	end
	if ( CT_Timer.time < 60 ) then
		CT_TimerFrameScrollDownMin:Disable();
		CT_TimerFrameScrollDownHour:Disable();
	elseif ( CT_Timer.time < 3600 ) then
		CT_TimerFrameScrollDownHour:Disable();
		CT_TimerFrameScrollDownMin:Enable();
	else
		CT_TimerFrameScrollDownMin:Enable();
		CT_TimerFrameScrollDownHour:Enable();
	end
end

function CT_Timer_GetTimeString(num)

	local hours, mins, secs;

	if ( num >= 3600 ) then
		hours = floor(num / 3600);
		mins = floor(mod(num, 3600) / 60);
	else
		hours = 0;
		mins = floor(num / 60);
	end

	if ( hours == 0 ) then
		if ( mins == 1 ) then
			return "1 " .. CT_TIMER_MIN;
		else
			return mins .. " " .. CT_TIMER_MINS;
		end
	else
		local str;
		if ( hours == 1 ) then
			str = "1 " .. CT_TIMER_HOUR;
		else
			str = hours .. " " .. CT_TIMER_HOURS;
		end
		if ( mins == 0 ) then
			return str;
		elseif ( mins == 1 ) then
			return str .. " and 1 " .. CT_TIMER_MIN;
		else
			return str .. " and " .. mins .. CT_TIMER_MINS;
		end
	end
end

function CT_Timer_AddZeros(num)
	if ( strlen(num) == 1 ) then
		return "0" .. num;
	elseif ( strlen(num) == 2 ) then
		return num;
	else
		return "--";
	end
end

function CT_Timer_ModTime(num)
	CT_Timer.time = CT_Timer.time + num;
	if ( CT_Timer.time < 0 ) then
		CT_Timer.time = 0;
	end
	CT_Timer_SetTime(CT_Timer.time, this:GetParent());
end

function CT_Timer_SetTimerTime(num)
	if ( num < 0 ) then
		num = 0;
	end
	CT_Timer.time = num;
	CT_Timer_SetTime(CT_Timer.time, CT_TimerFrame);
end

function CT_Timer_Reset()
	CT_TimerFrameTime:SetTextColor(1, 0, 0);
	CT_Timer.color = { 1, 0, 0 };
	CT_Timer.status = nil;
	CT_Timer.time = 0;
	CT_Timer.countfrom = nil;
	CT_Timer_SetTime(CT_Timer.time, CT_TimerFrame);
end

if ( CT_RegisterMod ) then
	local function modfunc(modId)
		if ( CT_TimerOptionsFrame:IsVisible() ) then
			HideUIPanel(CT_TimerOptionsFrame);
		else
			ShowUIPanel(CT_TimerOptionsFrame);
		end
	end

	CT_RegisterMod(	CT_TIMER_MODNAME,
					CT_TIMER_SUBNAME,
					5,
					"Interface\\Icons\\INV_Misc_Key_02",
					CT_TIMER_TOOLTIP,
					"off",
					nil,
					modfunc
	);
end

SlashCmdList["TIMER"] = function(msg)
	if ( msg == "" ) then
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[1], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[2], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[3], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[4], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[5], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[6], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[7], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[8], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[9], 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_HELP[10], 1, 1, 0);
	elseif ( msg == "show" ) then
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_SHOW_ON, 1, 1, 0);
		CT_TimerFrame:Show();
		CT_Timer.show = 1;
	elseif ( msg == "hide" ) then
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_SHOW_OFF, 1, 1, 0);
		CT_TimerFrame:Hide();
		CT_Timer.show = nil;
		CT_Timer_ShowTimer = 0;
	elseif ( msg == "secs on" ) then
		CT_Timer.showsecs = 1;
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_SHOWSECS_ON, 1, 1, 0);
		CT_Timer_SetTime(CT_Timer.time, CT_TimerFrame);
	elseif ( msg == "secs off" ) then
		CT_Timer.showsecs = nil;
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_TIMER_SHOWSECS_OFF, 1, 1, 0);
		CT_Timer_SetTime(CT_Timer.time, CT_TimerFrame);
	elseif ( msg == "start" ) then
		CT_Timer_Start();
	elseif ( msg == "stop" ) then
		CT_Timer_Pause();
	elseif ( msg == "reset" ) then
		CT_Timer_Reset();
	elseif ( msg == "bg on" ) then
		CT_Timer.hideBG = nil;
		CT_Timer.alphaUpdate = 5; -- Force redraw
	elseif ( msg == "bg off" ) then
		CT_Timer.hideBG = 1;
		CT_Timer.alphaUpdate = 5; -- Force redraw
	elseif ( msg == "options" ) then
		ShowUIPanel(CT_TimerOptionsFrame);
	elseif ( string.find(msg, "^%d+$") ) then
		local _, _, mins = string.find(msg, "^(%d+)$");
		CT_Timer_Start(tonumber(mins)*60);
	elseif ( string.find(msg, "^%d+:%d+$") ) then
		local _, _, mins, sec = string.find(msg, "^(%d+):(%d+)$");
		CT_Timer_Start(tonumber(mins)*60+tonumber(sec));
	else
		SlashCmdList["TIMER"]("");
	end
end

SLASH_TIMER1 = "/timer";
SLASH_TIMER2 = "/tr";

function CT_Timer_OnEvent(event)
	if ( event == "VARIABLES_LOADED" and not CT_RegisterMod ) then
		if ( CT_Timer.color ) then
			CT_TimerFrameTime:SetTextColor(CT_Timer.color[1], CT_Timer.color[2], CT_Timer.color[3]);
		end
		CT_Timer_SetTime(CT_Timer.time, CT_TimerFrame);
	end
end

tinsert(UISpecialFrames, "CT_TimerOptionsFrame");

function CT_TimerOptions_Initialize()
	CT_TimerOptions_OnClick(1, CT_Timer.show);
	CT_TimerOptions_OnClick(2, CT_Timer.showsecs);
	CT_TimerOptions_OnClick(3, CT_Timer.hideBG);
end

function CT_TimerOptions_OnClick(id, checked)
	if ( id == 1 ) then
		CT_Timer.show = checked;
		getglobal("CT_TimerOptionsFrameShowTimerCB"):SetChecked(checked);
		if ( checked ) then
			CT_TimerFrame:Show();
		else
			CT_TimerFrame:Hide();
		end
	elseif ( id == 2 ) then
		CT_Timer.showsecs = checked;
		getglobal("CT_TimerOptionsFrameShowSecondsCB"):SetChecked(checked);
		CT_Timer_SetTime(CT_Timer.time, CT_TimerFrame);
	elseif ( id == 3 ) then
		CT_Timer.hideBG = checked;
		getglobal("CT_TimerOptionsFrameHideBackgroundCB"):SetChecked(checked);
		CT_Timer.alphaUpdate = 5; -- Force redraw
	end
end
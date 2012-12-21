--[[
SpellAlert (modified again)
Author:______Sent
Thanks:______Awen_(Original_Author)
_____________Mithryn_(versions_up_to_1.65)
]]

-- ----------------- --
-- Slashcmd function --
-- ----------------- --

function SA_GetCmd(msg)
	if (msg) then
		local a,b,c=strfind(msg, "(%S+)");
		if (a) then
			return c, SA_GetCmd(strsub(msg, b+2));
		else
			return "", "";
		end
	end
end

function SA_Handler(msg)
	local arg1, arg2, arg3 = SA_GetCmd(msg);

-- Alert Type
	if ((arg1 == "0") or (arg1 == "1") or (arg1 == "2") or (arg1 == "3") or (arg1 == "4") or
		(arg1 == "5") or (arg1 == "6") or (arg1 == "7") or (arg1 == "8") or (arg1 == "9")) then
		if (arg2 == "to") then
			if (SAVars[tonumber(arg1)].to) then
				SAVars[tonumber(arg1)].to = false;
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000SpellAlert|r "..arg1.." TargetOnly now |c00FF0000[OFF]");
			else
				SAVars[tonumber(arg1)].to = true;
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000SpellAlert|r "..arg1.." TargetOnly now |c000000FF[ON]");
			end
		elseif (arg2 == "short") then
			if (SAVars[tonumber(arg1)].short) then
				SAVars[tonumber(arg1)].short = false;
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000SpellAlert|r "..arg1.." Short Alert now |c00FF0000[OFF]");
			else
				SAVars[tonumber(arg1)].short = true;
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000SpellAlert|r "..arg1.." Short Alert now |c000000FF[ON]");
			end
		elseif (arg2 == "goto") then
			arg3 = tonumber(arg3);
			if (type(arg3) == "number") then
				SAVars[tonumber(arg1)].alert = arg3;
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000SpellAlert|r "..arg1.." bound to alert"..arg3);
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000NOT A NUMBER!");
			end
		elseif (arg2 == "on") then
			SAVars[tonumber(arg1)].on = true;
			DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000SpellAlert|r "..arg1.." now |c000000FF[ON]");
		elseif (arg2 == "off") then
			SAVars[tonumber(arg1)].on = false;
			DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000SpellAlert|r "..arg1.." now |c00FF0000[OFF]");
		end

-- AlertFrames
	elseif ((arg1 == "alert1") or (arg1 == "alert2") or (arg1 == "alert3")) then
		local anum = gsub(arg1, "alert", "");
		local saDrag = getglobal("SA_Drag"..anum);
		local smf = getglobal("SA_SMF"..anum);

		if (arg2 == "lock") then
			if (saDrag:IsVisible()) then
				SAVars[arg1].top = saDrag:GetTop();
				SAVars[arg1].left = saDrag:GetLeft();
				saDrag:Hide();
			else
				saDrag:Show();
			end

		elseif (arg2 == "ht") then
			arg3 = tonumber(arg3);
			if (type(arg3) == "number") then
				if ((arg3 < 0) or (arg3 > 5)) then
					DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000 HoldTime must be 0<=>5");
				else
					SAVars[arg1].holdTime = arg3;
					SA_SMF_UpdateLook(anum);
					DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Alert"..anum.." HoldTime set to "..arg3);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000NOT A NUMBER!");
			end

		elseif (arg2 == "ft") then
			arg3 = tonumber(arg3);
			if (type(arg3) == "number") then
				if ((arg3 < 0) or (arg3 > 5)) then
					DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000 FadeTime must be 0<=>5");
				else
					SAVars[arg1].fadeTime = arg3;
					SA_SMF_UpdateLook(anum);
					DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Alert"..anum.." FadeTime set to "..arg3);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000NOT A NUMBER!");
			end

		elseif (arg2 == "alpha") then
			arg3 = tonumber(arg3);
			if (type(arg3) == "number") then
				if ((arg3 < 0) or (arg3 > 1)) then
					DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000 Alpha must be 0<=>1");
				else
					SAVars[arg1].alpha = arg3;
					SA_SMF_UpdateLook(anum);
					DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Alert"..anum.." alpha set to "..arg3);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000NOT A NUMBER!");
			end

		elseif (arg2 == "lines") then
			arg3 = tonumber(arg3);
			if (type(arg3) == "number") then
				if ((arg3 < 1) or (arg3 > 20)) then
					DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000 Lines number must be 1<=>20");
				else
					SAVars[arg1].lines = arg3;
					SA_SMF_UpdateLook(anum);
					DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Alert"..anum.." Lines number set to "..arg3);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000NOT A NUMBER!");
			end

		elseif (arg2 == "size") then
			arg3 = tonumber(arg3);
			if (type(arg3) == "number") then
				if ((arg3 < 1) or (arg3 > 50)) then
					DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000 Text Size must be 1<=>50");
				else
					SAVars[arg1].size = arg3;
					SA_SMF_UpdateLook(anum);
					DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Alert"..anum.." Text Size set to "..arg3);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000NOT A NUMBER!");
			end
		end

-- General
	elseif (arg1 == "on") then
		SAVars.on = true;
		DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r now |c000000FF[ON]");

	elseif (arg1 == "off") then
		SAVars.on = false;
		DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r now |c00FF0000[OFF]");

	elseif (arg1 == "offonrest") then
		if (SAVars.offonrest) then
			SAVars.offonrest = false;
			DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Auto turn-off while resting now |c00FF0000[OFF]");
		else
			SAVars.offonrest = true;
			DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Auto turn-off while resting now |c000000FF[ON]");
		end

	elseif (arg1 == "reset") then
		SA_Reset();
		for i = 1, 3 do
			getglobal("SA_Drag"..i):ClearAllPoints();
			getglobal("SA_Drag"..i):SetPoint("CENTER", UIParent, "CENTER", SAVars["alert"..i].left, SAVars["alert"..i].top);
		end
		DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r Resetting Options to Default");

	elseif (arg1 == "") then
		if (not IsAddOnLoaded("SpellAlertOptions")) then
			UIParentLoadAddOn("SpellAlertOptions");
		end
		if (IsAddOnLoaded("SpellAlertOptions")) then
			if (SAO_MainFrame:IsVisible()) then
				SAO_MainFrame:Hide()
			else
				SAO_MainFrame:Show()
			end
		end

	elseif (arg1 == "help") then
		SA_DisplayHelp();

	else
		SA_DisplayHelp();
	end
end

function SA_DisplayHelp()
	DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r /commands list");
	DEFAULT_CHAT_FRAME:AddMessage("*Alert types numbers, to = TargetOnly");
	DEFAULT_CHAT_FRAME:AddMessage("0 {on|off|to|short} -- dmg");
	DEFAULT_CHAT_FRAME:AddMessage("1 {on|off|to|short} -- heal");
	DEFAULT_CHAT_FRAME:AddMessage("2 {on|off|to|short} -- buff-gain");
	DEFAULT_CHAT_FRAME:AddMessage("3 {on|off|to|short} -- buff-gone");
	DEFAULT_CHAT_FRAME:AddMessage("4 {on|off|to|short} -- totem");
	DEFAULT_CHAT_FRAME:AddMessage("5 {on|off|to|short} -- emote");
	DEFAULT_CHAT_FRAME:AddMessage("6 {on|off|to|short} -- periodic");
	DEFAULT_CHAT_FRAME:AddMessage("7 {on|off|to|short} -- istant");
	DEFAULT_CHAT_FRAME:AddMessage("8 {on|off|to|short} -- DONT WORK!");
	DEFAULT_CHAT_FRAME:AddMessage("9 {on|off|to|short} -- DONT WORK!");
	DEFAULT_CHAT_FRAME:AddMessage("ex. /spellalert 6 off");
	DEFAULT_CHAT_FRAME:AddMessage("*Alerts opts, ht = HoldTime, ft = FadeTime");
	DEFAULT_CHAT_FRAME:AddMessage("lock      -- Toggle dragging");
	DEFAULT_CHAT_FRAME:AddMessage("ht num    -- min:0 max:5");
	DEFAULT_CHAT_FRAME:AddMessage("ft num    -- min:0 max:5");
	DEFAULT_CHAT_FRAME:AddMessage("size num  -- min:1 max:50");
	DEFAULT_CHAT_FRAME:AddMessage("lines num -- min:1 max:20");
	DEFAULT_CHAT_FRAME:AddMessage("alpha num -- min:0 max:1");
	DEFAULT_CHAT_FRAME:AddMessage("ex. /spellalert alert1 ht 1");
	DEFAULT_CHAT_FRAME:AddMessage("*General Options");
	DEFAULT_CHAT_FRAME:AddMessage("on -- Turn SpellAlert on");
	DEFAULT_CHAT_FRAME:AddMessage("off -- Turn SpellAlert off");
	DEFAULT_CHAT_FRAME:AddMessage("offonrest -- Auto turn-off while resting");
	DEFAULT_CHAT_FRAME:AddMessage("reset -- Reset Settings to Default");
end
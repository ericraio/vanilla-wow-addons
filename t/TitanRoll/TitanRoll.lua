----
--	TitanPanel[Roll]
----
--[[

	author: QuippeR

	many thanks for code from:
			LootHog by Chompers
			ToggleMe by Taii

description:

This Titan Panel plugin catches dice rolls from the chat system. It displays the last roll 
(performers name and roll value) in Titan Panel, and hovering the plugin brings up a list 
of the latest catched rolls.
Dice rolls with the range of 1-100 are displayed in green, others in red with the minimum 
and maximum of the roll after the actual value.
Clicking on the text displayed performs a roll.

]]--


TITAN_ROLL_ID = "Roll"

TITANROLL_TIMEOUTS = { 10, 20, 30, 60, 120, 180, -1};

function TitanPanelRollButton_OnLoad()
	this.registry = {
		id = TITAN_ROLL_ID,
		menuText = TITANROLL_MENUTEXT,
		buttonTextFunction = "TitanPanelRollButton_GetButtonText",
		tooltipTitle = TITANROLL_TOOLTIP,
		tooltipTextFunction = "TitanPanelRollButton_GetTooltipText",
		icon = "Interface\\PvPRankBadges\\PvPRank10",
		iconWidth = 16,
		category = "Information",
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowWinner = 1,
			ReplaceBadRolls = 1,
			SortList = 0,
			HighlightParty = 0,
			PerformedRoll = "1-100",
			ListLength = 10,
			Timeout = 20,
			OnlyGoodRollsWin = 1,
			AcceptGroupOnly = 0,
			IgnoreMultiRoll = 0,
			AnnouncePattern = TITANROLL_ANNPATT,
			EraseTimedOutRolls = 0,
			ShowTimeOut = 1
		}
	};

	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("CHAT_MSG_SAY");
	this:RegisterEvent("CHAT_MSG_PARTY");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_GUILD");

	TitanRolls = {};
	TimedOut = 0;

end

function TitanPanelRollButton_OnClick(button)
	local i;
	if (( button == "LeftButton" ) and IsShiftKeyDown()) then
		TitanPanelRollButton_TimeOutAll();
	elseif (( button == "LeftButton" ) and IsControlKeyDown()) then
		if (TitanRollsCount) then
			for i = 1, TitanRollsCount do
				TitanRolls[i] = TitanRolls[i+1];
			end
			TitanRollsCount = TitanRollsCount - 1;
			if (TimedOut ~= 0) then
				TimedOut = TimedOut - 1;
			end
			if (TitanRollsCount == 0) then
				TitanRollsCount = nil;
			end
		TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
		end
	elseif (( button == "LeftButton" ) and IsAltKeyDown()) then
		TitanRoll_AnnounceWinner();

-- (Maybe in a future version) --
--	elseif (( button ==  "LeftButton" ) and ChatFrameEditBox:IsShown()) then
--		local Ilink = ChatFrameEditBox:GetText();
--		ChatFrameEditBox:SetText("");
--		ChatFrameEditBox:Hide();
--		TitanRoll_AnnounceItem(Ilink);

	elseif ( button ==  "LeftButton" ) then
		TitanRoll_EditBox:SetText("/rnd "..TitanGetVar(TITAN_ROLL_ID, "PerformedRoll"));
		ChatEdit_SendText(TitanRoll_EditBox);
	end
end

-- Special thanks to LootHog author Chompers !

function TitanPanelRollButton_OnEvent()
	local msg = arg1;
	local pattern = TITANROLL_SEARCHPATTERN;
	local player, roll, min_roll, max_roll, report;
	_, _, player, roll, min_roll, max_roll = string.find(msg, pattern);
	if (player) and ((TitanGetVar(TITAN_ROLL_ID, "AcceptGroupOnly") and (UnitInGroupByName(player)) or (not TitanGetVar(TITAN_ROLL_ID, "AcceptGroupOnly")))) then
		TitanPanelRollButton_ProcessRoll(player, roll, min_roll, max_roll);
	end
	if (strlower(msg)=="!roll") then
		TitanRoll_EditBox:SetText("/rnd 100");
		ChatEdit_SendText(TitanRoll_EditBox);
	end
end

function TitanPanelRollButton_ProcessRoll(player, roll, min_roll, max_roll)
	local rollOK = true;
	local deleted = 0;
	local rolltime = GetTime();
	local firstRoll = true;
	min_roll = tonumber(min_roll);
	max_roll = tonumber(max_roll);
	roll = tonumber(roll);
	_, _, rolltime, _ = string.find(rolltime, "(%d+).(%d+)");
	rolltime = tonumber(rolltime);
	if (min_roll ~=1) or (max_roll~=100) then
		rollOK = false;
	end
	if ((TitanRollsCount) and (TitanGetVar(TITAN_ROLL_ID, "IgnoreMultiRoll")) and (TimedOut>0)) then
		for i = 1, TimedOut do
			if ((TitanRolls[i].name == player) and not (TitanGetVar(TITAN_ROLL_ID,"ReplaceBadRolls") and (not TitanRolls[i].onetohundred))) then
				firstRoll = false;
			end
		end
	end
       if (firstRoll) then
	if (TitanRollsCount) then
		if (TitanGetVar(TITAN_ROLL_ID, "ReplaceBadRolls")) then
			for i = 1, TitanRollsCount do
				if ((TitanRolls[i-deleted].name == player) and (not (TitanRolls[i-deleted].onetohundred)) and rollOK) then
					for j = i-deleted, TitanRollsCount do
						TitanRolls[j] = TitanRolls[j+1];
					end
					TitanRollsCount = TitanRollsCount - 1;
					if (TimedOut >= (i-deleted)) then
						TimedOut = TimedOut - 1;
					end
					deleted = deleted + 1;
				end
			end
		end
		for i = TitanRollsCount, 1, -1 do
			TitanRolls[i+1] = TitanRolls[i];
		end
		if (TitanRollsCount < TitanGetVar(TITAN_ROLL_ID, "ListLength")) then
			TitanRollsCount = TitanRollsCount + 1;
		end
		if (TimedOut < TitanGetVar(TITAN_ROLL_ID, "ListLength")) then
			TimedOut = TimedOut + 1;
		end
	else
		TitanRollsCount = 1;
		TimedOut = 1;
	end
	if (rollOK) then
		TitanRolls[1] = {name = player,
				 rolled = roll,
				 onetohundred = rollOK,
				 since = rolltime};
	else
		TitanRolls[1] = {name = player,
				 rolled = roll,
				 onetohundred = rollOK,
				 since = rolltime,
				 base = min_roll,
				 top = max_roll};
	end
	TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
	TitanPanelButton_SetTooltip(TITAN_ROLL_ID);
       end
end

function TitanPanelRollButton_OnUpdate()
	local secNow;
	if (TimedOut > 0) and (TitanGetVar(TITAN_ROLL_ID, "Timeout") > 0) then
		secNow = GetTime();
		_, _, secNow, _ = string.find(secNow, "(%d+).(%d+)");
		if ((secNow - TitanRolls[TimedOut].since) > TitanGetVar(TITAN_ROLL_ID, "Timeout")) then
			TimedOut = TimedOut - 1;
			if (TitanGetVar(TITAN_ROLL_ID, "EraseTimedOutRolls") == 1) then
				TitanRollsCount = TimedOut;
			end
			TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
		end
	elseif (TitanGetVar(TITAN_ROLL_ID, "Timeout") == -1) then
		TimedOut = TitanRollsCount or 0;
		TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
	else
		-- I don't want it to be negative no way
		TimedOut = 0;
	end
	TitanPanelButton_UpdateTooltip();
end


function TitanPanelRollButton_GetButtonText()
	local buttonText = "";
	local max = -1;
	local maxloc = 0;
	local i;
	local hasBadRoll = false;
	local parenth = "";
	local winners = "";

	if (TitanRollsCount) then
		if not (TitanGetVar(TITAN_ROLL_ID, "ShowWinner")) then
			buttonText = buttonText..TitanRolls[1].name.." ";
			if (TitanRolls[1].onetohundred) then
				buttonText = buttonText..TitanUtils_GetGreenText(TitanRolls[1].rolled);
			else
				buttonText = buttonText..TitanUtils_GetRedText(TitanRolls[1].rolled);
			end
			parenth = " ("..TimedOut..")";
		else
			for i = 1, TitanRollsCount do
				if (TitanRolls[i].rolled >= max) and (i <= TimedOut)  and ((TitanGetVar(TITAN_ROLL_ID, "OnlyGoodRollsWin") and (TitanRolls[i].onetohundred)) or (not TitanGetVar(TITAN_ROLL_ID, "OnlyGoodRollsWin"))) then
					if (max ~= tonumber(TitanRolls[i].rolled)) then
						winners = TitanRolls[i].name;
					else
						winners = winners..", "..TitanRolls[i].name;
					end
					max = tonumber(TitanRolls[i].rolled);
					maxloc = i;
				end
				if not (TitanRolls[i].onetohundred) and (i <= TimedOut) then
					hasBadRoll = true;
				end
			end
			if (maxloc > 0) then
				if hasBadRoll then
					buttonText = buttonText..TitanUtils_GetRedText(winners.." ");
				else
					buttonText = buttonText..winners.." ";
				end
				if (TitanRolls[maxloc].onetohundred) then
					buttonText = buttonText..TitanUtils_GetGreenText(TitanRolls[maxloc].rolled);
				else
					buttonText = buttonText..TitanUtils_GetRedText(TitanRolls[maxloc].rolled)
				end
				parenth = " ("..TimedOut..")";
			else
				buttonText = TitanUtils_GetColoredText(TITAN_NA, HIGHLIGHT_FONT_COLOR);
			end
		end
	else
		buttonText = buttonText..TitanUtils_GetColoredText(TITAN_NA, HIGHLIGHT_FONT_COLOR);
	end
	if not (TitanGetVar(TITAN_ROLL_ID, "ShowWinner")) then
		return TITANROLL_LABELTEXT, buttonText..parenth;
	else
		return TITANROLL_LABELWINNER, buttonText..parenth;
	end
end

function TitanPanelRollButton_GetTooltipText()
	local tooltipText = "";
	local i, j, k;
	local sortedList = {};
	if (TitanRollsCount) then
		if (TitanGetVar(TITAN_ROLL_ID, "SortList")) then
			for i = 1, TitanRollsCount do
				if (sortedList) then
					if (i <= TimedOut) then
						j = 1;
						while (j<i) and (sortedList[j].rolled > TitanRolls[i].rolled) do
							j = j + 1;
						end
						for k = i-1, j, -1 do
							sortedList[k+1] = sortedList[k];
						end
						sortedList[j] = TitanRolls[i];
					else
						sortedList[i] = TitanRolls[i];
					end
				else
					sortedList[i] = TitanRolls[i];
				end
			end
			tooltipText = TitanPanelRollButton_PrintTooltipText(sortedList)
		else
			tooltipText = TitanPanelRollButton_PrintTooltipText(TitanRolls)
		end
	else
		tooltipText = tooltipText..TitanUtils_GetNormalText(TITANROLL_NOROLL).."\n";
	end
	tooltipText = tooltipText..TitanUtils_GetGreenText(TITANROLL_HINT);
	return tooltipText;
end

function UnitInGroupByName(name)
	if (UnitName("player") == name) or (UnitName("party1") == name) or 
			(UnitName("party2") == name) or (UnitName("party3") == name) or (UnitName("party4") == name) then
		return true;
	else
		local raidmember = false;
		for i = 0, 40 do
			if (UnitName("raid"..i)) and (UnitName("raid"..i) == name) then
				raidmember = true;
			end
		end
		return raidmember;
	end
end

function TitanPanelRollButton_PrintTooltipText(array)
	local i;
	local name="";
	local tooltipText = "";
	local tooltipLength = 0;
	local nowIs = GetTime();
	local since = 0;
	local sinceText = "";
	local t = 0;
	_, _, nowIs, _ = string.find(nowIs, "(%d+).(%d+)");
	if TitanRollsCount < TITANROLL_MAXTTLEN then
		tooltipLength = TitanRollsCount;
	else
		tooltipLength = TITANROLL_MAXTTLEN;
	end
	for i = 1, tooltipLength do
		if (TitanGetVar(TITAN_ROLL_ID, "ShowTimeOut")) then
			since = (nowIs-array[i].since);
			t = since-mod(since,3600);
			if t>0 then
			 sinceText = ">"..(t/3600).."h"
			else
				t = since-mod(since,60);
				if t>60 then
					sinceText = ">"..(t/60).."min"
				elseif t>0 then
					sinceText = "1min "..(since-60).."s"
				else
					sinceText = since.."s"
				end
			end
			name = "["..sinceText.."] "..array[i].name;
		else
			name =  array[i].name;
		end
		if (i <= TimedOut) then
			if (UnitInGroupByName(array[i].name) and TitanGetVar(TITAN_ROLL_ID, "HighlightParty")) then
				tooltipText = tooltipText..TitanUtils_GetHighlightText(name).."\t";
			else
				tooltipText = tooltipText..TitanUtils_GetGreenText(name).."\t";
			end
		else
			tooltipText = tooltipText..name.."\t";
		end
		if (i <= TimedOut) then
			if (array[i].onetohundred) then
				if (UnitInGroupByName(array[i].name) and TitanGetVar(TITAN_ROLL_ID, "HighlightParty")) then
					tooltipText = tooltipText..TitanUtils_GetHighlightText(array[i].rolled).."\n";
				else
					tooltipText = tooltipText..TitanUtils_GetGreenText(array[i].rolled).."\n";
				end
			else
				tooltipText = tooltipText..TitanUtils_GetRedText(array[i].rolled.." ("..array[i].base.."-"..array[i].top..")").."\n";
			end
		else
			if (array[i].onetohundred) then
					tooltipText = tooltipText..array[i].rolled.."\n";
			else
					tooltipText = tooltipText..array[i].rolled.." ("..array[i].base.."-"..array[i].top..")\n";		
			end
		end
	end
	if (tooltipLength~=TitanRollsCount) then
		tooltipText = tooltipText..TitanUtils_GetRedText(TITANROLL_TTALERT).."\n";
	end
	return tooltipText;
end

function TitanPanelRollButton_ResetSession()
	TitanRollsCount = nil;
	TitanRolls = {};
	TimedOut = 0;
	TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
end

function TitanPanelRollButton_TimeOutAll()
	local i;
	if (TitanGetVar(TITAN_ROLL_ID,"Timeout")==-1) then
		TitanPanelRollButton_ResetSession();
	else
		for i = 1, TimedOut do
			TitanRolls[i].since = TitanRolls[i].since - TitanGetVar(TITAN_ROLL_ID,"Timeout");
		end
		TitanPanelButton_SetTooltip(TITAN_ROLL_ID);
	end
	TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
end

function TitanRoll_AnnounceWinner()
	local sendToChat = "";
	local hasBadRoll = "";
	local max = -1;
	local maxloc = 0;
	local winners = "";
	local rollerList = "";
	local annpattern = TitanGetVar(TITAN_ROLL_ID, "AnnouncePattern");
	if(GetNumRaidMembers()>0) then
		sendToChat = "/raid ";
	elseif (GetNumPartyMembers()>0) then
		sendToChat = "/p ";
	else
		sendToChat = "/s ";
	end
	if (TimedOut>0) then
		for i = 1, TimedOut do
			if (TitanRolls[i].rolled >= max) and (i <= TimedOut)  and ((TitanGetVar(TITAN_ROLL_ID, "OnlyGoodRollsWin") and (TitanRolls[i].onetohundred)) or (not TitanGetVar(TITAN_ROLL_ID, "OnlyGoodRollsWin"))) then
				if (max ~= tonumber(TitanRolls[i].rolled)) then
					winners = TitanRolls[i].name;
				else
					winners = winners..", "..TitanRolls[i].name;
				end
				max = tonumber(TitanRolls[i].rolled);
				maxloc = i;
			end
			if not (TitanRolls[i].onetohundred) and (i <= TimedOut) then
				if (hasBadRoll~="") then
					hasBadRoll = hasBadRoll..", ";
				end
				hasBadRoll = hasBadRoll..TitanRolls[i].name.." ("..TitanRolls[i].base.."-"..TitanRolls[i].top..")";
			end
			if (i~=1) then
				rollerList = rollerList..", "
			end
			rollerList = rollerList..TitanRolls[i].name.." - "..TitanRolls[i].rolled
		end
	       if (maxloc > 0) then
		annpattern = string.gsub(annpattern, "$a(.+)$b", "");
		annpattern = string.gsub(annpattern, "$w", winners);
		annpattern = string.gsub(annpattern, "$l", rollerList);
		annpattern = string.gsub(annpattern, "$r", TitanRolls[maxloc].rolled);
		annpattern = string.gsub(annpattern, "$n", TimedOut);
		if (hasBadRoll~="") then
			annpattern = string.gsub(annpattern, "$c", "");
			annpattern = string.gsub(annpattern, "$i", hasBadRoll)
		else
			annpattern = string.gsub(annpattern, "$c(.+)", "");
		end
	       end
	end
	if (maxloc==0) then
		annpattern = string.gsub(annpattern, "$a", " ");
		annpattern = string.gsub(annpattern, "$b(.+)", " ");
	end
	sendToChat = sendToChat..annpattern;
	local strLenToPrint = string.len(sendToChat)
	while strLenToPrint > 255 do
		TitanRoll_EditBox:SetText(string.sub(sendToChat,-strLenToPrint, -(strLenToPrint-255)));
		ChatEdit_SendText(TitanRoll_EditBox);
		strLenToPrint = strLenToPrint-255;
	end
	TitanRoll_EditBox:SetText(string.sub(sendToChat,-strLenToPrint));
	ChatEdit_SendText(TitanRoll_EditBox);
end

-- (Maybe in a future version) --
--function TitanRoll_AnnounceItem(itemlink)
--	local sendToChat = "";
--	
--	if(GetNumRaidMembers()>0) then
--		sendToChat = "/raid ";
--	elseif (GetNumPartyMembers()>0) then
--		sendToChat = "/p ";
--	else
--		DEFAULT_CHAT_FRAME:AddMessage("TitanRoll: You're not in a group!")
--	end
--	
--	sendToChat = sendToChat.."Please need roll on "..itemlink.."! You can pass by typing in the letter 'p'!";
--
--	TitanRoll_EditBox:SetText(sendToChat);
--	ChatEdit_SendText(TitanRoll_EditBox);
--end

function TitanPanelRollButton_ChangeAction()
	StaticPopupDialogs["TITANROLL_CHANGEACTION"]={
		text=TEXT(TITANROLL_CURRENTACTION..TitanGetVar(TITAN_ROLL_ID, "PerformedRoll")),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=30,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox")
			TitanSetVar(TITAN_ROLL_ID, "PerformedRoll", editBox:GetText());
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox")
			TitanSetVar(TITAN_ROLL_ID, "PerformedRoll", editBox:GetText());
		end,
		timeout=0,
		exclusive=1
	}
	StaticPopup_Show("TITANROLL_CHANGEACTION")

end

function TitanPanelRollButton_ChangeAnnounce()
	StaticPopupDialogs["TITANROLL_CHANGEANNOUNCE"]={
		text=TEXT(TITANROLL_CHATFORHELP),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=250,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox")
			TitanSetVar(TITAN_ROLL_ID, "AnnouncePattern", editBox:GetText());
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox")
			TitanSetVar(TITAN_ROLL_ID, "AnnouncePattern", editBox:GetText());
		end,
		timeout=0,
		exclusive=1
	}
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP01);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP02..TitanGetVar(TITAN_ROLL_ID, "AnnouncePattern"));
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP03);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP04);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP05);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP06);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP07);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP08);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP09);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP10);
	DEFAULT_CHAT_FRAME:AddMessage(TITANROLL_ANNHELP11);
	StaticPopup_Show("TITANROLL_CHANGEANNOUNCE")
	getglobal(getglobal(StaticPopup_Visible("TITANROLL_CHANGEANNOUNCE")):GetName().."EditBox"):SetText(TitanGetVar(TITAN_ROLL_ID, "AnnouncePattern"))

end

function TitanPanelRollButton_SetListLength()
	local i;
	local length = this.value;
	TitanSetVar(TITAN_ROLL_ID, "ListLength", length);
	if (TitanRollsCount) and (TitanRollsCount > length) then
		for i = length+1, TitanRollsCount do
			TitanRolls[i] = nil;
		end
		TitanRollsCount = length;
	end
	if (TimedOut > length) then
		TimedOut = length;
	end
	TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
end

function TitanPanelRollButton_SetTimeout()
	TitanSetVar(TITAN_ROLL_ID, "Timeout", TITANROLL_TIMEOUTS[this.value]);
	if (TitanRollsCount) then
		TimedOut = TitanRollsCount;
	else
		TimedOut = 0;
	end
	TitanPanelButton_UpdateButton(TITAN_ROLL_ID);
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelRightClickMenu_PrepareRollMenu()
	local i;

	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then

		TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ROLL_ID].menuText);

		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGWINNER, TITAN_ROLL_ID, "ShowWinner");	
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGREPLACE, TITAN_ROLL_ID, "ReplaceBadRolls");
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGIGNOREMUL, TITAN_ROLL_ID, "IgnoreMultiRoll");
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGSORTLIST, TITAN_ROLL_ID, "SortList");
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGGROUPACC, TITAN_ROLL_ID, "AcceptGroupOnly");
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGHIGHLIGHT, TITAN_ROLL_ID, "HighlightParty");
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGGOODWIN, TITAN_ROLL_ID, "OnlyGoodRollsWin");
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGSHOWTIME, TITAN_ROLL_ID, "ShowTimeOut");
		TitanPanelRightClickMenu_AddToggleVar(TITANROLL_TOGERASETO, TITAN_ROLL_ID, "EraseTimedOutRolls");

		info = {};
		info.text = TITANROLL_CHANGELENGTH;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = TITANROLL_SETTIMEOUT;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddCommand(TITANROLL_PERFORMED, TITAN_ROLL_ID, "TitanPanelRollButton_ChangeAction");
		TitanPanelRightClickMenu_AddCommand(TITANROLL_ANNOUNCE, TITAN_ROLL_ID, "TitanPanelRollButton_ChangeAnnounce");
		TitanPanelRightClickMenu_AddCommand(TITANROLL_ERASELIST, TITAN_ROLL_ID, "TitanPanelRollButton_ResetSession");

		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddToggleIcon(TITAN_ROLL_ID);
		TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ROLL_ID);

		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ROLL_ID, TITAN_PANEL_MENU_FUNC_HIDE);

	elseif (UIDROPDOWNMENU_MENU_LEVEL == 2) then

		if (UIDROPDOWNMENU_MENU_VALUE == TITANROLL_CHANGELENGTH) then
			TitanPanelRightClickMenu_AddTitle(TITANROLL_CHANGELENGTH, UIDROPDOWNMENU_MENU_LEVEL);
			for i = 5, 40, 5 do
				info = {};
				info.text = i;
				info.func = TitanPanelRollButton_SetListLength;
				info.checked = (i == TitanGetVar(TITAN_ROLL_ID, "ListLength"))
				info.value = i;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);	
			end 
		elseif (UIDROPDOWNMENU_MENU_VALUE == TITANROLL_SETTIMEOUT) then
			TitanPanelRightClickMenu_AddTitle(TITANROLL_SETTIMEOUT, UIDROPDOWNMENU_MENU_LEVEL);
			for i = 1, 7 do
				info = {}
				info.text = TITANROLL_TIMEOUTS_TEXT[i];
				info.func = TitanPanelRollButton_SetTimeout;
				info.checked = (TITANROLL_TIMEOUTS[i] == TitanGetVar(TITAN_ROLL_ID, "Timeout"))
				info.value = i;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);	
			end
		end
	end
end

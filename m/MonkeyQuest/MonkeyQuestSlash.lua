--[[

	MonkeyQuest:
	Displays your quests for quick viewing.
	
	Website:	http://wow.visualization.ca/
	Author:		Trentin (monkeymods@gmail.com)
	
	
	Contributors:
	Celdor
		- Help with the Quest Log Freeze bug
		
	Diungo
		- Toggle grow direction
		
	Pkp
		- Color Quest Titles the same as the quest level
	
	wowpendium.de
		- German translation
		
	MarsMod
		- Valid player name before the VARIABLES_LOADED event bug
		- Settings resetting bug

--]]


-- define the dialog box for reseting config
StaticPopupDialogs["MONKEYQUEST_RESET"] = {
	text = TEXT(MONKEYQUEST_CONFIRM_RESET),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		MonkeyQuestInit_ResetConfig();
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_RESET_MSG);
		end
	end,
	timeout = 0,
	exclusive = 1
};

-- function to register all the slash commands
function MonkeyQuestSlash_Init()
	-- this command toggles the Quest Monkey display
	SlashCmdList["MONKEYQUEST_DISPLAY"] = MonkeyQuestSlash_Parse;
	SLASH_MONKEYQUEST_DISPLAY1 = "/monkeyquest";
	SLASH_MONKEYQUEST_DISPLAY2 = "/mquest";
end

function MonkeyQuestSlash_Parse(msg)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (msg == nil or msg == "" or string.find(msg, "help") ~= nil) then
		local i, j = string.find(msg, "help");
		
		if (i ~= nil) then
			MonkeyQuestSlash_CmdHelp(string.lower(string.sub(msg, j + 2)));
			return;
		end
				
		MonkeyQuestSlash_CmdHelp();
		return;
	end
	if (string.lower(msg) == "reset") then
		MonkeyQuestSlash_CmdReset();
		return;
	end
	if (string.lower(msg) == "open") then
		MonkeyQuestSlash_CmdOpen(true);
		return;
	end
	if (string.lower(msg) == "close") then
		MonkeyQuestSlash_CmdOpen(false);
		return;
	end
	if (string.lower(msg) == "showhidden") then
		MonkeyQuestSlash_CmdShowHidden(true);
		return;
	end
	if (string.lower(msg) == "hidehidden") then
		MonkeyQuestSlash_CmdShowHidden(false);
		return;
	end
	if (string.lower(msg) == "useoverviews") then
		MonkeyQuestSlash_CmdUseOverviews(true);
		return;
	end
	if (string.lower(msg) == "nooverviews") then
		MonkeyQuestSlash_CmdUseOverviews(false);
		return;
	end
	if (string.lower(msg) == "hideheaders") then
		MonkeyQuestSlash_CmdHideHeaders(true);
		return;
	end
	if (string.lower(msg) == "showheaders") then
		MonkeyQuestSlash_CmdHideHeaders(false);
		return;
	end
	if (string.lower(msg) == "hideborder") then
		MonkeyQuestSlash_CmdHideBorder(true);
		return;
	end
	if (string.lower(msg) == "showborder") then
		MonkeyQuestSlash_CmdHideBorder(false);
		return;
	end
	if (string.lower(msg) == "growup") then
		MonkeyQuestSlash_CmdGrowUp(true);
		return;
	end
	if (string.lower(msg) == "growdown") then
		MonkeyQuestSlash_CmdGrowUp(false);
		return;
	end
	if (string.find(msg, "alpha") ~= nil) then
		local i, j = string.find(msg, "%d+");
		
		if (i ~= nil) then
			MonkeyQuestSlash_CmdAlpha(tonumber(string.sub(msg, i, j), 10));
		end
		return;
	end
	if (string.find(msg, "width") ~= nil) then
		local i, j = string.find(msg, "%d+");
		
		if (i ~= nil) then
			MonkeyQuestSlash_CmdWidth(tonumber(string.sub(msg, i, j), 10));
		end
		return;
	end
	if (string.find(msg, "fontheight") ~= nil) then
		local i, j = string.find(msg, "%d+");
		
		if (i ~= nil) then
			MonkeyQuestSlash_CmdFontHeight(tonumber(string.sub(msg, i, j), 10));
		end
		return;
	end
	if (string.find(msg, "tipanchor") ~= nil) then
		local i, j = string.find(msg, "=");
		
		if (i ~= nil) then
			MonkeyQuestSlash_CmdTipAnchor(string.sub(msg, i + 1));
		end
		return;
	end
	if (string.lower(msg) == "shownumquests") then
		MonkeyQuestSlash_CmdShowNumQuests(true);
		return;
	end
	if (string.lower(msg) == "hidenumquests") then
		MonkeyQuestSlash_CmdShowNumQuests(false);
		return;
	end
	if (string.lower(msg) == "lock") then
		MonkeyQuestSlash_CmdLock(true);
		return;
	end
	if (string.lower(msg) == "unlock") then
		MonkeyQuestSlash_CmdLock(false);
		return;
	end
	if (string.lower(msg) == "colourtitleon" or string.lower(msg) == "colortitleon") then
		MonkeyQuestSlash_CmdColourTitleOn(true);	
		return;
	end
	if (string.lower(msg) == "colourtitleoff" or string.lower(msg) == "colortitleoff") then
		MonkeyQuestSlash_CmdColourTitleOn(false);	
		return;
	end
	if (string.lower(msg) == "hidecompletedquests") then
		MonkeyQuestSlash_CmdHideCompletedQuests(true);
		return;
	end
	if (string.lower(msg) == "showcompletedquests") then
		MonkeyQuestSlash_CmdHideCompletedQuests(false);
		return;
	end
	if (string.lower(msg) == "hidecompletedobjectives") then
		MonkeyQuestSlash_CmdHideCompletedObjectives(true);
		return;
	end
	if (string.lower(msg) == "showcompletedobjectives") then
		MonkeyQuestSlash_CmdHideCompletedObjectives(false);
		return;
	end
	if (string.lower(msg) == "showtooltipobjectives") then
		MonkeyQuestSlash_CmdShowTooltipObjectives(true);
		return;
	end
	if (string.lower(msg) == "hidetooltipobjectives") then
		MonkeyQuestSlash_CmdShowTooltipObjectives(false);
		return;
	end
	if (string.lower(msg) == "allowrightclick") then
		MonkeyQuestSlash_CmdAllowRightClick(true);
		return;
	end
	if (string.lower(msg) == "disallowrightclick") then
		MonkeyQuestSlash_CmdAllowRightClick(false);
		return;
	end
	if (string.lower(msg) == "hidetitlebuttons") then
		MonkeyQuestSlash_CmdHideTitleButtons(true);
		return;
	end
	if (string.lower(msg) == "showtitlebuttons") then
		MonkeyQuestSlash_CmdHideTitleButtons(false);
		return;
	end
	if (string.lower(msg) == "hidetitle") then
		MonkeyQuestSlash_CmdHideTitle(true);
		return;
	end
	if (string.lower(msg) == "showtitle") then
		MonkeyQuestSlash_CmdHideTitle(false);
		return;
	end

	-- didn't match any others, print out the help msg
	MonkeyQuestSlash_CmdHelp();
end

function MonkeyQuestSlash_CmdHelp(strCommand)
	if (not DEFAULT_CHAT_FRAME) then
		return;
	end
	
	if (strCommand == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_MSG);
		return;
	end
	if (strCommand == "reset") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_RESET_MSG);
		return;
	end
	if (strCommand == "open") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_OPEN_MSG);
		return;
	end
	if (strCommand == "close") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_CLOSE_MSG);
		return;
	end
	if (strCommand == "showhidden") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWHIDDEN_MSG);
		return;
	end
	if (strCommand == "hidehidden") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDEHIDDEN_MSG);
		return;
	end
	if (strCommand == "useoverviews") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_USEOVERVIEWS_MSG);
		return;
	end
	if (strCommand == "nooverviews") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_NOOVERVIEWS_MSG);
		return;
	end
	if (strCommand == "tipanchor") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_TIPANCHOR_MSG);
		return;
	end
	if (strCommand == "alpha") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_ALPHA_MSG);
		return;
	end
	if (strCommand == "width") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_WIDTH_MSG);
		return;
	end
	if (strCommand == "fontheight") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_FONTHEIGHT_MSG);
		return;
	end
	if (strCommand == "hideheaders") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDEHEADERS_MSG);
		return;
	end
	if (strCommand == "showheaders") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWHEADERS_MSG);
		return;
	end
	if (strCommand == "hideborder") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDEBORDER_MSG);
		return;
	end
	if (strCommand == "showborder") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWBORDER_MSG);
		return;
	end
	if (strCommand == "growup") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_GROWUP_MSG);
		return;
	end
	if (strCommand == "growdown") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_GROWDOWN_MSG);
		return;
	end
	if (strCommand == "hidenumquests") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDENUMQUESTS_MSG);
		return;
	end
	if (strCommand == "shownumquests") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG);
		return;
	end
	if (strCommand == "lock") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_LOCK_MSG);
		return;
	end
	if (strCommand == "unlock") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_UNLOCK_MSG);
		return;
	end
	if (strCommand == "colourtitleon" or strCommand == "colortitleon") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_COLOURTITLEON_MSG);
		return;
	end
	if (strCommand == "colourtitleoff" or strCommand == "colortitleoff") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_COLOURTITLEOFF_MSG);
		return;
	end
	if (strCommand == "hidecompletedquests") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG);
		return;
	end
	if (strCommand == "showcompletedquests") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG);
		return;
	end
	if (strCommand == "hidecompletedobjectives") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG);
		return;
	end
	if (strCommand == "showcompletedobjectives") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG);
		return;
	end
	if (strCommand == "fontheight") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_FONTHEIGHT_MSG);
		return;
	end
	if (strCommand == "showtooltipobjectives") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG);
		return;
	end
	if (strCommand == "hidetooltipobjectives") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG);
		return;
	end
	if (strCommand == "allowrightclick") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG);
		return;
	end
	if (strCommand == "disallowrightclick") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG);
		return;
	end
	if (strCommand == "hidetitlebuttons") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG);
		return;
	end
	if (strCommand == "showtitlebuttons") then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG);
		return;
	end
	
	-- made it to the end just print the default help
	DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_HELP_MSG);
end

function MonkeyQuestSlash_CmdReset()
	StaticPopup_Show("MONKEYQUEST_RESET");
end

function MonkeyQuestSlash_CmdOpen(bOpen)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bDisplay = bOpen;
	
	if (bOpen == true) then
		MonkeyQuest_Show();
	else
		MonkeyQuest_Hide();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdShowHidden(bShow)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden = bShow;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdUseOverviews(bOverviews)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bObjectives = bOverviews;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdHideHeaders(bHide)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoHeaders = bHide;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdAlwaysHeaders(bAlways)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bAlwaysHeaders = bAlways;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdHideBorder(bNoBorder)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoBorder = bNoBorder;
	
	if (bNoBorder == true) then
		MonkeyQuestFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bCrashBorder == true) then
		MonkeyQuestFrame:SetBackdropBorderColor(MONKEYQUEST_DEFAULT_CRASHCOLOUR.r, MONKEYQUEST_DEFAULT_CRASHCOLOUR.g, MONKEYQUEST_DEFAULT_CRASHCOLOUR.b, 1.0);
	else
		MonkeyQuestFrame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1.0);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdGrowUp(bGrowUp)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bGrowUp = bGrowUp;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdAlpha(iAlpha)
	if (iAlpha >= 0 and iAlpha <= 255) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iAlpha = iAlpha / 255;
		MonkeyQuest_SetAlpha(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iAlpha);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdWidth(iWidth)
	if (iWidth >= 200 and iWidth <= 600) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameWidth = iWidth;
		MonkeyQuestFrame:SetWidth(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameWidth);
		MonkeyQuest_Refresh();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdFontHeight(iHeight)
	if (iHeight >= 8 and iHeight <= 48) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFontHeight = iHeight;
		
		MonkeyQuest_Refresh();
		
		-- little fix for when changing the font size
		MonkeyQuestFrame:SetScale(2);
		MonkeyQuestFrame:SetScale(1);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdTipAnchor(strAnchor)
	if (strAnchor == nil) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "DEFAULT";
		return;
	end
	
	-- let's check that it's a valid anchor before setting it
	if (string.upper(strAnchor) == "ANCHOR_TOPLEFT") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_TOPRIGHT") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_TOP") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_LEFT") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_RIGHT") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_BOTTOMLEFT") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_BOTTOMRIGHT") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_BOTTOM") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "ANCHOR_CURSOR") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "DEFAULT") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	if (string.upper(strAnchor) == "NONE") then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = string.upper(strAnchor);
		return;
	end
	
	-- bad input or default, set it to the default position
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_TOPLEFT";
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdShowNumQuests(bShowNumQuests)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNumQuests = bShowNumQuests;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdLock(bLocked)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLocked = bLocked;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdColourTitleOn(bColourTitle)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bColourTitle = bColourTitle;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdHideCompletedQuests(bHide)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideCompletedQuests = bHide;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdHideCompletedObjectives(bHide)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideCompletedObjectives = bHide;
	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdShowTooltipObjectives(bShow)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowTooltipObjectives = bShow;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdAllowRightClick(bAllow)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bAllowRightClick = bAllow;
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdHideTitleButtons(bHide)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideTitleButtons = bHide;
	
	if (bHide == true) then
		MonkeyQuestCloseButton:Hide();
		MonkeyQuestMinimizeButton:Hide();
		MonkeyQuestShowHiddenCheckButton:Hide();
	else
		MonkeyQuestCloseButton:Show();
		MonkeyQuestMinimizeButton:Show();
		MonkeyQuestShowHiddenCheckButton:Show();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdHideTitle(bHide)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideTitle = bHide;
	MonkeyQuest_Refresh();

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_ToggleDisplay()
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bDisplay) then
		MonkeyQuest_Hide();
	else
		MonkeyQuest_Show();
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_ToggleShowHidden()
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden = not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowHidden;

	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_ToggleObjectives()
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bObjectives = not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bObjectives;

	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_ToggleAnchor()

	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bDefaultAnchor == true) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bDefaultAnchor = false;
		
	else
		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "ANCHOR_BOTTOMRIGHT") then
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_BOTTOMLEFT";
			
		elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "ANCHOR_BOTTOMLEFT") then
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_TOPLEFT";
		
		elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "ANCHOR_TOPLEFT") then
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_LEFT";
			
		elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "ANCHOR_LEFT") then
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_CURSOR";
			
		elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor == "ANCHOR_CURSOR") then
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bDefaultAnchor = true;
			MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_BOTTOMRIGHT";
			
		end
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_Alpha(msg)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (not(tonumber(msg, 10) == nil)) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iAlpha = tonumber(msg, 10);
	else
		-- set it to the default
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iAlpha = MONKEYQUEST_DEFAULT_ALPHA;
	end
	
	MonkeyQuest_SetAlpha(MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iAlpha);
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_Width(msg)
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	if (not(tonumber(msg, 10) == nil)) then
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameWidth = tonumber(msg, 10);
	else
		-- set it to the default
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iFrameWidth = MONKEYQUEST_DEFAULT_WIDTH;
	end
	
	MonkeyQuest_Refresh();
	
	-- Let the user know they might have to reload the ui
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(MONKEYQUEST_SET_WIDTH_MSG);
	end
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_ToggleNoHeaders()
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoHeaders = not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoHeaders;

	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_ToggleNoBorder()
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoBorder = not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoBorder;

	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bNoBorder == true) then
		MonkeyQuestFrame:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bCrashBorder == false) then
		MonkeyQuestFrame:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1.0);
	else
		MonkeyQuestFrame:SetBackdropBorderColor(MONKEYQUEST_DEFAULT_CRASHCOLOUR.r, MONKEYQUEST_DEFAULT_CRASHCOLOUR.g, MONKEYQUEST_DEFAULT_CRASHCOLOUR.b, 1.0);
	end

	--MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_ToggleGrow()
	-- if not loaded yet then get out
	if (MonkeyQuest.m_bLoaded == false) then
		return;
	end

	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bGrowUp = not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bGrowUp;

	MonkeyQuest_Refresh();
	
	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdShowNoobTips(bShowNoobTips)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNoobTips = bShowNoobTips;

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdSetQuestPadding(iPadding)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_iQuestPadding = iPadding;

	local	i = 2;

	-- loop through ALL the quest button and apply the padding
	for i = 2, MONKEYQUEST_MAX_BUTTONS, 1 do
		getglobal("MonkeyQuestButton" .. i):SetPoint("TOPLEFT", "MonkeyQuestButton" .. (i - 1), "BOTTOMLEFT", 0, -iPadding);
	end

	-- resize MonkeyQuest
	MonkeyQuest_Resize();

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdShowZoneHighlight(bShowZoneHighlight)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowZoneHighlight = bShowZoneHighlight;

	MonkeyQuest_Refresh();

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

function MonkeyQuestSlash_CmdShowQuestLevel(bShowQuestLevel)
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowQuestLevel = bShowQuestLevel;

	MonkeyQuest_Refresh();

	-- check for MonkeyBuddy
	if (MonkeyBuddyQuestFrame_Refresh ~= nil) then
		MonkeyBuddyQuestFrame_Refresh();
	end
end

--Created by Tehu of Garona
--
--
--Credit goes out to the creators of AvgXP and AvgXPPlus for the AvgXP functions
--Credit goes out to the creator of TotalXP for the XP needed until 60 function
--Credit goes out the the creator of the original XPBar (non titan that is :P) for the sizing functions

TITAN_XPBAR_FREQUENCY=1
local restxp=nil
PLAYER_ENTERING_WORLD=0
TITAN_XPBAR_BUTTON_TEXT_XP="XP: %s"
TITAN_XPBAR_BUTTON_TEXT_NIL="%s"
TITAN_XPBAR_BUTTON_TEXT_NEEDED="%s XP"
TITAN_XPBAR_BUTTON_TEXT_NPCT="%s"
TITAN_XPBAR_MENU_TEXT="XPBar"
TITAN_XPBAR_MENU_SHOW_STATUS="Show XP Statusbar"
TITAN_XPBAR_MENU_HIDE_STATUS="Hide XP Statusbar"
TITAN_XPBAR_TOOLTIP_XP="Current XP:"
TITAN_XPBAR_TOOLTIP_LEV="Level XP:"
TITAN_XPBAR_TOOLTIP_REST="Rested XP:"
TITAN_XPBAR_TOOLTIP_NEED="XP Until Next Level:"
TITAN_XPBAR_TOOLTIP_PERCENT=""
TITAN_XPBAR_TOOLTIP="Experience Tooltip"
TITAN_XPBAR_TOOLTIP_CURRLEV="Currently Level:"
TITAN_XPBAR_TOOLTIP_XPTO60="XP Remaining Until 60"
TITAN_XPBAR_TOOLTIP_XPSOFAR="XP Gained Since Level 1"
TITAN_XPBAR_TOOLTIP_XPTO60PCT=""
TITAN_XPBAR_TOOLTIP_XPSOFARPCT=""
TITAN_XPBAR_TOTAL_TIME_PLAYED = "Total Time Played:"
TITAN_XPBAR_LEVEL_TIME_PLAYED = "Time Played This Level:"
TITAN_XPBAR_SESSION_TIME_PLAYED = "Time Played This Session:"
TITAN_XPBAR_SESSION_XP = "XP Gained This Session:"
TITAN_XPBAR_PER_HOUR_LEVEL = "XP Per Hour This Level:"
TITAN_XPBAR_PER_HOUR_SESSION = "XP Per Hour This Session:"
TITAN_XPBAR_EST_TIME_TO_LEVEL_LEVEL_RATE = "Time To Level At This Level's Rate:"
TITAN_XPBAR_EST_TIME_TO_LEVEL_SESSION_RATE = "Time To Level At This Session's Rate:"

TITAN_XPBAR_TOTAL_KILLS="Total Kills This Session:"
TITAN_XPBAR_TOTAL_NKILLS="Total Kills Needed To Level:"
TITAN_XPBAR_AVGXP="Average XP Gained Per Kill:"
TITAN_XPBAR_MENU_SHOW_TEXT="Show Average XP Text"

TITAN_XPBAR_NKILLS=" Needed: %s"
TITAN_XPBAR_KILLS=" Kills: %s"
TITAN_XPBAR_AVGXPTEXT="AVG XP: %s"

TITAN_XPBAR_MENU_SHOWCURR="Display Current Level Info"
TITAN_XPBAR_MENU_SHOWNEXT="Display XP Needed Until Next Level"
TITAN_XPBAR_MENU_CHAT="Enable Chat Output"

LBLUE_FONT_COLOR="|cff55A9FF"

TXP_pos = {};
RegisterForSave("TXP_pos");
AVG_pos = {};
RegisterForSave("AVG_pos");

function TitanPanelXPBarButton_OnLoad()
	SlashCmdList["TXP"] = TXP_SlashHandler
	SLASH_TXP1 = "/txp";
	
	SlashCmdList["TEST"] = TXP_TestHandler;
	SLASH_TEST1 = "/test"

	DEFAULT_CHAT_FRAME:AddMessage("TitanXPBar Loaded, /txp for options", 1, 1, 0)

	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("UPDATE_EXHAUSTION")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_LEVEL_UP")
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this.registry={
		id="XPBar",
		menuText = TITAN_XPBAR_MENU_TEXT,
		buttonTextFunction="TitanPanelXPBarButton_GetButtonText",
		tooltipTitle = TITAN_XPBAR_TOOLTIP,
		tooltipTextFunction = "TitanPanelXPBarButton_GetTooltipText", 
	}

	totalkilled=0
	avgxp=0
	totalxpgained=0
	lastxpgained=0
	numleft=0 
	bar = {255, 255, 255}

	
	
end

function TXP_TestHandler(msg)
	RegisterForSave("test_Args");
	test_Args=tyn_Parser(msg);
end	

function tyn_Parser(commandline)
	local t = {};
	local k, v;
	local msg=commandline;
	for k, v in string.gfind(msg, "(%w+)=\"(.-)\"") do
		t[k] = v
	end
	msg=string.gsub(msg, "(%w+)=\"(.-)\"", "")
	for k, v in string.gfind(msg, "(%w+)=(%w+)") do
		t[k] = v
	end
	msg=string.gsub(msg, "(%w+)=(%w+)", "")
	for k in string.gfind(msg, "(%w+)") do
		t[k] = true;
	end
	return t;
end

function TitanPanelXPBarButton_OnEvent(event)
	local rxp,curr,max,needed,currpcent,needpcent,currlev,nextlev=TitanPanelXPBarButton_GetXPBarInfo()
	TitanPanelButton_UpdateButton("XPBar")
	Statusbar_Update()
	
	if (TitanSettings.Chat == nil) then
		if (event == "PLAYER_XP_UPDATE") then
		DEFAULT_CHAT_FRAME:AddMessage(LBLUE_FONT_COLOR..curr.."/"..max.." XP ("..needpcent..") to go"..FONT_COLOR_CODE_CLOSE)
		DEFAULT_CHAT_FRAME:AddMessage(LBLUE_FONT_COLOR..needed.." XP Until Level "..nextlev..FONT_COLOR_CODE_CLOSE)
		end
	end
	
	if (event == "PLAYER_ENTERING_WORLD") then
		if (PLAYER_ENTERING_WORLD == 0) then		
		this.initXP = UnitXP("player");
		this.accumXP = 0;
		this.sessionXP = 0;
		PLAYER_ENTERING_WORLD = 1
		end
	elseif (event == "PLAYER_XP_UPDATE") then
		if (not this.initXP) then
			this.initXP = UnitXP("player");
			this.accumXP = 0;
			this.sessionXP = 0;
		end
		this.sessionXP = UnitXP("player") - this.initXP + this.accumXP;
	elseif (event == "PLAYER_LEVEL_UP") then
		this.accumXP = this.accumXP + UnitXPMax("player") - this.initXP;
		this.initXP = 0;
	end

	if(event=="CHAT_MSG_COMBAT_XP_GAIN") then
	for mobile_name, xp in string.gfind(arg1, "(.+) dies, you gain (%d+) experience.") do
		lastxpgained = tonumber(xp)
		totalkilled = totalkilled + 1
		totalxpgained = totalxpgained + lastxpgained
	end
	end
		
			


	if( (totalkilled > 0) and (totalkilled~=nil) ) then
			avgxp = floor(totalxpgained / totalkilled * 100) / 100;
	end


	if( (avgxp > 0) and (avgxp~=nil) ) then
			numleft = ( UnitXPMax("player") - UnitXP("player") ) / avgxp;
			numleft = ceil(numleft);
	end

	if (event == "VARIABLES_LOADED") then
		if (XPBar_Width) then
			XPBG:SetWidth(XPBar_Width);
			XPStatus:SetWidth(XPBar_Width);
		end

		if (XPBar_Height) then
			XPBG:SetHeight(XPBar_Height);
			XPStatus:SetHeight(XPBar_Height);
		end

		if (AVGXP_Locked) then
			TXP_SlashHandler('lock');
		end
		

	TXP()
	AVG()
	end

end

function TitanPanelXPBarButton_GetButtonText(id)
	local rxp,curr,max,needed,currpcent,needpcent,currlev,nextlev=TitanPanelXPBarButton_GetXPBarInfo()
	local button, id = TitanUtils_GetButton(id, true);
	if (rxp == nil) then
		rxp=0
	else
		rxp=rxp
	end
	
	
	if (TitanSettings.Status == 1) then
		XPStatus:Hide()
	end

	if (TitanSettings.Status == nil) then
		XPStatus:Show()
	end	

	
	if (TitanSettings.Showtext == nil) then
		getglobal("AVGText"):SetText("AVG XP: "..TitanUtils_GetHighlightText(avgxp).." Kills: "..TitanUtils_GetHighlightText(totalkilled).." Needed: "..TitanUtils_GetHighlightText(numleft))
		AVGXPButton:Show()
	end
	
	if (TitanSettings.Showtext == 1) then
		AVGXPButton:Hide()
	end

	if (TitanSettings.XPFormat == 1) then	
	return
		format(TITAN_XPBAR_BUTTON_TEXT_XP,TitanUtils_GetHighlightText(curr)).."/"..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(max)).." + ("..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp)).." Rested)"
	end


	if (TitanSettings.XPFormat == nil) then
	return
		format(TITAN_XPBAR_BUTTON_TEXT_NEEDED,TitanUtils_GetHighlightText(needed)).." ("..
		format(TITAN_XPBAR_BUTTON_TEXT_NPCT,TitanUtils_GetHighlightText(needpcent))..") until "..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(nextlev)).." ("..
		format(TITAN_XPBAR_BUTTON_TEXT_NIL,TitanUtils_GetHighlightText(rxp)).." Rested)"
	end

end

function TitanPanelXPBarButton_GetXPBarInfo()
	local rxp=GetXPExhaustion("player")
	local max=UnitXPMax("player")
	local curr=UnitXP("player")
	local needed=max - curr
	local currpercent=string.format("%.2f", ( curr / max) * 100)
	local needpcent=string.format("%.2f", ( needed / max) * 100)
	local currlev=UnitLevel("player")
	local nextlev=currlev + 1
	return rxp,curr,max,needed,currpercent.."%",needpcent.."%",currlev,nextlev
end

function TitanPanelXPBarButton_GetTooltipText()
	local rxp,curr,max,needed,currpercent,needpcent,currlev=TitanPanelXPBarButton_GetXPBarInfo()
	local totalxp,totalMaxXP,totalxppct,needxp,needxppct,totalgpct,totalnpct=totalxp(level)
	local totalTime = TitanUtils_GetTotalTime();
	local sessionTime = TitanUtils_GetSessionTime();
	local levelTime = TitanUtils_GetLevelTime();	
	local xpPerHourThisLevel = curr / levelTime * 3600;
	local xpPerHourThisSession = this.sessionXP / sessionTime * 3600;
	local estTimeToLevelThisLevel = TitanUtils_Ternary((curr == 0), -1, needed / curr * levelTime);
	local estTimeToLevelThisSession = TitanUtils_Ternary((this.sessionXP == 0), -1, needed / this.sessionXP * sessionTime);	

	if (rxp == nil) then
		rxp=0 
		rxppcent=0 .."%"
	else
		rxppcent=floor(rxp*100/max) .."%"
	end

	return  ""..
		TITAN_XPBAR_TOOLTIP_CURRLEV.." "..GetBlueText(currlev).."\n"..
		"\n"..
		TITAN_XPBAR_TOOLTIP_XP.." "..TitanUtils_GetHighlightText(curr).." "..
		TITAN_XPBAR_TOOLTIP_PERCENT.." ("..TitanUtils_GetHighlightText(currpercent)..")".."\n"..
		TITAN_XPBAR_TOOLTIP_LEV.." "..TitanUtils_GetHighlightText(max).."\n"..
		TITAN_XPBAR_TOOLTIP_NEED.." "..TitanUtils_GetHighlightText(needed).." "..
		TITAN_XPBAR_TOOLTIP_PERCENT.." ("..TitanUtils_GetHighlightText(needpcent)..")".."\n"..
		TITAN_XPBAR_TOOLTIP_REST.." "..TitanUtils_GetHighlightText(rxp).." "..
		TITAN_XPBAR_TOOLTIP_PERCENT.." ("..TitanUtils_GetHighlightText(rxppcent)..")".."\n".."\n"..
		TITAN_XPBAR_TOOLTIP_XPSOFAR..": "..GetBlueText(totalxp).." ("..
		TITAN_XPBAR_TOOLTIP_XPSOFARPCT..""..GetBlueText(totalgpct)..")".."\n"..
		TITAN_XPBAR_TOOLTIP_XPTO60.." "..GetBlueText(needxp).." ("..
		TITAN_XPBAR_TOOLTIP_XPTO60PCT..""..GetBlueText(totalnpct)..")".."\n".."\n"..
		TITAN_XPBAR_SESSION_XP.." "..TitanUtils_GetGreenText(this.sessionXP).."\n"..
		TITAN_XPBAR_AVGXP.." "..TitanUtils_GetGreenText(avgxp).."\n".."\n"..
		TITAN_XPBAR_TOTAL_KILLS.." "..GetBlueText(totalkilled).."\n"..
		TITAN_XPBAR_TOTAL_NKILLS.." "..GetBlueText(numleft).."\n".."\n"..		
		TITAN_XPBAR_PER_HOUR_LEVEL.." "..TitanUtils_GetHighlightText(floor((xpPerHourThisLevel / 100) *100)).."\n"..
		TITAN_XPBAR_PER_HOUR_SESSION.." "..TitanUtils_GetHighlightText(floor((xpPerHourThisSession / 100)*100)).."\n".."\n"..
		TITAN_XPBAR_TOTAL_TIME_PLAYED.." "..TitanUtils_GetHighlightText(TitanUtils_GetAbbrTimeText(totalTime)).."\n"..
		TITAN_XPBAR_EST_TIME_TO_LEVEL_LEVEL_RATE.." "..TitanUtils_GetHighlightText(TitanUtils_GetAbbrTimeText(estTimeToLevelThisLevel)).."\n"..
		TITAN_XPBAR_EST_TIME_TO_LEVEL_SESSION_RATE.." "..TitanUtils_GetHighlightText(TitanUtils_GetAbbrTimeText(estTimeToLevelThisSession))
		

end

function GetBlueText(text)
	if (text) then
		return LBLUE_FONT_COLOR..text..FONT_COLOR_CODE_CLOSE;
	end
end

function Statusbar_Update()
	local currValue = UnitXP("player");
	local maxValue = UnitXPMax("player");

	XPStatus:SetMinMaxValues(0, maxValue);
	XPStatus:SetValue(currValue);

	XPBG:SetMinMaxValues(0, maxValue);
	XPBG:SetValue(maxValue)

	XPStatus:ClearAllPoints();
	XPStatus:SetPoint("BOTTOM", "UIParent", "BOTTOM", TXP_pos["LOCATIONX"], TXP_pos["LOCATIONY"]);

	AVGText:ClearAllPoints();
	AVGText:SetPoint("BOTTOM", "UIParent", "BOTTOM", AVG_pos["LOCX"], AVG_pos["LOCY"]);
end

function TitanPanelRightClickMenu_PrepareXPBarMenu()
	local id = "XPBar";
	local info;

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);

	info = {};
	info.text = TITAN_XPBAR_MENU_SHOWCURR
	info.func = TitanPanelXPBarButton_ShowCurr
	info.checked=TitanSettings.XPFormat
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_XPBAR_MENU_SHOWNEXT
	info.func = TitanPanelXPBarButton_ShowNext
	info.checked=TitanUtils_Toggle(TitanSettings.XPFormat)
	UIDropDownMenu_AddButton(info)
	TitanPanelRightClickMenu_AddSpacer()

	info = {};
	info.text = TITAN_XPBAR_MENU_SHOW_STATUS;
	info.func = TitanPanelXPBarButton_ShowStatus;
	info.checked = TitanUtils_Toggle(TitanSettings.Status);
	UIDropDownMenu_AddButton(info);

	info = {};
	info.disabled = nil
	info.text = TITAN_XPBAR_MENU_SHOW_TEXT
	info.func = TitanPanelXPBarButton_ShowText
	info.checked = TitanUtils_Toggle(TitanSettings.Showtext)
	UIDropDownMenu_AddButton(info)
	
	info = {};
	info.text = TITAN_XPBAR_MENU_CHAT
	info.func = TitanPanelXPBarButton_Chat
	info.checked = TitanUtils_Toggle(TitanSettings.Chat)
	UIDropDownMenu_AddButton(info)

	info = {}
	info.text = "Enable Shift+Click Output"
	info.func = TitanPanelXPBarButton_Shift
	info.checked = TitanUtils_Toggle(TitanSettings.Shift)
	UIDropDownMenu_AddButton(info)

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelXPBarButton_ShowStatus()
	TitanSettings.Status = TitanUtils_Toggle(TitanSettings.Status)
	TitanPanelButton_UpdateButton("XPBar");
end


function totalxp(level)
	myLevel	= UnitLevel("player");
	myCurrXP = UnitXP("player");
	myMaxXP = UnitXPMax("player");
	myTNLXP = myMaxXP - myCurrXP;

	xpl = { 0, 400, 1300, 2700, 4800, 7600, 11200, 15700, 21100, 27600,
                35200, 44000, 54100, 65500, 78400, 92800, 108800, 126500,
		145900, 167200, 190400, 215600, 242900, 272300, 304000,
		338000, 374400, 413300, 454700, 499000, 546400, 597200,
		651900, 710500, 773300, 840300, 911900, 988000, 1068800,
		1154500, 1245200, 1341000, 1442000, 1548300, 1660100,
		1777500, 1900700, 2029800, 2164900, 2306100, 2453600,
		2607500, 2767900, 2935000, 3108900, 3289700, 3477600,
		3672600, 3874900, 4084700 }
		
	local totalxp = xpl[myLevel] + myCurrXP;
	local totalMaxXP = xpl[60];
	local totalxppct = totalxp / totalMaxXP;

	local needxp = totalMaxXP - totalxp
	local needxppct = (totalMaxXP - totalxp) / totalMaxXP
	
	local totalgpct = floor(totalxppct * 10000) / 100
	local totalnpct = floor(needxppct * 10000) / 100

	return totalxp,totalMaxXP,totalxppct,needxp,needxppct,totalgpct.."%",totalnpct.."%"
end

function TitanPanelXPBarButton_ShowText()
	TitanSettings.Showtext=TitanUtils_Toggle(TitanSettings.Showtext)
	TitanPanelButton_UpdateButton("XPBar")
end

function TitanPanelXPBarButton_Chat()
	TitanSettings.Chat=TitanUtils_Toggle(TitanSettings.Chat)
end

function TitanPanelXPBarButton_ShowCurr()
	TitanSettings.XPFormat=1
	TitanPanelButton_UpdateButton("XPBar")
end

function TitanPanelXPBarButton_ShowNext()
	TitanSettings.XPFormat=nil
	TitanPanelButton_UpdateButton("XPBar")
end

function TitanPanelXPBarButton_Shift()
	TitanSettings.Shift=TitanUtils_Toggle(TitanSettings.Shift)
	TitanPanelButton_UpdateButton("XPBar")
end

function TitanPanelXPBarButton_OnClick()
	local rxp,curr,max,needed,currpercent,needpcent,currlev,nextlev=TitanPanelXPBarButton_GetXPBarInfo()
	

	if (IsShiftKeyDown()) then
		if (not chatFrame) then
	   		chatFrame = DEFAULT_CHAT_FRAME;
		end
		
		chatType = chatFrame.editBox.chatType;

		if (TitanSettings.Shift == nil) then
		      if (ChatFrameEditBox:IsVisible()) then
	      			ChatFrameEditBox:Insert("Currently "..curr.."/"..max.." XP with "..needed.." XP ("..needpcent..") until level "..nextlev);
	      		else
	        		SendChatMessage("Currently "..curr.."/"..max.." XP with "..needed.." XP ("..needpcent..") until level "..nextlev);
		      end
		
		end
	end
end

function TXP_SlashHandler(msg)

if (msg == 'help') then msg = nil end
--if (msg == '') then 
--	DEFAULT_CHAT_FRAME:AddMessage("Usage: /txp height=## width=## x=## y=## avgx=## avgy=##", 1, 1, 0)
--	DEFAULT_CHAT_FRAME:AddMessage("Typing just '/txp x' (or y) will display the current x (or y) position", 1, 1, 0)
--end

if msg then

	local LOCK = false;
	local UNLOCK = false;

	local param = TXP_Split(msg, " ");
	
	

	
	local i = 1;
	
	
	while ( param[i] ~= nil ) do
		local current = string.lower(param[i]);
		if (string.sub(current, 1, 7)=="height=") then
			local height=tonumber(string.sub(current, 8));
			if (height) then
				if (height<10) then
					height=10;
				end
				XPBar_Height = height;
				XPBG:SetHeight(XPBar_Height);
				XPStatus:SetHeight(XPBar_Height);
			end
		end
		if (string.sub(current, 1, 6)=="width=") then
			local width=tonumber(string.sub(current, 7));
			if (width) then
				if (width<50) then
					width=50;
				end
				XPBar_Width = width;
				XPBG:SetWidth(XPBar_Width);
				XPStatus:SetWidth(XPBar_Width);
			end
		end

		if (current == "x") then
			DEFAULT_CHAT_FRAME:AddMessage("Current Statusbar X = " ..TXP_pos["LOCATIONX"], 1, 1, 0);
		end

		if (current == "") then
			DEFAULT_CHAT_FRAME:AddMessage("Use: /txp height=## width=## x=## y=## avgx=## avgy=##", 1, 1, 0)
			DEFAULT_CHAT_FRAME:AddMessage("Typing just '/txp x'(or y) will display the current x (or y) position", 1, 1, 0)
			DEFAULT_CHAT_FRAME:AddMessage("The same works for avgx and avgy", 1, 1, 0)
		end

		if (string.sub(current, 1, 2)=="x=") then
			local xpos=tonumber(string.sub(current,3))
			if (xpos) then
				if (xpos==0) then
					xpos=0
				end
				TXP_pos["LOCATIONX"] = xpos
			end
		end
		
		if (current == "y") then
			DEFAULT_CHAT_FRAME:AddMessage("Current Statusbar Y = " ..TXP_pos["LOCATIONY"], 1, 1, 0);
		end

		if (current == "avgx") then
			DEFAULT_CHAT_FRAME:AddMessage("Current AVGXP X = " ..AVG_pos["LOCX"], 1, 1, 0);
		end

		if (current == "avgy") then
			DEFAULT_CHAT_FRAME:AddMessage("Current AVGXP Y = " ..AVG_pos["LOCY"], 1, 1, 0);
		end
		
		if (string.sub(current, 1, 2)=="y=") then
			local ypos=tonumber(string.sub(current,3))
			if (ypos) then
				if (ypos == 0) then
					ypos=0
				end
				TXP_pos["LOCATIONY"] = ypos
			end
		end

		if (string.sub(current, 1, 5)=="avgx=") then
			local avgxpos=tonumber(string.sub(current,6))
			if (avgxpos) then
				if (avgxpos == 0) then
					avgxpos=0
				end
				AVG_pos["LOCX"] = avgxpos
			end
		end

		if (string.sub(current, 1, 5)=="avgy=") then
			local avgypos=tonumber(string.sub(current,6))
			if (avgypos) then
				if (avgypos == 0) then
					avgypos=0
				end
				AVG_pos["LOCY"] = avgypos
			end
		end

	 	i = i + 1;

	end

	

	Statusbar_Update();
	TXP()
	AVG()
end
end

function TXP_Split(toCut, separator)
	local splitted = {};
	local i = 0;
	local regEx = "([^" .. separator .. "]*)" .. separator .. "?";

	for item in string.gfind(toCut .. separator, regEx) do
		i = i + 1;
		splitted[i] = TXP_Trim(item) or '';
	end
	splitted[i] = nil;
	return splitted;
end

function TXP_Trim (s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

function TXP()
	if ( not TXP_pos["LOCATIONX"] ) then
		TXP_pos["LOCATIONX"] = "0";
	end
	
	if ( not TXP_pos["LOCATIONY"] ) then
	TXP_pos["LOCATIONY"] = "90";
	end
end

function AVG()
	if ( not AVG_pos["LOCX"] ) then
		AVG_pos["LOCX"] = "0";
	end

	if ( not AVG_pos["LOCY"] ) then
		AVG_pos["LOCY"] = "90";
	end
end
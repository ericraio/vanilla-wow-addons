WIM_VERSION = "1.2.10";

WIM_Windows = {};
WIM_EditBoxInFocus = nil;
WIM_NewMessageFlag = false;
WIM_NewMessageCount = 0;
WIM_Icon_TheMenu = nil;
WIM_Icon_UpdateInterval = .5;
WIM_CascadeStep = 0;
WIM_MaxMenuCount = 20;
WIM_ClassIcons = {};
WIM_ClassColors = {};

WIM_AlreadyCheckedGuildRoster = false;

WIM_GuildList = {}; --[Not saved between sessions: Autopopulates from GUILD_ROSTER_UPDATE event
WIM_FriendList = {}; --[Not saved between sessions: Autopopulates from FRIENDLIST_SHOW & FRIENDLIST_UPDATE event

WIM_Alias = {};
WIM_Filters = nil;
	
WIM_ToggleWindow_Timer = 0;
WIM_ToggleWindow_Index = 1;

WIM_RecentList = {}; --[Not saved between sessions: Store's list of recent conversations.
	
WIM_History = {};

WIM_Data_DEFAULTS = {
	versionLastLoaded = "",
	showChangeLogOnNewVersion = true,
	enableWIM = true,
	iconPosition=337,
	showMiniMap=true,
	displayColors = {
		wispIn = {r=0.5607843137254902, g=0.03137254901960784, b=0.7607843137254902},
		wispOut = {r=1, g=0.07843137254901961, b=0.9882352941176471},
		sysMsg = {r=1, g=0.6627450980392157, b=0},
		errorMsg = {r=1, g=0, b=0},
		webAddress = {r=0, g=0, b=1},
	},
	fontSize = 12,
	windowSize = 1,
	windowAlpha = .8,
	supressWisps = true,
	keepFocus = false,
	popNew = true,
	popUpdate = true,
	popOnSend = true,
	popCombat = false,
	autoFocus = false,
	playSoundWisp = true,
	showToolTips = true,
	sortAlpha = true,
	winSize = {
		width = 384,
		height = 256
	},
	winLoc = {
		left =242 ,
		top =775
	},
	winCascade = {
		enabled = true,
		direction = "downright"
	},
	miniFreeMoving = {
		enabled = false;
		left = 0,
		top = 0
	},
	characterInfo = {
		show = true,
		classIcon = true,
		details = true,
		classColor = true
	},
	showTimeStamps = true,
	showShortcutBar = true,
	enableAlias = true,
	enableFilter = true,
	aliasAsComment = true,
	enableHistory = true,
	historySettings = {
		recordEveryone = false,
		recordFriends = true,
		recordGuild = true,
		colorIn = {
				r=0.4705882352941176,
				g=0.4705882352941176,
				b=0.4705882352941176
		},
		colorOut = {
				r=0.7058823529411764,
				g=0.7058823529411764,
				b=0.7058823529411764
		},
		popWin = {
			enabled = true,
			count = 25
		},
		maxMsg = {
			enabled = true,
			count = 200
		},
		autoDelete = {
			enabled = true,
			days = 7
		}
	}
};
--[initialize defualt values
WIM_Data = WIM_Data_DEFAULTS;

WIM_CascadeDirection = {
	up = {
		left = 0,
		top = 25
	},
	down = {
		left = 0,
		top = -25
	},
	left = {
		left = -50,
		top = 0
	},
	right = {
		left = 50,
		top = 0
	},
	upleft = {
		left = -50,
		top = 25
	},
	upright = {
		left = 50,
		top = 25
	},
	downleft = {
		left = -50,
		top = -25
	},
	downright = {
		left = 50,
		top = -25
	}
};

WIM_IconItems = { };

function WIM_OnLoad()
	SlashCmdList["WIM"] = WIM_SlashCommand;
	SLASH_WIM1 = "/wim";
end


function WIM_Incoming(event)
	--[Events
	if(event == "VARIABLES_LOADED") then
		if(WIM_Data.enableWIM == nil) then WIM_Data.enableWIM = WIM_Data_DEFAULTS.enableWIM; end;
		if(WIM_Data.versionLastLoaded == nil) then WIM_Data.versionLastLoaded = ""; end;
		if(WIM_Data.showChangeLogOnNewVersion == nil) then WIM_Data.showChangeLogOnNewVersion = WIM_Data_DEFAULTS.showChangeLogOnNewVersion; end;
		if(WIM_Data.displayColors == nil) then WIM_Data.displayColors = WIM_Data_DEFAULTS.displayColors; end;
		if(WIM_Data.displayColors.sysMsg == nil) then WIM_Data.displayColors.sysMsg = WIM_Data_DEFAULTS.displayColors.sysMsg; end;
		if(WIM_Data.displayColors.errorMsg == nil) then WIM_Data.displayColors.errorMsg = WIM_Data_DEFAULTS.displayColors.errorMsg; end;
		if(WIM_Data.fontSize == nil) then WIM_Data.fontSize = WIM_Data_DEFAULTS.fontSize; end;
		if(WIM_Data.windowSize == nil) then WIM_Data.windowSize = WIM_Data_DEFAULTS.windowSize; end;
		if(WIM_Data.windowAlpha == nil) then WIM_Data.windowAlpha = WIM_Data_DEFAULTS.windowAlpha; end;
		if(WIM_Data.supressWisps == nil) then WIM_Data.supressWisps = WIM_Data_DEFAULTS.supressWisps; end;
		if(WIM_Data.keepFocus == nil) then WIM_Data.keepFocus = WIM_Data_DEFAULTS.keepFocus; end;
		if(WIM_Data.popNew == nil) then WIM_Data.popNew = WIM_Data_DEFAULTS.popNew; end;
		if(WIM_Data.popUpdate == nil) then WIM_Data.popNew = WIM_Data_DEFAULTS.popUpdate; end;
		if(WIM_Data.autoFocus == nil) then WIM_Data.autoFocus = WIM_Data_DEFAULTS.autoFocus; end;
		if(WIM_Data.playSoundWisp == nil) then WIM_Data.playSoundWisp = WIM_Data_DEFAULTS.playSoundWisp; end;
		if(WIM_Data.showToolTips == nil) then WIM_Data.showToolTips = WIM_Data_DEFAULTS.showToolTips; end;
		if(WIM_Data.sortAlpha == nil) then WIM_Data.sortAlpha = WIM_Data_DEFAULTS.sortAlpha; end;
		if(WIM_Data.winSize == nil) then WIM_Data.winSize = WIM_Data_DEFAULTS.winSize; end;
		if(WIM_Data.miniFreeMoving == nil) then WIM_Data.miniFreeMoving = WIM_Data_DEFAULTS.miniFreeMoving; end;
		if(WIM_Data.popCombat == nil) then WIM_Data.popCombat = WIM_Data_DEFAULTS.popCombat; end;
		if(WIM_Data.characterInfo == nil) then WIM_Data.characterInfo = WIM_Data_DEFAULTS.characterInfo; end;
		if(WIM_Data.showTimeStamps == nil) then WIM_Data.showTimeStamps = WIM_Data_DEFAULTS.showTimeStamps; end;
		if(WIM_Data.showShortcutBar == nil) then WIM_Data.showShortcutBar = WIM_Data_DEFAULTS.showShortcutBar; end;
		if(WIM_Data.enableAlias == nil) then WIM_Data.enableAlias = WIM_Data_DEFAULTS.enableAlias; end;
		if(WIM_Data.enableFilter == nil) then WIM_Data.enableFilter = WIM_Data_DEFAULTS.enableFilter; end;
		if(WIM_Data.aliasAsComment == nil) then WIM_Data.aliasAsComment = WIM_Data_DEFAULTS.aliasAsComment; end;
		if(WIM_Data.enableHistory == nil) then WIM_Data.enableHistory = WIM_Data_DEFAULTS.enableHistory; end;
		if(WIM_Data.historySettings == nil) then WIM_Data.historySettings = WIM_Data_DEFAULTS.historySettings; end;
		if(WIM_Data.winLoc == nil) then WIM_Data.winLoc = WIM_Data_DEFAULTS.winLoc; end;
		if(WIM_Data.winCascade == nil) then WIM_Data.winCascade = WIM_Data_DEFAULTS.winCascade; end;
		if(WIM_Data.popOnSend == nil) then WIM_Data.popOnSend = WIM_Data_DEFAULTS.popOnSend; end;
		if(WIM_Data.versionLastLoaded == nil) then WIM_Data.versionLastLoaded = WIM_Data_DEFAULTS.versionLastLoaded; end;
		
		if(WIM_Filters == nil) then
			WIM_LoadDefaultFilters();
		end
		
		ShowFriends(); --[update friend list
		if(IsInGuild()) then GuildRoster(); end; --[update guild roster
		
		ItemRefTooltip:SetFrameStrata("TOOLTIP");
		
		WIM_HistoryPurge();
		
		WIM_InitClassProps();
		
		WIM_SetWIM_Enabled(WIM_Data.enableWIM);
		
		if(WIM_VERSION ~= WIM_Data.versionLastLoaded) then
			WIM_Help:Show();
		end
		WIM_Data.versionLastLoaded = WIM_VERSION;
		
		if(WIM_Data.miniFreeMoving.enabled) then
			if(WIM_Data.showMiniMap == false) then
				WIM_IconFrame:Hide();
			else
				WIM_IconFrame:Show();
				WIM_IconFrame:SetFrameStrata("HIGH");
				WIM_IconFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",WIM_Data.miniFreeMoving.left,WIM_Data.miniFreeMoving.top);
			end
		else
			WIM_Icon_UpdatePosition();
		end
		
	elseif(event == "TRADE_SKILL_SHOW" or event == "CRAFT_SHOW") then
		--[hook tradeskill window functions
		WIM_HookTradeSkill();
	elseif(event == "GUILD_ROSTER_UPDATE") then
		WIM_LoadGuildList();
		WIM_AlreadyCheckedGuildRoster = true;
	elseif(event == "FRIENDLIST_SHOW" or event == "FRIENDLIST_UPDATE") then
		WIM_LoadFriendList();
	else
		if(WIM_AlreadyCheckedGuildRoster == false) then
			if(IsInGuild()) then GuildRoster(); end; --[update guild roster
		end
		WIM_ChatFrame_OnEvent(event);
	end
end

function WIM_ChatFrame_OnEvent(event)
	if( WIM_Data.enableWIM == false) then
		return;
	end
	local msg = "";
	if(event == "CHAT_MSG_AFK" or event == "CHAT_MSG_DND") then
		local afkType;
		if( event == "CHAT_MSG_AFK" ) then
			afkType = "AFK";
		else
			afkType = "DND";
		end
		msg = "<"..afkType.."> |Hplayer:"..arg2.."|h"..arg2.."|h: "..arg1;
		WIM_PostMessage(arg2, msg, 3);
		ChatEdit_SetLastTellTarget(ChatFrameEditBox,arg2);
	elseif(event == "CHAT_MSG_WHISPER") then
		if(WIM_FilterResult(arg1) ~= 1 and WIM_FilterResult(arg1) ~= 2) then
			msg = "[|Hplayer:"..arg2.."|h"..WIM_GetAlias(arg2, true).."|h]: "..arg1;
			WIM_PostMessage(arg2, msg, 1, arg2, arg1);
		end
		ChatEdit_SetLastTellTarget(ChatFrameEditBox,arg2);
	elseif(event == "CHAT_MSG_WHISPER_INFORM") then
		if(WIM_FilterResult(arg1) ~= 1 and WIM_FilterResult(arg1) ~= 2) then
			msg = "[|Hplayer:"..UnitName("player").."|h"..WIM_GetAlias(UnitName("player"), true).."|h]: "..arg1;
			WIM_PostMessage(arg2, msg, 2, UnitName("player") ,arg1);
		end
	elseif(event == "CHAT_MSG_SYSTEM") then
		local tstart,tfinish = string.find(arg1, "\'(%a+)\'");
		if(tstart ~= nil and tfinish ~= nil) then
			user = string.sub(arg1, tstart+1, tfinish-1);
			user = string.gsub(user, "^%l", string.upper)
			tstart, tfinish = string.find(arg1, "playing");
			if(tstart ~= nil and WIM_Windows[user] ~= nil) then
				-- player not playing, can't whisper
				msg = "|Hplayer:"..user.."|h"..user.."|h is not currently playing!";
				WIM_PostMessage(user, msg, 4);
			end
		end
	end
end

function WIM_ChatFrameSupressor_OnEvent(event)
	if(WIM_Data.enableWIM == false) then
		return true;
	end
	local msg = "";
	if(event == "CHAT_MSG_AFK" or event == "CHAT_MSG_DND") then
		if(WIM_Data.supressWisps) then
			return false; --[ false to supress from chatframe
		else
			return true;
		end	
	elseif(event == "CHAT_MSG_WHISPER") then
		if(WIM_Data.supressWisps) then
			if(WIM_FilterResult(arg1) == 1) then
				return true;
			else
				return false; --[ false to supress from chatframe
			end
		else
			if(WIM_FilterResult(arg1) == 2) then
				return false;
			else
				return true;
			end
		end
	elseif(event == "CHAT_MSG_WHISPER_INFORM") then
		if(WIM_Data.supressWisps) then
			if(WIM_FilterResult(arg1) == 1) then
				return true;
			else
				return false; --[ false to supress from chatframe
			end
		else
			if(WIM_FilterResult(arg1) == 2) then
				return false;
			else
				return true;
			end
		end
	elseif(event == "CHAT_MSG_SYSTEM") then
		local tstart,tfinish = string.find(arg1, "\'(%a+)\'");
		if(tstart ~= nil and tfinish ~= nil) then
			user = string.sub(arg1, tstart+1, tfinish-1);
			user = string.gsub(user, "^%l", string.upper)
			tstart, tfinish = string.find(arg1, "playing");
			if(tstart ~= nil and WIM_Windows[user] ~= nil) then
				-- player not playing, can't whisper
				if(WIM_Data.supressWisps) then
					return false; --[ false to supress from chatframe
				else
					return true;
				end
			end
		end
		return true;
	end
	return true;
end


function WIM_PostMessage(user, msg, ttype, from, raw_msg)
		--[[
			ttype:
				1 - Wisper from someone
				2 - Wisper sent
				3 - System Message
				4 - Error Message
				5 - Show window... Do nothing else...
		]]--
		
		local f,chatBox;
		local isNew = false;
		if(WIM_Windows[user] == nil) then
			if(getglobal("WIM_msgFrame"..user)) then
				f = getglobal("WIM_msgFrame"..user);
			else
				f = CreateFrame("Frame","WIM_msgFrame"..user,UIParent, "WIM_msgFrameTemplate");
			end
			WIM_SetWindowProps(f);
			WIM_Windows[user] = {
									frame = "WIM_msgFrame"..user, 
									newMSG = true, 
									is_visible = false, 
									last_msg=time(), 
									waiting_who=false,
									class="",
									level="",
									race="",
									guild=""
								};
			f.theUser = user;
			getglobal("WIM_msgFrame"..user.."From"):SetText(WIM_GetAlias(user));
			WIM_Icon_AddUser(user);
			isNew = true;
			WIM_SetWindowLocation(f);
			if(WIM_Data.characterInfo.show) then WIM_SendWho(user); end;
			WIM_UpdateCascadeStep();
			WIM_DisplayHistory(user);
			if(WIM_History[user]) then
				getglobal(f:GetName().."HistoryButton"):Show();
			end
		end
		f = getglobal("WIM_msgFrame"..user);
		chatBox = getglobal("WIM_msgFrame"..user.."ScrollingMessageFrame");
		msg = WIM_ConvertURLtoLinks(msg);
		WIM_Windows[user].newMSG = true;
		WIM_Windows[user].last_msg = time();
		if(ttype == 1) then
			WIM_PlaySoundWisp();
			WIM_AddToHistory(user, from, raw_msg, false);
			WIM_RecentListAdd(user);
			chatBox:AddMessage(WIM_getTimeStamp()..msg, WIM_Data.displayColors.wispIn.r, WIM_Data.displayColors.wispIn.g, WIM_Data.displayColors.wispIn.b);
		elseif(ttype == 2) then
			WIM_AddToHistory(user, from, raw_msg, true);
			WIM_RecentListAdd(user);
			chatBox:AddMessage(WIM_getTimeStamp()..msg, WIM_Data.displayColors.wispOut.r, WIM_Data.displayColors.wispOut.g, WIM_Data.displayColors.wispOut.b);
		elseif(ttype == 3) then
			chatBox:AddMessage(msg, WIM_Data.displayColors.sysMsg.r, WIM_Data.displayColors.sysMsg.g, WIM_Data.displayColors.sysMsg.b);
		elseif(ttype == 4) then
			chatBox:AddMessage(msg, WIM_Data.displayColors.errorMsg.r, WIM_Data.displayColors.errorMsg.g, WIM_Data.displayColors.errorMsg.b);
		end
		if( WIM_PopOrNot(isNew) or (ttype==2) or (ttype==5) ) then
			WIM_Windows[user].newMSG = false;
			if(ttype == 2 and WIM_Data.popOnSend == false) then
				--[ do nothing, user prefers not to pop on send
			else
				f:Show();
			end
		end
		WIM_UpdateScrollBars(chatBox);
		WIM_Icon_DropDown_Update();
		if(WIM_HistoryFrame:IsVisible()) then
			WIM_HistoryViewNameScrollBar_Update();
			WIM_HistoryViewFiltersScrollBar_Update();
		end
end

function WIM_SetWindowLocation(theWin)
	local CascadeOffset_Left = 0;
	local CascadeOffset_Top = 0;

	if(WIM_Data.winCascade.enabled) then
		CascadeOffset_Left = WIM_CascadeDirection[WIM_Data.winCascade.direction].left;
		CascadeOffset_Top = WIM_CascadeDirection[WIM_Data.winCascade.direction].top;
	end
	
	theWin:SetPoint(
		"TOPLEFT",
		"UIParent",
		"BOTTOMLEFT",
		(WIM_Data.winLoc.left + WIM_CascadeStep*CascadeOffset_Left), 
		(WIM_Data.winLoc.top + WIM_CascadeStep*CascadeOffset_Top)
	);
end

function WIM_PopOrNot(isNew)
	if(isNew == true and WIM_Data.popNew == true) then
		if(WIM_Data.popCombat and UnitAffectingCombat("player")) then
			return false;
		else
			return true;
		end
	elseif(WIM_Data.popNew == true and WIM_Data.popUpdate == true) then
		if(WIM_Data.popCombat and UnitAffectingCombat("player")) then
			return false;
		else
			return true;
		end
	else
		return false;
	end
end


function WIM_UpdateScrollBars(smf)
	local parentName = smf:GetParent():GetName();
	if(smf:AtTop()) then
		getglobal(parentName.."ScrollUp"):Disable();
	else
		getglobal(parentName.."ScrollUp"):Enable();
	end
	if(smf:AtBottom()) then
		getglobal(parentName.."ScrollDown"):Disable();
	else
		getglobal(parentName.."ScrollDown"):Enable();
	end
end

function WIM_isLinkURL(link)
	if (strsub(link, 1, 3) == "url") then
		return true;
	else
		return false;
	end
end

function WIM_DisplayURL(link)
	local theLink = "";
	if (string.len(link) > 4) and (string.sub(link,1,4) == "url:") then
		theLink = string.sub(link,5, string.len(link));
	end
	--show UI to show url so it can be copied
	if(theLink) then
		WIM_urlCopyUrlBox:SetText(theLink);
		WIM_urlCopy:Show();
		WIM_urlCopyUrlBox:HighlightText(0);
	end
end

function WIM_ConvertURLtoLinks(text)
	local preLink, midLink, postLink;
	preLink = "|Hurl:";
	midLink = "|h|cff"..WIM_RGBtoHex(WIM_Data.displayColors.webAddress.r, WIM_Data.displayColors.webAddress.g, WIM_Data.displayColors.webAddress.b);
	postLink = "|h|r";
	text = string.gsub(text, "(%a+://[%w_/%.%?%%=~&-]+)", preLink.."%1"..midLink.."%1"..postLink);
	return text;
end

function WIM_SlashCommand(msg)
	if(msg == "" or msg == nil) then
		WIM_Options:Show();
	elseif(msg == "reset") then
		WIM_Data = WIM_Data_DEFAULTS;
	elseif(msg == "clear history") then
		WIM_History = {};
	elseif(msg == "reset filters") then
		WIM_LoadDefaultFilters();
	elseif(msg == "history") then
		WIM_HistoryFrame:Show();
	elseif(msg == "help") then
		WIM_Help:Show();
	end
end


function WIM_Icon_Move(toDegree)
	WIM_Data.iconPosition = toDegree;
	WIM_Icon_UpdatePosition();
end

function WIM_Icon_UpdatePosition()
	if(WIM_Data.showMiniMap == false) then
		WIM_IconFrame:Hide();
	else
		if(WIM_Data.miniFreeMoving.enabled == false) then
			WIM_IconFrame:SetPoint(
				"TOPLEFT",
				"Minimap",
				"TOPLEFT",
				54 - (78 * cos(WIM_Data.iconPosition)),
				(78 * sin(WIM_Data.iconPosition)) - 55
			);
		end
		WIM_IconFrame:Show();
	end
end


function WIM_SetWindowProps(theWin)
	if(WIM_Data.showShortcutBar) then
		getglobal(theWin:GetName().."ShortcutFrame"):Show();
		local tHeight = WIM_Data.winSize.height;
		if(tHeight < 240) then
			tHeight = 240;
		end
		theWin:SetHeight(tHeight);
	else
		getglobal(theWin:GetName().."ShortcutFrame"):Hide();
		theWin:SetHeight(WIM_Data.winSize.height);
	end
	theWin:SetWidth(WIM_Data.winSize.width);
	theWin:SetScale(WIM_Data.windowSize);
	theWin:SetAlpha(WIM_Data.windowAlpha);
	getglobal(theWin:GetName().."ScrollingMessageFrame"):SetFont("Fonts\\FRIZQT__.TTF",WIM_Data.fontSize);
	getglobal(theWin:GetName().."ScrollingMessageFrame"):SetAlpha(1);
	getglobal(theWin:GetName().."MsgBox"):SetAlpha(1);
	getglobal(theWin:GetName().."ShortcutFrame"):SetAlpha(1);
end

function WIM_SetAllWindowProps()
	for key in WIM_Windows do
		WIM_SetWindowProps(getglobal(WIM_Windows[key].frame));
	end
end


function WIM_Icon_DropDown_Init(level)
	local dropdown;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	WIM_Icon_DropDown_InitButtons();
end

function WIM_Icon_ToggleDropDown()
	ToggleDropDownMenu(1, nil, WIM_Icon_DropDown);
	--local tMenu = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL);	
	--tMenu:ClearAllPoints();
	--tMenu:SetPoint("TOPRIGHT", "WIM_IconFrameButton", "BOTTOMLEFT", 0, 0);
	WIM_Icon_DropDown:SetWidth(DropDownList1Button1:GetWidth()+50);
	DropDownList1:SetScale(UIParent:GetScale());
end

function WIM_Icon_DropDown_InitButtons()
	local info = {};
	
	info = { };
	info.text = "Conversations";
	info.isTitle = 1;
	info.justifyH = "LEFT";
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	local tList = { };
	local tListActivity = { };
	local tCount = 0;
	for key in WIM_IconItems do
		table.insert(tListActivity, key);
		tCount = tCount + 1;
	end
	
	--[first get a sorted list of users by most frequent activity
	table.sort(tListActivity, WIM_Icon_SortByActivity);
	--[account for only the allowable amount of active users
	for i=1,table.getn(tListActivity) do
		if(i <= WIM_MaxMenuCount) then
			table.insert(tList, tListActivity[i]);
		end
	end
	
	WIM_NewMessageCount = 0;
	
	if(tCount == 0) then
		info = { };
		info.justifyH = "LEFT"
		info.text = " - None -";
		info.notClickable = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	else
		if(WIM_Data.sortAlpha) then
			table.sort(tList);
		end
		WIM_NewMessageFlag = false;
		for i=1, table.getn(tList) do
			if( WIM_Windows[tList[i]].newMSG and WIM_Windows[tList[i]].is_visible == false) then
				WIM_IconItems[tList[i]].textR = 77/255;
				WIM_IconItems[tList[i]].textG = 135/255;
				WIM_IconItems[tList[i]].textB = 224/255;
				WIM_NewMessageFlag = true;
				WIM_NewMessageCount = WIM_NewMessageCount + 1;
			else
				WIM_IconItems[tList[i]].textR = 255;
				WIM_IconItems[tList[i]].textG = 255;
				WIM_IconItems[tList[i]].textB = 255;
			end
			UIDropDownMenu_AddButton(WIM_IconItems[tList[i]]);
		end
	end
	if(WIM_Data.enableWIM == true) then
		if(WIM_NewMessageFlag == true) then
			WIM_IconFrameButton:SetNormalTexture("Interface\\AddOns\\WIM\\Images\\miniEnabled");
		else
			WIM_IconFrameButton:SetNormalTexture("Interface\\AddOns\\WIM\\Images\\miniDisabled");
		end
	else
		--show wim disabled icon
		WIM_IconFrameButton:SetNormalTexture("Interface\\AddOns\\WIM\\Images\\miniOff");
	end
end


function WIM_Icon_AddUser(theUser)
	UIDROPDOWNMENU_INIT_MENU = "WIM_Options_DropDown";
	UIDROPDOWNMENU_OPEN_MENU = UIDROPDOWNMENU_INIT_MENU;
	local info = { };
	info.text = theUser;
	info.justifyH = "LEFT"
	info.isTitle = nil;
	info.notCheckable = 1;
	info.value = WIM_Windows[theUser].frame;
	info.func = WIM_Icon_PlayerClick;
	WIM_IconItems[theUser] = info;
	table.sort(WIM_IconItems);
	WIM_Icon_DropDown_Update();
end

function WIM_Icon_PlayerClick()
	if(this.value ~= nil) then
		getglobal(this.value):Show();
		--[local user = getglobal(this.value.."From"):GetText();
		local user = getglobal(this.value).theUser;
		WIM_Windows[user].newMSG = false;
		WIM_Windows[user].is_visible = true;
		WIM_Icon_DropDown_Update();
	end
end

function WIM_Icon_DropDown_Update()
	UIDropDownMenu_Initialize(WIM_Icon_DropDown, WIM_Icon_DropDown_Init, "MENU");
end

function WIM_Icon_OnUpdate(elapsedTime)
	if(WIM_NewMessageFlag == false) then
		this.TimeSinceLastUpdate = 0;
		if(WIM_Icon_NewMessageFlash:IsVisible()) then
			WIM_Icon_NewMessageFlash:Hide();
		end
		return;
	end

	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsedTime; 	

	while (this.TimeSinceLastUpdate > WIM_Icon_UpdateInterval) do
		if(WIM_Icon_NewMessageFlash:IsVisible()) then
			WIM_Icon_NewMessageFlash:Hide();
		else
			WIM_Icon_NewMessageFlash:Show();
		end
		this.TimeSinceLastUpdate = this.TimeSinceLastUpdate - WIM_Icon_UpdateInterval;
	end
end

function WIM_UpdateCascadeStep()
		WIM_CascadeStep = WIM_CascadeStep + 1;
		if(WIM_CascadeStep > 10) then
			WIM_CascadeStep = 0;
		end
end

function WIM_PlaySoundWisp()
	if(WIM_Data.playSoundWisp == true) then
		PlaySoundFile("Interface\\AddOns\\WIM\\Sounds\\wisp.wav");
	end
end

function WIM_Icon_SortByActivity(user1, user2)
	if(WIM_Windows[user1].last_msg > WIM_Windows[user2].last_msg) then
		return true;
	else
		return false;
	end
end

function WIM_RGBtoHex(r,g,b)
	return string.format ("%.2x%.2x%.2x",r*255,g*255,b*255);
end

function WIM_Icon_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	GameTooltip:SetText("WIM v"..WIM_VERSION.."              ");
	GameTooltip:AddDoubleLine("Conversation Menu", "Left-Click", 1,1,1,1,1,1);
	GameTooltip:AddDoubleLine("Show New Messages", "Right-Click", 1,1,1,1,1,1);
	GameTooltip:AddDoubleLine("WIM Options", "/wim", 1,1,1,1,1,1);
end

function WIM_ShowNewMessages()
	for key in WIM_Windows do
		if(WIM_Windows[key].newMSG == true) then
			getglobal(WIM_Windows[key].frame):Show();
			WIM_Windows[key].newMSG = false;
		end
	end
	WIM_Icon_DropDown_Update();
end


function WIM_SendWho(name)
	WIM_Windows[name].waiting_who = true;
	SetWhoToUI(1);
	SendWho("\""..name.."\"");
end


function WIM_ShowAll()
	for key in WIM_Windows do
		getglobal(WIM_Windows[key].frame):Show();
	end
end

function WIM_CloseAllConvos()
	for key in WIM_Windows do
		WIM_CloseConvo(key);
	end
end

function WIM_CloseConvo(theUser)
	if(WIM_Windows[theUser] == nil) then return; end; --[ fail silently
	
	getglobal(WIM_Windows[theUser].frame):Hide();
	getglobal(WIM_Windows[theUser].frame.."ScrollingMessageFrame"):Clear();
	getglobal(WIM_Windows[theUser].frame.."ClassIcon"):SetTexture("Interface\\AddOns\\WIM\\Images\\classBLANK");
	getglobal(WIM_Windows[theUser].frame.."CharacterDetails"):SetText("");
	WIM_Windows[theUser] = nil;
	WIM_IconItems[theUser] = nil;
	
	WIM_Icon_DropDown_Update();
end

function WIM_InitClassProps()
	WIM_ClassIcons[WIM_LOCALIZED_DRUID] 	= "Interface\\AddOns\\WIM\\Images\\classDRUID";
	WIM_ClassIcons[WIM_LOCALIZED_HUNTER] 	= "Interface\\AddOns\\WIM\\Images\\classHUNTER";
	WIM_ClassIcons[WIM_LOCALIZED_MAGE]	 	= "Interface\\AddOns\\WIM\\Images\\classMAGE";
	WIM_ClassIcons[WIM_LOCALIZED_PALADIN] 	= "Interface\\AddOns\\WIM\\Images\\classPALADIN";
	WIM_ClassIcons[WIM_LOCALIZED_PRIEST] 	= "Interface\\AddOns\\WIM\\Images\\classPRIEST";
	WIM_ClassIcons[WIM_LOCALIZED_ROGUE] 	= "Interface\\AddOns\\WIM\\Images\\classROGUE";
	WIM_ClassIcons[WIM_LOCALIZED_SHAMAN] 	= "Interface\\AddOns\\WIM\\Images\\classSHAMAN";
	WIM_ClassIcons[WIM_LOCALIZED_WARLOCK] 	= "Interface\\AddOns\\WIM\\Images\\classWARLOCK";
	WIM_ClassIcons[WIM_LOCALIZED_WARRIOR] 	= "Interface\\AddOns\\WIM\\Images\\classWARRIOR";
	
	WIM_ClassColors[WIM_LOCALIZED_DRUID]	= "ff7d0a";
	WIM_ClassColors[WIM_LOCALIZED_HUNTER]	= "abd473";
	WIM_ClassColors[WIM_LOCALIZED_MAGE]		= "69ccf0";
	WIM_ClassColors[WIM_LOCALIZED_PALADIN]	= "f58cba";
	WIM_ClassColors[WIM_LOCALIZED_PRIEST]	= "ffffff";
	WIM_ClassColors[WIM_LOCALIZED_ROGUE]	= "fff569";
	WIM_ClassColors[WIM_LOCALIZED_SHAMAN]	= "f58cba";
	WIM_ClassColors[WIM_LOCALIZED_WARLOCK]	= "9482ca";
	WIM_ClassColors[WIM_LOCALIZED_WARRIOR]	= "c79c6e";
end

function WIM_UserWithClassColor(theUser)
	if(WIM_Windows[theUser].class == "") then
		return theUser;
	else
		if(WIM_ClassColors[WIM_Windows[theUser].class]) then
			return "|cff"..WIM_ClassColors[WIM_Windows[theUser].class]..WIM_GetAlias(theUser);
		else
			return WIM_GetAlias(theUser);
		end
	end
end

function WIM_SetWhoInfo(theUser)
	local classIcon = getglobal(WIM_Windows[theUser].frame.."ClassIcon");
	if(WIM_Data.characterInfo.classIcon and WIM_ClassIcons[WIM_Windows[theUser].class]) then
		classIcon:SetTexture(WIM_ClassIcons[WIM_Windows[theUser].class]);
	else
		classIcon:SetTexture("Interface\\AddOns\\WIM\\Images\\classBLANK");
	end
	if(WIM_Data.characterInfo.classColor) then	
		getglobal(WIM_Windows[theUser].frame.."From"):SetText(WIM_UserWithClassColor(theUser));
	end
	if(WIM_Data.characterInfo.details) then	
		local tGuild = "";
		if(WIM_Windows[theUser].guild ~= "") then
			tGuild = "<"..WIM_Windows[theUser].guild.."> ";
		end
		getglobal(WIM_Windows[theUser].frame.."CharacterDetails"):SetText("|cffffffff"..tGuild..WIM_Windows[theUser].level.." "..WIM_Windows[theUser].race.." "..WIM_Windows[theUser].class.."|r");
	end
end

function WIM_getTimeStamp()
	if(WIM_Data.showTimeStamps) then
		return "|cff"..WIM_RGBtoHex(WIM_Data.displayColors.sysMsg.r, WIM_Data.displayColors.sysMsg.g, WIM_Data.displayColors.sysMsg.b)..date("%H:%M").."|r ";
	else
		return "";
	end
end

function WIM_Bindings_EnableWIM()
	WIM_SetWIM_Enabled(not WIM_Data.enableWIM);
end

function WIM_SetWIM_Enabled(YesOrNo)
	WIM_Data.enableWIM = YesOrNo
	WIM_Icon_DropDown_Update();
end

function WIM_LoadShortcutFrame()
	local tButtons = {
		{
			icon = "Interface\\Icons\\Ability_Hunter_AimedShot",
			cmd		= "target",
			tooltip = "Target"
		},
		{
			icon = "Interface\\Icons\\Spell_Holy_BlessingOfStrength",
			cmd		= "invite",
			tooltip = "Invite"
		},
		{
			icon = "Interface\\Icons\\INV_Misc_Bag_10_Blue",
			cmd		= "trade",
			tooltip = "Trade"
		},
		{
			icon = "Interface\\Icons\\INV_Helmet_44",
			cmd		= "inspect",
			tooltip = "Inspect"
		},
		{
			icon = "Interface\\Icons\\Ability_Physical_Taunt",
			cmd		= "ignore",
			tooltip = "Ignore"
		},
	};
	for i=1,5 do
		getglobal(this:GetName().."ShortcutFrameButton"..i.."Icon"):SetTexture(tButtons[i].icon);
		getglobal(this:GetName().."ShortcutFrameButton"..i).cmd = tButtons[i].cmd;
		getglobal(this:GetName().."ShortcutFrameButton"..i).tooltip = tButtons[i].tooltip;
	end
	getglobal(this:GetName().."ShortcutFrame"):SetScale(.75);
end

function WIM_ShorcutButton_Clicked()
	local cmd = this.cmd;
	local theUser = this:GetParent():GetParent().theUser;
	if(cmd == "target") then
		TargetByName(theUser, true);
	elseif(cmd == "invite") then
		InviteByName(theUser);
	elseif(cmd == "trade") then
		TargetByName(theUser, true);
		InitiateTrade("target");
	elseif(cmd == "inspect") then
		TargetByName(theUser, true);
		InspectUnit("target");
	elseif(cmd == "ignore") then
		getglobal(this:GetParent():GetParent():GetName().."IgnoreConfirm"):Show();
	end
end

function WIM_GetAlias(theUser, nameOnly)
	if(WIM_Data.enableAlias and WIM_Alias[theUser] ~= nil) then
		if(WIM_Data.aliasAsComment) then
			if(nameOnly) then
				return theUser;
			else
				return theUser.." |cffffffff- "..WIM_Alias[theUser].."|r";
			end
		else
			return WIM_Alias[theUser];
		end
	else
		return theUser;
	end
end


function WIM_FilterResult(theMSG)
	if(WIM_Data.enableFilter) then
		local key, a, b;
		for key in WIM_Filters do
			if(strfind(strlower(theMSG), strlower(key)) ~= nil) then
				if(WIM_Filters[key] == "Ignore") then
					return 1;
				elseif(WIM_Filters[key] == "Block") then
					return 2;
				end
			end
		end
		return 0;
	else
		return 0;
	end
end

function WIM_CanRecordUser(theUser)
	if(WIM_Data.historySettings.recordEveryone) then
		return true;
	else
		if(WIM_Data.historySettings.recordFriends and WIM_FriendList[theUser]) then
			return true;
		elseif(WIM_Data.historySettings.recordGuild and WIM_GuildList[theUser]) then
			return true;
		end
	end
	return false;
end

function WIM_AddToHistory(theUser, userFrom, theMessage, isMsgIn)
	local tmpEntry = {};
	if(WIM_Data.enableHistory) then --[if history is enabled
		if(WIM_CanRecordUser(theUser)) then --[if record user
			getglobal(WIM_Windows[theUser].frame.."HistoryButton"):Show();
			tmpEntry["stamp"] = time();
			tmpEntry["date"] = date("%m/%d/%y");
			tmpEntry["time"] = date("%H:%M");
			tmpEntry["msg"] = WIM_ConvertURLtoLinks(theMessage);
			tmpEntry["from"] = userFrom;
			if(isMsgIn) then
				tmpEntry["type"] = 2;
			else
				tmpEntry["type"] = 1;
			end
			if(WIM_History[theUser] == nil) then
				WIM_History[theUser] = {};
			end
			table.insert(WIM_History[theUser], tmpEntry);
			
			if(WIM_Data.historySettings.maxMsg.enabled) then
				local tOver = table.getn(WIM_History[theUser]) - WIM_Data.historySettings.maxMsg.count;
				if(tOver > 0) then
					for i = 1, tOver do 
						table.remove(WIM_History[theUser], 1);
					end
				end
			end
			if(WIM_Options:IsVisible()) then
				WIM_HistoryScrollBar_Update();
			end
		end
	end
end

function WIM_SortHistory(a, b)
	if(a.stamp < b.stamp) then
		return true;
	else
		return false;
	end
end

function WIM_DisplayHistory(theUser)
	if(WIM_History[theUser] and WIM_Data.enableHistory and WIM_Data.historySettings.popWin.enabled) then
		table.sort(WIM_History[theUser], WIM_SortHistory);
		for i=table.getn(WIM_History[theUser])-WIM_Data.historySettings.popWin.count-1, table.getn(WIM_History[theUser]) do 
			if(WIM_History[theUser][i]) then
				--WIM_GetAlias
				msg = "|Hplayer:"..WIM_History[theUser][i].from.."|h["..WIM_GetAlias(WIM_History[theUser][i].from, true).."]|h: "..WIM_History[theUser][i].msg;
				if(WIM_Data.showTimeStamps) then
					msg = WIM_History[theUser][i].time.." "..msg;
				end
				if(WIM_History[theUser][i].type == 1) then
					getglobal("WIM_msgFrame"..theUser.."ScrollingMessageFrame"):AddMessage(msg, WIM_Data.historySettings.colorIn.r, WIM_Data.historySettings.colorIn.g, WIM_Data.historySettings.colorIn.b);
				elseif(WIM_History[theUser][i].type == 2) then
					getglobal("WIM_msgFrame"..theUser.."ScrollingMessageFrame"):AddMessage(msg, WIM_Data.historySettings.colorOut.r, WIM_Data.historySettings.colorOut.g, WIM_Data.historySettings.colorOut.b);
				end
			end
		end
	end
	--getglobal("WIM_msgFrame"..theUser.."ScrollingMessageFrame"):AddMessage(" ");
end

function WIM_LoadDefaultFilters()
	WIM_Filters = {};
	WIM_Filters["^LVBM"] 					= "Ignore";
	WIM_Filters["^YOU ARE BEING WATCHED!"] 	= "Ignore";
	WIM_Filters["^YOU ARE MARKED!"] 		= "Ignore";
	WIM_Filters["^YOU ARE CURSED!"] 		= "Ignore";
	WIM_Filters["^YOU HAVE THE PLAGUE!"] 	= "Ignore";
	WIM_Filters["^YOU ARE BURNING!"] 		= "Ignore";
	WIM_Filters["^YOU ARE THE BOMB!"] 		= "Ignore";
	WIM_Filters["VOLATILE INFECTION"] 		= "Ignore";
	WIM_Filters["^<GA"]						= "Ignore";
	
	WIM_FilteringScrollBar_Update();
end

function WIM_LoadGuildList()
	WIM_GuildList = {};
	if(IsInGuild()) then
		for i=1, GetNumGuildMembers(true) do 
			local name, junk = GetGuildRosterInfo(i);
			WIM_GuildList[name] = "1"; --[set place holder for quick lookup
		end
	end
end

function WIM_LoadFriendList()
	WIM_FriendList = {};
	for i=1, GetNumFriends() do 
		local name, junk = GetFriendInfo(i);
		if(name) then
			WIM_FriendList[name] = "1"; --[set place holder for quick lookup
		end
	end
end

function WIM_HistoryPurge()
	if(WIM_Data.historySettings.autoDelete.enabled) then
		local delCount = 0;
		local eldestTime = time() - (60 * 60 * 24 * WIM_Data.historySettings.autoDelete.days);
		for key in WIM_History do
			if(WIM_History[key][1]) then
				while(WIM_History[key][1].stamp < eldestTime) do
					table.remove(WIM_History[key], 1);
					delCount = delCount + 1;
					if(table.getn(WIM_History[key]) == 0) then
						WIM_History[key] = nil;
						break;
					end
				end
			end
		end
		if(delCount > 0) then
			DEFAULT_CHAT_FRAME:AddMessage("[WIM]: Purged "..delCount.." out-dated messages from history.");
		end
	end
end

function WIM_ToggleWindow_OnUpdate(elapsedTime)

	WIM_ToggleWindow_Timer = WIM_ToggleWindow_Timer + elapsedTime; 	

	while (WIM_ToggleWindow_Timer > 1) do
		WIM_ToggleWindow:Hide();
		WIM_ToggleWindow_Timer = 0;
	end
end

function WIM_RecentListAdd(theUser)
	local found = 0;
	for i=1, table.getn(WIM_RecentList) do 
		if(WIM_RecentList[i] == theUser) then
			found = 1;
			break;
		end
	end
	
	if(found > 0) then
		table.remove(WIM_RecentList, found);
	end
	table.insert(WIM_RecentList, 1, theUser);
end

function WIM_ToggleWindow_Toggle()
	if(table.getn(WIM_RecentList) == 0) then
		return;
	end
	
	if(WIM_RecentList[WIM_ToggleWindow_Index] == nil) then
		WIM_ToggleWindow_Index = 1;
	end
	
	WIM_ToggleWindowUser:SetText(WIM_GetAlias(WIM_RecentList[WIM_ToggleWindow_Index], true));
	WIM_ToggleWindow.theUser = WIM_RecentList[WIM_ToggleWindow_Index];
	WIM_ToggleWindowCount:SetText("Recent Conversation "..WIM_ToggleWindow_Index.." of "..table.getn(WIM_RecentList));
	if(WIM_Windows[WIM_RecentList[WIM_ToggleWindow_Index]]) then
		if(WIM_Windows[WIM_RecentList[WIM_ToggleWindow_Index]].newMSG) then
			WIM_ToggleWindowStatus:SetText("New message!");
			WIM_ToggleWindowIconNew:Show();
			WIM_ToggleWindowIconRead:Hide();
		else
			WIM_ToggleWindowStatus:SetText("No new messages.");
			WIM_ToggleWindowIconRead:Show();
			WIM_ToggleWindowIconNew:Hide();
		end
	else
		WIM_ToggleWindowStatus:SetText("Conversation closed.");
		WIM_ToggleWindowIconRead:Show();
		WIM_ToggleWindowIconNew:Hide();
	end
	WIM_ToggleWindow_Timer = 0;
	WIM_ToggleWindow:Show();
	WIM_ToggleWindow_Index = WIM_ToggleWindow_Index + 1;
end


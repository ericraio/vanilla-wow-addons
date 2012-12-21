-- Locally bound frame cache
local frameCache = CT_RA_Cache;

-- CT_RA_CustomOnClickFunction

-- Set this variable (CT_RA_CustomOnClickFunction) in your own mod to your function to handle OnClicks.
-- Two arguments are passed, button and raidid.
-- Button is a string that refers to the mouse button pressed, "LeftButton" or "RightButton".
-- Raidid is a string with the unit id, such as "raid1".

-- Example: function MyFunction(button, raidid) doStuff(); end
-- CT_RA_CustomOnClickFunction = MyFunction;

-- Note! If the function returns true, the default CTRA behaviour will not be called.
-- If it returns false or nil, the default behaviour will be called.

-- Variables
CHAT_MSG_CTRAID = "CTRaid";
CT_RA_Squelch = 0;
CT_RA_Comm_MessageQueue = { };
CT_RA_Level = 0;
CT_RA_Stats = {
	{
		{ }
	}
};
CT_RA_PTargets = { };
CT_RA_BuffsToCure = { };
CT_RA_BuffsToRecast = { };
CT_RA_RaidParticipant = nil; -- Used to see what player participated in the raid on this account

CT_RA_Auras = { 
	["buffs"] = { },
	["debuffs"] = { }
};
CT_RA_LastSend = nil;
CT_RA_ClassPositions = {
	[CT_RA_WARRIOR] = 1,
	[CT_RA_DRUID] = 2,
	[CT_RA_MAGE] = 3,
	[CT_RA_WARLOCK] = 4,
	[CT_RA_ROGUE] = 5,
	[CT_RA_HUNTER] = 6,
	[CT_RA_PRIEST] = 7,
	[CT_RA_PALADIN] = 8,
	[CT_RA_SHAMAN] = 8
};

CT_RA_Emergency_RaidHealth = { };
CT_RA_Emergency_Units = { };

CT_RA_LastSent = { };
CT_RA_BuffTimeLeft = { };
CT_RA_ResFrame_Options = { };
CT_RA_CurrPlayerName = "";

CT_RA_NumRaidMembers = 0;

ChatTypeGroup["CTRAID"] = {
	"CHAT_MSG_CTRAID"
};
ChatTypeInfo["CTRAID"] = { sticky = 0 };
tinsert(OtherMenuChatTypeGroups, "CTRAID");
CHAT_CTRAID_GET = "";
CT_RA_ChatInfo = {
	["Default"] = {
		["r"] = 1.0,
		["g"] = 0.5,
		["b"] = 0,
		["show"] = {
			"ChatFrame1"
		}
	}
};

CT_oldFCF_Tab_OnClick = FCF_Tab_OnClick;
function CT_newFCF_Tab_OnClick(button)
	CT_oldFCF_Tab_OnClick(button);
	if ( button == "RightButton" ) then
		local frameName = "ChatFrame" .. this:GetID();
		local frame = getglobal(frameName);
		local info = CT_RA_ChatInfo["Default"];
		if ( CT_RA_ChatInfo[UnitName("player")] ) then
			info = CT_RA_ChatInfo[UnitName("player")];
		end
		for k, v in info["show"] do
			if ( v == frameName ) then
				local y = 1;
				while ( frame.messageTypeList[y] ) do
					y = y + 1;
				end
				frame.messageTypeList[y] = "CTRAID";
			end
		end
	end
end
FCF_Tab_OnClick = CT_newFCF_Tab_OnClick;

CT_oldFCF_SetChatTypeColor = FCF_SetChatTypeColor;
function CT_newFCF_SetChatTypeColor()
	CT_oldFCF_SetChatTypeColor();
	if ( UIDROPDOWNMENU_MENU_VALUE == "CTRAID" ) then
		local r,g,b = ColorPickerFrame:GetColorRGB();
		local chatInfo = CT_RA_ChatInfo[UnitName("player")];
		local chatTypeInfo = ChatTypeInfo["CTRAID"];
		if ( not chatInfo ) then
			CT_RA_ChatInfo[UnitName("player")] = CT_RA_ChatInfo["Default"];
		end
		chatInfo.r = r;
		chatInfo.g = g;
		chatInfo.b = b;
		chatTypeInfo.r = r;
		chatTypeInfo.g = g;
		chatTypeInfo.b = b;
	end
end
FCF_SetChatTypeColor = CT_newFCF_SetChatTypeColor;

CT_oldFCF_CancelFontColorSettings = FCF_CancelFontColorSettings;
function CT_newFCF_CancelFontColorSettings(prev)
	CT_oldFCF_CancelFontColorSettings(prev);
	if ( prev.r and UIDROPDOWNMENU_MENU_VALUE == "CTRAID" ) then
		local chatInfo = CT_RA_ChatInfo[UnitName("player")];
		local chatTypeInfo = ChatTypeInfo["CTRAID"];
		if ( not chatInfo ) then
			CT_RA_ChatInfo[UnitName("player")] = CT_RA_ChatInfo["Default"];
		end
		chatInfo.r = prev.r;
		chatInfo.g = prev.g;
		chatInfo.b = prev.b;
		chatTypeInfo.r = prev.r;
		chatTypeInfo.g = prev.g;
		chatTypeInfo.b = prev.b;
	end
end
FCF_CancelFontColorSettings = CT_newFCF_CancelFontColorSettings;
CT_oldFCFMessageTypeDropDown_OnClick = FCFMessageTypeDropDown_OnClick;
function CT_newFCFMessageTypeDropDown_OnClick()
	CT_oldFCFMessageTypeDropDown_OnClick();
	if ( not CT_RA_ChatInfo[UnitName("player")] ) then
		CT_RA_ChatInfo[UnitName("player")] = CT_RA_ChatInfo["Default"];
	end
	if ( this.value == "CTRAID" ) then
		local chatInfo = CT_RA_ChatInfo[UnitName("player")];
		local chatTypeInfo = ChatTypeInfo["CTRAID"];
		local currChatFrame = FCF_GetCurrentChatFrame():GetName();
		if ( UIDropDownMenuButton_GetChecked() ) then
			for k, v in chatInfo["show"] do
				if ( v == currChatFrame ) then
					chatInfo["show"][k] = nil;
					break;
				end
			end
		else
			tinsert(chatInfo["show"], currChatFrame);
		end
	end
end
FCFMessageTypeDropDown_OnClick = CT_newFCFMessageTypeDropDown_OnClick;

function CT_RA_ShowHideWindows()
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( tempOptions["HiddenGroups"] ) then
		tempOptions["ShowGroups"] = tempOptions["HiddenGroups"];
		tempOptions["HiddenGroups"] = nil;

		local num = 0;
		for k, v in tempOptions["ShowGroups"] do
			num = num + 1;
			getglobal("CT_RAOptionsGroupCB" .. k):SetChecked(1);
		end
		if ( num > 0 ) then
			CT_RACheckAllGroups:SetChecked(1);
		else
			CT_RACheckAllGroups:SetChecked(nil);
		end
	else
		tempOptions["HiddenGroups"] = tempOptions["ShowGroups"];
		tempOptions["ShowGroups"] = { };
		for i = 1, 8, 1 do
			getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(nil);
		end
		CT_RACheckAllGroups:SetChecked(nil);
	end
	CT_RA_UpdateRaidGroup(0);
end

function CT_RA_SetGroup()
	local tempOptions = CT_RAMenu_Options["temp"];
	tempOptions["ShowGroups"][this.id] = this:GetChecked();
	local num = 0;
	for k, v in tempOptions["ShowGroups"] do
		num = num + 1;
	end
	if ( num > 0 ) then
		CT_RACheckAllGroups:SetChecked(1);
	else
		CT_RACheckAllGroups:SetChecked(nil);
	end
	CT_RA_UpdateRaidGroup(0);
end

function CT_RA_CheckAllGroups()
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( not tempOptions["ShowGroups"] ) then tempOptions["ShowGroups"] = { }; end
	for i = 1, 8, 1 do
		tempOptions["ShowGroups"][i] = this:GetChecked();
		getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(this:GetChecked());
	end
	CT_RA_UpdateRaidGroup(0);
end

function CT_RA_ParseEvent(event)
	local nick, sMsg, msg;
	if ( event == "CHAT_MSG_ADDON" ) then
		nick, sMsg = arg4, arg2;
	else
		nick, sMsg = arg2, arg1;
	end
	local numRaidMembers = GetNumRaidMembers();
	local name, rank, subgroup, level, class, fileName, zone, online, isDead, raidid, frame;
	for i = 1, numRaidMembers, 1 do
		if ( UnitName("raid" .. i) == nick ) then
			raidid = i;
			name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			frame = getglobal("CT_RAMember"..i);
			break;
		end
	end
	
	local playerName = UnitName("player");
	local unitStats = CT_RA_Stats[nick];
	local ctraChannel = CT_RA_Channel;
	
	if ( name and not unitStats ) then
		CT_RA_Stats[nick] = {
			["Buffs"] = { },
			["Debuffs"] = { },
			["Position"] = { }
		};
		unitStats = CT_RA_Stats[nick];
	end
	
	if ( ( event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" ) and type(sMsg) == "string" ) then
		if ( frame ) then
			-- We have a valid frame
			msg = gsub(sMsg, "%%", "%%%%");
			
			if ( stats and raidid ) then
				if ( arg6 and not unitStats[arg6]  and ( arg6 == "AFK" or arg6 == "DND" ) ) then
					unitStats[arg6] = { 1, 0 };
					CT_RA_UpdateUnitDead(frame);
				elseif ( arg2 == name and ( not arg6 or arg6 == "" ) and ( unitStats["DND"] or unitStats["AFK"] ) ) then
					unitStats["DND"] = nil;
					unitStats["AFK"] = nil;
					CT_RA_UpdateUnitDead(frame);
				end
			end
			if ( rank and rank < 1 and CT_RA_Squelch and CT_RA_Squelch > 0 ) then
				if ( CT_RA_Level >= 1 and CT_RA_IsSendingWithVersion(1.468) ) then
					SendChatMessage("<CTRaid> Quiet mode is enabled in the raid. Please be quiet. " .. floor(CT_RA_Squelch) .. " seconds remaining.", "WHISPER", nil, name);
				end
				return;
			end
			
			if ( rank and rank >= 1 and string.find(sMsg, "<CTRaid> Disbanding raid on request by (.+)") ) then
				LeaveParty();
				return;
			end
			if ( rank >= 1 ) then
				if ( name ~= playerName and sMsg == "<CTRaid> Quiet mode is over." ) then
					if ( CT_RA_Squelch > 0 ) then
						CT_RA_Squelch = 0;
						CT_RA_Print("<CTRaid> Quiet mode has been disabled by " .. name .. ".", 1, 0.5, 0);
					end
				elseif ( name ~= playerName and sMsg == "<CTRaid> Quiet mode, no talking." ) then
					if ( CT_RA_Squelch == 0 ) then
						CT_RA_Squelch = 5*60;
						CT_RA_Print("<CTRaid> Quiet Mode has been enabled by " .. name .. ".", 1, 0.5, 0);
					end
				end
				return;
			end
		end
	elseif ( event == "CHAT_MSG_WHISPER" and type(sMsg) == "string" ) then
		local tempOptions = CT_RAMenu_Options["temp"];
		if ( tempOptions["KeyWord"] and strlower(sMsg) == strlower(tempOptions["KeyWord"]) ) then
			local temp = arg2;
			if ( numRaidMembers == 40 or ( GetNumPartyMembers() == 4 and numRaidMembers == 0 ) ) then
				CT_RA_Print("<CTRaid> Player '|c00FFFFFF" .. temp .. "|r' requested invite, group is currently full.", 1, 0.5, 0);
				SendChatMessage("<CTRaid> The group is currently full.", "WHISPER", nil, temp);
			else
				CT_RA_Print("<CTRaid> Invited '|c00FFFFFF" .. temp .. "|r' by Keyword Inviting.", 1, 0.5, 0);
				InviteByName(temp);
				CT_RA_UpdateFrame.lastInvite = 1;
				CT_RA_UpdateFrame.inviteName = temp;
			end
		else
			local _, _, secRem = string.find(sMsg, "<CTRaid> Quiet mode is enabled in the raid%. Please be quiet%. (%d+) seconds remaining%.");
			if ( secRem and CT_RA_Squelch == 0 ) then
				if ( rank >= 1 ) then
					CT_RA_Squelch = tonumber(secRem);
					CT_RA_Print("<CTRaid> Quiet Mode has been enabled for " .. secRem .. " seconds by " .. name .. ".", 1, 0.5, 0);
				end
			end
		end
	elseif ( event == "CHAT_MSG_WHISPER_INFORM" ) then
		if ( arg1 == "<CTRaid> You are already grouped." ) then
			CT_RA_Print("<CTRaid> Informed '|c00FFFFFF" .. arg2 .. "|r' that he or she is already grouped.", 1, 0.5, 0);
		end
	elseif ( event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH" ) then
		if ( not CT_RAMenu_Options["temp"]["HideTankNotifications"] ) then
			local _, _, name = string.find(sMsg, CT_RA_TANKHASDIEDREGEXP);
			if ( name ) then
				for k, v in CT_RA_MainTanks do
					if ( v == name ) then
						CT_RA_WarningFrame:AddMessage("TANK " .. name .. " HAS DIED!", 1, 0, 0, 1, UIERRORS_HOLD_TIME);
						PlaySoundFile("Sound\\interface\\igQuestFailed.wav");
						break;
					end
				end
			end
		end
	elseif ( strsub(event, 1, 15) == "CHAT_MSG_SYSTEM" and type(sMsg) == "string" ) then
		local useless, useless, plr = string.find(sMsg, CT_RA_HASLEFTRAIDREGEXP);
		if ( CT_RA_RaidParticipant and plr and plr ~= CT_RA_RaidParticipant ) then
			CT_RA_CurrPositions[plr] = nil;
			CT_RA_Stats[plr] = nil;
			for k, v in CT_RA_MainTanks do
				if ( v == plr ) then
					CT_RA_MainTanks[k] = nil;
					CT_RATarget.MainTanks[k] = nil;
					break;
				end
			end
		elseif ( string.find(sMsg, CT_RA_HASJOINEDRAIDREGEXP) ) then
			if ( CT_RA_Level >= 2 ) then
				local useless, useless, plr = string.find(sMsg, CT_RA_HASJOINEDRAIDREGEXP);
				if ( plr and CT_RATab_AutoPromotions[plr] ) then
					PromoteToAssistant(plr);
					CT_RA_Print("<CTRaid> Auto-Promoted |c00FFFFFF" .. plr .. "|r.", 1, 0.5, 0);
				end
			end
		elseif ( string.find(sMsg, CT_RA_AFKMESSAGE) or sMsg == MARKED_AFK ) then
			local _, _, msg = string.find(sMsg, CT_RA_AFKMESSAGE);
			if ( msg and msg ~= DEFAULT_AFK_MESSAGE ) then
				if ( strlen(msg) > 20 ) then
					msg = strsub(msg, 1, 20) .. "...";
				end
				CT_RA_AddMessage("AFK " .. msg);
			else
				CT_RA_AddMessage("AFK");
			end
		elseif ( string.find(sMsg, CT_RA_DNDMESSAGE) ) then
			local _, _, msg = string.find(sMsg, CT_RA_DNDMESSAGE);
			if ( msg and msg ~= DEFAULT_DND_MESSAGE ) then
				if ( strlen(msg) > 20 ) then
					msg = strsub(msg, 1, 20) .. "...";
				end
				CT_RA_AddMessage("DND " .. msg);
			else
				CT_RA_AddMessage("DND");
			end
		elseif ( sMsg == CLEARED_AFK ) then
			CT_RA_AddMessage("UNAFK");
		elseif ( sMsg == CLEARED_DND ) then
			CT_RA_AddMessage("UNDND");
		end

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA" and arg3 == "RAID" ) then
		if ( frame ) then
			-- Unit is in raid
			local eventtype = strsub(event, 10);
			local info = ChatTypeInfo[eventtype];
			event = "CHAT_MSG_CTRAID";
			if ( arg6 and not unitStats[arg6] and ( arg6 == "AFK" or arg6 == "DND" ) ) then
				unitStats[arg6] = { 1, 0 };
				CT_RA_UpdateUnitDead(frame);
			elseif ( ( not arg6 or arg6 == "" ) and ( unitStats["DND"] or unitStats["AFK"] ) ) then
				unitStats["DND"] = nil;
				unitStats["AFK"] = nil;
				CT_RA_UpdateUnitDead(frame);
			end
			if ( not sMsg ) then
				return;
			end
			local msg = string.gsub(sMsg, "%$", "s");
			msg = string.gsub(msg, "§", "S");
			if ( strsub(msg, strlen(msg)-7) == " ...hic!") then
				msg = strsub(msg, 1, strlen(msg)-8);
			end
			local tempUpdate, message;
			if ( string.find(msg, "#") ) then
				local arr = CT_RA_Split(msg, "#");
				for k, v in arr do
					tempUpdate, message = CT_RA_ParseMessage(name, v);
					if ( message ) then
						CT_RA_Print(message, 1, 0.5, 0);
					end
					if ( tempUpdate ) then
						for k, v in tempUpdate do
							tinsert(update, v);
						end
					end
				end
			else
				tempUpdate, message = CT_RA_ParseMessage(name, msg);
				if ( message ) then
					CT_RA_Print(message, 1, 0.5, 0);
				end
				if ( tempUpdate ) then
					for k, v in tempUpdate do
						tinsert(update, v);
					end
				end
			end
			if ( type(update) == "table" ) then
				for k, v in update do
					if ( type(v) == "number" ) then
						CT_RA_UpdateUnitStatus(getglobal("CT_RAMember" .. v));
					else
						for i = 1, GetNumRaidMembers(), 1 do
							local uName = UnitName("raid" .. i);
							if ( uName and uName == v ) then
								CT_RA_UpdateUnitStatus(getglobal("CT_RAMember" .. i));
								break;
							end
						end
					end
				end
			end
		end
	elseif ( event == "CHAT_MSG_PARTY" ) then
		if ( frame ) then
			if ( arg6 and not unitStats[arg6] and ( arg6 == "AFK" or arg6 == "DND" ) ) then
				unitStats[arg6] = { 1, 0 };
				CT_RA_UpdateUnitDead(frame);
			elseif ( ( not arg6 or arg6 == "" ) and ( unitStats["DND"] or unitStats["AFK"] ) ) then
				unitStats["DND"] = nil;
				unitStats["AFK"] = nil;
				CT_RA_UpdateUnitDead(frame);
			end
		end
	end
end
	
CT_RA_oldChatFrame_OnEvent = ChatFrame_OnEvent;
function CT_RA_newChatFrame_OnEvent(event)
	if ( strsub(event, 1, 13) == "CHAT_MSG_RAID" ) then
		local tempOptions = CT_RAMenu_Options["temp"];
		local name, rank;
		for i = 1, GetNumRaidMembers(), 1 do
			name, rank = GetRaidRosterInfo(i);
			if ( name == arg2 ) then
				if ( rank and rank < 1 and CT_RA_Squelch > 0 ) then
					return;
				end
				break;
			end
		end
		if ( not rank ) then
			rank = 0;
		end
		if ( rank >= 1 and ( arg1 == "<CTRaid> Quiet mode, no talking." or arg1 == "<CTRaid> Quiet mode is over." ) ) then
			return;
		end
		local useless, useless, chan = string.find(gsub(arg1, "%%", "%%%%"), "^<CTMod> This is an automatic message sent by CT_RaidAssist. Channel changed to: (.+)$");
		if ( chan ) then
			return;
		end
		if ( rank == 2 and ( not tempOptions["leaderColor"] or tempOptions["leaderColor"].enabled ) ) then
			CT_RA_oldAddMessage = this.AddMessage;
			this.AddMessage = CT_RA_newAddMessage;
			CT_RA_oldChatFrame_OnEvent(event);
			this.AddMessage = CT_RA_oldAddMessage;
			return;
		end
	elseif ( event == "CHAT_MSG_WHISPER" ) then
		local tempOptions = CT_RAMenu_Options["temp"];
		if ( ( tempOptions["KeyWord"] and strlower(arg1) == strlower(tempOptions["KeyWord"]) ) or arg1 == "<CTRaid> Quiet mode is enabled in the raid. Please be quiet." ) then
			return;
		end
	elseif ( strsub(event, 1, 16) == "CHAT_MSG_CHANNEL" and CT_RA_Channel and arg9 and strlower(arg9) == strlower(CT_RA_Channel) ) then
		local type = strsub(event, 10);
		if ( type ~= "CHANNEL_LIST" and type ~= "SYSTEM" ) then
			return;
		end
	end
	CT_RA_oldChatFrame_OnEvent(event);
end
ChatFrame_OnEvent = CT_RA_newChatFrame_OnEvent;

function CT_RA_newAddMessage(obj, msg, r, g, b)
	local tempOptions = CT_RAMenu_Options["temp"];
	local newR, newG, newB = 1, 1, 0;
	if ( tempOptions["leaderColor"] ) then
		newR, newG, newB = tempOptions["leaderColor"].r, tempOptions["leaderColor"].g, tempOptions["leaderColor"].b;
	end
	return CT_RA_oldAddMessage(obj, string.gsub(msg, "(|Hplayer:.-|h%[)([%w]+)(%])", "%1|c00" .. CT_RA_RGBToHex(newR, newG, newB) .. "%2|r%3"), r, g, b);
end

function CT_RA_ParseMessage(nick, msg)
	local tempOptions = CT_RAMenu_Options["temp"];
	local useless, val1, val2, val3, val4, frame, raidid, rank, update;
	local numRaidMembers = GetNumRaidMembers();
	local playerName = UnitName("player");
	
	for i = 1, numRaidMembers, 1 do
		if ( UnitName("raid" .. i) == nick ) then
			raidid = i;
			useless, rank = GetRaidRosterInfo(i);
			frame = getglobal("CT_RAMember"..i);
			break;
		end
	end
	
	if ( not raidid or not frame ) then
		return;
	end
	
	local unitStats = CT_RA_Stats[nick];
	if ( not unitStats ) then
		if ( not update ) then
			update = { };
		end
		CT_RA_Stats[nick] = {
			["Buffs"] = { },
			["Debuffs"] = { },
			["Position"] = { }
		};
		unitStats = CT_RA_Stats[nick];
		tinsert(update, raidid);
	end
	unitStats["Reporting"] = 1;
	
	-- Check buff renewal
	useless, useless, val1, val2, val3 = string.find(msg, "^RN ([^%s]+) ([^%s]+) ([^%s]+)$"); -- timeleft(1), id(2), num(3)
	if ( tonumber(val1) and tonumber(val2) and tonumber(val3) ) then
		-- Buffs
		local buff;
		for k, v in tempOptions["BuffArray"] do
			if ( tonumber(val2) == v["index"] ) then
				buff = v;
				break;
			end
		end
		if ( not buff and tonumber(val2) == -1 ) then
			buff = { ["show"] = 1, ["name"] = CT_RA_FEIGNDEATH[CT_RA_GetLocale()] };
		elseif ( not buff ) then
			return update;
		end
		local name = buff["name"];
		if ( type(name) == "table" ) then
			if ( tonumber(val3) ) then
				name = name[tonumber(val3)];
			else
				return update;
			end
		end
		local text = CT_RA_BuffTextures[name];
		if ( not name or not text ) then
			return update;
		end
		unitStats["Buffs"][name] = { text[1], tonumber(val1) };
		return update;
	end

	-- Check status requests
	if ( msg == "SR" ) then
		if ( unitStats ) then
			unitStats["Buffs"] = { };
			unitStats["Debuffs"] = { };
			table.setn(unitStats["Buffs"], 0);
			table.setn(unitStats["Debuffs"], 0);
		end
		CT_RA_ScanPartyAuras("raid" .. raidid);
		CT_RA_UpdateFrame.scheduleUpdate = 8;
		CT_RA_UpdateFrame.scheduleMTUpdate = 8;
		return update;
	end

	if ( strsub(msg, 1, 2) == "S " ) then
		for str in string.gfind(msg, " B [^%s]+ [^%s]+ [^#]+ #") do
			useless, useless, val1, val3, val2 = string.find(str, "B ([^%s]+) ([^%s]+) (.+) #");
			if ( val1 and val2 and val3 ) then
				unitStats["Buffs"][val2] = { val1, tonumber(val3) };
				CT_RA_UpdateUnitBuffs(unitStats["Buffs"], frame, nick);
			end
		end
		return update;
	end

	if ( strsub(msg, 1, 3) == "MS " ) then
		if ( rank >= 1 ) then
			if ( tempOptions["PlayRSSound"] ) then
				PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
			end
			CT_RAMessageFrame:AddMessage(nick .. ": " .. strsub(msg, 3), tempOptions["DefaultAlertColor"].r, tempOptions["DefaultAlertColor"].g, tempOptions["DefaultAlertColor"].b, 1.0, UIERRORS_HOLD_TIME);
		end
		return update;
	end

	useless, useless, val1 = string.find(msg, "^V ([%d%.]+)$");
	if ( tonumber(val1) ) then
		unitStats["Version"] = tonumber(val1);
		return update;
	end


	if ( strsub(msg, 1, 4) == "SET " ) then
		local useless, useless, num, name = string.find(msg, "^SET (%d+) (.+)$");
		if ( num and name ) then
			if ( rank >= 1 ) then
				for k, v in CT_RA_MainTanks do
					if ( v == name ) then
						CT_RA_MainTanks[k] = nil;
						CT_RATarget.MainTanks[k] = nil;
					end
				end
				local mtID = 0;
				for i = 1, numRaidMembers, 1 do
					if ( UnitName("raid" .. i) == name ) then
						mtID = i;
						break;
					end
				end
				CT_RA_MainTanks[tonumber(num)] = name;
				CT_RATarget.MainTanks[tonumber(num)] = { mtID, name };
				CT_RATarget_UpdateInfoBox();
				CT_RATarget_UpdateStats();
				CT_RAOptions_Update();
				CT_RA_UpdateMTs();
			end
		end
		return update;
	end

	if ( strsub(msg, 1, 2) == "R " ) then
		local useless, useless, name = string.find(msg, "^R (.+)$");
		if ( name ) then
			for k, v in CT_RA_MainTanks do
				if ( v == name ) then
					for i = 1, GetNumRaidMembers(), 1 do
						local user, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
						if ( rank >= 1 and user == nick ) then
							CT_RA_MainTanks[k] = nil;
							CT_RATarget.MainTanks[k] = nil;
							CT_RA_UpdateMTs();
							CT_RAOptions_Update();
							return update;
						end
					end
				end
			end
		end
		return update;
	end

	if ( msg == "DB" ) then
		if ( rank >= 1 ) then
			CT_RA_Print("<CTRaid> Disbanding raid on request by '|c00FFFFFF" .. nick .. "|r'.", 1, 0.5, 0);
			LeaveParty();
		end
		return update;
	end

	if ( msg == "RESSED" ) then
		unitStats["Ressed"] = 1;
		CT_RA_UpdateUnitDead(frame);
		return update;
	end

	if ( msg == "NORESSED" ) then
		unitStats["Ressed"] = nil;
		CT_RA_UpdateUnitDead(frame);
		return update;
	end
	
	if ( msg == "CANRES" ) then
		unitStats["Ressed"] = 2;
		CT_RA_UpdateUnitDead(frame);
		return update;
	end

	if ( strsub(msg, 1, 3) == "RES" ) then
		if ( msg == "RESNO" ) then
			CT_RA_Ressers[nick] = nil;
		else
			local _, _, player = string.find(msg, "^RES (.+)$");
			if ( player ) then
				CT_RA_Ressers[nick] = player;
			end
		end
		CT_RA_UpdateResFrame();
		return update;
	end
	-- Check ready

	if ( msg == "CHECKREADY" ) then
		if ( rank >= 1 ) then
			CT_RA_CheckReady_Person = nick;
			if ( nick ~= playerName ) then
				PlaySoundFile("Sound\\interface\\levelup2.wav");
				CT_RA_ReadyFrame:Show();
			end
		end
		return update;
	elseif ( ( msg == "READY" or msg == "NOTREADY" ) and CT_RA_CheckReady_Person == playerName ) then
		if ( msg == "READY" ) then
			unitStats["notready"] = nil;
		else
			unitStats["notready"] = 2;
		end
		local all_ready = true;
		local nobody_ready = true;
		for k, v in CT_RA_Stats do
			if ( v["notready"] ) then
				all_ready = false;
				if ( v["notready"] == 1 ) then
					nobody_ready = false;
				end
			end
		end
		if ( all_ready ) then
			CT_RA_Print("<CTRaid> Everybody is ready.", 1, 1, 0);
		elseif ( not all_ready and nobody_ready ) then
			CT_RA_UpdateFrame.readyTimer = 0.1;
		end
		CT_RA_UpdateUnitDead(frame);
		return update;
	end
	
	-- Check Rly
	if ( msg == "CHECKRLY" ) then
		if ( rank >= 1 ) then
			CT_RA_CheckRly_Person = nick;
			if ( nick ~= UnitName("player") ) then
				PlaySoundFile("Sound\\interface\\levelup2.wav");
				CT_RA_RlyFrame:Show();
			end
		end
		return update;
	elseif ( ( msg == "YARLY" or msg == "NORLY" ) and CT_RA_CheckRly_Person == playerName ) then
		if ( msg == "YARLY" ) then
			unitStats["rly"] = nil;
		else
			unitStats["rly"] = 1;
		end
		local all_ready = true;
		local nobody_ready = true;
		for k, v in CT_RA_Stats do
			if ( v["rly"] ) then
				all_ready = false;
				if ( v["rly"] == 1 ) then
					nobody_ready = false;
				end
			end
		end
		if ( all_ready ) then
			CT_RA_Print("<CTRaid> Ya rly.", 1, 1, 0);
		elseif ( not all_ready and nobody_ready ) then
			CT_RA_UpdateFrame.rlyTimer = 0.1;
		end
		CT_RA_UpdateUnitDead(frame);
		return update;
	end

	-- Check AFK

	if ( msg == "AFK" ) then
		unitStats["AFK"] = { 1, 0 };
		CT_RA_UpdateUnitDead(frame);
		return update;
	elseif ( msg == "UNAFK" ) then
		unitStats["AFK"] = nil;
		CT_RA_UpdateUnitDead(frame);
		return update;
	elseif ( msg == "DND" ) then
		unitStats["DND"] = { 1, 0 };
		CT_RA_UpdateUnitDead(frame);
		return update;
	elseif ( msg == "UNDND" ) then
		unitStats["DND"] = nil;
		CT_RA_UpdateUnitDead(frame);
		return update;
	elseif ( strsub(msg, 1, 3) == "AFK" ) then
		-- With reason
		unitStats["AFK"] = { strsub(msg, 5), 0 };
		CT_RA_UpdateUnitDead(frame);
		return update;
	elseif ( strsub(msg, 1, 3) == "DND" ) then
		-- With reason
		unitStats["DND"] = { strsub(msg, 5), 0 };
		CT_RA_UpdateUnitDead(frame);
		return update;
	end
	
	-- Check duration
	if ( msg == "DURC" ) then
		if ( rank == 0 ) then
			return;
		end
		local currDur, maxDur, brokenItems = CT_RADurability_GetDurability();
		CT_RA_AddMessage("DUR " .. currDur .. " " .. maxDur .. " " .. brokenItems .. " " .. nick);
		return update;
	elseif ( string.find(msg, "^DUR ") ) then
		local _, _, currDur, maxDur, brokenItems, callPerson = string.find(msg, "^DUR (%d+) (%d+) (%d+) ([^%s]+)$");
		if ( currDur and maxDur and brokenItems and callPerson == playerName ) then
			currDur, maxDur = tonumber(currDur), tonumber(maxDur);
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(raidid);
			CT_RADurability_Add(nick, "|c00FFFFFF" .. floor((currDur/maxDur)*100+0.5) .. "%|r (|c00FFFFFF" .. brokenItems .. " broken items|r)", fileName, floor((currDur/maxDur)*100+0.5));
		end
		return update;
	end
	
	-- Check resists (Thanks Sudo!)
	if ( msg == "RSTC" ) then
		if ( rank == 0 ) then
			return update;
		end
		if ( tempOptions["DisableQuery"] ) then
			CT_RA_AddMessage("RST -1 " .. nick);
		else
			local resistStr = "";
			for i = 2, 6, 1 do
				local _, res, _, _ = UnitResistance("player", i);
				resistStr = resistStr .. " " .. res;
			end
			CT_RA_AddMessage("RST" .. resistStr ..  " " .. nick);
		end
		return update;
	elseif ( string.find(msg, "^RST ") ) then
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(raidid);
		local _, _, plrName = string.find(msg, "^RST %-1 ([^%s]+)$");
		if ( plrName and plrName == playerName ) then
			CT_RADurability_Add(nick, "|c00FFFFFFDisabled Queries|r", fileName, -1, -1, -1, -1, -1);
		else
			local _, _, FR, NR, FRR, SR, AR, callPerson = string.find(msg, "^RST (%d+) (%d+) (%d+) (%d+) (%d+) ([^%s]+)$");
			if ( FR and callPerson == playerName ) then
				CT_RADurability_Add(nick, "", fileName, tonumber(FR), tonumber(NR), tonumber(FRR), tonumber(SR), tonumber(AR) );
			end
		end
		return update;
	end
	
	-- Check reagents
	if ( msg == "REAC" ) then
		if ( rank == 0 ) then
			return update;
		end
		local numItems = CT_RAReagents_GetReagents();
		if ( numItems and numItems >= 0 ) then
			CT_RA_AddMessage("REA " .. numItems .. " " .. nick);
		end
		return update;
	elseif ( string.find(msg, "^REA ") ) then
		local _, _, numItems, callPerson = string.find(msg, "^REA ([^%s]+) ([^%s]+)$");
		if ( numItems and callPerson and callPerson == playerName ) then
			local classes = {
				[CT_RA_PRIEST] = CT_REG_PRIEST,
				[CT_RA_MAGE] = CT_REG_MAGE,
				[CT_RA_DRUID] = CT_REG_DRUID,
				[CT_RA_WARLOCK] = CT_REG_WARLOCK,
				[CT_RA_PALADIN] = CT_REG_PALADIN,
				[CT_RA_SHAMAN] = CT_REG_SHAMAN
			};
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(raidid);
			if ( numItems ~= "1" ) then
				CT_RADurability_Add(nick, "|c00FFFFFF" .. numItems .. "|r " .. classes[UnitClass("raid"..raidid)] .. "s", fileName, numItems);
			else
				CT_RADurability_Add(nick, "|c00FFFFFF" .. numItems .. "|r " .. classes[UnitClass("raid"..raidid)], fileName, numItems );
			end
		end
		return update;
	end
	
	-- Check items
	if ( string.find(msg, "^ITMC ") ) then
		local _, _, itemName = string.find(msg, "^ITMC (.+)$");
		if ( itemName ) then
			if ( rank == 0 ) then
				return;
			end
			if ( tempOptions["DisableQuery"] ) then
				CT_RA_AddMessage("ITM " .. -1 .. " " .. itemName .. " " .. nick);
			else
				local numItems = CT_RAItem_GetItems(itemName);
				if ( numItems and numItems > 0 ) then
					CT_RA_AddMessage("ITM " .. numItems .. " " .. itemName .. " " .. nick);
				end
			end
		end
		return update;
	elseif ( string.find(msg, "^ITM ") ) then
		local _, _, numItems, itemName, callPerson = string.find(msg, "^ITM ([-%d]+) (.+) ([^%s]+)$");
		if ( numItems and itemName and callPerson and callPerson == UnitName("player") ) then
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(raidid);
			if ( numItems == "-1" ) then
				CT_RADurability_Add(nick, "|c00FFFFFFDisabled Queries|r", fileName, "0", class);
			elseif ( numItems ~= "1" ) then
				CT_RADurability_Add(nick, "|c00FFFFFF" .. numItems .. "|r " .. itemName .. "s", fileName, numItems);
			else
				CT_RADurability_Add(nick, "|c00FFFFFF" .. numItems .. "|r " .. itemName, fileName, numItems);
			end
		end
		return update;
	end
	
	-- Check cooldowns
	if ( string.find(msg, "^CD %d+ %d+$") ) then
		local _, _, num, cooldown = string.find(msg, "^CD (%d+) (%d+)$");
		if ( num == "1" ) then
			unitStats["Rebirth"] = tonumber(cooldown)*60;
		elseif ( num == "2" ) then
			unitStats["Reincarnation"] = tonumber(cooldown)*60;
		elseif ( num == "3" ) then
			unitStats["Soulstone"] = tonumber(cooldown)*60;
		end
		return update;
	end
	
	-- Assist requests
	if ( string.find(msg, "^ASSISTME (.+)$") ) then
		if ( rank >= 1 ) then
			local _, _, name = string.find(msg, "^ASSISTME (.+)$");
			if ( name and name == playerName ) then
				CT_RATarget.assistPerson = { nick, 20 };
				ShowUIPanel(CT_RA_AssistFrame);
			end
		end
		return update;
	elseif ( string.find(msg, "^STOPASSIST (.+)$") ) then
		if ( rank >= 1 ) then
			local _, _, name = string.find(msg, "^STOPASSIST (.+)$");
			if ( name and name == playerName ) then
				HideUIPanel(CT_RA_AssistFrame);
			end
		end
		return update;
	end
	
	-- Vote
	local _, _, question = string.find(msg, "^VOTE (.+)$");
	if ( question ) then
		if ( rank >= 1 ) then
			CT_RA_VotePerson = { nick, 0, 0, question };
			if ( nick ~= playerName ) then
				PlaySoundFile("Sound\\interface\\levelup2.wav");
				CT_RA_VoteFrame.question = question;
				CT_RA_VoteFrame:Show();
			end
		end
		return update;
	elseif ( ( msg == "VOTEYES" or msg == "VOTENO" ) and CT_RA_VotePerson and CT_RA_VotePerson[1] == playerName ) then
		if ( msg == "VOTEYES" ) then
			CT_RA_VotePerson[2] = CT_RA_VotePerson[2] + 1;
		elseif ( msg == "VOTENO" ) then
			CT_RA_VotePerson[3] = CT_RA_VotePerson[3] + 1;
		end
		return update;
	end
	
	return update;
end

-- Send messages
function CT_RA_AddMessage(msg)
	tinsert(CT_RA_Comm_MessageQueue, msg);
end

function CT_RA_SendMessage(msg)
	if ( GetNumRaidMembers() == 0 ) then return; end -- Mod should be disabled if not in raid
	SendAddonMessage("CTRA", msg, "RAID");
end

function CT_RA_OnEvent(event)
	if ( event == "PLAYER_LEAVING_WORLD" ) then
		CT_RAFrame.disableEvents = true;
		return;
	elseif ( CT_RAFrame.disableEvents and event ~= "PLAYER_ENTERING_WORLD" ) then
		return;
	elseif ( event == "PLAYER_ENTERING_WORLD" or event == "RAID_ROSTER_UPDATE" ) then
		CT_RAFrame.disableEvents = nil;
		local numRaidMembers = GetNumRaidMembers();
		local playerName = UnitName("player");
		local tempOptions = CT_RAMenu_Options["temp"];
		if ( event == "RAID_ROSTER_UPDATE" ) then
			if ( numRaidMembers == 0 ) then
				CT_RA_MainTanks = { };
				CT_RA_PTargets = { };
				CT_RATarget.MainTanks = { };
				CT_RA_Stats = { };
				CT_RA_ButtonIndexes = { };
				CT_RA_Emergency_UpdateHealth();
				CT_RA_UpdateMTs();
				CT_RA_UpdatePTs();
				CT_RAMetersFrame:Hide();
			elseif ( CT_RA_NumRaidMembers == 0 and numRaidMembers > 0 ) then
				CT_RA_UpdateFrame.SS = 10;
				if ( CT_RA_UpdateFrame.time ) then
					CT_RA_UpdateFrame.time = nil;
				end
				if ( not CT_RA_HasJoinedRaid ) then
					CT_RA_Print("<CTRaid> First raid detected. Thanks for using CT_RaidAssist!", 1, 0.5, 0);
				end
				CT_RA_PartyMembers = { };
				CT_RA_HasJoinedRaid = 1;
				if ( CT_RA_Squelch > 0 ) then
					CT_RA_Print("<CTRaid> Quiet Mode has been automatically disabled (joined raid).", 1, 0.5, 0);
					CT_RA_Squelch = 0;
				end
			end
			CT_RA_CheckGroups();
		end
		if ( numRaidMembers > 0 ) then
			if ( tempOptions["StatusMeters"] and tempOptions["StatusMeters"]["Show"] ) then
				CT_RAMetersFrame:Show();
			else
				CT_RAMetersFrame:Hide();
			end
			if ( tempOptions["ShowMonitor"] ) then
				CT_RA_ResFrame:Show();
			else
				CT_RA_ResFrame:Hide();
			end
		else
			CT_RA_ResFrame:Hide();
			CT_RAMetersFrame:Hide();
		end
		CT_RAOptions_Update();
		if ( CT_RA_NumRaidMembers ~= numRaidMembers ) then
			for i = 1, numRaidMembers, 1 do
				local uId = "raid" .. i;
				local uName = UnitName(uId);
				if ( uName and CT_RA_Stats[uName] ) then
					table.setn(CT_RA_Stats[uName]["Debuffs"], 0);
				end
				CT_RA_ScanPartyAuras(uId);
			end
			CT_RA_UpdateRaidGroup(0);
			if ( CT_RA_NumRaidMembers == 0 and CT_RA_Level >= 2 ) then
				local lootid = ( CT_RATab_DefaultLootMethod or -1 );
				if ( lootid == 1 ) then
					SetLootMethod("freeforall");
				elseif ( lootid == 2 ) then
					SetLootMethod("roundrobin");
				elseif ( lootid == 3 ) then
					SetLootMethod("master", playerName);
				elseif ( lootid == 4 ) then
					SetLootMethod("group");
				elseif ( lootid == 5 ) then
					SetLootMethod("needbeforegreed");
				end
				for i = 1, numRaidMembers, 1 do
					local name, rank = GetRaidRosterInfo(i);
					if ( name ~= playerName and rank < 1 and CT_RATab_AutoPromotions[name] ) then
						PromoteToAssistant(name);
						CT_RA_Print("<CTRaid> Auto-Promoted |c00FFFFFF" .. name .. "|r.", 1, 0.5, 0);
					end
				end
			end
		else
			CT_RA_UpdateRaidGroup(3);
		end
		CT_RA_NumRaidMembers = numRaidMembers;
		if ( not CT_RA_Channel and GetGuildInfo("player") ) then
			CT_RA_Channel = "CT" .. string.gsub(GetGuildInfo("player"), "[^%w]", "");
		end
		if ( event == "PLAYER_ENTERING_WORLD" ) then
			if ( CT_RA_RaidParticipant ) then
				if ( CT_RA_RaidParticipant ~= playerName ) then
					CT_RA_Stats = { { } };
					CT_RA_MainTanks = { };
					CT_RA_PTargets = { };
					CT_RATarget.MainTanks = { };
					CT_RA_ButtonIndexes = { };
				end
			end
			CT_RA_RaidParticipant = playerName;
			-- Add chat frame stuff
			local info = CT_RA_ChatInfo[playerName];
			local chatTypeInfo = ChatTypeInfo["CTRAID"];
			if ( not info ) then
				info = CT_RA_ChatInfo["Default"];
			end
			chatTypeInfo.r = info.r;
			chatTypeInfo.g = info.g;
			chatTypeInfo.b = info.b;
		end
	elseif ( event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" ) then
		local _, _, id = string.find(arg1, "^raid(%d+)$");
		if ( id ) then
			local frame = getglobal("CT_RAMember" .. id);
			local name, hCurr, hMax = UnitName(arg1), UnitHealth(arg1), UnitHealthMax(arg1);
			local hpp = ( hCurr or 1 ) / ( hMax or 1 );
			local stats = CT_RA_Stats[name];
			if ( name ) then
				if ( not stats ) then
					CT_RA_Stats[name] = {
						["Buffs"] = { },
						["Debuffs"] = { },
						["Position"] = { }
					};
					stats = CT_RA_Stats[name];
				end
				if ( UnitIsDead(arg1) or UnitIsGhost(arg1) ) then
					CT_RA_ScanPartyAuras(arg1);
					if ( not stats["Dead"] ) then
						stats["Dead"] = 1;
					end
					CT_RA_UpdateUnitDead(frame);
				elseif ( stats["Dead"] ) then
					if ( hCurr > 0 and not UnitIsGhost(arg1) ) then
						stats["Dead"] = nil;
					end
					CT_RA_UpdateUnitDead(frame);
				else
					stats["Dead"] = nil;
					if ( not frame.hpp or frame.hpp ~= floor(hpp*100) ) then
						CT_RA_UpdateUnitHealth(frame);
					end
				end
				if ( CT_RA_Emergency_Units[name] or ( not CT_RA_EmergencyFrame.maxPercent or hpp < CT_RA_EmergencyFrame.maxPercent ) ) then
					CT_RA_Emergency_UpdateHealth();
				end
			end
		elseif ( ( GetNumRaidMembers() == 0 and ( arg1 == "player" or string.find(arg1, "^party%d+$") ) ) ) then
			if ( CT_RA_Emergency_Units[UnitName(arg1)] or ( not CT_RA_EmergencyFrame.maxPercent or ( hpp and hpp < CT_RA_EmergencyFrame.maxPercent ) ) ) then
				CT_RA_Emergency_UpdateHealth();
			end
		end
		return;
	elseif ( event == "UNIT_AURA" and GetNumRaidMembers() > 0 ) then
		if ( string.find(arg1, "^raid%d+$") ) then
			CT_RA_ScanPartyAuras(arg1);
		end
	elseif ( event == "UNIT_MANA" or event == "UNIT_MAXMANA" or event == "UNIT_RAGE" or event == "UNIT_MAXRAGE" or event == "UNIT_ENERGY" or event == "UNIT_MAXENERGY" ) then
		local _, _, id = string.find(arg1, "^raid(%d+)$");
		if ( id ) then
			CT_RA_UpdateUnitMana(getglobal("CT_RAMember" .. id));
		end
		return;
	elseif ( event == "UI_ERROR_MESSAGE" or event == "UI_INFO_MESSAGE" ) then
		if ( CT_RA_LastCast and (GetTime()-CT_RA_LastCast) <= 0.1 ) then
			if ( CT_RA_LastCastType == "debuff" ) then
				tinsert(CT_RA_BuffsToCure, 1, CT_RA_LastCastSpell);
			else
				tinsert(CT_RA_BuffsToRecast, 1, CT_RA_LastCastSpell);
			end
			CT_RA_LastCast = nil;
			CT_RA_LastCastSpell = nil;
		end
	elseif ( event == "SPELLCAST_START" ) then
		CT_RA_CurrCastSpell = arg1;
	elseif ( event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED" ) then
		CT_RA_CurrCastSpell = nil;
	elseif ( event == "SPELLCAST_STOP" and CT_RA_CurrCastSpell ) then
		if ( CT_RA_CurrCastSpell == CT_RA_REBIRTH ) then
			CT_RA_AddMessage("CD 1 30");
		elseif ( CT_RA_CurrCastSpell == CT_RA_SOULSTONERESURRECTION ) then
			CT_RA_AddMessage("CD 3 30");
		end
		CT_RA_CurrCastSpell = nil;
	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
		CT_RA_UpdateResFrame();
	end
end

CT_RA_oldUseSoulstone = UseSoulstone;
function CT_RA_newUseSoulstone()
	local text = HasSoulstone();
	if ( text and text == "Reincarnation" ) then
		local cooldown;
		for i = 1, GetNumTalentTabs(), 1 do
			for y = 1, GetNumTalents(i), 1 do
				local name, _, _, _, currRank = GetTalentInfo(i, y);
				if ( name == "Improved Reincarnation" ) then
					cooldown = 60 - (currRank*10);
					break;
				end
			end
			if ( cooldown ) then
				break;
			end
		end
		if ( not cooldown ) then
			cooldown = 60;
		end
		CT_RA_AddMessage("CD 2 " .. cooldown);
	end
	CT_RA_oldUseSoulstone();
end
UseSoulstone = CT_RA_newUseSoulstone;

-----------------------------------------------------
--                  Update Functions               --
-----------------------------------------------------
	
-- Update health
function CT_RA_UpdateUnitHealth(frame)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( not frame.group or not tempOptions["ShowGroups"][frame.group.id] ) then
		return;
	end
	local id = "raid" .. frame.id;
	local maxHealth = UnitHealthMax(id);
	local percent = floor(UnitHealth(id) / maxHealth * 100);
	local name = UnitName(id);
	if ( not name and tempOptions["SORTTYPE"] == "virtual" ) then
		percent = 100;
		maxHealth = 100;
		name = "Virtual " .. frame.id;
	end
	frame.hpp = percent;
	local updateDead = frame.status;
	if ( percent and percent > 0 ) then
		-- Commonly used values
		local defaultAlpha = tempOptions.DefaultAlpha;
		if ( defaultAlpha and defaultAlpha < 1 ) then
			frame:SetAlpha(math.max(math.min(defaultAlpha+(1-(percent/100))*(1-defaultAlpha), 1), defaultAlpha));
		else
			frame:SetAlpha(1);
		end
		local showHP = tempOptions["ShowHP"];
		local memberHeight = tempOptions["MemberHeight"];
		local framePercent = frame.Percent;
		local frameHPBar = frame.HPBar;
		local stats = CT_RA_Stats[name];
		
		if ( stats and stats["Ressed"] ) then
			stats["Ressed"] = nil;
			updateDead = 1;
		end
		if ( percent > 100 ) then
			percent = 100;
		end
		frameHPBar:SetValue(percent);
		if ( showHP and showHP == 1 and maxHealth and memberHeight == 40 ) then
			framePercent:SetText(floor(percent/100*maxHealth) .. "/" .. maxHealth);
		elseif ( showHP and showHP == 2 and memberHeight == 40 ) then
			framePercent:SetText(percent .. "%");
		elseif ( showHP and showHP == 3 and memberHeight == 40 ) then
			if ( maxHealth ) then
				local diff = floor(percent/100*maxHealth)-maxHealth;
				if ( diff == 0 ) then diff = ""; end
				framePercent:SetText(diff);
			else
				framePercent:SetText(percent-100 .. "%");
			end
		else
			framePercent:Hide();
		end
		local hppercent = percent/100;
		local r, g;
		if ( hppercent > 0.5 and hppercent <= 1) then
			g = 1;
			r = (1.0 - hppercent) * 2;
		elseif ( hppercent >= 0 and hppercent <= 0.5 ) then
			r = 1.0;
			g = hppercent * 2;
		else
			r = 0;
			g = 1;
		end
		frameHPBar:SetStatusBarColor(r, g, 0);
		frame.HPBG:SetVertexColor(r, g, 0, tempOptions["BGOpacity"]);
	end
	local isDead;
	if ( updateDead ) then
		CT_RA_UpdateUnitDead(frame, 1);
	end
end

-- Update status

function CT_RA_UpdateUnitStatus(frame)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( not frame.group or not tempOptions["ShowGroups"][frame.group.id] ) then
		return;
	end
	local frameName = frame.name;
	local id = frame.id;
	local castFrame = frame.CastFrame;
	
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(id);
	if ( not name and tempOptions["SORTTYPE"] == "virtual" ) then
		name, rank, subgroup, level, class, fileName, zone, online, isDead = "Virtual " .. id, 0, floor((id-1)/5)+1, 60, CT_RA_PRIEST, "PRIEST", "Emerald Dream", 1, nil;
	end
	local height = tempOptions["MemberHeight"];
	if ( ( ( class == CT_RA_WARRIOR or class == CT_RA_ROGUE ) and tempOptions["HideRP"] ) or ( class ~= CT_RA_WARRIOR and class ~= CT_RA_ROGUE and tempOptions["HideMP"] ) ) then
		height = height - 4;
	end
	if ( tempOptions["HideBorder"] ) then
		if ( height == 28 ) then
			frame.BuffButton1:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", -5, -5);
			frame.DebuffButton1:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", -5, -5);
		else
			frame.BuffButton1:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", -5, -3);
			frame.DebuffButton1:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", -5, -3);
		end
		frame:SetBackdropBorderColor(1, 1, 1, 0);
		
		frame.Percent:SetPoint("TOP", frameName, "TOP", 2, -16);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame.HPBG:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		castFrame:SetWidth(85);
		if ( not online ) then
			frame:SetHeight(37);
			castFrame:SetHeight(37);
		else
			frame:SetHeight(height-3);
			castFrame:SetHeight(height-3);
		end
	else
		frame:SetBackdropBorderColor(1, 1, 1, 1);
		frame.BuffButton1:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", -5, -5);
		frame.DebuffButton1:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", -5, -5);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -22);
		frame.HPBG:SetPoint("TOPLEFT",frameName, "TOPLEFT", 10, -22);
		frame.Percent:SetPoint("TOP", frameName, "TOP", 2, -18);
		castFrame:SetWidth(90);
		if ( not online ) then
			frame:SetHeight(40);
			castFrame:SetHeight(40);
		else
			frame:SetHeight(height);
			castFrame:SetHeight(height);
		end
	end
	if ( height == 32 or height == 28 ) then
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.Percent:Hide();
	else
		frame.HPBar:Show();
		frame.HPBG:Show();
	end
	stats = CT_RA_Stats[name];
	if ( frame.group and tempOptions["ShowGroups"][frame.group.id] ) then
		frame:Show();
	end
	frame.Name:SetText(name);
	CT_RA_UpdateUnitDead(frame);
	if ( stats ) then
		CT_RA_UpdateUnitBuffs(stats["Buffs"], frame, name);
	end
	if ( online ) then
		CT_RA_UpdateUnitHealth(frame, 1);
		CT_RA_UpdateUnitMana(frame);
		if ( stats ) then
			CT_RA_UpdateUnitBuffs(stats["Buffs"], frame, name);
		end
	end
end

function CT_RA_CanShowInfo(id)
	local tempOptions = CT_RAMenu_Options["temp"];
	local stats = CT_RA_Stats[UnitName(id)];
	local showHP, hasFD, isRessed, isNotReady, showAFK, isDead;
	local hp = tempOptions["ShowHP"];
	
	showHP = ( hp and hp <= 3 );
	hasFD = ( stats and stats["FD"] );
	isRessed = ( stats and stats["Ressed"] );
	isNotReady = ( stats and stats["notready"] );
	showAFK = ( tempOptions["ShowAFK"] and stats and stats["AFK"] );
	isDead = ( ( stats and stats["Dead"] ) or UnitIsDead(id) or UnitIsGhost(id) );
	if ( showHP and not hasFD and not isRessed and not isNotReady and not showAFK and not isDead ) then
		return true;
	else
		return nil;
	end
end
-- Update mana
function CT_RA_UpdateUnitMana(frame)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( not frame.group or not tempOptions["ShowGroups"][frame.group.id] ) then
		return;
	end
	local id = "raid" .. frame.id;
	local percent;
	if ( not UnitExists(id) and tempOptions["SORTTYPE"] == "virtual" ) then
		percent = 100;
	else
		percent = floor(UnitMana(id) / UnitManaMax(id) * 100);
	end
	frame.MPBar:SetValue(percent);
end

-- Update buffs
function CT_RA_UpdateUnitBuffs(buffs, frame, nick)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( not frame.group or not tempOptions["ShowGroups"][frame.group.id] ) then
		return;
	end
	local num = 1;
	if ( buffs ) then	
		if ( not tempOptions["ShowDebuffs"] or tempOptions["ShowBuffsDebuffed"] ) then
			for key, val in tempOptions["BuffArray"] do
				local name;
				if ( type(val["name"]) == "table" ) then
					if ( buffs[val["name"][1]] ) then
						name = val["name"][1];
					elseif ( buffs[val["name"][2]] ) then
						name = val["name"][2];
					end
				elseif ( buffs[val["name"]] ) then
					name = val["name"];
				end
				if ( name ) then
					if ( num <= 4 and val["show"] ~= -1 ) then -- Change 4 to number of buffs
						local button = frame["BuffButton"..num];
						frameCache[button].Icon:SetTexture("Interface\\Icons\\" .. CT_RA_BuffTextures[name][1]);
						button.name = name;
						button.owner = nick;
						button.texture = CT_RA_BuffTextures[name][1];
						button:Show();
						num = num + 1;
					end
				end
			end
		end
	end
	for i = num, 4, 1 do -- Change 4 to number of buffs
		frame["BuffButton"..i]:Hide();
	end
	local stats = CT_RA_Stats[nick];
	if ( stats ) then
		CT_RA_UpdateUnitDebuffs(stats["Debuffs"], frame);
	end
end

function CT_RA_UpdateUnitDead(frame, didUpdateHealth)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( not frame.group or not tempOptions["ShowGroups"][frame.group.id] ) then
		return;
	end
	local raidid = "raid" .. frame.id;
	local name, rank, subgroup, level, class, fileName, zone, online, dead = GetRaidRosterInfo(frame.id);
	if ( not name and tempOptions["SORTTYPE"] == "virtual" ) then
		name, rank, subgroup, level, class, fileName, zone, online, isDead = "Virtual " .. frame.id, 0, floor((frame.id-1)/5)+1, 60, CT_RA_PRIEST, "PRIEST", "Emerald Dream", 1, nil;
	end
	local color = RAID_CLASS_COLORS[fileName];
	if ( color ) then
		frame.Name:SetTextColor(color.r, color.g, color.b);
	end
	local stats, isFD, isDead = CT_RA_Stats[name], false, false;
	if ( UnitIsGhost(raidid) or UnitIsDead(raidid) ) then
		isFD = CT_RA_CheckFD(name, raidid)
		if ( isFD == 0 ) then
			isDead = 1;
			-- Scan buffs&debuffs on death
			CT_RA_ScanPartyAuras(raidid);
		end
	end
	local height = tempOptions["MemberHeight"];
	if ( ( ( class == CT_RA_WARRIOR or class == CT_RA_ROGUE ) and tempOptions["HideRP"] ) or ( class ~= CT_RA_WARRIOR and class ~= CT_RA_ROGUE and tempOptions["HideMP"] ) ) then
		height = height - 4;
	end
	if ( not online ) then
		if ( tempOptions["HideOffline"] ) then
			frame:Hide();
		end
		for i = 1, 4, 1 do
			if ( i <= 2 ) then
				frame["DebuffButton"..i]:Hide();
			end
			frame["BuffButton"..i]:Hide();
		end
		frame:SetBackdropColor(0.3, 0.3, 0.3, 1);
		if ( tempOptions["HideBorder"] ) then
			frame:SetHeight(37);
		else
			frame:SetHeight(40);
		end
		if ( name ) then
			if ( not stats ) then
				CT_RA_Stats[name] = {
					["Buffs"] = { },
					["Debuffs"] = { },
					["Position"] = { },
				};
				stats = CT_RA_Stats[name];
			end
			if ( not stats["Offline"] ) then
				stats["Offline"] = 1;
			end
		end
		frame.status = "offline";
		frame.Status:SetText("OFFLINE");
		frame.Status:Show();
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.Percent:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame:SetAlpha(1);
		return;
	elseif ( stats and stats["notready"] ) then
		frame.Status:Show();
		if ( tempOptions["HideBorder"] ) then
			frame:SetHeight(37);
		else
			frame:SetHeight(40);
		end
		
		if ( stats["notready"] == 1 ) then
			frame.status = "noreply";
			frame.Status:SetText("No Reply");
			frame:SetBackdropColor(0.45, 0.45, 0.45, 1);
		else
			frame.status = "notready";
			frame.Status:SetText("Not Ready");
			frame:SetBackdropColor(0.8, 0.45, 0.45, 1);
		end
		
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.Percent:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame:SetAlpha(1);
	elseif ( isFD == 1 ) then
		frame.status = "feigndeath";
		frame.Status:Show();
		frame.Status:SetText("Feign Death");
		frame:SetBackdropColor(0.3, 0.3, 0.3, 1);
		if ( tempOptions["HideBorder"] and ( ( ( class == CT_RA_WARRIOR or class == CT_RA_ROGUE ) and tempOptions["HideRP"] ) or ( class ~= CT_RA_WARRIOR and class ~= CT_RA_ROGUE and tempOptions["HideMP"] ) ) ) then
			frame:SetHeight(height+3);
		end
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.Percent:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame:SetAlpha(1);
	elseif ( isFD == 2 ) then
		frame.status = "spiritofredemption";
		frame.Status:Show();
		frame.Status:SetText("SoR");
		frame:SetBackdropColor(0.3, 0.3, 0.3, 1);
		if ( tempOptions["HideBorder"] and ( ( ( class == CT_RA_WARRIOR or class == CT_RA_ROGUE ) and tempOptions["HideRP"] ) or ( class ~= CT_RA_WARRIOR and class ~= CT_RA_ROGUE and tempOptions["HideMP"] ) ) ) then
			frame:SetHeight(height+3);
		end
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.Percent:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame:SetAlpha(1);
	elseif ( stats and stats["Ressed"] ) then
		frame.status = "resurrected";
		frame.Status:Show();
		frame:SetBackdropColor(0.3, 0.3, 0.3, 1);
		if ( tempOptions["HideBorder"] ) then
			frame:SetHeight(37);
		else
			frame:SetHeight(40);
		end
		if ( stats["Ressed"] == 1 ) then
			frame.Status:SetText("Resurrected");
		elseif ( stats["Ressed"] == 2 ) then
			frame.Status:SetText("SS Available");
		end
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.Percent:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame:SetAlpha(1);
	elseif ( isDead ) then
		frame.status = "dead";
		for i = 1, 4, 1 do
			if ( i <= 2 ) then
				frame["DebuffButton"..i]:Hide();
			end
			frame["BuffButton"..i]:Hide();
		end
		frame.Status:Show();
		frame:SetBackdropColor(0.3, 0.3, 0.3, 1);
		if ( tempOptions["HideBorder"] ) then
			frame:SetHeight(37);
		else
			frame:SetHeight(40);
		end
		frame.Status:SetText("DEAD");
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		
		frame.Percent:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame:SetAlpha(1);
	elseif ( stats and stats["AFK"] and tempOptions["ShowAFK"] ) then
		frame.status = "afk";
		frame.Status:Show();
		frame:SetBackdropColor(0.3, 0.3, 0.3, 1);
		if ( tempOptions["HideBorder"] ) then
			frame:SetHeight(37);
		else
			frame:SetHeight(40);
		end
		
		frame.Status:SetText("AFK");
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.Percent:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame:SetAlpha(1);
	else
		if ( frame.status and not didUpdateHealth ) then
			CT_RA_UpdateUnitHealth(frame);
		end
		local canShowInfo = CT_RA_CanShowInfo("raid"..frame.id);
		frame.status = nil;
		frame:SetBackdropColor(tempOptions["DefaultColor"].r, tempOptions["DefaultColor"].g, tempOptions["DefaultColor"].b, tempOptions["DefaultColor"].a);
		if ( tempOptions["MemberHeight"] == 40 ) then
			frame.HPBar:Show();
			frame.HPBG:Show();
			if ( canShowInfo ) then
				frame.Percent:Show();
			else
				frame.Percent:Hide();
			end
		end
		if ( tempOptions["HideBorder"] ) then
			frame:SetHeight(height-3);
		else
			frame:SetHeight(height);
		end
		if ( class == CT_RA_WARRIOR ) then
			frame.MPBar:SetStatusBarColor(1, 0, 0);
			frame.MPBG:SetVertexColor(1, 0, 0, tempOptions["BGOpacity"]);
		elseif ( class == CT_RA_ROGUE ) then
			frame.MPBar:SetStatusBarColor(1, 1, 0);
			frame.MPBG:SetVertexColor(1, 1, 0, tempOptions["BGOpacity"]);
		else
			frame.MPBar:SetStatusBarColor(0, 0, 1);
			frame.MPBG:SetVertexColor(0, 0, 1, tempOptions["BGOpacity"]);
		end
		frame.Status:Hide();
		if ( ( ( class == CT_RA_WARRIOR or class == CT_RA_ROGUE ) and not tempOptions["HideRP"] ) or ( class ~= CT_RA_WARRIOR and class ~= CT_RA_ROGUE and not tempOptions["HideMP"] ) ) then
			frame.MPBar:Show();
			frame.MPBG:Show();
			if ( canShowInfo ) then
				frame.Percent:Show();
			else
				frame.Percent:Hide();
			end
		else
			frame.MPBar:Hide();
			frame.MPBG:Hide();
		end
	end
	if ( stats ) then
		stats["Offline"] = nil;
	end
end

-- Update debuffs
function CT_RA_UpdateUnitDebuffs(debuffs, frame)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( not frame.group or not tempOptions["ShowGroups"][frame.group.id] ) then
		return;
	end
	local num = 1;
	if ( tempOptions["ShowBuffsDebuffed"] ) then
		num = 2;
	end
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(frame.id);
	local stats, setbg = CT_RA_Stats[name], 0;
	if ( name and stats and online and not UnitIsGhost("raid" .. frame.id) and ( not UnitIsDead("raid" .. frame.id) or stats["FD"] ) ) then
		if ( not frame.status ) then
			local defaultColors = tempOptions["DefaultColor"];
			frame:SetBackdropColor(defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a);
		end
		if ( debuffs ) then
			for key, val in tempOptions["DebuffColors"] do
				for k, v in debuffs do
					local en, de, fr;
					if ( type(val["type"]) == "table" ) then
						en = val["type"]["en"];
						de = val["type"]["de"];
						fr = val["type"]["fr"];
					else
						en = val["type"];
					end
					if ( ( ( en and en == v[1] ) or ( de and de == v[1] ) or ( fr and fr == v[1] ) ) and val["id"] ~= -1 ) then
						if ( tempOptions["ShowBuffsDebuffed"] and num >= 1 ) then
							local button = frame["DebuffButton"..num];
							frameCache[button].Icon:SetTexture("Interface\\Icons\\" ..v[3]);
							button.name = k;
							button.owner = name;
							button.texture = v[3];
							button:Show();
							num = num - 1;
						elseif ( not tempOptions["ShowBuffsDebuffed"] and tempOptions["ShowDebuffs"] and num <= 2 ) then
							local button = frame["DebuffButton"..num];
							frameCache[button].Icon:SetTexture("Interface\\Icons\\" ..v[3]);
							button.name = k;
							button.owner = name;
							button.texture = v[3];
							button:Show();
							num = num + 1;
						end
						if ( setbg == 0 and not frame.status ) then
							frame:SetBackdropColor(val.r, val.g, val.b, val.a);
							setbg = 1;
						end
					end
				end
			end
		end
		if ( tempOptions["ShowBuffsDebuffed"] ) then
			if ( num < 1 ) then
				for i = 1, 4, 1 do
					frame["BuffButton"..i]:Hide();
				end
			end
			for i = num, 1, -1 do
				frame["DebuffButton"..i]:Hide();
			end
		else
			for i = num, 2, 1 do
				frame["DebuffButton"..i]:Hide();
			end
		end
	end
end

-- Get info

function CT_RA_SortClassArray(arr)

	local classValues = {
		[CT_RA_WARRIOR] = 8,
		[CT_RA_PALADIN] = 7,
		[CT_RA_DRUID] = 6,
		[CT_RA_MAGE] = 5,
		[CT_RA_WARLOCK] = 4,
		[CT_RA_ROGUE] = 3,
		[CT_RA_HUNTER] = 2,
		[CT_RA_PRIEST] = 1,
		[CT_RA_SHAMAN] = 0
	};

	local limit, st, j, temp, swapped;
	limit = getn(arr);
	st = 0;
	while ( st < limit ) do
		swapped = false;
		st = st + 1;
		limit = limit - 1;
		local val, val1;

		for j = st, limit, 1 do
			if ( arr[j]["class"] ) then
				val = classValues[arr[j]["class"]];
			else
				val = 0;
			end
			if ( arr[j+1]["class"] ) then
				val1 = classValues[arr[j+1]["class"]];
			else
				val1 = 0;
			end
			if ( val < val1 ) then
				temp = arr[j];
				arr[j] = arr[j+1];
				arr[j+1] = temp;
				swapped = true;
			end
		end
		if ( not swapped ) then return arr; end

		swapped = false;
		for j=limit, st, -1 do
			if ( arr[j]["class"] ) then
				val = classValues[arr[j]["class"]];
			else
				val = 0;
			end
			if ( arr[j+1]["class"] ) then
				val1 = classValues[arr[j+1]["class"]];
			else
				val1 = 0;
			end

			if ( val < val1 ) then
				temp = arr[j];
				arr[j] = arr[j+1];
				arr[j+1] = temp;
				swapped = true;
			end
		end
		if ( not swapped ) then return arr; end
	end
	return arr;
end

function CT_RA_UpdateMT(raidid, mtid, frame, height, key, val)
	local tempOptions = CT_RAMenu_Options["temp"];
	local framecast = frame.CastFrame;
	local frameName = frame.name;
	if ( not tempOptions["ShowMTTT"] or ( UnitIsUnit(mtid, raidid .. "target") or tempOptions["HideColorChange"] ) ) then
		local defaultColors = tempOptions.DefaultColor;
		frame:SetBackdropColor(defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a);
	else
		frame:SetBackdropColor(1, 0, 0, 1);
	end
	if ( tempOptions["HideBorder"] ) then
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -16);
		frame:SetBackdropBorderColor(1, 1, 1, 0);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame.HPBG:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame:SetHeight(height-3);
		frame.height = height-3;
		framecast:SetHeight(height-3);
		framecast:SetWidth(85);
	else
		frame:SetBackdropBorderColor(1, 1, 1, 1);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -22);
		frame.HPBG:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -22);
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -18);
		frame:SetHeight(height);
		frame.height = height;
		framecast:SetHeight(height);
		framecast:SetWidth(90);
	end
	if ( raidid and UnitExists(raidid) and strlen(UnitName(raidid) or "") > 0 ) then
		local health, healthmax, mana, manamax = UnitHealth(raidid), UnitHealthMax(raidid), UnitMana(raidid), UnitManaMax(raidid);
		frame.Name:SetHeight(15);
		frame.Status:Hide();
		frame.HPBar:Show();
		frame.HPBG:Show();
		frame.MPBar:Show();
		frame.MPBG:Show();
		frame.Name:Show();
		local manaType = UnitPowerType(raidid);
		if ( ( manaType == 0 and not tempOptions["HideMP"] ) or ( manaType > 0 and not tempOptions["HideRP"] and UnitIsPlayer(raidid) ) ) then
			local manaTbl = ManaBarColor[manaType];
			frame.MPBar:SetStatusBarColor(manaTbl.r, manaTbl.g, manaTbl.b);
			frame.MPBG:SetVertexColor(manaTbl.r, manaTbl.g, manaTbl.b, tempOptions["BGOpacity"]);
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(37);
				frame.height = 37;
				framecast:SetHeight(37);
			else
				frame:SetHeight(40);
				frame.height = 40;
				framecast:SetHeight(40);
			end
			frame.MPBar:SetMinMaxValues(0, manamax);
			frame.MPBar:SetValue(mana);
		else
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(33);
				frame.height = 33;
				framecast:SetHeight(33);
			else
				frame:SetHeight(36);
				frame.height = 36;
				framecast:SetHeight(36);
			end
		end
		if ( health and healthmax and not UnitIsDead(raidid) and not UnitIsGhost(raidid) ) then
			if ( tempOptions["ShowHP"] and tempOptions["ShowHP"] <= 4 ) then
				frame.Percent:Show();
			else
				frame.Percent:Hide();
			end
			
			frame.HPBar:SetMinMaxValues(0, healthmax);
			frame.HPBar:SetValue(health);
			
			frame.Percent:SetText(floor(health/healthmax*100+0.5) .. "%");
			local percent = health/healthmax;
			if ( percent >= 0 and percent <= 1 ) then
				local r, g;
				if ( percent > 0.5 ) then
					g = 1;
					r = (1.0 - percent) * 2;
				else
					r = 1;
					g = percent * 2;
				end
				frame.HPBar:SetStatusBarColor(r, g, 0);
				frame.HPBG:SetVertexColor(r, g, 0, tempOptions["BGOpacity"]);
			end
		elseif ( UnitIsDead(raidid) or UnitIsGhost(raidid) ) then
			frame.HPBar:Hide();
			frame.HPBG:Hide();
			frame.Percent:Hide();
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			frame.Status:Show();
			frame.Status:SetText("DEAD");
		else
			frame.HPBar:Hide();
			frame.HPBG:Hide();
		end
		frame.Name:SetText(UnitName(raidid));
		if ( UnitCanAttack("player", raidid) ) then
			frame.Name:SetTextColor(1, 0.5, 0);
		else
			frame.Name:SetTextColor(0.5, 1, 0);
		end
		frame.CastFrame.unitName = UnitName(raidid);
	else
		frame.Percent:Hide();
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame.Status:Hide();
		frame.Name:SetText(val .. "'s Target");
		frame.Name:SetHeight(30);
		frame.Name:SetTextColor(1, 0.82, 0);
	end
end
	
function CT_RA_UpdateMTs()
	local tempOptions = CT_RAMenu_Options["temp"];
	CT_RAMTGroupGroupName:SetText("MT Targets");
	CT_RAMTGroup:Hide();
	CT_RAMTGroupGroupName:Hide();
	for i = 1, 10, 1 do
		local mem = getglobal("CT_RAMTGroupMember" .. i);
		mem:Hide();
		mem:ClearAllPoints();
		if ( i > 1 ) then
			local above = "CT_RAMTGroupMember" .. (i-1);
			if ( tempOptions["HideBorder"] ) then
				if ( tempOptions["HideSpace"] ) then
					if ( tempOptions["ShowReversed"] ) then
						mem:SetPoint("BOTTOMLEFT", above, "TOPLEFT", 0, -10);
					else
						mem:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, 10);
					end
				else
					if ( tempOptions["ShowReversed"] ) then
						mem:SetPoint("BOTTOMLEFT", above, "TOPLEFT", 0, -7);
					else
						mem:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, 7);
					end
				end
			else
				if ( tempOptions["ShowReversed"] ) then
					mem:SetPoint("BOTTOMLEFT", above, "TOPLEFT", 0, -5);
				else
					mem:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, 4);
				end
			end
		else
			if ( tempOptions["ShowReversed"] ) then
				mem:SetPoint("BOTTOMLEFT", "CT_RAMTGroup", "TOPLEFT", 0, -15);
			else
				mem:SetPoint("TOPLEFT", "CT_RAMTGroup", "TOPLEFT", 0, -20);
			end
		end
	end
	if ( GetNumRaidMembers() == 0 or tempOptions["HideMTs"] ) then
		CT_RAMTGroupDrag:Hide();
		return;
	end
	local hide = true;
	for key, val in CT_RA_MainTanks do
		if ( key <= ( tempOptions["ShowNumMTs"] or 10 ) ) then
			local height = tempOptions["MemberHeight"];
			if ( tempOptions["HideMP"] ) then
				height = height - 4;
			end
			local frame = getglobal("CT_RAMTGroupMember" .. key);
			local frameParent = frame.frameParent;
			local raidid, mtid;
			for i = 1, GetNumRaidMembers(), 1 do
				if ( UnitName("raid" .. i) == CT_RA_MainTanks[key] ) then
					raidid = "raid" .. i .. "target";
					mtid = "raid" .. i;
					break;
				end
			end
			if ( raidid and mtid ) then
				local name, hppercent, mppercent = UnitName(raidid), UnitHealth(raidid)/UnitHealthMax(raidid), UnitMana(raidid)/UnitManaMax(raidid);
				if ( name ~= ( frame.unitName or "" ) or hppercent ~= ( frame.hppercent or -1 ) or mppercent ~= ( frame.mppercent or -1 ) or not UnitIsConnected(raidid) ) then
					if ( not UnitIsConnected(raidid) ) then
						frame.unitName = nil; frame.hppercent = nil; frame.mppercent = nil;
					else
						frame.unitName = name; frame.hppercent = hppercent; frame.mppercent = mppercent;
					end
					CT_RA_UpdateMT(raidid, mtid, frame, height, key, val);
				end
				frame:Show();
				frameParent:Show();
			end
			if ( not tempOptions["HideNames"] ) then
				frameCache[frameParent].GroupName:Show();
			else
				frameCache[frameParent].GroupName:Hide();
			end
			if ( not tempOptions["LockGroups"] ) then
				hide = false;
				CT_RAMTGroupDrag:Show();
			end
		end
	end
	if ( hide ) then
		CT_RAMTGroupDrag:Hide();
	end
	CT_RA_UpdateMTTTs();
end

function CT_RA_UpdatePT(raidid, frame, height, key, val)
	local tempOptions = CT_RAMenu_Options["temp"];
	local framecast = getglobal("CT_RAPTGroupMember" .. key .. "CastFrame");
	local frameName = frame.name;
	frame:SetBackdropColor(tempOptions["DefaultColor"]["r"], tempOptions["DefaultColor"]["g"], tempOptions["DefaultColor"]["b"], tempOptions["DefaultColor"]["a"]);
	if ( tempOptions["HideBorder"] ) then
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -16);
		frame:SetBackdropBorderColor(1, 1, 1, 0);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame.HPBG:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame:SetHeight(height-3);
		frame.height = height-3;
		framecast:SetHeight(height-3);
		framecast:SetWidth(85);
	else
		frame:SetBackdropBorderColor(1, 1, 1, 1);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -22);
		frame.HPBG:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -22);
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -18);
		frame:SetHeight(height);
		frame.height = height;
		framecast:SetHeight(height);
		framecast:SetWidth(90);
	end
	if ( raidid and UnitExists(raidid) and strlen(UnitName(raidid) or "") > 0 ) then
		local health, healthmax, mana, manamax = UnitHealth(raidid), UnitHealthMax(raidid), UnitMana(raidid), UnitManaMax(raidid);
		frame.Name:SetHeight(15);
		frame.Status:Hide();
		frame.HPBar:Show();
		frame.HPBG:Show();
		frame.MPBar:Show();
		frame.MPBG:Show();
		frame.Name:Show();
		local manaType = UnitPowerType(raidid);
		if ( ( manaType == 0 and not tempOptions["HideMP"] ) or ( manaType > 0 and not tempOptions["HideRP"] and UnitIsPlayer(raidid) ) ) then
			local manaTbl = ManaBarColor[manaType];
			getglobal(frame:GetName() .. "MPBar"):SetStatusBarColor(manaTbl.r, manaTbl.g, manaTbl.b);
			getglobal(frame:GetName() .. "MPBG"):SetVertexColor(manaTbl.r, manaTbl.g, manaTbl.b, tempOptions["BGOpacity"]);
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(37);
				frame.height = 37;
				framecast:SetHeight(37);
			else
				frame:SetHeight(40);
				frame.height = 40;
				framecast:SetHeight(40);
			end
			frame.MPBar:SetMinMaxValues(0, manamax);
			frame.MPBar:SetValue(mana);
		else
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(33);
				frame.height = 33
				framecast:SetHeight(33);
			else
				frame:SetHeight(36);
				frame.height = 36;
				framecast:SetHeight(36);
			end
		end
		if ( health and healthmax and not UnitIsDead(raidid) and not UnitIsGhost(raidid) and UnitIsConnected(raidid) ) then
			if ( tempOptions["ShowHP"] and tempOptions["ShowHP"] <= 4 ) then
				frame.Percent:Show();
			else
				frame.Percent:Hide();
			end
			
			frame.HPBar:SetMinMaxValues(0, healthmax);
			frame.HPBar:SetValue(health);
			
			frame.Percent:SetText(floor(health/healthmax*100+0.5) .. "%");
			local percent = health/healthmax;
			if ( percent >= 0 and percent <= 1 ) then
				local r, g;
				if ( percent > 0.5 ) then
					g = 1;
					r = (1.0 - percent) * 2;
				else
					r = 1;
					g = percent * 2;
				end
				frame.HPBar:SetStatusBarColor(r, g, 0);
				frame.HPBG:SetVertexColor(r, g, 0, tempOptions["BGOpacity"]);
			end
		elseif ( not UnitIsConnected(raidid) ) then
			frame.HPBar:Hide();
			frame.HPBG:Hide();
			frame.Percent:Hide();
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			frame.Status:Show();
			frame.Status:SetText("OFFLINE");
		elseif ( UnitIsDead(raidid) or UnitIsGhost(raidid) ) then
			frame.HPBar:Hide();
			frame.HPBG:Hide();
			frame.Percent:Hide();
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			frame.Status:Show();
			local isFD = CT_RA_CheckFD(UnitName(raidid), raidid);
			if ( isFD == 1 ) then
				frame.Status:SetText("Feign Death");
			elseif ( isFD == 2 ) then
				frame.Status:SetText("SoR");
			else
				frame.Status:SetText("DEAD");
			end
		else
			frame.HPBar:Hide();
			frame.HPBG:Hide();
		end
		frame.Name:SetText(UnitName(raidid));
		frame.Name:SetTextColor(0.5, 1, 0);
		frame.CastFrame.unitName = UnitName(raidid);
	else
		frame.Percent:Hide();
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame.Status:Hide();
		frame.Name:SetText(val);
		frame.Name:SetHeight(30);
		frame.Name:SetTextColor(1, 0.82, 0);
	end
end

function CT_RA_UpdatePTs()
	local tempOptions = CT_RAMenu_Options["temp"];
	CT_RAPTGroupGroupName:SetText("PTargets");
	CT_RAPTGroup:Hide();
	CT_RAPTGroupGroupName:Hide();
	for i = 1, 10, 1 do
		local mem = getglobal("CT_RAPTGroupMember" .. i);
		mem:Hide();
		mem:ClearAllPoints();
		if ( i > 1 ) then
			local above = "CT_RAPTGroupMember" .. (i-1);
			if ( tempOptions["HideBorder"] ) then
				if ( tempOptions["HideSpace"] ) then
					if ( tempOptions["ShowReversed"] ) then
						mem:SetPoint("BOTTOMLEFT", above, "TOPLEFT", 0, -10);
					else
						mem:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, 10);
					end
				else
					if ( tempOptions["ShowReversed"] ) then
						mem:SetPoint("BOTTOMLEFT", above, "TOPLEFT", 0, -7);
					else
						mem:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, 7);
					end
				end
			else
				if ( tempOptions["ShowReversed"] ) then
					mem:SetPoint("BOTTOMLEFT", above, "TOPLEFT", 0, -5);
				else
					mem:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, 4);
				end
			end
		else
			if ( tempOptions["ShowReversed"] ) then
				mem:SetPoint("BOTTOMLEFT", "CT_RAPTGroup", "TOPLEFT", 0, -15);
			else
				mem:SetPoint("TOPLEFT", "CT_RAPTGroup", "TOPLEFT", 0, -20);
			end
		end
	end
	if ( GetNumRaidMembers() == 0 or not CT_RA_PTargets ) then
		CT_RAPTGroupDrag:Hide();
		return;
	end
	local hide = true;
	for key, val in CT_RA_PTargets do
		if ( key <= 10 ) then
			local height = tempOptions["MemberHeight"];
			if ( tempOptions["HideMP"] ) then
				height = height - 4;
			end
			local frame = getglobal("CT_RAPTGroupMember" .. key);
			local frameParent = frame.frameParent;
			local raidid;
			for i = 1, GetNumRaidMembers(), 1 do
				if ( UnitName("raid" .. i) == CT_RA_PTargets[key] ) then
					raidid = "raid" .. i;
					break;
				end
			end
			if ( raidid ) then
				local name, hppercent, mppercent = UnitName(raidid), UnitHealth(raidid)/UnitHealthMax(raidid), UnitMana(raidid)/UnitManaMax(raidid);
				if ( name ~= ( frame.unitName or "" ) or hppercent ~= ( frame.hppercent or -1 ) or mppercent ~= ( frame.mppercent or -1 ) or not UnitIsConnected(raidid) ) then
					if ( not UnitIsConnected(raidid) ) then
						frame.unitName = nil; frame.hppercent = nil; frame.mppercent = nil;
					else
						frame.unitName = name; frame.hppercent = hppercent; frame.mppercent = mppercent;
					end
					CT_RA_UpdatePT(raidid, frame, height, key, val);
				end
				frame:Show();
				frame:GetParent():Show();
			end
			if ( not tempOptions["HideNames"] ) then
				frameCache[frameParent].GroupName:Show();
			else
				frameCache[frameParent].GroupName:Hide();
			end
			if ( not tempOptions["LockGroups"] ) then
				hide = false;
				CT_RAPTGroupDrag:Show();
			end
		end
	end
	if ( hide ) then
		CT_RAPTGroupDrag:Hide();
	end
	CT_RA_UpdatePTTs();
end

function CT_RA_UpdatePTT(raidid, frame, height, key, val)
	local tempOptions = CT_RAMenu_Options["temp"];
	local frameParent = frame.frameParent;
	local currHeight = frameParent:GetHeight();
	local frameName = frame.name;
	if ( tempOptions["HideBorder"] ) then
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -16);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame.HPBG:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame:SetHeight(height-3);
		frame.theight = height-3;
	else
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -18);
		frame:SetHeight(height);
		frame.theight = height;
	end
	if ( raidid and UnitExists(raidid) and UnitIsConnected(raidid) ) then
		frameParent:SetBackdropColor(tempOptions["DefaultColor"].r, tempOptions["DefaultColor"].g, tempOptions["DefaultColor"].b, tempOptions["DefaultColor"].a);
		local health, healthmax, mana, manamax = UnitHealth(raidid), UnitHealthMax(raidid), UnitMana(raidid), UnitManaMax(raidid);
		frame.CastFrame.id = raidid;
		frame.Name:SetHeight(12);
		frame.Status:Hide();
		frame.HPBar:Show();
		frame.HPBG:Show();
		frame.MPBar:Show();
		frame.MPBG:Show();
		frame.Name:Show();
		local manaType = UnitPowerType(raidid);
		if ( ( manaType == 0 and not tempOptions["HideMP"] ) or ( manaType > 0 and not tempOptions["HideRP"] and UnitIsPlayer(raidid) ) ) then
			local manaTbl = ManaBarColor[manaType];
			getglobal(frame:GetName() .. "MPBar"):SetStatusBarColor(manaTbl.r, manaTbl.g, manaTbl.b);
			getglobal(frame:GetName() .. "MPBG"):SetVertexColor(manaTbl.r, manaTbl.g, manaTbl.b, tempOptions["BGOpacity"]);
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(37);
				frame.theight = 37;
				frame.CastFrame:SetHeight(37);
			else
				frame:SetHeight(40);
				frame.theight = 37;
				frame.CastFrame:SetHeight(40);
			end
			frame.MPBar:SetMinMaxValues(0, manamax);
			frame.MPBar:SetValue(mana);
		else
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(33);
				frame.theight = 33;
				frame.CastFrame:SetHeight(33);
			else
				frame:SetHeight(36);
				frame.theight = 36;
				frame.CastFrame:SetHeight(36);
			end
		end
		if ( health and healthmax and not UnitIsDead(raidid) and not UnitIsGhost(raidid) ) then
			if ( tempOptions["ShowHP"] and tempOptions["ShowHP"] <= 4 ) then
				frame.Percent:Show();
			else
				frame.Percent:Hide();
			end
			frame.HPBar:SetMinMaxValues(0, healthmax);
			frame.HPBar:SetValue(health);
			frame.Percent:SetText(floor(health/healthmax*100+0.5) .. "%");
			local percent = health/healthmax;
			if ( percent >= 0 and percent <= 1 ) then
				local r, g;
				if ( percent > 0.5 ) then
					g = 1;
					r = (1.0 - percent) * 2;
				else
					r = 1;
					g = percent * 2;
				end
				frame.HPBar:SetStatusBarColor(r, g, 0);
				frame.HPBG:SetVertexColor(r, g, 0, tempOptions["BGOpacity"]);
			end
		elseif ( UnitIsDead(raidid) or UnitIsGhost(raidid) ) then
			frame.HPBar:Hide();
			frame.HPBG:Hide();
			frame.Percent:Hide();
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			frame.Status:Show();
			frame.Status:SetText("DEAD");
		else
			frame.HPBar:Hide();
			frame.HPBG:Hide();
		end
		frame.Name:SetText(UnitName(raidid));
		if ( UnitCanAttack("player", raidid) ) then
			frame.Name:SetTextColor(1, 0.5, 0);
		else
			frame.Name:SetTextColor(0.5, 1, 0);
		end
		if ( frame:GetHeight() > currHeight ) then
			frame:GetParent():SetHeight(frame:GetHeight());
			frameParent.CastFrame:SetHeight(frame:GetHeight());
		end
	else
		local defaultColors = tempOptions["DefaultColor"];
		frameParent:SetBackdropColor(defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a);
		frame:SetBackdropColor(defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a);
		frame.Percent:Hide();
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame.Status:Hide();
		frame.Name:SetText("<No Target>");
		frame.Name:SetTextColor(1, 0.82, 0);
		frame.Name:SetHeight(30);
	end
end

function CT_RA_UpdatePTTs()
	local tempOptions = CT_RAMenu_Options["temp"];
	for key, val in CT_RA_PTargets do
		if ( key <= 10 ) then
			local height = tempOptions["MemberHeight"];
			if ( tempOptions["HideMP"] ) then
				height = height - 4;
			end
			local frameParent = getglobal("CT_RAPTGroupMember"..key);
			local frame = frameParent.MTTT;
			if ( tempOptions["ShowPTT"] ) then
				local raidid;
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitName("raid" .. i) == CT_RA_PTargets[key] ) then
						raidid = "raid" .. i .. "target";
						break;
					end
				end
				if ( raidid ) then
					frame:Show();
					local name, hppercent, mppercent = UnitName(raidid), UnitHealth(raidid)/UnitHealthMax(raidid), UnitMana(raidid)/UnitManaMax(raidid);
					if ( frame.theight and frame.theight > ( frameParent.height or 0 ) and name ) then
						frameParent:SetHeight(frame.theight);
					elseif ( not frame.theight ) then
						name = nil; -- Force an update
					end
					if ( name ~= ( frame.unitName or "" ) or hppercent ~= ( frame.hppercent or -1 ) or mppercent ~= ( frame.mppercent or -1 ) or not UnitIsConnected(raidid) ) then
						if ( not UnitIsConnected(raidid) ) then
							frame.unitName = nil; frame.hppercent = nil; frame.mppercent = nil;
						else
							frame.unitName = name; frame.hppercent = hppercent; frame.mppercent = mppercent;
						end
						CT_RA_UpdatePTT(raidid, frame, height, key, val);
					end
				end
				frameParent:SetWidth(165);
				CT_RAPTGroupMember1:ClearAllPoints();
				if ( tempOptions["ShowReversed"] ) then
					CT_RAPTGroupMember1:SetPoint("BOTTOMLEFT", "CT_RAPTGroup", "TOPLEFT", -35, -15);
				else
					CT_RAPTGroupMember1:SetPoint("TOPLEFT", "CT_RAPTGroup", "TOPLEFT", -35, -20);
				end
			else
				frame:Hide();
				frameParent:SetWidth(90);
				CT_RAPTGroupMember1:ClearAllPoints();
				if ( tempOptions["ShowReversed"] ) then
					CT_RAPTGroupMember1:SetPoint("BOTTOMLEFT", "CT_RAPTGroup", "TOPLEFT", 0, -15);
				else
					CT_RAPTGroupMember1:SetPoint("TOPLEFT", "CT_RAPTGroup", "TOPLEFT", 0, -20);
				end
			end
		end
	end
end

function CT_RA_AssistMTTT(button)
	local id = this.id;
	if ( not id ) then
		return;
	end
	local stopDefaultBehaviour;
	if ( type(CT_RA_CustomOnClickFunction) == "function" ) then
		stopDefaultBehaviour = CT_RA_CustomOnClickFunction(button, id);
	end
	if ( not stopDefaultBehaviour ) then
		if ( SpellIsTargeting() ) then
			SpellTargetUnit(id);
		else
			TargetUnit(id);
		end
	end
end

function CT_RA_UpdateMTTT(raidid, mtid, frame, height, key, val)
	local tempOptions = CT_RAMenu_Options["temp"];
	local frameParent = frame.frameParent;
	local currHeight = frameParent:GetHeight();
	local frameName = frame.name;
	if ( tempOptions["HideBorder"] ) then
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -16);
		frame.HPBar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame.HPBG:SetPoint("TOPLEFT", frameName, "TOPLEFT", 10, -19);
		frame:SetHeight(height-3);
		frame.theight = height-3;
	else
		frame.Percent:SetPoint("TOP", frameName, "TOPLEFT", 47, -18);
		frame:SetHeight(height);
		frame.height = height;
	end
	if ( raidid and UnitExists(raidid) ) then
		if ( not UnitIsUnit(mtid, raidid) and not tempOptions["HideColorChange"] ) then
			frame:GetParent():SetBackdropColor(1, 0, 0, 1);
		else
			local defaultColors = tempOptions.DefaultColor;
			frame:GetParent():SetBackdropColor(defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a);
		end
		local health, healthmax, mana, manamax = UnitHealth(raidid), UnitHealthMax(raidid), UnitMana(raidid), UnitManaMax(raidid);
		frame.CastFrame.id = raidid;
		frame.Name:SetHeight(12);
		frame.Status:Hide();
		frame.HPBar:Show();
		frame.HPBG:Show();
		frame.MPBar:Show();
		frame.MPBG:Show();
		frame.Name:Show();
		local manaType = UnitPowerType(raidid);
		if ( ( manaType == 0 and not tempOptions["HideMP"] ) or ( manaType > 0 and not tempOptions["HideRP"] and UnitIsPlayer(raidid) ) ) then
			local manaTbl = ManaBarColor[manaType];
			getglobal(frame:GetName() .. "MPBar"):SetStatusBarColor(manaTbl.r, manaTbl.g, manaTbl.b);
			getglobal(frame:GetName() .. "MPBG"):SetVertexColor(manaTbl.r, manaTbl.g, manaTbl.b, tempOptions["BGOpacity"]);
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(37);
				frame.theight = 37;
				frame.CastFrame:SetHeight(37);
			else
				frame:SetHeight(40);
				frame.theight = 40;
				frame.CastFrame:SetHeight(40);
			end
			frame.MPBar:SetMinMaxValues(0, manamax);
			frame.MPBar:SetValue(mana);
		else
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			if ( tempOptions["HideBorder"] ) then
				frame:SetHeight(33);
				frame.theight = 33;
				frame.CastFrame:SetHeight(33);
			else
				frame:SetHeight(36);
				frame.theight = 36;
				frame.CastFrame:SetHeight(36);
			end
		end
		if ( health and healthmax and not UnitIsDead(raidid) and not UnitIsGhost(raidid) ) then
			if ( tempOptions["ShowHP"] and tempOptions["ShowHP"] <= 4 ) then
				frame.Percent:Show();
			else
				frame.Percent:Hide();
			end
			frame.HPBar:SetMinMaxValues(0, healthmax);
			frame.HPBar:SetValue(health);
			frame.Percent:SetText(floor(health/healthmax*100+0.5) .. "%");
			local percent = health/healthmax;
			if ( percent >= 0 and percent <= 1 ) then
				local r, g;
				if ( percent > 0.5 ) then
					g = 1;
					r = (1.0 - percent) * 2;
				else
					r = 1;
					g = percent * 2;
				end
				frame.HPBar:SetStatusBarColor(r, g, 0);
				frame.HPBG:SetVertexColor(r, g, 0, tempOptions["BGOpacity"]);
			end
		elseif ( UnitIsDead(raidid) or UnitIsGhost(raidid) ) then
			frame.HPBar:Hide();
			frame.HPBG:Hide();
			frame.Percent:Hide();
			frame.MPBar:Hide();
			frame.MPBG:Hide();
			frame.Status:Show();
			frame.Status:SetText("DEAD");
		else
			frame.HPBar:Hide();
			frame.HPBG:Hide();
		end
		frame.Name:SetText(UnitName(raidid));
		if ( UnitCanAttack("player", raidid) ) then
			frame.Name:SetTextColor(1, 0.5, 0);
		else
			getglobal(frame:GetName() .. "Name"):SetTextColor(0.5, 1, 0);
		end
		if ( frame:GetHeight() > currHeight ) then
			frameParent:SetHeight(frame:GetHeight());
			frameParent.CastFrame:SetHeight(frame:GetHeight());
		end
	else
		local defaultColors = tempOptions.DefaultColor;
		frame:GetParent():SetBackdropColor(defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a);
		frame:SetBackdropColor(defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a);
		frame.Percent:Hide();
		frame.HPBar:Hide();
		frame.HPBG:Hide();
		frame.MPBar:Hide();
		frame.MPBG:Hide();
		frame.Status:Hide();
		frame.Name:SetText("<No Target>");
		frame.Name:SetTextColor(1, 0.82, 0);
		frame.Name:SetHeight(30);
	end
end

function CT_RA_UpdateMTTTs()
	local tempOptions = CT_RAMenu_Options["temp"];
	for key, val in CT_RA_MainTanks do
		if ( key <= ( tempOptions["ShowNumMTs"] or 10 ) ) then
			local height = tempOptions["MemberHeight"];
			if ( tempOptions["HideMP"] ) then
				height = height - 4;
			end
			local frameParent = getglobal("CT_RAMTGroupMember"..key);
			local frame = frameParent.MTTT
			if ( tempOptions["ShowMTTT"] and not tempOptions["HideMTs"] ) then
				if ( CT_RA_MainTanks[key] ) then
					local raidid, mtid;
					for i = 1, GetNumRaidMembers(), 1 do
						if ( UnitName("raid" .. i) == CT_RA_MainTanks[key] ) then
							raidid = "raid" .. i .. "targettarget";
							mtid = "raid" .. i;
							break;
						end
					end
					if ( raidid and mtid ) then
						frame:Show();
						local name, hppercent, mppercent = UnitName(raidid), UnitHealth(raidid)/UnitHealthMax(raidid), UnitMana(raidid)/UnitManaMax(raidid);
						if ( frame.theight and frame.theight > ( frameParent.height or 0 ) and name ) then
							frameParent:SetHeight(frame.theight);
						elseif ( not frame.theight ) then
							name = nil; -- Force an update
						end
						if ( name ~= ( frame.unitName or "" ) or hppercent ~= ( frame.hppercent or -1 ) or mppercent ~= ( frame.mppercent or -1 ) or not UnitIsConnected(raidid) ) then
							if ( not UnitIsConnected(raidid) ) then
								frame.unitName = nil; frame.hppercent = nil; frame.mppercent = nil;
							else
								frame.unitName = name; frame.hppercent = hppercent; frame.mppercent = mppercent;
							end
							if ( name == UnitName("player") and not UnitIsPlayer(mtid .. "target") ) then
								local isMT;
								for k, v in CT_RA_MainTanks do
									if ( v == UnitName("player") ) then
										isMT = 1;
										break;
									end
								end
								if ( not isMT and not CT_RA_UpdateFrame.hasAggroAlert and tempOptions["AggroNotifier"] ) then
									CT_RA_UpdateFrame.hasAggroAlert = 15;
									CT_RA_WarningFrame:AddMessage("AGGRO FROM " .. UnitName(mtid .. "target") .. "!", 1, 0, 0, 1, UIERRORS_HOLD_TIME);
									if ( tempOptions["AggroNotifierSound"] ) then
										PlaySoundFile("Sound\\Spells\\PVPFlagTakenHorde.wav");
									end
								end
							end
							CT_RA_UpdateMTTT(raidid, mtid, frame, height, key, val);
						end
					end
				end
				frameParent:SetWidth(165);
				CT_RAMTGroupMember1:ClearAllPoints();
				if ( tempOptions["ShowReversed"] ) then
					CT_RAMTGroupMember1:SetPoint("BOTTOMLEFT", "CT_RAMTGroup", "TOPLEFT", -35, -15);
				else
					CT_RAMTGroupMember1:SetPoint("TOPLEFT", "CT_RAMTGroup", "TOPLEFT", -35, -20);
				end
			else
				frame:Hide();
				frameParent:SetWidth(90);
				CT_RAMTGroupMember1:ClearAllPoints();
				if ( tempOptions["ShowReversed"] ) then
					CT_RAMTGroupMember1:SetPoint("BOTTOMLEFT", "CT_RAMTGroup", "TOPLEFT", 0, -15);
				else
					CT_RAMTGroupMember1:SetPoint("TOPLEFT", "CT_RAMTGroup", "TOPLEFT", 0, -20);
				end
			end
		end
	end
end

function CT_RA_UpdateGroupVisibility(num, noStatusUpdate)
	local tempOptions = CT_RAMenu_Options["temp"];
	local group = getglobal("CT_RAGroup" .. num);
	local drag = getglobal("CT_RAGroupDrag" .. num);
	if ( not tempOptions["ShowGroups"] or not tempOptions["ShowGroups"][num] or ( GetNumRaidMembers() == 0 and tempOptions["SORTTYPE"] ~= "virtual" ) or not group.next ) then
		group:Hide();
		drag:Hide();
	elseif ( group.next ) then
		if ( tempOptions["LockGroups"] ) then
			drag:Hide();
		else
			drag:Show();
		end
		if ( tempOptions["HideNames"] ) then
			frameCache[group].GroupName:Hide();
		else
			frameCache[group].GroupName:Show();
		end
		group:Show();
	end
	while ( group.next ) do
		if ( tempOptions["ShowGroups"] and tempOptions["ShowGroups"][num] ) then
			if ( not noStatusUpdate ) then
				CT_RA_UpdateUnitStatus(group.next);
			end
			group.next:Show();
		else
			group.next:Hide();
		end
		group = group.next;
	end
end

function CT_RA_UpdateVisibility(noStatusUpdate)
	for i = 1, 8, 1 do
		CT_RA_UpdateGroupVisibility(i, noStatusUpdate);
	end
	if ( CT_RA_MainTanks ) then
		CT_RA_UpdateMTs();
	end
	if ( CT_RA_PTargets ) then
		CT_RA_UpdatePTs();
	end
end

function CT_RA_UpdateRaidGroup(updateType)
	local tempOptions = CT_RAMenu_Options["temp"];
	local sortType = tempOptions["SORTTYPE"];
	if ( sortType == "group" ) then
		CT_RA_SortByGroup();
	elseif ( sortType == "custom" ) then
		CT_RA_SortByCustom();
	elseif ( sortType == "class" ) then
		CT_RA_SortByClass();
	elseif ( sortType == "virtual" ) then
		CT_RA_SortByVirtual(1);
	end
	local numRaidMembers = GetNumRaidMembers();
	local name, rank, subgroup, level, class, fileName, zone, online, isDead;

	for i=1, MAX_RAID_MEMBERS do
		if ( i <= numRaidMembers or sortType == "virtual" ) then
			local unitid = "raid" .. i;
			name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( not name and sortType == "virtual" ) then
				name, rank, subgroup, level, class, fileName, zone, online, isDead = "Virtual " .. i, 0, floor((i-1)/5)+1, 60, CT_RA_PRIEST, "PRIEST", "Emerald Dream", 1, nil;
			end
			if ( UnitIsDead(unitid) or UnitIsGhost(unitid) ) then
				isDead = 1;
			end
			-- Set Rank
			if ( name == UnitName("player") ) then
				if ( rank >= 2 and CT_RA_Level and CT_RA_Level < 2 ) then
					-- Check if we have to auto-promote people
					for j = 1, numRaidMembers, 1 do
						local pName, pRank = GetRaidRosterInfo(j);
						if ( pRank < 1 and pName and CT_RATab_AutoPromotions and CT_RATab_AutoPromotions[pName] ) then
							PromoteToAssistant(pName);
							CT_RA_Print("<CTRaid> Auto-Promoted |c00FFFFFF" .. pName .. "|r.", 1, 0.5, 0);
						end
					end
				end
				CT_RA_Level = rank;
			end
			local button = getglobal("CT_RAMember" .. i);
			local buttoncast = button.CastFrame;
			local group = button.group;
			if ( group ) then
				if ( tempOptions["ShowGroups"] and tempOptions["ShowGroups"][group.id] ) then
					button.Name:SetText(name);
					button.CastFrame.unitName = name;
					if ( sortType ~= "virtual" or not updateType or updateType == 0 ) then
						if ( button.update or updateType == 0 ) then
							CT_RA_UpdateUnitStatus(button);
						else
							CT_RA_UpdateUnitDead(button);
							local stats = CT_RA_Stats[name];
							if ( updateType == 2 and stats ) then
								CT_RA_UpdateUnitBuffs(stats["Buffs"], button, name);
							end
						end
						button.update = nil;
					else
						CT_RA_UpdateUnitDead(button);
					end
				end
			end
		else
			local btn = getglobal("CT_RAMember"..i);
			btn:Hide();
			btn.next = nil;
		end
	end
	CT_RA_UpdateVisibility(1);
end

function CT_RA_MemberFrame_OnEnter()
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( SpellIsTargeting() ) then
		SetCursor("CAST_CURSOR");
	end
	local parent = this.frameParent;
	local id = parent.id;
	if ( strsub(parent.name, 1, 12) == "CT_RAMTGroup" ) then
		local name;
		if ( CT_RA_MainTanks[id] ) then
			name = CT_RA_MainTanks[id];
		end
		for i = 1, GetNumRaidMembers(), 1 do
			local memberName = GetRaidRosterInfo(i);
			if ( name == memberName ) then
				id = i;
				break;
			end
		end
	elseif ( strsub(parent.name, 1, 12) == "CT_RAPTGroup" ) then
		local name;
		if ( CT_RA_PTargets[id] ) then
			name = CT_RA_PTargets[id];
		end
		for i = 1, GetNumRaidMembers(), 1 do
			local memberName = GetRaidRosterInfo(i);
			if ( name == memberName ) then
				id = i;
				break;
			end
		end
	end
	local unitid = "raid"..id;
	if ( SpellIsTargeting() and not SpellCanTargetUnit(unitid) ) then
		SetCursor("CAST_ERROR_CURSOR");
	end
	if ( tempOptions["HideTooltip"] ) then
		return;
	end
	local xp = "LEFT";
	local yp = "BOTTOM";
	local xthis, ythis = this:GetCenter();
	local xui, yui = UIParent:GetCenter();
	if ( xthis < xui ) then
		xp = "RIGHT";
	end
	if ( ythis < yui ) then
		yp = "TOP";
	end
	GameTooltip:SetOwner(this, "ANCHOR_" .. yp .. xp);
	local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(id);
	local stats = CT_RA_Stats[name];
	local isVirtual;
	if ( not name and tempOptions["SORTTYPE"] == "virtual" ) then
		isVirtual = 1;
		name, level = "Virtual " .. id, 60;
	end
	local version = stats;
	if ( version ) then
		version = version["Version"];
	end
	if ( name == UnitName("player") ) then
		zone = GetRealZoneText();
		version = CT_RA_VersionNumber;
	end
	local color = RAID_CLASS_COLORS[fileName];
	if ( not color ) then
		color = { ["r"] = 1, ["g"] = 1, ["b"] = 1 };
	end
	GameTooltip:AddDoubleLine(name, level, color.r, color.g, color.b, 1, 1, 1);
	if ( UnitRace(unitid) and class ) then
		GameTooltip:AddLine(UnitRace(unitid) .. " " .. class, 1, 1, 1);
	end
	GameTooltip:AddLine(zone, 1, 1, 1);
	
	if ( not version and not isVirtual ) then
		if ( not stats or not stats["Reporting"] ) then
			GameTooltip:AddLine("No CTRA Found", 0.7, 0.7, 0.7);
		else
			GameTooltip:AddLine("CTRA <1.077", 1, 1, 1);
		end
	elseif ( not isVirtual ) then
		GameTooltip:AddLine("CTRA " .. version, 1, 1, 1);
	end

	if ( stats and stats["AFK"] ) then
		if ( type(stats["AFK"][1]) == "string" ) then
			GameTooltip:AddLine("AFK: " .. stats["AFK"][1]);
		end
		GameTooltip:AddLine("AFK for " .. CT_RA_FormatTime(stats["AFK"][2]));
	elseif ( CT_RA_Stats[name] and stats["DND"] ) then
		if ( type(stats["DND"][1]) == "string" ) then
			GameTooltip:AddLine("DND: " .. stats["DND"][1]);
		end
		GameTooltip:AddLine("DND for " .. CT_RA_FormatTime(stats["DND"][2]));
	end
	if ( stats and stats["Offline"] ) then
		GameTooltip:AddLine("Offline for " .. CT_RA_FormatTime(stats["Offline"]));
	elseif ( stats and stats["FD"] ) then
		if ( stats["FD"] < 360 ) then
			GameTooltip:AddLine("Dying in " .. CT_RA_FormatTime(360-stats["FD"]));
		end
	elseif ( stats and stats["Dead"] ) then
		if ( stats["Dead"] < 360 and not UnitIsGhost(unitid) ) then
			GameTooltip:AddLine("Releasing in " .. CT_RA_FormatTime(360-stats["Dead"]));
		else
			GameTooltip:AddLine("Dead for " .. CT_RA_FormatTime(stats["Dead"]));
		end
	end
	if ( stats and stats["Rebirth"] and stats["Rebirth"] > 0 ) then
		GameTooltip:AddLine("Rebirth up in: " .. CT_RA_FormatTime(stats["Rebirth"]));
	elseif ( stats and stats["Reincarnation"] and stats["Reincarnation"] > 0 ) then
		GameTooltip:AddLine("Ankh up in: " .. CT_RA_FormatTime(stats["Reincarnation"]));
	elseif ( stats and stats["Soulstone"] and stats["Soulstone"] > 0 ) then
		GameTooltip:AddLine("Soulstone up in: " .. CT_RA_FormatTime(stats["Soulstone"]));
	end
	GameTooltip:Show();
	CT_RA_CurrentMemberFrame = this;
end

function CT_RA_FormatTime(num)
	num = floor(num + 0.5);
	local hour, min, sec, str = 0, 0, 0, "";

	hour = floor(num/3600);
	min = floor(mod(num, 3600)/60);
	sec = mod(num, 60);
	
	if ( hour > 0 ) then
		str = hour .. "h";
	end

	if ( min > 0 ) then
		if ( strlen(str) > 0 ) then
			str = str .. ", ";
		end
		str = str .. min .. "m";
	end

	if ( sec > 0 or strlen(str) == 0 ) then
		if ( strlen(str) > 0 ) then
			str = str .. ", ";
		end
		str = str .. sec .. "s";
	end
	return str;

end


function CT_RA_Drag_OnEnter()
	CT_RAMenuHelp_SetTooltip();
	GameTooltip:SetText("Click to drag");
end

function CT_RA_RecastBuffButton()
	if ( this.owner and this.name and this.type == "BUFF" ) then
		local spell = CT_RA_ClassSpells[this.name];
		if ( spell ) then
			local targetName = UnitName("target");
			for i = 1, GetNumRaidMembers(), 1 do
				local uId = "raid"..i;
				if ( UnitName(uId) == this.owner ) then
					TargetUnit(uId);
					break;
				end
			end
			local newTargetName = UnitName("target");
			if ( newTargetName == this.owner ) then
				CastSpell(spell["spell"], spell["tab"]+1);
			end
			if ( newTargetName ~= targetName ) then
				TargetLastTarget();
			end
		end
		return;
	elseif ( this.owner and this.name and this.type == "DEBUFF" ) then
		local stats = CT_RA_Stats[this.owner];
		if ( stats ) then
			local debuff = stats["Debuffs"][this.name];
			if ( debuff ) then
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitName("raid" .. i) == this.owner ) then
						CT_RADebuff_CureTarget(debuff[1], this.name, "raid" .. i);
						return;
					end
				end
			end
		end
	end
end

function CT_RA_BuffButton_OnEnter()
	if ( CT_RA_LockPosition ) then return; end
	CT_RAMenuHelp_SetTooltip();
	local left, secure;
	local stats = CT_RA_Stats[this.owner];
	if ( stats and stats["Buffs"][this.name] and stats["Buffs"][this.name][2] ) then
		left = stats["Buffs"][this.name][2];
		if ( stats["Reporting"] and ( stats["Version"] or 0 ) >= 1.38 ) then
			secure = 1;
		end
	end
	if ( this.name and left ) then
		local str;
		if ( left >= 60 ) then
			secs = mod(left, 60);
			mins = (left-secs)/60;
		else
			mins = 0;
			secs = left;
		end
		if ( mins < 0 ) then mins = "00"; elseif ( mins < 10 ) then mins = "0" .. mins; end
		if ( secs < 0 ) then secs = "00"; elseif ( secs < 10 ) then secs = "0" .. secs; end
		if ( not secure ) then
			GameTooltip:SetText(this.name .. " (" .. mins .. ":" .. secs .. "?)");
		else
			GameTooltip:SetText(this.name .. " (" .. mins .. ":" .. secs .. ")");
		end
	elseif ( this.name ) then
		GameTooltip:SetText(this.name);
	end
end

function CT_RA_AssistMT(id)
	if ( CT_RA_MainTanks[id] ) then
		for i = 1, GetNumRaidMembers(), 1 do
			local uId = "raid" .. i;
			if ( UnitName(uId) == CT_RA_MainTanks[id] ) then
				AssistUnit(uId);
				return;
			end
		end
	end
end

function CT_RA_TargetMT(id)
	if ( CT_RA_MainTanks[id] ) then
		for i = 1, GetNumRaidMembers(), 1 do
			local uId = "raid" .. i;
			if (  UnitName(uId) == CT_RA_MainTanks[id] ) then
				TargetUnit(uId);
				return;
			end
		end
	end
end

function CT_RA_AssistPT(id)
	if ( CT_RA_PTargets[id] ) then
		for i = 1, GetNumRaidMembers(), 1 do
			local uId = "raid" .. i;
			if (  UnitName(uId) == CT_RA_PTargets[id] ) then
				AssistUnit(uId);
				return;
			end
		end
	end
end

function CT_RA_TargetPT(id)
	if ( CT_RA_PTargets[id] ) then
		for i = 1, GetNumRaidMembers(), 1 do
			local uId = "raid" .. i;
			if (  UnitName(uId) == CT_RA_PTargets[id] ) then
				TargetUnit(uId);
				return;
			end
		end
	end
end

function CT_RA_MemberFrame_OnClick(button)
	local parent = this.frameParent;
	local id = parent.id;
	local unitid = "raid" .. id;
	if ( strsub(parent.name, 1, 12) == "CT_RAMTGroup" ) then
		for i = 1, GetNumRaidMembers(), 1 do
			local uId = "raid" .. i;
			if ( UnitName(uId) == CT_RA_MainTanks[id] ) then
				AssistUnit(uId);
				return;
			end
		end
	elseif ( strsub(parent.name, 1, 12) == "CT_RAPTGroup" ) then
		for i = 1, GetNumRaidMembers(), 1 do
			local uId = "raid" .. i;
			if ( UnitName(uId) == CT_RA_PTargets[id] ) then
				TargetUnit(uId);
				return;
			end
		end
	end
	
	local stopDefaultBehaviour;
	if ( type(CT_RA_CustomOnClickFunction) == "function" ) then
		stopDefaultBehaviour = CT_RA_CustomOnClickFunction(button, unitid);
	end
	if ( not stopDefaultBehaviour ) then
		if ( SpellIsTargeting() ) then
			SpellTargetUnit(unitid);
		else
			TargetUnit(unitid);
		end
	end
end

function CT_RA_SendStatus()
	CT_RA_Auras = { 
		["buffs"] = { },
		["debuffs"] = { }
	}; -- Reset everything so every buff & debuff is treated as new
	CT_RA_AddMessage("V " .. CT_RA_VersionNumber);
end

function CT_RA_AddToQueue(type, nick, name)
	tinsert(CT_RA_BuffsToCure, { ["type"] = type, ["nick"] = nick, ["name"] = name });
end

function CT_RA_GetDebuff()
	return tremove(CT_RA_BuffsToCure);
end

function CT_RA_GetCure(school)
	local arr = {
		[CT_RA_PRIEST] = { [CT_RA_MAGIC] = CT_RA_DISPELMAGIC, [CT_RA_DISEASE] = { CT_RA_CUREDISEASE, CT_RA_ABOLISHDISEASE } },
		[CT_RA_SHAMAN] = { [CT_RA_DISEASE] = CT_RA_CUREDISEASE, [CT_RA_POISON] = CT_RA_CUREPOISON },
		[CT_RA_DRUID] = { [CT_RA_CURSE] = CT_RA_REMOVECURSE, [CT_RA_POISON] = { CT_RA_CUREPOISON, CT_RA_ABOLISHPOISON } },
		[CT_RA_MAGE] = { [CT_RA_CURSE] = CT_RA_REMOVELESSERCURSE },
		[CT_RA_PALADIN] = { [CT_RA_MAGIC] = CT_RA_CLEANSE, [CT_RA_POISON] = { CT_RA_PURIFY, CT_RA_CLEANSE }, [CT_RA_DISEASE] = { CT_RA_PURIFY, CT_RA_CLEANSE } }
	};
	local playerArr = arr[UnitClass("player")];
	if ( playerArr and playerArr[school] ) then
		local tmp = playerArr[school];
		if ( type(tmp) == "table" ) then
			for i = getn(tmp), 1, -1 do
				if ( CT_RA_ClassSpells[tmp[i]] ) then
					return tmp[i];
				end
			end
			return nil;
		else
			if ( CT_RA_ClassSpells[tmp] ) then
				return tmp;
			else
				return nil;
			end
		end
	end
	return nil;
end

function CT_RA_UpdateRaidGroupColors()
	local tempOptions = CT_RAMenu_Options["temp"];
	local defaultColors = tempOptions["DefaultColor"];
	local r, g, b, a = defaultColors.r, defaultColors.g, defaultColors.b, defaultColors.a;
	for y = 1, 40, 1 do
		local frame = getglobal("CT_RAMember" .. y);
		if ( y <= 5 ) then
			local mt = getglobal("CT_RAMTGroupMember" .. y);
			mt:SetBackdropColor(r, g, b, a);
			mt.Percent:SetTextColor(r, g, b);
			mt = getglobal("CT_RAPTGroupMember" .. y);
			mt:SetBackdropColor(r, g, b, a);
			mt.Percent:SetTextColor(r, g, b);
		end
		if ( not frame.status ) then
			frame:SetBackdropColor(r, g, b, a);
		end
		frame.Percent:SetTextColor(r, g, b);
		local name = UnitName("raid"..y);
		if ( CT_RA_Stats[name] ) then
			CT_RA_UpdateUnitBuffs(CT_RA_Stats[name]["Buffs"], frame, name);
		end
	end
end
function CT_RA_UpdateRaidGroupColors()
	local tempOptions = CT_RAMenu_Options["temp"];
	for y = 1, 40, 1 do
		if ( y <= 5 ) then
			getglobal("CT_RAMTGroupMember" .. y):SetBackdropColor(tempOptions["DefaultColor"].r, tempOptions["DefaultColor"].g, tempOptions["DefaultColor"].b, tempOptions["DefaultColor"].a);
			getglobal("CT_RAMTGroupMember" .. y .. "Percent"):SetTextColor(tempOptions["PercentColor"].r, tempOptions["PercentColor"].g, tempOptions["PercentColor"].b);
		end
		if ( not getglobal("CT_RAMember" .. y).status ) then
			getglobal("CT_RAMember" .. y):SetBackdropColor(tempOptions["DefaultColor"].r, tempOptions["DefaultColor"].g, tempOptions["DefaultColor"].b, tempOptions["DefaultColor"].a);
		end
		getglobal("CT_RAMember" .. y .. "Percent"):SetTextColor(tempOptions["PercentColor"].r, tempOptions["PercentColor"].g, tempOptions["PercentColor"].b);
		if ( CT_RA_Stats[UnitName("raid"..y)] ) then
			CT_RA_UpdateUnitBuffs(CT_RA_Stats[UnitName("raid"..y)]["Buffs"], getglobal("CT_RAMember"..y), UnitName("raid"..y));
		end
	end
end

function CT_RA_UpdateRaidMovability()
	local tempOptions = CT_RAMenu_Options["temp"];
	for i = 1, 8, 1 do
		if ( tempOptions["LockGroups"] or not tempOptions["ShowGroups"] or not tempOptions["ShowGroups"][i] ) then
			getglobal("CT_RAGroupDrag" .. i):Hide();
		else
			if ( getglobal("CT_RAGroup" .. i).next ) then
				getglobal("CT_RAGroupDrag" .. i):Show();
			end
		end
	end
	if ( tempOptions["LockGroups"] or not tempOptions["ShowMTs"] or tempOptions["HideMTs"] ) then
		getglobal("CT_RAMTGroupDrag"):Hide();
	else
		for i = 1, 10, 1 do
			if ( CT_RA_MainTanks[i] ) then
				CT_RAMTGroupDrag:Show();
				break;
			else
				CT_RAMTGroupDrag:Hide();
			end
		end
	end
end

function CT_RA_AddToBuffQueue(name, nick)
	tinsert(CT_RA_BuffsToRecast, { ["name"] = name, ["nick"] = nick });
end

function CT_RA_GetBuff()
	return tremove(CT_RA_BuffsToRecast);
end

function CT_RA_RecastLastBuff()
	local tempOptions = CT_RAMenu_Options["temp"];
	local buff = CT_RA_GetBuff();
	
	while ( buff ) do
		if ( CT_RA_Stats[UnitName(buff["nick"])] and CT_RA_Stats[UnitName(buff["nick"])]["Buffs"][buff["name"]] ) then
			buff = CT_RA_GetBuff();
		else
			CT_RA_LastCastSpell = buff;
			CT_RA_LastCast = GetTime();
			CT_RA_LastCastType = "buff";
			local couldNotCast;
			local i, targetunit, targetname;
			if ( tempOptions["MaintainTarget"] ) then
				-- Check parties
				if ( UnitExists("target") ) then
					for i = 1, 40, 1 do
						if ( UnitIsUnit("raid" ..i, "target") ) then
							targetunit = "raid" .. i;
							break;
						end
					end
					if ( UnitIsUnit("target", "pet" ) ) then
						targetunit = "pet";
					elseif ( UnitIsUnit("target", "player" ) ) then
						targetunit = "player";
					elseif ( not UnitCanAttack("player", "target") ) then
						targetunit = "friend";
						targetname = UnitName("target");
					else
						targetunit = "lastenemy";
					end
				end
				TargetUnit(buff["nick"]);
				if ( not UnitIsUnit("target", buff["nick"]) ) then
					if ( targetunit ) then
						if ( targetunit == "lastenemy" ) then
							TargetLastEnemy();
						elseif ( targetunit == "friend" ) then
							TargetByName(targetname);
						else
							TargetUnit(targetunit);
						end
					else
						ClearTarget();
					end
					return;
				end
			else
				TargetUnit(buff["nick"]);
			end
			if ( buff["name"] and CT_RA_ClassSpells[buff["name"]] ) then
				if ( UnitIsUnit("target", buff["nick"]) ) then
					CastSpell(CT_RA_ClassSpells[buff["name"]]["spell"], CT_RA_ClassSpells[buff["name"]]["tab"]+1);
				end
				if ( SpellIsTargeting() and not SpellCanTargetUnit(buff["nick"]) ) then
					SpellStopTargeting();
					couldNotCast = 1;
				elseif ( SpellIsTargeting() and SpellCanTargetUnit(buff["nick"]) ) then
					SpellStopTargeting();
					tinsert(CT_RA_BuffsToRecast, 1, buff);
				end
			end
			if ( targetunit and tempOptions["MaintainTarget"] ) then
				if ( targetunit == "lastenemy" ) then
					TargetLastEnemy();
				elseif ( targetunit == "friend" ) then
					TargetByName(targetname);
				else
					TargetUnit(targetunit);
				end
			elseif ( tempOptions["MaintainTarget"] ) then
				ClearTarget();
			end
			break;
		end
		buff = couldNotCast;
	end
end

function CT_RA_Print(msg, r, g, b)
	if ( SIMPLE_CHAT == "1" ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
	else
		local oldArgs = {
			event, this, arg1, arg2, arg3, arg4, arg6
		};
		event = "CHAT_MSG_CTRAID";
		arg1 = msg;
		arg2, arg3, arg4, arg6 = "", "", "", "";
		local info = CT_RA_ChatInfo[UnitName("player")];

		if ( not info ) then
			info = CT_RA_ChatInfo["Default"];
		end
		for i = 1, 7, 1 do
			for k, v in info["show"] do
				local frameName = "ChatFrame" .. i;
				if ( v == frameName ) then
					this = getglobal(frameName);
					CT_RA_oldChatFrame_OnEvent(event);
					break;
				end
			end
		end
		event, this, arg1, arg2, arg3, arg4, arg6 = oldArgs[1], oldArgs[2], oldArgs[3], oldArgs[4], oldArgs[5], oldArgs[6], oldArgs[7];
	end
end

function CT_RA_SubSortByName()
	local tempOptions = CT_RAMenu_Options["temp"];
	-- Sort the name of the players in the raid.
	-- Returns an array containing raid roster numbers in player name sequence, followed by unfilled player slots.
	-- Thanks to Dargen of Eternal Keggers for this function
	local temp;
	local subsort = {};
	local count;
	local name;
	count = GetNumRaidMembers();
	if ( not tempOptions["SubSortByName"] ) then
		for i = 1, MAX_RAID_MEMBERS, 1 do
			subsort[i] = {};
			subsort[i][1] = i;
		end
		return subsort;
	end
	local playerName = UnitName("player");
	for i = 1, MAX_RAID_MEMBERS, 1 do
		subsort[i] = {};
		subsort[i][1] = i;
		if ( i <= count ) then
			name = UnitName("raid" .. i);
			if ( not name ) then name = playerName; end
			if ((name == nil) or (name == UNKNOWNOBJECT) or (name == UKNOWNBEING)) then name = ""; end
			subsort[i][2] = name;
		else
			subsort[i][2] = "";
		end
	end
	local swap;
	for j = 1, count - 1, 1 do
		swap = false;
		for i = 1, count - j, 1 do
			if ( subsort[i][2] > subsort[i+1][2] ) then
				-- Swap
				temp = subsort[i];
				subsort[i] = subsort[i+1];
				subsort[i+1] = temp;
				swap = true;
			end
		end
		if ( not swap ) then
			break;
		end
	end
	return subsort;
end

function CT_RA_SortByClass()
	local tempOptions = CT_RAMenu_Options["temp"];
	CT_RA_SetSortType("class");
	CT_RA_ButtonIndexes = { };
	CT_RA_CurrPositions = { };
	local groupnum = 1;
	local membernum = 1;
	
	for k, v in CT_RA_ClassPositions do
		if ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) then
			getglobal("CT_RAOptionsGroup" .. v .. "Label"):SetText(k);
		end
	end
	for i = 1, 40, 1 do
		if ( i <= 8 ) then
			getglobal("CT_RAGroup" .. i).next = nil;
			getglobal("CT_RAGroup" .. i).num = 0;
		end
		getglobal("CT_RAMember" .. i).next = nil;
	end
	local subsort = CT_RA_SubSortByName();
	for j = 1, GetNumRaidMembers(), 1 do
		i = subsort[j][1];
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if ( class and CT_RA_ClassPositions[class] ) then
			local group = getglobal("CT_RAGroup" .. CT_RA_ClassPositions[class]);
			if ( name ) then
				CT_RA_CurrPositions[name] = { CT_RA_ClassPositions[class], i };
			end
			local button = getglobal("CT_RAMember" .. i);
			getglobal(group:GetName() .. "GroupName"):SetText(class);
			local modifier = 0.5;
			if ( not online ) then
				modifier = 0.3;
			end
			getglobal("CT_RAOptionsGroupButton" .. i .."Texture"):SetVertexColor(modifier, modifier, modifier);
			getglobal("CT_RAOptionsGroupButton" .. i .."Rank"):SetTextColor(modifier, modifier, modifier);
			getglobal("CT_RAOptionsGroupButton" .. i .."Name"):SetTextColor(modifier, modifier, modifier);
			getglobal("CT_RAOptionsGroupButton" .. i .."Level"):SetTextColor(modifier, modifier, modifier);
			getglobal("CT_RAOptionsGroupButton" .. i .."Class"):SetTextColor(modifier, modifier, modifier);
			if ( not tempOptions["HideOffline"] or online ) then
				button:ClearAllPoints();
				local new, newName;
				if ( group.next and group.next ~= button ) then
					new = group;
					while ( new.next ) do
						if ( new.next ) then
							new = new.next;
						end
					end
					newName = new.name;
					group.num = group.num + 1;
					if ( tempOptions["ShowHorizontal"] ) then
						if ( tempOptions["HideBorder"] ) then
							if ( tempOptions["HideSpace"] ) then
								button:SetPoint("LEFT", newName, "RIGHT", -10, 0);
							else
								button:SetPoint("LEFT", newName, "RIGHT", -8, 0);
							end
						else
							button:SetPoint("LEFT", newName, "RIGHT", -2, 0);
						end
					else
						if ( tempOptions["HideBorder"] ) then
							if ( tempOptions["HideSpace"] ) then
								if ( tempOptions["ShowReversed"] ) then
									button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -10);
								else
									button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 10);
								end
							else
								if ( tempOptions["ShowReversed"] ) then
									button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -7);
								else
									button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 7);
								end
							end
						else
							if ( tempOptions["ShowReversed"] ) then
								button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -5);
							else
								button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 4);
							end
						end
					end
				else
					group.num = 1;
					new = group;
					button:ClearAllPoints();
					if ( tempOptions["ShowReversed"] ) then
						button:SetPoint("BOTTOMLEFT", group:GetName(), "TOPLEFT", 0, -15);
					else
						button:SetPoint("TOPLEFT", group:GetName(), "TOPLEFT", 0, -20);
					end
				end
				new.next = button;
				button.group = group;
			end
		end
	end
end

function CT_RA_SortByGroup()
	local tempOptions = CT_RAMenu_Options["temp"];
	CT_RA_SetSortType("group");
	CT_RA_ButtonIndexes = { };
	CT_RA_CurrPositions = { };
	local groupnum = 1;
	local membernum = 1;
	for i = 1, 40, 1 do
		if ( i <= 8 ) then
			local group = getglobal("CT_RAGroup"..i);
			group.next = nil;
			group.num = 0;
			local label = getglobal("CT_RAOptionsGroup" .. i .. "Label");
			if ( label ) then
				label:SetText("Group " .. i);
			end
		end
		getglobal("CT_RAMember" .. i).next = nil;
	end
	local subsort = CT_RA_SubSortByName();
	for j = 1, GetNumRaidMembers(), 1 do
		i = subsort[j][1];
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if ( ( not tempOptions["HideOffline"] or online ) and ( CT_RA_Stats[name] or not tempOptions["HideNA"] ) ) then
			local groupid = subgroup;
			if ( name and CT_RA_CurrPositions[name] ) then
				groupid = CT_RA_CurrPositions[name][1];
			elseif ( name ) then
				CT_RA_CurrPositions[name] = { subgroup, j };
			end
			local group = getglobal("CT_RAGroup" .. groupid);
			frameCache[group].GroupName:SetText("Group " .. subgroup);
			local text = getglobal("CT_RAOptionsGroupButton" .. i .."Texture");
			if ( text ) then
				text:SetVertexColor(1.0, 1.0, 1.0);
			end

			local button = getglobal("CT_RAMember" .. i);
			local new, newName;
			button:ClearAllPoints();
			if ( group.next and group.next ~= button ) then
				new = group;
				while ( new.next ) do
					if ( new.next ) then
						new = new.next;
					end
				end
				newName = new.name;
				group.num = group.num + 1;
				if ( tempOptions["ShowHorizontal"] ) then
					if ( tempOptions["HideBorder"] ) then
						if ( tempOptions["HideSpace"] ) then
							button:SetPoint("LEFT", newName, "RIGHT", -10, 0);
						else
							button:SetPoint("LEFT", newName, "RIGHT", -8, 0);
						end
					else
						button:SetPoint("LEFT", newName, "RIGHT", -2, 0);
					end
				else
					if ( tempOptions["HideBorder"] ) then
						if ( tempOptions["HideSpace"] ) then
							if ( tempOptions["ShowReversed"] ) then
								button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -10);
							else
								button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 10);
							end
						else
							if ( tempOptions["ShowReversed"] ) then
								button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -7);
							else
								button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 7);
							end
						end
					else
						if ( tempOptions["ShowReversed"] ) then
							button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -5);
						else
							button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 4);
						end
					end
				end
			else
				group.num = 1;
				new = group;
				button:ClearAllPoints();
				if ( tempOptions["ShowReversed"] ) then
					button:SetPoint("BOTTOMLEFT", group.name, "TOPLEFT", 0, -15);
				else
					button:SetPoint("TOPLEFT", group.name, "TOPLEFT", 0, -20);
				end
			end
			new.next = button;
			button.group = group;
		end
	end
end

function CT_RA_SortByVirtual(updateStatus)
	local tempOptions = CT_RAMenu_Options["temp"];
	CT_RA_SetSortType("virtual");
	local groupnum = 1;
	local membernum = 1;
	local availableSlots = {
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0,
		[7] = 0,
		[8] = 0
	};
	for i = 1, 40, 1 do
		if ( i <= GetNumRaidMembers() ) then
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			availableSlots[subgroup] = availableSlots[subgroup] + 1;
		end
		if ( i <= 8 ) then
			local group = getglobal("CT_RAGroup"..i);
			group.next = nil;
			group.num = 0;
			local label = getglobal("CT_RAOptionsGroup" .. i .. "Label");
			if ( label ) then
				label:SetText("Virtual " .. i);
			end
		end
		getglobal("CT_RAMember" .. i).next = nil;
	end
	local subsort = CT_RA_SubSortByName();
	for j = 1, 40, 1 do
		local i = subsort[j][1];
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		local isVirtual;
		if ( not name ) then
			isVirtual = 1;
			name, rank, level, class, fileName, zone, online, isDead = "Virtual " .. i, 0, 60, CT_RA_PRIEST, "PRIEST", "Emerald Dream", 1, nil;
			for i = 1, 8, 1 do
				if ( availableSlots[i] < 5 ) then
					availableSlots[i] = availableSlots[i] + 1;
					subgroup = i;
					break;
				end
			end
		end
		local groupid = subgroup;
		local group = getglobal("CT_RAGroup" .. groupid);
		frameCache[group].GroupName:SetText("Virtual " .. subgroup);
		local text = getglobal("CT_RAOptionsGroupButton" .. i .."Texture");
		if ( text ) then
			text:SetVertexColor(1.0, 1.0, 1.0);
		end

		local button = getglobal("CT_RAMember" .. i);
		local new, newName;
		if ( group.next and group.next ~= button ) then
			new = group;
			while ( new.next ) do
				new = new.next;
			end
			newName = new.name;
			group.num = group.num + 1;
			button:ClearAllPoints();
			if ( tempOptions["ShowHorizontal"] ) then
				if ( tempOptions["HideBorder"] ) then
					if ( tempOptions["HideSpace"] ) then
						button:SetPoint("LEFT", newName, "RIGHT", -10, 0);
					else
						button:SetPoint("LEFT", newName, "RIGHT", -8, 0);
					end
				else
					button:SetPoint("LEFT", newName, "RIGHT", -2, 0);
				end
			else
				if ( tempOptions["HideBorder"] ) then
					if ( tempOptions["HideSpace"] ) then
						if ( tempOptions["ShowReversed"] ) then
							button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -10);
						else
							button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 10);
						end
					else
						if ( tempOptions["ShowReversed"] ) then
							button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -7);
						else
							button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 7);
						end
					end
				else
					if ( tempOptions["ShowReversed"] ) then
						button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -5);
					else
						button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 4);
					end
				end
			end
		else
			group.num = 1;
			new = group;
			button:ClearAllPoints();
			if ( tempOptions["ShowReversed"] ) then
				button:SetPoint("BOTTOMLEFT", group.name, "TOPLEFT", 0, -15);
			else
				button:SetPoint("TOPLEFT", group.name, "TOPLEFT", 0, -20);
			end
		end
		new.next = button;
		button.group = group;
		group:Show();
		CT_RA_UpdateGroupVisibility(groupid, 1);
		if ( not updateStatus ) then
			CT_RA_UpdateUnitStatus(button);
		end
	end
end

function CT_RA_SortByCustom()
	local tempOptions = CT_RAMenu_Options["temp"];
	tempOptions["SORTTYPE"] = "custom";
	local groupnum = 1;
	local membernum = 1;
	for i = 1, 40, 1 do
		if ( i <= 8 ) then
			local group = getglobal("CT_RAGroup" .. i);
			group.next = nil;
			group.num = 0;
			local label = getglobal("CT_RAOptionsGroup" .. i .. "Label");
			if ( label ) then
				label:SetText("Custom " .. i);
			end
		end
		getglobal("CT_RAMember" .. i).next = nil;
	end
	local subsort = CT_RA_SubSortByName();
	for j = 1, GetNumRaidMembers(), 1 do
		local i = subsort[j][1];
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		local text = getglobal("CT_RAOptionsGroupButton" .. i .."Texture");
		if ( text ) then
			text:SetVertexColor(1.0, 1.0, 1.0);
		end
		if ( ( not tempOptions["HideOffline"] or online ) and ( CT_RA_Stats[name] or not tempOptions["HideNA"] ) ) then
			if ( name and CT_RA_CurrPositions[name] ) then
				subgroup = CT_RA_CurrPositions[name][1];
			elseif ( name ) then
				for y = 1, 8, 1 do
					local group = getglobal("CT_RAGroup" .. y);
					if ( not group.num or group.num < 5 ) then
						subgroup = y;
						CT_RA_CurrPositions[name] = { y, j };
						break;
					end
				end
			end
			if ( name ) then
				local group = getglobal("CT_RAGroup" .. subgroup);
				local button = getglobal("CT_RAMember" .. i);
				frameCache[group].GroupName:SetText("Custom " .. subgroup);
				button:ClearAllPoints();
				local new, newName;
				if ( group.next and group.next ~= button ) then
					new = group;
					while ( new.next ) do
						if ( new.next ) then
							new = new.next;
						end
					end
					newName = new.name;
					group.num = group.num + 1;
					button:ClearAllPoints();
					if ( tempOptions["ShowHorizontal"] ) then
						if ( tempOptions["HideBorder"] ) then
							if ( tempOptions["HideSpace"] ) then
								button:SetPoint("LEFT", newName, "RIGHT", -10, 0);
							else
								button:SetPoint("LEFT", newName, "RIGHT", -8, 0);
							end
						else
							button:SetPoint("LEFT", newName, "RIGHT", -2, 0);
						end
					else
						if ( tempOptions["HideBorder"] ) then
							if ( tempOptions["HideSpace"] ) then
								if ( tempOptions["ShowReversed"] ) then
									button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -10);
								else
									button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 10);
								end
							else
								if ( tempOptions["ShowReversed"] ) then
									button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -7);
								else
									button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 7);
								end
							end
						else
							if ( tempOptions["ShowReversed"] ) then
								button:SetPoint("BOTTOMLEFT", newName, "TOPLEFT", 0, -5);
							else
								button:SetPoint("TOPLEFT", newName, "BOTTOMLEFT", 0, 4);
							end
						end
					end
				else
					group.num = 1;
					new = group;
					button:ClearAllPoints();
					if ( tempOptions["ShowReversed"] ) then
						button:SetPoint("BOTTOMLEFT", group.name, "TOPLEFT", 0, -15);
					else
						button:SetPoint("TOPLEFT", group.name, "TOPLEFT", 0, -20);
					end
				end
				new.next = button;
				button.group = group;
			end
		end
	end
end

function CT_RA_LinkDrag(frame, drag, point, relative, x, y)
	frame:ClearAllPoints();
	frame:SetPoint(point, drag:GetName(), relative, x, y);
end

CT_RA_ConvertedRaid = 1;
CT_RA_HasInvited = { };

local CT_RA_GameTooltip_ClearMoney;

local function CT_RA_MoneyToggle()
	if( CT_RA_GameTooltip_ClearMoney ) then
		GameTooltip_ClearMoney = CT_RA_GameTooltip_ClearMoney;
		CT_RA_GameTooltip_ClearMoney = nil;
	else
		CT_RA_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = CT_RA_GameTooltipFunc_ClearMoney;
	end
end

function CT_RA_GameTooltipFunc_ClearMoney()

end

function CT_RA_GetBuffIndex(name, filter)
	local i = 0;
	local buffIndex, untilCancelled = GetPlayerBuff(i, filter);
	while ( buffIndex ~= -1 ) do
		CT_RA_MoneyToggle();
		CT_RATooltip:SetPlayerBuff(buffIndex);
		CT_RA_MoneyToggle();
		local tooltipName = CT_RATooltipTextLeft1:GetText();
		if ( tooltipName and name == tooltipName ) then
			return buffIndex;
		end
		i = i + 1;
		buffIndex, untilCancelled = GetPlayerBuff(i, filter);
	end
	return nil;
end
	

function CT_RA_UpdateFrame_OnUpdate(elapsed)
	if ( this.showDialog ) then
		this.showDialog = this.showDialog - elapsed;
		if ( this.showDialog <= 0 ) then
			if ( CT_RAChanges_DisplayDialog ) then
				CT_RAChanges_DisplayDialog();
			end
			this.showDialog = nil;
		end
	end
	
	if ( this.lastInvite ) then
		this.lastInvite = this.lastInvite - elapsed;
		if ( this.lastInvite <= 0 ) then
			this.lastInvite = nil;
			this.inviteName = nil;
		end
	end
	if ( this.invite ) then
		this.invite = this.invite - elapsed;
		if ( this.invite <= 0 ) then
			if ( not CT_RA_ConvertedRaid ) then
				GuildRoster();
				CT_RA_ConvertedRaid = 1;
				ConvertToRaid();
				this.invite = 3;
			else
				CT_RA_InviteGuild(CT_RA_MinLevel, CT_RA_MaxLevel);
				this.invite = nil;
			end
		end
	end
	if ( this.startinviting ) then
		this.startinviting = this.startinviting - elapsed;
		if ( this.startinviting <= 0 ) then
			this.startinviting = nil;
			CT_RA_HasInvited = { };
			if ( GetNumRaidMembers() == 0 ) then
				CT_RA_ConvertedRaid = nil;
			else
				CT_RA_ConvertedRaid = 1;
			end
			local inZone = "";
			if ( CT_RA_ZoneInvite ) then
				inZone = " from " .. GetRealZoneText();
			end
			local numInvites = CT_RA_InviteGuild(CT_RA_MinLevel, CT_RA_MaxLevel);
			if ( CT_RA_MinLevel == CT_RA_MaxLevel ) then
				CT_RA_Print("<CTRaid> " .. numInvites .. " Guild Members of level |c00FFFFFF" .. CT_RA_MinLevel .. "|r have been invited" .. inZone .. ".", 1, 0.5, 0);
			else
				CT_RA_Print("<CTRaid> " .. numInvites .. " Guild Members of levels |c00FFFFFF" .. CT_RA_MinLevel .. "|r to |c00FFFFFF" .. CT_RA_MaxLevel .. "|r have been invited" .. inZone .. ".", 1, 0.5, 0);
			end
		end
	end
	if ( this.closeroster ) then
		this.closeroster = this.closeroster - elapsed;
		if ( this.closeroster <= 0 ) then
			HideUIPanel(FriendsFrame);
			this.closeroster = nil;
		end
	end
	if ( this.joinchan ) then
		this.joinchan = this.joinchan - elapsed;
		if ( this.joinchan <= 0 ) then
			CT_RA_Channel = this.newchan;
			CT_RA_Join(CT_RA_Channel);
			this.joinchan = nil;
			this.newchan = nil;
		end
	end
	
	-- Only run the ones below if we're in a raid.
	if ( CT_RA_NumRaidMembers == 0 ) then
		return;
	end
	
	this.mouseOverUpdate = this.mouseOverUpdate - elapsed;
	if ( this.mouseOverUpdate <= 0 ) then
		this.mouseOverUpdate = 0.1;
		if ( CT_RA_CurrentMemberFrame ) then
			local parent = CT_RA_CurrentMemberFrame.frameParent;
			if ( SpellIsTargeting() and ( strsub(parent.name, 1, 12) == "CT_RAMTGroup" or SpellCanTargetUnit("raid" .. parent.id) ) ) then
				SetCursor("CAST_CURSOR");
			elseif ( SpellIsTargeting() ) then
				SetCursor("CAST_ERROR_CURSOR");
			end
		end
	end
	
	if ( this.hasAggroAlert ) then
		this.hasAggroAlert = this.hasAggroAlert - elapsed;
		if ( this.hasAggroAlert <= 0 ) then
			this.hasAggroAlert = nil;
		end
	end
	this.updateAFK = this.updateAFK + elapsed;
	if ( this.updateAFK >= 1 ) then
		this.updateAFK = this.updateAFK - 1;
		for k, v in CT_RA_Stats do
			if ( v["AFK"] ) then
				v["AFK"][2] = v["AFK"][2] + 1;
			end
			if ( v["DND"] ) then
				v["DND"][2] = v["DND"][2] + 1;
			end
			if ( v["Dead"] ) then
				v["Dead"] = v["Dead"] + 1;
			end
			if ( v["Offline"] ) then
				v["Offline"] = v["Offline"] + 1;
			end
			if ( v["FD"] ) then
				v["FD"] = v["FD"] + 1;
			end
			if ( v["Rebirth"] ) then
				v["Rebirth"] = v["Rebirth"] - 1;
			end
			if ( v["Reincarnation"] ) then
				v["Reincarnation"] = v["Reincarnation"] - 1;
			end
			if ( v["Soulstone"] ) then
				v["Soulstone"] = v["Soulstone"] - 1;
			end
		end
	end

	this.update = this.update + elapsed;
	if ( this.update >= 1 ) then
		for k, v in CT_RA_BuffTimeLeft do
			local buffIndex, buffTimeLeft, buffName;
			buffIndex = CT_RA_GetBuffIndex(k, "HELPFUL");
			if ( buffIndex ) then
				buffTimeLeft = GetPlayerBuffTimeLeft(buffIndex);
				if ( buffTimeLeft ) then
					if ( abs(CT_RA_BuffTimeLeft[k]-buffTimeLeft) >= 2 ) then
						local index, num;
						for key, val in CT_RAMenu_Options["temp"]["BuffArray"] do
							if ( type(val["name"]) == "table" ) then
								if ( k == val["name"][1] ) then
									buffName = k;
									index, num = key, 1;
									break;
								elseif ( k == val["name"][2] ) then
									buffName = k;
									index, num = key, 2;
									break;
								end
							elseif ( val["name"] == k ) then
								buffName = k;
								index, num = key, 0;
								break;
							end
						end
						if ( not index and not num ) then
							if ( k == CT_RA_FEIGNDEATH[CT_RA_GetLocale()] ) then
								buffName = CT_RA_FEIGNDEATH[CT_RA_GetLocale()];
								index, num = 0, 0;
							end
						end
						if ( index and num ) then
							local playerName = UnitName("player");
							local stats = CT_RA_Stats[playerName];
							if ( not stats ) then
								CT_RA_Stats[playerName] = {
									["Buffs"] = { },
									["Debuffs"] = { },
									["Position"] = { }
								};
								stats = CT_RA_Stats[playerName];
							end
							stats["Buffs"][buffName] = { string.find(GetPlayerBuffTexture(buffIndex), "([%w_&]+)$"), floor(buffTimeLeft+0.5) };
							CT_RA_AddMessage("RN " .. floor(buffTimeLeft+0.5) .. " " .. index .. " " .. num);
						end
					end
					CT_RA_BuffTimeLeft[k] = buffTimeLeft;
				end
			end
		end
		for k, v in CT_RA_Stats do
			if ( v["Buffs"] ) then
				for key, val in v["Buffs"] do
					if ( type(val) == "table" and val[2] ) then
						val[2] = val[2] - 1;
					end
				end
			end
		end		
		this.update = this.update - 1;
	end
	if ( this.time ) then
		this.time = this.time - elapsed;
		if ( this.time <= 0 ) then
			if ( CT_RA_Channel ) then
				this.time = nil;
				CT_RA_AddMessage("SR");
				if ( CT_RA_VersionNumber ) then
					CT_RA_AddMessage("V " .. CT_RA_VersionNumber);
				end
			else
				this.time = 5;
			end
		end
		if ( this.SS ) then
			this.SS = nil;
		end
	end

	if ( this.SS ) then
		this.SS = this.SS - elapsed;
		if ( this.SS <= 0 ) then
			if ( CT_RA_Channel ) then
				this.SS = nil;
				CT_RA_AddMessage("SR");
				if ( CT_RA_VersionNumber ) then
					CT_RA_AddMessage("V " .. CT_RA_VersionNumber);
				end
			else
				this.SS = 5;
			end
		end
	end
	if ( this.scheduleUpdate ) then
		this.scheduleUpdate = this.scheduleUpdate - elapsed;
		if ( this.scheduleUpdate <= 0 ) then
			if ( CT_RA_InCombat ) then
				this.scheduleUpdate = 1;
			else
				this.scheduleUpdate = nil;
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitIsUnit("raid" .. i, "player") ) then
						local useless, useless, subgroup = GetRaidRosterInfo(i);
						this.updateDelay = subgroup;
						return;
					end
				end
			end
		end
	end
	if ( this.scheduleMTUpdate ) then
		this.scheduleMTUpdate = this.scheduleMTUpdate - elapsed;
		if ( this.scheduleMTUpdate <= 0 ) then
			this.scheduleMTUpdate = nil;
			if ( CT_RA_IsSendingWithVersion(1.08) ) then
				for k, v in CT_RA_MainTanks do
					CT_RA_AddMessage("SET " .. k .. " " .. v);
				end
			end
		end
	end
	if ( this.updateDelay ) then
		this.updateDelay = this.updateDelay - elapsed;
		if ( this.updateDelay <= 0 ) then
			this.updateDelay = nil;
			CT_RA_SendStatus();
			CT_RA_UpdateRaidGroup(1);
		end
	end
	if ( this.voteTimer ) then
		this.voteTimer = this.voteTimer - elapsed;
		if ( this.voteTimer <= 0 ) then
			if ( CT_RA_VotePerson ) then
				local numCount = 0;
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitIsConnected("raid" .. i) ) then
						numCount = numCount + 1;
					end
				end
				local noVotes = numCount-(CT_RA_VotePerson[2]+CT_RA_VotePerson[3]+1);
				local yesPercent, noPercent, noVotePercent = 0, 0, 0;
				if ( CT_RA_VotePerson[2] > 0 ) then
					yesPercent = floor(CT_RA_VotePerson[2]/(CT_RA_VotePerson[2]+CT_RA_VotePerson[3]+noVotes)*100+0.5);
				end
				if ( CT_RA_VotePerson[3] > 0 ) then
					noPercent = floor(CT_RA_VotePerson[3]/(CT_RA_VotePerson[2]+CT_RA_VotePerson[3]+noVotes)*100+0.5);
				end
				if ( yesPercent+noPercent < 100 ) then
					noVotePercent = 100-(yesPercent+noPercent);
				end
				CT_RA_Print("<CTRaid> Vote results for \"|c00FFFFFF" .. CT_RA_VotePerson[4] .. "|r\": |c00FFFFFF" .. CT_RA_VotePerson[2] .. "|r (|c00FFFFFF" .. yesPercent .. "%|r) Yes / |c00FFFFFF" .. CT_RA_VotePerson[3] .. "|r (|c00FFFFFF" .. noPercent .. "%|r) No / |c00FFFFFF" .. noVotes .. "|r (|c00FFFFFF" .. noVotePercent .. "%|r) did not vote.", 1, 0.5, 0);
				SendChatMessage("<CTRaid> Vote results for \"" .. CT_RA_VotePerson[4] .. "\": " .. CT_RA_VotePerson[2] .. " (" .. yesPercent .. "%) Yes / " .. CT_RA_VotePerson[3] .. " (" .. noPercent .. "%) No / " .. noVotes .. " (" .. noVotePercent .. "%) did not vote.", "RAID");
				CT_RA_VotePerson = nil;
			end
			this.voteTimer = nil;
		end
	end
	if ( this.readyTimer ) then
		this.readyTimer = this.readyTimer - elapsed;
		if ( this.readyTimer <= 0 ) then
			CT_RA_CheckReady_Person = nil;
			this.readyTimer = nil;
			local numNotReady, numAfk = 0, 0
			local notReadyString, afkString = "", "";
			for k, v in CT_RA_Stats do
				if ( v["notready"] and v["notready"] == 2 ) then
					numNotReady = numNotReady + 1;
					if ( strlen(notReadyString) > 0 ) then
						notReadyString = notReadyString .. ", ";
					end
					notReadyString = notReadyString .. "|c00FFFFFF" .. k .. "|r";
				elseif ( v["notready"] and v["notready"] == 1 ) then
					numAfk = numAfk + 1;
					if ( strlen(afkString) > 0 ) then
						afkString = afkString .. ", ";
					end
					afkString = afkString .. "|c00FFFFFF" .. k .. "|r";
				end
				CT_RA_Stats[k]["notready"] = nil;
			end
			if ( numNotReady > 0 ) then
				if ( numNotReady == 1 ) then
					CT_RA_Print("<CTRaid> " .. notReadyString .. " is not ready.", 1, 1, 0);
				elseif ( numNotReady >= 8 ) then
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numNotReady .. "|r raid members are not ready.", 1, 1, 0);
				else
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numNotReady .. "|r raid members (" .. notReadyString .. ") are not ready.", 1, 1, 0);
				end
				CT_RA_UpdateRaidGroup(1);
			end
			if ( numAfk > 0 ) then
				if ( numAfk == 1 ) then
					CT_RA_Print("<CTRaid> " ..afkString .. " is away from keyboard.", 1, 1, 0);
				elseif ( numAfk >= 8 ) then
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numAfk.. "|r raid members are away from keyboard.", 1, 1, 0);
				else
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numAfk .. "|r raid members (" .. afkString .. ") are away from keyboard.", 1, 1, 0);
				end
				CT_RA_UpdateRaidGroup(1);
			end
		end
	end
	if ( this.rlyTimer ) then
		this.rlyTimer = this.rlyTimer - elapsed;
		if ( this.rlyTimer <= 0 ) then
			this.rlyTimer = nil;
			local numNotReady, numAfk = 0, 0
			local notReadyString, afkString = "", "";
			for k, v in CT_RA_Stats do
				if ( v["rly"] and v["rly"] == 2 ) then
					numNotReady = numNotReady + 1;
					if ( strlen(notReadyString) > 0 ) then
						notReadyString = notReadyString .. ", ";
					end
					notReadyString = notReadyString .. "|c00FFFFFF" .. k .. "|r";
				elseif ( v["rly"] and v["rly"] == 1 ) then
					numAfk = numAfk + 1;
					if ( strlen(afkString) > 0 ) then
						afkString = afkString .. ", ";
					end
					afkString = afkString .. "|c00FFFFFF" .. k .. "|r";
				end
				CT_RA_Stats[k]["rly"] = nil;
			end
			if ( numNotReady > 0 ) then
				if ( numNotReady == 1 ) then
					CT_RA_Print("<CTRaid> " .. notReadyString .. " says |c00FFFFFFNO WAI!|r.", 1, 1, 0);
				elseif ( numNotReady >= 8 ) then
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numNotReady .. "|r raid members say |c00FFFFFFNO WAI!|r.", 1, 1, 0);
				else
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numNotReady .. "|r raid members (" .. notReadyString .. ") say |c00FFFFFFNO WAI!|r.", 1, 1, 0);
				end
				CT_RA_UpdateRaidGroup(1);
			end
			if ( numAfk > 0 ) then
				if ( numAfk == 1 ) then
					CT_RA_Print("<CTRaid> " ..afkString .. " says nothing.", 1, 1, 0);
				elseif ( numAfk >= 8 ) then
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numAfk.. "|r raid members say nothing.", 1, 1, 0);
				else
					CT_RA_Print("<CTRaid> |c00FFFFFF" .. numAfk .. "|r raid members (" .. afkString .. ") say nothing.", 1, 1, 0);
				end
				CT_RA_UpdateRaidGroup(1);
			end
		end
	end
	if ( CT_RA_Squelch > 0 ) then
		CT_RA_Squelch = CT_RA_Squelch - elapsed;
		if ( CT_RA_Squelch <= 0 ) then
			CT_RA_Squelch = 0;
			CT_RA_Print("<CTRaid> Quiet Mode has been automatically disabled (timed out).", 1, 0.5, 0);
		end
	end
	if ( this.updateMT ) then
		this.updateMT = this.updateMT - elapsed;
		if ( this.updateMT <= 0 ) then
			this.updateMT = 0.25;
			CT_RA_UpdateMTs();
			CT_RA_UpdatePTs();
		end
	end
	for k, v in CT_RA_CurrDebuffs do
		CT_RA_CurrDebuffs[k][1] = CT_RA_CurrDebuffs[k][1] - elapsed;
		if ( CT_RA_CurrDebuffs[k][1] < 0 ) then
			local _, _, name, dType = string.find(k, "^([^@]+)@(.+)$");
			local msg = "";
			if ( GetBindingKey("CT_CUREDEBUFF") and CT_RA_GetCure(dType) ) then
				msg = " Press '|c00FFFFFF" .. GetBindingText(GetBindingKey("CT_CUREDEBUFF"), "KEY_") .. "|r' to cure";
			end
			if ( name == dType ) then
				dType = "";
			else
				dType = " (|c00FFFFFF" .. dType .. "|r)";
			end
			if ( CT_RA_CurrDebuffs[k][2] == 1 ) then
				CT_RA_Print("<CTRaid> |c00FFFFFF" .. CT_RA_CurrDebuffs[k][4] .. "|r has been debuffed by '|c00FFFFFF" .. name .. "|r'" .. dType .. msg .. ".", 1, 0.5, 0);
			else
				CT_RA_Print("<CTRaid> |c00FFFFFF" .. CT_RA_CurrDebuffs[k][2] .. "|r players have been debuffed by '|c00FFFFFF" .. name .. "|r'" .. dType .. msg .. ".", 1, 0.5, 0);
			end
			CT_RA_CurrDebuffs[k] = nil;
		end
	end
end
function CT_RA_UpdateFrame_OnEvent(event)
	if ( event == "PARTY_MEMBERS_CHANGED" ) then
		if ( not CT_RA_ConvertedRaid ) then
			this.invite = 3;
		end
	elseif ( event == "CHAT_MSG_SYSTEM" ) then
		local _, _, name = string.find(arg1, "^([^%s]+) is already in a group%.$");
		if ( name and this.inviteName and this.inviteName == name ) then
			this.inviteName = nil;
			this.lastInvite = nil;
			SendChatMessage("<CTRaid> You are already grouped.", "WHISPER", nil, name);
		end
	end
end

function CT_RA_InviteGuild(min, max)
	local offline = GetGuildRosterShowOffline();
	local selection = GetGuildRosterSelection();
	SetGuildRosterShowOffline(0);
	SetGuildRosterSelection(0);
	GetGuildRosterInfo(0);
	local inviteBeforeRaid = 4-GetNumPartyMembers();
	local numInvites = 0;
	local numGuildMembers = GetNumGuildMembers();
	CT_RA_UpdateFrame.closeroster = 2;
	local RealZoneText = GetRealZoneText();
	if (RealZoneText == nil) then RealZoneText = "?"; end
	local playerName = UnitName("player");
	for i = 1, numGuildMembers, 1 do
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
		if ( level >= min and level <= max and name ~= playerName and not CT_RA_HasInvited[i] and online ) then
			if ( zone == nil ) then zone = "???"; end
			if ( not CT_RA_ZoneInvite or ( CT_RA_ZoneInvite and zone == RealZoneText ) ) then
				CT_RA_HasInvited[i] = 1;
				InviteByName(name);
				numInvites = numInvites + 1;
				if ( numInvites == inviteBeforeRaid and not CT_RA_ConvertedRaid ) then 
					CT_RA_UpdateFrame.invite = 1.5;
					break;
				end
			end
		end
	end
	SetGuildRosterShowOffline(offline);
	SetGuildRosterSelection(selection);
	return numInvites;
end

function CT_RA_ProcessMessages(elapsed)
	if ( this.flush ) then
		this.flush = this.flush - elapsed;
		if ( this.flush <= 0 ) then
			this.flush = 1;
			this.numMessagesSent = 0;
		end
	end
	if ( this.elapsed ) then
		this.elapsed = this.elapsed - elapsed;
		if ( this.elapsed <= 0 ) then
			if ( getn(CT_RA_Comm_MessageQueue) > 0 and this.numMessagesSent < 4 ) then
				CT_RA_SendMessageQueue();
			end
			this.elapsed = 0.1;
		end
	end
end
function CT_RA_SendMessageQueue()
	local retstr = "";
	local numSent = 0;
	
	for key, val in CT_RA_Comm_MessageQueue do
		if ( strlen(retstr)+strlen(val)+1 > 255 ) then
			CT_RA_SendMessage(retstr, 1);
			this.numMessagesSent = this.numMessagesSent + 1;
			tremove(CT_RA_Comm_MessageQueue, key);
			if ( this.numMessagesSent == 4 ) then
				return;
			end
			retstr = "";
		end
		if ( retstr ~= "" ) then
			retstr = retstr .. "#";
		end
		retstr = retstr .. val;
	end
	if ( retstr ~= "" ) then
		CT_RA_SendMessage(retstr, 1);
		this.numMessagesSent = this.numMessagesSent + 1;
	end
	CT_RA_Comm_MessageQueue = { };
end

function CT_RA_Split(msg, char)
	local arr = { };
	while (string.find(msg, char) ) do
		local iStart, iEnd = string.find(msg, char);
		tinsert(arr, strsub(msg, 1, iStart-1));
		msg = strsub(msg, iEnd+1, strlen(msg));
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg);
	end
	return arr;
end

function CT_RA_IsSendingWithVersion(version)
	local playerName = UnitName("player");
	local names = { };
	if ( not CT_RA_Level or CT_RA_Level < 1 ) then
		return nil;
	end
	for i = 1, GetNumRaidMembers(), 1 do
		local name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(i);
		local stats = CT_RA_Stats[name];
		if ( rank >= 1 and name ~= playerName and stats and stats["Version"] and stats["Version"] >= version and name < playerName ) then
			return nil;
		end
	end
	return 1;
end

function CT_RA_ScanPartyAuras(unit)
	local name = UnitName(unit);
	if ( not name ) then
		return;
	end
	local id = string.gsub(unit, "^raid(%d+)$", "%1");
	local stats = CT_RA_Stats[name];
	if ( not stats ) then
		CT_RA_Stats[name] = {
			["Buffs"] = { },
			["Debuffs"] = { },
			["Position"] = { }
		};
		stats = CT_RA_Stats[name];
		CT_RA_ScanUnitBuffs(unit, name, id);
		CT_RA_ScanUnitDebuffs(unit, name, id);
		CT_RA_UpdateUnitBuffs(CT_RA_Stats[name]["Buffs"], getglobal("CT_RAMember" .. id), name);
	else
		local num, numDebuffs, debuff = 0, 0, UnitDebuff(unit, 1);
		numDebuffs, debuff = 0, UnitDebuff(unit, 1);
		while ( debuff ) do
			numDebuffs = numDebuffs + 1;
			debuff = UnitDebuff(unit, numDebuffs+1);
		end
		if ( getn(CT_RA_Stats[name]["Debuffs"]) ~= numDebuffs ) then 
			-- Debuffs
			CT_RA_ScanUnitDebuffs(unit, name, id);
		else
			CT_RA_ScanUnitBuffs(unit, name, id);
			local isFD = CT_RA_CheckFD(name, "raid" .. id);
			if ( isFD > 0 ) then
				CT_RA_UpdateUnitDead(getglobal("CT_RAMember" .. id));
			end
		end
		CT_RA_UpdateUnitBuffs(CT_RA_Stats[name]["Buffs"], getglobal("CT_RAMember" .. id), name);
	end
end

function CT_RA_CheckFD(name, unit)
	local class = UnitClass(unit);
	if ( class ~= CT_RA_HUNTER and class ~= CT_RA_PRIEST ) then
		return 0;
	end
	local hasFD = 0;
	local num, buff = 0, UnitBuff(unit, 1);
	while ( buff ) do
		if ( buff == "Interface\\Icons\\Ability_Rogue_FeignDeath" ) then
			hasFD = 1;
			break;
		elseif ( buff == "Interface\\Icons\\Spell_Holy_GreaterHeal" ) then
			hasFD = 2;
			break;
		end
		num = num + 1;
		buff = UnitBuff(unit, num+1);
	end
	return hasFD;
end

function CT_RA_ScanUnitBuffs(unit, name, id)
	local tempOptions = CT_RAMenu_Options["temp"];
	local oldAuras = { };
	local stats = CT_RA_Stats[name]["Buffs"];
	for k, v in stats do
		oldAuras[k] = 1;
	end
	table.setn(stats, 0);
	local num, buff = 0, UnitBuff(unit, 1);
	local duplicateTextures = {
		["Interface\\Icons\\Spell_Nature_Regeneration"] = true,
		["Interface\\Icons\\Spell_Nature_LightningShield"] = true
	};
	while ( buff ) do
		num = num + 1;
		local buffName;
		-- Only check matching if it's not used by anything else
		if ( not duplicateTextures[buff] ) then
			for k, v in CT_RA_BuffTextures do
				if ( "Interface\\Icons\\" .. v[1] == buff ) then
					buffName = k;
					break;
				end
			end
		else
			CT_RATooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
			CT_RATooltipTextLeft1:SetText("");
			CT_RATooltip:SetUnitBuff(unit, num);
			local tooltipName = CT_RATooltipTextLeft1:GetText();
			if ( strlen(tooltipName or "") > 0 and CT_RA_BuffTextures[tooltipName] ) then
				buffName = tooltipName;
			end
		end
		if ( buffName ) then
			local buffT = CT_RA_BuffTextures[buffName];
			if ( not stats[buffName] ) then
				stats[buffName] = { buff, buffT[2] };
				if ( UnitIsUnit(unit, "player") ) then
					CT_RA_BuffTimeLeft[buffName] = buffT[2];
				end
			end
			table.setn(stats, getn(stats)+1);
			oldAuras[buffName] = nil;
		end
		buff = UnitBuff(unit, num+1);
	end
	for k, v in oldAuras do
		stats[k] = nil;
		local buffTbl;
		for key, val in tempOptions["BuffArray"] do
			if ( k == val["name"] ) then
				buffTbl = val;
				break;
			end
		end
		if ( buffTbl ) then
			local uId = "raid" .. id;
			if ( not UnitIsDead(uId) and UnitIsVisible(uId) and not tempOptions["NotifyDebuffs"]["hidebuffs"] and k ~= CT_RA_POWERWORDSHIELD and k ~= CT_RA_ADMIRALSHAT ) then
				if ( buffTbl["show"] ~= -1 ) then
					local currPos = CT_RA_CurrPositions[name];
					if ( currPos ) then
						if ( tempOptions["NotifyDebuffs"][currPos[1]] and tempOptions["NotifyDebuffsClass"][CT_RA_ClassPositions[UnitClass("raid" .. currPos[2])]] ) then
							if ( CT_RA_ClassSpells and CT_RA_ClassSpells[k] and GetBindingKey("CT_RECASTRAIDBUFF") ) then
								if ( GetBindingKey("CT_RECASTRAIDBUFF") ) then
									CT_RA_AddToBuffQueue(k, uId);
									CT_RA_Print("<CTRaid> '|c00FFFFFF" .. name .. "|r's '|c00FFFFFF" .. k .. "|r' has faded. Press '|c00FFFFFF" .. GetBindingText(GetBindingKey("CT_RECASTRAIDBUFF"), "KEY_") .. "|r' to recast.", 1, 0.5, 0);
								else
									CT_RA_Print("<CTRaid> '|c00FFFFFF" .. name .. "|r's '|c00FFFFFF" .. k .. "|r' has faded.", 1, 0.5, 0);
								end
							end
						end
					end
				end
			end
		end
	end
end

function CT_RA_ScanUnitDebuffs(unit, name, id)
	local tempOptions = CT_RAMenu_Options["temp"];
	local oldAuras = { };
	local stats = CT_RA_Stats[name]["Debuffs"];
	for k, v in stats do
		oldAuras[k] = 1;
	end
	table.setn(stats, 0);
	local num, debuff = 0, UnitDebuff(unit, 1);
	while ( debuff ) do
		table.setn(stats, getn(stats)+1);
		num = num + 1;
		local debuffName;
		CT_RATooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
		CT_RATooltipTextLeft1:SetText("");
		CT_RATooltipTextRight1:SetText("");
		CT_RATooltip:SetUnitDebuff(unit, num);
		local tooltipName, dType = CT_RATooltipTextLeft1:GetText(), CT_RATooltipTextRight1:GetText();
		if ( tooltipName and strlen(tooltipName) > 0 ) then
			debuffName = tooltipName;
		end
		if ( debuffName ) then
			oldAuras[debuffName] = nil;
			if ( not stats[debuffName] ) then
				if ( debuffName == CT_RA_WEAKENEDSOUL ) then
					dType = CT_RA_WEAKENEDSOUL;
				elseif ( debuffName == CT_RA_RECENTLYBANDAGED ) then
					dType = CT_RA_RECENTLYBANDAGED;
				end
				local debuffType;
				for k, v in tempOptions["DebuffColors"] do
					if ( dType == v["type"] ) then
						debuffType = v;
						break;
					end
				end
				if ( debuffType ) then
					local uId = "raid" .. id;
					stats[debuffName] = { dType, 0, gsub(debuff, "^Interface\\Icons\\(.+)$", "%1") };
					if ( CastParty_AddDebuff ) then
						CastParty_AddDebuff(uId, dType);
					end
					if ( tempOptions["NotifyDebuffs"]["main"] and debuffName ~= CT_RA_RECENTLYBANDAGED and debuffName ~= CT_RA_MINDVISION and debuffType["id"] ~= -1 ) then
						local currPos = CT_RA_CurrPositions[name];
						if ( currPos ) then
							if ( tempOptions["NotifyDebuffs"][currPos[1]] and tempOptions["NotifyDebuffsClass"][CT_RA_ClassPositions[UnitClass(uId)]] ) then
								CT_RA_AddToQueue(dType, uId);
								CT_RA_AddDebuffMessage(debuffName, dType, name);
							end
						end
					end
				end
			end
		end
		debuff = UnitDebuff(unit, num+1);
	end
	for k, v in oldAuras do
		stats[k] = nil;
	end
end

function CT_RA_ShowHideDebuffs()
	local tempOptions = CT_RAMenu_Options["temp"];
	tempOptions["ShowDebuffs"] = not tempOptions["ShowDebuffs"];
	if ( tempOptions["ShowDebuffs"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 2);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show debuffs");
	elseif ( tempOptions["ShowBuffsDebuffed"] ) then
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 3);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs until debuffed");
	else
		UIDropDownMenu_SetSelectedID(CT_RAMenuFrameBuffsBuffsDropDown, 1);
		CT_RAMenuFrameBuffsBuffsDropDownText:SetText("Show buffs");
	end
	CT_RA_UpdateRaidGroup(2);
end

-- Thanks to Darco for the idea & some of the code
CT_RA_OldChatFrame_OnEvent = ChatFrame_OnEvent;
function CT_RA_NewChatFrame_OnEvent(event)
	if ( event == "CHAT_MSG_SYSTEM" ) then
		local iStart, iEnd, sName, iID, iDays, iHours, iMins, iSecs = string.find(arg1, "(.+) %(ID=(%w+)%): (%d+)d (%d+)h (%d+)m (%d+)s");
		if ( sName ) then
			local table = date("*t");
			table["sec"] = table["sec"] + (tonumber(iDays) * 86400) + (tonumber(iHours) * 3600) + (tonumber(iMins) * 60) + iSecs;
			arg1 = arg1 .. " ("..date("%A %b %d, %I:%M%p", time(table)) .. ")";
		end
	elseif ( event == "CHAT_MSG_WHISPER_INFORM" ) then
		if ( arg1 == "<CTRaid> You are already grouped." or string.find(arg1, "<CTRaid> Quiet mode is enabled in the raid%. Please be quiet%. %d+ seconds remaining%.") ) then
			return;
		end
	end
	CT_RA_OldChatFrame_OnEvent(event);
end

ChatFrame_OnEvent = CT_RA_NewChatFrame_OnEvent;

local oldDialogs = { };
oldDialogs["RESURRECTSHOW"] = StaticPopupDialogs["RESURRECT"].OnShow;
oldDialogs["RESURRECT_NO_SICKNESSSHOW"] = StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnShow;
oldDialogs["RESURRECT_NO_TIMERSHOW"] = StaticPopupDialogs["RESURRECT_NO_TIMER"].OnShow;
oldDialogs["DEATHSHOW"] = StaticPopupDialogs["DEATH"].OnShow;

StaticPopupDialogs["RESURRECT"].OnShow = function() oldDialogs["RESURRECTSHOW"]() CT_RA_AddMessage("RESSED") end;
StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnShow = function() oldDialogs["RESURRECT_NO_SICKNESSSHOW"]() CT_RA_AddMessage("RESSED") end;
StaticPopupDialogs["RESURRECT_NO_TIMER"].OnShow = function() oldDialogs["RESURRECT_NO_TIMERSHOW"]() CT_RA_AddMessage("RESSED") end;
StaticPopupDialogs["RESURRECT"].OnHide = function() CT_RA_AddMessage("NORESSED") end;
StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnHide = function() CT_RA_AddMessage("NORESSED") end;
StaticPopupDialogs["RESURRECT_NO_TIMER"].OnHide = function() if ( not StaticPopup_FindVisible("DEATH") ) then CT_RA_AddMessage("NORESSED") end end;
StaticPopupDialogs["DEATH"].OnShow = function() oldDialogs["DEATHSHOW"]() if ( HasSoulstone() ) then CT_RA_AddMessage("CANRES") end end;

CT_RA_OldStaticPopup_OnShow = StaticPopup_OnShow;
function CT_RA_NewStaticPopup_OnShow()
	if ( this.which and strsub(this.which, 1, 9) == "RESURRECT" ) then
		CT_RA_AddMessage("RESSED");
	end
	CT_RA_OldStaticPopup_OnShow();
end
StaticPopup_OnShow = CT_RA_NewStaticPopup_OnShow;

function CT_RA_ResFrame_DropDown_OnClick()
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( this.id == 2 ) then
		tempOptions["LockMonitor"] = not tempOptions["LockMonitor"];
	elseif ( this.id == 4 ) then
		tempOptions["ShowMonitor"] = nil;
		CT_RA_ResFrame:Hide();
	end
end

function CT_RA_ResFrame_InitButtons()
	local tempOptions = CT_RAMenu_Options["temp"];
	local dropdown, info;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end

	info = {};
	info.text = "Resurrection Monitor";
	info.isTitle = 1;
	info.justifyH = "CENTER";
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info = { };
	if ( tempOptions["LockMonitor"] ) then
		info.text = "Unlock Window";
	else
		info.text = "Lock Window";
	end
	info.notCheckable = 1;
	info.func = CT_RA_ResFrame_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = "Background Color";
	info.hasColorSwatch = 1;
	info.hasOpacity = 1;
	if ( tempOptions["RMBG"] ) then
		info.r = ( tempOptions["RMBG"].r );
		info.g = ( tempOptions["RMBG"].g );
		info.b = ( tempOptions["RMBG"].b );
		info.opacity = ( tempOptions["RMBG"].a );
	else
		info.r = 0;
		info.g = 0;
		info.b = 1;
		info.opacity = 0.5;
	end
	info.notClickable = 1;
	info.swatchFunc = CT_RA_ResFrame_DropDown_SwatchFunc;
	info.opacityFunc = CT_RA_ResFrame_DropDown_OpacityFunc;
	info.cancelFunc = CT_RA_ResFrame_DropDown_CancelFunc;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = "Hide";
	info.notCheckable = 1;
	info.func = CT_RA_ResFrame_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);

end

function CT_RA_ResFrame_DropDown_SwatchFunc()
	local tempOptions = CT_RAMenu_Options["temp"];
	local r, g, b = ColorPickerFrame:GetColorRGB();
	if ( not tempOptions["RMBG"] ) then
		tempOptions["RMBG"] = { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 0 };
	else
		tempOptions["RMBG"]["r"] = r;
		tempOptions["RMBG"]["g"] = g;
		tempOptions["RMBG"]["b"] = b;
	end
	CT_RA_ResFrame:SetBackdropColor(r, g, b, tempOptions["RMBG"]["a"]);
	CT_RA_ResFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["RMBG"]["a"]);
end

function CT_RA_ResFrame_DropDown_OpacityFunc()
	local tempOptions = CT_RAMenu_Options["temp"];
	local r, g, b = 1, 1, 1;
	if ( tempOptions["RMBG"] ) then
		r, g, b = tempOptions["RMBG"].r, tempOptions["RMBG"].g, tempOptions["RMBG"].b;
	end
	local a = OpacitySliderFrame:GetValue();
	tempOptions["RMBG"]["a"] = a;
	CT_RA_ResFrame:SetBackdropColor(r, g, b, a);
	CT_RA_ResFrame:SetBackdropBorderColor(1, 1, 1, a);
end

function CT_RA_ResFrame_DropDown_CancelFunc(val)
	local tempOptions = CT_RAMenu_Options["temp"];
	tempOptions["RMBG"] = { 
		["r"] = val.r,
		["g"] = val.g,
		["b"] = val.b,
		["a"] = val.opacity
	};
	CT_RA_ResFrame:SetBackdropColor(val.r, val.g, val.b, val.opacity);
	CT_RA_ResFrame:SetBackdropBorderColor(1, 1, 1, val.opacity);
end

function CT_RA_ResFrame_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RA_ResFrame_InitButtons, "MENU");
end

function CT_RA_SendReady()
	CT_RA_AddMessage("READY");
end

function CT_RA_SendNotReady()
	CT_RA_AddMessage("NOTREADY");
end

function CT_RA_SendYes()
	CT_RA_AddMessage("VOTEYES");
end

function CT_RA_SendNo()
	CT_RA_AddMessage("VOTENO");
end

function CT_RA_SendRly()
	CT_RA_AddMessage("YARLY");
end

function CT_RA_SendNoRly()
	CT_RA_AddMessage("NORLY");
end

function CT_RA_ReadyFrame_OnUpdate(elapsed)
	if ( this.hide ) then
		this.hide = this.hide - elapsed;
		if ( this.hide <= 0 ) then
			this:Hide();
		end
	end
end

function CT_RA_ToggleGroupSort(skipCustom)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( tempOptions["SORTTYPE"] == "group" ) then
		CT_RA_SetSortType("class");
	elseif ( tempOptions["SORTTYPE"] == "class" and not skipCustom ) then
		CT_RA_SetSortType("custom");
	else
		CT_RA_SetSortType("group");
	end

	CT_RA_UpdateRaidGroup(3);
	CT_RA_UpdateMTs();
	CT_RA_UpdatePTs();
	CT_RAOptions_Update();
end

function CT_RA_SetSortType(sort_type)
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( sort_type == "class" ) then
		tempOptions["SORTTYPE"] = "class";
		if ( CT_RAMenuFrameGeneralMiscDropDown and CT_RAMenuFrame:IsVisible() ) then
			UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralMiscDropDown, 2);
		end
		if ( CT_RAMenuFrameGeneralMiscDropDownText ) then
			CT_RAMenuFrameGeneralMiscDropDownText:SetText("Class");
		end
	elseif ( sort_type == "custom" ) then
		tempOptions["SORTTYPE"] = "custom";
		if ( CT_RAMenuFrameGeneralMiscDropDown and CT_RAMenuFrame:IsVisible() ) then
			UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralMiscDropDown, 3);
		end
		if ( CT_RAMenuFrameGeneralMiscDropDownText ) then
			CT_RAMenuFrameGeneralMiscDropDownText:SetText("Custom");
		end
	elseif ( sort_type == "virtual" ) then
		tempOptions["SORTTYPE"] = "virtual";
		if ( CT_RAMenuFrameGeneralMiscDropDown and CT_RAMenuFrame:IsVisible() ) then
			UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralMiscDropDown, 4);
		end
		if ( CT_RAMenuFrameGeneralMiscDropDownText ) then
			CT_RAMenuFrameGeneralMiscDropDownText:SetText("Virtual");
		end
	else
		tempOptions["SORTTYPE"] = "group";
		if ( CT_RAMenuFrameGeneralMiscDropDown and CT_RAMenuFrame:IsVisible() ) then
			UIDropDownMenu_SetSelectedID(CT_RAMenuFrameGeneralMiscDropDown, 1);
		end
		if ( CT_RAMenuFrameGeneralMiscDropDownText ) then
			CT_RAMenuFrameGeneralMiscDropDownText:SetText("Group");
		end
	end
end

function CT_RA_DragAllWindows(start)
	local id = this:GetID();
	if ( start ) then
		local group = getglobal("CT_RAGroupDrag" .. id);
		local x, y = group:GetLeft(), group:GetTop();

		if ( not x or not y ) then
			return;
		end
		for i = 1, 8, 1 do
			if ( i ~= id ) then
				local oGroup = getglobal("CT_RAGroup" .. i);
				local oX, oY = oGroup:GetLeft(), oGroup:GetTop();
				if ( oX and oY ) then
					oGroup:ClearAllPoints();
					oGroup:SetPoint("TOPLEFT", "CT_RAGroupDrag" .. id, "TOPLEFT", oX-x, oY-y);
				end
			end
		end
	else
		for i = 1, 8, 1 do
			if ( i ~= id ) then
				local oGroup = getglobal("CT_RAGroupDrag" .. id);
				local oX, oY = oGroup:GetLeft(), oGroup:GetTop();
				if ( oX and oY ) then
					oGroup:ClearAllPoints();
					oGroup:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", oX, oY-UIParent:GetTop());
				end
			end
		end
	end
end

function CT_RA_CheckGroups()
	if ( GetNumRaidMembers() == 0 ) then
		return;
	end
	local numPartyMembers = GetNumPartyMembers();
	if ( not CT_RA_PartyMembers ) then
		CT_RA_PartyMembers = { };
		if ( UnitName("party" .. numPartyMembers) ) then
			for i = 1, numPartyMembers, 1 do
				CT_RA_PartyMembers[UnitName("party"..i)] = i;
			end
		end
		return;
	end
	local joined, left, numleft, numjoin = "", "", 0, 0;
	if ( not UnitName("party" .. numPartyMembers) and numPartyMembers > 0 ) then
		CT_RA_PartyMembers = { };
		return;
	end
	for i = 1, numPartyMembers, 1 do
		local uName = UnitName("party" .. i);
		if ( uName and not CT_RA_PartyMembers[uName] ) then
			if ( numjoin > 0 ) then
				joined = joined .. "|r, |c00FFFFFF";
			end
			joined = joined .. uName;
			numjoin = numjoin + 1;
		end
		CT_RA_PartyMembers[uName] = nil;
	end

	for k, v in CT_RA_PartyMembers do
		if ( numleft > 0 ) then
			left = left .. "|r, |c00FFFFFF";
		end
		left = left .. k;
		numleft = numleft + 1;
	end
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( tempOptions["NotifyGroupChange"] and ( numjoin > 0 or numleft > 0 ) ) then
		if ( tempOptions["NotifyGroupChangeSound"] ) then
			PlaySoundFile("Sound\\Spells\\Thorns.wav");
		end
		if ( numjoin > 1 ) then
			CT_RA_Print("<CTRaid> |c00FFFFFF" .. joined .. "|r have joined your party.", 1, 0.5, 0);
		elseif ( numjoin == 1 ) then
			CT_RA_Print("<CTRaid> |c00FFFFFF" .. joined .. "|r has joined your party.", 1, 0.5, 0);
		end
		if ( numleft > 1 ) then
			CT_RA_Print("<CTRaid> |c00FFFFFF" .. left .. "|r have left your party.", 1, 0.5, 0);
		elseif ( numleft == 1 ) then
			CT_RA_Print("<CTRaid> |c00FFFFFF" .. left .. "|r has left your party.", 1, 0.5, 0);
		end
	end
	CT_RA_PartyMembers = { };
	for i = 1, numPartyMembers, 1 do
		local uName = UnitName("party" .. i);
		if ( uName ) then
			CT_RA_PartyMembers[uName] = 1;
		end
	end
end

function CT_RA_Emergency_UpdateHealth()
	local tempOptions = CT_RAMenu_Options["temp"];
	local numRaidMembers = GetNumRaidMembers();
	if ( not tempOptions["ShowEmergency"] or ( numRaidMembers == 0 and not tempOptions["ShowEmergencyOutsideRaid"] ) ) then
		CT_RA_EmergencyFrame:Hide();
		return;
	else
		CT_RA_EmergencyFrame:Show();
	end
	for i = 1, 5, 1 do
		CT_RA_EmergencyFrame["frame"..i]:Hide();
	end
	CT_RA_EmergencyFrame.maxPercent = nil;
	local healthThreshold = tempOptions["EMThreshold"];
	if ( not healthThreshold ) then
		healthThreshold = 0.9;
	end
	CT_RA_Emergency_Units = { };
	local health;
	if ( not tempOptions["ShowEmergencyParty"] and GetNumRaidMembers() > 0 ) then
		health = CT_RA_Emergency_RaidHealth;
		health = { };
		local numMembers = GetNumRaidMembers();
		for i = 1, numMembers, 1 do
			local uId = "raid" .. i;
			local curr, max = UnitHealth(uId), UnitHealthMax(uId);
			if ( curr and max and curr/max <= healthThreshold ) then
				tinsert(health, { curr, max, uId, i, curr/max });
			end
		end
	else
		health = { };
		for i = 1, GetNumPartyMembers(), 1 do
			local uId = "party" .. i;
			local curr, max = UnitHealth(uId), UnitHealthMax(uId);
			if ( curr and max and curr/max <= healthThreshold) then
				tinsert(health, { curr, max, uId, nil, curr/max });
			end
		end
		local curr, max = UnitHealth("player"), UnitHealthMax("player");
		if ( curr/max <= healthThreshold ) then
			tinsert(health, { curr, max, "player", nil, curr/max });
		end
	end
	
	table.sort(
		health, 
		function(v1, v2)
			return v1[5] < v2[5];
		end
	);
	CT_RA_EmergencyFrameTitle:Show();
	CT_RA_EmergencyFrameDrag:Show();
	local nextFrame = 0;
	for k, v in health do
		if ( not UnitIsDead(v[3]) and not UnitIsGhost(v[3]) and UnitIsConnected(v[3]) and UnitIsVisible(v[3]) and ( not CT_RA_Stats[UnitName(v[3])] or not CT_RA_Stats[UnitName(v[3])]["Dead"] ) and ( not tempOptions["EMClasses"] or not tempOptions["EMClasses"][UnitClass(v[3])] ) ) then
			local name, rank, subgroup, level, class, fileName;
			local obj = CT_RA_EmergencyFrame["frame" .. (nextFrame+1)];
			if ( GetNumRaidMembers() > 0 and not tempOptions["ShowEmergencyParty"] and v[4] ) then
				name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(v[4]);
				local colors = RAID_CLASS_COLORS[fileName];
				if ( colors ) then
					obj.Name:SetTextColor(colors.r, colors.g, colors.b);
				end
			else
				obj.Name:SetTextColor(1, 1, 1);
			end
			if ( not subgroup or not tempOptions["EMGroups"] or not tempOptions["EMGroups"][subgroup] ) then
				nextFrame = nextFrame + 1;
				obj:Show();
				CT_RA_EmergencyFrame.maxPercent = v[5];
				CT_RA_Emergency_Units[UnitName(v[3])] = 1;
				obj.ClickFrame.unitid = v[3];
				obj.HPBar:SetMinMaxValues(0, v[2]);
				obj.HPBar:SetValue(v[1]);
				obj.Name:SetText(UnitName(v[3]));
				obj.Deficit:SetText(v[1]-v[2]);
				
				if ( UnitIsUnit(v[3], "player") ) then
					obj.HPBar:SetStatusBarColor(1, 0, 0);
					obj.HPBG:SetVertexColor(1, 0, 0, tempOptions["BGOpacity"]);
				elseif ( UnitInParty(v[3]) ) then
					obj.HPBar:SetStatusBarColor(0, 1, 1);
					obj.HPBG:SetVertexColor(0, 1, 1, tempOptions["BGOpacity"]);
				else
					obj.HPBar:SetStatusBarColor(0, 1, 0);
					obj.HPBG:SetVertexColor(0, 1, 0, tempOptions["BGOpacity"]);
				end
			end
		end
		if ( nextFrame == 5 ) then
			break;
		end
	end
end

function CT_RA_Emergency_TargetMember(num)
	local obj = CT_RA_EmergencyFrame["frame"..num];
	if ( obj:IsVisible() and obj.ClickFrame.unitid ) then
		TargetUnit(obj.ClickFrame.unitid);
	end
end

function CT_RA_Emergency_OnEnter()
	if ( SpellIsTargeting() ) then
		SetCursor("CAST_CURSOR");
	elseif ( not SpellCanTargetUnit(this.unitid) and SpellIsTargeting() ) then
		SetCursor("CAST_ERROR_CURSOR");
	end
end

function CT_RA_Emergency_OnUpdate(elapsed)
	this.update = this.update - elapsed;
	if ( this.update <= 0 ) then
		this.update = 0.1;
		if ( this.cursor ) then
			if ( SpellIsTargeting() and SpellCanTargetUnit(this.unitid) ) then
				SetCursor("CAST_CURSOR");
			elseif ( SpellIsTargeting() ) then
				SetCursor("CAST_ERROR_CURSOR");
			end
		end
	end
end

function CT_RA_Emergency_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RA_Emergency_DropDown_Initialize, "MENU");
end

function CT_RA_Emergency_DropDown_Initialize()
	local tempOptions = CT_RAMenu_Options["temp"];
	local dropdown, info;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	if ( UIDROPDOWNMENU_MENU_VALUE == "Classes" ) then
		info = {};
		info.text = "Classes";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		for k, v in CT_RA_ClassPositions do
			if ( ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) and ( k ~= CT_RA_PALADIN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Alliance" ) ) ) then
				info = {};
				info.text = k;
				info.value = k;
				info.func = CT_RA_Emergency_DropDown_OnClick;
				info.checked = ( not tempOptions["EMClasses"] or not tempOptions["EMClasses"][k] );
				info.keepShownOnClick = 1;
				info.tooltipTitle = "Toggle Class";
				info.tooltipText = "Toggles displaying the selected class, allowing you to hide certain classes from the Emergency Monitor.";
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
		return;
	end

	if ( UIDROPDOWNMENU_MENU_VALUE == "Groups" ) then
		info = {};
		info.text = "Groups";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		for i = 1, 8, 1 do
			info = {};
			info.text = "Group " .. i;
			info.value = i;
			info.func = CT_RA_Emergency_DropDown_OnClick;
			info.checked = ( not tempOptions["EMGroups"] or not tempOptions["EMGroups"][i] );
			info.keepShownOnClick = 1;
			info.tooltipTitle = "Toggle Group";
			info.tooltipText = "Toggles displaying the selected group, allowing you to hide certain groups from the Emergency Monitor.";
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end
	info = {};
	info.text = "Emergency Monitor";
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Classes";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = "Groups";
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = "Background Color";
	info.hasColorSwatch = 1;
	info.hasOpacity = 1;
	if ( tempOptions["EMBG"] ) then
		info.r = ( tempOptions["EMBG"].r );
		info.g = ( tempOptions["EMBG"].g );
		info.b = ( tempOptions["EMBG"].b );
		info.opacity = ( tempOptions["EMBG"].a );
	else
		info.r = 0;
		info.g = 0;
		info.b = 1;
		info.opacity = 0;
	end
	info.notClickable = 1;
	info.swatchFunc = CT_RA_Emergency_DropDown_SwatchFunc;
	info.opacityFunc = CT_RA_Emergency_DropDown_OpacityFunc;
	info.cancelFunc = CT_RA_Emergency_DropDown_CancelFunc;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
end

function CT_RA_Emergency_DropDown_SwatchFunc()
	local tempOptions = CT_RAMenu_Options["temp"];
	local r, g, b = ColorPickerFrame:GetColorRGB();
	if ( not tempOptions["EMBG"] ) then
		tempOptions["EMBG"] = { ["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 0 };
	else
		tempOptions["EMBG"]["r"] = r;
		tempOptions["EMBG"]["g"] = g;
		tempOptions["EMBG"]["b"] = b;
	end
	CT_RA_EmergencyFrame:SetBackdropColor(r, g, b, tempOptions["EMBG"]["a"]);
	CT_RA_EmergencyFrame:SetBackdropBorderColor(1, 1, 1, tempOptions["EMBG"]["a"]);
end

function CT_RA_Emergency_DropDown_OpacityFunc()
	local tempOptions = CT_RAMenu_Options["temp"];
	local r, g, b = 1, 1, 1;
	if ( tempOptions["EMBG"] ) then
		r, g, b = tempOptions["EMBG"].r, tempOptions["EMBG"].g, tempOptions["EMBG"].b;
	end
	local a = OpacitySliderFrame:GetValue();
	tempOptions["EMBG"]["a"] = a;
	CT_RA_EmergencyFrame:SetBackdropColor(r, g, b, a);
	CT_RA_EmergencyFrame:SetBackdropBorderColor(1, 1, 1, a);
end

function CT_RA_Emergency_DropDown_CancelFunc(val)
	local tempOptions = CT_RAMenu_Options["temp"];
	tempOptions["EMBG"] = { 
		["r"] = val.r,
		["g"] = val.g,
		["b"] = val.b,
		["a"] = val.opacity
	};
	CT_RA_EmergencyFrame:SetBackdropColor(val.r, val.g, val.b, val.opacity);
	CT_RA_EmergencyFrame:SetBackdropBorderColor(1, 1, 1, val.opacity);
end

function CT_RA_Emergency_DropDown_OnClick()
	local tempOptions = CT_RAMenu_Options["temp"];
	if ( UIDROPDOWNMENU_MENU_VALUE == "Classes" ) then
		if ( not tempOptions["EMClasses"] ) then
			tempOptions["EMClasses"] = { };
		end
		tempOptions["EMClasses"][this.value] = not tempOptions["EMClasses"][this.value];
		CT_RA_Emergency_UpdateHealth();
	elseif ( UIDROPDOWNMENU_MENU_VALUE == "Groups" ) then
		if ( not tempOptions["EMGroups"] ) then
			tempOptions["EMGroups"] = { };
		end
		tempOptions["EMGroups"][this.value] = not tempOptions["EMGroups"][this.value];
		CT_RA_Emergency_UpdateHealth();	
	end
end

function CT_RA_Emergency_ToggleDropDown()
	local left, top = this:GetCenter();
	local uileft, uitop = UIParent:GetCenter();
	if ( left > uileft ) then
		CT_RA_EmergencyFrameDropDown.point = "TOPRIGHT";
		CT_RA_EmergencyFrameDropDown.relativePoint = "BOTTOMLEFT";
	else
		CT_RA_EmergencyFrameDropDown.point = "TOPLEFT";
		CT_RA_EmergencyFrameDropDown.relativePoint = "BOTTOMRIGHT";
	end
	CT_RA_EmergencyFrameDropDown.relativeTo = this:GetName();
	ToggleDropDownMenu(1, nil, CT_RA_EmergencyFrameDropDown);
end

-- RADurability stuff
function CT_RADurability_GetDurability()
	local currDur, maxDur, brokenItems = 0, 0, 0;
	local itemIds = {
		1, 2, 3, 5, 6, 7, 8, 9, 10, 16, 17, 18
	};
	for k, v in itemIds do
		CT_RADurationTooltip:ClearLines();
		CT_RADurationTooltip:SetInventoryItem("player", v);
		for i = 1, CT_RADurationTooltip:NumLines(), 1 do
			local useless, useless, sMin, sMax = string.find(getglobal("CT_RADurationTooltipTextLeft" .. i):GetText() or "", CT_RA_DURABILITY);
			if ( sMin and sMax ) then
				local iMin, iMax = tonumber(sMin), tonumber(sMax);
				if ( iMin == 0 ) then
					brokenItems = brokenItems + 1;
				end
				currDur = currDur + iMin;
				maxDur = maxDur + iMax;
				break;
			end
		end
	end
	return currDur, maxDur, brokenItems;
end

function CT_RAReagents_GetReagents()
	local numItems = 0;
	local classes = {
		[CT_RA_PRIEST] = {CT_REG_PRIEST , CT_REG_PRIEST_SPELL},
		[CT_RA_MAGE] = { CT_REG_MAGE , CT_REG_MAGE_SPELL },
		[CT_RA_DRUID] = { CT_REG_DRUID ,CT_REG_DRUID_SPELL },
		[CT_RA_WARLOCK] = { CT_REG_WARLOCK },
		[CT_RA_PALADIN] = { CT_REG_PALADIN, CT_REG_PALADIN_SPELL },
		[CT_RA_SHAMAN] = { CT_REG_SHAMAN, CT_REG_SHAMAN_SPELL }
	};
	local plClass = classes[UnitClass("player")];
	if ( not plClass or ( plClass[2] and not CT_RA_ClassSpells[plClass[2]] ) ) then
		return;
	end
	for i = 0, 4, 1 do
		for y = 1, MAX_CONTAINER_ITEMS, 1 do
			local link = GetContainerItemLink(i, y);
			if ( link ) then
				local _, _, name = string.find(link, "%[(.+)%]");
				if ( name ) then
					if ( plClass and plClass[1] == name ) then
						local texture, itemCount, locked, quality, readable = GetContainerItemInfo(i,y);
						numItems = numItems + itemCount;
					end
				end
			end
		end
	end
	return numItems;
end

function CT_RAItem_GetItems(itemName)
	local numItems = 0;
	for i = 0, 4, 1 do
		for y = 1, MAX_CONTAINER_ITEMS, 1 do
			local link = GetContainerItemLink(i, y);
			if ( link ) then
				local _, _, name = string.find(link, "%[(.+)%]");
				if ( name == itemName ) then
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(i,y);
					numItems = numItems + itemCount;
				end
			end
		end
	end
	return numItems;
end

CT_RADurability_Shown = { };
CT_RADurability_Sorting = {
	["curr"] = 4,
	[3] = { "a", "a" },
	[4] = { "a", "a" }
};
tinsert(UISpecialFrames, "CT_RA_DurabilityFrame");


function CT_RADurability_Add(name, info, fileName, ...)
	local tbl = { name, info, fileName };
	for i = 1, arg.n, 1 do
		tinsert(tbl, ( tonumber(arg[i]) or arg[i] ));
	end
	tinsert(CT_RADurability_Shown, tbl);
	CT_RADurability_Sort(CT_RADurability_Sorting["curr"], 1);
	CT_RADurability_Update();
end

function CT_RADurability_Sort(sortBy, maintain)
	if ( CT_RADurability_Sorting["curr"] ~= sortBy ) then
		CT_RADurability_Sorting[sortBy][1] = CT_RADurability_Sorting[sortBy][2];
	end
	CT_RADurability_Sorting["curr"] = sortBy;
	if ( CT_RADurability_Sorting[sortBy][1] == "a" ) then
		if ( not maintain ) then
			CT_RADurability_Sorting[sortBy][1] = "b";
		end
	else
		if ( not maintain ) then
			CT_RADurability_Sorting[sortBy][1] = "a";
		end
	end
	if ( CT_RADurability_Sorting[sortBy][1] == "b" ) then
		table.sort(CT_RADurability_Shown,
			function(t1, t2)
				if (t1[sortBy] == t2[sortBy] ) then
					if ( t1[3] == t2[3] ) then
						return t1[1] < t2[1]
					else
						return t1[3] < t2[3]
					end
				else
					return t1[sortBy] < t2[sortBy]
				end
			end
		);
	else
		table.sort(CT_RADurability_Shown,
			function(t1, t2)
				if (t1[sortBy] == t2[sortBy] ) then
					if ( t1[3] == t2[3] ) then
						return t1[1] < t2[1]
					else
						return t1[3] < t2[3]
					end
				else
					return t1[sortBy] > t2[sortBy]
				end
			end
		);
	end
	CT_RADurability_Update();
end

function CT_RADurability_Update()
	local numEntries = getn(CT_RADurability_Shown);
	FauxScrollFrame_Update(CT_RA_DurabilityFrameScrollFrame, numEntries, 19, 20);

	for i = 1, 19, 1 do
		local button = getglobal("CT_RA_DurabilityFramePlayer" .. i);
		local index = i + FauxScrollFrame_GetOffset(CT_RA_DurabilityFrameScrollFrame);
		if ( index <= numEntries ) then
			if ( numEntries <= 19 ) then
				button:SetWidth(275);
			else
				button:SetWidth(253);
			end
			if ( CT_RA_DurabilityFrame.type ~= "RARST" or numEntries <= 19 ) then
				CT_RA_DurabilityFrameScrollFrame:SetPoint("TOPLEFT", "CT_RA_DurabilityFrame", "TOPLEFT", 19, -27);
				getglobal(button:GetName() .. "Resist1"):SetPoint("LEFT", button:GetName(), "LEFT", 127, 0);
				CT_RA_DurabilityFrameNameTab:SetWidth(135);
			else
				CT_RA_DurabilityFrameScrollFrame:SetPoint("TOPLEFT", "CT_RA_DurabilityFrame", "TOPLEFT", 19, -32);
				getglobal(button:GetName() .. "Resist1"):SetPoint("LEFT", button:GetName(), "LEFT", 110, 0);
				CT_RA_DurabilityFrameNameTab:SetWidth(118);
			end
			button:Show();
			getglobal(button:GetName() .. "Name"):SetText(CT_RADurability_Shown[index][1]);
			local color = RAID_CLASS_COLORS[CT_RADurability_Shown[index][3]];
			if ( color ) then
				getglobal(button:GetName() .. "Name"):SetTextColor(color.r, color.g, color.b);
			end
			getglobal(button:GetName() .. "Info"):SetText(CT_RADurability_Shown[index][2]);
			for i = 1, 5, 1 do
				if ( CT_RA_DurabilityFrame.type == "RARST" and CT_RADurability_Shown[index][3+i] ~= -1 ) then
					getglobal(button:GetName() .. "Resist" .. i):SetText(CT_RADurability_Shown[index][3+i]);
					getglobal(button:GetName() .. "Resist" .. i):Show();
				else
					getglobal(button:GetName() .. "Resist" .. i):Hide();
				end
			end
		else
			button:Hide();
		end
	end

end

CT_RA_CurrDebuffs = { };

function CT_RA_AddDebuffMessage(name, dType, player)
	if ( not dType ) then
		return;
	end
	if ( CT_RADebuff_IgnoreDebuffs[name] ) then
		return;
	end
	if ( CT_RA_CurrDebuffs[name .. "@" .. dType] ) then
		if ( not CT_RA_CurrDebuffs[name .. "@" .. dType][3][player] ) then
			CT_RA_CurrDebuffs[name .. "@" .. dType][3][player] = 1;
			CT_RA_CurrDebuffs[name .. "@" .. dType][2] = CT_RA_CurrDebuffs[name .. "@" .. dType][2] + 1;
			CT_RA_CurrDebuffs[name .. "@" .. dType][1] = 0.4;
		end
	else
		CT_RA_CurrDebuffs[name .. "@" .. dType] = {
			0.4, 1, {
				[player] = 1
			},
			player
		};
	end
end

function CT_RA_RGBToHex(r, g, b)
	return format("%.2x%.2x%.2x", floor(r*255), floor(g*255), floor(b*255));
end

CT_RA_oldRaidFrame_LoadUI = RaidFrame_LoadUI;
function RaidFrame_LoadUI()
	CT_RA_oldRaidFrame_LoadUI();
	RaidFrameDropDown_Initialize = CT_RATab_newRaidFrameDropDown_Initialize;
end
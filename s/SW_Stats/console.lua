
function SW_SlashCommand(msg)
	if msg == nil then return; end
	
	local _,_, c, v = string.find(msg, "([^ ]+) (.+)");
	if c == nil then
		c = string.gsub(msg, " ", "");
	end
	if c == "" then
		SW_PrintHelp();
		return;
	end
	
	local cmd = nil;
	for k,v in pairs(SW_SlashCommands) do
		if v["c"] == c then
			cmd = v;
			break;
		end
	end
	if cmd == nil then
		SW_printStr(SW_CONSOLE_NOCMD .. c);
		SW_printStr(SW_CONSOLE_HELP ..SW_RootSlashes[1].." "..SW_SlashCommands["help"]["c"]);
		return;
	end
	
	if cmd["aC"] > 0 then
		if v == nil or string.gsub(v, " ", "") == "" then
			SW_printStr(cmd["u"]);
			return;
		end
		cmd["f"](v);
	else
		cmd["f"]();
	end
end
function SW_ResetAllWindows()
	SW_BarFrame1:SetPoint("TOPLEFT",UIParent, "CENTER", -50, 50); 
	SW_BarFrame1:Show();
	SW_TextWindow:SetPoint("TOPLEFT", UIParent, "CENTER");
	SW_GeneralSettings:SetPoint("TOPLEFT",UIParent, "CENTER", 20, -20);
	SW_GeneralSettings:Show();
	SW_BarReportFrame:SetPoint("TOPLEFT",UIParent, "CENTER", 40, -40);
	SW_BarReportFrame:Show();
	SW_BarSyncFrame:SetPoint("TOPLEFT",UIParent, "CENTER", 60, -60);
	SW_BarSyncFrame:Show();
	SW_BarSettingsFrameV2:SetPoint("TOPLEFT",UIParent, "CENTER");
	SW_FrameConsole:SetPoint("TOPLEFT",UIParent, "CENTER");
	
end
function SW_ToggleConsole()
	local frame = getglobal("SW_FrameConsole")
	if(  frame:IsVisible() ) then
		frame:Hide();
	else
		frame:Show();
	end
end
function SW_ToggleBarFrame()
	local frame = getglobal("SW_BarFrame1")
	if(  frame:IsVisible() ) then
		SW_Settings["SHOWMAIN"] = nil;
		frame:Hide();
	else
		SW_Settings["SHOWMAIN"] = true;
		frame:Show();
	end
end
function SW_ToggleLocks()
	if SW_Settings["BFLocked"] then
		SW_LockFrames();
	else
		SW_LockFrames(true);
	end
end
function SW_ToggleGeneralSettings()
	local frame = getglobal("SW_GeneralSettings")
	if(  frame:IsVisible() ) then
		frame:Hide();
	else
		frame:Show();
	end
end
function SW_DumpVar(cmdString)
	local varName = string.gsub(cmdString, " ", "")
	local g = getfenv();
	
	if g[varName] == nil then
		SW_printStr(varName..SW_CONSOLE_NIL_TRAILER);
		return;
	else
		if type(g[varName]) == "table" then
			SW_DumpTable(g[varName]);
		else
			SW_printStr(g[varName]);
		end
	end
	
end
function SW_ResetInfo()
	SW_S_Details = {};
	SW_S_Healed = {};
	SW_S_SpellInfo = {};
	SW_S_ManaUsage = {};
	SW_S_LastManaSent = {0,0,0};
	SW_CombatTime = 0;
	SW_DPS_Dmg =0;
	
	-- 1.5 the new pet systems needs a SW_RebuildFriendList
	SW_PetInfo = {};
	SW_PetInfo["OWNER_PET"] = {};
	SW_PetInfo["PET_OWNER"] = {};
	SW_RebuildFriendList();
	
	--1.5.3 the Raid per second info
	SW_RPS = SW_C_RPS:new();
	
	SW_Sync_MsgTrack = {};
end

function SW_PostCheck(target)
	local id;
	if SW_Settings["SYNARP"] then
		return true;
	end
	if UnitInRaid("player") then
		if IsRaidLeader() or IsRaidOfficer() then
			return true;
		else
			if target == "RAID" then
				return false;
			else
				return true;
			end
		end
	--[[ hmm i think this is to restrictive
	elseif UnitInParty("player") then
		if IsPartyLeader() then
			return true;
		else
			if target == "PARTY" then
				return false;
			else
				return true;
			end
		end
	--]]
	else
		return true;
	end
end

function SW_ResetCheck()
	local id;
	
	if SW_Settings["SYNCLastChan"] == nil then
		StaticPopup_Show("SW_Reset");
		return;
	else
		-- are we still in this channel?
		id, _ = GetChannelName(SW_Settings["SYNCLastChan"]); 
		if id == 0 then
			StaticPopup_Show("SW_Reset");
			return;
		else
			--here we are in a active syncchan 
			if UnitInRaid("player") then
				if IsRaidLeader() or IsRaidOfficer() then
					StaticPopup_Show("SW_ResetSync");
				else
					StaticPopup_Show("SW_ResetFailInfo");
				end
			else
				if IsPartyLeader() then
					StaticPopup_Show("SW_ResetSync");
				else
					StaticPopup_Show("SW_ResetFailInfo");
				end
			end
		end
	end
end
function SW_RebuildFriendList()
	if  GetNumRaidMembers() > 0 then
		SW_Make_Friends("RAID");
	elseif GetNumPartyMembers() > 0 then
		SW_Make_Friends("GROUP");
	else
		SW_Make_Friends();
	end
end

function SW_PrintHelp()
	local con = getglobal("SW_FrameConsole");
	
	if con ~= nil and con:IsVisible() then
		con = getglobal("SW_FrameConsole_Text1_MsgFrame");
	else
		con = DEFAULT_CHAT_FRAME;
	end
	if con ~= nil then
		for k,v in pairs(SW_SlashCommands) do	
			if v["c"] ~= nil then
				if v["si"] ==nil then
					con:AddMessage("|cc0c0ff00"..v["c"]..":");
				else
					con:AddMessage("|cc0c0ff00"..v["c"]..":"..NORMAL_FONT_COLOR_CODE.."  "..v["si"]);
				end
				if v["u"] ~= nil then
					con:AddMessage(NORMAL_FONT_COLOR_CODE.."     "..v["u"]);
				end
			end
		end
	end
end
function SW_ManualSyncJoin(chanName)
	if tonumber(chanName) then
		StaticPopup_Show("SW_InvalidChan");
		return;
	end
	SW_SyncChanID = 0;
	SW_SyncQueue:Clear();
	if SW_Settings["SYNCLastChan"] ~= nil then
		LeaveChannelByName(SW_Settings["SYNCLastChan"]);
		SW_Settings["SYNCLastChan"] = nil;
	end
	SW_SyncJoin(chanName); 
end

function SW_KickPlayer(who)
	if UnitInRaid("player") and not (IsRaidLeader() or IsRaidOfficer()) then
		return;
	end
	SW_SendSyncKick(who);
	
end
function SW_InitResetVote()
	if SW_SyncChanID ~= 0 and SW_Settings["SYNCLastChan"] ~= nil then
		SW_ResetVote();
	end
end
function SW_VersionCheck()
	SW_SyncSendRSV();
	local swc = getglobal("SW_FrameConsole");
	if not swc:IsVisible() then
		swc:Show();
	end
end
function SW_GetSkillUsage(cmdString)
	SW_SyncSendRSU(cmdString);
	local swc = getglobal("SW_FrameConsole");
	if not swc:IsVisible() then
		swc:Show();
	end
end
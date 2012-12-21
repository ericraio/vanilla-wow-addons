CThunWarnerStatus_InCombat = 0;
CThunWarnerStatus_Alarm = 1;
CThunWarnerStatus_Timer = 1;
CThunWarnerStatus_PlaySound = 1;
CThunWarnerStatus_SoundPhase2 = 0;
CThunWarnerStatus_ShowList = 4;
CThunWarnerStatus_Fake = 0;
CThunWarnerStatus_RangeStatus = 0;
CThunWarnerStatus_CurrentTime = 0;
CThunWarnerStatus_LastTimeCheck = 0;
CThunWarnerStatus_LastTimeSound = 0;
CThunWarnerStatus_Scale = 2;
CThunWarnerStatus_Locked = 0;
CThunWarnerStatus_InStomach = 0;
CThunWarnerStatus_TempDisableSound = 0;
CThunWarnerStatus_Players = {};
CThunWarnerStatus_PlayersStomach = {};
CThunWarnerStatus_DigestiveAcidTexture = "Interface\\Icons\\Ability_Creature_Disease_02";
CThunWarnerStatus_Emote = "%s is weakened!";
CThunWarnerStatus_Dies = "Eye of C'Thun dies.";
CThunWarnerStatus_Victory = "C'Thun dies.";
CThunWarnerStatus_WasVisible = true;
CThunWarnerStatus_VersionCheck = {};
CThunWarnerStatus_Offline = {};
CThunWarnerStatus_CheckRunning = false;
CThunWarnerStatus_CheckProgress = 0;
CThunWarnerStatus_CheckTime = 3;

function CThunWarner_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	SLASH_CThunWarner1 = "/ctw";
	SlashCmdList["CThunWarner"] = CThunWarner_SlashHandler;
end

function CThunWarner_SlashHandler(arg1)
	local _, _, command, args = string.find(arg1, "(%w+)%s?(.*)");
	if(command) then
		command = strlower(command);
	else
		command = "";
	end
	if(command == "sound") then
		if(args == "on") then
			CThunWarnerStatus_PlaySound = 1;
			CThunWarner_Print("|cFFFF9955Sound:|r |cFFFFFF00On|r.");
		elseif(args == "off") then
			CThunWarnerStatus_PlaySound = 0;
			CThunWarner_Print("|cFFFF9955Sound:|r |cFFFFFF00Off|r.");
		end
	elseif(command == "check") then
		if(UnitInRaid("player")) then
			CThunWarner_Check();
		else
			CThunWarner_Print("You are not in a raid.")
		end
	elseif(command == "fake") then
		if(CThunWarnerStatus_Fake == 0) then
			if(not CThunWarnerFrame:IsVisible()) then
				CThunWarnerStatus_WasVisible = false;
				CThunWarnerFrame:Show();
			end
			CThunWarnerStatus_Fake = 1;
			CThunWarnerStatusBar_Timer(8);
			if(CThunWarnerStatus_Alarm == 1) then
				PlaySoundFile("Interface\\AddOns\\CThunWarner\\alarm.mp3");
			end
		else
			CThunWarnerStatusBar:Hide();
			CThunWarnerStatus_Fake = 0;
			if(not CThunWarnerStatus_WasVisible) then
				CThunWarner_Off();
			end
			CThunWarnerStatus_WasVisible = true;
		end
	elseif(command == "alarm") then
		if(args == "on") then
			CThunWarnerStatus_Alarm = 1;
			CThunWarner_Print("|cFFFF9955Alarm:|r |cFFFFFF00On|r.");
		elseif(args == "off") then
			CThunWarnerStatus_Alarm = 0;
			CThunWarner_Print("|cFFFF9955Alarm:|r |cFFFFFF00Off|r.");
		end
	elseif(command == "timer") then
		if(args == "on") then
			CThunWarnerStatus_Timer = 1;
			CThunWarner_Print("|cFFFF9955Timer:|r |cFFFFFF00On|r.");
		elseif(args == "off") then
			CThunWarnerStatus_Timer = 0;
			CThunWarner_Print("|cFFFF9955Timer:|r |cFFFFFF00Off|r.");
		end
	elseif(command == "soundphase2") then
		if(args == "on") then
			CThunWarnerStatus_SoundPhase2 = 1;
			CThunWarner_Print("|cFFFF9955Phase2 Sound:|r |cFFFFFF00On|r.");
		elseif(args == "off") then
			CThunWarnerStatus_SoundPhase2 = 0;
			CThunWarner_Print("|cFFFF9955Phase2 Sound:|r |cFFFFFF00Off|r.");
		end
	elseif(command == "lock") then
		CThunWarnerStatus_Locked = 1;
		CThunWarner_Print("|cFFFF9955Position:|r |cFFFFFF00Locked|r.");
	elseif(command == "unlock") then
		CThunWarnerStatus_Locked = 0;
		CThunWarner_Print("|cFFFF9955Position:|r |cFFFFFF00Unlocked|r.");
	elseif(command == "reset") then
		CThunWarnerStatus_Locked = 0;
		CThunWarnerFrame:SetScale(2);
		CThunWarnerStatus_Scale = 2;
		CThunWarnerFrame:ClearAllPoints();
		CThunWarnerFrame:SetPoint("CENTER", "UIParent");
		CThunWarner_Print("|cFFFF9955Position:|r |cFFFFFF00Reset|r.");
	elseif(command == "scale") then
		if(tonumber(args)) then
			local newscale = tonumber(args);
			CThunWarnerStatus_Locked = 0;
			CThunWarnerFrame:SetScale(newscale);
			CThunWarnerStatus_Scale = newscale;
			CThunWarnerFrame:ClearAllPoints();
			CThunWarnerFrame:SetPoint("CENTER", "UIParent");
			CThunWarner_Print("|cFFFF9955Scale:|r |cFFFFFF00"..newscale.."|r.");
		end
	elseif(command == "list") then
		if(tonumber(args)) then
			local newlines = tonumber(args);
			CThunWarnerStatus_ShowList = newlines;
			CThunWarner_Print("|cFFFF9955Player List:|r |cFFFFFF00"..newlines.."|r.");
		end
	elseif(command == "ooc") then
		CThunWarnerStatus_InCombat = 0;
		CThunWarnerStatus_TempDisableSound = 0;
		CThunWarner_Print("|cFFFF9955Sound:|r |cFFFFFF00Reset|r.");
	elseif(command == "help") then
		CThunWarner_Print("Command List:");
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw on/off", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw alarm on/off", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw sound on/off", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw timer on/off", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw soundphase2 on/off", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw list 0..40", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw scale 1..9", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw reset", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw lock", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw unlock", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw ooc", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw fake", 0.988, 0.819, 0.086);
		DEFAULT_CHAT_FRAME:AddMessage("     /ctw check", 0.988, 0.819, 0.086);
		CThunWarner_Print("Command List.");
	elseif(command == "on") then
		CThunWarnerFrame:Show();
		CThunWarner_Print("|cFFFF9955C'Thun Warner:|r |cFFFFFF00On|r.");
	elseif(command == "off") then
		CThunWarner_Off();
		CThunWarnerStatus_Fake = 0;
		CThunWarnerStatus_WasVisible = true;
		CThunWarner_Print("|cFFFF9955C'Thun Warner:|r |cFFFFFF00Off|r.");
	elseif(command == "") then
		if(CThunWarnerFrame:IsVisible()) then
			CThunWarner_Off();
			CThunWarnerStatus_Fake = 0;
			CThunWarnerStatus_WasVisible = true;
			CThunWarner_Print("|cFFFF9955C'Thun Warner:|r |cFFFFFF00Off|r.");
		else
			CThunWarnerFrame:Show();
			CThunWarner_Print("|cFFFF9955C'Thun Warner:|r |cFFFFFF00On|r.");
		end
	else
		CThunWarner_Print("Type /ctw help for a command list.");
	end
end

function CThunWarner_OnEvent(event)
	if(event == "PLAYER_REGEN_DISABLED" and GetZoneText() == "Ahn'Qiraj") then
		if(CThunWarnerFrame:IsVisible()) then
			CThunWarnerStatus_InCombat = 1;
		end
	elseif(event == "PLAYER_REGEN_ENABLED" and CThunWarnerStatus_InCombat == 1) then
		CThunWarnerStatus_InCombat = 0;
		CThunWarnerStatus_TempDisableSound = 0;
	elseif(event == "PLAYER_ENTERING_WORLD") then
		CThunWarnerStatus_InCombat = 0;
		CThunWarnerStatus_TempDisableSound = 0;
	elseif(event == "VARIABLES_LOADED") then
		CThunWarnerFrame:SetScale(CThunWarnerStatus_Scale);
	elseif(event == "CHAT_MSG_ADDON" and UnitInRaid("player")) then
		if(arg1 == "CThunWarner" and arg3 == "RAID") then
			CThunWarner_Reply(arg2, arg4);
		end
	elseif(event == "CHAT_MSG_MONSTER_EMOTE" and CThunWarnerFrame:IsVisible() and GetZoneText() == "Ahn'Qiraj") then
		if(arg1 == CThunWarnerStatus_Emote) then
			if(CThunWarnerStatus_Alarm == 1) then
				PlaySoundFile("Interface\\AddOns\\CThunWarner\\alarm.mp3");
			end
			if(CThunWarnerStatus_Timer == 1) then
				CThunWarnerStatusBar_Timer(45);
			end
		end
	elseif(event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" and CThunWarnerFrame:IsVisible() and GetZoneText() == "Ahn'Qiraj") then
		if(arg1 == CThunWarnerStatus_Dies) then
			if(CThunWarnerStatus_SoundPhase2 == 0) then
				CThunWarnerStatus_TempDisableSound = 1;
			end
		elseif(arg1 == CThunWarnerStatus_Victory) then
			CThunWarner_Off();
			CThunWarnerStatus_InCombat = 0;
			CThunWarnerStatus_TempDisableSound = 0;
			CThunWarner_Print("|cFF5DFC0AVictory!|r |cFFFF9955C'Thun Warner:|r |cFFFFFF00Off|r.");
		end
	end
end

function CThunWarner_OnUpdate(arg1)
	CThunWarnerStatus_CurrentTime = CThunWarnerStatus_CurrentTime + arg1;
	if(CThunWarnerStatus_CurrentTime > (CThunWarnerStatus_LastTimeCheck+0.1)) then
		local unitid;
		CThunWarnerStatus_Players = {};
		CThunWarnerStatus_PlayersStomach = {};
		CThunWarnerStatus_InStomach = 0;
		for i = 1, GetNumRaidMembers(), 1 do
			unitid = "raid"..i;
			if(not UnitIsDeadOrGhost(unitid)) then
				if(not UnitIsUnit(unitid, "player")) then
					if(CheckInteractDistance(unitid, 3)) then
						tinsert(CThunWarnerStatus_Players, (UnitName(unitid)));
					end
				end
				for a=1,16 do
					local t,c = UnitDebuff(unitid,a);
					if(t == nil) then break; end;
					if(t == CThunWarnerStatus_DigestiveAcidTexture)	then
						if(UnitIsUnit(unitid, "player")) then
							CThunWarnerStatus_InStomach = 1;
						end
						tinsert(CThunWarnerStatus_PlayersStomach, unitid);
						break;
					end
				end
			end
		end
		if(getn(CThunWarnerStatus_Players) > 0) then
			CThunWarnerStatus_RangeStatus = 1;
			CThunWarnerStatusTexture:SetVertexColor(1,0,0);
			if(CThunWarnerStatus_InCombat == 1 and CThunWarnerStatus_PlaySound == 1 and CThunWarnerStatus_TempDisableSound == 0 and CThunWarnerStatus_InStomach == 0) then
				if(CThunWarnerStatus_CurrentTime > (CThunWarnerStatus_LastTimeSound+1)) then
					PlaySoundFile("Interface\\AddOns\\CThunWarner\\beep.mp3");
					CThunWarnerStatus_LastTimeSound = CThunWarnerStatus_CurrentTime;
				end
			end
		else
			CThunWarnerStatus_RangeStatus = 0;
			CThunWarnerStatusTexture:SetVertexColor(0,1,0);
		end
		CThunWarner_UpdateList();
		CThunWarner_UpdateStomachList();
		CThunWarnerStatus_LastTimeCheck = CThunWarnerStatus_CurrentTime;
	end
	if(CThunWarnerStatus_CheckRunning) then
		CThunWarnerStatus_CheckProgress = CThunWarnerStatus_CheckProgress + arg1;
		if(CThunWarnerStatus_CheckProgress > CThunWarnerStatus_CheckTime) then
			CThunWarnerStatus_CheckRunning = false;
			local foundcount = 0;
			local notfoundcount = 0;
			local notfound = "Not Found: ";
			for i=1,MAX_RAID_MEMBERS do
				local raidname = (UnitName("raid"..i));
				if(CThunWarnerStatus_VersionCheck[raidname] == false) then
					notfoundcount = notfoundcount + 1;
					notfound = notfound.."|Hplayer:"..raidname.."|h["..raidname.."]|h, ";
				elseif(CThunWarnerStatus_VersionCheck[raidname] == true and raidname ~= UnitName("player")) then
					foundcount = foundcount + 1;
				end
			end
			CThunWarner_Print("|cFFFF5333"..notfound.."("..notfoundcount.." Total)|r");
			CThunWarner_Print("|cFF5DFC0AFound: ("..foundcount.." Total)|r");
		end
	end
end

function CThunWarnerStatusBar_Timer(time)
	CThunWarnerStatusBar.startTime = GetTime();
	CThunWarnerStatusBar.endTime = CThunWarnerStatusBar.startTime + time;
	CThunWarnerStatusBar:SetMinMaxValues(CThunWarnerStatusBar.startTime, CThunWarnerStatusBar.endTime);
	CThunWarnerStatusBar:SetValue(CThunWarnerStatusBar.startTime);
	CThunWarnerStatusBar:Show();
end

function CThunWarnerStatusBar_OnUpdate()
	local time = GetTime();
	if(time > this.endTime) then
		time = this.endTime
	end
	if(time == this.endTime) then
		if(CThunWarnerStatus_Fake == 1) then
			CThunWarnerStatus_Fake = 0;
			if(not CThunWarnerStatus_WasVisible) then
				CThunWarner_Off();
				CThunWarnerStatus_WasVisible = true;
			end
		end
		this:Hide();
		return;
	end
	this:SetValue(this.startTime + (this.endTime - time));
	getglobal(this:GetName().."Text"):SetText(format("%.2f", this.endTime - time));
end

function CThunWarner_UpdateList()
	CThunWarnerTooltip:SetOwner(CThunWarnerFrame, "ANCHOR_BOTTOMRIGHT");
	CThunWarnerTooltip:SetFrameStrata("MEDIUM");
	if(CThunWarnerStatus_RangeStatus == 0 or CThunWarnerStatus_ShowList == 0) then
		CThunWarnerTooltip:Hide();
		if(CThunWarnerStatus_Fake == 1) then
			CThunWarnerTooltip:SetOwner(CThunWarnerFrame, "ANCHOR_BOTTOMRIGHT");
			CThunWarnerTooltip:SetFrameStrata("MEDIUM");
			CThunWarnerTooltip:ClearLines();
			CThunWarnerTooltip:AddLine("Linking:",0.890,0.811,0.341,0);
			CThunWarnerTooltip:AddLine("- Farming",1,0.498,0,0);
			CThunWarnerTooltip:AddLine("- Stranglekelp",0.666,0.666,1,0);
			CThunWarnerTooltip:AddLine("- Liferoot",0.666,0.666,1,0);
			CThunWarnerTooltip:AddLine("- Forever",1,0.498,0,0);
			CThunWarnerTooltip:Show();
		end
	else
		CThunWarnerTooltip:ClearLines();
		CThunWarnerTooltip:AddLine("Linking:",0.890,0.811,0.341,0);
		local index = 1;
		for key, player in CThunWarnerStatus_Players do
			for i=1,MAX_RAID_MEMBERS do
				local partyid = "raid"..i;
				if((player == (UnitName(partyid))) and UnitExists(partyid) and UnitInParty(partyid)) then
					CThunWarnerTooltip:AddLine("- "..player,0.666,0.666,1,0);
				else
					if((player == (UnitName(partyid))) and UnitExists(partyid) and not UnitInParty(partyid)) then
						CThunWarnerTooltip:AddLine("- "..player,1,0.498,0,0);
					end
				end
			end
			if(index >= CThunWarnerStatus_ShowList) then
				break;
			end
			index = index + 1;
		end
		CThunWarnerTooltip:Show();
	end
end

function CThunWarner_UpdateStomachList()
	CThunWarnerStomachTooltip:SetOwner(CThunWarnerFrame, "ANCHOR_RIGHT");
	CThunWarnerStomachTooltip:SetFrameStrata("MEDIUM");
	if(getn(CThunWarnerStatus_PlayersStomach) == 0 or CThunWarnerStatus_ShowList == 0 or CThunWarnerStatus_InStomach == 1) then
		CThunWarnerStomachTooltip:Hide();
		if(CThunWarnerStatus_Fake == 1) then
			CThunWarnerStomachTooltip:SetOwner(CThunWarnerFrame, "ANCHOR_RIGHT");
			CThunWarnerStomachTooltip:SetFrameStrata("MEDIUM");
			CThunWarnerStomachTooltip:ClearLines();
			CThunWarnerStomachTooltip:AddLine("Stomach:",0.635,0.737,0.074,0);
			CThunWarnerStomachTooltip:AddLine("- Pepcid",0.666,0.666,1,0);
			CThunWarnerStomachTooltip:AddLine("- Reflux",1,0.498,0,0);
			CThunWarnerStomachTooltip:Show();
		end
	else
		CThunWarnerStomachTooltip:ClearLines();
		CThunWarnerStomachTooltip:AddLine("Stomach:",0.635,0.737,0.074,0);
		for key, unit in CThunWarnerStatus_PlayersStomach do
			if(UnitExists(unit)) then
				if(UnitInParty(unit)) then
					CThunWarnerStomachTooltip:AddLine("- "..(UnitName(unit)),0.666,0.666,1,0);
				else
					CThunWarnerStomachTooltip:AddLine("- "..(UnitName(unit)),1,0.498,0,0);
				end
			end
		end
		CThunWarnerStomachTooltip:Show();
	end
end

function CThunWarner_Check()
	if(UnitInRaid("player")) then
		if(CThunWarnerFrame:IsVisible() and not CThunWarnerStatus_CheckRunning) then
			CThunWarner_Print("|cFF5DFC0AReady Check!|r");
		elseif(not CThunWarnerFrame:IsVisible()) then
			CThunWarnerFrame:Show();
			CThunWarner_Print("|cFFFF9955C'Thun Warner:|r |cFFFFFF00On|r. |cFF5DFC0AReady Check!|r");
		end
		if(not CThunWarnerStatus_CheckRunning) then
			CThunWarnerStatus_VersionCheck = {};
			CThunWarnerStatus_Offline = {};
			for i=1,MAX_RAID_MEMBERS do
				local raidname = (UnitName("raid"..i));
				local isonline = UnitIsConnected("raid"..i);
				if(raidname and isonline ~= nil) then
					CThunWarnerStatus_VersionCheck[raidname] = false;
				else
					if(raidname and isonline == nil) then
						CThunWarnerStatus_Offline[raidname] = true;
					end
				end
			end
			SendAddonMessage("CThunWarner", "Check", "RAID");
			CThunWarnerStatus_CheckRunning = true;
			CThunWarnerStatus_CheckProgress = 0;
			CThunWarner_Reply("Ready", (UnitName("player")));
			CThunWarner_Offline();
		end
	end
end

function CThunWarner_Offline()
	local offlinecount = 0;
	local isoffline = "Offline: ";
	for i=1,MAX_RAID_MEMBERS do
		local raidname = (UnitName("raid"..i));
		if(CThunWarnerStatus_Offline[raidname] == true) then
			offlinecount = offlinecount + 1;
			isoffline = isoffline.."|Hplayer:"..raidname.."|h["..raidname.."]|h, ";
		end
	end
	CThunWarner_Print("|cFFC6C3B5"..isoffline.."("..offlinecount.." Total)|r");
end

function CThunWarner_Reply(msg, sender)
	if(msg == "Check" and sender ~= UnitName("player")) then
		SendAddonMessage("CThunWarner", "Ready", "RAID");
		if(not CThunWarnerFrame:IsVisible() and GetZoneText() == "Ahn'Qiraj") then
			local name, rank;
			for i = 1, GetNumRaidMembers(), 1 do
				name, rank = GetRaidRosterInfo(i);
				if(name == sender) then
					if(rank and rank > 0) then
						CThunWarnerFrame:Show();
						CThunWarner_Print("|cFFFF9955C'Thun Warner:|r |cFFFFFF00On|r. |cFF5DFC0AReady Check!|r |cFFFF9955|Hplayer:"..sender.."|h["..sender.."]|h|r");
						break;
					end
					break;
				end
			end
		end
	elseif(CThunWarnerStatus_CheckRunning and msg == "Ready" and sender) then
		CThunWarnerStatus_VersionCheck[sender] = true;
	end
end

function CThunWarner_Off()
	CThunWarnerFrame:Hide();
	CThunWarnerTooltip:Hide();
	CThunWarnerStomachTooltip:Hide();
	CThunWarnerStatusBar:Hide();
end

function CThunWarner_Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage("<C'Thun Warner> "..msg, 0.988, 0.819, 0.086);
end

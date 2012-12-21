AutoInviteOptions = {};
local Realm;
local Player;
local version = "0.5";
local default_invite = "invite";

function AutoInvite_OnLoad()
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	
	SlashCmdList["AutoInvite"] = AutoInvite_SlashHandler;
	SLASH_AutoInvite1 = "/AutoInvite";
	SLASH_AutoInvite2 = "/ai";
	
	DEFAULT_CHAT_FRAME:AddMessage("AutoInvite (redux) v"..version.." loaded. Type /ai for usage.",0,0,1);
	DEFAULT_CHAT_FRAME:AddMessage("Type \'/ai alist\' to auto invite everyone in the A-list",0,0,1);
	DEFAULT_CHAT_FRAME:AddMessage("Type \'/ai blist\' to auto invite everyone in the B-list",0,0,1);
end

function AutoInvite_InitializeSetup()
	Player = UnitName("player");
	Realm = GetRealmName();
	if AutoInviteOptions == nil then AutoInviteOptions = {} end;
	if(AutoInviteOptions[Realm] == nil) then AutoInviteOptions[Realm] = {} end;
	if(AutoInviteOptions[Realm][Player] == nil) then AutoInviteOptions[Realm][Player] = {} end;
	if(AutoInviteOptions[Realm][Player]["Invite"] == nil) then AutoInviteOptions[Realm][Player]["Invite"] = default_invite end;
	if(AutoInviteOptions[Realm][Player]["Status"] == nil) then AutoInviteOptions[Realm][Player]["Status"] = "On" end;
	if(AutoInviteOptions[Realm][Player]["Type"] == nil) then AutoInviteOptions[Realm][Player]["Type"] = "Party" end;
end

function AutoInvite_OnEvent(event)
	if(event == "PLAYER_ENTERING_WORLD") then
		AutoInvite_InitializeSetup();
	elseif(event == "CHAT_MSG_WHISPER") then
		if(AutoInviteOptions[Realm][Player]["Status"] == "On") then
			local what = arg1;
			local who = arg2;
			local invite = AutoInvite_CheckMessage(what);
			if(invite) then AutoInvite_Invite(who) end;
		end
	end
end

function InviteAList()
	for j = 1, 50 do
		if (AList[j]) then
			numgroup = GetNumRaidMembers();
			if(numgroup == 0) then --Not currently in a raid
				numparty = GetNumPartyMembers();
				if(numparty == 0) then InviteByName(AList[j]) --Nobody in the party? Start a new one!
				elseif(numparty < 4) then
					if(IsPartyLeader()) then InviteByName(AList[j]) --4 or less party members? Invite if you can.
					else return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..AList[j].." right now, you're not the party leader.") end;
				elseif(GetNumPartyMembers() == 4)then --if you've got a 5-man party (GetNumPartyMembers excludes yourself) convert to raid.
					if(IsPartyLeader()) then
						DEFAULT_CHAT_FRAME:AddMessage("Raid mode enabled: Converting your group to a raid.")
						ConvertToRaid();
						InviteByName(AList[j]);
					else
						DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..AList[j].." right now, you're not the party leader.");
					end
				end
			elseif((IsRaidLeader() or IsRaidOfficer()) and numgroup < 40) then InviteByName(AList[j])
			else
				if(numgroup > 39) then return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..AList[j].." right now, raid is full.");
				else return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..AList[j].." right now, you're not the raid leader.") end;
			end
		end
	end
end

function InviteBList()
	for j = 1, 39 do
		if (BList[j]) then
			numgroup = GetNumRaidMembers();
			if(numgroup == 0) then --Not currently in a raid
				numparty = GetNumPartyMembers();
				if(numparty == 0) then InviteByName(BList[j]) --Nobody in the party? Start a new one!
				elseif(numparty < 4) then
					if(IsPartyLeader()) then InviteByName(BList[j]) --4 or less party members? Invite if you can.
					else return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..BList[j].." right now, you're not the party leader.") end;
				elseif(GetNumPartyMembers() == 4)then --if you've got a 5-man party (GetNumPartyMembers excludes yourself) convert to raid.
					if(IsPartyLeader()) then 
						DEFAULT_CHAT_FRAME:AddMessage("Raid mode enabled: Converting your group to a raid.")
						ConvertToRaid();
						InviteByName(BList[j]);
					else
						DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..BList[j].." right now, you're not the party leader.");
					end
				end
			elseif((IsRaidLeader() or IsRaidOfficer()) and numgroup < 40) then InviteByName(BList[j])
			else
				if(numgroup > 39) then return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..BList[j].." right now, raid is full.");
				else return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..BList[j].." right now, you're not the raid leader.") end;
			end
		end
	end
end

function AutoInvite_SlashHandler(msg)
	if(msg ~= "") then msg = string.lower(msg) end;
	if(msg == "" or msg == "status") then
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite status: |c00ffff00"..AutoInviteOptions[Realm][Player]["Status"].."|r (change with /ai on | off)");
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite keyword: |c00ffff00"..AutoInviteOptions[Realm][Player]["Invite"].."|r (change with /ai text)");
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite party type: |c00ffff00"..AutoInviteOptions[Realm][Player]["Type"].."|r (change with /ai party | raid)");
	elseif(msg == "on") then 
		AutoInviteOptions[Realm][Player]["Status"] = "On";
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite: Now issuing automatic invites on keyword[s]: |c00ffff00"..AutoInviteOptions[Realm][Player]["Invite"].."|r");
	elseif(msg == "off") then 
		AutoInviteOptions[Realm][Player]["Status"] = "Off";
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite: No longer issuing automatic invites." ,1,1,1);
	elseif(msg == "party") then 
		AutoInviteOptions[Realm][Player]["Type"] = "Party";
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite: Invite checking for 5-man party only." ,1,1,1);
	elseif(msg == "alist") then 
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite: Starting Invites of Priority List." ,1,1,1);
		InviteAList();
	elseif(msg == "blist") then 
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite: Starting Invites of Secondary List." ,1,1,1);
		InviteBList();
	elseif(msg == "raid") then 
		AutoInviteOptions[Realm][Player]["Type"] = "Raid";
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite: Invite checking for 40-man raid groups." ,1,1,1);
	else 
		AutoInviteOptions[Realm][Player]["Invite"] = msg;
		DEFAULT_CHAT_FRAME:AddMessage("AutoInvite: changed automatic invite keyword[s] to: |c00ffff00"..AutoInviteOptions[Realm][Player]["Invite"].."|r");
	end
end

function AutoInvite_CheckMessage(what)
	return string.find(string.lower(what), AutoInviteOptions[Realm][Player]["Invite"], 1, true);
end

function AutoInvite_Invite(who)
	local numgroup;
	local gtype = AutoInviteOptions[Realm][Player]["Type"];
	if(gtype == "Party") then
		numgroup = GetNumPartyMembers();
		if((IsPartyLeader() and numgroup < 4) or (numgroup == 0)) then InviteByName(who)
		else 
			if(numgroup >= 4) then return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..who.." right now, party is full.");
			else return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..who.." right now, you're not the party leader.") end;
		end
	elseif(gtype == "Raid") then
		numgroup = GetNumRaidMembers();
		if(numgroup == 0) then --Not currently in a raid
			numparty = GetNumPartyMembers();
			if(numparty == 0) then InviteByName(who) --Nobody in the party? Start a new one!
			elseif(numparty < 4) then
				if(IsPartyLeader()) then InviteByName(who) --4 or less party members? Invite if you can.
				else return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..who.." right now, you're not the party leader.") end;
			elseif(GetNumPartyMembers() == 4)then --if you've got a 5-man party (GetNumPartyMembers excludes yourself) convert to raid.
				if(IsPartyLeader()) then 
					DEFAULT_CHAT_FRAME:AddMessage("Raid mode enabled: Converting your group to a raid.")
					ConvertToRaid();
					InviteByName(who);
				else
					DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..who.." right now, you're not the party leader.");
				end
			end
		elseif((IsRaidLeader() or IsRaidOfficer()) and numgroup < 40) then InviteByName(who)
		else
			if(numgroup > 39) then return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..who.." right now, raid is full.");
			else return DEFAULT_CHAT_FRAME:AddMessage("Can't invite "..who.." right now, you're not the raid leader.") end;
		end
	end
end
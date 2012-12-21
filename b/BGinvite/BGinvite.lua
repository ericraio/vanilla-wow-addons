BGvar_save = {}
BGvar_declined = {}
BGvar_hideingroup = {}
BGvar_hideinvite = {}
BGvar_nothere = {}
BGvar_ingroup = {}
BGvar_dropgroupmessagesent = {}
BGvar_blacklist = {}
BGvar_timers_convertspam = GetTime()
BGvar_save.purge = "disabled"
BGvar_save.auto = "disabled"
BGvar_save.magicword = "invite"
BGvar_version = "2.0 alpha"


function BGinvite_OnLoad()
	this:RegisterEvent("PARTY_MEMBERS_CHANGED")
	this:RegisterEvent("CHAT_MSG_SYSTEM")
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("CHAT_MSG_WHISPER")
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
	Pre_BGinvite_ChatFrame_OnEvent = ChatFrame_OnEvent
	ChatFrame_OnEvent = BGinvite_hidealreadyingroupmsg

	SLASH_BGINVITE1 = "/bginvite";
	SlashCmdList["BGINVITE"] = function ( msg )
		BGinvite_SlashCmdHandler(msg);
	end
end

function BGinvite_OnEvent(event)
	if (event == "CHAT_MSG_SYSTEM") then
		if string.find(arg1, BGlocal_BLANK_DECLINES_YOUR_INVITATION) then
			local _, _, player = string.find(arg1, BGlocal_BLANK_DECLINES_YOUR_INVITATION_FIND)
			BGvar_declined[player] = GetTime()
			BGvar_ingroup[player] = nil
			BGvar_dropgroupmessagesent[player] = 1 -- because they aren't going to want to be told to drop group if they previously declined your invite
		elseif string.find(arg1, BGlocal_BLANK_IS_IGNORING_YOU) then
			local _, _, player = string.find(arg1, BGlocal_BLANK_IS_IGNORING_YOU_FIND)
			BGvar_declined[player] = GetTime()
			BGvar_ingroup[player] = nil
		elseif string.find(arg1, BGlocal_BLANK_HAS_JOINED_THE_RAID) then
			local _, _, player = string.find(arg1, BGlocal_BLANK_HAS_JOINED_THE_RAID_FIND) 
			BGvar_ingroup[player] = nil
		elseif string.find(arg1, BGlocal_BLANK_HAS_JOINED_THE_PARTY) then
			local _, _, player = string.find(arg1, BGlocal_BLANK_HAS_JOINED_THE_PARTY_FIND)
			BGvar_ingroup[player] = nil
		elseif string.find(arg1, BGlocal_BLANK_IS_ALREADY_IN_GROUP) then
			local _, _, player = string.find(arg1, BGlocal_BLANK_IS_ALREADY_IN_GROUP_FIND)
			if BGvar_dropgroupmessagesent[player] == nil then
				if (BGinvite_DominantGroup() == true) then
					BGinvite_localizevarvar(GetLocale())
					SendChatMessage(BGlocal_LEAVE_GROUP_WHISPER, "WHISPER", this.language, player)
					BGvar_dropgroupmessagesent[player] = 1
				end
			end
		elseif (arg1 == BGlocal_YOU_JOINED_RAID_GROUP) and (BGvar_restofinvitespending == 1) then
			BGinvite_autoinvites()
			BGvar_restofinvitespending = 0
		elseif string.find(arg1, BGlocal_SOMEONE_JOINED_BG) then
			BGinvite_autoinvites()		
			-- debug BGinvite_print("someone joined the BG! invite!") -- debug
		elseif string.find(arg1, BGlocal_SOMEONE_LEFT_BG) then
			local _, _, player = string.find(arg1, BGlocal_SOMEONE_LEFT_BG_FIND)
			-- debug BGinvite_print(player.." left the BG! kick him!")
			if (BGvar_save.purge == "disabled") then return end
				if IsRaidLeader() or IsRaidOfficer() then 
								SendChatMessage(BGlocal_YOU_APPEAR_GONE, "WHISPER", this.language, name)
								UninviteByName(name)
				end
			
		end
		
	elseif (event == "VARIABLES_LOADED") then
		BGinvite_localize(GetLocale())
		BGinvite_print(BGlocal_MOD_LOADED)
		BGinvite_autoinvites()
	elseif (event == "CHAT_MSG_WHISPER") then
		if string.find(string.lower(arg1), BGvar_save.magicword) and (strlen(arg1) <= (strlen(BGvar_save.magicword) + 8)) then
			if BGvar_blacklist[arg2] ~= 1 then
				InviteByName(arg2)
			end
		end
	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		BGvar_declined = {}
		BGvar_nothere = {}
		BGvar_hideinvite = {}
		BGvar_ingroup = {}
		BGvar_messageinsay = 0
		BGvar_dropgroupmessagesent = {}
	end
end

function BGinvite_SlashCmdHandler(msg)
	if strlen(msg) <= 1 then
		BGInviteUI:Show()
	elseif string.lower(msg) == "purge on" then
		BGvar_save.purge = "enabled" 
	    BGInviteAutoPurgeEnable:SetChecked(1)
		BGinvite_print(BGlocal_NOW_PURGING)
	elseif string.lower(msg) == "purge off" then
		BGvar_save.purge = "disabled" 
		BGinvite_print(BGlocal_NOT_PURGING)
		BGInviteAutoPurgeEnable:SetChecked(0)
	elseif (string.lower(msg) == "auto on") then
		BGvar_save.auto = "enabled"
		BGinvite_autoinvites()
		BGinvite_print(BGlocal_AUTO_INVITING)
		BGInviteAutoInviteEnable:SetChecked(1)
	elseif (string.lower(msg) == "auto off") then
		BGvar_save.auto = "disabled"
		BGinvite_print(BGlocal_NOT_AUTO_INVITING)
		BGInviteAutoInviteEnable:SetChecked(0)
	elseif (string.lower(msg) == "promote all") then
		BGinvite_promoteall()
	elseif (string.lower(msg) == "demote all") then
		BGinvite_demoteall()
	elseif (string.lower(msg) == "invite") then
		BGinvite_sendinvite()
	elseif (string.lower(msg) == "blacklist") then
		BGinvite_print(BGlocal_BLACKLISTED_PLAYERS)
		table.foreach(BGvar_blacklist, BGinvite_displayblacklist)
	elseif (strsub(string.lower(msg), 1, 13) == "blacklist add") then
		local name = string.upper(strsub(msg, 15, 15))..string.lower(strsub(msg, 16))
		BGinvite_blacklistadd(name)
	elseif (strsub(string.lower(msg), 1, 16) == "blacklist remove") then
		local name = string.upper(strsub(msg, 18, 18))..string.lower(strsub(msg, 19))
		BGinvite_blacklistremove(name)
	elseif (strsub(string.lower(msg), 1, 9) == "magicword") then
		BGvar_save.magicword = string.lower(strsub(msg, 11))
		BGinvite_magicwordchanged()
	elseif (string.lower(msg) == "help") then
		BGinvite_help()
	elseif (string.lower(msg) == "version") then
		BGinvite_print(BGlocal_VERSION_STR)
	else
		BGinvite_print(BGlocal_HELP_ERR) 
	end
end

function BGinvite_sendinvite()
	local status = BGinvite_GetBattlefieldStatus()
	if (BGvar_messageinsay == 0) and (status == "active") then
		SendChatMessage(BGlocal_SAY_INVITING, "SAY")
		BGvar_messageinsay = 1
	end
	if (GetNumRaidMembers() == 0) and (GetNumBattlefieldPositions() >= 5) then
		for i=1,5 do
			local x, y, name = GetBattlefieldPosition(i)
			if (not BGvar_declined[name]) and (name) then
				if BGvar_blacklist[name] ~= 1 then
					InviteByName(name)
				end
			end
		end
	else
		for i=1,GetNumBattlefieldPositions() do
			local x, y, name = GetBattlefieldPosition(i)
			if (not BGvar_declined[name]) then
				if BGvar_blacklist[name] ~= 1 then
					InviteByName(name)
				end
			end
		end
	end
end



function BGinvite_ConvertToRaid()
	BGinvite_print(BGlocal_CONVERTING_TO_RAID)
	ConvertToRaid()
	BGvar_restofinvitespending = 1
end

--function BGinvite_purge()
--	if (BGvar_save.purge == "disabled") then return end
--	if IsRaidLeader() or IsRaidOfficer() then 
--		BGinvite_print(BGlocal_PURGING_PLAYERS)
--		if GetBattlefieldScore(1) == nil then
--			BGinvite_print(BGlocal_ERROR_SCANNING)
--		elseif GetBattlefieldScore(1) ~= nil then
--			for i=1,GetNumRaidMembers() do
--				local name = GetRaidRosterInfo(i)
--				BGvar_inbg = false
--				if (BGinvite_inbattleground(name) ~= true) then
--					SendChatMessage(BGlocal_YOU_APPEAR_GONE, "WHISPER", _, name)
--					UninviteByName(name)
--				end
--			end
--		end
--	end
--end

function BGinvite_inbattleground(name)
	for i=1,80 do
		local bgname = GetBattlefieldScore(i)	
		if (bgname == name) then
			BGvar_inbg = true
		end
	end

	if BGvar_inbg == false then
		if (BGvar_nothere[name]) then
			BGvar_nothere[name] = BGvar_nothere[name] + 1
			if BGvar_nothere[name] >= 2 then
				return false
			end
		else
			BGvar_nothere[name] = 1
			return true
		end
	elseif BGvar_inbg == true then
		BGvar_nothere[name] = 0  
		return true
	end
end

function BGinvite_autoinvites()
	if (BGvar_save.auto == "disabled") then return end
	if IsRaidLeader() then
		if (GetNumRaidMembers() == 0) and (GetNumBattlefieldPositions() >= 5) then
			for i=1,5 do
				local x, y, name = GetBattlefieldPosition(i)
				if (not BGvar_declined[name]) then
					if BGvar_blacklist[name] ~= 1 then
						BGvar_hideingroup[name] = 1
						BGvar_hideinvite[name] = 1
						InviteByName(name)
					end
				end
			end
		else	
			for i=1,GetNumBattlefieldPositions() do
				local x, y, name = GetBattlefieldPosition(i)
				if (not BGvar_declined[name]) then
					if BGvar_blacklist[name] ~= 1 then
						BGvar_hideingroup[name] = 1
						BGvar_hideinvite[name] = 1
						InviteByName(name)
					end
				end
			end
		end
	end
	BGvar_timers_BGAUTOINVITE = GetTime() + 3
end

		
function BGinvite_hidealreadyingroupmsg(event)
	if (event == "CHAT_MSG_SYSTEM") then
		if string.find(arg1, BGlocal_BLANK_IS_ALREADY_IN_GROUP) then
			local _, _, player = string.find(arg1, BGlocal_BLANK_IS_ALREADY_IN_GROUP_FIND)
		
			if (BGvar_hideingroup[player] == 1) then
				BGvar_hideingroup[player] = 0
			else
				Pre_BGinvite_ChatFrame_OnEvent(event)
			end
		elseif string.find(arg1, BGlocal_YOU_HAVE_INVITED) then
			local _, _, player = string.find(arg1, BGlocal_YOU_HAVE_INVITED_FIND)
		
			if (BGvar_hideinvite[player] == 1) then
				BGvar_hideinvite[player] = 0
			else
				Pre_BGinvite_ChatFrame_OnEvent(event)
			end
		else
			Pre_BGinvite_ChatFrame_OnEvent(event)
		end
	else
		Pre_BGinvite_ChatFrame_OnEvent(event)
	end
end

function BGinvite_displayblacklist(name)
	if BGvar_blacklist[name] == 1 then
		BGinvite_print(name)
	end
end

function BGinvite_OnUpdate()
	if BGvar_timers_BGAUTOINVITE then
		if BGvar_timers_BGAUTOINVITE <= GetTime() then
			BGinvite_autoinvites()
			BGvar_timers_BGAUTOINVITE = GetTime() + 3
		end
	end
	if (GetNumPartyMembers() > 0) and (GetNumRaidMembers() == 0) and (BGvar_timers_convertspam <= GetTime()) and (IsRaidLeader()) then
	local status = BGinvite_GetBattlefieldStatus()
		if (status == "active") then
			BGvar_timers_convertspam = GetTime()+3
			BGinvite_ConvertToRaid()
		end
	end
end

function BGinvite_DominantGroup()
	local numpeople_notingroup = GetNumBattlefieldPositions()
	local numpeople_ingroup = GetNumRaidMembers()
		if numpeople_notingroup < numpeople_ingroup then
			return true
		else
			return false
		end
end

function BGinvite_print(msg)
	ChatFrame1:AddMessage(msg, 0, .5, 1)
end

function BGinvite_promoteall()
		for i=1, GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i)
			PromoteToAssistant(name)
		end
end

function BGinvite_demoteall()
		for i=1, GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i)
			DemoteAssistant(name)
		end
end

function BGinvite_help()
	BGinvite_print(BGlocal_HELP_1)
	BGinvite_print(BGlocal_HELP_2)
	BGinvite_print(BGlocal_HELP_3)
	BGinvite_print(BGlocal_HELP_4)
	BGinvite_print(BGlocal_HELP_5)
	BGinvite_print(BGlocal_HELP_6)
	BGinvite_print(BGlocal_HELP_7)
	BGinvite_print(BGlocal_HELP_8)
	BGinvite_print(BGlocal_HELP_9)
	BGinvite_print(BGlocal_HELP_10)
end

function BGinvite_magicwordchanged()
	BGinvite_localizevarvar(GetLocale())
	BGinvite_print(BGlocal_MAGICWORD_CHANGE)
end

function BGinvite_blacklistremove(name)
	if (BGvar_blacklist[name]) then
		BGvar_blacklist[name] = nil
		BGinvite_print(name..BGlocal_HAS_BEEN_REMOVED)
	else
		BGinvite_print(name..BGlocal_WASNT_ON_BLACKLIST)
	end
end

function BGinvite_blacklistadd(name)
	if (BGvar_blacklist[name]) then
		if BGvar_blacklist[name] == 1 then
			BGinvite_print(name..BGlocal_IS_ALREADY_BLACKLISTED)
		elseif BGvar_blacklist[name] ~= 1 then
			BGvar_blacklist[name] = 1
			BGinvite_print(name..BGlocal_HAS_BEEN_ADDED_BLACKLIST)
		end
	else
		BGvar_blacklist[name] = 1
		BGinvite_print(name..BGlocal_HAS_BEEN_ADDED_BLACKLIST)
	end
end

function BGinvite_GetBattlefieldStatus()
	for i=1,MAX_BATTLEFIELD_QUEUES do
		if GetBattlefieldStatus(i) == "active" then
			local status = "active"
		end
	end
	if status == "active" then 
		return "active"
	else
		return "none"
	end
end

	
		 
		
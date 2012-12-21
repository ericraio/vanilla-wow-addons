--[[
	FollowTheLeader

	By Torgo <jimmcq@concentric.net>

	If someone tells you to "follow" them, you will.  If they tell you to "stop" you will stop following them.  These commands must come in the form of a tell/whisper.  You will only follow players that are in your party, on you friends list, or in your guild.

	Feel free to use any of this code in other mods, or to modify this AddOn itself.  My only request is that you send me your modifications.

	URL: http://curse-gaming.com/mod.php?addid=1216
	
   ]]

FTL_Version = "1.1.1";
FTL_Leader = nil;

function FTL_ProcessChat(msg, name)
	msg = string.lower(msg);
	if (string.find(msg, "follow") and not string.find(msg, "auto")) then
		DEFAULT_CHAT_FRAME:AddMessage("I'm in", 1, 0, 0);
		if (OKtoFollow(name)) then
			FTL_Leader = name;
			FollowByName(name);
		end
	elseif (string.find(msg, "stop") and name == FTL_Leader) then
		MoveBackwardStart(GetTime()*1000 + 1);
		MoveBackwardStop(GetTime()*1000 + 2);
		MoveForwardStart(GetTime()*1000 + 3);
		MoveForwardStop(GetTime()*1000 + 4);
	elseif (string.find(msg, "mount") and name == FTL_Leader and AutoMount_GetMountItemBagSlot) then
		local bag, slot = AutoMount_GetMountItemBagSlot();
		if ( bag ) and ( slot ) then
			UseContainerItem(bag, slot);
		else
			if (name ~= UnitName("player")) then
				SendChatMessage("I can't seem to find my mount.", "WHISPER", GetLanguageByIndex(0), name);
			end
		end
	end
end

function FTL_ProcessError(msg)
	if (msg == ERR_AUTOFOLLOW_TOO_FAR) then
		if (FTL_Leader ~= nil) then
			FTL_TooFar(FTL_Leader);
			FTL_Leader = nil;
		end
	elseif (msg == ERR_INVALID_FOLLOW_TARGET) then
		FTL_Leader = nil;
	elseif (msg == ERR_TOOBUSYTOFOLLOW) then
		SendChatMessage("I'm too busy to auto-follow you right now, try again in a moment.", "WHISPER", GetLanguageByIndex(0), FTL_Leader);
		FTL_Leader = nil;
	end
end

function FTL_Following(name)
	SendChatMessage("I'm auto-following you", "WHISPER", GetLanguageByIndex(0), name);
	FTL_Leader = name;
end

function FTL_Stopped()
	if (FTL_Leader ~= nil) then
		SendChatMessage("I stopped auto-following you", "WHISPER", GetLanguageByIndex(0), FTL_Leader);
		FTL_Leader = nil;
	end
end

function FTL_TooFar(name)
	tMessage = "I can't auto-follow, you must be too far away.  I'm ";

	x, y = GetPlayerMapPosition("player");
	x = math.floor(x*100.0);
	y = math.floor(y*100.0);
	if ((x > 0) or (y > 0)) then
		tMessage = tMessage.." at Location: "..x..","..y;
	end
	
	tLoc = GetMinimapZoneText();
	tMessage = tMessage.." in "..tLoc;
	
	SendChatMessage(tMessage, "WHISPER", GetLanguageByIndex(0), name);
end

function OKtoFollow(name)
	-- Check to see if 'name' is in your party
	numParty = GetNumPartyMembers()
	if (numParty > 0) then
		for i=1, numParty do
			if (UnitName("party"..i) == name) then
				return true;
			end
		end
	end
	
	-- Check to see if 'name' is on your friends list
	local numFriends = GetNumFriends();
	if ( numFriends > 0 ) then
		for friendIndex=1, numFriends do
			friendName = GetFriendInfo(friendIndex);
			if (friendName == name) then
				return true;
			end
		end
	end
	
	-- Check to see if 'name' is in your guild
	if (IsInGuild()) then
		for i=1, GetNumGuildMembers(), 1 do
			guildMemberName = GetGuildRosterInfo(i);
			if (guildMemberName == name) then
				return true;
			end
		end
	end
	
	-- None of the above
	return false;
end
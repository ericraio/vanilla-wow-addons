BGvar_BlackList = {};
BGvar_NotInBG = {};

BGInvite_Var = {};
BGInvite_Var.debug = false;

BGvar_initialMessageSent = false;
BGvar_AutoInviteTimer = 0;
BGvar_AutoPurgeTimer = 0;

BGInvite_ITEM_HEIGHT = 32;
BGInvite_ITEMS_SHOWN = 7;

BGInvite_Config = {
	 AutoInvite = 0
	,AutoPurge = 0
	,MagicWord = "invite"
	,RetryTimeout = 20
	,PurgeTimeout = 120
	,MaxRetries = 5
	,SendWhisper = 1
	,AutoInviteTimeout = 5
	,MsgChannelId=1
	,Disable
};

local Pre_BGinvite_ToggleWorldStateScoreFrame;
local Pre_BGinvite_ChatFrame_OnEvent;
local chatParseInfoMagicWordWhisper = { AddOn = "BGInvite" };
local chatParseInfoMagicWordSay = { AddOn = "BGInvite" };

UIPanelWindows["BGInviteFrame"] = { area = "left", pushable = 3 };
BGINVITE_TAB_SUBFRAMES = { "BGInvite_OptionsFrame", "BGInvite_BlackListFrame" };

--[[
=============================================================================
=============================================================================
]]
function BGInvite_GetBattleFieldStatus()
	for i=1, MAX_BATTLEFIELD_QUEUES do
	   status, mapName, instanceID = GetBattlefieldStatus(i);
	   --BGDebugMessage("DEBUG","status="..status.." mapName="..mapName.." id="..instanceID,"debug");
	   if ( instanceID ~= 0 ) then
		   mapName = mapName.." "..instanceID;
		   return status,mapName,instanceID;
	   end
	end
	--status="active"; 
	return status,mapName,instanceID;

end

function MagicWordChanged()
BGDebugMessage("DEBUG","magicword changed="..BGInvite_Config.MagicWord,"debug");
	chatParseInfoMagicWordWhisper.template = BGInvite_Config.MagicWord;
	chatParseInfoMagicWordSay.template = BGInvite_Config.MagicWord;

	BGChatParse_UnregisterEvent(chatParseInfoMagicWordWhisper);
	BGChatParse_UnregisterEvent(chatParseInfoMagicWordSay);

	BGChatParse_RegisterEvent(chatParseInfoMagicWordWhisper);
	BGChatParse_RegisterEvent(chatParseInfoMagicWordSay);
end

--[[
=============================================================================
The loading frame handles getting our AddOn initialized properly 
=============================================================================
]]
function BGInviteLoadingFrame_OnUpdate()
	if ( BGInviteFrame.loaded ) then
		BGInviteLoadingFrame:UnregisterEvent("VARIABLES_LOADED");
		BGInviteLoadingFrame:UnregisterEvent("UNIT_NAME_UPDATE");
		BGInviteLoadingFrame:Hide();
		BGInviteLoadingFrame = nil;
	elseif ( BGInviteLoadingFrame.loadTime + 2 <= GetTime() ) then
		BGInviteFrame_LoadData();
		BGInviteLoadingFrame.loadTime = GetTime();
	end
end

function BGInviteLoadingFrame_OnLoad()
	BGInviteLoadingFrame:RegisterEvent("VARIABLES_LOADED");
	BGInviteLoadingFrame:RegisterEvent("UNIT_NAME_UPDATE");
	BGInviteLoadingFrame.init = 0;
	BGInviteLoadingFrame.loadTime = GetTime();

end

function BGInviteLoadingFrame_OnEvent(event, arg1)
	if ( not BGInviteLoadingFrame ) then
		return;
	end
	if ( event == "VARIABLES_LOADED" or event == "UNIT_NAME_UPDATE" ) then
		BGInviteLoadingFrame.init = BGInviteLoadingFrame.init + 1;
		BGInviteFrame_LoadData();
	end

	if ( BGInviteLoadingFrame.init >= 2 ) then
		BGInviteFrame_LoadData();
	end

end

--[[
=============================================================================
Variable initialization
=============================================================================
]]
function BGInviteFrame_LoadData()
	BGInviteFrame.loaded = true;
	-- check each variable to ensure its set
	if ( BGInvite_Config.AutoInvite == nil) then
		BGInvite_Config.AutoInvite = 0;
	end
	if ( BGInvite_Config.AutoPurge == nil) then
		BGInvite_Config.AutoPurge = 0;
	end
	if ( BGInvite_Config.MagicWord == nil) then
		BGInvite_Config.MagicWord = "invite";
	end
	if ( BGInvite_Config.RetryTimeout == nil ) then
		BGInvite_Config.RetryTimeout = 20;
	end
	if ( BGInvite_Config.PurgeTimeout == nil ) then
		BGInvite_Config.PurgeTimeout = 120;
	end	
	if ( BGInvite_Config.MaxRetries == nil ) then
		BGInvite_Config.MaxRetries = 5;
	end	
	if ( BGInvite_Config.SendWhisper == nil ) then
	BGDebugMessage("DEBUG","SendWhisper=nil","debug");
		BGInvite_Config.SendWhisper = 1;
	end	
	if ( BGInvite_Config.AutoInviteTimeout == nil ) then
		BGInvite_Config.AutoInviteTimeout = 5;
	end		
	if ( BGInvite_Config.MsgChannelId == nil ) then
		BGInvite_Config.MsgChannelId = 1;
	end		
	if ( BGInvite_Config.Disable == nil ) then
		BGInvite_Config.Disable = 0;
	end		
	
end

function BGInvite_ResetVariables()
	BGInviteClearVars();
	BGInvite_Config = {};
--		 AutoInvite = 0
--		,AutoPurge = 0
--		,MagicWord = "invite"
--		,RetryTimeout = 20
--		,PurgeTimeout = 120
--	};	
end

--[[
=============================================================================
Initialization.
=============================================================================
]]
function BGInviteFrame_OnLoad()

	this:RegisterEvent("PARTY_MEMBERS_CHANGED")
	this:RegisterEvent("VARIABLES_LOADED")	
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
	this:RegisterEvent("CHAT_MSG_SAY");
	this:RegisterEvent("CHAT_MSG_YELL");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_SYSTEM"); --(ie user joins the battlefield msgs?)
	this:RegisterEvent("CHAT_MSG_WHISPER")
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
	this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	this:RegisterEvent("UI_INFO_MESSAGE");	 
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");	 
	
	Pre_BGinvite_ChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = BGinvite_ChatFrame_OnEvent;

	SLASH_BGINVITE1 = "/bginvite";
	SlashCmdList["BGINVITE"] = function ( msg )
		BGinvite_SlashCmdHandler(msg);
	end

	-- Intall ChatMessge handlers
	local chatParseInfo = { AddOn = "BGInvite" };
	chatParseInfo.event    = "CHAT_MSG_SYSTEM";
	chatParseInfo.func     = function(t) BGInvite_AddBlackList(t.name,BGINVITE_DECLINED); end;
	chatParseInfo.template = BGlocal_BLANK_DECLINES_YOUR_INVITATION;
	chatParseInfo.english  = "%s declines your group invitation.";
	chatParseInfo.fields   = { "name" };
	BGChatParse_RegisterEvent(chatParseInfo);
	
	local chatParseInfo1 = { AddOn = "BGInvite" };
	chatParseInfo1.event    = "CHAT_MSG_SYSTEM";
	chatParseInfo1.func     = function(t) BGInvite_AddBlackList(t.name, BGINVITE_DECLINED); end;
	chatParseInfo1.template = BGlocal_BLANK_IS_IGNORING_YOU;
	chatParseInfo1.english  = "%s is ignoring you.";
	chatParseInfo1.fields   = { "name" };
	BGChatParse_RegisterEvent(chatParseInfo1);

	local chatParseInfo2 = { AddOn = "BGInvite" };
	chatParseInfo2.event    = "CHAT_MSG_SYSTEM";
	chatParseInfo2.func     = function(t) BGInvite_AddBlackList(t.name,BGINVITE_ALREADY_IN_GROUP); end;
	chatParseInfo2.template = BGlocal_BLANK_IS_ALREADY_IN_GROUP;
	chatParseInfo2.english  = "%s is already in a group.";
	chatParseInfo2.fields   = { "name" };
	BGChatParse_RegisterEvent(chatParseInfo2);
	
	chatParseInfoMagicWordWhisper.event    = "CHAT_MSG_WHISPER";
	chatParseInfoMagicWordWhisper.func     = function(t) BGInvite_MagicWordWhisperInvite(t.player); end;
	chatParseInfoMagicWordWhisper.template = BGInvite_Config.MagicWord;
	chatParseInfoMagicWordWhisper.english  = BGInvite_Config.MagicWord;
	chatParseInfoMagicWordWhisper.fields   = {  };
	BGChatParse_RegisterEvent(chatParseInfoMagicWordWhisper);

	chatParseInfoMagicWordSay.event    = "CHAT_MSG_SAY";
	chatParseInfoMagicWordSay.func     = function(t) BGInvite_MagicWordInvite(t.player); end;
	chatParseInfoMagicWordSay.template = BGInvite_Config.MagicWord;
	chatParseInfoMagicWordSay.english  = BGInvite_Config.MagicWord;
	chatParseInfoMagicWordSay.fields   = {  };
	BGChatParse_RegisterEvent(chatParseInfoMagicWordSay);
	

	local chatParseInfo3 = { AddOn = "BGInvite" };
	chatParseInfo1.event    = "CHAT_MSG_SYSTEM";
	chatParseInfo1.func     = function(t) BGDebugMessage("DEBUG","days is "..t.days,"debug"); end;
	chatParseInfo1.template = "%d days";
	chatParseInfo1.english  = "%s is ignoring you.";
	chatParseInfo1.fields   = { "days" };
	BGChatParse_RegisterEvent(chatParseInfo3);

	-- Tab Handling code
	PanelTemplates_SetNumTabs(BGInviteFrame, 2);
	PanelTemplates_SetTab(BGInviteFrame, 1);
	
	--RegisterForSave("BGInvite_Config");

	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(BGINVITE_TITLE.." AddOn loaded.  Use /bginvite");
	end
	UIErrorsFrame:AddMessage(loadMessage, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	
end

--[[
=============================================================================
The main event handler.  Gets called when any event we are subscribed to is fired
=============================================================================
]]
function BGInviteFrame_OnEvent(event)
	--BGDebugMessage("DEBUG","event="..event,"debug");

	if (BGInvite_Config.Disable == 1 ) then
		return;
	end

	if (event == "ZONE_CHANGED_NEW_AREA") then
		BGInviteClearVars();		
	end

	-- ready to convert to a raid?
	if ( IsPartyLeader() and GetNumPartyMembers() >= 3 and GetNumRaidMembers() == 0 ) then
		BGinvite_ConvertToRaid();
	end
	
-- If already in a Raid, no need to send out the initial message	
-- This is true when another player started the raid and you are now an officer and can invite
	if ( IsRaidLeader() or IsRaidOfficer() ) then
		BGvar_initialMessageSent = true;
	end
	

-- Handle invites
	if ( (IsPartyLeader() or IsRaidLeader() or IsRaidOfficer()) and (BGInvite_Config.AutoInvite == 1) and (BGvar_AutoInviteTimer+BGInvite_Config.AutoInviteTimeout < GetTime() )) then
		BGinvite_sendinvites();
	end

-- Handle purges
	if ((IsPartyLeader() or IsRaidLeader() or IsRaidOfficer()) and (BGInvite_Config.AutoPurge == 1) and (BGvar_AutoPurgeTimer+BGInvite_Config.PurgeTimeout < GetTime() ) ) then 
		BGinvite_purge();
	end
	
end

--[[
=============================================================================
=============================================================================
]]
function BGInviteClearVars()
	--BGvar_BlackList = {};
	BGInviteClearBlackListExceptPerms();
	BGvar_initialMessageSent = false;	
end

function BGInviteClearBlackList()
	BGvar_BlackList = {};
end

-- Only removes the players that were added because
-- they were in a group.
-- Leaves Declines and Manual adds
function BGInviteClearBlackListExceptPerms()
	for key,value in BGvar_BlackList do 
		if ( value.reason == BGINVITE_ALREADY_IN_GROUP ) then
			table.remove(BGvar_BlackList,key);
		elseif ( value.reason == BGINVITE_DECLINED ) then
			table.remove(BGvar_BlackList,key);
		end
	end
end

--[[
=============================================================================
Toggles the BGInvite UI on/off.  Gets called by tab click handler
=============================================================================
]]
function toggleBGInvite(tab)
	if ( not tab ) then
		if ( BGInviteFrame:IsVisible() ) then
			HideUIPanel(BGInviteFrame);
		else
			ShowUIPanel(BGInviteFrame);
			local selectedFrame = getglobal(BGINVITE_TAB_SUBFRAMES[BGInviteFrame.selectedTab]);
			if ( not selectedFrame:IsVisible() ) then
				selectedFrame:Show();
			end
		end
	else
		local subFrame = getglobal(tab);
		if ( subFrame ) then
			PanelTemplates_SetTab(BGInviteFrame, subFrame:GetID() );
			if ( BGInviteFrame:IsVisible() ) then
				if ( subFrame:IsVisible() ) then
					HideUIPanel( BGInviteFrame );
				else
					PlaySound("igCharacterInfoTab");
					BGInviteFrame_ShowSubFrame(tab);
				end
			else
				ShowUIPanel( BGInviteFrame );
				BGInviteFrame_ShowSubFrame(tab);
			end
		end
	end

end

--[[
=============================================================================
Shows or hides a subframe (tab)
=============================================================================
]]
function BGInviteFrame_ShowSubFrame(frameName)
	for index, value in BGINVITE_TAB_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end
	end
end


--[[
=============================================================================
Called when you click on any Tab and decodes into the correct tab to show.
=============================================================================
]]
function BGInviteTab_OnClick()
	if ( this:GetName() == "BGInviteFrameTab1" ) then
		toggleBGInvite("BGInvite_OptionsFrame");
	elseif ( this:GetName() == "BGInviteFrameTab2" ) then
		toggleBGInvite("BGInvite_BlackListFrame");
	end
	PlaySound("igCharacterInfoTab");
end

--[[
=============================================================================
Handles slash commands.  Most of the switches are for debugging/testing
=============================================================================
]]
function BGinvite_SlashCmdHandler(msg)		
if (string.lower(msg) == "promote all") then
		BGinvite_promoteall()
	elseif (string.lower(msg) == "demote all") then
		BGinvite_demoteall()
	elseif (string.lower(msg) == "invite") then
		BGinvite_sendinvites()
	elseif (string.sub(msg,1,6) == "invite") then
	BGDebugMessage("debug","invname="..string.sub(msg,8),"debug");
		BGInvite_SendInvite(string.sub(msg,8));
	elseif (msg == "testaig1" ) then
		testAlreadyInGroup();		
	elseif (msg == "testaig2" ) then
		testAIG();
	elseif (msg == "testaig3" ) then
		testAIG3();		
	elseif (msg == "vi" ) then
		vi();
	elseif (msg == "aig" ) then
		dumpAIG();
	elseif (string.sub(msg,1,7) == "cleanse") then
		testcleanse(string.sub(msg,9));
	elseif (string.sub(msg,1,3) == "aig") then
		BGInvite_AddBlackList(string.sub(msg,5),BGINVITE_ALREADY_IN_GROUP);	
	elseif (string.sub(msg,1,4) == "aig2") then
		BGInvite_AddBlackList(string.sub(msg,6),BGINVITE_DECLINED);	
	elseif (string.sub(msg,1,4) == "nibg") then
		BGinvite_inbattleground(string.sub(msg,6));
		table.foreach(BGvar_NotInBG, debugprintAIG); 
	elseif (msg == "testbg" ) then
		local status,mapname,instanceid = BGInvite_GetBattleFieldStatus();
		BGDebugMessage("debug","status="..status.." mapname="..mapname.." instance="..instanceid,"debug");
	elseif (msg == "scores") then
		debugDumpBGScores();
	elseif (msg == "reset") then
		BGInvite_ResetVariables();
	elseif (msg == "purge") then
		BGinvite_purge();
	elseif (msg == "testgroup") then
		testgroup();
	elseif (msg == "testmath") then
		testmath();
	elseif (msg == "testmatch") then
		testmatch();
	elseif (msg == "testcleanser") then
		testcleanser();
	elseif (msg == "channel") then		
		mychannel();
	else
		toggleBGInvite();
	end	
end


--[[
=============================================================================
Called when the player clicks "Send Invites" in the UI or when AutoInvites
are enabled.
=============================================================================
]]
function BGinvite_sendinvites()
	local status, mapName, instanceID = BGInvite_GetBattleFieldStatus()
	if ( status ~= "active" ) then
		return;
	end
	if (not BGvar_initialMessageSent) then
		SendChatMessage(BGlocal_SAY_INVITING, "SAY")
		BGvar_initialMessageSent = true;
	end
	
	-- Clean up Blacklist prior to sending invites.
	BGInvite_CleanseGroups();
	
	-- Invite the first 5 for the party, after convertToRaid invite all.
	local numPositions = GetNumBattlefieldPositions();
	local numInvites = 0;
	for i=1,numPositions do
		local x, y, name = GetBattlefieldPosition(i)
		if ( BGInvite_SendInvite(name) == true ) then
			numInvites = numInvites + 1;
		end
		if ( (GetNumRaidMembers() == 0) and (numInvites >= 4 - GetNumPartyMembers()) ) then
			break;
		end		
	end	
	BGvar_AutoInviteTimer = GetTime();
end

--[[
=============================================================================
=============================================================================
]]
function BGInvite_SendInvite(player)
	if (BGInvite_Config.Disable == 1 ) then
		return;
	end
	if ( BGIsValidInvite(player) == true ) then
		InviteByName(player);
		return true;
	end
	return false;
end

--[[
=============================================================================
Called by the ChatMessage callback handler for when the MagicWord is
detected.  Checks to ensure that AutoInvite is enabled before inviting.
=============================================================================
]]
function BGInvite_MagicWordInvite(player)
	local status, mapName, instanceID = BGInvite_GetBattleFieldStatus()
	if ( status ~= "active" ) then
		if ( IsPartyLeader() or IsRaidLeader() or IsRaidOfficer() ) then
			if (BGInvite_Config.AutoInvite == 1) then
				BGInvite_SendInvite(player);
			end
		end
	end
end


--[[
=============================================================================
Called by the ChatMessage callback handler for when the MagicWord is
detected.  Called when player whispers to Leader.
=============================================================================
]]
function BGInvite_MagicWordWhisperInvite(player)
	if ( IsPartyLeader() or IsRaidLeader() or IsRaidOfficer() ) then
		if (BGInvite_Config.AutoInvite == 1) then
			BGInvite_SendInvite(player);
		end
	end
end

--[[
=============================================================================
Check to ensure we can send an invite to this player.
Checks whether a user is blackedlisted and whether they are already in the raid.
=============================================================================
]]
function BGIsValidInvite(player)
	local index = findPlayerIndexInList(BGvar_BlackList,player);
	
	if ( index ) then
		if ( BGvar_BlackList[index].retries >= BGInvite_Config.MaxRetries or BGvar_BlackList[index].time+BGInvite_Config.RetryTimeout > GetTime() ) then
			if ( BGvar_BlackList[index].retries >= BGInvite_Config.MaxRetries ) then
				BGDebugMessage("DEBUG","Invite Not valid due to retries >= max "..BGInvite_Config.MaxRetries,"debug");
			end
			if ( BGvar_BlackList[index].time+BGInvite_Config.RetryTimeout > GetTime() ) then
				BGDebugMessage("DEBUG","Invite Not valid by time"..BGvar_BlackList[index].time+BGInvite_Config.RetryTimeout.." is greater than "..GetTime(),"debug");
			end
			return false;
		end
		if ( BGvar_BlackList[index].declined == 1 or BGvar_BlackList[index].reason == BGINVITE_DECLINED ) then
			BGDebugMessage("DEBUG","Invite Not valid because of decline:"..BGvar_BlackList[index].declined,"debug");
			return false;
		end
		if ( BGvar_BlackList[index].reason == BGINVITE_MANUAL_ADD ) then
			BGDebugMessage("DEBUG","Invite Not valid because player was manually added =>"..player,"debug");
			return false;
		end
	end

	if ( isInRaid(player) == true ) then
		return false;
	end

	BGDebugMessage("DEBUG","Invite is valid","debug");
	return true;
end

--[[
=============================================================================
Converts the party to a raid -- called by the EventHandler
=============================================================================
]]
function BGinvite_ConvertToRaid()
	local status, mapName, instanceID = BGInvite_GetBattleFieldStatus()
	if ( status == "active" ) then
		BGinvite_print(BGlocal_CONVERTING_TO_RAID);
		ConvertToRaid();
	end
end

--[[
=============================================================================
Determines whether the player is in the Raid or not
=============================================================================
]]
function isInRaid(player)
	for i=1,GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i);
		if ( name == player ) then
			return true;
		end
	end
	
	return false;
end

--[[
=============================================================================
Purges players from the Raid that have left the Battlefield.
This gets called if the user clicks "Purge" in the UI or if autopurges are enabled
=============================================================================
]]
function BGinvite_purge()
	BGvar_AutoPurgeTimer = GetTime();
	--BGinvite_print(BGlocal_PURGING_PLAYERS)
	if GetBattlefieldScore(1) == nil then
		--BGinvite_print(BGlocal_ERROR_SCANNING)
		-- not in BG
		return;
	else
		for i=1,GetNumRaidMembers() do
			local name = GetRaidRosterInfo(i)
			if (BGinvite_inbattleground(name) ~= true) then
				if ( BGInvite_Config.SendWhisper == 1) then
					SendChatMessage("[BGInvite] "..BGlocal_YOU_APPEAR_GONE, "WHISPER",this.language, name)
				end
				UninviteByName(name);
				BGDebugMessage("[BGINVITE]","Uninviting from raid: "..name.." (not in BG)","debug");
			end
		end
	end
end

--[[
=============================================================================
-- Determines whether a player is still on the BattleField
-- For some reason this can return false positives and so it performs
-- an extra check.  Places users not found in BG into a list for reference.
=============================================================================
]]
function BGinvite_inbattleground(name)

	local player = {};
	local x = findPlayerIndexInList(BGvar_NotInBG,name);
	for i=1,80 do
		local bgname = GetBattlefieldScore(i);
		if (bgname and bgname == name) then
			-- if previously flagged as not in BG, now we can remove them from that list.			
			if ( x ) then				
				table.remove(BGvar_NotInBG,x);
			end
			return true;
		end
	end
	
	if ( x ) then
		BGvar_NotInBG[x].retries = BGvar_NotInBG[x].retries+1;
		if (BGvar_NotInBG[x].retries > 2) then
			table.remove(BGvar_NotInBG,x);
			return false;
		end
	else
		player.name = name;
		player.time = 0;
		player.retries = 1;
		table.insert(BGvar_NotInBG,player);
	end
		
	return true;
end


function debugDumpBGScores()
	for i=1,80 do
		local bgname,killingBlows,honorKills,deaths,honorGained = GetBattlefieldScore(i);
		if (bgname) then
			local msg = bgname..":kb="..killingBlows..":kills="..honorKills..":deaths="..deaths..":honor="..honorGained;
			DEFAULT_CHAT_FRAME:AddMessage(format("|ccfff0000[%s]: %s|r", "debug", msg));
		end
	end
end

function BGinvite_print(msg)
	ChatFrame1:AddMessage(msg, 0, .5, 1)
end

--[[
=============================================================================
Promotion/Demotion handlers
=============================================================================
]]
function BGinvite_promoteall()
	if (IsRaidLeader()) then
		for i=1, GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i)
			PromoteToAssistant(name)
		end
	end
end

function BGinvite_demoteall()
	if (IsRaidLeader()) then
		for i=1, GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i)
			DemoteAssistant(name)
		end
	end
end

--[[
=============================================================================
-- Adds a user to the Blacklist
-- Called by the Chat Message handlers
=============================================================================
]]
function BGInvite_AddBlackList(name,reason)
	local player = {};	
	local status,mapname,instanceid = BGInvite_GetBattleFieldStatus();

	--if (BGInvite_Config.Disable == 1 ) then
	--	return;
	--end
	
	if (status == "active" or BGInvite_Var.debug == true or reason == BGINVITE_MANUAL_ADD) then
		if ( isInRaid(name) ) then
			return;
		end
		local index = findPlayerIndexInList(BGvar_BlackList,name);
		if ( index ) then
			BGDebugMessage("DEBUG","AIG: "..name.." is already flagged "..BGvar_BlackList[index].retries,"debug");
			BGvar_BlackList[index].time = GetTime();
			BGvar_BlackList[index].retries = BGvar_BlackList[index].retries + 1;
			player = BGvar_BlackList[index];
		else
			player.name = name;
			player.time = GetTime();
			player.retries = 0;
			player.reason = reason;
			player.declined = 0;
			if ( reason == BGINVITE_DECLINED ) then
				player.declined = 1;
			end
			table.insert(BGvar_BlackList,player);
		end

		if (BGInvite_Config.SendWhisper == 1 and math.mod(player.retries,2) == 0 and player.declined ~= 1) then  
			SendChatMessage("[BGInvite] "..BGINVITE_LEAVE_YOUR_GROUP, "WHISPER", this.language, name);
		end
		
		BGDebugMessage("DEBUG","[BlackList adding player] "..name,"debug");

	end
	BGInvite_BlackListFrame_Update();
end

--[[
=============================================================================
Walks the Blacklist array and calls BGInvite_CleanseBlackList for each entry
=============================================================================
]]
function BGInvite_CleanseGroups()
	--table.foreach(BGvar_BlackList, BGInvite_CleanseBlackList); 
	BGInvite_CleanseBlackList();
end

--[[
=============================================================================
-- Removes players from the Blacklist that are now in the Raid
=============================================================================
]]
function BGInvite_CleanseBlackList()
	for i=1,GetNumRaidMembers() do
		local playerName = GetRaidRosterInfo(i)
		local index = findPlayerIndexInList(BGvar_BlackList,playerName);
		if ( index ) then
			table.remove(BGvar_BlackList, index);
		end
	end
end


--[[
=============================================================================
-- Hook function for chat messages
-- Suppresses "Already in Group" messages
=============================================================================
]]
function BGinvite_ChatFrame_OnEvent(event)

if (BGvar_initialMessageSent and (event == "CHAT_MSG_SYSTEM")) then
	--BGDebugMessage("DEBUG", "chatmessagehook="..arg1, "debug");
	if string.find(arg1, BGlocal_BLANK_IS_ALREADY_IN_GROUP_FIND) then
			x=0;
			--BGDebugMessage("DEBUG", "hiding already in group message", "debug");
		elseif string.find(arg1, BGlocal_YOU_HAVE_INVITED_FIND) then
			x=0;
			--BGDebugMessage("DEBUG", "hiding you have invited message", "debug");
		else 
			Pre_BGinvite_ChatFrame_OnEvent(event)
		end
	else
		Pre_BGinvite_ChatFrame_OnEvent(event)
	end
end

--[[
=============================================================================
Called when frame window opens or closes
=============================================================================
]]
function BGInviteFrame_OnShow()
	PlaySound("igCharacterInfoOpen");
end

function BGInviteFrame_OnHide()
	PlaySound("igCharacterInfoClose");
end


--[[
=============================================================================
Finds our player object in any list.
=============================================================================
]]
function findPlayerIndexInList(list,name)
	local i;
	BGDebugMessage("DEBUG", "find player "..name, "debug");
	for i=1, table.getn( list ) do
		BGDebugMessage("DEBUG", "player="..list[i].name, "debug");
		if (list[i].name == name ) then
			BGDebugMessage("DEBUG", "found player="..list[i].name, "debug");
			return i;
		end
	end
end

--[[
=============================================================================
Debug message output 
=============================================================================
]]
function BGDebugMessage(x,y,z) 
	if ( z == "error" ) then 
		DEFAULT_CHAT_FRAME:AddMessage(format("|cffff0000[%s]: %s|r", x, y)) 
	end
	
	if ( BGInvite_Var.debug ) then
		DEFAULT_CHAT_FRAME:AddMessage(format("|ccfff0000[%s]: %s|r", x, y)) 
	end
	--if ( z == "debug" ) then 
	--	DEFAULT_CHAT_FRAME:AddMessage(format("|cffff0000[%s]: %s|r", x, y)) 
	--end
	--if ( z == "foods" ) then 
	--	DEFAULT_CHAT_FRAME:AddMessage(format("|cffff0000[%s]: %s|r", x, y)) 
	--end
end

--[[
=============================================================================
TEST CODE FROM HERE DOWN
=============================================================================
]]
function testAlreadyInGroup()

	for i=1,GetNumRaidMembers() do
		local name = GetRaidRosterInfo(i)
		BGInvite_AddBlackList(name,BGINVITE_ALREADY_IN_GROUP);
	end
	
	dumpAIG();
	BGvar_BlackList = {};
end

function testAIG()
	BGInvite_AddBlackList("testplayer1",BGINVITE_ALREADY_IN_GROUP);
	BGInvite_AddBlackList("testplayer2",BGINVITE_ALREADY_IN_GROUP);
	dumpAIG();
	BGInvite_AddBlackList("testplayer2",BGINVITE_ALREADY_IN_GROUP);
	dumpAIG();
	
	BGDebugMessage("DEBUG","magicword="..BGInvite_Config.MagicWord,"debug");
	BGDebugMessage("DEBUG","RetryTimeout="..BGInvite_Config.RetryTimeout,"debug");
end

function testAIG3()
	BGInvite_AddBlackList("testplayer1",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer2",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer3",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer4",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer5",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer6",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer7",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer8",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer9",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer10",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer11",BGINVITE_DECLINED);
	BGInvite_AddBlackList("testplayer12",BGINVITE_ALREADY_IN_GROUP);
end

function vi()
	BGDebugMessage("DEBUG","testplayer1 isvalid "..decodeBoolean(BGIsValidInvite("testplayer1")));
	BGDebugMessage("DEBUG","testplayer2 isvalid "..decodeBoolean(BGIsValidInvite("testplayer2")));
	BGDebugMessage("DEBUG","testplayer3 isvalid "..decodeBoolean(BGIsValidInvite("testplayer3")));
	BGDebugMessage("DEBUG","testplayer4 isvalid "..decodeBoolean(BGIsValidInvite("testplayer4")));
	BGDebugMessage("DEBUG","testplayer5 isvalid "..decodeBoolean(BGIsValidInvite("testplayer5")));
	BGDebugMessage("DEBUG","testplayer6 isvalid "..decodeBoolean(BGIsValidInvite("testplayer6")));
	BGDebugMessage("DEBUG","testplayer7 isvalid "..decodeBoolean(BGIsValidInvite("testplayer7")));
	BGDebugMessage("DEBUG","testplayer8 isvalid "..decodeBoolean(BGIsValidInvite("testplayer8")));
	BGDebugMessage("DEBUG","testplayer9 isvalid "..decodeBoolean(BGIsValidInvite("testplayer9")));
	BGDebugMessage("DEBUG","testplayer10 isvalid "..decodeBoolean(BGIsValidInvite("testplayer10")));
	BGDebugMessage("DEBUG","testplayer11 isvalid "..decodeBoolean(BGIsValidInvite("testplayer11")));
	BGDebugMessage("DEBUG","testplayer12 isvalid "..decodeBoolean(BGIsValidInvite("testplayer12")));	
end

function decodeBoolean(value)
	if ( value ) then
		return "true";
	end
	return "false";
end

function dumpAIG()
	BGDebugMessage("DEBUG","Dump AIG","debug");
	table.foreach(BGvar_BlackList, debugprintAIG); 
	BGDebugMessage("DEBUG","Dump AIG2","debug");
	for key,value in BGvar_BlackList do debugprintAIG(key,value) end
end

function debugprintAIG(key,player)
	BGDebugMessage("DEBUG","key="..key.." "..player.name..'-'..player.time..'-'..player.retries,"debug");
end

function testgroup()
	if ( IsPartyLeader() ) then
		BGDebugMessage("DEBUG","you are party leader","debug");
	else
		BGDebugMessage("DEBUG","you are NOT party leader","debug");
	end
	local n = GetNumPartyMembers();
	BGDebugMessage("DEBUG","party member cnt="..n,"debug");
	local x = GetNumRaidMembers();
	BGDebugMessage("DEBUG","raid member cnt="..x,"debug");
end

function testmath()
	local x = math.mod(0,2);
	local y = math.mod(1,2);
	local z = math.mod(2,2);
	local a = math.mod(3,2);
	
	BGDebugMessage("DEBUG","x="..x,"debug");
	BGDebugMessage("DEBUG","y="..y,"debug");
	BGDebugMessage("DEBUG","z="..z,"debug");
	BGDebugMessage("DEBUG","a="..a,"debug");
end

function testmatch()
	BGDebugMessage("DEBUG","testmatch","debug");
	local message = "who needs invite?";
	local pattern = "invite.*";
	local match = { string.gfind(message, pattern)() };
	if ( table.getn(match) ~= 0 ) then
		BGDebugMessage("DEBUG","matched","debug");
		local ret = { };
		local index;
		for index=1, table.getn(match), 1 do
			BGDebugMessage("DEBUG","match:"..match[index],"debug");
		end
	end
	message = "invite me!";
	match = { string.gfind(message, pattern)() };
	if ( table.getn(match) ~= 0 ) then
		BGDebugMessage("DEBUG","matched","debug");
		local ret = { };
		local index;
		for index=1, table.getn(match), 1 do
			BGDebugMessage("DEBUG","match:"..match[index],"debug");
		end
	end
	
end

function testcleanse(key)
	table.remove(BGvar_BlackList, key);
end

function testcleanser()
		for i=1,GetNumRaidMembers() do
			local name = GetRaidRosterInfo(i)
			if (BGinvite_inbattleground(name) ~= true) then
					BGDebugMessage("DEBUG","should rmeove from group:"..name,"debug");
			end
		end
end

function mychannel()
BGDebugMessage("DEBUG","channelname = "..BGInvite_Config.MsgChannelId,"debug");
SendChatMessage("?", BGINVITE_CHANNELS[BGInvite_Config.MsgChannelId].type, nil,BGINVITE_CHANNELS[BGInvite_Config.MsgChannelId].id);
end


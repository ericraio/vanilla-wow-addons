gGroupCalendar_MessagePrefix0 = "GC2";
gGroupCalendar_MessagePrefix = gGroupCalendar_MessagePrefix0.."/";

gGroupCalendar_MessagePrefixLength = string.len(gGroupCalendar_MessagePrefix);

gGroupCalendar_Channel =
{
	Name          = nil,
	NameLower     = nil,
	ID            = nil,
	Password      = nil,
	AutoPlayer    = nil,
	Status        = "Disconnected",
	StatusMessage = nil,
	GotTooManyChannelsMessage = false,
};

gGroupCalendar_Queue =
{
	TasksDelay       = 0,
	TasksElapsed     = 0,
	Tasks            = {},
	
	RequestsDelay    = 0,
	RequestsElapsed  = 0,
	Requests         = {[1] = {}, [2] = {}},
	
	InboundDelay     = 0,
	InboundMessages  = {},
	InboundLastSender = nil,
	InboundTimeSinceLastMessage = 0,
	
	OutboundDelay    = 0,
	OutboundMessages = {},
	OutboundTimeSinceLastMessage = 0,
	
	DatabaseUpdates  = {},
	RSVPUpdates      = {},
};

gCalendarNetwork_UserTrustCache =
{
};

gCalendarNetwork_RequestDelay =
{
	Init = 120,
	ShortInit = 5,
	SelfUpdateRequest = 1,
	ExternalUpdateRequest = 30,
	OwnedNotices = 300, -- Allow time for updates to arrive before we'll start advertising databases
	JoinChannel2 = 2,
	OwnedUpdate = 3,
	ProxyUpdateMin = 6,
	ProxyUpdateRange = 4,
	
	RFUMin = 1,
	RFURange = 5,
	
	OwnedNOURange = 2,
	ProxyNOUMin = 6,
	ProxyNOURange = 4,
	
	InboundQueue = 0.2,
	OutboundQueue = 0.2,
	RequestQueue = 0.2,
	
	-- Outbound queue delay 1 - 5 seconds
	
	OutboundQueueGapMin = 1, -- Delay for after last inbound message was processed
	OutboundQueueGapWidth = 4, -- Random delay after the min time
	
	-- Request queue delay 1 - 5 seconds
	
	RequestQueueGapMin = 1,  -- Delay for after last inbound or outbound message was processed
	RequestQueueGapWidth = 4, -- Random delay after the min time
	
	GuildUpdateAutoConfig = 2,
	
	CheckDatabaseTrust = 10,
	GuildRosterUpdate = 1,
	
	-- Maximum age for an update is two minutes
	
	MaximumUpdateAge = 120,
};

gGroupCalendar_EnableUpdates = false;  -- Don't allow the user to send updates to any databases
                                       -- until we're sure that his databases are up-to-date themselves
gGroupCalendar_EnableSelfUpdates = false; -- Don't allow the user to send updates for their own databases
                                          -- until well after they're sure nobody has updates for them

function CalendarNetwork_GetChannelStatus()
	return gGroupCalendar_Channel.Status;
end

function CalendarNetwork_SetChannel(pChannel, pPassword)
	-- Leave the channel and return if the new channel is nil
	
	if not pChannel then
		CalendarNetwork_LeaveChannel();
		return true;
	end
	
	-- Just return if nothing is actually changing
	
	if gGroupCalendar_Channel.Name
	and strupper(gGroupCalendar_Channel.Name) == strupper(pChannel)
	and gGroupCalendar_Channel.Password == pPassword
	and gGroupCalendar_Channel.Status == "Connected" then
		return false; -- return false to indicate that no change was made
	end
	
	-- Leave the old channel and join the new one
	
	CalendarNetwork_LeaveChannel();
	
	return CalendarNetwork_JoinChannel(pChannel, pPassword);
end

function CalendarNetwork_JoinChannel(pChannelName, pPassword)
	if not pChannelName
	or pChannelName == ""
	or gGroupCalendar_Channel.Disconnected then
		return false;
	end
	
	-- There seems to be some sort of bug with passworded channels getting
	-- screwed up if the UI is reloaded and the solution appears to be to
	-- leave and re-join the channel.  Therefore, the code below...
	
	LeaveChannelByName(pChannelName);
	CalendarNetwork_LeftChannel();
	
	CalendarNetwork_SetChannelStatus("Initializing");
	
	CalendarNetwork_QueueTask(
			CalendarNetwork_JoinChannel2,
			{mChannelName = pChannelName, mPassword = pPassword},
			gCalendarNetwork_RequestDelay.JoinChannel2,
			"JOINCHANNEL2");
	
	return true;
end

function CalendarNetwork_JoinChannelFailed()
	if gGroupCalendar_Channel.GotTooManyChannelsMessage then
		CalendarNetwork_SetChannelStatus("Error", GroupCalendar_cTooManyChannels);
	else
		CalendarNetwork_SetChannelStatus("Error", GroupCalendar_cJoinChannelFailed);
	end
end

function CalendarNetwork_LeftChannel()
	gGroupCalendar_Channel.Name = nil;
	gGroupCalendar_Channel.Password = nil;
	gGroupCalendar_Channel.NameLower = nil;
	gGroupCalendar_Channel.ID = nil;
	
	CalendarNetwork_SetChannelStatus("Disconnected");
end

function CalendarNetwork_SetChannelStatus(pStatus, pStatusMessage)
	gGroupCalendar_Channel.Status = pStatus;
	gGroupCalendar_Channel.StatusMessage = pStatusMessage;
	
	GroupCalendar_ChannelChanged();
end

function CalendarNetwork_SystemMessage(pMessage)
	if pMessage == ERR_TOO_MANY_CHAT_CHANNELS then
		gGroupCalendar_Channel.GotTooManyChannelsMessage = true;
		
		if gGroupCalendar_Channel.Status == "Error" then
			CalendarNetwork_SetChannelStatus("Error", pMessage);
		end
	elseif pMessage == INSTANCE_SAVED then
		-- Fetch the raid info so the reset events can be logged on
		-- the calendar
		
		RequestRaidInfo();
	elseif pMessage == NO_RAID_INSTANCES_SAVED then
		EventDatabase_RemoveSavedInstanceEvents(gGroupCalendar_UserDatabase);
	elseif pMessage == RAID_INSTANCE_INFO_HDR then
		-- Remove existing events since they will be replaced by new incoming info
		
		EventDatabase_RemoveSavedInstanceEvents(gGroupCalendar_UserDatabase);
	else
		local	vStartIndex, vEndIndex, vName, vID, vDays, vHours, vMinutes, vSeconds = string.find(pMessage, "(.+) %(ID=(%x+)%): (%d+)d (%d+)h (%d+)m (%d+)s");
		
		if vStartIndex then
			-- Calculate the number of seconds until the instance resets
			
			local	vRemainingDateTime60 = tonumber(vDays) * gCalendarSecondsPerDay
	                                     + Calendar_ConvertHMSToTime60(tonumber(vHours), tonumber(vMinutes), tonumber(vSeconds));
			
			local	vServerResetDate, vServerResetTime = Calendar_GetServerDateTimeFromSecondsOffset(vRemainingDateTime60);
			
			EventDatabase_ScheduleSavedInstanceEvent(gGroupCalendar_UserDatabase, vName, vServerResetDate, vServerResetTime);
		end
	end
end

function CalendarNetwork_JoinChannel2(pParams)
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("CalendarNetwork_JoinChannel: "..pParams.mChannelName);
	end
	
	gGroupCalendar_Channel.GotTooManyChannelsMessage = false;
	gGroupCalendar_Channel.Name = pParams.mChannelName;
	
	local	vChannelName = GetChannelName(pParams.mChannelName);
	local	vZoneChannel;
	local	vChannelAlreadyExists = false;
	
	if vChannelName and vChannelName ~= 0 then
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("Found existing channel "..pParams.mChannelName.." ("..vChannelName..")");
		end
		
		vChannelName = pParams.mChannelName;
		vChannelAlreadyExists = true;
	else
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("Channel "..pParams.mChannelName.." not found ("..vChannelName..") joining channel...");
		end
		
		vZoneChannel, vChannelName = JoinChannelByName(pParams.mChannelName, pParams.mPassword, DEFAULT_CHAT_FRAME:GetID());
		
		if not vZoneChannel then
			CalendarNetwork_JoinChannelFailed();
			return false;
		end
		
		if not vChannelName then
			vChannelName = pParams.mChannelName;
		end
	end
	
	-- Remove the channel from the chat frame so the user doesn't
	-- have to watch all that data comm. (if we're running debug
	-- code then leave the setting alone)
	
	ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, pParams.mChannelName);
	
	if gCalendar_DebugFrame then
		ChatFrame_AddChannel(gCalendar_DebugFrame, pParams.mChannelName);
	end
	
	gGroupCalendar_Channel.Password = pParams.mPassword;
	gGroupCalendar_Channel.NameLower = strlower(pParams.mChannelName);
	gGroupCalendar_Channel.ID = GetChannelName(gGroupCalendar_Channel.Name);
	
	if not gGroupCalendar_Channel.ID
	or gGroupCalendar_Channel.ID == 0 then
		gGroupCalendar_Channel.ID = nil;
		
		CalendarNetwork_JoinChannelFailed();
		
		return false;
	end
	
	if vChannelAlreadyExists then
		CalendarNetwork_JoinedChannel();
	end
	
	return true;
end

function CalendarNetwork_LeaveChannel()
	if gGroupCalendar_Channel.Name
	and gGroupCalendar_Channel.ID
	and gGroupCalendar_Channel.Status ~= "Suspended" then
		LeaveChannelByName(gGroupCalendar_Channel.Name);
		CalendarNetwork_LeftChannel();
	end
end

function CalendarNetwork_JoinedChannel()
	CalendarNetwork_SetChannelStatus("Connected");
	
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("CalendarNetwork_JoinChannel succeeded channel "..gGroupCalendar_Channel.Name.." ID "..gGroupCalendar_Channel.ID);
	end

	-- Send update requests/notices

	CalendarNetwork_QueueTask(CalendarNetwork_SendNotices, nil, gCalendarNetwork_RequestDelay.SelfUpdateRequest, "SELFUPDATE");
end

function CalendarNetwork_ChannelNotice(pChannelMessage, pChannelName, pChannelID, pActualChannelName)
	-- Decode the channel name if it's in the nn. <channel name> format
	
	local	vChannelName = pChannelName;
	
	for vFoundNumber, vFoundName in string.gfind(pChannelName, "(%d)%. (.+)") do
		vChannelName = vFoundName;
	end
	
	-- Just leave if it's not a channel we're interested in
	
	local	vIsDataChannel = strlower(vChannelName) == gGroupCalendar_Channel.NameLower;
	
	--
	
	if pChannelMessage == "YOU_JOINED" then
		-- If it's one of the system channels, then shorten the initialization
		-- timer if one is present
		
		if pChannelID == 1 then
			CalendarNetwork_SystemChannelJoined();
		end
		
		if not vIsDataChannel then
			return;
		end
		
		if pChannelID > 0 then
			CalendarNetwork_JoinedChannel();
		else
			-- Joining failed
			
			CalendarNetwork_JoinChannelFailed();
		end
		
	elseif pChannelMessage == "YOU_LEFT" then
		if not vIsDataChannel then
			return;
		end
		
		if not gGroupCalendar_Channel.ID then
			return;
		end
		
		CalendarNetwork_LeftChannel();
		
	elseif pChannelMessage == "WRONG_PASSWORD" then
		if not vIsDataChannel then
			return;
		end
		
		CalendarNetwork_SetChannelStatus("Error", GroupCalendar_cWrongPassword);
	end
end

function CalendarNetwork_SuspendChannel()
	if gGroupCalendar_Channel.Status == "Suspended"
	or not gGroupCalendar_Channel.Name
	or not gGroupCalendar_Channel.ID then
		return;
	end
	
	LeaveChannelByName(gGroupCalendar_Channel.Name);
	
	gGroupCalendar_Channel.ID = nil;
	CalendarNetwork_SetChannelStatus("Suspended");
end

function CalendarNetwork_ResumeChannel()
	if not gGroupCalendar_Channel.Status ~= "Suspended" then
		return;
	end
	
	JoinChannelByName(gGroupCalendar_Channel.Name, gGroupCalendar_Channel.Password, DEFAULT_CHAT_FRAME:GetID());
	gGroupCalendar_Channel.ID = GetChannelName(gGroupCalendar_Channel.Name);
	
	ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, gGroupCalendar_Channel.Name);
	
	CalendarNetwork_SetChannelStatus("Connected");
end

function CalendarNetwork_UnpackIndexedList(...)
	local	vList = {};
	
	for vIndex = 1, arg.n, 2 do
		vList[tonumber(arg[vIndex])] = arg[vIndex + 1];
	end
	
	return vList;
end

function CalendarNetwork_GetChannelList()
	local	vChannelList = CalendarNetwork_UnpackIndexedList(GetChannelList());
	
	return vChannelList;
end

function CalendarNetwork_CalendarLoaded()
	-- Set up a deferred initialization
	
	CalendarNetwork_SetChannelStatus("Starting");
	
	-- See if there are system channels yet and use
	-- the shorter delay if there are
	
	local	vDelay = gCalendarNetwork_RequestDelay.Init;
	
	local	vChannelList = CalendarNetwork_GetChannelList();
	
	if vChannelList[1] then
		vDelay = gCalendarNetwork_RequestDelay.ShortInit;
	end
	
	--
	
	CalendarNetwork_QueueTask(CalendarNetwork_Initialize, nil, vDelay, "INIT");
end

function CalendarNetwork_SystemChannelJoined()
	CalendarNetwork_SetTaskDelay("INIT", gCalendarNetwork_RequestDelay.ShortInit);
end

function CalendarNetwork_ProcessCommandString(pSender, pTrustLevel, pCommandString, pCurrentTimeStamp)
	local	vCommand = CalendarNetwork_ParseCommandString(pCommandString);
	
	if not vCommand then
		if gGroupCalendar_Settings.Debug then
			Calendar_DebugMessage("ProcessCommandString: Couldn't parse ["..pSender.."]:"..pCommandString);
		end
		
		return false;
	end
	
	return CalendarNetwork_ProcessCommand(pSender, pTrustLevel, vCommand, pCurrentTimeStamp);
end

function CalendarNetwork_ProcessCommand(pSender, pTrustLevel, pCommand, pCurrentTimeStamp)
	-- Age out old updates which haven't been seen in a while
	
	local	vMinimumUpdateTime = pCurrentTimeStamp - gCalendarNetwork_RequestDelay.MaximumUpdateAge;
	
	CalendarNetwork_KillOldUpdates("DB", gGroupCalendar_Queue.DatabaseUpdates, vMinimumUpdateTime);
	CalendarNetwork_KillOldUpdates("RAT", gGroupCalendar_Queue.RSVPUpdates, vMinimumUpdateTime);
	
	--
	
	local	vOpcode = pCommand[1].opcode;
	local	vOperands = pCommand[1].operands;
	
	table.remove(pCommand, 1);
	
	if vOpcode == "DB" then
		local	vUserName = vOperands[1];
		local	vDatabaseID = tonumber(vOperands[2]);
		local	vRevision = tonumber(vOperands[3]);
		local	vAuthRevision = tonumber(vOperands[4]);
		
		-- If the sender is using wildcards, fetch the path from
		-- the update records
		
		if vUserName == "*" then
			local	vDatabaseUpdate = CalendarNetwork_FindDatabaseUpdate(pSender);
			
			if not vDatabaseUpdate then
				return;
			end
			
			vUserName = vDatabaseUpdate.mUserName;
			vDatabaseID = vDatabaseUpdate.mDatabaseID;
			vRevision = vDatabaseUpdate.mRevision;
			vAuthRevision = nil;
		end
		
		--
		
		if not vRevision then
			vRevision = 0;
		end
		
		if CalendarTrust_UserIsTrusted(vUserName) then -- only accept databases for trusted users (or our own)
			CalendarNetwork_ProcessDatabaseCommand(pSender, pTrustLevel, vUserName, vDatabaseID, vRevision, vAuthRevision, pCommand);
		else
			if gGroupCalendar_Settings.DebugTrust then
				Calendar_DebugMessage("ChannelMessageReceived: User "..vUserName.." is not trusted for DB command");
			end
		end
	elseif vOpcode == "RAT" then
		local	vUserName = vOperands[1];
		local	vDatabaseID = tonumber(vOperands[2]);
		local	vRevision = tonumber(vOperands[3]);
		local	vAuthRevision = tonumber(vOperands[4]);
		
		-- If the sender is using wildcards, fetch the path from
		-- the update records
		
		if vUserName == "*" then
			local	vRSVPUpdate = CalendarNetwork_FindRSVPUpdate(pSender);
			
			if not vRSVPUpdate then
				return;
			end
			
			vUserName = vRSVPUpdate.mUserName;
			vDatabaseID = vRSVPUpdate.mDatabaseID;
			vRevision = vRSVPUpdate.mRevision;
			vAuthRevision = nil;
		end
		
		--
		
		if not vRevision then
			vRevision = 0;
		end
		
		if CalendarTrust_UserIsTrustedForRSVPs(vUserName) then -- only accept RSVP for trusted users (or our own)
			CalendarNetwork_ProcessRSVPCommand(pSender, vUserName, vDatabaseID, vRevision, vAuthRevision, pCommand);
		else
			if gGroupCalendar_Settings.DebugTrust then
				Calendar_DebugMessage("ChannelMessageReceived: User "..vUserName.." is not trusted for RAT command");
			end
		end
	elseif vOpcode == "GLD" then
		local	vGuildName = vOperands[1];
		local	vMinRank = tonumber(vOperands[2]);
		
		CalendarNetwork_ProcessGuildCommand(pSender, pTrustLevel, vGuildName, vMinRank, pCommand);
	elseif vOpcode == "ALL" then
		CalendarNetwork_ProcessAllCommand(pSender, pTrustLevel, pCommand);
	elseif vOpcode == "VER" then
		local	vDatabase = EventDatabase_GetDatabase(pSender, true);
		
		if vDatabase then
			vDatabase.AddonVersion = vOperands[1];
		end
	else
		if gGroupCalendar_Settings.Debug then
			Calendar_DebugMessage("ProcessCommand: Unknown opcode "..vOpcode);
		end
	end
end

function CalendarNetwork_ProcessChangesRFU(pChanges, pDatabaseTag, pPlayerOwned, pPriority, pUserName, pDatabaseID, pRevision, pAuthRevision)
	if gGroupCalendar_Settings.DebugUpdates then
		Calendar_DebugMessage(pDatabaseTag.." changes update requested for: "..pUserName..","..pRevision);
	end
	
	-- Cancel a queued RFU for the same database if it's redundant
	
	CalendarNetwork_CancelRedundantRFURequest(pDatabaseTag, pUserName, pDatabaseID, pRevision)
	
	-- Just bail out if we don't have the requested database
	
	if not pChanges then
		return;
	end
	
	-- Create the request
	
	local		vRequest;
	local		vFromRevision;
	local		vForceUpdate = false;
	
	if pChanges.ID ~= pDatabaseID then
		if pPlayerOwned
		or pChanges.ID > pDatabaseID then
			vFromRevision = 0;
			vForceUpdate = true;
		else
			if gGroupCalendar_Settings.DebugUpdates then
				Calendar_DebugMessage("Not sending "..pDatabaseTag.." update: Requested database isn't available for "..pUserName..","..pDatabaseID);
			end
			
			return;
		end
	else
		if pPlayerOwned
		and pAuthRevision
		and pAuthRevision < pRevision then
			vFromRevision = pAuthRevision;
		else
			vFromRevision = pRevision;
		end
	end
	
	vRequest = CalendarNetwork_FindUPDRequest(pDatabaseTag, pUserName);
	
	if vRequest then
		if vFromRevision < vRequest.mRevision then
			if gGroupCalendar_Settings.DebugUpdates then
				Calendar_DebugMessage("Changing existing "..pDatabaseTag.." request to revision "..vFromRevision.." for "..pUserName);
			end
			
			vRequest.mRevision = vFromRevision;
		else
			if gGroupCalendar_Settings.DebugUpdates then
				Calendar_DebugMessage("Existing request for "..pDatabaseTag.." "..pUserName..","..pRevision);
			end
		end
		
		CalendarNetwork_SetRequestPriority(vRequest, pPriority);
	elseif pChanges.Revision > vFromRevision
	or vForceUpdate then
		vRequest = {};
		
		vRequest.mOpcode = pDatabaseTag.."_UPD";
		vRequest.mUserName = pUserName;
		vRequest.mDatabaseID = pChanges.ID;
		vRequest.mRevision = vFromRevision;
		
		-- Determine a delay
		
		local	vDelay;
		
		if pPlayerOwned then
			vDelay = gCalendarNetwork_RequestDelay.OwnedUpdate;
		else
			vDelay = gCalendarNetwork_RequestDelay.ProxyUpdateMin + math.random() * gCalendarNetwork_RequestDelay.ProxyUpdateRange;
		end
		
		CalendarNetwork_QueueRequest(vRequest, vDelay, pPriority);
	end
end

function CalendarNetwork_GetDatabaseChanges(pUserName, pCreate)
	local	vDatabase = EventDatabase_GetDatabase(pUserName, pCreate);
	
	if vDatabase then
		return vDatabase, vDatabase.Changes, vDatabase.IsPlayerOwned;
	else
		return nil, nil, nil;
	end
end

function CalendarNetwork_GetDatabaseRSVPChanges(pUserName, pCreate)
	local	vDatabase = EventDatabase_GetDatabase(pUserName, pCreate);
	
	if vDatabase then
		return vDatabase, vDatabase.RSVPs, vDatabase.IsPlayerOwned;
	else
		return nil, nil, nil;
	end
end

function CalendarNetwork_ProcessDatabaseCommand(pSender, pTrustLevel, pUserName, pDatabaseID, pRevision, pAuthRevision, pCommand)
	local	vOpcode = pCommand[1].opcode;
	local	vOperands = pCommand[1].operands;
	
	table.remove(pCommand, 1);
	
	local	vDatabase, vChanges, vIsPlayerOwned = CalendarNetwork_GetDatabaseChanges(pUserName, false);
	local	vIsThisPlayerOwned = vIsPlayerOwned and pUserName == gGroupCalendar_PlayerName;
	
	if vOpcode ~= "RFU"
	and vOpcode ~= "RFV"
	and pTrustLevel < 2 then
		-- Players with moderate trust levels (ie, fellow guild members) are
		-- only allowed to requeust updates, not provide updates
		
		if gGroupCalendar_Settings.DebugTrust then
			Calendar_DebugMessage("CalendarNetwork_ProcessDatabaseCommand: Ignoring "..vOpcode.." request from "..pSender);
		end
		
		return;
	end
	
	if vOpcode == "RFU" then
		-- If the sender is seen transmitting an RFU while he has a database update
		-- pending then it probably means he d/c'd.  Kill the database update in that
		-- case
		
		CalendarNetwork_KillSendersDatabaseUpdates(pSender);
		
		--
		
		if vChanges then
			-- Give the owner high-priority to help ensure that he can roam successfully
			
			local	vPriority;
			
			if pSender == pUserName then
				vPriority = 1;
			else
				vPriority = 2;
			end
			
			CalendarNetwork_ProcessChangesRFU(vChanges, "DB", vIsThisPlayerOwned, vPriority, pUserName, pDatabaseID, pRevision, pAuthRevision);
		end
	elseif vOpcode == "RFV" then
		-- If the sender is seen transmitting an RFV while he has a database update
		-- pending then it probably means he d/c'd.  Kill the database update in that
		-- case
		
		CalendarNetwork_KillSendersDatabaseUpdates(pSender);
		
		--
		
		if vIsThisPlayerOwned then
			CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix.."VER:"..gGroupCalendar_VersionString);
		end
	elseif vOpcode == "NOU" then
		-- If the sender is seen transmitting an NOU while he has a database update
		-- pending then it probably means he d/c'd.  Kill the database update in that
		-- case
		
		CalendarNetwork_KillSendersDatabaseUpdates(pSender);
		
		--
		
		local		vCurrentRevision = 0;
		local		vDatabaseIDChanged = false;
		
		if not vIsThisPlayerOwned then
			CalendarNetwork_CancelRedundantNOURequests(vChanges, "DB", pSender, pUserName, pDatabaseID, pRevision);
		end
		
		if not vDatabase then
			vDatabase = EventDatabase_AssumeDatabase(pUserName);
		end
		
		if vDatabase then
			-- Ignore external updates to our own databases
			
			if vDatabase.IsPlayerOwned then
				-- If someone sent out a NOU for one of our databases and it's older than
				-- ours and ours is now empty, send out a DEL to let them know that it's newer
				-- and empty now
				
				if CalendarChanges_IsEmpty(vChanges) then
					CalendarNetwork_SendEmptyChanges(vChanges, "DB", pUserName);
				end
				
				return;
			end
			
			-- Ignore the update if the ID is older than the one we have
			-- unless it's from the owner
			
			if vChanges
			and pDatabaseID < vChanges.ID
			and pSender ~= vDatabase.UserName then
				return;
			end
			
			-- Force a RFU if the ID is changing
			
			if not vChanges
			or vChanges.ID ~= pDatabaseID then
				vDatabaseIDChanged = true;
			else
				vCurrentRevision = vChanges.Revision;
				
				if not vCurrentRevision then
					Calendar_ErrorMessage("Changes for "..pUserName.." has nil revision");
					return;
				end
			end
		end
		
		if vDatabaseIDChanged
		or vCurrentRevision < pRevision then
			CalendarNetwork_QueueRFURequest(pUserName, "DB", pDatabaseID, pRevision);
		end
	elseif vOpcode == "UPD" then
		-- If the sender is seen transmitting an UPD while he has another database update
		-- pending then it probably means he d/c'd.  Kill the database update in that
		-- case
		
		CalendarNetwork_KillSendersDatabaseUpdates(pSender, pUserName);
		
		-- Begin a database update
		
		local	vSinceRevision = tonumber(vOperands[1]);
		
		if not vSinceRevision then
			if gGroupCalendar_Settings.DebugErrors then
				Calendar_DebugMessage("GroupCalendar: DB UPD received from "..pSender.." for "..pUserName.." with no SinceRevision");
			end
			
			return;
		end
		
		if not vIsThisPlayerOwned then
			-- If we're waiting to request this same update, cancel the request
			
			CalendarNetwork_CancelRedundantRFURequest("DB", pUserName, pDatabaseID, vSinceRevision);

			-- If we're waiting to send this same update, cancel the request
			
			CalendarNetwork_CancelRedundantUPDRequests(vChanges, "DB", pUserName, pDatabaseID, pRevision, vSinceRevision);
		end
		
		CalendarNetwork_BeginDatabaseUpdate(pSender, pUserName, pDatabaseID, pRevision, vSinceRevision);

	elseif vOpcode == "DEL" then
		-- Delete the database since it's empty
		
		if not vIsThisPlayerOwned then
			CalendarNetwork_CancelRedundantUPDRequests(vChanges, "DB", pUserName, pDatabaseID, pRevision, 0);
		end
	
		CalendarNetwork_DeleteDatabase(pSender, pUserName, pDatabaseID, pRevision);
		
	elseif vOpcode == "EVT" then
		-- Event data
		
		local	vEventID = tonumber(vOperands[1]);
		
		CalendarNetwork_InsertEventUpdate(pSender, pUserName, pDatabaseID, pRevision, vEventID, pCommand);
		
	elseif vOpcode == "END" then
		-- End a database update
		
		local	vSinceRevision = tonumber(vOperands[1]);
		
		CalendarNetwork_EndDatabaseUpdate(pSender, pUserName, pDatabaseID, pRevision, vSinceRevision);
	end
end

function CalendarNetwork_ProcessRSVPCommand(pSender, pUserName, pDatabaseID, pRevision, pAuthRevision, pCommand)
	local	vOpcode = pCommand[1].opcode;
	local	vOperands = pCommand[1].operands;
	local	vOperandString = pCommand[1].operandString;
	
	table.remove(pCommand, 1);
	
	local	vDatabase, vChanges, vIsPlayerOwned = CalendarNetwork_GetDatabaseRSVPChanges(pUserName, false);
	local	vIsThisPlayerOwned = vIsPlayerOwned and pUserName == gGroupCalendar_PlayerName;
	
	if vOpcode == "RFU" then
		-- If the sender is seen transmitting an RFU while he has a database update
		-- pending then it probably means he d/c'd.  Kill the database update in that
		-- case
		
		CalendarNetwork_KillSendersRSVPUpdates(pSender);
		
		--
		
		if vChanges then
			-- Give the owner high-priority to help ensure that he can roam successfully
			
			local	vPriority;
			
			if pSender == pUserName then
				vPriority = 1;
			else
				vPriority = 2;
			end
			
			CalendarNetwork_ProcessChangesRFU(vChanges, "RAT", vIsThisPlayerOwned, vPriority, pUserName, pDatabaseID, pRevision, pAuthRevision);
		end
	elseif vOpcode == "NOU" then
		-- If the sender is seen transmitting a NOU while he has a database update
		-- pending then it probably means he d/c'd.  Kill the database update in that
		-- case
		
		CalendarNetwork_KillSendersRSVPUpdates(pSender);
		
		--
		
		local		vCurrentRevision = 0;
		local		vDatabaseIDChanged = false;
		
		if not vIsThisPlayerOwned then
			CalendarNetwork_CancelRedundantNOURequests(vChanges, "RAT", pSender, pUserName, pDatabaseID, pRevision);
		end
		
		if vDatabase then
			-- Ignore external updates to our own databases
			
			if vDatabase.IsPlayerOwned then
				-- If someone sent out a NOU for one of our databases and it's older than
				-- ours and ours is now empty, send out a DEL to let them know that it's newer
				-- and empty now
				
				if CalendarChanges_IsEmpty(vChanges) then
					CalendarNetwork_SendEmptyChanges(vChanges, "RAT", pUserName);
				end
				
				return;
			end

			-- Ignore the update if the ID is older than the one we have
			-- unless it's from the owner
			
			if vChanges
			and pDatabaseID < vChanges.ID
			and pSender ~= vDatabase.UserName then
				return;
			end
			
			-- Purge the existing database if the ID is changing
			
			if not vChanges
			or vChanges.ID ~= pDatabaseID then
				vDatabaseIDChanged = true;
			else
				vCurrentRevision = vChanges.Revision;
			end
		end
		
		if vDatabaseIDChanged
		or vCurrentRevision < pRevision then
			CalendarNetwork_QueueRFURequest(pUserName, "RAT", pDatabaseID, pRevision);
		end
	elseif vOpcode == "UPD" then
		-- If the sender is seen transmitting an UPD while he has a database update
		-- pending then it probably means he d/c'd.  Kill the database update in that
		-- case
		
		CalendarNetwork_KillSendersRSVPUpdates(pSender, pUserName);
		
		--
		
		-- Begin a RSVP database update
		
		local	vSinceRevision = tonumber(vOperands[1]);
		
		if not vSinceRevision then
			if gGroupCalendar_Settings.DebugErrors then
				Calendar_DebugMessage("GroupCalendar: RAT UPD received from "..pSender.." for "..pUserName.." with no SinceRevision");
			end
			
			return;
		end
		
		if not vIsThisPlayerOwned then
			-- If we're waiting to ask for an update to this database, cancel the request
			
			CalendarNetwork_CancelRedundantRFURequest("RAT", pUserName, pDatabaseID, vSinceRevision);
			
			-- If we're waiting to send this same update, cancel the request
			
			CalendarNetwork_CancelRedundantUPDRequests(vChanges, "RAT", pUserName, pDatabaseID, pRevision, vSinceRevision);
		end
		
		CalendarNetwork_BeginRSVPUpdate(pSender, pUserName, pDatabaseID, pRevision, vSinceRevision);
		
	elseif vOpcode == "DEL" then
		-- Delete the database since it's empty
		
		if not vIsThisPlayerOwned then
			CalendarNetwork_CancelRedundantUPDRequests(vChanges, "RAT", pUserName, pDatabaseID, pRevision, 0);
		end
		
		CalendarNetwork_DeleteRSVPs(pSender, pUserName, pDatabaseID, pRevision);
		
	elseif vOpcode == "EVT" then
		-- Event data
		
		CalendarNetwork_InsertRSVPUpdate(pSender, pUserName, pDatabaseID, pRevision, vOperandString);
		
	elseif vOpcode == "END" then
		-- End a RSVP update
		
		local	vSinceRevision = tonumber(vOperands[1]);
		
		CalendarNetwork_EndRSVPUpdate(pSender, pUserName, pDatabaseID, pRevision, vSinceRevision);
	end
end

function CalendarNetwork_ProcessGuildCommand(pSender, pTrustLevel, pGuildName, pMinRank, pCommand)
	-- Ignore guild commands if they're not directed at the player's guild
	-- or not at the player's rank
	
	if pGuildName ~= gGroupCalendar_PlayerGuild
	or gGroupCalendar_PlayerGuildRank > pMinRank then
		return;
	end
	
	-- Pass it on to the ALL handler for further processing
	
	CalendarNetwork_ProcessAllCommand(pSender, pTrustLevel, pCommand);
end

function CalendarNetwork_ProcessAllCommand(pSender, pTrustLevel, pCommand)
	local	vOpcode = pCommand[1].opcode;
	local	vOperands = pCommand[1].operands;

	table.remove(pCommand, 1);
	
	if vOpcode == "RFU" then
		CalendarNetwork_SendAllRevisionNotices();
	elseif vOpcode == "RFV" then
		CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix.."VER:"..gGroupCalendar_VersionString);
	end
end

function CalendarNetwork_DatabaseIsNewer(pDatabaseID1, pRevision1, pDatabaseID2, pRevision2)
	if pDatabaseID2 > pDatabaseID1 then
		return true;
	elseif pDatabaseID2 < pDatabaseID1 then
		return false;
	else
		return pRevision2 > pRevision1;
	end
end

function CalendarNetwork_UpdateIsBetterThanOurs(pSender, pUserName, pDatabaseID, pRevision, pDatabase, pChanges)
	-- Updates for our own databases are always worse if
	-- we're on the toon
	
	if pDatabase.IsPlayerOwned and pUserName == gGroupCalendar_PlayerName then
		return false;
	end
	
	-- Updates from the owner are always better than ours
	-- as are updates when our list is empty
	
	if string.lower(pSender) == string.lower(pUserName)
	or not pChanges then
		return true;
	end
	
	-- If the revision is higher than what we have it's better
	
	return CalendarNetwork_DatabaseIsNewer(pChanges.ID, pChanges.Revision, pDatabaseID, pRevision);
end

function CalendarNetwork_DeleteDatabase(pSender, pUserName, pDatabaseID, pRevision)
	-- Get the database
	
	local		vDatabase = EventDatabase_GetDatabase(pUserName, false);
	
	-- Nothing to do if we don't even have the database
	
	if not vDatabase then
		return;
	end
	
	-- Bail out if our stuff is better
	
	if not CalendarNetwork_UpdateIsBetterThanOurs(pSender, pUserName, pDatabaseID, pRevision, vDatabase, vDatabase.Changes) then
		return;
	end
	
	-- Empty the specified changelist
	
	EventDatabase_PurgeDatabase(vDatabase, pDatabaseID);
	vDatabase.Changes.Revision = pRevision;
end

function CalendarNetwork_BeginDatabaseUpdate(pSender, pUserName, pDatabaseID, pRevision, pSinceRevision)
	-- If the same sender has a pending update already in progress, kill it
	
	CalendarNetwork_KillSendersDatabaseUpdates(pSender, pUserName);
	
	-- Get the database
	
	local		vDatabase = EventDatabase_GetDatabase(pUserName, false);
	
	-- Ignore updates for our own databases

	if vDatabase
	and vDatabase.IsPlayerOwned
	and not gGroupCalendar_Settings.AllowSelfUpdate then
		return;
	end
	
	local	vChanges;
	
	if vDatabase then
		vChanges = vDatabase.Changes;
	else
		vChanges = nil;
	end
	
	-- Ignore the update if it isn't from the owner and
	-- our database ID is newer
	
	if string.lower(pSender) ~= string.lower(pUserName)
	and vChanges then
		if (vChanges.ID > pDatabaseID)
		or (vChanges.ID == pDatabaseID
		and vChanges.Revision >= pRevision) then
			return;
		end
	end
	
	-- If it's from the owner and isn't the same revision as ours,
	-- then delete the database.  If the update is from revision
	-- zero go ahead with the update otherwise ignore it and request
	-- and update from zero
	
	if string.lower(pSender) == string.lower(pUserName)
	and vChanges
	and vChanges.ID ~= pDatabaseID then
		EventDatabase_PurgeDatabase(vDatabase, pDatabaseID);
		
		if pSinceRevision ~= 0 then
			-- Request an update and exit
			
			CalendarNetwork_QueueRFURequest(pUserName, "DB", pDatabaseID, 0)
			return;
		end
	end
	
	-- See if there's another update for the same database already in progress
	
	local	vDatabaseUpdate = CalendarNetwork_FindDatabaseUpdate(nil, pUserName, nil);
	
	if vDatabaseUpdate then
		-- If the new update is from the owner or
		-- the old one isn't from the owner and is a higher revision,
		-- then cancel the old update
		
		if string.lower(pSender) == string.lower(pUserName)
		or (vDatabaseUpdate.mSender ~= vDatabaseUpdate.mUserName
		and CalendarNetwork_DatabaseIsNewer(vDatabaseUpdate.mDatabaseID, vDatabaseUpdate.mRevision, pDatabaseID, pRevision))  then
			CalendarNetwork_CancelDatabaseUpdate(nil, pUserName, nil);
		
		-- Otherwise cancel this one
		
		else
			return;
		end
	end
	
	if gGroupCalendar_Settings.DebugUpdates then
		Calendar_DebugMessage("CalendarNetwork_BeginDatabaseUpdate: "..pUserName..","..pRevision.." since revision "..pSinceRevision.." from "..pSender);
	end

	-- Can't accept updates which don't cover the last revision we received
	
	if vChanges
	and pSinceRevision > vChanges.Revision then
		-- Ask for another copy of the update starting with the revision we need
		
		CalendarNetwork_QueueRFURequest(pUserName, "DB", pDatabaseID, vChanges.Revision)
		return;
	end
	
	-- Create the database update record
	
	vDatabaseUpdate = {};
	
	vDatabaseUpdate.mSender = pSender;
	vDatabaseUpdate.mUserName = pUserName;
	vDatabaseUpdate.mDatabaseID = pDatabaseID;
	vDatabaseUpdate.mRevision = pRevision;
	vDatabaseUpdate.mSinceRevision = pSinceRevision;
	vDatabaseUpdate.mChanges = {};
	vDatabaseUpdate.mLastMessageTime = Calendar_GetCurrentLocalDateTimeStamp();
	
	table.insert(gGroupCalendar_Queue.DatabaseUpdates, vDatabaseUpdate);
end

function CalendarNetwork_InsertEventUpdate(pSender, pUserName, pDatabaseID, pRevision, pEventID, pCommand)
	local	vDatabaseUpdate = CalendarNetwork_FindDatabaseUpdate(pSender, pUserName, pDatabaseID);
	
	if not vDatabaseUpdate then
		return;
	end
	
	-- Bump the update time
	
	vDatabaseUpdate.mLastMessageTime = Calendar_GetCurrentLocalDateTimeStamp();
	
	--
	
	local	vChanges = vDatabaseUpdate.mChanges[pRevision];
	
	if not vChanges then
		vChanges = {};
		vDatabaseUpdate.mChanges[pRevision] = vChanges;
	end
	
	-- Reconstruct the change string
	
	local	vChangeString = "EVT:"..pEventID;
	
	for vIndex, vCommand in pCommand do
		vChangeString = vChangeString.."/"..vCommand.opcode;
		
		if vCommand.operandString and vCommand.operandString ~= "" then
			vChangeString = vChangeString..":"..vCommand.operandString;
		end
	end
	
	-- Save the string
	
	table.insert(vChanges, vChangeString);
end

function CalendarNetwork_EndDatabaseUpdate(pSender, pUserName, pDatabaseID, pRevision, pSinceRevision)
	local	vDatabaseUpdate = CalendarNetwork_FindDatabaseUpdate(pSender, pUserName, pDatabaseID, true);
	
	if not vDatabaseUpdate then
		return;
	end
	
	-- Sanity check: make sure the sinceRevision field matches the original UPD message
	
	if vDatabaseUpdate.mSinceRevision ~= pSinceRevision then
		return;
	end
	
	-- The update was received successfully.
	-- Copy the changes to the change list
	
	if gGroupCalendar_Settings.DebugUpdates then
		Calendar_DebugMessage("CalendarNetwork_EndDatabaseUpdate: Process update for "..pUserName..","..pDatabaseID..","..pRevision.." since revision "..pSinceRevision.." from "..pSender);
	end
	
	local	vDatabase = EventDatabase_GetDatabase(pUserName, true);
	local	vDatabaseChanges = vDatabase.Changes;
	local	vReconstructDatabase = false;
	
	-- If the update is for one of our own databases process it
	-- separately
	
	if vDatabase.IsPlayerOwned then
		CalendarNetwork_AskProcessSelfUpdate(vDatabaseUpdate);
		return;
	end
	
	-- Process the update
	
	CalendarNetwork_ProcessDatabaseUpdate(vDatabaseUpdate, false);
end

function CalendarNetwork_ProcessDatabaseUpdate(pDatabaseUpdate, pForceReconstruct)
	local	vIsOwnerUpdate = pDatabaseUpdate.mSender == pDatabaseUpdate.mUserName;
	local	vDatabase = EventDatabase_GetDatabase(pDatabaseUpdate.mUserName, true);
	local	vDatabaseChanges = vDatabase.Changes;
	local	vReconstructDatabase = pForceReconstruct;
	
	if not vDatabaseChanges
	or vDatabaseChanges.ID ~= pDatabaseUpdate.mDatabaseID then
		vDatabase.Changes = CalendarChanges_New(pDatabaseUpdate.mDatabaseID);
		vDatabaseChanges = vDatabase.Changes;
	end
	
	for vRevision = pDatabaseUpdate.mSinceRevision + 1, pDatabaseUpdate.mRevision do
		local	vChanges = pDatabaseUpdate.mChanges[vRevision];
		
		-- If the revision is newer than what we have, insert the new data
		
		if vRevision > vDatabaseChanges.Revision then
			CalendarChanges_SetChangeList(vDatabaseChanges, vRevision, vChanges);
			
			if vChanges then
				EventDatabase_ExecuteChangeList(vDatabase, vChanges, true);
			end
		
		-- If the revision overlaps what we have and the update is from
		-- the owner, then compare the data to make sure it's intact.  If
		-- it doesn't match then update the changes and flag the database
		-- for reconstruction
		
		elseif vIsOwnerUpdate then
			-- If we're not reconstructing then compare the owner's changes to what
			-- we've gotten before and see if they match.  Switch to reconstruction
			-- mode if there's a discrepancy
			
			if not vReconstructDatabase then
				local	vChangeList = CalendarChanges_GetChangeList(vDatabaseChanges, vRevision);
				
				if ((vChanges ~= nil) ~= (vChangeList ~= nil))
				or (vChangeList ~= nil and table.getn(vChangeList) ~= table.getn(vChanges)) then
					vReconstructDatabase = true;
					
					if gGroupCalendar_Settings.DebugReconstruct then
						Calendar_DebugMessage("Reconstructing "..vDatabase.UserName.." because changes for revision "..vRevision.." are different lengths");
					end
				elseif vChanges ~= nil then
					for vChangeIndex, vChange in vChanges do
						local	vOldChange = vChangeList[vChangeIndex];
						
						if vOldChange ~= vChange then
							vReconstructDatabase = true;
							
							if gGroupCalendar_Settings.DebugReconstruct then
								Calendar_DebugMessage("Reconstructing "..vDatabase.UserName.." because change "..vChangeIndex.." for revision "..vRevision.." doesn't match");
								Calendar_DebugMessage("Previously: "..vOldChange);
								Calendar_DebugMessage("Now: "..vChange);
							end
							break;
						end
					end
				end
			end
			
			-- Just copy the changes over if we're in re-construction mode
			
			if vReconstructDatabase then
				CalendarChanges_SetChangeList(vDatabaseChanges, vRevision, vChanges);
			end
		end
	end
	
	-- Make sure the current revision stamp matches the update
	
	vDatabaseChanges.Revision = pDatabaseUpdate.mRevision;
	
	-- Update AuthRevision if the update came from the owner
	
	if vIsOwnerUpdate
	and pDatabaseUpdate.mSinceRevision <= vDatabaseChanges.AuthRevision then
		vDatabaseChanges.AuthRevision = pDatabaseUpdate.mRevision;
	end
	
	if vReconstructDatabase then
		EventDatabase_ReconstructDatabase(vDatabase);
	else
		GroupCalendar_MajorDatabaseChange(vDatabase);
	end
end

StaticPopupDialogs["CONFIRM_CALENDAR_SELF_UPDATE"] = {
	text = TEXT(GroupCalendar_cConfirmSelfUpdateMsg),
	button1 = TEXT(GroupCalendar_cUpdate),
	button2 = TEXT(CANCEL),
	OnAccept = function() CalendarNetwork_ProcessSelfUpdate(); end,
	OnCancel = function() CalendarNetwork_RejectSelfUpdate(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
};

gGroupCalendar_DidAskSelfUpdate = false;
gGroupCalendar_SelfDatabaseUpdate = nil;

function CalendarNetwork_AskProcessSelfUpdate(pDatabaseUpdate)
	-- Only ask once
	
	if gGroupCalendar_DidAskSelfUpdate then
		return;
	end
	
	gGroupCalendar_DidAskSelfUpdate = true;
	
	gGroupCalendar_SelfDatabaseUpdate = pDatabaseUpdate;
	
	-- Format the message
	
	local	vMessage = Calendar_FormatNamed(GroupCalendar_cConfirmSelfUpdateParamFormat, pDatabaseUpdate);
	
	-- Show the dialog
	
	StaticPopup_Show("CONFIRM_CALENDAR_SELF_UPDATE", vMessage);
end

StaticPopupDialogs["CONFIRM_CALENDAR_SELF_RSVP_UPDATE"] = {
	text = TEXT(GroupCalendar_cConfirmSelfUpdateMsg),
	button1 = TEXT(GroupCalendar_cUpdate),
	button2 = TEXT(CANCEL),
	OnAccept = function() CalendarNetwork_ProcessSelfRSVPUpdate(); end,
	OnCancel = function() CalendarNetwork_RejectSelfRSVPUpdate(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
	showAlert = 1,
};

gGroupCalendar_DidAskSelfRSVPUpdate = false;
gGroupCalendar_SelfRSVPUpdate = nil;

function CalendarNetwork_AskProcessSelfRSVPUpdate(pRSVPUpdate)
	-- Only ask once
	
	if gGroupCalendar_DidAskSelfRSVPUpdate then
		return;
	end
	
	gGroupCalendar_DidAskSelfRSVPUpdate = true;
	gGroupCalendar_SelfRSVPUpdate = pRSVPUpdate;
	
	-- Format the message
	
	local	vMessage = Calendar_FormatNamed(GroupCalendar_cConfirmSelfRSVPUpdateParamFormat, pRSVPUpdate);
	
	-- Show the dialog
	
	StaticPopup_Show("CONFIRM_CALENDAR_SELF_RSVP_UPDATE", vMessage);
end

function CalendarNetwork_ProcessSelfUpdate()
	CalendarNetwork_ProcessDatabaseUpdate(gGroupCalendar_SelfDatabaseUpdate, true);
end

function CalendarNetwork_RejectSelfUpdate()
	local	vDatabase = EventDatabase_GetDatabase(gGroupCalendar_SelfDatabaseUpdate.mUserName, true);
	
	if not vDatabase then
		return;
	end
	
	EventDatabase_RebuildDatabase(vDatabase);
end

function CalendarNetwork_CancelDatabaseUpdate(pSender, pUserName, pDatabaseID)
	CalendarNetwork_FindDatabaseUpdate(pSender, pUserName, pDatabaseID, true);
end

function CalendarNetwork_FindOpenEventChangeRecord(pChanges, pEventID)
	for vIndex, vChange in pChanges do
		if vChange.mEventID == pEventID
		and vChange.mOpen then
			return vChange;
		end
	end
	
	return nil;
end

function CalendarNetwork_KillSendersDatabaseUpdates(pSender)
	local	vDatabaseUpdate = CalendarNetwork_FindDatabaseUpdate(pSender, nil, nil, true);
	
	if not vDatabaseUpdate
	or vDatabaseUpdate.mUserName == pDontRequestForUserName then
		return;
	end
	
	CalendarNetwork_RequestUpdateForUser(vDatabaseUpdate.mUserName, "DB");
end

function CalendarNetwork_FindDatabaseUpdate(pSender, pUserName, pDatabaseID, pDelete)
	for vIndex, vDatabaseUpdate in gGroupCalendar_Queue.DatabaseUpdates do
		if (pSender == nil or vDatabaseUpdate.mSender == pSender)
		and (pUserName == nil or vDatabaseUpdate.mUserName == pUserName)
		and (pDatabaseID == nil or vDatabaseUpdate.mDatabaseID == pDatabaseID) then
			-- Delete the update if requested
			
			if pDelete then
				table.remove(gGroupCalendar_Queue.DatabaseUpdates, vIndex);
			end
			
			return vDatabaseUpdate;
		end
	end
	
	return nil;
end

function CalendarNetwork_DeleteRSVPs(pSender, pUserName, pDatabaseID, pRevision)
	-- Get the database
	
	local		vDatabase = EventDatabase_GetDatabase(pUserName, false);
	
	-- Nothing to do if we don't even have the database
	
	if not vDatabase then
		return;
	end
	
	-- Bail out if our stuff is better
	
	if not CalendarNetwork_UpdateIsBetterThanOurs(pSender, pUserName, pDatabaseID, pRevision, vDatabase, vDatabase.RSVPs) then
		return;
	end
	
	-- Empty the specified changelist
	
	EventDatabase_PurgeRSVPs(vDatabase, pDatabaseID);
	vDatabase.RSVPs.Revision = pRevision;
end

function CalendarNetwork_BeginRSVPUpdate(pSender, pUserName, pDatabaseID, pRevision, pSinceRevision)
	-- If the same sender has a pending update already in progress, kill it
	
	CalendarNetwork_KillSendersRSVPUpdates(pSender, pUserName);
	
	-- Get the database
	
	local		vDatabase = EventDatabase_GetDatabase(pUserName, false);
	
	-- Don't listen to updates for our own databases
	
	if vDatabase
	and vDatabase.IsPlayerOwned
	and not gGroupCalendar_Settings.AllowSelfUpdate then
		return;
	end
	
	local		vChanges;
	
	if vDatabase then
		vChanges = vDatabase.RSVPs;
	else
		vChanges = nil;
	end
	
	-- Ignore the update if it isn't from the owner and
	-- our ID is newer
	
	if string.lower(pSender) ~= string.lower(pUserName)
	and vChanges then
		if (vChanges.ID > pDatabaseID)
		or (vChanges.ID == pDatabaseID
		and vChanges.Revision >= pRevision) then
			return;
		end
	end

	-- If it's from the owner and isn't the same revision as ours,
	-- then delete the database.  If the update is from revision
	-- zero go ahead with the update otherwise ignore it and request
	-- and update from zero
	
	if string.lower(pSender) == string.lower(pUserName)
	and vChanges
	and vChanges.ID ~= pDatabaseID then
		EventDatabase_PurgeRSVPs(vDatabase, pDatabaseID);
		
		if pSinceRevision ~= 0 then
			-- Request an update and exit
			
			CalendarNetwork_QueueRFURequest(pUserName, "RAT", pDatabaseID, 0)
			return;
		end
	end
	
	-- See if there's another update for the same database already in progress
	
	local	vRSVPUpdate = CalendarNetwork_FindRSVPUpdate(nil, pUserName, nil);
	
	if vRSVPUpdate then
		-- If the new update is from the owner or
		-- the old one isn't from the owner and is a higher revision,
		-- then cancel the old update
		
		if string.lower(pSender) == string.lower(pUserName)
		or (vRSVPUpdate.mSender ~= vRSVPUpdate.mUserName
		and CalendarNetwork_DatabaseIsNewer(vRSVPUpdate.mDatabaseID, vRSVPUpdate.mRevision, pDatabaseID, pRevision))  then
			CalendarNetwork_CancelRSVPUpdate(nil, pUserName, nil);
		
		-- Otherwise cancel this one
		
		else
			return;
		end
	end
	
	if gGroupCalendar_Settings.DebugUpdates then
		Calendar_DebugMessage("CalendarNetwork_BeginRSVPUpdate: "..pUserName..","..pRevision.." since revision "..pSinceRevision.." from "..pSender);
	end

	-- Can't accept updates which don't cover the last revision we received
	
	if vChanges
	and pSinceRevision > vChanges.Revision then
		-- Ask for another copy of the update starting with the revision we need
		
		CalendarNetwork_QueueRFURequest(pUserName, "RAT", pDatabaseID, vChanges.Revision);
		return;
	end
	
	-- Create the update record
	
	vRSVPUpdate = {};
	
	vRSVPUpdate.mSender = pSender;
	vRSVPUpdate.mUserName = pUserName;
	vRSVPUpdate.mDatabaseID = pDatabaseID;
	vRSVPUpdate.mRevision = pRevision;
	vRSVPUpdate.mSinceRevision = pSinceRevision;
	vRSVPUpdate.mChanges = {};
	vRSVPUpdate.mLastMessageTime = Calendar_GetCurrentLocalDateTimeStamp();
	
	table.insert(gGroupCalendar_Queue.RSVPUpdates, vRSVPUpdate);
end

function CalendarNetwork_InsertRSVPUpdate(pSender, pUserName, pDatabaseID, pRevision, pEventFields)
	local	vRSVPUpdate = CalendarNetwork_FindRSVPUpdate(pSender, pUserName, pDatabaseID);
	
	if not vRSVPUpdate then
		if gGroupCalendar_Settings.DebugUpdates then
			Calendar_DebugMessage("CalendarNetwork_InsertRSVPUpdate: Ignoring update for "..pUserName..","..pDatabaseID..": Update not found");
		end
		return;
	end
	
	-- Bump the update time
	
	vRSVPUpdate.mLastMessageTime = Calendar_GetCurrentLocalDateTimeStamp();
	
	--
	
	local	vChanges = vRSVPUpdate.mChanges[pRevision];
	
	if not vChanges then
		vChanges = {};
		vRSVPUpdate.mChanges[pRevision] = vChanges;
	end
	
	-- Process the event command
	
	local	vChangeString = "EVT:"..pEventFields;
	
	table.insert(vChanges, vChangeString);
end

function CalendarNetwork_EndRSVPUpdate(pSender, pUserName, pDatabaseID, pRevision, pSinceRevision)
	local	vRSVPUpdate = CalendarNetwork_FindRSVPUpdate(pSender, pUserName, pDatabaseID, true);
	
	if not vRSVPUpdate then
		return;
	end
	
	-- Sanity check: make sure the sinceRevision field matches the original UPD message
	
	if vRSVPUpdate.mSinceRevision ~= pSinceRevision then
		return;
	end
	
	-- The update was received successfully.
	-- Process the commands in the update
	
	if gGroupCalendar_Settings.DebugUpdates then
		Calendar_DebugMessage("CalendarNetwork_EndRSVPUpdate: Process update for "..pUserName..","..pRevision.." since revision "..pSinceRevision.." from "..pSender);
	end
	
	local	vDatabase = EventDatabase_GetDatabase(pUserName, true);
	local	vRSVPChanges = vDatabase.RSVPs;
	local	vReconstructRSVPs = false;
	
	-- If the update is for one of our own databases process it
	-- separately
	
	if vDatabase.IsPlayerOwned then
		CalendarNetwork_AskProcessSelfRSVPUpdate(vRSVPUpdate);
		return;
	end
	
	-- Process the update
	
	CalendarNetwork_ProcessRSVPUpdate(vRSVPUpdate, false);
end

function CalendarNetwork_ProcessRSVPUpdate(pRSVPUpdate, pForceReconstruct)
	local	vIsOwnerUpdate = pRSVPUpdate.mSender == pRSVPUpdate.mUserName;
	local	vDatabase = EventDatabase_GetDatabase(pRSVPUpdate.mUserName, true);
	local	vRSVPChanges = vDatabase.RSVPs;
	
	if not vRSVPChanges
	or vRSVPChanges.ID ~= pRSVPUpdate.mDatabaseID then
		vDatabase.RSVPs = CalendarChanges_New(pRSVPUpdate.mDatabaseID);
		vRSVPChanges = vDatabase.RSVPs;
	end
	
	for vRevision = pRSVPUpdate.mSinceRevision + 1, pRSVPUpdate.mRevision do
		local	vChanges = pRSVPUpdate.mChanges[vRevision];
		
		-- If the revision is newer than what we have, insert the new data
		
		if vRevision > vRSVPChanges.Revision then
			CalendarChanges_SetChangeList(vRSVPChanges, vRevision, vChanges);
			CalendarChanges_Close(vRSVPChanges, vRevision);
			
			if vChanges then
				EventDatabase_ExecuteRSVPChangeList(vDatabase, vChanges, true);
			end
		elseif vIsOwnerUpdate and vRevision > vRSVPChanges.AuthRevision then
			if gGroupCalendar_Settings.DebugUpdates then
				Calendar_DebugMessage("CalendarNetwork_EndRSVPUpdate: Ignoring owner update for "..vRevision..": Not implemented");
			end
		else
			if gGroupCalendar_Settings.DebugUpdates then
				Calendar_DebugMessage("CalendarNetwork_EndRSVPUpdate: Ignoring revision "..vRevision..": Already exists");
			end
		end
	end
	
	vRSVPChanges.Revision = pRSVPUpdate.mRevision;
	
	-- Update AuthRevision if the update came from the owner
	
	if vIsOwnerUpdate
	and pRSVPUpdate.mSinceRevision <= vRSVPChanges.AuthRevision then
		vRSVPChanges.AuthRevision = pRSVPUpdate.mRevision;
	end
end

function CalendarNetwork_ProcessSelfRSVPUpdate()
	CalendarNetwork_ProcessRSVPUpdate(gGroupCalendar_SelfRSVPUpdate, true);
end

function CalendarNetwork_RejectSelfRSVPUpdate()
	local	vDatabase = EventDatabase_GetDatabase(gGroupCalendar_SelfRSVPUpdate.mUserName, true);
	
	if not vDatabase then
		return;
	end
	
	EventDatabase_RebuildRSVPs(vDatabase);
end

function CalendarNetwork_CancelRSVPUpdate(pSender, pUserName, pDatabaseID)
	CalendarNetwork_FindRSVPUpdate(pSender, pUserName, pDatabaseID, true);
end

function CalendarNetwork_KillSendersRSVPUpdates(pSender, pDontRequestForUserName)
	local	vRSVPUpdate = CalendarNetwork_FindRSVPUpdate(pSender, nil, nil, pDelete);
	
	if not vRSVPUpdate
	or vRSVPUpdate.mUserName == pDontRequestForUserName then
		return;
	end
	
	CalendarNetwork_RequestUpdateForUser(vRSVPUpdate.mUserName, "RAT");
end

function CalendarNetwork_FindRSVPUpdate(pSender, pUserName, pDatabaseID, pDelete)
	for vIndex, vRSVPUpdate in gGroupCalendar_Queue.RSVPUpdates do
		if (pSender == nil or vRSVPUpdate.mSender == pSender)
		and (pUserName == nil or vRSVPUpdate.mUserName == pUserName)
		and (pDatabaseID == nil or vRSVPUpdate.mDatabaseID == pDatabaseID) then
			-- Delete the update if requested
			
			if pDelete then
				table.remove(gGroupCalendar_Queue.RSVPUpdates,vIndex);
			end
			
			return vRSVPUpdate;
		end
	end
	
	return nil;
end

function CalendarNetwork_KillOldUpdates(pDatabaseTag, pUpdates, pMinimumTime)
	local	vIndex = 1;
	local	vNumUpdates = table.getn(pUpdates);
	
	while vIndex <= vNumUpdates do
		local	vUpdate = pUpdates[vIndex];
		
		if vUpdate.mLastMessageTime < pMinimumTime then
			table.remove(pUpdates, vIndex);
			vNumUpdates = vNumUpdates - 1;
			
			-- Re-request the update
			
			CalendarNetwork_RequestUpdateForUser(vUpdate.mUserName, pDatabaseTag, false);
		else
			vIndex = vIndex + 1;
		end
	end
end

function CalendarNetwork_ParseCommandString(pCommandString)
	
	-- Verify the command begins with the message prefix
	
	if strsub(pCommandString, 1, gGroupCalendar_MessagePrefixLength) ~= gGroupCalendar_MessagePrefix then
		return nil;
	end
	
	local	vCommandString = strsub(pCommandString, gGroupCalendar_MessagePrefixLength);
	
	return CalendarNetwork_ParseCommandSubString(vCommandString)
end

function CalendarNetwork_ParseCommandSubString(pCommandString)
	-- Break the command into parts
	
	local	vCommand = {};
	
	for vOpcode, vOperands in string.gfind(pCommandString, "/(%w+):*([^/]*)") do
		local	vOperation = {};
		
		vOperation.opcode = vOpcode;
		vOperation.operandString = vOperands;
		vOperation.operands = CalendarNetwork_ParseParameterString(vOperands);
		
		table.insert(vCommand, vOperation);
	end
	
	return vCommand;
end

function CalendarNetwork_ParseParameterString(pParameterString)
	local	vParameters = {};
	local	vIndex = 0;
	local	vFound = true;
	local	vStartIndex = 1;
	
	while vFound do
		local	vEndIndex;
		
		vFound, vEndIndex, vParameter = string.find(pParameterString, "([^,]*),", vStartIndex);
		
		vIndex = vIndex + 1;
		
		if not vFound then
			vParameters[vIndex] = string.sub(pParameterString, vStartIndex);
			break;
		end
		
		vParameters[vIndex] = vParameter;
		vStartIndex = vEndIndex + 1;
	end
	
	return vParameters;
end

function CalendarNetwork_NewEvent(pDatabase, pEvent)
	-- Don't record private events in the change history
	
	if pEvent.mPrivate then
		return;
	end
	
	-- Append a change record for the event
	
	local	vChangeList = EventDatabase_GetCurrentChangeList(pDatabase);
	
	EventDatabase_AppendNewEvent(vChangeList, pEvent, EventDatabase_GetEventPath(pEvent));
end

function CalendarNetwork_EventChanged(pDatabase, pEvent, pChangedFields)
	-- Don't record private events in the change history
	
	if pEvent.mPrivate then
		return;
	end
	
	-- Append a change record for the event
	
	local	vChangeList = EventDatabase_GetCurrentChangeList(pDatabase);
	
	EventDatabase_AppendEventUpdate(
			vChangeList,
			pEvent,
			EventDatabase_GetEventPath(pEvent),
			pChangedFields);
end

function CalendarNetwork_RemovingEvent(pDatabase, pEvent)
	-- Don't record private events in the change history
	
	if pEvent.mPrivate then
		return;
	end
	
	-- Remove any references to the event from the change history

	EventDatabase_RemoveEventChanges(pDatabase, pEvent);
	
	-- Insert a delete event
	
	local	vChangeList = EventDatabase_GetCurrentChangeList(pDatabase);
	
	table.insert(vChangeList, EventDatabase_GetEventPath(pEvent).."DEL");
end

function CalendarNetwork_SendRevisionChanged(pChanges, pLabel, pUserName)
	-- Just leave if there's no channel to communicate on
	-- or no changes to announce
	
	if not gGroupCalendar_Channel.ID
	or not pChanges then
		return;
	end
	
	CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix..CalendarChanges_GetRevisionPath(pLabel, pUserName, pChanges.ID, pChanges.Revision).."NOU");
end

function CalendarNetwork_DBRevisionChanged(pDatabase)
	CalendarNetwork_SendRevisionChanged(pDatabase.Changes, "DB", pDatabase.UserName);
end

function CalendarNetwork_RSVPRevisionChanged(pDatabase)
	CalendarNetwork_SendRevisionChanged(pDatabase.RSVPs, "RAT", pDatabase.UserName);
end

function CalendarNetwork_RequestAllUpdate()
	-- Just leave if there's no channel to communicate on
	
	if not gGroupCalendar_Channel.ID then
		return;
	end
	
	-- Send the request immmediately since delaying it for channel silence will only
	-- increase the number of times that everyone has to transmit their NOU responses
	
	CalendarNetwork_SendMessage(gGroupCalendar_MessagePrefix.."ALL/RFU");
end

function CalendarNetwork_RequestGuildUpdate(pGuildName, pMinRank)
	-- Just leave if there's no channel to communicate on
	
	if not gGroupCalendar_Channel.ID then
		return;
	end
	
	-- Send the request immmediately since delaying it for channel silence will only
	-- increase the number of times that everyone has to transmit their NOU responses
	
	if pMinRank then
		CalendarNetwork_SendMessage(gGroupCalendar_MessagePrefix.."GLD:"..pGuildName..","..pMinRank.."/RFU");
	else
		CalendarNetwork_SendMessage(gGroupCalendar_MessagePrefix.."GLD:"..pGuildName.."/RFU");
	end
end

function CalendarNetwork_RequestUpdateForUser(pUserName, pDatabaseTag, pRequestImmediately)
	local	vDatabase = EventDatabase_GetDatabase(pUserName);

	if not vDatabase then
		return;
	end
	
	local	vChanges;
	
	if pDatabaseTag == "DB" then
		vChanges = vDatabase.Changes;
	elseif pDatabaseTag == "RAT" then
		vChanges = vDatabase.RSVPs;
	else
		Calendar_ErrorMessage("CalendarNetwork_RequestUpdateForUser: Unknown database tag "..pDatabaseTag);
		return;
	end
	
	if not vChanges then
		return;
	end
	
	CalendarNetwork_RequestUpdate(vDatabase, vChanges, pDatabaseTag, pRequestImmediately);
end

function CalendarNetwork_RequestUpdate(pDatabase, pChanges, pDatabaseTag, pRequestImmediately)
	-- Just leave if there's no channel to communicate on
	
	if not gGroupCalendar_Channel.ID then
		return;
	end
	
	local	vID, vRevision;
	
	if pChanges then
		vID = pChanges.ID;
		vRevision = pChanges.Revision;
	else
		vID = 0;
		vRevision = 0;
	end
	
	if pRequestImmediately then
		CalendarNetwork_SendMessage(gGroupCalendar_MessagePrefix..CalendarChanges_GetRevisionPath(pDatabaseTag, pDatabase.UserName, vID, vRevision, 0).."RFU");
	else
		CalendarNetwork_QueueRFURequest(pDatabase.UserName, pDatabaseTag, vID, vRevision);
	end
end

function CalendarNetwork_SendEmptyChanges(pChanges, pLabel, pUserName)
	local	vID, vRevision;
	
	if pChanges then
		vID = pChanges.ID;
		vRevision = pChanges.Revision;
	else
		vID = Calendar_GetCurrentDateTimeUT60();
		vRevision = 0;
	end
	
	CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix..CalendarChanges_GetRevisionPath(pLabel, pUserName, vID, vRevision).."DEL");
end

function CalendarNetwork_SendChanges(pChanges, pLabel, pUserName, pLockdown, pSinceRevision)
	if pLockdown then
		CalendarChanges_LockdownCurrentChangeList(pChanges);
	end
	
	if CalendarChanges_IsEmpty(pChanges) then
		CalendarNetwork_SendEmptyChanges(pChanges, pLabel, pUserName);
		return;
	end
	
	CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix..CalendarChanges_GetRevisionPath(pLabel, pUserName, pChanges.ID, pChanges.Revision).."UPD:"..pSinceRevision);
	
	for vRevision = pSinceRevision + 1, pChanges.Revision do
		local	vRevisionPath = CalendarChanges_GetRevisionPath(pLabel, pUserName, pChanges.ID, vRevision);
		local	vChangeList = pChanges.ChangeList[vRevision];
		
		if vChangeList then
			vChangeList.IsOpen = nil; -- Make sure IsOpen is cleared, a bug may have caused it to remain open
			
			for vIndex, vChange in vChangeList do
				CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix..vRevisionPath..vChange);
			end
		end
	end
	
	CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix..CalendarChanges_GetRevisionPath(pLabel, pUserName, pChanges.ID, pChanges.Revision).."END:"..pSinceRevision);
end

function CalendarNetwork_QueueOutboundMessage(pMessage)
	table.insert(gGroupCalendar_Queue.OutboundMessages, pMessage);
	
	GroupCalendar_StartUpdateTimer();
end

function CalendarNetwork_QueueInboundMessage(pSender, pTrustLevel, pMessage)
	table.insert(gGroupCalendar_Queue.InboundMessages, {mSender = pSender, mTrustLevel = pTrustLevel, mMessage = pMessage});
	
	if table.getn(gGroupCalendar_Queue.InboundMessages) == 1 then
		gGroupCalendar_Queue.InboundDelay = 0;
	end
	
	GroupCalendar_StartUpdateTimer();
end

function CalendarNetwork_QueueTask(pTaskFunc, pTaskParam, pDelay, pTaskID)
	local	vTask = {mTaskFunc = pTaskFunc, mTaskParam = pTaskParam, mDelay = pDelay, mID = pTaskID};
	
	-- Ignore tasks with duplicate IDs
	
	if pTaskID then
		for vIndex, vTask in gGroupCalendar_Queue.Tasks do
			if vTask.mID == pTaskID then
				return;
			end
		end
	end
	
	-- Insert the task
	
	table.insert(gGroupCalendar_Queue.Tasks, vTask);
	
	CalendarNetwork_UpdateTaskQueueDelay();
	
	return true;
end

function CalendarNetwork_UpdateTaskQueueDelay()
	local	vDelay = nil;
	
	for vIndex, vTask in gGroupCalendar_Queue.Tasks do
		if not vDelay
		or vTask.mDelay < vDelay then
			vDelay = vTask.mDelay;
		end
	end
	
	gGroupCalendar_Queue.TasksDelay = vDelay;
	
	if vDelay then
		GroupCalendar_StartUpdateTimer();
	end
end

function CalendarNetwork_SetTaskDelay(pTaskID, pDelay)
	-- Ignore tasks with duplicate IDs
	
	for vIndex, vTask in gGroupCalendar_Queue.Tasks do
		if vTask.mID == pTaskID then
			vTask.mDelay = pDelay;
			CalendarNetwork_UpdateTaskQueueDelay();
			return;
		end
	end
end

function CalendarNetwork_QueueRequest(pRequest, pDelay, pPriority)
	pRequest.mDelay = pDelay;
	
	if gGroupCalendar_Settings.DebugQueues then
		Calendar_DebugMessage("CalendarNetwork_QueueRequest: "..pRequest.mOpcode.." in "..pDelay.." seconds");
	end
	
	if not pPriority then
		pPriority = 2;
	end
	
	table.insert(gGroupCalendar_Queue.Requests[pPriority], pRequest);
	
	local	vTotalRequests = 0;
	
	for vPriority, vRequestQueue in gGroupCalendar_Queue.Requests do
		vTotalRequests = vTotalRequests + table.getn(gGroupCalendar_Queue.Requests[vPriority]);
	end
	
	if vTotalRequests == 1
	or (pRequest.mDelay < gGroupCalendar_Queue.RequestsDelay
	and pRequest.mDelay < gCalendarNetwork_RequestDelay.RequestQueue) then
		gGroupCalendar_Queue.RequestsDelay = pRequest.mDelay;
	end
	
	GroupCalendar_StartUpdateTimer();
	
	return true;
end

function CalendarNetwork_SetRequestPriority(pRequest, pPriority)
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		for vIndex, vRequest in vRequests do
			if vRequest == pRequest then
				if vPriority ~= pPriority then
					table.remove(vRequests, vIndex);
					table.insert(gGroupCalendar_Queue.Requests[pPriority], vRequest);
				end
				return;
			end
		end
	end
end

function CalendarNetwork_QueueUniqueOpcodeRequest(pRequest, pDelay)
	-- Remove an existing request with the same opcode
	
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		for vIndex, vRequest in vRequests do
			if vRequest.mOpcode == pRequest.mOpcode then
				table.remove(vRequests, vIndex);
				break;
			end
		end
	end
	
	return CalendarNetwork_QueueRequest(pRequest, pDelay);
end

function CalendarNetwork_QueueUniqueUserRequest(pRequest, pDelay)
	-- Remove an existing request with the same opcode and user name
	
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		for vIndex, vRequest in vRequests do
			if vRequest.mOpcode == pRequest.mOpcode
			and vRequest.mUserName == pRequest.mUserName then
				table.remove(vRequests, vIndex);
				break;
			end
		end
	end
	
	return CalendarNetwork_QueueRequest(pRequest, pDelay);
end

function CalendarNetwork_ArrayContainsArray(pArray, pSubArray)
	for vFieldName, vFieldValue in pSubArray do
		if pArray[vFieldName] ~= vFieldValue then
			return false;
		end
	end
	
	return true;
end

function CalendarNetwork_FindRequest(pRequest)
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		for vIndex, vRequest in vRequests do
			if CalendarNetwork_ArrayContainsArray(vRequest, pRequest) then
				return vRequest;
			end
		end
	end
	
	return nil;
end

function CalendarNetwork_FindUPDRequest(pDatabaseTag, pUserName)
	return CalendarNetwork_FindRequest({mOpcode = pDatabaseTag.."_UPD", mUserName = pUserName});
end

function CalendarNetwork_CancelRedundantRFURequest(pDatabaseTag, pUserName, pDatabaseID, pFromRevision)
	local	vOpcode = pDatabaseTag.."_RFU";
	
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		for vIndex, vRequest in vRequests do
			if vRequest.mOpcode == vOpcode
			and vRequest.mUserName == pUserName then
				if vRequest.mDatabaseID == pDatabaseID
				and pFromRevision <= vRequest.mRevision then
					if gGroupCalendar_Settings.DebugUpdates then
						Calendar_DebugMessage("Removing redundant RFU for "..pDatabaseTag.." "..pUserName..","..pDatabaseID..","..pFromRevision);
					end
					
					table.remove(vRequests, vIndex);
					return false; -- Return false to indicate there is no longer an RFU for this user
				else
					if gGroupCalendar_Settings.DebugUpdates then
						Calendar_DebugMessage("Keeping RFU request for "..pDatabaseTag.." "..pUserName..","..vRequest.mDatabaseID..","..vRequest.mRevision);
						Calendar_DebugMessage("Better thean "..pDatabaseTag.." "..pUserName..","..pDatabaseID..","..pFromRevision);
					end
				end
				
				if gGroupCalendar_Settings.DebugUpdates then
					Calendar_DebugMessage("RFU for "..pDatabaseTag.." "..pUserName..","..pDatabaseID..","..pFromRevision.." already exists");
				end
				
				return true; -- Return true to indicate there is an RFU for this user
			end
		end
	end
	
	return false; -- Return false to indicate no RFU for this user was found
end

function CalendarNetwork_NeedsUpdateTimer()
	if gGroupCalendar_Queue.TasksDelay then
		return true;
	end
	
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		if table.getn(vRequests) > 0 then
			return true;
		end
	end
	
	if table.getn(gGroupCalendar_Queue.InboundMessages) > 0 then
		return true;
	end

	if table.getn(gGroupCalendar_Queue.OutboundMessages) > 0 then
		return true;
	end
	
	return false;
end

function CalendarNetwork_ProcessTaskQueue(pElapsed)
	if not gGroupCalendar_Queue.TasksDelay then
		return;
	end
	
	gGroupCalendar_Queue.TasksDelay = gGroupCalendar_Queue.TasksDelay - pElapsed;
	gGroupCalendar_Queue.TasksElapsed = gGroupCalendar_Queue.TasksElapsed + pElapsed;
	
	if gGroupCalendar_Queue.TasksDelay <= 0 then
		local	vNumTasks = table.getn(gGroupCalendar_Queue.Tasks);
		local	vIndex = 1;
		
		gGroupCalendar_Queue.TasksDelay = nil;
		
		local	vLatencyStartTime;
		
		if gGroupCalendar_Settings.DebugLatency then
			vLatencyStartTime = GetTime();
		end
		
		while vIndex <= vNumTasks do
			local	vTask = gGroupCalendar_Queue.Tasks[vIndex];
			
			vTask.mDelay = vTask.mDelay - gGroupCalendar_Queue.TasksElapsed;
			
			if vTask.mDelay <= 0 then
				table.remove(gGroupCalendar_Queue.Tasks, vIndex);
				vNumTasks = vNumTasks - 1;
				
				-- Perform the task
				
				vTask.mTaskFunc(vTask.mTaskParam);

			else
				if not gGroupCalendar_Queue.TasksDelay
				or vTask.mDelay < gGroupCalendar_Queue.TasksDelay then
					gGroupCalendar_Queue.TasksDelay = vTask.mDelay;
				end
				
				vIndex = vIndex + 1;
			end
		end
		
		if gGroupCalendar_Settings.DebugLatency then
			local	vElapsed = GetTime() - vLatencyStartTime;
			
			if vElapsed > 0.1 then
				Calendar_DebugMessage("Tasks took "..vElapsed.."s to execute ("..vNumTasks.." tasks)");
			end
		end
		
		gGroupCalendar_Queue.TasksElapsed = 0;
	end
end

function CalendarNetwork_ProcessInboundQueue(pElapsed, pCurrentTimeStamp)
	local	vNumInboundMessages = table.getn(gGroupCalendar_Queue.InboundMessages);
	
	if vNumInboundMessages > 0 then
		local	vCollisionDetected = false;
		
		gGroupCalendar_Queue.InboundDelay = gGroupCalendar_Queue.InboundDelay - pElapsed;
		
		if gGroupCalendar_Queue.InboundDelay <= 0 then
			-- Process one message
			
			local	vMessage = gGroupCalendar_Queue.InboundMessages[1];
			
			table.remove(gGroupCalendar_Queue.InboundMessages, 1);
			
			local	vLatencyStartTime;
			
			if gGroupCalendar_Settings.DebugLatency then
				vLatencyStartTime = GetTime();
			end
			
			CalendarNetwork_ProcessCommandString(vMessage.mSender, vMessage.mTrustLevel, vMessage.mMessage, pCurrentTimeStamp);
			
			if gGroupCalendar_Settings.DebugLatency then
				local	vElapsed = GetTime() - vLatencyStartTime;
				
				if vElapsed > 0.1 then
					Calendar_DebugMessage("Inbound message took "..vElapsed.."s to process");
					Calendar_DumpArray("Message", vMessage);
				end
			end

			gGroupCalendar_Queue.InboundDelay = gCalendarNetwork_RequestDelay.InboundQueue;
			
			if gGroupCalendar_Queue.InboundLastSender ~= vMessage.mSender then
				if gGroupCalendar_Queue.InboundTimeSinceLastMessage < gCalendarNetwork_RequestDelay.OutboundQueueGapMin then
					-- Collision between other senders detected
					
					if gGroupCalendar_Settings.DebugQueues then
						Calendar_DebugMessage("Collision detected between "..gGroupCalendar_Queue.InboundLastSender.." and "..vMessage.mSender);
					end
					
					vCollisionDetected = true;
				end
				
				gGroupCalendar_Queue.InboundLastSender = vMessage.mSender;
			end
			
			gGroupCalendar_Queue.InboundTimeSinceLastMessage = 0;
		end
		
		-- Terminate processing while there are any pending inbound messages and delay further
		-- processing of the outbound and request queues
		
		-- If there was a collision and we *weren't* part of it then increase the range to
		-- avoid allowing us to become a part of the next collision.  This should gradually eliminate
		-- transmittors from the collisions until someone successfully takes over the wire.
		-- This probably seems really counterintuitive, but the idea is to eliminate players who
		-- didn't participate in a collision from attempting to try again.  By doing this, each collision
		-- should eliminate a significant number of players from the accident, leaving only the actual
		-- victims to try again.  The next collision will then eliminate several of those players
		-- until within a few seconds only one player remains and that player will then have control
		-- and finish his transmission.
		
		local	vOutboundQueueGapMin = gCalendarNetwork_RequestDelay.OutboundQueueGapMin;
		local	vRequestQueueGapMin = gCalendarNetwork_RequestDelay.RequestQueueGapMin;
		
		if vCollisionDetected
		and gGroupCalendar_Queue.OutboundTimeSinceLastMessage > gCalendarNetwork_RequestDelay.OutboundQueueGapMin then
			-- Collision detected between other players so use a longer gap to make sure
			-- we're not part of the next collision

			vOutboundQueueGapMin = vOutboundQueueGapMin + gCalendarNetwork_RequestDelay.OutboundQueueGapWidth;
			vRequestQueueGapMin = vRequestQueueGapMin  + gCalendarNetwork_RequestDelay.RequestQueueGapWidth;
		end
		
		vRandom = math.random();
		
		if gGroupCalendar_Queue.OutboundDelay < vOutboundQueueGapMin then
			gGroupCalendar_Queue.OutboundDelay = vOutboundQueueGapMin + vRandom * gCalendarNetwork_RequestDelay.OutboundQueueGapWidth;
		end
		
		if gGroupCalendar_Queue.RequestsDelay < vRequestQueueGapMin then
			gGroupCalendar_Queue.RequestsDelay = vRequestQueueGapMin + vRandom * gCalendarNetwork_RequestDelay.RequestQueueGapWidth;
		end
		
		return true;
	end
	
	return false;
end

function CalendarNetwork_ProcessOutboundQueue(pElapsed)
	local	vNumOutboundMessages = table.getn(gGroupCalendar_Queue.OutboundMessages);
	
	if vNumOutboundMessages > 0 then
		gGroupCalendar_Queue.OutboundDelay = gGroupCalendar_Queue.OutboundDelay - pElapsed;
		
		if gGroupCalendar_Queue.OutboundDelay <= 0 then
			local	vLatencyStartTime;
			
			if gGroupCalendar_Settings.DebugLatency then
				vLatencyStartTime = GetTime();
			end
			
			-- Send one message

			local	vMessage = gGroupCalendar_Queue.OutboundMessages[1];
			
			table.remove(gGroupCalendar_Queue.OutboundMessages, 1);
			
			CalendarNetwork_SendMessage(vMessage);
			
			gGroupCalendar_Queue.OutboundDelay = gCalendarNetwork_RequestDelay.OutboundQueue;
			
			-- Reset the time since last message to figure out if we're part of a collision
			
			gGroupCalendar_Queue.OutboundTimeSinceLastMessage = 0;
			
			--
			
			if gGroupCalendar_Settings.DebugLatency then
				local	vElapsed = GetTime() - vLatencyStartTime;
				
				if vElapsed > 0.1 then
					Calendar_DebugMessage("Outbound message took "..vElapsed.."s to process");
					Calendar_DebugMessage(vMessage);
				end
			end
			
			-- Stop processing if this isn't the last outbound message, otherwise
			-- go ahead and allow the request queue to be processed
			
			if vNumOutboundMessages == 1 then
				gGroupCalendar_Queue.RequestsDelay = 0;
			else
				return true;
			end
		else
			-- Terminate processing while there are any pending outbound messages and delay further
			-- processing of the request queues
			
			gGroupCalendar_Queue.RequestsDelay = gCalendarNetwork_RequestDelay.RequestQueueGapMin + math.random() * gCalendarNetwork_RequestDelay.RequestQueueGapWidth;
			return true;
		end
	end
	
	return false;
end

GroupCalendar_cUpdateRequestOpcodes =
{
	["DB_UPD"] = true,
	["RAT_UPD"] = true,
	["DB_NOU"] = true,
	["RAT_NOU"] = true
};

function CalendarNetwork_CanProcessRequest(pRequest)
	if not GroupCalendar_cUpdateRequestOpcodes[pRequest.mOpCode] then
		return true;
	end
	
	if not gGroupCalendar_EnableUpdates then
		return false;
	end
	
	if pRequest.mUserName then
		local	vDatabase = EventDatabase_GetDatabase(pRequest.mUserName, false);
		
		if vDatabase
		and vDatabase.IsPlayerOwned
		and not gGroupCalendar_EnableSelfUpdates then
			return false;
		end
	end
	
	return true;	
end

function CalendarNetwork_ProcessRequestQueue(pElapsed, pSuppressProcessing)
	local	vNumRequests = 0;
	
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		vNumRequests = vNumRequests + table.getn(vRequests);
	end
	
	if vNumRequests > 0 then
		gGroupCalendar_Queue.RequestsDelay = gGroupCalendar_Queue.RequestsDelay - pElapsed;
		gGroupCalendar_Queue.RequestsElapsed = gGroupCalendar_Queue.RequestsElapsed + pElapsed;
		
		if gGroupCalendar_Queue.RequestsDelay <= 0 then
			-- Process one request
			
			local	vDidProcessRequest = pSuppressProcessing;
			local	vMinDelayForNextRequest = nil;
			
			local	vLatencyStartTime;
			local	vTotalRequests = 0;
			
			if gGroupCalendar_Settings.DebugLatency then
				vLatencyStartTime = GetTime();
			end
			
			for vPriority, vRequests in gGroupCalendar_Queue.Requests do
				local	vIndex = 1;
				local	vNumRequestsThisQueue = table.getn(vRequests);
				
				vTotalRequests = vTotalRequests + vNumRequestsThisQueue;
				
				while vIndex <= vNumRequestsThisQueue do
					local	vRequest = vRequests[vIndex];
					
					if vRequest.mDelay > 0 then
						vRequest.mDelay = vRequest.mDelay - gGroupCalendar_Queue.RequestsElapsed;
						
						if vRequest.mDelay < 0 then
							vRequest.mDelay = 0;
						end
					end
					
					if vRequest.mDelay == 0
					and not vDidProcessRequest then
						table.remove(vRequests, vIndex);
						vNumRequestsThisQueue = vNumRequestsThisQueue - 1;
						
						CalendarNetwork_ProcessRequest(vRequest);
						
						vDidProcessRequest = true;
					else
						if not vMinDelayForNextRequest
						or vRequest.mDelay < vMinDelayForNextRequest then
							vMinDelayForNextRequest = vRequest.mDelay;
						end
						
						vIndex = vIndex + 1;
					end
				end -- while vIndex
			end -- for vPriority
			
			if gGroupCalendar_Settings.DebugLatency then
				local	vElapsed = GetTime() - vLatencyStartTime;
				
				if vElapsed > 0.1 then
					Calendar_DebugMessage("Requests took "..vElapsed.."s to process ("..vTotalRequests.." total requests)");
				end
			end
			
			if not vMinDelayForNextRequest
			or vMinDelayForNextRequest < gCalendarNetwork_RequestDelay.RequestQueue then
				vMinDelayForNextRequest = gCalendarNetwork_RequestDelay.RequestQueue;
			end
			
			gGroupCalendar_Queue.RequestsDelay = vMinDelayForNextRequest;
			gGroupCalendar_Queue.RequestsElapsed = 0;
		end
	end
end

function CalendarNetwork_ProcessQueues(pElapsed)
	-- Get the current time stamp
	
	local	vCurrentTimeStamp = Calendar_GetCurrentLocalDateTimeStamp();

	-- Process tasks
	
	CalendarNetwork_ProcessTaskQueue(pElapsed);
	
	-- Update the collision detection counters
	
	gGroupCalendar_Queue.InboundTimeSinceLastMessage = gGroupCalendar_Queue.InboundTimeSinceLastMessage + pElapsed;
	gGroupCalendar_Queue.OutboundTimeSinceLastMessage = gGroupCalendar_Queue.OutboundTimeSinceLastMessage + pElapsed;
	
	-- Process inbound messages
	
	local	vSuppressRequests = false;
	
	if CalendarNetwork_ProcessInboundQueue(pElapsed, vCurrentTimeStamp) then
		vSuppressRequests = true;
	
	elseif CalendarNetwork_ProcessOutboundQueue(pElapsed) then
		vSuppressRequests = true;
	end
	
	-- Process pending requests if there are no outbound messages pending
	
	CalendarNetwork_ProcessRequestQueue(pElapsed, vSuppressRequests);
end

function CalendarNetwork_ProcessRequest(pRequest)
	local	vDatabase;
	
	if pRequest.mUserName then
		vDatabase = EventDatabase_GetDatabase(pRequest.mUserName, false);
	else
		vDatabase = nil;
	end
	
	if pRequest.mOpcode == "DB_UPD" then
		if vDatabase then -- Check for nil since the database may have gotten deleted while in the queue
			CalendarNetwork_SendChanges(vDatabase.Changes, "DB", vDatabase.UserName, vDatabase.IsPlayerOwned, pRequest.mRevision);
		end

	elseif pRequest.mOpcode == "RAT_UPD" then
		if vDatabase then -- Check for nil since the database may have gotten deleted while in the queue
			CalendarNetwork_SendChanges(vDatabase.RSVPs, "RAT", vDatabase.UserName, vDatabase.IsPlayerOwned, pRequest.mRevision);
		end

	elseif pRequest.mOpcode == "DB_NOU" then
		if vDatabase then -- Check for nil since the database may have gotten deleted while in the queue
			CalendarNetwork_DBRevisionChanged(vDatabase);
		end

	elseif pRequest.mOpcode == "RAT_NOU" then
		if vDatabase then -- Check for nil since the database may have gotten deleted while in the queue
			CalendarNetwork_RSVPRevisionChanged(vDatabase);
		end

	elseif pRequest.mOpcode == "DB_RFU" then
		local	vCurrentRevision;
		local	vAuthRevision;
		
		if vDatabase and vDatabase.Changes then
			vCurrentRevision = vDatabase.Changes.Revision;
			vAuthRevision = vDatabase.Changes.AuthRevision;
		else
			vCurrentRevision = 0;
			vAuthRevision = nil;
		end
		
		if vCurrentRevision < pRequest.mRevision
		or vCurrentRevision == 0 then
			CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix..EventDatabase_GetDBRevisionPath(pRequest.mUserName, pRequest.mDatabaseID, vCurrentRevision, vAuthRevision).."RFU");
		end

	elseif pRequest.mOpcode == "RAT_RFU" then
		local	vCurrentRevision;
		local	vAuthRevision;
		
		if vDatabase and vDatabase.RSVPs then
			vCurrentRevision = vDatabase.RSVPs.Revision;
			vAuthRevision = vDatabase.RSVPs.AuthRevision;
		else
			vCurrentRevision = 0;
			vAuthRevision = nil;
		end
		
		if vCurrentRevision < pRequest.mRevision
		or vCurrentRevision == 0 then
			CalendarNetwork_QueueOutboundMessage(gGroupCalendar_MessagePrefix..EventDatabase_GetRSVPRevisionPath(pRequest.mUserName, pRequest.mDatabaseID, vCurrentRevision, vAuthRevision).."RFU");
		end
	
	elseif pRequest.mOpcode == "AUTOCONFIG" then
		CalendarNetwork_DoAutoConfig(pRequest.mCheckDatabaseTrust);
	
	elseif pRequest.mOpcode == "DBTRUST" then
		EventDatabase_CheckDatabaseTrust();
	
	elseif pRequest.mOpcode == "OWNEDNOTICES" then
		gGroupCalendar_EnableUpdates = true;
		gGroupCalendar_EnableSelfUpdates = true;
		CalendarNetwork_SendOwnedDatabaseUpdateNotices();
	end
end

function CalendarNetwork_Initialize()
	gGroupCalendar_Initialized = true;
	
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("GroupCalendar Initializing: Starting initialization");
	end

	CalendarNetwork_PlayerGuildChanged();

	-- Go ahead and do manual channel configuration now, automatic
	-- config will be handled once the player guild gets set and
	-- the roster gets loaded

	if not gGroupCalendar_PlayerSettings.Channel.AutoConfig then
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("GroupCalendar INIT: Starting up data channel (manual configuration)");
		end
		
		if gGroupCalendar_PlayerSettings.Channel.Name then
			CalendarNetwork_SetChannel(
					gGroupCalendar_PlayerSettings.Channel.Name,
					gGroupCalendar_PlayerSettings.Channel.Password);
		else
			CalendarNetwork_SetChannelStatus("Disconnected");
			Calendar_DebugMessage("GroupCalendar channel is not set");
		end
	end

	Calendar_GetPrimaryTradeskills();
end

function CalendarNetwork_SendNotices()
	-- If trust isn't available yet just defer the notices
	
	if not CalendarTrust_TrustCheckingAvailable() then
		gGroupCalendar_SendNoticesOnRosterUpdate = true;
		return;
	end
	
	--
	
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("Sending notices");
	end

	CalendarNetwork_RequestAllDatabaseUpdates();

	-- Request databases for trusted players who haven't sent one yet

	if not gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		CalendarNetwork_RequestMissingDatabases();
	end

	-- Schedule a request to send out owned database notices in two minutes

	CalendarNetwork_QueueUniqueOpcodeRequest({mOpcode = "OWNEDNOTICES"}, gCalendarNetwork_RequestDelay.OwnedNotices);
end

function CalendarNetwork_RequestAllDatabaseUpdates()
	-- Immediately send a notice of our version
	
	CalendarNetwork_SendMessage(gGroupCalendar_MessagePrefix.."VER:"..gGroupCalendar_VersionString);
	
	-- Immediately request updates to our own databases
	
	for vRealmName, vDatabase in gGroupCalendar_Database.Databases do
		if EventDatabase_DatabaseIsVisible(vDatabase)
		and vDatabase.IsPlayerOwned then
			CalendarNetwork_RequestUpdate(vDatabase, vDatabase.Changes, "DB", true);
			CalendarNetwork_RequestUpdate(vDatabase, vDatabase.RSVPs, "RAT", true);
		end
	end
	
	-- Request updates to all other databases after a delay
	
	CalendarNetwork_QueueTask(CalendarNetwork_RequestExternalDatabaseUpdates, nil, gCalendarNetwork_RequestDelay.ExternalUpdateRequest, "EXTERNALUPDATE");
end

function CalendarNetwork_RequestExternalDatabaseUpdates()
	if gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		CalendarNetwork_RequestAllUpdate();

	elseif gGroupCalendar_PlayerSettings.Security.TrustGuildies
	and gGroupCalendar_PlayerGuild then
		CalendarNetwork_RequestGuildUpdate(gGroupCalendar_PlayerGuild, gGroupCalendar_PlayerSettings.Security.MinTrustedRank);
	end
	
	if not gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		for vRealmName, vDatabase in gGroupCalendar_Database.Databases do
			if EventDatabase_DatabaseIsVisible(vDatabase) then
				if not vDatabase.IsPlayerOwned
				and (not gGroupCalendar_PlayerSettings.Security.TrustGuildies
				or vDatabase.Guild ~= gGroupCalendar_PlayerGuild) then
					CalendarNetwork_RequestUpdate(vDatabase, vDatabase.Changes, "DB", false);
					CalendarNetwork_RequestUpdate(vDatabase, vDatabase.RSVPs, "RAT", false);
				end
			end
		end
	end
end

function CalendarNetwork_SendOwnedDatabaseUpdateNotices()
	for vRealmName, vDatabase in gGroupCalendar_Database.Databases do
		if EventDatabase_DatabaseIsVisible(vDatabase)
		and vDatabase.IsPlayerOwned then
			if not CalendarChanges_IsEmpty(vDatabase.Changes) then
				CalendarNetwork_DBRevisionChanged(vDatabase);
			end
			
			if not CalendarChanges_IsEmpty(vDatabase.RSVPs) then
				CalendarNetwork_RSVPRevisionChanged(vDatabase);
			end
		end
	end
end

gCalendarNetwork_GuildMemberRankCache = nil;

function CalendarNetwork_FlushCaches()
	gCalendarNetwork_GuildMemberRankCache = nil;
	gCalendarNetwork_UserTrustCache = {};
end

function CalendarNetwork_GetGuildRosterCache()
	if gCalendarNetwork_GuildMemberRankCache then
		return gCalendarNetwork_GuildMemberRankCache;
	end
	
	-- Clear the cache
	
	gCalendarNetwork_GuildMemberRankCache = {};
	
	-- Scan the roster and collect the info
	
	local		vNumGuildMembers = GetNumGuildMembers(true);
	
	for vIndex = 1, vNumGuildMembers do
		local	vName, vRank, vRankIndex, vLevel, vClass, vZone, vNote, vOfficerNote, vOnline = GetGuildRosterInfo(vIndex);
		
		if vName then -- Have to check for name in case a guild member gets booted while querying the roster
			local	vMemberInfo =
			{
				Name = vName,
				RankIndex = vRankIndex,
				Level = vLevel,
				Class = vClass,
				Zone = vZone,
				OfficerNote = vOfficerNote,
				Online = vOnline
			};
			
			gCalendarNetwork_GuildMemberRankCache[strupper(vName)] = vMemberInfo;
		end
	end
	
	-- Dump any cached trust info
	
	gCalendarNetwork_UserTrustCache = {};
	
	return gCalendarNetwork_GuildMemberRankCache;
end

local	gGroupCalendar_SentLoadGuildRoster = false;

function CalendarNetwork_LoadGuildRosterTask()
	if IsInGuild() then
		GuildRoster();
	end
	
	-- Schedule another task to load the roster again
	-- in four minutes
	
	CalendarNetwork_QueueTask(
			CalendarNetwork_LoadGuildRosterTask, nil,
			240, "GUILDROSTER");
end

function CalendarNetwork_LoadGuildRoster()
	if not IsInGuild()
	or GetNumGuildMembers() > 0
	or gGroupCalendar_SentLoadGuildRoster then
		return;
	end
	
	gGroupCalendar_SentLoadGuildRoster = true;
	
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("CalendarNetwork_LoadGuildRoster: Loading");
	end
	
	CalendarNetwork_LoadGuildRosterTask();
end

function CalendarNetwork_UserIsInSameGuild(pUserName)
	if not IsInGuild() then
		return false, nil;
	end
	
	-- Build the roster
	
	if GetNumGuildMembers() == 0 then
		CalendarNetwork_LoadGuildRoster();
		return false, nil; -- have to return false for now since we don't really know
	end
	
	-- Search for the member
	
	local		vUpperUserName = strupper(pUserName);
	local		vRosterCache = CalendarNetwork_GetGuildRosterCache();
	local		vMemberInfo = vRosterCache[vUpperUserName];
	
	if not vMemberInfo then
		return false, nil;
	end
	
	return true, vMemberInfo.RankIndex;
end

function CalendarNetwork_SendAllRevisionNotices()
	-- Use the same delay for all the requests so that the requests will all go out together
	-- once they start getting processed
	
	local	vDelay = gCalendarNetwork_RequestDelay.ProxyNOUMin + math.random() * gCalendarNetwork_RequestDelay.ProxyNOURange;
	local	vOwnedDelay = math.random() * gCalendarNetwork_RequestDelay.OwnedNOURange;
	
	for vRealmName, vDatabase in gGroupCalendar_Database.Databases do
		if EventDatabase_DatabaseIsVisible(vDatabase) then
			local		vRequest = {mOpcode = "DB_NOU", mUserName = vDatabase.UserName};
			
			if vDatabase.IsPlayerOwned then
				CalendarNetwork_QueueUniqueUserRequest(vRequest, vOwnedDelay);
			else
				CalendarNetwork_QueueUniqueUserRequest(vRequest, vDelay);
			end
			
			local		vRequest = {mOpcode = "RAT_NOU", mUserName = vDatabase.UserName};
			
			if vDatabase.IsPlayerOwned then
				CalendarNetwork_QueueUniqueUserRequest(vRequest, vOwnedDelay);
			else
				CalendarNetwork_QueueUniqueUserRequest(vRequest, vDelay);
			end
		end
	end
end

function CalendarNetwork_CancelRedundantUPDRequests(pChanges, pDatabaseTag, pUserName, pDatabaseID, pRevision, pSinceRevision)
	local	vOpcode = pDatabaseTag.."_UPD";
	
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		for vIndex, vRequest in vRequests do
			if vRequest.mOpcode == vOpcode
			and vRequest.mUserName == pUserName then
				-- Theirs is better if:
				--   - Their database ID is higher
				--   - Their database ID is the same and
				--         - Their fromRevision is lower or the same
				--         - Their toRevision is higher or the same
				
				if pDatabaseID > vRequest.mDatabaseID
				or (pDatabaseID == vRequest.mDatabaseID
				and pSinceRevision <= vRequest.mRevision
				and (not pChanges or pRevision  >= pChanges.Revision)) then
					if gGroupCalendar_Settings.DebugQueues then
						Calendar_DebugMessage("Removing UPD request for "..pDatabaseTag.." "..pUserName..","..pDatabaseID..","..pSinceRevision.." to "..pRevision);
					end
					
					table.remove(vRequests, vIndex);
				else
					if gGroupCalendar_Settings.DebugQueues then
						Calendar_DebugMessage("Keeping UPD request for "..pDatabaseTag.." "..pUserName..","..vRequest.mDatabaseID..","..vRequest.mRevision.." to "..pChanges.Revision);
						Calendar_DebugMessage("Better thean "..pDatabaseTag.." "..pUserName..","..pDatabaseID..","..pSinceRevision.." to "..pRevision);
					end
				end
				
				return;
			end
		end -- for vIndex
	end -- for vPriority
end

function CalendarNetwork_CancelRedundantNOURequests(pChanges, pDatabaseTag, pSender, pUserName, pDatabaseID, pRevision)
	local	vOpcode = pDatabaseTag.."_NOU";
	
	for vPriority, vRequests in gGroupCalendar_Queue.Requests do
		for vIndex, vRequest in vRequests do
			if vRequest.mOpcode == vOpcode
			and vRequest.mUserName == pUserName then
				-- Cancel our update if the revision they're advertising is equal
				-- to or better than ours or if they're the owner
				
				local		vTheirsIsBetter;
				
				if pSender == pUserName then
					vTheirsIsBetter = true;
				else
					vTheirsIsBetter = not pChanges
										or pDatabaseID > pChanges.ID
										or (pDatabaseID == pChanges.ID and pRevision >= pChanges.Revision);
				end
				
				if vTheirsIsBetter then
					if gGroupCalendar_Settings.DebugQueues then
						Calendar_DebugMessage("Removing NOU request for "..pDatabaseTag.." "..pUserName..","..pDatabaseID..","..pRevision);
					end
					
					table.remove(vRequests, vIndex);
				else
					if gGroupCalendar_Settings.DebugQueues then
						Calendar_DebugMessage("Keeping NOU request for "..pDatabaseTag.." "..pUserName..","..pChanges.ID..","..pChanges.Revision);
						Calendar_DebugMessage("Better than "..pDatabaseTag.." "..pUserName..","..pDatabaseID..","..pRevision);
					end
				end
				
				return;
			end
		end -- for vIndex
	end -- for vPriority
end

function CalendarNetwork_SendMessage(pMessage)
	-- Just leave if there's no channel to communicate on
	
	if not gGroupCalendar_Channel.ID then
		return;
	end
	
	local	vSavedAutoClearAFK = GetCVar("autoClearAFK");
	SetCVar("autoClearAFK", 0);
	
	SendChatMessage(Calendar_EscapeChatString(pMessage), "CHANNEL", nil, gGroupCalendar_Channel.ID);
	
	SetCVar("autoClearAFK", vSavedAutoClearAFK);
end

function CalendarNetwork_ChannelMessageReceived(pSender, pMessage)
	local	vTrustLevel = CalendarTrust_GetUserTrustLevel(pSender);
	
	if vTrustLevel  > 0 then
		CalendarNetwork_QueueInboundMessage(pSender, vTrustLevel, pMessage);
	else
		if gGroupCalendar_Settings.DebugTrust then
			Calendar_DebugMessage("ChannelMessageReceived: "..pSender.." is not trusted");
		end
	end
end

function CalendarNetwork_GetGuildMemberIndex(pPlayerName)
	local		vUpperUserName = strupper(pPlayerName);
	local		vNumGuildMembers = GetNumGuildMembers(true);
	
	for vIndex = 1, vNumGuildMembers do
		local	vName = GetGuildRosterInfo(vIndex);
		
		if strupper(vName) == vUpperUserName then
			return vIndex;
		end
	end
	
	return nil;
end

function CalendarNetwork_SetAutoConfigData(pPlayerName)
	if not CanEditPublicNote()
	or not gGroupCalendar_PlayerSettings.Channel.Name then
		return false;
	end
	
	local		vMemberIndex = CalendarNetwork_GetGuildMemberIndex(pPlayerName);
	
	if not vMemberIndex then
		return false;
	end
	
	CalendarNetwork_RemoveAllAutoConfigData(pPlayerName);
	
	local		vNote = "["..gGroupCalendar_MessagePrefix.."C:"..gGroupCalendar_PlayerSettings.Channel.Name;
	
	if gGroupCalendar_PlayerSettings.Channel.Password then
		vNote = vNote..","..gGroupCalendar_PlayerSettings.Channel.Password
	end
	
	-- Add the trust group
	
	local		vTrustGroup = CalendarTrust_GetCurrentTrustGroup();
	
	vNote = vNote.."/T:"..vTrustGroup;
	
	-- Add the trust rank
	
	if gGroupCalendar_PlayerSettings.Security.TrustGuildies
	and gGroupCalendar_PlayerSettings.Security.MinTrustedRank then
		vNote = vNote..","..gGroupCalendar_PlayerSettings.Security.MinTrustedRank;
	end
	
	vNote = vNote.."]";
	
	if gGroupCalendar_Settings.DebugConfig then
		Calendar_DebugMessage("Setting auto-config data on player "..pPlayerName);
	end
	
	GuildRosterSetPublicNote(vMemberIndex, vNote);
	
	return true;
end

function CalendarNetwork_RemoveAllAutoConfigData(pExcludePlayerName)
	-- Remove it from the GuildInfoText
	
	local	vGuildInfoText = GetGuildInfoText();
	local	vStartIndex, vEndIndex = string.find(vGuildInfoText, "%["..gGroupCalendar_MessagePrefix.."[^%]]+%]");
	
	if vStartIndex then
		vGuildInfoText = string.sub(vGuildInfoText, 1, vStartIndex - 1)..string.sub(vGuildInfoText, vEndIndex + 1);
		SetGuildInfoText(vGuildInfoText);
	end
	
	-- Remove it from player notes
	
	local	vIndex = CalendarNetwork_FindAutoConfigData(nil, pExcludePlayerName);
	
	while vIndex do
		CalendarNetwork_RemoveAutoConfigData(vIndex);
		vIndex = CalendarNetwork_FindAutoConfigData(vIndex + 1, pExcludePlayerName);
	end
end

function CalendarNetwork_RemoveAutoConfigData(pMemberIndex)
	if not pMemberIndex then
		Calendar_DebugMessage("CalendarNetwork_RemoveAutoConfigData: nil index");
		return;
	end
	
	local	vName, vNote = CalendarNetwork_GetGuildPublicNote(pMemberIndex);
	
	if not vNote then
		return false;
	end
	
	if gGroupCalendar_Settings.DebugConfig then
		Calendar_DebugMessage("Removing auto-config data from player "..vName);
	end
	
	local	vPatternString = "%["..gGroupCalendar_MessagePrefix0.."[^%]]+%]";
	
	vNote = string.gsub(vNote, vPatternString, "");
	
	GuildRosterSetPublicNote(pMemberIndex, vNote);
	
	return true;
end

function CalendarNetwork_GetGuildPublicNote(pMemberIndex)
	local	vName, vRank, vRankIndex, vLevel, vClass, vZone, vNote, vOfficerNote, vOnline = GetGuildRosterInfo(pMemberIndex);
	
	return vName, vNote;
end

function CalendarNetwork_GetAutoConfigData()
	local	vGuildInfoText = GetGuildInfoText();
	local	vConfigSource = GroupCalendar_cGuildInfoConfigSource;
	
	local	vStartIndex, vEndIndex, vConfigString = string.find(vGuildInfoText, "%[("..gGroupCalendar_MessagePrefix.."[^%]]+)%]");
	
	if not vStartIndex then
		local	vIndex = CalendarNetwork_FindAutoConfigData();
		
		if not vIndex then
			return nil;
		end
		
		local	vName, vNote = CalendarNetwork_GetGuildPublicNote(vIndex);
		
		if not vNote then
			return nil;
		end
		
		vStartIndex, vEndIndex, vConfigString = string.find(vNote, "%[("..gGroupCalendar_MessagePrefix.."[^%]]+)%]");
		
		if not vStartIndex then
			return nil;
		end
		
		vConfigSource = vName;
	end
	
	return CalendarNetwork_ParseCommandString(vConfigString), vConfigSource;
end

function CalendarNetwork_FindAutoConfigData(pStartingIndex, pExcludePlayerName)
	-- Build the roster
	
	if GetNumGuildMembers() == 0 then
		CalendarNetwork_LoadGuildRoster();
		return nil;
	end
	
	-- Search for the member
	
	local		vNumGuildMembers = GetNumGuildMembers(true);
	local		vStartingIndex;
	
	if pStartingIndex then
		vStartingIndex = pStartingIndex;
	else
		vStartingIndex = 1;
	end
	
	for vIndex = vStartingIndex, vNumGuildMembers do
		local	vName, vNote = CalendarNetwork_GetGuildPublicNote(vIndex);
		
		if vNote
		and (not pExcludePlayerName or string.lower(vName) ~= string.lower(pExcludePlayerName))
		and strfind(vNote, "%["..gGroupCalendar_MessagePrefix0) then
			if gGroupCalendar_Settings.DebugConfig then
				Calendar_DebugMessage("Found auto-config data on player "..vName);
			end
			
			return vIndex, vName;
		end
	end
	
	return nil;
end

function CalendarNetwork_ScheduleCheckDatabaseTrust(pDelay)
	CalendarNetwork_QueueUniqueOpcodeRequest({mOpcode = "DBTRUST"}, pDelay);
end

function CalendarNetwork_ScheduleAutoConfig(pDelay, pCheckDatabaseTrust)
	if gGroupCalendar_Channel.Disconnected then
		return;
	end
	
	local	vRequest = CalendarNetwork_FindRequest({mOpcode = "AUTOCONFIG"});
	
	if vRequest then
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("CalendarNetwork_ScheduleAutoConfig: Rescheduling existing request");
		end
		
		if pDelay < vRequest.mDelay then
			vRequest.mDelay = pDelay;
		end
		
		if pCheckDatabaseTrust then
			vRequest.mCheckDatabaseTrust = true;
		end
	else
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("CalendarNetwork_ScheduleAutoConfig: Scheduling request");
		end
		
		CalendarNetwork_QueueRequest({mOpcode = "AUTOCONFIG", mCheckDatabaseTrust = pCheckDatabaseTrust}, pDelay);
	end
end

function CalendarNetwork_DoAutoConfig(pCheckDatabaseTrust)
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("CalendarNetwork_DoAutoConfig: Performing auto-config");
	end
	
	local	vCommand, vConfigSource = CalendarNetwork_GetAutoConfigData();
	
	if not vCommand then
		CalendarNetwork_SetChannelStatus("Error", GroupCalendar_cAutoConfigNotFound);
		return false;
	end
	
	local		vChannel = nil;
	local		vPassword = nil;
	local		vMinTrustedRank = nil;
	local		vTrustGroup = nil;
	
	while vCommand[1] ~= nil do
		local	vOpcode = vCommand[1].opcode;
		local	vOperands = vCommand[1].operands;
		
		table.remove(vCommand, 1);
		
		if vOpcode == "CHN"
		or vOpcode == "C" then
			vChannel = vOperands[1];
			vPassword = vOperands[2];
			
		elseif vOpcode == "RNK" then
			vMinTrustedRank = tonumber(vOperands[1]);
		elseif vOpcode == "T" then
			vTrustGroup = tonumber(vOperands[1]);
			vMinTrustedRank = tonumber(vOperands[2]);
		end
	end
	
	local	vAutoPlayerChanged = gGroupCalendar_Channel.AutoPlayer ~= vConfigSource;
	
	gGroupCalendar_Channel.AutoPlayer = vConfigSource;
	
	if vAutoPlayerChanged then
		GroupCalendar_ChannelChanged(); -- Send out a change notice just so the calendar knows the player changed
	end
	
	CalendarNetwork_SetChannel(vChannel, vPassword);
	
	-- Update the trust settings
	
	local	vTrustChanged = false;
	local	vCurrentTrustGroup = CalendarTrust_GetCurrentTrustGroup();
	
	if vTrustGroup ~= nil then
		if vCurrentTrustGroup ~= vTrustGroup then
			vTrustChanged = true;
		end
	else
		vTrustGroup = vCurrentTrustGroup;
	end
	
	if vMinTrustedRank ~= nil then
		if gGroupCalendar_PlayerSettings.Security.MinTrustedRank ~= vMinTrustedRank then
			vTrustChanged = true;
		end
	else
		vMinTrustedRank = gGroupCalendar_PlayerSettings.Security.MinTrustedRank;
	end
	
	if vTrustChanged then
		CalendarTrust_SetCurrentTrustGroup(vTrustGroup, vMinTrustedRank);
	elseif pCheckDatabaseTrust then
		EventDatabase_CheckDatabaseTrust();
	end
	
	return true;
end

function CalendarTrust_GetCurrentTrustGroup()
	if gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		return 2;
	elseif gGroupCalendar_PlayerSettings.Security.TrustGuildies then
		return 1;
	else
		return 0;
	end
end

function CalendarTrust_SetCurrentTrustGroup(pTrustGroup, pMinRank)
	if pTrustGroup == 2 then
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = true;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
	elseif pTrustGroup == 1 then
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = true;
	else
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
	end
	
	gGroupCalendar_PlayerSettings.Security.MinTrustedRank =  pMinRank;
	
	CalendarTrust_TrustSettingsChanged();
end

function CalendarTrust_TrustSettingsChanged()
	CalendarNetwork_FlushCaches();
	
	EventDatabase_CheckDatabaseTrust(); -- Delete databases owned by players we no longer trust
	CalendarNetwork_RequestMissingDatabases(); -- Request databases for newly trusted players
	
	if gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		CalendarNetwork_RequestAllUpdate();
	else
		if gGroupCalendar_PlayerSettings.Security.TrustGuildies
		and gGroupCalendar_PlayerGuild then
			CalendarNetwork_RequestGuildUpdate(gGroupCalendar_PlayerGuild, gGroupCalendar_PlayerSettings.Security.MinTrustedRank);
		end
	end
	
	CalendarNetwork_SendAllRevisionNotices(); -- Send out revision notices since trusted players may want to know now
end

function CalendarTrust_TrustCheckingAvailable()
	if not gGroupCalendar_PlayerSettings.Security.TrustGuildies then
		return true;
	end
	
	-- Doesn't matter if they're not in a guild
	
	if not IsInGuild() then
		return true;
	end

	-- If trust is guild members only then verify that the roster has been loaded
	
	return GetNumGuildMembers() > 0;
end

function CalendarTrust_GetUserTrustLevel(pUserName)
	local	vUserTrustInfo = gCalendarNetwork_UserTrustCache[pUserName];
	
	if not vUserTrustInfo then
		vUserTrustInfo = {};
		vUserTrustInfo.mTrustLevel = CalendarTrust_CalcUserTrust(pUserName);
		gCalendarNetwork_UserTrustCache[pUserName] = vUserTrustInfo;
	end
	
	return vUserTrustInfo.mTrustLevel;
end

function CalendarTrust_UserIsTrusted(pUserName)
	return CalendarTrust_GetUserTrustLevel(pUserName) == 2;
end

function CalendarTrust_UserIsTrustedForRSVPs(pUserName)
	return CalendarTrust_GetUserTrustLevel(pUserName) >= 1;
end

function CalendarTrust_CalcUserTrust(pUserName)
	-- If the user is one of our own characters, then trust them completely
	
	local	vDatabase = EventDatabase_GetDatabase(pUserName, false);
	
	if vDatabase
	and vDatabase.IsPlayerOwned then
		if gGroupCalendar_Settings.DebugTrust then
			Calendar_DebugMessage("CalendarTrust_CalcUserTrust: Implicit trust for "..pUserName);
		end
		
		return 2;
	end

	local	vPlayerSecurity = gGroupCalendar_PlayerSettings.Security.Player[pUserName];
	
	-- See if they're explicity allowed/forbidden
	
	if vPlayerSecurity ~= nil then
		if vPlayerSecurity == 1 then
			-- Trusted
			
			if gGroupCalendar_Settings.DebugTrust then
				Calendar_DebugMessage("CalendarTrust_CalcUserTrust: Explicit trust for "..pUserName);
			end
			
			return 2;
		elseif vPlayerSecurity == 2 then
			-- Excluded
			
			if gGroupCalendar_Settings.DebugTrust then
				Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." explicity excluded");
			end
			
			return 0;
		else
			Calendar_DebugMessage("GroupCalendar: Unknown player security setting of "..vPlayerSecurity.." for "..pUserName);
		end
	end
	
	-- Return true if we'll allow anyone in the channel
	
	if gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		if gGroupCalendar_Settings.DebugTrust then
			Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." trusted (all trusted)");
		end
		
		return 2;
	end
	
	-- Return true if they're in the same guild and of sufficient rank
	
	if gGroupCalendar_PlayerSettings.Security.TrustGuildies then
		local	vIsInGuild, vGuildRank = CalendarNetwork_UserIsInSameGuild(pUserName);
		
		if vIsInGuild then
			if not gGroupCalendar_PlayerSettings.Security.MinTrustedRank
			or vGuildRank <= gGroupCalendar_PlayerSettings.Security.MinTrustedRank then
				if gGroupCalendar_Settings.DebugTrust then
					Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." trusted (guild member)");
				end
				
				return 2;
			else
				if gGroupCalendar_Settings.DebugTrust then
					Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." partially trusted (guild member)");
				end
				
				return 1;
			end
		end
	end
	
	-- Failed all tests
		
	if gGroupCalendar_Settings.DebugTrust then
		Calendar_DebugMessage("CalendarTrust_CalcUserTrust: "..pUserName.." not trusted (all tests failed)");
	end
	
	return 0;
end

function CalendarTrust_GetNumTrustedPlayers(pTrustSetting)
	local	vNumPlayers = 0;
	
	for vPlayerName, vPlayerSecurity in gGroupCalendar_PlayerSettings.Security.Player do
		if vPlayerSecurity == pTrustSetting then
			vNumPlayers = vNumPlayers + 1;
		end
	end
	
	return vNumPlayers;
end

function CalendarTrust_GetIndexedTrustedPlayers(pTrustSetting, pIndex)
	local	vPlayerIndex = 1;
	
	for vPlayerName, vPlayerSecurity in gGroupCalendar_PlayerSettings.Security.Player do
		if vPlayerSecurity == pTrustSetting then
			if vPlayerIndex == pIndex then
				return vPlayerName;
			end
			
			vPlayerIndex = vPlayerIndex + 1;
		end
	end
	
	return nil;
end

function CalendarNetwork_RequestMissingDatabases()
	-- For each player we explicitly trust, see if there's a database for
	-- them yet.  If not, request one
	
	for vPlayerName, vPlayerSecurity in gGroupCalendar_PlayerSettings.Security.Player do
		if vPlayerSecurity == 1 then
			-- Found a trusted player, see if they have a database
			
			local	vDatabase = EventDatabase_GetDatabase(vPlayerName, false);
			
			if not vDatabase then
				CalendarNetwork_QueueRFURequest(vPlayerName, "DB", 0, 0);
				CalendarNetwork_QueueRFURequest(vPlayerName, "RAT", 0, 0);
			end
		end
	end
	
	return nil;
end

function CalendarNetwork_QueueRFURequest(pUserName, pDatabaseTag, pDatabaseID, pRevision)
	if CalendarNetwork_CancelRedundantRFURequest(pDatabaseTag, pUserName, pDatabaseID, pRevision) then
		return;
	end
	
	local	vRequest =
	{
		mOpcode = pDatabaseTag.."_RFU",
		mUserName = pUserName,
		mDatabaseID = pDatabaseID,
		mRevision = pRevision,
	}
	
	CalendarNetwork_QueueRequest(vRequest, gCalendarNetwork_RequestDelay.RFUMin + math.random() * gCalendarNetwork_RequestDelay.RFURange);
end

function CalendarNetwork_PlayerGuildChanged()
	-- Update the guild in the database
	
	if gGroupCalendar_UserDatabase then
		gGroupCalendar_UserDatabase.Guild = gGroupCalendar_PlayerGuild;
	end
	
	-- Just return if we're not initialized yet
	
	if not gGroupCalendar_Initialized then
		EventDatabase_UpdateGuildRankCache();
		return;
	end
	
	-- Clear the roster load flag
	
	gGroupCalendar_SentLoadGuildRoster = false;
	
	CalendarNetwork_FlushCaches();
	
	-- If the player is unguilded then simply leave the data
	-- channel if it was auto-configured, flush any databases
	-- which are no longer trusted and exit
	
	if not IsInGuild() then
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("PlayerGuildChanged: Player is now unguilded");
		end
		
		if gGroupCalendar_PlayerSettings.Channel.AutoConfig then
			CalendarNetwork_LeaveChannel();
		end
		
		EventDatabase_CheckDatabaseTrust();
		
		return;
	end
	
	-- The player is in a new guild or has changed guilds, so
	-- schedule a roster update if necessary
	
	if GetNumGuildMembers() > 0 then
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("PlayerGuildChanged: Roster is already loaded, calling GuildRosterChanged()");
		end
		
		CalendarNetwork_GuildRosterChanged();
	end
	
	-- Force the roster to reload or to start loading
	
	CalendarNetwork_LoadGuildRosterTask();
end

function CalendarNetwork_GuildRosterChanged()
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("CalendarNetwork_GuildRosterChanged: Checking changes");
	end
	
	EventDatabase_UpdateGuildRankCache();
	
	CalendarNetwork_FlushCaches();

	if gGroupCalendar_PlayerSettings.Channel.AutoConfig then
		CalendarNetwork_ScheduleAutoConfig(gCalendarNetwork_RequestDelay.GuildUpdateAutoConfig, true);
	else
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("PlayerGuildChanged: Channel is set for manual config, verifying database trust");
		end
		
		CalendarNetwork_ScheduleCheckDatabaseTrust(5);
	end
	
	-- Start sending notices now if we were waiting for a roster update
	
	if gGroupCalendar_SendNoticesOnRosterUpdate then
		gGroupCalendar_SendNoticesOnRosterUpdate = nil;
		CalendarNetwork_SendNotices();
	end
end

function CalendarNetwork_CheckPlayerGuild()
	local	vPlayerGuild;

	if IsInGuild() then
		vPlayerGuild, _, gGroupCalendar_PlayerGuildRank = GetGuildInfo("player");
		
		-- Just return if the server is lagging and the guild info
		-- isn't available yet
		
		if not vPlayerGuild then
			return;
		end
	else
		vPlayerGuild = nil;
		gGroupCalendar_PlayerGuildRank = nil;
	end

	if gGroupCalendar_PlayerGuild ~= vPlayerGuild then
		gGroupCalendar_PlayerGuild = vPlayerGuild;
		
		CalendarNetwork_PlayerGuildChanged();
	end
end

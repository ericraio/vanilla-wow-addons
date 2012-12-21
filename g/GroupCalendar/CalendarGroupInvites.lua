gGroupCalendar_Invites =
{
	Event = nil,
	Status = nil,
	Group = nil,
	Inviting = false,
	ChangedFunc = nil,
	ChangedFuncParam = nil,
	GroupChanged = false,
	NextInviteDelay = 0,
	MaxInvitesPerTimeSlice = 1,
	InvitationSliceInterval = 0.2,
};

GroupCalendar_cInviteStatusMessages =
{
	NeedSelection = GroupCalendar_cInviteNeedSelectionStatus,
	Ready = GroupCalendar_cInviteReadyStatus,
	InitialInvites = GroupCalendar_cInviteInitialInvitesStatus,
	AwaitingAcceptance = GroupCalendar_cInviteAwaitingAcceptanceStatus,
	ConvertingToRaid = GroupCalendar_cInviteConvertingToRaidStatus,
	Inviting = GroupCalendar_cInviteInvitingStatus,
	Complete = GroupCalendar_cInviteCompleteStatus,
	ReadyToRefill = GroupCalendar_cInviteReadyToRefillStatus,
-- The "no more available" message is kind of useless, so for now
-- I'm just showing it as completed instead until I figure out a 
-- better use for that state
	NoMoreAvailable = GroupCalendar_cInviteNoMoreAvailableStatus,
--	NoMoreAvailable = GroupCalendar_cInviteCompleteStatus,
	RaidFull = GroupCalendar_cRaidFull,
};

function CalendarGroupInvites_BeginEvent(pDatabase, pEvent)
	-- Just return if it's still the same event
	
	if pEvent == gGroupCalendar_Invites.Event then
		return;
	end
	
	gGroupCalendar_Invites.Database = pDatabase;
	gGroupCalendar_Invites.Event = pEvent;
	gGroupCalendar_Invites.Limits = pEvent.mLimits;
	
	if not gGroupCalendar_Invites.Limits then
		gGroupCalendar_Invites.Limits = EventDatabase_GetStandardLimitsByID(pEvent.mType);
	end
	
	if gGroupCalendar_Invites.Limits
	and not gGroupCalendar_Invites.Limits.mPriorityOrder then
		gGroupCalendar_Invites.Limits.mPriorityOrder = gGroupCalendar_PlayerSettings.AutoSelectPriorityOrder;
	end
	
	gGroupCalendar_Invites.Group = CalendarAttendanceList_New();
	gGroupCalendar_Invites.Group.NumJoinedMembers = 0;
	gGroupCalendar_Invites.Group.NumJoinedOrInvited = 0;
	
	gGroupCalendar_Invites.GroupChanged = true;
	gGroupCalendar_Invites.SortBy = "Date";

	CalendarGroupInvites_UpdateGroup(gGroupCalendar_Invites.Group);
	
	-- Determine the status
	
	local	vEventMaximumAttendance = CalendarGroupInvites_GetEventMaxAttendance(pEvent);
	
	if gGroupCalendar_Invites.Group.NumJoinedOrInvited >= vEventMaximumAttendance then
		CalendarGroupInvites_SetStatus("Complete");
	else
		CalendarGroupInvites_SetReadyStatus();
	end
	
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_EndEvent(pEvent)
	if pEvent ~= gGroupCalendar_Invites.Event then
		return;
	end
	
	CalendarGroupInvites_SetChangedFunc(nil, nil);
	
	gGroupCalendar_Invites.Event = nil;
	gGroupCalendar_Invites.Status = nil;
	gGroupCalendar_Invites.Group = nil;
end

function CalendarGroupInvites_SetChangedFunc(pChangedFunc, pChangedFuncParam)
	gGroupCalendar_Invites.ChangedFunc = pChangedFunc;
	gGroupCalendar_Invites.ChangedFuncParam = pChangedFuncParam;
end

function CalendarGroupInvites_EventChanged(pEvent)
	if pEvent ~= gGroupCalendar_Invites.Event then
		return;
	end
	
	CalendarGroupInvites_UpdateGroup(gGroupCalendar_Invites.Group);
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_SetReadyStatus()
	if CalendarGroupInvites_HasSelection() then
		CalendarGroupInvites_SetStatus("Ready");
	else
		CalendarGroupInvites_SetStatus("NeedSelection");
	end
end

function CalendarGroupInvites_SetStatus(pStatus)
	gGroupCalendar_Invites.Status = pStatus;
	gGroupCalendar_Invites.GroupChanged = true;
end

function CalendarGroupInvites_NotifyGroupChanged()
	if gGroupCalendar_Invites.GroupChanged then
		if gGroupCalendar_Invites.ChangedFunc then
			gGroupCalendar_Invites.ChangedFunc(gGroupCalendar_Invites.ChangedFuncParam);
		end
		
		gGroupCalendar_Invites.GroupChanged = false;
	end
end

function CalendarGroupInvites_GetUpdateDelay()
end

function CalendarGroupInvites_NeedsUpdateTimer()
	return gGroupCalendar_Invites.Inviting;
end

function CalendarGroupInvites_Update(pElapsed)
	if not gGroupCalendar_Invites.Inviting then
		return;
	end
	
	gGroupCalendar_Invites.NextInviteDelay = gGroupCalendar_Invites.NextInviteDelay - pElapsed;
	
	if gGroupCalendar_Invites.NextInviteDelay <= 0 then
		CalendarGroupInvites_InviteNow();
		gGroupCalendar_Invites.NextInviteDelay = gGroupCalendar_Invites.InvitationSliceInterval;
	end
end

function CalendarGroupInvites_PartyMembersChanged()
	if not gGroupCalendar_Invites.Event then
		return;
	end

	CalendarGroupInvites_UpdateGroup(gGroupCalendar_Invites.Group);
	
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_PartyLootMethodChanged()
	gGroupCalendar_Invites.PartyFormed = true;
end

function CalendarGroupInvites_SystemMessage(pMessage)
	-- See if someone declined an invitation
	
	local	vStartIndex, vEndIndex, vName = string.find(pMessage, GroupCalendar_cInviteDeclinedSysMsg);
	
	if vStartIndex then
		CalendarGroupInvites_PlayerDeclinedInvitation(vName);
		return;
	end
	
	-- See if they are already in a group
	
	vStartIndex, vEndIndex, vName = string.find(pMessage, GroupCalendar_cAlreadyGroupedSysMsg);
	
	if vStartIndex then
		CalendarGroupInvites_PlayerAlreadyGrouped(vName);
		return;
	end
	
	-- See if they're not online
	
	vStartIndex, vEndIndex, vName = string.find(pMessage, GroupCalendar_cNoSuchPlayerSysMsg);
	
	if vStartIndex then
		CalendarGroupInvites_NoSuchPlayer(vName);
		return;
	end
end

function CalendarGroupInvites_GuildRosterChanged()
	if gGroupCalendar_Invites.Group then
		CalendarGroupInvites_UpdateGroup(gGroupCalendar_Invites.Group);
	end
end

function CalendarGroupInvites_UpdateGroup(pGroup)
	-- Add the attendance info
	
	CalendarGroupInvites_MergeEventAttendance(pGroup, gGroupCalendar_Invites.Event, true);
	
	-- First mark all the joined members as "Left"  and
	-- count the invited members. Also check their offline
	-- status using the guild roster
	
	local	vGuildRoster = CalendarNetwork_GetGuildRosterCache();
	
	for vIndex, vPlayer in pGroup.Items do
		if vPlayer.mGroupStatus == "Joined" then
			vPlayer.mGroupStatus = "Left";
		end
		
		if vGuildRoster then
			local	vUpperName = strupper(vPlayer.mName);
			local	vMemberInfo = vGuildRoster[vUpperName];
			
			if vMemberInfo then
				vPlayer.mOffline = not vMemberInfo.Online;
			end
		end
	end
	
	-- Now scan the group and update everyone who's in
	
	local	vNumRaidMembers = GetNumRaidMembers();
	
	if vNumRaidMembers > 0 then
		for vIndex = 1, vNumRaidMembers do
			local	vName, vRank, vSubgroup, vLevel, vClass, vFileName, vZone, vOnline, vIsDead = GetRaidRosterInfo(vIndex);
			
			if vName then
				local	vClassCode = EventDatabase_GetClassCodeByClass(vClass);
				local	vPlayer = pGroup.Items[vName];
				
				if vPlayer then
					vPlayer.mRaidRank = vRank;
					vPlayer.mZone = vZone;
					vPlayer.mOffline = not vOnline;
					vPlayer.mDead = vIsDead;
					vPlayer.mGroupStatus = "Joined";
					vPlayer.mSelected = nil; -- Deselect players as they join the group
				else
					vPlayer = 
					{
						mType = "Player",
						mName = vName,
						mRaidRank = vRank,
						mGroupNumber = vSubGroup,
						mLevel = vLevel,
						mClassCode = vClassCode,
						mZone = vZone,
						mOffline = not vOnline,
						mDead = vIsDead,
						mGroupStatus = "Joined",
					};
					
					pGroup.Items[vName] = vPlayer;
				end
			end
		end
	else
		for vIndex = 0, MAX_PARTY_MEMBERS do
			local	vUnitID = nil;
			
			if vIndex == 0 then
				vUnitID = "player";
			elseif GetPartyMember(vIndex) then
				vUnitID = "party"..vIndex;
			else
				vUnitID = nil;
			end
			
			if vUnitID then
				local	vName = UnitName(vUnitID);
				
				-- Map the party info to a raid rank
				
				local	vRank = 0;
				
				if GetNumPartyMembers() == 0
				or UnitIsPartyLeader(vUnitID) then
					vRank = 2;
				end
				
				--
				
				local	vClassCode = EventDatabase_GetClassCodeByClass(UnitClass(vUnitID));
				local	vPlayer = pGroup.Items[vName];
				
				if vPlayer then
					vPlayer.mRaidRank = vRank;
					vPlayer.mOffline = not UnitIsConnected(vUnitID);
					vPlayer.mDead = UnitIsDeadOrGhost(vUnitID);
					vPlayer.mGroupStatus = "Joined";
					vPlayer.mSelected = nil; -- Deselect players as they join the group
				else
					vPlayer =
					{
						mType = "Player",
						mName = vName,
						mRaidRank = vRank,
						mGroupNumber = 1,
						mLevel = UnitLevel(vUnitID),
						mClassCode = vClassCode,
						--mZone = vZone,
						mOffline = not UnitIsConnected(vUnitID),
						mDead = UnitIsDeadOrGhost(vUnitID),
						mGroupStatus = "Joined",
					};
					
					pGroup.Items[vName] = vPlayer;
				end
			end
		end
	end
	
	-- 
	
	CalendarGroupInvites_SelectionChanged();
	gGroupCalendar_Invites.GroupChanged = true;
end

function CalendarGroupInvites_SetSortMode(pSortBy)
	gGroupCalendar_Invites.SortBy = pSortBy;
	
	if gGroupCalendar_Invites.Group then
		CalendarGroupInvites_SortGroup(gGroupCalendar_Invites.Group);
		CalendarGroupInvites_NotifyGroupChanged();
	end
end

function CalendarGroupInvites_EventChanged(pDatabase, pEvent)
	if gGroupCalendar_Invites.Event ~= pEvent
	or not gGroupCalendar_Invites.Group then
		return;
	end
	
	CalendarGroupInvites_UpdateGroup(gGroupCalendar_Invites.Group);
end

function CalendarGroupInvites_GetGroupItemCategory(pItem)
	if pItem.mStatus == "Y"
	or pItem.mGroupStatus == "Joined"
	or pItem.mGroupStatus == "Left"
	or pItem.mSelected then
		if pItem.mClassCode then
			return pItem.mClassCode;
		else
			return "?";
		end
	end

	return CalendarAttendanceList_GetRSVPClassCategory(pItem);
end

function CalendarGroupInvites_SortGroup(pGroup)
	-- Sort into categories
	
	local	vNumAttendees = pGroup.NumAttendees;
	CalendarAttendanceList_SortIntoCategories(pGroup, CalendarGroupInvites_GetGroupItemCategory);
	pGroup.NumAttendees = vNumAttendees;
	
	-- Sort the categories
	
	table.sort(pGroup.SortedCategories, EventDatabase_CompareClassCodes);
	
	-- Sort the attendance within each category
	
	for vCategory, vClassInfo in pGroup.Categories do
		table.sort(vClassInfo.mAttendees, CalendarGroupInvites_GetGroupItemCompare(gGroupCalendar_Invites.SortBy));
	end

	gGroupCalendar_Invites.GroupChanged = true;
end

GroupCalendar_cGroupStatusOrder =
{
	Joined = 1,
	Invited = 2,
	Ready = 3,
	Grouped = 4,
	Standby = 5,
	Declined = 6,
	Offline = 7,
	Left = 8,
};

GroupCalendar_cGroupStatusMessages =
{
	Joined = GroupCalendar_cJoinedGroupStatus,
	Invited = GropuCalendar_cInvitedGroupStatus,
	Ready = GropuCalendar_cReadyGroupStatus,
	Grouped = GroupCalendar_cGroupedGroupStatus,
	Standby = GroupCalendar_cStandbyGroupStatus,
	Declined = GroupCalendar_cDeclinedGroupStatus,
	Offline = GroupCalendar_cOfflineGroupStatus,
	Left = GroupCalendar_cLeftGroupStatus,
};

GroupCalendar_cRSVPStatusToGroupStatus = 
{
	Y = "Ready",
	S = "Standby",
};

function CalendarGroupInvites_CompareGroupItems(pItem1, pItem2, pSecondaryCompareFunc)
	if not pItem1 then
		if not pItem2 then
			Calendar_ErrorMessage("CalendarGroupInvites_CompareGroupItems: pItem1 is nil");
		else
			Calendar_ErrorMessage("CalendarGroupInvites_CompareGroupItems: pItem2 is nil");
		end
		
		return false;
	end
	
	if not pItem2 then
		Calendar_ErrorMessage("CalendarGroupInvites_CompareGroupItems: pItem2 is nil");
		return true;
	end
	
	-- Compare by status first
	
	local	vOrder1 = GroupCalendar_cGroupStatusOrder[pItem1.mGroupStatus];
	local	vOrder2 = GroupCalendar_cGroupStatusOrder[pItem2.mGroupStatus];
	
	if not vOrder1 then
		Calendar_ErrorMessage("CalendarGroupInvites_CompareGroupItems: pItem1: Unknown status "..pItem1.mGroupStatus);
		
		if not vOrder2 then
			Calendar_ErrorMessage("CalendarGroupInvites_CompareGroupItems: pItem2: Unknown status "..pItem2.mGroupStatus);
		end
		
		return false;
	end
	
	if not vOrder2 then
		Calendar_ErrorMessage("CalendarGroupInvites_CompareGroupItems: pItem2: Unknown status "..pItem2.mGroupStatus);
		return true;
	end
	
	if vOrder1 ~= vOrder2 then
		return vOrder1 < vOrder2;
	end
	
	-- Use the secondary comparison
	
	return pSecondaryCompareFunc(pItem1, pItem2);
end

function CalendarGroupInvites_CompareGroupItemsByRank(pItem1, pItem2)
	return CalendarGroupInvites_CompareGroupItems(pItem1, pItem2, EventDatabase_CompareRSVPsByRankAndDate);
end

function CalendarGroupInvites_CompareGroupItemsByDate(pItem1, pItem2)
	return CalendarGroupInvites_CompareGroupItems(pItem1, pItem2, EventDatabase_CompareRSVPsByDate);
end

function CalendarGroupInvites_CompareGroupItemsByName(pItem1, pItem2)
	return CalendarGroupInvites_CompareGroupItems(pItem1, pItem2, EventDatabase_CompareRSVPsByName);
end

function CalendarGroupInvites_GetGroupItemCompare(pSortBy)
	if pSortBy == "Rank" then
		return CalendarGroupInvites_CompareGroupItemsByRank;
	elseif pSortBy == "Date" then
		return CalendarGroupInvites_CompareGroupItemsByDate;
	elseif pSortBy == "Name" then
		return CalendarGroupInvites_CompareGroupItemsByName;
	else
		Calendar_ErrorMessage("GroupCalendar: Unknown sorting method in CalendarGroupInvites_GetGroupItemCompare");
	end
end

function CalendarGroupInvites_ComparePlayerItemsByDate(pPlayer1, pPlayer2)
	if not pPlayer1.mDate then
		return false;
	elseif not pPlayer2.mDate then
		return true;
	end
	
	if pPlayer1.mDate < pPlayer2.mDate then
		return true;
	elseif pPlayer1.mDate > pPlayer2.mDate then
		return false;
	elseif pPlayer1.mTime ~= pPlayer2.mTime then
		return pPlayer1.mTime < pPlayer2.mTime;
	else
		return pPlayer1.mName < pPlayer2.mName;
	end
end

function CalendarGroupInvites_GetEventMaxAttendance(pEvent)
	if not pEvent.mLimits
	or not pEvent.mLimits.mMaxAttendance then
		return MAX_RAID_MEMBERS;
	end
		
	return pEvent.mLimits.mMaxAttendance;
end

function CalendarGroupInvites_GetNextInvitee(pGroup)
	for vCategory, vCategoryInfo in pGroup.Categories do
		for vIndex, vPlayer in vCategoryInfo.mAttendees do
			if vPlayer.mNeedsInvite then
				return vPlayer;
			end
		end
	end
	
	return nil;
end

function CalendarGroupInvites_InviteNow()
	if not gGroupCalendar_Invites.Event then
		if gGroupCalendar_Settings.DebugInvites then
			Calendar_DebugMessage("Skipping invites: no event associated");
		end
		
		gGroupCalendar_Invites.Inviting = false;
		return;
	end
	
	-- Get the maximum size for the group
	
	local	vMaxPartyMembers;
	
	CalendarGroupInvites_SetStatus("Inviting");
	
	if GetNumRaidMembers() == 0 then
		vMaxPartyMembers = MAX_PARTY_MEMBERS + 1; -- +1 because Blizzard doesn't include the player in the MAX_PARTY_MEMBERS count
	else
		vMaxPartyMembers = MAX_RAID_MEMBERS;
	end
	
	--
	
	if gGroupCalendar_Settings.DebugInvites then
		Calendar_DebugMessage("Starting invites: MaxPartyMembers: "..vMaxPartyMembers);
	end
	
	-- Count the number of outstanding invitations
	
	local	vNumInvitesSent = 0;
	
	for vExcessLooping = 1, 40 do
		-- Don't allow too many invitations in one burst in order to prevent
		-- Blizzard's spammer filters from kicking us offline
		
		if vNumInvitesSent >= gGroupCalendar_Invites.MaxInvitesPerTimeSlice then
			if gGroupCalendar_Settings.DebugInvites then
				Calendar_DebugMessage("Maximum invites per time slice reached");
			end
			
			return;
		end
		
		if gGroupCalendar_Settings.DebugInvites then
			Calendar_DebugMessage("NumJoinedOrInvited: "..gGroupCalendar_Invites.Group.NumJoinedOrInvited);
		end
		
		-- Get the next player to invite
		
		local	vPlayer = CalendarGroupInvites_GetNextInvitee(gGroupCalendar_Invites.Group);
		
		-- Done if there are no more players to add
		
		if not vPlayer then
			CalendarGroupInvites_SetStatus("Complete");
			gGroupCalendar_Invites.Inviting = false;
			
			if gGroupCalendar_Settings.DebugInvites then
				Calendar_DebugMessage("No more players to invite");
			end
			
			return;
		end
		
		-- See if there's room for more
		
		if gGroupCalendar_Invites.Group.NumJoinedOrInvited >= vMaxPartyMembers then
			if GetNumRaidMembers() == 0 then
				-- Convert to a raid
				
				if gGroupCalendar_Invites.Group.NumJoinedMembers > 1
				and gGroupCalendar_Invites.PartyFormed then
					CalendarGroupInvites_SetStatus("ConvertingToRaid");
					
					if gGroupCalendar_Settings.DebugInvites then
						Calendar_DebugMessage("Converting to raid");
					end
					
					ConvertToRaid();
				
				-- Wait for at least one player to accept
				
				else
					CalendarGroupInvites_SetStatus("AwaitingAcceptance");
					if gGroupCalendar_Settings.DebugInvites then
						Calendar_DebugMessage("Waiting for players to accept");
					end
				end
			
			-- This state is only reached if the raid is full and the player
			-- tries to invite more
			
			else
				CalendarGroupInvites_SetStatus("RaidFull");
				gGroupCalendar_Invites.Inviting = false;
			end
			
			return;
		end
		
		-- Invite the player
		
		if gGroupCalendar_Settings.DebugInvites then
			Calendar_DebugMessage("Inviting "..vPlayer.mName);
		end
		
		SendChatMessage(
				format(GroupCalendar_cInviteWhisperFormat, EventDatabase_GetEventDisplayName(gGroupCalendar_Invites.Event)),
				"WHISPER",
				nil,
				vPlayer.mName);
		
		InviteByName(vPlayer.mName);
		
		vPlayer.mGroupStatus = "Invited";
		vPlayer.mNeedsInvite = nil;
		
		vNumInvitesSent = vNumInvitesSent + 1;
		
		gGroupCalendar_Invites.Group.NumJoinedOrInvited = gGroupCalendar_Invites.Group.NumJoinedOrInvited + 1;
		
		gGroupCalendar_Invites.GroupChanged = true;
	end -- for
	
	Calendar_ErrorMessage("GroupCalendar: Internal Error: InviteNow() not terminating properly");
end

function CalendarAttendanceList_GetRSVPClassCategory(pItem)
	local	vCategoryID = CalendarAttendanceList_GetRSVPStatusCategory(pItem);
	
	if not vCategoryID then
		return nil;
	end
	
	if vCategoryID ~= "YES" then
		return vCategoryID;
	end
	
	if pItem.mClassCode then
		return pItem.mClassCode;
	end
	
	return "?";
end

function CalendarGroupInvites_MergeEventAttendance(pGroup, pEvent, pSortByClass)
	if not pEvent
	or not pEvent.mAttendance then
		return;
	end
	
	for vAttendeeName, vRSVPString in pEvent.mAttendance do
		local	vRSVP = EventDatabase_UnpackEventRSVP(nil, vAttendeeName, pEvent.mID, vRSVPString);
		local	vCategoryID = CalendarAttendanceList_GetRSVPClassCategory(vRSVP);
		
		if vCategoryID
		and vCategoryID ~= "NO" then
			local	vItem = pGroup.Items[vRSVP.mName];
			
			if not vItem then
				vRSVP.mType = "RSVP";
				vRSVP.mGroupStatus = GroupCalendar_cRSVPStatusToGroupStatus[vRSVP.mStatus];
				
				if vRSVP.mGroupStatus then
					pGroup.Items[vRSVP.mName] = vRSVP;
				end
			else
				-- Just update the status and
				-- player info fields
				
				vItem.mStatus = vRSVP.mStatus;
				vItem.mComment = vRSVP.mComment;
				vItem.mGuild = vRSVP.mGuild;
				vItem.mGuildRank = vRSVP.mGuildRank;
				
				if vItem.mGroupStatus == "Standby"
				or vItem.mGroupStatus == "Ready" then
					vItem.mGroupStatus = GroupCalendar_cRSVPStatusToGroupStatus[vRSVP.mStatus];
				end
			end
		end
	end
end

function CalendarGroupInvites_InviteSelectedPlayers()
	-- Reset the SentInvite flag
	
	for vCategory, vCategoryInfo in gGroupCalendar_Invites.Group.Categories do
		for vIndex, vPlayer in vCategoryInfo.mAttendees do
			if vPlayer.mSelected then
				vPlayer.mNeedsInvite = true;
			end
		end
	end
	
	-- Arm the trigger for when the party is actually
	-- formed (needed to make ConvertToRaid() work properly)
	
	if GetNumRaidMembers() ~= 0
	or GetNumPartyMembers() ~= 0 then
		gGroupCalendar_Invites.PartyFormed = true;
	else
		gGroupCalendar_Invites.PartyFormed = false;
	end
	
	-- Start inviting
	
	gGroupCalendar_Invites.Inviting = true;
	gGroupCalendar_Invites.NextInviteDelay = 0;
	GroupCalendar_StartUpdateTimer();
	
	CalendarGroupInvites_InviteNow();
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_HasSelection()
	for vIndex, vPlayer in gGroupCalendar_Invites.Group.Items do
		if vPlayer.mSelected then
			return true;
		end
	end
	
	return false;
end

function CalendarGroupInvites_ClearSelection()
	for vIndex, vPlayer in gGroupCalendar_Invites.Group.Items do
		vPlayer.mSelected = nil;
	end
	
	CalendarGroupInvites_SelectionChanged();
end

function CalendarGroupInvites_SetItemSelected(pItem, pSelected)
	if not pSelected then
		pSelected = nil;
	end
	
	if pItem.mSelected == pSelected then
		return;
	end
	
	pItem.mSelected = pSelected;
	
	CalendarGroupInvites_SelectionChanged();
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_SelectionChanged()
	local	vNumSelected = 0;
	local	vNumJoined = 0;
	local	vNumAttendees = 0;
	local	vNumJoinedOrInvited = 0;
	
	for vIndex, vPlayer in gGroupCalendar_Invites.Group.Items do
		if vPlayer.mGroupStatus == "Joined" then
			vNumJoined = vNumJoined + 1;
			vNumJoinedOrInvited = vNumJoinedOrInvited + 1;
			vNumAttendees = vNumAttendees + 1;
		else
			if vPlayer.mSelected then
				vNumSelected = vNumSelected + 1;
				vNumAttendees = vNumAttendees + 1;
			end
			
			if vPlayer.mGroupStatus == "Invited" then
				vNumJoinedOrInvited = vNumJoinedOrInvited + 1;
			end
		end
	end
	
	gGroupCalendar_Invites.Group.NumAttendees =  vNumAttendees;
	gGroupCalendar_Invites.Group.NumJoinedMembers = vNumJoined;
	gGroupCalendar_Invites.Group.NumJoinedOrInvited = vNumJoinedOrInvited;
	
	gGroupCalendar_Invites.NumSelected = vNumSelected;
	
	CalendarGroupInvites_SortGroup(gGroupCalendar_Invites.Group);
	CalendarGroupInvites_SetReadyStatus();
end

function CalendarGroupInvites_AutoSelectPlayers()
	CalendarClassLimits_Open(gGroupCalendar_Invites.Limits, GroupCalendar_cAutoSelectWindowTitle, true, CalendarGroupInvites_AutoSelectFromLimits);
end

function CalendarGroupInvites_AutoSelectFromLimits(pLimits)
	gGroupCalendar_Invites.Limits = pLimits;
	gGroupCalendar_PlayerSettings.AutoSelectPriorityOrder = pLimits.mPriorityOrder;
	
	CalendarGroupInvites_ClearSelection();
	
	--
	
	local	vAvailableSlots = EventAvailableSlots_InitializeFromLimits(pLimits);
	
	-- Count existing players and accumulate the rest as prospective members
	
	local	vProspects = {};
	
	for vCategory, vCategoryInfo in gGroupCalendar_Invites.Group.Categories do
		for vIndex, vPlayer in vCategoryInfo.mAttendees do
			if vPlayer.mGroupStatus == "Joined"
			or vPlayer.mGroupStatus == "Invited" then
				CalendarEvent_PlayerClassAdded(vAvailableSlots, vPlayer.mClassCode)
			else
				table.insert(vProspects, vPlayer);
			end
		end
	end
	
	-- Sort the prospects by the selected priority
	
	table.sort(vProspects, CalendarGroupInvites_GetGroupItemCompare(pLimits.mPriorityOrder));
	
	-- Add them
	
	for vIndex, vPlayer in vProspects do
		if EventAvailableSlots_AcceptPlayer(vAvailableSlots, vPlayer.mClassCode) then
			vPlayer.mSelected = true;
		end
	end
	
	CalendarGroupInvites_SelectionChanged();
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_PlayerDeclinedInvitation(pName)
	local	vPlayer = CalendarAttendanceList_FindItem(gGroupCalendar_Invites.Group, "mName", pName);
	
	if not vPlayer
	or not vPlayer.mGroupStatus == "Invited" then
		return;
	end
	
	vPlayer.mGroupStatus = "Declined";
	
	gGroupCalendar_Invites.GroupChanged = true;
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_PlayerAlreadyGrouped(pName)
	local	vPlayer = CalendarAttendanceList_FindItem(gGroupCalendar_Invites.Group, "mName", pName);
	
	if not vPlayer then
		return;
	end
	
	if vPlayer.mGroupStatus == "Invited" then
		SendChatMessage(GroupCalendar_cAlreadyGroupedWhisper, "WHISPER", nil, vPlayer.mName);
	end
	
	vPlayer.mGroupStatus = "Grouped";
	
	gGroupCalendar_Invites.GroupChanged = true;
	CalendarGroupInvites_NotifyGroupChanged();
end

function CalendarGroupInvites_NoSuchPlayer(pName)
	local	vPlayer = CalendarAttendanceList_FindItem(gGroupCalendar_Invites.Group, "mName", pName);
	
	if not vPlayer then
		return;
	end
	
	vPlayer.mGroupStatus = "Offline";
	
	gGroupCalendar_Invites.GroupChanged = true;
	CalendarGroupInvites_NotifyGroupChanged();
end


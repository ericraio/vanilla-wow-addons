gGroupCalendar_Database =
{
	Format = 11,
	Databases = {},
};

gGroupCalendar_UserDatabase = nil;

gGroupCalendar_MaximumEventAge = 30;
gGroupCalendar_MinimumEventDate = nil;

gGroupCalendar_PlayerCharacters = {};

gGroupCalendar_40ManLimits =
{
	mClassLimits =
	{
		P = {mMin = 4, mMax = 6},
		R = {mMin = 4, mMax = 6},
		D = {mMin = 4, mMax = 6},
		W = {mMin = 4, mMax = 6},
		H = {mMin = 4, mMax = 6},
		K = {mMin = 4, mMax = 6},
		M = {mMin = 4, mMax = 6},
		L = {mMin = 4, mMax = 6},
		S = {mMin = 4, mMax = 6},
	},
	
	mMaxAttendance = 40,
};

gGroupCalendar_20ManLimits =
{
	mClassLimits =
	{
		P = {mMin = 2, mMax = 3},
		R = {mMin = 2, mMax = 3},
		D = {mMin = 2, mMax = 3},
		W = {mMin = 2, mMax = 3},
		H = {mMin = 2, mMax = 3},
		K = {mMin = 2, mMax = 3},
		M = {mMin = 2, mMax = 3},
		L = {mMin = 2, mMax = 3},
		S = {mMin = 2, mMax = 3},
	},
	
	mMaxAttendance = 20,
};

gGroupCalendar_15ManLimits =
{
	mClassLimits =
	{
		P = {mMin = 1, mMax = 3},
		R = {mMin = 1, mMax = 3},
		D = {mMin = 1, mMax = 3},
		W = {mMin = 1, mMax = 3},
		H = {mMin = 1, mMax = 3},
		K = {mMin = 1, mMax = 3},
		M = {mMin = 1, mMax = 3},
		L = {mMin = 1, mMax = 3},
		S = {mMin = 1, mMax = 3},
	},
	
	mMaxAttendance = 15,
};

gGroupCalendar_10ManLimits =
{
	mClassLimits =
	{
		P = {mMin = 1, mMax = 2},
		R = {mMin = 1, mMax = 2},
		D = {mMin = 1, mMax = 2},
		W = {mMin = 1, mMax = 2},
		H = {mMin = 1, mMax = 2},
		K = {mMin = 1, mMax = 2},
		M = {mMin = 1, mMax = 2},
		L = {mMin = 1, mMax = 2},
		S = {mMin = 1, mMax = 2},
	},
	
	mMaxAttendance = 10,
};

gGroupCalendar_5ManLimits =
{
	mClassLimits =
	{
		P = {mMax = 1},
		R = {mMax = 1},
		D = {mMax = 1},
		W = {mMax = 1},
		H = {mMax = 1},
		K = {mMax = 1},
		M = {mMax = 1},
		L = {mMax = 1},
		S = {mMax = 1},
	},
	
	mMaxAttendance = 5,
};

gGroupCalendar_EventTypes =
{
	General =
	{
		Title = GroupCalendar_cGeneralEventGroup,
		MenuHint = "FLAT",
		Events =
		{
			{id="Meet", name=GroupCalendar_cMeetingEventName},
			{id="Birth", name=GroupCalendar_cBirthdayEventName},
		},
	},
	
	Dungeon =
	{
		Title = GroupCalendar_cDungeonEventGroup,
		MenuHint = "FLAT",
		Events =
		{
			{id="AQT",       name = GroupCalendar_cAQTEventName,       limits = gGroupCalendar_40ManLimits},
			{id="AQR",       name = GroupCalendar_cAQREventName,       limits = gGroupCalendar_20ManLimits},
			{id="BWL",       name = GroupCalendar_cBWLEventName,       limits = gGroupCalendar_40ManLimits},
			{id="MC",        name = GroupCalendar_cMCEventName,        limits = gGroupCalendar_40ManLimits},
			{id="Onyxia",    name = GroupCalendar_cOnyxiaEventName,    limits = gGroupCalendar_40ManLimits},
			{id="ZG",        name = GroupCalendar_cZGEventName,        limits = gGroupCalendar_20ManLimits},
			{id="UBRS",      name = GroupCalendar_cUBRSEventName,      limits = gGroupCalendar_15ManLimits},
			{id="Scholo",    name = GroupCalendar_cScholoEventName,    limits = gGroupCalendar_5ManLimits},
			{id="DM",        name = GroupCalendar_cDMEventName,        limits = gGroupCalendar_5ManLimits},
			{id="Strath",    name = GroupCalendar_cStrathEventName,    limits = gGroupCalendar_5ManLimits},
			{id="LBRS",      name = GroupCalendar_cLBRSEventName,      limits = gGroupCalendar_5ManLimits},
			{id="BRD",       name = GroupCalendar_cBRDEventName,       limits = gGroupCalendar_5ManLimits},
			{id="ST",        name = GroupCalendar_cSTEventName,        limits = gGroupCalendar_5ManLimits},
			{id="ZF",        name = GroupCalendar_cZFEventName,        limits = gGroupCalendar_5ManLimits},
			{id="Mara",      name = GroupCalendar_cMaraEventName,      limits = gGroupCalendar_5ManLimits},
			{id="Uld",       name = GroupCalendar_cUldEventName,       limits = gGroupCalendar_5ManLimits},
			{id="RFD",       name = GroupCalendar_cRFDEventName,       limits = gGroupCalendar_5ManLimits},
			{id="SM",        name = GroupCalendar_cSMEventName,        limits = gGroupCalendar_5ManLimits},
			{id="RFK",       name = GroupCalendar_cRFKEventName,       limits = gGroupCalendar_5ManLimits},
			{id="Gnomer",    name = GroupCalendar_cGnomerEventName,    limits = gGroupCalendar_5ManLimits},
			{id="BFD",       name = GroupCalendar_cBFDEventName,       limits = gGroupCalendar_5ManLimits},
			{id="Stockades", name = GroupCalendar_cStockadesEventName, limits = gGroupCalendar_5ManLimits},
			{id="SFK",       name = GroupCalendar_cSFKEventName,       limits = gGroupCalendar_5ManLimits},
			{id="WC",        name = GroupCalendar_cWCEventName,        limits = gGroupCalendar_5ManLimits},
			{id="Deadmines", name = GroupCalendar_cDeadminesEventName, limits = gGroupCalendar_5ManLimits},
			{id="RFC",       name = GroupCalendar_cRFCEventName,       limits = gGroupCalendar_5ManLimits},
		},
	},
	
	Battleground =
	{
		Title = GroupCalendar_cBattlegroundEventGroup,
		MenuHint = "HIER",
		Events =
		{
			{id="AV", name=GroupCalendar_cAVEventName},
			{id="AB", name=GroupCalendar_cABEventName},
			{id="WSG", name=GroupCalendar_cWSGEventName},
		},
	},
	
	Reset =
	{
		Title = nil,
		Events =
		{
			{id="RSOny", name=GroupCalendar_cOnyxiaResetEventName}, -- Onyxia reset
			{id="RSMC", name=GroupCalendar_cMCResetEventName}, -- MC reset
			{id="RSBWL", name=GroupCalendar_cBWLResetEventName}, -- BWL reset
			{id="RSZG", name=GroupCalendar_cZGResetEventName}, -- ZG reset
			{id="RSAQT", name=GroupCalendar_cAQTResetEventName}, -- AQT reset
			{id="RSAQR", name=GroupCalendar_cAQRResetEventName}, -- AQR reset
			{id="RSXmut", name=GroupCalendar_cTransmuteCooldownEventName}, -- Transmute
			{id="RSSalt", name=GroupCalendar_cSaltShakerCooldownEventName}, -- Salt shaker
			{id="RSMoon", name=GroupCalendar_cMoonclothCooldownEventName}, -- Mooncloth
			{id="RSSnow", name=GroupCalendar_cSnowmasterCooldownEventName}, -- Snowmaster 9000
		},
		
		ResetEventInfo =
		{
			RSZG = {left = 0.0, top = 0.25, right = 0.25, bottom = 0.5, isDungeon = true, name=GroupCalendar_cRaidInfoZGName, largeIcon="ZG"},
			RSOny = {left = 0.25, top = 0.25, right = 0.5, bottom = 0.5, isDungeon = true, name=GroupCalendar_cRaidInfoOnyxiaName, largeIcon="Onyxia"},
			RSMC = {left = 0.5, top = 0.25, right = 0.75, bottom = 0.5, isDungeon = true, name=GroupCalendar_cRaidInfoMCName, largeIcon="MC"},
			RSBWL = {left = 0.75, top = 0.25, right = 1.0, bottom = 0.5, isDungeon = true, name=GroupCalendar_cRaidInfoBWLName, largeIcon="BWL"},
			RSAQT = {left = 0.0, top = 0.5, right = 0.25, bottom = 1.0, isDungeon = true, name=GroupCalendar_cRaidInfoAQTName, largeIcon="AQT"},
			RSAQR = {left = 0.25, top = 0.5, right = 0.5, bottom = 1.0, isDungeon = true, name=GroupCalendar_cRaidInfoAQRName, largeIcon="AQR"},
			RSXmut = {left = 0.50, top = 0, right = 0.75, bottom = 0.25, isTradeskill = true, id="Alchemy", largeSysIcon="Interface\\Icons\\Trade_Alchemy"},
			RSSalt = {left = 0.25, top = 0, right = 0.5, bottom = 0.25, isTradeskill = true, id="Leatherworking", largeSysIcon="Interface\\Icons\\Trade_Leatherworking"},
			RSMoon = {left = 0, top = 0, right = 0.25, bottom = 0.25, isTradeskill = true, id="Tailoring", largeSysIcon="Interface\\Icons\\Trade_Tailoring"},
			RSSnow = {left = 0.75, top = 0, right = 1.0, bottom = 0.25, isTradeskill = true, id="Snowmaster", largeSysIcon="Interface\\Icons\\Spell_Frost_WindWalkOn"},
		},
	},
};

gGroupCalendar_ClassInfoByClassCode =
{
	D = {name = GroupCalendar_cDruidClassName, color = GroupCalendar_cDruidClassColorName, element = "Druid"},
	H = {name = GroupCalendar_cHunterClassName, color = GroupCalendar_cHunterClassColorName, element = "Hunter"},
	M = {name = GroupCalendar_cMageClassName, color = GroupCalendar_cMageClassColorName, element = "Mage"},
	L = {name = GroupCalendar_cPaladinClassName, color = GroupCalendar_cPaladinClassColorName, element = "Paladin", faction="Alliance"},
	P = {name = GroupCalendar_cPriestClassName, color = GroupCalendar_cPriestClassColorName, element = "Priest"},
	R = {name = GroupCalendar_cRogueClassName, color = GroupCalendar_cRogueClassColorName, element = "Rogue"},
	S = {name = GroupCalendar_cShamanClassName, color = GroupCalendar_cShamanClassColorName, element = "Shaman", faction="Horde"},
	K = {name = GroupCalendar_cWarlockClassName, color = GroupCalendar_cWarlockClassColorName, element = "Warlock"},
	W = {name = GroupCalendar_cWarriorClassName, color = GroupCalendar_cWarriorClassColorName, element = "Warrior"},
};

gGroupCalendar_RaceNamesByRaceCode =
{
	A = {name = GroupCalendar_cDraeneiRaceName, faction="Alliance"},
	D = {name = GroupCalendar_cDwarfRaceName, faction="Alliance"},
	G = {name = GroupCalendar_cGnomeRaceName, faction="Alliance"},
	H = {name = GroupCalendar_cHumanRaceName, faction="Alliance"},
	N = {name = GroupCalendar_cNightElfRaceName, faction="Alliance"},
	B = {name = GroupCalendar_cBloodElfRaceName, faction="Horde"},
	O = {name = GroupCalendar_cOrcRaceName, faction="Horde"},
	T = {name = GroupCalendar_cTaurenRaceName, faction="Horde"},
	R = {name = GroupCalendar_cTrollRaceName, faction="Horde"},
	U = {name = GroupCalendar_cUndeadRaceName, faction="Horde"},
};

function EventDatabase_DatabaseIsVisible(pDatabase)
	return pDatabase
		and pDatabase.Realm == gGroupCalendar_RealmName
		and (pDatabase.IsPlayerOwned
		or (pDatabase.LocalUsers
			and pDatabase.LocalUsers[gGroupCalendar_PlayerName]));
end

function EventDatabase_GetDatabase(pUserName, pCreate)
	if not pUserName then
		Calendar_DebugMessage("EventDatabase_GetDatabase: pUserName is nil");
		return;
	end
	
	local	vDatabase = gGroupCalendar_Database.Databases[gGroupCalendar_RealmName.."_"..pUserName];
	
	if not vDatabase then
		if pCreate then
			vDatabase = {};
			
			vDatabase.UserName = pUserName;
			vDatabase.IsPlayerOwned = pUserName == gGroupCalendar_PlayerName;
			vDatabase.CurrentEventID = 0;
			vDatabase.Realm = gGroupCalendar_RealmName;
			vDatabase.Events = {};
			vDatabase.Changes = nil;
			vDatabase.RSVPs = nil;
			vDatabase.LocalUsers = {};
			vDatabase.Guild = gGroupCalendar_PlayerGuild;
			
			gGroupCalendar_Database.Databases[gGroupCalendar_RealmName.."_"..pUserName] = vDatabase;
			
			if vDatabase.IsPlayerOwned then
				gGroupCalendar_PlayerCharacters[gGroupCalendar_PlayerName] = true;
			end
		else
			return nil;
		end
	end
	
	if not vDatabase.IsPlayerOwned
	and (not vDatabase.LocalUsers
	or not vDatabase.LocalUsers[gGroupCalendar_PlayerName]) then
		if not pCreate then
			return nil;
		end
		
		if not vDatabase.LocalUsers then
			vDatabase.LocalUsers = {};
		end
		
		vDatabase.LocalUsers[gGroupCalendar_PlayerName] = true;
	end
	
	if vDatabase
	and not vDatabase.IsPlayerOwned
	and pUserName == gGroupCalendar_PlayerName then
		vDatabase.IsPlayerOwned = true;
	end
	
	return vDatabase;
end

function EventDatabase_GetOwnedDatabases()
	local	vOwnedDatabases = {};
	
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		if EventDatabase_DatabaseIsVisible(vDatabase)
		and vDatabase.IsPlayerOwned
		and vDatabase.PlayerLevel then -- Skip databases which haven't been visited since this version
			table.insert(vOwnedDatabases, vDatabase);
		end
	end
	
	return vOwnedDatabases;
end

function EventDatabase_AssumeDatabase(pUserName)
	local	vDatabase = gGroupCalendar_Database.Databases[gGroupCalendar_RealmName.."_"..pUserName];
	
	if not vDatabase then
		return nil;
	end
	
	if not vDatabase.IsPlayerOwned
	and not vDatabase.LocalUsers[gGroupCalendar_PlayerName] then
		vDatabase.LocalUsers[gGroupCalendar_PlayerName] = true;
		GroupCalendar_MajorDatabaseChange(vDatabase);
	end
	
	return vDatabase;
end

function EventDatabase_DeleteDatabase(pUserName)
	local	vDatabase = gGroupCalendar_Database.Databases[gGroupCalendar_RealmName.."_"..pUserName];
	
	if not vDatabase then
		return;
	end
	
	if vDatabase.LocalUsers then
		vDatabase.LocalUsers[gGroupCalendar_PlayerName] = nil;
	end
	
	if Calendar_ArrayIsEmpty(vDatabase.LocalUsers) then
		gGroupCalendar_Database.Databases[gGroupCalendar_RealmName.."_"..pUserName] = nil;
	end
	
	GroupCalendar_MajorDatabaseChange(vDatabase);
end

function EventDatabase_GetChanges(pDatabase)
	local	vChanges = pDatabase.Changes;
	
	if not vChanges then
		vChanges = CalendarChanges_New();
		pDatabase.Changes = vChanges;
	end
	
	return vChanges;
end

function EventDatabase_SetUserName(pUserName)
	gGroupCalendar_UserDatabase = EventDatabase_GetDatabase(gGroupCalendar_PlayerName, true);
	
	gGroupCalendar_UserDatabase.PlayerRaceCode = EventDatabase_GetRaceCodeByRace(UnitRace("PLAYER"));
	gGroupCalendar_UserDatabase.PlayerClassCode = EventDatabase_GetClassCodeByClass(UnitClass("PLAYER"));
end

function EventDatabase_NewEvent(pDatabase, pDate)
	local	vEvent = {};
	
	vEvent.mType = nil;
	vEvent.mTitle = nil;
	
	vEvent.mTime = 1140;
	vEvent.mDate = pDate;
	vEvent.mDuration = 120;
	
	vEvent.mDescription = nil;
	
	vEvent.mMinLevel = 0;
	vEvent.mAttendance = nil;
	
	vEvent.mPrivate = nil;
	
	vEvent.mManualConfirm = false;
	vEvent.mLimits = nil;
	
	pDatabase.CurrentEventID = pDatabase.CurrentEventID + 1;
	vEvent.mID = pDatabase.CurrentEventID;
	
	return vEvent;
end

function EventDatabase_AddEvent(pDatabase, pEvent, pSilent)
	local	vSchedule = pDatabase.Events[pEvent.mDate];
	
	if vSchedule == nil then
		vSchedule = {};
		pDatabase.Events[pEvent.mDate] = vSchedule;
	end
	
	-- append the event
	
	table.insert(vSchedule, pEvent);
	
	if not pSilent then
		EventDatabase_EventAdded(pDatabase, pEvent);
	end
end

function EventDatabase_GetDateSchedule(pDate)
	return gGroupCalendar_UserDatabase.Events[pDate];
end

function EventDatabase_GetCompiledSchedule(pDate)
	local		vCompiledSchedule = {};
	
	if gGroupCalendar_Settings.ShowEventsInLocalTime then
		local		vDate2 = nil;
		
		if gGroupCalendar_ServerTimeZoneOffset < 0 then
			vDate2 = pDate + 1;
		elseif gGroupCalendar_ServerTimeZoneOffset > 0 then
			vDate2 = pDate - 1;
		end
		
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if EventDatabase_DatabaseIsVisible(vDatabase) then
				for vDateIndex = 1, 2 do
					local	vDate;
					
					if vDateIndex == 1 then
						vDate = pDate;
					else
						if not vDate2 then
							break;
						end
						
						vDate = vDate2;
					end
					
					local	vSchedule = vDatabase.Events[vDate];
					
					if vSchedule then
						for vIndex, vEvent in vSchedule do
							-- Calculate the local date/time and see if it's still the right date
							
							local	vLocalDate, vLocalTime = Calendar_GetLocalDateTimeFromServerDateTime(vDate, vEvent.mTime);
							
							if vLocalDate == pDate then
								local	vCompiledEvent = {mOwner = vDatabase.UserName, mEvent = vEvent};
								
								table.insert(vCompiledSchedule, vCompiledEvent);
							end
						end
					end
				end
			end
		end
	else
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if EventDatabase_DatabaseIsVisible(vDatabase) then
				local	vSchedule = vDatabase.Events[pDate];
				
				if vSchedule then
					for vIndex, vEvent in vSchedule do
						local	vCompiledEvent = {mOwner = vDatabase.UserName, mEvent = vEvent};
						
						table.insert(vCompiledSchedule, vCompiledEvent);
					end
				end
			end
		end
	end
	
	table.sort(vCompiledSchedule, EventDatabase_CompareCompiledEvents);
	
	return vCompiledSchedule;
end

function EventDatabase_CompareCompiledEvents(pCompiledEvent1, pCompiledEvent2)
	return EventDatabase_CompareEvents(pCompiledEvent1.mEvent, pCompiledEvent2.mEvent);
end

function EventDatabase_GetEventDisplayName(pEvent)
	if pEvent.mTitle and pEvent.mTitle ~= "" then
		return Calendar_UnescapeString(pEvent.mTitle);
	else
		local	vName = EventDatabase_GetEventNameByID(pEvent.mType);
		
		if vName ~= nil then
			return vName;
		else
			return "";
		end
	end
end

function EventDatabase_CompareEvents(pEvent1, pEvent2)
	-- If either event has nil for a time (all day event) then
	-- sort based on time or display name
	
	if not pEvent1.mTime or not pEvent2.mTime then
		if pEvent1.mTime == pEvent2.mTime then
			return EventDatabase_GetEventDisplayName(pEvent1) < EventDatabase_GetEventDisplayName(pEvent2);
		elseif pEvent1.mTime == nil then
			return true;
		else
			return false;
		end
	
	-- Otherwise compare dates first
	
	elseif pEvent1.mDate < pEvent2.mDate then
		return true;
	elseif pEvent1.mDate > pEvent2.mDate then
		return false;
	
	-- Dates are the same, compare times
	
	elseif pEvent1.mTime == pEvent2.mTime then
		return EventDatabase_GetEventDisplayName(pEvent1) < EventDatabase_GetEventDisplayName(pEvent2);
	else
		return pEvent1.mTime < pEvent2.mTime;
	end
end

function EventDatabase_GetEventIndex(pSchedule, pEvent)
	for vIndex, vEvent in pSchedule do
		if vEvent == pEvent then
			return vIndex;
		end
	end
	
	return 0;
end

function EventDatabase_ScheduleIsEmpty(pSchedule)
	for vIndex, vEvent in pSchedule do
		return false;
	end
	
	return true;
end

function EventDatabase_FindEventByID(pDatabase, pEventID)
	for vDate, vSchedule in pDatabase.Events do
		for vEventIndex, vEvent in vSchedule do
			if vEvent.mID == pEventID then
				return vEvent, vDate;
			end
		end
	end
	
	return nil;
end

function EventDatabase_DeleteEvent(pDatabase, pEvent, pSilent)
	return EventDatabase_DeleteEventFromDate(pDatabase, pEvent.mDate, pEvent, pSilent);
end

function EventDatabase_DeleteEventFromDate(pDatabase, pDate, pEvent, pSilent)
	-- Get the event's schedule
	
	local	vSchedule = pDatabase.Events[pDate];
	
	if vSchedule == nil then
		return false;
	end
	
	-- Find the event index
	
	local	vEventIndex = EventDatabase_GetEventIndex(vSchedule, pEvent);
	
	if vEventIndex == 0 then
		return false;
	end
	
	-- Notify that the event is being removed
	
	if not pSilent
	and pDatabase.IsPlayerOwned then
		CalendarNetwork_RemovingEvent(pDatabase, pEvent);
	end
	
	-- Remove any pending RSVPs for the event
	
	EventDatabase_RemoveAllRSVPsForEvent(pDatabase, pEvent, false);
	
	-- Remove the event
	
	table.remove(vSchedule, vEventIndex);
	
	if EventDatabase_ScheduleIsEmpty(vSchedule) then
		pDatabase.Events[pDate] = nil;
		vSchedule = nil;
	end
	
	-- Notify that the schedule changed
	
	GroupCalendar_ScheduleChanged(pDatabase, pDate);
	
	return true;
end

function EventDatabase_GetEventInfoByID(pID)
	for vGroupID, vEventGroup in gGroupCalendar_EventTypes do
		for vIndex, vEventInfo in vEventGroup.Events do
			if vEventInfo.id == pID then
				return vEventInfo;
			end
		end
	end
	
	return nil;
end

function EventDatabase_GetEventNameByID(pID)
	local	vEventInfo = EventDatabase_GetEventInfoByID(pID);
	
	if not vEventInfo then
		return nil;
	end
	
	return vEventInfo.name;
end

function EventDatabase_GetStandardLimitsByID(pID)
	local	vEventInfo = EventDatabase_GetEventInfoByID(pID);
	
	if not vEventInfo
	or not vEventInfo.limits then
		return nil;
	end
	
	-- Remove limit for classes from the "wrong" faction
	
	for vClassCode, vClassLimit in vEventInfo.limits.mClassLimits do
		local	vClassInfo = gGroupCalendar_ClassInfoByClassCode[vClassCode];
		
		if vClassInfo.faction
		and vClassInfo.faction ~= gGroupCalendar_PlayerFactionGroup then
			vEventInfo.limits.mClassLimits[vClassCode] = nil;
		end
	end
	
	--
	
	return vEventInfo.limits;
end

function EventDatabase_EventAdded(pDatabase, pEvent)
	-- Notify the calendar
	
	GroupCalendar_ScheduleChanged(pDatabase, pEvent.mDate);
	
	-- Notify the network
	
	CalendarNetwork_NewEvent(pDatabase, pEvent);
end

function EventDatabase_EventChanged(pDatabase, pEvent, pChangedFields)
	-- If the date changed then move the event to the appropriate slot
	
	if pChangedFields and pChangedFields.mDate then
		local	vEvent, vDate = EventDatabase_FindEventByID(pDatabase, pEvent.mID);
		
		if vDate ~= pEvent.mDate then
			EventDatabase_DeleteEventFromDate(pDatabase, vDate, pEvent, true);
			EventDatabase_AddEvent(pDatabase, pEvent, true);
		end
	end
	
	-- Update pending RSVPs based on event contents
	
	if pChangedFields and pChangedFields.mAttendance then
		if pChangedFields.mAttendance.op == "UPD" then
			for vAttendeeName, vRSVPString in pChangedFields.mAttendance.val do
				local	vDatabase = EventDatabase_GetDatabase(vAttendeeName, false);
				
				if vDatabase then
					-- Remove any older (or same) RSVP for this person
					
					local	vRSVP = EventDatabase_UnpackEventRSVP(pDatabase.UserName, vAttendeeName, pEvent.mID, vRSVPString);
					
					EventDatabase_RemoveOlderRSVP(vDatabase, vRSVP)
				end
			end
		else
			Calendar_DumpArray("EventDatabase_EventChanged: ", pChangedFields);
			Calendar_DebugMessage("EventDatabase_EventChanged: Attendance op "..pChangedFields.mAttendance.op.." not recognized");
		end
	end
	
	-- Notify the calendar
	
	GroupCalendar_EventChanged(pDatabase, pEvent, pChangedFields);
	
	-- Notify the network
	
	CalendarNetwork_EventChanged(pDatabase, pEvent, pChangedFields);
end

function EventDatabase_GetCurrentChangeList(pDatabase)
	local	vChanges = EventDatabase_GetChanges(pDatabase);
	local	vChangeList, vRevisionChanged = CalendarChanges_GetCurrentChangeList(vChanges);
	
	if vRevisionChanged and pDatabase.IsPlayerOwned then
		CalendarNetwork_DBRevisionChanged(pDatabase);
	end
	
	return vChangeList;
end

function EventDatabase_GetDBRevisionPath(pUserName, pDatabaseID, pRevision, pAuthRevision)
	return CalendarChanges_GetRevisionPath("DB", pUserName, pDatabaseID, pRevision, pAuthRevision);
end

function EventDatabase_GetRSVPRevisionPath(pUserName, pDatabaseID, pRevision, pAuthRevision)
	return CalendarChanges_GetRevisionPath("RAT", pUserName, pDatabaseID, pRevision, pAuthRevision);
end

function EventDatabase_GetEventPath(pEvent)
	return "EVT:"..pEvent.mID.."/";
end

function EventDatabase_GenerateEventChangeString(pOpcode, pEvent, pEventPath)
	local		vChange;
	
	-- Basic fields: type, date, time, duration, minLevel, maxLevel

	vChange = pEventPath..pOpcode..":";
	
	if pEvent.mType ~= nil then
		vChange = vChange..pEvent.mType..",";
	else
		vChange = vChange..",";
	end

	if pEvent.mDate ~= nil then
		vChange = vChange..pEvent.mDate..",";
	else
		vChange = vChange..",";
	end

	if pEvent.mTime ~= nil then
		vChange = vChange..pEvent.mTime..",";
	else
		vChange = vChange..",";
	end

	if pEvent.mDuration ~= nil then
		vChange = vChange..pEvent.mDuration..",";
	else
		vChange = vChange..",";
	end

	if pEvent.mMinLevel ~= nil then
		vChange = vChange..pEvent.mMinLevel..",";
	else
		vChange = vChange..",";
	end

	if pEvent.mMaxLevel ~= nil then
		vChange = vChange..pEvent.mMaxLevel;
	end
	
	return vChange;
end

function EventDatabase_AppendNewEvent(pChangeList, pEvent, pEventPath)
	-- Basic fields: type, date, time, duration, minLevel, maxLevel
	
	table.insert(pChangeList, EventDatabase_GenerateEventChangeString("NEW", pEvent, pEventPath));
	
	-- Title
	
	if pEvent.mTitle then
		table.insert(pChangeList, pEventPath.."TIT:"..pEvent.mTitle);
	end

	if pEvent.mDescription ~= nil then
		table.insert(pChangeList, pEventPath.."DSC:"..pEvent.mDescription);
	end
	
	if pEvent.mManualConfirm then
		table.insert(pChangeList, pEventPath.."CNF:MAN");
	elseif pEvent.mLimits then
		local	vConfConfigString = "CNF:AUT";
		
		if pEvent.mLimits.mMaxAttendance then
			vConfConfigString = vConfConfigString.."/MAX:"..pEvent.mLimits.mMaxAttendance;
		end
		
		if pEvent.mLimits.mClassLimits then
			for vClassCode, vClassLimit in pEvent.mLimits.mClassLimits do
				vConfConfigString = vConfConfigString.."/"..vClassCode..":";
				
				if vClassLimit.mMin then
					vConfConfigString = vConfConfigString..vClassLimit.mMin;
				end
				
				if vClassLimit.mMax then
					vConfConfigString = vConfConfigString..","..vClassLimit.mMax;
				end
			end
		end
		
		table.insert(pChangeList, pEventPath..vConfConfigString);
	end

	-- Add attendance info
	
	if pEvent.mAttendance then
		for vAttendeeName, vAttendance in pEvent.mAttendance do
			table.insert(pChangeList, pEventPath.."ATT:"..vAttendeeName..","..vAttendance);
		end
	end
	
	table.insert(pChangeList, pEventPath.."END");
end

function EventDatabase_AppendEventUpdate(pChangeList, pEvent, pEventPath, pChangedFields)
	local	vNeedUpdateWrapper = false;
	
	-- See if fields sent in the NEW or UPD wrapper are being changed.  If so, the
	-- wrapper needs to be sent, otherwise it can be omitted to save bandwidth
	
	if pChangedFields.mType
	or pChangedFields.mDate
	or pChangedFields.mTime
	or pChangedFields.mDuration
	or pChangedFields.mMinLevel
	or pChangedFields.mMaxLevel then
		vNeedUpdateWrapper = true;
	end

	-- Basic fields: type, date, time, duration, minLevel, maxLevel
	
	if vNeedUpdateWrapper then
		table.insert(pChangeList, EventDatabase_GenerateEventChangeString("UPD", pEvent, pEventPath));
	end
	
	-- Title
	
	if pChangedFields.mTitle ~= nil then
		if pEvent.mTitle then
			table.insert(pChangeList, pEventPath.."TIT:"..pEvent.mTitle);
		end
	end
	
	if pChangedFields.mDescription ~= nil then
		if pEvent.mDescription ~= nil then
			table.insert(pChangeList, pEventPath.."DSC:"..pEvent.mDescription);
		end
	end
	
	if pChangedFields.mManualConfirm ~= nil
	or pChangedFields.mLimits ~= nil then
		if pEvent.mManualConfirm then
			table.insert(pChangeList, pEventPath.."CNF:MAN");
		elseif pEvent.mLimits then
			local	vConfConfigString = "CNF:AUT";
			
			if pEvent.mLimits.mMaxAttendance then
				vConfConfigString = vConfConfigString.."/MAX:"..pEvent.mLimits.mMaxAttendance;
			end
			
			if pEvent.mLimits.mClassLimits then
				for vClassCode, vClassLimit in pEvent.mLimits.mClassLimits do
					vConfConfigString = vConfConfigString.."/"..vClassCode..":";
					
					if vClassLimit.mMin then
						vConfConfigString = vConfConfigString..vClassLimit.mMin;
					end
					
					if vClassLimit.mMax then
						vConfConfigString = vConfConfigString..","..vClassLimit.mMax;
					end
				end
			end
			
			table.insert(pChangeList, pEventPath..vConfConfigString);
		end
	end

	if pChangedFields.mAttendance ~= nil then
		if pChangedFields.mAttendance.op == "UPD" then
			for vAttendeeName, vEventRSVPString in pChangedFields.mAttendance.val do
				local	vAttendeeRSVPString = pEvent.mAttendance[vAttendeeName];
				local	vAttendeePath = pEventPath.."ATT:"..vAttendeeName;
				
				if not vAttendeeRSVPString then
					table.insert(pChangeList, vAttendeePath);
				else
					table.insert(pChangeList, vAttendeePath..","..vAttendeeRSVPString);
				end
			end
		else
			Calendar_DebugMessage("EventDatabase_AppendEventUpdate: Unknown attendance opcode "..pChangedFields.mAttendance.op);
		end
	end
	
	if vNeedUpdateWrapper then
		table.insert(pChangeList, pEventPath.."END");
	end
end

function EventDatabase_RemoveEventChanges(pDatabase, pEvent)
	-- Nothing to do if there are no changes
	
	if not pDatabase.Changes then
		return;
	end
	
	-- Remove all prior occurances for this event
	
	for vRevision, vChangeList in pDatabase.Changes.ChangeList do
		local	vEventPath = EventDatabase_GetEventPath(pEvent);
		local	vPathLength = string.len(vEventPath);
		
		local	vNumChanges = table.getn(vChangeList);
		local	vChangeIndex = 1;
		
		while vChangeIndex <= vNumChanges do
			vChange = vChangeList[vChangeIndex];
			
			if vChange ~= nil
			and string.sub(vChange, 1, vPathLength) == vEventPath then
				table.remove(vChangeList, vIndex);
				vNumChanges = vNumChanges - 1;
			else
				vChangeIndex = vChangeIndex + 1;
			end
		end
		
		if vNumChanges == 0 then
			pDatabase.Changes.ChangeList[vRevision] = nil;
		end
	end
end

function EventDatabase_RebuildPlayerDatabases()
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		if vDatabase.IsPlayerOwned
		and vDatabase.Realm == gGroupCalendar_RealmName then
			EventDatabase_RebuildDatabase(vDatabase);
		end
	end -- for vRealmUser, vDatabase
end

----------------------------------------
-- EventDatabase_CalculateHighestUsedEventID
--     Calculates the highest event ID in use by the database
----------------------------------------

function EventDatabase_CalculateHighestUsedEventID(pDatabase)
	local	vHighestID = nil;
	
	for vDate, vSchedule in pDatabase.Events do
		for vEventIndex, vEvent in vSchedule do
			if not vHighestID
			or vHighestID < vEvent.mID then
				vHighestID = vEvent.mID;
			end
		end -- for vEventIndex, vEvent
	end -- for vDate, vSchedule
end

----------------------------------------
-- EventDatabase_RepairEventIDs
--     Scans the database an ensures that every event has
--     a unique ID
----------------------------------------

function EventDatabase_RepairEventIDs(pDatabase)
	local	vCurrentID = EventDatabase_CalculateHighestUsedEventID(pDatabase);
	
	-- Just return if there are no events
	
	if not vCurrentID then
		return;
	end
	
	-- Adjust the highest ID if it is lower than current ID
	
	if vCurrentID < pDatabase.CurrentEventID then
		vCurrentID = pDatabase.CurrentEventID;
	end
	
	-- Start making a map of used event IDs and
	-- use up the next ID if a collision is detected
	
	local	vUsedIDs = {};
	
	for vDate, vSchedule in pDatabase.Events do
		for vEventIndex, vEvent in vSchedule do
			if not vUsedIDs[vEvent.mID] then
				vUsedIDs[vEvent.mID] = true;
			else
				-- Collision
				
				vCurrentID = vCurrentID + 1;
				vEvent.mID = vCurrentID;
			end
		end -- for vEventIndex, vEvent
	end -- for vDate, vSchedule
	
	-- Save the new current ID
	
	pDatabase.CurrentEventID = vCurrentID;
end

----------------------------------------
-- EventDatabase_RebuildDatabase
--     Builds a new change history from the existing events
----------------------------------------

function EventDatabase_RebuildDatabase(pDatabase)
	-- Repair event IDs
	
	EventDatabase_RepairEventIDs(pDatabase);
	
	-- Clear the revisions
	
	pDatabase.Changes = nil;
	
	-- Start a new revision
	
	local	vChangeList = nil;
	
	-- Add each event to the revision
	
	for vDate, vSchedule in pDatabase.Events do
		for vEventIndex, vEvent in vSchedule do
			if not vChangeList then
				vChangeList = EventDatabase_GetCurrentChangeList(pDatabase);
			end
			
			local	vEventPath = EventDatabase_GetEventPath(vEvent);
			
			if not vEvent.mPrivate then
				EventDatabase_AppendNewEvent(
						vChangeList,
						vEvent,
						vEventPath);
			end
		end
	end
	
	if not vChangeList then
		CalendarNetwork_SendEmptyChanges(pDatabase.Changes, "DB", pDatabase.UserName)
	end
	
	-- Compact the RSVP list and notify that they're updated
	
	EventDatabase_RebuildRSVPs(pDatabase);
	
	-- Notify the calendar that there was a major change
	
	GroupCalendar_MajorDatabaseChange(pDatabase);
end

function EventDatabase_RebuildRSVPs(pDatabase)
	if pDatabase.RSVPs then
		CalendarChanges_Compact(pDatabase.RSVPs);
	end
	
	if not CalendarChanges_IsEmpty(pDatabase.RSVPs) then
		CalendarNetwork_RSVPRevisionChanged(pDatabase);
	else
		CalendarNetwork_SendEmptyChanges(pDatabase.RSVPs, "RAT", pDatabase.UserName)
	end
end

----------------------------------------
-- EventDatabase_ReconstructDatabase
--     Reconstructs the event records by re-playing the
--     change history
----------------------------------------

function EventDatabase_ReconstructDatabase(pDatabase)
	-- Clear the events
	
	pDatabase.Events = {};
	
	-- Execute each change
	
	if pDatabase.Changes then
		for vRevision, vChangeList in pDatabase.Changes.ChangeList do
			if gGroupCalendar_Settings.DebugReconstruct then
				Calendar_DebugMessage("EventDatabase_ReconstructDatabase: Reconstruction revision "..vRevision.." in "..pDatabase.UserName);
			end
			
			EventDatabase_ExecuteChangeList(pDatabase, vChangeList, false);
		end
	end
	
	GroupCalendar_MajorDatabaseChange(pDatabase);
end

function EventDatabase_ReprocessAllRSVPs(pDatabase)
	local		vRSVPs = pDatabase.RSVPs;
	
	if not vRSVPs then	
		return;
	end

	for vRevision, vChangeList in vRSVPs.ChangeList do
		EventDatabase_ExecuteRSVPChangeList(pDatabase, vChangeList, false);
	end
end

function EventDatabase_ExecuteRSVPChangeList(pDatabase, pChangeList, pNotifyChanges)
	pChangeList.IsOpen = nil; -- Make sure IsOpen is cleared, a bug may have caused it to remain open
	
	local	vIndex = 1;
	local	vNumChanges = table.getn(pChangeList);
	
	while vIndex <= vNumChanges do
		local	vChange = pChangeList[vIndex];
		
		if vChange then
			local	vCommands = CalendarNetwork_ParseCommandSubString("/"..vChange);
			
			if not vCommands then
				Calendar_DebugMessage("Invalid change entry found in RSVPs for "..pDatabase.UserName);
				return;
			end
			
			local	vOpcode = vCommands[1].opcode;
			local	vOperands = vCommands[1].operands;
			
			table.remove(vCommands, 1);
			
			if vOpcode == "EVT" then
				local	vRSVP = EventDatabase_UnpackRSVPFieldArray(vOperands, pDatabase.UserName);
				
				if EventDatabase_ProcessRSVP(pDatabase, vRSVP) then
					-- The request was consumed, remove it from the list
					
					table.remove(pChangeList, vIndex);
					
					vIndex = vIndex - 1;
					vNumChanges = vNumChanges - 1;
				end
			elseif gGroupCalendar_Settings.DebugErrors then
				Calendar_DebugMessage("GroupCalendar: Unknown RSVP opcode "..vOpcode); 
			end
		end
		
		vIndex = vIndex + 1;
	end
end

function EventDatabase_ExecuteChangeList(pDatabase, pChangeList, pNotifyChanges)
	local	vEvent = nil;
	local	vNewEvent = false;
	local	vQuickEvent = false;
	local	vEventDateChanged = false;
	
	pChangeList.IsOpen = nil; -- Make sure IsOpen is cleared, a bug may have caused it to remain open
	
	for vIndex, vChange in pChangeList do
		local	vCommands = CalendarNetwork_ParseCommandSubString("/"..vChange);
		
		if not vCommands then
			Calendar_DebugMessage("Invalid change entry found in database for "..pDatabase.UserName);
			return;
		end
		
		local	vOpcode = vCommands[1].opcode;
		local	vOperands = vCommands[1].operands;
		
		table.remove(vCommands, 1);
		
		if vOpcode == "EVT" then
			local	vEventID = tonumber(vOperands[1]);
			
			local	vEvtOpcode = vCommands[1].opcode;
			local	vEvtOperands = vCommands[1].operands;
			
			table.remove(vCommands, 1);
		
			if vEvtOpcode == "NEW" then
				if vEvent and gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Starting new event while previous event is still open in database for "..pDatabase.UserName);
				end
				
				if gGroupCalendar_Settings.Debug then
					Calendar_DebugMessage("Adding event "..vEventID.." for "..pDatabase.UserName);
				end
				
				if not EventDatabase_FindEventByID(pDatabase, vEventID) then
					local	vDate = tonumber(vEvtOperands[2]);
					
					if vDate >= gGroupCalendar_MinimumEventDate then
						-- Create the event record
						
						vEvent = {};
						vNewEvent = true;
						
						vEvent.mID = vEventID;
						vEvent.mType = vEvtOperands[1];
						vEvent.mDate = tonumber(vEvtOperands[2]);
						vEvent.mTime = tonumber(vEvtOperands[3]);
						vEvent.mDuration = tonumber(vEvtOperands[4]);
						vEvent.mMinLevel = tonumber(vEvtOperands[5]);
						vEvent.mMaxLevel = tonumber(vEvtOperands[6]);
						
						EventDatabase_AddEvent(pDatabase, vEvent, true);
					end
				elseif gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Event "..vEventID.." already exists in database for "..pDatabase.UserName);
				end
				
			elseif vEvtOpcode == "UPD" then
				if vEvent and gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Updating event while previous event is still open in database for "..pDatabase.UserName);
				end
				
				vEvent = EventDatabase_FindEventByID(pDatabase, vEventID);
				
				if vEvent then
					local	vDate = vEvent.mDate;
					
					vEvent.mID = vEventID;
					vEvent.mType = vEvtOperands[1];
					vEvent.mDate = tonumber(vEvtOperands[2]);
					vEvent.mTime = tonumber(vEvtOperands[3]);
					vEvent.mDuration = tonumber(vEvtOperands[4]);
					vEvent.mMinLevel = tonumber(vEvtOperands[5]);
					vEvent.mMaxLevel = tonumber(vEvtOperands[6]);
					
					vNewEvent = false;
					vEventDateChanged = vEvent.mDate ~= vDate;
				elseif gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Event "..vEventID.." not found in database for "..pDatabase.UserName);
				end
			
			elseif vEvtOpcode == "TIT" then
				if not vEvent then
					vEvent = EventDatabase_FindEventByID(pDatabase, vEventID);
					vQuickEvent = true;
				end
				
				if vEvent then
					vEvent.mTitle = vEvtOperands[1];
				elseif gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Event "..vEventID.." not found in database for "..pDatabase.UserName);
				end
				
			elseif vEvtOpcode == "DSC" then
				if not vEvent then
					vEvent = EventDatabase_FindEventByID(pDatabase, vEventID);
					vQuickEvent = true;
				end
				
				if vEvent then
					vEvent.mDescription = vEvtOperands[1];
				elseif gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Event "..vEventID.." not found in database for "..pDatabase.UserName);
				end
			
			elseif vEvtOpcode == "ATT" then
				if not vEvent then
					vEvent = EventDatabase_FindEventByID(pDatabase, vEventID);
					vQuickEvent = true;
				end
				
				if vEvent then
					local	vAttendeeName = vEvtOperands[1];
					
					if not vEvent.mAttendance then
						vEvent.mAttendance = {};
					end
					
					-- Add/update their attendance
					
					local	vNumOperands = table.getn(vEvtOperands);
					local	vAttendanceString = nil;
					
					if vNumOperands > 1 then
						for vOperandIndex = 2, vNumOperands do
							local	vOperand = vEvtOperands[vOperandIndex];
							
							if vAttendanceString == nil then
								vAttendanceString = "";
							else
								vAttendanceString = vAttendanceString..",";
							end
							
							if vOperand then
								vAttendanceString = vAttendanceString..vOperand;
							end
						end
						
					end
					
					vEvent.mAttendance[vAttendeeName] = vAttendanceString;
					
					-- Remove any older (or same) RSVP for this person
					
					EventDatabase_RemoveOldAttendeeRSVP(vAttendeeName, pDatabase.UserName, vEventID, vAttendanceString);
				
				-- Didn't find the specified event
				
				elseif gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Event "..vEventID.." not found in database for "..pDatabase.UserName);
				end

			elseif vEvtOpcode == "END" then
				if vEvent then
					if pNotifyChanges then
						-- Notify the calendar
						
						if vNewEvent then
							GroupCalendar_ScheduleChanged(pDatabase, vEvent.mDate);
						else
							if vEventDateChanged then
								local	vEvent2, vDate = EventDatabase_FindEventByID(pDatabase, vEvent.mID);
								
								if vDate ~= vEvent.mDate then
									EventDatabase_DeleteEventFromDate(pDatabase, vDate, pEvent, true);
									EventDatabase_AddEvent(pDatabase, vEvent, true);
								end
							end
							
							GroupCalendar_EventChanged(pDatabase, vEvent, nil); -- only notify the calendar
						end
					end
					
					vEvent = nil;
				elseif gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Event not open when attemping to end update for "..pDatabase.UserName);
				end
			
			elseif vEvtOpcode == "DEL" then
				vEvent = EventDatabase_FindEventByID(pDatabase, vEventID);
				vQuickEvent = true;
				
				if vEvent then
					EventDatabase_DeleteEvent(pDatabase, vEvent, true);
				elseif gGroupCalendar_Settings.DebugErrors then
					Calendar_DebugMessage("GroupCalendar: Can't delete event "..vEventID..": Event not found in database for "..pDatabase.UserName);
				end
				
			elseif gGroupCalendar_Settings.DebugErrors then
				Calendar_DebugMessage("GroupCalendar: Unknown change operator "..vEvtOpcode); 
			end
			
			if vQuickEvent then
				vEvent = nil;
			end	
		end
	end
end

function EventDatabase_PurgeDatabase(pDatabase, pDatabaseID)
	EventDatabase_RemoveAllRSVPsForDatabase(pDatabase, false)
	
	pDatabase.CurrentEventID = 0;
	pDatabase.Events = {};
	
	pDatabase.Changes = CalendarChanges_New();
	pDatabase.Changes.ID = pDatabaseID;
	
	GroupCalendar_MajorDatabaseChange(pDatabase);
end

function EventDatabase_PurgeRSVPs(pDatabase, pDatabaseID)
	pDatabase.RSVPs = CalendarChanges_New();
	pDatabase.RSVPs.ID = pDatabaseID;
	
	GroupCalendar_MajorDatabaseChange(pDatabase);
end

function EventDatabase_CheckDatabase(pDatabase)
	-- Remove empty RSVP changelists
	
	if pDatabase.RSVPs then
		for vRevision, vChangeList in pDatabase.RSVPs.ChangeList do
			if table.getn(vChangeList) == 0 then
				pDatabase.RSVPs.ChangeList[vRevision] = nil;
			end
		end
	end
	
	-- Remove events with duplicate IDs
	
	for vDate, vEvents in pDatabase.Events do
		local	vEventIndex = 1;
		local	vNumEvents = table.getn(vEvents);
		
		while vEventIndex <= vNumEvents do
			local	vEvent = vEvents[vEventIndex];
			
			if not vEvent
			or EventDatabase_FindEventByID(pDatabase, vEvent.mID) ~= vEvent then
				Calendar_DebugMessage("EventDatabase_CheckDatabase: Removing extra event ID "..vEvent.mID.." from database for "..pDatabase.UserName);
				
				table.remove(vEvents, vEventIndex);
				vNumEvents = vNumEvents - 1;
			else
				vEventIndex = vEventIndex + 1;
			end
		end
	end
end

function EventDatabase_ScanForNewlines(pDatabase)
	for vDate, vEvents in pDatabase.Events do
		for vEventID, vEvent in vEvents do
			if vEvent.mDescription then
				vEvent.mDescription = string.gsub(vEvent.mDescription, "\n", "&n;");
			end
		end
	end

	if pDatabase.Changes and pDatabase.Changes.ChangeList then
		for vRevision, vChanges in pDatabase.Changes.ChangeList do
			for vIndex, vChange in vChanges do
				if type(vIndex) == "number" then
					vChanges[vIndex] = string.gsub(vChange, "\n", "&n;");
				end
			end
		end
	end
end

function EventDatabase_Initialize()
	EventDatabase_CheckDatabases();
	
	-- Update the list of player-owned databases
	
	gGroupCalendar_PlayerCharacters = {};
	
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		if EventDatabase_DatabaseIsVisible(vDatabase)
		and vDatabase.IsPlayerOwned then
			gGroupCalendar_PlayerCharacters[vDatabase.UserName] = true;
		end
	end
end

function EventDatabase_CheckDatabases()
	-- Upgrade the database to format 4 (just purge all non-owned databases
	-- and rebuild the owned ones)
	
	if gGroupCalendar_Database.Format < 4 then
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if vDatabase.IsPlayerOwned then
				EventDatabase_RebuildDatabase(vDatabase);
			else
				gGroupCalendar_Database.Databases[vRealmUser] = nil;
			end
		end
		
		gGroupCalendar_Database.Format = 4;
	end
	
	-- Upgrade the database to format 5 (scan for newlines in event fields and escape them)
	
	if gGroupCalendar_Database.Format < 5 then
		for vRealmUser, vSettings in gGroupCalendar_Settings do
			if type(vSettings) == "array" and vSettings.EventTemplates then
				for vEventID, vEventTemplate in vSettings.EventTemplates do
					if vEventTemplate.mDescription then
						vEventTemplate.mDescription = string.gsub(vEventTemplate.mDescription, "\n", "&n;");
					end
				end
			end
		end
		
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			EventDatabase_ScanForNewlines(vDatabase);
		end
		
		gGroupCalendar_Database.Format = 5;
	end

	-- Upgrade the database to format 6 (just purge all non-owned databases
	-- and rebuild the owned ones again)
	
	if gGroupCalendar_Database.Format < 6 then
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if vDatabase.IsPlayerOwned then
				EventDatabase_RebuildDatabase(vDatabase);
			else
				gGroupCalendar_Database.Databases[vRealmUser] = nil;
			end
		end
		
		gGroupCalendar_Database.Format = 6;
	end
	
	-- Upgrade to format 7 (just purge all non-owned databases)

	if gGroupCalendar_Database.Format < 7 then
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if not vDatabase.IsPlayerOwned then
				gGroupCalendar_Database.Databases[vRealmUser] = nil;
			end
		end
		
		gGroupCalendar_Database.Format = 7;
	end
	
	-- Upgrade to format 8 (rebuild all owned databases to force
	-- them to the new version numbering system)
	
	if gGroupCalendar_Database.Format < 8 then
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if vDatabase.IsPlayerOwned then
				EventDatabase_RebuildDatabase(vDatabase);
			end
		end
		
		gGroupCalendar_Database.Format = 8;
	end

	-- Upgrade to format 9 (reconstruct non-owned databases to correct
	-- parsing errors)
	
	if gGroupCalendar_Database.Format < 9 then
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if not vDatabase.IsPlayerOwned then
				EventDatabase_ReconstructDatabase(vDatabase);
			end
		end
		
		gGroupCalendar_Database.Format = 9;
	end

	-- Upgrade the database to format 10 (just purge all non-owned databases)
	
	if gGroupCalendar_Database.Format < 10 then
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if not vDatabase.IsPlayerOwned then
				gGroupCalendar_Database.Databases[vRealmUser] = nil;
			end
		end
		
		gGroupCalendar_Database.Format = 10;
	end
	
	-- Upgrade the database to format 11 (ensure that RSVPs for deleted events have been removed
	-- and that event IDs are numbers and not strings)
	
	if gGroupCalendar_Database.Format < 11 then
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			-- Convert all event IDs to a number to fix a bug
			-- caused by earlier versions
			
			for vDate, vEvents in vDatabase.Events do
				for vIndex, vEvent in vEvents do
					vEvent.mID = tonumber(vEvent.mID);
				end
			end
		end
		
		for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
			if vDatabase.IsPlayerOwned then
				EventDatabase_RemoveObsoleteRSVPs(vDatabase);
				EventDatabase_RebuildRSVPs(vDatabase);
			else
				EventDatabase_ReprocessAllRSVPs(vDatabase);
			end
		end
		
		gGroupCalendar_Database.Format = 11;
	end
	
	-- Make sure the realm is set
	
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		if not vDatabase.Realm then
			local	vStartIndex, vEndIndex, vRealmName = string.find(vRealmUser, "([^_]+)");
			
			if vStartIndex ~= nil then
				vDatabase.Realm = vRealmName;
			end
		end
		
		EventDatabase_CheckDatabase(vDatabase);
	end
	
	-- Remove old events
	
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		EventDatabase_DeleteOldEvents(vDatabase);
	end
end

function EventDatabase_CheckDatabaseTrust()
	-- Return if they're in a guild but the roster isn't loaded
	-- so that we don't go and delete a bunch of guildie calendars
	-- by mistake
	
	if IsInGuild() and GetNumGuildMembers() == 0 then
		if gGroupCalendar_Settings.DebugInit then
			Calendar_DebugMessage("CheckDatabaseTrust: Roster isn't loaded, scheduling a load");
		end
		
		CalendarNetwork_LoadGuildRoster();
		return;
	end
	
	if gGroupCalendar_Settings.DebugInit then
		Calendar_DebugMessage("CheckDatabaseTrust: Verifying trust");
	end
	
	-- Verify that each database is still trusted
	
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		-- Only check databases for the current realm
		
		if EventDatabase_DatabaseIsVisible(vDatabase) then
			
			-- See if they're still trusted
			
			if not vDatabase.IsPlayerOwned
			and not CalendarTrust_UserIsTrusted(vDatabase.UserName) then
				-- not trusted anymore, remove their database
				
				EventDatabase_DeleteDatabase(vDatabase.UserName);
			end
		end
	end
end

function EventDatabase_GetDateTime60Stamp()
	local	vYear, vMonth, vDay, vHour, vMinute, vSecond = Calendar_GetCurrentYearMonthDayHourMinute();
	
	local	vDate = Calendar_ConvertMDYToDate(vMonth, vDay, vYear);
	local	vTime60 = Calendar_ConvertHMSToTime60(vHour, vMinute, vSecond);
	
	return vDate, vTime60;
end

function EventDatabase_GetServerDateTime60Stamp()
	local	vYear, vMonth, vDay, vHour, vMinute, vSecond = Calendar_GetCurrentYearMonthDayHourMinute();
	
	local	vDate = Calendar_ConvertMDYToDate(vMonth, vDay, vYear);
	local	vTime = Calendar_ConvertHMToTime(vHour, vMinute);
	
	vDate, vTime = Calendar_GetServerDateTimeFromLocalDateTime(vDate, vTime);
	
	return vDate, vTime * 60 + vSecond;
end

function EventDatabase_GetRSVPs(pDatabase)
	local	vRSVPs = pDatabase.RSVPs;
	
	if not vRSVPs then
		vRSVPs = CalendarChanges_New();
		pDatabase.RSVPs = vRSVPs;
	end
	
	return vRSVPs;
end

function EventDatabase_GetCurrentRSVPChangeList(pDatabase)
	local	vRSVPs = EventDatabase_GetRSVPs(pDatabase);
	local	vChangeList, vRevisionChanged = CalendarChanges_GetCurrentChangeList(vRSVPs);
	
	if vRevisionChanged and pDatabase.IsPlayerOwned then
		CalendarNetwork_RSVPRevisionChanged(pDatabase);
	end
	
	return vChangeList;
end

function EventDatabase_AddEventRSVP(pDatabase, pEvent, pAttendeeName, pRSVP)
	-- Verify that the attendance request is newer than the existing one
	
	local	vExistingRSVP = EventDatabase_FindEventRSVP(pDatabase.UserName, pEvent, pAttendeeName);

	if vExistingRSVP then
		if vExistingRSVP.mDate > pRSVP.mDate
		or (vExistingRSVP.mDate == pRSVP.mDate
		and vExistingRSVP.mTime > pRSVP.mTime) then
			if gGroupCalendar_Settings.Debug then
				Calendar_DebugMessage("EventDatabase_AddEventRSVP: Ignore event attendance request for "..pAttendeeName.." for ".." event "..pRSVP.mEventID..": Request is out-of-date");
			end
			
			return;
		end
	end

	-- Update the event attendance list

	if gGroupCalendar_Settings.Debug then
		Calendar_DebugMessage("EventDatabase_AddEventRSVP: Updating event attendance for "..pAttendeeName.." for ".." event "..pRSVP.mEventID);
	end

	if not pEvent.mAttendance then
		pEvent.mAttendance = {};
	end
	
	local	vEventRSVPString = EventDatabase_PackEventRSVP(pRSVP);
	
	pEvent.mAttendance[pAttendeeName] = vEventRSVPString;

	-- Notify the network of the change

	local	vChangedFields =
	{
		mAttendance =
		{
			op = "UPD",
			val =
			{
			}
		}
	};
	
	vChangedFields.mAttendance.val[pAttendeeName] = vEventRSVPString;

	EventDatabase_EventChanged(pDatabase, pEvent, vChangedFields);
end

function EventDatabase_RemoveEventRSVP(pDatabase, pEvent, pAttendeeName)
	if not pEvent.mAttendance then
		return;
	end
	
	pEvent.mAttendance[pAttendeeName] = nil;

	-- Notify the network of the change

	local	vChangedFields =
	{
		mAttendance =
		{
			op = "UPD",
			val =
			{
				[pAttendeeName] = "-",
			}
		}
	};
	
	EventDatabase_EventChanged(pDatabase, pEvent, vChangedFields);
end

function EventDatabase_AddRSVPRequest(pDatabase, pRSVP)
	-- Remove any existing RSVP for the same event
	
	if not EventDatabase_RemoveOlderRSVP(pDatabase, pRSVP) then
		if gGroupCalendar_Settings.Debug then
			Calendar_DebugMessage("EventDatabase_AddRSVPRequest: Ignoring "..pDatabase.UserName..","..pRSVP.mEventID..": "..pRSVP.mStatus);
		end
		
		return; -- A newer request already exists so disregard this one
	end

	-- Add the new RSVP

	local	vChangeList = EventDatabase_GetCurrentRSVPChangeList(pDatabase);
	
	local	vRSVPString = EventDatabase_PackRSVPRequest(pRSVP);
	local	vRSVPAltsString = EventDatabase_GetRSVPAltsString(pRSVP);
	
	if vRSVPAltsString then
		vRSVPString = vRSVPString.."/ALTS:"..vRSVPAltsString;
	end
	
	if gGroupCalendar_Settings.Debug then
		Calendar_DebugMessage("EventDatabase_AddRSVPRequest: Adding string "..vRSVPString);
	end
	
	table.insert(vChangeList, vRSVPString);
	
	GroupCalendar_MajorDatabaseChange(pDatabase);
end

function EventDatabase_GetRSVPOriginalDateTime(pRSVP)
	if pRSVP.mOriginalDate then
		return pRSVP.mOriginalDate, pRSVP.mOriginalTime;
	else
		return pRSVP.mDate, pRSVP.mTime;
	end
end

function EventDatabase_RemoveAllRSVPsForEvent(pDatabase, pEvent, pOwnedDatabasesOnly)
	local	vPrefix = "EVT:"..pDatabase.UserName..","..pEvent.mID..",";
	local	vPrefixLength = string.len(vPrefix);
	
	EventDatabase_RemoveAllRSVPsByPrefix(pDatabase.Realm, vPrefix, vPrefixLength, pOwnedDatabasesOnly);
end

function EventDatabase_RemoveAllRSVPsForDatabase(pDatabase, pOwnedDatabasesOnly)
	local	vPrefix = "EVT:"..pDatabase.UserName..",";
	local	vPrefixLength = string.len(vPrefix);
	
	EventDatabase_RemoveAllRSVPsByPrefix(pDatabase.Realm, vPrefix, vPrefixLength, pOwnedDatabasesOnly);
end

function EventDatabase_RemoveAllRSVPsByPrefix(pRealm, pPrefix, pPrefixLength, pOwnedDatabasesOnly)
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		if vDatabase.Realm == pRealm
		and (not pOwnedDatabasesOnly or vDatabase.IsPlayerOwned) then
			EventDatabase_RemoveRSVPsByPrefix(vDatabase, pPrefix, pPrefixLength);
		end
	end
end

function EventDatabase_RemoveRSVPsByPrefix(pDatabase, pPrefix, pPrefixLength)
	local	vRSVPString, vIndex, vRevision = EventDatabase_FindRSVPPrefixString(pDatabase, pPrefix, pPrefixLength)
	
	while vRSVPString do
		local	vChangeList = pDatabase.RSVPs.ChangeList[vRevision];
		
		table.remove(vChangeList, vIndex);
		
		if table.getn(vChangeList) == 0 then
			pDatabase.RSVPs.ChangeList[vRevision] = nil;
		end
		
		vRSVPString, vIndex, vRevision = EventDatabase_FindRSVPPrefixString(pDatabase, pPrefix, pPrefixLength)
	end
end

function EventDatabase_ProcessRSVP(pDatabase, pRSVP)
	local	vEventDatabase = EventDatabase_GetDatabase(pRSVP.mOrganizerName, false);
	
	-- Nothing to do if the database isn't one we own
	
	if not vEventDatabase or not vEventDatabase.IsPlayerOwned then
		return false;
	end
	
	-- Process the request into our database
	
	local	vEvent = EventDatabase_FindEventByID(vEventDatabase, pRSVP.mEventID);
	
	if not vEvent then
		if gGroupCalendar_Settings.Debug then
			Calendar_DebugMessage("EventDatabase_ProcessRSVP: Discarding request from "..pDatabase.UserName.." for ".." event "..pRSVP.mEventID..": Event no longer exists");
		end
		
		return true; -- Have the request deleted
	end
	
	-- Look up an existing RSVP
	
	local	vExistingRSVP = EventDatabase_FindEventRSVP(pDatabase.UserName, vEvent, pRSVP.mName);
	
	-- If the player has been banned (removed) from the event then ignore any
	-- requests from them
	
	if vExistingRSVP
	and vExistingRSVP.mStatus == "-" then
		return true; -- Delete the request without processing it
	end
	
	-- If the player is requesting attendance then figure out how to handle the request
	
	if pRSVP.mStatus == "Y" then
		-- If they're already accepted on the list then preserve their current
		-- status
		
		if vExistingRSVP
		and (vExistingRSVP.mStatus == "Y"
		or vExistingRSVP.mStatus == "S") then
			pRSVP.mOriginalDate, pRSVP.mOriginalTime = EventDatabase_GetRSVPOriginalDateTime(vExistingRSVP);
			pRSVP.mStatus = vExistingRSVP.mStatus;
		
		-- Otherwise put them on standby if using manual confirmations
		
		elseif vEvent.mManualConfirm then
			pRSVP.mStatus = "S";
		
		-- Check availablility to determine how to handle automatic confirmations
		
		else
			local	vAvailableSlots = EventAvailableSlots_CountSlots(pDatabase, vEvent);
			
			if not EventAvailableSlots_AcceptPlayer(vAvailableSlots, pRSVP.mClassCode) then
				pRSVP.mStatus = "S";
			end
		end
	end
	
	-- Add the RSVP
	
	EventDatabase_AddEventRSVP(vEventDatabase, vEvent, pDatabase.UserName, pRSVP);
	
	return true;
end

function EventDatabase_AddRSVP(pDatabase, pRSVP)
	if gGroupCalendar_Settings.Debug then
		if not pRSVP.mName then
			Calendar_DumpArray("Missing attendee: ", pRSVP);
			return;
		end
	end
	
	if not EventDatabase_ProcessRSVP(pDatabase, pRSVP) then
		EventDatabase_AddRSVPRequest(pDatabase, pRSVP);
	end
end

function EventDatabase_RemoveOldAttendeeRSVP(pAttendeeName, pOrganizerName, pEventID, pAttendanceString)
	local	vAttendeeDatabase = EventDatabase_GetDatabase(pAttendeeName, false);
	
	-- Just leave if we've never heard of them
	
	if not vAttendeeDatabase then
		return;
	end
	
	-- Just leave if it's a delete request, we don't know how to handle these yet
	
	if not pAttendanceString then
		return;
	end
	
	-- Remove the RSVP request if it exists in their database
	
	local	vRSVP = EventDatabase_UnpackEventRSVP(pOrganizerName, pAttendeeName, pEventID, pAttendanceString);
	
	EventDatabase_RemoveOlderRSVP(vAttendeeDatabase, vRSVP)
end

function EventDatabase_RemoveOlderRSVP(pDatabase, pRSVP)
	if gGroupCalendar_Settings.Debug then
		Calendar_DebugMessage("EventDatabase_RemoveOlderRSVP: Removing RSVP for "..pRSVP.mName.." from "..pDatabase.UserName..","..pRSVP.mEventID);
	end
	
	local	vRSVPString, vIndex, vRevision = EventDatabase_FindRSVPRequestString(pDatabase, pRSVP.mOrganizerName, pRSVP.mEventID);
	
	while vRSVPString ~= nil do
		if gGroupCalendar_Settings.Debug then
			Calendar_DebugMessage("EventDatabase_RemoveOlderRSVP: "..pRSVP.mOrganizerName..","..pRSVP.mEventID.." from position "..vRevision..","..vIndex);
		end
		
		-- If the existing RSVP is newer than the specified date/time then disregard the request
		
		if pRSVP.mDate ~= nil then
			local	vRSVP = EventDatabase_UnpackRSVPRequest(vRSVPString, pRSVP.mName);
			
			if vRSVP.mDate > pRSVP.mDate
			or (vRSVP.mDate == pRSVP.mDate and vRSVP.mTime > pRSVP.mTime) then
				if gGroupCalendar_Settings.Debug then
					Calendar_DebugMessage("EventDatabase_RemoveOlderRSVP: Newer request already exists");
				end
				
				return false; -- Fail to indicate that a newer request is already in the database
			end
		end
		
		-- Remove the old one
		
		local	vChangeList = pDatabase.RSVPs.ChangeList[vRevision];
		table.remove(vChangeList, vIndex);
		
		if table.getn(vChangeList) == 0 then
			pDatabase.RSVPs.ChangeList[vRevision] = nil;
		end
		
		-- Keep removing in case the database has become corrupted with multiple copies
		
		vRSVPString, vIndex, vRevision = EventDatabase_FindRSVPRequestString(pDatabase, pRSVP.mOrganizerName, pRSVP.mEventID);
	end
	
	return true; -- Everything's ok, no newer RSVP was found
end

function EventDatabase_FindRSVPRequestString(pDatabase, pOrganizerName, pEventID)
	if not pEventID then
		Calendar_DebugMessage("EventDatabase_FindRSVPRequestString: pEventID IS NIL!");
	end
	
	if not pOrganizerName then
		Calendar_DebugMessage("EventDatabase_FindRSVPRequestString: pOrganizerName IS NIL!");
	end
	
	local	vRSVPPrefix = "EVT:"..pOrganizerName..","..pEventID..",";
	local	vRSVPPrefixLength = string.len(vRSVPPrefix);
	
	return EventDatabase_FindRSVPPrefixString(pDatabase, vRSVPPrefix, vRSVPPrefixLength);
end

function EventDatabase_FindRSVPPrefixString(pDatabase, pPrefixString, pPrefixLength)
	local	vRSVPs = EventDatabase_GetRSVPs(pDatabase);
	
	for vRevision, vChangeList in vRSVPs.ChangeList do
		local	vNumChanges = table.getn(vChangeList);
		
		for vIndex = 1, vNumChanges do
			local	vRSVP = vChangeList[vIndex];
			
			if string.sub(vRSVP, 1, pPrefixLength) == pPrefixString then
				return vRSVP, vIndex, vRevision;
			end
		end
	end
	
	return nil, nil, nil;
end

function EventDatabase_FindRSVPRequestData(pDatabase, pOrganizerName, pEventID)
	if not pEventID then
		Calendar_DebugMessage("EventDatabase_FindRSVPRequestData: pEventID is nil!");
	end
	
	if not pOrganizerName then
		Calendar_DebugMessage("EventDatabase_FindRSVPRequestData: pOrganizerName IS NIL!");
	end
	
	local	vRSVPString = EventDatabase_FindRSVPRequestString(pDatabase, pOrganizerName, pEventID);
	
	if not vRSVPString then
		return nil;
	end
	
	return EventDatabase_UnpackRSVPRequest(vRSVPString, pDatabase.UserName);
end

function EventDatabase_FindEventRSVPString(pEvent, pAttendeeName)
	if not pEvent.mAttendance then
		return nil;
	end
	
	return pEvent.mAttendance[pAttendeeName];
end

function EventDatabase_FindEventRSVP(pEventOwner, pEvent, pAttendeeName)
	local	vEventRSVPString = EventDatabase_FindEventRSVPString(pEvent, pAttendeeName);
	
	if not vEventRSVPString then
		return nil;
	end
	
	return EventDatabase_UnpackEventRSVP(pEventOwner, pAttendeeName, pEvent.ID, vEventRSVPString);
end

function EventDatabase_EventExists(pEventOwner, pEventID)
	local	vDatabase = EventDatabase_GetDatabase(pEventOwner, false);
	
	if not vDatabase then
		return false;
	end
	
	if not EventDatabase_FindEventByID(vDatabase, pEventID) then
		return false;
	end
	
	return true;
end

function EventDatabase_RemoveObsoleteRSVPs(pDatabase)
	local	vRSVPs = EventDatabase_GetRSVPs(pDatabase);
	
	for vRevision, vChangeList in vRSVPs.ChangeList do
		local	vNumChanges = table.getn(vChangeList);
		local	vIndex = 1;
		
		while vIndex <= vNumChanges do
			local	vRSVP = EventDatabase_UnpackRSVPRequest(vChangeList[vIndex], pDatabase.UserName);
			
			if not EventDatabase_EventExists(vRSVP.mOrganizerName, vRSVP.mEventID) then
				table.remove(vChangeList, vIndex);
				vNumChanges = vNumChanges - 1;
			else
				vIndex = vIndex + 1;
			end
		end
		
		if vNumChanges == 0 then
			vRSVPs.ChangeList[vRevision] = nil;
		end
	end
end

function EventDatabase_GetRSVPAltsString(pRSVP)
	local	vAltsString = nil;
	
	if not pRSVP.mAlts then
		return nil;
	end
	
	for vPlayerName, _ in pRSVP.mAlts do
		if not vAltsString then
			vAltsString = vPlayerName;
		else
			vAltsString = vAltsString..","..vPlayerName;
		end
	end
	
	return vAltsString;
end

function EventDatabase_PackRSVPRequest(pRSVP)
	local	vRequest = "EVT:"..pRSVP.mOrganizerName..","..pRSVP.mEventID..","..pRSVP.mDate..","..pRSVP.mTime..","..pRSVP.mStatus..","..EventDatabase_PackCharInfo(pRSVP)..",";
	
	if pRSVP.mComment then
		vRequest = vRequest..pRSVP.mComment;
	end
	
	if pRSVP.mGuild then
		vRequest = vRequest..","..pRSVP.mGuild..","..pRSVP.mGuildRank;
	else
		vRequest = vRequest..",,";
	end
	
	return vRequest;
end

function EventDatabase_UnpackRSVPRequest(pRSVPString, pAttendee)
	local	vCommands = CalendarNetwork_ParseCommandSubString("/"..pRSVPString);
	local	vOpcode = vCommands[1].opcode;
	
	if vOpcode ~= "EVT" then
		return false;
	end
	
	local	vOperands = vCommands[1].operands;
	
	return EventDatabase_UnpackRSVPFieldArray(vOperands, pAttendee);
end

function EventDatabase_FillInRSVPGuildInfo(pRSVP)
	if pRSVP.mGuild then	
		return;
	end
	
	vIsInGuild, vRankIndex = CalendarNetwork_UserIsInSameGuild(pRSVP.mName);
	
	if not vIsInGuild then
		return;
	end
	
	pRSVP.mGuild = gGroupCalendar_PlayerGuild;
	pRSVP.mGuildRank = vRankIndex;
end

function EventDatabase_UnpackRSVPFieldArray(pArray, pAttendee)
	local	vRSVP =
	{
		mOrganizerName = pArray[1],
		mName = pAttendee;
		mEventID = tonumber(pArray[2]),
		mDate = tonumber(pArray[3]),
		mTime = tonumber(pArray[4]),
		mStatus = pArray[5],
		mComment = pArray[7],
		mGuild = pArray[8],
		mGuildRank = tonumber(pArray[9]),
	};
	
	if vRSVP.mGuild == "" then
		vRSVP.mGuild = nil;
	end
	
	EventDatabase_UnpackCharInfo(pArray[6], vRSVP);
	
	EventDatabase_FillInRSVPGuildInfo(vRSVP);
	
	return vRSVP;
end

function EventDatabase_PackEventRSVP(pEventRSVP)
	local	vEventRSVPString = ""..pEventRSVP.mDate..","..pEventRSVP.mTime..","..pEventRSVP.mStatus..","..EventDatabase_PackCharInfo(pEventRSVP)..",";
	
	if pEventRSVP.mComment then
		vEventRSVPString = vEventRSVPString..pEventRSVP.mComment;
	end
	
	if pEventRSVP.mGuild then
		vEventRSVPString = vEventRSVPString..","..pEventRSVP.mGuild..","..pEventRSVP.mGuildRank;
	else
		vEventRSVPString = vEventRSVPString..",,";
	end
	
	if pEventRSVP.mOriginalDate then
		vEventRSVPString = vEventRSVPString..","..pEventRSVP.mOriginalDate..","..pEventRSVP.mOriginalTime;
	else
		vEventRSVPString = vEventRSVPString..",,";
	end
	
	return vEventRSVPString;
end

function EventDatabase_UnpackEventRSVP(pOrganizerName, pAttendeeName, pEventID, pEventRSVPString)
	local	vEventParameters = CalendarNetwork_ParseParameterString(pEventRSVPString);
	
	local	vRSVPFields =
	{
		mOrganizerName = pOrganizerName,
		mName = pAttendeeName,
		mEventID = pEventID,
		mDate = tonumber(vEventParameters[1]),
		mTime = tonumber(vEventParameters[2]),
		mStatus = vEventParameters[3],
		mComment = vEventParameters[5],
		mGuild = vEventParameters[6],
		mGuildRank = tonumber(vEventParameters[7]),
		mOriginalDate = tonumber(vEventParameters[8]),
		mOriginalTime = tonumber(vEventParameters[9]),
	};
	
	if vRSVPFields.mGuild == "" then
		vRSVPFields.mGuild = nil;
	end
	
	EventDatabase_UnpackCharInfo(vEventParameters[4], vRSVPFields);
	
	EventDatabase_FillInRSVPGuildInfo(vRSVPFields);
	
	return vRSVPFields;
end

function EventDatabase_PackCharInfo(pCharInfo)
	local	vRaceCode, vClassCode, vLevel;
	
	vRaceCode = pCharInfo.mRaceCode;
	
	if not vRaceCode then
		vRaceCode = "?";
	end
	
	vClassCode = pCharInfo.mClassCode;
	
	if not vClassCode then
		vClassCode = "?";
	end
	
	if pCharInfo.mLevel then
		vLevel = pCharInfo.mLevel;
	else
		vLevel = 0;
	end
	
	return vRaceCode..vClassCode..vLevel;
end

function EventDatabase_GetRaceCodeByRace(pRace)
	for vRaceCode, vRaceInfo in gGroupCalendar_RaceNamesByRaceCode do
		if pRace == vRaceInfo.name then
			return vRaceCode;
		end
	end
	
	return "?";
end

function EventDatabase_GetRaceByRaceCode(pRaceCode)
	local	vRaceInfo = gGroupCalendar_RaceNamesByRaceCode[pRaceCode];
	
	if not vRaceInfo then
		return nil;
	end
	
	return vRaceInfo.name;
end

function EventDatabase_GetClassCodeByClass(pClass)
	for vClassCode, vClassInfo in gGroupCalendar_ClassInfoByClassCode do
		if pClass == vClassInfo.name then
			return vClassCode;
		end
	end
	
	return "?";
end

function EventDatabase_GetClassByClassCode(pClassCode)
	local	vClassInfo = gGroupCalendar_ClassInfoByClassCode[pClassCode];
	
	if not vClassInfo then
		if pClassCode then
			return "Unknown ("..pClassCode..")";
		else
			return "Unknown (nil)";
		end
	else
		return vClassInfo.name;
	end
end

function EventDatabase_UnpackCharInfo(pString, rCharInfo)
	if not pString then
		rCharInfo.mRaceCode = "?";
		rCharInfo.mClassCode = "?";
		rCharInfo.mLevel = 0;
	else
		rCharInfo.mRaceCode = string.sub(pString, 1, 1);
		rCharInfo.mClassCode = string.sub(pString, 2, 2);
		rCharInfo.mLevel = tonumber(string.sub(pString, 3));
	end
end
	
function EventDatabase_IsQuestingEventType(pEventType)
	return pEventType ~= "Meet" and pEventType ~= "Birth";
end

function EventDatabase_IsResetEventType(pEventType)
	if not pEventType then
		return false;
	end
	
	return gGroupCalendar_EventTypes.Reset.ResetEventInfo[pEventType] ~= nil;
end

function EventDatabase_GetResetIconCoords(pEventType)
	if not pEventType then
		return nil;
	end
	
	return gGroupCalendar_EventTypes.Reset.ResetEventInfo[pEventType];
end

function EventDatabase_GetResetEventLargeIconPath(pEventType)
	if not pEventType then
		return nil;
	end
	
	local	vResetEventInfo = gGroupCalendar_EventTypes.Reset.ResetEventInfo[pEventType];
	
	if vResetEventInfo.largeIcon then
		return vResetEventInfo.largeIcon, false;
	elseif vResetEventInfo.largeSysIcon then
		return vResetEventInfo.largeSysIcon, true;
	else
		return nil;
	end
end

function EventDatabase_IsDungeonResetEventType(pEventType)
	if not pEventType then
		return false;
	end
	
	local	vResetEventInfo = gGroupCalendar_EventTypes.Reset.ResetEventInfo[pEventType];
	
	if not vResetEventInfo then
		return false;
	end
	
	return vResetEventInfo.isDungeon;
end

function EventDatabase_LookupDungeonResetEventTypeByName(pName)
	for vEventType, vResetEventInfo in gGroupCalendar_EventTypes.Reset.ResetEventInfo do
		if vResetEventInfo.isDungeon then
			if vResetEventInfo.name == pName then
				return vEventType;
			end
		end
	end
	
	return nil;
end

function EventDatabase_LookupTradeskillEventTypeByID(pID)
	for vEventType, vResetEventInfo in gGroupCalendar_EventTypes.Reset.ResetEventInfo do
		if vResetEventInfo.isTradeskill then
			if vResetEventInfo.id == pID then
				return vEventType;
			end
		end
	end
	
	return nil;
end

function EventDatabase_EventTypeUsesAttendance(pEventType)
	if pEventType == "Birth"
	or EventDatabase_IsResetEventType(pEventType) then
		return false;
	end
	
	return true;
end

function EventDatabase_EventTypeUsesLevelLimits(pEventType)
	if pEventType == "Birth"
	or pEventType == "Meet"
	or EventDatabase_IsResetEventType(pEventType) then
		return false;
	end
	
	return true;
end

function EventDatabase_EventTypeUsesTime(pEventType)
	if pEventType == "Birth" then
		return false;
	end
	
	return true;
end

function CalendarChanges_New(pID)
	local	vID;
	
	if pID then
		vID = pID;
	else
		vID = Calendar_GetCurrentDateTimeUT60();
	end
	
	return
	{
		ID = vID,
		Revision = 0,
		AuthRevision = 0,
		ChangeList = {},
	};
end

function CalendarChanges_Rebuild(pChanges)
	pChanges.ID = Calendar_GetCurrentDateTimeUT60();
	
	pChanges.Revision = 0;
	pChanges.AuthRevision = 0;
	pChanges.ChangeList = {};
end

function CalendarChanges_Compact(pChanges)
	local	vNewChanges = nil;
	
	for vRevision, vChanges in pChanges.ChangeList do
		for vIndex, vChange in vChanges do
			if not vNewChanges then
				vNewChanges = {};
			end
			
			if type(vIndex) == "number" then
				table.insert(vNewChanges, vChange);
			end
		end
	end
	
	pChanges.ID = Calendar_GetCurrentDateTimeUT60();
	pChanges.ChangeList = {};
	
	if vNewChanges then
		pChanges.Revision = 1;
		pChanges.AuthRevision = 0;
		pChanges.ChangeList[1] = vNewChanges;
	else
		pChanges.Revision = 0;
		pChanges.AuthRevision = 0;
	end
end

function CalendarChanges_Open(pChanges, pRevision)
	local	vChangeList = pChanges.ChangeList[pRevision];
	
	if not vChangeList then
		vChangeList = {};
		pChanges.ChangeList[pRevision] = vChangeList;
		pChanges.Revision = pRevision;
	end
	
	vChangeList.IsOpen = true;
	
	return vChangeList;
end

function CalendarChanges_Close(pChanges, pRevision)
	local	vChangeList = pChanges.ChangeList[pRevision];
	
	if not vChangeList then
		return;
	end
	
	vChangeList.IsOpen = nil;
end

function CalendarChanges_SetChangeList(pChanges, pRevision, pChangeList)
	pChanges.ChangeList[pRevision] = pChangeList;
	
	if pRevision > pChanges.Revision then
		pChanges.Revision = pRevision;
	end
end

function CalendarChanges_GetCurrentChangeList(pChanges)
	local	vChangeList = nil;
	local	vRevisionChanged = false;
	
	if pChanges.Revision > 0 then
		vChangeList = pChanges.ChangeList[pChanges.Revision];
	end
	
	if vChangeList == nil
	or not vChangeList.IsOpen then
		pChanges.Revision = pChanges.Revision + 1;
		
		vChangeList = {};
		pChanges.ChangeList[pChanges.Revision] = vChangeList;
		
		vChangeList.IsOpen = true;
		
		vRevisionChanged = true;
	end
	
	return vChangeList, vRevisionChanged;
end

function CalendarChanges_LockdownCurrentChangeList(pChanges)
	-- Just return if there are no changes yet
	
	if pChanges.Revision == 0 then
		return;
	end
	
	-- See if the current list exists and is open
	
	local		vChangeList = pChanges.ChangeList[pChanges.Revision];
	
	if not vChangeList
	or not vChangeList.IsOpen then
		return;
	end
	
	-- Close the change list
	
	vChangeList.IsOpen = nil;
end

function CalendarChanges_GetRevisionPath(pLabel, pUserName, pDatabaseID, pRevision, pAuthRevision)
	local	vPath = pLabel..":"..pUserName..",";
	
	if pDatabaseID then
		vPath = vPath..pDatabaseID;
	end
	
	vPath = vPath..","..pRevision;
	
	if pAuthRevision then
		vPath = vPath..","..pAuthRevision;
	end
	
	return vPath.."/";
end

function CalendarChanges_IsEmpty(pChanges)
	if not pChanges
	or pChanges.Revision == 0 then
		return true;
	end
	
	for vRevision, vChanges in pChanges.ChangeList do
		return false;
	end
	
	return true;
end

function CalendarChanges_GetChangeList(pChanges, pRevision)
	return pChanges.ChangeList[pRevision];
end

function CalendarAttendanceList_New()
	return
	{
		NumCategories = 0,
		NumPlayers = 0,
		NumAttendees = 0,
		Categories = {},
		SortedCategories = {},
		ClassTotals = {},
		Items = {},
	};
end

function CalendarAttendanceList_RemoveCategory(pAttendanceList, pCategoryID)
	local	vClassInfo = pAttendanceList.Categories[pCategoryID];
	
	if not vClassInfo then
		return false;
	end
	
	pAttendanceList.NumPlayers = pAttendanceList.NumPlayers - table.getn(vClassInfo.mAttendees);
	pAttendanceList.NumCategories = pAttendanceList.NumCategories - 1;
	
	-- Remove it from the sorted categories
	
	for vIndex, vCategoryID in pAttendanceList.SortedCategories do
		if vCategoryID == pCategoryID then
			table.remove(pAttendanceList.SortedCategories, vIndex);
		end
	end

	pAttendanceList.Categories[pCategoryID] = nil;
	return true;
end

function CalendarAttendanceList_AddItem(pAttendanceList, pCategoryID, pItem)
	if not pItem then
		Calendar_ErrorMessage("CalendarAttendanceList_AddItem: pItem is nil");
		return;
	end
	
	if not pCategoryID then
		Calendar_ErrorMessage("CalendarAttendanceList_AddItem: pCategoryID is nil");
		return;
	end
	
	local	vClassInfo = pAttendanceList.Categories[pCategoryID];
	
	if not vClassInfo then
		vClassInfo = {mCount = 1, mClassCode = pCategoryID, mAttendees = {}};
		pAttendanceList.Categories[pCategoryID] = vClassInfo;
		table.insert(pAttendanceList.SortedCategories, pCategoryID);
		
		pAttendanceList.NumCategories = pAttendanceList.NumCategories + 1;
	else
		vClassInfo.mCount = vClassInfo.mCount + 1;
	end
	
	pAttendanceList.NumPlayers = pAttendanceList.NumPlayers + 1;
	
	table.insert(vClassInfo.mAttendees, pItem);
end

function CalendarAttendanceList_AddPlayer(pAttendanceList, pPlayer)
	return CalendarAttendanceList_AddItem(pAttendanceList, pPlayer.mClassCode, pPlayer);
end

function CalendarAttendanceList_AddWhisper(pAttendanceList, pPlayerName, pWhispers)
	local	vPlayer =
	{
		mName = pPlayerName,
		mWhispers = pWhispers.mWhispers,
	};
	
	local	vGuildMemberIndex = CalendarNetwork_GetGuildMemberIndex(pPlayerName);
	
	if vGuildMemberIndex then
		local	vMemberName, vRank, vRankIndex,
				vLevel, vClass, vZone, vNote,
				vOfficerNote, vOnline = GetGuildRosterInfo(vGuildMemberIndex);
		
		vPlayer.mLevel = vLevel;
		vPlayer.mClassCode = EventDatabase_GetClassCodeByClass(vClass);
		vPlayer.mZone = vZone;
		vPlayer.mOnline = vOnline;
	end
	
	vPlayer.mDate = pWhispers.mDate;
	vPlayer.mTime = pWhispers.mTime;
	vPlayer.mType = "Whisper";
	
	return CalendarAttendanceList_AddItem(
			pAttendanceList,
			"WHISPERS",
			vPlayer);
end

function CalendarAttendanceList_AddEventAttendanceItems(pAttendanceList, pDatabase, pEvent)
	if not pEvent.mAttendance then
		return;
	end
	
	for vAttendeeName, vRSVPString in pEvent.mAttendance do
		local	vRSVP = EventDatabase_UnpackEventRSVP(pDatabase.UserName, vAttendeeName, pEvent.mID, vRSVPString);
		
		pAttendanceList.Items[vRSVP.mName] = vRSVP;
	end
end

function CalendarAttendanceList_AddPendingRequests(pAttendanceList, pDatabase, pEvent)
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		if EventDatabase_DatabaseIsVisible(vDatabase) then
			local	vPendingRSVP = EventDatabase_FindRSVPRequestData(vDatabase, pDatabase.UserName, pEvent.mID);
			
			if vPendingRSVP then
				if vPendingRSVP.mStatus == "Y" then
					vPendingRSVP.mStatus = "P";
				end
				
				CalendarAttendanceList_AddItem(pAttendanceList, "PENDING", vPendingRSVP);
			end
		end
	end
end

function CalendarAttendanceList_CalculateClassTotals(pAttendanceList, pIsAttendingFunction)
	pAttendanceList.ClassTotals = {};
	
	for vName, vItem in pAttendanceList.Items do
		if vItem.mClassCode
		and pIsAttendingFunction(vItem) then
			local	vTotal = pAttendanceList.ClassTotals[vItem.mClassCode];
			
			if not vTotal then
				pAttendanceList.ClassTotals[vItem.mClassCode] = 1;
			else
				pAttendanceList.ClassTotals[vItem.mClassCode] = vTotal + 1;
			end
		end
	end
end

function CalendarAttendanceList_RSVPIsAttending(pItem)
	return pItem.mStatus ~= "-"
	   and pItem.mStatus ~= "N"
	   and pItem.mStatus ~= "C";
end

function CalendarAttendanceList_FindItem(pAttendanceList, pFieldName, pFieldValue, pCategoryID)
	if not pAttendanceList then
		return nil;
	end
	
	if not pFieldValue then
		Calendar_DebugMessage("CalendarAttendanceList_FindItem: pFieldValue is nil for "..pFieldName);
		return nil;
	end
	
	local	vLowerFieldValue = strlower(pFieldValue);
	
	-- Search all categories if none is specified
	
	if not pCategoryID then
		for vCategoryID, vCategoryInfo in pAttendanceList.Categories do
			for vIndex, vItem in vCategoryInfo.mAttendees do
				local	vItemFieldValue = vItem[pFieldName];
				
				if vItemFieldValue
				and strlower(vItemFieldValue) == vLowerFieldValue then
					return vItem;
				end
			end
		end
	
	-- Search the specified category
	
	else
		local	vCategoryInfo = pAttendanceList.Categories[pCategoryID];
		
		if not vCategoryInfo then
			return nil;
		end
		
		for vIndex, vItem in vCategoryInfo.mAttendees do
			if strlower(vItem[pFieldName]) == vLowerFieldValue then
				return vItem;
			end
		end
	end
	
	return nil;
end

GroupCalendar_cSortByFlags =
{
	Date = {Class = true, Rank = false},
	Rank = {Class = true, Rank = true},
	Name = {Class = false, Rank = false, Name = true},
	
	Status = {Class = true, Rank = false},
	ClassRank = {Class = true, Rank = true},
	DateRank = {Class = true, Rank = true},
};

function CalendarAttendanceList_SortIntoCategories(pAttendanceList, pGetItemCategoryFunction)
	-- Clear the existing categories
	
	pAttendanceList.Categories = {};
	pAttendanceList.SortedCategories = {};
	
	--
	
	local	vTotalAttendees = 0;
	
	for vName, vItem in pAttendanceList.Items do
		local	vCategoryID = pGetItemCategoryFunction(vItem);
		
		if vCategoryID then
			if vCategoryID ~= "NO" then
				vTotalAttendees = vTotalAttendees + 1;
			end
			
			CalendarAttendanceList_AddItem(pAttendanceList, pGetItemCategoryFunction(vItem), vItem);
		end
	end
	
	pAttendanceList.NumAttendees = vTotalAttendees;
end

function CalendarAttendanceList_GetRSVPStatusCategory(pItem)
	-- Skip RSVPs which are supposed to be ignored
	
	if pItem.mStatus == "-"
	or pItem.mStatus == "C" then
		return nil;
	end
	
	if pItem.mStatus == "N" then
		return "NO";
	elseif pItem.mStatus == "S" then
		return "STANDBY";
	elseif pItem.mStatus == "Q" then
		return "QUEUED";
	else
		return "YES";
	end
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

function CalendarAttendanceList_GetRSVPRankCategory(pItem)
	local	vCategoryID = CalendarAttendanceList_GetRSVPStatusCategory(pItem);
	
	if not vCategoryID then
		return nil;
	end
	
	if vCategoryID ~= "YES" then
		return vCategoryID;
	end
	
	vCategoryID = EventDatabase_MapGuildRank(pItem.mGuild, pItem.mGuildRank);
	
	if vCategoryID then
		return vCategoryID;
	end
	
	return "?";
end

function CalendarEvent_GetAttendanceCounts(pDatabase, pEvent, pUseClassCategories)
	local	vAttendanceList = CalendarAttendanceList_New();
	
	-- Fill in the items list
	
	CalendarAttendanceList_AddEventAttendanceItems(vAttendanceList, pDatabase, pEvent);
	
	-- Sort into categories
	
	local	vGetItemCategoryFunction;
	
	if pUseClassCategories then
		vGetItemCategoryFunction = CalendarAttendanceList_GetRSVPClassCategory;
	else
		vGetItemCategoryFunction = CalendarAttendanceList_GetRSVPStatusCategory;
	end
	
	CalendarAttendanceList_SortIntoCategories(vAttendanceList, vGetItemCategoryFunction);
	
	-- Add pending requests
	
	CalendarAttendanceList_AddPendingRequests(vAttendanceList, pDatabase, pEvent);
	
	-- Calculate class totals
	
	CalendarAttendanceList_CalculateClassTotals(vAttendanceList, CalendarAttendanceList_RSVPIsAttending);
	
	-- Done
	
	return vAttendanceList;
end

function CalendarEvent_SortAttendanceCounts(pAttendanceCounts, pSortBy)
	local	vSortByClass, vSortByRank, vSortByName;
	
	if pSortBy then
		local	vSortByFlags = GroupCalendar_cSortByFlags[pSortBy];
		
		if not vSortByFlags then
			Calendar_ErrorMessage("CalendarEvent_SortAttendanceCounts: Unknown sort "..pSortBy);
			return;
		end
		
		vSortByClass = vSortByFlags.Class;
		vSortByRank = vSortByFlags.Rank;
		vSortByName = vSortByFlags.Name;
	else
		vSortByClass = EventDatabase_IsQuestingEventType(pEvent.mType);
		vSortByRank = false;
		vSortByName = false;
	end
	
	-- Sort the categories
	
	if vSortByClass then
		table.sort(pAttendanceCounts.SortedCategories, EventDatabase_CompareClassCodes);
	else
		table.sort(pAttendanceCounts.SortedCategories, EventDatabase_CompareRankCodes);
	end
	
	-- Sort the attendance within each category
	
	local	vCompareFunction;
	
	if vSortByName then
		vCompareFunction = EventDatabase_CompareRSVPsByName;
	elseif vSortByClass and vSortByRank then
		vCompareFunction = EventDatabase_CompareRSVPsByRankAndDate;
	else
		vCompareFunction = EventDatabase_CompareRSVPsByDate;
	end
	
	if vSortByClass and vSortByRank then
	end
	
	for vCategory, vClassInfo in pAttendanceCounts.Categories do
		table.sort(vClassInfo.mAttendees, vCompareFunction);
	end
end

function EventAvailableSlots_InitializeFromLimits(pLimits)
	local	vAvailableSlots = {ClassInfo = {}};
	local	vMinTotal = 0;
	
	for vClassCode, vClassCodeInfo in gGroupCalendar_ClassInfoByClassCode do
		local	vClassAvailable = nil;
		local	vClassExtrasAvailable = nil;
		
		if pLimits
		and pLimits.mClassLimits then
			local	vClassLimits = pLimits.mClassLimits[vClassCode];
			
			if vClassLimits then
				if vClassLimits.mMin then
					vClassAvailable = vClassLimits.mMin;
					
					if vClassAvailable < 0 then
						vClassAvailable = 0;
					end
					
					vMinTotal = vMinTotal + vClassLimits.mMin;
				end
				
				if vClassLimits.mMax then
					vClassExtrasAvailable = vClassLimits.mMax;
					
					if vClassAvailable then
						vClassExtrasAvailable = vClassExtrasAvailable - vClassAvailable;
					end
					
					if vClassExtrasAvailable < 0 then
						vClassExtrasAvailable = 0;
					end
				end
				
				vClassMax = vClassLimits.mMax;
			end
		end
		
		if vClassAvailable
		or vClassExtrasAvailable then
			vAvailableSlots.ClassInfo[vClassCode] = {};
			vAvailableSlots.ClassInfo[vClassCode].Available = vClassAvailable;
			vAvailableSlots.ClassInfo[vClassCode].ExtrasAvailable = vClassExtrasAvailable;
		end
	end
	
	if pLimits
	and pLimits.mMaxAttendance then
		vAvailableSlots.TotalExtras = pLimits.mMaxAttendance - vMinTotal;
		if vAvailableSlots.TotalExtras < 0 then
			vAvailableSlots.TotalExtras = 0;
		end
	else
		vAvailableSlots.TotalExtras = nil;
	end
	
	return vAvailableSlots;
end

function CalendarEvent_PlayerClassAdded(pAvailableSlots, pClassCode)
	CalendarEvent_PlayerClassMultiAdded(pAvailableSlots, pClassCode, 1);
end

function CalendarEvent_PlayerClassMultiAdded(pAvailableSlots, pClassCode, pNumAdded)
	local	vNumAdded = pNumAdded;
	local	vClassInfo = pAvailableSlots.ClassInfo[pClassCode];
	
	if vNumAdded == 0 then	
		return;
	end
	
	-- If the class hasn't reached its minimum yet then accept the request
	
	if vClassInfo
	and vClassInfo.Available
	and vClassInfo.Available > 0 then
		local	vAvailableUsed = vNumAdded;
		
		if vAvailableUsed > vClassInfo.Available then
			vAvailableUsed = vClassInfo.Available;
		end
		
		vClassInfo.Available = vClassInfo.Available - vAvailableUsed;
		vNumAdded = vNumAdded - vAvailableUsed;
		
		if vNumAdded == 0 then
			return;
		end
	end
	
	-- Nothing to do if there are no limits
	
	if not pAvailableSlots.TotalExtras then
		return;
	end
	
	-- Have to bail if total extras is now zero
	
	if pAvailableSlots.TotalExtras == 0 then
		return;
	end
	
	-- Decrease the space for the class
	
	if vClassInfo
	and vClassInfo.ExtrasAvailable
	and vClassInfo.ExtrasAvailable > 0 then
		if vNumAdded > vClassInfo.ExtrasAvailable then
			vNumAdded = vClassInfo.ExtrasAvailable;
		end
		
		vClassInfo.ExtrasAvailable = vClassInfo.ExtrasAvailable - vNumAdded;
	end
	
	-- Decrease the total available extras
	
	pAvailableSlots.TotalExtras = pAvailableSlots.TotalExtras - vNumAdded;
end

function EventAvailableSlots_AcceptPlayer(pAvailableSlots, pClassCode)
	local	vClassInfo = pAvailableSlots.ClassInfo[pClassCode];

	-- If the class hasn't reached its minimum yet then accept the request
	
	if vClassInfo
	and vClassInfo.Available
	and vClassInfo.Available > 0 then
		vClassInfo.Available = vClassInfo.Available - 1;
		return true;
	end
	
	-- If the minimum has been reached and the extra slots haven't all
	-- been filled then accept the request
	
	if pAvailableSlots.TotalExtras then
		-- Put them on standby if the extras slots have all been filled
		
		if pAvailableSlots.TotalExtras == 0 then
			return false;
		end
		
		-- If the class has a max and it's been reached then put them
		-- on standby
		
		if vClassInfo
		and vClassInfo.ExtrasAvailable then
			if vClassInfo.ExtrasAvailable == 0 then
				return false;
			end
			
			vClassInfo.ExtrasAvailable = vClassInfo.ExtrasAvailable - 1;
		end
		
		pAvailableSlots.TotalExtras = pAvailableSlots.TotalExtras - 1;
		return true;
	end
	
	-- No limits at all, just accept them
	
	return true;
end

function EventAvailableSlots_CountSlots(pDatabase, pEvent)
	local	vAvailableSlots = EventAvailableSlots_InitializeFromLimits(pEvent.mLimits);
	local	vAttendanceCounts = CalendarEvent_GetAttendanceCounts(pDatabase, pEvent, true);
	
	for vCategory, vClassInfo in vAttendanceCounts.Categories do
		if vCategory ~= "NO"
		and vCategory ~= "STANDBY" then
			CalendarEvent_PlayerClassMultiAdded(vAvailableSlots, vCategory, table.getn(vClassInfo.mAttendees));
		end
	end
	
	return vAvailableSlots;
end

function EventDatabase_CompareRSVPsByDate(pRSVP1, pRSVP2)
	local	vRSVP1Date, vRSVP1Time = EventDatabase_GetRSVPOriginalDateTime(pRSVP1);
	local	vRSVP2Date, vRSVP2Time = EventDatabase_GetRSVPOriginalDateTime(pRSVP2);

	if not vRSVP1Date then
		return false;
	elseif not vRSVP2Date then
		return true;
	end
	
	if vRSVP1Date < vRSVP2Date then
		return true;
	elseif vRSVP1Date > vRSVP2Date then
		return false;
	elseif vRSVP1Time ~= vRSVP2Time then
		return vRSVP1Time < vRSVP2Time;
	else
		return EventDatabase_CompareRSVPsByName(pRSVP1, pRSVP2);
	end
end

function EventDatabase_CompareRSVPsByName(pRSVP1, pRSVP2)
	return pRSVP1.mName < pRSVP2.mName;
end

function EventDatabase_CompareRSVPsByRankAndDate(pRSVP1, pRSVP2)
	local	vRank1 = EventDatabase_MapGuildRank(pRSVP1.mGuild, pRSVP1.mGuildRank);
	local	vRank2 = EventDatabase_MapGuildRank(pRSVP2.mGuild, pRSVP2.mGuildRank);
	
	if not vRank1 then
		if not vRank2 then
			return EventDatabase_CompareRSVPsByDate(pRSVP1, pRSVP2);
		else
			return false;
		end
	elseif not vRank2 then
		return true;
	end
	
	if vRank1 == vRank2 then
		return EventDatabase_CompareRSVPsByDate(pRSVP1, pRSVP2);
	else
		return vRank1 < vRank2;
	end
end

Calendar_cClassCodeSortOrder =
{
	WHISPERS = 4,
	PENDING = 3,
	QUEUED = 2,
	YES = 1,
	STANDBY = -1,
	NO = -2,
};

function EventDatabase_CompareClassCodes(pClassCode1, pClassCode2)
	local	vSortPriority1 = Calendar_cClassCodeSortOrder[pClassCode1];
	local	vSortPriority2 = Calendar_cClassCodeSortOrder[pClassCode2];
	
	if not vSortPriority1 then
		if not vSortPriority2 then
			return EventDatabase_GetClassByClassCode(pClassCode1) < EventDatabase_GetClassByClassCode(pClassCode2);
		else
			return vSortPriority2 < 0;
		end
	elseif not vSortPriority2 then
		return vSortPriority1 > 0;
	else
		return vSortPriority1 > vSortPriority2;
	end
end

function EventDatabase_CompareRankCodes(pRank1, pRank2)
	local	vIsRank1 = type(pRank1) == "number";
	local	vIsRank2 = type(pRank2) == "number";
	
	if vIsRank1 and vIsRank2 then
		return pRank1 < pRank2;
	end
	
	if not vIsRank1 then
		if not vIsRank2 then
			return EventDatabase_CompareClassCodes(pRank1, pRank2);
		else
			return false;
		end
	end
	
	return true;
end

function EventDatabase_CreatePlayerRSVP(
				pDatabase, pEvent,
				pPlayerName,
				pPlayerRace, pPlayerClass, pPlayeLevel,
				pStatus,
				pComment,
				pGuild,
				pGuildRank,
				pAlts)
	local	vDate, vTime60 = EventDatabase_GetServerDateTime60Stamp();
	local	vAlts = nil;
	
	if pAlts then
		for vPlayerName, _ in pAlts do
			if vPlayerName ~= pPlayerName then
				if not vAlts then
					vAlts = {};
				end
				
				vAlts[vPlayerName] = true;
			end
		end
	end
	
	return
	{
		mName = pPlayerName,
		mOrganizerName = pDatabase.UserName,
		mEventID = pEvent.mID,
		mDate = vDate,
		mTime = vTime60,
		mStatus = pStatus,
		mComment = pComment,
		mRaceCode = pPlayerRace,
		mClassCode = pPlayerClass,
		mLevel = pPlayeLevel,
		mGuild = pGuild,
		mGuildRank = pGuildRank,
		mAlts = vAlts,
	};
end

function EventDatabase_PlayerLevelChanged(pPlayerLevel)
	if not gGroupCalendar_UserDatabase then
		return;
	end
	
	gGroupCalendar_UserDatabase.PlayerLevel = pPlayerLevel;
end

function EventDatabase_PlayerIsQualifiedForEvent(pEvent, pPlayerLevel)
	if not pPlayerLevel then
		return false;
	end
	
	if pEvent.mMinLevel and
	pPlayerLevel < pEvent.mMinLevel then
		return false;
	end
	
	if pEvent.mMaxLevel and
	pPlayerLevel > pEvent.mMaxLevel then
		return false;
	end
	
	return true;
end

function EventDatabase_RescheduleEvent(pDatabase, pEvent, pNewDate)
	local	vNewEvent = EventDatabase_NewEvent(pDatabase, pNewDate);
	
	vNewEvent.mType = pEvent.mType;
	vNewEvent.mTitle = pEvent.mTitle;

	vNewEvent.mTime = pEvent.mTime;
	vNewEvent.mDuration = pEvent.mDuration;

	vNewEvent.mDescription = pEvent.mDescription;

	vNewEvent.mMinLevel = pEvent.mMinLevel;
	vNewEvent.mAttendance = pEvent.mAttendance;

	EventDatabase_AddEvent(pDatabase, vNewEvent);

	return EventDatabase_DeleteEvent(pDatabase, pEvent);
end

function EventDatabase_DeleteOldEvents(pDatabase)
	if not pDatabase.Events then
		return;
	end
	
	for vDate, vEvents in pDatabase.Events do
		if vDate < gGroupCalendar_MinimumEventDate then
			-- Remove or reschedule the events for this date
			
			local	vNumEvents = table.getn(vEvents);
			local	vEventIndex = 1;
			
			for vIndex = 1, vNumEvents do
				local	vEvent = vEvents[vEventIndex];
				
				if pDatabase.IsPlayerOwned and vEvent.mType == "Birth" then
					Calendar_DebugMessage("GroupCalendar: Rescheduling birthday event "..vEvent.mID.." for "..pDatabase.UserName);
					
					local	vMonth, vDay, vYear = Calendar_ConvertDateToMDY(vDate);
					vYear = vYear + 1;
					local	vNewDate = Calendar_ConvertMDYToDate(vMonth, vDay, vYear);
					
					if not EventDatabase_RescheduleEvent(pDatabase, vEvent, vNewDate) then
						Calendar_DebugMessage("GroupCalendar: Can't reschedule event "..vEvent.mID.." for "..pDatabase.UserName..": Unknown error");
						vEventIndex = vEventIndex + 1;
					end
				elseif not EventDatabase_DeleteEvent(pDatabase, vEvent) then
					Calendar_DebugMessage("GroupCalendar: Can't delete old event "..vEvent.mID.." for "..pDatabase.UserName..": Unknown error");
					vEventIndex = vEventIndex + 1;
				end
			end
		end
	end
end

function EventDatabase_PlayerIsAttendingEvent(pEventOwner, pEvent)
	for vPlayerName, vPlayerValue in gGroupCalendar_PlayerCharacters do
		local	vPlayerDatabase = EventDatabase_GetDatabase(vPlayerName, false);
		local	vRSVP = nil;
		
		if vPlayerDatabase then
			vRSVP = EventDatabase_FindRSVPRequestData(vPlayerDatabase, pEventOwner, pEvent.mID);
		end
		
		if not vRSVP then
			vRSVP = EventDatabase_FindEventRSVP(pEventOwner, pEvent, vPlayerName);
		end
		
		if vRSVP then
			local	vStatus1 = string.sub(vRSVP.mStatus, 1, 1);
			
			if vStatus1 == "Y" then
				return true;
			end
		end
	end
	

	return false;
end

function EventDatabase_RemoveSavedInstanceEvents(pDatabase)
	for vDate, vSchedule in pDatabase.Events do
		local	vEventIndex = 1;
		local	vNumEvents = table.getn(vSchedule);
		
		while vEventIndex <= vNumEvents do
			local	vEvent = vSchedule[vEventIndex];
			
			if EventDatabase_IsDungeonResetEventType(vEvent.mType) then
				EventDatabase_DeleteEvent(pDatabase, vEvent);
				vNumEvents = vNumEvents - 1;
			else
				vEventIndex = vEventIndex + 1;
			end
		end
	end
end

function EventDatabase_RemoveTradeskillEventByType(pDatabase, pEventType)
	for vDate, vSchedule in pDatabase.Events do
		local	vEventIndex = 1;
		local	vNumEvents = table.getn(vSchedule);
		
		while vEventIndex <= vNumEvents do
			local	vEvent = vSchedule[vEventIndex];
			
			if vEvent.mType == pEventType then
				EventDatabase_DeleteEvent(pDatabase, vEvent);
				vNumEvents = vNumEvents - 1;
			else
				vEventIndex = vEventIndex + 1;
			end
		end
	end
end

function EventDatabase_ScheduleResetEvent(pDatabase, pType, pResetDate, pResetTime)
	local	vEvent = EventDatabase_NewEvent(pDatabase, pResetDate);
	
	vEvent.mType = pType;
	vEvent.mPrivate = true;
	vEvent.mTime = pResetTime;
	vEvent.mDuration = nil;
	
	EventDatabase_AddEvent(pDatabase, vEvent);
end

function EventDatabase_ScheduleSavedInstanceEvent(pDatabase, pName, pResetDate, pResetTime)
	local	vType = EventDatabase_LookupDungeonResetEventTypeByName(pName);
	
	if not vType then
		Calendar_DebugMessage("GroupCalendar: Can't schedule reset event for "..pName..": The instance name is not recognized");
		return;
	end
	
	EventDatabase_ScheduleResetEvent(pDatabase, vType, pResetDate, pResetTime);
end

function EventDatabase_ScheduleTradeskillCooldownEvent(pDatabase, pTradeskillID, pCooldownSeconds)
	local	vType = EventDatabase_LookupTradeskillEventTypeByID(pTradeskillID);
	local	vResetDate, vResetTime = Calendar_GetServerDateTimeFromSecondsOffset(pCooldownSeconds);
	
	EventDatabase_RemoveTradeskillEventByType(pDatabase, vType);
	EventDatabase_ScheduleResetEvent(pDatabase, vType, vResetDate, vResetTime);
end

function EventDatabase_UpdateTradeskillCooldown(pDatabase, pTradeskillID)
	local	vCooldown = Calendar_GetTradeskillCooldown(pTradeskillID);
	
	if vCooldown then
		EventDatabase_ScheduleTradeskillCooldownEvent(pDatabase, pTradeskillID, vCooldown)
	end
end

function EventDatabase_UpdateCurrentTradeskillCooldown()
	local	vTradeskillName, vCurrentLevel, vMaxLevel = GetTradeSkillLine();
	
	if not vTradeskillName then
		return;
	end
	
	local	vTradeskillID = Calendar_LookupTradeskillIDByName(vTradeskillName);
	
	if not vTradeskillID then
		return;
	end
	
	EventDatabase_UpdateTradeskillCooldown(gGroupCalendar_UserDatabase, vTradeskillID);
end

function EventDatabase_MapGuildRank(pFromGuild, pFromRank)
	if not pFromGuild
	or not pFromRank then
		return nil;
	end
	
	-- If it's the same guild then just return the rank
	
	if pFromGuild == gGroupCalendar_PlayerGuild then
		return pFromRank;
	end
	
	-- Force to zero if not in any guild
	
	if not IsInGuild() then
		return nil;
	end
	
	-- Just cover our eyes if the roster isn't loaded yet
	
	if GetNumGuildMembers() == 0 then
		CalendarNetwork_LoadGuildRoster();
		return pFromRank;
	end
	
	local	vMaxGuildRank = GuildControlGetNumRanks() - 1;
	
	-- Get the mapping
	
	local	vToRankMap;

	if gGroupCalendar_RealmSettings.RankMap then
		vToRankMap = gGroupCalendar_RealmSettings.RankMap[gGroupCalendar_PlayerGuild];
	end
	
	local	vRankMap;
	
	if vToRankMap then
		vRankMap = vToRankMap[pFromGuild];
	end
	
	if vRankMap then
		local	vToRank = vRankMap[pFromRank];
		
		if vToRank then
			return vToRank;
		end
		
		-- If there's not a mapping for this rank, map it to the
		-- same value as the next highest rank
		
		for vFromRank, vToRank in vRankMap do
			if vFromRank > pFromRank then
				return vToRank;
			end
		end
	end
	
	-- Do a dumb mapping which simply ensures that the rank index
	-- is valid for the current guild
	
	if pFromRank > vMaxGuildRank then
		return vMaxGuildRank;
	else
		return pFromRank;
	end
end

function EventDatabase_SetGuildRankMapping(pFromGuild, pFromRank, pToRank)
	if not pFromGuild
	or pFromGuild == ""
	or not pFromRank then
		return;
	end
	
	-- If it's the same guild then there's nothing to do
	
	if pFromGuild == gGroupCalendar_PlayerGuild then
		return;
	end
	
	-- Make sure the maps exist
	
	if not gGroupCalendar_RealmSettings.RankMap then
		gGroupCalendar_RealmSettings.RankMap = {};
	end
	
	-- Make sure the to guild map exists
	
	local	vToGuildMap = gGroupCalendar_RealmSettings.RankMap[gGroupCalendar_PlayerGuild];
	
	if not vToGuildMap then
		vToGuildMap = {};
		gGroupCalendar_RealmSettings.RankMap[gGroupCalendar_PlayerGuild] = vToGuildMap;
	end
	
	-- Make sure the from guild map exists
	
	local	vGuildMap = vToGuildMap[pFromGuild];
	
	if not vGuildMap then
		vGuildMap = {};
		vToGuildMap[pFromGuild] = vGuildMap;
	end
	
	vGuildMap[pFromRank] = pToRank;
end

function EventDatabase_UpdateGuildRankCache()
	if not gGroupCalendar_PlayerGuild
	or not gGroupCalendar_Initialized then
		return;
	end
	
	if not gGroupCalendar_RealmSettings.GuildRanks then
		gGroupCalendar_RealmSettings.GuildRanks = {};
	end
	
	vGuildRanks = {};
	
	local	vNumRanks = GuildControlGetNumRanks();
	
	for vIndex = 1, vNumRanks do
		vGuildRanks[vIndex - 1] = GuildControlGetRankName(vIndex);
	end
	
	gGroupCalendar_RealmSettings.GuildRanks[gGroupCalendar_PlayerGuild] = vGuildRanks;
end

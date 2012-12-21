gGroupCalendar_VersionString = "2.0";

GroupCalendar_cTitle = "Group Calendar v%s";

GroupCalendar_cSun = "Sun";
GroupCalendar_cMon = "Mon";
GroupCalendar_cTue = "Tue";
GroupCalendar_cWed = "Wed";
GroupCalendar_cThu = "Thu";
GroupCalendar_cFri = "Fri";
GroupCalendar_cSat = "Sat";

GroupCalendar_cSunday = "Sunday";
GroupCalendar_cMonday = "Monday";
GroupCalendar_cTuesday = "Tuesday";
GroupCalendar_cWednesday = "Wednesday";
GroupCalendar_cThursday = "Thursday";
GroupCalendar_cFriday = "Friday";
GroupCalendar_cSaturday = "Saturday";

GroupCalendar_cSelfWillAttend = "%s will attend";

GroupCalendar_cMonthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday};

GroupCalendar_cLoadMessage = "GroupCalendar loaded.  Use /calendar to view the calendar";
GroupCalendar_cInitializingGuilded = "GroupCalendar: Initializing settings for guilded player";
GroupCalendar_cInitializingUnguilded = "GroupCalendar: Initializing settings for unguilded player";
GroupCalendar_cLocalTimeNote = "(%s local)";

GroupCalendar_cOptions = "Setup...";

GroupCalendar_cCalendar = "Calendar";
GroupCalendar_cChannel = "Channel";
GroupCalendar_cTrust = "Trust";
GroupCalendar_cAbout = "About";

GroupCalendar_cUseServerDateTime = "Use server dates and times";
GroupCalendar_cUseServerDateTimeDescription = "Turn on to show events using the server date and time, turn off to use your local date and time";

GroupCalendar_cChannelConfigTitle = "Data Channel Setup";
GroupCalendar_cChannelConfigDescription = "The calendar data channel is used to send and receive events between players.  Anyone able to join the channel will be able to see your events if they choose to.  To keep your calendar private a channel password should be used.";
GroupCalendar_cAutoChannelConfig = "Automatic channel configuration";
GroupCalendar_cManualChannelConfig = "Manual channel configuration";
GroupCalendar_cStoreAutoConfig = "Store auto. config data in player note";
GroupCalendar_cAutoConfigPlayer = "Player name:";
GroupCalendar_cApplyChannelChanges = "Apply Changes";
GroupCalendar_cAutoConfigTipTitle = "Automatic Channel Configuration";
GroupCalendar_cAutoConfigTipDescription = "Automatically gets channel information from your guilds roster.  You must be in a guild and the feature must be configured by a guild officer in order to use this.";
GroupCalendar_cManualConfigTipDescription = "Allows you to manually enter the channel and password information.";
GroupCalendar_cStoreAutoConfigTipDescription = "Allows a guild officer to store channel configuration information in the selected players note in the guild roster.";
GroupCalendar_cAutoConfigPlayerTipDescription = "The name of the player in the guild roster containing the channel configuration data.";
GroupCalendar_cChannelNameTipTitle = "Channel name";
GroupCalendar_cChannelNameTipDescription = "The name of the chat channel which will be used to send and receive event data from other players";
GroupCalendar_cConnectChannel = "Connect";
GroupCalendar_cDisconnectChannel = "Disconnect";
GroupCalendar_cChannelStatus =
{
	Starting = {mText = "Status: Starting up...", mColor = {r = 1, g = 1, b = 0.3}},
	Connected = {mText = "Status: Data channel is connected", mColor = {r = 0.3, g = 1, b = 0.3}},
	Disconnected = {mText = "Status: Data channel is not connected", mColor = {r = 1, g = 0.5, b = 0.2}},
	Initializing = {mText = "Status: Initializing data channel", mColor = {r = 1, g = 1, b = 0.3}},
	Error = {mText = "Error: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
};

GroupCalendar_cConnected = "Connected";
GroupCalendar_cDisconnected = "Disconnected";
GroupCalendar_cTooManyChannels = "You have already joined the maximum number of channels";
GroupCalendar_cJoinChannelFailed = "Failed to join the channel for an unknown reason";
GroupCalendar_cWrongPassword = "The password is incorrect";
GroupCalendar_cAutoConfigNotFound = "Configuration data not found in the guild roster";
GroupCalendar_cErrorAccessingNote = "Couldn't retrieve configuration data";

GroupCalendar_cTrustConfigTitle = "Trust Setup";
GroupCalendar_cTrustConfigDescription = "Trust determines who you allow to provide you with events.  It does NOT limit who can see events in your calendar.  Use a password on the data channel to restrict who can see your calendar.";
GroupCalendar_cTrustGroupLabel = "Trust:";
GroupCalendar_cEvent = "Event";
GroupCalendar_cAttendance = "Attendance";

GroupCalendar_cAboutTitle = "About Group Calendar";
GroupCalendar_cTitleVersion = "Group Calendar v"..gGroupCalendar_VersionString;
GroupCalendar_cAuthor = "Designed and written by Baylord of Thunderlord";
GroupCalendar_cTestersTitle = "Testers";
GroupCalendar_cTestersNames = "Agnosbear, Airmid, Chalay, Drizztt, Fizzlebang, Lifegiver, Mistwalker, Powerhouse, Ragdzar, Saracen, Thoros and Zya";
GroupCalendar_cSpecialThanksTitle = "Special thanks for their extraordinary support to";
GroupCalendar_cSpecialThanksNames = "Agnosbear, Fizzlebang, Mistwalker and SFC Alliance";
GroupCalendar_cGuildURL = "http://www.starfleetclan.com";
GroupCalendar_cRebuildDatabase = "Rebuild Database";
GroupCalendar_cRebuildDatabaseDescription = "Rebuilds the event database for your character.  This may solve problems with people not seeing all of your events, but there is a slight risk that some event attendance replies could get lost.";

GroupCalendar_cTrustGroups =
{
	"Anyone who has access to the data channel",
	"Other members of your guild",
	"Only those explicitly listed below"
};

GroupCalendar_cTrustAnyone = "Trust anyone who has access to the data channel";
GroupCalendar_cTrustGuildies = "Trust other members of your guild";
GroupCalendar_cTrustMinRank = "Minimum rank:";
GroupCalendar_cTrustNobody = "Trust only those explicitly listed below";
GroupCalendar_cTrustedPlayers = "Additional players";
GroupCalendar_cExcludedPlayers = "Excluded players"
GroupCalendar_cPlayerName = "Player name:";
GroupCalendar_cAddTrusted = "Trust";
GroupCalendar_cRemoveTrusted = "Remove";
GroupCalendar_cAddExcluded = "Exclude";

CalendarEventViewer_cTitle = "View Event";
CalendarEventViewer_cDone = "Done";

CalendarEventViewer_cLevelRangeFormat = "Levels %i to %i";
CalendarEventViewer_cMinLevelFormat = "Levels %i and up";
CalendarEventViewer_cMaxLevelFormat = "Up to level %i";
CalendarEventViewer_cAllLevels = "All levels";
CalendarEventViewer_cSingleLevel = "Level %i only";

CalendarEventViewer_cYes = "Yes! I will attend this event";
CalendarEventViewer_cNo = "No. I won't attend this event";

CalendarEventViewer_cResponseMessage =
{
	"Status: No response sent",
	"Status: Waiting for confirmation",
	"Status: Confirmed - Accepted",
	"Status: Confirmed - On standy",
	"Status: Confirmed - Rejected",
};

CalendarEventEditorFrame_cTitle = "Add/Edit Event";
CalendarEventEditor_cDone = "Done";
CalendarEventEditor_cDelete = "Delete";
CalendarEventEditor_cGroupTabTitle = "Group";

CalendarEventEditor_cConfirmDeleteMsg = "Delete \"%s\"?";

-- Event names

GroupCalendar_cGeneralEventGroup = "General";
GroupCalendar_cDungeonEventGroup = "Dungeons";
GroupCalendar_cBattlegroundEventGroup = "Battlegrounds";

GroupCalendar_cMeetingEventName = "Meeting";
GroupCalendar_cBirthdayEventName = "Birthday";

GroupCalendar_cAQREventName = "Ahn'Qiraj Ruins";
GroupCalendar_cAQTEventName = "Ahn'Qiraj Temple";
GroupCalendar_cBFDEventName = "Blackfathom Deeps";
GroupCalendar_cBRDEventName = "Blackrock Depths";
GroupCalendar_cUBRSEventName = "Blackrock Spire (Upper)";
GroupCalendar_cLBRSEventName = "Blackrock Spire (Lower)";
GroupCalendar_cBWLEventName = "Blackwing Lair";
GroupCalendar_cDeadminesEventName = "The Deadmines";
GroupCalendar_cDMEventName = "Dire Maul";
GroupCalendar_cGnomerEventName = "Gnomeregan";
GroupCalendar_cMaraEventName = "Maraudon";
GroupCalendar_cMCEventName = "Molten Core";
GroupCalendar_cOnyxiaEventName = "Onyxia's Lair";
GroupCalendar_cRFCEventName = "Ragefire Chasm";
GroupCalendar_cRFDEventName = "Razorfen Downs";
GroupCalendar_cRFKEventName = "Razorfen Kraul";
GroupCalendar_cSMEventName = "Scarlet Monastery";
GroupCalendar_cScholoEventName = "Scholomance";
GroupCalendar_cSFKEventName = "Shadowfang Keep";
GroupCalendar_cStockadesEventName = "The Stockades";
GroupCalendar_cStrathEventName = "Stratholme";
GroupCalendar_cSTEventName = "The Sunken Temple";
GroupCalendar_cUldEventName = "Uldaman";
GroupCalendar_cWCEventName = "Wailing Caverns";
GroupCalendar_cZFEventName = "Zul'Farrak";
GroupCalendar_cZGEventName = "Zul'Gurub";

GroupCalendar_cABEventName = "Arathi Basin";
GroupCalendar_cAVEventName = "Alterac Valley";
GroupCalendar_cWSGEventName = "Warsong Gulch";

GroupCalendar_cZGResetEventName = "Zul'Gurub Resets";
GroupCalendar_cMCResetEventName = "Molten Core Resets";
GroupCalendar_cOnyxiaResetEventName = "Onyxia Resets";
GroupCalendar_cBWLResetEventName = "Blackwing Lair Resets";
GroupCalendar_cAQRResetEventName = "Ahn'Qiraj Ruins Resets";
GroupCalendar_cAQTResetEventName = "Ahn'Qiraj Temple Resets";

GroupCalendar_cTransmuteCooldownEventName = "Transmute Available";
GroupCalendar_cSaltShakerCooldownEventName = "Salt Shaker Available";
GroupCalendar_cMoonclothCooldownEventName = "Mooncloth Available";
GroupCalendar_cSnowmasterCooldownEventName = "SnowMaster 9000 Available";

GroupCalendar_cPersonalEventOwner = "Private";

GroupCalendar_cRaidInfoMCName = GroupCalendar_cMCEventName;
GroupCalendar_cRaidInfoOnyxiaName = "Onyxias Lair Instance";
GroupCalendar_cRaidInfoZGName = "Zul'gurub";
GroupCalendar_cRaidInfoBWLName = GroupCalendar_cBWLEventName;
GroupCalendar_cRaidInfoAQRName = "Ahn'Qiraj";
GroupCalendar_cRaidInfoAQTName = GroupCalendar_cAQTEventName;

-- Race names

GroupCalendar_cDwarfRaceName = "Dwarf";
GroupCalendar_cGnomeRaceName = "Gnome";
GroupCalendar_cHumanRaceName = "Human";
GroupCalendar_cNightElfRaceName = "Night Elf";
GroupCalendar_cOrcRaceName = "Orc";
GroupCalendar_cTaurenRaceName = "Tauren";
GroupCalendar_cTrollRaceName = "Troll";
GroupCalendar_cUndeadRaceName = "Undead";
GroupCalendar_cBloodElfRaceName = "Blood Elf";
GroupCalendar_cDraeneiRaceName = "Draenei";

-- Class names

GroupCalendar_cDruidClassName = "Druid";
GroupCalendar_cHunterClassName = "Hunter";
GroupCalendar_cMageClassName = "Mage";
GroupCalendar_cPaladinClassName = "Paladin";
GroupCalendar_cPriestClassName = "Priest";
GroupCalendar_cRogueClassName = "Rogue";
GroupCalendar_cShamanClassName = "Shaman";
GroupCalendar_cWarlockClassName = "Warlock";
GroupCalendar_cWarriorClassName = "Warrior";

-- Plural forms of class names

GroupCalendar_cDruidsClassName = "Druids";
GroupCalendar_cHuntersClassName = "Hunters";
GroupCalendar_cMagesClassName = "Mages";
GroupCalendar_cPaladinsClassName = "Paladins";
GroupCalendar_cPriestsClassName = "Priests";
GroupCalendar_cRoguesClassName = "Rogues";
GroupCalendar_cShamansClassName = "Shamans";
GroupCalendar_cWarlocksClassName = "Warlocks";
GroupCalendar_cWarriorsClassName = "Warriors";

-- ClassColorNames are the indices for the RAID_CLASS_COLORS array found in FrameXML\Fonts.xml
-- in the English version of WoW these are simply the class names in caps, I don't know if that's
-- true of other languages so I'm putting them here in case they need to be localized

GroupCalendar_cDruidClassColorName = "DRUID";
GroupCalendar_cHunterClassColorName = "HUNTER";
GroupCalendar_cMageClassColorName = "MAGE";
GroupCalendar_cPaladinClassColorName = "PALADIN";
GroupCalendar_cPriestClassColorName = "PRIEST";
GroupCalendar_cRogueClassColorName = "ROGUE";
GroupCalendar_cShamanClassColorName = "SHAMAN";
GroupCalendar_cWarlockClassColorName = "WARLOCK";
GroupCalendar_cWarriorClassColorName = "WARRIOR";

-- Label forms of the class names for the attendance panel.  Usually just the plural
-- form of the name followed by a colon

GroupCalendar_cDruidsLabel = GroupCalendar_cDruidsClassName..":";
GroupCalendar_cHuntersLabel = GroupCalendar_cHuntersClassName..":";
GroupCalendar_cMagesLabel = GroupCalendar_cMagesClassName..":";
GroupCalendar_cPaladinsLabel = GroupCalendar_cPaladinsClassName..":";
GroupCalendar_cPriestsLabel = GroupCalendar_cPriestsClassName..":";
GroupCalendar_cRoguesLabel = GroupCalendar_cRoguesClassName..":";
GroupCalendar_cShamansLabel = GroupCalendar_cShamansClassName..":";
GroupCalendar_cWarlocksLabel = GroupCalendar_cWarlocksClassName..":";
GroupCalendar_cWarriorsLabel = GroupCalendar_cWarriorsClassName..":";

GroupCalendar_cTimeLabel = "Time:";
GroupCalendar_cDurationLabel = "Duration:";
GroupCalendar_cEventLabel = "Event:";
GroupCalendar_cTitleLabel = "Title:";
GroupCalendar_cLevelsLabel = "Levels:";
GroupCalendar_cLevelRangeSeparator = "to";
GroupCalendar_cDescriptionLabel = "Description:";
GroupCalendar_cCommentLabel = "Comment:";

CalendarEditor_cNewEvent = "New Event...";
CalendarEditor_cEventsTitle = "Events";

GroupCalendar_cGermanTranslation = "German translation by Palyr of Silver Hand";
GroupCalendar_cFrenchTranslation = "French translation by Kisanth of Dalaran (EU)";
GroupCalendar_cChineseTranslation = "Chinese translation by Aska of Royaltia (HK)";

CalendarEventEditor_cNotAttending = "Not attending";
CalendarEventEditor_cConfirmed = "Confirmed";
CalendarEventEditor_cDeclined = "Declined";
CalendarEventEditor_cStandby = "On Standby List";
CalendarEventEditor_cPending = "Pending";
CalendarEventEditor_cUnknownStatus = "Unknown %s";

GroupCalendar_cChannelNameLabel = "Channel name:";
GroupCalendar_cPasswordLabel = "Password:";

GroupCalendar_cTimeRangeFormat = "%s to %s";

GroupCalendar_cPluralMinutesFormat = "%d minutes";
GroupCalendar_cSingularHourFormat = "%d hour";
GroupCalendar_cPluralHourFormat = "%d hours";
GroupCalendar_cSingularHourPluralMinutes = "%d hour %d minutes";
GroupCalendar_cPluralHourPluralMinutes = "%d hours %d minutes";

if string.sub(GetLocale(), -2) == "US" then
	GroupCalendar_cLongDateFormat = "$month $day, $year";
	GroupCalendar_cShortDateFormat = "$monthNum/$day";
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $month $day, $year";
else
	GroupCalendar_cLongDateFormat = "$day. $month $year";
	GroupCalendar_cShortDateFormat = "$day.$monthNum";
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $day. $month $year";
end

GroupCalendar_cNotAttending = "Not attending";
GroupCalendar_cAttending = "Attending";
GroupCalendar_cPendingApproval = "Pending requests and changes";
GroupCalendar_cStandby = "Standby";
GroupCalendar_Queued = "Processing";
GroupCalendar_cWhispers = "Recent whispers";

GroupCalendar_cQuestAttendanceNameFormat = "$name ($level $race)";
GroupCalendar_cMeetingAttendanceNameFormat = "$name ($level $class)";
GroupCalendar_cGroupAttendanceNameFormat = "$name ($status)";

GroupCalendar_cNumAttendeesFormat = "%d attendees";
GroupCalendar_cNumPlayersFormat = "%d players";

BINDING_HEADER_GROUPCALENDAR_TITLE = "Group Calendar";
BINDING_NAME_GROUPCALENDAR_TOGGLE = "Toggle GroupCalendar";

-- Tradeskill cooldown items

GroupCalendar_cHerbalismSkillName = "Herbalism";
GroupCalendar_cAlchemySkillName = "Alchemy";
GroupCalendar_cEnchantingSkillName = "Enchanting";
GroupCalendar_cLeatherworkingSkillName = "Leatherworking";
GroupCalendar_cSkinningSkillName = "Skinning";
GroupCalendar_cTailoringSkillName = "Tailoring";
GroupCalendar_cMiningSkillName = "Mining";
GroupCalendar_cBlacksmithingSkillName = "Blacksmithing";
GroupCalendar_cEngineeringSkillName = "Engineering";

GroupCalendar_cTransmuteMithrilToTruesilver = "Transmute: Mithril to Truesilver";
GroupCalendar_cTransmuteIronToGold = "Transmute: Iron to Gold";
GroupCalendar_cTransmuteLifeToEarth = "Transmute: Life to Earth";
GroupCalendar_cTransmuteWaterToUndeath = "Transmute: Water to Undeath";
GroupCalendar_cTransmuteWaterToAir = "Transmute: Water to Air";
GroupCalendar_cTransmuteUndeathToWater = "Transmute: Undeath to Water";
GroupCalendar_cTransmuteFireToEarth = "Transmute: Fire to Earth";
GroupCalendar_cTransmuteEarthToLife = "Transmute: Earth to Life";
GroupCalendar_cTransmuteEarthToWater = "Transmute: Earth to Water";
GroupCalendar_cTransmuteAirToFire = "Transmute: Air to Fire";
GroupCalendar_cTransmuteArcanite = "Transmute: Arcanite";
GroupCalendar_cMooncloth = "Mooncloth";

GroupCalendar_cCharactersLabel = "Character:";

GroupCalendar_cConfirmed = "Accepted";
GroupCalendar_cStandby = "Standby";
GroupCalendar_cDeclined = "Declined";
GroupCalendar_cRemove = "Remove";
GroupCalendar_cEditPlayer = "Edit Player...";
GroupCalendar_cInviteNow = "Inivte to group";
GroupCalendar_cStatus = "Status";
GroupCalendar_cAddPlayerEllipses = "Add player...";

GroupCalendar_cAddPlayer = "Add player";
GroupCalendar_cPlayerLevel = "Level:";
GroupCalendar_cPlayerClassLabel = "Class:";
GroupCalendar_cPlayerRaceLabel = "Race:";
GroupCalendar_cPlayerStatusLabel = "Status:";
GroupCalendar_cRankLabel = "Guild rank:";
GroupCalendar_cGuildLabel = "Guild:";
GroupCalendar_cSave = "Save";
GroupCalendar_cLastWhisper = "Last whisper:";
GroupCalendar_cReplyWhisper = "Whisper reply:";

GroupCalendar_cUnknown = "Unknown";
GroupCalendar_cAutoConfirmationTitle = "Automatic Confirmations";
GroupCalendar_cEnableAutoConfirm = "Enable automatic confirmations";
GroupCalendar_cMinLabel = "min";
GroupCalendar_cMaxLabel = "max";

GroupCalendar_cAddPlayerTitle = "Add...";
GroupCalendar_cAutoConfirmButtonTitle = "Settings...";

GroupCalendar_cClassLimitDescription = "Use the fields below to set minimum and maximum numbers for each class.  Classes which haven't met the minimum yet will be filled first, the extra spots will be filled in order of response until the maximums are reached.";

GroupCalendar_cViewByDate = "View by Date";
GroupCalendar_cViewByRank = "View by Rank";
GroupCalendar_cViewByName = "View by Name";
GroupCalendar_cViewByStatus = "View by Status";
GroupCalendar_cViewByClassRank = "View by Class and Rank";

GroupCalendar_cMaxPartySizeLabel = "Maximum party size:";
GroupCalendar_cMinPartySizeLabel = "Minimum party size:";
GroupCalendar_cNoMinimum = "No minimum";
GroupCalendar_cNoMaximum = "No maximum";
GroupCalendar_cPartySizeFormat = "%d players";

GroupCalendar_cInviteButtonTitle = "Invite Selected";
GroupCalendar_cAutoSelectButtonTitle = "Select Players...";
GroupCalendar_cAutoSelectWindowTitle = "Select Players";

GroupCalendar_cNoSelection = "No players selected";
GroupCalendar_cSingleSelection = "1 player selected";
GroupCalendar_cMultiSelection = "%d players selected";

GroupCalendar_cInviteNeedSelectionStatus = "Select players to be invited";
GroupCalendar_cInviteReadyStatus = "Ready to invite";
GroupCalendar_cInviteInitialInvitesStatus = "Sending initial invitations";
GroupCalendar_cInviteAwaitingAcceptanceStatus = "Waiting for initial acceptance";
GroupCalendar_cInviteConvertingToRaidStatus = "Converting to raid";
GroupCalendar_cInviteInvitingStatus = "Sending invitations";
GroupCalendar_cInviteCompleteStatus = "Invitations completed";
GroupCalendar_cInviteReadyToRefillStatus = "Ready to fill vacant slots";
GroupCalendar_cInviteNoMoreAvailableStatus = "No more players available to fill the group";
GroupCalendar_cRaidFull = "Raid full";

GroupCalendar_cInviteWhisperFormat = "[GroupCalendar] You are being invited to the event '%s'.  Please accept the invitation if you wish to join this event.";
GroupCalendar_cAlreadyGroupedWhisper = "[GroupCalendar] You are already in a group.  Please /w back when you leave your group.";
GroupCalendar_cAlreadyGroupedSysMsg = "(.+) is already in a group";
GroupCalendar_cInviteDeclinedSysMsg = "(.+) declines your group invitation.";
GroupCalendar_cNoSuchPlayerSysMsg = "No player named '(.+)' is currently playing.";

GroupCalendar_cJoinedGroupStatus = "Joined";
GropuCalendar_cInvitedGroupStatus = "Invited";
GropuCalendar_cReadyGroupStatus = "Ready";
GroupCalendar_cGroupedGroupStatus = "In another group";
GroupCalendar_cStandbyGroupStatus = "Standby";
GroupCalendar_cDeclinedGroupStatus = "Declined invitation";
GroupCalendar_cOfflineGroupStatus = "Offline";
GroupCalendar_cLeftGroupStatus = "Left group";

GroupCalendar_cPriorityLabel = "Priority:";
GroupCalendar_cPriorityDate = "Date";
GroupCalendar_cPriorityRank = "Rank";

GroupCalendar_cConfrimDeleteRSVP = "Remove %s from this event? They can't join again unless you add them back manually.";

GroupCalendar_cConfirmSelfUpdateMsg = "%s";
GroupCalendar_cConfirmSelfUpdateParamFormat = "A newer copy of the events for $mUserName is available from $mSender.  Do you want to update your events to the newer version? If you update then any events you've added or changed since logging in will be lost.";
GroupCalendar_cConfirmSelfRSVPUpdateParamFormat = "A newer copy of the attendance requests for %mUserName is available from $mSender.  Do you wnat to update your attendance requests to the newer version?  If you update then any unconfirmed attendance changes you've made since logging in will be lost.";
GroupCalendar_cUpdate = "Update";

GroupCalendar_cConfirmClearWhispers = "Clear all recent whispers?";
GroupCalendar_cClear = "Clear";

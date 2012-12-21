--[[
--
--	DamageMeters Localization Data (ENGLISH)
--
--]]


-------------------------------------------------------------------------------

-- General --
DamageMeters_PRINTCOLOR = "|cFF8F8FFF"

-- Bindings --
BINDING_HEADER_DAMAGEMETERSHEADER 		= "DamageMeters";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOW	= "Toggle Visible";
BINDING_NAME_DAMAGEMETERS_CYCLEQUANT	= "Cycle Visible Quantity";
BINDING_NAME_DAMAGEMETERS_CYCLEQUANTBACK= "Cycle Visible Quantity Backwards";
BINDING_NAME_DAMAGEMETERS_CLEAR			= "Clear Data";
BINDING_NAME_DAMAGEMETERS_TOGGLEPAUSED	= "Toggle Paused";
BINDING_NAME_DAMAGEMETERS_SHOWREPORTFRAME = "Show Report Frame";
BINDING_NAME_DAMAGEMETERS_SWAPMEMORY	= "Swap Memory";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOWMAX	= "Toggle Show Max Bars";
BINDING_NAME_DAMAGEMETERS_SYNCREADY		= "Send Sync Ready";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOWFIGHTASPS = "Toggle Show Fight Data As Per/Second";
BINDING_NAME_DAMAGEMETERS_TOGGLENORMALANDFIGHT = "Toggle Between Normal and Fight Quantities";
BINDING_NAME_DAMAGEMETERS_TOGGLEMINIMODE = "Toggle Mini Mode";
BINDING_NAME_DAMAGEMETERS_SYNCPAUSE = "Sync Pause";
BINDING_NAME_DAMAGEMETERS_SYNCUNPAUSE = "Sync Unpause";
BINDING_NAME_DAMAGEMETERS_SYNCCLEAR = "Sync Clear";

--[[ work in progress
-- command, function, help string
DM_HELPDEF = {
	-- Main commands.
	{ "help", DamageMeters_Help, DM_CMD_HELP },
	{ "cmd", DamageMeters_ListCommands, DM_CMD_CMD },
	{ "version", DamageMeters_ShowVersion, DM_CMD_VERSION },
	{ "show", DamageMeters_ToggleShow, DM_CMD_SHOW },
	{ "hide", DamageMeters_Hide, DM_CMD_HIDE },
	{ "clear", DamageMeters_Clear, DM_CMD_CLEAR },
	{ "report", DamageMeters_Report, DM_CMD_REPORT },
	{ "sort", DamageMeters_SetSort, DM_CMD_SORT },
	{ "count", DamageMeters_SetCount, DM_CMD_SETCOUNT },
	{ "autocount", DamageMeters_SetAutoCount, DM_CMD_AUTOCOUNT },
	{ "lock", DamageMeters_ToggleLock, DM_CMD_LOCK },
	{ "pause", DamageMeters_TogglePause, DM_CMD_PAUSE },
	{ "ready", DamageMeters_SetReady, DM_CMD_READY },
	{ "resetpos", DamageMeters_ResetPos, DM_CMD_RESETPOS },
	{ "pop", DamageMeters_Populate, DM_CMD_POP },
	{ "listbanned", DamageMeters_ListBanned, DM_CMD_LISTBANNED },
	{ "clearbanned", DamageMeters_ClearBanned, DM_CMD_CLEARBANNED },

	-- Memory
	{ "save", DamageMeters_Save, DM_CMD_SAVE },
	{ "restore", DamageMeters_Restore, DM_CMD_RESTORE },
	{ "swap", DamageMeters_Swap, DM_CMD_SWAP },
	{ "memclear", DamageMeters_MemClear, DM_CMD_MEMCLEAR },

	-- These all have menu options.
	{ "color", DamageMeters_SetColorScheme, DM_CMD_COLOR },
	{ "quant", DamageMeters_SetQuantity, DM_CMD_QUANT },
	{ "text", DamageMeters_SetTextOptions, DM_CMD_TEXT },
	{ "visinparty", DamageMeters_SetVisibleInParty, DM_CMD_VISINPARTY },
	{ "lockpos", DamageMeters_ToggleLockPos, DM_CMD_LOCKPAUSE },
	{ "grouponly", DamageMeters_ToggleGroupMembersOnly, DM_CMD_GROUPONLY },
	{ "addpettoplayer", DamageMeters_ToggleAddPetToPlayer, DM_CMD_ADDPETTOPLAYER },
	{ "resetoncombat", DamageMeters_ToggleResetWhenCombatStarts, DM_CMD_RESETONCOMBAT },
	{ "total", DamageMeters_ToggleTotal, DM_CMD_TOTAL },
	{ "showmax", DamageMeters_ToggleMaxBars, DM_CMD_SHOWMAX },	

	-- Sync commands.
	{ "sync", DamageMeters_Sync, DM_CMD_SYNC },
	{ "syncchan", DamageMeters_SyncChan, DM_CMD_SYNCCHAN },
	{ "syncleave", DamageMeters_SyncLeaveChanCmd, DM_CMD_SYNCLEAVE },
	{ "syncsend", DamageMeters_SyncReport, DM_CMD_SYNCSEND },
	{ "syncrequest", DamageMeters_SyncRequest, DM_CMD_SYNCREQUEST },
	{ "syncclear", DamageMeters_SyncClear, DM_CMD_SYNCCLEAR },
	{ "syncmsg", DamageMeters_SendSyncMsg, DM_CMD_SYNCMSG },
	{ "syncbroadcastchan", DamageMeters_SyncBroadcastChan, DM_CMD_SYNCBROADCASTCHAN },
	{ "syncping", DamageMeters_SyncPingRequest, DM_CMD_SYNCPING },
	{ "syncpause", DamageMeters_SyncPause, DM_CMD_SYNCPAUSE },
	{ "syncunpause", DamageMeters_SyncUnpause, DM_CMD_SYNCUNPAUSE },
	{ "syncready", DamageMeters_SyncReady, DM_CMD_SYNCREADY },
	{ "synckick", DamageMeters_SyncKick, DM_CMD_SYNCKICK },
	{ "synclabel", DamageMeters_SyncLabel, DM_CMD_SYNCLABEL },
	{ "syncstart", DamageMeters_SyncStart, DM_CMD_SYNCSTART },
	{ "synchalt", DamageMeters_SyncHalt, DM_CMD_SYNCHALT },
	{ "synce", DamageMeters_SyncEmote, DM_CMD_SYNCEMOTE },

	-- Debug commands.
	{ "reset", DamageMeters_Reset, DM_CMD_RESET },
	{ "test", DamageMeters_Test, DM_CMD_TEST },
	{ "add", DamageMeters_Add, DM_CMD_ADD },
	{ "dumptable", DamageMeters_DumpTable, DM_CMD_DUMPTABLE },
	{ "debug", DM_ToggleDMPrintD, DM_CMD_DEBUG },
	{ "dumpmsg", DM_DumpMsg, DM_CMD_DUMPMSG },
	{ "print", DM_ConsolePrint, DM_CMD_PRINT },
};
]]--

-- Help --
DamageMeters_helpTable = {
		"The following commands can be entered into the console:",
		"/dm help : Gives help on using DamageMeters.",
		"/dm cmd : Lists available /dm (DamageMeters) commands.",
		"/dm show : Toggles whether or not the meters are visible.  Note that data collection continues when meters are not visible.",
		"/dm hide : Hides the meters.",
		"/dm clear [#] : Removes entries from the bottom of the list, leaving #.  If # not specified, entire list is cleared.",
		"/dm report [help] [total] [c/s/p/r/w/h/g/f[#]] [whispertarget/channelNAME] - Prints a report of the current data: use '/dm report help' for details.",
		"/dm sort [#] - Sets sorting style.  Specify no number for a list of available styles.",
		"/dm count [#] - Sets number of bars visible at once.  If # not given shows the maximum possible.",
		"/dm save - Saves the current table internally.",
		"/dm restore - Restores a previously saved table, overwriting any new data.",
		--"/dm merge - Merges a previously saved table with any existing data.",
		"/dm swap - Swaps the previously saved table with the current one.",
		"/dm memclear - Clears the saved table.",
		"/dm resetpos - Resets the position of the window (helpful incase you lose it)%.",
		"/dm text 0/<[r][n][p][l][v]> - Sets what text should be shown on the bars. r - Rank. n - Player name. p - Percentage of total. l - Percentage of leader. v - Value.",
		"/dm color # - Sets the color scheme for the bars.  Specify no # for a list of options.",
		"/dm quant # - Sets the quantity the bars should use.  Specify no # for a list of options.",
		"/dm visinparty [y/n] - Sets whether or not the window should only be visible while you are in a party/raid.  Specify no argument to toggle.",
		"/dm autocount # - If # is greater than zero, then the window will show as many bars as it has information for up to #.  If # is zero, it turns off the auto-count function.",
		"/dm listbanned - Lists all banned entities.",
		"/dm clearbanned - Clears list of all banned entities.",

		"/dm sync [d#] [e] - Causes you to synchronize your data with other users using the same sync channel.  (Calls dmsyncsend and dmsyncrequest.)  If d specified, the sync will be delayed that many seconds.  If e specified, event data will be sent/requested.",
		--"/dm syncchan - Sets the name of the channel to use for synchronizing.",
		--"/dm syncleave - Leaves the current sync chan.",
		"/dm syncsend - Sends sync information on the sync channel.",
		"/dm syncrequest - Sends request for an automatic dmsync to other people using your sync channel.",
		"/dm syncclear - Sends request for everyone to clear their data.",
		"/dm syncmsg msg - Sends a message to other people in the same syncchan.  Can also use /dm m.",
		--"/dm syncbroadcastchan - Broadcasts the current sync channel to your party or raid.  Can also use /dm syncb.",
		"/dm syncping - 'Pings' the other people in the sync chan, causing them to respond with their current version of DM.",
		"/dm syncpause - Makes other DMs on your syncchan pause.",
		"/dm syncunpause - Makes other DMs on your syncchan unpause.",
		"/dm syncready - Transmits a command to make everyone in the sync chan go into the ready state.",
		--"/dm synckick player - Kickes player out of the sync channel.",
		"/dm synclabel label - Labels the current session. (Index defaults to 1).",
		"/dm syncstart label - Convenience function which does dmsynclabel, dmsyncpause, and dmsyncclear automatically.",
		"/dm synchalt - Aborts any syncing in progress (clears incoming and outgoing message queues).",

		"/dm pop - Populates it with your current party/raid members (though will not remove any existing entries)%.",
		"/dm lock - Toggles whether or not the list is locked. New people cannot be added to a locked list, but people already in can are updated.",
		"/dm pause - Toggles whether or not the parsing of data is to occur.",
		"/dm lockpos - Toggles whether or not the position of the window is locked.",
		"/dm grouponly - Toggles whether or not to reject anyone who is not in your raid/party.  (Your pet will be monitored regardless of this setting.)",
		"/dm addpettoplayer - Toggles whether or not to consider pet's data as coming directly from the player.",
		"/dm resetoncombat = Toggles whether or not to reset data when combat starts.",
		"/dm version - Shows version information.",
		"/dm total - Toggles display of the total display.",
		"/dm showmax - Toggles whether or not to show the max number of bars.",
};

-- Filters --
DamageMeters_Filter_STRING1 = "party members";
DamageMeters_Filter_STRING2 = "all friendly characters";

-- Relationships --
DamageMeters_Relation_STRING = {
		"Self",
		"Your Pet",
		"Party",
		"Friendly"};

-- Color Schemes -- 
DamageMeters_colorScheme_STRING = {
		"Relationship",
		"Class Colors"};

-- Quantities -- 
DM_QUANTSTRING_DAMAGEDONE = "Damage Done";
DM_QUANTSTRING_HEALINGDONE = "Healing Done";
DM_QUANTSTRING_DAMAGETAKEN = "Damage Taken";
DM_QUANTSTRING_HEALINGTAKEN = "Healing Taken";
DM_QUANTSTRING_DAMAGEDONE_FIGHT = "Fight Damage Done";
DM_QUANTSTRING_HEALINGDONE_FIGHT = "Fight Healing Done";
DM_QUANTSTRING_DAMAGETAKEN_FIGHT = "Fight Damage Taken";
DM_QUANTSTRING_HEALINGTAKEN_FIGHT = "Fight Healing Taken";
DM_QUANTSTRING_DAMAGEDONE_PS = "DPS";
DM_QUANTSTRING_HEALINGDONE_PS = "HPS";
DM_QUANTSTRING_DAMAGETAKEN_PS = "DTPS";
DM_QUANTSTRING_HEALINGTAKEN_PS = "HTPS";
DM_QUANTSTRING_IDLETIME = "Idle Time";
DM_QUANTSTRING_NETDAMAGE = "Net Damage";
DM_QUANTSTRING_NETHEALING = "Net Healing";
DM_QUANTSTRING_DAMAGEPLUSHEALING = "Damage+Healing";
DM_QUANTSTRING_CURING = "Curing Done";
DM_QUANTSTRING_CURING_FIGHT = "Fight Curing Done";
DM_QUANTSTRING_CURING_PS = "Cures PS";
DM_QUANTSTRING_OVERHEAL = "Overhealing";
DM_QUANTSTRING_OVERHEAL_FIGHT = "Fight Overhealing";
DM_QUANTSTRING_OVERHEAL_PS = "OHPS";
DM_QUANTSTRING_HEALTH = "Health";
DM_QUANTSTRING_OVERHEAL_PERCENTAGE = "Overheal %";
DM_QUANTSTRING_ABSHEAL = "Raw Heal Done";
DM_QUANTSTRING_ABSHEAL_FIGHT = "Fight Raw Heal Done";
DM_QUANTSTRING_ABSHEAL_PS = "Raw. HPS";

DMI_NAMES = {
	DM_QUANTSTRING_DAMAGEDONE,
	DM_QUANTSTRING_HEALINGDONE,
	DM_QUANTSTRING_DAMAGETAKEN,
	DM_QUANTSTRING_HEALINGTAKEN,
	DM_QUANTSTRING_CURING,
	DM_QUANTSTRING_OVERHEAL,
	DM_QUANTSTRING_ABSHEAL,
};

DM_QUANTABBREV_DAMAGEDONE = "D";
DM_QUANTABBREV_HEALINGDONE = "H";
DM_QUANTABBREV_DAMAGETAKEN = "DT";
DM_QUANTABBREV_HEALINGTAKEN = "HT";
DM_QUANTABBREV_CURING = "Cu";
DM_QUANTABBREV_OVERHEAL = "Oh";
DM_QUANTABBREV_ABSHEAL = "RawHD";

DM_QUANTABBREV_DAMAGEDONE_PS = "DPS";
DM_QUANTABBREV_HEALINGDONE_PS = "HPS";
DM_QUANTABBREV_DAMAGETAKEN_PS = "DTPS";
DM_QUANTABBREV_HEALINGTAKEN_PS = "HTPS";
DM_QUANTABBREV_CURING_PS = "CuPS";
DM_QUANTABBREV_OVERHEAL_PS = "OHPS";
DM_QUANTABBREV_ABSHEAL_PS = "RawHDPS";

DM_QUANTABBREV_IDLETIME = "IT";	
DM_QUANTABBREV_NETDAMAGE = "NetD";
DM_QUANTABBREV_NETHEALING = "NetH";
DM_QUANTABBREV_DAMAGEPLUSHEALING = "D+H";
DM_QUANTABBREV_HEALTH = "HP";
DM_QUANTABBREV_OVERHEAL_PERCENTAGE = "Oh%";


-- Sort --
DamageMeters_Sort_STRING = {
	"Decreasing", 
	"Increasing",
	"Alphabetical"};

-- Class Names
function DamageMeters_GetClassColor(className)
	return RAID_CLASS_COLORS[string.upper(className)];
end

-- This associates the string names of damage types (schools) with the DM_DMGTYPE constants.
DM_DMGNAMETOID = {
	Arcane = DM_DMGTYPE_ARCANE,
	Fire = DM_DMGTYPE_FIRE,
	Nature = DM_DMGTYPE_NATURE,
	Frost = DM_DMGTYPE_FROST,
	Shadow = DM_DMGTYPE_SHADOW,
	Holy = DM_DMGTYPE_HOLY,
	Physical = DM_DMGTYPE_PHYSICAL,
};

DM_DMGTYPENAMES = {
	"Arcane",
	"Fire",
	"Nature",
	"Frost",
	"Shadow",
	"Holy",
	"Physical",
	"Default",
};

-- Errors --
DM_ERROR_INVALIDARG = "DamageMeters: Invalid argument(s).";
DM_ERROR_MISSINGARG = "DamageMeters: Argument(s) missing.";
DM_ERROR_NOSAVEDTABLE = "DamageMeters: No saved table.";
DM_ERROR_BADREPORTTARGET = "DamageMeters: Invalid report target = ";
DM_ERROR_MISSINGWHISPERTARGET = "DamageMeters: Whisper specified but no player given.";
DM_ERROR_MISSINGCHANNEL = "DamageMeters: Channel specified but no number given.";
DM_ERROR_NOSYNCCHANNEL = "DamageMeters: Sync channel must be specified with dmsyncchan before calling sync functions.";
DM_ERROR_JOINSYNCCHANNEL = "DamageMeters: You must join sync channel ('%s') before you can call sync functions.";
DM_ERROR_SYNCTOOSOON = "DamageMeters: Sync request too soon after last one; ignoring.";
DM_ERROR_POPNOPARTY = "DamageMeters: Cannot populate table; you are not in a party or raid.";
DM_ERROR_NOROOMFORPLAYER = "DamageMeters: Cannot merge pet data with players because cannot add player to list (list full?).";
DM_ERROR_BROADCASTNOGROUP = "DamageMeters: Must be in a party or raid to broadcast the sync channel.";
DM_ERROR_NOPARTY = "DamageMeters: You are not in a party.";
DM_ERROR_NORAID = "DamageMeters: You are not in a raid.";

-- Messages --
DM_MSG_SETQUANT = "DamageMeters: Setting visible quantity to ";
DM_MSG_CURRENTQUANT = "DamageMeters: Current quantity = ";
DM_MSG_CURRENTSORT = "DamageMeters: Current sort = ";
DM_MSG_SORT = "DamageMeters: Setting sort to ";
DM_MSG_CLEAR = "DamageMeters: Removing entries %d to %d.";
--DM_MSG_REMAINING = "DamageMeters: %d items remaining.";
DM_MSG_REPORTHEADER = "DamageMeters: <%s> report on %d/%d sources:";
DM_MSG_PLAYERREPORTHEADER = "DamageMeters: Player report on %s:";
DM_MSG_SETCOUNTTOMAX = "DamageMeters: No count argument specified, setting to max.";
DM_MSG_SETCOUNT = "DamageMeters: New bar count = ";
DM_MSG_RESETFRAMEPOS = "DamageMeters: Resetting frame position.";
DM_MSG_SAVE = "DamageMeters: Saving table.";
DM_MSG_RESTORE = "DamageMeters: Restoring saved table.";
DM_MSG_MERGE = "DamageMeters: Merging saved table with current.";
DM_MSG_SWAP = "DamageMeters: Swapping normal (%d) and saved (%d) table.";
DM_MSG_SETCOLORSCHEME = "DamageMeters: Setting color scheme to ";
DM_MSG_TRUE = "true";
DM_MSG_FALSE = "false";
DM_MSG_SETVISINPARTY = "DamageMeters: Visible-only-in-party is set to ";
DM_MSG_SETAUTOCOUNT = "DamageMeters: Setting new autocount limit to ";
DM_MSG_LISTBANNED = "DamageMeters: Listing banned entities:";
DM_MSG_CLEARBANNED = "DamageMeters: Clearing all banned entities.";
DM_MSG_HOWTOSHOW = "DamageMeters: Hiding window.  Use /dm show to make it visible again.";
DM_MSG_SYNCCHAN = "DamageMeters: Synchronization channel name set to ";
DM_MSG_SYNCREQUESTACK = "DamageMeters: Sync requested from player ";
DM_MSG_SYNCREQUESTACKEVENTS = "DamageMeters: Sync (with events) requested from player ";
DM_MSG_SYNC = "DamageMeters: Sending sync data.";
DM_MSG_SYNCEVENTS = "DamageMeters: Sending sync data (with events).";
DM_MSG_LOCKED = "DamageMeters: List now locked.";
DM_MSG_NOTLOCKED = "DamageMeters: List unlocked.";
DM_MSG_PAUSED = "DamageMeters: Parsing paused.";
DM_MSG_UNPAUSED = "DamageMeters: Parsing resumed.";
DM_MSG_POSLOCKED = "DamageMeters: Position locked.";
DM_MSG_POSNOTLOCKED = "DamageMeters: Position unlocked.";
DM_MSG_CLEARRECEIVED = "DamageMeters: Clear request received from player ";
DM_MSG_ADDINGPETTOPLAYER = "DamageMeters: Now treating pet data as though it was yours.";
DM_MSG_NOTADDINGPETTOPLAYER = "DamageMeters: Pet data now treated separately from yours.";
DM_MSG_PETMERGE = "DamageMeters: Merging pet's (%s) information into your's.";
DM_MSG_RESETWHENCOMBATSTARTSCHANGE = "DamageMeters: Reset when combat starts = ";
DM_MSG_SHOWFIGHTASPS = "DamageMeters: Showing fight data as per/second = ";
DM_MSG_COMBATDURATION = "Combat duration = %.2f seconds.";
DM_MSG_RECEIVEDSYNCDATA = "DamageMeters: Receiving Sync data from %s.";
DM_MSG_TOTAL = "TOTAL";
DM_MSG_VERSION = "DamageMeters Version %s Active.";
DM_MSG_REPORTHELP = "The /dm report command consists of three parts:\n\n1) The destination character.  This can be one of the following letters:\n  c - Console (only you can see it)%.\n  s - Say\n  p - Party chat\n  r - Raid chat\n  g - Guild chat\n  o - Guild Officer chat\n  h - Chat cHannel. /dm report h mychannel\n  w - Whisper to player.  /dm report w dandelion\n  f - Frame: Shows the report in this window.\n\nIf the letter is lower case the report will be in reverse order (lowest to highest)%.\n\n2) Optionally, the number of people to limit it to.  This number goes right after the destination character.\nExample: /dm report p5.\n\n3) By default, reports are on the currently visible quantity only.  If the word 'total' is specified before the destination character, though, the report will be on the totals for every quantity. 'Total' reports are formatted so that they look good when cut-and-paste into a text file, and so work best with the Frame destination.\nExample: /dm report total f\n\nExample: Whisper to player 'dandelion' the top three people in the list:\n/dm report w3 dandelion";
DM_MSG_COLLECTORS = "Data collectors: (%s)";
DM_MSG_ACCUMULATING = "DamageMeters: Accumulating data in memory register.";
DM_MSG_REPORTTOTALDPS = "Total = %.1f (%.1f visible)";
DM_MSG_REPORTTOTAL = "Total = %d (%d visible)";
DM_MSG_SYNCMSG = "[DMM] |Hplayer:%s|h[%s]|h: %s";
DM_MSG_MEMCLEAR = "DamageMeters: Saved table cleared.";
DM_MSG_MAXBARS = "DamageMeters: Setting show-max-bars to %s.";
DM_MSG_MINBARS = "DamageMeters: Setting minimized to %s.";
DM_MSG_LEADERREPORTHEADER = "DamageMeters: Leaders Report on %d/%d Sources:\n #";
-- This causes disconnects...maybe its too long?  ..maybe WoW doesn't like the \n character?
--DM_MSG_FULLREPORTHEADER = "DamageMeters: Full Report on %d/%d Sources:\nPlayer        Damage     Healing     Damaged      Healed        Hits   Crits\n_______________________________________________________________________________";
DM_MSG_FULLREPORTHEADER1 = "DamageMeters: Full Report on %d/%d Sources:";
DM_MSG_FULLREPORTHEADER2 = "Player        Damage     Healing     Damaged      Healed        Hits   Crits";
DM_MSG_FULLREPORTHEADER3 = "_______________________________________________________________________________";
DM_MSG_CLEARACKNOWLEDGED = "DamageMeters: Clear acknowledged from player %s.";
DM_MSG_EVENTREPORTHEADER = "DamageMeters: Event report on %d/%d sources:\n";
DM_MSG_PLAYERONLYEVENTDATAOFF = "DamageMeters: Recording all player's event data.";
DM_MSG_PLAYERONLYEVENTDATAON = "DamageMeters: Now recording only your own event data.";
DM_MSG_SYNCCHANBROADCAST = "<DamageMeters>: Setting this group's sync channel to: ";
DM_MSG_SYNCINGROUPON = "DamageMeters: You will now only sync with group members.";
DM_MSG_SYNCINGROUPOFF = "DamageMeters: You can now sync with anyone.";
DM_MSG_AUTOSYNCJOINON = "DamageMeters: You will automatically join broadcasted sync channels.";
DM_MSG_AUTOSYNCJOINOFF = "DamageMeters: You will no longer automatically join broadcasted sync channels.";
DM_MSG_SYNCHELP = "DamageMeters Sync'ing (short for synchronization) is a process whereby multiple DM users can transmit their data to each other.  Its primary use is for instances where the players are often far from each other and thus miss some of each other's combat messages.\n\nSync Quick-Start Guide:\n\n1) Someone (I'll call her the Sync Leader) chooses a channel name and joins it, ie. /dm syncchan ourchannel.\n2) The Sync Leader then calls /dm syncbroadcastchan (or just /dm syncb).  Anyone who is running a sufficiently recent version of DM will automatically be joined into that channel.\n3) The Sync Leader choses a name for the session--for example, Onyxia-- then calls /dm syncstart with that name. (/dm syncstart Onyxia_.  This will clear everyone's data and pause them, as well as mark them with this label.\n3) Once everyone is in the channel, but before the activity begins, the Sync  Leader should call /dm syncready or /dm syncunpause so that data collection can happen.\n4) Play!  Collect data!\n5) Finally, the Sync Leader calls /dm sync whenever she wants the raid to share data.  Since it can cause a little slowdown it is best to do this between fights (though not necessarily between every fight).  If event data is desired, call (/dm sync e), though it takes a lot longer to sync.\n\nNote: There is nothing special about the Sync Leader: any player can perform any of these commands.  It just seems simpler to have one person in charge of it.";
DM_MSG_PINGING = "DamageMeters: Pinging other players...";
DM_MSG_SYNCONLYPLAYEREVENTSON = "DamageMeters: Only your event information will be transmitted.";
DM_MSG_SYNCONLYPLAYEREVENTSOFF = "DamageMeters: All player's event information will be transmitted.";
DM_MSG_SYNCPAUSE = "DamageMeters: Pause command recieved from %s.";
DM_MSG_SYNCUNPAUSE = "DamageMeters: Unpause command recieved from %s.";
DM_MSG_SYNCREADY = "DamageMeters: Ready command recieved from %s.";
DM_MSG_SYNCPAUSEREQ = "DamageMeters: Transmitting pause command...";
DM_MSG_SYNCUNPAUSEREQ = "DamageMeters: Transmitting unpause command...";
DM_MSG_SYNCREADYREQ = "DamageMeters: Transmitting ready command...";
DM_MSG_PRESSCONTROLEVENT = "Press Control To See Event Data";
DM_MSG_PRESSCONTROLQUANTITY = "Press Control To See Quantity Data";
DM_MSG_PRESSALTSINGLEQUANTITY = "Press Alt To See Only Current Quantity";
DM_MSG_PAUSEDTITLE = "Paused";
DM_MSG_READYTITLE = "Ready";
DM_MSG_EVENTDATALEVEL = {
	"DamageMeters: Parsing no event data.",
	"DamageMeters: Parsing player's event data only.",
	"DamageMeters: Parsing all players' event data."
};
DM_MSG_SYNCEVENTDATALEVEL = {
	"DamageMeters: Transmitting no event data.",
	"DamageMeters: Transmitting player's event data only.",
	"DamageMeters: Transmitting all players' event data."
};
DM_MSG_HELP = "- Enter /dm cmd for a list of commands.\n- If you cannot see the DM window, try /dm resetpos.";
DM_MSG_LEAVECHAN = "DamageMeters: Leaving sync channel '%s'.";
DM_MSG_READYUNPAUSING = "DamageMeters: Damage event received, transmitting sync unpause command...";
DM_MSG_KICKED = "DamageMeters: You have been removed from the sync channel by %s.";
DM_MSG_SETLABEL = "DamageMeters: Session label set to <%s>. (Index = %d)";
DM_MSG_SESSIONMISMATCH = "DamageMeters: Sync received with different session information.  Auto-clearing.";
DM_MSG_SHOWINGFIGHTEVENTSONLY = "Showing events for current fight only.";
DM_MSG_SYNCCLEARREQ = "DamageMeters: Transmitting clear request...";
DM_MSG_CURRENTBARWIDTH = "DamageMeters: Current bar width = %d.\nCall (/dm setbarwidth default) to reset.";
DM_MSG_NEWBARWIDTH = "DamageMeters: New bar width = %d.";
DM_MSG_PLAYERJOINEDSYNCCHAN = "DamageMeters: Player %s joined sync channel. [Version %s]";
DM_MSG_SYNCSESSIONMISMATCH = "Player %s's session (%s:%d) mismatched: Player's data cleared.";
DM_MSG_SYNCHALTRECEIVED = "DamageMeters: Sync Halt command received from %s.";
DM_MSG_SYNCHALTSENT = "DamageMeters: Transmitting halt command...";
DM_MSG_SYNCSESSIONCURRENT = "DamageMeters: You already have the current majority session.";
DM_MSG_SYNCNOSESSIONS = "DamageMeters: No current sessions found.";
-- RPS
DM_MSG_RPS_CHALLENGE = "You challenge %s to Rock-Paper Scissors!  You play %s.";
DM_MSG_RPS_CHALLENGED = "%s has challenged you to Rock-Paper-Scissors!  Use /dm rpsr [player] [r/p/s] to respond.";
DM_MSG_RPS_MISSING_PLAYER = "ERROR: Missing Arg.  Player argument can be omitted if and only if there is only one player currently challenging you.";
DM_MSG_RPS_NOTCHALLENGED = "Error: You were not challenged by %s.";
DM_MSG_RPS_YOUPLAY = "You play %s.";
DM_MSG_RPS_PLAYS = "%s plays %s.";
DM_MSG_RPS_DEFEATED = "%s has defeated you.";
DM_MSG_RPS_VICTORIOUS = "You have defeated %s!"
DM_MSG_RPS_TIE = "You have tied with %s.";

--[[ Note: This is only to help construct the DM_MSG_REPORTHELP string.
The /dm report command consists of three parts:

1) The destination character.  This can be one of the following letters:
  c - Console (only you can see it)%.
  s - Say
  p - Party chat
  r - Raid chat
  g - Guild chat
  h - Chat cHannel. /dm report h mychannel
  w - Whisper to player.  /dm report w dandelion
  f - Frame: Shows the report in this window.

If the letter is lower case the report will be in reverse order (lowest to highest)%.

2) Optionally, the number of people to limit it to.  This number goes right after the destination character.
Example: /dm report p5

3) By default, reports are on the currently visible quantity only.  If the word 'total' is specified before the destination character, though, the report will be on the totals for every quantity. 'Total' reports are formatted so that they look good when cut-and-paste into a text file, and so work best with the Frame destination.
Example: /dm report total f

Example: Whisper to player "dandelion" the top three people in the list:
/dm report w3 dandelion
]]--

--[[ Note: This is only to help construct the DM_MSG_SYNCHELP string.
DamageMeters Sync'ing (short for synchronization) is a process whereby multiple DM users can transmit their data to each other.  Its primary use is for instances where the players are often far from each other and thus miss some of each other's combat messages.\n\nSync Quick-Start Guide:\n\n1) Someone (I'll call her the Sync Leader) chooses a channel name and joins it, ie. /dm syncchan ourchannel.\n2) The Sync Leader then calls /dm syncbroadcastchan (or just /dm syncb).  Anyone who is running a sufficiently recent version of DM will automatically be joined into that channel.\n3) The Sync Leader choses a name for the session--for example, Onyxia-- then calls /dm syncstart with that name. (/dm syncstart Onyxia_.  This will clear everyone's data and pause them, as well as mark them with this label.\n3) Once everyone is in the channel, but before the activity begins, the Sync  Leader should call /dm syncready or /dm syncunpause so that data collection can happen.\n4) Play!  Collect data!\n5) Finally, the Sync Leader calls /dm sync whenever she wants the raid to share data.  Since it can cause a little slowdown it is best to do this between fights (though not necessarily between every fight).  If event data is desired, call (/dm sync e), though it takes a lot longer to sync.\n\nNote: There is nothing special about the Sync Leader: any player can perform any of these commands.  It just seems simpler to have one person in charge of it.
]]--

-- Menu Options --
DM_MENU_CLEAR = "Clear";
DM_MENU_RESETPOS = "Reset Position";
DM_MENU_HIDE = "Hide Window";
DM_MENU_SHOW = "Show Window";
DM_MENU_VISINPARTY = "Visible Only While In A Party";
DM_MENU_REPORT = "Report";
DM_MENU_BARCOUNT = "Bar Count";
DM_MENU_AUTOCOUNTLIMIT = "Auto Count Limit";
DM_MENU_SORT = "Sort Type";
DM_MENU_VISIBLEQUANTITY = "Visible Quantity";
--DM_MENU_COLORSCHEME = "Color Scheme";
DM_MENU_MEMORY = "Memory Register";
DM_MENU_SAVE = "Save";
DM_MENU_RESTORE = "Restore";
DM_MENU_MERGE = "Merge";
DM_MENU_SWAP = "Swap";
DM_MENU_DELETE = "Delete";
DM_MENU_BAN = "Ban";
DM_MENU_CLEARABOVE = "Clear Above";
DM_MENU_CLEARBELOW = "Clear Below";
--DM_MENU_LOCK = "Lock List";
--DM_MENU_UNLOCK = "Unlock List";
DM_MENU_PAUSE = "Pause Parsing";
--DM_MENU_UNPAUSE = "Resume Parsing";
DM_MENU_LOCKPOS = "Lock Position";
DM_MENU_UNLOCKPOS = "Unlock Position";
DM_MENU_GROUPMEMBERSONLY = "Only Monitor Group Members";
DM_MENU_ADDPETTOPLAYER = "Treat Pet Data As Your Data";
DM_MENU_TEXT = "Text Options";
DM_MENU_TEXT_RANK = "Rank";
DM_MENU_TEXT_NAME = "Name";
DM_MENU_TEXT_TOTALPERCENTAGE = "% of Total";
DM_MENU_TEXT_LEADERPERCENTAGE = "% of Leader's";
DM_MENU_TEXT_VALUE = "Value";
DM_MENU_TEXT_DELTA = "Delta";
DM_MENU_SETCOLORFORALL = "Set Color For All";
DM_MENU_DEFAULTCOLORS = "Restore Default Colors";
DM_MENU_RESETONCOMBATSTARTS = "Reset Data When Combat Starts";
DM_MENU_SHOWFIGHTASPS = "Show Fight Data as Per/Second";
DM_MENU_REFRESHBUTTON = "Refresh";
DM_MENU_TOTAL = "Total";
DM_MENU_CHOOSEREPORT = "Choose Report";
-- Note reordered this list in version 2.2.0
DM_MENU_REPORTNAMES = {"Frame", "Console", "Say", "Party", "Raid", "Guild", "Officer"};
DM_MENU_TEXTCYCLE = "Cycle";
DM_MENU_QUANTCYCLE = "Auto-Cycle";
DM_MENU_HELP = "Help";
DM_MENU_ACCUMULATEINMEMORY = "Accumulate Data";
DM_MENU_POSITION = "Position";
DM_MENU_RESIZELEFT = "Resize Left";
DM_MENU_RESIZEUP = "Resize Up";
DM_MENU_SHOWMAX = "Show Max";
DM_MENU_SHOWTOTAL = "Show Total";
DM_MENU_LEADERS = "Leaders";
DM_MENU_PLAYERREPORT = "Player Report";
DM_MENU_EVENTREPORT = "Event Report";
DM_MENU_EVENTDATA = "Event Data";
DM_MENU_EVENTDATA_NONE = "Parse No Events";
DM_MENU_EVENTDATA_PLAYER = "Parse Own Events";
DM_MENU_EVENTDATA_ALL = "Parse All Events";
--DM_MENU_SYNCEVENTDATA_NONE = "Transmit No Events";
--DM_MENU_SYNCEVENTDATA_PLAYER = "Transmit Own Events";
--DM_MENU_SYNCEVENTDATA_ALL = "Transmit All Events";
DM_MENU_SHOWEVENTDATATOOLTIP = "Tooltip Default";
DM_MENU_EVENTS1 = "Events 1-20";
DM_MENU_EVENTS2 = "Events 21-40";
DM_MENU_EVENTS3 = "Events 41-50";
DM_MENU_SYNC = "Synchronization";
DM_MENU_ONLYSYNCWITHGROUP = "Only Sync With Group";
DM_MENU_PERMITSYNCAUTOJOIN = "Join Broadcasted Channels";
DM_MENU_CLEARONAUTOJOIN = "Clear When Joining";
DM_MENU_SYNCBROADCASTCHAN = "Broadcast Channel";
DM_MENU_SYNCLEAVECHAN = "Leave Channel";
DM_MENU_SYNCONLYPLAYEREVENTS = "Sync Self Events Only";
DM_MENU_ENABLEDMM = "Show DMM Messages";
DM_MENU_NOSYNCCHAN = "NO SYNC CHANNEL SET";
DM_MENU_SYNCCHAN = "Current syncchan = ";
DM_MENU_SESSION = "Current session = ";
DM_MENU_SAVEDSESSION = "Session = ";
DM_MENU_JOINSYNCCHAN = "Join Channel: Use /dm syncchan";
DM_MENU_PARSEEVENTMESSAGES = "Parse Incoming Events";
DM_MENU_SENDINGBAR = "Sending...";
DM_MENU_PROCESSINGBAR = "Processing...";
DM_MENU_QUANTITYFILTER = "Quantity Filter";
DM_MENU_MINIMIZE = "Minimize";
DM_MENU_LEFTJUSTIFYTEXT = "Left-Justify";
DM_MENU_RESTOREDEFAULTOPTIONS = "Restore Default Options";
DM_MENU_PLAYERALWAYSVISIBLE = "Self Always Visible";
DM_MENU_APPLYFILTERTOMANUALCYCLING = "Apply to Manual Cycling";
DM_MENU_APPLYFILTERTOAUTOCYCLING = "Apply to Auto-Cycle";
DM_MENU_GENERAL = "General Options";
DM_MENU_GROUPDPSMODE = "Group DPS Mode";
DM_MENU_CLEARBANNED = "Un-ban All";
DM_MENU_CONSTANTVISUALUPDATE = "Constant Visual Update";
DM_MENU_CLEARWHENJOINPARTY = "Clear When Joining A Party";
DM_MENU_AUTOSYNC = "Sync Automaticly";
DM_MENU_STARTNEWSESSION = "Start A New Session";
DM_MENU_SYNCGROUPDATA = "Syncronize Group Data";
DM_MENU_SYNCREADY = "Request Ready";
DM_MENU_SYNCPAUSE = "Request Pause";
DM_MENU_SYNCCLEAR = "Request Clear";
DM_MENU_REPORTCHANNEL = "Channel";
DM_MENU_REPORTWHISPER = "Whisper";
DM_MENU_ENABLESYNC = "Enable Data Sync";
DM_MENU_SYNCREQSESSION = "Request Session ID";
DM_MENU_HIDESCROLLBAR = "Hide Scroll Bar";


-- Misc
DM_CLASS = "Class"; -- The word for player class, like Druid or Warrior.
DM_TOOLTIP = "\nTime since last action = %.1fs\nRelationship = %s";
DM_YOU = "you"
DM_CRITSTR = "Crit";
DM_UNKNOWNENTITY = "Unknown Entity";
DM_SYNCSPELLNAME = "[Sync]";
DM_NEWSESSIONID = "Enter new session ID: "
DM_REPORTCHANNEL = "Enter the name or number of the channel to report to: "
DM_REPORTWHISPER = "Enter the name of the player to report to: "

DM_DMG_MELEE = "[Melee]";
DM_DMG_FALLING = "[Falling]";
DM_DMG_LAVA = "[Lava]";
DM_DMG_DAMAGESHIELD = "[DmgShield]";
DM_DMG_DEATH = "[Death]";
DM_DMG_COMBAT = "[Out of Combat]";

DamageMeters_RPSmoveStrings = 
{ 
	r = "Rock", 
	p = "Paper", 
	s = "Scissors" 
};

-------------------------------------------------------------------------------

--[[ This system based on the one in Gello's Recap, which itself was based on the one in Telo's MobHealth.
- source and dest = 0 means the player

TODO: These are all special cases in English because they contain apostrophes. 
Julie's Dagger
Rammstein's Lightning Bolts
Night Dragon's Breath

]]--

--[[
This table defines types of messages that DM parses and how to parse them.

The index of the table is a human-readable name, which by convention is
normally the name of the string variable (as defined in GlobalStrings.lua) that
is being parsed.  Every type of message that is parsed for the "Damage Done", 
"Healing Done", "Damage Taken", and "Healing Taken" quantities must be defined in this
table.

The key to the system is the "pattern" member.  This is usually (there are some 
special cases) a string defined in GlobalStrings.lua.  An example is COMBATHITSELFOTHER =
"You hit %s for %d.".  When DM loads up it goes through this list and converts all the 
patterns into "regular expression" search strings.  So, for example, the above becomes
"You hit (.+) for (%d+)%."  

When a match is found there will be an array of "elements" for
each unknown in the pattern.  In the above pattern, elements[1] will be the string name
of who was hit, and elements[2] will be how much damage was done.  Each msgInfo has fields
in which you specify which elements mean what.  So, in the msgInfo for this example we set
"dest=1" and "amount=2".  

The fields of each entry are defined as follows:
- source: The index of the element that specifies the source of the amount.  The source is the 
person doing damage or doing the healing in the case of "Damage done" and "healing done" messages,
but it is the the person being hit in the case of "damage received" messages.  When source=0, it 
means the player (us) is the source.
- dest: The name of the entity being effected.  Again, dest=0 means the player.
- amount: The index of the element that contains the quantity of damage/healing done.
- spell: This is the index of the element which references the spell that is doing the damage/healing.
Alternately, if it is a string that spell will be used explicitly.  Spell=0 or nil defaults to regular
melee damage.
- damageType: Also known as "school", this is the index of the element which specifies the type of
damage done, ie. "physical", "fire", "frost", etc.
- crit: This is one of three defined values: DM_HIT, DM_CRT, DM_DOT.  Set this to specify whether
the message represents a spell that hit normally, critically hit, or was a non-crittable spell. 
(Damage Over Time spells, DOTs, cannot crit, hence the name.)
- pattern: This is the pattern, usually a string from GlobalStrings.lua.
- custom: If this is set to true, the pattern will not be transformed when DM is loaded.  Use
this for custom patterns.
]]--

DamageMeters_msgInfo = {
	-- CHAT_MSG_COMBAT_SELF_HITS
		_COMBATHITSELFOTHER = 
			{ source=0, dest=1, amount=2, spell=0, damageType=0, crit=DM_HIT, pattern=COMBATHITSELFOTHER }, -- You hit (.+) for (%d+)
		_COMBATHITCRITSELFOTHER = 
			{ source=0, dest=1, amount=2, spell=0, damageType=0, crit=DM_CRT, pattern=COMBATHITCRITSELFOTHER }, -- You crit (.+) for (%d+)
		_VSENVIRONMENTALDAMAGE_FALLING_SELF = 
			{ source=0, dest=0, amount=1, spell=DM_DMG_FALLING, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_FALLING_SELF }, -- You fall and lose (%d+) health
		_VSENVIRONMENTALDAMAGE_LAVA_SELF = 
			{ source=0, dest=0, amount=1, spell=DM_DMG_LAVA, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_LAVA_SELF }, -- You lose %d health for swimming in lava.

		
	-- CHAT_MSG_SPELL_SELF_DAMAGE
		_SPELLLOGSCHOOLSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=4, crit=DM_HIT, pattern=SPELLLOGSCHOOLSELFOTHER }, -- Your (.+) hits (.+) for (%d+) (.+)%.
		_SPELLLOGCRITSCHOOLSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=4, crit=DM_CRT, pattern=SPELLLOGCRITSCHOOLSELFOTHER }, -- "Your %s crits %s for %d %s damage.";
		_SPELLLOGSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, damageType=0, crit=DM_HIT, pattern=SPELLLOGSELFOTHER }, -- Your (.+) hits (.+) for (%d+)
		_SPELLLOGCRITSELFOTHER = 
			{ source=0, dest=2, amount=3, spell=1, damageType=0, crit=DM_CRT, pattern=SPELLLOGCRITSELFOTHER }, -- Your (.+) crits (.+) for (%d+)

	-- "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE"
		-- No such message.
		--_PERIODICAURADAMAGEABSORBEDSELFOTHER =
		--	{ source=0, dest=1, amount=2, spell=4, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGEABSORBEDSELFOTHER }, -- = "%s suffers %d %s damage from your %s (%d absorbed)."
		_PERIODICAURADAMAGESELFOTHER =
			{ source=0, dest=1, amount=2, spell=4, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGESELFOTHER }, -- (.+) suffers (%d+) (.+) damage from your (.+).
		-- No such message.
		--_PERIODICAURADAMAGEABSORBEDOTHEROTHER =
		--	{ source=4, dest=1, amount=2, spell=5, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGEABSORBEDOTHEROTHER }, -- %s suffers %d %s damage from %s's %s (%d absorbed).
		_PERIODICAURADAMAGEOTHEROTHER =
			{ source=4, dest=1, amount=2, spell=5, damageType=0, crit=DM_DOT, pattern=PERIODICAURADAMAGEOTHEROTHER }, -- (.+) suffers (%d+) (.+) damage from (.+)'s (.+)

	-- "CHAT_MSG_COMBAT_PARTY_HITS" or "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS" or	"CHAT_MSG_COMBAT_PET_HITS")
		_COMBATHITOTHEROTHER = 
			{ source=1, dest=2, amount=3, spell=7, damageType=0, crit=DM_HIT, pattern=COMBATHITOTHEROTHER }, -- (.+) hits (.+) for (%d+)
		_COMBATHITCRITOTHEROTHER =
			{ source=1, dest=2, amount=3, spell=7, damageType=0, crit=DM_CRT, pattern=COMBATHITCRITOTHEROTHER }, -- (.+) crits (.+) for (%d+)
		_VSENVIRONMENTALDAMAGE_FALLING_OTHER =
			{ source=1, dest=1, amount=2, spell=DM_DMG_FALLING, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_FALLING_OTHER }, -- %s falls and loses %d health.
		_VSENVIRONMENTALDAMAGE_LAVA_OTHER =
			{ source=1, dest=1, amount=2, spell=DM_DMG_LAVA, damageType=0, crit=DM_DOT, pattern=VSENVIRONMENTALDAMAGE_LAVA_OTHER }, -- %s loses %d health for swimming in lava.

	-- "CHAT_MSG_SPELL_PARTY_DAMAGE"  "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" "CHAT_MSG_SPELL_PET_DAMAGE"
		_SPELLLOGOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=0, crit=DM_HIT, pattern=SPELLLOGOTHEROTHER }, -- (.+)'s (.+) hits (.+) for (%d+)
		_SPELLLOGCRITOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=0, crit=DM_CRT, pattern=SPELLLOGCRITOTHEROTHER }, -- (.+)'s (.+) crits (.+) for (%d+)
		_SPELLSPLITDAMAGEOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=0, crit=DM_DOT, pattern=SPELLSPLITDAMAGEOTHEROTHER }, -- (.+)'s (.+) causes (.+) (%d+) damage

	-- CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF
		_DAMAGESHIELDSELFOTHER =
			{ source=0, dest=3, amount=1, spell=DM_DMG_DAMAGESHIELD, damageType=0, crit=DM_DOT, pattern=DAMAGESHIELDSELFOTHER }, -- You reflect (%d+) (.+) damage to (.+)

	-- CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS
		_DAMAGESHIELDOTHEROTHER = 
			{ source=1, dest=4, amount=2, spell=DM_DMG_DAMAGESHIELD, damageType=0, crit=DM_DOT, pattern=DAMAGESHIELDOTHEROTHER }, -- (.+) reflects (%d+) (.+) damage to (.+)
		-- ? soul link or something?
		_SPELLSPLITDAMAGESELFOTHER = 
			{ source=0, dest=2, amount=3, spell=1, damageType=0, crit=DM_DOT, pattern=SPELLSPLITDAMAGESELFOTHER }, -- Your (.+) causes (.+) (%d+) damage
		
-- DAMAGE TAKEN
	--"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" -- this gets complicated with pets.
	--"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" 
	--"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" 
		_COMBATHITOTHERSELF = 
			{ source=1, dest=0, amount=2, crit=DM_HIT, pattern=COMBATHITOTHERSELF }, -- "%s hits you for %d.";
		_COMBATHITCRITOTHERSELF =
			{ source=1, dest=0, amount=2, crit=DM_CRT, pattern=COMBATHITCRITOTHERSELF }, -- "%s crits you for %d.";
		_COMBATHITOTHEROTHER =
			{ source=1, dest=2, amount=3, crit=DM_HIT, pattern=COMBATHITOTHEROTHER }, -- "%s hits %s for %d.";
		_COMBATHITCRITOTHEROTHER =
			{ source=1, dest=2, amount=3, crit=DM_CRT, pattern=COMBATHITCRITOTHEROTHER }, -- "%s crits %s for %d.";
		_COMBATHITCRITSCHOOLOTHEROTHER = 
			{ source=1, dest=2, amount=3, damageType=4, crit=DM_CRT, pattern=COMBATHITCRITSCHOOLOTHEROTHER }, -- "%s crits %s for %d %s damage.";
		_COMBATHITSCHOOLOTHEROTHER = 
			{ source=1, dest=2, amount=3, damageType=4, crit=DM_HIT, pattern=COMBATHITSCHOOLOTHEROTHER }, -- "%s hits %s for %d %s damage.";
		_COMBATHITCRITSCHOOLOTHERSELF = 
			{ source=1, dest=0, amount=2, damageType=3, crit=DM_CRT, pattern=COMBATHITCRITSCHOOLOTHERSELF }, -- "%s crits you for %d %s damage.";
		_COMBATHITSCHOOLOTHERSELF = 
			{ source=1, dest=0, amount=2, damageType=3, crit=DM_HIT, pattern=COMBATHITSCHOOLOTHERSELF }, -- "%s hits you for %d %s damage.";
	

	--"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or
	--"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or
	--"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		_SPELLLOGOTHERSELF = 
			{ source=1, dest=0, amount=3, spell=2, damageType=0, crit=DM_HIT, pattern=SPELLLOGOTHERSELF }, -- "%s's %s hits you for %d.";
		_SPELLLOGSCHOOLOTHERSELF = 
			{ source=1, dest=0, amount=3, spell=2, damageType=4, crit=DM_HIT, pattern=SPELLLOGSCHOOLOTHERSELF }, --  "%s's %s hits you for %d %s damage.";
		_SPELLLOGCRITSCHOOLOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, damageType=4, crit=DM_CRT, pattern=SPELLLOGCRITSCHOOLOTHERSELF }, --  "%s's %s crits you for %d %s damage.";
		_SPELLLOGCRITOTHERSELF =
			{ source=1, dest=0, amount=3, spell=2, crit=DM_CRT, pattern=SPELLLOGCRITOTHERSELF }, -- "%s's %s crits you for %d.";
		-- bunch of junk in here in the old code
		_SPELLRESISTOTHERSELF =
			{ source=1, dest=0, amount=0, spell=2, crit=DM_HIT, pattern=SPELLRESISTOTHERSELF }, -- "%s's %s was resisted.";
		
		_SPELLLOGSCHOOLOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=5, crit=DM_HIT, pattern=SPELLLOGSCHOOLOTHEROTHER }, --  "%s's %s hits %s for %d %s damage.";
		_SPELLLOGCRITSCHOOLOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, damageType=5, crit=DM_CRT, pattern=SPELLLOGCRITSCHOOLOTHEROTHER }, --  "%s's %s crits %s for %d %s damage.";
		_SPELLRESISTOTHEROTHER =
			{ source=1, dest=3, amount=0, spell=2, crit=DM_HIT, pattern=SPELLRESISTOTHEROTHER }, -- "%s's %s was resisted by %s.";

	--"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE"
		_PERIODICAURADAMAGEOTHERSELF =
			{ source=3, dest=0, amount=1, spell=4, damageType=2, crit=DM_DOT, pattern=PERIODICAURADAMAGEOTHERSELF }, -- "You suffer %d %s damage from %s's %s."
		_PERIODICAURADAMAGESELFSELF =
			{ source=0, dest=0, amount=1, spell=3, damageType=2, crit=DM_DOT, pattern=PERIODICAURADAMAGESELFSELF }, -- "You suffer %d %s damage from your %s."
		-- pet
		_PERIODICAURADAMAGEOTHEROTHER =
			{ source=4, dest=1, amount=2, spell=5, damageType=3, crit=DM_DOT, pattern=PERIODICAURADAMAGEOTHEROTHER }, -- "%s suffers %d %s damage from %s's %s."

--HEALING
	-- "CHAT_MSG_SPELL_SELF_BUFF" "CHAT_MSG_SPELL_PARTY_BUFF" "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"
		_HEALEDSELFSELF =
			{ source=0, dest=0, amount=2, spell=1, crit=DM_HIT, pattern=HEALEDSELFSELF }, -- "Your %s heals you for %d.";
		_HEALEDCRITSELFSELF =
			{ source=0, dest=0, amount=2, spell=1, crit=DM_CRT, pattern=HEALEDCRITSELFSELF }, -- "Your %s critically heals you for %d.";
		_HEALEDSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, crit=DM_HIT, pattern=HEALEDSELFOTHER }, -- "Your %s heals %s for %d."
		-- missing some here, ie. HEALEDSELFSELF "Your %s heals you for %d."
		_HEALEDCRITSELFOTHER =
			{ source=0, dest=2, amount=3, spell=1, crit=DM_CRT, pattern=HEALEDCRITSELFOTHER }, -- "Your %s critically heals %s for %d.";
		__NIGHTDRAGONSBREATHOTHER = 
			{ source=1, dest=2, amount=3, spell="Night Dragon's Breath", crit=DM_HIT, pattern="(.+)'s Night Dragon's Breath heals (.+) for (%d+)%.", custom=true }, -- "%s's Night Dragon's Breath heals %s for %d.";
		__NIGHTDRAGONSBREATHOTHERCRIT = 
			{ source=1, dest=2, amount=3, spell="Night Dragon's Breath", crit=DM_CRT, pattern="(.+)'s Night Dragon's Breath critically heals (.+) for (%d+)%.", custom=true }, -- "%s's Night Dragon's Breath heals %s for %d.";
		_HEALEDOTHERSELF = 
			{ source=1, dest=0, amount=3, spell=2, crit=DM_HIT, pattern=HEALEDOTHERSELF }, -- "%s's %s heals %s you %d.";
		_HEALEDCRITOTHERSELF = 
			{ source=1, dest=0, amount=3, spell=2, crit=DM_CRT, pattern=HEALEDCRITOTHERSELF }, -- "%s's %s critically heals %s you %d.";
		_HEALEDOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, crit=DM_HIT, pattern=HEALEDOTHEROTHER }, -- "%s's %s heals %s for %d.";
		_HEALEDCRITOTHEROTHER =
			{ source=1, dest=3, amount=4, spell=2, crit=DM_CRT, pattern=HEALEDCRITOTHEROTHER }, -- "%s's %s critically heals %s for %d.";
	
	--"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS" -- why?
		__JULIESBLESSINGOTHER =
			{ source=3, dest=1, amount=2, spell="Julie's Blessing", crit=DM_HIT, pattern="(.+) gains (%d+) health from (.+)'s Julie's Blessing%.", custom=true }, 

		_PERIODICAURAHEALOTHERSELF =
			{ source=2, dest=0, amount=1, spell=3, crit=DM_DOT, pattern=PERIODICAURAHEALOTHERSELF }, -- "You gain %d health from %s's %s."
		_PERIODICAURAHEALSELFSELF =
			{ source=0, dest=0, amount=1, spell=2, crit=DM_DOT, pattern=PERIODICAURAHEALSELFSELF }, -- "You gain %d health from %s."
		_PERIODICAURAHEALSELFOTHER =
			{ source=0, dest=1, amount=2, spell=3, crit=DM_DOT, pattern=PERIODICAURAHEALSELFOTHER }, -- "%s gains %d health from your %s."
		_PERIODICAURAHEALOTHEROTHER =
			{ source=3, dest=1, amount=2, spell=4, crit=DM_DOT, pattern=PERIODICAURAHEALOTHEROTHER }, -- "%s gains %d health from %s's %s."
		
--CURING	
};

-------------------------------------------------------------------------------

--[[
I lifted this system from some other mod (can't remember which, maybe DPSPlus).
Basically, the DM_Spellometer_Patterns works a lot like my own system, but 
the patterns are quite a bit more complicated in this case.  In English, the two
patterns represent all 4 of the following:

DISPELLEDOTHEROTHER = "%s casts %s on %s.";
DISPELLEDOTHERSELF = "%s casts %s on you.";
DISPELLEDSELFOTHER = "You cast %s on %s.";
DISPELLEDSELFSELF = "You cast %s.";

]]--
DM_Spellometer_Patterns = {
   { pattern="^([^ ]+) cast[s]? (.*) on (.*)%.$", caster=1, spell=2, target=3 },
   { pattern="^([^ ]+) cast[s]? (.*)%.$", caster = 1, spell=2, target=nil }
};

-- This list contains all of the "cure" spells we want to track.
DM_CURESPELLS = {
	"Dispel Magic",
	"Remove Curse", 
	"Remove Lesser Curse",
	"Cure Poison", 
	"Abolish Poison",
	"Cure Disease",
	"Abolish Disease",
	"Cleanse",
	"Purification",
	"Poison Cleansing Totem",
	"Disease Cleansing Totem",
	"Ancestral Spirit",
	"Rebirth",
	"Redemption",
	"Resurrection",
	"Defibrillate",
};

-------------------------------------------------------------------------------

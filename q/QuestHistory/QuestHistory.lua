--[[

QuestHistory -- An in-game history log of quests that have been accepted, completed, failed, or abandoned.

Originally written by Jasters in 2004.
Adopted by Dsanai, after Jasters left World of Warcraft, in late 2005.

http://ui.worldofwar.net/ui.php?id=1417
http://www.curse-gaming.com/mod.php?addid=2310
http://www.emerald-order.com/wow/QuestHistory.php

FEATURES
-- Logs all quests that a player receives and records them in a sortable in-game list
-- The user can customize what data the addon logs. Using the default options records the following information for each quest:
-- -- Quest title, objectives, rewards, items as shown in the normal QuestLog
-- -- NPCs giving and completing the quest
-- -- Location of player when quest was accepted/completed
-- -- Level of player when quest was accepted/completed
-- -- Played time of player when quest was accepted/completed (displayed in days:hours:minutes:seconds format)
-- -- Times quest has been abandoned/failed
-- -- XP rewarded for quest completion
-- -- Money rewarded for quest completion
-- Notes can be added to quests
-- Quests can be edited and deleted
-- Quests can be manually added
-- Only records quest data from the time the addon is first used
-- Does not modify any of the game's original files

VERSION HISTORY

v10900-1
-- Added MetaMap support (as alternative to MapNotes).
-- Fixed background graphic display issues (thanks to blankstare2@Curse)
-- Added slash-command to enable/disable Quest Level display at NPC's. Type /qh levels to toggle.
-- Forced current realm's characters to sort to top of the dropdown list.
-- Fixed error that occurred with the dropdown list when you had a large number of characters on various servers.
-- Changed version structure to match other projects.
-- Updated for Patch 10900.

v2.8
-- Added quest level display to Quest Selection window at NPC's. Only occurs when there's more than one quest available.

v2.72
-- Changed the WorldMap cycler to the zoning event, so hopefully the Blizzard 0,0 bug will be killed PRIOR to any Quest activity.
-- Removed the circuit that was getting people stuck on quests in instances.
-- Increased individual quest-accept delay to 1 second. This may not be long enough. Let me know!

v2.71
-- Removed the 0,0 traps, as I've only received reports of 0,0's inside instances since adding the traps. Since instances are ALWAYS going to be 0,0, we are going to assume that things are kosher at the moment.

v2.7
-- Changed Unknown Entity search string to a localized global (so all languages should be covered) (courtesy Asjaskan@Curse)
-- Now strips any third-party quest level-adding addon text from the titles (courtesy Asjaskan@Curse)
-- Added new trap for 0,0 coordinate bug.
-- Added possible 0,0 fix, using a WorldMap show/hide cycler.
-- Finally fixed the delay on subsequent accepted quests (speed-accept bug).
-- Fixed errors that occurred upon login if you weren't an existing QH user.
-- Updated to TOC 1800.

v2.6
-- Fixed Unknown Entity bug (more like, plague).
-- Added Unknown Entity checks/fixes to the login procedure, and to the Repair module.
-- Updated for Patch 1700.

]]

----------------------------------------------------------------------------------------------------
-- Local QuestHistory Variables
----------------------------------------------------------------------------------------------------

local RealmName;						-- Name of realm that is being played on
local PlayerCharacterName;				-- Name of the player's character
local DisplayedRealmName;				-- Name of realm for which quest data is displayed
local DisplayedPlayerCharacterName		-- Name of character for which quest data is displayed

local questHasBeenRecentlyAccepted;		-- Flags if QUEST_LOG_UPDATE event occurs for accepting a quest
local questHasBeenRecentlyAbandoned;	-- Flags if QUEST_LOG_UPDATE event occurs for abandoning a quest

local recentlyAcceptedLocation;			-- Accepted location of the most recently accepted quest
local recentNPCQuestGiver;				-- Name of player's target when most recent quest was accepted

local recentlyCompletedQuestID;			-- ID of entry in QuestHistory_List for the most recently completed quest
local XPBeforeQuestCompletion = 0;		-- Amount of XP before completing a quest
local XPMaxBeforeQuestCompletion = 0;	-- Maximum XP before completing quest, needed in case player levels

local timeText;							-- Time played when a quest is accepted/completed
local timeEvent;						-- Event (Accepted, Completed or Logged) to which timeText applies

local SortedTable;						-- Table to sort the indices of the quest list
local sizeSortedTable;					-- Current size of SortedTable
local currentSortType = "accepted";		-- Keeps track of the current sort type of the quest list
local currentSortOrder = "inc";			-- Keeps track of the current sort order of the quest list

local currentDetailedQuestID;			-- Index of the current quest that is in the DetailFrame
local currentSortedID = 0;				-- SortedTable index of the quest highlighted in the list frame
local currentTitleListID;				-- Index of the currently selected TitleList button in the list frame

local searchText;						-- String to match in quest details

timeSinceLastLog = 0;					-- Keeps track of the time since the last logging of quest data
allowLogging = true;					-- Flags whether it is okay to run QuestHistory_LogCurrentQuests()
QuestHistory_DelayedConfigInit = nil;
QuestHistory_DelayedLoginFired = nil;   -- Flags after the initial login delay has fired, so we know to stop it.
QuestHistory_Loaded = false;
QuestHistory_InsideInstance = false;

-- For Sort Dropdown list
local QUESTHISTORY_SORT_DROPDOWN_LIST = {
	{ name = SORT_ACCEPTED, sortType = "accepted" },
	{ name = SORT_TITLE, sortType = "t" },
	{ name = SORT_LEVEL, sortType = "l" },
	{ name = SORT_CATEGORY, sortType = "c" },
	{ name = SORT_TAG, sortType = "y" },
	{ name = SORT_COMPLETED, sortType = "co" },
	{ name = SORT_XP, sortType = "x" },
	{ name = SORT_MONEY, sortType = "m" },
	{ name = SORT_GIVER, sortType = "g" },
	{ name = SORT_COMPLETER, sortType = "w" },
};

QUESTHISTORY_SORT_DROPDOWN_MENU_WIDTH = 120;		-- Width of the sort dropdown menu
QUESTHISTORY_CHARACTER_DROPDOWN_MENU_WIDTH = 150;	-- Width of the character dropdown menu
QUESTHISTORY_ITEMS_SHOWN = 31;						-- Number of lines in the scrolling list

-- Colors for quest status
local QuestHistoryStatusColor = { };
QuestHistoryStatusColor["completed"] = { r = 0.25, g = 0.50, b = 0.75 };	-- default color of completed quests (blue)
QuestHistoryStatusColor["abandoned"] = { r = 0.75, g = 0.00, b = 0.50 };	-- default color of abandoned quests (purple)
QuestHistoryStatusColor["failed"] = { r = 1.00, g = 0.50, b = 0.50 };		-- default color of failed quests (pink)

-- Flags for logging/showing of quest data
local QuestHistoryFlags = { };
QuestHistoryFlags["showAbandoned"] = { index = 1, status = true, text = QUESTHISTORY_SHOW_ABANDONED, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_SHOW_ABANDONED };
QuestHistoryFlags["showCurrent" ] = { index = 2, status = true, text = QUESTHISTORY_SHOW_CURRENT, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_SHOW_CURRENT };
QuestHistoryFlags["showCompleted" ] = { index = 3, status = true, text = QUESTHISTORY_SHOW_COMPLETED, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_SHOW_COMPLETED };
QuestHistoryFlags["logLevel"] = { index = 4, status = true, data = "l", text = QUESTHISTORY_LOG_LEVEL, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_LEVEL };
QuestHistoryFlags["logCategory"] = { index = 5, status = true, data = "c", text = QUESTHISTORY_LOG_CATEGORY, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_CATEGORY };
QuestHistoryFlags["logTag"] = { index = 6, status = true, data = "y", text = QUESTHISTORY_LOG_TAG, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_TAG };
QuestHistoryFlags["logCompletedOrder"] = { index = 7, status = true, data = "co", text = QUESTHISTORY_LOG_COMPLETED_ORDER, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_ORDER };
QuestHistoryFlags["logDescription"] = { index = 8, status = true, data = "d", text = QUESTHISTORY_LOG_DESCRIPTION, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_DESCRIPTION };
QuestHistoryFlags["logObjectives"] = { index = 9, status = true, data = "o", text = QUESTHISTORY_LOG_OBJECTIVES, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_OBJECTIVES };
QuestHistoryFlags["logObjectivesStatus"] = { index = 10, status = true, data = "os", text = QUESTHISTORY_LOG_OBJECTIVES_STATUS, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_OBJECTIVES_STATUS };
QuestHistoryFlags["logRewards"] = { index = 11, status = true, data = "r", text = QUESTHISTORY_LOG_REWARDS, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_REWARDS };
QuestHistoryFlags["logChoices"] = { index = 12, status = true, data = "i", text = QUESTHISTORY_LOG_CHOICES, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_CHOICES };
QuestHistoryFlags["logSpells"] = { index = 13, status = true, data = "s", text = QUESTHISTORY_LOG_SPELLS, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_SPELLS };
QuestHistoryFlags["logRewardMoney"] = { index = 14, status = true, data = "m", text = QUESTHISTORY_LOG_REWARD_MONEY, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_REWARD_MONEY };
QuestHistoryFlags["logBackgroundMaterial"] = { index = 15, status = true, data = "bg", text = QUESTHISTORY_LOG_BACKGROUND_MATERIAL, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_BACKGROUND_MATERIAL };
QuestHistoryFlags["logRequiredMoney"] = { index = 16, status = true, data = "rm", text = QUESTHISTORY_LOG_REQUIRED_MONEY, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_REQUIRED_MONEY };
QuestHistoryFlags["logXPReward"] = { index = 17, status = true, data = "x", text = QUESTHISTORY_LOG_XP_REWARD, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_XP_REWARD };
QuestHistoryFlags["logQuestGiver"] = { index = 18, status = true, data = "g", text = QUESTHISTORY_LOG_QUEST_GIVER, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_QUEST_GIVER };
QuestHistoryFlags["logQuestCompleter"] = { index = 19, status = true, data = "w", text = QUESTHISTORY_LOG_QUEST_COMPLETER, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_QUEST_COMPLETER };
QuestHistoryFlags["logLevelAccepted"] = { index = 20, status = true, data = "la", text = QUESTHISTORY_LOG_ACCEPTED_LEVEL, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_LEVEL };
QuestHistoryFlags["logLevelCompleted"] = { index = 21, status = true, data = "lc", text = QUESTHISTORY_LOG_COMPLETED_LEVEL, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_LEVEL };
QuestHistoryFlags["logTimeAccepted"] = { index = 22, status = true, data = "ta", text = QUESTHISTORY_LOG_ACCEPTED_TIME, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_TIME };
QuestHistoryFlags["logTimeCompleted"] = { index = 23, status = true, data = "tc", text = QUESTHISTORY_LOG_COMPLETED_TIME, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_TIME };
QuestHistoryFlags["logAcceptedLocation"] = { index = 24, status = true, data = "pa", text = QUESTHISTORY_LOG_ACCEPTED_LOCATION, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_ACCEPTED_LOCATION };
QuestHistoryFlags["logCompletedLocation"] = { index = 25, status = true, data = "pc", text = QUESTHISTORY_LOG_COMPLETED_LOCATION, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_COMPLETED_LOCATION };
QuestHistoryFlags["removePortQuests"] = { index = 26, status = false, text = QUESTHISTORY_REMOVE_PORT_QUESTS, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_REMOVE_PORT_QUESTS };
QuestHistoryFlags["removeDuplicates"] = { index = 27, status = false, text = QUESTHISTORY_REMOVE_DUPLICATES, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_REMOVE_DUPLICATES };
QuestHistoryFlags["allowEditing"] = { index = 28, status = false, text = QUESTHISTORY_ALLOW_EDITING, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_ALLOW_EDITING };
QuestHistoryFlags["allowDeleting"] = { index = 29, status = false, text = QUESTHISTORY_ALLOW_DELETING, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_ALLOW_DELETING };
QuestHistoryFlags["logPortQuests"] = { index = 30, status = false, text = QUESTHISTORY_LOG_PORT_QUESTS, tooltipText = QUESTHISTORY_OPTION_TOOLTIP_LOG_PORT_QUESTS };

local QuestHistoryData = { };
QuestHistoryData["t"] = { old = "title", box = "Title", type = "string", tab = 22 };
QuestHistoryData["l"] = { old = "level", box = "Level", type = "number", tab = 6 };
QuestHistoryData["c"] = { old = "location", box = "Category", type = "string", tab = 8 };
QuestHistoryData["y"] = { old = "tag", box = "Tag", type = "string", tab = 9 };
QuestHistoryData["d"] = { old = "description", box = "Description", type = "string", tab = 24 };
QuestHistoryData["o"] = { old = "objectives", box = "Objectives", type = "string", tab = 23 };
QuestHistoryData["la"] = { old = "levelAccepted", box = "LevelAccepted", type = "number", tab = 1 };
QuestHistoryData["ll"] = { old = "levelLogged", type = "number" };
QuestHistoryData["lc"] = { old = "levelCompleted", box = "LevelCompleted", type = "number", tab = 2 };
QuestHistoryData["rm"] = { old = "requiredMoney", type = "number" };
QuestHistoryData["m"] = { old = "rewardMoney", box = "MoneyRewarded", type = "number", tab = 3 };
QuestHistoryData["bg"] = { old = "material", type = "string" };
QuestHistoryData["g"] = { old = "NPCGiver", box = "QuestGiver", type = "string", tab = 10 };
QuestHistoryData["w"] = { old = "NPCCompleter", box = "QuestCompleter", type = "string", tab = 11 };
QuestHistoryData["ta"] = { old = "timeAccepted", box = "TimeAccepted", type = "string", tab = 18 };
QuestHistoryData["tl"] = { old = "timeLogged", type = "string" };
QuestHistoryData["tc"] = { old = "timeCompleted", box = "TimeCompleted", type = "string", tab = 19 };
QuestHistoryData["co"] = { old = "completedOrder", box = "CompletedOrder", type = "number", tab = 7 };
QuestHistoryData["a"] = { old = "isAbandoned", type = "boolean" };
QuestHistoryData["f"] = { old = "isFailed", type = "boolean" };
QuestHistoryData["ac"] = { old = "abandonedCount", box = "TimesAbandoned", type = "number", tab = 20 };
QuestHistoryData["fc"] = { old = "countFailed", box = "TimesFailed", type = "number", tab = 21 };
QuestHistoryData["n"] = { old = "note", type = "string" };
QuestHistoryData["x"] = { old = "XPReward", box = "XPRewarded", type = "number", tab = 4 };
QuestHistoryData["ao"] = { box = "AcceptedOrder", type = "number", tab = 5 };
QuestHistoryData["az"] = { box = "AcceptedZone", type = "string", tab = 12 };
QuestHistoryData["ax"] = { box = "AcceptedX", type = "number", tab = 13 };
QuestHistoryData["ay"] = { box = "AcceptedY", type = "number", tab = 14 };
QuestHistoryData["cz"] = { box = "CompletedZone", type = "string", tab = 15 };
QuestHistoryData["cx"] = { box = "CompletedX", type = "number", tab = 16 };
QuestHistoryData["cy"] = { box = "CompletedY", type = "number", tab = 17 };
QuestHistoryData["r"] = { type = "item" };
QuestHistoryData["i"] = { type = "item" };
QuestHistoryData["s"] = { type = "spell" };
QuestHistoryData["pa"] = { type = "string" };
QuestHistoryData["pc"] = { type = "string" };
QuestHistoryData["os"] = { type = "objective" };

QUESTHISTORY_MAX_LEVEL = 60;

-- Function hooks
local originalQuestDetailAcceptButton_OnClick;			-- Game functions that need to be
local originalQuestRewardCompleteButton_OnClick;		-- hooked because some quest logging
local originalQuestLogFrameAbandonButton_OnClick;		-- needs to be done when they are called
local originalChatFrame_DisplayTimePlayed;				-- To prevent played time from being displayed in chat

----------------------------------------------------------------------------------------------------
-- Global QuestHistory Variables
----------------------------------------------------------------------------------------------------

QUESTHISTORY_VERSION = 2.9;			-- Version of QuestHistory

QUESTHISTORY_ITEM_HEIGHT = 14;			-- Height of the item buttons in the list frame

UIPanelWindows["QuestHistoryFrame"] =				{ area = "left" , pushable = 12 };
UIPanelWindows["QuestHistoryOptionsFrame"] =		{ area = "left" , pushable = 0 };
UIPanelWindows["QuestHistoryDetailFrame"] =			{ area = "left" , pushable = 0 };
UIPanelWindows["QuestHistoryEditFrame"] =			{ area = "left" , pushable = 0 };
UIPanelWindows["QuestHistoryConfirmFrame"] =		{ area = "left" , pushable = 0 };

QuestHistory_StatusColorType = "";		-- Type of quest status when changing color

----------------------------------------------------------------------------------------------------
-- Internal Functions
----------------------------------------------------------------------------------------------------

-- Initializes the dropdown box with the available selections
local function QuestHistoryFrameSortDropDown_Initialize()
	local info;
	for i = 1, getn(QUESTHISTORY_SORT_DROPDOWN_LIST), 1 do
		info = { };
		info.text = QUESTHISTORY_SORT_DROPDOWN_LIST[i].name;
		info.func = QuestHistoryFrameSortDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function QuestHistoryOptionsFrameCharacterDropDown_Initialize()
	local info;
	local lineCount = 0;
	
	local thisRealm = GetRealmName(); -- Current realm first
	if (QuestHistory_List[thisRealm]) then
		info = { };
		info.text = thisRealm;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);
		lineCount = lineCount + 1;
		for charIndex, charValue in QuestHistory_List[thisRealm] do
			info = { };
			info.text = "    "..charIndex;
			info.value = thisRealm;
			info.func = QuestHistoryOptionsFrameCharacterDropDownButton_OnClick;
			UIDropDownMenu_AddButton(info);
			lineCount = lineCount + 1;
		end
	end
		
	for realmIndex, realmValue in QuestHistory_List do
		if (realmIndex ~= thisRealm and lineCount <= 25) then -- Others, up to limit
			info = { };
			info.text = realmIndex;
			info.isTitle = 1;
			UIDropDownMenu_AddButton(info);
			lineCount = lineCount + 1;
			for charIndex, charValue in realmValue do
				info = { };
				info.text = "    "..charIndex;
				info.value = realmIndex;
				info.func = QuestHistoryOptionsFrameCharacterDropDownButton_OnClick;
				UIDropDownMenu_AddButton(info);
				lineCount = lineCount + 1;
			end
		end
	end
end

-- Comparison function to sort table
local function QuestHistory_SortComparison(index1, index2)
	if ( currentSortType ~= "accepted" ) then
		-- Get the sort values that are to be compared
		local sort1 = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index1][currentSortType];
		local sort2 = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index2][currentSortType];
		if ( currentSortOrder == "dec" ) then
			-- Swap sort values if sorting in decremented order
			sort1, sort2 = sort2, sort1;
		end
		-- Make sure sort1 is not nil and is compatible with sort2
		if ( sort1 == nil ) then
			if ( type(sort2) == "string" ) then
				sort1 = "";
			else
				sort1 = 0;
			end
		end
		-- Make sure sort2 is not nil and is compatible with sort1
		if ( sort2 == nil ) then
			if ( type(sort1) == "string" ) then
				sort2 = "";
			else
				sort2 = 0;
			end
		end
		-- If sorting by completed order, make sure incomplete quests are valued more than completed quests
		-- and that current quests are valued more than abandoned quests
		if ( currentSortType == "co" ) then
			if ( sort1 ~= sort2 ) then
				if ( sort1 == 0 ) then
					sort1 = sort2 + 1;
				elseif ( sort2 == 0 ) then
					sort2 = sort1 + 1;
				end
			else
				if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index1].a ) then
					sort1 = -1;
				end
				if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index2].a ) then
					sort2 = -1;
				end
			end
		end
		-- If sort1 is different from sort2, return comparison of sort values
		if ( sort1 ~= sort2 ) then
			return sort1 < sort2;
		end
	else
		if ( currentSortOrder == "dec" ) then
			-- Swap index values if sorting in decremented order
			index1, index2 = index2, index1;
		end
	end
	-- Return comparison of index values
	return index1 < index2;
end

-- Returns true if data in value table match the current criteria, false otherwise
local function QuestHistory_MatchesSearch(index, value)
	-- Check if quest is completed
	if ( value.co ) then
		-- If it is and not showing completed quests, return false
		if ( not QuestHistoryFlags["showCompleted"].status ) then
			return false;
		end
	-- Check if quest is abandoned
	elseif ( value.a ) then
		-- If it is and not showing abandoned quests, return false
		if ( not QuestHistoryFlags["showAbandoned"].status ) then
			return false;
		end
	-- Quest must be current
	else
		-- If not showing current quests, return false
		if ( not QuestHistoryFlags["showCurrent"].status ) then
			return false;
		end
	end
	-- If there is no search text defined, return true
	if ( not searchText ) then
		return true;
	else
		-- Otherwise, cycle through quest details looking for search text
		for i, v in value do
			if ( string.find(strupper(tostring(value[i])), strupper(searchText)) ) then
				return true;
			end
		end
	end
	-- Return false if search text is defined and not found in the quest details
	return false;
end

-- Builds the SortedTable array and populates it with the indices of QuestHistory_List that match
-- the current criteria. This array can then be sorted without changing the original list.
local function QuestHistory_BuildSortedTable()
	local iNew = 1;
	-- Initialize blank table
	SortedTable = { };
	-- Populate table with quest IDs that match current criteria
	for index, value in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
		if ( QuestHistory_MatchesSearch(index, value) ) then
			SortedTable[iNew] = index;
			iNew = iNew + 1;
		end
	end
	-- Store size of sorted table
	sizeSortedTable = iNew - 1;
	if ( QUESTHISTORY_SORT_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(QuestHistoryFrameSortDropDown)].sortType ) then
		-- Sort table
		table.sort(SortedTable, QuestHistory_SortComparison);
	end
	-- Find sorted table ID that matches the currently selected quest
	currentSortedID = 0;
	for index, value in SortedTable do
		if ( currentDetailedQuestID == SortedTable[index] ) then
			currentSortedID = index;
		end
	end
end

-- Refreshes the display of the QuestHistory_Frame and the scrolling list.
local function QuestHistory_Refresh()
	-- Build the array that contains the indices to sort and display
	QuestHistory_BuildSortedTable();
	-- Check if the currently selected quest is displayed in the scrollframe or if scrolling is needed to display it
	if ( currentSortedID and ( currentSortedID > 0 ) and ( (currentSortedID - FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame) ) <=0 or ( currentSortedID - FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame) ) >= 32 ) ) then
		-- Calculate new offset to set scrollframe to so that currently selected quest is displayed
		local newOffset = currentSortedID * QUESTHISTORY_ITEM_HEIGHT - (QuestHistoryListScrollFrame:GetHeight() / 2);
		if ( newOffset < 0 ) then
			newOffset = 0;
		end
		-- Scroll frame and set the new value
		QuestHistoryListScrollFrameScrollBar:SetValue(newOffset);
	end
	-- Store the title list ID for the currently selected quest
	currentTitleListID = currentSortedID - FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
	QuestHistory_Update();
end

-- Toggles the currently selected sorting method from increasing to decreasing or vice versa
local function QuestHistory_SetSortOrder()
	-- Get selected sort type
	local sortType = QUESTHISTORY_SORT_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(QuestHistoryFrameSortDropDown)].sortType;
	-- If selected sort type is the same as the current sort type then toggle between incrementing and decrementing
	if ( currentSortType == sortType and currentSortOrder == "inc" ) then
		currentSortOrder = "dec";
	else
		currentSortOrder = "inc";
	end
	-- Set current sort type to the one selected
	currentSortType = sortType;
	-- Refresh the display
	QuestHistory_Refresh();
end

-- Displays and updates the reward items portion of the detail view for the quest specified by questIndex
-- Most of the code has been adapted from QuestFrameItems_Update() located in QuestFrame.lua
local function QuestHistory_Detail_Items_Update(questIndex)
	local questItemName = "QuestHistoryDetailItem";
	local questItemReceiveText = QuestHistoryDetailItemReceiveText;
	local spacerFrame = QuestHistoryDetailSpacerFrame;
	-- Get reward data for quest
	local numQuestRewards, numQuestChoices;
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["r"] ) then
		numQuestRewards = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["r"]);
	end
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["i"] ) then
		numQuestChoices = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["i"]);
	end
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["s"] ) then
		numQuestSpellRewards = 1;
	else
		numQuestSpellRewards = 0;
	end
	local money = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].m;
	local material = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].bg;
	-- Set variables to default values if the corresponding data is not in log
	if ( not numQuestRewards ) then
		numQuestRewards = 0;
	end
	if ( not numQuestChoices ) then
		numQuestChoices = 0;
	end
	if ( not money ) then
		money = 0;
	end
	if ( not material ) then
		material = "Parchment";
	end
	-- Calculate total number of rewards
	local totalRewards = numQuestRewards + numQuestChoices + numQuestSpellRewards;
	-- If there is any type of reward, show the reward frame
	if ( totalRewards == 0 and money == 0 ) then
		QuestHistoryDetailRewardTitleText:Hide();
	else
		QuestHistoryDetailRewardTitleText:Show();
		QuestFrame_SetTitleTextColor(QuestHistoryDetailRewardTitleText, material);
		QuestFrame_SetAsLastShown(QuestHistoryDetailRewardTitleText, spacerFrame);
	end
	-- If there is money rewarded, show the money frame and populate it
	if ( money == 0 ) then
		QuestHistoryDetailMoneyFrame:Hide();
	else
		QuestHistoryDetailMoneyFrame:Show();
		QuestFrame_SetAsLastShown(QuestHistoryDetailMoneyFrame, spacerFrame);
		MoneyFrame_Update("QuestHistoryDetailMoneyFrame", money);
	end
	-- Hide the unused frames
	for i = totalRewards + 1, MAX_NUM_ITEMS, 1 do
		getglobal(questItemName..i):Hide();
	end
	-- If there are items that can be chosen, show the choose items frame and populate it
	local questItem, name, texture, numItems;
	if ( numQuestChoices > 0 ) then
		QuestHistoryDetailItemChooseText:Show();
		QuestFrame_SetTextColor(QuestHistoryDetailItemChooseText, material);
		QuestFrame_SetAsLastShown(QuestHistoryDetailItemChooseText, spacerFrame);
		-- Cycle through the quest choices and set up the buttons with the data
		for i = 1, numQuestChoices, 1 do
			questItem = getglobal(questItemName..i);
			questItem.type = "choice";
			link = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["i"][i].l;
			if ( link ) then
				_, _, name = string.find(link, "|c%x+|H%w+:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r");
			end
			texture = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["i"][i].t;
			numItems = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["i"][i].a;
			if ( numItems == nil or numItems == 0 ) then
				numItems = 1;
			end
			-- Set the ID for the choice and show the item
			questItem:SetID(i);
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "item"
			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			getglobal(questItemName..i.."Name"):SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
			SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			-- Anchor this item correctly since the items are shown two to a line
			if ( i > 1 ) then
				if ( mod(i, 2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(i - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..(i - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", "QuestHistoryDetailItemChooseText", "BOTTOMLEFT", -3, -5);
			end
		end
	else
		-- Hide the choose items frame if there are no choices
		QuestHistoryDetailItemChooseText:Hide();
	end
	-- If there are quest rewards, show the receive items frame and populate it with reward data
	if ( numQuestRewards > 0 or money > 0 or numQuestSpellRewards > 0 ) then
		QuestFrame_SetTextColor(questItemReceiveText, material);
		-- Anchor the reward text differently if there are choosable rewards
		if ( numQuestChoices > 0 ) then
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS));
			local index = numQuestChoices;
			if ( mod(index, 2) == 0 ) then
				index = index - 1;
			end
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..index, "BOTTOMLEFT", 3, -5);
		else
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS_ONLY));
			questItemReceiveText:SetPoint("TOPLEFT", "QuestHistoryDetailRewardTitleText", "BOTTOMLEFT", 3, -5);
		end
		-- Show the receive items frame and set it as the last shown frame
		questItemReceiveText:Show();
		QuestFrame_SetAsLastShown(questItemReceiveText, spacerFrame);
		-- Setup mandatory rewards
		for i = 1, numQuestRewards, 1 do
			questItem = getglobal(questItemName..(i + numQuestChoices));
			questItem.type = "reward";
			link = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["r"][i].l;
			if ( link ) then
				_, _, name = string.find(link, "|c%x+|H%w+:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r");
			end
			texture = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["r"][i].t;
			numItems = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["r"][i].a;
			if ( numItems == nil or numItems == 0 ) then
				numItems = 1;
			end
			-- Set the ID for the reward and show the item
			questItem:SetID(i);
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "item";
			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			getglobal(questItemName..(i + numQuestChoices).."Name"):SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
			SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			-- Anchor this item correctly since the items are shown two to a line
			if ( i > 1 ) then
				if ( mod(i, 2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", "QuestHistoryDetailItemReceiveText", "BOTTOMLEFT", -3, -5);
			end
		end
		-- Setup spell reward
		if ( numQuestSpellRewards > 0 ) then
			texture = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["s"].t;
			name = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["s"].n;
			-- Show the spell reward button
			questItem = getglobal(questItemName..(numQuestRewards + numQuestChoices + 1));
			questItem.type = "spell";
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "spell";
			SetItemButtonTexture(questItem, texture);
			getglobal(questItemName..(numQuestRewards + numQuestChoices + 1).."Name"):SetText(name);
			-- Anchor the spell depending on whether it shares a line with a reward item or if it needs a line of its own
			if ( numQuestRewards > 0 ) then
				if ( mod(numQuestRewards, 2) == 0 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((numQuestRewards + numQuestChoices) - 1), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..((numQuestRewards + numQuestChoices)), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", "QuestHistoryDetailItemReceiveText", "BOTTOMLEFT", -3, -5);
			end
		end
	else
		questItemReceiveText:Hide();
	end
end

-- Displays and updates all non-item details for the quest specified by questIndex
-- Most of the code adapted from QuestLog_UpdateQuestDetails() located in QuestLogFrame.lua
local function QuestHistory_Detail_Update(questIndex)
	local spacerFrame = QuestHistoryDetailSpacerFrame;
	--Hide and Show the appropriate frames
	QuestHistoryDetailNotesScrollFrame:Hide();
	QuestHistoryDetailSaveButton:Hide();
	QuestHistoryDetailListScrollFrame:Show();
	QuestHistoryDetailEditButton:Show();
	-- Get information for frame title
	local QuestHistoryDetailTitle = QuestHistoryDetailTitle;
	local questTitle = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].t;
	local tagtext = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].y;
	local level = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].l;
	-- Set variables to default values if the corresponding data is not in log
	if ( not questTitle ) then
		questTitle = "";
	end
	if ( tagtext and tagtext ~= "" ) then
		tagtext = " ["..tagtext.."]";
	else
		tagtext = "";
	end
	if ( not level ) then
		level = "";
	end
	-- Set the title of the frame to show quest title, level and tag
	QuestHistoryDetailTitle:SetText(format(TEXT(QUESTHISTORY_DETAIL_TITLE_FORMAT), questTitle, level, tagtext));
	QuestHistoryDetailTitle:Show();
	-- Display the level of player when quest was accepted/logged
	local levelAccepted = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].la;
	if ( levelAccepted ) then
		QuestHistoryDetailLevelAcceptedTitle:SetText(QUESTHISTORY_LEVEL_ACCEPTED_TITLE);
	else
		levelAccepted = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].ll;
		QuestHistoryDetailLevelAcceptedTitle:SetText(QUESTHISTORY_LEVEL_LOGGED_TITLE);
	end
	if ( levelAccepted ) then
		QuestHistoryDetailLevelAcceptedText:SetText(levelAccepted);
		QuestHistoryDetailLevelAcceptedText:Show();
	else
		QuestHistoryDetailLevelAcceptedText:Hide();
	end
	-- Display the level of player when quest was completed
	local levelCompleted = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].lc;
	if ( levelCompleted ) then
		QuestHistoryDetailLevelCompletedText:SetText(levelCompleted);
		QuestHistoryDetailLevelCompletedText:Show();
	else
		QuestHistoryDetailLevelCompletedText:Hide();
	end
	-- Display the money reward for quest
	local rewardMoney = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].m;
	if ( rewardMoney ) then
		QuestHistoryDetailMoneyRewardedText:SetText(rewardMoney);
		QuestHistoryDetailMoneyRewardedText:Show();
	else
		QuestHistoryDetailMoneyRewardedText:Hide();
	end
	-- Display the XP gained for quest
	local XPReward = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].x;
	if ( XPReward ) then
		QuestHistoryDetailXPRewardedText:SetText(XPReward);
		QuestHistoryDetailXPRewardedText:Show();
	else
		QuestHistoryDetailXPRewardedText:Hide();
	end
	-- Display the name of the quest giver
	local giver = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].g;
	if ( giver ) then
		QuestHistoryDetailQuestGiverText:SetText(giver);
		QuestHistoryDetailQuestGiverText:Show();
	else
		QuestHistoryDetailQuestGiverText:Hide();
	end
	-- Display the name of the quest completer
	local completer = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].w;
	if ( completer ) then
		QuestHistoryDetailQuestCompleterText:SetText(completer);
		QuestHistoryDetailQuestCompleterText:Show();
	else
		QuestHistoryDetailQuestCompleterText:Hide();
	end
	-- Display the location where quest was accepted
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].pa ) then
		local _, _, acceptedZone, acceptedX, acceptedY = string.find(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].pa, "(.*):(.*):(.*)");
		QuestHistoryDetailAcceptedLocationText:SetText(acceptedZone.." ("..floor(tonumber(acceptedX) * 100)..", "..floor(tonumber(acceptedY) * 100)..")");
		QuestHistoryDetailAcceptedLocationButton:Show();
	else
		QuestHistoryDetailAcceptedLocationButton:Hide();
	end
	-- Display the location where quest was completed
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].pc ) then
		local _, _, completedZone, completedX, completedY = string.find(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].pc, "(.*):(.*):(.*)");
		QuestHistoryDetailCompletedLocationText:SetText(completedZone.." ("..floor(tonumber(completedX) * 100)..", "..floor(tonumber(completedY) * 100)..")");
		QuestHistoryDetailCompletedLocationButton:Show();
	else
		QuestHistoryDetailCompletedLocationButton:Hide();
	end
	-- Display the time played when quest was accepted/logged
	local timeAccepted = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].ta;
	if ( timeAccepted ) then
		QuestHistoryDetailTimeAcceptedTitle:SetText(QUESTHISTORY_TIME_ACCEPTED_TITLE);
	else
		timeAccepted = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].tl;
		QuestHistoryDetailTimeAcceptedTitle:SetText(QUESTHISTORY_TIME_LOGGED_TITLE);
	end
	if ( timeAccepted ) then
		QuestHistoryDetailTimeAcceptedText:SetText(timeAccepted);
		QuestHistoryDetailTimeAcceptedText:Show();
	else
		QuestHistoryDetailTimeAcceptedText:Hide();
	end
	-- Display the time played when quest was completed
	local timeCompleted = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].tc;
	if ( timeCompleted) then
		QuestHistoryDetailTimeCompletedText:SetText(timeCompleted);
		QuestHistoryDetailTimeCompletedText:Show();
	else
		QuestHistoryDetailTimeCompletedText:Hide();
	end
	-- Display the number of times quest has been abandoned
	local abandonCount = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].ac;
	if ( not abandonCount ) then
		abandonCount = 0;
	end
	QuestHistoryDetailTimesAbandonedText:SetText(abandonCount);
	QuestHistoryDetailTimesAbandonedText:Show();
	-- Display the number of times quest has been failed
	local failCount = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].fc;
	if ( not failCount ) then
		failCount = 0;
	end
	QuestHistoryDetailTimesFailedText:SetText(failCount);
	QuestHistoryDetailTimesFailedText:Show();
	-- Display the quest note if the player has entered one
	local note = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].n;
	if ( note ) then
		QuestHistoryDetailListNotes:SetText(note);
		QuestHistoryDetailListNotes:Show();
	else
		QuestHistoryDetailListNotes:Hide();
	end
	-- Display the quest title
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].f ) then
		questTitle = questTitle.." = ("..TEXT(FAILED)..")";
	end
	QuestHistoryDetailQuestTitle:SetText(questTitle);
	-- Display the quest objective
	local questObjectives = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].o;
	if ( not questObjectives ) then
		questObjectives = "";
	end
	QuestHistoryDetailObjectivesText:SetText(questObjectives);
	-- If there are objectives, then set their text and display them
	local numObjectives = 0;
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["os"] ) then
		numObjectives = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["os"]);
	end
	for i = 1, numObjectives, 1 do
		local string = getglobal("QuestHistoryDetailObjective"..i);
		local text = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["os"][i].t;
		if ( text ) then
			if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["os"][i].f ) then
				string:SetTextColor(0.2, 0.2, 0.2);
				text = text.." ("..TEXT(COMPLETE)..")";
			else
				string:SetTextColor(0, 0, 0);
			end
			string:SetText(text);
			string:Show();
			QuestFrame_SetAsLastShown(string, spacerFrame);
		end
	end
	for i = numObjectives + 1, MAX_OBJECTIVES, 1 do
		getglobal("QuestHistoryDetailObjective"..i):Hide();
	end
	-- If there's money required then anchor and display it
	local requiredMoney = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].rm;
	if ( not requiredMoney ) then
		requiredMoney = 0;
	end
	if ( requiredMoney > 0 ) then
		if ( numObjectives > 0 ) then
			QuestHistoryDetailRequiredMoneyText:SetPoint("TOPLEFT", "QuestHistoryDetailObjective"..numObjectives, "BOTTOMLEFT", 0, -4);
		else
			QuestHistoryDetailRequiredMoneyText:SetPoint("TOPLEFT", "QuestHistoryDetailObjectivesText", "BOTTOMLEFT", 0, -10);
		end
		MoneyFrame_Update("QuestHistoryDetailRequiredMoneyFrame", requiredMoney);
		if ( ( not QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].co ) and ( requiredMoney > GetMoney() ) ) then
			-- Not enough money for a current quest
			QuestHistoryDetailRequiredMoneyText:SetTextColor(0, 0, 0);
			SetMoneyFrameColor("QuestHistoryDetailRequiredMoneyFrame", 1.0, 0.1, 0.1);
		else
			QuestHistoryDetailRequiredMoneyText:SetTextColor(0.2, 0.2, 0.2);
			SetMoneyFrameColor("QuestHistoryDetailRequiredMoneyFrame", 1.0, 1.0, 1.0);
		end
		QuestHistoryDetailRequiredMoneyText:Show();
		QuestHistoryDetailRequiredMoneyFrame:Show();
	else
		QuestHistoryDetailRequiredMoneyText:Hide();
		QuestHistoryDetailRequiredMoneyFrame:Hide();
	end
	if ( requiredMoney > 0 ) then
		QuestHistoryDetailDescriptionTitle:SetPoint("TOPLEFT", "QuestHistoryDetailRequiredMoneyText", "BOTTOMLEFT", 0, -10);
	elseif ( numObjectives > 0 ) then
		QuestHistoryDetailDescriptionTitle:SetPoint("TOPLEFT", "QuestHistoryDetailObjective"..numObjectives, "BOTTOMLEFT", 0, -10);
	else
		QuestHistoryDetailDescriptionTitle:SetPoint("TOPLEFT", "QuestHistoryDetailObjectivesText", "BOTTOMLEFT", 0, -10);
	end
	-- Display the quest description
	local questDescription = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].d;
	if ( not questDescription ) then
		questDescription = "";
	end
	QuestHistoryDetailQuestDescription:SetText(questDescription);
	QuestFrame_SetAsLastShown(QuestHistoryDetailQuestDescription, spacerFrame);
	-- If there are rewards, display the reward frame which is populated from QuestHistory_Detail_Items_Update()
	local numRewards, numChoices;
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["r"] ) then
		numRewards = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["r"]);
	end
	if ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["i"] ) then
		numChoices = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex]["i"]);
	end
	if ( not numRewards ) then
		numRewards = 0;
	end
	if ( not numChoices ) then
		numChoices = 0;
	end
	if ( not rewardMoney ) then
		rewardMoney = 0;
	end
	if ( (numRewards + numChoices + rewardMoney) > 0 ) then
		QuestHistoryDetailRewardTitleText:Show();
		QuestFrame_SetAsLastShown(QuestHistoryDetailRewardTitleText, spacerFrame);
	else
		QuestHistoryDetailRewardTitleText:Hide();
	end
	QuestHistory_Detail_Items_Update(questIndex);
	QuestHistoryDetailListScrollFrameScrollBar:SetValue(0);
	QuestHistoryDetailListScrollFrame:UpdateScrollChildRect();
	QuestHistoryDetailScrollFrameScrollBar:SetValue(0);
	QuestHistoryDetailScrollFrame:UpdateScrollChildRect();
end

-- Process the stored link of an item to cut out the color and name and only return the hyperlink
local function QuestHistory_ProcessLinks(text)
	if ( text ) then
		local _, _, item = string.find(text, "|c%x+|H(%w+:%d+:%d+:%d+:%d+)|h%[.-%]|h|r");
		return item;
	end
end

-- Upgrades the data in QuestHistory_List to the latest format
local function QuestHistory_UpgradeData()
	for realmIndex, realmValue in QuestHistory_List do
		for charIndex, charValue in realmValue do
			for questIndex, questValue in charValue do
				for dataIndex, dataValue in QuestHistoryData do
					local data = questValue[dataValue.old];
					if ( data ~= nil ) then
						if ( data ~= 0 and data ~= false and data ~= "Parchment" ) then
							if ( dataIndex == "ta" or dataIndex == "tl" or dataIndex == "tc" ) then
								local _, _, days = string.find(data, "(%d+):.*");
								local _, _, hrs = string.find(data, "%d+:(%d+):.*");
								local _, _, mins = string.find(data, "%d+:%d+:(%d+):.*");
								local _, _, secs = string.find(data, "%d+:%d+:%d+:(%d+)");
								if ( days == nil ) then
									days = 0;
								end
								if ( hrs == nil ) then
									hrs = 0;
								end
								if ( mins == nil ) then
									mins = 0;
								end
								if ( secs == nil ) then
									secs = 0;
								end
								questValue[dataIndex] = format(TEXT(QUESTHISTORY_TIME_FORMAT), days, hrs, mins, secs);
							else
								questValue[dataIndex] = data;
							end
						end
						questValue[dataValue.old] = nil;
					end
				end
				-- Converts location data to new format
				if ( questValue.acceptedZone or questValue.acceptedX or questValue.acceptedY ) then
					if ( questValue.acceptedZone and questValue.acceptedX and questValue.acceptedY ) then
						questValue.pa = questValue.acceptedZone..":"..questValue.acceptedX..":"..questValue.acceptedY;
					end
					questValue.acceptedZone = nil;
					questValue.acceptedX = nil;
					questValue.acceptedY = nil;
				end
				if ( questValue.completedZone or questValue.completedX or questValue.completedY ) then
					if ( questValue.completedZone and questValue.completedX and questValue.completedY ) then
						questValue.pc = questValue.completedZone..":"..questValue.completedX..":"..questValue.completedY;
					end
					questValue.completedZone = nil;
					questValue.completedX = nil;
					questValue.completedY = nil;
				end
				-- Converts objectives status data to new format
				if ( questValue.numObjectives ) then
					if ( questValue.numObjectives > 0) then
						questValue.os = { };
						for obIndex = 1, questValue.numObjectives, 1 do
							questValue["os"][obIndex] = { };
							questValue["os"][obIndex].t = questValue["objective"..obIndex.."Text"];
							questValue["os"][obIndex].f = questValue["objective"..obIndex.."Finished"];
							questValue["objective"..obIndex.."Text"] = nil;
							questValue["objective"..obIndex.."Finished"] = nil;
						end
					end
					questValue.numObjectives = nil;
				end
				-- Converts reward item data to new format
				if ( questValue.numRewards ) then
					if ( questValue.numRewards > 0 ) then
						questValue.r = { };
						for rIndex = 1, questValue.numRewards, 1 do
							questValue["r"][rIndex] = { };
							questValue["r"][rIndex].t = questValue["reward"..rIndex.."Texture"];
							if ( questValue["reward"..rIndex.."NumItems"] > 1 ) then
								questValue["r"][rIndex].a = questValue["reward"..rIndex.."NumItems"];
							end
							questValue["r"][rIndex].l = questValue["reward"..rIndex.."ItemLink"];
							questValue["reward"..rIndex.."Name"] = nil;
							questValue["reward"..rIndex.."Texture"] = nil;
							questValue["reward"..rIndex.."NumItems"] = nil;
							questValue["reward"..rIndex.."IsUsable"] = nil;
							questValue["reward"..rIndex.."ItemLink"] = nil;
						end
					end
					questValue.numRewards = nil;
				end
				-- Converts choice item data to new format
				if ( questValue.numChoices ) then
					if ( questValue.numChoices > 0 ) then
						questValue.i = { };
						for iIndex = 1, questValue.numChoices, 1 do
							questValue["i"][iIndex] = { };
							questValue["i"][iIndex].t = questValue["choice"..iIndex.."Texture"];
							if ( questValue["choice"..iIndex.."NumItems"] > 1 ) then
								questValue["i"][iIndex].a = questValue["choice"..iIndex.."NumItems"];
							end
							questValue["i"][iIndex].l = questValue["choice"..iIndex.."ItemLink"];
							questValue["choice"..iIndex.."Name"] = nil;
							questValue["choice"..iIndex.."Texture"] = nil;
							questValue["choice"..iIndex.."NumItems"] = nil;
							questValue["choice"..iIndex.."IsUsable"] = nil;
							questValue["choice"..iIndex.."ItemLink"] = nil;
						end
					end
					questValue.numChoices = nil;
				end
				-- Converts spell reward data to new format
				if ( questValue.numSpells ) then
					if ( questValue.numSpells > 0 ) then
						questValue.s = { };
						questValue["s"].t = questValue.spellTexture;
						questValue["s"].n = questValue.spellName;
					end
					questValue.numSpells = nil;
					questValue.spellTexture = nil;
					questValue.spellName = nil;
					questValue.spellItemLink = nil;
				end
				if ( questValue.backgroundMaterial ) then
					if ( questValue.backgroundMaterial ~= "" and questValue.backgroundMaterial ~= "Parchment" ) then
						questValue.bg = questValue.backgroundMaterial;
					end
					questValue.backgroundMaterial = nil;
				end
				if ( questValue.NPCQuestGiver ) then
					if ( questValue.NPCQuestGiver ~= "" ) then
						questValue.g = questValue.NPCQuestGiver;
					end
					questValue.NPCQuestGiver = nil;
				end
			end
		end
	end
end

-- Purges unwanted data from logged quests
local function QuestHistory_PurgeData()
	for index, value in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
		for i, v in QuestHistoryFlags do
			if ( not v.status ) then
				if ( v.data == "la" ) then
					value.la = nil;
					value.ll = nil;
				elseif ( v.data == "ta" ) then
					value.ta = nil;
					value.tl = nil;
				elseif ( v.data ) then
					value[v.data] = nil;
				end
			end
		end
	end
	QuestHistory_Refresh();
end

-- Edits a quest in the player's history
local function QuestHistory_EditQuest(questID)
	for index, value in QuestHistoryData do
		if ( value.box ) then
			local data = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID][index];
			if ( data == nil ) then
				getglobal("QuestHistoryEdit"..value.box.."EditBox"):SetText("");
			else
				getglobal("QuestHistoryEdit"..value.box.."EditBox"):SetText(data);
			end
		end
	end
	QuestHistoryEditAcceptedOrderEditBox:SetText(questID);
	local location = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID].pa;
	if ( location ) then
		local _, _, zone = string.find(location, "(.-):.*:.*");
		local _, _, x = string.find(location, ".-:(.-):.*");
		local _, _, y = string.find(location, ".-:.-:(.*)");
		QuestHistoryEditAcceptedZoneEditBox:SetText(zone);
		QuestHistoryEditAcceptedXEditBox:SetText(x * 100);
		QuestHistoryEditAcceptedYEditBox:SetText(y * 100);
	end
	location = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID].pc;
	if ( location ) then
		local _, _, zone = string.find(location, "(.-):.*:.*");
		local _, _, x = string.find(location, ".-:(.-):.*");
		local _, _, y = string.find(location, ".-:.-:(.*)");
		QuestHistoryEditCompletedZoneEditBox:SetText(zone);
		QuestHistoryEditCompletedXEditBox:SetText(x * 100);
		QuestHistoryEditCompletedYEditBox:SetText(y * 100);
	end
end

-- Loads the text from the EditFrame and stores it in data
local function QuestHistory_GetEditData()
	local data = { };
	local questID;
	for index, value in QuestHistoryData do
		if ( value.box ) then
			if ( value.type == "string" ) then
				data[index] = getglobal("QuestHistoryEdit"..value.box.."EditBox"):GetText();
			elseif ( value.type == "number" ) then
				_, _, data[index] = string.find(getglobal("QuestHistoryEdit"..value.box.."EditBox"):GetText(), "(%d+)");
				if ( data[index] ~= nil ) then
					data[index] = tonumber(data[index]);
				else
					data[index] = "";
				end
			end
		end
	end
	_, _, questID = string.find(QuestHistoryEditAcceptedOrderEditBox:GetText(), "(%d+)");
	if ( questID == nil ) then
		questID = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]) + 1;
	elseif ( questID == "0" ) then
		questID = 1;
	else
		questID = tonumber( questID );
	end
	local zone, x, y;
	zone = QuestHistoryEditAcceptedZoneEditBox:GetText();
	_, _, x = string.find(QuestHistoryEditAcceptedXEditBox:GetText(), "(%d+%.?%d*)");
	_, _, y = string.find(QuestHistoryEditAcceptedYEditBox:GetText(), "(%d+%.?%d*)");
	if ( x ) then
		x = tonumber(x) / 100;
		if ( x < 0 ) then
			x = 0;
		elseif ( x > 1 ) then
			x = 1;
		end
	else
		x = nil;
	end
	if ( y ) then
		y = tonumber(y) / 100;
		if ( y < 0 ) then
			y = 0;
		elseif ( y > 1 ) then
			y = 1;
		end
	else
		y = nil;
	end
	if ( zone and x and y ) then
		data.pa = zone..":"..x..":"..y;
	end
	zone = QuestHistoryEditCompletedZoneEditBox:GetText();
	_, _, x = string.find(QuestHistoryEditCompletedXEditBox:GetText(), "(%d+%.?%d*)");
	_, _, y = string.find(QuestHistoryEditCompletedYEditBox:GetText(), "(%d+%.?%d*)");
	if ( x ) then
		x = tonumber(x) / 100;
		if ( x < 0 ) then
			x = 0;
		elseif ( x > 1 ) then
			x = 1;
		end
	else
		x = nil;
	end
	if ( y ) then
		y = tonumber(y) / 100;
		if ( y < 0 ) then
			y = 0;
		elseif ( y > 1 ) then
			y = 1;
		end
	else
		y = nil;
	end
	if ( zone and x and y ) then
		data.pc = zone..":"..x..":"..y;
	end
	return data, questID;
end

-- Removes a quest from the displayed player's history
local function QuestHistory_DeleteQuest(questID, realm, character)
	if ( not realm ) then
		realm = DisplayedRealmName;
	end
	if ( not character ) then
		character = DisplayedPlayerCharacterName;
	end
	local completed = QuestHistory_List[realm][character][questID].co;
	if ( completed ) then
		for index, value in QuestHistory_List[realm][character] do
			if ( value.co and ( value.co > completed ) ) then
				value.co = value.co - 1;
			end
		end
	end
	table.remove(QuestHistory_List[realm][character], questID);
end

-- Repairs quest data
local function QuestHistory_RepairData() -- BEGIN EMERALD FIX
	
	local playerName = UnitName("player");
	local repairCount = 0;

	--EMERALD: Kill bad entries before scanning for dupes
	for realmIndex, realmValue in QuestHistory_List do
		for charIndex, charValue in realmValue do
			for questIndex, questValue in charValue do
				if (string.find(questValue.d,UNKNOWNOBJECT)) then
					if (DEFAULT_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage("Removing #"..questIndex.." \""..questValue.t.."\" (BadEntry) from "..charIndex..".");
					end
					QuestHistory_DeleteQuest(questIndex, realmIndex, charIndex);
					questIndex = questIndex - 1;
					repairCount = repairCount + 1;
				end
			end
		end
	end
	
	for realmIndex, realmValue in QuestHistory_List do
		for charIndex, charValue in realmValue do
			for questIndex, questValue in charValue do
				if ( QuestHistoryFlags["removePortQuests"].status and ( questValue.t == "Port to Auberdine" or questValue.t == "Port to Menethil" ) ) then
					if (DEFAULT_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage("Removing #"..questIndex.." \""..questValue.t.."\" (Port) from "..charIndex..".");
					end
					QuestHistory_DeleteQuest(questIndex, realmIndex, charIndex);
					questIndex = questIndex - 1;
					repairCount = repairCount + 1;
				else
					if ( QuestHistoryFlags["removeDuplicates"].status ) then
						local offset = 0;
						for index = questIndex + 1, getn(charValue), 1 do
						
							-- EMERALD: Add checks here
							charValue[index - offset].d = string.gsub(charValue[index - offset].d,UNKNOWNOBJECT,charIndex);
							questValue.d = string.gsub(questValue.d,UNKNOWNOBJECT,charIndex);

							if ( charValue[index - offset].d == questValue.d and charValue[index - offset].t == questValue.t and index - offset ~= questIndex ) then
								if (DEFAULT_CHAT_FRAME) then
									DEFAULT_CHAT_FRAME:AddMessage("Removing #"..index.." \""..questValue.t.."\" (Duplicate) from "..charIndex..".");
								end
								QuestHistory_DeleteQuest(index - offset, realmIndex, charIndex);
								offset = offset + 1;
								repairCount = repairCount + 1;
							end
						end
					end -- END EMERALD FIX
					for dataIndex, dataValue in questValue do
						if ( QuestHistoryData[dataIndex] ) then
							local type = QuestHistoryData[dataIndex].type;
							if ( type == "number" ) then
								dataValue = tonumber(dataValue);
								if ( dataValue == 0 ) then
									dataValue = nil;
								end
							elseif ( type == "string" ) then
								dataValue = tostring(dataValue);
								if ( dataValue == "" ) then
									dataValue = nil;
								end
							elseif ( type == "item" ) then
								if ( dataValue.a == 1 ) then
									dataValue.a = nil;
								end
							elseif ( type == "objective" ) then
								if ( dataValue.f ~= 1 ) then
									dataValue.f = nil;
								end
							end
						elseif ( DEFAULT_CHAT_FRAME ) then
							DEFAULT_CHAT_FRAME:AddMessage("Cannot find "..dataIndex.." in QuestHistoryData.");
						end
					end
				end
			end
		end
	end
	QuestHistory_Refresh();
	DEFAULT_CHAT_FRAME:AddMessage("Repair finished. Removed "..repairCount.." entries.");
end

-- Reorders the quests in the displayed player's history
local function QuestHistory_ReorderQuests(oldQuestID, newQuestID)
	local temp = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][oldQuestID];
	if ( oldQuestID < newQuestID ) then
		newQuestID = newQuestID + 1;
	else
		oldQuestID = oldQuestID + 1;
	end
	table.insert(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName], newQuestID, temp);
	table.remove(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName], oldQuestID);
end

-- Reorders the completed status in the displayed player's history
local function QuestHistory_ReorderCompleted(old, new)
	local highest = 0;
	for index, value in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
		if ( value.co and highest < value.co ) then
			-- Store the highest value of the last completed quest
			highest = value.co;
		end
	end
	if ( new and new < 1 ) then
		new = highest + 1;
	end
	if ( old ) then
		if ( new ) then
			if ( new < old ) then
				-- Increment completed status of quests between new and old - 1
				for index, value in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
					if ( value.co and value.co >= new and value.co <= old - 1 ) then
						value.co = value.co + 1;
					end
				end
			else
				if ( new > highest ) then
					new = highest;
				end
				-- Decrement completed status of quests between old + 1 and new
				for index, value in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
					if ( value.co and value.co >= old + 1 and value.co <= new ) then
						value.co = value.co - 1;
					end
				end
			end
		else
			-- Decrement completed status of quests >= old + 1
			for index, value in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
				if ( value.co and value.co >= old + 1 ) then
					value.co = value.co - 1;
				end
			end
		end
	else
		if ( new ) then
			if ( new > highest ) then
				new = highest + 1;
			else
				-- Increment completed status of quests >= new
				for index, value in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
					if ( value.co and value.co >= new ) then
						value.co = value.co + 1;
					end
				end
			end
		else
			new = nil;
		end
	end
	return new;
end

-- Selects currently logged-in character as the currently displayed character
local function QuestHistory_SelectCurrentCharacter()
	local i = 0;
	for realmIndex, realmValue in QuestHistory_List do
		i = i + 1;
		for charIndex, charValue in realmValue do
			i = i + 1;
			if ( ( realmIndex == RealmName ) and ( charIndex == PlayerCharacterName ) ) then
				UIDropDownMenu_SetSelectedID(QuestHistoryOptionsFrameCharacterDropDown, i );
				break;
			end
		end
		if ( realmIndex == RealmName ) then
			break;
		end
	end
end

-- Deletes currently displayed character's data from QuestHistory_List
local function QuestHistory_DeleteCharacter()
	if ( RealmName ~= DisplayedRealmName or PlayerCharacterName ~= DisplayedPlayerCharacterName ) then
		local i = 0;
		QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] = nil;
		for charIndex, charValue in QuestHistory_List[DisplayedRealmName] do
			i = i + 1;
		end
		if ( i == 0 ) then
			QuestHistory_List[DisplayedRealmName] = nil;
		end
		QuestHistory_SelectCurrentCharacter();
		UIDropDownMenu_SetText(PlayerCharacterName, QuestHistoryOptionsFrameCharacterDropDown);
		DisplayedRealmName = RealmName;
		DisplayedPlayerCharacterName = PlayerCharacterName;
		QuestHistory_Refresh();
	end
end

-- Loads a hexadecimal value from QuestHistory_Flags if it exists and sets the flags accordingly
local function QuestHistory_LoadFlags()
	local sVal = QuestHistory_Flags;
	if ( sVal ) then
		local decVal = tonumber(sVal, 16);
		local flag;
		local numIndices = 0;
		for index, value in QuestHistoryFlags do
			numIndices = numIndices + 1;
		end
		for i = 1, numIndices, 1 do
			if ( math.mod(decVal, 2) == 0 ) then
				flag = false;
			else
				flag = true;
			end
			for index, value in QuestHistoryFlags do
				if ( value.index == i ) then
					value.status = flag;
					break;
				end
			end
			decVal = floor(decVal / 2);
		end
	end
end

-- Saves the flags as a hexadecimal value in QuestHistory_Flags
local function QuestHistory_SaveFlags()
	local val = 0;
	for index, value in QuestHistoryFlags do
		if ( value.status ) then
			val = val + 2 ^ (value.index - 1);
		end
	end
	QuestHistory_Flags = string.format("%X", val).."";
end

local function QuestHistory_LogCurrentQuests() -- BEGIN EMERALD FIX

	local questCategory = "";
	local playerName = UnitName("player");
	
	-- Cycle through the quests currently in the quest log
	for i = 1, GetNumQuestLogEntries(), 1 do
		local qTitle, qLevel, qTag, isHeader = GetQuestLogTitle(i);
		-- Check if quest title is a header
		if ( qTitle ) then -- EMERALD: Thanks, Asjaskan
			qTitle = string.gsub(string.gsub(qTitle,'^[[].*[]]',''),'^ ','');
		end
		if ( not isHeader ) then
			-- Not a header, so log information for this quest
			local questID;
			-- Select the quest
			SelectQuestLogEntry(i);
			-- Get the description and objectives of quest
			local qDescription, qObjectives = GetQuestLogQuestText();
			-- Find quest in QuestHistory_List if it has been logged already
			for index, value in QuestHistory_List[RealmName][PlayerCharacterName] do
				-- Compare descriptions if one has been logged
				if ( value.d ) then
					qDescription = string.gsub(qDescription,UNKNOWNOBJECT,playerName);
					value.d = string.gsub(value.d,UNKNOWNOBJECT,playerName);
					if ( qDescription == value.d ) then
						questID = index;
						-- Break out of for loop if quest has been found
						break;
					end -- END EMERALD FIX
				-- Otherwise, compare titles but don't break out until all quest descriptions have been checked
				elseif ( value.t ) then
					if ( qTitle == value.t and not value.co ) then
						questID = index;
					end
				end
			end
			-- Check if it is a new quest that hasn't been logged yet
			if ( not questID ) then
				-- Assign questID to be 1 more than the player's current number of logged quests
				questID = getn(QuestHistory_List[RealmName][PlayerCharacterName]) + 1;
				-- Create blank table to store quest data
				table.insert(QuestHistory_List[RealmName][PlayerCharacterName], { });
				-- Record quest title
				QuestHistory_List[RealmName][PlayerCharacterName][questID].t = qTitle;
				-- Record quest level if doing so
				if ( QuestHistoryFlags["logLevel"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][questID].l = qLevel;
				end
				-- Record quest tag if doing so
				if ( QuestHistoryFlags["logTag"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][questID].y = qTag;
				end
				-- Record quest location if doing so
				if ( QuestHistoryFlags["logCategory"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][questID].c = questCategory;
				end
				-- Record quest description if doing so
				if ( QuestHistoryFlags["logDescription"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][questID].d = qDescription;
				end
				-- Record quest objectives if doing so
				if ( QuestHistoryFlags["logObjectives"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][questID].o = qObjectives;
				end
				-- Record objectives status if doing so
				if ( QuestHistoryFlags["logObjectivesStatus"].status ) then
					local nObjectives = GetNumQuestLeaderBoards();
					if ( nObjectives and ( nObjectives > 0 ) ) then
						-- Create blank table to store quest objectives status
						QuestHistory_List[RealmName][PlayerCharacterName][questID].os = { };
						for j = 1, nObjectives, 1 do
							-- Create blank table for this objective
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["os"][j] = { };
						end
					end
				end
				-- Record player's level when quest was accepted/logged if doing so
				if ( QuestHistoryFlags["logLevelAccepted"].status ) then
					if ( questHasBeenRecentlyAccepted ) then
						QuestHistory_List[RealmName][PlayerCharacterName][questID].la = UnitLevel("player");
					else
						QuestHistory_List[RealmName][PlayerCharacterName][questID].ll = UnitLevel("player");
					end
				end
				-- Record played time when quest was accepted/logged if doing so
				if ( QuestHistoryFlags["logTimeAccepted"].status ) then
					if ( questHasBeenRecentlyAccepted ) then
						QuestHistory_List[RealmName][PlayerCharacterName][questID].ta = timeText;
					else
						QuestHistory_List[RealmName][PlayerCharacterName][questID].tl = timeText;
					end
				end
				-- Record required money if doing so
				if ( QuestHistoryFlags["logRequiredMoney"].status ) then
					local reqMoney = GetQuestLogRequiredMoney();
					if ( reqMoney and ( reqMoney > 0 ) ) then
						QuestHistory_List[RealmName][PlayerCharacterName][questID].rm = reqMoney;
					end
				end
				-- Record quest rewards if doing so
				if ( QuestHistoryFlags["logRewards"].status ) then
					local nRewards = GetNumQuestLogRewards();
					if ( nRewards and ( nRewards > 0 ) ) then
						-- Create blank table to store reward info
						QuestHistory_List[RealmName][PlayerCharacterName][questID].r = { };
						-- Cycle through number of quest rewards
						for j = 1, nRewards, 1 do
							-- Create blank table for this reward
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["r"][j] = { };
							-- Get data for quest reward
							local rName, rTexture, rNumItems, rQuality, rIsUsable = GetQuestLogRewardInfo(j);
							-- Record data for quest reward
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["r"][j].t = rTexture;
							if ( rNumItems > 1 ) then
								QuestHistory_List[RealmName][PlayerCharacterName][questID]["r"][j].a = rNumItems;
							end
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["r"][j].l = GetQuestLogItemLink("reward", j);
						end
					end
				end
				-- Record quest choices if doing so
				if ( QuestHistoryFlags["logChoices"].status ) then
					local nChoices = GetNumQuestLogChoices();
					if ( nChoices and ( nChoices > 0 ) ) then
						-- Create blank table to store choice info
						QuestHistory_List[RealmName][PlayerCharacterName][questID].i = { };
						-- Cycle through number of quest choices
						for j = 1, nChoices, 1 do
							-- Create blank table for this choice
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["i"][j] = { };
							-- Get data for quest choice
							local cName, cTexture, cNumItems, cQuality, cIsUsable = GetQuestLogChoiceInfo(j);
							-- Record data for quest choice
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["i"][j].t = cTexture;
							if ( cNumItems > 1 ) then
								QuestHistory_List[RealmName][PlayerCharacterName][questID]["i"][j].a = cNumItems;
							end
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["i"][j].l = GetQuestLogItemLink("choice", j);
						end
					end
				end
				-- Record quest spells if doing so
				if ( QuestHistoryFlags["logSpells"].status ) then
					if ( GetQuestLogRewardSpell() ) then
						-- Create blank table to store spell info
						QuestHistory_List[RealmName][PlayerCharacterName][questID].s = { };
						-- Get data for spell reward
						local sTexture, sName = GetQuestLogRewardSpell();
						-- Record data for spell reward
						QuestHistory_List[RealmName][PlayerCharacterName][questID]["s"].t = sTexture;
						QuestHistory_List[RealmName][PlayerCharacterName][questID]["s"].n = sName;
					end
				end
				-- Record reward money if doing so
				if ( QuestHistoryFlags["logRewardMoney"].status ) then
					local rewMoney = GetQuestLogRewardMoney();
					if  ( rewMoney and ( rewMoney > 0 ) ) then
						QuestHistory_List[RealmName][PlayerCharacterName][questID].m = rewMoney;
					end
				end
				-- Record background material if doing so
				if ( QuestHistoryFlags["logBackgroundMaterial"].status ) then
					local material = GetQuestBackgroundMaterial();
					if ( material ~= "Parchment" ) then
						QuestHistory_List[RealmName][PlayerCharacterName][questID].bg = material;
					end
				end
				-- Record accepted location if doing so
				if ( QuestHistoryFlags["logAcceptedLocation"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][questID].pa = recentlyAcceptedLocation;
					recentlyAcceptedLocation = nil;
				end
				-- Record quest giver if doing so
				if ( QuestHistoryFlags["logQuestGiver"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][questID].g = recentNPCQuestGiver;
					recentNPCQuestGiver = nil;
				end
				-- Check if recently accepted quest has been logged
				if ( questHasBeenRecentlyAccepted ) then
					-- Reset accepted flag
					questHasBeenRecentlyAccepted = nil;
					-- Break out of for loop since the quest most recently accepted has been logged
					break;
				end
			else
				-- Check if quest is failed
				if ( IsCurrentQuestFailed() ) then
					if ( not QuestHistory_List[RealmName][PlayerCharacterName][questID].f ) then
						QuestHistory_List[RealmName][PlayerCharacterName][questID].f = true;
						if ( not QuestHistory_List[RealmName][PlayerCharacterName][questID].fc ) then
							QuestHistory_List[RealmName][PlayerCharacterName][questID].fc = 1;
						else
							QuestHistory_List[RealmName][PlayerCharacterName][questID].fc = QuestHistory_List[RealmName][PlayerCharacterName][questID].fc + 1;
						end
					end
				else
					-- Mark quest as not failed
					QuestHistory_List[RealmName][PlayerCharacterName][questID].f = nil;
				end
				-- Make sure quest is not marked abandoned since it is currently in the quest log
				QuestHistory_List[RealmName][PlayerCharacterName][questID].a = nil;
			end
			-- Record quest objectives progress if doing so
			if ( QuestHistoryFlags["logObjectivesStatus"].status ) then
				if ( QuestHistory_List[RealmName][PlayerCharacterName][questID].os ) then
					local numObjectives = getn(QuestHistory_List[RealmName][PlayerCharacterName][questID]["os"]);
					for j = 1, numObjectives, 1 do
						local oText, oType, oFinished = GetQuestLogLeaderBoard(j);
						if ( not oText or strlen(oText) == 0 ) then
							oText = oType;
						end
						-- Check if quest objective has been finished
						if ( not oFinished or not QuestHistory_List[RealmName][PlayerCharacterName][questID]["os"][j].f ) then
							-- Update progress of objective
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["os"][j].t = oText;
							QuestHistory_List[RealmName][PlayerCharacterName][questID]["os"][j].f = oFinished;
						end
					end
				end
			end
		else
			-- Store header title as the zone location for the next quest
			questCategory = qTitle;
		end
	end
	-- Reset timer to disallow this function from being run again too soon
	timeSinceLastLog = 0;
	allowLogging = false;

	if ( QuestHistoryFrame:IsVisible() ) then
		QuestHistory_Refresh();
	end
end

----------------------------------------------------------------------------------------------------
-- On_Foo Functions
----------------------------------------------------------------------------------------------------

function QuestHistory_OnLoad()
	-- Register events for QuestHistoryFrame
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("QUEST_LOG_UPDATE");
	this:RegisterEvent("TIME_PLAYED_MSG");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_ALIVE");
	this:RegisterEvent("PLAYER_UNGHOST");
	-- Set up slash commands
	SLASH_QUESTHISTORY1 = "/questhistory";
	SLASH_QUESTHISTORY2 = "/qh";
	SlashCmdList["QUESTHISTORY"] = function(msg)
		QuestHistory_SlashCommandHandler(msg);
	end
	-- Hook the QuestDetailAcceptButton_OnClick function
	originalQuestDetailAcceptButton_OnClick = QuestDetailAcceptButton_OnClick;
	QuestDetailAcceptButton_OnClick = QuestHistory_QuestDetailAcceptButton_OnClick;
	-- Hook the QuestRewardCompleteButton_OnClick function
	originalQuestRewardCompleteButton_OnClick = QuestRewardCompleteButton_OnClick;
	QuestRewardCompleteButton_OnClick = QuestHistory_QuestRewardCompleteButton_OnClick;
	-- Hook the AbandonQuest function
	originalAbandonQuest = AbandonQuest;
	AbandonQuest = QuestHistory_AbandonQuest;
	-- Hook the ChatFrame_DisplayTimePlayed function
	originalChatFrame_DisplayTimePlayed = ChatFrame_DisplayTimePlayed;
	ChatFrame_DisplayTimePlayed = QuestHistory_ChatFrame_DisplayTimePlayed;
  -- Hook quest window open (v2.8)
	originalQuest_Save = QuestFrameGreetingPanel_OnShow;
	QuestFrameGreetingPanel_OnShow = QuestHistory_QuestFrameGreetingPanel_OnShow;
	-- Display a message in the ChatFrame indicating a successful load of this addon
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(format(QUESTHISTORY_LOAD_TEXT, QUESTHISTORY_VERSION));
	end
	-- Display a popup message indicating a successful load of this addon
	UIErrorsFrame:AddMessage(format(QUESTHISTORY_LOAD_TEXT, QUESTHISTORY_VERSION), 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

-- Handle quest window open (v2.8)
function QuestHistory_QuestFrameGreetingPanel_OnShow()
	originalQuest_Save();
	if (QuestHistory_Options["levels"]) then -- only if enabled
		local actQ, availQ = GetNumActiveQuests(), GetNumAvailableQuests();
		if (actQ + availQ == 0) then return; end
		local title, level, button;
		local o, GetTitle, GetLevel = 0, GetActiveTitle, GetActiveLevel;
		for i = 1, actQ + availQ do
			if(i == actQ + 1) then
				o, GetTitle, GetLevel = actQ, GetAvailableTitle, GetAvailableLevel;
			end
			title, level = GetTitle(i-o), GetLevel(i-o);
			button = getglobal("QuestTitleButton"..i);
			button:SetText(format('[%d] %s', level, title));
		end
	end
end

function QuestHistory_DelayedConfigInit_OnUpdate(elapsed)
	if (QuestHistory_DelayedConfigInit) then
		QuestHistory_DelayedLoginFired = true; -- This will prevent recurring delays
		QuestHistory_DelayedConfigInit = QuestHistory_DelayedConfigInit - elapsed;
		if (QuestHistory_DelayedConfigInit <= 0) then
			QuestHistory_LogCurrentQuests();
			QuestHistory_DelayedConfigInit = nil;
			QuestHistoryDelayedFrame:Hide();
		end
	else -- Stop receiving OnUpdates
		QuestHistoryDelayedFrame:Hide();
	end
end

function QuestHistory_OnEvent(event)

	if ( event == "PLAYER_LOGIN" ) then
		if (not QuestHistory_Loaded) then
		
			if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
				QHMN_ZoneNames = MapNotes_ZoneNames;
				QHMN_Data = MapNotes_Data;
				QHMN_SetNextAsMiniNote = MapNotes_SetNextAsMiniNote;
				QHMN_GetNoteBySlashCommand = MapNotes_GetNoteBySlashCommand;
			elseif (MetaMapNotes_Options) then
				QHMN_ZoneNames = MetaMapNotes_ZoneNames;
				QHMN_Data = MetaMapNotes_Data;
				QHMN_SetNextAsMiniNote = MetaMapNotes_SetNextAsMiniNote;
				QHMN_GetNoteBySlashCommand = MetaMapNotes_GetNoteBySlashCommand;
			end
			
			PlayerCharacterName = UnitName("player");
			DisplayedPlayerCharacterName = PlayerCharacterName;
			RealmName = GetCVar("realmName");
			DisplayedRealmName = RealmName;
			if (not QuestHistory_List) then QuestHistory_List = {}; end
			if (not QuestHistory_List[RealmName]) then
				QuestHistory_List[RealmName] = {};
			end
			if ( not QuestHistory_List[RealmName][PlayerCharacterName] ) then
				QuestHistory_List[RealmName][PlayerCharacterName] = {};
			end
			-- Upgrade the data to latest format
			QuestHistory_UpgradeData();
			-- Load the logging and displaying flags
			QuestHistory_LoadFlags();
			-- Load the colors of abandoned and completed quests
			if ( QuestHistory_StatusColors ) then
				for index, value in QuestHistory_StatusColors do
					QuestHistoryStatusColor[index] = value;
				end
			end
			-- Records the played time to use for quests accepted before this addon was installed if doing so
			if ( QuestHistoryFlags["logTimeAccepted"].status ) then
				timeEvent = "Logged";
				RequestTimePlayed();
			end
			if ( allowLogging ) then
				if (not QuestHistory_DelayedLoginFired) then
					QuestHistory_DelayedConfigInit = 10; -- EMERALD (thanks to UberQuest)
					QuestHistoryDelayedFrame:Show();
				else -- If QuestHistory_DelayedLoginFired, then we've done the login delay. No more long delays!
					QuestHistory_DelayedConfigInit = 1;
					QuestHistoryDelayedFrame:Show();
				end
			end

			if (not QuestHistory_Options) then
				QuestHistory_Options = {
					["levels"] = true, -- on by default
					};
			elseif (QuestHistory_Options["levels"]==nil) then
				QuestHistory_Options["levels"] = true; -- on by default
			end

			QuestHistory_Loaded = true;
		end
	
	elseif ( event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_ALIVE" or event == "PLAYER_UNGHOST" ) then
		local playerX, playerY = GetPlayerMapPosition("player");
		-- EMERALD: New attempt to prevent the Blizzard 0,0 bug -- doing so before the quest events happen, not during
		if (playerX==0 and playerY==0) then
			ShowUIPanel(WorldMapFrame);
			HideUIPanel(WorldMapFrame);
		end
	
	elseif ( event == "QUEST_LOG_UPDATE" and QuestHistory_Loaded ) then
		-- Following condition needed to make sure player name has been assigned
		if ( PlayerCharacterName ) then
			-- Check if a quest has been recently completed
			if ( recentlyCompletedQuestID ) then
				-- If so and XP logging is enabled, log the XP that was gained.
				-- Needed here because the player's XP is not actually increased
				-- until some time after the CompleteQuest() function is run
				if ( QuestHistoryFlags["logXPReward"].status ) then
					local newXP = UnitXP("player") - XPBeforeQuestCompletion;
					-- Check if XP has been updated after quest
					if ( newXP ~= 0 ) then
						-- Check if XP now is less than XP before quest was completed
						if ( newXP < 0 ) then
							-- If so, player leveled so add the previous max XP recorded to get correct value of XP gained
							newXP = newXP + XPMaxBeforeQuestCompletion;
						end
						-- Log the XP Reward
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].x = newXP;
						-- Reset variable values
						XPBeforeQuestCompletion = 0;
						XPMaxBeforeQuestCompletion = 0;
						recentlyCompletedQuestID = nil;
					end
				else
					-- If XP logging is not enabled, just reset recentlyCompletedQuestID
					recentlyCompletedQuestID = nil;
				end
			end
			-- Check if a quest has been recently abandoned
			if ( questHasBeenRecentlyAbandoned ) then
				-- Just reset the recently abandoned flag
				questHasBeenRecentlyAbandoned = nil;
			-- If a quest hasn't been recently completed or abandoned, check if
			-- it is okay to call LogCurrentQuests() to log new quests or update
			-- current ones
			elseif ( allowLogging ) then
				--QuestHistory_LogCurrentQuests();
				if (not QuestHistory_DelayedLoginFired) then
					QuestHistory_DelayedConfigInit = 10; -- EMERALD (thanks to UberQuest)
					QuestHistoryDelayedFrame:Show();
				else -- If QuestHistory_DelayedLoginFired, then we've done the login delay. No more long delays!
					QuestHistory_DelayedConfigInit = 0;
					QuestHistoryDelayedFrame:Show();
				end
			end
			-- Refreshes the display of the QuestHistory frame if it is visible
			if ( QuestHistoryFrame:IsVisible() ) then
				QuestHistory_Refresh();
			end
		end
	elseif ( event == "TIME_PLAYED_MSG" ) then
		if ( timeEvent == "Accepted" or timeEvent == "Completed" or timeEvent == "Logged" ) then
			-- Format and save current played time
			timeText = format(TEXT(QUESTHISTORY_TIME_FORMAT), ChatFrame_TimeBreakDown(arg1));
			-- Check if TIME_PLAYED_MSG event occurred when a quest was just completed
			if ( timeEvent == "Completed" ) then
				-- Record the quest completed time if doing so
				if ( QuestHistoryFlags["logTimeCompleted"].status ) then
					-- Make sure recentlyCompletedQuestID has been assigned a good value
					if ( recentlyCompletedQuestID ) then
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].tc = timeText;
						if ( QuestHistoryFlags["logTimeAccepted"].status and ( not QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].ta ) and ( not QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].tl ) ) then
							QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].ta = timeText;
						end
					end
				end
			end
		end
	end
end

function QuestHistory_OnShow()
	PlaySound("igMainMenuOpen");
	QuestHistory_Refresh();
end

function QuestHistory_OnHide()
	PlaySound("igMainMenuClose");
	HideUIPanel(QuestHistoryDetailFrame);
	HideUIPanel(QuestHistoryEditFrame);
	HideUIPanel(QuestHistoryOptionsFrame);
	HideUIPanel(QuestHistoryConfirmFrame);
	QuestHistoryFrameSearchEditBox:Hide();
	QuestHistoryFrameClearButton:Hide();
	QuestHistoryFrameSubmitButton:Hide();
	QuestHistoryFrameSearchButton:Show();
end

function QuestHistoryFrameSortDropDown_OnLoad()
	UIDropDownMenu_Initialize(QuestHistoryFrameSortDropDown, QuestHistoryFrameSortDropDown_Initialize);
	if ( not QuestHistoryFrameSortDropDown.selectedID ) then
		UIDropDownMenu_SetSelectedID(QuestHistoryFrameSortDropDown, 1 );
	end
	UIDropDownMenu_SetWidth(QUESTHISTORY_SORT_DROPDOWN_MENU_WIDTH);
	UIDropDownMenu_JustifyText("CENTER", QuestHistoryFrameSortDropDown);
end

function QuestHistoryFrameSortDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(QuestHistoryFrameSortDropDown, this:GetID());
	QuestHistory_SetSortOrder();
end

function QuestHistory_SortButton_OnClick()
	UIDropDownMenu_SetSelectedID(QuestHistoryFrameSortDropDown, this:GetID());
	QuestHistory_SetSortOrder();
end

function QuestHistoryListFrame_OnClick(button)
	if ( button == "LeftButton" ) then
		if ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
			-- Insert quest title, level, category, tag into ChatFrame if Shift-leftclicked and chat frame is visible
			local frame = "QuestHistoryListFrame"..this:GetID();
			local title = getglobal(frame.."TitleText"):GetText();
			local level = getglobal(frame.."LevelText"):GetText();
			local category = getglobal(frame.."CategoryText"):GetText();
			local tag = getglobal(frame.."TagText"):GetText();
			if ( tag and tag ~= "" ) then
				tag = " ["..tag.."]";
			else
				tag = "";
			end
			local text = title.." - "..level.." - "..category..tag;
			ChatFrameEditBox:Insert(text);
		else
			currentTitleListID = this:GetID();
			local index = currentTitleListID + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
			currentSortedID = index;
			currentDetailedQuestID = SortedTable[index];
			QuestHistory_Detail_Update(currentDetailedQuestID);
			ShowUIPanel(QuestHistoryDetailFrame);
			QuestHistoryListHighlightFrame:SetPoint("LEFT", "QuestHistoryListFrame"..currentTitleListID, "LEFT", 0, -2);
			QuestHistoryListHighlightFrame:Show();
		end
	elseif ( button == "RightButton" ) then
		if ( IsShiftKeyDown() and QuestHistoryFlags["allowDeleting"].status ) then
			local index = this:GetID() + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
			QuestHistory_DeleteQuest(SortedTable[index]);
			if ( getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]) and getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]) > 0 ) then
				if ( index ~= 1 ) then
					index = index - 1;
				end
				currentSortedID = index;
				currentDetailedQuestID = SortedTable[index];
				QuestHistory_Detail_Update(currentDetailedQuestID);
			else
				currentSortedID = 0;
				HideUIPanel(QuestHistoryDetailFrame);
			end
			QuestHistory_Refresh();
		elseif ( QuestHistoryFlags["allowEditing"].status ) then
			currentTitleListID = this:GetID();
			local index = currentTitleListID + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
			currentSortedID = index;
			currentDetailedQuestID = SortedTable[index];
			QuestHistoryEditTitle:SetText(QUESTHISTORY_EDIT_TEXT);
			QuestHistory_EditQuest(SortedTable[index]);
			QuestHistoryEditFrameSaveButton:Show();
			QuestHistoryEditFrameAddButton:Hide();
			ShowUIPanel(QuestHistoryEditFrame);
			QuestHistoryListHighlightFrame:SetPoint("LEFT", "QuestHistoryListFrame"..currentTitleListID, "LEFT", 0, -2);
			QuestHistoryListHighlightFrame:Show();
		end
	end
end

-- Displays quest note in a tootip-like button that appears when the mouse hovers over an item in the quest list
function QuestHistoryListFrame_OnEnter()
	local note = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][SortedTable[this:GetID() + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame)]].n;
	if ( note ~= nil and note ~= "" ) then
		QuestHistoryTooltip:SetPoint("TOPLEFT", "QuestHistoryListFrame"..this:GetID().."CompletedText", "TOPRIGHT", 15, 0);
		QuestHistoryTooltipText:SetText(note);
		QuestHistoryTooltip:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
		QuestHistoryTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
		QuestHistoryTooltip:Show();
	end
end

-- Hides the search button and shows the clear button and the search edit box
function QuestHistoryFrameSearchButton_OnClick()
	QuestHistoryFrameClearButton:Show();
	if ( searchText ) then
		QuestHistoryFrameSearchEditBox:SetText(searchText);
	end
end

-- Clears the search text and refreshes the quest list
function QuestHistoryFrameClearButton_OnClick()
	QuestHistoryFrameSearchEditBox:SetText("");
	searchText = nil;
	QuestHistory_Refresh();
end

-- Saves the entered search text and refreshes the quest list
function QuestHistoryFrameSearchEditBox_OnEnterPressed()
	searchText = QuestHistoryFrameSearchEditBox:GetText();
	QuestHistoryFrameSearchEditBox:AddHistoryLine(searchText);
	QuestHistory_Refresh();
	QuestHistoryFrameSearchButton:Show();
end

-- Registers events for the detail frame
function QuestHistoryDetailFrame_OnLoad()
	this:RegisterEvent("QUEST_LOG_UPDATE");
	this:RegisterEvent("UPDATE_FACTION");
end

-- Updates the detail frame if one of the registered events occur while the frame is visible
function QuestHistoryDetailFrame_OnEvent()
	if ( event == "QUEST_LOG_UPDATE" or event == "UPDATE_FACTION" ) then
		if ( QuestHistoryDetailFrame:IsVisible() ) then
			QuestHistory_Detail_Update(currentDetailedQuestID);
		end
	end
end

-- Sets up the tooltip for the reward items in the detailed quest view
function QuestHistoryDetailRewardItem_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	local itemNumber = this:GetID();
	local linkText, itemLink;
	-- Gets the item hyperlink and processes it
	if ( this.type == "choice" ) then
		linkText = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID]["i"][itemNumber].l;
		itemLink = QuestHistory_ProcessLinks(linkText);
	elseif ( this.type == "reward" ) then
		linkText = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID]["r"][itemNumber].l;
		itemLink = QuestHistory_ProcessLinks(linkText);
	end
	-- Sets the hyperlink to the game tooltip if it exists
	if ( itemLink ) then
		GameTooltip:SetHyperlink(itemLink);
	end
end

-- Allows item to be copied to ChatFrame if Shift-leftclicked
function QuestHistoryDetailRewardItem_OnClick()
	if ( IsShiftKeyDown() ) then
		local linkText;
		if ( ChatFrameEditBox:IsVisible() ) then
			local itemNumber = this:GetID();
			if ( this.type == "choice" ) then
				linkText = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID]["i"][itemNumber].l;
			elseif ( this.type == "reward" ) then
				linkText = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID]["r"][itemNumber].l;
			end
		end
		-- Adds the link to the chat frame
		if ( linkText ) then
			ChatFrameEditBox:Insert(linkText);
		end
	end
end

-- Tabs between edit boxes in QuestHistoryEditFrame
function QuestHistoryEditBox_OnTabPressed()
	local id;
	local numBoxes = 0;
	local _, _, name = string.find(this:GetName(), "QuestHistoryEdit(.*)EditBox");
	for index, value in QuestHistoryData do
		if ( value.box ) then
			numBoxes = numBoxes + 1;
		end
		if ( value.box == name ) then
			id = value.tab;
		end
	end
	if ( IsShiftKeyDown() ) then
		id = id - 1;
	else
		id = id + 1;
	end
	if ( id < 1 ) then
		id = numBoxes;
	elseif ( id > numBoxes ) then
		id = 1;
	end
	local tabIndex;
	for index, value in QuestHistoryData do
		if ( value.tab == id ) then
			tabIndex = index;
		end
	end
	getglobal("QuestHistoryEdit"..QuestHistoryData[tabIndex].box.."EditBox"):SetFocus();
	if ( id >= 5 and id <= 10 ) then
		QuestHistoryEditListScrollFrameScrollBar:SetValue(0);
	elseif ( id >= 15 and id <= 21 ) then
		QuestHistoryEditListScrollFrameScrollBar:SetValue(100);
	end
end

function QuestHistoryEditFrameSaveButton_OnClick()
	local index = currentTitleListID + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
	local data, questID = QuestHistory_GetEditData();
	if ( questID ~= SortedTable[index] ) then
		if ( questID > getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]) ) then
			questID = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]);
		end
		QuestHistory_ReorderQuests(SortedTable[index], questID);
	end
	for index, value in data do
		if ( index == "co" and value ~= QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID].co ) then
			if ( value == "" ) then
				value = nil;
			end
			local old = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID].co;
			QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID].co = QuestHistory_ReorderCompleted(old, value);
		elseif ( value ~= "" ) then
			QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID][index] = value;
		else
			QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questID][index] = nil;
		end
	end
	currentDetailedQuestID = questID;
	QuestHistory_Refresh();
	QuestHistory_EditQuest(questID);
end

function QuestHistoryEditFrameAddButton_OnClick()
	local data, questID = QuestHistory_GetEditData();
	if ( questID > getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]) + 1 ) then
		questID = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]) + 1;
	end
	for index, value in data do
		if ( value == "" ) then
			data[index] = nil;
		elseif ( index == "co" ) then
			data.co = QuestHistory_ReorderCompleted(nil, value);
		end
	end
	table.insert(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName], questID, data);
	currentDetailedQuestID = questID;
	QuestHistory_Refresh();
	QuestHistory_AddQuest();
end

-- Sets the checkboxes to the appropriate values from QuestHistoryFlags
function QuestHistoryOptionsFrame_OnShow()
	for index, value in QuestHistoryFlags do
		local button = getglobal("QuestHistoryOptionsFrameCheckButton"..value.index);
		local string = getglobal("QuestHistoryOptionsFrameCheckButton"..value.index.."Text");
		string:SetText(TEXT(value.text));
		button.tooltipText = value.tooltipText;
		if ( value.status ) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end
end

function QuestHistoryColorSwatch_OnShow(status)
	this.status = status;
	lowstatus = string.lower(status);
	this.swatchFunc = QuestHistory_SetColor;
	this.cancelFunc = QuestHistory_CancelColor;
	this.r = QuestHistoryStatusColor[lowstatus].r;
	this.g = QuestHistoryStatusColor[lowstatus].g;
	this.b = QuestHistoryStatusColor[lowstatus].b;
	getglobal(this:GetName().."NormalTexture"):SetVertexColor(this.r, this.g, this.b);
end

function QuestHistoryOptionsFrameCharacterDropDown_OnShow()
	UIDropDownMenu_Initialize(QuestHistoryOptionsFrameCharacterDropDown, QuestHistoryOptionsFrameCharacterDropDown_Initialize);
	if ( not QuestHistoryOptionsFrameCharacterDropDown.selectedID ) then
		QuestHistory_SelectCurrentCharacter();
	end
	UIDropDownMenu_SetWidth(QUESTHISTORY_CHARACTER_DROPDOWN_MENU_WIDTH);
end

function QuestHistoryOptionsFrameCharacterDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(QuestHistoryOptionsFrameCharacterDropDown, this:GetID());
	button = getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..this:GetID());
	_, _, DisplayedPlayerCharacterName = string.find(button:GetText(), "    (.*)");
	DisplayedRealmName = button.value;
	currentDetailedListID = nil;
	currentSortedID = 0;
	currentTitleListID = nil;
	QuestHistory_Refresh();
end

function QuestHistoryOptionsFrameDeleteButton_OnClick()
	if ( RealmName ~= DisplayedRealmName or PlayerCharacterName ~= DisplayedPlayerCharacterName ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
		QuestHistoryOptionsFrameOkayButton_OnClick();
		QuestHistoryConfirmFrameExplanation:SetText(QUESTHISTORY_DELETE_CONFIRM_EXPLANATION);
		ShowUIPanel(QuestHistoryConfirmFrame);
	end
end

function QuestHistory_AddQuest()
	QuestHistoryEditTitle:SetText(QUESTHISTORY_ADD_TEXT);
	QuestHistory_ClearQuest();
	QuestHistoryEditAcceptedOrderEditBox:SetText(getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName])+ 1);
	QuestHistoryEditFrameSaveButton:Hide();
	QuestHistoryEditFrameAddButton:Show();
	ShowUIPanel(QuestHistoryEditFrame);
end

-- Saves the checkbox values in QuestHistoryFlags
function QuestHistoryOptionsFrameOkayButton_OnClick()
	for index, value in QuestHistoryFlags do
		value.status = getglobal("QuestHistoryOptionsFrameCheckButton"..value.index):GetChecked();
	end
	QuestHistory_SaveFlags();
	HideUIPanel(QuestHistoryOptionsFrame);
	QuestHistory_Refresh();
end

function QuestHistoryConfirmFrameOkayButton_OnClick()
	local text = QuestHistoryConfirmFrameExplanation:GetText();
	if ( text == QUESTHISTORY_PURGE_CONFIRM_EXPLANATION ) then
		QuestHistory_PurgeData();
	elseif ( text == QUESTHISTORY_DELETE_CONFIRM_EXPLANATION ) then
		QuestHistory_DeleteCharacter();
	elseif ( text == QUESTHISTORY_REPAIR_CONFIRM_EXPLANATION ) then
		QuestHistory_RepairData();
	end
end

-- Keeps track of the time since the last logging of quest data
function QuestHistory_Timer_OnUpdate()
	-- Check if flag is set to disable logging
	if ( not allowLogging ) then
		-- Increase time since last log
		timeSinceLastLog = timeSinceLastLog + arg1;
		-- Check if it has been at least 0.1 seconds since the last logging
		if ( timeSinceLastLog > 0.1 ) then
			-- Set flag to allow logging
			allowLogging = true;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Hooked Functions
----------------------------------------------------------------------------------------------------

-- Needed so that QuestHistory knows when a quest has been accepted, also to
-- record the player's target, location and time when a quest is accepted
function QuestHistory_QuestDetailAcceptButton_OnClick()
	-- Flag that a quest has just been accepted
	questHasBeenRecentlyAccepted = true;
	-- Save the name of the current target to store as the quest giver
	recentNPCQuestGiver = UnitName("target");
	-- Save the player's location where quest was accepted
	local playerX, playerY = GetPlayerMapPosition("player");
	-- EMERALD: NOTE: This is the one that fired in instances, in all reports given.
	--if (playerX==0 and playerY==0) then
		--ShowUIPanel(WorldMapFrame);
		--HideUIPanel(WorldMapFrame);
		--playerX, playerY = GetPlayerMapPosition("player");
		--QuestHistory_InsideInstance = true; -- set to prevent 0,0 lock
	--end
	--QuestHistory_InsideInstance = false;
	local zone = GetZoneText();
	recentlyAcceptedLocation = zone..":"..playerX..":"..playerY;
	-- Get the played time when the quest was accepted if doing so
	if ( QuestHistoryFlags["logTimeAccepted"].status ) then
		timeEvent = "Accepted";
		RequestTimePlayed();
	end
	-- Call the original QuestDetailAcceptButton_OnClick function
	originalQuestDetailAcceptButton_OnClick();
end

-- Needed to record the player's target, level, location, time and XP when a
-- quest is completed -- also keeps track of the order in which quests are
-- completed
function QuestHistory_QuestRewardCompleteButton_OnClick()
	local rewardTitle = GetTitleText();
	local rewardDescription = GetRewardText();
	local skipQuest;
	if ( QuestHistoryFlags["logPortQuests"] or ( rewardTitle ~= "Port to Auberdine" and rewardTitle ~= "Port to Menethil" ) ) then
		recentlyCompletedQuestID = nil;
		-- Look through the currently logged quests to find the highest value of the completed quests
		local highestCompleted = 0;
    
    -- EMERALD DEBUG
    --DEFAULT_CHAT_FRAME:AddMessage("RealmName = "..RealmName);
    --DEFAULT_CHAT_FRAME:AddMessage("PlayerCharacterName = "..PlayerCharacterName);
    
		for index, value in QuestHistory_List[RealmName][PlayerCharacterName] do
			if ( value.co and highestCompleted < value.co ) then
				-- Store the highest value of the last completed quest
				highestCompleted = value.co;
			end
		end
		-- Look through the currently logged quests to find the one most recently completed by comparing titles
		for index, value in QuestHistory_List[RealmName][PlayerCharacterName] do
			-- Check if the quest has been marked completed
			if ( value.co ) then
				-- If so, then check if its description meets the reward description
				if ( rewardDescription == value.d ) then
					-- This quest has been logged before so skip it.
					skipQuest = true;
				end
			else
				-- If the quest has not been marked completed, check its title
				if ( rewardTitle == value.t ) then
					-- Store the index of the quest most recently completed
					recentlyCompletedQuestID = index;
					-- Don't skip this quest
					skipQuest = nil;
					-- Break out of the for loop if the quest is found
					break;
				end
			end
		end
		if ( not skipQuest ) then
			-- Check if quest is completed without ever being accepted and added to quest log
			if ( not recentlyCompletedQuestID ) then
				-- Set the last completed to 1 more than the player's current number of logged quests
				recentlyCompletedQuestID = getn(QuestHistory_List[RealmName][PlayerCharacterName]) + 1;
				-- Create a new blank quest entry
				table.insert(QuestHistory_List[RealmName][PlayerCharacterName], { });
				-- Record quest title
				QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].t = rewardTitle;
				-- Record quest description if doing so
				if ( QuestHistoryFlags["logDescription"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].d = rewardDescription;
				end
				-- Record quest category if doing so
				if ( QuestHistoryFlags["logCategory"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].c = GetZoneText();
				end
				-- Record player's level when quest was accepted if doing so
				if ( QuestHistoryFlags["logLevelAccepted"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].la = UnitLevel("player");
				end
				-- Record accepted location if doing so
				if ( QuestHistoryFlags["logAcceptedLocation"].status ) then
					local playerX, playerY = GetPlayerMapPosition("player");
					--if (playerX==0 and playerY==0 and not QuestHistory_InsideInstance) then
						--ShowUIPanel(WorldMapFrame);
						--HideUIPanel(WorldMapFrame);
						--playerX, playerY = GetPlayerMapPosition("player");
						--QuestHistory_InsideInstance = true; -- set to prevent 0,0 lock
		-- if (playerX==0 and playerY==0) then
			-- if ( DEFAULT_CHAT_FRAME ) then
				-- DEFAULT_CHAT_FRAME:AddMessage("QuestHistory: WARNING! Your coordinates are being reported as 0,0. Please give this code to Dsanai: BN2");
			-- end
		-- end
					--end
					--QuestHistory_InsideInstance = false;
					local zone = GetZoneText();
					QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].pc = zone..":"..playerX..":"..playerY;
				end
				-- Record quest giver if doing so
				if ( QuestHistoryFlags["logQuestGiver"].status ) then
					QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].g = UnitName("target");
				end
				-- Record required money if doing so
				if ( QuestHistoryFlags["logRequiredMoney"].status ) then
					local reqMoney = GetQuestMoneyToGet();
					if ( reqMoney and ( reqMoney > 0 ) ) then
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].rm = reqMoney;
					end
				end
				-- Record quest rewards if doing so
				if ( QuestHistoryFlags["logRewards"].status ) then
					local nRewards = GetNumQuestRewards();
					if ( nRewards and ( nRewards > 0 ) ) then
						-- Create blank table to store reward info
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].r = { };
						-- Cycle through number of quest rewards
						for j = 1, nRewards, 1 do
							-- Create blank table for this reward
							QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["r"][j] = { };
							-- Get data for quest reward
							local rName, rTexture, rNumItems, rQuality, rIsUsable = GetQuestItemInfo("reward", j);
							-- Record data for quest reward
							QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["r"][j].t = rTexture;
							if ( rNumItems > 1 ) then
								QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["r"][j].a = rNumItems;
							end
							QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["r"][j].l = GetQuestItemLink("reward", j);
						end
					end
				end
				-- Record quest choices if doing so
				if ( QuestHistoryFlags["logChoices"].status ) then
					local nChoices = GetNumQuestChoices();
					if ( nChoices and ( nChoices > 0 ) ) then
						-- Create blank table to store choice info
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].i = { };
						-- Cycle through number of quest choices
						for j = 1, nChoices, 1 do
							-- Create blank table for this choice
							QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["i"][j] = { };
							-- Get data for quest choice
							local cName, cTexture, cNumItems, cQuality, cIsUsable = GetQuestItemInfo("choice", j);
							-- Record data for quest choice
							QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["i"][j].t = cTexture;
							if ( cNumItems > 1 ) then
								QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["i"][j].a = cNumItems;
							end
							QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID]["i"][j].l = GetQuestItemLink("choice", j);
						end
					end
				end
				-- Record quest spells if doing so
				if ( QuestHistoryFlags["logSpells"].status ) then
					if ( GetRewardSpell() ) then
						-- Create blank table to store spell info
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].s = { };
						-- Get data for spell reward
						local sTexture, sName = GetRewardSpell();
						-- Record data for spell reward
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].t = sTexture;
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].n = sName;
					end
				end
				-- Record reward money if doing so
				if ( QuestHistoryFlags["logRewardMoney"].status ) then
					local rewMoney = GetRewardMoney();
					if  ( rewMoney and ( rewMoney > 0 ) ) then
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].m = rewMoney;
					end
				end
				-- Record background material if doing so
				if ( QuestHistoryFlags["logBackgroundMaterial"].status ) then
					local material = QuestFrame_GetMaterial();
					if ( material ~= "Parchment" ) then
						QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].bg = material;
					end
				end
			end
			-- If logging XP reward, record the current XP and current XP max
			if ( QuestHistoryFlags["logXPReward"].status ) then
				XPBeforeQuestCompletion = UnitXP("player");
				XPMaxBeforeQuestCompletion = UnitXPMax("player");
			end
			-- Record player's level when quest was completed if doing so
			if ( QuestHistoryFlags["logLevelCompleted"].status ) then
				QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].lc = UnitLevel("player");
			end
			-- Record order of quest completed if doing so
			if ( QuestHistoryFlags["logCompletedOrder"].status ) then
				QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].co = highestCompleted + 1;
			end
			-- Record quest completer if doing so
			if ( QuestHistoryFlags["logQuestCompleter"].status ) then
				QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].w = UnitName("target");
			end
			-- Record completed location if doing so
			if ( QuestHistoryFlags["logCompletedLocation"].status ) then
				local playerX, playerY = GetPlayerMapPosition("player");
				--if (playerX==0 and playerY==0 and not QuestHistory_InsideInstance) then
					--ShowUIPanel(WorldMapFrame);
					--HideUIPanel(WorldMapFrame);
					--playerX, playerY = GetPlayerMapPosition("player");
					--QuestHistory_InsideInstance = true; -- set to prevent 0,0 lock
		-- if (playerX==0 and playerY==0) then
			-- if ( DEFAULT_CHAT_FRAME ) then
				-- DEFAULT_CHAT_FRAME:AddMessage("QuestHistory: WARNING! Your coordinates are being reported as 0,0. Please give this code to Dsanai: LK6");
			-- end
		-- end
				--end
				--QuestHistory_InsideInstance = false;
				local zone = GetZoneText();
				QuestHistory_List[RealmName][PlayerCharacterName][recentlyCompletedQuestID].pc = zone..":"..playerX..":"..playerY;
			end
			-- Get the played time when quest was completed if doing so
			if ( QuestHistoryFlags["logTimeCompleted"].status ) then
				timeEvent = "Completed";
				RequestTimePlayed();
			end
		end
	end
	-- Call the original QuestRewardCompleteButton_OnClick function
	originalQuestRewardCompleteButton_OnClick();
end

-- Marks a quest as abandoned and updates the times abandoned count.
function QuestHistory_AbandonQuest()
	-- Flag that a quest has just been abandoned
	questHasBeenRecentlyAbandoned = true;
	-- Store the quest title so the right quest is marked abandoned
	local questTitle = GetQuestLogTitle(GetQuestLogSelection());
	if ( questTitle ) then -- EMERALD: Thanks, Asjaskan
		questTitle = string.gsub(string.gsub(questTitle,'^[[].*[]]',''),'^ ','');
	end

	-- Call the original AbandonQuest function
	originalAbandonQuest();
	-- Look through the currently logged quests to mark the one abandoned
	for index, value in QuestHistory_List[RealmName][PlayerCharacterName] do
		-- Check if the quest matches the title and that it hasn't been marked completed
		if ( questTitle == value.t and ( not value.co ) ) then
			-- Mark the quest has abandoned
			value.a = true;
			-- Update the quest's count of times abandoned
			if ( not value.ac ) then
				value.ac = 1;
			else
				value.ac = value.ac + 1;
			end
			-- Break out of the for loop if the right quest was found
			break;
		end
	end
end

-- Prevents played time from being displayed in the chat frame whenever it is
-- invoked for a quest being accepted/logged/completed.
function QuestHistory_ChatFrame_DisplayTimePlayed(totalTime, levelTime)
	if ( timeEvent == "Accepted" or timeEvent == "Logged" or timeEvent == "Completed" ) then
		-- Clear the value of timeEvent
		timeEvent = "";
	else
		-- Only call the original ChatFrame_DisplayTimePlayed function if it
		-- wasn't invoked by the accepting/logging/completing of a quest
		originalChatFrame_DisplayTimePlayed(totalTime, levelTime)
	end
end

----------------------------------------------------------------------------------------------------
-- Callback Functions
----------------------------------------------------------------------------------------------------

-- Toggles the showing/hiding of the QuestHistoryFrame
function QuestHistory_Toggle()
	if ( QuestHistoryFrame:IsVisible() ) then
		HideUIPanel(QuestHistoryFrame);
	else
		ShowUIPanel(QuestHistoryFrame);
	end
end

-- Handles the processing of the registered slash commands
function QuestHistory_SlashCommandHandler(msg)
	if (msg and string.lower(msg)=="levels") then -- EMERALD
		if (QuestHistory_Options["levels"]) then -- disable Levels
			QuestHistory_Options["levels"] = false;
			if ( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("QuestHistory: NPC Quest Level display is now disabled.");
			end
		else -- enable Levels
			QuestHistory_Options["levels"] = true;
			if ( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("QuestHistory: NPC Quest Level display is now enabled.");
			end
		end
	else
		QuestHistory_Toggle();
	end
end

-- Updates the display of the main QuestHistory frame and determines which
-- quests are shown in the visible scrollframe
function QuestHistory_Update()
	-- Get number of quests stored for current player
	local listSize = getn(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName]);
	local QuestHistoryTitle = QuestHistoryTitleText;
	-- Build sorted table if it hasn't been created yet
	if ( not SortedTable ) then
		QuestHistory_BuildSortedTable();
	end
	-- Highlight currently selected quest if it is visible in the scrollframe
	currentTitleListID = currentSortedID - FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
	if ( currentTitleListID >= 1 and currentTitleListID <= 31 ) then
		QuestHistoryListHighlightFrame:SetPoint("LEFT", "QuestHistoryListFrame"..currentTitleListID, "LEFT", 0, -2);
		QuestHistoryListHighlightFrame:Show();
	else
		-- Hide the highlight frame since selected quest is not visible in the scrollframe
		QuestHistoryListHighlightFrame:Hide();
	end
	-- Format QuestHistory title appropriately depending on how many quests are logged
	if ( listSize and ( listSize == 1 ) ) then
		QuestHistoryTitle:SetText(format(TEXT(QUESTHISTORY_TITLE_FORMAT_SINGULAR), DisplayedPlayerCharacterName));
	else
		QuestHistoryTitle:SetText(format(TEXT(QUESTHISTORY_TITLE_FORMAT_PLURAL), DisplayedPlayerCharacterName, listSize));
	end
	-- Update the scroll frame and add the quest data
	FauxScrollFrame_Update(QuestHistoryListScrollFrame, sizeSortedTable, QUESTHISTORY_ITEMS_SHOWN, QUESTHISTORY_ITEM_HEIGHT);
	for iQuest = 1, QUESTHISTORY_ITEMS_SHOWN, 1 do
		local questIndex = iQuest + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
		local listFrame = "QuestHistoryListFrame"..iQuest;
		if ( questIndex <= sizeSortedTable ) then
			local color;
			-- Get quest information
			local index = SortedTable[questIndex];
			local title = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].t;
			local level = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].l;
			local category = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].c;
			local tag = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].y;
			local completed = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].co;
			-- Check to make sure none of the data is nil
			if ( not title ) then
				title = "";
			end
			if ( not level ) then
				level = "";
			end
			if ( not category ) then
				category = "";
			end
			if ( not tag ) then
				tag = "";
			end
			-- Add quest data to frame
			getglobal(listFrame.."AcceptedText"):SetText(index);
			getglobal(listFrame.."TitleText"):SetText(title);
			getglobal(listFrame.."LevelText"):SetText(level);
			getglobal(listFrame.."CategoryText"):SetText(category);
			getglobal(listFrame.."TagText"):SetText(tag);
			if ( completed ) then
				-- If quest has been completed, show checkmark and completed number in brackets
				getglobal(listFrame.."CompletedText"):SetText("["..completed.."]");
				getglobal(listFrame.."CheckMark"):Show();
			else
				-- Otherwise, hide checkmark and display nothing for completed
				getglobal(listFrame.."CompletedText"):SetText("");
				getglobal(listFrame.."CheckMark"):Hide();
			end
			-- Set color depending on quest status
			if (completed) then
				color = QuestHistoryStatusColor["completed"];
			elseif ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].a ) then
				color = QuestHistoryStatusColor["abandoned"];
			elseif ( QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].f  ) then
				color = QuestHistoryStatusColor["failed"];
			else
				if ( level == "" ) then
					level = 0;
				end
				color = GetDifficultyColor(level);
			end
			-- Apply color to text
			getglobal(listFrame.."AcceptedText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."TitleText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."LevelText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."CategoryText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."TagText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."CompletedText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame):Show();
		else
			-- Hide the list frame if there is no data for it
			getglobal(listFrame):Hide();
		end
	end
end

-- Opens the QuestHistory note scroll frame and populates it with the current note if there is one
function QuestHistory_Edit_Note()
	local note = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID].n;
	if ( note ) then
		QuestHistoryDetailNotesText:SetText(note);
	else
		QuestHistoryDetailNotesText:SetText("");
	end
	-- Hide and show the appropriate frames
	QuestHistoryDetailListScrollFrame:Hide();
	QuestHistoryDetailEditButton:Hide();
	QuestHistoryDetailNotesScrollFrame:Show();
	QuestHistoryDetailSaveButton:Show();
end

-- Saves the player entered noted to QuestHistory_List
function QuestHistory_Save_Note()
	local note = QuestHistoryDetailNotesText:GetText();
	if ( note and note ~= "" ) then
		QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID].n = note;
	end
	-- Refresh the detailed view display
	QuestHistory_Detail_Update(currentDetailedQuestID);
end

-- Selects the quest in the main list relative to the currently selected quest and based
-- on the value of offset
function QuestHistory_Change_Detailed_Quest(offset)
	newID = currentSortedID + offset;
	-- Check if newID is valid
	if ( newID > 0 and newID <= sizeSortedTable ) then
		currentTitleListID = currentTitleListID + offset;
		currentSortedID = newID;
		currentDetailedQuestID = SortedTable[newID];
		QuestHistory_Detail_Update(currentDetailedQuestID);
		ShowUIPanel(QuestHistoryDetailFrame);
		QuestHistory_Refresh();
	end
end

function QuestHistory_ClearQuest()
	for index, value in QuestHistoryData do
		if ( value.box ) then
			getglobal("QuestHistoryEdit"..value.box.."EditBox"):SetText("");
		end
	end
end

function QuestHistory_SetColor()
	local red,green,blue = ColorPickerFrame:GetColorRGB();
	QuestHistoryStatusColor[string.lower(QuestHistory_StatusColorType)] = { r = red, g = green, b = blue };
	getglobal("QuestHistoryOptionsFrame"..QuestHistory_StatusColorType.."ColorSwatchNormalTexture"):SetVertexColor(red, green, blue);
	getglobal("QuestHistoryOptionsFrame"..QuestHistory_StatusColorType.."ColorSwatch").r = red;
	getglobal("QuestHistoryOptionsFrame"..QuestHistory_StatusColorType.."ColorSwatch").g = green;
	getglobal("QuestHistoryOptionsFrame"..QuestHistory_StatusColorType.."ColorSwatch").b = blue;
	if ( not QuestHistory_StatusColors ) then
		QuestHistory_StatusColors = { };
	end
	QuestHistory_StatusColors[string.lower(QuestHistory_StatusColorType)] = { r = red, g = green, b = blue };
	QuestHistory_Refresh();
end

function QuestHistory_CancelColor(previousValues)
	if ( previousValues.r ) then
		ColorPickerFrame:SetColorRGB(previousValues.r, previousValues.g, previousValues.b);
	end
end

-- Converts the zone into the continent/zone numbers used by MapNotes
function QuestHistory_MapNotes_GetZone(zone)
	for i = 1, 2, 1 do
		for j, value in QHMN_ZoneNames[i] do
			if ( value == zone ) then
				return i, j;
			end
		end
	end
	return 0, 0;
end

-- Creates the text for a new note and sends it to MapNotes
function QuestHistory_SendToMapNotes(button, locationType)
	if ( QHMN_Data and QHMN_ZoneNames ) then
		local _, _, area, xPos, yPos = string.find(QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID]["p"..locationType], "(.*):(.*):(.*)");
		if ( area and xPos and yPos ) then
			if ( button == "RightButton" ) then
				QHMN_SetNextAsMiniNote = 2;
			end
			local continent, zone = QuestHistory_MapNotes_GetZone(area);
			local title;
			local info1 = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID].t;
			local info2 = "";
			local creator = DisplayedPlayerCharacterName;
			local icon;
			local tcolor = 0;
			local i1color = 2;
			local i2color = 0;
			if ( locationType == "a" ) then
				title = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID].g;
				icon = 3;
			else
				title = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][currentDetailedQuestID].w;
				icon = 1;
			end
			local text = "c<"..continent.."> z<"..zone.."> x<"..xPos.."> y<"..yPos..">";
			text = text.." t<"..title.."> i1<"..info1.."> i2<"..info2.."> cr<"..creator..">";
			text = text.." i<"..icon.."> tf<"..tcolor.."> i1f<"..i1color.."> i2f<"..i2color..">";
			QHMN_GetNoteBySlashCommand(text);
		end
	end
end

--------------------------------------------------------------------------
-- TitanQuestsUtils.lua 
--------------------------------------------------------------------------
--[[
	Contains various utility functions for Titan [Quests].
]]--

--
-- utility function to get the string tag for a quest
--
function TitanPanelQuests_GetQuestTagText(questID)
	local useTag = "";
	local Title, Level, Tag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questID);

	-- Loc Note: Need to localize these tags - Ryessa
	if ( Tag == ELITE ) then
		useTag = "+"
	elseif ( Tag == TITAN_QUESTS_DUNGEON ) then
		useTag = "d";
	elseif ( Tag == TITAN_QUESTS_RAID ) then
		useTag = "r";
	elseif ( Tag == TITAN_QUESTS_PVP ) then
		useTag = "p";
	else
		useTag = "";
	end 
	
	if ( isComplete ) then
		--useTag = "C";
	end

	return useTag;
end

--
-- utility function to get the string tag for a watched quest
--
function TitanPanelQuests_GetQuestWatchText(questID)
	local questWatched;

	if ( IsQuestWatched(questID) ) then
		-- Loc Note: Need to localize this tag - Ryessa
		questWatched = TitanPanelQuests_BlueText(" (W)");
	else
		questWatched = "";
	end
	
	return questWatched;
end

--
-- utility function to get the string tag for a completed quest
--
function TitanPanelQuests_GetQuestCompleteText(questID)
	local completeTag;
	local Title, Level, Tag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questID);

	if ( isComplete ) then
		completeTag = "  ("..COMPLETE..")";
	else
		completeTag = "";
	end
	
	SelectQuestLogEntry(questID);
	if ( IsCurrentQuestFailed() ) then
		completeTag = " ("..TEXT(FAILED)..")";
	end
			
	return completeTag;
end

--
-- utility function to get the location string for a quest
--
function TitanPanelQuests_GetQuestLocationText(questID)
	local i;
	local questLocation = "";

	local questlist = TitanPanelQuests_BuildQuestList();
	local numQuests = table.getn(questlist);

	for i=1, numQuests do
		if ( questID == questlist[i].questID ) then
			questLocation = questlist[i].questLocation;
			break;
		end
	end

	if ( TitanGetVar(TITAN_QUESTS_ID, "SortByLocation") and TitanGetVar(TITAN_QUESTS_ID, "GroupBehavior") ) then
		return "";
	else
		return TitanUtils_GetNormalText("  ["..questLocation.."]");
	end
end

--
-- utility function to get the string tag for a watched quest
--

function TitanPanelQuests_GetQuestText(questID)
	local Title, Level, Tag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questID);
	local questTag;
	local locationTag = TitanPanelQuests_GetQuestLocationText(questID);

	questTag = TitanUtils_GetColoredText("["..Level..TitanPanelQuests_GetQuestTagText(questID).."]  ",GetDifficultyColor(Level))..Title..TitanUtils_GetRedText(TitanPanelQuests_GetQuestCompleteText(questID))..locationTag..TitanPanelQuests_GetQuestWatchText(questID);

	return questTag;
end

--
-- IsWatchAllowed
--	
function TitanPanelQuests_IsWatchAllowed(questID)
		if ( GetNumQuestLeaderBoards(questID) == 0 ) then
			-- Set an error that there are no objectives for the quest, so it may not be watched.
			UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
			return false;
		end
		if ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
         		-- Set an error message if trying to show too many quests
                  UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
			return false;
           	end

		-- Retrieve the quest info for questID.
		local Title, Level, Tag, isHeader, isCollapsed, isComplete;
		Title, Level, Tag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questID);
		if ( isComplete ) then
			-- We can't watch a complete item.
			return false;
		end
		return true;
end

--
-- build quest list (returns table of current active quests)
--
function TitanPanelQuests_BuildQuestList()

	local NumEntries, NumQuests;

	local Title, Level, Tag, isHeader, isCollapsed, isComplete;
	local questIndex;

	local Location;

	local useTag;
	local completeTag;
	local questWatched = "";
	local diff;

	local QuestList = { };

	NumEntries, NumQuests = GetNumQuestLogEntries();
	
	for questIndex=1, NumEntries do
		Title, Level, Tag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questIndex);

		if ( Level == 0 ) then
			Location = Title;
		else	
			local entry = { questID = questIndex, questTitle = Title, questLevel = Level, questTag = Tag, questisHeader = isHeader, questisComplete = isComplete, questLocation = Location };
			table.insert(QuestList, entry);
		end
	end	

	return QuestList;
end

--
-- debug
--
function TitanPanelQuests_DisplayTheList(thelist)
	local i = 0;
	for i=1, table.getn(thelist) do
		TitanPanelQuests_ChatPrint(i..":"..thelist[i].questLevel..":"..thelist[i].questTitle..":"..thelist[i].questLocation..":"..thelist[i].questID.."\n");
	end
end

--
-- blue text
--
function TitanPanelQuests_BlueText(text)
	if (text) then
		local redColorCode = format("%02x", 0);		
		local greenColorCode = format("%02x", 0);
		local blueColorCode = format("%02x", 255);		
		local colorCode = "|cff"..redColorCode..greenColorCode..blueColorCode;
		return colorCode..text..FONT_COLOR_CODE_CLOSE;
	end
end

--
-- debug
--
function TitanPanelQuests_ChatPrint(msg)
        DEFAULT_CHAT_FRAME:AddMessage(msg);
end

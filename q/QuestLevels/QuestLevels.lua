--[[

	QuestLevels
	>> http://www.insurgenceguild.com/insurgence/ui_mods.php

	By Halfhand <halfhand@insurgenceguild.com>

	Shows quest levels in the quest log, and speeds up quest text display.
	
	Based on code from Vjeux's QuestMinion mod (<3 QM).
	>> http://www.curse-gaming.com/mod.php?addid=83


	CHANGE LOG:

	v0.3 - 2005.03.28
	- Quests are now automatically removed from the tracker when completed
	- Added flags in tracker level based on quest tag (elite, dungeon, raid)
	- Levels of quests in tracker are now coloured based on difficulty

	v0.2 - 2005.03.26
	- Added quest levels to quest tracker frame
	- Fixed position of check mark next to quest titles in main quest log for
	  incomplete quests (was positioned correctly for completed quests)
	- Miscellaneous minor optimizations

	v0.1 - 2005.03.24
	- WoW Build 1300
	- Initial release

]]

-- globals
QUESTLEVELS_VERSION = "0.3";

-- labels
QUESTLEVELS_DUNGEON = "Dungeon";
QUESTLEVELS_RAID = "Raid";

-- disable quest fading
QUEST_FADING_ENABLE = nil;

function QuestLevels_OnLoad()
	-- define pretty-print functions
	if( not Print_Chat ) then 
		Print_Chat = function( x ) if( DEFAULT_CHAT_FRAME ) then DEFAULT_CHAT_FRAME:AddMessage( x, 1.0, 1.0, 0.0 ); end end
    end

	if( not Print_UI ) then
    	Print_UI = function( x ) UIErrorsFrame:AddMessage( x, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME ); end
    end

	this:RegisterEvent( "QUEST_LOG_UPDATE" );

	QuestLevels_QuestLog_Update = QuestLog_Update;
	QuestLevels_QuestWatch_Update = QuestWatch_Update;

	function QuestLog_Update()
		QuestLevels_QuestLog_Update();

		local numHeaders = 0;
		local numEntries = GetNumQuestLogEntries();
		
		for i = 1, QUESTS_DISPLAYED, 1 do
			local questIndex = i + FauxScrollFrame_GetOffset( QuestLogListScrollFrame );
			local questLogTitle = getglobal( "QuestLogTitle" .. i );
			local questTitleTag = getglobal( "QuestLogTitle".. i .."Tag" );
			local questCheck = getglobal( "QuestLogTitle" .. i .. "Check" );
			local questNormalText = getglobal( "QuestLogTitle" .. i .. "NormalText" );
			local questHighlightText = getglobal( "QuestLogTitle" .. i .. "HighlightText" );
			local questDisabledText = getglobal( "QuestLogTitle" .. i .. "DisabledText" );

			if( questIndex <= numEntries ) then
				local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle( questIndex );

				if( level and not isHeader ) then
					questLogTitle:SetText( "  [" .. level .. "] " .. questLogTitleText );
					QuestLogDummyText:SetText( questLogTitle:GetText() );

					-- set the quest tag
					if( isComplete ) then
						questTag = COMPLETE;
					end

					if( not questTag ) then
						questTitleTag:SetText( "" );

						-- reset to max text width
						questNormalText:SetWidth( 275 );
						questHighlightText:SetWidth( 275 );
						questDisabledText:SetWidth( 275 );

						-- show check mark if quest is being watched
						questCheck:Hide();

						if( IsQuestWatched( questIndex ) ) then
							questCheck:SetPoint( "LEFT", questLogTitle:GetName(), "LEFT", QuestLogDummyText:GetWidth() + 24, 0 );
							questCheck:Show();
						end
					end
				end
			end
		end
	end

	function QuestWatch_Update()
		QuestLevels_QuestWatch_Update();

		local numObjectives;
		local questWatchMaxWidth = 0;
		local tempWidth;
		local watchText;
		local watchTextIndex = 1;
		local questIndex;
		local objectivesCompleted;
		local text, type, finished;
		
		for i = 1, GetNumQuestWatches() do
			local tempIndex = 0;

			questIndex = GetQuestIndexForWatch(i);

			if( questIndex ) then
				numObjectives = GetNumQuestLeaderBoards(questIndex);
			
				-- if there are objectives, set the title
				if ( numObjectives > 0 ) then
					-- set title
					local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle( questIndex );

					if( level and not isHeader ) then
						local diff = GetDifficultyColor( level );
						local useTag, levelTag

						-- show flags in quest level based on tag
						if( questTag == ELITE ) then
							useTag = "+";
						elseif ( questTag == QUESTLEVELS_DUNGEON ) then
							useTag = "d";
						elseif ( questTag == QUESTLEVELS_RAID ) then
							useTag = "r";
						else
							useTag = "";
						end

						-- color quest level based on difficulty
						levelTag = format( "|c%02X%02X%02X%02X%s|r", 255, diff.r * 255, diff.g * 255, diff.b * 255,
							"[" .. level .. useTag .. "] " );

						watchText = getglobal( "QuestWatchLine" .. watchTextIndex );
						watchText:SetText( levelTag .. GetQuestLogTitle( questIndex ) );

						tempWidth = watchText:GetWidth();

						if( tempWidth > questWatchMaxWidth ) then
							questWatchMaxWidth = tempWidth;
						end

						objectivesCompleted = 0;

						for j = 1, numObjectives do
							text, type, finished = GetQuestLogLeaderBoard( j, questIndex );
							tempIndex = watchTextIndex + j;

							watchText = getglobal( "QuestWatchLine" .. tempIndex );

							if( finished ) then
								objectivesCompleted = objectivesCompleted + 1;
							end

							if( objectivesCompleted == numObjectives ) then
								-- spam quest completion message
								Print_UI( "[" .. level .. "] " .. GetQuestLogTitle( questIndex ) .. " (Complete)" );

								-- remove completed quest from tracker
								RemoveQuestWatch( questIndex );
								QuestWatch_Update();
							else
								tempWidth = watchText:GetWidth();

								-- adjust tracker width there are incomplete objectives
								if( tempWidth > questWatchMaxWidth ) then
									questWatchMaxWidth = tempWidth;
								end
							end
						end
					end
				end

				watchTextIndex = watchTextIndex + 1 + numObjectives;
			end
		end

		-- update width of tracker frame
		QuestWatchFrame:SetWidth( questWatchMaxWidth + 10 );
	end

	-- print mod version/load info to chat frame
	-- Print_Chat( "QuestLevels " .. QUESTLEVELS_VERSION .. " AddOn loaded" );
end

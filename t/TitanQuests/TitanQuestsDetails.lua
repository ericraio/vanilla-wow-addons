--------------------------------------------------------------------------
-- TitanQuestsDetails.lua 
--------------------------------------------------------------------------
--[[
	Contains all information to display the Quest Details panel for Titan [Quests].
]]--

--
-- Titan Panel Variables
--
TITAN_QUESTS_ID = "Quests";

TITAN_QUESTS_ARTWORK_PATH = "Interface\\AddOns\\TitanQuests\\Artwork\\";
	
--
-- display quest details window
--
function TitanPanelQuests_DisplayQuest()

	local questTitle, questLevel, questTag, questisHeader, questisCollapsed, questisComplete;
	local questDescription = "";
	local questObjectives = "";

	local diff, useTag, completeTag;

	local numObjectives = 0;

	local ObjectivesText = "";

    -- select the quest entry
    SelectQuestLogEntry(this.value[2]);
    QuestLog_SetSelection(this.value[2]);
	
	questDescription, questObjectives = GetQuestLogQuestText();

	questTitle, questLevel, questTag, questisHeader, questisCollapsed, questisComplete = GetQuestLogTitle(this.value[2]);	

	if ( questTag == ELITE ) then
		useTag = "+"
	elseif ( questTag == TITAN_QUESTS_DUNGEON ) then
		useTag = "d";
	elseif ( questTag == TITAN_QUESTS_RAID ) then
		useTag = "r";
	elseif ( questTag == TITAN_QUESTS_PVP ) then
		useTag = "p";
	else
		useTag = "";
	end 

	if ( questisComplete ) then
		useTag = "C";
		completeTag = "("..COMPLETE..")";
	else 
		completeTag = "";
	end

	diff = GetDifficultyColor(questLevel);

        -- find location
	local qid = 0;

	local questLocation = "";

	qid = this.value[2] - 1;

	for k = qid, 1, -1 do
		local qtitle, qlevel, qtag, qisheader, qiscollapsed, qiscomplete = GetQuestLogTitle(k);
		if ( qlevel == 0 ) then
			questLocation = qtitle;
			break;
		end
	end			
	-- end find location

	-- set title
	local newquestTitle = TitanUtils_GetColoredText("["..questLevel..useTag.."]",diff)..TitanUtils_GetHighlightText(questTitle);
	TitanQuests_Details_Title:SetText(newquestTitle);

	if ( IsCurrentQuestFailed() ) then
                questTitle = questTitle.." - ("..TEXT(FAILED)..")";
        end

	TitanQuests_Details_ScrollChild_QuestTitle:SetText(questTitle);

	-- add location to objectives
	local newquestObjectives = LOCATION_COLON.." "..questLocation.."\n\n"..questObjectives;
	TitanQuests_Details_ScrollChild_ObjectivesText:SetText(newquestObjectives);
	
	-- display quest timer 
        local questTimer = GetQuestLogTimeLeft();
        if ( questTimer ) then
                TitanQuests_Details.hasTimer = 1;
                TitanQuests_Details.timePassed = 0;
                TitanQuests_Details_ScrollChild_TimerText:Show();
                TitanQuests_Details_ScrollChild_TimerText:SetText(TEXT(TIME_REMAINING).." "..SecondsToTime(questTimer));
                TitanQuests_Details_ScrollChild_Objective1:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_TimerText", "BOTTOMLEFT", 0, -10);
        else
                TitanQuests_Details.hasTimer = nil;
                TitanQuests_Details_ScrollChild_TimerText:Hide();
                TitanQuests_Details_ScrollChild_Objective1:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10);
        end

	-- display objectives
	numObjectives = GetNumQuestLeaderBoards();

	for i=1, numObjectives, 1 do
                local string = getglobal("TitanQuests_Details_ScrollChild_Objective"..i);
                local text;
                local type;
                local finished;
                text, type, finished = GetQuestLogLeaderBoard(i);
                if ( not text or strlen(text) == 0 ) then
                        text = type;
                end
                if ( finished ) then
                        string:SetTextColor(0.2, 0.2, 0.2);
                        text = text.." ("..TEXT(COMPLETE)..")";
                else
                        string:SetTextColor(0, 0, 0);
                end
                string:SetText(text);
                string:Show();
                QuestFrame_SetAsLastShown(string,TitanQuests_Details_ScrollChild_SpacerFrame);
        end

	for i=numObjectives + 1, MAX_OBJECTIVES, 1 do
                getglobal("TitanQuests_Details_ScrollChild_Objective"..i):Hide();
        end

	-- If there's money required then anchor and display it
	if ( GetQuestLogRequiredMoney() > 0 ) then
		if ( numObjectives > 0 ) then
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_Objective"..numObjectives, "BOTTOMLEFT", 0, -4);
		else
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10);
		end
		
		MoneyFrame_Update("TitanQuests_Details_ScrollChild_RequiredMoneyFrame", GetQuestLogRequiredMoney());
		
		if ( GetQuestLogRequiredMoney() > GetMoney() ) then
			-- Not enough money
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetTextColor(0, 0, 0);
			SetMoneyFrameColor("UberQuest_Details_ScrollChild_RequiredMoneyFrame", 1.0, 0.1, 0.1);
		else
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetTextColor(0.2, 0.2, 0.2);
			SetMoneyFrameColor("UberQuest_Details_ScrollChild_RequiredMoneyFrame", 1.0, 1.0, 1.0);
		end
		TitanQuests_Details_ScrollChild_RequiredMoneyText:Show();
		TitanQuests_Details_ScrollChild_RequiredMoneyFrame:Show();
	else
		TitanQuests_Details_ScrollChild_RequiredMoneyText:Hide();
		TitanQuests_Details_ScrollChild_RequiredMoneyFrame:Hide();
	end
	
	if ( GetQuestLogRequiredMoney() > 0 ) then
                TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_RequiredMoneyText", "BOTTOMLEFT", 0, -10);
        elseif ( numObjectives > 0 ) then
                TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_Objective"..numObjectives, "BOTTOMLEFT", 0, -10);
        else
                if ( questTimer ) then
                        TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_TimerText", "BOTTOMLEFT", 0, -10);
                else
                        TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10);
                end
        end

	if ( questDescription ) then
                TitanQuests_Details_ScrollChild_QuestDescription:SetText(questDescription);
                QuestFrame_SetAsLastShown(TitanQuests_Details_ScrollChild_QuestDescription,TitanQuests_Details_ScrollChild_SpacerFrame);
        end

	local numRewards = GetNumQuestLogRewards();
        local numChoices = GetNumQuestLogChoices();
        local money = GetQuestLogRewardMoney();

        if ( (numRewards + numChoices + money) > 0 ) then
                TitanQuests_Details_ScrollChild_RewardTitleText:Show();
                QuestFrame_SetAsLastShown(TitanQuests_Details_ScrollChild_RewardTitleText,TitanQuests_Details_ScrollChild_SpacerFrame);
        else
                TitanQuests_Details_ScrollChild_RewardTitleText:Hide();
        end

        TitanQuests_Items_Update("TitanQuests_Details_ScrollChild_");
        TitanQuests_Details_ScrollScrollBar:SetValue(0);
        TitanQuests_Details_Scroll:UpdateScrollChildRect();

	TitanQuests_Details_AbandonButton:SetText(ABANDON_QUEST);
	
	if ( GetQuestLogPushable() ) then
		TitanQuests_Details_ShareButton:Enable();
		TitanQuests_Details_ShareButton:SetText(TITAN_QUESTS_DETAILS_SHARE_BUTTON_TEXT);
	else
		TitanQuests_Details_ShareButton:Disable();
		TitanQuests_Details_ShareButton:SetText(TITAN_QUESTS_DETAILS_SHARE_BUTTON_TEXT);
	end

	-- Corgi: ATTN
	if ( GetNumQuestLeaderBoards(this.value[2]) > 0)  then
		if ( IsQuestWatched(this.value[2]) ) then
			TitanQuests_Details_WatchButton:Disable();
			
		elseif ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
			TitanQuests_Details_WatchButton:Disable();
			
		else
			TitanQuests_Details_WatchButton:Enable();
			
		end
		
		TitanQuests_Details_WatchButton:SetText(TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT);
	else
		TitanQuests_Details_WatchButton:Disable();
		TitanQuests_Details_WatchButton:SetText(TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT);
	end
	-- Corgi: end ATTN

	TitanQuests_Details_CloseButton2:SetText(EXIT);

	-- Corgi: temp disable of abandon, share, watch buttons
	TitanQuests_Details_AbandonButton:Hide();
	TitanQuests_Details_ShareButton:Hide();
	TitanQuests_Details_WatchButton:Hide();
	TitanQuests_Details_CloseButton2:Hide();
	-- Corgi: end temp disable

        TitanQuests_Details:Show();

end

function TitanQuests_Items_Update(questState)
	local isQuestLog = 0;
	if ( questState == "TitanQuests_Details_ScrollChild_" ) then -- that's one change
		isQuestLog = 1;
	end
	local numQuestRewards;
	local numQuestChoices;
	local numQuestSpellRewards = 0;
	local money;
	local spacerFrame;
	if ( isQuestLog == 1 ) then
		numQuestRewards = GetNumQuestLogRewards();
		numQuestChoices = GetNumQuestLogChoices();
		if ( GetQuestLogRewardSpell() ) then
			numQuestSpellRewards = 1;
		end
		money = GetQuestLogRewardMoney();
		spacerFrame = TitanQuests_Details_ScrollChild_SpacerFrame; -- that's two!
		-- All this crap copied for TWO changes.
	else
		numQuestRewards = GetNumQuestRewards();
		numQuestChoices = GetNumQuestChoices();
		if ( GetRewardSpell() ) then
			numQuestSpellRewards = 1;
		end
		money = GetRewardMoney();
		spacerFrame = QuestSpacerFrame;
	end

	local totalRewards = numQuestRewards + numQuestChoices + numQuestSpellRewards;
	local questItemName = questState.."Item";
	local material = QuestFrame_GetMaterial();
	local  questItemReceiveText = getglobal(questState.."ItemReceiveText")
	if ( totalRewards == 0 and money == 0 ) then
		getglobal(questState.."RewardTitleText"):Hide();
	else
		getglobal(questState.."RewardTitleText"):Show();
		QuestFrame_SetTitleTextColor(getglobal(questState.."RewardTitleText"), material);
		QuestFrame_SetAsLastShown(getglobal(questState.."RewardTitleText"), spacerFrame);
	end
	if ( money == 0 ) then
		getglobal(questState.."MoneyFrame"):Hide();
	else
		getglobal(questState.."MoneyFrame"):Show();
		QuestFrame_SetAsLastShown(getglobal(questState.."MoneyFrame"), spacerFrame);
		MoneyFrame_Update(questState.."MoneyFrame", money);
	end
	
	for i=totalRewards + 1, MAX_NUM_ITEMS, 1 do
		getglobal(questItemName..i):Hide();
	end
	local questItem, name, texture, quality, isUsable, numItems = 1;
	if ( numQuestChoices > 0 ) then
		getglobal(questState.."ItemChooseText"):Show();
		QuestFrame_SetTextColor(getglobal(questState.."ItemChooseText"), material);
		QuestFrame_SetAsLastShown(getglobal(questState.."ItemChooseText"), spacerFrame);
		for i=1, numQuestChoices, 1 do	
			questItem = getglobal(questItemName..i);
			questItem.type = "choice";
			numItems = 1;
			if ( isQuestLog == 1 ) then
				name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo(i);
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
			end
			questItem:SetID(i)
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "item"
			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			getglobal(questItemName..i.."Name"):SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			else
				SetItemButtonTextureVertexColor(questItem, 0.9, 0, 0);
				SetItemButtonNameFrameVertexColor(questItem, 0.9, 0, 0);
			end
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(i - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..(i - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemChooseText", "BOTTOMLEFT", -3, -5);
			end
			
		end
	else
		getglobal(questState.."ItemChooseText"):Hide();
	end
	local rewardsCount = 0;
	if ( numQuestRewards > 0 or money > 0 or numQuestSpellRewards > 0) then
		QuestFrame_SetTextColor(questItemReceiveText, material);
		-- Anchor the reward text differently if there are choosable rewards
		if ( numQuestChoices > 0  ) then
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS));
			local index = numQuestChoices;
			if ( mod(index, 2) == 0 ) then
				index = index - 1;
			end
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..index, "BOTTOMLEFT", 3, -5);
		else 
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS_ONLY));
			questItemReceiveText:SetPoint("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 3, -5);
		end
		questItemReceiveText:Show();
		QuestFrame_SetAsLastShown(questItemReceiveText, spacerFrame);
		-- Setup mandatory rewards
		for i=1, numQuestRewards, 1 do
			questItem = getglobal(questItemName..(i + numQuestChoices));
			questItem.type = "reward";
			numItems = 1;
			if ( isQuestLog == 1 ) then
				name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo(i);
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i);
			end
			questItem:SetID(i)
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "item";
			QuestFrame_SetAsLastShown(questItem, spacerFrame);
			getglobal(questItemName..(i + numQuestChoices).."Name"):SetText(name);
			SetItemButtonCount(questItem, numItems);
			SetItemButtonTexture(questItem, texture);
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0);
			else
				SetItemButtonTextureVertexColor(questItem, 0.5, 0, 0);
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 0, 0);
			end
			
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 2), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 1), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemReceiveText", "BOTTOMLEFT", -3, -5);
			end
			rewardsCount = rewardsCount + 1;
		end
		-- Setup spell reward
		if ( numQuestSpellRewards > 0 ) then
			if ( isQuestLog == 1 ) then
				texture, name = GetQuestLogRewardSpell();
			else
				texture, name = GetRewardSpell();
			end
			questItem = getglobal(questItemName..(rewardsCount + numQuestChoices + 1));
			questItem:Show();
			-- For the tooltip
			questItem.rewardType = "spell";
			SetItemButtonCount(questItem, 0);
			SetItemButtonTexture(questItem, texture);
			getglobal(questItemName..(rewardsCount + numQuestChoices + 1).."Name"):SetText(name);
			if ( rewardsCount > 0 ) then
				if ( mod(rewardsCount,2) == 0 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((rewardsCount + numQuestChoices) - 1), "BOTTOMLEFT", 0, -2);
				else
					questItem:SetPoint("TOPLEFT", questItemName..((rewardsCount + numQuestChoices)), "TOPRIGHT", 1, 0);
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemReceiveText", "BOTTOMLEFT", -3, -5);
			end
		end
	else	
		questItemReceiveText:Hide();
	end
	if ( questState == "QuestReward" ) then
		QuestFrameCompleteQuestButton:Enable();
		QuestFrameRewardPanel.itemChoice = 0;
		QuestRewardItemHighlight:Hide();
	end
end

function TitanQuests_Details_Update()
	local questID = GetQuestLogSelection();
	local questTitle = GetQuestLogTitle(questID);
	if ( not questTitle ) then
		questTitle = "";
	end
	if ( IsCurrentQuestFailed() ) then
		questTitle = questTitle.." - ("..TEXT(FAILED)..")";
	end
	TitanQuests_Details_ScrollChild_QuestTitle:SetText(questTitle);

	local questDescription;
	local questObjectives;
	questDescription, questObjectives = GetQuestLogQuestText();
	TitanQuests_Details_ScrollChild_ObjectivesText:SetText(questObjectives);

	
	questTitle, questLevel, questTag, questisHeader, questisCollapsed, questisComplete = GetQuestLogTitle(questID);

	if ( questTag == ELITE ) then
		useTag = "+"
	elseif ( questTag == TITAN_QUESTS_DUNGEON ) then
		useTag = "d";
	elseif ( questTag == TITAN_QUESTS_RAID ) then
		useTag = "r";
	elseif ( questTag == TITAN_QUESTS_PVP ) then
		useTag = "p";
	else
		useTag = "";
	end 

	if ( questisComplete ) then
		--useTag = "C";
		completeTag = "("..COMPLETE..")";
	else 
		completeTag = "";
	end

	diff = GetDifficultyColor(questLevel);

        -- find location
	local qid = 0;

	local questLocation = "";

	qid = questID - 1;

	for k = qid, 1, -1 do
		local qtitle, qlevel, qtag, qisheader, qiscollapsed, qiscomplete = GetQuestLogTitle(k);
		if ( qlevel == 0 ) then
			questLocation = qtitle;
			break;
		end
	end			
	-- end find location

	local newquestTitle = TitanUtils_GetColoredText("["..questLevel..useTag.."]",diff)..TitanUtils_GetHighlightText(questTitle);

	TitanQuests_Details_Title:SetText(newquestTitle);

	if ( IsCurrentQuestFailed() ) then
                questTitle = questTitle.." - ("..TEXT(FAILED)..")";
        end
	TitanQuests_Details_ScrollChild_QuestTitle:SetText(questTitle);

	local newquestObjectives = LOCATION_COLON.." "..questLocation.."\n\n"..questObjectives;
	TitanQuests_Details_ScrollChild_ObjectivesText:SetText(newquestObjectives);

	local questTimer = GetQuestLogTimeLeft();
	if ( questTimer ) then
		TitanQuests_Details.hasTimer = 1;
		TitanQuests_Details.timePassed = 0;
		TitanQuests_Details_ScrollChild_TimerText:Show();
		TitanQuests_Details_ScrollChild_TimerText:SetText(TEXT(TIME_REMAINING).." "..SecondsToTime(questTimer));
		TitanQuests_Details_ScrollChild_Objective1:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_TimerText", "BOTTOMLEFT", 0, -10);
	else
		TitanQuests_Details.hasTimer = nil;
		TitanQuests_Details_ScrollChild_TimerText:Hide();
		TitanQuests_Details_ScrollChild_Objective1:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10);
	end
	
	local numObjectives = GetNumQuestLeaderBoards();
	for i=1, numObjectives, 1 do
		local string = getglobal("TitanQuests_Details_ScrollChild_Objective"..i);
		local text;
		local type;
		local finished;
		text, type, finished = GetQuestLogLeaderBoard(i);
		if ( not text or strlen(text) == 0 ) then
			text = type;
		end
		if ( finished ) then
			string:SetTextColor(0.2, 0.2, 0.2);
			text = text.." ("..TEXT(COMPLETE)..")";
		else
			string:SetTextColor(0, 0, 0);
		end
		string:SetText(text);
		string:Show();
		QuestFrame_SetAsLastShown(string,TitanQuests_Details_ScrollChild_SpacerFrame);
	end

	for i=numObjectives + 1, MAX_OBJECTIVES, 1 do
		getglobal("TitanQuests_Details_ScrollChild_Objective"..i):Hide();
	end
	
	-- If there's money required then anchor and display it
	if ( GetQuestLogRequiredMoney() > 0 ) then
		if ( numObjectives > 0 ) then
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_Objective"..numObjectives, "BOTTOMLEFT", 0, -4);
		else
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10);
		end
		
		MoneyFrame_Update("TitanQuests_Details_ScrollChild_RequiredMoneyFrame", GetQuestLogRequiredMoney());
		
		if ( GetQuestLogRequiredMoney() > GetMoney() ) then
			-- Not enough money
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetTextColor(0, 0, 0);
			SetMoneyFrameColor("TitanQuests_Details_ScrollChild_RequiredMoneyFrame", 1.0, 0.1, 0.1);
		else
			TitanQuests_Details_ScrollChild_RequiredMoneyText:SetTextColor(0.2, 0.2, 0.2);
			SetMoneyFrameColor("TitanQuests_Details_ScrollChild_RequiredMoneyFrame", 1.0, 1.0, 1.0);
		end
		TitanQuests_Details_ScrollChild_RequiredMoneyText:Show();
		TitanQuests_Details_ScrollChild_RequiredMoneyFrame:Show();
	else
		TitanQuests_Details_ScrollChild_RequiredMoneyText:Hide();
		TitanQuests_Details_ScrollChild_RequiredMoneyFrame:Hide();
	end

	if ( GetQuestLogRequiredMoney() > 0 ) then
		TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_RequiredMoneyText", "BOTTOMLEFT", 0, -10);
	elseif ( numObjectives > 0 ) then
		TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_Objective"..numObjectives, "BOTTOMLEFT", 0, -10);
	else
		if ( questTimer ) then
			TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_TimerText", "BOTTOMLEFT", 0, -10);
		else
			TitanQuests_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "TitanQuests_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10);
		end
	end
	if ( questDescription ) then
		TitanQuests_Details_ScrollChild_QuestDescription:SetText(questDescription);
		 QuestFrame_SetAsLastShown(TitanQuests_Details_ScrollChild_QuestDescription,TitanQuests_Details_ScrollChild_SpacerFrame);
	end
	local numRewards = GetNumQuestLogRewards();
	local numChoices = GetNumQuestLogChoices();
	local money = GetQuestLogRewardMoney();

	if ( (numRewards + numChoices + money) > 0 ) then
		TitanQuests_Details_ScrollChild_RewardTitleText:Show();
		QuestFrame_SetAsLastShown(TitanQuests_Details_ScrollChild_RewardTitleText,TitanQuests_Details_ScrollChild_SpacerFrame);
	else
		TitanQuests_Details_ScrollChild_RewardTitleText:Hide();
	end

	TitanQuests_Items_Update("TitanQuests_Details_ScrollChild_");
	TitanQuests_Details_ScrollScrollBar:SetValue(0);
	TitanQuests_Details_Scroll:UpdateScrollChildRect();

	if ( GetNumQuestLeaderBoards(questID) > 0)  then
		if ( IsQuestWatched(questID) ) then
			TitanQuests_Details_WatchButton:Disable();
			
		elseif ( GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
			TitanQuests_Details_WatchButton:Disable();
			
		else
			TitanQuests_Details_WatchButton:Enable();
			
		end
		
		TitanQuests_Details_WatchButton:SetText(TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT);
	else
		TitanQuests_Details_WatchButton:Disable();
		TitanQuests_Details_WatchButton:SetText(TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT);
	end

	-- Corgi: temp disable of abandon, share, watch buttons
	TitanQuests_Details_AbandonButton:Hide();
	TitanQuests_Details_ShareButton:Hide();
	TitanQuests_Details_WatchButton:Hide();
	TitanQuests_Details_CloseButton2:Hide();
	-- Corgi: end temp disable
end



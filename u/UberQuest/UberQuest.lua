
UBERQUEST_VERSION = "Reborn 1.11.9"

UIPanelWindows["UberQuest_List"] = {area = "doublewide", pushable = 997}
BINDING_HEADER_UBERQUEST_SEP = "Uber Quest Reborn"
BINDING_NAME_UBERQUEST_CONFIG = BINDING_NAME_UBERQUEST_CONFIG
BINDING_NAME_UBERQUEST_CONFIG2 = BINDING_NAME_UBERQUEST_CONFIG2

UBERQUEST_QUESTS_DISPLAYED = 22
UBERQUEST_QUESTLINE_HEIGHT = 16

UberQuest_Player = nil --global
UberQuest_Minion_ColorPicker = { r = 1, g = 1, b = 1 } -- global
UBERQUEST_MINIONSCALE = 100
local UberQuest_Config_Loaded = nil
local UberQuest_ThereAreQuests = nil
local UberQuest_MinionSetOnce = nil
local UberQuest_QuestTitles = nil
local UberQuest_SelectedQuest = nil
local UberQuest_ActivityTracker = {}
local UberQuest_GotFullList = nil
local UberQuest_DelayedConfigInit = nil
local UberQuest_InfoRequested = {}
local UberQuest_WatchTextIndex = 1

UberQuestDetails = {
	name = "UberQuest",
	version = UBERQUEST_VERSION,
	releaseDate = "2006.08.22",
	author = "Saien (Modded by BanMan)",
	email = "Woosleyt@gmail.com",
	website = "http://ui.worldofwar.net/ui.php?id=2780",
	category = MYADDONS_CATEGORY_QUESTS
}



function UberQuest_Minion_Reset()
	UberQuest_Minion:ClearAllPoints()
	UberQuest_Minion:SetPoint("CENTER","UIParent","CENTER",0,0)
	if (not UberQuest_Minion:IsVisible()) then
		UberQuest_MinionShowHide()
	end
end

local function UberQuest_Items_Update(questState)
	local isQuestLog = 0
	if (questState == "UberQuest_Details_ScrollChild_") then -- that's one change
		isQuestLog = 1
	end
	local numQuestRewards
	local numQuestChoices
	local numQuestSpellRewards = 0
	local money
	local spacerFrame
	if (isQuestLog == 1) then
		numQuestRewards = GetNumQuestLogRewards()
		numQuestChoices = GetNumQuestLogChoices()
		if ( GetQuestLogRewardSpell() ) then
			numQuestSpellRewards = 1
		end
		money = GetQuestLogRewardMoney()
		spacerFrame = UberQuest_Details_ScrollChild_SpacerFrame -- that's two!
		-- All this crap copied for TWO changes.
	else
		numQuestRewards = GetNumQuestRewards()
		numQuestChoices = GetNumQuestChoices()
		if ( GetRewardSpell() ) then
			numQuestSpellRewards = 1
		end
		money = GetRewardMoney()
		spacerFrame = QuestSpacerFrame
	end

	local totalRewards = numQuestRewards + numQuestChoices + numQuestSpellRewards
	local questItemName = questState.."Item"
	local material = QuestFrame_GetMaterial()
	local  questItemReceiveText = getglobal(questState.."ItemReceiveText")
	if (totalRewards == 0 and money == 0) then
		getglobal(questState.."RewardTitleText"):Hide()
	else
		getglobal(questState.."RewardTitleText"):Show()
		QuestFrame_SetTitleTextColor(getglobal(questState.."RewardTitleText"), material)
		QuestFrame_SetAsLastShown(getglobal(questState.."RewardTitleText"), spacerFrame)
	end
	if (money == 0) then
		getglobal(questState.."MoneyFrame"):Hide()
	else
		getglobal(questState.."MoneyFrame"):Show()
		QuestFrame_SetAsLastShown(getglobal(questState.."MoneyFrame"), spacerFrame)
		MoneyFrame_Update(questState.."MoneyFrame", money)
	end
	
	for i=totalRewards + 1, MAX_NUM_ITEMS, 1 do
		getglobal(questItemName..i):Hide()
	end
	local questItem, name, texture, quality, isUsable, numItems = 1
	if ( numQuestChoices > 0 ) then
		getglobal(questState.."ItemChooseText"):Show()
		QuestFrame_SetTextColor(getglobal(questState.."ItemChooseText"), material)
		QuestFrame_SetAsLastShown(getglobal(questState.."ItemChooseText"), spacerFrame)
		for i=1, numQuestChoices, 1 do	
			questItem = getglobal(questItemName..i)
			questItem.type = "choice"
			numItems = 1
			if ( isQuestLog == 1 ) then
				name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo(i)
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i)
			end
			questItem:SetID(i)
			questItem:Show()
			-- For the tooltip
			questItem.rewardType = "item"
			QuestFrame_SetAsLastShown(questItem, spacerFrame)
			getglobal(questItemName..i.."Name"):SetText(name)
			SetItemButtonCount(questItem, numItems)
			SetItemButtonTexture(questItem, texture)
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0)
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0)
			else
				SetItemButtonTextureVertexColor(questItem, 0.9, 0, 0)
				SetItemButtonNameFrameVertexColor(questItem, 0.9, 0, 0)
			end
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..(i - 2), "BOTTOMLEFT", 0, -2)
				else
					questItem:SetPoint("TOPLEFT", questItemName..(i - 1), "TOPRIGHT", 1, 0)
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemChooseText", "BOTTOMLEFT", -3, -5)
			end
			
		end
	else
		getglobal(questState.."ItemChooseText"):Hide()
	end
	local rewardsCount = 0
	if ( numQuestRewards > 0 or money > 0 or numQuestSpellRewards > 0) then
		QuestFrame_SetTextColor(questItemReceiveText, material)
		-- Anchor the reward text differently if there are choosable rewards
		if ( numQuestChoices > 0  ) then
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS))
			local index = numQuestChoices
			if ( mod(index, 2) == 0 ) then
				index = index - 1
			end
			questItemReceiveText:SetPoint("TOPLEFT", questItemName..index, "BOTTOMLEFT", 3, -5)
		else 
			questItemReceiveText:SetText(TEXT(REWARD_ITEMS_ONLY))
			questItemReceiveText:SetPoint("TOPLEFT", questState.."RewardTitleText", "BOTTOMLEFT", 3, -5)
		end
		questItemReceiveText:Show()
		QuestFrame_SetAsLastShown(questItemReceiveText, spacerFrame)
		-- Setup mandatory rewards
		for i=1, numQuestRewards, 1 do
			questItem = getglobal(questItemName..(i + numQuestChoices))
			questItem.type = "reward"
			numItems = 1
			if ( isQuestLog == 1 ) then
				name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo(i)
			else
				name, texture, numItems, quality, isUsable = GetQuestItemInfo(questItem.type, i)
			end
			questItem:SetID(i)
			questItem:Show()
			-- For the tooltip
			questItem.rewardType = "item"
			QuestFrame_SetAsLastShown(questItem, spacerFrame)
			getglobal(questItemName..(i + numQuestChoices).."Name"):SetText(name)
			SetItemButtonCount(questItem, numItems)
			SetItemButtonTexture(questItem, texture)
			if ( isUsable ) then
				SetItemButtonTextureVertexColor(questItem, 1.0, 1.0, 1.0)
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 1.0, 1.0)
			else
				SetItemButtonTextureVertexColor(questItem, 0.5, 0, 0)
				SetItemButtonNameFrameVertexColor(questItem, 1.0, 0, 0)
			end
			
			if ( i > 1 ) then
				if ( mod(i,2) == 1 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 2), "BOTTOMLEFT", 0, -2)
				else
					questItem:SetPoint("TOPLEFT", questItemName..((i + numQuestChoices) - 1), "TOPRIGHT", 1, 0)
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemReceiveText", "BOTTOMLEFT", -3, -5)
			end
			rewardsCount = rewardsCount + 1
		end
		-- Setup spell reward
		if ( numQuestSpellRewards > 0 ) then
			if ( isQuestLog == 1 ) then
				texture, name = GetQuestLogRewardSpell()
			else
				texture, name = GetRewardSpell()
			end
			questItem = getglobal(questItemName..(rewardsCount + numQuestChoices + 1))
			questItem:Show()
			-- For the tooltip
			questItem.rewardType = "spell"
			SetItemButtonCount(questItem, 0)
			SetItemButtonTexture(questItem, texture)
			getglobal(questItemName..(rewardsCount + numQuestChoices + 1).."Name"):SetText(name)
			if ( rewardsCount > 0 ) then
				if ( mod(rewardsCount,2) == 0 ) then
					questItem:SetPoint("TOPLEFT", questItemName..((rewardsCount + numQuestChoices) - 1), "BOTTOMLEFT", 0, -2)
				else
					questItem:SetPoint("TOPLEFT", questItemName..((rewardsCount + numQuestChoices)), "TOPRIGHT", 1, 0)
				end
			else
				questItem:SetPoint("TOPLEFT", questState.."ItemReceiveText", "BOTTOMLEFT", -3, -5)
			end
		end
	else	
		questItemReceiveText:Hide()
	end
	if ( questState == "QuestReward" ) then
		QuestFrameCompleteQuestButton:Enable()
		QuestFrameRewardPanel.itemChoice = 0
		QuestRewardItemHighlight:Hide()
	end
end

local function UberQuest_Details_Update()
	local questID = GetQuestLogSelection()
	local questTitle = GetQuestLogTitle(questID)
	if ( not questTitle ) then
		questTitle = ""
	end
	if ( IsCurrentQuestFailed() ) then
		questTitle = questTitle.." - ("..TEXT(FAILED)..")"
	end
	UberQuest_Details_ScrollChild_QuestTitle:SetText(questTitle)

	local questDescription
	local questObjectives
	questDescription, questObjectives = GetQuestLogQuestText()
	UberQuest_Details_ScrollChild_ObjectivesText:SetText(questObjectives)
	
	local questTimer = GetQuestLogTimeLeft()
	if ( questTimer ) then
		UberQuest_Details.hasTimer = 1
		UberQuest_Details.timePassed = 0
		UberQuest_Details_ScrollChild_TimerText:Show()
		UberQuest_Details_ScrollChild_TimerText:SetText(TEXT(TIME_REMAINING).." "..SecondsToTime(questTimer))
		UberQuest_Details_ScrollChild_Objective1:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_TimerText", "BOTTOMLEFT", 0, -10)
	else
		UberQuest_Details.hasTimer = nil
		UberQuest_Details_ScrollChild_TimerText:Hide()
		UberQuest_Details_ScrollChild_Objective1:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10)
	end
	
	local numObjectives = GetNumQuestLeaderBoards()
	for i=1, numObjectives, 1 do
		local string = getglobal("UberQuest_Details_ScrollChild_Objective"..i)
		local text
		local type
		local finished
		text, type, finished = GetQuestLogLeaderBoard(i)
		if ( not text or strlen(text) == 0 ) then
			text = type
		end
		if ( finished ) then
			string:SetTextColor(0.2, 0.2, 0.2)
			text = text.." ("..TEXT(COMPLETE)..")"
		else
			string:SetTextColor(0, 0, 0)
		end
		string:SetText(text)
		string:Show()
		QuestFrame_SetAsLastShown(string,UberQuest_Details_ScrollChild_SpacerFrame)
	end

	for i=numObjectives + 1, MAX_OBJECTIVES, 1 do
		getglobal("UberQuest_Details_ScrollChild_Objective"..i):Hide()
	end
	
	-- If there's money required then anchor and display it
	if ( GetQuestLogRequiredMoney() > 0 ) then
		if ( numObjectives > 0 ) then
			UberQuest_Details_ScrollChild_RequiredMoneyText:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_Objective"..numObjectives, "BOTTOMLEFT", 0, -4)
		else
			UberQuest_Details_ScrollChild_RequiredMoneyText:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10)
		end
		
		MoneyFrame_Update("UberQuest_Details_ScrollChild_RequiredMoneyFrame", GetQuestLogRequiredMoney())
		
		if ( GetQuestLogRequiredMoney() > GetMoney() ) then
			-- Not enough money
			UberQuest_Details_ScrollChild_RequiredMoneyText:SetTextColor(0, 0, 0)
			SetMoneyFrameColor("UberQuest_Details_ScrollChild_RequiredMoneyFrame", 1.0, 0.1, 0.1)
		else
			UberQuest_Details_ScrollChild_RequiredMoneyText:SetTextColor(0.2, 0.2, 0.2)
			SetMoneyFrameColor("UberQuest_Details_ScrollChild_RequiredMoneyFrame", 1.0, 1.0, 1.0)
		end
		UberQuest_Details_ScrollChild_RequiredMoneyText:Show()
		UberQuest_Details_ScrollChild_RequiredMoneyFrame:Show()
	else
		UberQuest_Details_ScrollChild_RequiredMoneyText:Hide()
		UberQuest_Details_ScrollChild_RequiredMoneyFrame:Hide()
	end

	if ( GetQuestLogRequiredMoney() > 0 ) then
		UberQuest_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_RequiredMoneyText", "BOTTOMLEFT", 0, -10)
	elseif ( numObjectives > 0 ) then
		UberQuest_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_Objective"..numObjectives, "BOTTOMLEFT", 0, -10)
	else
		if ( questTimer ) then
			UberQuest_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_TimerText", "BOTTOMLEFT", 0, -10)
		else
			UberQuest_Details_ScrollChild_DescriptionTitle:SetPoint("TOPLEFT", "UberQuest_Details_ScrollChild_ObjectivesText", "BOTTOMLEFT", 0, -10)
		end
	end
	if ( questDescription ) then
		UberQuest_Details_ScrollChild_QuestDescription:SetText(questDescription)
		 QuestFrame_SetAsLastShown(UberQuest_Details_ScrollChild_QuestDescription,UberQuest_Details_ScrollChild_SpacerFrame)
	end
	local numRewards = GetNumQuestLogRewards()
	local numChoices = GetNumQuestLogChoices()
	local money = GetQuestLogRewardMoney()

	if ( (numRewards + numChoices + money) > 0 ) then
		UberQuest_Details_ScrollChild_RewardTitleText:Show()
		QuestFrame_SetAsLastShown(UberQuest_Details_ScrollChild_RewardTitleText,UberQuest_Details_ScrollChild_SpacerFrame)
	else
		UberQuest_Details_ScrollChild_RewardTitleText:Hide()
	end

	UberQuest_Items_Update("UberQuest_Details_ScrollChild_")
	UberQuest_Details_ScrollScrollBar:SetValue(0)
	UberQuest_Details_Scroll:UpdateScrollChildRect()
end

local function UberQuest_List_SetSelection(questID)
	local selectedQuest
	if ( questID == 0 ) then
		UberQuest_Details_Scroll:Hide()
		return
	end
	UberQuest_Details_Scroll:Show()

	-- Get xml id
	local id = questID - FauxScrollFrame_GetOffset(UberQuest_List_Scroll)
	
	UberQuest_SelectedQuest = questID
	SelectQuestLogEntry(questID)
	local titleButton = getglobal("UberQuest_List_Title"..id)
	local titleButtonTag = getglobal("UberQuest_List_Title"..id.."Tag")
	local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(questID)
	if ( isHeader ) then
		if ( isCollapsed ) then
			ExpandQuestHeader(questID)
			return
		else
			CollapseQuestHeader(questID)
			return
		end
	else
		-- Set newly selected quest and highlight it
		UberQuest_List.selectedButtonID = questID
		local scrollFrameOffset = FauxScrollFrame_GetOffset(UberQuest_List_Scroll)
		if ( questID > scrollFrameOffset and questID <= (scrollFrameOffset + UBERQUEST_QUESTS_DISPLAYED) and questID <= GetNumQuestLogEntries() ) then
			titleButton:LockHighlight()
			titleButtonTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
			UberQuest_List_HighlightFrame_SkillHighlight:SetVertexColor(titleButton.r, titleButton.g, titleButton.b)
			UberQuest_List_HighlightFrame:SetPoint("TOPLEFT", "UberQuest_List_Title"..id, "TOPLEFT", 5, 0)
			UberQuest_List_HighlightFrame:Show()
		end
	end
	if ( GetQuestLogSelection() > GetNumQuestLogEntries() ) then
		return
	end
	UberQuest_Details_Title:SetText ("Uber Quest ("..UBERQUEST_VERSION..")")
	UberQuest_Details:Show()
	UberQuest_Details_Update()
end

local function UberQuest_SetFirstValidSelection()
	-- Intentionally left at QuestLog_
	local selectableQuest = QuestLog_GetFirstSelectableQuest()
	UberQuest_List_SetSelection(selectableQuest)
end


local function UberQuest_ConfigInit()
	UberQuest_Config_Loaded = 1
	if (not UberQuest_Config) then 
		UberQuest_Config = {}
		UberQuest_Config.showquestlevels = 1
		UberQuest_Config.useminion = 1
		UberQuest_Config.addnewquests = 1
		UberQuest_Config.UberMinionScale = 100
	end
	-- In General: No reason, IMO, for per-player config options since 
	-- people are going to want consistant QuestLog views anyways. Or at least I do.
	-- The exception is for options regarding onscreen placement, and (duh) 
	-- Quests selected for minion
	if (not UberQuest_Config[UberQuest_Player]) then
		UberQuest_Config[UberQuest_Player] = {}
	end
	if (not UberQuest_Config[UberQuest_Player].selected) then
		UberQuest_Config[UberQuest_Player].selected = {}
	end

	UberQuest_Config.speedquest = nil
	if (UberQuest_Config.useminion) then
		if (UberQuest_Config[UberQuest_Player].minionvisible) then
			if (not UberQuest_Minion:IsVisible()) then
				UberQuest_MinionShowHide()
			end
		end
		if (UberQuest_Config[UberQuest_Player].lockminion) then
			UberQuest_Minion_Move:Hide()
		else
			UberQuest_Minion_Move:Show()
		end
		if (UberQuest_Config.color and UberQuest_Config.color.r and UberQuest_Config.color.g and UberQuest_Config.color.b and UberQuest_Config.color.opacity) then
			UberQuest_MinionBackdrop:SetBackdropColor(UberQuest_Config.color.r, UberQuest_Config.color.g, UberQuest_Config.color.b)
			local alpha = 1.0 - UberQuest_Config.color.opacity
			UberQuest_MinionBackdrop:SetAlpha(alpha)
		else
			UberQuest_MinionBackdrop:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
			UberQuest_MinionBackdrop:SetAlpha(1)
		end
		if (UberQuest_Config[UberQuest_Player].lock and
			UberQuest_Config[UberQuest_Player].lock.corner and
			UberQuest_Config[UberQuest_Player].lock.pointone and
			UberQuest_Config[UberQuest_Player].lock.pointtwo) then
			UberQuest_Minion:ClearAllPoints()
			UberQuest_Minion:SetPoint(UberQuest_Config[UberQuest_Player].lock.corner,"UIParent","BOTTOMLEFT",UberQuest_Config[UberQuest_Player].lock.pointone,UberQuest_Config[UberQuest_Player].lock.pointtwo)
		end

		--  Load Scale settings
		
		if (UberQuest_Config[UberQuest_Player]["scale"]) then
			local scale = 1
			scale = UberQuest_Config[UberQuest_Player]["scale"]
			UberQuest_Minion:SetScale(UIParent:GetScale() * scale)
			UberMinionScale:SetValue(scale * 100)
		end

	end
	UberQuest_List_ConfigButton:Enable()
	UberQuest_List_SummonMinion:Enable()
end

function UberQuest_DelayedConfigInit_OnUpdate(elapsed)
	if (UberQuest_DelayedConfigInit) then
		UberQuest_DelayedConfigInit = UberQuest_DelayedConfigInit - elapsed
		if (UberQuest_DelayedConfigInit < 0) then
			UberQuest_ConfigInit()
			UberQuest_DelayedConfigInit = nil
			UberQuest:Hide()
		end
	else -- Stop receiving OnUpdates
		UberQuest:Hide()
	end
end

function UberQuest_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD") 
	this:RegisterEvent("QUEST_LOG_UPDATE")
	this:RegisterEvent("PARTY_MEMBERS_CHANGED")
	this:RegisterEvent("ADDON_LOADED")

	DEFAULT_CHAT_FRAME:AddMessage("UberQuest ("..UBERQUEST_VERSION..") loaded.")

	UberQuest_oldToggleQuestLog = ToggleQuestLog
	ToggleQuestLog = UberQuest_ListShowHide

	local playerName = UnitName("player")
	if (playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
		UberQuest_Player = playerName
	end
end

function UberQuest_OnEvent()
	if(event == "ADDON_LOADED" and myAddOnsFrame_Register) then
			myAddOnsFrame_Register(UberQuestDetails)
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		if (UberQuest_Player and not UberQuest_Config_Loaded) then
			UberQuest_DelayedConfigInit = 10
			UberQuest:Show()
		end
	elseif (UberQuest_Config_Loaded and event == "QUEST_LOG_UPDATE") then
		UberQuest_List_Update()
		if (UberQuest_Details:IsVisible()) then
			UberQuest_Details_Update()
		end
		if (UberQuest_Minion:IsVisible() and UberQuest_Config[UberQuest_Player].selected) then
			UberQuest_Minion_Update()
		end
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		-- Pushable == Sharable. Blizzard likes things straight forward
		if ( GetQuestLogPushable() and GetNumPartyMembers() > 0 ) then
			UberQuest_List_ShareButton:Enable()
		else
			UberQuest_List_ShareButton:Disable()
		end
	end
end

function UberQuest_List_OnLoad()
	this.selectedButtonID = 2
end

function UberQuest_ListShowHide()
	if (UberQuest_List:IsVisible()) then
		HideUIPanel(UberQuest_List)
		PlaySound("igQuestLogClose")
	else
		UberQuest_List_Title:SetText ("Uber Quest ("..UBERQUEST_VERSION..")")
		ShowUIPanel(UberQuest_List)
		UberQuest_List_Update()
		PlaySound("igQuestLogOpen")
		if (UberQuest_Details:IsVisible()) then
			UberQuest_Details_Update()
		end
	end
end

function UberQuest_Minion_ShowHide()
	if (UberQuest_Minion:IsVisible() and UberQuest_Config[UberQuest_Player].selected) then
			UberQuest_Minion_Update()
		else
		UberQuest_Minion:Hide()
	end
end


function UberQuest_List_Update()
	local i
	UberQuest_QuestTitles = {}
	if (UberQuest_Config.useminion) then
		UberQuest_List_SummonMinion:Show()
	else
		UberQuest_List_SummonMinion:Hide()
		UberQuest_Minion:Hide()
	end
	-- Copied muchly from QuestLog_Update(), Blizzard code, with updates for sexual prowess.
	local numEntries, numQuests = GetNumQuestLogEntries()
	if ( numEntries == 0 ) then
		--EmptyQuestLogFrame:Show()
		UberQuest_List_AbandonButton:Disable()
		UberQuest_List.hasTimer = nil
		UberQuest_List_ExpandButtonFrame:Hide()
	else
		--EmptyQuestLogFrame:Hide()
		UberQuest_List_AbandonButton:Enable()
		UberQuest_List_ExpandButtonFrame:Show()
		-- UberQuest_Details_Title:SetText ("Uber Quest ("..UBERQUEST_VERSION..")")
		-- UberQuest_Details:Show()
		-- UberQuest_Details_Update()
	end
	-- Update Quest Count
	UberQuest_List_QuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS))
	UberQuest_List_CountMiddle:SetWidth(UberQuest_List_QuestCount:GetWidth())

	-- ScrollFrame update
	FauxScrollFrame_Update(UberQuest_List_Scroll, numEntries, UBERQUEST_QUESTS_DISPLAYED, UBERQUEST_QUESTLINE_HEIGHT, nil, nil, nil, UberQuest_List_HighlightFrame, 293, 316 )

	if (numQuests and numQuests > 0) then
		local i
		for i=1, numEntries, 1 do
			local index = i
			local quest, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(i)
			if (quest and not isHeader) then
				if (UberQuest_GotFullList and UberQuest_Config.addnewquests and not UberQuest_ActivityTracker[quest]) then
					UberQuest_Config[UberQuest_Player].selected[quest] = 1
				end
				if (not UberQuest_ActivityTracker[quest]) then
					UberQuest_ActivityTracker[quest] = {}
				end
			end
		end
		if (UberQuest_ActivityTracker ~= {}) then
			UberQuest_GotFullList = true
		end
	end
	local numPartyMembers = GetNumPartyMembers()
	-- Update the quest listing
	UberQuest_List_HighlightFrame:Hide()
	for i=1, UBERQUEST_QUESTS_DISPLAYED, 1 do
		local questIndex = i + FauxScrollFrame_GetOffset(UberQuest_List_Scroll)
		local questLogTitle = getglobal("UberQuest_List_Title"..i)
		local questTitleTag = getglobal("UberQuest_List_Title"..i.."Tag")
		local questNormalText = getglobal("UberQuest_List_Title"..i.."NormalText")
		local questHighlightText = getglobal("UberQuest_List_Title"..i.."NormalText")
		local questDisabledText = getglobal("UberQuest_List_Title"..i.."NormalText")
		local questNumGroupMates = getglobal("UberQuest_List_Title"..i.."GroupMates")
		if ( questIndex <= numEntries ) then
			local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questIndex)
			local color
			if ( isHeader ) then
				if ( questLogTitleText ) then
					questLogTitle:SetText(questLogTitleText)
				else
					questLogTitle:SetText("")
				end
				
				if ( isCollapsed ) then
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
				else
					questLogTitle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up") 
				end
				questNumGroupMates:SetText("")
				getglobal("UberQuest_List_Title"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
				getglobal("UberQuest_List_Title"..i.."_MinionSelect"):Hide()
			else
				UberQuest_QuestTitles[i] = questLogTitleText
				if (UberQuest_Config.useminion) then
					getglobal("UberQuest_List_Title"..i.."_MinionSelect"):Show()
					getglobal("UberQuest_List_Title"..i.."_MinionSelect"):SetChecked(UberQuest_Config[UberQuest_Player].selected[questLogTitleText])
				else
					getglobal("UberQuest_List_Title"..i.."_MinionSelect"):Hide()
				end
				
				if ( UberQuest_Config.showquestlevels == 1 ) then		
				if ( questTag == ELITE ) then
					questLogTitle:SetText("  ["..level.."+] "..questLogTitleText)
				else									
			
					if ( questTag == RAID or questTag == "Schlachtzug" ) then
						questLogTitle:SetText("  ["..level.."R] "..questLogTitleText)
														
					else
						if ( questTag == "Dungeon" or questTag == "Donjon" or questTag == "Instanz" ) then
							questLogTitle:SetText("  ["..level.."D] "..questLogTitleText)
						else
							if ( questTag == "PvP" ) then
							questLogTitle:SetText("  ["..level.."P] "..questLogTitleText)
							else					
							questLogTitle:SetText("  ["..level.."] "..questLogTitleText)
							end
						end
					end
				end
				
			
		else
			questLogTitle:SetText("  "..questLogTitleText)
						
										
		end		
										
				questLogTitle:SetNormalTexture("")
				getglobal("UberQuest_List_Title"..i.."Highlight"):SetTexture("")
				local partyMembersOnQuest = 0
				for j=1, numPartyMembers do
					local isOnQuest = IsUnitOnQuest(questIndex, "party"..j)
					if ( isOnQuest and isOnQuest == 1 ) then
						partyMembersOnQuest = partyMembersOnQuest + 1
					end
				end
				if ( partyMembersOnQuest > 0 ) then
					questNumGroupMates:SetText("["..partyMembersOnQuest.."]")
				else
					questNumGroupMates:SetText("")
				end
			end
			-- Set the quest tag
			if ( isComplete ) then
				questTag = COMPLETE
			end
			if ( questTag ) then
				questTitleTag:SetText("("..questTag..")")
				-- Shrink text to accomdate quest tags without wrapping
				-- This is just wrong, so very very wrong.
				-- (Elite) is coming out at width 80
				if (questTag == "Elite" or questTag == "Raid" or questTag == "Fertig" or questTag == "PvP" ) then
					questNormalText:SetWidth(225)
				elseif (questTag == "Complete" or questTag == "Dungeon" or questTag == "Instanz") then
					questHighlightText:SetWidth(225)
					questDisabledText:SetWidth(225)
				elseif (questTag == "Schlachtzug") then
					questNormalText:SetWidth(205)
					questHighlightText:SetWidth(205)
					questDisabledText:SetWidth(205)
				else
					questNormalText:SetWidth(275 - 5 - questTitleTag:GetWidth())
					questHighlightText:SetWidth(275 - 5 - questTitleTag:GetWidth())
					questDisabledText:SetWidth(275 - 5 - questTitleTag:GetWidth())
				end
			else
				questTitleTag:SetText("")
				-- Reset to max text width
				questNormalText:SetWidth(275)
				questHighlightText:SetWidth(275)
				questDisabledText:SetWidth(275)
			end

			-- Color the quest title and highlight according to the difficulty level
			local playerLevel = UnitLevel("player")
			if ( isHeader ) then
				color = QuestDifficultyColor["header"]
			else
				color = GetDifficultyColor(level)
			end
			questTitleTag:SetTextColor(color.r, color.g, color.b)
			questLogTitle:SetTextColor(color.r, color.g, color.b)
			questNumGroupMates:SetTextColor(color.r, color.g, color.b)
			questLogTitle.r = color.r
			questLogTitle.g = color.g
			questLogTitle.b = color.b
			questLogTitle:Show()

			-- Place the highlight and lock the highlight state
			if ( UberQuest_List.selectedButtonID and GetQuestLogSelection() == questIndex ) then
			UberQuest_List_HighlightFrame:SetPoint("TOPLEFT", "UberQuest_List_Title"..i, "TOPLEFT", 0, 0)
			UberQuest_List_HighlightFrame:Show()
				questTitleTag:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
				questLogTitle:LockHighlight()
			else
				questLogTitle:UnlockHighlight()
			end
		else
			questLogTitle:Hide()
		end
	end
		
	-- Set the expand/collapse all button texture
	local numHeaders = 0
	local notExpanded = 0
	-- Somewhat redundant loop, but cleaner than the alternatives
	for i=1, numEntries, 1 do
		local index = i
		local questLogTitleText, level, questTag, isHeader, isCollapsed = GetQuestLogTitle(i)
		if ( questLogTitleText and isHeader ) then
			numHeaders = numHeaders + 1
			if ( isCollapsed ) then
				notExpanded = notExpanded + 1
			end
		end
	end
	-- If all headers are not expanded then show collapse button, otherwise show the expand button
	if ( notExpanded ~= numHeaders ) then
		UberQuest_List_ExpandButtonFrame_CollapseAllButton.collapsed = nil
		UberQuest_List_ExpandButtonFrame_CollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
	else
		UberQuest_List_ExpandButtonFrame_CollapseAllButton.collapsed = 1
		UberQuest_List_ExpandButtonFrame_CollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	end

	-- Update Quest Count
	UberQuest_List_QuestCount:SetText(format(QUEST_LOG_COUNT_TEMPLATE, numQuests, MAX_QUESTLOG_QUESTS))
	UberQuest_List_CountMiddle:SetWidth(UberQuest_List_QuestCount:GetWidth())

	-- If no selection then set it to the first available quest
	if ( GetQuestLogSelection() == 0 ) then
		UberQuest_SetFirstValidSelection()
	end

	-- Determine whether the selected quest is pushable or not
	if ( numEntries == 0 ) then
		UberQuest_List_ShareButton:Disable()
	elseif ( GetQuestLogPushable() and GetNumPartyMembers() > 0 ) then
		UberQuest_List_ShareButton:Enable()
	else
		UberQuest_List_ShareButton:Disable()
	end
end

function UberQuest_DetailsShowHide()
	if (UberQuest_Details:IsVisible()) then
		UberQuest_Details:Hide()
	else
		UberQuest_Details_Title:SetText ("Uber Quest ("..UBERQUEST_VERSION..")")
		UberQuest_Details:Show()
		UberQuest_Details_Update()
	end
end

function UberQuest_ConfigShowHide()
	if (UberQuest_ConfigFrame:IsVisible()) then
		UberQuest_ConfigFrame:Hide()
	else
		UberQuest_ConfigFrame:Show()
		UberQuest_Config_Update()
	end
end

function UberQuest_Config_Update()
	UberQuest_ConfigFrame_ShowQuestLevels:SetChecked(UberQuest_Config.showquestlevels)
	UberQuest_ConfigFrame_UseMinion:SetChecked(UberQuest_Config.useminion)
	UberQuest_ConfigFrame_LockMinion:SetChecked(UberQuest_Config[UberQuest_Player].lockminion)
	UberQuest_ConfigFrame_MinionAddNew:SetChecked(UberQuest_Config.addnewquests)
	UberQuest_ConfigFrame_ColorizeObjective:SetChecked(UberQuest_Config[UberQuest_Player].colorizeobjectives)
	UberQuest_ConfigFrame_ExpireObjective:SetChecked(UberQuest_Config[UberQuest_Player].expireobjectives) -- EMERALD
	UberQuest_ConfigFrame_ExpireQuest:SetChecked(UberQuest_Config[UberQuest_Player].expirequests) -- EMERALD
	UberQuest_ConfigFrame_ToggleMinionText:SetChecked(UberQuest_Config[UberQuest_Player].hidetext) -- D.I.

	if (UberQuest_Config.useminion) then
		UberQuest_ConfigFrame_LockMinion:Enable()
		UberQuest_ConfigFrame_MinionAddNew:Enable()
		UberQuest_ConfigFrame_ColorizeObjective:Enable()
		UberQuest_ConfigFrame_ExpireObjective:Enable() -- EMERALD
		UberQuest_ConfigFrame_ExpireQuest:Enable() -- EMERALD
	else
		UberQuest_ConfigFrame_LockMinion:Disable()
		UberQuest_ConfigFrame_MinionAddNew:Disable()
		UberQuest_ConfigFrame_ColorizeObjective:Disable()
		UberQuest_ConfigFrame_ExpireObjective:Disable() -- EMERALD
		UberQuest_ConfigFrame_ExpireQuest:Disable() -- EMERALD
	end

	if (UberQuest_Config.color and UberQuest_Config.color.r and UberQuest_Config.color.g and UberQuest_Config.color.b and UberQuest_Config.color.opacity) then
		UberQuest_Minion_ColorPicker = { r = UberQuest_Config.color.r, 
						 g = UberQuest_Config.color.g, 
						 b = UberQuest_Config.color.b } 
		UberQuest_ConfigFrame_BGColorSwatchBg:SetVertexColor(UberQuest_Config.color.r, 
								UberQuest_Config.color.g, 
								UberQuest_Config.color.b)
	else
		UberQuest_Minion_ColorPicker = { r = TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, 
						 g = TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, 
						 b = TOOLTIP_DEFAULT_BACKGROUND_COLOR.b } 
		UberQuest_ConfigFrame_BGColorSwatchBg:SetVertexColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, 
								TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, 
								TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	end
end

function UberQuest_Minion_OnOff(val)
	if (val) then
	else
		if (UberQuest_Minion:IsVisible()) then
			UberQuest_MinionShowHide()
		end
	end
end

function UberQuest_MinionSelect_OnClick()
	if (UberQuest_QuestTitles[this:GetParent():GetID()]) then
		if (this:GetChecked()) then
			UberQuest_Config[UberQuest_Player].selected[UberQuest_QuestTitles[this:GetParent():GetID()]] = 1
		else
			UberQuest_Config[UberQuest_Player].selected[UberQuest_QuestTitles[this:GetParent():GetID()]] = nil
		end
		if (UberQuest_Minion:IsVisible()) then
			UberQuest_Minion_Update()
		end
	end
end

function UberQuest_MinionShowHide()
	if (UberQuest_Config and UberQuest_Player and UberQuest_Config[UberQuest_Player]) then
		if (UberQuest_Minion:IsVisible()) then
			UberQuest_Minion:Hide()
			UberQuest_List_SummonMinion:SetText(UBERQUEST_SUMMONMINION)
			UberQuest_Config[UberQuest_Player].minionvisible = nil
		else
			UberQuest_Minion:Show()
			UberQuest_List_SummonMinion:SetText(UBERQUEST_DISMISSMINION)
			UberQuest_Minion_Update()
			UberQuest_Config[UberQuest_Player].minionvisible = 1
		end
	end
end

function UberQuest_Minion_Update()
	local function ConvertColorFormat(color) 
		local function dec2hex(decnum)
			if (decnum == 0) then return "00" end
    			local hexnum=""
 			local tempval
			decnum = 255*decnum
			if ((decnum-math.floor(decnum)) > 0) then
				decnum = decnum + 1
			end
			decnum = math.floor(decnum)
			while (decnum ~= 0) do
    				tempval = math.mod(decnum,16)
    				if (tempval > 9) then
					tempval = string.char(tempval + 55)
				end
				hexnum = tempval..hexnum
				decnum = math.floor(decnum / 16) 
				if (decnum < 16) then
					if (decnum > 9) then
						decnum = string.char(decnum + 55)
					end
					hexnum = decnum..hexnum 
					decnum = 0 
				end
			end
			return hexnum
		end
		return (dec2hex(color.r)..dec2hex(color.g)..dec2hex(color.b))
	end
	local function DifficultyColor(now,max)
		local startrange = QuestDifficultyColor["impossible"]
		local midrange = QuestDifficultyColor["difficult"]
		local endrange = QuestDifficultyColor["standard"]
		now = tonumber(now) 
		max = tonumber(max)
		if (not now or now == 0 or now > max) then
			return ConvertColorFormat(startrange)
		elseif (now == (max / 2)) then
			return ConvertColorFormat(midrange)
		elseif (now == max) then
			return ConvertColorFormat(endrange)
		elseif (now <= (max / 2)) then
			local color = {}
			local percent = now / max
			color.r = startrange.r
			color.g = startrange.g + ((midrange.g - startrange.g) * percent)
			color.b = startrange.b - ((startrange.b - midrange.b) * percent)
			return ConvertColorFormat(color)
		else 
			local color = {}
			local percent = now / max
			color.r = midrange.r - ((midrange.r - endrange.r) * percent)
			color.g = midrange.g - ((midrange.g - endrange.g) * percent)
			color.b = midrange.b + ((endrange.b - midrange.b) * percent)
			return ConvertColorFormat(color)
		end
	end
	local applytext = ""
	local questlist = {}
	local i = 1
	local j
	if (UberQuest_Config and UberQuest_Player and UberQuest_Config[UberQuest_Player] and UberQuest_Config[UberQuest_Player].selected and UberQuest_Config[UberQuest_Player].selected ~= {}) then
		local category = nil
		local questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i)
		while (questLogTitleText) do
			if (isHeader) then
				category = questLogTitleText
			elseif (UberQuest_Config[UberQuest_Player].selected[questLogTitleText]) then
				questlist[questLogTitleText] = i
					UberQuests_ThereAreQuests = 1

			--[[

				if (applytext ~= "") then
					applytext = applytext.."\n"
				end
				local color = ConvertColorFormat(GetDifficultyColor(level))
				
				-- Better Questlevels to Minion	
				
		if ( UberQuest_Config.showquestlevels == 1 ) then		
				if ( questTag == ELITE ) then
					applytext = applytext.."|cff"..color.."["..level.."+] "..questLogTitleText.."|r"
				else									
			
					if ( questTag == RAID or questTag == "Schlachtzug") then
						applytext = applytext.."|cff"..color.."["..level.."R] "..questLogTitleText.."|r"
														
					else
						if ( questTag == "Dungeon" or questTag == "Donjon" or questTag == "Instanz") then
							applytext = applytext.."|cff"..color.."["..level.."D] "..questLogTitleText.."|r"
						else						
							if ( questTag == "PvP") then
								applytext = applytext.."|cff"..color.."["..level.."P] "..questLogTitleText.."|r"
							else					
							applytext = applytext.."|cff"..color.."["..level.."] "..questLogTitleText.."|r"
							end
						end
					end
				end
				
		else
		
		applytext = applytext.."|cff"..color..questLogTitleText.."|r"
													
		end
				
				if (isComplete) then
					color = ConvertColorFormat(QuestDifficultyColor["header"])
					applytext = applytext.." |cff"..color.."("..UBERQUEST_QCOMPLETE..")|r"
				else
				 ]]--

				 -- EMERALD START
				local color = ConvertColorFormat(GetDifficultyColor(level))
				
				if (isComplete) then
					if (not UberQuest_Config[UberQuest_Player].expirequests) then
						if (applytext ~= "") then
							applytext = applytext.."\n"
						end
						if (UberQuest_Config.showquestlevels ==1) then

							if ( questTag == ELITE ) then
								applytext = applytext.."|cff"..color.."["..level.."+] "..questLogTitleText.."|r"
							else									
					
								if ( questTag == RAID or questTag == "Schlachtzug") then
									applytext = applytext.."|cff"..color.."["..level.."R] "..questLogTitleText.."|r"
												
								else
									if ( questTag == "Dungeon" or questTag == "Donjon" or questTag == "Instanz") then
										applytext = applytext.."|cff"..color.."["..level.."D] "..questLogTitleText.."|r"
									else	
										if ( questTag == "PvP") then
											applytext = applytext.."|cff"..color.."["..level.."P] "..questLogTitleText.."|r"
										else				
										applytext = applytext.."|cff"..color.."["..level.."] "..questLogTitleText.."|r"
										end
									end
								end
							end

						end
						color = ConvertColorFormat(QuestDifficultyColor["header"])
						applytext = applytext.." |cff"..color.."("..UBERQUEST_QCOMPLETE..")|r"
					end
				else
					if (applytext ~= "") then
						applytext = applytext.."\n"
					end
					if (UberQuest_Config.showquestlevels) then
							if ( questTag == ELITE ) then
								applytext = applytext.."|cff"..color.."["..level.."+] "..questLogTitleText.."|r"
							else									
					
								if ( questTag == RAID or questTag == "Schlachtzug") then
									applytext = applytext.."|cff"..color.."["..level.."R] "..questLogTitleText.."|r"			
								else
									if ( questTag == "Dungeon" or questTag == "Donjon" or questTag == "Instanz") then
										applytext = applytext.."|cff"..color.."["..level.."D] "..questLogTitleText.."|r"
									else		
										if ( questTag == "PvP") then
											applytext = applytext.."|cff"..color.."["..level.."P] "..questLogTitleText.."|r"
										else			
										applytext = applytext.."|cff"..color.."["..level.."] "..questLogTitleText.."|r"
										end
									end
								end
							end
						else
						applytext = applytext.."|cff"..color..questLogTitleText.."|r"

					end -- EMERALD END


					SelectQuestLogEntry(i)
					for j = 1, GetNumQuestLeaderBoards(), 1 do
						local text, typ, finished = GetQuestLogLeaderBoard(j)
						if ( not text or strlen(text) == 0 ) then
							text = typ
						end
						if (finished) then -- EMERALD START
							if (not UberQuest_Config[UberQuest_Player].expireobjectives) then
								color = ConvertColorFormat(QuestDifficultyColor["header"])
							applytext = applytext.."\n  |cff"..color..text.." ("..UBERQUEST_QCOMPLETE..")|r"
							end
						else -- EMERALD END
							local item, now, max
							for item, now, max in string.gfind(text,"([^:]+): (%d+)/(%d+)$") do
								if (item and now and max) then
									if (UberQuest_Config[UberQuest_Player].colorizeobjectives) then
										color = DifficultyColor(now,max)
									else
										color = "ffffff"
									end

								end
							end
							applytext = applytext.."\n  |cff"..color..text.."|r"
						end
					end
				end
			end
			i = i + 1
			questLogTitleText, level, questTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(i)
		end
		if (applytext == "") then
			if (UberQuest_Config[UberQuest_Player].hidetext) then
				UberQuest_Minion_Text:SetText("")
			else
				UberQuest_Minion_Text:SetText(UBERQUEST_MINION_NOQUESTS)
			end
		else
			UberQuest_Minion_Text:SetText(applytext)
		end
		if (UberQuests_ThereAreQuests) then
			for i in UberQuest_Config[UberQuest_Player].selected do
				if (not questlist[i]) then
					UberQuest_Config[UberQuest_Player].selected[i] = nil
					UberQuest_ActivityTracker[i] = nil
				end
			end
		end
	else
		if (UberQuest_Config[UberQuest_Player].hidetext) then
			UberQuest_Minion_Text:SetText("")
		else
			UberQuest_Minion_Text:SetText(UBERQUEST_MINION_NOQUESTS)
		end
	end
	if (UberQuest_SelectedQuest) then
		SelectQuestLogEntry(UberQuest_SelectedQuest)
	end
	local width = UberQuest_Minion_Text:GetWidth() + 15
	local height = UberQuest_Minion_Text:GetHeight() + 15
	if (width < 100) then width = 100 end
	if (height < 30) then height = 30 end
	if (UberQuest_MinionSetOnce) then
		-- Running this before the Width and Height are set at least once always 
		-- screws up the corner locking.
		UberQuest_Minion_LockCornerForGrowth()
	end
	UberQuest_MinionSetOnce = 1
	UberQuest_Minion:SetWidth(width)
	UberQuest_Minion:SetHeight(height)
end

function UberQuest_Minion_LockCornerForGrowth()
	local Left = UberQuest_Minion:GetLeft()
	local Right = UberQuest_Minion:GetRight()
	local Top = UberQuest_Minion:GetTop()
	local Bottom = UberQuest_Minion:GetBottom()
	local lock
	local pointone
	local pointtwo
	local TOPBOTTOM_MEDIAN = 384
	local LEFTRIGHT_MEDIAN = 512
	if (Left and Right and Top and Bottom) then
		if (Bottom < TOPBOTTOM_MEDIAN and Top > TOPBOTTOM_MEDIAN) then
			local topcross = Top - TOPBOTTOM_MEDIAN
			local bottomcross = TOPBOTTOM_MEDIAN - Bottom
			if (bottomcross > topcross) then
				lock = "BOTTOM"
				pointtwo = Bottom
			else
				lock = "TOP"
				pointtwo = Top
			end
		elseif (Top > TOPBOTTOM_MEDIAN) then
			lock = "TOP"
			pointtwo = Top
		elseif (Bottom < TOPBOTTOM_MEDIAN) then
			lock = "BOTTOM"
			pointtwo = Bottom
		end
		if (Left < LEFTRIGHT_MEDIAN and Right > LEFTRIGHT_MEDIAN) then
			-- Minion crossed the LEFT/RIGHT median
			local leftcross = LEFTRIGHT_MEDIAN - Left
			local rightcross = Right - LEFTRIGHT_MEDIAN
			if (rightcross > leftcross) then
				lock = lock.."RIGHT"
				pointone = Right
			else
				lock = lock.."LEFT"
				pointone = Left
			end
		elseif (Left < LEFTRIGHT_MEDIAN) then
			lock = lock.."LEFT"
			pointone = Left
		elseif (Right > LEFTRIGHT_MEDIAN) then
			lock = lock.."RIGHT"
			pointone = Right
		end
		if (lock and lock ~= "" and pointone and pointtwo) then
			UberQuest_Minion:ClearAllPoints()
			UberQuest_Minion:SetPoint(lock,"UIParent","BOTTOMLEFT",pointone,pointtwo)
			UberQuest_Config[UberQuest_Player].lock = {}
			UberQuest_Config[UberQuest_Player].lock.corner = lock
			UberQuest_Config[UberQuest_Player].lock.pointone = pointone
			UberQuest_Config[UberQuest_Player].lock.pointtwo = pointtwo
		elseif (UberQuests_ThereAreQuests and
			UberQuest_Config[UberQuest_Player].lock and
			UberQuest_Config[UberQuest_Player].lock.corner and
			UberQuest_Config[UberQuest_Player].lock.pointone and
			UberQuest_Config[UberQuest_Player].lock.pointtwo) then
			UberQuest_Minion:ClearAllPoints()
			UberQuest_Minion:SetPoint(UberQuest_Config[UberQuest_Player].lock.corner,"UIParent","BOTTOMLEFT",UberQuest_Config[UberQuest_Player].lock.pointone,UberQuest_Config[UberQuest_Player].lock.pointtwo)
		end
	end
end

function UberQuest_TitleButton_OnClick(button)
	if ( button == "LeftButton" ) then
		if ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(this:GetText())
		end
		UberQuest_List_SetSelection(this:GetID() + FauxScrollFrame_GetOffset(UberQuest_List_Scroll))
		UberQuest_List_Update()
	end
end

function UberQuest_Minion_ColorPick()
	ColorPickerFrame.func = UberQuest_Minion_SetColor
	ColorPickerFrame.hasOpacity = 1
	ColorPickerFrame.opacityFunc = UberQuest_Minion_SetOpacity
	ColorPickerFrame.cancelFunc = UberQuest_Minion_Cancel
	if (UberQuest_Config.color and UberQuest_Config.color.r and UberQuest_Config.color.g and UberQuest_Config.color.b and UberQuest_Config.color.opacity) then
		ColorPickerFrame:SetColorRGB(	UberQuest_Config.color.r,
						UberQuest_Config.color.g,
						UberQuest_Config.color.b)
		ColorPickerFrame.opacity = UberQuest_Config.color.opacity
		ColorPickerFrame.previousValues = {r=UberQuest_Config.color.r, g=UberQuest_Config.color.g, b=UberQuest_Config.color.b, opacity=UberQuest_Config.color.opacity}
	else
		ColorPickerFrame:SetColorRGB(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
		ColorPickerFrame.previousValues = {r=TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, g=TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, b=TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, opacity=0}
		ColorPickerFrame.opacity = 0
	end
	ShowUIPanel(ColorPickerFrame)
end

function UberQuest_Minion_SetColor()
	local r,g,b = ColorPickerFrame:GetColorRGB()
	UberQuest_MinionBackdrop:SetBackdropColor(r, g, b)
	if (not UberQuest_Config.color) then
		UberQuest_Config.color = {}
	end
	UberQuest_Config.color.r = r
	UberQuest_Config.color.g = g
	UberQuest_Config.color.b = b
	UberQuest_Config_Update()
end

function UberQuest_Minion_SetOpacity()
	local alpha = 1.0 - OpacitySliderFrame:GetValue()
	UberQuest_MinionBackdrop:SetAlpha(alpha)
	if (not UberQuest_Config.color) then
		UberQuest_Config.color = {}
	end
	UberQuest_Config.color.opacity = OpacitySliderFrame:GetValue()
end

function UberQuest_Minion_Cancel(previousValues)
	if (not UberQuest_Config.color) then
		UberQuest_Config.color = {}
	end
	if (previousValues.r and previousValues.g and previousValues.b) then
		UberQuest_MinionBackdrop:SetBackdropColor(previousValues.r, previousValues.g, previousValues.b)
		UberQuest_Config.color.r = previousValues.r
		UberQuest_Config.color.g = previousValues.g
		UberQuest_Config.color.b = previousValues.b
	end
	if (previousValues.opacity) then
		local alpha = 1.0 - previousValues.opacity
		UberQuest_MinionBackdrop:SetAlpha(alpha)
		UberQuest_Config.color.opacity = previousValues.opacity
	end
	UberQuest_Config_Update()
end

function UberMinion_Scale_Update()
	local scale = UberMinionScale:GetValue() / 100
	UberQuest_Minion:SetScale(UIParent:GetScale() * scale)
	UberQuest_Config[UberQuest_Player]["scale"] = scale
	UberQuest_Minion_Update()
end


function QuestLogTitleButton_OnEnter()
		-- Set highlight
	getglobal(this:GetName().."Tag"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)

		-- Set group info tooltip
	QuestLog_UpdatePartyInfoTooltip()
end


function QuestLog_UpdatePartyInfoTooltip()
	local index = this:GetID() + FauxScrollFrame_GetOffset(UberQuest_List_Scroll)
	local numPartyMembers = GetNumPartyMembers()
		if ( numPartyMembers == 0 or this.isHeader ) then
			return
		end
	GameTooltip_SetDefaultAnchor(GameTooltip, this)

	local questLogTitleText = GetQuestLogTitle(index)
	GameTooltip:SetText(questLogTitleText)

	local isOnQuest, unitName, partyMemberOnQuest
		for i=1, numPartyMembers do
			isOnQuest = IsUnitOnQuest( index, "party"..i)
			unitName = UnitName("party"..i)
				if ( isOnQuest and isOnQuest == 1 ) then
					if ( not partyMemberOnQuest ) then
						GameTooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..PARTY_QUEST_STATUS_ON..FONT_COLOR_CODE_CLOSE)
						partyMemberOnQuest = 1
					end
					GameTooltip:AddLine(LIGHTYELLOW_FONT_COLOR_CODE..unitName..FONT_COLOR_CODE_CLOSE)
				end
		end
	if ( not partyMemberOnQuest ) then
		GameTooltip:AddLine(HIGHLIGHT_FONT_COLOR_CODE..PARTY_QUEST_STATUS_NONE..FONT_COLOR_CODE_CLOSE)
	end
	GameTooltip:Show()
end

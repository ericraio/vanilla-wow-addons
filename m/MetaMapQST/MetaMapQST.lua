-- MetaMapQST
-- Written by MetaHawk - aka Urshurak

QST_DELAY				= 0.5;
QST_BUTTONWIDTH = 400;

QST_HEADERCOLOUR    = "|cFFBFBFFF";
QST_TITLECOLOUR     = "|cFFFFFFFF";
QST_OVERVIEWCOLOUR  = "|cFF7F7F7F";
QST_SPECIALCOLOUR   = "|cFFFFFF00";
QST_INITIALCOLOUR   = "|cFFD82619";
QST_MIDDLECOLOUR    = "|cFFFFFF00";
QST_COMPLETEDCOLOUR	= "|cFF00FF19";

QST_Options       = {};
QST_QuestLog     = {};
QST_QuestBase     = {};
QST_QuestList     = {};
QST_ItemList      = {};
QST_AcceptQuest   = nil;
QST_FinishQuest   = nil;
QST_AbandonQuest   = nil;

QST_Default = {
	["LoadAlways"]  = false,
	["ShowPlayers"] = false,
	["ShowAll"]     = false,
	["ShowActive"]  = false,
	["SaveHistory"] = true,
	["SaveDesc"]    = true,
	["SaveRew"]     = true,
	["Padding"]     = 10,
	["SortOrder"]   = "logtime",
}

QST_VarsLoaded      = false;
QST_ButtonTotal	    = 0;
QST_ActivePlayer    = "";
QST_SelectedPlayer  = "";
QST_LastRefresh     = 0.0;
QST_QuestLogUpdate  = false;
QST_ShowHeader      = true;
QST_LastSearch      = "";
QST_QuestDetail     = nil;

QST_FilterMenu = {
	[1] = {QST_SORT_TITLE,  "SortOrdertitle"},
	[2] = {QST_SORT_LEVEL,  "SortOrderlevel"},
	[3] = {QST_SORT_LOGGED, "SortOrderlogtime"},
	[4] = {"", "", 1},
	[5] = {QST_FILTER_ALL, "ShowAll"},
	[6] = {QST_FILTER_MAP, "ShowPlayers"},
	[7] = {QST_FILTER_ACT, "ShowActive"},
	[8] = {"", "", 1},
}

function QST_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("QUEST_LOG_UPDATE");
	this:RegisterEvent("QUEST_DETAIL");
	this:RegisterEvent("QUEST_FINISHED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
end

function QST_OnEvent(event)
	if(event == "ADDON_LOADED" and arg1 == "MetaMapQST") then
		QST_LoadConfig();
	elseif(event == "QUEST_DETAIL") then
		QST_QuestDetail = GetTitleText();
	elseif(event == "ZONE_CHANGED_NEW_AREA") then
		QST_RefreshDisplay();
	elseif(event == "WORLD_MAP_UPDATE" and QST_DisplayFrame:IsVisible()) then
		QST_RefreshDisplay();
	elseif(event == "INSTANCE_MAP_UPDATE" and QST_DisplayFrame:IsVisible()) then
		QST_RefreshDisplay();
	elseif(event == "PLAYER_LEVEL_UP" and QST_DisplayFrame:IsVisible()) then
		QST_ShowDisplay();
	elseif(event == "UNIT_NAME_UPDATE" and QST_DisplayFrame:IsVisible()) then
		QST_ShowDisplay();
	elseif(event == "UPDATE_MOUSEOVER_UNIT") then
		QST_EnhanceTooltip();
	elseif(event == "QUEST_LOG_UPDATE") then
		QST_QuestLogUpdate = true;
		QST_LastRefresh = 0.0;
	end
end

function QST_ToggleFrame(mode)
	if(mode == 2) then return; end
	if(QST_DisplayFrame:IsVisible()) then
		MetaMapContainer_ShowFrame();
		if(mode == 1) then
			MetaMap_ToggleFrame(WorldMapFrame);
		end
	else
		if(not WorldMapFrame:IsVisible()) then
			MetaMap_ToggleFrame(WorldMapFrame);
		end
		MetaMapContainer_ShowFrame(QST_DisplayFrame);
	end
end

function QST_LoadConfig()
	--- Hooks
	QST_Orig_afTooltip = aftt_setName;
	aftt_setName = QST_afTooltip;
	QST_Orig_ContainerButtonOnEnter = ContainerFrameItemButton_OnEnter;
	ContainerFrameItemButton_OnEnter = QST_ContainerButtonOnEnter;
	Orig_QuestAcceptOnClick = QuestDetailAcceptButton_OnClick;
	QuestDetailAcceptButton_OnClick = QST_QuestAcceptOnClick;
	Orig_RewardCompleteOnClick = QuestRewardCompleteButton_OnClick;
	QuestRewardCompleteButton_OnClick = QST_QuestCompleteOnClick;
	Orig_AbandonQuest = AbandonQuest;
	AbandonQuest = QST_AbandonQuestOnClick;
	if(IsAddOnLoaded("Sanity")) then
		QST_OrigSanityButtonOnEnter = SanityItemButton_OnEnter;
		SanityItemButton_OnEnter = QST_SanityButtonOnEnter;
	end
	--- End Hooks
	for option, value in QST_Default do
		if(QST_Options[option] == nil) then QST_Options[option] = value; end
	end
	if(QST_QuestLog == nil) then QST_QuestLog = {}; end
	QST_ActivePlayer = UnitName("player").." of "..GetCVar("realmName");
	QST_SelectedPlayer = QST_ActivePlayer;
	QST_UpdateQuests();
	QST_UpdatePlayer();
	UIDropDownMenu_Initialize(QST_FilterSelectMenu, QST_FilterMenuInit, "MENU");
	UIDropDownMenu_SetText(QST_SelectedPlayer, QST_FilterSelect)
	QST_VarsLoaded = true;
end

function QST_OnUpdate(arg1)
	if(not QST_VarsLoaded) then return; end
	if(QST_QuestLogUpdate == true) then
		QST_LastRefresh = QST_LastRefresh + arg1;
		if(QST_LastRefresh > QST_DELAY) then
			QST_UpdateQuests();
			QST_LastRefresh = 0.0;
			QST_QuestLogUpdate = false;
		end
	end
end

function QST_UpdatePlayer()
	local tempPlayers = {};
	local t = table.getn(QST_FilterMenu)+1;
	for index, qData in QST_QuestLog do
		for player, value in qData.qPlayer do
			if(tempPlayers[player] == nil) then
				tempPlayers[player] = 1;
			end
		end
	end
	for index, qData in QST_QuestBase do
		for player, value in qData.qPlayer do
			if(tempPlayers[player] == nil) then
				tempPlayers[player] = 1;
			end
		end
	end
	for player, value in tempPlayers do
		QST_FilterMenu[t] = {player, "player"};
		t = t +1;
	end
end

function QST_UpdateQuests()
	local qData, qZone;
	for qIndex=1, GetNumQuestLogEntries(), 1 do
		local QuestTitle, _, _, isHeader = GetQuestLogTitle(qIndex);
		if(isHeader) then
			qZone = QuestTitle;
		else
			SelectQuestLogEntry(qIndex);
			for index, qQuests in QST_QuestLog do
				if(qQuests.qTitle == QuestTitle and qQuests.qPlayer[QST_ActivePlayer]) then 
					qData = qQuests; break;
				end
			end
			if(qData) then
				QST_UpdateDataBase(qData, qIndex);
			else
				local n = table.getn(QST_QuestLog)+1;
				QST_QuestLog[n] = {};
				QST_CreateDatabase(QST_QuestLog[n], qZone, qIndex);
			end
			qData = nil;
		end
	end
	QST_SetLogOrder();
	if(QST_DisplayFrame:IsVisible()) then
		QST_RefreshDisplay();
	end
end

function QST_SetLogOrder()
	local TmpData = {};
	local new = 1;
	for index, value in QST_QuestLog do
		TmpData[new] = {};
		TmpData[new] = value;
		new = new +1;
	end
	QST_QuestLog = {};
	QST_QuestLog = TmpData;
end

function QST_UpdateDataBase(qData, qIndex)
	local QuestTitle, QuestLevel, QuestTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(qIndex);
	local Description, Objectives = GetQuestLogQuestText();
	local status = "";
	if(isComplete == nil) then status = QST_MIDDLECOLOUR..QST_QUEST_ACTIVE;
	elseif(isComplete < 0) then status = QST_INITIALCOLOUR..QST_QUEST_FAILED;
	elseif(isComplete == 1) then status = QST_COMPLETEDCOLOUR..QST_QUEST_DONE; end

	qData.qIndex = qIndex;
	qData["qPlayer"][QST_ActivePlayer]["qStatus"] = status;
	if(QST_AcceptQuest and QST_AcceptQuest.Title == QuestTitle) then
		qData["qNPC"][1] = {};
		qData["qNPC"][1].qName = QST_AcceptQuest.NPC;
		qData["qNPC"][1].qZone = QST_AcceptQuest.zone;
		qData["qNPC"][1].qX = QST_AcceptQuest.xPos;
		qData["qNPC"][1].qY = QST_AcceptQuest.yPos;
		QST_AcceptQuest = nil;
	end
	QST_UpdateQuestItems(QuestTitle, qData);
end

function QST_CreateDatabase(qData, qZone, qIndex)
	local QuestTitle, QuestLevel, QuestTag, isHeader, isCollapsed, isComplete = GetQuestLogTitle(qIndex);
	local Description, Objectives = GetQuestLogQuestText();
	local continent, zone = MetaMap_NameToZoneID(qZone);
	local status = "";

	if(isComplete == nil) then status = QST_MIDDLECOLOUR..QST_QUEST_ACTIVE;
	elseif(isComplete < 0) then status = QST_INITIALCOLOUR..QST_QUEST_FAILED;
	elseif(isComplete == 1) then status = QST_COMPLETEDCOLOUR..QST_QUEST_DONE; end
	if(zone == 0) then qData["qArea"] = GetRealZoneText(); end

	qData["qTitle"] = QuestTitle;
	qData["qZone"] = qZone;
	qData["qObj"] = Objectives;
	qData["qDesc"] = Description;
	qData["qLogtime"] = GetTime();
	qData["qNote"] = "";
	qData["qMoney"] = GetQuestLogRewardMoney();
	qData["qLevel"] = QuestLevel;
	qData["qTag"] = QuestTag;
	qData["qIndex"] = qIndex;
	qData["qPlayer"] = {};
	qData["qNPC"] = {};
	qData["qPlayer"][QST_ActivePlayer] = {};
	qData["qPlayer"][QST_ActivePlayer]["qStatus"] = status;
		
	if(GetNumQuestLogRewards() > 0) then
		qData["qReward"] = {};
		for index=1, GetNumQuestLogRewards(), 1 do
			local name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo(index);
			qData["qReward"][index] = {};
			qData["qReward"][index]["qAmount"] = numItems;
			qData["qReward"][index]["qLink"] = GetQuestLogItemLink("reward", index);
			qData["qReward"][index]["qTex"] = texture;
		end
	end
	if(GetNumQuestLogChoices() > 0) then
		qData["qChoice"] = {};
		for index=1, GetNumQuestLogChoices(), 1 do
			local name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo(index);
			qData["qChoice"][index] = {};
			qData["qChoice"][index]["qAmount"] = numItems;
			qData["qChoice"][index]["qLink"] = GetQuestLogItemLink("choice", index);
			qData["qChoice"][index]["qTex"] = texture;
		end
	end
	if(GetQuestLogRewardSpell()) then
		qData["qSpell"] = {};
		local texture, name = GetQuestLogRewardSpell();
		qData["qSpell"] = {};
		qData["qSpell"]["qLink"] = name;
		qData["qSpell"]["qTex"] = texture;
	end
	if(QST_AcceptQuest and QST_AcceptQuest.Title == QuestTitle) then
		qData["qNPC"][1] = {};
		qData["qNPC"][1].qName = QST_AcceptQuest.NPC;
		qData["qNPC"][1].qZone = QST_AcceptQuest.zone;
		qData["qNPC"][1].qX = QST_AcceptQuest.xPos;
		qData["qNPC"][1].qY = QST_AcceptQuest.yPos;
		QST_AcceptQuest = nil;
	end
	QST_UpdateQuestItems(QuestTitle, qData);
end

function QST_UpdateQuestItems(QuestTitle, qData)
	if(GetNumQuestLeaderBoards() > 0) then
		qData["qItems"] = {};
		for index=1, GetNumQuestLeaderBoards(), 1 do
			local LeaderBoardText, iType, Finished = GetQuestLogLeaderBoard(index);
			local i, j, ItemName, NumItems, NumNeeded = string.find(LeaderBoardText, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$");
			if(NumItems ~= nil) then
				local slain = "";
				i, j = string.find(ItemName, QST_TOOLTIP_SLAIN);
				if(i ~= nil) then
					ItemName = string.sub(ItemName, 1, i - 2);
					slain = " "..QST_TOOLTIP_SLAIN;
				end
				qData["qItems"][index] = {};
				qData["qItems"][index] = ItemName..slain..": "..NumItems.."/"..NumNeeded;
				QST_ItemList[ItemName] = {};
				QST_ItemList[ItemName]["qTitle"] = QuestTitle;
				QST_ItemList[ItemName]["qItems"] = NumItems.."/"..NumNeeded;
			end
		end
	end
end

function QST_RefreshDisplay()
	QST_QuestList = {};
	local qCount2, qTotal2, aCount2, aTotal2 = QST_DisplayInit("QST_QuestBase");
	local qCount1, qTotal1, aCount1, aTotal1 = QST_DisplayInit("QST_QuestLog");
	QST_InfoText1:SetText(QST_QUEST_TEXT..": "..qCount1 + qCount2.."/"..qTotal1 + qTotal2);
	QST_InfoText2:SetText(QST_QUEST_ACTIVE..": "..aCount1 + aCount2.."/"..aTotal1 + aTotal2);
	QST_SortQuestList(QST_Options.SortOrder);
	QST_ShowDisplay();
end

function QST_DisplayInit(qDB)
	QST_ShowHeader = true;
	local qBase = getglobal(qDB);
	local questCount, questTotal, activeCount, activeTotal = 0,0,0,0;
	local mapContinent, mapZone, _, mapName = MetaMap_GetCurrentMapInfo();
	QST_HeaderText:SetText(mapName);

	for index, qData in qBase do
		local showThis = false;
		local continent, zone;
		questTotal = questTotal +1;
		if(qData.qIndex) then activeTotal = activeTotal +1; end
		if(qData.qArea) then
			if(QST_GetLandMark(qData.qZone)) then showThis = true;
			elseif(qData.qArea == mapName) then showThis = true;
			else continent, zone = MetaMap_NameToZoneID(qData.qArea); end
		else
			continent, zone = MetaMap_NameToZoneID(qData.qZone);
		end
		if(mapName == "World") then showThis = true; end
		if(continent == mapContinent and mapName == "Kalimdor") then showThis = true; end
		if(continent == mapContinent and mapName == "Eastern Kingdoms") then showThis = true; end
		if(continent == mapContinent and zone == mapZone) then showThis = true; end
		if(not QST_Options.ShowPlayers and not qData["qPlayer"][QST_SelectedPlayer]) then showThis = false; end
		if(QST_Options.ShowActive and not qData.qIndex) then showThis = false; end
		if(qData.qZone == mapName and not QST_Options.ShowAll) then QST_ShowHeader = false; end
		if(qData.qArea and qData.qArea == mapName and not QST_Options.ShowAll) then QST_ShowHeader = false; end
			if(showThis or QST_Options.ShowAll) then
			if(string.find(string.lower(qData.qTitle),string.lower(QST_LastSearch),1,true)~=nil
				or string.find(string.lower(qData.qDesc),string.lower(QST_LastSearch),1,true)~=nil
				or string.find(string.lower(qData.qObj),string.lower(QST_LastSearch),1,true)~=nil
				or string.find(string.lower(qData.qZone),string.lower(QST_LastSearch),1,true)~=nil
				or string.find(string.lower(qData.qNote),string.lower(QST_LastSearch),1,true)~=nil) then
				tinsert(QST_QuestList, {qTitle = qData.qTitle, qZone = qData.qZone, qLevel = qData.qLevel, qLogtime = qData.qLogtime, qDB = qDB, qIndex = index});
				if(qData["qPlayer"][QST_SelectedPlayer]) then
					if(string.find(qData["qPlayer"][QST_SelectedPlayer]["qStatus"], "Active")) then activeCount = activeCount +1; end
				end
				questCount = questCount + 1;
			end
		end
	end
	return questCount, questTotal, activeCount, activeTotal;
end

function QST_SortQuestList(sort)
	local tmpList = {};
	local name = "";
	local tmp = MetaMap_sortType;
	MetaMap_sortType = METAMAP_SORTBY_NAME;
	for index, value in QST_QuestList do
		if(sort == "title") then
			name = value.qZone..value.qTitle..value.qLevel;
		elseif(sort == "level") then
			name = value.qZone..value.qLevel..value.qTitle;
		else
			name = value.qZone..value.qLogtime;
		end
		tinsert(tmpList, {qTitle = value.qTitle, qZone = value.qZone, qLevel = value.qLevel, qLogtime = value.qLogtime, qDB = value.qDB, qIndex = value.qIndex, name = name});
	end
	QST_QuestList = {};
  table.sort(tmpList, MetaMap_SortCriteria);
	for index, value in tmpList do
		tinsert(QST_QuestList, {qTitle = value.qTitle, qZone = value.qZone, qLevel = value.qLevel, qLogtime = value.qLogtime, qDB = value.qDB, qIndex = value.qIndex});
	end
	tmpList = nil;
	MetaMap_sortType = tmp;
end

function QST_ShowDisplay()
	local questInfo = "";
	local buttonID = 1;
	local setHeader = "";
	local ScrollHeight = 0;

	for index, qList in QST_QuestList do
		local qData = getglobal(qList.qDB)[qList.qIndex];
		if(QST_ShowHeader and setHeader ~= qData.qZone) then
			local area = "";
			local button = QST_CreateButton(buttonID);
			local buttontext = getglobal("QSTButton"..buttonID.."Text");
			if(qData.qArea) then area = " ("..qData.qArea..")"; end
			buttontext:SetText(format(QST_HEADERCOLOUR.."%s|r", qData.qZone..area).."\n");
			if(buttonID == 1) then
				button:SetPoint("TOPLEFT", "QST_ScrollChild", "TOPLEFT", 10, -10)
			else
				button:SetPoint("TOP", getglobal("QSTButton"..buttonID-1), "BOTTOM", 0, 0)
			end
			if(qData.qArea) then
				button.qMap = qData.qArea;
			else
				button.qMap = qData.qZone;
			end
			button.qDB = qList.qDB;
			button.qIndex = qList.qIndex;
			buttontext:SetWidth(QST_BUTTONWIDTH);
			button:SetHeight(buttontext:GetHeight() + QST_Options.Padding);
			button:SetParent("QST_ScrollChild");
			button:Show();
			ScrollHeight = ScrollHeight + button:GetHeight();
			setHeader = qData.qZone;
			buttonID = buttonID +1;
		end
		local button = QST_CreateButton(buttonID);
		local buttontext = getglobal("QSTButton"..buttonID.."Text");
		if(buttonID == 1) then
			button:SetPoint("TOPLEFT", "QST_ScrollChild", "TOPLEFT", 10, -10)
		else
			button:SetPoint("TOP", getglobal("QSTButton"..buttonID-1), "BOTTOM", 0, 0)
		end
		local col = GetDifficultyColor(qData.qLevel);
		local cText = "|c%02X%02X%02X%02X%s|r";
		local R = col.r * 255; local G = col.g * 255; local B = col.b * 255;
		questInfo = questInfo.."  ";
		if(qData.qTag == ELITE) then
			questInfo = questInfo..format(cText, 255, R, G, B, "["..qData.qLevel.."+] ");
		elseif(qData.qTag == QST_DUNGEON) then
			questInfo = questInfo..format(cText, 255, R, G, B, "["..qData.qLevel.."d] ");
		elseif(qData.qTag == RAID) then
			questInfo = questInfo..format(cText, 255, R, G, B, "["..qData.qLevel.."r] ");
		elseif(qData.qTag == QST_PVP) then
			questInfo = questInfo..format(cText, 255, R, G, B, "["..qData.qLevel.."p] ");
		else
			questInfo = questInfo..format(cText, 255, R, G, B, "["..qData.qLevel.."] ");
		end
		questInfo = questInfo..format(QST_TITLECOLOUR.."%s|r", qData.qTitle).."\n";
		if(qData.qItems) then
			for x, value in qData.qItems, 1 do
				questInfo = questInfo.."    "..QST_GetColourString(value)..value.."\n";
			end
		else
			questInfo = questInfo.."    "..format(QST_OVERVIEWCOLOUR.."%s|r", qData.qObj).."\n";
		end
		if(qData.qIndex) then
			for index, name in QST_FilterMenu do
				if(qData.qPlayer[name[1]]) then
					getglobal("QSTButton"..buttonID.."Status"):SetText(qData.qPlayer[name[1]].qStatus);
				end
			end
		else
			getglobal("QSTButton"..buttonID.."Status"):SetText(QST_QUEST_HISTORY);
		end
		if(strlen(qData.qNote) > 0) then
			getglobal("QSTButton"..buttonID.."Noted"):SetText(QST_HEADERCOLOUR..QST_NOTE_FLAG);
		end
		button.qDB = qList.qDB;
		button.qIndex = qList.qIndex;
		buttontext:SetText(questInfo);
		buttontext:SetWidth(QST_BUTTONWIDTH);
		button:SetHeight(buttontext:GetHeight() + QST_Options.Padding);
		button:SetParent("QST_ScrollChild");
		buttontext:Show();
		button:Show();
		questInfo = "";
		buttonID = buttonID + 1;
		ScrollHeight = ScrollHeight + button:GetHeight();
	end
	for i=buttonID, QST_ButtonTotal, 1 do
		getglobal("QSTButton"..i):Hide()
	end
	QST_ScrollChild:SetHeight(ScrollHeight);
	QST_ScrollFrame:UpdateScrollChildRect()
end

function QST_FilterMenuInit()
	for index, menuItem in QST_FilterMenu do
		local check = nil;
		local spacer = nil;
		if(menuItem[3]) then spacer = 1; end
		if(menuItem[2] == "player") then
			if(QST_Options.ShowPlayers) then
				check = 1;
			elseif(menuItem[1] == QST_SelectedPlayer) then
				check = 1;
			end
		elseif(QST_Options.SortOrder == string.gsub(menuItem[2], "SortOrder", "")) then
			check = 1;
		elseif(QST_Options[menuItem[2]]) then
			check = 1;
		end
		local info = {};
		info.isTitle = spacer;
		info.notClickable = spacer;
		info.checked = check;
		info.text = menuItem[1];
		info.value = menuItem[2];
		info.func = QST_FilterMenuOnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function QST_FilterMenuOnClick()
	if(this.value == "player") then
		QST_SelectedPlayer = this:GetText();
		QST_Options.ShowPlayers = false;
	elseif(string.find(this.value, "SortOrder")) then
		QST_Options.SortOrder = string.gsub(this.value, "SortOrder", "");
		QST_SortQuestList(QST_Options.SortOrder);
		QST_ShowDisplay();
		return;
	else
		QST_ToggleOptions(this.value);
	end
  UIDropDownMenu_SetText(this:GetText(), QST_FilterSelect);
	QST_RefreshDisplay();
end

function QSTButton_OnEnter()
	local qData = getglobal(this.qDB)[this.qIndex];
	if(not qData or QST_RewardFrame:IsVisible() or QST_EditorFrame:IsVisible()) then return; end
	WorldMapTooltip:SetOwner(QST_DisplayFrame, "ANCHOR_BOTTOMRIGHT", 0, QST_DisplayFrame:GetHeight()* QST_DisplayFrame:GetEffectiveScale());
	if(IsControlKeyDown()) then
		WorldMapTooltip:SetText(qData.qTitle, 1, 1, 1, 1);
		WorldMapTooltip:AddLine(qData.qNote, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
	elseif(IsShiftKeyDown()) then
		WorldMapTooltip:SetText(qData.qTitle, 1, 1, 1, 1);
		if(qData.qNPC[1]) then
			WorldMapTooltip:AddDoubleLine("QuestStart:", QST_COMPLETEDCOLOUR..qData.qNPC[1].qName, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		end
		if(qData.qNPC[2]) then
			WorldMapTooltip:AddDoubleLine("QuestEnd:", QST_COMPLETEDCOLOUR..qData.qNPC[2].qName, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		end
		WorldMapTooltip:AddLine(" ", 0, 0, 0, 0);
		for name, value in qData.qPlayer do
			WorldMapTooltip:AddDoubleLine(name, value.qStatus, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		end
	else
		WorldMapTooltip:SetText(qData.qTitle, 1, 1, 1, 1);
		WorldMapTooltip:AddLine(qData.qObj, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		WorldMapTooltip:AddLine(" ", 0, 0, 0, 0);
		if(qData.qDesc) then
			WorldMapTooltip:AddLine(qData.qDesc, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		end
		WorldMapTooltip:AddLine(qData.qTag, 1, 0, 1, 1);
		if(qData.qIndex) then
			SelectQuestLogEntry(qData.qIndex);
			for i = 1, GetNumPartyMembers() do
				if(IsUnitOnQuest(qData.qIndex, "party"..i)) then
					WorldMapTooltip:AddLine(QST_COMPLETEDCOLOUR..UnitName("party"..i));
				else
					WorldMapTooltip:AddLine(QST_INITIALCOLOUR..UnitName("party"..i));
				end
			end
		end
	end
	WorldMapTooltip:SetPoint("TOPRIGHT", QST_DisplayFrame, "TOPRIGHT", 0, 0);
	WorldMapTooltip:Show();
end

function QSTButton_OnClick(button)
	local qData = getglobal(this.qDB)[this.qIndex];
	QST_EditorFrame:Hide()
	if(this.qMap) then
		local continent, zone = MetaMap_NameToZoneID(this.qMap, 1);
		if(continent == 0 and zone > 0) then
			MetaMap_CurrentMap = zone;
			MetaMap_Toggle(true);
		else
			SetMapZoom(continent, zone);
		end
		return;
	end
	if(IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
		if(button == "LeftButton") then
			if(qData.qTag == ELITE) then
				ChatFrameEditBox:Insert("["..qData.qLevel.."+] "..qData.qTitle.." ");
			elseif(qData.qTag == QST_DUNGEON) then
				ChatFrameEditBox:Insert("["..qData.qLevel.."d] "..qData.qTitle.." ");
			elseif(qData.qTag == RAID) then
				ChatFrameEditBox:Insert("["..qData.qLevel.."r] "..qData.qTitle.." ");
			elseif(qData.qTag == QST_PVP) then
				ChatFrameEditBox:Insert("["..qData.qLevel.."p] "..qData.qTitle.." ");
			else
				ChatFrameEditBox:Insert("["..qData.qLevel.."] "..qData.qTitle.." ");
			end
		else
			local ChatItems = "";
			if(qData.qItems) then
				for i, value in qData.qItems, 1 do
					ChatItems = ChatItems.."{"..qData.qItems[i].."} ";
				end
			else
				ChatItems = ChatItems.."{"..qData.qObj.."} ";
			end
			ChatFrameEditBox:Insert(ChatItems);
		end
		return;
	elseif(IsControlKeyDown() and qData.qIndex) then
		if(button == "LeftButton") then
			SelectQuestLogEntry(qData.qIndex);
			if(GetQuestLogPushable() and GetNumPartyMembers() > 0) then
				QuestLogPushQuest();
			end
		else
			SelectQuestLogEntry(qData.qIndex);
			SetAbandonQuest();
			StaticPopup_Show("ABANDON_QUEST", GetAbandonQuestName());
			QST_AbandonQuest = GetAbandonQuestName();
		end
		return;
	else
		if(button == "LeftButton") then
			QST_RewardFrameShow(this.qDB, this.qIndex);
		else
			QST_QuestNoteShow(this.qDB, this.qIndex);
		end
	end
end

function QST_RewardFrameShow(qDB, qIndex)
	local qData = getglobal(qDB)[qIndex];
	local height = 100;
	local rewardCount, choiceCount, spellCount = 0,0,0;
	local receiveText = getglobal("QST_RewardItemReceiveText");
	local chooseText = getglobal("QST_RewardItemChooseText");
	
	if(qData.qChoice) then
		chooseText:Show();
		height = height + 14
		for i, choice in qData.qChoice do	
			local _, _, itemLink, itemName = string.find(choice.qLink, "|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
			rewardItem = getglobal("QST_RewardItem"..i);
			rewardItem.type = "choice";
			rewardItem.rewardType = "item";
			rewardItem.link = choice.qLink;
			rewardItem.itemID = itemLink;
			rewardItem:Show();
			SetItemButtonCount(rewardItem, choice.qAmount);
			SetItemButtonTexture(rewardItem, choice.qTex);
			if(qData.qIndex and qData.qPlayer[QST_ActivePlayer]) then
				SelectQuestLogEntry(qData.qIndex);
				_, _, _, _, isUsable = GetQuestLogChoiceInfo(i);
				if(isUsable) then
					SetItemButtonTextureVertexColor(rewardItem, 1.0, 1.0, 1.0);
				else
					SetItemButtonTextureVertexColor(rewardItem, 0.9, 0, 0);
				end
			else
				SetItemButtonTextureVertexColor(rewardItem, 1.0, 1.0, 1.0);
			end
			if(i > 1) then
				if(mod(i,2) == 1) then
					rewardItem:SetPoint("TOPLEFT", "QST_RewardItem"..(i - 2), "BOTTOMLEFT", 0, -2);
					height = height + 40
				else
					rewardItem:SetPoint("TOPLEFT", "QST_RewardItem"..(i - 1), "TOPRIGHT", 20, 0);
				end
			else
				rewardItem:SetPoint("TOPLEFT", "QST_RewardItemChooseText", "BOTTOMLEFT", 20, -5);
				height = height + 40
			end
			choiceCount = i;
		end
	else
		chooseText:Hide();
	end
	if(qData.qReward or qData.qSpell or (qData.qMoney and qData.qMoney > 0)) then
		height = height + 16;
		receiveText:Show();
		if(qData.qChoice) then
			local index = choiceCount;
			if(mod(index, 2) == 0 ) then
				index = index - 1;
			end
			receiveText:SetText(TEXT(REWARD_ITEMS));
			receiveText:SetPoint("TOPLEFT", "QST_RewardItem"..index, "BOTTOMLEFT", -20, -5);
		else 
			receiveText:SetText(TEXT(REWARD_ITEMS_ONLY));
			receiveText:SetPoint("TOPLEFT", "QST_RewardFrame", "TOPLEFT", 20, -45);
		end
		if(qData.qReward) then
			getglobal("QST_RewardItemReceiveText"):Show();
			for i, reward in qData.qReward do
				local _, _, itemLink, itemName = string.find(reward.qLink, "|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
				rewardItem = getglobal("QST_RewardItem"..(i + choiceCount));
				rewardItem.type = "reward";
				rewardItem.rewardType = "item";
				rewardItem.link = reward.qLink;
				rewardItem.itemID = itemLink;
				rewardItem:Show();
				SetItemButtonCount(rewardItem, reward.qAmount);
				SetItemButtonTexture(rewardItem, reward.qTex);
				if(qData.qIndex and qData.qPlayer[QST_ActivePlayer]) then
					SelectQuestLogEntry(qData.qIndex);
					_, _, _, _, isUsable = GetQuestLogRewardInfo(i);
					if(isUsable) then
						SetItemButtonTextureVertexColor(rewardItem, 1.0, 1.0, 1.0);
					else
						SetItemButtonTextureVertexColor(rewardItem, 0.9, 0, 0);
					end
				else
					SetItemButtonTextureVertexColor(rewardItem, 1.0, 1.0, 1.0);
				end
				if(i > 1) then
					if(mod(i,2) == 1) then
						rewardItem:SetPoint("TOPLEFT", "QST_RewardItem"..((i + choiceCount) - 2), "BOTTOMLEFT", 0, -2);
						height = height + 40
					else
						rewardItem:SetPoint("TOPLEFT", "QST_RewardItem"..((i + choiceCount) - 1), "TOPRIGHT", 20, 0);
					end
				else
					rewardItem:SetPoint("TOPLEFT", "QST_RewardItemReceiveText", "BOTTOMLEFT", 20, -5);
					height = height + 40
				end
				rewardCount = i;
			end
		end
		if(qData.qSpell) then
			local _, _, itemLink, itemName = string.find(qData.qSpell.qLink, "|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
			rewardItem = getglobal("QST_RewardItem"..(rewardCount + choiceCount + 1));
			rewardItem.rewardType = "spell";
			rewardItem.name = itemName;
			rewardItem.itemID = itemLink;
			rewardItem:Show();
			SetItemButtonTexture(rewardItem, qData.qSpell.qTex);
			if(rewardsCount > 0) then
				if(mod(rewardCount,2) == 0) then
					rewardItem:SetPoint("TOPLEFT", "QST_RewardItem"..((rewardCount + choiceCount) - 1), "BOTTOMLEFT", 0, -2);
					height = height + 40
				else
					rewardItem:SetPoint("TOPLEFT", "QST_RewardItem"..((rewardCount + choiceCount)), "TOPRIGHT", 20, 0);
				end
			else
				rewardItem:SetPoint("TOPLEFT", "QST_RewardItemReceiveText", "BOTTOMLEFT", 20, -5);
				height = height + 40
			end
			spellCount = 1;
		end
	else	
		receiveText:Hide();
	end
	local totalRewards = rewardCount + choiceCount + spellCount;
	for i=totalRewards + 1, 10, 1 do
		getglobal("QST_RewardItem"..i):Hide();
	end
	if(totalRewards > 0 or (qData.qMoney and qData.qMoney > 0)) then
		MoneyFrame_Update("QST_RewardMoneyFrame", qData.qMoney);
		local x, y = GetCursorPosition();
		x = x / UIParent:GetEffectiveScale();
		y = y / UIParent:GetEffectiveScale();
		QST_RewardFrame:SetPoint("LEFT", "UIParent", "BOTTOMLEFT", x-20, y);
		QST_RewardFrame:SetHeight(height);
		QST_RewardFrame:Show();
	end
end

function QST_RewardItemOnClick()
	if(IsControlKeyDown()) then
		if(this.rewardType ~= "spell") then
			MetaMap_ToggleDR(1);
			DressUpItemLink(this.itemID);
			DressUpFrame:Show();
			DressUpItemLink(this.itemID);
		end
	elseif(IsShiftKeyDown()) then
		if(ChatFrameEditBox:IsVisible()) then
			ChatFrameEditBox:Insert(this.link);
		end
	end
end

function QST_QuestNoteShow(qDB, qIndex)
	local qData = getglobal(qDB)[qIndex];
	QST_SaveNote.qDB = qDB;
	QST_SaveNote.qIndex = qIndex;
	QST_NotesEditBox:SetText(qData.qNote);
	QST_EditorFrame:Show();
	QST_NotesEditBox:SetFocus();
end

function QST_QuestNoteUpdate()
	local qData = getglobal(this.qDB)[this.qIndex];
	qData.qNote = QST_NotesEditBox:GetText();
	QST_EditorFrame:Hide();
	QST_ShowDisplay();
end

function QST_QuestAcceptOnClick()
	local x, y = GetPlayerMapPosition("player");
	local questStart = UnitName("target");
	if(questStart == nil) then questStart = "Quest Item"; end
	QST_AcceptQuest = {};
	QST_AcceptQuest.Title = QST_QuestDetail;
	QST_AcceptQuest.NPC = questStart;
	QST_AcceptQuest.zone = GetRealZoneText();
	QST_AcceptQuest.xPos = x;
	QST_AcceptQuest.yPos = y;
	QST_QuestDetail = nil;
	Orig_QuestAcceptOnClick();
end

function QST_QuestCompleteOnClick()
	local qIndex, qLog;
	local x, y = GetPlayerMapPosition("player");
	local questStart = UnitName("target");
	if(questStart == nil) then questStart = "Unknown"; end
	for index, qQuests in QST_QuestLog do
		if(qQuests.qTitle == GetTitleText() and qQuests.qPlayer[QST_ActivePlayer]) then
			qIndex = index; qLog = qQuests; break;
		end
	end
	if(qIndex) then
		if(QST_Options.SaveHistory) then
			qLog.qIndex = nil;
			qLog.qPlayer[QST_ActivePlayer].qStatus = QST_COMPLETEDCOLOUR..QST_QUEST_DONE;
			qLog.qNPC[2] = {};
			qLog.qNPC[2]["qName"] = questStart;
			qLog.qNPC[2]["qZone"] = GetRealZoneText;
			qLog.qNPC[2]["qX"] = x;
			qLog.qNPC[2]["qY"] = y;
			for index, qQuests in QST_QuestBase do
				if(qLog.qTitle == qQuests.qTitle and qLog.qObj == qQuests.qObj) then
					qBase = qQuests; break;
				end
			end
			if(qBase) then
				qBase.qNote = qBase.qNote.."\n\n"..qLog.qNote;
				qBase.qPlayer[QST_ActivePlayer] = {};
				qBase.qPlayer[QST_ActivePlayer] = qLog.qPlayer[QST_ActivePlayer];
				qBase.qNPC[2] = qLog.qNPC[2];
			else
				if(not QST_Options.SaveDesc) then
					qLog.qDesc = nil;
				end
				if(not QST_Options.SaveRew) then
					qLog.qReward = nil; qLog.qChoice = nil; qLog.qSpell = nil;
				end
				QST_QuestBase[table.getn(QST_QuestBase)+1] = qLog;
			end
		end
		QST_QuestLog[qIndex] = nil;
	end
	Orig_RewardCompleteOnClick();
end

function QST_AbandonQuestOnClick()
	local qIndex, qLog;
	for index, qQuests in QST_QuestLog do
		if(qQuests.qTitle == QST_AbandonQuest and qQuests.qPlayer[QST_ActivePlayer]) then
			qIndex = index; qLog = qQuests; break;
		end
	end
	if(qIndex) then
		if(QST_Options.SaveHistory) then
			qLog.qIndex = nil;
			qLog.qPlayer[QST_ActivePlayer].qStatus = QST_INITIALCOLOUR..QST_QUEST_ABANDON;
			for index, qQuests in QST_QuestBase do
				if(qLog.qTitle == qQuests.qTitle and qLog.qObj == qQuests.qObj) then
					qBase = qQuests; break;
				end
			end
			if(qBase) then
				qBase.qNote = qBase.qNote.."\n\n"..qLog.qNote;
				qBase.qPlayer[QST_ActivePlayer] = {};
				qBase.qPlayer[QST_ActivePlayer] = qLog.qPlayer[QST_ActivePlayer];
			else
				if(not QST_Options.SaveDesc) then
					qLog.qDesc = nil;
				end
				if(not QST_Options.SaveRew) then
					qLog.qReward = nil; qLog.qChoice = nil; qLog.qSpell = nil;
				end
				QST_QuestBase[table.getn(QST_QuestBase)+1] = qLog;
			end
		end
		QST_QuestLog[qIndex] = nil;
	end
	Orig_AbandonQuest();
end

function QST_afTooltip(unit)
	QST_Orig_afTooltip(unit);
	QST_EnhanceTooltip();
end

function QST_ContainerButtonOnEnter()
	QST_Orig_ContainerButtonOnEnter();
	QST_EnhanceTooltip();
end

function QST_SanityButtonOnEnter()
	QST_OrigSanityButtonOnEnter();
	QST_EnhanceTooltip();
end

function QST_EnhanceTooltip()
	if(GameTooltip == nil) then return; end
	if(not QST_ItemList) then return; end
	if(getglobal('GameTooltipTextLeft1'):GetText() ~= nil) then
		local itemName = string.gsub(getglobal('GameTooltipTextLeft1'):GetText(),"|c........(.*)|?r?","%1");
		if(QST_ItemList[itemName] == nil) then return; end
		if(getglobal('GameTooltipTextLeft2'):GetText() ~= ITEM_BIND_QUEST) then
			GameTooltip:AddLine(ITEM_BIND_QUEST, 1, 1, 1, 1);
			GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
		end
		GameTooltip:AddLine(QST_ItemList[itemName].qTitle..": "..QST_ItemList[itemName].qItems, 1, 0, 1, 1);
		length = getglobal(GameTooltip:GetName() .. "TextLeft" .. GameTooltip:NumLines()):GetStringWidth();
		length = length + 22;
		GameTooltip:SetHeight(GameTooltip:GetHeight() + 14);
		if(length > GameTooltip:GetWidth()) then
			GameTooltip:SetWidth(length);
		end
	end
end

function QST_HintTooltip()
	WorldMapTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
	WorldMapTooltip:SetText(QST_TTHINT_H0, 0.2, 0.5, 1, 1);
	WorldMapTooltip:AddLine(QST_TTHINT_H1, 0, 1, 0, 1);
	WorldMapTooltip:AddDoubleLine("Shift-onEnter", QST_TTHINT_T0, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Ctrl-onEnter", QST_TTHINT_T1, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Left-Click", QST_TTHINT_T2, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Right-Click", QST_TTHINT_T3, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Shift-Left", QST_TTHINT_T4, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Shift-Right", QST_TTHINT_T5, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Ctrl-Left", QST_TTHINT_T6, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Ctrl-Right", QST_TTHINT_T7, 1, 1, 1, 1);
	WorldMapTooltip:AddLine(QST_TTHINT_H2, 0, 1, 0, 1);
	WorldMapTooltip:AddDoubleLine("Shift-Left", QST_TTHINT_T8, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("Ctrl-Left", QST_TTHINT_T9, 1, 1, 1, 1);
	WorldMapTooltip:Show();
end

function QST_ToggleOptions(key, value)
	if(value) then
		QST_Options[key] = value;
	else
		QST_Options[key] = not QST_Options[key];
	end
	return QST_Options[key];
end

function QST_CreateButton(id)
	local button;
	if(getglobal("QSTButton"..id)) then
		button = getglobal("QSTButton"..id);
		button.qMap = nil;
		button.qTitle = nil;
		button.qData = nil;
		getglobal("QSTButton"..id.."Text"):SetText("");
		getglobal("QSTButton"..id.."Status"):SetText("");
		getglobal("QSTButton"..id.."Noted"):SetText("");
	else
		button = CreateFrame("Button" ,"QSTButton"..id, QST_ScrollChild, "QST_ButtonTemplate");
		button:SetWidth(QST_ScrollChild:GetWidth());
		button:SetID(id);
		QST_ButtonTotal = QST_ButtonTotal +1;
	end
	return button;
end

function QST_GetLandMark(zoneText)
	for landmarkIndex = 1, GetNumMapLandmarks(), 1 do
		local name = GetMapLandmarkInfo(landmarkIndex);
		if(strlower(name) == strlower(zoneText)) then return true; end
	end
	return false;
end

function QST_GetColourString(Text)
	local i, j, ItemName, NumItems, NumNeeded = string.find(Text, "(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$");
	local colour = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourInitial = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourMid = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	local colourComplete = {a = 1.0, r = 1.0, g = 1.0, b = 1.0};
	colourInitial.r, colourInitial.g, colourInitial.b, colourInitial.a = QST_TextToRGB(QST_INITIALCOLOUR);
	colourMid.r, colourMid.g, colourMid.b, colourMid.a = QST_TextToRGB(QST_MIDDLECOLOUR);
	colourComplete.r, colourComplete.g, colourComplete.b, colourComplete.a = QST_TextToRGB(QST_COMPLETEDCOLOUR);

	local colourDelta1 = {
		a = (colourMid.a - colourInitial.a),
		r = (colourMid.r - colourInitial.r),
		g = (colourMid.g - colourInitial.g),
		b = (colourMid.b - colourInitial.b)
	};
	local colourDelta2 = {
		a = (colourComplete.a - colourMid.a),
		r = (colourComplete.r - colourMid.r),
		g = (colourComplete.g - colourMid.g),
		b = (colourComplete.b - colourMid.b)
	};
	if (NumItems ~= nil) then
		if ((NumItems / NumNeeded) < 0.5) then
			colour.r = colourInitial.r + ((NumItems / (NumNeeded / 2)) * colourDelta1.r);
			colour.g = colourInitial.g + ((NumItems / (NumNeeded / 2)) * colourDelta1.g);
			colour.b = colourInitial.b + ((NumItems / (NumNeeded / 2)) * colourDelta1.b);
		else
			colour.r = colourMid.r + (((NumItems - (NumNeeded / 2)) / (NumNeeded / 2)) * colourDelta2.r);
			colour.g = colourMid.g + (((NumItems - (NumNeeded / 2)) / (NumNeeded / 2)) * colourDelta2.g);
			colour.b = colourMid.b + (((NumItems - (NumNeeded / 2)) / (NumNeeded / 2)) * colourDelta2.b);
		end
	else
		i, j, ItemName, NumItems, NumNeeded = string.find(Text, "(.*):%s*([-%a]+)%s*/%s*([-%a]+)%s*$");
		if (Items ~= nil) then
			if (NumItems == NumNeeded) then
				return QST_COMPLETEDCOLOUR;
			else
				return QST_INITIALCOLOUR;
			end
		else
			return QST_SPECIALCOLOUR;
		end
	end

	if(colour.r > 1.0) then colour.r = 1.0; end
	if(colour.g > 1.0) then colour.g = 1.0; end
	if(colour.b > 1.0) then colour.b = 1.0; end
	if(colour.r < 0.0) then colour.r = 0.0; end
	if(colour.g < 0.0) then colour.g = 0.0; end
	if(colour.b < 0.0) then colour.b = 0.0; end

	return QST_RGBtoText(colour.r, colour.g, colour.b, colour.a);
end

function QST_TextToRGB(strColour)
	local i = 3;
	local iAlpha = tonumber(string.sub(strColour, i, i + 1), 16);
	local iRed = tonumber(string.sub(strColour, i + 2, i + 3), 16);
	local iGreen = tonumber(string.sub(strColour, i + 4, i + 5), 16);
	local iBlue = tonumber(string.sub(strColour, i + 6, i + 7), 16);
	iAlpha = iAlpha / 255;
	iRed = iRed / 255;
	iGreen = iGreen / 255;
	iBlue = iBlue / 255;
	return iRed, iGreen, iBlue, iAlpha;
end

function QST_RGBtoText(iRed, iGreen, iBlue, iAlpha)
	local strColour;
	iAlpha = floor(iAlpha * 255);
	iRed = floor(iRed * 255);
	iGreen = floor(iGreen * 255);
	iBlue = floor(iBlue * 255);
	strColour = format("|c%2x%2x%2x%2x", iAlpha, iRed, iGreen, iBlue);
	return strColour;
end

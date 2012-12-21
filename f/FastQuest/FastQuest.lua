--	FastQuest 2.11 By Vashen ( Vashen@msn.com )
--	http://www.curse-gaming.com/mod.php?addid=812

hQuestLog_Update = QuestLog_Update;
hQuestWatch_Update = QuestWatch_Update;

local player = "DEFAULT";
local Formats = {};
	Formats[0]="QuestName";
	Formats[1]="[QuestLevel] QuestName";
	Formats[2]="[QuestLevel+] QuestName";
	Formats[3]="[QuestLevel] QuestName (Tag)";
local nFormats = 4;


function FastQuest_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UI_INFO_MESSAGE");
	this:RegisterEvent("QUEST_PROGRESS");
	this:RegisterEvent("QUEST_COMPLETE");
	SLASH_FQ1 = "/fastquest";
	SLASH_FQ2 = "/fq";
	SlashCmdList["FQ"] = FastQuest_SlashCmd; 
	qOut("|cff00ffffFastQuest 2.11 By Vashen is now loaded. |cffffffff/fq");
end
	
function FastQuest_SlashCmd(msg)
	if (msg) then
		local cmd = gsub(msg, "%s*([^%s]+).*", "%1");
		local info ="|cff00ffffFastQuest: |r|cffffffff";
		if( cmd == "tag" ) then
			info = (info.."Display of quest-tags has been ");
			FQD[player].Tag=FastQuest_ToggleBoolean(FQD[player].Tag,info);
			QuestLog_Update();
			QuestWatch_Update();
			return;
		elseif( cmd == "autoadd" ) then
			info = (info.."Automatic addition of changed quests to QuestTracker has been ");
			FQD.AutoAdd=FastQuest_ToggleBoolean(FQD.AutoAdd,info);
			return;
		elseif( cmd == "autonotify" ) then
			info = (info.."Automatic notification of party members regarding your quest progress has been ");
			FQD.AutoNotify=FastQuest_ToggleBoolean(FQD.AutoNotify,info);
			return;
		elseif( cmd == "autocomplete" ) then
			info = (info.."Automatic quest completion has been ");
			FQD.AutoComplete=FastQuest_ToggleBoolean(FQD.AutoComplete,info);
			return;
		elseif( cmd == "lock" and FQD.NoDrag==false)then
			qOut(info.." Movable components have been Locked");
			FQD.Lock = true;
			FastQuest_LockMovableParts();
			return;
 		elseif( cmd == "unlock" and FQD.NoDrag==false)then
			qOut(info.." Movable components have been Unlocked");
			FQD.Lock = false;
			FastQuest_LockMovableParts();
 			return;
		elseif( cmd == "nodrag") then
			info = (info.." Dragging is now ");
			FQD.NoDrag=FastQuest_ToggleBoolean(FQD.NoDrag,info);
			if (FQD.NoDrag == false ) then FQD.Lock = true;end
			qOut("You must reload UI for this change to apply. Type /console reloadui");
			return;
		elseif( cmd == "reset" and FQD.NoDrag==false)then
			qOut(info.." Movable components have been Reset");
			FastQuestFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", -20, -15);
			dQuestWatchDragButton:SetPoint("TOPLEFT", "UIParent", "TOPRIGHT", -250, -250);
			return;
		elseif( cmd == "format" )then
			if (FQD[player].Format==nil) then FQD[player].Format=1;end
			if (FQD[player].Format==(nFormats-1)) then
				FQD[player].Format=0;
			else
				FQD[player].Format=FQD[player].Format+1;
			end
			qOut(info.."Toggle beetween output formats ");
			qOut("Selected format: "..Formats[FQD[player].Format]);
			return;
		elseif( cmd == "clear" ) then
			qOut(info.."All quest tracker quests have been removed ");
			for i = GetNumQuestWatches(), 1 , -1 do
				local qID = GetQuestIndexForWatch(i)
				FQD[player].tQuests[i] = " ";
				RemoveQuestWatch(qID);
			end
			FQD[player].nQuests = 0;
			QuestWatch_Update();
			return;
		end
	qOut(info.."usage /fastquest [command] or /fq [command]");
	qOut("|cffffffff/fq tag  - Toggle display of quest tags (elite, raid,etc) ");
	qOut("|cffffffff/fq lock(unlock) - Locks/Unlocks quest tracker window");
	qOut("|cffffffff/fq nodrag  - Toggle dragging of quest tracker, you must reload UI to apply");
	qOut("|cffffffff/fq reset  - Resets FastQuest moving components, draging must be enabled");
	qOut("|cffffffff/fq autoadd  - Toggle automatic addition of changed quests to QuestTracker");
	qOut("|cffffffff/fq autonotify  - Toggle automatic notification of party members");
	qOut("|cffffffff/fq autocomplete  - Toggle automatic completion of quests when turning them in");
	qOut("|cffffffff/fq clear  - Clear QuestTracker window from all quests");
	qOut(info.."New version: http://www.curse-gaming.com/mod.php?addid=812");
	end
end

function FastQuest_OnEvent(event, message)
	if	((event == "QUEST_PROGRESS") and (FQD.AutoComplete==true)) then
			CompleteQuest();	
	elseif	((event == "QUEST_COMPLETE") and (FQD.AutoComplete==true)) then
		if (GetNumQuestChoices() == 0) then
			GetQuestReward(QuestFrameRewardPanel.itemChoice);
		end
	elseif(event == "VARIABLES_LOADED") then
		if (FQD == nil) then FQD = {};end
		if (FQD.Lock == nil) then FQD.Lock=true; end
		if (FQD.NoDrag == nil) then FQD.NoDrag = false; end;
		if (FQD.AutoNotify == nil) then FQD.AutoAdd  = true; end
		if (FQD.AutoComplete == nil) then FQD.AutoNotify  = true; end;
		FQD.AutoNotify  = false;
		UpdatePlayer();
		FastQuest_LinkFrame(dQuestWatchDragButton:GetName(), QuestWatchFrame:GetName(), "RIGHT");
		FastQuest_LockMovableParts();
	elseif (event == "UI_INFO_MESSAGE" and message) then
		local uQuestText = gsub(message,"(.*):%s*([-%d]+)%s*/%s*([-%d]+)%s*$","%1",1);
		if ( uQuestText ~= message) then
			if (FQD.AutoNotify == true) then 
				FastQuest_CheckDefaultChat(false);
				SendChatMessage("FastQuest progress: "..message, DEFAULT_CHAT_FRAME.editBox.chatType);
			end
			if (FQD.AutoAdd==true and GetNumQuestWatches()<MAX_WATCHABLE_QUESTS) then
				local qID = FastQuest_GetQuestID(uQuestText);
				if (qID) then
					if (not IsQuestWatched(qID)) then 
						FastQuest_Watch(qID,true); 
					end
				end
			end
		end
	end
end

function QuestLogTitleButton_OnClick(button)
	local qIndex = this:GetID() + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);
	local qTitle, qLevel, qTag, isHeader, isCollapsed = GetQuestLogTitle(qIndex);
	if ( button == "LeftButton" ) then
		QuestLog_SetSelection(qIndex);
		if ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
			if (FQD[player].Format==1) then
				ChatFrameEditBox:Insert("["..qLevel.."] "..qTitle.." ");
			elseif (FQD[player].Format==0) then
				ChatFrameEditBox:Insert(" "..qTitle.." ");
			elseif (FQD[player].Format==2) then
				if (qTag) then qTag = "+" else qTag="";end
				ChatFrameEditBox:Insert("["..qLevel..qTag.."] "..qTitle.." ");
			elseif (FQD[player].Format==3) then
				if (qTag) then qTag = (" ("..qTag..")  ") else qTag="";end
				ChatFrameEditBox:Insert("["..qLevel.."] "..qTitle..qTag);
			else	FQD[player].Format=1;	end
		elseif ( IsShiftKeyDown() ) then
			FastQuest_Watch(qIndex,false);
		elseif (IsControlKeyDown()) then
			FastQuest_CheckDefaultChat(true);
			if (FQD[player].Format==1) then
				SendChatMessage("["..qLevel.."] "..qTitle, DEFAULT_CHAT_FRAME.editBox.chatType, GetDefaultLanguage());
			elseif (FQD[player].Format==0) then
				SendChatMessage(" "..qTitle.." ", DEFAULT_CHAT_FRAME.editBox.chatType, GetDefaultLanguage());
			elseif (FQD[player].Format==2) then
				if (qTag) then qTag = "+" else qTag="";end
				SendChatMessage("["..qLevel..qTag.."] "..qTitle, DEFAULT_CHAT_FRAME.editBox.chatType, GetDefaultLanguage());
			elseif (FQD[player].Format==3) then
				if (qTag) then qTag = (" ("..qTag..")  ") else qTag="";end
					SendChatMessage("["..qLevel.."] "..qTitle..qTag, DEFAULT_CHAT_FRAME.editBox.chatType, GetDefaultLanguage());
			else	FQD[player].Format=1;	end
			local nObjectives = GetNumQuestLeaderBoards(qIndex);
			if ( nObjectives > 0 ) then
				for i=1, nObjectives do
					oText, oType, oDone = GetQuestLogLeaderBoard(i, qIndex);
					if ( not oText or strlen(oText) == 0 or oText == "" ) then oText = oType;end
					if ( oDone ) then
						SendChatMessage("  X "..oText, DEFAULT_CHAT_FRAME.editBox.chatType);
					else
						SendChatMessage("  -  "..oText, DEFAULT_CHAT_FRAME.editBox.chatType);
					end
				end
			end
		end
		QuestLog_Update();
	elseif ( button == "RightButton" ) then
		if ( ChatFrameEditBox:IsVisible() ) then
			QuestLog_SetSelection(qIndex);
			local qDescription, qObjectives = GetQuestLogQuestText();
			if (qObjectives) then ChatFrameEditBox:Insert(qObjectives);end
			return;
		end
		FastQuest_Watch(qIndex,false);		
	end
end

function QuestLog_Update()
	if (player == "DEFAULT" or FQD[player].tQuests == nil) then UpdatePlayer();end;
	FastQuest_LockMovableParts();
	local nEntries, nQuests = GetNumQuestLogEntries();
	if (GetNumQuestWatches() < 1 and FQD[player].nQuests > 0) then
		for i=1, nEntries do
			SelectQuestLogEntry(i);
 			local qTitle, qLevel, qTag, isHeader, isCollapsed = GetQuestLogTitle(i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame));
			for j = 1, FQD[player].nQuests do
				if (qTitle == FQD[player].tQuests[j] and not IsQuestWatched(i)) then
					AddQuestWatch(i); 
				end
			end
		end
	end
	hQuestLog_Update();
	for i=1, QUESTS_DISPLAYED, 1 do
      	  	if ( i <= nEntries ) then
            		local qTitle, qLevel, qTag, isHeader, isCollapsed = GetQuestLogTitle(i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame));
			local qLogTitle = getglobal("QuestLogTitle"..i);
			local qCheck = getglobal("QuestLogTitle"..i.."Check");
			qCheck:SetPoint("LEFT", qLogTitle:GetName(), "LEFT", 3, 0);
			FastQuest_ChangeTitle(qLogTitle, qTitle, qLevel, qTag, isHeader, false);
	  	end
	  end

end

function QuestWatch_Update()
	hQuestWatch_Update();
	local qDone; wID=1; oID=1; DoneID = -1;
	FQD[player].nQuests = GetNumQuestWatches();
	for i = 1, GetNumQuestWatches() do
		FQD[player].tQuests[i] = " ";
		local qID = GetQuestIndexForWatch(i);
		if (qID) then
			local qTitle, qLevel, qTag, isHeader, isCollapsed = GetQuestLogTitle(qID);
			FQD[player].tQuests[i]= qTitle;
			qLogTitle = getglobal( "QuestWatchLine" ..wID);
			FastQuest_ChangeTitle(qLogTitle, qTitle, qLevel, qTag, isHeader, true);
			qDone = true; oID = 1;
			for j = 1, GetNumQuestLeaderBoards(qID) do
				oID = j;
				qLogTitle = getglobal( "QuestWatchLine" ..(wID+j));
				local oTitle, oType, oDone = GetQuestLogLeaderBoard(j,qID);
				if (oDone) then
					qLogTitle:SetText("|cFFC0FFCF   X "..oTitle.." ");
				else
					qLogTitle:SetText("|cFFFFFFFF   -  "..oTitle.." ");
					qDone = false;
				end					
			end
			wID= wID+oID+1;
			if (qDone) then DoneID = qID;end							
		end
	end
	if (DoneID>0) then
		PlaySoundFile("sound/interface/igplayerBind.wav");
		UIErrorsFrame:AddMessage("|cff00ffff"..GetQuestLogTitle(DoneID).." (COMPLETE)", 1.0, 1.0, 1.0, 1.0, 2);
		if (FQD.AutoNotify==true) then 
			FastQuest_CheckDefaultChat(false);
			SendChatMessage("FastQuest : "..GetQuestLogTitle(DoneID).." is now complete!",  DEFAULT_CHAT_FRAME.editBox.chatType)
		end
		RemoveQuestWatch(DoneID);
		QuestWatch_Update();
	end
	FQD[player].nQuests = GetNumQuestWatches();
	FastQuest_LockMovableParts();
end


function FastQuest_ChangeTitle(qLogTitle, qTitle, qLevel, qTag, isHeader, Watch)
	local ColorTag="";
	local DifTag="";
	if (qTitle and not isHeader) then
		if (qTag and FQD[player].Tag==true) then DifTag = (" ("..qTag..")  ");end
		if (Watch) then
			local cQuestLevel = GetDifficultyColor(qLevel);
			ColorTag = string.format("|cff%02x%02x%02x", cQuestLevel.r * 255, cQuestLevel.g * 255, cQuestLevel.b * 255);
			qLogTitle:SetText(ColorTag.." ["..qLevel.."] "..qTitle..DifTag);
		else
			qLogTitle:SetText(" ["..qLevel.."] "..qTitle.."  ");
		end
	end
end

function FastQuest_LinkFrame(dButton, pFrame)
	if (FQD.NoDrag == false) then
		getglobal(pFrame):ClearAllPoints();
		getglobal(pFrame):SetPoint("TOPLEFT", dButton, "TOPRIGHT");
	else
		qOut("Fast Quest: Draging is disabled, use /fq nodrag to toggle you must also reload UI for changes to take affect");
		FQD.Lock = true;
	end
end

function FastQuest_DragFrame(pFrame, mode)
	if (FQD.NoDrag == false) then
		if (mode == 0) then
			pFrame:StartMoving();
		else
			pFrame:StopMovingOrSizing();
		end
	end
end

function qOut (msg)
	if( DEFAULT_CHAT_FRAME and msg) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function FastQuest_LockMovableParts()
	if (FQD[player].nQuests > 0 and QuestWatchFrame:IsVisible() and FQD.Lock==false and FQD.NoDrag==false) then
		dQuestWatchDragButton:Show();
	else
		dQuestWatchDragButton:Hide();
	end;
end

function UpdatePlayer()
	player = UnitName("player");
	if (player == nil or player == UNKNOWNBEING or player == UKNOWNBEING or player == UNKNOWNOBJECT) then
		player = "DEFAULT";end
	if ( FQD[player] == nil or FQD[player].tQuests == nil ) then 
		FQD[player] =	{
				  ["Format"]	= 1;
				  ["Tag"]	= false;
				  ["nQuests"]	= 0;
				  ["tQuests"]	= { };
				}
		for i=1, MAX_WATCHABLE_QUESTS, 1 do
			FQD[player].tQuests[i]=" ";
		end;
	end
end

function GetDifficultyColor(level)
	local lDiff = level - UnitLevel("player");
	if (lDiff >= 0) then
		for i= 1.00, 0.10, -0.10 do
			color = {r = 1.00, g = i, b = 0.00};
			if ((i/0.10)==(10-lDiff)) then return color; end
		end
	elseif ( -lDiff < GetQuestGreenRange() ) then
		for i= 0.90, 0.10, -0.10 do
			color = {r = i, g = 1.00, b = 0.00};
			if ((9-i/0.10)==(-1*lDiff)) then return color; end
		end
	elseif ( -lDiff == GetQuestGreenRange() ) then
		color = {r = 0.50, g = 1.00, b = 0.50};
	else
		color = {r = 0.75, g = 0.75, b = 0.75};
	end
	return color;
end

function FastQuest_Watch(qID, auto)
	if (qID) then
		if ((IsQuestWatched(qID)) and (auto == false)) then
			RemoveQuestWatch(qID);
			QuestWatch_Update();
			QuestLog_Update();
		else
			if ((GetNumQuestLeaderBoards(qID) == 0) and (auto == false)) then
				UIErrorsFrame:AddMessage(QUEST_WATCH_NO_OBJECTIVES, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
				return;
			end
			if (GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS ) then
				UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY, MAX_WATCHABLE_QUESTS), 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
				return;
			end
			AddQuestWatch(qID);
			QuestWatch_Update();
 			QuestLog_Update();
		end
	end
end

function FastQuest_GetQuestID(str)
	local qSelected= GetQuestLogSelection();
	for i=1, GetNumQuestLogEntries(), 1 do
		SelectQuestLogEntry(i);
		local qTitle, qLevel, qTag, isHeader, isCollapsed, qComplete = GetQuestLogTitle(i);
		if (qTitle == str ) then return i; end
		if(not isHeader) then
			for j = 1, GetNumQuestLeaderBoards() do
				local oText, oType, oDone = GetQuestLogLeaderBoard(j);
				if ((oText==nil) or (oText=="")) then
					oText = oType;
				end
				if (string.find(gsub(oText,"(.*): %d+/%d+","%1",1),gsub(str,"(.*): %d+/%d+","%1",1))) then
					SelectQuestLogEntry(qSelected);
					return i;
				end
			end
			local qDescription, qObjectives = GetQuestLogQuestText();
			if(string.find(qObjectives, str)) then
				SelectQuestLogEntry(qSelected);
				return i;
			end
		end
	end
	SelectQuestLogEntry(qSelected);
	return nil;
end

function FastQuest_CheckDefaultChat(allowGuild)
	if	((DEFAULT_CHAT_FRAME.editBox.stickyType == "GUILD") and (allowGuild == false)) then
			DEFAULT_CHAT_FRAME.editBox.chatType = "PARTY";
	elseif	((DEFAULT_CHAT_FRAME.editBox.stickyType == "PARTY") and (GetNumPartyMembers() == 0)) then
			DEFAULT_CHAT_FRAME.editBox.chatType = "SAY";
	elseif	((DEFAULT_CHAT_FRAME.editBox.stickyType == "RAID") and (GetNumRaidMembers() == 0)) then
			DEFAULT_CHAT_FRAME.editBox.chatType = "SAY";
	end
end

function FastQuest_ToggleBoolean ( bool, msg )
	if( bool == false ) then
		qOut(msg.."Enabled");
		bool = true;
	else
		qOut(msg.."Disabled");
		bool = false;
	end
	return bool;
end

